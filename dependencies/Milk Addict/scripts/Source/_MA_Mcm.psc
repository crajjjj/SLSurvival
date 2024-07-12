Scriptname _MA_Mcm extends SKI_ConfigBase  

string[] DifficultyList
string[] DropTypeList
string[] Property SlutClothesDescrip Auto Hidden

event OnGameReload()
    parent.OnGameReload() ; Don't forget to call the parent!

endEvent

; MCM Config Begin =======================================================

event OnConfigInit()
	Pages = new string[6]
	Pages[0] = "Settings "
	Pages[1] = "Milk "
	Pages[2] = "Trip / Strip"
	Pages[3] = "NPC Milking"
	Pages[4] = "Food "
	Pages[5] = "Armor "
	
	DifficultyList = new string[3]
	DifficultyList[0] = "Easy "
	DifficultyList[1] = "Normal "
	DifficultyList[2] = "Hard "
	
	DropTypeList = new string[2]
	DropTypeList[0] = "Unequip "
	DropTypeList[1] = "Drop Safe "
	
	DropSlots = new Int[4]
	DroppedClothesAliases = new ReferenceAlias[4]
	SlutClothesDescrip = new string[8]
	SlutClothesDescrip[0] = "Prudish"
	SlutClothesDescrip[1] = "Conservative"
	SlutClothesDescrip[2] = "Modest"
	SlutClothesDescrip[3] = "Average"
	SlutClothesDescrip[4] = "Revealing"
	SlutClothesDescrip[5] = "Whoreish"
	SlutClothesDescrip[6] = "Slutty"
	SlutClothesDescrip[7] = "Immune"
	ConfigureDropSlots()
endEvent

event OnPageReset(string page)
	SetCursorFillMode(LEFT_TO_RIGHT)

	if(page == "Settings ")
		AddHeaderOption("State")
		AddEmptyOption()
		Float CurrentMilk = MME_Storage.getMilkCurrent(PlayerRef)
		Float MilkMax = MME_Storage.getMilkMaximum(PlayerRef) ; Milk Maid level 10, Cap = 24.0
		CurrentAddictionOID_T = AddTextOption("Current Addiction Pool: " + _MA_LactacidAddictionPool.GetValueInt(), "")
		AddEmptyOption()
		CurrentMilkOID_T = AddTextOption("Current Milk: " + CurrentMilk + " Units ", "")
		MilkCapMaxOID_T = AddTextOption("Current Capacity: " + MilkMax + " Units ", "")
		
		ClothesDurabilityOID_T = AddTextOption("Current Clothes Durability: " + Main.CurrentClothesDurabilty, "")
		If Main.CurrentSlutiness == -1
			ClothesSluttinessOID_T = AddTextOption("Current Clothes Sluttiness: Naked Slut", "")
		Else
			If Main.CurrentSlutiness == 0
				ClothesSluttinessOID_T = AddTextOption("Current Clothes Sluttiness: Not Initialized", "")
			Else
				ClothesSluttinessOID_T = AddTextOption("Current Clothes Sluttiness: " + SlutClothesDescrip[(Main.CurrentSlutiness)], "")
			EndIf
		EndIf

		BonusCapacityOID_T = AddTextOption("Slut Clothes Capacity Bonus: " + Main.SlutinessFactor + "% ", "")
		AddEmptyOption()
		
		AddHeaderOption("Settings")
		AddEmptyOption()
		AddictionDecayOID_S = AddSliderOption("Addiction Decay Per Hour: ", AddictionDecay, "{0}")
		CraftingDifficultyDB = AddMenuOption("Crafting Difficulty: ", DifficultyList[CraftingDifficulty], 0)
		ExportSettingsOID_T = AddTextOption("Export Settings ", "")
		ImportSettingsOID_T = AddTextOption("Import Settings", "")
		DropTypeDB = AddMenuOption("Drop Method: ", DropTypeList[DropType], 0)
		TimeToFindClothesOID_S = AddSliderOption("Time To Find Clothes: ", TimeToFindClothes, "{0}")
		CleavageSpellOID = AddToggleOption("Cleavage Spell", CleavageSpellT)
		CleavageMaxUnitsOID_S = AddSliderOption("Cleavage Max Milk: ", CleavageMaxUnits, "{0} Units")
		LeakyBoobsSoundTOID = AddToggleOption("Milk Leak Sound", LeakyBoobsSoundT)
		LeakyBoobsVolumeOID_S = AddSliderOption("Leak Sound Volume: ", LeakyBoobsVolume, "{0}% ")
		LactacidCeilingTOID = AddToggleOption("Lactacid Ceiling", LactacidCeilingT)
		LactacidCeilingOID_S = AddSliderOption("Lactacid Limit: ", LactacidCeiling, "{0} Units")
		BreastRopeFreqOffsetOID_S = AddSliderOption("Breast Rope Rate Offset: ", BreastRopeFreqOffset, "{0}")
		InvoluntaryActionsOID = AddToggleOption("Involuntary Actions", InvoluntaryActions)	
		RapeLactacidChanceOID_S = AddSliderOption("Chance Of Lactacid On Rape: ", RapeLactacidChance, "{0}%")
		AddEmptyOption()
		
		AddHeaderOption("Lactacid Required At Stage:")
		AddEmptyOption()
		RequiredLactMildOID_S = AddSliderOption("Mild: ", RequiredLactMild, "{1}")
		RequiredLactModerateOID_S = AddSliderOption("Moderate: ", RequiredLactModerate, "{1}")
		RequiredLactAddictOID_S = AddSliderOption("Addict: ", RequiredLactAddict, "{1}")
		RequiredLactJunkieOID_S = AddSliderOption("Junkie: ", RequiredLactJunkie, "{1}")
		
		If Init.SlifInstalled
			AddHeaderOption("SLIF Scaling")
			AddEmptyOption()
			SlifScalingOID = AddToggleOption("SLIF Scaling Enabled", SlifScaling)
			ResetSlifOID_T = AddTextOption("Reset Progress", "")
			AssMaxScaleOID_S = AddSliderOption("Max Ass Scale: ", AssMaxScale, "{1}")
			AssLactMultOID_S = AddSliderOption("Lactacid Ass Mult: ", AssLactMult, "{4}")
			BaseAssScaleOID = AddToggleOption("Base Ass Scale is 1.0", BaseAssScale)
			AddEmptyOption()
		EndIf
		
		AddHeaderOption("Creatures")
		AddEmptyOption()
		CreaturesEventsOID = AddToggleOption("Creature Events Allowed", CreatureEventsT)
		
	elseif(page == "Milk ")
		AddHeaderOption("After Effect Debuff")
		AddEmptyOption()
		AffterEffectDebuffMagMultOID_S = AddSliderOption("Multiply Magnitude By: ", AfterEffectMagMult, "{2}")
		AffterEffectDebuffDurMultOID_S = AddSliderOption("Multiply Duration By: ", AfterEffectDurMult, "{2}")
		
		If Init.AproposInstalled
			AddHeaderOption("Apropos ")
			AddEmptyOption()
			AproposHealBaseOID_S = AddSliderOption("W&T Heal Base: ", AproposHealBase, "{0}")
			AproposHealDeltaOID_S = AddSliderOption("W&T Heal Delta: ", AproposHealDelta, "{0}")
		EndIf
		
		AddHeaderOption("Addiction Gained From: ")
		AddEmptyOption()
		AddictivenessDiluteOID_S = AddSliderOption("Dilute Milk: ", AddictivenessDilute, "{0}")
		AddictivenessWeakOID_S = AddSliderOption("Weak Milk: ", AddictivenessWeak, "{0}")
		AddictivenessRegularOID_S = AddSliderOption("Regular Milk: ", AddictivenessRegular, "{0}")
		AddictivenessStrongOID_S = AddSliderOption("Strong Milk: ", AddictivenessStrong, "{0}")
		AddictivenessTastyOID_S = AddSliderOption("Tasty Milk: ", AddictivenessTasty, "{0}")
		AddictivenessCreamyOID_S = AddSliderOption("Creamy Milk: ", AddictivenessCreamy, "{0}")
		AddictivenessEnrichedOID_S = AddSliderOption("Enriched Milk: ", AddictivenessEnriched, "{0}")
		AddictivenessSublimeOID_S = AddSliderOption("Sublime Milk: ", AddictivenessSublime, "{0}")
		AddictivenessLactacidOID_S = AddSliderOption("Lactacid: ", AddictivenessLactacid, "{0}")
		AddEmptyOption()
		
		AddHeaderOption("Lactacid Provided By:")
		AddEmptyOption()
		LactacidDiluteOID_S = AddSliderOption("Dilute Milk: ", LactacidDilute, "{2}")
		LactacidWeakOID_S = AddSliderOption("Weak Milk: ", LactacidWeak, "{2}")
		LactacidRegularOID_S = AddSliderOption("Regular Milk: ", LactacidRegular, "{2}")
		LactacidStrongOID_S = AddSliderOption("Strong Milk: ", LactacidStrong, "{2}")
		LactacidTastyOID_S = AddSliderOption("Tasty Milk: ", LactacidTasty, "{2}")
		LactacidCreamyOID_S = AddSliderOption("Creamy Milk: ", LactacidCreamy, "{2}")
		LactacidEnrichedOID_S = AddSliderOption("Enriched Milk: ", LactacidEnriched, "{2}")
		LactacidSublimeOID_S = AddSliderOption("Sublime Milk: ", LactacidSublime, "{2}")
		LactacidLactacidOID_S = AddSliderOption("Lactacid: ", LactacidLactacid, "{2}")
		AddEmptyOption()
		
		AddHeaderOption("Speed Gained From:")
		AddEmptyOption()
		SpeedDiluteOID_S = AddSliderOption("Dilute Milk: ", SpeedDilute, "{0}")
		SpeedWeakOID_S = AddSliderOption("Weak Milk: ", SpeedWeak, "{0}")
		SpeedRegularOID_S = AddSliderOption("Regular Milk: ", SpeedRegular, "{0}")
		SpeedStrongOID_S = AddSliderOption("Strong Milk: ", SpeedStrong, "{0}")
		SpeedTastyOID_S = AddSliderOption("Tasty Milk: ", SpeedTasty, "{0}")
		SpeedCreamyOID_S = AddSliderOption("Creamy Milk: ", SpeedCreamy, "{0}")
		SpeedEnrichedOID_S = AddSliderOption("Enriched Milk: ", SpeedEnriched, "{0}")
		SpeedSublimeOID_S = AddSliderOption("Sublime Milk: ", SpeedSublime, "{0}")
		
		AddHeaderOption("Stamina Rate Gained From:")
		AddEmptyOption()
		StaminaRateDiluteOID_S = AddSliderOption("Dilute Milk: ", StaminaRateDilute, "{0}")
		StaminaRateWeakOID_S = AddSliderOption("Weak Milk: ", StaminaRateWeak, "{0}")
		StaminaRateRegularOID_S = AddSliderOption("Regular Milk: ", StaminaRateRegular, "{0}")
		StaminaRateStrongOID_S = AddSliderOption("Strong Milk: ", StaminaRateStrong, "{0}")
		StaminaRateTastyOID_S = AddSliderOption("Tasty Milk: ", StaminaRateTasty, "{0}")
		StaminaRateCreamyOID_S = AddSliderOption("Creamy Milk: ", StaminaRateCreamy, "{0}")
		StaminaRateEnrichedOID_S = AddSliderOption("Enriched Milk: ", StaminaRateEnriched, "{0}")
		StaminaRateSublimeOID_S = AddSliderOption("Sublime Milk: ", StaminaRateSublime, "{0}")
		
		AddHeaderOption("Duration of Buff From:")
		AddEmptyOption()
		DurationDiluteOID_S = AddSliderOption("Dilute Milk: ", DurationDilute, "{0}")
		DurationWeakOID_S = AddSliderOption("Weak Milk: ", DurationWeak, "{0}")
		DurationRegularOID_S = AddSliderOption("Regular Milk: ", DurationRegular, "{0}")
		DurationStrongOID_S = AddSliderOption("Strong Milk: ", DurationStrong, "{0}")
		DurationTastyOID_S = AddSliderOption("Tasty Milk: ", DurationTasty, "{0}")
		DurationCreamyOID_S = AddSliderOption("Creamy Milk: ", DurationCreamy, "{0}")
		DurationEnrichedOID_S = AddSliderOption("Enriched Milk: ", DurationEnriched, "{0}")
		DurationSublimeOID_S = AddSliderOption("Sublime Milk: ", DurationSublime, "{0}")
		
	elseif(page == "Trip / Strip")
		AddHeaderOption("Debug ")
		AddEmptyOption()
		TripDebugOID = AddToggleOption("Debug Trip Events", DebugTripT)
		TripMeOID_T = AddTextOption("Trip Me", "")
		UseAltTripMethodOID  = AddToggleOption("Use Alternate Trip Method", UseAltTripMethod)
		TripStripChanceLocationModOID_S = AddSliderOption("Trip/Strip Chance Location Mod: ", TripStripChanceLocationMod, "{2}")
		
		AddHeaderOption("Creature Trip Events")
		AddEmptyOption()
		TripArousalReqOID_S = AddSliderOption("Arousal Required: ", TripArousalReq, "{0}")
		TripDistanceReqOID_S = AddSliderOption("Maximum Distance: ", TripDistanceReq, "{0}")
		MountCooldownTimeOID_S = AddSliderOption("Mount Cooldown Time: ", MountCooldownTime, "{0}")
		MountTeleportOID  = AddToggleOption("Teleport Creature", MountTeleport)
		
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("Trip Frequency At Addiction Stage:")
		TripFreqModerateOID_S = AddSliderOption("Moderate: ", TripFreqModerate, "{0} sec ")
		TripFreqAddictOID_S = AddSliderOption("Addict: ", TripFreqAddict, "{0} sec ")
		TripFreqJunkieOID_S = AddSliderOption("Junkie: ", TripFreqJunkie, "{0} sec ")

		AddHeaderOption("Strip Frequency At Addiction Stage:")
		SlipFreqModerateOID_S = AddSliderOption("Moderate: ", SlipFreqModerate, "{0} sec ")
		SlipFreqAddictOID_S = AddSliderOption("Addict: ", SlipFreqAddict, "{0} sec ")
		SlipFreqJunkieOID_S = AddSliderOption("Junkie: ", SlipFreqJunkie, "{0} sec ")
		
		AddHeaderOption("Drop Clothes In Slot:")
		DropBodyOID = AddToggleOption("Body ", DropBodyT)
		DropHeadOID = AddToggleOption("Head ", DropHeadT)
		
		AddHeaderOption("Chance Of Drop On Trip At Stage:")
		AdditionalTripDropChanceModerateOID_S = AddSliderOption("Moderate: ", AdditionalTripDropChanceModerate, "{0}% ")
		AdditionalTripDropChanceAddictOID_S = AddSliderOption("Addict: ", AdditionalTripDropChanceAddict, "{0}% ")
		AdditionalTripDropChanceJunkieOID_S = AddSliderOption("Junkie: ", AdditionalTripDropChanceJunkie, "{0}% ")
		
		SetCursorPosition(13)
		AddHeaderOption("Trip Chance At Addiction Stage:")
		TripChanceModerateOID_S = AddSliderOption("Moderate: ", TripChanceModerate, "{0}% ")
		TripChanceAddictOID_S = AddSliderOption("Addict: ", TripChanceAddict, "{0}% ")
		TripChanceJunkieOID_S = AddSliderOption("Junkie: ", TripChanceJunkie, "{0}% ")

		AddHeaderOption("Strip Chance At Addiction Stage:")
		SlipChanceModerateOID_S = AddSliderOption("Moderate: ", SlipChanceModerate, "{0}% ")
		SlipChanceAddictOID_S = AddSliderOption("Addict: ", SlipChanceAddict, "{0}% ")
		SlipChanceJunkieOID_S = AddSliderOption("Junkie: ", SlipChanceJunkie, "{0}% ")
		
		AddEmptyOption()
		DropHandsOID = AddToggleOption("Hands ", DropHandsT)
		DropFeetOID = AddToggleOption("Feet ", DropFeetT)	
	
	ElseIf(page == "NPC Milking")
		AddHeaderOption("General")
		AddEmptyOption()
		NpcMilkingCostOID_S = AddSliderOption("Milking Cost Per Maid Level: ", NpcMilkingCost, "{0} Gold ")
		AddEmptyOption()
		AddEmptyOption()
		AddEmptyOption()
		
		AddHeaderOption("Fresh Milk Multiplies:")
		AddEmptyOption()
		FreshAddictivenessMultOID_S = AddSliderOption("Addictiveness By: ", FreshAddictivenessMult, "{1}x ")
		FreshLactacidMultOID_S = AddSliderOption("Lactacid Gained By: ", FreshLactacidMult, "{1}x ")
		AddEmptyOption()
		AddEmptyOption()
		
		AddHeaderOption("Milk Production Rate")
		AddEmptyOption()
		If Init.SgoInstalled
			Init.GetSgoMilkTime()
			SgoMilkProductionTimeOID_S = AddSliderOption("SGO Milk Production Time: ", Init.SgoOptMilkProduceTime, "{0} Hours ")
		Else
			SgoMilkProductionTimeOID_S = AddSliderOption("SGO Milk Production Time: ", Init.SgoOptMilkProduceTime, "{0} Hours ", OPTION_FLAG_DISABLED)
		EndIf
		MmeMilkProductionRateOID_S = AddSliderOption("MME Milk Production Rate: ", MilkQ.MilkProdMod, "{0}% ")
		
		BoobgasmChanceOID_S = AddSliderOption("Base Boobgasm Chance: ", BoobgasmChance, "{0}%")
		BoobgasmChancePerLevelOID_S = AddSliderOption("Boobgasm Chance Per Level: ", BoobgasmChancePerLevel, "{0}% ")
		AddEmptyOption()
		AddEmptyOption()
		
		AddHeaderOption("Npc Inventory Milk")
		AddEmptyOption()
		NpcInvMilkQuantityOID_S = AddSliderOption("Max Number Of Milks: ", NpcInvMilkQuantity, "{0} ")
		NpcInvMilkChanceOID_S = AddSliderOption("Chance Per Milk: ", NpcInvMilkChance, "{1}% ")
		
	ElseIf(page == "Food ")
		SetupFoodOID = AddToggleOption("Setup Next Equip", Main.SetupFood)
		RemoveFoodOID = AddToggleOption("Remove Next Equip", Main.RemoveFood)
		SetupFoodLactacidOID_S = AddSliderOption("Next Equip Will Provide: ", SetupFoodLactacid, "{2} Lactacid ")
		SetupFoodAddictivenessOID_S = AddSliderOption("Next Equip Will Give: ", SetupFoodAddictiveness, "{0} Addictiveness ")
		
	ElseIf(page == "Armor ")
		AddHeaderOption("Armor Unequips At: ")
		AddEmptyOption()
		ArmorCapacityUnitsOID_S = AddSliderOption("", ArmorCapacityUnits, "{0} Milk Units ")
		ArmorCapacityOID_S = AddSliderOption("", ArmorCapacity, "{0}% Total Capacity ")
		
		AddHeaderOption("Clothes Are Safe Up To: ")
		AddEmptyOption()
		ClothesLimitUnitsOID_S = AddSliderOption("", ClothesLimitUnits, "{0} Milk Units ")
		ClothesLimitOID_S = AddSliderOption("", ClothesLimit, "{0}% Total Capacity ")
		
		AddHeaderOption("Chance Of Clothes Ripping ")
		AddEmptyOption()
		ClothesTearChanceBaseOID_S = AddSliderOption("Base Chance: ", ClothesTearChanceBase, "{0}% ")
		ClothesTearChanceOID_S = AddSliderOption("Chance Per % Capacity Above: ", ClothesTearChance, "{1}% ")
		
		ClothesTearChanceBellyOID_S = AddSliderOption("Chance Per 0.1 Belly Scale Above 1: ", ClothesTearChanceBelly, "{1}% ")
		ClothesTearChanceAssOID_S = AddSliderOption("Chance Per 0.1 Ass Scale Above 1: ", ClothesTearChanceAss, "{1}% ")
		
		AddHeaderOption("Repair Cost & Tear Volume")
		AddEmptyOption()
		RepairCostMultOID_S = AddSliderOption("Repair Cost Mult: ", RepairCostMult, "{1}X ")
		TearVolumeOID_S = AddSliderOption("Tear Sound Volume ", TearVolume * 100.0, "{0}% ")
		
		AddHeaderOption("Clothes Sluttiness")
		AddEmptyOption()
		SlutFactorOID = AddToggleOption("Enable Sluttiness ", SlutFactor)
		SetupSlutClothesOID = AddToggleOption("Setup Next Equip ", SetupSlutClothes)
		
		ClearSluttinessOID_T = AddTextOption("Erase Sluttiness From File ", "")
		AddEmptyOption()
		
		AddHeaderOption("Clothes Have A Durability Of: ")
		AddEmptyOption()
		ClothesDurabilityOID_S = AddSliderOption("Base: ", ClothesDurability, "{0} Rips ")
		DurabilityToleranceOID_S = AddSliderOption("+ / - ", DurabilityTolerance, "{0} Rips ")
		
		AddHeaderOption("Combat Ripping: ")
		AddEmptyOption()
		HitRipChanceOID_S = AddSliderOption("Chance To Rip: ", HitRipChance, "{0}% ")
		MagicArmorMultOID_S = AddSliderOption("Magic Armor Mult: ", MagicArmorMult, "x {0}%")
		
		AddHeaderOption("Current Tear Chance ")
		AddEmptyOption()
		Float CurrentMilk = MME_Storage.getMilkCurrent(PlayerRef)
		Float MilkMax = MME_Storage.getMilkMaximum(PlayerRef) ; Milk Maid level 10, Cap = 24.0
		Main.UpdateRipChance()
		CurrentMilkOID_T = AddTextOption("Current Milk: " + CurrentMilk + " Units ", "")
		AddEmptyOption()
		MilkCapMaxOID_T = AddTextOption("Current Capacity: " + MilkMax + " Units ", "")
		AddEmptyOption()
		
		If Init.SlifInstalled
			CurrentAssScaleOID_T = AddTextOption("Current Ass Scale: " + Init.GetSlifAss(), "")
			AssScaleTearChanceOID_T = AddTextOption("Ass Tear Chance: B: " + Init.GetSlifAss() * ClothesTearChanceAss + ". A: " + Main.AssRip, "")
			CurrentBellyScaleOID_T = AddTextOption("Current Belly Scale: " + Init.GetSlifBelly(), "")
			BellyScaleTearChanceOIS_T = AddTextOption("Belly Tear Chance: B: " + ((Init.GetSlifBelly() - 1)* ClothesTearChanceBelly) + ". A: " + Main.BellyRip, "")
		EndIf
		
		CurrentTearChanceOID_T = AddTextOption("Current Tear Chance: " + Main.TearChance + "% ", "")
		AddEmptyOption()

		AddHeaderOption("Actions Multiply Tear Chance By: ")
		AddEmptyOption()
		TearMultAttackOID_S = AddSliderOption("Attack: ", TearMultAttack, "{2}X ")
		AttackTearChanceOID_T = AddTextOption("Current Tear Chance: " + Main.TearChance * TearMultAttack + "% ", "")
		TearMultPowerAttackOID_S = AddSliderOption("Power Attack: ", TearMultPowerAttack, "{2}X ")
		PowerAttackTearChanceOID_T = AddTextOption("Current Tear Chance: " + Main.TearChance * TearMultPowerAttack + "% ", "")
		TearMultJumpOID_S = AddSliderOption("Jump: ", TearMultJump, "{2}X ")
		JumpTearChanceOID_T = AddTextOption("Current Tear Chance: " + Main.TearChance * TearMultJump + "% ", "")
		TearMultSprintOID_S = AddSliderOption("Sprint: ", TearMultSprint, "{2}X ")
		SprintTearChanceOID_T = AddTextOption("Current Tear Chance: " + Main.TearChance * TearMultSprint + "% ", "")
		TearMultBowOID_S = AddSliderOption("Bow: ", TearMultBow, "{2}X ")
		BowTearChanceOID_T = AddTextOption("Current Tear Chance: " + Main.TearChance * TearMultBow + "% ", "")
		TearMultMagicOID_S = AddSliderOption("Magic: ", TearMultMagic, "{2}X ")
		MagicTearChanceOID_T = AddTextOption("Current Tear Chance: " + Main.TearChance * TearMultMagic + "% ", "")
		TearMultShoutOID_S = AddSliderOption("Shout: ", TearMultShout, "{2}X ")
		ShoutTearChanceOID_T = AddTextOption("Current Tear Chance: " + Main.TearChance * TearMultShout + "% ", "")
	endif
