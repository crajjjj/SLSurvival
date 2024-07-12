Scriptname _SLS_DropStealRelay extends ObjectReference  

; Because I can't detect if the item comes from a container (thanks Beth), first add items to this 'relay' container
; If the source container is not None then return the item to it's container/actor
; If the source container is None then move to the stolen chest.

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	StorageUtil.UnSetIntValue(akItemReference, "_SLS_DroppedItemsAliasIndex")
	If akSourceContainer
		ReturnItem(akItemReference, akSourceContainer)
	Else
		_SLS_StolenContainerRef.AddItem(akItemReference)
	EndIf
EndEvent

Function ReturnItem(ObjectReference ObjRef, ObjectReference akSourceContainer)
	akSourceContainer.AddItem(ObjRef)
	If akSourceContainer as Actor
		akSourceContainer.AddItem(_SLS_DummyObject)
		(akSourceContainer as Actor).EquipItem(_SLS_DummyObject)
		akSourceContainer.RemoveItem(_SLS_DummyObject, 999)
		;Debug.Messagebox("Actor")
	EndIf
EndFunction

ObjectReference Property _SLS_StolenContainerRef Auto

Armor Property _SLS_DummyObject Auto
