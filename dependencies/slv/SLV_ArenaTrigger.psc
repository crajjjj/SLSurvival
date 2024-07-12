Scriptname SLV_ArenaTrigger extends ObjectReference  

Actor Property PlayerREF Auto ; Least 'costly' way to refer to the player
 
Event OnTriggerEnter(ObjectReference akActionRef)
	If akActionRef == PlayerREF ; This condition ensures that only the player will trigger this code
		if SLV_SlaveGladiator.getStage() == 1000
			Debug.MessageBox("Your opponents will enter soon, prepare yourself!")

			SLV_SlaveGladiator.SetObjectiveCompleted(1000)
			SLV_SlaveGladiator.SetStage(1500)

			Utility.wait(10)

			Fighter1.getActorRef().enable()
			Fighter1.getActorRef().moveto(FighterMarker )
			Fighter1.getActorRef().startcombat(PlayerRef)

			if SLV_GladiatorEnemyCount.getValue() > 1
				Fighter2.getActorRef().enable()
				Fighter2.getActorRef().moveto(FighterMarker )
				Fighter2.getActorRef().startcombat(PlayerRef)
			endif
			if SLV_GladiatorEnemyCount.getValue() > 2
				Fighter3.getActorRef().enable()
				Fighter3.getActorRef().moveto(FighterMarker )
				Fighter3.getActorRef().startcombat(PlayerRef)
			endif

			arenaTimer.StartArenaTimer()
		endif
	EndIf
EndEvent

Quest Property SLV_SlaveGladiator Auto
ReferenceAlias Property Fighter1 Auto 
ReferenceAlias Property Fighter2 Auto 
ReferenceAlias Property Fighter3 Auto 
ObjectReference Property FighterMarker Auto
SLV_SlaveGladiatorArenaTimer Property arenaTimer Auto
GlobalVariable Property SLV_GladiatorEnemyCount  Auto