endEvent

Event OnOptionMenuOpen(int option)
	If (option == CraftingDifficultyDB)
		SetMenuDialogStartIndex(CraftingDifficulty)
		SetMenuDialogDefaultIndex(1)
		SetMenuDialogOptions(DifficultyList)
	ElseIf (option == DropTypeDB)
		SetMenuDialogStartIndex(DropType)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(DropTypeList)
	endIf
EndEvent

Event OnOptionMenuAccept(int option, int index)
	If (option == CraftingDifficultyDB)
		CraftingDifficulty = index
		SetMenuOptionValue(option, DifficultyList[CraftingDifficulty])
	ElseIf (option == DropTypeDB)
		DropType = index
		SetMenuOptionValue(option, DropTypeList[DropType])
	EndIf
EndEvent

Event OnOptionSelect(int option)
	; Settings
	If (option == ExportSettingsOID_T)
		SetTextOptionValue(ExportSettingsOID_T, "Exporting Settings ", false)
		If ShowMessage("Are you sure?")
			SaveSettings()			
		Endif
	ElseIf (option == ImportSettingsOID_T)
		SetTextOptionValue(ImportSettingsOID_T, "Importing Settings ", false)
		If ShowMessage("Are you sure?")
			LoadSettings()	
			ForcePageReset()		
		Endif
		
	ElseIf (option == SlifScalingOID)
		SlifScaling = !SlifScaling
		SetToggleOptionValue(SlifScalingOID, SlifScaling)
		If MQ101.GetCurrentStageID() >= 240 ; Toggle option but do nothing if still in alternate start cell. StartSlifScaling() in _MA_SlifScalingScript should already be running and will check toggle option before acting after leaving AS cell
			If SlifScaling
				MaScaling.StartSlifScaling()
			Else
				MaScaling.StopSlifScaling()
			EndIf
		EndIf
	ElseIf (option == ResetSlifOID_T)
		SetTextOptionValue(ResetSlifOID_T, "Resetting Ass ", false)
		If ShowMessage("Reset all SL Inflation Framework ass progression from Milk Addict?")
			MaScaling.ResetAss()
			ForcePageReset()		
		Endif
	ElseIf (option == BaseAssScaleOID)
		BaseAssScale = !BaseAssScale
		SetToggleOptionValue(BaseAssScaleOID, BaseAssScale)
	ElseIf (option == LeakyBoobsSoundTOID)
		LeakyBoobsSoundT = !LeakyBoobsSoundT
		SetToggleOptionValue(LeakyBoobsSoundTOID, LeakyBoobsSoundT)		
	ElseIf (option == CreaturesEventsOID)
		CreatureEventsT = !CreatureEventsT
		SetToggleOptionValue(CreaturesEventsOID, CreatureEventsT)
	ElseIf (option == CleavageSpellOID)
		CleavageSpellT = !CleavageSpellT
		SetToggleOptionValue(CleavageSpellOID, CleavageSpellT)
		If CleavageSpellT
			Main.RefreshCleavageEffect()
		Else
			PlayerRef.RemoveSpell(Main._MA_Cleavage)
		EndIf
	ElseIf (option == LactacidCeilingTOID)
		LactacidCeilingT = !LactacidCeilingT
		SetToggleOptionValue(LactacidCeilingTOID, LactacidCeilingT)
	ElseIf (option == InvoluntaryActionsOID)
		InvoluntaryActions = !InvoluntaryActions
		SetToggleOptionValue(InvoluntaryActionsOID, InvoluntaryActions)
		SetupInvoluntaryActions()
		
	; Milk
	
	; Trip / Slip
	ElseIf (option == TripDebugOID)
		DebugTripT = !DebugTripT
		SetToggleOptionValue(TripDebugOID, DebugTripT)
	ElseIf (option == UseAltTripMethodOID)
		UseAltTripMethod = !UseAltTripMethod
		SetToggleOptionValue(UseAltTripMethodOID, UseAltTripMethod)
	ElseIf (option == TripMeOID_T)
		SetTextOptionValue(TripMeOID_T, "Tripping! ", false)
		If !UseAltTripMethod
			_MA_TripSpell.Cast(PlayerRef, PlayerRef)
		Else
			PlayerRef.PushActorAway(PlayerRef, 1.5)
		EndIf
	ElseIf (option == MountTeleportOID)
		MountTeleport = !MountTeleport
		SetToggleOptionValue(MountTeleportOID, MountTeleport)
	ElseIf (option == DropBodyOID)
		DropBodyT = !DropBodyT
		SetToggleOptionValue(DropBodyOID, DropBodyT)
		ConfigureDropSlots()
	ElseIf (option == DropHeadOID)
		DropHeadT = !DropHeadT
		SetToggleOptionValue(DropHeadOID, DropHeadT)
		ConfigureDropSlots()
	ElseIf (option == DropHandsOID)
		DropHandsT = !DropHandsT
		SetToggleOptionValue(DropHandsOID, DropHandsT)
		ConfigureDropSlots()
	ElseIf (option == DropFeetOID)
		DropFeetT = !DropFeetT
		SetToggleOptionValue(DropFeetOID, DropFeetT)
		ConfigureDropSlots()

	; Food
	ElseIf (option == SetupFoodOID)
		Main.SetupFood = !Main.SetupFood
		SetToggleOptionValue(SetupFoodOID, Main.SetupFood)
	ElseIf (option == RemoveFoodOID)
		Main.RemoveFood = !Main.RemoveFood
		SetToggleOptionValue(RemoveFoodOID, Main.RemoveFood)
		
	; Armor
	ElseIf (option == SlutFactorOID)
		SlutFactor = !SlutFactor
		SetToggleOptionValue(SlutFactorOID, SlutFactor)
	ElseIf (option == SetupSlutClothesOID)
		SetupSlutClothes = !SetupSlutClothes
		SetToggleOptionValue(SetupSlutClothesOID, SetupSlutClothes)
	ElseIf (option == ClearSluttinessOID_T)
		If ShowMessage("Are you sure you want to clear all sluttiness values saved to file SlutClothes.json?")
			ClearSluttiness()
		Endif
	EndIf
endEvent

