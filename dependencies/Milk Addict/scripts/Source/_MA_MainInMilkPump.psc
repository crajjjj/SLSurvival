Scriptname _MA_MainInMilkPump extends activemagiceffect  

_MA_Main Property Main Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Main.GoToState("InMilkPump")
EndEvent