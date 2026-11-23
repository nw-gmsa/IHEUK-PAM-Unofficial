# HSCIC ITK HL7 v2 ADT Examples

Example messages from the HSCIC ITK HL7 V2 Domain Message Specification (DMS v1.1). They are **HL7 v2.4** (MSH-12 `2.4`) as published, not updated to v2.5.1; see `input/pagecontent/hscic-changes.md` for the differences.

Each interaction folder has the message in ER7 (pipe-delimited, `.txt`) and, where published, HL7 v2 XML encoding (`.XML`). Patients, organisations and practitioners in these examples are fictitious.

## AdvancedEncounterManagement

| Interaction | Example (ER7) | Scenario | XML |
|---|---|---|---|
| CancelLeaveOfAbsence ADT-A52 | [A52_Example.txt](AdvancedEncounterManagement/CancelLeaveOfAbsence%20ADT-A52/A52_Example.txt) | [A52_Scenario.txt](AdvancedEncounterManagement/CancelLeaveOfAbsence%20ADT-A52/A52_Scenario.txt) | [A52.XML](AdvancedEncounterManagement/CancelLeaveOfAbsence%20ADT-A52/A52.XML) |
| CancelReturnFromLeaveOfAbsence ADT-A53 | [A53_Example.txt](AdvancedEncounterManagement/CancelReturnFromLeaveOfAbsence%20ADT-A53/A53_Example.txt) | [A53_Scenario.txt](AdvancedEncounterManagement/CancelReturnFromLeaveOfAbsence%20ADT-A53/A53_Scenario.txt) | [A53.XML](AdvancedEncounterManagement/CancelReturnFromLeaveOfAbsence%20ADT-A53/A53.XML) |
| LeaveOfAbsence ADT-A21 | [A21_Example.txt](AdvancedEncounterManagement/LeaveOfAbsence%20ADT-A21/A21_Example.txt) | [A21_Scenario.txt](AdvancedEncounterManagement/LeaveOfAbsence%20ADT-A21/A21_Scenario.txt) | [A21.XML](AdvancedEncounterManagement/LeaveOfAbsence%20ADT-A21/A21.XML) |
| ReturnFromLeaveOfAbsence ADT-A22 | [A22_Example.txt](AdvancedEncounterManagement/ReturnFromLeaveOfAbsence%20ADT-A22/A22_Example.txt) | [A22_Scenario.txt](AdvancedEncounterManagement/ReturnFromLeaveOfAbsence%20ADT-A22/A22_Scenario.txt) | [A22.XML](AdvancedEncounterManagement/ReturnFromLeaveOfAbsence%20ADT-A22/A22.XML) |

## InpatientOutpatientEncounterManagement

| Interaction | Example (ER7) | Scenario | XML |
|---|---|---|---|
| CancelPreAdmitPatient ADT-A38 | [A38_example.txt](InpatientOutpatientEncounterManagement/CancelPreAdmitPatient%20ADT-A38/A38_example.txt) | [A38_scenario.txt](InpatientOutpatientEncounterManagement/CancelPreAdmitPatient%20ADT-A38/A38_scenario.txt) | [A38.XML](InpatientOutpatientEncounterManagement/CancelPreAdmitPatient%20ADT-A38/A38.XML) |
| CancelTransferPatient ADT-A12 | [A12_Example.txt](InpatientOutpatientEncounterManagement/CancelTransferPatient%20ADT-A12/A12_Example.txt) | [A12_scenario.txt](InpatientOutpatientEncounterManagement/CancelTransferPatient%20ADT-A12/A12_scenario.txt) | [A12.XML](InpatientOutpatientEncounterManagement/CancelTransferPatient%20ADT-A12/A12.XML) |
| PreAdmitPatient ADT-A05 | [A05_example.txt](InpatientOutpatientEncounterManagement/PreAdmitPatient%20ADT-A05/A05_example.txt) | [A05_scenario.txt](InpatientOutpatientEncounterManagement/PreAdmitPatient%20ADT-A05/A05_scenario.txt) | [A05.XML](InpatientOutpatientEncounterManagement/PreAdmitPatient%20ADT-A05/A05.XML) |
| TransferPatient ADT-A02 | [A02_Example.txt](InpatientOutpatientEncounterManagement/TransferPatient%20ADT-A02/A02_Example.txt) | [A02_scenario.txt](InpatientOutpatientEncounterManagement/TransferPatient%20ADT-A02/A02_scenario.txt) | [A02.XML](InpatientOutpatientEncounterManagement/TransferPatient%20ADT-A02/A02.XML) |

