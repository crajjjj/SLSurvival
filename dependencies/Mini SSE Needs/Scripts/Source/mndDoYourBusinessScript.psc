Scriptname mndDoYourBusinessScript extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	int id = ModEvent.Create("MiniNeedsDoPissAndPoop")
	ModEvent.PushInt(id, 1)
	ModEvent.Send(id)
EndEvent