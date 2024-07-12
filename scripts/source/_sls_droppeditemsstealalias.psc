Scriptname _SLS_DroppedItemsStealAlias extends ReferenceAlias  

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
EndEvent

State Track
	Event OnBeginState()
		DroppedMarker = PlayerRef.PlaceAtMe(_SLS_DroppedItemsMarker)
	EndEvent
	
	Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
		If akItemReference
			StorageUtil.FormListAdd(DroppedMarker, "_SLS_DroppedItemsList", akItemReference)
		EndIf
	EndEvent
	
	Event OnEndState()
		If StorageUtil.FormListCount(DroppedMarker, "_SLS_DroppedItemsList") > 0
			DropSteal.BeginTracking(DroppedMarker)
		Else
			DroppedMarker.Disable()
			DroppedMarker.Delete()
			DroppedMarker = None
		EndIf
	EndEvent
EndState

ObjectReference DroppedMarker

Actor Property PlayerRef Auto

Static Property _SLS_DroppedItemsMarker Auto

_SLS_DroppedItemsSteal Property DropSteal Auto
