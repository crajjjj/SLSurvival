Scriptname aaaKNNMCM extends SKI_ConfigBase 

;int IsLastKNNEnable
;int updateFlag = 0
string modVersion
bool IsUpdate = false

Int function GetVersion()
	return 400104
endFunction

Event OnVersionUpdate(Int NewVersion)
	;Debug.Notification("NewVersion : " + NewVersion + ", CurrentVersion : " + CurrentVersion)
	if NewVersion != CurrentVersion
		modVersion = "4.1.4"
		Debug.Notification("Installed EatingSleepingDrinking version " + modVersion)
		OnConfigInit()

		if 0 != aaaKNNIsHT.GetValueInt() && 2 != aaaKNNHTPriority.GetValueInt()
			KNNPlugin_Utility.SetNoLookObject()
		endIf
	endIf
EndEvent

Event OnGameReload()
	parent.OnGameReload()
	if 255 != Game.GetModByName("UltimateCombat.esp")
		_KNNHTDisabledWhileWeaponDrawn.SetValueInt(1)
 	endIf
 	if 0 > SKSE.GetPluginVersion("QuickLoot")
 		aaaKNNIsEnableQuickLootAnim.SetValueInt(0)
 	endIf
 	;AnimSpeedHelper.SetAnimationSpeed(Game.GetPlayer(), 2.0, 0.0, 0)
EndEvent

State READY
	Event OnConfigClose()
		GoToState("")
		if 0 < aaaKNNHotkeyJurnal.GetValueInt() && !JurnalQuest.IsRunning()
			JurnalQuest.Start()
		else
			JurnalQuest.Stop()
		endIf

		if 0 == aaaKNNIsBasicNeedsEnable.GetValueInt()
			aaaKNNVendorQuest.Stop()
			WaterBarrelQuest.Stop()
		else
			if 0 != aaaKNNIsEnableSellWaterBottle.GetValueInt() || 0 != aaaKNNIsEnabledSellTowel.GetValueInt()
				if !aaaKNNVendorQuest.IsRunning()
					aaaKNNVendorQuest.Start()
				endIf
			else
				aaaKNNVendorQuest.Stop()
			endIf

			if 0 != _KNNIsEnableWaterBarrelFeature.GetValueInt()
				if !WaterBarrelQuest.IsRunning()
					WaterBarrelQuest.Start()
				endIf
			else
				WaterBarrelQuest.Stop()
			endIf
		endIf

		CheckAnimationQuest()
	EndEvent
EndState

Function CheckAnimationQuest()
	if 0 != aaaAnimEatFoodStanding.GetValueInt() || 0 != aaaAnimEatFoodSitting.GetValueInt() || 0 != aaaAnimEatSoupStanding.GetValueInt() || 0 != aaaAnimEatSoupSitting.GetValueInt() \
			|| 0 != aaaAnimDrinkStanding.GetValueInt() || 0 != aaaAnimDrinkSitting.GetValueInt() || 0 != aaaAnimWashBody.GetValueInt() || 0 != aaaAnimFillWater.GetValueInt() \
			|| 0 != aaaAnimMakeTowel.GetValueInt() || 0 != aaaAnimReadBook.GetValueInt() || 0 != aaaAnimTakePotion.GetValueInt() || 0 != aaaAnimForetaste.GetValueInt() \
			|| 0 < aaaKNNHotkeyJurnal.GetValueInt() || 0 < aaaKNNHotkeyIdleAnim.GetValueInt()
		if PreAnimQuest.IsStopped()
			PreAnimQuest.Start()
		endIf
	else
		PreAnimQuest.Stop()
	endIf
EndFunction

Event OnConfigInit()
	;Debug.Notification("MCM OnConfigInit")
	IsUpdate = true
	Pages = new string[21]
	Pages[0] = "$KNNBasic_Needs_Basic"
	Pages[1] = "$KNNBasic_Needs_Extend"
	Pages[2] = "$KNNBasicNeeds_Manage"
	Pages[3] = "$KNN_Anim_Config"
	Pages[4] = "$KNN_General_Anim"
	Pages[5] = "$KNN_Activate_Anim"
	Pages[6] = "$KNN_QuickLoot_Anim"
	Pages[7] = "$KNN_Bathing_config"
	Pages[8] = "$KNN_EquipArmorStatus"
	Pages[9] = "$KNN_misc_config_Basic"
	Pages[10] = "$KNN_misc_config_Extend"
	Pages[11] = "$KNN_misc_config_Management"
	Pages[12] = "$KNN_Potion_Hotkey"
	Pages[13] = "$KNN_Misc_Hotkey"
	Pages[14] = "$KNN_Follower_config"
	Pages[15] = "$KNN_Player_Jurnal"
	Pages[16] = "$KNN_Widget"
	Pages[17] = "$KNNHT_General"
	Pages[18] = "$KNNHT_Eye"
	Pages[19] = "$KNNHT_Basic"
	Pages[20] = "$KNNHT_Detail"

	CheckAnimationQuest()
	xmlList = new string[10]
	xmlList[0] = "$DoNothingNoHappen"
	xmlList[1] = "$EatFoodStand"
	xmlList[2] = "$EatFoodSit"
	xmlList[3] = "$DrinkStand"
	xmlList[4] = "$DrinkSit"
	xmlList[5] = "$DrinkingMoving_xml"
	xmlList[6] = "$TakePotion"
	xmlList[7] = "$Foretaste"
	xmlList[8] = "$RegisterCustomPotion"
	xmlList[9] = "$ReadBooks"
EndEvent

Event OnPageReset(string page)
	;updateFlag = 0
	if IsUpdate
		IsUpdate = false
		SetBasicNeedsGeneralPage()
		SetBasicNeedsExtendPage()
		SetBasicNeedsManagePage()
		SetGeneralAnimSettingPage()
		SetGeneralAnimPage()
		SetPerkAnimPage()
		SetQuicKLootAnimPage()
		SetBathingPage()
		SetEquippingArmorStatusPage()
		SetMiscConfigGeneralPage()
		SetMiscConfigExtendPage()
		SetPotionHotkeyPage()
		SetMiscHotkeyPage()	
		SetFollowerPage()
		SetJurnalPage()
		SetWidgetPage()
		SetHeadTrackingGeneralPage()
		SetHeadTrackingEyePage()
		SetHeadTrackingBasicPage()
		SetHeadTrackingDetailPage()
	endIf
	if page == ""
		; Image size 512x256
		float Xoffset = 376 - (512 / 2)
		float Yoffset = 223 - (256 / 2)
		LoadCustomContent("EatingSleepingDrinking/logo.dds", Xoffset, Yoffset)
	else
		UnloadCustomContent()
	endIf

	if page == "$KNNBasic_Needs_Basic"
		SetBasicNeedsGeneralPage()
	elseIf page == "$KNNBasic_Needs_Extend"
		SetBasicNeedsExtendPage()
	elseIf page == "$KNNBasicNeeds_Manage"
		SetBasicNeedsManagePage()
	elseIf page == "$KNN_Anim_Config"
		SetGeneralAnimSettingPage()
	elseIf page == "$KNN_General_Anim"
		SetGeneralAnimPage()
	elseIf page == "$KNN_Activate_Anim"
		SetPerkAnimPage()
	elseIf page == "$KNN_QuickLoot_Anim"
		SetQuicKLootAnimPage()
	elseIf page == "$KNN_Bathing_config"
		SetBathingPage()
	elseIf page == "$KNN_EquipArmorStatus"
		SetEquippingArmorStatusPage()
	elseIf page == "$KNN_misc_config_Basic"
		SetMiscConfigGeneralPage()
	elseIf page == "$KNN_misc_config_Extend"
		SetMiscConfigExtendPage()
	elseIf page == "$KNN_misc_config_Management"
		SetMiscConfigManagementPage()
	elseIf page == "$KNN_Potion_Hotkey"
		SetPotionHotkeyPage()
	elseIf page == "$KNN_Misc_Hotkey"
		SetMiscHotkeyPage()	
	elseIf page == "$KNN_Follower_config"
		SetFollowerPage()
	elseIf page == "$KNN_Player_Jurnal"
		SetJurnalPage()
	elseIf page == "$KNN_Widget"
		SetWidgetPage()
	elseIf page == "$KNNHT_General"
		SetHeadTrackingGeneralPage()
	elseIf page == "$KNNHT_Eye"
		SetHeadTrackingEyePage()	
	elseIf page == "$KNNHT_Basic"
		SetHeadTrackingBasicPage()
	elseIf page == "$KNNHT_Detail"
		SetHeadTrackingDetailPage()	
	endIf
EndEvent

Function SetBasicNeedsGeneralPage()
	SetTitleText("$KNN_General_Settings")
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)
	BNOID = AddTextOption("$Enable_BasicNeeds", GetFunctionState(aaaKNNIsBasicNeedsEnable.GetValueInt()))
	int FLAG = 0
	int FLAG_BODY = 0
	int FLAG_GROWL = 0
	int FLAG_EXPRESSION = 0
	int FLAG_DIE = 0
	if aaaKNNIsBasicNeedsEnable.GetValueInt() == 0
		FLAG = 1
		FLAG_BODY = 1
		FLAG_GROWL = 1
		;FLAG_EXPRESSION = 1
		FLAG_DIE = 1
	else
		if aaaKNNIsEnableHungry.GetValueInt() == 0 && aaaKNNIsEnableThirsty.GetValueInt() == 0 && aaaKNNIsEnableSleepiness.GetValueInt() == 0
			FLAG_DIE = 1
		endIf
		if aaaKNNIsEnableBodyHealth.GetValueInt() == 0
			FLAG_BODY = 1
		endIf
		if aaaKNNIsEnableHungry.GetValueInt() == 0 && aaaKNNIsEnableThirsty.GetValueInt() == 0 && aaaKNNIsEnableSleepiness.GetValueInt() == 0 && aaaKNNIsEnableBodyHealth.GetValueInt() == 0
			FLAG_GROWL = 1
		endIf
	endIf
	;if FLAG_EXPRESSION == 1
	;	if aaaKNNIsEnableExpression.GetValueInt() != 0
	;		aaaKNNIsEnableExpression.SetValueInt(0)
	;	endIf
	;endIf
	AddHeaderOption("$BasicNeeds_Status")
	HungryOID = AddTextOption("$Enable_Hungry", GetFunctionState(aaaKNNIsEnableHungry.GetValueInt()), FLAG)
	ThirstyOID = AddTextOption("$Enable_Thirsty", GetFunctionState(aaaKNNIsEnableThirsty.GetValueInt()), FLAG)
	SleepOID = AddTextOption("$Enable_Sleep", GetFunctionState(aaaKNNIsEnableSleepiness.GetValueInt()), FLAG)		
	DrunkOID = AddTextOption("$Enable_Drunk", GetFunctionState(aaaKNNIsEnableDrunkness.GetValueInt()), FLAG)
	BodyOID = AddTextOption("$Enable_Body", GetFunctionState(aaaKNNIsEnableBodyHealth.GetValueInt()), FLAG)
	intervalBodyOID = AddSliderOption("$Interval_Body", aaaKNNWashBodyInterval.GetValue(), "${0} Days", FLAG_BODY)
	SetCursorPosition(1)
	;AddEmptyOption()
	AddTextOption("MOD version", modVersion, 1)
	AddHeaderOption("$BasicNeeds_SubStatus")
	DirtyBodyOID = AddTextOption("$Enable_DirtyBody", GetFunctionState(aaaKNNIsEnableDirtyBodyEffect.GetValueInt()), FLAG_BODY)
	HungryGrowlOID = AddTextOption("$Enable_HungryGrowl", GetFunctionState(aaaKNNIsEnableHungryGrowl.GetValueInt()), FLAG_GROWL)
	ExpressionOID = AddTextOption("$Enable_Expression", GetExpressionState(aaaKNNIsEnableExpression.GetValueInt()), FLAG_EXPRESSION)
	
	AddHeaderOption("$BasicNeeds_HardStatus")
	HardOID = AddTextOption("$Enable_BasicNeedsHard", GetStaminaPenaltyState(aaaKNNIsEnableBasicNeedsHard.GetValueInt()))
	DieOID = AddSliderOption("$Enable_Die", aaaKNNIsEnableDie.GetValue(), "${0} Days", FLAG_DIE)
EndFunction
Function SetBasicNeedsExtendPage()
	SetTitleText("$KNN_Extend_Settings")
	SetCursorFillMode(TOP_TO_BOTTOM)
	int FLAG_HUNGRY = 0
	int FLAG_THIRSTY = 0
	int FLAG_SLEEP = 0
	int FLAG_BODY = 0
	int FLAG_DRUNK = 0
	if aaaKNNIsBasicNeedsEnable.GetValueInt() == 0
		FLAG_HUNGRY = 1
		FLAG_THIRSTY = 1
		FLAG_SLEEP = 1
		FLAG_BODY = 1
		FLAG_DRUNK = 1
	else
		if aaaKNNIsEnableHungry.GetValueInt() == 0
			FLAG_HUNGRY = 1
		endIf
		if aaaKNNIsEnableThirsty.GetValueInt() == 0
			FLAG_THIRSTY = 1
		endIf
		if aaaKNNIsEnableSleepiness.GetValueInt() == 0
			FLAG_SLEEP = 1
		endIf
		if aaaKNNIsEnableBodyHealth.GetValueInt() == 0
			FLAG_BODY = 1
		endIf
		if aaaKNNIsEnableDrunkness.GetValueInt() == 0
			FLAG_DRUNK = 1
		endIf
	endIf
	SetCursorPosition(0)
	AddHeaderOption("$BasicNeeds_Magnitude")
	FoodsTimeOID = AddSliderOption("$FoodsTime_PerDay", _KNNFoodsTimePerDay.GetValue(), "${0} timesPerDays", FLAG_HUNGRY)
	DrinksTimeOID = AddSliderOption("$DrinksTime_PerDay", _KNNDrinksTimePerDay.GetValue(), "${0} timesPerDays", FLAG_THIRSTY)
	intHungryOID = AddSliderOption("$Intensity_Hungry", aaaKNNIntensityHungry.GetValue(), "{2}", FLAG_HUNGRY)
	magHungryOID = AddSliderOption("$Magnitude_Hungry", aaaKNNDamageMagnitudeHungry.GetValue(), "{2}", FLAG_HUNGRY)
	intThirstyOID = AddSliderOption("$Intensity_Thirsty", aaaKNNIntensityThirsty.GetValue(), "{2}", FLAG_THIRSTY)
	magThirstyOID = AddSliderOption("$Magnitude_Thirsty", aaaKNNDamageMagnitudeThirsty.GetValue(), "{2}", FLAG_THIRSTY)
	shortSleeperOID = AddSliderOption("$Short_Sleeper", aaaKNNShortSleeper.GetValue(), "{2}", FLAG_SLEEP)
	intSleepOID = AddSliderOption("$Intensity_Sleep", aaaKNNIntensitySleep.GetValue(), "{2}", FLAG_SLEEP)
	intDrunkOID = AddSliderOption("$Intensity_Drunk", aaaKNNIntensityDrunk.GetValue(), "{2}", FLAG_DRUNK)
	intBodyOID = AddSliderOption("$Intensity_Body", aaaKNNIntensityBody.GetValue(), "{2}", FLAG_BODY)

	SetCursorPosition(1)
	AddHeaderOption("$BasicNeeds_LimitDamage")
	int FLAG_LIMITHUNGRY = 0
	if FLAG_HUNGRY == 1 || aaaKNNIsLimitDamageHungry.GetValueInt() == 0 || aaaKNNIsLimitDamageHungry.GetValueInt() == 2
		FLAG_LIMITHUNGRY = 1
	endIf
	int FLAG_LIMITHUNGRYMAG = 0
	if FLAG_HUNGRY == 1 || aaaKNNIsLimitDamageHungry.GetValueInt() == 2
		FLAG_LIMITHUNGRYMAG = 1
	endIf

	int FLAG_LIMITTHIRSTY = 0
	if FLAG_THIRSTY == 1 || aaaKNNIsLimitDamageThirsty.GetValueInt() == 0 || aaaKNNIsLimitDamageThirsty.GetValueInt() == 2
		FLAG_LIMITTHIRSTY = 1
	endIf
	int FLAG_LIMITTHIRSTYMAG = 0
	if FLAG_THIRSTY == 1 || aaaKNNIsLimitDamageThirsty.GetValueInt() == 2
		FLAG_LIMITTHIRSTYMAG = 1
	endIf
	IsLimitDamageHungryOID = AddTextOption("$Enable_LimitHungryDamage", GetDamageBasicneedState(aaaKNNIsLimitDamageHungry.GetValueInt()), FLAG_HUNGRY)
	damageHungryLimitValOID = AddSliderOption("$LimitValue", aaaKNNIsLimitDamageHungryValue.GetValue(), "{0}", FLAG_LIMITHUNGRY)
	damageHungryLimitMagOID = AddSliderOption("$LimitMagnitude", aaaKNNIsLimitDamageHungryMag.GetValue(), "{2}", FLAG_LIMITHUNGRYMAG)
	IsLimitDamageThirstyOID = AddTextOption("$Enable_LimitThirstyDamage", GetDamageBasicneedState(aaaKNNIsLimitDamageThirsty.GetValueInt()), FLAG_THIRSTY)
	damageThirstyLimitValOID = AddSliderOption("$LimitValue", aaaKNNIsLimitDamageThirstyValue.GetValue(), "{0}", FLAG_LIMITTHIRSTY)
	damageThirstyLimitMagOID = AddSliderOption("$LimitMagnitude", aaaKNNIsLimitDamageThirstyMag.GetValue(), "{2}", FLAG_LIMITTHIRSTYMAG)
EndFunction
Function SetBasicNeedsManagePage()
	SetTitleText("$KNN_Manage_Values")
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)
	AddHeaderOption("$Manage_BasicNeeds_Status")
	int FLAG = OPTION_FLAG_NONE
	if aaaKNNIsBasicNeedsEnable.GetValueInt() == 0
		FLAG = OPTION_FLAG_DISABLED
	endIf
	ResetHungryValueOID = AddToggleOption("$Reset_Hungry_Values", false, FLAG)
	ResetThirstyValueOID = AddToggleOption("$Reset_Thirsty_Values", false, FLAG)
	ResetSleepyValueOID = AddToggleOption("$Reset_Sleepy_Values", false, FLAG)
	ResetBodyValueOID = AddToggleOption("$Reset_Body_Values", false, FLAG)
	ResetDrunkValueOID = AddToggleOption("$Reset_Drunk_Values", false, FLAG)
	AddHeaderOption("$WaterBarrel_Stutas")
	string wbStutas = "Invalid"
	int FLAG_WATER_BARREL = OPTION_FLAG_DISABLED
	bool IsDisplayed = false
	if WaterBarrelQuest.IsRunning()
		FLAG_WATER_BARREL = OPTION_FLAG_NONE
		_KNNWaterBarrelQuest wbq = WaterBarrelQuest as _KNNWaterBarrelQuest
		if wbq
			IsDisplayed = wbq.IsLocationDisplayed
			int totalCount = wbq.waterBarrels.Length
			int i = 0
			int numCount = 0
			while i < totalCount
				if wbq.waterBarrels[i] && wbq.waterBarrels[i].GetReference()
					numCount += 1
				endIf
				i += 1
			endwhile
			wbStutas = numCount + "/" + totalCount
		endIf
	endIf
	AddTextOption("$WaterBarrel_Quantity", wbStutas, FLAG_WATER_BARREL)
	AddHeaderOption("$Output_KNNStutas")
	KNNCurrentStutasOID = AddToggleOption("$Output_KNN_Stutas", false)

	SetCursorPosition(1)
	AddHeaderOption("$Current_BasicNeeds_Status")
	CurrentHungryOID = AddTextOption("$HungryValue", KNNPlugin_Utility.GetBasicNeeds("hungry"), FLAG)
	CurrentThirstyOID = AddTextOption("$ThirstyValue", KNNPlugin_Utility.GetBasicNeeds("thirsty"), FLAG)
	CurrentSleepyOID = AddTextOption("$SleepyValue", KNNPlugin_Utility.GetBasicNeeds("Sleepiness"), FLAG)
	CurrentBodyOID = AddTextOption("$BodyValue", KNNPlugin_Utility.GetBasicNeeds("Bodyhealth"), FLAG)
	CurrentDrunkOID = AddTextOption("$DrunkValue", KNNPlugin_Utility.GetBasicNeeds("Drunkness"), FLAG)
	AddHeaderOption("$WaterBarrel_Locations")
	WaterBarrelLocationsOID = AddToggleOption("$WaterBarrels_Displayed", IsDisplayed, FLAG_WATER_BARREL)
EndFunction
Function SetGeneralAnimSettingPage()
	SetTitleText("$KNN_Anim_Setting")
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)
	int FLAG = 0
	if aaaKNNIsBasicNeedsEnable.GetValueInt() == 0
		FLAG = 1
	endIf
	AddHeaderOption("$Gender_Settings")
	PCGenderOID = AddTextOption("$PCGender", GetPCGender(aaaKNNIsPCGenderFemale.GetValueInt()))
	SetCursorPosition(1)
	IsPOVOID = AddTextOption("$Enable_POV", GetFunctionState(aaaKNNIsEnablePOV.GetValueInt()), FLAG)
	IsShieldUnequipOID = AddTextOption("$Enabled_Ctrl_Shield", GetShieldCtrl(aaaKNNIsShieldUnequip.GetValueInt()))
	IsCameraAnimatedOID = AddTextOption("$Enable_CamAnim", GetFunctionState(aaaKNNIsEnableCameraAnimated.GetValueInt()))
EndFunction
Function SetGeneralAnimPage()
	SetTitleText("$KNN_General_Anim_Settings")
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)
	mealAnimOID = new int[13]
	mealAnimStr = new string[13]
	mealAnimGV = new GlobalVariable[13]
	mealAnimDisc = new string[13]
	mealAnimStr[0] = "$EatFoodStand"
	mealAnimStr[1] = "$EatFoodSit"
	mealAnimStr[2] = "$EatSoupStand"
	mealAnimStr[3] = "$EatSoupSit"
	mealAnimStr[4] = "$DrinkStand"
	mealAnimStr[5] = "$DrinkSit"
	mealAnimStr[6] = "$WashBody"
	mealAnimStr[7] = "$FillBottleWater"
	mealAnimStr[8] = "$MakeTowel"
	mealAnimStr[9] = "$ReadBooks"
	mealAnimStr[10] = "$TakePotion"
	mealAnimStr[11] = "$Foretaste"
	mealAnimStr[12] = "$RegisterCustomPotion"
	mealAnimGV[0] = aaaAnimEatFoodStanding
	mealAnimGV[1] = aaaAnimEatFoodSitting
	mealAnimGV[2] = aaaAnimEatSoupStanding
	mealAnimGV[3] = aaaAnimEatSoupSitting
	mealAnimGV[4] = aaaAnimDrinkStanding
	mealAnimGV[5] = aaaAnimDrinkSitting
	mealAnimGV[6] = aaaAnimWashBody
	mealAnimGV[7] = aaaAnimFillWater
	mealAnimGV[8] = aaaAnimMakeTowel
	mealAnimGV[9] = aaaAnimReadBook
	mealAnimGV[10] = aaaAnimTakePotion
	mealAnimGV[11] = aaaAnimForetaste
	mealAnimGV[12] = aaaAnimRegisterCustomPotion
	mealAnimDisc[0] = "$EatFoodStand_Description"
	mealAnimDisc[1] = "$EatFoodSit_Description"
	mealAnimDisc[2] = "$EatSoupStand_Description"
	mealAnimDisc[3] = "$EatSoupSit_Description"
	mealAnimDisc[4] = "$DrinkStand_Description"
	mealAnimDisc[5] = "$DrinkSit_Description"
	mealAnimDisc[6] = "$WashBody_Description"
	mealAnimDisc[7] = "$FillBottleWater_Description"
	mealAnimDisc[8] = "$MakeTowel_Description"
	mealAnimDisc[9] = "$ReadBooks_Description"
	mealAnimDisc[10] = "$TakePotion_Description"
	mealAnimDisc[11] = "$Foretaste_Description"
	mealAnimDisc[12] = "$RegisterCustomPotion_Description"
	int[] animFlag = new int[13]
	int FLAG_EATING_DRINKING = 0
	int FLAG_WASHBODY = 0
	int FLAG_FILLBOTTLE = 0
	int FLAG_MAKE_TOWEL = 0
	int FLAG_CUSTOM_POTION = 0
	if aaaKNNIsBasicNeedsEnable.GetValueInt() == 0
		FLAG_EATING_DRINKING = 1
		FLAG_WASHBODY = 1
		FLAG_FILLBOTTLE = 1
		FLAG_MAKE_TOWEL = 1
	else
		int IsHungry = aaaKNNIsEnableHungry.GetValueInt()
		int IsThirsty = aaaKNNIsEnableThirsty.GetValueInt()
		int IsBody = aaaKNNIsEnableBodyHealth.GetValueInt()
		if IsHungry == 0 && IsThirsty == 0 && IsBody == 0
			FLAG_WASHBODY = 1
		endIf
		if IsThirsty == 0
			FLAG_FILLBOTTLE = 1
		endIf
		if IsBody == 0
			FLAG_MAKE_TOWEL = 1
		endIf
	endIf
	if aaaKNNHotkeyCustom.GetValueInt() == 0
		FLAG_CUSTOM_POTION = 1
	endIf
	animFlag[0] = FLAG_EATING_DRINKING
	animFlag[1] = FLAG_EATING_DRINKING
	animFlag[2] = FLAG_EATING_DRINKING
	animFlag[3] = FLAG_EATING_DRINKING
	animFlag[4] = FLAG_EATING_DRINKING
	animFlag[5] = FLAG_EATING_DRINKING
	animFlag[6] = FLAG_WASHBODY
	animFlag[7] = FLAG_FILLBOTTLE
	animFlag[8] = FLAG_MAKE_TOWEL
	animFlag[9] = 0
	animFlag[10] = 0
	animFlag[11] = 0
	animFlag[12] = FLAG_CUSTOM_POTION
	int index = 0
	while index < mealAnimOID.Length
		if index == 6
			SetCursorPosition(1)
		endIf
		mealAnimOID[index] = AddToggleOption(mealAnimStr[index], mealAnimGV[index].GetValueInt(), animFlag[index])
		index += 1
	endWhile
