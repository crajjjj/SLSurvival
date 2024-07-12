Scriptname PlayerSuccubusMenu Extends SKI_ConfigBase

Import StorageUtil

PlayerSuccubusQuestScript Property PSQ Auto
SuccubusEnergyBarUpdate Property SEBU Auto
PSQSoulGemIncubateQuestScript Property SGI Auto

GlobalVariable Property PlayerIsSuccubus Auto
GlobalVariable Property SuccubusEnergy Auto
GlobalVariable Property SuccubusEXP Auto
GlobalVariable Property SuccubusRank Auto

Actor SuccubusNPC

Int Function GetVersion()
	Return 101
EndFunction

Event OnVersionUpdate(Int NewVersion)
EndEvent

Event OnConfigInit()
	;Pages = New String[12]
	Pages = New String[11]
	Pages[0] = "$PSQ_Page0"
	Pages[1] = "$PSQ_Page1"
	Pages[2] = "$PSQ_Page2"
	Pages[3] = "$PSQ_Page3"
	Pages[4] = "$PSQ_Page4"
	Pages[5] = "$PSQ_Page5"
	Pages[6] = "$PSQ_Page6"
	Pages[7] = "$PSQ_Page7"
	Pages[8] = "$PSQ_Page8"
	Pages[9] = "$PSQ_Page9"
	Pages[10] = "$PSQ_Page10"
	;Pages[11] = "$PSQ_Page11"
EndEvent

