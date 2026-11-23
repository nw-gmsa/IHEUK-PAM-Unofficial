#!/usr/bin/env python3
"""Generate input/pagecontent/hscic-examples.md from the HSCIC ITK HL7 v2.4 example messages.

Each example is shown as the original HL7 v2.4 message and an HL7 v2.5.1 conversion, using only the
rules on the 'Changes from HSCIC ITK v2.4' page (hscic-changes.md). Problems in the original examples
that are not version related are reported, not corrected.

Usage: python3 -I scripts/convert_hscic_examples.py "Specifications/HSCIC/HL7 v2 ADT Examples" input/pagecontent/hscic-examples.md
"""
import pathlib
import re
import sys

NHS_AA = "NHS&2.16.840.1.113883.2.1.4.1&ISO"
SEX = {"1": "M", "2": "F", "0": "U", "9": "A"}
NAME_TYPE = {"PREFERRED": "N", "PREVIOUS-BIRTH": "B", "PREVIOUS-MAIDEN": "M", "PREVIOUS": "U", "PREVIOUS-BACHELOR": "U"}

# (folder, title, description) in the order shown on the page
SECTIONS = [
    ("PatientIdentityManagement", "Patient Identity Management [ITI-30]", "HSCIC ITK 3.1.4. PAS (Patient Demographics Supplier) to consumers."),
    ("PatientIdentityManagementUpdateMaster", "Patient Identity Management - Update Master [ITI-30]",
     "A departmental system (here a self check-in kiosk) updates the PAS master record. The departmental system acts as Patient Demographics Supplier and the PAS as Patient Demographics Consumer."),
    ("PatientEncounterManagement", "Basic Encounter Management [ITI-31]", "HSCIC ITK 3.1.1. IHE Basic Subset, plus A05 and A08."),
    ("InpatientOutpatientEncounterManagement", "Inpatient / Outpatient Encounter Management [ITI-31]", "HSCIC ITK 3.1.1. IHE Inpatient/Outpatient Encounter Management Option."),
    ("PendingEncounterManagement", "Pending Event Management [ITI-31]", "HSCIC ITK 3.1.2. IHE Pending Event Management Option."),
    ("AdvancedEncounterManagement", "Advanced Encounter Management [ITI-31]", "HSCIC ITK 3.1.3. IHE Advanced Encounter Management Option."),
    ("PatientEncounterManagementMaster", "Encounter Management - Update Master [ITI-31]",
     "Departmental systems (maternity, electronic whiteboard, kiosk) update the PAS. The departmental system acts as Patient Encounter Supplier and the PAS as Patient Encounter Consumer."),
    ("InpatientOutpatientEncounterManagementUpdateMaster", "Inpatient / Outpatient Encounter Management - Update Master [ITI-31]",
     "A surgical dashboard updates the PAS with transfers."),
    ("QueryPatient", "Patient Demographic and Visit Queries [PDQ - out of scope]",
     "HSCIC ITK 3.1.5. These are IHE PDQ (ITI-21/ITI-22) style queries. They are shown for completeness and converted to v2.5.1 syntax only; this guide does not profile them."),
]


def read_text(p):
    raw = p.read_bytes()
    for enc in ("utf-8", "cp1252"):
        try:
            return raw.decode(enc)
        except UnicodeDecodeError:
            continue
    return raw.decode("latin-1")


def segments(text):
    lines = re.split(r"\r\n|\r|\n", text)
    return [l.rstrip("\t ") for l in lines if l.strip()]


def fields(seg):
    # MSH: field 1 is the separator, so MSH-n is index n-1 of the split + offset
    parts = seg.split("|")
    if parts[0] == "MSH":
        return ["MSH", "|"] + parts[1:]
    return parts


def join(f):
    if f[0] == "MSH":
        return "MSH|" + "|".join(f[2:])
    return "|".join(f)


def get(f, n):
    return f[n] if n < len(f) else ""


def put(f, n, value):
    while len(f) <= n:
        f.append("")
    f[n] = value


