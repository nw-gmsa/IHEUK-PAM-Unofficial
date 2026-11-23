Profile:     PAMMessageHeader
Parent:      MessageHeader
Id:          PAMMessageHeader
Title:       "PAM Message Header (MSH)"
Description: """
HL7 v2.5.1 `MSH` Message Header as a FHIR MessageHeader. The trigger event (`MSH-9.2`) is carried as `eventCoding` from HL7 Table 0003, so the v2 and FHIR messages share the same event semantics.

Where PAS broadcasts via an integration engine, HSCIC ITK populates `MSH-5`/`MSH-6` with `ROUTE` to indicate that the engine takes responsibility for onward routing. In FHIR, the `destination` is then the integration engine endpoint.
"""
* eventCoding 1..1 MS
* eventCoding from http://terminology.hl7.org/ValueSet/v2-0003 (required)
* eventCoding ^short = "MSH-9.2 Trigger Event (e.g. A01)"
* source MS
* source.name ^short = "MSH-3 Sending Application (e.g. PAS)"
* source.endpoint ^short = "MSH-3 Sending Application endpoint"
* sender 1..1 MS
* sender only Reference(PAMOrganization)
* sender.identifier only ODSOrganisationCode
* sender ^short = "MSH-4 Sending Facility (ODS code)"
* destination MS
* destination.name ^short = "MSH-5 Receiving Application (or ROUTE)"
* destination.receiver only Reference(PAMOrganization)
* destination.receiver.identifier only ODSOrganisationCode
* destination.receiver ^short = "MSH-6 Receiving Facility (ODS code, or ROUTE)"
* response ^short = "MSA - message acknowledgement (ACK)"
* response.identifier ^short = "MSA-2 Message Control ID of the message being acknowledged"
* response.code ^short = "MSA-1 Acknowledgment Code (AA=ok, AE=fatal-error, AR=transient-error)"
* focus 1..* MS
* focus ^short = "The Patient (ITI-30) or Encounter (ITI-31) the event is about"

Mapping:  PAMMessageHeaderToV2
Source:   PAMMessageHeader
Target:   "http://hl7.org/v2"
Id:       hl7v2
Title:    "HL7 v2.5.1 (HSCIC ITK)"
* -> "MSH"
* source.name -> "MSH-3"
* sender -> "MSH-4"
* destination.name -> "MSH-5"
* destination.receiver -> "MSH-6"
* eventCoding -> "MSH-9.2"
* response -> "MSA"

Profile:     PAMProvenance
Parent:      Provenance
Id:          PAMProvenance
Title:       "PAM Event (EVN)"
Description: """
HL7 v2.5.1 `EVN` Event Type. HSCIC ITK made `EVN-2` and `EVN-6` mandatory so that event sequencing can be preserved and reconstructed when messages are received out of sequence.
"""
* target 1..* MS
* target ^short = "The Patient / Encounter affected by the event"
* occurred[x] 1..1 MS
* occurred[x] only dateTime
* occurred[x] ^short = "EVN-6 Event Occurred - when the real-world event happened"
* recorded MS
* recorded ^short = "EVN-2 Recorded Date/Time"
* activity 1..1 MS
* activity from http://terminology.hl7.org/ValueSet/v2-0003 (extensible)
* activity ^short = "Trigger event (MSH-9.2 / EVN-1)"
* reason ^short = "EVN-4 Event Reason Code"
* agent MS
* agent.who only Reference(PAMPractitioner or PAMOrganization or Device)
* agent.who ^short = "EVN-5 Operator ID (clinical/non-clinical operator who triggered the event)"

Mapping:  PAMProvenanceToV2
Source:   PAMProvenance
Target:   "http://hl7.org/v2"
Id:       hl7v2
Title:    "HL7 v2.5.1 (HSCIC ITK)"
* -> "EVN"
* recorded -> "EVN-2"
* reason -> "EVN-4"
* agent.who -> "EVN-5"
* occurred[x] -> "EVN-6"

Profile:     PAMBundleMessage
Parent:      Bundle
Id:          PAMBundleMessage
Title:       "PAM Message Bundle"
Description: """
[FHIR Message](https://hl7.org/fhir/R4/messaging.html) equivalent of an HL7 v2.5.1 ADT message. The first entry is the [PAM Message Header](StructureDefinition-PAMMessageHeader.html).

| HL7 v2 | FHIR |
|--------|------|
| MSH-10 Message Control ID | `Bundle.identifier` |
| MSH-7 Date/Time of Message | `Bundle.timestamp` |
| MSH | `MessageHeader` |
| EVN | `Provenance` ([PAM Event](StructureDefinition-PAMProvenance.html)) |
| PID, PD1, ZU8 | `Patient` |
| NK1 | `RelatedPerson` |
| PV1, PV2, ZU1 | `Encounter` |
| AL1 | `AllergyIntolerance` |
| DG1 | `Condition` |
| PR1 | `Procedure` |
| MRG | `Patient.link` on the surviving Patient |
{:.grid}
"""
* identifier 1..1 MS
* identifier ^short = "MSH-10 Message Control ID"
* type = #message
* timestamp 1..1 MS
* timestamp ^short = "MSH-7 Date/Time of Message"
* entry 1..* MS
* entry.fullUrl 1..1
* entry.resource 1..1
* entry ^slicing.discriminator.type = #type
* entry ^slicing.discriminator.path = "resource"
* entry ^slicing.ordered = true
* entry ^slicing.rules = #open
* entry contains
    messageHeader 1..1 MS and
    event 0..1 MS and
    patient 1..* MS and
    encounter 0..1 MS
* entry[messageHeader].resource only PAMMessageHeader
* entry[messageHeader] ^short = "MSH"
* entry[event].resource only PAMProvenance
* entry[event] ^short = "EVN"
* entry[patient].resource only PAMPatient
* entry[patient] ^short = "PID, PD1. For A40 Merge the non-surviving Patient (MRG) may also be included"
* entry[encounter].resource only PAMEncounter
* entry[encounter] ^short = "PV1, PV2, ZU1 (required for ITI-31 events except A28, A31, A40)"
