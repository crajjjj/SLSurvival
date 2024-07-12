Scriptname _SLS_SteepFallWhirlwind extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	SteepFall.Whirlwind = JsonUtil.GetFloatValue("SL Survival/SteepFall.json", WhirlTier + "height")
	;Debug.Messagebox("Done the thing")
	Utility.Wait(JsonUtil.GetFloatValue("SL Survival/SteepFall.json", WhirlTier + "duration"))
	SteepFall.RecordHeight()
	SteepFall.Whirlwind = 0
	;Debug.Messagebox("UNDone the thing")
EndEvent

String Property WhirlTier Auto

_SLS_SteepFall Property SteepFall Auto
