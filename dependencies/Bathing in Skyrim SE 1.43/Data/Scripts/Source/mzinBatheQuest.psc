ScriptName mzinBatheQuest Extends Quest
{ this script handles some functions needed by other scripts }

import mzinWaterUtil

GlobalVariable Property BathingInSkyrimEnabled Auto
GlobalVariable Property WaterRestrictionEnabled Auto

GlobalVariable Property BatheKeyCode Auto
GlobalVariable Property ShowerKeyCode Auto
GlobalVariable Property CheckStatusKeyCode Auto

GlobalVariable Property DirtinessPercentage Auto

FormList Property WashPropList Auto
FormList Property SoapBonusSpellList Auto
FormList Property BatheAttemptSpellList Auto

FormList Property DirtinessSpellList Auto
FormList Property DirtinessThresholdList Auto

FormList Property WaterList Auto
FormList Property WaterfallList Auto

FormList Property SoapBonusMessageList Auto

Keyword Property SoapKeyword Auto

Spell Property DefaultBatheAttemptSpell Auto

Spell Property PlayBatheAnimationWithSoap Auto
Spell Property PlayBatheAnimationWithoutSoap Auto
Spell Property PlayShowerAnimationWithSoap Auto
Spell Property PlayShowerAnimationWithoutSoap Auto

FormList Property GetDirtyOverTimeSpellList Auto

Message Property BathingWithSoapMessage Auto
Message Property BathingWithoutSoapMessage Auto
Message Property ShoweringWithSoapMessage Auto
Message Property ShoweringWithoutSoapMessage Auto

Message Property ShoweringNeedsWaterMessage Auto
Message Property DirtinessStatusMessage Auto

Bool DawnguardSupportAdded
Bool DragonbornSupportAdded
Bool FalskaarSupportAdded
Bool RealisticWaterTwoSupportAdded

Event OnInit()
	RegisterHotKeys()
EndEvent
Event OnReset()
	UpdateDangerousWater()
EndEvent
Event OnKeyDown(Int KeyCode)
	If Utility.IsInMenuMode() || BathingInSkyrimEnabled.GetValue() As Bool == False
		Return
	EndIf
	
	If KeyCode == CheckStatusKeyCode.GetValueInt()
		DirtinessStatusMessage.Show(DirtinessPercentage.GetValue() * 100)
	ElseIf KeyCode == BatheKeyCode.GetValueInt()
		TryBatheActor(Game.GetPlayer(), None)
	ElseIf KeyCode == ShowerKeyCode.GetValueInt()
		If TryShowerActor(Game.GetPlayer(), None) == False
			ShoweringNeedsWaterMessage.Show()
		EndIf
	Endif
EndEvent

Function RegisterHotKeys()
	RegisterForKey(BatheKeyCode.GetValueInt())
	RegisterForKey(ShowerKeyCode.GetValueInt())
	RegisterForKey(CheckStatusKeyCode.GetValueInt())
EndFunction
Function UnRegisterHotKeys()
	UnregisterForKey(BatheKeyCode.GetValueInt())
	UnregisterForKey(ShowerKeyCode.GetValueInt())
	UnregisterForKey(CheckStatusKeyCode.GetValueInt())
EndFunction

Function TryBatheActor(Actor DirtyActor, MiscObject WashProp)
	Spell BatheAttemptSpell = DefaultBatheAttemptSpell
	If WashProp == None
		WashProp = TryFindWashProp(DirtyActor)
	EndIf
	If WashProp
		BatheAttemptSpell = BatheAttemptSpellList.GetAt(GetWashPropIndex(WashProp)) As Spell
	EndIf
	DirtyActor.AddSpell(BatheAttemptSpell, False)
	Utility.Wait(1)
	DirtyActor.RemoveSpell(BatheAttemptSpell)
EndFunction
Bool Function TryShowerActor(Actor DirtyActor, MiscObject WashProp)
	Bool Result = False

	If WashProp == None
		WashProp = TryFindWashProp(DirtyActor)
	EndIf

	If WaterRestrictionEnabled.GetValue() As Bool == False || IsUnderWaterfall(DirtyActor)
		ShowerActor(DirtyActor, WashProp)
		Result = True
	EndIf

	Return Result
