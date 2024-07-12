Scriptname mndMCM Extends SKI_ConfigBase


; ((- Variables and arrays
mndController Property mnd Auto
mndShowersScript Property mndShowers Auto
Armor Property mndPee0 Auto
Armor Property mndPee1 Auto

int pageMode ; 0=main, 10=needs, 11=basic needs, 12=physio needs, 13=adult needs, 15=NeedsPenalties, 30=Widgets, 31=EnDisWidgets, 32=WidgetsColors, 40=UnknownFood
string[] Property wOpacities Auto
string[] Property wPositions Auto
string[] Property wArrangementsTB Auto
string[] Property wArrangementsLR Auto
string[] Property wSizes Auto
string[] Property wGrouping Auto
string[] Property howToPissPoop Auto
string[] Property penaltyModes Auto
string[] Property penaltyNames Auto
string[] Property stripModes Auto
string[] Property foodPossibilities Auto
string[] Property notificationsTimes Auto
string[] Property currentNeedNames Auto
string[] Property useNutritionValues Auto
string[] Property addPuddles Auto
string[] Property unknowFoodModes Auto
string[] possibleJSONs
bool possibleJSONsLoaded
int[] Property opts Auto
int numOpts
int currentNeed
bool needToSaveJson = false
int selectedJSONFile = -1
string saveFileName
int unknowFoodMode = 2
int[] penaltiesToApply
int numPenaltiesToApply
; -))

Function doInit()
	if pages.length!=9
		pages = new string[9]
	endIf
	Pages[0] = "$MDN_PageMain"
	Pages[1] = "$MDN_PageNeedsBasic"
	Pages[2] = "$MDN_PageNeedsSocial"
	Pages[3] = "$MDN_PageNeedsPhysio"
	Pages[4] = "$MDN_PageNeedsAdult"
	Pages[5] = "$MDN_PageNeedsPenalties"
	Pages[6] = "$MDN_PageWidgets"
	Pages[7] = "$MDN_PageUnrecognized"
	Pages[8] = "$MDN_PageApplyPenalties"
	
	if mnd.weHaveSexLab
		if stripModes.length!=8
			stripModes = Utility.ResizeStringArray(stripModes, 8)
			stripModes[4] = "$MND_StripModes4"
			stripModes[5] = "$MND_StripModes5"
			stripModes[6] = "$MND_StripModes6"
			stripModes[7] = "$MND_StripModes7"
		endIf
	else
		if stripModes.length!=4
			stripModes = Utility.ResizeStringArray(stripModes, 4)
		endIf
	endIf

	if mnd.weHaveSexLab
		penaltyNames[43] = "$MND_DamageMasturbateUse{"
	else
		penaltyNames[43] = "$MND_Unavailable{"
	endIf
	
	if !penaltiesToApply
		penaltiesToApply = new int[64]
	endIf
	while numPenaltiesToApply
		numPenaltiesToApply-=1
		penaltiesToApply[numPenaltiesToApply]=-1
	endWhile
	
	possibleJSONsLoaded = false
	selectedJSONFile = -1
	saveFileName = ""
endFunction

int Function getVersion()
	return 3200
endFunction

Event OnConfigOpen()
	doInit()
	needToSaveJson = false
EndEvent

Event OnConfigClose()
	mnd.applyConfig()
	mnd.initWidgets()
	mnd.calculateWidgets()
	if needToSaveJson
		mnd.saveFoodJson("")
	endIf
	while numPenaltiesToApply
		numPenaltiesToApply-=1
		int modeventid = ModEvent.Create("MiniNeedsApplyPenalty")
		ModEvent.PushInt(modeventid, penaltiesToApply[numPenaltiesToApply])
		ModEvent.Send(modeventid)
	endWhile
endEvent

Event OnPageReset(string page)
	if page==""
		LoadCustomContent("MiniNeeds/mndMiniNeeds.dds", 12, 0)
		return
	endIf
	UnloadCustomContent()

	; 0=main, 1=Load/Save, 10=needs, 11=basic needs, 12=physio needs, 13=adult needs, 14=Social needs, 20=NeedsPenalties, 21=DefineNeedPenalties, 30=Widgets, 31=EnDisWidgets, 32=WidgetsColors, 40=UnknownFood

	if page=="Main" || page=="$MDN_PageMain"
		if pageMode==1
			generateLoadSave()
		else
			generateMain()
		endIf
	elseIf page=="Basic Needs" || page=="$MDN_PageNeedsBasic"
		pageMode=11
		generateBasicNeeds()
	elseIf page=="Social Needs" || page=="$MDN_PageNeedsSocial"
		pageMode=14
		generateSocialNeeds()
	elseIf page=="Physio Needs" || page=="$MDN_PageNeedsPhysio"
		pageMode=12
		generatePhysiologicalNeeds()
	elseIf page=="Adult Needs" || page=="$MDN_PageNeedsAdult"
		pageMode=13
		generateAdultNeeds()
	elseIf page=="Needs Penalties" || page=="$MDN_PageNeedsPenalties"
		if pageMode==21
			generateDefineNeedPenalties()
		else
			generateNeedsPenalties()
		endIf
	elseIf page=="Widgets" || page=="$MDN_PageWidgets"
		if pageMode==31
			generateEnableWidgets()
		elseIf pageMode==32
			generateWidgetColors()
		else
			generateWidgets()
		endIf
	elseIf page=="Unknown food" || page=="$MDN_PageUnrecognized"
		pageMode=40
		generateUnknownFood()
	elseIf page=="Apply Penalties" || page=="$MDN_PageApplyPenalties"
		pageMode=22
		generateApplyPenalties()
	endIf
EndEvent

function generateMain()
	SetCursorFillMode(TOP_TO_BOTTOM)
	AddTextOption("Mini Needs V3.2 by CPU", "", OPTION_FLAG_DISABLED)
	
	SetCursorPosition(6)
	AddTextOptionST("FreePlayerBN", "$MND_FreePlayer", "$MND_Clear")
	if mnd.weHavePapyrusUtils
		AddTextOptionST("LoadSaveConfigBN", "$MND_LoadSaveConfig", "$MND_Go")
	else
		AddEmptyOption()
	endIf
	AddEmptyOption()
	AddToggleOptionST("EnableStaticShowersTG", "$MND_EnableStaticShowers", mnd.enableStaticShowers)
	AddMenuOptionST("UseNutritionValuesMN", "$MND_UseNutritionValues", useNutritionValues[mnd.useNutritionValues])
	AddToggleOptionST("ReverseWidgetsTG", "$MND_ReverseWidgets", mnd.reverseWidgets)
	

	SetCursorPosition(1)
	AddToggleOptionST("useTimeScaleTG", "$MND_useTimeScale", mnd.useTimeScale)
	AddEmptyOption()
	AddMenuOptionST("StripModeMN", "$MND_StripMode", stripModes[mnd.stripMode])
	AddEmptyOption()
	AddToggleOptionST("useAnimForEatingTG", "$MND_useAnimForEating", mnd.useAnimForEating)
	AddToggleOptionST("useAnimForDrinkingTG", "$MND_useAnimForDrinking", mnd.useAnimForDrinking)
	AddToggleOptionST("useAnimForPissingTG", "$MND_useAnimForPissing", mnd.useAnimForPissing)
	AddToggleOptionST("useAnimForPoopingTG", "$MND_useAnimForPooping", mnd.useAnimForPooping)
	AddEmptyOption()

	AddMenuOptionST("NotificationsTimeMN", "$MND_NotificationsTime", notificationsTimes[mnd.notificationsTime])
	
	SetCursorPosition(23)
	if mnd.disableTheMod
		AddTextOptionST("DisableModBN", "$MND_Moddisabled", "$MND_Reactivate")
	else
		AddTextOptionST("DisableModBN", "$MND_Disablethemod", "$MND_Disable")
	endIf
endFunction


function generateLoadSave()
	if !mnd.weHavePapyrusUtils
		AddTextOption("$MND_PapyrusUtilNotAvailable", "")
		return
	endIf
	if !possibleJSONsLoaded
		possibleJSONs = JSONUtil.JsonInFolder("../MiniNeeds")
	endIf

	SetCursorFillMode(TOP_TO_BOTTOM)
	AddHeaderOption("$MND_LoadConfig")
	if !possibleJSONs
		AddTextOption("$MND_NoJSONFilesFound", "...", OPTION_FLAG_DISABLED)
	else
		if selectedJSONFile==-1
			AddMenuOptionST("JsonToLoadMN", "$MND_JsonToLoad", "$MND_Select...")
			AddTextOptionST("LoadConfigFromJSONBN", "$MND_LoadConfigFromJson", "$MND_Load", OPTION_FLAG_DISABLED)
		else
			AddMenuOptionST("JsonToLoadMN", "$MND_JsonToLoad", possibleJSONs[selectedJSONFile])
			AddTextOptionST("LoadConfigFromJSONBN", "$MND_LoadConfigFromJson", "$MND_Load")
		endIf
	endIf
	SetCursorPosition(22)
	AddTextOptionST("GoBackBN", "$MND_GoBack", "$MND_Back")

	
	SetCursorPosition(1)
	AddHeaderOption("$MND_SaveConfig")
	AddInputOptionST("SaveConfigNameIN", "$MND_SaveConfigName", saveFileName)
	AddTextOptionST("SaveConfigToJSONBN", "$MND_SaveConfigToJson", "$MND_Save")
	AddEmptyOption()
	AddInputOptionST("SavePenaltiesConfigNameIN", "$MND_SavePenaltiesConfigName", saveFileName)
	AddTextOptionST("SavePenaltiesConfigToJSONBN", "$MND_SavePenaltiesConfigToJson", "$MND_Save")
	AddEmptyOption()
	AddInputOptionST("SaveFoodConfigNameIN", "$MND_SaveFoodConfigName", saveFileName)
	AddTextOptionST("SaveFoodConfigToJSONBN", "$MND_SaveFoodConfigToJson", "$MND_Save")
endFunction

function generateBasicNeeds()
	SetCursorFillMode(TOP_TO_BOTTOM)
	AddToggleOptionST("EnableEatTG", "$MND_EnableEating", mnd.enableEat)
	if mnd.enableEat
		AddSliderOptionST("TimeEatST", "$MND_MaxTimeForEating", mnd.timeEat, "$MND_hours")
		AddSliderOptionST("maxEatDamageST", "$MND_MaxEatDamage", mnd.maxEatDamage, "$MND_percent")
	else
		AddSliderOptionST("TimeEatST", "$MND_MaxTimeForEating", mnd.timeEat, "$MND_hours", OPTION_FLAG_DISABLED)
		AddSliderOptionST("maxEatDamageST", "$MND_MaxEatDamage", mnd.maxEatDamage, "$MND_percent", OPTION_FLAG_DISABLED)
	endIf
	AddEmptyOption()
	
	AddToggleOptionST("EnableDrinkTG", "$MND_EnableDrinking", mnd.enableDrink)
	if mnd.enableDrink
		AddSliderOptionST("TimeDrinkST", "$MND_Maxtimefordrinking", mnd.timeDrink, "$MND_hours")
		AddSliderOptionST("maxDrinkDamageST", "$MND_MaxDrinkDamage", mnd.maxDrinkDamage, "$MND_percent")
	else
		AddSliderOptionST("TimeDrinkST", "$MND_Maxtimefordrinking", mnd.timeDrink, "$MND_hours", OPTION_FLAG_DISABLED)
		AddSliderOptionST("maxDrinkDamageST", "$MND_MaxDrinkDamage", mnd.maxDrinkDamage, "$MND_percent", OPTION_FLAG_DISABLED)
	endIf
	
	SetCursorPosition(1)
	AddToggleOptionST("EnableSleepTG", "$MND_EnableSleeping", mnd.enableSleep)
	if mnd.enableSleep
		AddSliderOptionST("TimeSleepST", "$MND_Maxtimeforsleeping", mnd.timeSleep, "$MND_hours")
		AddSliderOptionST("maxSleepDamageST", "$MND_MaxSleepDamage", mnd.maxSleepDamage, "$MND_percent")
	else
		AddSliderOptionST("TimeSleepST", "$MND_Maxtimeforsleeping", mnd.timeSleep, "$MND_hours", OPTION_FLAG_DISABLED)
		AddSliderOptionST("maxSleepDamageST", "$MND_MaxSleepDamage", mnd.maxSleepDamage, "$MND_percent", OPTION_FLAG_DISABLED)
	endIf
	AddEmptyOption()

endFunction

function generateSocialNeeds()
	SetCursorFillMode(TOP_TO_BOTTOM)
	AddToggleOptionST("EnableBathTG", "$MND_EnableBath", mnd.enableBath)
	if mnd.enableBath
		AddSliderOptionST("TimeBathST", "$MND_MaxTimeForBath", mnd.timeBath, "$MND_hours")
		AddSliderOptionST("maxBathST", "$MND_MaxBathDamage", mnd.maxBathDamage, "$MND_percent")
		AddMenuOptionST("HowToBathInRiversMN", "$MND_HowToBathInRivers", howToPissPoop[mnd.howToBathInRivers])
		if mnd.howToBathInRivers==2
			AddKeyMapOptionST("keyToBathInRiversKM", "$MND_KeyToBathInRivers", mnd.keyToBathInRivers)
		else
			AddEmptyOption()
		endIf
		AddSliderOptionST("bathDurationST", "$MND_BathDuration", mnd.bathDuration, "$MND_seconds")
		if mnd.weHaveSexLab
			AddToggleOptionST("noDirtShaderWhileCumTG", "$MND_noDirtShaderWhileCum", mnd.noDirtShaderWhileCum)
		endIf
	else
		AddSliderOptionST("TimeBathST", "$MND_MaxTimeForBath", mnd.timeBath, "$MND_hours", OPTION_FLAG_DISABLED)
		AddSliderOptionST("maxBathST", "$MND_MaxBathDamage", mnd.maxBathDamage, "$MND_percent", OPTION_FLAG_DISABLED)
		AddMenuOptionST("HowToBathInRiversMN", "$MND_HowToBathInRivers", howToPissPoop[mnd.howToBathInRivers], OPTION_FLAG_DISABLED)
		if mnd.howToBathInRivers==2
			AddKeyMapOptionST("keyToBathInRiversKM", "$MND_KeyToBathInRivers", mnd.keyToBathInRivers, OPTION_FLAG_DISABLED)
		else
			AddEmptyOption()
		endIf
		AddSliderOptionST("bathDurationST", "$MND_BathDuration", mnd.bathDuration, "$MND_seconds", OPTION_FLAG_DISABLED)
		if mnd.weHaveSexLab
			AddToggleOptionST("noDirtShaderWhileCumTG", "$MND_noDirtShaderWhileCum", mnd.noDirtShaderWhileCum, OPTION_FLAG_DISABLED)
		endIf
	endIf
	AddEmptyOption()
	
	AddToggleOptionST("EnablePrayTG", "$MND_EnablePray", mnd.enablePray)
	if mnd.enablePray
		AddSliderOptionST("TimePrayST", "$MND_MaxTimeForPray", mnd.timePray, "$MND_hours")
		AddSliderOptionST("maxPrayST", "$MND_MaxPrayDamage", mnd.maxPrayDamage, "$MND_percent")
	else
		AddSliderOptionST("TimePrayST", "$MND_MaxTimeForPray", mnd.timePray, "$MND_hours", OPTION_FLAG_DISABLED)
		AddSliderOptionST("maxPrayST", "$MND_MaxPrayDamage", mnd.maxPrayDamage, "$MND_percent", OPTION_FLAG_DISABLED)
	endIf
	AddEmptyOption()
	
	SetCursorPosition(1)
	AddToggleOptionST("EnableTalkTG", "$MND_EnableTalk", mnd.enableTalk)
	if mnd.enableTalk
		AddSliderOptionST("TimeTalkST", "$MND_MaxtimeforTalk", mnd.timeTalk, "$MND_hours")
		AddSliderOptionST("maxTalkDamageST", "$MND_MaxTalkDamage", mnd.maxTalkDamage, "$MND_percent")
	else
		AddSliderOptionST("TimeTalkST", "$MND_MaxtimeforTalk", mnd.timeTalk, "$MND_hours", OPTION_FLAG_DISABLED)
		AddSliderOptionST("maxTalkDamageST", "$MND_MaxTalkDamage", mnd.maxTalkDamage, "$MND_percent", OPTION_FLAG_DISABLED)
	endIf
endFunction

function generatePhysiologicalNeeds()
	SetCursorFillMode(TOP_TO_BOTTOM)
	AddToggleOptionST("EnablePissTG", "$MND_EnablePissing", mnd.enablePiss)
	if mnd.enablePiss
		AddSliderOptionST("TimePissST", "$MND_Maxtimeforpeeing", mnd.timePiss, "$MND_hours")
		AddSliderOptionST("maxPissDamageST", "$MND_MaxPissDamage", mnd.maxPissDamage, "$MND_percent")
		AddToggleOptionST("NoPissInPublicTG", "$MND_NoPissInPublic", mnd.noPissInPublic)
		if mnd.enablePoop && mnd.pissAndPoopTogether
			AddMenuOptionST("HowToPissMN", "$MND_HowToPiss", howToPissPoop[mnd.howToPiss], OPTION_FLAG_DISABLED)
			if mnd.howToPiss==2
				AddKeyMapOptionST("KeyToPiss", "$MND_KeyToPiss", mnd.keyToPiss, OPTION_FLAG_DISABLED)
			else
				AddEmptyOption()
			endIf
		else
			AddMenuOptionST("HowToPissMN", "$MND_HowToPiss", howToPissPoop[mnd.howToPiss])
			if mnd.howToPiss==2
				AddKeyMapOptionST("KeyToPiss", "$MND_KeyToPiss", mnd.keyToPiss)
			else
				AddEmptyOption()
			endIf
		endIf
		AddMenuOptionST("AddPissPuddleMN", "$MND_AddPissPuddle", addPuddles[mnd.addPissPuddle])
	else
		AddSliderOptionST("TimePissST", "$MND_Maxtimeforpeeing", mnd.timePiss, "$MND_hours", OPTION_FLAG_DISABLED)
		AddSliderOptionST("maxPissDamageST", "$MND_MaxPissDamage", mnd.maxPissDamage, "$MND_percent", OPTION_FLAG_DISABLED)
		AddToggleOptionST("NoPissInPublicTG", "$MND_NoPissInPublic", mnd.noPissInPublic, OPTION_FLAG_DISABLED)
		AddMenuOptionST("HowToPissMN", "$MND_HowToPiss", howToPissPoop[mnd.howToPiss], OPTION_FLAG_DISABLED)
		if mnd.howToPiss==2
			AddKeyMapOptionST("KeyToPiss", "$MND_KeyToPiss", mnd.keyToPiss, OPTION_FLAG_DISABLED)
		else
			AddEmptyOption()
		endIf
		AddMenuOptionST("AddPissPuddleMN", "$MND_AddPissPuddle", addPuddles[mnd.addPissPuddle], OPTION_FLAG_DISABLED)
	endIf
	
	SetCursorPosition(1)
	; Damage: max carry weight set to zero, possibility of random diarrhea
	AddToggleOptionST("EnablePoopTG", "$MND_EnablePooping", mnd.enablePoop)
	if mnd.enablePoop
		AddSliderOptionST("TimePoopST", "$MND_MaxtimeforPooping", mnd.timePoop, "$MND_hours")
		AddSliderOptionST("maxPoopDamageST", "$MND_maxPoopDamage", mnd.maxPoopDamage, "$MND_percent")
		AddToggleOptionST("NoPoopInPublicTG", "$MND_NoPoopInPublic", mnd.noPoopInPublic)
		AddMenuOptionST("HowToPoopMN", "$MND_HowToPoop", howToPissPoop[mnd.howToPoop])
		if mnd.howToPoop==2
			AddKeyMapOptionST("KeyToPoop", "$MND_KeyToPoop", mnd.keyToPoop)
		else
			AddEmptyOption()
		endIf
		AddMenuOptionST("AddVisiblePoopMN", "$MND_AddVisiblePoop", addPuddles[mnd.addVisiblePoop])
	else
		AddSliderOptionST("TimePoopST", "$MND_MaxtimeforPooping", mnd.timePoop, "$MND_hours", OPTION_FLAG_DISABLED)
		AddSliderOptionST("maxPoopDamageST", "$MND_maxPoopDamage", mnd.maxPoopDamage, "$MND_percent", OPTION_FLAG_DISABLED)
		AddToggleOptionST("NoPoopInPublicTG", "$MND_NoPoopInPublic", mnd.noPoopInPublic, OPTION_FLAG_DISABLED)
		AddMenuOptionST("HowToPoopMN", "$MND_HowToPoop", howToPissPoop[mnd.howToPoop], OPTION_FLAG_DISABLED)
		if mnd.howToPoop==2
			AddKeyMapOptionST("KeyToPoop", "$MND_KeyToPoop", mnd.keyToPoop, OPTION_FLAG_DISABLED)
		else
			AddEmptyOption()
		endIf
		AddMenuOptionST("AddVisiblePoopMN", "$MND_AddVisiblePoop", addPuddles[mnd.addVisiblePoop], OPTION_FLAG_DISABLED)
	endIf

	SetCursorPosition(20)
	if mnd.enablePiss && mnd.enablePoop
		AddToggleOptionST("PissAndPoopTogetherTG", "$MND_PissAndPoopTogether", mnd.pissAndPoopTogether)
		SetCursorPosition(21)
		if mnd.pissAndPoopTogether
			AddMenuOptionST("HowToPissPoopMN", "$MND_HowToPissPoop", howToPissPoop[mnd.howToPissPoop], OPTION_FLAG_DISABLED)
			if mnd.howToPissPoop==2
				AddKeyMapOptionST("KeyToPissPoop", "$MND_KeyToPissPoop", mnd.keyToPissPoop, OPTION_FLAG_DISABLED)
			endIf
		else
			AddMenuOptionST("HowToPissPoopMN", "$MND_HowToPissPoop", howToPissPoop[mnd.howToPissPoop])
			if mnd.howToPissPoop==2
				AddKeyMapOptionST("KeyToPissPoop", "$MND_KeyToPissPoop", mnd.keyToPissPoop)
			endIf
		endIf
	endIf
endFunction

