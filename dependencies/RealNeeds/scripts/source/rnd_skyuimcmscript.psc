Scriptname RND_SkyUIMCMScript extends ski_configbase

RND_HungerCountScript Property HungerScript Auto
RND_ThirstCountScript Property ThirstScript Auto
RND_SleepCountScript Property SleepScript Auto
RND_InebriationCountScript Property InebriationScript Auto
RND_WeightCountScript Property WeightScript Auto
RND_WidgetUpdateScript Property UpdateScript Auto

Int HungerWidget
Int HungerPosX
Int HungerPosY
Int HungerAnchorV
Int HungerAnchorH
Int HungerAlpha
Int HungerScale
Int ThirstWidget
Int ThirstPosX
Int ThirstPosY
Int ThirstAnchorV
Int ThirstAnchorH
Int ThirstAlpha
Int ThirstScale
Int SleepWidget
Int SleepPosX
Int SleepPosY
Int SleepAnchorV
Int SleepAnchorH
Int SleepAlpha
Int SleepScale
Int InebriationWidget
Int InebriationPosX
Int InebriationPosY
Int InebriationAnchorV
Int InebriationAnchorH
Int InebriationAlpha
Int InebriationScale
Int WeightWidget
Int WeightPosX
Int WeightPosY
Int WeightAnchorV
Int WeightAnchorH
Int WeightAlpha
Int WeightScale

Int AutoWidget
Int UpdateTimerInt

Int KeyQuickCustomize
Int KeyCustomize
Int KeyQuickWidget
Int KeyWidget
Int KeyQuickWait
Int KeyWait

String[] HAnchorHungerString
String[] VAnchorHungerString
String[] HAnchorThirstString
String[] VAnchorThirstString
String[] HAnchorSleepString
String[] VAnchorSleepString
String[] HAnchorInebriationString
String[] VAnchorInebriationString
String[] HAnchorWeightString
String[] VAnchorWeightString

GlobalVariable Property RND_State Auto
GlobalVariable Property RND_DebugMode Auto
GlobalVariable Property RND_1stPersonMsg Auto

Quest Property RNDTrackingQuest Auto
Quest Property RNDReminderQuest Auto
Quest Property RNDSpoilageQuest Auto

RND_PlayerScript Property RND_Player Auto
RND_SpoilageScript Property RND_Spoilage Auto

GlobalVariable Property RND_AnimEat Auto
GlobalVariable Property RND_AnimDrink Auto
GlobalVariable Property RND_AnimInebriation Auto
GlobalVariable Property RND_AnimRefill Auto
GlobalVariable Property RND_AnimMisc Auto
GlobalVariable Property RND_IsmInebriation Auto

GlobalVariable Property RND_DiseaseFatigue Auto
GlobalVariable Property RND_MortalVamp Auto
GlobalVariable Property RND_HideCampingGear Auto
GlobalVariable Property RND_HidePowers Auto
GlobalVariable Property RND_ShrinesCureDisease Auto

GlobalVariable Property RND_HungerPoInts Auto
GlobalVariable Property RND_HungerPoIntsPerHour Auto
GlobalVariable Property RND_ThirstPoInts Auto
GlobalVariable Property RND_ThirstPoIntsPerHour Auto
GlobalVariable Property RND_InebriationPoInts Auto
GlobalVariable Property RND_InebriationPoIntsPerHour Auto
GlobalVariable Property RND_SleepPoInts Auto
GlobalVariable Property RND_SleepPoIntsPerHour Auto

GlobalVariable Property RND_ForceSatiation Auto
GlobalVariable Property RND_DieOfThirst Auto

GlobalVariable Property RND_FastTravelSlowRate Auto
GlobalVariable Property RND_ReminderInterval Auto
GlobalVariable Property RND_ReminderSound Auto
GlobalVariable Property RND_ReminderMessage Auto
GlobalVariable Property RND_ReminderSoundVolume Auto

GlobalVariable Property RND_AlcoholPoIntsWeak Auto
GlobalVariable Property RND_AlcoholPoIntsNormal Auto
GlobalVariable Property RND_AlcoholPoIntsStrong Auto

GlobalVariable Property RND_TrippingChance01 Auto
GlobalVariable Property RND_TrippingChance02 Auto
GlobalVariable Property RND_TrippingChance03 Auto

GlobalVariable Property RND_DiseaseChanceRawFood Auto
GlobalVariable Property RND_DiseaseChanceStaleFood Auto
GlobalVariable Property RND_DiseaseChanceRiverWater Auto
GlobalVariable Property RND_DiseaseChanceDirtyBedroll Auto

GlobalVariable Property RND_CleanCookMenu Auto
GlobalVariable Property RND_CanMilkCow Auto

GlobalVariable Property RND_FoodSpoilage Auto
GlobalVariable Property RND_SpoilDaysCat0 Auto
GlobalVariable Property RND_SpoilDaysCat1 Auto
GlobalVariable Property RND_SpoilDaysCat2 Auto
GlobalVariable Property RND_SpoilDaysCat3 Auto
GlobalVariable Property RND_SpoilDaysCat4 Auto
GlobalVariable Property RND_SpoilDaysCat5 Auto
GlobalVariable Property RND_SpoilDaysCat6 Auto
GlobalVariable Property RND_SpoilDaysCat7 Auto
GlobalVariable Property RND_SpoilDaysCat8 Auto
GlobalVariable Property RND_SpoilDaysCat9 Auto
GlobalVariable Property RND_RemoveSpoiledFood Auto

GlobalVariable Property RND_CheckNeedsKey Auto
GlobalVariable Property RND_DrinkWaterKey Auto

Spell Property RND_CheckNeedsSpell Auto
Spell Property RND_DrinkFromWaterSource Auto
Spell Property RND_InitNeedsSpell Auto
Spell Property RND_CureDiseaseSpell Auto
Spell Property RND_RemoveNeedsSpell Auto
Spell Property RND_CustomFoodSpell Auto
Spell Property RND_RestSpell Auto
Spell Property RND_WidgetSpell Auto

Perk Property RND_MilkingPerk  Auto 

Actor Property PlayerREF Auto
Keyword Property VendorItemFood Auto
Keyword Property VendorItemFoodRaw Auto
Message Property RND_CustomizeFoodMessage Auto
FormList Property RND_RawFoodList Auto
FormList Property RND_SnackFoodList Auto
FormList Property RND_MediumFoodList Auto
FormList Property RND_AbundantFoodList Auto
FormList Property RND_BeverageList Auto
FormList Property RND_AlcoholBeverageList Auto
FormList Property RND_VanillaFoodList Auto

Perk Property RND_WaterWellPerk Auto
Perk Property RND_GrillFoodPerk Auto
GlobalVariable Property RND_WaterWellGlobal Auto
GlobalVariable Property RND_GrillFoodGlobal Auto
;GlobalVariable Property RND_NoPenaltyGlobal Auto
GlobalVariable Property RND_AutoWidget Auto
GlobalVariable Property RND_HoursThresholdGlobal Auto
GlobalVariable Property RND_DisableWeightGlobal Auto
GlobalVariable Property RND_CurrentWeightGlobal Auto

Spell Property RND_SleepSpell02 Auto
Spell Property RND_SleepSpell03 Auto
Spell Property RND_SleepSpell04 Auto
Spell Property RND_HungerSpell05 Auto
Spell Property RND_WeightSpell00 Auto
Spell Property RND_WeightSpell01 Auto
Spell Property RND_WeightSpell02 Auto
Spell Property RND_WeightSpell03 Auto
Spell Property RND_WeightSpell04 Auto

Idle Property DefaultSheathe auto
Int DefaultSleepPoints

;================================================

Event OnConfigInit()
	parent.OnConfigInit()
	Pages = new String[5]
	pages[0] = "$RNDBasicNeeds"
	pages[1] = "$RNDAlcoholDisease"
	pages[2] = "$RNDFoodSpoilage"
	pages[3] = "$RNDToggles"
	pages[4] = "$RNDWidgets"
	
	HAnchorHungerString = new String[3]
	HAnchorHungerString[0] = "Left"
	HAnchorHungerString[1] = "Right"
	HAnchorHungerString[2] = "Center"	
	HAnchorThirstString = new String[3]
	HAnchorThirstString[0] = "Left"
	HAnchorThirstString[1] = "Right"
	HAnchorThirstString[2] = "Center"	
	HAnchorSleepString = new String[3]
	HAnchorSleepString[0] = "Left"
	HAnchorSleepString[1] = "Right"
	HAnchorSleepString[2] = "Center"	
	HAnchorInebriationString = new String[3]
	HAnchorInebriationString[0] = "Left"
	HAnchorInebriationString[1] = "Right"
	HAnchorInebriationString[2] = "Center"
	HAnchorWeightString = new String[3]
	HAnchorWeightString[0] = "Left"
	HAnchorWeightString[1] = "Right"
	HAnchorWeightString[2] = "Center"	
	
	VAnchorHungerString = new String[3]
	VAnchorHungerString[0] = "Bottom"
	VAnchorHungerString[1] = "Top"
	VAnchorHungerString[2] = "Center"	
	VAnchorThirstString = new String[3]
	VAnchorThirstString[0] = "Bottom"
	VAnchorThirstString[1] = "Top"
	VAnchorThirstString[2] = "Center"	
	VAnchorSleepString = new String[3]
	VAnchorSleepString[0] = "Bottom"
	VAnchorSleepString[1] = "Top"
	VAnchorSleepString[2] = "Center"	
	VAnchorInebriationString = new String[3]
	VAnchorInebriationString[0] = "Bottom"
	VAnchorInebriationString[1] = "Top"
	VAnchorInebriationString[2] = "Center"
	VAnchorWeightString = new String[3]
	VAnchorWeightString[0] = "Bottom"
	VAnchorWeightString[1] = "Top"
	VAnchorWeightString[2] = "Center"	

	InitKeys()
	
EndEvent

Event OnPlayerLoadGame()

	InitKeys()

EndEvent
;================================================

; OIDs
Int OID_Status
Int OID_DebugMode
Int OID_Version
Int OID_1stPersonMsg

Int OID_HungerRate_S
Int OID_ThirstRate_S
Int OID_FatigueRate_S
Int OID_WeightRate_S
Int OID_WeightPlayer_S

Int OID_ForceSatiation
Int OID_DieOfThirst

Int OID_DiseaseChanceRawFood_S
Int OID_DiseaseChanceStaleFood_S
Int OID_DiseaseChanceRiverWater_S
Int OID_DiseaseChanceDirtyBedroll_S

Int OID_AlcoholPoIntsWeak_S
Int OID_AlcoholPoIntsNormal_S
Int OID_AlcoholPoIntsStrong_S

Int OID_TrippingChance01_S
Int OID_TrippingChance02_S
Int OID_TrippingChance03_S

Int OID_ReminderInterval_S
Int OID_ReminderMessage
Int OID_ReminderSound
Int OID_ReminderSoundVolume_S

