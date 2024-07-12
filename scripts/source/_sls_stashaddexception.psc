Scriptname _SLS_StashAddException extends ReferenceAlias  

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	If akDestContainer && !akDestContainer as Actor
		StashTrack.ToggleException(akDestContainer)
	Else
		Debug.Messagebox("Destination container is NONE. Aborting")
	EndIf
	Self.GetOwningQuest().Stop()
EndEvent

SLS_StashTrackPlayer Property StashTrack Auto
