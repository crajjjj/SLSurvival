Scriptname SLV_SlaveFighterDeath extends ReferenceAlias  

event OnDeath(Actor akKiller)
	;Debug.MessageBox("You won!")

	if SLV_SlaveGladiator.getStage() == 1500
		SLV_SlaveGladiator.SetObjectiveCompleted(1500)
		SLV_SlaveGladiator.SetStage(2000)
		arenaDoor.enable()
		arenaDoor.lock(false)
		arenadummyDoor.disable()
	EndIf
EndEvent

;Event OnActivate(ObjectReference akActionRef)
;	Debug.notification("You are not allowed to loot in the arena")
;EndEvent

Quest Property SLV_SlaveGladiator Auto
ObjectReference Property arenaDoor  Auto  
ObjectReference Property arenadummyDoor  Auto  

ReferenceAlias Property Fighter1 Auto
ReferenceAlias Property Fighter2 Auto
ReferenceAlias Property Fighter3 Auto