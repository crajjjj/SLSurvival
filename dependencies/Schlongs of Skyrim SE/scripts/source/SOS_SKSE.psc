ScriptName SOS_SKSE

; The dynamic use of the slot 52 has been moved from the Armors to their ArmorAddons

; Checks the slots on the armor, and also on all AAs that uses the body slot
;Bool Function HasSlot(Armor akArmor, int slotMask) Global Native

; Checks if the armor is a custom armor and adds the slot 52 to it
; For that, the armor must be a non-revealing body armor with no slot 52
; Returns true if the slot was added, false if these conditions were not met
Bool Function FixCustomArmor(Armor akArmor) Global Native

; Returns true if either
; A) the passed Armor has the SOS_Revealing keyword, or
; B) its first ArmorAddon using the body biped slot is stored in the list SOS_RevealingArmors
Bool Function IsRevealing(Armor akArmor) Global Native

; Returns true if the armor is a body armor and its first ArmorAddon using the body biped slot also uses the slot 52
;Bool Function IsConcealing(Armor akArmor) Global
;	Return akArmor && HasSlot(akArmor, akArmor.kSlotMask52)
;EndFunction

;Bool Function SetConcealing(Armor akArmor) Global Native

;Bool Function SetRevealing(Armor akArmor) Global Native

; Returns true if the armor is stored in the list SOS_ConcealingArmors
Bool Function IsInConcealingList(Armor akArmor) Global Native

; This does fixes to the data stored in SOS SKSE plugin, if needed for the passed version
;Function Maintenance(int version) Global Native

Form Function DetermineSchlongType (Actor akActor) Global Native

Function ScaleSchlongBones(Form addon, Actor akActor, int rank, float factor) Global Native

int function FormListAdd(Form obj, string key, Form value, bool allowDuplicate = true) global native
int function IntListAdd(Form obj, string key, Int value, bool allowDuplicate = true) global native
int function FloatListAdd(Form obj, string key, Float value, bool allowDuplicate = true) global native

int function FormListClear(Form obj, string key) global native
int function IntListClear(Form obj, string key) global native
int function FloatListClear(Form obj, string key) global native

int function FormListCount(Form obj, string key) global native
int function IntListCount(Form obj, string key) global native
int function FloatListCount(Form obj, string key) global native

int function FormListFind(Form obj, string key, Form value) global native
int function IntListFind(Form obj, string key, Int value) global native
int function FloatListFind(Form obj, string key, Float value) global native

Form function FormListGet(Form obj, string key, int index) global native
Int function IntListGet(Form obj, string key, int index) global native
Float function FloatListGet(Form obj, string key, int index) global native

int function FormListRemove(Form obj, string key, Form value, bool allInstances = false) global native
int function IntListRemove(Form obj, string key, Int value, bool allInstances = false) global native
int function FloatListRemove(Form obj, string key, Float value, bool allInstances = false) global native

Form function FormListSet(Form obj, string key, int index, Form value) global native
int function IntListSet(Form obj, string key, int index, int value) global native
float function FloatListSet(Form obj, string key, int index, float value) global native

int function GetIntValue(Form obj, string key, int missing = 0) global native

int function SetIntValue(Form obj, string key, int value) global native

bool function UnsetIntValue(Form obj, string key) global native;
