Scriptname _SLS_CumAddictionRemedy extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Float Mag = GetMagnitude()
	Float Decay = 1.0
	If Mag == 2.0
		Decay = 4.0
	EndIf
	_SLS_CumRemedyDecay.SetValue(Decay)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	_SLS_CumRemedyDecay.SetValue(0.0)
EndEvent

GlobalVariable Property _SLS_CumRemedyDecay Auto
