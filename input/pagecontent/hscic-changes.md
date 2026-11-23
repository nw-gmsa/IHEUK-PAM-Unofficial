This page lists the changes made to the HSCIC ITK HL7 v2 Message Specification (v1.0.15) and Reference Tables (v1.0.14) to move them from HL7 v2.4 to HL7 v2.5.1 and align them with IHE PAM and PIX. The aim is that **existing ITK feeds need only small changes to conform**. Where a change could break existing receivers, receivers are asked to accept the legacy form as well.

<div class="alert alert-danger">These changes are proposals for discussion. They have not been agreed by NHS England, HL7 UK or IHE UK.</div>

### Summary of changes

| # | Area | HSCIC ITK (v2.4) | This guide (v2.5.1) | Impact |
|---|------|------------------|---------------------|--------|
| 1 | MSH-12 Version | `2.4` | `2.5.1` | Senders |
| 2 | MSH-2 Encoding characters | Printed as `^&~\` | `^~\&` (HL7 standard) | Typographical in HSCIC; most senders already use `^~\&` |
| 3 | MSH-21 Message Profile Identifier | `ITKv1.0`, ID | EI. ITK value retained, plus an IHE UK PAM profile identifier | Senders (additive) |
| 4 | MSH-15/16 Acknowledgment types | Not supported | Empty (original mode). `AL` permitted under the IHE Acknowledgement Support option | None for original mode |
| 5 | PID-3 CX-4 for NHS Number | `NHS` | `NHS&2.16.840.1.113883.2.1.4.1&ISO` | Senders. Receivers accept both |
| 6 | PID-3 CX-5 Identifier Type Code | Not used | **Required**: `NH` (NHS Number), `MR` (local) | Senders. IHE PAM requires CX-5 |
| 7 | PID-8 Administrative Sex | NHS DD numeric (`0`,`1`,`2`,`9`) | HL7 Table 0001 (`U`,`M`,`F`,`O`,`A`,`N`) | Senders. Receivers accept both ([ConceptMap](ConceptMap-HL7SexToHSCICSex.html)) |
| 8 | XPN-7 Name Type | PDS values up to 17 characters (`PREFERRED`, `PREVIOUS-BIRTH`...) | HL7 Table 0200 single character | Senders. Receivers accept both ([mapping](hl7v2.html#name-type-xpn-7)) |
| 9 | PV1-10 Hospital Service, PV1-14 Admit Source | CE | IS (HL7 v2.5.1 data type) | Send the code only, without `^text^system` |
| 10 | PV1-37 Discharged to Location | CM | DLD | Format unchanged (`code^date`) |
| 11 | PV1-19 CX-5 | - | `VN` | Senders |
| 11a | PID-18 Patient Account Number | Not used in ITK (defined in 5.3.8) | Conditional: Hospital Provider Spell number, CX-5 `AN`, for admitted patient care events | Senders of admitted patient care events |
| 12 | XON (PD1-3) | XON-3 ID Number | XON-10 Organization Identifier preferred; XON-3 still accepted | Senders |
| 13 | EVN-4, EVN-7 | Not used | Permitted | None |
| 14 | ERR | ERR-1 ELD | ERR-2, ERR-3, ERR-4 (v2.5) | Receivers that return errors |
| 15 | PID-33, PID-34 | Not used | Conditional: required under the PIX Pediatric Demographics option | Optional |
| 16 | ITI-30 A28/A31 PV1 | `[PV1]` optional | PV1 required with PV1-2 = `N` | Senders |
| 17 | A08 | "Update Encounter Information" | Restricted to encounter updates (ITI-31); pure demographic updates use A31 (ITI-30) | Senders |
| 18 | Merge | A40 only | A40 required (Merge option); A47 recommended | Additive |
| 19 | IHE options not in ITK | - | A06, A07, A09, A10, A32, A33, A44, A54, A55, ZBE/Z99 allowed as in ITI TF-2 | Additive |
| 20 | Z segments | At end of message | Unchanged, order fixed (ZU1, ZU3-ZU8). ZU2 remains withdrawn | None |
| 21 | ZU1-27 | Legacy NHS Number tracing status | Unchanged (legacy). Use PID-32 | None |
| 22 | Queries Q21/Q22/ZV1 | Defined in ITK 4.30-4.33 | Out of scope; see IHE PDQ / PDQm | - |
| 23 | Transport | ITK web services | MLLP (v2) and FHIR Messaging. ITK transport is out of scope | - |
{:.grid}

Each of these rules is applied to the original HSCIC ITK example messages on [HSCIC ITK Example Messages](hscic-examples.html).

### Unchanged

The following HSCIC ITK rules carry forward without change:

- Senders send **all** information they hold (`O` = `RE` for the sender).
- Null (`""`) vs absent semantics, and the update and data replacement rules.
- Field lengths from PDS and the NHS Data Dictionary.
- A traced NHS Number **must** be sent in PID-3 when available.
- PID-9 Patient Alias and PD1-12 Protection Indicator must **not** be populated.
- PID-26 Citizenship must **not** carry Overseas Visitor Status (use ZU1-10).
- The contents of the ZU1, ZU3-ZU8 segments.
- The NHS Data Dictionary values of the Reference Tables.

### Document history of the source

| Source | Version | Date | Notes |
|--------|---------|------|-------|
| HSCIC ITK HL7 V2 Message Specifications (NPFIT-ELIBR-AREL-DST-0369) | 1.0.15 | 30/06/2014 | HSCIC re-branding; MSH-15/16 conditions removed |
| HSCIC ITK HL7 V2 Reference Tables (NPFIT-ELIBR-AREL-DST-0376) | 1.0.14 | 30/06/2014 | |
{:.grid}
