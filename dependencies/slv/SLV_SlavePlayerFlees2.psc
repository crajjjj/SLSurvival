Scriptname SLV_SlavePlayerFlees2 extends ReferenceAlias  

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	if SLV_ArenaFightQuest.getStage() == 1500 &&  akOldLoc == SLV_Arena
		SLV_ArenaFightQuest.SetObjectiveCompleted(1500)
		SLV_ArenaFightQuest.SetStage(5000)

		ActorUtil.RemoveAllPackageOverride(SLV_DoNothing2)

		Debug.Trace("We have left the arena location!")
		Debug.Notification("We have left the arena location!")
	EndIf
endEvent

Quest Property SLV_ArenaFightQuest Auto
Location Property SLV_Arena Auto
Package Property SLV_DoNothing2 Auto