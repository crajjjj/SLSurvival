Scriptname _SLS_OnLocChangeDlhpResume extends ReferenceAlias  

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	SendModEvent("dhlp-Resume")
	(Game.GetFormFromFile(0x02C168, "SL Survival.esp") as _SLS_KennelUtil).PlayerLeavesKennel()
	Self.GetOwningQuest().Stop()
EndEvent

Quest Property _SLS_KennelKeeper Auto
