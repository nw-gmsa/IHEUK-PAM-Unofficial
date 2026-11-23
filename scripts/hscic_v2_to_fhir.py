#!/usr/bin/env python3
"""Generate FHIR Message (Bundle) FSH examples from the HSCIC ITK ADT examples.

Each ADT example is first converted to HL7 v2.5.1 (with the test identifier substitutions) by
convert_hscic_examples.py, then mapped to the PAM FHIR profiles following v2-fhir-mapping.md.
Queries (QBP/RSP/QCN) are PDQ and are not converted.

Usage: python3 -I scripts/hscic_v2_to_fhir.py "Specifications/HSCIC/HL7 v2 ADT Examples" input/fsh/Examples/HSCIC/HSCICMessages.fsh
"""
import datetime
import importlib.util
import pathlib
import re
import sys
from zoneinfo import ZoneInfo

_spec = importlib.util.spec_from_file_location("conv", pathlib.Path(__file__).with_name("convert_hscic_examples.py"))
conv = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(conv)

LONDON = ZoneInfo("Europe/London")
BASE = "https://fhir.ihe-uk.org/ITI/PAM/"
# Local identifiers (MRN, visit number, ward, staff ID) have only a local HD-1 namespace in the HSCIC examples and no
# known OID, so no identifier system is invented: they are qualified by type and assigner (ODS code) instead.
ENDPOINT = "http://example.org/hl7v2/"
ICD10 = "http://hl7.org/fhir/sid/icd-10"

ODS_NAMES = {"RCB": "YORK AND SCARBOROUGH TEACHING HOSPITALS NHS FOUNDATION TRUST"}

# Encounter.status after the trigger event (see ITI-31.md)
STATUS = {
    "A01": "in-progress", "A02": "in-progress", "A03": "finished", "A04": "arrived", "A05": "planned",
    "A08": "in-progress", "A11": "cancelled", "A12": "in-progress", "A13": "in-progress", "A14": "planned",
    "A15": "in-progress", "A16": "in-progress", "A21": "onleave", "A22": "in-progress", "A25": "in-progress",
    "A26": "in-progress", "A27": "cancelled", "A38": "cancelled", "A52": "in-progress", "A53": "onleave",
}
CLASS = {"I": "IMP", "O": "AMB", "E": "EMER", "P": "PRENC", "R": "AMB", "B": "IMP"}
GENDER = {"F": "female", "M": "male", "U": "unknown", "A": "other", "O": "other", "N": "unknown"}
ITI30 = {"A28", "A31", "A40"}

# All the HSCIC ADT examples are about one patient and the same next of kin, so they share one Patient and one
# RelatedPerson per next of kin (standalone examples) instead of a copy in every message.
SHARED_PATIENT = "Patient-EDITESTPATIENT-TEN-9999999557"


def related_person_name(nk1):
    xpn = conv.get(nk1, 2)
    return f"RelatedPerson-{comp(xpn, 1)}-{comp(xpn, 2)}".replace(" ", "-")


def q(v):
    return '"' + v.replace("\\", "\\\\").replace('"', '\\"') + '"'


def ts(v, instant=False):
    """HL7 v2 TS/DTM -> FHIR date or dateTime (Europe/London offset). None if absent or invalid."""
    m = re.fullmatch(r"(\d{4})(\d{2})?(\d{2})?(\d{2})?(\d{2})?(\d{2})?([+-]\d{4})?", v.split("^")[0] if v else "")
    if not m:
        return None
    y, mo, d, hh, mi, ss, tz = m.groups()
    try:
        if not hh:
            if instant:
                return None
            datetime.date(int(y), int(mo or 1), int(d or 1))
            return "-".join(x for x in (y, mo, d) if x)
        dt = datetime.datetime(int(y), int(mo), int(d), int(hh), int(mi or 0), int(ss or 0))
    except ValueError:
        return None
    if tz:
        sign = 1 if tz[0] == "+" else -1
        dt = dt.replace(tzinfo=datetime.timezone(sign * datetime.timedelta(hours=int(tz[1:3]), minutes=int(tz[3:5]))))
    else:
        dt = dt.replace(tzinfo=LONDON)
    return dt.isoformat()


def comp(v, n):
    c = v.split("^")
    return c[n - 1] if len(c) >= n else ""


def segs_of(segs, sid):
    return [conv.fields(s) for s in segs if s.startswith(sid + "|")]


