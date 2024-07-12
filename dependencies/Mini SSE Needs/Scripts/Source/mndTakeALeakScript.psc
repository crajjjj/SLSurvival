Scriptname mndTakeALeakScript extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	int id = ModEvent.Create("MiniNeedsDoPissAndPoop")
	ModEvent.PushInt(id, 0)
	ModEvent.Send(id)
EndEvent
