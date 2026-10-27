Scriptname _SLS_LicenceMagicCollarPlayerAlias extends ReferenceAlias

; Set along with the filter. Events can arrive before the filter is (see _SLS_RemoveAllLicProtect),
; so a removal only reaches LicUtil when it can be the watched collar.
Form WatchedObject

Event OnInit()
	AddInventoryEventFilter(_SLS_EmptyAlways)
EndEvent

Function SetWatchObject(Form WatchObject)
	;Debug.Messagebox("Added Inv filter: " + WatchObject)
	WatchedObject = WatchObject
	RemoveAllInventoryEventFilters()
	AddInventoryEventFilter(WatchObject)
EndFunction

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	;Debug.Messagebox("item removed")
	If WatchedObject
		If akBaseItem != WatchedObject
			Return
		EndIf
	ElseIf !(akBaseItem as Armor) ; Older saves may watch a collar this script never recorded
		Return
	EndIf
	LicUtil.CollarItemRemovedFromInv()
EndEvent

Formlist Property _SLS_EmptyAlways Auto

_SLS_LicenceUtil Property LicUtil Auto
