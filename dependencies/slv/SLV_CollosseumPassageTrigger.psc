Scriptname SLV_CollosseumPassageTrigger extends ObjectReference  

Event OnTriggerEnter(ObjectReference akActionRef)
If akActionRef == Game.GetPlayer() ; This condition ensures that only the player will trigger this code
	;If RunOnce == 0
	if SLV_ColosseumFunFairQuest.getstage() == 3500
		SLV_ColosseumFunFairQuest.SetObjectiveCompleted(3500)
		SLV_ColosseumFunFairQuest.setstage(4000)

		ActorUtil.ClearPackageOverride(SLV_Caesar.getActorRef())
		SLV_Caesar.getActorRef().evaluatePackage()
	EndIf
EndIf
EndEvent

Int RunOnce

Quest Property SLV_ColosseumFunFairQuest auto
ReferenceAlias Property SLV_Caesar Auto