EndFunction
Function SetPerkAnimPage()
	SetTitleText("$KNN_Activate_Settings")
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)
	PerksOID = new int[24]
	PerksStrOID = new string[24]
	PerksDescOID = new string[24]
	PerksStrOID[0] = "$Play_GoToBed"
	PerksStrOID[1] = "$Play_Flora"
	PerksStrOID[2] = "$Play_Critter"
	PerksStrOID[3] = "$Play_Pray"
	PerksStrOID[4] = "$Play_Door"
	PerksStrOID[5] = "$Play_DoorLegacy"
	PerksStrOID[6] = "$Play_DoorBolt"
	PerksStrOID[7] = "$Play_LootAnimal"
	PerksStrOID[8] = "$Play_LootHumanOther"
	PerksStrOID[9] = "$Play_Chest"
	PerksStrOID[10] = "$Play_Barrel"
	PerksStrOID[11] = "$Play_Wardrobe"
	PerksStrOID[12] = "$Play_Sack"
	PerksStrOID[13] = "$Play_CupBoard"
	PerksStrOID[14] = "$Play_EndTable"
	PerksStrOID[15] = "$Play_MiscContainer"
	PerksStrOID[16] = "$Play_TrapTrigger"
	PerksStrOID[17] = "$Play_PazzlePillar"
	PerksStrOID[18] = "$Play_PuzzleWheel"
	PerksStrOID[19] = "$Play_PullBar"
	PerksStrOID[20] = "$Play_PullChain"
	PerksStrOID[21] = "$Play_Cage"
	PerksStrOID[22] = "$Play_Lever"
	PerksStrOID[23] = "$Play_DweBotton"

	PerksDescOID[0] = "$GoToBed_Description"
	PerksDescOID[1] = "$Flora_Description"
	PerksDescOID[2] = "$Critter_Description"
	PerksDescOID[3] = "$Pray_Description"
	PerksDescOID[4] = "$Door_Description"
	PerksDescOID[5] = "$DoorLegacy_Description"
	PerksDescOID[6] = "$DoorBolt_Description"
	PerksDescOID[7] = "$LootAnimal_Description"
	PerksDescOID[8] = "$LootHumanOther_Description"
	PerksDescOID[9] = "$Chest_Description"
	PerksDescOID[10] = "$Barrel_Description"
	PerksDescOID[11] = "$Wardrobe_Description"
	PerksDescOID[12] = "$Sack_Description"
	PerksDescOID[13] = "$CupBoard_Description"
	PerksDescOID[14] = "$EndTable_Description"
	PerksDescOID[15] = "$MiscContainer_Description"
	PerksDescOID[16] = "$TrapTrigger_Description"
	PerksDescOID[17] = "$PazzlePillar_Description"
	PerksDescOID[18] = "$PuzzleWheel_Description"
	PerksDescOID[19] = "$PullBar_Description"
	PerksDescOID[20] = "$PullChain_Description"
	PerksDescOID[21] = "$Cage_Description"
	PerksDescOID[22] = "$Lever_Description"
	PerksDescOID[23] = "$DweBotton_Description"
	Actor player = Game.GetPlayer()
	int FLAG = 0
	if aaaKNNIsEnableQuickLootAnim.GetValueInt() == 1
		FLAG = 1
	endIf
	int index = 0
	while index < PerksOID.Length
		if index == 12
			SetCursorPosition(1)
		endIf
		int TEMP_FLAG = OPTION_FLAG_NONE
		if index > 6 && index < 16
			TEMP_FLAG = FLAG
		endIf
		PerksOID[index] = AddToggleOption(PerksStrOID[index], player.HasPerk(PerkList.GetAt(index) as Perk), TEMP_FLAG)
		index += 1
	endWhile
EndFunction
Function SetQuicKLootAnimPage()
	SetTitleText("$KNN_QLAnim_Settings")
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)
	int IsEnableAnim = aaaKNNIsEnableQuickLootAnim.GetValueInt()
	int FLAG = OPTION_FLAG_NONE
	if 0 > SKSE.GetPluginVersion("QuickLoot")
		FLAG = OPTION_FLAG_DISABLED
		IsEnableAnim = 0
		aaaKNNIsEnableQuickLootAnim.SetValueInt(0)
	endIf
	IsActiAmiQLOID = AddTextOption("$Enable_QLAnim", GetFunctionState(IsEnableAnim), FLAG)

	SetCursorPosition(1)
	QLAnimsOID = new int[9]
	QLStrOID = new string[9]
	QLValOID = new GlobalVariable[9]
	QLDescOID = new string[9]
	QLStrOID[0] = "$Play_LootAnimal"
	QLStrOID[1] = "$Play_LootHumanOther"
	QLStrOID[2] = "$Play_Chest"
	QLStrOID[3] = "$Play_Barrel"
	QLStrOID[4] = "$Play_Wardrobe"
	QLStrOID[5] = "$Play_Sack"
	QLStrOID[6] = "$Play_CupBoard"
	QLStrOID[7] = "$Play_EndTable"
	QLStrOID[8] = "$Play_MiscContainer"

	QLValOID[0] = aaaKNNQLAnimal
	QLValOID[1] = aaaKNNQLHumanoid
	QLValOID[2] = aaaKNNQLChest
	QLValOID[3] = aaaKNNQLBarrel
	QLValOID[4] = aaaKNNQLQWardrode
	QLValOID[5] = aaaKNNQLSack
	QLValOID[6] = aaaKNNQLCupBoard
	QLValOID[7] = aaaKNNQLEndTable
	QLValOID[8] = aaaKNNQLMiscContainer

	QLDescOID[0] = "$LootAnimal_Description"
	QLDescOID[1] = "$LootHumanOther_Description"
	QLDescOID[2] = "$Chest_Description"
	QLDescOID[3] = "$Barrel_Description"
	QLDescOID[4] = "$Wardrobe_Description"
	QLDescOID[5] = "$Sack_Description"
	QLDescOID[6] = "$CupBoard_Description"
	QLDescOID[7] = "$EndTable_Description"
	QLDescOID[8] = "$MiscContainer_Description"

	int animFLAG = FLAG
	if FLAG == 0 && IsEnableAnim == 0
		animFLAG = OPTION_FLAG_DISABLED
	endIf
	int index = 0
	while index < QLAnimsOID.Length			
		QLAnimsOID[index] = AddToggleOption(QLStrOID[index], QLValOID[index].GetValueInt(), animFLAG)
		index += 1
	endWhile
EndFunction
Function SetBathingPage()
	SetTitleText("$KNN_Bathing_Settings")
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)
	slotsOID = new int[29]
	slotsStrOID = new string[29]
	slotsStrOID[0] = "Slot30: Head"
	slotsStrOID[1] = "Slot31: Hair"
	slotsStrOID[2] = "Slot32: Body"
	slotsStrOID[3] = "Slot33: Hands"
	slotsStrOID[4] = "Slot34: Forearms"
	slotsStrOID[5] = "Slot35: Amulet"
	slotsStrOID[6] = "Slot36: Ring"
	slotsStrOID[7] = "Slot37: Feet"
	slotsStrOID[8] = "Slot38: Calves"
	slotsStrOID[9] = "Slot39: Shield"
	slotsStrOID[10] = "Slot40: Tail"
	slotsStrOID[11] = "Slot41: Longhair"
	slotsStrOID[12] = "Slot42: Circlet"
	slotsStrOID[13] = "Slot43: Ears"
	slotsStrOID[14] = "Slot44: Face/Mouth"
	slotsStrOID[15] = "Slot45: Neck"
	slotsStrOID[16] = "Slot46: Chest(primary)"
	slotsStrOID[17] = "Slot47: Back"
	slotsStrOID[18] = "Slot48: Misc"
	slotsStrOID[19] = "Slot49: Pelvis(primary)"
	slotsStrOID[20] = "Slot52: Pelvis(secondary)"
	slotsStrOID[21] = "Slot53: Leg(primary)"
	slotsStrOID[22] = "Slot54: Leg(secondary)"
	slotsStrOID[23] = "Slot55: Face alternate or Jewelry"
	slotsStrOID[24] = "Slot56: Chest(secondary)"
	slotsStrOID[25] = "Slot57: Shoulder"
	slotsStrOID[26] = "Slot58: Arm(secondary)"
	slotsStrOID[27] = "Slot59: Arm(primary)"
	slotsStrOID[28] = "Slot60: Misc"

	int FLAG = 0
	if aaaKNNIsBasicNeedsEnable.GetValueInt() == 0
		FLAG = 1
	else
		if aaaKNNIsEnableBodyHealth.GetValueInt() == 0
			FLAG = 1
		endIf
	endIf
	SetCursorPosition(0)
	CurrentCharacterSlotOID = AddTextOption("$Current_Slot_Settings", GetCurrentSlots(CurrentCharacter))
	SlotMaskArray = KNNPlugin_Utility.LoadSlotMasks(GetXMLPath(CurrentCharacter))
	if 29 == SlotMaskArray.Length
		int index = 0
		while index < 29
			if index == 14
				SetCursorPosition(1)
			endIf
			slotsOID[index] = AddToggleOption(slotsStrOID[index], SlotMaskArray[index], FLAG)			
			index += 1
		endWhile
	endIf
EndFunction
Function SetEquippingArmorStatusPage()
	SetTitleText("$KNN_EquipArmorStatus")
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)
	Form[] armors = KNNPlugin_Utility.GetEquippedArmors(Game.GetPlayer())
	if !armors.Length
		AddHeaderOption("Nothing")
	else
		int count = armors.Length
		int half = 0
		if 1 < count
			half = count / 2
		endIf
		int i = 0
		while i < count
			if 0 < half && i == half
				SetCursorPosition(1)
			endIf
			Armor thisArmor = armors[i] as Armor
			if thisArmor
				;Debug.Trace(thisArmor.GetName())
				AddHeaderOption(thisArmor.GetName())
				string slotName = KNNPlugin_Utility.GetArmorSlotName(thisArmor)
				if "" == slotName
					AddTextOption("Slot", "unknown", OPTION_FLAG_DISABLED)
				else
					AddTextOption("Slot", slotName, OPTION_FLAG_DISABLED)
				endIf
			endIf
			i += 1
		endWhile
	endIf	
EndFunction
Function SetMiscConfigGeneralPage()
	SetTitleText("$KNN_misc_Basic_Settings")
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)
	int FLAG = 0
	int FLAG_TRUNDRA_COTTON = 0	
	if aaaKNNIsBasicNeedsEnable.GetValueInt() == 0
		FLAG = 1
		FLAG_TRUNDRA_COTTON = 1
	endIf
	if aaaKNNIsEnableBodyHealth.GetValueInt() == 0
		FLAG_TRUNDRA_COTTON = 1
	endIf
	
	MsgOID = AddTextOption("$Enable_Messgae", GetFunctionState(aaaKNNIsEnableMessage.GetValueInt()), FLAG)	
	convertEmptyBottleOID = AddTextOption("$ConvertBottle", GetFunctionState(aaaKNNIsConvertEmptyBottle.GetValueInt()), FLAG)
	NeedTundraCottnOID = AddSliderOption("$TrundraCotton_Amount", aaaKNNNeedTundraCotton.GetValue(), "{0}", FLAG_TRUNDRA_COTTON)
	GetBookOID = AddToggleOption("$Get_TextBook", false, FLAG)	

	SetCursorPosition(1)
	SellBottleOID = AddTextOption("$SellWaterBottle", GetFunctionState(aaaKNNIsEnableSellWaterBottle.GetValueInt()), FLAG)
	SellTowelPotionOID = AddTextOption("$SellTowelPotion", GetFunctionState(aaaKNNIsEnabledSellTowel.GetValueInt()), FLAG)
	WaterBarrelOID = AddTextOption("$WaterBarrelFeature", GetFunctionState(_KNNIsEnableWaterBarrelFeature.GetValueInt()), FLAG)
EndFunction
Function SetMiscConfigExtendPage()
	SetTitleText("$KNN_misc_Extend_Settings")
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)
	QuiverOID = AddTextOption("$Enable_Quiver", GetFunctionState(aaaKNNIsEnableQuiver.GetValueInt()))
	StumbleOID =  AddTextOption("$Enable_Stumble", GetFunctionState(aaaKNNIsEnableStumble.GetValueInt()))	
EndFunction
Function SetMiscConfigManagementPage()
	SetTitleText("$KNN_misc_Managemant_Settings")
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)
	AddHeaderOption("$Manage_Foods_List")
	int FLAG = OPTION_FLAG_NONE
	if 0 == aaaKNNIsBasicNeedsEnable.GetValueInt()
		FLAG = OPTION_FLAG_DISABLED
	endIf
	FoodTypeListOID = new int[7]
	string[] menuListNames = new string[7]
	menuListNames[0] = "$FoodList"
	menuListNames[1] = "$SoupList"
	menuListNames[2] = "$WaterList"
	menuListNames[3] = "$AlcoholList"	
	menuListNames[4] = "$RawFoodLidt"
	menuListNames[5] = "$NoFood"
	menuListNames[6] = "$CustomPotion"
	ClearListMessageList = new string[7]
	ClearListMessageList[0] = "$ClearedFoodList"
	ClearListMessageList[1] = "$ClearedSoupList"
	ClearListMessageList[2] = "$ClearedWaterList"
	ClearListMessageList[3] = "$ClearedAlcholList"
	ClearListMessageList[4] = "$ClearedLawFoodList"
	ClearListMessageList[5] = "$ClearedNoFoodList"
	ClearListMessageList[6] = "$ClearedCustomPotionList"
	FoodListNames = new string[7]
	FoodListNames[0] = "Foods"
	FoodListNames[1] = "Soup"
	FoodListNames[2] = "Water"
	FoodListNames[3] = "Alchol"
	FoodListNames[4] = "RawFoods"
	FoodListNames[5] = "NoFoodsNoDrinks"
	FoodListNames[6] = "CustomPotions"
	int i = 0
	while i < FoodTypeListOID.Length
		FoodTypeListOID[i] = AddMenuOption(menuListNames[i], "Select Form", FLAG)
		i += 1
	endwhile
	ExportAllFoodListOID = AddToggleOption("$Export_FoodList", false)
	ImportAllFoodListOID = AddToggleOption("$Import_FoodList", false)

	SetCursorPosition(1)
	int FLAG_MOD_BED = OPTION_FLAG_NONE
	if !Game.GetPlayer().HasPerk(aaaKNNPerkGotoBed)
		FLAG_MOD_BED = OPTION_FLAG_DISABLED
	endIf
	AddHeaderOption("$Manage_ModBed")
	ResolveModBedOID = AddToggleOption("$ResolveModBed", false, FLAG_MOD_BED)
	AddHeaderOption("$ExternalModFood_xml")
	CreateXMLOID = AddMenuOption("$Create_XML", "Select XML Type")
	AddHeaderOption("$Manege_MCM_Settings")
	SaveMCMSettingsOID = AddToggleOption("$Save_Settings", false)
	LoadMCMSettingsOID = AddToggleOption("$Load_Settings", false)
EndFunction
Function SetPotionHotkeyPage()
	SetTitleText("$KNN_Potion_Hotkey_Settings")
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)
	int FLAG = 0
	if aaaKNNIsBasicNeedsEnable.GetValueInt() == 0
		FLAG = 1
	endIf
	;小タイトル
	AddHeaderOption("$Foods_Potion")
	FOODOID = AddKeyMapOption("$Potion_Hotkey", aaaKNNHotkeyFoods.GetValueInt(), FLAG)
	PUFOODOID = AddTextOption("$Potion_text_priorityA", GetFoodEffectState(aaaKNNPotionUseageEffectFoods.GetValueInt()), FLAG)
	int foodPriorityFlag = FLAG
	if aaaKNNPotionUseageEffectFoods.GetValueInt() == 2
		foodPriorityFlag = 1
	endIf
	PRIORITYFOODOID = AddTextOption("$Potion_text_priorityB", GetPotionPriorityState(aaaKNNPotionUseagePriorityFoods.GetValueInt()), foodPriorityFlag)

	AddHeaderOption("$Drinks_Potion")
	DRINKOID = AddKeyMapOption("$Potion_Hotkey", aaaKNNHotkeyDrinks.GetValueInt(), FLAG)
	PUDRINKOID = AddTextOption("$Potion_text_priorityA", GetDrinkEffectState(aaaKNNPotionUseageEffectDrinks.GetValueInt()), FLAG)
	PRIORITYDRINKOID = AddTextOption("$Potion_text_priorityB", GetPotionPriorityState(aaaKNNPotionUseagePriorityDrinks.GetValueInt()), FLAG)
	PRIORITYDRINKSTYPEOID = AddTextOption("$Potion_text_priorityC", GetPotionDrinkTypeState(aaaKNNPotionUseagePriorityWater.GetValueInt()), FLAG)

	SetCursorPosition(1)
	AddHeaderOption("$Custom_Potion")
	CUSTOMOID = AddKeyMapOption("$Potion_Hotkey", aaaKNNHotkeyCustom.GetValueInt(), FLAG)
	PUCUSTOMOID = AddTextOption("$Potion_text_priorityA", GetPotionEffectState(aaaKNNPotionUseageEffectCustom.GetValueInt()), FLAG)
	;小タイトル
EndFunction
Function SetMiscHotkeyPage()
	SetTitleText("$Misc_Hotkey_Settings")
	SetCursorFillMode(TOP_TO_BOTTOM)
	int FLAG = OPTION_FLAG_NONE
	if 0 == aaaKNNIsBasicNeedsEnable.GetValueInt()
		FLAG = OPTION_FLAG_DISABLED
		if -1 != aaaKNNHotkeyIdleAnim.GetValueInt()
			aaaKNNHotkeyIdleAnim.SetValueInt(-1)
		endIf
		if -1 != aaaKNNHotkeyHipBag.GetValueInt()
			aaaKNNHotkeyHipBag.SetValueInt(-1)
		endIf
	endIf
	SetCursorPosition(0)
	AddHeaderOption("$KNN_IdleAnim_Settings")
	IdleAnimOID = AddKeyMapOption("$IdleAnim_Hotkey", aaaKNNHotkeyIdleAnim.GetValueInt(), FLAG)
	SetCursorPosition(1)
	AddHeaderOption("$KNN_HipBag_Settings")
	HipBagOID = AddKeyMapOption("$Hotkey_HipBag", aaaKNNHotkeyHipBag.GetValueInt(), FLAG)
EndFunction
Function SetFollowerPage()
	SetTitleText("$KNN_Follower_Settings")
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)
	followerOID = new int[15]
	followerStrOID = new string[15]
	followerValOID = new GlobalVariable[15]
	followerStrOID[0] = "$Follower_Harvest_Anim"
	followerStrOID[1] = "$Follower_Container_Anim"
	followerStrOID[2] = "$Follower_Door_Anim"
	followerStrOID[3] = "$Follower_DoorBar_Anim"
	followerStrOID[4] = "$Follower_Loot_Anim"
	followerStrOID[5] = "$Follower_PuzzuldePillar_Anim"
	followerStrOID[6] = "$Follower_Shrine_Anim"
	followerStrOID[7] = "$Follower_PullBar_Anim"
	followerStrOID[8] = "$Follower_PullChain_Anim"
	followerStrOID[9] = "$Follower_Always_Anim"
	followerStrOID[10] = "$Follower_FillWater_Anim"
	followerStrOID[11] = "$Follower_WashBody_Anim"
	followerStrOID[12] = "$Follower_Sleeping_Anim"
	followerStrOID[13] = "$Follower_Meal_Anim"
	followerStrOID[14] = "$Enable_DirtyBody"
	followerValOID[0] = aaaKNNFollowerPlayHarvest
	followerValOID[1] = aaaKNNFollowerPlayContainer
	followerValOID[2] = aaaKNNFollowerPlayDoor
	followerValOID[3] = aaaKNNFollowerPlayDoorBar
	followerValOID[4] = aaaKNNFollowerPlayLoot
	followerValOID[5] = aaaKNNFollowerPlayPuzzulePillar
	followerValOID[6] = aaaKNNFollowerPlayShrine
	followerValOID[7] = aaaKNNFollowerPlayPullBar
	followerValOID[8] = aaaKNNFollowerPlayPullChain
	followerValOID[9] = _EnabledAlwaysFollowerAnimActivation
	followerValOID[10] = aaaKNNFollowerFillWater
	followerValOID[11] = aaaKNNFollowerWashBody
	followerValOID[12] = aaaKNNFollowerPlaySleeping
	followerValOID[13] = aaaKNNFollowerPlayMeal
	followerValOID[14] = aaaKNNIsEnableFollowerDirtyBodyEffect
	AddHeaderOption("$Follower_ActivationAnim_Settings")
	int index = 0
	while index < followerOID.Length
		if index == 2
			followerOID[index] = AddToggleOption(followerStrOID[index], followerValOID[index].GetValueInt(), 1)
		else
			if index == 10				
				SetCursorPosition(1)
				AddHeaderOption("$Follower_MiscAnim_Settings")
			endIf
			int FLAG = 0
			if aaaKNNFollowerPlaySleeping == followerValOID[index]
				Actor player = Game.GetPlayer()
				if !player || !player.HasPerk(aaaKNNPerkGotoBed)
					FLAG = 1
					if 0 != aaaKNNFollowerPlaySleeping.GetValueInt()
						aaaKNNFollowerPlaySleeping.SetValueInt(0)
						(PerkAnimCtrlQuest as aaaKNNPlayPerkBedAnimQuest).SetFollowerSleepAnimEvent(0)
					endIf
				endIf
			elseIf aaaKNNFollowerPlayMeal == followerValOID[index]
				if IsResetFollowerMealToggle()
					FLAG = 1
				endIf
			elseIf aaaKNNIsEnableFollowerDirtyBodyEffect == followerValOID[index]
				if 1 != aaaKNNIsEnableDirtyBodyEffect.GetValueInt()
					FLAG = 1
				elseIf 1 != aaaKNNIsBasicNeedsEnable.GetValueInt() || 1 != aaaKNNIsEnableBodyHealth.GetValueInt()
					FLAG = 1
				endIf
			endIf
			followerOID[index] = AddToggleOption(followerStrOID[index], followerValOID[index].GetValueInt(), FLAG)
		endIf
		index += 1
	endWhile
EndFunction
Function SetJurnalPage()
	SetTitleText("$KNN_Jurnal_Settings")
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)
	int FLAG = 0
	if aaaKNNIsBasicNeedsEnable.GetValueInt() == 0
		FLAG = 1
	endIf
	JurnalOID = AddKeyMapOption("$Hotkey_Jurnal", aaaKNNHotkeyJurnal.GetValueInt(), FLAG)
	UseInkPenOID = AddTextOption("$Enable_ExpendInkPen", GetFunctionState(aaaKNNIsEnableUseInkPen.GetValueInt()))
EndFunction
Function SetWidgetPage()
	SetTitleText("$KNN_Widget_Settings")
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)
	int FLAG = 0
	if aaaKNNIsBasicNeedsEnable.GetValueInt() == 0
		FLAG = 1
		if aaaKNNIsEnableWidget.GetValueInt() == 1
			aaaKNNIsEnableWidget.SetValueInt(0)
		endIf
		if aaaKNNIsEnableWidgetOp.GetValueInt() == 1
			aaaKNNIsEnableWidgetOp.SetValueInt(0)
		endIf
	endIf		
	WidgetHotkeyOID = AddKeyMapOption("$Widget_Hotkey", aaaKNNHotkeyWidget.GetValueInt(), FLAG)
	AddHeaderOption("$Widget_main")
	WidgetOID = AddTextOption("$Enable_Widget", GetFunctionState(aaaKNNIsEnableWidget.GetValueInt()), FLAG)
	AddHeaderOption("$WidgetPosition")
	WidgetPosXOID = addSliderOption("$Widget_PositionX", widget.GetWidgetPositionX(), "{0}", FLAG)
	WidgetPosYOID = addSliderOption("$Widget_PositionY", widget.GetWidgetPositionY(), "{0}", FLAG)
	AddHeaderOption("$WidgetAlpha")
	WidgetAlphaOID = addSliderOption("$Widget_Alpha", widget.GetWigetAlpha(), "{0}", FLAG)
	SetCursorPosition(1)
	AddEmptyOption()
	AddHeaderOption("$Widget_option")
	WidgetOpOID = AddTextOption("$Enable_Widget", GetFunctionState(aaaKNNIsEnableWidgetOp.GetValueInt()), FLAG)
	AddHeaderOption("$WidgetPosition")
	WidgetOpPosXOID = addSliderOption("$Widget_PositionX", widget.GetWidgetOptionPositionX(), "{0}", FLAG)
	WidgetOpPosYOID = addSliderOption("$Widget_PositionY", widget.GetWidgetOptionPositionY(), "{0}", FLAG)
	AddHeaderOption("$WidgetAlpha")
	WidgetOpAlphaOID = addSliderOption("$Widget_Alpha", widget.GetWigetOptionAlpha(), "{0}", FLAG)
EndFunction
Function SetHeadTrackingGeneralPage()
	int FLAG_ALL = OPTION_FLAG_NONE
	SetTitleText("$KNNHT_General")
	SetCursorFillMode(TOP_TO_BOTTOM)
	;MCM左側
	SetCursorPosition(0)
	if aaaKNNIsHT.GetValueInt() == 1
		IsHTOID = AddToggleOption("$Enable_Headtracking", true)
	else
		IsHTOID = AddToggleOption("$Enable_Headtracking", false)
		FLAG_ALL = OPTION_FLAG_DISABLED
	endIf
	HTPriorityOID = AddTextOption("$Priority_Mode", GetHTPriority(aaaKNNHTPriority.GetValueInt()), FLAG_ALL)
	HTIntervalOID = addSliderOption("$Update_Interval", aaaKNNHTInterVal.GetValue(), "${1} Second", FLAG_ALL)
	NextHTIntervalOID = addSliderOption("$NextHT_Interval", _KNNNextHTInterval.GetValue(), "${0} Milliseconds", FLAG_ALL)
	int FLAG_EX_EXTEND = FLAG_ALL
	if !aaaKNNIsEnableExpression.GetValueInt()
		FLAG_EX_EXTEND = OPTION_FLAG_DISABLED
	endIf
	IsExpressionChangeExtensionOID = AddToggleOption("$Expression_extension", aaaKNNIsExpressionChangeExtension.GetValueInt(), FLAG_EX_EXTEND)	
	SetCursorPosition(1)
	int FLAG_HT_WHILE_WEAPON = FLAG_ALL
	if Game.GetPlayer().IsWeaponDrawn() || 255 != Game.GetModByName("UltimateCombat.esp")
		FLAG_HT_WHILE_WEAPON = OPTION_FLAG_DISABLED
	endIf
	IsNotHTWeaponDrawnOID = AddToggleOption("$Disabled_HT_WeaponDrawn", _KNNHTDisabledWhileWeaponDrawn.GetValueInt() as bool, FLAG_HT_WHILE_WEAPON)
	IsIdleAnimOID = AddToggleOption("$Enable_Idle_Anim", aaaKNNIsHTIdleAnim.GetValueInt(), FLAG_ALL)
	UpdateNoLookObjOID = AddToggleOption("$Update_NoLookObject", false, FLAG_ALL)
EndFunction
Function SetHeadTrackingEyePage()
	SetTitleText("$EyeTracking_Settings")
	SetCursorFillMode(TOP_TO_BOTTOM)
	;MCM左側
	int FLAG_MAIN = OPTION_FLAG_NONE
	int FLAG_SUB = OPTION_FLAG_NONE
	if !aaaKNNIsHT.GetValueInt() || !aaaKNNIsEnableExpression.GetValueInt()
		FLAG_MAIN = OPTION_FLAG_DISABLED
	endIf
	FLAG_SUB = FLAG_MAIN
	if !aaaKNNIsHTEnableEyeTracking.GetValueInt()
		FLAG_SUB = OPTION_FLAG_DISABLED
	endIf
	SetCursorPosition(0)
	IsEyeTrackingOID = AddTextOption("$KNNHT_Eye", GetFunctionState(aaaKNNIsHTEnableEyeTracking.GetValueInt()), FLAG_MAIN)
	AddHeaderOption("$Horizontal_Settings")
	HorizontalRangeMaxOID = AddSliderOption("$RangeMax", aaaKNNEyeHorizonalRangeMax.GetValue(), "${0} Degree", FLAG_SUB)
	HorizontalRangeMinOID = AddSliderOption("$RangeMin", aaaKNNEyeHorizonalRangeMin.GetValue(), "${0} Degree", FLAG_SUB)
	HorizontalPowerMaxOID = AddSliderOption("$PowerMax", aaaKNNEyeHorizonalPowerMax.GetValue(), "{0}", FLAG_SUB)
	HorizontalPowerMinOID = AddSliderOption("$PowerMin", aaaKNNEyeHorizonalpowerMin.GetValue(), "{0}", FLAG_SUB)
	SetCursorPosition(1)
	AddEmptyOption()
	AddHeaderOption("$Vertical_Settings")
	VerticalRangeMaxOID = AddSliderOption("$RangeMax", aaaKNNEyeVerticalRangeMax.GetValue(), "${0} Degree", FLAG_SUB)
	VerticalRangeMinOID = AddSliderOption("$RangeMin", aaaKNNEyeVerticalRangeMin.GetValue(), "${0} Degree", FLAG_SUB)
	VerticalPowerMaxOID = AddSliderOption("$PowerMax", aaaKNNEyeVerticalPowerMax.GetValue(), "{0}", FLAG_SUB)
	VerticalPowerMinOID = AddSliderOption("$PowerMin", aaaKNNEyeVerticalpowerMin.GetValue(), "{0}", FLAG_SUB)