Event OnPageReset(String Page)
	If PSQ.SexLab.Config.TargetRef != None
		SuccubusNPC = PSQ.SexLab.Config.TargetRef
	EndIf
	
	If Page == "$PSQ_Page0"
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$PSQ_PlayerStatus")
		
		AddHeaderOption("$PSQ_PlayerSuccubusFlag")
		;サキュバスフラグの表示
		AddTextOptionST("PlayerIsSuccubus", "PlayerIsSuccubus = " + PlayerIsSuccubus.GetValueInt(), "")
		
		If PlayerIsSuccubus.GetValueInt() == 1
			;サキュバスレベルの表示
			AddHeaderOption("$PSQ_SuccubusRank")
			AddTextOptionST("SuccubusRank", GetTitle(), "")
			
			;経験値と次のレベルに必要な経験値
			AddHeaderOption("$PSQ_SuccubusEXP_Next")
			AddTextOptionST("SuccubusEXP", SuccubusEXP.GetValue() * 100 + " / " + GetNextExp(), "")
			
			;サキュバスエナジー
			AddHeaderOption("$PSQ_SuccubusEnergyCurrent_MAX")
			AddTextOptionST("SuccubusEnergy", SuccubusEnergy.GetValue() + " / " + PSQ.MaxEnergy, "")
			
			;消費エナジー
			AddHeaderOption("$PSQ_EnergyConsumptionPerDay")
			AddTextOptionST("EnergyConsumption", PSQ.EnergyConsumption, "")
			
			;貯まってる母乳
			AddHeaderOption("$PSQ_MilkTotal")
			AddTextOptionST("MilkTotal", GetFloatValue(PSQ.PlayerRef, "PRG_MilkTotal"), "")
		EndIf
	EndIf
	
	If Page == "$PSQ_Page1"
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$PSQ_DrainSettings")
		AddToggleOptionST("EnableDrain", "$PSQ_EnableDrain", PSQ.EnableDrain)
		AddToggleOptionST("AllowDrainFromFemale", "$PSQ_AllowDrainFromFemale", PSQ.AllowDrainFromFemale)
		AddToggleOptionST("AllowDrainFromBeast", "$PSQ_AllowDrainFromBeast", PSQ.AllowDrainFromBeast)
		AddToggleOptionST("AllowDrainFromUndead", "$PSQ_AllowDrainFromUndead", PSQ.AllowDrainFromUndead)
		
		AddToggleOptionST("ExtractSemenPotion", "$PSQ_ExtractSemenPotion", PSQ.ExtractSemenPotion)
		AddToggleOptionST("AutoExtractSemenPotion", "$PSQ_AutoExtractSemenPotion", PSQ.AutoExtractSemenPotion)
		AddSliderOptionST("AutoExtractSemenPotionThreshold","$PSQ_AutoExtractSemenPotionThreshold", PSQ.AutoExtractSemenPotionThreshold, "{0}%")
		
		AddToggleOptionST("FastMode", "$PSQ_FastMode", PSQ.FastMode)
		AddSliderOptionST("FastModeTime","$PSQ_FastModeTime", PSQ.FastModeTime, "{0}")
		
		AddEmptyOption()
		AddHeaderOption("$PSQ_NPCEnergySettings")
		AddSliderOptionST("CalcMaxEnergyHealth","$PSQ_CalcMaxEnergyHealth", PSQ.CalcMaxEnergyHealth, "{1}")
		AddToggleOptionST("AdjustMinEnergyOfHuman", "$PSQ_AdjustMinEnergyOfHuman", PSQ.AdjustMinEnergyOfHuman)
		AddSliderOptionST("MinEnergyOfHuman","$PSQ_MinEnergyOfHuman", PSQ.MinEnergyOfHuman, "{0}")
		AddSliderOptionST("LoversRestoreMult","$PSQ_LoversRestoreMult", PSQ.LoversRestoreMult, "{1}")
		
		SetCursorPosition(3)
		AddToggleOptionST("AllowKill", "$PSQ_AllowKill", PSQ.AllowKill)
		AddMenuOptionST("ConditionToKill", "$PSQ_DeathCondition", GetConditionalString(PSQ.ConditionToKill))
		
		AddToggleOptionST("EnableSoulTrap", "$PSQ_EnableSoulTrap", PSQ.EnableSoulTrap)
		AddMenuOptionST("ConditionToSoulTrap", "$PSQ_SoulTrapCondition", GetConditionalString(PSQ.ConditionToSoulTrap))
		AddToggleOptionST("EnableCaptive", "$PSQ_EnableCaptive", PSQ.EnableCaptive)
		AddToggleOptionST("UseArousalAtDrain", "$PSQ_UseArousalAtDrain", PSQ.UseArousalAtDrain)
		AddSliderOptionST("DrainValueMultipliers","$PSQ_DrainValueMultipliers", PSQ.DrainValueMultipliers, "{2}")
		AddSliderOptionST("EXPGainedMultipliers","$PSQ_EXPGainedMultipliers", PSQ.EXPGainedMultipliers, "{2}")
		
		AddEmptyOption()
		AddHeaderOption("$PSQ_FeedSettings")
		AddToggleOptionST("AllowSneakFeed", "$PSQ_AllowSneakFeed", PSQ.AllowSneakFeed.GetValueInt())
		AddToggleOptionST("AllowSleepFeed", "$PSQ_AllowSleepFeed", PSQ.AllowSleepFeed.GetValueInt())
		AddToggleOptionST("AllowForceFeed", "$PSQ_AllowForceFeed", PSQ.AllowForceFeed.GetValueInt())
		AddToggleOptionST("AllowTeamMateFeed", "$PSQ_AllowTeamMateFeed", PSQ.AllowTeamMateFeed.GetValueInt())
	EndIf
	
	If Page == "$PSQ_Page2"
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$PSQ_SatiationSettings")
		AddToggleOptionST("EnableSatiationEffect", "$PSQ_EnableSatiationEffect", PSQ.EnableSatiationEffect)
		AddToggleOptionST("EnableSatiationNotification", "$PSQ_EnableNotification", PSQ.EnableSatiationNotification)
		AddSliderOptionST("EnergyConsumptionPerMax", "$PSQ_ConsumptionRate", PSQ.EnergyConsumptionPerMax, "{0} %")
		
		AddEmptyOption()
		AddHeaderOption("$PSQ_SatiationEffectSettings")
		AddSliderOptionST("HealthBuffInc", "$PSQ_HealthBuffInc", (PSQ.HealthBuffInc - PSQ.HealthBuffDec) * 100, "{0} %")
		AddSliderOptionST("HealthBuffDec", "$PSQ_HealthBuffDec", -PSQ.HealthBuffDec * 100, "{0} %")
		AddSliderOptionST("MagickaBuffInc", "$PSQ_MagickaBuffInc", (PSQ.MagickaBuffInc - PSQ.MagickaBuffDec) * 100, "{0} %")
		AddSliderOptionST("MagickaBuffDec", "$PSQ_MagickaBuffDec", -PSQ.MagickaBuffDec * 100, "{0} %")
		AddSliderOptionST("StaminaBuffInc", "$PSQ_StaminaBuffInc", (PSQ.StaminaBuffInc - PSQ.StaminaBuffDec) * 100, "{0} %")
		AddSliderOptionST("StaminaBuffDec", "$PSQ_StaminaBuffDec", -PSQ.StaminaBuffDec * 100, "{0} %")
		AddSliderOptionST("SpeedBuffInc", "$PSQ_SpeedBuffInc", (PSQ.SpeedBuffInc - PSQ.SpeedBuffDec), "{0} %")
		AddSliderOptionST("SpeedBuffDec", "$PSQ_SpeedBuffDec", -PSQ.SpeedBuffDec, "{0} %")
		
		SetCursorPosition(3)
		AddToggleOptionST("EnableStarvation", "$PSQ_EnableStarvationDeath", PSQ.EnableStarvation)
		AddToggleOptionST("EnergyModeAlt", "$PSQ_EnergyModeAlt", PSQ.EnergyModeAlt)
		AddSliderOptionST("MaxEnergyAtAltMode", "$PSQ_MaxEnergyAtAltMode", PSQ.MaxEnergyAtAltMode, "{0}")
		
		AddEmptyOption()
		AddTextOptionST("SatiationBuffs", "$PSQ_SatiationBuffs", "")
		AddSliderOptionST("HealthRateBuffInc", "$PSQ_HealthRateBuffInc", (PSQ.HealthRateBuffInc - PSQ.HealthRateBuffDec), "{0} %")
		AddSliderOptionST("HealthRateBuffDec", "$PSQ_HealthRateBuffDec", -PSQ.HealthRateBuffDec, "{0} %")
		AddSliderOptionST("MagickaRateBuffInc", "$PSQ_MagickaRateBuffInc", (PSQ.MagickaRateBuffInc - PSQ.MagickaRateBuffDec), "{0} %")
		AddSliderOptionST("MagickaRateBuffDec", "$PSQ_MagickaRateBuffDec", -PSQ.MagickaRateBuffDec, "{0} %")
		AddSliderOptionST("StaminaRateBuffInc", "$PSQ_StaminaRateBuffInc", (PSQ.StaminaRateBuffInc - PSQ.StaminaRateBuffDec), "{0} %")
		AddSliderOptionST("StaminaRateBuffDec", "$PSQ_StaminaRateBuffDec", -PSQ.StaminaRateBuffDec, "{0} %")
	EndIf
	
	If Page == "$PSQ_Page3"
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$PSQ_SchlongSettings")
		AddMenuOptionST("PlayerHumanSchlong", "$PSQ_PlayerHumanSchlong", PSQ.PlayerHumanSchlong.GetName())
		AddMenuOptionST("PlayerSuccubusSchlong", "$PSQ_PlayerSuccubusSchlong", PSQ.PlayerSuccubusSchlong.GetName())
		AddToggleOptionST("AutoGenderSwitch", "$PSQ_AutoGenderSwitch", PSQ.AutoGenderSwitch)
		AddToggleOptionST("EnableFutanariPower", "$PSQ_EnableFutanariPower", PSQ.EnableFutanariPower)
		AddKeyMapOptionST("HotkeyCreatePenisSelf","$PSQ_HotkeyCreatePenisSelf", PSQ.HotkeyCreatePenisSelf)
		
		AddEmptyOption()
		AddHeaderOption("$PSQ_PSQSuccubusEye")
		AddSliderOptionST("SuccubusNightEyeStrength", "$PSQ_SuccubusNightEyeStrength", PSQ.SuccubusNightEyeStrength, "{2}")
		AddKeyMapOptionST("HotkeyDetectArousal","$PSQ_HotkeyDetectArousal", PSQ.HotkeyDetectArousal)
		AddKeyMapOptionST("HotkeyNightEye","$PSQ_HotkeyNightEye", PSQ.HotkeyNightEye)
		
		AddEmptyOption()
		AddHeaderOption("$PSQ_PSQRape")
		AddToggleOptionST("EnablePSQRape", "$PSQ_EnablePSQRape", PSQ.EnablePSQRape)
		AddSliderOptionST("RapeHealthThreshold", "$PSQ_RapeHealthThreshold", PSQ.RapeHealthThreshold, "{0} %")
		AddSliderOptionST("RapeArousalThreshold", "$PSQ_RapeArousalThreshold", PSQ.RapeArousalThreshold, "{0} %")
		AddSliderOptionST("RapeChance", "$PSQ_RapeChance", PSQ.RapeChance, "{0} %")
		
		AddEmptyOption()
		AddHeaderOption("$PSQ_PSQFlying")
		AddToggleOptionST("EnableAutoAddFlying", "$PSQ_EnableAutoAddFlying", PSQ.EnableAutoAddFlying)
		AddSliderOptionST("CanFlyingLevel", "$PSQ_CanFlyingLevel", PSQ.CanFlyingLevel, "{0}")
		AddKeyMapOptionST("HotkeyToggleFlying","$PSQ_HotkeyToggleFlying", PSQ.HotkeyToggleFlying)
		
		AddEmptyOption()
		AddHeaderOption("$PSQ_Lure")
		AddToggleOptionST("PSQ_LureEffectOnFemale", "$PSQ_LureEffectOnFemale", GetIntValue(PSQ.PlayerRef, "PSQ_LureEffectOnFemale") == 0)
		AddToggleOptionST("PSQ_LureEffectOnMale", "$PSQ_LureEffectOnMale", GetIntValue(PSQ.PlayerRef, "PSQ_LureEffectOnMale") == 0)
		AddToggleOptionST("PSQ_LureEffectOnBeast", "$PSQ_LureEffectOnBeast", GetIntValue(PSQ.PlayerRef, "PSQ_LureEffectOnBeast") == 0)
		AddToggleOptionST("PSQ_LureEffectOnUndead", "$PSQ_LureEffectOnUndead", GetIntValue(PSQ.PlayerRef, "PSQ_LureEffectOnUndead") == 1)
		
		AddEmptyOption()
		AddHeaderOption("$PSQ_OtherSettings")
		AddToggleOptionST("EnableCumInflation", "$PSQ_EnableCumInflation", PSQ.EnableCumInflation)
		AddToggleOptionST("AllowCumInflationAnal", "$PSQ_AllowCumInflationAnal", PSQ.CumInflationAnal)
		AddToggleOptionST("AllowCumInflationOral", "$PSQ_AllowCumInflationOral", PSQ.CumInflationOral)
		AddToggleOptionST("ManualDigestionMode", "$PSQ_ManualDigestionMode", PSQ.ManualDigestionMode)
		AddKeyMapOptionST("HotkeyDigestion","$PSQ_HotkeyDigestion", PSQ.HotkeyDigestion)
		AddToggleOptionST("EnableBodyslideMorph", "$PSQ_EnableBodyslideMorph", PSQ.EnableBodyslideMorph)
		AddSliderOptionST("CumInflationIncrement", "$PSQ_CumInflationIncrement", PSQ.CumInflationIncrement, "{0}")
		AddToggleOptionST("FluidNeedArousal", "$PSQ_FluidNeedArousal", PSQ.FluidNeedArousal)
		AddSliderOptionST("RequiredToFluid", "$PSQ_RequiredToFluid", PSQ.RequiredToFluid, "{0}")
		AddToggleOptionST("AllowHybrid", "$PSQ_AllowHybrid", PSQ.AllowHybrid)
		
		SetCursorPosition(1)
		AddHeaderOption("$PSQ_TattooSettings")
		AddToggleOptionST("HenshinTattoo", "$PSQ_HenshinTattoo", PSQ.HenshinTattoo)
		AddToggleOptionST("EnableBodyPaintTintChangeSatiation", "$PSQ_EnableBodyPaintTintChangeSatiation", PSQ.EnableBodyPaintTintChangeSatiation)
		AddToggleOptionST("EnableBodyPaintAlphaChangeSatiation", "$PSQ_EnableBodyPaintAlphaChangeSatiation", PSQ.EnableBodyPaintAlphaChangeSatiation)
		AddToggleOptionST("EnableBodyPaintGlowTintChangeSatiation", "$PSQ_EnableBodyPaintGlowTintChangeSatiation", PSQ.EnableBodyPaintGlowTintChangeSatiation)
		AddToggleOptionST("EnableBodyPaintGlowAlphaChangeSatiation", "$PSQ_EnableBodyPaintGlowAlphaChangeSatiation", PSQ.EnableBodyPaintGlowAlphaChangeSatiation)
		AddTextOptionST("GetCurrentColorAsMax", "", "$PSQ_GetCurrentColorAsMax")
		AddTextOptionST("GetCurrentColorAsMin", "", "$PSQ_GetCurrentColorAsMin")
		AddHeaderOption("$PSQ_NPCTattooSettings")
		AddToggleOptionST("EnableCursePaintGradient", "$PSQ_EnableCursePaintGradient", PSQ.EnableCursePaintGradient)
		AddToggleOptionST("EnableCursePaintTint", "$PSQ_EnableCursePaintTint", PSQ.EnableCursePaintTint)
		AddToggleOptionST("EnableCursePaintAlpha", "$PSQ_EnableCursePaintAlpha", PSQ.EnableCursePaintAlpha)
		AddToggleOptionST("EnableCursePaintGlowTint", "$PSQ_EnableCursePaintGlowTint", PSQ.EnableCursePaintGlowTint)
		AddToggleOptionST("EnableCursePaintGlowAlpha", "$PSQ_EnableCursePaintGlowAlpha", PSQ.EnableCursePaintGlowAlpha)
		
		AddEmptyOption()
		AddHeaderOption("$PSQ_Milking")
		AddToggleOptionST("StopAddMilk", "$PSQ_StopAddMilk", PSQ.StopAddMilk)
		AddToggleOptionST("EnableBreastGrowthByMilk", "$PSQ_EnableBreastGrowthByMilk", PSQ.EnableBreastGrowthByMilk)
		
		AddEmptyOption()
		AddHeaderOption("$PSQ_Familiar")
		AddToggleOptionST("ChargeFull", "$PSQ_ChargeFull", PSQ.ChargeFull)
		AddSliderOptionST("ChargeValueAuto", "$PSQ_ChargeValueAuto", PSQ.ChargeValueAuto, "{0}")
		
		AddEmptyOption()
		AddHeaderOption("$PSQ_EnergyBarHeader")
		AddKeyMapOptionST("HotkeyEnergyBar","$PSQ_HotkeyEnergyBar", PSQ.HotkeyEnergyBar)
		AddToggleOptionST("EnegyBarVisible", "$PSQ_EnegyBarVisible", SEBU.EnegyBarVisible)
		AddTextOptionST("EnergyBarFillDirection", "$PSQ_EnergyBarFillDirection", SEBU.EnergyBarFillDirection)
		AddSliderOptionST("EnergyBarX", "$PSQ_EnergyBarX", SEBU.EnergyBarX, "{0}")
		AddSliderOptionST("EnergyBarY", "$PSQ_EnergyBarY", SEBU.EnergyBarY, "{0}")
		AddSliderOptionST("ColorChangeThreshould01", "$PSQ_ColorChangeThreshould01", SEBU.ColorChangeThreshould01 * 100, "{0} %")
		AddSliderOptionST("ColorChangeThreshould02", "$PSQ_ColorChangeThreshould02", SEBU.ColorChangeThreshould02 * 100, "{0} %")
		AddSliderOptionST("ColorChangeThreshould03", "$PSQ_ColorChangeThreshould03", SEBU.ColorChangeThreshould03 * 100, "{0} %")
		AddColorOptionST("EnergyBarColor1A", "$PSQ_EnergyBarColor1A", SEBU.EnergyBarColor1A)
		AddColorOptionST("EnergyBarColor1B", "$PSQ_EnergyBarColor1B", SEBU.EnergyBarColor1B)
		AddColorOptionST("EnergyBarColor2A", "$PSQ_EnergyBarColor2A", SEBU.EnergyBarColor2A)
		AddColorOptionST("EnergyBarColor2B", "$PSQ_EnergyBarColor2B", SEBU.EnergyBarColor2B)
		AddColorOptionST("EnergyBarColor3A", "$PSQ_EnergyBarColor3A", SEBU.EnergyBarColor3A)
		AddColorOptionST("EnergyBarColor3B", "$PSQ_EnergyBarColor3B", SEBU.EnergyBarColor3B)
		AddColorOptionST("EnergyBarColor4A", "$PSQ_EnergyBarColor4A", SEBU.EnergyBarColor4A)
		AddColorOptionST("EnergyBarColor4B", "$PSQ_EnergyBarColor4B", SEBU.EnergyBarColor4B)
	EndIf
	
	If Page == "$PSQ_Page4"
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$PSQ_Hotkeys")
		AddKeyMapOptionST("HotkeyEnableDrain","$PSQ_HotkeyEnableDrain", PSQ.HotkeyEnableDrain)
		AddKeyMapOptionST("HotkeyAllowKill","$PSQ_HotkeyAllowKill", PSQ.HotkeyAllowKill)
		AddKeyMapOptionST("HotkeyExtractSemenPotion","$PSQ_HotkeyExtractSemenPotion", PSQ.HotkeyExtractSemenPotion)
		AddKeyMapOptionST("HotkeyEnableSoulTrap","$PSQ_HotkeyEnableSoulTrap", PSQ.HotkeyEnableSoulTrap)
		AddKeyMapOptionST("HotkeySuccubusStats","$PSQ_HotkeySuccubusStats", PSQ.HotkeySuccubusStats)
		AddKeyMapOptionST("HotkeyHenshin","$PSQ_HotkeyHenshin", PSQ.HotkeyHenshin)
		AddKeyMapOptionST("HotkeySuccubusCharmSpell","$PSQ_HotkeySuccubusCharmSpell", PSQ.HotkeySuccubusCharmSpell)
		AddKeyMapOptionST("HotkeyMasturbation","$PSQ_HotkeyMasturbation", PSQ.HotkeyMasturbation)
		AddKeyMapOptionST("HotkeyCreatePenisSelf","$PSQ_HotkeyCreatePenisSelf", PSQ.HotkeyCreatePenisSelf)
		AddKeyMapOptionST("HotkeyToggleFlying","$PSQ_HotkeyToggleFlying", PSQ.HotkeyToggleFlying)
		AddKeyMapOptionST("HotkeyRestoreMagicka","$PSQ_HotkeyRestoreMagicka", PSQ.HotkeyRestoreMagicka)
		AddKeyMapOptionST("HotkeyDigestion","$PSQ_HotkeyDigestion", PSQ.HotkeyDigestion)
		
		SetCursorPosition(1)
		AddTextOptionST("HotkeyDLTInfo", "$PSQ_HotkeyDLTInfo", "")
		AddKeyMapOptionST("HotkeyEnergyBar","$PSQ_HotkeyEnergyBar", PSQ.HotkeyEnergyBar)
		AddKeyMapOptionST("HotkeyNightEye","$PSQ_HotkeyNightEye", PSQ.HotkeyNightEye)
		AddKeyMapOptionST("HotkeyDetectArousal","$PSQ_HotkeyDetectArousal", PSQ.HotkeyDetectArousal)
		AddKeyMapOptionST("HotkeyIncreaseNode","$PSQ_HotkeyIncreaseNode", PSQ.HotkeyIncreaseNode)
		AddKeyMapOptionST("HotkeyDecreaseNode","$PSQ_HotkeyDecreaseNode", PSQ.HotkeyDecreaseNode)
		AddKeyMapOptionST("HotkeyHeight","$PSQ_HotkeyHeight", PSQ.HotkeyHeight)
		AddKeyMapOptionST("HotkeyBreastNode","$PSQ_HotkeyBreastNode", PSQ.HotkeyBreastNode)
		AddKeyMapOptionST("HotkeyButtNode","$PSQ_HotkeyButtNode", PSQ.HotkeyButtNode)
		AddKeyMapOptionST("HotkeyGenitalsNode","$PSQ_HotkeyGenitalsNode", PSQ.HotkeyGenitalsNode)
		AddKeyMapOptionST("HotkeyScrotumNode","$PSQ_HotkeyScrotumNode", PSQ.HotkeyScrotumNode)
	EndIf
	
	If Page == "$PSQ_Page5"
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddTextOptionST("HenshinCaution", "$PSQ_HenshinCaution", "")
		AddToggleOptionST("HenshinBody", "$PSQ_EnableHenshinBody", PSQ.HenshinBody)
		AddToggleOptionST("HenshinSkin", "$PSQ_EnableHenshinSkin", PSQ.HenshinSkin)
		AddColorOptionST("PSQSkinColor", "$PSQ_HenshinSkinColor", PSQ.PSQSkinColor)
		AddSliderOptionST("HenshinSkinColorfulness", "$PSQ_HenshinSkinAlpha", PSQ.PSQSkinColorAlpha, "{0}")
		AddTextOptionST("SetSkinColor", "", "$PSQ_SetSkinColor")
		AddToggleOptionST("HenshinEyes", "$PSQ_EnableHenshinEyes", PSQ.HenshinEyes)
		AddToggleOptionST("HenshinWings", "$PSQ_EnableHenshinWings", PSQ.HenshinWings)
		AddMenuOptionST("SwitchWings", "$PSQ_SwitchWings", PSQ.PSQSuccubusWings.GetName())
		AddToggleOptionST("HenshinHorn", "$PSQ_EnableHenshinHorn", PSQ.HenshinHorn)
		AddToggleOptionST("HenshinTail", "$PSQ_EnableHenshinTail", PSQ.HenshinTail)
		AddToggleOptionST("HenshinCuirass", "$PSQ_EnableHenshinCuirass", PSQ.HenshinCuirass)
		AddToggleOptionST("HenshinBoots", "$PSQ_EnableHenshinBoots", PSQ.HenshinBoots)
		AddToggleOptionST("HenshinGloves", "$PSQ_EnableHenshinGloves", PSQ.HenshinGloves)
		AddToggleOptionST("HenshinPenis", "$PSQ_EnableHenshinPenis", PSQ.HenshinPenis)
		AddToggleOptionST("HenshinHair", "$PSQ_EnableHenshinHair", PSQ.HenshinHair)
		AddToggleOptionST("HenshinHairColor", "$PSQ_EnableHenshinHairColor", PSQ.HenshinHairColor)
		AddColorOptionST("PSQSuccubusHairColorInt", "$PSQ_HairColor", PSQ.PSQSuccubusHairColorInt)
		AddTextOptionST("SetHairColor", "", "$PSQ_SetHairColor")
		
		SetCursorPosition(3)
		AddToggleOptionST("EnableSuccubusSpellBooster", "$PSQ_EnableSuccubusSpellBooster", PSQ.EnableSuccubusSpellBooster)
		AddToggleOptionST("CanWalkOnTheWater", "$PSQ_CanWalkOnTheWater", PSQ.CanWalkOnTheWater)
		AddToggleOptionST("HenshinIsCrime", "$PSQ_HenshinIsCrime", PSQ.HenshinIsCrime)
		AddToggleOptionST("HenshinFear", "$PSQ_HenshinFear", PSQ.HenshinFear)
		AddToggleOptionST("HenshinBuff", "$PSQ_HenshinBuff", PSQ.HenshinBuff)
		AddSliderOptionST("HenshinBuffRateHealth", "$PSQ_HenshinBuffRateHealth", PSQ.HenshinBuffRateHealth, "{0} %")
		AddSliderOptionST("HenshinBuffRateMagicka", "$PSQ_HenshinBuffRateMagicka", PSQ.HenshinBuffRateMagicka, "{0} %")
		AddSliderOptionST("HenshinBuffRateStamina", "$PSQ_HenshinBuffRateStamina", PSQ.HenshinBuffRateStamina, "{0} %")
		AddSliderOptionST("HenshinBuffRateCarry", "$PSQ_HenshinBuffRateCarry", PSQ.HenshinBuffRateCarry, "{0} %")
		AddToggleOptionST("HenshinArmorRate", "$PSQ_HenshinArmorRate", PSQ.HenshinArmorRate)
		AddSliderOptionST("SuccubusArmorMagnitude", "$PSQ_SuccubusArmorMagnitude", PSQ.SuccubusArmorMagnitude, "{0}")
		
		AddEmptyOption()
		AddToggleOptionST("ArousedForceTransform", "$PSQ_ArousedForceTransform", PSQ.ArousedForceTransform)
		AddSliderOptionST("TransformThreshold", "$PSQ_TransformThreshold", PSQ.TransformThreshold, "{0}")
		AddToggleOptionST("ArousedForceDeTransform", "$PSQ_ArousedForceDeTransform", PSQ.ArousedForceDeTransform)
		AddSliderOptionST("DeTransformThreshold", "$PSQ_DeTransformThreshold", PSQ.DeTransformThreshold, "{0}")
	EndIf
	
	If Page == "$PSQ_Page6"
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$PSQ_BodyShapeChange")
		AddToggleOptionST("EnableHeightChangeSuccubus", "$PSQ_EnableHeightChangeSuccubus", PSQ.EnableHeightChangeSuccubus)
		AddSliderOptionST("SuccubusHeight", "$PSQ_SuccubusHeight", PSQ.SuccubusHeight, "{2}")
		AddToggleOptionST("EnableBreastChangeSuccubus", "$PSQ_EnableBreastChangeSuccubus", PSQ.EnableBreastChangeSuccubus)
		AddSliderOptionST("SuccubusBreast", "$PSQ_SuccubusBreast", PSQ.SuccubusBreast, "{2}")
		AddSliderOptionST("BreastScaleMax", "$PSQ_BreastScaleMax", PSQ.BreastScaleMax, "{2}")
		AddToggleOptionST("EnableButtChangeSuccubus", "$PSQ_EnableButtChangeSuccubus", PSQ.EnableButtChangeSuccubus)
		AddSliderOptionST("SuccubusButt", "$PSQ_SuccubusButt", PSQ.SuccubusButt, "{2}")
		
		SetCursorPosition(3)
		AddToggleOptionST("EnableGenitalsChangeSuccubus", "$EnableGenitalsChangeSuccubus", PSQ.EnableGenitalsChangeSuccubus)
		AddSliderOptionST("SuccubusGenitals", "$PSQ_SuccubusGenitals", PSQ.SuccubusGenitals, "{2}")
		AddToggleOptionST("EnableScrotumChangeSuccubus", "$PSQ_EnableScrotumChangeSuccubus", PSQ.EnableScrotumChangeSuccubus)
		AddSliderOptionST("SuccubusScrotum", "$PSQ_SuccubusScrotum", PSQ.SuccubusScrotum, "{2}")
	EndIf
	If Page == "$PSQ_Page7"
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$PSQ_PregnancyHeader")
		AddToggleOptionST("EnableSoulGemPregnancy", "$PSQ_EnableSoulGemPregnancy", PSQ.EnableSoulGemPregnancy)
		AddToggleOptionST("AllowAnalPregnancy", "$PSQ_AllowAnalFertilisation", PSQ.AllowAnalPregnancy)
		AddSliderOptionST("FertilisationProbability", "$PSQ_FertilisationProbability", PSQ.FertilisationProbability, "{0} %")
		AddSliderOptionST("SpeedDecreaseMax", "$PSQ_SpeedDecreaseMax", SGI.SpeedDecreaseMax, "{0} %")
		AddToggleOptionST("EnableBellyGrowthByPregnancy", "$PSQ_EnableBellyGrowthByPregnancy", PSQ.EnableBellyGrowthByPregnancy)
		AddSliderOptionST("BellyScaleMax", "$PSQ_BellyScaleMax", PSQ.BellyScaleMax, "{2}")
		AddToggleOptionST("EnableBodyslideMorph", "$PSQ_EnableBodyslideMorph", PSQ.EnableBodyslideMorph)
		
		SetCursorPosition(3)
		AddTextOptionST("SeedsNum", "$PSQ_SeedsNum", GetIntValue(PSQ.PlayerRef, "PRG_SeedsNum"))
		AddTextOptionST("SeedsTotal", "$PSQ_SeedsTotal", GetFloatValue(PSQ.PlayerRef, "PRG_SeedsTotal") as Int)
		AddEmptyOption()
		AddTextOptionST("ClearPregnancy", "", "$PSQ_ClearPregnancy")
	EndIf
	If Page == "$PSQ_Page8"
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddTextOptionST("SpellSwichNotice", "$PSQ_SpellSwichNotice", "")
		AddToggleOptionST("EnableSuccubusDrainHealthSpell", "$PSQ_EnableSuccubusDrainHealthSpell", PSQ.EnableSuccubusDrainHealthSpell)
		AddToggleOptionST("EnableSuccubusDrainStaminaSpell", "$PSQ_EnableSuccubusDrainStaminaSpell", PSQ.EnableSuccubusDrainStaminaSpell)
		AddToggleOptionST("EnableSuccubusDrainFF", "$PSQ_EnableSuccubusDrainFF", PSQ.EnableSuccubusDrainFF)
		
		AddToggleOptionST("CreatePenisSpellSelf", PSQ.CreatePenisSpellSelf.GetName(), PSQ.PlayerRef.HasSpell(PSQ.CreatePenisSpellSelf))
		AddToggleOptionST("CreatePenisSpellOther", PSQ.CreatePenisSpellOther.GetName(), PSQ.PlayerRef.HasSpell(PSQ.CreatePenisSpellOther))
		AddToggleOptionST("SuccubusCurseSpell", PSQ.SuccubusCurseSpell.GetName(), PSQ.PlayerRef.HasSpell(PSQ.SuccubusCurseSpell))
		AddToggleOptionST("StarkRealitySpell", PSQ.StarkRealitySpell.GetName(), PSQ.PlayerRef.HasSpell(PSQ.StarkRealitySpell))
		AddToggleOptionST("SuccuKanashibari", PSQ.SuccuKanashibari.GetName(), PSQ.PlayerRef.HasSpell(PSQ.SuccuKanashibari))
		
		SetCursorPosition(3)
		AddToggleOptionST("SuccubusRaiseArousalSpell", PSQ.SuccubusRaiseArousalSpell.GetName(), PSQ.PlayerRef.HasSpell(PSQ.SuccubusRaiseArousalSpell))
		AddToggleOptionST("SuccubusArousalCloakSpell", PSQ.SuccubusArousalCloakSpell.GetName(), PSQ.PlayerRef.HasSpell(PSQ.SuccubusArousalCloakSpell))
		AddToggleOptionST("FortifyMSGBoxSpell", PSQ.FortifyMSGBoxSpell.GetName(), PSQ.PlayerRef.HasSpell(PSQ.FortifyMSGBoxSpell))
		AddToggleOptionST("SuccubusSpellLearningMSGBoxSpell", PSQ.SuccubusSpellLearningMSGBoxSpell.GetName(), PSQ.PlayerRef.HasSpell(PSQ.SuccubusSpellLearningMSGBoxSpell))
		AddToggleOptionST("SuccubusSummonMerchantSpell", PSQ.SuccubusSummonMerchantSpell.GetName(), PSQ.PlayerRef.HasSpell(PSQ.SuccubusSummonMerchantSpell))
		AddToggleOptionST("RestoreMagickaSpell", PSQ.RestoreMagickaSpell.GetName(), PSQ.PlayerRef.HasSpell(PSQ.RestoreMagickaSpell))
		AddToggleOptionST("MasturbationSpell", PSQ.MasturbationSpell.GetName(), PSQ.PlayerRef.HasSpell(PSQ.MasturbationSpell))
	EndIf
	
	If Page == "$PSQ_Page9"
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$PSQ_ContinuousAbilitySettings")
		AddToggleOptionST("EnableEnergyConsumingBySuccubusSpell", "$PSQ_EnableEnergyConsumingBySuccubusSpell", PSQ.EnableEnergyConsumingBySuccubusSpell)
		AddToggleOptionST("EnableSpellCastingNotification", "$PSQ_EnableSpellCastingNotification", PSQ.EnableSpellCastingNotification)
		AddToggleOptionST("FortifyMagickaSpell", PSQ.FortifyMagickaSpell.GetName(), PSQ.PlayerRef.HasSpell(PSQ.FortifyMagickaSpell))
		AddToggleOptionST("EnableFortifyDestruction", "$PSQ_EnableFortifyDestruction", PSQ.EnableFortifyDestruction)
		AddSliderOptionST("FortifyDestructionMult", "$PSQ_FortifyDestructionMult", PSQ.FortifyDestructionMult * 100, "{0} %")
		AddToggleOptionST("EnableFortifyIllusion", "$PSQ_EnableFortifyIllusion", PSQ.EnableFortifyIllusion)
		AddSliderOptionST("FortifyIllusionMult", "$PSQ_FortifyIllusionMult", PSQ.FortifyIllusionMult * 100, "{0} %")
		AddToggleOptionST("EnableMagicResistance", "$PSQ_EnableMagicResistance", PSQ.EnableMagicResistance)
		AddSliderOptionST("MagicResistanceMult", "$PSQ_MagicResistanceMult", PSQ.MagicResistanceMult * 100, "{0} %")
		AddToggleOptionST("EnableSuccubusSpellBooster", "$PSQ_EnableSuccubusSpellBooster", PSQ.EnableSuccubusSpellBooster)
		AddToggleOptionST("FortifySneakSpell", "$PSQ_EnableFortifySneak", PSQ.PlayerRef.HasSpell(PSQ.FortifySneakSpell))
		AddToggleOptionST("EnableFortifyBartar", "$PSQ_EnableFortifyBartar", PSQ.EnableFortifyBartar)
		AddToggleOptionST("ImmunityToSTD", PSQ.ImmunityToSTD.GetName(), PSQ.PlayerRef.HasSpell(PSQ.ImmunityToSTD))
		
		SetCursorPosition(1)
		AddHeaderOption("$PSQ_OtherAbilitySettings")
		AddSliderOptionST("WingMaxJumpHeight", "$PSQ_WingJumpHeight", PSQ.WingMaxJumpHeight, "{0}")
		AddSliderOptionST("DefaultJumpHeight", "$PSQ_DefaultJumpHeight", PSQ.DefaultJumpHeight, "{0}")
		AddToggleOptionST("PhysicalWeakness", "$PSQ_PhysicalWeakness", PSQ.PhysicalWeakness)
		AddHeaderOption("$PSQ_EnergyConversionMAX")
		AddSliderOptionST("RestoreMagickaMAX", "$PSQ_EnergyConversionMagicka", PSQ.RestoreMagickaMAX, "{0}")
	EndIf
	
	If Page == "$PSQ_Page10"
		AddToggleOptionST("StopEnergyConsuming", "$PSQ_PauseEnergyConsuming", PSQ.StopEnergyConsuming)
		AddTextOptionST("InitFaction", "", "$PSQ_InitFaction")
		AddTextOptionST("BecomeSuccubus", "", GetBecomeSuccubusStrings())
		AddTextOptionST("RegisteriNeed", "$PSQ_RegisteriNeed", "$PSQ_Execute")
		AddTextOptionST("RegisterEFF", "$PSQ_RegisterEFF", "$PSQ_Execute")
	EndIf
	
	If Page == "$PSQ_Page11"
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddTextOptionST("NPCTransform", "NPC Transform", "")
		AddTextOptionST("NPCName", SuccubusNPC.GetLeveledActorBase().GetName(), "")
		AddToggleOptionST("NPCBecomeSuccubus", "Register as Succubus", GetIntValue(SuccubusNPC, "PSQ_NPCTransformRegistered"))
		AddToggleOptionST("NPCHenshinBody", "$PSQ_EnableHenshinBody", GetIntValue(SuccubusNPC, "PSQ_NPCTransformBody"))
		AddToggleOptionST("NPCHenshinSkin", "$PSQ_EnableHenshinSkin", GetIntValue(SuccubusNPC, "PSQ_NPCTransformSkin"))
		AddColorOptionST("NPCPSQSkinColor", "$PSQ_HenshinSkinColor", GetIntValue(SuccubusNPC, "PSQ_NPCTransformSkinColor"))
		AddTextOptionST("NPCSetSkinColor", "", "$PSQ_SetSkinColor")
		AddToggleOptionST("NPCHenshinEyes", "$PSQ_EnableHenshinEyes", GetIntValue(SuccubusNPC, "PSQ_NPCTransformEye"))
		AddToggleOptionST("NPCHenshinWings", "$PSQ_EnableHenshinWings", GetIntValue(SuccubusNPC, "PSQ_NPCTransformWings"))
		AddMenuOptionST("NPCSwitchWings", "$PSQ_SwitchWings", GetFormValue(SuccubusNPC, "PSQ_NPCWings"))
		AddToggleOptionST("NPCHenshinHorn", "$PSQ_EnableHenshinHorn", GetIntValue(SuccubusNPC, "PSQ_NPCTransformHorns"))
		AddToggleOptionST("NPCHenshinTail", "$PSQ_EnableHenshinTail", GetIntValue(SuccubusNPC, "PSQ_NPCTransformTail"))
		AddToggleOptionST("NPCHenshinCuirass", "$PSQ_EnableHenshinCuirass", GetIntValue(SuccubusNPC, "PSQ_NPCTransformCuirass"))
		AddToggleOptionST("NPCHenshinBoots", "$PSQ_EnableHenshinBoots", GetIntValue(SuccubusNPC, "PSQ_NPCTransformBoots"))
		AddToggleOptionST("NPCHenshinGloves", "$PSQ_EnableHenshinGloves", GetIntValue(SuccubusNPC, "PSQ_NPCTransformGauntlets"))
		AddToggleOptionST("NPCHenshinPenis", "$PSQ_EnableHenshinPenis", GetIntValue(SuccubusNPC, "PSQ_NPCTransformPenis"))
		
		SetCursorPosition(1)
		AddToggleOptionST("NPCHenshinScale", "Transform Body Scales", GetIntValue(SuccubusNPC, "PSQ_NPCTransformScale"))
		AddSliderOptionST("NPCSuccubusHeight", "$PSQ_SuccubusHeight", GetFloatValue(SuccubusNPC, "PSQ_NPCTransformHeight"), "{2}")
		AddSliderOptionST("NPCSuccubusBreast", "$PSQ_SuccubusBreast", GetFloatValue(SuccubusNPC, "PSQ_NPCTransformBreast"), "{2}")
		AddSliderOptionST("NPCSuccubusButt", "$PSQ_SuccubusButt", GetFloatValue(SuccubusNPC, "PSQ_NPCTransformButt"), "{2}")
		AddSliderOptionST("NPCSuccubusGenitals", "$PSQ_SuccubusGenitals", GetFloatValue(SuccubusNPC, "PSQ_NPCTransformGenitals"), "{2}")
		AddSliderOptionST("NPCSuccubusScrotum", "$PSQ_SuccubusScrotum", GetFloatValue(SuccubusNPC, "PSQ_NPCTransformScrotum"), "{2}")
	EndIf
