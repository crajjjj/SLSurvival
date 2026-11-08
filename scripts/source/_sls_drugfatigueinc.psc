Scriptname _SLS_DrugFatigueInc extends activemagiceffect

; The drug comedown. sls_main adds each dose's debt to _SLS_Needs.DrugFatigueOwed when it is taken
; (OweDrugFatigue) and _SLS_Needs pays it when the last dose's effect is gone (DrugEffectEnded).

MagicEffect DrugEffect

Event OnEffectStart(Actor akTarget, Actor akCaster)
	DrugEffect = Self.GetBaseObject() ; read now: the effect is going away by OnEffectFinish
	RegisterForSleep()
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	Needs.DrugEffectEnded(DrugEffect)
EndEvent

State InActive
	Event OnEffectFinish(Actor akTarget, Actor akCaster)
	EndEvent
EndState

Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
	Needs.DrugFatigueOwed = 0.0 ; sleeping through it skips the comedown
	GoToState("InActive")
	Self.Dispel()
EndEvent

_SLS_Needs Property Needs Auto
SLS_Mcm Property Menu Auto ; CK-filled, unused since 0.806
