Scriptname _SLS_InflateAss extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	(Game.GetFormFromFile(0x0CE982, "SL Survival.esp") as Quest).Start()
EndEvent
