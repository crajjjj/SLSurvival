Scriptname _SLS_StashAddException extends ReferenceAlias  

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	If akDestContainer && !akDestContainer as Actor
		GetStashTrack().ToggleException(akDestContainer)
	Else
		Debug.Messagebox("Destination container is NONE. Aborting")
	EndIf
	Self.GetOwningQuest().Stop()
EndEvent

SLS_StashTrackPlayer Property StashTrack Auto

; Alias properties that point at another quest's alias fail to bind on a new game ("is not the right type"),
; leaving StashTrack None, so stash exceptions were never toggled. Resolve the alias at runtime instead.
SLS_StashTrackPlayer Function GetStashTrack()
	If !StashTrack
		StashTrack = (Game.GetFormFromFile(0x006894, "SL Survival.esp") as Quest).GetAlias(0) as SLS_StashTrackPlayer ; _SLS_StashTrack.PlayerRef
	EndIf
	Return StashTrack
EndFunction