event OnOptionDefault(int option)
	; Settings
	If(option == SlifScalingOID)
		SlifScaling = true
		SetToggleOptionValue(SlifScalingOID, SlifScaling)
		If SlifScaling
			MaScaling.StartSlifScaling()
		Else
			MaScaling.StopSlifScaling()
		EndIf
	ElseIf(option == BaseAssScaleOID)
		BaseAssScale = true
		SetToggleOptionValue(BaseAssScaleOID, BaseAssScale)
	ElseIf(option == LeakyBoobsSoundTOID)
		LeakyBoobsSoundT = true
		SetToggleOptionValue(LeakyBoobsSoundTOID, LeakyBoobsSoundT)
	ElseIf(option == CreaturesEventsOID)
		CreatureEventsT = true
		SetToggleOptionValue(CreaturesEventsOID, CreatureEventsT)
	ElseIf(option == CleavageSpellOID)
		CleavageSpellT = true
		SetToggleOptionValue(CleavageSpellOID, CleavageSpellT)
		If CleavageSpellT
			Main.RefreshCleavageEffect()
		Else
			PlayerRef.RemoveSpell(Main._MA_Cleavage)
		EndIf
	ElseIf(option == LactacidCeilingTOID)
		LactacidCeilingT = true
		SetToggleOptionValue(LactacidCeilingTOID, LactacidCeilingT)
	ElseIf(option == InvoluntaryActionsOID)
		InvoluntaryActions = true
		SetToggleOptionValue(InvoluntaryActionsOID, InvoluntaryActions)
		SetupInvoluntaryActions()
	; Milk
	
	; Trip / Slip
	ElseIf(option == DropBodyOID)
		DropBodyT = true
		SetToggleOptionValue(DropBodyOID, DropBodyT)
		ConfigureDropSlots()
	ElseIf(option == DropHeadOID)
		DropHeadT = true
		SetToggleOptionValue(DropHeadOID, DropHeadT)
		ConfigureDropSlots()
	ElseIf(option == DropHandsOID)
		DropHandsT = true
		SetToggleOptionValue(DropHandsOID, DropHandsT)
		ConfigureDropSlots()
	ElseIf(option == DropFeetOID)
		DropFeetT = true
		SetToggleOptionValue(DropFeetOID, DropFeetT)
		ConfigureDropSlots()
	ElseIf(option == TripDebugOID)
		DebugTripT = false
		SetToggleOptionValue(TripDebugOID, DebugTripT)
	ElseIf(option == UseAltTripMethodOID)
		UseAltTripMethod = false
		SetToggleOptionValue(UseAltTripMethodOID, UseAltTripMethod)
		
	; Food
	ElseIf(option == SetupFoodOID)
		Main.SetupFood = false
		SetToggleOptionValue(SetupFoodOID, Main.SetupFood)
	ElseIf(option == RemoveFoodOID)
		Main.RemoveFood = false
		SetToggleOptionValue(RemoveFoodOID, Main.RemoveFood)
		
	; Armor
	ElseIf(option == SlutFactorOID)
		SlutFactor = true
		SetToggleOptionValue(SlutFactorOID, SlutFactor)
	ElseIf(option == SetupSlutClothesOID)
		SetupSlutClothes = false
		SetToggleOptionValue(SetupSlutClothesOID, SetupSlutClothes)
	EndIf
endEvent

event OnOptionHighlight(int option)
	;Settings
	If (option == CurrentAddictionOID_T)
		SetInfoText("Your current lactacid addiction total")
		
	ElseIf (option == CurrentMilkOID_T)
		SetInfoText("How much milk you have now")
	ElseIf (option == MilkCapMaxOID_T)
		SetInfoText("Your maximum milk capacity")
	ElseIf (option == ClothesDurabilityOID_T)
		SetInfoText("The durability of your currently equipped (or last equipped) clothes\nYour clothes can survive this many rips before turning into rags")
	ElseIf (option == ClothesSluttinessOID_T)
		SetInfoText("How slutty your current clothes are")
	ElseIf (option == BonusCapacityOID_T)
		SetInfoText("How much capacity bonus the sluttiness of your clothes is providing")
		
	ElseIf (option == AddictionDecayOID_S)
		SetInfoText("How much addiction you lose each hour")
	ElseIf (option == CraftingDifficultyDB)
		SetInfoText("Slighty adjusts the crafting difficulty of lactacid rememdies. \nCrafting results are based on: this difficulty modifier, your alchemy skill, ingredient quality and some random luck")
	ElseIf (option == DropTypeDB)
		SetInfoText("Clothes/Armor drop method\nUnequip - Simple unequip to inventory. Should be 100% safe\nSafe Drop: Drops clothes but provides safety measures if your clothes drop through the floor\nBody/Feet/Hands/Head slots are tracked separately. If you drop another item of the same type (eg. body clothes) then the new item is tracked instead. The old Item will be available to buy back ")
	ElseIf (option == TimeToFindClothesOID_S)
		SetInfoText("How long until you automatically find your dropped clothes\nYou can not search for your clothes during combat ")
	ElseIf (option == CleavageSpellOID)
		SetInfoText("Enable/Disable cleavage spell\nIncreased/Decreased speech skill based on how many units of milk in your breasts\nThe cleavage spell is updated when MME finishes it's update cycle (once an hour by default)\nNeed a way to detect when the player has been milked without heavy updates")
	ElseIf (option == CleavageMaxUnitsOID_S)
		SetInfoText("At how many units to consider your breasts full for the cleavage spell\nThe default max capacity at level 10 milk maid is 24 for MME\nThe closer you are to max capacity the higher the buff. The closer you are to empty the higher the debuff")
	ElseIf (option == LeakyBoobsSoundTOID)
		SetInfoText("Enable/Disable dripping sound for leaking milk")
	ElseIf (option == LeakyBoobsVolumeOID_S)
		SetInfoText("Change the volume of the milk dripping sound")
	ElseIf (option == LactacidCeilingTOID)
		SetInfoText("Enable/Disable lactacid ceiling to stop your lactacid levels increasing to ridiculous levels\nWhich will help reduce milk generation rate")
	ElseIf (option == LactacidCeilingOID_S)
		SetInfoText("The maximum lactacid the mod will try to keep you from going over\nMust be set higher than 'Lactacid required at stage Junkie'")
	ElseIf (option == BreastRopeFreqOffsetOID_S)
		SetInfoText("By default breast ropes leak milk at a rate that will require you to wear the rope for the full amount of time between MME updates. This keeps you wearing the ropes if you want empty breasts\nThis option changes how quickly milk will drain from your tits. Increase this if milk is draining too slowly for your liking\n")
	ElseIf (option == InvoluntaryActionsOID)
		SetInfoText("Enable/Disable involuntary junkie actions")

	ElseIf (option == ExportSettingsOID_T)
		SetInfoText("Save your MCM settings to file /SKSE/Plugins/StorageUtilData/Milk Addict/Settings.json\nDon't forget to backup the file if you are clean saving the mod")
	ElseIf (option == ImportSettingsOID_T)
		SetInfoText("Load your MCM settings from file /SKSE/Plugins/StorageUtilData/Milk Addict/Settings.json")
	ElseIf (option == SlifScalingOID)
		SetInfoText("Enable/Disable SLIF scaling of your ass based on how much lactacid is in your system each day\nThe more/less lactacid in your system the faster your ass will grow or decline\nIf Current Lactacid < Lactacid Required At Stage Mild THEN your ass will get smaller\nIf Current Lactacid < Lactacid Required At Stage Moderate THEN no change\nIf Current Lactacid > Lactacid Required At Stage Moderate THEN your ass will get bigger")
	ElseIf (option == ResetSlifOID_T)
		SetInfoText("Reset your Milk Addict ass size progression\nThis will reset your SLIF ass size modification (from Milk Addict only) to Base Ass Scale below (0.0 or 1.0)")
	ElseIf (option == AssMaxScaleOID_S)
		SetInfoText("The maximum scale your ass should grow to")
	ElseIf (option == AssLactMultOID_S)
		SetInfoText("Determines how quickly your ass will increase/decrease in size\nGrowth is calculated as: (Current Lactacid - Lactacid Required At Stage Moderate) * Lactacid Ass Mult * 5\nDecline: (Lactacid Required At Stage Mild - Current Lactacid) * Lactacid Ass Mult * 10\nEg: Current Lactacid = 4.0, Lactacid Required At Stage Moderate = 2.0, Lactacid Ass Mult = 0.0125 THEN growth = (4.0 - 2.0) * 0.0125 * 5 = 0.125 per day")
	ElseIf (option == BaseAssScaleOID)
		SetInfoText("Enable if your bodys base butt scale is 1. Disable if your bodys base ass scale is zero\nIt's usually 1.0")
	ElseIf (option == RequiredLactMildOID_S || option ==  RequiredLactModerateOID_S || option ==  RequiredLactAddictOID_S || option == RequiredLactJunkieOID_S)
		SetInfoText("The amount of lactacid you'll need in your system to be unaffected by any withdrawal symptoms\nAs your lactacid levels decrease the severity of your symptoms will increase\nWARNING! Make sure your settings are progressive - Eg. Moderate should be set higher than mild etc\nProgression: Mild, Moderate, Addict, Junkie")
	ElseIf (option == RapeLactacidChanceOID_S)
		SetInfoText("The chance of being forced to drink lactacid after rape events\nOnce your addiction is high enough they'll stop force drugging you, which would effectively be helping you at that point")
		
	; Milk
	ElseIf (option == AffterEffectDebuffMagMultOID_S)
		SetInfoText("The severity of the stamina debuff you get when the buff from a milk expires\nThe magnitude is calculated as (The magnitude of the last milk you consumed) X (This value)")
	ElseIf (option == AffterEffectDebuffDurMultOID_S)
		SetInfoText("The duration of the stamina debuff you get when the buff from a milk expires\nThe duration is calculated as (The duration of the last milk you consumed) X (This value)")
	ElseIf (option == AproposHealBaseOID_S)
		SetInfoText("The amount of Apropos Wear & Tear healing applied by Dilute Milk\nFor reference, by default Apropos healing provided by spider eggs/charus eggs and skooma is 20 'units'")
	ElseIf (option == AproposHealDeltaOID_S)
		SetInfoText("The difference between the healing provided by the different tiers of milk\nEg: Base = 5, Delta = 10 THEN Dilute provides 5 healing, Weak = 15, Regular = 25, Strong = 35, Tasty = 45 etc")
	ElseIf (option == AddictivenessDiluteOID_S || option == AddictivenessWeakOID_S || option == AddictivenessRegularOID_S || option == AddictivenessStrongOID_S || option == AddictivenessTastyOID_S || option == AddictivenessCreamyOID_S || option == AddictivenessEnrichedOID_S || option == AddictivenessSublimeOID_S || option == AddictivenessLactacidOID_S)
		SetInfoText("How much addiction is gained when you consume this type of milk / lactacid")
	ElseIf (option == LactacidDiluteOID_S || option == LactacidWeakOID_S || option == LactacidRegularOID_S || option == LactacidStrongOID_S || option == LactacidTastyOID_S || option == LactacidCreamyOID_S || option == LactacidEnrichedOID_S || option == LactacidSublimeOID_S || option == LactacidLactacidOID_S)
		SetInfoText("How much lactacid is added to your system when you consume this type of milk / lactacid\nNote: Lactacid gained from pure lactacid decreases substantially as your addiction increases\nThis is to stop you trading in all your crappy milk for super-duper lactacid. The amount of addiction gained does not change, however")
	ElseIf (option == SpeedDiluteOID_S || option == SpeedWeakOID_S || option == SpeedRegularOID_S || option == SpeedStrongOID_S || option == SpeedTastyOID_S || option == SpeedCreamyOID_S || option == SpeedEnrichedOID_S || option == SpeedSublimeOID_S)
		SetInfoText("The magnitude of the speed buff you gain for consuming this type of milk")
	ElseIf (option == StaminaRateDiluteOID_S || option == StaminaRateWeakOID_S || option == StaminaRateRegularOID_S || option == StaminaRateStrongOID_S || option == StaminaRateTastyOID_S || option == StaminaRateCreamyOID_S || option == StaminaRateEnrichedOID_S || option == StaminaRateSublimeOID_S)
		SetInfoText("The magnitude of the stamina rate buff you gain for consuming this type of milk")
	ElseIf (option == DurationDiluteOID_S || option == DurationWeakOID_S || option == DurationRegularOID_S || option == DurationStrongOID_S || option == DurationTastyOID_S || option == DurationCreamyOID_S || option == DurationEnrichedOID_S || option == DurationSublimeOID_S)
		SetInfoText("The duration of the stamina rate/speed buff you gain for consuming this type of milk")
	
	; Trip / Slip
	ElseIf (option == TripStripChanceLocationModOID_S)
		SetInfoText("If your current location is not in or around a town then your chance of a trip or strip event is multiplied by this\nUse this to reduce the chance of trip/strip events when not in towns to make the mod less annoying")
	ElseIf (option == TripArousalReqOID_S)
		SetInfoText("Creature arousal required for it to mount you during trip event\nRecommend setting this fairly low or events may never trigger")
	ElseIf (option == TripDistanceReqOID_S)
		SetInfoText("Maximum distance to creature for it to mount you")
	ElseIf (option == MountCooldownTimeOID_S)
		SetInfoText("Minimum time between mount events. Cooldown begins after the current scene is finished\nYou can still trip in this time")
	ElseIf (option == MountTeleportOID)
		SetInfoText("Teleport the creature to you because Skyrim pathfinding is horrendous at the best of times\nStarts scene faster and is a bit more like an actual surprise mounting event but teleporting...\nI know there's an option in Sexlab but most of the time I don't like teleporting")
	ElseIf (option == TripFreqModerateOID_S || option == TripFreqAddictOID_S || option == TripFreqJunkieOID_S)
		SetInfoText("Number of seconds between trip chance checks at this stage of addiction withdrawal\nWarning: Setting too low may result in hilarity")
	ElseIf (option == TripChanceModerateOID_S || option == TripChanceAddictOID_S || option == TripChanceJunkieOID_S)
		SetInfoText("The chance that you will trip at the check interval for a given addiction stage")
	ElseIf (option == SlipFreqModerateOID_S || option == SlipFreqAddictOID_S  || option == SlipFreqJunkieOID_S)
		SetInfoText("Number of seconds between strip chance checks at this stage of addiction withdrawal\nStrip = Your clothes/armor spontaneously becoming undone due to your lack of concentration when you put them on")
	ElseIf (option == SlipChanceModerateOID_S || option == SlipChanceAddictOID_S  || option == SlipChanceJunkieOID_S)
		SetInfoText("The chance that you will have a strip event at the check interval for a given addiction stage")
	ElseIf (option == AdditionalTripDropChanceModerateOID_S || option == AdditionalTripDropChanceAddictOID_S || option == AdditionalTripDropChanceJunkieOID_S)
		SetInfoText("Additional chance for some of your clothes to become undone when a trip event is triggered\nThis is completely independent of the 'strip' sliders and only effects trip events")
	ElseIf (option == DropBodyOID || option == DropHeadOID || option == DropHandsOID || option == DropFeetOID)
		SetInfoText("Enable/Disable clothes being dropped from this slot\nNote: Head actually checks the 'Hair' slot since most helmets occupy this slot")
	ElseIf (option == TripDebugOID)
		SetInfoText("Enable/Disable trip mount event debugging\nShows a message on trip mount events displaying the selected creature, distance, arousal, etc\nTry this is you can not figure out why trip events are not firing")
	ElseIf (option == UseAltTripMethodOID)
		SetInfoText("Use a different method to trip the player.\nTry this if you get a tripping notification but don't actually trip - Some mods make the player immortal which interferes with the main method\nOr you might just prefer the way the alternate method animates.")
	ElseIf (option == TripMeOID_T)
		SetInfoText("Trigger a trip. Useful if you get stuck running on the spot etc")
	
	; NPC Milking
	ElseIf (option == NpcMilkingCostOID_S)
		SetInfoText("How much gold NPCs will want from you to milk them X their milk maid level")
	ElseIf (option == BoobgasmChanceOID_S)
		SetInfoText("Base chance of a boobgasm for SGO npcs only. Boobgasms produce better milk\nMME milk boobgasms are still handled by MME")
	ElseIf (option == BoobgasmChancePerLevelOID_S)
		SetInfoText("Boobgasm chance gained per maid level of SGO NPCs only\nMME milk boobgasms are still handled by MME")
	ElseIf (option == FreshAddictivenessMultOID_S)
		SetInfoText("'Fresh' milk modifies the standard addictiveness of the produced milk by this value\nAffects both SGO and MME NPCs")
	ElseIf (option == FreshLactacidMultOID_S)
		SetInfoText("'Fresh' milk modifies the standard lactacid of the produced milk by this value\nAffects both SGO and MME NPCs")
	ElseIf (option == NpcInvMilkQuantityOID_S)
		SetInfoText("Maximum number of milks to be found in Npc inventories\nFor this to trigger the Npc must not already have milk and you must not have searched them recently")
	ElseIf (option == NpcInvMilkChanceOID_S)
		SetInfoText("Chance to add a milk. This is the chance per quantity so each milk to be added will have this chance to be added")
		
	ElseIf (option == SgoMilkProductionTimeOID_S)
		SetInfoText("Time it takes to produce a single SGO milk\nOverrides SGOs setting with a slider with a much greater range\nAllows you to slow down SGO milk production")
	ElseIf (option == MmeMilkProductionRateOID_S)
		SetInfoText("MME milk production rate. Overrides MME MCM->Debug->Milk Production Rate setting\nSlider has a greater granularity then MMEs - values can be set in increaments of 1% instead of 10%")
		
	; Food
	ElseIf (option == SetupFoodOID)
		SetInfoText("Enable to consider the next equipped item for the addition of lactacid and addiction whenever you equip it again\nSet the sliders below to the desired levels, enable this toggle, go to your inventory and equip the food item\nIf you've already added this food item it will be updated with the current sliders")
	ElseIf (option == RemoveFoodOID)
		SetInfoText("Enable and equip a food item to remove its lactacid and addiction effects")
	ElseIf (option == SetupFoodLactacidOID_S)
		SetInfoText("The lactacid that should be gained when consuming the next food item you equip")
	ElseIf (option == SetupFoodAddictivenessOID_S)
		SetInfoText("The addiction that should be gained when consuming the next food item you equip")
	
	; Armor
	ElseIf (option == ArmorCapacityUnitsOID_S)
		SetInfoText("Your armor will not unequip until you reach this much milk\nSet to -1 to disable armor stripping ")
	ElseIf (option == ArmorCapacityOID_S)
		SetInfoText("If your milk exceeds the unit check, you are then checked against your total percentage capacity\nThis allows you to equip armor at higher milk values as your milk capacity/level grows")
	ElseIf (option == ClothesLimitUnitsOID_S)
		SetInfoText("Your clothes have no chance of ripping below this much milk\nSet to -1 to disable clothes ripping ")
	ElseIf (option == ClothesLimitOID_S)
		SetInfoText("If your milk exceeds the unit check, you are then checked against your total percentage capacity\nThis allows you to equip clothes at higher milk values as your milk capacity/level grows")
	ElseIf (option == ClothesTearChanceBaseOID_S)
		SetInfoText("The base chance of your clothes ripping when you exceed the unit check. Ripping is checked each game hour and when you equip clothes")
	ElseIf (option == ClothesTearChanceOID_S)
		SetInfoText("Additional chance of your clothes ripping. You gain this much % chance of ripping per % of your milk capacity above the limit\nEg: Capacity limit: 50%. Current capacity: 70%. Base chance: 10%. Chance per %: 0.5%\nTotal chance = Base chance + (0.5% X 20) = 20%")
	ElseIf (option == RepairCostMultOID_S)
		SetInfoText("How much should it cost to fix your clothes. Multiplies by the value of what you're trying to repair")
	ElseIf (option == TearVolumeOID_S)
		SetInfoText("The volume tear sounds should be played at")
	
	ElseIf (option == ClearSluttinessOID_T)
		SetInfoText("Clears all clothes sluttiness data saved to SlutClothes.json")
	ElseIf (option == SlutFactorOID)
		SetInfoText("How slutty your clothes are affects the milk capacity of those clothes and how likely they are to tear\nPrudish/Conservative/Modest - Penalty to capacity. Average- applys no penalty or bonus to capacity. Revealing/Whorish/Slutty - Bonus to capacity\nEcourages the player to wear more revealing clothes but needs honest input from you and your ability to 'eyeball' how slutty clothes are")
	ElseIf (option == SetupSlutClothesOID)
		SetInfoText("Set how slutty the next item of body clothes you equip is\nOverwrites current setting and setting saved to json file")
	ElseIf (option == CurrentAssScaleOID_T)
		SetInfoText("The current SLIF size of your ass ")
	ElseIf (option == AssScaleTearChanceOID_T)
		SetInfoText("The chance that your ass is contributing towards rip chance\nB -> Base. A -> Adjusted chance based on the sluttiness of your clothes")
	ElseIf (option == CurrentBellyScaleOID_T)
		SetInfoText("The current SLIF size of your belly ")
	ElseIf (option == BellyScaleTearChanceOIS_T)
		SetInfoText("The chance that your belly is contributing towards rip chance\nB -> Base. A -> Adjusted chance based on the sluttiness of your clothes")
		
	ElseIf (option == CurrentMilkOID_T || option == MilkCapMaxOID_T || option == CurrentTearChanceOID_T)
		SetInfoText("Your current chance to tear your clothes. Does not consider the first unit limit check\nIf you are over the unit limit this is you chance for ripping your clothes")
	ElseIf (option == ClothesDurabilityOID_S)
		SetInfoText("How many rips a clothing item can take before it turns into rags ")
	ElseIf (option == DurabilityToleranceOID_S)
		SetInfoText("A random durability added or subtracted from the base durability \nMake sure that the + / - is greater than the base!")
	ElseIf (option == HitRipChanceOID_S)
		SetInfoText("The chance your clothes have of ripping when hit with an unblocked attack\nPower attacks double the chance\nSet to zero to disable combat ripping")
	ElseIf (option == MagicArmorMultOID_S)
		SetInfoText("Magic armor spells protect your clothes from ripping. This value is multiplied by your rip chance\nTo make clothes invulnerable with a mage armor spell, set this to 0\nTo make mage armor spells have no effect at all, set this to 100\nTo make armor spells to reduce the chance of ripping by 50%, set this to 50, etc.")
	ElseIf (option == TearMultAttackOID_S)
		SetInfoText("How much a standard attack multiplies your tear chance by ")
	ElseIf (option == TearMultPowerAttackOID_S)
		SetInfoText("How much a power attack multiplies your tear chance by ")
	ElseIf (option == TearMultJumpOID_S)
		SetInfoText("How much a jump multiplies your tear chance by ")
	ElseIf (option == TearMultSprintOID_S)
		SetInfoText("How much sprinting multiplies your tear chance by ")
	ElseIf (option == TearMultBowOID_S)
		SetInfoText("How much drawing a bow multiplies your tear chance by ")
	ElseIf (option == TearMultMagicOID_S)
		SetInfoText("How much casting magic multiplies your tear chance by ")
	ElseIf (option == TearMultShoutOID_S)
		SetInfoText("How much shouting multiplies your tear chance by ")
	EndIf