function generateAdultNeeds()
	SetCursorFillMode(TOP_TO_BOTTOM)
	if mnd.weHaveSexLab
		AddToggleOptionST("EnableSexTG", "$MND_EnableSex", mnd.enableSex)
		if mnd.enableSex
			AddSliderOptionST("TimeSexST", "$MND_MaxtimeforSex", mnd.timeSex, "$MND_hours")
			AddSliderOptionST("maxSexDamageST", "$MND_MaxSexDamage", mnd.maxSexDamage, "$MND_percent")
			AddToggleOptionST("NoSexInPublicTG", "$MND_NoSexInPublic", mnd.noSexInPublic)
			AddKeyMapOptionST("KeyToMasturbate", "$MND_KeyToMasturbate", mnd.keyToMasturbate)
		else
			AddSliderOptionST("TimeSexST", "$MND_MaxtimeforSex", mnd.timeSex, "$MND_hours", OPTION_FLAG_DISABLED)
			AddSliderOptionST("maxSexDamageST", "$MND_MaxSexDamage", mnd.maxSexDamage, "$MND_percent", OPTION_FLAG_DISABLED)
			AddToggleOptionST("NoSexInPublicTG", "$MND_NoSexInPublic", mnd.noSexInPublic, OPTION_FLAG_DISABLED)
			AddKeyMapOptionST("KeyToMasturbate", "$MND_KeyToMasturbate", mnd.keyToMasturbate, OPTION_FLAG_DISABLED)
		endIf
	endIf
	AddEmptyOption()
	
	; Weed
	; Damage: Low contrast, HeavyLightArmor
	if mnd.weHaveWeed
		AddToggleOptionST("EnableWeedTG", "$MND_EnableWeed", mnd.enableWeed)
		if mnd.enableWeed
			AddSliderOptionST("TimeWeedST", "$MND_MaxTimeForWeed", mnd.timeWeed, "$MND_hours")
			AddSliderOptionST("maxWeedDamageST", "$MND_MaxWeedDamage", mnd.maxWeedDamage, "$MND_percent")
		else
			AddSliderOptionST("TimeWeedST", "$MND_MaxTimeForWeed", mnd.timeWeed, "$MND_hours", OPTION_FLAG_DISABLED)
			AddSliderOptionST("maxWeedDamageST", "$MND_MaxWeedDamage", mnd.maxWeedDamage, "$MND_percent", OPTION_FLAG_DISABLED)
		endIf
	endIf

	SetCursorPosition(1)
	; Skooma
	; Damage: Reduce hit accuracy, AttackDamageMult
	AddToggleOptionST("EnableSkoomaTG", "$MND_EnableSkooma", mnd.enableSkooma)
	if mnd.enableSkooma
		AddSliderOptionST("TimeSkoomaST", "$MND_MaxTimeForSkooma", mnd.timeSkooma, "$MND_hours")
		AddSliderOptionST("maxSkoomaDamageST", "$MND_maxSkoomaDamage", mnd.maxSkoomaDamage, "$MND_percent")
	else
		AddSliderOptionST("TimeSkoomaST", "$MND_MaxTimeForSkooma", mnd.timeSkooma, "$MND_hours", OPTION_FLAG_DISABLED)
		AddSliderOptionST("maxSkoomaDamageST", "$MND_maxSkoomaDamage", mnd.maxSkoomaDamage, "$MND_percent", OPTION_FLAG_DISABLED)
	endIf
	AddEmptyOption()
	
	; Alcohol
	; Damage: Speechcraft, Reduce hit accuracy
	AddToggleOptionST("EnableWineTG", "$MND_EnableAcohol", mnd.enableAlcohol)
	if mnd.enableAlcohol
		AddSliderOptionST("TimeAlcoholST", "$MND_MaxTimeForAlcohol", mnd.timeAlcohol, "$MND_hours")
		AddSliderOptionST("maxAlcoholDamageST", "$MND_MaxAlcoholDamage", mnd.maxAlcoholDamage, "$MND_percent")
	else
		AddSliderOptionST("TimeAlcoholST", "$MND_MaxTimeForAlcohol", mnd.timeAlcohol, "$MND_hours", OPTION_FLAG_DISABLED)
		AddSliderOptionST("maxAlcoholDamageST", "$MND_MaxAlcoholDamage", mnd.maxAlcoholDamage, "$MND_percent", OPTION_FLAG_DISABLED)
	endIf
	AddEmptyOption()
	
	; Drunk mode
	; Damage: double vision, alternate anims, pick random weapon
	AddToggleOptionST("EnableDrunkTG", "$MND_EnableDrunk", mnd.enableDrunk)
	if mnd.enableDrunk
		AddSliderOptionST("TimeDrunkST", "$MND_HowLongDrunk", mnd.timeDrunk, "$MND_hours")
	else
		AddSliderOptionST("TimeDrunkST", "$MND_HowLongDrunk", mnd.timeDrunk, "$MND_hours", OPTION_FLAG_DISABLED)
	endIf
endFunction

function generateNeedsPenalties()
	pageMode=20
	SetCursorFillMode(LEFT_TO_RIGHT)
	SetTitleText("$MND_DefineNeedPenalties")
	while numOpts
		numOpts-=1
		opts[numOpts]=-1
	endWhile

	numOpts=0
	while numOpts<currentNeedNames.length
		opts[numOpts] = AddTextOption("$MND_PenaltiesFor{" + currentNeedNames[numOpts] + "}", "$MND_GO")
		numOpts+=1
	endWhile
endFunction

function generateDefineNeedPenalties()
	pageMode=21
	while numOpts
		numOpts-=1
		opts[numOpts]=-1
	endWhile

	SetCursorFillMode(LEFT_TO_RIGHT)
	SetTitleText("$MND_DefineNeedPenalties")
	opts[penaltyNames.length] = AddTextOption("$MND_Need{" + currentNeedNames[currentNeed] + "}", "", OPTION_FLAG_DISABLED)
	AddTextOptionST("GoBackBN", "$MND_GoBack", "$MND_Back")

	; 0="No", 1="[I--]", 2="[-I-]", 3="[--I]", 4="[---][I--]", 5="[---][-I-]", 6="[---][--I]", 7=not used
	int i=0
	while i<penaltyNames.length
		if i==43 && !mnd.weHaveSexLab
			opts[i] = AddTextOption(penaltyNames[i] + checkPenaltyUsage(i, currentNeed) + "}", penaltyModes[mnd.getDamageValue(currentNeed, i)], OPTION_FLAG_DISABLED)
		else
			opts[i] = AddTextOption(penaltyNames[i] + checkPenaltyUsage(i, currentNeed) + "}", penaltyModes[mnd.getDamageValue(currentNeed, i)])
		endIf
		i+=1
	endWhile
	
	numOpts=penaltyNames.length + 1
endFunction

function generateApplyPenalties()
	pageMode=22
	while numOpts
		numOpts-=1
		opts[numOpts]=-1
	endWhile

	SetCursorFillMode(LEFT_TO_RIGHT)
	SetTitleText("$MND_ApplyNeedPenalties")

	int i=0
	while i<penaltyNames.length
		if i==43 && !mnd.weHaveSexLab
			opts[i] = AddTextOption(penaltyNames[i]+"}", "$MND_Apply", OPTION_FLAG_DISABLED)
		else
			opts[i] = AddTextOption(penaltyNames[i]+"}", "$MND_Apply")
		endIf
		i+=1
	endWhile
	
	numOpts=penaltyNames.length + 1
endFunction

function generateWidgets()
	SetCursorFillMode(TOP_TO_BOTTOM)
	if !mnd.enableEat && !mnd.enableDrink && !mnd.enableSleep && !mnd.enableTalk && !mnd.enableBath && !mnd.enablePray && !mnd.enablePiss && !mnd.enablePoop && !mnd.enableSex && !mnd.enableSkooma && !mnd.enableAlcohol && !mnd.enableWeed && !mnd.enableDrunk 
		AddToggleOptionST("EnableWidgetsTG", "$MND_Enablewidgets", mnd.enableWidgets, OPTION_FLAG_DISABLED)
	else
		AddToggleOptionST("EnableWidgetsTG", "$MND_Enablewidgets", mnd.enableWidgets)
	endIf
	AddEmptyOption()
	
	if mnd.enableWidgets && (mnd.enableEat || mnd.enableDrink || mnd.enableSleep || mnd.enableTalk || mnd.enableBath || mnd.enablePray || mnd.enablePiss || mnd.enablePoop || mnd.enableSex || mnd.enableSkooma || mnd.enableAlcohol || mnd.enableWeed || mnd.enableDrunk)
		AddMenuOptionST("WidgetsOpacityMN", "$MND_Widgetopacities", wOpacities[mnd.widgetsOpacities])
		AddEmptyOption()
		
		AddMenuOptionST("WidgetsPositionMN", "$MND_Widgetpositions", wPositions[mnd.widgetsPositions])
		if mnd.widgetsPositions==0 || mnd.widgetsPositions==1
			AddMenuOptionST("WidgetsArrangementsMN", "$MND_Widgetarrangements", wArrangementsTB[mnd.widgetsArrangements])
		else
			AddMenuOptionST("WidgetsArrangementsMN", "$MND_Widgetarrangements", wArrangementsLR[mnd.widgetsArrangements])
		endIf
		AddMenuOptionST("WidgetsGroupingMN", "$MND_WidgetsGrouping", wGrouping[mnd.widgetsGrouped])
		AddMenuOptionST("WidgetsSizeMN", "$MND_Widgetssize", wSizes[mnd.widgetsSize])
		SetCursorPosition(20)
		AddTextOptionST("SetWidgetColorsBN", "$MND_SetWidgetColors", "$MND_GO")
		AddTextOptionST("EnableDisableSpecificWidgetsBN", "$MND_EnableDisableSpecificWidgets", "$MND_GO")
		SetCursorPosition(1)
		AddKeyMapOptionST("WidgetsKeyDef", "$MND_WidgetsKey", mnd.widgetsKey)
		SetCursorPosition(5)
		AddSliderOptionST("WidgetsSpaceSL", "$MND_Spacebetweenwidgets", mnd.widgetsSpace, "{0}")
		AddSliderOptionST("WidgetsHMarginSL", "$MND_HorizontalMargin", mnd.widgetsMarginH, "{0}")
		AddSliderOptionST("WidgetsVMarginSL", "$MND_VerticalMargin", mnd.widgetsMarginV, "{0}")
	else
		AddMenuOptionST("WidgetsOpacityMN", "$MND_Widgetopacities", wOpacities[mnd.widgetsOpacities], OPTION_FLAG_DISABLED)
		AddEmptyOption()
		
		AddMenuOptionST("WidgetsPositionMN", "$MND_Widgetpositions", wPositions[mnd.widgetsPositions], OPTION_FLAG_DISABLED)
		if mnd.widgetsPositions==0 || mnd.widgetsPositions==1
			AddMenuOptionST("WidgetsArrangementsMN", "$MND_Widgetarrangements", wArrangementsTB[mnd.widgetsArrangements], OPTION_FLAG_DISABLED)
		else
			AddMenuOptionST("WidgetsArrangementsMN", "$MND_Widgetarrangements", wArrangementsLR[mnd.widgetsArrangements], OPTION_FLAG_DISABLED)
		endIf
		AddMenuOptionST("WidgetsGroupingMN", "$MND_WidgetsGrouping", wGrouping[mnd.widgetsGrouped], OPTION_FLAG_DISABLED)
		AddMenuOptionST("WidgetsSizeMN", "$MND_Widgetssize", wSizes[mnd.widgetsSize], OPTION_FLAG_DISABLED)
		SetCursorPosition(1)
		AddKeyMapOptionST("WidgetsKeyDef", "$MND_WidgetsKey", mnd.widgetsKey, OPTION_FLAG_DISABLED)
		SetCursorPosition(5)
		AddSliderOptionST("WidgetsSpaceSL", "$MND_Spacebetweenwidgets", mnd.widgetsSpace, "{0}", OPTION_FLAG_DISABLED)
		AddSliderOptionST("WidgetsHMarginSL", "$MND_HorizontalMargin", mnd.widgetsMarginH, "{0}", OPTION_FLAG_DISABLED)
		AddSliderOptionST("WidgetsVMarginSL", "$MND_VerticalMargin", mnd.widgetsMarginV, "{0}", OPTION_FLAG_DISABLED)
	endIf
endFunction

function generateEnableWidgets()
	SetCursorFillMode(LEFT_TO_RIGHT)
	if mnd.enableEat
		opts[0] = AddToggleOption("$MND_EnableWidgetEat", mnd.enableWidgetEat)
	else
		opts[0] = AddToggleOption("$MND_EnableWidgetEat", mnd.enableWidgetEat, OPTION_FLAG_DISABLED)
	endIf
	if mnd.enableDrink
		opts[1] = AddToggleOption("$MND_EnableWidgetDrink", mnd.enableWidgetDrink)
	else
		opts[1] = AddToggleOption("$MND_EnableWidgetDrink", mnd.enableWidgetDrink, OPTION_FLAG_DISABLED)
	endIf
	if mnd.enableSleep
		opts[2] = AddToggleOption("$MND_EnableWidgetSleep", mnd.enableWidgetSleep)
	else
		opts[2] = AddToggleOption("$MND_EnableWidgetSleep", mnd.enableWidgetSleep, OPTION_FLAG_DISABLED)
	endIf
	if mnd.enableTalk
		opts[3] = AddToggleOption("$MND_EnableWidgetTalk", mnd.enableWidgetTalk)
	else
		opts[3] = AddToggleOption("$MND_EnableWidgetTalk", mnd.enableWidgetTalk, OPTION_FLAG_DISABLED)
	endIf
	if mnd.enableBath
		opts[4] = AddToggleOption("$MND_EnableWidgetBath", mnd.enableWidgetBath)
	else
		opts[4] = AddToggleOption("$MND_EnableWidgetBath", mnd.enableWidgetBath, OPTION_FLAG_DISABLED)
	endIf
	if mnd.enablePray
		opts[5] = AddToggleOption("$MND_EnableWidgetPray", mnd.enableWidgetPray)
	else
		opts[5] = AddToggleOption("$MND_EnableWidgetPray", mnd.enableWidgetPray, OPTION_FLAG_DISABLED)
	endIf
	if mnd.enablePiss
		opts[6] = AddToggleOption("$MND_EnableWidgetPiss", mnd.enableWidgetPiss)
	else
		opts[6] = AddToggleOption("$MND_EnableWidgetPiss", mnd.enableWidgetPiss, OPTION_FLAG_DISABLED)
	endIf
	if mnd.enablePoop
		opts[7] = AddToggleOption("$MND_EnableWidgetPoop", mnd.enableWidgetPoop)
	else
		opts[7] = AddToggleOption("$MND_EnableWidgetPoop", mnd.enableWidgetPoop, OPTION_FLAG_DISABLED)
	endIf
	if mnd.weHaveSexLab
		if mnd.enableSex
			opts[8] = AddToggleOption("$MND_EnableWidgetSex", mnd.enableWidgetSex)
		else
			opts[8] = AddToggleOption("$MND_EnableWidgetSex", mnd.enableWidgetSex, OPTION_FLAG_DISABLED)
		endIf
	endIf
	if mnd.enableSkooma
		opts[9] = AddToggleOption("$MND_EnableWidgetSkooma", mnd.enableWidgetSkooma)
	else
		opts[9] = AddToggleOption("$MND_EnableWidgetSkooma", mnd.enableWidgetSkooma, OPTION_FLAG_DISABLED)
	endIf
	if mnd.enableAlcohol
		opts[10] = AddToggleOption("$MND_EnableWidgetWine", mnd.enableWidgetAlcohol)
	else
		opts[10] = AddToggleOption("$MND_EnableWidgetWine", mnd.enableWidgetAlcohol, OPTION_FLAG_DISABLED)
	endIf
	if mnd.weHaveWeed
		if mnd.enableWeed
			opts[11] = AddToggleOption("$MND_EnableWidgetWeed", mnd.enableWidgetWeed)
		else
			opts[11] = AddToggleOption("$MND_EnableWidgetWeed", mnd.enableWidgetWeed, OPTION_FLAG_DISABLED)
		endIf
	endIf
	if mnd.enableDrunk
		opts[12] = AddToggleOption("$MND_EnableWidgetDrunk", mnd.enableWidgetDrunk)
	else
		opts[12] = AddToggleOption("$MND_EnableWidgetDrunk", mnd.enableWidgetDrunk, OPTION_FLAG_DISABLED)
	endIf
	SetCursorPosition(23)
	AddTextOptionST("GoBackBN", "$MND_GoBack", "$MND_Back")
endFunction

function generateWidgetColors()
	SetCursorFillMode(LEFT_TO_RIGHT)
	AddTextOptionST("GoBackBN", "$MND_GoBack", "$MND_Back")
	AddTextOptionST("ResetWidColsBN", "$MND_ResetWidColsBN", "Reset")
	AddColorOptionST("WidColEatS", "$MND_WidColEatS", mnd.widColSEat)
	AddColorOptionST("WidColEatE", "$MND_WidColEatE", mnd.widColEEat)
	AddColorOptionST("WidColDrinkS", "$MND_WidColDrinkS", mnd.widColSDrink)
	AddColorOptionST("WidColDrinkE", "$MND_WidColDrinkE", mnd.widColEDrink)
	AddColorOptionST("WidColSleepS", "$MND_WidColSleepS", mnd.widColSSleep)
	AddColorOptionST("WidColSleepE", "$MND_WidColSleepE", mnd.widColESleep)
	AddColorOptionST("WidColTalkS", "$MND_WidColTalkS", mnd.widColSTalk)
	AddColorOptionST("WidColTalkE", "$MND_WidColTalkE", mnd.widColETalk)
	AddColorOptionST("WidColBathS", "$MND_WidColBathS", mnd.widColSBath)
	AddColorOptionST("WidColBathE", "$MND_WidColBathE", mnd.widColEBath)
	AddColorOptionST("WidColPrayS", "$MND_WidColPrayS", mnd.widColSPray)
	AddColorOptionST("WidColPrayE", "$MND_WidColPrayE", mnd.widColEPray)
	AddColorOptionST("WidColPissS", "$MND_WidColPissS", mnd.widColSPiss)
	AddColorOptionST("WidColPissE", "$MND_WidColPissE", mnd.widColEPiss)
	AddColorOptionST("WidColPoopS", "$MND_WidColPoopS", mnd.widColSPoop)
	AddColorOptionST("WidColPoopE", "$MND_WidColPoopE", mnd.widColEPoop)
	if mnd.weHaveSexLab
		AddColorOptionST("WidColSexS", "$MND_WidColSexS", mnd.widColSSex)
		AddColorOptionST("WidColSexE", "$MND_WidColSexE", mnd.widColESex)
	endIf
	AddColorOptionST("WidColSkoomaS", "$MND_WidColSkoomaS", mnd.widColSSkooma)
	AddColorOptionST("WidColSkoomaE", "$MND_WidColSkoomaE", mnd.widColESkooma)
	AddColorOptionST("WidColAlcoholS", "$MND_WidColAlcoholS", mnd.widColSAlcohol)
	AddColorOptionST("WidColAlcoholE", "$MND_WidColAlcoholE", mnd.widColEAlcohol)
	if mnd.weHaveWeed
		AddColorOptionST("WidColWeedS", "$MND_WidColWeedS", mnd.widColSWeed)
		AddColorOptionST("WidColWeedE", "$MND_WidColWeedE", mnd.widColEWeed)
	endIf
	AddColorOptionST("WidColDrunkS", "$MND_WidColDrunkS", mnd.widColSDrunk)
	AddColorOptionST("WidColDrunkE", "$MND_WidColDrunkE", mnd.widColEDrunk)
endFunction

function generateUnknownFood()
	SetCursorFillMode(LEFT_TO_RIGHT)
	SetTitleText("$MND_DefineUnknownFood")
	if mnd.mndUnidentified.GetSize()==0 && mnd.mndPreviouslyUnidentified.GetSize()==0
		AddTextOption("$MND_NoUnknownFood", "", OPTION_FLAG_DISABLED)
		return
	endIf
	while numOpts
		numOpts-=1
		opts[numOpts]=-1
	endWhile
	numOpts=0
	
	AddMenuOptionST("UnknowFoodModeMN", "$MND_UnknowFoodMode", unknowFoodModes[unknowFoodMode])
	if unknowFoodMode==0
		if mnd.mndUnidentified.GetSize()==0
			AddTextOption("$MND_NoUnknownFood", "", OPTION_FLAG_DISABLED)
			return
		endIf
		while numOpts<mnd.mndUnidentified.GetSize() && numOpts<opts.length
			Form f = mnd.mndUnidentified.GetAt(numOpts) as Potion
			if f
				opts[numOpts] = AddMenuOption(getFormName(f), "$MND_Define")
				numOpts+=1
			endIf
		endWhile
		
	elseIf unknowFoodMode==1
		if mnd.mndPreviouslyUnidentified.GetSize()==0
			AddTextOption("$MND_NoUnknownFood", "", OPTION_FLAG_DISABLED)
			return
		endIf
		while numOpts<mnd.mndPreviouslyUnidentified.GetSize() && numOpts<opts.length
			Form f = mnd.mndPreviouslyUnidentified.GetAt(numOpts) as Potion
			opts[numOpts] = AddMenuOption(getFormName(f), foodPossibilities[calculateFoodType(f)])
			numOpts+=1
		endWhile
	
	elseIf unknowFoodMode==2
		if mnd.mndUnidentified.GetSize()==0
			AddTextOption("$MND_NoUnknownFood", "", OPTION_FLAG_DISABLED)
			return
		endIf
		while numOpts<mnd.mndUnidentified.GetSize() && numOpts<opts.length
			Form f = mnd.mndUnidentified.GetAt(numOpts) as Potion
			if f
				opts[numOpts] = AddMenuOption(f.getName(), "$MND_Define")
				numOpts+=1
			endIf
		endWhile

	elseIf unknowFoodMode==3
		if mnd.mndPreviouslyUnidentified.GetSize()==0
			AddTextOption("$MND_NoUnknownFood", "", OPTION_FLAG_DISABLED)
			return
		endIf
		while numOpts<mnd.mndPreviouslyUnidentified.GetSize() && numOpts<opts.length
			Form f = mnd.mndPreviouslyUnidentified.GetAt(numOpts) as Potion
			if f
				opts[numOpts] = AddMenuOption(f.getName(), foodPossibilities[calculateFoodType(f)])
				numOpts+=1
			endIf
		endWhile
	endIf
endFunction



string function GetCustomControl(int keyCode)
	if keyCode==mnd.keyToPiss
		return "Used by MiniNeeds to have the player to piss"
	elseIf keyCode==mnd.keyToPoop
		return "Used by MiniNeeds to have the player to defecate"
	elseIf keyCode==mnd.keyToMasturbate
		return "Used by MiniNeeds to have the player to masturbate"
	elseIf keyCode==mnd.widgetsKey
		return "Used by MiniNeeds to activate/deactivate the widgets"
	elseIf keyCode==mnd.keyToBathInRivers
		return "Used by MiniNeeds to have a bath in rivers"
	else
		return ""
	endIf
