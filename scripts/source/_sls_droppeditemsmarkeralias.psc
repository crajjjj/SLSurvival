Scriptname _SLS_DroppedItemsMarkerAlias extends ReferenceAlias  

Function BeginTracking(ObjectReference DroppedMarker)
	DropSteal.IndexObjRefs(DroppedMarker, AliasIndex)
	RegisterForSingleUpdateGameTime(1.0)
EndFunction

Function EndTracking()
	UnRegisterForUpdateGameTime()
	CleanUp()
EndFunction

Event OnUnload()
	DropSteal.MarkerUnloaded(Self.GetReference())
EndEvent

Event OnUpdateGameTime()
	Float UpdateTime = DropSteal.MarkerUpdate(Self.GetReference())
	If UpdateTime > 0.0
		RegisterForSingleUpdateGameTime(UpdateTime)
	Else
		CleanUp()
	EndIf
EndEvent

Function CleanUp()
	ObjectReference DroppedMarker = Self.GetReference()
	If DroppedMarker
		DropSteal.UnIndexMarker(DroppedMarker)
		StorageUtil.UnSetFloatValue(DroppedMarker, "_SLS_DroppedItemsSetupTime")
		StorageUtil.FormListClear(DroppedMarker, "_SLS_DroppedItemsList")
		DroppedMarker.Disable()
		DroppedMarker.Delete()
	EndIf
	Self.Clear()
EndFunction

Int Property AliasIndex Auto

_SLS_DroppedItemsSteal Property DropSteal Auto
