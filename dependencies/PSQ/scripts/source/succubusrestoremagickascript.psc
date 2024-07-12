Scriptname SuccubusRestoreMagickaScript Extends ActivemagicEffect

PlayerSuccubusQuestScript Property PSQ Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If akCaster == PSQ.PlayerRef
		Float RestoreValue = akCaster.GetActorValue("Magicka") / akCaster.GetActorValuePercentage("Magicka") - akCaster.GetActorValue("Magicka")
		If RestoreValue > 0 && PSQ.SuccubusEnergy.GetValue() > 0
			If RestoreValue >= PSQ.RestoreMagickaMAX
				RestoreValue = PSQ.RestoreMagickaMAX
			EndIf
			If RestoreValue >= PSQ.SuccubusEnergy.GetValue()
				RestoreValue = PSQ.SuccubusEnergy.GetValue()
				akCaster.RestoreActorValue("Magicka", RestoreValue)
				PSQ.Satiety(-PSQ.SuccubusEnergy.GetValue())
				PSQ.SatietyNotification(-PSQ.SuccubusEnergy.GetValue(), True)
			Else
				akCaster.RestoreActorValue("Magicka", RestoreValue)
				PSQ.Satiety(-RestoreValue)
				PSQ.SatietyNotification(-RestoreValue, True)
			EndIf
		EndIf
	EndIf
EndEvent
