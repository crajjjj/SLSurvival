Scriptname SLS_CumBreath extends activemagiceffect  

MagicEffect Property _SLS_CumBreath01Mgef Auto
MagicEffect Property _SLS_CumBreath02Mgef Auto
MagicEffect Property _SLS_CumBreath03Mgef Auto

Spell Property _SLS_CumBreath01 Auto
Spell Property _SLS_CumBreath02 Auto
Spell Property _SLS_CumBreath03 Auto

Actor Property PlayerRef Auto

SLS_Init Property Init Auto
SLS_Utility Property Util Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Int Increase = 1
	If Util.LastLoadSize >= 15.0 ; LoadSize is +/- 25%
		Increase = 3
	ElseIf Util.LastLoadSize >= 4.0 ; LoadSize is +/- 25%
		Increase = 2
	EndIf
	
	Int CurrentLevel = 0
	If PlayerRef.HasMagicEffect(_SLS_CumBreath03Mgef)
		CurrentLevel = 3
	ElseIf PlayerRef.HasMagicEffect(_SLS_CumBreath02Mgef)
		CurrentLevel = 2
	ElseIf PlayerRef.HasMagicEffect(_SLS_CumBreath01Mgef)
		CurrentLevel = 1
	EndIf
	
	;Debug.Messagebox("CurrentLevel: " + CurrentLevel + ". Increase: " + Increase + ". LastLoadSize: " + Util.LastLoadSize)
	Int NewLevel = CurrentLevel + Increase
	If NewLevel > 3
		NewLevel = 3
	EndIf
	
	If NewLevel == 3
		_SLS_CumBreath02.Cast(PlayerRef, PlayerRef) ; Lazy way around 'dispel with keyword' not working for the same mgef...
		_SLS_CumBreath03.Cast(PlayerRef, PlayerRef) ; Reset timer
		Init.CumBreathLevel = 3
	ElseIf NewLevel == 2
		_SLS_CumBreath01.Cast(PlayerRef, PlayerRef) ; Lazy way around 'dispel with keyword' not working for the same mgef...
		_SLS_CumBreath02.Cast(PlayerRef, PlayerRef) ; Upgrade
		Init.CumBreathLevel = 2
	ElseIf NewLevel == 1
		_SLS_CumBreath02.Cast(PlayerRef, PlayerRef) ; Lazy way around 'dispel with keyword' not working for the same mgef...
		_SLS_CumBreath01.Cast(PlayerRef, PlayerRef)
		Init.CumBreathLevel = 1
	EndIf
EndEvent
