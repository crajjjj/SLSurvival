Scriptname _JSW_SUB_BirthEffect extends ActiveMagicEffect


event OnEffectStart(Actor akTarget, Actor akCaster)

	if !akTarget
		return
	endIf
	
	int handle = ModEvent.Create("FMPlusLabor")
	if handle
		ModEvent.PushString(handle, "")
		ModEvent.PushForm(handle, akTarget as form)
		ModEvent.PushInt(handle, -1)
		ModEvent.Send(handle)
	endIf

endEvent
