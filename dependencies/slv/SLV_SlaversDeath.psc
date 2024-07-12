Scriptname SLV_SlaversDeath extends ReferenceAlias  

event OnDeath(Actor akKiller)
	;Debug.MessageBox("You won!")

	if SLV_Abolitionism.getStage() == 6000 && Draemora.getActorRef().IsDead() && Thalmor.getActorRef().IsDead() 
		SLV_Abolitionism.SetObjectiveCompleted(6000)
		SLV_Abolitionism.SetStage(6500)

		if SLV_DeadSlaveWalkingquest.isrunning()
			SLV_DeadSlaveWalkingquest.CompleteAllObjectives()
			SLV_DeadSlaveWalkingquest.SetStage(9000)
		endif
		if SLV_CelebrateSlaveryquest.isrunning()
			SLV_CelebrateSlaveryquest.FailAllObjectives()
			SLV_CelebrateSlaveryquest.SetStage(9000)
		endif
	EndIf
EndEvent

Quest Property SLV_Abolitionism Auto
ReferenceAlias Property Draemora Auto 
ReferenceAlias Property Thalmor Auto 

Quest Property SLV_DeadSlaveWalkingquest Auto
Quest Property SLV_CelebrateSlaveryquest Auto
