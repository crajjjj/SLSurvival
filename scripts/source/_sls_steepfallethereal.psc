Scriptname _SLS_SteepFallEthereal extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	SteepFall.Ethereal = JsonUtil.GetFloatValue("SL Survival/SteepFall.json", "etherealallowance")
	;Debug.Messagebox("Done the thing")
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	Utility.Wait(0.5)
	SteepFall.Ethereal = 0
	SteepFall.RecordHeight()
	;Debug.Messagebox("UnDone the thing")
EndEvent

_SLS_SteepFall Property SteepFall Auto
