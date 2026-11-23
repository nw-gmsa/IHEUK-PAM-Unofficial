Instance:   ADT-A01
InstanceOf: MessageDefinition
Title:      "ADT^A01^ADT_A01 Admit/Visit Notification"
Usage:      #definition
* insert ADTEvent(A01, ADT_A01, Admit/Visit Notification, ITI-31, Basic Subset)
* focus[+].code = #Patient
* focus[=].profile = Canonical(PAMPatient)
* focus[=].min = 1
* focus[=].max = "1"
* focus[+].code = #Encounter
* focus[=].profile = Canonical(PAMEncounter)
* focus[=].min = 1
* focus[=].max = "1"

Instance:   ADT-A02
InstanceOf: MessageDefinition
Title:      "ADT^A02^ADT_A02 Transfer a Patient"
Usage:      #definition
* insert ADTEvent(A02, ADT_A02, Transfer a Patient, ITI-31, Inpatient/Outpatient Encounter Management Option)
* focus[+].code = #Patient
* focus[=].profile = Canonical(PAMPatient)
* focus[=].min = 1
* focus[=].max = "1"
* focus[+].code = #Encounter
* focus[=].profile = Canonical(PAMEncounter)
* focus[=].min = 1
* focus[=].max = "1"

Instance:   ADT-A03
InstanceOf: MessageDefinition
Title:      "ADT^A03^ADT_A03 Discharge/End Visit"
Usage:      #definition
* insert ADTEvent(A03, ADT_A03, Discharge/End Visit, ITI-31, Basic Subset)
* focus[+].code = #Patient
* focus[=].profile = Canonical(PAMPatient)
* focus[=].min = 1
* focus[=].max = "1"
* focus[+].code = #Encounter
* focus[=].profile = Canonical(PAMEncounter)
* focus[=].min = 1
* focus[=].max = "1"

Instance:   ADT-A04
InstanceOf: MessageDefinition
Title:      "ADT^A04^ADT_A01 Register a Patient - Outpatient"
Usage:      #definition
* insert ADTEvent(A04, ADT_A01, Register a Patient - Outpatient, ITI-31, Basic Subset)
* focus[+].code = #Patient
* focus[=].profile = Canonical(PAMPatient)
* focus[=].min = 1
* focus[=].max = "1"
* focus[+].code = #Encounter
* focus[=].profile = Canonical(PAMEncounter)
* focus[=].min = 1
* focus[=].max = "1"

Instance:   ADT-A05
InstanceOf: MessageDefinition
Title:      "ADT^A05^ADT_A05 Pre-Admit a Patient"
Usage:      #definition
* insert ADTEvent(A05, ADT_A05, Pre-Admit a Patient, ITI-31, Inpatient/Outpatient Encounter Management Option)
* focus[+].code = #Patient
* focus[=].profile = Canonical(PAMPatient)
* focus[=].min = 1
* focus[=].max = "1"
* focus[+].code = #Encounter
* focus[=].profile = Canonical(PAMEncounter)
* focus[=].min = 1
* focus[=].max = "1"

Instance:   ADT-A08
InstanceOf: MessageDefinition
Title:      "ADT^A08^ADT_A01 Update Patient Information"
Usage:      #definition
* insert ADTEvent(A08, ADT_A01, Update Patient Information, ITI-31, Maintain Demographics Option)
* focus[+].code = #Patient
* focus[=].profile = Canonical(PAMPatient)
* focus[=].min = 1
* focus[=].max = "1"
* focus[+].code = #Encounter
* focus[=].profile = Canonical(PAMEncounter)
* focus[=].min = 1
* focus[=].max = "1"

Instance:   ADT-A11
InstanceOf: MessageDefinition
Title:      "ADT^A11^ADT_A09 Cancel Admit/Visit Notification"
Usage:      #definition
* insert ADTEvent(A11, ADT_A09, Cancel Admit/Visit Notification, ITI-31, Basic Subset)
* focus[+].code = #Patient
* focus[=].profile = Canonical(PAMPatient)
* focus[=].min = 1
* focus[=].max = "1"
* focus[+].code = #Encounter
* focus[=].profile = Canonical(PAMEncounter)
* focus[=].min = 1
* focus[=].max = "1"

