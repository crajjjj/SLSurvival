Scriptname mndBathInRiversScript extends activemagiceffect

Event OnEffectStart(Actor akTarget, Actor akCaster)
	mndController.instance().bathInRivers()
endEvent