Int OID_FastTravelSlowRate_S

Int OID_AnimEat
Int OID_AnimDrink
Int OID_AnimInebriation
Int OID_AnimRefill
Int OID_AnimMisc
Int OID_IsmInebriation

Int OID_DiseaseFatigue
Int OID_MortalVamp
Int OID_HideCampingGear
Int OID_HidePowers
Int OID_ShrinesCureDisease

Int OID_CanMilkCow
Int OID_CleanCookMenu

Int OID_FoodSpoilage
Int OID_SpoilDaysCat0_S
Int OID_SpoilDaysCat1_S
Int OID_SpoilDaysCat2_S
Int OID_SpoilDaysCat3_S
Int OID_SpoilDaysCat4_S
Int OID_SpoilDaysCat5_S
Int OID_SpoilDaysCat6_S
Int OID_SpoilDaysCat7_S
Int OID_SpoilDaysCat8_S
Int OID_SpoilDaysCat9_S
Int OID_RemoveSpoiledFood

Int OID_CheckNeedsKey_K
Int OID_DrinkWaterKey_K

Int OID_ConfigHTS
Int OID_ConfigAlcohol

Int OID_WaterWell
Int OID_GrillFood
;Int OID_NoPenalty
Int OID_NoWeight
bool RND_WaterSourceToggle = false
bool RND_GrillFoodToggle = false
bool RND_NoPenaltyToggle = false
bool RND_AutoWidgetToggle = false
bool RND_NoWeightToggle = false

Event OnPageReset(string page)

	If (page == "")	
		;X offset = 376 - (imageWidth / 2) = 376 - 128 = 258
		;Y offset = 223 - (imageHeight / 2) = 223 - 128 = 95
		LoadCustomContent("rnd/rnd_logo.dds", 120, 159)
		return
	Else
		UnloadCustomContent()
	EndIf
	
	SetCursorFillMode(TOP_TO_BOTTOM)
	
	If (page == "$RNDBasicNeeds")
	
		AddHeaderOption("$RNDBasicNeeds")
		OID_HungerRate_S = AddSliderOption("$RNDHungerRate", RND_HungerPoIntsPerHour.getValueInt(), "{0} Points per Hour")
		OID_ThirstRate_S = AddSliderOption("$RNDThirstRate", RND_ThirstPoIntsPerHour.getValueInt(), "{0} Points per Hour")
		OID_FatigueRate_S = AddSliderOption("$RNDFatigueRate", RND_SleepPoIntsPerHour.getValueInt(), "{0} Points per Hour")
		OID_WeightRate_S = AddSliderOption("$RNDWeightRate", RND_HoursThresholdGlobal.getValue(), "{0} Weight Threshold")
		OID_WeightPlayer_S = AddSliderOption("$RNDWeightPlayer", RND_CurrentWeightGlobal.getValue(), "{0} Units")			
		;OID_ConfigHTS = AddTextOption("", "$RNDConfigTip")
		
		;AddHeaderOption("$RNDOptions")
		OID_ForceSatiation = AddToggleOption("$RNDForceSatiationFirst", RND_ForceSatiation.getValueInt())
		OID_DieOfThirst = AddToggleOption("$RNDDieOfThirst", RND_DieOfThirst.getValueInt())
		OID_NoWeight = AddToggleOption("$RNDNoWeight", RND_DisableWeightGlobal.getValueInt())
		
		AddHeaderOption("$RNDHotkeys")
		
		OID_CheckNeedsKey_K = AddKeyMapOption("$RNDCheckNeedsKey", RND_CheckNeedsKey.GetValueInt())
		OID_DrinkWaterKey_K = AddKeyMapOption("$RNDDrinkWaterKey", RND_DrinkWaterKey.GetValueInt())		
			
		SetCursorPosition(1)
		
		If RND_State.getValue() == 0
			OID_Status = AddTextOption("$RNDStartRND", "")
		Else
			OID_Status = AddTextOption("$RNDStopRND", "")
		EndIf
		;OID_Version = AddTextOption("$RNDCurrentVersion", "v1.9.9")
		
		AddHeaderOption("$RNDAutoReminder")
		OID_ReminderInterval_S = AddSliderOption("$RNDReminderIntervalinminutes", RND_ReminderInterval.getValueInt())
		OID_ReminderMessage = AddToggleOption("$RNDMessageNotification", RND_ReminderMessage.getValueInt())
		OID_ReminderSound = AddToggleOption("$RNDSoundNotification", RND_ReminderSound.getValueInt())
		OID_ReminderSoundVolume_S = AddSliderOption("$RNDSoundVolume", RND_ReminderSoundVolume.getValueInt())

		AddHeaderOption("$RNDDuringFastTravel")
		OID_FastTravelSlowRate_S = AddSliderOption("$RNDSlowFatigueRateby", RND_FastTravelSlowRate.getValueInt(), "{0}%")
		
		AddHeaderOption("$RNDHotkeys")
		KeyQuickCustomize = AddKeyMapOption("$RND_CustomFoodHotkey", KeyCustomize)
		KeyQuickWidget = AddKeyMapOption("$RND_WidgetHotkey", KeyWidget)
		KeyQuickWait = AddKeyMapOption("$RND_WaitHotkey", KeyWait)
				
	ElseIf (page == "$RNDAlcoholDisease")
	
		AddHeaderOption("$RNDAlcoholLevel")
		OID_AlcoholPoIntsWeak_S = AddSliderOption("$RNDWeakAlcoholicBeverage", RND_AlcoholPoIntsWeak.getValueInt())
		OID_AlcoholPoIntsNormal_S = AddSliderOption("$RNDNormalAlcoholicBeverage", RND_AlcoholPoIntsNormal.getValueInt())
		OID_AlcoholPoIntsStrong_S = AddSliderOption("$RNDStrongAlcoholicBeverage", RND_AlcoholPoIntsStrong.getValueInt())
		OID_ConfigAlcohol = AddTextOption("", "$RNDConfigTip")
		
		AddHeaderOption("$RNDRandomTripping")
		OID_TrippingChance01_S = AddSliderOption("$RNDWhenDizzy", RND_TrippingChance01.getValueInt(), "{0}%")
		OID_TrippingChance02_S = AddSliderOption("$RNDWhenDrunk", RND_TrippingChance02.getValueInt(), "{0}%")
		OID_TrippingChance03_S = AddSliderOption("$RNDWhenWasted", RND_TrippingChance03.getValueInt(), "{0}%")
		
		SetCursorPosition(1)
		
		AddHeaderOption("$RNDDiseaseChance")
		OID_DiseaseChanceRawFood_S = AddSliderOption("$RNDRawFood", RND_DiseaseChanceRawFood.getValueInt(), "{0}%")
		OID_DiseaseChanceStaleFood_S = AddSliderOption("$RNDStaleFood", RND_DiseaseChanceStaleFood.getValueInt(), "{0}%")
		OID_DiseaseChanceRiverWater_S = AddSliderOption("$RNDRiverWater", RND_DiseaseChanceRiverWater.getValueInt(), "{0}%")
		OID_DiseaseChanceDirtyBedroll_S = AddSliderOption("$RNDDirtyBedroll", RND_DiseaseChanceDirtyBedroll.getValueInt(), "{0}%")
		OID_DiseaseFatigue = AddToggleOption("$RNDDiseaseFatigue", RND_DiseaseFatigue.getValueInt())
	
	ElseIf (page == "$RNDFoodSpoilage")
		AddHeaderOption("$RNDFoodSpoilinDays")
		OID_SpoilDaysCat0_S = AddSliderOption("$RNDSpoilageCategory0", RND_SpoilDaysCat0.getValueInt())
		OID_SpoilDaysCat1_S = AddSliderOption("$RNDSpoilageCategory1", RND_SpoilDaysCat1.getValueInt())
		OID_SpoilDaysCat2_S = AddSliderOption("$RNDSpoilageCategory2", RND_SpoilDaysCat2.getValueInt())
		OID_SpoilDaysCat3_S = AddSliderOption("$RNDSpoilageCategory3", RND_SpoilDaysCat3.getValueInt())
		OID_SpoilDaysCat4_S = AddSliderOption("$RNDSpoilageCategory4", RND_SpoilDaysCat4.getValueInt())
		OID_SpoilDaysCat5_S = AddSliderOption("$RNDSpoilageCategory5", RND_SpoilDaysCat5.getValueInt())
		OID_SpoilDaysCat6_S = AddSliderOption("$RNDSpoilageCategory6", RND_SpoilDaysCat6.getValueInt())
		OID_SpoilDaysCat7_S = AddSliderOption("$RNDSpoilageCategory7", RND_SpoilDaysCat7.getValueInt())
		;OID_SpoilDaysCat8_S = AddSliderOption("$RNDSpoilageCategory8", RND_SpoilDaysCat8.getValueInt())
		;OID_SpoilDaysCat9_S = AddSliderOption("$RNDSpoilageCategory9", RND_SpoilDaysCat9.getValueInt())
		
		SetCursorPosition(1)
		
		OID_FoodSpoilage = AddToggleOption("$RNDFoodSpoilage", RND_FoodSpoilage.getValueInt())
		AddHeaderOption("$RNDOptions")
		OID_RemoveSpoiledFood = AddToggleOption("$RNDRemoveSpoiledFood", RND_RemoveSpoiledFood.getValueInt())
	
	ElseIf (page == "$RNDToggles")
		AddHeaderOption("$RNDAnimationToggle")
		OID_AnimEat = AddToggleOption("$RNDEatFood", RND_AnimEat.getValueInt())
		OID_AnimDrink = AddToggleOption("$RNDDrinkMug", RND_AnimDrink.getValueInt())
		OID_AnimInebriation = AddToggleOption("$RNDInebriation", RND_AnimInebriation.getValueInt())
		OID_AnimRefill = AddToggleOption("$RNDRefillBottle", RND_AnimRefill.getValueInt())
		OID_AnimMisc = AddToggleOption("$RNDMisc", RND_AnimMisc.getValueInt())
		
		OID_IsmInebriation = AddToggleOption("$RNDAlternativeDrunkVisual", RND_IsmInebriation.getValueInt())
		
		SetCursorPosition(1)
		
		OID_DebugMode = AddToggleOption("$RNDDebugMode", RND_DebugMode.getValueInt())
		OID_1stPersonMsg = AddToggleOption("$RNDFirstPersonMessage", RND_1stPersonMsg.getValueInt())
		OID_HidePowers = AddToggleOption("$RNDHidePowers", RND_HidePowers.getValueInt())
		OID_CleanCookMenu = AddToggleOption("$RNDCleanCookMenu", RND_CleanCookMenu.getValueInt())
		OID_CanMilkCow = AddToggleOption("$RNDCanMilkCow", RND_CanMilkCow.getValueInt())
		OID_MortalVamp = AddToggleOption("$RNDMortalVamp", RND_MortalVamp.getValueInt())
		OID_HideCampingGear = AddToggleOption("$RNDHideCampingGear", RND_HideCampingGear.getValueInt())
		OID_ShrinesCureDisease = AddToggleOption("$RNDShrinesCureDisease", RND_ShrinesCureDisease.getValueInt())
		OID_WaterWell = AddToggleOption("$RND_WaterFromWells", RND_WaterSourceToggle)
		OID_GrillFood = AddToggleOption("$RND_GrillFood", RND_GrillFoodToggle)
		;OID_NoPenalty = AddToggleOption("$RND_NoPenalty", RND_NoPenaltyToggle)		
		
	ElseIf (page == "$RNDWidgets")
	
		SetCursorFillMode(TOP_TO_BOTTOM)
		SetCursorPosition(0)
		AddHeaderOption("Hunger Widget")
		HungerWidget = AddToggleOption("$RND_ToggleHunger", HungerScript.Visible)
		HungerPosX = AddSliderOption("$RND_LeftRight", HungerScript.X, "{0}")
		HungerPosY = AddSliderOption("$RND_UpDown", HungerScript.Y, "{0}")
		HungerAnchorH = AddMenuOption("$RND_HorAnch", HAnchorHungerString[HAnchorHungerString.Find(HungerScript.HAnchor)])
		HungerAnchorV = AddMenuOption("$RND_VertAnch", VAnchorHungerString[VAnchorHungerString.Find(HungerScript.VAnchor)])
		HungerAlpha = AddSliderOption("$RND_Trans", HungerScript.Alpha, "{0} %")
		HungerScale = AddSliderOption("$RND_Scale", HungerScript.Size, "{0} %")
		AddHeaderOption("Thirst Widget")
		ThirstWidget = AddToggleOption("$RND_ToggleThirst", ThirstScript.Visible)
		ThirstPosX = AddSliderOption("$RND_LeftRight", ThirstScript.X, "{0}")
		ThirstPosY = AddSliderOption("$RND_UpDown", ThirstScript.Y, "{0}")
		ThirstAnchorH = AddMenuOption("$RND_HorAnch", HAnchorThirstString[HAnchorThirstString.Find(ThirstScript.HAnchor)])
		ThirstAnchorV = AddMenuOption("$RND_VertAnch", VAnchorThirstString[VAnchorThirstString.Find(ThirstScript.VAnchor)])
		ThirstAlpha = AddSliderOption("$RND_Trans", ThirstScript.Alpha, "{0} %")
		ThirstScale = AddSliderOption("$RND_Scale", ThirstScript.Size, "{0} %")
		AddHeaderOption("Sleep Widget")
		SleepWidget = AddToggleOption("$RND_ToggleSleep", SleepScript.Visible)
		SleepPosX = AddSliderOption("$RND_LeftRight", SleepScript.X, "{0}")
		SleepPosY = AddSliderOption("$RND_UpDown", SleepScript.Y, "{0}")
		SleepAnchorH = AddMenuOption("$RND_HorAnch", HAnchorSleepString[HAnchorSleepString.Find(SleepScript.HAnchor)])
		SleepAnchorV = AddMenuOption("$RND_VertAnch", VAnchorSleepString[VAnchorSleepString.Find(SleepScript.VAnchor)])
		SleepAlpha = AddSliderOption("$RND_Trans", SleepScript.Alpha, "{0} %")
		SleepScale = AddSliderOption("$RND_Scale", SleepScript.Size, "{0} %")
		SetCursorPosition(1)
		AddHeaderOption("General Settings")
		AutoWidget = AddToggleOption("$RND_AutoWidget", RND_AutoWidget.GetValueInt())
		UpdateTimerInt = AddSliderOption("$RND_UpdateTimer", UpdateScript.UpdateTimer, "{0} sec.")	

		AddHeaderOption("Inebriation Widget")
		InebriationWidget = AddToggleOption("$RND_ToggleIneb", InebriationScript.Visible)
		InebriationPosX = AddSliderOption("$RND_LeftRight", InebriationScript.X, "{0}")
		InebriationPosY = AddSliderOption("$RND_UpDown", InebriationScript.Y, "{0}")
		InebriationAnchorH = AddMenuOption("$RND_HorAnch", HAnchorInebriationString[HAnchorInebriationString.Find(InebriationScript.HAnchor)])
		InebriationAnchorV = AddMenuOption("$RND_VertAnch", VAnchorInebriationString[VAnchorInebriationString.Find(InebriationScript.VAnchor)])
		InebriationAlpha = AddSliderOption("$RND_Trans", InebriationScript.Alpha, "{0} %")
		InebriationScale = AddSliderOption("$RND_Scale", InebriationScript.Size, "{0} %")
		AddHeaderOption("Weight Widget")
		WeightWidget = AddToggleOption("$RND_ToggleWeight", WeightScript.Visible)
		WeightPosX = AddSliderOption("$RND_LeftRight", WeightScript.X, "{0}")
		WeightPosY = AddSliderOption("$RND_UpDown", WeightScript.Y, "{0}")
		WeightAnchorH = AddMenuOption("$RND_HorAnch", HAnchorWeightString[HAnchorWeightString.Find(WeightScript.HAnchor)])
		WeightAnchorV = AddMenuOption("$RND_VertAnch", VAnchorWeightString[VAnchorWeightString.Find(WeightScript.VAnchor)])
		WeightAlpha = AddSliderOption("$RND_Trans", WeightScript.Alpha, "{0} %")
		WeightScale = AddSliderOption("$RND_Scale", WeightScript.Size, "{0} %")		
		
	EndIf
	
