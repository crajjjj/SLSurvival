Scriptname aaaKNNBedrollACTI extends ObjectReference

Quest Property PerkAnim auto

Event OnActivate(ObjectReference akActionRef)
	if akActionRef as Actor
		;Debug.Trace("OnActivate")
		if akActionRef == Game.GetPlayer()
			(PerkAnim as aaaKNNPlayPerkBedAnimQuest).ActivateBedrollActivator(Self, (akActionRef as Actor))
		endIf
	endIf
EndEvent