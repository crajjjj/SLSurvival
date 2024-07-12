Scriptname slaConfigScr extends SKI_ConfigBase  

; FOLDSTART - Properties
Keyword Property kArmorCuirass Auto
Keyword Property kClothingBody Auto

slaInternalScr Property slaUtil Auto
Int[] Property slaSlotMaskValues Auto Hidden
Actor Property slaPuppetActor Auto

Actor Property slaNakedActor Auto Hidden
Actor Property slaMostArousedActorInLocation Auto Hidden
Int Property slaArousalOfMostArousedActorInLoc Auto

ReferenceAlias Property follower Auto

Bool Property isCloakEffect Auto
Bool Property isDesireSpell Auto
Bool Property isUseSOS Auto
Bool Property isExtendedNPCNaked Auto
Bool Property wantsPurging = false Auto Hidden
Float Property TimeRateHalfLife = 2.0 Auto Hidden
Int Property MinimumTimeRate = 0 Auto Hidden
Int Property Fatigue = 40 Auto Hidden
Int Property FatigueMaleBonus = 60 Auto Hidden
Bool Property MBonUsesSLGender = True Auto Hidden
Float Property FatigueHalfLife = 0.5 Auto Hidden
Int Property Frustration = 5 Auto Hidden
Int Property LewdMod = 0 Auto Hidden
Float Property FrustrationHalfLife = 1.0 Auto Hidden
Float Property FrustrationGrowth = 0.5 Auto Hidden
Int Property FrustrationGrowthThreshold = 90 Auto Hidden
Int Property FrustrationLoss = 100 Auto Hidden
Int Property Trauma = 100 Auto Hidden
Int Property MinStartArousal = 25 Auto Hidden
Int Property MinRapeStartArousal = 50 Auto Hidden
Int Property Masochism = 5 Auto Hidden
Float Property MasochismHalfLife = 2.0 Auto Hidden
Int Property Exhibitionism = 5 Auto Hidden
Int Property ExhibitionismAdditional = 2 Auto Hidden
Float Property ExhibitionismCooldown = 120.0 Auto Hidden
Float Property ExhibitionismHalfLife = 2.0 Auto Hidden
Int Property ExhibitionismThreshold = 50 Auto Hidden
Float Property TraumaHalfLife Auto Hidden
Float Property MinDaysWithoutSex = 0.0 Auto Hidden
Int Property sexOveruseEffect = 5 Auto Hidden
Float Property defaultExposureRate = 2.0 Auto Hidden
Float Property ExposureHalfLife = 2.0 Auto Hidden
Int Property notificationKey = 49 Auto Hidden
Float Property cellScanFreq = 120.00 Auto Hidden
bool Property maleAnimation = false Auto Hidden
bool Property femaleAnimation = false Auto Hidden
bool Property useLOS = false Auto Hidden
Bool Property isNakedOnly = true Auto Hidden
Bool Property bDisabled = false Auto Hidden


; FOLDEND - Properties


; FOLDSTART - Keys
String keyNakedArmor
String keyBikiniArmor
String keySexyArmor
String keySlootyArmor
String keyIllegalArmor
String keyPoshArmor
String keyRaggedArmor
String keyKillerHeels
String[] pageKeys
; FOLDEND - Keys

; FOLDSTART - Keywords
Keyword wordNakedArmor
Keyword wordBikiniArmor
Keyword wordSexyArmor
Keyword wordSlootyArmor
Keyword wordIllegalArmor
Keyword wordPoshArmor
Keyword wordRaggedArmor
Keyword wordKillerHeels
; FOLDEND - Keywords


; FOLDSTART - Variables
String pageName
Int pageId

Bool statusNotSplash
Bool sliderMode

Int targetActorIndex
String[] targetActorNames
Actor[] targetActors

Actor puppetActor
Int puppetActorIndex
String[] puppetActorNames
Actor[] puppetActors

Armor bodyItem
Armor footItem
Int nakedArmorValue
Int bikiniArmorValue
Int sexyArmorValue
Int slootyArmorValue
Int illegalArmorValue
Int poshArmorValue
Int raggedArmorValue
Int killerHeelsValue

Form[] bikiniArmors ; May not really be bikini armors, but that's what I'm trying to locate.
Int[] bikiniSliderValues
; FOLDEND - Variables

; FOLDSTART - OIDs
Int useSOSOID
Int cloakEffectOID
Int desireSpellOID
Int exbitionistOID
Int extendedNPCNakedOID
Int blockArousalOID
Int lockArousalOID
Int timeRateHalfLifeOID
Int MinimumTimeRateOID
Int FatigueOID
Int FatigueHalfLifeOID
Int FatigueMaleBonusOID
Int MBonUsesSLGenderOID
Int FrustrationOID
Int LewdModOID
Int FrustrationHalfLifeOID
Int FrustrationGrowthOID
Int FrustrationGrowthThresholdOID
Int FrustrationLossOID
Int TraumaOID
Int MinStartArousalOID
Int MinRapeStartArousalOID
Int MasochismOID
Int MasochismHalfLifeOID
Int ExhibitionismOID
Int ExhibitionismAdditionalOID
Int ExhibitionismCooldownOID
Int ExhibitionismHalfLifeOID
Int ExhibitionismThresholdOID
Int TraumaHalfLifeOID
Int MinDaysWithoutSexOID
Int ExposureHalfLifeOID
Int setExposureOID
Int defaultExposureRateOID
Int arousalExposureRateOID
Int notificationKeyOID
Int genderPreferenceOID
Int setTimeRateOID
Int sexOveruseEffectOID
int cellScanFreqOID
int wantsPurgingOID
int maleAnimationOID
int femaleAnimationOID
int useLOSOID
int nakedOnlyOID
int bDisabledOID
Int[] currentArmorListOID
Int targetActorMenuOID
Int statusNotSplashOID
Int puppetActorMenuOID

Int sliderModeOID
Int bodyItemOID
Int noBodyItemOID
Int footItemOID
Int noFootItemOID
Int heelsSliderOID
Int heelsToggleOID

Int nakedSliderOID
Int bikiniSliderOID
Int sexySliderOID
Int slootySliderOID
Int illegalSliderOID
Int poshSliderOID
Int raggedSliderOID
Int[] bikiniSliderOIDs

Int nakedToggleOID
Int bikiniToggleOID
Int sexyToggleOID
Int slootyToggleOID
Int illegalToggleOID
Int poshToggleOID
Int raggedToggleOID
Int[] bikiniToggleOIDs
; FOLDEND - OIDs


; FOLDSTART - Quasi constants
slaMainScr slaMain 
Actor player
String[] genderPreferenceList
Form[] emptyFormArray
Armor[] emptyArmorArray
; FOLDEND - Quasi constants


Int Function GetVersion()
	return 29
EndFunction


Event OnVersionUpdate(int newVersion)

    ResetConstants()
    
	If (((newVersion >= 7) && (CurrentVersion < 7)) || (Pages.length < 4))
		Debug.Trace(self + ": Updating MCM menus to version " + newVersion)

		InitSlotMaskValues()
	EndIf
    
	If((CurrentVersion > 0) && (CurrentVersion < 28))
    
		Debug.Notification("Updating Aroused Redux to version " + GetVersion() + "...")
		sla_ConfigHelper helper = Quest.getQuest("sla_ConfigHelper") As sla_ConfigHelper
		helper.ResetAllQuests()
        
	Endif
    
EndEvent


Event OnGameReload()

    slax.Info("SLAX - OnGameReload")
    
    ResetConstants()

    RestoreKeywords(keyNakedArmor,   wordNakedArmor)
    RestoreKeywords(keyBikiniArmor,  wordBikiniArmor)
    RestoreKeywords(keySexyArmor,    wordSexyArmor)
    RestoreKeywords(keySlootyArmor,  wordSlootyArmor)
    RestoreKeywords(keyIllegalArmor, wordIllegalArmor)
    RestoreKeywords(keyPoshArmor,    wordPoshArmor)
    RestoreKeywords(keyRaggedArmor,  wordRaggedArmor)
    RestoreKeywords(keyKillerHeels,  wordKillerHeels)
    
	slaMain = Quest.GetQuest("sla_Main") As slaMainScr
	slaMain.Maintenance()
    
    parent.OnGameReload() ; Don't forget to call the parent!

EndEvent


Function ResetToDefault()

    ResetConstants()
    
	slaUtil = Quest.GetQuest("sla_Internal") As slaInternalScr
	slaPuppetActor = player
	slaNakedActor = None
	slaMostArousedActorInLocation = None
	slaArousalOfMostArousedActorInLoc = 0
	isCloakEffect = True
	isDesireSpell = True
	isUseSOS = False
	isExtendedNPCNaked = False
	timeRateHalfLife = 2.0
    MinimumTimeRate = 0
    Fatigue = 40
    FatigueHalfLife = 0.5
    FatigueMaleBonus = 60
    MBonUsesSLGender = True
    Frustration = 5
    LewdMod = 0
    FrustrationHalfLife = 1.0
    FrustrationGrowth = 0.5
    FrustrationGrowthThreshold = 90
    FrustrationLoss = 100
    Trauma = 100
    MinStartArousal = 25
    MinRapeStartArousal = 50
    Masochism = 5
    MasochismHalfLife = 2.0
    Exhibitionism = 5
    ExhibitionismAdditional = 2
    ExhibitionismCooldown = 120
    ExhibitionismHalfLife = 2
    ExhibitionismThreshold = 50
    TraumaHalfLife = 2.0
    MinDaysWithoutSex = 0.0
    ExposureHalfLife = 2.0
	sexOveruseEffect = 5
	defaultExposureRate = 2.0
	notificationKey = 49
	cellScanFreq = 120
    
    sliderMode = False
    statusNotSplash = False

	InitSlotMaskValues()
    
EndFunction