EndEvent

Event OnOptionKeyMapChange(Int option, Int keyCode, string conflictControl, string conflictName)
	If (option == OID_CheckNeedsKey_K)
		RND_CheckNeedsKey.SetValue(keyCode)
		SetKeyMapOptionValue(OID_CheckNeedsKey_K, RND_CheckNeedsKey.GetValueInt())
				
	ElseIf (option == OID_DrinkWaterKey_K)
		RND_DrinkWaterKey.SetValue(keyCode)
		SetKeyMapOptionValue(OID_DrinkWaterKey_K, RND_DrinkWaterKey.GetValueInt())
	ElseIf (option == KeyQuickCustomize)
		bool Continue = true
		If (conflictControl != "")
			string msg
			If (conflictName != "")
				msg = "This key is already mapped to:\n'" + conflictControl + "'\n(" + conflictName + ")\n\nAre you sure you want to continue?"
			Else
				msg = "This key is already mapped to:\n'" + conflictControl + "'\n\nAre you sure you want to continue?"
			EndIf
			Continue = ShowMessage(msg, true, "Yes", "No")
		EndIf
		If (Continue)
			KeyCustomize = keyCode
			SetKeymapOptionValue(option, keyCode)
			RegisterForKey(KeyCustomize)			
		EndIf
	ElseIf (option == KeyQuickWidget)
		bool Continue = true
		If (conflictControl != "")
			string msg
			If (conflictName != "")
				msg = "This key is already mapped to:\n'" + conflictControl + "'\n(" + conflictName + ")\n\nAre you sure you want to continue?"
			Else
				msg = "This key is already mapped to:\n'" + conflictControl + "'\n\nAre you sure you want to continue?"
			EndIf
			Continue = ShowMessage(msg, true, "Yes", "No")
		EndIf
		If (Continue)
			KeyWidget = keyCode
			SetKeymapOptionValue(option, keyCode)
			RegisterForKey(KeyWidget)			
		EndIf
	ElseIf (option == KeyQuickWait)
		bool Continue = true
		If (conflictControl != "")
			string msg
			If (conflictName != "")
				msg = "This key is already mapped to:\n'" + conflictControl + "'\n(" + conflictName + ")\n\nAre you sure you want to continue?"
			Else
				msg = "This key is already mapped to:\n'" + conflictControl + "'\n\nAre you sure you want to continue?"
			EndIf
			Continue = ShowMessage(msg, true, "Yes", "No")
		EndIf
		If (Continue)
			KeyWait = keyCode
			SetKeymapOptionValue(option, keyCode)
			RegisterForKey(KeyWait)			
		EndIf		
	EndIf
	
	If RNDTrackingQuest.isRunning()
		RND_Player.mapKey()
	EndIf
EndEvent

