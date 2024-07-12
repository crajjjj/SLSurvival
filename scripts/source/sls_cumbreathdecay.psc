Scriptname SLS_CumBreathDecay extends activemagiceffect  

Spell Property _SLS_CumBreath01 Auto
Spell Property _SLS_CumBreath02 Auto
Spell Property _SLS_CumBreath03 Auto

MagicEffect Property _SLS_CumBreath01Mgef Auto
MagicEffect Property _SLS_CumBreath02Mgef Auto
MagicEffect Property _SLS_CumBreath03Mgef Auto

Actor Property PlayerRef Auto

SLS_Init Property Init Auto
SLS_Mcm Property Menu Auto

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	Utility.Wait(1.0)
	
	If !PlayerRef.HasMagicEffect(_SLS_CumBreath01Mgef) && !PlayerRef.HasMagicEffect(_SLS_CumBreath02Mgef) && !PlayerRef.HasMagicEffect(_SLS_CumBreath03Mgef)
		If Menu.CumBreathNotify
			Debug.Notification("Your breath smells less like sperm now")
		EndIf
		If Init.CumBreathLevel == 3
			_SLS_CumBreath02.Cast(PlayerRef, PlayerRef)
			Init.CumBreathLevel = 2
		ElseIf Init.CumBreathLevel == 2
			_SLS_CumBreath01.Cast(PlayerRef, PlayerRef)
			Init.CumBreathLevel = 1
		ElseIf Init.CumBreathLevel == 1
			Init.CumBreathLevel = 0
		EndIf
	EndIf
EndEvent