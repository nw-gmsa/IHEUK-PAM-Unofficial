UK national extension of [IHE ITI TF-2: 3.30 Patient Identity Management](https://profiles.ihe.net/ITI/TF/Volume2/ITI-30.html), derived from HSCIC ITK section 3.1.4 *Patient Identity Management*.

### Scope

The Patient Demographics Supplier uses this transaction to tell Consumers that patients have been created or updated, or that duplicate patient records have been merged. It concerns the patient only. Encounter information is in [ITI-31](ITI-31.html).

### Actor Roles

| Actor | Role |
|-------|------|
| [Patient Demographics Supplier](ActorDefinition-PatientDemographicsSupplier.html) | Adds and modifies patient demographics and identifiers |
| [Patient Demographics Consumer](ActorDefinition-PatientDemographicsConsumer.html) | Receives patient demographics and updates its local records |
{:.grid}

### Trigger Events

| Event | Message | Description | IHE option | HSCIC ITK ref | FHIR |
|-------|---------|-------------|------------|---------------|------|
| A28 | ADT^A28^ADT_A05 | Add person information (Create New Patient) | (base) | 4.23 | [MessageDefinition](MessageDefinition-ADT-A28.html) |
| A31 | ADT^A31^ADT_A05 | Update person information | (base) | 4.24 | [MessageDefinition](MessageDefinition-ADT-A31.html) |
| A40 | ADT^A40^ADT_A39 | Merge patient - patient identifier list | Merge | 4.27 | [MessageDefinition](MessageDefinition-ADT-A40.html) |
| A47 | ADT^A47^ADT_A30 | Change patient identifier list | Merge | not defined | - |
| A24 / A37 | ADT^A24^ADT_A24 / ADT^A37^ADT_A37 | Link / unlink patient information | Link/Unlink | not defined | not used in UK |
{:.grid}

A31 is also the **compensating transaction**: HSCIC ITK has no "cancel" for A28 or A31, so a correction is sent as a further A31.

<div class="alert alert-info">
<b>UK note on A47:</b> HSCIC ITK did not define A47. IHE ITI-30 includes A47 in the Merge Option. Suppliers <b>should</b> support A47 to correct a wrongly assigned local identifier (for example a temporary number replaced by the permanent MRN). Consumers claiming the Merge Option <b>shall</b> accept it.
</div>

### Message Structure - ADT^A28 / ADT^A31 (ADT_A05)

| Segment | Description | Usage | Card. | HSCIC notes |
|---------|-------------|-------|-------|-------------|
| [MSH](hl7v2-segments.html#msh---message-header) | Message Header | R | [1..1] | |
| [SFT] | Software Segment | O | [0..*] | New in v2.5. Not used in ITK |
| [EVN](hl7v2-segments.html#evn---event-type) | Event Type | R | [1..1] | |
| [PID](hl7v2-segments.html#pid---patient-identification) | Patient Identification | R | [1..1] | |
| [PD1](hl7v2-segments.html#pd1---patient-additional-demographic) | Additional Demographics | O | [0..1] | GP Practice and registered GP |
| [ROL] | Role | O | [0..*] | Not used in ITK |
| [NK1](hl7v2-segments.html#nk1---next-of-kin--associated-parties) | Next of Kin | O | [0..*] | |
| [PV1](hl7v2-segments.html#pv1---patient-visit) | Patient Visit | R (v2.5.1) / O (ITK) | [1..1] | HSCIC: "may not be available prior to episodic activity". IHE ITI-30 requires a PV1 with **PV1-2 = `N`** (not applicable) |
| [PV2] | Patient Visit - Additional Info | O | [0..1] | |
| [{OBX}] | Observation/Result | O | [0..*] | e.g. height/weight |
| [{AL1}](hl7v2-segments.html#al1---patient-allergy-information) | Allergy Information | RE | [0..*] | If the patient has recorded allergies they **must** be sent |
| [{DG1}] | Diagnosis | O | [0..*] | |
| [{PR1}] | Procedures | O | [0..*] | |
| [ZU1](hl7v2-zsegments.html#zu1---uk-additional-data) | UK Additional PV info | O | [0..1] | Overseas visitor status (ZU1-10) |
| [ZU8](hl7v2-zsegments.html#zu8---uk-miscellaneous-demographic-data) | UK Miscellaneous Demographics | O | [0..1] | Sexual orientation, consent, location hiding |
{:.grid}

### Message Structure - ADT^A40 (ADT_A39)

| Segment | Description | Usage | Card. | Notes |
|---------|-------------|-------|-------|-------|
| MSH | Message Header | R | [1..1] | |
| EVN | Event Type | R | [1..1] | |
| { PATIENT | | R | [1..1] | IHE: only one PATIENT group per message |
| &nbsp;&nbsp;PID | Patient Identification | R | [1..1] | **Surviving** patient: correct identifiers in PID-3 |
| &nbsp;&nbsp;[PD1] | Additional Demographics | O | [0..1] | |
| &nbsp;&nbsp;[MRG](hl7v2-segments.html#mrg---merge-patient-information) | Merge Information | R | [1..1] | **Non-surviving** patient identifiers in MRG-1 |
| &nbsp;&nbsp;[PV1] | Patient Visit | O | [0..1] | Not used in ITK |
| } | | | | |
{:.grid}

MRG-1 **shall** be "tightly coupled" with PID-3: every identifier in MRG-1 has an equivalent of the same type (assigning authority and identifier type) in PID-3, in the same position. All known identifiers of the non-surviving record **should** be sent, and at least one **should** identify the discarded record uniquely across all receiving systems.

### Expected Actions

The Consumer **shall** update its database according to:

- the data received;
- the data already on the receiving system;
- local rules on data ownership (HSCIC ITK 3.3.2).

| Field state in message | Consumer action |
|------------------------|-----------------|
| Field absent (not sent) | Leave the stored value unchanged |
| Field sent as `""` (HL7 null) | Delete the stored value |
| Field valued | Replace the stored value |
{:.grid}

On A40 the Consumer **shall** merge all data held against the non-surviving identifiers (MRG-1) into the surviving record (PID-3), and **shall not** treat the non-surviving identifiers as active. In FHIR this is expressed with `Patient.link`: the non-surviving Patient is `replaced-by` the surviving one and has `active` = false. The surviving Patient **may** also carry a `replaces` link to the non-surviving one. See the [A40 example](Bundle-Bundle-ADT-A40.html).

### FHIR Messaging

| v2 message | FHIR focus | Profile |
|------------|-----------|---------|
| A28, A31 | Patient | [PAM Patient](StructureDefinition-PAMPatient.html) (+ [PAM Related Person](StructureDefinition-PAMRelatedPerson.html) for NK1) |
| A40 | Surviving Patient (and the non-surviving Patient) | [PAM Patient](StructureDefinition-PAMPatient.html) with `link` |
{:.grid}

Examples: [ADT^A28](Bundle-Bundle-ADT-A28.html), [ADT^A40](Bundle-Bundle-ADT-A40.html).

### Security Considerations

Patient demographic feeds carry personal data and **shall** be exchanged only over secured channels (for example MLLP over TLS, or HSCN-restricted networks). Consumers **shall** honour [Location Hiding (ZU8-4)](hl7v2-zsegments.html#zu8---uk-miscellaneous-demographic-data) and the PDS S-flag. Suppliers and Consumers **should** audit these events (create, update, merge) in line with [IHE BALP](https://profiles.ihe.net/ITI/BALP/).
