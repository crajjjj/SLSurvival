Scriptname EggFActoryuncurseScript extends ActiveMagicEffect

;Faction Property EggFactoryFaction auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	int handle = ModEvent.Create("EggFactory_UnCurse")
	if (handle)
		modevent.pushform(handle, akTarget)
		modevent.send(handle)
	endif
EndEvent