EndEvent

;toggle switchs
Event OnSelectST()
	String Option = GetState()
	If Option == "EnableDrain"
		PSQ.EnableDrain = !PSQ.EnableDrain
		SetToggleOptionValueST(PSQ.EnableDrain)
	ElseIf Option == "AllowDrainFromFemale"
		PSQ.AllowDrainFromFemale = !PSQ.AllowDrainFromFemale
		SetToggleOptionValueST(PSQ.AllowDrainFromFemale)
	ElseIf Option == "AllowDrainFromBeast"
		PSQ.AllowDrainFromBeast = !PSQ.AllowDrainFromBeast
		SetToggleOptionValueST(PSQ.AllowDrainFromBeast)
	ElseIf Option == "AllowDrainFromUndead"
		PSQ.AllowDrainFromUndead = !PSQ.AllowDrainFromUndead
		SetToggleOptionValueST(PSQ.AllowDrainFromUndead)
	ElseIf Option == "ExtractSemenPotion"
		PSQ.ExtractSemenPotion = !PSQ.ExtractSemenPotion
		SetToggleOptionValueST(PSQ.ExtractSemenPotion)
	ElseIf Option == "AutoExtractSemenPotion"
		PSQ.AutoExtractSemenPotion = !PSQ.AutoExtractSemenPotion
		SetToggleOptionValueST(PSQ.AutoExtractSemenPotion)
	ElseIf Option == "FastMode"
		PSQ.FastMode = !PSQ.FastMode
		SetToggleOptionValueST(PSQ.FastMode)
	ElseIf Option == "AdjustMinEnergyOfHuman"
		PSQ.AdjustMinEnergyOfHuman = !PSQ.AdjustMinEnergyOfHuman
		SetToggleOptionValueST(PSQ.AdjustMinEnergyOfHuman)
	ElseIf Option == "EnableSoulTrap"
		PSQ.EnableSoulTrap = !PSQ.EnableSoulTrap
		SetToggleOptionValueST(PSQ.EnableSoulTrap)
	ElseIf Option == "AllowKill"
		PSQ.AllowKill = !PSQ.AllowKill
		SetToggleOptionValueST(PSQ.AllowKill)
	ElseIf Option == "EnableCaptive"
		PSQ.EnableCaptive = !PSQ.EnableCaptive
		SetToggleOptionValueST(PSQ.EnableCaptive)
	ElseIf Option == "UseArousalAtDrain"
		PSQ.UseArousalAtDrain = !PSQ.UseArousalAtDrain
		SetToggleOptionValueST(PSQ.UseArousalAtDrain)
	ElseIf Option == "AllowSneakFeed"
		If PSQ.AllowSneakFeed.GetValueInt() == 0
			PSQ.AllowSneakFeed.SetValue(1)
		Else
			PSQ.AllowSneakFeed.SetValue(0)
		EndIf
		SetToggleOptionValueST(PSQ.AllowSneakFeed.GetValueInt())
	ElseIf Option == "AllowSleepFeed"
		If PSQ.AllowSleepFeed.GetValueInt() == 0
			PSQ.AllowSleepFeed.SetValue(1)
		Else
			PSQ.AllowSleepFeed.SetValue(0)
		EndIf
		SetToggleOptionValueST(PSQ.AllowSleepFeed.GetValueInt())
	ElseIf Option == "AllowForceFeed"
		If PSQ.AllowForceFeed.GetValueInt() == 0
			PSQ.AllowForceFeed.SetValue(1)
		Else
			PSQ.AllowForceFeed.SetValue(0)
		EndIf
		SetToggleOptionValueST(PSQ.AllowForceFeed.GetValueInt())
	ElseIf Option == "AllowTeamMateFeed"
		If PSQ.AllowTeamMateFeed.GetValueInt() == 0
			PSQ.AllowTeamMateFeed.SetValue(1)
		Else
			PSQ.AllowTeamMateFeed.SetValue(0)
		EndIf
		SetToggleOptionValueST(PSQ.AllowTeamMateFeed.GetValueInt())
	ElseIf Option == "EnableSatiationEffect"
		PSQ.EnableSatiationEffect = !PSQ.EnableSatiationEffect
		SetToggleOptionValueST(PSQ.EnableSatiationEffect)
	ElseIf Option == "EnableSatiationNotification"
		PSQ.EnableSatiationNotification = !PSQ.EnableSatiationNotification
		SetToggleOptionValueST(PSQ.EnableSatiationNotification)
	ElseIf Option == "EnableStarvation"
		PSQ.EnableStarvation = !PSQ.EnableStarvation
		If SuccubusEnergy.GetValue() == 0
			If PSQ.EnableStarvation
				PSQ.PlayerRef.AddSpell(PSQ.SuccubusStarvation, False)
			Else
				PSQ.PlayerRef.RemoveSpell(PSQ.SuccubusStarvation)
			EndIf
		EndIf
		SetToggleOptionValueST(PSQ.EnableStarvation)
	ElseIf Option == "EnergyModeAlt"
		PSQ.EnergyModeAlt = !PSQ.EnergyModeAlt
		If PSQ.EnergyModeAlt
			PSQ.MaxEnergy = PSQ.MaxEnergyAtAltMode
		Else
			If SuccubusEXP.GetValue() >= 10
				PSQ.MaxEnergy = 250 * Math.Sqrt(SuccubusEXP.GetValue())
			Else
				PSQ.MaxEnergy = 60 * SuccubusEXP.GetValue() + 200
			EndIf
		EndIf
		PSQ.EnergyConsumption = PSQ.MaxEnergy * PSQ.EnergyConsumptionPerMax / 100
		SetToggleOptionValueST(PSQ.EnergyModeAlt)
	ElseIf Option == "AutoGenderSwitch"
		PSQ.AutoGenderSwitch = !PSQ.AutoGenderSwitch
		SetToggleOptionValueST(PSQ.AutoGenderSwitch)
	ElseIf Option == "EnableFutanariPower"
		PSQ.EnableFutanariPower = !PSQ.EnableFutanariPower
		SetToggleOptionValueST(PSQ.EnableFutanariPower)
	ElseIf Option == "EnableAutoAddFlying"
		PSQ.EnableAutoAddFlying = !PSQ.EnableAutoAddFlying
		SetToggleOptionValueST(PSQ.EnableAutoAddFlying)
	ElseIf Option == "StopAddMilk"
		PSQ.StopAddMilk = !PSQ.StopAddMilk
		SetToggleOptionValueST(PSQ.StopAddMilk)
	ElseIf Option == "EnableBreastGrowthByMilk"
		PSQ.EnableBreastGrowthByMilk = !PSQ.EnableBreastGrowthByMilk
		SetToggleOptionValueST(PSQ.EnableBreastGrowthByMilk)
	ElseIf Option == "ChargeFull"
		PSQ.ChargeFull = !PSQ.ChargeFull
		SetToggleOptionValueST(PSQ.ChargeFull)
	ElseIf Option == "EnegyBarVisible"
		SEBU.EnegyBarVisible = !SEBU.EnegyBarVisible
		SEBU.UpdateEnergyBarPosition()
		SetToggleOptionValueST(SEBU.EnegyBarVisible)
	ElseIf Option == "EnablePSQRape"
		PSQ.EnablePSQRape = !PSQ.EnablePSQRape
		SetToggleOptionValueST(PSQ.EnablePSQRape)
	ElseIf Option == "EnableCumInflation"
		PSQ.EnableCumInflation = !PSQ.EnableCumInflation
		SetToggleOptionValueST(PSQ.EnableCumInflation)
	ElseIf Option == "AllowCumInflationAnal"
		PSQ.CumInflationAnal = !PSQ.CumInflationAnal
		SetToggleOptionValueST(PSQ.CumInflationAnal)
	ElseIf Option == "AllowCumInflationOral"
		PSQ.CumInflationOral = !PSQ.CumInflationOral
		SetToggleOptionValueST(PSQ.CumInflationOral)
	ElseIf Option == "ManualDigestionMode"
		PSQ.ManualDigestionMode = !PSQ.ManualDigestionMode
		SetToggleOptionValueST(PSQ.ManualDigestionMode)
	ElseIf Option == "EnableBodyslideMorph"
		PSQ.EnableBodyslideMorph = !PSQ.EnableBodyslideMorph
		If PSQ.EnableBodyslideMorph
			NiOverride.RemoveNodeTransformScale(PSQ.PlayerRef, True, True, "NPC Belly", "PSQ")
			NiOverride.RemoveNodeTransformScale(PSQ.PlayerRef, False, True, "NPC Belly", "PSQ")
			NiOverride.UpdateNodeTransform(PSQ.PlayerRef, True, True, "NPC Belly")
			NiOverride.UpdateNodeTransform(PSQ.PlayerRef, False, True, "NPC Belly")
		Else
			NiOverride.ClearBodyMorph(PSQ.PlayerRef, "PregnancyBelly", "PSQ")
			NiOverride.UpdateModelWeight(PSQ.PlayerRef)
		EndIf
		SetToggleOptionValueST(PSQ.EnableBodyslideMorph)
	ElseIf Option == "FluidNeedArousal"
		PSQ.FluidNeedArousal = !PSQ.FluidNeedArousal
		SetToggleOptionValueST(PSQ.FluidNeedArousal)
	ElseIf Option == "AllowHybrid"
		PSQ.AllowHybrid = !PSQ.AllowHybrid
		SetToggleOptionValueST(PSQ.AllowHybrid)
	ElseIf Option == "HenshinTattoo"
		PSQ.HenshinTattoo = !PSQ.HenshinTattoo
		SetToggleOptionValueST(PSQ.HenshinTattoo)
	ElseIf Option == "EnableBodyPaintTintChangeSatiation"
		PSQ.EnableBodyPaintTintChangeSatiation = !PSQ.EnableBodyPaintTintChangeSatiation
		SetToggleOptionValueST(PSQ.EnableBodyPaintTintChangeSatiation)
	ElseIf Option == "EnableBodyPaintAlphaChangeSatiation"
		PSQ.EnableBodyPaintAlphaChangeSatiation = !PSQ.EnableBodyPaintAlphaChangeSatiation
		SetToggleOptionValueST(PSQ.EnableBodyPaintAlphaChangeSatiation)
	ElseIf Option == "EnableBodyPaintGlowTintChangeSatiation"
		PSQ.EnableBodyPaintGlowTintChangeSatiation = !PSQ.EnableBodyPaintGlowTintChangeSatiation
		SetToggleOptionValueST(PSQ.EnableBodyPaintGlowTintChangeSatiation)
	ElseIf Option == "EnableBodyPaintGlowAlphaChangeSatiation"
		PSQ.EnableBodyPaintGlowAlphaChangeSatiation = !PSQ.EnableBodyPaintGlowAlphaChangeSatiation
		SetToggleOptionValueST(PSQ.EnableBodyPaintGlowAlphaChangeSatiation)
	ElseIf Option == "EnableCursePaintGradient"
		PSQ.EnableCursePaintGradient = !PSQ.EnableCursePaintGradient
		If PSQ.EnableCursePaintGradient
			PSQ.PlayerRef.AddSpell(PSQ.SuccubusCurseCloakSpell, False)
		Else
			PSQ.PlayerRef.RemoveSpell(PSQ.SuccubusCurseCloakSpell)
		EndIf
		SetToggleOptionValueST(PSQ.EnableCursePaintGradient)
	ElseIf Option == "EnableCursePaintTint"
		PSQ.EnableCursePaintTint = !PSQ.EnableCursePaintTint
		SetToggleOptionValueST(PSQ.EnableCursePaintTint)
	ElseIf Option == "EnableCursePaintAlpha"
		PSQ.EnableCursePaintAlpha = !PSQ.EnableCursePaintAlpha
		SetToggleOptionValueST(PSQ.EnableCursePaintAlpha)
	ElseIf Option == "EnableCursePaintGlowTint"
		PSQ.EnableCursePaintGlowTint = !PSQ.EnableCursePaintGlowTint
		SetToggleOptionValueST(PSQ.EnableCursePaintGlowTint)
	ElseIf Option == "EnableCursePaintGlowAlpha"
		PSQ.EnableCursePaintGlowAlpha = !PSQ.EnableCursePaintGlowAlpha
		SetToggleOptionValueST(PSQ.EnableCursePaintGlowAlpha)
	ElseIf Option == "HenshinBody"
		PSQ.HenshinBody = !PSQ.HenshinBody
		SetToggleOptionValueST(PSQ.HenshinBody)
	ElseIf Option == "HenshinSkin"
		PSQ.HenshinSkin = !PSQ.HenshinSkin
		SetToggleOptionValueST(PSQ.HenshinSkin)
	ElseIf Option == "HenshinEyes"
		PSQ.HenshinEyes = !PSQ.HenshinEyes
		SetToggleOptionValueST(PSQ.HenshinEyes)
	ElseIf Option == "HenshinWings"
		PSQ.HenshinWings = !PSQ.HenshinWings
		SetToggleOptionValueST(PSQ.HenshinWings)
	ElseIf Option == "HenshinHorn"
		PSQ.HenshinHorn = !PSQ.HenshinHorn
		SetToggleOptionValueST(PSQ.HenshinHorn)
	ElseIf Option == "HenshinTail"
		PSQ.HenshinTail = !PSQ.HenshinTail
		SetToggleOptionValueST(PSQ.HenshinTail)
	ElseIf Option == "HenshinCuirass"
		PSQ.HenshinCuirass = !PSQ.HenshinCuirass
		SetToggleOptionValueST(PSQ.HenshinCuirass)
	ElseIf Option == "HenshinBoots"
		PSQ.HenshinBoots = !PSQ.HenshinBoots
		SetToggleOptionValueST(PSQ.HenshinBoots)
	ElseIf Option == "HenshinGloves"
		PSQ.HenshinGloves = !PSQ.HenshinGloves
		SetToggleOptionValueST(PSQ.HenshinGloves)
	ElseIf Option == "HenshinPenis"
		PSQ.HenshinPenis = !PSQ.HenshinPenis
		SetToggleOptionValueST(PSQ.HenshinPenis)
	ElseIf Option == "HenshinHair"
		PSQ.HenshinHair = !PSQ.HenshinHair
		SetToggleOptionValueST(PSQ.HenshinHair)
	ElseIf Option == "HenshinHairColor"
		PSQ.HenshinHairColor = !PSQ.HenshinHairColor
		SetToggleOptionValueST(PSQ.HenshinHairColor)
	ElseIf Option == "EnableSuccubusSpellBooster"
		PSQ.EnableSuccubusSpellBooster = !PSQ.EnableSuccubusSpellBooster
		SetToggleOptionValueST(PSQ.EnableSuccubusSpellBooster)
	ElseIf Option == "CanWalkOnTheWater"
		PSQ.CanWalkOnTheWater = !PSQ.CanWalkOnTheWater
		SetToggleOptionValueST(PSQ.CanWalkOnTheWater)
	ElseIf Option == "HenshinIsCrime"
		PSQ.HenshinIsCrime = !PSQ.HenshinIsCrime
		If PSQ.IsHenshined
			If PSQ.HenshinIsCrime
				PSQ.PlayerRef.AddToFaction(PSQ.SuccubusFoeFaction)
			Else
				PSQ.PlayerRef.RemoveFromFaction(PSQ.SuccubusFoeFaction)
			EndIf
		EndIf
		SetToggleOptionValueST(PSQ.HenshinIsCrime)
	ElseIf Option == "HenshinFear"
		PSQ.HenshinFear = !PSQ.HenshinFear
		SetToggleOptionValueST(PSQ.HenshinFear)
	ElseIf Option == "HenshinBuff"
		PSQ.HenshinBuff = !PSQ.HenshinBuff
		SetToggleOptionValueST(PSQ.HenshinBuff)
	ElseIf Option == "HenshinArmorRate"
		PSQ.HenshinArmorRate = !PSQ.HenshinArmorRate
		SetToggleOptionValueST(PSQ.HenshinArmorRate)
	ElseIf Option == "ArousedForceTransform"
		PSQ.ArousedForceTransform = !PSQ.ArousedForceTransform
		If PSQ.ArousedForceTransform
			PSQ.PlayerRef.AddSpell(PSQ.SuccubusForceTransform)
		Else
			PSQ.PlayerRef.RemoveSpell(PSQ.SuccubusForceTransform)
		EndIf
		SetToggleOptionValueST(PSQ.ArousedForceTransform)
	ElseIf Option == "ArousedForceDeTransform"
		PSQ.ArousedForceDeTransform = !PSQ.ArousedForceDeTransform
		If PSQ.ArousedForceDeTransform
			PSQ.PlayerRef.AddSpell(PSQ.SuccubusForceTransform)
		Else
			PSQ.PlayerRef.RemoveSpell(PSQ.SuccubusForceTransform)
		EndIf
		SetToggleOptionValueST(PSQ.ArousedForceDeTransform)
	ElseIf Option == "EnableHeightChangeSuccubus"
		PSQ.EnableHeightChangeSuccubus = !PSQ.EnableHeightChangeSuccubus
		SetToggleOptionValueST(PSQ.EnableHeightChangeSuccubus)
	ElseIf Option == "EnableBreastChangeSuccubus"
		PSQ.EnableBreastChangeSuccubus = !PSQ.EnableBreastChangeSuccubus
		SetToggleOptionValueST(PSQ.EnableBreastChangeSuccubus)
	ElseIf Option == "EnableButtChangeSuccubus"
		PSQ.EnableButtChangeSuccubus = !PSQ.EnableButtChangeSuccubus
		SetToggleOptionValueST(PSQ.EnableButtChangeSuccubus)
	ElseIf Option == "EnableGenitalsChangeSuccubus"
		PSQ.EnableGenitalsChangeSuccubus = !PSQ.EnableGenitalsChangeSuccubus
		SetToggleOptionValueST(PSQ.EnableGenitalsChangeSuccubus)
	ElseIf Option == "EnableScrotumChangeSuccubus"
		PSQ.EnableScrotumChangeSuccubus = !PSQ.EnableScrotumChangeSuccubus
		SetToggleOptionValueST(PSQ.EnableScrotumChangeSuccubus)
	ElseIf Option == "EnableSoulGemPregnancy"
		PSQ.EnableSoulGemPregnancy = !PSQ.EnableSoulGemPregnancy
		SetSpell(PSQ.PSQSoulGemBirthingSpell, 1)
		SetToggleOptionValueST(PSQ.EnableSoulGemPregnancy)
	ElseIf Option == "AllowAnalPregnancy"
		PSQ.AllowAnalPregnancy = !PSQ.AllowAnalPregnancy
		SetToggleOptionValueST(PSQ.AllowAnalPregnancy)
	ElseIf Option == "EnableBellyGrowthByPregnancy"
		PSQ.EnableBellyGrowthByPregnancy = !PSQ.EnableBellyGrowthByPregnancy
		SetToggleOptionValueST(PSQ.EnableBellyGrowthByPregnancy)
	ElseIf Option == "EnableSuccubusDrainHealthSpell"
		PSQ.EnableSuccubusDrainHealthSpell = !PSQ.EnableSuccubusDrainHealthSpell
		If PSQ.EnableSuccubusDrainHealthSpell
			If SuccubusRank.GetValue() == 1
				PSQ.PlayerRef.AddSpell(PSQ.SuccubusDrainHealthSpell01, False)
			ElseIf SuccubusRank.GetValue() == 2
				PSQ.PlayerRef.AddSpell(PSQ.SuccubusDrainHealthSpell02, False)
			ElseIf SuccubusRank.GetValue() == 3
				PSQ.PlayerRef.AddSpell(PSQ.SuccubusDrainHealthSpell03, False)
			ElseIf SuccubusRank.GetValue() == 4
				PSQ.PlayerRef.AddSpell(PSQ.SuccubusDrainHealthSpell04, False)
			ElseIf SuccubusRank.GetValue() == 5
				PSQ.PlayerRef.AddSpell(PSQ.SuccubusDrainHealthSpell05, False)
			ElseIf SuccubusRank.GetValue() == 6
				PSQ.PlayerRef.AddSpell(PSQ.SuccubusDrainHealthSpell06, False)
			ElseIf SuccubusRank.GetValue() == 7
				PSQ.PlayerRef.AddSpell(PSQ.SuccubusDrainHealthSpell07, False)
			ElseIf SuccubusRank.GetValue() == 8
				PSQ.PlayerRef.AddSpell(PSQ.SuccubusDrainHealthSpell08, False)
			EndIf
		Else
			PSQ.PlayerRef.RemoveSpell(PSQ.SuccubusDrainHealthSpell01)
			PSQ.PlayerRef.RemoveSpell(PSQ.SuccubusDrainHealthSpell02)
			PSQ.PlayerRef.RemoveSpell(PSQ.SuccubusDrainHealthSpell03)
			PSQ.PlayerRef.RemoveSpell(PSQ.SuccubusDrainHealthSpell04)
			PSQ.PlayerRef.RemoveSpell(PSQ.SuccubusDrainHealthSpell05)
			PSQ.PlayerRef.RemoveSpell(PSQ.SuccubusDrainHealthSpell06)
			PSQ.PlayerRef.RemoveSpell(PSQ.SuccubusDrainHealthSpell07)
			PSQ.PlayerRef.RemoveSpell(PSQ.SuccubusDrainHealthSpell08)
		EndIf
		SetToggleOptionValueST(PSQ.EnableSuccubusDrainHealthSpell)
	ElseIf Option == "EnableSuccubusDrainStaminaSpell"
		PSQ.EnableSuccubusDrainStaminaSpell = !PSQ.EnableSuccubusDrainStaminaSpell
		If PSQ.EnableSuccubusDrainStaminaSpell
			If SuccubusRank.GetValue() == 1
				PSQ.PlayerRef.AddSpell(PSQ.SuccubusDrainStaminaSpell01, False)
			ElseIf SuccubusRank.GetValue() == 2
				PSQ.PlayerRef.AddSpell(PSQ.SuccubusDrainStaminaSpell02, False)
			ElseIf SuccubusRank.GetValue() == 3
				PSQ.PlayerRef.AddSpell(PSQ.SuccubusDrainStaminaSpell03, False)
			ElseIf SuccubusRank.GetValue() == 4
				PSQ.PlayerRef.AddSpell(PSQ.SuccubusDrainStaminaSpell04, False)
			ElseIf SuccubusRank.GetValue() == 5
				PSQ.PlayerRef.AddSpell(PSQ.SuccubusDrainStaminaSpell05, False)
			ElseIf SuccubusRank.GetValue() == 6
				PSQ.PlayerRef.AddSpell(PSQ.SuccubusDrainStaminaSpell06, False)
			ElseIf SuccubusRank.GetValue() == 7
				PSQ.PlayerRef.AddSpell(PSQ.SuccubusDrainStaminaSpell07, False)
			ElseIf SuccubusRank.GetValue() == 8
				PSQ.PlayerRef.AddSpell(PSQ.SuccubusDrainStaminaSpell08, False)
			EndIf
		Else
			PSQ.PlayerRef.RemoveSpell(PSQ.SuccubusDrainStaminaSpell01)
			PSQ.PlayerRef.RemoveSpell(PSQ.SuccubusDrainStaminaSpell02)
			PSQ.PlayerRef.RemoveSpell(PSQ.SuccubusDrainStaminaSpell03)
			PSQ.PlayerRef.RemoveSpell(PSQ.SuccubusDrainStaminaSpell04)
			PSQ.PlayerRef.RemoveSpell(PSQ.SuccubusDrainStaminaSpell05)
			PSQ.PlayerRef.RemoveSpell(PSQ.SuccubusDrainStaminaSpell06)
			PSQ.PlayerRef.RemoveSpell(PSQ.SuccubusDrainStaminaSpell07)
			PSQ.PlayerRef.RemoveSpell(PSQ.SuccubusDrainStaminaSpell08)
		EndIf
		SetToggleOptionValueST(PSQ.EnableSuccubusDrainStaminaSpell)
	ElseIf Option == "EnableSuccubusDrainFF"
		PSQ.EnableSuccubusDrainFF = !PSQ.EnableSuccubusDrainFF
		If PSQ.EnableSuccubusDrainFF
			If SuccubusRank.GetValue() == 1
				PSQ.PlayerRef.AddSpell(PSQ.SuccubusDrainFF01, False)
			ElseIf SuccubusRank.GetValue() == 2
				PSQ.PlayerRef.AddSpell(PSQ.SuccubusDrainFF02, False)
			ElseIf SuccubusRank.GetValue() == 3
				PSQ.PlayerRef.AddSpell(PSQ.SuccubusDrainFF03, False)
			ElseIf SuccubusRank.GetValue() == 4
				PSQ.PlayerRef.AddSpell(PSQ.SuccubusDrainFF04, False)
			ElseIf SuccubusRank.GetValue() == 5
				PSQ.PlayerRef.AddSpell(PSQ.SuccubusDrainFF05, False)
			ElseIf SuccubusRank.GetValue() == 6
				PSQ.PlayerRef.AddSpell(PSQ.SuccubusDrainFF06, False)
			ElseIf SuccubusRank.GetValue() == 7
				PSQ.PlayerRef.AddSpell(PSQ.SuccubusDrainFF07, False)
			ElseIf SuccubusRank.GetValue() == 8
				PSQ.PlayerRef.AddSpell(PSQ.SuccubusDrainFF08, False)
			EndIf
		Else
			PSQ.PlayerRef.RemoveSpell(PSQ.SuccubusDrainFF01)
			PSQ.PlayerRef.RemoveSpell(PSQ.SuccubusDrainFF02)
			PSQ.PlayerRef.RemoveSpell(PSQ.SuccubusDrainFF03)
			PSQ.PlayerRef.RemoveSpell(PSQ.SuccubusDrainFF04)
			PSQ.PlayerRef.RemoveSpell(PSQ.SuccubusDrainFF05)
			PSQ.PlayerRef.RemoveSpell(PSQ.SuccubusDrainFF06)
			PSQ.PlayerRef.RemoveSpell(PSQ.SuccubusDrainFF07)
			PSQ.PlayerRef.RemoveSpell(PSQ.SuccubusDrainFF08)
		EndIf
		SetToggleOptionValueST(PSQ.EnableSuccubusDrainFF)
	ElseIf Option == "CreatePenisSpellSelf"
		SetSpell(PSQ.CreatePenisSpellSelf, 1)
		SetToggleOptionValueST(PSQ.PlayerRef.HasSpell(PSQ.CreatePenisSpellSelf))
	ElseIf Option == "CreatePenisSpellOther"
		SetSpell(PSQ.CreatePenisSpellOther, 1)
		SetToggleOptionValueST(PSQ.PlayerRef.HasSpell(PSQ.CreatePenisSpellOther))
	ElseIf Option == "SuccubusCurseSpell"
		SetSpell(PSQ.SuccubusCurseSpell, 1)
		SetToggleOptionValueST(PSQ.PlayerRef.HasSpell(PSQ.SuccubusCurseSpell))
	ElseIf Option == "SuccubusSummonMerchantSpell"
		SetSpell(PSQ.SuccubusSummonMerchantSpell, 1)
		SetToggleOptionValueST(PSQ.PlayerRef.HasSpell(PSQ.SuccubusSummonMerchantSpell))
	ElseIf Option == "SuccubusRaiseArousalSpell"
		SetSpell(PSQ.SuccubusRaiseArousalSpell, 1)
		SetToggleOptionValueST(PSQ.PlayerRef.HasSpell(PSQ.SuccubusRaiseArousalSpell))
	ElseIf Option == "SuccubusArousalCloakSpell"
		SetSpell(PSQ.SuccubusArousalCloakSpell, 1)
		SetToggleOptionValueST(PSQ.PlayerRef.HasSpell(PSQ.SuccubusArousalCloakSpell))
	ElseIf Option == "StarkRealitySpell"
		SetSpell(PSQ.StarkRealitySpell, 1)
		SetToggleOptionValueST(PSQ.PlayerRef.HasSpell(PSQ.StarkRealitySpell))
	ElseIf Option == "SuccuKanashibari"
		SetSpell(PSQ.SuccuKanashibari, 2)
		SetToggleOptionValueST(PSQ.PlayerRef.HasSpell(PSQ.SuccuKanashibari))
	ElseIf Option == "FortifyMSGBoxSpell"
		SetSpell(PSQ.FortifyMSGBoxSpell, 3)
		SetToggleOptionValueST(PSQ.PlayerRef.HasSpell(PSQ.FortifyMSGBoxSpell))
	ElseIf Option == "RestoreMagickaSpell"
		SetSpell(PSQ.RestoreMagickaSpell, 1)
		SetToggleOptionValueST(PSQ.PlayerRef.HasSpell(PSQ.RestoreMagickaSpell))
	ElseIf Option == "MasturbationSpell"
		SetSpell(PSQ.MasturbationSpell, 1)
		SetToggleOptionValueST(PSQ.PlayerRef.HasSpell(PSQ.MasturbationSpell))
	ElseIf Option == "ImmunityToSTD"
		SetSpell(PSQ.ImmunityToSTD, 1)
		SetToggleOptionValueST(PSQ.PlayerRef.HasSpell(PSQ.ImmunityToSTD))
	ElseIf Option == "FortifyMagickaSpell"
		SetSpell(PSQ.FortifyMagickaSpell, 1)
		SetToggleOptionValueST(PSQ.PlayerRef.HasSpell(PSQ.FortifyMagickaSpell))
	ElseIf Option == "SuccubusSpellLearningMSGBoxSpell"
		SetSpell(PSQ.SuccubusSpellLearningMSGBoxSpell, 1)
		SetToggleOptionValueST(PSQ.PlayerRef.HasSpell(PSQ.SuccubusSpellLearningMSGBoxSpell))
	ElseIf Option == "FortifySneakSpell"
		SetSpell(PSQ.FortifySneakSpell, 1)
		If PSQ.PlayerRef.HasSpell(PSQ.FortifySneakSpell)
			PSQ.PlayerRef.AddPerk(PSQ.FortifySneakPerk)
		Else
			PSQ.PlayerRef.RemovePerk(PSQ.FortifySneakPerk)
		EndIf
		SetToggleOptionValueST(PSQ.PlayerRef.HasSpell(PSQ.FortifySneakSpell))
	ElseIf Option == "PhysicalWeakness"
		PSQ.PhysicalWeakness = !PSQ.PhysicalWeakness
		If PlayerIsSuccubus.GetValueInt() == 1
			If PSQ.PhysicalWeakness
				PSQ.PlayerRef.SetActorValue("Health", PSQ.PlayerRef.GetBaseActorValue("Health") - 30)
				PSQ.PlayerRef.SetActorValue("Stamina", PSQ.PlayerRef.GetBaseActorValue("Stamina") - 30)
			Else
				PSQ.PlayerRef.SetActorValue("Health", PSQ.PlayerRef.GetBaseActorValue("Health") + 30)
				PSQ.PlayerRef.SetActorValue("Stamina", PSQ.PlayerRef.GetBaseActorValue("Stamina") + 30)
			EndIf
		PSQ.Satiety()
		EndIf
		SetToggleOptionValueST(PSQ.PhysicalWeakness)
	ElseIf Option == "EnableEnergyConsumingBySuccubusSpell"
		PSQ.EnableEnergyConsumingBySuccubusSpell = !PSQ.EnableEnergyConsumingBySuccubusSpell
		SetToggleOptionValueST(PSQ.EnableEnergyConsumingBySuccubusSpell)
	ElseIf Option == "EnableSpellCastingNotification"
		PSQ.EnableSpellCastingNotification = !PSQ.EnableSpellCastingNotification
		SetToggleOptionValueST(PSQ.EnableSpellCastingNotification)
	ElseIf Option == "StopEnergyConsuming"
		PSQ.StopEnergyConsuming = !PSQ.StopEnergyConsuming
		If PlayerIsSuccubus.GetValue() == 1
			If PSQ.StopEnergyConsuming
				PSQ.ConsumeTimer = PSQ.GameDaysPassed.GetValue() - PSQ.LastConsumeTime
				PSQ.Satiety(- 1 * PSQ.EnergyConsumption * PSQ.ConsumeTimer)
				PSQ.LastConsumeTime = PSQ.GameDaysPassed.GetValue()
			Else
				PSQ.LastConsumeTime = PSQ.GameDaysPassed.GetValue()
			EndIf
		EndIf
		SetToggleOptionValueST(PSQ.StopEnergyConsuming)
	ElseIf Option == "EnableFortifyDestruction"
		PSQ.EnableFortifyDestruction = !PSQ.EnableFortifyDestruction
		If PSQ.EnableFortifyDestruction
			PSQ.FortifyDestructionSpell.SetNthEffectMagnitude(0, (3 * SuccubusRank.GetValue() + Math.Sqrt(SuccubusEXP.GetValue())))
			PSQ.PlayerRef.AddSpell(PSQ.FortifyDestructionSpell, False)
		Else
			PSQ.PlayerRef.RemoveSpell(PSQ.FortifyDestructionSpell)
		EndIf
		SetToggleOptionValueST(PSQ.EnableFortifyDestruction)
	ElseIf Option == "EnableFortifyIllusion"
		PSQ.EnableFortifyIllusion = !PSQ.EnableFortifyIllusion
		If PSQ.EnableFortifyIllusion
			PSQ.PlayerRef.AddPerk(PSQ.FortifyIllusionPerk)
			PSQ.FortifyIllusionSpell.SetNthEffectMagnitude(0, (3 * SuccubusRank.GetValue() + Math.Sqrt(SuccubusEXP.GetValue())))
			PSQ.PlayerRef.AddSpell(PSQ.FortifyIllusionSpell, False)
		Else
			PSQ.PlayerRef.RemoveSpell(PSQ.FortifyIllusionSpell)
			PSQ.PlayerRef.RemovePerk(PSQ.FortifyIllusionPerk)
		EndIf
		SetToggleOptionValueST(PSQ.EnableFortifyIllusion)
	ElseIf Option == "EnableMagicResistance"
		PSQ.EnableMagicResistance = !PSQ.EnableMagicResistance
		If PSQ.EnableMagicResistance
			PSQ.MagicResistanceSpell.SetNthEffectMagnitude(0, ((2 * SuccubusRank.GetValue() + 0.5 * Math.Sqrt(SuccubusEXP.GetValue())) + 7))
			PSQ.PlayerRef.AddSpell(PSQ.MagicResistanceSpell, False)
		Else
			PSQ.PlayerRef.RemoveSpell(PSQ.MagicResistanceSpell)
		EndIf
		SetToggleOptionValueST(PSQ.EnableMagicResistance)
	ElseIf Option == "EnableFortifyBartar"
		PSQ.EnableFortifyBartar = !PSQ.EnableFortifyBartar
		If PSQ.EnableFortifyBartar
			PSQ.PlayerRef.AddPerk(PSQ.FortifyBartarPerk)
			If SuccubusRank.GetValue() == 1
				PSQ.PlayerRef.AddSpell(PSQ.FortifyBartarSpell1, False)
			ElseIf SuccubusRank.GetValue() == 2
				PSQ.PlayerRef.AddSpell(PSQ.FortifyBartarSpell2, False)
			ElseIf SuccubusRank.GetValue() == 3
				PSQ.PlayerRef.AddSpell(PSQ.FortifyBartarSpell3, False)
			ElseIf SuccubusRank.GetValue() == 4
				PSQ.PlayerRef.AddSpell(PSQ.FortifyBartarSpell4, False)
			ElseIf SuccubusRank.GetValue() == 5
				PSQ.PlayerRef.AddSpell(PSQ.FortifyBartarSpell5, False)
			ElseIf SuccubusRank.GetValue() == 6
				PSQ.PlayerRef.AddSpell(PSQ.FortifyBartarSpell6, False)
			ElseIf SuccubusRank.GetValue() == 7
				PSQ.PlayerRef.AddSpell(PSQ.FortifyBartarSpell7, False)
			ElseIf SuccubusRank.GetValue() == 8
				PSQ.PlayerRef.AddSpell(PSQ.FortifyBartarSpell8, False)
			EndIf
		Else
			PSQ.PlayerRef.RemovePerk(PSQ.FortifyBartarPerk)
			PSQ.PlayerRef.RemoveSpell(PSQ.FortifyBartarSpell1)
			PSQ.PlayerRef.RemoveSpell(PSQ.FortifyBartarSpell2)
			PSQ.PlayerRef.RemoveSpell(PSQ.FortifyBartarSpell3)
			PSQ.PlayerRef.RemoveSpell(PSQ.FortifyBartarSpell4)
			PSQ.PlayerRef.RemoveSpell(PSQ.FortifyBartarSpell5)
			PSQ.PlayerRef.RemoveSpell(PSQ.FortifyBartarSpell6)
			PSQ.PlayerRef.RemoveSpell(PSQ.FortifyBartarSpell7)
			PSQ.PlayerRef.RemoveSpell(PSQ.FortifyBartarSpell8)
		EndIf
		SetToggleOptionValueST(PSQ.EnableFortifyBartar)	
	ElseIf Option == "NPCBecomeSuccubus"
		If GetIntValue(SuccubusNPC, "PSQ_NPCTransformRegistered") == 0
			SetIntValue(SuccubusNPC, "PSQ_NPCTransformRegistered", 1)
			SuccubusNPC.AddToFaction(PSQ.SuccubusNPCFaction)
			NiOverride.AddNodeOverrideString(SuccubusNPC, true, "Face [Ovl0]", 9, 0, "Textures\\PSQ\\Overlays\\FollowerSuccubusFace_0.dds", true)
			NiOverride.AddNodeOverrideString(SuccubusNPC, true, "Body [Ovl0]", 9, 0, "Textures\\PSQ\\Overlays\\FollowerSuccubusBody_0.dds", true)
			NiOverride.AddNodeOverrideString(SuccubusNPC, true, "Feet [Ovl0]", 9, 0, "Textures\\PSQ\\Overlays\\FollowerSuccubusBody_0.dds", true)
			NiOverride.AddNodeOverrideString(SuccubusNPC, true, "Hands [Ovl0]", 9, 0, "Textures\\PSQ\\Overlays\\FollowerSuccubusHands_0.dds", true)
			NiOverride.AddNodeOverrideFloat(SuccubusNPC, True, "Face [Ovl0]", 8, -1, 0.0, True)
			NiOverride.AddNodeOverrideFloat(SuccubusNPC, True, "Body [Ovl0]", 8, -1, 0.0, True)
			NiOverride.AddNodeOverrideFloat(SuccubusNPC, True, "Feet [Ovl0]", 8, -1, 0.0, True)
			NiOverride.AddNodeOverrideFloat(SuccubusNPC, True, "Hands [Ovl0]", 8, -1, 0.0, True)
		Else
			SetIntValue(SuccubusNPC, "PSQ_NPCTransformRegistered", 0)
			SuccubusNPC.RemoveFromFaction(PSQ.SuccubusNPCFaction)
		EndIf
		SetToggleOptionValueST(GetIntValue(SuccubusNPC, "PSQ_NPCTransformRegistered"))
	ElseIf Option == "NPCHenshinBody"
		If GetIntValue(SuccubusNPC, "PSQ_NPCTransformBody") == 0
			SetIntValue(SuccubusNPC, "PSQ_NPCTransformBody", 1)
		Else
			SetIntValue(SuccubusNPC, "PSQ_NPCTransformBody", 0)
		EndIf
		SetToggleOptionValueST(GetIntValue(SuccubusNPC, "PSQ_NPCTransformBody"))
	ElseIf Option == "NPCHenshinSkin"
		If GetIntValue(SuccubusNPC, "PSQ_NPCTransformSkin") == 0
			SetIntValue(SuccubusNPC, "PSQ_NPCTransformSkin", 1)
		Else
			SetIntValue(SuccubusNPC, "PSQ_NPCTransformSkin", 0)
		EndIf
		SetToggleOptionValueST(GetIntValue(SuccubusNPC, "PSQ_NPCTransformSkin"))
	ElseIf Option == "NPCHenshinEyes"
		If GetIntValue(SuccubusNPC, "PSQ_NPCTransformEye") == 0
			SetIntValue(SuccubusNPC, "PSQ_NPCTransformEye", 1)
		Else
			SetIntValue(SuccubusNPC, "PSQ_NPCTransformEye", 0)
		EndIf
		SetToggleOptionValueST(GetIntValue(SuccubusNPC, "PSQ_NPCTransformEye"))
	ElseIf Option == "NPCHenshinWings"
		If GetIntValue(SuccubusNPC, "PSQ_NPCTransformWings") == 0
			SetIntValue(SuccubusNPC, "PSQ_NPCTransformWings", 1)
			If GetFormValue(SuccubusNPC, "PSQ_NPCWings") == None
				SetFormValue(SuccubusNPC, "PSQ_NPCWings", PSQ.SuccubusStaticWings)
			EndIf
		Else
			SetIntValue(SuccubusNPC, "PSQ_NPCTransformWings", 0)
		EndIf
		SetToggleOptionValueST(GetIntValue(SuccubusNPC, "PSQ_NPCTransformWings"))
	ElseIf Option == "NPCHenshinHorn"
		If GetIntValue(SuccubusNPC, "PSQ_NPCTransformHorns") == 0
			SetIntValue(SuccubusNPC, "PSQ_NPCTransformHorns", 1)
		Else
			SetIntValue(SuccubusNPC, "PSQ_NPCTransformHorns", 0)
		EndIf
		SetToggleOptionValueST(GetIntValue(SuccubusNPC, "PSQ_NPCTransformHorns"))
	ElseIf Option == "NPCHenshinTail"
		If GetIntValue(SuccubusNPC, "PSQ_NPCTransformTail") == 0
			SetIntValue(SuccubusNPC, "PSQ_NPCTransformTail", 1)
		Else
			SetIntValue(SuccubusNPC, "PSQ_NPCTransformTail", 0)
		EndIf
		SetToggleOptionValueST(GetIntValue(SuccubusNPC, "PSQ_NPCTransformTail"))
	ElseIf Option == "NPCHenshinCuirass"
		If GetIntValue(SuccubusNPC, "PSQ_NPCTransformCuirass") == 0
			SetIntValue(SuccubusNPC, "PSQ_NPCTransformCuirass", 1)
		Else
			SetIntValue(SuccubusNPC, "PSQ_NPCTransformCuirass", 0)
		EndIf
		SetToggleOptionValueST(GetIntValue(SuccubusNPC, "PSQ_NPCTransformCuirass"))
	ElseIf Option == "NPCHenshinBoots"
		If GetIntValue(SuccubusNPC, "PSQ_NPCTransformBoots") == 0
			SetIntValue(SuccubusNPC, "PSQ_NPCTransformBoots", 1)
		Else
			SetIntValue(SuccubusNPC, "PSQ_NPCTransformBoots", 0)
		EndIf
		SetToggleOptionValueST(GetIntValue(SuccubusNPC, "PSQ_NPCTransformBoots"))
	ElseIf Option == "NPCHenshinGloves"
		If GetIntValue(SuccubusNPC, "PSQ_NPCTransformGauntlets") == 0
			SetIntValue(SuccubusNPC, "PSQ_NPCTransformGauntlets", 1)
		Else
			SetIntValue(SuccubusNPC, "PSQ_NPCTransformGauntlets", 0)
		EndIf
		SetToggleOptionValueST(GetIntValue(SuccubusNPC, "PSQ_NPCTransformGauntlets"))
	ElseIf Option == "NPCHenshinPenis"
		If GetIntValue(SuccubusNPC, "PSQ_NPCTransformPenis") == 0
			SetIntValue(SuccubusNPC, "PSQ_NPCTransformPenis", 1)
		Else
			SetIntValue(SuccubusNPC, "PSQ_NPCTransformPenis", 0)
		EndIf
		SetToggleOptionValueST(GetIntValue(SuccubusNPC, "PSQ_NPCTransformPenis"))
	ElseIf Option == "NPCHenshinScale"
		If GetIntValue(SuccubusNPC, "PSQ_NPCTransformScale") == 0
			SetIntValue(SuccubusNPC, "PSQ_NPCTransformScale", 1)
		Else
			SetIntValue(SuccubusNPC, "PSQ_NPCTransformScale", 0)
		EndIf
		SetToggleOptionValueST(GetIntValue(SuccubusNPC, "PSQ_NPCTransformScale"))
	ElseIf Option == "PSQ_LureEffectOnFemale"
		If GetIntValue(PSQ.PlayerRef, "PSQ_LureEffectOnFemale") == 0
			SetIntValue(PSQ.PlayerRef, "PSQ_LureEffectOnFemale", 1)
		Else
			SetIntValue(PSQ.PlayerRef, "PSQ_LureEffectOnFemale", 0)
		EndIf
		SetToggleOptionValueST(GetIntValue(PSQ.PlayerRef, "PSQ_LureEffectOnFemale") == 0)
	ElseIf Option == "PSQ_LureEffectOnMale"
		If GetIntValue(PSQ.PlayerRef, "PSQ_LureEffectOnMale") == 0
			SetIntValue(PSQ.PlayerRef, "PSQ_LureEffectOnMale", 1)
		Else
			SetIntValue(PSQ.PlayerRef, "PSQ_LureEffectOnMale", 0)
		EndIf
		SetToggleOptionValueST(GetIntValue(PSQ.PlayerRef, "PSQ_LureEffectOnMale") == 0)
	ElseIf Option == "PSQ_LureEffectOnBeast"
		If GetIntValue(PSQ.PlayerRef, "PSQ_LureEffectOnBeast") == 0
			SetIntValue(PSQ.PlayerRef, "PSQ_LureEffectOnBeast", 1)
		Else
			SetIntValue(PSQ.PlayerRef, "PSQ_LureEffectOnBeast", 0)
		EndIf
		SetToggleOptionValueST(GetIntValue(PSQ.PlayerRef, "PSQ_LureEffectOnBeast") == 0)
	ElseIf Option == "PSQ_LureEffectOnUndead"
		If GetIntValue(PSQ.PlayerRef, "PSQ_LureEffectOnUndead") == 0
			SetIntValue(PSQ.PlayerRef, "PSQ_LureEffectOnUndead", 1)
		Else
			SetIntValue(PSQ.PlayerRef, "PSQ_LureEffectOnUndead", 0)
		EndIf
		SetToggleOptionValueST(GetIntValue(PSQ.PlayerRef, "PSQ_LureEffectOnUndead") == 1)
	EndIf
