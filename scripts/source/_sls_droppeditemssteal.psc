Scriptname _SLS_DroppedItemsSteal extends Quest  

Event OnInit()
	If Self.IsRunning()
		RegisterForMenu("InventoryMenu")
	EndIf
EndEvent

Event OnMenuOpen(String MenuName)
	DroppedItem.GoToState("Track")
EndEvent

Event OnMenuClose(String MenuName)
	DroppedItem.GoToState("")
EndEvent

Function BeginTracking(ObjectReference DroppedMarker)
	ReferenceAlias AliasSelect = GetDropAlias()
	StorageUtil.SetFloatValue(DroppedMarker, "_SLS_DroppedItemsSetupTime", Utility.GetCurrentGameTime())
	AliasSelect.ForceRefTo(DroppedMarker)
	(AliasSelect as _SLS_DroppedItemsMarkerAlias).BeginTracking(DroppedMarker)
	;Debug.Messagebox("Begin tracking: " + DroppedMarker + "\n\n" + StorageUtil.FormListToArray(DroppedMarker, "_SLS_DroppedItemsList")) 
EndFunction

Function StealItems(ObjectReference DroppedMarker)
	Int i = 0
	ObjectReference ObjRef
	While i < StorageUtil.FormListCount(DroppedMarker, "_SLS_DroppedItemsList")
		ObjRef = StorageUtil.FormListGet(DroppedMarker, "_SLS_DroppedItemsList", i) as ObjectReference
		If ObjRef && PlayerRef.GetItemCount(ObjRef) == 0
			;Debug.Messagebox("Stealing: " + ObjRef.GetBaseObject().GetName() + "\n\nPos:\nX: " + ObjRef.GetPositionX() + "\nY: " + ObjRef.GetPositionY() + "\nz: " + ObjRef.GetPositionZ())
			_SLS_DropStealRelayContainer.AddItem(ObjRef)	
		EndIf
		i += 1
	EndWhile
	RunCleanup(DroppedMarker)
EndFunction

Float Function MarkerUpdate(ObjectReference DroppedMarker)
	If DroppedMarker.GetDistance(PlayerRef) > 4096.0
		;Debug.Messagebox(DroppedMarker + " is too far from player: \n:" + DroppedMarker.GetDistance(PlayerRef))
		StealItems(DroppedMarker)
		Return 0.0
	EndIf
	Return 1.0
EndFunction

Function MarkerUnloaded(ObjectReference DroppedMarker)
	;Debug.Messagebox(DroppedMarker + " unloaded")
	StealItems(DroppedMarker)
EndFunction

ReferenceAlias Function GetDropAlias()
	Int i = 0
	While i < _SLS_DroppedItemsStealAliases.GetNumAliases()
		If !(_SLS_DroppedItemsStealAliases.GetNthAlias(i) as ReferenceAlias).GetReference()
			Return _SLS_DroppedItemsStealAliases.GetNthAlias(i) as ReferenceAlias
		EndIf
		i += 1
	EndWhile
	Return GetOldestAlias()
EndFunction

ReferenceAlias Function GetOldestAlias()
	Float OldestValue = 9999999.9
	Int OldestIndex = -1
	ObjectReference Marker
	Int i = 0
	While i < _SLS_DroppedItemsStealAliases.GetNumAliases()
		Marker = (_SLS_DroppedItemsStealAliases.GetNthAlias(i) as ReferenceAlias).GetReference()
		If Marker && StorageUtil.GetFloatValue(Marker, "_SLS_DroppedItemsSetupTime") < OldestValue
			OldestIndex = i
			OldestValue = StorageUtil.GetFloatValue(Marker, "_SLS_DroppedItemsSetupTime")
		EndIf
		i += 1
	EndWhile
	Return _SLS_DroppedItemsStealAliases.GetNthAlias(OldestIndex) as ReferenceAlias
EndFunction

Bool Function RunCleanup(ObjectReference DroppedMarker)
	Int i = 0
	While i < _SLS_DroppedItemsStealAliases.GetNumAliases()
		If (_SLS_DroppedItemsStealAliases.GetNthAlias(i) as ReferenceAlias).GetReference() == DroppedMarker
			((_SLS_DroppedItemsStealAliases.GetNthAlias(i) as ReferenceAlias) as _SLS_DroppedItemsMarkerAlias).EndTracking()
			Return true
		EndIf
		i += 1
	EndWhile
	Return false
EndFunction

Function IndexObjRefs(ObjectReference Marker, Int AliasIndex)
	Int i = 0
	ObjectReference ObjRef
	While i < StorageUtil.FormListCount(Marker, "_SLS_DroppedItemsList")
		ObjRef = StorageUtil.FormListGet(Marker, "_SLS_DroppedItemsList", i) as ObjectReference
		If ObjRef
			If StorageUtil.GetIntValue(Marker, "_SLS_DroppedItemsAliasIndex", Missing = -1) != AliasIndex
				 ; ObjRef is already associated with another marker - Was picked up and dropped again. Associate with new marker
				ObjectReference OldMarker = ((_SLS_DroppedItemsStealAliases.GetNthAlias(StorageUtil.GetIntValue(ObjRef, "_SLS_DroppedItemsAliasIndex"))) as ReferenceAlias).GetReference()
				StorageUtil.FormlistRemove(OldMarker, "_SLS_DroppedItemsList", ObjRef)
			EndIf
			StorageUtil.SetIntValue(ObjRef, "_SLS_DroppedItemsAliasIndex", AliasIndex)
		EndIf
		i += 1
	EndWhile
EndFunction

Function UnIndexMarker(ObjectReference Marker)
	Int i = 0
	ObjectReference ObjRef
	While i < StorageUtil.FormListCount(Marker, "_SLS_DroppedItemsList")
		ObjRef = StorageUtil.FormListGet(Marker, "_SLS_DroppedItemsList", i) as ObjectReference
		If ObjRef
			StorageUtil.UnSetIntValue(ObjRef, "_SLS_DroppedItemsAliasIndex")
		EndIf
		i += 1
	EndWhile
EndFunction

Quest Property _SLS_DroppedItemsStealAliases Auto

ObjectReference Property _SLS_DropStealRelayContainer Auto

Actor Property PlayerRef Auto

_SLS_DroppedItemsStealAlias Property DroppedItem Auto
