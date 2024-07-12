Scriptname _SLS_CumpulsionPony extends ReferenceAlias  

Event OnInit()
	If Self.GetOwningQuest().IsRunning()
		Debug.Notification("A strange feeling has come over me")
		EquipPonyGearFrom(PlayerRef)
		RegisterForMenu("ContainerMenu")
		PlayerRef.AddSpell(_SLS_CumpulsionPonyDispSpell, false)
	EndIf
EndEvent

Event OnUpdateGameTime()
	EquipPonyGearFrom(PlayerRef)
	RegisterForMenu("ContainerMenu")
EndEvent

Event OnMenuOpen(String MenuName)
	ObjectReference ObjRef = Game.GetCurrentCrosshairRef()
	If ObjRef
		EquipPonyGearFrom(ObjRef)
	EndIf
EndEvent

Function EquipPonyGearFrom(ObjectReference ObjRef)
	Armor Device = Devious.GetEquippablePonyDevice(PlayerRef, ObjRef)
	If Device
		While PlayerRef.IsInFaction(SexLabAnimatingFaction)
			Utility.Wait(5.0)
		EndWhile
		If ObjRef != PlayerRef
			Debug.Messagebox("Something catches your eye in the container and an overwhelming compulsion comes upon you as you hastily equip the pretty pony gear")
		Else
			Debug.Messagebox("A strange compulsion comes over you to try on the pony gear in your pack")
		EndIf
		While Utility.IsInMenuMode()
			Input.TapKey(Input.GetMappedKey("Tween Menu", DeviceType = 0xFF))
			Utility.WaitMenuMode(0.1)
		EndWhile
		Devious.EquipDevice(PlayerRef, Device)
		Keyword Kw = Devious.GetDeviceKeyword(Device)
		If (Kw == Devious.zad_DeviousPlugAnal || Kw == Devious.zad_DeviousPlugVaginal) && !PlayerRef.WornHasKeyword(Devious.zad_DeviousBelt)
			Devious.EquipRandomDeviceByCategory(PlayerRef, "ChastityBelts")
		EndIf
		
		If ObjRef != PlayerRef
			ObjRef.RemoveItem(Device, 1)
		EndIf
		UnRegisterForMenu("ContainerMenu")
		RegisterForSingleUpdateGameTime(1.0)
	EndIf
EndFunction

Function EndEffect()
	Utility.Wait(2.0)
	If !PlayerRef.HasMagicEffect(_SLS_CumEffectHorseMgef)
		PlayerRef.RemoveSpell(_SLS_CumpulsionPonyDispSpell)
		Debug.Notification("My pony compulsion has ended")
		Self.GetOwningQuest().Stop()
	EndIf
EndFunction

Actor Property PlayerRef Auto

Spell Property _SLS_CumpulsionPonyDispSpell Auto

MagicEffect Property _SLS_CumEffectHorseMgef Auto

Faction Property SexLabAnimatingFaction Auto

_SLS_InterfaceDevious Property Devious Auto
