// Example Scenario: inpatient admission, leave of absence, pending discharge and discharge, with event
// notifications to the GP practice and to social care.
// Step 1 reuses the HSCIC A01 FHIR Message (hscic-a01-encounter). The later events are new messages for the
// same Hospital Provider Spell (visit 2139), reusing the shared HSCIC patient and the A01 encounter content.

Alias: $instanceContent = http://hl7.org/fhir/5.0/StructureDefinition/extension-ExampleScenario.instance.content
Alias: $verContent = http://hl7.org/fhir/5.0/StructureDefinition/extension-ExampleScenario.instance.version.content
Alias: $verTitle = http://hl7.org/fhir/5.0/StructureDefinition/extension-ExampleScenario.instance.version.title

// ---- ExampleScenario rule sets (as in the NW Genomics IG)

RuleSet: ActorEntity(id, name, description)
* actor[+]
  * actorId = "{id}"
  * type = #entity
  * name = {name}
  * description = "{description}"

RuleSet: ActorPerson(id, name, description)
* actor[+]
  * actorId = "{id}"
  * type = #person
  * name = {name}
  * description = "{description}"

RuleSet: Instance_Empty(id, type, name, description)
* instance[+]
  * resourceId = "{id}"
  * resourceType = #{type}
  * name = {name}
  * description = "{description}"

RuleSet: InstanceVersion(id, name, content, description)
* instance[=].version[+]
  * extension[$verTitle].valueString = {name}
  * extension[$verContent].valueReference = Reference({content})
  * versionId = "{id}"
  * description = "{description}"

RuleSet: ProcessCreateEvent(num, name, sender, receiver, request, version, description)
* step[+].operation
  * number = "{num}"
  * type = "create"
  * name = {name}
  * description = "{description}"
  * initiator = "{sender}"
  * receiver = "{receiver}"
  * request.resourceId = "{request}"
  * request.versionId = "{version}"

// ---- Shared content of the Hospital Provider Spell (from the HSCIC A01 example)

RuleSet: SpellEncounter
* identifier[visitNumber].value = "2139"
* identifier[visitNumber].assigner.identifier.system = $ods-code
* identifier[visitNumber].assigner.identifier.value = "RCB"
* class = $v3-ActCode#IMP
* subject = Reference(Patient-EDITESTPATIENT-TEN-9999999557)
* hospitalization.extension[+].url = $UKCore-AdmissionMethod
* hospitalization.extension[=].valueCodeableConcept = $UKCore-AdmissionMethodEngland#13
* hospitalization.admitSource = $UKCore-SourceOfAdmissionEngland#19
* serviceType.coding[+] = $NHSTreatmentFunction#300
* participant[attendingDoctor].individual.identifier.system = $gmc-number
* participant[attendingDoctor].individual.identifier.value = "C3456789"
* participant[attendingDoctor].individual.display = "Dr Samuel Darwin"
* participant[referringDoctor].individual.identifier.system = $gmp-number
* participant[referringDoctor].individual.identifier.value = "G5612908"
* participant[referringDoctor].individual.display = "Dr Gregory Townley"
* participant[consultingDoctor].individual.identifier.system = $gmc-number
* participant[consultingDoctor].individual.identifier.value = "C3456789"
* participant[consultingDoctor].individual.display = "Dr Samuel Darwin"
* period.start = "2010-10-20T17:16:00+01:00"
* serviceProvider.identifier.system = $ods-code
* serviceProvider.identifier.value = "RCB"
* extension[+].url = "https://fhir.ihe-uk.org/ITI/PAM/StructureDefinition/Extension-DecisionToAdmitDateTime"
* extension[=].valueDateTime = "2010-10-07T12:34:00+01:00"
* extension[+].url = "https://fhir.ihe-uk.org/ITI/PAM/StructureDefinition/Extension-IntendedManagement"
* extension[=].valueCodeableConcept = IntendedManagementCS#1

RuleSet: SpellLocation(status)
* location[+].location.identifier.value = "OBS1"
* location[=].location.display = "RCB OBS1 BAY2-6"
* location[=].status = #{status}

RuleSet: SpellHeader(event, focus)
* eventCoding = $v2-0003#{event}
* source.name = "PAS"
* source.endpoint = "http://example.org/hl7v2/PAS"
* sender.identifier.system = $ods-code
* sender.identifier.value = "RCB"
* sender.display = "YORK AND SCARBOROUGH TEACHING HOSPITALS NHS FOUNDATION TRUST"
* destination[+].name = "ROUTE"
* destination[=].endpoint = "http://example.org/hl7v2/ROUTE"
* focus[+] = Reference({focus})