endFunction


; ((- Stateless options 

event OnOptionMenuOpen(int option)
	if pageMode==40 ; UnknownFood
		if unknowFoodMode==0 || unknowFoodMode==2
			SetMenuDialogStartIndex(0)
		else
			Form f = mnd.mndPreviouslyUnidentified.GetAt(opts.find(option))
			SetMenuDialogStartIndex(calculateFoodType(f))
		endIf
		SetMenuDialogDefaultIndex(9)
		SetMenuDialogOptions(foodPossibilities)
	endIf
endEvent

event OnOptionMenuAccept(int option, int index)
	int pos = opts.find(option)
	if pageMode==40 ; UnknownFood
		Form f
		if unknowFoodMode==0 || unknowFoodMode==2
			f = mnd.mndUnidentified.GetAt(pos)
		else
			f = mnd.mndPreviouslyUnidentified.GetAt(pos)
		endIf
		if index>0
			mnd.mndFoods.RemoveAddedForm(f)
			mnd.mndDrinks.RemoveAddedForm(f)
			mnd.mndLiquidFoods.RemoveAddedForm(f)
			mnd.mndAlcohol.RemoveAddedForm(f)
			mnd.mndSkooma.RemoveAddedForm(f)
			mnd.mndWeed.RemoveAddedForm(f)
			mnd.mndBlood.RemoveAddedForm(f)
			mnd.mndMilk.RemoveAddedForm(f)
			mnd.mndToBeIgnored.RemoveAddedForm(f)
			if index==1
				mnd.mndFoods.addForm(f)
			elseIf index==2
				mnd.mndDrinks.addForm(f)
			elseIf index==3
				mnd.mndLiquidFoods.addForm(f)
			elseIf index==4
				mnd.mndAlcohol.addForm(f)
			elseIf index==5
				mnd.mndSkooma.addForm(f)
			elseIf index==6
				mnd.mndWeed.addForm(f)
			elseIf index==7
				mnd.mndBlood.addForm(f)
			elseIf index==8
				mnd.mndMilk.addForm(f)
			elseIf index==9
				mnd.mndToBeIgnored.addForm(f)
			endIf
			mnd.mndUnidentified.RemoveAddedForm(f)
			ForcePageReset()
		endIf
		needToSaveJson = true
	endIf
endEvent

event OnOptionHighlight(int option)
	int pos = opts.find(option)
	if pageMode==31 ; EnableWidgets
		if pos==0 ; Eat
			SetInfoText("$MND_HelpEnableWidgetEat")
		elseIf pos==1 ; Drink
			SetInfoText("$MND_HelpEnableWidgetDrink")
		elseIf pos==2 ; Sleep
			SetInfoText("$MND_HelpEnableWidgetSleep")
		elseIf pos==3 ; Talk
			SetInfoText("$MND_HelpEnableWidgetTalk")
		elseIf pos==4 ; Bath
			SetInfoText("$MND_HelpEnableWidgetBath")
		elseIf pos==5 ; Pray
			SetInfoText("$MND_HelpEnableWidgetPray")
		elseIf pos==6 ; Piss
			SetInfoText("$MND_HelpEnableWidgetPiss")
		elseIf pos==7 ; Poop
			SetInfoText("$MND_HelpEnableWidgetPoop")
		elseIf pos==8 ; Sex
			SetInfoText("$MND_HelpEnableWidgetSex")
		elseIf pos==9 ; Skooma
			SetInfoText("$MND_HelpEnableWidgetSkooma")
		elseIf pos==10 ; Alcohol
			SetInfoText("$MND_HelpEnableWidgetWine")
		elseIf pos==11 ; Weed
			SetInfoText("$MND_HelpEnableWidgetWeed")
		elseIf pos==12 ; Drunk
			SetInfoText("$MND_HelpEnableWidgetDrunk")
		endIf
	elseIf pageMode==20 ; NeedsPenalties
		SetInfoText(calculateCurrentPenalties(pos))
	elseIf pageMode==21 ; DefineNeedPenalties
		if pos==0
			SetInfoText("$MND_HelpMagicka")
		elseIf pos==1
			SetInfoText("$MND_HelpMagickaRegen")
		elseIf pos==2
			SetInfoText("$MND_HelpHealth")
		elseIf pos==3
			SetInfoText("$MND_HelpHealthRegen")
		elseIf pos==4
			SetInfoText("$MND_HelpStamina")
		elseIf pos==5
			SetInfoText("$MND_HelpStaminaRegen")
		elseIf pos==6
			SetInfoText("$MND_HelpSpeed")
		elseIf pos==7
			SetInfoText("$MND_HelpRndSpeed")
		elseIf pos==8
			SetInfoText("$MND_HelpWeaponsSpeed")
		elseIf pos==9
			SetInfoText("$MND_HelpWeaponsDamage")
		elseIf pos==10
			SetInfoText("$MND_HelpRemoveWeapon")
		elseIf pos==11
			SetInfoText("$MND_HelpRndWeapon")
		elseIf pos==12
			SetInfoText("$MND_HelpRndWeaponEquipping")
		elseIf pos==13
			SetInfoText("$MND_HelpAttackDamage")
		elseIf pos==14
			SetInfoText("$MND_HelpCarryWeight")
		elseIf pos==15
			SetInfoText("$MND_HelpAlchemy")
		elseIf pos==16
			SetInfoText("$MND_HelpSpellsIllusion")
		elseIf pos==17
			SetInfoText("$MND_HelpSpellsConjuration")
		elseIf pos==18
			SetInfoText("$MND_HelpSpellsDestruction")
		elseIf pos==19
			SetInfoText("$MND_HelpSpellsRestoration")
		elseIf pos==20
			SetInfoText("$MND_HelpSpellsAlteration")
		elseIf pos==21
			SetInfoText("$MND_HelpEnchanting")
		elseIf pos==22
			SetInfoText("$MND_HelpLightArmors")
		elseIf pos==23
			SetInfoText("$MND_HelpHeavyArmors")
		elseIf pos==24
			SetInfoText("$MND_HelpDecrSneak")
		elseIf pos==25
			SetInfoText("$MND_HelpIncrSneak")
		elseIf pos==26
			SetInfoText("$MND_HelpDecrLockPicking")
		elseIf pos==27
			SetInfoText("$MND_HelpIncrLockPicking")
		elseIf pos==28
			SetInfoText("$MND_HelpDecrPickPocket")
		elseIf pos==29
			SetInfoText("$MND_HelpIncrPickPocket")
		elseIf pos==30
			SetInfoText("$MND_HelpSpeech")
		elseIf pos==31
			SetInfoText("$MND_HelpBlocking")
		elseIf pos==32
			SetInfoText("$MND_HelpDirt1")
		elseIf pos==33
			SetInfoText("$MND_HelpDirt2")
		elseIf pos==34
			SetInfoText("$MND_HelpDecrTits")
		elseIf pos==35
			SetInfoText("$MND_HelpIncrTits")
		elseIf pos==36
			SetInfoText("$MND_HelpDectBelly")
		elseIf pos==37
			SetInfoText("$MND_HelpIncrBelly")
		elseIf pos==38
			SetInfoText("$MND_HelpDecrWeight")
		elseIf pos==39
			SetInfoText("$MND_HelpIncrWeight")
		elseIf pos==40
			SetInfoText("$MND_HelpDrinkAgainAlcohol")
		elseIf pos==41
			SetInfoText("$MND_HelpDiarrhea")
		elseIf pos==42
			SetInfoText("$MND_HelpHornyPose")
		elseIf pos==43
			SetInfoText("$MND_HelpMasturbate")
		elseIf pos==44
			SetInfoText("$MND_HelpCollapse")
		elseIf pos==45
			SetInfoText("$MND_HelpISMLowContrast")
		elseIf pos==46
			SetInfoText("$MND_HelpISMBlurry1")
		elseIf pos==47
			SetInfoText("$MND_HelpISMBlurry2")
		elseIf pos==48
			SetInfoText("$MND_HelpISMDistorted1")
		elseIf pos==49
			SetInfoText("$MND_HelpISMDistorted2")
		endIf
	elseIf pageMode==40 ; UnknownFood
		if unknowFoodMode==0 || unknowFoodMode==2
			SetInfoText("$MND_HelpSetUnidentified{" + getFormName(mnd.mndUnidentified.GetAt(pos)) + "}")
		else
			SetInfoText("$MND_HelpSetUnidentified{" + getFormName(mnd.mndPreviouslyUnidentified.GetAt(pos)) + "}")
		endIf
	elseIf pageMode==22 ; Apply Penalties
		SetInfoText("$MND_HelpApply")
	endIf
endEvent

event OnOptionSelect(int option)
	if pageMode==20 ; NeedsPenalties
		currentNeed = opts.find(option)
		pageMode=21
		ForcePageReset()
	elseIf pageMode==21 ; DefineNeedPenalties
		; find the penalty, add it to the currentNeed and remove it from all other needs
		int penalty = opts.find(option)
		int val = mnd.getDamageValue(currentNeed, penalty) + 1
		if val==7
			val=0
		endIf
		mnd.setDamageValue(currentNeed, penalty, val)
		SetTextOptionValue(option, penaltyModes[val])
	elseIf pageMode==22 ; ApplyPenalties
		int pos = opts.find(option)
		int here = penaltiesToApply.find(pos)
		if here==-1 && numPenaltiesToApply<penaltiesToApply.length
			penaltiesToApply[numPenaltiesToApply] = pos
			numPenaltiesToApply+=1
		endIf
		SetTextOptionValue(option, "$MND_Done")
	elseIf pageMode==31 ; EnableWidgets
		int pos = opts.find(option)
		if pos==0
			mnd.enableWidgetEat = !mnd.enableWidgetEat
			SetToggleOptionValue(option, mnd.enableWidgetEat)
		elseIf pos==1
			mnd.enableWidgetDrink = !mnd.enableWidgetDrink
			SetToggleOptionValue(option, mnd.enableWidgetDrink)
		elseIf pos==2
			mnd.enableWidgetSleep = !mnd.enableWidgetSleep
			SetToggleOptionValue(option, mnd.enableWidgetSleep)
		elseIf pos==3
			mnd.enableWidgetTalk = !mnd.enableWidgetTalk
			SetToggleOptionValue(option, mnd.enableWidgetTalk)
		elseIf pos==4
			mnd.enableWidgetBath = !mnd.enableWidgetBath
			SetToggleOptionValue(option, mnd.enableWidgetBath)
		elseIf pos==5
			mnd.enableWidgetPray = !mnd.enableWidgetPray
			SetToggleOptionValue(option, mnd.enableWidgetPray)
		elseIf pos==6
			mnd.enableWidgetPiss = !mnd.enableWidgetPiss
			SetToggleOptionValue(option, mnd.enableWidgetPiss)
		elseIf pos==7
			mnd.enableWidgetPoop = !mnd.enableWidgetPoop
			SetToggleOptionValue(option, mnd.enableWidgetPoop)
		elseIf pos==8
			mnd.enableWidgetSex = !mnd.enableWidgetSex
			SetToggleOptionValue(option, mnd.enableWidgetSex)
		elseIf pos==9
			mnd.enableWidgetSkooma = !mnd.enableWidgetSkooma
			SetToggleOptionValue(option, mnd.enableWidgetSkooma)
		elseIf pos==10
			mnd.enableWidgetAlcohol = !mnd.enableWidgetAlcohol
			SetToggleOptionValue(option, mnd.enableWidgetAlcohol)
		elseIf pos==11
			mnd.enableWidgetWeed = !mnd.enableWidgetWeed
			SetToggleOptionValue(option, mnd.enableWidgetWeed)
		elseIf pos==12
			mnd.enableWidgetDrunk = !mnd.enableWidgetDrunk
			SetToggleOptionValue(option, mnd.enableWidgetDrunk)
		endIf 
	endIf
endEvent

; -))