EndFunction
Function SetHeadTrackingBasicPage()
	SetTitleText("$KNNHT_Basic")
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)
	AddHeaderOption("$Combat_Settings")
	EnabledExInCombatOID = AddTextOption("$Disalbed_Combat_Expression", GetFunctionState(aaaKNNIsEnableExpressionInCombat.GetValueInt()), GetFlag(iCOMB, true))
	int FLAG_EX_COMBAT = OPTION_FLAG_DISABLED
	int FLAG_VAL_COMBAT = OPTION_FLAG_DISABLED
	if 0 != aaaKNNIsEnableExpressionInCombat.GetValueInt()
		FLAG_EX_COMBAT = GetFlag(iCOMB, true)
		FLAG_VAL_COMBAT = GetFlag(iCOMB, false)
	endIf
	HTExBasicOID = new int[4]
	HTExValBasicOID = new int[4]
	HTExBasicDefault = new int[4]
	HTExBasicDefault[0] = 15
	HTExBasicDefault[1] = 9
	HTExBasicDefault[2] = 13
	HTExBasicDefault[3] = 11
	ExValBasicDefault = new float[4]
	ExValBasicDefault[0] = 100.0
	ExValBasicDefault[1] = 100.0
	ExValBasicDefault[2] = 100.0
	ExValBasicDefault[3] = 100.0
	int[] exFlag = new int[4]
	exFlag[0] = FLAG_EX_COMBAT
	exFlag[1] = GetFlag(iPURSUE, true)
	exFlag[2] = GetFlag(iALERT, true)
	exFlag[3] = GetFlag(iALERTSHOUT, true)
	int[] exValFlag = new int[4]
	exValFlag[0] = FLAG_VAL_COMBAT
	exValFlag[1] = GetFlag(iPURSUE, false)
	exValFlag[2] = GetFlag(iALERT, false)
	exValFlag[3] = GetFlag(iALERTSHOUT, false)
	string[] basicHeaderNames = new string[3]
	basicHeaderNames[0] = "$Pursued_Settings"
	basicHeaderNames[1] = "$Alerted_Settings"
	basicHeaderNames[2] = "$AlertedShout_Settings"
	int i = 0
	while i < HTExBasicOID.Length
		if 0 != i
			if 2 == i
				SetCursorPosition(1)
			endIf
			AddHeaderOption(basicHeaderNames[i - 1])
		endIf
		HTExBasicOID[i] = AddTextOption("$ExMood", GetExpressionType((HTExBasicGv.GetAt(i) as GlobalVariable).GetValueInt()), exFlag[i])
		HTExValBasicOID[i] = addSliderOption("$Intensity", (HTExValBasicGv.GetAt(i) as GlobalVariable).GetValue(), "{0}", exValFlag[i])
		i += 1
	endwhile
	;ExCombatOID = AddTextOption("$ExMood", GetExpressionType(aaaKNNExCombat.GetValueInt()), FLAG_EX_COMBAT)
	;ExValueCombatOID = addSliderOption("$Intensity", aaaKNNExValueCombat.GetValue(), "{0}", FLAG_VAL_COMBAT)

	;AddHeaderOption("$Pursued_Settings")
	;ExPursuedOID = AddTextOption("$ExMood", GetExpressionType(aaaKNNExPursued.GetValueInt()), GetFlag(iPURSUE, true))
	;ExValuePursuedOID = addSliderOption("$Intensity", aaaKNNExValuePursued.GetValue(), "{0}", GetFlag(iPURSUE, false))

	;SetCursorPosition(1)
	;AddHeaderOption("$Alerted_Settings")
	;ExAlertedOID = AddTextOption("$ExMood", GetExpressionType(aaaKNNExAlerted.GetValueInt()), GetFlag(iALERT, true))
	;ExValueAlertedOID = addSliderOption("$Intensity", aaaKNNExValueAlerted.GetValue(), "{0}", GetFlag(iALERT, false))

	;AddHeaderOption("$AlertedShout_Settings")
	;ExAlertedShoutOID = AddTextOption("$ExMood", GetExpressionType(aaaKNNExAlertedShout.GetValueInt()), GetFlag(iALERTSHOUT, true))
	;ExValueAlertedShoutOID = addSliderOption("$Intensity", aaaKNNExValueAlertedShout.GetValue(), "{0}", GetFlag(iALERTSHOUT, false))
EndFunction
Function SetHeadTrackingDetailPage()
	SetTitleText("$KNNHT_Detail")
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)
	;小タイトル
	AddHeaderOption("$Actor_Settings")		
	IsHTActorOID = AddToggleOption("$function_enable", 0 != aaaKNNIsHTActor.GetValueInt(), GetFlag(iACTO, true))
	HTExActorsOID = new int[9]
	HTExValActorsOID = new int[9]
	ExValActorsDesc = new string[9]
	ExValActorsDesc[0] = "$ActorRank1_Settings_Description"
	ExValActorsDesc[1] = "$ActorRank2_Settings_Description"
	ExValActorsDesc[2] = "$ActorRank3_Settings_Description"
	ExValActorsDesc[3] = "$ActorRank4_Settings_Description"
	ExValActorsDesc[4] = "$ActorRank-1_Settings_Description"
	ExValActorsDesc[5] = "$ActorRank-2_Settings_Description"
	ExValActorsDesc[6] = "$ActorRank-3_Settings_Description"
	ExValActorsDesc[7] = "$ActorRank-4_Settings_Description"
	ExValActorsDesc[8] = "$PreyAnimal_Settings_Description"
	HTExActorDefault = new int[9]
	HTExActorDefault[0] = 10
	HTExActorDefault[1] = 10
	HTExActorDefault[2] = 10
	HTExActorDefault[3] = 10
	HTExActorDefault[4] = 8
	HTExActorDefault[5] = 8
	HTExActorDefault[6] = 14
	HTExActorDefault[7] = 14
	HTExActorDefault[8] = 10
	HTExValActorDefault = new float[9]
	HTExValActorDefault[0] = 20.0
	HTExValActorDefault[1] = 40.0
	HTExValActorDefault[2] = 60.0
	HTExValActorDefault[3] = 100.0
	HTExValActorDefault[4] = 40.0
	HTExValActorDefault[5] = 60.0
	HTExValActorDefault[6] = 50.0
	HTExValActorDefault[7] = 100.0
	HTExValActorDefault[8] = 50.0
	string[] actorsHeadNames = new string[9]
	actorsHeadNames[0] = "Rank: 1"
	actorsHeadNames[1] = "Rank: 2"
	actorsHeadNames[2] = "Rank: 3"
	actorsHeadNames[3] = "Rank: 4"
	actorsHeadNames[4] = "Rank: -1"
	actorsHeadNames[5] = "Rank: -2"
	actorsHeadNames[6] = "Rank: -3"
	actorsHeadNames[7] = "Rank: -4"
	actorsHeadNames[8] = "$PreyAnimals"
	int[] actorsFlags = new int[9]
	actorsFlags[0] = iACTO_P0
	actorsFlags[1] = iACTO_P1
	actorsFlags[2] = iACTO_P2
	actorsFlags[3] = iACTO_P3
	actorsFlags[4] = iACTO_N0
	actorsFlags[5] = iACTO_N1
	actorsFlags[6] = iACTO_N2
	actorsFlags[7] = iACTO_N3
	actorsFlags[8] = iACTO_PREY

	int i = 0
	while i < HTExActorsOID.Length
		AddHeaderOption(actorsHeadNames[i])
		HTExActorsOID[i] = AddTextOption("$ExMood", GetExpressionType((HTExActorGV.GetAt(i) as GlobalVariable).GetValueInt()), GetFlag(iACTO, false))
		HTExValActorsOID[i] = addSliderOption("$Intensity", (HTExValActorGV.GetAt(i) as GlobalVariable).GetValue(), "{0}", GetFlag(actorsFlags[i], false))
		i += 1
	endwhile
	HTFormsOID = new int[11]
	HTExFormsOID = new int[11]
	HTExFormDefault = new int[11]
	HTExFormDefault[0] = 12
	HTExFormDefault[1] = 10
	HTExFormDefault[2] = 12
	HTExFormDefault[3] = 12
	HTExFormDefault[4] = 12
	HTExFormDefault[5] = 12
	HTExFormDefault[6] = 12
	HTExFormDefault[7] = 7
	HTExFormDefault[8] = 12
	HTExFormDefault[9] = 12
	HTExFormDefault[10] = 12
	HTExValFormsOID = new int[11]	
	HTExValFormDefault = new float[11]	
	HTExValFormDefault[0] = 50.0
	HTExValFormDefault[1] = 30.0
	HTExValFormDefault[2] = 50.0
	HTExValFormDefault[3] = 50.0
	HTExValFormDefault[4] = 50.0
	HTExValFormDefault[5] = 50.0
	HTExValFormDefault[6] = 50.0
	HTExValFormDefault[7] = 100.0
	HTExValFormDefault[8] = 50.0
	HTExValFormDefault[9] = 50.0
	HTExValFormDefault[10] = 40.0
	string[] HTFormHeaderNames = new string[11]
	HTFormHeaderNames[0] = "$Container_Settings"
	HTFormHeaderNames[1] = "$Food_Settings"
	HTFormHeaderNames[2] = "$Potion_Settings"
	HTFormHeaderNames[3] = "$Weapon_Settings"
	HTFormHeaderNames[4] = "$Armor_Settings"
	HTFormHeaderNames[5] = "$Book_Settings"
	HTFormHeaderNames[6] = "$Misc_Settings"
	HTFormHeaderNames[7] = "$Furniture_Settings"
	HTFormHeaderNames[8] = "$Ingredient_Settings"
	HTFormHeaderNames[9] = "$Activator_Settings"
	HTFormHeaderNames[10] = "$Flora_Settings"
	int[] HTFormFlags = new int[11]
	HTFormFlags[0] = iCONT
	HTFormFlags[1] = iFOOD
	HTFormFlags[2] = iPOTI
	HTFormFlags[3] = iWEAP
	HTFormFlags[4] = iARMO
	HTFormFlags[5] = iBOOK
	HTFormFlags[6] = iMISC
	HTFormFlags[7] = iFURN
	HTFormFlags[8] = iINGR
	HTFormFlags[9] = iACTI
	HTFormFlags[10] = iFLOR

	i = 0
	while i < HTFormsOID.Length
		if 2 == i
			SetCursorPosition(1)
		endIf
		AddHeaderOption(HTFormHeaderNames[i])
		HTFormsOID[i] = AddToggleOption("$function_enable", 0 != (HTFormGV.GetAt(i) as GlobalVariable).GetValueInt(), GetFlag(HTFormFlags[i], true))
		HTExFormsOID[i] = AddTextOption("$ExMood", GetExpressionType((HTExFormGV.GetAt(i) as GlobalVariable).GetValueInt()), GetFlag(HTFormFlags[i], false))
		HTExValFormsOID[i] = addSliderOption("$Intensity", (HTExValFormGV.GetAt(i) as GlobalVariable).GetValue(), "{0}", GetFlag(HTFormFlags[i], false))
		i += 1
	endwhile	
EndFunction

Event OnOptionSliderOpen(int option)
	if option == FoodsTimeOID
		SetSliderDialogStartValue(_KNNFoodsTimePerDay.GetValue())
		SetSliderDialogDefaultValue(3.0)
		SetSliderDialogRange(1.0, 3.0)
		SetSliderDialogInterval(1.0)
	elseIf option == DrinksTimeOID
		SetSliderDialogStartValue(_KNNDrinksTimePerDay.GetValue())
		SetSliderDialogDefaultValue(3.0)
		SetSliderDialogRange(1.0, 3.0)
		SetSliderDialogInterval(1.0)
	elseIf  option == intHungryOID
		SetSliderDialogStartValue(aaaKNNIntensityHungry.GetValue())
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.05, 5.0)
		SetSliderDialogInterval(0.05)
	elseIf option == intThirstyOID
		SetSliderDialogStartValue(aaaKNNIntensityThirsty.GetValue())
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.05, 5.0)
		SetSliderDialogInterval(0.05)
	elseIf option == intSleepOID
		SetSliderDialogStartValue(aaaKNNIntensitySleep.GetValue())
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 5.0)
		SetSliderDialogInterval(0.05)
	elseIf option == intDrunkOID
		SetSliderDialogStartValue(aaaKNNIntensityDrunk.GetValue())
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.05, 20.0)
		SetSliderDialogInterval(0.05)
	elseIf option == intBodyOID
		SetSliderDialogStartValue(aaaKNNIntensityBody.GetValue())
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 5.0)
		SetSliderDialogInterval(0.05)
	elseIf option == magHungryOID
		SetSliderDialogStartValue(aaaKNNDamageMagnitudeHungry.GetValue())
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.00, 2.00)
		SetSliderDialogInterval(0.01)
	elseIf option == magThirstyOID
		SetSliderDialogStartValue(aaaKNNDamageMagnitudeThirsty.GetValue())
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.00, 2.00)
		SetSliderDialogInterval(0.01)
	elseIf option == shortSleeperOID
		SetSliderDialogStartValue(aaaKNNShortSleeper.GetValue())
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.05, 5.00)
		SetSliderDialogInterval(0.05)
	elseIf option == intervalBodyOID
		SetSliderDialogStartValue(aaaKNNWashBodyInterval.GetValue())
		SetSliderDialogDefaultValue(3.0)
		SetSliderDialogRange(1.0, 7.0)
		SetSliderDialogInterval(1.0)
	elseIf option == damageHungryLimitValOID
		SetSliderDialogStartValue(aaaKNNIsLimitDamageHungryValue.GetValue())
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-4320.0, 2880.0)
		SetSliderDialogInterval(10.0)
	elseIf option == damageHungryLimitMagOID
		SetSliderDialogStartValue(aaaKNNIsLimitDamageHungryMag.GetValue())
		SetSliderDialogDefaultValue(1.00)
		SetSliderDialogRange(0.01, 5.00)
		SetSliderDialogInterval(0.01)
	elseIf option == damageThirstyLimitValOID
		SetSliderDialogStartValue(aaaKNNIsLimitDamageThirstyValue.GetValue())
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-4320.0, 2880.0)
		SetSliderDialogInterval(10.0)
	elseIf option == damageThirstyLimitMagOID
		SetSliderDialogStartValue(aaaKNNIsLimitDamageThirstyMag.GetValue())
		SetSliderDialogDefaultValue(1.00)
		SetSliderDialogRange(0.01, 5.00)
		SetSliderDialogInterval(0.01)
	elseIf option == NeedTundraCottnOID
		SetSliderDialogStartValue(aaaKNNNeedTundraCotton.GetValue())
		SetSliderDialogDefaultValue(3.00)
		SetSliderDialogRange(0.0, 50.0)
		SetSliderDialogInterval(1.0)
	elseIf option == DieOID
		SetSliderDialogStartValue(aaaKNNIsEnableDie.GetValue())
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 5.0)
		SetSliderDialogInterval(1.0)
	elseIf option == WidgetPosXOID
		SetSliderDialogStartValue(widget.GetWidgetPositionX())
		SetSliderDialogDefaultValue(1225)
		SetSliderDialogRange(0, 1920)
		SetSliderDialogInterval(1)
	elseIf option == WidgetPosYOID
		SetSliderDialogStartValue(widget.GetWidgetPositionY())
		SetSliderDialogDefaultValue(600)
		SetSliderDialogRange(0, 1080)
		SetSliderDialogInterval(1)
	elseIf option == WidgetAlphaOID
		SetSliderDialogStartValue(widget.GetWigetAlpha())
		SetSliderDialogDefaultValue(85)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	elseIf option == WidgetOpPosXOID
		SetSliderDialogStartValue(widget.GetWidgetOptionPositionX())
		SetSliderDialogDefaultValue(1225)
		SetSliderDialogRange(0, 1920)
		SetSliderDialogInterval(1)
	elseIf option == WidgetOpPosYOID
		SetSliderDialogStartValue(widget.GetWidgetOptionPositionY())
		SetSliderDialogDefaultValue(520)
		SetSliderDialogRange(0, 1080)
		SetSliderDialogInterval(1)
	elseIf option == WidgetOpAlphaOID
		SetSliderDialogStartValue(widget.GetWigetOptionAlpha())
		SetSliderDialogDefaultValue(85)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	elseIf option == HTIntervalOID
		SetSliderDialogStartValue(aaaKNNHTInterVal.GetValue())
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 180.0)
		SetSliderDialogInterval(0.1)
	elseIf option == NextHTIntervalOID
		SetSliderDialogStartValue(_KNNNextHTInterval.GetValue())
		SetSliderDialogDefaultValue(3.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1.0)
	elseIf option == HorizontalRangeMaxOID
		SetSliderDialogStartValue(aaaKNNEyeHorizonalRangeMax.GetValue())
		SetSliderDialogDefaultValue(180.0)
		SetSliderDialogRange(aaaKNNEyeHorizonalRangeMin.GetValue() + 1.0, 180.0)
		SetSliderDialogInterval(1.0)
	elseIf option == HorizontalRangeMinOID
		SetSliderDialogStartValue(aaaKNNEyeHorizonalRangeMin.GetValue())
		SetSliderDialogDefaultValue(40.0)
		SetSliderDialogRange(0.0, aaaKNNEyeHorizonalRangeMax.GetValue() - 1.0)
		SetSliderDialogInterval(1.0)
	elseIf option == HorizontalPowerMaxOID
		SetSliderDialogStartValue(aaaKNNEyeHorizonalPowerMax.GetValue())
		SetSliderDialogDefaultValue(80.0)
		SetSliderDialogRange(aaaKNNEyeHorizonalPowerMin.GetValue() + 1.0, 100.0)
		SetSliderDialogInterval(1.0)
	elseIf option == HorizontalPowerMinOID
		SetSliderDialogStartValue(aaaKNNEyeHorizonalPowerMin.GetValue())
		SetSliderDialogDefaultValue(15.0)
		SetSliderDialogRange(0.0, aaaKNNEyeHorizonalPowerMax.GetValue() - 1.0)
		SetSliderDialogInterval(1.0)
	elseIf option == VerticalRangeMaxOID
		SetSliderDialogStartValue(aaaKNNEyeVerticalRangeMax.GetValue())
		SetSliderDialogDefaultValue(30.0)
		SetSliderDialogRange(aaaKNNEyeVerticalRangeMin.GetValue() + 1.0, 180.0)
		SetSliderDialogInterval(1.0)
	elseIf option == VerticalRangeMinOID
		SetSliderDialogStartValue(aaaKNNEyeVerticalRangeMin.GetValue())
		SetSliderDialogDefaultValue(7.0)
		SetSliderDialogRange(0.0, aaaKNNEyeVerticalRangeMax.GetValue() - 1.0)
		SetSliderDialogInterval(1.0)
	elseIf option == VerticalPowerMaxOID
		SetSliderDialogStartValue(aaaKNNEyeVerticalPowerMax.GetValue())
		SetSliderDialogDefaultValue(35.0)
		SetSliderDialogRange(aaaKNNEyeVerticalPowerMin.GetValue() + 1.0, 100.0)
		SetSliderDialogInterval(1.0)
	elseIf option == VerticalPowerMinOID
		SetSliderDialogStartValue(aaaKNNEyeVerticalPowerMin.GetValue())
		SetSliderDialogDefaultValue(3.0)
		SetSliderDialogRange(0.0, aaaKNNEyeVerticalPowerMax.GetValue() - 1.0)
		SetSliderDialogInterval(1.0)
	else
		int i = 0
		while i < HTExValBasicOID.Length
			if option == HTExValBasicOID[i]
				SetSliderDialogStartValue((HTExValBasicGv.GetAt(i) as GlobalVariable).GetValue())
				SetSliderDialogDefaultValue(100)
				SetSliderDialogRange(0, 100)
				SetSliderDialogInterval(1)
				return
			endIf
			i += 1
		endwhile

		i = 0
		while i < HTExValActorsOID.Length
			if option == HTExValActorsOID[i]
				SetSliderDialogStartValue((HTExValActorGV.GetAt(i) as GlobalVariable).GetValue())
				SetSliderDialogDefaultValue(HTExValActorDefault[i])
				SetSliderDialogRange(0, 100)
				SetSliderDialogInterval(1)
				return
			endIf
			i += 1			
		endwhile

		i = 0
		while i < HTExValFormsOID.Length
			if option == HTExValFormsOID[i]
				SetSliderDialogStartValue((HTExValFormGV.GetAt(i) as GlobalVariable).GetValue())
				SetSliderDialogDefaultValue(HTExValFormDefault[i])
				SetSliderDialogRange(0, 100)
				SetSliderDialogInterval(1)
				return
			endIf
			i += 1
		endwhile
	endIf
EndEvent

Event OnOptionSliderAccept(int option, float value)
	if option == FoodsTimeOID
		SetSliderOptionValue(FoodsTimeOID, value, "${0} timesPerDays")
		_KNNFoodsTimePerDay.SetValue(value)
	elseIf option == DrinksTimeOID
		SetSliderOptionValue(DrinksTimeOID, value, "${0} timesPerDays")
		_KNNDrinksTimePerDay.SetValue(value)
	elseIf  option == intHungryOID
		SetSliderOptionValue(intHungryOID, value, "{2}")
		aaaKNNIntensityHungry.SetValue(value)		
	elseIf option == intThirstyOID
		SetSliderOptionValue(intThirstyOID, value, "{2}")
		aaaKNNIntensityThirsty.SetValue(value)		
	elseIf option == intSleepOID
		SetSliderOptionValue(intSleepOID, value, "{2}")
		aaaKNNIntensitySleep.SetValue(value)		
	elseIf option == intDrunkOID
		SetSliderOptionValue(intDrunkOID, value, "{2}")
		aaaKNNIntensityDrunk.SetValue(value)		
	elseIf option == intBodyOID
		SetSliderOptionValue(intBodyOID, value, "{2}")
		aaaKNNIntensityBody.SetValue(value)
	elseIf option == magHungryOID
		SetSliderOptionValue(magHungryOID, value, "{2}")
		aaaKNNDamageMagnitudeHungry.SetValue(value)
	elseIf option == magThirstyOID
		SetSliderOptionValue(magThirstyOID, value, "{2}")
		aaaKNNDamageMagnitudeThirsty.SetValue(value)
	elseIf option == shortSleeperOID
		SetSliderOptionValue(shortSleeperOID, value, "{2}")
		aaaKNNShortSleeper.SetValue(value)
	elseIf option == intervalBodyOID
		SetSliderOptionValue(intervalBodyOID, value, "${0} Days")
		aaaKNNWashBodyInterval.SetValue(value)
	elseIf option == damageHungryLimitValOID
		SetSliderOptionValue(damageHungryLimitValOID, value, "{0}")
		aaaKNNIsLimitDamageHungryValue.SetValue(value)
	elseIf option == damageHungryLimitMagOID
		SetSliderOptionValue(damageHungryLimitMagOID, value, "{2}")
		aaaKNNIsLimitDamageHungryMag.SetValue(value)
	elseIf option == damageThirstyLimitValOID
		SetSliderOptionValue(damageThirstyLimitValOID, value, "{0}")
		aaaKNNIsLimitDamageThirstyValue.SetValue(value)
	elseIf option == damageThirstyLimitMagOID
		SetSliderOptionValue(damageThirstyLimitMagOID, value, "{2}")
		aaaKNNIsLimitDamageThirstyMag.SetValue(value)
	elseIf option == NeedTundraCottnOID
		SetSliderOptionValue(NeedTundraCottnOID, value, "{0}")
		aaaKNNNeedTundraCotton.SetValue(value)
	elseIf option == DieOID
		SetSliderOptionValue(DieOID, value, "${0} Days")
		aaaKNNIsEnableDie.SetValue(value)
	elseIf option == WidgetPosXOID
		widget.SetWidgetPositionX(value)
		SetSliderOptionValue(WidgetPosXOID, value, "{0}")
	elseIf option == WidgetPosYOID
		widget.SetWidgetPositionY(value)
		SetSliderOptionValue(WidgetPosYOID, value, "{0}")
	elseIf option == WidgetAlphaOID
		widget.SetWidgetAlpha(value)
		SetSliderOptionValue(WidgetAlphaOID, value, "{0}")
	elseIf option == WidgetOpPosXOID
		widget.SetWidgetOptionPositionX(value)
		SetSliderOptionValue(WidgetOpPosXOID, value, "{0}")
	elseIf option == WidgetOpPosYOID
		widget.SetWidgetOptionPositionY(value)
		SetSliderOptionValue(WidgetOpPosYOID, value, "{0}")
	elseIf option == WidgetOpAlphaOID
		widget.SetWidgetOptionAlpha(value)
		SetSliderOptionValue(WidgetOpAlphaOID, value, "{0}")
	elseIf option == HTInterValOID
		SetSliderOptionValue(HTInterValOID, value,"{1} Second")
		aaaKNNHTInterVal.SetValue(value)
		;(KNNHTQuest as aaaKNNHTQuest).UpdateValue()
	elseIf option == NextHTIntervalOID
		SetSliderOptionValue(NextHTIntervalOID, value,"{0} Milliseconds")
		_KNNNextHTInterval.SetValue(value)
	elseIf option == HorizontalRangeMaxOID
		SetSliderOptionValue(HorizontalRangeMaxOID, value, "${0} Degree")
		aaaKNNEyeHorizonalRangeMax.SetValue(value)
	elseIf option == HorizontalRangeMinOID
		SetSliderOptionValue(HorizontalRangeMinOID, value, "${0} Degree")
		aaaKNNEyeHorizonalRangeMin.SetValue(value)
	elseIf option == HorizontalPowerMaxOID
		SetSliderOptionValue(HorizontalPowerMaxOID, value, "{0}")
		aaaKNNEyeHorizonalPowerMax.SetValue(value)
	elseIf option == HorizontalPowerMinOID
		SetSliderOptionValue(HorizontalPowerMinOID, value, "{0}")
		aaaKNNEyeHorizonalPowerMin.SetValue(value)		
	elseIf option == VerticalRangeMaxOID
		SetSliderOptionValue(VerticalRangeMaxOID, value, "${0} Degree")
		aaaKNNEyeVerticalRangeMax.SetValue(value)
	elseIf option == VerticalRangeMinOID
		SetSliderOptionValue(VerticalRangeMinOID, value, "${0} Degree")
		aaaKNNEyeVerticalRangeMin.SetValue(value)
	elseIf option == VerticalPowerMaxOID
		SetSliderOptionValue(VerticalPowerMaxOID, value, "{0}")
		aaaKNNEyeVerticalPowerMax.SetValue(value)
	elseIf option == VerticalPowerMinOID
		SetSliderOptionValue(VerticalPowerMinOID, value, "{0}")
		aaaKNNEyeVerticalPowerMin.SetValue(value)
	else
		int i = 0
		while i < HTExValBasicOID.Length
			if option == HTExValBasicOID[i]
				SetSliderOptionValue(HTExValBasicOID[i], value, "{0}")
				(HTExValBasicGv.GetAt(i) as GlobalVariable).SetValue(value)
				return
			endIf
			i += 1
		endwhile
		i = 0
		while i < HTExValActorsOID.Length
			if option == HTExValActorsOID[i]
				SetSliderOptionValue(HTExValActorsOID[i], value, "{0}")
				(HTExValActorGV.GetAt(i) as GlobalVariable).SetValue(value)
				return
			endIf
			i += 1			
		endwhile
		i = 0
		while i < HTExValFormsOID.Length
			if option == HTExValFormsOID[i]
				SetSliderOptionValue(HTExValFormsOID[i], value, "{0}")
				(HTExValFormGV.GetAt(i) as GlobalVariable).SetValueInt(value as int)
				return
			endIf
			i += 1
		endwhile
	endIf