Event OnOptionSelect(Int option)
	string page = CurrentPage

	If (option == OID_Status)
	
		If RND_State.getValue() == 0
			SetTextOptionValue(option, "$RNDExitMenu")
			RND_Start()
		Else
			SetTextOptionValue(option, "$RNDExitMenu")
			RND_Stop()
		EndIf
		
	ElseIf (option == OID_ForceSatiation)
		toggle(RND_ForceSatiation)
		SetToggleOptionValue(option, RND_ForceSatiation.getValueInt())
		
	ElseIf (option == OID_DieOfThirst)
		toggle(RND_DieOfThirst)
		SetToggleOptionValue(option, RND_DieOfThirst.getValueInt())
	ElseIf (option == OID_NoWeight)
		toggle(RND_DisableWeightGlobal)
		SetToggleOptionValue(option, RND_DisableWeightGlobal.getValueInt())	
		Utility.Wait(3)
		If RND_DisableWeightGlobal.GetValueInt() == 0
			PlayerREF.RemoveSpell(RND_WeightSpell00)
			PlayerREF.RemoveSpell(RND_WeightSpell01)
			PlayerREF.RemoveSpell(RND_WeightSpell02)
			PlayerREF.RemoveSpell(RND_WeightSpell03)
			PlayerREF.RemoveSpell(RND_WeightSpell04)
		Else
			Debug.Notification("Please restart RNAD!")			
		EndIf
		
	ElseIf (Option == OID_WaterWell)
		If RND_State.getValue() == 1
			RND_WaterSourceToggle = !RND_WaterSourceToggle
			SetToggleOptionValue(OID_WaterWell, RND_WaterSourceToggle)
			RND_WaterWellGlobal.SetValue(1)
			PlayerREF.AddPerk(RND_WaterWellPerk)		
			If !RND_WaterSourceToggle	
				RND_WaterWellGlobal.SetValue(0)
				PlayerREF.RemovePerk(RND_WaterWellPerk)			
			EndIf
		ElseIf RND_State.getValue() == 0
			Debug.Notification("Please activate the Mod first!")
		EndIf

	ElseIf (Option == OID_GrillFood)
		If RND_State.getValue() == 1
			RND_GrillFoodToggle = !RND_GrillFoodToggle
			SetToggleOptionValue(OID_GrillFood, RND_GrillFoodToggle)
			RND_GrillFoodGlobal.SetValue(1)
			PlayerREF.AddPerk(RND_GrillFoodPerk)		
			If !RND_GrillFoodToggle	
				RND_GrillFoodGlobal.SetValue(0)
				PlayerREF.RemovePerk(RND_GrillFoodPerk)			
			EndIf
		ElseIf RND_State.getValue() == 0
			Debug.Notification("Please activate the Mod first!")
		EndIf			
	; deprecated as of 2.3.6 because of stupid special edition!	
	;ElseIf (Option == OID_NoPenalty)
	;	If RND_State.getValue() == 1
	;		RND_NoPenaltyToggle = !RND_NoPenaltyToggle
	;		SetToggleOptionValue(OID_NoPenalty, RND_NoPenaltyToggle)
	;		RND_NoPenaltyGlobal.SetValue(1)
	;		RND_HungerSpell05.SetNthEffectMagnitude(1, 0.0)
	;		RND_SleepSpell02.SetNthEffectMagnitude(0, 0.0)
	;		RND_SleepSpell03.SetNthEffectMagnitude(0, 0.0)
	;		RND_SleepSpell04.SetNthEffectMagnitude(0, 0.0)		
	;		If !RND_NoPenaltyToggle	
	;			RND_NoPenaltyGlobal.SetValue(0)
	;			RND_HungerSpell05.SetNthEffectMagnitude(1, 50.0)
	;			RND_SleepSpell02.SetNthEffectMagnitude(0, 30.0)
	;			RND_SleepSpell03.SetNthEffectMagnitude(0, 60.0)
	;			RND_SleepSpell04.SetNthEffectMagnitude(0, 90.0)				
	;		EndIf			
	;		
	;	ElseIf RND_State.getValue() == 0
	;		Debug.Messagebox("Please activate the Mod first!")
	;	EndIf		
		
	ElseIf (option == OID_ReminderMessage)
		toggle(RND_ReminderMessage)
		SetToggleOptionValue(option, RND_ReminderMessage.getValueInt())
		
	ElseIf (option == OID_ReminderSound)
		toggle(RND_ReminderSound)
		SetToggleOptionValue(option, RND_ReminderSound.getValueInt())
		
	ElseIf (option == OID_AnimEat)
		toggle(RND_AnimEat)
		SetToggleOptionValue(option, RND_AnimEat.getValueInt())
		
	ElseIf (option == OID_AnimDrink)
		toggle(RND_AnimDrink)
		SetToggleOptionValue(option, RND_AnimDrink.getValueInt())
		
	ElseIf (option == OID_AnimInebriation)
		toggle(RND_AnimInebriation)
		SetToggleOptionValue(option, RND_AnimInebriation.getValueInt())
		
	ElseIf (option == OID_AnimRefill)
		toggle(RND_AnimRefill)
		SetToggleOptionValue(option, RND_AnimRefill.getValueInt())
		
	ElseIf (option == OID_AnimMisc)
		toggle(RND_AnimMisc)
		SetToggleOptionValue(option, RND_AnimMisc.getValueInt())
		
	ElseIf (option == OID_IsmInebriation)
		toggle(RND_IsmInebriation)
		SetToggleOptionValue(option, RND_IsmInebriation.getValueInt())
		
	ElseIf (option == OID_DebugMode)
		toggle(RND_DebugMode)
		SetToggleOptionValue(option, RND_DebugMode.getValueInt())
		
	ElseIf (option == OID_1stPersonMsg)
		toggle(RND_1stPersonMsg)
		SetToggleOptionValue(option, RND_1stPersonMsg.getValueInt())
		
	ElseIf (option == OID_DiseaseFatigue)
		toggle(RND_DiseaseFatigue)
		SetToggleOptionValue(option, RND_DiseaseFatigue.getValueInt())	
	
	ElseIf (option == OID_HidePowers)
		toggle(RND_HidePowers)
		SetToggleOptionValue(option, RND_HidePowers.getValueInt())
		If RND_HidePowers.getValue() == 1
			Game.GetPlayer().RemoveSpell(RND_CheckNeedsSpell)
			Game.GetPlayer().RemoveSpell(RND_DrinkFromWaterSource)
			Game.GetPlayer().RemoveSpell(RND_CustomFoodSpell)
			Game.GetPlayer().RemoveSpell(RND_RestSpell)
			Game.GetPlayer().RemoveSpell(RND_WidgetSpell)			
		Else	
			If !Game.GetPlayer().HasSpell(RND_CheckNeedsSpell)
				Game.GetPlayer().AddSpell(RND_CheckNeedsSpell)
			EndIf
			If !Game.GetPlayer().HasSpell(RND_DrinkFromWaterSource)
				Game.GetPlayer().AddSpell(RND_DrinkFromWaterSource)
			EndIf
			If !Game.GetPlayer().HasSpell(RND_CustomFoodSpell)
				Game.GetPlayer().AddSpell(RND_CustomFoodSpell)
			EndIf
			If !Game.GetPlayer().HasSpell(RND_RestSpell)
				Game.GetPlayer().AddSpell(RND_RestSpell)
			EndIf
			If !Game.GetPlayer().HasSpell(RND_WidgetSpell)
				Game.GetPlayer().AddSpell(RND_WidgetSpell)
			EndIf			
		EndIf
	
	ElseIf (option == OID_CanMilkCow)
		toggle(RND_CanMilkCow)
		SetToggleOptionValue(option, RND_CanMilkCow.getValueInt())
		If RND_CanMilkCow.getValue() == 1
			Game.GetPlayer().AddPerk(RND_MilkingPerk)
		Else
			Game.GetPlayer().RemovePerk(RND_MilkingPerk)
		EndIf
	
	ElseIf (option == OID_CleanCookMenu)
		toggle(RND_CleanCookMenu)
		SetToggleOptionValue(option, RND_CleanCookMenu.getValueInt())
	
	ElseIf (option == OID_ShrinesCureDisease)
		toggle(RND_ShrinesCureDisease)
		SetToggleOptionValue(option, RND_ShrinesCureDisease.getValueInt())	
	
	ElseIf (option == OID_MortalVamp)
		toggle(RND_MortalVamp)
		SetToggleOptionValue(option, RND_MortalVamp.getValueInt())
	
	ElseIf (option == OID_HideCampingGear)
		toggle(RND_HideCampingGear)
		SetToggleOptionValue(option, RND_HideCampingGear.getValueInt())
		
	ElseIf (option == OID_ConfigHTS)
		showMessage("$RNDConfigTipHTSText")
		
	ElseIf (option == OID_ConfigAlcohol)
		showMessage("$RNDConfigTipAlcoholText")
		
	ElseIf (option == OID_RemoveSpoiledFood)
		toggle(RND_RemoveSpoiledFood)
		SetToggleOptionValue(option, RND_RemoveSpoiledFood.getValueInt())
		
	ElseIf (option == OID_FoodSpoilage)
		toggle(RND_FoodSpoilage)
		SetToggleOptionValue(option, RND_FoodSpoilage.getValueInt())
		If RND_FoodSpoilage.getValue() == 1
			If RNDSpoilageQuest.isRunning()
				RND_Spoilage.refresh()
			EndIf
		EndIf
		
	ElseIf (Option == HungerWidget)
		HungerScript.Visible = !HungerScript.Visible
		SetToggleOptionValue(Option, HungerScript.Visible)
	ElseIf (Option == ThirstWidget)
		ThirstScript.Visible = !ThirstScript.Visible
		SetToggleOptionValue(Option, ThirstScript.Visible)
	ElseIf (Option == SleepWidget)
		SleepScript.Visible = !SleepScript.Visible
		SetToggleOptionValue(Option, SleepScript.Visible)		
	ElseIf (Option == AutoWidget)
		RND_AutoWidgetToggle = !RND_AutoWidgetToggle
		SetToggleOptionValue(AutoWidget, RND_AutoWidgetToggle)
			RND_AutoWidget.SetValue(1)
			HungerScript.FadeTo(0, 0.1)
			ThirstScript.FadeTo(0, 0.1)
			SleepScript.FadeTo(0, 0.1)
			InebriationScript.FadeTo(0, 0.1)
			WeightScript.FadeTo(0, 0.1)
		If !RND_AutoWidgetToggle	
			RND_AutoWidget.SetValue(0)
			HungerScript.FadeTo(100, 0.1)
			ThirstScript.FadeTo(100, 0.1)
			SleepScript.FadeTo(100, 0.1)
			InebriationScript.FadeTo(100, 0.1)
			WeightScript.FadeTo(100, 0.1)			
		EndIf
	ElseIf (Option == InebriationWidget)
		InebriationScript.Visible = !InebriationScript.Visible
		SetToggleOptionValue(Option, InebriationScript.Visible)
	ElseIf (Option == WeightWidget)
		WeightScript.Visible = !WeightScript.Visible
		SetToggleOptionValue(Option, WeightScript.Visible)		
		
	EndIf

EndEvent

