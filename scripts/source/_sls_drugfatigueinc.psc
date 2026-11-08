Scriptname _SLS_DrugFatigueInc extends activemagiceffect  

Float FatigueStrength
Float FatigueAtBegin

Event OnEffectStart(Actor akTarget, Actor akCaster)
	FatigueStrength = Self.GetMagnitude()
	FatigueAtBegin = Needs.FatigueBeforeModding
	RegisterForSleep()
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	; The comedown: the fatigue the drug took away comes back, plus DrugEndFatigueInc of its strength.
	; Needs.ModFatigue adds fatigue for a positive amount. This passed a negative one until 0.806, so
	; the comedown was a second dose of rest, and SunHelm and Survival Mode had no comedown at all.
	String NeedsState = Needs.GetState()
	Float FatigueGain = FatigueStrength * Menu.DrugEndFatigueInc
	If NeedsState == "Rnd" || NeedsState == "Shs" || NeedsState == "Ccs"
		; Fatigue counts up from 0 here, so the drug only took what there was to take
		FatigueGain += PapyrusUtil.ClampFloat(FatigueAtBegin, 0.0, FatigueStrength)
	ElseIf NeedsState == "Esd" || NeedsState == "iNeed"
		; These count rest, not fatigue: no "before" figure to cap the refund with
		FatigueGain += FatigueStrength
	Else
		Return
	EndIf
	Needs.ModFatigue(Math.Ceiling(FatigueGain))
EndEvent

State InActive
	Event OnEffectFinish(Actor akTarget, Actor akCaster)
	EndEvent
EndState

Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
	;OnEffectFinish(None, None)
	GoToState("InActive")
	Self.Dispel()
EndEvent

_SLS_Needs Property Needs Auto
SLS_Mcm Property Menu Auto
