Instance:   PatientDemographicsSupplier
InstanceOf: ActorDefinition
Title:      "Patient Demographics Supplier"
Usage:      #definition
* url = "https://fhir.ihe-uk.org/ITI/PAM/ActorDefinition/PatientDemographicsSupplier"
* name = "PatientDemographicsSupplier"
* title = "Patient Demographics Supplier"
* status = #draft
* experimental = false
* type = #system
* description = """
Adds and modifies patient demographics and identifiers, and sends Patient Identity Management [ITI-30] messages. Typically the Patient Administration System (PAS) or EPR. The HSCIC ITK requires the supplier to send ALL information it holds (optional fields are treated as RE - required if known).
"""
* documentation = "IHE PAM: see [PAM](PAM.html)"

Instance:   PatientDemographicsConsumer
InstanceOf: ActorDefinition
Title:      "Patient Demographics Consumer"
Usage:      #definition
* url = "https://fhir.ihe-uk.org/ITI/PAM/ActorDefinition/PatientDemographicsConsumer"
* name = "PatientDemographicsConsumer"
* title = "Patient Demographics Consumer"
* status = #draft
* experimental = false
* type = #system
* description = """
Receives patient demographics and identity changes [ITI-30] and updates its local patient records according to local data ownership rules (departmental systems, LIMS, RIS, shared care records).
"""
* documentation = "IHE PAM: see [PAM](PAM.html)"

Instance:   PatientEncounterSupplier
InstanceOf: ActorDefinition
Title:      "Patient Encounter Supplier"
Usage:      #definition
* url = "https://fhir.ihe-uk.org/ITI/PAM/ActorDefinition/PatientEncounterSupplier"
* name = "PatientEncounterSupplier"
* title = "Patient Encounter Supplier"
* status = #draft
* experimental = false
* type = #system
* description = """
Sends inserts, cancels and updates of patient encounters and movements [ITI-31]. Typically the PAS/EPR ADT module. Must be grouped with a Patient Demographics Supplier and/or Consumer.
"""
* documentation = "IHE PAM: see [PAM](PAM.html)"

Instance:   PatientEncounterConsumer
InstanceOf: ActorDefinition
Title:      "Patient Encounter Consumer"
Usage:      #definition
* url = "https://fhir.ihe-uk.org/ITI/PAM/ActorDefinition/PatientEncounterConsumer"
* name = "PatientEncounterConsumer"
* title = "Patient Encounter Consumer"
* status = #draft
* experimental = false
* type = #system
* description = """
Receives patient encounter and movement messages [ITI-31] and takes the appropriate actions. A Consumer that does not support an option application-rejects messages it does not support.
"""
* documentation = "IHE PAM: see [PAM](PAM.html)"

Instance:   PatientIdentitySource
InstanceOf: ActorDefinition
Title:      "Patient Identity Source"
Usage:      #definition
* url = "https://fhir.ihe-uk.org/ITI/PAM/ActorDefinition/PatientIdentitySource"
* name = "PatientIdentitySource"
* title = "Patient Identity Source"
* status = #draft
* experimental = false
* type = #system
* description = """
Provides notification to the Patient Identifier Cross-reference Manager of patient identity creation, update and merge events within its patient identifier domain [ITI-8, or ITI-30 for PAM based implementations].
"""
* documentation = "IHE PIX: see [PIX](PIX.html)"

Instance:   PatientIdentifierCrossReferenceManager
InstanceOf: ActorDefinition
Title:      "Patient Identifier Cross-reference Manager"
Usage:      #definition
* url = "https://fhir.ihe-uk.org/ITI/PAM/ActorDefinition/PatientIdentifierCrossReferenceManager"
* name = "PatientIdentifierCrossReferenceManager"
* title = "Patient Identifier Cross-reference Manager"
* status = #draft
* experimental = false
* type = #system
* description = """
Manages the cross-referencing of patient identifiers across patient identifier domains (e.g. local MRN and NHS Number), responding to PIX Query [ITI-9] and sending PIX Update Notifications [ITI-10]. An NHS Trust MPI / regional Master Patient Index typically implements this actor together with a Patient Identity Source.
"""
* documentation = "IHE PIX: see [PIX](PIX.html)"

Instance:   PatientIdentifierCrossReferenceConsumer
InstanceOf: ActorDefinition
Title:      "Patient Identifier Cross-reference Consumer"
Usage:      #definition
* url = "https://fhir.ihe-uk.org/ITI/PAM/ActorDefinition/PatientIdentifierCrossReferenceConsumer"
* name = "PatientIdentifierCrossReferenceConsumer"
* title = "Patient Identifier Cross-reference Consumer"
* status = #draft
* experimental = false
* type = #system
* description = """
Queries the Patient Identifier Cross-reference Manager for corresponding identifiers [ITI-9] and/or receives PIX Update Notifications [ITI-10].
"""
* documentation = "IHE PIX: see [PIX](PIX.html)"