EndEvent

Event OnOptionSelect(int option)
	if option == BNOID
		int index = 1 + aaaKNNIsBasicNeedsEnable.GetValueInt()
		if index < 0 || index > 1
			index = 0
		endIf
		SetTextOptionValue(BNOID, GetFunctionState(index))
		aaaKNNIsBasicNeedsEnable.SetValueInt(index)
		if index == 0
			SetOptionFlags(HungryOID, OPTION_FLAG_DISABLED)
			SetOptionFlags(ThirstyOID, OPTION_FLAG_DISABLED)
			SetOptionFlags(SleepOID, OPTION_FLAG_DISABLED)
			SetOptionFlags(BodyOID, OPTION_FLAG_DISABLED)
			SetOptionFlags(DrunkOID, OPTION_FLAG_DISABLED)

			SetOptionFlags(DirtyBodyOID, OPTION_FLAG_DISABLED)
			SetOptionFlags(HungryGrowlOID, OPTION_FLAG_DISABLED)
			;if aaaKNNIsEnableExpression.GetValueInt() != 0
			;	SetTextOptionValue(ExpressionOID, GetExpressionState(0))
			;	aaaKNNIsEnableExpression.SetValueInt(0)
			;endIf
			;SetOptionFlags(ExpressionOID, 1)
			SetOptionFlags(intervalBodyOID, OPTION_FLAG_DISABLED)
			SetOptionFlags(SellBottleOID, OPTION_FLAG_DISABLED)
			SetOptionFlags(SellTowelPotionOID, OPTION_FLAG_DISABLED)
			SetOptionFlags(WaterBarrelOID, OPTION_FLAG_DISABLED)
			if 0 != aaaKNNIsEnabledSellTowel.GetValueInt() || 0 != aaaKNNIsEnableSellWaterBottle.GetValueInt() || 0 != _KNNIsEnableWaterBarrelFeature.GetValueInt()
				GoToState("READY")
			endIf			
			SetOptionFlags(convertEmptyBottleOID, OPTION_FLAG_DISABLED)
			SetOptionFlags(DieOID, OPTION_FLAG_DISABLED)

			if aaaKNNHotkeyHipBag.GetValueInt() > 0
				aaaKNNHotkeyHipBag.SetValueInt(0)
			endIf
			if aaaKNNHotkeyJurnal.GetValueInt() > 0
				GoToState("READY")
				aaaKNNHotkeyJurnal.SetValueInt(0)
			endIf
			if aaaKNNIsEnableWidget.GetValueInt() !=0
				aaaKNNIsEnableWidget.SetValueInt(0)
				widget.SetKNNWidget(false)
			endIf
			if aaaKNNIsEnableWidgetOp.GetValueInt() !=0
				aaaKNNIsEnableWidgetOp.SetValueInt(0)
				widget.SetKNNWidgetOption(false)
			endIf
			if aaaKNNHotkeyWidget.GetValueInt() > 0
				aaaKNNHotkeyWidget.SetValueInt(0)
			endIf
			if aaaKNNIsEnableQuickLootAnim.GetValueInt() != 0
				aaaKNNHotkeyWidget.SetValueInt(0)
			endIf
			if aaaKNNIsEnableSellWaterBottle.GetValueInt() != 0
				aaaKNNIsEnableSellWaterBottle.SetValueInt(0)
			endIf
			if aaaKNNIsConvertEmptyBottle.GetValueInt() != 0
				aaaKNNIsConvertEmptyBottle.SetValueInt(0)
			endIf
			if -1 != aaaKNNHotkeyIdleAnim.GetValueInt()
				aaaKNNHotkeyIdleAnim.SetValueInt(-1)
			endIf
			if -1 != aaaKNNHotkeyHipBag.GetValueInt()
				aaaKNNHotkeyHipBag.SetValueInt(-1)
			endIf
			RemoveAbility(ABILITY_ALL)			
		else
			SetOptionFlags(HungryOID, OPTION_FLAG_NONE)
			SetOptionFlags(ThirstyOID, OPTION_FLAG_NONE)
			SetOptionFlags(SleepOID, OPTION_FLAG_NONE)
			SetOptionFlags(BodyOID, OPTION_FLAG_NONE)
			SetOptionFlags(DrunkOID, OPTION_FLAG_NONE)

			SetOptionFlags(intervalBodyOID, OPTION_FLAG_NONE)
			SetOptionFlags(DirtyBodyOID, OPTION_FLAG_NONE)
			SetOptionFlags(HungryGrowlOID, OPTION_FLAG_NONE)
			;SetOptionFlags(ExpressionOID, OPTION_FLAG_NONE)
			SetOptionFlags(SellBottleOID, OPTION_FLAG_NONE)
			SetOptionFlags(SellTowelPotionOID, OPTION_FLAG_NONE)
			SetOptionFlags(WaterBarrelOID, OPTION_FLAG_NONE)
			if 0 != aaaKNNIsEnabledSellTowel.GetValueInt() || 0 != aaaKNNIsEnableSellWaterBottle.GetValueInt() || 0 != _KNNIsEnableWaterBarrelFeature.GetValueInt()
				GoToState("READY")
			endIf
			SetOptionFlags(convertEmptyBottleOID, OPTION_FLAG_NONE)

			SetOptionFlags(DieOID, OPTION_FLAG_NONE)

			if aaaKNNIsEnableHungry.GetValueInt() == 1
				SetOptionFlags(IsLimitDamageHungryOID, OPTION_FLAG_NONE)
			endIf
			if aaaKNNIsLimitDamageHungry.GetValueInt() == 1 && aaaKNNIsEnableHungry.GetValueInt() == 1
				SetOptionFlags(damageHungryLimitValOID, OPTION_FLAG_NONE)
			endIf
			if aaaKNNIsLimitDamageHungry.GetValueInt() != 2 && aaaKNNIsEnableHungry.GetValueInt() == 1
				SetOptionFlags(damageHungryLimitMagOID, OPTION_FLAG_NONE)
			endIf
			if aaaKNNIsEnableThirsty.GetValueInt() == 1
				SetOptionFlags(IsLimitDamageThirstyOID, OPTION_FLAG_NONE)
			endIf
			if aaaKNNIsLimitDamageThirsty.GetValueInt() == 1 && aaaKNNIsEnableThirsty.GetValueInt() == 1
				SetOptionFlags(damageThirstyLimitValOID, OPTION_FLAG_NONE)
			endIf
			if aaaKNNIsLimitDamageThirsty.GetValueInt() != 2 && aaaKNNIsEnableThirsty.GetValueInt() == 1
				SetOptionFlags(damageThirstyLimitMagOID, OPTION_FLAG_NONE)
			endIf
		endIf
	elseIf option == HungryOID
		int index = 1 + aaaKNNIsEnableHungry.GetValueInt()
		if index < 0 || index > 1
			index = 0
		endIf
		if index == 0
			if aaaKNNIsEnableThirsty.GetValueInt() == 0 && aaaKNNIsEnableSleepiness.GetValueInt() == 0
				;SetTextOptionValue(ExpressionOID, GetExpressionState(index))
				;aaaKNNIsEnableExpression.SetValueInt(index)
				;SetOptionFlags(ExpressionOID, 1)
				SetOptionFlags(DieOID, 1)
			endIf
			if !IsEnableGrowl(HungryOID)
				SetOptionFlags(HungryGrowlOID, 1)
			endIf
			RemoveAbility(ABILITY_HUNGRY)
		else
			;SetOptionFlags(ExpressionOID, 0)
			SetOptionFlags(HungryGrowlOID, 0)
			SetOptionFlags(DieOID, 0)
		endIf
		SetTextOptionValue(HungryOID, GetFunctionState(index))
		aaaKNNIsEnableHungry.SetValueInt(index)	
	elseIf option == ThirstyOID
		int index = 1 + aaaKNNIsEnableThirsty.GetValueInt()
		if index < 0 || index > 1
			index = 0
		endIf
		if index == 0
			if aaaKNNIsEnableHungry.GetValueInt() == 0 && aaaKNNIsEnableSleepiness.GetValueInt() == 0
				;SetTextOptionValue(ExpressionOID, GetExpressionState(index))
				;aaaKNNIsEnableExpression.SetValueInt(index)
				;SetOptionFlags(ExpressionOID, 1)
				SetOptionFlags(DieOID, 1)
			endIf
			if !IsEnableGrowl(ThirstyOID)
				SetOptionFlags(HungryGrowlOID, 1)
			endIf
			RemoveAbility(ABILITY_THIRSTY)
		else
			;SetOptionFlags(ExpressionOID, 0)
			SetOptionFlags(HungryGrowlOID, 0)
			SetOptionFlags(DieOID, 0)
		endIf
		SetTextOptionValue(ThirstyOID, GetFunctionState(index))
		aaaKNNIsEnableThirsty.SetValueInt(index)		
	elseIf option == SleepOID
		int index = 1 + aaaKNNIsEnableSleepiness.GetValueInt()
		if index < 0 || index > 1
			index = 0
		endIf
		if index == 0		
			if aaaKNNIsEnableHungry.GetValueInt() == 0 && aaaKNNIsEnableThirsty.GetValueInt() == 0
				;SetTextOptionValue(ExpressionOID, GetExpressionState(index))
				;aaaKNNIsEnableExpression.SetValueInt(index)
				;SetOptionFlags(ExpressionOID, 1)
				SetOptionFlags(DieOID, 1)
			endIf
			if !IsEnableGrowl(SleepOID)
				SetOptionFlags(HungryGrowlOID, 1)
			endIf
			RemoveAbility(ABILITY_SLEEPY)
		else
			;SetOptionFlags(ExpressionOID, 0)
			SetOptionFlags(HungryGrowlOID, 0)
			SetOptionFlags(DieOID, 0)
		endIf
		SetTextOptionValue(SleepOID, GetFunctionState(index))
		aaaKNNIsEnableSleepiness.SetValueInt(index)		
	elseIf option == BodyOID
		int index = 1 + aaaKNNIsEnableBodyHealth.GetValueInt()
		if index < 0 || index > 1
			index = 0
		endIf
		if index == 0
			SetOptionFlags(DirtyBodyOID, 1)
			SetOptionFlags(intervalBodyOID, 1)
			if !IsEnableGrowl(BodyOID)
				SetOptionFlags(HungryGrowlOID, 1)
			endIf
			RemoveAbility(ABILITY_BODY)
		else
			SetOptionFlags(DirtyBodyOID, 0)
			SetOptionFlags(intervalBodyOID, 0)
			SetOptionFlags(HungryGrowlOID, 0)
		endIf
		SetTextOptionValue(BodyOID, GetFunctionState(index))
		aaaKNNIsEnableBodyHealth.SetValueInt(index)
	elseIf option == DrunkOID
		int index = 1 + aaaKNNIsEnableDrunkness.GetValueInt()
		if index < 0 || index > 1
			index = 0
		endIf
		if index == 0
			RemoveAbility(ABILITY_DRUNK)
		endIf
		SetTextOptionValue(DrunkOID, GetFunctionState(index))
		aaaKNNIsEnableDrunkness.SetValueInt(index)
	elseIf option == ResetHungryValueOID
		SetToggleOptionValue(ResetHungryValueOID, true)
		KNNPlugin_Utility.SetBasicNeeds("hungry", 2880.0)
		ShowMessage("$ResetBasicNeedsValues", false)
		SetToggleOptionValue(ResetHungryValueOID, false)

		SetTextOptionValue(CurrentHungryOID, KNNPlugin_Utility.GetBasicNeeds("hungry"))
	elseIf option == ResetThirstyValueOID
		SetToggleOptionValue(ResetThirstyValueOID, true)
		KNNPlugin_Utility.SetBasicNeeds("thirsty", 2880.0)
		ShowMessage("$ResetBasicNeedsValues", false)
		SetToggleOptionValue(ResetThirstyValueOID, false)

		SetTextOptionValue(CurrentThirstyOID, KNNPlugin_Utility.GetBasicNeeds("thirsty"))
	elseIf option == ResetSleepyValueOID
		SetToggleOptionValue(ResetSleepyValueOID, true)
		KNNPlugin_Utility.SetBasicNeeds("sleepiness", 1680.0)
		ShowMessage("$ResetBasicNeedsValues", false)
		SetToggleOptionValue(ResetSleepyValueOID, false)

		SetTextOptionValue(CurrentSleepyOID, KNNPlugin_Utility.GetBasicNeeds("Sleepiness"))
	elseIf option == ResetBodyValueOID
		SetToggleOptionValue(ResetBodyValueOID, true)
		KNNPlugin_Utility.SetBasicNeeds("bodyhealth", 0.0)
		ShowMessage("$ResetBasicNeedsValues", false)
		SetToggleOptionValue(ResetBodyValueOID, false)

		SetTextOptionValue(CurrentBodyOID, KNNPlugin_Utility.GetBasicNeeds("Bodyhealth"))
	elseIf option == ResetDrunkValueOID
		SetToggleOptionValue(ResetDrunkValueOID, true)
		KNNPlugin_Utility.SetBasicNeeds("drunkness", 0.0)
		ShowMessage("$ResetBasicNeedsValues", false)
		SetToggleOptionValue(ResetDrunkValueOID, false)

		SetTextOptionValue(CurrentDrunkOID, KNNPlugin_Utility.GetBasicNeeds("Drunkness"))
	elseIf option == DirtyBodyOID
		int index = 1 + aaaKNNIsEnableDirtyBodyEffect.GetValueInt()
		if index < 0 || index > 1
			index = 0
			if 0 != aaaKNNIsEnableFollowerDirtyBodyEffect.GetValueInt()
				aaaKNNIsEnableFollowerDirtyBodyEffect.SetValueInt(index)
			endIf
		endIf
		SetTextOptionValue(DirtyBodyOID, GetFunctionState(index))
		aaaKNNIsEnableDirtyBodyEffect.SetValueInt(index)
		RemoveAbility(ABILITY_BODY)
	elseif option == HungryGrowlOID
		int index = 1 + aaaKNNIsEnableHungryGrowl.GetValueInt()
		if index < 0 || index > 1
			index = 0
		endIf
		SetTextOptionValue(HungryGrowlOID, GetFunctionState(index))
		aaaKNNIsEnableHungryGrowl.SetValueInt(index)
	elseif option == ExpressionOID
		int index = 1 + aaaKNNIsEnableExpression.GetValueInt()
		if 0 > index || 2 < index
			index = 0
		endIf
		SetTextOptionValue(ExpressionOID, GetExpressionState(index))
		aaaKNNIsEnableExpression.SetValueInt(index)
	elseIf option == GetBookOID
		SetToggleOptionValue(GetBookOID, true)
		if 0 == Game.GetPlayer().GetItemCount(_BookOfKNNSurvival)
			Game.GetPlayer().AddItem(_BookOfKNNSurvival, 1)
		endIf
		SetToggleOptionValue(GetBookOID, false)
	elseIf option == ResolveModBedOID
		SetToggleOptionValue(ResolveModBedOID, true)
		int numOfModBed = KNNPlugin_Utility.ResolveModBed()
		if !numOfModBed
			ShowMessage("$NotFoundModBed", false)
		else
			ShowMessage("$NumOfMODBedsFound", false)
		endIf
		SetToggleOptionValue(ResolveModBedOID, false)
	elseIf option == IsLimitDamageHungryOID
		int index = 1 + aaaKNNIsLimitDamageHungry.GetValueInt()
		if index < 0 || index > 2
			index = 0
		endIf
		if index == 0
			SetOptionFlags(damageHungryLimitValOID, 1)
			SetOptionFlags(damageHungryLimitMagOID, 0)
		elseIf index == 1
			SetOptionFlags(damageHungryLimitValOID, 0)
			SetOptionFlags(damageHungryLimitMagOID, 0)
		else
			SetOptionFlags(damageHungryLimitValOID, 1)
			SetOptionFlags(damageHungryLimitMagOID, 1)
		endIf
		SetTextOptionValue(IsLimitDamageHungryOID, GetDamageBasicneedState(index))
		aaaKNNIsLimitDamageHungry.SetValueInt(index)
	elseIf option == IsLimitDamageThirstyOID
		int index = 1 + aaaKNNIsLimitDamageThirsty.GetValueInt()
		if index < 0 || index > 2
			index = 0
		endIf
		if index == 0
			SetOptionFlags(damageThirstyLimitValOID, 1)
			SetOptionFlags(damageThirstyLimitMagOID, 0)
		elseIf index == 1
			SetOptionFlags(damageThirstyLimitValOID, 0)
			SetOptionFlags(damageThirstyLimitMagOID, 0)
		else
			SetOptionFlags(damageThirstyLimitValOID, 1)
			SetOptionFlags(damageThirstyLimitMagOID, 1)
		endIf
		SetTextOptionValue(IsLimitDamageThirstyOID, GetDamageBasicneedState(index))
		aaaKNNIsLimitDamageThirsty.SetValueInt(index)
	elseIf option == KNNCurrentStutasOID
		SetToggleOptionValue(KNNCurrentStutasOID, true)
		if KNNPlugin_Utility.ShowKNNBasicNeedsStutas()
			ShowMessage("$SucceedToOutPutKNNLog", false)
		else
			ShowMessage("$FailedToOutPutKNNLog", false)
		endIf
		SetToggleOptionValue(KNNCurrentStutasOID, false)
	elseIf option == WaterBarrelLocationsOID
		if WaterBarrelQuest.IsRunning()
			_KNNWaterBarrelQuest wbq = WaterBarrelQuest as _KNNWaterBarrelQuest
			if wbq
				wbq.DisplayedAllBarrelLocations()
				SetToggleOptionValue(WaterBarrelLocationsOID, wbq.IsLocationDisplayed)
			endIf
		endIf
	elseIf option == HardOID
		int index = 1 + aaaKNNIsEnableBasicNeedsHard.GetValueInt()
		if index < 0 || index > 2
			index = 0
		endIf
		if index == 0
			RemoveAbility(ABILITY_HARD)
			RemoveAbility(ABILITY_LEGENDARY)
		elseIf index == 1
			if !Game.GetPlayer().HasSpell(aaaKNNBasicNeedsHardStaminaSpell)
				Game.GetPlayer().AddSpell(aaaKNNBasicNeedsHardStaminaSpell, false)
			endIf
			RemoveAbility(ABILITY_LEGENDARY)
		elseIf index == 2			
			if !Game.GetPlayer().HasSpell(aaaKNNBasicNeedsHardStaminaSpell)
				Game.GetPlayer().AddSpell(aaaKNNBasicNeedsHardStaminaSpell, false)
			endIf
			if !Game.GetPlayer().HasSpell(aaaKNNBasicNeedsLegendaryStaminaSpell)
				Game.GetPlayer().AddSpell(aaaKNNBasicNeedsLegendaryStaminaSpell, false)
			endIf
			RemoveAbility(ABILITY_SLEEPY)
		endIf
		SetTextOptionValue(HardOID, GetStaminaPenaltyState(index))
		aaaKNNIsEnableBasicNeedsHard.SetValueInt(index)
	elseIf option == PCGenderOID
		int index = (0 == aaaKNNIsPCGenderFemale.GetValueInt()) as int
		SetTextOptionValue(PCGenderOID, GetPCGender(index))
		aaaKNNIsPCGenderFemale.SetValueInt(index)
	elseIf option == CurrentCharacterSlotOID
		CurrentCharacter += 1
		if 0 > CurrentCharacter || 3 < CurrentCharacter
			CurrentCharacter = 0
		endIf
		SetTextOptionValue(CurrentCharacterSlotOID, GetCurrentSlots(CurrentCharacter))
		ForcePageReset()
	elseIf option == IsPOVOID
		int index = 1 + aaaKNNIsEnablePOV.GetValueInt()
		if index < 0 || index > 1
			index = 0
		endIf
		SetTextOptionValue(IsPOVOID, GetFunctionState(index))
		aaaKNNIsEnablePOV.SetValueInt(index)
	elseIf option == IsShieldUnequipOID
		int index = 1 + aaaKNNIsShieldUnequip.GetValueInt()
		if index < 0 || index > 2
			index = 0
		endIf
		SetTextOptionValue(IsShieldUnequipOID, GetShieldCtrl(index))
		aaaKNNIsShieldUnequip.SetValueInt(index)
	elseIf option == IsCameraAnimatedOID
		int index = 1 + aaaKNNIsEnableCameraAnimated.GetValueInt()
		if index < 0 || index > 1
			index = 0
		endIf
		SetTextOptionValue(IsCameraAnimatedOID, GetFunctionState(index))
		aaaKNNIsEnableCameraAnimated.SetValueInt(index)
	elseIf option == IsActiAmiQLOID
		int index = 1 + aaaKNNIsEnableQuickLootAnim.GetValueInt()
		if index < 0 || index > 1
			index = 0
		endIf
		if index == 1
			RemoveActivateAnimPerk()
			if QLAnimsOID.Length > 0
				int OIDIndex = 0
				while OIDIndex < QLAnimsOID.Length
					SetOptionFlags(QLAnimsOID[OIDIndex], 0)
					OIDIndex += 1
				endWhile
			endIf
		elseIf index == 0
			if QLAnimsOID.Length > 0
				int OIDIndex = 0
				while OIDIndex < QLAnimsOID.Length
					SetOptionFlags(QLAnimsOID[OIDIndex], 1)
					OIDIndex += 1
				endWhile
			endIf
		endIf
		SetTextOptionValue(IsActiAmiQLOID, GetFunctionState(index))
		aaaKNNIsEnableQuickLootAnim.SetValueInt(index)
	elseIf option == MsgOID
		int index = 1 + aaaKNNIsEnableMessage.GetValueInt()
		if index < 0 || index > 1
			index = 0
		endIf
		SetTextOptionValue(MsgOID, GetFunctionState(index))
		aaaKNNIsEnableMessage.SetValueInt(index)
		(BasicNeedsQuest as aaaKNNBasicNeedsQuest).InIt()		
	elseIf option == QuiverOID
		int index = 1 + aaaKNNIsEnableQuiver.GetValueInt()
		if index < 0 || index > 1
			index = 0
		endIf
		SetTextOptionValue(QuiverOID, GetFunctionState(index))
		aaaKNNIsEnableQuiver.SetValueInt(index)		
	elseIf option == UseInkPenOID
		int index = 1 + aaaKNNIsEnableUseInkPen.GetValueInt()
		if index < 0 || index > 1
			index = 0
		endIf
		SetTextOptionValue(UseInkPenOID, GetFunctionState(index))
		aaaKNNIsEnableUseInkPen.SetValueInt(index)
	elseIf option == StumbleOID
		int index = 1 + aaaKNNIsEnableStumble.GetValueInt()
		if index < 0 || index > 1
			index = 0
		endIf
		SetTextOptionValue(StumbleOID, GetFunctionState(index))
		aaaKNNIsEnableStumble.SetValueInt(index)
	elseIf option == SellBottleOID
		GoToState("READY")
		int index = 1 + aaaKNNIsEnableSellWaterBottle.GetValueInt()
		if index < 0 || index > 1
			index = 0
		endIf
		SetTextOptionValue(SellBottleOID, GetFunctionState(index))
		aaaKNNIsEnableSellWaterBottle.SetValueInt(index)
	elseIf option == SellTowelPotionOID
		GoToState("READY")
		int index = 1 + aaaKNNIsEnabledSellTowel.GetValueInt()
		if index < 0 || index > 1
			index = 0
		endIf
		SetTextOptionValue(SellTowelPotionOID, GetFunctionState(index))
		aaaKNNIsEnabledSellTowel.SetValueInt(index)
	elseIf option == WaterBarrelOID
		GoToState("READY")
		int index = 1 + _KNNIsEnableWaterBarrelFeature.GetValueInt()
		if index < 0 || index > 1
			index = 0
		endIf
		SetTextOptionValue(WaterBarrelOID, GetFunctionState(index))
		_KNNIsEnableWaterBarrelFeature.SetValueInt(index)
	elseIf option == convertEmptyBottleOID
		int index = 1 + aaaKNNIsConvertEmptyBottle.GetValueInt()
		if index < 0 || index > 1
			index = 0
		endIf
		SetTextOptionValue(convertEmptyBottleOID, GetFunctionState(index))
		aaaKNNIsConvertEmptyBottle.SetValueInt(index)
	elseIf option == PRIORITYDRINKSTYPEOID
		int index = 1 + aaaKNNPotionUseagePriorityWater.GetValueInt()
		if index < 0 || index > 2
			index = 0
		endIf
		SetTextOptionValue(PRIORITYDRINKSTYPEOID, GetPotionDrinkTypeState(index))
		aaaKNNPotionUseagePriorityWater.SetValueInt(index)
	elseIf option == PUFOODOID || option == PUDRINKOID
		int[] OID = new int[2]
		OID[0] = PUFOODOID
		OID[1] = PUDRINKOID
		GlobalVariable[] VAL = new GlobalVariable[2]
		VAL[0] = aaaKNNPotionUseageEffectFoods
		VAL[1] = aaaKNNPotionUseageEffectDrinks
		int id = 0
		while id < OID.Length
			if option == OID[id]
				int index = 1 + VAL[id].GetValueInt()
				if id == 0
					if index < 0 || index > 2
						index = 0
					endIf
					if index == 2
						SetOptionFlags(PRIORITYFOODOID, 1)
					else
						SetOptionFlags(PRIORITYFOODOID, 0)
					endIf
					SetTextOptionValue(OID[id], GetFoodEffectState(index))
				else
					if index < 0 || index > 4
						index = 0
					endIf
					SetTextOptionValue(OID[id], GetDrinkEffectState(index))
				endIf				
				VAL[id].SetValueInt(index)
			endIf
			id += 1
		endWhile
	elseIf option == PUCUSTOMOID		
		int index = 1 + aaaKNNPotionUseageEffectCustom.GetValueInt()
		if index < 0 || index > 1
			index = 0
		endIf
		SetTextOptionValue(PUCUSTOMOID, GetPotionEffectState(index))
		aaaKNNPotionUseageEffectCustom.SetValueInt(index)			
	elseIf option == PRIORITYFOODOID || option == PRIORITYDRINKOID
		int[] OID = new int[2]
		OID[0] = PRIORITYFOODOID
		OID[1] = PRIORITYDRINKOID
		GlobalVariable[] VAL = new GlobalVariable[2]
		VAL[0] = aaaKNNPotionUseagePriorityFoods
		VAL[1] = aaaKNNPotionUseagePriorityDrinks
		int id = 0
		while id < OID.Length
			if option == OID[id]
				int index = 1 + VAL[id].GetValueInt()
				if index < 0 || index > 2
					index = 0
				endIf
				SetTextOptionValue(OID[id], GetPotionPriorityState(index))
				VAL[id].SetValueInt(index)
			endIf
			id += 1
		endWhile	
	elseIf option == WidgetOID
		int index = 1 + aaaKNNIsEnableWidget.GetValueInt()
		if index < 0 || index > 1
			index = 0
		endIf
		widget.SetKNNWidget(0 != index)
		SetTextOptionValue(WidgetOID, GetFunctionState(index))
		aaaKNNIsEnableWidget.SetValueInt(index)		
	elseIf option == WidgetOpOID
		int index = 1 + aaaKNNIsEnableWidgetOp.GetValueInt()
		if index < 0 || index > 1
			index = 0
		endIf
		widget.SetKNNWidgetOption(0 != index)
		SetTextOptionValue(WidgetOpOID, GetFunctionState(index))
		aaaKNNIsEnableWidgetOp.SetValueInt(index)
	elseIf option == IsHTOID
		bool IsEnable = true
		if 0 != aaaKNNIsHT.GetValueInt()
			IsEnable = false
			(KNNHTQuest as aaaKNNHTQuest).EndHeadTrack()
		else
			KNNPlugin_Utility.SetNoLookObject()
		endIf
		SetToggleOptionValue(IsHTOID, IsEnable)
		aaaKNNIsHT.SetValueInt(IsEnable as int)
		SetOptionFlags(HTPriorityOID, (!IsEnable) as int)
		SetOptionFlags(HTIntervalOID, (!IsEnable) as int)
		SetOptionFlags(IsExpressionChangeExtensionOID, (!IsEnable) as int)
		SetOptionFlags(NextHTIntervalOID, (!IsEnable) as int)
		SetOptionFlags(IsNotHTWeaponDrawnOID, (!IsEnable) as int)
		SetOptionFlags(IsIdleAnimOID, (!IsEnable) as int)
		SetOptionFlags(UpdateNoLookObjOID, (!IsEnable) as int)
	elseIf option == IsExpressionChangeExtensionOID
		bool IsEnable = true
		if 0 != aaaKNNIsExpressionChangeExtension.GetValueInt()
			IsEnable = false
		endIf
		SetToggleOptionValue(IsExpressionChangeExtensionOID, IsEnable)
		aaaKNNIsExpressionChangeExtension.SetValueInt(IsEnable as int)
	elseIf option == IsEyeTrackingOID
	 	int index = 1 + aaaKNNIsHTEnableEyeTracking.GetValueInt()
		if 0> index || 1 < index
			index = 0
		endIf
		SetTextOptionValue(IsEyeTrackingOID, GetFunctionState(index))
		aaaKNNIsHTEnableEyeTracking.SetValueInt(index)
		SetOptionFlags(HorizontalRangeMaxOID, (0 == index) as int)
		SetOptionFlags(HorizontalRangeMinOID, (0 == index) as int)
		SetOptionFlags(HorizontalPowerMaxOID, (0 == index) as int)
		SetOptionFlags(HorizontalPowerMinOID, (0 == index) as int)
		SetOptionFlags(VerticalRangeMaxOID, (0 == index) as int)
		SetOptionFlags(VerticalRangeMinOID, (0 == index) as int)
		SetOptionFlags(VerticalPowerMaxOID, (0 == index) as int)
		SetOptionFlags(VerticalPowerMinOID, (0 == index) as int)
	elseIf option == HTPriorityOID
		int priority = 1 + aaaKNNHTPriority.GetValueInt()
		if 0 > priority || 2 < priority
			priority = 0
		endIf
		aaaKNNHTPriority.SetValueInt(priority)
		;(KNNHTQuest as aaaKNNHTQuest).UpdateValue()
		;(KNNHTQuest as aaaKNNHTQuest).StartHeadTrack()
		SetTextOptionValue(HTPriorityOID, GetHTPriority(priority))
	elseIf option == IsIdleAnimOID
		bool IsEnable = true
		if 0 != aaaKNNIsHTIdleAnim.GetValueInt()
			IsEnable = false
		endIf
		SetToggleOptionValue(IsIdleAnimOID, IsEnable)
		aaaKNNIsHTIdleAnim.SetValueInt(IsEnable as int)
	elseIf option == UpdateNoLookObjOID
		SetToggleOptionValue(UpdateNoLookObjOID, true)
		KNNPlugin_Utility.SetNoLookObject()
		ShowMessage("$ResetBasicNeedsValues", false)
		SetToggleOptionValue(UpdateNoLookObjOID, false)
	elseIf option == UpdateNoLookObjOID
	elseIf option == IsHTActorOID
		bool IsEnable = true
		if 0 != aaaKNNIsHTActor.GetValueInt()
			IsEnable = false
		endIf
		SetToggleOptionValue(IsHTActorOID, IsEnable)
		aaaKNNIsHTActor.SetValueInt(IsEnable as int)
		int i = 0
		while i < HTExActorsOID.Length
			SetOptionFlags(HTExActorsOID[i], (!IsEnable) as int)
			i += 1
		endwhile
		i = 0
		while i < HTExValActorsOID.Length
			SetOptionFlags(HTExValActorsOID[i], (!IsEnable) as int)
			i += 1
		endwhile
		;SetOptionFlags(ExActorPositive00OID, (!IsEnable) as int)
		;SetOptionFlags(ExActorPositive01OID, (!IsEnable) as int)
		;SetOptionFlags(ExActorPositive02OID, (!IsEnable) as int)
		;SetOptionFlags(ExActorPositive03OID, (!IsEnable) as int)
		;SetOptionFlags(ExActorNegative00OID, (!IsEnable) as int)
		;SetOptionFlags(ExActorNegative01OID, (!IsEnable) as int)
		;SetOptionFlags(ExActorNegative02OID, (!IsEnable) as int)
		;SetOptionFlags(ExActorNegative03OID, (!IsEnable) as int)
		;SetOptionFlags(ExPreyAnimalOID, (!IsEnable) as int)

		;SetOptionFlags(ExValueActorPositive00OID, (!IsEnable) as int)
		;SetOptionFlags(ExValueActorPositive01OID, (!IsEnable) as int)
		;SetOptionFlags(ExValueActorPositive02OID, (!IsEnable) as int)
		;SetOptionFlags(ExValueActorPositive03OID, (!IsEnable) as int)
		;SetOptionFlags(ExValueActorNegative00OID, (!IsEnable) as int)
		;SetOptionFlags(ExValueActorNegative01OID, (!IsEnable) as int)
		;SetOptionFlags(ExValueActorNegative02OID, (!IsEnable) as int)
		;SetOptionFlags(ExValueActorNegative03OID, (!IsEnable) as int)
		;SetOptionFlags(ExValuePreyAnimalOID, (!IsEnable) as int)	
	elseIf option == IsNotHTWeaponDrawnOID
		bool IsEnable = true
		if 0 != _KNNHTDisabledWhileWeaponDrawn.GetValueInt()
			IsEnable = false
		endIf
		_KNNHTDisabledWhileWeaponDrawn.SetValueInt(IsEnable as int)
		SetToggleOptionValue(IsNotHTWeaponDrawnOID, IsEnable)
	elseIf option == EnabledExInCombatOID
		bool IsEnable = true
		if 0 != aaaKNNIsEnableExpressionInCombat.GetValueInt()
			IsEnable = false
		endIf
		SetOptionFlags(HTExBasicOID[0], (!IsEnable) as int)
		SetOptionFlags(HTExValBasicOID[0], (!IsEnable) as int)
		SetTextOptionValue(EnabledExInCombatOID, GetFunctionState(IsEnable as int))
		aaaKNNIsEnableExpressionInCombat.SetValueInt(IsEnable as int)	
	elseIf option == SaveMCMSettingsOID
		SetToggleOptionValue(SaveMCMSettingsOID, true)
		float[] widgetInfo = new float[6]
		widgetInfo[0] = widget.GetWidgetPositionX()
		widgetInfo[1] = widget.GetWidgetPositionY()
		widgetInfo[2] = widget.GetWidgetOptionPositionX()
		widgetInfo[3] = widget.GetWidgetOptionPositionY()
		widgetInfo[4] = widget.GetWigetAlpha()
		widgetInfo[5] = widget.GetWigetOptionAlpha()
		bool IsComplate = KNNPlugin_Utility.SaveKNNSettings(widgetInfo)
		SetToggleOptionValue(SaveMCMSettingsOID, false)
		if IsComplate
			ShowMessage("$Output_was_successful", false)
		else
			ShowMessage("$Failed_to_output", false)
		endIf
	elseIf option == LoadMCMSettingsOID
		SetToggleOptionValue(LoadMCMSettingsOID, true)
		KNNPlugin_Utility.SetBasicNeeds("hungry", 2880.0)
		KNNPlugin_Utility.SetBasicNeeds("thirsty", 2880.0)
		KNNPlugin_Utility.SetBasicNeeds("sleepiness", 1680.0)
		KNNPlugin_Utility.SetBasicNeeds("bodyhealth", 0.0)
		KNNPlugin_Utility.SetBasicNeeds("drunkness", 0.0)
		KNNPlugin_Utility.SetBasicNeeds("followerbodyhealth", 0.0)
		widget.SetKNNWidget(false)
		widget.SetKNNWidgetOption(false)
		RemoveAbility(0)
		if Campfire.IsRunning()
			Campfire.Stop()
		endIf

		float[] values = KNNPlugin_Utility.LoadKNNSettings("GlobalSettings")
		Form[] array = KNNPlugin_Utility.GetKNNSettingsForms("GlobalSettings")
		if 0 < array.Length && 0 < values.Length && values.Length <= array.Length
			int i = 0
			while i < values.Length
				GlobalVariable gv = array[i] as GlobalVariable
				if gv
					gv.SetValue(values[i])
					if aaaKNNIsEnableWidget == gv
						if 0.0 != values[i]
							widget.SetKNNWidget(true)
						else
							widget.SetKNNWidget(false)
						endIf
					elseIf aaaKNNIsEnableWidgetOp == array[i]
						if 0.0 != values[i]
							widget.SetKNNWidgetOption(true)
						else
							widget.SetKNNWidgetOption(false)
						endIf
					endIf
				endIf
				i += 1
			endWhile

		else
			Debug.Trace("Failed to load KNN GlobalSettings")
		endIf
		Actor player = Game.GetPlayer()
		values = KNNPlugin_Utility.LoadKNNSettings("ActivationAnimationSettings")
		array = KNNPlugin_Utility.GetKNNSettingsForms("ActivationAnimationSettings")
		if player && 0 < array.Length && 0 < values.Length && values.Length <= array.Length
			int i = 0
			while i < array.Length
				Perk pk = array[i] as perk
				if pk
					player.RemovePerk(pk)
				endIf
				i += 1
			endWhile
			int n = 0
			while n < values.Length
				if 0.0 != values[n]
					Perk pk = array[n] as perk
					if pk
						player.AddPerk(pk)
						if pk == aaaKNNPerkGotoBed
							KNNPlugin_Utility.ResolveModBed()
						endIf
					endIf
				endIf
				n += 1
			endWhile
			if player.HasPerk(aaaKNNPerkDoor) && player.HasPerk(aaaKNNPerkDoorLegacy)
				player.RemovePerk(aaaKNNPerkDoorLegacy)
			endIf
		else
			Debug.Trace("Failed to load KNN Perk Anim Settings")
		endIf

		values = KNNPlugin_Utility.LoadKNNSettings("WidgetSettings")
		if 6 == values.Length
			widget.SetWidgetPositionX(values[0])
			widget.SetWidgetPositionY(values[1])
			widget.SetWidgetOptionPositionX(values[2])
			widget.SetWidgetOptionPositionY(values[3])
			widget.SetWidgetAlpha(values[4])
			widget.SetWidgetOptionAlpha(values[5])
		else
			Debug.Trace("Failed to load KNN Widget Settings")
		endIf

		values = KNNPlugin_Utility.LoadKNNSettings("KNNHTSettings")
		array = KNNPlugin_Utility.GetKNNSettingsForms("KNNHTSettings")
		if 0 < array.Length && 0 < values.Length && values.Length <= array.Length
			int i = 0
			while i < values.Length
				GlobalVariable gv = array[i] as GlobalVariable
				if gv
					gv.SetValue(values[i])
				endIf
				i += 1
			endWhile
		else
			Debug.Trace("Failed to load KNN-HT Settings")
		endIf

		SetToggleOptionValue(LoadMCMSettingsOID, false)
		GoToState("READY")
		(BasicNeedsQuest as aaaKNNBasicNeedsQuest).InIt()
		;(KNNHTQuest as aaaKNNHTQuest).UpdateValue()
		if 0 == aaaKNNIsHT.GetValueInt()
			(KNNHTQuest as aaaKNNHTQuest).EndHeadTrack()
		else
			KNNPlugin_Utility.SetNoLookObject()
		endIf
		(PerkAnimCtrlQuest as aaaKNNPlayPerkBedAnimQuest).SetFollowerSleepAnimEvent(aaaKNNFollowerPlaySleeping.GetValueInt())
		KNNPlugin_Utility.ForceCloseMCMMenu()
		(AnimCtrlQuest as aaaKNNPlayMealAnimQuest).SetFollowerMealAnimEvent(aaaKNNFollowerPlayMeal.GetValueInt())
		if player.HasPerk(aaaKNNPerkGotoBed) && !Campfire.IsRunning()
			Campfire.Start()
			(Campfire as aaaKNNFirewoodControlQuest).CheckModInstalled()
		endIf
	elseIf option == ExportAllFoodListOID
		SetToggleOptionValue(ExportAllFoodListOID, true)	
		if  KNNPlugin_Utility.ManagingAllFoodList(true)	
			ShowMessage("$Output_was_successful", false)
		else
			ShowMessage("$Failed_to_output", false)
		endIf
		SetToggleOptionValue(ExportAllFoodListOID, false)
	elseIf option == ImportAllFoodListOID
		SetToggleOptionValue(ImportAllFoodListOID, true)	
		if  KNNPlugin_Utility.ManagingAllFoodList(false)	
			ShowMessage("$Inport_was_successful", false)
		else
			ShowMessage("$Failed_to_inport", false)
		endIf
		SetToggleOptionValue(ImportAllFoodListOID, false)
	else
		int i = 0
		while i < mealAnimOID.Length
			if option == mealAnimOID[i]
				GoToState("READY")
				if mealAnimGV[i].GetValueInt() == 1
					SetToggleOptionValue(mealAnimOID[i], false)
					mealAnimGV[i].SetValueInt(0)
					if aaaAnimEatFoodStanding == mealAnimGV[i] || aaaAnimEatFoodSitting == mealAnimGV[i] || aaaAnimEatSoupStanding == mealAnimGV[i] || aaaAnimEatSoupSitting == mealAnimGV[i] || aaaAnimDrinkStanding == mealAnimGV[i] || aaaAnimDrinkSitting == mealAnimGV[i]
						IsResetFollowerMealToggle()
					endIf
				else
					SetToggleOptionValue(mealAnimOID[i], true)
					mealAnimGV[i].SetValueInt(1)						
				endIf
				return
			endIf
			i += 1
		endWhile
		
		Actor player = Game.GetPlayer()
		i = 0
		while i < PerksOID.Length
			if option == PerksOID[i]
				perk activationPerk = PerkList.GetAt(i) as Perk
				if activationPerk
					if i == 0
						if player.HasPerk(activationPerk)
							SetToggleOptionValue(PerksOID[i], false)
							player.RemovePerk(activationPerk)							
							if 0 != aaaKNNFollowerPlaySleeping.GetValueInt()
								aaaKNNFollowerPlaySleeping.SetValueInt(0)
								(PerkAnimCtrlQuest as aaaKNNPlayPerkBedAnimQuest).SetFollowerSleepAnimEvent(0)
							endIf
							if Campfire.IsRunning()
								Campfire.Stop()
							endIf
						else
							SetToggleOptionValue(PerksOID[i], true)
							player.AddPerk(activationPerk)							
							if !Campfire.IsRunning()
								KNNPlugin_Utility.ForceCloseMCMMenu()
								Campfire.Start()
								(Campfire as aaaKNNFirewoodControlQuest).CheckModInstalled()
							endIf
							KNNPlugin_Utility.ResolveModBed()
						endIf
					elseIf 4 == i
						if player.HasPerk(activationPerk)
							SetToggleOptionValue(PerksOID[i], false)
							player.RemovePerk(activationPerk)
						else
							perk removedPerk = PerkList.GetAt(i + 1) as Perk
							if removedPerk
								player.RemovePerk(removedPerk)
							endIf
							SetToggleOptionValue(PerksOID[i], true)
							player.AddPerk(activationPerk)
						endIf
					elseIf 5 == i
						if player.HasPerk(activationPerk)
							SetToggleOptionValue(PerksOID[i], false)
							player.RemovePerk(activationPerk)
						else
							perk removedPerk = PerkList.GetAt(i - 1) as Perk
							if removedPerk
								player.RemovePerk(removedPerk)
							endIf
							SetToggleOptionValue(PerksOID[i], true)
							player.AddPerk(activationPerk)
						endIf
					else
						if player.HasPerk(activationPerk)
							SetToggleOptionValue(PerksOID[i], false)
							player.RemovePerk(activationPerk)
						else
							SetToggleOptionValue(PerksOID[i], true)
							player.AddPerk(activationPerk)
						endIf
					endIf
				endIf
				return
			endIf
			i += 1
		endWhile		

		i = 0
		while i < QLAnimsOID.Length
			if option == QLAnimsOID[i]
				if QLValOID[i].GetValueInt() == 1
					SetToggleOptionValue(QLAnimsOID[i], false)
					QLValOID[i].SetValueInt(0)
				else
					SetToggleOptionValue(QLAnimsOID[i], true)
					QLValOID[i].SetValueInt(1)
				endIf
				return
			endIf
			i += 1
		endWhile
		
		if slotsOID.Length == SlotMaskArray.Length
			i = 0
			while i < slotsOID.Length
				if option == slotsOID[i]
					SlotMaskArray[i] = true != SlotMaskArray[i]
					SetToggleOptionValue(slotsOID[i], SlotMaskArray[i])
					KNNPlugin_Utility.SaveSlotMasks(GetXMLPath(CurrentCharacter), SlotMaskArray)
					return
				endIf
				i += 1
			endWhile
		endIf
		
		i = 0
		while i < HTExBasicOID.Length
			if option == HTExBasicOID[i]
				int MoodIndex = 1 + (HTExBasicGv.GetAt(i) as GlobalVariable).GetValueInt()
				if MoodIndex  < 0 || MoodIndex > 17
					MoodIndex = 0
				endIf
				(HTExBasicGv.GetAt(i) as GlobalVariable).SetValueInt(MoodIndex)
				SetTextOptionValue(HTExBasicOID[i], GetExpressionType(MoodIndex))
				SetOptionFlags(HTExValBasicOID[i], (17 == MoodIndex) as int)
				return
			endIf
			i += 1
		endWhile

		i = 0
		while i < HTExActorsOID.Length
			if option == HTExActorsOID[i]
				int MoodIndex = 1 + (HTExActorGV.GetAt(i) as GlobalVariable).GetValueInt()
				if MoodIndex  < 0 || MoodIndex > 17
					MoodIndex = 0
				endIf
				(HTExActorGV.GetAt(i) as GlobalVariable).SetValueInt(MoodIndex)
				SetTextOptionValue(HTExActorsOID[i], GetExpressionType(MoodIndex))
				SetOptionFlags(HTExValActorsOID[i], (17 == MoodIndex) as int)
				return
			endIf
			i += 1
		endwhile

		i = 0
		while i < HTFormsOID.Length
			if option == HTFormsOID[i]
				bool IsEnable = true
				if 0 != (HTFormGV.GetAt(i) as GlobalVariable).GetValueInt()
					IsEnable = false
				endIf
				SetToggleOptionValue(HTFormsOID[i], IsEnable)
				(HTFormGV.GetAt(i) as GlobalVariable).SetValueInt(IsEnable as int)
				SetOptionFlags(HTExFormsOID[i], (!IsEnable) as int)
				SetOptionFlags(HTExValFormsOID[i], (!IsEnable) as int)
				return
			endIf
			i += 1
		endwhile

		i = 0
		while i < HTExFormsOID.Length
			if option == HTExFormsOID[i]
				int MoodIndex = 1 + (HTExFormGV.GetAt(i) as GlobalVariable).GetValueInt()
				if MoodIndex  < 0 || MoodIndex > 17
					MoodIndex = 0
				endIf				
				(HTExFormGV.GetAt(i) as GlobalVariable).SetValueInt(MoodIndex)
				SetTextOptionValue(HTExFormsOID[i], GetExpressionType(MoodIndex))
				SetOptionFlags(HTExValFormsOID[i], (17 == MoodIndex) as int)
				return
			endIf
			i += 1
		endwhile
		
		i = 0
		while i < followerOID.Length
			if option == followerOID[i]
				if i != 2
					if followerValOID[i].GetValueInt() == 1
						SetToggleOptionValue(followerOID[i], false)
						followerValOID[i].SetValueInt(0)
						if aaaKNNFollowerPlaySleeping == followerValOID[i]
							(PerkAnimCtrlQuest as aaaKNNPlayPerkBedAnimQuest).SetFollowerSleepAnimEvent(0)
						elseIf aaaKNNFollowerPlayMeal == followerValOID[i]
							(AnimCtrlQuest as aaaKNNPlayMealAnimQuest).SetFollowerMealAnimEvent(0)
						endIf
					else
						SetToggleOptionValue(followerOID[i], true)
						followerValOID[i].SetValueInt(1)
						if aaaKNNFollowerPlaySleeping == followerValOID[i]
							(PerkAnimCtrlQuest as aaaKNNPlayPerkBedAnimQuest).SetFollowerSleepAnimEvent(1)
						elseIf aaaKNNFollowerPlayMeal == followerValOID[i]
							KNNPlugin_Utility.ForceCloseMCMMenu()
							(AnimCtrlQuest as aaaKNNPlayMealAnimQuest).SetFollowerMealAnimEvent(1)
						endIf
					endIf
				endIf
				return
			endIf
			i += 1
		endWhile
	endIf