Event OnConfigOpen()
    
    slaMain = Quest.GetQuest("sla_Main") As slaMainScr
    cellScanFreq = slaMain.updateFrequency
    If(cellScanFreq < 10)
        cellScanFreq = 120
    Endif

    
    targetActorIndex = 0
    targetActors = new Actor[1]
    targetActorNames = new String[1]
    targetActors[0] = player
    targetActorNames[0] = "PLAYER"
    
    
    puppetActorIndex = 0
    puppetActors = new Actor[1]
    puppetActorNames = new String[1]
    puppetActors[0] = player
    puppetActorNames[0] = "PLAYER"
    puppetActor = player
    
    If follower
        Actor followerActor = follower.GetReference() As Actor
        If followerActor
            String followerName = followerActor.GetLeveledActorBase().GetName()
            
            targetActors = PapyrusUtil.PushActor(targetActors, followerActor)
            targetActorNames = PapyrusUtil.PushString(targetActorNames, followerName)
            puppetActors = PapyrusUtil.PushActor(puppetActors, followerActor)
            puppetActorNames = PapyrusUtil.PushString(puppetActorNames, followerName)
        EndIf
    EndIf
    
    If slaPuppetActor && slaPuppetActor != player
        String puppetName = slaPuppetActor.GetLeveledActorBase().GetName()
        targetActors = PapyrusUtil.PushActor(targetActors, slaPuppetActor)
        targetActorNames = PapyrusUtil.PushString(targetActorNames, "PUPPET: " + puppetName)
        puppetActors = PapyrusUtil.PushActor(puppetActors, slaPuppetActor)
        puppetActorNames = PapyrusUtil.PushString(puppetActorNames, puppetName)
        puppetActor = slaPuppetActor
    EndIf
    
    If slaMostArousedActorInLocation && targetActors.Find(slaMostArousedActorInLocation) < 0
        String arousedName = slaMostArousedActorInLocation.GetLeveledActorBase().GetName()
        targetActors = PapyrusUtil.PushActor(targetActors, slaMostArousedActorInLocation)
        targetActorNames = PapyrusUtil.PushString(targetActorNames, "AROUSED: " + arousedName)
        puppetActors = PapyrusUtil.PushActor(puppetActors, slaMostArousedActorInLocation)
        puppetActorNames = PapyrusUtil.PushString(puppetActorNames, arousedName)
    EndIf

    ; Add follower if present
    ; TODO
    
    
    ; Add other SLA aliases
    ; TODO
    
    
    GetBikiniArmorsForTargetActor(targetActors[targetActorIndex])

EndEvent


Event OnConfigClose()

    slax.Info("SLAX - OnConfigClose - update spells and key registry")
    
	slaUtil.slaMain.UpdateDesireSpell()
	slaUtil.slaMain.UpdateCloakEffect()
	slaUtil.slaMain.UpdateKeyRegistery()

    slaMain.updateFrequency = cellScanFreq
	slaUtil.slaMain.setUpdateFrequency(cellScanFreq)
    
EndEvent


Event OnPageReset(String page)

    pageName = page
	; Load custom logo in DDS format
	If page == "" && !statusNotSplash
    
		Int xOffset = 376 - (284 / 2)
		LoadCustomContent("sexlabaroused.dds", xOffset, 0)
		Return
        
	Else
		UnloadCustomContent()
	EndIf
	
	If "$SLA_Settings" == page
        pageId = 0 ; Main
        
		SetCursorFillMode(TOP_TO_BOTTOM)

		AddTextOption("$SLA_Version" , "" + GetVersion() + "(" + slaUtil.GetVersion() + ")", OPTION_FLAG_DISABLED)
        
		AddHeaderOption("$SLA_General")
        
		notificationKeyOID = AddKeyMapOption("$SLA_StatusKey", notificationKey)
		desireSpellOID = AddToggleOption("$SLA_EnableDesire", isDesireSpell)
		wantsPurgingOID = AddToggleOption("$SLA_WantsPurging", wantsPurging)
		maleAnimationOID = AddToggleOption("$SLA_EnableMaleAnimation", maleAnimation)
		femaleAnimationOID = AddToggleOption("$SLA_EnableFemaleAnimation", femaleAnimation)
		useLOSOID = AddToggleOption("$SLA_UseLOS", useLOS)
		nakedOnlyOID = AddToggleOption("$SLA_IsNakedOnly", isNakedOnly)
		bDisabledOID = AddToggleOption("$SLA_Disabled", bDisabled)
		extendedNPCNakedOID = AddToggleOption("$SLA_ExtendedNPCNaked", isExtendedNPCNaked)
		useSOSOID = AddToggleOption("$SLA_EnableSOS", isUseSOS)
        statusNotSplashOID = AddToggleOption("$SLA_StatusNotSplash", statusNotSplash)
		
		SetCursorPosition(3) ; Move cursor to top right position (almost)
		AddHeaderOption("$SLA_Arousal")
        
		defaultExposureRateOID = AddSliderOption("$SLA_DefaultExposureRate", defaultExposureRate, "{1}")
        ExposureHalfLifeOID = AddSliderOption("$SLA_ExposureHalfLife", ExposureHalfLife, "{1}")
        MinimumTimeRateOID = AddSliderOption("$SLA_MinimumTimeRate", MinimumTimeRate, "{1}")
        sexOveruseEffectOID = AddSliderOption("$SLA_SexOverUseEffect", sexOveruseEffect, "{0}")
		timeRateHalfLifeOID = AddSliderOption("$SLA_TimeRateHalfLife", timeRateHalfLife, "{1}")
		MinStartArousalOID = AddSliderOption("$SLA_MinStartArousal", MinStartArousal, "{0}")
		MinRapeStartArousalOID = AddSliderOption("$SLA_MinRapeStartArousal", MinRapeStartArousal, "{0}")
        FatigueOID = AddSliderOption("$SLA_Fatigue", Fatigue, "{0}")
        FatigueMaleBonusOID = AddSliderOption("$SLA_FatigueMaleBonus", FatigueMaleBonus, "{0}")
        MBonUsesSLGenderOID = AddToggleOption("$SLA_MBonUsesSLGender", MBonUsesSLGender)
        FatigueHalfLifeOID = AddSliderOption("$SLA_FatigueHalfLife", FatigueHalfLife, "{1}")
        FrustrationOID = AddSliderOption("$SLA_Frustration", Frustration, "{0}")
        FrustrationHalfLifeOID = AddSliderOption("$SLA_FrustrationHalfLife", FrustrationHalfLife, "{1}")
        FrustrationGrowthOID = AddSliderOption("$SLA_FrustrationGrowth", FrustrationGrowth, "{1}")
        FrustrationGrowthThresholdOID = AddSliderOption("$SLA_FrustrationGrowthThreshold", FrustrationGrowthThreshold, "{0}")
        FrustrationLossOID = AddSliderOption("$SLA_FrustrationLoss", FrustrationLoss, "{0}")
        TraumaOID = AddSliderOption("$SLA_Trauma", Trauma, "{0}")
        TraumaHalfLifeOID = AddSliderOption("$SLA_TraumaHalfLife", TraumaHalfLife, "{1}")
        MasochismOID = AddSliderOption("$SLA_Masochism", Masochism, "{0}")
        MasochismHalfLifeOID = AddSliderOption("$SLA_MasochismHalfLife", MasochismHalfLife, "{1}")
        ExhibitionismOID = AddSliderOption("$SLA_Exhibitionism", Exhibitionism, "{0} seconds")
        ExhibitionismAdditionalOID = AddSliderOption("$SLA_ExhibitionismAdditional", ExhibitionismAdditional, "{0}")
        ExhibitionismCooldownOID = AddSliderOption("$SLA_ExhibitionismCooldown", ExhibitionismCooldown, "{0}")
        ExhibitionismHalfLifeOID = AddSliderOption("$SLA_ExhibitionismHalfLife", ExhibitionismHalfLife, "{0}")
        ExhibitionismThresholdOID = AddSliderOption("$SLA_ExhibitionismThreshold", ExhibitionismThreshold, "{0}")
        If Game.GetModByName("SLSO.esp") == 255
            LewdModOID = AddSliderOption("$SLA_LewdMod", LewdMod, "{0}")
        Else
            LewdMod = JsonUtil.GetIntValue("/SLSO/Config", "sl_sla_orgasmexposuremodifier")
            LewdModOID = AddSliderOption("$SLA_LewdMod", LewdMod, "{0}", OPTION_FLAG_DISABLED)
        EndIf
        MinDaysWithoutSexOID = AddSliderOption("$SLA_MinDaysWithoutSex", MinDaysWithoutSex, "{1}")
		cellScanFreqOID = AddSliderOption("$SLA_CellScanFreq", cellScanFreq, "{0}")
        
	ElseIf "$SLA_Status" == page || (statusNotSplash && "" == page)
        pageId = 1 ; Status
        DisplayStatus()
		
	ElseIf "$SLA_PuppetMaster" == page
        pageId = 2 ; Puppet Master
		DisplayPuppetMaster()

	ElseIf "$SLA_CurrentArmorList" == page
        pageId = 3
        DisplayArmorList()
        
	EndIf
    
EndEvent


; If this returns None, there is no secondary target.
Actor Function GetSecondaryTargetActor()

    If puppetActor && puppetActor != player
        Return puppetActor
    EndIf
    
    If slaMostArousedActorInLocation
        Return slaMostArousedActorInLocation
    EndIf
    
    Return player

EndFunction


Function DisplayStatus()

    SetCursorFillMode(TOP_TO_BOTTOM)
    
    AddTextOption("$SLA_PlayerStatus", "", OPTION_FLAG_DISABLED)
    DisplayActorStatus(player)
    
    SetCursorPosition(1) ; Move cursor to top right position
    Actor secondaryTarget = GetSecondaryTargetActor()
    
    If secondaryTarget && secondaryTarget != player
        ; TODO - replace this with a drop-down to select status target
        AddTextOption("$SLA_NpcStatus", "", OPTION_FLAG_DISABLED)
        DisplayActorStatus(secondaryTarget)
    EndIf

EndFunction