Event OnOptionSliderOpen(Int a_option)
	string page = CurrentPage

		If (a_option == OID_HungerRate_S)
			SetSliderDialogStartValue(RND_HungerPoIntsPerHour.getValueInt())
			SetSliderDialogDefaultValue(6)
			SetSliderDialogRange(0, 20)
			SetSliderDialogInterval(1)
		ElseIf (a_option == OID_ThirstRate_S)
			SetSliderDialogStartValue(RND_ThirstPoIntsPerHour.getValueInt())
			SetSliderDialogDefaultValue(8)
			SetSliderDialogRange(0, 20)
			SetSliderDialogInterval(1)
		ElseIf (a_option == OID_FatigueRate_S)
			SetSliderDialogStartValue(RND_SleepPoIntsPerHour.getValueInt())
			SetSliderDialogDefaultValue(4)
			SetSliderDialogRange(0, 20)
			SetSliderDialogInterval(1)
		ElseIf (a_option == OID_WeightRate_S)
			SetSliderDialogStartValue(RND_HoursThresholdGlobal.getValue())
			SetSliderDialogDefaultValue(1.0)
			SetSliderDialogRange(0.1, 2.0)
			SetSliderDialogInterval(0.1)
		ElseIf (a_option == OID_WeightPlayer_S)
			SetSliderDialogStartValue(RND_CurrentWeightGlobal.getValue())
			SetSliderDialogDefaultValue(0.0)
			SetSliderDialogRange(0.0, 100.0)
			SetSliderDialogInterval(1.0)			
		; Disease Chance
		ElseIf (a_option == OID_DiseaseChanceRawFood_S)
			SetSliderDialogStartValue(RND_DiseaseChanceRawFood.getValueInt())
			SetSliderDialogDefaultValue(15)
			SetSliderDialogRange(0, 100)
			SetSliderDialogInterval(1)
		ElseIf (a_option == OID_DiseaseChanceStaleFood_S)
			SetSliderDialogStartValue(RND_DiseaseChanceStaleFood.getValueInt())
			SetSliderDialogDefaultValue(25)
			SetSliderDialogRange(0, 100)
			SetSliderDialogInterval(1)
		ElseIf (a_option == OID_DiseaseChanceRiverWater_S)
			SetSliderDialogStartValue(RND_DiseaseChanceRiverWater.getValueInt())
			SetSliderDialogDefaultValue(10)
			SetSliderDialogRange(0, 100)
			SetSliderDialogInterval(1)
		ElseIf (a_option == OID_DiseaseChanceDirtyBedroll_S)
			SetSliderDialogStartValue(RND_DiseaseChanceDirtyBedroll.getValueInt())
			SetSliderDialogDefaultValue(10)
			SetSliderDialogRange(0, 100)
			SetSliderDialogInterval(1)
		; Alcoholic Beverage
		ElseIf (a_option == OID_AlcoholPoIntsWeak_S)
			SetSliderDialogStartValue(RND_AlcoholPoIntsWeak.getValueInt())
			SetSliderDialogDefaultValue(10)
			SetSliderDialogRange(0, 100)
			SetSliderDialogInterval(1)
		ElseIf (a_option == OID_AlcoholPoIntsNormal_S)
			SetSliderDialogStartValue(RND_AlcoholPoIntsNormal.getValueInt())
			SetSliderDialogDefaultValue(30)
			SetSliderDialogRange(0, 100)
			SetSliderDialogInterval(1)
		ElseIf (a_option == OID_AlcoholPoIntsStrong_S)
			SetSliderDialogStartValue(RND_AlcoholPoIntsStrong.getValueInt())
			SetSliderDialogDefaultValue(45)
			SetSliderDialogRange(0, 100)
			SetSliderDialogInterval(1)
		;Random Tripping
		ElseIf (a_option == OID_TrippingChance01_S)
			SetSliderDialogStartValue(RND_TrippingChance01.getValueInt())
			SetSliderDialogDefaultValue(5)
			SetSliderDialogRange(0, 100)
			SetSliderDialogInterval(1)
		ElseIf (a_option == OID_TrippingChance02_S)
			SetSliderDialogStartValue(RND_TrippingChance02.getValueInt())
			SetSliderDialogDefaultValue(25)
			SetSliderDialogRange(0, 100)
			SetSliderDialogInterval(1)
		ElseIf (a_option == OID_TrippingChance03_S)
			SetSliderDialogStartValue(RND_TrippingChance03.getValueInt())
			SetSliderDialogDefaultValue(50)
			SetSliderDialogRange(0, 100)
			SetSliderDialogInterval(1)
		; Reminder
		ElseIf (a_option == OID_ReminderInterval_S)
			SetSliderDialogStartValue(RND_ReminderInterval.getValueInt())
			SetSliderDialogDefaultValue(10)
			SetSliderDialogRange(3, 30)
			SetSliderDialogInterval(1)
		ElseIf (a_option == OID_ReminderSoundVolume_S)
			SetSliderDialogStartValue(RND_ReminderSoundVolume.getValueInt())
			SetSliderDialogDefaultValue(80)
			SetSliderDialogRange(10, 100)
			SetSliderDialogInterval(1)
			
		ElseIf (a_option == OID_FastTravelSlowRate_S)
			SetSliderDialogStartValue(RND_FastTravelSlowRate.getValueInt())
			SetSliderDialogDefaultValue(0)
			SetSliderDialogRange(0, 100)
			SetSliderDialogInterval(1)
		;
		ElseIf (a_option == OID_SpoilDaysCat0_S)
			SetSliderDialogStartValue(RND_SpoilDaysCat0.getValueInt())
			SetSliderDialogDefaultValue(3)
			SetSliderDialogRange(1, 14)
			SetSliderDialogInterval(1)
		ElseIf (a_option == OID_SpoilDaysCat1_S)
			SetSliderDialogStartValue(RND_SpoilDaysCat1.getValueInt())
			SetSliderDialogDefaultValue(6)
			SetSliderDialogRange(1, 14)
			SetSliderDialogInterval(1)
		ElseIf (a_option == OID_SpoilDaysCat2_S)
			SetSliderDialogStartValue(RND_SpoilDaysCat2.getValueInt())
			SetSliderDialogDefaultValue(5)
			SetSliderDialogRange(1, 14)
			SetSliderDialogInterval(1)
		ElseIf (a_option == OID_SpoilDaysCat3_S)
			SetSliderDialogStartValue(RND_SpoilDaysCat3.getValueInt())
			SetSliderDialogDefaultValue(7)
			SetSliderDialogRange(1, 14)
			SetSliderDialogInterval(1)
		ElseIf (a_option == OID_SpoilDaysCat4_S)
			SetSliderDialogStartValue(RND_SpoilDaysCat4.getValueInt())
			SetSliderDialogDefaultValue(2)
			SetSliderDialogRange(1, 14)
			SetSliderDialogInterval(1)
		ElseIf (a_option == OID_SpoilDaysCat5_S)
			SetSliderDialogStartValue(RND_SpoilDaysCat5.getValueInt())
			SetSliderDialogDefaultValue(4)
			SetSliderDialogRange(1, 14)
			SetSliderDialogInterval(1)
		ElseIf (a_option == OID_SpoilDaysCat6_S)
			SetSliderDialogStartValue(RND_SpoilDaysCat6.getValueInt())
			SetSliderDialogDefaultValue(3)
			SetSliderDialogRange(1, 14)
			SetSliderDialogInterval(1)
		ElseIf (a_option == OID_SpoilDaysCat7_S)
			SetSliderDialogStartValue(RND_SpoilDaysCat7.getValueInt())
			SetSliderDialogDefaultValue(2)
			SetSliderDialogRange(1, 14)
			SetSliderDialogInterval(1)
		ElseIf (a_option == OID_SpoilDaysCat8_S)
			SetSliderDialogStartValue(RND_SpoilDaysCat8.getValueInt())
			SetSliderDialogDefaultValue(3)
			SetSliderDialogRange(1, 14)
			SetSliderDialogInterval(1)
		ElseIf (a_option == OID_SpoilDaysCat9_S)
			SetSliderDialogStartValue(RND_SpoilDaysCat9.getValueInt())
			SetSliderDialogDefaultValue(3)
			SetSliderDialogRange(1, 14)
			SetSliderDialogInterval(1)
		ElseIf (a_option == HungerPosX)
			SetSliderDialogStartValue(HungerScript.X)
			SetSliderDialogRange(-100.00, 1380.00)
			SetSliderDialogInterval(1.00)
			SetSliderDialogDefaultValue(10.00)
		ElseIf (a_option == HungerPosY)
			SetSliderDialogStartValue(HungerScript.Y)
			SetSliderDialogRange(-100.00, 820.00)
			SetSliderDialogInterval(1.00)
			SetSliderDialogDefaultValue(710.00)	
		ElseIf (a_option == HungerAlpha)
			SetSliderDialogStartValue(HungerScript.Alpha)
			SetSliderDialogRange(0.00, 100.00)
			SetSliderDialogInterval(1.00)
			SetSliderDialogDefaultValue(100.00)
		ElseIf (a_option == HungerScale)
			SetSliderDialogStartValue(HungerScript.Size)
			SetSliderDialogRange(1.00, 1000.00)
			SetSliderDialogInterval(1.00)
			SetSliderDialogDefaultValue(100.00)
		ElseIf (a_option == ThirstPosX)
			SetSliderDialogStartValue(ThirstScript.X)
			SetSliderDialogRange(-100.00, 1380.00)
			SetSliderDialogInterval(1.00)
			SetSliderDialogDefaultValue(10.00)
		ElseIf (a_option == ThirstPosY)
			SetSliderDialogStartValue(ThirstScript.Y)
			SetSliderDialogRange(-100.00, 820.00)
			SetSliderDialogInterval(1.00)
			SetSliderDialogDefaultValue(710.00)	
		ElseIf (a_option == ThirstAlpha)
			SetSliderDialogStartValue(ThirstScript.Alpha)
			SetSliderDialogRange(0.00, 100.00)
			SetSliderDialogInterval(1.00)
			SetSliderDialogDefaultValue(100.00)
		ElseIf (a_option == ThirstScale)
			SetSliderDialogStartValue(ThirstScript.Size)
			SetSliderDialogRange(1.00, 1000.00)
			SetSliderDialogInterval(1.00)
			SetSliderDialogDefaultValue(100.00)
		ElseIf (a_option == SleepPosX)
			SetSliderDialogStartValue(SleepScript.X)
			SetSliderDialogRange(-100.00, 1380.00)
			SetSliderDialogInterval(1.00)
			SetSliderDialogDefaultValue(10.00)
		ElseIf (a_option == SleepPosY)
			SetSliderDialogStartValue(SleepScript.Y)
			SetSliderDialogRange(-100.00, 820.00)
			SetSliderDialogInterval(1.00)
			SetSliderDialogDefaultValue(710.00)	
		ElseIf (a_option == SleepAlpha)
			SetSliderDialogStartValue(SleepScript.Alpha)
			SetSliderDialogRange(0.00, 100.00)
			SetSliderDialogInterval(1.00)
			SetSliderDialogDefaultValue(100.00)
		ElseIf (a_option == SleepScale)
			SetSliderDialogStartValue(SleepScript.Size)
			SetSliderDialogRange(1.00, 1000.00)
			SetSliderDialogInterval(1.00)
			SetSliderDialogDefaultValue(100.00)		
		ElseIf (a_option == UpdateTimerInt)
			SetSliderDialogStartValue(UpdateScript.UpdateTimer)
			SetSliderDialogRange(0.1, 10.00)
			SetSliderDialogInterval(0.1)
			SetSliderDialogDefaultValue(0.25)
		ElseIf (a_option == InebriationPosX)
			SetSliderDialogStartValue(InebriationScript.X)
			SetSliderDialogRange(-100.00, 1380.00)
			SetSliderDialogInterval(1.00)
			SetSliderDialogDefaultValue(10.00)
		ElseIf (a_option == InebriationPosY)
			SetSliderDialogStartValue(InebriationScript.Y)
			SetSliderDialogRange(-100.00, 820.00)
			SetSliderDialogInterval(1.00)
			SetSliderDialogDefaultValue(710.00)	
		ElseIf (a_option == InebriationAlpha)
			SetSliderDialogStartValue(InebriationScript.Alpha)
			SetSliderDialogRange(0.00, 100.00)
			SetSliderDialogInterval(1.00)
			SetSliderDialogDefaultValue(100.00)
		ElseIf (a_option == InebriationScale)
			SetSliderDialogStartValue(InebriationScript.Size)
			SetSliderDialogRange(1.00, 1000.00)
			SetSliderDialogInterval(1.00)
			SetSliderDialogDefaultValue(100.00)
		ElseIf (a_option == WeightPosX)
			SetSliderDialogStartValue(WeightScript.X)
			SetSliderDialogRange(-100.00, 1380.00)
			SetSliderDialogInterval(1.00)
			SetSliderDialogDefaultValue(10.00)
		ElseIf (a_option == WeightPosY)
			SetSliderDialogStartValue(WeightScript.Y)
			SetSliderDialogRange(-100.00, 820.00)
			SetSliderDialogInterval(1.00)
			SetSliderDialogDefaultValue(710.00)	
		ElseIf (a_option == WeightAlpha)
			SetSliderDialogStartValue(WeightScript.Alpha)
			SetSliderDialogRange(0.00, 100.00)
			SetSliderDialogInterval(1.00)
			SetSliderDialogDefaultValue(100.00)
		ElseIf (a_option == WeightScale)
			SetSliderDialogStartValue(WeightScript.Size)
			SetSliderDialogRange(1.00, 1000.00)
			SetSliderDialogInterval(1.00)
			SetSliderDialogDefaultValue(100.00)				
		EndIf