EndFunction
Function BatheActor(Actor DirtyActor, MiscObject WashProp)
	Bool DirtyActorIsPlayer = (DirtyActor == Game.GetPlayer())

	DirtyActor.ClearExtraArrows()
	
	RemoveSpells(DirtyActor, SoapBonusSpellList)
	RemoveSpells(DirtyActor, DirtinessSpellList)
	RemoveSpells(DirtyActor, BatheAttemptSpellList)
	RemoveSpells(DirtyActor, GetDirtyOverTimeSpellList)

	Utility.Wait(1)

	If WashProp && WashProp.HasKeyWord(SoapKeyword)
		ApplySoapBonus(DirtyActor, WashProp)
		DirtyActor.RemoveItem(WashProp, 1, True, None)
		DirtyActor.AddSpell(GetDirtyOverTimeSpellList.GetAt(0) As Spell, False)
		DirtyActor.AddSpell(PlayBatheAnimationWithSoap, False)
		If DirtyActorIsPlayer
			BathingWithSoapMessage.Show()
		EndIf
	Else
		DirtyActor.AddSpell(GetDirtyOverTimeSpellList.GetAt(1) As Spell, False)
		DirtyActor.AddSpell(PlayBatheAnimationWithoutSoap, False)	
		If DirtyActorIsPlayer
			BathingWithoutSoapMessage.Show()
		EndIf
	EndIf
EndFunction
Function ShowerActor(Actor DirtyActor, MiscObject WashProp)
	Bool DirtyActorIsPlayer = (DirtyActor == Game.GetPlayer())

	DirtyActor.ClearExtraArrows()

	RemoveSpells(DirtyActor, SoapBonusSpellList)
	RemoveSpells(DirtyActor, DirtinessSpellList)
	RemoveSpells(DirtyActor, BatheAttemptSpellList)
	RemoveSpells(DirtyActor, GetDirtyOverTimeSpellList)

	Utility.Wait(0.1)

	If WashProp && WashProp.HasKeyWord(SoapKeyword)
		ApplySoapBonus(DirtyActor, WashProp)
		DirtyActor.RemoveItem(WashProp, 1, True, None)
		DirtyActor.AddSpell(GetDirtyOverTimeSpellList.GetAt(0) As Spell, False)
		DirtyActor.AddSpell(PlayShowerAnimationWithSoap, False)
		If DirtyActorIsPlayer
			ShoweringWithSoapMessage.Show()
		EndIf
	Else
		DirtyActor.AddSpell(GetDirtyOverTimeSpellList.GetAt(1) As Spell, False)
		DirtyActor.AddSpell(PlayShowerAnimationWithoutSoap, False)
		If DirtyActorIsPlayer
			ShoweringWithoutSoapMessage.Show()
		EndIf
	EndIf
EndFunction

Function SetDirtPercentage(Actor BathingActor, Float NewDirtPercentage)
EndFunction

Function ApplySoapBonus(Actor DirtyActor, MiscObject WashProp)
	If WashProp
		Int Index = GetWashPropIndex(WashProp)
		Spell SoapBonusSpell = SoapBonusSpellList.GetAt(Index) As Spell
		DirtyActor.AddSpell(SoapBonusSpell, False)
		If DirtyActor == Game.GetPlayer()
			(SoapBonusMessageList.GetAt(Index) As Message).Show()
		EndIf
	EndIf
EndFunction

Function RemoveSpells(Actor DirtyActor, FormList SpellsFormList)
	Int Index = SpellsFormList.GetSize()
	While Index
		Index -= 1
		DirtyActor.RemoveSpell(SpellsFormList.GetAt(Index) As Spell)	
	EndWhile
EndFunction

MiscObject Function TryFindWashProp(Actor DirtyActor)
	Int WashPropIndex = WashPropList.GetSize()

	While WashPropIndex
		WashPropIndex -= 1
		MiscObject WashProp = WashPropList.GetAt(WashPropIndex) As MiscObject
		If DirtyActor.GetItemCount(WashProp) > 0
			Return WashProp
		EndIf		
	EndWhile
	
	Return None
EndFunction
Int Function GetWashPropIndex(MiscObject Soap)
	Int WashPropIndex = WashPropList.GetSize()

	While WashPropIndex
		WashPropIndex -= 1		
		If WashPropList.GetAt(WashPropIndex) As MiscObject == Soap
			Return WashPropIndex
		EndIf		
	EndWhile
	
	Return -1
EndFunction

Bool Function IsUnderWaterfall(Actor DirtyActor)
	If Game.FindClosestReferenceOfAnyTypeInListFromRef(WaterfallList, DirtyActor, 128.0)
		Return True
	EndIf

	Return False
EndFunction

