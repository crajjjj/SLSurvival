Scriptname sr_FTUPumpAlias extends ReferenceAlias

Keyword Property sr_CumPump Auto
Keyword Property sr_CumPumpForced Auto
GlobalVariable Property sr_PlayerInPump Auto 
sr_inflateQuest Property inflater Auto

Event OnGetUp(ObjectReference akFurniture)
	If akFurniture.HasKeyword(sr_CumPump) || akFurniture.HasKeyword(sr_CumPumpForced)
		If GetActorReference() == inflater.player
			sr_PlayerInPump.SetValueInt(0)
		EndIf
		inflater.UnstripActor(GetActorReference())
		clear()
	EndIf
EndEvent