; ((- Statefull Options

state FreePlayerBN
	event OnSelectST()
		if Game.GetCameraState() == 3 && mnd.weHaveSexLab
			MiscUtil.ToggleFreeCamera()
			Game.ForceThirdPerson()
		endIf
		mnd.PlayerRef.unEquipItem(mndPee0, false, true)
		mnd.PlayerRef.unEquipItem(mndPee1, false, true)
		mnd.PlayerRef.ForceAV("MagickaRateMult", 100.0)
		mnd.PlayerRef.ForceAV("HealRateMult", 100.0)
		mnd.PlayerRef.ForceAV("StaminaRateMult", 100.0)
		mnd.PlayerRef.unEquipItem(mndPee0, false, true)
		mnd.PlayerRef.unEquipItem(mndPee1, false, true)
		Game.EnablePlayerControls(true, true, false, false, false, false, false, false, 0)
		Game.setPlayerAIDriven(false)
		mnd.PlayerRef.EquipItem(mnd.mndPeeNone, false, true)
		Debug.SendAnimationEvent(mnd.PlayerRef, "IdleForceDefaultState")
		mndShowers.resetBuilding()
		mnd.PlayerRef.unEquipItem(mnd.mndPeeNone, false, true)
		SetTextOptionValueST("$MND_Done", false)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MND_HelpFreePlayer")
	endEvent
endState

state DisableModBN
	event OnSelectST()
		if mnd.disableTheMod==0
			if !ShowMessage("$MND_AreYouSureDisable", true, "$MND_Yes", "$MND_No")
				return
			endIf
			SetTextOptionValueST("$MND_Disabling")
			disableMiniNeeds()
		else
			SetTextOptionValueST("$MND_Enabling")
			enableMiniNeeds(ShowMessage("$MND_ResetDefaultValues", true, "$MND_Yes", "$MND_No"))
		endIf
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpDisableMod")
	endEvent
endState

state LoadSaveConfigBN
	event OnSelectST()
		pageMode=1
		ForcepageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpLoadSaveConfig")
	endEvent
endState

state LoadConfigFromJSONBN
	event OnSelectST()
		string file = "../MiniNeeds/" + possibleJSONs[selectedJSONFile]
		if !JSONUtil.IsGood(file)
			Debug.MessageBox("$MND_NotValidJSON{" + JSONUtil.GetErrors("../MiniNeeds/" + possibleJSONs[selectedJSONFile]) + "}")
			return
		endIf
		SetTextOptionValueST("$MND_LoadingInProgress")
		; Get all the values and update all properties
		mnd.enableStaticShowers = JsonUtil.GetPathBoolValue(file, ".Config.enableStaticShowers", mnd.enableStaticShowers)
		mnd.reverseWidgets = JsonUtil.GetPathBoolValue(file, ".Config.reverseWidgets", mnd.reverseWidgets)
		mnd.useNutritionValues = JsonUtil.GetPathIntValue(file, ".Config.useNutritionValues", mnd.useNutritionValues)
		mnd.enableEat = JsonUtil.GetPathBoolValue(file, ".Config.enableEat", mnd.enableEat)
		mnd.timeEat = JsonUtil.GetPathFloatValue(file, ".Config.timeEat", mnd.timeEat)
		mnd.maxEatDamage = JsonUtil.GetPathFloatValue(file, ".Config.maxEatDamage", mnd.maxEatDamage)
		mnd.useAnimForEating = JsonUtil.GetPathBoolValue(file, ".Config.useAnimForEating", mnd.useAnimForEating)
		mnd.enableDrink = JsonUtil.GetPathBoolValue(file, ".Config.enableDrink", mnd.enableDrink)
		mnd.timeDrink = JsonUtil.GetPathFloatValue(file, ".Config.timeDrink", mnd.timeDrink)
		mnd.maxDrinkDamage = JsonUtil.GetPathFloatValue(file, ".Config.maxDrinkDamage", mnd.maxDrinkDamage)
		mnd.useAnimForDrinking = JsonUtil.GetPathBoolValue(file, ".Config.useAnimForDrinking", mnd.useAnimForDrinking)
		mnd.enableSleep = JsonUtil.GetPathBoolValue(file, ".Config.enableSleep", mnd.enableSleep)
		mnd.timeSleep = JsonUtil.GetPathFloatValue(file, ".Config.timeSleep", mnd.timeSleep)
		mnd.maxSleepDamage = JsonUtil.GetPathFloatValue(file, ".Config.maxSleepDamage", mnd.maxSleepDamage)
		mnd.enableTalk = JsonUtil.GetPathBoolValue(file, ".Config.enableTalk", mnd.enableTalk)
		mnd.timeTalk = JsonUtil.GetPathFloatValue(file, ".Config.timeTalk", mnd.timeTalk)
		mnd.maxTalkDamage = JsonUtil.GetPathFloatValue(file, ".Config.maxTalkDamage", mnd.maxTalkDamage)
		mnd.enablePiss = JsonUtil.GetPathBoolValue(file, ".Config.enablePiss", mnd.enablePiss)
		mnd.timePiss = JsonUtil.GetPathFloatValue(file, ".Config.timePiss", mnd.timePiss)
		mnd.maxPissDamage = JsonUtil.GetPathFloatValue(file, ".Config.maxPissDamage", mnd.maxPissDamage)
		mnd.useAnimForPissing = JsonUtil.GetPathBoolValue(file, ".Config.useAnimForPissing", mnd.useAnimForPissing)
		mnd.howToPiss = JsonUtil.GetPathIntValue(file, ".Config.howToPiss", mnd.howToPiss)
		mnd.keyToPiss = JsonUtil.GetPathIntValue(file, ".Config.keyToPiss", mnd.keyToPiss)
		mnd.noPissInPublic = JsonUtil.GetPathBoolValue(file, ".Config.noPissInPublic", mnd.noPissInPublic)
		mnd.addPissPuddle = JsonUtil.GetPathIntValue(file, ".Config.addPissPuddle", mnd.addPissPuddle)
		mnd.enablePoop = JsonUtil.GetPathBoolValue(file, ".Config.enablePoop", mnd.enablePoop)
		mnd.timePoop = JsonUtil.GetPathFloatValue(file, ".Config.timePoop", mnd.timePoop)
		mnd.maxPoopDamage = JsonUtil.GetPathFloatValue(file, ".Config.maxPoopDamage", mnd.maxPoopDamage)
		mnd.useAnimForPooping = JsonUtil.GetPathBoolValue(file, ".Config.useAnimForPooping", mnd.useAnimForPooping)
		mnd.howToPoop = JsonUtil.GetPathIntValue(file, ".Config.howToPoop", mnd.howToPoop)
		mnd.keyToPoop = JsonUtil.GetPathIntValue(file, ".Config.keyToPoop", mnd.keyToPoop)
		mnd.howToPissPoop = JsonUtil.GetPathIntValue(file, ".Config.howToPissPoop", mnd.howToPissPoop)
		mnd.keyToPissPoop = JsonUtil.GetPathIntValue(file, ".Config.keyToPissPoop", mnd.keyToPissPoop)
		mnd.noPoopInPublic = JsonUtil.GetPathBoolValue(file, ".Config.noPoopInPublic", mnd.noPoopInPublic)
		mnd.addVisiblePoop = JsonUtil.GetPathIntValue(file, ".Config.addVisiblePoop", mnd.addVisiblePoop)
		mnd.pissAndPoopTogether = JsonUtil.GetPathBoolValue(file, ".Config.pissAndPoopTogether", mnd.pissAndPoopTogether)
		mnd.enableSex = JsonUtil.GetPathBoolValue(file, ".Config.enableSex", mnd.enableSex)
		mnd.timeSex = JsonUtil.GetPathFloatValue(file, ".Config.timeSex", mnd.timeSex)
		mnd.maxSexDamage = JsonUtil.GetPathFloatValue(file, ".Config.maxSexDamage", mnd.maxSexDamage)
		mnd.noSexInPublic = JsonUtil.GetPathBoolValue(file, ".Config.noSexInPublic", mnd.noSexInPublic)
		mnd.keyToMasturbate = JsonUtil.GetPathIntValue(file, ".Config.keyToMasturbate", mnd.keyToMasturbate)
		mnd.enableDrunk = JsonUtil.GetPathBoolValue(file, ".Config.enableDrunk", mnd.enableDrunk)
		mnd.timeDrunk = JsonUtil.GetPathFloatValue(file, ".Config.timeDrunk", mnd.timeDrunk)
		mnd.maxDrunkDamage = JsonUtil.GetPathFloatValue(file, ".Config.maxDrunkDamage", mnd.maxDrunkDamage)
		mnd.enableBath = JsonUtil.GetPathBoolValue(file, ".Config.enableBath", mnd.enableBath)
		mnd.timeBath = JsonUtil.GetPathFloatValue(file, ".Config.timeBath", mnd.timeBath)
		mnd.maxBathDamage = JsonUtil.GetPathFloatValue(file, ".Config.maxBathDamage", mnd.maxBathDamage)
		mnd.noDirtShaderWhileCum = JsonUtil.GetPathBoolValue(file, ".Config.noDirtShaderWhileCum", mnd.noDirtShaderWhileCum)
		mnd.enablePray = JsonUtil.GetPathBoolValue(file, ".Config.enablePray", mnd.enablePray)
		mnd.timePray = JsonUtil.GetPathFloatValue(file, ".Config.timePray", mnd.timePray)
		mnd.maxPrayDamage = JsonUtil.GetPathFloatValue(file, ".Config.maxPrayDamage", mnd.maxPrayDamage)
		mnd.enableSkooma = JsonUtil.GetPathBoolValue(file, ".Config.enableSkooma", mnd.enableSkooma)
		mnd.timeSkooma = JsonUtil.GetPathFloatValue(file, ".Config.timeSkooma", mnd.timeSkooma)
		mnd.maxSkoomaDamage = JsonUtil.GetPathFloatValue(file, ".Config.maxSkoomaDamage", mnd.maxSkoomaDamage)
		mnd.enableAlcohol = JsonUtil.GetPathBoolValue(file, ".Config.enableAlcohol", mnd.enableAlcohol)
		mnd.timeAlcohol = JsonUtil.GetPathFloatValue(file, ".Config.timeAlcohol", mnd.timeAlcohol)
		mnd.maxAlcoholDamage = JsonUtil.GetPathFloatValue(file, ".Config.maxAlcoholDamage", mnd.maxAlcoholDamage)
		mnd.enableWeed = JsonUtil.GetPathBoolValue(file, ".Config.enableWeed", mnd.enableWeed)
		mnd.timeWeed = JsonUtil.GetPathFloatValue(file, ".Config.timeWeed", mnd.timeWeed)
		mnd.maxWeedDamage = JsonUtil.GetPathFloatValue(file, ".Config.maxWeedDamage", mnd.maxWeedDamage)
		mnd.stripMode = JsonUtil.GetPathIntValue(file, ".Config.stripMode", mnd.stripMode)
		mnd.enableWidgets = JsonUtil.GetPathBoolValue(file, ".Config.enableWidgets", mnd.enableWidgets)
		mnd.widgetsKey = JsonUtil.GetPathIntValue(file, ".Config.widgetsKey", mnd.widgetsKey)
		mnd.oldWidgetsKey = JsonUtil.GetPathIntValue(file, ".Config.oldWidgetsKey", mnd.oldWidgetsKey)
		mnd.widgetsOpacities = JsonUtil.GetPathIntValue(file, ".Config.widgetsOpacities", mnd.widgetsOpacities)
		mnd.widgetsPositions = JsonUtil.GetPathIntValue(file, ".Config.widgetsPositions", mnd.widgetsPositions)
		mnd.widgetsArrangements = JsonUtil.GetPathIntValue(file, ".Config.widgetsArrangements", mnd.widgetsArrangements)
		mnd.widgetsSize = JsonUtil.GetPathIntValue(file, ".Config.widgetsSize", mnd.widgetsSize)
		mnd.widgetsSpace = JsonUtil.GetPathIntValue(file, ".Config.widgetsSpace", mnd.widgetsSpace)
		mnd.widgetsMarginH = JsonUtil.GetPathIntValue(file, ".Config.widgetsMarginH", mnd.widgetsMarginH)
		mnd.widgetsMarginV = JsonUtil.GetPathIntValue(file, ".Config.widgetsMarginV", mnd.widgetsMarginV)
		mnd.widgetsGrouped = JsonUtil.GetPathIntValue(file, ".Config.widgetsGrouped", mnd.widgetsGrouped)
		mnd.useTimeScale = JsonUtil.GetPathBoolValue(file, ".Config.useTimeScale", mnd.useTimeScale)
		mnd.notificationsTime = JsonUtil.GetPathIntValue(file, ".Config.notificationsTime", mnd.notificationsTime)
		mnd.disableTheMod = JsonUtil.GetPathBoolValue(file, ".Config.disableTheMod", mnd.disableTheMod)
		mnd.enableWidgetEat = JsonUtil.GetPathBoolValue(file, ".Config.enableWidgetEat", mnd.enableWidgetEat)
		mnd.enableWidgetDrink = JsonUtil.GetPathBoolValue(file, ".Config.enableWidgetDrink", mnd.enableWidgetDrink)
		mnd.enableWidgetSleep = JsonUtil.GetPathBoolValue(file, ".Config.enableWidgetSleep", mnd.enableWidgetSleep)
		mnd.enableWidgetTalk = JsonUtil.GetPathBoolValue(file, ".Config.enableWidgetTalk", mnd.enableWidgetTalk)
		mnd.enableWidgetBath = JsonUtil.GetPathBoolValue(file, ".Config.enableWidgetBath", mnd.enableWidgetBath)
		mnd.enableWidgetPray = JsonUtil.GetPathBoolValue(file, ".Config.enableWidgetPray", mnd.enableWidgetPray)
		mnd.enableWidgetPiss = JsonUtil.GetPathBoolValue(file, ".Config.enableWidgetPiss", mnd.enableWidgetPiss)
		mnd.enableWidgetPoop = JsonUtil.GetPathBoolValue(file, ".Config.enableWidgetPoop", mnd.enableWidgetPoop)
		mnd.enableWidgetSex = JsonUtil.GetPathBoolValue(file, ".Config.enableWidgetSex", mnd.enableWidgetSex)
		mnd.enableWidgetSkooma = JsonUtil.GetPathBoolValue(file, ".Config.enableWidgetSkooma", mnd.enableWidgetSkooma)
		mnd.enableWidgetAlcohol = JsonUtil.GetPathBoolValue(file, ".Config.enableWidgetAlcohol", mnd.enableWidgetAlcohol)
		mnd.enableWidgetWeed = JsonUtil.GetPathBoolValue(file, ".Config.enableWidgetWeed", mnd.enableWidgetWeed)
		mnd.enableWidgetDrunk = JsonUtil.GetPathBoolValue(file, ".Config.enableWidgetDrunk", mnd.enableWidgetDrunk)
		mnd.widColSEat = JsonUtil.GetPathIntValue(file, ".Config.widColSEat", mnd.widColSEat)
		mnd.widColEEat = JsonUtil.GetPathIntValue(file, ".Config.widColEEat", mnd.widColEEat)
		mnd.widColSDrink = JsonUtil.GetPathIntValue(file, ".Config.widColSDrink", mnd.widColSDrink)
		mnd.widColEDrink = JsonUtil.GetPathIntValue(file, ".Config.widColEDrink", mnd.widColEDrink)
		mnd.widColSSleep = JsonUtil.GetPathIntValue(file, ".Config.widColSSleep", mnd.widColSSleep)
		mnd.widColESleep = JsonUtil.GetPathIntValue(file, ".Config.widColESleep", mnd.widColESleep)
		mnd.widColSTalk = JsonUtil.GetPathIntValue(file, ".Config.widColSTalk", mnd.widColSTalk)
		mnd.widColETalk = JsonUtil.GetPathIntValue(file, ".Config.widColETalk", mnd.widColETalk)
		mnd.widColSBath = JsonUtil.GetPathIntValue(file, ".Config.widColSBath", mnd.widColSBath)
		mnd.widColEBath = JsonUtil.GetPathIntValue(file, ".Config.widColEBath", mnd.widColEBath)
		mnd.widColSPray = JsonUtil.GetPathIntValue(file, ".Config.widColSPray", mnd.widColSPray)
		mnd.widColEPray = JsonUtil.GetPathIntValue(file, ".Config.widColEPray", mnd.widColEPray)
		mnd.widColSPiss = JsonUtil.GetPathIntValue(file, ".Config.widColSPiss", mnd.widColSPiss)
		mnd.widColEPiss = JsonUtil.GetPathIntValue(file, ".Config.widColEPiss", mnd.widColEPiss)
		mnd.widColSPoop = JsonUtil.GetPathIntValue(file, ".Config.widColSPoop", mnd.widColSPoop)
		mnd.widColEPoop = JsonUtil.GetPathIntValue(file, ".Config.widColEPoop", mnd.widColEPoop)
		mnd.widColSSex = JsonUtil.GetPathIntValue(file, ".Config.widColSSex", mnd.widColSSex)
		mnd.widColESex = JsonUtil.GetPathIntValue(file, ".Config.widColESex", mnd.widColESex)
		mnd.widColSDrunk = JsonUtil.GetPathIntValue(file, ".Config.widColSDrunk", mnd.widColSDrunk)
		mnd.widColEDrunk = JsonUtil.GetPathIntValue(file, ".Config.widColEDrunk", mnd.widColEDrunk)
		mnd.widColSSkooma = JsonUtil.GetPathIntValue(file, ".Config.widColSSkooma", mnd.widColSSkooma)
		mnd.widColESkooma = JsonUtil.GetPathIntValue(file, ".Config.widColESkooma", mnd.widColESkooma)
		mnd.widColSAlcohol = JsonUtil.GetPathIntValue(file, ".Config.widColSAlcohol", mnd.widColSAlcohol)
		mnd.widColEAlcohol = JsonUtil.GetPathIntValue(file, ".Config.widColEAlcohol", mnd.widColEAlcohol)
		mnd.widColSWeed = JsonUtil.GetPathIntValue(file, ".Config.widColSWeed", mnd.widColSWeed)
		mnd.widColEWeed = JsonUtil.GetPathIntValue(file, ".Config.widColEWeed", mnd.widColEWeed)
		; If the part is missing we cannot update the penalties
		int[] tmpPenalties = JSONUtil.PathIntElements(file, ".Config.penalties0", -1)
		if tmpPenalties && tmpPenalties.length==15 && tmpPenalties[0]!=-1
			mnd.penalties0 = tmpPenalties
		endIf
		tmpPenalties = JSONUtil.PathIntElements(file, ".Config.penalties1", -1)
		if tmpPenalties && tmpPenalties.length==15 && tmpPenalties[0]!=-1
			mnd.penalties1 = tmpPenalties
		endIf
		tmpPenalties = JSONUtil.PathIntElements(file, ".Config.penalties2", -1)
		if tmpPenalties && tmpPenalties.length==15 && tmpPenalties[0]!=-1
			mnd.penalties2 = tmpPenalties
		endIf
		tmpPenalties = JSONUtil.PathIntElements(file, ".Config.penalties3", -1)
		if tmpPenalties && tmpPenalties.length==15 && tmpPenalties[0]!=-1
			mnd.penalties3 = tmpPenalties
		endIf
		tmpPenalties = JSONUtil.PathIntElements(file, ".Config.penalties4", -1)
		if tmpPenalties && tmpPenalties.length==15 && tmpPenalties[0]!=-1
			mnd.penalties4 = tmpPenalties
		endIf
		ShowMessage("$MND_ConfigLoaded{" + possibleJSONs[selectedJSONFile] + "}", false)
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpLoadConfigFromJson")
	endEvent
endState

state SaveConfigToJSONBN
	event OnSelectST()
		SetTextOptionValueST("$MND_SavingInProgress")
		string file = "../MiniNeeds/"
		string fileName = ""
		if saveFileName!=""
			fileName = saveFileName
			file += saveFileName
			if StringUtil.GetLength(saveFileName)<5
				file += ".json"
			elseIf StringUtil.substring(saveFileName, StringUtil.GetLength(saveFileName) - 6)!=".json"
				file += ".json"
			endIf
		else
			fileName = "currentMiniNeedsConfig"
			file += "currentMiniNeedsConfig.json"
		endIf
		
		; Get all the values and update all properties
		SetPathBoolValue(file, ".Config.enableStaticShowers", mnd.enableStaticShowers)
		SetPathBoolValue(file, ".Config.reverseWidgets", mnd.reverseWidgets)
		JsonUtil.SetPathIntValue(file, ".Config.useNutritionValues", mnd.useNutritionValues)
		SetPathBoolValue(file, ".Config.enableEat", mnd.enableEat)
		JsonUtil.SetPathFloatValue(file, ".Config.timeEat", mnd.timeEat)
		JsonUtil.SetPathFloatValue(file, ".Config.maxEatDamage", mnd.maxEatDamage)
		SetPathBoolValue(file, ".Config.useAnimForEating", mnd.useAnimForEating)
		SetPathBoolValue(file, ".Config.enableDrink", mnd.enableDrink)
		JsonUtil.SetPathFloatValue(file, ".Config.timeDrink", mnd.timeDrink)
		JsonUtil.SetPathFloatValue(file, ".Config.maxDrinkDamage", mnd.maxDrinkDamage)
		SetPathBoolValue(file, ".Config.useAnimForDrinking", mnd.useAnimForDrinking)
		SetPathBoolValue(file, ".Config.enableSleep", mnd.enableSleep)
		JsonUtil.SetPathFloatValue(file, ".Config.timeSleep", mnd.timeSleep)
		JsonUtil.SetPathFloatValue(file, ".Config.maxSleepDamage", mnd.maxSleepDamage)
		SetPathBoolValue(file, ".Config.enableTalk", mnd.enableTalk)
		JsonUtil.SetPathFloatValue(file, ".Config.timeTalk", mnd.timeTalk)
		JsonUtil.SetPathFloatValue(file, ".Config.maxTalkDamage", mnd.maxTalkDamage)
		SetPathBoolValue(file, ".Config.enablePiss", mnd.enablePiss	)
		JsonUtil.SetPathFloatValue(file, ".Config.timePiss", mnd.timePiss)
		JsonUtil.SetPathFloatValue(file, ".Config.maxPissDamage", mnd.maxPissDamage)
		SetPathBoolValue(file, ".Config.useAnimForPissing", mnd.useAnimForPissing)
		JsonUtil.SetPathIntValue(file, ".Config.howToPiss", mnd.howToPiss)
		JsonUtil.SetPathIntValue(file, ".Config.keyToPiss", mnd.keyToPiss)
		SetPathBoolValue(file, ".Config.noPissInPublic", mnd.noPissInPublic)
		JsonUtil.SetPathIntValue(file, ".Config.addPissPuddle", mnd.addPissPuddle)
		SetPathBoolValue(file, ".Config.enablePoop", mnd.enablePoop)
		JsonUtil.SetPathFloatValue(file, ".Config.timePoop", mnd.timePoop)
		JsonUtil.SetPathFloatValue(file, ".Config.maxPoopDamage", mnd.maxPoopDamage)
		SetPathBoolValue(file, ".Config.useAnimForPooping", mnd.useAnimForPooping)
		JsonUtil.SetPathIntValue(file, ".Config.howToPoop", mnd.howToPoop)
		JsonUtil.SetPathIntValue(file, ".Config.keyToPoop", mnd.keyToPoop)
		JsonUtil.SetPathIntValue(file, ".Config.howToPissPoop", mnd.howToPissPoop)
		JsonUtil.SetPathIntValue(file, ".Config.keyToPissPoop", mnd.keyToPissPoop)
		SetPathBoolValue(file, ".Config.noPoopInPublic", mnd.noPoopInPublic)
		JsonUtil.SetPathIntValue(file, ".Config.addVisiblePoop", mnd.addVisiblePoop)
		SetPathBoolValue(file, ".Config.pissAndPoopTogether", mnd.pissAndPoopTogether)
		SetPathBoolValue(file, ".Config.enableSex", mnd.enableSex)
		JsonUtil.SetPathFloatValue(file, ".Config.timeSex", mnd.timeSex)
		JsonUtil.SetPathFloatValue(file, ".Config.maxSexDamage", mnd.maxSexDamage)
		SetPathBoolValue(file, ".Config.noSexInPublic", mnd.noSexInPublic)
		JsonUtil.SetPathIntValue(file, ".Config.keyToMasturbate", mnd.keyToMasturbate)
		SetPathBoolValue(file, ".Config.enableDrunk", mnd.enableDrunk)
		JsonUtil.SetPathFloatValue(file, ".Config.timeDrunk", mnd.timeDrunk)
		JsonUtil.SetPathFloatValue(file, ".Config.maxDrunkDamage", mnd.maxDrunkDamage)
		SetPathBoolValue(file, ".Config.enableBath", mnd.enableBath)
		JsonUtil.SetPathFloatValue(file, ".Config.timeBath", mnd.timeBath)
		JsonUtil.SetPathFloatValue(file, ".Config.maxBathDamage", mnd.maxBathDamage)
		SetPathBoolValue(file, ".Config.noDirtShaderWhileCum", mnd.noDirtShaderWhileCum)
		SetPathBoolValue(file, ".Config.enablePray", mnd.enablePray)
		JsonUtil.SetPathFloatValue(file, ".Config.timePray", mnd.timePray)
		JsonUtil.SetPathFloatValue(file, ".Config.maxPrayDamage", mnd.maxPrayDamage)
		SetPathBoolValue(file, ".Config.enableSkooma", mnd.enableSkooma)
		JsonUtil.SetPathFloatValue(file, ".Config.timeSkooma", mnd.timeSkooma)
		JsonUtil.SetPathFloatValue(file, ".Config.maxSkoomaDamage", mnd.maxSkoomaDamage)
		SetPathBoolValue(file, ".Config.enableAlcohol", mnd.enableAlcohol)
		JsonUtil.SetPathFloatValue(file, ".Config.timeAlcohol", mnd.timeAlcohol)
		JsonUtil.SetPathFloatValue(file, ".Config.maxAlcoholDamage", mnd.maxAlcoholDamage)
		SetPathBoolValue(file, ".Config.enableWeed", mnd.enableWeed)
		JsonUtil.SetPathFloatValue(file, ".Config.timeWeed", mnd.timeWeed)
		JsonUtil.SetPathFloatValue(file, ".Config.maxWeedDamage", mnd.maxWeedDamage)
		JsonUtil.SetPathIntValue(file, ".Config.stripMode", mnd.stripMode)
		SetPathBoolValue(file, ".Config.enableWidgets", mnd.enableWidgets)
		JsonUtil.SetPathIntValue(file, ".Config.widgetsKey", mnd.widgetsKey)
		JsonUtil.SetPathIntValue(file, ".Config.oldWidgetsKey", mnd.oldWidgetsKey)
		JsonUtil.SetPathIntValue(file, ".Config.widgetsOpacities", mnd.widgetsOpacities)
		JsonUtil.SetPathIntValue(file, ".Config.widgetsPositions", mnd.widgetsPositions)
		JsonUtil.SetPathIntValue(file, ".Config.widgetsArrangements", mnd.widgetsArrangements)
		JsonUtil.SetPathIntValue(file, ".Config.widgetsSize", mnd.widgetsSize)
		JsonUtil.SetPathIntValue(file, ".Config.widgetsSpace", mnd.widgetsSpace)
		JsonUtil.SetPathIntValue(file, ".Config.widgetsMarginH", mnd.widgetsMarginH)
		JsonUtil.SetPathIntValue(file, ".Config.widgetsMarginV", mnd.widgetsMarginV)
		JsonUtil.SetPathIntValue(file, ".Config.widgetsGrouped", mnd.widgetsGrouped)
		SetPathBoolValue(file, ".Config.useTimeScale", mnd.useTimeScale)
		JsonUtil.SetPathIntValue(file, ".Config.notificationsTime", mnd.notificationsTime)
		SetPathBoolValue(file, ".Config.disableTheMod", mnd.disableTheMod)
		SetPathBoolValue(file, ".Config.enableWidgetEat", mnd.enableWidgetEat)
		SetPathBoolValue(file, ".Config.enableWidgetDrink", mnd.enableWidgetDrink)
		SetPathBoolValue(file, ".Config.enableWidgetSleep", mnd.enableWidgetSleep)
		SetPathBoolValue(file, ".Config.enableWidgetTalk", mnd.enableWidgetTalk)
		SetPathBoolValue(file, ".Config.enableWidgetBath", mnd.enableWidgetBath)
		SetPathBoolValue(file, ".Config.enableWidgetPray", mnd.enableWidgetPray)
		SetPathBoolValue(file, ".Config.enableWidgetPiss", mnd.enableWidgetPiss)
		SetPathBoolValue(file, ".Config.enableWidgetPoop", mnd.enableWidgetPoop)
		SetPathBoolValue(file, ".Config.enableWidgetSex", mnd.enableWidgetSex)
		SetPathBoolValue(file, ".Config.enableWidgetSkooma", mnd.enableWidgetSkooma)
		SetPathBoolValue(file, ".Config.enableWidgetAlcohol", mnd.enableWidgetAlcohol)
		SetPathBoolValue(file, ".Config.enableWidgetWeed", mnd.enableWidgetWeed)
		SetPathBoolValue(file, ".Config.enableWidgetDrunk", mnd.enableWidgetDrunk)
		JsonUtil.SetPathIntValue(file, ".Config.widColSEat", mnd.widColSEat)
		JsonUtil.SetPathIntValue(file, ".Config.widColEEat", mnd.widColEEat)
		JsonUtil.SetPathIntValue(file, ".Config.widColSDrink", mnd.widColSDrink)
		JsonUtil.SetPathIntValue(file, ".Config.widColEDrink", mnd.widColEDrink)
		JsonUtil.SetPathIntValue(file, ".Config.widColSSleep", mnd.widColSSleep)
		JsonUtil.SetPathIntValue(file, ".Config.widColESleep", mnd.widColESleep)
		JsonUtil.SetPathIntValue(file, ".Config.widColSTalk", mnd.widColSTalk)
		JsonUtil.SetPathIntValue(file, ".Config.widColETalk", mnd.widColETalk)
		JsonUtil.SetPathIntValue(file, ".Config.widColSBath", mnd.widColSBath)
		JsonUtil.SetPathIntValue(file, ".Config.widColEBath", mnd.widColEBath)
		JsonUtil.SetPathIntValue(file, ".Config.widColSPray", mnd.widColSPray)
		JsonUtil.SetPathIntValue(file, ".Config.widColEPray", mnd.widColEPray)
		JsonUtil.SetPathIntValue(file, ".Config.widColSPiss", mnd.widColSPiss)
		JsonUtil.SetPathIntValue(file, ".Config.widColEPiss", mnd.widColEPiss)
		JsonUtil.SetPathIntValue(file, ".Config.widColSPoop", mnd.widColSPoop)
		JsonUtil.SetPathIntValue(file, ".Config.widColEPoop", mnd.widColEPoop)
		JsonUtil.SetPathIntValue(file, ".Config.widColSSex", mnd.widColSSex)
		JsonUtil.SetPathIntValue(file, ".Config.widColESex", mnd.widColESex)
		JsonUtil.SetPathIntValue(file, ".Config.widColSDrunk", mnd.widColSDrunk)
		JsonUtil.SetPathIntValue(file, ".Config.widColEDrunk", mnd.widColEDrunk)
		JsonUtil.SetPathIntValue(file, ".Config.widColSSkooma", mnd.widColSSkooma)
		JsonUtil.SetPathIntValue(file, ".Config.widColESkooma", mnd.widColESkooma)
		JsonUtil.SetPathIntValue(file, ".Config.widColSAlcohol", mnd.widColSAlcohol)
		JsonUtil.SetPathIntValue(file, ".Config.widColEAlcohol", mnd.widColEAlcohol)
		JsonUtil.SetPathIntValue(file, ".Config.widColSWeed", mnd.widColSWeed)
		JsonUtil.SetPathIntValue(file, ".Config.widColEWeed", mnd.widColEWeed)
		JSONUtil.SetPathIntArray(file, ".Config.penalties0", mnd.penalties0)
		JSONUtil.SetPathIntArray(file, ".Config.penalties1", mnd.penalties1)
		JSONUtil.SetPathIntArray(file, ".Config.penalties2", mnd.penalties2)
		JSONUtil.SetPathIntArray(file, ".Config.penalties3", mnd.penalties3)
		JSONUtil.SetPathIntArray(file, ".Config.penalties4", mnd.penalties4)
		JSONUtil.save(file)
		mnd.saveFoodJson(file)
		ShowMessage("$MND_ConfigSaved{" + file + "}", false)
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpLoadConfigFromJson")
	endEvent
endState

state SavePenaltiesConfigToJSONBN
	event OnSelectST()
		SetTextOptionValueST("$MND_SavingInProgress")
		string file = "../MiniNeeds/"
		string fileName = ""
		if saveFileName!=""
			fileName = saveFileName
			file += saveFileName
			if StringUtil.GetLength(saveFileName)<5
				file += ".json"
			elseIf StringUtil.substring(saveFileName, StringUtil.GetLength(saveFileName) - 6)!=".json"
				file += ".json"
			endIf
		else
			fileName = "currentMiniNeedsConfig"
			file += "currentMiniNeedsConfig.json"
		endIf
		
		; Get all the values and update all properties
		JSONUtil.SetPathIntArray(file, ".Config.penalties0", mnd.penalties0)
		JSONUtil.SetPathIntArray(file, ".Config.penalties1", mnd.penalties1)
		JSONUtil.SetPathIntArray(file, ".Config.penalties2", mnd.penalties2)
		JSONUtil.SetPathIntArray(file, ".Config.penalties3", mnd.penalties3)
		JSONUtil.SetPathIntArray(file, ".Config.penalties4", mnd.penalties4)
		JSONUtil.save(file)
		ShowMessage("$MND_ConfigSaved{" + fileName + "}", false)
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_SavePenaltiesConfigToJson")
	endEvent
endState

state SaveFoodConfigToJSONBN
	event OnSelectST()
		SetTextOptionValueST("$MND_SavingInProgress")
		string file = "../MiniNeeds/"
		string fileName = ""
		if saveFileName!=""
			fileName = saveFileName
			file += saveFileName
			if StringUtil.GetLength(saveFileName)<5
				file += ".json"
			elseIf StringUtil.substring(saveFileName, StringUtil.GetLength(saveFileName) - 6)!=".json"
				file += ".json"
			endIf
		else
			fileName = "currentMiniNeedsConfig"
			file += "currentMiniNeedsConfig.json"
		endIf
		mnd.saveFoodJson(file)
		ShowMessage("$MND_ConfigSaved{" + file + "}", false)
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_SaveSaveFoodConfigToJson")
	endEvent
endState

function SetPathBoolValue(string file, string jsonKey, bool val)
	if val
		JsonUtil.SetPathIntValue(file, jsonKey, 1)
	else
		JsonUtil.SetPathIntValue(file, jsonKey, 0)
	endIf
endFunction

state SaveConfigNameIN
	event OnInputOpenST()
		if saveFileName!=""
			SetInputDialogStartText(saveFileName)
		endIf
	endEvent

	event OnInputAcceptST(string newTxt)
		saveFileName = newTxt
		SetInputOptionValueST(saveFileName)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MND_HelpSaveConfigName")
	endEvent
endState

state SavePenaltiesConfigNameIN
	event OnInputOpenST()
		if saveFileName!=""
			SetInputDialogStartText(saveFileName)
		endIf
	endEvent

	event OnInputAcceptST(string newTxt)
		saveFileName = newTxt
		SetInputOptionValueST(saveFileName)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MND_HelpSavePenaltiesConfigName")
	endEvent
endState

state SaveFoodConfigNameIN
	event OnInputOpenST()
		if saveFileName!=""
			SetInputDialogStartText(saveFileName)
		endIf
	endEvent

	event OnInputAcceptST(string newTxt)
		saveFileName = newTxt
		SetInputOptionValueST(saveFileName)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MND_HelpSaveFoodConfigName")
	endEvent
endState

state EnableStaticShowersTG
	event OnSelectST()
		mnd.enableStaticShowers = !mnd.enableStaticShowers
		SetToggleOptionValueST(mnd.enableStaticShowers)
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpEnableStaticShowers")
	endEvent
endState

state ReverseWidgetsTG
	event OnSelectST()
		mnd.reverseWidgets = !mnd.reverseWidgets
		SetToggleOptionValueST(mnd.reverseWidgets)
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpReverseWidgets")
	endEvent
endState

state UseNutritionValuesMN
	event OnMenuOpenST()
		SetMenuDialogStartIndex(mnd.useNutritionValues)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(useNutritionValues)
	endEvent

	event OnMenuAcceptST(int val)
		if val>=0 && val<=useNutritionValues.length
			SetMenuOptionValueST(useNutritionValues[val])
			mnd.useNutritionValues = val
			ForcePageReset()
		endIf
	endEvent
	
	event OnDefaultST()
		SetMenuOptionValueST(useNutritionValues[0])
		mnd.useNutritionValues = 0
		ForcePageReset()
	endEvent
		
	event OnHighlightST()
		SetInfoText("$MND_HelpUseNutritionValues")
	endEvent
endState

state EnableEatTG
	event OnSelectST()
		mnd.enableEat = !mnd.enableEat
		SetToggleOptionValueST(mnd.enableEat)
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpEnableEat")
	endEvent
endState

state EnableDrinkTG
	event OnSelectST()
		mnd.enableDrink = !mnd.enableDrink
		SetToggleOptionValueST(mnd.enableDrink)
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpEnableDrink")
	endEvent
endState

state EnableSleepTG
	event OnSelectST()
		mnd.enableSleep = !mnd.enableSleep
		SetToggleOptionValueST(mnd.enableSleep)
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpEnableSleep")
	endEvent
endState

state EnablePissTG
	event OnSelectST()
		mnd.enablePiss = !mnd.enablePiss
		SetToggleOptionValueST(mnd.enablePiss)
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpEnablePiss")
	endEvent
endState

state EnablePoopTG
	event OnSelectST()
		mnd.enablePoop = !mnd.enablePoop
		SetToggleOptionValueST(mnd.enablePoop)
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpEnablePooping")
	endEvent
endState

state AddPissPuddleMN
	event OnMenuOpenST()
		SetMenuDialogStartIndex(mnd.addPissPuddle)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(addPuddles)
	endEvent

	event OnMenuAcceptST(int val)
		if val>=0 && val<=stripModes.length
			SetMenuOptionValueST(addPuddles[val])
			mnd.addPissPuddle = val
		endIf
	endEvent
	
	event OnDefaultST()
		SetMenuOptionValueST(addPuddles[0])
		mnd.addPissPuddle = 0
	endEvent
		
	event OnHighlightST()
		SetInfoText("$MND_HelpAddPissPuddle")
	endEvent
endState

state AddVisiblePoopMN
	event OnMenuOpenST()
		SetMenuDialogStartIndex(mnd.addVisiblePoop)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(addPuddles)
	endEvent
	
	event OnMenuAcceptST(int val)
		if val>=0 && val<=addPuddles.length
			SetMenuOptionValueST(addPuddles[val])
			mnd.addVisiblePoop = val
		endIf
	endEvent
	
	event OnDefaultST()
		SetMenuOptionValueST(addPuddles[0])
		mnd.addVisiblePoop = 0
	endEvent
		
	event OnHighlightST()
		SetInfoText("$MND_HelpAddVisiblePoop")
	endEvent
endState

state PissAndPoopTogetherTG
	event OnSelectST()
		mnd.pissAndPoopTogether = !mnd.pissAndPoopTogether
		SetToggleOptionValueST(mnd.pissAndPoopTogether)
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpPissAndPoopTogether")
	endEvent
endState

state EnableSexTG
	event OnSelectST()
		mnd.enableSex = !mnd.enableSex
		SetToggleOptionValueST(mnd.enableSex)
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpEnableSex")
	endEvent
endState

state EnableTalkTG
	event OnSelectST()
		mnd.enableTalk = !mnd.enableTalk
		SetToggleOptionValueST(mnd.enableTalk)
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpEnableTalk")
	endEvent
endState

state EnableBathTG
	event OnSelectST()
		mnd.enableBath = !mnd.enableBath
		SetToggleOptionValueST(mnd.enableBath)
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpEnableBath")
	endEvent
endState

state EnablePrayTG
	event OnSelectST()
		mnd.enablePray = !mnd.enablePray
		SetToggleOptionValueST(mnd.enablePray)
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpEnablePray")
	endEvent
endState

state EnableDrunkTG
	event OnSelectST()
		mnd.enableDrunk = !mnd.enableDrunk
		SetToggleOptionValueST(mnd.enableDrunk)
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpEnableDrunk")
	endEvent
endState

state EnableSkoomaTG
	event OnSelectST()
		mnd.enableSkooma = !mnd.enableSkooma
		SetToggleOptionValueST(mnd.enableSkooma)
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpEnableSkooma")
	endEvent
endState

state EnableWineTG
	event OnSelectST()
		mnd.enableAlcohol = !mnd.enableAlcohol
		SetToggleOptionValueST(mnd.enableAlcohol)
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpEnableAcohol")
	endEvent
endState

state EnableWeedTG
	event OnSelectST()
		mnd.enableWeed = !mnd.enableWeed
		SetToggleOptionValueST(mnd.enableWeed)
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpEnableWeed")
	endEvent
endState

state useTimeScaleTG
	event OnSelectST()
		mnd.useTimeScale = !mnd.useTimeScale
		SetToggleOptionValueST(mnd.useTimeScale)
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpUseTimeScale")
	endEvent
endState

state NoBusinessInPublicTG
	event OnSelectST()
		if mnd.noPissInPublic || mnd.noPoopInPublic || mnd.noSexInPublic
			mnd.noPissInPublic=false
			mnd.noPoopInPublic=false
			mnd.noSexInPublic=false
			SetToggleOptionValueST(false)
		else
			mnd.noPissInPublic=true
			mnd.noPoopInPublic=true
			mnd.noSexInPublic=true
			SetToggleOptionValueST(true)
		endIf
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpNoBusinessInPublic")
	endEvent
endState

state noPissInPublicTG
	event OnSelectST()
		mnd.noPissInPublic = !mnd.noPissInPublic
		SetToggleOptionValueST(mnd.noPissInPublic)
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpNoPissInPublic")
	endEvent
endState

state NoPoopInPublicTG
	event OnSelectST()
		mnd.noPoopInPublic = !mnd.noPoopInPublic
		SetToggleOptionValueST(mnd.noPoopInPublic)
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpNoPoopInPublic")
	endEvent
endState

state NoSexInPublicTG
	event OnSelectST()
		mnd.noSexInPublic = !mnd.noSexInPublic
		SetToggleOptionValueST(mnd.noSexInPublic)
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpNoSexInPublic")
	endEvent
endState

state useAnimsTG
	event OnSelectST()
		if mnd.useAnimForDrinking || mnd.useAnimForEating || mnd.useAnimForPissing || mnd.useAnimForPooping
			mnd.useAnimForDrinking=false
			mnd.useAnimForEating=false
			mnd.useAnimForPissing=false
			mnd.useAnimForPooping=false
			SetToggleOptionValueST(false)
		else
			mnd.useAnimForDrinking=true
			mnd.useAnimForEating=true
			mnd.useAnimForPissing=true
			mnd.useAnimForPooping=true
			SetToggleOptionValueST(true)
		endIf
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpUseAnims")
	endEvent
endState

state useAnimForEatingTG
	event OnSelectST()
		mnd.useAnimForEating = !mnd.useAnimForEating
		SetToggleOptionValueST(mnd.useAnimForEating)
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpUseAnimForEating")
	endEvent
endState

state useAnimForDrinkingTG
	event OnSelectST()
		mnd.useAnimForDrinking = !mnd.useAnimForDrinking
		SetToggleOptionValueST(mnd.useAnimForDrinking)
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpUseAnimForDrinking")
	endEvent
endState

state useAnimForPissingTG
	event OnSelectST()
		mnd.useAnimForPissing = !mnd.useAnimForPissing
		SetToggleOptionValueST(mnd.useAnimForPissing)
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpUseAnimForPissing")
	endEvent
endState

state useAnimForPoopingTG
	event OnSelectST()
		mnd.useAnimForPooping = !mnd.useAnimForPooping
		SetToggleOptionValueST(mnd.useAnimForPooping)
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpUseAnimForPooping")
	endEvent
endState

state noDirtShaderWhileCumTG
	event OnSelectST()
		mnd.noDirtShaderWhileCum = !mnd.noDirtShaderWhileCum
		SetToggleOptionValueST(mnd.noDirtShaderWhileCum)
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpNoDirtShaderWhileCum")
	endEvent
endState

state NotificationsTimeMN
	event OnMenuOpenST()
		SetMenuDialogStartIndex(mnd.notificationsTime)
		SetMenuDialogDefaultIndex(2)
		SetMenuDialogOptions(notificationsTimes)
	endEvent

	event OnMenuAcceptST(int val)
		if val>=0 && val<=notificationsTimes.length
			SetMenuOptionValueST(notificationsTimes[val])
			mnd.notificationsTime = val
			ForcePageReset()
		endIf
	endEvent
	
	event OnDefaultST()
		SetMenuOptionValueST(notificationsTimes[2])
		mnd.notificationsTime = 2
		ForcePageReset()
	endEvent
		
	event OnHighlightST()
		SetInfoText("$MND_HelpNotificationsTime")
	endEvent
endState

state StripModeMN
	event OnMenuOpenST()
		SetMenuDialogStartIndex(mnd.stripMode)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(stripModes)
	endEvent

	event OnMenuAcceptST(int val)
		if val>=0 && val<=stripModes.length
			SetMenuOptionValueST(stripModes[val])
			mnd.stripMode = val
			ForcePageReset()
		endIf
	endEvent
	
	event OnDefaultST()
		SetMenuOptionValueST(stripModes[1])
		mnd.stripMode = 0
		ForcePageReset()
	endEvent
		
	event OnHighlightST()
		if mnd.weHaveSexLab
			SetInfoText("$MND_HelpSLStripMode")
		else
			SetInfoText("$MND_HelpStripMode")
		endIf
	endEvent
endState

state JsonToLoadMN
	event OnMenuOpenST()
		SetMenuDialogStartIndex(selectedJSONFile)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(possibleJSONs)
	endEvent

	event OnMenuAcceptST(int val)
		if val>=0 && val<=possibleJSONs.length
			SetMenuOptionValueST(possibleJSONs[val])
			selectedJSONFile = val
			ForcePageReset()
		endIf
	endEvent
	
	event OnDefaultST()
		SetMenuOptionValueST(possibleJSONs[0])
		selectedJSONFile = 0
		ForcePageReset()
	endEvent
		
	event OnHighlightST()
		SetInfoText("$MND_HelpJsonToLoad")
	endEvent
endState

state TimeEatST
	Event OnSliderOpenST()
		SetSliderDialogStartValue(mnd.timeEat)
		SetSliderDialogDefaultValue(8.0)
		SetSliderDialogRange(1.0, 48.0)
		SetSliderDialogInterval(1.0)
	endEvent

	event OnSliderAcceptST(float a_value)
		mnd.timeEat=a_value
		SetSliderOptionValueST(mnd.timeEat, "$MND_hours")
	endEvent

	event OnDefaultST()
		mnd.timeEat=8.0
		SetSliderOptionValueST(8.0, "$MND_hours")
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpMaxTimeForEat")
	endEvent
endState

state TimeDrinkST
	Event OnSliderOpenST()
		SetSliderDialogStartValue(mnd.timeDrink)
		SetSliderDialogDefaultValue(6.0)
		SetSliderDialogRange(1.0, 48.0)
		SetSliderDialogInterval(1.0)
	endEvent

	event OnSliderAcceptST(float a_value)
		mnd.timeDrink=a_value
		SetSliderOptionValueST(mnd.timeDrink, "$MND_hours")
	endEvent

	event OnDefaultST()
		mnd.timeDrink=6.0
		SetSliderOptionValueST(6.0, "$MND_hours")
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpMaxTimeForDrink")
	endEvent
endState

state TimeSleepST
	Event OnSliderOpenST()
		SetSliderDialogStartValue(mnd.timeSleep)
		SetSliderDialogDefaultValue(16.0)
		SetSliderDialogRange(1.0, 48.0)
		SetSliderDialogInterval(1.0)
	endEvent

	event OnSliderAcceptST(float a_value)
		mnd.timeSleep=a_value
		SetSliderOptionValueST(mnd.timeSleep, "$MND_hours")
	endEvent

	event OnDefaultST()
		mnd.timeSleep=16.0
		SetSliderOptionValueST(16.0, "$MND_hours")
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpMaxTimeForSleep")
	endEvent
endState

state TimeBathST
	Event OnSliderOpenST()
		SetSliderDialogStartValue(mnd.timeBath)
		SetSliderDialogDefaultValue(24.0)
		SetSliderDialogRange(1.0, 96.0)
		SetSliderDialogInterval(1.0)
	endEvent

	event OnSliderAcceptST(float a_value)
		mnd.timeBath=a_value
		SetSliderOptionValueST(mnd.timeBath, "$MND_hours")
	endEvent

	event OnDefaultST()
		mnd.timeBath=24.0
		SetSliderOptionValueST(24.0, "$MND_hours")
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpMaxTimeForBath")
	endEvent
endState

state TimePrayST
	Event OnSliderOpenST()
		SetSliderDialogStartValue(mnd.timePray)
		SetSliderDialogDefaultValue(96.0)
		SetSliderDialogRange(2.0, 168.0)
		SetSliderDialogInterval(4.0)
	endEvent

	event OnSliderAcceptST(float a_value)
		mnd.timePray=a_value
		SetSliderOptionValueST(mnd.timePray, "$MND_hours")
	endEvent

	event OnDefaultST()
		mnd.timePray=96.0
		SetSliderOptionValueST(96.0, "$MND_hours")
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpMaxTimeForPray")
	endEvent
endState

state TimePissST
	Event OnSliderOpenST()
		SetSliderDialogStartValue(mnd.timePiss)
		SetSliderDialogDefaultValue(12.0)
		SetSliderDialogRange(1.0, 48.0)
		SetSliderDialogInterval(1.0)
	endEvent

	event OnSliderAcceptST(float a_value)
		mnd.timePiss=a_value
		SetSliderOptionValueST(mnd.timePiss, "$MND_hours")
	endEvent

	event OnDefaultST()
		mnd.timePiss=12.0
		SetSliderOptionValueST(12.0, "$MND_hours")
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpMaxTimeForPiss")
	endEvent
endState

state TimePoopST
	Event OnSliderOpenST()
		SetSliderDialogStartValue(mnd.timePoop)
		SetSliderDialogDefaultValue(24.0)
		SetSliderDialogRange(1.0, 48.0)
		SetSliderDialogInterval(1.0)
	endEvent

	event OnSliderAcceptST(float a_value)
		mnd.timePoop=a_value
		SetSliderOptionValueST(mnd.timePoop, "$MND_hours")
	endEvent

	event OnDefaultST()
		mnd.timePoop=24.0
		SetSliderOptionValueST(24.0, "$MND_hours")
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpMaxtimeforPooping")
	endEvent
endState

state TimeSexST
	Event OnSliderOpenST()
		SetSliderDialogStartValue(mnd.timeSex)
		SetSliderDialogDefaultValue(48.0)
		SetSliderDialogRange(2.0, 168.0)
		SetSliderDialogInterval(2.0)
	endEvent

	event OnSliderAcceptST(float a_value)
		mnd.timeSex=a_value
		SetSliderOptionValueST(mnd.timeSex, "$MND_hours")
	endEvent

	event OnDefaultST()
		mnd.timeSex=48.0
		SetSliderOptionValueST(48.0, "$MND_hours")
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpMaxtimeforSex")
	endEvent
endState

state TimeTalkST
	Event OnSliderOpenST()
		SetSliderDialogStartValue(mnd.timeTalk)
		SetSliderDialogDefaultValue(48.0)
		SetSliderDialogRange(4.0, 200.0)
		SetSliderDialogInterval(4.0)
	endEvent

	event OnSliderAcceptST(float a_value)
		mnd.timeTalk=a_value
		SetSliderOptionValueST(mnd.timeTalk, "$MND_hours")
	endEvent

	event OnDefaultST()
		mnd.timeTalk=48.0
		SetSliderOptionValueST(48.0, "$MND_hours")
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpMaxtimeforTalk")
	endEvent
endState

state TimeDrunkST
	Event OnSliderOpenST()
		SetSliderDialogStartValue(mnd.timeDrunk)
		SetSliderDialogDefaultValue(4.0)
		SetSliderDialogRange(1.0, 24.0)
		SetSliderDialogInterval(1.0)
	endEvent

	event OnSliderAcceptST(float a_value)
		mnd.timeDrunk=a_value
		SetSliderOptionValueST(mnd.timeDrunk, "$MND_hours")
	endEvent

	event OnDefaultST()
		mnd.timeDrunk=4.0
		SetSliderOptionValueST(4.0, "$MND_hours")
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpHowLongDrunk")
	endEvent
endState

state TimeSkoomaST
	Event OnSliderOpenST()
		SetSliderDialogStartValue(mnd.timeSkooma)
		SetSliderDialogDefaultValue(18.0)
		SetSliderDialogRange(1.0, 48.0)
		SetSliderDialogInterval(1.0)
	endEvent

	event OnSliderAcceptST(float a_value)
		mnd.timeSkooma=a_value
		SetSliderOptionValueST(mnd.timeSkooma, "$MND_hours")
	endEvent

	event OnDefaultST()
		mnd.timeSkooma=18.0
		SetSliderOptionValueST(18.0, "$MND_hours")
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpMaxTimeForSkooma")
	endEvent
endState

state TimeAlcoholST
	Event OnSliderOpenST()
		SetSliderDialogStartValue(mnd.timeAlcohol)
		SetSliderDialogDefaultValue(24.0)
		SetSliderDialogRange(1.0, 72.0)
		SetSliderDialogInterval(1.0)
	endEvent

	event OnSliderAcceptST(float a_value)
		mnd.timeAlcohol=a_value
		SetSliderOptionValueST(mnd.timeAlcohol, "$MND_hours")
	endEvent

	event OnDefaultST()
		mnd.timeSkooma=24.0
		SetSliderOptionValueST(24.0, "$MND_hours")
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpMaxTimeForAcohol")
	endEvent
endState

state TimeWeedST
	Event OnSliderOpenST()
		SetSliderDialogStartValue(mnd.timeWeed)
		SetSliderDialogDefaultValue(48.0)
		SetSliderDialogRange(1.0, 72.0)
		SetSliderDialogInterval(1.0)
	endEvent

	event OnSliderAcceptST(float a_value)
		mnd.timeWeed=a_value
		SetSliderOptionValueST(mnd.timeWeed, "$MND_hours")
	endEvent

	event OnDefaultST()
		mnd.timeWeed=48.0
		SetSliderOptionValueST(48.0, "$MND_hours")
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpMaxTimeForWeed")
	endEvent
endState

state EnableWidgetsTG
	event OnSelectST()
		mnd.enableWidgets = !mnd.enableWidgets
		SetToggleOptionValueST(mnd.enableWidgets)
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpEnableWidgets")
	endEvent
endState

state HowToPissMN
	event OnMenuOpenST()
		SetMenuDialogStartIndex(mnd.howToPiss)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(howToPissPoop)
	endEvent

	event OnMenuAcceptST(int val)
		if val>=0 && val<=howToPissPoop.length
			SetMenuOptionValueST(howToPissPoop[val])
			mnd.howToPiss = val
			ForcePageReset()
		endIf
	endEvent
	
	event OnDefaultST()
		SetMenuOptionValueST(howToPissPoop[0])
		mnd.howToPiss = 0
		ForcePageReset()
	endEvent
		
	event OnHighlightST()
		SetInfoText("$MND_HelpHowToPiss")
	endEvent
endState

state HowToPoopMN
	event OnMenuOpenST()
		SetMenuDialogStartIndex(mnd.howToPoop)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(howToPissPoop)
	endEvent

	event OnMenuAcceptST(int val)
		if val>=0 && val<=howToPissPoop.length
			SetMenuOptionValueST(howToPissPoop[val])
			mnd.howToPoop = val
			ForcePageReset()
		endIf
	endEvent
	
	event OnDefaultST()
		SetMenuOptionValueST(howToPissPoop[0])
		mnd.howToPoop = 0
		ForcePageReset()
	endEvent
		
	event OnHighlightST()
		SetInfoText("$MND_HelpHowToPoop")
	endEvent
endState

state HowToPissPoopMN
	event OnMenuOpenST()
		SetMenuDialogStartIndex(mnd.howToPissPoop)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(howToPissPoop)
	endEvent

	event OnMenuAcceptST(int val)
		if val>=0 && val<=howToPissPoop.length
			SetMenuOptionValueST(howToPissPoop[val])
			mnd.howToPissPoop = val
			ForcePageReset()
		endIf
	endEvent
	
	event OnDefaultST()
		SetMenuOptionValueST(howToPissPoop[0])
		mnd.howToPissPoop = 0
		ForcePageReset()
	endEvent
		
	event OnHighlightST()
		SetInfoText("$MND_HelpHowToPissPoop")
	endEvent
endState

state HowToBathInRiversMN
	event OnMenuOpenST()
		SetMenuDialogStartIndex(mnd.howToBathInRivers)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(howToPissPoop)
	endEvent

	event OnMenuAcceptST(int val)
		if val>=0 && val<=howToPissPoop.length
			SetMenuOptionValueST(howToPissPoop[val])
			mnd.howToBathInRivers = val
			ForcePageReset()
		endIf
	endEvent
	
	event OnDefaultST()
		SetMenuOptionValueST(howToPissPoop[0])
		mnd.howToBathInRivers = 0
		ForcePageReset()
	endEvent
		
	event OnHighlightST()
		SetInfoText("$MND_HowToBathInRivers")
	endEvent
endState

state WidgetsOpacityMN
	event OnMenuOpenST()
		SetMenuDialogStartIndex(mnd.widgetsOpacities)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(wOpacities)
	endEvent

	event OnMenuAcceptST(int val)
		if val>=0 && val<=wOpacities.length
			SetMenuOptionValueST(wOpacities[val])
			mnd.widgetsOpacities = val
		endIf
	endEvent
	
	event OnDefaultST()
		SetMenuOptionValueST(wOpacities[0])
		mnd.widgetsOpacities = 0
	endEvent
		
	event OnHighlightST()
		SetInfoText("$MND_HelpWidgOpacity")
	endEvent
endState

state WidgetsPositionMN
	event OnMenuOpenST()
		SetMenuDialogStartIndex(mnd.widgetsPositions)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(wPositions)
	endEvent

	event OnMenuAcceptST(int val)
		if val>=0 && val<=wPositions.length
			SetMenuOptionValueST(wPositions[val])
			mnd.widgetsPositions = val
			ForcePageReset()
		endIf
	endEvent
	
	event OnDefaultST()
		SetMenuOptionValueST(wPositions[0])
		mnd.widgetsPositions = 0
		ForcePageReset()
	endEvent
		
	event OnHighlightST()
		SetInfoText("$MND_HelpWidgPosition")
	endEvent
endState

state WidgetsArrangementsMN
	event OnMenuOpenST()
		SetMenuDialogStartIndex(mnd.widgetsArrangements)
		SetMenuDialogDefaultIndex(1)
		if mnd.widgetsPositions==0 || mnd.widgetsPositions==1
			SetMenuDialogOptions(wArrangementsTB)
		else
			SetMenuDialogOptions(wArrangementsLR)
		endIf
	endEvent

	event OnMenuAcceptST(int val)
		if val>=0 && val<=wArrangementsTB.length
			if mnd.widgetsPositions==0 || mnd.widgetsPositions==1
				SetMenuOptionValueST(wArrangementsTB[val])
			else
				SetMenuOptionValueST(wArrangementsLR[val])
			endIf
			mnd.widgetsArrangements = val
		endIf
	endEvent
	
	event OnDefaultST()
		if mnd.widgetsPositions==0 || mnd.widgetsPositions==1
			SetMenuOptionValueST(wArrangementsTB[1])
		else
			SetMenuOptionValueST(wArrangementsLR[1])
		endIf
		mnd.widgetsArrangements = 1
	endEvent
		
	event OnHighlightST()
		SetInfoText("$MND_HelpWidgArrangement")
	endEvent
endState

state WidgetsSizeMN
	event OnMenuOpenST()
		SetMenuDialogStartIndex(mnd.widgetsSize)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(wSizes)
	endEvent

	event OnMenuAcceptST(int val)
		if val>=0 && val<=wSizes.length
			SetMenuOptionValueST(wSizes[val])
			mnd.widgetsSize = val
		endIf
	endEvent
	
	event OnDefaultST()
		SetMenuOptionValueST(wSizes[0])
		mnd.widgetsSize = 0
	endEvent
		
	event OnHighlightST()
		SetInfoText("$MND_HelpWidgSize")
	endEvent
endState

state WidgetsGroupingMN
	event OnMenuOpenST()
		SetMenuDialogStartIndex(mnd.widgetsGrouped)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(wGrouping)
	endEvent

	event OnMenuAcceptST(int val)
		if val>=0 && val<=wGrouping.length
			SetMenuOptionValueST(wGrouping[val])
			mnd.widgetsGrouped = val
		endIf
	endEvent
	
	event OnDefaultST()
		SetMenuOptionValueST(wGrouping[1])
		mnd.widgetsGrouped = 0
	endEvent
		
	event OnHighlightST()
		SetInfoText("$MND_HelpWidgetsGrouping")
	endEvent
endState

state WidgetsSpaceSL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(mnd.widgetsSpace)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-20.0, 30.0)
		SetSliderDialogInterval(1.0)
	endEvent

	event OnSliderAcceptST(float a_value)
		mnd.widgetsSpace=a_value as int
		SetSliderOptionValueST(mnd.widgetsSpace, "{0}")
	endEvent

	event OnDefaultST()
		mnd.widgetsSpace=0
		SetSliderOptionValueST(0.0, "{0}")
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpWidgSpace")
	endEvent
endState

state WidgetsHMarginSL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(mnd.widgetsMarginH)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-20.0, 100.0)
		SetSliderDialogInterval(1.0)
	endEvent

	event OnSliderAcceptST(float a_value)
		mnd.widgetsMarginH=a_value as int
		SetSliderOptionValueST(mnd.widgetsMarginH, "{0}")
	endEvent

	event OnDefaultST()
		mnd.widgetsMarginH=0
		SetSliderOptionValueST(0.0, "{0}")
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpWidgHMarg")
	endEvent
