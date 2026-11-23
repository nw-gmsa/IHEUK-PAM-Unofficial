RuleSet: MapCode(source, target, equivalence)
* group[=].element[+].code = #{source}
* group[=].element[=].target[+].code = #{target}
* group[=].element[=].target[=].equivalence = #{equivalence}

Instance:   HSCICSexToFHIRGender
InstanceOf: ConceptMap
Title:      "HSCIC Administrative Sex to FHIR Administrative Gender"
Description: "PID-8 HSCIC Table 0001 (NHS Person Gender Code) to FHIR Patient.gender."
Usage:      #definition
* name = "HSCICSexToFHIRGender"
* status = #draft
* experimental = false
* group[+].source = "https://fhir.ihe-uk.org/ITI/PAM/CodeSystem/hscic-administrative-sex"
* group[=].target = "http://hl7.org/fhir/administrative-gender"
* insert MapCode(0, unknown, equivalent)
* insert MapCode(1, male, equivalent)
* insert MapCode(2, female, equivalent)
* insert MapCode(9, other, equivalent)

Instance:   HL7SexToHSCICSex
InstanceOf: ConceptMap
Title:      "HL7 v2 Table 0001 to HSCIC Administrative Sex"
Description: "Mapping from international HL7 v2.5.1 Table 0001 (as required by IHE PAM) to the NHS Person Gender Code values of HSCIC Table 0001."
Usage:      #definition
* name = "HL7SexToHSCICSex"
* status = #draft
* experimental = false
* group[+].source = "http://terminology.hl7.org/CodeSystem/v2-0001"
* group[=].target = "https://fhir.ihe-uk.org/ITI/PAM/CodeSystem/hscic-administrative-sex"
* insert MapCode(A, 9, equivalent)
* insert MapCode(F, 2, equivalent)
* insert MapCode(M, 1, equivalent)
* insert MapCode(N, 0, wider)
* insert MapCode(O, 0, wider)
* insert MapCode(U, 0, equivalent)

Instance:   HSCICPatientClassToFHIR
InstanceOf: ConceptMap
Title:      "HSCIC Patient Class to FHIR Encounter class"
Description: "PV1-2 HSCIC Table 0004 Patient Class to FHIR Encounter.class (v3 ActCode)."
Usage:      #definition
* name = "HSCICPatientClassToFHIR"
* status = #draft
* experimental = false
* group[+].source = "https://fhir.ihe-uk.org/ITI/PAM/CodeSystem/hscic-patient-class"
* group[=].target = "http://terminology.hl7.org/CodeSystem/v3-ActCode"
* insert MapCode(I, IMP, equivalent)
* insert MapCode(O, AMB, equivalent)
* insert MapCode(E, EMER, equivalent)
* insert MapCode(P, PRENC, equivalent)
* insert MapCode(B, IMP, wider)
* insert MapCode(R, AMB, wider)

Instance:   HSCICNameTypeToFHIR
InstanceOf: ConceptMap
Title:      "HSCIC Name Type to FHIR Name Use"
Description: "XPN-7 HSCIC/PDS Name Type to FHIR HumanName.use."
Usage:      #definition
* name = "HSCICNameTypeToFHIR"
* status = #draft
* experimental = false
* group[+].source = "https://fhir.ihe-uk.org/ITI/PAM/CodeSystem/hscic-name-type"
* group[=].target = "http://hl7.org/fhir/name-use"
* insert MapCode(L, official, equivalent)
* insert MapCode(A, nickname, relatedto)
* insert MapCode(PREFERRED, usual, equivalent)
* insert MapCode(PREVIOUS-BIRTH, old, wider)
* insert MapCode(PREVIOUS-BACHELOR, old, wider)
* insert MapCode(PREVIOUS-MAIDEN, maiden, equivalent)
* insert MapCode(PREVIOUS, old, equivalent)

Instance:   HSCICAddressTypeToFHIR
InstanceOf: ConceptMap
Title:      "HSCIC Address Type to FHIR Address Use"
Description: "XAD-7 HSCIC/PDS Address Type to FHIR Address.use. PST (Correspondence) has no Address.use equivalent and is conveyed with Address.type = postal."
Usage:      #definition
* name = "HSCICAddressTypeToFHIR"
* status = #draft
* experimental = false
* group[+].source = "https://fhir.ihe-uk.org/ITI/PAM/CodeSystem/hscic-address-type"
* group[=].target = "http://hl7.org/fhir/address-use"
* insert MapCode(H, home, equivalent)
* insert MapCode(TMP, temp, equivalent)

Instance:   HSCICIdentityReliabilityToNHSNumberStatus
InstanceOf: ConceptMap
Title:      "HSCIC Identity Reliability to UK Core NHS Number Verification Status"
Description: "PID-32 NSTSnn codes to the UK Core NHS Number Verification Status (England), carried in the extension on Patient.identifier (NHS Number)."
Usage:      #definition
* name = "HSCICIdentityReliabilityToNHSNumberStatus"
* status = #draft
* experimental = false
* group[+].source = "https://fhir.ihe-uk.org/ITI/PAM/CodeSystem/hscic-identity-reliability"
* group[=].target = "https://fhir.hl7.org.uk/CodeSystem/UKCore-NHSNumberVerificationStatusEngland"
* insert MapCode(NSTS01, 01, equivalent)
* insert MapCode(NSTS02, 02, equivalent)
* insert MapCode(NSTS03, 03, equivalent)
* insert MapCode(NSTS04, 04, equivalent)
* insert MapCode(NSTS05, 05, equivalent)
* insert MapCode(NSTS06, 06, equivalent)
* insert MapCode(NSTS07, 07, equivalent)
* insert MapCode(NSTS08, 08, equivalent)

