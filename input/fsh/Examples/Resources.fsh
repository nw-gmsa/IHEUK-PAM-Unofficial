Instance:    Organization-R0A
InstanceOf:  PAMOrganization
Title:       "Organization - Manchester University NHS Foundation Trust"
Description: "Sending facility (MSH-4) and assigning facility (CX-6)"
Usage:       #example
* identifier[+].system = $ods-code
* identifier[=].value = "R0A"
* name = "MANCHESTER UNIVERSITY NHS FOUNDATION TRUST"

Instance:    Organization-Y00001
InstanceOf:  PAMOrganization
Title:       "Organization - GP Practice"
Description: "PD1-3 Patient Primary Facility (GP Practice). Uses the HSCIC ITK example code Y00001."
Usage:       #example
* identifier[+].system = $ods-code
* identifier[=].value = "Y00001"
* name = "EXAMPLE GP PRACTICE"

Instance:    Practitioner-G1234560
InstanceOf:  PAMPractitioner
Title:       "Practitioner - Registered GP"
Description: "PD1-4 Patient Primary Care Provider. Uses the HSCIC ITK example national GP code G1234560."
Usage:       #example
* identifier[+].system = $gmp-number
* identifier[=].value = "G1234560"
* name[+].family = "SMITH"
* name[=].given[+] = "Jane"
* name[=].prefix[+] = "Dr"

Instance:    Practitioner-C1234567
InstanceOf:  PAMPractitioner
Title:       "Practitioner - Consultant"
Description: "PV1-9 Consulting Doctor / PV1-17 Admitting Doctor (GMC number)"
Usage:       #example
* identifier[+].system = $gmc-number
* identifier[=].value = "C1234567"
* name[+].family = "JONES"
* name[=].given[+] = "Alan"
* name[=].prefix[+] = "Dr"

Instance:    Location-Ward-W12
InstanceOf:  PAMLocation
Title:       "Location - Ward W12 Bed 3"
Description: "PV1-3 Assigned Patient Location ^W12^3^RW3MR (point of care, ward, bed, facility)"
Usage:       #example
* identifier[+].system = "https://fhir.example-trust.nhs.uk/Id/ward-code"
* identifier[=].value = "W12"
* name = "Ward 12"
* physicalType = http://terminology.hl7.org/CodeSystem/location-physical-type#wa
* managingOrganization.identifier.system = $ods-code
* managingOrganization.identifier.value = "R0A"

Instance:    Patient-OctaviaCHISLETT-9449305552
InstanceOf:  PAMPatient
Title:       "Patient - Octavia CHISLETT"
Description: "Patient demographics (PID, PD1) for test NHS Number 9449305552."
Usage:       #example
* extension[+].url = $UKCore-EthnicCategory
* extension[=].valueCodeableConcept = $UKCore-EthnicCategoryEngland#A "British, Mixed British"
* extension[locationHiding].valueCodeableConcept = LocationHidingCS#0 "No location hiding"
* identifier[nhsNumber].system = $nhs-number
* identifier[nhsNumber].value = "9449305552"
* identifier[nhsNumber].extension[+].url = $UKCore-NHSNumberVerificationStatus
* identifier[nhsNumber].extension[=].valueCodeableConcept = $UKCore-NHSNumberVerificationStatusEngland#01 "Number present and verified"
* identifier[localPatientIdentifier].system = "https://fhir.example-trust.nhs.uk/Id/mrn"
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
* address[=].line[+] = "1 Example Street"
* address[=].city = "MANCHESTER"
* address[=].postalCode = "M13 9WL"
* address[=].country = "GBR"
* telecom[+].system = #phone
* telecom[=].value = "01632960587"
* telecom[=].use = #home
* maritalStatus = $UKCore-PersonMaritalStatusEngland#S "Single"
* communication[+].language = urn:ietf:bcp:47#en "English"
* generalPractitioner[+] = Reference(Organization-Y00001)
* generalPractitioner[=].identifier.system = $ods-code
* generalPractitioner[=].identifier.value = "Y00001"
* generalPractitioner[+] = Reference(Practitioner-G1234560)
* generalPractitioner[=].identifier.system = $gmp-number
* generalPractitioner[=].identifier.value = "G1234560"

Instance:    RelatedPerson-NOK
InstanceOf:  PAMRelatedPerson
Title:       "Related Person - Next of Kin"
Description: "NK1 Next of Kin of Octavia CHISLETT"
Usage:       #example
* patient = Reference(Patient-OctaviaCHISLETT-9449305552)
* relationship[+] = HSCICRelationship#12 "Mother"
* name[+].family = "CHISLETT"
* name[=].given[+] = "Mary"
* telecom[+].system = #phone
* telecom[=].value = "07700900123"
* telecom[=].use = #mobile