Function DisplayActorStatus(Actor who)

	AddHeaderOption(who.GetLeveledActorBase().GetName())
	
	AddTextOption("$SLA_ArousalLevel", slaUtil.GetActorArousal(who), OPTION_FLAG_DISABLED)
	AddTextOption("$SLA_Exposure", slaUtil.GetActorExposure(who), OPTION_FLAG_DISABLED)
	AddTextOption("$SLA_ExposureRate", slaUtil.GetActorExposureRate(who), OPTION_FLAG_DISABLED)
	
	Float timeRate = slaUtil.GetActorTimeRate(who)
	Float timeSinceLastSex = slaUtil.GetActorDaysSinceLastOrgasm(who)
    Float fatiguevalue = slaUtil.GetActorFatigue(who)
    Float FrustrationValue = slaUtil.GetActorFrustration(who)
    Float TraumaValue = slaUtil.GetActorTrauma(who)
    Float MasochismValue = slaUtil.GetActorMasochism(who)
    Float ActualTraumaValue = TraumaValue - MasochismValue
    Float timeArousal = timeSinceLastSex * ((timeRate + FrustrationValue) - fatiguevalue)
    If timeArousal < -100
        timeArousal = -100
    EndIf
    Float ExhibitionismValue = slaUtil.GetActorExhibitionism(Who)
	
	AddTextOption("$SLA_ArousalTimeCalc", timeArousal as Int, OPTION_FLAG_DISABLED)
	AddTextOption("$SLA_HoursSinceSex", timeSinceLastSex, OPTION_FLAG_DISABLED)
	AddTextOption("$SLA_TimeRate", timeRate, OPTION_FLAG_DISABLED)
    AddTextOption("$SLA_FrustrationValue", FrustrationValue, OPTION_FLAG_DISABLED)
    AddTextOption("$SLA_FatigueValue", fatiguevalue, OPTION_FLAG_DISABLED)
    AddTextOption("$SLA_TraumaValue", TraumaValue, OPTION_FLAG_DISABLED)
    AddTextOption("$SLA_MasochismValue", MasochismValue, OPTION_FLAG_DISABLED)
    AddTextOption("$SLA_ActualTraumaValue", ActualTraumaValue, OPTION_FLAG_DISABLED)
    AddTextOption("SLA_ExhibitionismValue", ExhibitionismValue, OPTION_FLAG_DISABLED)
		
	Int genderPreference = slaUtil.GetGenderPreference(who)
	AddTextOption("$SLA_GenderPreference", GenderPreferenceList[genderPreference], OPTION_FLAG_DISABLED)
    
EndFunction


Function DisplayPuppetMaster()

	SetCursorFillMode(TOP_TO_BOTTOM)
    
    If puppetActor
    
        AddEmptyOption()
        AddHeaderOption(puppetActor.GetLeveledActorBase().GetName())

        Bool blockArousal = slaUtil.IsActorArousalBlocked(puppetActor)
        blockArousalOID = AddToggleOption("$SLA_ArousalBlocked", BlockArousal)
        
        Bool lockArousal = slaUtil.IsActorArousalLocked(puppetActor)
        lockArousalOID = AddToggleOption("$SLA_ArousalLocked", LockArousal)

        Int exposure = slaUtil.GetActorExposure(puppetActor)
        setExposureOID = AddSliderOption("$SLA_Exposure", exposure, "{0}")
                    
        Float arousalExposureRate = slaUtil.GetActorExposureRate(puppetActor)
        arousalExposureRateOID = AddSliderOption("$SLA_ExposureRate", ArousalExposureRate, "{1}")

        Float timeRate = slaUtil.GetActorTimeRate(puppetActor)
        setTimeRateOID = AddSliderOption("$SLA_TimeRate", timeRate, "{0}")
        
        Int genderPreference = slaUtil.GetGenderPreference(puppetActor, True)
        genderPreferenceOID = AddMenuOption("$SLA_GenderPreference", GenderPreferenceList[genderPreference])

        Bool isExbitionist = slaUtil.IsActorExhibitionist(puppetActor)
        exbitionistOID = AddToggleOption("$SLA_IsExhibitionist", IsExbitionist)	
        
    EndIf
    
    ; Move to top right
    SetCursorPosition(1)
    
    puppetActorMenuOID = AddMenuOption("$SLA_SelectPuppet", puppetActorNames[puppetActorIndex])

    If puppetActor
    
        DisplayActorStatus(puppetActor)
        
    EndIf
    
EndFunction


Function DisplayArmorList()

        SetCursorFillMode(LEFT_TO_RIGHT)
        sliderModeOID = AddToggleOption("$SLA_EnableDetails", sliderMode)

        targetActorMenuOID = AddMenuOption("$SLA_SelectActor", targetActorNames[targetActorIndex])
        
        AddHeaderOption("$SLA_EquippedItems")
        AddHeaderOption("$SLA_Options")
		
		DisplayWornItems(targetActors[targetActorIndex])

EndFunction


Function DisplayWornItems(Actor who)

    UpdateWornItemStates(who) ; we only care about body and shoes.

    If bodyItem
        bodyItemOID = AddTextOption("$SLA_BodyItem", bodyItem.GetName())
        If sliderMode
            AddSlidersForBodyItem()
        Else
            AddTogglesForBodyItem()
        EndIf
        AddEmptyOption()
        AddEmptyOption()
    Else
        noBodyItemOID = AddTextOption("", "$SLA_NoBodyItem")
        AddEmptyOption()
        AddEmptyOption()
        AddEmptyOption()
    EndIf
    
    If footItem
        footItemOID = AddTextOption("$SLA_ShoesBoots", footItem.GetName())
        If sliderMode
            heelsSliderOID = AddSliderOption("$SLA_HighHeels", killerHeelsValue)
        Else
            heelsToggleOID = AddToggleOption("$SLA_HighHeels", killerHeelsValue > 0)
        EndIf
    Else
        noFootItemOID = AddTextOption("", "$SLA_NoShoesBoots")
        AddEmptyOption()
    EndIf
    
    If bikiniArmors.Length > 0
    
        AddHeaderOption("Items in bikini slots")
        AddHeaderOption("")
    
        Int ii = 0
        Int count = bikiniArmors.Length
        While ii < count
        
            Armor bikini = bikiniArmors[ii] As Armor
            AddTextOption(_fw_utils.FormatHex(bikini.GetFormId()), bikini.GetName())
            
            Int value = bikiniSliderValues[ii]
            If sliderMode
                bikiniSliderOIDs[ii] = AddSliderOption("$SLA_Bikini", value)
            Else
                bikiniToggleOIDs[ii] = AddToggleOption("$SLA_Bikini", value > 0)
            EndIf
            ii += 1
            
        EndWhile

    EndIf

EndFunction


Function UpdateWornItemStates(Actor who)

    bodyItem = who.GetWornForm(slaSlotMaskValues[2]) As Armor ; 32 - 30
    If bodyItem
        nakedArmorValue   = StorageUtil.GetIntValue(bodyItem, keyNakedArmor)
        bikiniArmorValue  = StorageUtil.GetIntValue(bodyItem, keyBikiniArmor)
        sexyArmorValue    = StorageUtil.GetIntValue(bodyItem, keySexyArmor)
        slootyArmorValue  = StorageUtil.GetIntValue(bodyItem, keySlootyArmor)
        illegalArmorValue = StorageUtil.GetIntValue(bodyItem, keyIllegalArmor)
        raggedArmorValue  = StorageUtil.GetIntValue(bodyItem, keyRaggedArmor)
    EndIf

    footItem  = who.GetWornForm(slaSlotMaskValues[7]) As Armor ; 37 - 30
    If footItem
        killerHeelsValue = StorageUtil.GetIntValue(footItem, keyKillerHeels)
    EndIf
    
    GetBikiniArmorsForTargetActor(who)
    
EndFunction


Function GetBikiniArmorsForTargetActor(Actor who)

    bikiniArmors = emptyFormArray
    
    ; 44, 45 - depravity armors, 48 TAWoBA, 49 SLS, 52 TAWoBA, 56 SLS, 58 harness
    Armor[] candidates = new Armor[7]
    candidates[0] = who.GetWornForm(slaSlotMaskValues[14]) As Armor ; 44
    candidates[1] = who.GetWornForm(slaSlotMaskValues[15]) As Armor ; 45
    candidates[2] = who.GetWornForm(slaSlotMaskValues[18]) As Armor ; 48
    candidates[3] = who.GetWornForm(slaSlotMaskValues[19]) As Armor ; 49
    candidates[4] = who.GetWornForm(slaSlotMaskValues[22]) As Armor ; 52
    candidates[5] = who.GetWornForm(slaSlotMaskValues[26]) As Armor ; 56
    candidates[6] = who.GetWornForm(slaSlotMaskValues[28]) As Armor ; 58
    
    Int ii = 0
    While ii < 7
        Armor item = candidates[ii]
        If item && item != bodyItem && bikiniArmors.Find(item) < 0 && item.GetName() ; don't re-add duplicates, or body slot items, but can re-add boots
            If item.HasKeywordString("ArmorClothes") || item.HasKeywordString("ArmorLight") || item.HasKeywordString("ArmorHeavy") ; exclude schlongs etc.
                bikiniArmors = PapyrusUtil.PushForm(bikiniArmors, item)
            EndIf
        EndIf
        ii += 1
    EndWhile
    
    bikiniSliderOIDs = Utility.CreateIntArray(bikiniArmors.Length)
    bikiniToggleOIDs = Utility.CreateIntArray(bikiniArmors.Length)
    bikiniSliderValues = Utility.CreateIntArray(bikiniArmors.Length)
    
    ii = bikiniArmors.Length
    _fw_utils.Spam("Got " + ii + " bikini items ")
    While ii
        ii -= 1
        bikiniSliderValues[ii] = StorageUtil.GetIntValue(bikiniArmors[ii], keyBikiniArmor)
    EndWhile


EndFunction


Function AddSlidersForBodyItem()
        nakedSliderOID   = AddSliderOption("$SLA_Naked", nakedArmorValue)
        AddEmptyOption()
        bikiniSliderOID  = AddSliderOption("$SLA_Bikini", bikiniArmorValue)
        AddEmptyOption()
        sexySliderOID    = AddSliderOption("$SLA_Sexy", sexyArmorValue)
        AddEmptyOption()
        slootySliderOID  = AddSliderOption("$SLA_Slooty", slootyArmorValue)
        AddEmptyOption()
        illegalSliderOID = AddSliderOption("$SLA_Illegal", illegalArmorValue)
        AddEmptyOption()
        poshSliderOID    = AddSliderOption("$SLA_Posh", poshArmorValue)
        AddEmptyOption()
        raggedSliderOID  = AddSliderOption("$SLA_Ragged", raggedArmorValue)
