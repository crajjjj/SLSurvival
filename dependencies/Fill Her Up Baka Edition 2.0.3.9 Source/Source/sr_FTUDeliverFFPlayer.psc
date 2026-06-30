Scriptname sr_FTUDeliverFFPlayer extends ReferenceAlias

Keyword Property sr_CumPump Auto
GlobalVariable Property sr_PlayerInPump Auto 
sr_inflateQuest Property inflater Auto

Event OnPlayerLoadGame()
	(GetOwningQuest() as sr_FTUDeliveryFrame).Maintenance()
EndEvent

Event OnSit(ObjectReference akFurniture)
	If akFurniture.HasKeyword(sr_CumPump)
		sr_PlayerInPump.SetValueInt(1)
		inflater.StripActor(GetActorReference())
	EndIf
EndEvent

Event OnGetUp(ObjectReference akFurniture)
	If akFurniture.HasKeyword(sr_CumPump)
		sr_PlayerInPump.SetValueInt(0)
		inflater.UnstripActor(GetActorReference())
	EndIf
EndEvent