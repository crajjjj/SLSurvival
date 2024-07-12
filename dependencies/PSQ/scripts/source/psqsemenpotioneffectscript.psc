Scriptname PSQSemenPotionEffectScript Extends ActivemagicEffect

PlayerSuccubusQuestScript Property PSQ Auto
Float Property Value Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If !akCaster.IsInCombat()
		If Value < 50
			Debug.SendanimationEvent(akCaster, "IdleDrinkPotion")
		Else
			Debug.SendanimationEvent(akCaster, "IdleDrink")
		EndIf
	EndIf
	
	If PSQ.EnableCumInflation && PSQ.CumInflationOral && PSQ.ManualDigestionMode
		StorageUtil.SetFloatValue(PSQ.PlayerRef, "PSQ_InternalSemen", StorageUtil.GetFloatValue(PSQ.PlayerRef, "PSQ_InternalSemen") + Value)
		PSQ.SetBellyScale()
	EndIf
	
	PSQ.SexLabCumOralShaderPSQ.Play(akCaster, 30)
	
	If akCaster == PSQ.PlayerRef
		If PSQ.PlayerIsSuccubus.GetValue() == 1
			Debug.Notification("$PSQ_DrinkSemenNotice")
			PSQ.Satiety(Value)
			PSQ.SatietyNotification(Value)
		Else
			Debug.Notification("$PSQ_DrinkSemenNotice")
			Debug.Notification("$PSQ_DisgustingNotice.")
		EndIf
	EndIf
EndEvent
