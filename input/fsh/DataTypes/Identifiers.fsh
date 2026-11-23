Profile:        PAMIdentifier
Parent:         Identifier
Id:             PAMIdentifier
Title:          "PAM Identifier (CX)"
Description:    """
Core data contract for HL7 v2.5.1 `CX` (Extended Composite ID with Check Digit) and `EI` (Entity Identifier) as a FHIR Identifier.

| CX | Component | FHIR |
|----|-----------|------|
| CX-1 | ID Number | `value` |
| CX-4 | Assigning Authority (HD) | `system`: an established identifier system URI (e.g. `https://fhir.nhs.uk/Id/nhs-number`), or the HD-2 Universal ID as `urn:oid:<OID>`. If only a local HD-1 namespace is known, `system` is omitted - **do not invent a URI** |
| CX-5 | Identifier Type Code | `type` (HL7 Table 0203) |
| CX-6 | Assigning Facility (HD) | `assigner.identifier` (ODS code) |
{:.grid}
"""

* type 0..1 MS
* type ^short = "CX-5 Identifier Type Code (HL7 Table 0203)"
* system 0..1 MS
* system ^short = "CX-4 Assigning Authority: established URI, or urn:oid: of HD-2. Omit if only a local namespace is known"
* system ^comment = "Do not invent identifier system URIs. Use an established system (e.g. NHS Number, ODS code) or the OID of the assigning authority (HD-2 Universal ID, e.g. the OID of a Trust's EPR) as urn:oid:. Where only a local namespace (HD-1) is known, omit system; the identifier is then qualified by type (CX-5) and assigner (CX-6 ODS code)."
* value 1..1 MS
* value ^short = "CX-1 ID Number. MUST be unique within the assigning authority"
* assigner 0..1 MS
* assigner ^short = "CX-6 Assigning Facility"
* assigner.identifier 1..1 MS
* assigner.identifier.system 1..1
* assigner.identifier.system = $ods-code
* assigner.identifier.value 1..1
* assigner.identifier.value ^example.valueString = "R0A"
* assigner.identifier.value ^example.label = "Manchester University NHS Foundation Trust"

Mapping:  PAMIdentifierToV2
Source:   PAMIdentifier
Target:   "http://hl7.org/v2"
Id:       hl7v2
Title:    "HL7 v2.5.1"
* value -> "CX-1"
* system -> "CX-4"
* type -> "CX-5"
* assigner -> "CX-6"

Profile:        NHSNumber
Parent:         PAMIdentifier
Id:             NHSNumber
Title:          "NHS Number"
Description:    """
NHS Number (England and Wales). Where a traced NHS Number is available for the patient it **MUST** be included in PID-3 (HSCIC ITK 5.3.1).

In HL7 v2.5.1 this is sent as `PID-3` with `CX-1` = 10 digit NHS Number, `CX-4` = `NHS&2.16.840.1.113883.2.1.4.1&ISO` and `CX-5` = `NH`. The HSCIC ITK v2.4 convention of `CX-4` = `NHS` (namespace only) remains acceptable.

The tracing status (HSCIC `PID-32` Identity Reliability Code / legacy `ZU1-27`) is carried in the UK Core NHS Number Verification Status extension.
"""
* extension contains $UKCore-NHSNumberVerificationStatus named nhsNumberVerificationStatus 0..1 MS
* extension[nhsNumberVerificationStatus] ^short = "PID-32 Identity Reliability Code (NHS Number tracing status)"
* type = $v2-0203#NH
* system = $nhs-number (exactly)
* value ^maxLength = 10
* value obeys nhs-number-format
* assigner 0..0

Invariant:   nhs-number-format
Description: "NHS Number is 10 numeric digits"
Expression:  "matches('^[0-9]{10}$')"
Severity:    #error

Profile:        LocalPatientIdentifier
Parent:         PAMIdentifier
Id:             LocalPatientIdentifier
Title:          "Local Patient Identifier (Medical Record Number)"
Description:    """
Local hospital / PAS patient number (`PID-3`, `CX-5` = `MR`). The assigning authority (`CX-4`) is the local system code, which requires mutual agreement between participating systems (HSCIC Table 0363). The assigning facility is the ODS code of the organisation.
"""
* type = $v2-0203#MR
* system ^short = "CX-4 Assigning Authority, e.g. urn:oid: of the Trust PAS/EPR. Omit if no OID is known"
* assigner 1..1

Profile:        TemporaryPatientIdentifier
Parent:         PAMIdentifier
Id:             TemporaryPatientIdentifier
Title:          "Temporary Patient Identifier"
Description:    """
HSCIC ITK `PID-4` Alternate Patient ID - **Temporary Patient Number only**. `PID-4` is retained for backwards compatibility in HL7 v2.5.1; Suppliers **SHOULD** also send this as a repeat of `PID-3`.
"""
* use = #temp
* type = $v2-0203#MR

Profile:        VisitNumber
Parent:         PAMIdentifier
Id:             VisitNumber
Title:          "Visit Number"
Description:    """
`PV1-19` Visit Number. A unique number representing the visit, which may be an admission, an A&E attendance, a community contact or an outpatient attendance (appointment). Unique within assigning authority and number type.
"""
* use = #official
* type = $v2-0203#VN
* assigner 1..1

Profile:        AlternateVisitIdentifier
Parent:         PAMIdentifier
Id:             AlternateVisitIdentifier
Title:          "Alternate Visit Identifier (Consultant Episode)"
Description:    """
`PV1-50` Alternate Visit ID. HL7 UK allows this field to further qualify the Visit ID. A typical use is a **consultant episode** within an inpatient stay: `PV1-19` identifies the inpatient stay, `PV1-50` the consultant episode.
"""
* use = #secondary

Profile:        ODSOrganisationCode
Parent:         Identifier
Id:             ODSOrganisationCode
Title:          "ODS Organisation Code"
Description:    "NHS Organisation Data Service (ODS) code. Used for `MSH-4`/`MSH-6` facilities, `PD1-3` GP practice and the `CX-6` assigning facility."
* system 1..1
* system = $ods-code (exactly)
* value 1..1

Profile:        ODSSiteCode
Parent:         Identifier
Id:             ODSSiteCode
Title:          "ODS Site Code"
Description:    "NHS ODS site code (formerly NACS). Used for `PL-4` Facility of `PV1-3` Assigned Patient Location."
* system 1..1
* system = $ods-site-code (exactly)
* value 1..1

Profile:        PractitionerIdentifier
Parent:         Identifier
Id:             PractitionerIdentifier
Title:          "Practitioner Identifier (XCN)"
Description:    """
HL7 v2.5.1 `XCN-1` ID Number for persons. HSCIC Table 0010: National GP / Consultant Code.

- GP: national GP code (G + 6 digits + check digit), system `https://fhir.hl7.org.uk/Id/gmp-number`
- Consultant: GMC number (C + 7 digits), system `https://fhir.hl7.org.uk/Id/gmc-number`
"""
* system 1..1
* system ^short = "https://fhir.hl7.org.uk/Id/gmp-number (GP) or https://fhir.hl7.org.uk/Id/gmc-number (Consultant)"
* value 1..1
