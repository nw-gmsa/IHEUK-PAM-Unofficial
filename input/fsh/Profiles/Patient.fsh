Profile:     PAMPatient
Parent:      $patient-eu
Id:          PAMPatient
Title:       "PAM Patient"
Description: """
Patient demographics conveyed by IHE PAM [ITI-30](ITI-30.html) and [ITI-31](ITI-31.html): HL7 v2.5.1 `PID`, `PD1`, and the UK `ZU1-10` and `ZU8` fields.

Based on [HL7 Europe Patient](http://hl7.eu/fhir/base/StructureDefinition/patient-eu). `patient-eu` is used rather than `patient-eu-core` because HSCIC ITK `PID-7` Date of Birth is RE (required but may be empty), whereas `patient-eu-core` requires `birthDate`.
"""

* extension contains
    $UKCore-EthnicCategory named ethnicCategory 0..1 MS and
    http://hl7.org/fhir/StructureDefinition/patient-mothersMaidenName named mothersMaidenName 0..1 and
    http://hl7.org/fhir/StructureDefinition/patient-religion named religion 0..1 and
    OverseasVisitorStatus named overseasVisitorStatus 0..1 and
    LocationHiding named locationHiding 0..1 MS and
    IdentityUnknownIndicator named identityUnknown 0..1
* extension[ethnicCategory] ^short = "PID-22 Ethnic Group"
* extension[mothersMaidenName] ^short = "PID-6 Mother's Maiden Name"
* extension[religion] ^short = "PID-17 Religion"
* extension[overseasVisitorStatus] ^short = "ZU1-10 Overseas Visitor Status"
* extension[locationHiding] ^short = "ZU8-4 Location Hiding"
* extension[identityUnknown] ^short = "PID-31 Identity Unknown Indicator"
* extension[birthPlace] ^short = "PID-23 Birth Place"
* extension[patient-citizenship] ^short = "PID-26 Citizenship (NOT Overseas Visitor Status)"
* extension[patient-nationality] ^short = "PID-28 Nationality"
* extension[birthTime] ^short = "PID-7 Date/Time of Birth (time component)"

* identifier 1..* MS
* identifier only PAMIdentifier
* identifier ^short = "PID-3 Patient Identifier List"
* identifier ^slicing.discriminator.type = #pattern
* identifier ^slicing.discriminator.path = "type"
* identifier ^slicing.rules = #open
* identifier ^slicing.description = "Slice based on the CX-5 identifier type"
* identifier ^slicing.ordered = false
* identifier contains
    nhsNumber 0..1 MS and
    localPatientIdentifier 0..* MS
* identifier[nhsNumber] only NHSNumber
* identifier[nhsNumber] ^short = "NHS Number. MUST be present where a traced NHS Number is available"
* identifier[nhsNumber] insert SupplierPopulateIfKnown
* identifier[localPatientIdentifier] only LocalPatientIdentifier
* identifier[localPatientIdentifier] ^short = "Local patient identifier (hospital number / MRN)"

* active MS

* name 1..* MS
* name ^short = "PID-5 Patient Name (XPN). Alias names are sent in PID-5 with XPN-7 = A, not PID-9"
* name.use 1..1 MS
* name.use ^short = "XPN-7 Name Type Code (see ConceptMap HSCIC Name Type to FHIR Name Use)"
* name.family 1..1 MS
* name.family ^short = "XPN-1 Family Name. The literal 'Unknown' is used if the legal name is not known"
* name.family ^maxLength = 35
* name.given MS
* name.given ^short = "XPN-2 Given Name and XPN-3 Second and Further Given Names"
* name.prefix ^short = "XPN-5 Prefix"
* name.suffix ^short = "XPN-4 Suffix"

* telecom MS
* telecom ^short = "PID-13 Phone Number - Home and PID-14 Phone Number - Business (XTN)"

* gender MS
* gender ^short = "PID-8 Administrative Sex"
* gender insert SupplierPopulateIfKnown

* birthDate MS
* birthDate ^short = "PID-7 Date/Time of Birth (RE)"
* birthDate insert SupplierPopulateIfKnown

* deceased[x] MS
* deceased[x] ^short = "PID-29 Patient Death Date and Time / PID-30 Patient Death Indicator"

* address MS
* address ^short = "PID-11 Patient Address (XAD)"
* address.line ^short = "XAD-1 Street Address and XAD-2 Other Designation"
* address.city ^short = "XAD-3 City"
* address.district ^short = "XAD-4 State or Province (County)"
* address.postalCode MS
* address.postalCode ^short = "XAD-5 Zip or Postal Code"
* address.postalCode ^maxLength = 8
* address.use ^short = "XAD-7 Address Type (H, TMP). PST (correspondence) is Address.type = postal"

* maritalStatus from $VS-UKCore-PersonMaritalStatusCode (extensible)
* maritalStatus ^short = "PID-16 Marital Status"

* multipleBirth[x] ^short = "PID-24 Multiple Birth Indicator (boolean) / PID-25 Birth Order (integer)"

* communication.language ^short = "PID-15 Primary Language"

* generalPractitioner MS
* generalPractitioner only Reference(PAMOrganization or PAMPractitioner)
* generalPractitioner ^short = "PD1-3 Patient Primary Facility (GP Practice) and PD1-4 Patient Primary Care Provider (GP)"
* generalPractitioner ^comment = "The first PD1-3 repetition is the GP Practice, a Reference(PAMOrganization) with identifier = ODS code. PD1-4 is the registered GP, a Reference(PAMPractitioner) with identifier = national GP code (gmp-number). Identifier-only (logical) references are acceptable."

* link MS
* link ^short = "MRG-1 Prior Patient ID (ADT^A40 Merge). The surviving patient 'replaces' the non-surviving patient"

Mapping:  PAMPatientToV2
Source:   PAMPatient
Target:   "http://hl7.org/v2"
Id:       hl7v2
Title:    "HL7 v2.5.1 (HSCIC ITK)"
* -> "PID"
* identifier -> "PID-3 (and PID-4 temporary number)"
* identifier[nhsNumber] -> "PID-3 where CX-5 = NH"
* identifier[nhsNumber].extension[nhsNumberVerificationStatus] -> "PID-32 NSTSnn"
* name -> "PID-5"
* extension[mothersMaidenName] -> "PID-6"
* birthDate -> "PID-7"
* gender -> "PID-8"
* address -> "PID-11"
* telecom -> "PID-13, PID-14"
* communication.language -> "PID-15"
* maritalStatus -> "PID-16"
* extension[religion] -> "PID-17"
* extension[ethnicCategory] -> "PID-22"
* extension[birthPlace] -> "PID-23"
* multipleBirth[x] -> "PID-24, PID-25"
* extension[patient-citizenship] -> "PID-26"
* extension[patient-nationality] -> "PID-28"
* deceased[x] -> "PID-29, PID-30"
* extension[identityUnknown] -> "PID-31"
* generalPractitioner -> "PD1-3, PD1-4"
* extension[overseasVisitorStatus] -> "ZU1-10"
* extension[locationHiding] -> "ZU8-4"
* link -> "MRG-1"