EndFunction


Function AddTogglesForBodyItem()
        nakedToggleOID   = AddToggleOption("$SLA_Naked", nakedArmorValue > 0)
        AddEmptyOption()
        bikiniToggleOID  = AddToggleOption("$SLA_Bikini", bikiniArmorValue > 0)
        AddEmptyOption()
        sexyToggleOID    = AddToggleOption("$SLA_Sexy", sexyArmorValue > 0)
        AddEmptyOption()
        slootyToggleOID  = AddToggleOption("$SLA_Slooty", slootyArmorValue > 0)
        AddEmptyOption()
        illegalToggleOID = AddToggleOption("$SLA_Illegal", illegalArmorValue > 0)
        AddEmptyOption()
        poshToggleOID    = AddToggleOption("$SLA_Posh", poshArmorValue > 0)
        AddEmptyOption()
        raggedToggleOID  = AddToggleOption("$SLA_Ragged", raggedArmorValue > 0)
EndFunction


Event OnOptionMenuOpen(int option)

    If 2 == pageId ; PuppetMaster
    
        If option == puppetActorMenuOID

            SetMenuDialogOptions(puppetActorNames)
            SetMenuDialogStartIndex(puppetActorIndex)
            SetMenuDialogDefaultIndex(0)

        ElseIf option == genderPreferenceOID
            Int genderPreference = slaUtil.GetGenderPreference(puppetActor, True)
            SetMenuDialogOptions(genderPreferenceList)
            SetMenuDialogStartIndex(genderPreference)
            SetMenuDialogDefaultIndex(1) ; Female
            
        EndIf
    
    ElseIf 3 == pageId ; Armor
    
        If option == targetActorMenuOID
            
            SetMenuDialogOptions(targetActorNames)
            SetMenuDialogStartIndex(targetActorIndex)
            SetMenuDialogDefaultIndex(0)
            
        EndIf
    
    EndIf
    
EndEvent


Event OnOptionMenuAccept(int option, int index)

    If 2 == pageId ; PuppetMaster
    
        If option == puppetActorMenuOID
            puppetActorIndex = index
            puppetActor = puppetActors[index]
            ForcePageReset()
            
        ElseIf option == genderPreferenceOID
            slaUtil.SetGenderPreference(puppetActor, index)
            SetMenuOptionValue(option, genderPreferenceList[index])
            
        EndIf
        
    ElseIf 3 == pageId ; Armor
    
        If option == targetActorMenuOID
        
            targetActorIndex = index
            UpdateWornItemStates(targetActors[index])
            ForcePageReset()
        
        EndIf
    
    EndIf
    
EndEvent


Event OnOptionSelect(int option)

    If 0 == pageId ; Main
	
        If option == desireSpellOID
            IsDesireSpell = !IsDesireSpell
            SetToggleOptionValue(option, IsDesireSpell)
            
        ElseIf (option == wantsPurgingOID)
            wantsPurging = !wantsPurging
            SetToggleOptionValue(option, wantsPurging)
            If wantsPurging
                slaMain = Quest.GetQuest("sla_Main") As slaMainScr
                slaMain.startCleaning()
            EndIf

        ElseIf option == maleAnimationOID
            maleAnimation = !maleAnimation
            SetToggleOptionValue(option, maleAnimation)
            slaMain.SetIsAnimatingMales(maleAnimation As Int)

            ElseIf (option == femaleAnimationOID)
            femaleAnimation = !femaleAnimation
            SetToggleOptionValue(option, femaleAnimation)
            slaMain.SetIsAnimatingFemales(femaleAnimation As Int)
            
        ElseIf option == useLOSOID
            useLOS = !useLOS
            SetToggleOptionValue(useLOSOID, useLOS)
            slaMain.SetUseLOS(useLOS As Int)

        ElseIf option == nakedOnlyOID
            isNakedOnly = !isNakedOnly
            SetToggleOptionValue(option, IsNakedOnly)
            slaMain.SetNakedOnly(isNakedOnly As Int)

        ElseIf option == bDisabledOID
            bDisabled = !bDisabled
            SetToggleOptionValue(option, bDisabled)
            slaMain.SetDisabled(bDisabled As Int)

        ElseIf option == extendedNPCNakedOID
            isExtendedNPCNaked = !isExtendedNPCNaked
            SetToggleOptionValue(option, isExtendedNPCNaked)
            
        ElseIf option == useSOSOID
            isUseSOS = !isUseSOS
            SetToggleOptionValue(option, IsUseSOS)
            
        ElseIf option == statusNotSplashOID
            statusNotSplash = !statusNotSplash
            SetToggleOptionValue(option, statusNotSplash)
            
        EndIf
            
    ElseIf 2 == pageId ; PuppetMaster
		
        If option == blockArousalOID
            Bool blockArousal = !slaUtil.IsActorArousalBlocked(puppetActor)
            SetToggleOptionValue(option, blockArousal)
            slaUtil.SetActorArousalBlocked(puppetActor, blockArousal)
        
        ElseIf option == lockArousalOID
            Bool lockArousal = !slaUtil.IsActorArousalLocked(puppetActor)
            SetToggleOptionValue(option, lockArousal)
            slaUtil.SetActorArousalLocked(puppetActor, lockArousal)
            
        ElseIf option == exbitionistOID
            Bool isExbitionist = !slaUtil.IsActorExhibitionist(puppetActor)
            SetToggleOptionValue(option, isExbitionist)		
            slaUtil.SetActorExhibitionist(puppetActor, isExbitionist)
            
        EndIf
        
    ElseIf 3 == pageId ; Armor

        If option == sliderModeOID
            sliderMode = !sliderMode
            ForcePageReset()
            
        ElseIf option == nakedToggleOID
            nakedArmorValue = ToggleBodyArmorValue(nakedArmorValue, keyNakedArmor)
            SetToggleOptionValue(option, nakedArmorValue > 0)
            UpdateNakedKeywords(bodyItem, nakedArmorValue)
            
        ElseIf option == bikiniToggleOID
            bikiniArmorValue = ToggleBodyArmorValue(bikiniArmorValue, keyBikiniArmor)
            SetToggleOptionValue(option, bikiniArmorValue > 0)
            UpdateBikiniKeywords(bodyItem, bikiniArmorValue)

        ElseIf option == sexyToggleOID
            sexyArmorValue = ToggleBodyArmorValue(sexyArmorValue, keySexyArmor)
            SetToggleOptionValue(option, sexyArmorValue > 0)
            UpdateSexyKeywords(bodyItem, sexyArmorValue)

        ElseIf option == slootyToggleOID
            slootyArmorValue = ToggleBodyArmorValue(slootyArmorValue, keySlootyArmor)
            SetToggleOptionValue(option, slootyArmorValue > 0)
            UpdateSlootyKeywords(bodyItem, slootyArmorValue)

        ElseIf option == illegalToggleOID
            illegalArmorValue = ToggleBodyArmorValue(illegalArmorValue, keyIllegalArmor)
            SetToggleOptionValue(option, illegalArmorValue > 0)
            UpdateIllegalKeywords(bodyItem, illegalArmorValue)

        ElseIf option == poshToggleOID
            poshArmorValue = ToggleBodyArmorValue(poshArmorValue, keyPoshArmor)
            SetToggleOptionValue(option, poshArmorValue > 0)
            UpdatePoshKeywords(bodyItem, poshArmorValue)

        ElseIf option == raggedToggleOID    
            raggedArmorValue = ToggleBodyArmorValue(raggedArmorValue, keyRaggedArmor)
            SetToggleOptionValue(option, raggedArmorValue >0)
            UpdateRaggedKeywords(bodyItem, raggedArmorValue)

        ElseIf option == heelsToggleOID
            If killerHeelsValue > 0
                killerHeelsValue = 0
            Else
                killerHeelsValue = 75
            EndIf
            SetToggleOptionValue(option, killerHeelsValue > 0)
            UpdateHeelsKeywords(footItem, killerHeelsValue)
            
        Else
        
            Int bikiniIndex = bikiniToggleOIDs.Find(option)
            If bikiniIndex >= 0
                Int value = bikiniSliderValues[bikiniIndex]
                If value > 0
                    value = 0
                Else
                    value = 51
                EndIf
                bikiniSliderValues[bikiniIndex] = value
                SetToggleOptionValue(option, value > 0)
                UpdateBikiniKeywords(bikiniArmors[bikiniIndex], value)
            EndIf
            
        EndIf
        
    EndIf
    
EndEvent