endEvent

event OnOptionSliderOpen(int option)
	; Settings
	If (option == AddictionDecayOID_S)
		SetSliderDialogStartValue(AddictionDecay)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 50.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == TimeToFindClothesOID_S)
		SetSliderDialogStartValue(TimeToFindClothes)
		SetSliderDialogDefaultValue(20.0)
		SetSliderDialogRange(1.0, 30.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == CleavageMaxUnitsOID_S)
		SetSliderDialogStartValue(CleavageMaxUnits)
		SetSliderDialogDefaultValue(24.0)
		SetSliderDialogRange(1.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == LeakyBoobsVolumeOID_S)
		SetSliderDialogStartValue(LeakyBoobsVolume)
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(5.0)
	ElseIf (option == LactacidCeilingOID_S)
		SetSliderDialogStartValue(LactacidCeiling)
		SetSliderDialogDefaultValue(12.0)
		SetSliderDialogRange(RequiredLactJunkie, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == BreastRopeFreqOffsetOID_S)
		SetSliderDialogStartValue(BreastRopeFreqOffset)
		SetSliderDialogDefaultValue(20.0)
		SetSliderDialogRange(5.0, 120.0)
		SetSliderDialogInterval(5.0)
	ElseIf (option == RequiredLactMildOID_S)
		SetSliderDialogStartValue(RequiredLactMild)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 20.0)
		SetSliderDialogInterval(0.1)
	ElseIf (option == RequiredLactModerateOID_S)
		SetSliderDialogStartValue(RequiredLactModerate)
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(RequiredLactMild, 20.0)
		SetSliderDialogInterval(0.1)
	ElseIf (option == RequiredLactAddictOID_S)
		SetSliderDialogStartValue(RequiredLactAddict)
		SetSliderDialogDefaultValue(4.0)
		SetSliderDialogRange(RequiredLactModerate, 20.0)
		SetSliderDialogInterval(0.1)
	ElseIf (option == RequiredLactJunkieOID_S)
		SetSliderDialogStartValue(RequiredLactJunkie)
		SetSliderDialogDefaultValue(8.0)
		SetSliderDialogRange(RequiredLactAddict, 20.0)
		SetSliderDialogInterval(0.1)
	ElseIf (option == AssMaxScaleOID_S)
		SetSliderDialogStartValue(AssMaxScale)
		SetSliderDialogDefaultValue(2.5)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.1)
	ElseIf (option == AssLactMultOID_S)
		SetSliderDialogStartValue(AssLactMult)
		SetSliderDialogDefaultValue(0.0125)
		SetSliderDialogRange(0.0, 0.2)
		SetSliderDialogInterval(0.0025)
	ElseIf (option == RapeLactacidChanceOID_S)
		SetSliderDialogStartValue(RapeLactacidChance)
		SetSliderDialogDefaultValue(35.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)

	; Milk
	ElseIf (option == AffterEffectDebuffMagMultOID_S)
		SetSliderDialogStartValue(AfterEffectMagMult)
		SetSliderDialogDefaultValue(0.5)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.05)
	ElseIf (option == AffterEffectDebuffDurMultOID_S)
		SetSliderDialogStartValue(AfterEffectDurMult)
		SetSliderDialogDefaultValue(1.5)
		SetSliderDialogRange(0.0, 5.0)
		SetSliderDialogInterval(0.05)
		
	ElseIf (option == AproposHealBaseOID_S)
		SetSliderDialogStartValue(AproposHealBase)
		SetSliderDialogDefaultValue(5.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == AproposHealDeltaOID_S)
		SetSliderDialogStartValue(AproposHealDelta)
		SetSliderDialogDefaultValue(5.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
		
	ElseIf (option == AddictivenessDiluteOID_S)
		SetSliderDialogStartValue(AddictivenessDilute)
		SetSliderDialogDefaultValue(3.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == AddictivenessWeakOID_S)
		SetSliderDialogStartValue(AddictivenessWeak)
		SetSliderDialogDefaultValue(4.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == AddictivenessRegularOID_S)
		SetSliderDialogStartValue(AddictivenessRegular)
		SetSliderDialogDefaultValue(5.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == AddictivenessStrongOID_S)
		SetSliderDialogStartValue(AddictivenessStrong)
		SetSliderDialogDefaultValue(7.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == AddictivenessTastyOID_S)
		SetSliderDialogStartValue(AddictivenessTasty)
		SetSliderDialogDefaultValue(11.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == AddictivenessCreamyOID_S)
		SetSliderDialogStartValue(AddictivenessCreamy)
		SetSliderDialogDefaultValue(16.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)	
	ElseIf (option == AddictivenessEnrichedOID_S)
		SetSliderDialogStartValue(AddictivenessEnriched)
		SetSliderDialogDefaultValue(24.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == AddictivenessSublimeOID_S)
		SetSliderDialogStartValue(AddictivenessSublime)
		SetSliderDialogDefaultValue(31.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == AddictivenessLactacidOID_S)
		SetSliderDialogStartValue(AddictivenessLactacid)
		SetSliderDialogDefaultValue(49.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
		
	ElseIf (option == LactacidDiluteOID_S)
		SetSliderDialogStartValue(LactacidDilute)
		SetSliderDialogDefaultValue(0.1)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ElseIf (option == LactacidWeakOID_S)
		SetSliderDialogStartValue(LactacidWeak)
		SetSliderDialogDefaultValue(0.2)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ElseIf (option == LactacidRegularOID_S)
		SetSliderDialogStartValue(LactacidRegular)
		SetSliderDialogDefaultValue(0.3)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ElseIf (option == LactacidStrongOID_S)
		SetSliderDialogStartValue(LactacidStrong)
		SetSliderDialogDefaultValue(0.4)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ElseIf (option == LactacidTastyOID_S)
		SetSliderDialogStartValue(LactacidTasty)
		SetSliderDialogDefaultValue(0.5)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ElseIf (option == LactacidCreamyOID_S)
		SetSliderDialogStartValue(LactacidCreamy)
		SetSliderDialogDefaultValue(0.65)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)	
	ElseIf (option == LactacidEnrichedOID_S)
		SetSliderDialogStartValue(LactacidEnriched)
		SetSliderDialogDefaultValue(24.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ElseIf (option == LactacidSublimeOID_S)
		SetSliderDialogStartValue(LactacidSublime)
		SetSliderDialogDefaultValue(0.8)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ElseIf (option == LactacidLactacidOID_S)
		SetSliderDialogStartValue(LactacidLactacid)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
		
	ElseIf (option == SpeedDiluteOID_S)
		SetSliderDialogStartValue(SpeedDilute)
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == SpeedWeakOID_S)
		SetSliderDialogStartValue(SpeedWeak)
		SetSliderDialogDefaultValue(15.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == SpeedRegularOID_S)
		SetSliderDialogStartValue(SpeedRegular)
		SetSliderDialogDefaultValue(20.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == SpeedStrongOID_S)
		SetSliderDialogStartValue(SpeedStrong)
		SetSliderDialogDefaultValue(25.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == SpeedTastyOID_S)
		SetSliderDialogStartValue(SpeedTasty)
		SetSliderDialogDefaultValue(30.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == SpeedCreamyOID_S)
		SetSliderDialogStartValue(SpeedCreamy)
		SetSliderDialogDefaultValue(35.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)	
	ElseIf (option == SpeedEnrichedOID_S)
		SetSliderDialogStartValue(SpeedEnriched)
		SetSliderDialogDefaultValue(40.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == SpeedSublimeOID_S)
		SetSliderDialogStartValue(SpeedSublime)
		SetSliderDialogDefaultValue(50.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
		
	ElseIf (option == StaminaRateDiluteOID_S)
		SetSliderDialogStartValue(StaminaRateDilute)
		SetSliderDialogDefaultValue(35.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == StaminaRateWeakOID_S)
		SetSliderDialogStartValue(StaminaRateWeak)
		SetSliderDialogDefaultValue(40.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == StaminaRateRegularOID_S)
		SetSliderDialogStartValue(StaminaRateRegular)
		SetSliderDialogDefaultValue(45.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == StaminaRateStrongOID_S)
		SetSliderDialogStartValue(StaminaRateStrong)
		SetSliderDialogDefaultValue(50.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == StaminaRateTastyOID_S)
		SetSliderDialogStartValue(StaminaRateTasty)
		SetSliderDialogDefaultValue(55.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == StaminaRateCreamyOID_S)
		SetSliderDialogStartValue(StaminaRateCreamy)
		SetSliderDialogDefaultValue(60.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)	
	ElseIf (option == StaminaRateEnrichedOID_S)
		SetSliderDialogStartValue(StaminaRateEnriched)
		SetSliderDialogDefaultValue(65.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == StaminaRateSublimeOID_S)
		SetSliderDialogStartValue(StaminaRateSublime)
		SetSliderDialogDefaultValue(70.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
		
	ElseIf (option == DurationDiluteOID_S)
		SetSliderDialogStartValue(DurationDilute)
		SetSliderDialogDefaultValue(120.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == DurationWeakOID_S)
		SetSliderDialogStartValue(DurationWeak)
		SetSliderDialogDefaultValue(150.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == DurationRegularOID_S)
		SetSliderDialogStartValue(DurationRegular)
		SetSliderDialogDefaultValue(180.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == DurationStrongOID_S)
		SetSliderDialogStartValue(DurationStrong)
		SetSliderDialogDefaultValue(210.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == DurationTastyOID_S)
		SetSliderDialogStartValue(DurationTasty)
		SetSliderDialogDefaultValue(240.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == DurationCreamyOID_S)
		SetSliderDialogStartValue(DurationCreamy)
		SetSliderDialogDefaultValue(270.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1.0)	
	ElseIf (option == DurationEnrichedOID_S)
		SetSliderDialogStartValue(DurationEnriched)
		SetSliderDialogDefaultValue(300.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == DurationSublimeOID_S)
		SetSliderDialogStartValue(DurationSublime)
		SetSliderDialogDefaultValue(360.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1.0)
		
	; Trip / Slip
	ElseIf (option == TripStripChanceLocationModOID_S)
		SetSliderDialogStartValue(TripStripChanceLocationMod)
		SetSliderDialogDefaultValue(0.25)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf (option == TripArousalReqOID_S)
		SetSliderDialogStartValue(TripArousalReq)
		SetSliderDialogDefaultValue(30.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == TripDistanceReqOID_S)
		SetSliderDialogStartValue(TripDistanceReq)
		SetSliderDialogDefaultValue(500.0)
		SetSliderDialogRange(0.0, 2000.0)
		SetSliderDialogInterval(100.0)
	ElseIf (option == MountCooldownTimeOID_S)
		SetSliderDialogStartValue(MountCooldownTime)
		SetSliderDialogDefaultValue(60.0)
		SetSliderDialogRange(0.0, 600.0)
		SetSliderDialogInterval(10.0)
		
	ElseIf (option == TripFreqModerateOID_S)
		SetSliderDialogStartValue(TripFreqModerate)
		SetSliderDialogDefaultValue(30.0)
		SetSliderDialogRange(1.0, 600.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == TripFreqAddictOID_S)
		SetSliderDialogStartValue(TripFreqAddict)
		SetSliderDialogDefaultValue(20.0)
		SetSliderDialogRange(1.0, 600.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == TripFreqJunkieOID_S)
		SetSliderDialogStartValue(TripFreqJunkie)
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(1.0, 600.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == TripChanceModerateOID_S)
		SetSliderDialogStartValue(TripChanceModerate)
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == TripChanceAddictOID_S)
		SetSliderDialogStartValue(TripChanceAddict)
		SetSliderDialogDefaultValue(15.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == TripChanceJunkieOID_S)
		SetSliderDialogStartValue(TripChanceJunkie)
		SetSliderDialogDefaultValue(25.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
		
	ElseIf (option == SlipFreqModerateOID_S)
		SetSliderDialogStartValue(SlipFreqModerate)
		SetSliderDialogDefaultValue(30.0)
		SetSliderDialogRange(1.0, 600.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == SlipFreqAddictOID_S)
		SetSliderDialogStartValue(SlipFreqAddict)
		SetSliderDialogDefaultValue(20.0)
		SetSliderDialogRange(1.0, 600.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == SlipFreqJunkieOID_S)
		SetSliderDialogStartValue(SlipFreqJunkie)
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(1.0, 600.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == SlipChanceModerateOID_S)
		SetSliderDialogStartValue(SlipChanceModerate)
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == SlipChanceAddictOID_S)
		SetSliderDialogStartValue(SlipChanceAddict)
		SetSliderDialogDefaultValue(15.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == SlipChanceJunkieOID_S)
		SetSliderDialogStartValue(SlipChanceJunkie)
		SetSliderDialogDefaultValue(25.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
		
	ElseIf (option == AdditionalTripDropChanceModerateOID_S)
		SetSliderDialogStartValue(AdditionalTripDropChanceModerate)
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == AdditionalTripDropChanceAddictOID_S)
		SetSliderDialogStartValue(AdditionalTripDropChanceAddict)
		SetSliderDialogDefaultValue(20.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == AdditionalTripDropChanceJunkieOID_S)
		SetSliderDialogStartValue(AdditionalTripDropChanceJunkie)
		SetSliderDialogDefaultValue(35.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
		
	; NPC Milking
	ElseIf (option == BoobgasmChanceOID_S)
		SetSliderDialogStartValue(BoobgasmChance)
		SetSliderDialogDefaultValue(5.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == BoobgasmChancePerLevelOID_S)
		SetSliderDialogStartValue(BoobgasmChancePerLevel)
		SetSliderDialogDefaultValue(3.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == NpcMilkingCostOID_S)
		SetSliderDialogStartValue(NpcMilkingCost)
		SetSliderDialogDefaultValue(50.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(25.0)
	ElseIf (option == FreshAddictivenessMultOID_S)
		SetSliderDialogStartValue(FreshAddictivenessMult)
		SetSliderDialogDefaultValue(1.5)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.1)
	ElseIf (option == FreshLactacidMultOID_S)
		SetSliderDialogStartValue(FreshLactacidMult)
		SetSliderDialogDefaultValue(1.5)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.1)
	ElseIf (option == SgoMilkProductionTimeOID_S)
		Init.GetSgoMilkTime()
		SetSliderDialogStartValue(Init.SgoOptMilkProduceTime)
		SetSliderDialogDefaultValue(24.0)
		SetSliderDialogRange(1.0, 168.0)
		SetSliderDialogInterval(1)
	ElseIf (option == MmeMilkProductionRateOID_S)
		SetSliderDialogStartValue(MilkQ.MilkProdMod)
		SetSliderDialogDefaultValue(5.0)
		SetSliderDialogRange(1.0, 200.0)
		SetSliderDialogInterval(1)
	ElseIf (option == NpcInvMilkQuantityOID_S)
		SetSliderDialogStartValue(NpcInvMilkQuantity)
		SetSliderDialogDefaultValue(5.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(1)
	ElseIf (option == NpcInvMilkChanceOID_S)
		SetSliderDialogStartValue(NpcInvMilkChance)
		SetSliderDialogDefaultValue(3.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(0.1)
	
	; Food
	ElseIf (option == SetupFoodLactacidOID_S)
		SetSliderDialogStartValue(SetupFoodLactacid)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ElseIf (option == SetupFoodAddictivenessOID_S)
		SetSliderDialogStartValue(SetupFoodAddictiveness)
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1)
		
	; Armor
	ElseIf (option == ArmorCapacityUnitsOID_S)
		SetSliderDialogStartValue(ArmorCapacityUnits)
		SetSliderDialogDefaultValue(4.0)
		SetSliderDialogRange(-1.0, 10.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == ArmorCapacityOID_S)
		SetSliderDialogStartValue(ArmorCapacity)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == ClothesLimitUnitsOID_S)
		SetSliderDialogStartValue(ClothesLimitUnits)
		SetSliderDialogDefaultValue(6.0)
		SetSliderDialogRange(-1.0, 20.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == ClothesLimitOID_S)
		SetSliderDialogStartValue(ClothesLimit)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == ClothesTearChanceBaseOID_S)
		SetSliderDialogStartValue(ClothesTearChanceBase)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == ClothesTearChanceBellyOID_S)
		SetSliderDialogStartValue(ClothesTearChanceBelly)
		SetSliderDialogDefaultValue(0.2)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.1)
	ElseIf (option == ClothesTearChanceAssOID_S)
		SetSliderDialogStartValue(ClothesTearChanceAss)
		SetSliderDialogDefaultValue(0.3)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.1)
		
	ElseIf (option == ClothesTearChanceOID_S)
		SetSliderDialogStartValue(ClothesTearChance)
		SetSliderDialogDefaultValue(0.5)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.1)
	ElseIf (option == RepairCostMultOID_S)
		SetSliderDialogStartValue(RepairCostMult)
		SetSliderDialogDefaultValue(0.5)
		SetSliderDialogRange(0.0, 5.0)
		SetSliderDialogInterval(0.1)
	ElseIf (option == TearVolumeOID_S)
		SetSliderDialogStartValue(TearVolume * 100.0)
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(5)
		
	ElseIf (option == ClothesDurabilityOID_S)
		SetSliderDialogStartValue(ClothesDurability)
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0, 50.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == DurabilityToleranceOID_S)
		SetSliderDialogStartValue(DurabilityTolerance)
		SetSliderDialogDefaultValue(3.0)
		SetSliderDialogRange(0.0, 20.0)
		SetSliderDialogInterval(1.0)
		
	ElseIf (option == HitRipChanceOID_S)
		SetSliderDialogStartValue(HitRipChance)
		SetSliderDialogDefaultValue(35.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == MagicArmorMultOID_S)
		SetSliderDialogStartValue(MagicArmorMult)
		SetSliderDialogDefaultValue(50.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
		
	ElseIf (option == TearMultAttackOID_S)
		SetSliderDialogStartValue(TearMultAttack)
		SetSliderDialogDefaultValue(0.5)
		SetSliderDialogRange(0.0, 3.0)
		SetSliderDialogInterval(0.05)
	ElseIf (option == TearMultPowerAttackOID_S)
		SetSliderDialogStartValue(TearMultPowerAttack)
		SetSliderDialogDefaultValue(1.5)
		SetSliderDialogRange(0.0, 3.0)
		SetSliderDialogInterval(0.05)
	ElseIf (option == TearMultJumpOID_S)
		SetSliderDialogStartValue(TearMultJump)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 3.0)
		SetSliderDialogInterval(0.05)
	ElseIf (option == TearMultSprintOID_S)
		SetSliderDialogStartValue(TearMultSprint)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 3.0)
		SetSliderDialogInterval(0.05)
	ElseIf (option == TearMultBowOID_S)
		SetSliderDialogStartValue(TearMultBow)
		SetSliderDialogDefaultValue(0.8)
		SetSliderDialogRange(0.0, 3.0)
		SetSliderDialogInterval(0.05)
	ElseIf (option == TearMultMagicOID_S)
		SetSliderDialogStartValue(TearMultMagic)
		SetSliderDialogDefaultValue(0.5)
		SetSliderDialogRange(0.0, 3.0)
		SetSliderDialogInterval(0.05)
	ElseIf (option == TearMultShoutOID_S)
		SetSliderDialogStartValue(TearMultShout)
		SetSliderDialogDefaultValue(1.3)
		SetSliderDialogRange(0.0, 3.0)
		SetSliderDialogInterval(0.05)
		
	EndIf
