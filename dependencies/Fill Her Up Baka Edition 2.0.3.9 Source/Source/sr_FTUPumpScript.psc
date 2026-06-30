Scriptname sr_FTUPumpScript extends ObjectReference

bool property bound = false auto
GlobalVariable Property sr_PlayerInPump Auto 
sr_inflateQuest Property inflater Auto
ReferenceAlias Property pumpAlias auto

Event OnActivate(ObjectReference akActionRef)
	If bound
		if akActionRef == inflater.player
			sr_PlayerInPump.SetValueInt(2)
		EndIf
		inflater.StripActor(akActionRef as Actor)
	Else
		If akActionRef == inflater.player
			sr_PlayerInPump.SetValueInt(1)
		EndIf
		inflater.StripActor(akActionRef as Actor)
	EndIf
	pumpAlias.ForceRefTo(akActionRef)
EndEvent