Event OnOptionSliderOpen(int option)		

	If 0 == pageId ; Main
    
        If option == defaultExposureRateOID
            SetSliderDialogStartValue(defaultExposureRate)
            SetSliderDialogDefaultValue(2.0)
            SetSliderDialogRange(0.0, 10.0)
            SetSliderDialogInterval(0.1)
            
        ElseIf option == timeRateHalfLifeOID
            SetSliderDialogStartValue(timeRateHalfLife as Float)
            SetSliderDialogDefaultValue(2.0)
            SetSliderDialogRange(0.0, 10.0)
            SetSliderDialogInterval(0.1)

        ElseIF option == MinimumTimeRateOID
            SetSliderDialogStartValue(MinimumTimeRate as Float)
            SetSliderDialogDefaultValue(0.0)
            SetSliderDialogRange(0.0, 100.0)
            SetSliderDialogInterval(1.0)

        ElseIf option == FatigueOID
            SetSliderDialogStartValue(Fatigue as Float)
            SetSliderDialogDefaultValue(40.0)
            SetSliderDialogRange(0.0, 100.0)
            SetSliderDialogInterval(1.0)

        ElseIf option == FatigueHalfLifeOID
            SetSliderDialogStartValue(FatigueHalfLife as Float)
            SetSliderDialogDefaultValue(0.5)
            SetSliderDialogRange(0.0, 10.0)
            SetSliderDialogInterval(0.1)

        ElseIf option == FatigueMaleBonusOID
            SetSliderDialogStartValue(FatigueMaleBonus as Float)
            SetSliderDialogDefaultValue(60.0)
            SetSliderDialogRange(0.0, 100.0)
            SetSliderDialogInterval(1.0)

        ElseIf option == FrustrationOID
            SetSliderDialogStartValue(Frustration as Float)
            SetSliderDialogDefaultValue(5.0)
            SetSliderDialogRange(0.0, 100.0)
            SetSliderDialogInterval(1.0)

        ElseIf option == LewdModOID
            SetSliderDialogStartValue(LewdMod as Float)
            SetSliderDialogDefaultValue(0.0)
            SetSliderDialogRange(0.0, 5.0)
            SetSliderDialogInterval(1.0)

        ElseIf option == FrustrationHalfLifeOID
            SetSliderDialogStartValue(FrustrationHalfLife as Float)
            SetSliderDialogDefaultValue(1.0)
            SetSliderDialogRange(0.0, 10.0)
            SetSliderDialogInterval(0.1)

        ElseIf option == FrustrationGrowthOID
            SetSliderDialogStartValue(FrustrationGrowth as Float)
            SetSliderDialogDefaultValue(0.5)
            SetSliderDialogRange(0.0, 10.0)
            SetSliderDialogInterval(0.1)

        ElseIf option == FrustrationGrowthThresholdOID
            SetSliderDialogStartValue(FrustrationGrowthThreshold as Float)
            SetSliderDialogDefaultValue(90.0)
            SetSliderDialogRange(0.0, 100.0)
            SetSliderDialogInterval(1.0)

        ElseIf option == FrustrationLossOID
            SetSliderDialogStartValue(FrustrationLoss as Float)
            SetSliderDialogDefaultValue(100.0)
            SetSliderDialogRange(0.0, 100.0)
            SetSliderDialogInterval(1.0)

        ElseIf option == TraumaOID
            SetSliderDialogStartValue(Trauma as Float)
            SetSliderDialogDefaultValue(100.0)
            SetSliderDialogRange(0.0, 100.0)
            SetSliderDialogInterval(1.0)

        ElseIf option == MinStartArousalOID
            SetSliderDialogStartValue(MinStartArousal as Float)
            SetSliderDialogDefaultValue(25.0)
            SetSliderDialogRange(0.0, 100.0)
            SetSliderDialogInterval(1.0)

        ElseIf option == MinRapeStartArousalOID
            SetSliderDialogStartValue(MinRapeStartArousal as Float)
            SetSliderDialogDefaultValue(50.0)
            SetSliderDialogRange(0.0, 100.0)
            SetSliderDialogInterval(1.0)

        ElseIf option == MasochismOID
            SetSliderDialogStartValue(Masochism as Float)
            SetSliderDialogDefaultValue(5.0)
            SetSliderDialogRange(0.0, 100.0)
            SetSliderDialogInterval(1.0)

        ElseIf option == MasochismHalfLifeOID
            SetSliderDialogStartValue(MasochismHalfLife as Float)
            If TraumaHalfLife <= 2.0
            	SetSliderDialogDefaultValue(2.0)
            Else
            	SetSliderDialogDefaultValue(TraumaHalfLife)
            EndIf
            SetSliderDialogRange(TraumaHalfLife, 10.0)
            SetSliderDialogInterval(0.1)

        ElseIf option == ExhibitionismOID
            SetSliderDialogStartValue(Exhibitionism as Float)
            SetSliderDialogDefaultValue(5.0)
            SetSliderDialogRange(0.0, 100.0)
            SetSliderDialogInterval(1.0)

        ElseIf option == ExhibitionismAdditionalOID
            SetSliderDialogStartValue(ExhibitionismAdditional as Float)
            SetSliderDialogDefaultValue(2.0)
            SetSliderDialogRange(0.0, 100.0)
            SetSliderDialogInterval(1.0)

        ElseIf option == ExhibitionismCooldownOID
            SetSliderDialogStartValue(ExhibitionismCooldown as Float)
            SetSliderDialogDefaultValue(120.0)
            SetSliderDialogRange(15.0, 300.0)
            SetSliderDialogInterval(5.0)

        ElseIf option == ExhibitionismHalfLifeOID
            SetSliderDialogStartValue(ExhibitionismHalfLife as Float)
            SetSliderDialogDefaultValue(2.0)
            SetSliderDialogRange(0.0, 10.0)
            SetSliderDialogInterval(0.1)

        ElseIf option == ExhibitionismThresholdOID
            SetSliderDialogStartValue(ExhibitionismThreshold as Float)
            SetSliderDialogDefaultValue(50.0)
            SetSliderDialogRange(0.0, 100.0)
            SetSliderDialogInterval(1.0)

        ElseIf option == TraumaHalfLifeOID
            SetSliderDialogStartValue(TraumaHalfLife as Float)
            SetSliderDialogDefaultValue(2.0)
            SetSliderDialogRange(0.0, 10.0)
            SetSliderDialogInterval(0.1)

        ElseIf option == MinDaysWithoutSexOID
            SetSliderDialogStartValue(MinDaysWithoutSex as Float)
            SetSliderDialogDefaultValue(0.0)
            SetSliderDialogRange(0.0, 10.0)
            SetSliderDialogInterval(0.1)

        ElseIf option == ExposureHalfLifeOID
            SetSliderDialogStartValue(ExposureHalfLife as Float)
            SetSliderDialogDefaultValue(2.0)
            SetSliderDialogRange(0.0, 10.0)
            SetSliderDialogInterval(0.1)
            
        ElseIf option == sexOveruseEffectOID ; Time rate modifier
            SetSliderDialogStartValue(sexOveruseEffect as Float)
            SetSliderDialogDefaultValue(5.0)
            SetSliderDialogRange(0.0, 10.0)
            SetSliderDialogInterval(1.0)

        ElseIf option == cellScanFreqOID
            SetSliderDialogStartValue(cellScanFreq as Float)
            SetSliderDialogDefaultValue(120.0)
            SetSliderDialogRange(15.0, 300.0)
            SetSliderDialogInterval(5.0)
        EndIf
        
    ElseIf 2 == pageId ; PuppetMaster
    
        If (option == SetExposureOID)
            Int exposure = slaUtil.GetActorExposure(puppetActor)
            SetSliderDialogStartValue(exposure)
            SetSliderDialogDefaultValue(0)
            SetSliderDialogRange(0, slaUtil.slaArousalCap)
            SetSliderDialogInterval(1)
            
        ElseIf (option == ArousalExposureRateOID)
            Float ArousalExposureRate = slaUtil.GetActorExposureRate(puppetActor)
            SetSliderDialogStartValue(ArousalExposureRate)
            SetSliderDialogDefaultValue(2.0)
            SetSliderDialogRange(0.0, 10.0)
            SetSliderDialogInterval(0.1)

        ElseIf option == setTimeRateOID
            Float addiction = slaUtil.GetActorTimeRate(puppetActor)
            SetSliderDialogStartValue(addiction)
            SetSliderDialogDefaultValue(10.0)
            SetSliderDialogRange(0.0, 100.0)
            SetSliderDialogInterval(1.0)
        EndIf
        
    ElseIf 3 == pageId ; Armor
    
        If option == nakedSliderOID
            SetSliderDialogStartValue(nakedArmorValue)
        ElseIf option == bikiniSliderOID
            SetSliderDialogStartValue(bikiniArmorValue)
        ElseIf option == sexySliderOID
            SetSliderDialogStartValue(sexyArmorValue)
        ElseIf option == slootySliderOID
            SetSliderDialogStartValue(slootyArmorValue)
        ElseIf option == illegalSliderOID
            SetSliderDialogStartValue(illegalArmorValue)
        ElseIf option == poshSliderOID
            SetSliderDialogStartValue(poshArmorValue)
        ElseIf option == raggedSliderOID
            SetSliderDialogStartValue(raggedArmorValue)
        ElseIf option == heelsSliderOID
            SetSliderDialogStartValue(killerHeelsValue)
            
        Else
        
            Int bikiniIndex = bikiniSliderOIDs.Find(option)
            If bikiniIndex >= 0
                Int value = bikiniSliderValues[bikiniIndex]
                SetSliderDialogStartValue(value)
            EndIf
            
        EndIf
        
        SetSliderDialogDefaultValue(0)
        SetSliderDialogRange(0.0, 100.0)
        SetSliderDialogInterval(1.0)

    EndIf
    
EndEvent