RuleSet: SpellEvent(event, focus, occurred, recorded)
* target[+] = Reference({focus})
* occurredDateTime = "{occurred}"
* recorded = "{recorded}"
* activity = $v2-0003#{event}
* agent[+].who.identifier.value = "OP000123"
* agent[=].who.display = "Emily Cortana"

RuleSet: SpellBundle(id, uuid, timestamp)
* insert MessageBundle("{uuid}", "{timestamp}")
* insert Entry("https://fhir.ihe-uk.org/ITI/PAM/MessageHeader/{id}-header", {id}-header)
* insert Entry("https://fhir.ihe-uk.org/ITI/PAM/Provenance/{id}-event", {id}-event)
* insert Entry("https://fhir.ihe-uk.org/ITI/PAM/Patient/Patient-EDITESTPATIENT-TEN-9999999557", Patient-EDITESTPATIENT-TEN-9999999557)
* insert Entry("https://fhir.ihe-uk.org/ITI/PAM/Encounter/{id}-encounter", {id}-encounter)

// ---- A21 Patient goes on leave of absence

Instance:    scenario-a21-leave-encounter
InstanceOf:  PAMEncounter
Title:       "Encounter - on leave (A21)"
Usage:       #inline
* insert SpellEncounter
* status = #onleave
* insert SpellLocation(reserved)

Instance:    scenario-a21-leave-header
InstanceOf:  PAMMessageHeader
Usage:       #inline
* insert SpellHeader(A21, scenario-a21-leave-encounter)

Instance:    scenario-a21-leave-event
InstanceOf:  PAMProvenance
Usage:       #inline
* insert SpellEvent(A21, scenario-a21-leave-encounter, 2010-10-23T10:00:00+01:00, 2010-10-23T10:05:00+01:00)

Instance:    scenario-a21-leave
InstanceOf:  PAMBundleMessage
Title:       "Scenario - ADT^A21 Patient goes on leave of absence"
Description: "Mrs Editestpatient goes home to Malton on leave of absence. The bed on Ward OBS1 is kept for her (location status reserved)."
Usage:       #example
* insert SpellBundle(scenario-a21-leave, urn:uuid:a1c3e5f7-2b4d-4f6a-8c0e-1a2b3c4d5a21, 2010-10-23T10:05:30+01:00)

// ---- A22 Patient returns from leave of absence

Instance:    scenario-a22-return-encounter
InstanceOf:  PAMEncounter
Title:       "Encounter - returned from leave (A22)"
Usage:       #inline
* insert SpellEncounter
* status = #in-progress
* insert SpellLocation(active)

Instance:    scenario-a22-return-header
InstanceOf:  PAMMessageHeader
Usage:       #inline
* insert SpellHeader(A22, scenario-a22-return-encounter)

Instance:    scenario-a22-return-event
InstanceOf:  PAMProvenance
Usage:       #inline
* insert SpellEvent(A22, scenario-a22-return-encounter, 2010-10-24T18:00:00+01:00, 2010-10-24T18:02:00+01:00)

Instance:    scenario-a22-return
InstanceOf:  PAMBundleMessage
Title:       "Scenario - ADT^A22 Patient returns from leave of absence"
Description: "Mrs Editestpatient returns to Ward OBS1 from leave of absence."
Usage:       #example
* insert SpellBundle(scenario-a22-return, urn:uuid:b2d4f6a8-3c5e-4a7b-9d1f-2b3c4d5e6a22, 2010-10-24T18:02:30+01:00)

// ---- A16 Pending discharge

Instance:    scenario-a16-pending-encounter
InstanceOf:  PAMEncounter
Title:       "Encounter - pending discharge (A16)"
Usage:       #inline
* insert SpellEncounter
* status = #in-progress
* insert SpellLocation(active)
* extension[+].url = "https://fhir.ihe-uk.org/ITI/PAM/StructureDefinition/Extension-ReadyForDischargeDateTime"
* extension[=].valueDateTime = "2010-10-26T08:30:00+01:00"
* extension[+].url = "https://fhir.ihe-uk.org/ITI/PAM/StructureDefinition/Extension-PlannedEndDate"
* extension[=].valueDateTime = "2010-10-27T12:00:00+01:00"