endEvent

event OnOptionSliderAccept(int option, float value)
	; Settings
	If (option == AddictionDecayOID_S)
		AddictionDecay = value as Int
		SetSliderOptionValue(AddictionDecayOID_S, AddictionDecay)
	ElseIf (option == TimeToFindClothesOID_S)
		TimeToFindClothes = value as Int
		SetSliderOptionValue(TimeToFindClothesOID_S, TimeToFindClothes)
	ElseIf (option == CleavageMaxUnitsOID_S)
		CleavageMaxUnits = value as Int
		SetSliderOptionValue(CleavageMaxUnitsOID_S, CleavageMaxUnits)
	ElseIf (option == LeakyBoobsVolumeOID_S)
		LeakyBoobsVolume = value
		SetSliderOptionValue(LeakyBoobsVolumeOID_S, LeakyBoobsVolume)
		
	ElseIf (option == LactacidCeilingOID_S)
		LactacidCeiling = value
		SetSliderOptionValue(LactacidCeilingOID_S, LactacidCeiling)
	ElseIf (option == BreastRopeFreqOffsetOID_S)
		BreastRopeFreqOffset = value
		SetSliderOptionValue(BreastRopeFreqOffsetOID_S, BreastRopeFreqOffset)
		
	ElseIf (option == RequiredLactMildOID_S)
		RequiredLactMild = value
		SetSliderOptionValue(RequiredLactMildOID_S, RequiredLactMild)
	ElseIf (option == RequiredLactModerateOID_S)
		RequiredLactModerate = value
		SetSliderOptionValue(RequiredLactModerateOID_S, RequiredLactModerate)
	ElseIf (option == RequiredLactAddictOID_S)
		RequiredLactAddict = value
		SetSliderOptionValue(RequiredLactAddictOID_S, RequiredLactAddict)
	ElseIf (option == RequiredLactJunkieOID_S)
		RequiredLactJunkie = value
		SetSliderOptionValue(RequiredLactJunkieOID_S, RequiredLactJunkie)
		If RequiredLactJunkie > LactacidCeiling
			LactacidCeiling = RequiredLactJunkie
		EndIf
		
	ElseIf (option == AssMaxScaleOID_S)
		AssMaxScale = value
		SetSliderOptionValue(AssMaxScaleOID_S, AssMaxScale)
	ElseIf (option == AssLactMultOID_S)
		AssLactMult = value
		SetSliderOptionValue(AssLactMultOID_S, AssLactMult)
	ElseIf (option == RapeLactacidChanceOID_S)
		RapeLactacidChance = value
		SetSliderOptionValue(RapeLactacidChanceOID_S, RapeLactacidChance)
		
	; Milk
	ElseIf (option == AffterEffectDebuffMagMultOID_S)
		AfterEffectMagMult = value
		SetSliderOptionValue(AffterEffectDebuffMagMultOID_S, AfterEffectMagMult)
	ElseIf (option == AffterEffectDebuffDurMultOID_S)
		AfterEffectDurMult = value
		SetSliderOptionValue(AffterEffectDebuffDurMultOID_S, AfterEffectDurMult)
	
	ElseIf (option == AproposHealBaseOID_S)
		AproposHealBase = value as Int
		SetSliderOptionValue(AproposHealBaseOID_S, AproposHealBase)
	ElseIf (option == AproposHealDeltaOID_S)
		AproposHealDelta = value as Int
		SetSliderOptionValue(AproposHealDeltaOID_S, AproposHealDelta)
		
	ElseIf (option == AddictivenessDiluteOID_S)
		AddictivenessDilute = value as Int
		SetSliderOptionValue(AddictivenessDiluteOID_S, AddictivenessDilute)
	ElseIf (option == AddictivenessWeakOID_S)
		AddictivenessWeak = value as Int
		SetSliderOptionValue(AddictivenessWeakOID_S, AddictivenessWeak)
	ElseIf (option == AddictivenessRegularOID_S)
		AddictivenessRegular = value as Int
		SetSliderOptionValue(AddictivenessRegularOID_S, AddictivenessRegular)
	ElseIf (option == AddictivenessStrongOID_S)
		AddictivenessStrong = value as Int
		SetSliderOptionValue(AddictivenessStrongOID_S, AddictivenessStrong)
	ElseIf (option == AddictivenessTastyOID_S)
		AddictivenessTasty = value as Int
		SetSliderOptionValue(AddictivenessTastyOID_S, AddictivenessTasty)
	ElseIf (option == AddictivenessCreamyOID_S)
		AddictivenessCreamy = value as Int
		SetSliderOptionValue(AddictivenessCreamyOID_S, AddictivenessCreamy)
	ElseIf (option == AddictivenessEnrichedOID_S)
		AddictivenessEnriched = value as Int
		SetSliderOptionValue(AddictivenessEnrichedOID_S, AddictivenessEnriched)
	ElseIf (option == AddictivenessSublimeOID_S)
		AddictivenessSublime = value as Int
		SetSliderOptionValue(AddictivenessSublimeOID_S, AddictivenessSublime)
	ElseIf (option == AddictivenessLactacidOID_S)
		AddictivenessLactacid = value as Int
		SetSliderOptionValue(AddictivenessLactacidOID_S, AddictivenessLactacid)

	ElseIf (option == LactacidDiluteOID_S)
		LactacidDilute = value
		SetSliderOptionValue(LactacidDiluteOID_S, LactacidDilute)
	ElseIf (option == LactacidWeakOID_S)
		LactacidWeak = value
		SetSliderOptionValue(LactacidWeakOID_S, LactacidWeak)
	ElseIf (option == LactacidRegularOID_S)
		LactacidRegular = value
		SetSliderOptionValue(LactacidRegularOID_S, LactacidRegular)
	ElseIf (option == LactacidStrongOID_S)
		LactacidStrong = value
		SetSliderOptionValue(LactacidStrongOID_S, LactacidStrong)
	ElseIf (option == LactacidTastyOID_S)
		LactacidTasty = value
		SetSliderOptionValue(LactacidTastyOID_S, LactacidTasty)
	ElseIf (option == LactacidCreamyOID_S)
		LactacidCreamy = value
		SetSliderOptionValue(LactacidCreamyOID_S, LactacidCreamy)
	ElseIf (option == LactacidEnrichedOID_S)
		LactacidEnriched = value
		SetSliderOptionValue(LactacidEnrichedOID_S, LactacidEnriched)
	ElseIf (option == LactacidSublimeOID_S)
		LactacidSublime = value
		SetSliderOptionValue(LactacidSublimeOID_S, LactacidSublime)
	ElseIf (option == LactacidLactacidOID_S)
		LactacidLactacid = value
		SetSliderOptionValue(LactacidLactacidOID_S, LactacidLactacid)
		
	ElseIf (option == SpeedDiluteOID_S)
		SpeedDilute = value
		SetSliderOptionValue(SpeedDiluteOID_S, SpeedDilute)
	ElseIf (option == SpeedWeakOID_S)
		SpeedWeak = value
		SetSliderOptionValue(SpeedWeakOID_S, SpeedWeak)
	ElseIf (option == SpeedRegularOID_S)
		SpeedRegular = value
		SetSliderOptionValue(SpeedRegularOID_S, SpeedRegular)
	ElseIf (option == SpeedStrongOID_S)
		SpeedStrong = value
		SetSliderOptionValue(SpeedStrongOID_S, SpeedStrong)
	ElseIf (option == SpeedTastyOID_S)
		SpeedTasty = value
		SetSliderOptionValue(SpeedTastyOID_S, SpeedTasty)
	ElseIf (option == SpeedCreamyOID_S)
		SpeedCreamy = value
		SetSliderOptionValue(SpeedCreamyOID_S, SpeedCreamy)
	ElseIf (option == SpeedEnrichedOID_S)
		SpeedEnriched = value
		SetSliderOptionValue(SpeedEnrichedOID_S, SpeedEnriched)
	ElseIf (option == SpeedSublimeOID_S)
		SpeedSublime = value
		SetSliderOptionValue(SpeedSublimeOID_S, SpeedSublime)
	
	ElseIf (option == StaminaRateDiluteOID_S)
		StaminaRateDilute = value
		SetSliderOptionValue(StaminaRateDiluteOID_S, StaminaRateDilute)
	ElseIf (option == StaminaRateWeakOID_S)
		StaminaRateWeak = value
		SetSliderOptionValue(StaminaRateWeakOID_S, StaminaRateWeak)
	ElseIf (option == StaminaRateRegularOID_S)
		StaminaRateRegular = value
		SetSliderOptionValue(StaminaRateRegularOID_S, StaminaRateRegular)
	ElseIf (option == StaminaRateStrongOID_S)
		StaminaRateStrong = value
		SetSliderOptionValue(StaminaRateStrongOID_S, StaminaRateStrong)
	ElseIf (option == StaminaRateTastyOID_S)
		StaminaRateTasty = value
		SetSliderOptionValue(StaminaRateTastyOID_S, StaminaRateTasty)
	ElseIf (option == StaminaRateCreamyOID_S)
		StaminaRateCreamy = value
		SetSliderOptionValue(StaminaRateCreamyOID_S, StaminaRateCreamy)
	ElseIf (option == StaminaRateEnrichedOID_S)
		StaminaRateEnriched = value
		SetSliderOptionValue(StaminaRateEnrichedOID_S, StaminaRateEnriched)
	ElseIf (option == StaminaRateSublimeOID_S)
		StaminaRateSublime = value
		SetSliderOptionValue(StaminaRateSublimeOID_S, StaminaRateSublime)
		
	ElseIf (option == DurationDiluteOID_S)
		DurationDilute = value as Int
		SetSliderOptionValue(DurationDiluteOID_S, DurationDilute)
	ElseIf (option == DurationWeakOID_S)
		DurationWeak = value as Int
		SetSliderOptionValue(DurationWeakOID_S, DurationWeak)
	ElseIf (option == DurationRegularOID_S)
		DurationRegular = value as Int
		SetSliderOptionValue(DurationRegularOID_S, DurationRegular)
	ElseIf (option == DurationStrongOID_S)
		DurationStrong = value as Int
		SetSliderOptionValue(DurationStrongOID_S, DurationStrong)
	ElseIf (option == DurationTastyOID_S)
		DurationTasty = value as Int
		SetSliderOptionValue(DurationTastyOID_S, DurationTasty)
	ElseIf (option == DurationCreamyOID_S)
		DurationCreamy = value as Int
		SetSliderOptionValue(DurationCreamyOID_S, DurationCreamy)
	ElseIf (option == DurationEnrichedOID_S)
		DurationEnriched = value as Int
		SetSliderOptionValue(DurationEnrichedOID_S, DurationEnriched)
	ElseIf (option == DurationSublimeOID_S)
		DurationSublime = value as Int
		SetSliderOptionValue(DurationSublimeOID_S, DurationSublime)
		
	; Trip / Slip
	ElseIf (option == TripStripChanceLocationModOID_S)
		TripStripChanceLocationMod = value
		SetSliderOptionValue(TripStripChanceLocationModOID_S, TripStripChanceLocationMod)
	ElseIf (option == TripArousalReqOID_S)
		TripArousalReq = value
		SetSliderOptionValue(TripArousalReqOID_S, TripArousalReq)
	ElseIf (option == TripDistanceReqOID_S)
		TripDistanceReq = value
		SetSliderOptionValue(TripDistanceReqOID_S, TripDistanceReq)
	ElseIf (option == MountCooldownTimeOID_S)
		MountCooldownTime = value as Int
		SetSliderOptionValue(MountCooldownTimeOID_S, MountCooldownTime)
		
	ElseIf (option == TripFreqModerateOID_S)
		TripFreqModerate = value
		SetSliderOptionValue(TripFreqModerateOID_S, TripFreqModerate)
		Main.SetAddictionEffects()
	ElseIf (option == TripFreqAddictOID_S)
		TripFreqAddict = value
		SetSliderOptionValue(TripFreqAddictOID_S, TripFreqAddict)
		Main.SetAddictionEffects()
	ElseIf (option == TripFreqJunkieOID_S)
		TripFreqJunkie = value
		SetSliderOptionValue(TripFreqJunkieOID_S, TripFreqJunkie)
		Main.SetAddictionEffects()
	ElseIf (option == TripChanceModerateOID_S)
		TripChanceModerate = value
		SetSliderOptionValue(TripChanceModerateOID_S, TripChanceModerate)
		Main.SetAddictionEffects()
	ElseIf (option == TripChanceAddictOID_S)
		TripChanceAddict = value
		SetSliderOptionValue(TripChanceAddictOID_S, TripChanceAddict)
		Main.SetAddictionEffects()
	ElseIf (option == TripChanceJunkieOID_S)
		TripChanceJunkie = value
		SetSliderOptionValue(TripChanceJunkieOID_S, TripChanceJunkie)
		Main.SetAddictionEffects()
		
	ElseIf (option == SlipFreqModerateOID_S)
		SlipFreqModerate = value
		SetSliderOptionValue(SlipFreqModerateOID_S, SlipFreqModerate)
		Main.SetAddictionEffects()
	ElseIf (option == SlipFreqAddictOID_S)
		SlipFreqAddict = value
		SetSliderOptionValue(SlipFreqAddictOID_S, SlipFreqAddict)
		Main.SetAddictionEffects()
	ElseIf (option == SlipFreqJunkieOID_S)
		SlipFreqJunkie = value
		SetSliderOptionValue(SlipFreqJunkieOID_S, SlipFreqJunkie)
		Main.SetAddictionEffects()
	ElseIf (option == SlipChanceModerateOID_S)
		SlipChanceModerate = value
		SetSliderOptionValue(SlipChanceModerateOID_S, SlipChanceModerate)
		Main.SetAddictionEffects()
	ElseIf (option == SlipChanceAddictOID_S)
		SlipChanceAddict = value
		SetSliderOptionValue(SlipChanceAddictOID_S, SlipChanceAddict)
		Main.SetAddictionEffects()
	ElseIf (option == SlipChanceJunkieOID_S)
		SlipChanceJunkie = value
		SetSliderOptionValue(SlipChanceJunkieOID_S, SlipChanceJunkie)
		Main.SetAddictionEffects()
		
	ElseIf (option == AdditionalTripDropChanceModerateOID_S)
		AdditionalTripDropChanceModerate = value
		SetSliderOptionValue(AdditionalTripDropChanceModerateOID_S, AdditionalTripDropChanceModerate)
		Main.SetAddictionEffects()
	ElseIf (option == AdditionalTripDropChanceAddictOID_S)
		AdditionalTripDropChanceAddict = value
		SetSliderOptionValue(AdditionalTripDropChanceAddictOID_S, AdditionalTripDropChanceAddict)
		Main.SetAddictionEffects()
	ElseIf (option == AdditionalTripDropChanceJunkieOID_S)
		AdditionalTripDropChanceJunkie = value
		SetSliderOptionValue(AdditionalTripDropChanceJunkieOID_S, AdditionalTripDropChanceJunkie)
		Main.SetAddictionEffects()
		
	; NPC Milking
	ElseIf (option == BoobgasmChanceOID_S)
		BoobgasmChance = value
		SetSliderOptionValue(BoobgasmChanceOID_S, BoobgasmChance)
	ElseIf (option == BoobgasmChancePerLevelOID_S)
		BoobgasmChancePerLevel = value
		SetSliderOptionValue(BoobgasmChancePerLevelOID_S, BoobgasmChancePerLevel)
	ElseIf (option == NpcMilkingCostOID_S)
		NpcMilkingCost = value
		SetSliderOptionValue(NpcMilkingCostOID_S, NpcMilkingCost)
	ElseIf (option == FreshAddictivenessMultOID_S)
		FreshAddictivenessMult = value
		SetSliderOptionValue(FreshAddictivenessMultOID_S, FreshAddictivenessMult)
	ElseIf (option == FreshLactacidMultOID_S)
		FreshLactacidMult = value
		SetSliderOptionValue(FreshLactacidMultOID_S, FreshLactacidMult)
	ElseIf (option == SgoMilkProductionTimeOID_S)
		SgoMilkProductionTime = value
		Init.SetSgoMilkTime()
		SetSliderOptionValue(SgoMilkProductionTimeOID_S, SgoMilkProductionTime)
	ElseIf (option == MmeMilkProductionRateOID_S)
		MilkQ.MilkProdMod = value
		SetSliderOptionValue(MmeMilkProductionRateOID_S, MilkQ.MilkProdMod)
	ElseIf (option == NpcInvMilkQuantityOID_S)
		NpcInvMilkQuantity = value as Int
		SetSliderOptionValue(NpcInvMilkQuantityOID_S, NpcInvMilkQuantity)
		SetupNpcInvMilkPerk()
	ElseIf (option == NpcInvMilkChanceOID_S)
		NpcInvMilkChance = value
		SetSliderOptionValue(NpcInvMilkChanceOID_S, NpcInvMilkChance)
		SetupNpcInvMilkPerk()
		
	; Food
	ElseIf (option == SetupFoodLactacidOID_S)
		SetupFoodLactacid = value
		SetSliderOptionValue(SetupFoodLactacidOID_S, SetupFoodLactacid)
	ElseIf (option == SetupFoodAddictivenessOID_S)
		SetupFoodAddictiveness = value as Int
		SetSliderOptionValue(SetupFoodAddictivenessOID_S, SetupFoodAddictiveness)
		
	; Armor
	ElseIf (option == ArmorCapacityUnitsOID_S)
		ArmorCapacityUnits = value
		SetSliderOptionValue(ArmorCapacityUnitsOID_S, ArmorCapacityUnits)
	ElseIf (option == ArmorCapacityOID_S)
		ArmorCapacity = value
		SetSliderOptionValue(ArmorCapacityOID_S, ArmorCapacity)
	ElseIf (option == ClothesLimitUnitsOID_S)
		ClothesLimitUnits = value
		SetSliderOptionValue(ClothesLimitUnitsOID_S, ClothesLimitUnits)
		Main.UpdateRipChance()
	ElseIf (option == ClothesLimitOID_S)
		ClothesLimit = value
		SetSliderOptionValue(ClothesLimitOID_S, ClothesLimit)
		Main.UpdateRipChance()
	ElseIf (option == ClothesTearChanceBaseOID_S)
		ClothesTearChanceBase = value
		SetSliderOptionValue(ClothesTearChanceBaseOID_S, ClothesTearChanceBase)
		Main.UpdateRipChance()
	ElseIf (option == ClothesTearChanceOID_S)
		ClothesTearChance = value
		SetSliderOptionValue(ClothesTearChanceOID_S, ClothesTearChance)
		Main.UpdateRipChance()
	ElseIf (option == ClothesTearChanceBellyOID_S)
		ClothesTearChanceBelly = value
		SetSliderOptionValue(ClothesTearChanceBellyOID_S, ClothesTearChanceBelly)
		Main.UpdateRipChance()
	ElseIf (option == ClothesTearChanceAssOID_S)
		ClothesTearChanceAss = value
		SetSliderOptionValue(ClothesTearChanceAssOID_S, ClothesTearChanceAss)
		Main.UpdateRipChance()
		
		
	ElseIf (option == RepairCostMultOID_S)
		RepairCostMult = value
		SetSliderOptionValue(RepairCostMultOID_S, RepairCostMult)
	ElseIf (option == TearVolumeOID_S)
		TearVolume = value/100.0
		SetSliderOptionValue(TearVolumeOID_S, TearVolume * 100.0)
	ElseIf (option == ClothesDurabilityOID_S)
		ClothesDurability = value as Int
		SetSliderOptionValue(ClothesDurabilityOID_S, ClothesDurability)
	ElseIf (option == DurabilityToleranceOID_S)
		DurabilityTolerance = value as Int
		SetSliderOptionValue(DurabilityToleranceOID_S, DurabilityTolerance)
	ElseIf (option == HitRipChanceOID_S)
		HitRipChance = value
		SetSliderOptionValue(HitRipChanceOID_S, HitRipChance)
	ElseIf (option == MagicArmorMultOID_S)
		MagicArmorMult = value
		SetSliderOptionValue(MagicArmorMultOID_S, MagicArmorMult)
	ElseIf (option == TearMultAttackOID_S)
		TearMultAttack = value
		SetSliderOptionValue(TearMultAttackOID_S, TearMultAttack)
	ElseIf (option == TearMultPowerAttackOID_S)
		TearMultPowerAttack = value
		SetSliderOptionValue(TearMultPowerAttackOID_S, TearMultPowerAttack)
	ElseIf (option == TearMultJumpOID_S)
		TearMultJump = value
		SetSliderOptionValue(TearMultJumpOID_S, TearMultJump)
	ElseIf (option == TearMultSprintOID_S)
		TearMultSprint = value
		SetSliderOptionValue(TearMultSprintOID_S, TearMultSprint)
	ElseIf (option == TearMultBowOID_S)
		TearMultBow = value
		SetSliderOptionValue(TearMultBowOID_S, TearMultBow)
	ElseIf (option == TearMultMagicOID_S)
		TearMultMagic = value
		SetSliderOptionValue(TearMultMagicOID_S, TearMultMagic)
	ElseIf (option == TearMultShoutOID_S)
		TearMultShout = value
		SetSliderOptionValue(TearMultShoutOID_S, TearMultShout)
	EndIf
	ForcePageReset()