EndEvent

Event OnOptionDefault(int option)
	if option == BNOID
		if aaaKNNIsBasicNeedsEnable.GetValueInt() != 0
			SetTextOptionValue(BNOID, GetFunctionState(0))
			aaaKNNIsBasicNeedsEnable.SetValueInt(0)
			SetOptionFlags(HungryOID, OPTION_FLAG_DISABLED)
			SetOptionFlags(ThirstyOID, OPTION_FLAG_DISABLED)
			SetOptionFlags(SleepOID, OPTION_FLAG_DISABLED)
			SetOptionFlags(BodyOID, OPTION_FLAG_DISABLED)
			SetOptionFlags(DrunkOID, OPTION_FLAG_DISABLED)
			SetOptionFlags(dirtyBodyOID, OPTION_FLAG_DISABLED)
			SetOptionFlags(HungryGrowlOID, OPTION_FLAG_DISABLED)
			;if aaaKNNIsEnableExpression.GetValueInt() != 0
			;	SetTextOptionValue(ExpressionOID, GetExpressionState(0))
			;	aaaKNNIsEnableExpression.SetValueInt(0)
			;endIf
			;SetOptionFlags(ExpressionOID, OPTION_FLAG_DISABLED)			
			SetOptionFlags(intervalBodyOID, OPTION_FLAG_DISABLED)
			SetOptionFlags(SellBottleOID, OPTION_FLAG_DISABLED)
			SetOptionFlags(SellTowelPotionOID, OPTION_FLAG_DISABLED)
			SetOptionFlags(WaterBarrelOID, OPTION_FLAG_DISABLED)
			if 0 != aaaKNNIsEnabledSellTowel.GetValueInt() || 0 != aaaKNNIsEnableSellWaterBottle.GetValueInt() || 0 != _KNNIsEnableWaterBarrelFeature.GetValueInt()
				GoToState("READY")
			endIf
			SetOptionFlags(convertEmptyBottleOID, OPTION_FLAG_DISABLED)
			SetOptionFlags(DieOID, OPTION_FLAG_DISABLED)
			if aaaKNNHotkeyHipBag.GetValueInt() > 0
				aaaKNNHotkeyHipBag.SetValueInt(0)
			endIf
			if aaaKNNHotkeyJurnal.GetValueInt() > 0
				GoToState("READY")
				aaaKNNHotkeyJurnal.SetValueInt(0)
			endIf
			if aaaKNNIsEnableWidget.GetValueInt() !=0
				aaaKNNIsEnableWidget.SetValueInt(0)
				widget.SetKNNWidget(false)
			endIf
			if aaaKNNIsEnableWidgetOp.GetValueInt() !=0
				aaaKNNIsEnableWidgetOp.SetValueInt(0)
				widget.SetKNNWidgetOption(false)
			endIf
			if aaaKNNHotkeyWidget.GetValueInt() > 0
				aaaKNNHotkeyWidget.SetValueInt(0)
			endIf
			if aaaKNNIsEnableQuickLootAnim.GetValueInt() != 0
				aaaKNNIsEnableQuickLootAnim.SetValueInt(0)
			endIf
			if aaaKNNIsEnableSellWaterBottle.GetValueInt() != 0
				aaaKNNIsEnableSellWaterBottle.SetValueInt(0)
			endIf
			if aaaKNNIsConvertEmptyBottle.GetValueInt() != 0
				aaaKNNIsConvertEmptyBottle.SetValueInt(0)
			endIf
			if -1 != aaaKNNHotkeyIdleAnim.GetValueInt()
				aaaKNNHotkeyIdleAnim.SetValueInt(-1)
			endIf
			if -1 != aaaKNNHotkeyHipBag.GetValueInt()
				aaaKNNHotkeyHipBag.SetValueInt(-1)
			endIf
			RemoveAbility(ABILITY_ALL)
		endIf
	elseIf option == HungryOID
		if aaaKNNIsEnableHungry.GetValueInt() != 1
			SetTextOptionValue(HungryOID, GetFunctionState(1))
			aaaKNNIsEnableHungry.SetValueInt(1)			
			;SetOptionFlags(ExpressionOID, 0)
			SetOptionFlags(HungryGrowlOID, 0)
			SetOptionFlags(DieOID, 0)
			if aaaKNNIsLimitDamageHungry.GetValueInt() == 1
				SetOptionFlags(damageHungryLimitValOID, 0)
			endIf
			if aaaKNNIsLimitDamageHungry.GetValueInt() != 2
				SetOptionFlags(damageHungryLimitMagOID, 0)
			endIf
			RemoveAbility(ABILITY_HUNGRY)
		endIf
	elseIf option == ThirstyOID
		if aaaKNNIsEnableThirsty.GetValueInt() != 1
			SetTextOptionValue(ThirstyOID, GetFunctionState(1))
			aaaKNNIsEnableThirsty.SetValueInt(1)			
			;SetOptionFlags(ExpressionOID, 0)
			SetOptionFlags(HungryGrowlOID, 0)
			SetOptionFlags(DieOID, 0)
			if aaaKNNIsLimitDamageThirsty.GetValueInt() == 1
				SetOptionFlags(damageThirstyLimitValOID, 0)
			endIf
			if aaaKNNIsLimitDamageThirsty.GetValueInt() != 2
				SetOptionFlags(damageThirstyLimitMagOID, 0)
			endIf
			RemoveAbility(ABILITY_THIRSTY)
		endIf
	elseIf option == SleepOID
		if aaaKNNIsEnableSleepiness.GetValueInt() != 1
			SetTextOptionValue(SleepOID, GetFunctionState(1))
			aaaKNNIsEnableSleepiness.SetValueInt(1)			
			;SetOptionFlags(ExpressionOID, 0)
			SetOptionFlags(HungryGrowlOID, 0)
			SetOptionFlags(DieOID, 0)
			RemoveAbility(ABILITY_SLEEPY)
		endIf
	elseIf option == BodyOID
		if aaaKNNIsEnableBodyHealth.GetValueInt() != 1
			SetTextOptionValue(BodyOID, GetFunctionState(1))
			aaaKNNIsEnableBodyHealth.SetValueInt(1)
			SetOptionFlags(DirtyBodyOID, 0)
			SetOptionFlags(intervalBodyOID, 0)
			SetOptionFlags(HungryGrowlOID, 0)
			RemoveAbility(ABILITY_BODY)
		endIf
	elseIf option == DrunkOID
		if aaaKNNIsEnableDrunkness.GetValueInt() != 1
			SetTextOptionValue(DrunkOID, GetFunctionState(1))
			aaaKNNIsEnableDrunkness.SetValueInt(1)
			RemoveAbility(ABILITY_DRUNK)
		endIf
	elseIf option == ResetHungryValueOID
		SetToggleOptionValue(ResetHungryValueOID, true)
		KNNPlugin_Utility.SetBasicNeeds("hungry", 2880.0)
		ShowMessage("$ResetBasicNeedsValues", false)
		SetToggleOptionValue(ResetHungryValueOID, false)

		SetTextOptionValue(CurrentHungryOID, KNNPlugin_Utility.GetBasicNeeds("hungry"))
	elseIf option == ResetThirstyValueOID
		SetToggleOptionValue(ResetThirstyValueOID, true)
		KNNPlugin_Utility.SetBasicNeeds("thirsty", 2880.0)
		ShowMessage("$ResetBasicNeedsValues", false)
		SetToggleOptionValue(ResetThirstyValueOID, false)

		SetTextOptionValue(CurrentThirstyOID, KNNPlugin_Utility.GetBasicNeeds("thirsty"))
	elseIf option == ResetSleepyValueOID
		SetToggleOptionValue(ResetSleepyValueOID, true)
		KNNPlugin_Utility.SetBasicNeeds("sleepiness", 1680.0)
		ShowMessage("$ResetBasicNeedsValues", false)
		SetToggleOptionValue(ResetSleepyValueOID, false)

		SetTextOptionValue(CurrentSleepyOID, KNNPlugin_Utility.GetBasicNeeds("Sleepiness"))
	elseIf option == ResetBodyValueOID
		SetToggleOptionValue(ResetBodyValueOID, true)
		KNNPlugin_Utility.SetBasicNeeds("bodyhealth", 0.0)
		ShowMessage("$ResetBasicNeedsValues", false)
		SetToggleOptionValue(ResetBodyValueOID, false)

		SetTextOptionValue(CurrentBodyOID, KNNPlugin_Utility.GetBasicNeeds("Bodyhealth"))
	elseIf option == ResetDrunkValueOID
		SetToggleOptionValue(ResetDrunkValueOID, true)
		KNNPlugin_Utility.SetBasicNeeds("drunkness", 0.0)
		ShowMessage("$ResetBasicNeedsValues", false)
		SetToggleOptionValue(ResetDrunkValueOID, false)

		SetTextOptionValue(CurrentDrunkOID, KNNPlugin_Utility.GetBasicNeeds("Drunkness"))
	elseIf option == DirtyBodyOID
		if aaaKNNIsEnableDirtyBodyEffect.GetValueInt() != 0
			SetTextOptionValue(DirtyBodyOID, GetFunctionState(0))
			aaaKNNIsEnableDirtyBodyEffect.SetValueInt(0)
			SetOptionFlags(intBodyOID, 0)
			if 0 != aaaKNNIsEnableFollowerDirtyBodyEffect.GetValueInt()
				aaaKNNIsEnableFollowerDirtyBodyEffect.SetValueInt(0)
			endIf
			RemoveAbility(ABILITY_BODY)
		endIf
	elseif option == HungryGrowlOID
		if aaaKNNIsEnableHungryGrowl.GetValueInt() != 1
			SetTextOptionValue(HungryGrowlOID, GetFunctionState(1))
			aaaKNNIsEnableHungryGrowl.SetValueInt(1)
		endIf
	elseif option == ExpressionOID
		if aaaKNNIsEnableExpression.GetValueInt() != 0
			SetTextOptionValue(ExpressionOID, GetExpressionState(0))
			aaaKNNIsEnableExpression.SetValueInt(0)
		endIf
	elseIf option == IsLimitDamageHungryOID
		if aaaKNNIsLimitDamageHungry.GetValueInt() != 0
			SetTextOptionValue(IsLimitDamageHungryOID, GetDamageBasicneedState(0))
			aaaKNNIsLimitDamageHungry.SetValueInt(0)
		endIf
	elseIf option == IsLimitDamageThirstyOID
		if aaaKNNIsLimitDamageThirsty.GetValueInt() != 0
			SetTextOptionValue(IsLimitDamageThirstyOID, GetDamageBasicneedState(0))
			aaaKNNIsLimitDamageThirsty.SetValueInt(0)
		endIf
	elseIf option == KNNCurrentStutasOID
		SetToggleOptionValue(KNNCurrentStutasOID, true)
		if KNNPlugin_Utility.ShowKNNBasicNeedsStutas()
			ShowMessage("$SucceedToOutPutKNNLog", false)
		else
			ShowMessage("$FailedToOutPutKNNLog", false)
		endIf
		SetToggleOptionValue(KNNCurrentStutasOID, false)
	elseIf option == WaterBarrelLocationsOID
		if WaterBarrelQuest.IsRunning()
			_KNNWaterBarrelQuest wbq = WaterBarrelQuest as _KNNWaterBarrelQuest
			if wbq && wbq.IsLocationDisplayed
				wbq.DisplayedAllBarrelLocations()
				SetToggleOptionValue(WaterBarrelLocationsOID, wbq.IsLocationDisplayed)
			endIf
		endIf
	elseIf option == HardOID
		if aaaKNNIsEnableBasicNeedsHard.GetValueInt() != 0
			aaaKNNIsEnableBasicNeedsHard.SetValueInt(0)
			RemoveAbility(ABILITY_HARD)
			RemoveAbility(ABILITY_LEGENDARY)
			SetTextOptionValue(HardOID, GetStaminaPenaltyState(0))
		endIf
	elseIf option == PCGenderOID
		if 0 == aaaKNNIsPCGenderFemale.GetValueInt()
			SetTextOptionValue(PCGenderOID, GetPCGender(1))
			aaaKNNIsPCGenderFemale.SetValueInt(1)
		endIf
	elseIf option == CurrentCharacterSlotOID
		if 0 != CurrentCharacter
			CurrentCharacter = 0		
			SetTextOptionValue(CurrentCharacterSlotOID, GetCurrentSlots(CurrentCharacter))
			ForcePageReset()
		endIf
	elseIf option == IsPOVOID
		if aaaKNNIsEnablePOV.GetValueInt() != 0
			SetTextOptionValue(IsPOVOID, GetFunctionState(0))
			aaaKNNIsEnablePOV.SetValueInt(0)
		endIf
	elseIf option == IsShieldUnequipOID
		if 0 != aaaKNNIsShieldUnequip.GetValueInt()
			SetTextOptionValue(IsShieldUnequipOID, GetShieldCtrl(0))
			aaaKNNIsShieldUnequip.SetValueInt(0)
		endIf
	elseIf option == IsCameraAnimatedOID
		if aaaKNNIsEnableCameraAnimated.GetValueInt() != 0
			SetTextOptionValue(IsCameraAnimatedOID, GetFunctionState(0))
			aaaKNNIsEnableCameraAnimated.SetValueInt(0)
		endIf
	elseIf option == IsActiAmiQLOID
		if aaaKNNIsEnableQuickLootAnim.GetValueInt() != 0
			SetTextOptionValue(IsActiAmiQLOID, GetFunctionState(0))
			aaaKNNIsEnableQuickLootAnim.SetValueInt(0)
			if QLAnimsOID.Length > 0
				int index = 0
				while index < QLAnimsOID.Length
					SetOptionFlags(QLAnimsOID[index], 1)
					index += 1
				endWhile
			endIf
		endIf
	elseIf option == MsgOID
		if aaaKNNIsEnableMessage.GetValueInt() != 0
			SetTextOptionValue(MsgOID, GetFunctionState(0))
			aaaKNNIsEnableMessage.SetValueInt(0)
			(BasicNeedsQuest as aaaKNNBasicNeedsQuest).InIt()
			
		endIf
	elseIf option == QuiverOID
		if aaaKNNIsEnableQuiver.GetValueInt() != 0
			SetTextOptionValue(QuiverOID, GetFunctionState(0))
			aaaKNNIsEnableQuiver.SetValueInt(0)
			
		endIf
	elseIf option == UseInkPenOID
		if aaaKNNIsEnableUseInkPen.GetValueInt() != 1
			SetKeyMapOptionValue(UseInkPenOID, 1)
			aaaKNNIsEnableUseInkPen.SetValueInt(1)			
		endIf
	elseIf option == StumbleOID
		if aaaKNNIsEnableStumble.GetValueInt() != 1
			SetTextOptionValue(StumbleOID, GetFunctionState(1))
			aaaKNNIsEnableStumble.SetValueInt(1)
		endIf
	elseIf option == SellBottleOID
		if aaaKNNIsEnableSellWaterBottle.GetValueInt() != 0
			GoToState("READY")
			SetTextOptionValue(SellBottleOID, GetFunctionState(0))
			aaaKNNIsEnableSellWaterBottle.SetValueInt(0)
		endIf
	elseIf option == SellTowelPotionOID
		if 0 != aaaKNNIsEnabledSellTowel.GetValueInt()
			GoToState("READY")
			SetTextOptionValue(SellTowelPotionOID, GetFunctionState(0))
			aaaKNNIsEnabledSellTowel.SetValueInt(0)
		endIf
	elseIf option == WaterBarrelOID
		if 0 != _KNNIsEnableWaterBarrelFeature.GetValueInt()
			GoToState("READY")
			SetTextOptionValue(WaterBarrelOID, GetFunctionState(0))
			_KNNIsEnableWaterBarrelFeature.SetValueInt(0)
		endIf
	elseIf option == convertEmptyBottleOID
		if aaaKNNIsConvertEmptyBottle.GetValueInt() != 0
			SetTextOptionValue(convertEmptyBottleOID, GetFunctionState(0))
			aaaKNNIsConvertEmptyBottle.SetValueInt(0)
		endIf
	elseIf option == PRIORITYDRINKSTYPEOID
		if aaaKNNPotionUseagePriorityWater.GetValueInt() != 0
			SetTextOptionValue(PRIORITYDRINKSTYPEOID, GetPotionDrinkTypeState(0))
			aaaKNNPotionUseagePriorityWater.SetValueInt(0)
		endIf
	elseIf option == PUFOODOID || option == PUDRINKOID
		int[] OID = new int[2]
		OID[0] = PUFOODOID
		OID[1] = PUDRINKOID
		GlobalVariable[] VAL = new GlobalVariable[2]
		VAL[0] = aaaKNNPotionUseageEffectFoods
		VAL[1] = aaaKNNPotionUseageEffectDrinks
		int id = 0
		while id < OID.Length
			if option == OID[id]
				if VAL[id].GetValueInt() != 0					
					VAL[id].SetValueInt(0)
					if id == 0
						SetTextOptionValue(OID[id], GetFoodEffectState(0))
						SetOptionFlags(PRIORITYFOODOID, 0)
					else
						SetTextOptionValue(OID[id], GetDrinkEffectState(0))
					endIf
				endIf
			endIf
			id += 1
		endWhile
	elseIf option == PUCUSTOMOID
		if aaaKNNPotionUseageEffectCustom.GetValueInt() != 1
			aaaKNNPotionUseageEffectCustom.SetValueInt(1)
			SetTextOptionValue(PUCUSTOMOID, GetPotionEffectState(1))
		endIf
	elseIf option == PRIORITYFOODOID || option == PRIORITYDRINKOID
		int[] OID = new int[2]
		OID[0] = PRIORITYFOODOID
		OID[1] = PRIORITYDRINKOID
		GlobalVariable[] VAL = new GlobalVariable[2]
		VAL[0] = aaaKNNPotionUseagePriorityFoods
		VAL[1] = aaaKNNPotionUseagePriorityDrinks
		int id = 0
		while id < OID.Length
			if option == OID[id]
				if VAL[id].GetValueInt() != 0
					VAL[id].SetValueInt(0)
					SetTextOptionValue(OID[id], GetPotionPriorityState(0))
				endIf
			endIf
			id += 1
		endWhile
	elseIf option == WidgetOID
		if aaaKNNIsEnableWidget.GetValueInt() != 0
			aaaKNNIsEnableWidget.SetValueInt(0)
			SetToggleOptionValue(WidgetOID, false)
			widget.SetKNNWidget(false)
		endIf
	elseIf option == WidgetOpOID
		if aaaKNNIsEnableWidgetOp.GetValueInt() != 0
			aaaKNNIsEnableWidgetOp.SetValueInt(0)
			SetToggleOptionValue(WidgetOpOID, false)
			widget.SetKNNWidgetOption(false)
			
		endIf
	elseIf option == IsHTOID
		if aaaKNNIsHT.GetValueInt() != 0
			SetToggleOptionValue(IsHTOID, false)
			aaaKNNIsHT.SetValueInt(0)
			(KNNHTQuest as aaaKNNHTQuest).EndHeadTrack()
			SetOptionFlags(HTPriorityOID, OPTION_FLAG_DISABLED)
			SetOptionFlags(HTIntervalOID, OPTION_FLAG_DISABLED)
			SetOptionFlags(IsExpressionChangeExtensionOID, OPTION_FLAG_DISABLED)
			SetOptionFlags(NextHTIntervalOID, OPTION_FLAG_DISABLED)
			SetOptionFlags(IsNotHTWeaponDrawnOID, OPTION_FLAG_DISABLED)
			SetOptionFlags(IsIdleAnimOID, OPTION_FLAG_DISABLED)
			SetOptionFlags(UpdateNoLookObjOID, OPTION_FLAG_DISABLED)
		endIf
	elseIf option == HTIntervalOID
		if aaaKNNHTInterVal.GetValue() != 0.0
			SetSliderOptionValue(HTInterValOID, 0.0,"{1} Second")
			aaaKNNHTInterVal.SetValue(0.0)
			;(KNNHTQuest as aaaKNNHTQuest).UpdateValue()
		endIf
	elseIf option == IsExpressionChangeExtensionOID
		if aaaKNNIsExpressionChangeExtension.GetValueInt() != 0
			SetToggleOptionValue(IsExpressionChangeExtensionOID, true)
			aaaKNNIsExpressionChangeExtension.SetValueInt(1)			
		endIf
	elseIf option == IsEyeTrackingOID
		if 0 != aaaKNNIsHTEnableEyeTracking.GetValueInt()
			SetTextOptionValue(IsEyeTrackingOID, GetFunctionState(0))
			aaaKNNIsHTEnableEyeTracking.SetValueInt(0)
			SetOptionFlags(HorizontalRangeMaxOID, OPTION_FLAG_DISABLED)
			SetOptionFlags(HorizontalRangeMinOID, OPTION_FLAG_DISABLED)
			SetOptionFlags(HorizontalPowerMaxOID, OPTION_FLAG_DISABLED)
			SetOptionFlags(HorizontalPowerMinOID, OPTION_FLAG_DISABLED)
			SetOptionFlags(VerticalRangeMaxOID, OPTION_FLAG_DISABLED)
			SetOptionFlags(VerticalRangeMinOID, OPTION_FLAG_DISABLED)
			SetOptionFlags(VerticalPowerMaxOID, OPTION_FLAG_DISABLED)
			SetOptionFlags(VerticalPowerMinOID, OPTION_FLAG_DISABLED)
		endIf
	elseIf option == HTPriorityOID
		if aaaKNNHTPriority.GetValueInt() != 1
			aaaKNNHTPriority.SetValueInt(1)
			SetTextOptionValue(HTPriorityOID, GetHTPriority(1))
			;(KNNHTQuest as aaaKNNHTQuest).UpdateValue()
			;(KNNHTQuest as aaaKNNHTQuest).StartHeadTrack()
			
		endIf
	elseIf option == IsIdleAnimOID
		if aaaKNNIsHTIdleAnim.GetValueInt() != 0
			SetToggleOptionValue(IsIdleAnimOID, false)
			aaaKNNIsHTIdleAnim.SetValueInt(0)
		endIf
	elseIf option == UpdateNoLookObjOID
		SetToggleOptionValue(UpdateNoLookObjOID, false)
	elseIf option == IsHTActorOID
		if aaaKNNIsHTActor.GetValueInt() != 1
			SetToggleOptionValue(IsHTActorOID, true)
			aaaKNNIsHTActor.SetValueInt(1)
			int i = 0
			while i < HTExActorsOID.Length && i < HTExValActorsOID.Length
				SetOptionFlags(HTExActorsOID[i], OPTION_FLAG_NONE)
				SetOptionFlags(HTExValActorsOID[i], OPTION_FLAG_NONE)
				i += 1
			endwhile		
		endIf	
	elseIf option == IsNotHTWeaponDrawnOID
		if 0 != _KNNHTDisabledWhileWeaponDrawn.GetValueInt()
			_KNNHTDisabledWhileWeaponDrawn.SetValueInt(0)
			SetToggleOptionValue(IsNotHTWeaponDrawnOID, false)
		endIf		
	elseIf option == EnabledExInCombatOID
		if 0 == aaaKNNIsEnableExpressionInCombat.GetValueInt()
			SetOptionFlags(HTExBasicOID[0], OPTION_FLAG_NONE)
			SetOptionFlags(HTExValBasicOID[0], OPTION_FLAG_NONE)
			SetTextOptionValue(EnabledExInCombatOID, GetFunctionState(1))
			aaaKNNIsEnableExpressionInCombat.SetValueInt(1)
		endIf	
	elseIf option == HipBagOID || option == JurnalOID || option == WidgetHotkeyOID || option == IdleAnimOID
		int[] OID = new int[4]
		OID[0] = HipBagOID
		OID[1] = JurnalOID
		OID[2] = WidgetHotkeyOID
		OID[3] = IdleAnimOID
		GlobalVariable[] VAL = new GlobalVariable[4]
		VAL[0] = aaaKNNHotkeyHipBag
		VAL[1] = aaaKNNHotkeyJurnal
		VAL[2] = aaaKNNHotkeyWidget
		VAL[3] = aaaKNNHotkeyIdleAnim
		int id = 0
		while id < OID.Length
			if option == OID[id]
				if VAL[id].GetValueInt() != -1
					if 1 == id || 3 == id
						GoToState("READY")
					endIf
					VAL[id].SetValueInt(-1)
					SetKeyMapOptionValue(OID[id], -1)
				endIf
			endIf
			id += 1
		endWhile
	elseIf option == FOODOID || option == DRINKOID || option == CUSTOMOID
		int[] OID = new int[3]
		OID[0] = FOODOID
		OID[1] = DRINKOID
		OID[2] = CUSTOMOID
		GlobalVariable[] VAL = new GlobalVariable[3]
		VAL[0] = aaaKNNHotkeyFoods
		VAL[1] = aaaKNNHotkeyDrinks
		VAL[2] = aaaKNNHotkeyCustom
		int id = 0
		while id < OID.Length
			if option == OID[id]
				if VAL[id].GetValueInt() != -1
					VAL[id].SetValueInt(-1)
					SetKeyMapOptionValue(OID[id], -1)
				endIf
			endIf
			id += 1
		endWhile
	else
		int i = 0
		while i < mealAnimOID.Length
			if option == mealAnimOID[i]
				if mealAnimGV[i].GetValueInt() != 1
					GoToState("READY")
					SetToggleOptionValue(mealAnimOID[i], true)
					mealAnimGV[i].SetValueInt(1)						
				endIf
				return
			endIf
			i += 1
		endWhile
		
		Actor player = Game.GetPlayer()
		i = 0
		while i < PerksOID.Length
			if option == PerksOID[i]
				perk thisPerk = PerkList.GetAt(i) as perk
				if thisPerk
					if player.HasPerk(thisPerk)
						SetToggleOptionValue(PerksOID[i], false)
						player.RemovePerk(thisPerk)
						if 0 == i
							if 0 != aaaKNNFollowerPlaySleeping.GetValueInt()
								aaaKNNFollowerPlaySleeping.SetValueInt(0)
								(PerkAnimCtrlQuest as aaaKNNPlayPerkBedAnimQuest).SetFollowerSleepAnimEvent(0)
							endIf
							if Campfire.IsRunning()
								Campfire.Stop()
							endIf
						endIf
					endIf
				endIf
				return
			endIf
			i += 1
		endWhile

		i = 0
		while i < QLAnimsOID.Length
			if option == QLAnimsOID[i]
				if QLValOID[i].GetValueInt() != 0
					SetToggleOptionValue(QLAnimsOID[i], false)
					QLValOID[i].SetValueInt(0)
				endIf
				return
			endIf
			i += 1
		endWhile

		if slotsOID.Length == SlotMaskArray.Length
			i = 0
			while i < slotsOID.Length
				if option == slotsOID[i]
					if !SlotMaskArray[i]
						SlotMaskArray[i] = true
						SetToggleOptionValue(slotsOID[i], SlotMaskArray[i])
						KNNPlugin_Utility.SaveSlotMasks(GetXMLPath(CurrentCharacter), SlotMaskArray)
					endIf
					return
				endIf
				i += 1
			endWhile
		endIf

		i = 0
		while i < HTExBasicOID.Length
			if option == HTExBasicOID[i]
				if HTExBasicDefault[i] != (HTExBasicGv.GetAt(i) as GlobalVariable).GetValueInt()
					SetTextOptionValue(HTExBasicOID[i], GetExpressionType(HTExBasicDefault[i]))
					(HTExBasicGv.GetAt(i) as GlobalVariable).SetValueInt(HTExBasicDefault[i])
					SetOptionFlags(HTExValBasicOID[i], OPTION_FLAG_NONE)			
				endIf
				return
			endIf
			i += 1
		endWhile

		i = 0
		while i < HTExValBasicOID.Length
			if option == HTExValBasicOID[i]
				if 100.0 != (HTExValBasicGv.GetAt(i) as GlobalVariable).GetValue()
					SetSliderOptionValue(HTExValBasicOID[i], 100.0, "{0}")
					(HTExValBasicGv.GetAt(i) as GlobalVariable).SetValue(100.0)			
				endIf
				return
			endIf
			i += 1
		endwhile

		i = 0
		while i < HTExActorsOID.Length
			if option == HTExActorsOID[i]
				if HTExActorDefault[i] != (HTExActorGV.GetAt(i) as GlobalVariable).GetValueInt()
					SetTextOptionValue(HTExActorsOID[i], GetExpressionType(HTExActorDefault[i]))
					(HTExActorGV.GetAt(i) as GlobalVariable).SetValueInt(HTExActorDefault[i] as int)					
				endIf
				return
			endIf
			i += 1
		endwhile

		i = 0
		while i < HTExValActorsOID.Length
			if option == HTExValActorsOID[i]
				if HTExValActorDefault[i] != (HTExValActorGV.GetAt(i) as GlobalVariable).GetValue()
					SetSliderOptionValue(HTExValActorsOID[i], HTExValActorDefault[i], "{0}")
					(HTExValActorGV.GetAt(i) as GlobalVariable).SetValue(HTExValActorDefault[i])
				endIf
				return
			endIf
			i += 1
		endwhile

		i = 0
		while i < HTFormsOID.Length
			if option == HTFormsOID[i]
				if 0 == (HTFormGV.GetAt(i) as GlobalVariable).GetValueInt()
					SetToggleOptionValue(HTFormsOID[i], true)
					(HTFormGV.GetAt(i) as GlobalVariable).SetValueInt(1)
					SetOptionFlags(HTExFormsOID[i], OPTION_FLAG_NONE)
					SetOptionFlags(HTExValFormsOID[i], OPTION_FLAG_NONE)					
				endIf
				return
			endIf
			i += 1
		endwhile
		
		i = 0
		while i < HTExFormsOID.Length
			if option == HTExFormsOID[i]
				if HTExFormDefault[i] != (HTExFormGV.GetAt(i) as GlobalVariable).GetValueInt()
					SetTextOptionValue(HTExFormsOID[i], GetExpressionType(HTExFormDefault[i]))
					(HTExFormGV.GetAt(i) as GlobalVariable).SetValueInt(HTExFormDefault[i])
					SetOptionFlags(HTExValFormsOID[i], OPTION_FLAG_NONE)
					
				endIf
				return
			endIf
			i += 1
		endwhile

		i = 0
		while i < HTExValFormsOID.Length
			if option == HTExValFormsOID[i]
				if HTExValFormDefault[i] != (HTExValFormGV.GetAt(i) as GlobalVariable).GetValueInt()
					SetSliderOptionValue(HTExValFormsOID[i], HTExValFormDefault[i], "{0}")
					(HTExValFormGV.GetAt(i) as GlobalVariable).SetValueInt(HTExValFormDefault[i] as int)					
				endIf
				return
			endIf
			i += 1
		endwhile

		i = 0
		while i < followerOID.Length
			if option == followerOID[i]
				if i != 2
					if followerValOID[i].GetValueInt() != 0
						SetToggleOptionValue(followerOID[i], false)
						followerValOID[i].SetValueInt(0)
						if aaaKNNFollowerPlaySleeping == followerValOID[i]
							(PerkAnimCtrlQuest as aaaKNNPlayPerkBedAnimQuest).SetFollowerSleepAnimEvent(0)
						elseIf aaaKNNFollowerPlayMeal == followerValOID[i]
							(AnimCtrlQuest as aaaKNNPlayMealAnimQuest).SetFollowerMealAnimEvent(0)
						endIf
					endIf
				endIf
				return
			endIf
			i += 1
		endWhile
	endIf