Instance:    scenario-a16-pending-header
InstanceOf:  PAMMessageHeader
Usage:       #inline
* insert SpellHeader(A16, scenario-a16-pending-encounter)

Instance:    scenario-a16-pending-event
InstanceOf:  PAMProvenance
Usage:       #inline
* insert SpellEvent(A16, scenario-a16-pending-encounter, 2010-10-26T09:00:00+01:00, 2010-10-26T09:04:00+01:00)

Instance:    scenario-a16-pending
InstanceOf:  PAMBundleMessage
Title:       "Scenario - ADT^A16 Pending discharge"
Description: "Mrs Editestpatient is medically fit for discharge (ZU1-24) and is expected to be discharged home at 12:00 the next day (PV2-9)."
Usage:       #example
* insert SpellBundle(scenario-a16-pending, urn:uuid:c3e5a7b9-4d6f-4b8c-8e2a-3c4d5e6f7a16, 2010-10-26T09:04:30+01:00)

// ---- A03 Discharge

Instance:    scenario-a03-discharge-encounter
InstanceOf:  PAMEncounter
Title:       "Encounter - discharged (A03)"
Usage:       #inline
* insert SpellEncounter
* status = #finished
* insert SpellLocation(completed)
* period.end = "2010-10-27T11:30:00+01:00"
* hospitalization.dischargeDisposition = $UKCore-DischargeDestinationEngland#19
* extension[+].url = $UKCore-DischargeMethod
* extension[=].valueCodeableConcept = $UKCore-DischargeMethodEngland#1

Instance:    scenario-a03-discharge-header
InstanceOf:  PAMMessageHeader
Usage:       #inline
* insert SpellHeader(A03, scenario-a03-discharge-encounter)

Instance:    scenario-a03-discharge-event
InstanceOf:  PAMProvenance
Usage:       #inline
* insert SpellEvent(A03, scenario-a03-discharge-encounter, 2010-10-27T11:30:00+01:00, 2010-10-27T11:34:00+01:00)

Instance:    scenario-a03-discharge
InstanceOf:  PAMBundleMessage
Title:       "Scenario - ADT^A03 Discharge"
Description: "Mrs Editestpatient is discharged on clinical advice (discharge method 1) to her usual place of residence (discharge destination 19)."
Usage:       #example
* insert SpellBundle(scenario-a03-discharge, urn:uuid:d4f6b8c0-5e7a-4c9d-9f3b-4d5e6f7a8a03, 2010-10-27T11:34:30+01:00)

// ---- The Example Scenario

Instance:    InpatientLeaveAndDischarge
InstanceOf:  ExampleScenario
Title:       "Inpatient admission, leave and discharge"
Description: """
Mrs Editestpatient (the HSCIC ITK example patient, EDITESTPATIENT TEN) is referred by her GP, Dr Townley of the Malton GP Practice, and admitted to York Hospital under Dr Darwin (General Medicine). During her stay she goes home on leave and returns. When she is medically fit, a pending discharge is recorded, and she is then discharged home.

The hospital PAS (Patient Encounter Supplier) sends each event once to the integration engine (`MSH-5`/`MSH-6` = `ROUTE`), which forwards it to the systems that need it (Patient Encounter Consumers):

- the **GP practice** clinical system is told when its patient is admitted, goes on leave, returns, and is discharged. Admission and discharge notifications to GP systems are widely supported by GP clinical system suppliers;
- **social care** (the local authority adult social care system) is told of the pending discharge, so that any care and support needed at home can be arranged before the patient leaves hospital, and then of the discharge.
"""
Usage:       #example
* status = #draft
* name = "InpatientLeaveAndDischarge"

