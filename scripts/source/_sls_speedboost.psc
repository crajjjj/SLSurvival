Scriptname _SLS_SpeedBoost extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	akTarget.ModAV("SpeedMult", 0.1)
	akTarget.ModAV("SpeedMult", -0.1)
EndEvent
