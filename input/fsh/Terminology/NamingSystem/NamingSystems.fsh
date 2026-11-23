Instance:   nhs-number
InstanceOf: NamingSystem
Title:      "NHS Number Naming System"
Description: "NHS Number (England and Wales). OID 2.16.840.1.113883.2.1.4.1. HL7 v2 PID-3 CX-4 `NHS`."
Usage:      #definition
* name = "NHSNumber"
* status = #draft
* kind = #identifier
* date = "2026-11-23"
* publisher = "NHS North West Genomics"
* type = $v2-0203#NH
* description = "NHS Number (England and Wales). OID 2.16.840.1.113883.2.1.4.1. HL7 v2 PID-3 CX-4 `NHS`."
* jurisdiction = urn:iso:std:iso:3166#GB "United Kingdom of Great Britain and Northern Ireland"
* uniqueId[+].type = #uri
* uniqueId[=].value = "https://fhir.nhs.uk/Id/nhs-number"
* uniqueId[=].preferred = true
* uniqueId[+].type = #oid
* uniqueId[=].value = "2.16.840.1.113883.2.1.4.1"

Instance:   ods-organization-code
InstanceOf: NamingSystem
Title:      "ODS Organisation Code Naming System"
Description: "NHS Organisation Data Service (ODS) organisation code. HL7 v2 MSH-4, MSH-6, CX-6, PD1-3."
Usage:      #definition
* name = "ODSOrganisationCode"
* status = #draft
* kind = #identifier
* date = "2026-11-23"
* publisher = "NHS North West Genomics"
* type = $v2-0203#XX
* description = "NHS Organisation Data Service (ODS) organisation code. HL7 v2 MSH-4, MSH-6, CX-6, PD1-3."
* jurisdiction = urn:iso:std:iso:3166#GB "United Kingdom of Great Britain and Northern Ireland"
* uniqueId[+].type = #uri
* uniqueId[=].value = "https://fhir.nhs.uk/Id/ods-organization-code"
* uniqueId[=].preferred = true

Instance:   ods-site-code
InstanceOf: NamingSystem
Title:      "ODS Site Code Naming System"
Description: "NHS ODS site code (formerly NACS). HL7 v2 PL-4."
Usage:      #definition
* name = "ODSSiteCode"
* status = #draft
* kind = #identifier
* date = "2026-11-23"
* publisher = "NHS North West Genomics"
* type = $v2-0203#XX
* description = "NHS ODS site code (formerly NACS). HL7 v2 PL-4."
* jurisdiction = urn:iso:std:iso:3166#GB "United Kingdom of Great Britain and Northern Ireland"
* uniqueId[+].type = #uri
* uniqueId[=].value = "https://fhir.nhs.uk/Id/ods-site-code"
* uniqueId[=].preferred = true

Instance:   gmc-number
InstanceOf: NamingSystem
Title:      "GMC Number Naming System"
Description: "General Medical Council number (consultant code). HL7 v2 XCN-1 (PV1-7, PV1-8, PV1-9, PV1-17)."
Usage:      #definition
* name = "GMCNumber"
* status = #draft
* kind = #identifier
* date = "2026-11-23"
* publisher = "NHS North West Genomics"
* type = $v2-0203#MD
* description = "General Medical Council number (consultant code). HL7 v2 XCN-1 (PV1-7, PV1-8, PV1-9, PV1-17)."
* jurisdiction = urn:iso:std:iso:3166#GB "United Kingdom of Great Britain and Northern Ireland"
* uniqueId[+].type = #uri
* uniqueId[=].value = "https://fhir.hl7.org.uk/Id/gmc-number"
* uniqueId[=].preferred = true

Instance:   gmp-number
InstanceOf: NamingSystem
Title:      "GP National Code Naming System"
Description: "National GP code (G + 6 digits + check digit). HL7 v2 PD1-4 XCN-1."
Usage:      #definition
* name = "GMPNumber"
* status = #draft
* kind = #identifier
* date = "2026-11-23"
* publisher = "NHS North West Genomics"
* type = $v2-0203#MD
* description = "National GP code (G + 6 digits + check digit). HL7 v2 PD1-4 XCN-1."
* jurisdiction = urn:iso:std:iso:3166#GB "United Kingdom of Great Britain and Northern Ireland"
* uniqueId[+].type = #uri
* uniqueId[=].value = "https://fhir.hl7.org.uk/Id/gmp-number"
* uniqueId[=].preferred = true

Instance:   example-trust-mrn
InstanceOf: NamingSystem
Title:      "Example Trust Medical Record Number Naming System"
Description: "Example only: local hospital number of an NHS Trust. Each Trust defines its own system."
Usage:      #definition
* name = "ExampleTrustMRN"
* status = #draft
* kind = #identifier
* date = "2026-11-23"
* publisher = "NHS North West Genomics"
* type = $v2-0203#MR
* description = "Example only: local hospital number of an NHS Trust. Each Trust defines its own system."
* jurisdiction = urn:iso:std:iso:3166#GB "United Kingdom of Great Britain and Northern Ireland"
* uniqueId[+].type = #uri
* uniqueId[=].value = "https://fhir.example-trust.nhs.uk/Id/mrn"
* uniqueId[=].preferred = true

Instance:   example-trust-visit-number
InstanceOf: NamingSystem
Title:      "Example Trust Visit Number Naming System"
Description: "Example only: PV1-19 visit number of an NHS Trust."
Usage:      #definition
* name = "ExampleTrustVisitNumber"
* status = #draft
* kind = #identifier
* date = "2026-11-23"
* publisher = "NHS North West Genomics"
* type = $v2-0203#VN
* description = "Example only: PV1-19 visit number of an NHS Trust."
* jurisdiction = urn:iso:std:iso:3166#GB "United Kingdom of Great Britain and Northern Ireland"
* uniqueId[+].type = #uri
* uniqueId[=].value = "https://fhir.example-trust.nhs.uk/Id/visit-number"
* uniqueId[=].preferred = true

Instance:   example-trust-ward-code
InstanceOf: NamingSystem
Title:      "Example Trust Ward Code Naming System"
Description: "Example only: PL-2 ward code of an NHS Trust."
Usage:      #definition
* name = "ExampleTrustWardCode"
* status = #draft
* kind = #identifier
* date = "2026-11-23"
* publisher = "NHS North West Genomics"
* type = $v2-0203#RI
* description = "Example only: PL-2 ward code of an NHS Trust."
* jurisdiction = urn:iso:std:iso:3166#GB "United Kingdom of Great Britain and Northern Ireland"
* uniqueId[+].type = #uri
* uniqueId[=].value = "https://fhir.example-trust.nhs.uk/Id/ward-code"
* uniqueId[=].preferred = true