EndEvent

;Text Options
State GetCurrentColorAsMax
	Event OnSelectST()
		PSQ.GetBodyPaintData(True)
		SetTextOptionValueST("$PSQ_Done")
	EndEvent
EndState
State GetCurrentColorAsMin
	Event OnSelectST()
		PSQ.GetBodyPaintData(False)
		SetTextOptionValueST("$PSQ_Done")
	EndEvent
EndState
State SetSkinColor
	Event OnSelectST()
		PSQ.PSQSkinColor = Game.GetTintMaskColor(6, 0)
		SetColorOptionValueST(PSQ.PSQSkinColor, False, "PSQSkinColor")
	EndEvent
	Event OnHighlightST()
		SetInfoText("$PSQ_SetSkinColorInfo")
	EndEvent
EndState
State SetHairColor
	Event OnSelectST()
		PSQ.PSQSuccubusHairColorInt = PSQ.PlayerRef.GetLeveledActorBase().GetHairColor().GetColor()
		PSQ.PSQSuccubusHairColor.SetColor(PSQ.PSQSuccubusHairColorInt)
		SetColorOptionValueST(PSQ.PSQSuccubusHairColorInt, False, "PSQSuccubusHairColorInt")
	EndEvent
	Event OnHighlightST()
		SetInfoText("$PSQ_SethairColorInfo")
	EndEvent