endEvent

; Functions Begin =======================================================

Function ConfigureDropSlots()

;0x00000004 AutoReadOnly ; BODY
;0x00000001 AutoReadOnly ; HEAD
;0x00000002 AutoReadOnly ; HAIR
;0x00000080 AutoReadOnly ; Feet
;0x00000008 AutoReadOnly ; Hands

	; Zero array
	Int i = 0
	While i < DropSlots.Length
		DropSlots[i] = 0
		DroppedClothesAliases[i] = None
		i += 1
	EndWhile
	i = 0
	
	;Body
	If DropBodyT
		DropSlots[i] = 4
		DroppedClothesAliases[i] = DroppedClothesBody
		i+=1		
	EndIf
	
	;Head
	If DropHeadT
		DropSlots[i] = 2
		DroppedClothesAliases[i] = DroppedClothesHair
		i+=1
	EndIf
	
	;Hands
	If DropHandsT
		DropSlots[i] = 8
		DroppedClothesAliases[i] = DroppedClothesHands
		i+=1
	EndIf
	
	;Feet
	If DropFeetT
		DropSlots[i] = 128
		DroppedClothesAliases[i] = DroppedClothesFeet
		i+=1
	EndIf
	
	TotalSlots = i
EndFunction

Function ClearSluttiness()
	SetTextOptionValue(ClearSluttinessOID_T, "Clearing " , false)
	JsonUtil.FormListClear("Milk Addict/SlutClothes.json", "ClothesList")
	JsonUtil.IntListClear("Milk Addict/SlutClothes.json", "Sluttiness")
	SetTextOptionValue(ClearSluttinessOID_T, "Done! " , false)
EndFunction

Function SetupInvoluntaryActions()
	If InvoluntaryActions
		_MA_AddictItemAddedQuest.Start()
		_MA_AddictShopMenuQuest.Start()
		PlayerRef.AddPerk(_MA_ContainerPerk)
		PlayerRef.AddPerk(_MA_DeadActorPerk)
	Else
		_MA_AddictItemAddedQuest.Stop()
		_MA_AddictShopMenuQuest.Stop()
		PlayerRef.RemovePerk(_MA_ContainerPerk)
		PlayerRef.RemovePerk(_MA_DeadActorPerk)
	EndIf
	Debug.Messagebox("Done. Exit menu to apply setting")
