Scriptname _JSW_SUB_WashoutEffect extends ActiveMagicEffect

form	thisActor

event OnEffectStart(Actor akTarget, Actor akCaster)

	thisActor = akTarget as form
	RegisterForSingleUpdate(3.0)

endEvent

event OnUpdate()

	int handle = ModEvent.Create("FertilityModeSpermRemoval")
	if handle
		ModEvent.PushForm(handle, thisActor)
		modEvent.Send(handle)
	endIf
	thisActor = none

endEvent
