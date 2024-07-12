Scriptname _SLS_LicMagicCurseFollowerAlias extends ReferenceAlias  


Event OnLoad()
	;/
	If Self.GetReference() as Actor
		(Self.GetReference() as Actor).AddSpell(_SLS_MagicLicenceCurse)
	EndIf
	/;
	
	If !(Self.GetReference() as Actor).HasMagicEffect(_SLS_MagicLicenceCollarMgef)
		(Self.GetReference() as Actor).RemoveSpell(_SLS_MagicLicenceCurse)
		Utility.Wait(0.1)
		(Self.GetReference() as Actor).AddSpell(_SLS_MagicLicenceCurse)
		;Debug.Messagebox("READD")
	EndIf
EndEvent
;/
Event OnUnLoad()
	Debug.Messagebox("UNload")
EndEvent

Event OnAttachedToCell()
	Debug.Messagebox("OnAttachedToCell")
EndEvent

Event OnDetachedFromCell()
	Debug.Messagebox("OnDetachedFromCell")
EndEvent
/;
Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
	;Debug.Trace("_SLS_: Remvoed devicessssss")
	If akBaseObject == StorageUtil.GetFormValue(Self.GetReference(), "_SLS_MagicCurseDeviceRender")
		LicUtil.UnNullifyMagic(Self.GetReference() as Actor)
		Self.Clear()
		;Debug.Messagebox("UNNULLIFY")
	EndIf
EndEvent

Spell Property _SLS_MagicLicenceCurse Auto

MagicEffect Property _SLS_MagicLicenceCollarMgef Auto

_SLS_LicenceUtil Property LicUtil Auto
