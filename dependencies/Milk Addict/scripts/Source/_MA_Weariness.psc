Scriptname _MA_Weariness extends activemagiceffect  

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	If !PlayerRef.HasMagicEffect(_MA_fortifyspeed)
		Main.TryAutoActionMilkEquip()
	EndIf
	Utility.Wait(1)
	If !PlayerRef.HasMagicEffect(_MA_fortifyspeed) ; Check if player has equipped another milk first
		if Menu.AfterEffectMagMult > 0.0
			_MA_WearySpell.SetNthEffectMagnitude(0, (Menu.AfterEffectMagMult * _MA_MilkStamina.GetNthEffectMagnitude(0)))
			_MA_WearySpell.SetNthEffectDuration(0,((Menu.AfterEffectDurMult * _MA_MilkStamina.GetNthEffectDuration(0)) as Int))
			_MA_WearySpell.Cast(PlayerRef, PlayerRef)
		EndIf
	EndIf

EndEvent

SPELL Property _MA_MilkStamina Auto  
SPELL Property _MA_WearySpell  Auto  

Actor Property PlayerRef  Auto  
MagicEffect Property _MA_fortifyspeed Auto

_MA_Mcm Property Menu Auto
_MA_Main Property Main Auto