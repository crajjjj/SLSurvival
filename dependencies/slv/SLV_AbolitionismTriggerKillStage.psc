Scriptname SLV_AbolitionismTriggerKillStage extends ObjectReference  

auto State waiting
	Event onTriggerEnter(objectReference triggerRef)
		Actor actorRef = triggerRef as Actor
		; check whether we care if the player is activating

		if SLV_Abolitionism.getStage() == 5500
			SLV_Abolitionism.SetObjectiveCompleted(5500)
			SLV_Abolitionism.SetStage(6000)
		EndIf
	endEvent
endState
Quest Property SLV_Abolitionism Auto