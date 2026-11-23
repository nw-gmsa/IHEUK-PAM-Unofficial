// PDQm, PIXm and PMIR examples. They reuse the shared HSCIC example patient (Patient-EDITESTPATIENT-TEN-9999999557,
// generated in Examples/HSCIC/HSCICMessages.fsh), whose only identifier is the NHS Number, and the ADT^A40
// non-surviving record (hscic-a40-identity-prior-patient).

Alias: $PDQmResponse = https://profiles.ihe.net/ITI/PDQm/StructureDefinition/IHE.PDQm.QueryPatientResourceResponseMessage
Alias: $PIXmOut = https://profiles.ihe.net/ITI/PIXm/StructureDefinition/IHE.PIXm.Query.Parameters.Out
Alias: $PMIRBundle = https://profiles.ihe.net/ITI/PMIR/StructureDefinition/IHE.PMIR.Bundle
Alias: $PMIRHistory = https://profiles.ihe.net/ITI/PMIR/StructureDefinition/IHE.PMIR.Bundle.History
Alias: $PMIRMessageHeader = https://profiles.ihe.net/ITI/PMIR/StructureDefinition/IHE.PMIR.MessageHeader

Instance:    pdqm-search-nhs-number
InstanceOf:  $PDQmResponse
Title:       "PDQm [ITI-78] response - search by NHS Number"
Description: "Response to GET [base]/Patient?identifier=https://fhir.nhs.uk/Id/nhs-number|9999999557 - the FHIR equivalent of the HSCIC ITK QBP^Q21 Get Person Demographics query"
Usage:       #example
* type = #searchset
* total = 1
* link[+].relation = "self"
* link[=].url = "http://example.org/fhir/Patient?identifier=https://fhir.nhs.uk/Id/nhs-number|9999999557"
* entry[Patient][+].fullUrl = "https://fhir.ihe-uk.org/ITI/PAM/Patient/Patient-EDITESTPATIENT-TEN-9999999557"
* entry[Patient][=].resource = Patient-EDITESTPATIENT-TEN-9999999557
* entry[Patient][=].search.mode = #match

Instance:    pixm-query-nhs-number
InstanceOf:  $PIXmOut
Title:       "PIXm [ITI-83] response - cross-reference an NHS Number"
Description: "Response to GET [base]/Patient/$ihe-pix?sourceIdentifier=https://fhir.nhs.uk/Id/nhs-number|9999999557 - the FHIR equivalent of the PIX Query [ITI-9]. The source identifier is not returned; the Patient resource held by the Manager is returned as targetId."
Usage:       #example
* parameter[+].name = "targetId"
* parameter[=].valueReference = Reference(Patient-EDITESTPATIENT-TEN-9999999557)

// ---- PMIR [ITI-93] Mobile Patient Identity Feed: ADT^A40 merge

Instance:    pmir-a40-header
InstanceOf:  $PMIRMessageHeader
Title:       "PMIR MessageHeader - merge (ADT^A40)"
Usage:       #inline
* eventUri = "urn:ihe:iti:pmir:2019:patient-feed"
* definition = "https://profiles.ihe.net/ITI/PMIR/MessageDefinition/IHE.PMIR.MessageDefinition"
* source.name = "PAS"
* source.endpoint = "http://example.org/fhir/PAS"
* sender.identifier.system = $ods-code
* sender.identifier.value = "RCB"
* destination[+].name = "Patient Identity Registry"
* destination[=].endpoint = "http://example.org/fhir/Registry"
* focus = Reference(pmir-a40-history)

Instance:    pmir-a40-history
InstanceOf:  $PMIRHistory
Title:       "PMIR history Bundle - merge (ADT^A40)"
Usage:       #inline
* type = #history
* entry[PMIREntryUpdate][+].fullUrl = "https://fhir.ihe-uk.org/ITI/PAM/Patient/hscic-a40-identity-prior-patient"
* entry[PMIREntryUpdate][=].resource = hscic-a40-identity-prior-patient
* entry[PMIREntryUpdate][=].request.method = #PUT
* entry[PMIREntryUpdate][=].request.url = "Patient/hscic-a40-identity-prior-patient"
* entry[PMIREntryUpdate][=].response.status = "200"
* entry[PMIREntryUpdate][+].fullUrl = "https://fhir.ihe-uk.org/ITI/PAM/Patient/Patient-EDITESTPATIENT-TEN-9999999557"
* entry[PMIREntryUpdate][=].resource = Patient-EDITESTPATIENT-TEN-9999999557
* entry[PMIREntryUpdate][=].request.method = #PUT
* entry[PMIREntryUpdate][=].request.url = "Patient/Patient-EDITESTPATIENT-TEN-9999999557"
* entry[PMIREntryUpdate][=].response.status = "200"