def comps(v):
    return v.split("^")


def cx_fix(value, default_type, field_name, changes):
    out = []
    for rep in value.split("~"):
        if not rep:
            out.append(rep)
            continue
        c = comps(rep)
        while len(c) < 5:
            c.append("")
        aa, typ = c[3], c[4]
        if aa == "NHS":
            c[3] = NHS_AA
            changes.add(f"{field_name}: NHS Number assigning authority `NHS` → `{NHS_AA}` (CX-4)")
            if typ != "NH":
                c[4] = "NH"
                changes.add(f"{field_name}: identifier type code (CX-5) `NH` added for the NHS Number" if not typ else
                            f"{field_name}: CX-5 `{typ}` → `NH` for the NHS Number")
        elif not typ:
            c[4] = default_type
            changes.add(f"{field_name}: identifier type code (CX-5) `{default_type}` added")
        out.append("^".join(c).rstrip("^"))
    return "~".join(out)


def xpn_fix(value, field_name, changes):
    out = []
    for rep in value.split("~"):
        c = comps(rep)
        if len(c) >= 7 and c[6] in NAME_TYPE:
            changes.add(f"{field_name}: name type (XPN-7) `{c[6]}` → HL7 Table 0200 `{NAME_TYPE[c[6]]}`")
            c[6] = NAME_TYPE[c[6]]
        out.append("^".join(c))
    return "~".join(out)


def lang_fix(value, field_name, changes):
    c = comps(value)
    if c and c[0] and c[0] != c[0].lower():
        changes.add(f"{field_name}: language `{c[0]}` → ISO 639-1 `{c[0].lower()}`")
        c[0] = c[0].lower()
    return "^".join(c)


def sex_fix(value, field_name, changes):
    if value in SEX:
        changes.add(f"{field_name}: NHS Person Gender Code `{value}` → HL7 Table 0001 `{SEX[value]}`")
        return SEX[value]
    return value


def is_fix(value, field_name, changes):
    if "^" in value:
        changes.add(f"{field_name}: CE → IS, components after the code removed")
        return value.split("^")[0]
    return value


def bad_dates(f):
    """Yield (field number, value) for TS/DT-like values with an impossible month, day or time."""
    for n, value in enumerate(f[1:], start=1):
        if f[0] == "MSH" and n < 3:
            continue
        for part in re.split(r"[~^&]", value):
            m = re.fullmatch(r"((?:19|20)\d\d)(\d\d)(\d\d)(\d\d)?(\d\d)?(\d\d)?([+-]\d{4})?", part)
            if not m:
                continue
            mo, d = int(m.group(2)), int(m.group(3))
            hh, mi = int(m.group(4) or 0), int(m.group(5) or 0)
            if not (1 <= mo <= 12 and 1 <= d <= 31 and hh < 24 and mi < 60):
                yield n, part