* insert ActorPerson(patient, "Patient - Mrs Editestpatient", [[ EDITESTPATIENT TEN (test NHS Number 9999999557), registered with the Malton GP Practice ]])
* insert ActorEntity(pas, "Hospital PAS - York Hospital", [[ [Patient Encounter Supplier](ActorDefinition-PatientEncounterSupplier.html). The PAS of York and Scarborough Teaching Hospitals NHS Foundation Trust (RCB), which records the admission, leave, pending discharge and discharge ]])
* insert ActorEntity(engine, "Integration Engine", [[ The Trust integration engine, addressed as ROUTE in MSH-5/MSH-6. It acts as a Patient Encounter Consumer to the PAS and as a Patient Encounter Supplier to the downstream systems, and decides which events each system receives ]])
* insert ActorEntity(gp, "GP Practice - Malton GP Practice", [[ [Patient Encounter Consumer](ActorDefinition-PatientEncounterConsumer.html). The GP clinical system of the Malton GP Practice (Y06601), where the patient is registered (PD1-3) ]])
* insert ActorEntity(socialcare, "Social Care - Local Authority", [[ [Patient Encounter Consumer](ActorDefinition-PatientEncounterConsumer.html). The adult social care system of the patient's local authority, which plans any care and support needed after discharge ]])

* insert Instance_Empty(Admission, Bundle, [["Admission (ADT^A01)"]], [[ Inpatient admission, visit 2139, Ward OBS1, General Medicine ]])
* insert InstanceVersion(1, "PAM FHIR Message A01", hscic-a01-encounter, [[ The HSCIC ITK Inpatient Admission example ]])
* insert Instance_Empty(Leave, Bundle, [["Leave of absence (ADT^A21)"]], [[ Encounter status onleave; the bed is kept (location status reserved) ]])
* insert InstanceVersion(1, "PAM FHIR Message A21", scenario-a21-leave, [[ Patient goes on leave of absence ]])
* insert Instance_Empty(Return, Bundle, [["Return from leave of absence (ADT^A22)"]], [[ Encounter status in-progress ]])
* insert InstanceVersion(1, "PAM FHIR Message A22", scenario-a22-return, [[ Patient returns from leave of absence ]])
* insert Instance_Empty(PendingDischarge, Bundle, [["Pending discharge (ADT^A16)"]], [[ Ready for discharge (ZU1-24) and expected discharge date/time (PV2-9) ]])
* insert InstanceVersion(1, "PAM FHIR Message A16", scenario-a16-pending, [[ Pending discharge ]])
* insert Instance_Empty(Discharge, Bundle, [["Discharge (ADT^A03)"]], [[ Encounter status finished; discharge method and destination ]])
* insert InstanceVersion(1, "PAM FHIR Message A03", scenario-a03-discharge, [[ Discharge ]])

* process[+]
  * title = "Inpatient admission, leave and discharge"
  * description = "Each event is sent by the PAS to the integration engine and routed to the GP practice and, for discharge planning, to social care. Every message is acknowledged (ACK) by its receiver."
  * insert ProcessCreateEvent(1, "Admit patient", pas, engine, Admission, 1, [[ ITI-31 Basic Subset. HL7 v2 ADT^A01^ADT_A01 ]])
  * insert ProcessCreateEvent(2, "Notify GP of admission", engine, gp, Admission, 1, [[ The GP practice knows its patient is in hospital ]])
  * insert ProcessCreateEvent(3, "Patient goes on leave", pas, engine, Leave, 1, [[ ITI-31 Advanced Encounter Management Option. HL7 v2 ADT^A21^ADT_A21 ]])
  * insert ProcessCreateEvent(4, "Notify GP of leave", engine, gp, Leave, 1, [[ The patient is at home, under the care of the hospital ]])
  * insert ProcessCreateEvent(5, "Patient returns from leave", pas, engine, Return, 1, [[ ITI-31 Advanced Encounter Management Option. HL7 v2 ADT^A22^ADT_A21 ]])
  * insert ProcessCreateEvent(6, "Notify GP of return", engine, gp, Return, 1, [[ ]])
  * insert ProcessCreateEvent(7, "Pending discharge", pas, engine, PendingDischarge, 1, [[ ITI-31 Pending Event Management Option. HL7 v2 ADT^A16^ADT_A16 ]])
  * insert ProcessCreateEvent(8, "Notify social care of pending discharge", engine, socialcare, PendingDischarge, 1, [[ Social care arranges any care and support needed at home before the expected discharge date ]])
  * insert ProcessCreateEvent(9, "Discharge patient", pas, engine, Discharge, 1, [[ ITI-31 Basic Subset. HL7 v2 ADT^A03^ADT_A03 ]])
  * insert ProcessCreateEvent(10, "Notify GP of discharge", engine, gp, Discharge, 1, [[ The GP practice knows its patient is home ]])
  * insert ProcessCreateEvent(11, "Notify social care of discharge", engine, socialcare, Discharge, 1, [[ Social care confirms the discharge and starts the planned care and support ]])
