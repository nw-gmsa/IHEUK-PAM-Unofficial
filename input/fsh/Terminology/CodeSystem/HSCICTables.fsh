// HSCIC ITK HL7 V2 Reference Tables v1.0.14 (NPFIT-ELIBR-AREL-DST-0376).
// Only tables without an equivalent UK Core / HL7 Terminology CodeSystem are defined here.

CodeSystem:  HSCICAdministrativeSex
Id:          hscic-administrative-sex
Title:       "HSCIC Administrative Sex (Table 0001)"
Description: "HSCIC ITK User Table 0001 - Administrative Sex, based on NHS Data Dictionary Person Gender Code. Used in PID-8 and NK1-15. HL7 v2.5.1 senders SHOULD use HL7 Table 0001 (M, F, U, O, A, N); see ConceptMap HL7 Table 0001 to NHS Person Gender."
* ^caseSensitive = true
* ^experimental = false
* #0 "Not Known" "The gender of the person has not been recorded."
* #1 "Male"
* #2 "Female"
* #9 "Not specified" "Indeterminate, i.e. unable to be classified as either male or female."

CodeSystem:  HSCICPatientClass
Id:          hscic-patient-class
Title:       "HSCIC Patient Class (Table 0004)"
Description: "HSCIC ITK User Table 0004 - Patient Class. Used in PV1-2."
* ^caseSensitive = true
* ^experimental = false
* #B "Obstetrics"
* #C "Commercial Account"
* #E "Emergency"
* #I "Inpatient"
* #N "Not Applicable"
* #O "Outpatient"
* #P "Pre-admit"
* #R "Recurring patient"
* #U "Unknown"
* #W "Waiting List"

CodeSystem:  HSCICNameType
Id:          hscic-name-type
Title:       "HSCIC Name Type (Table 0200, PDS)"
Description: "HSCIC ITK override of HL7 Table 0200 using the Personal Demographics Service (PDS) / MIM name types. Used in XPN-7 of PID-5."
* ^caseSensitive = true
* ^experimental = false
* #L "Usual/Legal (current) name"
* #A "Alias name"
* #PREFERRED "Preferred name"
* #PREVIOUS-BIRTH "Birth name"
* #PREVIOUS-BACHELOR "Bachelor name"
* #PREVIOUS-MAIDEN "Maiden name"
* #PREVIOUS "Other previous name"

CodeSystem:  HSCICAddressType
Id:          hscic-address-type
Title:       "HSCIC Address Type (Table 0190, PDS)"
Description: "HSCIC ITK address types as per PDS. Used in XAD-7 of PID-11 and NK1-4."
* ^caseSensitive = true
* ^experimental = false
* #H "Home"
* #PST "Correspondence (Postal)"
* #TMP "Temporary"

CodeSystem:  HSCICRelationship
Id:          hscic-relationship
Title:       "HSCIC Relationship (Table 0063, PDS)"
Description: "HSCIC ITK User Table 0063 - Relationship, sourced from the PDS data item Relationship Type. Used in NK1-3 and NK1-7 (HSCIC Table 0131 Contact Role uses the same values)."
* ^caseSensitive = true
* ^experimental = false
* #1 "Spouse"
* #2 "Partner"
* #3 "Parent"
* #4 "Next of kin"
* #5 "Guardian" "Other than a parent"
* #6 "Foster parent"
* #9 "Child"
* #10 "Dependant"
* #11 "Non-dependant"
* #12 "Mother"
* #13 "Father"
* #14 "Sister"
* #15 "Brother"
* #16 "Relative"
* #17 "Proxy - Contact"
* #18 "Proxy - Communication"
* #19 "Proxy - Contact and Communication"
* #20 "Carer"
* #21 "Self"
* #61 "Step parent"
* #62 "Polygamous partner"
* #98 "Not Known"
* #99 "Not specified"

CodeSystem:  HSCICIdentityReliability
Id:          hscic-identity-reliability
Title:       "HSCIC Identity Reliability Code (Table 0445)"
Description: "HSCIC ITK User Table 0445 - Identity Reliability Code. Used in PID-32. A maximum of one NHS Number Tracing Status (NSTSnn) value shall be included in this repeating field. NSTS codes are from the NHS Data Dictionary NHS Number Status Indicator."
* ^caseSensitive = true
* ^experimental = false
* #US "Unknown/Default Social Security Number"
* #UD "Unknown/Default Date of Birth"
* #UA "Unknown/Default Address"
* #AL "Patient/Person Name is an Alias"
* #ED "Estimated Date of Birth"
* #NSTS01 "Number present and verified"
* #NSTS02 "Number present but not traced"
* #NSTS03 "Trace required"
* #NSTS04 "Trace attempted - No match or multiple match found"
* #NSTS05 "Trace needs to be resolved - (NHS Number or patient detail conflict)"
* #NSTS06 "Trace in progress"
* #NSTS07 "Number not present and trace not required"
* #NSTS08 "Trace postponed (baby under six weeks old)"

