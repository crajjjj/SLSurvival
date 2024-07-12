Scriptname _STA_PlayerGagRemoveDetect extends ReferenceAlias

_STA_SexDialogUtil Property DialogUtil Auto

Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
	If akBaseObject as Armor
		DialogUtil.CheckIsGagRemoved(akBaseObject)
	EndIf
EndEvent
