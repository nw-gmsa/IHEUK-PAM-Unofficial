Profile:     PAMEncounter
Parent:      Encounter
Id:          PAMEncounter
Title:       "PAM Encounter"
Description: """
Patient visit / encounter conveyed by IHE PAM [ITI-31](ITI-31.html): HL7 v2.5.1 `PV1`, `PV2` and the UK `ZU1` segment.

A visit (`PV1-19`) may be an admission (Hospital Provider Spell), an A&E attendance, a community contact or an outpatient attendance (appointment). A consultant episode within an inpatient stay is identified by `PV1-50` Alternate Visit ID.

HL7 Europe Base does not define an Encounter profile, so this profile is based on the FHIR R4 Encounter with UK Core extensions and terminology. `Encounter.status` is derived from the trigger event, see [ITI-31](ITI-31.html#trigger-events-and-encounter-status).
"""

* extension contains
    DecisionToAdmitDateTime named decisionToAdmit 0..1 and
    IntendedManagement named intendedManagement 0..1 and
    ReadyForDischargeDateTime named readyForDischarge 0..1 and
    PlannedStartDate named plannedStartDate 0..1 and
    PlannedEndDate named plannedEndDate 0..1 and
    $UKCore-DischargeMethod named dischargeMethod 0..1 and
    $UKCore-LegalStatus named legalStatus 0..*
* extension[decisionToAdmit] ^short = "ZU1-1 Date of decision to admit"
* extension[intendedManagement] ^short = "ZU1-2 Intended Management"
* extension[readyForDischarge] ^short = "ZU1-24 Ready for Discharge"
* extension[plannedStartDate] ^short = "PV2-8 Expected Admit Date/Time (C: required in A05, A14)"
* extension[plannedEndDate] ^short = "PV2-9 Expected Discharge Date/Time (C: required in A16)"
* extension[dischargeMethod] ^short = "PV1-36 Discharge Disposition (admitted patient care Discharge Method)"
* extension[legalStatus] ^short = "ZU5-2/ZU5-3 Legal Status (Mental Health Act)"

* identifier 1..* MS
* identifier only PAMIdentifier
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "use"
* identifier ^slicing.rules = #open
* identifier ^slicing.ordered = false
* identifier contains
    visitNumber 0..1 MS and
    alternateVisitId 0..1
* identifier[visitNumber] only VisitNumber
* identifier[visitNumber] ^short = "PV1-19 Visit Number"
* identifier[visitNumber] insert SupplierPopulateIfKnown
* identifier[alternateVisitId] only AlternateVisitIdentifier
* identifier[alternateVisitId] ^short = "PV1-50 Alternate Visit ID (e.g. consultant episode)"

* status MS
* status ^short = "Derived from the trigger event (EVN/MSH-9) - see ITI-31"

* class MS
* class ^short = "PV1-2 Patient Class (see ConceptMap HSCIC Patient Class to FHIR)"

* type MS
* type ^short = "PV1-18 Patient Type / ZU3-6 Attendance Class"

* serviceType MS
* serviceType ^short = "PV1-10 Hospital Service (NHS Treatment Function Code)"

* priority ^short = "PV2-25 Visit Priority Code"

* subject 1..1 MS
* subject only Reference(PAMPatient)
* subject ^short = "PID - the patient"

* participant MS
* participant.type 1..1
* participant.individual only Reference(PAMPractitioner or PractitionerRole)
* participant.individual.identifier only PractitionerIdentifier
* participant ^slicing.discriminator.type = #pattern
* participant ^slicing.discriminator.path = "type"
* participant ^slicing.rules = #open
* participant contains
    attendingDoctor 0..1 MS and
    referringDoctor 0..1 MS and
    consultingDoctor 0..* MS and
    admittingDoctor 0..1 MS
* participant[attendingDoctor].type = $v3-ParticipationType#ATND
* participant[attendingDoctor] ^short = "PV1-7 Attending Doctor"
* participant[referringDoctor].type = $v3-ParticipationType#REF
* participant[referringDoctor] ^short = "PV1-8 Referring Doctor"
* participant[consultingDoctor].type = $v3-ParticipationType#CON
* participant[consultingDoctor] ^short = "PV1-9 Consulting Doctor. The consultant in charge of the care spell; first is the main consultant"
* participant[admittingDoctor].type = $v3-ParticipationType#ADM
* participant[admittingDoctor] ^short = "PV1-17 Admitting Doctor - the doctor who made the decision to admit"

* period MS
* period.start ^short = "PV1-44 Admit Date/Time (C)"
* period.end ^short = "PV1-45 Discharge Date/Time (C: required in A03)"

* reasonCode ^short = "PV2-3 Admit Reason"

