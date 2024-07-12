Scriptname _SLS_CombatEnd extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Util.SendCombatChangeEvent(False)
EndEvent

SLS_Utility Property Util Auto