EndState
State EnergyBarFillDirection
	Event OnSelectST()
		If SEBU.EnergyBarFillDirection == "Right"
			SEBU.EnergyBarFillDirection = "Left"
			SEBU.UpdateEnergyBarPosition()
			SetTextOptionValueST(SEBU.EnergyBarFillDirection)
		ElseIf SEBU.EnergyBarFillDirection == "Left"
			SEBU.EnergyBarFillDirection = "Both"
			SEBU.UpdateEnergyBarPosition()
			SetTextOptionValueST(SEBU.EnergyBarFillDirection)
		ElseIf SEBU.EnergyBarFillDirection == "Both"
			SEBU.EnergyBarFillDirection = "Right"
			SEBU.UpdateEnergyBarPosition()
			SetTextOptionValueST(SEBU.EnergyBarFillDirection)
		EndIf
	EndEvent
EndState
State ClearPregnancy
	Event OnSelectST()
		SGI.ClearUterus()
		SetTextOptionValueST(GetIntValue(PSQ.PlayerRef, "PRG_SeedsNum"), False, "SeedsNum")
		SetTextOptionValueST(GetIntValue(PSQ.PlayerRef, "PRG_SeedsTotal"), False, "SeedsTotal")
		SetTextOptionValueST("$PSQ_PregnancyCleared")
	EndEvent
EndState
State BecomeSuccubus
	Event OnSelectST()
		If PSQ.PlayerIsSuccubus.GetValueInt() == 0
			SetTextOptionValueST("$PSQ_QuitSuccubus")
			PSQ.BecomeSuccubus()
		Else
			SetTextOptionValueST("$PSQ_BecomeSuccubus")
			PSQ.QuitSuccubus()
		EndIf
	EndEvent
EndState
State RegisteriNeed
	Event OnSelectST()
		SetTextOptionValueST("$PSQ_Processing")
		PSQ.RegisteriNeed()
		SetTextOptionValueST("$PSQ_Completed")
	EndEvent
EndState
State RegisterEFF
	Event OnSelectST()
		SetTextOptionValueST("$PSQ_Processing")
		PSQ.RegisterEFF()
		SetTextOptionValueST("$PSQ_Completed")
	EndEvent
EndState
State InitFaction
	Event OnSelectST()
		SetTextOptionValueST("$PSQ_Processing")
		PSQ.FactionInit()
		SetTextOptionValueST("$PSQ_Completed")
	EndEvent
EndState
State SatiationBuffs
	Event OnHighlightST()
		SetInfoText("$PSQ_SuccubusBuffTextInfo")
	EndEvent
EndState
State HenshinCaution
	Event OnHighlightST()
		SetInfoText("$PSQ_HenshinCautionInfo")
	EndEvent
EndState
State SpellSwichNotice
	Event OnHighlightST()
		SetInfoText("$PSQ_SpellSwichNoticeInfo")
	EndEvent
EndState
State NPCTransform
	Event OnHighlightST()
		SetInfoText("The appearance change of NPC does not work like PC, so in some cases incomplete operation will occur.")
	EndEvent
EndState
State NPCSetSkinColor
	Event OnSelectST()
		Int Color = Game.GetTintMaskColor(6, 0)
		SetIntValue(SuccubusNPC, "PSQ_NPCTransformSkinColor", Color)
		NiOverride.AddNodeOverrideInt(SuccubusNPC, True, "Face [Ovl0]", 7, -1, Color, True)
		NiOverride.AddNodeOverrideInt(SuccubusNPC, True, "Body [Ovl0]", 7, -1, Color, True)
		NiOverride.AddNodeOverrideInt(SuccubusNPC, True, "Feet [Ovl0]", 7, -1, Color, True)
		NiOverride.AddNodeOverrideInt(SuccubusNPC, True, "Hands [Ovl0]", 7, -1, Color, True)
		SetColorOptionValueST(GetIntValue(SuccubusNPC, "PSQ_NPCTransformSkinColor"), False, "NPCPSQSkinColor")
	EndEvent
	Event OnHighlightST()
		SetInfoText("$PSQ_SetSkinColorInfo")
	EndEvent
EndState