## InpatientOutpatientEncounterManagementUpdateMaster

| Interaction | Example (ER7) | Scenario | XML |
|---|---|---|---|
| CancelTransferPatientUpdateMaster ADT-A12 | [A12_Example.txt](InpatientOutpatientEncounterManagementUpdateMaster/CancelTransferPatientUpdateMaster%20ADT-A12/A12_Example.txt) | [A12_scenario.txt](InpatientOutpatientEncounterManagementUpdateMaster/CancelTransferPatientUpdateMaster%20ADT-A12/A12_scenario.txt) | [A12.XML](InpatientOutpatientEncounterManagementUpdateMaster/CancelTransferPatientUpdateMaster%20ADT-A12/A12.XML) |
| TransferPatientUpdateMaster ADT-A02 | [A02_Example.txt](InpatientOutpatientEncounterManagementUpdateMaster/TransferPatientUpdateMaster%20ADT-A02/A02_Example.txt) | [A02_scenario.txt](InpatientOutpatientEncounterManagementUpdateMaster/TransferPatientUpdateMaster%20ADT-A02/A02_scenario.txt) | [A02.XML](InpatientOutpatientEncounterManagementUpdateMaster/TransferPatientUpdateMaster%20ADT-A02/A02.XML) |

## PatientEncounterManagement

| Interaction | Example (ER7) | Scenario | XML |
|---|---|---|---|
| Cancel Discharge ADT-A13 | [A13_example.txt](PatientEncounterManagement/Cancel%20Discharge%20ADT-A13/A13_example.txt) | [A13_scenario.txt](PatientEncounterManagement/Cancel%20Discharge%20ADT-A13/A13_scenario.txt) | [A13.XML](PatientEncounterManagement/Cancel%20Discharge%20ADT-A13/A13.XML) |
| Cancel Inpatient ADT-A11 | [A11_example.txt](PatientEncounterManagement/Cancel%20Inpatient%20ADT-A11/A11_example.txt) | [A11_Scenario.txt](PatientEncounterManagement/Cancel%20Inpatient%20ADT-A11/A11_Scenario.txt) | [A11.XML](PatientEncounterManagement/Cancel%20Inpatient%20ADT-A11/A11.XML) |
| Discharge Patient ADT-A03 | [A03_example.txt](PatientEncounterManagement/Discharge%20Patient%20ADT-A03/A03_example.txt) | [A03_scenario.txt](PatientEncounterManagement/Discharge%20Patient%20ADT-A03/A03_scenario.txt) | [A03.XML](PatientEncounterManagement/Discharge%20Patient%20ADT-A03/A03.XML) |
| Inpatient Admission ADT-A01 | [A01_example.txt](PatientEncounterManagement/Inpatient%20Admission%20ADT-A01/A01_example.txt) | [A01_scenario.txt](PatientEncounterManagement/Inpatient%20Admission%20ADT-A01/A01_scenario.txt) | [A01.XML](PatientEncounterManagement/Inpatient%20Admission%20ADT-A01/A01.XML) |
| PreadmitPatient ADT-A05 | [A05_Example.txt](PatientEncounterManagement/PreadmitPatient%20ADT-A05/A05_Example.txt) | [A05_Scenario.txt](PatientEncounterManagement/PreadmitPatient%20ADT-A05/A05_Scenario.txt) | [A05.XML](PatientEncounterManagement/PreadmitPatient%20ADT-A05/A05.XML) |
| Register Outpatient ADT-A04 | [A04_example.txt](PatientEncounterManagement/Register%20Outpatient%20ADT-A04/A04_example.txt) | [A04_scenario.txt](PatientEncounterManagement/Register%20Outpatient%20ADT-A04/A04_scenario.txt) | [A04.XML](PatientEncounterManagement/Register%20Outpatient%20ADT-A04/A04.XML) |
| Update Encounter ADT-A08 | [A08_example.txt](PatientEncounterManagement/Update%20Encounter%20ADT-A08/A08_example.txt) | [A08_scenario.txt](PatientEncounterManagement/Update%20Encounter%20ADT-A08/A08_scenario.txt) | [A08.XML](PatientEncounterManagement/Update%20Encounter%20ADT-A08/A08.XML) |