* hospitalization MS
* hospitalization.extension contains $UKCore-AdmissionMethod named admissionMethod 0..1 MS
* hospitalization.extension[admissionMethod] ^short = "PV1-4 Admission Type (NHS Admission Method)"
* hospitalization.preAdmissionIdentifier ^short = "PV1-5 Preadmit Number (not used in HSCIC ITK)"
* hospitalization.admitSource from $VS-UKCore-SourceOfAdmission (extensible)
* hospitalization.admitSource ^short = "PV1-14 Admit Source (NHS Source of Admission)"
* hospitalization.reAdmission ^short = "PV1-13 Re-admission Indicator"
* hospitalization.dietPreference ^short = "PV1-38 Diet Type"
* hospitalization.specialCourtesy ^short = "PV1-16 VIP Indicator"
* hospitalization.dischargeDisposition from $VS-UKCore-DischargeDestination (extensible)
* hospitalization.dischargeDisposition ^short = "PV1-37 Discharged to Location (NHS Discharge Destination)"

* location MS
* location.location only Reference(PAMLocation)
* location ^short = "PV1-3 Assigned Patient Location (status active) and PV1-6 Prior Patient Location (status completed)"
* location.status MS
* location.period ^short = "EVN-6 Event Occurred of the transfer (A02) / leave of absence (A21, A22)"

* serviceProvider MS
* serviceProvider.identifier only ODSOrganisationCode
* serviceProvider ^short = "MSH-4 Sending Facility / PL-4 Facility organisation (ODS code)"

* partOf only Reference(PAMEncounter)
* partOf ^short = "For a consultant episode (PV1-50), the Hospital Provider Spell (PV1-19)"

Mapping:  PAMEncounterToV2
Source:   PAMEncounter
Target:   "http://hl7.org/v2"
Id:       hl7v2
Title:    "HL7 v2.5.1 (HSCIC ITK)"
* -> "PV1, PV2, ZU1"
* status -> "MSH-9.2 trigger event"
* class -> "PV1-2"
* location -> "PV1-3, PV1-6"
* hospitalization.extension[admissionMethod] -> "PV1-4"
* participant[attendingDoctor] -> "PV1-7"
* participant[referringDoctor] -> "PV1-8"
* participant[consultingDoctor] -> "PV1-9"
* serviceType -> "PV1-10"
* hospitalization.reAdmission -> "PV1-13"
* hospitalization.admitSource -> "PV1-14"
* hospitalization.specialCourtesy -> "PV1-16"
* participant[admittingDoctor] -> "PV1-17"
* type -> "PV1-18"
* identifier[visitNumber] -> "PV1-19"
* extension[dischargeMethod] -> "PV1-36"
* hospitalization.dischargeDisposition -> "PV1-37"
* hospitalization.dietPreference -> "PV1-38"
* period.start -> "PV1-44"
* period.end -> "PV1-45"
* identifier[alternateVisitId] -> "PV1-50"
* reasonCode -> "PV2-3"
* extension[plannedStartDate] -> "PV2-8"
* extension[plannedEndDate] -> "PV2-9"
* priority -> "PV2-25"
* extension[decisionToAdmit] -> "ZU1-1"
* extension[intendedManagement] -> "ZU1-2"
* extension[readyForDischarge] -> "ZU1-24"
* extension[legalStatus] -> "ZU5-2, ZU5-3"

Profile:     PAMLocation
Parent:      $location-eu-core
Id:          PAMLocation
Title:       "PAM Location"
Description: """
HL7 v2.5.1 `PL` Person Location (`PV1-3` Assigned Patient Location, `PV1-6` Prior Patient Location).

| PL | Component | HSCIC usage | FHIR |
|----|-----------|-------------|------|
| PL-1 | Point of Care | O | `Location` with `physicalType` = `wa` / `ro`, `name` |
| PL-2 | Room - NHS Ward Code | RE | `identifier` (local ward code), `physicalType` = `wa` |
| PL-3 | Bed | O | `Location` with `physicalType` = `bd`, `partOf` the ward |
| PL-4 | Facility - ODS site code (formerly NACS) | R | `managingOrganization` / `partOf` site Location `identifier` (ODS site code) |
| PL-5 | Location Status | O | `operationalStatus` |
{:.grid}

Ward and bed values are locally defined; consistent use between participating systems is required. As a minimum the Facility should be populated with the code representing the hospital.
"""
* identifier MS
* identifier ^short = "PL-2 ward code / PL-3 bed (local) or PL-4 ODS site code"
* name MS
* physicalType MS
* physicalType ^short = "wa (ward), ro (room), bd (bed), si (site)"
* operationalStatus ^short = "PL-5 Location Status"
* partOf MS
* partOf ^short = "Bed partOf Ward partOf Site (PL-4)"
* managingOrganization.identifier only ODSOrganisationCode