def convert(segs, event):
    changes, issues = set(), []
    out = []
    for seg in segs:
        f = fields(seg)
        sid = f[0]
        for n, value in bad_dates(f):
            issues.append(f"{sid}-{n} `{value}` is not a valid date/time")
        if sid == "MSH":
            if get(f, 12) == "2.4":
                put(f, 12, "2.5.1")
                changes.add("MSH-12: version `2.4` → `2.5.1`")
            if get(f, 13) and not get(f, 13).isdigit():
                issues.append(f"MSH-13 Sequence Number is `{get(f, 13)}`, which is not numeric (NM)")
            if re.fullmatch(r"\d{12,14}([+-]\d{4})?", get(f, 14)):
                issues.append(f"MSH-14 Continuation Pointer holds a date/time (`{get(f, 14)}`); it should be empty in an unsolicited ADT message")
            if get(f, 18) == "UNICODE":
                put(f, 18, "UNICODE UTF-8")
                changes.add("MSH-18: character set `UNICODE` → `UNICODE UTF-8`")
            if get(f, 19):
                put(f, 19, lang_fix(get(f, 19), "MSH-19", changes))
            if get(f, 21) == "iTKv1.0":
                issues.append("MSH-21 is `iTKv1.0`; HSCIC ITK specifies `ITKv1.0`")
        elif sid == "EVN":
            c = comps(get(f, 5))
            if len(c) >= 5 and c[4] in ("Miss", "Mrs", "Mr", "Dr", "Ms") and (len(c) < 6 or not c[5]):
                issues.append(f"EVN-5 Operator ID: prefix `{c[4]}` is in XCN-5 (Suffix); XCN-6 is Prefix")
        elif sid == "PID":
            put(f, 3, cx_fix(get(f, 3), "MR", "PID-3", changes))
            if get(f, 4):
                put(f, 4, cx_fix(get(f, 4), "MR", "PID-4", changes))
            put(f, 5, xpn_fix(get(f, 5), "PID-5", changes))
            if get(f, 8):
                put(f, 8, sex_fix(get(f, 8), "PID-8", changes))
            if get(f, 15):
                put(f, 15, lang_fix(get(f, 15), "PID-15", changes))
            if get(f, 21):
                put(f, 21, cx_fix(get(f, 21), "MR", "PID-21", changes))
            for rep in get(f, 3).split("~"):
                c = comps(rep)
                if len(c) >= 5 and c[4] not in ("", "NH", "MR", "PI", "VN", "AN"):
                    issues.append(f"PID-3 identifier type code `{c[4]}` is not an HL7 Table 0203 value")
        elif sid == "PD1":
            reps = []
            for i, rep in enumerate(get(f, 3).split("~")):
                c = comps(rep)
                if len(c) >= 3 and c[2] and (len(c) < 10 or not c[9]):
                    while len(c) < 10:
                        c.append("")
                    c[9] = c[2]
                    changes.add("PD1-3: GP Practice code copied from XON-3 to XON-10 Organization Identifier")
                reps.append("^".join(c))
            put(f, 3, "~".join(reps))
        elif sid == "NK1":
            put(f, 2, xpn_fix(get(f, 2), "NK1-2", changes))
            if get(f, 15):
                put(f, 15, sex_fix(get(f, 15), "NK1-15", changes))
            if get(f, 20):
                put(f, 20, lang_fix(get(f, 20), "NK1-20", changes))
        elif sid == "PV1":
            put(f, 10, is_fix(get(f, 10), "PV1-10", changes))
            put(f, 14, is_fix(get(f, 14), "PV1-14", changes))
            if get(f, 19):
                put(f, 19, cx_fix(get(f, 19), "VN", "PV1-19", changes))
            if get(f, 50):
                put(f, 50, cx_fix(get(f, 50), "VN", "PV1-50", changes))
        elif sid == "MRG":
            put(f, 1, cx_fix(get(f, 1), "MR", "MRG-1", changes))
            if get(f, 5):
                put(f, 5, cx_fix(get(f, 5), "VN", "MRG-5", changes))
                if event == "A40":
                    issues.append("MRG-5 Prior Visit Number is valued; HSCIC ITK 5.9 says it is only valued in A42")
        elif sid == "QPD":
            q = comps(get(f, 1))
            if event == "Q21" and q and q[0] == "Q22":
                issues.append("QPD-1 Message Query Name is `Q22` in a Q21 query")
        out.append(join(f))

    # ITI-30: A28/A31 require a PV1 with PV1-2 = N
    if event in ("A28", "A31") and not any(s.startswith("PV1|") for s in out):
        pos = 0
        for i, s in enumerate(out):
            if s[:3] in ("MSH", "EVN", "PID", "PD1", "ROL", "NK1"):
                pos = i + 1
        out.insert(pos, "PV1|1|N")
        changes.add("PV1: `PV1|1|N` added - IHE ITI-30 requires PV1 with Patient Class `N` in A28/A31")
    order = {s[:3]: i for i, s in reversed(list(enumerate(out)))}

    def key(c):
        m = re.match(r"([A-Z0-9]{3})(?:-(\d+))?", c)
        return (order.get(m.group(1), 99), int(m.group(2) or 0), c) if m else (99, 0, c)
    return out, sorted(changes, key=key), list(dict.fromkeys(issues))


