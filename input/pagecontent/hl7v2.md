These conventions apply to all HL7 v2.5.1 messages in this guide. They combine [IHE ITI TF-2 Appendix C](https://profiles.ihe.net/ITI/TF/Volume2/ch-C.html) (HL7 v2.x conventions) with HSCIC ITK section 3 and section 6.

### Usage codes

| Code | Meaning |
|------|---------|
| R | Required. Must be populated |
| RE | Required but may be empty. Must be populated if the sender holds the data |
| C | Conditional. The condition is given in the notes |
| O | Optional for the **consumer**. For the **sender** (PAS), treat as RE: HSCIC ITK requires sources to send ALL information they hold |
| X / `-` | Not used in this guide. HSCIC ITK "not used in ITK". Receivers shall ignore it if present |
{:.grid}

### Message delimiters

| Delimiter | Value | Encoding character position |
|-----------|-------|-----------------------------|
| Segment terminator | `<cr>` (hex 0D) | - (cannot be changed) |
| Field separator | <code>&#124;</code> | - |
| Component separator | `^` | 1 |
| Repetition separator | `~` | 2 |
| Escape character | `\` | 3 |
| Subcomponent separator | `&` | 4 |
{:.grid}

<div class="alert alert-info">
HSCIC ITK printed the encoding characters as <code>^&amp;~\</code>. HL7 v2.5.1 and IHE use <b><code>MSH-2</code> = <code>^~\&amp;</code></b> (component, repetition, escape, subcomponent). Senders <b>shall</b> use <code>^~\&amp;</code>.
</div>

### Message construction

HSCIC ITK 3.3.1 is unchanged. Trailing empty fields, components and subcomponents need not be sent: `ABC^DEF^^` is equivalent to `ABC^DEF`. Fields **should not** be padded to a fixed length.

### Null vs empty (updates and data replacement)

| Sent | Meaning | Consumer action on update |
|------|---------|---------------------------|
| field absent (<code>&#124;&#124;</code>) | Not sent / not known | Keep the existing value |
| `""` | Explicit null | Delete the existing value |
| value | Value | Replace |
{:.grid}

The sender constructs a **fully populated** message for every trigger event: all required fields and all optional fields for which it holds values (HSCIC ITK 3.3.2).

### Field lengths

HSCIC ITK set maximum field lengths to stay within the constraints of PDS and the NHS Data Dictionary (e.g. names 35 characters, postcode 8 characters). These lengths are retained and are shown in the [segment definitions](hl7v2-segments.html). Where none is given, the HL7 v2.5.1 length applies. Lengths are not enforced by schema.

### Character set and language

| Field | Value |
|-------|-------|
| MSH-17 Country Code | `GBR` (ISO 3166-1 alpha-3) |
| MSH-18 Character Set | `UNICODE UTF-8` recommended. Empty means ASCII |
| MSH-19 Principal Language of Message | `en` (ISO 639-1) |
{:.grid}

### Data types (v2.5.1)

| Type | Name | HSCIC ITK usage | v2.5.1 changes | FHIR |
|------|------|-----------------|----------------|------|
| CE | Coded Element | Identifier^Text^Coding System | Unchanged. CWE preferred for new fields | CodeableConcept |
| CX | Extended Composite ID | CX-1 ID, CX-4 Assigning Authority. CX-5 "not used" | **CX-5 Identifier Type Code is required** (IHE PAM) | [PAM Identifier](StructureDefinition-PAMIdentifier.html) |
| DLD | Discharge to Location and Date | (CM in v2.4) | Used by PV1-37 | CodeableConcept + dateTime |
| DTM | Date/Time | - | New primitive; TS-1 is a DTM | dateTime / instant |
| EI | Entity Identifier | MSH-21 | MSH-21 is EI in v2.5 | Identifier / uri |
| HD | Hierarchic Designator | ODS code in HD-1 | HD-2 Universal ID + HD-3 `ISO` recommended for OIDs | Identifier.system / Organization.identifier |
| MSG | Message Type | MSH-9 `ADT^A01^ADT_A01` | Unchanged | MessageHeader.eventCoding |
| PL | Person Location | PL-2 ward, PL-3 bed, PL-4 facility | Unchanged | [PAM Location](StructureDefinition-PAMLocation.html) |
| TS | Time Stamp | `YYYYMMDD[HHMM[SS]]` | TS-2 Degree of Precision is deprecated. Time zone `+/-ZZZZ` **should** be sent | dateTime |
| XAD | Extended Address | XAD-1..7, XAD-9 | Unchanged | Address ([HL7 Europe Address](http://hl7.eu/fhir/base/StructureDefinition/Address-eu)) |
| XCN | Extended Composite ID and Name for Persons | XCN-1 national code, XCN-2.. name | Unchanged | Reference(PAMPractitioner) |
| XON | Extended Composite Name and ID for Organisations | XON-1 name, XON-3 ID | **XON-10 Organization Identifier** is preferred to XON-3 (retained for backward compatibility) | Reference(PAMOrganization) |
| XPN | Extended Person Name | XPN-7 PDS name type | See [Name type](#name-type-xpn-7) | HumanName |
| XTN | Extended Telecommunication Number | XTN-1 as a single unformatted string; XTN-4 email | XTN-1 retained; **XTN-12 Unformatted Telephone Number** may also be sent | ContactPoint |
{:.grid}

#### Name type (XPN-7)

HSCIC ITK overrode HL7 Table 0200 with PDS values of up to 17 characters. XPN-7 in v2.5.1 is an `ID` with a 1-character HL7 Table 0200 value, as required by IHE. Senders **shall** use HL7 Table 0200. Receivers **should** accept the legacy PDS values.

| HL7 Table 0200 (v2.5.1) | Legacy HSCIC/PDS value | FHIR HumanName.use |
|-------------------------|------------------------|--------------------|
| L Legal | L | official |
| A Alias | A | nickname / anonymous |
| N Nickname / "call me" | PREFERRED | usual |
| B Name at birth | PREVIOUS-BIRTH | old |
| M Maiden name | PREVIOUS-MAIDEN | maiden |
| U Unspecified | PREVIOUS / PREVIOUS-BACHELOR | old |
{:.grid}

The legal name is sent in the first repetition of PID-5. If the legal name is not known, the literal `Unknown` is sent as the family name.

#### Telephone numbers (XTN)

The telephone number **should** be sent in XTN-1 as a single string with no sub-delimiting. XTN-2 (Telecommunication Use Code, HL7 Table 0201) and XTN-3 (Telecommunication Equipment Type, HL7 Table 0202) distinguish the primary landline (`PRN^PH`) from the mobile (`ORN^CP`). Email addresses are sent as `^NET^Internet^name@example.nhs.uk`.

### Acknowledgements

- **Original mode** (default): MSH-15 and MSH-16 are empty. The receiver returns `ACK^<event>^ACK` with `MSA-1` = `AA`, `AE` or `AR`, and `MSA-2` = the MSH-10 of the message being acknowledged.
- **Enhanced mode**: required only by the IHE *Acknowledgement Support* option. MSH-15 = `AL` and MSH-16 = `NE` or `AL`. HSCIC ITK did not support enhanced mode.
- `ERR` (v2.5.1): ERR-2 Error Location, ERR-3 HL7 Error Code (HL7 Table 0357) and ERR-4 Severity are used. ERR-1 (ELD) is retained for backward compatibility only.

```
MSH|^~\&|LIMS|R0A|PAS|R0A|20261120101603+0000||ACK^A01^ACK|ACK0001|P|2.5.1|||||GBR||en
MSA|AA|MSG00002
```
