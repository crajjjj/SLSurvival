Scriptname _SLS_DeviousEffects extends ReferenceAlias  

Event OnInit()
	If Game.GetModByName("Devious Devices - Expansion.esm") != 255
		zad_DeviousHeavyBondage = Game.GetFormFromFile(0x05226C, "Devious Devices - Integration.esm") as Keyword
		
		LockpickingDiff = Menu.DevEffLockpickDiff
		PickPocketDiff = Menu.DevEffPickpocketDiff

		If PlayerRef.WornHasKeyword(zad_DeviousHeavyBondage)
			EquippedHeavyBondage(Devious.GetWornDeviceByKeyword(PlayerRef, zad_DeviousHeavyBondage))
		EndIf
	Else
		Self.GetOwningQuest().Stop()
	EndIf
EndEvent
;/
Event OnPlayerLoadGame()
	Debug.Messagebox("reged")	
	RegisterForMenu("Dialogue Menu")
EndEvent
/;
Function Shutdown()
	PlayerRef.RemoveSpell(_SLS_DvEf_HeavyBondageLockpickingDiffSpell)
	PlayerRef.RemoveSpell(_SLS_DvEf_HeavyBondageLockpickingImpSpell)
	PlayerRef.RemoveSpell(_SLS_DvEf_HeavyBondagePickpocketDiffSpell)
	PlayerRef.RemoveSpell(_SLS_DvEf_HeavyBondagePickpocketImpSpell)
	PlayerRef.RemoveSpell(_SLS_DeviousDrowningSpell)
	UnRegisterForAllMenus()
	RegForSwimEvents(Reg = false)
	PlayerRef.RemovePerk(_SLS_NoHarvestingPerk)
	UnRegisterForAnimationEvent(PlayerRef, "SoundPlay.NPCHumanPickAxe")
	Self.GetOwningQuest().Stop()
EndFunction

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	EquipEvent(akBaseObject, WasEquipped = true)
EndEvent

Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
	EquipEvent(akBaseObject, WasEquipped = false)
EndEvent

Function EquipEvent(Form akBaseObject, Bool WasEquipped)
	If akBaseObject as Armor
		If akBaseObject.HasKeyword(SexLabNoStrip)
			If akBaseObject.HasKeyword(zad_DeviousHeavyBondage)
				EquippedHeavyBondage(akBaseObject)
			EndIf
		EndIf
	EndIf
EndFunction

Function EquippedHeavyBondage(Form akBaseObject)
	If akBaseObject
		Utility.Wait(1.0)
		RegForSwimEvents(true)
		If PlayerRef.IsEquipped(akBaseObject)
			If LockpickingDiff == 1
				PlayerRef.AddSpell(_SLS_DvEf_HeavyBondageLockpickingDiffSpell, abVerbose  = false)
				
			ElseIf LockpickingDiff == 2
				PlayerRef.AddSpell(_SLS_DvEf_HeavyBondageLockpickingImpSpell, abVerbose  = false)
				RegisterForMenu("Lockpicking Menu")
			EndIf
			
			If PickPocketDiff == 1
				PlayerRef.AddSpell(_SLS_DvEf_HeavyBondagePickpocketDiffSpell, abVerbose  = false)
				
			ElseIf PickPocketDiff == 2
				PlayerRef.AddSpell(_SLS_DvEf_HeavyBondagePickpocketImpSpell, abVerbose  = false)
				RegisterForMenu("ContainerMenu")
			EndIf
			PlayerRef.AddPerk(_SLS_NoHarvestingPerk)
			RegisterForAnimationEvent(PlayerRef, "SoundPlay.NPCHumanPickAxe")
		
		Else
			RegForSwimEvents(false)
			PlayerRef.RemoveSpell(_SLS_DvEf_HeavyBondageLockpickingDiffSpell)
			PlayerRef.RemoveSpell(_SLS_DvEf_HeavyBondageLockpickingImpSpell)
			PlayerRef.RemoveSpell(_SLS_DvEf_HeavyBondagePickpocketDiffSpell)
			PlayerRef.RemoveSpell(_SLS_DvEf_HeavyBondagePickpocketImpSpell)
			UnRegisterForMenu("ContainerMenu")
			UnRegisterForMenu("Lockpicking Menu")
			PlayerRef.RemovePerk(_SLS_NoHarvestingPerk)
			UnRegisterForAnimationEvent(PlayerRef, "SoundPlay.NPCHumanPickAxe")
		EndIf
	EndIf
