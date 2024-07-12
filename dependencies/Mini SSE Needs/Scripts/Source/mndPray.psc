Scriptname mndPray extends ObjectReference

Event OnActivate(ObjectReference akActionRef)
	if akActionRef == Game.GetPlayer()
		mndController.instance().lastTimePray = Utility.GetCurrentGameTime()
	endif
EndEvent
