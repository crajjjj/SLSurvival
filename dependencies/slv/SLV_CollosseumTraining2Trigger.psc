Scriptname SLV_CollosseumTraining2Trigger extends ObjectReference  

Event OnTriggerEnter(ObjectReference akActionRef)
If akActionRef == Game.GetPlayer() ; This condition ensures that only the player will trigger this code
	;If RunOnce == 0
	if SLV_ColosseumTrainingQuest.getstage() == 4500
		SLV_ColosseumTrainingQuest.SetObjectiveCompleted(4500)
		SLV_ColosseumTrainingQuest.setstage(5000)
	EndIf
	
	if SLV_SexSlaveTraining6Quest.getstage() == 2000
		int currentvalue = SLV_ColosseumTrainingCount.getValue() as int
		if currentvalue == 0 || currentvalue== 2 || currentvalue == 4
			if SLV_SexSlaveTraining6Quest.ModObjectiveGlobal(1, SLV_ColosseumTrainingCount, 2000, 6)	
				SLV_SexSlaveTraining6Quest.SetObjectiveCompleted(2000)
				SLV_SexSlaveTraining6Quest.setstage(2500)
			EndIf	
		EndIf	
	EndIf	
EndIf
EndEvent

Int RunOnce

Quest Property SLV_ColosseumTrainingQuest auto
Quest Property SLV_SexSlaveTraining6Quest auto
GlobalVariable Property SLV_ColosseumTrainingCount auto