def event_of(segs):
    msh = fields(segs[0])
    m = comps(get(msh, 9))
    return m[1] if len(m) > 1 else "", get(msh, 9)


def scenario_for(example):
    for p in sorted(example.parent.iterdir()):
        if "scenario" in p.name.lower() and p.suffix.lower() == ".txt":
            return " ".join(segments(read_text(p)))
    return ""


def code(lines):
    return "```\n" + "\n".join(lines) + "\n```\n"


def main(src, dest):
    root = pathlib.Path(src)
    md = []
    md.append("""<div class="alert alert-info">
These examples are the <b>HSCIC ITK HL7 v2 ADT example messages</b> (HL7 v2.4), published with the HSCIC ITK specifications. Each one is shown in its original form and then converted to <b>HL7 v2.5.1</b> using the rules in <a href="hscic-changes.html">Changes from HSCIC ITK v2.4</a>. They are <b>not</b> converted to FHIR; see <a href="testing.html">Testing and Example Messages</a> for FHIR examples.
</div>

The conversion changes only what the move to v2.5.1 and IHE PAM requires. Under each example:

- **Changes** lists every field changed by the conversion.
- **Issues in the original** lists problems in the HSCIC example that are *not* version related. These are left unchanged, so that the converted message can still be compared directly with the original.

The examples are about one fictitious patient, Mrs Fredrica SMITH (test NHS Number `3333333333`), at York Hospital (`RCB`). Segments are shown one per line; on the wire each segment ends with `<cr>`. The HSCIC v2 XML encodings of the v2.4 examples are held in `Specifications/HSCIC/HL7 v2 ADT Examples` in the source repository.

Not converted:

- Time zones (`+ZZZZ`) are not added to TS values, because the originals do not give the offset. Senders **should** include it in v2.5.1.
- XTN-2/XTN-3 (use and equipment type) are not added to telephone numbers, because the type cannot be inferred.
""")
    total = 0
    for folder, title, desc in SECTIONS:
        base = root / folder
        if not base.exists():
            continue
        rank = ["Q21", "K21", "Q22", "K22", "ZV1", "ZV2", "J01"]
        files = sorted((p for p in base.rglob("*.txt") if "scenario" not in p.name.lower()),
                       key=lambda p: (rank.index(p.stem) if p.stem in rank else 0, p.stem.split("_")[0], str(p)))
        if not files:
            continue
        md.append(f"### {title}\n\n{desc}\n")
        for p in files:
            segs = segments(read_text(p))
            if not segs or not segs[0].startswith("MSH"):
                continue
            ev, mtype = event_of(segs)
            v251, changes, issues = convert(segs, ev)
            name = p.parent.name if folder != "QueryPatient" else f"{p.parent.name} {p.stem}"
            name = re.sub(r"\s*ADT-A\d\d$", "", name)
            name = re.sub(r"([a-z])([A-Z])", r"\1 \2", name)
            md.append(f"#### {mtype.split('^')[0]}^{ev} - {name}\n")
            sc = scenario_for(p) if folder != "QueryPatient" else ""
            if sc:
                md.append(f"*Scenario:* {sc}\n")
            md.append("**HL7 v2.4 (HSCIC ITK original)**\n")
            md.append(code(segs))
            md.append("**HL7 v2.5.1**\n")
            md.append(code(v251))
            if changes:
                md.append("Changes:\n\n" + "\n".join(f"- {c}" for c in changes) + "\n")
            if issues:
                md.append("Issues in the original (not changed):\n\n" + "\n".join(f"- {i}" for i in issues) + "\n")
            total += 1
    pathlib.Path(dest).write_text("\n".join(md))
    print(f"wrote {total} examples to {dest}")


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2])
