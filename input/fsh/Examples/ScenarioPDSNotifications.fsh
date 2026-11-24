// Example Scenario: PDS Notifications (MNS) - Example 3 NHS Number change (nhs-number-change-2) as ADT^A40.
// Patient.link.other uses the NHS Number (Reference.identifier), not a literal reference, so that receivers
// can resolve the linked record against their own patient index.

Instance:    Patient-PDS-OctaviaCHISLETT-9449310602
InstanceOf:  PAMPatient
Title:       "Patient - Octavia CHISLETT, surviving record after NHS Number change (A40 PID)"
Description: "PID of the PDS scenario ADT^A40: the new NHS Number 9449310602 returned by PDS and the unchanged MRN. It replaces the record identified by the superseded NHS Number 9449305552."
Usage:       #example
* extension[locationHiding].valueCodeableConcept = LocationHidingCS#0 "No location hiding"
* active = true
* identifier[nhsNumber].use = #official
* identifier[nhsNumber].type = $v2-0203#NH
* identifier[nhsNumber].system = $nhs-number
* identifier[nhsNumber].value = "9449310602"
* identifier[nhsNumber].extension[+].url = $UKCore-NHSNumberVerificationStatus
* identifier[nhsNumber].extension[=].valueCodeableConcept = $UKCore-NHSNumberVerificationStatusEngland#01 "Number present and verified"
* identifier[localPatientIdentifier].use = #usual
* identifier[localPatientIdentifier].type = $v2-0203#MR
* identifier[localPatientIdentifier].value = "MRN123456"
* identifier[localPatientIdentifier].assigner.identifier.system = $ods-code
* identifier[localPatientIdentifier].assigner.identifier.value = "R0A"
* name[+].use = #official
* name[=].family = "CHISLETT"
* name[=].given[+] = "Octavia"
* name[=].prefix[+] = "Mrs"
* gender = #female
* birthDate = "2008-09-20"
* address[+].use = #home
* address[=].line[+] = "2 New Road"
* address[=].city = "MANCHESTER"
* address[=].postalCode = "M20 2AB"
* address[=].country = "GBR"
* address[=].period.start = "2026-11-20"
* telecom[+].system = #phone
* telecom[=].value = "01632960587"
* telecom[=].use = #home
* maritalStatus = $UKCore-PersonMaritalStatusEngland#S "Single"
* communication[+].language = urn:ietf:bcp:47#en "English"
* generalPractitioner[+].identifier.system = $ods-code
* generalPractitioner[=].identifier.value = "Y00001"
* generalPractitioner[=].type = "Organization"
* generalPractitioner[=].display = "EXAMPLE GP PRACTICE"
* generalPractitioner[+].identifier.system = $gmp-number
* generalPractitioner[=].identifier.value = "G1234560"
* generalPractitioner[=].type = "Practitioner"
* link[+].other.identifier.system = $nhs-number
* link[=].other.identifier.value = "9449305552"
* link[=].other.type = "Patient"
* link[=].type = #replaces

Instance:    Patient-PDS-Superseded-9449305552
InstanceOf:  PAMPatient
Title:       "Patient - superseded NHS Number 9449305552 (A40 MRG)"
Description: "MRG-1 of the PDS scenario ADT^A40: the record identified by the superseded NHS Number. It is inactive and replaced-by the record with NHS Number 9449310602."
Usage:       #example
* active = false
* identifier[nhsNumber].use = #old
* identifier[nhsNumber].type = $v2-0203#NH
* identifier[nhsNumber].system = $nhs-number
* identifier[nhsNumber].value = "9449305552"
* name[+].use = #official
* name[=].family = "CHISLETT"
* name[=].given[+] = "Octavia"
* gender = #female
* birthDate = "2008-09-20"
* link[+].other.identifier.system = $nhs-number
* link[=].other.identifier.value = "9449310602"
* link[=].other.type = "Patient"
* link[=].type = #replaced-by

Instance:    Provenance-PDS-A40
InstanceOf:  PAMProvenance
Title:       "Event - A40 NHS Number change"
Description: "EVN of the PDS scenario ADT^A40. EVN-6 is the MNS event time."
Usage:       #example
* target[+] = Reference(Patient-PDS-OctaviaCHISLETT-9449310602)
* target[+] = Reference(Patient-PDS-Superseded-9449305552)
* occurredDateTime = "2026-11-24T14:15:00Z"
* recorded = "2026-11-24T14:15:30Z"
* activity = $v2-0003#A40
* agent[+].who = Reference(Organization-R0A)

Instance:    MessageHeader-PDS-A40
InstanceOf:  PAMMessageHeader
Title:       "Message Header - A40 NHS Number change"
Usage:       #inline
* insert PAMHeader(A40)
* focus[+] = Reference(Patient-PDS-OctaviaCHISLETT-9449310602)

Instance:    Bundle-PDS-ADT-A40-NHSNumberChange
InstanceOf:  PAMBundleMessage
Title:       "Message - ADT^A40 NHS Number change from PDS (nhs-number-change-2) [ITI-30]"
Description: "FHIR Message equivalent of the ADT^A40 in the PDS Notifications scenario (Example 3). The record with the superseded NHS Number (MRG-1) is replaced-by the record with the new NHS Number (PID-3). Patient.link.other references the linked Patient by NHS Number."
Usage:       #example
* insert MessageBundle("urn:uuid:b4413162-76d6-4ee1-98ef-dedf013a8a40", "2026-11-24T14:15:30Z")
* insert Entry("https://fhir.ihe-uk.org/ITI/PAM/MessageHeader/MessageHeader-PDS-A40", MessageHeader-PDS-A40)
* insert Entry("https://fhir.ihe-uk.org/ITI/PAM/Provenance/Provenance-PDS-A40", Provenance-PDS-A40)
* insert Entry("https://fhir.ihe-uk.org/ITI/PAM/Patient/Patient-PDS-OctaviaCHISLETT-9449310602", Patient-PDS-OctaviaCHISLETT-9449310602)
* insert Entry("https://fhir.ihe-uk.org/ITI/PAM/Patient/Patient-PDS-Superseded-9449305552", Patient-PDS-Superseded-9449305552)
