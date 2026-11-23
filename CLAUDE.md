# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project overview

Unofficial IHE UK national extension of IHE ITI **Patient Administration Management (PAM)** (ITI TF-1 ch 14, transactions ITI-30/ITI-31) and **Patient Identifier Cross-referencing (PIX)** (ITI TF-1 ch 5), modelled on the NW Genomics IHE LTW guide (`../nw-gmsa.github.com`, https://nw-gmsa.github.io/en/).

- Initial content: HSCIC ITK HL7 V2 Message Specifications v1.0.15 and Reference Tables v1.0.14 (PDFs in `Specifications/HSCIC`), originally HL7 v2.4. The original HSCIC example messages (v2.4, ER7 + v2 XML) are in `Specifications/HSCIC/HL7 v2 ADT Examples/`. Their ER7 (.txt) versions, with v2.5.1 conversions, are published on `hscic-examples.md`, which is **generated** by `python3 -I scripts/convert_hscic_examples.py "Specifications/HSCIC/HL7 v2 ADT Examples" input/pagecontent/hscic-examples.md` - edit the script (it implements the `hscic-changes.md` rules), not the page. Their FHIR Message equivalents (`input/fsh/Examples/HSCIC/HSCICMessages.fsh`) are **generated** by `python3 -I scripts/hscic_v2_to_fhir.py "Specifications/HSCIC/HL7 v2 ADT Examples" input/fsh/Examples/HSCIC/HSCICMessages.fsh` (it reuses the v2.5.1 conversion; run it before the page generator).
- Target: **HL7 v2.5.1** for v2 content; FHIR R4 profiles based on **HL7 Europe Base** (`hl7.fhir.eu.base`), with UK Core extensions/terminology.
- `id`: `ihe.uk.iti.pam`, `canonical`: `https://fhir.ihe-uk.org/ITI/PAM` (placeholder, see `sushi-config.yaml`).

## Build

`./_build.sh build` (SUSHI then IG Publisher → `output/`), `./_build.sh nosushi`, `./_build.sh notx`. `sushi build .` alone is a fast FSH check. QA via `output/qa.html`; suppress known-good warnings in `input/ignoreWarnings.txt`.

## Layout

- `input/fsh/Profiles/` - PAMPatient (PID/PD1/ZU8, parent `patient-eu`), PAMEncounter (PV1/PV2/ZU1), Location, Practitioner, Organization, RelatedPerson (NK1), AllergyIntolerance (AL1), Condition (DG1), Procedure (PR1), Messaging (MSH/EVN/Bundle).
- `input/fsh/DataTypes/` - Identifier profiles for v2 CX (NHS Number, MRN, Visit Number...).
- `input/fsh/Extensions/` - ZU segment / PV2 fields with no FHIR R4 element.
- `input/fsh/Terminology/` - HSCIC tables not in UK Core (CodeSystems + ValueSets), ConceptMaps HL7 v2 tables → NHS DD / FHIR.
- `input/fsh/MessageDefinition/` - one MessageDefinition per HSCIC trigger event (generated from a list; keep in sync with `ITI-30.md`/`ITI-31.md` tables and `CapabilityStatement/`).
- `input/fsh/Examples/Mobile.fsh` - PDQm/PIXm/PMIR examples (IHE packages `ihe.iti.pdqm`, `ihe.iti.pixm`, `ihe.iti.pmir`); they reuse the generated shared HSCIC patient. IHE.PDQm.Patient requires `identifier.system`, so only identifiers with a known system/OID can be used there.
- `input/resources/` - NHS England Treatment Function / Main Specialty CodeSystems and ValueSets copied from the deprecated `uk.nhsdigital.r4` 2.11.0 (canonicals kept via `special-url`).
- `input/pagecontent/` - narrative. v2 segment tables are in `hl7v2-segments.md` / `hl7v2-zsegments.md`; HSCIC→v2.5.1 deltas in `hscic-changes.md`.
- Each profile has a FSH `Mapping:` block (`Id: hl7v2`) giving the v2 field per element - keep these aligned with the segment tables.

## Conventions

- Markdown tables use kramdown with `{:.grid}`; escape `|` inside table cells as `<code>&#124;</code>`.
- Diagrams are inline Mermaid.
- Do not invent identifier system URIs. Use established systems (NHS Number, ODS, GMC/GMP) or `urn:oid:` of a real OID; otherwise omit `Identifier.system` (qualified by type + assigner). Example endpoints use `http://example.org/`.
- Do not use parentheses or commas in RuleSet arguments (SUSHI splits on them).
- `PV1-19` is the Hospital Provider Spell (inpatient stay or outpatient spell, CX-5 `AN`, `Encounter.identifier[hospitalProviderSpell]`); `PV1-50` is the outpatient attendance or consultant episode (CX-5 `VN`, `identifier[alternateVisitId]`). The HSCIC ADT examples are amended to this via `SPELLS` in `scripts/convert_hscic_examples.py`.
- SUSHI does not fill in slice pattern values (`use`, `type`) in instances: set them explicitly for sliced identifiers.
- The Example Scenario `InpatientLeaveAndDischarge` uses purpose-built HL7 v2.5.1 messages in `examples-v2/InpatientLeaveAndDischarge/` (source of truth). Their FHIR Messages (`input/fsh/Examples/ScenarioMessages.fsh`, one shared Encounter id) and page include (`input/includes/scenario-inpatient-leave-discharge-v2.md`) are **generated** by `python3 -I scripts/hscic_v2_to_fhir.py --scenario examples-v2/InpatientLeaveAndDischarge input/fsh/Examples/ScenarioMessages.fsh input/includes/scenario-inpatient-leave-discharge-v2.md`.
- UK Core extensions have no snapshot in the package: in instances set them with `extension[+].url = $alias` rather than by slice name.
