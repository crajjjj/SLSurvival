Scriptname SLV_SlavePlayerFlees extends ReferenceAlias  

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	if SLV_SlaveGladiator.getStage() == 1500 &&  akOldLoc == SLV_Arena
		SLV_SlaveGladiator.SetObjectiveCompleted(1500)
		SLV_SlaveGladiator.SetStage(2200)
		Debug.Trace("We have left the arena location!")
		Debug.Notification("We have left the arena location!")
	EndIf
endEvent

Quest Property SLV_SlaveGladiator Auto
Location Property SLV_Arena Auto