def practitioner_ref(xcn):
    """XCN -> logical Reference rules (relative to the element path)."""
    idn, family, given, prefix = comp(xcn, 1), comp(xcn, 2), comp(xcn, 3), comp(xcn, 6) or comp(xcn, 5)
    rules = []
    system = "$gmc-number" if idn.startswith("C") else "$gmp-number" if re.fullmatch(r"G\d{7}", idn) else None
    if idn and system:
        rules += [f".identifier.system = {system}", f".identifier.value = {q(idn)}"]
    name = " ".join(x for x in (prefix, given, family) if x)
    if name:
        rules.append(f".display = {q(name)}")
    return rules


class Out:
    def __init__(self):
        self.lines = []

    def instance(self, name, profile, title, usage="#inline", description=None):
        self.lines += ["", f"Instance:    {name}", f"InstanceOf:  {profile}", f"Title:       {q(title)}"]
        if description:
            self.lines.append(f"Description: {q(description)}")
        self.lines.append(f"Usage:       {usage}")

    def r(self, rule):
        self.lines.append("* " + rule)


def patient(o, name, f, pd1, title, usage="#inline", description=None):
    o.instance(name, "PAMPatient", title, usage=usage, description=description)
    for rep in conv.get(f, 3).split("~"):
        if not rep:
            continue
        idn, aa, typ = comp(rep, 1), comp(rep, 4), comp(rep, 5)
        if typ == "NH":
            o.r(f"identifier[nhsNumber].system = $nhs-number")
            o.r(f"identifier[nhsNumber].value = {q(idn)}")
        else:
            o.r(f"identifier[localPatientIdentifier][+].value = {q(idn)}")
            o.r("identifier[localPatientIdentifier][=].assigner.identifier.system = $ods-code")
            o.r("identifier[localPatientIdentifier][=].assigner.identifier.value = \"RCB\"")
    for rep in conv.get(f, 5).split("~"):
        family, given, middle, prefix, ntype = comp(rep, 1), comp(rep, 2), comp(rep, 3), comp(rep, 5), comp(rep, 7)
        o.r("name[+].use = " + {"L": "#official", "A": "#nickname", "N": "#usual", "B": "#old", "M": "#maiden"}.get(ntype, "#official"))
        o.r(f"name[=].family = {q(family)}")
        for g in (given, middle):
            if g:
                o.r(f"name[=].given[+] = {q(g)}")
        if prefix:
            o.r(f"name[=].prefix[+] = {q(prefix)}")
    if comp(conv.get(f, 6), 1):
        o.r('extension[+].url = "http://hl7.org/fhir/StructureDefinition/patient-mothersMaidenName"')
        o.r(f"extension[=].valueString = {q(comp(conv.get(f, 6), 1))}")
    dob = conv.get(f, 7)
    birth_date = ts(dob[:8])
    if birth_date:
        o.r(f'birthDate = "{birth_date}"')
        if len(dob) > 8 and ts(dob):
            o.r('birthDate.extension[+].url = "http://hl7.org/fhir/StructureDefinition/patient-birthTime"')
            o.r(f'birthDate.extension[=].valueDateTime = "{ts(dob)}"')
    if conv.get(f, 8) in GENDER:
        o.r(f"gender = #{GENDER[conv.get(f, 8)]}")
    address(o, "address", conv.get(f, 11))
    phone = comp(conv.get(f, 13), 1)
    if phone:
        o.r("telecom[+].system = #phone")
        o.r(f"telecom[=].value = {q(phone)}")
        o.r("telecom[=].use = #home")
    if comp(conv.get(f, 15), 1):
        o.r(f"communication[+].language = urn:ietf:bcp:47#{comp(conv.get(f, 15), 1)}")
    if comp(conv.get(f, 16), 1) in ("S", "M", "D", "W", "P", "N", "8", "9"):
        o.r(f"maritalStatus = $UKCore-PersonMaritalStatusEngland#{comp(conv.get(f, 16), 1)}")
    if comp(conv.get(f, 22), 1):
        o.r("extension[+].url = $UKCore-EthnicCategory")
        o.r(f"extension[=].valueCodeableConcept = $UKCore-EthnicCategoryEngland#{comp(conv.get(f, 22), 1)}")
    if conv.get(f, 23):
        o.r('extension[+].url = "http://hl7.org/fhir/StructureDefinition/patient-birthPlace"')
        o.r(f"extension[=].valueAddress.city = {q(conv.get(f, 23))}")
    if conv.get(f, 24) in ("Y", "N"):
        o.r(f"multipleBirthBoolean = {'true' if conv.get(f, 24) == 'Y' else 'false'}")
    for n, url in ((26, "patient-citizenship"), (28, "patient-nationality")):
        if comp(conv.get(f, n), 1):
            o.r(f'extension[+].url = "http://hl7.org/fhir/StructureDefinition/{url}"')
            o.r('extension[=].extension[+].url = "code"')
            o.r(f"extension[=].extension[=].valueCodeableConcept = urn:iso:std:iso:3166#{comp(conv.get(f, n), 1)}")
    if pd1:
        practice, gp = conv.get(pd1, 3).split("~")[0], conv.get(pd1, 4)
        code = comp(practice, 10) or comp(practice, 3)
        if code:
            o.r("generalPractitioner[+].identifier.system = $ods-code")
            o.r(f"generalPractitioner[=].identifier.value = {q(code)}")
            if comp(practice, 1):
                o.r(f"generalPractitioner[=].display = {q(comp(practice, 1))}")
        rules = practitioner_ref(gp) if gp else []
        for i, rule in enumerate(rules):
            o.r(("generalPractitioner[+]" if i == 0 else "generalPractitioner[=]") + rule)