Instance:   HL7AdmissionTypeToNHSAdmissionMethod
InstanceOf: ConceptMap
Title:      "HL7 v2 Table 0007 to NHS Admission Method"
Description: "PV1-4 Admission Type. HSCIC Table 0007 uses the NHS Data Dictionary Admission Method codes, which are those of UK Core Admission Method (England). This maps international HL7 Table 0007 values to those codes."
Usage:      #definition
* name = "HL7AdmissionTypeToNHSAdmissionMethod"
* status = #draft
* experimental = false
* group[+].source = "http://terminology.hl7.org/CodeSystem/v2-0007"
* group[=].target = "https://fhir.hl7.org.uk/CodeSystem/UKCore-AdmissionMethodEngland"
* insert MapCode(A, 21, wider)
* insert MapCode(C, 13, equivalent)
* insert MapCode(E, 21, wider)
* insert MapCode(L, 31, wider)
* insert MapCode(N, 82, equivalent)
* insert MapCode(R, 12, equivalent)

Instance:   HL7AdmitSourceToNHSSourceOfAdmission
InstanceOf: ConceptMap
Title:      "HL7 v2 Table 0023 to NHS Source of Admission"
Description: "PV1-14 Admit Source. HSCIC Table 0023 uses NHS Data Dictionary Source of Admission codes (UK Core Source of Admission England). This maps international HL7 Table 0023 values to those codes."
Usage:      #definition
* name = "HL7AdmitSourceToNHSSourceOfAdmission"
* status = #draft
* experimental = false
* group[+].source = "http://terminology.hl7.org/CodeSystem/v2-0023"
* group[=].target = "https://fhir.hl7.org.uk/CodeSystem/UKCore-SourceOfAdmissionEngland"
* insert MapCode(6, 51, wider)
* insert MapCode(7, 51, wider)
* insert MapCode(8, 39, equivalent)
* insert MapCode(9, 19, wider)

Instance:   HL7MaritalStatusToNHSMaritalStatus
InstanceOf: ConceptMap
Title:      "HL7 v2 Table 0002 to NHS Person Marital Status"
Description: "PID-16 Marital Status. HSCIC Table 0002 uses NHS Data Dictionary Person Marital Status codes (UK Core Person Marital Status England)."
Usage:      #definition
* name = "HL7MaritalStatusToNHSMaritalStatus"
* status = #draft
* experimental = false
* group[+].source = "http://terminology.hl7.org/CodeSystem/v2-0002"
* group[=].target = "https://fhir.hl7.org.uk/CodeSystem/UKCore-PersonMaritalStatusEngland"
* insert MapCode(A, P, equivalent)
* insert MapCode(B, S, wider)
* insert MapCode(C, S, wider)
* insert MapCode(D, D, equivalent)
* insert MapCode(E, P, equivalent)
* insert MapCode(G, S, wider)
* insert MapCode(I, N, wider)
* insert MapCode(M, M, equivalent)
* insert MapCode(N, D, wider)
* insert MapCode(O, N, wider)
* insert MapCode(P, S, wider)
* insert MapCode(R, M, wider)
* insert MapCode(S, S, equivalent)
* insert MapCode(T, N, wider)
* insert MapCode(U, N, wider)
* insert MapCode(W, W, equivalent)

Instance:   HL7RelationshipToHSCICRelationship
InstanceOf: ConceptMap
Title:      "HL7 v2 Table 0063 to HSCIC Relationship"
Description: "NK1-3 Relationship. International HL7 Table 0063 to HSCIC/PDS Relationship Type."
Usage:      #definition
* name = "HL7RelationshipToHSCICRelationship"
* status = #draft
* experimental = false
* group[+].source = "http://terminology.hl7.org/CodeSystem/v2-0063"
* group[=].target = "https://fhir.ihe-uk.org/ITI/PAM/CodeSystem/hscic-relationship"
* insert MapCode(ASC, 99, wider)
* insert MapCode(BRO, 15, equivalent)
* insert MapCode(CGV, 20, equivalent)
* insert MapCode(CHD, 9, equivalent)
* insert MapCode(DEP, 10, wider)
* insert MapCode(DOM, 2, equivalent)
* insert MapCode(EMC, 17, wider)
* insert MapCode(EXF, 16, wider)
* insert MapCode(FCH, 9, wider)
* insert MapCode(FTH, 13, equivalent)
* insert MapCode(GCH, 16, wider)
* insert MapCode(GRD, 5, equivalent)
* insert MapCode(GRP, 16, wider)
* insert MapCode(MTH, 12, equivalent)
* insert MapCode(NCH, 9, wider)
* insert MapCode(NON, 98, wider)
* insert MapCode(OTH, 99, wider)
* insert MapCode(PAR, 3, equivalent)
* insert MapCode(SCH, 9, wider)
* insert MapCode(SEL, 21, equivalent)
* insert MapCode(SIB, 16, wider)
* insert MapCode(SIS, 14, equivalent)
* insert MapCode(SPO, 1, equivalent)
* insert MapCode(UNK, 98, equivalent)