endState

state WidgetsVMarginSL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(mnd.widgetsMarginV)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-20.0, 100.0)
		SetSliderDialogInterval(1.0)
	endEvent

	event OnSliderAcceptST(float a_value)
		mnd.widgetsMarginV=a_value as int
		SetSliderOptionValueST(mnd.widgetsMarginV, "{0}")
	endEvent

	event OnDefaultST()
		mnd.widgetsMarginV=0
		SetSliderOptionValueST(0.0, "{0}")
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpWidgVMarg")
	endEvent
endState

state WidgetsKeyDef
	event OnKeyMapChangeST(int newKeyCode, string conflictControl, string conflictName)
		if newKeyCode==1
			; Esc, let's use it to cancel the values
			mnd.oldWidgetsKey = mnd.widgetsKey
			mnd.widgetsKey = 0
			ForcePageReset()
		elseIf conflictControl || conflictName
			if conflictName==""
				conflictName="Vanilla Game"
			endIf
			if newKeyCode==0
				mnd.oldWidgetsKey = mnd.widgetsKey
				mnd.widgetsKey = newKeyCode
				SetKeyMapOptionValueST(newKeyCode)
			elseIf ShowMessage("$MND_KeymapConflict{" + conflictControl + "}{" + conflictName + "}", true, "$MND_Yes", "$MND_No")
				mnd.widgetsKey = newKeyCode
				SetKeyMapOptionValueST(newKeyCode)
			endIf
		else
			mnd.oldWidgetsKey = mnd.widgetsKey
			mnd.widgetsKey = newKeyCode
			SetKeyMapOptionValueST(newKeyCode)
		endIf
	endEvent
	
	event OnDefaultST()
		mnd.widgetsKey = 0
		SetKeyMapOptionValueST(0)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MND_HelpWidgetsKey")
	endEvent