## PatientEncounterManagementMaster

| Interaction | Example (ER7) | Scenario | XML |
|---|---|---|---|
| CancelDischargeMaster ADT-A13 | [A13_Example.txt](PatientEncounterManagementMaster/CancelDischargeMaster%20ADT-A13/A13_Example.txt) | [A13_Master_Scenario.txt](PatientEncounterManagementMaster/CancelDischargeMaster%20ADT-A13/A13_Master_Scenario.txt) | [A13.XML](PatientEncounterManagementMaster/CancelDischargeMaster%20ADT-A13/A13.XML) |
| DischargeMaster ADT-A03 | [A03_Example.txt](PatientEncounterManagementMaster/DischargeMaster%20ADT-A03/A03_Example.txt) | [A03_Master_Scenario.txt](PatientEncounterManagementMaster/DischargeMaster%20ADT-A03/A03_Master_Scenario.txt) | [A03.XML](PatientEncounterManagementMaster/DischargeMaster%20ADT-A03/A03.XML) |
| RegisterOutpatientUpdateMaster ADT-A04 | [A04_Example.txt](PatientEncounterManagementMaster/RegisterOutpatientUpdateMaster%20ADT-A04/A04_Example.txt) | [A04_Scenario.txt](PatientEncounterManagementMaster/RegisterOutpatientUpdateMaster%20ADT-A04/A04_Scenario.txt) | [A04.XML](PatientEncounterManagementMaster/RegisterOutpatientUpdateMaster%20ADT-A04/A04.XML) |

## PatientIdentityManagement

| Interaction | Example (ER7) | Scenario | XML |
|---|---|---|---|
| CreatePatient ADT-A28 | [A28_Example.txt](PatientIdentityManagement/CreatePatient%20ADT-A28/A28_Example.txt) | [A28_Scenario.txt](PatientIdentityManagement/CreatePatient%20ADT-A28/A28_Scenario.txt) | [A28.XML](PatientIdentityManagement/CreatePatient%20ADT-A28/A28.XML) |
| MergeTwoPatient ADT-A40 | [A40_Example.txt](PatientIdentityManagement/MergeTwoPatient%20ADT-A40/A40_Example.txt) | [A40_Scenario.txt](PatientIdentityManagement/MergeTwoPatient%20ADT-A40/A40_Scenario.txt) | [A40.XML](PatientIdentityManagement/MergeTwoPatient%20ADT-A40/A40.XML) |
| UpdatePatient ADT-A31 | [A31_example.txt](PatientIdentityManagement/UpdatePatient%20ADT-A31/A31_example.txt) | [A31_scenario.txt](PatientIdentityManagement/UpdatePatient%20ADT-A31/A31_scenario.txt) | [A31.XML](PatientIdentityManagement/UpdatePatient%20ADT-A31/A31.XML) |

## PatientIdentityManagementUpdateMaster

| Interaction | Example (ER7) | Scenario | XML |
|---|---|---|---|
| UpdatePatientUpdateMaster ADT-A31 | [A31_example.txt](PatientIdentityManagementUpdateMaster/UpdatePatientUpdateMaster%20ADT-A31/A31_example.txt) | [A31_scenario.txt](PatientIdentityManagementUpdateMaster/UpdatePatientUpdateMaster%20ADT-A31/A31_scenario.txt) | [A31.XML](PatientIdentityManagementUpdateMaster/UpdatePatientUpdateMaster%20ADT-A31/A31.XML) |