Instance:   ADT-A12
InstanceOf: MessageDefinition
Title:      "ADT^A12^ADT_A12 Cancel Transfer"
Usage:      #definition
* insert ADTEvent(A12, ADT_A12, Cancel Transfer, ITI-31, Inpatient/Outpatient Encounter Management Option)
* focus[+].code = #Patient
* focus[=].profile = Canonical(PAMPatient)
* focus[=].min = 1
* focus[=].max = "1"
* focus[+].code = #Encounter
* focus[=].profile = Canonical(PAMEncounter)
* focus[=].min = 1
* focus[=].max = "1"

Instance:   ADT-A13
InstanceOf: MessageDefinition
Title:      "ADT^A13^ADT_A01 Cancel Discharge/End Visit"
Usage:      #definition
* insert ADTEvent(A13, ADT_A01, Cancel Discharge/End Visit, ITI-31, Basic Subset)
* focus[+].code = #Patient
* focus[=].profile = Canonical(PAMPatient)
* focus[=].min = 1
* focus[=].max = "1"
* focus[+].code = #Encounter
* focus[=].profile = Canonical(PAMEncounter)
* focus[=].min = 1
* focus[=].max = "1"

Instance:   ADT-A14
InstanceOf: MessageDefinition
Title:      "ADT^A14^ADT_A05 Pending Admit"
Usage:      #definition
* insert ADTEvent(A14, ADT_A05, Pending Admit, ITI-31, Pending Event Management Option)
* focus[+].code = #Patient
* focus[=].profile = Canonical(PAMPatient)
* focus[=].min = 1
* focus[=].max = "1"
* focus[+].code = #Encounter
* focus[=].profile = Canonical(PAMEncounter)
* focus[=].min = 1
* focus[=].max = "1"

Instance:   ADT-A15
InstanceOf: MessageDefinition
Title:      "ADT^A15^ADT_A15 Pending Transfer"
Usage:      #definition
* insert ADTEvent(A15, ADT_A15, Pending Transfer, ITI-31, Pending Event Management Option)
* focus[+].code = #Patient
* focus[=].profile = Canonical(PAMPatient)
* focus[=].min = 1
* focus[=].max = "1"
* focus[+].code = #Encounter
* focus[=].profile = Canonical(PAMEncounter)
* focus[=].min = 1
* focus[=].max = "1"

Instance:   ADT-A16
InstanceOf: MessageDefinition
Title:      "ADT^A16^ADT_A16 Pending Discharge"
Usage:      #definition
* insert ADTEvent(A16, ADT_A16, Pending Discharge, ITI-31, Pending Event Management Option)
* focus[+].code = #Patient
* focus[=].profile = Canonical(PAMPatient)
* focus[=].min = 1
* focus[=].max = "1"
* focus[+].code = #Encounter
* focus[=].profile = Canonical(PAMEncounter)
* focus[=].min = 1
* focus[=].max = "1"

Instance:   ADT-A21
InstanceOf: MessageDefinition
Title:      "ADT^A21^ADT_A21 Patient Goes on a Leave of Absence"
Usage:      #definition
* insert ADTEvent(A21, ADT_A21, Patient Goes on a Leave of Absence, ITI-31, Advanced Encounter Management Option)
* focus[+].code = #Patient
* focus[=].profile = Canonical(PAMPatient)
* focus[=].min = 1
* focus[=].max = "1"
* focus[+].code = #Encounter
* focus[=].profile = Canonical(PAMEncounter)
* focus[=].min = 1
* focus[=].max = "1"

Instance:   ADT-A22
InstanceOf: MessageDefinition
Title:      "ADT^A22^ADT_A21 Patient Returns from a Leave of Absence"
Usage:      #definition
* insert ADTEvent(A22, ADT_A21, Patient Returns from a Leave of Absence, ITI-31, Advanced Encounter Management Option)
* focus[+].code = #Patient
* focus[=].profile = Canonical(PAMPatient)
* focus[=].min = 1
* focus[=].max = "1"
* focus[+].code = #Encounter
* focus[=].profile = Canonical(PAMEncounter)
* focus[=].min = 1
* focus[=].max = "1"

Instance:   ADT-A25
InstanceOf: MessageDefinition
Title:      "ADT^A25^ADT_A21 Cancel Pending Discharge"
Usage:      #definition
* insert ADTEvent(A25, ADT_A21, Cancel Pending Discharge, ITI-31, Pending Event Management Option)
* focus[+].code = #Patient
* focus[=].profile = Canonical(PAMPatient)
* focus[=].min = 1
* focus[=].max = "1"
* focus[+].code = #Encounter
* focus[=].profile = Canonical(PAMEncounter)
* focus[=].min = 1
* focus[=].max = "1"

