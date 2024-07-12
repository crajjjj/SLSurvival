Scriptname EggPotionScript extends ActiveMagicEffect

;Faction Property EggFactoryFaction auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	int handle = ModEvent.Create("EggFactory_RapidStart")
	if (handle)
		modevent.pushform(handle, akTarget)
		modevent.pushint(handle, utility.randomint(2,4))
		modevent.send(handle)
	endif
EndEvent

