Scriptname _SLS_LicenceMagicCollar extends ReferenceAlias  

SLS_Mcm Property Menu Auto
_SLS_LicenceUtil Property LicUtil Auto
SLS_Utility Property Util Auto

MagicEffect Property _SLS_MagicLicenceCollarMgef Auto

Spell Property _SLS_MagicLicenceCollarSpell Auto
Spell Property _SLS_MagicLicenceCurse Auto

Actor Property PlayerRef Auto

Bool CheckWait = false

;/ only works when removed via key etc
Event OnInit()
	RegisterForModEvent("DDI_DeviceRemoved", "OnDDI_DeviceRemoved")
EndEvent

Event OnDDI_DeviceRemoved(Form inventoryDevice, Form deviceKeyword, Form akActor)
	Debug.Messagebox("Device removed")
	If akActor == PlayerRef
		If inventoryDevice == Self.GetReference()
			Debug.Messagebox("Device removed")
			CheckCollar()
		EndIf
	EndIf
EndEvent
/;

Event OnEquipped(Actor akActor)
	If akActor == PlayerRef
		CheckCollar()
	EndIf
EndEvent

Event OnUnequipped(Actor akActor)
	If akActor == PlayerRef
		CheckCollar()
	EndIf
EndEvent

State BeginCheck
	Event OnEquipped(Actor akActor)
		CheckWait = true
	EndEvent
	
	Event OnUnequipped(Actor akActor)
		CheckWait = true
	EndEvent
EndState

;/
Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	Debug.Messagebox("Container changed")
EndEvent
/;

Function CheckCollar()
	GoToState("BeginCheck")
	
	; Wait for events to stop firing
	CheckWait = false
	Utility.Wait(1.0)
	While CheckWait
		CheckWait = false
		Utility.Wait(1.0)
	EndWhile
		
	; Check the collar
	;Debug.Messagebox(Self.GetReference().GetBaseObject())
	If Self.GetReference() && PlayerRef.IsEquipped(Self.GetReference().GetBaseObject())
		;Debug.Messagebox("equipped")
		If !PlayerRef.HasMagicEffect(_SLS_MagicLicenceCollarMgef)
			PlayerRef.AddSpell(_SLS_MagicLicenceCollarSpell)
		EndIf
		LicUtil.IsCollared = true
		StorageUtil.SetIntValue(None, "_SLS_PlayerIsMagicCursed", 2)
		
	Else
		PlayerRef.RemoveSpell(_SLS_MagicLicenceCollarSpell)
		PlayerRef.RemoveSpell(_SLS_MagicLicenceCurse) ; Remove both collar and non collar spells just in case
		Util.RemoveOverlay(PlayerRef, "\\SL Survival\\magic_silence_collar.dds", Menu.OverlayAreas[Menu.MagicCurseArea])
		StorageUtil.SetIntValue(None, "_SLS_PlayerIsMagicCursed", 0)
		LicUtil.IsCollared = false
	EndIf
	LicUtil.CheckOrdinatior(LicUtil.IsCollared)
	GoToState("")
EndFunction
