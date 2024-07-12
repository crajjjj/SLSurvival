Scriptname _SLS_HighlightItemsPlayerAlias extends ReferenceAlias  

Event OnInit()
	 RegForControls()
EndEvent

Function RegForControls()
	RegisterForControl("Move")
	RegisterForControl("Forward")
	RegisterForControl("Back")
	RegisterForControl("Strafe Left")
	RegisterForControl("Strafe Right")
	RegisterForControl("Activate")
EndFunction

Event OnControlDown(string control)
	UnRegisterForAllControls()
	Shutdown()
EndEvent

Function Shutdown()
;/
	DisableMarkers()
	DeleteMarkers()
	/;
	SendModEvent("_SLS_HighlightItemsStop")
	Int i = 5
	While i > 0 && StorageUtil.FormListCount(None, "_SLS_HighlightedItemsList") > 0
		i -= 1
		Utility.Wait(0.5)
	EndWhile
	;Utility.Wait(2.5)
	If StorageUtil.FormListCount(None, "_SLS_HighlightedItemsList") > 0 ; If timed out waiting for markers to clear then do cleanup
		DisableMarkers()
		DeleteMarkers()
		StorageUtil.FormListClear(None, "_SLS_HighlightedItemsList")
		Self.GetOwningQuest().Stop()
	EndIf
	Self.GetOwningQuest().Stop()
EndFunction

Function DisableMarkers()
	Int i = 1
	ObjectReference Marker
	While i < Self.GetOwningQuest().GetNumAliases()
		Marker = (Self.GetOwningQuest().GetNthAlias(i) as _SLS_HighlightItem).Marker
		If Marker
			Marker.Disable()
		Else
			Return
		EndIf
		i += 1
	EndWhile
EndFunction

Function DeleteMarkers()
	Int i = 1
	ObjectReference Marker
	While i < Self.GetOwningQuest().GetNumAliases()
		Marker =  (Self.GetOwningQuest().GetNthAlias(i) as _SLS_HighlightItem).Marker
		If Marker
			Marker.Delete()
		Else
			Return
		EndIf
		i += 1
	EndWhile
EndFunction