;Menu Options
State ConditionToKill
	Event OnMenuOpenST()
		String[] Option = New String[4]
		Option[0] = "$PSQ_Unconditional"
		Option[1] = "$PSQ_WhenAggressor"
		Option[2] = "$PSQ_WhenVictim"
		Option[3] = "$PSQ_WhenBoth"
		SetMenuDialogStartIndex(PSQ.ConditionToKill)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(Option)
	EndEvent
	Event OnMenuAcceptST(Int i)
		String[] Option = New String[4]
		Option[0] = "$PSQ_Unconditional"
		Option[1] = "$PSQ_WhenAggressor"
		Option[2] = "$PSQ_WhenVictim"
		Option[3] = "$PSQ_WhenBoth"
		PSQ.ConditionToKill = i
		SetMenuOptionValueST(Option[i])
	EndEvent
	Event OnHighlightST()
		If PSQ.ConditionToKill == 0
			SetInfoText("$PSQ_DeathConditionInfo1")
		ElseIf PSQ.ConditionToKill == 1
			SetInfoText("$PSQ_DeathConditionInfo2")	
		ElseIf PSQ.ConditionToKill == 2
			SetInfoText("$PSQ_DeathConditionInfo3")
		ElseIf PSQ.ConditionToKill == 3
			SetInfoText("$PSQ_DeathConditionInfo4")
		EndIf
	EndEvent
EndState
State ConditionToSoulTrap
	Event OnMenuOpenST()
		String[] Option = New String[4]
		Option[0] = "$PSQ_Unconditional"
		Option[1] = "$PSQ_WhenAggressor"
		Option[2] = "$PSQ_WhenVictim"
		Option[3] = "$PSQ_WhenBoth"
		SetMenuDialogStartIndex(PSQ.ConditionToSoulTrap)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(Option)
	EndEvent
	Event OnMenuAcceptST(Int i)
		String[] Option = New String[4]
		Option[0] = "$PSQ_Unconditional"
		Option[1] = "$PSQ_WhenAggressor"
		Option[2] = "$PSQ_WhenVictim"
		Option[3] = "$PSQ_WhenBoth"
		PSQ.ConditionToSoulTrap = i
		SetMenuOptionValueST(Option[i])
	EndEvent
	Event OnHighlightST()
		If PSQ.ConditionToSoulTrap == 0
			SetInfoText("$PSQ_SoulTrapConditionInfo1")
		ElseIf PSQ.ConditionToSoulTrap == 1
			SetInfoText("$PSQ_SoulTrapConditionInfo2")
		ElseIf PSQ.ConditionToSoulTrap == 2
			SetInfoText("$PSQ_SoulTrapConditionInfo3")
		ElseIf PSQ.ConditionToSoulTrap == 3
			SetInfoText("$PSQ_SoulTrapConditionInfo4")
		EndIf
	EndEvent
EndState
State PlayerHumanSchlong
	Event OnMenuOpenST()
		String[] Option = New String[5]
		Option[0] = PSQ.FemaleSchlongA.GetName()
		Option[1] = PSQ.FemaleSchlongB.GetName()
		Option[2] = PSQ.FemaleSchlongC.GetName()
		Option[3] = PSQ.FemaleSchlongD.GetName()
		Option[4] = PSQ.FemaleSchlongE.GetName()
		SetMenuDialogStartIndex(0)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(Option)
	EndEvent
	Event OnMenuAcceptST(Int i)
		Armor[] Schlong = New Armor[5]
		Schlong[0] = PSQ.FemaleSchlongA
		Schlong[1] = PSQ.FemaleSchlongB
		Schlong[2] = PSQ.FemaleSchlongC
		Schlong[3] = PSQ.FemaleSchlongD
		Schlong[4] = PSQ.FemaleSchlongE
		PSQ.PlayerHumanSchlong = Schlong[i]
		SetMenuOptionValueST(Schlong[i].GetName())
	EndEvent
EndState
State PlayerSuccubusSchlong
	Event OnMenuOpenST()
		String[] Option = New String[5]
		Option[0] = PSQ.FemaleSchlongA.GetName()
		Option[1] = PSQ.FemaleSchlongB.GetName()
		Option[2] = PSQ.FemaleSchlongC.GetName()
		Option[3] = PSQ.FemaleSchlongD.GetName()
		Option[4] = PSQ.FemaleSchlongE.GetName()
		SetMenuDialogStartIndex(0)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(Option)
	EndEvent
	Event OnMenuAcceptST(Int i)
		Armor[] Schlong = New Armor[5]
		Schlong[0] = PSQ.FemaleSchlongA
		Schlong[1] = PSQ.FemaleSchlongB
		Schlong[2] = PSQ.FemaleSchlongC
		Schlong[3] = PSQ.FemaleSchlongD
		Schlong[4] = PSQ.FemaleSchlongE
		PSQ.PlayerSuccubusSchlong = Schlong[i]
		SetMenuOptionValueST(Schlong[i].GetName())
	EndEvent
EndState
State SwitchWings
	Event OnMenuOpenST()
		String[] Option = New String[13]
		Option[0] = PSQ.SuccubusStaticWings.GetName()
		Option[1] = PSQ.SuccubusDragonWingsCommon.GetName()
		Option[2] = PSQ.SuccubusDragonWingsBoss.GetName()
		Option[3] = PSQ.SuccubusDragonWingsForest.GetName()
		Option[4] = PSQ.SuccubusDragonWingOdaviing.GetName()
		Option[5] = PSQ.SuccubusDragonWingsParthurnax.GetName()
		Option[6] = PSQ.SuccubusDragonWingsSnow.GetName()
		Option[7] = PSQ.SuccubusDragonWingsTundra.GetName()
		Option[8] = PSQ.SuccubusDragonWingsUnderskin.GetName()
		Option[9] = PSQ.SuccubusDragonWingsAlduin.GetName()
		Option[10] = PSQ.SuccubusDragonWingsBloody.GetName()
		Option[11] = PSQ.SuccubusDragonWingsRealFlying.GetName()
		Option[12] = PSQ.SuccubusFairyWings.GetName()
		SetMenuDialogStartIndex(0)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(Option)
	EndEvent
	Event OnMenuAcceptST(Int i)
		Bool HasWings = False
		If PSQ.PlayerRef.GetItemCount(PSQ.PSQSuccubusWings) > 0
			PSQ.PlayerRef.RemoveItem(PSQ.PSQSuccubusWings, PSQ.PlayerRef.GetItemCount(PSQ.PSQSuccubusWings), True)
			HasWings = True
		EndIf
		Armor[] Wing = New Armor[13]
		Wing[0] = PSQ.SuccubusStaticWings
		Wing[1] = PSQ.SuccubusDragonWingsCommon
		Wing[2] = PSQ.SuccubusDragonWingsBoss
		Wing[3] = PSQ.SuccubusDragonWingsForest
		Wing[4] = PSQ.SuccubusDragonWingOdaviing
		Wing[5] = PSQ.SuccubusDragonWingsParthurnax
		Wing[6] = PSQ.SuccubusDragonWingsSnow
		Wing[7] = PSQ.SuccubusDragonWingsTundra
		Wing[8] = PSQ.SuccubusDragonWingsUnderskin
		Wing[9] = PSQ.SuccubusDragonWingsAlduin
		Wing[10] = PSQ.SuccubusDragonWingsBloody
		Wing[11] = PSQ.SuccubusDragonWingsRealFlying
		Wing[12] = PSQ.SuccubusFairyWings
		PSQ.PSQSuccubusWings = Wing[i]
		If HasWings
			PSQ.PlayerRef.AddItem(PSQ.PSQSuccubusWings, 1, True)
			PSQ.PlayerRef.EquipItem(PSQ.PSQSuccubusWings, abSilent = True)
		EndIf
		SetMenuOptionValueST(Wing[i].GetName())
	EndEvent
EndState
State NPCSwitchWings
	Event OnMenuOpenST()
		String[] Option = New String[13]
		Option[0] = PSQ.SuccubusStaticWings.GetName()
		Option[1] = PSQ.SuccubusDragonWingsCommon.GetName()
		Option[2] = PSQ.SuccubusDragonWingsBoss.GetName()
		Option[3] = PSQ.SuccubusDragonWingsForest.GetName()
		Option[4] = PSQ.SuccubusDragonWingOdaviing.GetName()
		Option[5] = PSQ.SuccubusDragonWingsParthurnax.GetName()
		Option[6] = PSQ.SuccubusDragonWingsSnow.GetName()
		Option[7] = PSQ.SuccubusDragonWingsTundra.GetName()
		Option[8] = PSQ.SuccubusDragonWingsUnderskin.GetName()
		Option[9] = PSQ.SuccubusDragonWingsAlduin.GetName()
		Option[10] = PSQ.SuccubusDragonWingsBloody.GetName()
		Option[11] = PSQ.SuccubusDragonWingsRealFlying.GetName()
		Option[12] = PSQ.SuccubusFairyWings.GetName()
		SetMenuDialogStartIndex(0)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(Option)
	EndEvent
	Event OnMenuAcceptST(Int i)
		Armor NPCWings = GetFormValue(SuccubusNPC, "PSQ_NPCWings") as Armor
		Bool HasWings = False
		If SuccubusNPC.GetItemCount(NPCWings) > 0
			SuccubusNPC.RemoveItem(NPCWings, SuccubusNPC.GetItemCount(NPCWings), True)
			HasWings = True
		EndIf
		Armor[] Wing = New Armor[13]
		Wing[0] = PSQ.SuccubusStaticWings
		Wing[1] = PSQ.SuccubusDragonWingsCommon
		Wing[2] = PSQ.SuccubusDragonWingsBoss
		Wing[3] = PSQ.SuccubusDragonWingsForest
		Wing[4] = PSQ.SuccubusDragonWingOdaviing
		Wing[5] = PSQ.SuccubusDragonWingsParthurnax
		Wing[6] = PSQ.SuccubusDragonWingsSnow
		Wing[7] = PSQ.SuccubusDragonWingsTundra
		Wing[8] = PSQ.SuccubusDragonWingsUnderskin
		Wing[9] = PSQ.SuccubusDragonWingsAlduin
		Wing[10] = PSQ.SuccubusDragonWingsBloody
		Wing[11] = PSQ.SuccubusDragonWingsRealFlying
		Wing[12] = PSQ.SuccubusFairyWings
		NPCWings = Wing[i]
		If HasWings
			SuccubusNPC.AddItem(NPCWings, 1, True)
			SuccubusNPC.EquipItem(NPCWings, abSilent = True)
		EndIf
		SetFormValue(SuccubusNPC, "PSQ_NPCWings", NPCWings)
		SetMenuOptionValueST(Wing[i].GetName())
	EndEvent
EndState

;Slider Options
State AutoExtractSemenPotionThreshold
	Event OnSliderOpenST()
		SetSliderDialogStartValue(PSQ.AutoExtractSemenPotionThreshold)
		SetSliderDialogDefaultValue(80.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(Float Value)
		PSQ.AutoExtractSemenPotionThreshold = Value
		SetSliderOptionValueST(Value, "{0}%")
	EndEvent
	Event OnHighlightST()
		SetInfoText("$PSQ_SuccubusEPACThresholdInfo")
	EndEvent
EndState
State FastModeTime
	Event OnSliderOpenST()
		SetSliderDialogStartValue(PSQ.FastModeTime)
		SetSliderDialogDefaultValue(60.0)
		SetSliderDialogRange(0.0, 300.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(Float Value)
		PSQ.FastModeTime = Value
		SetSliderOptionValueST(Value, "{0}")
	EndEvent
EndState
State CalcMaxEnergyHealth
	Event OnSliderOpenST()
		SetSliderDialogStartValue(PSQ.CalcMaxEnergyHealth)
		SetSliderDialogDefaultValue(3.0)
		SetSliderDialogRange(0.0, 7.0)
		SetSliderDialogInterval(0.1)
	EndEvent
	Event OnSliderAcceptST(Float Value)
		PSQ.CalcMaxEnergyHealth = Value
		SetSliderOptionValueST(Value, "{1}")
	EndEvent
EndState
State MinEnergyOfHuman
	Event OnSliderOpenST()
		SetSliderDialogStartValue(PSQ.MinEnergyOfHuman)
		SetSliderDialogDefaultValue(500.0)
		SetSliderDialogRange(50.0, 2000.0)
		SetSliderDialogInterval(10.0)
	EndEvent
	Event OnSliderAcceptST(Float Value)
		PSQ.MinEnergyOfHuman = Value
		SetSliderOptionValueST(Value, "{0}")
	EndEvent
EndState
State LoversRestoreMult
	Event OnSliderOpenST()
		SetSliderDialogStartValue(PSQ.LoversRestoreMult)
		SetSliderDialogDefaultValue(1.5)
		SetSliderDialogRange(1.0, 3.0)
		SetSliderDialogInterval(0.1)
	EndEvent
	Event OnSliderAcceptST(Float Value)
		PSQ.LoversRestoreMult = Value
		SetSliderOptionValueST(Value, "{1}")
	EndEvent
EndState
State LoversDrainMult
	Event OnSliderOpenST()
		SetSliderDialogStartValue(PSQ.LoversDrainMult)
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(1.0, 3.0)
		SetSliderDialogInterval(0.1)
	EndEvent
	Event OnSliderAcceptST(Float Value)
		PSQ.LoversDrainMult = Value
		SetSliderOptionValueST(Value, "{1}")
	EndEvent
EndState
State DrainValueMultipliers
	Event OnSliderOpenST()
		SetSliderDialogStartValue(PSQ.DrainValueMultipliers)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.05, 3.0)
		SetSliderDialogInterval(0.05)
	EndEvent
	Event OnSliderAcceptST(Float Value)
		PSQ.DrainValueMultipliers = Value
		SetSliderOptionValueST(Value, "{2}")
	EndEvent
	Event OnHighlightST()
		SetInfoText("$PSQ_DrainValueMultipliersInfo")
	EndEvent
EndState
State EXPGainedMultipliers
	Event OnSliderOpenST()
		SetSliderDialogStartValue(PSQ.EXPGainedMultipliers)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.05, 3.0)
		SetSliderDialogInterval(0.05)
	EndEvent
	Event OnSliderAcceptST(Float Value)
		PSQ.EXPGainedMultipliers = Value
		SetSliderOptionValueST(Value, "{2}")
	EndEvent
	Event OnHighlightST()
		SetInfoText("$PSQ_EXPGainedMultipliersInfo")
	EndEvent
EndState