EndEvent

Event OnOptionMenuAccept(int option, int index)
	if option == CreateXMLOID
		if 0 == index; || xmlList.Length - 1 < index
			return
		endIf
		if KNNPlugin_Utility.CreateAnimationXML(ListStringConvertToAnimType(index))
			ShowMessage("$SucceedToOutPutKNNLog", false)
		else
			ShowMessage("$FailedToOutPutKNNLog", false)
		endIf
	else
		int i = 0
		while i < FoodTypeListOID.Length
			if option == FoodTypeListOID[i]
				if index < foodsList.Length && index < foodsStrList.Length
					if foodsStrList[index] == "Do nothing" || foodsStrList[index] == "N/A" 
						;Debug.Trace("Do nothing")
						return				
					elseIf foodsStrList[index] == "Remove all"
						;Debug.Trace("Remove all")
						FormList list = _KNNAlllFoodTypeLists.GetAt(i) as FormList
						if list
							list.Revert()
							ShowMessage(ClearListMessageList[i], false)
						endIf
					else
						if foodsList[index]
							FormList list = _KNNAlllFoodTypeLists.GetAt(i) as FormList
							if list
								list.RemoveAddedForm(foodsList[index])
								;Debug.Trace(foodsList[index].GetName() + " is Removed")
								;ShowMessage("$ClearedFoodList", false)
							endIf
						endIf
					endIf
				endIf
				return
			endIf
			i += 1
		endwhile
	endIf
EndEvent

Event OnOptionMenuOpen(int option)
	if option == CreateXMLOID
		SetMenuDialogOptions(xmlList)
		SetMenuDialogStartIndex(0)
		SetMenuDialogDefaultIndex(0)
	else
		int i = 0
		while i < FoodTypeListOID.Length
			if option == FoodTypeListOID[i]
				foodsList = KNNPlugin_Utility.GetFoodsFromList(FoodListNames[i])
				foodsStrList = KNNPlugin_Utility.GetFoodsFromNameList(FoodListNames[i])
				if 0 == foodsList.Length || 0 == foodsStrList.Length
					foodsStrList = new string[1]
					foodsStrList[0] = "N/A"
				endIf
				SetMenuDialogOptions(foodsStrList)
				SetMenuDialogStartIndex(0)
				SetMenuDialogDefaultIndex(0)
				return
			endIf
			i += 1
		endwhile
	endIf
EndEvent

