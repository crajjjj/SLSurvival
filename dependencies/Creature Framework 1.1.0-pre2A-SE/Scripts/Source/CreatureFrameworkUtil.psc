Scriptname CreatureFrameworkUtil hidden
{Utility script | Creature Framework}

; Get the version of the mod
int function GetVersion() global
	return 10021
endFunction

; Get the textual representation of the version of the mod
string function GetVersionString() global
	return "1.1.0-pre2"
endFunction

; Get the framework script
CreatureFramework function GetAPI() global
	return Game.GetFormFromFile(0xD62, "CreatureFramework.esm") as CreatureFramework
endFunction

; Get the configuration script
CFConfigMenu function GetConfig() global
	return Game.GetFormFromFile(0xD63, "CreatureFramework.esm") as CFConfigMenu
endFunction

; Get the main quest
CFQuestMain function GetMainQuest() global
	return Game.GetFormFromFile(0xD64, "CreatureFramework.esm") as CFQuestMain
endFunction

Spell function GetCloakSpell() global
	return Game.GetFormFromFile(0x22EE, "CreatureFramework.esm") as Spell
endFunction

; Get the creature spell
Spell function GetCreatureSpell() global
	return Game.GetFormFromFile(0x2854, "CreatureFramework.esm") as Spell
endFunction

; Get the creature apply spell
Spell function GetCreatureApplySpell() global
	return Game.GetFormFromFile(0x48A2, "CreatureFramework.esm") as Spell
endFunction

; Get the creature effect
MagicEffect function GetCreatureEffect() global
	return Game.GetFormFromFile(0x2853, "CreatureFramework.esm") as MagicEffect
endFunction

; Get the key of a JMap that corresponds to the index of a JArray of its keys
string function GetJMapKeyFromIndex(int map, int index) global
	int keys = JMap.AllKeys(map)
	return JArray.GetStr(keys, index)
endFunction

; Get the key of a JFormMap that corresponds to the index of a JArray of its keys
Form function GetJFormMapKeyFromIndex(int map, int index) global
	int keys = JFormMap.AllKeys(map)
	return JArray.GetForm(keys, index)
endFunction

; Get the JArray index that corresponds to the key of a JMap
int function GetIndexFromJMapKey(int map, string mapKey) global
	int keys = JMap.AllKeys(map)
	return JArray.FindStr(keys, mapKey)
endFunction

; Get the JArray index that corresponds to the key of a JFormMap
int function GetIndexFromJFormMapKey(int map, Form mapKey) global
	int keys = JFormMap.AllKeys(map)
	return JArray.FindForm(keys, mapKey)
endFunction

; Get a Papyrus string array from a JArray
string[] function GetStringArrayFromJArray(int array) global
	int size = JArray.Count(array)
	string[] strings = Utility.CreateStringArray(size)
	int i
	while i < size
		strings[i] = JArray.GetStr(array, i)
		i += 1
	endWhile
	return strings
endFunction

; Get an actor's name
string function GetActorName(Actor actorForm) global
	if actorForm != none
		string baseName = actorForm.GetActorBase().GetName()
		string leveledBaseName = actorForm.GetLeveledActorBase().GetName()
		string name
		if baseName == "" && leveledBaseName == ""
			name = "$Unknown"
		elseIf baseName == ""
			name = leveledBaseName
		else
			name = baseName
		endIf
		return name
	else
		return "$None"
	endIf
endFunction

; Get a more detailed name of an Actor
string function GetDetailedActorName(Actor actorForm) global
	if actorForm != none
		string baseName = actorForm.GetActorBase().GetName()
		string leveledBaseName = actorForm.GetLeveledActorBase().GetName()
		string name
		if baseName == "" && leveledBaseName == ""
			name = "Unknown"
		elseIf baseName == ""
			name = leveledBaseName
		else
			name = baseName
		endIf
		return "[\"" + name +"\" " + actorForm + "]"
	else
		return "[None]"
	endIf
endFunction