EndEvent

Event OnOptionSliderAccept(Int a_option, float a_value)
	string page = CurrentPage

	If (a_option == OID_HungerRate_S)
		SetSliderOptionValue(a_option, a_value)
		RND_HungerPoIntsPerHour.setValue(a_value)
	ElseIf (a_option == OID_ThirstRate_S)
		SetSliderOptionValue(a_option, a_value)
		RND_ThirstPoIntsPerHour.setValue(a_value)
	ElseIf (a_option == OID_FatigueRate_S)
		SetSliderOptionValue(a_option, a_value)
		RND_SleepPoIntsPerHour.setValue(a_value)
	ElseIf (a_option == OID_WeightRate_S)
		SetSliderOptionValue(a_option, a_value)
		RND_HoursThresholdGlobal.setValue(a_value)
	ElseIf (a_option == OID_WeightPlayer_S)
		SetSliderOptionValue(a_option, a_value)
		RND_CurrentWeightGlobal.setValue(a_value)
		PlayerREF.GetActorBase().SetWeight(a_value)
		If !PlayerREF.IsOnMount()
			PlayerREF.QueueNiNodeUpdate()
		EndIf	
	ElseIf (a_option == OID_DiseaseChanceRawFood_S)
		SetSliderOptionValue(a_option, a_value, "{0}%")
		RND_DiseaseChanceRawFood.setValue(a_value)
	ElseIf (a_option == OID_DiseaseChanceStaleFood_S)
		SetSliderOptionValue(a_option, a_value, "{0}%")
		RND_DiseaseChanceStaleFood.setValue(a_value)
	ElseIf (a_option == OID_DiseaseChanceRiverWater_S)
		SetSliderOptionValue(a_option, a_value, "{0}%")
		RND_DiseaseChanceRiverWater.setValue(a_value)
	ElseIf (a_option == OID_DiseaseChanceDirtyBedroll_S)
		SetSliderOptionValue(a_option, a_value, "{0}%")
		RND_DiseaseChanceDirtyBedroll.setValue(a_value)
	
	ElseIf (a_option == OID_AlcoholPoIntsWeak_S)
		SetSliderOptionValue(a_option, a_value)
		RND_AlcoholPoIntsWeak.setValue(a_value)
	ElseIf (a_option == OID_AlcoholPoIntsNormal_S)
		SetSliderOptionValue(a_option, a_value)
		RND_AlcoholPoIntsNormal.setValue(a_value)
	ElseIf (a_option == OID_AlcoholPoIntsStrong_S)
		SetSliderOptionValue(a_option, a_value)
		RND_AlcoholPoIntsStrong.setValue(a_value)
		
	ElseIf (a_option == OID_TrippingChance01_S)
		SetSliderOptionValue(a_option, a_value, "{0}%")
		RND_TrippingChance01.setValue(a_value)
	ElseIf (a_option == OID_TrippingChance02_S)
		SetSliderOptionValue(a_option, a_value, "{0}%")
		RND_TrippingChance02.setValue(a_value)
	ElseIf (a_option == OID_TrippingChance03_S)
		SetSliderOptionValue(a_option, a_value, "{0}%")
		RND_TrippingChance03.setValue(a_value)	
		
	ElseIf (a_option == OID_ReminderInterval_S)
		SetSliderOptionValue(a_option, a_value)
		RND_ReminderInterval.setValue(a_value)
	ElseIf (a_option == OID_ReminderSoundVolume_S)
		SetSliderOptionValue(a_option, a_value)
		RND_ReminderSoundVolume.setValue(a_value)
		
	ElseIf (a_option == OID_FastTravelSlowRate_S)
		SetSliderOptionValue(a_option, a_value, "{0}%")
		RND_FastTravelSlowRate.setValue(a_value)
		
	ElseIf (a_option == OID_SpoilDaysCat0_S)
		SetSliderOptionValue(a_option, a_value)
		RND_SpoilDaysCat0.setValue(a_value)
	ElseIf (a_option == OID_SpoilDaysCat1_S)
		SetSliderOptionValue(a_option, a_value)
		RND_SpoilDaysCat1.setValue(a_value)
	ElseIf (a_option == OID_SpoilDaysCat2_S)
		SetSliderOptionValue(a_option, a_value)
		RND_SpoilDaysCat2.setValue(a_value)
	ElseIf (a_option == OID_SpoilDaysCat3_S)
		SetSliderOptionValue(a_option, a_value)
		RND_SpoilDaysCat3.setValue(a_value)
	ElseIf (a_option == OID_SpoilDaysCat4_S)
		SetSliderOptionValue(a_option, a_value)
		RND_SpoilDaysCat4.setValue(a_value)
	ElseIf (a_option == OID_SpoilDaysCat5_S)
		SetSliderOptionValue(a_option, a_value)
		RND_SpoilDaysCat5.setValue(a_value)
	ElseIf (a_option == OID_SpoilDaysCat6_S)
		SetSliderOptionValue(a_option, a_value)
		RND_SpoilDaysCat6.setValue(a_value)
	ElseIf (a_option == OID_SpoilDaysCat7_S)
		SetSliderOptionValue(a_option, a_value)
		RND_SpoilDaysCat7.setValue(a_value)
	ElseIf (a_option == OID_SpoilDaysCat8_S)
		SetSliderOptionValue(a_option, a_value)
		RND_SpoilDaysCat8.setValue(a_value)
	ElseIf (a_option == OID_SpoilDaysCat9_S)
		SetSliderOptionValue(a_option, a_value)
		RND_SpoilDaysCat9.setValue(a_value)
	ElseIf (a_option == HungerPosX)
		HungerScript.SetX(a_value)
		SetSliderOptionValue(a_option, HungerScript.X, "{0}")
	ElseIf (a_option == HungerPosY)
		HungerScript.SetY(a_value)
		SetSliderOptionValue(a_option, HungerScript.Y, "{0}")
	ElseIf (a_option == HungerAlpha)
		HungerScript.SetTransparency(a_value)
		SetSliderOptionValue(a_option, HungerScript.Alpha, "{0}")
	ElseIf (a_option == HungerScale)
		HungerScript.Size = a_value as Int
		SetSliderOptionValueST(a_option, HungerScript.Size, "{0}%")
		ForcePageReset()
	ElseIf (a_option == ThirstPosX)
		ThirstScript.SetX(a_value)
		SetSliderOptionValue(a_option, ThirstScript.X, "{0}")
	ElseIf (a_option == ThirstPosY)
		ThirstScript.SetY(a_value)
		SetSliderOptionValue(a_option, ThirstScript.Y, "{0}")
	ElseIf (a_option == ThirstAlpha)
		ThirstScript.SetTransparency(a_value)
		SetSliderOptionValue(a_option, ThirstScript.Alpha, "{0}")
	ElseIf (a_option == ThirstScale)
		ThirstScript.Size = a_value as Int
		SetSliderOptionValueST(a_option, ThirstScript.Size, "{0}%")
		ForcePageReset()
	ElseIf (a_option == SleepPosX)
		SleepScript.SetX(a_value)
		SetSliderOptionValue(a_option, SleepScript.X, "{0}")
	ElseIf (a_option == SleepPosY)
		SleepScript.SetY(a_value)
		SetSliderOptionValue(a_option, SleepScript.Y, "{0}")
	ElseIf (a_option == SleepAlpha)
		SleepScript.SetTransparency(a_value)
		SetSliderOptionValue(a_option, SleepScript.Alpha, "{0}")
	ElseIf (a_option == SleepScale)
		SleepScript.Size = a_value as Int
		SetSliderOptionValueST(a_option, SleepScript.Size, "{0}%")
		ForcePageReset()	
	ElseIf (a_option == UpdateTimerInt)
		UpdateScript.UpdateTimer = a_value
		SetSliderOptionValue(a_option, UpdateScript.UpdateTimer, "{0} sec.")
		ForcePageReset()
	ElseIf (a_option == InebriationPosX)
		InebriationScript.SetX(a_value)
		SetSliderOptionValue(a_option, InebriationScript.X, "{0}")
	ElseIf (a_option == InebriationPosY)
		InebriationScript.SetY(a_value)
		SetSliderOptionValue(a_option, InebriationScript.Y, "{0}")
	ElseIf (a_option == InebriationAlpha)
		InebriationScript.SetTransparency(a_value)
		SetSliderOptionValue(a_option, InebriationScript.Alpha, "{0}")
	ElseIf (a_option == InebriationScale)
		InebriationScript.Size = a_value as Int
		SetSliderOptionValueST(a_option, InebriationScript.Size, "{0}%")
		ForcePageReset()
	ElseIf (a_option == WeightPosX)
		WeightScript.SetX(a_value)
		SetSliderOptionValue(a_option, WeightScript.X, "{0}")
	ElseIf (a_option == WeightPosY)
		WeightScript.SetY(a_value)
		SetSliderOptionValue(a_option, WeightScript.Y, "{0}")
	ElseIf (a_option == WeightAlpha)
		WeightScript.SetTransparency(a_value)
		SetSliderOptionValue(a_option, WeightScript.Alpha, "{0}")
	ElseIf (a_option == WeightScale)
		WeightScript.Size = a_value as Int
		SetSliderOptionValueST(a_option, WeightScript.Size, "{0}%")
		ForcePageReset()		
	EndIf
EndEvent

Event OnOptionMenuOpen(Int a_option)
	If (a_option == HungerAnchorH)
		SetMenuDialogStartIndex(HAnchorHungerString.Find(HungerScript.HAnchor))
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(HAnchorHungerString)
	ElseIf (a_option == HungerAnchorV)
		SetMenuDialogStartIndex(VAnchorHungerString.Find(HungerScript.VAnchor))
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(VAnchorHungerString)
	ElseIf (a_option == ThirstAnchorH)
		SetMenuDialogStartIndex(HAnchorThirstString.Find(ThirstScript.HAnchor))
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(HAnchorThirstString)
	ElseIf (a_option == ThirstAnchorV)
		SetMenuDialogStartIndex(VAnchorThirstString.Find(ThirstScript.VAnchor))
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(VAnchorThirstString)
	ElseIf (a_option == SleepAnchorH)
		SetMenuDialogStartIndex(HAnchorSleepString.Find(SleepScript.HAnchor))
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(HAnchorSleepString)
	ElseIf (a_option == SleepAnchorV)
		SetMenuDialogStartIndex(VAnchorSleepString.Find(SleepScript.VAnchor))
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(VAnchorSleepString)
	ElseIf (a_option == InebriationAnchorH)
		SetMenuDialogStartIndex(HAnchorInebriationString.Find(InebriationScript.HAnchor))
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(HAnchorInebriationString)
	ElseIf (a_option == InebriationAnchorV)
		SetMenuDialogStartIndex(VAnchorInebriationString.Find(InebriationScript.VAnchor))
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(VAnchorInebriationString)
	ElseIf (a_option == WeightAnchorH)
		SetMenuDialogStartIndex(HAnchorWeightString.Find(WeightScript.HAnchor))
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(HAnchorWeightString)
	ElseIf (a_option == WeightAnchorV)
		SetMenuDialogStartIndex(VAnchorWeightString.Find(WeightScript.VAnchor))
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(VAnchorWeightString)		
	EndIf