endState

state KeyToPiss
	event OnKeyMapChangeST(int newKeyCode, string conflictControl, string conflictName)
		if newKeyCode==1
			; Esc, let's use it to cancel the values
			mnd.keyToPiss = 0
			ForcePageReset()
		elseIf conflictControl || conflictName
			if conflictName==""
				conflictName="Vanilla Game"
			endIf
			if ShowMessage("$MND_KeymapConflict{" + conflictControl + "}{" + conflictName + "}", true, "$MND_Yes", "$MND_No")
				mnd.keyToPiss = newKeyCode
				SetKeyMapOptionValueST(newKeyCode)
			endIf
		else
			mnd.keyToPiss = newKeyCode
			SetKeyMapOptionValueST(newKeyCode)
		endIf
	endEvent
	
	event OnDefaultST()
		mnd.keyToPiss = 0
		SetKeyMapOptionValueST(0)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MND_HelpKeyToPiss")
	endEvent
endState

state KeyToPoop
	event OnKeyMapChangeST(int newKeyCode, string conflictControl, string conflictName)
		if newKeyCode==1
			; Esc, let's use it to cancel the values
			mnd.keyToPoop = 0
			ForcePageReset()
		elseIf conflictControl || conflictName
			if conflictName==""
				conflictName="Vanilla Game"
			endIf
			if ShowMessage("$MND_KeymapConflict{" + conflictControl + "}{" + conflictName + "}", true, "$MND_Yes", "$MND_No")
				mnd.keyToPoop = newKeyCode
				SetKeyMapOptionValueST(newKeyCode)
			endIf
		else
			mnd.keyToPoop = newKeyCode
			SetKeyMapOptionValueST(newKeyCode)
		endIf
	endEvent
	
	event OnDefaultST()
		mnd.keyToPoop = 0
		SetKeyMapOptionValueST(0)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MND_HelpKeyToPoop")
	endEvent
endState

state KeyToPissPoop
	event OnKeyMapChangeST(int newKeyCode, string conflictControl, string conflictName)
		if newKeyCode==1
			; Esc, let's use it to cancel the values
			mnd.keyToPissPoop = 0
			ForcePageReset()
		elseIf conflictControl || conflictName
			if conflictName==""
				conflictName="Vanilla Game"
			endIf
			if ShowMessage("$MND_KeymapConflict{" + conflictControl + "}{" + conflictName + "}", true, "$MND_Yes", "$MND_No")
				mnd.keyToPissPoop = newKeyCode
				SetKeyMapOptionValueST(newKeyCode)
			endIf
		else
			mnd.keyToPissPoop = newKeyCode
			SetKeyMapOptionValueST(newKeyCode)
		endIf
	endEvent
	
	event OnDefaultST()
		mnd.keyToPissPoop = 0
		SetKeyMapOptionValueST(0)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MND_HelpKeyToPissPoop")
	endEvent
endState

state keyToBathInRiversKM
	event OnKeyMapChangeST(int newKeyCode, string conflictControl, string conflictName)
		if newKeyCode==1
			; Esc, let's use it to cancel the values
			mnd.keyToBathInRivers = 0
			ForcePageReset()
		elseIf conflictControl || conflictName
			if conflictName==""
				conflictName="Vanilla Game"
			endIf
			if ShowMessage("$MND_KeymapConflict{" + conflictControl + "}{" + conflictName + "}", true, "$MND_Yes", "$MND_No")
				mnd.keyToBathInRivers = newKeyCode
				SetKeyMapOptionValueST(newKeyCode)
			endIf
		else
			mnd.keyToBathInRivers = newKeyCode
			SetKeyMapOptionValueST(newKeyCode)
		endIf
	endEvent
	
	event OnDefaultST()
		mnd.keyToBathInRivers = 0
		SetKeyMapOptionValueST(0)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MND_HelpKeyToBathInRivers")
	endEvent
endState

state maxEatDamageST
	Event OnSliderOpenST()
		SetSliderDialogStartValue(mnd.maxEatDamage)
		SetSliderDialogDefaultValue(50.0)
		SetSliderDialogRange(1.0, 100.0)
		SetSliderDialogInterval(1.0)
	endEvent

	event OnSliderAcceptST(float a_value)
		mnd.maxEatDamage=a_value
		SetSliderOptionValueST(mnd.maxEatDamage, "$MND_Percent")
	endEvent

	event OnDefaultST()
		mnd.maxEatDamage=50.0
		SetSliderOptionValueST(50.0, "$MND_Percent")
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpMaxEatDamage")
	endEvent
endState

state maxDrinkDamageST
	Event OnSliderOpenST()
		SetSliderDialogStartValue(mnd.maxDrinkDamage)
		SetSliderDialogDefaultValue(50.0)
		SetSliderDialogRange(1.0, 100.0)
		SetSliderDialogInterval(1.0)
	endEvent

	event OnSliderAcceptST(float a_value)
		mnd.maxDrinkDamage=a_value
		SetSliderOptionValueST(mnd.maxDrinkDamage, "$MND_Percent")
	endEvent

	event OnDefaultST()
		mnd.maxDrinkDamage=50.0
		SetSliderOptionValueST(50.0, "$MND_Percent")
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpMaxDrinkDamage")
	endEvent
endState

state maxSleepDamageST
	Event OnSliderOpenST()
		SetSliderDialogStartValue(mnd.maxSleepDamage)
		SetSliderDialogDefaultValue(50.0)
		SetSliderDialogRange(1.0, 100.0)
		SetSliderDialogInterval(1.0)
	endEvent

	event OnSliderAcceptST(float a_value)
		mnd.maxSleepDamage=a_value
		SetSliderOptionValueST(mnd.maxSleepDamage, "$MND_Percent")
	endEvent

	event OnDefaultST()
		mnd.maxSleepDamage=50.0
		SetSliderOptionValueST(50.0, "$MND_Percent")
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpMaxSleepDamage")
	endEvent
endState

state maxBathST
	Event OnSliderOpenST()
		SetSliderDialogStartValue(mnd.maxBathDamage)
		SetSliderDialogDefaultValue(50.0)
		SetSliderDialogRange(1.0, 100.0)
		SetSliderDialogInterval(1.0)
	endEvent

	event OnSliderAcceptST(float a_value)
		mnd.maxBathDamage=a_value
		SetSliderOptionValueST(mnd.maxBathDamage, "$MND_Percent")
	endEvent

	event OnDefaultST()
		mnd.maxBathDamage=50.0
		SetSliderOptionValueST(50.0, "$MND_Percent")
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpMaxBathDamage")
	endEvent
endState

state bathDurationST
	Event OnSliderOpenST()
		SetSliderDialogStartValue(mnd.bathDuration)
		SetSliderDialogDefaultValue(30.0)
		SetSliderDialogRange(5.0, 180.0)
		SetSliderDialogInterval(5.0)
	endEvent

	event OnSliderAcceptST(float a_value)
		mnd.bathDuration=a_value
		SetSliderOptionValueST(mnd.bathDuration, "$MND_seconds")
	endEvent

	event OnDefaultST()
		mnd.bathDuration=30.0
		SetSliderOptionValueST(30.0, "$MND_seconds")
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpBathDuration")
	endEvent
endState

state maxPrayST
	Event OnSliderOpenST()
		SetSliderDialogStartValue(mnd.maxPrayDamage)
		SetSliderDialogDefaultValue(50.0)
		SetSliderDialogRange(1.0, 100.0)
		SetSliderDialogInterval(1.0)
	endEvent

	event OnSliderAcceptST(float a_value)
		mnd.maxPrayDamage=a_value
		SetSliderOptionValueST(mnd.maxPrayDamage, "$MND_Percent")
	endEvent

	event OnDefaultST()
		mnd.maxPrayDamage=50.0
		SetSliderOptionValueST(50.0, "$MND_Percent")
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpMaxPrayDamage")
	endEvent
endState

state maxPissDamageST
	Event OnSliderOpenST()
		SetSliderDialogStartValue(mnd.maxPissDamage)
		SetSliderDialogDefaultValue(50.0)
		SetSliderDialogRange(1.0, 100.0)
		SetSliderDialogInterval(1.0)
	endEvent

	event OnSliderAcceptST(float a_value)
		mnd.maxPissDamage=a_value
		SetSliderOptionValueST(mnd.maxPissDamage, "$MND_Percent")
	endEvent

	event OnDefaultST()
		mnd.maxPissDamage=50.0
		SetSliderOptionValueST(50.0, "$MND_Percent")
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpMaxPissDamage")
	endEvent
endState

state maxPoopDamageST
	Event OnSliderOpenST()
		SetSliderDialogStartValue(mnd.maxPoopDamage)
		SetSliderDialogDefaultValue(50.0)
		SetSliderDialogRange(1.0, 100.0)
		SetSliderDialogInterval(1.0)
	endEvent

	event OnSliderAcceptST(float a_value)
		mnd.maxPoopDamage=a_value
		SetSliderOptionValueST(mnd.maxPoopDamage, "$MND_Percent")
	endEvent

	event OnDefaultST()
		mnd.maxPoopDamage=50.0
		SetSliderOptionValueST(50.0, "$MND_Percent")
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpMaxPoopDamage")
	endEvent
endState

state maxSexDamageST
	Event OnSliderOpenST()
		SetSliderDialogStartValue(mnd.maxSexDamage)
		SetSliderDialogDefaultValue(50.0)
		SetSliderDialogRange(1.0, 100.0)
		SetSliderDialogInterval(1.0)
	endEvent

	event OnSliderAcceptST(float a_value)
		mnd.maxSexDamage=a_value
		SetSliderOptionValueST(mnd.maxSexDamage, "$MND_Percent")
	endEvent

	event OnDefaultST()
		mnd.maxSexDamage=50.0
		SetSliderOptionValueST(50.0, "$MND_Percent")
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpMaxSexDamage")
	endEvent
endState

state maxTalkDamageST
	Event OnSliderOpenST()
		SetSliderDialogStartValue(mnd.maxTalkDamage)
		SetSliderDialogDefaultValue(50.0)
		SetSliderDialogRange(1.0, 100.0)
		SetSliderDialogInterval(1.0)
	endEvent

	event OnSliderAcceptST(float a_value)
		mnd.maxTalkDamage=a_value
		SetSliderOptionValueST(mnd.maxTalkDamage, "$MND_Percent")
	endEvent

	event OnDefaultST()
		mnd.maxTalkDamage=50.0
		SetSliderOptionValueST(50.0, "$MND_Percent")
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpMaxTalkDamage")
	endEvent
endState

state maxSkoomaDamageST
	Event OnSliderOpenST()
		SetSliderDialogStartValue(mnd.maxSkoomaDamage)
		SetSliderDialogDefaultValue(50.0)
		SetSliderDialogRange(1.0, 100.0)
		SetSliderDialogInterval(1.0)
	endEvent

	event OnSliderAcceptST(float a_value)
		mnd.maxSkoomaDamage=a_value
		SetSliderOptionValueST(mnd.maxSkoomaDamage, "$MND_Percent")
	endEvent

	event OnDefaultST()
		mnd.maxSkoomaDamage=50.0
		SetSliderOptionValueST(50.0, "$MND_Percent")
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_helpMaxSkoomaDamage")
	endEvent
endState

state maxAlcoholDamageST
	Event OnSliderOpenST()
		SetSliderDialogStartValue(mnd.maxAlcoholDamage)
		SetSliderDialogDefaultValue(50.0)
		SetSliderDialogRange(1.0, 100.0)
		SetSliderDialogInterval(1.0)
	endEvent

	event OnSliderAcceptST(float a_value)
		mnd.maxAlcoholDamage=a_value
		SetSliderOptionValueST(mnd.maxAlcoholDamage, "$MND_Percent")
	endEvent

	event OnDefaultST()
		mnd.maxAlcoholDamage=50.0
		SetSliderOptionValueST(50.0, "$MND_Percent")
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_HelpMaxAlcoholDamage")
	endEvent
endState

state maxWeedDamageST
	Event OnSliderOpenST()
		SetSliderDialogStartValue(mnd.maxWeedDamage)
		SetSliderDialogDefaultValue(50.0)
		SetSliderDialogRange(1.0, 100.0)
		SetSliderDialogInterval(1.0)
	endEvent

	event OnSliderAcceptST(float a_value)
		mnd.maxWeedDamage=a_value
		SetSliderOptionValueST(mnd.maxWeedDamage, "$MND_Percent")
	endEvent

	event OnDefaultST()
		mnd.maxWeedDamage=50.0
		SetSliderOptionValueST(50.0, "$MND_Percent")
	endEvent

	event OnHighlightST()
		SetInfoText("$MND_helpMaxWeedDamage")
	endEvent
endState

state KeyToMasturbate
	event OnKeyMapChangeST(int newKeyCode, string conflictControl, string conflictName)
		if newKeyCode==1
			; Esc, let's use it to cancel the values
			mnd.keyToMasturbate = 0
			ForcePageReset()
		elseIf conflictControl || conflictName
			if conflictName==""
				conflictName="Vanilla Game"
			endIf
			if ShowMessage("$MND_KeymapConflict{" + conflictControl + "}{" + conflictName + "}", true, "$MND_Yes", "$MND_No")
				mnd.keyToMasturbate = newKeyCode
				SetKeyMapOptionValueST(newKeyCode)
			endIf
		else
			mnd.keyToMasturbate = newKeyCode
			SetKeyMapOptionValueST(newKeyCode)
		endIf
	endEvent
	
	event OnDefaultST()
		mnd.keyToMasturbate = 0
		SetKeyMapOptionValueST(0)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MND_HelpKeyToMasturbate")
	endEvent
