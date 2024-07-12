Scriptname EggFactoryDestructionScript extends ObjectReference

Ingredient property MyEgg Auto

Faction property PlayerFaction Auto

Event OnLoad()
;	Debug.Notification("Loaded")
	Utility.Wait(1.0)
	DamageObject(100.0)
EndEvent

Event OnGrab()
;	Debug.Notification("Grabbed")
	DamageObject(100.0)
EndEvent

Event OnRelease()
;	Debug.Notification("Released")
	DamageObject(100.0)
EndEvent

Event OnDestructionStageChanged(int aiOldStage, int aiCurrentStage)
;	Debug.Notification("Out destruction stage changed from " + aiOldStage + " to " + aiCurrentStage)
	if (aiOldStage == 1)
		ObjectReference newegg
		newegg=PlaceAtMe(MyEgg)
		newegg.SetFactionOwner(PlayerFaction)
	endif
EndEvent