Profile:     PAMPractitioner
Parent:      $practitioner-eu
Id:          PAMPractitioner
Title:       "PAM Practitioner"
Description: "HL7 v2.5.1 `XCN` Extended Composite ID Number and Name for Persons - `PV1-7`, `PV1-8`, `PV1-9`, `PV1-17`, `PD1-4`, `EVN-5`. HSCIC Table 0010: national GP / consultant code."
* identifier MS
* identifier only PractitionerIdentifier
* identifier ^short = "XCN-1 ID Number (national GP code or GMC number)"
* name MS
* name.family ^short = "XCN-2 Family Name"
* name.given ^short = "XCN-3 Given Name, XCN-4 Second and Further Given Names"
* name.prefix ^short = "XCN-6 Prefix"

Profile:     PAMOrganization
Parent:      $organization-eu
Id:          PAMOrganization
Title:       "PAM Organization"
Description: "HL7 v2.5.1 `XON` / `HD` organisations - `PD1-3` GP Practice, `MSH-4`/`MSH-6` facilities, `CX-6` assigning facility. Identified by ODS code."
* identifier 1..* MS
* identifier only ODSOrganisationCode
* identifier ^short = "XON-10 / XON-3 Organization Identifier (ODS code)"
* name MS
* name ^short = "XON-1 Organization Name"

Profile:     PAMRelatedPerson
Parent:      RelatedPerson
Id:          PAMRelatedPerson
Title:       "PAM Related Person (Next of Kin)"
Description: """
HL7 v2.5.1 `NK1` Next of Kin / Associated Parties. HSCIC ITK requires the Next of Kin name (`NK1-2`) and relationship (`NK1-3`).

HL7 Europe Base does not define a RelatedPerson profile. Implementations that carry NK1 as `Patient.contact` instead are acceptable, but `Patient.contact` cannot carry `NK1-16` Date of Birth or `NK1-20` Primary Language.
"""
* patient only Reference(PAMPatient)
* relationship 1..* MS
* relationship from HSCICRelationshipVS (preferred)
* relationship ^short = "NK1-3 Relationship and NK1-7 Contact Role (HSCIC/PDS Relationship Type)"
* name 1..* MS
* name ^short = "NK1-2 Name"
* address ^short = "NK1-4 Address"
* telecom ^short = "NK1-5 Phone Number, NK1-6 Business Phone Number"
* period ^short = "NK1-8 Start Date, NK1-9 End Date"
* gender ^short = "NK1-15 Sex"
* birthDate ^short = "NK1-16 Date of Birth"
* communication.language ^short = "NK1-20 Primary Language"

Mapping:  PAMRelatedPersonToV2
Source:   PAMRelatedPerson
Target:   "http://hl7.org/v2"
Id:       hl7v2
Title:    "HL7 v2.5.1 (HSCIC ITK)"
* -> "NK1"
* name -> "NK1-2"
* relationship -> "NK1-3, NK1-7"
* address -> "NK1-4"
* telecom -> "NK1-5, NK1-6"
* period -> "NK1-8, NK1-9"
* gender -> "NK1-15"
* birthDate -> "NK1-16"
* communication.language -> "NK1-20"

Profile:     PAMAllergyIntolerance
Parent:      $allergyIntolerance-eu-core
Id:          PAMAllergyIntolerance
Title:       "PAM Allergy Intolerance"
Description: "HL7 v2.5.1 `AL1` Patient Allergy Information. HSCIC ITK: if the patient has recorded allergies they **must** be sent (RE) in A01, A04, A05, A08, A13, A28, A31 and A38."
* category ^short = "AL1-2 Allergy Type"
* code ^short = "AL1-3 Allergy Code/Mnemonic/Description. If not coded, the description is sent as code.text"
* criticality ^short = "AL1-4 Allergy Severity"
* reaction.description ^short = "AL1-5 Allergy Reaction (text)"
* recordedDate ^short = "AL1-6 Identification Date"

Profile:     PAMCondition
Parent:      $condition-eu-core
Id:          PAMCondition
Title:       "PAM Condition (Diagnosis)"
Description: "HL7 v2.5.1 `DG1` Diagnosis. Diagnosis codes are ICD-10 (5th Edition) or SNOMED CT."
* encounter only Reference(PAMEncounter)
* code ^short = "DG1-3 Diagnosis Code"
* recordedDate ^short = "DG1-5 Diagnosis Date/Time"
* category ^short = "DG1-6 Diagnosis Type"

Profile:     PAMProcedure
Parent:      $procedure-eu-core
Id:          PAMProcedure
Title:       "PAM Procedure"
Description: "HL7 v2.5.1 `PR1` Procedures. Procedure codes are OPCS-4 or SNOMED CT."
* encounter only Reference(PAMEncounter)
* code ^short = "PR1-3 Procedure Code"
* performed[x] ^short = "PR1-5 Procedure Date/Time"