EndFunction

Function SetupNpcInvMilkPerk()
	If NpcInvMilkQuantity > 0 && NpcInvMilkChance > 0.0
		PlayerRef.AddPerk(_MA_NpcMilkAddPerk)
	Else
		PlayerRef.RemovePerk(_MA_NpcMilkAddPerk)
	EndIf
EndFunction

Function SaveSettings()

	; Ints
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "AddictionDecay", AddictionDecay)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "CraftingDifficulty", CraftingDifficulty)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "DropType", DropType)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "TimeToFindClothes", TimeToFindClothes)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "MountCooldownTime", MountCooldownTime)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "AproposHealBase", AproposHealBase)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "AproposHealDelta", AproposHealDelta)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "AddictivenessDilute", AddictivenessDilute)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "AddictivenessWeak", AddictivenessWeak)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "AddictivenessRegular", AddictivenessRegular)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "AddictivenessStrong", AddictivenessStrong)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "AddictivenessTasty", AddictivenessTasty)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "AddictivenessCreamy", AddictivenessCreamy)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "AddictivenessEnriched", AddictivenessEnriched)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "AddictivenessSublime", AddictivenessSublime)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "AddictivenessLactacid", AddictivenessLactacid)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "DurationDilute", DurationDilute)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "DurationWeak", DurationWeak)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "DurationRegular", DurationRegular)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "DurationStrong", DurationStrong)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "DurationTasty", DurationTasty)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "DurationCreamy", DurationCreamy)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "DurationEnriched", DurationEnriched)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "DurationSublime", DurationSublime)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "NpcInvMilkQuantity", NpcInvMilkQuantity)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "SetupFoodAddictiveness", SetupFoodAddictiveness)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "ClothesDurability", ClothesDurability)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "DurabilityTolerance", DurabilityTolerance)

	; Floats
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "AfterEffectMagMult", AfterEffectMagMult)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "AfterEffectDurMult", AfterEffectDurMult)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "CleavageMaxUnits", CleavageMaxUnits)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "LeakyBoobsVolume", LeakyBoobsVolume)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "LactacidCeiling", LactacidCeiling)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "BreastRopeFreqOffset", BreastRopeFreqOffset)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "RequiredLactMild", RequiredLactMild)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "RequiredLactModerate", RequiredLactModerate)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "RequiredLactAddict", RequiredLactAddict)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "RequiredLactJunkie", RequiredLactJunkie)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "AssMaxScale", AssMaxScale)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "AssLactMult", AssLactMult)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "LactacidDilute", LactacidDilute)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "LactacidWeak", LactacidWeak)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "LactacidRegular", LactacidRegular)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "LactacidStrong", LactacidStrong)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "LactacidTasty", LactacidTasty)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "LactacidCreamy", LactacidCreamy)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "LactacidEnriched", LactacidEnriched)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "LactacidSublime", LactacidSublime)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "LactacidLactacid", LactacidLactacid)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "SpeedDilute", SpeedDilute)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "SpeedWeak", SpeedWeak)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "SpeedRegular", SpeedRegular)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "SpeedStrong", SpeedStrong)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "SpeedTasty", SpeedTasty)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "SpeedCreamy", SpeedCreamy)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "SpeedEnriched", SpeedEnriched)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "SpeedSublime", SpeedSublime)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "StaminaRateDilute", StaminaRateDilute)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "StaminaRateWeak", StaminaRateWeak)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "StaminaRateRegular", StaminaRateRegular)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "StaminaRateStrong", StaminaRateStrong)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "StaminaRateTasty", StaminaRateTasty)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "StaminaRateCreamy", StaminaRateCreamy)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "StaminaRateEnriched", StaminaRateEnriched)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "StaminaRateSublime", StaminaRateSublime)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "TripArousalReq", TripArousalReq)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "TripDistanceReq", TripDistanceReq)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "TripFreqModerate", TripFreqModerate)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "TripFreqAddict", TripFreqAddict)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "TripFreqJunkie", TripFreqJunkie)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "TripChanceModerate", TripChanceModerate)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "TripChanceAddict", TripChanceAddict)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "TripChanceJunkie", TripChanceJunkie)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "SlipFreqModerate", SlipFreqModerate)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "SlipFreqAddict", SlipFreqAddict)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "SlipFreqJunkie", SlipFreqJunkie)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "SlipChanceModerate", SlipChanceModerate)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "SlipChanceAddict", SlipChanceAddict)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "SlipChanceJunkie", SlipChanceJunkie)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "AdditionalTripDropChanceModerate", AdditionalTripDropChanceModerate)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "AdditionalTripDropChanceAddict", AdditionalTripDropChanceAddict)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "AdditionalTripDropChanceJunkie", AdditionalTripDropChanceJunkie)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "BoobgasmChance", BoobgasmChance)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "BoobgasmChancePerLevel", BoobgasmChancePerLevel)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "NpcMilkingCost", NpcMilkingCost)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "FreshAddictivenessMult", FreshAddictivenessMult)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "FreshLactacidMult", FreshLactacidMult)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "SgoMilkProductionTime", SgoMilkProductionTime)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "MilkQ.MilkProdMod", MilkQ.MilkProdMod)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "NpcInvMilkChance", NpcInvMilkChance)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "SetupFoodLactacid", SetupFoodLactacid)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "ArmorCapacityUnits", ArmorCapacityUnits)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "ArmorCapacity", ArmorCapacity)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "ClothesLimitUnits", ClothesLimitUnits)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "ClothesLimit", ClothesLimit)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "ClothesTearChanceBase", ClothesTearChanceBase)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "ClothesTearChance", ClothesTearChance)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "RepairCostMult", RepairCostMult)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "TearVolume", TearVolume)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "HitRipChance", HitRipChance)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "MagicArmorMult", MagicArmorMult)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "TearMultAttack", TearMultAttack)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "TearMultPowerAttack", TearMultPowerAttack)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "TearMultJump", TearMultJump)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "TearMultSprint", TearMultSprint)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "TearMultBow", TearMultBow)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "TearMultMagic", TearMultMagic)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "TearMultShout", TearMultShout)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "RapeLactacidChance", RapeLactacidChance)
	JsonUtil.SetFloatValue("Milk Addict/Settings.json", "TripStripChanceLocationMod", TripStripChanceLocationMod)

	; Bools
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "SlifScaling", SlifScaling as Int)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "LactacidCeilingT", LactacidCeilingT as Int)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "InvoluntaryActions", InvoluntaryActions as Int)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "BaseAssScale", BaseAssScale as Int)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "CreatureEventsT", CreatureEventsT as Int)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "CleavageSpellT", CleavageSpellT as Int)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "LeakyBoobsSoundT", LeakyBoobsSoundT as Int)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "DropBodyT", DropBodyT as Int)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "DropHeadT", DropHeadT as Int)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "DropHandsT", DropHandsT as Int)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "DropFeetT", DropFeetT as Int)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "SlutFactor", SlutFactor as Int)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "UseAltTripMethod", UseAltTripMethod as Int)
	JsonUtil.SetIntValue("Milk Addict/Settings.json", "MountTeleport", MountTeleport as Int)
	JsonUtil.Save("Milk Addict/Settings.json")
	Debug.Messagebox("Settings Exported")
EndFunction

Function LoadSettings()

	; Ints
	AddictionDecay = JsonUtil.GetIntValue("Milk Addict/Settings.json", "AddictionDecay")
	CraftingDifficulty = JsonUtil.GetIntValue("Milk Addict/Settings.json", "CraftingDifficulty")
	DropType = JsonUtil.GetIntValue("Milk Addict/Settings.json", "DropType")
	TimeToFindClothes = JsonUtil.GetIntValue("Milk Addict/Settings.json", "TimeToFindClothes")
	MountCooldownTime = JsonUtil.GetIntValue("Milk Addict/Settings.json", "MountCooldownTime")
	AproposHealBase = JsonUtil.GetIntValue("Milk Addict/Settings.json", "AproposHealBase")
	AproposHealDelta = JsonUtil.GetIntValue("Milk Addict/Settings.json", "AproposHealDelta")
	AddictivenessDilute = JsonUtil.GetIntValue("Milk Addict/Settings.json", "AddictivenessDilute")
	AddictivenessWeak = JsonUtil.GetIntValue("Milk Addict/Settings.json", "AddictivenessWeak")
	AddictivenessRegular = JsonUtil.GetIntValue("Milk Addict/Settings.json", "AddictivenessRegular")
	AddictivenessStrong = JsonUtil.GetIntValue("Milk Addict/Settings.json", "AddictivenessStrong")
	AddictivenessTasty = JsonUtil.GetIntValue("Milk Addict/Settings.json", "AddictivenessTasty")
	AddictivenessCreamy = JsonUtil.GetIntValue("Milk Addict/Settings.json", "AddictivenessCreamy")
	AddictivenessEnriched = JsonUtil.GetIntValue("Milk Addict/Settings.json", "AddictivenessEnriched")
	AddictivenessSublime = JsonUtil.GetIntValue("Milk Addict/Settings.json", "AddictivenessSublime")
	AddictivenessLactacid = JsonUtil.GetIntValue("Milk Addict/Settings.json", "AddictivenessLactacid")
	DurationDilute = JsonUtil.GetIntValue("Milk Addict/Settings.json", "DurationDilute")
	DurationWeak = JsonUtil.GetIntValue("Milk Addict/Settings.json", "DurationWeak")
	DurationRegular = JsonUtil.GetIntValue("Milk Addict/Settings.json", "DurationRegular")
	DurationStrong = JsonUtil.GetIntValue("Milk Addict/Settings.json", "DurationStrong")
	DurationTasty = JsonUtil.GetIntValue("Milk Addict/Settings.json", "DurationTasty")
	DurationCreamy = JsonUtil.GetIntValue("Milk Addict/Settings.json", "DurationCreamy")
	DurationEnriched = JsonUtil.GetIntValue("Milk Addict/Settings.json", "DurationEnriched")
	DurationSublime = JsonUtil.GetIntValue("Milk Addict/Settings.json", "DurationSublime")
	SetupFoodAddictiveness = JsonUtil.GetIntValue("Milk Addict/Settings.json", "SetupFoodAddictiveness")
	ClothesDurability = JsonUtil.GetIntValue("Milk Addict/Settings.json", "ClothesDurability")
	DurabilityTolerance = JsonUtil.GetIntValue("Milk Addict/Settings.json", "DurabilityTolerance")
	NpcInvMilkQuantity = JsonUtil.GetIntValue("Milk Addict/Settings.json", "NpcInvMilkQuantity")
	
	; Floats
	AfterEffectMagMult = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "AfterEffectMagMult")
	AfterEffectDurMult = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "AfterEffectDurMult")
	CleavageMaxUnits = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "CleavageMaxUnits")
	LeakyBoobsVolume = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "LeakyBoobsVolume")
	LactacidCeiling = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "LactacidCeiling")
	BreastRopeFreqOffset = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "BreastRopeFreqOffset")
	RequiredLactMild = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "RequiredLactMild")
	RequiredLactModerate = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "RequiredLactModerate")
	RequiredLactAddict = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "RequiredLactAddict")
	RequiredLactJunkie = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "RequiredLactJunkie")
	AssMaxScale = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "AssMaxScale")
	AssLactMult = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "AssLactMult")
	LactacidDilute = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "LactacidDilute")
	LactacidWeak = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "LactacidWeak")
	LactacidRegular = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "LactacidRegular")
	LactacidStrong = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "LactacidStrong")
	LactacidTasty = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "LactacidTasty")
	LactacidCreamy = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "LactacidCreamy")
	LactacidEnriched = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "LactacidEnriched")
	LactacidSublime = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "LactacidSublime")
	LactacidLactacid = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "LactacidLactacid")
	SpeedDilute = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "SpeedDilute")
	SpeedWeak = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "SpeedWeak")
	SpeedRegular = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "SpeedRegular")
	SpeedStrong = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "SpeedStrong")
	SpeedTasty = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "SpeedTasty")
	SpeedCreamy = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "SpeedCreamy")
	SpeedEnriched = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "SpeedEnriched")
	SpeedSublime = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "SpeedSublime")
	StaminaRateDilute = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "StaminaRateDilute")
	StaminaRateWeak = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "StaminaRateWeak")
	StaminaRateRegular = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "StaminaRateRegular")
	StaminaRateStrong = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "StaminaRateStrong")
	StaminaRateTasty = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "StaminaRateTasty")
	StaminaRateCreamy = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "StaminaRateCreamy")
	StaminaRateEnriched = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "StaminaRateEnriched")
	StaminaRateSublime = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "StaminaRateSublime")
	TripArousalReq = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "TripArousalReq")
	TripDistanceReq = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "TripDistanceReq")
	TripFreqModerate = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "TripFreqModerate")
	TripFreqAddict = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "TripFreqAddict")
	TripFreqJunkie = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "TripFreqJunkie")
	TripChanceModerate = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "TripChanceModerate")
	TripChanceAddict = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "TripChanceAddict")
	TripChanceJunkie = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "TripChanceJunkie")
	SlipFreqModerate = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "SlipFreqModerate")
	SlipFreqAddict = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "SlipFreqAddict")
	SlipFreqJunkie = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "SlipFreqJunkie")
	SlipChanceModerate = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "SlipChanceModerate")
	SlipChanceAddict = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "SlipChanceAddict")
	SlipChanceJunkie = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "SlipChanceJunkie")
	AdditionalTripDropChanceModerate = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "AdditionalTripDropChanceModerate")
	AdditionalTripDropChanceAddict = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "AdditionalTripDropChanceAddict")
	AdditionalTripDropChanceJunkie = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "AdditionalTripDropChanceJunkie")
	BoobgasmChance = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "BoobgasmChance")
	BoobgasmChancePerLevel = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "BoobgasmChancePerLevel")
	NpcMilkingCost = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "NpcMilkingCost")
	FreshAddictivenessMult = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "FreshAddictivenessMult")
	FreshLactacidMult = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "FreshLactacidMult")
	SgoMilkProductionTime = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "SgoMilkProductionTime")
		Init.SetSgoMilkTime()
	MilkQ.MilkProdMod = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "MilkQ.MilkProdMod")
	NpcInvMilkChance = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "NpcInvMilkChance")
	SetupFoodLactacid = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "SetupFoodLactacid")
	ArmorCapacityUnits = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "ArmorCapacityUnits")
	ArmorCapacity = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "ArmorCapacity")
	ClothesLimitUnits = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "ClothesLimitUnits")
	ClothesLimit = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "ClothesLimit")
	ClothesTearChanceBase = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "ClothesTearChanceBase")
	ClothesTearChance = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "ClothesTearChance")
	RepairCostMult = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "RepairCostMult")
	TearVolume = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "TearVolume")
	HitRipChance = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "HitRipChance")
	MagicArmorMult = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "MagicArmorMult")
	TearMultAttack = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "TearMultAttack")
	TearMultPowerAttack = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "TearMultPowerAttack")
	TearMultJump = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "TearMultJump")
	TearMultSprint = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "TearMultSprint")
	TearMultBow = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "TearMultBow")
	TearMultMagic = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "TearMultMagic")
	TearMultShout = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "TearMultShout")
		Main.UpdateRipChance()
	RapeLactacidChance = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "RapeLactacidChance")
	TripStripChanceLocationMod = JsonUtil.GetFloatValue("Milk Addict/Settings.json", "TripStripChanceLocationMod")
	
	; Bools
	SlifScaling = JsonUtil.GetIntValue("Milk Addict/Settings.json", "SlifScaling")
	If Init.SlifInstalled
		If SlifScaling
			MaScaling.StartSlifScaling()
		Else
			MaScaling.StopSlifScaling()
		EndIf
	EndIf
	LactacidCeilingT = JsonUtil.GetIntValue("Milk Addict/Settings.json", "LactacidCeilingT")
	InvoluntaryActions = JsonUtil.GetIntValue("Milk Addict/Settings.json", "InvoluntaryActions")
	SetupInvoluntaryActions()
	BaseAssScale = JsonUtil.GetIntValue("Milk Addict/Settings.json", "BaseAssScale")
	CreatureEventsT = JsonUtil.GetIntValue("Milk Addict/Settings.json", "CreatureEventsT")
	CleavageSpellT = JsonUtil.GetIntValue("Milk Addict/Settings.json", "CleavageSpellT")
	If CleavageSpellT
		Main.RefreshCleavageEffect()
	Else
		PlayerRef.RemoveSpell(Main._MA_Cleavage)
	EndIf
	LeakyBoobsSoundT = JsonUtil.GetIntValue("Milk Addict/Settings.json", "LeakyBoobsSoundT")
	DropBodyT = JsonUtil.GetIntValue("Milk Addict/Settings.json", "DropBodyT")
	DropHeadT = JsonUtil.GetIntValue("Milk Addict/Settings.json", "DropHeadT")
	DropHandsT = JsonUtil.GetIntValue("Milk Addict/Settings.json", "DropHandsT")
	DropFeetT = JsonUtil.GetIntValue("Milk Addict/Settings.json", "DropFeetT")
	SlutFactor = JsonUtil.GetIntValue("Milk Addict/Settings.json", "SlutFactor")
	UseAltTripMethod = JsonUtil.GetIntValue("Milk Addict/Settings.json", "UseAltTripMethod")
	MountTeleport = JsonUtil.GetIntValue("Milk Addict/Settings.json", "MountTeleport")
	
	SetupNpcInvMilkPerk()
	
	ConfigureDropSlots()
	Debug.Messagebox("Settings Imported")
