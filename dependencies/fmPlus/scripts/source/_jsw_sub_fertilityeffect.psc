Scriptname _JSW_SUB_FertilityEffect extends ActiveMagicEffect

actor	thisActor

event OnEffectStart(Actor akTarget, Actor akCaster)

	thisActor = akTarget
	RegisterForSingleUpdate(5.0)

endEvent

event OnUpdate()

	int handle = ModEvent.Create("FertilityModeFertilityBuff")
	if handle
		ModEvent.PushForm(handle, thisActor as form)
		ModEvent.Send(handle)
	endIf
	thisActor = none

endEvent