;スライダーを開いた時のやつ
Event OnSliderOpenST()
	String Option = GetState()
	If Option == "RapeArousalThreshold"
		SetSliderDialogStartValue(PSQ.RapeArousalThreshold as Int)
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == "RapeHealthThreshold"
		SetSliderDialogStartValue(PSQ.RapeHealthThreshold)
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == "RapeChance"
		SetSliderDialogStartValue(PSQ.RapeChance)
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == "RestoreMagickaMAX"
		SetSliderDialogStartValue(PSQ.RestoreMagickaMAX)
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 3000.0)
		SetSliderDialogInterval(10.0)
	ElseIf Option == "WingMaxJumpHeight"
		SetSliderDialogStartValue(PSQ.WingMaxJumpHeight)
		SetSliderDialogDefaultValue(299.0)
		SetSliderDialogRange(80, 2000.0)
		SetSliderDialogInterval(20.0)
	ElseIf Option == "DefaultJumpHeight"
		SetSliderDialogStartValue(PSQ.WingMaxJumpHeight)
		SetSliderDialogDefaultValue(76.0)
		SetSliderDialogRange(0, 200.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == "EnergyConsumptionPerMax"
		SetSliderDialogStartValue(PSQ.EnergyConsumptionPerMax)
		SetSliderDialogDefaultValue(14.0)
		SetSliderDialogRange(0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == "CanFlyingLevel"
		SetSliderDialogStartValue(PSQ.CanFlyingLevel)
		SetSliderDialogDefaultValue(4.0)
		SetSliderDialogRange(1.0, 8.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == "HenshinBuffRateHealth"
		SetSliderDialogStartValue(PSQ.HenshinBuffRateHealth)
		SetSliderDialogDefaultValue(30.0)
		SetSliderDialogRange(0.00, 200.0)
		SetSliderDialogInterval(5.00)
	ElseIf Option == "HenshinBuffRateMagicka"
		SetSliderDialogStartValue(PSQ.HenshinBuffRateMagicka)
		SetSliderDialogDefaultValue(30.0)
		SetSliderDialogRange(0.00, 200.0)
		SetSliderDialogInterval(5.00)
	ElseIf Option == "HenshinBuffRateStamina"
		SetSliderDialogStartValue(PSQ.HenshinBuffRateStamina)
		SetSliderDialogDefaultValue(30.0)
		SetSliderDialogRange(0.00, 200.0)
		SetSliderDialogInterval(5.00)
	ElseIf Option == "HenshinBuffRateCarry"
		SetSliderDialogStartValue(PSQ.HenshinBuffRateCarry)
		SetSliderDialogDefaultValue(30.0)
		SetSliderDialogRange(0.00, 200.0)
		SetSliderDialogInterval(5.00)
	ElseIf Option == "SuccubusArmorMagnitude"
		SetSliderDialogStartValue(PSQ.SuccubusArmorMagnitude)
		SetSliderDialogDefaultValue(50.0)
		SetSliderDialogRange(0.00, 500.0)
		SetSliderDialogInterval(5.00)
	ElseIf Option == "CumInflationIncrement"
		SetSliderDialogStartValue(PSQ.CumInflationIncrement)
		SetSliderDialogDefaultValue(15.0)
		SetSliderDialogRange(1.0, 100.0)
		SetSliderDialogInterval(5.0)
	ElseIf Option == "RequiredToFluid"
		SetSliderDialogStartValue(PSQ.RequiredToFluid)
		SetSliderDialogDefaultValue(30.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == "TransformThreshold"
		SetSliderDialogStartValue(PSQ.TransformThreshold)
		SetSliderDialogDefaultValue(90.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == "DeTransformThreshold"
		SetSliderDialogStartValue(PSQ.DeTransformThreshold)
		SetSliderDialogDefaultValue(30.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == "ChargeValueAuto"
		SetSliderDialogStartValue(PSQ.ChargeValueAuto)
		SetSliderDialogDefaultValue(1000.0)
		SetSliderDialogRange(0.0, 10000.0)
		SetSliderDialogInterval(500.0)
	ElseIf Option == "EnergyBarX"
		SetSliderDialogStartValue(SEBU.EnergyBarX)
		SetSliderDialogDefaultValue(495.0)
		SetSliderDialogRange(0.0, 1280.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == "EnergyBarY"
		SetSliderDialogStartValue(SEBU.EnergyBarY)
		SetSliderDialogDefaultValue(700.0)
		SetSliderDialogRange(0.0, 720.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == "ColorChangeThreshould01"
		SetSliderDialogStartValue(SEBU.ColorChangeThreshould01 * 100)
		SetSliderDialogDefaultValue(85.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == "ColorChangeThreshould02"
		SetSliderDialogStartValue(SEBU.ColorChangeThreshould02 * 100)
		SetSliderDialogDefaultValue(85.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == "ColorChangeThreshould03"
		SetSliderDialogStartValue(SEBU.ColorChangeThreshould03 * 100)
		SetSliderDialogDefaultValue(85.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == "FertilisationProbability"
		SetSliderDialogStartValue(PSQ.FertilisationProbability as Float)
		SetSliderDialogDefaultValue(5.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == "SuccubusNightEyeStrength"
		SetSliderDialogStartValue(PSQ.SuccubusNightEyeStrength)
		SetSliderDialogDefaultValue(0.5)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf Option == "BellyScaleMax"
		SetSliderDialogStartValue(PSQ.BellyScaleMax)
		SetSliderDialogDefaultValue(7.0)
		SetSliderDialogRange(1.0, 100.0)
		SetSliderDialogInterval(0.01)
	ElseIf Option == "SuccubusHeight"
		SetSliderDialogStartValue(PSQ.SuccubusHeight)
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.01, 5.0)
		SetSliderDialogInterval(0.01)
	ElseIf Option == "SuccubusBreast"
		SetSliderDialogStartValue(PSQ.SuccubusBreast)
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.01, 5.0)
		SetSliderDialogInterval(0.01)
	ElseIf Option == "BreastScaleMax"
		SetSliderDialogStartValue(PSQ.BreastScaleMax)
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.01, 5.0)
		SetSliderDialogInterval(0.01)
	ElseIf Option == "SuccubusButt"
		SetSliderDialogStartValue(PSQ.SuccubusButt)
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.01, 5.0)
		SetSliderDialogInterval(0.01)
	ElseIf Option == "SuccubusGenitals"
		SetSliderDialogStartValue(PSQ.SuccubusGenitals)
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.01, 5.0)
		SetSliderDialogInterval(0.01)
	ElseIf Option == "SuccubusScrotum"
		SetSliderDialogStartValue(PSQ.SuccubusScrotum)
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.01, 5.0)
		SetSliderDialogInterval(0.01)
	ElseIf Option == "SpeedDecreaseMax"
		SetSliderDialogStartValue(SGI.SpeedDecreaseMax)
		SetSliderDialogDefaultValue(70.0)
		SetSliderDialogRange(1.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == "HenshinSkinColorfulness"
		SetSliderDialogStartValue(PSQ.PSQSkinColorAlpha)
		SetSliderDialogDefaultValue(255.0)
		SetSliderDialogRange(0.0, 255.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == "MaxEnergyAtAltMode"
		SetSliderDialogStartValue(PSQ.MaxEnergyAtAltMode)
		SetSliderDialogDefaultValue(1000.0)
		SetSliderDialogRange(100.0, 5000.0)
		SetSliderDialogInterval(50.0)
	ElseIf Option == "HealthBuffInc"
		SetSliderDialogStartValue((PSQ.HealthBuffInc - PSQ.HealthBuffDec) * 100)
		SetSliderDialogDefaultValue(25.0)
		SetSliderDialogRange(-100.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == "HealthBuffDec"
		SetSliderDialogStartValue(-PSQ.HealthBuffDec * 100)
		SetSliderDialogDefaultValue(-30.0)
		SetSliderDialogRange(-100.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == "MagickaBuffInc"
		SetSliderDialogStartValue((PSQ.MagickaBuffInc - PSQ.MagickaBuffDec) * 100)
		SetSliderDialogDefaultValue(40.0)
		SetSliderDialogRange(-100.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == "MagickaBuffDec"
		SetSliderDialogStartValue(-PSQ.MagickaBuffDec * 100)
		SetSliderDialogDefaultValue(-25.0)
		SetSliderDialogRange(-100.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == "StaminaBuffInc"
		SetSliderDialogStartValue((PSQ.StaminaBuffInc - PSQ.StaminaBuffDec) * 100)
		SetSliderDialogDefaultValue(25.0)
		SetSliderDialogRange(-100.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == "StaminaBuffDec"
		SetSliderDialogStartValue(-PSQ.StaminaBuffDec * 100)
		SetSliderDialogDefaultValue(-30.0)
		SetSliderDialogRange(-100.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == "HealthRateBuffInc"
		SetSliderDialogStartValue(PSQ.HealthRateBuffInc - PSQ.HealthRateBuffDec)
		SetSliderDialogDefaultValue(70.0)
		SetSliderDialogRange(-200.0, 200.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == "HealthRateBuffDec"
		SetSliderDialogStartValue(-PSQ.HealthRateBuffDec)
		SetSliderDialogDefaultValue(-100.0)
		SetSliderDialogRange(-200.0, 200.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == "MagickaRateBuffInc"
		SetSliderDialogStartValue(PSQ.MagickaRateBuffInc - PSQ.MagickaRateBuffDec)
		SetSliderDialogDefaultValue(70.0)
		SetSliderDialogRange(-200.0, 200.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == "MagickaRateBuffDec"
		SetSliderDialogStartValue(-PSQ.MagickaRateBuffDec)
		SetSliderDialogDefaultValue(-100.0)
		SetSliderDialogRange(-200.0, 200.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == "StaminaRateBuffInc"
		SetSliderDialogStartValue(PSQ.StaminaRateBuffInc - PSQ.StaminaRateBuffDec)
		SetSliderDialogDefaultValue(70.0)
		SetSliderDialogRange(-200.0, 200.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == "StaminaRateBuffDec"
		SetSliderDialogStartValue(-PSQ.StaminaRateBuffDec)
		SetSliderDialogDefaultValue(-100.0)
		SetSliderDialogRange(-200.0, 200.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == "SpeedBuffInc"
		SetSliderDialogStartValue(PSQ.SpeedBuffInc - PSQ.SpeedBuffDec)
		SetSliderDialogDefaultValue(40.0)
		SetSliderDialogRange(-100.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == "SpeedBuffDec"
		SetSliderDialogStartValue(-PSQ.SpeedBuffDec)
		SetSliderDialogDefaultValue(-30.0)
		SetSliderDialogRange(-100.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == "FortifyDestructionMult"
		SetSliderDialogStartValue(PSQ.FortifyDestructionMult * 100)
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 200.0)
	ElseIf Option == "FortifyIllusionMult"
		SetSliderDialogStartValue(PSQ.FortifyIllusionMult * 100)
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 200.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == "MagicResistanceMult"
		SetSliderDialogStartValue(PSQ.MagicResistanceMult * 100)
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 200.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == "NPCSuccubusHeight"
		SetSliderDialogStartValue(GetFloatValue(SuccubusNPC, "PSQ_NPCTransformHeight"))
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.01, 5.0)
		SetSliderDialogInterval(0.01)
	ElseIf Option == "NPCSuccubusBreast"
		SetSliderDialogStartValue(GetFloatValue(SuccubusNPC, "PSQ_NPCTransformBreast"))
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.01, 5.0)
		SetSliderDialogInterval(0.01)
	ElseIf Option == "NPCSuccubusButt"
		SetSliderDialogStartValue(GetFloatValue(SuccubusNPC, "PSQ_NPCTransformButt"))
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.01, 5.0)
		SetSliderDialogInterval(0.01)
	ElseIf Option == "NPCSuccubusGenitals"
		SetSliderDialogStartValue(GetFloatValue(SuccubusNPC, "PSQ_NPCTransformGenitals"))
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.01, 5.0)
		SetSliderDialogInterval(0.01)
	ElseIf Option == "NPCSuccubusScrotum"
		SetSliderDialogStartValue(GetFloatValue(SuccubusNPC, "PSQ_NPCTransformScrotum"))
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.01, 5.0)
		SetSliderDialogInterval(0.01)
	EndIf
EndEvent

;スライダーの値を決定するやつ
Event OnSliderAcceptST(Float Value)
	String Option = GetState()
	If Option == "RapeArousalThreshold"
		PSQ.RapeArousalThreshold = Value as Int
		SetSliderOptionValueST(Value, "{0} %")
	ElseIf Option == "RapeHealthThreshold"
		PSQ.RapeHealthThreshold = Value
		SetSliderOptionValueST(Value, "{0} %")
	ElseIf Option == "RapeChance"
		PSQ.RapeChance = Value
		SetSliderOptionValueST(Value, "{0} %")
	ElseIf Option == "RestoreMagickaMAX"
		PSQ.RestoreMagickaMAX = Value
		SetSliderOptionValueST(Value, "{0}")
	ElseIf Option == "WingMaxJumpHeight"
		PSQ.WingMaxJumpHeight = Value
		SetSliderOptionValueST(Value, "{0}")
	ElseIf Option == "DefaultJumpHeight"
		PSQ.DefaultJumpHeight = Value
		SetSliderOptionValueST(Value, "{0}")
	ElseIf Option == "CanFlyingLevel"
		PSQ.CanFlyingLevel = Value as Int
		SetSliderOptionValueST(Value, "{0}")
	ElseIf Option == "EnergyConsumptionPerMax"
		PSQ.EnergyConsumptionPerMax = Value
		PSQ.EnergyConsumption = PSQ.MaxEnergy * PSQ.EnergyConsumptionPerMax / 100
		SetSliderOptionValueST(Value, "{0} %")
	ElseIf Option == "HenshinBuffRateHealth"
		PSQ.HenshinBuffRateHealth = Value
		SetSliderOptionValueST(Value, "{0} %")
	ElseIf Option == "HenshinBuffRateMagicka"
		PSQ.HenshinBuffRateMagicka = Value
		SetSliderOptionValueST(Value, "{0} %")
	ElseIf Option == "HenshinBuffRateStamina"
		PSQ.HenshinBuffRateStamina = Value
		SetSliderOptionValueST(Value, "{0} %")
	ElseIf Option == "HenshinBuffRateCarry"
		PSQ.HenshinBuffRateCarry = Value
		SetSliderOptionValueST(Value, "{0} %")
	ElseIf Option == "SuccubusArmorMagnitude"
		PSQ.SuccubusArmorMagnitude = Value
		SetSliderOptionValueST(Value, "{0}")
	ElseIf Option == "TransformThreshold"
		PSQ.TransformThreshold = Value
		SetSliderOptionValueST(Value, "{0}")
	ElseIf Option == "DeTransformThreshold"
		PSQ.DeTransformThreshold = Value
		SetSliderOptionValueST(Value, "{0}")
	ElseIf Option == "ChargeValueAuto"
		PSQ.ChargeValueAuto = Value
		SetSliderOptionValueST(Value, "{0}")
	ElseIf Option == "CumInflationIncrement"
		PSQ.CumInflationIncrement = Value
		SetSliderOptionValueST(Value, "{0}")
	ElseIf Option == "RequiredToFluid"
		PSQ.RequiredToFluid = Value
		SetSliderOptionValueST(Value, "{0}")
	ElseIf Option == "EnergyBarX"
		SEBU.EnergyBarX = Value
		SEBU.UpdateEnergyBarPosition()
		SetSliderOptionValueST(Value, "{0}")
	ElseIf Option == "EnergyBarY"
		SEBU.EnergyBarY = Value
		SEBU.UpdateEnergyBarPosition()
		SetSliderOptionValueST(Value, "{0}")
	ElseIf Option == "ColorChangeThreshould01"
		SEBU.ColorChangeThreshould01 = Value / 100
		SetSliderOptionValueST(Value, "{0} %")
	ElseIf Option == "ColorChangeThreshould02"
		SEBU.ColorChangeThreshould02 = Value / 100
		SetSliderOptionValueST(Value, "{0} %")
	ElseIf Option == "ColorChangeThreshould03"
		SEBU.ColorChangeThreshould03 = Value / 100
		SetSliderOptionValueST(Value, "{0} %")
	ElseIf Option == "FertilisationProbability"
		PSQ.FertilisationProbability = Value as Int
		SetSliderOptionValueST(Value, "{0} %")
	ElseIf Option == "SuccubusNightEyeStrength"
		PSQ.SuccubusNightEyeStrength = Value
		SetSliderOptionValueST(Value, "{2}")
	ElseIf Option == "BellyScaleMax"
		PSQ.BellyScaleMax = Value
		PSQ.SetBellyScale()
		SetSliderOptionValueST(Value, "{2}")
	ElseIf Option == "SuccubusHeight"
		PSQ.SuccubusHeight = Value
		If PSQ.IsHenshined
			PSQ.SetScaleSuccubus()
		EndIf
		SetSliderOptionValueST(Value, "{2}")
	ElseIf Option == "SuccubusBreast"
		PSQ.SuccubusBreast = Value
		If PSQ.IsHenshined
			PSQ.SetBreastScaleSuccubus()
		EndIf
		SetSliderOptionValueST(Value, "{2}")
	ElseIf Option == "BreastScaleMax"
		PSQ.BreastScaleMax = Value
		If PSQ.IsHenshined
			PSQ.SetBreastScaleSuccubus()
		EndIf
		SetSliderOptionValueST(Value, "{2}")
	ElseIf Option == "SuccubusButt"
		PSQ.SuccubusButt = Value
		If PSQ.IsHenshined
			PSQ.SetScaleSuccubus()
		EndIf
		SetSliderOptionValueST(Value, "{2}")
	ElseIf Option == "SuccubusGenitals"
		PSQ.SuccubusGenitals = Value
		If PSQ.IsHenshined
			PSQ.SetScaleSuccubus()
		EndIf
		SetSliderOptionValueST(Value, "{2}")
	ElseIf Option == "SuccubusScrotum"
		PSQ.SuccubusScrotum = Value
		If PSQ.IsHenshined
			PSQ.SetScaleSuccubus()
		EndIf
		SetSliderOptionValueST(Value, "{2}")
	ElseIf Option == "SpeedDecreaseMax"
		SGI.SpeedDecreaseMax = Value
		SetSliderOptionValueST(Value, "{1}")
	ElseIf Option == "HenshinSkinColorfulness"
		PSQ.PSQSkinColorAlpha = Value as Int
		PSQ.PSQSkinColor = PSQ.PSQSkinColor + PSQ.PSQSkinColorAlpha * 16777216
		SetSliderOptionValueST(Value, "{0}")
	ElseIf Option == "MaxEnergyAtAltMode"
		PSQ.MaxEnergyAtAltMode = Value
		If PSQ.EnergyModeAlt
			PSQ.MaxEnergy = Value
			PSQ.EnergyConsumption = PSQ.MaxEnergy * PSQ.EnergyConsumptionPerMax / 100
		EndIf
		SetSliderOptionValueST(Value, "{0}")
	ElseIf Option == "HealthBuffInc"
		PSQ.HealthBuffInc = (Value / 100) + PSQ.HealthBuffDec
		SetSliderOptionValueST(Value, "{0} %")
	ElseIf Option == "HealthBuffDec"
		PSQ.HealthBuffInc = PSQ.HealthBuffInc - (Value / 100) - PSQ.HealthBuffDec
		PSQ.HealthBuffDec = - Value / 100
		SetSliderOptionValueST(Value, "{0} %")
	ElseIf Option == "MagickaBuffInc"
		PSQ.MagickaBuffInc = (Value / 100) + PSQ.MagickaBuffDec
		SetSliderOptionValueST(Value, "{0} %")
	ElseIf Option == "MagickaBuffDec"
		PSQ.MagickaBuffInc = PSQ.MagickaBuffInc - (Value / 100) - PSQ.MagickaBuffDec
		PSQ.MagickaBuffDec = - Value / 100
		SetSliderOptionValueST(Value, "{0} %")
	ElseIf Option == "StaminaBuffInc"
		PSQ.StaminaBuffInc = (Value / 100) + PSQ.StaminaBuffDec
		SetSliderOptionValueST(Value, "{0} %")
	ElseIf Option == "StaminaBuffDec"
		PSQ.StaminaBuffInc = PSQ.StaminaBuffInc - (Value / 100) - PSQ.StaminaBuffDec
		PSQ.StaminaBuffDec = - Value / 100
		SetSliderOptionValueST(Value, "{0} %")
	ElseIf Option == "HealthRateBuffInc"
		PSQ.HealthRateBuffInc = Value + PSQ.HealthRateBuffDec
		SetSliderOptionValueST(Value, "{0} %")
	ElseIf Option == "HealthRateBuffDec"
		PSQ.HealthRateBuffInc = PSQ.HealthRateBuffInc - Value - PSQ.HealthRateBuffDec
		PSQ.HealthRateBuffDec = - Value
		SetSliderOptionValueST(Value, "{0} %")
	ElseIf Option == "MagickaRateBuffInc"
		PSQ.MagickaRateBuffInc = Value + PSQ.MagickaRateBuffDec
		SetSliderOptionValueST(Value, "{0} %")
	ElseIf Option == "MagickaRateBuffDec"
		PSQ.MagickaRateBuffInc = PSQ.MagickaRateBuffInc - Value - PSQ.MagickaRateBuffDec
		PSQ.MagickaRateBuffDec = - Value
		SetSliderOptionValueST(Value, "{0} %")
	ElseIf Option == "StaminaRateBuffInc"
		PSQ.StaminaRateBuffInc = Value + PSQ.StaminaRateBuffDec
		SetSliderOptionValueST(Value, "{0} %")
	ElseIf Option == "StaminaRateBuffDec"
		PSQ.StaminaRateBuffInc = PSQ.StaminaRateBuffInc - Value - PSQ.StaminaRateBuffDec
		PSQ.StaminaRateBuffDec = - Value
		SetSliderOptionValueST(Value, "{0} %")
	ElseIf Option == "SpeedBuffInc"
		PSQ.SpeedBuffInc = Value + PSQ.SpeedBuffDec
		SetSliderOptionValueST(Value, "{0} %")
	ElseIf Option == "SpeedBuffDec"
		PSQ.SpeedBuffInc = PSQ.SpeedBuffInc - Value - PSQ.SpeedBuffDec
		PSQ.SpeedBuffDec = - Value
		SetSliderOptionValueST(Value, "{0} %")
	ElseIf Option == "FortifyDestructionMult"
		PSQ.FortifyDestructionMult = Value / 100
		SetSliderOptionValueST(Value, "{0} %")
	ElseIf Option == "FortifyIllusionMult"
		PSQ.FortifyIllusionMult = Value / 100
		SetSliderOptionValueST(Value, "{0} %")
	ElseIf Option == "MagicResistanceMult"
		PSQ.MagicResistanceMult = Value / 100
		SetSliderOptionValueST(Value, "{0} %")
	ElseIf Option == "NPCSuccubusHeight"
		SetFloatValue(SuccubusNPC, "PSQ_NPCTransformHeight", Value)
		SetSliderOptionValueST(Value, "{2}")
	ElseIf Option == "NPCSuccubusBreast"
		SetFloatValue(SuccubusNPC, "PSQ_NPCTransformBreast", Value)
		SetSliderOptionValueST(Value, "{2}")
	ElseIf Option == "NPCSuccubusButt"
		SetFloatValue(SuccubusNPC, "PSQ_NPCTransformButt", Value)
		SetSliderOptionValueST(Value, "{2}")
	ElseIf Option == "NPCSuccubusGenitals"
		SetFloatValue(SuccubusNPC, "PSQ_NPCTransformGenitals", Value)
		SetSliderOptionValueST(Value, "{2}")
	ElseIf Option == "NPCSuccubusScrotum"
		SetFloatValue(SuccubusNPC, "PSQ_NPCTransformScrotum", Value)
		SetSliderOptionValueST(Value, "{2}")
	EndIf
EndEvent

Event OnColorOpenST()
	String Option = GetState()
	If Option == "PSQSkinColor"
		SetColorDialogStartColor(PSQ.PSQSkinColor)
		SetColorDialogDefaultColor(PSQ.PSQSkinColor)
	ElseIf Option == "PSQSuccubusHairColorInt"
		SetColorDialogStartColor(PSQ.PSQSuccubusHairColorInt)
		SetColorDialogDefaultColor(PSQ.PSQSuccubusHairColorInt)
	ElseIf Option == "EnergyBarColor1A"
		SetColorDialogStartColor(SEBU.EnergyBarColor1A)
		SetColorDialogDefaultColor(SEBU.EnergyBarColor1A)
	ElseIf Option == "EnergyBarColor1B"
		SetColorDialogStartColor(SEBU.EnergyBarColor1B)
		SetColorDialogDefaultColor(SEBU.EnergyBarColor1B)
	ElseIf Option == "EnergyBarColor2A"
		SetColorDialogStartColor(SEBU.EnergyBarColor2A)
		SetColorDialogDefaultColor(SEBU.EnergyBarColor2A)
	ElseIf Option == "EnergyBarColor2B"
		SetColorDialogStartColor(SEBU.EnergyBarColor2B)
		SetColorDialogDefaultColor(SEBU.EnergyBarColor2B)
	ElseIf Option == "EnergyBarColor3A"
		SetColorDialogStartColor(SEBU.EnergyBarColor3A)
		SetColorDialogDefaultColor(SEBU.EnergyBarColor3A)
	ElseIf Option == "EnergyBarColor3B"
		SetColorDialogStartColor(SEBU.EnergyBarColor3B)
		SetColorDialogDefaultColor(SEBU.EnergyBarColor3B)
	ElseIf Option == "EnergyBarColor4A"
		SetColorDialogStartColor(SEBU.EnergyBarColor4A)
		SetColorDialogDefaultColor(SEBU.EnergyBarColor4A)
	ElseIf Option == "EnergyBarColor4B"
		SetColorDialogStartColor(SEBU.EnergyBarColor4B)
		SetColorDialogDefaultColor(SEBU.EnergyBarColor4B)
	ElseIf Option == "NPCPSQSkinColor"
		SetColorDialogStartColor(GetIntValue(SuccubusNPC, "PSQ_NPCTransformSkinColor"))
		SetColorDialogDefaultColor(GetIntValue(SuccubusNPC, "PSQ_NPCTransformSkinColor"))
	EndIf
EndEvent

Event OnColorAcceptST(Int Color)
	String Option = GetState()
	If Option == "PSQSkinColor"
		PSQ.PSQSkinColor = Color + PSQ.PSQSkinColorAlpha * 16777216
		SetColorOptionValueST(Color)
	ElseIf Option == "PSQSuccubusHairColorInt"
		PSQ.PSQSuccubusHairColorInt = Color
		PSQ.PSQSuccubusHairColor.SetColor(Color)
		SetColorOptionValueST(Color)
	ElseIf Option == "EnergyBarColor1A"
		SEBU.EnergyBarColor1A = Color
		SEBU.UpdateEnergyBarPosition()
		SetColorOptionValueST(Color)
	ElseIf Option == "EnergyBarColor1B"
		SEBU.EnergyBarColor1B = Color
		SEBU.UpdateEnergyBarPosition()
		SetColorOptionValueST(Color)
	ElseIf Option == "EnergyBarColor2A"
		SEBU.EnergyBarColor2A = Color
		SEBU.UpdateEnergyBarPosition()
		SetColorOptionValueST(Color)
	ElseIf Option == "EnergyBarColor2B"
		SEBU.EnergyBarColor2B = Color
		SEBU.UpdateEnergyBarPosition()
		SetColorOptionValueST(Color)
	ElseIf Option == "EnergyBarColor3A"
		SEBU.EnergyBarColor3A = Color
		SEBU.UpdateEnergyBarPosition()
		SetColorOptionValueST(Color)
	ElseIf Option == "EnergyBarColor3B"
		SEBU.EnergyBarColor3B = Color
		SEBU.UpdateEnergyBarPosition()
		SetColorOptionValueST(Color)
	ElseIf Option == "EnergyBarColor4A"
		SEBU.EnergyBarColor4A = Color
		SEBU.UpdateEnergyBarPosition()
		SetColorOptionValueST(Color)
	ElseIf Option == "EnergyBarColor4B"
		SEBU.EnergyBarColor4B = Color
		SEBU.UpdateEnergyBarPosition()
		SetColorOptionValueST(Color)
	ElseIf Option == "NPCPSQSkinColor"
		SetIntValue(SuccubusNPC, "PSQ_NPCTransformSkinColor", Color)
		NiOverride.AddNodeOverrideInt(SuccubusNPC, True, "Face [Ovl0]", 7, -1, Color, True)
		NiOverride.AddNodeOverrideInt(SuccubusNPC, True, "Body [Ovl0]", 7, -1, Color, True)
		NiOverride.AddNodeOverrideInt(SuccubusNPC, True, "Feet [Ovl0]", 7, -1, Color, True)
		NiOverride.AddNodeOverrideInt(SuccubusNPC, True, "Hands [Ovl0]", 7, -1, Color, True)
		SetColorOptionValueST(Color)
	EndIf
EndEvent

Event OnKeyMapChangeST(Int KeyCode, String ConflictControl, String ConflictName)
	String Option = GetState()
	If Option == "HotkeyEnableDrain"
		If !KeyConflict(KeyCode, ConflictControl, ConflictName)
			PSQ.HotkeyEnableDrain = KeyCode
			SetKeyMapOptionValueST(PSQ.HotkeyEnableDrain)
		EndIf
	ElseIf Option == "HotkeyAllowKill"
		If !KeyConflict(KeyCode, ConflictControl, ConflictName)
			PSQ.HotkeyAllowKill = KeyCode
			SetKeyMapOptionValueST(PSQ.HotkeyAllowKill)
		EndIf
	ElseIf Option == "HotkeyHenshin"
		If !KeyConflict(KeyCode, ConflictControl, ConflictName)
			PSQ.HotkeyHenshin = KeyCode
			SetKeyMapOptionValueST(PSQ.HotkeyHenshin)
		EndIf
	ElseIf Option == "HotkeySuccubusStats"
		If !KeyConflict(KeyCode, ConflictControl, ConflictName)
			PSQ.HotkeySuccubusStats = KeyCode
			SetKeyMapOptionValueST(PSQ.HotkeySuccubusStats)
		EndIf
	ElseIf Option == "HotkeySuccubusCharmSpell"
		If !KeyConflict(KeyCode, ConflictControl, ConflictName)
			PSQ.HotkeySuccubusCharmSpell = KeyCode
			SetKeyMapOptionValueST(PSQ.HotkeySuccubusCharmSpell)
		EndIf
	ElseIf Option == "HotkeyMasturbation"
		If !KeyConflict(KeyCode, ConflictControl, ConflictName)
			PSQ.HotkeyMasturbation = KeyCode
			SetKeyMapOptionValueST(PSQ.HotkeyMasturbation)
		EndIf
	ElseIf Option == "HotkeyRestoreMagicka"
		If !KeyConflict(KeyCode, ConflictControl, ConflictName)
			PSQ.HotkeyRestoreMagicka = KeyCode
			SetKeyMapOptionValueST(PSQ.HotkeyRestoreMagicka)
		EndIf
	ElseIf Option == "HotkeyExtractSemenPotion"
		If !KeyConflict(KeyCode, ConflictControl, ConflictName)
			PSQ.HotkeyExtractSemenPotion = KeyCode
			SetKeyMapOptionValueST(PSQ.HotkeyExtractSemenPotion)
		EndIf
	ElseIf Option == "HotkeyEnableSoulTrap"
		If !KeyConflict(KeyCode, ConflictControl, ConflictName)
			PSQ.HotkeyEnableSoulTrap = KeyCode
			SetKeyMapOptionValueST(PSQ.HotkeyEnableSoulTrap)
		EndIf
	ElseIf Option == "HotkeyCreatePenisSelf"
		If !KeyConflict(KeyCode, ConflictControl, ConflictName)
			PSQ.HotkeyCreatePenisSelf = KeyCode
			SetKeyMapOptionValueST(PSQ.HotkeyCreatePenisSelf)
		EndIf
	ElseIf Option == "HotkeyEnergyBar"
		If !KeyConflict(KeyCode, ConflictControl, ConflictName)
			PSQ.HotkeyEnergyBar = KeyCode
			SetKeyMapOptionValueST(PSQ.HotkeyEnergyBar)
		EndIf
	ElseIf Option == "HotkeyNightEye"
		If !KeyConflict(KeyCode, ConflictControl, ConflictName)
			PSQ.HotkeyNightEye = KeyCode
			SetKeyMapOptionValueST(PSQ.HotkeyNightEye)
		EndIf
	ElseIf Option == "HotkeyDetectArousal"
		If !KeyConflict(KeyCode, ConflictControl, ConflictName)
			PSQ.HotkeyDetectArousal = KeyCode
			SetKeyMapOptionValueST(PSQ.HotkeyDetectArousal)
		EndIf
	ElseIf Option == "HotkeyToggleFlying"
		If !KeyConflict(KeyCode, ConflictControl, ConflictName)
			PSQ.HotkeyToggleFlying = KeyCode
			SetKeyMapOptionValueST(PSQ.HotkeyToggleFlying)
		EndIf
	ElseIf Option == "HotkeyIncreaseNode"
		If !KeyConflict(KeyCode, ConflictControl, ConflictName)
			PSQ.HotkeyIncreaseNode = KeyCode
			SetKeyMapOptionValueST(PSQ.HotkeyIncreaseNode)
		EndIf
	ElseIf Option == "HotkeyDecreaseNode"
		If !KeyConflict(KeyCode, ConflictControl, ConflictName)
			PSQ.HotkeyDecreaseNode = KeyCode
			SetKeyMapOptionValueST(PSQ.HotkeyDecreaseNode)
		EndIf
	ElseIf Option == "HotkeyHeight"
		If !KeyConflict(KeyCode, ConflictControl, ConflictName)
			PSQ.HotkeyHeight = KeyCode
			SetKeyMapOptionValueST(PSQ.HotkeyHeight)
		EndIf
	ElseIf Option == "HotkeyBreastNode"
		If !KeyConflict(KeyCode, ConflictControl, ConflictName)
			PSQ.HotkeyBreastNode = KeyCode
			SetKeyMapOptionValueST(PSQ.HotkeyBreastNode)
		EndIf
	ElseIf Option == "HotkeyButtNode"
		If !KeyConflict(KeyCode, ConflictControl, ConflictName)
			PSQ.HotkeyButtNode = KeyCode
			SetKeyMapOptionValueST(PSQ.HotkeyButtNode)
		EndIf
	ElseIf Option == "HotkeyGenitalsNode"
		If !KeyConflict(KeyCode, ConflictControl, ConflictName)
			PSQ.HotkeyGenitalsNode = KeyCode
			SetKeyMapOptionValueST(PSQ.HotkeyGenitalsNode)
		EndIf
	ElseIf Option == "HotkeyScrotumNode"
		If !KeyConflict(KeyCode, ConflictControl, ConflictName)
			PSQ.HotkeyScrotumNode = KeyCode
			SetKeyMapOptionValueST(PSQ.HotkeyScrotumNode)
		EndIf
	ElseIf Option == "HotkeyDigestion"
		If !KeyConflict(KeyCode, ConflictControl, ConflictName)
			PSQ.HotkeyDigestion = KeyCode
			SetKeyMapOptionValueST(PSQ.HotkeyDigestion)
		EndIf
	EndIf
	PSQ.ReloadHotkeys()
EndEvent

Event OnHighlightST()
	String Option = GetState()
	If Option == "EnableDrain"
		If PSQ.EnableDrain
			SetInfoText("$PSQ_EnableDrainInfo1")
		Else
			SetInfoText("$PSQ_EnableDrainInfo2")
		EndIf
	ElseIf Option == "AllowDrainFromFemale"
		If !PSQ.AllowDrainFromFemale
			SetInfoText("$PSQ_EnableDrainFemaleInfo1")
		Else
			SetInfoText("$PSQ_EnableDrainFemaleInfo2")
		EndIf
	ElseIf Option == "AllowDrainFromBeast"
		If !PSQ.AllowDrainFromBeast
			SetInfoText("$PSQ_EnableDrainBeastInfo1")
		Else
			SetInfoText("$PSQ_EnableDrainBeastInfo2")
		EndIf
	ElseIf Option == "AllowDrainFromUndead"
		If !PSQ.AllowDrainFromUndead
			SetInfoText("$PSQ_EnableDrainUndeadInfo1")
		Else
			SetInfoText("$PSQ_EnableDrainUndeadInfo2")
		EndIf
	ElseIf Option == "ExtractSemenPotion"
		If !PSQ.ExtractSemenPotion
			SetInfoText("$PSQ_EnableSemenPotionInfo1")
		Else
			SetInfoText("$PSQ_EnableSemenPotionInfo2")
		EndIf
	ElseIf Option == "AutoExtractSemenPotion"
		SetInfoText("$PSQ_SuccubusExtractPotionAutoCheckInfo")
	ElseIf Option == "EnableSoulTrap"
		If !PSQ.EnableSoulTrap
			SetInfoText("$PSQ_EnableDrainSoulTrapInfo1")
		Else
			SetInfoText("$PSQ_EnableDrainSoulTrapInfo2")
		EndIf
	ElseIf Option == "AllowKill"
		If PSQ.AllowKill
			SetInfoText("$PSQ_EnableDrainDeathInfo1")
		Else
			SetInfoText("$PSQ_EnableDrainDeathInfo2")
		EndIf
	ElseIf Option == "EnableCaptive"
		SetInfoText("$PSQ_EnableCaptiveInfo")
	ElseIf Option == "UseArousalAtDrain"
		SetInfoText("$PSQ_UseArousalAtDrainInfo")
	ElseIf Option == "EnableSatiationNotification"
		If PSQ.EnableSatiationNotification
			SetInfoText("$PSQ_EnableNotificationInfo1")
		Else
			SetInfoText("$PSQ_EnableNotificationInfo2")
		EndIf
	ElseIf Option == "EnableStarvation"
		If PSQ.EnableStarvation
			SetInfoText("$PSQ_EnableStarvationDeathInfo1")
		Else
			SetInfoText("$PSQ_EnableStarvationDeathInfo2")
		EndIf
	ElseIf Option == "EnergyModeAlt"
		SetInfoText("$PSQ_EnergyModeAltInfo")
	ElseIf Option == "FluidNeedArousal"
		SetInfoText("$PSQ_FluidNeedArousalInfo")
	ElseIf Option == "HenshinIsCrime"
		SetInfoText("$PSQ_HenshinIsCrimeInfo")
	ElseIf Option == "HenshinFear"
		SetInfoText("$PSQ_HenshinFearInfo")
	ElseIf Option == "ArousedForceTransform"
		SetInfoText("$PSQ_ArousedForceTransformInfo")
	ElseIf Option == "ArousedForceDeTransform"
		SetInfoText("$PSQ_ArousedForceDeTransformInfo")
	ElseIf Option == "PhysicalWeakness"
		SetInfoText("$PSQ_PhysicalWeaknessInfo")
	ElseIf Option == "StopEnergyConsuming"
		If !PSQ.StopEnergyConsuming
			SetInfoText("$PSQ_PauseEnergyConsumingInfo1")
		Else
			SetInfoText("$PSQ_PauseEnergyConsumingInfo2")
		EndIf
	ElseIf Option == "EnergyConsumptionPerMax"
		SetInfoText("$PSQ_ConsumptionRateInfo")
	ElseIf Option == "WingMaxJumpHeight"
		SetInfoText("$PSQ_WingJumpHeightInfo")
	ElseIf Option == "RestoreMagickaMAX"
		SetInfoText("$PSQ_ConversionEnergyMagickaInfo")
	EndIf
EndEvent

;ロード時にレジスターしなおしたりPerkの値を再設定する作業
Event OnGameReload()
	Parent.OnGameReload()
	PSQ.PSQReload()
EndEvent

Function SetSpell(Spell akSpell, Int ReqRank)
	If PlayerIsSuccubus.GetValueInt() == 1
		If PSQ.PlayerRef.HasSpell(akSpell)
			PSQ.PlayerRef.RemoveSpell(akSpell)
		Else
			If SuccubusRank.GetValueInt() >= ReqRank
				PSQ.PlayerRef.AddSpell(akSpell, False)
			EndIf
		EndIf
	EndIf
EndFunction

String Function GetTitle()
	If SuccubusRank.GetValue() == 1
		Return "$PSQ_RankAndTitle1"
	ElseIf SuccubusRank.GetValue() == 2
		Return "$PSQ_RankAndTitle2"
	ElseIf SuccubusRank.GetValue() == 3
		Return "$PSQ_RankAndTitle3"
	ElseIf SuccubusRank.GetValue() == 4
		Return "$PSQ_RankAndTitle4"
	ElseIf SuccubusRank.GetValue() == 5
		Return "$PSQ_RankAndTitle5"
	ElseIf SuccubusRank.GetValue() == 6
		Return "$PSQ_RankAndTitle6"
	ElseIf SuccubusRank.GetValue() == 7
		Return "$PSQ_RankAndTitle7"
	ElseIf SuccubusRank.GetValue() == 8
		Return "$PSQ_RankAndTitle8"
	EndIf
	Return ""
EndFunction

String Function GetConditionalString(Int Cond)
	If Cond == 0
		Return "$PSQ_Unconditional"
	ElseIf Cond == 1
		Return "$PSQ_WhenAggressor"
	ElseIf Cond == 2
		Return "$PSQ_WhenVictim"
	ElseIf Cond == 3
		Return "$PSQ_WhenBoth"
	EndIf
	Return ""
EndFunction

Float Function GetNextExp()
	If SuccubusRank.GetValue() == 1
		Return 1000
	ElseIf SuccubusRank.GetValue() == 2
		Return 5000
	ElseIf SuccubusRank.GetValue() == 3
		Return 10000
	ElseIf SuccubusRank.GetValue() == 4
		Return 25000
	ElseIf SuccubusRank.GetValue() == 5
		Return 50000
	ElseIf SuccubusRank.GetValue() == 6
		Return 100000
	ElseIf SuccubusRank.GetValue() == 7
		Return 200000
	ElseIf SuccubusRank.GetValue() == 8
		Return 0
	EndIf
	Return 0
EndFunction

String Function GetBecomeSuccubusStrings()
	If PlayerIsSuccubus.GetValue() == 0
		Return "$PSQ_BecomeSuccubus"
	ElseIf PlayerIsSuccubus.GetValue() == 1
		Return "$PSQ_QuitSuccubus"
	EndIf
	Return ""
EndFunction

Bool function KeyConflict(Int KeyCode, String ConflictControl, String ConflictName)
	Bool Continue = True
	If ConflictControl != ""
		String Msg
		If ConflictName != ""
			Msg = "This key is already mapped to: \n'" + ConflictControl + "'\n(" + ConflictName + ")\n\nAre you sure you want to continue?"
		Else
			Msg = "This key is already mapped to: \n'" + ConflictControl + "'\n\nAre you sure you want to continue?"
		EndIf
		Continue = ShowMessage(Msg, True, "$Yes", "$No")
	EndIf
	Return !Continue
EndFunction