EndEvent

Event OnOptionMenuAccept(Int a_option, Int Index)
	If (a_option == HungerAnchorH)
		HungerScript.HAnchor = HAnchorHungerString[Index]
		SetMenuOptionValue(a_option, HAnchorHungerString[HAnchorHungerString.Find(HungerScript.HAnchor)])
		If Index == 0
			HungerScript.X = 10
			ForcePageReset()
		ElseIf Index == 1
			HungerScript.X = 1270
			ForcePageReset()
		ElseIf Index == 2
			HungerScript.X = 630
			ForcePageReset()			
		EndIf
	ElseIf (a_option == HungerAnchorV)
		HungerScript.VAnchor = VAnchorHungerString[Index]
		SetMenuOptionValue(a_option, VAnchorHungerString[VAnchorHungerString.Find(HungerScript.VAnchor)])
		If Index == 0
			HungerScript.Y = 710
			ForcePageReset()
		ElseIf Index == 1
			HungerScript.Y = 10
			ForcePageReset()
		ElseIf Index == 2
			HungerScript.Y = 350
			ForcePageReset()			
		EndIf
	ElseIf (a_option == ThirstAnchorH)
		ThirstScript.HAnchor = HAnchorThirstString[Index]
		SetMenuOptionValue(a_option, HAnchorThirstString[HAnchorThirstString.Find(ThirstScript.HAnchor)])
		If Index == 0
			ThirstScript.X = 10
			ForcePageReset()
		ElseIf Index == 1
			ThirstScript.X = 1270
			ForcePageReset()
		ElseIf Index == 2
			ThirstScript.X = 630
			ForcePageReset()			
		EndIf
	ElseIf (a_option == ThirstAnchorV)
		ThirstScript.VAnchor = VAnchorThirstString[Index]
		SetMenuOptionValue(a_option, VAnchorThirstString[VAnchorThirstString.Find(ThirstScript.VAnchor)])
		If Index == 0
			ThirstScript.Y = 710
			ForcePageReset()
		ElseIf Index == 1
			ThirstScript.Y = 10
			ForcePageReset()
		ElseIf Index == 2
			ThirstScript.Y = 350
			ForcePageReset()			
		EndIf
	ElseIf (a_option == SleepAnchorH)
		SleepScript.HAnchor = HAnchorSleepString[Index]
		SetMenuOptionValue(a_option, HAnchorSleepString[HAnchorSleepString.Find(SleepScript.HAnchor)])
		If Index == 0
			SleepScript.X = 10
			ForcePageReset()
		ElseIf Index == 1
			SleepScript.X = 1270
			ForcePageReset()
		ElseIf Index == 2
			SleepScript.X = 630
			ForcePageReset()			
		EndIf
	ElseIf (a_option == SleepAnchorV)
		SleepScript.VAnchor = VAnchorSleepString[Index]
		SetMenuOptionValue(a_option, VAnchorSleepString[VAnchorSleepString.Find(SleepScript.VAnchor)])
		If Index == 0
			SleepScript.Y = 710
			ForcePageReset()
		ElseIf Index == 1
			SleepScript.Y = 10
			ForcePageReset()
		ElseIf Index == 2
			SleepScript.Y = 350
			ForcePageReset()			
		EndIf
	ElseIf (a_option == InebriationAnchorH)
		InebriationScript.HAnchor = HAnchorInebriationString[Index]
		SetMenuOptionValue(a_option, HAnchorInebriationString[HAnchorInebriationString.Find(InebriationScript.HAnchor)])
		If Index == 0
			InebriationScript.X = 10
			ForcePageReset()
		ElseIf Index == 1
			InebriationScript.X = 1270
			ForcePageReset()
		ElseIf Index == 2
			InebriationScript.X = 630
			ForcePageReset()			
		EndIf
	ElseIf (a_option == InebriationAnchorV)
		InebriationScript.VAnchor = VAnchorInebriationString[Index]
		SetMenuOptionValue(a_option, VAnchorInebriationString[VAnchorInebriationString.Find(InebriationScript.VAnchor)])
		If Index == 0
			InebriationScript.Y = 710
			ForcePageReset()
		ElseIf Index == 1
			InebriationScript.Y = 10
			ForcePageReset()
		ElseIf Index == 2
			InebriationScript.Y = 350
			ForcePageReset()			
		EndIf
	ElseIf (a_option == WeightAnchorH)
		WeightScript.HAnchor = HAnchorWeightString[Index]
		SetMenuOptionValue(a_option, HAnchorWeightString[HAnchorWeightString.Find(WeightScript.HAnchor)])
		If Index == 0
			WeightScript.X = 10
			ForcePageReset()
		ElseIf Index == 1
			WeightScript.X = 1270
			ForcePageReset()
		ElseIf Index == 2
			WeightScript.X = 630
			ForcePageReset()			
		EndIf
	ElseIf (a_option == WeightAnchorV)
		WeightScript.VAnchor = VAnchorWeightString[Index]
		SetMenuOptionValue(a_option, VAnchorWeightString[VAnchorWeightString.Find(WeightScript.VAnchor)])
		If Index == 0
			WeightScript.Y = 710
			ForcePageReset()
		ElseIf Index == 1
			WeightScript.Y = 10
			ForcePageReset()
		ElseIf Index == 2
			WeightScript.Y = 350
			ForcePageReset()			
		EndIf		
	EndIf	
EndEvent		


Event OnOptionHighlight(Int option)
	
	If (option == OID_HungerRate_S)
		SetInfoText("$RNDOptionHighlightHungerText")
		
	ElseIf (option == OID_ThirstRate_S)
		SetInfoText("$RNDOptionHighlightThirstText")
		
	ElseIf (option == OID_FatigueRate_S)
		SetInfoText("$RNDOptionHighlightSleepText")
		
	ElseIf (option == OID_WeightRate_S)
		SetInfoText("$RNDOptionHighlightWeightText")

	ElseIf (option == OID_WeightPlayer_S)
		SetInfoText("$RNDOptionHighlightWeightPlayerText")			
		
	ElseIf (option == OID_AlcoholPoIntsWeak_S) || (option == OID_AlcoholPoIntsNormal_S) || (option == OID_AlcoholPoIntsStrong_S)
		SetInfoText("$RNDOptionHighlightAlcoholText")
		
	ElseIf (option == OID_AnimEat) || (option == OID_AnimDrink) || (option == OID_AnimRefill) || (option == OID_AnimInebriation) || (option == OID_AnimMisc)
		SetInfoText("$RNDOptionHighlightAnimationText")
	
	ElseIf (option == OID_ReminderSound)
		SetInfoText("$RNDOptionHighlightSoundNotificationText")
	
	ElseIf (option == OID_ForceSatiation)
		SetInfoText("$RNDOptionHighlightForceSatiationText")
		
	ElseIf (option == OID_DieOfThirst)
		SetInfoText("$RNDOptionHighlightDieOfThirstText")
	ElseIf (option == OID_NoWeight)
		SetInfoText("$RNDOptionHighlightNoWeightText")		
		
	ElseIf (Option == KeyQuickCustomize)
		SetInfoText("$RND_DefineFoodHotkey")
		
	ElseIf (Option == KeyQuickWidget)
		SetInfoText("$RND_DefineWidgetHotkey")

	ElseIf (Option == KeyQuickWait)
		SetInfoText("$RND_DefineWaitHotkey")			
		
	ElseIf (Option == OID_WaterWell)
		SetInfoText("$RND_WaterWellsDescr")
		
	ElseIf (Option == OID_GrillFood)
		SetInfoText("$RND_GrillFoodDescr")		
		
	;ElseIf (Option == OID_NoPenalty)
	;	SetInfoText("$RND_NoPenaltyDescr")			
		
	ElseIf (option == OID_DebugMode)
		SetInfoText("$RNDOptionHighlightDebugModeText")
	
	ElseIf (option == OID_HidePowers)
		SetInfoText("$RNDOptionHighlightHidePowersText")
	
	ElseIf (option == OID_CanMilkCow)
		SetInfoText("$RNDOptionHighlightCanMilkCowText")
	
	ElseIf (option == OID_DiseaseFatigue)
		SetInfoText("$RNDOptionHighlightDiseaseFatigueText")
		
	ElseIf (option == OID_MortalVamp)
		SetInfoText("$RNDOptionHighlightMortalVampText")
	
	ElseIf (option == OID_HideCampingGear)
		SetInfoText("$RNDOptionHighlightHideCampingGearText")
		
	ElseIf (option == OID_CleanCookMenu)
		SetInfoText("$RNDOptionHighlightCleanCookMenuText")

	ElseIf (option == OID_ShrinesCureDisease)
		SetInfoText("$RNDOptionHighlightShrinesCureDiseaseText")
		
	ElseIf (option == OID_1stPersonMsg)
		SetInfoText("$RNDOptionHighlight1stPersonMsgText")
	
	ElseIf (option == OID_DrinkWaterKey_K)
		SetInfoText("$RNDOptionHighlightDrinkWaterKeyText")
		
	ElseIf (option == OID_RemoveSpoiledFood)
		SetInfoText("$RNDOptionHighlightRemoveSpoiledFoodText")	
	
	ElseIf (option == OID_IsmInebriation)
		SetInfoText("$RNDOptionHighlightIsmInebriationText")
		
	ElseIf (Option == HungerWidget)
		SetInfoText("$RND_HungerCountDescr")
	ElseIf (Option == HungerPosX)
		SetInfoText("$RND_HungerHorDescr")
	ElseIf (Option == HungerPosY)
		SetInfoText("$RND_HungerVerDescr")
	ElseIf (Option == HungerAnchorH)
		SetInfoText("$RND_HungerHorAnchDescr")
	ElseIf (Option == HungerAnchorV)
		SetInfoText("$RND_HungerVerAnchDescr")
	ElseIf (Option == HungerAlpha)
		SetInfoText("$RND_HungerAlphaDescr")
	ElseIf (Option == HungerScale)
		SetInfoText("$RND_HungerScaleDescr")
	ElseIf (Option == ThirstWidget)
		SetInfoText("$RND_ThirstCountDescr")
	ElseIf (Option == ThirstPosX)
		SetInfoText("$RND_ThirstHorDescr")
	ElseIf (Option == ThirstPosY)
		SetInfoText("$RND_ThirstVerDescr")
	ElseIf (Option == ThirstAnchorH)
		SetInfoText("$RND_ThirstHorAnchDescr")
	ElseIf (Option == ThirstAnchorV)
		SetInfoText("$RND_ThirstVerAnchDescr")
	ElseIf (Option == ThirstAlpha)
		SetInfoText("$RND_ThirstAlphaDescr")
	ElseIf (Option == ThirstScale)
		SetInfoText("$RND_ThirstScaleDescr")
	ElseIf (Option == SleepWidget)
		SetInfoText("$RND_SleepCountDescr")
	ElseIf (Option == SleepPosX)
		SetInfoText("$RND_SleepHorDescr")
	ElseIf (Option == SleepPosY)
		SetInfoText("$RND_SleepVerDescr")
	ElseIf (Option == SleepAnchorH)
		SetInfoText("$RND_SleepHorAnchDescr")
	ElseIf (Option == SleepAnchorV)
		SetInfoText("$RND_SleepVerAnchDescr")
	ElseIf (Option == SleepAlpha)
		SetInfoText("$RND_SleepAlphaDescr")
	ElseIf (Option == SleepScale)
		SetInfoText("$RND_SleepScaleDescr")	
	ElseIf (Option == AutoWidget)
		SetInfoText("$RND_AutoWidgetDescr")		
	ElseIf (Option == UpdateTimerInt)
		SetInfoText("$RND_UpdateIntervalDescr")
	ElseIf (Option == InebriationWidget)
		SetInfoText("$RND_InebriationCountDescr")
	ElseIf (Option == InebriationPosX)
		SetInfoText("$RND_InebriationHorDescr")
	ElseIf (Option == InebriationPosY)
		SetInfoText("$RND_InebriationVerDescr")
	ElseIf (Option == InebriationAnchorH)
		SetInfoText("$RND_InebriationHorAnchDescr")
	ElseIf (Option == InebriationAnchorV)
		SetInfoText("$RND_InebriationVerAnchDescr")
	ElseIf (Option == InebriationAlpha)
		SetInfoText("$RND_InebriationAlphaDescr")
	ElseIf (Option == InebriationScale)
		SetInfoText("$RND_InebriationScaleDescr")
	ElseIf (Option == WeightWidget)
		SetInfoText("$RND_WeightCountDescr")
	ElseIf (Option == WeightPosX)
		SetInfoText("$RND_WeightHorDescr")
	ElseIf (Option == WeightPosY)
		SetInfoText("$RND_WeightVerDescr")
	ElseIf (Option == WeightAnchorH)
		SetInfoText("$RND_WeightHorAnchDescr")
	ElseIf (Option == WeightAnchorV)
		SetInfoText("$RND_WeightVerAnchDescr")
	ElseIf (Option == WeightAlpha)
		SetInfoText("$RND_WeightAlphaDescr")
	ElseIf (Option == WeightScale)
		SetInfoText("$RND_WeightScaleDescr")				
	EndIf
	