Event OnOptionSliderAccept(Int option, Float value)		

    If 0 == pageId ; Main

        If option == defaultExposureRateOID
            DefaultExposureRate = value
            SetSliderOptionValue(option, value, "{1}")
            
        ElseIf option == timeRateHalfLifeOID
            TimeRateHalfLife = value
            SetSliderOptionValue(option, value, "{1}")

        ElseIf option == MinimumTimeRateOID
            MinimumTimeRate = value as Int
            SetSliderOptionValue(option, value, "{1}")

        ElseIf option == FatigueOID
            Fatigue = value as Int
            SetSliderOptionValue(option, value, "{0}")

        ElseIf option == FatigueHalfLifeOID
            FatigueHalfLife = value
            SetSliderOptionValue(option, value, "{1}")

        ElseIf option == FatigueMaleBonusOID
            FatigueMaleBonus = value as Int
            SetSliderOptionValue(option, value, "{0}")

        ElseIf option == FrustrationOID
            Frustration = value as Int
            SetSliderOptionValue(option, value, "{0}")

        ElseIf option == LewdModOID
            LewdMod = value as Int
            SetSliderOptionValue(option, value, "{0}")

        ElseIf option == FrustrationHalfLifeOID
            FrustrationHalfLife = value
            SetSliderOptionValue(option, value, "{1}")

        ElseIf option == FrustrationGrowthOID
            FrustrationGrowth = value
            SetSliderOptionValue(option, value, "{1}")

        ElseIf option == FrustrationGrowthThresholdOID
            FrustrationGrowthThreshold = value as Int
            SetSliderOptionValue(option, value, "{0}")

        ElseIf option == FrustrationLossOID
            FrustrationLoss = value as Int
            SetSliderOptionValue(option, value, "{0}")

        ElseIf option == TraumaOID
            Trauma = value as Int
            SetSliderOptionValue(option, value, "{0}")

        ElseIf option == MinStartArousalOID
            MinStartArousal = value as Int
            SetSliderOptionValue(option, value, "{0}")

        ElseIf option == MinRapeStartArousalOID
            MinRapeStartArousal = value as Int
            SetSliderOptionValue(option, value, "{0}")

        ElseIf option == MasochismOID
            Masochism = value as Int
            SetSliderOptionValue(option, value, "{0}")

        ElseIf option == MasochismHalfLifeOID
            MasochismHalfLife = value
            SetSliderOptionValue(option, value, "{1}")

        ElseIf option == ExhibitionismOID
            Exhibitionism = value as Int
            SetSliderOptionValue(option, value, "{0}")

        ElseIf option == ExhibitionismAdditionalOID
            ExhibitionismAdditional = value as Int
            SetSliderOptionValue(option, value, "{0}")

        ElseIf option == ExhibitionismCooldownOID
            ExhibitionismCooldown = value as Int
            SetSliderOptionValue(option, value, "{0}")

        ElseIf option == ExhibitionismHalfLifeOID
            ExhibitionismHalfLife = value as Int
            SetSliderOptionValue(option, value, "{0}")

        ElseIf option == ExhibitionismThresholdOID
            ExhibitionismThreshold = value as Int
            SetSliderOptionValue(option, value, "{0}")

        ElseIf option == TraumaHalfLifeOID
            TraumaHalfLife = value
            SetSliderOptionValue(option, value, "{1}")

        ElseIf option == MinDaysWithoutSexOID
            MinDaysWithoutSex = value as Int
            SetSliderOptionValue(option, value, "{1}")

        ElseIf option == ExposureHalfLifeOID
            ExposureHalfLife = value
            SetSliderOptionValue(option, value, "{1}")

        ElseIf option == sexOveruseEffectOID ; Time rate modifier
            SexOveruseEffect = value As Int
            SetSliderOptionValue(option, value, "{0}")

        ElseIf option == cellScanFreqOID
            cellScanFreq = value As Int
            SetSliderOptionValue(option, value, "{0}")
        EndIf
        
    ElseIf 2 == pageId ; PuppetMaster
    
        If option == setExposureOID
            slaUtil.SetActorExposure(puppetActor, value As Int)
            SetSliderOptionValue(option, value, "{0}")		
            
        ElseIf option == arousalExposureRateOID
            slaUtil.SetActorExposureRate(puppetActor, value)
            SetSliderOptionValue(option, value, "{1}")
            
        ElseIf option == setTimeRateOID
            slaUtil.SetActorTimeRate(puppetActor, value As Int)
            SetSliderOptionValue(option, value, "{0}")	
        EndIf
        
    ElseIf 3 == pageId ; Armor
    
        If option == nakedSliderOID
            nakedArmorValue = value As Int
            StorageUtil.SetIntValue(bodyItem, keyNakedArmor, nakedArmorValue)
            
        ElseIf option == bikiniSliderOID
            bikiniArmorValue = value As Int
            StorageUtil.SetIntValue(bodyItem, keyBikiniArmor, bikiniArmorValue)
            
        ElseIf option == sexySliderOID
            sexyArmorValue = value As Int
            StorageUtil.SetIntValue(bodyItem, keySexyArmor, sexyArmorValue)
            
        ElseIf option == slootySliderOID
            slootyArmorValue = value As Int
            StorageUtil.SetIntValue(bodyItem, keySlootyArmor, slootyArmorValue)
            
        ElseIf option == illegalSliderOID
            illegalArmorValue = value As Int
            StorageUtil.SetIntValue(bodyItem, keyIllegalArmor, illegalArmorValue)
            
        ElseIf option == poshSliderOID
            poshArmorValue = value As Int
            StorageUtil.SetIntValue(bodyItem, keyPoshArmor, poshArmorValue)
            
        ElseIf option == raggedSliderOID
            raggedArmorValue = value As Int
            StorageUtil.SetIntValue(bodyItem, keyRaggedArmor, raggedArmorValue)
            
        ElseIf option == heelsSliderOID
            killerHeelsValue = value As Int
            StorageUtil.SetIntValue(footItem, keyKillerHeels, killerHeelsValue)
            
        Else
        
            Int bikiniIndex = bikiniSliderOIDs.Find(option)
            If bikiniIndex >= 0
                Int intValue = value As Int
                bikiniSliderValues[bikiniIndex] = intValue
                StorageUtil.SetIntValue(bikiniArmors[bikiniIndex], keyBikiniArmor, intValue)
            EndIf
            
        EndIf

        SetSliderOptionValue(option, value)

    EndIf
    
EndEvent


Event OnOptionKeyMapChange(Int option, Int keyCode, String conflictingItem, String conflictName)

	Bool ok = True

	; Check for conflict
	If "" != conflictingItem
    
		String boxText
		If conflictName == ""
			boxText = "This key is already mapped to:\n'" + conflictingItem + "'\n\nAre you sure you want to continue?"
		Else
			boxText = "This key is already mapped to:\n'" + conflictingItem + "'\n(" + conflictName + ")\n\nAre you sure you want to continue?"
		EndIf
		ok = ShowMessage(boxText, True, "$SLA_Yes", "$SLA_No")
        
	EndIf

	If ok
    
		If option == NotificationKeyOID
			notificationKey = keyCode			
		EndIf

		SetKeymapOptionValue(option, keyCode)
        
	EndIf
    
EndEvent


Event OnOptionHighlight(int option)

    String infoText
    
    If 0 == pageId ; Main
    
        If option == notificationKeyOID
            infoText = "$SLA_InfoStatusKey"
        ElseIf option == DesireSpellOID
            infoText = "$SLA_InfoDesire"
        ElseIf option == wantsPurgingOID
            infoText = "$SLA_WantsPurgingDesc"
        ElseIf option == maleAnimationOID
            infoText = "$SLA_EnableMaleAnimationDesc"
        ElseIf option == femaleAnimationOID
            infoText = "$SLA_EnableFemaleAnimationDesc"
        ElseIf option == useLOSOID
            infoText = "$SLA_UseLOSDesc"
        ElseIf option == nakedOnlyOID
            infoText = "$SLA_IsNakedOnlyDesc"
        ElseIf option == bDisabledOID
            infoText = "$SLA_DisabledDesc"
        ElseIf option == extendedNPCNakedOID
            infoText = "$SLA_InfoExtendedNPCNaked"
        ElseIf option == useSOSOID
            infoText = "$SLA_InfoEnableSOS"
        ElseIf option == defaultExposureRateOID
            infoText = "$SLA_InfoDefaultExposureRate"
        ElseIf option == timeRateHalfLifeOID
            infoText = "$SLA_InfoTimeRateHalfLife"
        ElseIf option == MinimumTimeRateOID
            infoText = "$SLA_InfoMinimumTimeRate"
        ElseIf option == FatigueOID
            infoText = "$SLA_InfoFatigue"
        ElseIf option == FatigueMaleBonusOID
            infoText = "$SLA_InfoFatigueMaleBonus"
        ElseIf option == MBonUsesSLGenderOID
            infoText = "$SLA_InfoMBonUsesSLGender"
        ElseIf option == FatigueHalfLifeOID
            infoText = "$SLA_InfoFatigueHalfLife"
        ElseIf option == FrustrationOID
            infoText = "$SLA_InfoFrustration"
        ElseIf option == LewdModOID
            If Game.GetModByName("SLSO.esp") == 255
                infoText = "$SLA_InfoLewdMod"
            Else
                infoText = "$SLA_InfoLewdModDisabled"
            EndIf
        ElseIf option == FrustrationHalfLifeOID
            infoText = "$SLA_InfoFrustrationHalfLife"
        ElseIf option == FrustrationGrowthOID
            infoText = "$SLA_InfoFrustrationGrowth"
        ElseIf option == FrustrationGrowthThresholdOID
            infoText = "$SLA_InfoFrustrationGrowthThreshold"
        ElseIf option == FrustrationLossOID
            infoText = "$SLA_InfoFrustrationLoss"
        ElseIf option == TraumaOID
            infoText = "$SLA_InfoTrauma"
        ElseIf option == MinStartArousalOID
            infoText = "$SLA_InfoMinStartArousal"
        ElseIf option == MinRapeStartArousalOID
            infoText = "$SLA_InfoMinRapeStartArousal"
        ElseIf option == MasochismOID
            infoText = "$SLA_InfoMasochism"
        ElseIf option == MasochismHalfLifeOID
            infoText = "$SLA_InfoMasochismHalfLife"
        ElseIf option == ExhibitionismOID
            infoText = "$SLA_InfoExhibitionism"
        ElseIf option == ExhibitionismAdditionalOID
            infoText = "$SLA_InfoExhibitionismAdditional"
        ElseIf option == ExhibitionismCooldownOID
            infoText = "$SLA_InfoExhibitionismCooldown"
        ElseIf option == ExhibitionismHalfLifeOID
            infoText = "$SLA_InfoExhibitionismHalfLife"
        ElseIf option == ExhibitionismThresholdOID
            infoText = "$SLA_InfoExhibitionismThreshold"
        ElseIf option == TraumaHalfLifeOID
            infoText = "$SLA_InfoTraumaHalfLife"
        ElseIf option == MinDaysWithoutSexOID
            infoText == "$SLA_InfoMinDaysWithoutSex"
        ElseIf option == ExposureHalfLifeOID
            infoText = "$SLA_InfoExposureHalfLife"
        ElseIf option == sexOveruseEffectOID
            infoText = "$SLA_InfoSexOverUseEffect"
        ElseIf option == cellScanFreqOID
            infoText = "$SLA_InfoCellScanFreq"
        ElseIf option == statusNotSplashOID
            infoText = "$SLA_StatusNotSplashInfo"
        EndIf
    
    ElseIf 2 == pageId ; PuppetMaster
    
        If option == puppetActorMenuOID
            infoText = "$SLA_SelectPuppetInfo"
        ElseIf option == blockArousalOID
            infoText = "$SLA_InfoBlockedArousal"
        ElseIf option == lockArousalOID
            infoText = "$SLA_InfoLockedArousal"
        ElseIf option == exbitionistOID
            infoText = "$SLA_InfoIsExhibitionist"
        ElseIf option == setExposureOID
            infoText = "$SLA_InfoSetExposure"
        ElseIf option == arousalExposureRateOID
            infoText = "$SLA_InfoExposureRate"
        ElseIf option == setTimeRateOID
            infoText = "$SLA_InfoTimeRate"
        ElseIf option == genderPreferenceOID
            infoText = "$SLA_InfoGenderPreference"
        EndIf
        
    ElseIf 3 == pageId ; Armor

        If option == targetActorMenuOID
            InfoText = "$SLA_TargetActorMenuInfo"
        ElseIf option == sliderModeOID
            infoText = "$SLA_SliderModeInfo"
        ElseIf option == bodyItemOID
            infoText = "$SLA_BodyItemInfo"
        ElseIf option == noBodyItemOID
            infoText = "$SLA_NoBodyItemInfo"
        ElseIf option == nakedSliderOID
            infoText = "$SLA_NakedSliderInfo"
        ElseIf option == bikiniSliderOID
            infoText = "$SLA_BikiniSliderInfo"
        ElseIf option == sexySliderOID
            infoText = "$SLA_SexySliderInfo"
        ElseIf option == slootySliderOID
            infoText = "$SLA_SlootySliderInfo"
        ElseIf option == illegalSliderOID
            infoText = "$SLA_IllegalSliderInfo"
        ElseIf option == poshSliderOID
            infoText = "$SLA_PoshSliderInfo"
        ElseIf option == raggedSliderOID
            infoText = "$SLA_RaggedSliderInfo"

        ElseIf option == nakedToggleOID
            infoText = "$SLA_NakedToggleInfo"
        ElseIf option == bikiniToggleOID
            infoText = "$SLA_BikiniToggleInfo"
        ElseIf option == sexyToggleOID
            infoText = "$SLA_SexyToggleInfo"
        ElseIf option == slootyToggleOID
            infoText = "$SLA_SlootyToggleInfo"
        ElseIf option == illegalToggleOID
            infoText = "$SLA_IllegalToggleInfo"
        ElseIf option == poshToggleOID
            infoText = "$SLA_PoshToggleInfo"
        ElseIf option == raggedToggleOID
            infoText = "$SLA_RaggedToggleInfo"

        ElseIf option == footItemOID
            infoText = "$SLA_FootItemInfo"
        ElseIf option == noFootItemOID
            infoText = "$SLA_NoFootItemInfo"
        ElseIf option == heelsSliderOID
            infoText = "$SLA_HeelsSliderInfo"
        ElseIf option == heelsToggleOID
            infoText = "$SLA_HeelsToggleInfo"
        EndIf
        
    EndIf   
    
    SetInfoText(infoText)
     
