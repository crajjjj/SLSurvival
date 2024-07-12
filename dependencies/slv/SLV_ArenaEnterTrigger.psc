Scriptname SLV_ArenaEnterTrigger extends ObjectReference

Event OnTriggerEnter(ObjectReference akActionRef)
If akActionRef == Game.GetPlayer() ; This condition ensures that only the player will trigger this code
	;If RunOnce == 0
	if SLV_ColosseumArenaQuest.getstage() == 4500
		SLV_ColosseumArenaQuest.setstage(5000)
	elseif SLV_ArenaFightQuest.getstage() == 500
		SLV_ArenaFightQuest.SetObjectiveCompleted(500)
		SLV_ArenaFightQuest.setstage(1000)
	elseif SLV_ArenaFightQuest.getstage() == 2000
		arenaDoor.lock(true)
	elseif SLV_ArenaFightQuest.getstage() == 3000
		arenaDoor.lock(true)
	elseif SLV_ArenaFightQuest.getstage() == 3500
		arenaDoor.lock(true)
	elseif SLV_ArenaShowQuest.getstage() == 500
		SLV_ArenaShowQuest.SetObjectiveCompleted(500)
		SLV_ArenaShowQuest.setstage(1000)
	elseif SLV_ArenaShowQuest.getstage() == 9500
		arenaDoor.lock(true)
	EndIf
EndIf
EndEvent

Quest Property SLV_ArenaFightQuest auto
Quest Property SLV_ArenaShowQuest auto
Quest Property SLV_ColosseumArenaQuest auto
ObjectReference Property arenaDoor auto