endState

state WidColEatS
	event OnColorOpenST()
		SetColorDialogStartColor(mnd.widColSEat)
		SetColorDialogDefaultColor(0xEF6F12)
	endEvent
	event OnColorAcceptST(int color)
		mnd.widColSEat=color
		SetColorOptionValueST(color)
	endEvent
	event OnDefaultST()
		mnd.widColSEat=0xEF6F12
		SetColorOptionValueST(mnd.widColSEat)
	endEvent
	event OnHighlightST()
		SetInfoText("$MND_HelpWidColEatS")
	endEvent
endState

state WidColEatE
	event OnColorOpenST()
		SetColorDialogStartColor(mnd.widColEEat)
		SetColorDialogDefaultColor(0xFF2211)
	endEvent
	event OnColorAcceptST(int color)
		mnd.widColEEat=color
		SetColorOptionValueST(color)
	endEvent
	event OnDefaultST()
		mnd.widColEEat=0xFF2211
		SetColorOptionValueST(mnd.widColEEat)
	endEvent
	event OnHighlightST()
		SetInfoText("$MND_HelpWidColEatE")
	endEvent
endState

state WidColDrinkS
	event OnColorOpenST()
		SetColorDialogStartColor(mnd.widColSDrink)
		SetColorDialogDefaultColor(0x82FF82)
	endEvent
	event OnColorAcceptST(int color)
		mnd.widColSDrink=color
		SetColorOptionValueST(color)
	endEvent
	event OnDefaultST()
		mnd.widColSDrink=0x82FF82
		SetColorOptionValueST(mnd.widColSDrink)
	endEvent
	event OnHighlightST()
		SetInfoText("$MND_HelpWidColDrinkS")
	endEvent
endState

state WidColDrinkE
	event OnColorOpenST()
		SetColorDialogStartColor(mnd.widColEDrink)
		SetColorDialogDefaultColor(0x11AF22)
	endEvent
	event OnColorAcceptST(int color)
		mnd.widColEDrink=color
		SetColorOptionValueST(color)
	endEvent
	event OnDefaultST()
		mnd.widColEDrink=0x11AF22
		SetColorOptionValueST(mnd.widColEDrink)
	endEvent
	event OnHighlightST()
		SetInfoText("$MND_HelpWidColDrinkE")
	endEvent
endState

state WidColSleepS
	event OnColorOpenST()
		SetColorDialogStartColor(mnd.widColSSleep)
		SetColorDialogDefaultColor(0x6666FF)
	endEvent
	event OnColorAcceptST(int color)
		mnd.widColSSleep=color
		SetColorOptionValueST(color)
	endEvent
	event OnDefaultST()
		mnd.widColSSleep=0x6666FF
		SetColorOptionValueST(mnd.widColSSleep)
	endEvent
	event OnHighlightST()
		SetInfoText("$MND_HelpWidColSleepS")
	endEvent
endState

state WidColSleepE
	event OnColorOpenST()
		SetColorDialogStartColor(mnd.widColESleep)
		SetColorDialogDefaultColor(0x1122A1)
	endEvent
	event OnColorAcceptST(int color)
		mnd.widColESleep=color
		SetColorOptionValueST(color)
	endEvent
	event OnDefaultST()
		mnd.widColESleep=0x1122A1
		SetColorOptionValueST(mnd.widColESleep)
	endEvent
	event OnHighlightST()
		SetInfoText("$MND_HelpWidColSleepE")
	endEvent
endState

state WidColTalkS
	event OnColorOpenST()
		SetColorDialogStartColor(mnd.widColSTalk)
		SetColorDialogDefaultColor(0xb7b4b4)
	endEvent
	event OnColorAcceptST(int color)
		mnd.widColSTalk=color
		SetColorOptionValueST(color)
	endEvent
	event OnDefaultST()
		mnd.widColSTalk=0xb7b4b4
		SetColorOptionValueST(mnd.widColSTalk)
	endEvent
	event OnHighlightST()
		SetInfoText("$MND_HelpWidColTalkS")
	endEvent
endState

state WidColTalkE
	event OnColorOpenST()
		SetColorDialogStartColor(mnd.widColETalk)
		SetColorDialogDefaultColor(0x999997)
	endEvent
	event OnColorAcceptST(int color)
		mnd.widColETalk=color
		SetColorOptionValueST(color)
	endEvent
	event OnDefaultST()
		mnd.widColETalk=0x999997
		SetColorOptionValueST(mnd.widColETalk)
	endEvent
	event OnHighlightST()
		SetInfoText("$MND_HelpWidColTalkE")
	endEvent
endState

state WidColBathS
	event OnColorOpenST()
		SetColorDialogStartColor(mnd.widColSBath)
		SetColorDialogDefaultColor(0xa7e4f4)
	endEvent
	event OnColorAcceptST(int color)
		mnd.widColSBath=color
		SetColorOptionValueST(color)
	endEvent
	event OnDefaultST()
		mnd.widColSBath=0xa7e4f4
		SetColorOptionValueST(mnd.widColSBath)
	endEvent
	event OnHighlightST()
		SetInfoText("$MND_HelpWidColBathS")
	endEvent
endState

state WidColBathE
	event OnColorOpenST()
		SetColorDialogStartColor(mnd.widColEBath)
		SetColorDialogDefaultColor(0xa9d9e7)
	endEvent
	event OnColorAcceptST(int color)
		mnd.widColEBath=color
		SetColorOptionValueST(color)
	endEvent
	event OnDefaultST()
		mnd.widColEBath=0xa9d9e7
		SetColorOptionValueST(mnd.widColEBath)
	endEvent
	event OnHighlightST()
		SetInfoText("$MND_HelpWidColBathE")
	endEvent
endState

state WidColPrayS
	event OnColorOpenST()
		SetColorDialogStartColor(mnd.widColSPray)
		SetColorDialogDefaultColor(0xf884b4)
	endEvent
	event OnColorAcceptST(int color)
		mnd.widColSPray=color
		SetColorOptionValueST(color)
	endEvent
	event OnDefaultST()
		mnd.widColSPray=0xf884b4
		SetColorOptionValueST(mnd.widColSPray)
	endEvent
	event OnHighlightST()
		SetInfoText("$MND_HelpWidColPrayS")
	endEvent
endState

state WidColPrayE
	event OnColorOpenST()
		SetColorDialogStartColor(mnd.widColEPray)
		SetColorDialogDefaultColor(0xe98997)
	endEvent
	event OnColorAcceptST(int color)
		mnd.widColEPray=color
		SetColorOptionValueST(color)
	endEvent
	event OnDefaultST()
		mnd.widColEPray=0xe98997
		SetColorOptionValueST(mnd.widColEPray)
	endEvent
	event OnHighlightST()
		SetInfoText("$MND_HelpWidColPrayE")
	endEvent
endState

state WidColPissS
	event OnColorOpenST()
		SetColorDialogStartColor(mnd.widColSPiss)
		SetColorDialogDefaultColor(0xFFDA22)
	endEvent
	event OnColorAcceptST(int color)
		mnd.widColSPiss=color
		SetColorOptionValueST(color)
	endEvent
	event OnDefaultST()
		mnd.widColSPiss=0xFFDA22
		SetColorOptionValueST(mnd.widColSPiss)
	endEvent
	event OnHighlightST()
		SetInfoText("$MND_HelpWidColPissS")
	endEvent
endState

state WidColPissE
	event OnColorOpenST()
		SetColorDialogStartColor(mnd.widColEPiss)
		SetColorDialogDefaultColor(0xBABA11)
	endEvent
	event OnColorAcceptST(int color)
		mnd.widColEPiss=color
		SetColorOptionValueST(color)
	endEvent
	event OnDefaultST()
		mnd.widColEPiss=0xBABA11
		SetColorOptionValueST(mnd.widColEPiss)
	endEvent
	event OnHighlightST()
		SetInfoText("$MND_HelpWidColPissE")
	endEvent
endState

state WidColPoopS
	event OnColorOpenST()
		SetColorDialogStartColor(mnd.widColSPoop)
		SetColorDialogDefaultColor(0x834a07)
	endEvent
	event OnColorAcceptST(int color)
		mnd.widColSPoop=color
		SetColorOptionValueST(color)
	endEvent
	event OnDefaultST()
		mnd.widColSPoop=0x834a07
		SetColorOptionValueST(mnd.widColSPoop)
	endEvent
	event OnHighlightST()
		SetInfoText("$MND_HelpWidColPoopS")
	endEvent
endState

state WidColPoopE
	event OnColorOpenST()
		SetColorDialogStartColor(mnd.widColEPoop)
		SetColorDialogDefaultColor(0xd4801d)
	endEvent
	event OnColorAcceptST(int color)
		mnd.widColEPoop=color
		SetColorOptionValueST(color)
	endEvent
	event OnDefaultST()
		mnd.widColEPoop=0xd4801d
		SetColorOptionValueST(mnd.widColEPoop)
	endEvent
	event OnHighlightST()
		SetInfoText("$MND_HelpWidColPoopE")
	endEvent
endState

state WidColSexS
	event OnColorOpenST()
		SetColorDialogStartColor(mnd.widColSSex)
		SetColorDialogDefaultColor(0xe0efef)
	endEvent
	event OnColorAcceptST(int color)
		mnd.widColSSex=color
		SetColorOptionValueST(color)
	endEvent
	event OnDefaultST()
		mnd.widColSSex=0xe0efef
		SetColorOptionValueST(mnd.widColSSex)
	endEvent
	event OnHighlightST()
		SetInfoText("$MND_HelpWidColSexS")
	endEvent
endState

state WidColSexE
	event OnColorOpenST()
		SetColorDialogStartColor(mnd.widColESex)
		SetColorDialogDefaultColor(0xf0f4f5)
	endEvent
	event OnColorAcceptST(int color)
		mnd.widColESex=color
		SetColorOptionValueST(color)
	endEvent
	event OnDefaultST()
		mnd.widColESex=0xf0f4f5
		SetColorOptionValueST(mnd.widColESex)
	endEvent
	event OnHighlightST()
		SetInfoText("$MND_HelpWidColSexE")
	endEvent
endState

state WidColDrunkS
	event OnColorOpenST()
		SetColorDialogStartColor(mnd.widColSDrunk)
		SetColorDialogDefaultColor(0x91acd4)
	endEvent
	event OnColorAcceptST(int color)
		mnd.widColSDrunk=color
		SetColorOptionValueST(color)
	endEvent
	event OnDefaultST()
		mnd.widColSDrunk=0x91acd4
		SetColorOptionValueST(mnd.widColSDrunk)
	endEvent
	event OnHighlightST()
		SetInfoText("$MND_HelpWidColDrunkS")
	endEvent
endState

state WidColDrunkE
	event OnColorOpenST()
		SetColorDialogStartColor(mnd.widColEDrunk)
		SetColorDialogDefaultColor(0x9a1dd4)
	endEvent
	event OnColorAcceptST(int color)
		mnd.widColEDrunk=color
		SetColorOptionValueST(color)
	endEvent
	event OnDefaultST()
		mnd.widColEDrunk=0x9a1dd4
		SetColorOptionValueST(mnd.widColEDrunk)
	endEvent
	event OnHighlightST()
		SetInfoText("$MND_HelpWidColDrunkE")
	endEvent
endState

state WidColSkoomaS
	event OnColorOpenST()
		SetColorDialogStartColor(mnd.widColSSkooma)
		SetColorDialogDefaultColor(0x68c6d5)
	endEvent
	event OnColorAcceptST(int color)
		mnd.widColSSkooma=color
		SetColorOptionValueST(color)
	endEvent
	event OnDefaultST()
		mnd.widColSSkooma=0x68c6d5
		SetColorOptionValueST(mnd.widColSSkooma)
	endEvent
	event OnHighlightST()
		SetInfoText("$MND_HelpWidColSkoomaS")
	endEvent
endState

state WidColSkoomaE
	event OnColorOpenST()
		SetColorDialogStartColor(mnd.widColESkooma)
		SetColorDialogDefaultColor(0x22d0eb)
	endEvent
	event OnColorAcceptST(int color)
		mnd.widColESkooma=color
		SetColorOptionValueST(color)
	endEvent
	event OnDefaultST()
		mnd.widColESkooma=0x22d0eb
		SetColorOptionValueST(mnd.widColESkooma)
	endEvent
	event OnHighlightST()
		SetInfoText("$MND_HelpWidColSkoomaE")
	endEvent
endState

state WidColAlcoholS
	event OnColorOpenST()
		SetColorDialogStartColor(mnd.widColSAlcohol)
		SetColorDialogDefaultColor(0xdb90f4)
	endEvent
	event OnColorAcceptST(int color)
		mnd.widColSAlcohol=color
		SetColorOptionValueST(color)
	endEvent
	event OnDefaultST()
		mnd.widColSAlcohol=0xdb90f4
		SetColorOptionValueST(mnd.widColSAlcohol)
	endEvent
	event OnHighlightST()
		SetInfoText("$MND_HelpWidColAlcoholS")
	endEvent
endState

state WidColAlcoholE
	event OnColorOpenST()
		SetColorDialogStartColor(mnd.widColEAlcohol)
		SetColorDialogDefaultColor(0xf434c0)
	endEvent
	event OnColorAcceptST(int color)
		mnd.widColEAlcohol=color
		SetColorOptionValueST(color)
	endEvent
	event OnDefaultST()
		mnd.widColEAlcohol=0xf434c0
		SetColorOptionValueST(mnd.widColEAlcohol)
	endEvent
	event OnHighlightST()
		SetInfoText("$MND_HelpWidColAlcoholE")
	endEvent
endState

state WidColWeedS
	event OnColorOpenST()
		SetColorDialogStartColor(mnd.widColSWeed)
		SetColorDialogDefaultColor(0x9ae1ac)
	endEvent
	event OnColorAcceptST(int color)
		mnd.widColSWeed=color
		SetColorOptionValueST(color)
	endEvent
	event OnDefaultST()
		mnd.widColSWeed=0x9ae1ac
		SetColorOptionValueST(mnd.widColSWeed)
	endEvent
	event OnHighlightST()
		SetInfoText("$MND_HelpWidColWeedS")
	endEvent
endState

state WidColWeedE
	event OnColorOpenST()
		SetColorDialogStartColor(mnd.widColEWeed)
		SetColorDialogDefaultColor(0x2d8b2c)
	endEvent
	event OnColorAcceptST(int color)
		mnd.widColEWeed=color
		SetColorOptionValueST(color)
	endEvent
	event OnDefaultST()
		mnd.widColEWeed=0x2d8b2c
		SetColorOptionValueST(mnd.widColEWeed)
	endEvent
	event OnHighlightST()
		SetInfoText("$MND_HelpWidColWeedE")
	endEvent
endState

state ResetWidColsBN
	event OnSelectST()
		mnd.widColSEat=0xEF6F12
		mnd.widColEEat=0xFF2211
		mnd.widColSDrink=0x82FF82
		mnd.widColEDrink=0x11AF22
		mnd.widColSSleep=0x6666FF
		mnd.widColESleep=0x1122A1
		mnd.widColSTalk=0xb7b4b4
		mnd.widColETalk=0x999997
		mnd.widColSBath=0xa7e4f4
		mnd.widColEBath=0xa9d9e7
		mnd.widColSPray=0xf884b4
		mnd.widColEPray=0xe98997
		mnd.widColSPiss=0xFFDA22
		mnd.widColEPiss=0xBABA11
		mnd.widColSPoop=0x834a07
		mnd.widColEPoop=0xd4801d
		mnd.widColSSex=0xe0efef
		mnd.widColESex=0xf0f4f5
		mnd.widColSDrunk=0x91acd4
		mnd.widColEDrunk=0x9a1dd4
		mnd.widColSSkooma=0x68c6d5
		mnd.widColESkooma=0x22d0eb
		mnd.widColSAlcohol=0xdb90f4
		mnd.widColEAlcohol=0xf434c0
		mnd.widColSWeed=0x9ae1ac
		mnd.widColEWeed=0x2d8b2c
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MND_HelpResetWidColsBN")
	endEvent
endState

state SetWidgetColorsBN
	event OnSelectST()
		pageMode=32
		ForcepageReset()
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MND_HelpSetWidgetColors")
	endEvent
endState

state EnableDisableSpecificWidgetsBN
	event OnSelectST()
		pageMode=31
		ForcepageReset()
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MND_HelpEnableDisableSpecificWidgets")
	endEvent
endState

state GoBackBN
	event OnSelectST()
		pageMode=(pageMode/10) * 10
		ForcepageReset()
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MND_HelpGoBack")
	endEvent
endState

state UnknowFoodModeMN
	event OnMenuOpenST()
		SetMenuDialogStartIndex(unknowFoodMode)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(unknowFoodModes)
	endEvent

	event OnMenuAcceptST(int val)
		if val>=0 && val<=unknowFoodModes.length
			SetMenuOptionValueST(unknowFoodModes[val])
			unknowFoodMode = val
		endIf
		ForcePageReset()
	endEvent
	
	event OnDefaultST()
		SetMenuOptionValueST(unknowFoodModes[0])
		unknowFoodMode = 0
		ForcePageReset()
	endEvent
		
	event OnHighlightST()
		SetInfoText("$MND_HelpUnknowFoodMode")
	endEvent
endState


; -))


function showTranslatedString(string toGet)
	if toGet=="CantUrinate"
		debug.notification("$MND_CannotUrinate")
	elseIf toGet=="CantMasturbate"
		debug.notification("$MND_CantMasturbate")
	elseIf toGet=="CantDefecate"
		debug.notification("$MND_CantDefecate")
	elseIf toGet=="NeedsP_PP"
		debug.notification("$MND_NeedsP_PP")
	elseIf toGet=="NeedsP_P!"
		debug.notification("$MND_NeedsP_P!")
	elseIf toGet=="NeedsP_!P"
		debug.notification("$MND_NeedsP_!P")
	elseIf toGet=="NeedsB_EDS"
		debug.notification("$MND_NeedsB_EDS")
	elseIf toGet=="NeedsB_ED!"
		debug.notification("$MND_NeedsB_ED!")
	elseIf toGet=="NeedsB_E!S"
		debug.notification("$MND_NeedsB_E!S")
	elseIf toGet=="NeedsB_E!!"
		debug.notification("$MND_NeedsB_E!!")
	elseIf toGet=="NeedsB_!DS"
		debug.notification("$MND_NeedsB_!DS")
	elseIf toGet=="NeedsB_!D!"
		debug.notification("$MND_NeedsB_!D!")
	elseIf toGet=="NeedsB_!!S"
		debug.notification("$MND_NeedsB_!!S")
	elseIf toGet=="NeedsB_!!!"
		debug.notification("$MND_NeedsB_!!!")
	elseIf toGet=="NeedsS_TBP"
		debug.notification("$MND_NeedsS_TBP")
	elseIf toGet=="NeedsS_TB!"
		debug.notification("$MND_NeedsS_TB!")
	elseIf toGet=="NeedsS_T!P"
		debug.notification("$MND_NeedsS_T!P")
	elseIf toGet=="NeedsS_T!!"
		debug.notification("$MND_NeedsS_T!!")
	elseIf toGet=="NeedsS_!BP"
		debug.notification("$MND_NeedsS_!BP")
	elseIf toGet=="NeedsS_!B!"
		debug.notification("$MND_NeedsS_!B!")
	elseIf toGet=="NeedsS_!!P"
		debug.notification("$MND_NeedsS_!!P")
	elseIf toGet=="NeedsS_!!!"
		debug.notification("$MND_NeedsS_!!!")
	elseIf toGet=="NeedsA_SSWW"
		debug.notification("$MND_NeedsA_SSWW")
	elseIf toGet=="NeedsA_SSW!"
		debug.notification("$MND_NeedsA_SSW!")
	elseIf toGet=="NeedsA_SS!W"
		debug.notification("$MND_NeedsA_SS!W")
	elseIf toGet=="NeedsA_SS!!"
		debug.notification("$MND_NeedsA_SS!!")
	elseIf toGet=="NeedsA_S!WW"
		debug.notification("$MND_NeedsA_S!WW")
	elseIf toGet=="NeedsA_S!W!"
		debug.notification("$MND_NeedsA_S!W!")
	elseIf toGet=="NeedsA_S!!W"
		debug.notification("$MND_NeedsA_S!!W")
	elseIf toGet=="NeedsA_S!!!"
		debug.notification("$MND_NeedsA_S!!!")
	elseIf toGet=="NeedsA_!SWW"
		debug.notification("$MND_NeedsA_!SWW")
	elseIf toGet=="NeedsA_!SW!"
		debug.notification("$MND_NeedsA_!SW!")
	elseIf toGet=="NeedsA_!S!W"
		debug.notification("$MND_NeedsA_!S!W")
	elseIf toGet=="NeedsA_!S!!"
		debug.notification("$MND_NeedsA_!S!!")
	elseIf toGet=="NeedsA_!!WW"
		debug.notification("$MND_NeedsA_!!WW")
	elseIf toGet=="NeedsA_!!W!"
		debug.notification("$MND_NeedsA_!!W!")
	elseIf toGet=="NeedsA_!!!W"
		debug.notification("$MND_NeedsA_!!!W")
	elseIf toGet=="NeedsA_!!!!"
		debug.notification("$MND_NeedsA_!!!!")
	elseIf toGet=="YouAreAlreadyDoingYourBusiness"
		debug.notification("$MND_YouAreAlreadyDoingYourBusiness")
	elseIf toGet=="NoMoreShowers"
		debug.notification("$MND_YouAreBuildTooManyShowers")
	elseIf toGet=="NoMoreBathtubs"
		debug.notification("$MND_YouAreBuildTooManyBathtubs")
	elseIf toGet=="Test"
		debug.notification("$MND_Test")
		
	elseIf toGet=="YouAreNotInWaterToBath"
		debug.notification("$MND_YouAreNotInWaterToBath")
	elseIf toGet=="TooDeepWaterToBath"
		debug.notification("$MND_TooDeepWaterToBath")
	endIf
endFunction