EndEvent


Event OnOptionDefault(int option)

    If 0 == pageId ; Main
    
        If (option == NotificationKeyOID)
            notificationKey = 49 ; default value
            SetKeymapOptionValue(option, notificationKey)
            
        ElseIf (option == DesireSpellOID)
            IsDesireSpell = True
            SetToggleOptionValue(desireSpellOID, isDesireSpell)
            
        ElseIf (option == wantsPurgingOID)
            wantsPurging = False
            SetToggleOptionValue(wantsPurgingOID, wantsPurging)
            
        ElseIf (option == maleAnimationOID)
            maleAnimation = False
            SetToggleOptionValue(maleAnimationOID, maleAnimation)
            slaMain.SetIsAnimatingMales(maleAnimation As Int)
            
        ElseIf (option == femaleAnimationOID)
            femaleAnimation = False
            SetToggleOptionValue(femaleAnimationOID, femaleAnimation)
            slaMain.SetIsAnimatingFemales(femaleAnimation As Int)
            
        ElseIf (option == useLOSOID)
            useLOS = True
            SetToggleOptionValue(useLOSOID, useLOS)
            slaMain.setUseLOS(useLOS as Int)
            
        ElseIf (option == nakedOnlyOID)
            isNakedOnly = True
            SetToggleOptionValue(nakedOnlyOID, isNakedOnly)
            slaMain.setNakedOnly(isNakedOnly as Int)
            
        ElseIf (option == bDisabledOID)
            bDisabled = False
            SetToggleOptionValue(bDisabledOID, bDisabled)
            slaMain.setDisabled(bDisabled as Int)
            
        ElseIf (option == extendedNPCNakedOID)
            isExtendedNPCNaked = False
            SetToggleOptionValue(extendedNPCNakedOID, isExtendedNPCNaked)
            
        ElseIf (option == useSOSOID)
            isUseSOS = False
            SetToggleOptionValue(useSOSOID, isUseSOS)
            
        ElseIf (option == defaultExposureRateOID)
            defaultExposureRate = 2.0
            SetSliderOptionValue(defaultExposureRateOID, defaultExposureRate, "{1}")
            
        ElseIf (option == timeRateHalfLifeOID)
            timeRateHalfLife = 2.0
            SetSliderOptionValue(timeRateHalfLifeOID, 2.0, "{1}")

        ElseIf (option == MinimumTimeRateOID)
            MinimumTimeRate = 0
            SetSliderOptionValue(MinimumTimeRateOID, 0, "{1}")

        ElseIf (option == FatigueOID)
            Fatigue = 40
            SetSliderOptionValue(FatigueOID, Fatigue, 40, "{0}")

        ElseIf (option == FatigueMaleBonusOID)
            FatigueMaleBonus = 60
            SetSliderOptionValue(FatigueMaleBonusOID, FatigueMaleBonus, 60, "{0}")

        ElseIf (option == MBonUsesSLGenderOID)
            MBonUsesSLGender = True
            SetToggleOptionValue(MBonUsesSLGenderOID, MBonUsesSLGender)

        ElseIf (option == FatigueHalfLifeOID)
            FatigueHalfLife = 0.5
            SetSliderOptionValue(FatigueHalfLifeOID, 0.5, "{1}")

        ElseIf (option == FrustrationOID)
            Frustration = 5
            SetSliderOptionValue(FrustrationOID, Frustration, 5, "{0}")

        ElseIf (option == LewdModOID)
            LewdMod = 0
            SetSliderOptionValue(LewdModOID, LewdMod, 0, "{0}")

        ElseIf (option == FrustrationHalfLifeOID)
            FrustrationHalfLife = 1.0
            SetSliderOptionValue(FrustrationHalfLifeOID, 1.0, "{1}")

        ElseIf (option == FrustrationGrowthOID)
            FrustrationGrowth = 0.5
            SetSliderOptionValue(FrustrationGrowthOID, 0.5, "{1}")

        ElseIf (option == FrustrationGrowthThresholdOID)
            FrustrationGrowthThreshold = 90
            SetSliderOptionValue(FrustrationGrowthThresholdOID, 90, "{0}")

        ElseIf (option == FrustrationLossOID)
            FrustrationLoss = 100
            SetSliderOptionValue(FrustrationLossOID, 100, "{0}")

        ElseIf (option == TraumaOID)
            Trauma = 100
            SetSliderOptionValue(TraumaOID, 100, "{0}")

        ElseIf (option == MinStartArousalOID)
            MinStartArousal = 25
            SetSliderOptionValue(MinStartArousalOID, 25, "{0}")

        ElseIf (option == MinRapeStartArousalOID)
            MinRapeStartArousal = 50
            SetSliderOptionValue(MinRapeStartArousal, 50, "{0}")

        ElseIf (option == MasochismOID)
            Masochism = 5
            SetSliderOptionValue(MasochismOID, 5, "{0}")

        ElseIf (option == MasochismHalfLifeOID)
        	If TraumaHalfLife <= 2.0
	            MasochismHalfLife = 2.0
	            SetSliderOptionValue(MasochismHalfLifeOID, 2.0, "{1}")
	        Else
	            MasochismHalfLife = TraumaHalfLife
	            SetSliderOptionValue(MasochismHalfLifeOID, TraumaHalfLife, "{1}")
	        EndIf

        ElseIf (option == ExhibitionismOID)
            Exhibitionism = 5
            SetSliderOptionValue(ExhibitionismOID, 5, "{0}")

        ElseIf (option == ExhibitionismAdditionalOID)
            ExhibitionismAdditional = 2
            SetSliderOptionValue(ExhibitionismAdditionalOID, 2, "{0}")

        ElseIf (option == ExhibitionismCooldownOID)
            ExhibitionismCooldown = 120
            SetSliderOptionValue(ExhibitionismCooldownOID, 120, "{0}")

        ElseIf (option == ExhibitionismHalfLifeOID)
            ExhibitionismHalfLife = 2
            SetSliderOptionValue(ExhibitionismHalfLifeOID, 2, "{1}")

        ElseIf (option == ExhibitionismThresholdOID)
            ExhibitionismThreshold = 50
            SetSliderOptionValue(ExhibitionismThresholdOID, 50, "{0}")

        ElseIf (option == TraumaHalfLifeOID)
            TraumaHalfLife = 2.0
            SetSliderOptionValue(TraumaHalfLifeOID, 2.0, "{1}")

        ElseIf (option == MinDaysWithoutSexOID)
            MinDaysWithoutSex = 0.0
            SetSliderOptionValue(MinDaysWithoutSexOID, 0.0, "{1}")

        ElseIf (option == ExposureHalfLifeOID)
            ExposureHalfLife = 2.0
            SetSliderOptionValue(ExposureHalfLifeOID, 2.0, "{1}")
            
        ElseIf (option == sexOveruseEffectOID)
            sexOveruseEffect = 5
            SetSliderOptionValue(sexOveruseEffectOID, 5.0, "{0}")
            
        ElseIf (option == cellScanFreqOID)
            cellScanFreq = 120.0
            SetSliderOptionValue(cellScanFreqOID, cellScanFreq, "{1}")
        EndIf
    
    ElseIf 2 == pageId ; PuppetMaster
						
        If (option == blockArousalOID)
            Bool blockArousal = False
            SetToggleOptionValue(blockArousalOID, blockArousal)
            slaUtil.SetActorArousalBlocked(puppetActor, blockArousal)
            
        ElseIf (option == lockArousalOID)
            Bool lockArousal = False
            SetToggleOptionValue(lockArousalOID, lockArousal)
            slaUtil.SetActorArousalLocked(puppetActor, lockArousal)
            
        ElseIf (option == ExbitionistOID)
            Bool IsExbitionist = False
            slaUtil.SetActorExhibitionist(puppetActor, isExbitionist)
            SetToggleOptionValue(exbitionistOID, isExbitionist)
            
        ElseIf (option == SetExposureOID)
            Int exposure = 0
            slaUtil.SetActorExposure(puppetActor, exposure)
            SetSliderOptionValue(setExposureOID, exposure, "{0}")
            
        ElseIf (option == ArousalExposureRateOID)
            slaUtil.SetActorExposureRate(puppetActor, -200.0)
            SetSliderOptionValue(arousalExposureRateOID, slaUtil.GetActorExposureRate(puppetActor), "{1}")
            
        ElseIf (option == setTimeRateOID)
            slaUtil.SetActorTimeRate(puppetActor, 10.0)
            SetSliderOptionValue(setTimeRateOID, 10.0, "{0}")
            
        ElseIf (option == genderPreferenceOID)
            slaUtil.SetGenderPreference(puppetActor, -2)
            Int genderPreference = slaUtil.GetGenderPreference(puppetActor, True)
            SetMenuOptionValue(genderPreferenceOID, genderPreferenceList[genderPreference])
        EndIf
		
	EndIf
    