Event OnOptionHighlight(int option)
	if option == BNOID
		SetInfoText("$Enable_KNN_Description")
	elseIf option == HungryOID
		SetInfoText("$Enable_Hungry_Description")
	elseIf option == ThirstyOID
		SetInfoText("$Enable_Thirsty_Description")
	elseIf option == SleepOID
		SetInfoText("$Enable_Sleepy_Description")
	elseIf option == BodyOID
		SetInfoText("$Enable_Body_Description")
	elseIf option == DrunkOID
		SetInfoText("$Enable_Drunk_Description")
	elseIf option == intervalBodyOID
		SetInfoText("$Body_Interval_Description")
	elseIf option == ResetHungryValueOID
		SetInfoText("$Reset_BasicNeedsValues_Description")
	elseIf option == ResetThirstyValueOID
		SetInfoText("$Reset_BasicNeedsValues_Description")
	elseIf option == ResetSleepyValueOID
		SetInfoText("$Reset_BasicNeedsValues_Description")
	elseIf option == ResetBodyValueOID
		SetInfoText("$Reset_BasicNeedsValues_Description")
	elseIf option == ResetDrunkValueOID
		SetInfoText("$Reset_BasicNeedsValues_Description")
	elseIf option == CurrentHungryOID
		SetInfoText("$CurrentHungry_Description")
	elseIf option == CurrentThirstyOID
		SetInfoText("$CurrentThirsty_Description")
	elseIf option == CurrentSleepyOID
		SetInfoText("$CurrentSleepy_Description")
	elseIf option == CurrentBodyOID
		SetInfoText("$CurrentBody_Description")
	elseIf option == CurrentDrunkOID
		SetInfoText("$CurrentDrunk_Description")
	elseIf option == intHungryOID
		SetInfoText("$intHungry_Description")
	elseIf option == intThirstyOID
		SetInfoText("$intThirsty_Description")
	elseIf option == intSleepOID
		SetInfoText("$intSleep_Description")
	elseIf option == intDrunkOID
		SetInfoText("$intDrunk_Description")
	elseIf option == intBodyOID
		SetInfoText("$intBody_Description")
	elseIf option == magHungryOID
		SetInfoText("$magHungry_Description")
	elseIf option == magThirstyOID
		SetInfoText("$magThirsty_Description")
	elseIf option == shortSleeperOID
		SetInfoText("$ShortSleeper_Description")
	elseIf option == DirtyBodyOID
		SetInfoText("$DirtyBody_Description")
	elseIf option == HungryGrowlOID
		SetInfoText("$HungryGrowl_Description")
	elseIf option == ExpressionOID
		SetInfoText("$Expression_Description")
	elseIf option == GetBookOID
		SetInfoText("$SuvivalTextBook_Description")
	elseIf option == ResolveModBedOID
		SetInfoText("$ResolveModBed_Description")
	elseIf option == IsLimitDamageHungryOID
		SetInfoText("$LimitDamageHungry_Description")
	elseIf option == IsLimitDamageThirstyOID
		SetInfoText("$LimitDamageThirsty_Description")
	elseIf option == damageHungryLimitValOID
		SetInfoText("$LimitDamageHungryValue_Description")
	elseIf option == damageThirstyLimitValOID
		SetInfoText("$LimitDamageThirstyValue_Description")
	elseIf option == damageHungryLimitMagOID
		SetInfoText("$LimitDamageHungryMaginitude_Description")
	elseIf option == damageThirstyLimitMagOID
		SetInfoText("$LimitDamageThirstyMaginitude_Description")
	elseIf option == KNNCurrentStutasOID
		SetInfoText("$Output_KNN_Stutas_Description")
	elseIf option == HardOID
		SetInfoText("$BasicNeedsHard_Description")
	elseIf option == CurrentCharacterSlotOID
		SetInfoText("$SlotMask_Description")
	elseIf option == DieOID
		SetInfoText("$Die_Description")
	elseIf option == PCGenderOID
		SetInfoText("$PCGender_Description")
	elseIf option == IsPOVOID
		SetInfoText("$EnablePOV_Description")
	elseIf option == IsShieldUnequipOID
		SetInfoText("$Ctrl_Shield_Description")
	elseIf option == IsCameraAnimatedOID
		SetInfoText("$Ctrl_CameraAimated_Description")
	elseIf option == CreateXMLOID
		SetInfoText("$CreateXML_Description")
	elseIf option == HipBagOID
		SetInfoText("$HipbagHotkey_Description")
	elseIf option == JurnalOID
		SetInfoText("$JurnalHotkey_Description")
	elseIf option == MsgOID
		SetInfoText("$ShowMessage_Description")
	elseIf option == SellBottleOID
		SetInfoText("$SellBottle_Description")
	elseIf option == SellTowelPotionOID
		SetInfoText("$SellTowelPotion_Description")
	elseIf option == WaterBarrelOID
		SetInfoText("$WaterBarrel_Description")
	elseIf option == convertEmptyBottleOID
		SetInfoText("$Convert_Empty_Bottle_Description")
	elseIf option == NeedTundraCottnOID
		SetInfoText("$TrundraCotton_Amount_Description")
	elseIf option == WidgetHotkeyOID
		SetInfoText("$WidgetHotkey_Description")
	elseIf option == IsActiAmiQLOID
		SetInfoText("$QLAnim_Description")
	elseIf option == QuiverOID
		SetInfoText("$UnequipQuiver_Description")
	elseIf option == StumbleOID
		SetInfoText("$Enable_Stumble_Description")
	elseIf option == PUFOODOID
		SetInfoText("$FoodWeightPriority_Description")
	elseIf option == IdleAnimOID
		SetInfoText("$IdleAnimHotkey_Description")	
	elseIf option == HTPriorityOID
		SetInfoText("$Priority_Mode_Description")
	elseIf option == HTIntervalOID
		SetInfoText("$Update_Interval_Description")
	elseIf option == NextHTIntervalOID
		SetInfoText("$NextHT_Interval_Description")
	elseIf option == IsExpressionChangeExtensionOID
		SetInfoText("$Expression_extension_Description")
	elseIf option == IsEyeTrackingOID
		SetInfoText("$EyeTracking_Description")
	elseIf option == IsIdleAnimOID
		SetInfoText("$Enable_Idle_Anim_Description")
	elseIf option == UpdateNoLookObjOID
		SetInfoText("$UpdateNoLookObj_Description")	
	elseIf option == HorizontalRangeMaxOID || option == HorizontalRangeMinOID
		SetInfoText("$HorizontalRange_Description")
	elseIf option == HorizontalPowerMaxOID || option == HorizontalPowerMinOID
		SetInfoText("$HorizontalPower_Description")
	elseIf option == VerticalRangeMaxOID || option == VerticalRangeMinOID
		SetInfoText("$VerticalRange_Description")
	elseIf option == VerticalPowerMaxOID || option == VerticalPowerMinOID
		SetInfoText("$VerticalPower_Description")
	elseIf option == IsNotHTWeaponDrawnOID
		SetInfoText("$DisabledHTWeaponDrawn_Description")
	elseIf option == SaveMCMSettingsOID
		SetInfoText("$SaveMCMSettings_Description")
	elseIf option == LoadMCMSettingsOID
		SetInfoText("$LoadMCMSettings_Description")
	elseIf option == ExportAllFoodListOID
		SetInfoText("$ExportAllFoodList_Description")
	elseIf option == ImportAllFoodListOID
		SetInfoText("$ImportAllFoodList_Description")
	elseIf 0 < HTFormsOID.Length && Option == HTFormsOID[6]
		SetInfoText("$Misc_Settings_Description")
	elseIf option == FoodsTimeOID || option == DrinksTimeOID
		SetInfoText("$MealTimePerDays_Description")
	else
		int i = 0
		while i < mealAnimOID.Length
			if option == mealAnimOID[i]
				SetInfoText(mealAnimDisc[i])
				return
			endIf
			i += 1
		endWhile

		i = 0
		while i < PerksDescOID.Length
			if option == PerksOID[i]
				SetInfoText(PerksDescOID[i])
				return
			endIf
			i += 1
		endWhile

		i = 0
		while i < slotsOID.Length
			if option == slotsOID[i]
				SetInfoText("$SlotMask_Description")
				return
			endIf
			i += 1
		endWhile
		
		i = 0
		while i < QLAnimsOID.Length
			if option == QLAnimsOID[i]
				SetInfoText(QLDescOID[i])
				return
			endIf
			i += 1
		endWhile

		i = 0
		while i < FoodTypeListOID.Length
			if option == FoodTypeListOID[i]
				if 0 == i
					SetInfoText("$ClearedFoodList_Description")
				else
					SetInfoText("$ClearedList_Description")
				endIf
				return
			endIf
			i += 1
		endwhile

		i = 0
		while i < HTExBasicOID.Length
			if option == HTExBasicOID[i]
				if 0 == i
					SetInfoText("$General_Settings_Description")
				elseIf 1 == i
					SetInfoText("$Pursued_Settings_Description")
				elseIf 2 == i
					SetInfoText("$Alerted_Settings_Description")
				elseIf 3 == i
					SetInfoText("$AlertedShout_Settings_Description")
				endIf
				return
			endIf
			i += 1
		endWhile

		i = 0
		while i < HTExValActorsOID.Length
			if option == HTExValActorsOID[i]
				SetInfoText(ExValActorsDesc[i])
				return
			endIf
			i += 1
		endwhile

		i = 0
		while i < HTExFormsOID.Length
			if option == HTExFormsOID[i]
				SetInfoText("$General_Settings_Description")
				return
			endIf
			i += 1
		endwhile

		i = 0
		while i < followerOID.Length
			if option == followerOID[i]
				if aaaKNNFollowerFillWater == followerValOID[i]
					SetInfoText("$Follower_FillWater_Description")
				elseIf aaaKNNFollowerWashBody == followerValOID[i]
					SetInfoText("$Follower_WashBody_Description")
				elseIf aaaKNNFollowerPlaySleeping == followerValOID[i]
					SetInfoText("$Follower_Sleep_Description")
				elseIf aaaKNNFollowerPlayMeal == followerValOID[i]
					SetInfoText("$Follower_Meal_Description")
				elseIf aaaKNNIsEnableFollowerDirtyBodyEffect == followerValOID[i]
					SetInfoText("$Follower_DirtyBodyEffect_Description")
				elseIf _EnabledAlwaysFollowerAnimActivation == followerValOID[i]
					SetInfoText("$Follower_AlwaysPlayActiAnim_Description")
				else
					SetInfoText("$FollowerAnim_Description")
				endIf
				return
			endIf
			i += 1
		endWhile
	endIf
EndEvent

Event OnOptionKeyMapChange(Int Option, Int KeyCode, String ConflictControl, String ConflictName)	
	if ConflictControl == ""
		;ShowMessage(ConflictName, false)
		if option == HipBagOID && !IsConflictKeycode(Option, KeyCode)
			aaaKNNHotkeyHipBag.SetValueInt(KeyCode)
			SetKeyMapOptionValue(HipBagOID, KeyCode)
		elseIf option == JurnalOID && !IsConflictKeycode(Option, KeyCode)
			GoToState("READY")
			aaaKNNHotkeyJurnal.SetValueInt(KeyCode)
			SetKeyMapOptionValue(JurnalOID, KeyCode)
		elseIf option == WidgetHotkeyOID && !IsConflictKeycode(Option, KeyCode)
			aaaKNNHotkeyWidget.SetValueInt(KeyCode)
			SetKeyMapOptionValue(WidgetHotkeyOID, KeyCode)
		elseIf option == FOODOID && !IsConflictKeycode(Option, KeyCode)
			aaaKNNHotkeyFoods.SetValueInt(KeyCode)
			SetKeyMapOptionValue(FOODOID, KeyCode)
		elseIf option == DRINKOID && !IsConflictKeycode(Option, KeyCode)
			aaaKNNHotkeyDrinks.SetValueInt(KeyCode)
			SetKeyMapOptionValue(DRINKOID, KeyCode)
		elseIf option == CUSTOMOID && !IsConflictKeycode(Option, KeyCode)
			aaaKNNHotkeyCustom.SetValueInt(KeyCode)
			SetKeyMapOptionValue(CUSTOMOID, KeyCode)
		elseIf option == IdleAnimOID && !IsConflictKeycode(Option, KeyCode)
			GoToState("READY")
			aaaKNNHotkeyIdleAnim.SetValueInt(KeyCode)
			SetKeyMapOptionValue(IdleAnimOID, KeyCode)		
		else
			ShowMessage("$HotkeyConflictKeyOtherFunction", false)
			return
		endIf
	elseIf ConflictControl == "pause"
		if option == HipBagOID
			if aaaKNNHotkeyHipBag.GetValueInt() != -1
				aaaKNNHotkeyHipBag.SetValueInt(-1)
				SetKeyMapOptionValue(HipBagOID, -1)
			endIf
		elseIf option == JurnalOID
			if aaaKNNHotkeyJurnal.GetValueInt() != -1
				GoToState("READY")
				aaaKNNHotkeyJurnal.SetValueInt(-1)
				SetKeyMapOptionValue(JurnalOID, -1)
			endIf
		elseIf option == WidgetHotkeyOID
			if aaaKNNHotkeyWidget.GetValueInt() != -1
				aaaKNNHotkeyWidget.SetValueInt(-1)
				SetKeyMapOptionValue(WidgetHotkeyOID, -1)
			endIf		
		elseIf option == FOODOID
			if aaaKNNHotkeyFoods.GetValueInt() != -1
				aaaKNNHotkeyFoods.SetValueInt(-1)
				SetKeyMapOptionValue(FOODOID, -1)
			endIf
		elseIf option == DRINKOID
			if aaaKNNHotkeyDrinks.GetValueInt() != -1
				aaaKNNHotkeyDrinks.SetValueInt(-1)
				SetKeyMapOptionValue(DRINKOID, -1)
			endIf
		elseIf option == CUSTOMOID
			if aaaKNNHotkeyCustom.GetValueInt() != -1
				aaaKNNHotkeyCustom.SetValueInt(-1)
				SetKeyMapOptionValue(CUSTOMOID, -1)
			endIf
		elseIf option == IdleAnimOID
			if aaaKNNHotkeyIdleAnim.GetValueInt() != -1
				GoToState("READY")
				aaaKNNHotkeyIdleAnim.SetValueInt(-1)
				SetKeyMapOptionValue(IdleAnimOID, -1)
			endIf		
		endIf
	endIf
EndEvent

bool Function IsConflictKeycode(int Option, Int KeyCode)
	if !KeyCode
		return true
	endIf
	int[] OID = new int[6]
	OID[0] = HipBagOID
	OID[1] = JurnalOID
	OID[2] = WidgetHotkeyOID
	OID[3] = FOODOID
	OID[4] = DRINKOID
	OID[5] = IdleAnimOID
	GlobalVariable[] VAL = new GlobalVariable[6]
	VAL[0] = aaaKNNHotkeyHipBag
	VAL[1] = aaaKNNHotkeyJurnal
	VAL[2] = aaaKNNHotkeyWidget
	VAL[3] = aaaKNNHotkeyFoods
	VAL[4] = aaaKNNHotkeyDrinks
	VAL[5] = aaaKNNHotkeyIdleAnim
	int arraySize = OID.Length
	while arraySize > 0
		arraySize -= 1
		if option != OID[arraySize] && VAL[arraySize].GetValueInt() && KeyCode == VAL[arraySize].GetValueInt()
			return true
		endIf
	endWhile
	return false
EndFunction

String Function GetPCGender(Int SavedIndex)
	if 0 != SavedIndex
		return "$FemalePC"
	endIf
	return "$MalePC"
EndFunction

String Function GetFunctionState(Int SavedIndex)
	if 0 != SavedIndex
		return "$function_enable"
	endIf
	return "$function_disable"
EndFunction

String Function GetShieldCtrl(Int SavedIndex)
	if 1 == SavedIndex
		return "$Only_Unequipped"
	elseIf 2 == SavedIndex
		return "$Unequipped_And_Equipped"
	endIf
	return "$function_disable"
EndFunction

String Function GetStaminaPenaltyState(Int SavedIndex)
	if SavedIndex == 1
		return "$State_Hard"
	elseIf SavedIndex == 2
		return "$State_Legendary"
	endIf
	return "$function_disable"
EndFunction

String Function GetPotionEffectState(Int SavedIndex)
	if SavedIndex == 1
		return "$Priority_HighEffect"
	endIf
	return "$Priority_LowEffect"
EndFunction

String Function GetFoodEffectState(Int SavedIndex)
	if SavedIndex == 0
		return "$Priority_Light"
	elseIf SavedIndex == 1
		return "$Priority_Heavy"
	endIf
	return "$Priority_Recommended"
EndFunction

String Function GetDrinkEffectState(Int SavedIndex)
	if SavedIndex == 0
		return "$Priority_Light"
	elseIf SavedIndex == 1
		return "$Priority_Heavy"
	elseIf SavedIndex == 2
		return "$Priority_Few"
	elseIf SavedIndex == 3
		return "$Priority_Large"
	endIf
	return "$Priority_Random"
EndFunction

String Function GetPotionPriorityState(Int SavedIndex)
	if SavedIndex == 1
		return "$PrioriyVanilla"
	elseIf SavedIndex == 2
		return "$PrioriyMod"
	endIf
	return "$PriorityNothing"
EndFunction

String Function GetPotionDrinkTypeState(Int SavedIndex)
	if SavedIndex == 1
		return "$PrioriyWater"
	elseIf SavedIndex == 2
		return "$PriorityAlchol"
	endIf
	return "$PriorityNothing"
EndFunction

String Function GetExpressionState(Int SavedIndex)
	if SavedIndex == 1
		return "$TypeDefault"
	elseIf SavedIndex == 2
		return "$TypeDefaultExtend"
	endIf
	return "$TypeNothing"
EndFunction

String Function GetDamageBasicneedState(Int SavedIndex)
	if SavedIndex == 1
		return "$EnableLimit"
	elseIf SavedIndex == 2
		return "$function_disable"
	endIf
	return "$DisableLimit"
EndFunction

String Function GetEquipSpellState(Int SavedIndex)
	if SavedIndex == 1
		return "$RightHand"
	elseIf SavedIndex == 2
		return "$LeftHand"
	endIf
	return "$BothHands"
EndFunction

String Function GetExpressionType(Int SavedIndex)
	if SavedIndex == 0
		return "Dialogue Anger"
	elseIf SavedIndex == 1
		return "Dialogue Fear"
	elseIf SavedIndex == 2
		return "Dialogue Happy"
	elseIf SavedIndex == 3
		return "Dialogue Sad"
	elseIf SavedIndex == 4
		return "Dialogue Surprise"
	elseIf SavedIndex == 5
		return "Dialogue Puzzled"
	elseIf SavedIndex == 6
		return "Dialogue Disgusted"
	elseIf SavedIndex == 7
		return "Mood Neutral"
	elseIf SavedIndex == 8
		return "Mood Anger"
	elseIf SavedIndex == 9
		return "Mood Fear"
	elseIf SavedIndex == 10
		return "Mood Happy"
	elseIf SavedIndex == 11
		return "Mood Sad"
	elseIf SavedIndex == 12
		return "Mood Surprise"
	elseIf SavedIndex == 13
		return "Mood Puzzled"
	elseIf SavedIndex == 14
		return "Mood Disgusted"
	elseIf SavedIndex == 15
		return "Combat Anger"
	elseIf SavedIndex == 16
		return "Combat Shout"
	endIf
	return "Custom"
EndFunction

String Function GetHTPriority(Int SavedIndex)
	if SavedIndex == 1
		return "Speaker + HUD"
	elseIf SavedIndex == 2
		return "Only Speaker"
	endIf
	return "Only HUD"
EndFunction

String Function GetCurrentSlots(int SavedIndex)
	if 1 == SavedIndex
		return "$Female_Followers_Bathing"
	elseIf 2 == SavedIndex
		return "$Male_Followers_Bathing"
	elseIf 3 == SavedIndex
		return "$Player_Character_Sleeping"
	endIf
	return "$Player_Character_Bathing"
EndFunction

String Function GetXMLPath(int SavedIndex)
	if 1 == SavedIndex
		return "EatingSleepingDrinking\\backup\\FemaleFollowersWashBodySlot.xml"
	elseIf 2 == SavedIndex
		return "EatingSleepingDrinking\\backup\\MaleFollowersWashBodySlot.xml"
	elseIf 3 == SavedIndex
		return "EatingSleepingDrinking\\backup\\PlayerSleepSlot.xml"
	endIf
	return "EatingSleepingDrinking\\backup\\PlayerWashBodySlot.xml"
EndFunction

;removeType:
int ABILITY_ALL = 0
int ABILITY_HUNGRY = 1
int ABILITY_THIRSTY = 2
int ABILITY_SLEEPY = 3
int ABILITY_BODY = 4
int ABILITY_DRUNK = 5
int ABILITY_HARD = 6
int ABILITY_LEGENDARY = 7
Function RemoveAbility(int removeType = 0)
	Actor player  = Game.GetPlayer()
	if removeType == ABILITY_ALL
		player.RemoveSpell(aaaKNNBasicNeedsHungrySpell)
		player.RemoveSpell(aaaKNNBasicNeedsThirstySpell)
		player.RemoveSpell(aaaKNNBasicNeedsSleepySpell)
		player.RemoveSpell(aaaKNNBasicNeedsBodySpell)
		player.DispelSpell(aaaKNNBasicNeedsHungryDurationSpell)
		player.DispelSpell(aaaKNNBasicNeedsThirstyDurationSpell)
		player.DispelSpell(aaaKNNBasicNeedsSleepyDurationSpell)
		player.DispelSpell(aaaKNNBasicNeedsBodyDurationSpell)
		player.RemoveSpell(aaaKNNDirtyBodySpell01)
		player.RemoveSpell(aaaKNNDirtyBodySpell02)
		player.RemoveSpell(aaaKNNDirtyBodySpell03)
		player.RemoveSpell(aaaKNNVisualDrunkSpell)
	elseIf removeType == ABILITY_HUNGRY
		player.RemoveSpell(aaaKNNBasicNeedsHungrySpell)
		player.DispelSpell(aaaKNNBasicNeedsHungryDurationSpell)
	elseIf removeType == ABILITY_THIRSTY
		player.RemoveSpell(aaaKNNBasicNeedsThirstySpell)
		player.DispelSpell(aaaKNNBasicNeedsThirstyDurationSpell)
	elseIf removeType == ABILITY_SLEEPY
		player.RemoveSpell(aaaKNNBasicNeedsSleepySpell)
		player.DispelSpell(aaaKNNBasicNeedsSleepyDurationSpell)
	elseIf removeType == ABILITY_BODY
		player.RemoveSpell(aaaKNNDirtyBodySpell01)
		player.RemoveSpell(aaaKNNDirtyBodySpell02)
		player.RemoveSpell(aaaKNNDirtyBodySpell03)
		Actor follower = KNNPlugin_Utility.GetAliasFollower()
		if follower
			follower.RemoveSpell(aaaKNNDirtyBodySpell01)
			follower.RemoveSpell(aaaKNNDirtyBodySpell02)
			follower.RemoveSpell(aaaKNNDirtyBodySpell03)
		endIf
	elseIf removeType == ABILITY_DRUNK
		player.RemoveSpell(aaaKNNVisualDrunkSpell)
	elseIf removeType == ABILITY_HARD
		player.RemoveSpell(aaaKNNBasicNeedsHardStaminaSpell)
	elseIf removeType == ABILITY_LEGENDARY
		player.RemoveSpell(aaaKNNBasicNeedsLegendaryStaminaSpell)
	endIf
EndFunction

Function RemoveActivateAnimPerk()
	Actor player = Game.GetPlayer()
	if player	
		player.RemovePerk(aaaKNNPerkLootAnimal)
		player.RemovePerk(aaaKNNPerkLootHumanOther)
		player.RemovePerk(aaaKNNPerkMiscContainer)
		player.RemovePerk(aaaKNNPerkChest)
		player.RemovePerk(aaaKNNPerkBarrel)
		player.RemovePerk(aaaKNNPerkWardrobe)
		player.RemovePerk(aaaKNNPerkSack)
		player.RemovePerk(aaaKNNPerkCupBoard)
		player.RemovePerk(aaaKNNPerkEndTable)
	endIf
EndFunction

bool Function IsEnableGrowl(int ObjectID)
	if ObjectID == HungryOID
		if aaaKNNIsEnableThirsty.GetValueInt() == 0 && aaaKNNIsEnableSleepiness.GetValueInt() == 0 && aaaKNNIsEnableBodyHealth.GetValueInt() == 0
			return false
		endIf
	elseIf ObjectID == ThirstyOID
		if aaaKNNIsEnableHungry.GetValueInt() == 0 && aaaKNNIsEnableSleepiness.GetValueInt() == 0 && aaaKNNIsEnableBodyHealth.GetValueInt() == 0
			return false
		endIf
	elseIf ObjectID == SleepOID
		if aaaKNNIsEnableHungry.GetValueInt() == 0 && aaaKNNIsEnableThirsty.GetValueInt() == 0 && aaaKNNIsEnableBodyHealth.GetValueInt() == 0
			return false
		endIf
	elseIf ObjectID == BodyOID
		if aaaKNNIsEnableHungry.GetValueInt() == 0 && aaaKNNIsEnableThirsty.GetValueInt() == 0 && aaaKNNIsEnableSleepiness.GetValueInt() == 0
			return false
		endIf
	endIf
	return true
EndFunction