def address(o, path, xad):
    if not xad:
        return
    o.r(f"{path}[+].line[+] = {q(comp(xad, 1))}")
    if comp(xad, 2):
        o.r(f"{path}[=].line[+] = {q(comp(xad, 2))}")
    for n, el in ((3, "city"), (4, "district"), (5, "postalCode"), (6, "country")):
        if comp(xad, n):
            o.r(f"{path}[=].{el} = {q(comp(xad, n))}")
    if comp(xad, 7) == "H":
        o.r(f"{path}[=].use = #home")


def related_person(o, name, nk1):
    pat = SHARED_PATIENT
    xpn = conv.get(nk1, 2)
    o.instance(name, "PAMRelatedPerson", f"Related Person (NK1) - {comp(xpn, 2)} {comp(xpn, 1)}", usage="#example",
               description="Next of kin (NK1) of the HSCIC ITK example patient, shared by the HSCIC FHIR Message examples")
    o.r(f"patient = Reference({pat})")
    if comp(conv.get(nk1, 3), 1):
        o.r(f"relationship[+] = HSCICRelationship#{comp(conv.get(nk1, 3), 1)}")
    o.r(f"name[+].family = {q(comp(xpn, 1))}")
    if comp(xpn, 2):
        o.r(f"name[=].given[+] = {q(comp(xpn, 2))}")
    if comp(xpn, 5):
        o.r(f"name[=].prefix[+] = {q(comp(xpn, 5))}")
    address(o, "address", conv.get(nk1, 4))
    if comp(conv.get(nk1, 5), 1):
        o.r("telecom[+].system = #phone")
        o.r(f"telecom[=].value = {q(comp(conv.get(nk1, 5), 1))}")
    if conv.get(nk1, 15) in GENDER:
        o.r(f"gender = #{GENDER[conv.get(nk1, 15)]}")
    if ts(conv.get(nk1, 16)[:8]):
        o.r(f'birthDate = "{ts(conv.get(nk1, 16)[:8])}"')
    if comp(conv.get(nk1, 20), 1):
        o.r(f"communication[+].language = urn:ietf:bcp:47#{comp(conv.get(nk1, 20), 1)}")


