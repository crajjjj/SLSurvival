Scriptname SLS_DrinkAlcohol extends activemagiceffect  

Spell Property _SLS_CumBreath01 Auto
Spell Property _SLS_CumBreath02 Auto
Spell Property _SLS_CumBreath03 Auto

Actor Property PlayerRef Auto

SLS_Init Property Init Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	debug.notification("Your breath smells less like sperm now")
	If Init.CumBreathLevel == 3
		_SLS_CumBreath02.Cast(PlayerRef, PlayerRef)
		Init.CumBreathLevel = 2
	ElseIf Init.CumBreathLevel == 2
		_SLS_CumBreath01.Cast(PlayerRef, PlayerRef)
		Init.CumBreathLevel = 1
	ElseIf Init.CumBreathLevel == 1
		Init.CumBreathLevel = 0
	EndIf
EndEvent