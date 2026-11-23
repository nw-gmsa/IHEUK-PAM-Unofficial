Segment definitions for HL7 v2.5.1, derived from HSCIC ITK section 5. Only fields that HSCIC ITK uses are listed. All other fields are **not used** (`X`): senders should not populate them, and receivers shall ignore them. Table numbers refer to [Terminology and Reference Tables](terminology.html). Changes from HSCIC ITK v2.4 are marked **v2.5.1**.

### MSH - Message Header

| Seq | Element | DT | Usage | Card. | Tbl | Notes | FHIR |
|-----|---------|----|-------|-------|-----|-------|------|
| 1 | Field Separator | ST | R | [1..1] | | <code>&#124;</code> | |
| 2 | Encoding Characters | ST | R | [1..1] | | `^~\&` | |
| 3 | Sending Application | HD | R | [1..1] | 0361 | e.g. `PAS` | MessageHeader.source.name |
| 4 | Sending Facility | HD | R | [1..1] | 0362 | ODS code of the NHS organisation (3 characters), or a 5-character site code when there is more than one sending facility | MessageHeader.sender |
| 5 | Receiving Application | HD | R | [1..1] | 0361 | `ROUTE` where PAS broadcasts via an integration engine, which takes responsibility for onward routing | MessageHeader.destination.name |
| 6 | Receiving Facility | HD | R | [1..1] | 0362 | ODS code, or `ROUTE` | MessageHeader.destination.receiver |
| 7 | Date/Time of Message | TS | R | [1..1] | | All systems should use a consistent time server | Bundle.timestamp |
| 9 | Message Type | MSG | R | [1..1] | 0076/0003/0354 | All three components required, e.g. `ADT^A01^ADT_A01`. The message structure (third component) selects the schema | MessageHeader.eventCoding |
| 10 | Message Control ID | ST | R | [1..1] | | Max 20 characters | Bundle.identifier |
| 11 | Processing ID | PT | R | [1..1] | 0103 | `P` production, `T` training, `D` debug | meta.tag |
| 12 | Version ID | VID | R | [1..1] | 0104 | **v2.5.1**: `2.5.1` (was `2.4`) | |
| 13 | Sequence Number | NM | O | [0..1] | | Used with MSH-7 to detect messages received out of sequence | |
| 15 | Accept Acknowledgment Type | ID | C | [0..1] | 0155 | **v2.5.1**: empty (original mode), or `AL` under the IHE Acknowledgement Support option | |
| 16 | Application Acknowledgment Type | ID | C | [0..1] | 0155 | As MSH-15 | |
| 17 | Country Code | ID | RE | [0..1] | 0399 | `GBR` | |
| 18 | Character Set | ID | C | [0..1] | 0211 | `UNICODE UTF-8` recommended | |
| 19 | Principal Language of Message | CE | RE | [0..1] | 0296 | `en` | |
| 21 | Message Profile Identifier | EI | R | [1..*] | | **v2.5.1** EI. HSCIC ITK required the ITK version, e.g. `ITKv1.0`. Senders conforming to this guide **should** add a repetition `IHEUK-PAM^^2.16.840.1.113883.2.1.3.x^ISO` *(OID to be assigned)* | MessageHeader.definition |
{:.grid}

### EVN - Event Type

| Seq | Element | DT | Usage | Card. | Notes | FHIR |
|-----|---------|----|-------|-------|-------|------|
| 1 | Event Type Code | ID | X | | Retained for backward compatibility only; use MSH-9.2 | Provenance.activity |
| 2 | Recorded Date/Time | TS | R | [1..1] | Mandatory in ITK, to preserve sequencing | Provenance.recorded |
| 4 | Event Reason Code | IS | O | [0..1] | **v2.5.1**: permitted (was not used in ITK) | Provenance.reason |
| 5 | Operator ID | XCN | O | [0..1] | Clinical or non-clinical operator who triggered the event | Provenance.agent.who |
| 6 | Event Occurred | TS | R | [1..1] | The time of the real-world event, not of the message. Used to reconstruct episode sequencing | Provenance.occurredDateTime |
| 7 | Event Facility | HD | O | [0..1] | **v2.5.1**: permitted (was not used in ITK) | Provenance.location |
{:.grid}

### PID - Patient Identification

