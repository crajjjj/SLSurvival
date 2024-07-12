Scriptname _SLS_CombatBegin extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Util.SendCombatChangeEvent(True)
EndEvent

SLS_Utility Property Util Auto
