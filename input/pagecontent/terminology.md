The HSCIC ITK *Reference Tables* (NPFIT-ELIBR-AREL-DST-0376) define the values allowed in the ADT messages. Most of them are **NHS Data Dictionary** attributes that replace or extend the international HL7 tables. HSCIC labelled many of these tables "Differs - discuss with HL7 UK / IHE UK".

This guide takes the following approach:

1. Where **UK Core** already publishes the NHS Data Dictionary attribute as a FHIR CodeSystem, it is reused rather than redefined.
2. HSCIC tables with no UK Core equivalent are published as CodeSystems in this guide.
3. **ConceptMaps** relate the international HL7 v2 tables (which IHE PAM requires for v2.5.1) to the NHS values and to FHIR.

### Key tables

| Table | Name | v2 field(s) | NHS Data Dictionary | FHIR CodeSystem | ConceptMap |
|-------|------|-------------|---------------------|-----------------|------------|
| 0001 | Administrative Sex | PID-8, NK1-15 | Person Gender Code | [HSCIC Administrative Sex](CodeSystem-hscic-administrative-sex.html) → FHIR administrative-gender | [HSCIC→FHIR](ConceptMap-HSCICSexToFHIRGender.html), [HL7→HSCIC](ConceptMap-HL7SexToHSCICSex.html) |
| 0002 | Marital Status | PID-16 | Person Marital Status | UK Core `UKCore-PersonMaritalStatusEngland` | [HL7→NHS](ConceptMap-HL7MaritalStatusToNHSMaritalStatus.html) |
| 0004 | Patient Class | PV1-2 | - | [HSCIC Patient Class](CodeSystem-hscic-patient-class.html) | [HSCIC→FHIR](ConceptMap-HSCICPatientClassToFHIR.html) |
| 0007 | Admission Type | PV1-4 | Admission Method | UK Core `UKCore-AdmissionMethodEngland` | [HL7→NHS](ConceptMap-HL7AdmissionTypeToNHSAdmissionMethod.html) |
| 0023 | Admit Source | PV1-14 | Source of Admission | UK Core `UKCore-SourceOfAdmissionEngland` | [HL7→NHS](ConceptMap-HL7AdmitSourceToNHSSourceOfAdmission.html) |
| 0063 | Relationship | NK1-3 | PDS Relationship Type | [HSCIC Relationship](CodeSystem-hscic-relationship.html) | [HL7→HSCIC](ConceptMap-HL7RelationshipToHSCICRelationship.html) |
| 0112 | Discharge Disposition | PV1-36 | Discharge Method / A&E Attendance Disposal | UK Core `UKCore-DischargeMethodEngland` (admitted care); [HSCIC Discharge Disposition](CodeSystem-hscic-discharge-disposition.html) (the HSCIC table as published) | |
| 0113 | Discharged to Location | PV1-37 | Discharge Destination | UK Core `UKCore-DischargeDestinationEngland` | (same codes) |
| 0171 | Overseas Visitor Status | ZU1-10 | Overseas Visitor Status Classification | [Overseas Visitor Status](CodeSystem-overseas-visitor-status.html) | |
| 0189 | Ethnic Group | PID-22 | Ethnic Category | UK Core `UKCore-EthnicCategoryEngland` | (same codes) |
| 0190 | Address Type | XAD-7 | PDS Address Use | [HSCIC Address Type](CodeSystem-hscic-address-type.html) | [HSCIC→FHIR](ConceptMap-HSCICAddressTypeToFHIR.html) |
| 0200 | Name Type | XPN-7 | PDS Name Type | [HSCIC Name Type](CodeSystem-hscic-name-type.html) | [HSCIC→FHIR](ConceptMap-HSCICNameTypeToFHIR.html) |
| 0445 | Identity Reliability | PID-32 | NHS Number Status Indicator | [HSCIC Identity Reliability](CodeSystem-hscic-identity-reliability.html) | [→UK Core NHS Number Verification Status](ConceptMap-HSCICIdentityReliabilityToNHSNumberStatus.html) |
| ZU032 | Sexual Orientation | ZU8-1 | Sexual Orientation | [Sexual Orientation](CodeSystem-sexual-orientation.html) | |
| ZU051 | Intended Management | ZU1-2 | Intended Management | [Intended Management](CodeSystem-intended-management.html) | |
| ZU056 | DCR Consent to Share | ZU8-2 | PDS Consent to Share | [DCR Consent to Share](CodeSystem-dcr-consent-to-share.html) | |
| ZU057 | Location Hiding | ZU8-4 | - | [Location Hiding](CodeSystem-location-hiding.html) | |
| ZU058 | SCR Consent to Store | ZU8-3 | - | [SCR Consent to Store](CodeSystem-scr-consent-to-store.html) | |
{:.grid}

### Other tables

The remaining HSCIC tables are not yet published as FHIR resources. They are listed here with their source, for future elaboration:

| Group | Tables | Source |
|-------|--------|--------|
| HL7 standard tables, used unchanged | 0003, 0008, 0076, 0085, 0103, 0104, 0125, 0136, 0155, 0201, 0202, 0211, 0354, 0357, 0396, 0399 (ISO 3166 alpha-3) | HL7 Terminology (THO) `v2-xxxx` CodeSystems |
| NHS Data Dictionary | 0006 Religion, 0069 Hospital Service (Treatment Function), 0092 Re-admission, 0114 Diet, 0217 Visit Priority, 0296 Language (ISO 639-1), 0430 Mode of Arrival | NHS DD, UK Core where available |
| Clinical coding | 0051 Diagnosis (ICD-10), 0088 Procedure (OPCS-4), ZU002 Allergy | ICD-10, OPCS-4, SNOMED CT (UK edition) |
| Locally defined | 0010 Physician ID, 0361/0362 Application/Facility, 0363 Assigning Authority | ODS, GMC, local agreement |
| Commissioning (ZU) | ZU001-ZU055 (except those above) | NHS DD (CDS) |
{:.grid}

