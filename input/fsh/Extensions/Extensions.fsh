Extension:   OverseasVisitorStatus
Id:          Extension-OverseasVisitorStatus
Title:       "Overseas Visitor Status"
Description: "HSCIC ITK `ZU1-10` Overseas Visitor Status. HSCIC ITK states PID-26 Citizenship is NOT to be used to carry the Overseas Visitor Status."
Context:     Patient
* value[x] only CodeableConcept
* value[x] from OverseasVisitorStatusVS (required)

Extension:   LocationHiding
Id:          Extension-LocationHiding
Title:       "Location Hiding"
Description: """
HSCIC ITK `ZU8-4` Location Hiding. Systems MUST offer the ability to shield patient location details, for example to protect the location details of an abused spouse. Shielding typically involves blanking/obscuring addresses, telephone numbers, email addresses, next of kin and GP details.

Where location hiding applies (codes `1` or `2`), the Patient resource SHOULD also carry `meta.security` = `R` (restricted) from `v3-Confidentiality`.
"""
Context:     Patient
* value[x] only CodeableConcept
* value[x] from LocationHidingVS (required)

Extension:   IdentityUnknownIndicator
Id:          Extension-IdentityUnknownIndicator
Title:       "Identity Unknown Indicator"
Description: """
`PID-31` Identity Unknown Indicator (HSCIC Table ZU050). `true` indicates a **Pseudo Person** (e.g. John Doe, newborn, minimal demographics): receivers must not attempt "fuzzy" matching, only exact identifier matching. A Full Person can never be demoted to a Pseudo Person.
"""
Context:     Patient
* value[x] only boolean

Extension:   DecisionToAdmitDateTime
Id:          Extension-DecisionToAdmitDateTime
Title:       "Decision To Admit Date Time"
Description: "HSCIC ITK `ZU1-1` Date of decision to admit. The date a clinical decision was made by, or on behalf of, someone with the right of admission to admit the patient to a hospital bed, either immediately or in the future."
Context:     Encounter
* value[x] only dateTime

Extension:   IntendedManagement
Id:          Extension-IntendedManagement
Title:       "Intended Management"
Description: "HSCIC ITK `ZU1-2` Intended Management. Describes what is intended to happen to the patient (Encounter.class / PV1-2 describes what actually happens)."
Context:     Encounter
* value[x] only CodeableConcept
* value[x] from IntendedManagementVS (required)

Extension:   ReadyForDischargeDateTime
Id:          Extension-ReadyForDischargeDateTime
Title:       "Ready For Discharge Date Time"
Description: "HSCIC ITK `ZU1-24` Ready for Discharge - date the patient became medically fit for discharge (see also `ZU1-22` Medically Fit Indicator)."
Context:     Encounter
* value[x] only dateTime

Extension:   PlannedStartDate
Id:          Extension-PlannedStartDate
Title:       "Planned Start Date (Expected Admit Date/Time)"
Description: "`PV2-8` Expected Admit Date/Time. Required in A05 Pre-Admit and A14 Pending Admit. Equivalent to FHIR R5 `Encounter.plannedStartDate`."
Context:     Encounter
* value[x] only dateTime

Extension:   PlannedEndDate
Id:          Extension-PlannedEndDate
Title:       "Planned End Date (Expected Discharge Date/Time)"
Description: "`PV2-9` Expected Discharge Date/Time. Required in A16 Pending Discharge. Equivalent to FHIR R5 `Encounter.plannedEndDate`."
Context:     Encounter
* value[x] only dateTime