Instance:    Encounter-Inpatient-V0001234
InstanceOf:  PAMEncounter
Title:       "Encounter - Inpatient Admission (A01)"
Description: "PV1/PV2/ZU1 for an emergency inpatient admission via A&E"
Usage:       #example
* extension[decisionToAdmit].valueDateTime = "2026-11-20T09:45:00Z"
* extension[intendedManagement].valueCodeableConcept = IntendedManagementCS#1 "Patient to stay in hospital for at least one night"
* identifier[visitNumber].system = "https://fhir.example-trust.nhs.uk/Id/visit-number"
* identifier[visitNumber].value = "V0001234"
* identifier[visitNumber].assigner.identifier.system = $ods-code
* identifier[visitNumber].assigner.identifier.value = "R0A"
* status = #in-progress
* class = $v3-ActCode#IMP "inpatient encounter"
* subject = Reference(Patient-OctaviaCHISLETT-9449305552)
* participant[consultingDoctor].individual = Reference(Practitioner-C1234567)
* participant[admittingDoctor].individual = Reference(Practitioner-C1234567)
* period.start = "2026-11-20T10:15:00Z"
* hospitalization.extension[+].url = $UKCore-AdmissionMethod
* hospitalization.extension[=].valueCodeableConcept = $UKCore-AdmissionMethodEngland#21 "Emergency Admission: Emergency Care Department or dental casualty department of the Health Care Provider"
* hospitalization.admitSource = $UKCore-SourceOfAdmissionEngland#19 "Usual place of residence"
* location[+].location = Reference(Location-Ward-W12)
* location[=].status = #active
* location[=].period.start = "2026-11-20T10:15:00Z"
* serviceProvider = Reference(Organization-R0A)

Instance:    Encounter-Discharged-V0001234
InstanceOf:  PAMEncounter
Title:       "Encounter - Discharged (A03)"
Description: "PV1 for the same inpatient spell after discharge"
Usage:       #example
* identifier[visitNumber].system = "https://fhir.example-trust.nhs.uk/Id/visit-number"
* identifier[visitNumber].value = "V0001234"
* identifier[visitNumber].assigner.identifier.system = $ods-code
* identifier[visitNumber].assigner.identifier.value = "R0A"
* status = #finished
* class = $v3-ActCode#IMP "inpatient encounter"
* subject = Reference(Patient-OctaviaCHISLETT-9449305552)
* participant[consultingDoctor].individual = Reference(Practitioner-C1234567)
* period.start = "2026-11-20T10:15:00Z"
* period.end = "2026-11-23T14:00:00Z"
* extension[+].url = $UKCore-DischargeMethod
* extension[=].valueCodeableConcept = $UKCore-DischargeMethodEngland#1 "Patient discharged on clinical advice or with clinical consent"
* hospitalization.extension[+].url = $UKCore-AdmissionMethod
* hospitalization.extension[=].valueCodeableConcept = $UKCore-AdmissionMethodEngland#21 "Emergency Admission: Emergency Care Department or dental casualty department of the Health Care Provider"
* hospitalization.dischargeDisposition = $UKCore-DischargeDestinationEngland#19 "Usual place of residence"
* location[+].location = Reference(Location-Ward-W12)
* location[=].status = #completed
* location[=].period.start = "2026-11-20T10:15:00Z"
* location[=].period.end = "2026-11-23T14:00:00Z"
* serviceProvider = Reference(Organization-R0A)

Instance:    Provenance-A01
InstanceOf:  PAMProvenance
Title:       "Event - A01 Admit"
Description: "EVN for the A01 admission"
Usage:       #example
* target[+] = Reference(Encounter-Inpatient-V0001234)
* occurredDateTime = "2026-11-20T10:15:00Z"
* recorded = "2026-11-20T10:16:02Z"
* activity = $v2-0003#A01
* agent[+].who = Reference(Organization-R0A)

Instance:    Patient-Duplicate-MRN999999
InstanceOf:  PAMPatient
Title:       "Patient - Non-surviving duplicate (A40)"
Description: "The duplicate record (MRG-1) merged into Octavia CHISLETT by ADT^A40"
Usage:       #example
* active = false
* identifier[localPatientIdentifier].system = "https://fhir.example-trust.nhs.uk/Id/mrn"
* identifier[localPatientIdentifier].value = "MRN999999"
* identifier[localPatientIdentifier].assigner.identifier.system = $ods-code
* identifier[localPatientIdentifier].assigner.identifier.value = "R0A"
* name[+].use = #official
* name[=].family = "CHISLETT"
* name[=].given[+] = "Octavia"
* gender = #female
* birthDate = "2008-09-20"
* link[+].other = Reference(Patient-OctaviaCHISLETT-9449305552)
* link[=].type = #replaced-by

Instance:    Patient-Merged-OctaviaCHISLETT
InstanceOf:  PAMPatient
Title:       "Patient - Surviving record after merge (A40)"
Description: "Surviving patient (PID) of an ADT^A40 merge, with link to the non-surviving record (MRG-1)"
Usage:       #example
* identifier[nhsNumber].system = $nhs-number
* identifier[nhsNumber].value = "9449305552"
* identifier[localPatientIdentifier].system = "https://fhir.example-trust.nhs.uk/Id/mrn"
* identifier[localPatientIdentifier].value = "MRN123456"
* identifier[localPatientIdentifier].assigner.identifier.system = $ods-code
* identifier[localPatientIdentifier].assigner.identifier.value = "R0A"
* name[+].use = #official
* name[=].family = "CHISLETT"
* name[=].given[+] = "Octavia"
* gender = #female
* birthDate = "2008-09-20"
* link[+].other = Reference(Patient-Duplicate-MRN999999)
* link[=].type = #replaces