int iACTO = -1
int iACTO_P0 = 0
int iACTO_P1 = 1
int iACTO_P2 = 2
int iACTO_P3 = 3
int iACTO_N0 = 4
int iACTO_N1 = 5
int iACTO_N2 = 6
int iACTO_N3 = 7
int iCONT = 8
int iFOOD = 9
int iPOTI = 10
int iWEAP = 11
int iARMO = 12
int iBOOK = 13
int iMISC = 14
int iFURN = 15
int iINGR = 16
int iACTI = 17
int iFLOR = 18
int iCOMB = 19
int iALERT = 20
int iPURSUE = 21
int iALERTSHOUT = 22
int iACTO_PREY = 23
int Function GetFlag(int HeadtrackingTarget, bool IsToggle)
	int IsEnableHT = aaaKNNIsHT.GetValueInt()
	int IsEnableExpression = aaaKNNIsEnableExpression.GetValueInt()
	if HeadtrackingTarget == iACTO
		if IsEnableHT != 1 || !IsEnableExpression
			;Debug.Trace("IsEnableHT != 1 || !IsEnableExpression")
			return 1
		elseIf aaaKNNHTPriority.GetValueInt() == 0
			;Debug.Trace("aaaKNNHTPriority.GetValueInt() == 0")
			return 1
		elseIf !IsToggle && aaaKNNIsHTActor.GetValueInt() == 0
			;Debug.Trace("!IsToggle && aaaKNNIsHTActor.GetValueInt() == 0")
			return 1
		endIf
		return 0
	elseIf HeadtrackingTarget == iACTO_P0
		if IsEnableHT != 1 || !IsEnableExpression
			return 1
		elseIf aaaKNNHTPriority.GetValueInt() == 0
			return 1
		elseIf !IsToggle && aaaKNNIsHTActor.GetValueInt() == 0
			return 1
		elseIf !IsToggle && (HTExActorGV.GetAt(0) as GlobalVariable).GetValueInt() == 17
			return 1
		endIf
		return 0
	elseIf HeadtrackingTarget == iACTO_P1
		if IsEnableHT != 1 || !IsEnableExpression
			return 1
		elseIf aaaKNNHTPriority.GetValueInt() == 0
			return 1
		elseIf !IsToggle && aaaKNNIsHTActor.GetValueInt() == 0
			return 1
		elseIf !IsToggle && (HTExActorGV.GetAt(1) as GlobalVariable).GetValueInt() == 17
			return 1
		endIf
		return 0
	elseIf HeadtrackingTarget == iACTO_P2
		if IsEnableHT != 1 || !IsEnableExpression
			return 1
		elseIf aaaKNNHTPriority.GetValueInt() == 0
			return 1
		elseIf !IsToggle && aaaKNNIsHTActor.GetValueInt() == 0
			return 1
		elseIf !IsToggle && (HTExActorGV.GetAt(2) as GlobalVariable).GetValueInt() == 17
			return 1
		endIf
		return 0
	elseIf HeadtrackingTarget == iACTO_P3
		if IsEnableHT != 1 || !IsEnableExpression
			return 1
		elseIf aaaKNNHTPriority.GetValueInt() == 0
			return 1
		elseIf !IsToggle && aaaKNNIsHTActor.GetValueInt() == 0
			return 1
		elseIf !IsToggle && (HTExActorGV.GetAt(3) as GlobalVariable).GetValueInt() == 17
			return 1
		endIf
		return 0
	elseIf HeadtrackingTarget == iACTO_N0
		if IsEnableHT != 1 || !IsEnableExpression
			return 1
		elseIf aaaKNNHTPriority.GetValueInt() == 0
			return 1
		elseIf !IsToggle && aaaKNNIsHTActor.GetValueInt() == 0
			return 1
		elseIf !IsToggle && (HTExActorGV.GetAt(4) as GlobalVariable).GetValueInt() == 17
			return 1
		endIf
		return 0
	elseIf HeadtrackingTarget == iACTO_N1
		if IsEnableHT != 1 || !IsEnableExpression
			return 1
		elseIf aaaKNNHTPriority.GetValueInt() == 0
			return 1
		elseIf !IsToggle && aaaKNNIsHTActor.GetValueInt() == 0
			return 1
		elseIf !IsToggle && (HTExActorGV.GetAt(5) as GlobalVariable).GetValueInt() == 17
			return 1
		endIf
		return 0
	elseIf HeadtrackingTarget == iACTO_N2
		if IsEnableHT != 1 || !IsEnableExpression
			return 1
		elseIf aaaKNNHTPriority.GetValueInt() == 0
			return 1
		elseIf !IsToggle && aaaKNNIsHTActor.GetValueInt() == 0
			return 1
		elseIf !IsToggle && (HTExActorGV.GetAt(6) as GlobalVariable).GetValueInt() == 17
			return 1
		endIf
		return 0
	elseIf HeadtrackingTarget == iACTO_N3
		if IsEnableHT != 1 || !IsEnableExpression
			return 1
		elseIf aaaKNNHTPriority.GetValueInt() == 0
			return 1
		elseIf !IsToggle && aaaKNNIsHTActor.GetValueInt() == 0
			return 1
		elseIf !IsToggle && (HTExActorGV.GetAt(7) as GlobalVariable).GetValueInt() == 17
			return 1
		endIf
		return 0
	elseIf HeadtrackingTarget == iACTO_PREY
		if IsEnableHT != 1 || !IsEnableExpression
			return 1
		elseIf aaaKNNHTPriority.GetValueInt() == 0
			return 1
		elseIf !IsToggle && aaaKNNIsHTActor.GetValueInt() == 0
			return 1
		elseIf !IsToggle && (HTExActorGV.GetAt(8) as GlobalVariable).GetValueInt() == 17
			return 1
		endIf
		return 0
	elseIf HeadtrackingTarget == iCONT
		if IsEnableHT != 1 || !IsEnableExpression
			return 1
		elseIf aaaKNNHTPriority.GetValueInt() == 3
			return 1
		elseIf !IsToggle && (HTFormGV.GetAt(0) as GlobalVariable).GetValueInt() == 0
			return 1
		elseIf !IsToggle && (HTFormGV.GetAt(0) as GlobalVariable).GetValueInt() == 17
			return 1
		endIf
		return 0
	elseIf HeadtrackingTarget == iFOOD
		if IsEnableHT != 1 || !IsEnableExpression
			return 1
		elseIf aaaKNNHTPriority.GetValueInt() == 3
			return 1
		elseIf !IsToggle && (HTFormGV.GetAt(1) as GlobalVariable).GetValueInt() == 0
			return 1
		elseIf !IsToggle && (HTFormGV.GetAt(1) as GlobalVariable).GetValueInt() == 17
			return 1
		endIf
		return 0
	elseIf HeadtrackingTarget == iPOTI
		if IsEnableHT != 1 || !IsEnableExpression
			return 1
		elseIf aaaKNNHTPriority.GetValueInt() == 3
			return 1
		elseIf !IsToggle && (HTFormGV.GetAt(2) as GlobalVariable).GetValueInt() == 0
			return 1
		elseIf !IsToggle && (HTFormGV.GetAt(2) as GlobalVariable).GetValueInt() == 17
			return 1
		endIf
		return 0
	elseIf HeadtrackingTarget == iWEAP
		if IsEnableHT != 1 || !IsEnableExpression
			return 1
		elseIf aaaKNNHTPriority.GetValueInt() == 3
			return 1
		elseIf !IsToggle && (HTFormGV.GetAt(3) as GlobalVariable).GetValueInt() == 0
			return 1
		elseIf !IsToggle && (HTFormGV.GetAt(3) as GlobalVariable).GetValueInt() == 17
			return 1
		endIf
		return 0
	elseIf HeadtrackingTarget == iARMO
		if IsEnableHT != 1 || !IsEnableExpression
			return 1
		elseIf aaaKNNHTPriority.GetValueInt() == 3
			return 1
		elseIf !IsToggle && (HTFormGV.GetAt(4) as GlobalVariable).GetValueInt() == 0
			return 1
		elseIf !IsToggle && (HTFormGV.GetAt(4) as GlobalVariable).GetValueInt() == 17
			return 1
		endIf
		return 0
	elseIf HeadtrackingTarget == iBOOK
		if IsEnableHT != 1 || !IsEnableExpression
			return 1
		elseIf aaaKNNHTPriority.GetValueInt() == 3
			return 1
		elseIf !IsToggle && (HTFormGV.GetAt(5) as GlobalVariable).GetValueInt() == 0
			return 1
		elseIf !IsToggle && (HTFormGV.GetAt(5) as GlobalVariable).GetValueInt() == 17
			return 1
		endIf
		return 0
	elseIf HeadtrackingTarget == iMISC
		if IsEnableHT != 1 || !IsEnableExpression
			return 1
		elseIf aaaKNNHTPriority.GetValueInt() == 3
			return 1
		elseIf !IsToggle && (HTFormGV.GetAt(6) as GlobalVariable).GetValueInt() == 0
			return 1
		elseIf !IsToggle && (HTFormGV.GetAt(6) as GlobalVariable).GetValueInt() == 17
			return 1
		endIf
		return 0	
	elseIf HeadtrackingTarget == iFURN
		if IsEnableHT != 1 || !IsEnableExpression
			return 1
		elseIf aaaKNNHTPriority.GetValueInt() == 3
			return 1
		elseIf !IsToggle && (HTFormGV.GetAt(7) as GlobalVariable).GetValueInt() == 0
			return 1
		elseIf !IsToggle && (HTFormGV.GetAt(7) as GlobalVariable).GetValueInt() == 17
			return 1
		endIf
		return 0
	elseIf HeadtrackingTarget == iINGR
		if IsEnableHT != 1 || !IsEnableExpression
			return 1
		elseIf aaaKNNHTPriority.GetValueInt() == 3
			return 1
		elseIf !IsToggle && (HTFormGV.GetAt(8) as GlobalVariable).GetValueInt() == 0
			return 1
		elseIf !IsToggle && (HTFormGV.GetAt(8) as GlobalVariable).GetValueInt() == 17
			return 1
		endIf
		return 0
	elseIf HeadtrackingTarget == iACTI
		if IsEnableHT != 1 || !IsEnableExpression
			return 1
		elseIf aaaKNNHTPriority.GetValueInt() == 3
			return 1
		elseIf !IsToggle && (HTFormGV.GetAt(9) as GlobalVariable).GetValueInt() == 0
			return 1
		elseIf !IsToggle && (HTFormGV.GetAt(9) as GlobalVariable).GetValueInt() == 17
			return 1
		endIf
		return 0
	elseIf HeadtrackingTarget == iFLOR
		if IsEnableHT != 1 || !IsEnableExpression
			return 1
		elseIf aaaKNNHTPriority.GetValueInt() == 3
			return 1
		elseIf !IsToggle && (HTFormGV.GetAt(10) as GlobalVariable).GetValueInt() == 0
			return 1
		elseIf !IsToggle && (HTFormGV.GetAt(10) as GlobalVariable).GetValueInt() == 17
			return 1
		endIf
		return 0
	elseIf HeadtrackingTarget == iCOMB
		if IsEnableHT != 1 || !IsEnableExpression
			return 1
		elseIf !IsToggle && (HTExBasicGv.GetAt(0) as GlobalVariable).GetValueInt() == 17
			return 1
		endIf
		return 0
	elseIf HeadtrackingTarget == iALERT
		if 1 != IsEnableHT || !IsEnableExpression
			return 1
		elseIf 0 == aaaKNNIsExpressionChangeExtension.GetValueInt()
			return 1
		elseIf !IsToggle && (HTExBasicGv.GetAt(2) as GlobalVariable).GetValueInt() == 17
			return 1
		endIf
		return 0
	elseIf HeadtrackingTarget == iPURSUE
		if 1 != IsEnableHT || !IsEnableExpression
			return 1
		elseIf 0 == aaaKNNIsExpressionChangeExtension.GetValueInt()
			return 1
		elseIf !IsToggle && (HTExBasicGv.GetAt(1) as GlobalVariable).GetValueInt() == 17
			return 1
		endIf
		return 0
	elseIf HeadtrackingTarget == iALERTSHOUT
		if 1 != IsEnableHT || !IsEnableExpression
			return 1
		elseIf 0 == aaaKNNIsExpressionChangeExtension.GetValueInt()
			return 1
		elseIf !IsToggle && (HTExBasicGv.GetAt(3) as GlobalVariable).GetValueInt() == 17
			return 1
		endIf
		return 0
	endIf
	return 1
EndFunction

bool Function IsResetFollowerMealToggle()
	if 0 == aaaAnimEatFoodStanding.GetValueInt() && 0 == aaaAnimEatFoodSitting.GetValueInt() && 0 == aaaAnimEatSoupStanding.GetValueInt() && 0 == aaaAnimEatSoupSitting.GetValueInt() && 0 == aaaAnimDrinkStanding.GetValueInt() && 0 == aaaAnimDrinkSitting.GetValueInt()
		if 0 != aaaKNNFollowerPlayMeal.GetValueInt()
			aaaKNNFollowerPlayMeal.SetValueInt(0)
			(AnimCtrlQuest as aaaKNNPlayMealAnimQuest).SetFollowerMealAnimEvent(0)
			return true
		endIf
	endIf
	return false
EndFunction

int Function ListStringConvertToAnimType(int index)
	;int Property TYPE_WASHING_BODY 				= 1 	autoReadOnly
	;int Property TYPE_PEEPED_WASHING_BODY 		= 2 	autoReadOnly
	;int Property TYPE_REDING_BOOKS 				= 3 	autoReadOnly
	;int Property TYPE_TAKE_POTIONS 				= 4 	autoReadOnly
	;int Property TYPE_FORETASTE_INGREDIENTS 	= 5 	autoReadOnly
	;int Property TYPE_KNITTING_TOWELS 			= 6 	autoReadOnly
	;int Property TYPE_KEEP_JOURNAL 				= 7 	autoReadOnly
	;int Property TYPE_REGISTER_POTIONS 			= 8 	autoReadOnly
	;int Property TYPE_FILLED_WATER 				= 9 	autoReadOnly
	;int Property TYPE_IDLEMARKER_NOTFOUND 		= 10 	autoReadOnly
	;int Property TYPE_DRINKWATER_HANDS 			= 11 	autoReadOnly
	;int Property TYPE_ABSORB_DRAGONSOUL			= 12 	autoReadOnly
	;int Property TYPE_DRINKING_DRINKS			= 13 	autoReadOnly
	;int Property TYPE_DRINKING_DRINKS_MOVING	= 14 	autoReadOnly
	;int Property TYPE_DRINKING_DRINKS_SITTING	= 15 	autoReadOnly
	;int Property TYPE_EATING_FOODS				= 16 	autoReadOnly
	;int Property TYPE_EATING_FOODS_SITTING		= 17 	autoReadOnly
	;xmlList[0] = "$DoNothingNoHappen"
	;xmlList[1] = "$EatingStanding_xml"
	;xmlList[2] = "$EatingSitting_xml"
	;xmlList[3] = "$DrinkingStanding_xml"
	;xmlList[4] = "$DrinkingSitting_xml"
	;xmlList[5] = "$DrinkingRunning_xml"
	;xmlList[6] = "$TakingPotion_xml"
	;xmlList[7] = "$ForetasteIngredients_xml"
	;xmlList[8] = "$ReisterPotions_xml"
	;xmlList[9] = "$FillingWater Bottle_xml"
	;xmlList[10] = "$ReadingBook_xml"
	if 1 == index
		return (PreAnimQuest as _KNNPrePlayAnimationQuest).TYPE_EATING_FOODS
	elseIf 2 == index
		return (PreAnimQuest as _KNNPrePlayAnimationQuest).TYPE_EATING_FOODS_SITTING
	elseIf 3 == index
		return (PreAnimQuest as _KNNPrePlayAnimationQuest).TYPE_DRINKING_DRINKS
	elseIf 4 == index
		return (PreAnimQuest as _KNNPrePlayAnimationQuest).TYPE_DRINKING_DRINKS_SITTING
	elseIf 5 == index
		return (PreAnimQuest as _KNNPrePlayAnimationQuest).TYPE_DRINKING_DRINKS_MOVING
	elseIf 6 == index
		return (PreAnimQuest as _KNNPrePlayAnimationQuest).TYPE_TAKE_POTIONS
	elseIf 7 == index
		return (PreAnimQuest as _KNNPrePlayAnimationQuest).TYPE_FORETASTE_INGREDIENTS
	elseIf 8 == index
		return (PreAnimQuest as _KNNPrePlayAnimationQuest).TYPE_REGISTER_POTIONS
	elseIf 9 == index
		return (PreAnimQuest as _KNNPrePlayAnimationQuest).TYPE_REDING_BOOKS
	endIf
	return 0
EndFunction

;main
;aaaKNNAnimControlQuest Property animCtrl auto
Quest Property AnimCtrlQuest auto
GlobalVariable Property aaaKNNIsBasicNeedsEnable auto
GlobalVariable Property aaaKNNIsEnableHungry auto
GlobalVariable Property aaaKNNIsEnableThirsty auto
GlobalVariable Property aaaKNNIsEnableSleepiness auto
GlobalVariable Property aaaKNNIsEnableBodyHealth auto
GlobalVariable Property aaaKNNIsEnableDrunkness auto
GlobalVariable Property aaaKNNIntensityHungry auto
GlobalVariable Property aaaKNNIntensityThirsty auto
GlobalVariable Property aaaKNNIntensityDrunk auto
GlobalVariable Property aaaKNNIntensityBody auto
GlobalVariable Property aaaKNNIntensitySleep auto

GlobalVariable Property aaaKNNDamageMagnitudeHungry auto
GlobalVariable Property aaaKNNDamageMagnitudeThirsty auto
GlobalVariable Property aaaKNNShortSleeper auto

GlobalVariable Property aaaKNNIsLimitDamageHungry auto
GlobalVariable Property aaaKNNIsLimitDamageHungryValue auto
GlobalVariable Property aaaKNNIsLimitDamageHungryMag auto
GlobalVariable Property aaaKNNIsLimitDamageThirsty auto
GlobalVariable Property aaaKNNIsLimitDamageThirstyValue auto
GlobalVariable Property aaaKNNIsLimitDamageThirstyMag auto

GlobalVariable Property aaaKNNWashBodyInterval auto
GlobalVariable Property aaaKNNIsEnableHungryGrowl auto
GlobalVariable Property aaaKNNIsEnableDirtyBodyEffect auto
GlobalVariable Property aaaKNNIsEnableExpression auto
GlobalVariable Property aaaKNNIsEnableBasicNeedsHard auto
GlobalVariable Property aaaKNNIsEnableDie auto

GlobalVariable Property _KNNFoodsTimePerDay auto
GlobalVariable Property _KNNDrinksTimePerDay auto

int KNNCurrentStutasOID
int BNOID
int HungryOID
int ThirstyOID
int SleepOID
int BodyOID
int DrunkOID
int HardOID
int DieOID
int intHungryOID
int intThirstyOID
int intDrunkOID
int intBodyOID
int intSleepOID
int FoodsTimeOID
int DrinksTimeOID

int magHungryOID
int magThirstyOID
int shortSleeperOID

int IsLimitDamageHungryOID
int damageHungryLimitValOID
int damageHungryLimitMagOID
int IsLimitDamageThirstyOID
int damageThirstyLimitValOID
int damageThirstyLimitMagOID

int intervalBodyOID
int HungryGrowlOID
int DirtyBodyOID
int ExpressionOID
Spell Property aaaKNNDirtyBodySpell01 auto
Spell Property aaaKNNDirtyBodySpell02 auto
Spell Property aaaKNNDirtyBodySpell03 auto
Spell Property aaaKNNVisualDrunkSpell auto
Spell Property aaaKNNBasicNeedsHardStaminaSpell auto
Spell Property aaaKNNBasicNeedsLegendaryStaminaSpell auto
Spell Property aaaKNNBasicNeedsHungrySpell auto
Spell Property aaaKNNBasicNeedsThirstySpell auto
Spell Property aaaKNNBasicNeedsSleepySpell auto
Spell Property aaaKNNBasicNeedsBodySpell auto
Spell Property aaaKNNBasicNeedsHungryDurationSpell auto
Spell Property aaaKNNBasicNeedsThirstyDurationSpell auto
Spell Property aaaKNNBasicNeedsSleepyDurationSpell auto
Spell Property aaaKNNBasicNeedsBodyDurationSpell auto

int ResetHungryValueOID
int ResetThirstyValueOID
int ResetSleepyValueOID
int ResetBodyValueOID
int ResetDrunkValueOID
int CurrentHungryOID
int CurrentThirstyOID
int CurrentSleepyOID
int CurrentBodyOID
int CurrentDrunkOID
int WaterBarrelLocationsOID

;Anim general settings
Quest Property PreAnimQuest auto
Quest Property PerkAnimCtrlQuest auto
GlobalVariable Property aaaKNNIsEnablePOV auto
Globalvariable Property aaaKNNIsPCGenderFemale auto
Globalvariable Property aaaKNNIsShieldUnequip auto
GlobalVariable Property aaaKNNIsEnableCameraAnimated auto
int IsPOVOID
int PCGenderOID
int IsShieldUnequipOID
int IsCameraAnimatedOID

;Activation animation feature settings
Quest Property Campfire auto

FormList Property PerkList auto
Perk Property aaaKNNPerkGotoBed auto
Perk Property aaaKNNPerkPlants auto
Perk Property aaaKNNPerkCritters auto
Perk Property aaaKNNPerkPray auto
Perk Property aaaKNNPerkDoor auto
Perk Property aaaKNNPerkDoorLegacy auto
Perk Property aaaKNNPerkDoorBolt auto
Perk Property aaaKNNPerkLootAnimal auto
Perk Property aaaKNNPerkLootHumanOther auto
Perk Property aaaKNNPerkMiscContainer auto
Perk Property aaaKNNPerkChest auto
Perk Property aaaKNNPerkBarrel auto
Perk Property aaaKNNPerkWardrobe auto
Perk Property aaaKNNPerkSack auto
Perk Property aaaKNNPerkCupBoard auto
Perk Property aaaKNNPerkEndTable auto
Perk Property aaaKNNPerkTrapTrigger auto
Perk Property aaaKNNPerkPuzzlePillar auto
Perk Property aaaKNNPerkPuzzleWheel auto
Perk Property aaaKNNPullBar auto
Perk Property aaaKNNPullChain auto
Perk Property aaaKNNPerkCage auto
Perk Property aaaKNNPerkLever auto
Perk Property aaaKNNPerkBotton auto

int[] PerksOID
string[] PerksStrOID
string[] PerksDescOID

;QuickLoot Anim
GlobalVariable Property aaaKNNIsEnableQuickLootAnim auto
GlobalVariable Property aaaKNNQLAnimal auto
GlobalVariable Property aaaKNNQLHumanoid auto
GlobalVariable Property aaaKNNQLChest auto
GlobalVariable Property aaaKNNQLBarrel auto
GlobalVariable Property aaaKNNQLMiscContainer auto
GlobalVariable Property aaaKNNQLQWardrode auto
GlobalVariable Property aaaKNNQLSack auto
GlobalVariable Property aaaKNNQLCupBoard auto
GlobalVariable Property aaaKNNQLEndTable auto
int IsActiAmiQLOID

int[] QLAnimsOID
string[] QLStrOID
GlobalVariable[] QLValOID
string[] QLDescOID

;meal anim
GlobalVariable Property aaaAnimEatFoodStanding auto
GlobalVariable Property aaaAnimEatFoodSitting auto
GlobalVariable Property aaaAnimEatSoupStanding auto
GlobalVariable Property aaaAnimEatSoupSitting auto
GlobalVariable Property aaaAnimDrinkStanding auto
GlobalVariable Property aaaAnimDrinkSitting auto
GlobalVariable Property aaaAnimWashBody auto
GlobalVariable Property aaaAnimFillWater auto
GlobalVariable Property aaaAnimMakeTowel auto
GlobalVariable Property aaaAnimReadBook auto
GlobalVariable Property aaaAnimTakePotion auto
GlobalVariable Property aaaAnimForetaste auto
GlobalVariable Property aaaAnimRegisterCustomPotion auto
int[] mealAnimOID
string[] mealAnimStr
GlobalVariable[] mealAnimGV
string[] mealAnimDisc

;Bathing settings
int[] slotsOID
string[] slotsStrOID
bool[] SlotMaskArray
int CurrentCharacterSlotOID
int CurrentCharacter = 0

;misc config
Quest Property BasicNeedsQuest auto
GlobalVariable Property aaaKNNIsEnableMessage auto
GlobalVariable Property aaaKNNHotkeyHipBag auto
GlobalVariable Property aaaKNNIsEnableSellWaterBottle auto
GlobalVariable Property aaaKNNIsEnabledSellTowel auto
GlobalVariable Property aaaKNNIsConvertEmptyBottle auto
GlobalVariable Property aaaKNNNeedTundraCotton auto
GlobalVariable Property _KNNIsEnableWaterBarrelFeature auto
Quest Property aaaKNNVendorQuest auto
Quest Property WaterBarrelQuest auto
int MsgOID
int HipBagOID
int SellBottleOID
int SellTowelPotionOID
int convertEmptyBottleOID
int NeedTundraCottnOID
int ResolveModBedOID
int WaterBarrelOID

;management page
FormList Property _KNNAlllFoodTypeLists auto
int[] FoodTypeListOID
string[] ClearListMessageList
string[] FoodListNames
form[] foodsList
string[] foodsStrList
int ExportAllFoodListOID
int ImportAllFoodListOID
int SaveMCMSettingsOID
int LoadMCMSettingsOID
int CreateXMLOID
string[] xmlList

GlobalVariable Property aaaKNNIsEnableQuiver auto
GlobalVariable Property aaaKNNIsEnableStumble auto
int QuiverOID
int StumbleOID

Book Property _BookOfKNNSurvival auto
int GetBookOID
 
;potion hotkey
GlobalVariable Property aaaKNNHotkeyFoods auto
GlobalVariable Property aaaKNNHotkeyDrinks auto
GlobalVariable Property aaaKNNHotkeyCustom auto
GlobalVariable Property aaaKNNPotionUseageEffectFoods auto
GlobalVariable Property aaaKNNPotionUseageEffectDrinks auto
GlobalVariable Property aaaKNNPotionUseageEffectCustom auto
GlobalVariable Property aaaKNNPotionUseagePriorityFoods auto
GlobalVariable Property aaaKNNPotionUseagePriorityDrinks auto
GlobalVariable Property aaaKNNPotionUseagePriorityWater auto
int FOODOID
int DRINKOID
int CUSTOMOID
int PUFOODOID
int PUDRINKOID
int PUCUSTOMOID
int PRIORITYFOODOID
int PRIORITYDRINKOID
int PRIORITYDRINKSTYPEOID

;idle anim hotkey
GlobalVariable Property aaaKNNHotkeyIdleAnim auto
int IdleAnimOID

;follower anim
GlobalVariable Property aaaKNNFollowerPlayHarvest auto
GlobalVariable Property aaaKNNFollowerPlayContainer auto
GlobalVariable Property aaaKNNFollowerPlayDoor auto
GlobalVariable Property aaaKNNFollowerPlayDoorBar auto
GlobalVariable Property aaaKNNFollowerPlayLoot auto
GlobalVariable Property aaaKNNFollowerPlayPuzzulePillar auto
GlobalVariable Property aaaKNNFollowerPlayShrine auto
GlobalVariable Property aaaKNNFollowerPlayPullBar auto
GlobalVariable Property aaaKNNFollowerPlayPullChain auto
GlobalVariable Property _EnabledAlwaysFollowerAnimActivation auto
GlobalVariable Property aaaKNNFollowerFillWater auto
GlobalVariable Property aaaKNNFollowerWashBody auto
GlobalVariable Property aaaKNNFollowerPlaySleeping auto
GlobalVariable Property aaaKNNFollowerPlayMeal auto
Globalvariable Property aaaKNNIsEnableFollowerDirtyBodyEffect auto
int[] followerOID
string[] followerStrOID
GlobalVariable[] followerValOID

;player jurnal
Quest Property JurnalQuest auto
GlobalVariable Property aaaKNNHotkeyJurnal auto
GlobalVariable Property aaaKNNIsEnableUseInkPen auto
int JurnalOID
int UseInkPenOID

;widget
aaaKNNWidgetQuest Property widget auto
GlobalVariable Property aaaKNNIsEnableWidget auto
GlobalVariable Property aaaKNNIsEnableWidgetOp auto
GlobalVariable Property aaaKNNHotkeyWidget auto
int WidgetHotkeyOID
int WidgetOID
int WidgetPosXOID
int WidgetPosYOID
int WidgetAlphaOID
int WidgetOpOID
int WidgetOpPosXOID
int WidgetOpPosYOID
int WidgetOpAlphaOID

;Head Tracking
Quest Property KNNHTQuest auto
GlobalVariable Property aaaKNNIsHT auto
GlobalVariable Property aaaKNNHTPriority auto
GlobalVariable Property aaaKNNHTInterVal auto
GlobalVariable Property aaaKNNIsExpressionChangeExtension auto
Globalvariable Property aaaKNNIsHTEnableEyeTracking auto
Globalvariable Property _KNNHTDisabledWhileWeaponDrawn auto
GlobalVariable Property aaaKNNIsHTActor auto
GlobalVariable Property aaaKNNIsHTIdleAnim auto
GlobalVariable Property _KNNNextHTInterval auto

GlobalVariable Property aaaKNNEyeHorizonalRangeMax auto
GlobalVariable Property aaaKNNEyeHorizonalRangeMin auto
GlobalVariable Property aaaKNNEyeHorizonalPowerMax auto
GlobalVariable Property aaaKNNEyeHorizonalPowerMin auto
GlobalVariable Property aaaKNNEyeVerticalRangeMax auto
GlobalVariable Property aaaKNNEyeVerticalRangeMin auto
GlobalVariable Property aaaKNNEyeVerticalPowerMax auto
GlobalVariable Property aaaKNNEyeVerticalPowerMin auto

GlobalVariable Property aaaKNNIsEnableExpressionInCombat auto

int IsHTOID
int HTPriorityOID
int HTIntervalOID
int IsExpressionChangeExtensionOID
int IsEyeTrackingOID
int IsNotHTWeaponDrawnOID
int IsHTActorOID
int IsIdleAnimOID
int NextHTIntervalOID
int UpdateNoLookObjOID

int HorizontalRangeMaxOID
int HorizontalRangeMinOID
int HorizontalPowerMaxOID
int HorizontalPowerMinOID
int VerticalRangeMaxOID
int VerticalRangeMinOID
int VerticalPowerMaxOID
int VerticalPowerMinOID

int EnabledExInCombatOID

int[] HTExActorsOID
FormList Property HTExActorGV auto
int[] HTExActorDefault
int[] HTExValActorsOID
FormList Property HTExValActorGV auto
float[] HTExValActorDefault
string[] ExValActorsDesc

int[] HTFormsOID
FormList Property HTFormGV auto
int[] HTExFormsOID
int[] HTExFormDefault
FormList Property HTExFormGV auto
int[] HTExValFormsOID
FormList Property HTExValFormGV auto
float[] HTExValFormDefault

int[] HTExBasicOID
FormList Property HTExBasicGv auto
int[] HTExBasicDefault

int[] HTExValBasicOID
FormList Property HTExValBasicGv auto
float[] ExValBasicDefault