EndFunction

; MCM Begin ===================================================
; Text
int CurrentAddictionOID_T
int ClothesDurabilityOID_T
int ClothesSluttinessOID_T
int BonusCapacityOID_T
int ExportSettingsOID_T
int ImportSettingsOID_T
int ResetSlifOID_T
int CurrentTearChanceOID_T
int CurrentMilkOID_T
int MilkCapMaxOID_T
int ClearSluttinessOID_T
int AttackTearChanceOID_T
int PowerAttackTearChanceOID_T
int JumpTearChanceOID_T
int SprintTearChanceOID_T
int BowTearChanceOID_T
int MagicTearChanceOID_T
int ShoutTearChanceOID_T
int TripMeOID_T
int CurrentAssScaleOID_T
int AssScaleTearChanceOID_T
int CurrentBellyScaleOID_T
int BellyScaleTearChanceOIS_T

; Toggles
int SlifScalingOID
int BaseAssScaleOID
int CreaturesEventsOID
int CleavageSpellOID
int LeakyBoobsSoundTOID
int LactacidCeilingTOID
int InvoluntaryActionsOID
int DropBodyOID
int DropHeadOID
int DropHandsOID
int DropFeetOID
int TripDebugOID
int MountTeleportOID
int UseAltTripMethodOID
int SetupFoodOID
int RemoveFoodOID
int SlutFactorOID
int SetupSlutClothesOID

; Sliders
int AddictionDecayOID_S
int TimeToFindClothesOID_S
int CleavageMaxUnitsOID_S
int LeakyBoobsVolumeOID_S
int LactacidCeilingOID_S
int BreastRopeFreqOffsetOID_S
int RequiredLactMildOID_S
int RequiredLactModerateOID_S
int RequiredLactAddictOID_S
int RequiredLactJunkieOID_S
int AssMaxScaleOID_S
int AssLactMultOID_S
Int RapeLactacidChanceOID_S

int AffterEffectDebuffMagMultOID_S
int AffterEffectDebuffDurMultOID_S
int AproposHealBaseOID_S
int AproposHealDeltaOID_S
int AddictivenessDiluteOID_S
int AddictivenessWeakOID_S
int AddictivenessRegularOID_S
int AddictivenessStrongOID_S
int AddictivenessTastyOID_S
int AddictivenessCreamyOID_S
int AddictivenessEnrichedOID_S
int AddictivenessSublimeOID_S
int AddictivenessLactacidOID_S

int LactacidDiluteOID_S
int LactacidWeakOID_S
int LactacidRegularOID_S
int LactacidStrongOID_S
int LactacidTastyOID_S
int LactacidCreamyOID_S
int LactacidEnrichedOID_S
int LactacidSublimeOID_S
int LactacidLactacidOID_S

int SpeedDiluteOID_S
int SpeedWeakOID_S
int SpeedRegularOID_S
int SpeedStrongOID_S
int SpeedTastyOID_S
int SpeedCreamyOID_S
int SpeedEnrichedOID_S
int SpeedSublimeOID_S

int StaminaRateDiluteOID_S
int StaminaRateWeakOID_S
int StaminaRateRegularOID_S
int StaminaRateStrongOID_S
int StaminaRateTastyOID_S
int StaminaRateCreamyOID_S
int StaminaRateEnrichedOID_S
int StaminaRateSublimeOID_S

int DurationDiluteOID_S
int DurationWeakOID_S
int DurationRegularOID_S
int DurationStrongOID_S
int DurationTastyOID_S
int DurationCreamyOID_S
int DurationEnrichedOID_S
int DurationSublimeOID_S

int TripStripChanceLocationModOID_S
int TripArousalReqOID_S
int TripDistanceReqOID_S
int MountCooldownTimeOID_S

int TripFreqModerateOID_S
int TripFreqAddictOID_S
int TripFreqJunkieOID_S
int TripChanceModerateOID_S
int TripChanceAddictOID_S
int TripChanceJunkieOID_S

int SlipFreqModerateOID_S
int SlipFreqAddictOID_S
int SlipFreqJunkieOID_S
int SlipChanceModerateOID_S
int SlipChanceAddictOID_S
int SlipChanceJunkieOID_S

int AdditionalTripDropChanceModerateOID_S
int AdditionalTripDropChanceAddictOID_S
int AdditionalTripDropChanceJunkieOID_S

int BoobgasmChanceOID_S
int BoobgasmChancePerLevelOID_S
int NpcMilkingCostOID_S
int FreshAddictivenessMultOID_S
int FreshLactacidMultOID_S
int SgoMilkProductionTimeOID_S
int MmeMilkProductionRateOID_S
int NpcInvMilkQuantityOID_S
int NpcInvMilkChanceOID_S

int SetupFoodLactacidOID_S
int SetupFoodAddictivenessOID_S

int ArmorCapacityUnitsOID_S
int ArmorCapacityOID_S
int ClothesLimitUnitsOID_S
int ClothesLimitOID_S
int ClothesTearChanceBaseOID_S
int ClothesTearChanceOID_S
int ClothesTearChanceBellyOID_S
int ClothesTearChanceAssOID_S
int RepairCostMultOID_S
int TearVolumeOID_S
int ClothesDurabilityOID_S
int DurabilityToleranceOID_S
int HitRipChanceOID_S
int MagicArmorMultOID_S
int TearMultAttackOID_S
int TearMultPowerAttackOID_S
int TearMultJumpOID_S
int TearMultSprintOID_S
int TearMultBowOID_S
int TearMultMagicOID_S
int TearMultShoutOID_S

; DialogBox
int CraftingDifficultyDB
int DropTypeDB

; Menu Variables Begin =======================================================
Int[] Property DropSlots Auto Hidden
ReferenceAlias[] Property DroppedClothesAliases Auto Hidden
ReferenceAlias Property DroppedClothesBody Auto Hidden
ReferenceAlias Property DroppedClothesHands Auto Hidden
ReferenceAlias Property DroppedClothesFeet Auto Hidden
ReferenceAlias Property DroppedClothesHair Auto Hidden
Int Property TotalSlots Auto Hidden

	;Settings
Int Property AddictionDecay = 1 Auto Hidden
Int Property CraftingDifficulty = 1 Auto Hidden
Int Property DropType = 1 Auto Hidden
Int Property TimeToFindClothes = 20 Auto Hidden
Float Property CleavageMaxUnits = 24.0 Auto Hidden
Bool Property CleavageSpellT = true Auto Hidden
Bool Property LeakyBoobsSoundT = true Auto Hidden
Float Property LeakyBoobsVolume = 60.0 Auto Hidden
Bool Property LactacidCeilingT = true Auto Hidden
Float Property LactacidCeiling = 12.0 Auto Hidden
Float Property BreastRopeFreqOffset = 0.0 Auto Hidden
Float Property RequiredLactMild = 1.0 Auto  Hidden
Float Property RequiredLactModerate = 2.0 Auto Hidden
Float Property RequiredLactAddict = 4.0 Auto Hidden
Float Property RequiredLactJunkie = 8.0 Auto Hidden
Bool Property SlifScaling = true Auto Hidden
Float Property AssMaxScale = 2.5 Auto Hidden
Float Property AssLactMult = 0.0125 Auto Hidden
Bool Property BaseAssScale = true Auto Hidden
Bool Property CreatureEventsT = True Auto Hidden
Bool Property InvoluntaryActions = True Auto Hidden
Float Property RapeLactacidChance = 35.0 Auto Hidden

	; Milk
Float Property AfterEffectMagMult = 0.5 Auto Hidden
Float Property AfterEffectDurMult = 1.5 Auto Hidden

Int Property AproposHealBase = 5 Auto Hidden
Int Property AproposHealDelta = 5 Auto Hidden

Int Property AddictivenessDilute = 2 Auto Hidden
Int Property AddictivenessWeak = 3 Auto Hidden
Int Property AddictivenessRegular = 4 Auto Hidden
Int Property AddictivenessStrong = 6 Auto Hidden
Int Property AddictivenessTasty = 8 Auto Hidden
Int Property AddictivenessCreamy = 12 Auto Hidden
Int Property AddictivenessEnriched = 20 Auto Hidden
Int Property AddictivenessSublime = 25 Auto Hidden
Int Property AddictivenessLactacid = 40 Auto Hidden

Float Property LactacidDilute = 0.05 Auto Hidden
Float Property LactacidWeak = 0.1 Auto Hidden
Float Property LactacidRegular = 0.15 Auto Hidden
Float Property LactacidStrong = 0.20 Auto Hidden
Float Property LactacidTasty = 0.30 Auto Hidden
Float Property LactacidCreamy = 0.40 Auto Hidden
Float Property LactacidEnriched = 0.50 Auto Hidden
Float Property LactacidSublime = 0.6 Auto Hidden
Float Property LactacidLactacid = 2.0 Auto Hidden

Float Property SpeedDilute = 5.0 Auto Hidden
Float Property SpeedWeak = 10.0 Auto Hidden
Float Property SpeedRegular = 15.0 Auto Hidden
Float Property SpeedStrong = 20.0 Auto Hidden
Float Property SpeedTasty = 25.0 Auto Hidden
Float Property SpeedCreamy = 30.0 Auto Hidden
Float Property SpeedEnriched = 35.0 Auto Hidden
Float Property SpeedSublime = 40.0 Auto Hidden

Float Property StaminaRateDilute = 35.0 Auto Hidden
Float Property StaminaRateWeak = 40.0 Auto Hidden
Float Property StaminaRateRegular = 45.0 Auto Hidden
Float Property StaminaRateStrong = 50.0 Auto Hidden
Float Property StaminaRateTasty = 55.0 Auto Hidden
Float Property StaminaRateCreamy = 60.0 Auto Hidden
Float Property StaminaRateEnriched = 65.0 Auto Hidden
Float Property StaminaRateSublime = 70.0 Auto Hidden

int Property DurationDilute = 170 Auto Hidden
int Property DurationWeak = 210 Auto Hidden
int Property DurationRegular = 240 Auto Hidden
int Property DurationStrong = 270 Auto Hidden
int Property DurationTasty = 300 Auto Hidden
int Property DurationCreamy = 330 Auto Hidden
int Property DurationEnriched = 260 Auto Hidden
int Property DurationSublime = 420 Auto Hidden

	; Trip / Slip
Float Property TripStripChanceLocationMod = 0.25 Auto Hidden
Bool Property DebugTripT = False Auto Hidden
Bool Property UseAltTripMethod = false Auto Hidden

Float Property TripArousalReq = 30.0 Auto Hidden
Float Property TripDistanceReq = 500.0 Auto Hidden
Int Property MountCooldownTime = 30 Auto Hidden
Bool Property MountTeleport = True Auto Hidden

Float Property TripFreqModerate = 30.0 Auto Hidden
Float Property TripFreqAddict = 20.0 Auto Hidden
Float Property TripFreqJunkie = 10.0 Auto Hidden
Float Property TripChanceModerate = 10.0 Auto Hidden
Float Property TripChanceAddict = 15.0 Auto Hidden
Float Property TripChanceJunkie = 25.0 Auto Hidden

Float Property SlipFreqModerate = 30.0 Auto Hidden
Float Property SlipFreqAddict = 20.0 Auto Hidden
Float Property SlipFreqJunkie = 10.0 Auto Hidden
Float Property SlipChanceModerate = 10.0 Auto Hidden
Float Property SlipChanceAddict = 15.0 Auto Hidden
Float Property SlipChanceJunkie = 25.0 Auto Hidden

Float Property AdditionalTripDropChanceModerate = 25.0 Auto  Hidden
Float Property AdditionalTripDropChanceAddict = 35.0 Auto Hidden
Float Property AdditionalTripDropChanceJunkie = 50.0 Auto Hidden

Bool Property DropBodyT = True Auto Hidden
Bool Property DropHeadT = True Auto Hidden
Bool Property DropHandsT = True Auto Hidden
Bool Property DropFeetT = True Auto Hidden

	; NPC Milking
Float Property BoobgasmChance = 5.0 Auto Hidden
Float Property BoobgasmChancePerLevel = 3.0 Auto Hidden
Float Property NpcMilkingCost = 50.0 Auto Hidden
Float Property FreshAddictivenessMult = 1.5 Auto Hidden
Float Property FreshLactacidMult = 1.5 Auto Hidden
Float Property SgoMilkProductionTime = 8.0 Auto Hidden
Int Property NpcInvMilkQuantity = 5 Auto Hidden
Float Property NpcInvMilkChance = 3.0 Auto Hidden

	; Food
Float Property SetupFoodLactacid = 1.0 Auto Hidden
int Property SetupFoodAddictiveness = 10 Auto Hidden

	; Armor
Float Property ArmorCapacityUnits = 4.0 Auto Hidden
Float Property ArmorCapacity = 40.0 Auto Hidden
Float Property ClothesLimitUnits = 6.0 Auto Hidden
Float Property ClothesLimit = 50.0 Auto Hidden
Float Property ClothesTearChanceBase = 1.0 Auto Hidden
Float Property ClothesTearChance = 0.5 Auto Hidden
Float Property ClothesTearChanceBelly = 2.0 Auto Hidden
Float Property ClothesTearChanceAss = 3.0 Auto Hidden
Float Property RepairCostMult = 0.5 Auto Hidden
Float Property TearVolume = 1.0 Auto Hidden
Int Property ClothesDurability = 10 Auto Hidden
Int Property DurabilityTolerance = 3 Auto Hidden
Float Property HitRipChance = 35.0 Auto Hidden
Float Property MagicArmorMult = 50.0 Auto Hidden
Float Property TearMultAttack = 0.5 Auto Hidden
Float Property TearMultPowerAttack = 1.5 Auto Hidden
Float Property TearMultJump = 1.0 Auto Hidden
Float Property TearMultSprint = 1.0 Auto Hidden
Float Property TearMultBow = 0.8 Auto Hidden
Float Property TearMultMagic = 0.5 Auto Hidden
Float Property TearMultShout = 1.3 Auto Hidden
Bool Property SlutFactor = true Auto Hidden
Bool Property SetupSlutClothes = false Auto Hidden

; Properties ============================================================

Quest Property MQ101 Auto
Quest Property _MA_AddictItemAddedQuest Auto
Quest Property _MA_AddictShopMenuQuest Auto

Perk Property _MA_ContainerPerk Auto
Perk Property _MA_DeadActorPerk Auto
Perk Property _MA_NpcMilkAddPerk Auto

GlobalVariable Property _MA_LactacidAddictionPool Auto

Actor Property PlayerRef Auto

Spell Property _MA_TripSpell Auto

_MA_Main Property Main auto 
_MA_Init Property Init Auto
_MA_SlifScalingScript Property MaScaling Auto
MilkQUEST Property MilkQ Auto
