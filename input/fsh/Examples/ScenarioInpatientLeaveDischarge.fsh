// Example Scenario: inpatient admission, leave of absence, pending discharge and discharge, with event
// notifications to the GP practice and to social care.
// The steps are the purpose-built HL7 v2.5.1 messages in examples-v2/InpatientLeaveAndDischarge and their FHIR Messages
// (generated into ScenarioMessages.fsh by scripts/hscic_v2_to_fhir.py --scenario). Every message carries the same
// Hospital Provider Spell 5000123 (PV1-19, type AN) and, in FHIR, the same Encounter resource
// (Encounter/inpatient-spell-5000123), shown here as one instance with a version per event.

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

RuleSet: InstanceEncounterVersion(id, description)
* instance[=].version[+]
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

Every message carries the same **Hospital Provider Spell** number (`PV1-19`, type `AN`, `5000123`). In FHIR every message carries the same Encounter, updated by each event: admitted (`in-progress`), on leave (`onleave`), back on the ward (`in-progress`), expected discharge date, and discharged (`finished`).

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

* insert Instance_Empty(SpellEncounter, Encounter, [["Hospital Provider Spell 5000123"]], [[ The inpatient stay. PV1-19 5000123^^^RCB^AN. Encounter/inpatient-spell-5000123 in every FHIR Message ]])
* insert InstanceEncounterVersion(1, [[ Admitted to Ward OBS1 under Dr Darwin, General Medicine. status in-progress ]])
* insert InstanceEncounterVersion(2, [[ On leave of absence. status onleave ]])
* insert InstanceEncounterVersion(3, [[ Back on the ward. status in-progress ]])
* insert InstanceEncounterVersion(4, [[ Pending discharge. status in-progress with expected discharge date/time 12 November 2026 11:00 ]])
* insert InstanceEncounterVersion(5, [[ Discharged to usual place of residence. status finished with period.end ]])

* insert Instance_Empty(Admission, Bundle, [["Admission (ADT^A01)"]], [[ Emergency admission on referral from the GP ]])
* insert InstanceVersion(1, "PAM FHIR Message A01", scenario-a01, [[ Carries version 1 of the Hospital Provider Spell Encounter. ADT^A01 2 November 2026 14:30 ]])
* insert Instance_Empty(Leave, Bundle, [["Leave of absence (ADT^A21)"]], [[ The patient goes home on leave ]])
* insert InstanceVersion(1, "PAM FHIR Message A21", scenario-a21, [[ Carries version 2 of the Hospital Provider Spell Encounter. ADT^A21 6 November 2026 10:00 ]])
* insert Instance_Empty(Return, Bundle, [["Return from leave of absence (ADT^A22)"]], [[ The patient returns from leave ]])
* insert InstanceVersion(1, "PAM FHIR Message A22", scenario-a22, [[ Carries version 3 of the Hospital Provider Spell Encounter. ADT^A22 8 November 2026 18:00 ]])
* insert Instance_Empty(PendingDischarge, Bundle, [["Pending discharge (ADT^A16)"]], [[ Expected discharge date/time in PV2-9 ]])
* insert InstanceVersion(1, "PAM FHIR Message A16", scenario-a16, [[ Carries version 4 of the Hospital Provider Spell Encounter. ADT^A16 10 November 2026 09:00 ]])
* insert Instance_Empty(Discharge, Bundle, [["Discharge (ADT^A03)"]], [[ Discharge date/time and discharge destination ]])
* insert InstanceVersion(1, "PAM FHIR Message A03", scenario-a03, [[ Carries version 5 of the Hospital Provider Spell Encounter. ADT^A03 12 November 2026 11:30 ]])

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