EndEvent

Event OnKeyDown(Int aiKeyCode)

	If aiKeyCode == KeyCustomize
		If self.CheckValidState(PlayerREF) == true	
			ObjectReference SelectedRef = Game.GetCurrentCrosshairRef() as ObjectReference
			Potion SelectedFood = SelectedRef.GetBaseObject() as Potion
			If (SelectedFood.HasKeyword(VendorItemFood) || SelectedFood.HasKeyword(VendorItemFoodRaw)) && !RND_VanillaFoodList.HasForm(SelectedFood)
				If (!RND_RawFoodList.HasForm(SelectedFood) && !RND_SnackFoodList.HasForm(SelectedFood) && !RND_MediumFoodList.HasForm(SelectedFood) && !RND_AbundantFoodList.HasForm(SelectedFood) && !RND_BeverageList.HasForm(SelectedFood) && !RND_AlcoholBeverageList.HasForm(SelectedFood))
					Int iButton = RND_CustomizeFoodMessage.Show() as Int
					If iButton == 0
						RND_RawFoodList.AddForm(SelectedFood)
						SelectedFood.SetName(SelectedFood.GetName() + " (Raw Food)")
					ElseIf iButton == 1
						RND_SnackFoodList.AddForm(SelectedFood)
						SelectedFood.SetName(SelectedFood.GetName() + " (Snack)")					
					ElseIf iButton == 2
						RND_MediumFoodList.AddForm(SelectedFood)
						SelectedFood.SetName(SelectedFood.GetName() + " (Medium Meal)")					
					ElseIf iButton == 3
						RND_AbundantFoodList.AddForm(SelectedFood)
						SelectedFood.SetName(SelectedFood.GetName() + " (Abundant Meal)")					
					ElseIf iButton == 4
						RND_BeverageList.AddForm(SelectedFood)
						SelectedFood.SetName(SelectedFood.GetName() + " (Beverage)")					
					ElseIf iButton == 5
						RND_AlcoholBeverageList.AddForm(SelectedFood)
						SelectedFood.SetName(SelectedFood.GetName() + " (Alcohol)")					
					ElseIf iButton == 6
						return
					EndIf
				ElseIf (RND_RawFoodList.HasForm(SelectedFood) || RND_SnackFoodList.HasForm(SelectedFood) || RND_MediumFoodList.HasForm(SelectedFood) || RND_AbundantFoodList.HasForm(SelectedFood) || RND_BeverageList.HasForm(SelectedFood) || RND_AlcoholBeverageList.HasForm(SelectedFood))
					Debug.Messagebox("This item is already classIfied as functional food, no adaption needed!")	
				EndIf	
			ElseIf (SelectedFood.HasKeyword(VendorItemFood) || SelectedFood.HasKeyword(VendorItemFoodRaw)) && RND_VanillaFoodList.HasForm(SelectedFood)
				Debug.Messagebox("This item is food by default, no adaption needed!")
			EndIf
		EndIf	
	ElseIf aiKeyCode == KeyWidget
		If self.CheckValidState(PlayerREF) == true		
			HungerScript.WidgetFade()
			ThirstScript.WidgetFade()
			SleepScript.WidgetFade()
			InebriationScript.WidgetFade()
			WeightScript.WidgetFade()
		EndIf	
	ElseIf aiKeyCode == KeyWait
	
		Int WaitKey = Input.GetMappedKey("Wait") as Int
		DefaultSleepPoints = RND_SleepPointsPerHour.GetValue() as Int
	
		If self.CheckValidState(PlayerREF) == true
			game.ForceThirdPerson()
			If PlayerREF.IsInCombat() == false
				PlayerREF.playIdle(DefaultSheathe)
				RND_SleepPointsPerHour.SetValue(RND_SleepPointsPerHour.GetValue() / 2)
				Utility.Wait(2.0)
				If PlayerREF.GetSitState() == 3
					input.TapKey(WaitKey)
					Rest()
				Else
					debug.sendAnimationEvent(PlayerREF as objectreference, "IdleSitCrossleggedEnter")
					Utility.Wait(2.0)
					input.TapKey(WaitKey)
					Rest()
				EndIf
			EndIf
		EndIf
		
	EndIf

EndEvent

Bool function CheckValidState(actor ActorPlayer)

	If Utility.IsInMenuMode()
		return false
	EndIf
	If UI.IsTextInputEnabled()
		return false
	EndIf
	If UI.IsMenuOpen("Crafting Menu")
		return false
	EndIf
	If UI.IsMenuOpen("Dialogue Menu")
		return false
	EndIf
	If UI.IsMenuOpen("RaceSex Menu")
		return false
	EndIf	
	If ActorPlayer.IsBleedingOut()
		return false
	EndIf
	If ActorPlayer.IsInCombat()
		debug.Notification("You can not wait while in combat!")
		return false
	EndIf
	If ActorPlayer.IsDead()
		return false
	EndIf
	If ActorPlayer.IsInKillMove()
		return false
	EndIf
	If ActorPlayer.IsOnMount()
		return false
	EndIf
	If ActorPlayer.GetSleepState() != 0
		debug.Notification("You can not wait while sleeping!")
		return false
	EndIf
	If ActorPlayer.IsSwimming()
		debug.Notification("You can not wait while swimming!")
		return false
	EndIf
	If ActorPlayer.IsUnconscious()
		return false
	EndIf
	
	return true
	
EndFunction

Function Rest()

	PlayerREF.RestoreActorValue("health", 1000)		
	debug.sendAnimationEvent(PlayerREF, "Idlechairexitstart")
	RND_SleepPointsPerHour.SetValue(DefaultSleepPoints)
	
EndFunction	

Function toggle(GlobalVariable gVar)
	If gVar.getValueInt() == 0
		gVar.setValueInt(1)
	Else
		gVar.setValueInt(0)
	EndIf
EndFunction

Function RND_Start()

	If RND_State.GetValue() == 0
		RND_State.SetValue(1)
		RNDTrackingQuest.Start()
		RNDReminderQuest.Start()
		RNDSpoilageQuest.Start()
		RND_InitNeedsSpell.Cast(Game.GetPlayer(), Game.GetPlayer())
	EndIf
	
Endfunction

Function RND_Stop()
	If RND_State.GetValue() == 1
		RND_State.SetValue(0)
		RNDSpoilageQuest.Stop()
		RNDReminderQuest.Stop()
		RNDTrackingQuest.Stop()
		RND_RemoveNeedsSpell.Cast(Game.GetPlayer(), Game.GetPlayer())
		RND_CureDiseaseSpell.Cast(Game.GetPlayer(), Game.GetPlayer())
		RND_WaterSourceToggle = false
		RND_WaterWellGlobal.SetValue(0)
		RND_GrillFoodToggle = false
		RND_GrillFoodGlobal.SetValue(0)		
		PlayerREF.RemovePerk(RND_WaterWellPerk)
		PlayerREF.RemovePerk(RND_GrillFoodPerk)			
	EndIf
EndFunction

Function InitKeys(Int aiDXScanCode = 0)

	RegisterForKey(KeyCustomize)
	RegisterForKey(KeyWidget)
	RegisterForKey(KeyWait)
	
	;If 	RND_NoPenaltyGlobal.GetValue() == 0
	
	;	RND_HungerSpell05.SetNthEffectMagnitude(1, 0.0)
	;	RND_SleepSpell02.SetNthEffectMagnitude(0, 0.0)
	;	RND_SleepSpell03.SetNthEffectMagnitude(0, 0.0)
	;	RND_SleepSpell04.SetNthEffectMagnitude(0, 0.0)	
		
	;ElseIf RND_NoPenaltyGlobal.GetValue() == 1
	
	;	RND_HungerSpell05.SetNthEffectMagnitude(1, 50.0)
	;	RND_SleepSpell02.SetNthEffectMagnitude(0, 30.0)
	;	RND_SleepSpell03.SetNthEffectMagnitude(0, 60.0)
	;	RND_SleepSpell04.SetNthEffectMagnitude(0, 90.0)	
		
	;EndIf	

EndFunction