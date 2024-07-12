Scriptname SuccubusStatsMSGBoxScript Extends ActivemagicEffect

PlayerSuccubusQuestScript Property PSQ Auto
Message Property SuccubusStatsMSGBoxEnergy Auto
Message Property SuccubusStatsMSGBoxStats Auto
Message Property SuccubusStatsMSGBoxBuff Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If akCaster == PSQ.PlayerRef
		PSQ.Satiety()
		Menu()
	EndIf
EndEvent

Function Menu(Int Page = 0)
	If Page == 0
		Float Manpukudo = PSQ.SuccubusEnergy.GetValue() / PSQ.MaxEnergy
		Int i = SuccubusStatsMSGBoxEnergy.Show(PSQ.SuccubusEnergy.GetValue(), PSQ.MaxEnergy, Manpukudo * 100, PSQ.EnergyConsumption)
		If i == 0
			Menu(1)
		ElseIf i == 1
			Menu(2)
		ElseIf i == 2
		EndIf
	ElseIf Page == 1
		Float ExpToNextRank
		If PSQ.SuccubusRank.GetValue() == 1
			ExpToNextRank = 1000
		ElseIf PSQ.SuccubusRank.GetValue() == 2
			ExpToNextRank = 5000
		ElseIf PSQ.SuccubusRank.GetValue() == 3
			ExpToNextRank = 10000
		ElseIf PSQ.SuccubusRank.GetValue() == 4
			ExpToNextRank = 25000
		ElseIf PSQ.SuccubusRank.GetValue() == 5
			ExpToNextRank = 50000
		ElseIf PSQ.SuccubusRank.GetValue() == 6
			ExpToNextRank = 100000
		ElseIf PSQ.SuccubusRank.GetValue() == 7
			ExpToNextRank = 200000
		ElseIf PSQ.SuccubusRank.GetValue() == 8
			ExpToNextRank = 0
		EndIf
		Int i = SuccubusStatsMSGBoxStats.Show(PSQ.SuccubusRank.GetValue(), PSQ.SuccubusEXP.GetValue() * 100, ExpToNextRank)
		If i == 0
			Menu()
		ElseIf i == 1
			Menu(2)
		ElseIf i == 2
		EndIf
	ElseIf Page == 2
		Float Manpukudo = PSQ.SuccubusEnergy.GetValue() / PSQ.MaxEnergy
		Float HealthMod = PSQ.PlayerRef.GetBaseAV("Health") * (Manpukudo * PSQ.HealthBuffInc - PSQ.HealthBuffDec)
		Float MagickaMod = PSQ.PlayerRef.GetBaseAV("Magicka") * (Manpukudo * PSQ.MagickaBuffInc - PSQ.MagickaBuffDec)
		Float StaminaMod = PSQ.PlayerRef.GetBaseAV("Stamina") * (Manpukudo * PSQ.StaminaBuffInc - PSQ.StaminaBuffDec)
		Float HealthRateMod = Manpukudo * PSQ.HealthRateBuffInc - PSQ.HealthRateBuffDec
		Float MagickaRateMod = Manpukudo * PSQ.MagickaRateBuffInc - PSQ.MagickaRateBuffDec
		Float StaminaRateMod = Manpukudo * PSQ.StaminaRateBuffInc - PSQ.StaminaRateBuffDec
		Float SpeedMod = Manpukudo * PSQ.SpeedBuffInc - PSQ.SpeedBuffDec
		Int i = SuccubusStatsMSGBoxBuff.Show(HealthMod, MagickaMod, StaminaMod, HealthRateMod, MagickaRateMod, StaminaRateMod, SpeedMod)
		If i == 0
			Menu()
		ElseIf i == 1
			Menu(1)
		ElseIf i == 2
		EndIf
	EndIf
EndFunction