EndEvent


Function UpdateNakedKeywords(Armor item, Int value)
    _fw_utils.Spam("BEFORE AddNakedKeywords - value " + value + " : keyword present " + item.HasKeyword(wordNakedArmor))
    UpdateWearableState(item, keyNakedArmor, value)
    If value > 0
        KeywordUtil.AddKeywordToForm(item, wordNakedArmor)
    Else
        KeywordUtil.RemoveKeywordFromForm(item, wordNakedArmor)
    EndIf
    _fw_utils.Spam("AFTER AddNakedKeywords - value " + value + " : keyword present " + item.HasKeyword(wordNakedArmor))
EndFunction

Function UpdateBikiniKeywords(Form item, Int value)
    _fw_utils.Spam("BEFORE AddBikiniKeywords - value " + value + " : keyword present " + item.HasKeyword(wordBikiniArmor))
    UpdateWearableState(item, keyBikiniArmor, value)
    If value > 0
        KeywordUtil.AddKeywordToForm(item, wordBikiniArmor)
    Else
        KeywordUtil.RemoveKeywordFromForm(item, wordBikiniArmor)
    EndIf
    _fw_utils.Spam("AFTER AddBikiniKeywords - value " + value + " : keyword present " + item.HasKeyword(wordBikiniArmor))
EndFunction

Function UpdateSexyKeywords(Armor item, Int value)
    _fw_utils.Spam("BEFORE AddSexyKeywords - value " + value + " : keyword present " + item.HasKeyword(wordSexyArmor))
    UpdateWearableState(item, keySexyArmor, value)
    If value > 0
        KeywordUtil.AddKeywordToForm(item, wordSexyArmor)
    Else
        KeywordUtil.RemoveKeywordFromForm(item, wordSexyArmor)
    EndIf
    _fw_utils.Spam("AFTER AddSexyKeywords - value " + value + " : keyword present " + item.HasKeyword(wordSexyArmor))
EndFunction

Function UpdateSlootyKeywords(Armor item, Int value)
    UpdateWearableState(item, keySlootyArmor, value)
    If value > 0
        KeywordUtil.AddKeywordToForm(item, wordSlootyArmor)
    Else
        KeywordUtil.RemoveKeywordFromForm(item, wordSlootyArmor)
    EndIf
EndFunction

Function UpdateIllegalKeywords(Armor item, Int value)
    UpdateWearableState(item, keyIllegalArmor, value)
    If value > 0
        KeywordUtil.AddKeywordToForm(item, wordIllegalArmor)
    Else
        KeywordUtil.RemoveKeywordFromForm(item, wordIllegalArmor)
    EndIf
EndFunction

Function UpdatePoshKeywords(Armor item, Int value)
    UpdateWearableState(item, keyPoshArmor, value)
    If value > 0
        KeywordUtil.AddKeywordToForm(item, wordPoshArmor)
    Else
        KeywordUtil.RemoveKeywordFromForm(item, wordPoshArmor)
    EndIf
EndFunction

Function UpdateRaggedKeywords(Armor item, Int value)
    UpdateWearableState(item, keyRaggedArmor, value)
    If value > 0
        KeywordUtil.AddKeywordToForm(item, wordRaggedArmor)
    Else
        KeywordUtil.RemoveKeywordFromForm(item, wordRaggedArmor)
    EndIf
EndFunction

Function UpdateHeelsKeywords(Armor item, Int value)
    UpdateWearableState(item, keyKillerHeels, value)
    If value > 0
        KeywordUtil.AddKeywordToForm(item, wordKillerHeels)
    Else
        KeywordUtil.RemoveKeywordFromForm(item, wordKillerHeels)
    EndIf
EndFunction


Function UpdateWearableState(Form item, String keyValue, Int stateValue)

    If !item
        Return
    EndIf

    StorageUtil.SetIntValue(item, keyValue, stateValue)
    
    If stateValue > 0
        StorageUtil.FormListAdd(player, keyValue, item, False) ; no duplicates
        StorageUtil.FormListRemove(player, keyValue+"No", item, True) ; all instances
    Else
        StorageUtil.FormListAdd(player, keyValue+"No", item, False) ; no duplicates
        StorageUtil.FormListRemove(player, keyValue, item, True) ; all instances
    EndIf
    
EndFunction


Function RestoreKeywords(String keyValue, Keyword wordValue)

    Form[] addItems = StorageUtil.FormListToArray(player, keyValue)
    Form[] removeItems = StorageUtil.FormListToArray(player, keyValue+"No")
    
    If addItems
        KeywordUtil.AddKeywordToForms(addItems, wordValue)
    EndIf

    If removeItems
        KeywordUtil.RemoveKeywordFromForms(removeItems, wordValue)
    EndIf
    
EndFunction


Int Function ToggleBodyArmorValue(Int value, String keyTag)

    If value > 0
        value = 0
    Else
        value = 51
    EndIf
    StorageUtil.SetIntValue(bodyItem, keyTag, value)
    Return value
    
EndFunction


; Get a list of Armor items worn by the target actor - deprecated
; This is extremely SLOW due to all the GetWornForm calls.
; Retained only in case somebody is referencing it - it's not used here.
Form[] Function GetEquippedArmors(Actor who)

	Form[] armorList

	If !who
		Return armorList
	EndIf
	
    Int itemCount = slaSlotMaskValues.Length
	Int slot = 0
	While slot < itemCount
    
		Form slotForm = who.GetWornForm(slaSlotMaskValues[slot])
		
		If slotForm
            If armorList.Find(slotForm) < 0
                armorList = PapyrusUtil.PushForm(armorList, slotForm)
            EndIf
		EndIf
		
		slot += 1
        
	EndWhile
	
	Return armorList
    
EndFunction


Function InitSlotMaskValues()

	slaSlotMaskValues = new int[31]
    
	Int slotValue = 1
    
	Int ii = 0
	While ii < 31
		slaSlotMaskValues[ii] = slotValue
		slotValue *= 2
		ii += 1
	EndWhile
    
EndFunction


Function ResetPageNames()

	Pages = new String[4]
	Pages[0] = "$SLA_Settings"
	Pages[1] = "$SLA_Status"
	Pages[2] = "$SLA_PuppetMaster"
	Pages[3] = "$SLA_CurrentArmorList"

EndFunction


Function ResetKeys()

    keyNakedArmor = "SLAroused.IsNakedArmor"
    keyBikiniArmor = "SLAroused.IsBikiniArmor"
    keySexyArmor = "SLAroused.IsSexyArmor"
    keySlootyArmor = "SLAroused.IsSlootyArmor"
    keyIllegalArmor = "SLAroused.IsIllegalArmor"
    keyPoshArmor = "SLAroused.IsPoshArmor"
    keyRaggedArmor = "SLAroused.IsRaggedArmor"
    keyKillerHeels = "SLAroused.IsKillerHeels"
    
    pageKeys = new String[8]
    pageKeys[0] = keyNakedArmor
    pageKeys[1] = keyBikiniArmor
    pageKeys[2] = keySexyArmor
    pageKeys[3] = keySlootyArmor
    pageKeys[4] = keyIllegalArmor
    pageKeys[5] = keyPoshArmor
    pageKeys[6] = keyRaggedArmor
    pageKeys[7] = keyKillerHeels
    
EndFunction


Function ResetKeywords()

    wordNakedArmor   = Keyword.GetKeyword("EroticArmor")
    wordBikiniArmor  = Keyword.GetKeyword("SLA_ArmorHalfNakedBikini")
    wordSexyArmor    = Keyword.GetKeyword("SLA_ArmorPretty")
    wordSlootyArmor  = Keyword.GetKeyword("SLA_ArmorHalfNaked")
    wordIllegalArmor = Keyword.GetKeyword("SLA_ArmorIllegal")
    wordPoshArmor    = Keyword.GetKeyword("ClothingRich")
    wordRaggedArmor  = Keyword.GetKeyword("ClothingPoor")
    wordKillerHeels  = Keyword.GetKeyword("SLA_KillerHeels")

EndFunction


Function ResetGenderPreferenceList()

    genderPreferenceList = new String[4]
    genderPreferenceList[0] = "$SLA_Male"
    genderPreferenceList[1] = "$SLA_Female"
    genderPreferenceList[2] = "$SLA_Both"
    genderPreferenceList[3] = "$SLA_UseSexLab"

EndFunction


; Remove a form from an array - deprecated
; Retained only in case somebody is referencing it - it's not used here.
Form[] Function RemoveForm(Form item, Form[] itemList)

    Return PapyrusUtil.RemoveForm(itemList, item)

EndFunction


Function ResetConstants()

    player = Game.GetPlayer()
    ResetPageNames()
    ResetGenderPreferenceList()
    ResetKeys()
    ResetKeywords()
    
EndFunction
