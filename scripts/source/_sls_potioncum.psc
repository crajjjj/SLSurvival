Scriptname _SLS_PotionCum extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Util.QueueCumPotion(CumSource)
EndEvent

Actor Property CumSource Auto

SLS_Utility Property Util Auto