def message(o, folder, path, shared):
    segs = conv.segments(conv.pseudonymise(conv.read_text(path)))
    ev, mtype = conv.event_of(segs)
    if not mtype.startswith("ADT"):
        return None
    v251, _, _ = conv.convert(segs, ev)
    bid = conv.bundle_id(folder, ev)
    msh = conv.fields(v251[0])
    evn = (segs_of(v251, "EVN") or [None])[0]
    pid = segs_of(v251, "PID")[0]
    pd1 = (segs_of(v251, "PD1") or [None])[0]
    pv1 = (segs_of(v251, "PV1") or [None])[0]
    pv2 = (segs_of(v251, "PV2") or [None])[0]
    zu1 = (segs_of(v251, "ZU1") or [None])[0]
    mrg = (segs_of(v251, "MRG") or [None])[0]
    has_encounter = ev not in ITI30 and pv1 is not None
    pat, enc = SHARED_PATIENT, f"{bid}-encounter"
    shared["pid"].append((pid, pd1))
    focus = enc if has_encounter else pat
    entries = []

    # MSH
    o.instance(f"{bid}-header", "PAMMessageHeader", f"Message Header - {mtype}")
    o.r(f"eventCoding = $v2-0003#{ev}")
    app, fac, rapp, rfac = (comp(conv.get(msh, n), 1) for n in (3, 4, 5, 6))
    o.r(f"source.name = {q(app)}")
    o.r(f'source.endpoint = "{ENDPOINT}{app}"')
    o.r(f"sender.identifier.system = $ods-code")
    o.r(f"sender.identifier.value = {q(fac)}")
    if fac in ODS_NAMES:
        o.r(f"sender.display = {q(ODS_NAMES[fac])}")
    o.r(f"destination[+].name = {q(rapp)}")
    o.r(f'destination[=].endpoint = "{ENDPOINT}{rapp}"')
    if rfac and rfac != "ROUTE":
        o.r("destination[=].receiver.identifier.system = $ods-code")
        o.r(f"destination[=].receiver.identifier.value = {q(rfac)}")
    o.r(f"focus[+] = Reference({focus})")
    entries.append(("MessageHeader", f"{bid}-header"))

    # EVN
    if evn:
        o.instance(f"{bid}-event", "PAMProvenance", f"Event - {ev}")
        o.r(f"target[+] = Reference({focus})")
        occurred = ts(conv.get(evn, 6)) or ts(conv.get(evn, 2))
        o.r(f'occurredDateTime = "{occurred}"')
        o.r(f'recorded = "{ts(conv.get(evn, 2), instant=True) or occurred}"')
        o.r(f"activity = $v2-0003#{ev}")
        op = conv.get(evn, 5)
        o.r(f"agent[+].who.identifier.value = {q(comp(op, 1))}")
        o.r(f"agent[=].who.display = {q(' '.join(x for x in (comp(op, 3), comp(op, 2)) if x))}")
        entries.append(("Provenance", f"{bid}-event"))

    # PID, PD1: the shared Patient. For MRG (A40) only the non-surviving record carries the link (replaced-by),
    # so the shared Patient has no link that points outside the other messages.
    entries.append(("Patient", pat))
    if mrg:
        o.instance(f"{bid}-prior-patient", "PAMPatient", f"Patient - non-surviving record (MRG) - {ev}")
        o.r("active = false")
        for rep in conv.get(mrg, 1).split("~"):
            o.r(f"identifier[localPatientIdentifier][+].value = {q(comp(rep, 1))}")
            o.r("identifier[localPatientIdentifier][=].assigner.identifier.system = $ods-code")
            o.r('identifier[localPatientIdentifier][=].assigner.identifier.value = "RCB"')
        o.r('name[+].use = #official')
        o.r('name[=].family = "Unknown"')
        o.r(f"link[+].other = Reference({pat})")
        o.r("link[=].type = #replaced-by")
        entries.append(("Patient", f"{bid}-prior-patient"))

    # PV1, PV2, ZU1
    if has_encounter:
        o.instance(enc, "PAMEncounter", f"Encounter - {ev}")
        visit = conv.get(pv1, 19)
        if comp(visit, 1):
            o.r(f"identifier[visitNumber].value = {q(comp(visit, 1))}")
            o.r("identifier[visitNumber].assigner.identifier.system = $ods-code")
            o.r(f"identifier[visitNumber].assigner.identifier.value = {q(fac)}")
        o.r(f"status = #{STATUS.get(ev, 'in-progress')}")
        o.r(f"class = $v3-ActCode#{CLASS.get(conv.get(pv1, 2), 'AMB')}")
        o.r(f"subject = Reference({pat})")
        if conv.get(pv1, 4) in ("11", "12", "13", "21", "22", "23", "24", "28", "31", "32", "81", "82", "83", "98", "99"):
            o.r("hospitalization.extension[+].url = $UKCore-AdmissionMethod")
            o.r(f"hospitalization.extension[=].valueCodeableConcept = $UKCore-AdmissionMethodEngland#{conv.get(pv1, 4)}")
        if conv.get(pv1, 14) in ("19", "29", "39", "49", "51", "52", "53", "54", "65", "66", "79", "85", "87", "88", "98", "99"):
            o.r(f"hospitalization.admitSource = $UKCore-SourceOfAdmissionEngland#{conv.get(pv1, 14)}")
        dest = comp(conv.get(pv1, 37), 1)
        if re.fullmatch(r"\d\d", dest):
            o.r(f"hospitalization.dischargeDisposition = $UKCore-DischargeDestinationEngland#{dest}")
        if conv.get(pv1, 10):
            if conv.get(pv1, 10) in conv.NOT_TREATMENT_FUNCTION:
                # a Main Specialty sent in PV1-10 (reported as an issue on the examples page)
                o.r(f"serviceType.text = {q('Main Specialty ' + conv.get(pv1, 10))}")
            else:
                o.r(f"serviceType.coding[+] = $NHSTreatmentFunction#{conv.get(pv1, 10)}")
        if conv.get(pv1, 18):
            o.r(f"type[+].text = {q(conv.get(pv1, 18))}")
        for n, sl in ((7, "attendingDoctor"), (8, "referringDoctor"), (9, "consultingDoctor"), (17, "admittingDoctor")):
            xcn = conv.get(pv1, n).split("~")[0]
            rules = practitioner_ref(xcn) if xcn else []
            if any(x.startswith(".identifier") for x in rules):
                for rule in rules:
                    o.r(f"participant[{sl}].individual{rule}")
        start, end = ts(conv.get(pv1, 44)), ts(conv.get(pv1, 45))
        if start:
            o.r(f'period.start = "{start}"')
        if end:
            o.r(f'period.end = "{end}"')
        for n, status in ((3, "completed" if ev == "A03" else "active"), (6, "completed")):
            pl = conv.get(pv1, n)
            if pl:
                o.r(f"location[+].location.identifier.value = {q(comp(pl, 2) or comp(pl, 1))}")
                o.r(f"location[=].location.display = {q(' '.join(x for x in (comp(pl, 1), comp(pl, 2), comp(pl, 3)) if x))}")
                o.r(f"location[=].status = #{status}")
        o.r("serviceProvider.identifier.system = $ods-code")
        o.r(f"serviceProvider.identifier.value = {q(fac)}")
        if pv2:
            if comp(conv.get(pv2, 3), 1):
                o.r(f"reasonCode[+].text = {q(comp(conv.get(pv2, 3), 1))}")
            for n, url in ((8, "PlannedStartDate"), (9, "PlannedEndDate")):
                if ts(conv.get(pv2, n)):
                    o.r(f'extension[+].url = "{BASE}StructureDefinition/Extension-{url}"')
                    o.r(f'extension[=].valueDateTime = "{ts(conv.get(pv2, n))}"')
        if zu1:
            if ts(conv.get(zu1, 1)):
                o.r(f'extension[+].url = "{BASE}StructureDefinition/Extension-DecisionToAdmitDateTime"')
                o.r(f'extension[=].valueDateTime = "{ts(conv.get(zu1, 1))}"')
            if conv.get(zu1, 2) in ("1", "2", "3", "4", "5", "8", "9"):
                o.r(f'extension[+].url = "{BASE}StructureDefinition/Extension-IntendedManagement"')
                o.r(f"extension[=].valueCodeableConcept = IntendedManagementCS#{conv.get(zu1, 2)}")
        entries.append(("Encounter", enc))

    # NK1
    for nk1 in segs_of(v251, "NK1"):
        name = related_person_name(nk1)
        if name not in shared["nk1"]:
            shared["nk1"][name] = nk1
        entries.append(("RelatedPerson", name))


    # AL1
    for i, al1 in enumerate(segs_of(v251, "AL1"), start=1):
        name = f"{bid}-allergy-{i}"
        o.instance(name, "PAMAllergyIntolerance", f"Allergy (AL1) - {ev}")
        o.r(f"patient = Reference({pat})")
        if comp(conv.get(al1, 2), 1) == "DA":
            o.r("category[+] = #medication")
        o.r("clinicalStatus = http://terminology.hl7.org/CodeSystem/allergyintolerance-clinical#active")
        o.r("type = #allergy")
        o.r(f"code.coding[+].system = {q(ICD10)}")
        o.r(f"code.coding[=].code = #{comp(conv.get(al1, 3), 1)}")
        if ts(conv.get(al1, 6)):
            o.r(f'recordedDate = "{ts(conv.get(al1, 6))}"')
        entries.append(("AllergyIntolerance", name))

    # DG1
    for i, dg1 in enumerate(segs_of(v251, "DG1"), start=1):
        name = f"{bid}-condition-{i}"
        o.instance(name, "PAMCondition", f"Diagnosis (DG1) - {ev}")
        o.r(f"subject = Reference({pat})")
        if has_encounter:
            o.r(f"encounter = Reference({enc})")
        o.r("clinicalStatus = http://terminology.hl7.org/CodeSystem/condition-clinical#active")
        o.r("category[+] = http://terminology.hl7.org/CodeSystem/condition-category#encounter-diagnosis")
        ce = conv.get(dg1, 3)
        if comp(ce, 1) in conv.RETIRED_ICD10:
            # not a valid code in current WHO ICD-10: carried as text (reported as an issue on the examples page)
            o.r(f"code.text = {q(('ICD-10 ' + comp(ce, 1) + ' ' + comp(ce, 2)).strip())}")
        else:
            o.r(f"code.coding[+].system = {q(ICD10)}")
            o.r(f"code.coding[=].code = #{comp(ce, 1)}")
            if comp(ce, 2):
                o.r(f"code.coding[=].display = {q(comp(ce, 2))}")
        if ts(conv.get(dg1, 5)):
            o.r(f'recordedDate = "{ts(conv.get(dg1, 5))}"')
        entries.append(("Condition", name))

    # PR1
    for i, pr1 in enumerate(segs_of(v251, "PR1"), start=1):
        name = f"{bid}-procedure-{i}"
        o.instance(name, "PAMProcedure", f"Procedure (PR1) - {ev}")
        o.r("status = #completed")
        o.r(f"subject = Reference({pat})")
        if has_encounter:
            o.r(f"encounter = Reference({enc})")
        ce = conv.get(pr1, 3)
        # OPCS-4 has no agreed FHIR canonical URI in HL7 Terminology, so the code is carried as text
        o.r(f"code.text = {q(('OPCS-4 ' + comp(ce, 1) + ' ' + comp(ce, 2)).strip())}")
        o.r(f'performedDateTime = "{ts(conv.get(pr1, 5)) or ts(conv.get(msh, 7))}"')
        entries.append(("Procedure", name))

    # Bundle
    scenario = conv.scenario_for(path)
    o.instance(bid, "PAMBundleMessage", f"HSCIC {mtype} - {path.parent.name}", usage="#example",
               description=f"FHIR Message equivalent of the HSCIC ITK example {mtype} (converted to HL7 v2.5.1). {scenario}"[:900])
    # MSH-10 Message Control ID has no identifier system
    o.r(f'identifier.value = "{comp(conv.get(msh, 10), 1)}"')
    o.r("type = #message")
    o.r(f'timestamp = "{ts(conv.get(msh, 7), instant=True)}"')
    for rtype, name in entries:
        o.r(f'insert Entry("{BASE}{rtype}/{name}", {name})')
    return bid