| Seq | Element | DT | Usage | Card. | Tbl | Notes | FHIR ([PAM Patient](StructureDefinition-PAMPatient.html)) |
|-----|---------|----|-------|-------|-----|-------|------|
| 1 | Set ID | SI | O | [0..1] | | | |
| 3 | Patient Identifier List | CX | R | [1..*] | 0203, 0363 | At least one identifier common to sender and receiver. A traced NHS Number **MUST** be included where available. See [CX for PID-3](#pid-3-patient-identifier-list-cx) | identifier |
| 4 | Alternate Patient ID | CX | O | [0..1] | | Temporary patient number only. Retained for backward compatibility in v2.5.1 | identifier (use = temp) |
| 5 | Patient Name | XPN | R | [1..*] | 0200 | Legal name first. Alias names repeat in PID-5 with XPN-7 = `A` | name |
| 6 | Mother's Maiden Name | XPN | O | [0..1] | | Family name only (35) | extension: patient-mothersMaidenName |
| 7 | Date/Time of Birth | TS | RE | [0..1] | | Field length 17. Unknown/estimated DoB is flagged in PID-32 (`UD`/`ED`) | birthDate, birthTime |
| 8 | Administrative Sex | IS | RE | [0..1] | 0001 | **v2.5.1**: HL7 Table 0001 (`M`,`F`,`U`,`O`,`A`,`N`) is required by IHE. Legacy NHS numeric codes (`0`,`1`,`2`,`9`) **should** be accepted by receivers. See [ConceptMap](ConceptMap-HL7SexToHSCICSex.html) | gender |
| 9 | Patient Alias | XPN | X | | | Must NOT be populated. Use PID-5 | |
| 11 | Patient Address | XAD | O | [0..*] | 0190 | | address |
| 13 | Phone Number - Home | XTN | O | [0..*] | 0201, 0202 | Landline first, mobile second | telecom |
| 14 | Phone Number - Business | XTN | O | [0..*] | | | telecom (use = work) |
| 15 | Primary Language | CE | O | [0..1] | 0296 | ISO 639-1 plus 5 'q' codes for non-spoken languages | communication.language |
| 16 | Marital Status | CE | O | [0..1] | 0002 | NHS DD Person Marital Status | maritalStatus |
| 17 | Religion | CE | O | [0..1] | 0006 | | extension: patient-religion |
| 18 | Patient Account Number | CX | C | [0..1] | 0203 | **Hospital Provider Spell** number (CX-5 = `AN`). HSCIC ITK 5.3.8: ties the patient to an incidence of care, such as a stay as an admitted patient; conditionally required for messages about a specific incidence of care, not for A14, A28, A31. **v2.5.1**: required for admitted patient care events in ITI-31 (HSCIC: not used in ITK) | Encounter.partOf.identifier ([Hospital Provider Spell Identifier](StructureDefinition-HospitalProviderSpellIdentifier.html)) |
| 21 | Mother's Identifier | CX | O | [0..*] | | Mother's PID-3 identifier | RelatedPerson.identifier (relationship = mother) |
| 22 | Ethnic Group | CE | O | [0..1] | 0189 | NHS DD Ethnic Category | extension: UKCore-EthnicCategory |
| 23 | Birth Place | ST | O | [0..1] | | 35 characters | extension: patient-birthPlace |
| 24 | Multiple Birth Indicator | ID | O | [0..1] | 0136 | | multipleBirthBoolean |
| 25 | Birth Order | NM | O | [0..1] | | | multipleBirthInteger |
| 26 | Citizenship | CE | O | [0..1] | 0399 | Country of citizenship. NOT Overseas Visitor Status (use ZU1-10) | extension: patient-citizenship |
| 28 | Nationality | CE | O | [0..1] | 0399 | | extension: patient-nationality |
| 29 | Patient Death Date and Time | TS | O | [0..1] | | | deceasedDateTime |
| 30 | Patient Death Indicator | ID | O | [0..1] | 0136 | | deceasedBoolean |
| 31 | Identity Unknown Indicator | ID | O | [0..1] | 0136 / ZU050 | `Y` = Pseudo Person (no fuzzy matching). A Full Person can never become a Pseudo Person | extension: IdentityUnknownIndicator |
| 32 | Identity Reliability Code | IS | C | [0..*] | 0445 | At most one NHS Number tracing status `NSTSnn`. `UD`/`ED` for unknown/estimated DoB | NHS Number extension: NHSNumberVerificationStatus |
| 33 | Last Update Date/Time | TS | C | [0..1] | | **v2.5.1**: required if the PIX Pediatric Demographics option is claimed | meta.lastUpdated |
| 34 | Last Update Facility | HD | C | [0..1] | | As PID-33 | |
{:.grid}

#### PID-3 Patient Identifier List (CX)

| Comp | Name | Usage | NHS Number | Local identifier |
|------|------|-------|------------|------------------|
| 1 | ID Number | R | 10 digits, no spaces | Whole local number |
| 4 | Assigning Authority | R | **v2.5.1**: `NHS&2.16.840.1.113883.2.1.4.1&ISO` (HSCIC: `NHS`) | Local system code by agreement (Table 0363) |
| 5 | Identifier Type Code | R | **v2.5.1**: `NH` | **v2.5.1**: `MR` |
| 6 | Assigning Facility | O | - | ODS code of the organisation |
{:.grid}

Example: `9449305552^^^NHS&2.16.840.1.113883.2.1.4.1&ISO^NH~MRN123456^^^R0A^MR^R0A`

### PD1 - Patient Additional Demographic

| Seq | Element | DT | Usage | Card. | Notes | FHIR |
|-----|---------|----|-------|-------|-------|------|
| 3 | Patient Primary Facility | XON | C | [0..2] | Repetition 1: GP Practice (shall be coded, XON-3 / **v2.5.1** XON-10 = ODS code). Repetition 2: Surgery, if different from the practice (name only by local agreement) | generalPractitioner (Organization) |
| 4 | Patient Primary Care Provider Name and ID No. | XCN | O | [0..1] | XCN-1 = national GP code (G + 6 digits + check digit, Table 0010). XCN-2 Family Name required if XCN-1 is empty | generalPractitioner (Practitioner) |
| 12 | Protection Indicator | ID | X | | Must NOT be populated; use ZU8-4 | |
{:.grid}

### NK1 - Next of Kin / Associated Parties

| Seq | Element | DT | Usage | Card. | Tbl | Notes | FHIR ([PAM Related Person](StructureDefinition-PAMRelatedPerson.html)) |
|-----|---------|----|-------|-------|-----|-------|------|
| 1 | Set ID | SI | R | [1..1] | | | |
| 2 | Name | XPN | R | [1..1] | | Required by this standard | name |
| 3 | Relationship | CE | R | [1..1] | 0063 | PDS Relationship Type | relationship |
| 4 | Address | XAD | O | [0..1] | | | address |
| 5 | Phone Number | XTN | O | [0..*] | | | telecom |
| 6 | Business Phone Number | XTN | O | [0..*] | | | telecom (use = work) |
| 7 | Contact Role | CE | O | [0..1] | 0131 | Uses the Table 0063 values | relationship |
| 8 | Start Date | DT | O | [0..1] | | | period.start |
| 9 | End Date | DT | O | [0..1] | | | period.end |
| 15 | Administrative Sex | IS | O | [0..1] | 0001 | | gender |
| 16 | Date/Time of Birth | TS | O | [0..1] | | | birthDate |
| 20 | Primary Language | CE | O | [0..1] | 0296 | | communication.language |
{:.grid}

### PV1 - Patient Visit

| Seq | Element | DT | Usage | Card. | Tbl | Notes | FHIR ([PAM Encounter](StructureDefinition-PAMEncounter.html)) |
|-----|---------|----|-------|-------|-----|-------|------|
| 1 | Set ID | SI | O | [0..1] | | | |
| 2 | Patient Class | IS | R | [1..1] | 0004 | `N` in ITI-30 messages | class |
| 3 | Assigned Patient Location | PL | O | [0..1] | | PL-1 point of care, PL-2 ward code (RE), PL-3 bed, PL-4 facility (ODS site code, R) | location (active) |
| 4 | Admission Type | IS | O | [0..1] | 0007 | NHS DD Admission Method | hospitalization.extension:admissionMethod |
| 6 | Prior Patient Location | PL | O | [0..1] | | | location (completed) |
| 7 | Attending Doctor | XCN | O | [0..1] | 0010 | National GP / Consultant code | participant (ATND) |
| 8 | Referring Doctor | XCN | O | [0..1] | 0010 | | participant (REF) |
| 9 | Consulting Doctor | XCN | O | [0..*] | 0010 | Consultant in charge of the care spell. The first is the main consultant; for shared care, a list | participant (CON) |
| 10 | Hospital Service | IS | O | [0..1] | 0069 | **v2.5.1**: IS (HSCIC: CE). [Treatment Function Code](https://www.datadictionary.nhs.uk/attributes/treatment_function_code.html) (not Main Specialty) | serviceType (`https://fhir.nhs.uk/CodeSystem/NHSDataModelAndDictionary-treatment-function`) |
| 13 | Re-admission Indicator | IS | O | [0..1] | 0092 | | hospitalization.reAdmission |
| 14 | Admit Source | IS | O | [0..1] | 0023 | **v2.5.1**: IS (HSCIC: CE). NHS DD Source of Admission | hospitalization.admitSource |
| 15 | Ambulatory Status | IS | O | [0..*] | 0009 | IHE Ambulatory Patient Data option | (Flag / Observation) |
| 16 | VIP Indicator | IS | O | [0..1] | 0099 | | hospitalization.specialCourtesy |
| 17 | Admitting Doctor | XCN | O | [0..1] | 0010 | Doctor who made the decision to admit | participant (ADM) |
| 18 | Patient Type | IS | O | [0..1] | 0018 | | type |
| 19 | Visit Number | CX | O (C) | [0..1] | | Unique within assigning authority and type. Required for all ITI-31 events. **v2.5.1** CX-5 = `VN` | identifier (visitNumber) |
| 36 | Discharge Disposition | IS | O | [0..1] | 0112 | NHS DD Discharge Method / A&E Attendance Disposal | extension:dischargeMethod |
| 37 | Discharged to Location | DLD | O | [0..1] | 0113 | **v2.5.1** DLD (v2.4 CM). NHS DD Discharge Destination | hospitalization.dischargeDisposition |
| 38 | Diet Type | CE | O | [0..1] | 0114 | | hospitalization.dietPreference |
| 44 | Admit Date/Time | TS | C | [0..1] | | Required where present for the event; not in A05 (use PV2-8) | period.start |
| 45 | Discharge Date/Time | TS | C | [0..1] | | Required in A03 | period.end |
| 50 | Alternate Visit ID | CX | O | [0..1] | | e.g. consultant episode within the stay identified by PV1-19 | identifier (alternateVisitId) |
{:.grid}

### PV2 - Patient Visit - Additional Information

| Seq | Element | DT | Usage | Card. | Tbl | Notes | FHIR |
|-----|---------|----|-------|-------|-----|-------|------|
| 3 | Admit Reason | CE | O | [0..1] | ZU001 | | reasonCode |
| 4 | Transfer Reason | CE | O | [0..1] | ZU036 | | location.extension / reasonCode |
| 8 | Expected Admit Date/Time | TS | C | [0..1] | | Required in A05 and A14 | extension:plannedStartDate |
| 9 | Expected Discharge Date/Time | TS | C | [0..1] | | Required in A16 | extension:plannedEndDate |
| 12 | Visit Description | ST | O | [0..1] | | | text |
| 25 | Visit Priority Code | IS | O | [0..1] | 0217 | | priority |
| 38 | Mode of Arrival Code | CE | O | [0..1] | 0430 | | (not mapped) |
{:.grid}

### AL1 - Patient Allergy Information

| Seq | Element | DT | Usage | Card. | Tbl | Notes | FHIR ([PAM Allergy Intolerance](StructureDefinition-PAMAllergyIntolerance.html)) |
|-----|---------|----|-------|-------|-----|-------|------|
| 1 | Set ID | SI | R | [1..1] | | | |
| 2 | Allergen Type Code | CE | O | [0..1] | 0127 | | category |
| 3 | Allergen Code/Mnemonic/Description | CE | R | [1..1] | ZU002 | Code and coding system uniquely identify the allergy. The description is shown to the user, and may be used alone as a free-text allergy | code |
| 4 | Allergy Severity Code | CE | O | [0..1] | 0128 | | criticality |
| 5 | Allergy Reaction | ST | O | [0..1] | | Text | reaction.description |
| 6 | Identification Date | DT | O | [0..1] | | | recordedDate |
{:.grid}

### MRG - Merge Patient Information

| Seq | Element | DT | Usage | Card. | Notes | FHIR |
|-----|---------|----|-------|-------|-------|------|
| 1 | Prior Patient Identifier List | CX | R | [1..*] | Identifiers of the non-surviving record, "tightly coupled" to PID-3 | Patient.link (replaces) → identifier |
| 5 | Prior Visit Number | CX | C | [0..1] | Only valued in A42 (not used in this guide) | |
{:.grid}

### MSA - Message Acknowledgment

| Seq | Element | DT | Usage | Card. | Tbl | Notes |
|-----|---------|----|-------|-------|-----|-------|
| 1 | Acknowledgment Code | ID | R | [1..1] | 0008 | `AA`, `AE`, `AR` (original mode) |
| 2 | Message Control ID | ST | R | [1..1] | | MSH-10 of the message being acknowledged |
{:.grid}

### Other segments

The OBX, DG1, PR1, ERR, QAK, QPD, RCP, DSC, QRI and QID definitions in HSCIC ITK 5.10, 5.11 and 5.19 to 5.27 follow HL7 v2.5.1 unchanged. Diagnosis (DG1-3) uses ICD-10; procedures (PR1-3) use OPCS-4. Both map to [PAM Condition](StructureDefinition-PAMCondition.html) and [PAM Procedure](StructureDefinition-PAMProcedure.html). The query segments belong to PDQ (out of scope).
