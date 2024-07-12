Scriptname _MA_RegressAfterMilk extends activemagiceffect  

_MA_Main Property Main Auto

MagicEffect Property _MA_FortifySpeed Auto

Actor Property PlayerRef Auto

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	Utility.Wait(2.0)
	If !PlayerRef.HasMagicEffect(_MA_FortifySpeed)	
		Main.SetAddictionEffects()
	EndIf
EndEvent