; Get a more detailed name of a form
string function GetDetailedFormName(Form formForm) global
	if formForm != none
		string name = formForm.GetName()
		if name == ""
			name = "Unknown"
		endIf
		return "[\"" + formForm.GetName() + "\" " + formForm + "]"
	else
		return "[None]"
	endIf
endFunction

; Test to see if an actor has an equipped item that matches the slot mask
bool function ActorHasEquippedSlot(Actor actorForm, int slotMask) global
	return actorForm.GetWornForm(slotMask) != none
endFunction

; Test to see if an actor has any equipped items that match any of the slot masks in a JArray
bool function ActorHasAnyEquippedSlot(Actor actorForm, int slotMasks) global
	int size = JArray.Count(slotMasks)
	int s
	while s < size
		if ActorHasEquippedSlot(actorForm, JArray.GetInt(slotMasks, s))
			return true
		endIf
		s += 1
	endWhile
	return false
endFunction

; Add and equip an armour to an actor (the wiki says just doing EquipItem sometimes doesn't register the equip if they don't have the item already)
function AddAndEquipArmor(Actor actorForm, Armor armorForm) global
	if actorForm.GetItemCount(armorForm) == 0
		actorForm.AddItem(armorForm, 1, true)
	endIf
	actorForm.EquipItem(armorForm, false, true)
endFunction

; Equip an item or a spell to an actor
function GenericEquip(Actor actorForm, Form theThing, bool preventRemoval = false, int spellSlot = 0) global
	if theThing as Spell
		actorForm.EquipSpell(theThing as Spell, spellSlot)
	else
		actorForm.EquipItem(actorForm, preventRemoval, true)
	endIf
endFunction

; Unequip an item or a spell to an actor; optionally, do it multiple times
function GenericUnequip(Actor actorForm, Form theThing, bool preventEquip = false, int spellSlot = 0, int iterations = 1, float waitTime = 0.25) global
	int i = 1
	if theThing as Spell
		actorForm.UnequipSpell(theThing as Spell, spellSlot)
		while i < iterations
			Utility.Wait(waitTime)
			actorForm.UnequipSpell(theThing as Spell, spellSlot)
			i += 1
		endWhile
	else
		actorForm.UnequipItem(theThing, preventEquip, true)
		while i < iterations
			Utility.Wait(waitTime)
			actorForm.UnequipItem(theThing, preventEquip, true)
			i += 1
		endWhile
	endIf
endFunction

; Create a JArray of forms from a Papyrus array
int function JArrayObjectFromForms(Form[] forms) global
	if forms.length > 0
		int jFormArr = JArray.Object()
		JValue.Retain(jFormArr)
		int f
		while f < forms.length
			JArray.AddForm(jFormArr, forms[f])
			f += 1
		endWhile
		JValue.Release(jFormArr)
		return jFormArr
	else
		return 0
	endIf
endFunction

; Create a Papyrus array of integers from a JArray
int[] function IntArrayFromJArray(int obj) global
	JValue.Retain(obj)
	int[] array = Utility.CreateIntArray(JArray.Count(obj))
	int i
	while i < array.length
		array[i] = JArray.GetInt(obj, i)
		i += 1
	endWhile
	JValue.Release(obj)
	return array
endFunction

; Create a Papyrus array of strings from a JArray
string[] function StringArrayFromJArray(int obj) global
	JValue.Retain(obj)
	string[] array = Utility.CreateStringArray(JArray.Count(obj))
	int i
	while i < array.length
		array[i] = JArray.GetStr(obj, i)
		i += 1
	endWhile
	JValue.Release(obj)
	return array
endFunction

; Create a Papyrus array of forms from a JArray
Form[] function FormArrayFromJArray(int obj) global
	JValue.Retain(obj)
	Form[] array = Utility.CreateFormArray(JArray.Count(obj))
	int i
	while i < array.length
		array[i] = JArray.GetForm(obj, i)
		i += 1
	endWhile
	JValue.Release(obj)
	return array
endFunction