CodeSystem:  HSCICDischargeDisposition
Id:          hscic-discharge-disposition
Title:       "HSCIC Discharge Disposition (Table 0112)"
Description: "HSCIC ITK User Table 0112 - Discharge Disposition. Used in PV1-36. Values are from the NHS Data Dictionary A&E Attendance Disposal and Discharge Method. For admitted patient care, FHIR implementations SHOULD use the UK Core Discharge Method extension."
* ^caseSensitive = true
* ^experimental = false
* #1 "Admitted as inpatient"
* #2 "GP Follow Up"
* #3 "No Follow Up Required"
* #4 "Referred to A&E Clinic"
* #5 "Stillbirth"
* #6 "Referral to Outpatient Clinic"
* #7 "Transferred to Other Health Care Provider"
* #8 "Not applicable" "Hospital Provider Spell not yet finished (i.e. not discharged)"
* #9 "Not known"
* #10 "Died in Department"
* #11 "Referred to Other Health Care Profession"
* #12 "Left Department Before Treatment"
* #13 "Left Department - Refused Treatment"
* #14 "Other"

CodeSystem:  OverseasVisitorStatusCS
Id:          overseas-visitor-status
Title:       "Overseas Visitor Status Classification (Table 0171)"
Description: "HSCIC ITK User Table 0171 - Citizenship (Overseas Visitor Status), sourced from the NHS Data Dictionary Overseas Visitor Status Classification. Carried in ZU1-10 (not PID-26)."
* ^caseSensitive = true
* ^experimental = false
* #1 "Exempt from payment - subject to reciprocal health agreement"
* #2 "Exempt from payment - other"
* #3 "To pay hotel fees only"
* #4 "To pay all fees"
* #8 "Not applicable" "Not an Overseas Visitor"
* #9 "Charging rate not known"

CodeSystem:  IntendedManagementCS
Id:          intended-management
Title:       "Intended Management (Table ZU051)"
Description: "HSCIC ITK User Table ZU051 - Intended Management, sourced from the NHS Data Dictionary. Used in ZU1-2."
* ^caseSensitive = true
* ^experimental = false
* #1 "Patient to stay in hospital for at least one night"
* #2 "Patient not to stay in hospital overnight"
* #3 "Patient to be admitted for a planned sequence of admissions each involving at least one overnight stay"
* #4 "Patient to be admitted for a planned sequence of admissions which do not involve an overnight stay"
* #5 "Patient to be admitted regularly for a planned sequence of nights who returns home for the remainder of the 24 hour period"
* #8 "Not applicable"
* #9 "Not known"

CodeSystem:  LocationHidingCS
Id:          location-hiding
Title:       "Location Hiding (Table ZU057)"
Description: "HSCIC ITK User Table ZU057 - Location Hiding. Used in ZU8-4. Systems MUST offer the ability to shield patient location details (addresses, telephone numbers, email addresses, next of kin and GP details)."
* ^caseSensitive = true
* ^experimental = false
* #0 "No location hiding"
* #1 "Local location hiding"
* #2 "National S-flag determines location hiding" "Refer to the PDS data item Information Sensitivity Indicator."

CodeSystem:  DCRConsentToShare
Id:          dcr-consent-to-share
Title:       "DCR Consent to Share Indicator (Table ZU056)"
Description: "HSCIC ITK User Table ZU056 - Detailed Care Record (DCR) Consent to Share Indicator, from the PDS data item Consent to Share Indicator. Used in ZU8-2. If no value is present, consent is implied."
* ^caseSensitive = true
* ^experimental = false
* #1 "Express consent"
* #2 "Express dissent"
* #3 "Consent Status Unknown"

CodeSystem:  SCRConsentToStore
Id:          scr-consent-to-store
Title:       "SCR Consent to Store (Table ZU058)"
Description: "HSCIC ITK User Table ZU058 - Summary Care Record (SCR) Consent to Store. Used in ZU8-3. If no value is present the patient must be asked every time for permission to view their Summary Care Record."
* ^caseSensitive = true
* ^experimental = false
* #Yes "Yes" "Patient need not be asked every time for permission to view their Summary Care Record."
* #No "No" "Patient does not wish to have a Summary Care Record."

CodeSystem:  SexualOrientation
Id:          sexual-orientation
Title:       "Sexual Orientation (Table ZU032)"
Description: "HSCIC ITK User Table ZU032 - Sexual Orientation. Used in ZU8-1. Where a system is not specific about the type of homosexuality, '2' MUST be used instead of '2a' or '2b'."
* ^caseSensitive = true
* ^experimental = false
* #1 "Heterosexual"
* #2 "Homosexual (Not Specified)"
* #2a "Gay Man"
* #2b "Lesbian / Gay Woman"
* #3 "Bisexual"
* #4 "Not Certain"
* #U "Unknown"
* #X "Other"
* #Z "Not Stated" "Person asked but declined to respond"
