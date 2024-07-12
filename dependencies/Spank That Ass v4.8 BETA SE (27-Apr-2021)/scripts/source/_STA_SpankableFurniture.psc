Scriptname _STA_SpankableFurniture extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	int SpankEvent = ModEvent.Create("STA_DoRandomNpcSpank")
	if (SpankEvent)
		ModEvent.PushFloat(SpankEvent, 8.0)
		ModEvent.PushBool(SpankEvent, true)
		ModEvent.PushFloat(SpankEvent, -1.0)
		ModEvent.Send(SpankEvent)
	endIf
EndEvent