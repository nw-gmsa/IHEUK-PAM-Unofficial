RuleSet: Obligation(code, actor)
* ^extension[$Obligation][+].extension[code].valueCode = {code}
* ^extension[$Obligation][=].extension[actor].valueCanonical = "{actor}"

// HSCIC ITK 'O' is Optional for consumers but 'RE' (populate if known) for the sending PAS
RuleSet: SupplierPopulateIfKnown
* insert Obligation(#SHOULD:populate-if-known, https://fhir.ihe-uk.org/ITI/PAM/ActorDefinition/PatientDemographicsSupplier)
* insert Obligation(#SHOULD:populate-if-known, https://fhir.ihe-uk.org/ITI/PAM/ActorDefinition/PatientEncounterSupplier)

RuleSet: SupplierPopulate
* insert Obligation(#SHALL:populate, https://fhir.ihe-uk.org/ITI/PAM/ActorDefinition/PatientDemographicsSupplier)
* insert Obligation(#SHALL:populate, https://fhir.ihe-uk.org/ITI/PAM/ActorDefinition/PatientEncounterSupplier)

RuleSet: MessageBundle(id, timestamp)
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = {id}
* type = #message
* timestamp = {timestamp}

RuleSet: Entry(fullUrl, resource)
* entry[+].fullUrl = {fullUrl}
* entry[=].resource = {resource}

// ADT trigger event MessageDefinition. allowedResponse is always the HL7 v2 ACK (or FHIR response)
RuleSet: ADTEvent(event, structure, title, transaction, option)
* url = "https://fhir.ihe-uk.org/ITI/PAM/MessageDefinition/ADT-{event}"
* name = "ADT_{event}"
* title = "ADT^{event}^{structure} {title}"
* status = #draft
* experimental = false
* date = "2026-11-23"
* publisher = "NHS North West Genomics"
* description = """
HL7 v2.5.1 `ADT^{event}^{structure}` - {title}. IHE [{transaction}]({transaction}.html), {option}.
FHIR Messaging equivalent: a [PAM Message Bundle](StructureDefinition-PAMBundleMessage.html) whose MessageHeader.eventCoding is `{event}` from HL7 Table 0003.
"""
* eventCoding = $v2-0003#{event}
* category = #notification
* responseRequired = #always