Function UpdateDangerousWater()
	; try to support water from mods
	TryAddDawnguardSupport()
	TryAddDragonbornSupport()
	TryAddFalskaarSupport()
	TryAddRealisticWaterTwoSupport()

	; process the water list
	Int Index = WaterList.GetSize()
	Bool Dangerous = WaterRestrictionEnabled.GetValue() As Bool
	While Index
		Index -= 1
		Form WaterForm = WaterList.GetAt(Index)
		If WaterForm != None
			mzinWaterUtil.SetDangerousWater(WaterForm, Dangerous)
		EndIf
	EndWhile
EndFunction
Function AddWaterToList(Form WaterForm)
	If WaterForm != None && WaterList.HasForm(WaterForm) == False
		WaterList.AddForm(WaterForm)
	EndIf
EndFunction

; mod support
Function TryAddDawnguardSupport()
	If DawnguardSupportAdded == False && Game.GetModByName("Dawnguard.esm") != 255
		AddWaterToList(Game.GetFormFromFile(0x001C18, "Dawnguard.esm"))
		AddWaterToList(Game.GetFormFromFile(0x002932, "Dawnguard.esm"))
		AddWaterToList(Game.GetFormFromFile(0x006AEB, "Dawnguard.esm"))
		AddWaterToList(Game.GetFormFromFile(0x006AFD, "Dawnguard.esm"))
		AddWaterToList(Game.GetFormFromFile(0x00C7C2, "Dawnguard.esm"))
		AddWaterToList(Game.GetFormFromFile(0x00CE71, "Dawnguard.esm"))
		AddWaterToList(Game.GetFormFromFile(0x00CE72, "Dawnguard.esm"))
		AddWaterToList(Game.GetFormFromFile(0x019C98, "Dawnguard.esm"))
		Debug.Notification("Bathing in Skyrim - Dawnguard Support Added")
		DawnguardSupportAdded = True
	EndIf
EndFunction
Function TryAddDragonbornSupport()
	If DragonbornSupportAdded == False && Game.GetModByName("Dragonborn.esm") != 255
		AddWaterToList(Game.GetFormFromFile(0x0173B6, "Dragonborn.esm"))
		AddWaterToList(Game.GetFormFromFile(0x01DFF1, "Dragonborn.esm"))
		AddWaterToList(Game.GetFormFromFile(0x028644, "Dragonborn.esm"))
		AddWaterToList(Game.GetFormFromFile(0x02ADEC, "Dragonborn.esm"))
		AddWaterToList(Game.GetFormFromFile(0x03731A, "Dragonborn.esm"))
		AddWaterToList(Game.GetFormFromFile(0x03805D, "Dragonborn.esm"))
		Debug.Notification("Bathing in Skyrim - Dragonborn Support Added")
		DragonbornSupportAdded = True
	EndIf
EndFunction
Function TryAddFalskaarSupport()
	If FalskaarSupportAdded == False && Game.GetModByName("Falskaar.esm") != 255
		AddWaterToList(Game.GetFormFromFile(0x052A0F, "Falskaar.esm"))
		AddWaterToList(Game.GetFormFromFile(0x0B5AB4, "Falskaar.esm"))
		AddWaterToList(Game.GetFormFromFile(0x0B5AB5, "Falskaar.esm"))
		AddWaterToList(Game.GetFormFromFile(0x0B5AB6, "Falskaar.esm"))
		AddWaterToList(Game.GetFormFromFile(0x0B5AB7, "Falskaar.esm"))
		AddWaterToList(Game.GetFormFromFile(0x0B7DA2, "Falskaar.esm"))
		AddWaterToList(Game.GetFormFromFile(0x11960F, "Falskaar.esm"))
		AddWaterToList(Game.GetFormFromFile(0x17B736, "Falskaar.esm"))
		Debug.Notification("Bathing in Skyrim - Falskaar Support Added")
		FalskaarSupportAdded = True
	EndIf
EndFunction
Function TryAddRealisticWaterTwoSupport()
	If RealisticWaterTwoSupportAdded == False && Game.GetModByName("RealisticWaterTwo.esp") != 255
		AddWaterToList(Game.GetFormFromFile(0x002DAE, "RealisticWaterTwo.esp"))
		AddWaterToList(Game.GetFormFromFile(0x0048D3, "RealisticWaterTwo.esp"))
		AddWaterToList(Game.GetFormFromFile(0x015BE8, "RealisticWaterTwo.esp"))
		AddWaterToList(Game.GetFormFromFile(0x02088C, "RealisticWaterTwo.esp"))
		Debug.Notification("Bathing in Skyrim - Realistic Water Two Support Added")
		RealisticWaterTwoSupportAdded = True
	EndIf
EndFunction
