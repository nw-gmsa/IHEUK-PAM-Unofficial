UK national extension of [IHE ITI TF-2: 3.31 Patient Encounter Management](https://profiles.ihe.net/ITI/TF/Volume2/ITI-31.html), derived from HSCIC ITK sections 3.1.1 to 3.1.3 and 4.1 to 4.29.

### Scope

The Patient Encounter Supplier uses this transaction to send inserts, updates and cancels of patient encounters (admissions, registrations, transfers, leave, discharges) and of the patient's movements. The Consumer acts on them.

### Actor Roles

| Actor | Role |
|-------|------|
| [Patient Encounter Supplier](ActorDefinition-PatientEncounterSupplier.html) | Sends inserts, cancels and updates of patient encounters and movements |
| [Patient Encounter Consumer](ActorDefinition-PatientEncounterConsumer.html) | Receives encounter and movement messages and takes the appropriate actions |
{:.grid}

### Trigger Events and Encounter Status

The table lists every HSCIC ITK trigger event with its IHE option. It also gives the FHIR `Encounter.status` the Consumer should hold after processing the event.

| Event | Message | Description | IHE option | HSCIC ref | Cancelled by | FHIR Encounter.status |
|-------|---------|-------------|------------|-----------|--------------|-----------------------|
| A01 | ADT^A01^ADT_A01 | Admit inpatient | Basic Subset | 4.1 | A11 | `in-progress` |
| A04 | ADT^A04^ADT_A01 | Register outpatient / A&E attendance | Basic Subset | 4.6 | A11 | `arrived` / `in-progress` |
| A03 | ADT^A03^ADT_A03 | Discharge patient (inpatient or outpatient) | Basic Subset | 4.4 | A13 | `finished` |
| A11 | ADT^A11^ADT_A09 | Cancel admission / registration | Basic Subset | 4.10 | - | `cancelled` (or `entered-in-error`) |
| A13 | ADT^A13^ADT_A01 | Cancel discharge | Basic Subset | 4.13 | - | `in-progress` |
| A05 | ADT^A05^ADT_A05 | Pre-admit a patient | Inpatient/Outpatient | 4.8 | A38 | `planned` |
| A38 | ADT^A38^ADT_A38 | Cancel pre-admit | Inpatient/Outpatient | 4.26 | - | `cancelled` |
| A02 | ADT^A02^ADT_A02 | Transfer patient | Inpatient/Outpatient | 4.2 | A12 | `in-progress` (new `location`) |
| A12 | ADT^A12^ADT_A09 | Cancel transfer | Inpatient/Outpatient | 4.11 | - | `in-progress` (prior `location` restored) |
| A06 / A07 | ADT^A06^ADT_A06 / ADT^A07^ADT_A06 | Change outpatient to inpatient / inpatient to outpatient | Inpatient/Outpatient | not defined | - | `class` changed |
| A14 | ADT^A14^ADT_A05 | Pending admit | Pending Event | 4.15 | A27 | `planned` |
| A27 | ADT^A27^ADT_A21 | Cancel pending admit | Pending Event | 4.22 | - | `cancelled` |
| A15 | ADT^A15^ADT_A15 | Pending transfer | Pending Event | 4.16 | A26 | `in-progress` (location `planned`) |
| A26 | ADT^A26^ADT_A21 | Cancel pending transfer | Pending Event | 4.21 | - | `in-progress` |
| A16 | ADT^A16^ADT_A16 | Pending discharge | Pending Event | 4.17 | A25 | `in-progress` (+ PV2-9 planned end) |
| A25 | ADT^A25^ADT_A21 | Cancel pending discharge | Pending Event | 4.20 | - | `in-progress` |
| A21 | ADT^A21^ADT_A21 | Patient goes on leave of absence | Advanced | 4.18 | A52 | `onleave` |
| A52 | ADT^A52^ADT_A52 | Cancel leave of absence | Advanced | 4.28 | - | `in-progress` |
| A22 | ADT^A22^ADT_A21 | Patient returns from leave of absence | Advanced | 4.19 | A53 | `in-progress` |
| A53 | ADT^A53^ADT_A52 | Cancel patient returns from leave of absence | Advanced | 4.29 | - | `onleave` |
| A08 | ADT^A08^ADT_A01 | Update patient / encounter information | Maintain Demographics | 4.9 | (A08) | unchanged |
| A40 | ADT^A40^ADT_A39 | Merge two patients | Maintain Demographics | 4.27 | - | see [ITI-30](ITI-30.html) |
{:.grid}

A MessageDefinition is published for each event: see [Artifacts](artifacts.html#structures-message-definitions). IHE events not defined by HSCIC ITK (A06, A07, A09, A10, A32, A33, A44, A54, A55, Z99) follow ITI TF-2 unchanged.

<div class="alert alert-info">
<b>A08 semantics:</b> HSCIC ITK titles A08 "Update Encounter Information". IHE restricts A08 within ITI-31 to updating information related to the <i>current encounter</i>, including the demographics in it. Pure patient (non-encounter) updates <b>shall</b> be sent as <a href="ITI-30.html">ITI-30</a> A31.
</div>

### Message Structure - ADT_A01 family (A01, A04, A08, A13)

The same structure, with the indicated variations, is used for ADT_A02 (A02), ADT_A03 (A03), ADT_A05 (A05, A14), ADT_A09 (A11, A12), ADT_A15, ADT_A16, ADT_A21 (A21, A22, A25, A26, A27), ADT_A38 and ADT_A52 (A52, A53).

| Segment | Description | Usage | Card. | Present in | HSCIC notes |
|---------|-------------|-------|-------|-----------|-------------|
| [MSH](hl7v2-segments.html#msh---message-header) | Message Header | R | [1..1] | all | |
| [SFT] | Software | O | [0..*] | all | New in v2.5. Not used in ITK |
| [EVN](hl7v2-segments.html#evn---event-type) | Event Type | R | [1..1] | all | |
| [PID](hl7v2-segments.html#pid---patient-identification) | Patient Identification | R | [1..1] | all | |
| [PD1](hl7v2-segments.html#pd1---patient-additional-demographic) | Additional Demographics | O | [0..1] | all | |
| [{NK1}](hl7v2-segments.html#nk1---next-of-kin--associated-parties) | Next of Kin | O | [0..*] | A01, A04, A05, A08, A13, A14, A16, A38 | |
| [PV1](hl7v2-segments.html#pv1---patient-visit) | Patient Visit | R | [1..1] | all | |
| [PV2](hl7v2-segments.html#pv2---patient-visit---additional-information) | Patient Visit - Additional Info | O (C) | [0..1] | all | PV2-8 required in A05/A14, PV2-9 required in A16 |
| [ZBE] | Movement segment | C | [0..1] | | IHE Historic Movement Option only. Not used in ITK |
| [{OBX}] | Observation/Result | O | [0..*] | all | |
| [{AL1}](hl7v2-segments.html#al1---patient-allergy-information) | Allergy Information | RE | [0..*] | A01, A04, A05, A08, A13, A14, A16, A38 | Recorded allergies **must** be sent |
| [{DG1}] | Diagnosis | O | [0..*] | A01, A04, A05, A08, A11, A12, A13, A14, A15, A16, A38 | |
| [{PR1}] | Procedures | O | [0..*] | A01, A04, A05, A08, A13, A14, A16, A38 | |
| [ZU1](hl7v2-zsegments.html#zu1---uk-additional-data) | UK Additional PV info | RE | [0..1] | not A52/A53 | Required if available |
| [ZU3](hl7v2-zsegments.html#zu3---uk-additional-data---attendance-details) | UK Attendance Details | O | [0..1] | not A52/A53 | |
| [ZU4](hl7v2-zsegments.html#zu4---uk-additional-data---waiting-list) | UK Waiting List | O | [0..1] | not A52/A53 | |
| [ZU5](hl7v2-zsegments.html#zu5---uk-additional-data---psychiatric-census) | UK Psychiatric Census | O | [0..1] | A08 only | Annual census |
| [ZU6](hl7v2-zsegments.html#zu6---uk-additional-data---labour-and-delivery) | UK Labour & Delivery | O | [0..1] | not A52/A53 | |
| [ZU7](hl7v2-zsegments.html#zu7---uk-additional-data---birth) | UK Birth Details | O | [0..1] | not A52/A53 | |
| [ZU8](hl7v2-zsegments.html#zu8---uk-miscellaneous-demographic-data) | UK Miscellaneous Demographics | O | [0..1] | not A52/A53 | |
{:.grid}

<div class="alert alert-info">
HL7 v2.5.1 allows Z segments anywhere in a message. To match HSCIC ITK and keep parsers simple, UK Z segments <b>shall</b> be sent at the <b>end</b> of the message, in the order ZU1, ZU3, ZU4, ZU5, ZU6, ZU7, ZU8. Consumers <b>shall</b> ignore Z segments they do not process.
</div>

### Expected Actions

- The Consumer **shall** apply the event to the encounter identified by **PV1-19 Visit Number**, for the patient identified by PID-3.
- An event that the Consumer receives for an unknown visit (for example A03 without a prior A01) **should** create the encounter, rather than be rejected, unless local policy says otherwise.
- **Sequencing:** messages can arrive out of sequence in multi-hop environments. Consumers **should** use EVN-6 Event Occurred together with MSH-7 and MSH-13 Sequence Number to detect and resolve this (HSCIC ITK 5.1, 5.2).
- Cancel events (A11, A12, A13, A25, A26, A27, A38, A52, A53) **shall** reverse the matching insert event. A cancel that does not match the current state of the encounter **should** be application-rejected (`AE`).

### FHIR Messaging

The FHIR equivalent is a [PAM Message Bundle](StructureDefinition-PAMBundleMessage.html) with a [PAM Message Header](StructureDefinition-PAMMessageHeader.html) whose `eventCoding` is the trigger event. Its focus is the [PAM Encounter](StructureDefinition-PAMEncounter.html), which references the [PAM Patient](StructureDefinition-PAMPatient.html). Examples: [ADT^A01](Bundle-Bundle-ADT-A01.html), [ADT^A03](Bundle-Bundle-ADT-A03.html).

### Security Considerations

As for [ITI-30](ITI-30.html#security-considerations). Location information (PV1-3) is subject to [Location Hiding](hl7v2-zsegments.html#zu8---uk-miscellaneous-demographic-data).
