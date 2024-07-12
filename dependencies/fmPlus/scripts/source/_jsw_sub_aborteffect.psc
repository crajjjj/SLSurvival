Scriptname _JSW_SUB_AbortEffect extends ActiveMagicEffect

event OnEffectStart(Actor akTarget, Actor akCaster)

	if !akTarget
		return
	endIf

	; 1.56 make it all event
	int handle = ModEvent.Create("FertilityModeAbort")
	if handle
		ModEvent.PushForm(handle, akTarget as form)
		ModEvent.Send(handle)
	endIf

endEvent
