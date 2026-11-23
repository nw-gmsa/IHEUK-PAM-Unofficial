This page is the UK national extension of [IHE ITI Patient Identifier Cross-reference for Mobile (PIXm)](https://profiles.ihe.net/ITI/PIXm/) version 3.1.0 (Trial Implementation, FHIR R4, package `ihe.iti.pixm#3.1.0`).

<div class="alert alert-danger">This section is currently being elaborated.</div>

PIXm is the FHIR alternative to the [PIX](PIX.html) transactions: the PIX Query [ITI-9] becomes ITI-83, and the Patient Identity Feed [ITI-8] (or the PAM [ITI-30](ITI-30.html) feed) becomes ITI-104.

### Actors and Transactions

| Actor | Transaction | Optionality | UK system | IHE CapabilityStatement |
|-------|-------------|-------------|-----------|-------------------------|
| Patient Identity Source | Patient Identity Feed FHIR [ITI-104] | R | PAS / EPR (one per patient identifier domain) | [Source](https://profiles.ihe.net/ITI/PIXm/CapabilityStatement-IHE.PIXm.Source.html) |
| Patient Identifier Cross-reference Consumer | Mobile Patient Identifier Cross-reference Query [ITI-83] | R | LIMS, RIS, Shared Care Record, apps | [Consumer](https://profiles.ihe.net/ITI/PIXm/CapabilityStatement-IHE.PIXm.Consumer.html) |
| Patient Identifier Cross-reference Manager | ITI-83 (responder), ITI-104 (responder) | R | Trust MPI, regional MPI / integration engine | [Manager](https://profiles.ihe.net/ITI/PIXm/CapabilityStatement-IHE.PIXm.Manager.html) |
{:.grid}

Option: **Remove Patient** (Source and Manager): the Source can delete a patient (conditional DELETE). There are no required actor groupings.

### Patient Identifier Cross-reference Query [ITI-83]

```
GET [base]/Patient/$ihe-pix?sourceIdentifier=https://fhir.nhs.uk/Id/nhs-number|9999999557
                           {&targetSystem=urn:oid:[OID of the target domain]}
```

- `sourceIdentifier` (exactly one): the known identifier as `system|value`.
- `targetSystem` (0..*): restricts the identifier domains returned.
- The response is a Parameters resource ([IHE.PIXm.Query.Parameters.Out](https://profiles.ihe.net/ITI/PIXm/StructureDefinition-IHE.PIXm.Query.Parameters.Out.html)) with a `targetIdentifier` for each cross-referenced identifier (system, value and assigner.display) and a `targetId` for each matching Patient resource. The source identifier is not returned.
- Errors: 404 (source identifier not found), 400 (source domain not recognised), 403 (target domain not recognised).

Example: [PIXm query response](Parameters-pixm-query-nhs-number.html) for the HSCIC example patient.

### Patient Identity Feed FHIR [ITI-104]

ITI-104 uses conditional FHIR operations on Patient, keyed on the Source's own identifier:

| v2 event | ITI-104 | Request |
|----------|---------|---------|
| A28 Create, A31 Update (ITI-30) / A01, A04, A05, A08 (ITI-8) | Add or Revise Patient | <code>PUT [base]/Patient?identifier=[system]&#124;[value]</code> with the Patient |
| A40 Merge | Resolve Duplicate Patient | <code>PUT [base]/Patient?identifier=[system]&#124;[non-surviving value]</code> with `active = false` and `link` (`type = replaced-by`) to the surviving patient's identifier |
| (no v2 equivalent in HSCIC ITK) | Remove Patient (option) | <code>DELETE [base]/Patient?identifier=[system]&#124;[value]</code> |
{:.grid}

Merge (A40) example body:

```json
{
  "resourceType": "Patient",
  "identifier": [ { "system": "urn:oid:[OID of the Trust MRN domain]", "value": "22789" } ],
  "active": false,
  "link": [ {
    "other": { "identifier": { "system": "https://fhir.nhs.uk/Id/nhs-number", "value": "9999999557" } },
    "type": "replaced-by"
  } ]
}
```

The Manager replaces its references to the non-surviving identifier with the surviving one, and then re-runs its cross-referencing. For a given patient identifier domain there **shall** be only one Patient Identity Source.

### UK national extension

- **Identifier domains:** the NHS Number (`https://fhir.nhs.uk/Id/nhs-number`) is the national domain. Each local domain (Trust MRN, departmental system IDs) **shall** be identified by its assigning authority's OID (`urn:oid:`). PIXm cannot cross-reference an identifier without a system, and this guide does not invent identifier URIs. See [PIX - Patient identifier domains in the NHS](PIX.html#patient-identifier-domains-in-the-nhs).
- **Profile:** ITI-104 sends Patients conforming to [IHE.PDQm.Patient](https://profiles.ihe.net/ITI/PDQm/StructureDefinition-IHE.PDQm.Patient.html). [PAM Patient](StructureDefinition-PAMPatient.html) is compatible when every identifier has a system.
- **Feeds from PAM:** a PAM Patient Demographics Supplier (PAS) can be the PIXm Patient Identity Source, mapping ITI-30 events as in the table above. The PIXm Manager may also proxy to a v2 PIX Manager.
- **Update notifications:** PIXm has no equivalent of PIX Update Notification [ITI-10]. Use [PMIR](PMIR.html) (ITI-94 subscription and ITI-93 feed).

### Security

ITI-83 and ITI-104 shall be audited (IHE BALP) and may be authorised with IHE IUA (scopes `ITI-83`, `ITI-104`).
