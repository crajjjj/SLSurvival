Scriptname _SLS_DroppedItemTrigger extends ObjectReference  

;/ 0 size - no enter/leave events
Event OnTriggerEnter(ObjectReference akActionRef)
	Debug.Messagebox("Enter: " + akActionRef)
EndEvent

Event OnTriggerLeave(ObjectReference akActionRef)
	Debug.Messagebox("Leave: " + akActionRef)
EndEvent
/;;

;/
Event OnInit()
	
EndEvent
/;
Function InitTrigger()
	;Debug.Messagebox("Init(): " + Self)
	;Utility.Wait(1.0) ; Not priority now
	RegisterForModEvent("_SLS_LostItemMovedToStorage", "On_SLS_LostItemMovedToStorage")
	StorageUtil.FormListAdd(None, "_SLS_DroppedItemsTriggersAll", Self)
	StorageUtil.FormListAdd(None, "_SLS_ActiveDroppedItemsTriggers", Self, AllowDuplicate = false)
	TestMarker = PlaceAtMe(xMarker)
	LostFound.UpdateLostCount()
	RegisterForSingleUpdateGameTime(24.0 * JsonUtil.GetFloatValue(Self, "daystodumplostitems", Missing = 3.0))
	RegisterForSingleUpdate(4.0) ; Allow time to settle
EndFunction

Event OnUpdateGameTime()
	Int i = StorageUtil.FormListCount(Self, "_SLS_DroppedItems")
	ObjectReference ObjRef
	While i > 0
		i -= 1
		ObjRef = StorageUtil.FormListGet(Self, "_SLS_DroppedItems", i) as ObjectReference
		If ObjRef
			LostFound.ClearObjRef(ObjRef)
		EndIf
	EndWhile
	Shutdown()
EndEvent

Event On_SLS_LostItemMovedToStorage(Form ObjRef)
	;/
	If StorageUtil.FormListFind(Self, "_SLS_DroppedItems", ObjRef) >= 0
		Debug.Messagebox("Object moved to storage: " + ObjRef)
	EndIf
	/;
	StorageUtil.FormListRemove(Self, "_SLS_DroppedItems", ObjRef)
	If StorageUtil.FormListCount(Self, "_SLS_DroppedItems") == 0
		Shutdown()
	EndIf
EndEvent

Event OnUpdate()
	If PlayerRef.GetDistance(Self) < 1500.0 ; No point if not close enough
		;Debug.Trace("_SLS_: Trig: " + Self + ". Items: " + StorageUtil.FormListToArray(Self, "_SLS_DroppedItems"))
		Bool WasMoved = false
		;Debug.Messagebox("Close enough")
		Int i = StorageUtil.FormListCount(Self, "_SLS_DroppedItems")
		If i > 0
			ObjectReference ObjRef
			While i > 0
				i -= 1
				ObjRef = StorageUtil.FormListGet(Self, "_SLS_DroppedItems", i) as ObjectReference
				If ObjRef && PlayerRef.GetItemCount(ObjRef) == 0
					TestMarker.MoveTo(ObjRef)
					PO3_SKSEFunctions.MoveToNearestNavmeshLocation(TestMarker)
					;Debug.Trace("_SLS_: TEST: " + ObjRef.GetDisplayName() + ". Distance to test marker: " + TestMarker.GetDistance(ObjRef))
					If ObjRef.GetDistance(Self) > _SLS_DroppedItemDistanceMax.GetValue() || TestMarker.GetDistance(ObjRef) > 60.0
						_SLS_DroppedItemsCalmerRef.AddItem(ObjRef) ; Need to move item to container to remove any momentum it's built up otherwise it'll just fly off again
						ObjRef.MoveTo(Self, afXOffset = Utility.RandomFloat(-256.0, 256.0), afYOffset = Utility.RandomFloat(-256.0, 256.0), afZOffset = 20.0)
						PO3_SKSEFunctions.MoveToNearestNavmeshLocation(ObjRef)
						ObjRef.MoveTo(ObjRef, afZOffset = 30.0)
						;ObjRef.ApplyHavokImpulse(0.0, 0.0, -1.0, 1.0) ; Settle
						WasMoved = true
					EndIf
				Else
					StorageUtil.FormListRemove(Self, "_SLS_DroppedItems", ObjRef)
				EndIf
			EndWhile
			If WasMoved
				RegisterForSingleUpdate(1.0)
			Else
				RegisterForSingleUpdate(3.0)
			EndIf
		
		Else
			;Debug.Messagebox("Deleting: " + Self)
			Shutdown()
		EndIf
	Else
		;Debug.Messagebox("Too far away")
		RegisterForSingleUpdate(3.0)
	EndIf
EndEvent

Function PickedUp(ObjectReference ObjRef)
	StorageUtil.FormListRemove(Self, "_SLS_DroppedItems", ObjRef)
	If StorageUtil.FormListCount(Self, "_SLS_DroppedItems") == 0
		Shutdown()
	EndIf
EndFunction

Event OnCellAttach()
	;Debug.Messagebox("Attach(): " + Self)
	StorageUtil.FormListAdd(None, "_SLS_ActiveDroppedItemsTriggers", Self, AllowDuplicate = false)
	LostFound.UpdateLostCount()
	RegisterForSingleUpdate(3.0)
EndEvent

Event OnCellDetach()
	;Debug.Messagebox("Detatch(): " + Self)
	StorageUtil.FormListRemove(None, "_SLS_ActiveDroppedItemsTriggers", Self)
	LostFound.UpdateLostCount()
	UnRegisterForUpdate()
EndEvent

Function Shutdown()
	;Debug.Messagebox("Deleting self: " + Self)
	UnRegisterForModEvent("_SLS_LostItemMovedToStorage")
	DumpItemsToStorage()
	StorageUtil.FormListRemove(None, "_SLS_ActiveDroppedItemsTriggers", Self)
	StorageUtil.FormListRemove(None, "_SLS_DroppedItemsTriggersAll", Self)
	StorageUtil.FormListClear(Self, "_SLS_DroppedItems")
	TestMarker.Delete()
	Disable()
	Delete()
EndFunction

Function DumpItemsToStorage()
	Int i = StorageUtil.FormListCount(Self, "_SLS_DroppedItems")
	ObjectReference ObjRef
	While i > 0
		i -= 1
		ObjRef = StorageUtil.FormListGet(Self, "_SLS_DroppedItems", i) as ObjectReference
		If ObjRef
			LostFoundBarrelRef.AddItem(ObjRef)
			LostFound.ClearObjRef(ObjRef)
		EndIf
	EndWhile
	LostFound.UpdateLostCount()
EndFunction

Actor Property PlayerRef Auto

ObjectReference TestMarker
ObjectReference Property _SLS_DroppedItemsCalmerRef Auto
ObjectReference Property LostFoundBarrelRef Auto

GlobalVariable Property _SLS_DroppedItemDistanceMax Auto

Static Property XMarker Auto

_SLS_LostFound Property LostFound Auto
