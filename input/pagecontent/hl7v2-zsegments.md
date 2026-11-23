The UK Z segments were defined by HL7 UK (v2.4 A2/A3, Appendix A.4.3) and profiled by HSCIC ITK sections 5.12 to 5.18. They carry NHS Data Dictionary (Commissioning Data Set) items that have no place in standard HL7 v2 segments. They are carried forward unchanged into HL7 v2.5.1. Data types follow the v2.5.1 definitions.

Z segments are sent at the end of the message, in the order ZU1, ZU3, ZU4, ZU5, ZU6, ZU7, ZU8 (see [ITI-31](ITI-31.html#message-structure---adt_a01-family-a01-a04-a08-a13)). ZU2 (Augmented Care) was removed from the HSCIC specification because Augmented Care was retired from the NHS Data Dictionary.

<div class="alert alert-info">
Many ZU fields describe commissioning and activity data (CDS) rather than patient administration events. Only the fields with a clear patient administration use have FHIR mappings in this version. Other ZU fields are listed for completeness, with their FHIR destination marked "not mapped".
</div>

### ZU1 - UK Additional Data

Usage: RE in the encounter messages (ITI-31), O in A28/A31.

| Seq | Element | DT | Tbl | Notes | FHIR |
|-----|---------|----|-----|-------|------|
| 1 | Date of decision to admit | TS | | May equal the admission date (most emergency admissions), or be earlier for a future admission | Encounter extension:decisionToAdmit |
| 2 | Intended Management | CE | ZU051 | What is intended; PV1-2 records what actually happens | Encounter extension:intendedManagement |
| 3 | Coding Status | IS | ZU010 | | not mapped |
| 4 | Consultant Episode start Date/Time | TS | | | Encounter (consultant episode, PV1-50).period.start |
| 5 | Consultant Episode end Date/Time | TS | | | Encounter (consultant episode).period.end |
| 6 | Consultant's main specialty | CE | ZU012 | [Main Specialty Code](https://www.datadictionary.nhs.uk/attributes/main_specialty_code.html). May differ from the treatment function (PV1-10) | PractitionerRole.specialty (`https://fhir.nhs.uk/CodeSystem/NHSDataModelAndDictionary-clinical-specialty`, OID `2.16.840.1.113883.2.1.3.2.4.16.64`) |
| 9 | Neonatal level of care | CE | ZU020 | | not mapped |
| 10 | Overseas Visitor Status | CE | 0171 | Use this field, not PID-26 | Patient extension:overseasVisitorStatus |
| 13 | Source of Referral | CE | ZU035 | | ServiceRequest (referral) |
| 14 | Service Type Requested | CE | ZU031 | | ServiceRequest.code |
| 15 | Referral Request Received Date | TS | | | ServiceRequest.authoredOn |
| 16 | Referral Date | TS | | | ServiceRequest.occurrence |
| 17 | Referral Receipt Method | CE | ZU028 | | not mapped |
| 18 | Written Referral Indicator | ID | 0136 | Y/N | not mapped |
| 19 | First Regular Day or Night Admission | CE | ZU014 | | not mapped |
| 20 | Psychiatric Admission Status | CE | ZU026 | | not mapped |
| 21 | Significant Facility | ST | | Facility used in SMRs (Scotland) | not mapped |
| 22 | Medically Fit Indicator | ID | 0136 | Y/N | (see ZU1-24) |
| 23 | Embedded Daycase Indicator | ID | 0136 | Scotland only | not mapped |
| 24 | Ready for Discharge | TS | | Date the patient became medically fit for discharge | Encounter extension:readyForDischarge |
| 25 | Borrowed Bed Specialty | CE | ZU008 | Specialty the bed was intended for, when used by another specialty | not mapped |
| 26 | Borrowed Bed HCP | XCN | | | not mapped |
| 27 | NHS Number Tracing Status | IS | | **Legacy only**. Use PID-32 | (PID-32) |
{:.grid}

### ZU3 - UK Additional Data - Attendance Details

| Seq | Element | DT | Tbl | FHIR |
|-----|---------|----|-----|------|
| 1 | Location Type | CE | ZU052 | Location.type |
| 2 | Medical Staff Type seeing Patient | CE | ZU019 | Encounter.participant.type |
| 3 | Attended or DNA | CE | ZU007 | Encounter.status (`finished` / `cancelled`), Appointment.status (`noshow`) |
| 4 | Outcome of Attendance | CE | ZU022 | not mapped |
| 5 | Transport Requirements | CE | ZU037 | not mapped |
| 6 | Attendance Class | CE | ZU006 | Encounter.type |
| 7 | Diary Type | CE | ZU013 | not mapped |
| 8 | Appointment Type | CE | 0277 | Appointment.appointmentType |
| 9 | Patient Age Sex Mix | CE | ZU024 | not mapped |
| 10 | Intended Clinical Care Intensity | CE | ZU017 | not mapped |
| 11 | Broad Patient Group | CE | ZU053 | not mapped |
| 12 | First Attendance Indicator | CE | ZU054 | not mapped |
| 13 | Cancelled By | CE | ZU009 | not mapped |
| 14 | Source of Attendance | CE | ZU034 | not mapped |
{:.grid}

### ZU4 - UK Additional Data - Waiting List

Standard Waiting List CMDS items: Date on list this provider (1), Original date on list (2), Guaranteed admission date (3), Suspension start/end (4, 5), TCI date (6), Responsible HCP provider (7, ZU030), Source of addition (8, ZU033), Removal/Reinstate reason and date (9, 10, ZU029), Outcome of offer of admission (11, ZU023), Initiator of suspension (12, ZU016), Waiting list type (13, ZU055), Reason for exceeding guarantee date (14, ZU027), Last review date (15).

FHIR: not mapped in this version. Waiting lists are better represented by ServiceRequest / Appointment workflows, outside PAM.

### ZU5 - UK Additional Data - Psychiatric Census

Annual psychiatric census, sent in A08 only. Census Year (1, R), Legal Status on Admission (2, ZU047), Legal Status at Census Date (3, ZU048), Mental Category (4, ZU049), Date Detention Commenced (5), Ward Type at Census Date (6).

FHIR: ZU5-2 and ZU5-3 map to the UK Core Legal Status extension (`https://fhir.hl7.org.uk/StructureDefinition/Extension-UKCore-LegalStatus`) on [PAM Encounter](StructureDefinition-PAMEncounter.html), using UK Core Legal Status Classification (England).

### ZU6 - UK Additional Data - Labour and Delivery

Antenatal GP (1), First Antenatal Assessment Date (2), Number of Previous Pregnancies (3), Actual Delivery Place (4, ZU040), Delivery Date (5), Intended Delivery Place (6, ZU041), Delivery Place Change Reason (7, ZU042), Estimated Gestation Length at Initial Assessment (8, 10-49), Labour/Delivery Onset Method (9, ZU018), Delivery Method (10, ZU043), Status of Person Conducting Delivery (11, ZU044), Anaesthetic Given During (12, ZU003) and Post (13, ZU004) Labour/Delivery, Number of Babies (14, 1-9).

### ZU7 - UK Additional Data - Birth

Live or Still Birth (2, ZU046), Birth Weight (3), Resuscitation Method (5, ZU045), Gestation Length at Onset of Labour (6), Number of Births this Confinement (7), Suspected Congenital Anomaly (8), Birth Order (9).

ZU6 and ZU7 are usually sent as a pair, but receivers **shall not** assume that if one is present the other is too. They carry Maternity CDS data. Because the complete CDS needs data from both mother and baby, neither segment can carry a complete Maternity CDS on its own. FHIR: not mapped. Maternity and birth details are clinical Observations, outside PAM.

### ZU8 - UK Miscellaneous Demographic Data

| Seq | Element | DT | Tbl | Notes | FHIR |
|-----|---------|----|-----|-------|------|
| 1 | Sexual Orientation | IS | ZU032 | | Observation (code LOINC 76690-7 Sexual orientation), value from [Sexual Orientation](CodeSystem-sexual-orientation.html) |
| 2 | DCR Consent to share | IS | ZU056 | Information crossing an organisational boundary MUST be agreed with the patient. Empty implies consent | Consent (scope = patient-privacy) |
| 3 | SCR Consent to Store | IS | ZU058 | Empty: the patient must be asked every time | Consent |
| 4 | Location Hiding | IS | ZU057 | See below | Patient extension:locationHiding + meta.security = `R` |
{:.grid}

#### Location hiding

Systems **must** offer the ability to *shield* patient location details, for example to protect the location of an abused spouse. This gives a reasonable but limited level of protection while still allowing essential care to continue. Shielding blanks or protects:

- addresses (PID-11, NK1-4)
- telephone numbers and email addresses (PID-13, PID-14, NK1-5, NK1-6)
- next of kin details (NK1)
- GP details (PD1)

Code `2` defers to the national PDS S-flag (Information Sensitivity Indicator). A Consumer receiving `1` or `2` **shall** apply equivalent restrictions to display and onward disclosure.
