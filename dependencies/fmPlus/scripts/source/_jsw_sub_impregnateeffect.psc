Scriptname _JSW_SUB_ImpregnateEffect extends ActiveMagicEffect


event OnEffectStart(Actor akTarget, Actor akCaster)

	; new 1.56
	int handle = ModEvent.Create("FertilityModeImpregnate")
	if handle
		ModEvent.PushForm(handle, akTarget as form)
		ModEvent.Send(handle)
	endIf

endEvent