Instance:    pmir-feed-merge-a40
InstanceOf:  $PMIRBundle
Title:       "PMIR [ITI-93] Mobile Patient Identity Feed - merge (ADT^A40)"
Description: "PMIR equivalent of the HSCIC ITK ADT^A40 merge example: the non-surviving record (MRG-1) is deprecated (active = false, link replaced-by the surviving Patient) and the surviving Patient (PID) is updated. Compare the PAM FHIR Message hscic-a40-identity."
Usage:       #example
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:7d0e3c5a-4b8a-4f3e-9c21-6a5f0b2e9a40"
* type = #message
* timestamp = "2010-01-25T12:15:00+00:00"
* entry[PMIRMessageHeaderEntry].fullUrl = "https://fhir.ihe-uk.org/ITI/PAM/MessageHeader/pmir-a40-header"
* entry[PMIRMessageHeaderEntry].resource = pmir-a40-header
* entry[PMIRBundleHistoryEntry].fullUrl = "https://fhir.ihe-uk.org/ITI/PAM/Bundle/pmir-a40-history"
* entry[PMIRBundleHistoryEntry].resource = pmir-a40-history

// ---- PMIR [ITI-93] Mobile Patient Identity Feed: ADT^A28 create

Instance:    pmir-a28-header
InstanceOf:  $PMIRMessageHeader
Title:       "PMIR MessageHeader - create (ADT^A28)"
Usage:       #inline
* eventUri = "urn:ihe:iti:pmir:2019:patient-feed"
* definition = "https://profiles.ihe.net/ITI/PMIR/MessageDefinition/IHE.PMIR.MessageDefinition"
* source.name = "PAS"
* source.endpoint = "http://example.org/fhir/PAS"
* sender.identifier.system = $ods-code
* sender.identifier.value = "RCB"
* destination[+].name = "Patient Identity Registry"
* destination[=].endpoint = "http://example.org/fhir/Registry"
* focus = Reference(pmir-a28-history)

Instance:    pmir-a28-history
InstanceOf:  $PMIRHistory
Title:       "PMIR history Bundle - create (ADT^A28)"
Usage:       #inline
* type = #history
* entry[PMIREntryCreate][+].fullUrl = "https://fhir.ihe-uk.org/ITI/PAM/Patient/Patient-EDITESTPATIENT-TEN-9999999557"
* entry[PMIREntryCreate][=].resource = Patient-EDITESTPATIENT-TEN-9999999557
* entry[PMIREntryCreate][=].request.method = #POST
* entry[PMIREntryCreate][=].request.url = "Patient"
* entry[PMIREntryCreate][=].response.status = "201"

Instance:    pmir-feed-create-a28
InstanceOf:  $PMIRBundle
Title:       "PMIR [ITI-93] Mobile Patient Identity Feed - create (ADT^A28)"
Description: "PMIR equivalent of the HSCIC ITK ADT^A28 Create New Patient example. Compare the PAM FHIR Message hscic-a28-identity."
Usage:       #example
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:2f6c1b7e-0d4a-4b9e-8e3f-5a1c7d2b0a28"
* type = #message
* timestamp = "2010-01-02T12:15:00+00:00"
* entry[PMIRMessageHeaderEntry].fullUrl = "https://fhir.ihe-uk.org/ITI/PAM/MessageHeader/pmir-a28-header"
* entry[PMIRMessageHeaderEntry].resource = pmir-a28-header
* entry[PMIRBundleHistoryEntry].fullUrl = "https://fhir.ihe-uk.org/ITI/PAM/Bundle/pmir-a28-history"
* entry[PMIRBundleHistoryEntry].resource = pmir-a28-history
