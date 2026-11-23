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
* focus[+] = Reference(urn:uuid:5b0e6c2e-6a2f-4a85-9d1e-0d3e7c3a0a28)

Instance:    Bundle-ADT-A28
InstanceOf:  PAMBundleMessage
Title:       "Message - ADT^A28 Create New Patient [ITI-30]"
Description: "FHIR Message equivalent of ADT^A28^ADT_A05"
Usage:       #example
* insert MessageBundle("urn:uuid:2d1b9b5e-58ef-4c3c-9a3e-6c4b8e0f0a28", "2026-11-19T15:30:00Z")
* insert Entry("urn:uuid:7f1a3c55-1c0d-4e1b-8f5e-3a2b6c1d0a28", MessageHeader-A28)
* insert Entry("urn:uuid:5b0e6c2e-6a2f-4a85-9d1e-0d3e7c3a0a28", Patient-OctaviaCHISLETT-9449305552)
* insert Entry("urn:uuid:a3c1e2d4-7b8f-4e6a-9c0d-1e2f3a4b0a28", RelatedPerson-NOK)

Instance:    MessageHeader-A01
InstanceOf:  PAMMessageHeader
Title:       "Message Header - A01"
Usage:       #inline
* insert PAMHeader(A01)
* focus[+] = Reference(urn:uuid:9c8d7e6f-5a4b-4c3d-8e2f-1a0b9c8d0a01)

Instance:    Bundle-ADT-A01
InstanceOf:  PAMBundleMessage
Title:       "Message - ADT^A01 Admit Inpatient [ITI-31]"
Description: "FHIR Message equivalent of ADT^A01^ADT_A01"
Usage:       #example
* insert MessageBundle("urn:uuid:0e3f6a1b-2c4d-4e5f-8a9b-7c6d5e4f0a01", "2026-11-20T10:16:02Z")
* insert Entry("urn:uuid:1f2e3d4c-5b6a-4978-8a9b-0c1d2e3f0a01", MessageHeader-A01)
* insert Entry("urn:uuid:2a3b4c5d-6e7f-4a8b-9c0d-1e2f3a4b0a01", Provenance-A01)
* insert Entry("urn:uuid:5b0e6c2e-6a2f-4a85-9d1e-0d3e7c3a0a28", Patient-OctaviaCHISLETT-9449305552)
* insert Entry("urn:uuid:9c8d7e6f-5a4b-4c3d-8e2f-1a0b9c8d0a01", Encounter-Inpatient-V0001234)

Instance:    MessageHeader-A03
InstanceOf:  PAMMessageHeader
Title:       "Message Header - A03"
Usage:       #inline
* insert PAMHeader(A03)
* focus[+] = Reference(urn:uuid:9c8d7e6f-5a4b-4c3d-8e2f-1a0b9c8d0a03)

Instance:    Bundle-ADT-A03
InstanceOf:  PAMBundleMessage
Title:       "Message - ADT^A03 Discharge Patient [ITI-31]"
Description: "FHIR Message equivalent of ADT^A03^ADT_A03"
Usage:       #example
* insert MessageBundle("urn:uuid:0e3f6a1b-2c4d-4e5f-8a9b-7c6d5e4f0a03", "2026-11-23T14:01:10Z")
* insert Entry("urn:uuid:1f2e3d4c-5b6a-4978-8a9b-0c1d2e3f0a03", MessageHeader-A03)
* insert Entry("urn:uuid:5b0e6c2e-6a2f-4a85-9d1e-0d3e7c3a0a28", Patient-OctaviaCHISLETT-9449305552)
* insert Entry("urn:uuid:9c8d7e6f-5a4b-4c3d-8e2f-1a0b9c8d0a03", Encounter-Discharged-V0001234)

Instance:    MessageHeader-A40
InstanceOf:  PAMMessageHeader
Title:       "Message Header - A40"
Usage:       #inline
* insert PAMHeader(A40)
* focus[+] = Reference(urn:uuid:5b0e6c2e-6a2f-4a85-9d1e-0d3e7c3a0a40)

Instance:    Bundle-ADT-A40
InstanceOf:  PAMBundleMessage
Title:       "Message - ADT^A40 Merge Patient [ITI-30]"
Description: "FHIR Message equivalent of ADT^A40^ADT_A39. The surviving Patient (PID) links to the non-surviving Patient (MRG-1)."
Usage:       #example
* insert MessageBundle("urn:uuid:0e3f6a1b-2c4d-4e5f-8a9b-7c6d5e4f0a40", "2026-11-23T16:00:00Z")
* insert Entry("urn:uuid:1f2e3d4c-5b6a-4978-8a9b-0c1d2e3f0a40", MessageHeader-A40)
* insert Entry("urn:uuid:5b0e6c2e-6a2f-4a85-9d1e-0d3e7c3a0a40", Patient-Merged-OctaviaCHISLETT)
* insert Entry("urn:uuid:6c1f7d3f-7b3a-4b96-8e2f-1e4f8d4b0a40", Patient-Duplicate-MRN999999)