EndFunction

Function RegForSwimEvents(Bool Reg)
	If Reg
		;Debug.Messagebox("Reg for swim")
		If DeviousDrowning
			RegisterForModEvent("Frostfall_OnPlayerStartSwimming", "Frostfall_OnPlayerStartSwimming")
			RegisterForModEvent("Frostfall_OnPlayerStopSwimming", "Frostfall_OnPlayerStopSwimming")
		EndIf
	Else
		;Debug.Messagebox("UnReg for swim")
		UnRegisterForModEvent("Frostfall_OnPlayerStartSwimming")
		UnRegisterForModEvent("Frostfall_OnPlayerStopSwimming")
	EndIf
EndFunction

Event OnMenuOpen(String MenuName)
	If MenuName == "Lockpicking Menu"
		Input.TapKey(Input.GetMappedKey("Tween Menu", DeviceType = 0xFF))
		Utility.Wait(0.1)
		Debug.Notification("I can't pick locks with my hands bound!")
	
	ElseIf MenuName == "ContainerMenu"
		If PlayerRef.IsSneaking()
			Actor akTarget = Game.GetCurrentCrosshairRef() as Actor
			If akTarget
				If !akTarget.IsDead()
					While Utility.IsInMenuMode()
						Input.TapKey(Input.GetMappedKey("Tween Menu", DeviceType = 0xFF))
						Utility.WaitMenuMode(0.1)
					EndWhile
					Utility.Wait(0.1)
					Debug.Notification("I can't pick pockets with my hands bound!")
				EndIf
			EndIf
		EndIf
		
	;ElseIf MenuName == "Dialogue Menu"
	;	Debug.Messagebox("DialogUE")
	
	EndIf
EndEvent

Event Frostfall_OnPlayerStartSwimming()
	Debug.Notification("I can't swim in this thing!")
	RegisterForAnimationEvent(PlayerRef, "FootLeft")
	RegisterForAnimationEvent(PlayerRef, "FootRight")
	PlayerRef.AddSpell(_SLS_DeviousDrowningSpell, false)
EndEvent

Event Frostfall_OnPlayerStopSwimming()
	;Debug.Notification("Stopped swimming")
	UnRegisterForAnimationEvent(PlayerRef, "FootLeft")
	UnRegisterForAnimationEvent(PlayerRef, "FootRight")
	PlayerRef.RemoveSpell(_SLS_DeviousDrowningSpell)
EndEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	If asEventName == "SoundPlay.NPCHumanPickAxe"
		;Debug.Messagebox("HIHI")
		PlayerRef.MoveTo(PlayerRef)
	Else
		;Debug.Messagebox(asEventName)
		PlayerRef.RemoveSpell(_SLS_DeviousDrowningSpell)
		UnRegisterForAnimationEvent(PlayerRef, "FootLeft")
		UnRegisterForAnimationEvent(PlayerRef, "FootRight")
	EndIf
EndEvent

Function ToggleDeviousDrowning()
	If DeviousDrowning
		If PlayerRef.WornHasKeyword(zad_DeviousHeavyBondage)
			RegForSwimEvents(Reg = true)
		EndIf
	Else
		RegForSwimEvents(Reg = false)
		PlayerRef.RemoveSpell(_SLS_DeviousDrowningSpell)
	EndIf
EndFunction

Int Property LockpickingDiff = 1 Auto Hidden ; 0 - Off, 1 - Difficult, 2 - Impossible
Int Property PickPocketDiff = 1 Auto Hidden ; 0 - Off, 1 - Difficult, 2 - Impossible

Bool Property DeviousDrowning = true Auto Hidden

Perk Property _SLS_NoHarvestingPerk Auto

Keyword zad_DeviousHeavyBondage

Spell Property _SLS_DvEf_HeavyBondageLockpickingDiffSpell Auto
Spell Property _SLS_DvEf_HeavyBondageLockpickingImpSpell Auto
Spell Property _SLS_DvEf_HeavyBondagePickpocketDiffSpell Auto
Spell Property _SLS_DvEf_HeavyBondagePickpocketImpSpell Auto
Spell Property _SLS_DeviousDrowningSpell Auto

Keyword Property SexLabNoStrip Auto

Actor Property PlayerRef Auto

Quest Property MQ101 Auto

SLS_Mcm Property Menu Auto
_SLS_InterfaceDevious Property Devious Auto
