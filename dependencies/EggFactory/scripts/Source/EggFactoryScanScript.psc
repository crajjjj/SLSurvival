Scriptname EggFactoryScanScript extends ActiveMagicEffect

;Faction Property EggFactoryFaction auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	int handle = ModEvent.Create("EggFactory_Info")
	if (handle)
		modevent.pushform(handle, aktarget)
		if(!modevent.send(handle))
			debug.notification("Mod event could not send.")
		endif
	else
		debug.notification("Could not create mod event, help!")
	endif
EndEvent