def main(src, dest):
    root = pathlib.Path(src)
    o = Out()
    shared = {"pid": [], "nk1": {}}
    count = 0
    for folder in conv.ABBR:
        for p in sorted((root / folder).rglob("*.txt")):
            if "scenario" in p.name.lower():
                continue
            if message(o, folder, p, shared):
                count += 1

    # Shared Patient: the most complete PID/PD1 with a valid date of birth
    nhs = {comp(rep, 1) for f, _ in shared["pid"] for rep in conv.get(f, 3).split("~") if comp(rep, 5) == "NH"}
    assert len(nhs) == 1, f"expected one patient, found NHS Numbers {nhs}"
    valid = [(f, pd1) for f, pd1 in shared["pid"] if ts(conv.get(f, 7)[:8])]
    pid, pd1 = max(valid, key=lambda x: sum(1 for v in x[0][1:] if v))
    head = Out()
    head.lines.append("// GENERATED by scripts/hscic_v2_to_fhir.py from the HSCIC ITK ADT examples - do not edit")
    patient(head, SHARED_PATIENT, pid, pd1, "Patient - EDITESTPATIENT TEN (HSCIC ITK examples)", usage="#example",
            description="The HSCIC ITK example patient (PID, PD1), with the test identifier substitutions, shared by all the HSCIC FHIR Message examples")
    for name, nk1 in shared["nk1"].items():
        related_person(head, name, nk1)

    pathlib.Path(dest).parent.mkdir(parents=True, exist_ok=True)
    pathlib.Path(dest).write_text("\n".join(head.lines + o.lines) + "\n")
    print(f"wrote {count} FHIR Messages, 1 shared Patient and {len(shared['nk1'])} shared RelatedPersons to {dest}")

if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2])
