Scriptname SLS_Mcm extends SKI_ConfigBase

; MCM Config Begin =======================================================

Event OnConfigInit()
	BuildPages()

	SetupMenuArrays()
	
	;LoadSettings()
	AssSlappingEvents = true
	If Game.GetModByName("Spank That Ass.esp") != 255
		AssSlappingEvents = false
	EndIf
	ToggleAssSlapping()
	
	If Game.GetModByName("Devious Devices - Expansion.esm") != 255
		DeviousEffectsEnable = true
	Else
		PpLootKeysChance = 0.0
	EndIf
	
	If Game.GetModByName("Amputator.esm") == 255
		AmpType = 0
		ToggleDismemberment()
	EndIf
	
	PlayerRef.AddPerk(_SLS_InequalitySkillsPerk)
	PlayerRef.AddPerk(_SLS_InequalityBuySellPerk)
	PlayerRef.AddPerk(_SLS_BikiniExpPerk)
	PlayerRef.AddSpell(_SLS_BikiniExpSpell)
	PlayerRef.AddSpell(Game.GetFormFromFile(0x0CF9B0, "SL Survival.esp") as Spell) ; Jiggles
	
	ImportTradeRestrictMerchants()
	BuildPpLootList()
	ImportEscorts()
	AddQuestObjects()
	InitLocJurisdictions()
	ImportLicenceExceptions()
	AddWearableLanternExceptions()
	SetHorseCost(SurvivalHorseCost)
	ToggleProxSpank()
	ToggleCumAddiction()
	ToggleCoverMechanics()
	TogglePpSleepNpcPerk()
	Game.SetGameSettingFloat("fAIMinGreetingDistance", GreetDist)
	Game.SetGameSettingInt("iCrimeGoldPickpocket", PpCrimeGold)
	ToggleSexExp()
	ImportStrongFemales()
	ReplaceVanillaMaps(ReplaceMaps)
	AddRemoveChainCollars(LicMagicChainCollars)
	ToggleAhegao()
	PapyrusUtilCheck()
EndEvent

Function PlayerLoadsGame()
	If Game.GetModByName(JsonUtil.GetStringValue("SL Survival/BikiniArmors.json", "bikinimodname", missing = "TheAmazingWorldOfBikiniArmor.esp")) != 255
		_SLS_BikiniArmorsEntryPointVendorCity.SetNthCount(0, BikiniDropsVendorCity)
		_SLS_BikiniArmorsEntryPointVendorTown.SetNthCount(0, BikiniDropsVendorTown)
		_SLS_BikiniArmorsEntryPointVendorKhajiit.SetNthCount(0, BikiniDropsVendorKhajiit)
		_SLS_BikiniArmorsEntryPointChest.SetNthCount(0, BikiniDropsChest)
		_SLS_BikiniArmorsEntryPointChestOrnate.SetNthCount(0, BikiniDropsChestOrnate)
	EndIf
	AddWearableLanternExceptions()
	Game.SetGameSettingFloat("fAIMinGreetingDistance", GreetDist)
	Game.SetGameSettingInt("iCrimeGoldPickpocket", PpCrimeGold)
	PapyrusUtilCheck()
EndFunction

Function PapyrusUtilCheck()
	While PapyrusUtil.GetVersion() < 33
		Debug.Messagebox("SL Survival: Your version of PapyrusUtil is outdated! \n\nThis issue is answered in the FAQ of the mod page. Please read the FAQ FIRST before posting on the forum as it's been asked a thousand times! If you're still stuck after reading then, by all means, ask for help\n\nYou should exit the game and fix this problem before proceeding! This message will repeat until it's fixed")
		Utility.Wait(3.0)
	EndWhile
EndFunction

Function BuildPages()
	Pages = new string[18]
	Pages[0] = "$SLS_pSettings"
	Pages[1] = "$SLS_pSexEffects"
	Pages[2] = "$SLS_pMisogynyInequality"
	Pages[3] = "$SLS_pTrauma"
	Pages[4] = "$SLS_pNeeds"
	Pages[5] = "$SLS_pCum"
	Pages[6] = "$SLS_pFrostfallSimplyKnock"
	Pages[7] = "$SLS_pTollsEvictionGates"
	Pages[8] = "$SLS_pLicences1"
	Pages[9] = "$SLS_pLicences2"
	Pages[10] = "$SLS_pStashes"
	Pages[11] = "$SLS_pBeggingKennel"
	Pages[12] = "$SLS_pPickpocketDismemberment"
	Pages[13] = "$SLS_pBikiniArmorsExp"
	Pages[14] = "$SLS_pInnRoomPrices"
	Pages[15] = "$SLS_pInterfaces"
	Pages[16] = "$SLS_pStatsInfo"
	Pages[17] = "$SLS_pStatsInfo2"
EndFunction

Function SetupMenuArrays()
	SlotMasks = new Int[32]
	SlotMasks[0] = 1 ; kSlotMask30
	SlotMasks[1] = 2 ; kSlotMask31
	SlotMasks[2] = 4 ; kSlotMask32
	SlotMasks[3] = 8 ; kSlotMask33
	SlotMasks[4] = 16 ; kSlotMask34
	SlotMasks[5] = 32 ; kSlotMask35
	SlotMasks[6] = 64 ; kSlotMask36
	SlotMasks[7] = 128 ; kSlotMask37
	SlotMasks[8] = 256 ; kSlotMask38
	SlotMasks[9] = 512 ; kSlotMask39
	SlotMasks[10] = 1024 ; kSlotMask40
	SlotMasks[11] = 2048 ; kSlotMask41
	SlotMasks[12] = 4096 ; kSlotMask42
	SlotMasks[13] = 8192 ; kSlotMask43
	SlotMasks[14] = 16384 ; kSlotMask44
	SlotMasks[15] = 32768 ; kSlotMask45
	SlotMasks[16] = 65536 ; kSlotMask46
	SlotMasks[17] = 131072 ; kSlotMask47
	SlotMasks[18] = 262144 ; kSlotMask48
	SlotMasks[19] = 524288 ; kSlotMask49
	SlotMasks[20] = 1048576 ; kSlotMask50
	SlotMasks[21] = 2097152 ; kSlotMask51
	SlotMasks[22] = 4194304 ; kSlotMask52
	SlotMasks[23] = 8388608 ; kSlotMask53
	SlotMasks[24] = 16777216 ; kSlotMask54
	SlotMasks[25] = 33554432 ; kSlotMask55
	SlotMasks[26] = 67108864 ; kSlotMask56
	SlotMasks[27] = 134217728 ; kSlotMask57
	SlotMasks[28] = 268435456 ; kSlotMask58
	SlotMasks[29] = 536870912 ; kSlotMask59
	SlotMasks[30] = 1073741824 ; kSlotMask60
	SlotMasks[31] = 0x80000000 ; kSlotMask61 - Use hex otherwise number ends up being 1 short....?

	PushEventsType = new String[4]
	PushEventsType[0] = "$SLS_Off"
	PushEventsType[1] = "$SLS_StaggerOnly"
	PushEventsType[2] = "$SLS_ParalysisOnly"
	PushEventsType[3] = "$SLS_StaggerParalysis"
	
	ClothesLicenceMethod = new String[3]
	ClothesLicenceMethod[0] = "$SLS_NeverRequired"
	ClothesLicenceMethod[1] = "$SLS_AlwaysRequired"
	ClothesLicenceMethod[2] = "$SLS_InSlaverunTowns"
	
	HeavyBondageDifficulty = new String[3]
	HeavyBondageDifficulty[0] = "$SLS_Off"
	HeavyBondageDifficulty[1] = "$SLS_Difficult"
	HeavyBondageDifficulty[2] = "$SLS_Impossible"
	
	
	AmputationTypes = new String[4]
	AmputationTypes[0] = "$SLS_Off"
	AmputationTypes[1] = "$SLS_Random"
	AmputationTypes[2] = "$SLS_ArmsFirst"
	AmputationTypes[3] = "$SLS_LegsFirst"

	AmputationDepth = new String[3]
	AmputationDepth[0] = "$SLS_OneLevelAtATime"
	AmputationDepth[1] = "$SLS_MaxInOneChop"
	AmputationDepth[2] = "$SLS_Random"

	MaxAmputationDepthArms = new String [3]
	MaxAmputationDepthArms[0] = "$SLS_Everything"
	MaxAmputationDepthArms[1] = "$SLS_UpToForearmsOnly"
	MaxAmputationDepthArms[2] = "$SLS_HandsOnly"
	
	MaxAmputationDepthLegs = new String [3]
	MaxAmputationDepthLegs[0] = "$SLS_Everything"
	MaxAmputationDepthLegs[1] = "$SLS_UpToLowerLegsOnly"
	MaxAmputationDepthLegs[2] = "$SLS_FeetOnly"

	;/
	AltHealingRequirements[0] = "Swallow Cum Immediate"
	AltHealingRequirements[1] = "Swallow Cum + Rest"
	AltHealingRequirements[2] = "Filled With Cum Immediate"
	AltHealingRequirements[3] = "Filled With Cum + Rest"
	AltHealingRequirements[4] = "Filled With Cum + Swallow Cum Immediate"
	AltHealingRequirements[5] = "Filled With Cum + Swallow Cum + Rest"
	/;

	DismemberWeapons = new String[3]
	DismemberWeapons[0] = "$SLS_TwoHandedOnly"
	DismemberWeapons[1] = "$SLS_EverythingExceptDaggersRanged"
	DismemberWeapons[2] = "$SLS_EverythingSillyMode"
	
	OverlayAreas = new String[4]
	OverlayAreas[0] = "Body"
	OverlayAreas[1] = "Face"
	OverlayAreas[2] = "Hands"
	OverlayAreas[3] = "Feet"
	
	BuyBackPrices = new String [6]
	BuyBackPrices[5] = "$SLS_100Original"
	BuyBackPrices[4] = "$SLS_75Original"
	BuyBackPrices[3] = "$SLS_50Original"
	BuyBackPrices[2] = "$SLS_25Original"
	BuyBackPrices[1] = "$SLS_10Original"
	BuyBackPrices[0] = "$SLS_5Original"
	
	LicenceStyleList = new String[4]
	LicenceStyleList[0] = "$SLS_Default"
	LicenceStyleList[1] = "$SLS_ThaneshipChoice"
	LicenceStyleList[2] = "$SLS_ThaneshipRandom"
	LicenceStyleList[3] = "$SLS_Unlock"
	
	ProxSpankNpcList = new String[6]
	ProxSpankNpcList[0] = "$SLS_GuardsOnly"
	ProxSpankNpcList[1] = "$SLS_GuardsMen"
	ProxSpankNpcList[2] = "$SLS_OnlyMen"
	ProxSpankNpcList[3] = "$SLS_OnlyWomen"
	ProxSpankNpcList[4] = "$SLS_AnythingWithHands"
	ProxSpankNpcList[5] = "$SLS_Off"
	
	ProxSpankRequiredCoverList = new String[4]
	ProxSpankRequiredCoverList[0] = "$SLS_Naked"
	ProxSpankRequiredCoverList[1] = "$SLS_NakedBikiniSlooty"
	ProxSpankRequiredCoverList[2] = "$SLS_Anything"
	ProxSpankRequiredCoverList[3] = "$SLS_Off"
	
	CumHungerStrings = new String[5]
	CumHungerStrings[0] = "$SLS_Satisfied"
	CumHungerStrings[1] = "$SLS_Peckish"
	CumHungerStrings[2] = "$SLS_Hungry"
	CumHungerStrings[3] = "$SLS_Starving"
	CumHungerStrings[4] = "$SLS_Ravenous"
	
	SexExpCreatureCorruption = new String[2]
	SexExpCreatureCorruption[0] = "$SLS_Off"
	SexExpCreatureCorruption[1] = "$SLS_GradualOneWay"
	
	FollowerLicStyles = new String[2]
	FollowerLicStyles[0] = "$SLS_PlayerCentric"
	FollowerLicStyles[1] = "$SLS_PartyWide"
	
	CompassHideMethods = new String[3]
	CompassHideMethods[0] = "$SLS_Transparent"
	CompassHideMethods[1] = "$SLS_IniDisable"
	CompassHideMethods[2] = "$SLS_Both"
	
	BuildSexOptionsArrays()
	
	BuildSplashArray()
EndFunction

Event OnConfigOpen()
	IsInMcm = true
	
	StorageUtil.SetIntValue(Self, "SteepFallEnabled", SteepFall.GetOwningQuest().IsRunning() as Int)
	
	; Setup Equip lists for licence exceptions
	StorageUtil.FormListClear(Self, "_SLS_EquipSlots")
	StorageUtil.StringListClear(Self, "_SLS_EquipSlotStrings")
	StorageUtil.StringListAdd(Self, "_SLS_EquipSlotStrings", "None ")
	StorageUtil.FormListAdd(Self, "_SLS_EquipSlots", None, allowDuplicate = false)
	EquipSlots = new Form[1]
	EquipSlots[0] = None
	SelectedEquip = 0
	EquipSlotStrings = StorageUtil.StringListToArray(Self, "_SLS_EquipSlotStrings")
EndEvent

Event OnConfigClose()
	IsInMcm = false
	If DoSlaverunInitOnClose
		DoSlaverunInitOnClose = false
		DoSlaverunInit()
	EndIf
	If DoDeviousEffectsChange
		ToggleDeviousEffects()
		DoDeviousEffectsChange = false
	EndIf
	If DoTollDodgingToggle
		ToggleTollDodging()
		DoTollDodgingToggle = false
	EndIf
	If DoPpLvlListbuildOnClose
		DoPpLvlListbuildOnClose = false
		BuildPpLootList()
	EndIf
	If DoTogglePpFailHandle
		DoTogglePpFailHandle = false
		TogglePpFailHandle()
	EndIf
	If DoInequalityRefresh
		DoInequalityRefresh = false
		SetInequalityEffects()
		_SLS_InequalityRefreshQuest.Stop()
		_SLS_InequalityRefreshQuest.Start()
	EndIf
	If DoToggleBikiniExp
		DoToggleBikiniExp = false
		ToggleBikiniExp()
	EndIf
	If DoToggleCumEffects
		DoToggleCumEffects = false
		ToggleCumEffects()
	EndIf
	If DoToggleAnimalBreeding
		DoToggleAnimalBreeding = false
		ToggleAnimalBreeding()
	EndIf
	If DoTogglePushEvents
		DoTogglePushEvents = false
		TogglePushPlayer()
	EndIf
	If DoToggleHalfNakedCover
		DoToggleHalfNakedCover = false
		ToggleHalfNakedCover()
	EndIf
	If DoToggleHeelsRequired
		DoToggleHeelsRequired = false
		BikiniCurse.DoArmorCheck()
	EndIf
	If DoToggleBondFurn
		DoToggleBondFurn = false
		ToggleBondFurn()
	EndIf
	If DoToggleCatCalling
		DoToggleCatCalling = false
		ToggleCatCalling()
	EndIf
	If DoToggleLicenceStyle
		DoToggleLicenceStyle = false
		ToggleLicenceStyle()
	EndIf
	If DoToggleGuardBehavWeapDrawn
		DoToggleGuardBehavWeapDrawn = false
		ToggleGuardBehavWeapDrawn()
	EndIf
	If DoToggleGuardBehavWeapEquip
		DoToggleGuardBehavWeapEquip = false
		ToggleGuardBehavWeapEquip()
	EndIf
	If DoToggleGuardBehavArmorEquip
		DoToggleGuardBehavArmorEquip = false
		ToggleGuardBehavArmorEquip()
	EndIf
	If DoToggleGuardBehavDrugs
		DoToggleGuardBehavDrugs = false
		ToggleGuardBehavDrugs()
	EndIf
	If DoToggleGuardBehavLockpick
		DoToggleGuardBehavLockpick = false
		ToggleGuardBehavLockpick()
	EndIf
	If DoToggleGuardComments
		DoToggleGuardComments = false
		ToggleGuardComments()
	EndIf
	If DoToggleProxSpank
		DoToggleProxSpank = false
		ToggleProxSpank()
	EndIf
	If DoToggleBarefootSpeed
		DoToggleBarefootSpeed = false
		ToggleBarefootMag()
	EndIf
	If DoToggleCumAddiction
		DoToggleCumAddiction = false
		ToggleCumAddiction()
	EndIf
	If DoToggleCoverMechanics
		DoToggleCoverMechanics = false
		ToggleCoverMechanics()
	EndIf
	If DoToggleCumAddictAutoSuckCreature
		DoToggleCumAddictAutoSuckCreature = false
		ToggleCumAddictAutoSuckCreature()
	EndIf
	If DoToggleSexExp
		DoToggleSexExp = false
		ToggleSexExp()
	EndIf
	If DoToggleIneqStrongFemaleFollowers
		DoToggleIneqStrongFemaleFollowers = false
		ToggleIneqStrongFemaleFollowers()
	EndIf
	If DoStashAddRemoveException
		DoStashAddRemoveException = false
		_SLS_StashAddExceptionQuest.Start()
	EndIf
	If DoToggleStashTracking
		DoToggleStashTracking = false
		ToggleStashTracking()
	EndIf
	If SnowberryEnable
		_SLS_LicenceSnowberryQuest.Start()
	Else
		_SLS_LicenceSnowberryQuest.Stop()
	EndIf
	If DoToggleBellyInflation
		DoToggleBellyInflation = false
		ToggleBellyInflation()
	EndIf
	If StorageUtil.GetIntValue(Self, "DoToggleDaydream", Missing = 0) == 1
		StorageUtil.SetIntValue(Self, "DoToggleDaydream", 0)
		CumAddict.ToggleDaydreaming(StorageUtil.GetIntValue(Self, "CumAddictDayDream", Missing = 1))
	EndIf
	If StorageUtil.GetIntValue(Self, "DoToggleDaydreamButterflys", Missing = 0) == 1
		StorageUtil.SetIntValue(Self, "DoToggleDaydreamButterflys", 0)
		CumAddict.ToggleButterflys(StorageUtil.GetIntValue(Self, "CumAddictDayDreamButterflys", Missing = 1))
	EndIf
	If StorageUtil.GetIntValue(Self, "DoToggleGrowth", Missing = 0) == 1
		StorageUtil.SetIntValue(Self, "DoToggleGrowth", 0)
		If MQ101.GetCurrentStageID() >= 240 && StorageUtil.GetFloatValue(Self, "WeightGainPerDay", Missing = 0.0) > 0.0
			(Game.GetFormFromFile(0x0DC7EE, "SL Survival.esp") as Quest).Start()
		Else
			(Game.GetFormFromFile(0x0DC7EE, "SL Survival.esp") as Quest).Stop()
		EndIf
	EndIf
	If StorageUtil.GetIntValue(Self, "DoToggleNpcComments", Missing = 0) == 1
		StorageUtil.SetIntValue(Self, "DoToggleNpcComments", 0)
		ToggleNpcComments()
	EndIf
	If StorageUtil.GetIntValue(Self, "DoToggleJiggles", Missing = 0) == 1
		StorageUtil.SetIntValue(Self, "DoToggleJiggles", 0)
		ToggleJiggles()
	EndIf
	If StorageUtil.GetIntValue(Self, "DoToggleCompulsiveSex", Missing = 0) == 1
		StorageUtil.UnSetIntValue(Self, "DoToggleCompulsiveSex")
		ToggleCompulsiveSex()
	EndIf
	If StorageUtil.GetIntValue(Self, "DoToggleOrgasmFatigue", Missing = 0) == 1
		StorageUtil.UnSetIntValue(Self, "DoToggleOrgasmFatigue")
		ToggleOrgasmFatigue()
	EndIf
	If StorageUtil.GetIntValue(Self, "DoToggleCurfew", Missing = 0) == 1
		StorageUtil.UnSetIntValue(Self, "DoToggleCurfew")
		ToggleCurfew(LicUtil.LicCurfewEnable)
	EndIf
	If StorageUtil.GetIntValue(Self, "DoToggleTrauma", Missing = 0) == 1
		StorageUtil.UnSetIntValue(Self, "DoToggleTrauma")
		Trauma.ToggleTrauma()
	EndIf
	If StorageUtil.GetIntValue(Self, "DoToggleDynamicTrauma", Missing = 0) == 1
		StorageUtil.UnSetIntValue(Self, "DoToggleDynamicTrauma")
		Trauma.ToggleDynamicTrauma()
	EndIf
	If StorageUtil.GetIntValue(Self, "DoToggleAhegaoEnable", Missing = 0) == 1
		StorageUtil.UnSetIntValue(Self, "DoToggleDynamicTrauma")
		ToggleAhegao()
	EndIf
	If StorageUtil.GetIntValue(Self, "DoToggleDropStealing", Missing = 0) == 1
		StorageUtil.UnSetIntValue(Self, "DoToggleDropStealing")
		ToggleDropStealing()
	EndIf
	If StorageUtil.GetIntValue(Self, "DoToggleSteepFall", Missing = 0) == 1
		StorageUtil.UnSetIntValue(Self, "DoToggleSteepFall")
		ToggleSteepFall()
	EndIf
	If StorageUtil.GetIntValue(Self, "DoToggleCombatEquip", Missing = 0) == 1
		StorageUtil.UnSetIntValue(Self, "DoToggleCombatEquip")
		ToggleCombatEquip()
	EndIf
EndEvent

event OnPageReset(string page)
	StorageUtil.SetStringValue(Self, "CurrentPage", page)

	If Page == ""
		LoadCustomContent(SplashArray[Utility.RandomInt(0, SplashArray.Length - 1)])
		Return
	Else
		UnloadCustomContent()
	EndIf

	Int HardMode = OPTION_FLAG_DISABLED
	If !IsHardcoreLocked
		HardMode = OPTION_FLAG_NONE
	EndIf
	
	Int CreatureEventsFlag = OPTION_FLAG_DISABLED
	If Init.SlsCreatureEvents
		CreatureEventsFlag = OPTION_FLAG_NONE
	EndIf
	
	String CrosshairRefString = GetActorCrosshairRef()

	If(page == "$SLS_pSettings")
		Int SlaverunModFound = OPTION_FLAG_DISABLED
		Int SlaverunFlag = OPTION_FLAG_DISABLED
		If Game.GetModByName("Slaverun_Reloaded.esp") != 255
			If Slaverun.GetIsInterfaceActive()
				If Slaverun.IsFreeTownWhiterun() && !IsHardcoreLocked
					SlaverunModFound = OPTION_FLAG_NONE
					If SlaverunAutoStart
						SlaverunFlag = OPTION_FLAG_NONE
					EndIf
				EndIf
			EndIf
		EndIf
		
		Int HalfNakedCoverFlag = OPTION_FLAG_DISABLED
		If HalfNakedEnable
			HalfNakedCoverFlag = OPTION_FLAG_NONE
		EndIf
		
		Int MinAvFlag = OPTION_FLAG_DISABLED
		If MinAvToggleT
			MinAvFlag = OPTION_FLAG_NONE
		EndIf
		
		Int DeviousInstalledFlag = OPTION_FLAG_DISABLED
		Int DeviousFlag = OPTION_FLAG_DISABLED
		If Game.GetModByName("Devious Devices - Expansion.esm") != 255
			DeviousInstalledFlag = OPTION_FLAG_NONE
			If DeviousEffectsEnable && !IsHardcoreLocked
				DeviousFlag = OPTION_FLAG_NONE
			EndIf
		EndIf

		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$SLS_hInfo")
		AddTextOption("$SLS_SurvivalScriptVersion", Main.Version, OPTION_FLAG_DISABLED)
		AddEmptyOption()
		
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$SLS_hImport_Export_Settings")
		ImportSettingsOID_T = AddTextOption("$SLS_ImportSettings", "")
		ExportSettingsOID_T = AddTextOption("$SLS_ExportSettings", "")
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hKeys")
		StorageUtil.SetIntValue(Self, "AioFavoriteDB", AddMenuOption("$SLS_AioFavoriteDB", AllInOne.Fav.AioFavorites[AllInOne.Fav.Favorite]))
		AllInOneKeyOID = AddKeyMapOption("$SLS_AllInOneKey", AllInOne.AioKey)
		StorageUtil.SetIntValue(Self, "AllInOneStatusKeyOID", AddKeyMapOption("$SLS_AllInOneStatusKey", AllInOne.StatusKey))
		StorageUtil.SetIntValue(Self, "OpenMouthKey", AddKeyMapOption("$SLS_OpenMouthKey", CumSwallow.OpenMouthKey))
		AddEmptyOption()

		AddHeaderOption("$SLS_hGeneralSettings1")
		StorageUtil.SetIntValue(Self, "SLS_CombatEquipEnableOID", AddToggleOption("$SLS_CombatEquipEnable", StorageUtil.GetIntValue(Self, "CombatEquipEnabled", Missing = 1) as Bool))
		DropItemsOID = AddToggleOption("$SLS_DropItems", DropItems)
		OrgasmRequiredOID = AddToggleOption("$SLS_OrgasmRequired", OrgasmRequired)
		HorseCostOIS_S = AddSliderOption("$SLS_HorseCost", SurvivalHorseCost, "$SLS_Gold", HardMode)
		StorageUtil.SetIntValue(Self, "GrowthWeightGainOID_S", AddSliderOption("$SLS_GrowthWeightGain", StorageUtil.GetFloatValue(Self, "WeightGainPerDay", Missing = 0.0), "{2}"))
		EasyBedTrapsOID = AddToggleOption("$SLS_EasyBedTraps", EasyBedTraps, HardMode)
		HardcoreModeOID = AddToggleOption("$SLS_HardcoreMode", HardcoreMode)
		DebugModeOID = AddToggleOption("$SLS_DebugMode", Init.DebugMode)
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hTraversal")
		StorageUtil.SetIntValue(Self, "SteepFall", AddToggleOption("$SLS_SteepFallEnable", StorageUtil.GetIntValue(Self, "SteepFallEnabled", Missing = 0)))
		BarefootMagOIS_S = AddSliderOption("$SLS_BarefootMag", BarefootMag, "{0}")
		StorageUtil.SetIntValue(Self, "BarefootStaggerChanceOID_S", AddSliderOption("$SLS_BarefootStaggerChance", StorageUtil.GetFloatValue(Self, "BarefootStaggerChance", Missing = 10.0), "{1}%", HardMode))
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hMinimumSpeed_CarryWeight")
		MinAvToggleOID = AddToggleOption("$SLS_MinAvToggle", MinAvToggleT)
		MinSpeedOID_S = AddSliderOption("$SLS_MinSpeed", MinSpeedMult, "{0}", MinAvFlag)
		MinCarryWeightOID_S = AddSliderOption("$SLS_MinCarryWeight", MinCarryWeight, "{0}", MinAvFlag)
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hNavigationOptions")
		CompassMechanicsOID = AddToggleOption("$SLS_CompassMechanics", CompassMechanics, HardMode)
		CompassHideMethodDB = AddMenuOption("$SLS_CompassHideMethodDB", CompassHideMethods[CompassHideMethod])
		FastTravelDisableOID = AddToggleOption("$SLS_FastTravelDisable", FastTravelDisable, HardMode)
		FtDisableIsNormalOID = AddToggleOption("$SLS_FtDisableIsNormal", FtDisableIsNormal)
		ReplaceMapsOID = AddToggleOption("$SLS_ReplaceMaps", ReplaceMaps)
		ReplaceMapsTimerOID_S = AddSliderOption("$SLS_ReplaceMapsTimer", ReplaceMapsTimer, "{0} Seconds")
		ConstructableMapAndCompassOID = AddToggleOption("$SLS_ConstructableMapAndCompass", _SLS_MapAndCompassRecipeEnable.GetValueInt(), HardMode)
		AddEmptyOption()
		
		AddHeaderOption("$SLS_TollCostGold")
		GoldWeightOID_S = AddSliderOption("$SLS_GoldWeight", GoldWeight, "{3}")
		FolGoldStealChanceOID_S = AddSliderOption("$SLS_FolGoldStealChance", FolGoldStealChance, "{0}%", HardMode)
		FolGoldSteamAmountOID_S = AddSliderOption("$SLS_FolGoldSteamAmount", FolGoldSteamAmount, "{0}%", HardMode)
		AddEmptyOption()
		
		AddHeaderOption("API ")
		LicShowApiBlockFormsOID_T = AddTextOption("$SLS_LicShowApiBlockForms", "")
		LicClearApiBlockFormsOID_T = AddTextOption("$SLS_LicClearApiBlockForms", "")
		AddEmptyOption()
		
		Int BondFurnFlag = OPTION_FLAG_DISABLED
		If BondFurnEnable && !IsHardcoreLocked
			BondFurnFlag = OPTION_FLAG_NONE
		EndIf
		
		Int DflowResistFlag = OPTION_FLAG_DISABLED
		If Dflow.GetDfVersion() >= 206.0
			DflowResistFlag = OPTION_FLAG_NONE
		EndIf

		SetCursorPosition(1)
		AddHeaderOption("$SLS_hDeviousFollowers")
		DflowResistLossOID_S = AddSliderOption("$SLS_DflowResistLoss", DflowResistLoss, "{1}", DflowResistFlag)
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hDeviousOptions")
		RunDevicePatchUpOID_T = AddTextOption("$SLS_RunDevicePatchUp", "", DeviousInstalledFlag)
		LicMagicChainCollarsOID = AddToggleOption("$SLS_LicMagicChainCollars", LicMagicChainCollars, DeviousInstalledFlag)
		DeviousGagDebuffOID_S = AddSliderOption("$SLS_DeviousGagDebuff", DeviousGagDebuff, "$SLS_Points", DeviousInstalledFlag)
		DeviousEffectsEnableOID = AddToggleOption("$SLS_DeviousEffectsEnable", DeviousEffectsEnable, DeviousInstalledFlag)
		StorageUtil.SetIntValue(Self, "DeviousDrowningOID", AddToggleOption("$SLS_DeviousDrowning", DeviousEffects.DeviousDrowning, DeviousInstalledFlag))
		DevEffLockpickDiffDB = AddMenuOption("$SLS_DevEffLockpickDiffDB", HeavyBondageDifficulty[DevEffLockpickDiff], DeviousFlag)
		DevEffPickpocketDiffDB = AddMenuOption("$SLS_DevEffPickpocketDiffDB", HeavyBondageDifficulty[DevEffPickpocketDiff], DeviousFlag)
		DevEffNoGagTradingOID = AddToggleOption("$SLS_DevEffNoGagTrading", DevEffNoGagTrading, DeviousFlag)
		BondFurnEnableOID = AddToggleOption("$SLS_BondFurnEnable", BondFurnEnable)
		BondFurnMilkFreqOID_S = AddSliderOption("$SLS_BondFurnMilkFreq", BondFurnMilkFreq, "$SLS_Seconds1", BondFurnFlag)
		BondFurnMilkFatigueMultOID_S = AddSliderOption("$SLS_BondFurnMilkFatigueMult", BondFurnMilkFatigueMult, "{1}x", BondFurnFlag)
		BondFurnMilkWillOID_S = AddSliderOption("$SLS_BondFurnMilkWill", BondFurnMilkWill, "{1}", BondFurnFlag)
		BondFurnFreqOID_S = AddSliderOption("$SLS_BondFurnFreq", BondFurnFreq, "$SLS_Seconds1", BondFurnFlag)
		BondFurnFatigueMultOID_S = AddSliderOption("$SLS_BondFurnFatigueMult", BondFurnFatigueMult, "{1}x", BondFurnFlag)
		BondFurnWillOID_S = AddSliderOption("$SLS_BondFurnWill", BondFurnWill, "{1}", BondFurnFlag)
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hHalfNakedCover")
		HalfNakedEnableOID = AddToggleOption("$SLS_HalfNakedEnable", HalfNakedEnable)
		HalfNakedStripsOID = AddToggleOption("$SLS_HalfNakedStrips", HalfNakedStrips)
		HalfNakedBraOID_S = AddSliderOption("$SLS_HalfNakedBra", HalfNakedBra, "{0}", HalfNakedCoverFlag)
		HalfNakedPantyOID_S = AddSliderOption("$SLS_HalfNakedPanty", HalfNakedPanty, "{0}", HalfNakedCoverFlag)
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hSLIFMaxScaling")
		StorageUtil.SetIntValue(Self, "SlifBreastScaleMaxOID_S", AddSliderOption("$SLS_SlifBreastScaleMax", Main.Slif.ScaleMaxBreasts, "{1}"))
		StorageUtil.SetIntValue(Self, "SlifBellyScaleMaxOID_S", AddSliderOption("$SLS_SlifBellyScaleMax", Main.Slif.ScaleMaxBelly, "{1}"))
		StorageUtil.SetIntValue(Self, "SlifAssScaleMaxOID_S", AddSliderOption("$SLS_SlifAssScaleMax", Main.Slif.ScaleMaxAss, "{1}"))
		AddEmptyOption()
		
		AddHeaderOption("Slaverun ")
		SlaverunAutoStartOID = AddToggleOption("$SLS_SlaverunAutoStart", SlaverunAutoStart, SlaverunModFound)
		SlaverunAutoMinOID_S = AddSliderOption("$SLS_SlaverunAutoMin", SlaverunAutoMin, "$SLS_Days", SlaverunFlag)
		SlaverunAutoMaxOID_S = AddSliderOption("$SLS_SlaverunAutoMax", SlaverunAutoMax, "$SLS_Days", SlaverunFlag)
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hHomeOptions")
		StorageUtil.SetIntValue(Self, "EasyHomeWhiterunOID", AddToggleOption("$EasyHomeWhiterun", !(Game.GetFormFromFile(0x112E32, "SL Survival.esp") as GlobalVariable).GetValueInt() as Bool))
		StorageUtil.SetIntValue(Self, "EasyHomeSolitudeOID", AddToggleOption("$EasyHomeSolitude", !(Game.GetFormFromFile(0x113395, "SL Survival.esp") as GlobalVariable).GetValueInt() as Bool))
		StorageUtil.SetIntValue(Self, "EasyHomeMarkarthOID", AddToggleOption("$EasyHomeMarkarth", !(Game.GetFormFromFile(0x113396, "SL Survival.esp") as GlobalVariable).GetValueInt() as Bool))
		StorageUtil.SetIntValue(Self, "EasyHomeWindhelmOID", AddToggleOption("$EasyHomeWindhelm", !(Game.GetFormFromFile(0x113397, "SL Survival.esp") as GlobalVariable).GetValueInt() as Bool))
		StorageUtil.SetIntValue(Self, "EasyHomeRiftenOID", AddToggleOption("$EasyHomeRiften", !(Game.GetFormFromFile(0x113398, "SL Survival.esp") as GlobalVariable).GetValueInt() as Bool))
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hHomePrices")
		StorageUtil.SetIntValue(Self, "HomeCostWhiterunOID_S", AddSliderOption("$HomeCostWhiterun", (Game.GetFormFromFile(0xF728B, "Skyrim.esm") as GlobalVariable).GetValueInt(), "{0} Gold"))
		StorageUtil.SetIntValue(Self, "HomeCostSolitudeOID_S", AddSliderOption("$HomeCostSolitude", (Game.GetFormFromFile(0xF728C, "Skyrim.esm") as GlobalVariable).GetValueInt(), "{0} Gold"))
		StorageUtil.SetIntValue(Self, "HomeCostMarkarthOID_S", AddSliderOption("$HomeCostMarkarth", (Game.GetFormFromFile(0xF728E, "Skyrim.esm") as GlobalVariable).GetValueInt(), "{0} Gold"))
		StorageUtil.SetIntValue(Self, "HomeCostWindhelmOID_S", AddSliderOption("$HomeCostWindhelm", (Game.GetFormFromFile(0xF728A, "Skyrim.esm") as GlobalVariable).GetValueInt(), "{0} Gold"))
		StorageUtil.SetIntValue(Self, "HomeCostRiftenOID_S", AddSliderOption("$HomeCostRiften", (Game.GetFormFromFile(0xF728D, "Skyrim.esm") as GlobalVariable).GetValueInt(), "{0} Gold"))
		AddEmptyOption()
		
	ElseIf(page == "$SLS_pSexEffects")
		Int FashionFlag = OPTION_FLAG_DISABLED
		If StorageUtil.GetFloatValue(None, "YPS_TweakVersion", Missing = -1.0) >= 1.0
			FashionFlag = OPTION_FLAG_NONE
		EndIf
		
		Int SexExpEnFlag = OPTION_FLAG_DISABLED
		Int SexCorruptionEnFlag = OPTION_FLAG_DISABLED
		Int DebugCorruptionFlag = OPTION_FLAG_DISABLED
		Int MinStamMagFlag = OPTION_FLAG_DISABLED
		If SexExpEn
			SexExpEnFlag = OPTION_FLAG_NONE
			If SexExpCorruption == 1
				SexCorruptionEnFlag = OPTION_FLAG_NONE
				If Init.DebugMode
					DebugCorruptionFlag = OPTION_FLAG_NONE
				EndIf
			EndIf
			If SexMinStamMagRates
				MinStamMagFlag = OPTION_FLAG_NONE
			EndIf
		EndIf
		
		Int DrugLactacidFlag = OPTION_FLAG_DISABLED
		If Game.GetModByName("MilkModNEW.esp") != 255 && !IsHardcoreLocked
			DrugLactacidFlag = OPTION_FLAG_NONE
		EndIf
		Int DrugSkoomaFlag = OPTION_FLAG_DISABLED
		If Game.GetModByName("SexLabSkoomaWhore.esp") != 255 && !IsHardcoreLocked
			DrugSkoomaFlag = OPTION_FLAG_NONE
		EndIf
		Int DrugInflateFlag = OPTION_FLAG_DISABLED
		If Game.GetModByName("SexLab Inflation Framework.esp") != 255 && !IsHardcoreLocked
			DrugInflateFlag = OPTION_FLAG_NONE
		EndIf
		Int DrugFmFertilityFlag = OPTION_FLAG_DISABLED
		If Game.GetModByName("Fertility Mode.esm") != 255 && !IsHardcoreLocked
			DrugFmFertilityFlag = OPTION_FLAG_NONE
		EndIf
		Int DrugSlenFlag = OPTION_FLAG_DISABLED
		If Game.GetModByName("SexLab Eager NPCs.esp") != 255 && !IsHardcoreLocked
			DrugSlenFlag = OPTION_FLAG_NONE
		EndIf
		
		Int FondleAddFlag = OPTION_FLAG_DISABLED
		Int FondleRemoveFlag = OPTION_FLAG_DISABLED
		ObjectReference CrossHairRef = Game.GetCurrentCrosshairRef()
		VoiceType Voice
		If CrossHairRef as Actor && Init.SlsCreatureEvents
			If (CrossHairRef as Actor).GetRace().IsRaceFlagSet(0)
				Voice = CrossHairRef.GetVoiceType()
				If Voice
					If _SLS_FondleableVoices.HasForm(Voice)
						FondleRemoveFlag = OPTION_FLAG_NONE
					Else
						FondleAddFlag = OPTION_FLAG_NONE
					EndIf
				EndIf
			EndIf
		EndIf
		
		Int WildlingFlag = OPTION_FLAG_DISABLED
		If Init.SlsCreatureEvents && AnimalBreedEnable
			WildlingFlag = OPTION_FLAG_NONE
		EndIf
		
		Int OrgasmFatigueFlag = OPTION_FLAG_DISABLED
		If StorageUtil.GetIntValue(Self, "OrgasmFatigue", Missing = 1) == 1
			OrgasmFatigueFlag = OPTION_FLAG_NONE
		EndIf
		
		SetCursorFillMode(TOP_TO_BOTTOM)
		
		AddHeaderOption("$SLS_hSexExperience_Effects")
		;StorageUtil.SetIntValue(Self, "AhegaoEnableOID", AddToggleOption("$SLS_AhegaoEnable", StorageUtil.GetIntValue(Self, "AhegaoEnable", Missing = 1)))
		SexExpEnableOID = AddToggleOption("$SLS_SexExpEnable", SexExpEn)
		SexExpCorruptionDB = AddMenuOption("$SLS_SexExpCorruptionDB", SexExpCreatureCorruption[SexExpCorruption], SexExpEnFlag)
		DremoraCorruptionOID = AddToggleOption("$SLS_DremoraCorruption", DremoraCorruption, SexExpEnFlag)
		SexExpCorruptionCurrentOID_S = AddSliderOption("$SLS_SexExpCorruptionCurrent", StorageUtil.GetFloatValue(None, "_SLS_CreatureCorruption", Missing = 0.0), "$SLS_Points", DebugCorruptionFlag)
		CockSizeBonusEnjFreqOID_S = AddSliderOption("$SLS_CockSizeBonusEnjFreq", CockSizeBonusEnjFreq, "$SLS_Sec", SexCorruptionEnFlag)
		RapeForcedSkoomaChanceOID_S = AddSliderOption("$SLS_RapeForcedSkoomaChance", RapeForcedSkoomaChance, "{0}%", SexExpEnFlag)
		RapeMinArousalOID_S = AddSliderOption("$SLS_RapeMinArousal", RapeMinArousal, "{0}", SexExpEnFlag)
		SexExpResetStatsOID_T = AddTextOption("$SLS_SexExpResetStats", "", SexExpEnFlag)
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hJiggles")
		StorageUtil.SetIntValue(Self, "JigglesOID", AddToggleOption("$SLS_Jiggles", StorageUtil.GetIntValue(Self, "Jiggles", Missing = 1)))
		StorageUtil.SetIntValue(Self, "JigglesVisualsOID", AddToggleOption("$SLS_JigglesVisuals", (Game.GetFormFromFile(0x0CF9B1, "SL Survival.esp") as _SLS_BodyInflationTracking).DoImod))
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hCompulsiveSex")
		StorageUtil.SetIntValue(Self, "CompulsiveSexOID", AddToggleOption("$SLS_hCompulsiveSex", StorageUtil.GetIntValue(Self, "CompulsiveSex", Missing = 0)))
		StorageUtil.SetIntValue(Self, "CompulsiveSexFuckTimeOID_S", AddSliderOption("$SLS_CompulsiveSexFuckTime", (Game.GetFormFromFile(0x0E7553, "SL Survival.esp") as _SLS_CompulsiveSex).TimeBetweenFucks, "{1}x"))
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hOrgasmFatigue")
		StorageUtil.SetIntValue(Self, "OrgasmFatigueOID", AddToggleOption("$SLS_hOrgasmFatigue", StorageUtil.GetIntValue(Self, "OrgasmFatigue", Missing = 1)))
		;StorageUtil.SetIntValue(Self, "OrgasmFatigueThresholdOID_S", AddSliderOption("$SLS_OrgasmFatigueThreshold", (Game.GetFormFromFile(0x0E857D, "SL Survival.esp") as _SLS_OrgasmFatigue).OrgasmThreshold, "{0}", OrgasmFatigueFlag))
		StorageUtil.SetIntValue(Self, "OrgasmFatigueRecoveryOID_S", AddSliderOption("$SLS_OrgasmFatigueRecovery", (Game.GetFormFromFile(0x0E857D, "SL Survival.esp") as _SLS_OrgasmFatigue).OrgasmRecoveryPerHour, "{1}", OrgasmFatigueFlag))
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hAhegao")
		StorageUtil.SetIntValue(Self, "AhegaoEnableOID", AddToggleOption("$SLS_AhegaoEnable", StorageUtil.GetIntValue(Self, "AhegaoEnable", Missing = 1)))
		StorageUtil.SetIntValue(Self, "AhegaoDurPerOrgasmOID_S", AddSliderOption("$SLS_AhegaoDurPerOrgasm", (Game.GetFormFromFile(0x0FCE71, "SL Survival.esp") as _SLS_Ahegao).DurPerOrgasm, "{1}"))
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hMinimumSexStamina_Magicka")
		SexMinStamMagRatesOID = AddToggleOption("$SLS_SexMinStamMagRates", SexMinStamMagRates, SexExpEnFlag)
		SexMinStaminaRateOID_S = AddSliderOption("$SLS_SexMinStaminaRate", SexMinStaminaRate, "{1}", MinStamMagFlag)
		SexMinStaminaMultOID_S = AddSliderOption("$SLS_SexMinStaminaMult", SexMinStaminaMult, "{0}", MinStamMagFlag)
		SexMinMagickaRateOID_S = AddSliderOption("$SLS_SexMinMagickaRate", SexMinMagickaRate, "{1}", MinStamMagFlag)
		SexMinMagickaMultOID_S = AddSliderOption("$SLS_SexMinMagickaMult", SexMinMagickaMult, "{0}", MinStamMagFlag)
		SexRapeDrainsAttributesOID = AddToggleOption("$SLS_SexRapeDrainsAttributes", RapeDrainsAttributes, SexExpEnFlag)
		AddEmptyOption()
		
		SetCursorPosition(1)
		AddHeaderOption("$SLS_hCreatureSettings")
		SlsCreatureEventOID = AddToggleOption("$SLS_SlsCreatureEvent", Init.SlsCreatureEvents)
		AddFondleToListOID_T = AddTextOption("$SLS_AddFondleToList" + CrosshairRefString, "", FondleAddFlag)
		RemoveFondleFromListOID_T = AddTextOption("$SLS_RemoveFondleFromList" + CrosshairRefString, "", FondleRemoveFlag)
		FondleInfoOID_T = AddTextOption("$SLS_FondleInfo", Util.CreatureFondleCount as Int)
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hWildling")
		AnimalBreedEnableOID = AddToggleOption("$SLS_WildlingEnable", AnimalBreedEnable, CreatureEventsFlag)
		StorageUtil.SetIntValue(Self, "WildlingPointsLossRate", AddSliderOption("$SLS_WildlingPointsLossRate", AnimalFriend.Wildling.WildlingPointsLossPerRank, "{1}x", WildlingFlag))
		StorageUtil.SetIntValue(Self, "AllurePerLevel", AddSliderOption("$SLS_AllurePerLevel", AnimalFriend.Wildling.AllurePointsPerLevel, "{1}", WildlingFlag))
		AddEmptyOption()
		
		AfCooloffBaseOID_S = AddSliderOption("$SLS_AfCooloffBase", AnimalFriend.BreedingCooloffBase, "$SLS_Hours1", WildlingFlag)
		AfCooloffBodyCumOID_S = AddSliderOption("$SLS_AfCooloffBodyCum", AnimalFriend.BreedingCooloffCumCovered, "$SLS_Hours1", WildlingFlag)
		AfCooloffCumInflationOID_S = AddSliderOption("$SLS_fCooloffCumInflation", AnimalFriend.BreedingCooloffCumFilled, "$SLS_Hours1", WildlingFlag)
		AfCooloffCumSwallowOID_S = AddSliderOption("$SLS_AfCooloffCumSwallow", AnimalFriend.SwallowBonus, "$SLS_Hours1", WildlingFlag)
		AfCooloffPregnancyOID_S = AddSliderOption("$SLS_AfCooloffPregnancy", AnimalFriend.BreedingCooloffPregnancy, "$SLS_Hours1", WildlingFlag)
		String FriendRef = "None "
		ObjectReference ObjRef = (_SLS_AnimalFriendAliases.GetNthAlias(0) as ReferenceAlias).GetReference()
		If ObjRef != None
			;Debug.Messagebox(ObjRef)
			FriendRef = ObjRef.GetBaseObject().GetName() + " - " + StringUtil.Substring(ObjRef, StringUtil.Find(ObjRef, "(", 0) + 1, len = 8)
		EndIf
		AddTextOption("Animal Friend 0: " + FriendRef, "", WildlingFlag)
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hRapeDrugs")
		StorageUtil.SetIntValue(Self, "RapeDrugLactacidOID", AddToggleOption("$SLS_TollDrugLactacid", ForceDrug.RapeDrugLactacid, DrugLactacidFlag))
		StorageUtil.SetIntValue(Self, "RapeDrugSkoomaOID", AddToggleOption("$SLS_TollDrugSkooma", ForceDrug.RapeDrugSkooma, DrugSkoomaFlag))
		StorageUtil.SetIntValue(Self, "RapeDrugCumHumanOID", AddToggleOption("$SLS_RapeDrugCumHuman", ForceDrug.RapeDrugHumanCum, HardMode))
		StorageUtil.SetIntValue(Self, "RapeDrugCumCreatureOID", AddToggleOption("$SLS_RapeDrugCumCreature", ForceDrug.RapeDrugCreatureCum, HardMode))
		StorageUtil.SetIntValue(Self, "RapeDrugInflateOID", AddToggleOption("$SLS_RapeDrugInflate", ForceDrug.RapeDrugInflate, DrugInflateFlag))
		StorageUtil.SetIntValue(Self, "RapeDrugFmFertilityOID", AddToggleOption("$SLS_RapeDrugFmFertility", ForceDrug.RapeDrugFmFertility, DrugFmFertilityFlag))
		StorageUtil.SetIntValue(Self, "RapeDrugSlenAphrodisiacOID", AddToggleOption("$SLS_RapeDrugSlenAphrodisiac", ForceDrug.RapeDrugSlenAphrodisiac, DrugSlenFlag))
		StorageUtil.SetIntValue(Self, "RapeDrugSensitivityOID", AddToggleOption("$SLS_RapeDrugSensitivity", ForceDrug.RapeDrugSensitivity, HardMode))
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hFashionRape")
		StorageUtil.SetIntValue(Self, "FashionRapeHaircutChanceOID_S", AddSliderOption("$SLS_FashionRapeHaircutChance", FashionRape.HaircutChance, "{1}%", FashionFlag))
		StorageUtil.SetIntValue(Self, "FashionRapeHairCutMinOID_S", AddSliderOption("$SLS_FashionRapeHairCutMin", FashionRape.HairCutMinLevel, "$SLS_Stages", FashionFlag))
		StorageUtil.SetIntValue(Self, "FashionRapeHairCutMaxOID_S", AddSliderOption("$SLS_FashionRapeHairCutMax", FashionRape.HairCutMaxLevel, "$SLS_Stages", FashionFlag))
		StorageUtil.SetIntValue(Self, "FashionRapeHairCutFloorOID_S", AddSliderOption("$SLS_FashionRapeHairCutFloor", FashionRape.HaircutFloor, "$SLS_Stage", FashionFlag))
		StorageUtil.SetIntValue(Self, "FashionRapeDyeHairChanceOID_S", AddSliderOption("$SLS_FashionRapeDyeHairChance", FashionRape.DyeHairChance, "{1}%", FashionFlag))
		StorageUtil.SetIntValue(Self, "FashionRapeShavePussyChanceOID_S", AddSliderOption("$SLS_FashionRapeShavePussyChance", FashionRape.ShavePussyChance, "{1}%", FashionFlag))
		StorageUtil.SetIntValue(Self, "FashionRapeLipstickChanceOID_S", AddSliderOption("$SLS_FashionRapeLipstickChance", FashionRape.SmudgeLipstickChance, "{1}%", FashionFlag))
		StorageUtil.SetIntValue(Self, "FashionRapeEyeshadowChanceOID_S", AddSliderOption("$SLS_FashionRapeEyeshadowChance", FashionRape.SmudgeEyeshadowChance, "{1}%", FashionFlag))
		AddEmptyOption()
		
	ElseIf(page == "$SLS_pMisogynyInequality")
		Int StaInstalledFlag = OPTION_FLAG_DISABLED
		Int ProxSpankOptionsFlag = OPTION_FLAG_DISABLED
		If Game.GetModByName("Spank That Ass.esp") != 255
			StaInstalledFlag = OPTION_FLAG_NONE
			If ProxSpankNpcType != 5
				ProxSpankOptionsFlag = OPTION_FLAG_NONE
			EndIf
		EndIf

		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$SLS_hGeneralSettings2")
		GreetDistOIS_S = AddSliderOption("$SLS_GreetDist", Game.GetGameSettingFloat("fAIMinGreetingDistance"), "{0}")
		CoverMyselfMechanicsOID = AddToggleOption("$SLS_CoverMyselfMechanics", CoverMyselfMechanics)
		StorageUtil.SetIntValue(Self, "NpcCommentsOID", AddToggleOption("$SLS_NpcComments", (Game.GetFormFromFile(0x0DF88F, "SL Survival.esp") as GlobalVariable).GetValueInt())) ; _SLS_NpcComments
		PushEventsDB = AddMenuOption("$SLS_PushEventsDB", PushEventsType[PushEvents], 0)
		StorageUtil.SetIntValue(Self, "PushCooldownOID_S", AddSliderOption("$SLS_PushCooldown", (Game.GetFormFromFile(0x0E651A, "SL Survival.esp") as _SLS_PushPlayerCooloff).CooloffPeriod, "$SLS_Hours1"))
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hCatCalling")
		CatCallVolOIS_S = AddSliderOption("$SLS_CatCallVol", CatCallVol, "{0}%")
		CatCallWillLossOIS_S = AddSliderOption("$SLS_CatCallWillLoss", CatCallWillLoss, "{0}")
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hSurvivalAssSlapping")
		AssSlappingOID = AddToggleOption("$SLS_AssSlapping", AssSlappingEvents)
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hSpankThatAssSlapping")
		AssSlapResistLossOID_S = AddSliderOption("$SLS_AssSlapResistLoss", AssSlapResistLoss, "{0}")
		ProxSpankNpcDB = AddMenuOption("$SLS_ProxSpankNpcDB", ProxSpankNpcList[ProxSpankNpcType], StaInstalledFlag)
		ProxSpankCoverDB = AddMenuOption("$SLS_ProxSpankCoverDB", ProxSpankRequiredCoverList[_SLS_ProxSpankRequiredCover.GetValueInt()], ProxSpankOptionsFlag)
		ProxSpankCooloffOID_S = AddSliderOption("$SLS_ProxSpankCooloff", ProxSpankCooloff, "$SLS_Seconds0", ProxSpankOptionsFlag)
		ProxSpankCommentOID = AddToggleOption("$SLS_ProxSpankComment", Util.ProxSpankComment, ProxSpankOptionsFlag)
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hGuardBehaviour")
		GuardCommentsOID = AddToggleOption("$SLS_GuardComments", GuardComments)
		GuardBehavLockpickingOID = AddToggleOption("$SLS_GuardBehavLockpicking", GuardBehavLockpicking, HardMode)
		GuardBehavDrugsOID = AddToggleOption("$SLS_TollCostDrugs", GuardBehavDrugs, HardMode)
		GuardBehavShoutOID = AddToggleOption("$SLS_GuardBehavShout", _SLS_GuardBehavShoutEn.GetValueInt() as Bool, HardMode)
		GuardBehavWeapDropOID = AddToggleOption("$SLS_GuardBehavWeapDrop", _SLS_GuardBehavWeapDropEn.GetValueInt() as Bool, HardMode)
		GuardBehavWeapDrawnOID = AddToggleOption("$SLS_GuardBehavWeapDrawn", GuardBehavWeapDrawn, HardMode)
		GuardBehavWeapEquipOID = AddToggleOption("$SLS_GuardBehavWeapEquip", GuardBehavWeapEquip, HardMode)
		GuardBehavArmorEquipOID = AddToggleOption("$SLS_GuardBehavArmorEquip", GuardBehavArmorEquip, HardMode)
		StorageUtil.SetIntValue(Self, "GuardBehavArmorEquipAnyArmorOID", AddToggleOption("$SLS_GuardBehavArmorEquipAnyArmor", StorageUtil.GetIntValue(Self, "GuardBehavArmorEquipAnyArmor", Missing = 0), HardMode))
		AddEmptyOption()

		Int IneqStatsFlag = OPTION_FLAG_DISABLED
		If _SLS_IneqStat.GetValueInt() == 1 && !IsHardcoreLocked
			IneqStatsFlag = OPTION_FLAG_NONE
		EndIf
		
		Int IneqCarryFlag = OPTION_FLAG_DISABLED
		If _SLS_IneqCarry.GetValueInt() == 1 && !IsHardcoreLocked
			IneqCarryFlag = OPTION_FLAG_NONE
		EndIf
		
		Int IneqSpeedFlag = OPTION_FLAG_DISABLED
		If _SLS_IneqSpeed.GetValueInt() == 1 && !IsHardcoreLocked
			IneqSpeedFlag = OPTION_FLAG_NONE
		EndIf
		
		Int IneqDamageFlag = OPTION_FLAG_DISABLED
		If _SLS_IneqDamage.GetValueInt() == 1 && !IsHardcoreLocked
			IneqDamageFlag = OPTION_FLAG_NONE
		EndIf
		Int IneqDestFlag = OPTION_FLAG_DISABLED
		If _SLS_IneqDestruction.GetValueInt() == 1 && !IsHardcoreLocked
			IneqDestFlag = OPTION_FLAG_NONE
		EndIf
		
		String StrongFemString = "$SLS_RemoveStrongFemale"
		String CrosshairRefName
		Int CrossHairRefFlag = OPTION_FLAG_DISABLED
		Actor CrossHairRef = Game.GetCurrentCrosshairRef() as Actor
		If CrossHairRef && CrossHairRef.GetLeveledActorBase().GetSex() == 1
			CrosshairRefName = CrossHairRef.GetLeveledActorBase().GetName()
			CrossHairRefFlag = OPTION_FLAG_NONE
			If !CrossHairRef.IsInFaction(_SLS_IneqStrongFemaleFact)
				StrongFemString = "$SLS_AddStrongFemale"
			EndIf
		EndIf
		
		SetCursorPosition(1)
		AddHeaderOption("$SLS_hInequality")
		IneqStatsOID = AddToggleOption("$SLS_IneqStatsChange", _SLS_IneqStat.GetValueInt(), HardMode)
		IneqStatsValOID = AddSliderOption("$SLS_IneqStatsVal", IneqStatsVal, "$SLS_Points", IneqStatsFlag)
		IneqHealthCushionOID = AddSliderOption("$SLS_IneqHealthCushion", IneqHealthCushion, "$SLS_Points", IneqStatsFlag)
		IneqCarryOID = AddToggleOption("$SLS_IneqCarryChange", _SLS_IneqCarry.GetValueInt(), HardMode)
		IneqCarryValOID = AddSliderOption("$SLS_IneqCarryVal", IneqCarryVal, "$SLS_Points", IneqCarryFlag)
		InqSpeedOID = AddToggleOption("$SLS_InqSpeedChange", _SLS_IneqSpeed.GetValueInt(), HardMode)
		IneqSpeedValOID = AddSliderOption("$SLS_IneqSpeedVal", IneqSpeedVal, "$SLS_Points", IneqSpeedFlag)
		IneqDamageOID = AddToggleOption("$SLS_IneqDamageChange", _SLS_IneqDamage.GetValueInt(), HardMode)
		IneqDamageValOID = AddSliderOption("$SLS_IneqDamageVal", IneqDamageVal, "{1}%", IneqDamageFlag)
		IneqDestOID = AddToggleOption("$SLS_IneqDestChange", _SLS_IneqDestruction.GetValueInt(), HardMode)
		IneqDestValOID = AddSliderOption("$SLS_IneqDestVal", IneqDestVal, "{1}%", IneqDestFlag)
		IneqSkillsOID = AddToggleOption("$SLS_IneqSkills", InequalitySkills, HardMode)
		IneqBuySellOID = AddToggleOption("$SLS_IneqBuySell", InequalityBuySell, HardMode)
		IneqVendorGoldOID = AddSliderOption("$SLS_IneqVendorGold", IneqFemaleVendorGoldMult, "{2}x", HardMode)
		IneqStrongFemaleFollowersOID = AddToggleOption("$SLS_IneqStrongFemaleFollowers", IneqStrongFemaleFollowers, HardMode)
		ModStrongFemaleOID_T = AddTextOption(StrongFemString, CrosshairRefName, CrossHairRefFlag)
		AddEmptyOption()
		
	ElseIf page == "$SLS_pTrauma"
		SetCursorFillMode(TOP_TO_BOTTOM)
		Int TraumaFlag = OPTION_FLAG_DISABLED
		If Trauma.TraumaEnable
			TraumaFlag = OPTION_FLAG_NONE
		EndIf
		Int DynamicTraumaFlag = OPTION_FLAG_DISABLED
		If Trauma.TraumaEnable && Trauma.DynamicTrauma
			DynamicTraumaFlag = OPTION_FLAG_NONE
		EndIf

		Actor akTarget = Game.GetCurrentCrosshairRef() as Actor
		Int ValidTargetFlag = OPTION_FLAG_DISABLED
		String AddRemoveString = "Track "
		String FollowerName = "No Target"
		String IsDynamicNpc = ""
		If Trauma.TraumaEnable && akTarget && akTarget.IsInFaction(Game.GetFormFromFile(0x05C84D, "Skyrim.esm") as Faction) ; PotentialFollowerFaction
			ValidTargetFlag = OPTION_FLAG_NONE
			FollowerName = akTarget.GetLeveledActorBase().GetName()
			If akTarget.IsInFaction(Trauma._SLS_TraumaFaction)
				AddRemoveString = "Untrack "
			EndIf
			If StorageUtil.FormListHas(Trauma._SLS_TraumaDynamicQuest, "_SLS_TraumaActors", akTarget)
				IsDynamicNpc = " - Dynamic"
			EndIf
		EndIf
		
		AddHeaderOption("$SLS_hGeneral")
		StorageUtil.SetIntValue(Self, "TraumaPainSoundVolOID_S", AddSliderOption("$SLS_TraumaPainSoundVol", Util.PainSoundVol * 100.0, "{0}%"))
		StorageUtil.SetIntValue(Self, "TraumaHitSoundVolOID_S", AddSliderOption("$SLS_TraumaHitSoundVol", Util.HitSoundVol * 100.0, "{0}%"))
		StorageUtil.SetIntValue(Self, "TraumaPlayerSqueaksOID", AddToggleOption("$SLS_TraumaPlayerSqueaks", Trauma.PlayerSqueaks, TraumaFlag))
		AddEmptyOption()
		
		AddHeaderOption("$SLS_pTrauma")
		StorageUtil.SetIntValue(Self, "TraumaEnableOID", AddToggleOption("$SLS_TraumaEnable", Trauma.TraumaEnable))
		StorageUtil.SetIntValue(Self, "TraumaRebuildTexturesOID_T", AddTextOption("$SLS_TraumaRebuildTextures", "", TraumaFlag))
		StorageUtil.SetIntValue(Self, "TraumaDynamicOID", AddToggleOption("$SLS_TraumaDynamic", Trauma.DynamicTrauma, TraumaFlag))
		StorageUtil.SetIntValue(Self, "TraumaDynamicCombatOID", AddToggleOption("$SLS_TraumaDynamicCombat", Trauma.DynamicCombat, DynamicTraumaFlag))
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hAssignFollowers")
		StorageUtil.SetIntValue(Self, "TraumaTrackFollowerOID_T", AddTextOption(FollowerName + IsDynamicNpc, AddRemoveString, ValidTargetFlag))
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hTrackedFollowers")
		Quest TraumaAssignedQuest = Game.GetFormFromFile(0x0F3D04, "SL Survival.esp") as Quest
		
		Int i = 0
		While i < TraumaAssignedQuest.GetNumAliases()
			akTarget = (TraumaAssignedQuest.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
			If akTarget
				AddTextOption(akTarget.GetLeveledActorBase().GetName(), "", TraumaFlag)
			Else
				AddTextOption("Empty ", "", TraumaFlag)
			EndIf
			i += 1
		EndWhile
		
		SetCursorPosition(1)
		AddHeaderOption("$SLS_hMaxNumberOfTraumas")
		StorageUtil.SetIntValue(Self, "TraumaCountMaxPlayerOID_S", AddSliderOption("$SLS_TraumaCountMaxPlayer", Trauma.PlayerTraumaCountMax, "{0}", TraumaFlag))
		StorageUtil.SetIntValue(Self, "TraumaCountMaxFollowerOID_S", AddSliderOption("$SLS_raumaCountMaxFollower", Trauma.FollowerTraumaCountMax, "{0}", TraumaFlag))
		StorageUtil.SetIntValue(Self, "TraumaCountMaxNpcOID_S", AddSliderOption("$SLS_TraumaCountMaxNpc", Trauma.NpcTraumaCountMax, "{0}", TraumaFlag))
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hOpacityDuration")
		StorageUtil.SetIntValue(Self, "TraumaStartingOpacityOID_S", AddSliderOption("$SLS_TraumaStartingOpacity", Trauma.StartingAlpha * 100.0, "{0}%", TraumaFlag))
		StorageUtil.SetIntValue(Self, "TraumaMaximumOpacityOID_S", AddSliderOption("$SLS_TraumaMaximumOpacity", Trauma.MaxAlpha * 100.0, "{0}%", TraumaFlag))
		StorageUtil.SetIntValue(Self, "TraumaHoursToFadeInOID_S", AddSliderOption("$SLS_TraumaHoursToFadeIn", Trauma.HoursToMaxAlpha, "$SLS_Hours0", TraumaFlag))
		StorageUtil.SetIntValue(Self, "TraumaHoursToFadeOutOID_S", AddSliderOption("$SLS_TraumaHoursToFadeOut", Trauma.HoursToFadeOut, "$SLS_Hours0", TraumaFlag))
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hSexTrauma")
		StorageUtil.SetIntValue(Self, "TraumaSexChancePlayerOID_S", AddSliderOption("$SLS_TraumaSexChancePlayer", Trauma.SexChancePlayer, "{0}%", TraumaFlag))
		StorageUtil.SetIntValue(Self, "TraumaSexChanceFollowerOID_S", AddSliderOption("$SLS_TraumaSexChanceFollower", Trauma.SexChanceFollower, "{0}%", TraumaFlag))
		StorageUtil.SetIntValue(Self, "TraumaSexChanceOID_S", AddSliderOption("$SLS_TraumaSexChance", Trauma.SexChanceNpc, "{0}%", TraumaFlag))
		AddEmptyOption()
		StorageUtil.SetIntValue(Self, "TraumaSexHitsPlayerOID_S", AddSliderOption("$SLS_TraumaSexHitsPlayer", Trauma.SexHitsPlayer, "$SLS_Hits", TraumaFlag))
		StorageUtil.SetIntValue(Self, "TraumaSexHitsFollowerOID_S", AddSliderOption("$SLS_TraumaSexHitsFollower", Trauma.SexHitsFollower, "$SLS_Hits", TraumaFlag))
		StorageUtil.SetIntValue(Self, "TraumaSexHitsOID_S", AddSliderOption("$SLS_TraumaSexHits", Trauma.SexHitsNpc, "$SLS_Hits", TraumaFlag))
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hCombatTrauma")
		StorageUtil.SetIntValue(Self, "TraumaDamageThresholdOID_S", AddSliderOption("$SLS_TraumaDamageThreshold", Trauma.CombatDamageThreshold, "$SLS_Points", TraumaFlag))
		StorageUtil.SetIntValue(Self, "TraumaCombatChancePlayerOID_S", AddSliderOption("$SLS_TraumaSexChancePlayer", Trauma.CombatChancePlayer, "{0}%", TraumaFlag))
		StorageUtil.SetIntValue(Self, "TraumaCombatChanceFollowerOID_S", AddSliderOption("$SLS_TraumaSexChanceFollower", Trauma.CombatChanceFollower, "{0}%", TraumaFlag))
		StorageUtil.SetIntValue(Self, "TraumaCombatChanceOID_S", AddSliderOption("$SLS_TraumaSexChance", Trauma.CombatChanceNpc, "{0}%", TraumaFlag))
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hPushTraumas")
		StorageUtil.SetIntValue(Self, "TraumaPushChancePlayerOID_S", AddSliderOption("$SLS_TraumaPushChancePlayer", Trauma.PushChance, "{0}%", TraumaFlag))
		AddEmptyOption()

	ElseIf page == "$SLS_pNeeds"
		
		; Flags
		Int RndFlag = OPTION_FLAG_DISABLED
		Int IneedFlag = OPTION_FLAG_DISABLED
		Int EatingSleepingDrinkingFlag = OPTION_FLAG_DISABLED
		Int BellyNeedsMod = OPTION_FLAG_DISABLED
		Int AnyNeedsMod = OPTION_FLAG_DISABLED
		Int BellyScaleRndFlag = OPTION_FLAG_DISABLED
		Int BellyScaleIneedFlag = OPTION_FLAG_DISABLED

		If Game.GetModByName("RealisticNeedsandDiseases.esp") != 255
			RndFlag = OPTION_FLAG_NONE
		EndIf
		If Game.GetModByName("iNeed.esp") != 255
			IneedFlag = OPTION_FLAG_NONE
		EndIf
		If Game.GetModByName("EatingSleepingDrinking.esp") != 255
			EatingSleepingDrinkingFlag = OPTION_FLAG_NONE
		EndIf
		If RndFlag == OPTION_FLAG_NONE || IneedFlag == OPTION_FLAG_NONE
			BellyNeedsMod = OPTION_FLAG_NONE
		EndIf
		If RndFlag == OPTION_FLAG_NONE || IneedFlag == OPTION_FLAG_NONE || EatingSleepingDrinkingFlag == OPTION_FLAG_NONE
			AnyNeedsMod = OPTION_FLAG_NONE
		EndIf
		
		If BellyScaleEnable && RndFlag == OPTION_FLAG_NONE
			BellyScaleRndFlag = OPTION_FLAG_NONE
		EndIf
		If BellyScaleEnable && IneedFlag == OPTION_FLAG_NONE
			BellyScaleIneedFlag = OPTION_FLAG_NONE
		EndIf
	
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$SLS_hGluttony")
		GluttedSpeedMultOID_S = AddSliderOption("$SLS_GluttedSpeedMult", GluttedSpeed, "{0}", RndFlag)
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hSleepDeprivation")
		SleepDeprivOID = AddToggleOption("$SLS_SleepDepriv", SleepDepriv)
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hBellyScaling")
		BellyScaleEnableOID = AddToggleOption("$SLS_BellyScaleEnable", BellyScaleEnable, BellyNeedsMod)
		BaseBellyScaleOID_S = AddSliderOption("$SLS_BaseBellyScale", Needs.BaseBellyScale, "{1}", BellyNeedsMod)
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hRndBellyScaling")
		BellyScaleRnd00OID_S = AddSliderOption("$SLS_BellyScaleRnd00", Rnd.BellyScaleRnd00, "{2}", BellyScaleRndFlag)
		BellyScaleRnd01OID_S = AddSliderOption("$SLS_BellyScaleRnd01", Rnd.BellyScaleRnd01, "{2}", BellyScaleRndFlag)
		BellyScaleRnd02OID_S = AddSliderOption("$SLS_BellyScaleRnd02", Rnd.BellyScaleRnd02, "{2}", BellyScaleRndFlag)
		BellyScaleRnd03OID_S = AddSliderOption("$SLS_BellyScaleRnd03", Rnd.BellyScaleRnd03, "{2}", BellyScaleRndFlag)
		BellyScaleRnd04OID_S = AddSliderOption("$SLS_BellyScaleRnd04", Rnd.BellyScaleRnd04, "{2}", BellyScaleRndFlag)
		BellyScaleRnd05OID_S = AddSliderOption("$SLS_BellyScaleRnd05", Rnd.BellyScaleRnd05, "{2}", BellyScaleRndFlag)
		
		SetCursorPosition(1)
		AddHeaderOption("$SLS_hFatigueAndDrugs")
		SkoomaSleepOID_S = AddSliderOption("$SLS_SkoomaSleep", SkoomaSleep, "$SLS_xMore", AnyNeedsMod)
		MilkSleepMultOID_S = AddSliderOption("$SLS_MilkSleepMult", MilkSleepMult, "$SLS_xMore", AnyNeedsMod)
		DrugEndFatigueIncOID_S = AddSliderOption("$SLS_DrugEndFatigueInc", DrugEndFatigueInc * 100.0, "{0}% ", AnyNeedsMod)
		AddEmptyOption()
		
		AddHeaderOption("$SLS_pCum")
		CumFoodMultOID_S = AddSliderOption("$SLS_CumFoodMult", Needs.CumFoodMult, "$SLS_xMoreFood", AnyNeedsMod)
		CumDrinkMultOID_S = AddSliderOption("$SLS_CumFoodMult", Needs.CumDrinkMult, "$SLS_xMoreWater", AnyNeedsMod)
		SaltyCumOID = AddToggleOption("$SLS_SaltyCum", SaltyCum, AnyNeedsMod)
		AddEmptyOption()
		
		SetCursorPosition(21)
		AddHeaderOption("$SLS_hiNeedBellyScaling")
		BellyScaleIneed00OID_S = AddSliderOption("$SLS_BellyScaleRnd01", Ineed.BellyScaleIneed00, "{2}", BellyScaleIneedFlag)
		BellyScaleIneed01OID_S = AddSliderOption("$SLS_BellyScaleIneed01", Ineed.BellyScaleIneed01, "{2}", BellyScaleIneedFlag)
		BellyScaleIneed02OID_S = AddSliderOption("$SLS_BellyScaleIneed02", Ineed.BellyScaleIneed02, "{2}", BellyScaleIneedFlag)
		BellyScaleIneed03OID_S = AddSliderOption("$SLS_BellyScaleIneed03", Ineed.BellyScaleIneed03, "{2}", BellyScaleIneedFlag)
		AddEmptyOption()
		
	ElseIf(page == "$SLS_pCum")
		Int CumEffectsFlag = OPTION_FLAG_DISABLED
		If CumEffectsEnable
			CumEffectsFlag = OPTION_FLAG_NONE
		EndIf
		
		Int CumSwallowInflateFlag = OPTION_FLAG_DISABLED
		If Game.GetModByName("sr_FillHerUp.esp") != 255
			CumSwallowInflateFlag = OPTION_FLAG_NONE
		EndIf
		
		Int MmeInstalledFlag = OPTION_FLAG_DISABLED
		If Game.GetModByName("MilkModNEW.esp") != 255
			MmeInstalledFlag = OPTION_FLAG_NONE
		EndIf
		
		Int CumAddictionFlag = OPTION_FLAG_DISABLED
		Int CumAddictHungerEffectiveFlag = OPTION_FLAG_DISABLED
		Int CreatureContentFlag = OPTION_FLAG_DISABLED
		If CumAddictEn
			CumAddictionFlag = OPTION_FLAG_NONE
			If Init.SlsCreatureEvents
				CreatureContentFlag = OPTION_FLAG_NONE
				If CumAddictBeastLevels
					CumAddictHungerEffectiveFlag = OPTION_FLAG_NONE
				EndIf
			EndIf
		EndIf
		
		Int PsqFlag = OPTION_FLAG_DISABLED
		If Game.GetModByName("PSQ PlayerSuccubusQuest.esm") != 255
			PsqFlag = OPTION_FLAG_NONE
		EndIf
	
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$SLS_hCumOptions")
		CumBreathOID = AddToggleOption("$SLS_CumBreath", CumBreath)
		CumBreathNotifyOID = AddToggleOption("$SLS_CumBreathNotify", CumBreathNotify)
		MilkDecCumBreathOID = AddToggleOption("$SLS_MilkDecCumBreath", MilkDecCumBreath)
		AproTwoTrollHealAmountOID = AddSliderOption("$SLS_AproTwoTrollHealAmount", AproTwoTrollHealAmount, "{0}")
		CumSwallowInflateOID = AddToggleOption("$SLS_CumSwallowInflate", CumSwallowInflate, CumSwallowInflateFlag)
		CumSwallowInflateMultOID_S = AddSliderOption("$SLS_CumSwallowInflateMult", CumSwallowInflateMult, "{1}x", CumSwallowInflateFlag)
		CumEffectsEnableOID = AddToggleOption("$SLS_CumEffectsEnable", CumEffectsEnable)
		CumEffectsStackOID = AddToggleOption("$SLS_CumEffectsStack", CumEffectsStack, CumEffectsFlag)
		CumEffectsMagMultOID_S = AddSliderOption("$SLS_CumEffectsMagMult", CumEffectsMagMult, "{1}x", CumEffectsFlag)
		CumEffectsDurMultOID_S = AddSliderOption("$SLS_CumEffectsDurMult", CumEffectsDurMult, "{1}x", CumEffectsFlag)
		CumpulsionChanceOID_S = AddSliderOption("$SLS_CumpulsionChance", CumpulsionChance, "{0}%", CumEffectsFlag)
		CumRegenTimeOID_S = AddSliderOption("$SLS_CumRegenTime", CumRegenTime, "$SLS_Hours0")
		CumEffectVolThresOID_S = AddSliderOption("$SLS_CumEffectVolThres", CumEffectVolThres, "{0}%")
		StorageUtil.SetIntValue(Self, "CumInsideBonusEnjOID_S", AddSliderOption("$SLS_CumInsideBonusEnj", CumSwallow.CumInsideBonusEnjMult * 100.0, "{0}%"))
		AddEmptyOption()

		AddHeaderOption("$SLS_hCumAddiction")
		CumAddictEnOID = AddToggleOption("$SLS_CumAddictEn", CumAddictEn)
		CumSatiationOID_S = AddSliderOption("$SLS_CumSatiation", CumSatiation, "{1}x", CumAddictionFlag)
		CumAddictClampHungerOID = AddToggleOption("$SLS_CumAddictClampHunger", CumAddictClampHunger, CumAddictionFlag)
		CumAddictHungerRateOID_S = AddSliderOption("$SLS_CumAddictHungerRate", CumAddictionHungerRate, "$SLS_PointsPerHour", CumAddictionFlag)
		CumAddictHungerRateEffective = AddTextOption("$SLS_CumAddictHungerRateEffective", ((CumAddictBeastLevels as Float) * (CumAddict.GetAddictionState() * CumAddictionHungerRate)), CumAddictHungerEffectiveFlag)
		CumAddictBeastLevelsOID = AddToggleOption("$SLS_CumAddictBeastLevels", CumAddictBeastLevels, CreatureContentFlag)
		CumAddictionSpeedOID_S = AddSliderOption("$SLS_CumAddictionSpeed", CumAddictionSpeed, "{1}x", CumAddictionFlag)
		CumAddictionPerHourOID_S = AddSliderOption("$SLS_CumAddictionPerHour", CumAddictionDecayPerHour, "$SLS_PointsPerHour", CumAddictionFlag)
		StorageUtil.SetIntValue(Self, "CumAddictBlockDecayOID", AddToggleOption("$SLS_CumAddictBlockDecay", CumAddict.CumBlocksAddictionDecay, CumAddictionFlag))
		AddEmptyOption()
		
		AddHeaderOption("Daydreaming ")
		StorageUtil.SetIntValue(Self, "CumAddictDayDreamOID", AddToggleOption("$SLS_CumAddictDayDream", StorageUtil.GetIntValue(Self, "CumAddictDayDream", Missing = 1), CumAddictionFlag))
		StorageUtil.SetintValue(Self, "CumAddictDayDreamArousalOID_S", AddSliderOption("$SLS_CumAddictDayDreamArousal", StorageUtil.GetFloatValue(Self, "CumAddictDayDreamArousal", Missing = 101.0), "{0}", CumAddictionFlag))
		StorageUtil.SetIntValue(Self, "CumAddictDayDreamVolOID_S", AddSliderOption("$SLS_CumAddictDayDreamVol", StorageUtil.GetFloatValue(Self, "CumAddictDayDreamVol", Missing = 1.0) * 100.0, "{0}%", CumAddictionFlag))
		StorageUtil.SetIntValue(Self, "CumAddictDayDreamButterflysOID", AddToggleOption("$SLS_CumAddictDayDreamButterflys", StorageUtil.GetIntValue(Self, "CumAddictDayDreamButterflys", Missing = 1), CumAddictionFlag))
		
		StorageUtil.SetintValue(Self, "DayDreamVoicesChanceOID_S", AddSliderOption("Voices Chance", (Game.GetFormFromFile(0x104511, "SL Survival.esp") as _SLS_CumDesperationVoices).VoicesChance, "{0}%"))
		StorageUtil.SetintValue(Self, "DayDreamVoicesVolumeOID_S", AddSliderOption("Voices Volume", (Game.GetFormFromFile(0x104511, "SL Survival.esp") as _SLS_CumDesperationVoices).VoicesVolume * 100.0, "{0}%"))
		StorageUtil.SetintValue(Self, "DayDreamVanillaVoiceVolumeOID_S", AddSliderOption("Vanilla Voice Volume", (Game.GetFormFromFile(0x104511, "SL Survival.esp") as _SLS_CumDesperationVoices).VanillaVoiceVolume * 100.0, "{0}%"))
		AddEmptyOption()
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hAddictActions")
		CumAddictBatheRefuseTimeOID_S = AddSliderOption("$SLS_CumAddictBatheRefuseTime", CumAddictBatheRefuseTime, "$SLS_Hours0", CumAddictionFlag)
		CumAddictReflexSwallowOID_S = AddSliderOption("$SLS_CumAddictReflexSwallow", CumAddictReflexSwallow, "{1}x", CumAddictionFlag)
		CumAddictAutoSuckCreatureOID_S = AddSliderOption("$SLS_CumAddictAutoSuckCreature", CumAddictAutoSuckCreature, "{1}x", CreatureContentFlag)
		CumAddictAutoSuckStageDB = AddMenuOption("$SLS_CumAddictAutoSuckStage", CumHungerStrings[CumHungerAutoSuck], CumAddictionFlag)
		CumAddictAutoSuckCooldownOID_S = AddSliderOption("$SLS_CumAddictAutoSuckCooldown", CumAddictAutoSuckCooldown, "$SLS_Hours0", CreatureContentFlag)
		CumAddictAutoSuckCreatureArousalOID_S = AddSliderOption("$SLS_CumAddictAutoSuckCreatureArousal", CumAddictAutoSuckCreatureArousal, "{0}", CreatureContentFlag)
		StorageUtil.SetIntValue(Self, "CumAddictAutoSuckVictim", AddToggleOption("$SLS_CumAddictAutoSuckVictim", CumAddict.AutoSuckVictim, CreatureContentFlag))
		AddEmptyOption()
		
		If CumAddictEn
			AddHeaderOption("$SLS_hCurrentStats")
			AddTextOption("$SLS_AddictionPoints", _SLS_CumAddictionPool.GetValue() + " (" + CumAddict.GetCurrentAddictionString() + ")")
			AddTextOption("$SLS_HungerPoints", _SLS_CumAddictionHunger.GetValue() + " (" + CumAddict.GetCurrentHungerString() + ")")
			AddEmptyOption()
			
			AddHeaderOption("$SLS_hCurrentHungerRangeValues")
			AddTextOption("$SLS_HungerPointsSatisfied", _SLS_CumHunger0.GetValue())
			AddTextOption("$SLS_HungerPointsPeckish", _SLS_CumHunger1.GetValue())
			AddTextOption("$SLS_HungerPointsHungry", _SLS_CumHunger2.GetValue())
			AddTextOption("$SLS_HungerPointsStarving", _SLS_CumHunger3.GetValue())
			AddTextOption("$SLS_HungerPointsRavenous", _SLS_CumHunger3.GetValue())
			AddEmptyOption()
			
			AddHeaderOption("$SLS_hCurrentAddictionGainPerHourFrom")
			Float CumGainSkin = CumAddict.ProcSkinCumAddiction(DoProc = false, HoursPassed = 1.0)
			Float CumGainVag = CumAddict.ProcVagCumAddiction(DoProc = false, HoursPassed = 1.0)
			Float CumGainAnal = CumAddict.ProcAnalCumAddiction(DoProc = false, HoursPassed = 1.0)
			AddTextOption("$SLS_CumOnSkin", CumGainSkin)
			AddTextOption("$SLS_CumInPussy", CumGainVag)
			AddTextOption("$SLS_CumInAss", CumGainAnal)
			AddTextOption("$SLS_TotalGainPerHour", CumGainAnal + CumGainVag + CumGainSkin)
			AddEmptyOption()
			
			AddHeaderOption("$SLS_hSatiationProvidedBy")
			AddTextOption("$SLS_SmallLoads", Util.GetLoadSize(CumSource = None, LoadTier = 1) * CumSatiation)
			AddTextOption("$SLS_AverageLoads", Util.GetLoadSize(CumSource = None, LoadTier = 2) * CumSatiation)
			AddTextOption("$SLS_BigLoads", Util.GetLoadSize(CumSource = None, LoadTier = 4) * CumSatiation)
			AddEmptyOption()
		EndIf
		
		Actor CrosshairRef = Game.GetCurrentCrosshairRef() as Actor
		String AddRemoveString = "No Crosshair Ref"
		Int CrosshairRefFlag = OPTION_FLAG_DISABLED
		If Init.MmeInstalled && CrossHairRef && !CumLactacidAll
			VoiceType Voice = CrossHairRef.GetVoiceType()
			If Voice
				String VoiceString = Voice as String
				VoiceString = StringUtil.Substring(VoiceString, startIndex = 12, len = 0)
				VoiceString = StringUtil.Substring(VoiceString, startIndex = 0, len = (StringUtil.GetLength(VoiceString) - 2))
				If _SLS_CumHasLactacidVoices.HasForm(CrosshairRef.GetVoiceType())
					AddRemoveString = "Remove " + VoiceString
				Else
					AddRemoveString = "Add " + VoiceString
				EndIf
				CrosshairRefFlag = OPTION_FLAG_NONE
			EndIf
		EndIf
		
		Int SpecificCumFlag = OPTION_FLAG_DISABLED
		If !CumLactacidAll
			SpecificCumFlag = OPTION_FLAG_NONE
		EndIf

		SetCursorPosition(1)
		AddHeaderOption("$SLS_hSuccubus")
		SuccubusCumSwallowEnergyMultOID_S = AddSliderOption("$SLS_SuccubusCumSwallowEnergyMult", SuccubusCumSwallowEnergyMult, "{1}X", PsqFlag)
		SuccubusCumSwallowEnergyPerRankOID = AddToggleOption("$SLS_SuccubusCumSwallowEnergyPerRank", SuccubusCumSwallowEnergyPerRank, PsqFlag)
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hCumHasLactacid")
		CumIsLactacidOID_S = AddSliderOption("$SLS_CumIsLactacid", (CumIsLactacid * 100.0), "{0}%", MmeInstalledFlag)
		AddEmptyOption()
		CumLactacidAllOID = AddToggleOption("$SLS_CumLactacidAll", CumLactacidAll)
		CumLactacidAllPlayableOID = AddToggleOption("$SLS_CumLactacidAllPlayable", CumLactacidAllPlayable, SpecificCumFlag)
		CumLactacidCustomOID_T = AddTextOption(AddRemoveString, "", CrosshairRefFlag)
		AddEmptyOption()
		
		StorageUtil.SetIntValue(Self, "CumLactacidBearOID", AddToggleOption("$SLS_CumLactacidBear", _SLS_CumHasLactacidVoices.HasForm(_SLS_CumLactacidVoicesList.GetAt(0)), SpecificCumFlag))
		StorageUtil.SetIntValue(Self, "CumLactacidChaurusOID", AddToggleOption("$SLS_CumLactacidChaurus", _SLS_CumHasLactacidVoices.HasForm(_SLS_CumLactacidVoicesList.GetAt(1)), SpecificCumFlag))
		StorageUtil.SetIntValue(Self, "CumLactacidDeerOID", AddToggleOption("$SLS_CumLactacidDeer", _SLS_CumHasLactacidVoices.HasForm(_SLS_CumLactacidVoicesList.GetAt(2)), SpecificCumFlag))
		StorageUtil.SetIntValue(Self, "CumLactacidDogOID", AddToggleOption("$SLS_CumLactacidDog", _SLS_CumHasLactacidVoices.HasForm(_SLS_CumLactacidVoicesList.GetAt(3)), SpecificCumFlag))
		StorageUtil.SetIntValue(Self, "CumLactacidDragonPriestOID", AddToggleOption("$SLS_CumLactacidDragonPriest", _SLS_CumHasLactacidVoices.HasForm(_SLS_CumLactacidVoicesList.GetAt(4)), SpecificCumFlag))
		StorageUtil.SetIntValue(Self, "CumLactacidDragonOID", AddToggleOption("$SLS_CumLactacidDragon", _SLS_CumHasLactacidVoices.HasForm(_SLS_CumLactacidVoicesList.GetAt(5)), SpecificCumFlag))
		StorageUtil.SetIntValue(Self, "CumLactacidDraugrOID", AddToggleOption("$SLS_CumLactacidDraugr", _SLS_CumHasLactacidVoices.HasForm(_SLS_CumLactacidVoicesList.GetAt(6)), SpecificCumFlag))
		StorageUtil.SetIntValue(Self, "CumLactacidDremoraOID", AddToggleOption("$SLS_CumLactacidDremora", _SLS_CumHasLactacidVoices.HasForm(_SLS_CumLactacidVoicesList.GetAt(7)), SpecificCumFlag))
		StorageUtil.SetIntValue(Self, "CumLactacidDwarvenCenturionOID", AddToggleOption("$SLS_CumLactacidDwarvenCenturion", _SLS_CumHasLactacidVoices.HasForm(_SLS_CumLactacidVoicesList.GetAt(8)), SpecificCumFlag))
		StorageUtil.SetIntValue(Self, "CumLactacidDwarvenSphereOID", AddToggleOption("$SLS_CumLactacidDwarvenSphere", _SLS_CumHasLactacidVoices.HasForm(_SLS_CumLactacidVoicesList.GetAt(9)), SpecificCumFlag))
		StorageUtil.SetIntValue(Self, "CumLactacidDwarvenSpiderOID", AddToggleOption("$SLS_CumLactacidDwarvenSpider", _SLS_CumHasLactacidVoices.HasForm(_SLS_CumLactacidVoicesList.GetAt(10)), SpecificCumFlag))
		StorageUtil.SetIntValue(Self, "CumLactacidFalmerOID", AddToggleOption("$SLS_CumLactacidFalmer", _SLS_CumHasLactacidVoices.HasForm(_SLS_CumLactacidVoicesList.GetAt(11)), SpecificCumFlag))
		StorageUtil.SetIntValue(Self, "CumLactacidFoxOID", AddToggleOption("$SLS_CumLactacidFox", _SLS_CumHasLactacidVoices.HasForm(_SLS_CumLactacidVoicesList.GetAt(12)), SpecificCumFlag))
		StorageUtil.SetIntValue(Self, "CumLactacidSpiderOID", AddToggleOption("$SLS_CumLactacidSpider", _SLS_CumHasLactacidVoices.HasForm(_SLS_CumLactacidVoicesList.GetAt(13)), SpecificCumFlag))
		StorageUtil.SetIntValue(Self, "CumLactacidGiantOID", AddToggleOption("$SLS_CumLactacidGiant", _SLS_CumHasLactacidVoices.HasForm(_SLS_CumLactacidVoicesList.GetAt(15)), SpecificCumFlag))
		StorageUtil.SetIntValue(Self, "CumLactacidGoatOID", AddToggleOption("$SLS_CumLactacidGoat", _SLS_CumHasLactacidVoices.HasForm(_SLS_CumLactacidVoicesList.GetAt(16)), SpecificCumFlag))
		StorageUtil.SetIntValue(Self, "CumLactacidHorkerOID", AddToggleOption("$SLS_CumLactacidHorker", _SLS_CumHasLactacidVoices.HasForm(_SLS_CumLactacidVoicesList.GetAt(17)), SpecificCumFlag))
		StorageUtil.SetIntValue(Self, "CumLactacidHorseOID", AddToggleOption("$SLS_CumLactacidHorse", _SLS_CumHasLactacidVoices.HasForm(_SLS_CumLactacidVoicesList.GetAt(18)), SpecificCumFlag))
		StorageUtil.SetIntValue(Self, "CumLactacidMammothOID", AddToggleOption("Mammoth ", _SLS_CumHasLactacidVoices.HasForm(_SLS_CumLactacidVoicesList.GetAt(19)), SpecificCumFlag))
		StorageUtil.SetIntValue(Self, "CumLactacidSabrecatOID", AddToggleOption("$SLS_CumLactacidSabrecat", _SLS_CumHasLactacidVoices.HasForm(_SLS_CumLactacidVoicesList.GetAt(20)), SpecificCumFlag))
		StorageUtil.SetIntValue(Self, "CumLactacidSkeeverOID", AddToggleOption("$SLS_CumLactacidSkeever", _SLS_CumHasLactacidVoices.HasForm(_SLS_CumLactacidVoicesList.GetAt(21)), SpecificCumFlag))
		StorageUtil.SetIntValue(Self, "CumLactacidSprigganOID", AddToggleOption("$SLS_CumLactacidSpriggan", _SLS_CumHasLactacidVoices.HasForm(_SLS_CumLactacidVoicesList.GetAt(22)), SpecificCumFlag))
		StorageUtil.SetIntValue(Self, "CumLactacidTrollOID", AddToggleOption("$SLS_CumLactacidTroll", _SLS_CumHasLactacidVoices.HasForm(_SLS_CumLactacidVoicesList.GetAt(23)), SpecificCumFlag))
		StorageUtil.SetIntValue(Self, "CumLactacidWerewolfOID", AddToggleOption("$SLS_CumLactacidWerewolf", _SLS_CumHasLactacidVoices.HasForm(_SLS_CumLactacidVoicesList.GetAt(24)), SpecificCumFlag))
		StorageUtil.SetIntValue(Self, "CumLactacidWolfOID", AddToggleOption("$SLS_CumLactacidWolf", _SLS_CumHasLactacidVoices.HasForm(_SLS_CumLactacidVoicesList.GetAt(25)), SpecificCumFlag))
		AddEmptyOption()
		
	ElseIf page == "$SLS_pFrostfallSimplyKnock"
		Int FfRescueEventsFlag = OPTION_FLAG_DISABLED
		If FfRescueEvents && !IsHardcoreLocked
			FfRescueEventsFlag = OPTION_FLAG_NONE
		EndIf
		
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("Frostfall ")
		WarmBodiesOID_S = AddSliderOption("$SLS_WarmBodies", WarmBodies, "{0} Per Tick")
		MilkLeakWetOID_S = AddSliderOption("$SLS_MilkLeakWet", MilkLeakWet, "{0} Wetness Per Tick")
		CumWetMultOID_S = AddSliderOption("$SLS_CumWetMult", CumWetMult, "{1}x More Wet")
		CumExposureMultOID_S = AddSliderOption("$SLS_CumExposureMult", CumExposureMult, "{1}x More Exposure")
		SwimCumCleanOID_S = AddSliderOption("$SLS_SwimCumClean", SwimCumClean, "{0} Sec Clears Cum")
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hFrostfallRescue")
		FfRescueEventsOID = AddToggleOption("$SLS_FfRescueEvents", FfRescueEvents, HardMode)
		SimpleSlaveryFFOID_S = AddSliderOption("$SLS_SimpleSlaveryFF", SimpleSlaveryFF, "{0}%", FfRescueEventsFlag)
		SdDreamFFOID_S = AddSliderOption("$SLS_SdDreamFF", SdDreamFF, "{0}%", FfRescueEventsFlag)
		
		SetCursorPosition(1)
		AddHeaderOption("$SLS_hSimplyKnock")
		NormalKnockDialogOID = AddToggleOption("$SLS_NormalKnockDialog", Init.SKdialog)
		KnockSlaveryChanceOID_S = AddSliderOption("$SLS_KnockSlaveryChance", KnockSlaveryChance, "{0}%", HardMode)
		SimpleSlaveryWeightOID_S = AddSliderOption("$SLS_SimpleSlaveryWeight", SimpleSlaveryWeight, "{0}%", HardMode)
		SdWeightOID_S = AddSliderOption("$SLS_SdWeight", SdWeight, "{0}%", HardMode)

	ElseIf page == "$SLS_pTollsEvictionGates"
		
		Int AddLocationFlag = OPTION_FLAG_DISABLED
		Int RemoveLocationFlag = OPTION_FLAG_DISABLED
		Location Loc = PlayerRef.GetCurrentLocation()
		If Loc != None
			If GetLocationJurisdictionList(Loc) == None
				AddLocationFlag = OPTION_FLAG_NONE
			Else
				RemoveLocationFlag = OPTION_FLAG_NONE
			EndIf
		EndIf
		
		Int FollowersReqLocked = OPTION_FLAG_NONE
		If IsHardcoreLocked || TollFollowersHardcore
			FollowersReqLocked = OPTION_FLAG_DISABLED
		EndIf
		
		Int CurfewFlag = OPTION_FLAG_DISABLED
		If CurfewEnable && !IsHardcoreLocked
			CurfewFlag = OPTION_FLAG_NONE
		EndIf
		
		Int DrugLactacidFlag = OPTION_FLAG_DISABLED
		If Game.GetModByName("MilkModNEW.esp") != 255 && !IsHardcoreLocked
			DrugLactacidFlag = OPTION_FLAG_NONE
		EndIf
		Int DrugSkoomaFlag = OPTION_FLAG_DISABLED
		If Game.GetModByName("SexLabSkoomaWhore.esp") != 255 && !IsHardcoreLocked
			DrugSkoomaFlag = OPTION_FLAG_NONE
		EndIf
		Int DrugInflateFlag = OPTION_FLAG_DISABLED
		If Game.GetModByName("SexLab Inflation Framework.esp") != 255 && !IsHardcoreLocked
			DrugInflateFlag = OPTION_FLAG_NONE
		EndIf
		Int DrugFmFertilityFlag = OPTION_FLAG_DISABLED
		If Game.GetModByName("Fertility Mode.esm") != 255 && !IsHardcoreLocked
			DrugFmFertilityFlag = OPTION_FLAG_NONE
		EndIf
		Int DrugSlenFlag = OPTION_FLAG_DISABLED
		If Game.GetModByName("SexLab Eager NPCs.esp") != 255 && !IsHardcoreLocked
			DrugSlenFlag = OPTION_FLAG_NONE
		EndIf

		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$SLS_hTollsGeneral")
		StorageUtil.SetIntValue(Self, "TollsEnableOID", AddToggleOption("$SLS_TollsEnable", Init.TollEnable, HardMode))
		StorageUtil.SetIntValue(Self, "ResidentsDontPayTollsOID", AddToggleOption("$SLS_ResidentsDontPayTolls", LocTrack.ResidentsDontPayTolls, HardMode))
		DoorLockDownOID = AddToggleOption("$SLS_DoorLockDown", DoorLockDownT, HardMode)
		TollFollowersHardcoreOID = AddToggleOption("$SLS_TollFollowersHardcore", TollFollowersHardcore, FollowersReqLocked)
		TollFollowersOID_S = AddSliderOption("$SLS_TollFollowers", _SLS_TollFollowersRequired.GetValueInt(), "{0}", FollowersReqLocked)
		TollSexAggDB = AddMenuOption("$SLS_TollSexAgg", SexAggressiveness[TollSexAgg], 0)
		TollSexVictimDB = AddMenuOption("$SLS_TollSexVictim", SexPlayerIsVictim[TollSexVictim], 0)
		
		CurrentLocationOID_T = AddTextOption("$SLS_CurrentLocation", GetLocationCurrentString())
		;AddTextOption("This Location Is In: ", GetLocationJurisdictionString(Loc))
		AddTownLocationOID_T = AddTextOption("$SLS_AddTownLocation", "", AddLocationFlag)
		RemoveTownLocationOID_T = AddTextOption("$SLS_RemoveTownLocation", "", RemoveLocationFlag)
		AddEmptyOption()
	
		AddHeaderOption("$SLS_hTollsCosts")
		TollCostGoldOID_S = AddSliderOption("$SLS_TollCostGold", TollUtil.TollCostGold, "$SLS_Gold", HardMode)
		GoldPerLevelOID = AddToggleOption("$SLS_GoldPerLevel", TollUtil.TollCostPerLevel, HardMode)
		SlaverunFactorOID = AddSliderOption("$SLS_SlaverunFactor", TollUtil.SlaverunFactor, "{1}x ", HardMode)
		SlaverunJobFactorOID = AddSliderOption("$SLS_SlaverunJobFactor", TollUtil.SlaverunJobFactor, "{0}x ", HardMode)
		TollCostDevicesOID_S = AddSliderOption("$SLS_TollCostDevices", TollUtil.TollCostDevices, "{0}", HardMode)
		TollCostTattoosOID_S = AddSliderOption("$SLS_TollCostTattoos", TollUtil.TollCostTattoos, "{0}", HardMode)
		TollCostDrugsOID_S = AddSliderOption("$SLS_TollCostDrugs", TollUtil.TollCostDrugs, "{0}", HardMode)
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hMaxTattoosOn")
		MaxTatsBodyOID_S = AddSliderOption("$SLS_MaxTatsBody", MaxTatsBody, "{0}")
		MaxTatsFaceOID_S = AddSliderOption("$SLS_MaxTatsFace", MaxTatsFace, "{0}")
		MaxTatsHandsOID_S = AddSliderOption("$SLS_MaxTatsHands", MaxTatsHands, "{0}")
		MaxTatsFeetOID_S = AddSliderOption("$SLS_MaxTatsFeet", MaxTatsFeet, "{0}")		
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hTollDrugs")
		StorageUtil.SetIntValue(Self, "TollDrugLactacidOID", AddToggleOption("$SLS_TollDrugLactacid", ForceDrug.TollDrugLactacid, DrugLactacidFlag))
		StorageUtil.SetIntValue(Self, "TollDrugSkoomaOID", AddToggleOption("$SLS_TollDrugSkooma", ForceDrug.TollDrugSkooma, DrugSkoomaFlag))
		StorageUtil.SetIntValue(Self, "TollDrugCumHumanOID", AddToggleOption("$SLS_RapeDrugCumHuman", ForceDrug.TollDrugHumanCum, HardMode))
		StorageUtil.SetIntValue(Self, "TollDrugCumCreatureOID", AddToggleOption("$SLS_RapeDrugCumCreature", ForceDrug.TollDrugCreatureCum, HardMode))
		StorageUtil.SetIntValue(Self, "TollDrugInflateOID", AddToggleOption("$SLS_RapeDrugInflate", ForceDrug.TollDrugInflate, DrugInflateFlag))
		StorageUtil.SetIntValue(Self, "TollDrugFmFertilityOID", AddToggleOption("$SLS_RapeDrugFmFertility", ForceDrug.TollDrugFmFertility, DrugFmFertilityFlag))
		StorageUtil.SetIntValue(Self, "TollDrugSlenAphrodisiacOID", AddToggleOption("$SLS_RapeDrugSlenAphrodisiac", ForceDrug.TollDrugSlenAphrodisiac, DrugSlenFlag))
		StorageUtil.SetIntValue(Self, "TollDrugSensitivityOID", AddToggleOption("$SLS_RapeDrugSensitivity", ForceDrug.TollDrugSensitivity, HardMode))

		SetCursorPosition(1)
		Int TollDodgingFlag = OPTION_FLAG_DISABLED
		If TollDodging && !IsHardcoreLocked
			TollDodgingFlag =OPTION_FLAG_NONE
		EndIf
		AddHeaderOption("$SLS_hEviction")
		EvictionLimitOID_S = AddSliderOption("$SLS_EvictionLimit", EvictionLimit, "$SLS_Gold", HardMode)
		SlaverunEvictionLimitOID_S = AddSliderOption("$SLS_SlaverunEvictionLimit", SlaverunEvictionLimit, "$SLS_Gold", HardMode)
		ConfiscationFineOID_S = AddSliderOption("$SLS_ConfiscationFine", ConfiscationFine, "$SLS_Gold", HardMode)
		ConfiscationFineSlaverunOID_S = AddSliderOption("$SLS_ConfiscationFineSlaverun", ConfiscationFineSlaverun, "$SLS_Gold", HardMode)
		AddEmptyOption()

		AddHeaderOption("$SLS_hTollEvasion")
		TollDodgingOID = AddToggleOption("$SLS_TollDodging", TollDodging, HardMode)
		TollDodgeGracePeriodOID_S = AddSliderOption("$SLS_TollDodgeGracePeriod", TollDodgeGracePeriod, "$SLS_Hours0", TollDodgingFlag)
		TollDodgeHuntFreqOID_S = AddSliderOption("$SLS_TollDodgeHuntFreq", TollDodgeHuntFreq, "{2} seconds", TollDodgingFlag)
		TollDodgeMaxGuardsOID_S = AddSliderOption("$SLS_TollDodgeMaxGuards", TollDodgeMaxGuards, "{0}", TollDodgingFlag)
		TollDodgeGiftMenuOID = AddToggleOption("$SLS_TollDodgeGiftMenu", Init.TollDodgeGiftMenu, TollDodgingFlag)
		TollDodgeItemValueModOID_S = AddSliderOption("$SLS_TollDodgeItemValueMod", TollDodgeItemValueMod, "{2}", TollDodgingFlag)
		TollDodgeDetectDistMaxOID_S = AddSliderOption("$SLS_TollDodgeDetectDistMax", GuardSpotDistNom, "$SLS_Units1", TollDodgingFlag)
		TollDodgeDisguiseBodyPenaltyOID_S = AddSliderOption("$SLS_TollDodgeDisguiseBodyPenalt", TollDodgeDisguiseBodyPenalty * 100.0, "{0}%", TollDodgingFlag)
		TollDodgeDisguiseHeadPenaltyOID_S = AddSliderOption("$SLS_TollDodgeDisguiseHeadPenalty", TollDodgeDisguiseHeadPenalty * 100.0, "{0}%", TollDodgingFlag)
		TollDodgeCurrentSpotDist = AddTextOption("$SLS_TollDodgeCurrentSpotDist" , (_SLS_TollDodgeHuntRadius.GetValue() as String), HardMode)
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hGateCurfew")
		CurfewEnableOID = AddToggleOption("$SLS_CurfewEnable", CurfewEnable)
		StorageUtil.SetIntValue(Self, "GateCurfewBeginOID_S", AddSliderOption("$SLS_GateCurfewBegin", (Game.GetFormFromFile(0x0EAB5A, "SL Survival.esp") as GlobalVariable).GetValue(), "{0}:00 Hours", CurfewFlag)) ; _SLS_GateCurfewBegin
		StorageUtil.SetIntValue(Self, "GateCurfewEndOID_S", AddSliderOption("$SLS_GateCurfewEnd", (Game.GetFormFromFile(0x0EAB5B, "SL Survival.esp") as GlobalVariable).GetValue(), "{0}:00 Hours", CurfewFlag)) ; _SLS_GateCurfewEnd
		StorageUtil.SetIntValue(Self, "GateCurfewSlavetownBeginOID_S", AddSliderOption("$SLS_GateCurfewSlavetownBegin", (Game.GetFormFromFile(0x0EE155, "SL Survival.esp") as GlobalVariable).GetValue(), "{0}:00 Hours", CurfewFlag)) ; _SLS_GateCurfewSlavetownBegin
		StorageUtil.SetIntValue(Self, "GateCurfewSlavetownEndOID_S", AddSliderOption("$SLS_GateCurfewSlavetownEnd", (Game.GetFormFromFile(0x0EE156, "SL Survival.esp") as GlobalVariable).GetValue(), "{0}:00 Hours", CurfewFlag)) ; _SLS_GateCurfewSlavetownEnd
		AddEmptyOption()
		
	ElseIf(page == "$SLS_pLicences1")
		String BikCurseTrig = "None "
		If BikiniCurseTriggerArmor
			BikCurseTrig = BikiniCurseTriggerArmor.GetName()
		EndIf
	
		Int HardcoreFlag = OPTION_FLAG_NONE
		If IsHardcoreLocked
			HardcoreFlag = OPTION_FLAG_DISABLED
		EndIf
	
		Int LicFlag = OPTION_FLAG_DISABLED
		If Init.LicencesEnable && !IsHardcoreLocked
			LicFlag = OPTION_FLAG_NONE
		EndIf
		
		Int UnlockStyleFlag = OPTION_FLAG_DISABLED
		If Init.LicencesEnable && !IsHardcoreLocked && LicUtil.LicenceStyle == 3
			UnlockStyleFlag = OPTION_FLAG_NONE
		EndIf
		
		Int BikiniFlag = OPTION_FLAG_DISABLED
		If Init.LicencesEnable && LicUtil.LicBikiniEnable && !IsHardcoreLocked
			BikiniFlag = OPTION_FLAG_NONE
		EndIf
		
		Int ClothesFlag = OPTION_FLAG_DISABLED
		If Init.LicencesEnable && LicUtil.LicClothesEnable && !IsHardcoreLocked
			ClothesFlag = OPTION_FLAG_NONE
		EndIf
		
		Int MagicFlag = OPTION_FLAG_DISABLED
		If Init.LicencesEnable && LicUtil.LicMagicEnable && !IsHardcoreLocked
			MagicFlag = OPTION_FLAG_NONE
		EndIf
		
		Int EscortAddFlag = OPTION_FLAG_DISABLED
		Int EscortRemoveFlag = OPTION_FLAG_DISABLED
		
		Actor Escort = Game.GetCurrentCrosshairRef() as Actor
		If Escort
			If Escort.IsInFaction(PotentialFollowerFaction) && !Escort.IsInFaction(PotentialHireling)
				If _SLS_EscortsList.HasForm(Escort)
					EscortRemoveFlag = OPTION_FLAG_NONE
				Else
					EscortAddFlag = OPTION_FLAG_NONE
				EndIf
			EndIf
		EndIf

		Int OverlayFlag = OPTION_FLAG_DISABLED
		If LicUtil.CurseTats && Init.LicencesEnable
			OverlayFlag = OPTION_FLAG_NONE
		EndIf

		String S1 = "Remove"
		If !_SLS_LicExceptionsArmor.HasForm(EquipSlots[SelectedEquip]) && !_SLS_LicExceptionsWeapon.HasForm(EquipSlots[SelectedEquip])
			S1 = "Add"
		EndIf
	
		Int AddLicExceptionFlag = OPTION_FLAG_DISABLED
		If EquipSlots[SelectedEquip] != None && Init.LicencesEnable
			AddLicExceptionFlag = OPTION_FLAG_NONE
		EndIf
		
		Int OrdinatorInstalledFlag = OPTION_FLAG_DISABLED
		If Game.GetModByName("Ordinator - Perks of Skyrim.esp") != 255 && Init.LicencesEnable
			OrdinatorInstalledFlag = OPTION_FLAG_NONE
		EndIf
		
		Int ForceCheckDfFlag = OPTION_FLAG_DISABLED
		If LicUtil.CheckFollowers
			ForceCheckDfFlag = OPTION_FLAG_NONE
		EndIf

		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$SLS_hGeneralSettings2")
		LicencesEnableOID = AddToggleOption("$SLS_LicencesEnable", Init.LicencesEnable, HardcoreFlag)
		LicencesSnowberryOID = AddToggleOption("$SLS_LicencesSnowberry", SnowberryEnable, LicFlag)
		LicenceStyleDB = AddMenuOption("$SLS_LicenceStyle", LicenceStyleList[LicUtil.LicenceStyle], LicFlag)
		BikiniLicFirstOID = AddToggleOption("$SLS_BikiniLicFirst", LicUtil.AlwaysAwardBikiniLicFirst, LicFlag)
		FollowerLicStyleDB = AddMenuOption("$SLS_FollowerLicStyle", FollowerLicStyles[LicUtil.FollowerLicStyle], LicFlag)
		LicUnlockCostOID_S = AddSliderOption("$SLS_LicUnlockCost", _SLS_LicUnlockCost.GetValueInt(), "$SLS_Gold", UnlockStyleFlag)
		LicBlockChanceOID_S = AddSliderOption("$SLS_LicBlockChance", LicBlockChance, "{0}%", LicFlag)
		LicBuyBackOID = AddToggleOption("$SLS_LicBuyBack", LicUtil.BuyBack, LicFlag)
		LicBuyBackPriceDB = AddMenuOption("$SLS_LicBuyBackPrice", BuyBackPrices[BuyBackPrice], LicFlag)
		LicBountyMustBePaidOID = AddToggleOption("$SLS_LicBountyMustBePaid", LicUtil.BountyMustBePaid, LicFlag)
		StorageUtil.SetIntValue(Self, "LicCheckFollowers", AddToggleOption("Check Followers", LicUtil.CheckFollowers, LicFlag))
		StorageUtil.SetIntValue(Self, "LicForceCheckDeviousFollower", AddToggleOption("Force Check Devious Follower", LicUtil.ForceCheckDF, ForceCheckDfFlag))
		FolContraBlockOID = AddToggleOption("$SLS_FolContraBlock", FolContraBlock, LicFlag)
		FolContraKeysOID = AddToggleOption("$SLS_FolContraKeys", LicUtil.FollowerWontCarryKeys, LicFlag)
		FolTakeClothesOID = AddToggleOption("$SLS_FolTakeClothes", LicUtil.FolTakeClothes, LicFlag)
		OrdinSupressOID = AddToggleOption("$SLS_OrdinSupres", LicUtil.OrdinSupress, OrdinatorInstalledFlag)
		StorageUtil.SetIntValue(Self, "WetLicenceDestroyChanceOID_S", AddSliderOption("$SLS_WetLicenceDestroyChance", LicUtil.DrenchLicDestroyChance, "{0}%", LicFlag))
		StorageUtil.SetIntValue(Self, "WetLicenceMaxToLoseOID_S", AddSliderOption("$SLS_WetLicenceMaxToLose", Frostfall.MaxLicsToLose, "{0}", LicFlag))
		
		TollDodgeDetectDistTownMaxOID_S = AddSliderOption("$SLS_TollDodgeDetectDistTownMax", GuardSpotDistTown, "$SLS_Units1", LicFlag)
		TollDodgeDisguiseBodyPenaltyOID_S = AddSliderOption("$SLS_TollDodgeDisguiseBodyPenalt", TollDodgeDisguiseBodyPenalty * 100.0, "{0}%", LicFlag)
		TollDodgeDisguiseHeadPenaltyOID_S = AddSliderOption("$SLS_TollDodgeDisguiseHeadPenalty", TollDodgeDisguiseHeadPenalty * 100.0, "{0}%", LicFlag)
		TollDodgeCurrentSpotDistTown = AddTextOption("$SLS_TollDodgeCurrentSpotDistTow" , (_SLS_TollDodgeHuntRadiusTown.GetValue() as String), HardMode)
		
		SearchEscortsOID_T = AddTextOption("$SLS_SearchEscorts", "Escort Count: " + _SLS_EscortsList.GetSize(), LicFlag)
		AddEscortToListOID_T = AddTextOption("$SLS_AddEscortToList" + CrosshairRefString, "", EscortAddFlag)
		RemoveEscortFromListOID_T = AddTextOption("$SLS_RemoveEscortFromList" + CrosshairRefString, "", EscortRemoveFlag)
		ClearAllEscortsOID_T = AddTextOption("$SLS_ClearAllEscorts", "", LicFlag)
		ImportEscortsFromJsonOID_T = AddTextOption("$SLS_ImportEscortsFromJson", "", LicFlag)
		AddEmptyOption()
		LicGetEquipListOID_T = AddTextOption("$SLS_LicGetEquipList", "")
		LicEquipListDB = AddMenuOption("$SLS_LicEquipList", EquipSlotStrings[SelectedEquip])
		AddLicExceptionOID_T = AddTextOption(S1 + "$SLS_AddLicException", EquipSlotStrings[SelectedEquip], AddLicExceptionFlag)
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hFactionDiscounts")
		LicFactionDiscountOID_S = AddSliderOption("$SLS_LicFactionDiscount", LicUtil.LicFactionDiscount * 100.0, "{0}%", LicFlag)
		String DiscountString = (LicUtil.GetLicenceDiscountMagic() * 100.0)
		DiscountCollegeOID_T = AddTextOption("College Of Winterhold: " + GetMageRankString(), StringUtil.Substring(DiscountString, 0, StringUtil.Find(DiscountString, ".") + 2) + "%")
		
		DiscountString = (LicUtil.GetLicenceDiscountWeapons() * 100.0)
		DiscountCompanionsOID_T = AddTextOption("Companions: " + GetCompanionsRankString(), StringUtil.Substring(DiscountString, 0, StringUtil.Find(DiscountString, ".") + 2) + "%")
		
		DiscountString = (LicUtil.GetLicenceDiscountArmor() * 100.0)
		DiscountCwOID_T = AddTextOption(GetCwSide() + LicUtil.GetCwRankString(), StringUtil.Substring(DiscountString, 0, StringUtil.Find(DiscountString, ".") + 2) + "%")
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hLicenceDurations")
		LicShortDurOID_S = AddSliderOption("$SLS_LicShortDur", LicUtil.LicShortDur, "$SLS_Days", LicFlag)
		LicLongDurOID_S = AddSliderOption("$SLS_LicLongDur", LicUtil.LicLongDur, "$SLS_Days", LicFlag)
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hMagicLicence")
		LicMagicEnableOID = AddToggleOption("$SLS_LicMagicEnable", LicUtil.LicMagicEnable, LicFlag)
		LicMagicCursedDevicesOID = AddToggleOption("$SLS_LicMagicCursedDevices", LicUtil.LicMagicCursedDevices, MagicFlag)
		StorageUtil.SetIntValue(Self, "LicMagicCurseDrainTo", AddSliderOption("$LicMagicDrainMagicTo", (Game.GetFormFromFile(0x10C223, "SL Survival.esp") as GlobalVariable).GetValue(), "{0} Points", MagicFlag))
		LicMagicShortCostOID_S = AddSliderOption("$SLS_ShortCost", LicUtil.LicCostMagicShort, "$SLS_Gold", MagicFlag)
		LicMagicLongCostOID_S = AddSliderOption("$SLS_LongCost", LicUtil.LicCostMagicLong, "$SLS_Gold", MagicFlag)
		LicMagicPerCostOID_S = AddSliderOption("$SLS_PerCost", LicUtil.LicCostMagicPer, "$SLS_Gold", MagicFlag)
		AddEmptyOption()
		
		SetCursorPosition(1)
		AddHeaderOption("$SLS_hOverlayOptions")
		CurseTatsOID = AddToggleOption("$SLS_CurseTats", LicUtil.CurseTats, LicFlag)
		BikiniCurseAreaDB = AddMenuOption("$SLS_BikiniCurseArea", OverlayAreas[BikiniCurseArea], OverlayFlag)
		MagicCurseAreaDB = AddMenuOption("$SLS_MagicCurseArea", OverlayAreas[MagicCurseArea], OverlayFlag)
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hMerchantTrade")
		RestrictTradeOID = AddToggleOption("$SLS_RestrictTrade", TradeRestrictions, LicFlag)
		TradeRestrictBribeOID_S = AddSliderOption("$SLS_TradeRestrictBribe", TradeRestrictBribe, "$SLS_Gold", LicFlag)
		TradeRestrictAddMerchantOID_T = AddTextOption("$SLS_TradeRestrictAddMerchant", CrosshairRefString)
		TradeRestrictRemoveMerchantOID_T = AddTextOption("$SLS_TradeRestrictRemoveMerchant", CrosshairRefString)
		TradeRestrictResetAllMerchantsOID_T = AddTextOption("$SLS_TradeRestrictResetAllMerchants", "")
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hEnforcers")
		EnforcersMinOID_S = AddSliderOption("$SLS_EnforcersMin", EnforcersMin, "{0}", LicFlag)
		EnforcersMaxOID_S = AddSliderOption("$SLS_EnforcersMax", EnforcersMax, "{0}", LicFlag)
		StorageUtil.SetIntValue(Self, "_SLS_EnforcerGuardsMinOID_S", AddSliderOption("$SLS_EnforcerGuardsMin", (_SLS_LicTownCheckQuest as _SLS_LicTownCheck).EnforcerGuardsMin))
		StorageUtil.SetIntValue(Self, "_SLS_EnforcerGuardsMaxOID_S", AddSliderOption("$SLS_EnforcerGuardsMax", (_SLS_LicTownCheckQuest as _SLS_LicTownCheck).EnforcerGuardsMax))
		ResponsiveEnforcersOID = AddToggleOption("$SLS_ResponsiveEnforcers", _SLS_ResponsiveEnforcers.GetValueInt(), LicFlag)
		PersistentEnforcersOID_S = AddSliderOption("$SLS_PersistentEnforcers", _SLS_LicInspPersistence.GetValueInt(), "$SLS_Seconds0", LicFlag)
		StorageUtil.SetIntValue(Self, "EnforcerChaseDistanceOID_S", AddSliderOption("$SLS_EnforcerChaseDistance", (Game.GetFormFromFile(0x1118A1, "SL Survival.esp") as GlobalVariable).GetValue(), "$SLS_Units1", LicFlag)) ; _SLS_LicInspChaseDistance
		EnforcerRespawnDurOID_S = AddSliderOption("$SLS_EnforcerRespawnDur", EnforcerRespawnDur, "{1} Days", LicFlag)
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hArmorLicence")
		LicArmorShortCostOID_S = AddSliderOption("$SLS_ShortCost", LicUtil.LicCostArmorShort, "$SLS_Gold", LicFlag)
		LicArmorLongCostOID_S = AddSliderOption("$SLS_LongCost", LicUtil.LicCostArmorLong, "$SLS_Gold", LicFlag)
		LicArmorPerCostOID_S = AddSliderOption("$SLS_PerCost", LicUtil.LicCostArmorPer, "$SLS_Gold", LicFlag)
		AddEmptyOption()

		AddHeaderOption("$SLS_hBikiniLicence")
		LicBikiniEnableOID = AddToggleOption("$SLS_LicBikiniEnable", LicUtil.LicBikiniEnable, LicFlag)
		LicBikiniCurseEnableOID = AddToggleOption("$SLS_LicBikiniCurseEnable", LicUtil.BikiniCurseEnable, BikiniFlag)
		StorageUtil.SetIntValue(Self, "LicBikiniBreathChanceOID_S", AddSliderOption("$SLS_LicBikiniBreathChance", StorageUtil.GetFloatValue(None, "_SLS_LicBikOutOfBreathAnimChance", Missing = 60.0), "{0}%", BikiniFlag))
		LicBikiniTriggerOID_T = AddTextOption("$SLS_LicBikiniTrigger", BikCurseTrig + " - " + StringUtil.Substring(BikiniCurseTriggerArmor, StringUtil.Find(BikiniCurseTriggerArmor, "(", 0) + 1, len = 8), BikiniFlag)
		LicBikiniHeelsOID = AddToggleOption("$SLS_LicBikiniHeels", BikiniCurse.HeelsRequired, BikiniFlag)
		LicBikiniHeelHeightOID_S = AddSliderOption("$SLS_LicBikiniHeelHeight", BikiniCurse.HeelHeightRequired, "{1}", BikiniFlag)
		StorageUtil.SetIntValue(Self, "LicBikiniArmorTestOID_T", AddTextOption("$SLS_LicBikiniArmorTest", ""))
		LicBikiniShortCostOID_S = AddSliderOption("$SLS_ShortCost", LicUtil.LicCostBikiniShort, "$SLS_Gold", BikiniFlag)
		LicBikiniLongCostOID_S = AddSliderOption("$SLS_LongCost", LicUtil.LicCostBikiniLong, "$SLS_Gold", BikiniFlag)
		LicBikiniPerCostOID_S = AddSliderOption("$SLS_PerCost", LicUtil.LicCostBikiniPer, "$SLS_Gold", BikiniFlag)
		AddEmptyOption()

		AddHeaderOption("$SLS_hClothesLicence")
		LicClothesEnableDB = AddMenuOption("$SLS_LicClothesEnable", ClothesLicenceMethod[LicUtil.LicClothesEnable], LicFlag)
		LicClothesShortCostOID_S = AddSliderOption("$SLS_ShortCost", LicUtil.LicCostClothesShort, "$SLS_Gold", ClothesFlag)
		LicClothesLongCostOID_S = AddSliderOption("$SLS_LongCost", LicUtil.LicCostClothesLong, "$SLS_Gold", ClothesFlag)
		LicClothesPerCostOID_S = AddSliderOption("$SLS_PerCost", LicUtil.LicCostClothesPer, "$SLS_Gold", ClothesFlag)
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hWeaponLicence")
		LicWeapShortCostOID_S = AddSliderOption("$SLS_ShortCost", LicUtil.LicCostWeaponShort, "$SLS_Gold", LicFlag)
		LicWeapLongCostOID_S = AddSliderOption("$SLS_LongCost", LicUtil.LicCostWeaponLong, "$SLS_Gold", LicFlag)
		LicWeapPerCostOID_S = AddSliderOption("$SLS_PerCost", LicUtil.LicCostWeaponPer, "$SLS_Gold", LicFlag)
		AddEmptyOption()
		
	ElseIf(page == "$SLS_pLicences2")
		Int LicFlag = OPTION_FLAG_DISABLED
		If Init.LicencesEnable && !IsHardcoreLocked
			LicFlag = OPTION_FLAG_NONE
		EndIf
		
		Int LicCurfewFlag = OPTION_FLAG_DISABLED
		If Init.LicencesEnable && LicUtil.LicCurfewEnable && !IsHardcoreLocked
			LicCurfewFlag = OPTION_FLAG_NONE
		EndIf
		
		Int LicWhoreFlag = OPTION_FLAG_DISABLED
		If Init.LicencesEnable && LicUtil.LicWhoreEnable && !IsHardcoreLocked
			LicWhoreFlag = OPTION_FLAG_NONE
		EndIf
		
		Int LicPropertyFlag = OPTION_FLAG_DISABLED
		If Init.LicencesEnable && LicUtil.LicPropertyEnable && !IsHardcoreLocked
			LicPropertyFlag = OPTION_FLAG_NONE
		EndIf
		
		Int LicFreedomFlag = OPTION_FLAG_DISABLED
		If Init.LicencesEnable && LicUtil.LicFreedomEnable && !IsHardcoreLocked
			LicFreedomFlag = OPTION_FLAG_NONE
		EndIf
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$SLS_hCurfewLicence")
		StorageUtil.SetIntValue(Self, "CurfewLicenceEnableOID", AddToggleOption("$SLS_CurfewLicenceEnable", LicUtil.LicCurfewEnable, LicFlag))
		StorageUtil.SetIntValue(Self, "LicCurfewShortCostOID_S", AddSliderOption("$SLS_ShortCost", LicUtil.LicCostCurfewShort, "$SLS_Gold", LicCurfewFlag))
		StorageUtil.SetIntValue(Self, "LicCurfewLongCostOID_S", AddSliderOption("$SLS_LongCost", LicUtil.LicCostCurfewLong, "$SLS_Gold", LicCurfewFlag))
		StorageUtil.SetIntValue(Self, "LicCurfewPerCostOID_S", AddSliderOption("$SLS_PerCost", LicUtil.LicCostCurfewPer, "$SLS_Gold", LicCurfewFlag))
		AddEmptyOption()
		
		StorageUtil.SetIntValue(Self, "LicCurfewNotificationsOID", AddToggleOption("Curfew Notifications", (Game.GetFormFromFile(0x0E3F3D, "SL Survival.esp") as _SLS_Curfew).DoCurfewNotification, LicCurfewFlag))
		StorageUtil.SetIntValue(Self, "CurfewRestartDelayOID_S", AddSliderOption("$SLS_CurfewRestartDelay", (Game.GetFormFromFile(0x0E3F3D, "SL Survival.esp") as _SLS_Curfew).TimeToClearStreets, "{0} Sec", LicCurfewFlag))
		StorageUtil.SetIntValue(Self, "CurfewBeginOID_S", AddSliderOption("$SLS_GateCurfewBegin", (Game.GetFormFromFile(0x07B44C, "SL Survival.esp") as GlobalVariable).GetValue(), "{0}:00 Hours", LicCurfewFlag)) ; _SLS_CurfewBegin
		StorageUtil.SetIntValue(Self, "CurfewEndOID_S", AddSliderOption("$SLS_GateCurfewEnd", (Game.GetFormFromFile(0x07B44D, "SL Survival.esp") as GlobalVariable).GetValue(), "{0}:00 Hours", LicCurfewFlag)) ; _SLS_CurfewEnd
		StorageUtil.SetIntValue(Self, "CurfewSlavetownBeginOID_S", AddSliderOption("$SLS_GateCurfewSlavetownBegin", (Game.GetFormFromFile(0x0ECBC0, "SL Survival.esp") as GlobalVariable).GetValue(), "{0}:00 Hours", LicCurfewFlag)) ; _SLS_CurfewSlavetownBegin
		StorageUtil.SetIntValue(Self, "CurfewSlavetownEndOID_S", AddSliderOption("$SLS_GateCurfewSlavetownEnd", (Game.GetFormFromFile(0x0ECBC1, "SL Survival.esp") as GlobalVariable).GetValue(), "{0}:00 Hours", LicCurfewFlag)) ; _SLS_CurfewSlavetownEnd
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hWhoreLicence")
		StorageUtil.SetIntValue(Self, "WhoreLicenceEnableOID", AddToggleOption("$SLS_WhoreLicenceEnable", LicUtil.LicWhoreEnable, LicFlag))
		StorageUtil.SetIntValue(Self, "LicWhoreShortCostOID_S", AddSliderOption("$SLS_ShortCost", LicUtil.LicCostWhoreShort, "$SLS_Gold", LicWhoreFlag))
		StorageUtil.SetIntValue(Self, "LicWhoreLongCostOID_S", AddSliderOption("$SLS_LongCost", LicUtil.LicCostWhoreLong, "$SLS_Gold", LicWhoreFlag))
		StorageUtil.SetIntValue(Self, "LicWhorePerCostOID_S", AddSliderOption("$SLS_PerCost", LicUtil.LicCostWhorePer, "$SLS_Gold", LicWhoreFlag))
		AddEmptyOption()
	
		SetCursorPosition(1)
		AddHeaderOption("$SLS_hPropertyLicence")
		StorageUtil.SetIntValue(Self, "PropertyLicenceEnableOID", AddToggleOption("$SLS_PropertyLicenceEnable", LicUtil.LicPropertyEnable, LicFlag))
		StorageUtil.SetIntValue(Self, "LicPropertyShortCostOID_S", AddSliderOption("$SLS_ShortCost", LicUtil.LicCostPropertyShort, "$SLS_Gold", LicPropertyFlag))
		StorageUtil.SetIntValue(Self, "LicPropertyLongCostOID_S", AddSliderOption("$SLS_LongCost", LicUtil.LicCostPropertyLong, "$SLS_Gold", LicPropertyFlag))
		StorageUtil.SetIntValue(Self, "LicPropertyPerCostOID_S", AddSliderOption("$SLS_PerCost", LicUtil.LicCostPropertyPer, "$SLS_Gold", LicPropertyFlag))
		AddEmptyOption()
		
		AddHeaderOption("$SLS_FreedomLicence")
		;StorageUtil.SetIntValue(Self, "FreedomLicenceEnableOID", AddToggleOption("Enable Freedom Licence", LicUtil.LicFreedomEnable, LicFlag))

		StorageUtil.SetIntValue(Self, "FreedomLicenceEnableDB", AddMenuOption("$SLS_LicClothesEnable", ClothesLicenceMethod[LicUtil.LicFreedomEnable], LicFlag))
		
		StorageUtil.SetIntValue(Self, "LicFreedomShortCostOID_S", AddSliderOption("$SLS_ShortCost", LicUtil.LicCostFreedomShort, "$SLS_Gold", LicFreedomFlag))
		StorageUtil.SetIntValue(Self, "LicFreedomLongCostOID_S", AddSliderOption("$SLS_LongCost", LicUtil.LicCostFreedomLong, "$SLS_Gold", LicFreedomFlag))
		StorageUtil.SetIntValue(Self, "LicFreedomPerCostOID_S", AddSliderOption("$SLS_PerCost", LicUtil.LicCostFreedomPer, "$SLS_Gold", LicFreedomFlag))
		AddEmptyOption()
		
	
	ElseIf(page == "$SLS_pStashes")
		Int StashesEnabledFlag = OPTION_FLAG_DISABLED
		If StashTrackEn
			StashesEnabledFlag = OPTION_FLAG_NONE
		EndIf
	
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$SLS_hOptions")
		StashTrackEnOID = AddToggleOption("$SLS_StashTrackEn", StashTrackEn)
		ContTypeCountsOID = AddToggleOption("$SLS_ContTypeCounts", ContTypeCountsT, StashesEnabledFlag)
		RoadDistOID_S = AddSliderOption("$SLS_RoadDist", RoadDist, "$SLS_Units0", StashesEnabledFlag)
		StealXItemsOID_S = AddSliderOption("$SLS_StealXItems", StealXItems, "$SLS_Items", StashesEnabledFlag)
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hExceptions")
		StashAddRemoveExceptionOID_T = AddTextOption("$SLS_StashAddRemoveException", "")
		StashAddRemoveJsonExceptionsOID_T = AddTextOption("$SLS_StashAddRemoveJsonException", "")
		StashAddRemoveTempExceptionsOID_T = AddTextOption("$SLS_StashAddRemoveTempExceptions", "")
		StashAddRemoveAllExceptionsOID_T = AddTextOption("$SLS_StashAddRemoveAllExceptions", "")
		AddEmptyOption()
		
		SetCursorPosition(1)
		AddHeaderOption("$SLS_hDropStealing")
		StorageUtil.SetIntValue(Self, "DroppedItemStealingEnOID", AddToggleOption("$SLS_DroppedItemStealingEn", StorageUtil.GetIntValue(Self, "DroppedItemStealingEn", Missing = 1)))
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hExceptionListJson")
		Int i = JsonUtil.FormListCount("SL Survival/StashExceptions.json", "StashExceptions")
		ObjectReference ObjRef
		While i > 0
			i -= 1
			ObjRef = JsonUtil.FormListGet("SL Survival/StashExceptions.json", "StashExceptions", i) as ObjectReference
			If ObjRef
				AddTextOption(i + ") " + StringUtil.Substring(ObjRef, StringUtil.Find(ObjRef, "(", 0) + 1, len = 8), "", OPTION_FLAG_DISABLED)
			EndIf
		EndWhile
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hExceptionListTemporaryRefs")
		i = StorageUtil.FormListCount(None, "_SLS_StashExceptionsTemp")
		While i > 0
			i -= 1
			ObjRef = StorageUtil.FormListGet(None, "_SLS_StashExceptionsTemp", i) as ObjectReference
			If ObjRef
				AddTextOption(i + ") " + StringUtil.Substring(ObjRef, StringUtil.Find(ObjRef, "(", 0) + 1, len = 8), "", OPTION_FLAG_DISABLED)
			EndIf
		EndWhile
		
	ElseIf(page == "$SLS_pBeggingKennel")
		SetCursorFillMode(LEFT_TO_RIGHT)
		Int BeggingFlag = OPTION_FLAG_DISABLED
		If _SLS_BeggingDialogT.GetValueInt() == 1 && !IsHardcoreLocked
			BeggingFlag = OPTION_FLAG_NONE
		EndIf
		Int SlaveRapeFlag = OPTION_FLAG_DISABLED
		If KennelSlaveRapeTimeMin > -1
			SlaveRapeFlag = OPTION_FLAG_NONE
		EndIf
		Int MwaInstalled = OPTION_FLAG_DISABLED
		If Game.GetModByName("Mortal Weapons & Armor.esp") != 255
			MwaInstalled = OPTION_FLAG_NONE
		EndIf
		
		AddHeaderOption("$SLS_hBegging")
		AddEmptyOption()
		BeggingTOID = AddToggleOption("$SLS_BeggingT", _SLS_BeggingDialogT.GetValueInt())
		BegSelfDegEnableOID = AddToggleOption("$SLS_BegSelfDegEnable", _SLS_BegSelfDegradationEnable.GetValueInt())
		BegNumItemsOID_S = AddSliderOption("$SLS_BegNumItems", BegNumItems, "$SLS_Items", BeggingFlag)
		BegGoldOID_S = AddSliderOption("$SLS_BegNumItems", BegGold, "$SLS_xGold", BeggingFlag)
		BegSexAggDB = AddMenuOption("$SLS_TollSexAgg", SexAggressiveness[BegSexAgg], 0)
		BegSexVictimDB = AddMenuOption("$SLS_TollSexVictim", SexPlayerIsVictim[BegSexVictim], 0)
		BegMwaCurseChanceOID_S = AddSliderOption("$SLS_BegMwaCurseChance", BegMwaCurseChance, "{0}%", MwaInstalled)
		AddEmptyOption()
		
		AddEmptyOption()
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hKennelPlayerOptions")
		AddEmptyOption()
		KennelSafeCellCostOID_S = AddSliderOption("$SLS_KennelSafeCellCost", KennelSafeCellCost, "$SLS_Gold", HardMode)
		StorageUtil.SetIntValue(Self, "KennelSuitsOID", AddToggleOption("$SLS_KennelSuits", StorageUtil.GetIntValue(Self, "KennelSuits", Missing = 0)))
		KennelRapeChancePerHourOID_S = AddSliderOption("$SLS_KennelRapeChancePerHour", KennelRapeChancePerHour, "{0}%", HardMode)
		KennelCreatureChanceOID_S = AddSliderOption("$SLS_KennelCreatureChance", KennelCreatureChance, "{0}%", CreatureEventsFlag)
		KennelExtraDevicesOID = AddToggleOption("$SLS_KennelExtraDevices", _SLS_KennelExtraDevices.GetValueInt())
		KennelFollowerToggleOID = AddToggleOption("$SLS_KennelFollowerToggle", KennelFollowerToggle)
		KennelSexAggDB = AddMenuOption("$SLS_TollSexAgg", SexAggressiveness[KennelSexAgg], 0)
		KennelSexVictimDB = AddMenuOption("$SLS_TollSexVictim", SexPlayerIsVictim[KennelSexVictim], 0)
		AddEmptyOption()
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hKennelSlaveOptions")
		AddEmptyOption()
		KennelSlaveRapeTimeMinOID_S = AddSliderOption("$SLS_KennelSlaveRapeTimeMin", KennelSlaveRapeTimeMin, "$SLS_Seconds0")
		KennelSlaveRapeTimeMaxOID_S = AddSliderOption("$SLS_KennelSlaveRapeTimeMax", KennelSlaveRapeTimeMax, "$SLS_Seconds0", SlaveRapeFlag)
		StorageUtil.SetIntValue(Self, "KennelSlaveDeviceCountMinOID_S", AddSliderOption("$SLS_KennelSlaveDeviceCountMin", StorageUtil.GetIntValue(Self, "KennelSlaveDeviceCountMin", Missing = 2), "{0} Devices"))
		StorageUtil.SetIntValue(Self, "KennelSlaveDeviceCountMaxOID_S", AddSliderOption("$SLS_KennelSlaveDeviceCountMax", StorageUtil.GetIntValue(Self, "KennelSlaveDeviceCountMax", Missing = 6), "{0} Devices"))

	ElseIf(page == "$SLS_pPickpocketDismemberment")
		Int PpLootEnableFlag = OPTION_FLAG_DISABLED
		If PpLootEnable && !IsHardcoreLocked
			PpLootEnableFlag = OPTION_FLAG_NONE
		EndIf
		
		Int AmpInstalledFlag = OPTION_FLAG_DISABLED
		If Game.GetModByName("Amputator.esm") != 255
			AmpInstalledFlag = OPTION_FLAG_NONE
		EndIf
		
		Int DismemberFlag = OPTION_FLAG_DISABLED
		If AmpType != 0
			DismemberFlag = OPTION_FLAG_NONE
		EndIf
		
		SetCursorFillMode(TOP_TO_BOTTOM)
		
		AddHeaderOption("$SLS_hPickpocket Settings")
		PpSleepNpcPerkOID = AddToggleOption("$SLS_PpSleepNpcPerk", PpSleepNpcPerk)
		PpCrimeGoldOID_S = AddSliderOption("$SLS_PpCrimeGold", Game.GetGameSettingInt("iCrimeGoldPickpocket"), "$SLS_Gold")
		PpFailHandleOID = AddToggleOption("$SLS_PpFailHandle", PpFailHandle)
		PpFailDevicesOID_S = AddSliderOption("$SLS_PpFailDevices", Init.PpFailDevices, "{0}", PpLootEnableFlag)
		PpFailStealValueOID_S = AddSliderOption("$SLS_PpFailStealValue", _SLS_PickPocketFailStealValue.GetValueInt(), "{0}", PpLootEnableFlag)
		PpFailDrugCountOID_S = AddSliderOption("$SLS_PpFailDrugCount", PpFailDrugCount, "{0}", PpLootEnableFlag)
		PpLootEnableOID = AddToggleOption("$SLS_PpLootEnable", PpLootEnable)
		
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hMorePickpocketGold")
		PpGoldChanceOfNoneOID_T = AddTextOption("$SLS_PpLootChanceOfNone" , 100.0 - (PpGoldLowChance + PpGoldModerateChance + PpGoldHighChance) + "%", PpLootEnableFlag)
		PpGoldLowChanceOID_S = AddSliderOption("$SLS_PpGoldLowChance", PpGoldLowChance, "{1}%", PpLootEnableFlag)
		PpGoldModerateChanceOID_S = AddSliderOption("$SLS_PpGoldModerateChance", PpGoldModerateChance, "{1}%", PpLootEnableFlag)
		PpGoldHighChanceOID_S = AddSliderOption("$SLS_PpGoldHighChance", PpGoldHighChance, "{1}%", PpLootEnableFlag)
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hMorePickpocketLoot")
		PpLootMinOID_S = AddSliderOption("$SLS_PpLootMin", Util.PpLootLootMin, "{0}", PpLootEnableFlag)
		PpLootMaxOID_S = AddSliderOption("$SLS_PpLootMax", Util.PpLootLootMax, "{0}", PpLootEnableFlag)
		AddEmptyOption()
		PpLootChanceOfNoneOID_T = AddTextOption("$SLS_PpLootChanceOfNone" , 100.0 - (PpLootFoodChance + PpLootGemsChance + PpLootSoulgemsChance + PpLootJewelryChance + PpLootEnchJewelryChance + PpLootPotionsChance + PpLootKeysChance + PpLootTomesChance + PpLootCureChance) + "%", PpLootEnableFlag)
		PpLootFoodChanceOID_S = AddSliderOption("$SLS_PpLootFoodChance", PpLootFoodChance, "{1}%", PpLootEnableFlag)
		PpLootGemsChanceOID_S = AddSliderOption("$SLS_PpLootGemsChance", PpLootGemsChance, "{1}%", PpLootEnableFlag)
		PpLootSoulgemsChanceOID_S = AddSliderOption("$SLS_PpLootSoulgemsChance", PpLootSoulgemsChance, "{1}%", PpLootEnableFlag)
		PpLootJewelryChanceOID_S = AddSliderOption("$SLS_PpLootJewelryChance", PpLootJewelryChance, "{1}%", PpLootEnableFlag)
		PpLootEnchJewelryChanceOID_S = AddSliderOption("$SLS_PpLootEnchJewelryChance", PpLootEnchJewelryChance, "{1}%", PpLootEnableFlag)
		PpLootPotionsChanceOID_S = AddSliderOption("$SLS_PpLootPotionsChance", PpLootPotionsChance, "{1}%", PpLootEnableFlag)
		PpLootKeysChanceOID_S = AddSliderOption("$SLS_PpLootKeysChance", PpLootKeysChance, "{1}%", PpLootEnableFlag)
		PpLootTomesChanceOID_S = AddSliderOption("$SLS_PpLootTomesChance", PpLootTomesChance, "{1}%", PpLootEnableFlag)
		PpLootCureChanceOID_S = AddSliderOption("$SLS_PpLootCureChance", PpLootCureChance, "{1}%", PpLootEnableFlag)
		AddEmptyOption()
		
		SetCursorPosition(1)
		Float DismemberActual
		Float PlayerArmor = PlayerRef.GetActorValue("DamageResist")
		If PlayerArmor > 0.0
			DismemberActual = DismemberChance - ((PlayerArmor / 10.0) * DismemberArmorBonus)
		Else
			DismemberActual = DismemberChance
		EndIf
		If DismemberActual < 0.0
			DismemberActual = 0.0
		EndIf
		AddHeaderOption("$SLS_hPlayerDismemberment")
		SetCursorFillMode(TOP_TO_BOTTOM)
		DismembermentsDB = AddMenuOption("$SLS_Dismemberments", AmputationTypes[AmpType], 0)
		DismemberProgressionDB = AddMenuOption("$SLS_DismemberProgression", AmputationDepth[AmpDepth], DismemberFlag)
		DismemberWeaponsDB = AddMenuOption("$SLS_DismemberWeapons", DismemberWeapons[DismemberWeapon], DismemberFlag)
		DismemberDepthMaxArmsDB = AddMenuOption("$SLS_DismemberDepthMaxArms", MaxAmputationDepthArms[MaxAmpDepthArms], DismemberFlag)
		DismemberDepthMaxLegsDB = AddMenuOption("$SLS_DismemberDepthMaxLegs", MaxAmputationDepthLegs[MaxAmpDepthLegs], DismemberFlag)
		DismemberCooldownOID_S = AddSliderOption("$SLS_DismemberCooldown", DismemberCooldown, "$SLS_Hours3", DismemberFlag)
		DismemberMaxAmpedLimbsOID_S = AddSliderOption("$SLS_DismemberMaxAmpedLimbs", MaxAmpedLimbs, "{0}", DismemberFlag)
		DismemberChanceOID_S = AddSliderOption("$SLS_DismemberChance", DismemberChance, "{1}%", DismemberFlag)
		DismemberArmorBonusOID_S = AddSliderOption("$SLS_DismemberArmorBonus", DismemberArmorBonus, "$SLS_Per10Armor", DismemberFlag)
		DismemberChanceActualOID_T = AddTextOption("$SLS_DismemberChanceActual" , DismemberActual + "%", DismemberFlag)
		DismemberDamageThresOID_S = AddSliderOption("$SLS_DismemberDamageThres", DismemberDamageThres, "{0}", DismemberFlag)
		DismemberHealthThresOID_S = AddSliderOption("$SLS_DismemberHealthThres", DismemberHealthThres, "{0}", DismemberFlag)
		AmpPriestHealCostOID_S = AddSliderOption("$SLS_AmpPriestHealCost", _SLS_AmpPriestHealCost.GetValueInt(), "$SLS_Gold", DismemberFlag)
		StorageUtil.SetIntValue(Self, "AmpBlockMagicOID", AddToggleOption("$SLS_AmpBlockMagic", Amputation.BlockMagic))
		DismemberTrollCumOID = AddToggleOption("$SLS_DismemberTrollCum", DismemberTrollCum)
		DismemberBathingOID = AddToggleOption("$SLS_DismemberBathing", DismemberBathing)
		DismemberPlayerSayOID = AddToggleOption("$SLS_DismemberPlayerSay", DismemberPlayerSay)
		StorageUtil.SetIntValue(Self, "DismemberCombatStopOID", AddToggleOption("$SLS_DismemberCombatStop", StorageUtil.GetIntValue(Self, "DismemberCombatStop", Missing = 1)))
		AddEmptyOption()
		
	ElseIf(page == "$SLS_pBikiniArmorsExp")
		Int BikiniFlag = OPTION_FLAG_DISABLED
		If Game.GetModByName(JsonUtil.GetStringValue("SL Survival/BikiniArmors.json", "bikinimodname", missing = "TheAmazingWorldOfBikiniArmor.esp")) != 255
			BikiniFlag = OPTION_FLAG_NONE
		EndIf
		Int BikExpFlag = OPTION_FLAG_DISABLED
		If BikiniExpT && !IsHardcoreLocked
			BikExpFlag = OPTION_FLAG_NONE
		EndIf
		Int BikBreakFlag = OPTION_FLAG_DISABLED
		If (Game.GetFormFromFile(0x108062, "SL Survival.esp") as GlobalVariable).GetValueInt() == 1; _SLS_BikBreakEnable
			BikBreakFlag = OPTION_FLAG_NONE
		EndIf
		
		Float BikExp = 0.0
		Float BikExpNextLevel = 0.0
		Float ExpPerLevel = 0.0
		String BikRankString = "Untrained "
		If _SLS_BikiniExpTrainingQuest.IsRunning()
			ExpPerLevel = BikiniExp.ExpPerLevel
			BikExp = BikiniExp.BikExp
			BikExpNextLevel = BikiniExp.ExpPerLevel
			BikRankString = BikiniExp.GetBikRankString()
			
			Int i = 0
			While BikExpNextLevel < BikExp
				BikExpNextLevel += BikiniExp.ExpPerLevel
				If i == 1
					BikExpNextLevel += (BikiniExp.ExpPerLevel * 0.5)
				EndIf
				If i == 2
					BikExpNextLevel += (BikiniExp.ExpPerLevel)
				EndIf
				i += 1
				;Debug.Trace("_SLS_: Looping")
			EndWhile
		EndIf
		
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$SLS_hBikiniExperience")
		BikiniExpOID = AddToggleOption("$SLS_BikiniExp", BikiniExpT)
		BikiniExpPerLevelOID_S = AddSliderOption("$SLS_BikiniExpPerLevel", ExpPerLevel, "$SLS_Hours0", BikExpFlag)
		BikiniExpTrainOID_S = AddSliderOption("$SLS_BikiniExpTrain", BikTrainingSpeed, "{1}x", BikExpFlag)
		BikiniExpUntrainOID_S = AddSliderOption("$SLS_BikiniExpUntrain", BikUntrainingSpeed, "{1}x", BikExpFlag)
		BikiniExpReflexesOID = AddToggleOption("$SLS_BikiniExpReflexes", _SLS_BikiniExpReflexes.GetValueInt() as Bool, BikExpFlag)
		AddTextOption("$SLS_CurrentBikiniExpRank", BikRankString, BikExpFlag)
		AddTextOption("$SLS_CurrentBikiniExp", BikExp, BikExpFlag)
		AddTextOption("$SLS_NextBikiniExpLevel", BikExpNextLevel, BikExpFlag)
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hNumberOfDropsIn")
		BikiniDropsVendorCityOID_S = AddSliderOption("$SLS_BikiniDropsVendorCity", BikiniDropsVendorCity, "$SLS_Drops", BikiniFlag)
		BikiniDropsVendorTownOID_S = AddSliderOption("$SLS_BikiniDropsVendorTown", BikiniDropsVendorTown, "$SLS_Drops", BikiniFlag)
		BikiniDropsVendorKhajiitOID_S = AddSliderOption("$SLS_BikiniDropsVendorKhajiit", BikiniDropsVendorKhajiit, "$SLS_Drops", BikiniFlag)
		AddEmptyOption()
		
		BikiniDropsChestOID_S = AddSliderOption("$SLS_BikiniDropsChest", BikiniDropsChest, "$SLS_Drops", BikiniFlag)
		BikiniDropsChestOrnateOID_S = AddSliderOption("$SLS_BikiniDropsChestOrnate", BikiniDropsChestOrnate, "$SLS_Drops", BikiniFlag)
		AddEmptyOption()
		
		AddHeaderOption("Armor Breakdowns")
		StorageUtil.SetIntValue(Self, "BikBreakEnable_OID", AddToggleOption("Enable Breakdowns", (Game.GetFormFromFile(0x108062, "SL Survival.esp") as GlobalVariable).GetValueInt()))
		StorageUtil.SetIntValue(Self, "BikBreakCompatibilityMode_OID", AddToggleOption("Compatibility Mode", (Game.GetFormFromFile(0x10D7AF, "SL Survival.esp") as _SLS_BikiniBreak).CompatibilityMode, BikBreakFlag))
		StorageUtil.SetIntValue(Self, "BikBreakBuild_OID", AddTextOption("Build Breakdown Recipes", "", BikBreakFlag))
		AddEmptyOption()
		
		AddHeaderOption("Built-In Breakdowns")
		StorageUtil.SetIntValue(Self, "BikBreakTawoba_OID", AddToggleOption("TAWoBA Breakdowns", (Game.GetFormFromFile(0x10A737, "SL Survival.esp") as GlobalVariable).GetValueInt(), BikBreakFlag))
		AddEmptyOption()
		
		SetCursorPosition(1)
		AddTextOption("$SLS_Dontforgettobuildlist", "", BikiniFlag)
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hPopulate")
		BikiniBuildListOID_T = AddTextOption("$SLS_BikiniBuildList", "", BikiniFlag)
		BikiniClearListOID_T = AddTextOption("$SLS_BikiniClearList", "", BikiniFlag)
		AddEmptyOption()
		
		;SetCursorPosition(7)
		AddHeaderOption("$SLS_hChanceOf")
		BikiniChanceNoneOID_S = AddTextOption("$SLS_PpLootChanceOfNone" , 100.0 - (BikiniChanceHide + BikiniChanceLeather + BikiniChanceIron + BikiniChanceSteel + BikiniChanceSteelPlate + BikiniChanceDwarven + BikiniChanceFalmer + BikiniChanceWolf + BikiniChanceBlades + BikiniChanceEbony + BikiniChanceDragonbone) + "%", BikiniFlag)
		BikiniChanceHideOID_S = AddSliderOption("$SLS_BikiniChanceHide", BikiniChanceHide, "{1}%", BikiniFlag)
		BikiniChanceLeatherOID_S = AddSliderOption("$SLS_BikiniChanceLeather", BikiniChanceLeather, "{1}%", BikiniFlag)
		BikiniChanceIronOID_S = AddSliderOption("$SLS_BikiniChanceIron", BikiniChanceIron, "{1}%", BikiniFlag)
		BikiniChanceSteelOID_S = AddSliderOption("$SLS_BikiniChanceSteel", BikiniChanceSteel, "{1}%", BikiniFlag)
		BikiniChanceSteelPlateOID_S = AddSliderOption("$SLS_BikiniChanceSteelPlate", BikiniChanceSteelPlate, "{1}%", BikiniFlag)
		BikiniChanceDwarvenOID_S = AddSliderOption("$SLS_BikiniChanceDwarven", BikiniChanceDwarven, "{1}%", BikiniFlag)
		BikiniChanceFalmerOID_S = AddSliderOption("$SLS_BikiniChanceFalmer", BikiniChanceFalmer, "{1}%", BikiniFlag)
		BikiniChanceWolfOID_S = AddSliderOption("$SLS_BikiniChanceWolf", BikiniChanceWolf, "{1}%", BikiniFlag)
		BikiniChanceBladesOID_S = AddSliderOption("$SLS_BikiniChanceBlades", BikiniChanceBlades, "{1}%", BikiniFlag)
		BikiniChanceEbonyOID_S = AddSliderOption("$SLS_BikiniChanceEbony", BikiniChanceEbony, "{1}%", BikiniFlag)
		BikiniChanceDragonboneOID_S = AddSliderOption("$SLS_BikiniChanceDragonbone", BikiniChanceDragonbone, "{1}%", BikiniFlag)
		
	ElseIf(page == "$SLS_pInnRoomPrices")	
		SetCursorFillMode(TOP_TO_BOTTOM)
		StorageUtil.SetIntValue(Self, "SetInnPricesOID", AddToggleOption("$SLS_hSetInnPrices", LocTrack.SetInnPrices))
		AddEmptyOption()

		String InnLoc
		Int i = 0
		While i < LocTrack.InnCosts.Length
			InnLoc = StorageUtil.StringListGet(LocTrack, "_SLS_LocIndex", i)
			StorageUtil.SetIntValue(Self, "InnCost" + InnLoc + "OID_S", AddSliderOption(InnLoc, LocTrack.InnCosts[i], "$SLS_Gold"))
			i += 1
			If i == LocTrack.InnCosts.Length / 2
				SetCursorPosition(5)
			EndIf
		EndWhile
		
		
	ElseIf(page == "$SLS_pInterfaces")
		AddHeaderOption("$SLS_pInterfaces")
		AddEmptyOption()
		StorageUtil.SetIntValue(Self, "IntAproposTwoOID", AddToggleOption("Apropos Two ", AproposTwo.GetIsInterfaceActive()))
		StorageUtil.SetIntValue(Self, "IntAmpOID", AddToggleOption("Amputator ", Amp.GetIsInterfaceActive()))
		StorageUtil.SetIntValue(Self, "IntBisOID", AddToggleOption("Bathing In Skyrim", Bis.GetIsInterfaceActive()))
		StorageUtil.SetIntValue(Self, "IntDdsOID", AddToggleOption("$SLS_TollCostDevices", Devious.GetIsInterfaceActive()))
		StorageUtil.SetIntValue(Self, "IntDfOID", AddToggleOption("Devious Followers ", Dflow.GetIsInterfaceActive()))
		StorageUtil.SetIntValue(Self, "IntEsdOID", AddToggleOption("EatingSleepingDrinking ", EatSleepDrink.GetIsInterfaceActive()))
		StorageUtil.SetIntValue(Self, "IntEffOID", AddToggleOption("EFF ", Eff.GetIsInterfaceActive()))
		StorageUtil.SetIntValue(Self, "IntFhuOID", AddToggleOption("Fill Her Up 2.0 ", Fhu.GetIsInterfaceActive()))
		StorageUtil.SetIntValue(Self, "IntFrostfallOID", AddToggleOption("Frostfall ", Frostfall.GetIsInterfaceActive()))
		StorageUtil.SetIntValue(Self, "IntIneedOID", AddToggleOption("iNeed ", Ineed.GetIsInterfaceActive()))
		StorageUtil.SetIntValue(Self, "IntMaOID", AddToggleOption("Milk Addict", MilkAddict.GetIsInterfaceActive()))
		StorageUtil.SetIntValue(Self, "IntPscOID", AddToggleOption("PaySexCrime ", Psc.GetIsInterfaceActive()))
		StorageUtil.SetIntValue(Self, "IntRndOID", AddToggleOption("Realistic Needs & Diseases", Rnd.GetIsInterfaceActive()))
		StorageUtil.SetIntValue(Self, "IntSlaxOID", AddToggleOption("Sexlab Aroused", Sla.GetIsInterfaceActive()))
		StorageUtil.SetIntValue(Self, "IntSlsoOID", AddToggleOption("Sexlab Separate Orgasms", Slso.GetIsInterfaceActive()))
		StorageUtil.SetIntValue(Self, "IntSlsfOID", AddToggleOption("Sexlab Sexual Fame", Slsf.GetIsInterfaceActive()))
		StorageUtil.SetIntValue(Self, "IntSexyMoveOID", AddToggleOption("Sexy Move", SexyMove.GetIsInterfaceActive()))
		StorageUtil.SetIntValue(Self, "IntSlaverunOID", AddToggleOption("Slaverun 3.x", Slaverun.GetIsInterfaceActive()))
		StorageUtil.SetIntValue(Self, "IntTatsOID", AddToggleOption("Slavetats ", Tats.GetIsInterfaceActive()))
		StorageUtil.SetIntValue(Self, "IntSgoOID", AddToggleOption("Soulgem Oven 3.0 ", Sgo.GetIsInterfaceActive()))
		StorageUtil.SetIntValue(Self, "IntStaOID", AddToggleOption("Spank That Ass", Sta.GetIsInterfaceActive()))
		AddEmptyOption()
		
	ElseIf(page == "$SLS_pStatsInfo")
		SetCursorFillMode(TOP_TO_BOTTOM)
		Float CurrentTime = Utility.GetCurrentGameTime()
		
		AddHeaderOption("$SLS_pCum")
		AddTextOption("$SLS_LoadsSwallowed", Util.LoadsSwallowed)
		AddTextOption("$SLS_CumUnitsSwallowed", Util.CumUnitsSwallowed)
		AddTextOption("$SLS_LoadsSpat", Util.LoadsSpat)
		AddTextOption("$SLS_CumUnitsSpat", Util.CumUnitsSpat)
		AddTextOption("$SLS_LastLoadUnitSize", Util.LastLoadSize)
		AddEmptyOption()
		AddTextOption("$SLS_HumanoidLoads", Util.LoadsSwallowedHumanoid + " - (" + Util.CumUnitsSwallowedHumanoid + ")")
		AddTextOption("$SLS_DogLoads", StorageUtil.GetIntValue(_SLS_CumLactacidVoicesList.GetAt(3), "_SLS_LoadsSwallowed", Missing = 0) + " - (" + StorageUtil.GetFloatValue(_SLS_CumLactacidVoicesList.GetAt(3), "_SLS_CumUnitsSwallowed", Missing = 0.0) + ")")
		AddTextOption("$SLS_WolfLoads", StorageUtil.GetIntValue(_SLS_CumLactacidVoicesList.GetAt(25), "_SLS_LoadsSwallowed", Missing = 0) + " - (" + StorageUtil.GetFloatValue(_SLS_CumLactacidVoicesList.GetAt(25), "_SLS_CumUnitsSwallowed", Missing = 0.0) + ")")
		AddTextOption("$SLS_HorseLoads", StorageUtil.GetIntValue(_SLS_CumLactacidVoicesList.GetAt(18), "_SLS_LoadsSwallowed", Missing = 0) + " - (" + StorageUtil.GetFloatValue(_SLS_CumLactacidVoicesList.GetAt(18), "_SLS_CumUnitsSwallowed", Missing = 0.0) + ")")
		AddTextOption("$SLS_TrollLoads", StorageUtil.GetIntValue(_SLS_CumLactacidVoicesList.GetAt(23), "_SLS_LoadsSwallowed", Missing = 0) + " - (" + StorageUtil.GetFloatValue(_SLS_CumLactacidVoicesList.GetAt(23), "_SLS_CumUnitsSwallowed", Missing = 0.0) + ")")
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hFondling")
		AddTextOption("$SLS_CreaturesFondled", Util.CreatureFondleCount as Int)
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hAnimalFriendsLoyalty")
		Int i = 0
		ReferenceAlias AliasSelect
		While i < _SLS_AnimalFriendAliases.GetNumAliases()
			AliasSelect = _SLS_AnimalFriendAliases.GetNthAlias(i) as ReferenceAlias
			If AliasSelect.GetReference() != None
				;Debug.Messagebox("UpdateTime: " + (AliasSelect as _SLS_AnimalFriendAlias).UpdateTime)
				AddTextOption(i + ") " + AliasSelect.GetReference().GetBaseObject().GetName(),  (((AliasSelect as _SLS_AnimalFriendAlias).UpdateTime - CurrentTime) * 24.0) + " Hours")
			Else
				AddTextOption(i + ") None",  "0 Hours")
			EndIf
			i += 1
		EndWhile
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hWhoring")
		AddTextOption("$SLS_BegSexCount", Util.BegSexCount)
		AddTextOption("$SLS_BegBlowjobCount", Util.BegBlowjobs)
		AddTextOption("$SLS_BegLickingsCount", Util.BegLickings)
		AddTextOption("$SLS_BegVaginalSexCount", Util.BegVagSex)
		AddTextOption("$SLS_BegAnalSexCount", Util.BegAnalSex)
		AddTextOption("$SLS_BegGangbangCount", Util.BegGangbangs)
		AddEmptyOption()
		AddTextOption("$SLS_BegCreatureSexCount", Util.BegCreatureSexCount)
		AddTextOption("$SLS_BegDogSexCount", Util.BegDogSex)
		AddTextOption("$SLS_BegWolfSexCount", Util.BegWolfSex)
		AddTextOption("$SLS_BegHorseSexCount", Util.BegHorseSex)
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hThaneStatus")
		AddTextOption("$SLS_YouAreThaneOfWhiterun", LicUtil.IsThaneWhiterun)
		AddTextOption("$SLS_YouAreThaneOfSolitude", LicUtil.IsThaneSolitude)
		AddTextOption("$SLS_YouAreThaneOfMarkarth", LicUtil.IsThaneMarkarth)
		AddTextOption("$SLS_YouAreThaneOfWindhelm", LicUtil.IsThaneWindhelm)
		AddTextOption("$SLS_YouAreThaneOfRiften", LicUtil.IsThaneRiften)
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hBountiesLocBounty")
		AddTextOption("Whiterun", Eviction.CrimeFactionWhiterun.GetCrimeGold() + " - (" + Psc.GetPscBountyWhiterun() + ")")
		AddTextOption("Solitude", Eviction.CrimeFactionHaafingar.GetCrimeGold() + " - (" + Psc.GetPscBountySolitude() + ")")
		AddTextOption("Markarth", Eviction.CrimeFactionReach.GetCrimeGold() + " - (" + Psc.GetPscBountyMarkarth() + ")")
		AddTextOption("Windhelm", Eviction.CrimeFactionEastmarch.GetCrimeGold() + " - (" + Psc.GetPscBountyWindhelm() + ")")
		AddTextOption("Riften", Eviction.CrimeFactionRift.GetCrimeGold() + " - (" + Psc.GetPscBountyRiften() + ")")
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hYouAreEvictedIn")
		AddTextOption("Whiterun", (Eviction.OwnsWhiterun && Eviction.IsBarredWhiterun))
		AddTextOption("Solitude", (Eviction.OwnsSolitude && Eviction.IsBarredSolitude))
		AddTextOption("Markarth", (Eviction.OwnsMarkarth && Eviction.IsBarredMarkarth))
		AddTextOption("Windhelm", (Eviction.OwnsWindhelm && Eviction.IsBarredWindhelm))
		AddTextOption("Riften", (Eviction.OwnsRiften && Eviction.IsBarredRiften))
		AddEmptyOption()

		SetCursorPosition(1)
		AddHeaderOption("$SLS_hValidLicences")
		AddTextOption("$SLS_ArmorLicence", LicUtil.HasValidArmorLicence)
		AddTextOption("$SLS_BikiniLicence", LicUtil.HasValidBikiniLicence)
		AddTextOption("$SLS_WeaponLicence", LicUtil.HasValidWeaponLicence)
		AddTextOption("$SLS_MagicLicence", LicUtil.HasValidMagicLicence)
		AddTextOption("$SLS_ClothesLicence", LicUtil.HasValidClothesLicence)
		AddTextOption("$SLS_CurfewLicence", LicUtil.HasValidCurfewLicence)
		AddTextOption("$SLS_WhoreLicence", LicUtil.HasValidWhoreLicence)
		AddTextOption("$SLS_FreedomLicence", LicUtil.HasValidFreedomLicence)
		AddTextOption("$SLS_PropertyLicence", LicUtil.HasValidPropertyLicence)
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hValidUntil")
		AddTextOption("$SLS_CurrentTime", CurrentTime)
		AddTextOption("$SLS_ArmorLicence", LicUtil.NextArmorExpiry)
		AddTextOption("$SLS_BikiniLicence", LicUtil.NextBikiniExpiry)
		AddTextOption("$SLS_WeaponLicence", LicUtil.NextWeaponExpiry)
		AddTextOption("$SLS_MagicLicence", LicUtil.NextMagicExpiry)
		AddTextOption("$SLS_ClothesLicence", LicUtil.NextClothesExpiry)
		AddTextOption("$SLS_CurfewLicence", LicUtil.NextCurfewExpiry)
		AddTextOption("$SLS_WhoreLicence", LicUtil.NextWhoreExpiry)
		AddTextOption("$SLS_FreedomLicence", LicUtil.NextFreedomExpiry)
		AddTextOption("$SLS_PropertyLicence", LicUtil.NextPropertyExpiry)
		AddEmptyOption()
		
		If TollDodging
			AddHeaderOption("$SLS_hMandatoryRestraints")
			AddTextOption("$SLS_CurrentTime", CurrentTime)
			AddTextOption("Whiterun", "Level: " + TollDodge.RestraintLevelWhiterun + " Until: " + TollDodge.RestraintReqWhiterun)
			AddTextOption("Solitude", "Level: " + TollDodge.RestraintLevelSolitude + " Until: " + TollDodge.RestraintReqSolitude)
			AddTextOption("Markarth", "Level: " + TollDodge.RestraintLevelMarkarth + " Until: " + TollDodge.RestraintReqMarkarth)
			AddTextOption("Windhelm", "Level: " + TollDodge.RestraintLevelWindhelm + " Until: " + TollDodge.RestraintReqWindhelm)
			AddTextOption("Riften", "Level: " + TollDodge.RestraintLevelRiften + " Until: " + TollDodge.RestraintReqRiften)
			AddEmptyOption()
			
			AddHeaderOption("$SLS_hDodgedTollIn")
			TollDodgedWhiterunOID_T = AddTextOption("Whiterun", TollDodge.DodgedTollWhiterun)
			TollDodgedSolitudeOID_T = AddTextOption("Solitude", TollDodge.DodgedTollSolitude)
			TollDodgedMarkarthOID_T = AddTextOption("Markarth", TollDodge.DodgedTollMarkarth)
			TollDodgedWindhelmOID_T = AddTextOption("Windhelm", TollDodge.DodgedTollWindhelm)
			TollDodgedRiftenOID_T = AddTextOption("Riften", TollDodge.DodgedTollRiften)
			AddEmptyOption()
		EndIf
		
		AddHeaderOption("$SLS_hGroundedUntil")
		AddTextOption("$SLS_CurrentTime", CurrentTime)
		AddTextOption("Whiterun", TollUtil.GroundedUntilWhiterun)
		AddTextOption("Solitude", TollUtil.GroundedUntilSolitude)
		AddTextOption("Markarth", TollUtil.GroundedUntilMarkarth)
		AddTextOption("Windhelm", TollUtil.GroundedUntilWindhelm)
		AddTextOption("Riften", TollUtil.GroundedUntilRiften)
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hMandatoryGagUntil")
		AddTextOption("$SLS_CurrentTime", CurrentTime)
		AddTextOption("Whiterun", LicUtil.MandGagWhiterun)
		AddTextOption("Solitude", LicUtil.MandGagSolitude)
		AddTextOption("Markarth", LicUtil.MandGagMarkarth)
		AddTextOption("Windhelm", LicUtil.MandGagWindhelm)
		AddTextOption("Riften", LicUtil.MandGagRiften)
		AddEmptyOption()
		
	ElseIf(page == "$SLS_pStatsInfo2")
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$SLS_hMasturbationStats")
		AddTextOption("$SLS_MasturbationCount", StorageUtil.GetIntValue(PlayerRef, "_SLS_SexExperience", Missing = 0))
		AddTextOption("$SLS_MasturbationOrgasms", StorageUtil.GetIntValue(PlayerRef, "_SLS_MasturbationOrgasmCount", Missing = 0))
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hSexStatsHumans")
		AddTextOption("$SLS_HumanoidSexCountTotal", StorageUtil.GetIntValue(None, "_SLS_HumanSexCount", Missing = 0))
		AddTextOption("$SLS_PlayerOrgasmsWithHumans", StorageUtil.GetIntValue(None, "_SLS_HumanSexOrgasmCount", Missing = 0))
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hHumanRaceSexStats")
		AddTextOption("$SLS_GenericCustomFemale", StorageUtil.GetIntValue(None, "_SLS_SexExperienceGenericFemale", Missing = 0))
		AddTextOption("$SLS_GenericCustomMale", StorageUtil.GetIntValue(None, "_SLS_SexExperienceGenericMale", Missing = 0))
		
		Int i = 0
		Form akForm
		String RaceString
		While i < StorageUtil.FormListCount(None, "_SLS_HumanSexForms")
			akForm = StorageUtil.FormListGet(None, "_SLS_HumanSexForms", i)
			RaceString = TidyFormString(akForm)
			AddTextOption(RaceString + " Female", StorageUtil.GetIntValue(akForm, "_SLS_SexExperienceFemale", Missing = 0))
			AddTextOption(RaceString + " Male", StorageUtil.GetIntValue(akForm, "_SLS_SexExperienceMale", Missing = 0))
			i += 1
		EndWhile
		
		SetCursorPosition(1)
		AddHeaderOption("$SLS_hSexStatsCreatures")
		AddTextOption("$SLS_CreatureSexCountTotal", StorageUtil.GetIntValue(None, "_SLS_CreatureSexCount", Missing = 0))
		AddTextOption("$SLS_PlayerOrgasmsWithCreatures", StorageUtil.GetIntValue(None, "_SLS_CreatureSexOrgasmCount", Missing = 0))
		AddTextOption("$SLS_EffectiveCorruptionPoints", PapyrusUtil.ClampFloat(StorageUtil.GetFloatValue(None, "_SLS_CreatureCorruption", Missing = 0.0), 0.0, 100.0) as Int)
		AddEmptyOption()
		
		Race DremoraRace = Game.GetFormFromFile(0x131F0, "Skyrim.esm") as Race
		Int DremoraFemaleSexCount = StorageUtil.GetIntValue(DremoraRace, "_SLS_SexExperienceFemale", Missing = 0)
		Int DremoraMaleSexCount = StorageUtil.GetIntValue(DremoraRace, "_SLS_SexExperienceMale", Missing = 0)
		
		AddHeaderOption("$SLS_hSexStatsDremora")
		AddTextOption("$SLS_DremoraSexCountFemale", DremoraFemaleSexCount)
		AddTextOption("$SLS_DremoraSexCountMale", DremoraMaleSexCount)
		AddTextOption("$SLS_DremoraSexCountTotal", (DremoraMaleSexCount + DremoraFemaleSexCount))
		AddTextOption("$SLS_PlayerOrgasmsFromDremora", StorageUtil.GetIntValue(None, "_SLS_DremoraSexOrgasmCount", Missing = 0))
		AddEmptyOption()
		
		AddHeaderOption("$SLS_hCreatureRaceSexStats")
		i = 0
		While i < StorageUtil.FormListCount(None, "_SLS_CreatureSexForms")
			akForm = StorageUtil.FormListGet(None, "_SLS_CreatureSexForms", i)
			AddTextOption(TidyFormString(akForm), StorageUtil.GetIntValue(akForm, "_SLS_SexExperience", Missing = 0))
			i += 1
		EndWhile
	EndIf
EndEvent

event OnOptionHighlight(int option)
	If StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pSettings" ; <----------------->
		If(option == ImportSettingsOID_T)
			SetInfoText("$SLS_ImportSettings_Info")
		ElseIf(option == ExportSettingsOID_T)
			SetInfoText("$SLS_ExportSettings_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "AioFavoriteDB")
			SetInfoText("$SLS_AioFavoriteDB_Info")
		ElseIf Option == AllInOneKeyOID
			SetInfoText("$SLS_AllInOneKey_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "AllInOneStatusKeyOID")
			SetInfoText("$SLS_AllInOneStatusKey_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "OpenMouthKey")
			SetInfoText("$SLS_OpenMouthKey_Info")
		ElseIf(option == StorageUtil.GetIntValue(Self, "SLS_CombatEquipEnableOID"))
			SetInfoText("$SLS_CombatEquipEnable_Info")
		ElseIf(option == DropItemsOID)
			SetInfoText("$SLS_DropItems_Info")
		ElseIf(option == OrgasmRequiredOID)
			SetInfoText("$SLS_OrgasmRequired_Info")
		ElseIf(option == BarefootMagOIS_S)
			SetInfoText("$SLS_BarefootMag_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "BarefootStaggerChanceOID_S")
			SetInfoText("$SLS_BarefootStaggerChance_Info")
		ElseIf(option == HorseCostOIS_S)
			SetInfoText("$SLS_HorseCost_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "GrowthWeightGainOID_S")
			SetInfoText("$SLS_GrowthWeightGain_Info")
		ElseIf(option == EasyBedTrapsOID)
			SetInfoText("$SLS_EasyBedTraps_Info")
		ElseIf(option == HardcoreModeOID)
			SetInfoText("$SLS_HardcoreMode_Info")
		ElseIf(option == DebugModeOID)
			SetInfoText("$SLS_DebugMode_Info")
		ElseIf(option == StorageUtil.GetIntValue(Self, "SteepFall"))
			SetInfoText("$SLS_SteepFallEnable_Info")
		ElseIf(option == GoldWeightOID_S)
			SetInfoText("$SLS_GoldWeight_Info")
		ElseIf(option == FolGoldStealChanceOID_S)
			SetInfoText("$SLS_FolGoldStealChance_Info")
		ElseIf(option == FolGoldSteamAmountOID_S)
			SetInfoText("$SLS_FolGoldSteamAmount_Info")
		ElseIf(option == FastTravelDisableOID)
			SetInfoText("$SLS_FastTravelDisable_Info")
		ElseIf(option == FtDisableIsNormalOID)
			SetInfoText("$SLS_FtDisableIsNormal_Info")
		ElseIf(option == CompassHideMethodDB)
			SetInfoText("$SLS_CompassHideMethod_Info")
		ElseIf(option == CompassMechanicsOID)
			SetInfoText("$SLS_CompassMechanics_Info")
		ElseIf(option == ReplaceMapsOID)
			SetInfoText("$SLS_ReplaceMaps_Info")
		ElseIf(option == ReplaceMapsTimerOID_S)
			SetInfoText("$SLS_ReplaceMapsTimer_Info")
		ElseIf(option == ConstructableMapAndCompassOID)
			SetInfoText("$SLS_ConstructableMapAndCompass_Info")
		ElseIf(option == MinAvToggleOID)
			SetInfoText("$SLS_MinAvToggle_Info")
		ElseIf(option == MinSpeedOID_S)
			SetInfoText("$SLS_MinSpeed_Info")
		ElseIf(option == MinCarryWeightOID_S)
			SetInfoText("$SLS_MinCarryWeight_Info")
		ElseIf(option == SlaverunAutoStartOID)
			SetInfoText("$SLS_SlaverunAutoStart_Info")
		ElseIf(option == SlaverunAutoMinOID_S)
			SetInfoText("$SLS_SlaverunAutoMin_Info")
		ElseIf(option == SlaverunAutoMaxOID_S)
			SetInfoText("$SLS_SlaverunAutoMax_Info")
		ElseIf(option == DflowResistLossOID_S)
			SetInfoText("$SLS_DflowResistLoss_Info")
		ElseIf(option == HalfNakedEnableOID)
			SetInfoText("$SLS_HalfNakedEnable_Info")
		ElseIf(option == HalfNakedStripsOID)
			SetInfoText("$SLS_HalfNakedStrips_Info")
		ElseIf(option == HalfNakedBraOID_S)
			SetInfoText("$SLS_HalfNakedBra_Info")
		ElseIf(option == HalfNakedPantyOID_S)
			SetInfoText("$SLS_HalfNakedPanty_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "SlifBreastScaleMaxOID_S")
			SetInfoText("$SLS_SlifBreastScaleMax_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "SlifBellyScaleMaxOID_S")
			SetInfoText("$SLS_SlifBellyScaleMax_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "SlifAssScaleMaxOID_S")
			SetInfoText("$SLS_SlifAssScaleMax_Info")
		ElseIf(option == RunDevicePatchUpOID_T)
			SetInfoText("$SLS_RunDevicePatchUp_Info")
		ElseIf(option == DeviousGagDebuffOID_S)
			SetInfoText("$SLS_DeviousGagDebuff_Info")
		ElseIf(option == LicMagicChainCollarsOID)
			SetInfoText("$SLS_LicMagicChainCollars_Info")
		ElseIf(option == DeviousEffectsEnableOID)
			SetInfoText("$SLS_DeviousEffectsEnable_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "DeviousDrowningOID")
			SetInfoText("$SLS_DeviousDrowning_Info")
		ElseIf(option == DevEffLockpickDiffDB)
			SetInfoText("$SLS_DevEffLockpickDiff_Info")
		ElseIf(option == DevEffPickpocketDiffDB)
			SetInfoText("$SLS_DevEffPickpocketDiff_Info")
		ElseIf(option == DevEffNoGagTradingOID)
			SetInfoText("$SLS_DevEffNoGagTrading_Info")
		ElseIf(option == BondFurnEnableOID)
			SetInfoText("$SLS_BondFurnEnable_Info")
		ElseIf(option == BondFurnMilkFreqOID_S)
			SetInfoText("$SLS_BondFurnMilkFreq_Info")
		ElseIf(option == BondFurnMilkFatigueMultOID_S)
			SetInfoText("$SLS_BondFurnMilkFatigueMult_Info")
		ElseIf(option == BondFurnMilkWillOID_S)
			SetInfoText("$SLS_BondFurnMilkWill_Info")
		ElseIf(option == BondFurnFreqOID_S)
			SetInfoText("$SLS_BondFurnFreq_Info")
		ElseIf(option == BondFurnFatigueMultOID_S)
			SetInfoText("$SLS_BondFurnFatigueMult_Info")
		ElseIf(option == BondFurnWillOID_S)
			SetInfoText("$SLS_BondFurnWill_Info")
		ElseIf option == StorageUtil.GetIntValue(Self, "IntAproposTwoOID") || option == StorageUtil.GetIntValue(Self, "IntAmpOID") || option == StorageUtil.GetIntValue(Self, "IntDdsOID") || option == StorageUtil.GetIntValue(Self, "IntDfOID") || option == StorageUtil.GetIntValue(Self, "IntEsdOID") || option == StorageUtil.GetIntValue(Self, "IntEffOID") || option == StorageUtil.GetIntValue(Self, "IntFhuOID") || option == StorageUtil.GetIntValue(Self, "IntFrostfallOID") || option == StorageUtil.GetIntValue(Self, "IntIneedOID")|| option == StorageUtil.GetIntValue(Self, "IntMaOID") || option == StorageUtil.GetIntValue(Self, "IntPscOID") || option == StorageUtil.GetIntValue(Self, "IntRndOID") || option == StorageUtil.GetIntValue(Self, "IntSlaxOID") || option == StorageUtil.GetIntValue(Self, "IntSlsoOID") || option == StorageUtil.GetIntValue(Self, "IntSlsfOID") || option == StorageUtil.GetIntValue(Self, "IntSlaverunOID") || option == StorageUtil.GetIntValue(Self, "IntTatsOID") || option == StorageUtil.GetIntValue(Self, "IntSgoOID") || option == StorageUtil.GetIntValue(Self, "IntStaOID") || option == StorageUtil.GetIntValue(Self, "IntBisOID") || option == StorageUtil.GetIntValue(Self, "IntSexyMoveOID")
			SetInfoText("$SLS_IntAproposTwo_Info")
		ElseIf(option == LicShowApiBlockFormsOID_T)
			SetInfoText("$SLS_LicShowApiBlockForms_Info")
		ElseIf(option == LicClearApiBlockFormsOID_T)
			SetInfoText("$SLS_LicClearApiBlockForms_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "EasyHomeWhiterunOID") || Option == StorageUtil.GetIntValue(Self, "EasyHomeSolitudeOID") || Option == StorageUtil.GetIntValue(Self, "EasyHomeMarkarthOID") || Option == StorageUtil.GetIntValue(Self, "EasyHomeWindhelmOID") || Option == StorageUtil.GetIntValue(Self, "EasyHomeRiftenOID")
			SetInfoText("$SLS_EasyHome_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "HomeCostWhiterunOID_S") || StorageUtil.GetIntValue(Self, "HomeCostSolitudeOID_S") || StorageUtil.GetIntValue(Self, "HomeCostMarkarthOID_S") || StorageUtil.GetIntValue(Self, "HomeCostWindhelmOID_S") || StorageUtil.GetIntValue(Self, "HomeCostRiftenOID_S")
			SetInfoText("$SLS_HomeCost_Info")
		EndIf
	
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pSexEffects" ; <----------------->
		If(option == SlsCreatureEventOID)
			SetInfoText("$SLS_SlsCreatureEvent_Info")
		ElseIf option == StorageUtil.GetIntValue(Self, "AhegaoEnableOID")
			SetInfoText("$SLS_AhegaoEnable_Info")
		ElseIf option == StorageUtil.GetIntValue(Self, "AhegaoDurPerOrgasmOID_S")
			SetInfoText("When ahegao face conditions are reached you will keep the face for 6 seconds + (this slider X your orgasm count)\nThe more times you cum the longer you keep the face")
		ElseIf(option == SexExpEnableOID)
			SetInfoText("$SLS_SexExpEnable_Info")
		ElseIf(option == DremoraCorruptionOID)
			SetInfoText("$SLS_DremoraCorruption_Info")
		ElseIf(option == SexExpCorruptionDB)
			SetInfoText("$SLS_SexExpCorruption_Info")
		ElseIf(option == SexExpResetStatsOID_T)
			SetInfoText("$SLS_SexExpResetStats_Info")

		ElseIf Option == StorageUtil.GetIntValue(Self, "JigglesOID")
			SetInfoText("$SLS_Jiggles_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "JigglesVisualsOID")
			SetInfoText("$SLS_JigglesVisuals_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "CompulsiveSexOID")
			SetInfoText("$SLS_CompulsiveSex_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "CompulsiveSexFuckTimeOID_S")
			SetInfoText("$SLS_CompulsiveSexFuckTime_Info")
		
		ElseIf Option == StorageUtil.GetIntValue(Self, "OrgasmFatigueOID")
			SetInfoText("$SLS_OrgasmFatigue_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "OrgasmFatigueThresholdOID_S")
			SetInfoText("$SLS_OrgasmFatigueThreshold_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "OrgasmFatigueRecoveryOID_S")
			SetInfoText("$SLS_OrgasmFatigueRecovery_Info")
		
		ElseIf Option == StorageUtil.GetIntValue(Self, "RapeDrugLactacidOID")
			SetInfoText("$SLS_RapeDrugLactacid_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "RapeDrugSkoomaOID")
			SetInfoText("$SLS_RapeDrugSkooma_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "RapeDrugCumHumanOID")
			SetInfoText("$SLS_RapeDrugCumHuman_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "RapeDrugCumCreatureOID")
			SetInfoText("$SLS_RapeDrugCumCreature_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "RapeDrugInflateOID")
			SetInfoText("$SLS_RapeDrugInflate_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "RapeDrugFmFertilityOID")
			SetInfoText("$SLS_RapeDrugFmFertility_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "RapeDrugSlenAphrodisiacOID")
			SetInfoText("$SLS_RapeDrugSlenAphrodisiac_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "RapeDrugSensitivityOID")
			SetInfoText("$SLS_RapeDrugSensitivity_Info")
		
		ElseIf Option == StorageUtil.GetIntValue(Self, "FashionRapeHaircutChanceOID_S")
			SetInfoText("$SLS_FashionRapeHaircutChance_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "FashionRapeHairCutMinOID_S")
			SetInfoText("$SLS_FashionRapeHairCutMin_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "FashionRapeHairCutMaxOID_S")
			SetInfoText("$SLS_FashionRapeHairCutMax_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "FashionRapeHairCutFloorOID_S")
			SetInfoText("$SLS_FashionRapeHairCutFloor_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "FashionRapeDyeHairChanceOID_S")
			SetInfoText("$SLS_FashionRapeDyeHairChance_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "FashionRapeShavePussyChanceOID_S")
			SetInfoText("$SLS_FashionRapeShavePussyChance_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "FashionRapeLipstickChanceOID_S")
			SetInfoText("$SLS_FashionRapeLipstickChance_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "FashionRapeEyeshadowChanceOID_S")
			SetInfoText("$SLS_FashionRapeEyeshadowChance_Info")
		
		ElseIf (option == SexMinStaminaRateOID_S)
			SetInfoText("$SLS_SexMinStaminaRate_Info")	
		ElseIf (option == SexMinStaminaMultOID_S)
			SetInfoText("$SLS_SexMinStaminaMult_Info")
		ElseIf (option == SexMinMagickaRateOID_S)
			SetInfoText("$SLS_SexMinMagickaRate_Info")
		ElseIf (option == SexMinMagickaMultOID_S)
			SetInfoText("$SLS_SexMinMagickaMult_Info")
		ElseIf (option == SexMinStamMagRatesOID)
			SetInfoText("$SLS_SexMinStamMagRates_Info")
		ElseIf (option == SexRapeDrainsAttributesOID)
			SetInfoText("$SLS_SexRapeDrainsAttributes_Info")
		ElseIf(option == SexExpCorruptionCurrentOID_S)
			SetInfoText("$SLS_SexExpCorruptionCurrent_Info")
		ElseIf(option == CockSizeBonusEnjFreqOID_S)
			SetInfoText("$SLS_CockSizeBonusEnjFreq_Info")
		ElseIf(option == RapeForcedSkoomaChanceOID_S)
			SetInfoText("$SLS_RapeForcedSkoomaChance_Info")
		ElseIf(option == RapeMinArousalOID_S)
			SetInfoText("$SLS_RapeMinArousal_Info")
		ElseIf(option == AddFondleToListOID_T) || (option == RemoveFondleFromListOID_T)
			SetInfoText("$SLS_AddFondleToList_Info")
		ElseIf(option == FondleInfoOID_T)
			SetInfoText("$SLS_FondleInfo_Info")
		ElseIf(option == AnimalBreedEnableOID)
			SetInfoText("$SLS_WildlingEnable_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "WildlingPointsLossRate")
			SetInfoText("$SLS_WildlingPointsLossRate_Info")	
		ElseIf Option == StorageUtil.GetIntValue(Self, "AllurePerLevel")
			SetInfoText("$SLS_AllurePerLevel_Info")	
		ElseIf(option == AfCooloffBaseOID_S)
			SetInfoText("$SLS_AfCooloffBase_Info")
		ElseIf(option == AfCooloffBodyCumOID_S)
			SetInfoText("$SLS_AfCooloffBodyCum_Info")
		ElseIf(option == AfCooloffCumInflationOID_S)
			SetInfoText("$SLS_AfCooloffCumInflation_Info")
		ElseIf(option == AfCooloffPregnancyOID_S)
			SetInfoText("$SLS_AfCooloffPregnancy_Info")
		ElseIf(option == AfCooloffCumSwallowOID_S)
			SetInfoText("$SLS_AfCooloffCumSwallow_Info")
		EndIf
		
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pMisogynyInequality" ; <----------------->
		If Option == PushEventsDB
			SetInfoText("$SLS_PushEvents_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "PushCooldownOID_S")
			SetInfoText("$SLS_PushCooldown_Info")
		ElseIf(option == CatCallVolOIS_S)
			SetInfoText("$SLS_CatCallVol_Info")
		ElseIf(option == CatCallWillLossOIS_S)
			SetInfoText("$SLS_CatCallWillLoss_Info")
		ElseIf(option == GreetDistOIS_S)
			SetInfoText("$SLS_GreetDist_Info")
			ElseIf(option == AssSlappingOID)
			SetInfoText("$SLS_AssSlapping_Info")
		ElseIf(option == CoverMyselfMechanicsOID)
			SetInfoText("$SLS_CoverMyselfMechanics_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "NpcCommentsOID")
			SetInfoText("$SLS_NpcComments_Info")
		ElseIf(option == AssSlapResistLossOID_S)
			SetInfoText("$SLS_AssSlapResistLoss_Info")
		
		ElseIf(option == ProxSpankNpcDB)
			SetInfoText("$SLS_ProxSpankNpc_Info")
		ElseIf(option == ProxSpankCoverDB)
			SetInfoText("$SLS_ProxSpankCover_Info")		
		ElseIf(option == ProxSpankCooloffOID_S)
			SetInfoText("$SLS_ProxSpankCooloff_Info")
		ElseIf(option == ProxSpankCommentOID)
			SetInfoText("$SLS_ProxSpankComment_Info")

		ElseIf(option == IneqStatsOID)
			SetInfoText("$SLS_IneqStats_Info")
		ElseIf(option == IneqStatsValOID)
			SetInfoText("$SLS_IneqStatsVal_Info")
		ElseIf(option == IneqHealthCushionOID)
			SetInfoText("$SLS_IneqHealthCushion_Info")
		ElseIf(option == IneqCarryOID)
			SetInfoText("$SLS_IneqCarry_Info")
		ElseIf(option == IneqCarryValOID)
			SetInfoText("$SLS_IneqCarryVal_Info")
		ElseIf(option == InqSpeedOID)
			SetInfoText("$SLS_InqSpeed_Info")
		ElseIf(option == IneqSpeedValOID)
			SetInfoText("$SLS_IneqSpeedVal_Info")
		ElseIf(option == IneqDamageOID)
			SetInfoText("$SLS_IneqDamage_Info")
		ElseIf(option == IneqDamageValOID)
			SetInfoText("$SLS_IneqDamageVal_Info")
		ElseIf(option == IneqDestOID)
			SetInfoText("$SLS_IneqDest_Info")
		ElseIf(option == IneqDestValOID)
			SetInfoText("$SLS_IneqDestVal_Info")
		ElseIf(option == IneqSkillsOID)
			SetInfoText("$SLS_IneqSkills_Info")
		ElseIf(option == IneqBuySellOID)
			SetInfoText("$SLS_IneqBuySell_Info")
		ElseIf(option == IneqVendorGoldOID)
			SetInfoText("$SLS_IneqVendorGold_Info")
		ElseIf(option == IneqStrongFemaleFollowersOID)
			SetInfoText("$SLS_IneqStrongFemaleFollowers_Info")
		ElseIf(option == ModStrongFemaleOID_T)
			SetInfoText("$SLS_ModStrongFemale_Info")
		ElseIf(option == GuardCommentsOID)
			SetInfoText("$SLS_GuardComments_Info")
		ElseIf(option == GuardBehavWeapDropOID)
			SetInfoText("$SLS_GuardBehavWeapDrop_Info")
		ElseIf(option == GuardBehavWeapDrawnOID)
			SetInfoText("$SLS_GuardBehavWeapDrawn_Info")
		ElseIf(option == GuardBehavWeapEquipOID)
			SetInfoText("$SLS_GuardBehavWeapEquip_Info")
		ElseIf(option == GuardBehavArmorEquipOID)
			SetInfoText("$SLS_GuardBehavArmorEquip_Info")
		
		ElseIf Option == StorageUtil.GetIntValue(Self, "GuardBehavArmorEquipAnyArmorOID")
			SetInfoText("$SLS_GuardBehavArmorEquipAnyArmor_Info")
		ElseIf(option == GuardBehavLockpickingOID)
			SetInfoText("$SLS_GuardBehavLockpicking_Info")
		ElseIf(option == GuardBehavDrugsOID)
			SetInfoText("$SLS_GuardBehavDrugs_Info")
		ElseIf(option == GuardBehavShoutOID)
			SetInfoText("$SLS_GuardBehavShout_Info")
		EndIf
		
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pTrauma" ; <----------------->
		If Option == StorageUtil.GetIntValue(Self, "TraumaPainSoundVolOID_S")
			SetInfoText("$SLS_TraumaPainSoundVol_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaHitSoundVolOID_S")
			SetInfoText("$SLS_TraumaHitSoundVol")
		
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaEnableOID")
			SetInfoText("$SLS_TraumaEnable_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaRebuildTexturesOID_T")
			SetInfoText("$SLS_TraumaRebuildTextures_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaDynamicOID")
			SetInfoText("$SLS_TraumaDynamic_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaDynamicCombatOID")
			SetInfoText("$SLS_TraumaDynamicCombat_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaTrackFollowerOID_T")
			SetInfoText("$SLS_TraumaTrackFollower_Info")

		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaCountMaxPlayerOID_S")
			SetInfoText("$SLS_TraumaCountMaxPlayer_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaCountMaxFollowerOID_S")
			SetInfoText("$SLS_TraumaCountMaxFollower_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaCountMaxNpcOID_S")
			SetInfoText("$SLS_TraumaCountMaxNpc_Info")
		
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaStartingOpacityOID_S")
			SetInfoText("$SLS_TraumaStartingOpacity_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaMaximumOpacityOID_S")
			SetInfoText("$SLS_TraumaMaximumOpacity_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaHoursToFadeInOID_S")
			SetInfoText("$SLS_TraumaHoursToFadeIn_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaHoursToFadeOutOID_S")
			SetInfoText("$SLS_TraumaHoursToFadeOut_Info")
			
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaSexChancePlayerOID_S")
			SetInfoText("$SLS_TraumaSexChancePlayer_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaSexChanceFollowerOID_S")
			SetInfoText("$SLS_TraumaSexChanceFollower_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaSexChanceOID_S")
			SetInfoText("$SLS_TraumaSexChance_Info")
		
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaSexHitsPlayerOID_S")
			SetInfoText("$SLS_TraumaSexHitsPlayer_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaSexHitsFollowerOID_S")
			SetInfoText("$SLS_TraumaSexHitsFollower_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaSexHitsOID_S")
			SetInfoText("$SLS_TraumaSexHits_Info")
		
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaPlayerSqueaksOID")
			SetInfoText("$SLS_TraumaPlayerSqueaks_Info")	
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaDamageThresholdOID_S")
			SetInfoText("$SLS_TraumaDamageThreshold_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaCombatChancePlayerOID_S")
			SetInfoText("$SLS_TraumaCombatChancePlayer_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaCombatChanceFollowerOID_S")
			SetInfoText("$SLS_TraumaCombatChanceFollower_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaCombatChanceOID_S")
			SetInfoText("$SLS_TraumaCombatChance_Info")
			
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaPushChancePlayerOID_S")
			SetInfoText("$SLS_TraumaPushChancePlayer_Info")
		EndIf
		
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pNeeds" ; <----------------->
		If(option == GluttedSpeedMultOID_S)
			SetInfoText("$SLS_GluttedSpeedMult_Info")
		ElseIf(option == SleepDeprivOID)
			SetInfoText("$SLS_SleepDepriv_Info")
		ElseIf(option == CumFoodMultOID_S)
			SetInfoText("$SLS_CumFoodMult_Info")
		ElseIf(option == CumDrinkMultOID_S)
			SetInfoText("$SLS_CumDrinkMult_Info")
		ElseIf(option == SaltyCumOID)
			SetInfoText("$SLS_SaltyCum_Info")
		ElseIf(option == SkoomaSleepOID_S)
			SetInfoText("$SLS_SkoomaSleep_Info")
		ElseIf(option == MilkSleepMultOID_S)
			SetInfoText("$SLS_MilkSleepMult_Info")
		ElseIf(option == DrugEndFatigueIncOID_S)
			SetInfoText("$SLS_DrugEndFatigueInc_Info")
			
		ElseIf(option == BellyScaleEnableOID)
			SetInfoText("$SLS_BellyScaleEnable_Info")
		ElseIf(option == BaseBellyScaleOID_S)
			SetInfoText("$SLS_BaseBellyScale_Info")
		ElseIf(option == BellyScaleRnd00OID_S)
			SetInfoText("$SLS_BellyScaleRnd00_Info")
		ElseIf(option == BellyScaleRnd01OID_S)
			SetInfoText("$SLS_BellyScale_Info")
		ElseIf(option == BellyScaleRnd02OID_S)
			SetInfoText("$SLS_BellyScaleRnd02_Info")
		ElseIf(option == BellyScaleRnd03OID_S)
			SetInfoText("$SLS_BellyScaleRnd03_Info")
		ElseIf(option == BellyScaleRnd04OID_S)
			SetInfoText("$SLS_BellyScaleRnd04_Info")
		ElseIf(option == BellyScaleRnd05OID_S)
			SetInfoText("$SLS_BellyScaleRnd05_Info")
			
		ElseIf(option == BellyScaleIneed00OID_S)
			SetInfoText("$SLS_BellyScale_Info")
		ElseIf(option == BellyScaleIneed01OID_S)
			SetInfoText("$SLS_BellyScaleIneed01_Info")
		ElseIf(option == BellyScaleIneed02OID_S)
			SetInfoText("$SLS_BellyScaleIneed02_Info")
		ElseIf(option == BellyScaleIneed03OID_S)
			SetInfoText("$SLS_BellyScaleIneed03_Info")
		EndIf	
		
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pCum" ; <----------------->
		If(option == AproTwoTrollHealAmountOID)
			SetInfoText("$SLS_AproTwoTrollHealAmount_Info")
		ElseIf(option == CumBreathOID)
			SetInfoText("$SLS_CumBreath_Info")
		ElseIf(option == CumBreathNotifyOID)
			SetInfoText("$SLS_CumBreathNotify_Info")	
		ElseIf(option == CumSwallowInflateOID)
			SetInfoText("$SLS_CumSwallowInflate_Info")
		ElseIf(option == CumSwallowInflateMultOID_S)
			SetInfoText("$SLS_CumSwallowInflateMult_Info")
		ElseIf(option == CumEffectsEnableOID)
			SetInfoText("$SLS_CumEffectsEnable_Info")
		ElseIf(option == CumEffectsStackOID)
			SetInfoText("$SLS_CumEffectsStack_Info")
		ElseIf(option == CumEffectsMagMultOID_S)
			SetInfoText("$SLS_CumEffectsMagMult_Info")
		ElseIf(option == CumEffectsDurMultOID_S)
			SetInfoText("$SLS_CumEffectsDurMult_Info")
		ElseIf(option == CumpulsionChanceOID_S)
			SetInfoText("$SLS_CumpulsionChance_Info")
		ElseIf(option == CumRegenTimeOID_S)
			SetInfoText("$SLS_CumRegenTime_Info")
		ElseIf(option == CumEffectVolThresOID_S)
			SetInfoText("$SLS_CumEffectVolThres_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "CumInsideBonusEnjOID_S")
			SetInfoText("$SLS_CumInsideBonusEnj_Info")
		ElseIf(option == SuccubusCumSwallowEnergyMultOID_S)
			SetInfoText("$SLS_SuccubusCumSwallowEnergyMult_Info")
		ElseIf(option == SuccubusCumSwallowEnergyPerRankOID)
			SetInfoText("$SLS_SuccubusCumSwallowEnergyPerRank_Info")
		ElseIf(option == CumAddictEnOID)
			SetInfoText("$SLS_CumAddictEn_Info")
		ElseIf(option == CumAddictBeastLevelsOID)
			SetInfoText("$SLS_CumAddictBeastLevels_Info")
		ElseIf(option == CumAddictHungerRateOID_S)
			SetInfoText("$SLS_CumAddictHungerRate_Info")
		ElseIf(option == CumAddictHungerRateEffective)
			SetInfoText("$SLS_CumAddictHungerRateEffective_Info")
		ElseIf(option == CumAddictClampHungerOID)
			SetInfoText("$SLS_CumAddictClampHunger_Info")
		ElseIf(option == CumAddictionSpeedOID_S)
			SetInfoText("$SLS_CumAddictionSpeed_Info")
		ElseIf(option == CumAddictionPerHourOID_S)
			SetInfoText("$SLS_CumAddictionPerHour_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "CumAddictBlockDecayOID")
			SetInfoText("$SLS_CumAddictBlockDecay_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "CumAddictDayDreamOID")
			SetInfoText("$SLS_CumAddictDayDream_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "CumAddictDayDreamArousalOID_S")
			SetInfoText("$SLS_CumAddictDayDreamArousal_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "CumAddictDayDreamVolOID_S")
			SetInfoText("$SLS_CumAddictDayDreamVol_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "CumAddictDayDreamButterflysOID")
			SetInfoText("$SLS_CumAddictDayDreamButterflys_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "DayDreamVoicesChanceOID_S")
			SetInfoText("Lower this if you feel voices in your head urging you to suck dicks are too frequent\nSet to zero to disable the voices in your head")
		ElseIf Option == StorageUtil.GetIntValue(Self, "DayDreamVoicesVolumeOID_S")
			SetInfoText("Set the volume of the voices in your head")
		ElseIf Option == StorageUtil.GetIntValue(Self, "DayDreamVanillaVoiceVolumeOID_S")
			SetInfoText("Set this to whatever you use for the volume of vanilla voices in your system settings menu\nSLS lowers the volume of regular voices while the voices in your head take over. But there's no GetVolume function to save what you've got in settings. So set it here and the mod will apply it again when the voices are finished urging you to suck cocks")

		ElseIf(option == CumSatiationOID_S)
			SetInfoText("$SLS_CumSatiation_Info")
		ElseIf(option == MilkDecCumBreathOID)
			SetInfoText("$SLS_MilkDecCumBreath_Info")
		
		ElseIf(option == CumAddictBatheRefuseTimeOID_S)
			SetInfoText("$SLS_CumAddictBatheRefuseTime_Info")
		ElseIf(option == CumAddictReflexSwallowOID_S)
			SetInfoText("$SLS_CumAddictReflexSwallow_Info")
		ElseIf(option == CumAddictAutoSuckCreatureOID_S)
			SetInfoText("$SLS_CumAddictAutoSuckCreature_Info")
		ElseIf(option == CumAddictAutoSuckStageDB)
			SetInfoText("$SLS_CumAddictAutoSuckStage_Info")
		ElseIf(option == CumAddictAutoSuckCooldownOID_S)
			SetInfoText("$SLS_CumAddictAutoSuckCooldown_Info")
		ElseIf(option == CumAddictAutoSuckCreatureArousalOID_S)
			SetInfoText("$SLS_CumAddictAutoSuckCreatureArousal_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "CumAddictAutoSuckVictim")
			SetInfoText("$SLS_CumAddictAutoSuckVictim_Info")

		ElseIf(option == CumIsLactacidOID_S)
			SetInfoText("$SLS_CumIsLactacid_Info")
		ElseIf(option == CumLactacidAllOID)
			SetInfoText("$SLS_CumLactacidAll_Info")
		ElseIf(option == CumLactacidCustomOID_T)
			SetInfoText("$SLS_CumLactacidCustom_Info")
		ElseIf(option == CumLactacidAllPlayableOID)
			SetInfoText("$SLS_CumLactacidAllPlayable_Info")
		EndIf
		
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pFrostfallSimplyKnock" ; <----------------->
		; Frostfall
		If(option == WarmBodiesOID_S)
			SetInfoText("$SLS_WarmBodies_Info")
		ElseIf(option == CumWetMultOID_S)
			SetInfoText("$SLS_CumWetMult_Info")
		ElseIf(option == CumExposureMultOID_S)
			SetInfoText("$SLS_CumExposureMult_Info")
		ElseIf(option == MilkLeakWetOID_S)
			SetInfoText("$SLS_MilkSleepMult_Info")
		ElseIf(option == SwimCumCleanOID_S)
			SetInfoText("$SLS_SwimCumClean_Info")
		
		ElseIf(option == FfRescueEventsOID)
			SetInfoText("$SLS_FfRescueEvents_Info")
		
		ElseIf(option == SimpleSlaveryFFOID_S)
			SetInfoText("$SLS_SimpleSlaveryFF_Info")
		ElseIf(option == SdDreamFFOID_S)
			SetInfoText("$SLS_SdDreamFF_Info")
		
		; Simply Knock
		ElseIf(option == NormalKnockDialogOID)
			SetInfoText("$SLS_NormalKnockDialog_Info")
		ElseIf(option == KnockSlaveryChanceOID_S)
			SetInfoText("$SLS_KnockSlaveryChance_Info")
		ElseIf(option == SimpleSlaveryWeightOID_S)
			SetInfoText("$SLS_SimpleSlaveryWeight_Info")
		ElseIf(option == SdWeightOID_S)
			SetInfoText("$SLS_SdWeight_Info")
		EndIf
		
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pTollsEvictionGates" ; <----------------->
		If(option == CurrentLocationOID_T)
			SetInfoText("$SLS_CurrentLocation_Info")
		ElseIf(option == AddTownLocationOID_T)
			SetInfoText("$SLS_AddTownLocation_Info")
		ElseIf(option == RemoveTownLocationOID_T)
			SetInfoText("$SLS_RemoveTownLocation_Info")
			
		ElseIf(option == EvictionLimitOID_S)
			SetInfoText("$SLS_EvictionLimit_Info")
		ElseIf(option == SlaverunEvictionLimitOID_S)
			SetInfoText("$SLS_SlaverunEvictionLimit_Info")
		ElseIf(option == ConfiscationFineOID_S)
			SetInfoText("$SLS_ConfiscationFine_Info")
		ElseIf(option == ConfiscationFineSlaverunOID_S)
			SetInfoText("$SLS_ ConfiscationFineSlaverun_Info")
		ElseIf option == StorageUtil.GetIntValue(Self, "TollsEnableOID")
			SetInfoText("$SLS_TollsEnable_Info")
		ElseIf option == StorageUtil.GetIntValue(Self, "ResidentsDontPayTollsOID")
			SetInfoText("$SLS_ResidentsDontPayTolls_Info")
		ElseIf(option == DoorLockDownOID)
			SetInfoText("$SLS_DoorLockDown_Info")
		ElseIf(option == TollFollowersHardcoreOID)
			SetInfoText("$SLS_TollFollowersHardcore_Info")
		ElseIf(option == TollFollowersOID_S)
			SetInfoText("$SLS_TollFollowers_Info")
		ElseIf(option == TollSexAggDB)
			SetInfoText("$SLS_TollSexAgg_Info")
		ElseIf(option == TollSexVictimDB)
			SetInfoText("$SLS_TollSexVictim_Info")
		ElseIf(option == TollCostGoldOID_S)
			SetInfoText("$SLS_TollCostGold_Info")
		ElseIf(option == GoldPerLevelOID)
			SetInfoText("$SLS_GoldPerLevel_Info")
		ElseIf(option == SlaverunFactorOID)
			SetInfoText("$SLS_SlaverunFacto_Info")
		ElseIf(option == SlaverunJobFactorOID)
			SetInfoText("$SLS_SlaverunJobFactor_Info")
		ElseIf(option == TollCostDevicesOID_S)
			SetInfoText("$SLS_TollCostDevices_Info")
		ElseIf(option == TollCostTattoosOID_S)
			SetInfoText("$SLS_TollCostTattoos_Info")
		ElseIf(option == TollCostDrugsOID_S)
			SetInfoText("$SLS_TollCostDrugs_Info")
			
		ElseIf(option == TollDodgingOID)
			SetInfoText("$SLS_TollDodging_Info")
		ElseIf(option == TollDodgeGracePeriodOID_S)
			SetInfoText("$SLS_TollDodgeGracePeriod_Info")
		ElseIf(option == TollDodgeHuntFreqOID_S)
			SetInfoText("$SLS_TollDodgeHuntFreq_Info")
		ElseIf(option == TollDodgeMaxGuardsOID_S)
			SetInfoText("$SLS_TollDodgeMaxGuards_Info")
		ElseIf(option == TollDodgeDetectDistMaxOID_S)
			SetInfoText("$SLS_TollDodgeDetectDistMax_Info")
		ElseIf(option == TollDodgeDetectDistTownMaxOID_S)
			SetInfoText("$SLS_TollDodgeDetectDistTownMax_Info")
		ElseIf(option == TollDodgeDisguiseBodyPenaltyOID_S)
			SetInfoText("$SLS_TollDodgeDisguiseBodyPenalty_Info")
		ElseIf(option == TollDodgeDisguiseHeadPenaltyOID_S)
			SetInfoText("$SLS_TollDodgeDisguiseHeadPenalty_Info")
		ElseIf(option == TollDodgeCurrentSpotDist)
			SetInfoText("$SLS_TollDodgeCurrentSpotDist_Info")
			
		ElseIf(option == TollDodgeCurrentSpotDistTown)
			SetInfoText("$SLS_TollDodgeCurrentSpotDistTown_Info")

		ElseIf(option == TollDodgeGiftMenuOID)
			SetInfoText("$SLS_TollDodgeGiftMenu_Info")
		ElseIf(option == TollDodgeItemValueModOID_S)
			SetInfoText("$SLS_TollDodgeItemValueMod_Info")

		ElseIf(option == CurfewEnableOID)
			SetInfoText("$SLS_CurfewEnable_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "GateCurfewBeginOID_S")
			SetInfoText("$SLS_GateCurfewBegin_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "GateCurfewEndOID_S")
			SetInfoText("$SLS_GateCurfewEnd_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "GateCurfewSlavetownBeginOID_S")
			SetInfoText("$SLS_GateCurfewSlavetownBegin_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "GateCurfewSlavetownEndOID_S")
			SetInfoText("$SLS_GateCurfewSlavetownEnd_Info")
		ElseIf(option == MaxTatsBodyOID_S)
			SetInfoText("$SLS_MaxTatsBody_Info")
		ElseIf(option == MaxTatsFaceOID_S)
			SetInfoText("$SLS_MaxTatsFace_Info")
		ElseIf(option == MaxTatsHandsOID_S)
			SetInfoText("$SLS_MaxTatsHands_Info")
		ElseIf(option == MaxTatsFeetOID_S)
			SetInfoText("$SLS_MaxTatsFeet_Info")
			
		ElseIf Option == StorageUtil.GetIntValue(Self, "TollDrugLactacidOID")
			SetInfoText("$SLS_TollDrugLactacid_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "TollDrugSkoomaOID")
			SetInfoText("$SLS_TollDrugSkooma_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "TollDrugCumHumanOID")
			SetInfoText("$SLS_TollDrugCumHuman_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "TollDrugCumCreatureOID")
			SetInfoText("$SLS_TollDrugCumCreature_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "TollDrugInflateOID")
			SetInfoText("$SLS_TollDrugInflat_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "TollDrugFmFertilityOID")
			SetInfoText("$SLS_TollDrugFmFertility_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "TollDrugSlenAphrodisiacOID")
			SetInfoText("$SLS_TollDrugSlenAphrodisiac_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "TollDrugSensitivityOID")
			SetInfoText("$SLS_TollDrugSensitivity_Info")
		EndIf
		
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pLicences1" ; <----------------->
		If(option == LicencesEnableOID)
			SetInfoText("$SLS_LicencesEnable_Info")
		ElseIf(option == LicencesSnowberryOID)
			SetInfoText("$SLS_LicencesSnowberry_Info")
		ElseIf(option == LicenceStyleDB)
			SetInfoText("$SLS_LicenceStyle_Info")
		ElseIf(option == BikiniLicFirstOID)
			SetInfoText("$SLS_BikiniLicFirst_Info")
		ElseIf(option == FollowerLicStyleDB)
			SetInfoText("$SLS_FollowerLicStyle_Info")
		ElseIf(option == LicUnlockCostOID_S)
			SetInfoText("$SLS_LicUnlockCost_Info")
		ElseIf(option == LicBlockChanceOID_S)
			SetInfoText("$SLS_LicBlockChance_Info")
		ElseIf(option == LicBuyBackOID)
			SetInfoText("$SLS_LicBuyBack_Info")
		ElseIf(option == LicBuyBackPriceDB)
			SetInfoText("$SLS_LicBuyBackPrice_Info")
		ElseIf(option == LicBountyMustBePaidOID)
			SetInfoText("$SLS_LicBountyMustBePaid_Info")
		ElseIf option == StorageUtil.GetIntValue(Self, "LicCheckFollowers")
			SetInfoText("If enabled then followers will be included in contraband checks and any qualifying items will be confiscated\nIf disabled then any items in your follower's inventory will be ignored and they are excluded from checks.")
		ElseIf option == StorageUtil.GetIntValue(Self, "LicForceCheckDeviousFollower")
			SetInfoText("Force check your followers inventory even if they are your devious follower\nEnabled is the way SLS has worked in the past. Disabled will probably be the way of the future when DFC starts having the DF manage their own inventory (and yours possibly as well)")
		ElseIf(option == FolContraBlockOID)
			SetInfoText("$SLS_FolContraBlock_Info")
		ElseIf(option == FolContraKeysOID)
			SetInfoText("$SLS_FolContraKeys_Info")
		ElseIf(option == FolTakeClothesOID)
			SetInfoText("$SLS_FolTakeClothes_Info")
		ElseIf(option == OrdinSupressOID)
			SetInfoText("$SLS_OrdinSupress_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "WetLicenceDestroyChanceOID_S")
			SetInfoText("$SLS_WetLicenceDestroyChance_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "WetLicenceMaxToLoseOID_S")
			SetInfoText("$SLS_WetLicenceMaxToLose_Info")
			
		ElseIf(option == TollDodgeDetectDistTownMaxOID_S)
			SetInfoText("Maximum distance at which an licence enforcer will spot you in small towns.\nDoes not include penalties from not covering your body or head\nJust to give you an idea 128 'units' is approximately equal to the height of an Npc")
		ElseIf(option == TollDodgeDisguiseBodyPenaltyOID_S)
			SetInfoText("The guards have studied your body extensively or you likely have unique markings on your characters body. Not wearing something in the body slot will make you more recognisable and increase the distance at which guards will spot you\nThis is the same setting for Toll Evasion and Licence enforcers. Provided here for convenience")
		ElseIf(option == TollDodgeDisguiseHeadPenaltyOID_S)
			SetInfoText("Not wearing something in the head slot will make you more recognisable and increase the distance at which guards will spot you\nThis is the same setting for Toll Evasion and Licence enforcers. Provided here for convenience")
		ElseIf(option == TollDodgeCurrentSpotDistTown)
			SetInfoText("The distance you'll be spotted at with your current settings and equipped body/head armor around small towns\nGive it a second after changing equipment to update as the script is lazy to keep cpu usage low\nJust to give you an idea 128 'units' is approximately equal to the height of an Npc\nThis option is only for display purposes (doesn't actually do anything)")
			
		ElseIf(option == CurseTatsOID)
			SetInfoText("$SLS_CurseTats_Info")
		ElseIf(option == BikiniCurseAreaDB)
			SetInfoText("$SLS_BikiniCurseArea_Info")
		ElseIf(option == MagicCurseAreaDB)
			SetInfoText("$SLS_MagicCurseArea_Info")
		ElseIf(option == SearchEscortsOID_T)
			SetInfoText("$SLS_SearchEscorts_Info")
		ElseIf(option == AddEscortToListOID_T)
			SetInfoText("$SLS_AddEscortToList_Info")
		ElseIf(option == RemoveEscortFromListOID_T)
			SetInfoText("$SLS_AddEscortToList_Info")
		ElseIf(option == ClearAllEscortsOID_T)
			SetInfoText("$SLS_ClearAllEscorts_Info")
		ElseIf(option == ImportEscortsFromJsonOID_T)
			SetInfoText("$SLS_ImportEscortsFromJson_Info")
		ElseIf(option == LicGetEquipListOID_T)
			SetInfoText("$SLS_LicGetEquipList_Info")
		ElseIf(option == LicEquipListDB)
			SetInfoText("$SLS_LicEquipList_Info")
		ElseIf(option == AddLicExceptionOID_T)
			SetInfoText("$SLS_AddLicException_Info")
		ElseIf(option == LicFactionDiscountOID_S)
			SetInfoText("$SLS_LicFactionDiscount_Info")
		ElseIf(option == DiscountCollegeOID_T)
			SetInfoText("$SLS_DiscountCollege_Info")
		ElseIf(option == DiscountCompanionsOID_T)
			SetInfoText("$SLS_DiscountCompanions_Info")
		ElseIf(option == DiscountCwOID_T)
			SetInfoText("$SLS_DiscountCw_Info")
			
		ElseIf(option == EnforcersMinOID_S)
			SetInfoText("$SLS_EnforcersMin_Info")
		ElseIf(option == EnforcersMaxOID_S)
			SetInfoText("$SLS_EnforcersMin_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "_SLS_EnforcerGuardsMinOID_S")
			SetInfoText("$SLS_EnforcerGuardsMin_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "_SLS_EnforcerGuardsMaxOID_S")
			SetInfoText("$SLS_EnforcerGuardsMax_Info")
			
		ElseIf(option == ResponsiveEnforcersOID)
			SetInfoText("$SLS_ResponsiveEnforcers_Info")
		ElseIf(option == PersistentEnforcersOID_S)
			SetInfoText("$SLS_PersistentEnforcers_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "EnforcerChaseDistanceOID_S")
			SetInfoText("$SLS_EnforcerChaseDistance_Info")
		ElseIf(option == EnforcerRespawnDurOID_S)
			SetInfoText("$SLS_EnforcerRespawnDur_Info")
			
		ElseIf(option == RestrictTradeOID)
			SetInfoText("$SLS_RestrictTrade_Info")
		ElseIf(option == TradeRestrictBribeOID_S)
			SetInfoText("$SLS_TradeRestrictBribe_Info")
		ElseIf(option == TradeRestrictAddMerchantOID_T)
			SetInfoText("$SLS_TradeRestrictAddMerchant_Info")
			
		ElseIf(option == TradeRestrictRemoveMerchantOID_T)
			SetInfoText("$SLS_TradeRestrictRemoveMerchant_Info")
		ElseIf(option == TradeRestrictResetAllMerchantsOID_T)
			SetInfoText("$SLS_TradeRestrictResetAllMerchants_Info")

		ElseIf(option == LicShortDurOID_S)
			SetInfoText("$SLS_LicShortDur_Info")
		ElseIf(option == LicLongDurOID_S)
			SetInfoText("$SLS_LicLongDur_Info")
		ElseIf option == StorageUtil.GetIntValue(Self, "LicMagicCurseDrainTo")
			SetInfoText("$LicMagicDrainMagicTo_Info")
		ElseIf(option == LicWeapShortCostOID_S) || (option == LicMagicShortCostOID_S) || (option == LicArmorShortCostOID_S) || (option == LicBikiniShortCostOID_S) || (option == LicClothesShortCostOID_S) || Option == StorageUtil.GetIntValue(Self, "LicPropertyShortCostOID_S")
			SetInfoText("$SLS_LicWeapShortCost_Info")
		ElseIf(option == LicWeapLongCostOID_S) || (option == LicMagicLongCostOID_S) || (option == LicArmorLongCostOID_S) || (option == LicBikiniLongCostOID_S) || (option == LicClothesLongCostOID_S) || Option == StorageUtil.GetIntValue(Self, "LicPropertyLongCostOID_S")
			SetInfoText("$SLS_LicWeapLongCost_Info")
		ElseIf(option == LicWeapPerCostOID_S) || (option == LicMagicPerCostOID_S) || (option == LicArmorPerCostOID_S) || (option == LicBikiniPerCostOID_S) || (option == LicClothesPerCostOID_S) || Option == StorageUtil.GetIntValue(Self, "LicPropertyPerCostOID_S")
			SetInfoText("$SLS_LicWeapPerCost_Info")
			
		ElseIf(option == LicBikiniEnableOID)
			SetInfoText("$SLS_LicBikiniEnable_Info")
		ElseIf(option == LicBikiniCurseEnableOID)
			SetInfoText("$SLS_LicBikiniCurseEnable_Info")
		ElseIf(option == LicBikiniTriggerOID_T)
			SetInfoText("$SLS_LicBikiniTrigger_Info")
		ElseIf(option == LicBikiniHeelsOID)
			SetInfoText("$SLS_LicBikiniHeels_Info")
		ElseIf(option == LicBikiniHeelHeightOID_S)
			SetInfoText("$SLS_LicBikiniHeelHeight_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "LicBikiniArmorTestOID_T")
			SetInfoText("$SLS_LicBikiniArmorTest_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "LicBikiniBreathChanceOID_S")
			SetInfoText("$SLS_LicBikiniBreathChance_Info")
			
		ElseIf(option == LicMagicEnableOID)
			SetInfoText("$SLS_LicMagicEnable_Info")
		ElseIf(option == LicMagicCursedDevicesOID)
			SetInfoText("$SLS_LicMagicCursedDevices_Info")
		ElseIf(option == LicClothesEnableDB)
			SetInfoText("$SLS_LicClothesEnable_Info")
		EndIf
		
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pLicences2" ; <----------------->
		If Option == StorageUtil.GetIntValue(Self, "PropertyLicenceEnableOID")
			SetInfoText("$SLS_PropertyLicenceEnable_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "CurfewLicenceEnableOID")
			SetInfoText("$SLS_CurfewLicenceEnable_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "LicCurfewNotificationsOID")
			SetInfoText("Enable/Disable notifications around curfew beginning and ending")
		ElseIf Option == StorageUtil.GetIntValue(Self, "CurfewRestartDelayOID_S")
			SetInfoText("$SLS_CurfewRestartDelay_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "CurfewBeginOID_S")
			SetInfoText("$SLS_CurfewBegin_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "CurfewEndOID_S")
			SetInfoText("$SLS_CurfewEnd_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "CurfewSlavetownBeginOID_S")
			SetInfoText("$SLS_CurfewSlavetownBegin_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "CurfewSlavetownEndOID_S")
			SetInfoText("$SLS_CurfewSlavetownEnd_Info")
		EndIf

	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pStashes" ; <----------------->
		If(option == StashTrackEnOID)
			SetInfoText("$SLS_StashTrackEn_Info")
		ElseIf(option == StashAddRemoveExceptionOID_T)
			SetInfoText("$SLS_StashAddRemoveException_Info")
		ElseIf(option == StashAddRemoveJsonExceptionsOID_T)
			SetInfoText("$SLS_StashAddRemoveJsonExceptions_Info")
		ElseIf(option == StashAddRemoveTempExceptionsOID_T)
			SetInfoText("$SLS_StashAddRemoveTempExceptions_Info")
		ElseIf(option == StashAddRemoveAllExceptionsOID_T)
			SetInfoText("$SLS_StashAddRemoveAllExceptions_Info")

		ElseIf Option == StorageUtil.GetIntValue(Self, "DroppedItemStealingEnOID")
			SetInfoText("$SLS_DroppedItemStealingEn_Info")
			
		ElseIf(option == ContTypeCountsOID)
			SetInfoText("$SLS_ContTypeCounts_Info")
		ElseIf(option == RoadDistOID_S)
			SetInfoText("$SLS_RoadDist_Info")
		ElseIf(option == StealXItemsOID_S)
			SetInfoText("$SLS_StealXItems_Info")
		EndIf

	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pBeggingKennel" ; <----------------->
		If(option == BeggingTOID)
			SetInfoText("$SLS_BeggingT_Info")
		ElseIf(option == BegSelfDegEnableOID)
			SetInfoText("$SLS_BegSelfDegEnable_Info")
		ElseIf(option == BegNumItemsOID_S)
			SetInfoText("$SLS_BegNumItems_Info")
		ElseIf(option == BegGoldOID_S)
			SetInfoText("$SLS_BegGold_Info")
		ElseIf(option == BegSexAggDB)
			SetInfoText("$SLS_BegSexAgg_Info")
		ElseIf(option == BegSexVictimDB)
			SetInfoText("$SLS_BegSexVictim_Info")
		ElseIf(option == BegMwaCurseChanceOID_S)
			SetInfoText("$SLS_BegMwaCurseChance_Info")

		ElseIf(option == KennelSafeCellCostOID_S)
			SetInfoText("$SLS_KennelSafeCellCost_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "KennelSuitsOID")
			SetInfoText("$SLS_KennelSuits_Info")
		ElseIf(option == KennelCreatureChanceOID_S)
			SetInfoText("$SLS_KennelCreatureChance_Info")
		ElseIf(option == KennelRapeChancePerHourOID_S)
			SetInfoText("$SLS_KennelRapeChancePerHour_Info")
		ElseIf(option == KennelSlaveRapeTimeMinOID_S) || (option == KennelSlaveRapeTimeMaxOID_S)
			SetInfoText("$SLS_KennelSlaveRapeTimeMinMax_Info")

		ElseIf Option == StorageUtil.GetIntValue(Self, "KennelSlaveDeviceCountMinOID_S")
			SetInfoText("$SLS_KennelSlaveDeviceCountMin_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "KennelSlaveDeviceCountMaxOID_S")
			SetInfoText("$SLS_KennelSlaveDeviceCountMax_Info")
		ElseIf(option == KennelExtraDevicesOID)
			SetInfoText("$SLS_KennelExtraDevices_Info")
		ElseIf(option == KennelFollowerToggleOID)
			SetInfoText("$SLS_KennelFollowerToggle_Info")
		ElseIf(option == KennelSexAggDB)
			SetInfoText("$SLS_KennelSexAgg_Info")
		ElseIf(option == KennelSexVictimDB)
			SetInfoText("$SLS_KennelSexVictim_Info")
		EndIf
		
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pPickpocketDismemberment" ; <----------------->
		If(option == PpLootEnableOID)
			SetInfoText("$SLS_PpLootEnable_Info")
		ElseIf(option == PpGoldChanceOfNoneOID_T)
			SetInfoText("$SLS_PpGoldChanceOfNone_Info")
		ElseIf(option == PpGoldLowChanceOID_S)
			SetInfoText("$SLS_PpGoldLowChance_Info")
		ElseIf(option == PpGoldModerateChanceOID_S)
			SetInfoText("$SLS_PpGoldModerateChance_Info")
		ElseIf(option == PpGoldHighChanceOID_S)
			SetInfoText("$SLS_PpGoldHighChance_Info")
		ElseIf(option == PpLootMinOID_S)
			SetInfoText("$SLS_PpLootMin_Info")
		ElseIf(option == PpLootMaxOID_S)
			SetInfoText("$SLS_PpLootMax_Info")

		ElseIf(option == PpLootChanceOfNoneOID_T)
			SetInfoText("$SLS_PpLootChanceOfNone_Info")
		ElseIf(option == PpLootFoodChanceOID_S)
			SetInfoText("$SLS_PpLootFoodChance_Info")
		ElseIf(option == PpLootGemsChanceOID_S)
			SetInfoText("$SLS_PpLootGemsChance_Info")
		ElseIf(option == PpLootSoulgemsChanceOID_S)
			SetInfoText("$SLS_PpLootSoulgemsChance_Info")
		ElseIf(option == PpLootJewelryChanceOID_S)
			SetInfoText("$SLS_PpLootJewelryChance_Info")
		ElseIf(option == PpLootEnchJewelryChanceOID_S)
			SetInfoText("$SLS_PpLootEnchJewelryChance_Info")
		ElseIf(option == PpLootPotionsChanceOID_S)
			SetInfoText("$SLS_PpLootPotionsChance_Info")
		ElseIf(option == PpLootKeysChanceOID_S)
			SetInfoText("$SLS_PpLootKeysChance_Info")
		ElseIf(option == PpLootTomesChanceOID_S)
			SetInfoText("$SLS_PpLootTomesChance_Info")
		ElseIf(option == PpLootCureChanceOID_S)
			SetInfoText("$SLS_PpLootCureChance_Info")
		
		ElseIf(option == PpSleepNpcPerkOID)
			SetInfoText("$SLS_PpSleepNpcPerk_Info")
		ElseIf(option == PpFailHandleOID)
			SetInfoText("$SLS_PpFailHandle_Info")
		ElseIf(option == PpCrimeGoldOID_S)
			SetInfoText("$SLS_PpCrimeGold_Info")
		ElseIf(option == PpFailDevicesOID_S)
			SetInfoText("$SLS_PpFailDevices_Info")
		ElseIf(option == PpFailStealValueOID_S)
			SetInfoText("$SLS_PpFailStealValue_Info")
		ElseIf(option == PpFailDrugCountOID_S)
			SetInfoText("$SLS_PpFailDrugCount_Info")
		
		ElseIf(option == DismembermentsDB)
			SetInfoText("$SLS_Dismemberments_Info")
		ElseIf(option == DismemberProgressionDB)
			SetInfoText("$SLS_DismemberProgression_Info")
		ElseIf(option == DismemberWeaponsDB)
			SetInfoText("$SLS_DismemberWeapons_Info")
		ElseIf(option == DismemberDepthMaxArmsDB)
			SetInfoText("$SLS_DismemberDepthMaxArms_Info")
		ElseIf(option == DismemberDepthMaxLegsDB)
			SetInfoText("$SLS_DismemberDepthMaxLegs_Info")
		ElseIf(option == DismemberMaxAmpedLimbsOID_S)
			SetInfoText("$SLS_DismemberMaxAmpedLimbs_Info")
		ElseIf(option == DismemberCooldownOID_S)
			SetInfoText("$SLS_DismemberCooldown_Info")
		ElseIf(option == DismemberChanceOID_S)
			SetInfoText("$SLS_DismemberChance_Info")
		ElseIf(option == DismemberArmorBonusOID_S)
			SetInfoText("$SLS_DismemberArmorBonus_Info")
		ElseIf(option == DismemberChanceActualOID_T)
			SetInfoText("$SLS_DismemberChanceActual_Info")
		ElseIf(option == DismemberDamageThresOID_S)
			SetInfoText("$SLS_DismemberDamageThres_Info")
		ElseIf(option == DismemberHealthThresOID_S)
			SetInfoText("$SLS_DismemberHealthThres_Info")
		ElseIf(option == AmpPriestHealCostOID_S)
			SetInfoText("$SLS_AmpPriestHealCost_Info")
		ElseIf Option == StorageUtil.GetIntValue(Self, "AmpBlockMagicOID")
			SetInfoText("$SLS_AmpBlockMagic_Info")
		ElseIf(option == DismemberTrollCumOID)
			SetInfoText("$SLS_DismemberTrollCum_Info")
		ElseIf(option == DismemberBathingOID)
			SetInfoText("$SLS_DismemberBathing_Info")
		ElseIf(option == DismemberPlayerSayOID)
			SetInfoText("$SLS_DismemberPlayerSay_Info")
		ElseIf(option == StorageUtil.GetIntValue(Self, "DismemberCombatStopOID"))
			SetInfoText("$SLS_DismemberCombatStop_Info")
		EndIf
		
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pBikiniArmorsExp" ; <----------------->
		If option == BikiniExpOID
			SetInfoText("$SLS_BikiniExp_Info")
		ElseIf option == BikiniExpPerLevelOID_S
			SetInfoText("$SLS_BikiniExpPerLevel_Info")
		ElseIf option == BikiniExpReflexesOID
			SetInfoText("$SLS_BikiniExpReflexes_Info")
		ElseIf option == BikiniExpTrainOID_S
			SetInfoText("$SLS_BikiniExpTrain_Info")
		ElseIf option == BikiniExpUntrainOID_S
			SetInfoText("$SLS_BikiniExpUntrain_Info")
		ElseIf option == BikiniBuildListOID_T
			SetInfoText("$SLS_BikiniBuildList_Info")
		ElseIf option == BikiniClearListOID_T
			SetInfoText("$SLS_BikiniClearList_Info")
		ElseIf option == BikiniDropsVendorCityOID_S || option == BikiniDropsVendorTownOID_S || option == BikiniDropsVendorKhajiitOID_S || option == BikiniDropsChestOID_S || option == BikiniDropsChestOrnateOID_S 
			SetInfoText("$SLS_BikiniDropsVendorCity_Info")
		
		ElseIf option == BikiniChanceNoneOID_S || option == BikiniChanceHideOID_S || option == BikiniChanceLeatherOID_S || option == BikiniChanceIronOID_S || option == BikiniChanceSteelOID_S || option == BikiniChanceSteelPlateOID_S || option == BikiniChanceDwarvenOID_S || option == BikiniChanceFalmerOID_S || option == BikiniChanceWolfOID_S || option == BikiniChanceBladesOID_S || option == BikiniChanceEbonyOID_S  || option == BikiniChanceDragonboneOID_S 
			SetInfoText("$SLS_BikiniChanceNone_Info")
		ElseIf option == StorageUtil.GetIntValue(Self, "BikBreakEnable_OID")
			SetInfoText("Enable recipes as the forge to break down vanilla armors into skimpy versions for use with the bikini curse\nDoes not require perks or crafting books but you have a chance to fail to recover parts based on your crafting skill. This chance is never zero, no matter how high your skill\nThis currently covers vanilla TAWoBA. Check the guide for how to create your own")
		ElseIf option == StorageUtil.GetIntValue(Self, "BikBreakCompatibilityMode_OID")
			SetInfoText("Compatibility mode for mods like 'Living Takes Time' or 'Time Passes'\nBroken down bikini parts won't be added to your inventory until you close the crafting menu. The only item added is a MiscObject token")
		ElseIf option == StorageUtil.GetIntValue(Self, "BikBreakBuild_OID")
			SetInfoText("Build breakdown recipes. Use this anytime you add/remove breakdown recipes from the mod")
		ElseIf option == StorageUtil.GetIntValue(Self, "BikBreakTawoba_OID")
			SetInfoText("Enable/Disable the breakdown recipes for vanilla TAWoBA")
		EndIf
		
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pInnRoomPrices" ; <----------------->
		If Option == StorageUtil.GetIntValue(Self, "SetInnPricesOID")
			SetInfoText("$SLS_SetInnPrices_Info")
		EndIf
	
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pStatsInfo" ; <----------------->
		If option == TollDodgedWhiterunOID_T || option == TollDodgedSolitudeOID_T || option == TollDodgedMarkarthOID_T || option == TollDodgedWindhelmOID_T || option == TollDodgedRiftenOID_T
			SetInfoText("$SLS_TollDodgedWhiterun_Info")
		EndIf
	EndIf
EndEvent

Event OnOptionKeyMapChange(int option, int keyCode, string conflictControl, string conflictName)
	If Option == AllInOneKeyOID
		If conflictControl != ""
			If ShowMessage("Key is already bound to: " + conflictControl + "\nAre you sure you want to bind it?\nIt won't overwrite the control")
				SetKeyMapOptionValue(AllInOneKeyOID, keyCode)
				AllInOne.SetKey(keyCode)
			EndIf
		
		Else
			SetKeyMapOptionValue(Option, keyCode)
			AllInOne.SetKey(keyCode)
		EndIf
		
	ElseIf Option == StorageUtil.GetIntValue(Self, "AllInOneStatusKeyOID")
		If conflictControl != ""
			If ShowMessage("Key is already bound to: " + conflictControl + "\nAre you sure you want to bind it?\nIt won't overwrite the control")
				SetKeyMapOptionValue(Option, keyCode)
				AllInOne.SetStatusKey(keyCode)
			EndIf
		
		Else
			SetKeyMapOptionValue(Option, keyCode)
			AllInOne.SetStatusKey(keyCode)
		EndIf
		
	ElseIf Option == StorageUtil.GetIntValue(Self, "OpenMouthKey")
		If conflictControl != ""
			If ShowMessage("Key is already bound to: " + conflictControl + "\nAre you sure you want to bind it?\nIt won't overwrite the control")
				SetKeyMapOptionValue(Option, keyCode)
				CumSwallow.SetOpenMouthKey(KeyCode)
			EndIf
		
		Else
			SetKeyMapOptionValue(Option, keyCode)
			CumSwallow.SetOpenMouthKey(KeyCode)
		EndIf
	EndIf
	
	;/
	If option == CumAddictKeyOID
		If conflictControl != ""
			If ShowMessage("Key is already bound to: " + conflictControl + "\nAre you sure you want to bind it?\nIt won't overwrite the control")
				SetKeyMapOptionValue(CumAddictKeyOID, keyCode)
				CumAddict.SetNotifyKey(keyCode)
			EndIf
		
		Else
			SetKeyMapOptionValue(CumAddictKeyOID, keyCode)
			CumAddict.SetNotifyKey(keyCode)
		EndIf
		
	ElseIf option == CoverMyselfKeyOID
		If conflictControl != ""
			If ShowMessage("Key is already bound to: " + conflictControl + "\nAre you sure you want to bind it?\nIt won't overwrite the control")
				SetKeyMapOptionValue(CoverMyselfKeyOID, keyCode)
				CoverMyselfKey = keyCode
				CoverMyself.ChangeCoverKey(keyCode)
			EndIf
		
		Else
			SetKeyMapOptionValue(CoverMyselfKeyOID, keyCode)
			CoverMyselfKey = keyCode
			CoverMyself.ChangeCoverKey(keyCode)
		EndIf
		
	ElseIf option == OpenMouthKeyOID
		If conflictControl != ""
			If ShowMessage("Key is already bound to: " + conflictControl + "\nAre you sure you want to bind it?\nIt won't overwrite the control")
				SetKeyMapOptionValue(OpenMouthKeyOID, keyCode)
				OpenMouthKey = keyCode
				CumSwallow.SetOpenMouthKey()
			EndIf
		
		Else
			SetKeyMapOptionValue(OpenMouthKeyOID, keyCode)
			OpenMouthKey = keyCode
			CumSwallow.SetOpenMouthKey()
		EndIf
	EndIf
	/;
EndEvent

Event OnOptionMenuOpen(int option)
	If (option == PushEventsDB)
		SetMenuDialogStartIndex(PushEvents)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(PushEventsType)
	ElseIf Option == StorageUtil.GetIntValue(Self, "AioFavoriteDB")
		SetMenuDialogStartIndex(AllInOne.Fav.Favorite)
		SetMenuDialogDefaultIndex(10)
		SetMenuDialogOptions(AllInOne.Fav.AioFavorites)
	ElseIf (option == CompassHideMethodDB)
		SetMenuDialogStartIndex(CompassHideMethod)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(CompassHideMethods)
	ElseIf (option == ProxSpankNpcDB)
		SetMenuDialogStartIndex(ProxSpankNpcType)
		SetMenuDialogDefaultIndex(1)
		SetMenuDialogOptions(ProxSpankNpcList)
	ElseIf (option == ProxSpankCoverDB)
		SetMenuDialogStartIndex(_SLS_ProxSpankRequiredCover.GetValueInt())
		SetMenuDialogDefaultIndex(1)
		SetMenuDialogOptions(ProxSpankRequiredCoverList)
		
	ElseIf (option == CumAddictAutoSuckStageDB)
		SetMenuDialogStartIndex(CumHungerAutoSuck)
		SetMenuDialogDefaultIndex(2)
		SetMenuDialogOptions(CumHungerStrings)
		
	ElseIf (option == DismembermentsDB)
		SetMenuDialogStartIndex(AmpType)
		SetMenuDialogDefaultIndex(2)
		SetMenuDialogOptions(AmputationTypes)
	ElseIf (option == DismemberProgressionDB)
		SetMenuDialogStartIndex(AmpDepth)
		SetMenuDialogDefaultIndex(2)
		SetMenuDialogOptions(AmputationDepth)
	ElseIf (option == DismemberWeaponsDB)
		SetMenuDialogStartIndex(DismemberWeapon)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(DismemberWeapons)
	ElseIf (option == DismemberDepthMaxArmsDB)
		SetMenuDialogStartIndex(MaxAmpDepthArms)
		SetMenuDialogDefaultIndex(1)
		SetMenuDialogOptions(MaxAmputationDepthArms)
	ElseIf (option == DismemberDepthMaxLegsDB)
		SetMenuDialogStartIndex(MaxAmpDepthLegs)
		SetMenuDialogDefaultIndex(1)
		SetMenuDialogOptions(MaxAmputationDepthLegs)
		
	ElseIf (option == LicenceStyleDB)
		SetMenuDialogStartIndex(LicUtil.LicenceStyle)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(LicenceStyleList)
	ElseIf (option == FollowerLicStyleDB)
		SetMenuDialogStartIndex(LicUtil.FollowerLicStyle)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(FollowerLicStyles)
	ElseIf (option == LicBuyBackPriceDB)
		SetMenuDialogStartIndex(BuyBackPrice)
		SetMenuDialogDefaultIndex(2)
		SetMenuDialogOptions(BuyBackPrices)
	ElseIf (option == LicEquipListDB)
		SetMenuDialogStartIndex(SelectedEquip)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(EquipSlotStrings)	
	ElseIf (option == LicClothesEnableDB)
		SetMenuDialogStartIndex(LicUtil.LicClothesEnable)
		SetMenuDialogDefaultIndex(2)
		SetMenuDialogOptions(ClothesLicenceMethod)
	ElseIf (option == BikiniCurseAreaDB)
		SetMenuDialogStartIndex(BikiniCurseArea)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(OverlayAreas)
	ElseIf (option == MagicCurseAreaDB)
		SetMenuDialogStartIndex(MagicCurseArea)
		SetMenuDialogDefaultIndex(1)
		SetMenuDialogOptions(OverlayAreas)
		
	ElseIf option == StorageUtil.GetIntValue(Self, "FreedomLicenceEnableDB")
		SetMenuDialogStartIndex(LicUtil.LicFreedomEnable)
		SetMenuDialogDefaultIndex(2)
		SetMenuDialogOptions(ClothesLicenceMethod)
		
	ElseIf (option == SexExpCorruptionDB)
		SetMenuDialogStartIndex(SexExpCorruption)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(SexExpCreatureCorruption)
		
	ElseIf (option == DevEffLockpickDiffDB)
		SetMenuDialogStartIndex(DevEffLockpickDiff)
		SetMenuDialogDefaultIndex(1)
		SetMenuDialogOptions(HeavyBondageDifficulty)
	ElseIf (option == DevEffPickpocketDiffDB)
		SetMenuDialogStartIndex(DevEffPickpocketDiff)
		SetMenuDialogDefaultIndex(1)
		SetMenuDialogOptions(HeavyBondageDifficulty)
		
	ElseIf (option == TollSexAggDB)
		SetMenuDialogStartIndex(TollSexAgg)
		SetMenuDialogDefaultIndex(1)
		SetMenuDialogOptions(SexAggressiveness)
	ElseIf (option == TollSexVictimDB)
		SetMenuDialogStartIndex(TollSexVictim)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(SexPlayerIsVictim)
		
	ElseIf (option == BegSexAggDB)
		SetMenuDialogStartIndex(BegSexAgg)
		SetMenuDialogDefaultIndex(1)
		SetMenuDialogOptions(SexAggressiveness)
	ElseIf (option == BegSexVictimDB)
		SetMenuDialogStartIndex(BegSexVictim)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(SexPlayerIsVictim)
	ElseIf (option == KennelSexAggDB)
		SetMenuDialogStartIndex(KennelSexAgg)
		SetMenuDialogDefaultIndex(1)
		SetMenuDialogOptions(SexAggressiveness)
	ElseIf (option == KennelSexVictimDB)
		SetMenuDialogStartIndex(KennelSexVictim)
		SetMenuDialogDefaultIndex(1)
		SetMenuDialogOptions(SexPlayerIsVictim)
	EndIf
EndEvent

Event OnOptionMenuAccept(int option, int index)
	If (option == PushEventsDB)
		PushEvents = index
		SetMenuOptionValue(option, PushEventsType[PushEvents])
		DoTogglePushEvents = true
	ElseIf Option == StorageUtil.GetIntValue(Self, "AioFavoriteDB")
		AllInOne.Fav.SetFav(Index)
		SetMenuOptionValue(option, AllInOne.Fav.AioFavorites[Index])	
	ElseIf (option == CompassHideMethodDB)
		CompassHideMethod = index
		SetMenuOptionValue(option, CompassHideMethods[CompassHideMethod])
		MapAndCompass.ResetCompass()
	ElseIf (option == ProxSpankNpcDB)
		ProxSpankNpcType = index
		SetMenuOptionValue(option, ProxSpankNpcList[ProxSpankNpcType])
		DoToggleProxSpank = true
		;ForcePageReset()
	ElseIf (option == ProxSpankCoverDB)
		_SLS_ProxSpankRequiredCover.SetValueInt(index)
		SetMenuOptionValue(option, ProxSpankRequiredCoverList[_SLS_ProxSpankRequiredCover.GetValueInt()])
		
	ElseIf (option == CumAddictAutoSuckStageDB)
		CumHungerAutoSuck = index
		SetMenuOptionValue(option, CumHungerStrings[CumHungerAutoSuck])
		CumAddict.SetAutoSuckBeginStage()
		
	ElseIf (option == DismembermentsDB)
		If Game.GetModByName("Amputator.esm") != 255
			AmpType = index
			SetMenuOptionValue(option, AmputationTypes[AmpType])
			ToggleDismemberment()
		
		Else
			Debug.Messagebox("Amputator framework is not installed")
		EndIf
	ElseIf (option == DismemberProgressionDB)
		AmpDepth = index
		SetMenuOptionValue(option, AmputationDepth[AmpDepth])
	ElseIf (option == DismemberWeaponsDB)
		DismemberWeapon = index
		SetMenuOptionValue(option, DismemberWeapons[DismemberWeapon])
	ElseIf (option == DismemberDepthMaxArmsDB)
		Amputation.CheckAvailabilty()
		MaxAmpDepthArms = index
		SetMenuOptionValue(option, MaxAmputationDepthArms[MaxAmpDepthArms])
	ElseIf (option == DismemberDepthMaxLegsDB)
		Amputation.CheckAvailabilty()
		MaxAmpDepthLegs = index
		SetMenuOptionValue(option, MaxAmputationDepthLegs[MaxAmpDepthLegs])

	ElseIf (option == LicenceStyleDB)
		If ShowMessage("Warning: Changing licence style when you have already unlocked licences in the 'Thaneship' styles will reset and lock all licences again. If style is 'Choice' you'll need to choose your licences at a quartermaster again. If style is 'Random' then random licences will be unlocked\n\nAre you sure you want to change style?")
			LicUtil.LicenceStyle = index
			SetMenuOptionValue(option, LicenceStyleList[LicUtil.LicenceStyle])
			DoToggleLicenceStyle = true
		EndIf
	ElseIf (option == FollowerLicStyleDB)
		LicUtil.FollowerLicStyle = index
		SetMenuOptionValue(option, FollowerLicStyles[LicUtil.FollowerLicStyle])
	ElseIf (option == LicBuyBackPriceDB)
		BuyBackPrice = index
		SetMenuOptionValue(option, BuyBackPrices[BuyBackPrice])
	ElseIf (option == LicEquipListDB)
		SelectedEquip = index
		SetMenuOptionValue(option, EquipSlotStrings[SelectedEquip])
		SetTextOptionValue(AddLicExceptionOID_T, EquipSlotStrings[SelectedEquip])
	ElseIf (option == LicClothesEnableDB)
		LicUtil.LicClothesEnable = index
		LicenceToggleToggled()
		SetMenuOptionValue(option, ClothesLicenceMethod[LicUtil.LicClothesEnable])
	ElseIf (option == BikiniCurseAreaDB)
		RefreshBikiniCurseOverlay(index)
		BikiniCurseArea = index
		SetMenuOptionValue(option, OverlayAreas[BikiniCurseArea])
	ElseIf (option == MagicCurseAreaDB)
		RefreshMagicCurseOverlay(index)
		MagicCurseArea = index
		SetMenuOptionValue(option, OverlayAreas[MagicCurseArea])
		
	ElseIf option == StorageUtil.GetIntValue(Self, "FreedomLicenceEnableDB")
		LicUtil.LicFreedomEnable = index
		SetMenuOptionValue(option, ClothesLicenceMethod[LicUtil.LicFreedomEnable])
		LicenceToggleToggled()
		
	ElseIf (option == SexExpCorruptionDB)
		SexExpCorruption = index
		SetMenuOptionValue(option, SexExpCreatureCorruption[SexExpCorruption])

	ElseIf (option == DevEffLockpickDiffDB)
		DevEffLockpickDiff = index
		SetMenuOptionValue(option, HeavyBondageDifficulty[DevEffLockpickDiff])
		DoDeviousEffectsChange = true
	ElseIf (option == DevEffPickpocketDiffDB)
		DevEffPickpocketDiff = index
		SetMenuOptionValue(option, HeavyBondageDifficulty[DevEffPickpocketDiff])
		DoDeviousEffectsChange = true
		
	ElseIf (option == TollSexAggDB)
		TollSexAgg = index
		SetMenuOptionValue(option, SexAggressiveness[TollSexAgg])
	ElseIf (option == TollSexVictimDB)
		TollSexVictim = index
		SetMenuOptionValue(option, SexPlayerIsVictim[TollSexVictim])
		
	ElseIf (option == BegSexAggDB)
		BegSexAgg = index
		SetMenuOptionValue(option, SexAggressiveness[BegSexAgg])
	ElseIf (option == BegSexVictimDB)
		BegSexVictim = index
		SetMenuOptionValue(option, SexPlayerIsVictim[BegSexVictim])
	ElseIf (option == KennelSexAggDB)
		KennelSexAgg = index
		SetMenuOptionValue(option, SexAggressiveness[KennelSexAgg])
	ElseIf (option == KennelSexVictimDB)
		KennelSexVictim = index
		SetMenuOptionValue(option, SexPlayerIsVictim[KennelSexVictim])
	EndIf
	ForcePageReset()
EndEvent

Event OnOptionSelect(int option)
	If (option == ImportSettingsOID_T)
		LoadSettings()
	ElseIf (option == ExportSettingsOID_T)
		SaveSettings()
	ElseIf (option == SlaverunAutoStartOID)
		SlaverunAutoStart = !SlaverunAutoStart
		SetToggleOptionValue(SlaverunAutoStartOID, SlaverunAutoStart)
		DoSlaverunInitOnClose = true
		ForcePageReset()
		
	ElseIf Option == StorageUtil.GetIntValue(Self, "EasyHomeWhiterunOID")
		Bool EasyHome = !(Game.GetFormFromFile(0x112E32, "SL Survival.esp") as GlobalVariable).GetValueInt() as Bool
		EasyHome = !EasyHome
		If EasyHome
			(Game.GetFormFromFile(0x112E32, "SL Survival.esp") as GlobalVariable).SetValueInt(0)
		Else
			(Game.GetFormFromFile(0x112E32, "SL Survival.esp") as GlobalVariable).SetValueInt(2)
		EndIf
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "EasyHomeWhiterunOID"), EasyHome)
	ElseIf Option == StorageUtil.GetIntValue(Self, "EasyHomeSolitudeOID")
		Bool EasyHome = !(Game.GetFormFromFile(0x113395, "SL Survival.esp") as GlobalVariable).GetValueInt() as Bool
		EasyHome = !EasyHome
		If EasyHome
			(Game.GetFormFromFile(0x113395, "SL Survival.esp") as GlobalVariable).SetValueInt(0)
		Else
			(Game.GetFormFromFile(0x113395, "SL Survival.esp") as GlobalVariable).SetValueInt(2)
		EndIf
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "EasyHomeSolitudeOID"), EasyHome)
	ElseIf Option == StorageUtil.GetIntValue(Self, "EasyHomeMarkarthOID")
		Bool EasyHome = !(Game.GetFormFromFile(0x113396, "SL Survival.esp") as GlobalVariable).GetValueInt() as Bool
		EasyHome = !EasyHome
		If EasyHome
			(Game.GetFormFromFile(0x113396, "SL Survival.esp") as GlobalVariable).SetValueInt(0)
		Else
			(Game.GetFormFromFile(0x113396, "SL Survival.esp") as GlobalVariable).SetValueInt(2)
		EndIf
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "EasyHomeMarkarthOID"), EasyHome)
	ElseIf Option == StorageUtil.GetIntValue(Self, "EasyHomeWindhelmOID")
		Bool EasyHome = !(Game.GetFormFromFile(0x113397, "SL Survival.esp") as GlobalVariable).GetValueInt() as Bool
		EasyHome = !EasyHome
		If EasyHome
			(Game.GetFormFromFile(0x113397, "SL Survival.esp") as GlobalVariable).SetValueInt(0)
		Else
			(Game.GetFormFromFile(0x113397, "SL Survival.esp") as GlobalVariable).SetValueInt(2)
		EndIf
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "EasyHomeWindhelmOID"), EasyHome)
	ElseIf Option == StorageUtil.GetIntValue(Self, "EasyHomeRiftenOID")
		Bool EasyHome = !(Game.GetFormFromFile(0x113398, "SL Survival.esp") as GlobalVariable).GetValueInt() as Bool
		EasyHome = !EasyHome
		If EasyHome
			(Game.GetFormFromFile(0x113398, "SL Survival.esp") as GlobalVariable).SetValueInt(0)
		Else
			(Game.GetFormFromFile(0x113398, "SL Survival.esp") as GlobalVariable).SetValueInt(2)
		EndIf
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "EasyHomeRiftenOID"), EasyHome)
	
	ElseIf (option == CoverMyselfMechanicsOID)
		CoverMyselfMechanics = !CoverMyselfMechanics
		SetToggleOptionValue(CoverMyselfMechanicsOID, CoverMyselfMechanics)
		;/
		If CoverMyselfMechanics
			If !IsCoverAnimationInstalled()
				CoverMyselfMechanics = false
				Debug.Messagebox("Cover mechanics can not be enabled because the cover animation was not found. Cursed Loot needs to be installed but doesn't need to be active")
			EndIf
		EndIf
		/;
		DoToggleCoverMechanics = true
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "NpcCommentsOID")
		If (Game.GetFormFromFile(0x0DF88F, "SL Survival.esp") as GlobalVariable).GetValueInt() == 0 ; _SLS_NpcComments
			(Game.GetFormFromFile(0x0DF88F, "SL Survival.esp") as GlobalVariable).SetValueInt(1)
		Else
			(Game.GetFormFromFile(0x0DF88F, "SL Survival.esp") as GlobalVariable).SetValueInt(0)
		EndIf
		SetToggleOptionValue(Option, (Game.GetFormFromFile(0x0DF88F, "SL Survival.esp") as GlobalVariable).GetValueInt())
		StorageUtil.SetIntValue(Self, "DoToggleNpcComments", 1)
	ElseIf (option == AssSlappingOID)
		AssSlappingEvents = !AssSlappingEvents
		SetToggleOptionValue(AssSlappingOID, AssSlappingEvents)
		ToggleAssSlapping()
	ElseIf (option == ProxSpankCommentOID)
		Util.ProxSpankComment = !Util.ProxSpankComment
		SetToggleOptionValue(ProxSpankCommentOID, Util.ProxSpankComment)
	ElseIf (option == EasyBedTrapsOID)
		EasyBedTraps = !EasyBedTraps
		SetToggleOptionValue(EasyBedTrapsOID, EasyBedTraps)
	ElseIf (option == CumBreathOID)
		CumBreath = !CumBreath
		SetToggleOptionValue(CumBreathOID, CumBreath)
	ElseIf (option == CumBreathNotifyOID)
		CumBreathNotify = !CumBreathNotify
		SetToggleOptionValue(CumBreathNotifyOID, CumBreathNotify)
	ElseIf (option == HardcoreModeOID)
		If !HardcoreMode
			If ShowMessage("Are you sure you want to enable hardcore mode?\nMany options will be disabled in hardcore mode and you can not disable hardcore mode unless you have enough gold")
				TryHardcoreToggle()
			EndIf
			
		Else
			TryHardcoreToggle()
		EndIf
		ForcePageReset()
		;Debug.Messagebox("IsHardcoreLocked: " + IsHardcoreLocked)
		
	ElseIf (option == DebugModeOID)
		Init.DebugMode = !Init.DebugMode
		SetToggleOptionValue(DebugModeOID, Init.DebugMode)
		ToggleDebugMode()
		
	ElseIf Option == StorageUtil.GetIntValue(Self, "SteepFall")
		StorageUtil.SetIntValue(Self, "DoToggleSteepFall", 1)
		StorageUtil.SetIntValue(Self, "SteepFallEnabled", (!StorageUtil.GetIntValue(Self, "SteepFallEnabled", Missing = 1) as Bool) as Int)
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "SteepFall"), StorageUtil.GetIntValue(Self, "SteepFallEnabled", Missing = 0))
		
	ElseIf (option == MinAvToggleOID)
		MinAvToggleT = !MinAvToggleT
		SetToggleOptionValue(MinAvToggleOID, MinAvToggleT)
		ToggleMinAV()
	ElseIf (option == HalfNakedEnableOID)
		HalfNakedEnable = !HalfNakedEnable
		SetToggleOptionValue(HalfNakedEnableOID, HalfNakedEnable)
		DoToggleHalfNakedCover = true
		ForcePageReset()
		
	ElseIf (option == HalfNakedStripsOID)
		HalfNakedStrips = !HalfNakedStrips
		SetToggleOptionValue(HalfNakedStripsOID, HalfNakedStrips)
		ForcePageReset()
		ToggleHalfNakedStrips()
		
	ElseIf Option == StorageUtil.GetIntValue(Self, "AhegaoEnableOID")
		If Game.GetModByName("SLSO.esp") != 255
			;If StorageUtil.GetIntValue(Self, "AhegaoEnable", Missing = 1) == 0 && Game.GetModByName("SLSO.esp") != 255
				StorageUtil.SetIntValue(Self, "AhegaoEnable", (!StorageUtil.GetIntValue(Self, "AhegaoEnable", Missing = 1) as Bool) as Int)
				StorageUtil.SetIntValue(Self, "DoToggleAhegaoEnable", 1)
				SetToggleOptionValue(StorageUtil.GetIntValue(Self, "AhegaoEnableOID"), StorageUtil.GetIntValue(Self, "AhegaoEnable"))
			;EndIf
		
		Else
			Debug.Messagebox("SLSO is needed for ahegao face")
			StorageUtil.SetIntValue(Self, "AhegaoEnable", 0)
			StorageUtil.SetIntValue(Self, "DoToggleAhegaoEnable", 1)
			SetToggleOptionValue(StorageUtil.GetIntValue(Self, "AhegaoEnableOID"), 0)
		EndIf
		
	ElseIf (option == SexExpEnableOID)
		SexExpEn = !SexExpEn
		If SexExpEn
			If !Init.SlsoInstalled
				Debug.Messagebox("Sexlab Separate Orgasms needs to be installed to enable Sex Experience")
				SexExpEn = false
			EndIf
		EndIf
		SetToggleOptionValue(SexExpEnableOID, SexExpEn)
		DoToggleSexExp = true
		ForcePageReset()
	ElseIf (option == DremoraCorruptionOID)
		DremoraCorruption = !DremoraCorruption
		SetToggleOptionValue(DremoraCorruptionOID, DremoraCorruption)
		
	ElseIf Option == StorageUtil.GetIntValue(Self, "RapeDrugLactacidOID")
		ForceDrug.RapeDrugLactacid = !ForceDrug.RapeDrugLactacid
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "RapeDrugLactacidOID"), ForceDrug.RapeDrugLactacid)
	ElseIf Option == StorageUtil.GetIntValue(Self, "RapeDrugSkoomaOID")
		ForceDrug.RapeDrugSkooma = !ForceDrug.RapeDrugSkooma
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "RapeDrugSkoomaOID"), ForceDrug.RapeDrugSkooma)
	ElseIf Option == StorageUtil.GetIntValue(Self, "RapeDrugCumHumanOID")
		ForceDrug.RapeDrugHumanCum = !ForceDrug.RapeDrugHumanCum
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "RapeDrugCumHumanOID"), ForceDrug.RapeDrugHumanCum)
	ElseIf Option == StorageUtil.GetIntValue(Self, "RapeDrugCumCreatureOID")
		ForceDrug.RapeDrugCreatureCum = !ForceDrug.RapeDrugCreatureCum
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "RapeDrugCumCreatureOID"), ForceDrug.RapeDrugCreatureCum)
	ElseIf Option == StorageUtil.GetIntValue(Self, "RapeDrugInflateOID")
		ForceDrug.RapeDrugInflate = !ForceDrug.RapeDrugInflate
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "RapeDrugInflateOID"), ForceDrug.RapeDrugInflate)
	ElseIf Option == StorageUtil.GetIntValue(Self, "RapeDrugFmFertilityOID")
		ForceDrug.RapeDrugFmFertility = !ForceDrug.RapeDrugFmFertility
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "RapeDrugFmFertilityOID"), ForceDrug.RapeDrugFmFertility)
	ElseIf Option == StorageUtil.GetIntValue(Self, "RapeDrugSlenAphrodisiacOID")
		ForceDrug.RapeDrugSlenAphrodisiac = !ForceDrug.RapeDrugSlenAphrodisiac
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "RapeDrugSlenAphrodisiacOID"), ForceDrug.RapeDrugSlenAphrodisiac)
	ElseIf Option == StorageUtil.GetIntValue(Self, "RapeDrugSensitivityOID")
		ForceDrug.RapeDrugSensitivity = !ForceDrug.RapeDrugSensitivity
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "RapeDrugSensitivityOID"), ForceDrug.RapeDrugSensitivity)

	ElseIf (option == SexExpResetStatsOID_T)
		If ShowMessage("Are you sure you want to reset all your SLS sex stats back to zero?")
			ResetSexExpStats()
		EndIf
	ElseIf (option == SexMinStamMagRatesOID)
		SexMinStamMagRates = !SexMinStamMagRates
		SetToggleOptionValue(SexMinStamMagRatesOID, SexMinStamMagRates)
		ForcePageReset()
	ElseIf (option == SexRapeDrainsAttributesOID)
		RapeDrainsAttributes = !RapeDrainsAttributes
		SetToggleOptionValue(SexRapeDrainsAttributesOID, RapeDrainsAttributes)
		
	ElseIf (option == IneqStatsOID)
		If _SLS_IneqStat.GetValueInt() == 0
			_SLS_IneqStat.SetValueInt(1)
		Else
			_SLS_IneqStat.SetValueInt(0)
		EndIf
		SetToggleOptionValue(IneqStatsOID, _SLS_IneqStat.GetValueInt() as Bool)
		ForcePageReset()
	ElseIf (option == IneqCarryOID)
		If _SLS_IneqCarry.GetValueInt() == 0
			_SLS_IneqCarry.SetValueInt(1)
		Else
			_SLS_IneqCarry.SetValueInt(0)
		EndIf
		SetToggleOptionValue(IneqCarryOID, _SLS_IneqCarry.GetValueInt() as Bool)
		ForcePageReset()
	ElseIf (option == InqSpeedOID)
		If _SLS_IneqSpeed.GetValueInt() == 0
			_SLS_IneqSpeed.SetValueInt(1)
		Else
			_SLS_IneqSpeed.SetValueInt(0)
		EndIf
		SetToggleOptionValue(InqSpeedOID, _SLS_IneqSpeed.GetValueInt() as Bool)
		ForcePageReset()
	ElseIf (option == IneqDamageOID)
		If _SLS_IneqDamage.GetValueInt() == 0
			_SLS_IneqDamage.SetValueInt(1)
		Else
			_SLS_IneqDamage.SetValueInt(0)
		EndIf
		SetToggleOptionValue(IneqDamageOID, _SLS_IneqDamage.GetValueInt() as Bool)
		ForcePageReset()
	ElseIf (option == IneqDestOID)
		If _SLS_IneqDestruction.GetValueInt() == 0
			_SLS_IneqDestruction.SetValueInt(1)
		Else
			_SLS_IneqDestruction.SetValueInt(0)
		EndIf
		SetToggleOptionValue(IneqDestOID, _SLS_IneqDestruction.GetValueInt() as Bool)
		ForcePageReset()
	ElseIf (option == IneqSkillsOID)
		InequalitySkills = !InequalitySkills
		ToggleIneqSkills()
		SetToggleOptionValue(IneqSkillsOID, InequalitySkills)
	ElseIf (option == IneqBuySellOID)
		InequalityBuySell = !InequalityBuySell
		ToggleIneqBuySell()
		SetToggleOptionValue(IneqBuySellOID, InequalityBuySell)
	ElseIf (option == IneqStrongFemaleFollowersOID)
		IneqStrongFemaleFollowers = !IneqStrongFemaleFollowers
		SetToggleOptionValue(IneqStrongFemaleFollowersOID, IneqStrongFemaleFollowers)
		DoToggleIneqStrongFemaleFollowers = true
	ElseIf (option == ModStrongFemaleOID_T)
		SetStrongFemale()
		ForcePageReset()
	ElseIf (option == LicShowApiBlockFormsOID_T)
		LicShowApiBlockForms()
	ElseIf (option == LicClearApiBlockFormsOID_T)
		SetTextOptionValue(LicClearApiBlockFormsOID_T, "Clearing...")
		LicClearApiBlockForms()
		SetTextOptionValue(LicClearApiBlockFormsOID_T, "Done! ")
		
	ElseIf (option == PpLootEnableOID)
		PpLootEnable = !PpLootEnable
		SetToggleOptionValue(PpLootEnableOID, PpLootEnable)
		TogglePpLoot()

	ElseIf Option == StorageUtil.GetIntValue(Self, "AmpBlockMagicOID")
		Amputation.BlockMagic = !Amputation.BlockMagic
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "AmpBlockMagicOID"), Amputation.BlockMagic)
	ElseIf (option == DismemberTrollCumOID)
		DismemberTrollCum = !DismemberTrollCum
		SetToggleOptionValue(DismemberTrollCumOID, DismemberTrollCum)
	ElseIf (option == DismemberBathingOID)
		DismemberBathing = !DismemberBathing
		SetToggleOptionValue(DismemberBathingOID, DismemberBathing)
	ElseIf (option == DismemberPlayerSayOID)
		DismemberPlayerSay = !DismemberPlayerSay
		SetToggleOptionValue(DismemberPlayerSayOID, DismemberPlayerSay)
	ElseIf (option == StorageUtil.GetIntValue(Self, "DismemberCombatStopOID"))
		StorageUtil.SetIntValue(Self, "DismemberCombatStop", (!StorageUtil.GetIntValue(Self, "DismemberCombatStop", Missing = 1) as Bool) as Int)
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "DismemberCombatStopOID"), StorageUtil.GetIntValue(Self, "DismemberCombatStop"))
	ElseIf (option == CumSwallowInflateOID)
		CumSwallowInflate = !CumSwallowInflate
		SetToggleOptionValue(CumSwallowInflateOID, CumSwallowInflate)
		ForcePageReset()
	ElseIf (option == CumEffectsEnableOID)
		CumEffectsEnable = !CumEffectsEnable
		SetToggleOptionValue(CumEffectsEnableOID, CumEffectsEnable)
		DoToggleCumEffects = true
		ForcePageReset()
	ElseIf (option == CumEffectsStackOID)
		CumEffectsStack = !CumEffectsStack
		SetToggleOptionValue(CumEffectsStackOID, CumEffectsStack)
	ElseIf (option == SuccubusCumSwallowEnergyPerRankOID)
		SuccubusCumSwallowEnergyPerRank = !SuccubusCumSwallowEnergyPerRank
		SetToggleOptionValue(SuccubusCumSwallowEnergyPerRankOID, SuccubusCumSwallowEnergyPerRank)
	ElseIf (option == MilkDecCumBreathOID)
		MilkDecCumBreath = !MilkDecCumBreath
		SetToggleOptionValue(MilkDecCumBreathOID, MilkDecCumBreath)
	ElseIf (option == CumAddictEnOID)
		CumAddictEn = !CumAddictEn
		SetToggleOptionValue(CumAddictEnOID, CumAddictEn)
		DoToggleCumAddiction = true
		ForcePageReset()
	ElseIf (option == CumAddictClampHungerOID)
		CumAddictClampHunger = !CumAddictClampHunger
		SetToggleOptionValue(CumAddictClampHungerOID, CumAddictClampHunger)
		CumAddict.DoUpdate()
	ElseIf (option == CumAddictBeastLevelsOID)
		CumAddictBeastLevels = !CumAddictBeastLevels
		SetToggleOptionValue(CumAddictBeastLevelsOID, CumAddictBeastLevels)
		CumAddict.LoadNewHungerThresholds()
		CumAddict.DoUpdate()
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "CumAddictBlockDecayOID")
		CumAddict.CumBlocksAddictionDecay = !CumAddict.CumBlocksAddictionDecay
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "CumAddictBlockDecayOID"), CumAddict.CumBlocksAddictionDecay)
	ElseIf Option == StorageUtil.GetIntValue(Self, "CumAddictDayDreamOID")
		StorageUtil.SetIntValue(Self, "CumAddictDayDream", (!StorageUtil.GetIntValue(Self, "CumAddictDayDream", Missing = 1) as Bool) as Int)
		StorageUtil.SetIntValue(Self, "DoToggleDaydream", 1)
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "CumAddictDayDreamOID"), StorageUtil.GetIntValue(Self, "CumAddictDayDream", Missing = 1))
	ElseIf Option == StorageUtil.GetIntValue(Self, "CumAddictDayDreamButterflysOID")
		StorageUtil.SetIntValue(Self, "CumAddictDayDreamButterflys", (!StorageUtil.GetIntValue(Self, "CumAddictDayDreamButterflys", Missing = 1) as Bool) as Int)
		StorageUtil.SetIntValue(Self, "DoToggleDaydreamButterflys", 1)
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "CumAddictDayDreamButterflysOID"), StorageUtil.GetIntValue(Self, "CumAddictDayDreamButterflys", Missing = 1))
	ElseIf Option == StorageUtil.GetIntValue(Self, "CumAddictAutoSuckVictim")
		CumAddict.AutoSuckVictim = !CumAddict.AutoSuckVictim
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "CumAddictAutoSuckVictim"), CumAddict.AutoSuckVictim)

	ElseIf (option == CumLactacidAllOID)
		CumLactacidAll = !CumLactacidAll
		SetToggleOptionValue(CumLactacidAllOID, CumLactacidAll)
		ToggleCumAsLactacid(Voice = None)
		ForcePageReset()
	ElseIf (option == CumLactacidCustomOID_T)
		ToggleCumAsLactacidCustom()
		ForcePageReset()
	ElseIf (option == CumLactacidAllPlayableOID)
		CumLactacidAllPlayable = !CumLactacidAllPlayable
		SetToggleOptionValue(CumLactacidAllPlayableOID, CumLactacidAllPlayable)
	ElseIf Option == StorageUtil.GetIntValue(Self, "CumLactacidBearOID")
		ToggleCumAsLactacid(_SLS_CumLactacidVoicesList.GetAt(0) as VoiceType)
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "CumLactacidChaurusOID")
		ToggleCumAsLactacid(_SLS_CumLactacidVoicesList.GetAt(1) as VoiceType)
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "CumLactacidDeerOID")
		ToggleCumAsLactacid(_SLS_CumLactacidVoicesList.GetAt(2) as VoiceType)
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "CumLactacidDogOID")
		ToggleCumAsLactacid(_SLS_CumLactacidVoicesList.GetAt(3) as VoiceType)
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "CumLactacidDragonPriestOID")
		ToggleCumAsLactacid(_SLS_CumLactacidVoicesList.GetAt(4) as VoiceType)
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "CumLactacidDragonOID")
		ToggleCumAsLactacid(_SLS_CumLactacidVoicesList.GetAt(5) as VoiceType)
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "CumLactacidDraugrOID")
		ToggleCumAsLactacid(_SLS_CumLactacidVoicesList.GetAt(6) as VoiceType)
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "CumLactacidDremoraOID")
		ToggleCumAsLactacid(_SLS_CumLactacidVoicesList.GetAt(7) as VoiceType)
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "CumLactacidDwarvenCenturionOID")
		ToggleCumAsLactacid(_SLS_CumLactacidVoicesList.GetAt(8) as VoiceType)
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "CumLactacidDwarvenSphereOID")
		ToggleCumAsLactacid(_SLS_CumLactacidVoicesList.GetAt(9) as VoiceType)
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "CumLactacidDwarvenSpiderOID")
		ToggleCumAsLactacid(_SLS_CumLactacidVoicesList.GetAt(10) as VoiceType)
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "CumLactacidFalmerOID")
		ToggleCumAsLactacid(_SLS_CumLactacidVoicesList.GetAt(11) as VoiceType)
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "CumLactacidFoxOID")
		ToggleCumAsLactacid(_SLS_CumLactacidVoicesList.GetAt(12) as VoiceType)
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "CumLactacidSpiderOID")
		ToggleCumAsLactacid(_SLS_CumLactacidVoicesList.GetAt(13) as VoiceType)
		ToggleCumAsLactacid(_SLS_CumLactacidVoicesList.GetAt(14) as VoiceType)
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "CumLactacidGiantOID")
		ToggleCumAsLactacid(_SLS_CumLactacidVoicesList.GetAt(15) as VoiceType)
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "CumLactacidGoatOID")
		ToggleCumAsLactacid(_SLS_CumLactacidVoicesList.GetAt(16) as VoiceType)
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "CumLactacidHorkerOID")
		ToggleCumAsLactacid(_SLS_CumLactacidVoicesList.GetAt(17) as VoiceType)
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "CumLactacidHorseOID")
		ToggleCumAsLactacid(_SLS_CumLactacidVoicesList.GetAt(18) as VoiceType)
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "CumLactacidMammothOID")
		ToggleCumAsLactacid(_SLS_CumLactacidVoicesList.GetAt(19) as VoiceType)
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "CumLactacidSabrecatOID")
		ToggleCumAsLactacid(_SLS_CumLactacidVoicesList.GetAt(20) as VoiceType)
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "CumLactacidSkeeverOID")
		ToggleCumAsLactacid(_SLS_CumLactacidVoicesList.GetAt(21) as VoiceType)
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "CumLactacidSprigganOID")
		ToggleCumAsLactacid(_SLS_CumLactacidVoicesList.GetAt(22) as VoiceType)
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "CumLactacidTrollOID")
		ToggleCumAsLactacid(_SLS_CumLactacidVoicesList.GetAt(23) as VoiceType)
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "CumLactacidWerewolfOID")
		ToggleCumAsLactacid(_SLS_CumLactacidVoicesList.GetAt(24) as VoiceType)
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "CumLactacidWolfOID")
		ToggleCumAsLactacid(_SLS_CumLactacidVoicesList.GetAt(25) as VoiceType)
		
	ElseIf (option == FfRescueEventsOID)
		FfRescueEvents = !FfRescueEvents
		SetToggleOptionValue(FfRescueEventsOID, FfRescueEvents)
		ForcePageReset()
		
	ElseIf (option == PpSleepNpcPerkOID)
		PpSleepNpcPerk = !PpSleepNpcPerk
		SetToggleOptionValue(PpSleepNpcPerkOID, PpSleepNpcPerk)
		TogglePpSleepNpcPerk()
	ElseIf (option == PpFailHandleOID)
		PpFailHandle = !PpFailHandle
		SetToggleOptionValue(PpFailHandleOID, PpFailHandle)
		DoTogglePpFailHandle = true
	ElseIf (option == NormalKnockDialogOID)
		Init.SKdialog = !Init.SKdialog
		SetToggleOptionValue(NormalKnockDialogOID, Init.SKdialog)

	ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaEnableOID")
		Trauma.TraumaEnable = !Trauma.TraumaEnable
		StorageUtil.SetIntValue(Self, "DoToggleTrauma", 1)
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "TraumaEnableOID"), Trauma.TraumaEnable)
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaRebuildTexturesOID_T")
		If ShowMessage("Rebuilding the texture list will remove all existing traumas. Proceed?")
			SetTextOptionValue(StorageUtil.GetIntValue(Self, "TraumaRebuildTexturesOID_T"), "Working...")
			Trauma.SetupTextureArrays()
			SetTextOptionValue(StorageUtil.GetIntValue(Self, "TraumaRebuildTexturesOID_T"), "Done! ")
		EndIf		
	ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaDynamicOID")
		Trauma.DynamicTrauma = !Trauma.DynamicTrauma
		StorageUtil.SetIntValue(Self, "DoToggleDynamicTrauma", 1)
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "TraumaDynamicOID"), Trauma.DynamicTrauma)
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaDynamicCombatOID")
		Trauma.DynamicCombat = !Trauma.DynamicCombat
		Trauma.RegisterForCombat()
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "TraumaDynamicCombatOID"), Trauma.DynamicCombat)
		
	ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaPlayerSqueaksOID")
		Trauma.PlayerSqueaks = !Trauma.PlayerSqueaks
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "TraumaPlayerSqueaksOID"), Trauma.PlayerSqueaks)
	ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaTrackFollowerOID_T")
		Trauma.ToggleFollowerTracking(Game.GetCurrentCrosshairRef() as Actor)
		ForcePageReset()
	ElseIf (option == SleepDeprivOID)
		SleepDepriv = !SleepDepriv
		SetToggleOptionValue(SleepDeprivOID, SleepDepriv)
		ToggleSleepDepriv()
	ElseIf (option == SaltyCumOID)
		SaltyCum = !SaltyCum
		SetToggleOptionValue(SaltyCumOID, SaltyCum)
		SetSaltyCum(SaltyCum)
	ElseIf (option == BellyScaleEnableOID)
		BellyScaleEnable = !BellyScaleEnable
		SetToggleOptionValue(BellyScaleEnableOID, BellyScaleEnable)
		DoToggleBellyInflation = true
		ForcePageReset()

	ElseIf (option == SlsCreatureEventOID)
		Init.SlsCreatureEvents = !Init.SlsCreatureEvents
		SetToggleOptionValue(SlsCreatureEventOID, Init.SlsCreatureEvents)
		ToggleCreatureEvents()
		ForcePageReset()
	ElseIf (option == AnimalBreedEnableOID)
		AnimalBreedEnable = !AnimalBreedEnable
		SetToggleOptionValue(AnimalBreedEnableOID, AnimalBreedEnable)
		DoToggleAnimalBreeding = true
		ForcePageReset()
	ElseIf (option == AddFondleToListOID_T)
		ModFondleVoice(AddToList = true)
		ForcePageReset()
	ElseIf (option == RemoveFondleFromListOID_T)
		ModFondleVoice(AddToList = false)
		ForcePageReset()
		
	ElseIf (option == AddTownLocationOID_T)
		ModLocationJurisdiction(true)
		ForcePageReset()
	ElseIf (option == RemoveTownLocationOID_T)
		ModLocationJurisdiction(false)
		ForcePageReset()
	
	ElseIf (option == FfRescueEventsOID)
		FfRescueEvents = !FfRescueEvents
		SetToggleOptionValue(FfRescueEventsOID, FfRescueEvents)
		ForcePageReset()

	ElseIf option == StorageUtil.GetIntValue(Self, "TollsEnableOID")
		Init.TollEnable = !Init.TollEnable
		ToggleTolls()
		ForcePageReset()
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "TollsEnableOID"), Init.TollEnable)
	ElseIf option == StorageUtil.GetIntValue(Self, "ResidentsDontPayTollsOID")
		LocTrack.ResidentsDontPayTolls = !LocTrack.ResidentsDontPayTolls
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "ResidentsDontPayTollsOID"), LocTrack.ResidentsDontPayTolls)
	ElseIf (option == DoorLockDownOID)
		DoorLockDownT = !DoorLockDownT
		ToggleTollGateLocks()
		SetToggleOptionValue(DoorLockDownOID, DoorLockDownT)
	ElseIf (option == TollFollowersHardcoreOID)
		If ShowMessage("Are you sure you want to lock followers required?\nYou won't be able to change it again when set")
			TollFollowersHardcore = !TollFollowersHardcore
			SetToggleOptionValue(TollFollowersHardcoreOID, TollFollowersHardcore)
			ForcePageReset()
		EndIf
	ElseIf (option == DropItemsOID)
		DropItems = !DropItems
		SetToggleOptionValue(DropItemsOID, DropItems)
	ElseIf (option == StorageUtil.GetIntValue(Self, "SLS_CombatEquipEnableOID"))
		StorageUtil.SetIntValue(Self, "CombatEquipEnabled", (!StorageUtil.GetIntValue(Self, "CombatEquipEnabled", Missing = 1) as Bool) as Int)
		StorageUtil.SetIntValue(Self, "DoToggleCombatEquip", 1)
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "SLS_CombatEquipEnableOID"), StorageUtil.GetIntValue(Self, "CombatEquipEnabled"))
	ElseIf (option == FastTravelDisableOID)
		FastTravelDisable = !FastTravelDisable
		SetToggleOptionValue(FastTravelDisableOID, FastTravelDisable)
		ToggleFastTravelDisable()
	ElseIf (option == FtDisableIsNormalOID)
		FtDisableIsNormal = !FtDisableIsNormal
		SetToggleOptionValue(FtDisableIsNormalOID, FtDisableIsNormal)
	ElseIf (option == CompassMechanicsOID)
		CompassMechanics = !CompassMechanics
		SetToggleOptionValue(CompassMechanicsOID, CompassMechanics)
		ToggleCompassMechanics()
	ElseIf (option == ReplaceMapsOID)
		ReplaceMaps = !ReplaceMaps
		SetToggleOptionValue(ReplaceMapsOID, ReplaceMaps)
		ReplaceVanillaMaps(ReplaceMaps)		
	ElseIf (option == ConstructableMapAndCompassOID)
		If _SLS_MapAndCompassRecipeEnable.GetValueInt() == 0
			_SLS_MapAndCompassRecipeEnable.SetValueInt(1)
		Else
			_SLS_MapAndCompassRecipeEnable.SetValueInt(0)
		EndIf
		SetToggleOptionValue(ConstructableMapAndCompassOID, _SLS_MapAndCompassRecipeEnable.GetValueInt())

	ElseIf (option == GoldPerLevelOID)
		TollUtil.TollCostPerLevel = !TollUtil.TollCostPerLevel
		SetToggleOptionValue(GoldPerLevelOID, TollUtil.TollCostPerLevel)
		;SetTollCost()
		
	ElseIf Option == StorageUtil.GetIntValue(Self, "TollDrugLactacidOID")
		ForceDrug.TollDrugLactacid = !ForceDrug.TollDrugLactacid
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "TollDrugLactacidOID"), ForceDrug.TollDrugLactacid)
	ElseIf Option == StorageUtil.GetIntValue(Self, "TollDrugSkoomaOID")
		ForceDrug.TollDrugSkooma = !ForceDrug.TollDrugSkooma
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "TollDrugSkoomaOID"), ForceDrug.TollDrugSkooma)
	ElseIf Option == StorageUtil.GetIntValue(Self, "TollDrugCumHumanOID")
		ForceDrug.TollDrugHumanCum = !ForceDrug.TollDrugHumanCum
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "TollDrugCumHumanOID"), ForceDrug.TollDrugHumanCum)
	ElseIf Option == StorageUtil.GetIntValue(Self, "TollDrugCumCreatureOID")
		ForceDrug.TollDrugCreatureCum = !ForceDrug.TollDrugCreatureCum
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "TollDrugCumCreatureOID"), ForceDrug.TollDrugCreatureCum)
	ElseIf Option == StorageUtil.GetIntValue(Self, "TollDrugInflateOID")
		ForceDrug.TollDrugInflate = !ForceDrug.TollDrugInflate
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "TollDrugInflateOID"), ForceDrug.TollDrugInflate)
	ElseIf Option == StorageUtil.GetIntValue(Self, "TollDrugFmFertilityOID")
		ForceDrug.TollDrugFmFertility = !ForceDrug.TollDrugFmFertility
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "TollDrugFmFertilityOID"), ForceDrug.TollDrugFmFertility)
	ElseIf Option == StorageUtil.GetIntValue(Self, "TollDrugSlenAphrodisiacOID")
		ForceDrug.TollDrugSlenAphrodisiac = !ForceDrug.TollDrugSlenAphrodisiac
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "TollDrugSlenAphrodisiacOID"), ForceDrug.TollDrugSlenAphrodisiac)
	ElseIf Option == StorageUtil.GetIntValue(Self, "TollDrugSensitivityOID")
		ForceDrug.TollDrugSensitivity = !ForceDrug.TollDrugSensitivity
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "TollDrugSensitivityOID"), ForceDrug.TollDrugSensitivity)

	ElseIf (option == TollDodgingOID)
		TollDodging = !TollDodging
		SetToggleOptionValue(TollDodgingOID, TollDodging)
		DoTollDodgingToggle = true
		ForcePageReset()
	ElseIf (option == TollDodgeGiftMenuOID)
		Init.TollDodgeGiftMenu = !Init.TollDodgeGiftMenu
		SetToggleOptionValue(TollDodgeGiftMenuOID, Init.TollDodgeGiftMenu)
	ElseIf (option == CurfewEnableOID)
		CurfewEnable = !CurfewEnable
		SetToggleOptionValue(CurfewEnableOID, CurfewEnable)
		TollUtil.IsCurfewTimeByLoc(PlayerRef.GetCurrentLocation())
		ForcePageReset()
	ElseIf (option == LicencesEnableOID)
		If ShowMessage("Are you sure you want to toggle the licence system?\nIf you are disabling the system any licences in your inventory will be removed!\n\nYou'll have to exit the menu and return to the game to complete the process")
			Init.LicencesEnable = !Init.LicencesEnable
			SetToggleOptionValue(LicencesEnableOID, Init.LicencesEnable)
			ForcePageReset()
			ToggleLicences(Init.LicencesEnable)
		EndIf
	ElseIf (option == LicencesSnowberryOID)
		If CanEnableSnowberry()
			SnowberryEnable = !SnowberryEnable
			SetToggleOptionValue(LicencesSnowberryOID, SnowberryEnable)
		Else
			Debug.Messagebox("Can not enable Snowberry after starting your game. You must enable it before leaving Helgen")
		EndIf
	ElseIf (option == BikiniLicFirstOID)
		LicUtil.AlwaysAwardBikiniLicFirst = !LicUtil.AlwaysAwardBikiniLicFirst
		SetToggleOptionValue(BikiniLicFirstOID, LicUtil.AlwaysAwardBikiniLicFirst)
	ElseIf (option == LicBuyBackOID)
		LicUtil.BuyBack = !LicUtil.BuyBack
		SetToggleOptionValue(LicBuyBackOID, LicUtil.BuyBack)
	ElseIf (option == LicBountyMustBePaidOID)
		LicUtil.BountyMustBePaid = !LicUtil.BountyMustBePaid
		SetToggleOptionValue(LicBountyMustBePaidOID, LicUtil.BountyMustBePaid)
	ElseIf option == StorageUtil.GetIntValue(Self, "LicCheckFollowers")
		LicUtil.CheckFollowers = !LicUtil.CheckFollowers
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "LicCheckFollowers"), LicUtil.CheckFollowers)
		ForcePageReset()
	ElseIf option == StorageUtil.GetIntValue(Self, "LicForceCheckDeviousFollower")
		LicUtil.ForceCheckDF = !LicUtil.ForceCheckDF
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "LicForceCheckDeviousFollower"), LicUtil.ForceCheckDF)
	ElseIf (option == FolContraBlockOID)
		FolContraBlock = !FolContraBlock
		SetToggleOptionValue(FolContraBlockOID, FolContraBlock)
		ToggleFolContraBlock()
	ElseIf (option == FolContraKeysOID)
		LicUtil.FollowerWontCarryKeys = !LicUtil.FollowerWontCarryKeys
		SetToggleOptionValue(FolContraKeysOID, LicUtil.FollowerWontCarryKeys)
	ElseIf (option == FolTakeClothesOID)
		LicUtil.FolTakeClothes = !LicUtil.FolTakeClothes
		SetToggleOptionValue(FolTakeClothesOID, LicUtil.FolTakeClothes)
	ElseIf (option == OrdinSupressOID)
		LicUtil.OrdinSupress = !LicUtil.OrdinSupress
		SetToggleOptionValue(OrdinSupressOID, LicUtil.OrdinSupress)
		LicUtil.ToggleOrdinSuppression()
	ElseIf (option == CurseTatsOID)
		LicUtil.CurseTats = !LicUtil.CurseTats
		SetToggleOptionValue(CurseTatsOID, LicUtil.CurseTats)
		ToggleCurseTats()
		ForcePageReset()
	ElseIf (option == SearchEscortsOID_T)
		Debug.Messagebox("Please exit the menu to continue and wait for the process to complete. It can take some time depending on how many followers you have installed so please be patient\n\nIf you cancel the process then any followers added up to that point will stay in the list")
		SearchEscorts()
	ElseIf (option == AddEscortToListOID_T)
		AddEscort()
		ForcePageReset()
	ElseIf (option == RemoveEscortFromListOID_T)
		RemoveEscort()
		ForcePageReset()
	ElseIf (option == ClearAllEscortsOID_T)
		If ShowMessage("Are you sure you want to clear all escorts?\nThe Json file will be wiped clean!")
			SetTextOptionValue(ClearAllEscortsOID_T, "Clearing...")
			ClearAllEscorts()
			SetTextOptionValue(ClearAllEscortsOID_T, "Done! ")
			Utility.WaitMenuMode(0.6)
			ForcePageReset()
		EndIf
	ElseIf (option == ImportEscortsFromJsonOID_T)
		If ShowMessage("Are you sure you want to clear all escorts and read in escorts from the Json file?")
			SetTextOptionValue(ImportEscortsFromJsonOID_T, "Working...")
			ReImportEscorts()
			SetTextOptionValue(ImportEscortsFromJsonOID_T, "Done! ")
			Utility.WaitMenuMode(0.6)
			ForcePageReset()
		EndIf
	ElseIf (option == LicGetEquipListOID_T)
		GetEquippedList()
	ElseIf (option == AddLicExceptionOID_T)
		AddRemoveLicenceException()
		ForcePageReset()
	ElseIf (option == ResponsiveEnforcersOID)
		If _SLS_ResponsiveEnforcers.GetValueInt() == 0
			_SLS_ResponsiveEnforcers.SetValueInt(1)
		Else
			_SLS_ResponsiveEnforcers.SetValueInt(0)
		EndIf
		SetToggleOptionValue(RestrictTradeOID, _SLS_ResponsiveEnforcers.GetValueInt() as Bool)
		ForcePageReset()
	ElseIf (option == RestrictTradeOID)
		TradeRestrictions = !TradeRestrictions
		SetToggleOptionValue(RestrictTradeOID, TradeRestrictions)
		ToggleTradeRestrictions()

	ElseIf (option == TradeRestrictAddMerchantOID_T)
		DoTradeRestrictAddMerchant()
	ElseIf (option == TradeRestrictRemoveMerchantOID_T)
		DoTradeRestrictRemoveMerchant()
	ElseIf (option == TradeRestrictResetAllMerchantsOID_T)
		DoTradeRestrictResetAllMerchants()
		
	ElseIf (option == LicBikiniEnableOID)
		LicUtil.LicBikiniEnable = !LicUtil.LicBikiniEnable
		LicenceToggleToggled()
		SetToggleOptionValue(LicBikiniEnableOID, LicUtil.LicBikiniEnable)
		ForcePageReset()
	ElseIf (option == LicBikiniCurseEnableOID)
		LicUtil.BikiniCurseEnable = !LicUtil.BikiniCurseEnable
		ToggleBikiniCurse()
		SetToggleOptionValue(LicBikiniCurseEnableOID, LicUtil.BikiniCurseEnable)
	ElseIf (option == LicBikiniHeelsOID)
		BikiniCurse.HeelsRequired = !BikiniCurse.HeelsRequired
		SetToggleOptionValue(LicBikiniHeelsOID, BikiniCurse.HeelsRequired)
		DoToggleHeelsRequired = true
	ElseIf Option == StorageUtil.GetIntValue(Self, "LicBikiniArmorTestOID_T")
		TestBikiniArmor()

	ElseIf (option == LicMagicEnableOID)
		LicUtil.LicMagicEnable = !LicUtil.LicMagicEnable
		LicenceToggleToggled()
		SetToggleOptionValue(LicMagicEnableOID, LicUtil.LicMagicEnable)
		ForcePageReset()
		LicUtil.SetMagicCurseGlobalStatus()
	ElseIf Option == StorageUtil.GetIntValue(Self, "CurfewLicenceEnableOID")
		LicUtil.LicCurfewEnable = !LicUtil.LicCurfewEnable
		LicenceToggleToggled()
		StorageUtil.SetIntValue(Self, "DoToggleCurfew", 1)
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "CurfewLicenceEnableOID"), LicUtil.LicCurfewEnable)
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "LicCurfewNotificationsOID")
		(Game.GetFormFromFile(0x0E3F3D, "SL Survival.esp") as _SLS_Curfew).DoCurfewNotification = !(Game.GetFormFromFile(0x0E3F3D, "SL Survival.esp") as _SLS_Curfew).DoCurfewNotification
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "LicCurfewNotificationsOID"), (Game.GetFormFromFile(0x0E3F3D, "SL Survival.esp") as _SLS_Curfew).DoCurfewNotification)		
	ElseIf Option == StorageUtil.GetIntValue(Self, "WhoreLicenceEnableOID")
		LicUtil.LicWhoreEnable = !LicUtil.LicWhoreEnable
		LicenceToggleToggled()
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "WhoreLicenceEnableOID"), LicUtil.LicWhoreEnable)
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "PropertyLicenceEnableOID")
		LicUtil.LicPropertyEnable = !LicUtil.LicPropertyEnable
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "PropertyLicenceEnableOID"), LicUtil.LicPropertyEnable)
		Eviction.UpdateEvictions(DoImmediately = true)
		LicenceToggleToggled()
		ForcePageReset()

	ElseIf (option == LicMagicCursedDevicesOID)
		LicUtil.LicMagicCursedDevices = !LicUtil.LicMagicCursedDevices
		SetToggleOptionValue(LicMagicCursedDevicesOID, LicUtil.LicMagicCursedDevices)
		ToggleLicMagicCursedDevices()
	ElseIf (option == LicMagicChainCollarsOID)
		LicMagicChainCollars = !LicMagicChainCollars
		SetToggleOptionValue(LicMagicChainCollarsOID, LicMagicChainCollars)
		AddRemoveChainCollars(LicMagicChainCollars)

	ElseIf (option == StashTrackEnOID)
		StashTrackEn = !StashTrackEn
		SetToggleOptionValue(StashTrackEnOID, StashTrackEn)
		DoToggleStashTracking = true
		ForcePageReset()
	ElseIf (option == StashAddRemoveExceptionOID_T)
		DoStashAddRemoveException = !DoStashAddRemoveException
		If DoStashAddRemoveException
			Debug.Messagebox("Exit the menu, open the container and add an item to the container to remove the container from tracking")
			SetTextOptionValue(StashAddRemoveExceptionOID_T, "Armed! ")
		Else
			SetTextOptionValue(StashAddRemoveExceptionOID_T, "")
		EndIf
		
	ElseIf (option == StashAddRemoveJsonExceptionsOID_T)
		If ShowMessage("Are you certain you want to remove all added stash exceptions from the json file?")
			StashClearAllJsonExceptions()
			SetTextOptionValue(StashAddRemoveJsonExceptionsOID_T, "Done! ")
			Utility.WaitMenuMode(0.6)
			ForcePageReset()
		EndIf
	ElseIf (option == StashAddRemoveTempExceptionsOID_T)
		If ShowMessage("Are you certain you want to remove all added temporary stash exceptions?")
			StashClearAllTempExceptions()
			SetTextOptionValue(StashAddRemoveTempExceptionsOID_T, "Done! ")
			Utility.WaitMenuMode(0.6)
			ForcePageReset()
		EndIf
	ElseIf (option == StashAddRemoveAllExceptionsOID_T)
		If ShowMessage("Are you certain you want to remove all added stash exceptions?\nStashes saved to the json file will also be cleared in the process")
			StashClearAllStashExceptions()
			SetTextOptionValue(StashAddRemoveAllExceptionsOID_T, "Done! ")
			Utility.WaitMenuMode(0.6)
			ForcePageReset()
		EndIf
		
	ElseIf Option == StorageUtil.GetIntValue(Self, "DroppedItemStealingEnOID")
		StorageUtil.SetIntValue(Self, "DoToggleDropStealing", 1)
		StorageUtil.SetIntValue(Self, "DroppedItemStealingEn", (!StorageUtil.GetIntValue(Self, "DroppedItemStealingEn", Missing = 1) as Bool) as Int)
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "DroppedItemStealingEnOID"), StorageUtil.GetIntValue(Self, "DroppedItemStealingEn"))
		
	ElseIf (option == ContTypeCountsOID)
		ContTypeCountsT = !ContTypeCountsT
		SetToggleOptionValue(ContTypeCountsOID, ContTypeCountsT)
	ElseIf (option == OrgasmRequiredOID)
		OrgasmRequired = !OrgasmRequired
		SetToggleOptionValue(OrgasmRequiredOID, OrgasmRequired)
	ElseIf Option == StorageUtil.GetIntValue(Self, "JigglesOID")
		StorageUtil.SetIntValue(Self, "Jiggles", (!StorageUtil.GetIntValue(Self, "Jiggles", Missing = 1) as Bool) as Int)
		StorageUtil.SetIntValue(Self, "DoToggleJiggles", 1)
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "CompulsiveSexOID")
		StorageUtil.SetIntValue(Self, "CompulsiveSex", (!StorageUtil.GetIntValue(Self, "CompulsiveSex", Missing = 0) as Bool) as Int)
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "CompulsiveSexOID"), StorageUtil.GetIntValue(Self, "CompulsiveSex", Missing = 0))
		StorageUtil.SetIntValue(Self, "DoToggleCompulsiveSex", 1)
		If StorageUtil.GetIntValue(Self, "CompulsiveSex", Missing = 0) == 1
			Debug.Messagebox("Warning!\n\nThere is a little known bug in the interaction between TapKey (which compulsive sex uses) and RegisterForKey(0) (Which other mods, usually with hotkeys, might use). If another mod Registers for key zero and compulsive sex does TapKey it can create hundreds of OnKeyDown() events in the registered mod. Potentially clogging up your papyrus VM with spammed script instances.\n\nOther mods should not register for key 0 but I can not determine if they have. If you enable this then keep an eye on your saves 'Active scripts' and 'Suspended stacks' in Falrim Tools especially after a compulsive sex scene. Ask the authors of affected mods to add a check before registering that the key is not 0")
		EndIf
	ElseIf Option == StorageUtil.GetIntValue(Self, "OrgasmFatigueOID")
		StorageUtil.SetIntValue(Self, "OrgasmFatigue", (!StorageUtil.GetIntValue(Self, "OrgasmFatigue", Missing = 1) as Bool) as Int)
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "OrgasmFatigueOID"), StorageUtil.GetIntValue(Self, "OrgasmFatigue", Missing = 1))
		StorageUtil.SetIntValue(Self, "DoToggleOrgasmFatigue", 1)
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "JigglesVisualsOID")
		(Game.GetFormFromFile(0x0CF9B1, "SL Survival.esp") as _SLS_BodyInflationTracking).DoImod = !(Game.GetFormFromFile(0x0CF9B1, "SL Survival.esp") as _SLS_BodyInflationTracking).DoImod
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "JigglesVisualsOID"), (Game.GetFormFromFile(0x0CF9B1, "SL Survival.esp") as _SLS_BodyInflationTracking).DoImod)
	ElseIf (option == BeggingTOID)
		If _SLS_BeggingDialogT.GetValueInt() == 0
			_SLS_BeggingDialogT.SetValueInt(1)
		Else
			_SLS_BeggingDialogT.SetValueInt(0)
		EndIf
		SetToggleOptionValue(BeggingTOID, _SLS_BeggingDialogT.GetValueInt() as Bool)
		ForcePageReset()
	ElseIf (option == BegSelfDegEnableOID)
		If _SLS_BegSelfDegradationEnable.GetValueInt() == 0
			_SLS_BegSelfDegradationEnable.SetValueInt(1)
		Else
			_SLS_BegSelfDegradationEnable.SetValueInt(0)
		EndIf
		SetToggleOptionValue(BegSelfDegEnableOID, _SLS_BegSelfDegradationEnable.GetValueInt() as Bool)
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "KennelSuitsOID")
		StorageUtil.SetIntValue(Self, "KennelSuits", (!(StorageUtil.GetIntValue(Self, "KennelSuits", Missing = 0)) as Bool) as Int)
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "KennelSuitsOID"), StorageUtil.GetIntValue(Self, "KennelSuits", Missing = 0))
	ElseIf (option == KennelExtraDevicesOID)
		If _SLS_KennelExtraDevices.GetValueInt() == 0
			_SLS_KennelExtraDevices.SetValueInt(1)
		Else
			_SLS_KennelExtraDevices.SetValueInt(0)
		EndIf
		SetToggleOptionValue(KennelExtraDevicesOID, _SLS_KennelExtraDevices.GetValueInt() as Bool)
		ForcePageReset()
	ElseIf (option == KennelFollowerToggleOID)
		ToggleKennelFollower()
	
	ElseIf (option == GuardCommentsOID)
		GuardComments = !GuardComments
		SetToggleOptionValue(GuardCommentsOID, GuardComments)
		DoToggleGuardComments = true
	ElseIf (option == GuardBehavWeapDropOID)
		If _SLS_GuardBehavWeapDropEn.GetValueInt() == 1
			_SLS_GuardBehavWeapDropEn.SetValueInt(0)
		Else
			_SLS_GuardBehavWeapDropEn.SetValueInt(1)
		EndIf
		SetToggleOptionValue(GuardBehavWeapDropOID, _SLS_GuardBehavWeapDropEn.GetValueInt() as Bool)
	ElseIf (option == GuardBehavShoutOID)
		If _SLS_GuardBehavShoutEn.GetValueInt() == 1
			_SLS_GuardBehavShoutEn.SetValueInt(0)
		Else
			_SLS_GuardBehavShoutEn.SetValueInt(1)
		EndIf
		SetToggleOptionValue(GuardBehavShoutOID, _SLS_GuardBehavShoutEn.GetValueInt() as Bool)
	
	ElseIf (option == GuardBehavWeapDrawnOID)
		GuardBehavWeapDrawn = !GuardBehavWeapDrawn
		SetToggleOptionValue(GuardBehavWeapDrawnOID, GuardBehavWeapDrawn)
		DoToggleGuardBehavWeapDrawn = true
	ElseIf (option == GuardBehavWeapEquipOID)
		GuardBehavWeapEquip = !GuardBehavWeapEquip
		SetToggleOptionValue(GuardBehavWeapEquipOID, GuardBehavWeapEquip)
		DoToggleGuardBehavWeapEquip = true
	ElseIf (option == GuardBehavArmorEquipOID)
		GuardBehavArmorEquip = !GuardBehavArmorEquip
		SetToggleOptionValue(GuardBehavArmorEquipOID, GuardBehavArmorEquip)
		DoToggleGuardBehavArmorEquip = true
	ElseIf option == StorageUtil.GetIntValue(Self, "GuardBehavArmorEquipAnyArmorOID")
		StorageUtil.SetIntValue(Self, "GuardBehavArmorEquipAnyArmor", (!StorageUtil.GetIntValue(Self, "GuardBehavArmorEquipAnyArmor", Missing = 0) as Bool) as Int)
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "GuardBehavArmorEquipAnyArmorOID"), StorageUtil.GetIntValue(Self, "GuardBehavArmorEquipAnyArmor", Missing = 0) as Bool)
	ElseIf (option == GuardBehavLockpickingOID)
		GuardBehavLockpicking = !GuardBehavLockpicking
		SetToggleOptionValue(GuardBehavLockpickingOID, GuardBehavLockpicking)
		DoToggleGuardBehavLockpick = true
	ElseIf (option == GuardBehavDrugsOID)
		GuardBehavDrugs = !GuardBehavDrugs
		SetToggleOptionValue(GuardBehavDrugsOID, GuardBehavDrugs)
		DoToggleGuardBehavDrugs = true
		
	ElseIf (option == RunDevicePatchUpOID_T)
		Devious.DoDevicePatchup()
	ElseIf (option == DeviousEffectsEnableOID)
		DeviousEffectsEnable = !DeviousEffectsEnable
		SetToggleOptionValue(DeviousEffectsEnableOID, DeviousEffectsEnable)
		DoDeviousEffectsChange = true
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "DeviousDrowningOID")
		DeviousEffects.DeviousDrowning = !DeviousEffects.DeviousDrowning
		DeviousEffects.ToggleDeviousDrowning()
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "DeviousDrowningOID"), DeviousEffects.DeviousDrowning)
	ElseIf (option == DevEffNoGagTradingOID)
		DevEffNoGagTrading = !DevEffNoGagTrading
		SetToggleOptionValue(DevEffNoGagTradingOID, DevEffNoGagTrading)
		GagTrade.ToggleActive()
		
	ElseIf (option == BondFurnEnableOID)
		BondFurnEnable = !BondFurnEnable
		SetToggleOptionValue(BondFurnEnableOID, BondFurnEnable)
		DoToggleBondFurn = true
		ForcePageReset()
	
	ElseIf (option == BikiniExpOID)
		If BikiniExpT
			If ShowMessage("Are you sure you want to toggle off Bikini Experience?\nAll bikini training experience will be lost!")
				BikiniExpT = !BikiniExpT
				DoToggleBikiniExp = true
			EndIf
		Else
			BikiniExpT = !BikiniExpT
			DoToggleBikiniExp = true
		EndIf
		SetToggleOptionValue(BikiniExpOID, BikiniExpT)
		ForcePageReset()
	ElseIf (option == BikiniExpReflexesOID)
		If _SLS_BikiniExpReflexes.GetValueInt() == 0
			_SLS_BikiniExpReflexes.SetValueInt(1)
		Else
			_SLS_BikiniExpReflexes.SetValueInt(0)
		EndIf
		SetToggleOptionValue(BikiniExpReflexesOID, _SLS_BikiniExpReflexes.GetValueInt() as Bool)
	ElseIf (option == BikiniBuildListOID_T)
		BuildBikiniLists()
	ElseIf (option == BikiniClearListOID_T)
		ClearBikiniLists()
	
	ElseIf Option == StorageUtil.GetIntValue(Self, "BikBreakEnable_OID")
		GlobalVariable Glob = Game.GetFormFromFile(0x108062, "SL Survival.esp") as GlobalVariable
		Glob.SetValueInt((!(Glob.GetValueInt() as Bool)) as Int)
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "BikBreakEnable_OID"), Glob.GetValueInt() as Bool)
	ElseIf Option == StorageUtil.GetIntValue(Self, "BikBreakCompatibilityMode_OID")
		(Game.GetFormFromFile(0x10D7AF, "SL Survival.esp") as _SLS_BikiniBreak).CompatibilityMode = !(Game.GetFormFromFile(0x10D7AF, "SL Survival.esp") as _SLS_BikiniBreak).CompatibilityMode
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "BikBreakCompatibilityMode_OID"), (Game.GetFormFromFile(0x10D7AF, "SL Survival.esp") as _SLS_BikiniBreak).CompatibilityMode)
	ElseIf Option == StorageUtil.GetIntValue(Self, "BikBreakBuild_OID")
		SetTextOptionValue(StorageUtil.GetIntValue(Self, "BikBreakBuild_OID"), "Working... ")
		BuildBikiniBreakdowns()
		If IsInMcm
			SetTextOptionValue(StorageUtil.GetIntValue(Self, "BikBreakBuild_OID"), "Complete! ")
		EndIf
		
	ElseIf Option == StorageUtil.GetIntValue(Self, "BikBreakEnable_OID")
		GlobalVariable Glob = Game.GetFormFromFile(0x108062, "SL Survival.esp") as GlobalVariable
		Glob.SetValueInt((!(Glob.GetValueInt() as Bool)) as Int)
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "BikBreakEnable_OID"), Glob.GetValueInt() as Bool)
	ElseIf Option == StorageUtil.GetIntValue(Self, "BikBreakTawoba_OID")
		GlobalVariable Glob = Game.GetFormFromFile(0x10A737, "SL Survival.esp") as GlobalVariable
		Glob.SetValueInt((!(Glob.GetValueInt() as Bool)) as Int)
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "BikBreakTawoba_OID"), Glob.GetValueInt() as Bool)

	ElseIf Option == StorageUtil.GetIntValue(Self, "SetInnPricesOID")
		LocTrack.SetInnPrices = !LocTrack.SetInnPrices
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "SetInnPricesOID"), LocTrack.SetInnPrices)
		If LocTrack.SetInnPrices
			LocTrack.SetInnCostByString(LocTrack.PlayerCurrentLocString)
		EndIf
	
	ElseIf option == StorageUtil.GetIntValue(Self, "IntRndOID")
		RestartInterfacePrompt("RealisticNeedsandDiseases.esp")
	ElseIf option == StorageUtil.GetIntValue(Self, "IntIneedOID")
		RestartInterfacePrompt("iNeed.esp")
	ElseIf option == StorageUtil.GetIntValue(Self, "IntESDOID")
		RestartInterfacePrompt("EatingSleepingDrinking.esp")
	ElseIf option == StorageUtil.GetIntValue(Self, "IntFrostfallOID")
		RestartInterfacePrompt("Frostfall.esp")
	ElseIf option == StorageUtil.GetIntValue(Self, "IntSlaverunOID")
		RestartInterfacePrompt("Slaverun_Reloaded.esp")
	ElseIf option == StorageUtil.GetIntValue(Self, "IntPscOID")
		RestartInterfacePrompt("SexLab_PaySexCrime.esp")
	ElseIf option == StorageUtil.GetIntValue(Self, "IntDdsOID")
		RestartInterfacePrompt("Devious Devices - Expansion.esm")
	ElseIf option == StorageUtil.GetIntValue(Self, "IntDfOID")
		RestartInterfacePrompt("DeviousFollowers.esp")
	ElseIf option == StorageUtil.GetIntValue(Self, "IntEffOID")
		RestartInterfacePrompt("EFFCore.esm")
	ElseIf option == StorageUtil.GetIntValue(Self, "IntSgoOID")
		RestartInterfacePrompt("dcc-soulgem-oven-000.esm")
	ElseIf option == StorageUtil.GetIntValue(Self, "IntFhuOID")
		RestartInterfacePrompt("sr_FillHerUp.esp")
	ElseIf option == StorageUtil.GetIntValue(Self, "IntAmpOID")
		RestartInterfacePrompt("Amputator.esm")
	ElseIf option == StorageUtil.GetIntValue(Self, "IntAproposTwoOID")
		RestartInterfacePrompt("Apropos2.esp")
	ElseIf option == StorageUtil.GetIntValue(Self, "IntTatsOID")
		RestartInterfacePrompt("SlaveTats.esp")
	ElseIf option == StorageUtil.GetIntValue(Self, "IntMaOID")
		RestartInterfacePrompt("Milk Addict.esp")
	ElseIf option == StorageUtil.GetIntValue(Self, "IntSlaxOID")
		RestartInterfacePrompt("SexLabAroused.esm")
	ElseIf option == StorageUtil.GetIntValue(Self, "IntSlsfOID")
		RestartInterfacePrompt("SexLab - Sexual Fame [SLSF].esm")
	ElseIf option == StorageUtil.GetIntValue(Self, "IntSlsoOID")
		RestartInterfacePrompt("Slso.esp")
	ElseIf option == StorageUtil.GetIntValue(Self, "IntStaOID")
		RestartInterfacePrompt("Spank That Ass.esp")
	ElseIf option == StorageUtil.GetIntValue(Self, "IntBisOID")
		RestartInterfacePrompt("Bathing in Skyrim - Main.esp")
	ElseIf option == StorageUtil.GetIntValue(Self, "IntSexyMoveOID")
		RestartInterfacePrompt("FNISSexyMove.esp")
		
	; Stats
	ElseIf (option == TollDodgedWhiterunOID_T)
		TollDodge.DodgedTollWhiterun = !TollDodge.DodgedTollWhiterun
		ForcePageReset()
	ElseIf (option == TollDodgedSolitudeOID_T)
		TollDodge.DodgedTollSolitude = !TollDodge.DodgedTollSolitude
		ForcePageReset()
	ElseIf (option == TollDodgedMarkarthOID_T)
		TollDodge.DodgedTollMarkarth = !TollDodge.DodgedTollMarkarth
		ForcePageReset()
	ElseIf (option == TollDodgedWindhelmOID_T)
		TollDodge.DodgedTollWindhelm = !TollDodge.DodgedTollWindhelm
		ForcePageReset()
	ElseIf (option == TollDodgedRiftenOID_T)
		TollDodge.DodgedTollRiften = !TollDodge.DodgedTollRiften
		ForcePageReset()
	EndIf
endEvent

event OnOptionDefault(int option)
	If(option == SlaverunAutoStartOID)
		SlaverunAutoStart = false
		SetToggleOptionValue(SlaverunAutoStartOID, SlaverunAutoStart)
	ElseIf(option == CoverMyselfMechanicsOID)
		CoverMyselfMechanics = true
		SetToggleOptionValue(CoverMyselfMechanicsOID, CoverMyselfMechanics)
		DoToggleCoverMechanics = true
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "NpcCommentsOID")
		(Game.GetFormFromFile(0x0DF88F, "SL Survival.esp") as GlobalVariable).SetValueInt(1)
		SetToggleOptionValue(Option, true)
		StorageUtil.SetIntValue(Self, "DoToggleNpcComments", 1)
	ElseIf(option == AssSlappingOID)
		AssSlappingEvents = true
		SetToggleOptionValue(AssSlappingOID, AssSlappingEvents)
		ToggleAssSlapping()
	ElseIf(option == ProxSpankCommentOID)
		Util.ProxSpankComment = false
		SetToggleOptionValue(ProxSpankCommentOID, Util.ProxSpankComment)	
	ElseIf(option == EasyBedTrapsOID)
		EasyBedTraps = true
		SetToggleOptionValue(EasyBedTrapsOID, EasyBedTraps)
	ElseIf(option == CumBreathOID)
		CumBreath = true
		SetToggleOptionValue(CumBreathOID, CumBreath)
	ElseIf(option == CumBreathNotifyOID)
		CumBreathNotify = true
		SetToggleOptionValue(CumBreathNotifyOID, CumBreathNotify)
	ElseIf(option == DebugModeOID)
		Init.DebugMode = false
		SetToggleOptionValue(DebugModeOID, Init.DebugMode)
		ToggleDebugMode()
	ElseIf(option == MinAvToggleOID)
		MinAvToggleT = true
		SetToggleOptionValue(MinAvToggleOID, MinAvToggleT)
		ToggleMinAV()
	ElseIf(option == HalfNakedEnableOID)
		HalfNakedEnable = false
		SetToggleOptionValue(HalfNakedEnableOID, HalfNakedEnable)
		DoToggleHalfNakedCover = true
		ForcePageReset()
	ElseIf(option == HalfNakedStripsOID)
		HalfNakedStrips = false
		SetToggleOptionValue(HalfNakedStripsOID, HalfNakedStrips)
		ForcePageReset()
		ToggleHalfNakedStrips()
	ElseIf(option == PpLootEnableOID)
		PpLootEnable = true
		SetToggleOptionValue(PpLootEnableOID, PpLootEnable)
		TogglePpLoot()
	ElseIf Option == StorageUtil.GetIntValue(Self, "AmpBlockMagicOID")
		Amputation.BlockMagic = true
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "AmpBlockMagicOID"), Amputation.BlockMagic)	
	ElseIf(option == DismemberTrollCumOID)
		DismemberTrollCum = true
		SetToggleOptionValue(DismemberTrollCumOID, DismemberTrollCum)
	ElseIf(option == DismemberBathingOID)
		DismemberBathing = true
		SetToggleOptionValue(DismemberBathingOID, DismemberBathing)
	ElseIf(option == StorageUtil.GetIntValue(Self, "DismemberCombatStopOID"))
		StorageUtil.SetIntValue(Self, "DismemberCombatStop", 1)
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "DismemberCombatStopOID"), StorageUtil.GetIntValue(Self, "DismemberCombatStop"))
	ElseIf(option == DismemberPlayerSayOID)
		DismemberPlayerSay = true
		SetToggleOptionValue(DismemberPlayerSayOID, DismemberPlayerSay)
		
		
	ElseIf(option == CumSwallowInflateOID)
		CumSwallowInflate = true
		SetToggleOptionValue(CumSwallowInflateOID, CumSwallowInflate)
		ForcePageReset()
	ElseIf(option == CumEffectsEnableOID)
		CumEffectsEnable = true
		SetToggleOptionValue(CumEffectsEnableOID, CumEffectsEnable)
		DoToggleCumEffects = true
		ForcePageReset()
	ElseIf(option == CumEffectsStackOID)
		CumEffectsStack = true
		SetToggleOptionValue(CumEffectsStackOID, CumEffectsStack)
	ElseIf(option == SuccubusCumSwallowEnergyPerRankOID)
		SuccubusCumSwallowEnergyPerRank = true
		SetToggleOptionValue(SuccubusCumSwallowEnergyPerRankOID, SuccubusCumSwallowEnergyPerRank)
	ElseIf(option == CumAddictClampHungerOID)
		CumAddictClampHunger = true
		SetToggleOptionValue(CumAddictClampHungerOID, CumAddictClampHunger)
		CumAddict.DoUpdate()
	ElseIf(option == CumAddictBeastLevelsOID)
		CumAddictBeastLevels = false
		SetToggleOptionValue(CumAddictBeastLevelsOID, CumAddictBeastLevels)
		CumAddict.LoadNewHungerThresholds()
		CumAddict.DoUpdate()
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "CumAddictBlockDecayOID")
		CumAddict.CumBlocksAddictionDecay = true
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "CumAddictBlockDecayOID"), CumAddict.CumBlocksAddictionDecay)
	ElseIf Option == StorageUtil.GetIntValue(Self, "CumAddictDayDreamOID")
		StorageUtil.SetIntValue(Self, "CumAddictDayDream", 1)
		StorageUtil.SetIntValue(Self, "DoToggleDaydream", 1)
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "CumAddictDayDreamOID"), true)
	ElseIf Option == StorageUtil.GetIntValue(Self, "CumAddictDayDreamButterflysOID")
		StorageUtil.SetIntValue(Self, "CumAddictDayDreamButterflys", 1)
		StorageUtil.SetIntValue(Self, "DoToggleDaydreamButterflys", 1)
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "CumAddictDayDreamButterflysOID"), true)
	ElseIf Option == StorageUtil.GetIntValue(Self, "CumAddictAutoSuckVictim")
		CumAddict.AutoSuckVictim = true
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "CumAddictAutoSuckVictim"), CumAddict.AutoSuckVictim)
		
	ElseIf(option == MilkDecCumBreathOID)
		MilkDecCumBreath = false
		SetToggleOptionValue(MilkDecCumBreathOID, MilkDecCumBreath)
	ElseIf(option == PpSleepNpcPerkOID)
		PpSleepNpcPerk = true
		SetToggleOptionValue(PpSleepNpcPerkOID, PpSleepNpcPerk)
		TogglePpSleepNpcPerk()
	ElseIf(option == PpFailHandleOID)
		PpFailHandle = true
		SetToggleOptionValue(PpFailHandleOID, PpFailHandle)
		DoTogglePpFailHandle = true		
	ElseIf(option == NormalKnockDialogOID)
		Init.SKdialog = true
		SetToggleOptionValue(NormalKnockDialogOID, Init.SKdialog)
	
	ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaPlayerSqueaksOID")
		Trauma.PlayerSqueaks = true
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "TraumaPlayerSqueaksOID"), Trauma.PlayerSqueaks)
	
	ElseIf(option == SleepDeprivOID)
		SleepDepriv = false
		SetToggleOptionValue(SleepDeprivOID, SleepDepriv)
		ToggleSleepDepriv()
	ElseIf(option == SaltyCumOID)
		SaltyCum = false
		SetToggleOptionValue(SaltyCumOID, SaltyCum)
		SetSaltyCum(SaltyCum)
	ElseIf(option == BellyScaleEnableOID)
		BellyScaleEnable = false
		SetToggleOptionValue(BellyScaleEnableOID, BellyScaleEnable)
		DoToggleBellyInflation = true
		ForcePageReset()
	ElseIf(option == SlsCreatureEventOID)
		Init.SlsCreatureEvents = false
		SetToggleOptionValue(SlsCreatureEventOID, Init.SlsCreatureEvents)
		PlayerRef.RemovePerk(_SLS_CreatureTalk)
		ForcePageReset()
	ElseIf(option == AnimalBreedEnableOID)
		AnimalBreedEnable = true
		SetToggleOptionValue(AnimalBreedEnableOID, AnimalBreedEnable)
		DoToggleAnimalBreeding = true
		ForcePageReset()

	ElseIf(option == DoorLockDownOID)
		DoorLockDownT = true
		ToggleTollGateLocks()
		SetToggleOptionValue(DoorLockDownOID, DoorLockDownT)
	ElseIf(option == DropItemsOID)
		DropItems = true
		SetToggleOptionValue(DropItemsOID, DropItems)
	ElseIf(option == FastTravelDisableOID)
		FastTravelDisable = true
		SetToggleOptionValue(FastTravelDisableOID, FastTravelDisable)
	ElseIf(option == FtDisableIsNormalOID)
		FtDisableIsNormal = true
		SetToggleOptionValue(FtDisableIsNormalOID, FtDisableIsNormal)
	ElseIf(option == CompassMechanicsOID)
		CompassMechanics = true
		SetToggleOptionValue(CompassMechanicsOID, CompassMechanics)
		ToggleCompassMechanics()
	ElseIf(option == ReplaceMapsOID)
		ReplaceMaps = true
		SetToggleOptionValue(ReplaceMapsOID, ReplaceMaps)
		ReplaceVanillaMaps(ReplaceMaps)
	ElseIf(option == ConstructableMapAndCompassOID)
		_SLS_MapAndCompassRecipeEnable.SetValueInt(1)
		SetToggleOptionValue(ConstructableMapAndCompassOID, _SLS_MapAndCompassRecipeEnable.GetValueInt())
	ElseIf(option == GoldPerLevelOID)
		TollUtil.TollCostPerLevel = false
		SetToggleOptionValue(GoldPerLevelOID, TollUtil.TollCostPerLevel)
	ElseIf(option == TollDodgingOID)
		TollDodging = false
		SetToggleOptionValue(TollDodgingOID, TollDodging)
		DoTollDodgingToggle = true
		ForcePageReset()
	ElseIf(option == TollDodgeGiftMenuOID)
		Init.TollDodgeGiftMenu = true
		SetToggleOptionValue(TollDodgeGiftMenuOID, Init.TollDodgeGiftMenu)
	ElseIf(option == LicencesEnableOID)
		Init.LicencesEnable = true
		SetToggleOptionValue(LicencesEnableOID, Init.LicencesEnable)
		ToggleLicences(Init.LicencesEnable)
	ElseIf(option == BikiniLicFirstOID)
		LicUtil.AlwaysAwardBikiniLicFirst = true
		SetToggleOptionValue(BikiniLicFirstOID, LicUtil.AlwaysAwardBikiniLicFirst)
	ElseIf(option == LicBuyBackOID)
		LicUtil.BuyBack = false
		SetToggleOptionValue(LicBuyBackOID, LicUtil.BuyBack)
	ElseIf(option == LicBountyMustBePaidOID)
		LicUtil.BountyMustBePaid = true
		SetToggleOptionValue(LicBountyMustBePaidOID, LicUtil.BountyMustBePaid)
	ElseIf Option == StorageUtil.GetIntValue(Self, "LicCheckFollowers")
		LicUtil.CheckFollowers = true
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "LicCheckFollowers"), LicUtil.CheckFollowers)
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "LicForceCheckDeviousFollower")
		LicUtil.ForceCheckDF = true
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "LicForceCheckDeviousFollower"), LicUtil.ForceCheckDF)
	ElseIf(option == FolContraBlockOID)
		FolContraBlock = true
		SetToggleOptionValue(FolContraBlockOID, FolContraBlock)
		ToggleFolContraBlock()
	ElseIf(option == FolContraKeysOID)
		LicUtil.FollowerWontCarryKeys = true
		SetToggleOptionValue(FolContraKeysOID, LicUtil.FollowerWontCarryKeys)
	ElseIf(option == FolTakeClothesOID)
		LicUtil.FolTakeClothes = true
		SetToggleOptionValue(FolTakeClothesOID, LicUtil.FolTakeClothes)	
	ElseIf(option == OrdinSupressOID)
		LicUtil.OrdinSupress = false
		SetToggleOptionValue(OrdinSupressOID, LicUtil.OrdinSupress)
		LicUtil.ToggleOrdinSuppression()
	ElseIf(option == CurseTatsOID)
		LicUtil.CurseTats = true
		SetToggleOptionValue(CurseTatsOID, LicUtil.CurseTats)
		ToggleCurseTats()
		ForcePageReset()
	ElseIf(option == ResponsiveEnforcersOID)
		_SLS_ResponsiveEnforcers.SetValueInt(0)
		SetToggleOptionValue(ResponsiveEnforcersOID, false)
		ForcePageReset()
	ElseIf(option == RestrictTradeOID)
		TradeRestrictions = true
		SetToggleOptionValue(RestrictTradeOID, TradeRestrictions)
		ToggleTradeRestrictions()
	ElseIf(option == LicBikiniCurseEnableOID)
		LicUtil.BikiniCurseEnable = true
		ToggleBikiniCurse()
		SetToggleOptionValue(LicBikiniCurseEnableOID, LicUtil.BikiniCurseEnable)
	ElseIf(option == LicBikiniHeelsOID)
		BikiniCurse.HeelsRequired = true
		SetToggleOptionValue(LicBikiniHeelsOID, BikiniCurse.HeelsRequired)
		DoToggleHeelsRequired = true
	ElseIf(option == LicBikiniEnableOID)
		LicUtil.LicBikiniEnable = true
		LicenceToggleToggled()
		SetToggleOptionValue(LicBikiniEnableOID, LicUtil.LicBikiniEnable)
		ForcePageReset()
	ElseIf(option == LicMagicEnableOID)
		LicUtil.LicMagicEnable = true
		LicenceToggleToggled()
		SetToggleOptionValue(LicMagicEnableOID, LicUtil.LicMagicEnable)
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "CurfewLicenceEnableOID")
		LicUtil.LicCurfewEnable = true
		StorageUtil.SetIntValue(Self, "DoToggleCurfew", 1)
		LicenceToggleToggled()
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "CurfewLicenceEnableOID"), LicUtil.LicCurfewEnable)
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "LicCurfewNotificationsOID")
		(Game.GetFormFromFile(0x0E3F3D, "SL Survival.esp") as _SLS_Curfew).DoCurfewNotification = true
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "LicCurfewNotificationsOID"), true)
	ElseIf Option == StorageUtil.GetIntValue(Self, "WhoreLicenceEnableOID")
		LicUtil.LicWhoreEnable = true
		LicenceToggleToggled()
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "WhoreLicenceEnableOID"), LicUtil.LicWhoreEnable)
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "PropertyLicenceEnableOID")
		LicUtil.LicPropertyEnable = true
		Eviction.UpdateEvictions(DoImmediately = true)
		LicenceToggleToggled()
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "PropertyLicenceEnableOID"), LicUtil.LicPropertyEnable)
		ForcePageReset()

	ElseIf(option == LicMagicCursedDevicesOID)
		LicUtil.LicMagicCursedDevices = true
		SetToggleOptionValue(LicMagicCursedDevicesOID, LicUtil.LicMagicCursedDevices)
		PlayerRef.RemoveSpell(_SLS_MagicLicenceCurse)
	ElseIf(option == LicMagicChainCollarsOID)
		LicMagicChainCollars = false
		SetToggleOptionValue(LicMagicChainCollarsOID, LicMagicChainCollars)
		AddRemoveChainCollars(LicMagicChainCollars)
	ElseIf(option == StashTrackEnOID)
		StashTrackEn = true
		SetToggleOptionValue(StashTrackEnOID, StashTrackEn)
		DoToggleStashTracking = true
		ForcePageReset()	
	ElseIf(option == ContTypeCountsOID)
		ContTypeCountsT = true
		SetToggleOptionValue(ContTypeCountsOID, ContTypeCountsT)
	ElseIf(option == OrgasmRequiredOID)
		OrgasmRequired = true
		SetToggleOptionValue(OrgasmRequiredOID, OrgasmRequired)
	ElseIf Option == StorageUtil.GetIntValue(Self, "JigglesOID")
		StorageUtil.SetIntValue(Self, "$SLS_hJiggles", 1)
		StorageUtil.SetIntValue(Self, "DoToggleJiggles", 1)
		SetToggleOptionValue(Option, true)
	ElseIf(option == BeggingTOID)
		_SLS_BeggingDialogT.SetValueInt(1)
		SetToggleOptionValue(BeggingTOID, _SLS_BeggingDialogT.GetValueInt() as Bool)
		ForcePageReset()
	ElseIf(option == BegSelfDegEnableOID)
		_SLS_BegSelfDegradationEnable.SetValueInt(1)
		SetToggleOptionValue(BegSelfDegEnableOID, _SLS_BegSelfDegradationEnable.GetValueInt() as Bool)
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "KennelSuitsOID")
		StorageUtil.SetIntValue(Self, "KennelSuits", 0)
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "KennelSuitsOID"), StorageUtil.GetIntValue(Self, "KennelSuits", Missing = 0))
	ElseIf(option == KennelExtraDevicesOID)
		_SLS_KennelExtraDevices.SetValueInt(1)
		SetToggleOptionValue(KennelExtraDevicesOID, _SLS_KennelExtraDevices.GetValueInt() as Bool)
		ForcePageReset()
		
	ElseIf(option == GuardCommentsOID)
		GuardComments = true
		SetToggleOptionValue(GuardCommentsOID, GuardComments)
		DoToggleGuardComments = true
	ElseIf(option == GuardBehavWeapDropOID)
		_SLS_GuardBehavWeapDropEn.SetValueInt(1)
		SetToggleOptionValue(GuardBehavWeapDropOID, DeviousEffectsEnable)
		ForcePageReset()
	ElseIf(option == GuardBehavShoutOID)
		_SLS_GuardBehavShoutEn.SetValueInt(1)
		SetToggleOptionValue(GuardBehavShoutOID, DeviousEffectsEnable)
		ForcePageReset()
	ElseIf(option == GuardBehavWeapDrawnOID)
		GuardBehavWeapDrawn = true
		SetToggleOptionValue(GuardBehavWeapDrawnOID, GuardBehavWeapDrawn)
		DoToggleGuardBehavWeapDrawn = true
	ElseIf(option == GuardBehavWeapEquipOID)
		GuardBehavWeapEquip = true
		DoToggleGuardBehavWeapEquip = true
		SetToggleOptionValue(GuardBehavWeapEquipOID, GuardBehavWeapEquip)
	ElseIf(option == GuardBehavArmorEquipOID)
		GuardBehavArmorEquip = false
		_SLS_GuardWarnArmorEquippedQuest.Stop()
		SetToggleOptionValue(GuardBehavArmorEquipOID, GuardBehavArmorEquip)
	ElseIf option == StorageUtil.GetIntValue(Self, "GuardBehavArmorEquipAnyArmorOID")
		StorageUtil.SetIntValue(Self, "GuardBehavArmorEquipAnyArmor", 0)
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "GuardBehavArmorEquipAnyArmorOID"), StorageUtil.GetIntValue(Self, "GuardBehavArmorEquipAnyArmor", Missing = 0))
	ElseIf(option == GuardBehavLockpickingOID)
		GuardBehavLockpicking = true
		SetToggleOptionValue(GuardBehavLockpickingOID, GuardBehavLockpicking)
		DoToggleGuardBehavLockpick = true
	ElseIf(option == GuardBehavDrugsOID)
		GuardBehavDrugs = true
		SetToggleOptionValue(GuardBehavDrugsOID, GuardBehavDrugs)
		DoToggleGuardBehavDrugs = true
		
	ElseIf(option == DeviousEffectsEnableOID)
		DeviousEffectsEnable = true
		SetToggleOptionValue(DeviousEffectsEnableOID, DeviousEffectsEnable)
		DoDeviousEffectsChange = true
		ForcePageReset()
	ElseIf Option == StorageUtil.GetIntValue(Self, "DeviousDrowningOID")
		DeviousEffects.DeviousDrowning = true
		DeviousEffects.ToggleDeviousDrowning()
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "DeviousDrowningOID"), DeviousEffects.DeviousDrowning)
	ElseIf(option == DevEffNoGagTradingOID)
		DevEffNoGagTrading = false
		SetToggleOptionValue(DevEffNoGagTradingOID, DevEffNoGagTrading)
		GagTrade.ToggleActive()
	ElseIf(option == BondFurnEnableOID)
		BondFurnEnable = true
		SetToggleOptionValue(BondFurnEnableOID, BondFurnEnable)
		DoToggleBondFurn = true
		ForcePageReset()
	ElseIf(option == BikiniExpReflexesOID)
		_SLS_BikiniExpReflexes.SetValueInt(1)
		SetToggleOptionValue(BikiniExpReflexesOID, _SLS_BikiniExpReflexes.GetValueInt() as Bool)
	
	ElseIf Option == StorageUtil.GetIntValue(Self, "BikBreakEnable_OID")
		(Game.GetFormFromFile(0x108062, "SL Survival.esp") as GlobalVariable).SetValueInt(1)
	ElseIf Option == StorageUtil.GetIntValue(Self, "BikBreakCompatibilityMode_OID")
		(Game.GetFormFromFile(0x10D7AF, "SL Survival.esp") as _SLS_BikiniBreak).CompatibilityMode = true
	ElseIf Option == StorageUtil.GetIntValue(Self, "BikBreakTawoba_OID")
		(Game.GetFormFromFile(0x10A737, "SL Survival.esp") as GlobalVariable).SetValueInt(0)

	ElseIf Option == StorageUtil.GetIntValue(Self, "SetInnPricesOID")
		LocTrack.SetInnPrices = false
		SetToggleOptionValue(StorageUtil.GetIntValue(Self, "SetInnPricesOID"), LocTrack.SetInnPrices)
	EndIf
endEvent

Function SetSliderOptions(Float Value, Float Default, Float Min, Float Max, Float Interval)
	SetSliderDialogStartValue(Value)
	SetSliderDialogDefaultValue(Default)
	SetSliderDialogRange(Min, Max)
	SetSliderDialogInterval(Interval)
EndFunction

Event OnOptionSliderOpen(int option)
	If StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pSettings" ; <----------------->
		If Option == BarefootMagOIS_S
			SetSliderOptions(Value = BarefootMag, Default = 50.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		ElseIf option == StorageUtil.GetIntValue(Self, "BarefootStaggerChanceOID_S")
			SetSliderOptions(Value = StorageUtil.GetFloatValue(Self, "BarefootStaggerChance", Missing = 10.0), Default = 10.0, Min = 0.0, Max = 100.0, Interval = 0.5)
		ElseIf (option == HorseCostOIS_S)
			SetSliderOptions(Value = SurvivalHorseCost, Default = 6000.0, Min = 1000.0, Max = 50000.0, Interval = 1000.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "GrowthWeightGainOID_S")
			SetSliderOptions(Value = StorageUtil.GetFloatValue(Self, "WeightGainPerDay", Missing = 0.0), Default = 0.1, Min = 0.0, Max = 10.0, Interval = 0.01)
		ElseIf (option == MinSpeedOID_S)
			SetSliderOptions(Value = MinSpeedMult, Default = 50.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		ElseIf (option == MinCarryWeightOID_S)
			SetSliderOptions(Value = MinCarryWeight, Default = 50.0, Min = 0.0, Max = 500.0, Interval = 10.0)
		ElseIf (option == ReplaceMapsTimerOID_S)
			SetSliderOptions(Value = ReplaceMapsTimer, Default = 180.0, Min = 10.0, Max = 600.0, Interval = 10.0)
		ElseIf (option == GoldWeightOID_S)
			SetSliderOptions(Value = GoldWeight, Default = 0.01, Min = 0.0, Max = 0.1, Interval = 0.001)
		ElseIf (option == FolGoldStealChanceOID_S)
			SetSliderOptions(Value = FolGoldStealChance, Default = 50.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		ElseIf (option == FolGoldSteamAmountOID_S)
			SetSliderOptions(Value = FolGoldSteamAmount, Default = 30.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		ElseIf (option == SlaverunAutoMinOID_S)
			SetSliderOptions(Value = SlaverunAutoMin, Default = 2.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		ElseIf (option == SlaverunAutoMaxOID_S)
			SetSliderOptions(Value = SlaverunAutoMax, Default = 14.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "HomeCostWhiterunOID_S")
			SetSliderOptions(Value = (Game.GetFormFromFile(0xF728B, "Skyrim.esm") as GlobalVariable).GetValueInt(), Default = 5000.0, Min = 0.0, Max = 100000.0, Interval = 1000.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "HomeCostSolitudeOID_S")
			SetSliderOptions(Value = (Game.GetFormFromFile(0xF728C, "Skyrim.esm") as GlobalVariable).GetValueInt(), Default = 25000.0, Min = 0.0, Max = 100000.0, Interval = 1000.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "HomeCostMarkarthOID_S")
			SetSliderOptions(Value = (Game.GetFormFromFile(0xF728E, "Skyrim.esm") as GlobalVariable).GetValueInt(), Default = 8000.0, Min = 0.0, Max = 100000.0, Interval = 1000.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "HomeCostWindhelmOID_S")
			SetSliderOptions(Value = (Game.GetFormFromFile(0xF728A, "Skyrim.esm") as GlobalVariable).GetValueInt(), Default = 12000.0, Min = 0.0, Max = 100000.0, Interval = 1000.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "HomeCostRiftenOID_S")
			SetSliderOptions(Value = (Game.GetFormFromFile(0xF728D, "Skyrim.esm") as GlobalVariable).GetValueInt(), Default = 8000.0, Min = 0.0, Max = 100000.0, Interval = 1000.0)
		ElseIf (option == DflowResistLossOID_S)
			SetSliderOptions(Value = DflowResistLoss, Default = 5.0, Min = 0.0, Max = 20.0, Interval = 0.1)
		ElseIf (option == DeviousGagDebuffOID_S)
			SetSliderOptions(Value = DeviousGagDebuff, Default = 80.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		ElseIf (option == BondFurnMilkFreqOID_S)
			SetSliderOptions(Value = BondFurnMilkFreq, Default = 6.0, Min = -1.0, Max = 30.0, Interval = 0.5)
		ElseIf (option == BondFurnMilkFatigueMultOID_S)
			SetSliderOptions(Value = BondFurnMilkFatigueMult, Default = 1.0, Min = 0.0, Max = 10.0, Interval = 0.1)
		ElseIf (option == BondFurnMilkWillOID_S)
			SetSliderOptions(Value = BondFurnMilkWill, Default = 4.0, Min = -1.0, Max = 10.0, Interval = 1.0)
		ElseIf (option == BondFurnFreqOID_S)
			SetSliderOptions(Value = BondFurnFreq, Default = 3.0, Min = -1.0, Max = 30.0, Interval = 0.5)
		ElseIf (option == BondFurnFatigueMultOID_S)
			SetSliderOptions(Value = BondFurnFatigueMult, Default = 1.0, Min = 0.0, Max = 10.0, Interval = 0.1)
		ElseIf (option == BondFurnWillOID_S)
			SetSliderOptions(Value = BondFurnWill, Default = 2.0, Min = -1.0, Max = 10.0, Interval = 1.0)
		ElseIf (option == HalfNakedBraOID_S)
			SetSliderOptions(Value = HalfNakedBra, Default = 26.0, Min = 30.0, Max = 61.0, Interval = 1.0)
		ElseIf (option == HalfNakedPantyOID_S)
			SetSliderOptions(Value = HalfNakedPanty, Default = 49.0, Min = 30.0, Max = 61.0, Interval = 1.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "SlifBreastScaleMaxOID_S")
			SetSliderOptions(Value = Main.Slif.ScaleMaxBreasts, Default = 3.3, Min = 0.0, Max = 10.0, Interval = 0.1)
		ElseIf Option == StorageUtil.GetIntValue(Self, "SlifBellyScaleMaxOID_S")
			SetSliderOptions(Value = Main.Slif.ScaleMaxBelly, Default = 5.5, Min = 0.0, Max = 10.0, Interval = 0.1)
		ElseIf Option == StorageUtil.GetIntValue(Self, "SlifAssScaleMaxOID_S")
			SetSliderOptions(Value = Main.Slif.ScaleMaxAss, Default = 2.3, Min = 0.0, Max = 10.0, Interval = 0.1)
		EndIf
		
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pSexEffects" ; <----------------->
		If (option == SexExpCorruptionCurrentOID_S)
			SetSliderOptions(Value = StorageUtil.GetFloatValue(None, "_SLS_CreatureCorruption", Missing = 0.0), Default = 0.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		ElseIf (option == CockSizeBonusEnjFreqOID_S)
			SetSliderOptions(Value = CockSizeBonusEnjFreq, Default = 3.0, Min = 0.0, Max = 30.0, Interval = 0.5)
		ElseIf (option == RapeForcedSkoomaChanceOID_S)
			SetSliderOptions(Value = RapeForcedSkoomaChance, Default = 35.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		ElseIf (option == RapeMinArousalOID_S)
			SetSliderOptions(Value = RapeMinArousal, Default = 50.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "CompulsiveSexFuckTimeOID_S")
			SetSliderOptions(Value = (Game.GetFormFromFile(0x0E7553, "SL Survival.esp") as _SLS_CompulsiveSex).TimeBetweenFucks, Default = 1.0, Min = 0.0, Max = 10.0, Interval = 0.1)
		ElseIf Option == StorageUtil.GetIntValue(Self, "OrgasmFatigueThresholdOID_S")
			SetSliderOptions(Value = (Game.GetFormFromFile(0x0E857D, "SL Survival.esp") as _SLS_OrgasmFatigue).OrgasmThreshold, Default = 3.0, Min = 1.0, Max = 10.0, Interval = 1.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "OrgasmFatigueRecoveryOID_S")
			SetSliderOptions(Value = (Game.GetFormFromFile(0x0E857D, "SL Survival.esp") as _SLS_OrgasmFatigue).OrgasmRecoveryPerHour, Default = 0.8, Min = 0.0, Max = 2.0, Interval = 0.1)
		ElseIf Option == StorageUtil.GetIntValue(Self, "AhegaoDurPerOrgasmOID_S")
			SetSliderOptions(Value = (Game.GetFormFromFile(0x0FCE71, "SL Survival.esp") as _SLS_Ahegao).DurPerOrgasm, Default = 6.0, Min = 0.0, Max = 20.0, Interval = 0.5)
		ElseIf (option == SexMinStaminaRateOID_S)
			SetSliderOptions(Value = SexMinStaminaRate, Default = 2.5, Min = 0.0, Max = 10.0, Interval = 0.1)
		ElseIf (option == SexMinStaminaMultOID_S)
			SetSliderOptions(Value = SexMinStaminaMult, Default = 60.0, Min = 0.0, Max = 200.0, Interval = 10.0)
		ElseIf (option == SexMinMagickaRateOID_S)
			SetSliderOptions(Value = SexMinMagickaRate, Default = 1.5, Min = 0.0, Max = 10.0, Interval = 0.1)
		ElseIf (option == SexMinMagickaMultOID_S)
			SetSliderOptions(Value = SexMinMagickaMult, Default = 50.0, Min = 0.0, Max = 200.0, Interval = 10.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "WildlingPointsLossRate")
			SetSliderOptions(Value = AnimalFriend.Wildling.WildlingPointsLossPerRank, Default = 2.5, Min = 0.0, Max = 10.0, Interval = 0.1)
		ElseIf Option == StorageUtil.GetIntValue(Self, "AllurePerLevel")
			SetSliderOptions(Value = AnimalFriend.Wildling.AllurePointsPerLevel, Default = 2.0, Min = 1.0, Max = 10.0, Interval = 0.1)
		ElseIf (option == AfCooloffBaseOID_S)
			SetSliderOptions(Value = AnimalFriend.BreedingCooloffBase, Default = 3.0, Min = 0.0, Max = 168.0, Interval = 0.5)
		ElseIf (option == AfCooloffBodyCumOID_S)
			SetSliderOptions(Value = AnimalFriend.BreedingCooloffCumCovered, Default = 6.0, Min = 0.0, Max = 168.0, Interval = 0.5)
		ElseIf (option == AfCooloffCumInflationOID_S)
			SetSliderOptions(Value = AnimalFriend.BreedingCooloffCumFilled, Default = 12.0, Min = 0.0, Max = 168.0, Interval = 0.5)
		ElseIf (option == AfCooloffPregnancyOID_S)
			SetSliderOptions(Value = AnimalFriend.BreedingCooloffPregnancy, Default = 12.0, Min = 0.0, Max = 168.0, Interval = 0.5)
		ElseIf (option == AfCooloffCumSwallowOID_S)
			SetSliderOptions(Value = AnimalFriend.SwallowBonus, Default = 12.0, Min = 0.0, Max = 168.0, Interval = 0.5)
		ElseIf Option == StorageUtil.GetIntValue(Self, "FashionRapeHairCutChanceOID_S")
			SetSliderOptions(Value = FashionRape.HaircutChance, Default = 5.0, Min = 0.0, Max = 100.0, Interval = 0.1)
		ElseIf Option == StorageUtil.GetIntValue(Self, "FashionRapeHairCutMinOID_S")
			SetSliderOptions(Value = FashionRape.HaircutMinLevel, Default = 1.0, Min = 0.0, Max = FashionRape.HaircutMaxLevel, Interval = 1.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "FashionRapeHairCutMaxOID_S")
			SetSliderOptions(Value = FashionRape.HaircutMaxLevel, Default = 3.0, Min = FashionRape.HaircutMinLevel, Max = 20.0, Interval = 1.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "FashionRapeHairCutFloorOID_S")
			SetSliderOptions(Value = FashionRape.HaircutFloor, Default = 4.0, Min = 0.0, Max = 20.0, Interval = 1.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "FashionRapeDyeHairChanceOID_S")
			SetSliderOptions(Value = FashionRape.DyeHairChance, Default = 2.0, Min = 0.0, Max = 100.0, Interval = 0.1)
		ElseIf Option == StorageUtil.GetIntValue(Self, "FashionRapeShavePussyChanceOID_S")
			SetSliderOptions(Value = FashionRape.ShavePussyChance, Default = 10.0, Min = 0.0, Max = 100.0, Interval = 0.1)
		ElseIf Option == StorageUtil.GetIntValue(Self, "FashionRapeLipstickChanceOID_S")
			SetSliderOptions(Value = FashionRape.SmudgeLipstickChance, Default = 20.0, Min = 0.0, Max = 100.0, Interval = 0.1)
		ElseIf Option == StorageUtil.GetIntValue(Self, "FashionRapeEyeshadowChanceOID_S")
			SetSliderOptions(Value = FashionRape.SmudgeEyeshadowChance, Default = 20.0, Min = 0.0, Max = 100.0, Interval = 0.1)
		EndIf
		
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pMisogynyInequality" ; <----------------->
		If Option == StorageUtil.GetIntValue(Self, "PushCooldownOID_S")
			SetSliderOptions(Value = (Game.GetFormFromFile(0x0E651A, "SL Survival.esp") as _SLS_PushPlayerCooloff).CooloffPeriod, Default = 1.0, Min = 0.0, Max = 24.0, Interval = 0.1)
		ElseIf (option == CatCallVolOIS_S)
			SetSliderOptions(Value = CatCallVol, Default = 20.0, Min = 0.0, Max = 100.0, Interval = 5.0)
		ElseIf (option == CatCallWillLossOIS_S)
			SetSliderOptions(Value = CatCallWillLoss, Default = 1.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		ElseIf (option == GreetDistOIS_S)
			SetSliderOptions(Value = GreetDist, Default = 150.0, Min = 0.0, Max = 500.0, Interval = 10.0)

		ElseIf (option == AssSlapResistLossOID_S)
			SetSliderOptions(Value = AssSlapResistLoss, Default = 1.0, Min = 0.0, Max = 20.0, Interval = 1.0)
		ElseIf (option == ProxSpankCooloffOID_S)
			SetSliderOptions(Value = ProxSpankCooloff, Default = 10.0, Min = 0.0, Max = 300.0, Interval = 5.0)

		ElseIf (option == IneqStatsValOID)
			SetSliderOptions(Value = IneqStatsVal, Default = 40.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		ElseIf (option == IneqHealthCushionOID)
			SetSliderOptions(Value = IneqHealthCushion, Default = 20.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		ElseIf (option == IneqCarryValOID)
			SetSliderOptions(Value = IneqCarryVal, Default = 150.0, Min = 0.0, Max = 300.0, Interval = 1.0)
		ElseIf (option == IneqSpeedValOID)
			SetSliderOptions(Value = IneqSpeedVal, Default = 10.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		ElseIf (option == IneqDamageValOID)
			SetSliderOptions(Value = IneqDamageVal, Default = 20.0, Min = 0.0, Max = 100.0, Interval = 0.1)
		ElseIf (option == IneqDestValOID)
			SetSliderOptions(Value = IneqDestVal, Default = 20.0, Min = 0.0, Max = 100.0, Interval = 0.1)
		ElseIf (option == IneqVendorGoldOID)
			SetSliderOptions(Value = IneqFemaleVendorGoldMult, Default = 1.0, Min = 0.0, Max = 1.0, Interval = 0.01)
		EndIf
		
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pTrauma" ; <----------------->
		If Option == StorageUtil.GetIntValue(Self, "TraumaPainSoundVolOID_S")
			SetSliderOptions(Value = Util.PainSoundVol * 100.0, Default = 50.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaHitSoundVolOID_S")
			SetSliderOptions(Value = Util.HitSoundVol * 100.0, Default = 50.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaCountMaxPlayerOID_S")
			SetSliderOptions(Value = Trauma.PlayerTraumaCountMax, Default = 10.0, Min = 0.0, Max = 35.0, Interval = 1.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaCountMaxFollowerOID_S")
			SetSliderOptions(Value = Trauma.FollowerTraumaCountMax, Default = 10.0, Min = 0.0, Max = 35.0, Interval = 1.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaCountMaxNpcOID_S")
			SetSliderOptions(Value = Trauma.NpcTraumaCountMax, Default = 10.0, Min = 0.0, Max = 35.0, Interval = 1.0)
			
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaStartingOpacityOID_S")
			SetSliderOptions(Value = Trauma.StartingAlpha * 100.0, Default = 50.0, Min = 30.0, Max = Trauma.MaxAlpha * 100.0, Interval = 1.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaMaximumOpacityOID_S")
			SetSliderOptions(Value = Trauma.MaxAlpha * 100.0, Default = 85.0, Min = Trauma.StartingAlpha * 100.0, Max = 100.0, Interval = 1.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaHoursToFadeInOID_S")
			SetSliderOptions(Value = Trauma.HoursToMaxAlpha, Default = 4.0, Min = 1.0, Max = 12.0, Interval = 1.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaHoursToFadeOutOID_S")
			SetSliderOptions(Value = Trauma.HoursToFadeOut, Default = 48.0, Min = 6.0, Max = 168.0, Interval = 1.0)
			
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaSexChancePlayerOID_S")
			SetSliderOptions(Value = Trauma.SexChancePlayer, Default = 33.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaSexChanceFollowerOID_S")
			SetSliderOptions(Value = Trauma.SexChanceFollower, Default = 50.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaSexChanceOID_S")
			SetSliderOptions(Value = Trauma.SexChanceNpc, Default = 75.0, Min = 0.0, Max = 100.0, Interval = 1.0)			
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaSexHitsPlayerOID_S")
			SetSliderOptions(Value = Trauma.SexHitsPlayer, Default = 1.0, Min = 0.0, Max = 5.0, Interval = 1.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaSexHitsFollowerOID_S")
			SetSliderOptions(Value = Trauma.SexHitsFollower, Default = 1.0, Min = 0.0, Max = 5.0, Interval = 1.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaSexHitsOID_S")
			SetSliderOptions(Value = Trauma.SexHitsNpc, Default = 2.0, Min = 0.0, Max = 5.0, Interval = 1.0)
			
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaDamageThresholdOID_S")
			SetSliderOptions(Value = Trauma.CombatDamageThreshold, Default = 4.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaCombatChancePlayerOID_S")
			SetSliderOptions(Value = Trauma.CombatChancePlayer, Default = 25.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaCombatChanceFollowerOID_S")
			SetSliderOptions(Value = Trauma.CombatChanceFollower, Default = 10.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaCombatChanceOID_S")
			SetSliderOptions(Value = Trauma.CombatChanceNpc, Default = 25.0, Min = 0.0, Max = 100.0, Interval = 1.0)
			
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaPushChancePlayerOID_S")
			SetSliderOptions(Value = Trauma.PushChance, Default = 33.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		EndIf
		
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pNeeds" ; <----------------->
		If (option == GluttedSpeedMultOID_S)
			SetSliderOptions(Value = GluttedSpeed, Default = 10.0, Min = 0.0, Max = 50.0, Interval = 1.0)
		ElseIf (option == CumFoodMultOID_S)
			SetSliderOptions(Value = Needs.CumFoodMult, Default = 1.0, Min = 0.0, Max = 10.0, Interval = 0.01)
		ElseIf (option == CumDrinkMultOID_S)
			SetSliderOptions(Value = Needs.CumDrinkMult, Default = 1.0, Min = 0.0, Max = 10.0, Interval = 0.01)
		ElseIf (option == SkoomaSleepOID_S)
			SetSliderOptions(Value = SkoomaSleep, Default = 1.0, Min = 0.0, Max = 5.0, Interval = 0.1)
		ElseIf (option == MilkSleepMultOID_S)
			SetSliderOptions(Value = MilkSleepMult, Default = 1.0, Min = 0.0, Max = 5.0, Interval = 0.1)
		ElseIf (option == DrugEndFatigueIncOID_S)
			SetSliderOptions(Value = DrugEndFatigueInc * 100.0, Default = 25.0, Min = -5.0, Max = 200.0, Interval = 5.0)
		
		ElseIf (option == BaseBellyScaleOID_S)
			SetSliderOptions(Value = Needs.BaseBellyScale, Default = 1.0, Min = 0.0, Max = 1.0, Interval = 1.0)
		ElseIf (option == BellyScaleRnd00OID_S)
			SetSliderOptions(Value = Rnd.BellyScaleRnd00, Default = 2.5, Min = 0.0, Max = 5.0, Interval = 0.01)
		ElseIf (option == BellyScaleRnd01OID_S)
			SetSliderOptions(Value = Rnd.BellyScaleRnd01, Default = 1.4, Min = 0.0, Max = 5.0, Interval = 0.01)
		ElseIf (option == BellyScaleRnd02OID_S)
			SetSliderOptions(Value = Rnd.BellyScaleRnd02, Default = 1.3, Min = 0.0, Max = 5.0, Interval = 0.01)
		ElseIf (option == BellyScaleRnd03OID_S)
			SetSliderOptions(Value = Rnd.BellyScaleRnd03, Default = 1.2, Min = 0.0, Max = 5.0, Interval = 0.01)
		ElseIf (option == BellyScaleRnd04OID_S)
			SetSliderOptions(Value = Rnd.BellyScaleRnd04, Default = 1.1, Min = 0.0, Max = 5.0, Interval = 0.01)
		ElseIf (option == BellyScaleRnd05OID_S)
			SetSliderOptions(Value = Rnd.BellyScaleRnd05, Default = 1.0, Min = 0.0, Max = 5.0, Interval = 0.01)
			
		ElseIf (option == BellyScaleIneed00OID_S)
			SetSliderOptions(Value = Ineed.BellyScaleIneed00, Default = 0.9, Min = 0.0, Max = 5.0, Interval = 0.01)
		ElseIf (option == BellyScaleIneed01OID_S)
			SetSliderOptions(Value = Ineed.BellyScaleIneed01, Default = 0.6, Min = 0.0, Max = 5.0, Interval = 0.01)
		ElseIf (option == BellyScaleIneed02OID_S)
			SetSliderOptions(Value = Ineed.BellyScaleIneed02, Default = 0.3, Min = 0.0, Max = 5.0, Interval = 0.01)
		ElseIf (option == BellyScaleIneed03OID_S)
			SetSliderOptions(Value = Ineed.BellyScaleIneed03, Default = 0.0, Min = 0.0, Max = 5.0, Interval = 0.01)
		EndIf
		
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pCum" ; <----------------->
		If (option == CumIsLactacidOID_S)
			SetSliderOptions(Value = CumIsLactacid * 100.0, Default = 0.0, Min = 0.0, Max = 200.0, Interval = 1.0)
		ElseIf (option == AproTwoTrollHealAmountOID)
			SetSliderOptions(Value = AproTwoTrollHealAmount, Default = 200.0, Min = 0.0, Max = 1000.0, Interval = 10.0)

		ElseIf (option == CumSwallowInflateMultOID_S)
			SetSliderOptions(Value = CumSwallowInflateMult, Default = 1.0, Min = 0.0, Max = 10.0, Interval = 0.1)
		ElseIf (option == CumEffectsMagMultOID_S)
			SetSliderOptions(Value = CumEffectsMagMult, Default = 1.0, Min = 0.0, Max = 4.0, Interval = 0.1)
		ElseIf (option == CumEffectsDurMultOID_S)
			SetSliderOptions(Value = CumEffectsDurMult, Default = 1.0, Min = 0.0, Max = 4.0, Interval = 0.1)
		ElseIf (option == CumpulsionChanceOID_S)
			SetSliderOptions(Value = CumpulsionChance, Default = 25.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		ElseIf (option == CumRegenTimeOID_S)
			SetSliderOptions(Value = CumRegenTime, Default = 24.0, Min = 0.0, Max = 48.0, Interval = 0.5)
		ElseIf (option == CumEffectVolThresOID_S)
			SetSliderOptions(Value = CumEffectVolThres, Default = 85.0, Min = 0.0, Max = 100.0, Interval = 5.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "CumInsideBonusEnjOID_S")
			SetSliderOptions(Value = CumSwallow.CumInsideBonusEnjMult * 100.0, Default = 100.0, Min = 0.0, Max = 200.0, Interval = 10.0)
		ElseIf (option == SuccubusCumSwallowEnergyMultOID_S)
			SetSliderOptions(Value = SuccubusCumSwallowEnergyMult, Default = 1.0, Min = 0.0, Max = 10.0, Interval = 0.1)
			
		ElseIf (option == CumAddictHungerRateOID_S)
			SetSliderOptions(Value = CumAddictionHungerRate, Default = 0.1, Min = 0.0, Max = 10.0, Interval = 0.01)
		ElseIf (option == CumAddictionSpeedOID_S)
			SetSliderOptions(Value = CumAddictionSpeed, Default = 1.0, Min = 0.0, Max = 10.0, Interval = 0.1)
		ElseIf (option == CumAddictionPerHourOID_S)
			SetSliderOptions(Value = CumAddictionDecayPerHour, Default = 1.0, Min = 0.0, Max = 20.0, Interval = 0.25)
		ElseIf (option == CumSatiationOID_S)
			SetSliderOptions(Value = CumSatiation, Default = 1.0, Min = 0.0, Max = 10.0, Interval = 0.1)
		ElseIf Option == StorageUtil.GetIntValue(Self, "CumAddictDayDreamArousalOID_S")
			SetSliderOptions(Value = StorageUtil.GetFloatValue(Self, "CumAddictDayDreamArousal", Missing = 101.0), Default = 101.0, Min = 0.0, Max = 101.0, Interval = 1.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "CumAddictDayDreamVolOID_S")
			SetSliderOptions(Value = StorageUtil.GetFloatValue(Self, "CumAddictDayDreamVol", Missing = 1.0) * 100.0, Default = 100.0, Min = 0.0, Max = 100.0, Interval = 5.0)
			
		ElseIf Option == StorageUtil.GetIntValue(Self, "DayDreamVoicesChanceOID_S")
			SetSliderOptions(Value = (Game.GetFormFromFile(0x104511, "SL Survival.esp") as _SLS_CumDesperationVoices).VoicesChance, Default = 100.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "DayDreamVoicesVolumeOID_S")
			SetSliderOptions(Value = (Game.GetFormFromFile(0x104511, "SL Survival.esp") as _SLS_CumDesperationVoices).VoicesVolume * 100.0, Default = 100.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "DayDreamVanillaVoiceVolumeOID_S")
			SetSliderOptions(Value = (Game.GetFormFromFile(0x104511, "SL Survival.esp") as _SLS_CumDesperationVoices).VanillaVoiceVolume * 100.0, Default = 100.0, Min = 0.0, Max = 100.0, Interval = 1.0)

		ElseIf (option == CumAddictBatheRefuseTimeOID_S)
			SetSliderOptions(Value = CumAddictBatheRefuseTime, Default = 6.0, Min = 0.0, Max = 48.0, Interval = 1.0)
		ElseIf (option == CumAddictReflexSwallowOID_S)
			SetSliderOptions(Value = CumAddictReflexSwallow, Default = 1.0, Min = 0.0, Max = 2.0, Interval = 0.1)
		ElseIf (option == CumAddictAutoSuckCreatureOID_S)
			SetSliderOptions(Value = CumAddictAutoSuckCreature, Default = 1.0, Min = 0.0, Max = 2.0, Interval = 0.1)
		ElseIf (option == CumAddictAutoSuckCooldownOID_S)
			SetSliderOptions(Value = CumAddictAutoSuckCooldown, Default = 6.0, Min = 0.0, Max = 48.0, Interval = 1.0)
		ElseIf (option == CumAddictAutoSuckCreatureArousalOID_S)
			SetSliderOptions(Value = CumAddictAutoSuckCreatureArousal, Default = 70.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		EndIf
		
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pFrostfallSimplyKnock" ; <----------------->
		If (option == WarmBodiesOID_S)
			SetSliderOptions(Value = WarmBodies, Default = 3.0, Min = 0.0, Max = 20.0, Interval = 1.0)
		ElseIf (option == MilkLeakWetOID_S)
			SetSliderOptions(Value = MilkLeakWet, Default = 50.0, Min = 0.0, Max = 200.0, Interval = 1.0)
		ElseIf (option == CumWetMultOID_S)
			SetSliderOptions(Value = CumWetMult, Default = 1.0, Min = 0.0, Max = 5.0, Interval = 0.1)
		ElseIf (option == CumExposureMultOID_S)
			SetSliderOptions(Value = CumExposureMult, Default = 1.0, Min = 0.0, Max = 5.0, Interval = 0.1)
		ElseIf (option == SwimCumCleanOID_S)
			SetSliderOptions(Value = SwimCumClean, Default = 12.0, Min = 0.0, Max = 120.0, Interval = 2.0)
		ElseIf (option == SimpleSlaveryFFOID_S)
			SetSliderOptions(Value = SimpleSlaveryFF, Default = 50.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		ElseIf (option == SdDreamFFOID_S)
			SetSliderOptions(Value = SdDreamFF, Default = 50.0, Min = 0.0, Max = 100.0, Interval = 1.0)

		ElseIf (option == KnockSlaveryChanceOID_S)
			SetSliderOptions(Value = KnockSlaveryChance, Default = 3.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		ElseIf (option == SimpleSlaveryWeightOID_S)
			SetSliderOptions(Value = SimpleSlaveryWeight, Default = 50.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		ElseIf (option == SdWeightOID_S)
			SetSliderOptions(Value = SdWeight, Default = 50.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		EndIf
		
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pTollsEvictionGates" ; <----------------->
		If (option == TollFollowersOID_S)
			SetSliderOptions(Value = _SLS_TollFollowersRequired.GetValueInt(), Default = 1.0, Min = 0.0, Max = 5.0, Interval = 1.0)

		ElseIf (option == TollDodgeHuntFreqOID_S)
			SetSliderOptions(Value = TollDodgeHuntFreq, Default = 1.5, Min = 0.25, Max = 10.0, Interval = 0.25)
		ElseIf (option == TollDodgeGracePeriodOID_S)
			SetSliderOptions(Value = TollDodgeGracePeriod, Default = 2.0, Min = 0.0, Max = 24.0, Interval = 1.0)
		ElseIf (option == TollDodgeMaxGuardsOID_S)
			SetSliderOptions(Value = TollDodgeMaxGuards, Default = 6.0, Min = 1.0, Max = 10.0, Interval = 1.0)
		ElseIf (option == TollDodgeDetectDistMaxOID_S)
			SetSliderOptions(Value = GuardSpotDistNom, Default = 512.0, Min = 0.0, Max = 4096.0, Interval = 64.0)
		ElseIf (option == TollDodgeDisguiseBodyPenaltyOID_S)
			SetSliderOptions(Value = TollDodgeDisguiseBodyPenalty * 100.0, Default = 75.0, Min = 0.0, Max = 300.0, Interval = 1.0)
		ElseIf (option == TollDodgeDisguiseHeadPenaltyOID_S)
			SetSliderOptions(Value = TollDodgeDisguiseHeadPenalty * 100.0, Default = 75.0, Min = 0.0, Max = 300.0, Interval = 1.0)
		ElseIf (option == TollDodgeItemValueModOID_S)
			SetSliderOptions(Value = TollDodgeItemValueMod, Default = 1.0, Min = 0.0, Max = 5.0, Interval = 0.01)
		ElseIf Option == StorageUtil.GetIntValue(Self, "GateCurfewBeginOID_S")
			SetSliderOptions(Value = (Game.GetFormFromFile(0x0EAB5A, "SL Survival.esp") as GlobalVariable).GetValue(), Default = 20.0, Min = 0.0, Max = 24.0, Interval = 1.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "GateCurfewEndOID_S")
			SetSliderOptions(Value = (Game.GetFormFromFile(0x0EAB5B, "SL Survival.esp") as GlobalVariable).GetValue(), Default = 7.0, Min = 0.0, Max = 24.0, Interval = 1.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "GateCurfewSlavetownBeginOID_S")
			SetSliderOptions(Value = (Game.GetFormFromFile(0x0EE155, "SL Survival.esp") as GlobalVariable).GetValue(), Default = 18.0, Min = 0.0, Max = 24.0, Interval = 1.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "GateCurfewSlavetownEndOID_S")
			SetSliderOptions(Value = (Game.GetFormFromFile(0x0EE156, "SL Survival.esp") as GlobalVariable).GetValue(), Default = 10.0, Min = 0.0, Max = 24.0, Interval = 1.0)
			
		ElseIf (option == TollCostGoldOID_S)
			SetSliderOptions(Value = TollUtil.TollCostGold, Default = 100.0, Min = 0.0, Max = 500.0, Interval = 1.0)
		ElseIf (option == SlaverunFactorOID)
			SetSliderOptions(Value = TollUtil.SlaverunFactor, Default = 2.0, Min = 0.0, Max = 10.0, Interval = 0.1)
		ElseIf (option == SlaverunJobFactorOID)
			SetSliderOptions(Value = TollUtil.SlaverunJobFactor, Default = 2.0, Min = 0.0, Max = 10.0, Interval = 1.0)
		ElseIf (option == TollCostDevicesOID_S)
			SetSliderOptions(Value = TollUtil.TollCostDevices, Default = 3.0, Min = 0.0, Max = 10.0, Interval = 1.0)
		ElseIf (option == TollCostTattoosOID_S)
			SetSliderOptions(Value = TollUtil.TollCostTattoos, Default = 2.0, Min = 0.0, Max = 10.0, Interval = 1.0)
		ElseIf (option == TollCostDrugsOID_S)
			SetSliderOptions(Value = TollUtil.TollCostDrugs, Default = 2.0, Min = 0.0, Max = 10.0, Interval = 1.0)
			
		ElseIf (option == MaxTatsBodyOID_S)
			SetSliderOptions(Value = MaxTatsBody, Default = 6.0, Min = 0.0, Max = 20.0, Interval = 1.0)
		ElseIf (option == MaxTatsFaceOID_S)
			SetSliderOptions(Value = MaxTatsFace, Default = 3.0, Min = 0.0, Max = 10.0, Interval = 1.0)
		ElseIf (option == MaxTatsHandsOID_S)
			SetSliderOptions(Value = MaxTatsHands, Default = 0.0, Min = 0.0, Max = 10.0, Interval = 1.0)
		ElseIf (option == MaxTatsFeetOID_S)
			SetSliderOptions(Value = MaxTatsFeet, Default = 0.0, Min = 0.0, Max = 10.0, Interval = 1.0)

		ElseIf (option == EvictionLimitOID_S)
			SetSliderOptions(Value = EvictionLimit, Default = 500.0, Min = 0.0, Max = 5000.0, Interval = 100.0)
		ElseIf (option == SlaverunEvictionLimitOID_S)
			SetSliderOptions(Value = SlaverunEvictionLimit, Default = 200.0, Min = 0.0, Max = 5000.0, Interval = 50.0)
		ElseIf (option == ConfiscationFineOID_S)
			SetSliderOptions(Value = ConfiscationFine, Default = 100.0, Min = 0.0, Max = 1000.0, Interval = 50.0)
		ElseIf (option == ConfiscationFineSlaverunOID_S)
			SetSliderOptions(Value = ConfiscationFineSlaverun, Default = 200.0, Min = 0.0, Max = 1000.0, Interval = 50.0)
		EndIf
		
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pLicences1" ; <----------------->
		If (option == TollDodgeDetectDistTownMaxOID_S)
			SetSliderOptions(Value = GuardSpotDistTown, Default = 1024.0, Min = 0.0, Max = 4096.0, Interval = 64.0)
		ElseIf (option == TollDodgeDisguiseBodyPenaltyOID_S)
			SetSliderOptions(Value = TollDodgeDisguiseBodyPenalty * 100.0, Default = 75.0, Min = 0.0, Max = 300.0, Interval = 1.0)
		ElseIf (option == TollDodgeDisguiseHeadPenaltyOID_S)
			SetSliderOptions(Value = TollDodgeDisguiseHeadPenalty * 100.0, Default = 75.0, Min = 0.0, Max = 300.0, Interval = 1.0)		
		ElseIf (option == EnforcerRespawnDurOID_S)
			SetSliderOptions(Value = EnforcerRespawnDur, Default = 7.0, Min = 0.0, Max = 100.0, Interval = 0.5)
		ElseIf (option == TradeRestrictBribeOID_S)
			SetSliderOptions(Value = TradeRestrictBribe, Default = 50.0, Min = 0.0, Max = 1000.0, Interval = 1.0)
		ElseIf (option == LicUnlockCostOID_S)
			SetSliderOptions(Value = _SLS_LicUnlockCost.GetValueInt(), Default = 5000.0, Min = 100.0, Max = 100000.0, Interval = 100.0)
		ElseIf (option == LicBlockChanceOID_S)
			SetSliderOptions(Value = LicBlockChance, Default = 70.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		
		ElseIf Option == StorageUtil.GetIntValue(Self, "WetLicenceDestroyChanceOID_S")
			SetSliderOptions(Value = LicUtil.DrenchLicDestroyChance, Default = 0.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "WetLicenceMaxToLoseOID_S")
			SetSliderOptions(Value = Frostfall.MaxLicsToLose, Default = 1.0, Min = 0.0, Max = 10.0, Interval = 1.0)

		ElseIf (option == LicFactionDiscountOID_S)
			SetSliderOptions(Value = LicUtil.LicFactionDiscount * 100.0, Default = 50.0, Min = 0.0, Max = 100.0, Interval = 1.0)
			
		ElseIf (option == EnforcersMinOID_S)
			SetSliderOptions(Value = EnforcersMin, Default = 2.0, Min = 0.0, Max = EnforcersMax, Interval = 1.0)
		ElseIf (option == EnforcersMaxOID_S)
			SetSliderOptions(Value = EnforcersMax, Default = 5.0, Min = EnforcersMin, Max = 5.0, Interval = 1.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "_SLS_EnforcerGuardsMinOID_S")
			SetSliderOptions(Value = (_SLS_LicTownCheckQuest as _SLS_LicTownCheck).EnforcerGuardsMin, Default = 3.0, Min = 0, Max = (_SLS_LicTownCheckQuest as _SLS_LicTownCheck).EnforcerGuardsMax, Interval = 1.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "_SLS_EnforcerGuardsMaxOID_S")
			SetSliderOptions(Value = (_SLS_LicTownCheckQuest as _SLS_LicTownCheck).EnforcerGuardsMax, Default = 7.0, Min = (_SLS_LicTownCheckQuest as _SLS_LicTownCheck).EnforcerGuardsMin, Max = 20, Interval = 1.0)
		ElseIf (option == PersistentEnforcersOID_S)
			SetSliderOptions(Value = _SLS_LicInspPersistence.GetValueInt(), Default = 0.0, Min = 0.0, Max = 10.0, Interval = 1.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "EnforcerChaseDistanceOID_S")
			SetSliderOptions(Value = (Game.GetFormFromFile(0x1118A1, "SL Survival.esp") as GlobalVariable).GetValue(), Default = 1024.0, Min = 0.0, Max = 4096.0, Interval = 256.0) ; ; _SLS_LicInspChaseDistance
		
		ElseIf (option == LicShortDurOID_S)
			SetSliderOptions(Value = LicUtil.LicShortDur, Default = 7.0, Min = 1.0, Max = 1000.0, Interval = 1.0)
		ElseIf (option == LicLongDurOID_S)
			SetSliderOptions(Value = LicUtil.LicLongDur, Default = 28.0, Min = 1.0, Max = 1000.0, Interval = 1.0)
			
		ElseIf (option == LicWeapShortCostOID_S)
			SetSliderOptions(Value = LicUtil.LicCostWeaponShort, Default = 1000.0, Min = 50.0, Max = 100000.0, Interval = 50.0)
		ElseIf (option == LicWeapLongCostOID_S)
			SetSliderOptions(Value = LicUtil.LicCostWeaponLong, Default = 3000.0, Min = 50.0, Max = 100000.0, Interval = 50.0)
		ElseIf (option == LicWeapPerCostOID_S)
			SetSliderOptions(Value = LicUtil.LicCostWeaponPer, Default = 15000.0, Min = 50.0, Max = 100000.0, Interval = 50.0)
		
		ElseIf Option == StorageUtil.GetIntValue(Self, "LicMagicCurseDrainTo")
			SetSliderOptions(Value = (Game.GetFormFromFile(0x10C223, "SL Survival.esp") as GlobalVariable).GetValue(), Default = -10.0, Min = -10.0, Max = 200.0, Interval = 10.0)
		ElseIf (option == LicMagicShortCostOID_S)
			SetSliderOptions(Value = LicUtil.LicCostMagicShort, Default = 1000.0, Min = 50.0, Max = 100000.0, Interval = 50.0)
		ElseIf (option == LicMagicLongCostOID_S)
			SetSliderOptions(Value = LicUtil.LicCostMagicLong, Default = 3000.0, Min = 50.0, Max = 100000.0, Interval = 50.0)
		ElseIf (option == LicMagicPerCostOID_S)
			SetSliderOptions(Value = LicUtil.LicCostMagicPer, Default = 20000.0, Min = 50.0, Max = 100000.0, Interval = 50.0)
			
		ElseIf (option == LicArmorShortCostOID_S)
			SetSliderOptions(Value = LicUtil.LicCostArmorShort, Default = 3000.0, Min = 50.0, Max = 100000.0, Interval = 50.0)
		ElseIf (option == LicArmorLongCostOID_S)
			SetSliderOptions(Value = LicUtil.LicCostArmorLong, Default = 9000.0, Min = 50.0, Max = 100000.0, Interval = 50.0)
		ElseIf (option == LicArmorPerCostOID_S)
			SetSliderOptions(Value = LicUtil.LicCostArmorPer, Default = 30000.0, Min = 50.0, Max = 100000.0, Interval = 50.0)
			
		ElseIf (option == LicBikiniHeelHeightOID_S)
			SetSliderOptions(Value = BikiniCurse.HeelHeightRequired, Default = 5.0, Min = 0.0, Max = 20.0, Interval = 0.1)
		ElseIf Option == StorageUtil.GetIntValue(Self, "LicBikiniBreathChanceOID_S")
			SetSliderOptions(Value = StorageUtil.GetFloatValue(None, "_SLS_LicBikOutOfBreathAnimChance", Missing = 60.0), Default = 60.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		ElseIf (option == LicBikiniShortCostOID_S)
			SetSliderOptions(Value = LicUtil.LicCostBikiniShort, Default = 1000.0, Min = 50.0, Max = 100000.0, Interval = 50.0)
		ElseIf (option == LicBikiniLongCostOID_S)
			SetSliderOptions(Value = LicUtil.LicCostBikiniLong, Default = 3000.0, Min = 50.0, Max = 100000.0, Interval = 50.0)
		ElseIf (option == LicBikiniPerCostOID_S)
			SetSliderOptions(Value = LicUtil.LicCostBikiniPer, Default = 15000.0, Min = 50.0, Max = 100000.0, Interval = 50.0)
			
		ElseIf (option == LicClothesShortCostOID_S)
			SetSliderOptions(Value = LicUtil.LicCostClothesShort, Default = 500.0, Min = 50.0, Max = 100000.0, Interval = 50.0)
		ElseIf (option == LicClothesLongCostOID_S)
			SetSliderOptions(Value = LicUtil.LicCostClothesLong, Default = 1500.0, Min = 50.0, Max = 100000.0, Interval = 50.0)
		ElseIf (option == LicClothesPerCostOID_S)
			SetSliderOptions(Value = LicUtil.LicCostClothesPer, Default = 10000.0, Min = 50.0, Max = 100000.0, Interval = 50.0)
		EndIf
		
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pLicences2" ; <----------------->
		
		If Option == StorageUtil.GetIntValue(Self, "CurfewRestartDelayOID_S")
			SetSliderOptions(Value = (Game.GetFormFromFile(0x0E3F3D, "SL Survival.esp") as _SLS_Curfew).TimeToClearStreets, Default = 60.0, Min = 10.0, Max = 300.0, Interval = 10.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "CurfewBeginOID_S")
			SetSliderOptions(Value = (Game.GetFormFromFile(0x07B44C, "SL Survival.esp") as GlobalVariable).GetValue(), Default = 21.0, Min = 0.0, Max = 24.0, Interval = 1.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "CurfewEndOID_S")
			SetSliderOptions(Value = (Game.GetFormFromFile(0x07B44D, "SL Survival.esp") as GlobalVariable).GetValue(), Default = 6.0, Min = 0.0, Max = 24.0, Interval = 1.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "CurfewSlavetownBeginOID_S")
			SetSliderOptions(Value = (Game.GetFormFromFile(0x0ECBC0, "SL Survival.esp") as GlobalVariable).GetValue(), Default = 19.0, Min = 0.0, Max = 24.0, Interval = 1.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "CurfewSlavetownEndOID_S")
			SetSliderOptions(Value = (Game.GetFormFromFile(0x0ECBC1, "SL Survival.esp") as GlobalVariable).GetValue(), Default = 9.0, Min = 0.0, Max = 24.0, Interval = 1.0)
			
		ElseIf Option == StorageUtil.GetIntValue(Self, "LicCurfewShortCostOID_S")
			SetSliderOptions(Value = LicUtil.LicCostCurfewShort, Default = 1000.0, Min = 50.0, Max = 100000.0, Interval = 50.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "LicCurfewLongCostOID_S")
			SetSliderOptions(Value = LicUtil.LicCostCurfewLong, Default = 3000.0, Min = 50.0, Max = 100000.0, Interval = 50.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "LicCurfewPerCostOID_S")
			SetSliderOptions(Value = LicUtil.LicCostCurfewPer, Default = 20000.0, Min = 50.0, Max = 100000.0, Interval = 50.0)
		
		ElseIf Option == StorageUtil.GetIntValue(Self, "LicWhoreShortCostOID_S")
			SetSliderOptions(Value = LicUtil.LicCostWhoreShort, Default = 100.0, Min = 50.0, Max = 100000.0, Interval = 50.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "LicWhoreLongCostOID_S")
			SetSliderOptions(Value = LicUtil.LicCostWhoreLong, Default = 300.0, Min = 50.0, Max = 100000.0, Interval = 50.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "LicWhorePerCostOID_S")
			SetSliderOptions(Value = LicUtil.LicCostWhorePer, Default = 1000.0, Min = 50.0, Max = 100000.0, Interval = 50.0)

		ElseIf Option == StorageUtil.GetIntValue(Self, "LicPropertyShortCostOID_S")
			SetSliderOptions(Value = LicUtil.LicCostPropertyShort, Default = 1000.0, Min = 50.0, Max = 100000.0, Interval = 50.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "LicPropertyLongCostOID_S")
			SetSliderOptions(Value = LicUtil.LicCostPropertyLong, Default = 6000.0, Min = 50.0, Max = 100000.0, Interval = 50.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "LicPropertyPerCostOID_S")
			SetSliderOptions(Value = LicUtil.LicCostPropertyPer, Default = 100000.0, Min = 50.0, Max = 100000.0, Interval = 50.0)
			
		ElseIf Option == StorageUtil.GetIntValue(Self, "LicFreedomShortCostOID_S")
			SetSliderOptions(Value = LicUtil.LicCostFreedomShort, Default = 500.0, Min = 50.0, Max = 100000.0, Interval = 50.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "LicFreedomLongCostOID_S")
			SetSliderOptions(Value = LicUtil.LicCostFreedomLong, Default = 5000.0, Min = 50.0, Max = 100000.0, Interval = 50.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "LicFreedomPerCostOID_S")
			SetSliderOptions(Value = LicUtil.LicCostFreedomPer, Default = 250000.0, Min = 50.0, Max = 100000.0, Interval = 50.0)
		EndIf
		
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pStashes" ; <----------------->
		If (option == RoadDistOID_S)
			SetSliderOptions(Value = RoadDist, Default = 8192.0, Min = 0.0, Max = 16384.0, Interval = 512.0)
		ElseIf (option == StealXItemsOID_S)
			SetSliderOptions(Value = StealXItems, Default = 25.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		EndIf
		
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pBeggingKennel" ; <----------------->
		If (option == BegNumItemsOID_S)
			SetSliderOptions(Value = BegNumItems, Default = 2.0, Min = 0.0, Max = 5.0, Interval = 1.0)
		ElseIf (option == BegGoldOID_S)
			SetSliderOptions(Value = BegGold, Default = 1.0, Min = 0.0, Max = 3.0, Interval = 0.1)
		ElseIf (option == BegMwaCurseChanceOID_S)
			SetSliderOptions(Value = BegMwaCurseChance, Default = 50.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		ElseIf (option == KennelSafeCellCostOID_S)
			SetSliderOptions(Value = KennelSafeCellCost, Default = 40.0, Min = 0.0, Max = 200.0, Interval = 1.0)
		ElseIf (option == KennelCreatureChanceOID_S)
			SetSliderOptions(Value = KennelCreatureChance, Default = 50.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		ElseIf (option == KennelRapeChancePerHourOID_S)
			SetSliderOptions(Value = KennelRapeChancePerHour, Default = 20.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		ElseIf (option == KennelSlaveRapeTimeMinOID_S)
			SetSliderOptions(Value = KennelSlaveRapeTimeMin, Default = 10.0, Min = -1.0, Max = KennelSlaveRapeTimeMax, Interval = 1.0)
		ElseIf (option == KennelSlaveRapeTimeMaxOID_S)
			SetSliderOptions(Value = KennelSlaveRapeTimeMax, Default = 40.0, Min = KennelSlaveRapeTimeMin, Max = 600.0, Interval = 1.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "KennelSlaveDeviceCountMinOID_S")
			SetSliderOptions(Value = StorageUtil.GetIntValue(Self, "KennelSlaveDeviceCountMin", Missing = 2), Default = 2.0, Min = 0.0, Max = StorageUtil.GetIntValue(Self, "KennelSlaveDeviceCountMax", Missing = 6), Interval = 1.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "KennelSlaveDeviceCountMaxOID_S")
			SetSliderOptions(Value = StorageUtil.GetIntValue(Self, "KennelSlaveDeviceCountMax", Missing = 2), Default = 6.0, Min = StorageUtil.GetIntValue(Self, "KennelSlaveDeviceCountMin", Missing = 2), Max = 10.0, Interval = 1.0)
		EndIf
		
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pPickpocketDismemberment" ; <----------------->
		If (option == PpGoldLowChanceOID_S)
			SetSliderOptions(Value = PpGoldLowChance, Default = 60.0, Min = 0.0, Max = 100.0 - (PpGoldModerateChance + PpGoldHighChance), Interval = 0.5)
		ElseIf (option == PpGoldModerateChanceOID_S)
			SetSliderOptions(Value = PpGoldModerateChance, Default = 20.0, Min = 0.0, Max = 100.0 - (PpGoldLowChance + PpGoldHighChance), Interval = 0.5)
		ElseIf (option == PpGoldHighChanceOID_S)
			SetSliderOptions(Value = PpGoldHighChance, Default = 2.0, Min = 0.0, Max = 100.0 - (PpGoldLowChance + PpGoldModerateChance), Interval = 0.5)
			
		ElseIf (option == PpLootMinOID_S)
			SetSliderOptions(Value = Util.PpLootLootMin, Default = 0.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		ElseIf (option == PpLootMaxOID_S)
			SetSliderOptions(Value = Util.PpLootLootMax, Default = 8.0, Min = 0.0, Max = 100.0, Interval = 1.0)

		ElseIf (option == PpLootFoodChanceOID_S)
			SetSliderOptions(Value = PpLootFoodChance, Default = 25.0, Min = 0.0, Max = 100.0 - (PpLootGemsChance + PpLootSoulgemsChance + PpLootJewelryChance + PpLootEnchJewelryChance + PpLootPotionsChance + PpLootKeysChance + PpLootTomesChance + PpLootCureChance), Interval = 0.5)
		ElseIf (option == PpLootGemsChanceOID_S)
			SetSliderOptions(Value = PpLootGemsChance, Default = 15.0, Min = 0.0, Max = 100.0 - (PpLootFoodChance + PpLootSoulgemsChance + PpLootJewelryChance + PpLootEnchJewelryChance + PpLootPotionsChance + PpLootKeysChance + PpLootTomesChance + PpLootCureChance), Interval = 0.5)
		ElseIf (option == PpLootSoulgemsChanceOID_S)
			SetSliderOptions(Value = PpLootSoulgemsChance, Default = 10.0, Min = 0.0, Max = 100.0 - (PpLootFoodChance + PpLootGemsChance + PpLootJewelryChance + PpLootEnchJewelryChance + PpLootPotionsChance + PpLootKeysChance + PpLootTomesChance + PpLootCureChance), Interval = 0.5)
		ElseIf (option == PpLootJewelryChanceOID_S)
			SetSliderOptions(Value = PpLootJewelryChance, Default = 15.0, Min = 0.0, Max = 100.0 - (PpLootFoodChance + PpLootGemsChance + PpLootSoulgemsChance + PpLootEnchJewelryChance + PpLootPotionsChance + PpLootKeysChance + PpLootTomesChance + PpLootCureChance), Interval = 0.5)
		ElseIf (option == PpLootEnchJewelryChanceOID_S)
			SetSliderOptions(Value = PpLootEnchJewelryChance, Default = 5.0, Min = 0.0, Max = 100.0 - (PpLootFoodChance + PpLootGemsChance + PpLootSoulgemsChance + PpLootJewelryChance + PpLootPotionsChance + PpLootKeysChance + PpLootTomesChance + PpLootCureChance), Interval = 0.5)
		ElseIf (option == PpLootPotionsChanceOID_S)
			SetSliderOptions(Value = PpLootPotionsChance, Default = 10.0, Min = 0.0, Max = 100.0 - (PpLootFoodChance + PpLootGemsChance + PpLootSoulgemsChance + PpLootJewelryChance + PpLootEnchJewelryChance + PpLootKeysChance + PpLootTomesChance + PpLootCureChance), Interval = 0.5)
		ElseIf (option == PpLootKeysChanceOID_S)
			SetSliderOptions(Value = PpLootKeysChance, Default = 10.0, Min = 0.0, Max = 100.0 - (PpLootFoodChance + PpLootGemsChance + PpLootSoulgemsChance + PpLootJewelryChance + PpLootEnchJewelryChance + PpLootPotionsChance + PpLootTomesChance + PpLootCureChance), Interval = 0.5)
		ElseIf (option == PpLootTomesChanceOID_S)
			SetSliderOptions(Value = PpLootTomesChance, Default = 5.0, Min = 0.0, Max = 100.0 - (PpLootFoodChance + PpLootGemsChance + PpLootSoulgemsChance + PpLootJewelryChance + PpLootEnchJewelryChance + PpLootPotionsChance + PpLootKeysChance + PpLootCureChance), Interval = 0.5)
		ElseIf (option == PpLootCureChanceOID_S)
			SetSliderOptions(Value = PpLootCureChance, Default = 5.0, Min = 0.0, Max = 100.0 - (PpLootFoodChance + PpLootGemsChance + PpLootSoulgemsChance + PpLootJewelryChance + PpLootEnchJewelryChance + PpLootPotionsChance + PpLootKeysChance + PpLootTomesChance), Interval = 0.5)
			
		ElseIf (option == PpCrimeGoldOID_S)
			SetSliderOptions(Value = Game.GetGameSettingInt("iCrimeGoldPickpocket"), Default = 100.0, Min = 0.0, Max = 1000.0, Interval = 25.0)
		ElseIf (option == PpFailDevicesOID_S)
			SetSliderOptions(Value = Init.PpFailDevices, Default = 4.0, Min = 0.0, Max = 10.0, Interval = 1.0)
		ElseIf (option == PpFailStealValueOID_S)
			SetSliderOptions(Value = _SLS_PickPocketFailStealValue.GetValueInt(), Default = 200.0, Min = 0.0, Max = 10000.0, Interval = 10.0)
		ElseIf (option == PpFailDrugCountOID_S)
			SetSliderOptions(Value = PpFailDrugCount, Default = 2.0, Min = 1.0, Max = 10.0, Interval = 1.0)

		ElseIf (option == DismemberCooldownOID_S)
			SetSliderOptions(Value = DismemberCooldown, Default = 0.5, Min = 0.0, Max = 168.0, Interval = 0.05)
		ElseIf (option == DismemberMaxAmpedLimbsOID_S)
			SetSliderOptions(Value = MaxAmpedLimbs, Default = 4.0, Min = 1.0, Max = 4.0, Interval = 1.0)
		ElseIf (option == DismemberChanceOID_S)
			SetSliderOptions(Value = DismemberChance, Default = 90.0, Min = 0.0, Max = 100.0, Interval = 0.1)
		ElseIf (option == DismemberArmorBonusOID_S)
			SetSliderOptions(Value = DismemberArmorBonus, Default = 5.0, Min = 0.0, Max = 100.0, Interval = 0.1)
		ElseIf (option == DismemberDamageThresOID_S)
			SetSliderOptions(Value = DismemberDamageThres, Default = 3.0, Min = 0.0, Max = 1000.0, Interval = 1.0)
		ElseIf (option == DismemberHealthThresOID_S)
			SetSliderOptions(Value = DismemberHealthThres, Default = 110.0, Min = 0.0, Max = 1000.0, Interval = 10.0)
		ElseIf (option == AmpPriestHealCostOID_S)
			SetSliderOptions(Value = _SLS_AmpPriestHealCost.GetValueInt(), Default = 200.0, Min = 0.0, Max = 10000.0, Interval = 50.0)
		EndIf
			
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pBikiniArmorsExp" ; <----------------->
		If (option == BikiniDropsVendorCityOID_S)
			SetSliderOptions(Value = BikiniDropsVendorCity, Default = 30.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		ElseIf (option == BikiniDropsVendorTownOID_S)
			SetSliderOptions(Value = BikiniDropsVendorTown, Default = 16.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		ElseIf (option == BikiniDropsVendorKhajiitOID_S)
			SetSliderOptions(Value = BikiniDropsVendorKhajiit, Default = 12.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		ElseIf (option == BikiniDropsChestOID_S)
			SetSliderOptions(Value = BikiniDropsChest, Default = 6.0, Min = 0.0, Max = 100.0, Interval = 1.0)
		ElseIf (option == BikiniDropsChestOrnateOID_S)
			SetSliderOptions(Value = BikiniDropsChestOrnate, Default = 10.0, Min = 0.0, Max = 100.0, Interval = 1.0)
			
		ElseIf (option == BikiniExpPerLevelOID_S)
			SetSliderOptions(Value = BikiniExp.ExpPerLevel, Default = 100.0, Min = 10.0, Max = 1000.0, Interval = 10.0)
		ElseIf (option == BikiniExpTrainOID_S)
			SetSliderOptions(Value = BikTrainingSpeed, Default = 1.0, Min = 0.0, Max = 10.0, Interval = 0.1)
		ElseIf (option == BikiniExpUntrainOID_S)
			SetSliderOptions(Value = BikUntrainingSpeed, Default = 0.5, Min = 0.0, Max = 10.0, Interval = 0.1)
		
		ElseIf (option == BikiniChanceHideOID_S)
			SetSliderOptions(Value = BikiniChanceHide, Default = 10.0, Min = 0.0, Max = 100.0 - (BikiniChanceLeather + BikiniChanceIron + BikiniChanceSteel + BikiniChanceSteelPlate + BikiniChanceDwarven + BikiniChanceFalmer + BikiniChanceWolf + BikiniChanceBlades + BikiniChanceEbony + BikiniChanceDragonbone), Interval = 0.5)
		ElseIf (option == BikiniChanceLeatherOID_S)
			SetSliderOptions(Value = BikiniChanceLeather, Default = 10.0, Min = 0.0, Max = 100.0 - (BikiniChanceHide + BikiniChanceIron + BikiniChanceSteel + BikiniChanceSteelPlate + BikiniChanceDwarven + BikiniChanceFalmer + BikiniChanceWolf + BikiniChanceBlades + BikiniChanceEbony + BikiniChanceDragonbone), Interval = 0.5)
		ElseIf (option == BikiniChanceIronOID_S)
			SetSliderOptions(Value = BikiniChanceIron, Default = 10.0, Min = 0.0, Max = 100.0 - (BikiniChanceHide + BikiniChanceLeather + BikiniChanceSteel + BikiniChanceSteelPlate + BikiniChanceDwarven + BikiniChanceFalmer + BikiniChanceWolf + BikiniChanceBlades + BikiniChanceEbony + BikiniChanceDragonbone), Interval = 0.5)
		ElseIf (option == BikiniChanceSteelOID_S)
			SetSliderOptions(Value = BikiniChanceSteel, Default = 11.0, Min = 0.0, Max = 100.0 - (BikiniChanceHide + BikiniChanceLeather + BikiniChanceIron + BikiniChanceSteelPlate + BikiniChanceDwarven + BikiniChanceFalmer + BikiniChanceWolf + BikiniChanceBlades + BikiniChanceEbony + BikiniChanceDragonbone), Interval = 0.5)
		ElseIf (option == BikiniChanceSteelPlateOID_S)
			SetSliderOptions(Value = BikiniChanceSteelPlate, Default = 8.0, Min = 0.0, Max = 100.0 - (BikiniChanceHide + BikiniChanceLeather + BikiniChanceIron + BikiniChanceSteel + BikiniChanceDwarven + BikiniChanceFalmer + BikiniChanceWolf + BikiniChanceBlades + BikiniChanceEbony + BikiniChanceDragonbone), Interval = 0.5)
		ElseIf (option == BikiniChanceDwarvenOID_S)
			SetSliderOptions(Value = BikiniChanceDwarven, Default = 6.0, Min = 0.0, Max = 100.0 - (BikiniChanceHide + BikiniChanceLeather + BikiniChanceIron + BikiniChanceSteel + BikiniChanceSteelPlate + BikiniChanceFalmer + BikiniChanceWolf + BikiniChanceBlades + BikiniChanceEbony + BikiniChanceDragonbone), Interval = 0.5)
		ElseIf (option == BikiniChanceFalmerOID_S)
			SetSliderOptions(Value = BikiniChanceFalmer, Default = 6.0, Min = 0.0, Max = 100.0 - (BikiniChanceHide + BikiniChanceLeather + BikiniChanceIron + BikiniChanceSteel + BikiniChanceSteelPlate + BikiniChanceDwarven + BikiniChanceWolf + BikiniChanceBlades + BikiniChanceEbony + BikiniChanceDragonbone), Interval = 0.5)
		ElseIf (option == BikiniChanceWolfOID_S)
			SetSliderOptions(Value = BikiniChanceWolf, Default = 6.0, Min = 0.0, Max = 100.0 - (BikiniChanceHide + BikiniChanceLeather + BikiniChanceIron + BikiniChanceSteel + BikiniChanceSteelPlate + BikiniChanceDwarven + BikiniChanceFalmer + BikiniChanceBlades + BikiniChanceEbony + BikiniChanceDragonbone), Interval = 0.5)
		ElseIf (option == BikiniChanceBladesOID_S)
			SetSliderOptions(Value = BikiniChanceBlades, Default = 2.0, Min = 0.0, Max = 100.0 - (BikiniChanceHide + BikiniChanceLeather + BikiniChanceIron + BikiniChanceSteel + BikiniChanceSteelPlate + BikiniChanceDwarven + BikiniChanceFalmer + BikiniChanceWolf + BikiniChanceEbony + BikiniChanceDragonbone), Interval = 0.5)
		ElseIf (option == BikiniChanceEbonyOID_S)
			SetSliderOptions(Value = BikiniChanceEbony, Default = 1.0, Min = 0.0, Max = 100.0 - (BikiniChanceHide + BikiniChanceLeather + BikiniChanceIron + BikiniChanceSteel + BikiniChanceSteelPlate + BikiniChanceDwarven + BikiniChanceFalmer + BikiniChanceWolf + BikiniChanceBlades + BikiniChanceDragonbone), Interval = 0.5)
		ElseIf (option == BikiniChanceDragonboneOID_S)
			SetSliderOptions(Value = BikiniChanceDragonbone, Default = 0.5, Min = 0.0, Max = 100.0 - (BikiniChanceHide + BikiniChanceLeather + BikiniChanceIron + BikiniChanceSteel + BikiniChanceSteelPlate + BikiniChanceDwarven + BikiniChanceFalmer + BikiniChanceWolf + BikiniChanceBlades + BikiniChanceEbony), Interval = 0.5)
		EndIf
		
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pInnRoomPrices" ; <----------------->
		; Inn prices
		String InnLoc
		Int i = 0
		While i < LocTrack.InnCosts.Length
			InnLoc = StorageUtil.StringListGet(LocTrack, "_SLS_LocIndex", i)
			If Option == StorageUtil.GetIntValue(Self, "InnCost" + InnLoc + "OID_S")
				SetSliderOptions(Value = LocTrack.InnCosts[i], Default = 100.0, Min = 5.0, Max = 1000.0, Interval = 5.0)
			EndIf
			i += 1
		EndWhile
	EndIf
endEvent

Event OnOptionSliderAccept(int option, float value)
	If StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pSettings" ; <----------------->
		If (option == BarefootMagOIS_S)
			BarefootMag = value
			SetSliderOptionValue(BarefootMagOIS_S, BarefootMag)
			DoToggleBarefootSpeed = true
		ElseIf Option == StorageUtil.GetIntValue(Self, "BarefootStaggerChanceOID_S")
			StorageUtil.SetFloatValue(Self, "BarefootStaggerChance", value)
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "BarefootStaggerChanceOID_S"), StorageUtil.GetFloatValue(Self, "BarefootStaggerChance", Missing = 20.0))
			SendModEvent("_SLS_BarefootStaggerChance")
		ElseIf (option == HorseCostOIS_S)
			SurvivalHorseCost = value as Int
			SetSliderOptionValue(HorseCostOIS_S, SurvivalHorseCost)
			SetHorseCost(SurvivalHorseCost)
		ElseIf Option == StorageUtil.GetIntValue(Self, "GrowthWeightGainOID_S")
			StorageUtil.SetFloatValue(Self, "WeightGainPerDay", value)
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "GrowthWeightGainOID_S"), value)
			StorageUtil.SetIntValue(Self, "DoToggleGrowth", 1)
		ElseIf (option == MinSpeedOID_S)
			MinSpeedMult = value
			SetSliderOptionValue(MinSpeedOID_S, MinSpeedMult)
		ElseIf (option == MinCarryWeightOID_S)
			MinCarryWeight = value
			SetSliderOptionValue(MinCarryWeightOID_S, MinCarryWeight)
		ElseIf (option == ReplaceMapsTimerOID_S)
			ReplaceMapsTimer = value
			SetSliderOptionValue(ReplaceMapsTimerOID_S, ReplaceMapsTimer)
		ElseIf (option == GoldWeightOID_S)
			GoldWeight = value
			SetSliderOptionValue(GoldWeightOID_S, GoldWeight)
			Gold001.SetWeight(GoldWeight)
		ElseIf (option == FolGoldStealChanceOID_S)
			FolGoldStealChance = value
			Main.FilterGold(FolGoldStealChance)
			SetSliderOptionValue(FolGoldStealChanceOID_S, FolGoldStealChance)
		ElseIf (option == FolGoldSteamAmountOID_S)
			FolGoldSteamAmount = value as int
			SetSliderOptionValue(FolGoldSteamAmountOID_S, FolGoldSteamAmount)
		ElseIf (option == SlaverunAutoMinOID_S)
			If value > 0.0
				If value > SlaverunAutoMax
					Debug.Messagebox("Min can not be greater than max")
				Else
					SlaverunAutoMin = value
					SetSliderOptionValue(SlaverunAutoMinOID_S, SlaverunAutoMin)
					DoSlaverunInitOnClose = true
				EndIf
			Else
				If ShowMessage("Are you sure you want to start Slaverun now?")
					SlaverunAutoMin = 0.0
					SlaverunAutoMax = 0.0
					DoSlaverunInitOnClose = true
				EndIf
			EndIf
		ElseIf (option == SlaverunAutoMaxOID_S)
			If value < SlaverunAutoMin
				Debug.Messagebox("Max can not be less than min")
			Else
				SlaverunAutoMax = value
				SetSliderOptionValue(SlaverunAutoMaxOID_S, SlaverunAutoMax)
				DoSlaverunInitOnClose = true
			EndIf
			
		ElseIf Option == StorageUtil.GetIntValue(Self, "HomeCostWhiterunOID_S")
			(Game.GetFormFromFile(0xF728B, "Skyrim.esm") as GlobalVariable).SetValueInt(value as Int)
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "HomeCostWhiterunOID_S"), value)
			(Game.GetFormFromFile(0xA7B33, "Skyrim.esm") as Quest).UpdateCurrentInstanceGlobal(Game.GetFormFromFile(0xF728B, "Skyrim.esm") as GlobalVariable) ; HousePurchase - HPWhiterun
		ElseIf Option == StorageUtil.GetIntValue(Self, "HomeCostSolitudeOID_S")
			(Game.GetFormFromFile(0xF728C, "Skyrim.esm") as GlobalVariable).SetValueInt(value as Int)
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "HomeCostSolitudeOID_S"), value)
			(Game.GetFormFromFile(0xA7B33, "Skyrim.esm") as Quest).UpdateCurrentInstanceGlobal(Game.GetFormFromFile(0xF728C, "Skyrim.esm") as GlobalVariable) ; HousePurchase - HPSolitude
		ElseIf Option == StorageUtil.GetIntValue(Self, "HomeCostMarkarthOID_S")
			(Game.GetFormFromFile(0xF728E, "Skyrim.esm") as GlobalVariable).SetValueInt(value as Int)
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "HomeCostMarkarthOID_S"), value)
			(Game.GetFormFromFile(0xA7B33, "Skyrim.esm") as Quest).UpdateCurrentInstanceGlobal(Game.GetFormFromFile(0xF728E, "Skyrim.esm") as GlobalVariable) ; HousePurchase - HPMarkarth
		ElseIf Option == StorageUtil.GetIntValue(Self, "HomeCostWindhelmOID_S")
			(Game.GetFormFromFile(0xF728A, "Skyrim.esm") as GlobalVariable).SetValueInt(value as Int)
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "HomeCostWindhelmOID_S"), value)
			(Game.GetFormFromFile(0xA7B33, "Skyrim.esm") as Quest).UpdateCurrentInstanceGlobal(Game.GetFormFromFile(0xF728A, "Skyrim.esm") as GlobalVariable) ; HousePurchase - HPWindhelm
		ElseIf Option == StorageUtil.GetIntValue(Self, "HomeCostRiftenOID_S")
			(Game.GetFormFromFile(0xF728D, "Skyrim.esm") as GlobalVariable).SetValueInt(value as Int)
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "HomeCostRiftenOID_S"), value)
			(Game.GetFormFromFile(0xA7B33, "Skyrim.esm") as Quest).UpdateCurrentInstanceGlobal(Game.GetFormFromFile(0xF728D, "Skyrim.esm") as GlobalVariable) ; HousePurchase - HPRiften
		
		ElseIf (option == DflowResistLossOID_S)
			DflowResistLoss = value
			SetSliderOptionValue(DflowResistLossOID_S, DflowResistLoss)
		ElseIf (option == DeviousGagDebuffOID_S)
			DeviousGagDebuff = value
			SetSliderOptionValue(DeviousGagDebuffOID_S, DeviousGagDebuff)
			SetGagSpeechDebuff()
		ElseIf (option == BondFurnMilkFreqOID_S)
			BondFurnMilkFreq = value
			SetSliderOptionValue(BondFurnMilkFreqOID_S, BondFurnMilkFreq)
		ElseIf (option == BondFurnMilkFatigueMultOID_S)
			BondFurnMilkFatigueMult = value
			SetSliderOptionValue(BondFurnMilkFatigueMultOID_S, BondFurnMilkFatigueMult)
		ElseIf (option == BondFurnMilkWillOID_S)
			BondFurnMilkWill = value as Int
			SetSliderOptionValue(BondFurnMilkWillOID_S, BondFurnMilkWill)
		ElseIf (option == BondFurnFreqOID_S)
			BondFurnFreq = value
			SetSliderOptionValue(BondFurnFreqOID_S, BondFurnFreq)
		ElseIf (option == BondFurnFatigueMultOID_S)
			BondFurnFatigueMult = value
			SetSliderOptionValue(BondFurnFatigueMultOID_S, BondFurnFatigueMult)
		ElseIf (option == BondFurnWillOID_S)
			BondFurnWill = value as Int
			SetSliderOptionValue(BondFurnWillOID_S, BondFurnWill)
		ElseIf (option == HalfNakedBraOID_S)
			HalfNakedBra = value as Int
			SetSliderOptionValue(HalfNakedBraOID_S, value)
			CheckHalfNakedCover()
		ElseIf (option == HalfNakedPantyOID_S)
			HalfNakedPanty = value as Int
			SetSliderOptionValue(HalfNakedPantyOID_S, value)
			CheckHalfNakedCover()
		ElseIf Option == StorageUtil.GetIntValue(Self, "SlifBreastScaleMaxOID_S")
			Main.Slif.ScaleMaxBreasts = value
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "SlifBreastScaleMaxOID_S"), value)
		ElseIf Option == StorageUtil.GetIntValue(Self, "SlifBellyScaleMaxOID_S")
			Main.Slif.ScaleMaxBelly = value
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "SlifBellyScaleMaxOID_S"), value)
		ElseIf Option == StorageUtil.GetIntValue(Self, "SlifAssScaleMaxOID_S")
			Main.Slif.ScaleMaxAss = value
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "SlifAssScaleMaxOID_S"), value)
		EndIf
		
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pSexEffects" ; <----------------->
		If (option == SexExpCorruptionCurrentOID_S)
			StorageUtil.SetFloatValue(None, "_SLS_CreatureCorruption", value)
			SetSliderOptionValue(SexExpCorruptionCurrentOID_S, value)
		ElseIf (option == CockSizeBonusEnjFreqOID_S)
			CockSizeBonusEnjFreq = value
			SetSliderOptionValue(CockSizeBonusEnjFreqOID_S, value)
		ElseIf (option == RapeForcedSkoomaChanceOID_S)
			RapeForcedSkoomaChance = value
			SetSliderOptionValue(RapeForcedSkoomaChanceOID_S, value)
		ElseIf (option == RapeMinArousalOID_S)
			RapeMinArousal = value
			SetSliderOptionValue(RapeMinArousalOID_S, value)
		ElseIf Option == StorageUtil.GetIntValue(Self, "CompulsiveSexFuckTimeOID_S")
			(Game.GetFormFromFile(0x0E7553, "SL Survival.esp") as _SLS_CompulsiveSex).TimeBetweenFucks = value
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "CompulsiveSexFuckTimeOID_S"), (Game.GetFormFromFile(0x0E7553, "SL Survival.esp") as _SLS_CompulsiveSex).TimeBetweenFucks)
		ElseIf Option == StorageUtil.GetIntValue(Self, "OrgasmFatigueThresholdOID_S")
			(Game.GetFormFromFile(0x0E857D, "SL Survival.esp") as _SLS_OrgasmFatigue).OrgasmThreshold = value
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "OrgasmFatigueThresholdOID_S"), (Game.GetFormFromFile(0x0E857D, "SL Survival.esp") as _SLS_OrgasmFatigue).OrgasmThreshold)
		ElseIf Option == StorageUtil.GetIntValue(Self, "OrgasmFatigueRecoveryOID_S")
			(Game.GetFormFromFile(0x0E857D, "SL Survival.esp") as _SLS_OrgasmFatigue).OrgasmRecoveryPerHour = value
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "OrgasmFatigueRecoveryOID_S"), (Game.GetFormFromFile(0x0E857D, "SL Survival.esp") as _SLS_OrgasmFatigue).OrgasmRecoveryPerHour)
		ElseIf Option == StorageUtil.GetIntValue(Self, "AhegaoDurPerOrgasmOID_S")
			(Game.GetFormFromFile(0x0FCE71, "SL Survival.esp") as _SLS_Ahegao).DurPerOrgasm = value
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "AhegaoDurPerOrgasmOID_S"), value)
		ElseIf (option == SexMinStaminaRateOID_S)
			SexMinStaminaRate = value
			SetSliderOptionValue(SexMinStaminaRateOID_S, SexMinStaminaRate)
		ElseIf (option == SexMinStaminaMultOID_S)
			SexMinStaminaMult = value
			SetSliderOptionValue(SexMinStaminaMultOID_S, SexMinStaminaMult)
		ElseIf (option == SexMinMagickaRateOID_S)
			SexMinMagickaRate = value
			SetSliderOptionValue(SexMinMagickaRateOID_S, SexMinMagickaRate)
		ElseIf (option == SexMinMagickaMultOID_S)
			SexMinMagickaMult = value
			SetSliderOptionValue(SexMinMagickaMultOID_S, SexMinMagickaMult)
		ElseIf Option == StorageUtil.GetIntValue(Self, "WildlingPointsLossRate")
			AnimalFriend.Wildling.WildlingPointsLossPerRank = value
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "WildlingPointsLossRate"), AnimalFriend.Wildling.WildlingPointsLossPerRank)
		ElseIf Option == StorageUtil.GetIntValue(Self, "AllurePerLevel")
			AnimalFriend.Wildling.AllurePointsPerLevel = value
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "AllurePerLevel"), AnimalFriend.Wildling.AllurePointsPerLevel)
			AnimalFriend.Wildling.UpdateAllurePool()
		ElseIf (option == AfCooloffBaseOID_S)
			AnimalFriend.BreedingCooloffBase = value
			SetSliderOptionValue(AfCooloffBaseOID_S, AnimalFriend.BreedingCooloffBase)
		ElseIf (option == AfCooloffBodyCumOID_S)
			AnimalFriend.BreedingCooloffCumCovered = value
			SetSliderOptionValue(AfCooloffBodyCumOID_S, AnimalFriend.BreedingCooloffCumCovered)
		ElseIf (option == AfCooloffCumInflationOID_S)
			AnimalFriend.BreedingCooloffCumFilled = value
			SetSliderOptionValue(AfCooloffCumInflationOID_S, AnimalFriend.BreedingCooloffCumFilled)
		ElseIf (option == AfCooloffPregnancyOID_S)
			AnimalFriend.BreedingCooloffPregnancy = value
			SetSliderOptionValue(AfCooloffPregnancyOID_S, AnimalFriend.BreedingCooloffPregnancy)
		ElseIf (option == AfCooloffCumSwallowOID_S)
			AnimalFriend.SwallowBonus = value
			SetSliderOptionValue(AfCooloffCumSwallowOID_S, AnimalFriend.SwallowBonus)
		ElseIf Option == StorageUtil.GetIntValue(Self, "FashionRapeHairCutChanceOID_S")
			FashionRape.HaircutChance = value
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "FashionRapeHairCutChanceOID_S"), value)
		ElseIf Option == StorageUtil.GetIntValue(Self, "FashionRapeHaircutMinOID_S")
			FashionRape.HaircutMinLevel = value as Int
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "FashionRapeHairCutMinOID_S"), value)
		ElseIf Option == StorageUtil.GetIntValue(Self, "FashionRapeHaircutMaxOID_S")
			FashionRape.HaircutMaxLevel = value as Int
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "FashionRapeHairCutMaxOID_S"), value)
		ElseIf Option == StorageUtil.GetIntValue(Self, "FashionRapeHairCutFloorOID_S")
			FashionRape.HaircutFloor = value as Int
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "FashionRapeHairCutFloorOID_S"), value)
		ElseIf Option == StorageUtil.GetIntValue(Self, "FashionRapeDyeHairChanceOID_S")
			FashionRape.DyeHairChance = value
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "FashionRapeDyeHairChanceOID_S"), value)
		ElseIf Option == StorageUtil.GetIntValue(Self, "FashionRapeShavePussyChanceOID_S")
			FashionRape.ShavePussyChance = value
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "FashionRapeShavePussyChanceOID_S"), value)
		ElseIf Option == StorageUtil.GetIntValue(Self, "FashionRapeLipstickChanceOID_S")
			FashionRape.SmudgeLipstickChance = value
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "FashionRapeLipstickChanceOID_S"), value)
		ElseIf Option == StorageUtil.GetIntValue(Self, "FashionRapeEyeshadowChanceOID_S")
			FashionRape.SmudgeEyeshadowChance = value
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "FashionRapeEyeshadowChanceOID_S"), value)
		EndIf
		
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pMisogynyInequality" ; <----------------->	
		If Option == StorageUtil.GetIntValue(Self, "PushCooldownOID_S")
			(Game.GetFormFromFile(0x0E651A, "SL Survival.esp") as _SLS_PushPlayerCooloff).CooloffPeriod = value
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "PushCooldownOID_S"), (Game.GetFormFromFile(0x0E651A, "SL Survival.esp") as _SLS_PushPlayerCooloff).CooloffPeriod)
		ElseIf (option == CatCallVolOIS_S)
			CatCallVol = value
			SetSliderOptionValue(CatCallVolOIS_S, CatCallVol)
			DoToggleCatCalling = true
		ElseIf (option == CatCallWillLossOIS_S)
			CatCallWillLoss = value
			SetSliderOptionValue(CatCallWillLossOIS_S, CatCallWillLoss)
		ElseIf (option == GreetDistOIS_S)
			GreetDist = value
			SetSliderOptionValue(GreetDistOIS_S, GreetDist)
			Game.SetGameSettingFloat("fAIMinGreetingDistance", GreetDist)
		ElseIf (option == AssSlapResistLossOID_S)
			AssSlapResistLoss = value
			SetSliderOptionValue(AssSlapResistLossOID_S, AssSlapResistLoss)
		ElseIf (option == ProxSpankCooloffOID_S)
			ProxSpankCooloff = value
			SetSliderOptionValue(ProxSpankCooloffOID_S, ProxSpankCooloff)
	
		ElseIf (option == IneqStatsValOID)
			IneqStatsVal = value
			SetSliderOptionValue(IneqStatsValOID, value)
			_SLS_IneqDebuffPlusCushion.SetValue(IneqStatsVal + IneqHealthCushion)
			DoInequalityRefresh = true
		ElseIf (option == IneqHealthCushionOID)
			IneqHealthCushion = value
			SetSliderOptionValue(IneqHealthCushionOID, value)
			_SLS_IneqDebuffPlusCushion.SetValue(IneqStatsVal + IneqHealthCushion)
			DoInequalityRefresh = true
		ElseIf (option == IneqCarryValOID)
			IneqCarryVal = value
			SetSliderOptionValue(IneqCarryValOID, value)
			DoInequalityRefresh = true
		ElseIf (option == IneqSpeedValOID)
			IneqSpeedVal = value
			SetSliderOptionValue(IneqSpeedValOID, value)
			DoInequalityRefresh = true
		ElseIf (option == IneqDamageValOID)
			IneqDamageVal = value
			SetSliderOptionValue(IneqDamageValOID, value)
			DoInequalityRefresh = true
		ElseIf (option == IneqDestValOID)
			IneqDestVal = value
			SetSliderOptionValue(IneqDestValOID, value)
			DoInequalityRefresh = true
		ElseIf (option == IneqVendorGoldOID)
			IneqFemaleVendorGoldMult = value
			SetSliderOptionValue(IneqVendorGoldOID, value)
			ModifyVendorGold()
		EndIf
		
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pTrauma" ; <----------------->
		If Option == StorageUtil.GetIntValue(Self, "TraumaPainSoundVolOID_S")
			Util.PainSoundVol = value / 100.0
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "TraumaPainSoundVolOID_S"), Util.PainSoundVol * 100.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaHitSoundVolOID_S")
			Util.HitSoundVol = value / 100.0
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "TraumaHitSoundVolOID_S"), Util.HitSoundVol * 100.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaCountMaxPlayerOID_S")
			Trauma.PlayerTraumaCountMax = value as Int
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "TraumaCountMaxPlayerOID_S"), Trauma.PlayerTraumaCountMax)
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaCountMaxFollowerOID_S")
			Trauma.FollowerTraumaCountMax = value as Int
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "TraumaCountMaxFollowerOID_S"), Trauma.FollowerTraumaCountMax)
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaCountMaxNpcOID_S")
			Trauma.NpcTraumaCountMax = value as Int
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "TraumaCountMaxNpcOID_S"), Trauma.NpcTraumaCountMax)
			
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaStartingOpacityOID_S")
			Trauma.StartingAlpha = value / 100.0
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "TraumaStartingOpacityOID_S"), Trauma.StartingAlpha * 100.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaMaximumOpacityOID_S")
			Trauma.MaxAlpha = value / 100.0
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "TraumaMaximumOpacityOID_S"), Trauma.MaxAlpha * 100.0)
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaHoursToFadeInOID_S")
			Trauma.HoursToMaxAlpha = value as Int
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "TraumaHoursToFadeInOID_S"), Trauma.HoursToMaxAlpha)
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaHoursToFadeOutOID_S")
			Trauma.HoursToFadeOut = value as Int
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "TraumaHoursToFadeOutOID_S"), Trauma.HoursToFadeOut)
			
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaSexChancePlayerOID_S")
			Trauma.SexChancePlayer = value
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "TraumaSexChancePlayerOID_S"), Trauma.SexChancePlayer)
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaSexChanceFollowerOID_S")
			Trauma.SexChanceFollower = value
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "TraumaSexChanceFollowerOID_S"), Trauma.SexChanceFollower)
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaSexChanceOID_S")
			Trauma.SexChanceNpc = value
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "TraumaSexChanceOID_S"), Trauma.SexChanceNpc)
			
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaSexHitsPlayerOID_S")
			Trauma.SexHitsPlayer = value as Int
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "TraumaSexHitsPlayerOID_S"), Trauma.SexHitsPlayer)
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaSexHitsFollowerOID_S")
			Trauma.SexHitsFollower = value as Int
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "TraumaSexHitsFollowerOID_S"), Trauma.SexHitsFollower)
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaSexHitsOID_S")
			Trauma.SexHitsNpc = value as Int
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "TraumaSexHitsOID_S"), Trauma.SexHitsNpc)
			
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaDamageThresholdOID_S")
			Trauma.CombatDamageThreshold = value as Int
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "TraumaDamageThresholdOID_S"), Trauma.CombatDamageThreshold)
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaCombatChancePlayerOID_S")
			If Trauma.CombatChancePlayer != value
				Trauma.CombatChancePlayer = value
				Trauma.ToggleCombatTrauma()
			EndIf
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "TraumaCombatChancePlayerOID_S"), Trauma.CombatChancePlayer)
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaCombatChanceFollowerOID_S")
			If Trauma.CombatChanceFollower != Value
				Trauma.CombatChanceFollower = value
				Trauma.ToggleCombatTrauma()
			EndIf
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "TraumaCombatChanceFollowerOID_S"), Trauma.CombatChanceFollower)
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaCombatChanceOID_S")
			If Trauma.CombatChanceNpc != Value
				Trauma.CombatChanceNpc = value
				Trauma.ToggleCombatTrauma()
			EndIf
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "TraumaCombatChanceOID_S"), Trauma.CombatChanceNpc)
		
		ElseIf Option == StorageUtil.GetIntValue(Self, "TraumaPushChancePlayerOID_S")
			If Trauma.PushChance != value
				Trauma.SetPushChance()
			EndIf
			Trauma.PushChance = value
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "TraumaPushChancePlayerOID_S"), Trauma.PushChance)
		EndIf
	
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pNeeds" ; <----------------->
		If (option == GluttedSpeedMultOID_S)
			GluttedSpeed = value
			SetSliderOptionValue(GluttedSpeedMultOID_S, GluttedSpeed)
		ElseIf (option == CumFoodMultOID_S)
			Needs.CumFoodMult = value
			SetSliderOptionValue(CumFoodMultOID_S, Needs.CumFoodMult)
		ElseIf (option == CumDrinkMultOID_S)
			Needs.CumDrinkMult = value
			SetSliderOptionValue(CumDrinkMultOID_S, Needs.CumDrinkMult)
		ElseIf (option == SkoomaSleepOID_S)
			SkoomaSleep = value
			SetSliderOptionValue(SkoomaSleepOID_S, SkoomaSleep)
		ElseIf (option == MilkSleepMultOID_S)
			MilkSleepMult = value
			SetSliderOptionValue(MilkSleepMultOID_S, MilkSleepMult)
		ElseIf (option == DrugEndFatigueIncOID_S)
			DrugEndFatigueInc = value / 100.0
			SetSliderOptionValue(DrugEndFatigueIncOID_S, DrugEndFatigueInc * 100.0)
		
		ElseIf (option == BaseBellyScaleOID_S)
			Needs.BaseBellyScale = value
			SetSliderOptionValue(BaseBellyScaleOID_S, Needs.BaseBellyScale)
			UpdateBellyScale()
		ElseIf (option == BellyScaleRnd00OID_S)
			Rnd.BellyScaleRnd00 = value
			SetSliderOptionValue(BellyScaleRnd00OID_S, Rnd.BellyScaleRnd00)
			UpdateBellyScale()
		ElseIf (option == BellyScaleRnd01OID_S)
			Rnd.BellyScaleRnd01 = value
			SetSliderOptionValue(BellyScaleRnd01OID_S, Rnd.BellyScaleRnd01)
			UpdateBellyScale()
		ElseIf (option == BellyScaleRnd02OID_S)
			Rnd.BellyScaleRnd02 = value
			SetSliderOptionValue(BellyScaleRnd02OID_S, Rnd.BellyScaleRnd02)
			UpdateBellyScale()
		ElseIf (option == BellyScaleRnd03OID_S)
			Rnd.BellyScaleRnd03 = value
			SetSliderOptionValue(BellyScaleRnd03OID_S, Rnd.BellyScaleRnd03)
			UpdateBellyScale()
		ElseIf (option == BellyScaleRnd04OID_S)
			Rnd.BellyScaleRnd04 = value
			SetSliderOptionValue(BellyScaleRnd04OID_S, Rnd.BellyScaleRnd04)
			UpdateBellyScale()
		ElseIf (option == BellyScaleRnd05OID_S)
			Rnd.BellyScaleRnd05 = value
			SetSliderOptionValue(BellyScaleRnd05OID_S, Rnd.BellyScaleRnd05)
			UpdateBellyScale()
			
		ElseIf (option == BellyScaleIneed00OID_S)
			Ineed.BellyScaleIneed00 = value
			SetSliderOptionValue(BellyScaleIneed00OID_S, Ineed.BellyScaleIneed00)
			UpdateBellyScale()
		ElseIf (option == BellyScaleIneed01OID_S)
			Ineed.BellyScaleIneed01 = value
			SetSliderOptionValue(BellyScaleIneed01OID_S, Ineed.BellyScaleIneed01)
			UpdateBellyScale()
		ElseIf (option == BellyScaleIneed02OID_S)
			Ineed.BellyScaleIneed02 = value
			SetSliderOptionValue(BellyScaleIneed02OID_S, Ineed.BellyScaleIneed02)
			UpdateBellyScale()
		ElseIf (option == BellyScaleIneed03OID_S)
			Ineed.BellyScaleIneed03 = value
			SetSliderOptionValue(BellyScaleIneed03OID_S, Ineed.BellyScaleIneed03)
			UpdateBellyScale()
		EndIf
		
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pCum" ; <----------------->
	
		If (option == CumIsLactacidOID_S)
			CumIsLactacid = (value / 100.0)
			SetSliderOptionValue(CumIsLactacidOID_S, value)
		ElseIf (option == AproTwoTrollHealAmountOID)
			AproTwoTrollHealAmount = value as Int
			SetSliderOptionValue(AproTwoTrollHealAmountOID, AproTwoTrollHealAmount)

		ElseIf (option == CumSwallowInflateMultOID_S)
			CumSwallowInflateMult = value
			SetSliderOptionValue(CumSwallowInflateMultOID_S, CumSwallowInflateMult)
		ElseIf (option == CumEffectsMagMultOID_S)
			CumEffectsMagMult = value
			SetSliderOptionValue(CumEffectsMagMultOID_S, CumEffectsMagMult)
		ElseIf (option == CumEffectsDurMultOID_S)
			CumEffectsDurMult = value
			SetSliderOptionValue(CumEffectsDurMultOID_S, CumEffectsDurMult)
		ElseIf (option == CumpulsionChanceOID_S)
			CumpulsionChance = value
			SetSliderOptionValue(CumpulsionChanceOID_S, CumpulsionChance)
		ElseIf (option == CumRegenTimeOID_S)
			CumRegenTime = value
			SetSliderOptionValue(CumRegenTimeOID_S, CumRegenTime)
		ElseIf (option == CumEffectVolThresOID_S)
			CumEffectVolThres = value
			SetSliderOptionValue(CumEffectVolThresOID_S, CumEffectVolThres)
		ElseIf Option == StorageUtil.GetIntValue(Self, "CumInsideBonusEnjOID_S")
			CumSwallow.CumInsideBonusEnjMult = value / 100.0
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "CumInsideBonusEnjOID_S"), Value)
		ElseIf (option == SuccubusCumSwallowEnergyMultOID_S)
			SuccubusCumSwallowEnergyMult = value
			SetSliderOptionValue(SuccubusCumSwallowEnergyMultOID_S, SuccubusCumSwallowEnergyMult)
		ElseIf (option == CumAddictHungerRateOID_S)
			CumAddictionHungerRate = value
			SetSliderOptionValue(CumAddictHungerRateOID_S, CumAddictionHungerRate)
		ElseIf (option == CumAddictionSpeedOID_S)
			CumAddictionSpeed = value
			SetSliderOptionValue(CumAddictionSpeedOID_S, CumAddictionSpeed)
		ElseIf (option == CumAddictionPerHourOID_S)
			CumAddictionDecayPerHour = value
			SetSliderOptionValue(CumAddictionPerHourOID_S, CumAddictionDecayPerHour)
		ElseIf (option == CumSatiationOID_S)
			CumSatiation = value
			SetSliderOptionValue(CumSatiationOID_S, CumSatiation)
		ElseIf Option == StorageUtil.GetIntValue(Self, "CumAddictDayDreamArousalOID_S")
			StorageUtil.SetFloatValue(Self, "CumAddictDayDreamArousal", value)
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "CumAddictDayDreamArousalOID_S"), value)
			CumAddict.RegForArousal()
			CumAddict.CumDesperationEffects(CumAddict.GetHungerState())
		ElseIf Option == StorageUtil.GetIntValue(Self, "CumAddictDayDreamVolOID_S")
			StorageUtil.SetFloatValue(Self, "CumAddictDayDreamVol", (value / 100.0))
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "CumAddictDayDreamVolOID_S"), value)
		ElseIf Option == StorageUtil.GetIntValue(Self, "DayDreamVoicesChanceOID_S")
			(Game.GetFormFromFile(0x104511, "SL Survival.esp") as _SLS_CumDesperationVoices).VoicesChance = value
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "DayDreamVoicesChanceOID_S"), value)
		ElseIf Option == StorageUtil.GetIntValue(Self, "DayDreamVoicesVolumeOID_S")
			(Game.GetFormFromFile(0x104511, "SL Survival.esp") as _SLS_CumDesperationVoices).VoicesVolume = value / 100.0
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "DayDreamVoicesVolumeOID_S"), value)
		ElseIf Option == StorageUtil.GetIntValue(Self, "DayDreamVanillaVoiceVolumeOID_S")
			(Game.GetFormFromFile(0x104511, "SL Survival.esp") as _SLS_CumDesperationVoices).VanillaVoiceVolume = value / 100.0
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "DayDreamVanillaVoiceVolumeOID_S"), value)

		ElseIf (option == CumAddictBatheRefuseTimeOID_S)
			CumAddictBatheRefuseTime = value
			SetSliderOptionValue(CumAddictBatheRefuseTimeOID_S, CumAddictBatheRefuseTime)
		ElseIf (option == CumAddictReflexSwallowOID_S)
			CumAddictReflexSwallow = value
			SetSliderOptionValue(CumAddictReflexSwallowOID_S, CumAddictReflexSwallow)
		ElseIf (option == CumAddictAutoSuckCreatureOID_S)
			CumAddictAutoSuckCreature = value
			SetSliderOptionValue(CumAddictAutoSuckCreatureOID_S, CumAddictAutoSuckCreature)
			DoToggleCumAddictAutoSuckCreature = true
		ElseIf (option == CumAddictAutoSuckCooldownOID_S)
			CumAddictAutoSuckCooldown = value
			SetSliderOptionValue(CumAddictAutoSuckCooldownOID_S, CumAddictAutoSuckCooldown)
		ElseIf (option == CumAddictAutoSuckCreatureArousalOID_S)
			CumAddictAutoSuckCreatureArousal = value
			SetSliderOptionValue(CumAddictAutoSuckCreatureArousalOID_S, CumAddictAutoSuckCreatureArousal)
		EndIf
		
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pFrostfallSimplyKnock" ; <----------------->
		; Frostfall
		If (option == WarmBodiesOID_S)
			WarmBodies = -value
			SetSliderOptionValue(WarmBodiesOID_S, -WarmBodies)
		ElseIf (option == MilkLeakWetOID_S)
			MilkLeakWet = value
			SetSliderOptionValue(MilkLeakWetOID_S, MilkLeakWet)
		ElseIf (option == CumWetMultOID_S)
			CumWetMult = value
			SetSliderOptionValue(CumWetMultOID_S, CumWetMult)
		ElseIf (option == CumExposureMultOID_S)
			CumExposureMult = value
			SetSliderOptionValue(CumExposureMultOID_S, CumExposureMult)
		ElseIf (option == SwimCumCleanOID_S)
			SwimCumClean = value as Int
			SetSliderOptionValue(SwimCumCleanOID_S, SwimCumClean)
			
		ElseIf (option == SimpleSlaveryFFOID_S)
			SimpleSlaveryFF = value
			SetSliderOptionValue(SimpleSlaveryFFOID_S, SimpleSlaveryFF)
			
			SdDreamFF = 100.0 - SimpleSlaveryFF
			SetSliderOptionValue(SdDreamFFOID_S, SdDreamFF)
		ElseIf (option == SdDreamFFOID_S)
			SdDreamFF = value
			SetSliderOptionValue(SdDreamFFOID_S, SdDreamFF)
			
			SimpleSlaveryFF = 100.0 - SdDreamFF
			SetSliderOptionValue(SimpleSlaveryFFOID_S, SimpleSlaveryFF)
			
		; Simply Knock
		ElseIf (option == KnockSlaveryChanceOID_S)
			KnockSlaveryChance = value
			SetSliderOptionValue(KnockSlaveryChanceOID_S, KnockSlaveryChance)
		ElseIf (option == SimpleSlaveryWeightOID_S)
			SimpleSlaveryWeight = value
			SetSliderOptionValue(SimpleSlaveryWeightOID_S, SimpleSlaveryWeight)
			
			SdWeight = 100.0 - SimpleSlaveryWeight
			SetSliderOptionValue(SdWeightOID_S, SdWeight)
		ElseIf (option == SdWeightOID_S)
			SdWeight = value
			SetSliderOptionValue(SdWeightOID_S, SdWeight)
			SimpleSlaveryWeight = 100.0 - SdWeight
			SetSliderOptionValue(SimpleSlaveryWeightOID_S, SimpleSlaveryWeight)
		EndIf
		
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pTollsEvictionGates" ; <----------------->
		; Tolls & Eviction
		If (option == EvictionLimitOID_S)
			EvictionLimit = value as Int
			SetSliderOptionValue(EvictionLimitOID_S, EvictionLimit)
		ElseIf (option == SlaverunEvictionLimitOID_S)
			SlaverunEvictionLimit = value as Int
			SetSliderOptionValue(SlaverunEvictionLimitOID_S, SlaverunEvictionLimit)
		ElseIf (option == ConfiscationFineOID_S)
			ConfiscationFine = value as Int
			SetSliderOptionValue(ConfiscationFineOID_S, ConfiscationFine)
		ElseIf (option == ConfiscationFineSlaverunOID_S)
			ConfiscationFineSlaverun = value as Int
			SetSliderOptionValue(ConfiscationFineSlaverunOID_S, ConfiscationFineSlaverun)
			
		ElseIf (option == TollCostGoldOID_S)
			TollUtil.TollCostGold = value as Int
			SetSliderOptionValue(TollCostGoldOID_S, TollUtil.TollCostGold)
			;SetTollCost()
		ElseIf (option == SlaverunFactorOID)
			TollUtil.SlaverunFactor = value
			SetSliderOptionValue(SlaverunFactorOID, TollUtil.SlaverunFactor)
			;SetTollCost()
		ElseIf (option == SlaverunJobFactorOID)
			TollUtil.SlaverunJobFactor = value as Int
			SetSliderOptionValue(SlaverunJobFactorOID, TollUtil.SlaverunJobFactor)
		ElseIf (option == TollCostDevicesOID_S)
			TollUtil.TollCostDevices = value as Int
			SetSliderOptionValue(TollCostDevicesOID_S, TollUtil.TollCostDevices)
		ElseIf (option == TollCostTattoosOID_S)
			TollUtil.TollCostTattoos = value as Int
			SetSliderOptionValue(TollCostTattoosOID_S, TollUtil.TollCostTattoos)
		ElseIf (option == TollCostDrugsOID_S)
			TollUtil.TollCostDrugs = value as Int
			SetSliderOptionValue(TollCostDrugsOID_S, TollUtil.TollCostDrugs)
			
		ElseIf (option == MaxTatsBodyOID_S)
			MaxTatsBody = value as Int
			SetSliderOptionValue(MaxTatsBodyOID_S, MaxTatsBody)
		ElseIf (option == MaxTatsFaceOID_S)
			MaxTatsFace = value as Int
			SetSliderOptionValue(MaxTatsFaceOID_S, MaxTatsFace)
		ElseIf (option == MaxTatsHandsOID_S)
			MaxTatsHands = value as Int
			SetSliderOptionValue(MaxTatsHandsOID_S, MaxTatsHands)
		ElseIf (option == MaxTatsFeetOID_S)
			MaxTatsFeet = value as Int
			SetSliderOptionValue(MaxTatsFeetOID_S, MaxTatsFeet)

		ElseIf (option == TollDodgeHuntFreqOID_S)
			TollDodgeHuntFreq = value
			SetSliderOptionValue(TollDodgeHuntFreqOID_S, TollDodgeHuntFreq)
		ElseIf (option == TollDodgeGracePeriodOID_S)
			TollDodgeGracePeriod = value as Int
			SetSliderOptionValue(TollDodgeGracePeriodOID_S, TollDodgeGracePeriod)
		ElseIf (option == TollDodgeMaxGuardsOID_S)
			TollDodgeMaxGuards = value as int
			SetSliderOptionValue(TollDodgeMaxGuardsOID_S, TollDodgeMaxGuards)
		ElseIf (option == TollDodgeDetectDistMaxOID_S)
			GuardSpotDistNom = value
			SetSliderOptionValue(TollDodgeDetectDistMaxOID_S, GuardSpotDistNom)
			RefreshGuardSpotDistance()
		ElseIf (option == TollDodgeDetectDistTownMaxOID_S)
			GuardSpotDistTown = value
			SetSliderOptionValue(TollDodgeDetectDistTownMaxOID_S, GuardSpotDistTown)
			RefreshGuardSpotDistance()
		ElseIf (option == TollDodgeDisguiseBodyPenaltyOID_S)
			TollDodgeDisguiseBodyPenalty = value / 100.0
			SetSliderOptionValue(TollDodgeDisguiseBodyPenaltyOID_S, TollDodgeDisguiseBodyPenalty * 100.0)
			RefreshGuardSpotDistance()
		ElseIf (option == TollDodgeDisguiseHeadPenaltyOID_S)
			TollDodgeDisguiseHeadPenalty = value / 100.0
			SetSliderOptionValue(TollDodgeDisguiseHeadPenaltyOID_S, TollDodgeDisguiseHeadPenalty * 100.0)
			RefreshGuardSpotDistance()
		ElseIf (option == TollDodgeItemValueModOID_S)
			TollDodgeItemValueMod = value
			SetSliderOptionValue(TollDodgeItemValueModOID_S, TollDodgeItemValueMod)
		ElseIf Option == StorageUtil.GetIntValue(Self, "GateCurfewBeginOID_S")
			If value > (Game.GetFormFromFile(0x0EAB5B, "SL Survival.esp") as GlobalVariable).GetValue() ; _SLS_GateCurfewEnd
				(Game.GetFormFromFile(0x0EAB5A, "SL Survival.esp") as GlobalVariable).SetValue(value) ; _SLS_GateCurfewBegin
				SetSliderOptionValue(StorageUtil.GetIntValue(Self, "GateCurfewBeginOID_S"), value)
				TollUtil.IsCurfewTimeByLoc(PlayerRef.GetCurrentLocation())
			Else
				Debug.Messagebox("Curfew can not begin before it ends")
			EndIf
		ElseIf Option == StorageUtil.GetIntValue(Self, "GateCurfewEndOID_S")
			If value < (Game.GetFormFromFile(0x0EAB5A, "SL Survival.esp") as GlobalVariable).GetValue() ; _SLS_GateCurfewBegin
				(Game.GetFormFromFile(0x0EAB5B, "SL Survival.esp") as GlobalVariable).SetValue(value) ; _SLS_GateCurfewEnd
				SetSliderOptionValue(StorageUtil.GetIntValue(Self, "GateCurfewEndOID_S"), value)
				TollUtil.IsCurfewTimeByLoc(PlayerRef.GetCurrentLocation())
			Else
				Debug.Messagebox("Curfew can not end before it begins")
			EndIf
		ElseIf Option == StorageUtil.GetIntValue(Self, "GateCurfewSlavetownBeginOID_S")
			If value > (Game.GetFormFromFile(0x0EE156, "SL Survival.esp") as GlobalVariable).GetValue() ; _SLS_GateCurfewSlavetownEnd
				(Game.GetFormFromFile(0x0EE155, "SL Survival.esp") as GlobalVariable).SetValue(value) ; _SLS_GateCurfewSlavetownBegin
				SetSliderOptionValue(StorageUtil.GetIntValue(Self, "GateCurfewSlavetownBeginOID_S"), value)
				TollUtil.IsCurfewTimeByLoc(PlayerRef.GetCurrentLocation())
			Else
				Debug.Messagebox("Slavetown curfew can not begin before it ends")
			EndIf
		ElseIf Option == StorageUtil.GetIntValue(Self, "GateCurfewSlavetownEndOID_S")
			If value < (Game.GetFormFromFile(0x0EE155, "SL Survival.esp") as GlobalVariable).GetValue() ; _SLS_GateCurfewSlavetownBegin
				(Game.GetFormFromFile(0x0EE156, "SL Survival.esp") as GlobalVariable).SetValue(value) ; _SLS_GateCurfewSlavetownEnd
				SetSliderOptionValue(StorageUtil.GetIntValue(Self, "GateCurfewSlavetownEndOID_S"), value)
				TollUtil.IsCurfewTimeByLoc(PlayerRef.GetCurrentLocation())
			Else
				Debug.Messagebox("Slavetown curfew can not end before it begins")
			EndIf		
		ElseIf (option == TollFollowersOID_S)
			_SLS_TollFollowersRequired.SetValueInt(value as Int)
			SetSliderOptionValue(TollFollowersOID_S, _SLS_TollFollowersRequired.GetValueInt())
		EndIf
	
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pLicences1" ; <----------------->
		If (option == EnforcerRespawnDurOID_S)
			EnforcerRespawnDur = value
			SetSliderOptionValue(EnforcerRespawnDurOID_S, EnforcerRespawnDur)	
		ElseIf (option == TradeRestrictBribeOID_S)
			TradeRestrictBribe = value as Int
			SetSliderOptionValue(TradeRestrictBribeOID_S, TradeRestrictBribe)
			_SLS_RestrictTradeBribe.SetValueInt(TradeRestrictBribe)
			_SLS_LicenceTradersQuest.UpdateCurrentInstanceGlobal(_SLS_RestrictTradeBribe)
		ElseIf (option == LicUnlockCostOID_S)
			_SLS_LicUnlockCost.SetValueInt(value as Int)
			SetSliderOptionValue(LicUnlockCostOID_S, value)
			_SLS_LicenceQuest.UpdateCurrentInstanceGlobal(_SLS_LicUnlockCost)
		ElseIf (option == LicBlockChanceOID_S)
			LicBlockChance = value
			SetSliderOptionValue(LicBlockChanceOID_S, LicBlockChance)
			ModLicBuyBlock()
		
		ElseIf Option == StorageUtil.GetIntValue(Self, "WetLicenceDestroyChanceOID_S")
			LicUtil.DrenchLicDestroyChance = value
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "WetLicenceDestroyChanceOID_S"), LicUtil.DrenchLicDestroyChance)
			Frostfall.RegisterForDrenchEvent(LicUtil.DrenchLicDestroyChance as Bool)
		ElseIf Option == StorageUtil.GetIntValue(Self, "WetLicenceMaxToLoseOID_S")
			Frostfall.MaxLicsToLose = value as Int
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "WetLicenceMaxToLoseOID_S"), Frostfall.MaxLicsToLose)
			
		ElseIf (option == TollDodgeDetectDistTownMaxOID_S)
			GuardSpotDistTown = value
			SetSliderOptionValue(TollDodgeDetectDistTownMaxOID_S, GuardSpotDistTown)
			RefreshGuardSpotDistance()
		ElseIf (option == TollDodgeDisguiseBodyPenaltyOID_S)
			TollDodgeDisguiseBodyPenalty = value / 100.0
			SetSliderOptionValue(TollDodgeDisguiseBodyPenaltyOID_S, TollDodgeDisguiseBodyPenalty * 100.0)
			RefreshGuardSpotDistance()
		ElseIf (option == TollDodgeDisguiseHeadPenaltyOID_S)
			TollDodgeDisguiseHeadPenalty = value / 100.0
			SetSliderOptionValue(TollDodgeDisguiseHeadPenaltyOID_S, TollDodgeDisguiseHeadPenalty * 100.0)
			RefreshGuardSpotDistance()

		ElseIf (option == LicFactionDiscountOID_S)
			LicUtil.LicFactionDiscount = value/100.0
			SetSliderOptionValue(LicFactionDiscountOID_S, value)

		ElseIf (option == EnforcersMinOID_S)
			EnforcersMin = value as Int
			SetSliderOptionValue(EnforcersMinOID_S, EnforcersMin)
		ElseIf (option == EnforcersMaxOID_S)
			EnforcersMax = value as Int
			SetSliderOptionValue(EnforcersMaxOID_S, EnforcersMax)
		ElseIf Option == StorageUtil.GetIntValue(Self, "_SLS_EnforcerGuardsMinOID_S")
			(_SLS_LicTownCheckQuest as _SLS_LicTownCheck).EnforcerGuardsMin = value as Int
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "_SLS_EnforcerGuardsMinOID_S"), (_SLS_LicTownCheckQuest as _SLS_LicTownCheck).EnforcerGuardsMin)
		ElseIf Option == StorageUtil.GetIntValue(Self, "_SLS_EnforcerGuardsMaxOID_S")
			(_SLS_LicTownCheckQuest as _SLS_LicTownCheck).EnforcerGuardsMax = value as Int
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "_SLS_EnforcerGuardsMaxOID_S"), (_SLS_LicTownCheckQuest as _SLS_LicTownCheck).EnforcerGuardsMax)
		ElseIf (option == PersistentEnforcersOID_S)
			_SLS_LicInspPersistence.SetValueInt(value as Int)
			SetSliderOptionValue(PersistentEnforcersOID_S, value)
			_SLS_LicInspLostSightSpell.SetNthEffectDuration(0, _SLS_LicInspPersistence.GetValueInt())
		ElseIf Option == StorageUtil.GetIntValue(Self, "EnforcerChaseDistanceOID_S")
			(Game.GetFormFromFile(0x1118A1, "SL Survival.esp") as GlobalVariable).SetValue(Value)
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "EnforcerChaseDistanceOID_S"), value)
			
		ElseIf (option == LicShortDurOID_S)
			LicUtil.LicShortDur = value
			SetSliderOptionValue(LicShortDurOID_S, LicUtil.LicShortDur)
		ElseIf (option == LicLongDurOID_S)
			LicUtil.LicLongDur = value
			SetSliderOptionValue(LicLongDurOID_S, MaxTatsFeet)
			
		ElseIf (option == LicWeapShortCostOID_S)
			LicUtil.LicCostWeaponShort = value as Int
			SetSliderOptionValue(LicWeapShortCostOID_S, value)
		ElseIf (option == LicWeapLongCostOID_S)
			LicUtil.LicCostWeaponLong = value as Int
			SetSliderOptionValue(LicWeapLongCostOID_S, value)
		ElseIf (option == LicWeapPerCostOID_S)
			LicUtil.LicCostWeaponPer = value as Int
			SetSliderOptionValue(LicWeapPerCostOID_S, value)
		ElseIf Option == StorageUtil.GetIntValue(Self, "LicMagicCurseDrainTo")
			(Game.GetFormFromFile(0x10C223, "SL Survival.esp") as GlobalVariable).SetValue(value)
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "LicMagicCurseDrainTo"), value)
		ElseIf (option == LicMagicShortCostOID_S)
			LicUtil.LicCostMagicShort = value as Int
			SetSliderOptionValue(LicMagicShortCostOID_S, value)
		ElseIf (option == LicMagicLongCostOID_S)
			LicUtil.LicCostMagicLong = value as Int
			SetSliderOptionValue(LicMagicLongCostOID_S, value)
		ElseIf (option == LicMagicPerCostOID_S)
			LicUtil.LicCostMagicPer = value as Int
			SetSliderOptionValue(LicMagicPerCostOID_S, value)
			
		ElseIf (option == LicArmorShortCostOID_S)
			LicUtil.LicCostArmorShort = value as Int
			SetSliderOptionValue(LicArmorShortCostOID_S, value)
		ElseIf (option == LicArmorLongCostOID_S)
			LicUtil.LicCostArmorLong = value as Int
			SetSliderOptionValue(LicArmorLongCostOID_S, value)
		ElseIf (option == LicArmorPerCostOID_S)
			LicUtil.LicCostArmorPer = value as Int
			SetSliderOptionValue(LicArmorPerCostOID_S, value)

		ElseIf (option == LicBikiniHeelHeightOID_S)
			BikiniCurse.HeelHeightRequired = value
			SetSliderOptionValue(LicBikiniHeelHeightOID_S, value)
			DoToggleHeelsRequired = true
		ElseIf Option == StorageUtil.GetIntValue(Self, "LicBikiniBreathChanceOID_S")
			StorageUtil.SetFloatValue(None, "_SLS_LicBikOutOfBreathAnimChance", value)
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "LicBikiniBreathChanceOID_S"), value)
		ElseIf (option == LicBikiniShortCostOID_S)
			LicUtil.LicCostBikiniShort = value as Int
			SetSliderOptionValue(LicBikiniShortCostOID_S, value)
		ElseIf (option == LicBikiniLongCostOID_S)
			LicUtil.LicCostBikiniLong = value as Int
			SetSliderOptionValue(LicBikiniLongCostOID_S, value)
		ElseIf (option == LicBikiniPerCostOID_S)
			LicUtil.LicCostBikiniPer = value as Int
			SetSliderOptionValue(LicBikiniPerCostOID_S, value)
			
		ElseIf (option == LicClothesShortCostOID_S)
			LicUtil.LicCostClothesShort = value as Int
			SetSliderOptionValue(LicClothesShortCostOID_S, value)
		ElseIf (option == LicClothesLongCostOID_S)
			LicUtil.LicCostClothesLong = value as Int
			SetSliderOptionValue(LicClothesLongCostOID_S, value)
		ElseIf (option == LicClothesPerCostOID_S)
			LicUtil.LicCostClothesPer = value as Int
			SetSliderOptionValue(LicClothesPerCostOID_S, value)
		EndIf
		
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pLicences2" ; <----------------->
		If Option == StorageUtil.GetIntValue(Self, "LicCurfewShortCostOID_S")
			LicUtil.LicCostCurfewShort = value as Int
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "LicCurfewShortCostOID_S"), value)
		ElseIf Option == StorageUtil.GetIntValue(Self, "LicCurfewLongCostOID_S")
			LicUtil.LicCostCurfewLong = value as Int
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "LicCurfewLongCostOID_S"), value)
		ElseIf Option == StorageUtil.GetIntValue(Self, "LicCurfewPerCostOID_S")
			LicUtil.LicCostCurfewPer = value as Int
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "LicCurfewPerCostOID_S"), value)
			
		ElseIf Option == StorageUtil.GetIntValue(Self, "LicWhoreShortCostOID_S")
			LicUtil.LicCostWhoreShort = value as Int
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "LicWhoreShortCostOID_S"), value)
		ElseIf Option == StorageUtil.GetIntValue(Self, "LicWhoreLongCostOID_S")
			LicUtil.LicCostWhoreLong = value as Int
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "LicWhoreLongCostOID_S"), value)
		ElseIf Option == StorageUtil.GetIntValue(Self, "LicWhorePerCostOID_S")
			LicUtil.LicCostWhorePer = value as Int
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "LicWhorePerCostOID_S"), value)
			
		ElseIf Option == StorageUtil.GetIntValue(Self, "LicPropertyShortCostOID_S")
			LicUtil.LicCostPropertyShort = value as Int
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "LicPropertyShortCostOID_S"), value)
		ElseIf Option == StorageUtil.GetIntValue(Self, "LicPropertyLongCostOID_S")
			LicUtil.LicCostPropertyLong = value as Int
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "LicPropertyLongCostOID_S"), value)
		ElseIf Option == StorageUtil.GetIntValue(Self, "LicPropertyPerCostOID_S")
			LicUtil.LicCostPropertyPer = value as Int
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "LicPropertyPerCostOID_S"), value)
			
		ElseIf Option == StorageUtil.GetIntValue(Self, "LicFreedomShortCostOID_S")
			LicUtil.LicCostFreedomShort = value as Int
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "LicFreedomShortCostOID_S"), value)
		ElseIf Option == StorageUtil.GetIntValue(Self, "LicFreedomLongCostOID_S")
			LicUtil.LicCostFreedomLong = value as Int
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "LicFreedomLongCostOID_S"), value)
		ElseIf Option == StorageUtil.GetIntValue(Self, "LicFreedomPerCostOID_S")
			LicUtil.LicCostFreedomPer = value as Int
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "LicFreedomPerCostOID_S"), value)

		ElseIf Option == StorageUtil.GetIntValue(Self, "CurfewRestartDelayOID_S")
			(Game.GetFormFromFile(0x0E3F3D, "SL Survival.esp") as _SLS_Curfew).TimeToClearStreets = value
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "CurfewRestartDelayOID_S"), (Game.GetFormFromFile(0x0E3F3D, "SL Survival.esp") as _SLS_Curfew).TimeToClearStreets)
		ElseIf Option == StorageUtil.GetIntValue(Self, "CurfewBeginOID_S")
			If value > (Game.GetFormFromFile(0x07B44D, "SL Survival.esp") as GlobalVariable).GetValue() ; _SLS_CurfewEnd
				(Game.GetFormFromFile(0x07B44C, "SL Survival.esp") as GlobalVariable).SetValue(value) ; _SLS_CurfewBegin
				SetSliderOptionValue(StorageUtil.GetIntValue(Self, "CurfewBeginOID_S"), value)
				(Game.GetFormFromFile(0x0E3F3D, "SL Survival.esp") as _SLS_Curfew).CheckCurfewState()
			Else
				Debug.Messagebox("Curfew can not begin before it ends")
			EndIf
		ElseIf Option == StorageUtil.GetIntValue(Self, "CurfewEndOID_S")
			If value < (Game.GetFormFromFile(0x07B44C, "SL Survival.esp") as GlobalVariable).GetValue() ; _SLS_CurfewBegin
				(Game.GetFormFromFile(0x07B44D, "SL Survival.esp") as GlobalVariable).SetValue(value) ; _SLS_CurfewEnd
				SetSliderOptionValue(StorageUtil.GetIntValue(Self, "CurfewEndOID_S"), value)
				(Game.GetFormFromFile(0x0E3F3D, "SL Survival.esp") as _SLS_Curfew).CheckCurfewState()
			Else
				Debug.Messagebox("Curfew can not end before it begins")
			EndIf
		ElseIf Option == StorageUtil.GetIntValue(Self, "CurfewSlavetownBeginOID_S")
			If value > (Game.GetFormFromFile(0x0ECBC1, "SL Survival.esp") as GlobalVariable).GetValue() ; _SLS_CurfewSlavetownEnd
				(Game.GetFormFromFile(0x0ECBC0, "SL Survival.esp") as GlobalVariable).SetValue(value) ; _SLS_CurfewSlavetownBegin
				SetSliderOptionValue(StorageUtil.GetIntValue(Self, "CurfewSlavetownBeginOID_S"), value)
				(Game.GetFormFromFile(0x0E3F3D, "SL Survival.esp") as _SLS_Curfew).CheckCurfewState()
			Else
				Debug.Messagebox("Slavetown curfew can not begin before it ends")
			EndIf
		ElseIf Option == StorageUtil.GetIntValue(Self, "CurfewSlavetownEndOID_S")
			If value < (Game.GetFormFromFile(0x0ECBC0, "SL Survival.esp") as GlobalVariable).GetValue() ; _SLS_CurfewSlavetownBegin
				(Game.GetFormFromFile(0x0ECBC1, "SL Survival.esp") as GlobalVariable).SetValue(value) ; _SLS_CurfewSlavetownEnd
				SetSliderOptionValue(StorageUtil.GetIntValue(Self, "CurfewSlavetownEndOID_S"), value)
				(Game.GetFormFromFile(0x0E3F3D, "SL Survival.esp") as _SLS_Curfew).CheckCurfewState()
			Else
				Debug.Messagebox("Slavetown curfew can not end before it begins")
			EndIf
		EndIf
		
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pStashes" ; <----------------->
		If (option == RoadDistOID_S)
			RoadDist = value
			SetSliderOptionValue(RoadDistOID_S, RoadDist)
		ElseIf (option == StealXItemsOID_S)
			StealXItems = value
			SetSliderOptionValue(StealXItemsOID_S, StealXItems)
		EndIf
	
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pBeggingKennel" ; <----------------->
		If (option == BegNumItemsOID_S)
			BegNumItems = value as Int
			SetSliderOptionValue(BegNumItemsOID_S, BegNumItems)
		ElseIf (option == BegGoldOID_S)
			BegGold = value
			SetSliderOptionValue(BegGoldOID_S, BegGold)
		ElseIf (option == BegMwaCurseChanceOID_S)
			BegMwaCurseChance = value
			SetSliderOptionValue(BegMwaCurseChanceOID_S, BegMwaCurseChance)
		ElseIf (option == KennelSafeCellCostOID_S)
			KennelSafeCellCost = value as Int
			SetSliderOptionValue(KennelSafeCellCostOID_S, KennelSafeCellCost)
			_SLS_KennelCellCost.SetValueInt(KennelSafeCellCost)
		ElseIf (option == KennelCreatureChanceOID_S)
			KennelCreatureChance = value
			SetSliderOptionValue(KennelCreatureChanceOID_S, KennelCreatureChance)
		ElseIf (option == KennelRapeChancePerHourOID_S)
			KennelRapeChancePerHour = value
			SetSliderOptionValue(KennelRapeChancePerHourOID_S, KennelRapeChancePerHour)
		ElseIf (option == KennelSlaveRapeTimeMinOID_S)
			KennelSlaveRapeTimeMin = value as Int
			SetSliderOptionValue(KennelSlaveRapeTimeMinOID_S, KennelSlaveRapeTimeMin)
		ElseIf (option == KennelSlaveRapeTimeMaxOID_S)
			KennelSlaveRapeTimeMax = value as Int
			SetSliderOptionValue(KennelSlaveRapeTimeMaxOID_S, KennelSlaveRapeTimeMax)
		ElseIf Option == StorageUtil.GetIntValue(Self, "KennelSlaveDeviceCountMinOID_S")
			StorageUtil.SetIntValue(Self, "KennelSlaveDeviceCountMin", value as Int)
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "KennelSlaveDeviceCountMinOID_S"), StorageUtil.GetIntValue(Self, "KennelSlaveDeviceCountMin", Missing = 2))
		ElseIf Option == StorageUtil.GetIntValue(Self, "KennelSlaveDeviceCountMaxOID_S")
			StorageUtil.SetIntValue(Self, "KennelSlaveDeviceCountMax", value as Int)
			SetSliderOptionValue(StorageUtil.GetIntValue(Self, "KennelSlaveDeviceCountMaxOID_S"), StorageUtil.GetIntValue(Self, "KennelSlaveDeviceCountMax", Missing = 6))
		EndIf
		
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pPickpocketDismemberment" ; <----------------->
		If (option == PpGoldLowChanceOID_S)
			PpGoldLowChance = value
			SetSliderOptionValue(PpGoldLowChanceOID_S, PpGoldLowChance)
			DoPpLvlListbuildOnClose = true
		ElseIf (option == PpGoldModerateChanceOID_S)
			PpGoldModerateChance = value
			SetSliderOptionValue(PpGoldModerateChanceOID_S, PpGoldModerateChance)
			DoPpLvlListbuildOnClose = true
		ElseIf (option == PpGoldHighChanceOID_S)
			PpGoldHighChance = value
			SetSliderOptionValue(PpGoldHighChanceOID_S, PpGoldHighChance)
			DoPpLvlListbuildOnClose = true

		ElseIf (option == PpLootMinOID_S)
			Util.PpLootLootMin = value as Int
			SetSliderOptionValue(PpLootMinOID_S, Util.PpLootLootMin)
		ElseIf (option == PpLootMaxOID_S)
			Util.PpLootLootMax = value as Int
			SetSliderOptionValue(PpLootMaxOID_S, Util.PpLootLootMax)

		ElseIf (option == PpLootFoodChanceOID_S)
			PpLootFoodChance = value
			SetSliderOptionValue(PpLootFoodChanceOID_S, PpLootFoodChance)
			DoPpLvlListbuildOnClose = true
		ElseIf (option == PpLootGemsChanceOID_S)
			PpLootGemsChance = value
			SetSliderOptionValue(PpLootGemsChanceOID_S, PpLootGemsChance)
			DoPpLvlListbuildOnClose = true
		ElseIf (option == PpLootSoulgemsChanceOID_S)
			PpLootSoulgemsChance = value
			SetSliderOptionValue(PpLootSoulgemsChanceOID_S, PpLootSoulgemsChance)
			DoPpLvlListbuildOnClose = true
		ElseIf (option == PpLootJewelryChanceOID_S)
			PpLootJewelryChance = value
			SetSliderOptionValue(PpLootJewelryChanceOID_S, PpLootJewelryChance)
			DoPpLvlListbuildOnClose = true
		ElseIf (option == PpLootEnchJewelryChanceOID_S)
			PpLootEnchJewelryChance = value
			SetSliderOptionValue(PpLootEnchJewelryChanceOID_S, PpLootEnchJewelryChance)
			DoPpLvlListbuildOnClose = true
		ElseIf (option == PpLootPotionsChanceOID_S)
			PpLootPotionsChance = value
			SetSliderOptionValue(PpLootPotionsChanceOID_S, PpLootPotionsChance)
			DoPpLvlListbuildOnClose = true
		ElseIf (option == PpLootKeysChanceOID_S)
			PpLootKeysChance = value
			SetSliderOptionValue(PpLootKeysChanceOID_S, PpLootKeysChance)
			DoPpLvlListbuildOnClose = true
		ElseIf (option == PpLootTomesChanceOID_S)
			PpLootTomesChance = value
			SetSliderOptionValue(PpLootTomesChanceOID_S, PpLootTomesChance)
			DoPpLvlListbuildOnClose = true
		ElseIf (option == PpLootCureChanceOID_S)
			PpLootCureChance = value
			SetSliderOptionValue(PpLootCureChanceOID_S, PpLootCureChance)
			DoPpLvlListbuildOnClose = true
		
		ElseIf (option == PpCrimeGoldOID_S)
			PpCrimeGold = value as Int
			SetSliderOptionValue(PpCrimeGoldOID_S, PpCrimeGold)
			Game.SetGameSettingInt("iCrimeGoldPickpocket", PpCrimeGold)
		ElseIf (option == PpFailDevicesOID_S)
			Init.PpFailDevices = value as Int
			SetSliderOptionValue(PpFailDevicesOID_S, Init.PpFailDevices)
		ElseIf (option == PpFailStealValueOID_S)
			_SLS_PickPocketFailStealValue.SetValueInt(value as Int)
			SetSliderOptionValue(PpFailStealValueOID_S, value)
		ElseIf (option == PpFailDrugCountOID_S)
			PpFailDrugCount = value as Int
			SetSliderOptionValue(PpFailDrugCountOID_S, PpFailDrugCount)
		
		ElseIf (option == DismemberCooldownOID_S)
			DismemberCooldown = value
			SetSliderOptionValue(DismemberCooldownOID_S, value)
		ElseIf (option == DismemberMaxAmpedLimbsOID_S)
			MaxAmpedLimbs = value as Int
			SetSliderOptionValue(DismemberMaxAmpedLimbsOID_S, value)
		ElseIf (option == DismemberArmorBonusOID_S)
			DismemberArmorBonus = value
			SetSliderOptionValue(DismemberArmorBonusOID_S, value)
		ElseIf (option == DismemberChanceOID_S)
			DismemberChance = value
			SetSliderOptionValue(DismemberChanceOID_S, value)
		ElseIf (option == DismemberDamageThresOID_S)
			DismemberDamageThres = value as Int
			SetSliderOptionValue(DismemberDamageThresOID_S, value)
		ElseIf (option == DismemberHealthThresOID_S)
			DismemberHealthThres = value
			SetSliderOptionValue(DismemberHealthThresOID_S, value)
		ElseIf (option == AmpPriestHealCostOID_S)
			_SLS_AmpPriestHealCost.SetValueInt(value as Int)
			SetSliderOptionValue(AmpPriestHealCostOID_S, value)
			_SLS_AmputationQuest.UpdateCurrentInstanceGlobal(_SLS_AmpPriestHealCost)	
		EndIf
	
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pBikiniArmorsExp" ; <----------------->
		If (option == BikiniDropsVendorCityOID_S)
			BikiniDropsVendorCity = value as Int
			SetSliderOptionValue(BikiniDropsVendorCityOID_S, BikiniDropsVendorCity)
		ElseIf (option == BikiniDropsVendorTownOID_S)
			BikiniDropsVendorTown = value as Int
			SetSliderOptionValue(BikiniDropsVendorTownOID_S, BikiniDropsVendorTown)
		ElseIf (option == BikiniDropsVendorKhajiitOID_S)
			BikiniDropsVendorKhajiit = value as Int
			SetSliderOptionValue(BikiniDropsVendorKhajiitOID_S, BikiniDropsVendorKhajiit)
		ElseIf (option == BikiniDropsChestOID_S)
			BikiniDropsChest = value as Int
			SetSliderOptionValue(BikiniDropsChestOID_S, BikiniDropsChest)
		ElseIf (option == BikiniDropsChestOrnateOID_S)
			BikiniDropsChestOrnate = value as Int
			SetSliderOptionValue(BikiniDropsChestOrnateOID_S, BikiniDropsChestOrnate)
			
		ElseIf (option == BikiniExpTrainOID_S)
			BikTrainingSpeed = value
			SetSliderOptionValue(BikiniExpTrainOID_S, BikTrainingSpeed)
		ElseIf (option == BikiniExpPerLevelOID_S)
			BikiniExp.ExpPerLevel = value
			SetSliderOptionValue(BikiniExpPerLevelOID_S, BikiniExp.ExpPerLevel)
		ElseIf (option == BikiniExpUntrainOID_S)
			BikUntrainingSpeed = value
			SetSliderOptionValue(BikiniExpUntrainOID_S, BikUntrainingSpeed)
			
		ElseIf (option == BikiniChanceHideOID_S)
			BikiniChanceHide = value
			SetSliderOptionValue(BikiniChanceHideOID_S, BikiniChanceHide)
		ElseIf (option == BikiniChanceLeatherOID_S)
			BikiniChanceLeather = value
			SetSliderOptionValue(BikiniChanceLeatherOID_S, BikiniChanceLeather)
		ElseIf (option == BikiniChanceIronOID_S)
			BikiniChanceIron = value
			SetSliderOptionValue(BikiniChanceIronOID_S, BikiniChanceIron)
		ElseIf (option == BikiniChanceSteelOID_S)
			BikiniChanceSteel = value
			SetSliderOptionValue(BikiniChanceSteelOID_S, BikiniChanceSteel)
		ElseIf (option == BikiniChanceSteelPlateOID_S)
			BikiniChanceSteelPlate = value
			SetSliderOptionValue(BikiniChanceSteelPlateOID_S, BikiniChanceSteelPlate)
		ElseIf (option == BikiniChanceDwarvenOID_S)
			BikiniChanceDwarven = value
			SetSliderOptionValue(BikiniChanceDwarvenOID_S, BikiniChanceDwarven)
		ElseIf (option == BikiniChanceFalmerOID_S)
			BikiniChanceFalmer = value
			SetSliderOptionValue(BikiniChanceFalmerOID_S, BikiniChanceFalmer)
		ElseIf (option == BikiniChanceWolfOID_S)
			BikiniChanceWolf = value
			SetSliderOptionValue(BikiniChanceWolfOID_S, BikiniChanceWolf)
		ElseIf (option == BikiniChanceBladesOID_S)
			BikiniChanceBlades = value
			SetSliderOptionValue(BikiniChanceBladesOID_S, BikiniChanceBlades)
		ElseIf (option == BikiniChanceEbonyOID_S)
			BikiniChanceEbony = value
			SetSliderOptionValue(BikiniChanceEbonyOID_S, BikiniChanceEbony)
		ElseIf (option == BikiniChanceDragonboneOID_S)
			BikiniChanceDragonbone = value
			SetSliderOptionValue(BikiniChanceDragonboneOID_S, BikiniChanceDragonbone)
		EndIf
		
	; Inn Prices
	ElseIf StorageUtil.GetStringValue(Self, "CurrentPage") == "$SLS_pInnRoomPrices" ; <----------------->
		String InnLoc
		Int i = 0
		While i < LocTrack.InnCosts.Length
			InnLoc = StorageUtil.StringListGet(LocTrack, "_SLS_LocIndex", i)
			If Option == StorageUtil.GetIntValue(Self, "InnCost" + InnLoc + "OID_S")
				LocTrack.InnCosts[i] = Value as Int
				SetSliderOptionValue(StorageUtil.GetIntValue(LocTrack, "InnCost" + InnLoc + "OID_S"), LocTrack.InnCosts[i])
				LocTrack.SetInnCostByString(LocTrack.PlayerCurrentLocString)
			EndIf
			i += 1
		EndWhile
	EndIf
	ForcePageReset()
EndEvent

; Functions Begin =======================================================

Function ToggleTollGateLocks() ; Lock: True - Lock, False - Unlock
;/
	(_SLS_TollGateWhiterunInside as SLS_TollGate).ToggleDoorLocks(DoorLockDownT)
	(_SLS_TollGateSolitudeInside as SLS_TollGate).ToggleDoorLocks(DoorLockDownT)
	(_SLS_TollGateRiftenMainInside as SLS_TollGate).ToggleDoorLocks(DoorLockDownT)
	(_SLS_TollGateWindhelmInterior as SLS_TollGate).ToggleDoorLocks(DoorLockDownT)
	(_SLS_TollGateMarkarthInterior as SLS_TollGate).ToggleDoorLocks(DoorLockDownT)
	/;
	
	TollUtil.ToggleDoorLocks(_SLS_TollGateWhiterunInside.GetReference(), (DoorLockDownT && Init.TollEnable))
	TollUtil.ToggleDoorLocks(_SLS_TollGateSolitudeInside.GetReference(), (DoorLockDownT && Init.TollEnable))
	TollUtil.ToggleDoorLocks(_SLS_TollGateRiftenMainInside.GetReference(), (DoorLockDownT && Init.TollEnable))
	TollUtil.ToggleDoorLocks(_SLS_TollGateWindhelmInterior.GetReference(), (DoorLockDownT && Init.TollEnable))
	TollUtil.ToggleDoorLocks(_SLS_TollGateMarkarthInterior.GetReference(), (DoorLockDownT && Init.TollEnable))
EndFunction

Function RestartInterfacePrompt(String IntSelect)
	If IntSelect == "RealisticNeedsandDiseases.esp"
		If Game.GetModByName(IntSelect) != 255
			RestartInterface(Game.GetFormFromFile(0x03AA30, "SL Survival.esp") as Quest)
		Else
			RestartIntErrorMsg(IntSelect)
		EndIf
	
	ElseIf IntSelect == "iNeed.esp"
		If Game.GetModByName(IntSelect) != 255
			RestartInterface(Game.GetFormFromFile(0x03EADE, "SL Survival.esp") as Quest)
		Else
			RestartIntErrorMsg(IntSelect)
		EndIf
		
	ElseIf IntSelect == "Devious Devices - Expansion.esm"
		If Game.GetModByName(IntSelect) != 255
			RestartInterface(Game.GetFormFromFile(0x040068, "SL Survival.esp") as Quest)
		Else
			RestartIntErrorMsg(IntSelect)
		EndIf
		
	ElseIf IntSelect == "Frostfall.esp"
		If Game.GetModByName(IntSelect) != 255
			RestartInterface(Game.GetFormFromFile(0x03CA81, "SL Survival.esp") as Quest)
		Else
			RestartIntErrorMsg(IntSelect)
		EndIf
		
	ElseIf IntSelect == "SexLab_PaySexCrime.esp"
		If Game.GetModByName(IntSelect) != 255
			RestartInterface(Game.GetFormFromFile(0x040B2D, "SL Survival.esp") as Quest)
		Else
			RestartIntErrorMsg(IntSelect)
		EndIf
	
	ElseIf IntSelect == "Slaverun_Reloaded.esp"
		If Game.GetModByName(IntSelect) != 255
			RestartInterface(Game.GetFormFromFile(0x03F041, "SL Survival.esp") as Quest)
		Else
			RestartIntErrorMsg(IntSelect)
		EndIf
		
	ElseIf IntSelect == "EFFCore.esm"
		If Game.GetModByName(IntSelect) != 255
			RestartInterface(Game.GetFormFromFile(0x057C3C, "SL Survival.esp") as Quest)
		Else
			RestartIntErrorMsg(IntSelect)
		EndIf

	ElseIf IntSelect == "dcc-soulgem-oven-000.esm"
		If Game.GetModByName(IntSelect) != 255
			RestartInterface(Game.GetFormFromFile(0x063A97, "SL Survival.esp") as Quest)
		Else
			RestartIntErrorMsg(IntSelect)
		EndIf
		
	ElseIf IntSelect == "sr_FillHerUp.esp"
		If Game.GetModByName(IntSelect) != 255
			RestartInterface(Game.GetFormFromFile(0x063A98, "SL Survival.esp") as Quest)
		Else
			RestartIntErrorMsg(IntSelect)
		EndIf
		
	ElseIf IntSelect == "Amputator.esm"
		If Game.GetModByName(IntSelect) != 255
			RestartInterface(Game.GetFormFromFile(0x069BC0, "SL Survival.esp") as Quest)
		Else
			RestartIntErrorMsg(IntSelect)
		EndIf
		
	ElseIf IntSelect == "Apropos2.esp"
		If Game.GetModByName(IntSelect) != 255
			RestartInterface(Game.GetFormFromFile(0x0707CE, "SL Survival.esp") as Quest)
		Else
			RestartIntErrorMsg(IntSelect)
		EndIf
		
	ElseIf IntSelect == "SlaveTats.esp"
		If Game.GetModByName(IntSelect) != 255
			RestartInterface(Game.GetFormFromFile(0x0732E3, "SL Survival.esp") as Quest)
		Else
			RestartIntErrorMsg(IntSelect)
		EndIf
		
	ElseIf IntSelect == "Milk Addict.esp"
		If Game.GetModByName(IntSelect) != 255
			RestartInterface(Game.GetFormFromFile(0x07995C, "SL Survival.esp") as Quest)
		Else
			RestartIntErrorMsg(IntSelect)
		EndIf
		
	ElseIf IntSelect == "SexLabAroused.esm"
		If Game.GetModByName(IntSelect) != 255
			RestartInterface(Game.GetFormFromFile(0x07DF73, "SL Survival.esp") as Quest)
		Else
			RestartIntErrorMsg(IntSelect)
		EndIf
		
	ElseIf IntSelect == "DeviousFollowers.esp"
		If Game.GetModByName(IntSelect) != 255
			RestartInterface(Game.GetFormFromFile(0x07EF9A, "SL Survival.esp") as Quest)
		Else
			RestartIntErrorMsg(IntSelect)
		EndIf

	ElseIf IntSelect == "SexLab - Sexual Fame [SLSF].esm"
		If Game.GetModByName(IntSelect) != 255
			RestartInterface(Game.GetFormFromFile(0x0840A1, "SL Survival.esp") as Quest)
		Else
			RestartIntErrorMsg(IntSelect)
		EndIf
		
	ElseIf IntSelect == "Slso.esp"
		If Game.GetModByName(IntSelect) != 255
			RestartInterface(Game.GetFormFromFile(0x0A62A4, "SL Survival.esp") as Quest)
		Else
			RestartIntErrorMsg(IntSelect)
		EndIf
	
	ElseIf IntSelect == "EatingSleepingDrinking.esp"
		If Game.GetModByName(IntSelect) != 255
			RestartInterface(Game.GetFormFromFile(0x0A8307, "SL Survival.esp") as Quest)
		Else
			RestartIntErrorMsg(IntSelect)
		EndIf
		
	ElseIf IntSelect == "Spank That Ass.esp"
		If Game.GetModByName(IntSelect) != 255
			RestartInterface(Game.GetFormFromFile(0x0A8DCD, "SL Survival.esp") as Quest)
		Else
			RestartIntErrorMsg(IntSelect)
		EndIf
		
	ElseIf IntSelect == "FNISSexyMove.esp"
		If Game.GetModByName(IntSelect) != 255
			RestartInterface(Game.GetFormFromFile(0x0BCB05, "SL Survival.esp") as Quest)
		Else
			RestartIntErrorMsg(IntSelect)
		EndIf
		
	ElseIf IntSelect == "Bathing in Skyrim - Main.esp"
		If Game.GetModByName(IntSelect) != 255
			RestartInterface(Game.GetFormFromFile(0x0BC03D, "SL Survival.esp") as Quest)
		Else
			RestartIntErrorMsg(IntSelect)
		EndIf
		
	Else
		Debug.Trace("_SLS_: RestartInterfacePrompt: Unknown interface")
	EndIf
EndFunction

Function RestartIntErrorMsg(String ModName)
	Debug.Messagebox(ModName + " not found in load order")
EndFunction

Function RestartInterface(Quest IntSelect)
	If ShowMessage("Restart the interface?\nYou may need to exit the menu to apply changes.")
		IntSelect.Stop()
		Utility.WaitMenuMode(0.2)
		IntSelect.Start()
		Debug.Messagebox("Interface restarted:\n" + IntSelect + "\n\nPlease save your game, reload it and wait 5 seconds for the interface to start up")
	EndIf
EndFunction

Function SetSaltyCum(Bool SaltyCum)
	If SaltyCum
		Needs.SaltyCum = -1.0
	Else
		Needs.SaltyCum = 1.0
	EndIf
EndFunction

Function TogglePushPlayer()
	If PushEvents > 0
		(Game.GetFormFromFile(0x01C58E, "SL Survival.esp") as Quest).Start() ; _SLS_PushPlayer
		(Game.GetFormFromFile(0x0E651A, "SL Survival.esp") as Quest).Start() ; _SLS_PushPlayerProximity
		(Game.GetFormFromFile(0x0E6A8D, "SL Survival.esp") as GlobalVariable).SetValueInt(0)
	Else
		(Game.GetFormFromFile(0x01C58E, "SL Survival.esp") as Quest).Stop() ; _SLS_PushPlayer
		(Game.GetFormFromFile(0x0E651A, "SL Survival.esp") as Quest).Stop() ; _SLS_PushPlayerProximity
	EndIf
EndFunction

Function ToggleAssSlapping()
	If AssSlappingEvents
		_SLS_AssSlapQuest.Start()
	Else
		_SLS_AssSlapQuest.Stop()
	EndIf
EndFunction

Function ToggleMinAV()
	If MinAvToggleT
		MinAv.StartUp()
		PlayerRef.AddSpell(_SLS_WeaponReadySpell, false)
	Else
		MinAv.Shutdown()
		If !GuardBehavWeapDrawn ; If both MinAv and Guard behaviour weapons drawn is off remove weapon ready spell - not needed.
			PlayerRef.RemoveSpell(_SLS_WeaponReadySpell)
		EndIf
	EndIf
EndFunction

Function UpdateBellyScale()
	Gluttony.BellyScaleUpdate()
EndFunction

Function ToggleBellyInflation()
	If !CanEnableSnowberry() ; Has left the alternate start cell (game time updates can be registered)
		If BellyScaleEnable
			If IsInMcm
				Debug.Messagebox("Please exit the menu to apply changes")
			EndIf
			_SLS_BellyInflationQuest.Start()
		Else
			Gluttony.Shutdown()
			_SLS_BellyInflationQuest.Stop()
		EndIf
	EndIf
EndFunction

Function ToggleLicences(Bool Enabled)
	Int i = _SLS_LicenceGateActList.GetSize()
	ObjectReference ObjRef
	
	; Disable/Enable gate activators
	While i > 0
		i -= 1
		ObjRef = _SLS_LicenceGateActList.GetAt(i) as ObjectReference
		If ObjRef
			If Enabled
				ObjRef.Enable()
			Else
				ObjRef.Disable()
			EndIf
		EndIf
	EndWhile
	If Game.GetModByName("JKs Skyrim.esp") != 255 ; Enable/Disable the extra activator at the riften side door
		If Enabled
			_SLS_LicenceGateActJkRef.Enable()
		Else
			_SLS_LicenceGateActJkRef.Disable()
		EndIf
	Else
		_SLS_LicenceGateActJkRef.Disable()
	EndIf
	
	; Remove licences
	If !Enabled
		i = _SLS_LicenceAliases.GetNumAliases()
		While i > 0
			i -= 1
			ObjRef = (_SLS_LicenceAliases.GetNthAlias(i) as ReferenceAlias).GetReference()
			If ObjRef && ObjRef.GetBaseObject() as Book
				_SLS_LicenceDumpRef.AddItem(ObjRef)
			EndIf
		EndWhile
	EndIf
	
	ToggleCurfew(Enabled && LicUtil.LicCurfewEnable)
	
	; Disable/Enable enforcers + system
	If Enabled
		_SLS_LicTownCheckEnforcerAliases.Start()
		_SLS_LicTownCheckPlayerAliasQuest.Start()
		_SLS_LicTownCheckQuest.Start()
		Utility.Wait(2.0) ; Wait for quest aliases to fill just in case
		i = _SLS_LicTownCheckEnforcerAliases.GetNumAliases()
		Actor Enforcer
		While i > 0
			i -= 1
			Enforcer = (_SLS_LicTownCheckEnforcerAliases.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
			If Enforcer
				Enforcer.Enable()
			EndIf
		EndWhile
		
	Else
		i = _SLS_LicTownCheckEnforcerAliases.GetNumAliases()
		Actor Enforcer
		While i > 0
			i -= 1
			Enforcer = (_SLS_LicTownCheckEnforcerAliases.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
			If Enforcer
				Enforcer.Disable()
			EndIf
		EndWhile
		_SLS_LicTownCheckQuest.Stop()
		_SLS_LicTownCheckPlayerAliasQuest.Stop()
		_SLS_LicTownCheckEnforcerAliases.Stop()
		(Game.GetFormFromFile(0x11085E, "SL Survival.esp") as Quest).Stop() ; _SLS_LicTownCheckGuardAliases
		(Game.GetFormFromFile(0x058C90, "SL Survival.esp") as GlobalVariable).SetValueInt(0) ; _SLS_LicTownViolation
	EndIf
	ToggleTollGateGuards()	
	
	If !Enabled
		TradeRestrictions = false
	EndIf
	ToggleTradeRestrictions()
	ToggleFolContraBlock()
	
	
	If !Enabled
		LicUtil.LicCurfewEnable = false
		LicUtil.LicWhoreEnable = false
		LicUtil.LicPropertyEnable = false
		LicUtil.LicFreedomEnable = 0
	EndIf
	LicenceToggleToggled()
	
	ToggleCurfew(LicUtil.LicCurfewEnable)
	Eviction.UpdateEvictions(DoImmediately = true)
	Debug.Messagebox("Licence change complete")
EndFunction

Function ToggleTollGateGuards()
	Quest akQuest = Game.GetFormFromFile(0x0A0BFC, "SL Survival.esp") as Quest ; _SLS_LicenceTollGuyPackAliases
	Bool EnableThem = false
	If Init.TollEnable || Init.LicencesEnable
		EnableThem = true
	EndIf
	
	Actor akGuard
	Int i = 0
	While i < akQuest.GetNumAliases()
		akGuard = (akQuest.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
		If EnableThem
			akGuard.Enable()
		Else
			akGuard.Disable()
		EndIf
		i += 1
	EndWhile
EndFunction

Function ToggleCompassMechanics()
	If CompassMechanics
		_SLS_MapAndCompassQuest.Start()
	Else
		Compass.ToggleCompass(true)
		_SLS_MapAndCompassQuest.Stop()
	EndIf
EndFunction

Function ToggleSleepDepriv()
	If SleepDepriv
		_SLS_SleepDeprivationQuest.Start()
		Needs.ToggleSleepDepriv(SleepDepriv)
	Else
		_SLS_SleepDeprivationQuest.Stop()
		Needs.ToggleSleepDepriv(SleepDepriv)
	EndIf
EndFunction

Function DoSlaverunInit()
	_SLS_SlaverunKickerQuest.Stop()
	_SLS_SlaverunKickerQuest.Start()
EndFunction

Function ToggleHalfNakedCover()
	If HalfNakedEnable
		_SLS_HalfNakedCoverQuest.Start()
	Else
		PlayerRef.UnequipItem(HalfNakedCover._SLS_HalfNakedCoverArmor, abPreventEquip = false, abSilent = true)
		PlayerRef.Removeitem(HalfNakedCover._SLS_HalfNakedCoverArmor, aiCount = PlayerRef.GetItemCount(HalfNakedCover._SLS_HalfNakedCoverArmor), abSilent = true)
		_SLS_HalfNakedCoverQuest.Stop()
	EndIf
EndFunction

Function CheckHalfNakedCover()
	HalfNakedCover.BraSlot = HalfNakedBra
	HalfNakedCover.PantySlot = HalfNakedPanty
	If HalfNakedEnable
		HalfNakedCover.CheckCover()
	EndIf
EndFunction

Function ToggleHalfNakedStrips()
	HalfNakedCover.CoverStripsCuirass = HalfNakedStrips
EndFunction

Function ToggleDeviousEffects()
	DeviousEffects.Shutdown()
	If DeviousEffectsEnable
		_SLS_DeviousEffectsQuest.Start()
	EndIf
EndFunction

Function ToggleTollDodging()
	If TollDodging
		_SLS_TollDodgeHuntQuest.Stop()
		_SLS_TollDodgeQuest.Start()
	Else
		_SLS_TollDodgeHuntQuest.Stop()
		_SLS_TollDodgeQuest.Stop()
		
		If GuardBehavArmorEquip ; turn off guard warnings for having armor equipped as well - piggy backs off toll evasion cell detection
			GuardBehavArmorEquip = false
		EndIf
		If GuardBehavWeapEquip
			GuardBehavWeapEquip = false
		EndIf
	EndIf
EndFunction

Function RefreshGuardSpotDistance()
	DodgeDisguise.ProcArmorChange()
EndFunction
;/
Function SetTollCost()
	Bool IsFreeTown = true
	
	If TollDodge.LastTollLocation != ""
		If TollDodge.LastTollLocation == "Whiterun"
			IsFreeTown = Slaverun.IsFreeTownWhiterun()
		ElseIf TollDodge.LastTollLocation == "Riften"
			IsFreeTown = Slaverun.IsFreeTownRiften()
		ElseIf TollDodge.LastTollLocation == "Windhelm"
			IsFreeTown = Slaverun.IsFreeTownWindhelm()
		ElseIf TollDodge.LastTollLocation == "Markarth"
			IsFreeTown = Slaverun.IsFreeTownMarkarth()
		ElseIf TollDodge.LastTollLocation == "Solitude"
			IsFreeTown = Slaverun.IsFreeTownSolitude()
		EndIf
	EndIf

	Float EnslavedTownFactor 
	If IsFreeTown
		EnslavedTownFactor = 1.0
	Else
		EnslavedTownFactor = SlaverunFactor * ((!IsFreeTown) as Int)
	EndIf

	;Debug.Messagebox("EnslavedTownFactor: " + EnslavedTownFactor)

	If GoldPerLevelT
		_SLS_TollCost.SetValueInt((TollCostGold * PlayerRef.GetLevel() * EnslavedTownFactor) as Int)
	Else
		_SLS_TollCost.SetValueInt((TollCostGold * EnslavedTownFactor) as Int)
	EndIf
	;Debug.Messagebox("Toll cost: " + _SLS_TollCost.GetValueInt())
EndFunction
/;
Function TryHardcoreToggle()
	If HardcoreToggleAllowed()
		HardcoreMode = !HardcoreMode
	EndIf
	SetToggleOptionValue(HardcoreModeOID, HardcoreMode)

	If HardcoreMode
		IsHardcoreLocked = true
	Else
		IsHardcoreLocked = false
	EndIf
EndFunction

Bool Function HardcoreToggleAllowed()
	If HardcoreMode
		Int HighestCost = LicUtil.LicCostWeaponShort
		If LicUtil.LicCostArmorShort > HighestCost
			HighestCost = LicUtil.LicCostArmorShort
		EndIf
		If LicUtil.LicMagicEnable
			If LicUtil.LicCostMagicShort > HighestCost
				HighestCost = LicUtil.LicCostMagicShort
			EndIf
		EndIf
		If LicUtil.LicBikiniEnable
			If LicUtil.LicCostBikiniShort > HighestCost
				HighestCost = LicUtil.LicCostBikiniShort
			EndIf
		EndIf
		If LicUtil.LicClothesEnable != 0
			If LicUtil.LicCostClothesShort > HighestCost
				HighestCost = LicUtil.LicCostClothesShort
			EndIf
		EndIf
		
		Int TollCost = _SLS_TollCost.GetValueInt()
		If TollCost > HighestCost
			HighestCost = TollCost
		EndIf
		
		If PlayerRef.GetItemCount(Gold001) >= HighestCost
			Return true
		Else
			Debug.Messagebox("You do not have enough gold to toggle hardcore mode off.\nGold needed: " + HighestCost + " septims.")
			Return false
		EndIf

	Else
		Return true
	EndIf
EndFunction

Function ToggleTradeRestrictions()
	If TradeRestrictions
		_SLS_LicenceTradersQuest.Start()
	Else
		_SLS_LicenceTradersQuest.Stop()
	EndIf
EndFunction

String Function GetActorCrosshairRef()
	ObjectReference CrosshairRef = Game.GetCurrentCrosshairRef()
	If CrosshairRef != None
		If CrosshairRef as Actor
			Return (CrosshairRef.GetBaseObject().GetName() as String)
		
		Else
			Return ""
		EndIf
		
	Else
		Return ""
	EndIf
EndFunction

Function DoTradeRestrictAddMerchant()
	Actor akTarget = Game.GetCurrentCrosshairRef() as Actor
	If akTarget
		If ShowMessage("Set the current Npc as an exception? Exculded merchants will always trade items freely regardless of your licences\n\nIf you select no here you can assign them a Slaverun region next (if Slaverun is installed)")
			; Assign Npc as an exception to licence trading rules
			_SLS_TraderListExceptions.AddForm(akTarget)
			Debug.Messagebox("Done!\n" + akTarget.GetBaseObject().GetName() + " has been added as an exception")
		Else
		
			; Assign Npc a slaverun region
			If Game.GetModByName("Slaverun_Reloaded.esp") != 255
				
				UnAssignTradeRestrictMerchant(akTarget)
				Debug.Messagebox("Please exit the menu to continue")
				Int Button = _SLS_TradeRestrictSetMerchant.Show()
				AssignSlaverunMerchantRegion(akTarget, Button)
				Debug.Messagebox("Done!\n" + akTarget.GetBaseObject().GetName() + " has been assigned")
			EndIf
		EndIf
	
	Else
		Debug.Messagebox("Current crosshair ref is not a valid actor")
	EndIf
EndFunction

Function DoTradeRestrictRemoveMerchant()
	Actor akTarget = Game.GetCurrentCrosshairRef() as Actor
	If akTarget
		If ShowMessage("Are you sure you want to remove " + akTarget.GetBaseObject().GetName() + " from the system? \nThis will remove their assigned Slaverun region or their exception status if applicable")
			UnAssignTradeRestrictMerchant(akTarget)
			Debug.MessageBox("Done! ")
		EndIf
		
	Else
		Debug.Messagebox("Current crosshair ref is not a valid actor")
	EndIf
EndFunction

Function AssignSlaverunMerchantRegion(Actor akTarget, Int Button)
	; 0 - Whiterun
	; 1 - Riften
	; 2 - Windhelm
	; 3 - Markarth
	; 4 - Solitude
	; 5 - Riverwood
	; 6 - Falkreath
	; 7 - Dawnstar
	; 8 - Morthal
	; 9 - Winterhold

	If Button == 0
		_SLS_TraderListWhiterun.AddForm(akTarget)
		JsonUtil.FormListAdd("SL Survival/MerchantRestrictions.json", "LocsWhiterun", akTarget, allowDuplicate = false)
	ElseIf Button == 1
		_SLS_TraderListRiften.AddForm(akTarget)
		JsonUtil.FormListAdd("SL Survival/MerchantRestrictions.json", "LocsRiften", akTarget, allowDuplicate = false)
	ElseIf Button == 2
		_SLS_TraderListWindhelm.AddForm(akTarget)
		JsonUtil.FormListAdd("SL Survival/MerchantRestrictions.json", "LocsWindhelm", akTarget, allowDuplicate = false)
	ElseIf Button == 3
		_SLS_TraderListMarkarth.AddForm(akTarget)
		JsonUtil.FormListAdd("SL Survival/MerchantRestrictions.json", "LocsMarkarth", akTarget, allowDuplicate = false)
	ElseIf Button == 4
		_SLS_TraderListSolitude.AddForm(akTarget)
		JsonUtil.FormListAdd("SL Survival/MerchantRestrictions.json", "LocsSolitude", akTarget, allowDuplicate = false)
	ElseIf Button == 5
		_SLS_TraderListRiverwood.AddForm(akTarget)
		JsonUtil.FormListAdd("SL Survival/MerchantRestrictions.json", "LocsRiverwood", akTarget, allowDuplicate = false)
	ElseIf Button == 6
		_SLS_TraderListFalkreath.AddForm(akTarget)
		JsonUtil.FormListAdd("SL Survival/MerchantRestrictions.json", "LocsFalkreath", akTarget, allowDuplicate = false)
	ElseIf Button == 7
		_SLS_TraderListDawnstar.AddForm(akTarget)
		JsonUtil.FormListAdd("SL Survival/MerchantRestrictions.json", "LocsDawnstar", akTarget, allowDuplicate = false)
	ElseIf Button == 8
		_SLS_TraderListMorthal.AddForm(akTarget)
		JsonUtil.FormListAdd("SL Survival/MerchantRestrictions.json", "LocsMorthal", akTarget, allowDuplicate = false)
	ElseIf Button == 9
		_SLS_TraderListWinterhold.AddForm(akTarget)
		JsonUtil.FormListAdd("SL Survival/MerchantRestrictions.json", "LocsWinterhold", akTarget, allowDuplicate = false)
	EndIf
	_SLS_TraderListAll.AddForm(akTarget)
	_SLS_TraderBaseListAll.AddForm(akTarget.GetBaseObject())
	JsonUtil.Save("SL Survival/MerchantRestrictions.json")
EndFunction

Function UnAssignTradeRestrictMerchant(Actor akTarget)
	_SLS_TraderListExceptions.RemoveAddedForm(akTarget)
	
	_SLS_TraderListWhiterun.RemoveAddedForm(akTarget)
	_SLS_TraderListRiften.RemoveAddedForm(akTarget)
	_SLS_TraderListWindhelm.RemoveAddedForm(akTarget)
	_SLS_TraderListMarkarth.RemoveAddedForm(akTarget)
	_SLS_TraderListSolitude.RemoveAddedForm(akTarget)
	_SLS_TraderListRiverwood.RemoveAddedForm(akTarget)
	_SLS_TraderListFalkreath.RemoveAddedForm(akTarget)
	_SLS_TraderListMorthal.RemoveAddedForm(akTarget)
	_SLS_TraderListDawnstar.RemoveAddedForm(akTarget)
	_SLS_TraderListWinterhold.RemoveAddedForm(akTarget)
	
	_SLS_TraderListAll.RemoveAddedForm(akTarget)
	_SLS_TraderBaseListAll.RemoveAddedForm(akTarget.GetBaseObject())
	
	JsonUtil.FormListRemove("SL Survival/MerchantRestrictions.json", "Exceptions", akTarget)
	
	JsonUtil.FormListRemove("SL Survival/MerchantRestrictions.json", "LocsWhiterun", akTarget)
	JsonUtil.FormListRemove("SL Survival/MerchantRestrictions.json", "LocsRiften", akTarget)
	JsonUtil.FormListRemove("SL Survival/MerchantRestrictions.json", "LocsWindhelm", akTarget)
	JsonUtil.FormListRemove("SL Survival/MerchantRestrictions.json", "LocsMarkarth", akTarget)
	JsonUtil.FormListRemove("SL Survival/MerchantRestrictions.json", "LocsSolitude", akTarget)
	JsonUtil.FormListRemove("SL Survival/MerchantRestrictions.json", "LocsRiverwood", akTarget)
	JsonUtil.FormListRemove("SL Survival/MerchantRestrictions.json", "LocsFalkreath", akTarget)
	JsonUtil.FormListRemove("SL Survival/MerchantRestrictions.json", "LocsDawnstar", akTarget)
	JsonUtil.FormListRemove("SL Survival/MerchantRestrictions.json", "LocsMorthal", akTarget)
	JsonUtil.FormListRemove("SL Survival/MerchantRestrictions.json", "LocsWinterhold", akTarget)
	JsonUtil.FormListRemove("SL Survival/MerchantRestrictions.json", "LocsRavenRock", akTarget)
	JsonUtil.Save("SL Survival/MerchantRestrictions.json")
EndFunction

Function DoTradeRestrictResetAllMerchants()
	If ShowMessage("Are you sure you want to reset all merchant changes and clear the json file?")
		_SLS_TraderListExceptions.Revert()
		
		_SLS_TraderListWhiterun.Revert()
		_SLS_TraderListRiften.Revert()
		_SLS_TraderListWindhelm.Revert()
		_SLS_TraderListMarkarth.Revert()
		_SLS_TraderListSolitude.Revert()
		_SLS_TraderListRiverwood.Revert()
		_SLS_TraderListFalkreath.Revert()
		_SLS_TraderListMorthal.Revert()
		_SLS_TraderListDawnstar.Revert()
		_SLS_TraderListWinterhold.Revert()
		
		_SLS_TraderListAll.Revert()
		_SLS_TraderBaseListAll.Revert()
		
		JsonUtil.FormListClear("SL Survival/MerchantRestrictions.json", "Exceptions")
		
		JsonUtil.FormListClear("SL Survival/MerchantRestrictions.json", "LocsWhiterun")
		JsonUtil.FormListClear("SL Survival/MerchantRestrictions.json", "LocsRiften")
		JsonUtil.FormListClear("SL Survival/MerchantRestrictions.json", "LocsWindhelm")
		JsonUtil.FormListClear("SL Survival/MerchantRestrictions.json", "LocsMarkarth")
		JsonUtil.FormListClear("SL Survival/MerchantRestrictions.json", "LocsSolitude")
		JsonUtil.FormListClear("SL Survival/MerchantRestrictions.json", "LocsRiverwood")
		JsonUtil.FormListClear("SL Survival/MerchantRestrictions.json", "LocsFalkreath")
		JsonUtil.FormListClear("SL Survival/MerchantRestrictions.json", "LocsDawnstar")
		JsonUtil.FormListClear("SL Survival/MerchantRestrictions.json", "LocsMorthal")
		JsonUtil.FormListClear("SL Survival/MerchantRestrictions.json", "LocsWinterhold")
		JsonUtil.FormListClear("SL Survival/MerchantRestrictions.json", "LocsRavenRock")
		JsonUtil.Save("SL Survival/MerchantRestrictions.json")
		Debug.MessageBox("Done!")
	EndIf
EndFunction

Function ImportTradeRestrictMerchants()
	String[] LocList = new String[12]
	LocList[0] = "Exceptions"
	LocList[1] = "LocsWhiterun"
	LocList[2] = "LocsRiften"
	LocList[3] = "LocsWindhelm"
	LocList[4] = "LocsMarkarth"
	LocList[5] = "LocsSolitude"
	LocList[6] = "LocsRiverwood"
	LocList[7] = "LocsFalkreath"
	LocList[8] = "LocsDawnstar"
	LocList[9] = "LocsMorthal"
	LocList[10] = "LocsWinterhold"
	LocList[11] = "LocsRavenRock"
	
	Formlist[] FlArray = new Formlist[12]
	FlArray[0] = _SLS_TraderListExceptions
	FlArray[1] = _SLS_TraderListWhiterun
	FlArray[2] = _SLS_TraderListRiften
	FlArray[3] = _SLS_TraderListWindhelm
	FlArray[4] = _SLS_TraderListMarkarth
	FlArray[5] = _SLS_TraderListSolitude
	FlArray[6] = _SLS_TraderListRiverwood
	FlArray[7] = _SLS_TraderListFalkreath
	FlArray[8] = _SLS_TraderListDawnstar
	FlArray[9] = _SLS_TraderListMorthal
	FlArray[10] = _SLS_TraderListWinterhold
	FlArray[11] = _SLS_TraderListRavenRock
	
	Int i = 0
	Int j
	Formlist FlSelect
	Actor akTarget
	While i < LocList.Length
		FlSelect = FlArray[i]
		j = 0
		While j < JsonUtil.FormListCount("SL Survival/MerchantRestrictions.json", LocList[i])
			akTarget = JsonUtil.FormListGet("SL Survival/MerchantRestrictions.json", LocList[i], j) as Actor
			If akTarget
				If i > 0 ; Is not exception list
					FlSelect.AddForm(akTarget)
					_SLS_TraderListAll.AddForm(akTarget)
					_SLS_TraderBaseListAll.AddForm(akTarget.GetBaseObject())
				EndIf
			EndIf
			j += 1
		EndWhile
		i += 1
	EndWhile

	If Game.GetModByName("Mortal Weapons & Armor.esp") != 255
		ImportSupportedMerchant(_SLS_TraderListMarkarth, Game.GetFormFromFile(0x0012DF, "Mortal Weapons & Armor.esp") as Actor)
		ImportSupportedMerchant(_SLS_TraderListSolitude, Game.GetFormFromFile(0x0012E0, "Mortal Weapons & Armor.esp") as Actor)
		ImportSupportedMerchant(_SLS_TraderListFalkreath, Game.GetFormFromFile(0x0012DC, "Mortal Weapons & Armor.esp") as Actor)
		ImportSupportedMerchant(_SLS_TraderListWinterhold, Game.GetFormFromFile(0x0012DB, "Mortal Weapons & Armor.esp") as Actor)
		ImportSupportedMerchant(_SLS_TraderListWhiterun, Game.GetFormFromFile(0x0012DA, "Mortal Weapons & Armor.esp") as Actor)
		ImportSupportedMerchant(_SLS_TraderListRiften, Game.GetFormFromFile(0x0012D9, "Mortal Weapons & Armor.esp") as Actor)
		ImportSupportedMerchant(_SLS_TraderListWindhelm, Game.GetFormFromFile(0x0012DE, "Mortal Weapons & Armor.esp") as Actor)
		ImportSupportedMerchant(_SLS_TraderListRiverwood, Game.GetFormFromFile(0x0012DD, "Mortal Weapons & Armor.esp") as Actor)

	ElseIf Game.GetModByName("Milk Addict.esp") != 255
		ImportSupportedMerchant(_SLS_TraderListMarkarth, Game.GetFormFromFile(0x016789, "Milk Addict.esp") as Actor)
		ImportSupportedMerchant(_SLS_TraderListRiverwood, Game.GetFormFromFile(0x016783, "Milk Addict.esp") as Actor)
		ImportSupportedMerchant(_SLS_TraderListWhiterun, Game.GetFormFromFile(0x016785, "Milk Addict.esp") as Actor)
		ImportSupportedMerchant(_SLS_TraderListSolitude, Game.GetFormFromFile(0x016787, "Milk Addict.esp") as Actor)
		ImportSupportedMerchant(_SLS_TraderListWindhelm, Game.GetFormFromFile(0x01678B, "Milk Addict.esp") as Actor)
		ImportSupportedMerchant(_SLS_TraderListRiften, Game.GetFormFromFile(0x01678D, "Milk Addict.esp") as Actor)
		ImportSupportedMerchant(_SLS_TraderListFalkreath, Game.GetFormFromFile(0x01678F, "Milk Addict.esp") as Actor)
		ImportSupportedMerchant(_SLS_TraderListWinterhold, Game.GetFormFromFile(0x016791, "Milk Addict.esp") as Actor)
	EndIf
EndFunction

Function ImportSupportedMerchant(Formlist FlSelect, Actor akTarget)
	FlSelect.AddForm(akTarget)
	_SLS_TraderListAll.AddForm(akTarget)
	_SLS_TraderBaseListAll.AddForm(akTarget.GetBaseObject())
EndFunction

Function TogglePpLoot()
	If PpLootEnable
		PlayerRef.AddPerk(_SLS_IncPickpocketLootPerk)
	Else
		PlayerRef.RemovePerk(_SLS_IncPickpocketLootPerk)
	EndIf
	ForcePageReset()
EndFunction

Function BuildPpLootList()
	Debug.Notification("SLS: Building pickpocket leveled list")
	
	; Build devious key list
	_SLS_PpLootKeysList.Revert()
	If Game.GetModByName("Devious Devices - Expansion.esm") != 255
		_SLS_PpLootKeysList.AddForm(Game.GetFormFromFile(0x01775F, "Devious Devices - Integration.esm"), 1, 1)
		_SLS_PpLootKeysList.AddForm(Game.GetFormFromFile(0x008A4F, "Devious Devices - Integration.esm"), 1, 1)
	EndIf
	
	; Build loot list
	_SLS_PpLootRootList.Revert()
	Form[] LvlItems = new Form[9]
	LvlItems[0] = _SLS_PpLootFoodList
	LvlItems[1] = _SLS_PpLootGemsList
	LvlItems[2] = _SLS_PpLootSoulgemsList
	LvlItems[3] = _SLS_PpLootJewelryList
	LvlItems[4] = _SLS_PpLootEnchJewelryList
	LvlItems[5] = _SLS_PpLootPotionsList
	LvlItems[6] = _SLS_PpLootKeysList
	LvlItems[7] = _SLS_PpLootTomesList
	LvlItems[8] = CureDisease
	
	Float[] Chances = new Float[9]
	Chances[0] = PpLootFoodChance
	Chances[1] = PpLootGemsChance
	Chances[2] = PpLootSoulgemsChance
	Chances[3] = PpLootJewelryChance
	Chances[4] = PpLootEnchJewelryChance
	Chances[5] = PpLootPotionsChance
	Chances[6] = PpLootKeysChance
	Chances[7] = PpLootTomesChance
	Chances[8] = PpLootCureChance
	
	Float j
	Int i = 0
	While i < LvlItems.Length
		j = Chances[i]
		While j > 0.0
			_SLS_PpLootRootList.AddForm(LvlItems[i], 1, 1)
			j -= 0.5
		EndWhile
		i += 1
	EndWhile
	
	; Fill remaining slots with empty lists to give accurate percentage chances
	i = _SLS_PpLootRootList.GetNumForms()
	If i < 200
		i = 200 - i
		While i > 0
			_SLS_PpLootRootList.AddForm(_SLS_PpLootEmptyList, 1, 1)
			i -= 1
		EndWhile
	EndIf
	
	; Build gold list
	_SLS_PpGoldRoot.Revert()
	
	LvlItems = new Form[3]
	LvlItems[0] = _SLS_PpGoldLow
	LvlItems[1] = _SLS_PpGoldModerate
	LvlItems[2] = _SLS_PpGoldHigh
	
	Chances = new Float[9]
	Chances[0] = PpGoldLowChance
	Chances[1] = PpGoldModerateChance
	Chances[2] = PpGoldHighChance
	
	i = 0
	While i < LvlItems.Length
		j = Chances[i]
		While j > 0
			_SLS_PpGoldRoot.AddForm(LvlItems[i], 1, 1)
			j -= 0.5
		EndWhile
		i += 1
	EndWhile
	
	; Fill remaining slots with empty lists to give accurate percentage chances
	i = _SLS_PpGoldRoot.GetNumForms()
	If i < 200
		i = 200 - i
		While i > 0
			_SLS_PpGoldRoot.AddForm(_SLS_PpLootEmptyList, 1, 1)
			i -= 1
		EndWhile
	EndIf
	
	Debug.Notification("SLS: Building pickpocket leveled list complete!")
EndFunction

Function ToggleFolContraBlock()
	If FolContraBlock && Init.LicencesEnable
		_SLS_LicFollowerEnforcementDumbQuest.Start()
	Else
		_SLS_LicFollowerEnforcementDumbQuest.Stop()
	EndIf
EndFunction

Function TogglePpSleepNpcPerk()
	If PpSleepNpcPerk
		PlayerRef.AddPerk(_SLS_PickpocketSleepBonusPerk)
	Else
		PlayerRef.RemovePerk(_SLS_PickpocketSleepBonusPerk)
	EndIf
EndFunction

Function TogglePpFailHandle()
	If PpFailHandle
		_SLS_PickPocketFailDetectQuest.Start()
	Else
		_SLS_PickPocketFailDetectQuest.Stop()
	EndIf
EndFunction

Function ImportEscorts()
	Int i = JsonUtil.FormListCount("SL Survival/EscortList.json", "Escorts")
	While i > 0
		i -= 1
		_SLS_EscortsList.AddForm(JsonUtil.FormListGet("SL Survival/EscortList.json", "Escorts", i) as ObjectReference)
	EndWhile
EndFunction

Function AddEscort()
	Actor Escort = Game.GetCurrentCrosshairRef() as Actor
	_SLS_EscortsList.AddForm(Escort)
	JsonUtil.FormListAdd("SL Survival/EscortList.json", "Escorts", Escort, allowDuplicate = false)
	JsonUtil.Save("SL Survival/EscortList.json")
	SetStrongFollower(Escort)	
EndFunction

Function RemoveEscort()
	Actor Escort = Game.GetCurrentCrosshairRef() as Actor
	_SLS_EscortsList.RemoveAddedForm(Escort)
	JsonUtil.FormListRemove("SL Survival/EscortList.json", "Escorts", Escort, allInstances = true)
	JsonUtil.Save("SL Survival/EscortList.json")
	SetStrongFollower(Escort)
EndFunction

String Function GetMageRankString()
	Int Rank = PlayerRef.GetFactionRank(CollegeofWinterholdFaction)
	If Rank < 0
		Return "Not A Member"
	ElseIf Rank == 0
		Return "0 - Student"
	ElseIf Rank == 1
		Return "1 - Apprentice"
	ElseIf Rank == 2
		Return "2 - Evoker"
	ElseIf Rank == 3
		Return "3 - Scholar"
	ElseIf Rank == 4
		Return "4 - Wizard"
	ElseIf Rank == 5
		Return "5 - Master-Wizard"
	ElseIf Rank == 6
		Return "6 - Arch-Mage"
	EndIf
EndFunction

String Function GetCompanionsRankString()
	Int Rank = PlayerRef.GetFactionRank(CompanionsFaction)
	If Rank < 0
		Return "Not A Member"
	ElseIf Rank == 0
		Return "0 - Cohort"
	ElseIf Rank == 1
		Return "1 - Companion"
	ElseIf Rank == 2
		Return "2 - Shield-Sister"
	ElseIf Rank == 3
		Return "3 - Harbinger"
	EndIf
EndFunction

String Function GetCwSide()
	String CwSide
	If CW01A.GetCurrentStageId() >= 200 || CW01B.GetCurrentStageId() >= 200
		If Cw.playerAllegiance == 1 ; Player is imperial
			Return "Imperials: "
		ElseIf Cw.playerAllegiance == 2 ; Player is stormcloak
			Return "Stormcloaks: "
		EndIf
	
	Else
		Return "Civil War: Undecided"
	EndIf
EndFunction

Function AddQuestObjects() ; Add quest objects to list so that they are not removed when items are stolen from your inventory (Toll evasion/Pickpocket fail)
	If Game.GetModByName("Dawnguard.esm") != 255
		_SLS_QuestItems.AddForm(Game.GetFormFromFile(0x0118F9, "Dawnguard.esm"))
		_SLS_QuestItems.AddForm(Game.GetFormFromFile(0x011A13, "Dawnguard.esm"))
	EndIf
	;If Game.GetModByName("Dragonborn.esm") != 255
	
	;EndIf
EndFunction

Function ToggleKennelFollower()
	If PlayerRef.GetCurrentLocation() == _SLS_KennelWhiterunLocation
		Debug.Messagebox("You can not toggle this while inside the kennel. Exit the kennel and wait for your follower to rejoin you and toggle the option again")
	
	Else
		KennelFollowerToggle = !KennelFollowerToggle
		SetToggleOptionValue(KennelFollowerToggleOID, KennelFollowerToggle)
	EndIf
EndFunction

Function BuildBikiniLists()
	If Game.GetModByName(JsonUtil.GetStringValue("SL Survival/BikiniArmors.json", "bikinimodname", missing = "TheAmazingWorldOfBikiniArmor.esp")) != 255
		Debug.Notification("SLS: Building bikini armor leveled list")
		
		; Build bikini type lists
		Form[] LvlItems = new Form[11]
		LvlItems[0] = _SLS_BikiniArmorsListHide
		LvlItems[1] = _SLS_BikiniArmorsListLeather
		LvlItems[2] = _SLS_BikiniArmorsListIron
		LvlItems[3] = _SLS_BikiniArmorsListSteel
		LvlItems[4] = _SLS_BikiniArmorsListSteelPlate
		LvlItems[5] = _SLS_BikiniArmorsListDwarven
		LvlItems[6] = _SLS_BikiniArmorsListFalmer
		LvlItems[7] = _SLS_BikiniArmorsListWolf
		LvlItems[8] = _SLS_BikiniArmorsListBlades
		LvlItems[9] = _SLS_BikiniArmorsListEbony
		LvlItems[10] = _SLS_BikiniArmorsListDragonbone

		String[] JsonKeys = new String[11]
		JsonKeys[0] = "hide"
		JsonKeys[1] = "leather"
		JsonKeys[2] = "iron"
		JsonKeys[3] = "steel"
		JsonKeys[4] = "steelplate"
		JsonKeys[5] = "dwarven"
		JsonKeys[6] = "falmer"
		JsonKeys[7] = "wolf"
		JsonKeys[8] = "blades"
		JsonKeys[9] = "ebony"
		JsonKeys[10] = "dragonbone"
		
		Int i = LvlItems.Length
		Int j
		Form akForm
		Int ResolveErrorCount = 0
		Int NonArmorCount = 0
		While i > 0
			i -= 1
			
			(LvlItems[i] as LeveledItem).Revert()
			j = JsonUtil.FormListCount("SL Survival/BikiniArmors.json", JsonKeys[i])
			If IsInMcm
				SetTextOptionValue(BikiniBuildListOID_T, "Building " + JsonKeys[i] + " bikinis")
			EndIf
			While j > 0
				j -= 1
				Debug.Trace("_SLS_: i: " + i + ". j: " + j)
				;Debug.Trace("_SLS_: LVLI: Adding " + JsonUtil.FormListGet("SL Survival/BikiniArmors.json", JsonKeys[i], j) + " to " + LvlItems[i])
				akForm = JsonUtil.FormListGet("SL Survival/BikiniArmors.json", JsonKeys[i], j)
				If akForm as Armor
					(LvlItems[i] as LeveledItem).AddForm(akForm, 1, 1)
				Else
					If akForm
						Debug.Trace("_SLS_: BuildBikinis(): Json entry is not an armor record: " + JsonKeys[i] + " at index: " + j)
						NonArmorCount += 1
					Else
						Debug.Trace("_SLS_: BuildBikinis(): Json form could not be resolved: " + JsonKeys[i] + " at index: " + j)
						ResolveErrorCount += 1
					EndIf
				EndIf
			EndWhile
		EndWhile
		
		; Set drop counts
		_SLS_BikiniArmorsEntryPointVendorCity.SetNthCount(0, BikiniDropsVendorCity)
		_SLS_BikiniArmorsEntryPointVendorTown.SetNthCount(0, BikiniDropsVendorTown)
		_SLS_BikiniArmorsEntryPointVendorKhajiit.SetNthCount(0, BikiniDropsVendorKhajiit)
		_SLS_BikiniArmorsEntryPointChest.SetNthCount(0, BikiniDropsChest)
		_SLS_BikiniArmorsEntryPointChestOrnate.SetNthCount(0, BikiniDropsChestOrnate)
		
		; Build distribution list
		Float[] Chances = new Float[11]
		Chances[0] = BikiniChanceHide
		Chances[1] = BikiniChanceLeather
		Chances[2] = BikiniChanceIron
		Chances[3] = BikiniChanceSteel
		Chances[4] = BikiniChanceSteelPlate
		Chances[5] = BikiniChanceDwarven
		Chances[6] = BikiniChanceFalmer
		Chances[7] = BikiniChanceWolf
		Chances[8] = BikiniChanceBlades
		Chances[9] = BikiniChanceEbony
		Chances[10] = BikiniChanceDragonbone

		_SLS_BikiniArmorsList.Revert()
		i = 0
		Float k
		While i < LvlItems.Length
			If IsInMcm
				SetTextOptionValue(BikiniBuildListOID_T, "Finalizing " + JsonKeys[i] + " bikinis")
			EndIf
			k = Chances[i]
			While k > 0.0
				;Debug.Trace("_SLS_: LVLI: Adding: " + LvlItems[i])
				_SLS_BikiniArmorsList.AddForm(LvlItems[i], 1, 1)
				k -= 0.5
			EndWhile
			i += 1
		EndWhile
		
		; Fill remaining slots with empty lists to give accurate percentage chances
		i = _SLS_BikiniArmorsList.GetNumForms()
		If i < 201
			i = 201 - i
			While i > 0
				_SLS_BikiniArmorsList.AddForm(_SLS_PpLootEmptyList, 1, 1)
				i -= 1
			EndWhile
		EndIf
		
		If IsInMcm
			SetTextOptionValue(BikiniBuildListOID_T, "Done!")
		EndIf
		
		If ResolveErrorCount || NonArmorCount
			Debug.Messagebox("Warning: " + ResolveErrorCount + " armors in your BikiniArmor.Json could not be found in game. \n\n" + NonArmorCount + " records in your json are not ARMO records!" + "\n\nSearch your papyrus log for 'BuildBikinis' to find out more\n\nThis is usually harmless enough if you're missing just a couple of armors due to all the different variations of TAWoBA available.")
		EndIf
		
		Debug.Notification("SLS: Building bikini armor leveled list complete!")
	EndIf
EndFunction

Function ClearBikiniLists()
	_SLS_BikiniArmorsList.Revert()
	Debug.Messagebox("List cleared")
EndFunction

Function ModFondleVoice(Bool AddToList)
	VoiceType Voice = Game.GetCurrentCrosshairRef().GetVoiceType()
	If AddToList
		If ShowMessage("Are you sure you want to add the following voice type from the fondleable list?\n" + Voice)
			_SLS_FondleableVoices.AddForm(Voice)
			JsonUtil.FormListAdd("SL Survival/FondleableVoices.json", "customvoices", Voice, allowDuplicate = false)
			JsonUtil.Save("SL Survival/FondleableVoices.json")
		EndIf
	
	Else
		If ShowMessage("Are you sure you want to remove the following voice type from the fondleable list?\n" + Voice)
			_SLS_FondleableVoices.RemoveAddedForm(Voice)
			JsonUtil.FormListAdd("SL Survival/FondleableVoices.json", "customvoices", Voice, allowDuplicate = false)
			JsonUtil.Save("SL Survival/FondleableVoices.json")			
		EndIf
	EndIf
EndFunction

Function InitLocJurisdictions()
	Int i = JsonUtil.FormListCount("SL Survival/CustomTownLocations.json", "whiterun")
	While i > 0
		i -= 1
		_SLS_LocsWhiterun.AddForm(JsonUtil.FormListGet("SL Survival/CustomTownLocations.json", "whiterun", i))
	EndWhile
	
	i = JsonUtil.FormListCount("SL Survival/CustomTownLocations.json", "solitude")
	While i > 0
		i -= 1
		_SLS_LocsSolitude.AddForm(JsonUtil.FormListGet("SL Survival/CustomTownLocations.json", "solitude", i))
	EndWhile
	
	i = JsonUtil.FormListCount("SL Survival/CustomTownLocations.json", "markarth")
	While i > 0
		i -= 1
		_SLS_LocsMarkarth.AddForm(JsonUtil.FormListGet("SL Survival/CustomTownLocations.json", "markarth", i))
	EndWhile
	
	i = JsonUtil.FormListCount("SL Survival/CustomTownLocations.json", "windhelm")
	While i > 0
		i -= 1
		_SLS_LocsWindhelm.AddForm(JsonUtil.FormListGet("SL Survival/CustomTownLocations.json", "windhelm", i))
	EndWhile
	
	i = JsonUtil.FormListCount("SL Survival/CustomTownLocations.json", "riften")
	While i > 0
		i -= 1
		_SLS_LocsRiften.AddForm(JsonUtil.FormListGet("SL Survival/CustomTownLocations.json", "riften", i))
	EndWhile
EndFunction

String Function GetLocationJurisdictionString(Location Loc)
	If _SLS_LocsWhiterun.HasForm(Loc)
		Return "Whiterun "
	ElseIf _SLS_LocsSolitude.HasForm(Loc)
		Return "Solitude "
	ElseIf _SLS_LocsMarkarth.HasForm(Loc)
		Return "Markarth "
	ElseIf _SLS_LocsWindhelm.HasForm(Loc)
		Return "Windhelm "
	ElseIf _SLS_LocsRiften.HasForm(Loc)
		Return "Riften "
	Else
		Return "Unknown "
	EndIf
EndFunction

Function ModLocationJurisdiction(Bool AddLocation)
	Location Loc = PlayerRef.GetCurrentLocation()
	
	If AddLocation
		If Loc != None
			Debug.Messagebox("You need to return to the game for the town selection menu to show")
			Int Button = _SLS_GetLocationJurisdiction.Show()
			If Button == 0 ; Whiterun
				_SLS_LocsWhiterun.AddForm(Loc)
				JsonUtil.FormListAdd("SL Survival/CustomTownLocations.json", "whiterun", Loc, allowDuplicate = false)
				
			ElseIf Button == 1 ; Riften
				_SLS_LocsRiften.AddForm(Loc)
				JsonUtil.FormListAdd("SL Survival/CustomTownLocations.json", "riften", Loc, allowDuplicate = false)
				
			ElseIf Button == 2 ; Windhelm
				_SLS_LocsWindhelm.AddForm(Loc)
				JsonUtil.FormListAdd("SL Survival/CustomTownLocations.json", "windhelm", Loc, allowDuplicate = false)
				
			ElseIf Button == 3 ; Markarth
				_SLS_LocsMarkarth.AddForm(Loc)
				JsonUtil.FormListAdd("SL Survival/CustomTownLocations.json", "markarth", Loc, allowDuplicate = false)
				
			ElseIf Button == 4 ; Solitude
				_SLS_LocsSolitude.AddForm(Loc)
				JsonUtil.FormListAdd("SL Survival/CustomTownLocations.json", "solitude", Loc, allowDuplicate = false)
				
			Else ; cancel
				Return
			EndIf
			JsonUtil.Save("SL Survival/CustomTownLocations.json")
		
		Else
			Debug.Messagebox("Can not add a None location")
		EndIf
	Else
		If ShowMessage("Are you sure you want to remove this location?")
			RemoveLocationJurisdiction(Loc)
		EndIf	
	EndIf
EndFunction

Formlist Function GetLocationJurisdictionList(Location Loc)
	If _SLS_LocsWhiterun.HasForm(Loc)
		Return _SLS_LocsWhiterun
	ElseIf _SLS_LocsSolitude.HasForm(Loc)
		Return _SLS_LocsSolitude
	ElseIf _SLS_LocsMarkarth.HasForm(Loc)
		Return _SLS_LocsMarkarth
	ElseIf _SLS_LocsWindhelm.HasForm(Loc)
		Return _SLS_LocsWindhelm
	ElseIf _SLS_LocsRiften.HasForm(Loc)
		Return _SLS_LocsRiften
	Else
		Return None
	EndIf
EndFunction

Function RemoveLocationJurisdiction(Location Loc)
	_SLS_LocsWhiterun.RemoveAddedForm(Loc)
	_SLS_LocsSolitude.RemoveAddedForm(Loc)
	_SLS_LocsMarkarth.RemoveAddedForm(Loc)
	_SLS_LocsWindhelm.RemoveAddedForm(Loc)
	_SLS_LocsRiften.RemoveAddedForm(Loc)
	JsonUtil.FormListRemove("SL Survival/CustomTownLocations.json", "whiterun", Loc, allInstances = true)
	JsonUtil.FormListRemove("SL Survival/CustomTownLocations.json", "solitude", Loc, allInstances = true)
	JsonUtil.FormListRemove("SL Survival/CustomTownLocations.json", "markarth", Loc, allInstances = true)
	JsonUtil.FormListRemove("SL Survival/CustomTownLocations.json", "windhelm", Loc, allInstances = true)
	JsonUtil.FormListRemove("SL Survival/CustomTownLocations.json", "riften", Loc, allInstances = true)
	JsonUtil.Save("SL Survival/CustomTownLocations.json")
EndFunction

String Function GetLocationCurrentString()
	;/
	String LocString
	Location MyLoc = PlayerRef.GetCurrentLocation()
	If MyLoc == None
		Return "Nowhere"
	Else
		LocString = MyLoc.GetName()
		If LocString == ""
			LocString = "Nowhere"
		EndIf
	EndIf
	Return LocString
	/;
	String LocString = LocTrack.PlayerCurrentLocString
	If LocString == ""
		Return "Untracked location"
	EndIf
	Return LocString
EndFunction

Function ToggleDismemberment()
	If AmpType == 0
		Amputation.Shutdown()
	Else
		_SLS_AmputationQuest.Start()
	EndIf
EndFunction

Function ToggleCurseTats()
	If LicUtil.CurseTats
		If PlayerRef.HasMagicEffect(_SLS_MagicLicenceCollarMgef)
			Util.BeginOverlay(PlayerRef, 0.9, "\\SL Survival\\magic_silence_collar.dds", OverlayAreas[MagicCurseArea])
		EndIf
		If PlayerRef.HasMagicEffect(_SLS_LicBikiniCurseInactiveMgef) || PlayerRef.HasMagicEffect(_SLS_LicBikiniCurseStamina) 
			Util.BeginOverlay(PlayerRef, 0.9, "\\SL Survival\\bikini_curse_body.dds", OverlayAreas[BikiniCurseArea])
		EndIf
	
	Else
		Util.RemoveOverlay(PlayerRef, "\\SL Survival\\magic_silence_collar.dds", OverlayAreas[MagicCurseArea])
		Util.RemoveOverlay(PlayerRef, "\\SL Survival\\bikini_curse_body.dds", OverlayAreas[BikiniCurseArea])
	EndIf
EndFunction

Function SetInequalityEffects()
	_SLS_InequalitySpell.SetNthEffectMagnitude(0, IneqStatsVal) ; Health male
	_SLS_InequalitySpell.SetNthEffectMagnitude(1, IneqStatsVal) ; Health female
	_SLS_InequalitySpell.SetNthEffectMagnitude(2, IneqStatsVal) ; Magicka/Stamina male
	_SLS_InequalitySpell.SetNthEffectMagnitude(3, IneqStatsVal) ; Magicka/Stamina female
	_SLS_InequalitySpell.SetNthEffectMagnitude(4, IneqSpeedVal) ; Speed male
	_SLS_InequalitySpell.SetNthEffectMagnitude(5, (IneqDamageVal/100.0)) ; Damage mult male
	_SLS_InequalitySpell.SetNthEffectMagnitude(6, (IneqDamageVal/100.0)) ; Damage mult female
	_SLS_InequalitySpell.SetNthEffectMagnitude(7, IneqCarryVal) ; Carryweight female
	_SLS_InequalitySpell.SetNthEffectMagnitude(8, IneqDestVal) ; Destruction power male
	_SLS_InequalitySpell.SetNthEffectMagnitude(9, IneqDestVal) ; Destruction power female
EndFunction

Function ToggleBikiniExp()
	_SLS_BikiniExpLevel.SetValueInt(0)
	If BikiniExpT
		PlayerRef.AddSpell(_SLS_BikiniExpSpell)
		PlayerRef.AddPerk(_SLS_BikiniExpPerk)
		_SLS_BikiniExpTrainingQuest.Start()
	Else
		_SLS_BikiniExpTrainingQuest.Stop()
		PlayerRef.RemoveSpell(_SLS_BikiniExpSpell)
		PlayerRef.RemovePerk(_SLS_BikiniExpPerk)
	EndIf
EndFunction

Function ImportLicenceExceptions()
	Form akForm
	Int i = JsonUtil.FormListCount("SL Survival/LicenceExceptions.json", "LicenceExceptions")
	While i > 0
		i -= 1
		akForm = JsonUtil.FormListGet("SL Survival/LicenceExceptions.json", "LicenceExceptions", i)
		If akForm
			If akForm as Weapon
				_SLS_LicExceptionsWeapon.AddForm(akForm)
			ElseIf akForm as Armor
				_SLS_LicExceptionsArmor.AddForm(akForm)
			Else
				Debug.Trace("_SLS_: ImportLicenceExceptions(): Uncategorized item: " + akForm)
			EndIf
		EndIf
	EndWhile
EndFunction

Function AddWearableLanternExceptions()
	; Filter wearable lanterns. Other lanterns are non-playable so should filter ok. 
	If Game.GetModByName("Chesko_WearableLantern.esp") != 255
		_SLS_LicExceptionsArmor.AddForm(Game.GetFormFromFile(0x0111C2, "Chesko_WearableLantern.esp"))
		_SLS_LicExceptionsArmor.AddForm(Game.GetFormFromFile(0x011726, "Chesko_WearableLantern.esp"))
		_SLS_LicExceptionsArmor.AddForm(Game.GetFormFromFile(0x011727, "Chesko_WearableLantern.esp"))
		_SLS_LicExceptionsArmor.AddForm(Game.GetFormFromFile(0x010C3E, "Chesko_WearableLantern.esp"))
		_SLS_LicExceptionsArmor.AddForm(Game.GetFormFromFile(0x010C3F, "Chesko_WearableLantern.esp"))
	EndIf
EndFunction

Function AddRemoveLicenceException()
	Form akForm = EquipSlots[SelectedEquip]
	If !_SLS_LicExceptionsWeapon.HasForm(akForm) && !_SLS_LicExceptionsArmor.HasForm(akForm) ; Add exception
		If akForm as Weapon
			_SLS_LicExceptionsWeapon.AddForm(akForm)
		Else
			_SLS_LicExceptionsArmor.AddForm(akForm)
		EndIf
		JsonUtil.FormListAdd("SL Survival/LicenceExceptions.json", "LicenceExceptions", akForm, allowDuplicate = false)
		
	Else ; Remove exception
		If akForm as Weapon
			_SLS_LicExceptionsWeapon.RemoveAddedForm(akForm)
		Else
			_SLS_LicExceptionsArmor.RemoveAddedForm(akForm)
		EndIf
		JsonUtil.FormListRemove("SL Survival/LicenceExceptions.json", "LicenceExceptions", akForm, allInstances = true)
	EndIf
	JsonUtil.Save("SL Survival/LicenceExceptions.json")
EndFunction

Function BuildSplashArray()
	SplashArray = new String[4]
	SplashArray[0] = "SL Survival/Mcm1.dds"
	SplashArray[1] = "SL Survival/Mcm2.dds"
	SplashArray[2] = "SL Survival/Mcm3.dds"
	SplashArray[3] = "SL Survival/Mcm4.dds"
EndFunction

Function ToggleCumEffects()
	If CumEffectsEnable
		_SLS_CumEffectsQuest.Start()
	Else
		_SLS_CumEffectsQuest.Stop()
	EndIf
EndFunction

Function ToggleAnimalBreeding()
	If AnimalBreedEnable && Init.SlsCreatureEvents
		PlayerRef.AddPerk(Game.GetFormFromFile(0x11CFFF, "SL Survival.esp") as Perk)
		_SLS_AnimalFriendAliases.Start()
		_SLS_AnimalFriendQuest.Start()
		(Game.GetFormFromFile(0x11E028, "SL Survival.esp") as Quest).Start() ; _SLS_WildlingQuest
	Else
		PlayerRef.RemovePerk(Game.GetFormFromFile(0x11CFFF, "SL Survival.esp") as Perk)
		_SLS_AnimalFriendAliases.Stop()
		_SLS_AnimalFriendQuest.Stop()
		(Game.GetFormFromFile(0x11E028, "SL Survival.esp") as Quest).Stop() ; _SLS_WildlingQuest
	EndIf
EndFunction

Function ToggleBondFurn()
	If BondFurnEnable
		_SLS_DeviousFurnitureQuest.Start()
	Else
		_SLS_DeviousFurnitureQuest.Stop()
	EndIf
EndFunction

Function RefreshBikiniExpEffects() ; Changes to bikini mgefs will require reloading the spells to take effect
	PlayerRef.RemoveSpell(_SLS_BikiniExpSpell)
	PlayerRef.RemovePerk(_SLS_BikiniExpPerk)
	If BikiniExpT
		Utility.Wait(5.0)
		PlayerRef.AddSpell(_SLS_BikiniExpSpell)
		PlayerRef.AddPerk(_SLS_BikiniExpPerk)
	EndIf
EndFunction

Function ToggleBikiniCurse()
		LicUtil.CheckForBikiniCurse()
EndFunction

Function SetHorseCost(Int Cost)
	HorseCost.SetValueInt(Cost)
	Stables.UpdateCurrentInstanceGlobal(HorseCost)
EndFunction

Function GetEquippedList()
	SetTextOptionValue(LicGetEquipListOID_T, "Working...")
	StorageUtil.FormListClear(Self, "_SLS_EquipSlots")
	StorageUtil.StringListClear(Self, "_SLS_EquipSlotStrings")
	
	StorageUtil.FormListAdd(Self, "_SLS_EquipSlots", None, allowDuplicate = false)
;/
	Int[] SlotMasks = new Int[32]
	SlotMasks[0] = 1 ; kSlotMask30
	SlotMasks[1] = 2 ; kSlotMask31
	SlotMasks[2] = 4 ; kSlotMask32
	SlotMasks[3] = 8 ; kSlotMask33
	SlotMasks[4] = 16 ; kSlotMask34
	SlotMasks[5] = 32 ; kSlotMask35
	SlotMasks[6] = 64 ; kSlotMask36
	SlotMasks[7] = 128 ; kSlotMask37
	SlotMasks[8] = 256 ; kSlotMask38
	SlotMasks[9] = 512 ; kSlotMask39
	SlotMasks[10] = 1024 ; kSlotMask40
	SlotMasks[11] = 2048 ; kSlotMask41
	SlotMasks[12] = 4096 ; kSlotMask42
	SlotMasks[13] = 8192 ; kSlotMask43
	SlotMasks[14] = 16384 ; kSlotMask44
	SlotMasks[15] = 32768 ; kSlotMask45
	SlotMasks[16] = 65536 ; kSlotMask46
	SlotMasks[17] = 131072 ; kSlotMask47
	SlotMasks[18] = 262144 ; kSlotMask48
	SlotMasks[19] = 524288 ; kSlotMask49
	SlotMasks[20] = 1048576 ; kSlotMask50
	SlotMasks[21] = 2097152 ; kSlotMask51
	SlotMasks[22] = 4194304 ; kSlotMask52
	SlotMasks[23] = 8388608 ; kSlotMask53
	SlotMasks[24] = 16777216 ; kSlotMask54
	SlotMasks[25] = 33554432 ; kSlotMask55
	SlotMasks[26] = 67108864 ; kSlotMask56
	SlotMasks[27] = 134217728 ; kSlotMask57
	SlotMasks[28] = 268435456 ; kSlotMask58
	SlotMasks[29] = 536870912 ; kSlotMask59
	SlotMasks[30] = 1073741824 ; kSlotMask60
	SlotMasks[31] = 2147483648 ; kSlotMask61
/;	
	;Int Index = 0
	Form akForm
	akForm = PlayerRef.GetEquippedWeapon(abLeftHand = false)
	If akForm
		StorageUtil.FormListAdd(Self, "_SLS_EquipSlots", akForm)
		;Index += 1
	EndIf
	akForm = PlayerRef.GetEquippedWeapon(abLeftHand = true)
	If akForm
		StorageUtil.FormListAdd(Self, "_SLS_EquipSlots", akForm)
		;Index += 1
	EndIf
	
	
	Int i = 0
	While i < SlotMasks.Length
		akForm = PlayerRef.GetWornForm(SlotMasks[i])
		If akForm
			If !akForm.HasKeyword(SexlabNoStrip) && (akForm as Armor).IsPlayable() && akForm.GetName() != ""
				StorageUtil.FormListAdd(Self, "_SLS_EquipSlots", akForm, allowDuplicate = false)
			EndIf
		EndIf
		i += 1
	EndWhile
	EquipSlots = StorageUtil.FormListToArray(Self, "_SLS_EquipSlots")
	
	If EquipSlots[SelectedEquip] == None
		SelectedEquip = 0
	EndIf		
	
	i = 0
	While i < EquipSlots.Length
		akForm = EquipSlots[i]
		If akForm == None
			StorageUtil.StringListAdd(Self, "_SLS_EquipSlotStrings", "None ")
		Else
			StorageUtil.StringListAdd(Self, "_SLS_EquipSlotStrings", akForm.GetName() + " - " + akForm)
		EndIf
		i += 1
	EndWhile
	EquipSlotStrings = StorageUtil.StringListToArray(Self, "_SLS_EquipSlotStrings")
	SetTextOptionValue(LicGetEquipListOID_T, "Done! ")
EndFunction

Function ModLicBuyBlock()
	If _SLS_LicenceBuyBlockerQuest.IsRunning()
		LicBuyBlocker.DoRandomize()
	EndIf
EndFunction

Function ToggleDebugMode()
	If Init.DebugMode
		PlayerRef.AddSpell(_SLS_DebugGetActorPackSpell)
		PlayerRef.AddSpell(_SLS_DebugGetActorVoiceTypeSpell)
	Else
		PlayerRef.RemoveSpell(_SLS_DebugGetActorPackSpell)
		PlayerRef.RemoveSpell(_SLS_DebugGetActorVoiceTypeSpell)
	EndIf
EndFunction

Function UpdateMenuText(Int MenuOption, String Text)
	If IsInMcm
		SetTextOptionValue(MenuOption, Text)
	EndIf
EndFunction

Function LicShowApiBlockForms()
	;Debug.Messagebox(StorageUtil.FormListCount(None, "_SLS_LicenceBlockingForms"))
	String Blockers = "Licences blocked: " + ((Game.GetFormFromFile(0x08666A, "SL Survival.esp") as GlobalVariable).GetValueInt() as Bool) + "\n\nBlocking Forms: "
	Int i = 0
	While i < StorageUtil.FormListCount(None, "_SLS_LicenceBlockingForms")
		Blockers += "\n" + StorageUtil.FormListGet(None, "_SLS_LicenceBlockingForms", i)
		i += 1
	EndWhile
	Debug.Messagebox(Blockers)
EndFunction

Function LicClearApiBlockForms()
	(Game.GetFormFromFile(0x08666A, "SL Survival.esp") as GlobalVariable).SetValueInt(0)
	StorageUtil.FormListClear(None, "_SLS_LicenceBlockingForms")
EndFunction

Function BuildSexOptionsArrays()
	Bool DflowInstalled = false
	If Game.GetModByName("DeviousFollowers.esp") != 255
		DflowInstalled = true
		SexAggressiveness = new String[5]
	Else
		SexAggressiveness = new String[3]
	EndIf
	SexAggressiveness[0] = "Not Aggressive"
	SexAggressiveness[1] = "Don't Care"
	SexAggressiveness[2] = "Aggressive"
	If DflowInstalled
		SexAggressiveness[3] = "Use DF Willpower Fixed"
		SexAggressiveness[4] = "Use DF Willpower % Chance"
	EndIf
	
	SexPlayerIsVictim = new String[2]
	SexPlayerIsVictim[0] = "Player Is Not Victim"
	SexPlayerIsVictim[1] = "Player Is Victim"
EndFunction

Function RefreshBikiniCurseOverlay(Int index)
	Util.RemoveOverlay(PlayerRef, "\\SL Survival\\bikini_curse_body.dds", OverlayAreas[BikiniCurseArea])
	If PlayerRef.HasMagicEffect(_SLS_LicBikiniCurseInactiveMgef) || PlayerRef.HasMagicEffect(_SLS_LicBikiniCurseStamina)	
		Util.BeginOverlay(PlayerRef, 0.9, "\\SL Survival\\bikini_curse_body.dds", OverlayAreas[index])
	EndIf
EndFunction

Function RefreshMagicCurseOverlay(Int index)
	Util.RemoveOverlay(PlayerRef, "\\SL Survival\\magic_silence_collar.dds", OverlayAreas[MagicCurseArea])
	If PlayerRef.HasMagicEffect(_SLS_MagicLicenceCollarMgef)
		Util.BeginOverlay(PlayerRef, 0.9, "\\SL Survival\\magic_silence_collar.dds", OverlayAreas[index])
	EndIf
EndFunction

Function ToggleIneqSkills()
	If InequalitySkills
		PlayerRef.AddPerk(_SLS_InequalitySkillsPerk)
	Else
		PlayerRef.RemovePerk(_SLS_InequalitySkillsPerk)
	EndIf
EndFunction

Function ToggleIneqBuySell()
	If InequalityBuySell
		PlayerRef.AddPerk(_SLS_InequalityBuySellPerk)
	Else
		PlayerRef.RemovePerk(_SLS_InequalityBuySellPerk)
	EndIf
EndFunction

Function ToggleCreatureEvents()
	PlayerRef.RemovePerk(_SLS_CreatureTalk)
	If Init.SlsCreatureEvents
		PlayerRef.AddPerk(_SLS_CreatureTalk)
	EndIf
	ToggleAnimalBreeding()
EndFunction

Function ToggleFastTravelDisable()
	If !FastTravelDisable
		Game.EnableFastTravel()
	EndIf
EndFunction

Function ToggleLicMagicCursedDevices()
	If LicUtil.LicMagicCursedDevices
		PlayerRef.RemoveSpell(_SLS_MagicLicenceCurse)
	EndIf
EndFunction

Function ToggleBarefootMag()
	PlayerRef.RemoveSpell(Main._SLS_BarefootSpeedSpell)
	If BarefootMag > 0.0
		Main.BarefootMaintenance()
		Utility.Wait(0.1)
		PlayerRef.AddSpell(Main._SLS_BarefootSpeedSpell, false)
	EndIf
EndFunction

Function ToggleCatCalling()
	If CatCallVol > 0.0
		_SLS_CatCallsQuest.Start()
	Else
		_SLS_CatCallsQuest.Stop()
	EndIf
EndFunction

Function ToggleLicenceStyle()
	LicUtil.ChangeLicenceStyle()
EndFunction

Function ToggleGuardBehavLockpick()
	If GuardBehavLockpicking
		_SLS_GuardWarnLockpickQuest.Start()
	Else
		_SLS_GuardWarnLockpickQuest.Stop()
	EndIf
EndFunction

Function ToggleGuardBehavDrugs()
	If GuardBehavDrugs
		_SLS_GuardWarnDrugsQuest.Start()
	Else
		_SLS_GuardWarnDrugsQuest.Stop()
	EndIf
EndFunction

Function ToggleGuardBehavWeapDrawn()
	If GuardBehavWeapDrawn
		PlayerRef.AddSpell(_SLS_WeaponReadySpell, false)
	Else
		If !MinAvToggleT
			PlayerRef.RemoveSpell(_SLS_WeaponReadySpell)
		EndIf
		_SLS_GuardWarnWeapDrawnQuest.Stop()
		;_SLS_GuardWarnWeapDrawnDetectionQuest.Stop()
	EndIf
EndFunction

Function ToggleGuardBehavWeapEquip()
	If GuardBehavWeapEquip && Init.IsPlayerInside
		_SLS_GuardWarnWeapEquippedQuest.Start()
	Else
		_SLS_GuardWarnWeapEquippedQuest.Stop()
		;_SLS_GuardWarnWeapEquippedDetectQuest.Stop()
	EndIf
EndFunction

Function ToggleGuardBehavArmorEquip()
	If GuardBehavArmorEquip && Init.IsPlayerInside
		_SLS_GuardWarnArmorEquippedQuest.Start()
	Else
		_SLS_GuardWarnArmorEquippedQuest.Stop()
		;_SLS_GuardWarnArmorEquippedDetectQuest.Stop()
	EndIf
EndFunction

Function ToggleGuardComments()
	If GuardComments
		_SLS_GuardHellosQuest.Start()
	Else
		_SLS_GuardHellosQuest.Stop()
	EndIf
EndFunction

Function ToggleCumAsLactacid(VoiceType Voice)
	; Send Voice = None to toggle all
	If Voice ; Add/Remove specific voice
		If _SLS_CumHasLactacidVoices.HasForm(Voice)
			_SLS_CumHasLactacidVoices.RemoveAddedForm(Voice)
		Else
			_SLS_CumHasLactacidVoices.AddForm(Voice)
		EndIf
		
	Else ; Toggle All
		If CumLactacidAll
			Form akForm
			Int i = 0
			While i < _SLS_CumLactacidVoicesList.GetSize()
				_SLS_CumHasLactacidVoices.AddForm(_SLS_CumLactacidVoicesList.GetAt(i))
				i += 1
			EndWhile
		Else
			_SLS_CumHasLactacidVoices.Revert()
		EndIf
	EndIf
EndFunction

Function ToggleCumAsLactacidCustom()
	Actor akActor = Game.GetCurrentCrosshairRef() as Actor
	If akActor
		VoiceType Voice = akActor.GetVoiceType()
		If Voice
			If _SLS_CumHasLactacidVoices.HasForm(Voice)
				_SLS_CumHasLactacidVoices.RemoveAddedForm(Voice)
			Else
				_SLS_CumHasLactacidVoices.AddForm(Voice)
			EndIf
		EndIf
	EndIf
EndFunction

Function ToggleProxSpank()
	_SLS_HelloSpankAnythingQuest.Stop()
	_SLS_HelloSpankGuardsQuest.Stop()
	_SLS_HelloSpankGuardsAndMenQuest.Stop()
	_SLS_HelloSpankMenQuest.Stop()
	_SLS_HelloSpankWomenQuest.Stop()
	
	If Game.GetModByName("Spank That Ass.esp") == 255
		ProxSpankNpcType = 5
	EndIf
	
	If ProxSpankNpcType == 0
		_SLS_HelloSpankGuardsQuest.Start()
	ElseIf ProxSpankNpcType == 1
		_SLS_HelloSpankGuardsAndMenQuest.Start()
	ElseIf ProxSpankNpcType == 2
		_SLS_HelloSpankMenQuest.Start()
	ElseIf ProxSpankNpcType == 3
		_SLS_HelloSpankWomenQuest.Start()
	ElseIf ProxSpankNpcType == 4
		_SLS_HelloSpankAnythingQuest.Start()		
	EndIf
EndFunction

Function ToggleCumAddiction()
	If CumAddictEn
		(Game.GetFormFromFile(0x097F8F, "SL Survival.esp")as Quest).Start() ; _SLS_CumAddictQuest
	Else
		PlayerRef.RemoveSpell(_SLS_CumAddictHungerSpell)
		CumAddict.ToggleDaydreaming(false)
		Utility.Wait(0.1)
		PlayerRef.RemoveSpell(_SLS_CumAddictStatusSpell)
		(Game.GetFormFromFile(0x097F8F, "SL Survival.esp") as Quest).Stop() ; _SLS_CumAddictQuest
		(Game.GetFormFromFile(0x0850D2, "SL Survival.esp") as _SLS_Api).SendCumHungerChangeEvent(HungerState = -1)
	EndIf
EndFunction

Function ToggleCoverMechanics()
	If CoverMyselfMechanics
		;If IsCoverAnimationInstalled()
			If _SLS_BodyCoverStatus.GetValueInt() == 0 ; Player is naked
				_SLS_CoverMySelfQuest.Start()
			Else
				_SLS_CoverMySelfQuest.Stop()
				;Debug.SendAnimationEvent(PlayerRef, "IdleForceDefaultState")
				Debug.SendAnimationEvent(PlayerRef, "OffsetStop")
			EndIf
		;/Else
			CoverMyselfMechanics = false
			_SLS_CoverMySelfQuest.Stop()
			;Debug.SendAnimationEvent(PlayerRef, "IdleForceDefaultState")
			Debug.SendAnimationEvent(PlayerRef, "OffsetStop")
			_SLS_CoveringNakedStatus.SetValueInt(1)
		EndIf/;
	Else
		_SLS_CoverMySelfQuest.Stop()
		;Debug.SendAnimationEvent(PlayerRef, "IdleForceDefaultState")
		Debug.SendAnimationEvent(PlayerRef, "OffsetStop")
		_SLS_CoveringNakedStatus.SetValueInt(1)
	EndIf
EndFunction
;/
Bool Function IsCoverAnimationInstalled()
	;If MiscUtil.FileExists("data/Meshes/actors/character/animations/ZaZAnimationPack/ZaZAPCSHFOFF.HKX")
	If MiscUtil.FileExists("data/Meshes/Actors/Character/Animations/Deviously Cursed Loot/DCLFTNudeCoverOff.HKX")
		Return true
	EndIf
	Return false
EndFunction
/;
Function ToggleCumAddictAutoSuckCreature()
	If CumAddictAutoSuckCreature == 0.0
		_SLS_CumAddictAutoSuckCreatureQuest.Stop()
	Else
		If CumAddict.GetHungerState() >= 1
			_SLS_CumAddictAutoSuckCreatureQuest.Start()
		EndIf
	EndIf
EndFunction

String Function TidyFormString(Form akForm)
	; Example: Returns 'ImperialRace' FROM '[Race <ImperialRace (00013744)>]'
	String S1 = StringUtil.Substring(akForm, StringUtil.Find(akForm, "<", 0) + 1)
	Return StringUtil.Substring(S1, 0, len = StringUtil.Find(S1, " (", 0))
EndFunction

Function ToggleSexExp()
	If SexExpEn
		If Game.GetModByName("SLSO.esp") != 255
			_SLS_SexExperienceQuest.Start()
		Else
			SexExpEn = false
			_SLS_SexExperienceQuest.Stop()
			_SLS_SexCockSizeQuest.Stop()
		EndIf
	Else
		_SLS_SexExperienceQuest.Stop()
		_SLS_SexCockSizeQuest.Stop()
	EndIf
EndFunction

Function ResetSexExpStats()
	Int i = 0
	Form akForm
	While i < StorageUtil.FormListCount(None, "_SLS_HumanSexForms")
		akForm = StorageUtil.FormListGet(None, "_SLS_HumanSexForms", i)
		StorageUtil.UnsetIntValue(akForm, "_SLS_SexExperienceFemale")
		StorageUtil.UnsetIntValue(akForm, "_SLS_SexExperienceMale")
		i += 1
	EndWhile
	StorageUtil.FormListClear(None, "_SLS_HumanSexForms")
	
	i = 0
	While i < StorageUtil.FormListCount(None, "_SLS_CreatureSexForms")
		akForm = StorageUtil.FormListGet(None, "_SLS_CreatureSexForms", i)
		StorageUtil.UnsetIntValue(akForm, "_SLS_SexExperience")
		i += 1
	EndWhile
	StorageUtil.FormListClear(None, "_SLS_CreatureSexForms")
	
	StorageUtil.UnSetIntValue(None, "_SLS_CreatureSexOrgasmCount")
	StorageUtil.UnSetIntValue(None, "_SLS_HumanSexOrgasmCount")
	StorageUtil.UnSetIntValue(None, "_SLS_CreatureSexCount")
	StorageUtil.UnSetIntValue(None, "_SLS_HumanSexCount")
	
	StorageUtil.UnSetFloatValue(None, "_SLS_CreatureCorruption")
EndFunction

Function ToggleIneqStrongFemaleFollowers()
	; Do vanilla followers
	Actor Follower
	Actor[] FolList = new Actor[23]
	FolList[0] = Game.GetFormFromFile(0x01C1A4, "Skyrim.esm") as Actor ; Brelyna
	FolList[1] = Game.GetFormFromFile(0x01A697, "Skyrim.esm") as Actor ; Aela the Huntress
	FolList[2] = Game.GetFormFromFile(0x01A6DA, "Skyrim.esm") as Actor ; Njada Stonearm
	FolList[3] = Game.GetFormFromFile(0x01A6D8, "Skyrim.esm") as Actor ; Ria
	FolList[4] = Game.GetFormFromFile(0x015D09, "Skyrim.esm") as Actor ; Dark Brotherhood Initiate (female)
	FolList[5] = Game.GetFormFromFile(0x0E1BA9, "Skyrim.esm") as Actor ; Jenassa
	FolList[6] = Game.GetFormFromFile(0x0A2C93, "Skyrim.esm") as Actor ; Iona
	FolList[7] = Game.GetFormFromFile(0x0A2C95, "Skyrim.esm") as Actor ; Jordis the Sword-Maiden
	FolList[8] = Game.GetFormFromFile(0x0A2C94, "Skyrim.esm") as Actor ; Lydia
	FolList[9] = Game.GetFormFromFile(0x05B688, "Skyrim.esm") as Actor ; Borgakh the Steel Heart
	FolList[10] = Game.GetFormFromFile(0x019E1B, "Skyrim.esm") as Actor ; Ugor
	FolList[11] = Game.GetFormFromFile(0x01B13E, "Skyrim.esm") as Actor ; Adelaisa Vendicci
	FolList[12] = Game.GetFormFromFile(0x01B092, "Skyrim.esm") as Actor ; Annekke Crag-Jumper
	FolList[13] = Game.GetFormFromFile(0x028AD1, "Skyrim.esm") as Actor ; Aranea Ienith
	FolList[14] = Game.GetFormFromFile(0x01BB8E, "Skyrim.esm") as Actor ; Eola
	FolList[15] = Game.GetFormFromFile(0x019DF7, "Skyrim.esm") as Actor ; Mjoll the Lioness
	FolList[16] = Game.GetFormFromFile(0x091918, "Skyrim.esm") as Actor ; Uthgerd the Unbroken
	FolList[17] = Game.GetFormFromFile(0x013485, "Skyrim.esm") as Actor ; Delphine
	
	; Dawnguard
	FolList[18] = Game.GetFormFromFile(0x015C14, "Skyrim.esm") as Actor ; Beleval
	FolList[19] = Game.GetFormFromFile(0x015C17, "Skyrim.esm") as Actor ; Ingjard
	FolList[20] = Game.GetFormFromFile(0x002B74, "Skyrim.esm") as Actor ; Serana
	
	; Dragonborn
	FolList[21] = Game.GetFormFromFile(0x017A0D, "Skyrim.esm") as Actor ; Frea
	
	; Hearthfire
	FolList[22] = Game.GetFormFromFile(0x005216, "Skyrim.esm") as Actor ; Rayya
	
	Int i = FolList.Length
	While i > 0
		i -= 1
		Follower = FolList[i]
		SetStrongFollower(Follower)
	EndWhile
	
	; Do escorts
	i = JsonUtil.FormListCount("SL Survival/EscortList.json", "Escorts")
	While i > 0
		i -= 1
		Follower = JsonUtil.FormListGet("SL Survival/EscortList.json", "Escorts", i) as Actor
		SetStrongFollower(Follower)
	EndWhile
EndFunction

Function SetStrongFollower(Actor Follower)
	If Follower && Follower.GetActorBase().GetSex() == 1
		If IneqStrongFemaleFollowers
			Follower.AddToFaction(_SLS_IneqStrongFemaleFact)
		Else
			Follower.RemoveFromFaction(_SLS_IneqStrongFemaleFact)
		EndIf
	EndIf
EndFunction

Function SetStrongFemale()
	Actor CrossHairRef = Game.GetCurrentCrosshairRef() as Actor
	If CrossHairRef && CrossHairRef.GetLeveledActorBase().GetSex() == 1
		If !CrossHairRef.IsInFaction(_SLS_IneqStrongFemaleFact)
			CrossHairRef.AddToFaction(_SLS_IneqStrongFemaleFact)
			JsonUtil.FormListAdd("SL Survival/StrongFemales.json", "StrongFemales", CrossHairRef, allowDuplicate = false)
		Else
			CrossHairRef.RemoveFromFaction(_SLS_IneqStrongFemaleFact)
			JsonUtil.FormListRemove("SL Survival/StrongFemales.json", "StrongFemales", CrossHairRef, allInstances = true)
		EndIf
		JsonUtil.Save("SL Survival/StrongFemales.json")
	EndIf
EndFunction

Function ImportStrongFemales()
	Actor Female
	Int i = JsonUtil.FormListCount("SL Survival/StrongFemales.json", "StrongFemales")
	While i > 0
		i -= 1
		Female = JsonUtil.FormListGet("SL Survival/StrongFemales.json", "StrongFemales", i) as Actor
		If Female
			Female.AddToFaction(_SLS_IneqStrongFemaleFact)
		EndIf
	EndWhile
EndFunction

Function AddRemoveChainCollars(Bool AddToList)
	;Debug.MessageBox("AddRemoveChainCollars: " + AddToList + ". Count before: " + JsonUtil.FormListCount("SL Survival/DeviceList.json", "steelcollars"))
	If AddToList
		JsonUtil.FormListAdd("SL Survival/DeviceList.json", "steelcollars", Game.GetFormFromFile(0x02E4DE, "Devious Devices - Expansion.esm"), allowDuplicate = false)
		JsonUtil.FormListAdd("SL Survival/DeviceList.json", "steelcollars", Game.GetFormFromFile(0x02E4DF, "Devious Devices - Expansion.esm"), allowDuplicate = false)
		JsonUtil.FormListAdd("SL Survival/DeviceList.json", "steelcollars", Game.GetFormFromFile(0x02E4DD, "Devious Devices - Expansion.esm"), allowDuplicate = false)
		JsonUtil.FormListAdd("SL Survival/DeviceList.json", "steelcollars", Game.GetFormFromFile(0x02E4DC, "Devious Devices - Expansion.esm"), allowDuplicate = false)
		JsonUtil.FormListAdd("SL Survival/DeviceList.json", "steelcollars", Game.GetFormFromFile(0x02E4E2, "Devious Devices - Expansion.esm"), allowDuplicate = false)
		JsonUtil.FormListAdd("SL Survival/DeviceList.json", "steelcollars", Game.GetFormFromFile(0x02E4E3, "Devious Devices - Expansion.esm"), allowDuplicate = false)
		JsonUtil.FormListAdd("SL Survival/DeviceList.json", "steelcollars", Game.GetFormFromFile(0x02E4E1, "Devious Devices - Expansion.esm"), allowDuplicate = false)
		JsonUtil.FormListAdd("SL Survival/DeviceList.json", "steelcollars", Game.GetFormFromFile(0x02E4E0, "Devious Devices - Expansion.esm"), allowDuplicate = false)
		
		JsonUtil.FormListAdd("SL Survival/DeviceList.json", "collars", Game.GetFormFromFile(0x02E4DE, "Devious Devices - Expansion.esm"), allowDuplicate = false)
		JsonUtil.FormListAdd("SL Survival/DeviceList.json", "collars", Game.GetFormFromFile(0x02E4DF, "Devious Devices - Expansion.esm"), allowDuplicate = false)
		JsonUtil.FormListAdd("SL Survival/DeviceList.json", "collars", Game.GetFormFromFile(0x02E4DD, "Devious Devices - Expansion.esm"), allowDuplicate = false)
		JsonUtil.FormListAdd("SL Survival/DeviceList.json", "collars", Game.GetFormFromFile(0x02E4DC, "Devious Devices - Expansion.esm"), allowDuplicate = false)
		JsonUtil.FormListAdd("SL Survival/DeviceList.json", "collars", Game.GetFormFromFile(0x02E4E2, "Devious Devices - Expansion.esm"), allowDuplicate = false)
		JsonUtil.FormListAdd("SL Survival/DeviceList.json", "collars", Game.GetFormFromFile(0x02E4E3, "Devious Devices - Expansion.esm"), allowDuplicate = false)
		JsonUtil.FormListAdd("SL Survival/DeviceList.json", "collars", Game.GetFormFromFile(0x02E4E1, "Devious Devices - Expansion.esm"), allowDuplicate = false)
		JsonUtil.FormListAdd("SL Survival/DeviceList.json", "collars", Game.GetFormFromFile(0x02E4E0, "Devious Devices - Expansion.esm"), allowDuplicate = false)
	Else
		JsonUtil.FormListRemove("SL Survival/DeviceList.json", "steelcollars", Game.GetFormFromFile(0x02E4DE, "Devious Devices - Expansion.esm"), allInstances = true)
		JsonUtil.FormListRemove("SL Survival/DeviceList.json", "steelcollars", Game.GetFormFromFile(0x02E4DF, "Devious Devices - Expansion.esm"), allInstances = true)
		JsonUtil.FormListRemove("SL Survival/DeviceList.json", "steelcollars", Game.GetFormFromFile(0x02E4DD, "Devious Devices - Expansion.esm"), allInstances = true)
		JsonUtil.FormListRemove("SL Survival/DeviceList.json", "steelcollars", Game.GetFormFromFile(0x02E4DC, "Devious Devices - Expansion.esm"), allInstances = true)
		JsonUtil.FormListRemove("SL Survival/DeviceList.json", "steelcollars", Game.GetFormFromFile(0x02E4E2, "Devious Devices - Expansion.esm"), allInstances = true)
		JsonUtil.FormListRemove("SL Survival/DeviceList.json", "steelcollars", Game.GetFormFromFile(0x02E4E3, "Devious Devices - Expansion.esm"), allInstances = true)
		JsonUtil.FormListRemove("SL Survival/DeviceList.json", "steelcollars", Game.GetFormFromFile(0x02E4E1, "Devious Devices - Expansion.esm"), allInstances = true)
		JsonUtil.FormListRemove("SL Survival/DeviceList.json", "steelcollars", Game.GetFormFromFile(0x02E4E0, "Devious Devices - Expansion.esm"), allInstances = true)
		
		JsonUtil.FormListRemove("SL Survival/DeviceList.json", "collars", Game.GetFormFromFile(0x02E4DE, "Devious Devices - Expansion.esm"), allInstances = true)
		JsonUtil.FormListRemove("SL Survival/DeviceList.json", "collars", Game.GetFormFromFile(0x02E4DF, "Devious Devices - Expansion.esm"), allInstances = true)
		JsonUtil.FormListRemove("SL Survival/DeviceList.json", "collars", Game.GetFormFromFile(0x02E4DD, "Devious Devices - Expansion.esm"), allInstances = true)
		JsonUtil.FormListRemove("SL Survival/DeviceList.json", "collars", Game.GetFormFromFile(0x02E4DC, "Devious Devices - Expansion.esm"), allInstances = true)
		JsonUtil.FormListRemove("SL Survival/DeviceList.json", "collars", Game.GetFormFromFile(0x02E4E2, "Devious Devices - Expansion.esm"), allInstances = true)
		JsonUtil.FormListRemove("SL Survival/DeviceList.json", "collars", Game.GetFormFromFile(0x02E4E3, "Devious Devices - Expansion.esm"), allInstances = true)
		JsonUtil.FormListRemove("SL Survival/DeviceList.json", "collars", Game.GetFormFromFile(0x02E4E1, "Devious Devices - Expansion.esm"), allInstances = true)
		JsonUtil.FormListRemove("SL Survival/DeviceList.json", "collars", Game.GetFormFromFile(0x02E4E0, "Devious Devices - Expansion.esm"), allInstances = true)
	EndIf
	JsonUtil.Save("SL Survival/DeviceList.json")
	;Debug.MessageBox("AddRemoveChainCollars: " + AddToList + ". Count After: " + JsonUtil.FormListCount("SL Survival/DeviceList.json", "steelcollars"))
EndFunction

Function ReplaceVanillaMaps(Bool AddMaps)
	Int i = _SLS_StaticMapList.GetSize()
	ObjectReference Map
	While i > 0
		i -= 1
		Map = _SLS_StaticMapList.GetAt(i) as ObjectReference
		If AddMaps
			Map.Disable()
		Else
			Map.Enable()
		EndIf
	EndWhile

	i = _SLS_ActivatableMapList.GetSize()
	While i > 0
		i -= 1
		Map = _SLS_ActivatableMapList.GetAt(i) as ObjectReference
		If AddMaps
			Map.Enable()
		Else
			Map.Disable()
		EndIf
	EndWhile
EndFunction

Function ToggleStashTracking()
	If StashTrackEn
		_SLS_StashTrack.Start()
	Else
		StashTrack.TerminateTracking()
	EndIf
EndFunction

Function StashClearAllStashExceptions()
	StashClearAllJsonExceptions()
	StashClearAllTempExceptions()
EndFunction

Function StashClearAllJsonExceptions()
	ObjectReference ObjRef
	Int i = JsonUtil.FormListCount("SL Survival/StashExceptions.json", "StashExceptions")
	While i > 0
		i -= 1
		ObjRef = JsonUtil.FormListGet("SL Survival/StashExceptions.json", "StashExceptions", i) as ObjectReference
		If ObjRef
			StorageUtil.UnSetIntValue(ObjRef, "_SLS_StashExceptionContainer")
			StorageUtil.FormListRemove(None, "_SLS_StashExceptionsAll", ObjRef, allInstances = true)
		EndIf
	EndWhile
	JsonUtil.FormListClear("SL Survival/StashExceptions.json", "StashExceptions")
	JsonUtil.Save("SL Survival/StashExceptions.json")
EndFunction

Function StashClearAllTempExceptions()
	ObjectReference ObjRef
	Int i = StorageUtil.FormListCount(None, "_SLS_StashExceptionsTemp")
	While i > 0
		i -= 1
		ObjRef = StorageUtil.FormListGet(None, "_SLS_StashExceptionsTemp", i) as ObjectReference
		If ObjRef
			StorageUtil.UnSetIntValue(ObjRef, "_SLS_StashExceptionContainer")
			StorageUtil.FormListRemove(None, "_SLS_StashExceptionsAll", ObjRef, allInstances = true)
		EndIf		
	EndWhile
	StorageUtil.FormListClear(None, "_SLS_StashExceptionsTemp")
EndFunction

Function SearchEscorts()
	; Populate forbidden escorts before scan
	Formlist ForbiddenEscorts = Game.GetFormFromFile(0x0E0928, "SL Survival.esp") as Formlist
	ForbiddenEscorts.Revert()
	Form akForm
	String CurModName
	Int i = 0
	While i < JsonUtil.StringListCount("SL Survival/ForbiddenEscorts.json", "modnames")
		CurModName = JsonUtil.StringListGet("SL Survival/ForbiddenEscorts.json", "modnames", i)
		If Game.GetModByName(CurModName) != 255
			Int j = 0
			;Debug.Messagebox("CurModName: " + CurModName + "\nCount: "  + JsonUtil.FormListCount("SL Survival/ForbiddenEscorts.json", CurModName))
			While j < JsonUtil.FormListCount("SL Survival/ForbiddenEscorts.json", CurModName)
				akForm = JsonUtil.FormListGet("SL Survival/ForbiddenEscorts.json", CurModName, j)
				If akForm
					ForbiddenEscorts.AddForm(akForm)
				EndIf
				j += 1
			EndWhile
		EndIf
		i += 1
	EndWhile
	
	If Game.GetModByName("Dawnguard.esm") != 255
		_SLS_EscortsVanilla.AddForm(Game.GetFormFromFile(0x00336E, "Dawnguard.esm"))
		_SLS_EscortsVanilla.AddForm(Game.GetFormFromFile(0x01541C, "Dawnguard.esm"))
		_SLS_EscortsVanilla.AddForm(Game.GetFormFromFile(0x01541E, "Dawnguard.esm"))
		_SLS_EscortsVanilla.AddForm(Game.GetFormFromFile(0x01541D, "Dawnguard.esm"))
		_SLS_EscortsVanilla.AddForm(Game.GetFormFromFile(0x01541B, "Dawnguard.esm"))
		_SLS_EscortsVanilla.AddForm(Game.GetFormFromFile(0x002B6C, "Dawnguard.esm"))
	EndIf
	If Game.GetModByName("HearthFires.esm") != 255
		_SLS_EscortsVanilla.AddForm(Game.GetFormFromFile(0x00521E, "HearthFires.esm"))
		_SLS_EscortsVanilla.AddForm(Game.GetFormFromFile(0x005215, "HearthFires.esm"))
		_SLS_EscortsVanilla.AddForm(Game.GetFormFromFile(0x00521B, "HearthFires.esm"))		
	EndIf
	If Game.GetModByName("Dragonborn.esm") != 255
		_SLS_EscortsVanilla.AddForm(Game.GetFormFromFile(0x017934, "Dragonborn.esm"))
		_SLS_EscortsVanilla.AddForm(Game.GetFormFromFile(0x017777, "Dragonborn.esm"))
		_SLS_EscortsVanilla.AddForm(Game.GetFormFromFile(0x038560, "Dragonborn.esm"))
		_SLS_EscortsVanilla.AddForm(Game.GetFormFromFile(0x0179C7, "Dragonborn.esm"))
	EndIf

	Int FollowersAddedTotal = 0
	Int NewFolCount = 1
	Int Button = 1
	Actor Follower
	String[] EscortPlusModname = new String[15]
	While Button == 1 && NewFolCount > 0
		i = _SLS_EscortsList.GetSize()
		While i > 0
			i -= 1
			_SLS_EscortsBaseList.AddForm((_SLS_EscortsList.GetAt(i) as ObjectReference).GetBaseObject())
		EndWhile
	
		_SLS_FindEscortsQuest.Stop()
		_SLS_FindEscortsQuest.Start()
		Utility.Wait(1.0)
		NewFolCount = 0
		i = 0
		;Debug.Trace("_SLS_: Escorts: LOOP START ====================================")
		While i < _SLS_FindEscortsQuest.GetNumAliases()
			Follower = (_SLS_FindEscortsQuest.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
			If Follower
				EscortPlusModname[i] = "\n" + (i + 1) + ") " + Follower.GetBaseObject().GetName() + " | " + Game.GetModName(Math.RightShift(Math.LogicalAnd(Follower.GetFormID(), 0xFF000000), 24))
				;NewFols += "\n" + (i + 1) + ") " + Follower.GetBaseObject().GetName() + " - " + Game.GetModName(Math.RightShift(Math.LogicalAnd(Follower.GetFormID(), 0xFF000000), 24))
				;Debug.Trace("_SLS_: Escorts: " + (i + 1) + ") " + Follower.GetBaseObject().GetName())
				
				NewFolCount += 1
			Else
				;Debug.Trace("_SLS_: Escorts: " + (i + 1) + ") Nothing here apparently????")
				;EscortPlusModname[i] = "\n" + (i + 1) + ") Nothing here ???"
				EscortPlusModname[i] = ""
			EndIf
			i += 1
		EndWhile

		If NewFolCount > 0
			Debug.Messagebox("Found these followers:" + EscortPlusModname[0] + EscortPlusModname[1] + EscortPlusModname[2] + EscortPlusModname[3] + EscortPlusModname[4] + EscortPlusModname[5] + EscortPlusModname[6] + EscortPlusModname[7] + EscortPlusModname[8] + EscortPlusModname[9] + EscortPlusModname[10] + EscortPlusModname[11] + EscortPlusModname[12] + EscortPlusModname[13] + EscortPlusModname[14])
		Else
			Debug.Messagebox("No more followers found")
		EndIf
		
		If NewFolCount > 0
			Button = _SLS_AddEscortsMsg.Show()
			If Button == 1 
				i = 0
				While i < _SLS_FindEscortsQuest.GetNumAliases()
					Follower = (_SLS_FindEscortsQuest.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
					If Follower
						_SLS_EscortsList.AddForm(Follower)
						JsonUtil.FormListAdd("SL Survival/EscortList.json", "Escorts", Follower, allowDuplicate = false)
						SetStrongFollower(Follower)	
						FollowersAddedTotal += 1
					EndIf
					i += 1
				EndWhile
				
				JsonUtil.Save("SL Survival/EscortList.json")
			EndIf
		EndIf
		;Debug.Messagebox("_SLS_EscortsList.GetSize(): " + _SLS_EscortsList.GetSize() + "\nNewFolCount: " + NewFolCount + "\nButton: " + Button)
		_SLS_EscortsBaseList.Revert()
	EndWhile
	Debug.Messagebox("Done adding escorts!\nTotal escorts added: " + FollowersAddedTotal)
EndFunction

Function ReImportEscorts()
	_SLS_EscortsList.Revert()
	ImportEscorts()
EndFunction

Function ClearAllEscorts()
	_SLS_EscortsList.Revert()
	JsonUtil.FormListClear("SL Survival/EscortList.json", "Escorts")
	JsonUtil.Save("SL Survival/EscortList.json")
EndFunction

Bool Function CanEnableSnowberry()
	If Game.GetModByName("Skyrim Unbound.esp") != 255 ; Unbound
		If (Game.GetFormFromFile(0x000D62, "Skyrim Unbound.esp") as Quest).GetCurrentStageID() < 100
			Return true
		EndIf
	ElseIf MQ101.GetCurrentStageID() < 240 ; Alternate Start / Vanilla
		Return true
	EndIf
	Return false
EndFunction

Function SetGagSpeechDebuff()
	; ForceIt - Spell Mag changes don't persist through game loads anyway
	If (Game.GetModByName("Devious Devices - Integration.esm") != 255)
		Spell GagDebuff = Game.GetFormFromFile(0x04B63C, "Devious Devices - Integration.esm") as Spell
		GagDebuff.SetNthEffectMagnitude(0, DeviousGagDebuff)
	EndIf
EndFunction

Bool Function GetIsSleepDeprivationEnabled()
	Return SleepDepriv
EndFunction

Function ToggleNpcComments()
	If (Game.GetFormFromFile(0x0DF88F, "SL Survival.esp") as GlobalVariable).GetValueInt() == 0 ; _SLS_NpcComments
		(Game.GetFormFromFile(0x0DEDA7, "SL Survival.esp") as Quest).Stop() ; _SLS_NpcHellosQuest
	Else
		(Game.GetFormFromFile(0x0DEDA7, "SL Survival.esp") as Quest).Start() ; _SLS_NpcHellosQuest
	EndIf
EndFunction

Function ToggleJiggles()
	(Game.GetFormFromFile(0x0CF9B1, "SL Survival.esp") as _SLS_BodyInflationTracking).ToggleJiggles(DoEnable = StorageUtil.GetIntValue(Self, "Jiggles", Missing = 1) as Bool)
EndFunction

Function ToggleCompulsiveSex()
	If StorageUtil.GetIntValue(Self, "CompulsiveSex", Missing = 1) == 0
		(Game.GetFormFromFile(0x0E7553, "SL Survival.esp") as Quest).Stop()
	Else
		(Game.GetFormFromFile(0x0E7553, "SL Survival.esp") as Quest).Start()
	EndIf
EndFunction

Function ToggleOrgasmFatigue()
	If StorageUtil.GetIntValue(Self, "OrgasmFatigue", Missing = 1) == 0
		(Game.GetFormFromFile(0x0E857D, "SL Survival.esp") as _SLS_OrgasmFatigue).Shutdown()
	Else
		(Game.GetFormFromFile(0x0E857D, "SL Survival.esp") as Quest).Start()
	EndIf
EndFunction

Function TestBikiniArmor()
	String OutStr = "Slot) Armor Name - HasKeyword - BikiniFlag\n\n"
	Form akForm
	Keyword BikiniKeyword = Game.GetFormFromFile(0x049867, "SL Survival.esp") as Keyword
	Int i = 0
	While i < SlotMasks.Length
		akForm = PlayerRef.GetWornForm(SlotMasks[i])
		If akForm && akForm.GetName() != ""
			OutStr += (i+30) + ") " + akForm.GetName() + " - " + TranslateBoolToYesNo(akForm.HasKeyword(BikiniKeyword)) + " - " + TranslateBoolToYesNo(StorageUtil.GetIntValue(akForm, "SLAroused.IsSlootyArmor", Missing = -1) > 0) + "\n"
		EndIf
		i += 1
	EndWhile
	
	OutStr += "\nHeels - NiO (Height) - HDT - KillerHeelsFlag\n"
	akForm = PlayerRef.GetWornForm(0x00000080)
	If akForm
		Bool IsHdtHeels
		MagicEffect HdtHeelsEffect
		If Game.GetModByName("") != 255
			HdtHeelsEffect = Game.GetFormFromFile(0x000800, "hdtHighHeel.esm") as MagicEffect
			IsHdtHeels = PlayerRef.HasMagicEffect(HdtHeelsEffect)
		EndIf
		OutStr += akForm.GetName() + " - " + TranslateBoolToYesNo(NiOverride.HasNodeTransformPosition(PlayerRef, False, true, "NPC", "internal")) + " (" + AllInOne.SnipToDecimalPlaces(NiOverride.GetNodeTransformPosition(PlayerRef, false, true, "NPC", "internal")[2] as String, 1) + ")" + " - " + TranslateBoolToYesNo(IsHdtHeels) + " - " + TranslateBoolToYesNo(StorageUtil.GetIntValue(akForm, "SLAroused.IsKillerHeels", Missing = -1) > 0)
	Else
		OutStr += "None "
	EndIf
	Debug.Messagebox(OutStr)
EndFunction

String Function TranslateBoolToYesNo(Bool Value)
	If Value
		Return "Yes"
	EndIf
	Return "No"
EndFunction

Function ToggleCurfew(Bool Enabled)
	If Enabled
		(Game.GetFormFromFile(0x0E3F3D, "SL Survival.esp") as Quest).Start() ; _SLS_CurfewQuest
	Else
		(Game.GetFormFromFile(0x0E3F3D, "SL Survival.esp") as Quest).Stop() ; _SLS_CurfewQuest
		(Game.GetFormFromFile(0x0E9049, "SL Survival.esp") as Quest).Stop() ; _SLS_CurfewGuardAliases
	EndIf
EndFunction

Function LicenceToggleToggled()
	LicUtil.GetIsAtLeastOneLicenceAvailable()
	LicUtil.UpdateGlobalLicVariables()
EndFunction

Function ToggleTolls()
	Debug.Messagebox("The menu may freeze for a moment...\nBe patient\n\nYou may need to enter/exit towns for changes to take effect")
	Formlist TollObjs = Game.GetFormFromFile(0x0F8868, "SL Survival.esp") as Formlist
	Int i = 0
	If !Init.TollEnable
		TollDodging = false
		DoTollDodgingToggle = true
		DoorLockDownT = false
		ToggleTollGateLocks()
		While i < TollObjs.GetSize()
			(TollObjs.GetAt(i) as ObjectReference).Disable()
			i += 1
		EndWhile
	Else
		DoorLockDownT = false
		TollDodging = false
		If ShowMessage("Do you want to lock the toll doors?")
			DoorLockDownT = true
		EndIf
		If ShowMessage("Do you want to enable toll evasion?\n\nToll Evasion - If you leave town without paying the toll and the grace period expires then guards will be on the look out for you when you return and punish you severely if they catch you.")
			TollDodging = true
		EndIf
		DoTollDodgingToggle = true
		ToggleTollGateLocks()
		While i < TollObjs.GetSize()
			(TollObjs.GetAt(i) as ObjectReference).Enable()
			i += 1
		EndWhile
	EndIf
	ToggleTollGateGuards()
EndFunction

Function ToggleAhegao()
	If StorageUtil.GetIntValue(Self, "AhegaoEnable", Missing = 1) == 1
		(Game.GetFormFromFile(0x0FCE71, "SL Survival.esp") as Quest).Start() ; _SLS_AhegaoQuest
	Else
		(Game.GetFormFromFile(0x0FCE71, "SL Survival.esp") as Quest).Stop() ; _SLS_AhegaoQuest
		AllInOne.AhegaoClear(PlayerRef)
	EndIf
EndFunction

Function BuildBikiniBreakdowns()
	(Game.GetFormFromFile(0x10D7AF, "SL Survival.esp") as _SLS_BikiniBreak).BuildRecipes()
EndFunction

Function ToggleDropStealing()
	(Game.GetFormFromFile(0x1118A4, "SL Survival.esp")as Quest).Stop() ; _SLS_DroppedItemsStealAliases
	(Game.GetFormFromFile(0x1118A2, "SL Survival.esp")as Quest).Stop() ; _SLS_DroppedItemsStealQuest
	If StorageUtil.GetIntValue(Self, "DroppedItemStealingEn", Missing = 1) == 1
		(Game.GetFormFromFile(0x1118A4, "SL Survival.esp")as Quest).Start() ; _SLS_DroppedItemsStealAliases
		(Game.GetFormFromFile(0x1118A2, "SL Survival.esp")as Quest).Start() ; _SLS_DroppedItemsStealQuest
	EndIf
EndFunction

Function ModifyVendorGold(Bool ImportSettings = false)
	If Game.GetModByName("TradeBarter.esp") == 255
		If Main.CanChangeVendorLists()
			If IneqFemaleVendorGoldMult != 1.0
				Main.IneqVendorGoldUpdate()
			ElseIf !ImportSettings
				Main.RestoreVendorGoldDefaults()
			EndIf
		
		Else
			Debug.Messagebox("_SLS_: Something in your load order is removing the necessary leveled lists from vendor gold lists. Check in TesEdit")
		EndIf
	Else
		Debug.Messagebox("_SLS_: Vendor gold inequality can not be turned on with Trade and Barter installed.")
	EndIf
EndFunction

Function ToggleSteepFall()
	SteepFall.Shutdown()
	If StorageUtil.GetIntValue(Self, "SteepFallEnabled", Missing = 0) == 1
		SteepFall.Begin()
	EndIf
EndFunction

Function ToggleCombatEquip()
	Quest _SLS_CombatEquipQuest = Game.GetFormFromFile(0x12872A, "SL Survival.esp") as Quest
	_SLS_CombatEquipQuest.Stop()
	If StorageUtil.GetIntValue(Self, "CombatEquipEnabled", Missing = 1) == 1
		_SLS_CombatEquipQuest.Start()
	EndIf
EndFunction

Function LoadSettings()
	If ShowMessage("Are you sure you want to overwrite your current settings with the settings save in the json file?")
		If IsInMcm
			SetTextOptionValue(ImportSettingsOID_T, "Loading Bools")
		EndIf

		; Bools
		If CanEnableSnowberry()
			SnowberryEnable = JsonUtil.GetIntValue("SL Survival/Settings.json", "SnowberryEnable", missing = 0)
		EndIf
		Init.SlsCreatureEvents = JsonUtil.GetIntValue("SL Survival/Settings.json", "Init.SlsCreatureEvents", missing = 0)
		DropItems = JsonUtil.GetIntValue("SL Survival/Settings.json", "DropItems", missing = 1)
		OrgasmRequired = JsonUtil.GetIntValue("SL Survival/Settings.json", "OrgasmRequired", missing = 1)
		AssSlappingEvents = JsonUtil.GetIntValue("SL Survival/Settings.json", "AssSlappingEvents", missing = 1)
		EasyBedTraps = JsonUtil.GetIntValue("SL Survival/Settings.json", "EasyBedTraps", missing = 1)
		HardcoreMode = JsonUtil.GetIntValue("SL Survival/Settings.json", "HardcoreMode", missing = 0)
		MinAvToggleT = JsonUtil.GetIntValue("SL Survival/Settings.json", "MinAvToggleT", missing = 1)
		CompassMechanics = JsonUtil.GetIntValue("SL Survival/Settings.json", "CompassMechanics", missing = 1)
		FastTravelDisable = JsonUtil.GetIntValue("SL Survival/Settings.json", "FastTravelDisable", missing = 1)
		FtDisableIsNormal = JsonUtil.GetIntValue("SL Survival/Settings.json", "FtDisableIsNormal", missing = 1)
		ReplaceMaps = JsonUtil.GetIntValue("SL Survival/Settings.json", "ReplaceMaps", missing = 1)
		SlaverunAutoStart = JsonUtil.GetIntValue("SL Survival/Settings.json", "SlaverunAutoStart", missing = 0)
		HalfNakedEnable = JsonUtil.GetIntValue("SL Survival/Settings.json", "HalfNakedEnable", missing = 0)
		CumBreath = JsonUtil.GetIntValue("SL Survival/Settings.json", "CumBreath", missing = 1)
		CumBreathNotify = JsonUtil.GetIntValue("SL Survival/Settings.json", "CumBreathNotify", missing = 1)
		MilkDecCumBreath = JsonUtil.GetIntValue("SL Survival/Settings.json", "MilkDecCumBreath", missing = 0)
		CumEffectsEnable = JsonUtil.GetIntValue("SL Survival/Settings.json", "CumEffectsEnable", missing = 1)
		CumEffectsStack = JsonUtil.GetIntValue("SL Survival/Settings.json", "CumEffectsStack", missing = 1)
		CumAddictEn = JsonUtil.GetIntValue("SL Survival/Settings.json", "CumAddictEn", missing = 1)
		CumSwallowInflate = JsonUtil.GetIntValue("SL Survival/Settings.json", "CumSwallowInflate", missing = 1)
		Init.SlsCreatureEvents = JsonUtil.GetIntValue("SL Survival/Settings.json", "Init.SlsCreatureEvents", missing = 0)
		AnimalBreedEnable = JsonUtil.GetIntValue("SL Survival/Settings.json", "AnimalBreedEnable", missing = 0)
		DeviousEffectsEnable = JsonUtil.GetIntValue("SL Survival/Settings.json", "DeviousEffectsEnable", missing = 0)
		DevEffNoGagTradingOID = JsonUtil.GetIntValue("SL Survival/Settings.json", "DevEffNoGagTradingOID", missing = 0)
		BondFurnEnable = JsonUtil.GetIntValue("SL Survival/Settings.json", "BondFurnEnable", missing = 1)
		InequalitySkills = JsonUtil.GetIntValue("SL Survival/Settings.json", "InequalitySkills", missing = 1)
		InequalityBuySell = JsonUtil.GetIntValue("SL Survival/Settings.json", "InequalityBuySell", missing = 1)
		Init.SKdialog = JsonUtil.GetIntValue("SL Survival/Settings.json", "Init.SKdialog", missing = 1)
		SleepDepriv = JsonUtil.GetIntValue("SL Survival/Settings.json", "SleepDepriv", missing = 1)
		BellyScaleEnable = JsonUtil.GetIntValue("SL Survival/Settings.json", "BellyScaleEnable", missing = 1)
		SaltyCum = JsonUtil.GetIntValue("SL Survival/Settings.json", "SaltyCum", missing = 0)
		DoorLockDownT = JsonUtil.GetIntValue("SL Survival/Settings.json", "DoorLockDownT", missing = 1)
		TollUtil.TollCostPerLevel = JsonUtil.GetIntValue("SL Survival/Settings.json", "TollCostPerLevel", missing = 0)
		TollDodging = JsonUtil.GetIntValue("SL Survival/Settings.json", "TollDodging", missing = 1)
		Init.TollDodgeGiftMenu = JsonUtil.GetIntValue("SL Survival/Settings.json", "Init.TollDodgeGiftMenu", missing = 1)
		CurfewEnable = JsonUtil.GetIntValue("SL Survival/Settings.json", "CurfewEnable", missing = 1)
		Init.LicencesEnable = JsonUtil.GetIntValue("SL Survival/Settings.json", "Init.LicencesEnable", missing = 1)
		LicUtil.BuyBack = JsonUtil.GetIntValue("SL Survival/Settings.json", "LicUtil.BuyBack", missing = 0)
		LicUtil.BountyMustBePaid = JsonUtil.GetIntValue("SL Survival/Settings.json", "LicUtil.BountyMustBePaid", missing = 1)
		FolContraBlock = JsonUtil.GetIntValue("SL Survival/Settings.json", "FolContraBlock", missing = 1)
		LicUtil.FollowerWontCarryKeys = JsonUtil.GetIntValue("SL Survival/Settings.json", "LicUtil.FollowerWontCarryKeys", missing = 1)
		LicUtil.FolTakeClothes = JsonUtil.GetIntValue("SL Survival/Settings.json", "LicUtil.FolTakeClothes", missing = 1)
		LicUtil.LicMagicEnable = JsonUtil.GetIntValue("SL Survival/Settings.json", "LicUtil.LicMagicEnable", missing = 1)
		LicUtil.LicMagicCursedDevices = JsonUtil.GetIntValue("SL Survival/Settings.json", "LicUtil.LicMagicCursedDevices", missing = 1)
		LicUtil.CurseTats = JsonUtil.GetIntValue("SL Survival/Settings.json", "LicUtil.CurseTats", missing = 1)
		TradeRestrictions = JsonUtil.GetIntValue("SL Survival/Settings.json", "TradeRestrictions", missing = 1)
		_SLS_ResponsiveEnforcers.SetValueInt(JsonUtil.GetIntValue("SL Survival/Settings.json", "_SLS_ResponsiveEnforcers", missing = 0))
		LicUtil.LicBikiniEnable = JsonUtil.GetIntValue("SL Survival/Settings.json", "LicUtil.LicBikiniEnable", missing = 1)
		LicUtil.BikiniCurseEnable = JsonUtil.GetIntValue("SL Survival/Settings.json", "LicUtil.BikiniCurseEnable", missing = 1)
		BikiniCurse.HeelsRequired = JsonUtil.GetIntValue("SL Survival/Settings.json", "BikiniCurse.HeelsRequired", missing = 1)
		ContTypeCountsT = JsonUtil.GetIntValue("SL Survival/Settings.json", "ContTypeCountsT", missing = 1)
		_SLS_BeggingDialogT.SetValueInt(JsonUtil.GetIntValue("SL Survival/Settings.json", "_SLS_BeggingDialogT", missing = 1))
		_SLS_BegSelfDegradationEnable.SetValueInt(JsonUtil.GetIntValue("SL Survival/Settings.json", "_SLS_BegSelfDegradationEnable", missing = 1))
		StorageUtil.SetIntValue(Self, "KennelSuits", JsonUtil.GetIntValue("SL Survival/Settings.json", "KennelSuits", missing = 0))
		_SLS_KennelExtraDevices.SetValueInt(JsonUtil.GetIntValue("SL Survival/Settings.json", "_SLS_KennelExtraDevices", missing = 1))
		KennelFollowerToggle = JsonUtil.GetIntValue("SL Survival/Settings.json", "KennelFollowerToggle", missing = 1)
		PpSleepNpcPerk = JsonUtil.GetIntValue("SL Survival/Settings.json", "PpSleepNpcPerk", missing = 1)
		PpFailHandle = JsonUtil.GetIntValue("SL Survival/Settings.json", "PpFailHandle", missing = 1)
		PpLootEnable = JsonUtil.GetIntValue("SL Survival/Settings.json", "PpLootEnable", missing = 1)
		DismemberTrollCum = JsonUtil.GetIntValue("SL Survival/Settings.json", "DismemberTrollCum", missing = 1)
		DismemberBathing = JsonUtil.GetIntValue("SL Survival/Settings.json", "DismemberBathing", missing = 1)
		DismemberPlayerSay = JsonUtil.GetIntValue("SL Survival/Settings.json", "DismemberPlayerSay", missing = 1)
		BikiniExpT = JsonUtil.GetIntValue("SL Survival/Settings.json", "BikiniExpT", missing = 1)
		_SLS_BikiniExpReflexes.SetValueInt(JsonUtil.GetIntValue("SL Survival/Settings.json", "_SLS_BikiniExpReflexes", missing = 1))
		LicUtil.AlwaysAwardBikiniLicFirst = JsonUtil.GetIntValue("SL Survival/Settings.json", "AlwaysAwardBikiniLicFirst", missing = 1)
		_SLS_GuardBehavWeapDropEn.SetValueInt(JsonUtil.GetIntValue("SL Survival/Settings.json", "_SLS_GuardBehavWeapDropEn", missing = 1))
		_SLS_GuardBehavShoutEn.SetValueInt(JsonUtil.GetIntValue("SL Survival/Settings.json", "_SLS_GuardBehavShoutEn", missing = 1))
		GuardBehavWeapDrawn = JsonUtil.GetIntValue("SL Survival/Settings.json", "GuardBehavWeapDrawn", missing = 1)
		GuardBehavLockpicking = JsonUtil.GetIntValue("SL Survival/Settings.json", "GuardBehavLockpicking", missing = 1)
		GuardBehavDrugs = JsonUtil.GetIntValue("SL Survival/Settings.json", "GuardBehavDrugs", missing = 1)
		GuardBehavArmorEquip = JsonUtil.GetIntValue("SL Survival/Settings.json", "GuardBehavArmorEquip", missing = 0)
		GuardBehavWeapEquip = JsonUtil.GetIntValue("SL Survival/Settings.json", "GuardBehavWeapEquip", missing = 1)
		GuardComments = JsonUtil.GetIntValue("SL Survival/Settings.json", "GuardComments", missing = 1)
		CumLactacidAll = JsonUtil.GetIntValue("SL Survival/Settings.json", "CumLactacidAll", missing = 0)
		CumLactacidAllPlayable = JsonUtil.GetIntValue("SL Survival/Settings.json", "CumLactacidAllPlayable", missing = 0)
		LicUtil.OrdinSupress = JsonUtil.GetIntValue("SL Survival/Settings.json", "OrdinSupress", missing = 0)
		Util.ProxSpankComment = JsonUtil.GetIntValue("SL Survival/Settings.json", "ProxSpankComment", missing = 0)
		CoverMyselfMechanics = JsonUtil.GetIntValue("SL Survival/Settings.json", "CoverMyselfMechanics", missing = 0)
		StorageUtil.SetIntValue(Self, "CumAddictDayDream", JsonUtil.GetIntValue("SL Survival/Settings.json", "CumAddictDayDream", missing = 1))
		CumAddictClampHunger = JsonUtil.GetIntValue("SL Survival/Settings.json", "CumAddictClampHunger", missing = 1)
		CumAddictBeastLevels = JsonUtil.GetIntValue("SL Survival/Settings.json", "CumAddictBeastLevels", missing = 0)
		TollFollowersHardcore = JsonUtil.GetIntValue("SL Survival/Settings.json", "TollFollowersHardcore", missing = 0)
		SexExpEn = JsonUtil.GetIntValue("SL Survival/Settings.json", "SexExpEn", missing = 1)
		IneqStrongFemaleFollowers = JsonUtil.GetIntValue("SL Survival/Settings.json", "IneqStrongFemaleFollowers", missing = 0)
		LicMagicChainCollars = JsonUtil.GetIntValue("SL Survival/Settings.json", "LicMagicChainCollars", missing = 0)
		StashTrackEn = JsonUtil.GetIntValue("SL Survival/Settings.json", "StashTrackEn", missing = 1)
		_SLS_MapAndCompassRecipeEnable.SetValueInt(JsonUtil.GetIntValue("SL Survival/Settings.json", "_SLS_MapAndCompassRecipeEnable", missing = 1))
		CumAddict.CumBlocksAddictionDecay = JsonUtil.GetIntValue("SL Survival/Settings.json", "CumBlocksAddictionDecay", missing = 1)
		DeviousEffects.DeviousDrowning = JsonUtil.GetIntValue("SL Survival/Settings.json", "DeviousDrowning", missing = 1)
		StorageUtil.SetIntValue(Self, "CumAddictDayDreamButterflys", JsonUtil.GetIntValue("SL Survival/Settings.json", "CumAddictDayDreamButterflys", missing = 1))
		ForceDrug.RapeDrugLactacid = JsonUtil.GetIntValue("SL Survival/Settings.json", "RapeDrugLactacid", missing = (Game.GetModByName("MilkModNEW.esp") != 255) as Int)
		ForceDrug.RapeDrugSkooma = JsonUtil.GetIntValue("SL Survival/Settings.json", "RapeDrugSkooma", missing = (Game.GetModByName("SexLabSkoomaWhore.esp") != 255) as Int)
		ForceDrug.RapeDrugHumanCum = JsonUtil.GetIntValue("SL Survival/Settings.json", "RapeDrugHumanCum", missing = 1)
		ForceDrug.RapeDrugCreatureCum = JsonUtil.GetIntValue("SL Survival/Settings.json", "RapeDrugCreatureCum", missing = 0)
		ForceDrug.RapeDrugInflate = JsonUtil.GetIntValue("SL Survival/Settings.json", "RapeDrugInflate", missing = (Game.GetModByName("SexLab Inflation Framework.esp") != 255) as Int)
		ForceDrug.RapeDrugFmFertility = JsonUtil.GetIntValue("SL Survival/Settings.json", "RapeDrugFmFertility", missing = (Game.GetModByName("Fertility Mode.esm") != 255) as Int)
		ForceDrug.RapeDrugSlenAphrodisiac = JsonUtil.GetIntValue("SL Survival/Settings.json", "RapeDrugSlenAphrodisiac", missing = (Game.GetModByName("SexLab Eager NPCs.esp") != 255) as Int)
		ForceDrug.RapeDrugSensitivity = JsonUtil.GetIntValue("SL Survival/Settings.json", "RapeDrugSensitivity", missing = 1)
		ForceDrug.TollDrugLactacid = JsonUtil.GetIntValue("SL Survival/Settings.json", "TollDrugLactacid", missing = (Game.GetModByName("MilkModNEW.esp") != 255) as Int)
		ForceDrug.TollDrugSkooma = JsonUtil.GetIntValue("SL Survival/Settings.json", "TollDrugSkooma", missing = (Game.GetModByName("SexLabSkoomaWhore.esp") != 255) as Int)
		ForceDrug.TollDrugHumanCum = JsonUtil.GetIntValue("SL Survival/Settings.json", "TollDrugHumanCum", missing = 1)
		ForceDrug.TollDrugCreatureCum = JsonUtil.GetIntValue("SL Survival/Settings.json", "TollDrugCreatureCum", missing = 0)
		ForceDrug.TollDrugInflate = JsonUtil.GetIntValue("SL Survival/Settings.json", "TollDrugInflate", missing = (Game.GetModByName("SexLab Inflation Framework.esp") != 255) as Int)
		ForceDrug.TollDrugFmFertility = JsonUtil.GetIntValue("SL Survival/Settings.json", "TollDrugFmFertility", missing = (Game.GetModByName("Fertility Mode.esm") != 255) as Int)
		ForceDrug.TollDrugSlenAphrodisiac = JsonUtil.GetIntValue("SL Survival/Settings.json", "TollDrugSlenAphrodisiac", missing = (Game.GetModByName("SexLab Eager NPCs.esp") != 255) as Int)
		ForceDrug.TollDrugSensitivity = JsonUtil.GetIntValue("SL Survival/Settings.json", "TollDrugSensitivity", missing = 1)
		CumAddict.AutoSuckVictim = JsonUtil.GetIntValue("SL Survival/Settings.json", "AutoSuckVictim", missing = 1)
		(Game.GetFormFromFile(0x0DF88F, "SL Survival.esp") as GlobalVariable).SetValueInt(JsonUtil.GetIntValue("SL Survival/Settings.json", "NpcComments", missing = 1))
		(Game.GetFormFromFile(0x0CF9B1, "SL Survival.esp") as _SLS_BodyInflationTracking).DoImod = JsonUtil.GetIntValue("SL Survival/Settings.json", "JigglesVisuals", missing = 1)
		StorageUtil.SetIntValue(Self, "CompulsiveSex", JsonUtil.GetIntValue("SL Survival/Settings.json", "CompulsiveSex", missing = 1))
		StorageUtil.SetIntValue(Self, "OrgasmFatigue", JsonUtil.GetIntValue("SL Survival/Settings.json", "OrgasmFatigue", missing = 1))
		Amputation.BlockMagic = JsonUtil.GetIntValue("SL Survival/Settings.json", "AmpBlockMagic", missing = 1)
		Trauma.TraumaEnable =  JsonUtil.GetIntValue("SL Survival/Settings.json", "Trauma.TraumaEnable", missing = 1)
		Trauma.DynamicTrauma = JsonUtil.GetIntValue("SL Survival/Settings.json", "Trauma.DynamicTrauma", missing = 1)
		Trauma.DynamicCombat = JsonUtil.GetIntValue("SL Survival/Settings.json", "Trauma.DynamicCombat", missing = 1)
		StorageUtil.SetIntValue(Self, "GuardBehavArmorEquipAnyArmor", JsonUtil.GetIntValue("SL Survival/Settings.json", "GuardBehavArmorEquipAnyArmor", missing = 0))
		Init.TollEnable = JsonUtil.GetIntValue("SL Survival/Settings.json", "Init.TollEnable", missing = 1)
		StorageUtil.SetIntValue(Self, "AhegaoEnable", JsonUtil.GetIntValue("SL Survival/Settings.json", "AhegaoEnable", missing = 1))
		RapeDrainsAttributes = JsonUtil.GetIntValue("SL Survival/Settings.json", "RapeDrainsAttributes", missing = 1)
		(Game.GetFormFromFile(0x0E3F3D, "SL Survival.esp") as _SLS_Curfew).DoCurfewNotification = JsonUtil.GetIntValue("SL Survival/Settings.json", "Curfew.DoCurfewNotification", missing = 1)
		LicUtil.CheckFollowers = JsonUtil.GetIntValue("SL Survival/Settings.json", "LicUtil.CheckFollowers", missing = 1)
		LicUtil.ForceCheckDF = JsonUtil.GetIntValue("SL Survival/Settings.json", "LicUtil.LicForceCheckDeviousFollower", missing = 1)
		(Game.GetFormFromFile(0x10D7AF, "SL Survival.esp") as _SLS_BikiniBreak).CompatibilityMode = JsonUtil.GetIntValue("SL Survival/Settings.json", "BikiniBreak.CompatibilityMode", missing = 1)
		StorageUtil.SetIntValue(Self, "DroppedItemStealingEn", JsonUtil.GetIntValue("SL Survival/Settings.json", "DroppedItemStealingEn", missing = 1))		
		
		If IsInMcm
			SetTextOptionValue(ImportSettingsOID_T, "Loading Ints")
		EndIf
		
		; Ints
		PushEvents = JsonUtil.GetIntValue("SL Survival/Settings.json", "PushEvents", missing = 0)
		SurvivalHorseCost = JsonUtil.GetIntValue("SL Survival/Settings.json", "SurvivalHorseCost", missing = 6000)
		FolGoldStealChance = JsonUtil.GetIntValue("SL Survival/Settings.json", "FolGoldStealChance", missing = 50)
		FolGoldSteamAmount = JsonUtil.GetIntValue("SL Survival/Settings.json", "FolGoldSteamAmount", missing = 30)
		HalfNakedBra = JsonUtil.GetIntValue("SL Survival/Settings.json", "HalfNakedBra", missing = 56)
		HalfNakedPanty = JsonUtil.GetIntValue("SL Survival/Settings.json", "HalfNakedPanty", missing = 49)
		AproTwoTrollHealAmount = JsonUtil.GetIntValue("SL Survival/Settings.json", "AproTwoTrollHealAmount", missing = 200)
		DevEffLockpickDiff = JsonUtil.GetIntValue("SL Survival/Settings.json", "DevEffLockpickDiff", missing = 1)
		DevEffPickpocketDiff = JsonUtil.GetIntValue("SL Survival/Settings.json", "DevEffPickpocketDiff", missing = 1)
		BondFurnMilkWill = JsonUtil.GetIntValue("SL Survival/Settings.json", "BondFurnMilkWill", missing = 4)
		BondFurnWill = JsonUtil.GetIntValue("SL Survival/Settings.json", "BondFurnWill", missing = 2)
		_SLS_IneqStat.SetValueInt(JsonUtil.GetIntValue("SL Survival/Settings.json", "_SLS_IneqStat", missing = 1))
		_SLS_IneqCarry.SetValueInt(JsonUtil.GetIntValue("SL Survival/Settings.json", "_SLS_IneqCarry", missing = 1))
		_SLS_IneqSpeed.SetValueInt(JsonUtil.GetIntValue("SL Survival/Settings.json", "_SLS_IneqSpeed", missing = 1))
		_SLS_IneqDamage.SetValueInt(JsonUtil.GetIntValue("SL Survival/Settings.json", "_SLS_IneqDamage", missing = 1))
		_SLS_IneqDestruction.SetValueInt(JsonUtil.GetIntValue("SL Survival/Settings.json", "_SLS_IneqDestruction", missing = 1))
		SwimCumClean = JsonUtil.GetIntValue("SL Survival/Settings.json", "SwimCumClean", missing = 12)
		TollSexAgg = JsonUtil.GetIntValue("SL Survival/Settings.json", "TollSexAgg", missing = 0)
		TollSexVictim = JsonUtil.GetIntValue("SL Survival/Settings.json", "TollSexVictim", missing = 0)
		TollUtil.TollCostGold = JsonUtil.GetIntValue("SL Survival/Settings.json", "TollCostGold", missing = 100)
		TollUtil.SlaverunJobFactor = JsonUtil.GetIntValue("SL Survival/Settings.json", "SlaverunJobFactor", missing = 3)
		TollUtil.TollCostDevices = JsonUtil.GetIntValue("SL Survival/Settings.json", "TollCostDevices", missing = 3)
		TollUtil.TollCostTattoos = JsonUtil.GetIntValue("SL Survival/Settings.json", "TollCostTattoos", missing = 2)
		TollUtil.TollCostDrugs = JsonUtil.GetIntValue("SL Survival/Settings.json", "TollCostDrugs", missing = 2)
		MaxTatsBody = JsonUtil.GetIntValue("SL Survival/Settings.json", "MaxTatsBody", missing = 6)
		MaxTatsFace = JsonUtil.GetIntValue("SL Survival/Settings.json", "MaxTatsFace", missing = 3)
		MaxTatsHands = JsonUtil.GetIntValue("SL Survival/Settings.json", "MaxTatsHands", missing = 0)
		MaxTatsFeet = JsonUtil.GetIntValue("SL Survival/Settings.json", "MaxTatsFeet", missing = 0)
		TollDodgeMaxGuards = JsonUtil.GetIntValue("SL Survival/Settings.json", "TollDodgeMaxGuards", missing = 6)
		BuyBackPrice = JsonUtil.GetIntValue("SL Survival/Settings.json", "BuyBackPrice", missing = 2)
		LicUtil.LicCostWeaponShort = JsonUtil.GetIntValue("SL Survival/Settings.json", "LicUtil.LicCostWeaponShort", missing = 1000)
		LicUtil.LicCostWeaponLong = JsonUtil.GetIntValue("SL Survival/Settings.json", "LicUtil.LicCostWeaponLong", missing = 3000)
		LicUtil.LicCostWeaponPer = JsonUtil.GetIntValue("SL Survival/Settings.json", "LicUtil.LicCostWeaponPer", missing = 15000)
		LicUtil.LicCostMagicShort = JsonUtil.GetIntValue("SL Survival/Settings.json", "LicUtil.LicCostMagicShort", missing = 1000)
		LicUtil.LicCostMagicLong = JsonUtil.GetIntValue("SL Survival/Settings.json", "LicUtil.LicCostMagicLong", missing = 3000)
		LicUtil.LicCostMagicPer = JsonUtil.GetIntValue("SL Survival/Settings.json", "LicUtil.LicCostMagicPer", missing = 20000)
		LicUtil.LicCostArmorShort = JsonUtil.GetIntValue("SL Survival/Settings.json", "LicUtil.LicCostArmorShort", missing = 3000)
		LicUtil.LicCostArmorLong = JsonUtil.GetIntValue("SL Survival/Settings.json", "LicUtil.LicCostArmorLong", missing = 9000)
		LicUtil.LicCostArmorPer = JsonUtil.GetIntValue("SL Survival/Settings.json", "LicUtil.LicCostArmorPer", missing = 30000)
		LicUtil.LicCostBikiniShort = JsonUtil.GetIntValue("SL Survival/Settings.json", "LicUtil.LicCostBikiniShort", missing = 1000)
		LicUtil.LicCostBikiniLong = JsonUtil.GetIntValue("SL Survival/Settings.json", "LicUtil.LicCostBikiniLong", missing = 3000)
		LicUtil.LicCostBikiniPer = JsonUtil.GetIntValue("SL Survival/Settings.json", "LicUtil.LicCostBikiniPer", missing = 15000)
		LicUtil.LicCostClothesShort = JsonUtil.GetIntValue("SL Survival/Settings.json", "LicUtil.LicCostClothesShort", missing = 500)
		LicUtil.LicCostClothesLong = JsonUtil.GetIntValue("SL Survival/Settings.json", "LicUtil.LicCostClothesLong", missing = 1500)
		LicUtil.LicCostClothesPer = JsonUtil.GetIntValue("SL Survival/Settings.json", "LicUtil.LicCostClothesPer", missing = 10000)
		CumHungerAutoSuck = JsonUtil.GetIntValue("SL Survival/Settings.json", "CumHungerAutoSuck", missing = 2)
		SexExpCorruption = JsonUtil.GetIntValue("SL Survival/Settings.json", "SexExpCorruption", missing = 0)
		AllInOne.SetKey(JsonUtil.GetIntValue("SL Survival/Settings.json", "AioKey", missing = 34))
	
		Int NewSlot = JsonUtil.GetIntValue("SL Survival/Settings.json", "BikiniCurseArea", missing = 0)
		RefreshBikiniCurseOverlay(NewSlot)
		BikiniCurseArea = NewSlot
		NewSlot = JsonUtil.GetIntValue("SL Survival/Settings.json", "MagicCurseArea", missing = 1)
		RefreshMagicCurseOverlay(NewSlot)
		MagicCurseArea = NewSlot
		
		TradeRestrictBribe = JsonUtil.GetIntValue("SL Survival/Settings.json", "TradeRestrictBribe", missing = 50)
		EnforcersMin = JsonUtil.GetIntValue("SL Survival/Settings.json", "EnforcersMin", missing = 2)
		EnforcersMax = JsonUtil.GetIntValue("SL Survival/Settings.json", "EnforcersMax", missing = 4)
		LicUtil.LicClothesEnable = JsonUtil.GetIntValue("SL Survival/Settings.json", "LicUtil.LicClothesEnable", missing = 2)
		BegNumItems = JsonUtil.GetIntValue("SL Survival/Settings.json", "BegNumItems", missing = 2)
		BegSexAgg = JsonUtil.GetIntValue("SL Survival/Settings.json", "BegSexAgg", missing = 0)
		BegSexVictim = JsonUtil.GetIntValue("SL Survival/Settings.json", "BegSexVictim", missing = 0)
		KennelSafeCellCost = JsonUtil.GetIntValue("SL Survival/Settings.json", "KennelSafeCellCost", missing = 40)
		KennelSlaveRapeTimeMin = JsonUtil.GetIntValue("SL Survival/Settings.json", "KennelSlaveRapeTimeMin", missing = 10)
		KennelSlaveRapeTimeMax = JsonUtil.GetIntValue("SL Survival/Settings.json", "KennelSlaveRapeTimeMax", missing = 40)
		StorageUtil.SetIntValue(Self, "KennelSlaveDeviceCountMin", JsonUtil.GetIntValue("SL Survival/Settings.json", "KennelSlaveDeviceCountMin", missing = 2))
		StorageUtil.SetIntValue(Self, "KennelSlaveDeviceCountMax", JsonUtil.GetIntValue("SL Survival/Settings.json", "KennelSlaveDeviceCountMax", missing = 6))
		_SLS_KennelExtraDevices.SetValueInt(JsonUtil.GetIntValue("SL Survival/Settings.json", "_SLS_KennelExtraDevices", missing = 1))
		KennelSexAgg = JsonUtil.GetIntValue("SL Survival/Settings.json", "KennelSexAgg", missing = 2)
		KennelSexVictim = JsonUtil.GetIntValue("SL Survival/Settings.json", "KennelSexVictim", missing = 1)
		Init.PpFailDevices = JsonUtil.GetIntValue("SL Survival/Settings.json", "PpFailDevices", missing = 4)
		_SLS_PickPocketFailStealValue.SetValueInt(JsonUtil.GetIntValue("SL Survival/Settings.json", "_SLS_PickPocketFailStealValue", missing = 200))
		PpFailDrugCount = JsonUtil.GetIntValue("SL Survival/Settings.json", "PpFailDrugCount", missing = 2)
		Util.PpLootLootMin = JsonUtil.GetIntValue("SL Survival/Settings.json", "Util.PpLootLootMin", missing = 0)
		Util.PpLootLootMax = JsonUtil.GetIntValue("SL Survival/Settings.json", "Util.PpLootLootMax", missing = 8)
		AmpDepth = JsonUtil.GetIntValue("SL Survival/Settings.json", "AmpDepth", missing = 2)
		DismemberWeapon = JsonUtil.GetIntValue("SL Survival/Settings.json", "DismemberWeapon", missing = 0)
		MaxAmpDepthArms = JsonUtil.GetIntValue("SL Survival/Settings.json", "MaxAmpDepthArms", missing = 1)
		MaxAmpDepthLegs = JsonUtil.GetIntValue("SL Survival/Settings.json", "MaxAmpDepthLegs", missing = 1)
		MaxAmpedLimbs = JsonUtil.GetIntValue("SL Survival/Settings.json", "MaxAmpedLimbs", missing = 2)
		DismemberDamageThres = JsonUtil.GetIntValue("SL Survival/Settings.json", "DismemberDamageThres", missing = 3)
		_SLS_AmpPriestHealCost.SetValueInt(JsonUtil.GetIntValue("SL Survival/Settings.json", "_SLS_AmpPriestHealCost", missing = 200))
		BikiniDropsVendorCity = JsonUtil.GetIntValue("SL Survival/Settings.json", "BikiniDropsVendorCity", missing = 30)
		BikiniDropsVendorTown = JsonUtil.GetIntValue("SL Survival/Settings.json", "BikiniDropsVendorTown", missing = 16)
		BikiniDropsVendorKhajiit = JsonUtil.GetIntValue("SL Survival/Settings.json", "BikiniDropsVendorKhajiit", missing = 12)
		BikiniDropsChest = JsonUtil.GetIntValue("SL Survival/Settings.json", "BikiniDropsChest", missing = 6)
		BikiniDropsChestOrnate = JsonUtil.GetIntValue("SL Survival/Settings.json", "BikiniDropsChestOrnate", missing = 10)
		_SLS_BikiniExpReflexes.SetValueInt(JsonUtil.GetIntValue("SL Survival/Settings.json", "_SLS_BikiniExpReflexes", missing = 1))
		ProxSpankNpcType = JsonUtil.GetIntValue("SL Survival/Settings.json", "ProxSpankNpcType", missing = 1)
		_SLS_ProxSpankRequiredCover.SetValueInt(JsonUtil.GetIntValue("SL Survival/Settings.json", "_SLS_ProxSpankRequiredCover", missing = 1))
		PpCrimeGold = JsonUtil.GetIntValue("SL Survival/Settings.json", "PpCrimeGold", missing = 100)
		LicUtil.FollowerLicStyle = JsonUtil.GetIntValue("SL Survival/Settings.json", "FollowerLicStyle", missing = 0)
		_SLS_TollFollowersRequired.SetValueInt(JsonUtil.GetIntValue("SL Survival/Settings.json", "_SLS_TollFollowersRequired", missing = 1))
		LicUtil.LicenceStyle = JsonUtil.GetIntValue("SL Survival/Settings.json", "LicenceStyle", missing = 0)
		_SLS_LicUnlockCost.SetValueInt(JsonUtil.GetIntValue("SL Survival/Settings.json", "_SLS_LicUnlockCost", missing = 5000))
		CompassHideMethod = JsonUtil.GetIntValue("SL Survival/Settings.json", "CompassHideMethod", missing = 0)
		_SLS_LicInspPersistence.SetValueInt(JsonUtil.GetIntValue("SL Survival/Settings.json", "_SLS_LicInspPersistence", missing = 0))
		FashionRape.HairCutMinLevel = JsonUtil.GetIntValue("SL Survival/Settings.json", "HairCutMinLevel", missing = 1)
		FashionRape.HairCutMaxLevel = JsonUtil.GetIntValue("SL Survival/Settings.json", "HairCutMaxLevel", missing = 3)
		FashionRape.HaircutFloor = JsonUtil.GetIntValue("SL Survival/Settings.json", "HaircutFloor", missing = 1)
		Trauma.PlayerTraumaCountMax =  JsonUtil.GetIntValue("SL Survival/Settings.json", "Trauma.PlayerTraumaCountMax", missing = 15)
		Trauma.FollowerTraumaCountMax =  JsonUtil.GetIntValue("SL Survival/Settings.json", "Trauma.FollowerTraumaCountMax", missing = 15)
		Trauma.NpcTraumaCountMax =  JsonUtil.GetIntValue("SL Survival/Settings.json", "Trauma.NpcTraumaCountMax", missing = 10)
		Trauma.SexHitsPlayer =  JsonUtil.GetIntValue("SL Survival/Settings.json", "Trauma.SexHitsPlayer", missing = 1)
		Trauma.SexHitsFollower =  JsonUtil.GetIntValue("SL Survival/Settings.json", "Trauma.SexHitsFollower", missing = 1)
		Trauma.SexHitsNpc =  JsonUtil.GetIntValue("SL Survival/Settings.json", "Trauma.SexHitsNpc", missing = 2)
		Trauma.CombatDamageThreshold =  JsonUtil.GetIntValue("SL Survival/Settings.json", "Trauma.CombatDamageThreshold", missing = 4)
		AllInOne.StatusKey =  JsonUtil.GetIntValue("SL Survival/Settings.json", "AllInOne.StatusKey", missing = 0)
		(Game.GetFormFromFile(0x112E32, "SL Survival.esp") as GlobalVariable).SetValueInt(JsonUtil.GetIntValue("SL Survival/Settings.json", "EasyHomeWhiterun", missing = 2))
		(Game.GetFormFromFile(0x113395, "SL Survival.esp") as GlobalVariable).SetValueInt(JsonUtil.GetIntValue("SL Survival/Settings.json", "EasyHomeSolitude", missing = 2))
		(Game.GetFormFromFile(0x113396, "SL Survival.esp") as GlobalVariable).SetValueInt(JsonUtil.GetIntValue("SL Survival/Settings.json", "EasyHomeMarkarth", missing = 2))
		(Game.GetFormFromFile(0x113397, "SL Survival.esp") as GlobalVariable).SetValueInt(JsonUtil.GetIntValue("SL Survival/Settings.json", "EasyHomeWindhelm", missing = 2))
		(Game.GetFormFromFile(0x113398, "SL Survival.esp") as GlobalVariable).SetValueInt(JsonUtil.GetIntValue("SL Survival/Settings.json", "EasyHomeRiften", missing = 2))
		(Game.GetFormFromFile(0xF728B, "Skyrim.esm") as GlobalVariable).SetValueInt(JsonUtil.GetIntValue("SL Survival/Settings.json", "HousePriceWhiterun", Missing = 5000))
		(Game.GetFormFromFile(0xF728C, "Skyrim.esm") as GlobalVariable).SetValueInt(JsonUtil.GetIntValue("SL Survival/Settings.json", "HousePriceSolitude", Missing = 25000))
		(Game.GetFormFromFile(0xF728E, "Skyrim.esm") as GlobalVariable).SetValueInt(JsonUtil.GetIntValue("SL Survival/Settings.json", "HousePriceMarkarth", Missing = 8000))
		(Game.GetFormFromFile(0xF728A, "Skyrim.esm") as GlobalVariable).SetValueInt(JsonUtil.GetIntValue("SL Survival/Settings.json", "HousePriceWindhelm", Missing = 12000))
		(Game.GetFormFromFile(0xF728D, "Skyrim.esm") as GlobalVariable).SetValueInt(JsonUtil.GetIntValue("SL Survival/Settings.json", "HousePriceRiften", Missing = 8000))
		AllInOne.Fav.Favorite =  JsonUtil.GetIntValue("SL Survival/Settings.json", "AllInOne.Fav.Favorite", missing = 11)
		
		If IsInMcm
			SetTextOptionValue(ImportSettingsOID_T, "Loading Floats")
		EndIf
		
		; Floats
		StorageUtil.SetFloatValue(Self, "CumAddictDayDreamArousal", JsonUtil.GetFloatValue("SL Survival/Settings.json", "CumAddictDayDreamArousal", missing = 101.0))
		FolGoldStealChance = JsonUtil.GetFloatValue("SL Survival/Settings.json", "FolGoldStealChance", missing = 50.0)
		BarefootMag = JsonUtil.GetFloatValue("SL Survival/Settings.json", "BarefootMag", missing = 50.0)
		MinSpeedMult = JsonUtil.GetFloatValue("SL Survival/Settings.json", "MinSpeedMult", missing = 50.0)
		MinCarryWeight = JsonUtil.GetFloatValue("SL Survival/Settings.json", "MinCarryWeight", missing = 50.0)
		ReplaceMapsTimer = JsonUtil.GetFloatValue("SL Survival/Settings.json", "ReplaceMapsTimer", missing = 50.0)
		SlaverunAutoMin = JsonUtil.GetFloatValue("SL Survival/Settings.json", "SlaverunAutoMin", missing = 2.0)
		SlaverunAutoMax = JsonUtil.GetFloatValue("SL Survival/Settings.json", "SlaverunAutoMax", missing = 14.0)
		CumSwallowInflateMult = JsonUtil.GetFloatValue("SL Survival/Settings.json", "CumSwallowInflateMult", missing = 1.0)
		CumEffectsMagMult = JsonUtil.GetFloatValue("SL Survival/Settings.json", "CumEffectsMagMult", missing = 1.0)
		CumEffectsDurMult = JsonUtil.GetFloatValue("SL Survival/Settings.json", "CumEffectsDurMult", missing = 1.0)
		CumpulsionChance = JsonUtil.GetFloatValue("SL Survival/Settings.json", "CumpulsionChance", missing = 25.0)
		AnimalFriend.BreedingCooloffBase = JsonUtil.GetFloatValue("SL Survival/Settings.json", "AnimalFriend.BreedingCooloffBase", missing = 3.0)
		AnimalFriend.BreedingCooloffCumCovered = JsonUtil.GetFloatValue("SL Survival/Settings.json", "AnimalFriend.BreedingCooloffCumCovered", missing = 6.0)
		AnimalFriend.BreedingCooloffCumFilled = JsonUtil.GetFloatValue("SL Survival/Settings.json", "AnimalFriend.BreedingCooloffCumFilled", missing = 12.0)
		AnimalFriend.SwallowBonus = JsonUtil.GetFloatValue("SL Survival/Settings.json", "AnimalFriend.SwallowBonus", missing = 12.0)
		AnimalFriend.BreedingCooloffPregnancy = JsonUtil.GetFloatValue("SL Survival/Settings.json", "AnimalFriend.BreedingCooloffPregnancy", missing = 12.0)
		DflowResistLoss = JsonUtil.GetFloatValue("SL Survival/Settings.json", "DflowResistLoss", missing = 5.0)
		BondFurnMilkFreq = JsonUtil.GetFloatValue("SL Survival/Settings.json", "BondFurnMilkFreq", missing = 6.0)
		BondFurnMilkFatigueMult = JsonUtil.GetFloatValue("SL Survival/Settings.json", "BondFurnMilkFatigueMult", missing = 1.0)
		BondFurnFreq = JsonUtil.GetFloatValue("SL Survival/Settings.json", "BondFurnFreq", missing = 3.0)
		BondFurnFatigueMult = JsonUtil.GetFloatValue("SL Survival/Settings.json", "BondFurnFatigueMult", missing = 1.0)
		IneqStatsVal = JsonUtil.GetFloatValue("SL Survival/Settings.json", "IneqStatsVal", missing = 40.0)
		IneqHealthCushion = JsonUtil.GetFloatValue("SL Survival/Settings.json", "IneqHealthCushion", missing = 20.0)
		IneqCarryVal = JsonUtil.GetFloatValue("SL Survival/Settings.json", "IneqCarryVal", missing = 150.0)
		IneqSpeedVal = JsonUtil.GetFloatValue("SL Survival/Settings.json", "IneqSpeedVal", missing = 10.0)
		IneqDamageVal = JsonUtil.GetFloatValue("SL Survival/Settings.json", "IneqDamageVal", missing = 20.0)
		IneqDestVal = JsonUtil.GetFloatValue("SL Survival/Settings.json", "IneqDestVal", missing = 20.0)
		KnockSlaveryChance = JsonUtil.GetFloatValue("SL Survival/Settings.json", "KnockSlaveryChance", missing = 25.0)
		SimpleSlaveryWeight = JsonUtil.GetFloatValue("SL Survival/Settings.json", "SimpleSlaveryWeight", missing = 50.0)
		SdWeight = JsonUtil.GetFloatValue("SL Survival/Settings.json", "SdWeight", missing = 50.0)
		GluttedSpeed = JsonUtil.GetFloatValue("SL Survival/Settings.json", "GluttedSpeed", missing = 10.0)
		Needs.BaseBellyScale = JsonUtil.GetFloatValue("SL Survival/Settings.json", "Needs.BaseBellyScale", missing = 1.0)
		Rnd.BellyScaleRnd00 = JsonUtil.GetFloatValue("SL Survival/Settings.json", "Rnd.BellyScaleRnd00", missing = 1.5)
		Rnd.BellyScaleRnd01 = JsonUtil.GetFloatValue("SL Survival/Settings.json", "Rnd.BellyScaleRnd01", missing = 0.4)
		Rnd.BellyScaleRnd02 = JsonUtil.GetFloatValue("SL Survival/Settings.json", "Rnd.BellyScaleRnd02", missing = 0.3)
		Rnd.BellyScaleRnd03 = JsonUtil.GetFloatValue("SL Survival/Settings.json", "Rnd.BellyScaleRnd03", missing = 0.2)
		Rnd.BellyScaleRnd04 = JsonUtil.GetFloatValue("SL Survival/Settings.json", "Rnd.BellyScaleRnd04", missing = 0.1)
		Rnd.BellyScaleRnd05 = JsonUtil.GetFloatValue("SL Survival/Settings.json", "Rnd.BellyScaleRnd05", missing = 0.0)
		SkoomaSleep = JsonUtil.GetFloatValue("SL Survival/Settings.json", "SkoomaSleep", missing = 1.0)
		MilkSleepMult = JsonUtil.GetFloatValue("SL Survival/Settings.json", "MilkSleepMult", missing = 1.0)
		DrugEndFatigueInc = JsonUtil.GetFloatValue("SL Survival/Settings.json", "DrugEndFatigueInc", missing = 0.25)
		Needs.CumFoodMult = JsonUtil.GetFloatValue("SL Survival/Settings.json", "Needs.CumFoodMult", missing = 1.0)
		Needs.CumDrinkMult = JsonUtil.GetFloatValue("SL Survival/Settings.json", "Needs.CumDrinkMult", missing = 1.0)
		Ineed.BellyScaleIneed00 = JsonUtil.GetFloatValue("SL Survival/Settings.json", "Ineed.BellyScaleIneed00", missing = 0.9)
		Ineed.BellyScaleIneed01 = JsonUtil.GetFloatValue("SL Survival/Settings.json", "Ineed.BellyScaleIneed01", missing = 0.6)
		Ineed.BellyScaleIneed02 = JsonUtil.GetFloatValue("SL Survival/Settings.json", "Ineed.BellyScaleIneed02", missing = 0.3)
		Ineed.BellyScaleIneed03 = JsonUtil.GetFloatValue("SL Survival/Settings.json", "Ineed.BellyScaleIneed03", missing = 0.0)
		WarmBodies = JsonUtil.GetFloatValue("SL Survival/Settings.json", "WarmBodies", missing = -3.0)
		MilkLeakWet = JsonUtil.GetFloatValue("SL Survival/Settings.json", "MilkLeakWet", missing = 50.0)
		CumWetMult = JsonUtil.GetFloatValue("SL Survival/Settings.json", "CumWetMult", missing = 1.0)
		CumExposureMult = JsonUtil.GetFloatValue("SL Survival/Settings.json", "CumExposureMult", missing = 1.0)
		SimpleSlaveryFF = JsonUtil.GetFloatValue("SL Survival/Settings.json", "SimpleSlaveryFF", missing = 50.0)
		SdDreamFF = JsonUtil.GetFloatValue("SL Survival/Settings.json", "SdDreamFF", missing = 50.0)
		TollUtil.SlaverunFactor = JsonUtil.GetFloatValue("SL Survival/Settings.json", "SlaverunFactor", missing = 2.0)
		TollDodgeGracePeriod = JsonUtil.GetFloatValue("SL Survival/Settings.json", "TollDodgeGracePeriod", missing = 2.0)
		TollDodgeHuntFreq = JsonUtil.GetFloatValue("SL Survival/Settings.json", "TollDodgeHuntFreq", missing = 1.5)
		TollDodgeItemValueMod = JsonUtil.GetFloatValue("SL Survival/Settings.json", "TollDodgeItemValueMod", missing = 1.0)
		GuardSpotDistTown = JsonUtil.GetFloatValue("SL Survival/Settings.json", "GuardSpotDistTown", missing = 768.0)
		GuardSpotDistNom = JsonUtil.GetFloatValue("SL Survival/Settings.json", "GuardSpotDistNom", missing = 512.0)
		TollDodgeDisguiseBodyPenalty = JsonUtil.GetFloatValue("SL Survival/Settings.json", "TollDodgeDisguiseBodyPenalty", missing = 0.75)
		TollDodgeDisguiseHeadPenalty = JsonUtil.GetFloatValue("SL Survival/Settings.json", "TollDodgeDisguiseHeadPenalty", missing = 0.75)
		(Game.GetFormFromFile(0x0EAB5A, "SL Survival.esp") as GlobalVariable).SetValue(JsonUtil.GetFloatValue("SL Survival/Settings.json", "_SLS_GateCurfewBegin", missing = 20.0)) ; _SLS_GateCurfewBegin
		(Game.GetFormFromFile(0x0EAB5B, "SL Survival.esp") as GlobalVariable).SetValue(JsonUtil.GetFloatValue("SL Survival/Settings.json", "_SLS_GateCurfewEnd", missing = 7.0)) ; _SLS_GateCurfewEnd
		(Game.GetFormFromFile(0x0EE155, "SL Survival.esp") as GlobalVariable).SetValue(JsonUtil.GetFloatValue("SL Survival/Settings.json", "_SLS_GateCurfewSlavetownBegin", missing = 18.0)) ; _SLS_GateCurfewSlavetownBegin
		(Game.GetFormFromFile(0x0EE156, "SL Survival.esp") as GlobalVariable).SetValue(JsonUtil.GetFloatValue("SL Survival/Settings.json", "_SLS_GateCurfewSlavetownEnd", missing = 10.0)) ; _SLS_GateCurfewSlavetownEnd
		LicBlockChance = JsonUtil.GetFloatValue("SL Survival/Settings.json", "LicBlockChance", missing = 70.0)
		LicUtil.LicFactionDiscount = JsonUtil.GetFloatValue("SL Survival/Settings.json", "LicUtil.LicFactionDiscount", missing = 0.5)
		LicUtil.LicShortDur = JsonUtil.GetFloatValue("SL Survival/Settings.json", "LicUtil.LicShortDur", missing = 7.0)
		LicUtil.LicLongDur = JsonUtil.GetFloatValue("SL Survival/Settings.json", "LicUtil.LicLongDur", missing = 28.0)
		EnforcerRespawnDur = JsonUtil.GetFloatValue("SL Survival/Settings.json", "EnforcerRespawnDur", missing = 7.0)
		BikiniCurse.HeelHeightRequired = JsonUtil.GetFloatValue("SL Survival/Settings.json", "BikiniCurse.HeelHeightRequired", missing = 5.0)
		RoadDist = JsonUtil.GetFloatValue("SL Survival/Settings.json", "RoadDist", missing = 8192.0)
		StealXItems = JsonUtil.GetFloatValue("SL Survival/Settings.json", "StealXItems", missing = 25.0)
		BegGold = JsonUtil.GetFloatValue("SL Survival/Settings.json", "BegGold", missing = 1.0)
		BegMwaCurseChance = JsonUtil.GetFloatValue("SL Survival/Settings.json", "BegMwaCurseChance", missing = 50.0)
		KennelRapeChancePerHour = JsonUtil.GetFloatValue("SL Survival/Settings.json", "KennelRapeChancePerHour", missing = 20.0)
		KennelCreatureChance = JsonUtil.GetFloatValue("SL Survival/Settings.json", "KennelCreatureChance", missing = 50.0)
		PpGoldLowChance = JsonUtil.GetFloatValue("SL Survival/Settings.json", "PpGoldLowChance", missing = 60.0)
		PpGoldModerateChance = JsonUtil.GetFloatValue("SL Survival/Settings.json", "PpGoldModerateChance", missing = 20.0)
		PpGoldHighChance = JsonUtil.GetFloatValue("SL Survival/Settings.json", "PpGoldHighChance", missing = 2.0)
		PpLootFoodChance = JsonUtil.GetFloatValue("SL Survival/Settings.json", "PpLootFoodChance", missing = 25.0)
		PpLootGemsChance = JsonUtil.GetFloatValue("SL Survival/Settings.json", "PpLootGemsChance", missing = 15.0)
		PpLootSoulgemsChance = JsonUtil.GetFloatValue("SL Survival/Settings.json", "PpLootSoulgemsChance", missing = 10.0)
		PpLootJewelryChance = JsonUtil.GetFloatValue("SL Survival/Settings.json", "PpLootJewelryChance", missing = 15.0)
		PpLootEnchJewelryChance = JsonUtil.GetFloatValue("SL Survival/Settings.json", "PpLootEnchJewelryChance", missing = 5.0)
		PpLootPotionsChance = JsonUtil.GetFloatValue("SL Survival/Settings.json", "PpLootPotionsChance", missing = 10.0)
		PpLootKeysChance = JsonUtil.GetFloatValue("SL Survival/Settings.json", "PpLootKeysChance", missing = 10.0)
		PpLootTomesChance = JsonUtil.GetFloatValue("SL Survival/Settings.json", "PpLootTomesChance", missing = 5.0)
		PpLootCureChance = JsonUtil.GetFloatValue("SL Survival/Settings.json", "PpLootCureChance", missing = 5.0)
		DismemberCooldown = JsonUtil.GetFloatValue("SL Survival/Settings.json", "DismemberCooldown", missing = 0.1)
		DismemberChance = JsonUtil.GetFloatValue("SL Survival/Settings.json", "DismemberChance", missing = 90.0)
		DismemberArmorBonus = JsonUtil.GetFloatValue("SL Survival/Settings.json", "DismemberArmorBonus", missing = 5.0)
		DismemberHealthThres = JsonUtil.GetFloatValue("SL Survival/Settings.json", "DismemberHealthThres", missing = 110.0)
		BikiniExp.ExpPerLevel = JsonUtil.GetFloatValue("SL Survival/Settings.json", "BikiniExp.ExpPerLevel", missing = 100.0)
		BikTrainingSpeed = JsonUtil.GetFloatValue("SL Survival/Settings.json", "BikTrainingSpeed", missing = 1.0)
		BikUntrainingSpeed = JsonUtil.GetFloatValue("SL Survival/Settings.json", "BikUntrainingSpeed", missing = 0.5)
		BikiniChanceHide = JsonUtil.GetFloatValue("SL Survival/Settings.json", "BikiniChanceHide", missing = 10.0)
		BikiniChanceLeather = JsonUtil.GetFloatValue("SL Survival/Settings.json", "BikiniChanceLeather", missing = 10.0)
		BikiniChanceIron = JsonUtil.GetFloatValue("SL Survival/Settings.json", "BikiniChanceIron", missing = 10.0)
		BikiniChanceSteel = JsonUtil.GetFloatValue("SL Survival/Settings.json", "BikiniChanceSteel", missing = 11.0)
		BikiniChanceSteelPlate = JsonUtil.GetFloatValue("SL Survival/Settings.json", "BikiniChanceSteelPlate", missing = 8.0)
		BikiniChanceDwarven = JsonUtil.GetFloatValue("SL Survival/Settings.json", "BikiniChanceDwarven", missing = 6.0)
		BikiniChanceFalmer = JsonUtil.GetFloatValue("SL Survival/Settings.json", "BikiniChanceFalmer", missing = 6.0)
		BikiniChanceWolf = JsonUtil.GetFloatValue("SL Survival/Settings.json", "BikiniChanceWolf", missing = 6.0)
		BikiniChanceBlades = JsonUtil.GetFloatValue("SL Survival/Settings.json", "BikiniChanceBlades", missing = 2.0)
		BikiniChanceEbony = JsonUtil.GetFloatValue("SL Survival/Settings.json", "BikiniChanceEbony", missing = 1.0)
		BikiniChanceDragonbone = JsonUtil.GetFloatValue("SL Survival/Settings.json", "BikiniChanceDragonbone", missing = 0.5)
		IneqFemaleVendorGoldMult = JsonUtil.GetFloatValue("SL Survival/Settings.json", "IneqFemaleVendorGoldMult", missing = 1.0)
		CatCallVol = JsonUtil.GetFloatValue("SL Survival/Settings.json", "CatCallVol", missing = 20.0)
		CumIsLactacid = JsonUtil.GetFloatValue("SL Survival/Settings.json", "CumIsLactacid", missing = 0.0)
		ProxSpankCooloff = JsonUtil.GetFloatValue("SL Survival/Settings.json", "ProxSpankCooloff", missing = 10.0)
		CatCallWillLoss = JsonUtil.GetFloatValue("SL Survival/Settings.json", "CatCallWillLoss", missing = 1.0)
		GreetDist = JsonUtil.GetFloatValue("SL Survival/Settings.json", "GreetDist", missing = 150.0)
		CumAddictBatheRefuseTime = JsonUtil.GetFloatValue("SL Survival/Settings.json", "CumAddictBatheRefuseTime", missing = 6.0)
		CumAddictReflexSwallow = JsonUtil.GetFloatValue("SL Survival/Settings.json", "CumAddictReflexSwallow", missing = 1.0)
		CumAddictAutoSuckCreature = JsonUtil.GetFloatValue("SL Survival/Settings.json", "CumAddictAutoSuckCreature", missing = 1.0)
		CumAddictAutoSuckCooldown = JsonUtil.GetFloatValue("SL Survival/Settings.json", "CumAddictAutoSuckCooldown", missing = 6.0)
		CumAddictAutoSuckCreatureArousal = JsonUtil.GetFloatValue("SL Survival/Settings.json", "CumAddictAutoSuckCreatureArousal", missing = 70.0)
		AssSlapResistLoss = JsonUtil.GetFloatValue("SL Survival/Settings.json", "AssSlapResistLoss", missing = 1.0)
		GoldWeight = JsonUtil.GetFloatValue("SL Survival/Settings.json", "GoldWeight", missing = 0.01)
		CumSatiation = JsonUtil.GetFloatValue("SL Survival/Settings.json", "CumSatiation", missing = 1.0)
		CumAddictionHungerRate = JsonUtil.GetFloatValue("SL Survival/Settings.json", "CumAddictionHungerRate", missing = 0.1)
		CumAddictionSpeed = JsonUtil.GetFloatValue("SL Survival/Settings.json", "CumAddictionSpeed", missing = 1.0)
		CumAddictionDecayPerHour = JsonUtil.GetFloatValue("SL Survival/Settings.json", "CumAddictionDecayPerHour", missing = 1.0)
		CockSizeBonusEnjFreq = JsonUtil.GetFloatValue("SL Survival/Settings.json", "CockSizeBonusEnjFreq", missing = 3.0)
		RapeForcedSkoomaChance = JsonUtil.GetFloatValue("SL Survival/Settings.json", "RapeForcedSkoomaChance", missing = 35.0)
		RapeMinArousal = JsonUtil.GetFloatValue("SL Survival/Settings.json", "RapeMinArousal", missing = 50.0)
		DeviousGagDebuff = JsonUtil.GetFloatValue("SL Survival/Settings.json", "DeviousGagDebuff", missing = 80.0)
		StorageUtil.SetFloatValue(Self, "CumAddictDayDreamVol", StorageUtil.GetFloatValue(Self, "CumAddictDayDreamVol", Missing = 1.0))
		Main.Slif.ScaleMaxBreasts = JsonUtil.GetFloatValue("SL Survival/Settings.json", "ScaleMaxBreasts", missing = 3.3)
		Main.Slif.ScaleMaxBelly = JsonUtil.GetFloatValue("SL Survival/Settings.json", "ScaleMaxBelly", missing = 5.5)
		Main.Slif.ScaleMaxAss = JsonUtil.GetFloatValue("SL Survival/Settings.json", "ScaleMaxAss", missing = 2.3)
		FashionRape.HaircutChance = JsonUtil.GetFloatValue("SL Survival/Settings.json", "HaircutChance", missing = 4.0)
		FashionRape.DyeHairChance = JsonUtil.GetFloatValue("SL Survival/Settings.json", "DyeHairChance", missing = 2.0)
		FashionRape.ShavePussyChance = JsonUtil.GetFloatValue("SL Survival/Settings.json", "ShavePussyChance", missing = 10.0)
		FashionRape.SmudgeLipstickChance = JsonUtil.GetFloatValue("SL Survival/Settings.json", "SmudgeLipstickChance", missing = 20.0)
		FashionRape.SmudgeEyeshadowChance = JsonUtil.GetFloatValue("SL Survival/Settings.json", "SmudgeEyeshadowChance", missing = 20.0)
		StorageUtil.SetFloatValue(Self, "WeightGainPerDay", JsonUtil.GetFloatValue("SL Survival/Settings.json", "WeightGainPerDay", missing = 0.0))
		(Game.GetFormFromFile(0x0E651A, "SL Survival.esp") as _SLS_PushPlayerCooloff).CooloffPeriod = JsonUtil.GetFloatValue("SL Survival/Settings.json", "PushCooldown", missing = 0.0)
		(Game.GetFormFromFile(0x0E7553, "SL Survival.esp") as _SLS_CompulsiveSex).TimeBetweenFucks = JsonUtil.GetFloatValue("SL Survival/Settings.json", "TimeBetweenFucks", missing = 1.0)
		;(Game.GetFormFromFile(0x0E857D, "SL Survival.esp") as _SLS_OrgasmFatigue).OrgasmThreshold = JsonUtil.GetFloatValue("SL Survival/Settings.json", "OrgasmFatigueThreshold", missing = 3.0)
		(Game.GetFormFromFile(0x0E857D, "SL Survival.esp") as _SLS_OrgasmFatigue).OrgasmRecoveryPerHour = JsonUtil.GetFloatValue("SL Survival/Settings.json", "OrgasmFatigueRecovery", missing = 0.8)
		(Game.GetFormFromFile(0x0E3F3D, "SL Survival.esp") as _SLS_Curfew).TimeToClearStreets = JsonUtil.GetFloatValue("SL Survival/Settings.json", "TimeToClearStreets", missing = 60.0)
		(Game.GetFormFromFile(0x07B44C, "SL Survival.esp") as GlobalVariable).SetValue(JsonUtil.GetFloatValue("SL Survival/Settings.json", "_SLS_CurfewBegin", missing = 21.0)) ; _SLS_CurfewBegin
		(Game.GetFormFromFile(0x07B44D, "SL Survival.esp") as GlobalVariable).SetValue(JsonUtil.GetFloatValue("SL Survival/Settings.json", "_SLS_CurfewEnd", missing = 6.0)) ; _SLS_CurfewEnd
		(Game.GetFormFromFile(0x0ECBC0, "SL Survival.esp") as GlobalVariable).SetValue(JsonUtil.GetFloatValue("SL Survival/Settings.json", "_SLS_CurfewSlavetownBegin", missing = 19.0)) ; _SLS_CurfewSlavetownBegin
		(Game.GetFormFromFile(0x0ECBC1, "SL Survival.esp") as GlobalVariable).SetValue(JsonUtil.GetFloatValue("SL Survival/Settings.json", "_SLS_CurfewSlavetownEnd", missing = 9.0)) ; _SLS_CurfewSlavetownEnd
		Trauma.StartingAlpha = JsonUtil.GetFloatValue("SL Survival/Settings.json", "Trauma.StartingAlpha", missing = 0.5)
		Trauma.MaxAlpha = JsonUtil.GetFloatValue("SL Survival/Settings.json", "Trauma.MaxAlpha", missing = 0.85)
		Trauma.HoursToMaxAlpha = JsonUtil.GetFloatValue("SL Survival/Settings.json", "Trauma.HoursToMaxAlpha", missing = 4.0)
		Trauma.HoursToFadeOut = JsonUtil.GetFloatValue("SL Survival/Settings.json", "Trauma.HoursToFadeOut", missing = 48.0)
		Trauma.SexChancePlayer = JsonUtil.GetFloatValue("SL Survival/Settings.json", "Trauma.SexChancePlayer", missing = 33.0)
		Trauma.SexChanceFollower = JsonUtil.GetFloatValue("SL Survival/Settings.json", "Trauma.SexChanceFollower", missing = 50.0)
		Trauma.SexChanceNpc = JsonUtil.GetFloatValue("SL Survival/Settings.json", "Trauma.SexChanceNpc", missing = 75.0)
		Trauma.CombatChancePlayer = JsonUtil.GetFloatValue("SL Survival/Settings.json", "Trauma.CombatChancePlayer", missing = 25.0)
		Trauma.CombatChanceFollower = JsonUtil.GetFloatValue("SL Survival/Settings.json", "Trauma.CombatChanceFollower", missing = 10.0)
		Trauma.CombatChanceNpc = JsonUtil.GetFloatValue("SL Survival/Settings.json", "Trauma.CombatChanceNpc", missing = 25.0)
		Trauma.PushChance = JsonUtil.GetFloatValue("SL Survival/Settings.json", "Trauma.PushChance", missing = 33.0)
		Util.PainSoundVol = JsonUtil.GetFloatValue("SL Survival/Settings.json", "Util.PainSoundVol", missing = 0.5)
		Util.HitSoundVol = JsonUtil.GetFloatValue("SL Survival/Settings.json", "Util.HitSoundVol", missing = 0.5)
		(Game.GetFormFromFile(0x0FCE71, "SL Survival.esp") as _SLS_Ahegao).DurPerOrgasm = JsonUtil.GetFloatValue("SL Survival/Settings.json", "Ahegao.DurPerOrgasm", missing = 6.0)
		(Game.GetFormFromFile(0x104511, "SL Survival.esp") as _SLS_CumDesperationVoices).VoicesChance = JsonUtil.GetFloatValue("SL Survival/Settings.json", "Voices.VoicesChance", missing = 100.0)
		(Game.GetFormFromFile(0x104511, "SL Survival.esp") as _SLS_CumDesperationVoices).VoicesVolume = JsonUtil.GetFloatValue("SL Survival/Settings.json", "Voices.VoicesVolume", missing = 1.0)
		(Game.GetFormFromFile(0x104511, "SL Survival.esp") as _SLS_CumDesperationVoices).VanillaVoiceVolume = JsonUtil.GetFloatValue("SL Survival/Settings.json", "Voices.VanillaVoiceVolume", missing = 1.0)
		(Game.GetFormFromFile(0x10C223, "SL Survival.esp") as GlobalVariable).SetValue(JsonUtil.GetFloatValue("SL Survival/Settings.json", "_SLS_LicMagicCurseLimit", Missing = -10))
		(Game.GetFormFromFile(0x1118A1, "SL Survival.esp") as GlobalVariable).SetValue(JsonUtil.GetFloatValue("SL Survival/Settings.json", "_SLS_EnforcerChaseDistance", Missing = 1024.0)) ; _SLS_LicInspChaseDistance		
		CumSwallow.CumInsideBonusEnjMult = JsonUtil.GetFloatValue("SL Survival/Settings.json", "CumSwallow.CumInsideBonusEnjMult", missing = 1.0)
		
		; Int list
		LocTrack.InnCosts = JsonUtil.IntListToArray("SL Survival/Settings.json", "InnCosts")
		
		; Forms
		LoadJsonFormsToFormlist(_SLS_CumHasLactacidVoices, "SL Survival/Settings.json", "_SLS_CumHasLactacidVoices", RevertFl = true)
		
		If IsInMcm
			Debug.Messagebox("Please exit the menu to complete changes")
			SetTextOptionValue(ImportSettingsOID_T, "Actioning Settings")
		EndIf
		
		ToggleCreatureEvents()
		DoTogglePushEvents = true
		ToggleDismemberment()
		Amputation.CheckAvailabilty()
		DoDeviousEffectsChange = true
		Main.FilterGold(FolGoldStealChance)
		DoSlaverunInitOnClose = true
		ToggleAssSlapping()
		ToggleDebugMode()
		ToggleMinAV()
		DoToggleHalfNakedCover = true
		ToggleHalfNakedStrips()
		TogglePpLoot()
		DoToggleCumEffects = true
		TogglePpSleepNpcPerk()
		DoTogglePpFailHandle = true
		ToggleSleepDepriv()
		SetSaltyCum(SaltyCum)
		ToggleBellyInflation()
		DoToggleAnimalBreeding = true
		ToggleTollGateLocks()
		ToggleCompassMechanics()
		;SetTollCost()
		DoTollDodgingToggle = true
		TollUtil.IsCurfewTimeByLoc(PlayerRef.GetCurrentLocation())
		ToggleLicences(Init.LicencesEnable)
		ToggleFolContraBlock()
		ToggleCurseTats()
		ToggleTradeRestrictions()
		ToggleBikiniCurse()
		DoToggleHeelsRequired = true
		ToggleLicMagicCursedDevices()
		ToggleKennelFollower()
		Devious.DoDevicePatchup()
		DoToggleBondFurn = true
		DoToggleBikiniExp = true
		BuildBikiniLists()
		ToggleBarefootMag()
		SetHorseCost(SurvivalHorseCost)
		CheckHalfNakedCover()
		DoInequalityRefresh = true
		ToggleIneqSkills()
		DoPpLvlListbuildOnClose = true
		_SLS_AmputationQuest.UpdateCurrentInstanceGlobal(_SLS_AmpPriestHealCost)
		UpdateBellyScale()
		RefreshGuardSpotDistance()
		_SLS_LicenceTradersQuest.UpdateCurrentInstanceGlobal(_SLS_RestrictTradeBribe)
		ModLicBuyBlock()
		_SLS_KennelCellCost.SetValueInt(KennelSafeCellCost)
		Main.IneqVendorGoldUpdate()
		GagTrade.ToggleActive()
		DoToggleCatCalling = true
		DoToggleLicenceStyle = true
		DoToggleGuardBehavDrugs = true
		DoToggleGuardBehavLockpick = true
		DoToggleGuardBehavWeapDrawn = true
		DoToggleGuardComments = true
		DoToggleProxSpank = true
		DoToggleBarefootSpeed = true
		Game.SetGameSettingFloat("fAIMinGreetingDistance", GreetDist)
		LicUtil.ToggleOrdinSuppression()
		DoToggleCumAddictAutoSuckCreature = true
		DoToggleCoverMechanics = true
		Gold001.SetWeight(GoldWeight)
		DoToggleCumAddiction = true
		CumAddict.LoadNewHungerThresholds()
		CumAddict.DoUpdate()
		DoToggleSexExp = true
		DoToggleIneqStrongFemaleFollowers = true
		ReplaceVanillaMaps(ReplaceMaps)
		DoToggleStashTracking = true
		_SLS_LicenceQuest.UpdateCurrentInstanceGlobal(_SLS_LicUnlockCost)
		MapAndCompass.ResetCompass()
		SetGagSpeechDebuff()
		AddRemoveChainCollars(LicMagicChainCollars)
		DoToggleBellyInflation = true
		StorageUtil.SetIntValue(Self, "DoToggleDaydream", 1)
		DeviousEffects.ToggleDeviousDrowning()
		StorageUtil.SetIntValue(Self, "DoToggleDaydreamButterflys", 1)
		StorageUtil.SetIntValue(Self, "DoToggleGrowth", 1)
		StorageUtil.SetIntValue(Self, "DoToggleNpcComments", 1)
		CumSwallow.SetOpenMouthKey(JsonUtil.GetIntValue("SL Survival/Settings.json", "OpenMouthKey", missing = 0))
		StorageUtil.SetIntValue(Self, "DoToggleCompulsiveSex", 1)
		StorageUtil.SetIntValue(Self, "DoToggleOrgasmFatigue", 1)
		(Game.GetFormFromFile(0x0E3F3D, "SL Survival.esp") as _SLS_Curfew).CheckCurfewState()
		LocTrack.SetInnCostByString(LocTrack.PlayerCurrentLocString)
		StorageUtil.SetIntValue(Self, "DoToggleTrauma", 1)
		StorageUtil.SetIntValue(Self, "DoToggleDynamicTrauma", 1)
		Trauma.RegisterForCombat()
		Trauma.ToggleCombatTrauma()
		LicenceToggleToggled()
		StorageUtil.SetIntValue(Self, "DoToggleAhegaoEnable", 1)
		LicUtil.SetMagicCurseGlobalStatus()
		CumAddict.RegForArousal()
		CumAddict.CumDesperationEffects(CumAddict.GetHungerState())
		ToggleTollGateGuards()
		AllInOne.SetStatusKey(AllInOne.StatusKey)
		StorageUtil.SetIntValue(Self, "DoToggleDropStealing", 1)
		(Game.GetFormFromFile(0xA7B33, "Skyrim.esm") as Quest).UpdateCurrentInstanceGlobal(Game.GetFormFromFile(0xF728B, "Skyrim.esm") as GlobalVariable)
		(Game.GetFormFromFile(0xA7B33, "Skyrim.esm") as Quest).UpdateCurrentInstanceGlobal(Game.GetFormFromFile(0xF728C, "Skyrim.esm") as GlobalVariable)
		(Game.GetFormFromFile(0xA7B33, "Skyrim.esm") as Quest).UpdateCurrentInstanceGlobal(Game.GetFormFromFile(0xF728E, "Skyrim.esm") as GlobalVariable)
		(Game.GetFormFromFile(0xA7B33, "Skyrim.esm") as Quest).UpdateCurrentInstanceGlobal(Game.GetFormFromFile(0xF728A, "Skyrim.esm") as GlobalVariable)
		(Game.GetFormFromFile(0xA7B33, "Skyrim.esm") as Quest).UpdateCurrentInstanceGlobal(Game.GetFormFromFile(0xF728D, "Skyrim.esm") as GlobalVariable)
		ModifyVendorGold(ImportSettings = true)
		AllInOne.Fav.SetFav(AllInOne.Fav.Favorite)
		; Do debug mode last to avoid messagebox spam
		Init.DebugMode = JsonUtil.GetIntValue("SL Survival/Settings.json", "Init.DebugMode")
		
		
		If IsInMcm
			SetTextOptionValue(ImportSettingsOID_T, "Load Complete!")
			ForcePageReset()
		EndIf
		Debug.Messagebox("SLS: Import settings complete")
	EndIf
EndFunction

Function SaveSettings()
	If ShowMessage("Are you sure you want to overwrite the settings saved in the json file with your current settings?")
		If IsInMcm
			SetTextOptionValue(ExportSettingsOID_T, "Saving...")
		EndIf

		; Bools
		JsonUtil.SetIntValue("SL Survival/Settings.json", "SnowberryEnable", SnowberryEnable as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "Init.SlsCreatureEvents", Init.SlsCreatureEvents as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "DropItems", DropItems as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "OrgasmRequired", OrgasmRequired as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "AssSlappingEvents", AssSlappingEvents as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "EasyBedTraps", EasyBedTraps as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "HardcoreMode", HardcoreMode as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "Init.DebugMode", Init.DebugMode as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "MinAvToggleT", MinAvToggleT as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "CompassMechanics", CompassMechanics as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "FastTravelDisable", FastTravelDisable as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "FtDisableIsNormal", FtDisableIsNormal as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "ReplaceMaps", ReplaceMaps as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "FollowersStealGold", FollowersStealGold as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "SlaverunAutoStart", SlaverunAutoStart as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "HalfNakedEnable", HalfNakedEnable as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "CumBreath", CumBreath as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "CumBreathNotify", CumBreathNotify as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "MilkDecCumBreath", MilkDecCumBreath as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "CumEffectsEnable", CumEffectsEnable as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "CumEffectsStack", CumEffectsStack as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "CumAddictEn", CumAddictEn as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "CumSwallowInflate", CumSwallowInflate as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "Init.SlsCreatureEvents", Init.SlsCreatureEvents as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "AnimalBreedEnable", AnimalBreedEnable as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "DeviousEffectsEnable", DeviousEffectsEnable as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "DevEffNoGagTrading", DevEffNoGagTrading as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "BondFurnEnable", BondFurnEnable as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "InequalitySkills", InequalitySkills as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "InequalityBuySell", InequalityBuySell as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "Init.SKdialog", Init.SKdialog as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "SleepDepriv", SleepDepriv as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "BellyScaleEnable", BellyScaleEnable as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "SaltyCum", SaltyCum as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "DoorLockDownT", DoorLockDownT as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "TollCostPerLevel", TollUtil.TollCostPerLevel as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "TollDodging", TollDodging as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "Init.TollDodgeGiftMenu", Init.TollDodgeGiftMenu as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "CurfewEnable", CurfewEnable as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "Init.LicencesEnable", Init.LicencesEnable as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "LicUtil.BuyBack", LicUtil.BuyBack as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "LicUtil.BountyMustBePaid", LicUtil.BountyMustBePaid as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "FolContraBlock", FolContraBlock as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "LicUtil.FollowerWontCarryKeys", LicUtil.FollowerWontCarryKeys as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "LicUtil.FolTakeClothes", LicUtil.FolTakeClothes as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "LicUtil.LicMagicEnable", LicUtil.LicMagicEnable as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "LicUtil.LicMagicCursedDevices", LicUtil.LicMagicCursedDevices as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "LicUtil.CurseTats", LicUtil.CurseTats as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "TradeRestrictions", TradeRestrictions as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "_SLS_ResponsiveEnforcers", _SLS_ResponsiveEnforcers.GetValueInt())
		JsonUtil.SetIntValue("SL Survival/Settings.json", "LicUtil.LicBikiniEnable", LicUtil.LicBikiniEnable as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "LicUtil.BikiniCurseEnable", LicUtil.BikiniCurseEnable as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "BikiniCurse.HeelsRequired", BikiniCurse.HeelsRequired as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "ContTypeCountsT", ContTypeCountsT as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "_SLS_BeggingDialogT", _SLS_BeggingDialogT.GetValueInt())
		JsonUtil.SetIntValue("SL Survival/Settings.json", "_SLS_BegSelfDegradationEnable", _SLS_BegSelfDegradationEnable.GetValueInt())
		JsonUtil.SetIntValue("SL Survival/Settings.json", "KennelSuits", StorageUtil.GetIntValue(Self, "KennelSuits", Missing = 0))
		JsonUtil.SetIntValue("SL Survival/Settings.json", "_SLS_KennelExtraDevices", _SLS_KennelExtraDevices.GetValueInt())
		JsonUtil.SetIntValue("SL Survival/Settings.json", "KennelFollowerToggle", KennelFollowerToggle as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "PpSleepNpcPerk", PpSleepNpcPerk as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "PpFailHandle", PpFailHandle as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "PpLootEnable", PpLootEnable as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "DismemberTrollCum", DismemberTrollCum as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "DismemberBathing", DismemberBathing as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "DismemberPlayerSay", DismemberPlayerSay as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "BikiniExpT", BikiniExpT as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "_SLS_BikiniExpReflexes", _SLS_BikiniExpReflexes.GetValueInt())
		JsonUtil.SetIntValue("SL Survival/Settings.json", "AlwaysAwardBikiniLicFirst", LicUtil.AlwaysAwardBikiniLicFirst as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "_SLS_GuardBehavWeapDropEn", _SLS_GuardBehavWeapDropEn.GetValueInt())
		JsonUtil.SetIntValue("SL Survival/Settings.json", "_SLS_GuardBehavShoutEn", _SLS_GuardBehavShoutEn.GetValueInt())
		JsonUtil.SetIntValue("SL Survival/Settings.json", "GuardBehavWeapDrawn", GuardBehavWeapDrawn as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "GuardBehavLockpicking", GuardBehavLockpicking as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "GuardBehavDrugs", GuardBehavDrugs as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "GuardBehavArmorEquip", GuardBehavArmorEquip as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "GuardBehavWeapEquip", GuardBehavWeapEquip as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "GuardComments", GuardComments as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "CumLactacidAll", CumLactacidAll as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "CumLactacidAllPlayable", CumLactacidAllPlayable as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "OrdinSupress", LicUtil.OrdinSupress as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "ProxSpankComment", Util.ProxSpankComment as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "CoverMyselfMechanics", CoverMyselfMechanics as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "CumAddictDayDream", StorageUtil.GetIntValue(Self, "CumAddictDayDream", Missing = 1))
		JsonUtil.SetIntValue("SL Survival/Settings.json", "CumAddictClampHunger", CumAddictClampHunger as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "CumAddictBeastLevels", CumAddictBeastLevels as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "TollFollowersHardcore", TollFollowersHardcore as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "SexExpEn", SexExpEn as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "IneqStrongFemaleFollowers", IneqStrongFemaleFollowers as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "LicMagicChainCollars", LicMagicChainCollars as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "StashTrackEn", StashTrackEn as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "_SLS_MapAndCompassRecipeEnable", _SLS_MapAndCompassRecipeEnable.GetValueInt())
		JsonUtil.SetIntValue("SL Survival/Settings.json", "CumBlocksAddictionDecay", CumAddict.CumBlocksAddictionDecay as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "DeviousDrowning", DeviousEffects.DeviousDrowning as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "CumAddictDayDreamButterflys", StorageUtil.GetIntValue(Self, "CumAddictDayDreamButterflys", Missing = 1))
		JsonUtil.SetIntValue("SL Survival/Settings.json", "RapeDrugLactacid", ForceDrug.RapeDrugLactacid as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "RapeDrugSkooma", ForceDrug.RapeDrugSkooma as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "RapeDrugHumanCum", ForceDrug.RapeDrugHumanCum as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "RapeDrugCreatureCum", ForceDrug.RapeDrugCreatureCum as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "RapeDrugInflate", ForceDrug.RapeDrugInflate as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "RapeDrugFmFertility", ForceDrug.RapeDrugFmFertility as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "RapeDrugSlenAphrodisiac", ForceDrug.RapeDrugSlenAphrodisiac as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "TollDrugLactacid", ForceDrug.TollDrugLactacid as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "TollDrugSkooma", ForceDrug.TollDrugSkooma as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "TollDrugHumanCum", ForceDrug.TollDrugHumanCum as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "TollDrugCreatureCum", ForceDrug.TollDrugCreatureCum as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "TollDrugInflate", ForceDrug.TollDrugInflate as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "TollDrugFmFertility", ForceDrug.TollDrugFmFertility as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "TollDrugSlenAphrodisiac", ForceDrug.TollDrugSlenAphrodisiac as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "AutoSuckVictim", CumAddict.AutoSuckVictim as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "NpcComments", (Game.GetFormFromFile(0x0DF88F, "SL Survival.esp") as GlobalVariable).GetValueInt())
		JsonUtil.SetIntValue("SL Survival/Settings.json", "JigglesVisuals", (Game.GetFormFromFile(0x0CF9B1, "SL Survival.esp") as _SLS_BodyInflationTracking).DoImod as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "CompulsiveSex", StorageUtil.GetIntValue(Self, "CompulsiveSex", Missing = 1))
		JsonUtil.SetIntValue("SL Survival/Settings.json", "OrgasmFatigue", StorageUtil.GetIntValue(Self, "OrgasmFatigue", Missing = 1))
		JsonUtil.SetIntValue("SL Survival/Settings.json", "AmpBlockMagic", Amputation.BlockMagic as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "Trauma.TraumaEnable", Trauma.TraumaEnable as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "Trauma.DynamicTrauma", Trauma.DynamicTrauma as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "Trauma.DynamicCombat", Trauma.DynamicCombat as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "GuardBehavArmorEquipAnyArmor", StorageUtil.GetIntValue(Self, "GuardBehavArmorEquipAnyArmor", Missing = 0))
		JsonUtil.SetIntValue("SL Survival/Settings.json", "Init.TollEnable", Init.TollEnable as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "AhegaoEnable", StorageUtil.GetIntValue(Self, "AhegaoEnable", Missing = 1))
		JsonUtil.SetIntValue("SL Survival/Settings.json", "RapeDrainsAttributes", RapeDrainsAttributes as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "Curfew.DoCurfewNotification", (Game.GetFormFromFile(0x0E3F3D, "SL Survival.esp") as _SLS_Curfew).DoCurfewNotification as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "LicUtil.CheckFollowers", LicUtil.CheckFollowers as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "LicUtil.LicForceCheckDeviousFollower", LicUtil.ForceCheckDF as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "BikiniBreak.CompatibilityMode", (Game.GetFormFromFile(0x10D7AF, "SL Survival.esp") as _SLS_BikiniBreak).CompatibilityMode as Int)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "DroppedItemStealingEn", StorageUtil.GetIntValue(Self, "DroppedItemStealingEn") as Int)
		
		; Ints
		JsonUtil.SetIntValue("SL Survival/Settings.json", "PushEvents", PushEvents)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "SurvivalHorseCost", SurvivalHorseCost)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "FolGoldSteamAmount", FolGoldSteamAmount)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "HalfNakedBra", HalfNakedBra)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "HalfNakedPanty", HalfNakedPanty)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "AproTwoTrollHealAmount", AproTwoTrollHealAmount)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "DevEffLockpickDiff", DevEffLockpickDiff)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "DevEffPickpocketDiff", DevEffPickpocketDiff)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "BondFurnMilkWill", BondFurnMilkWill)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "BondFurnWill", BondFurnWill)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "_SLS_IneqStat", _SLS_IneqStat.GetValueInt())
		JsonUtil.SetIntValue("SL Survival/Settings.json", "_SLS_IneqCarry", _SLS_IneqCarry.GetValueInt())
		JsonUtil.SetIntValue("SL Survival/Settings.json", "_SLS_IneqSpeed", _SLS_IneqSpeed.GetValueInt())
		JsonUtil.SetIntValue("SL Survival/Settings.json", "_SLS_IneqDamage", _SLS_IneqDamage.GetValueInt())
		JsonUtil.SetIntValue("SL Survival/Settings.json", "_SLS_IneqDestruction", _SLS_IneqDestruction.GetValueInt())
		JsonUtil.SetIntValue("SL Survival/Settings.json", "SwimCumClean", SwimCumClean)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "TollSexAgg", TollSexAgg)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "TollSexVictim", TollSexVictim)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "TollCostGold", TollUtil.TollCostGold)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "SlaverunJobFactor", TollUtil.SlaverunJobFactor)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "TollCostDevices", TollUtil.TollCostDevices)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "TollCostTattoos", TollUtil.TollCostTattoos)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "TollCostDrugs", TollUtil.TollCostDrugs)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "MaxTatsBody", MaxTatsBody)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "MaxTatsFace", MaxTatsFace)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "MaxTatsHands", MaxTatsHands)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "MaxTatsFeet", MaxTatsFeet)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "TollDodgeMaxGuards", TollDodgeMaxGuards)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "BuyBackPrice", BuyBackPrice)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "LicUtil.LicCostWeaponShort", LicUtil.LicCostWeaponShort)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "LicUtil.LicCostWeaponLong", LicUtil.LicCostWeaponLong)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "LicUtil.LicCostWeaponPer", LicUtil.LicCostWeaponPer)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "LicUtil.LicCostMagicShort", LicUtil.LicCostMagicShort)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "LicUtil.LicCostMagicLong", LicUtil.LicCostMagicLong)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "LicUtil.LicCostMagicPer", LicUtil.LicCostMagicPer)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "LicUtil.LicCostArmorShort", LicUtil.LicCostArmorShort)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "LicUtil.LicCostArmorLong", LicUtil.LicCostArmorLong)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "LicUtil.LicCostArmorPer", LicUtil.LicCostArmorPer)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "LicUtil.LicCostBikiniShort", LicUtil.LicCostBikiniShort)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "LicUtil.LicCostBikiniLong", LicUtil.LicCostBikiniLong)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "LicUtil.LicCostBikiniPer", LicUtil.LicCostBikiniPer)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "LicUtil.LicCostClothesShort", LicUtil.LicCostClothesShort)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "LicUtil.LicCostClothesLong", LicUtil.LicCostClothesLong)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "LicUtil.LicCostClothesPer", LicUtil.LicCostClothesPer)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "BikiniCurseArea", BikiniCurseArea)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "MagicCurseArea", MagicCurseArea)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "TradeRestrictBribe", TradeRestrictBribe)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "EnforcersMin", EnforcersMin)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "EnforcersMax", EnforcersMax)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "LicUtil.LicClothesEnable", LicUtil.LicClothesEnable)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "BegNumItems", BegNumItems)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "BegSexAgg", BegSexAgg)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "BegSexVictim", BegSexVictim)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "KennelSafeCellCost", KennelSafeCellCost)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "KennelSlaveRapeTimeMin", KennelSlaveRapeTimeMin)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "KennelSlaveRapeTimeMax", KennelSlaveRapeTimeMax)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "KennelSlaveDeviceCountMin", StorageUtil.GetIntValue(Self, "KennelSlaveDeviceCountMin", Missing = 2))
		JsonUtil.SetIntValue("SL Survival/Settings.json", "KennelSlaveDeviceCountMax", StorageUtil.GetIntValue(Self, "KennelSlaveDeviceCountMax", Missing = 6))
		JsonUtil.SetIntValue("SL Survival/Settings.json", "_SLS_KennelExtraDevices", _SLS_KennelExtraDevices.GetValueInt())
		JsonUtil.SetIntValue("SL Survival/Settings.json", "KennelSexAgg", KennelSexAgg)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "KennelSexVictim", KennelSexVictim)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "PpFailDevices", Init.PpFailDevices)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "_SLS_PickPocketFailStealValue", _SLS_PickPocketFailStealValue.GetValueInt())
		JsonUtil.SetIntValue("SL Survival/Settings.json", "PpFailDrugCount", PpFailDrugCount)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "Util.PpLootLootMin", Util.PpLootLootMin)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "Util.PpLootLootMax", Util.PpLootLootMax)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "AmpDepth", AmpDepth)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "DismemberWeapon", DismemberWeapon)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "MaxAmpDepthArms", MaxAmpDepthArms)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "MaxAmpDepthLegs", MaxAmpDepthLegs)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "MaxAmpedLimbs", MaxAmpedLimbs)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "DismemberDamageThres", DismemberDamageThres)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "_SLS_AmpPriestHealCost", _SLS_AmpPriestHealCost.GetValueInt())
		JsonUtil.SetIntValue("SL Survival/Settings.json", "BikiniDropsVendorCity", BikiniDropsVendorCity)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "BikiniDropsVendorTown", BikiniDropsVendorTown)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "BikiniDropsVendorKhajiit", BikiniDropsVendorKhajiit)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "BikiniDropsChest", BikiniDropsChest)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "BikiniDropsChestOrnate", BikiniDropsChestOrnate)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "_SLS_BikiniExpReflexes", _SLS_BikiniExpReflexes.GetValueInt())
		JsonUtil.SetIntValue("SL Survival/Settings.json", "ProxSpankNpcType", ProxSpankNpcType)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "_SLS_ProxSpankRequiredCover", _SLS_ProxSpankRequiredCover.GetValueInt())
		JsonUtil.SetIntValue("SL Survival/Settings.json", "CumHungerAutoSuck", CumHungerAutoSuck)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "PpCrimeGold", PpCrimeGold)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "SexExpCorruption", SexExpCorruption)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "FollowerLicStyle", LicUtil.FollowerLicStyle)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "_SLS_TollFollowersRequired", _SLS_TollFollowersRequired.GetValueInt())
		JsonUtil.SetIntValue("SL Survival/Settings.json", "_SLS_LicUnlockCost", _SLS_LicUnlockCost.GetValueInt())
		JsonUtil.SetIntValue("SL Survival/Settings.json", "LicenceStyle", LicUtil.LicenceStyle)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "CompassHideMethod", CompassHideMethod)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "_SLS_LicInspPersistence", _SLS_LicInspPersistence.GetValueInt())
		JsonUtil.SetIntValue("SL Survival/Settings.json", "AioKey", AllInOne.AioKey)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "HairCutMinLevel", FashionRape.HairCutMinLevel)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "HairCutMaxLevel", FashionRape.HairCutMaxLevel)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "HaircutFloor", FashionRape.HaircutFloor)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "OpenMouthKey", CumSwallow.OpenMouthKey)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "Trauma.PlayerTraumaCountMax", Trauma.PlayerTraumaCountMax)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "Trauma.FollowerTraumaCountMax", Trauma.FollowerTraumaCountMax)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "Trauma.NpcTraumaCountMax", Trauma.NpcTraumaCountMax)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "Trauma.SexHitsPlayer", Trauma.SexHitsPlayer)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "Trauma.SexHitsFollower", Trauma.SexHitsFollower)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "Trauma.SexHitsNpc", Trauma.SexHitsNpc)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "Trauma.CombatDamageThreshold", Trauma.CombatDamageThreshold)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "AllInOne.StatusKey", AllInOne.StatusKey)
		JsonUtil.SetIntValue("SL Survival/Settings.json", "EasyHomeWhiterun", (Game.GetFormFromFile(0x112E32, "SL Survival.esp") as GlobalVariable).GetValueInt())
		JsonUtil.SetIntValue("SL Survival/Settings.json", "EasyHomeSolitude", (Game.GetFormFromFile(0x113395, "SL Survival.esp") as GlobalVariable).GetValueInt())
		JsonUtil.SetIntValue("SL Survival/Settings.json", "EasyHomeMarkarth", (Game.GetFormFromFile(0x113396, "SL Survival.esp") as GlobalVariable).GetValueInt())
		JsonUtil.SetIntValue("SL Survival/Settings.json", "EasyHomeWindhelm", (Game.GetFormFromFile(0x113397, "SL Survival.esp") as GlobalVariable).GetValueInt())
		JsonUtil.SetIntValue("SL Survival/Settings.json", "EasyHomeRiften", (Game.GetFormFromFile(0x113398, "SL Survival.esp") as GlobalVariable).GetValueInt())
		JsonUtil.SetIntValue("SL Survival/Settings.json", "HousePriceWhiterun", (Game.GetFormFromFile(0xF728B, "Skyrim.esm") as GlobalVariable).GetValueInt())
		JsonUtil.SetIntValue("SL Survival/Settings.json", "HousePriceSolitude", (Game.GetFormFromFile(0xF728C, "Skyrim.esm") as GlobalVariable).GetValueInt())
		JsonUtil.SetIntValue("SL Survival/Settings.json", "HousePriceMarkarth", (Game.GetFormFromFile(0xF728E, "Skyrim.esm") as GlobalVariable).GetValueInt())
		JsonUtil.SetIntValue("SL Survival/Settings.json", "HousePriceWindhelm", (Game.GetFormFromFile(0xF728A, "Skyrim.esm") as GlobalVariable).GetValueInt())
		JsonUtil.SetIntValue("SL Survival/Settings.json", "HousePriceRiften", (Game.GetFormFromFile(0xF728D, "Skyrim.esm") as GlobalVariable).GetValueInt())
		JsonUtil.SetIntValue("SL Survival/Settings.json", "AllInOne.Fav.Favorite", AllInOne.Fav.Favorite)

		; Floats
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "CumAddictDayDreamArousal", StorageUtil.GetFloatValue(Self, "CumAddictDayDreamArousal", Missing = 101.0))
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "FolGoldStealChance", FolGoldStealChance)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "BarefootMag", BarefootMag)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "MinSpeedMult", MinSpeedMult)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "MinCarryWeight", MinCarryWeight)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "ReplaceMapsTimer", ReplaceMapsTimer)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "SlaverunAutoMin", SlaverunAutoMin)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "SlaverunAutoMax", SlaverunAutoMax)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "CumSwallowInflateMult", CumSwallowInflateMult)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "CumEffectsMagMult", CumEffectsMagMult)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "CumEffectsDurMult", CumEffectsDurMult)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "CumpulsionChance", CumpulsionChance)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "AnimalFriend.BreedingCooloffBase", AnimalFriend.BreedingCooloffBase)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "AnimalFriend.BreedingCooloffCumCovered", AnimalFriend.BreedingCooloffCumCovered)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "AnimalFriend.BreedingCooloffCumFilled", AnimalFriend.BreedingCooloffCumFilled)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "AnimalFriend.SwallowBonus", AnimalFriend.SwallowBonus)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "AnimalFriend.BreedingCooloffPregnancy", AnimalFriend.BreedingCooloffPregnancy)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "DflowResistLoss", DflowResistLoss)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "BondFurnMilkFreq", BondFurnMilkFreq)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "BondFurnMilkFatigueMult", BondFurnMilkFatigueMult)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "BondFurnFreq", BondFurnFreq)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "BondFurnFatigueMult", BondFurnFatigueMult)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "IneqStatsVal", IneqStatsVal)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "IneqHealthCushion", IneqHealthCushion)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "IneqCarryVal", IneqCarryVal)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "IneqSpeedVal", IneqSpeedVal)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "IneqDamageVal", IneqDamageVal)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "IneqDestVal", IneqDestVal)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "KnockSlaveryChance", KnockSlaveryChance)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "SimpleSlaveryWeight", SimpleSlaveryWeight)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "SdWeight", SdWeight)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "GluttedSpeed", GluttedSpeed)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "Needs.BaseBellyScale", Needs.BaseBellyScale)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "Rnd.BellyScaleRnd00", Rnd.BellyScaleRnd00)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "Rnd.BellyScaleRnd01", Rnd.BellyScaleRnd01)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "Rnd.BellyScaleRnd02", Rnd.BellyScaleRnd02)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "Rnd.BellyScaleRnd03", Rnd.BellyScaleRnd03)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "Rnd.BellyScaleRnd04", Rnd.BellyScaleRnd04)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "Rnd.BellyScaleRnd05", Rnd.BellyScaleRnd05)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "SkoomaSleep", SkoomaSleep)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "MilkSleepMult", MilkSleepMult)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "DrugEndFatigueInc", DrugEndFatigueInc)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "Needs.CumFoodMult", Needs.CumFoodMult)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "Needs.CumDrinkMult", Needs.CumDrinkMult)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "Ineed.BellyScaleIneed00", Ineed.BellyScaleIneed00)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "Ineed.BellyScaleIneed01", Ineed.BellyScaleIneed01)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "Ineed.BellyScaleIneed02", Ineed.BellyScaleIneed02)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "Ineed.BellyScaleIneed03", Ineed.BellyScaleIneed03)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "WarmBodies", WarmBodies)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "MilkLeakWet", MilkLeakWet)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "CumWetMult", CumWetMult)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "CumExposureMult", CumExposureMult)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "SimpleSlaveryFF", SimpleSlaveryFF)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "SdDreamFF", SdDreamFF)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "SlaverunFactor", TollUtil.SlaverunFactor)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "TollDodgeGracePeriod", TollDodgeGracePeriod)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "TollDodgeHuntFreq", TollDodgeHuntFreq)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "TollDodgeItemValueMod", TollDodgeItemValueMod)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "GuardSpotDistNom", GuardSpotDistNom)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "GuardSpotDistTown", GuardSpotDistTown)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "TollDodgeDisguiseBodyPenalty", TollDodgeDisguiseBodyPenalty)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "TollDodgeDisguiseHeadPenalty", TollDodgeDisguiseHeadPenalty)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "_SLS_GateCurfewBegin", (Game.GetFormFromFile(0x0EAB5A, "SL Survival.esp") as GlobalVariable).GetValue()) ; _SLS_GateCurfewBegin
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "_SLS_GateCurfewEnd", (Game.GetFormFromFile(0x0EAB5B, "SL Survival.esp") as GlobalVariable).GetValue()) ; _SLS_GateCurfewEnd
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "_SLS_GateCurfewSlavetownBegin", (Game.GetFormFromFile(0x0EE155, "SL Survival.esp") as GlobalVariable).GetValue()) ; _SLS_GateCurfewSlavetownBegin
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "_SLS_GateCurfewSlavetownEnd", (Game.GetFormFromFile(0x0EE156, "SL Survival.esp") as GlobalVariable).GetValue()) ; _SLS_GateCurfewSlavetownEnd
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "LicBlockChance", LicBlockChance)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "LicUtil.LicFactionDiscount", LicUtil.LicFactionDiscount)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "LicUtil.LicShortDur", LicUtil.LicShortDur)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "LicUtil.LicLongDur", LicUtil.LicLongDur)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "EnforcerRespawnDur", EnforcerRespawnDur)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "BikiniCurse.HeelHeightRequired", BikiniCurse.HeelHeightRequired)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "RoadDist", RoadDist)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "StealXItems", StealXItems)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "BegGold", BegGold)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "BegMwaCurseChance", BegMwaCurseChance)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "KennelRapeChancePerHour", KennelRapeChancePerHour)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "KennelCreatureChance", KennelCreatureChance)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "PpGoldLowChance", PpGoldLowChance)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "PpGoldModerateChance", PpGoldModerateChance)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "PpGoldHighChance", PpGoldHighChance)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "PpLootFoodChance", PpLootFoodChance)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "PpLootGemsChance", PpLootGemsChance)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "PpLootSoulgemsChance", PpLootSoulgemsChance)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "PpLootJewelryChance", PpLootJewelryChance)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "PpLootEnchJewelryChance", PpLootEnchJewelryChance)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "PpLootPotionsChance", PpLootPotionsChance)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "PpLootKeysChance", PpLootKeysChance)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "PpLootTomesChance", PpLootTomesChance)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "PpLootCureChance", PpLootCureChance)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "DismemberCooldown", DismemberCooldown)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "DismemberChance", DismemberChance)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "DismemberArmorBonus", DismemberArmorBonus)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "DismemberHealthThres", DismemberHealthThres)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "BikiniExp.ExpPerLevel", BikiniExp.ExpPerLevel)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "BikTrainingSpeed", BikTrainingSpeed)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "BikUntrainingSpeed", BikUntrainingSpeed)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "BikiniChanceHide", BikiniChanceHide)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "BikiniChanceLeather", BikiniChanceLeather)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "BikiniChanceIron", BikiniChanceIron)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "BikiniChanceSteel", BikiniChanceSteel)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "BikiniChanceSteelPlate", BikiniChanceSteelPlate)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "BikiniChanceDwarven", BikiniChanceDwarven)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "BikiniChanceFalmer", BikiniChanceFalmer)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "BikiniChanceWolf", BikiniChanceWolf)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "BikiniChanceBlades", BikiniChanceBlades)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "BikiniChanceEbony", BikiniChanceEbony)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "BikiniChanceDragonbone", BikiniChanceDragonbone)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "IneqFemaleVendorGoldMult", IneqFemaleVendorGoldMult)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "CatCallVol", CatCallVol)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "CumIsLactacid", CumIsLactacid)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "ProxSpankCooloff", ProxSpankCooloff)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "CatCallWillLoss", CatCallWillLoss)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "GreetDist", GreetDist)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "CumAddictBatheRefuseTime", CumAddictBatheRefuseTime)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "CumAddictReflexSwallow", CumAddictReflexSwallow)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "CumAddictAutoSuckCreature", CumAddictAutoSuckCreature)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "CumAddictAutoSuckCooldown", CumAddictAutoSuckCooldown)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "CumAddictAutoSuckCreatureArousal", CumAddictAutoSuckCreatureArousal)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "AssSlapResistLoss", AssSlapResistLoss)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "GoldWeight", GoldWeight)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "CumSatiation", CumSatiation)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "CumAddictionHungerRate", CumAddictionHungerRate)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "CumAddictionSpeed", CumAddictionSpeed)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "CumAddictionDecayPerHour", CumAddictionDecayPerHour)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "CockSizeBonusEnjFreq", CockSizeBonusEnjFreq)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "RapeForcedSkoomaChance", RapeForcedSkoomaChance)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "RapeMinArousal", RapeMinArousal)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "DeviousGagDebuff", DeviousGagDebuff)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "CumAddictDayDreamVol", StorageUtil.GetFloatValue(Self, "CumAddictDayDreamVol", Missing = 1.0))
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "ScaleMaxBreasts", Main.Slif.ScaleMaxBreasts)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "ScaleMaxBelly", Main.Slif.ScaleMaxBelly)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "ScaleMaxAss", Main.Slif.ScaleMaxAss)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "HaircutChance", FashionRape.HaircutChance)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "DyeHairChance", FashionRape.DyeHairChance)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "ShavePussyChance", FashionRape.ShavePussyChance)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "SmudgeLipstickChance", FashionRape.SmudgeLipstickChance)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "SmudgeEyeshadowChance", FashionRape.SmudgeEyeshadowChance)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "WeightGainPerDay", StorageUtil.GetFloatValue(Self, "WeightGainPerDay", Missing = 0.0))
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "PushCooldown", (Game.GetFormFromFile(0x0E651A, "SL Survival.esp") as _SLS_PushPlayerCooloff).CooloffPeriod)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "TimeBetweenFucks", (Game.GetFormFromFile(0x0E7553, "SL Survival.esp") as _SLS_CompulsiveSex).TimeBetweenFucks)
		;JsonUtil.SetFloatValue("SL Survival/Settings.json", "OrgasmFatigueThreshold", (Game.GetFormFromFile(0x0E857D, "SL Survival.esp") as _SLS_OrgasmFatigue).OrgasmThreshold)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "OrgasmFatigueRecovery", (Game.GetFormFromFile(0x0E857D, "SL Survival.esp") as _SLS_OrgasmFatigue).OrgasmRecoveryPerHour)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "TimeToClearStreets", (Game.GetFormFromFile(0x0E3F3D, "SL Survival.esp") as _SLS_Curfew).TimeToClearStreets)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "_SLS_CurfewBegin", (Game.GetFormFromFile(0x07B44C, "SL Survival.esp") as GlobalVariable).GetValue()) ; _SLS_CurfewBegin
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "_SLS_CurfewEnd", (Game.GetFormFromFile(0x07B44D, "SL Survival.esp") as GlobalVariable).GetValue()) ; _SLS_CurfewEnd
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "_SLS_CurfewSlavetownBegin", (Game.GetFormFromFile(0x0ECBC0, "SL Survival.esp") as GlobalVariable).GetValue()) ; _SLS_CurfewSlavetownBegin
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "_SLS_CurfewSlavetownEnd", (Game.GetFormFromFile(0x0ECBC1, "SL Survival.esp") as GlobalVariable).GetValue()) ; _SLS_CurfewSlavetownEnd
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "Trauma.StartingAlpha", Trauma.StartingAlpha)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "Trauma.MaxAlpha", Trauma.MaxAlpha)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "Trauma.HoursToMaxAlpha", Trauma.HoursToMaxAlpha)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "Trauma.HoursToFadeOut", Trauma.HoursToFadeOut)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "Trauma.SexChancePlayer", Trauma.SexChancePlayer)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "Trauma.SexChanceFollower", Trauma.SexChanceFollower)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "Trauma.SexChanceNpc", Trauma.SexChanceNpc)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "Trauma.CombatChancePlayer", Trauma.CombatChancePlayer)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "Trauma.CombatChanceFollower", Trauma.CombatChanceFollower)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "Trauma.CombatChanceNpc", Trauma.CombatChanceNpc)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "Trauma.PushChance", Trauma.PushChance)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "Util.PainSoundVol", Util.PainSoundVol)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "Util.HitSoundVol", Util.HitSoundVol)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "Ahegao.DurPerOrgasm", (Game.GetFormFromFile(0x0FCE71, "SL Survival.esp") as _SLS_Ahegao).DurPerOrgasm)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "Voices.VoicesChance", (Game.GetFormFromFile(0x104511, "SL Survival.esp") as _SLS_CumDesperationVoices).VoicesChance)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "Voices.VoicesVolume", (Game.GetFormFromFile(0x104511, "SL Survival.esp") as _SLS_CumDesperationVoices).VoicesVolume)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "Voices.VanillaVoiceVolume", (Game.GetFormFromFile(0x104511, "SL Survival.esp") as _SLS_CumDesperationVoices).VanillaVoiceVolume)
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "_SLS_LicMagicCurseLimit", (Game.GetFormFromFile(0x10C223, "SL Survival.esp") as GlobalVariable).GetValue())
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "_SLS_EnforcerChaseDistance", (Game.GetFormFromFile(0x1118A1, "SL Survival.esp") as GlobalVariable).GetValue()) ; _SLS_LicInspChaseDistance
		JsonUtil.SetFloatValue("SL Survival/Settings.json", "CumSwallow.CumInsideBonusEnjMult", CumSwallow.CumInsideBonusEnjMult)
		
		; Int list
		JsonUtil.IntListCopy("SL Survival/Settings.json", "InnCosts", LocTrack.InnCosts)
		
		; Forms
		SaveFormlistToJson(_SLS_CumHasLactacidVoices, "SL Survival/Settings.json", "_SLS_CumHasLactacidVoices", ClearJsonKey = true)

		JsonUtil.Save("SL Survival/Settings.json")
		If IsInMcm
			SetTextOptionValue(ExportSettingsOID_T, "Save Complete!")
		EndIf
		Utility.WaitMenuMode(0.7)
		If IsInMcm
			SetTextOptionValue(ExportSettingsOID_T, "")
		EndIf
	EndIf
EndFunction

Function SaveFormlistToJson(Formlist FlSelect, String FileName, String JsonKey, Bool ClearJsonKey = true)
	If ClearJsonKey
		JsonUtil.FormListClear(FileName, JsonKey)
	EndIf

	Form akForm
	Int i = 0
	While i < FlSelect.GetSize()
		akForm = FlSelect.GetAt(i)
		If akForm
			JsonUtil.FormListAdd(FileName, JsonKey, akForm, allowDuplicate = false)
			Debug.Trace("_SLS_: Saved " + akForm + " to key " + JsonKey + " in file: " + FileName + " to formlist: " + FlSelect)
		EndIf
		i += 1
	EndWhile
EndFunction

Function LoadJsonFormsToFormlist(Formlist FlSelect, String FileName, String JsonKey, Bool RevertFl = true)
	If RevertFl
		FlSelect.Revert()
	EndIf
	
	Form akForm
	Int i = 0
	While i < JsonUtil.FormListCount(FileName, JsonKey)
		akForm = JsonUtil.FormListGet(FileName, JsonKey, i)
		If akForm
			FlSelect.AddForm(akForm)
			Debug.Trace("_SLS_: Loaded " + akForm + " from key " + JsonKey + " in file: " + FileName + " to formlist: " + FlSelect)
		EndIf
		i += 1
	EndWhile
EndFunction

; MCM Begin ===================================================

; Keys
Int AllInOneKeyOID

; Text
Int ImportSettingsOID_T
Int ExportSettingsOID_T
Int SearchEscortsOID_T
Int AddEscortToListOID_T
Int RemoveEscortFromListOID_T
Int ClearAllEscortsOID_T
Int ImportEscortsFromJsonOID_T
Int LicGetEquipListOID_T
Int AddLicExceptionOID_T
Int TradeRestrictAddMerchantOID_T
Int TradeRestrictRemoveMerchantOID_T
Int TradeRestrictResetAllMerchantsOID_T
Int LicBikiniTriggerOID_T
Int StashAddRemoveExceptionOID_T
Int StashAddRemoveJsonExceptionsOID_T
Int StashAddRemoveTempExceptionsOID_T
Int StashAddRemoveAllExceptionsOID_T
Int LicBikiniHeelsOID
Int DiscountCollegeOID_T
Int DiscountCompanionsOID_T
Int DiscountCwOID_T
Int BikiniBuildListOID_T
Int BikiniClearListOID_T
Int BikiniChanceNoneOID_S
Int SexExpResetStatsOID_T
Int ModStrongFemaleOID_T
Int AddFondleToListOID_T
Int RemoveFondleFromListOID_T
Int FondleInfoOID_T
Int Property RunDevicePatchUpOID_T Auto Hidden
Int LicShowApiBlockFormsOID_T
Int LicClearApiBlockFormsOID_T
Int CurrentLocationOID_T
Int AddTownLocationOID_T
Int RemoveTownLocationOID_T
Int DismemberChanceActualOID_T
Int CumLactacidCustomOID_T
Int TollDodgedWhiterunOID_T
Int TollDodgedSolitudeOID_T
Int TollDodgedMarkarthOID_T
Int TollDodgedWindhelmOID_T
Int TollDodgedRiftenOID_T

; Toggles
Int CoverMyselfMechanicsOID
Int AssSlappingOID
Int ProxSpankCommentOID
Int EasyBedTrapsOID
Int CumBreathOID
Int CumBreathNotifyOID
Int DropItemsOID
Int SlsCreatureEventOID
Int AnimalBreedEnableOID
Int HardcoreModeOID
Int DebugModeOID
Int SlaverunAutoStartOID
Int MinAvToggleOID
Int FastTravelDisableOID
Int FtDisableIsNormalOID
Int ConstructableMapAndCompassOID
Int ReplaceMapsOID
Int CompassMechanicsOID
Int CumSwallowInflateOID
Int CumEffectsEnableOID
Int CumEffectsStackOID
Int CumAddictEnOID
Int CumAddictClampHungerOID
Int CumAddictBeastLevelsOID
Int SuccubusCumSwallowEnergyPerRankOID
Int CumLactacidAllOID
Int CumLactacidAllPlayableOID
;/
Int CumLactacidBearOID
Int CumLactacidChaurusOID
Int CumLactacidDeerOID
Int CumLactacidDogOID
Int CumLactacidDragonPriestOID
Int CumLactacidDragonOID
Int CumLactacidDraugrOID
Int CumLactacidDremoraOID
Int CumLactacidDwarvenCenturionOID
Int CumLactacidDwarvenSphereOID
Int CumLactacidDwarvenSpiderOID
Int CumLactacidFalmerOID
Int CumLactacidFoxOID
Int CumLactacidSpiderOID
Int CumLactacidGiantOID
Int CumLactacidGoatOID
Int CumLactacidHorkerOID
Int CumLactacidHorseOID
Int CumLactacidMammothOID
Int CumLactacidSabrecatOID
Int CumLactacidSkeeverOID
Int CumLactacidSprigganOID
Int CumLactacidTrollOID
Int CumLactacidWerewolfOID
Int CumLactacidWolfOID
/;
Int FfRescueEventsOID
Int MilkDecCumBreathOID
Int PpLootEnableOID
Int PpFailHandleOID
Int PpSleepNpcPerkOID
;/
Int IntRndOID
Int IntIneedOID
Int IntEsdOID
Int IntFrostfallOID
Int IntSlaverunOID
Int IntPscOID
Int IntDdsOID
Int IntDfOID
Int IntEffOID
Int IntSgoOID
Int IntStaOID
Int IntFhuOID
Int IntAmpOID
Int IntAproposTwoOID
Int IntTatsOID
Int IntMaOID
Int IntSlaxOID
Int IntSlsfOID
Int IntSlsoOID
/;
Int HalfNakedEnableOID
Int HalfNakedStripsOID
Int SexExpEnableOID
Int DremoraCorruptionOID
Int SexMinStamMagRatesOID
Int SexRapeDrainsAttributesOID
Int CurfewEnableOID

Int IneqStatsOID
Int IneqCarryOID
Int InqSpeedOID
Int IneqDamageOID
Int IneqDestOID
Int IneqSkillsOID
Int IneqBuySellOID
Int IneqStrongFemaleFollowersOID

Int NormalKnockDialogOID
Int SleepDeprivOID
Int SaltyCumOID
Int BellyScaleEnableOID
Int GoldPerLevelOID
Int DoorLockDownOID
Int TollFollowersHardcoreOID
Int TollDodgingOID
Int TollDodgeGiftMenuOID
Int StashTrackEnOID
Int ContTypeCountsOID
Int OrgasmRequiredOID
Int LicencesEnableOID
Int LicencesSnowberryOID
Int BikiniLicFirstOID
Int LicBuyBackOID
Int LicBountyMustBePaidOID
Int FolContraBlockOID
Int FolContraKeysOID
Int FolTakeClothesOID
Int OrdinSupressOID
Int CurseTatsOID
Int ResponsiveEnforcersOID
Int PersistentEnforcersOID_S
Int RestrictTradeOID
Int BeggingTOID
Int BegSelfDegEnableOID
Int KennelExtraDevicesOID
Int KennelFollowerToggleOID
Int GuardCommentsOID
Int GuardBehavWeapDropOID
Int GuardBehavWeapEquipOID
Int GuardBehavWeapDrawnOID
Int GuardBehavArmorEquipOID
Int GuardBehavLockpickingOID
Int GuardBehavDrugsOID
Int GuardBehavShoutOID
Int DeviousEffectsEnableOID
Int DevEffNoGagTradingOID
Int BondFurnEnableOID
Int BikiniExpOID
Int BikiniExpReflexesOID

; Sliders
Int ReplaceMapsTimerOID_S
Int GoldWeightOID_S
Int FolGoldStealChanceOID_S
Int FolGoldSteamAmountOID_S
Int SlaverunAutoMinOID_S
Int SlaverunAutoMaxOID_S
Int HalfNakedBraOID_S
Int HalfNakedPantyOID_S
Int SexExpCorruptionCurrentOID_S
Int CockSizeBonusEnjFreqOID_S
Int RapeForcedSkoomaChanceOID_S
Int RapeMinArousalOID_S
Int SexMinStaminaRateOID_S
Int SexMinStaminaMultOID_S
Int SexMinMagickaRateOID_S
Int SexMinMagickaMultOID_S
Int AssSlapResistLossOID_S
Int ProxSpankCooloffOID_S
Int CumIsLactacidOID_S
Int AproTwoTrollHealAmountOID
Int AfCooloffBaseOID_S
Int AfCooloffBodyCumOID_S
Int AfCooloffCumInflationOID_S
Int AfCooloffPregnancyOID_S
Int AfCooloffCumSwallowOID_S
Int DflowResistLossOID_S
Int CumSwallowInflateMultOID_S
Int CumEffectsMagMultOID_S
Int CumEffectsDurMultOID_S
Int CumpulsionChanceOID_S
Int CumRegenTimeOID_S
Int CumEffectVolThresOID_S
Int SuccubusCumSwallowEnergyMultOID_S
Int CumAddictionSpeedOID_S
Int CumAddictHungerRateOID_S
Int CumAddictHungerRateEffective
Int CumAddictionPerHourOID_S
Int CumSatiationOID_S
Int CumAddictBatheRefuseTimeOID_S
Int CumAddictReflexSwallowOID_S
Int CumAddictAutoSuckCreatureOID_S
Int CumAddictAutoSuckCooldownOID_S
Int CumAddictAutoSuckCreatureArousalOID_S
Int DeviousGagDebuffOID_S
Int BondFurnMilkFreqOID_S
Int BondFurnMilkFatigueMultOID_S
Int BondFurnMilkWillOID_S
Int BondFurnFreqOID_S
Int BondFurnFatigueMultOID_S
Int BondFurnWillOID_S
Int BarefootMagOIS_S
Int HorseCostOIS_S
Int CatCallVolOIS_S
Int CatCallWillLossOIS_S
Int GreetDistOIS_S
Int MinSpeedOID_S
Int MinCarryWeightOID_S

Int PpGoldChanceOfNoneOID_T
Int PpGoldLowChanceOID_S
Int PpGoldModerateChanceOID_S
Int PpGoldHighChanceOID_S
Int PpLootMinOID_S
Int PpLootMaxOID_S
Int PpLootChanceOfNoneOID_T
Int PpLootFoodChanceOID_S
Int PpLootGemsChanceOID_S
Int PpLootSoulgemsChanceOID_S
Int PpLootJewelryChanceOID_S
Int PpLootEnchJewelryChanceOID_S
Int PpLootPotionsChanceOID_S
Int PpLootKeysChanceOID_S
Int PpLootTomesChanceOID_S
Int PpLootCureChanceOID_S

Int PpCrimeGoldOID_S
Int PpFailDevicesOID_S
Int PpFailStealValueOID_S
Int PpFailDrugCountOID_S

Int DismemberCooldownOID_S
Int DismemberMaxAmpedLimbsOID_S
Int DismemberChanceOID_S
Int DismemberArmorBonusOID_S
Int DismemberDamageThresOID_S
Int DismemberHealthThresOID_S
Int AmpPriestHealCostOID_S
Int DismemberTrollCumOID
Int DismemberBathingOID
Int DismemberPlayerSayOID

Int IneqStatsValOID
Int IneqCarryValOID
Int IneqSpeedValOID
Int IneqDamageValOID
Int IneqDestValOID
Int IneqHealthCushionOID
Int IneqVendorGoldOID

Int KnockSlaveryChanceOID_S
Int SimpleSlaveryWeightOID_S
Int SdWeightOID_S

Int GluttedSpeedMultOID_S
Int CumFoodMultOID_S
Int CumDrinkMultOID_S
Int SkoomaSleepOID_S
Int MilkSleepMultOID_S
Int DrugEndFatigueIncOID_S
Int BaseBellyScaleOID_S
Int BellyScaleRnd00OID_S
Int BellyScaleRnd01OID_S
Int BellyScaleRnd02OID_S
Int BellyScaleRnd03OID_S
Int BellyScaleRnd04OID_S
Int BellyScaleRnd05OID_S

Int BellyScaleIneed00OID_S
Int BellyScaleIneed01OID_S
Int BellyScaleIneed02OID_S
Int BellyScaleIneed03OID_S

Int WarmBodiesOID_S
Int CumWetMultOID_S
Int CumExposureMultOID_S
Int MilkLeakWetOID_S
Int SwimCumCleanOID_S
Int SimpleSlaveryFFOID_S
Int SdDreamFFOID_S

Int EvictionLimitOID_S
Int SlaverunEvictionLimitOID_S
Int ConfiscationFineOID_S
Int ConfiscationFineSlaverunOID_S
Int TollCostGoldOID_S
Int SlaverunFactorOID
Int SlaverunJobFactorOID
Int TollCostDevicesOID_S
Int TollCostTattoosOID_S
Int TollCostDrugsOID_S
Int MaxTatsBodyOID_S
Int MaxTatsFaceOID_S
Int MaxTatsHandsOID_S
Int MaxTatsFeetOID_S
Int TollFollowersOID_S
Int TollDodgeHuntFreqOID_S
Int TollDodgeMaxGuardsOID_S
Int TollDodgeDetectDistMaxOID_S
Int TollDodgeDetectDistTownMaxOID_S
Int TollDodgeDisguiseBodyPenaltyOID_S
Int TollDodgeDisguiseHeadPenaltyOID_S
Int TollDodgeCurrentSpotDist
Int TollDodgeCurrentSpotDistTown
Int TollDodgeItemValueModOID_S
Int TollDodgeGracePeriodOID_S

Int EnforcerRespawnDurOID_S
Int TradeRestrictBribeOID_S
Int LicUnlockCostOID_S
Int LicBlockChanceOID_S
Int LicFactionDiscountOID_S
Int LicShortDurOID_S
Int LicLongDurOID_S
Int LicWeapShortCostOID_S
Int LicWeapLongCostOID_S
Int LicWeapPerCostOID_S
Int LicMagicShortCostOID_S
Int LicMagicLongCostOID_S
Int LicMagicPerCostOID_S
Int LicArmorShortCostOID_S
Int LicArmorLongCostOID_S
Int LicArmorPerCostOID_S
Int LicBikiniEnableOID
Int LicBikiniCurseEnableOID
Int LicMagicEnableOID
Int LicMagicCursedDevicesOID
Int LicMagicChainCollarsOID
Int LicBikiniHeelHeightOID_S
Int LicBikiniShortCostOID_S
Int LicBikiniLongCostOID_S
Int LicBikiniPerCostOID_S
Int LicClothesShortCostOID_S
Int LicClothesLongCostOID_S
Int LicClothesPerCostOID_S
Int EnforcersMinOID_S
Int EnforcersMaxOID_S

Int RoadDistOID_S
Int StealXItemsOID_S

Int BegNumItemsOID_S
Int BegGoldOID_S
Int BegMwaCurseChanceOID_S
Int KennelSafeCellCostOID_S
Int KennelCreatureChanceOID_S
Int KennelRapeChancePerHourOID_S
Int KennelSlaveRapeTimeMinOID_S 
Int KennelSlaveRapeTimeMaxOID_S

Int BikiniExpPerLevelOID_S
Int BikiniExpTrainOID_S
Int BikiniExpUntrainOID_S

Int BikiniDropsVendorCityOID_S
Int BikiniDropsVendorTownOID_S
Int BikiniDropsVendorKhajiitOID_S
Int BikiniDropsChestOID_S
Int BikiniDropsChestOrnateOID_S

Int BikiniChanceHideOID_S
Int BikiniChanceLeatherOID_S
Int BikiniChanceIronOID_S
Int BikiniChanceSteelOID_S
Int BikiniChanceSteelPlateOID_S
Int BikiniChanceDwarvenOID_S
Int BikiniChanceFalmerOID_S
Int BikiniChanceWolfOID_S
Int BikiniChanceBladesOID_S
Int BikiniChanceEbonyOID_S
Int BikiniChanceDragonboneOID_S

; DialogBox
Int PushEventsDB
Int ProxSpankNpcDB
Int ProxSpankCoverDB
Int CumAddictAutoSuckStageDB
Int LicClothesEnableDB
Int BegSexAggDB
Int BegSexVictimDB
Int KennelSexAggDB
Int KennelSexVictimDB
Int CompassHideMethodDB
Int DevEffLockpickDiffDB
Int DevEffPickpocketDiffDB
Int TollSexAggDB
Int TollSexVictimDB
Int DismembermentsDB
Int DismemberProgressionDB
Int DismemberWeaponsDB
Int DismemberDepthMaxArmsDB
Int DismemberDepthMaxLegsDB
Int LicenceStyleDB
Int FollowerLicStyleDB
Int LicBuyBackPriceDB
Int LicEquipListDB
Int BikiniCurseAreaDB
Int MagicCurseAreaDB
Int SexExpCorruptionDB

; Menu Variables Begin =======================================================

Bool IsInMcm = false ; Set to true when the SLS Mcm is opened and set false when it's closed

Bool DoSlaverunInitOnClose = false
Bool DoToggleCatCalling = false
Bool HardcoreMode = false
Bool IsHardcoreLocked = false
Bool LicMagicChainCollars = false
Bool TradeRestrictions = true
Bool PpLootEnable = true
Bool DoToggleCumEffects = false
Bool DoPpLvlListbuildOnClose = false
Bool DoTogglePpFailHandle = false
Bool DoInequalityRefresh = false
Bool DoToggleBikiniExp = false
Bool DoToggleAnimalBreeding = false
Bool DoTogglePushEvents = false
Bool DoToggleHalfNakedCover = false
Bool DoToggleIneqStrongFemaleFollowers = false
Bool DoToggleSexExp = false
Bool DoToggleHeelsRequired = false
Bool DoToggleStashTracking = false
Bool DoStashAddRemoveException = false
Bool CumEffectsEnable = true
Bool BikiniExpT = true
Bool InequalitySkills = true
Bool InequalityBuySell = true
Bool IneqStrongFemaleFollowers = false
Bool TollFollowersHardcore = false
Bool Property CoverMyselfMechanics = true Auto Hidden
Bool AssSlappingEvents = true
Bool Property BellyScaleEnable = true Auto Hidden
Bool Property HalfNakedEnable = false Auto Hidden
Bool SleepDepriv = true
Bool SlaverunAutoStart = false
Bool DoDeviousEffectsChange = false
Bool DoToggleBondFurn = false
Bool Property TollDodging = true Auto Hidden
Bool DoTollDodgingToggle = false
Bool FolContraBlock = true
Bool PpFailHandle = true
Bool PpSleepNpcPerk = true
Bool DoToggleLicenceStyle = false
Bool DoToggleGuardComments = false
Bool DoToggleGuardBehavWeapDrawn = false
Bool DoToggleGuardBehavLockpick = false
Bool DoToggleGuardBehavArmorEquip = false
Bool DoToggleGuardBehavWeapEquip = false
Bool DoToggleGuardBehavDrugs = false
Bool GuardComments = true
Bool Property GuardBehavWeapDrawn = true Auto Hidden
Bool Property GuardBehavArmorEquip = false Auto Hidden
Bool Property GuardBehavWeapEquip = true Auto Hidden
Bool GuardBehavLockpicking = true
Bool GuardBehavDrugs = true
Bool DoToggleProxSpank = false
Bool DoToggleBarefootSpeed = false
Bool DoToggleCumAddiction = false
Bool DoToggleCoverMechanics = false
Bool DoToggleCumAddictAutoSuckCreature = false
Bool Property SnowberryEnable = false Auto Hidden
Bool DoToggleBellyInflation = false

Bool Property CumLactacidAll = false Auto Hidden
Bool Property CumLactacidAllPlayable = false Auto Hidden

Int ProxSpankNpcType = 1
Int TradeRestrictBribe = 50
Int SurvivalHorseCost = 6000

Float PpGoldLowChance = 60.0
Float PpGoldModerateChance = 20.0
Float PpGoldHighChance = 2.0

Int PpLootLootMin = 0
Int PpLootLootMax = 8
Float PpLootFoodChance = 25.0
Float PpLootGemsChance = 15.0
Float PpLootSoulgemsChance = 10.0
Float PpLootJewelryChance = 15.0
Float PpLootEnchJewelryChance = 5.0
Float PpLootPotionsChance = 10.0
Float PpLootKeysChance = 10.0
Float PpLootTomesChance = 5.0
Float PpLootCureChance = 5.0
Float GreetDist = 150.0

Int SelectedEquip = 0

Int BikiniDropsVendorCity = 30
Int BikiniDropsVendorTown = 16
Int BikiniDropsVendorKhajiit = 12
Int BikiniDropsChest = 6
Int BikiniDropsChestOrnate = 10

Float BikiniChanceHide = 10.0
Float BikiniChanceLeather = 10.0
Float BikiniChanceIron = 10.0
Float BikiniChanceSteel = 11.0
Float BikiniChanceSteelPlate = 8.0
Float BikiniChanceDwarven = 6.0
Float BikiniChanceFalmer = 6.0
Float BikiniChanceWolf = 6.0
Float BikiniChanceBlades = 2.0
Float BikiniChanceEbony = 1.0
Float BikiniChanceDragonbone = 0.5

Float Property IneqFemaleVendorGoldMult = 1.0 Auto Hidden
Float Property IneqStatsVal = 40.0 Auto Hidden
Float IneqHealthCushion = 20.0
Float IneqCarryVal = 150.0
Float IneqSpeedVal = 10.0
Float IneqDamageVal = 20.0
Float IneqDestVal = 20.0

Int Property AmpType = 2 Auto Hidden ; Off/Random/Hands first
Int Property AmpDepth = 2 Auto Hidden ; One level at a time/Max in one go/Random
Int Property MaxAmpDepthArms = 1 Auto Hidden
Int Property MaxAmpDepthLegs = 1 Auto Hidden
Int Property DismemberDamageThres = 3 Auto Hidden
Int Property DismemberWeapon = 0 Auto Hidden ; Twohanded/Everything except daggers & ranged/Everything
Int Property MaxAmpedLimbs = 2 Auto Hidden ; How many limbs can be amputated at any one time
Float Property DismemberChance = 90.0 Auto Hidden
Float Property DismemberArmorBonus = 5.0 Auto Hidden
Float Property DismemberCooldown = 0.1 Auto Hidden
Float Property DismemberHealthThres = 110.0 Auto Hidden

Int[] Property SlotMasks Auto Hidden

String[] SplashArray

String[] PushEventsType
String[] ClothesLicenceMethod
String[] HeavyBondageDifficulty
String[] SexAggressiveness
String[] SexPlayerIsVictim
String[] FollowerLicStyles
String[] CompassHideMethods

String[] EquipSlotStrings
Form[] EquipSlots

String[] AmputationTypes
String[] AmputationDepth
String[] MaxAmputationDepthArms
String[] MaxAmputationDepthLegs
String[] DismemberWeapons
String[] Property OverlayAreas Auto Hidden
String[] BuyBackPrices
String[] LicenceStyleList
String[] ProxSpankNpcList
String[] ProxSpankRequiredCoverList
String[] CumHungerStrings
String[] SexExpCreatureCorruption

; Properties ============================================================
Int Property FolGoldSteamAmount = 30 Auto Hidden
Int Property PpCrimeGold = 100 Auto Hidden
Int Property PpFailDrugCount = 2 Auto Hidden
Int Property AproTwoTrollHealAmount = 200 Auto Hidden
Int Property BondFurnMilkWill = 4 Auto Hidden
Int Property BondFurnWill = 2 Auto Hidden
Int Property SwimCumClean = 12 Auto Hidden
Int Property ConfiscationFine = 100 Auto Hidden
Int Property ConfiscationFineSlaverun = 200 Auto Hidden
Int Property TollSexAgg = 0 Auto Hidden
Int Property TollSexVictim = 0 Auto Hidden
Int Property MaxTatsBody = 6 Auto Hidden
Int Property MaxTatsFace = 3 Auto Hidden
Int Property MaxTatsHands = 0 Auto Hidden
Int Property MaxTatsFeet = 0 Auto Hidden
Int Property BegNumItems = 2 Auto Hidden
Int Property BegSexAgg = 0 Auto Hidden
Int Property BegSexVictim = 0 Auto Hidden
Int Property HalfNakedBra = 56 Auto Hidden
Int Property HalfNakedPanty = 49 Auto Hidden
Int Property SexExpCorruption = 0 Auto Hidden
Int Property TollDodgeMaxGuards = 6 Auto Hidden
Int Property BikiniCurseArea = 0 Auto Hidden
Int Property MagicCurseArea = 1 Auto Hidden
Int Property EnforcersMin = 2 Auto Hidden
Int Property BuyBackPrice = 2 Auto Hidden
Int Property EnforcersMax= 4 Auto Hidden
Int Property BegQuantity = 2 Auto Hidden
Int Property KennelSafeCellCost = 40 Auto Hidden
Int Property PushEvents = 0 Auto Hidden ; 0 - Off, 1 - Stagger, 2 - Paralysis, 3 - Both
Int Property DevEffLockpickDiff = 1 Auto Hidden
Int Property DevEffPickpocketDiff = 1 Auto Hidden
Int Property KennelSlaveRapeTimeMin = 10 Auto Hidden
Int Property KennelSlaveRapeTimeMax = 40 Auto Hidden
Int Property KennelSexAgg = 2 Auto Hidden
Int Property KennelSexVictim = 1 Auto Hidden
Int Property CumHungerAutoSuck = 2 Auto Hidden
Int Property CompassHideMethod = 0 Auto Hidden

Float Property FolGoldStealChance = 50.0 Auto Hidden
Float Property BarefootMag = 50.0 Auto Hidden
Float Property CatCallVol = 20.0 Auto Hidden
Float Property CatCallWillLoss = 1.0 Auto Hidden
Float Property SlaverunAutoMin = 2.0 Auto Hidden
Float Property SlaverunAutoMax = 14.0 Auto Hidden
Float Property AssSlapResistLoss = 1.0 Auto Hidden
Float Property ProxSpankCooloff = 10.0 Auto Hidden
Float Property CockSizeBonusEnjFreq = 3.0 Auto Hidden
Float Property RapeForcedSkoomaChance = 35.0 Auto Hidden
Float Property RapeMinArousal = 50.0 Auto Hidden
Float Property SexMinStaminaRate = 2.5 Auto Hidden
Float Property SexMinStaminaMult = 60.0 Auto Hidden
Float Property SexMinMagickaRate = 1.5 Auto Hidden
Float Property SexMinMagickaMult = 50.0 Auto Hidden
Float Property KennelRapeChancePerHour = 20.0 Auto Hidden
Float Property MinSpeedMult = 50.0 Auto Hidden
Float Property MinCarryWeight = 50.0 Auto Hidden
Float Property ReplaceMapsTimer = 180.0 Auto Hidden
Float Property GoldWeight = 0.01 Auto Hidden
Float Property GluttedSpeed = 10.0 Auto Hidden
Float Property SkoomaSleep = 1.0 Auto Hidden
Float Property MilkSleepMult = 1.0 Auto Hidden
Float Property DrugEndFatigueInc = 0.25 Auto Hidden
Float Property CumIsLactacid = 0.0 Auto Hidden
Float Property CumSwallowInflateMult = 1.0 Auto Hidden
Float Property CumEffectsMagMult = 1.0 Auto Hidden
Float Property CumEffectsDurMult = 1.0 Auto Hidden
Float Property CumpulsionChance = 25.0 Auto Hidden
Float Property CumRegenTime = 24.0 Auto Hidden
Float Property CumEffectVolThres = 85.0 Auto Hidden
Float Property SuccubusCumSwallowEnergyMult = 1.0 Auto Hidden
Float Property CumAddictionHungerRate = 0.1 Auto Hidden
Float Property CumAddictionSpeed = 1.0 Auto Hidden
Float Property CumAddictionDecayPerHour = 1.0 Auto Hidden
Float Property CumSatiation = 1.0 Auto Hidden
Float Property CumAddictBatheRefuseTime = 6.0 Auto Hidden
Float Property CumAddictAutoSuckCreature = 1.0 Auto Hidden
Float Property CumAddictAutoSuckCooldown = 6.0 Auto Hidden
Float Property CumAddictAutoSuckCreatureArousal = 70.0 Auto Hidden
Float Property CumAddictReflexSwallow = 1.0 Auto Hidden
Float Property DflowResistLoss = 5.0 Auto Hidden

Float Property DeviousGagDebuff = 80.0 Auto Hidden
Float Property BondFurnMilkFreq = 6.0 Auto Hidden
Float Property BondFurnMilkFatigueMult = 1.0 Auto Hidden
Float Property BondFurnFreq = 3.0 Auto Hidden
Float Property BondFurnFatigueMult = 1.0 Auto Hidden

Float Property KnockSlaveryChance = 3.0 Auto Hidden
Float Property SimpleSlaveryWeight = 50.0 Auto Hidden
Float Property SdWeight = 50.0 Auto Hidden

Float Property WarmBodies = -3.0 Auto Hidden
Float Property CumWetMult = 1.0 Auto Hidden
Float Property CumExposureMult = 1.0 Auto Hidden
Float Property MilkLeakWet = 50.0 Auto Hidden
Float Property SimpleSlaveryFF = 50.0 Auto Hidden
Float Property SdDreamFF = 50.0 Auto Hidden

Float Property EvictionLimit = 500.0 Auto Hidden
Float Property SlaverunEvictionLimit = 200.0 Auto Hidden
Float Property TollDodgeHuntFreq = 1.5 Auto Hidden
Float Property TollDodgeDisguiseBodyPenalty = 0.75 Auto Hidden
Float Property TollDodgeDisguiseHeadPenalty = 0.75 Auto Hidden
Float Property TollDodgeItemValueMod = 1.0 Auto Hidden
Float Property TollDodgeGracePeriod = 2.0 Auto Hidden
Float Property GuardSpotDistNom = 512.0 Auto Hidden
Float Property GuardSpotDistTown = 768.0 Auto Hidden
Float Property EnforcerRespawnDur = 7.0 Auto Hidden

Float Property LicBlockChance = 70.0 Auto Hidden

Float Property RoadDist = 8192.0 Auto Hidden
Float Property StealXItems = 25.0 Auto Hidden

Float Property BegGold = 1.0 Auto Hidden
Float Property BegMwaCurseChance = 50.0 Auto Hidden
Float Property KennelCreatureChance = 50.0 Auto Hidden

Float Property BikTrainingSpeed = 1.0 Auto Hidden
Float Property BikUntrainingSpeed = 0.5 Auto Hidden

Bool Property CumSwallowInflate = true Auto Hidden
Bool Property CumEffectsStack = true Auto Hidden
Bool Property SuccubusCumSwallowEnergyPerRank = true Auto Hidden
Bool Property CumAddictEn = true Auto Hidden
Bool Property CumAddictClampHunger = true Auto Hidden
Bool Property CumAddictBeastLevels = false Auto Hidden
Bool Property MilkDecCumBreath = false Auto Hidden
Bool Property DropItems = true Auto Hidden
Bool Property EasyBedTraps = true Auto Hidden
Bool Property AnimalBreedEnable = false Auto Hidden
Bool Property CumBreath = true Auto Hidden
Bool Property CumBreathNotify = true Auto Hidden
Bool Property FollowersStealGold = true Auto Hidden
Bool Property FastTravelDisable = true Auto Hidden
Bool Property FtDisableIsNormal = true Auto Hidden
Bool Property ReplaceMaps = true Auto Hidden
Bool Property CompassMechanics = true Auto Hidden
Bool Property MinAvToggleT = true Auto Hidden
Bool Property FfRescueEvents = true Auto Hidden
Bool Property DoorLockDownT = true Auto Hidden
Bool Property StashTrackEn = true Auto Hidden
Bool Property ContTypeCountsT = true Auto Hidden
Bool Property OrgasmRequired = true Auto Hidden
Bool Property SaltyCum = false Auto Hidden
Bool Property HalfNakedStrips = false Auto Hidden
Bool Property SexExpEn = true Auto Hidden
Bool Property DremoraCorruption = false Auto Hidden
Bool Property SexMinStamMagRates = true Auto Hidden
Bool Property RapeDrainsAttributes = true Auto Hidden
Bool Property CurfewEnable = true Auto Hidden
Bool Property DeviousEffectsEnable = false Auto Hidden
Bool Property DevEffNoGagTrading = false Auto Hidden
Bool Property BondFurnEnable = true Auto Hidden
Bool Property KennelFollowerToggle = true Auto Hidden
Bool Property DismemberTrollCum = true Auto Hidden
Bool Property DismemberBathing = true Auto Hidden
Bool Property DismemberPlayerSay = true Auto Hidden

Quest Property _SLS_AssSlapQuest Auto
Quest Property _SLS_BellyInflationQuest Auto

Quest Property _SLS_LicenceAliases Auto
Quest Property _SLS_MapAndCompassQuest Auto
Quest Property _SLS_SleepDeprivationQuest Auto
Quest Property _SLS_SlaverunKickerQuest Auto
Quest Property _SLS_HalfNakedCoverQuest Auto
Quest Property _SLS_DeviousEffectsQuest Auto
Quest Property _SLS_TollDodgeHuntQuest Auto
Quest Property _SLS_TollDodgeQuest Auto
Quest Property _SLS_LicenceTradersQuest Auto
Quest Property _SLS_LicFollowerEnforcementDumbQuest Auto
Quest Property _SLS_PickPocketFailDetectQuest Auto
Quest Property _SLS_LicTownCheckEnforcerAliases Auto
Quest Property _SLS_LicTownCheckPlayerAliasQuest Auto
Quest Property _SLS_LicTownCheckQuest Auto
Quest Property _SLS_AmputationQuest Auto
Quest Property _SLS_InequalityRefreshQuest Auto
Quest Property _SLS_BikiniExpTrainingQuest Auto
Quest Property _SLS_CumEffectsQuest Auto
Quest Property _SLS_AnimalFriendQuest Auto
Quest Property _SLS_AnimalFriendAliases Auto
Quest Property _SLS_DeviousFurnitureQuest Auto
Quest Property _SLS_LicenceBuyBlockerQuest Auto
Quest Property _SLS_CatCallsQuest Auto
Quest Property _SLS_GuardWarnLockpickQuest Auto
Quest Property _SLS_GuardWarnDrugsQuest Auto
Quest Property _SLS_GuardWarnArmorEquippedQuest Auto
Quest Property _SLS_GuardWarnArmorEquippedDetectQuest Auto
Quest Property _SLS_GuardWarnWeapEquippedQuest Auto
Quest Property _SLS_GuardWarnWeapEquippedDetectQuest Auto
Quest Property _SLS_GuardWarnWeapDrawnQuest Auto
Quest Property _SLS_GuardWarnWeapDrawnDetectionQuest Auto
Quest Property _SLS_GuardHellosQuest Auto
Quest Property _SLS_HelloSpankAnythingQuest Auto
Quest Property _SLS_HelloSpankGuardsQuest Auto
Quest Property _SLS_HelloSpankGuardsAndMenQuest Auto
Quest Property _SLS_HelloSpankMenQuest Auto
Quest Property _SLS_HelloSpankWomenQuest Auto
Quest Property _SLS_CoverMySelfQuest Auto
Quest Property _SLS_CumAddictAutoSuckCreatureQuest Auto
Quest Property _SLS_SexExperienceQuest Auto
Quest Property _SLS_SexCockSizeQuest Auto
Quest Property _SLS_StashTrack Auto
Quest Property _SLS_StashAddExceptionQuest Auto
Quest Property _SLS_FindEscortsQuest Auto
Quest Property _SLS_LicenceQuest Auto
Quest Property _SLS_LicenceSnowberryQuest Auto

Quest Property CW01A Auto
Quest Property CW01B Auto
Quest Property Stables Auto
Quest Property MQ101 Auto

Actor Property PlayerRef Auto

Faction Property PotentialFollowerFaction Auto
Faction Property PotentialHireling Auto
Faction Property CollegeofWinterholdFaction Auto
Faction Property CompanionsFaction Auto
Faction Property _SLS_IneqStrongFemaleFact Auto

ObjectReference Property _SLS_LicenceGateActJkRef Auto
ObjectReference Property _SLS_LicenceDumpRef Auto

Spell Property _SLS_MagicLicenceCurse Auto
Spell Property _SLS_InequalitySpell Auto
Spell Property _SLS_BikiniExpSpell Auto
Spell Property _SLS_DebugGetActorPackSpell Auto
Spell Property _SLS_DebugGetActorVoiceTypeSpell Auto
Spell Property _SLS_WeaponReadySpell Auto
Spell Property _SLS_CumAddictHungerSpell Auto
Spell Property _SLS_CumAddictStatusSpell Auto
Spell Property _SLS_LicInspLostSightSpell Auto

MagicEffect Property _SLS_MagicLicenceCollarMgef Auto
MagicEffect Property _SLS_LicBikiniCurseInactiveMgef Auto
MagicEffect Property _SLS_LicBikiniCurseStamina Auto

Perk Property _SLS_CreatureTalk Auto
Perk Property _SLS_IncPickpocketLootPerk Auto
Perk Property _SLS_PickpocketSleepBonusPerk Auto
Perk Property _SLS_InequalityBuySellPerk Auto
Perk Property _SLS_InequalitySkillsPerk Auto
Perk Property _SLS_BikiniExpPerk Auto

Formlist Property _SLS_LicenceGateActList Auto
Formlist Property _SLS_TraderListExceptions Auto
Formlist Property _SLS_TraderListAll Auto
Formlist Property _SLS_TraderBaseListAll Auto
Formlist Property _SLS_TraderListFalkreath Auto
Formlist Property _SLS_TraderListMarkarth Auto
Formlist Property _SLS_TraderListMorthal Auto
Formlist Property _SLS_TraderListRavenRock Auto
Formlist Property _SLS_TraderListRiften Auto
Formlist Property _SLS_TraderListRiverwood Auto
Formlist Property _SLS_TraderListSolitude Auto
Formlist Property _SLS_TraderListWhiterun Auto
Formlist Property _SLS_TraderListWindhelm Auto
Formlist Property _SLS_TraderListWinterhold Auto
Formlist Property _SLS_TraderListDawnstar Auto
Formlist Property _SLS_EscortsList Auto
Formlist Property _SLS_QuestItems Auto
Formlist Property _SLS_FondleableVoices Auto
Formlist Property _SLS_LocsWhiterun Auto
Formlist Property _SLS_LocsSolitude Auto
Formlist Property _SLS_LocsMarkarth Auto
Formlist Property _SLS_LocsWindhelm Auto
Formlist Property _SLS_LocsRiften Auto
Formlist Property _SLS_LicExceptionsWeapon Auto
Formlist Property _SLS_LicExceptionsArmor Auto
Formlist Property _SLS_CumHasLactacidVoices Auto
Formlist Property _SLS_StaticMapList Auto
Formlist Property _SLS_ActivatableMapList Auto
Formlist Property _SLS_EscortsVanilla Auto
Formlist Property _SLS_EscortsBaseList Auto
Formlist Property _SLS_CumLactacidVoicesList Auto

GlobalVariable Property _SLS_TollCost Auto
GlobalVariable Property _SLS_TollFollowersRequired Auto
GlobalVariable Property _SLS_KennelCellCost Auto
GlobalVariable Property _SLS_LicCostShort Auto
GlobalVariable Property _SLS_LicCostLong Auto
GlobalVariable Property _SLS_LicCostPer Auto
GlobalVariable Property _SLS_BeggingDialogT Auto
GlobalVariable Property _SLS_TollDodgeHuntRadius Auto
GlobalVariable Property _SLS_TollDodgeHuntRadiusTown Auto
GlobalVariable Property _SLS_RestrictTradeBribe Auto
GlobalVariable Property _SLS_PickPocketFailStealValue Auto
GlobalVariable Property _SLS_BegSelfDegradationEnable Auto
GlobalVariable Property _SLS_ResponsiveEnforcers Auto
GlobalVariable Property _SLS_KennelExtraDevices Auto
GlobalVariable Property _SLS_AmpPriestHealCost Auto
GlobalVariable Property _SLS_BikiniExpReflexes Auto
GlobalVariable Property _SLS_BikiniExpLevel Auto
GlobalVariable Property _SLS_GuardBehavShoutEn Auto
GlobalVariable Property _SLS_GuardBehavWeapDropEn Auto
GlobalVariable Property _SLS_ProxSpankRequiredCover Auto
GlobalVariable Property _SLS_CumAddictionPool Auto
GlobalVariable Property _SLS_CumAddictionHunger Auto
GlobalVariable Property _SLS_CumHunger0 Auto ; < Satisfied
GlobalVariable Property _SLS_CumHunger1 Auto ; < Peckish
GlobalVariable Property _SLS_CumHunger2 Auto ; < Hungry
GlobalVariable Property _SLS_CumHunger3 Auto ; < Starving, >= Ravenous
GlobalVariable Property _SLS_CoveringNakedStatus Auto
GlobalVariable Property _SLS_BodyCoverStatus Auto
GlobalVariable Property _SLS_LicUnlockCost Auto
GlobalVariable Property _SLS_LicInspPersistence Auto
GlobalVariable Property _SLS_MapAndCompassRecipeEnable Auto

GlobalVariable Property _SLS_IneqCarry Auto
GlobalVariable Property _SLS_IneqDamage Auto
GlobalVariable Property _SLS_IneqDestruction Auto
GlobalVariable Property _SLS_IneqSpeed Auto
GlobalVariable Property _SLS_IneqStat Auto
GlobalVariable Property _SLS_IneqDebuffPlusCushion Auto

GlobalVariable Property HorseCost Auto

MiscObject Property Gold001 Auto

Message Property _SLS_TradeRestrictSetMerchant Auto
Message Property _SLS_GetLocationJurisdiction Auto
Message Property _SLS_AddEscortsMsg Auto

ReferenceAlias Property _SLS_TollGateWhiterunInside Auto
ReferenceAlias Property _SLS_TollGateSolitudeInside Auto
ReferenceAlias Property _SLS_TollGateRiftenMainInside Auto
ReferenceAlias Property _SLS_TollGateWindhelmInterior Auto
ReferenceAlias Property _SLS_TollGateMarkarthInterior Auto

Location Property _SLS_KennelWhiterunLocation Auto

Keyword Property SexlabNoStrip Auto

LeveledItem Property _SLS_PpLootRootList Auto
LeveledItem Property _SLS_PpGoldRoot Auto
LeveledItem Property _SLS_PpLootEmptyList Auto

LeveledItem Property _SLS_PpLootFoodList Auto
LeveledItem Property _SLS_PpLootGemsList Auto
LeveledItem Property _SLS_PpLootSoulgemsList Auto
LeveledItem Property _SLS_PpLootJewelryList Auto
LeveledItem Property _SLS_PpLootEnchJewelryList Auto
LeveledItem Property _SLS_PpLootPotionsList Auto
LeveledItem Property _SLS_PpLootKeysList Auto
LeveledItem Property _SLS_PpLootTomesList Auto
Potion Property CureDisease Auto

LeveledItem Property _SLS_PpGoldLow Auto
LeveledItem Property _SLS_PpGoldModerate Auto
LeveledItem Property _SLS_PpGoldHigh Auto

LeveledItem Property _SLS_BikiniArmorsListHide Auto
LeveledItem Property _SLS_BikiniArmorsListLeather Auto
LeveledItem Property _SLS_BikiniArmorsListIron Auto
LeveledItem Property _SLS_BikiniArmorsListSteel Auto
LeveledItem Property _SLS_BikiniArmorsListSteelPlate Auto
LeveledItem Property _SLS_BikiniArmorsListDwarven Auto
LeveledItem Property _SLS_BikiniArmorsListFalmer Auto
LeveledItem Property _SLS_BikiniArmorsListWolf Auto
LeveledItem Property _SLS_BikiniArmorsListBlades Auto
LeveledItem Property _SLS_BikiniArmorsListEbony Auto
LeveledItem Property _SLS_BikiniArmorsListDragonbone Auto

LeveledItem Property _SLS_BikiniArmorsEntryPointChest Auto
LeveledItem Property _SLS_BikiniArmorsEntryPointChestOrnate Auto
LeveledItem Property _SLS_BikiniArmorsEntryPointVendorCity Auto
LeveledItem Property _SLS_BikiniArmorsEntryPointVendorTown Auto
LeveledItem Property _SLS_BikiniArmorsEntryPointVendorKhajiit Auto

LeveledItem Property _SLS_BikiniArmorsList Auto

Form Property BikiniCurseTriggerArmor Auto Hidden

;/
VoiceType Property CrBearVoice Auto
VoiceType Property CrChaurusVoice Auto
VoiceType Property CrDeerVoice Auto
VoiceType Property CrDogVoice Auto
VoiceType Property CrDragonPriestVoice Auto
VoiceType Property CrDragonVoice Auto
VoiceType Property CrDraugrVoice Auto
VoiceType Property CrDremoraVoice Auto
VoiceType Property CrDwarvenCenturionVoice Auto
VoiceType Property CrDwarvenSphereVoice Auto
VoiceType Property CrDwarvenSpiderVoice Auto
VoiceType Property CrFalmerVoice Auto
VoiceType Property CrFoxVoice Auto
VoiceType Property CrFrostbiteSpiderGiantVoice Auto
VoiceType Property CrFrostbiteSpiderVoice Auto
VoiceType Property CrGiantVoice Auto
VoiceType Property CrGoatVoice Auto
VoiceType Property CrHorkerVoice Auto
VoiceType Property CrHorseVoice Auto
VoiceType Property CrMammothVoice Auto
VoiceType Property CrSabreCatVoice Auto
VoiceType Property CrSkeeverVoice Auto
VoiceType Property CrSprigganVoice Auto
VoiceType Property CrTrollVoice Auto
VoiceType Property CrWerewolfVoice Auto
VoiceType Property CrWolfVoice Auto
/;
SLS_Init Property Init Auto
SLS_Main Property Main Auto
SLS_MinAv Property MinAv Auto
SLS_Utility Property Util Auto
SLS_GluttonyInflationScript Property Gluttony Auto
_SLS_Needs Property Needs Auto
_SLS_LicenceUtil Property LicUtil Auto
_SLS_MapAndCompassAlias Property Compass Auto
_SLS_HalfNakedCover Property HalfNakedCover Auto
_SLS_DeviousEffects Property DeviousEffects Auto
_SLS_TollDodgeDisguise Property DodgeDisguise Auto
_SLS_TollDodge Property TollDodge Auto
_SLS_AnimalFriend Property AnimalFriend Auto
_SLS_Amputation Property Amputation Auto
_SLS_BikiniExpTraining Property BikiniExp Auto
_SLS_LicBikiniCurse Property BikiniCurse Auto
SLS_EvictionTrack Property Eviction Auto
_SLS_LicenceBuyBlocker Property LicBuyBlocker Auto
_SLS_DeviousEffectsGagTrade Property GagTrade Auto
_SLS_CumAddict Property CumAddict Auto
_SLS_CoverMyself Property CoverMyself Auto
_SLS_CumSwallow Property CumSwallow Auto
SLS_StashTrackPlayer Property StashTrack Auto
_SLS_MapAndCompassAlias Property MapAndCompass Auto
_SLS_AllInOneKey Property AllInOne Auto
_SLS_ForcedDrugging Property ForceDrug Auto
_SLS_FashionRape Property FashionRape Auto
_SLS_TollUtil Property TollUtil Auto
_SLS_LocTrackCentral Property LocTrack Auto
_SLS_Trauma Property Trauma Auto
_SLS_SteepFall Property SteepFall Auto

_SLS_InterfaceRnd Property Rnd Auto
_SLS_InterfaceIneed Property Ineed Auto
_SLS_InterfaceFrostfall Property Frostfall Auto
_SLS_InterfaceSlaverun Property Slaverun Auto
_SLS_InterfacePaySexCrime Property Psc Auto
_SLS_InterfaceDevious Property Devious Auto
_SLS_InterfaceEff Property Eff Auto
_SLS_InterfaceSgo Property Sgo Auto
_SLS_InterfaceFhu Property Fhu Auto
_SLS_InterfaceAmputation Property Amp Auto
_SLS_InterfaceAproposTwo Property AproposTwo Auto
_SLS_InterfaceSlavetats Property Tats Auto
_SLS_InterfaceMilkAddict Property MilkAddict Auto
_SLS_InterfaceSlax Property Sla Auto
_SLS_InterfaceDeviousFollowers Property Dflow Auto
_SLS_InterfaceSlsf Property Slsf Auto
_SLS_InterfaceSlso Property Slso Auto
_SLS_InterfaceEatSleepDrink Property EatSleepDrink Auto
_SLS_InterfaceSpankThatAss Property Sta Auto
_SLS_InterfaceBis Property Bis Auto
_SLS_InterfaceSexyMove Property SexyMove Auto

CWScript Property Cw Auto
