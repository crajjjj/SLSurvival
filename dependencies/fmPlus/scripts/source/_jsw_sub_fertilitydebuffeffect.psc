Scriptname _JSW_SUB_FertilityDebuffEffect extends ActiveMagicEffect

actor	thisActor

event OnEffectStart(Actor akTarget, Actor akCaster)

	thisActor = akTarget
	RegisterForSingleUpdate(5.0)

endEvent

event OnUpdate()

	int handle = ModEvent.Create("FertilityModeFertilityDebuff")
	if handle
		ModEvent.PushForm(handle, thisActor as form)
		ModEvent.Send(handle)
	endIf
	thisActor = none

endEvent
