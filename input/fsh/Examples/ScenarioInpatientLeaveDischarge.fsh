// Example Scenario: inpatient admission, leave of absence, pending discharge and discharge, with event
// notifications to the GP practice and to social care.
// The steps reuse the HSCIC ITK example FHIR Messages (A01, A21, A22, A16, A03). They are different visits (PV1-19);
// the Hospital Provider Spell number 5000123 (PID-18 / Encounter.partOf), added to these examples by
// scripts/convert_hscic_examples.py (SCENARIO_EXAMPLES), ties them together.

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

Instance:    InpatientLeaveAndDischarge
InstanceOf:  ExampleScenario
Title:       "Inpatient admission, leave and discharge"
Description: """
Mrs Editestpatient (the HSCIC ITK example patient, EDITESTPATIENT TEN) is referred by her GP, Dr Townley of the Malton GP Practice, and admitted to York Hospital under Dr Darwin (General Medicine). During her stay she goes home on leave and returns. When she is medically fit, a pending discharge is recorded, and she is then discharged home.

The events are recorded against different visits (`PV1-19`). The **Hospital Provider Spell** number (`PID-18` Patient Account Number, `5000123`; `Encounter.partOf` in FHIR) ties them together into one stay as an admitted patient.

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

* insert Instance_Empty(Admission, Bundle, [["Admission (ADT^A01)"]], [[ Inpatient admission, visit 2139, Ward OBS1, General Medicine. Hospital Provider Spell 5000123 ]])
* insert InstanceVersion(1, "PAM FHIR Message A01", hscic-a01-encounter, [[ The HSCIC ITK Inpatient Admission example (visit 2139) ]])
* insert Instance_Empty(Leave, Bundle, [["Leave of absence (ADT^A21)"]], [[ Encounter status onleave. Hospital Provider Spell 5000123 ]])
* insert InstanceVersion(1, "PAM FHIR Message A21", hscic-a21-advanced, [[ The HSCIC ITK Leave of Absence example (visit 1164) ]])
* insert Instance_Empty(Return, Bundle, [["Return from leave of absence (ADT^A22)"]], [[ Encounter status in-progress. Hospital Provider Spell 5000123 ]])
* insert InstanceVersion(1, "PAM FHIR Message A22", hscic-a22-advanced, [[ The HSCIC ITK Return from Leave of Absence example (visit 1164) ]])
* insert Instance_Empty(PendingDischarge, Bundle, [["Pending discharge (ADT^A16)"]], [[ Expected discharge date/time (PV2-9). Hospital Provider Spell 5000123 ]])
* insert InstanceVersion(1, "PAM FHIR Message A16", hscic-a16-pending, [[ The HSCIC ITK Pending Discharge example (visit 1114) ]])
* insert Instance_Empty(Discharge, Bundle, [["Discharge (ADT^A03)"]], [[ Encounter status finished; discharge destination. Hospital Provider Spell 5000123 ]])
* insert InstanceVersion(1, "PAM FHIR Message A03", hscic-a03-encounter, [[ The HSCIC ITK Discharge Patient example (visit YOR123456) ]])

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
