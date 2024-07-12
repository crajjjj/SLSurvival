Scriptname mndDoFullBusinessScript extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	int id = ModEvent.Create("MiniNeedsDoPissAndPoop")
	ModEvent.PushInt(id, 2)
	ModEvent.Send(id)
EndEvent
