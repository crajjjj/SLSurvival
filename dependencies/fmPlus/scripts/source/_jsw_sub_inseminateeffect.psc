Scriptname _JSW_SUB_InseminateEffect extends ActiveMagicEffect


event OnEffectStart(Actor akTarget, Actor akCaster)

	; 1.50 make the already existing event do all the work!
	int handle = ModEvent.Create("FertilityModeAddSperm")
	if (handle)
		ModEvent.PushForm(handle, akTarget as form)
		ModEvent.PushString(handle, akCaster.GetDisplayName())
		ModEvent.PushForm(handle, akCaster as form)
		ModEvent.Send(handle)
	endIf

endEvent
