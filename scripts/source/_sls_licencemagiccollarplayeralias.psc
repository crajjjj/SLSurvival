Scriptname _SLS_LicenceMagicCollarPlayerAlias extends ReferenceAlias  

Event OnInit()
	AddInventoryEventFilter(_SLS_EmptyAlways)
EndEvent

Function SetWatchObject(Form WatchObject)
	;Debug.Messagebox("Added Inv filter: " + WatchObject)
	RemoveAllInventoryEventFilters()
	AddInventoryEventFilter(WatchObject)
EndFunction

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	;Debug.Messagebox("item removed")
	LicUtil.CollarItemRemovedFromInv()
EndEvent

Formlist Property _SLS_EmptyAlways Auto

_SLS_LicenceUtil Property LicUtil Auto