## PendingEncounterManagement

| Interaction | Example (ER7) | Scenario | XML |
|---|---|---|---|
| CancelPendingAdmit ADT-A27 | [A27_Example.txt](PendingEncounterManagement/CancelPendingAdmit%20ADT-A27/A27_Example.txt) | [A27_Scenario.txt](PendingEncounterManagement/CancelPendingAdmit%20ADT-A27/A27_Scenario.txt) | [A27.XML](PendingEncounterManagement/CancelPendingAdmit%20ADT-A27/A27.XML) |
| CancelPendingDischarge ADT-A25 | [A25_example.txt](PendingEncounterManagement/CancelPendingDischarge%20ADT-A25/A25_example.txt) | [A25_scenario.txt](PendingEncounterManagement/CancelPendingDischarge%20ADT-A25/A25_scenario.txt) | [A25.XML](PendingEncounterManagement/CancelPendingDischarge%20ADT-A25/A25.XML) |
| CancelPendingTransfer ADT-A26 | [A26_Example.txt](PendingEncounterManagement/CancelPendingTransfer%20ADT-A26/A26_Example.txt) | [A26_Scenario.txt](PendingEncounterManagement/CancelPendingTransfer%20ADT-A26/A26_Scenario.txt) | [A26.XML](PendingEncounterManagement/CancelPendingTransfer%20ADT-A26/A26.XML) |
| PendingAdmit ADT-A14 | [A14_Example.txt](PendingEncounterManagement/PendingAdmit%20ADT-A14/A14_Example.txt) | [A14_Scenario.txt](PendingEncounterManagement/PendingAdmit%20ADT-A14/A14_Scenario.txt) | [A14.XML](PendingEncounterManagement/PendingAdmit%20ADT-A14/A14.XML) |
| PendingDischarge ADT-A16 | [A16_example.txt](PendingEncounterManagement/PendingDischarge%20ADT-A16/A16_example.txt) | [A16_scenario.txt](PendingEncounterManagement/PendingDischarge%20ADT-A16/A16_scenario.txt) | [A16.XML](PendingEncounterManagement/PendingDischarge%20ADT-A16/A16.XML) |
| PendingTransfer ADT-A15 | [A15_Example.txt](PendingEncounterManagement/PendingTransfer%20ADT-A15/A15_Example.txt) | [A15_Scenario.txt](PendingEncounterManagement/PendingTransfer%20ADT-A15/A15_Scenario.txt) | [A15.XML](PendingEncounterManagement/PendingTransfer%20ADT-A15/A15.XML) |

## QueryPatient

| Interaction | Example (ER7) | Scenario | XML |
|---|---|---|---|
| CancelQuery | [J01.txt](QueryPatient/CancelQuery/J01.txt) | - | [J01.XML](QueryPatient/CancelQuery/J01.XML) |
| FindCandidatesQuery | [K22.txt](QueryPatient/FindCandidatesQuery/K22.txt) [Q22.txt](QueryPatient/FindCandidatesQuery/Q22.txt) | - | [K22.XML](QueryPatient/FindCandidatesQuery/K22.XML) [Q22.XML](QueryPatient/FindCandidatesQuery/Q22.XML) |
| QueryPatientDemographics | [K21.txt](QueryPatient/QueryPatientDemographics/K21.txt) [Q21.txt](QueryPatient/QueryPatientDemographics/Q21.txt) | - | [K21.XML](QueryPatient/QueryPatientDemographics/K21.XML) [Q21.XML](QueryPatient/QueryPatientDemographics/Q21.XML) |
| QueryPatientDemographicsAndVisit | [ZV1.txt](QueryPatient/QueryPatientDemographicsAndVisit/ZV1.txt) [ZV2.txt](QueryPatient/QueryPatientDemographicsAndVisit/ZV2.txt) | - | [ZV1.XML](QueryPatient/QueryPatientDemographicsAndVisit/ZV1.XML) [ZV2.XML](QueryPatient/QueryPatientDemographicsAndVisit/ZV2.XML) |
