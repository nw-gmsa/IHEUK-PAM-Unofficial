Instance:   PAMPatientDemographicsSupplier
InstanceOf: CapabilityStatement
Title:      "Patient Demographics Supplier Requirements"
Usage:      #definition
* url = "https://fhir.ihe-uk.org/ITI/PAM/CapabilityStatement/PAMPatientDemographicsSupplier"
* name = "PAMPatientDemographicsSupplier"
* title = "Patient Demographics Supplier Requirements"
* status = #draft
* experimental = false
* date = "2026-11-23"
* kind = #requirements
* fhirVersion = #4.0.1
* format[+] = #json
* format[+] = #xml
* description = """
Capabilities of the IHE PAM Patient Demographics Supplier actor for Patient Identity Management [ITI-30]. HL7 v2.5.1 messages are exchanged over MLLP; the equivalent FHIR Messages use the $process-message operation.
"""
* messaging[+].documentation = "Patient Identity Management [ITI-30]. Every message is acknowledged with an HL7 ACK (original mode) or a FHIR response MessageHeader."
* messaging[=].supportedMessage[+].mode = #sender
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A28)
* messaging[=].supportedMessage[+].mode = #sender
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A31)
* messaging[=].supportedMessage[+].mode = #sender
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A40)

Instance:   PAMPatientDemographicsConsumer
InstanceOf: CapabilityStatement
Title:      "Patient Demographics Consumer Requirements"
Usage:      #definition
* url = "https://fhir.ihe-uk.org/ITI/PAM/CapabilityStatement/PAMPatientDemographicsConsumer"
* name = "PAMPatientDemographicsConsumer"
* title = "Patient Demographics Consumer Requirements"
* status = #draft
* experimental = false
* date = "2026-11-23"
* kind = #requirements
* fhirVersion = #4.0.1
* format[+] = #json
* format[+] = #xml
* description = """
Capabilities of the IHE PAM Patient Demographics Consumer actor for Patient Identity Management [ITI-30]. HL7 v2.5.1 messages are exchanged over MLLP; the equivalent FHIR Messages use the $process-message operation.
"""
* messaging[+].documentation = "Patient Identity Management [ITI-30]. Every message is acknowledged with an HL7 ACK (original mode) or a FHIR response MessageHeader."
* messaging[=].supportedMessage[+].mode = #receiver
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A28)
* messaging[=].supportedMessage[+].mode = #receiver
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A31)
* messaging[=].supportedMessage[+].mode = #receiver
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A40)

Instance:   PAMPatientEncounterSupplier
InstanceOf: CapabilityStatement
Title:      "Patient Encounter Supplier Requirements"
Usage:      #definition
* url = "https://fhir.ihe-uk.org/ITI/PAM/CapabilityStatement/PAMPatientEncounterSupplier"
* name = "PAMPatientEncounterSupplier"
* title = "Patient Encounter Supplier Requirements"
* status = #draft
* experimental = false
* date = "2026-11-23"
* kind = #requirements
* fhirVersion = #4.0.1
* format[+] = #json
* format[+] = #xml
* description = """
Capabilities of the IHE PAM Patient Encounter Supplier actor for Patient Encounter Management [ITI-31]. HL7 v2.5.1 messages are exchanged over MLLP; the equivalent FHIR Messages use the $process-message operation.
"""
* messaging[+].documentation = "Patient Encounter Management [ITI-31]. Every message is acknowledged with an HL7 ACK (original mode) or a FHIR response MessageHeader."
* messaging[=].supportedMessage[+].mode = #sender
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A01)
* messaging[=].supportedMessage[+].mode = #sender
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A02)
* messaging[=].supportedMessage[+].mode = #sender
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A03)
* messaging[=].supportedMessage[+].mode = #sender
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A04)
* messaging[=].supportedMessage[+].mode = #sender
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A05)
* messaging[=].supportedMessage[+].mode = #sender
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A08)
* messaging[=].supportedMessage[+].mode = #sender
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A11)
* messaging[=].supportedMessage[+].mode = #sender
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A12)
* messaging[=].supportedMessage[+].mode = #sender
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A13)
* messaging[=].supportedMessage[+].mode = #sender
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A14)
* messaging[=].supportedMessage[+].mode = #sender
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A15)
* messaging[=].supportedMessage[+].mode = #sender
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A16)
* messaging[=].supportedMessage[+].mode = #sender
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A21)
* messaging[=].supportedMessage[+].mode = #sender
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A22)
* messaging[=].supportedMessage[+].mode = #sender
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A25)
* messaging[=].supportedMessage[+].mode = #sender
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A26)
* messaging[=].supportedMessage[+].mode = #sender
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A27)
* messaging[=].supportedMessage[+].mode = #sender
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A38)
* messaging[=].supportedMessage[+].mode = #sender
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A52)
* messaging[=].supportedMessage[+].mode = #sender
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A53)

Instance:   PAMPatientEncounterConsumer
InstanceOf: CapabilityStatement
Title:      "Patient Encounter Consumer Requirements"
Usage:      #definition
* url = "https://fhir.ihe-uk.org/ITI/PAM/CapabilityStatement/PAMPatientEncounterConsumer"
* name = "PAMPatientEncounterConsumer"
* title = "Patient Encounter Consumer Requirements"
* status = #draft
* experimental = false
* date = "2026-11-23"
* kind = #requirements
* fhirVersion = #4.0.1
* format[+] = #json
* format[+] = #xml
* description = """
Capabilities of the IHE PAM Patient Encounter Consumer actor for Patient Encounter Management [ITI-31]. HL7 v2.5.1 messages are exchanged over MLLP; the equivalent FHIR Messages use the $process-message operation.
"""
* messaging[+].documentation = "Patient Encounter Management [ITI-31]. Every message is acknowledged with an HL7 ACK (original mode) or a FHIR response MessageHeader."
* messaging[=].supportedMessage[+].mode = #receiver
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A01)
* messaging[=].supportedMessage[+].mode = #receiver
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A02)
* messaging[=].supportedMessage[+].mode = #receiver
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A03)
* messaging[=].supportedMessage[+].mode = #receiver
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A04)
* messaging[=].supportedMessage[+].mode = #receiver
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A05)
* messaging[=].supportedMessage[+].mode = #receiver
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A08)
* messaging[=].supportedMessage[+].mode = #receiver
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A11)
* messaging[=].supportedMessage[+].mode = #receiver
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A12)
* messaging[=].supportedMessage[+].mode = #receiver
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A13)
* messaging[=].supportedMessage[+].mode = #receiver
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A14)
* messaging[=].supportedMessage[+].mode = #receiver
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A15)
* messaging[=].supportedMessage[+].mode = #receiver
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A16)
* messaging[=].supportedMessage[+].mode = #receiver
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A21)
* messaging[=].supportedMessage[+].mode = #receiver
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A22)
* messaging[=].supportedMessage[+].mode = #receiver
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A25)
* messaging[=].supportedMessage[+].mode = #receiver
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A26)
* messaging[=].supportedMessage[+].mode = #receiver
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A27)
* messaging[=].supportedMessage[+].mode = #receiver
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A38)
* messaging[=].supportedMessage[+].mode = #receiver
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A52)
* messaging[=].supportedMessage[+].mode = #receiver
* messaging[=].supportedMessage[=].definition = Canonical(ADT-A53)