string function getFormName(form f)
	if !f
		return ""
	endIf
	string name = f.getName()
	int id = f.GetFormID()
	int mod = Math.RightShift(Math.logicalAnd(id, 0xFF000000), 24)
	id = Math.logicalAnd(id, 0xFFFFFF)
	string res = ""
	if name
		res = name
	else
		while id
			int part = Math.logicalAnd(id, 0xF)
			id = Math.RightShift(Math.logicalAnd(id, 0xFFFFF0), 4)
			if id<10
				res = id + res
			elseIf id==10
				res = "A" + res
			elseIf id==11
				res = "B" + res
			elseIf id==12
				res = "C" + res
			elseIf id==13
				res = "D" + res
			elseIf id==14
				res = "E" + res
			elseIf id==15
				res = "F" + res
			endIf
		endWhile
	endIf
	string modn = Game.GetModName(Math.RightShift(Math.logicalAnd(f.GetFormID(), 0xFF000000), 24))
	if StringUtil.find(modn, ".esp")!=-1 || StringUtil.find(modn, ".esl")!=-1 || StringUtil.find(modn, ".esm")!=-1
		modn = StringUtil.substring(modn, 0, StringUtil.getLength(modn) - 4)
	endIf
	return res + " (" + modn + ")"
endFunction


function disableMiniNeeds()
	mnd.disableTheMod = true
	mnd.enableWidgets = 0
	mnd.enableEat = false
	mnd.enableDrink = false
	mnd.enableSleep = false
	mnd.enableTalk = false
	mnd.enablePiss = false
	mnd.enablePoop = false
	mnd.enableDrunk = false
	mnd.enableSkooma = false
	mnd.enableAlcohol = false
	mnd.enableWeed = false
	mnd.lastTimeAlcohol = Utility.getCurrentGameTime()
	mnd.lastTimeBath = Utility.getCurrentGameTime()
	mnd.lastTimeDrink = Utility.getCurrentGameTime()
	mnd.lastTimeDrunk = 0.0
	mnd.lastTimeEat = Utility.getCurrentGameTime()
	mnd.lastTimePiss = Utility.getCurrentGameTime()
	mnd.lastTimePoop = Utility.getCurrentGameTime()
	mnd.lastTimePray = Utility.getCurrentGameTime()
	mnd.lastTimeSex = Utility.getCurrentGameTime()
	mnd.lastTimeSkooma = Utility.getCurrentGameTime()
	mnd.lastTimeSleep = Utility.getCurrentGameTime()
	mnd.lastTimeTalk = Utility.getCurrentGameTime()
	mnd.lastTimeWeed = Utility.getCurrentGameTime()
	mnd.calculateWidgets()
	mnd.applyConfig()
	
	mndShowers.resetBuilding()

	Actor PlayerRef = Game.getPlayer()
	mnd.removeAllDiseases()
	if PlayerRef.HasSpell(mnd.mndTakeALeak)
		PlayerRef.removeSpell(mnd.mndTakeALeak)
	endIf
	if PlayerRef.HasSpell(mnd.mndDoYourBusiness)
		PlayerRef.removeSpell(mnd.mndDoYourBusiness)
	endIf
	if PlayerRef.HasSpell(mnd.mndDoFullBusiness)
		PlayerRef.removeSpell(mnd.mndDoFullBusiness)
	endIf
	PlayerRef.removeShout(mnd.mndTakeALeakShout)
	PlayerRef.removeShout(mnd.mndDoYourBusinessShout)
	PlayerRef.removeShout(mnd.mndDoFullBusinessShout)
	mndMiniNeedsPlayerScript playerAlias = mnd.GetAliasByName("PlayerRef") as mndMiniNeedsPlayerScript
	playerAlias.UnregisterForAllKeys()
	playerAlias.UnregisterForUpdate()
	playerAlias.UnregisterForUpdateGameTime()
	playerAlias.UnregisterForSleep()
	playerAlias.UnregisterForMenu("Dialogue Menu")
	mnd.UnRegisterForModEvent("HookAnimationEnding")
	mnd.removeISMs()
	mnd.stop()
	ForcePageReset()
endFunction

function enableMiniNeeds(bool resetToDefaultValues)
	mnd.disableTheMod = false
	if resetToDefaultValues
		float now = Utility.getCurrentGameTime()
		mnd.enableStaticShowers=true
		mnd.reverseWidgets=false
		mnd.useNutritionValues=0
		mnd.enableEat=false
		mnd.timeEat=8.0
		mnd.lastTimeEat=now
		mnd.maxEatDamage=50.0
		mnd.useAnimForEating=false
		mnd.enableDrink=false
		mnd.timeDrink=6.0
		mnd.lastTimeDrink=now
		mnd.maxDrinkDamage=50.0
		mnd.useAnimForDrinking=false
		mnd.enableSleep=false
		mnd.timeSleep=16.0
		mnd.lastTimeSleep=now
		mnd.maxSleepDamage=50.0
		mnd.enableTalk=false
		mnd.timeTalk=168.0
		mnd.lastTimeTalk=now
		mnd.maxTalkDamage=50.0
		mnd.enableBath=false
		mnd.timeBath=24.0
		mnd.lastTimeBath=now
		mnd.maxBathDamage=50.0
		mnd.noDirtShaderWhileCum=true
		mnd.enablePray=false
		mnd.timePray=96.0
		mnd.lastTimePray=now
		mnd.maxPrayDamage=50.0
		mnd.enablePiss=false
		mnd.timePiss=12.0
		mnd.lastTimePiss=now
		mnd.maxPissDamage=50.0
		mnd.useAnimForPissing=false
		mnd.howToPiss=0
		mnd.keyToPiss=0
		mnd.noPissInPublic=0
		mnd.addPissPuddle=0
		mnd.enablePoop=false
		mnd.timePoop=48.0
		mnd.lastTimePoop=now
		mnd.maxPoopDamage=50.0
		mnd.useAnimForPooping=false
		mnd.howToPoop=0
		mnd.keyToPoop=0
		mnd.noPoopInPublic=false
		mnd.addVisiblePoop=0
		mnd.pissAndPoopTogether=false
		mnd.enableSex=false
		mnd.timeSex=48.0
		mnd.lastTimeSex=now
		mnd.noSexInPublic=false
		mnd.keyToMasturbate=0
		mnd.maxSexDamage=50.0
		mnd.enableSkooma=false
		mnd.timeSkooma=18.0
		mnd.lastTimeSkooma=now
		mnd.maxSkoomaDamage=90.0
		mnd.enableAlcohol=false
		mnd.timeAlcohol=24.0
		mnd.lastTimeAlcohol=now
		mnd.maxAlcoholDamage=50.0
		mnd.enableWeed=false
		mnd.timeWeed=48.0
		mnd.lastTimeWeed=now
		mnd.maxWeedDamage=50.0
		mnd.enableDrunk=false
		mnd.timeDrunk=6.0
		mnd.maxDrunkDamage=50.0
		mnd.lastTimeDrunk=0.0
		mnd.stripMode=0
		mnd.grabRandomWeapon=0
		mnd.drinkAnotherAlcohol=0
		mnd.enableWidgets=false
		mnd.widgetsKey=0
		mnd.oldWidgetsKey=0
		mnd.widgetsOpacities = 0
		mnd.widgetsPositions = 0
		mnd.widgetsArrangements = 1
		mnd.widgetsSize = 0
		mnd.widgetsSpace=0
		mnd.widgetsMarginH=0
		mnd.widgetsMarginV=0
		mnd.widgetsGrouped = 0
		mnd.useTimeScale=false
		mnd.notificationsTime=2
		mnd.enableWidgetEat=true
		mnd.enableWidgetDrink=true
		mnd.enableWidgetSleep=true
		mnd.enableWidgetTalk=true
		mnd.enableWidgetBath=true
		mnd.enableWidgetPray=true
		mnd.enableWidgetPiss=true
		mnd.enableWidgetPoop=true
		mnd.enableWidgetSex=true
		mnd.enableWidgetSkooma=true
		mnd.enableWidgetAlcohol=true
		mnd.enableWidgetWeed=true
		mnd.enableWidgetDrunk=true
		mnd.widColSEat=0xEF6F12
		mnd.widColEEat=0xFF2211
		mnd.widColSDrink=0x82FF82
		mnd.widColEDrink=0x11AF22
		mnd.widColSSleep=0x6666FF
		mnd.widColESleep=0x1122A1
		mnd.widColSTalk=0xb7b4b4
		mnd.widColETalk=0x999997
		mnd.widColSBath=0xa7e4f4
		mnd.widColEBath=0xa9d9e7
		mnd.widColSPray=0xf884b4
		mnd.widColEPray=0xe98997
		mnd.widColSPiss=0xFFDA22
		mnd.widColEPiss=0xBABA11
		mnd.widColSPoop=0x834a07
		mnd.widColEPoop=0xd4801d
		mnd.widColSSex=0xe0efef
		mnd.widColESex=0xf0f4f5
		mnd.widColSSkooma=0x68c6d5
		mnd.widColESkooma=0x22d0eb
		mnd.widColSAlcohol=0xdb90f4
		mnd.widColEAlcohol=0xf434c0
		mnd.widColSWeed=0x9ae1ac
		mnd.widColEWeed=0x2d8b2c
		mnd.widColSDrunk=0x91acd4
		mnd.widColEDrunk=0x9a1dd4

		int i = mnd.penalties0.length
		while i
			i-=1
			mnd.penalties0[i]=0
			mnd.penalties1[i]=0
			mnd.penalties2[i]=0
			mnd.penalties3[i]=0
			mnd.penalties4[i]=0
		endWhile
		mnd.penalties0[0]=2432
		mnd.penalties0[1]=155648
		mnd.penalties0[2]=38
		mnd.penalties0[6]=101711872
		mnd.penalties0[11]=402653184
		mnd.penalties1[3]=613416960
		mnd.penalties1[5]=131072
		mnd.penalties1[7]=19456
		mnd.penalties1[8]=5
		mnd.penalties1[10]=320
		mnd.penalties1[12]=16
		mnd.penalties2[3]=818085892
		mnd.penalties2[5]=32
		mnd.penalties2[10]=2304
		mnd.penalties3[3]=4
		mnd.penalties3[4]=2182
		mnd.penalties4[2]=805306368
		mnd.penalties4[7]=48
		mnd.penalties4[8]=3328
		mnd.penalties4[9]=67133440
		mnd.penalties4[11]=131072
		mnd.penalties4[12]=813694977
	endIf
	mnd.start()
	Utility.waitMenuMode(1.0)
	(mnd.GetAliasByName("PlayerRef") as mndMiniNeedsPlayerScript).doInit()
	mnd.applyConfig()
	ForcePageReset()
endFunction

string function calculateCurrentPenalties(int need)
	if need<0 || need>mnd.penalties0.length
		return ""
	endIf
	string res=""
	int num=0
	
	if Math.LogicalAnd(mnd.penalties0[need], 0x00000007) ; 0 0	damageM
		if num==0
			res+="{$MND_DamageMagickaValue}"
		else
			res+="{$MND_DamageMagickaValueC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties0[need], 0x00000038) ; 1 0	damageRM
		if num==0
			res+="{$MND_DamageMagickaRestoration}"
		else
			res+="{$MND_DamageMagickaRestorationC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties0[need], 0x000001C0) ; 2 0	damageH
		if num==0
			res+="{$MND_DamageHealthValue}"
		else
			res+="{$MND_DamageHealthValueC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties0[need], 0x00000E00) ; 3 0	damageRH
		if num==0
			res+="{$MND_DamageHealthRestoration}"
		else
			res+="{$MND_DamageHealthRestorationC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties0[need], 0x00007000) ; 4 0	damageS
		if num==0
			res+="{$MND_DamageStaminaValue}"
		else
			res+="{$MND_DamageStaminaValueC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties0[need], 0x00038000) ; 5 0	damageRS
		if num==0
			res+="{$MND_DamageStaminaRestoration}"
		else
			res+="{$MND_DamageStaminaRestorationC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties0[need], 0x001C0000) ; 6 0	damageSpeed
		if num==0
			res+="{$MND_DamageSpeed}"
		else
			res+="{$MND_DamageSpeedC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties0[need], 0x00E00000) ; 7 0	rndSpeed
		if num==0
			res+="{$MND_DamageSpeed}"
		else
			res+="{$MND_DamageSpeedC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties0[need], 0x07000000) ; 8 0	damageWeaponsSpeed
		if num==0
			res+="{$MND_DamageWeaponsSpeed}"
		else
			res+="{$MND_DamageWeaponsSpeedC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties0[need], 0x38000000) ; 9 0	damageWeaponsDamage
		if num==0
			res+="{$MND_DamageWeaponsDamage}"
		else
			res+="{$MND_DamageWeaponsDamageC}"
		endIf
		num+=1
	endIf

	if Math.LogicalAnd(mnd.penalties1[need], 0x00000007) ; 0 1	RemoveWeapon
		if num==0
			res+="{$MND_DamageRemoveWeapon}"
		else
			res+="{$MND_DamageRemoveWeaponC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties1[need], 0x00000038) ; 1 1	RndWeaponUse
		if num==0
			res+="{$MND_DamageRndWeapon}"
		else
			res+="{$MND_DamageRndWeaponC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties1[need], 0x000001C0) ; 2 1	RndWeaponEquipping
		if num==0
			res+="{$MND_DamageRndWeaponEquipping}"
		else
			res+="{$MND_DamageRndWeaponEquippingC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties1[need], 0x00000E00) ; 3 1	AttackDamage
		if num==0
			res+="{$MND_DamageAttackDamage}"
		else
			res+="{$MND_DamageAttackDamageC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties1[need], 0x00007000) ; 4 1	CarryWeight
		if num==0
			res+="{$MND_DamageCarryWeight}"
		else
			res+="{$MND_DamageCarryWeightC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties1[need], 0x00038000) ; 5 1	Alchemy
		if num==0
			res+="{$MND_DamageAlchemy}"
		else
			res+="{$MND_DamageAlchemyC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties1[need], 0x001C0000) ; 6 1	SpellsIllusion
		if num==0
			res+="{$MND_DamageSpellsIllusion}"
		else
			res+="{$MND_DamageSpellsIllusionC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties1[need], 0x00E00000) ; 7 1	SpellsConjuration
		if num==0
			res+="{$MND_DamageSpellsConjuration}"
		else
			res+="{$MND_DamageSpellsConjurationC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties1[need], 0x07000000) ; 8 1	SpellsDestruction
		if num==0
			res+="{$MND_DamageSpellsDestruction}"
		else
			res+="{$MND_DamageSpellsDestructionC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties1[need], 0x38000000) ; 9 1	SpellsRestoration
		if num==0
			res+="{$MND_DamageSpellsRestoration}"
		else
			res+="{$MND_DamageSpellsRestorationC}"
		endIf
		num+=1
	endIf

	if Math.LogicalAnd(mnd.penalties2[need], 0x00000007) ; 0 2	SpellsAlteration
		if num==0
			res+="{$MND_DamageSpellsAlteration}"
		else
			res+="{$MND_DamageSpellsAlterationC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties2[need], 0x00000038) ; 1 2	Enchanting
		if num==0
			res+="{$MND_DamageEnchanting}"
		else
			res+="{$MND_DamageEnchantingC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties2[need], 0x000001C0) ; 2 2	LightArmors
		if num==0
			res+="{$MND_DamageLightArmors}"
		else
			res+="{$MND_DamageLightArmorsC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties2[need], 0x00000E00) ; 3 2	HeavyArmors
		if num==0
			res+="{$MND_DamageHeavyArmors}"
		else
			res+="{$MND_DamageHeavyArmorsC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties2[need], 0x00007000) ; 4 2	Sneak
		if num==0
			res+="{$MND_DamageSneak}"
		else
			res+="{$MND_DamageSneakC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties2[need], 0x00038000) ; 5 2	IncreaseSneak
		if num==0
			res+="{$MND_DamageIncreaseSneak}"
		else
			res+="{$MND_DamageIncreaseSneakC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties2[need], 0x001C0000) ; 6 2	LockPicking
		if num==0
			res+="{$MND_DamageLockPicking}"
		else
			res+="{$MND_DamageLockPickingC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties2[need], 0x00E00000) ; 7 2	IncreaseLockPicking
		if num==0
			res+="{$MND_DamageIncreaseLockPicking}"
		else
			res+="{$MND_DamageIncreaseLockPickingC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties2[need], 0x07000000) ; 8 2	PickPocket
		if num==0
			res+="{$MND_DamagePickPocket}"
		else
			res+="{$MND_DamagePickPocketC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties2[need], 0x38000000) ; 9 2	IncreasePickPocket
		if num==0
			res+="{$MND_DamageIncreasePickPocket}"
		else
			res+="{$MND_DamageIncreasePickPocketC}"
		endIf
		num+=1
	endIf

	if Math.LogicalAnd(mnd.penalties3[need], 0x00000007) ; 0 3	DamageSpeech
		if num==0
			res+="{$MND_DamageSpeech}"
		else
			res+="{$MND_DamageSpeechC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties3[need], 0x00000038) ; 1 3	DamageBlocking
		if num==0
			res+="{$MND_DamageBlocking}"
		else
			res+="{$MND_DamageBlockingC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties3[need], 0x000001C0) ; 2 3	DamageDirt1
		if num==0
			res+="{$MND_DamageDirt1}"
		else
			res+="{$MND_DamageDirt1C}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties3[need], 0x00000E00) ; 3 3	DamageDirt2
		if num==0
			res+="{$MND_DamageDirt2}"
		else
			res+="{$MND_DamageDirt2C}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties3[need], 0x00007000) ; 4 3	DamageReduceTits
		if num==0
			res+="{$MND_DamageReduceTits}"
		else
			res+="{$MND_DamageReduceTitsC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties3[need], 0x00038000) ; 5 3	DamageIncreaseTits
		if num==0
			res+="{$MND_DamageIncreaseTits}"
		else
			res+="{$MND_DamageIncreaseTitsC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties3[need], 0x001C0000) ; 6 3	DamageReduceBelly
		if num==0
			res+="{$MND_DamageReduceBelly}"
		else
			res+="{$MND_DamageReduceBellyC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties3[need], 0x00E00000) ; 7 3	DamageIncreaseBelly
		if num==0
			res+="{$MND_DamageIncreaseBelly}"
		else
			res+="{$MND_DamageIncreaseBellyC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties3[need], 0x07000000) ; 8 3	DamageWeight
		if num==0
			res+="{$MND_DamageWeight}"
		else
			res+="{$MND_DamageWeightC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties3[need], 0x38000000) ; 9 3	DamageIncreaseWeight
		if num==0
			res+="{$MND_DamageIncreaseWeight}"
		else
			res+="{$MND_DamageIncreaseWeightC}"
		endIf
		num+=1
	endIf

	if Math.LogicalAnd(mnd.penalties4[need], 0x00000007) ; 0 4	MND_DamageDrinkAgainAlcohol
		if num==0
			res+="{$MND_DamageDrinkAgainAlcohol}"
		else
			res+="{$MND_DamageDrinkAgainAlcoholC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties4[need], 0x00000038) ; 1 4	MND_DamageDiarrhea
		if num==0
			res+="{$MND_DamageDiarrhea}"
		else
			res+="{$MND_DamageDiarrheaC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties4[need], 0x000001C0) ; 2 4	MND_DamageHornyPose
		if num==0
			res+="{$MND_DamageHornyPose}"
		else
			res+="{$MND_DamageHornyPoseC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties4[need], 0x00000E00) ; 3 4	MND_DamageMasturbate
		if num==0
			res+="{$MND_DamageMasturbate}"
		else
			res+="{$MND_DamageMasturbateC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties4[need], 0x00007000) ; 4 4	MND_DamageCollapse
		if num==0
			res+="{$MND_DamageCollapse}"
		else
			res+="{$MND_DamageCollapseC}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties4[need], 0x00038000) ; 5 4	MND_DamageISMLowContrast1
		if num==0
			res+="{$MND_DamageISMLowContrast1}"
		else
			res+="{$MND_DamageISMLowContrast1C}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties4[need], 0x001C0000) ; 6 4	MND_DamageISMBlurry1
		if num==0
			res+="{$MND_DamageISMBlurry1}"
		else
			res+="{$MND_DamageISMBlurry1C}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties4[need], 0x00E00000) ; 7 4	MND_DamageISMBlurry2
		if num==0
			res+="{$MND_DamageISMBlurry2}"
		else
			res+="{$MND_DamageISMBlurry2C}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties4[need], 0x07000000) ; 8 4	MND_DamageISMDistorted1
		if num==0
			res+="{$MND_DamageISMDistorted1}"
		else
			res+="{$MND_DamageISMDistorted1C}"
		endIf
		num+=1
	endIf
	if Math.LogicalAnd(mnd.penalties4[need], 0x38000000) ; 9 4	MND_DamageISMDistorted2
		if num==0
			res+="{$MND_DamageISMDistorted2}"
		else
			res+="{$MND_DamageISMDistorted2C}"
		endIf
		num+=1
	endIf

	if num==0
		return "$MND_NoPenalties{" + currentNeedNames[need] + "}"
	endIf
	
	if num<10
		res = "$MND_HelpPenaltiesFor0{" + currentNeedNames[need] + "}" + res
		while num<10
			res += "{}"
			num+=1
		endWhile
	elseif num<20
		res = "$MND_HelpPenaltiesFor1{" + currentNeedNames[need] + "}" + res
		while num<20
			res += "{}"
			num+=1
		endWhile
	elseif num<30
		res = "$MND_HelpPenaltiesFor2{" + currentNeedNames[need] + "}" + res
		while num<30
			res += "{}"
			num+=1
		endWhile
	elseif num<40
		res = "$MND_HelpPenaltiesFor3{" + currentNeedNames[need] + "}" + res
		while num<40
			res += "{}"
			num+=1
		endWhile
	else
		return "$MND_TooManyPenaltiesFor{" + currentNeedNames[need] + "}"
	endIf
	
	return res
endFunction

string function checkPenaltyUsage(int penalty, int need)
	int numUsers = 0

	int i=currentNeedNames.length
	while i
		i-=1
		if need!=i && mnd.getDamageValue(i, penalty)!=0
			numUsers+=1
		endIf
	endWhile
	if numUsers
		return "(" + numUsers + ")"
	endIf
	return ""
endFunction

int function calculateFoodType(Form p)
	if mnd.mndFoods.HasForm(p)
		return 1
	elseIf mnd.mndDrinks.HasForm(p)
		return 2
	elseIf mnd.mndLiquidFoods.HasForm(p)
		return 3
	elseIf mnd.mndAlcohol.HasForm(p)
		return 4
	elseIf mnd.mndSkooma.HasForm(p)
		return 5
	elseIf mnd.mndWeed.HasForm(p)
		return 6
	elseIf mnd.mndBlood.HasForm(p)
		return 7
	elseIf mnd.mndMilk.HasForm(p)
		return 8
	elseIf mnd.mndToBeIgnored.HasForm(p)
		return 9
	endIf
	return 0
endFunction