Instance:   ADT-A26
InstanceOf: MessageDefinition
Title:      "ADT^A26^ADT_A21 Cancel Pending Transfer"
Usage:      #definition
* insert ADTEvent(A26, ADT_A21, Cancel Pending Transfer, ITI-31, Pending Event Management Option)
* focus[+].code = #Patient
* focus[=].profile = Canonical(PAMPatient)
* focus[=].min = 1
* focus[=].max = "1"
* focus[+].code = #Encounter
* focus[=].profile = Canonical(PAMEncounter)
* focus[=].min = 1
* focus[=].max = "1"

Instance:   ADT-A27
InstanceOf: MessageDefinition
Title:      "ADT^A27^ADT_A21 Cancel Pending Admit"
Usage:      #definition
* insert ADTEvent(A27, ADT_A21, Cancel Pending Admit, ITI-31, Pending Event Management Option)
* focus[+].code = #Patient
* focus[=].profile = Canonical(PAMPatient)
* focus[=].min = 1
* focus[=].max = "1"
* focus[+].code = #Encounter
* focus[=].profile = Canonical(PAMEncounter)
* focus[=].min = 1
* focus[=].max = "1"

Instance:   ADT-A38
InstanceOf: MessageDefinition
Title:      "ADT^A38^ADT_A38 Cancel Pre-Admit"
Usage:      #definition
* insert ADTEvent(A38, ADT_A38, Cancel Pre-Admit, ITI-31, Inpatient/Outpatient Encounter Management Option)
* focus[+].code = #Patient
* focus[=].profile = Canonical(PAMPatient)
* focus[=].min = 1
* focus[=].max = "1"
* focus[+].code = #Encounter
* focus[=].profile = Canonical(PAMEncounter)
* focus[=].min = 1
* focus[=].max = "1"

Instance:   ADT-A52
InstanceOf: MessageDefinition
Title:      "ADT^A52^ADT_A52 Cancel Leave of Absence for a Patient"
Usage:      #definition
* insert ADTEvent(A52, ADT_A52, Cancel Leave of Absence for a Patient, ITI-31, Advanced Encounter Management Option)
* focus[+].code = #Patient
* focus[=].profile = Canonical(PAMPatient)
* focus[=].min = 1
* focus[=].max = "1"
* focus[+].code = #Encounter
* focus[=].profile = Canonical(PAMEncounter)
* focus[=].min = 1
* focus[=].max = "1"

Instance:   ADT-A53
InstanceOf: MessageDefinition
Title:      "ADT^A53^ADT_A52 Cancel Patient Returns from a Leave of Absence"
Usage:      #definition
* insert ADTEvent(A53, ADT_A52, Cancel Patient Returns from a Leave of Absence, ITI-31, Advanced Encounter Management Option)
* focus[+].code = #Patient
* focus[=].profile = Canonical(PAMPatient)
* focus[=].min = 1
* focus[=].max = "1"
* focus[+].code = #Encounter
* focus[=].profile = Canonical(PAMEncounter)
* focus[=].min = 1
* focus[=].max = "1"

Instance:   ADT-A28
InstanceOf: MessageDefinition
Title:      "ADT^A28^ADT_A05 Add Person Information - Create New Patient"
Usage:      #definition
* insert ADTEvent(A28, ADT_A05, Add Person Information - Create New Patient, ITI-30, Patient Identity Management)
* focus[+].code = #Patient
* focus[=].profile = Canonical(PAMPatient)
* focus[=].min = 1
* focus[=].max = "1"

Instance:   ADT-A31
InstanceOf: MessageDefinition
Title:      "ADT^A31^ADT_A05 Update Person Information"
Usage:      #definition
* insert ADTEvent(A31, ADT_A05, Update Person Information, ITI-30, Patient Identity Management)
* focus[+].code = #Patient
* focus[=].profile = Canonical(PAMPatient)
* focus[=].min = 1
* focus[=].max = "1"

Instance:   ADT-A40
InstanceOf: MessageDefinition
Title:      "ADT^A40^ADT_A39 Merge Patient - Patient Identifier List"
Usage:      #definition
* insert ADTEvent(A40, ADT_A39, Merge Patient - Patient Identifier List, ITI-30, Merge Option)
* focus[+].code = #Patient
* focus[=].profile = Canonical(PAMPatient)
* focus[=].min = 1
* focus[=].max = "2"
