Scriptname _MA_MountEventCooldown extends activemagiceffect  

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	Init.MountEventCooldown = false
EndEvent

_MA_Init Property Init Auto