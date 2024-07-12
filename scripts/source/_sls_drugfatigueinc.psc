Scriptname _SLS_DrugFatigueInc extends activemagiceffect  

Float FatigueStrength
Float FatigueAtBegin

Event OnEffectStart(Actor akTarget, Actor akCaster)
	FatigueStrength = Self.GetMagnitude()
	FatigueAtBegin = Needs.FatigueBeforeModding
	RegisterForSleep()
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	;Debug.Messagebox("Ended: Fatigue strenght: " + FatigueStrength)
	If Needs.GetState() == "Rnd"
		Float FatigueLoss
		If FatigueAtBegin > FatigueStrength
			FatigueLoss = FatigueStrength + (FatigueStrength * Menu.DrugEndFatigueInc)
		Else
			FatigueLoss = FatigueAtBegin + (FatigueStrength * Menu.DrugEndFatigueInc)
		EndIf
		;Debug.Messagebox("Increase fatigue by: " + FatigueLoss)
		Needs.ModFatigue(-Math.Ceiling(FatigueLoss))
	ElseIf Needs.GetState() == "Esd"
		Needs.ModFatigue(-Math.Ceiling(FatigueStrength))
	ElseIf Needs.GetState() == "Ineed"
		Needs.ModFatigue(-Math.Ceiling(FatigueStrength))
	EndIf
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
