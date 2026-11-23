RuleSet: PAMHeader(event)
* eventCoding = $v2-0003#{event}
* source.name = "PAS"
* source.endpoint = "https://pas.example-trust.nhs.uk/hl7"
* sender = Reference(Organization-R0A)
* sender.identifier.system = $ods-code
* sender.identifier.value = "R0A"
* destination[+].name = "ROUTE"
* destination[=].endpoint = "https://integration.example-trust.nhs.uk/hl7"

Instance:    MessageHeader-A28
InstanceOf:  PAMMessageHeader
Title:       "Message Header - A28"
Usage:       #inline
* insert PAMHeader(A28)
* focus[+] = Reference(Patient-OctaviaCHISLETT-9449305552)

Instance:    Bundle-ADT-A28
InstanceOf:  PAMBundleMessage
Title:       "Message - ADT^A28 Create New Patient [ITI-30]"
Description: "FHIR Message equivalent of ADT^A28^ADT_A05"
Usage:       #example
* insert MessageBundle("urn:uuid:2d1b9b5e-58ef-4c3c-9a3e-6c4b8e0f0a28", "2026-11-19T15:30:00Z")
* insert Entry("https://fhir.ihe-uk.org/ITI/PAM/MessageHeader/MessageHeader-A28", MessageHeader-A28)
* insert Entry("https://fhir.ihe-uk.org/ITI/PAM/Patient/Patient-OctaviaCHISLETT-9449305552", Patient-OctaviaCHISLETT-9449305552)
* insert Entry("https://fhir.ihe-uk.org/ITI/PAM/RelatedPerson/RelatedPerson-NOK", RelatedPerson-NOK)

Instance:    MessageHeader-A01
InstanceOf:  PAMMessageHeader
Title:       "Message Header - A01"
Usage:       #inline
* insert PAMHeader(A01)
* focus[+] = Reference(Encounter-Inpatient-V0001234)

Instance:    Bundle-ADT-A01
InstanceOf:  PAMBundleMessage
Title:       "Message - ADT^A01 Admit Inpatient [ITI-31]"
Description: "FHIR Message equivalent of ADT^A01^ADT_A01"
Usage:       #example
* insert MessageBundle("urn:uuid:0e3f6a1b-2c4d-4e5f-8a9b-7c6d5e4f0a01", "2026-11-20T10:16:02Z")
* insert Entry("https://fhir.ihe-uk.org/ITI/PAM/MessageHeader/MessageHeader-A01", MessageHeader-A01)
* insert Entry("https://fhir.ihe-uk.org/ITI/PAM/Provenance/Provenance-A01", Provenance-A01)
* insert Entry("https://fhir.ihe-uk.org/ITI/PAM/Patient/Patient-OctaviaCHISLETT-9449305552", Patient-OctaviaCHISLETT-9449305552)
* insert Entry("https://fhir.ihe-uk.org/ITI/PAM/Encounter/Encounter-Inpatient-V0001234", Encounter-Inpatient-V0001234)

Instance:    MessageHeader-A03
InstanceOf:  PAMMessageHeader
Title:       "Message Header - A03"
Usage:       #inline
* insert PAMHeader(A03)
* focus[+] = Reference(Encounter-Discharged-V0001234)

Instance:    Bundle-ADT-A03
InstanceOf:  PAMBundleMessage
Title:       "Message - ADT^A03 Discharge Patient [ITI-31]"
Description: "FHIR Message equivalent of ADT^A03^ADT_A03"
Usage:       #example
* insert MessageBundle("urn:uuid:0e3f6a1b-2c4d-4e5f-8a9b-7c6d5e4f0a03", "2026-11-23T14:01:10Z")
* insert Entry("https://fhir.ihe-uk.org/ITI/PAM/MessageHeader/MessageHeader-A03", MessageHeader-A03)
* insert Entry("https://fhir.ihe-uk.org/ITI/PAM/Patient/Patient-OctaviaCHISLETT-9449305552", Patient-OctaviaCHISLETT-9449305552)
* insert Entry("https://fhir.ihe-uk.org/ITI/PAM/Encounter/Encounter-Discharged-V0001234", Encounter-Discharged-V0001234)

Instance:    MessageHeader-A40
InstanceOf:  PAMMessageHeader
Title:       "Message Header - A40"
Usage:       #inline
* insert PAMHeader(A40)
* focus[+] = Reference(Patient-Merged-OctaviaCHISLETT)

Instance:    Bundle-ADT-A40
InstanceOf:  PAMBundleMessage
Title:       "Message - ADT^A40 Merge Patient [ITI-30]"
Description: "FHIR Message equivalent of ADT^A40^ADT_A39. The surviving Patient (PID) links to the non-surviving Patient (MRG-1)."
Usage:       #example
* insert MessageBundle("urn:uuid:0e3f6a1b-2c4d-4e5f-8a9b-7c6d5e4f0a40", "2026-11-23T16:00:00Z")
* insert Entry("https://fhir.ihe-uk.org/ITI/PAM/MessageHeader/MessageHeader-A40", MessageHeader-A40)
* insert Entry("https://fhir.ihe-uk.org/ITI/PAM/Patient/Patient-Merged-OctaviaCHISLETT", Patient-Merged-OctaviaCHISLETT)
* insert Entry("https://fhir.ihe-uk.org/ITI/PAM/Patient/Patient-Duplicate-MRN999999", Patient-Duplicate-MRN999999)
