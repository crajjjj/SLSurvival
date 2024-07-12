Scriptname _DFlowMCM extends  SKI_ConfigBase Conditional

; Order properties by type ... it's not ideal, but it's better than nothing to help find them

; FOLDSTART - ReferenceAlias Properties
ReferenceAlias Property Follower Auto ; The follower alias on _DFlow '_DMaster' - use this for everything.
ReferenceAlias Property MCMFollower Auto ; The follower alias on the MCM quest - which has no reason to exist and is just a source of bugs.
ReferenceAlias Property Scan Auto
; FOLDEND - ReferenceAlias Properties

Bool Property FNISCompatibility Auto

; FOLDSTART - Quests
QF__Gift_09000D62 Property Q  Auto  
_Dtick Property Tick Auto
_DFTools Property Tool Auto
_DFPotionQuest Property DFPotQ Auto
_DFGoldConQScript Property GoldCont  Auto  
QF__DflowDealController_0A01C86D Property DC Auto
_DFSold Property DSold Auto
_DFlowModDealController Property MDC Auto
_DflowSleepQuestScript  Property SQ Auto
_DFlowUnflaggedFollowerScan Property UnflaggedFollowersScan Auto
_LDC Property LDC Auto
DialogueFollowerScript Property VanillaFollowerQuest Auto 
_DFLicensing Property _DFLicenses Auto

Quest Property Dflow  Auto  ; Same quest as Q ...
Quest Property DealO  Auto 
Quest Property DealB  Auto 
Quest Property DealH  Auto 
Quest Property DealP  Auto 
Quest Property DealS  Auto 
Quest Property DealController  Auto 
Quest Property Games  Auto 
Quest Property SEvents  Auto 
Quest Property DS1  Auto 
Quest Property DS2  Auto 
Quest Property DSB  Auto 
Quest Property BoredomQuest Auto
Quest Property ForcedStart Auto ; This didn't get set originally, so it's now useless...
Quest Property _DFlowGames Auto
QF__DFlowForcedStart_081ABD14 Property _DFlowForcedStart Auto ; Above replaced with this.
; FOLDEND - Quests

; FOLDSTART - Miscellaneous Property Types
Message Property _DFScan Auto
Message Property _DFScan2 Auto
Message Property Reseted Auto

Faction Property _DFMaster Auto
Faction Property _DFDisable Auto
Faction Property CurrentFollowerFaction Auto
Faction Property DismissedFollowerFaction Auto
Faction Property PotentialFollowerFaction Auto
Faction Property EnabledFollowerFaction Auto ; Followers that won't be picked up in an all followers marked ignored scan. Doesn't make an ignored follower not ignored.
Faction Property HirelingFollowerFaction Auto

FormList Property _DFPauseModsList Auto
MiscObject Property _DFDebt001 Auto
Actor Property PlayerRef Auto
Actor Property FActor Auto
; FOLDEND - Miscellaneous Property Types
; FOLDSTART - String Properties
String _DFKeyDiffS = "$DF_KEYDIF_NORMAL"
String _DFRemovalModeS = "$DF_REMOVAL_FULL"
String[] DealInfos

String Property ForcedDeal Auto
; FOLDEND - String Properties
; FOLDSTART - Int Properties
Int Property SexPreferenceIndex Auto
Int Property DismissalIndex Auto
Int Property DealOstage Auto
Int Property DealBstage Auto
Int Property DealHstage Auto
Int Property DealPstage Auto
Int Property DealSstage Auto
Int Property _DFMinStolenPer = 5 Auto
Int Property _DFMaxStolenPer = 40 Auto
Int Property clevel = 0 Auto 
Int Property _DFKeyDiffI = 1 Auto
Int Property _DFRemovalMode = 0 Auto Conditional
Int Property _DFMaxResistMCM Auto
Int Property _DFMaxResistMin Auto
Int Property _DFWillRegainMode = 0 Auto ; Not used at this time.
Int Property DebtDifficulty = 3 Auto
; FOLDEND - Int Properties
; FOLDSTART - Bool Properties
Bool Property _DFDealSCustArmor Auto
Bool Property _DFWillBool = True Auto
Bool Property _DFTheifsBool = False Auto
Bool Property _DFChaoConcealed = False Auto
Bool Property _DFChaoGo = False Auto
Bool Property _DFLocNoti = True Auto Conditional
Bool Property _DFAnimalCont = True Auto Conditional
Bool Property _DFShowRollMsg = False Auto
Bool Property _DFZAZAutoPause = False Auto
Bool Scan = False
Bool Property _DFMaxResistDevices Auto 
Bool Property _DFMaxResistDeal Auto ; unused
Bool Property _DFDealEffectWill Auto  ; unused
Bool Property SkipToTheEnd Auto Conditional
Bool Property IsPaused Auto Conditional
; FOLDEND - Bool Properties
; FOLDSTART - Float Properties
Float Property _DFDebtMaxPL = 0.0 Auto ; unused
Float Property _DFDebtMinPL = 0.0 Auto ; unused
Float Property _DFRemovalMultiMax = 0.0 Auto ; unused
Float Property _DFRemovalMultiMin = 0.0 Auto ; unused

Float Property CustomDifficultyCurve = 0.5 Auto ; => _DflowDebtExponent
Float Property DealEarlyMulti = 500.0 Auto ; => _DflowDealMulti
Float Property PunishmentDebt = 100.0 Auto ; => _DFPunDebt
Float Property DeviceRemovalFirst = 100.0 Auto ; => _DflowRemovalBasePrice
Float Property DeviceRemovalInc = 50.0 Auto ; => _DFlowRemovalInc
Float Property DealDurationDays = 2.0 Auto ; => _DflowDealBaseDays
Float Property FollowerLivesMax = 11.0 Auto ; => MLives
Float Property MinWillRegain = 2.0 Auto
Float Property MaxWillRegain = 7.0 Auto
Float Property WillRegainEase = 1.2 Auto
Float Property SpankingCooldownHours = 3.5 Auto

Float Property _DFSWeightD = 50.0 Auto
Float Property _DFSWeightE = 50.0  Auto
Float Property _DFSWeightED = 50.0 Auto
Float Property _DFKConceal = 0.3 Auto
Float Property _DFResistanceWillDelta = 0.0 Auto
Float Property _DFResistanceDealDelta = 0.0 Auto
Float Property _DFResistanceLevelDelta = 0.0 Auto

Float Property DebtPerDayLoLevel = 250.0 Auto
Float Property DebtPerDayHiLevel = 12000.0 Auto
Float Property EnslavementDebtScale = 5.0 Auto
Float Property FreedomCostScale = 5.0 Auto
Float Property FailureScale = 10.0 Auto
Float Property BaseDebtRelief = 200.0 Auto ; Percentage of daily cost relieved by deal
Float Property BaseDebtBuyout = 100.0 Auto ; Percentage of daily cost to buyout of deal once expired
; FOLDEND - Float Properties
; FOLDSTART - Chaos
Float Property _DFChaosPercent = 40.0 Auto 
Float Property _DFChaosDays = 1.0 Auto
Float Property _DFChaosTimer = 0.0 Auto

Float Property _DFDebtperdayMax = 10.0 Auto ; Daily debt scale range
Float Property _DFDebtperdayMin = 0.1 Auto
Float Property _DFPunDebtMax = 10.0 Auto ; punishment debt scale
Float Property _DFPunDebtMin = 0.1 Auto
Float Property _DFRemovalMax = 10.0 Auto ; Removal cost scale range
Float Property _DFRemovalMin = 0.1 Auto
Float Property _DFRemovalIncMax = 10.0 Auto ; removal increment scale range
Float Property _DFRemovalIncMin = 0.1 Auto
Float Property _DFDealsMaxDebt = 10.0 Auto ; debt relief
Float Property _DFDealsMinDebt = 0.1 Auto
Float Property _DFDealsMaxPrice = 10.0 Auto ; debt buyout
Float Property _DFDealsMinPrice = 0.1 Auto
Float Property _DFDealsMaxPTime = 100.0 Auto ; deal duration
Float Property _DFDealsMinPTime = 0.0 Auto
Float Property _DFDealsMaxMulti = 10.0 Auto ; premature payoff scale
Float Property _DFDealsMinMulti = 1.0 Auto
Float Property _DFLivesChaoMax = 21.0 Auto ; lives
Float Property _DFLivesChaoMin = 6.0 Auto

Float Property ChaosDailyDebt = 1.0 Auto
Float Property ChaosPunishmentDebt = 1.0 Auto
Float Property ChaosDeviceRemovalFirst = 1.0 Auto
Float Property ChaosDeviceRemovalInc = 1.0 Auto
Float Property ChaosDealRelief = 1.0 Auto
Float Property ChaosDealBuyout = 1.0 Auto
Float Property ChaosDealEarlyMulti = 5.0 Auto
Float Property ChaosDealDurationDays = 2.0 Auto
Float Property ChaosFollowerLivesMax = 11.0 Auto ; => MLives and Lives
Float Property PauseTimerElapsed Auto ; For saving the main debt-update timer

; FOLDEND - Chaos
; FOLDSTART - GlobalVariable Properties
GlobalVariable Property _DFSoldDeals Auto
GlobalVariable Property HEDebt  Auto  

GlobalVariable Property DebtPerDay Auto   ; This is always a derived value
GlobalVariable Property DebtPerLevel Auto ; This now means something ... different ... it's a derived value
GlobalVariable Property _DflowDebtExponent Auto ; New - the power factor for debt calculation
GlobalVariable Property _DFPunDebt  Auto  ; Derived from PunishmentDebt, ChaosPunishmentDebt and DailyDebt

GlobalVariable Property _DflowDealBaseDebt Auto     ; The calculated debt relief amount
GlobalVariable Property _DflowDealBasePrice Auto    ; The calculated amount you pay back
GlobalVariable Property _DflowDealMulti Auto        ; Early buyout scale percentage
GlobalVariable Property _DFDeepDebtDifficulty Auto  ; Multiplier to deep debt extra cost.

GlobalVariable Property _DFlowRemovalDebtTimes Auto  ; No chaos value for this
GlobalVariable Property _DflowRemovalBasePrice Auto  ; Comes from DeviceRemovalFirst and ChaosDeviceRemovalFirst
GlobalVariable Property _DFlowRemovalInc Auto        ; Comes from DeviceRemovalInc and ChaosDeviceRemovalInc
GlobalVariable Property _DflowDealBaseDays Auto     ; Comes from ChaosDealDurationDays OR DealDurationDays

GlobalVariable Property EnslavementDebt Auto ; Derived
GlobalVariable Property FreedomCost Auto ; Derived
GlobalVariable Property Failure Auto ; Derived

GlobalVariable Property _DFlowItemsPerRemoved Auto  
GlobalVariable Property _DFlowGambleJPot Auto  
GlobalVariable Property _DflowEndlessMode Auto  
GlobalVariable Property _DFlowWarmComp  Auto  

GlobalVariable Property Intrest Auto
GlobalVariable Property Pause Auto
GlobalVariable Property Reset Auto ; This seems to serve no useful purpose
GlobalVariable Property QuestStage Auto ; This is used on PAUSE.
GlobalVariable Property DebtPollhrs Auto
GlobalVariable Property ETimerp Auto
GlobalVariable Property Dia Auto
GlobalVariable Property Debt Auto
GlobalVariable Property Tats Auto
GlobalVariable Property Resist Auto
GlobalVariable Property Will Auto
GlobalVariable Property ADFD Auto

GlobalVariable Property EnslavePerLevel Auto
GlobalVariable Property DebtPerFollower Auto
GlobalVariable Property Lives Auto
GlobalVariable Property LivesM Auto
GlobalVariable Property DfcSlaveryChance Auto
GlobalVariable Property LolaChance Auto
GlobalVariable Property SSO Auto
GlobalVariable Property GameDaysPassed Auto
GlobalVariable Property _DFLivesFollowerRape Auto
GlobalVariable Property _DFMinimumContract Auto
GlobalVariable Property _DFMinimumContractRemaining Auto
GlobalVariable Property _DFHardcoreMode Auto
GlobalVariable Property _DFFatigue Auto
GlobalVariable Property _DFFatigueRate Auto
GlobalVariable Property _DFDailyDebtIncrement Auto
GlobalVariable Property _DFBoredom Auto
GlobalVariable Property _DFBoredomIntervalDays Auto
GlobalVariable Property _DFBoredomTimer Auto
GlobalVariable Property _DFDiscountLimit Auto
GlobalVariable Property _DFExpectedDealCount Auto
GlobalVariable Property _DFExpectedDealLimit Auto
GlobalVariable Property _DFGoldPerFatigue Auto
GlobalVariable Property _DFFollowerCount Auto
GlobalVariable Property _DFDailyDebtAdjust Auto
GlobalVariable Property _DFAllowForceStart Auto
GlobalVariable Property _DFResistanceBroken Auto
GlobalVariable Property _DFDismissRule Auto

GlobalVariable Property _DFModSkoomaWhorePresent Auto
GlobalVariable Property _DFModMmePresent Auto
GlobalVariable Property _DFModSLSPresent Auto
; FOLDEND - GlobalVariable Properties

; FOLDSTART - Internal variables
String[] sexPreferenceOptions
String[] dismissalOptions
String _currentLocationType
String File
Int flags = 1
Float[] Logs
Float[] debtExponents
String[] debtExponentNames

Int exploreDifficulty
Float exploreLoPrice
Float exploreHiPrice
Float exploreExponent

Bool chaosModified
Bool licenseStatusEnabledNew
; FOLDEND - Internal variables

; FOLDSTART - Version Functions
Float Property Version = 0.0 Auto

Function LoadMCMSettings()
    Debug.Notification("Loading MCM Settings")
EndFunction

String Function GetScriptVersionName()
    ; e.g. 2.12
    Return Tick.GetScriptVersionName()
EndFunction

Int Function GetScriptVersion()
    ; e.g. 21200
    Return Tick.GetScriptVersion()
EndFunction

Float Function GetDFVersion()
    Return (GetScriptVersion() As Float) / 100.0
EndFunction

Bool Function IsDebug()
    Return True
EndFunction
; FOLDEND - Version Functions

Event OnConfigInit()

    ; Version is an integer, though the var is a float
    ; e.g. for 2.12 Version is 212
    Version = GetDFVersion()
    SetMenuNames()
    ResetAllOIDs()
    
    _DFResistanceWillDelta = 0.0
    _DFResistanceDealDelta = 0.0
    _DFResistanceLevelDelta = 0.0
    _DFDealEffectWill = False ; unused
    _DFMaxResistDeal = False ; unused
    MDC.Update()

    SetupDebtDifficulty()
    
EndEvent

Event OnConfigOpen()
    Debug.TraceConditional("DF - OnConfigOpen - start", True)
    licenseStatusEnabledNew = _DFLicenses.Enabled
    Debug.TraceConditional("DF - OnConfigOpen - licenses enabled on " + _DFLicenses + " is " + licenseStatusEnabledNew, True)
    Debug.TraceConditional("DF - OnConfigOpen - end", True)
    SetMenuNames()
EndEvent

Event OnConfigClose()

    Debug.TraceConditional("DF - OnConfigClose - start", True)

    If Version != GetDFVersion() 
        Debug.TraceConditional("DF - OnConfigClose - wrong version - UpdateMCM", True)
        UpdateMCM()
        Return
    EndIf

    _DFLicenses.Enabled = licenseStatusEnabledNew
    Debug.TraceConditional("DF - OnConfigClose - licenses enabled on " + _DFLicenses + " is now " + licenseStatusEnabledNew, True)

    If chaosModified
        chaosModified = False
        Chaos(True)
    EndIf
    CalculateScaledDebts()
    
    ; It's easier just to always re-pick, because there are so many places this can be impacted.
    DC.PickRandomDeal()
    Debug.TraceConditional("DF - OnConfigClose - end", True)
    
EndEvent

Function UpdateMCM()

    ; This will work with up to two digits of point release.
    If Version < 212.0
        SetupDebtDifficulty()
    EndIf

    If Version < 213.3
        SexPreferenceIndex = 0
        Tool.SetScanGenders(SexPreferenceIndex)
    EndIf
    
    If Version < 213.5
        DismissalIndex = 0
        SetDismissalRules(DismissalIndex)
        ; Repair missing globals in _DFlow
        Q.SSO = SSO
        Q._Dtats = Tats
    EndIf
    
    Version = GetDFVersion()
    SetMenuNames()
    They()
    DC._DFFatigue = _DFFatigue
    DC._DFFatigueRate = _DFFatigueRate
    MDC.Update()
    Q.UpdateVersion()
    ResetAllOIDs()
    Utility.wait(5)
    ; seems the wrong place, but it ensures the player sees the message.
    Debug.Notification("$DF_UPDATING")
    Debug.Notification("Devious Followers V" + GetScriptVersionName()) ; Tried using {} in this to localize. DID NOT WORK! Either I'm dumb, or Debug.Notification is not *quite* the same as normal menu items.
    
EndFunction


Function SetMenuNames()

    Pages = new String[14]
    Pages[0] = "$DF_STATS"
    Pages[1] = "$DF_GENERAL"
    Pages[2] = "$DF_WILLPOWER"
    Pages[3] = "$DF_COSTS"
    Pages[4] = "Rules"
    Pages[5] = "Rule Settings"
    Pages[6] = "$DF_PUNISHMENTS"
    Pages[7] = "$DF_CHAOSM"
    Pages[8] = "$DF_MISC"
    Pages[9] = "$DF_OTHER"
    Pages[10] = "$DF_COST_EXPLORER"
    Pages[11] = "$DF_DEBUG"
    Pages[12] = "$DF_HELP"

    DealInfos = New String[20] ; classic deal info
    DealInfos[ 0] = "$DF_RULE_B_1"
    DealInfos[ 1] = "$DF_RULE_B_2"
    DealInfos[ 2] = "$DF_RULE_B_3"
    DealInfos[ 3] = "$DF_RULE_B_4"
    DealInfos[ 4] = "$DF_RULE_H_1"
    DealInfos[ 5] = "$DF_RULE_H_2"
    DealInfos[ 6] = "$DF_RULE_H_3"
    DealInfos[ 7] = "$DF_RULE_H_4"
    DealInfos[ 8] = "$DF_RULE_O_1"
    DealInfos[ 9] = "$DF_RULE_O_2"
    DealInfos[10] = "$DF_RULE_O_3"
    DealInfos[11] = "$DF_RULE_O_4"
    DealInfos[12] = "$DF_RULE_P_1"
    DealInfos[13] = "$DF_RULE_P_2"
    DealInfos[14] = "$DF_RULE_P_3"
    DealInfos[15] = "$DF_RULE_P_4"
    DealInfos[16] = "$DF_RULE_S_1"
    DealInfos[17] = "$DF_RULE_S_2"
    DealInfos[18] = "$DF_RULE_S_3"
    DealInfos[19] = "$DF_RULE_S_4"
    
EndFunction


Function SetupDebtDifficulty()

    debtExponentNames = New String[8]
    debtExponentNames[0] = "$DF_DIFF_EASIEST"
    debtExponentNames[1] = "$DF_DIFF_VERY_EASY"
    debtExponentNames[2] = "$DF_DIFF_EASY"
    debtExponentNames[3] = "$DF_DIFF_MODERATE"
    debtExponentNames[4] = "$DF_DIFF_HARD"
    debtExponentNames[5] = "$DF_DIFF_VERY_HARD"
    debtExponentNames[6] = "$DF_DIFF_MAXIMUM"
    debtExponentNames[7] = "$DF_DIFF_CUSTOM"
    debtExponents = New Float[8]
    debtExponents[0] = 2.63
    debtExponents[1] = 2.17
    debtExponents[2] = 1.82
    debtExponents[3] = 1.54
    debtExponents[4] = 1.33
    debtExponents[5] = 1.16
    debtExponents[6] = 1.0
    debtExponents[7] = 0.75

    DebtDifficulty = 3

    _DflowDebtExponent.SetValue(debtExponents[3])
    ; These have all been converted to percentages of daily debt
    DealEarlyMulti = 500.0
    PunishmentDebt = 100.0
    DeviceRemovalFirst = 100.0
    DeviceRemovalInc = 50.0
    DealDurationDays = 2.0
    FollowerLivesMax = 11.0

    _DFlowRemovalDebtTimes.SetValue(115.0)
    
    _DflowDealBaseDebt.SetValue(200.0) ; Debt relief
    _DflowDealBasePrice.SetValue(100.0) ; Buyout
    
    DebtPerDayLoLevel = 250.0
    DebtPerDayHiLevel = 12000.0
    EnslavementDebtScale = 5.0
    FreedomCostScale = 5.0
    FailureScale = 10.0
    BaseDebtRelief = 200.0
    BaseDebtBuyout = 100.0
    
    _DFChaosPercent = 40.0
    _DFChaosDays = 1.0
    _DFDebtperdayMax = 10.0 ; Daily debt scale range
    _DFDebtperdayMin = 0.1
    _DFPunDebtMax = 10.0 ; punishment debt scale
    _DFPunDebtMin = 0.1
    _DFRemovalMax = 10.0 ; Removal cost scale range
    _DFRemovalMin = 0.1
    _DFRemovalIncMax = 10.0 ; removal increment scale range
    _DFRemovalIncMin = 0.1
    _DFDealsMaxDebt = 10.0 ; debt relief
    _DFDealsMinDebt = 0.1
    _DFDealsMaxPrice = 10.0 ; debt buyout
    _DFDealsMinPrice = 0.1
    _DFDealsMaxPTime = 100.0 ; deal duration
    _DFDealsMinPTime = 1.0
    _DFDealsMaxMulti = 10.0 ; premature payoff scale
    _DFDealsMinMulti = 1.0
    _DFLivesChaoMax = 21.0 ; lives
    _DFLivesChaoMin = 6.0
    
    MinWillRegain = 2.0
    MaxWillRegain = 7.0
    WillRegainEase = 1.2

    exploreDifficulty = DebtDifficulty
    exploreLoPrice = DebtPerDayLoLevel
    exploreHiPrice = DebtPerDayHiLevel
    exploreExponent = debtExponents[exploreDifficulty]
    
    BuildLogTable()
    Chaos(True)
    CalculateScaledDebts()
    
EndFunction

Event OnPageReset(String page)
    If Version != GetDFVersion() 
        AddHeaderOption("$DF_UPDATE_REQUIRED")
        ResetAllOIDs()
        Return
    EndIf

    SetCursorFillMode(TOP_TO_BOTTOM)
    SetCursorPosition(0)
    
    Float delayTime = Utility.GetCurrentGameTime() + 0.04
    If Q.Delay > delayTime ; Prevent this having some huge value that we never reach.
        Q.Delay = delayTime  ; This is a delay that cooldowns normal recruitment, but reset it here as it may resolve some player bugs
    EndIf

    Bool mcmLocked = _DFHardcoreMode.GetValue() > 0.0

    ; FOLDSTART - Stats
    If page == "" || page == "$DF_STATS"
        DoStatsPageMenu()
    EndIf
    ; FOLDEND - Stats
    ; FOLDSTART - General
    If page == "$DF_GENERAL"
        If mcmLocked
            AddHeaderOption("$DF_MCM_LOCKED_HEADER")
        Else
            DoGeneralPageMenu()
        EndIf
    EndIf
    ; FOLDEND - General
    ; FOLDSTART - Willpower
    If page == "$DF_WILLPOWER"
        If mcmLocked
            AddHeaderOption("$DF_MCM_LOCKED_HEADER")
        Else
            DoWillpowerPageMenu()
        EndIf
    EndIf
    ; FOLDEND - Willpower
    ; FOLDSTART - Costs
    If page == "$DF_COSTS"
        If mcmLocked
            AddHeaderOption("$DF_MCM_LOCKED_HEADER")
        Else
            DoCostsPageMenu()
        EndIf
    EndIf
    ; FOLDEND - Costs
    
    ; FOLDSTART - Modular Deal Settings
    If page=="Rules"
        If mcmLocked
            AddHeaderOption("$DF_MCM_LOCKED_HEADER")
        Else
            groupNames = DealManager.GetPackNames()
            if groupIndex >= groupNames.length
                groupIndex = 0
            endIf
            DoModularDealsPageMenu()
        EndIf
    EndIf
    ; FOLDEND - Modular Deals

    ; FOLDSTART - Deal Options
    If page == "Rule Settings"
        If mcmLocked
            AddHeaderOption("$DF_MCM_LOCKED_HEADER")
            ;/ Custom whore armor - replicated from below because we want to be able to change this even in HARDCORE mode.
            AddEmptyOption()
            AddHeaderOption("$DF_SIGNCA_HEADER")
            OID_DFDealSCustArmorTog = AddToggleOption("$DF_SIGNCA",_DFDealSCustArmor)
            /;
        Else
            DoDealsPageMenu()
        EndIf
    EndIf
    ; FOLDEND - Deal Options

    ; FOLDSTART - Punishments
    If page == "$DF_PUNISHMENTS"
        If mcmLocked
            AddHeaderOption("$DF_MCM_LOCKED_HEADER")
        Else
            DoPunishmentsPageMenu()
        EndIf
    EndIf
    ; FOLDEND - Punishments
    ; FOLDSTART - Chaos
    If page == "$DF_CHAOSM"
        If mcmLocked
            AddHeaderOption("$DF_MCM_LOCKED_HEADER")
        Else
            DoChaosPageMenu()
        EndIf
    EndIf
    ; FOLDEND - Chaos
    ; FOLDSTART - Misc - Additional Content
    If page == "$DF_MISC"
            If mcmLocked
            AddHeaderOption("$DF_MCM_LOCKED_HEADER")
        Else
            DoMiscAdditionalContentPageMenu()
        EndIf
    EndIf
    ; FOLDEND - Misc - Additional Content
    ; FOLDSTART - Other Mod Settings
    If page == "$DF_OTHER"
        DoOtherModSettingsPageMenu()
    EndIf
    ; FOLDEND - Other
    ; FOLDSTART - Cost Explorer
    If page == "$DF_COST_EXPLORER"
        If mcmLocked
            AddHeaderOption("$DF_MCM_LOCKED_HEADER")
        Else
            DoCostExplorerPageMenu()
        EndIf
    EndIf
    ; FOLDEND - Cost Explorer
    ; FOLDSTART - Debug
    If page == "$DF_DEBUG"
        DoDebugPageMenu()
    Endif
    ; FOLDEND - Debug
    ; FOLDSTART - Debug
    If page == "$DF_HELP"
        DoHelpPageMenu()
    Endif
    ; FOLDEND - Debug
EndEvent

String Function Uppercase(string c)
    string u = c
    if c == "a"
        u = "A"
    elseIf c == "b"
        u = "B"
    elseIf c == "o"
        u = "O"
    elseIf c == "w"
        u = "W"
    endif

    return u
EndFunction

String Function Capitalize(string text) 
    return Uppercase(StringUtil.GetNthChar(text, 0)) + StringUtil.Substring(text, 1, StringUtil.GetLength(text))
EndFunction

Function DoStatsPageMenu()
    SetCursorFillMode(LEFT_TO_RIGHT)
    AddHeaderOption("$DF_WELCOME")
    AddHeaderOption("Version " + GetScriptVersionName())

	If 0.0 == Pause.GetValue() ; PAUSED
		AddTextOption("$PAUSE_DISABLED_STATS", "")
		Return
	EndIf
   
    int debtVal = Debt.GetValue() As Int

    if GoldCont.Credit > 0 && !GoldCont.Enabled
        debtVal = -GoldCont.Credit
    endIf

    If GoldCont.Enabled
        OID_DebtText = AddTextOption("$DF_DEBT", "$DF_IN_GOLD_CONTROL")
    ElseIf Lives.GetValue() <= 0.0
        OID_DebtText = AddTextOption("$DF_DEBT", "$DF_FOLLOWER_ANGRY")
    Else
        OID_DebtText = AddTextOption("$DF_DEBT", debtVal)
    EndIf
    AddTextOption("$DF_DEBTDAILY", FormatFloat_N0(DebtPerDay.GetValue()))

    
    String contractText = "$DF_NONE"
    Float contractRemaining = _DFMinimumContractRemaining.GetValue()
    If contractRemaining >= 2.0
        contractText = ((contractRemaining As Int) As String) + " days"
    ElseIf contractRemaining >= 1.0
        contractText = "$DF_DAYPLUS"
    ElseIf contractRemaining > 0.0
        contractText = "$DF_DAYLESS"
    EndIf
    OID_ContractRemaining = AddTextOption("$DF_CONTRACTREMAIN", contractText)
    
    
    Float debtAdjust = _DFDailyDebtAdjust.GetValue()
    Float dealCount = (DealController As  QF__DflowDealController_0A01C86D).Deals As Float
    Float reduction = dealCount * 10.0 ; TICK
    Float dealScale = (100.0 + debtAdjust) - reduction
    ; Make discountLimit negative
    Float discountLimit = 100.0 * (1.0 - _DFDiscountLimit.GetValue())
    If dealScale < discountLimit
        dealScale = discountLimit
    ElseIf dealScale > 200.0 ; Also impose a penalty limit
        dealScale = 200.0
    EndIf
    
    ; dealScale of 200.0 = -100% discount, 100.0 = 0% discount, 0.0 = 100% discount
    
    Float discount = 100.0 - dealScale
    
    OID_DiscountText = AddTextOption("$DF_DISCOUNT", (discount As Int) + "%")
    
    OID_WillText = AddTextOption("$DF_WILLPOWER", Will.GetValue() As Int)
    OID_ResistText = AddTextOption("$DF_RESIST", Resist.GetValue() As Int)

    Float boredValue = _DFBoredom.GetValue()
    OID_BoredomText = AddTextOption("$DF_BOREDOM", FormatFloat_N1(boredValue)) 
    OID_FatigueText = AddTextOption("$_DFFatigue", _DFFatigue.GetValue() As Int)

    OID_ActualDealCountText = AddTextOption("$DF_DEAL_COUNT", DC.Deals)
    OID_ExpectedDealCountText = AddTextOption("$DF_EXPECTED_DEAL_COUNT", _DFExpectedDealCount.GetValue() As Int)
    
    Actor currentMaster = Follower.GetActorReference()
    If currentMaster
        AddTextOption("$DF_CURRENT_DF", currentMaster.GetBaseObject().GetName(), OPTION_FLAG_DISABLED)
    Else
        AddTextOption("$DF_NO_DF", "", OPTION_FLAG_DISABLED)
    EndIf
    Actor currentVanilla = VanillaFollowerQuest.pFollowerAlias.GetActorRef()
    If currentVanilla
        AddTextOption("$DF_CURRENT_VANILLA", currentVanilla.GetBaseObject().GetName(), OPTION_FLAG_DISABLED)
    Else
        ;AddTextOption("$DF_NO_VANILLA", "", OPTION_FLAG_DISABLED)
        AddEmptyOption()
    EndIf

   
    ; DEAL DISPLAYS
    string[] dealNames = DealManager.GetDeals()

    int half = dealNames.length / 2
    int i = 0

    SetCursorFillMode(LEFT_TO_RIGHT)
    AddHeaderOption("Active Deals")
    AddHeaderOption("")
    
    SetCursorFillMode(TOP_TO_BOTTOm)
    
    if dealNames.length == 0
        AddTextOption("None active", "")
    endIf

    while i < half
        ShowDeal(dealNames[i])
        i += 1
    endWhile
    
    SetCursorPosition(17)
    while i < dealNames.length
        ShowDeal(dealNames[i])
        i += 1
    endWhile
EndFunction

Function ShowDeal(string deal)
    AddHeaderOption(" " + deal)
    string[] rules = DealManager.GetDealRules(deal)
    int i = 0
    while i < rules.length
        AddTextOption(DealManager.GetRuleName(rules[i]), DealManager.GetRuleDesc(rules[i]))
        i += 1
    endWhile
    
EndFunction

Function DoGeneralPageMenu()
    AddHeaderOption("$DF_TITLE")

    Int minimumContractFlags = OPTION_FLAG_NONE
    If Q.GetStage() >= 10
        minimumContractFlags = OPTION_FLAG_DISABLED
    EndIf
    OID_MinimumContractSlider = AddSliderOption("$DF_MINIMUMCONTRACT", _DFMinimumContract.GetValue(), "$DF_0", minimumContractFlags)

    OID_DebtDifficulty = AddMenuOption("$DF_DEBT_DIFFICULTY", debtExponentNames[DebtDifficulty])
    Int editCurve = OPTION_FLAG_DISABLED
    If 7 == DebtDifficulty
        editCurve = OPTION_FLAG_NONE
    EndIf
    OID_CustomCurve = AddSliderOption("$DF_CUSTOM_CURVE", CustomDifficultyCurve, "$DF_2", editCurve)

    AddEmptyOption()
    OID_DebtPerDayLoLevel = AddSliderOption("$DF_DEBT_PER_DAY_LO", DebtPerDayLoLevel, "$DF_0")
    OID_DebtPerDayHiLevel = AddSliderOption("$DF_DEBT_PER_DAY_HI", DebtPerDayHiLevel, "$DF_0")
    
    AddEmptyOption()
    AddHeaderOption("$DF_FOLLOWER_ENABLE")
    String cursorName = GetTargetActorName()
    If cursorName != ""
        If HaveValidToggleActorTarget()
            String toggleFollowerText
            If IsToggleActorTargetEnabled()
                toggleFollowerText = "$DF_TOGGLE_FOLLOWER_DISABLE"
            Else
                toggleFollowerText = "$DF_TOGGLE_FOLLOWER_ENABLE"
            EndIf
            
            OID_ToggleFollower = AddTextOption(cursorName, toggleFollowerText)
        ElseIf IsCurrentTargetActiveDF()
            OID_ToggleFollower = AddTextOption(cursorName, "$DF_TOGGLE_FOLLOWER_IS_DF")
        Else
            OID_ToggleFollower = AddTextOption(cursorName, "$DF_TOGGLE_FOLLOWER_INVALID")
        EndIf
    Else
        OID_ToggleFollower = AddTextOption("$DF_SELECT_A_TARGET", "$DF_TO_TOGGLE_ENABLE")
    EndIf

    ; --- RIGHT COLUMN ---
    SetCursorPosition(1)
    AddHeaderOption("")

    OID_FollowerEventCDSlider = AddSliderOption("$DF_FLWCDOWNDAYS", ETimerp.GetValue(), "$DF_1DAYS")
    OID_HoursTillBillSlider = AddSliderOption("$DF_HOURSNEXTBILL", DebtPollhrs.GetValue()*24, "$DF_0HOURS")

    sexPreferenceOptions = New String[3]
    sexPreferenceOptions[0] = "$DF_SEX_PREFER_BOTH"
    sexPreferenceOptions[1] = "$DF_SEX_PREFER_MALE"
    sexPreferenceOptions[2] = "$DF_SEX_PREFER_FEMALE"

    OID_SexPreferences = AddMenuOption("$DF_SEX_PREFERENCES", sexPreferenceOptions[SexPreferenceIndex])
    OID_DFAnimalContTog = AddToggleOption("$DFANIMALCONT",_DFAnimalCont)
    OID_DFLocNotiTog = AddToggleOption("$DF_LOCCHANGENOTI", _DFLocNoti)
    OID_PermitForceStart = AddToggleOption("$DF_ALLOW_FORCESTART", _DFAllowForceStart.GetValue() != 0.0)
    OID_FNISCompatibility = AddToggleOption("FNIS Compatibility", FNISCompatibility)
    
    ; Dismissal
    AddEmptyOption()
    AddHeaderOption("$DF_DISMISSAL")
    dismissalOptions = New String[3]
    dismissalOptions[0] = "$DF_DISMISSAL_NONE"
    dismissalOptions[1] = "$DF_DISMISSAL_WILL_OR_LOCATION" ; and location
    dismissalOptions[2] = "$DF_DISMISSAL_LOCATION"
    OID_DismissalOption = AddMenuOption("$DF_DISMISSAL_RESTRICTION", dismissalOptions[DismissalIndex])

EndFunction

Function DoWillpowerPageMenu()
    AddHeaderOption("$DF_WILLPOWER")
    
    OID_MinWillRegain = AddSliderOption("$DF_MIN_WILL_REGAIN", MinWillRegain, "$DF_0")
    OID_MaxWillRegain = AddSliderOption("$DF_MAX_WILL_REGAIN", MaxWillRegain, "$DF_0")
    OID_DFMaxResistMCMSlider = AddSliderOption("$_DFMaxResistMCM", _DFMaxResistMCM, "$DF_0")
    OID_DFMaxResistMinSlider = AddSliderOption("$_DFMaxResistMin", _DFMaxResistMin, "$DF_0")
    OID_ResistanceWillSlider = AddSliderOption("$_DFResistanceWillDelta", _DFResistanceWillDelta, "$DF_0")
    OID_ResistanceDealSlider = AddSliderOption("$_DFResistanceDealDelta", _DFResistanceDealDelta, "$DF_1")
    OID_ResistanceLevelDelta = AddSliderOption("$_DFResistanceLevelDelta", _DFResistanceLevelDelta, "$DF_2")
    OID_FatigueRateSlider = AddSliderOption("$_DFFatigueRate", _DFFatigueRate.GetValue(), "$DF_1")
    OID_GoldPerFatigueSlider = AddSliderOption("$_DFGoldPerFatigue", _DFGoldPerFatigue.GetValue(), "$DF_0")

    ;OID_WillRegainMode = AddToggleOption("$_DFWillRegainMode", 0 != _DFWillRegainMode)
    ;OID_DFDealEffectWillTog  = AddToggleOption("$_DFDealEffectWill",_DFDealEffectWill)
    ;OID_DFMaxResistDealTog  = AddToggleOption("$_DFMaxResistDeal",_DFMaxResistDeal)
    
    ; --- RIGHT COLUMN ---
    SetCursorPosition(1)
    AddHeaderOption("")
    
    OID_LivesSlider = AddSliderOption("$DF_FLWLIFES", FollowerLivesMax, "$DF_0LIFES")
    OID_DFLivesFollowerRapeTog = AddToggleOption("$DF_FLWVICTIMLIFELOST",_DFLivesFollowerRape.GetValueInt())
  
    OID_DFlowItemsPerRemovedSlider  = AddSliderOption("$DF_PERCITEMSTAKEN", _DFlowItemsPerRemoved.GetValue(), "$DF_0%")
    OID_BoredomIntervalSlider = AddSliderOption("$DF_BOREDOM_INTERVAL", _DFBoredomIntervalDays.GetValue(), "$DF_2")
    OID_ResistanceFatigueLimit = AddSliderOption("$DF_RESISTANCE_FATIGUE_LIMIT", Tool.MaxResistanceFatigue, "$DF_0")
    OID_DFMaxResistDevicesTog  = AddToggleOption("$_DFMaxResistDevices",_DFMaxResistDevices)
EndFunction

Function DoCostsPageMenu()
    AddHeaderOption("$DF_DAILYDEBTMODS")
    OID_DailyDebtIncrement = AddSliderOption("$_DFDailyDebtIncrement", _DFDailyDebtIncrement.GetValue(), "$DF_1%")
    OID_IntrestSlider = AddSliderOption("$DF_INTDAILY", Intrest.GetValue(), "$DF_0%")
    OID_DebtPerFollowerSlider = AddSliderOption("$DF_DEBTPERFLW", DebtPerFollower.GetValue(), "$DF_0%")
        
        ; _DflowDealBaseDebt.GetValueInt() = debt relief
        ; _DflowDealBasePrice.GetValueInt() = debt buyout

    AddHeaderOption("$DF_DEALSETT")
    OID_DflowDealBaseDebtSlider = AddSliderOption("$DF_DEALREMDEBT", BaseDebtRelief, "$DF_0%")
    OID_DflowDealBasePriceSlider = AddSliderOption("$DF_GOLDREMDEAL", BaseDebtBuyout, "$DF_0%")
    
    OID_DflowDealMultiSlider = AddSliderOption("$DF_EARLYREMMULT", DealEarlyMulti, "$DF_0%") ; early buyout PERCENTAGE
    OID_DflowDealBaseDaysSlider = AddSliderOption("$DF_DEALDUR", DealDurationDays, "$DF_1")
    
    OID_DiscountLimitSlider = AddSliderOption("$DF_DISCOUNT_LIMIT", _DFDiscountLimit.GetValue() * 100.0, "$DF_0%")

    AddHeaderOption("$DF_GSETT")
    OID_DFlowGambleJPotSlider= AddSliderOption("$DF_JACKPOTVAL", _DFlowGambleJPot.GetValueInt(), "$DF_0")
    
    
    SetCursorPosition(1)
    
    AddHeaderOption("$DF_PUNISHDEBT")
    OID_DFPunDebtSlider = -2
    OID_DFPunDebtSlider = AddSliderOption("$DF_PUNISHDEBT", PunishmentDebt, "$DF_0%")

    
    AddHeaderOption("$DF_DEVREMPRICES")
    OID_DFRemovalModeS = AddTextOption("$DF_REMOVAL_MODE",_DFRemovalModeS)
    OID_DFKeyDiffS = AddTextOption("$DF_KEYGAMEDIF",_DFKeyDiffS)
    OID_DFKConcealSlider = AddSliderOption("$DF_KEYGAMECON",_DFKConceal,"$DF_0%")
    OID_DflowRemovalBasePriceSlider = AddSliderOption("$DF_DEVREMBASEPRICE", DeviceRemovalFirst, "$DF_0%")
    OID_DFlowRemovalIncSlider = AddSliderOption("$DF_PRICEINCRPERREM", DeviceRemovalInc, "$DF_0%")
    OID_DFlowRemovalDebtTimesSlider = AddSliderOption("$DF_COSTMULTDEPT", _DFlowRemovalDebtTimes.GetValue(), "$DF_0%")
EndFunction


String MAX_STAGE_PREFIX = "DFR_MaxStage_"
String FINAL_STAGE_PREFIX = "DFR_FinalStageToggle_"

Function DoDealsPageMenu()

	If 0.0 == Pause.GetValue() ; This means paused... The underlying property isn't called Pause at all...
		AddHeaderOption("$DF_DEALSPAGE")
		AddTextOption("$PAUSE_DISABLED", "")
		Return
	EndIf

    OID_ExpectedDealLimitSlider = AddSliderOption("$DF_EXPECTED_DEAL_LIMIT", _DFExpectedDealLimit.GetValue() As Int, "$DF_0")

    AddHeaderOption("Whore Deal Settings")
    ;OID_DFDealSCustArmorTog = AddToggleOption("$DF_SIGNCA",_DFDealSCustArmor)

    OID_DFDealSSignTog = AddToggleOption("$DFDEALSIGNTOG",(DealS As _DDeal).Stat As Bool)

    SetCursorPosition(1)
    ;OID_DealBias = AddSliderOption("$DF_DEAL_BIAS", DC.DealBias, "$DF_0%")
    AddHeaderOption("Deal Settings")
	
    ;OID_ModDealNumOfDeals = AddSliderOption("# of Modular Deals", MDC.MaxModDealsSetting)
    OID_DFMDTimerSlider = AddSliderOption("$DFMDTimer", MDC.TimerSetting, "$DF_1Days")
    
    OID_DeepDebtDifficulty = AddSliderOption("$DF_DEEP_DEBT_DIFFICULTY", _DFDeepDebtDifficulty.GetValue(), "$DF_1")
EndFunction


Int groupIndex
String[] groupNames
Int OID_RulesCurrentGroup

Function DoModularDealsPageMenu()

	If 0.0 == Pause.GetValue() ; This means paused...
		AddHeaderOption("$DF_MODDEALSPAGE")
		AddTextOption("$PAUSE_DISABLED", "")
		Return
	EndIf

    SetCursorFillMode(LEFT_TO_RIGHT)

    string currGroup = groupNames[groupIndex]
    AddTextOption("Current Group", "")
    OID_RulesCurrentGroup = AddMenuOption("", currGroup)
    AddHeaderOption("")
    AddHeaderOption("")

    string[] rules = DealManager.GetPackRules(currGroup)

    
    int i = 0
    while i < rules.length
        string rule = rules[i]

        GlobalVariable status = DealManager.GetRuleGlobal(rule)
        int value = status.GetValue() as int

        string name = DealManager.GetRuleName(rule)
        string translated = TranslateStatus(value)

        int flag = OPTION_FLAG_NONE

        if !DealManager.CanEnableRule(rule)
            flag = OPTION_FLAG_DISABLED
        endIf

        StorageUtil.SetStringValue(none, "DF_RULE_STATUS_" + AddTextOption(name, translated), rule)
        i += 1
    endWhile
    
EndFunction

String Function TranslateStatus(int value)
    if value == 0
        return "Disabled"
    elseIf value == 1 || value == 2
        return "Enabled"
    elseIf value == 3
        return "Active"
    else
        return "Invalid"
    endIf
EndFunction

Function DoPunishmentsPageMenu()

    AddHeaderOption("$DF_REGULAR_SLAVERY_OPTIONS")
    OID_EnslavementSlider = AddSliderOption("$DF_MAXDEBT", EnslavementDebtScale, "$DF_2") ; enslavement debt
    OID_EnslavFailSlider = AddSliderOption("$DF_SLAVEFAILDEBT", FailureScale, "$DF_2") ; abandonment/sent-to-pit debt
    
    ; Don't give deals when punished for excessive debt, just enslave instead. Endless mode will not work with this.
    OID_SkipToTheEndTog = AddToggleOption("$DF_SkipToTheEnd", SkipToTheEnd)

    ; Endless mode is "gone" but you can still disable regular enslavement with this tickbox.
    OID_DflowEndlessModeTog = AddToggleOption("$DF_DISABLE_REGULAR_SLAVERY", _DflowEndlessMode.GetValueInt())


    ; Regular enslavement destinations
    AddHeaderOption("$DF_REGULAR_WEIGHTS")
    Float sltrChance = 0.0
    Int sltrFlags = OPTION_FLAG_DISABLED
    If Tool.HaveLola()
        sltrFlags = OPTION_FLAG_NONE
        sltrChance = LolaChance.GetValue()
    EndIf

    Float ssoChance = 0.0
    Int ssFlags = OPTION_FLAG_DISABLED
    If Tool.HaveSimpleSlavery()
        ssFlags = OPTION_FLAG_NONE
        ssoChance = SSO.GetValue()
    EndIf
    
    Float dfcChance = DfcSlaveryChance.GetValue()
    Int dfcFlags = OPTION_FLAG_NONE
    If ssoChance <= 0.0 && sltrChance <= 0.0
        dfcChance = 100.0
        DfcSlaveryChance.SetValue(dfcChance)
    EndIf
    
    If sltrFlags == OPTION_FLAG_DISABLED && ssoChance == OPTION_FLAG_DISABLED
        dfcChance = OPTION_FLAG_DISABLED
    EndIf

    OID_DfcSlaverySlider = AddSliderOption("$DF_DFCSLAVECHANCE", dfcChance, "$DF_0", dfcFlags)
    OID_LolaSlider = AddSliderOption("$DF_LOLACHANCE", sltrChance, "$DF_0", sltrFlags)
    OID_SimplePerSlider = AddSliderOption("$DF_SSLVCHANCE", ssoChance, "$DF_0", ssFlags)
    

    ; Alternate enslavement...
    AddEmptyOption()
    AddHeaderOption("$DF_ALTERNATE_PUNISHMENTS")
    OID_DFSoldTog = AddToggleOption("$DF_SOLDACTIVE", DSold.Active)
    OID_DFSoldTimerMin = AddSliderOption ("$DFSOLDTIMERMIN", DSold.TimerMin, "$DF_1Days")
    OID_DFSoldTimerMax = AddSliderOption ("$DFSOLDTIMERMAX", DSold.TimerMax, "$DF_1Days")
    OID_DFSoldDeals = AddSliderOption("$DFSOLDDEALS", _DFSoldDeals.GetValue())

    ; Alternate mode enslavement destinations
    AddHeaderOption("$DF_ALTERNATE_WEIGHTS")

    Float soldChance = Q.EndlessSoldWeight
    dfcChance = Q.EndlessSlaveWeight

    sltrChance = 0.0
    sltrFlags = OPTION_FLAG_DISABLED
    If Tool.HaveLola()
        sltrFlags = OPTION_FLAG_NONE
        sltrChance = Q.EndlessLolaWeight
    EndIf

    ssoChance = 0.0
    ssFlags = OPTION_FLAG_DISABLED
    If Tool.HaveSimpleSlavery()
        ssFlags = OPTION_FLAG_NONE
        ssoChance = Q.EndlessAuctionWeight
    EndIf
    

    OID_EndlessSoldWeight = AddSliderOption("$DF_SOLD_WEIGHT", soldChance, "$DF_0")
    OID_EndlessSlaveWeight = AddSliderOption("$DF_DFCSLAVECHANCE", dfcChance, "$DF_0")
    OID_EndlessLolaWeight = AddSliderOption("$DF_LOLACHANCE", sltrChance, "$DF_0", sltrFlags)
    OID_EndlessAuctionWeight = AddSliderOption("$DF_SSLVCHANCE", ssoChance, "$DF_0", ssFlags)


    ; --- RIGHT COLUMN ---
    SetCursorPosition(1)
    
    AddHeaderOption("$DF_PUNISHMENT_BENEFITS")
    OID_debtReduction = AddSliderOption("$DF_PUNISHMENT_DEBT_REDUCTION", Q.PunishmentDebtReduction, "$DF_0%")
    OID_dealReduction = AddSliderOption("$DF_PUNISHMENT_DEAL_REDUCTION", Q.PunishmentDealReduction, "$DF_0")
    
    AddEmptyOption()
    AddHeaderOption("$DF_SIMPLE_SLAVERY_INTEGRATION")
    OID_DFZAZAutoPause = AddToggleOption("$DF_AUTOPAUSE",_DFZAZAutoPause)

    ; Slaver NPC
    String targetName = GetTargetActorName()
    If !HaveValidSlaverTarget()
        targetName = "$DF_INELIGIBLE"
    EndIf
    OID_Scan2Tog = AddTextOption("$DF_SSLVNPCSLAVER", targetName, ssFlags)

    ; Simple Slavery destination
    AddHeaderOption("$DF_ENSLAVEWEIGHTS")
    OID_FreedomSlider = AddSliderOption("$DF_FREEDOMPRICE", FreedomCostScale, "$DF_2", ssFlags)

    OID_DFSWeightDSlider = AddSliderOption("$DF_DEALENSLAVE", _DFSWeightD,  "$DF_0", ssFlags)
    OID_DFSWeightESlider = AddSliderOption("$DF_NORMALENSLAVE", _DFSWeightE, "$DF_0", ssFlags)
    OID_DFSWeightEDSlider = AddSliderOption("$DF_NORMALDEALENSLAVE", _DFSWeightED , "$DF_0", ssFlags)
    

EndFunction

Function DoChaosPageMenu()
    SetCursorFillMode(LEFT_TO_RIGHT)
    AddHeaderOption("$DF_CHAOSM")
    AddHeaderOption("")
    
    OID_DFChaoGoTog = AddToggleOption("$DF_ACTIVATECM", _DFChaoGo)
    OID_DFChaoConcealedTog = AddToggleOption("$DF_CONCELVAL", _DFChaoConcealed)
    
    OID_DFChaosPercentSlider= AddSliderOption("$DF_MAXDAILYDEBTCHANGEPERC", _DFChaosPercent, "$DF_0%")
    OID_DFChaosDaysSlider= AddSliderOption("$DF_DAYSTILLCHAOSREROLL", _DFChaosDays, "$DF_1DAYS")

    
    OID_DFDebtperdayMinSlider = AddSliderOption("$DF_MINDAILYDEBT", _DFDebtperdayMin, "$DF_1")
    OID_DFDebtperdayMaxSlider = AddSliderOption("$DF_MAXDAILYDEBT", _DFDebtperdayMax, "$DF_1")

    OID_DFPunDebtMinSlider = AddSliderOption("$DF_MINPUNISHDEBT", _DFPunDebtMin, "$DF_1")
    OID_DFPunDebtMaxSlider = AddSliderOption("$DF_MAXPUNISHDEBT", _DFPunDebtMax, "$DF_1")

    OID_DFRemovalMinSlider= AddSliderOption("$DF_MINDEVREMPRICE", _DFRemovalMin, "$DF_1")
    OID_DFRemovalMaxSlider= AddSliderOption("$DF_MAXDEVREMPRICE", _DFRemovalMax, "$DF_1")

    OID_DFRemovalIncMinSlider= AddSliderOption("$DF_MINDEVREMINCR", _DFRemovalIncMin, "$DF_1")
    OID_DFRemovalIncMaxSlider= AddSliderOption("$DF_MAXDEVREMINCR", _DFRemovalIncMax, "$DF_1")

    OID_DFDealsMinDebtSlider= AddSliderOption("$DF_MINDEBTREMDEAL", _DFDealsMinDebt, "$DF_1")
    OID_DFDealsMaxDebtSlider= AddSliderOption("$DF_MAXDEBTREMDEAL", _DFDealsMaxDebt, "$DF_1")

    OID_DFDealsMinPriceSlider= AddSliderOption("$DF_MINDEALREMCOST", _DFDealsMinPrice, "$DF_1")
    OID_DFDealsMaxPriceSlider= AddSliderOption("$DF_MAXDEALREMCOST", _DFDealsMaxPrice, "$DF_1")

    OID_DFDealsMinPTimeSlider= AddSliderOption("$DF_MINDEALDUR", _DFDealsMinPTime, "$DF_0DAYS")
    OID_DFDealsMaxPTimeSlider= AddSliderOption("$DF_MAXDEALDUR", _DFDealsMaxPTime, "$DF_0DAYS")

    OID_DFDealsMinMultiSlider= AddSliderOption("$DF_MINDEALDAYMULT", _DFDealsMinMulti, "$DF_1")
    OID_DFDealsMaxMultiSlider= AddSliderOption("$DF_MAXDEALDAYMULT",_DFDealsMaxMulti, "$DF_1")

    OID_DFLivesChaoMinSlider= AddSliderOption("$DF_MINLIFES", _DFLivesChaoMin, "$DF_0")
    OID_DFLivesChaoMaxSlider= AddSliderOption("$DF_MAXLIFES", _DFLivesChaoMax, "$DF_0")

    If  !_DFChaoConcealed
        SetCursorFillMode(TOP_TO_BOTTOM)
        SetCursorPosition(24)
        AddHeaderOption("")
        AddTextOption("$DF_DAILY_DEBT", FormatFloat_N1(ChaosDailyDebt), OPTION_FLAG_DISABLED)
        AddTextOption("$DF_PUNISH_DEBT", FormatFloat_N1(ChaosPunishmentDebt), OPTION_FLAG_DISABLED)
        AddTextOption("$DF_DEVICE_REMOVE_DEBT", FormatFloat_N1(ChaosDeviceRemovalFirst), OPTION_FLAG_DISABLED)
        AddTextOption("$DF_INC_REMOVE_DEBT", FormatFloat_N1(ChaosDeviceRemovalInc), OPTION_FLAG_DISABLED)
        AddTextOption("$DF_DEAL_DEBT_RELIEF", FormatFloat_N1(ChaosDealRelief), OPTION_FLAG_DISABLED)
        AddTextOption("$DF_DEAL_BUYOUT", FormatFloat_N1(ChaosDealBuyout), OPTION_FLAG_DISABLED)
        AddTextOption("$DF_DEAL_DURATION", FormatFloat_N0(ChaosDealDurationDays), OPTION_FLAG_DISABLED)
        AddTextOption("$DF_DEAL_EARLY_MULTI", FormatFloat_N1(ChaosDealEarlyMulti), OPTION_FLAG_DISABLED)
        AddTextOption("$DF_FOLLOWER_LIVES", FormatFloat_N0(ChaosFollowerLivesMax), OPTION_FLAG_DISABLED)
    EndIf
EndFunction

Function DoMiscAdditionalContentPageMenu()

    If 0.0 == Pause.GetValue() ; PAUSED
        AddTextOption("$PAUSE_DISABLED_STATS", "")
        Return
    EndIf

    AddHeaderOption("$DF_SPANKING")
    OID_SpankingCooldown = AddSliderOption("$DF_SPANKING_COOLDOWN", SpankingCooldownHours, "$DF_2HOURS")

    AddHeaderOption("$DF_GOLDCONTROLTITLE")
    OID_DflowGoldModeTog = AddToggleOption("$DF_GOLDMOD", GoldCont.Active)
    OID_DflowGoldModeMaxSlider = AddSliderOption("$DF_GOLDMODMAX", GoldCont.AgreedGoldMax, "$DF_0GOLD")
    OID_DflowGoldModeMinSlider = AddSliderOption("$DF_GOLDMODMIN", GoldCont.AgreedGoldMin, "$DF_0GOLD")
    OID_DFGDecaySlider = AddSliderOption("$DF_GOLDDECAY", GoldCont.Decay*100, "$DF_1%")
    OID_DFGStay0Tog= AddToggleOption("$DF_GOLDSTAYZERO",GoldCont.Stay0)
    OID_DFGKnockDownTog= AddToggleOption("$DF_GOLDKNOCKTOG",GoldCont.KnockDown)
    OID_DFGOtherTog= AddToggleOption("$DF_GOLDOTHERTOG",GoldCont.Other)
    OID_DFGRedGoldModSlider = AddSliderOption("$DF_GOLDREDUCEMOD", GoldCont.RedGoldMod*100, "$DF_1%")
    OID_DFGCredToLeaveSlider = AddSliderOption("$DF_CRED2L", GoldCont.CredToLeave, "$DF_0GOLD")


    ; --- RIGHT COLUMN ---
    SetCursorPosition(1)
    
    AddHeaderOption("$DF_HARDCORE_MODE")
    OID_HardCoreMode = AddTextOption("$DF_HARDCORE_MODE", "$DF_CLICK_TO_ENABLE")

    AddHeaderOption("$DF_GOLDTHEFTSEX")
    OID_DFTheifsBoolTog = AddToggleOption("$DF_ENABLED", _DFTheifsBool)
    OID_DFMaxStolenPerSlider = AddSliderOption("$DF_MAXGOLDSTOLEN", _DFMaxStolenPer, "$DF_0%")
    OID_DFMinStolenPerSlider = AddSliderOption("$DF_MINGOLDSTOLEN", _DFMinStolenPer, "$DF_0%")
    OID_DFWillBoolTog = AddToggleOption("$DF_LESSWILLTHEFT",_DFWillBool)
    
    ; Kludge very ancient bug of no initialization of these values.
    If DFPotQ.DelayMin < 0.25 && DFPotQ.DelayMax < 0.25
        DFPotQ.DelayMin = 3.0
        DFPotQ.DelayMax = 11.0
    EndIf

    AddHeaderOption("$DF_POTIONQUEST")
    OID_DFPotionQTog = AddToggleOption("$DF_POTIONENABLE", DFPotQ.Enabled, OPTION_FLAG_DISABLED)
    OID_DFPotionQSlider = AddSliderOption("$DFPOTIONDEALS", DFPotQ._DFlowPotionDeal.GetValue(), OPTION_FLAG_DISABLED)
    OID_DFPotionQETog = AddToggleOption("$DF_POTIONENABLEEVIL", DFPotQ.EnabledEvil, OPTION_FLAG_DISABLED)
    OID_DFPotionQESlider = AddSliderOption("$DFPOTIONDEALSEVIL", DFPotQ._DFlowPotionDealEvil.GetValue(), OPTION_FLAG_DISABLED)
    OID_DFPotionQDelayMin = AddSliderOption ("$DFPOTIONTIMERMIN", DFPotQ.DelayMin, "$DF_2DAYS", OPTION_FLAG_DISABLED)
    OID_DFPotionQDelayMax = AddSliderOption ("$DFPOTIONTIMERMAX", DFPotQ.DelayMax, "$DF_2DAYS", OPTION_FLAG_DISABLED)
    

EndFunction

Function DoOtherModSettingsPageMenu()

    AddHeaderOption("$DF_SPANK_SUPPORT")
    
    String spankingInfo = "$DF_NO"
    If Tool.CheckSpanking()
        spankingInfo = "$DF_YES"
    EndIf
    
    OID_Spanking = AddTextOption("$DF_SPANKING_AVAIL", spankingInfo)
    OID_SpankingAnims = AddTextOption("$DF_SPANKING_ANIMS", Tool.GetSpankingAnims())
    OID_SpankingCode = AddTextOption("$DF_SPANKING_CODE", Tool.GetSpankingCodeStatus())
    
    AddHeaderOption("$DF_OTHERDEALMODS")
    ; Frostfall
    OID_DFlowWarmCompTog  = AddToggleOption("$DF_FFALLHELP",_DFlowWarmComp.GetValueInt())
    ; Skooma Whore deals/rules
    If IsSkoomaWhorePresent()
        OID_SkoomaWhore = AddTextOption("$DF_SKOOMA_WHORE", "$DF_PRESENT", OPTION_FLAG_DISABLED)
    Else
        OID_SkoomaWhore = AddTextOption("$DF_SKOOMA_WHORE", "$DF_NOT_PRESENT", OPTION_FLAG_DISABLED)
    EndIf
    ; MME
    If IsMmePresent()
        OID_Mme = AddTextOption("$DF_MME", "$DF_PRESENT", OPTION_FLAG_DISABLED)
    Else
        OID_Mme = AddTextOption("$DF_MME", "$DF_NOT_PRESENT", OPTION_FLAG_DISABLED)
    EndIf
    ; Lola
    If Tool.HaveLola()
        AddTextOption("$DF_LOLA_SUPPORT", "$DF_PRESENT", OPTION_FLAG_DISABLED)
    Else
        AddTextOption("$DF_LOLA_SUPPORT", "$DF_NOT_PRESENT", OPTION_FLAG_DISABLED)
    EndIf
    
    ; Tattoos
    AddHeaderOption("$DF_TATTOO_SUPPORT")
    Int modIndex = Game.GetModByName("RapeTattoos.esp")
    If (modIndex != 255)
        OID_MaxTatsSlider = AddSliderOption("$DF_MAXSLAVETATS", Tats.GetValue(), "$DF_0TATS")
    Else
        OID_MaxTatsSlider = AddSliderOption("$DF_MAXSLAVETATS", Tats.GetValue(), "$DF_0TATS", OPTION_FLAG_DISABLED)
    EndIf


    ; --- RIGHT COLUMN ---
    SetCursorPosition(1)
    
    AddHeaderOption("$DF_FOLLOWER_FRAMEWORKS")
    
    ; AFT support
    Int aftFollowerCount = -1
    modIndex = Game.GetModByName("AmazingFollowerTweaks.esp")
    If 255 != modIndex
        aftFollowerCount = _df_AFT_extensions.CountDeviousFollowers(_DFDisable)
    EndIf
    
    If aftFollowerCount >= 0
        OID_AFTcount = AddTextOption("$DF_AFT", "" + aftFollowerCount)
    Else
        OID_AFTcount = AddTextOption("$DF_AFT", "$DF_NOT_PRESENT", OPTION_FLAG_DISABLED)
    EndIF
    
    ; EFF support
    Int effFollowerCount = -1
    modIndex = Game.GetModByName("EFFCore.esm")
    If 255 != modIndex
        effFollowerCount = _df_EFF_extensions.CountDeviousFollowers(_DFDisable)
    EndIf
    
    If effFollowerCount >= 0
        OID_EFFcount = AddTextOption("$DF_EFF", "" + effFollowerCount)
    Else
        OID_EFFcount = AddTextOption("$DF_EFF", "$DF_NOT_PRESENT", OPTION_FLAG_DISABLED)
    EndIF

    ; NFF support
    Int nffFollowerCount = -1
    modIndex = Game.GetModByName("nwsFollowerFramework.esp")
    If 255 != modIndex
        nffFollowerCount = _df_NFF_extensions.CountDeviousFollowers(_DFDisable)
    EndIf
    
    If nffFollowerCount >= 0
        OID_NFFcount = AddTextOption("$DF_NFF", "" + nffFollowerCount)
    Else
        OID_NFFcount = AddTextOption("$DF_NFF", "$DF_NOT_PRESENT", OPTION_FLAG_DISABLED)
    EndIf
    
    ; SLS Licenses
    AddHeaderOption("$DF_SLS_HEADER")
    Int licenseFlags = OPTION_FLAG_DISABLED
    If IsSlsPresent()
        AddTextOption("$DF_SLS", "$DF_PRESENT", OPTION_FLAG_DISABLED)
        licenseFlags = OPTION_FLAG_NONE        
    Else
        AddTextOption("$DF_SLS", "$DF_NOT_PRESENT", OPTION_FLAG_DISABLED)
    EndIf
    
    ; If locked or paused, disable license changes
    If _DFHardcoreMode.GetValue() > 0.0 || 0.0 == Pause.GetValue()
        licenseFlags = OPTION_FLAG_DISABLED
    EndIf
    
    OID_LicenseEnable = AddToggleOption("$DF_LICENSE_ENABLE", licenseStatusEnabledNew, licenseFlags)
    OID_ForcedLicenses = AddToggleOption("$DF_LICENSE_FORCED", GoldCont.IsEnabledForcedLicenseControl, licenseFlags)
    OID_LicenseBasePrice = AddSliderOption("$DF_LICENSE_BASE_PRICE", _DFLicenses.BasePrice, "$DF_0", licenseFlags)
    OID_LicenseMarkup = AddSliderOption("$DF_LICENSE_MARKUP", _DFLicenses.Markup, "$DF_0%", licenseFlags)

EndFunction            

Function DoCostExplorerPageMenu()
    SetCursorFillMode(LEFT_TO_RIGHT)
    AddHeaderOption("$DF_COST_EXPLORER")
    AddHeaderOption("")
    Int editExponent = OPTION_FLAG_DISABLED
    If 7 == exploreDifficulty
        editExponent = OPTION_FLAG_NONE
    EndIf
    
    OID_ExploreDifficulty = AddMenuOption("$DF_EXPLORE_DIFFICULTY", debtExponentNames[exploreDifficulty])
    OID_ExploreExponent = AddSliderOption("$DF_EXPLORE_EXPONENT", exploreExponent, "$DF_2", editExponent)
    
    OID_ExploreLoPrice = AddSliderOption("$DF_EXPLORE_LO_PRICE", exploreLoPrice)
    OID_ExploreHiPrice = AddSliderOption("$DF_EXPLORE_HI_PRICE", exploreHiPrice)

    Float exponent = debtExponents[exploreDifficulty]
    If 7 == exploreDifficulty
        exponent = exploreExponent
    EndIf
    Float x100 = (exploreHiPrice - exploreLoPrice) / Math.Pow(100, exponent)
    
    OID_CopyToSettings = AddTextOption("", "$COPY_TO_SETTINGS")
    AddTextOption("Level 1", FormatFloat_N0(exploreLoPrice), OPTION_FLAG_DISABLED)
    Int el = 5
    While el < 101
    
        Float perDay = exploreLoPrice + x100 * Math.Pow(el - 1.0, exponent)
        AddTextOption("Level " + el, FormatFloat_N0(perDay), OPTION_FLAG_DISABLED)
        el += 5
    EndWhile
    AddTextOption("Level 101", FormatFloat_N0(exploreHiPrice), OPTION_FLAG_DISABLED)
EndFunction            

Function DoDebugPageMenu()
    AddHeaderOption("$DF_DOPTIONS")
    ; Pause back to front, mis-named it here, though its real name id _DFlowEnable, which makes more sense.
    ; If Pause is non-zero the mod is RUNNING, and if it's zero, the mod is PAUSED.
    OID_EnableTog = AddToggleOption("$DF_MODPAUSED", Pause.GetValue() == 0.0)
    OID_DFShowRollMsgTog = AddToggleOption("$DF_SHOWROLLS",_DFShowRollMsg)
    OID_AddFollowerDebug = AddToggleOption("$DF_DEBUGADDFLW", ADFD.GetValueInt())
    OID_ScanTog = AddTextOption("$DF_EXCLNPC", "$DF_CLICK_ME") ; Set all non-current followers to be ignored!
    OID_ResetTog = AddTextOption("$DF_RESET", "$DF_CLICK_ME")  ; Reset mod
    OID_RestoreControls = AddTextOption("$DF_RESTORE_CTLS", "$DF_CLICK_ME")
    OID_AddDebtDebug100 = AddTextOption("$DF_ADD100DEBT", "$DF_CLICK_ME")
    OID_AddDebtDebugTog = AddTextOption("$DF_ADD1KDEBT", "$DF_CLICK_ME")
    OID_DebugResistance = AddTextOption("$DF_DEBUG_RESISTANCE", "$DF_CLICK_ME")
    OID_DebugBoredom = AddTextOption("$DF_DEBUG_BOREDOM", "$DF_CLICK_ME")
    
    SetCursorPosition(1)
    AddHeaderOption("DFC Version " + FormatDecimal_x100(Version As Int))
    OID_LDCInitTog = AddTextOption("$DF_LDCINITTOG", "$DF_CLICK_ME")
    If tick.Suspend == 1 && Tool.Suspend == 0
        OID_SuspendOutPut = AddTextOption("$DF_SUSPENDOID","$DF_SUSPENDOTHER")
    ElseIf Tick.Suspend == 1 && Tool.Suspend == 1
        OID_SuspendOutPut = AddTextOption("$DF_SUSPENDOID","$DF_SUSPENDMOD")
    Else
        OID_SuspendOutPut = AddTextOption("$DF_SUSPENDOID","$DF_SUSPENDOK")
    EndIf
    OID_SendResumeTog = AddTextOption("$DF_SENDRESUME", "$DF_CLICK_ME")
    
    OID_EndScene = AddTextOption("$DF_END_SCENE", "$DF_CLICK_ME")
    OID_RepairFollower = AddTextOption("$DF_REPAIR_FOLLOWER", "$DF_CLICK_ME")
    OID_RemoveFollower = AddTextOption("$DF_REMOVE_FOLLOWER", "$DF_CLICK_ME")
    OID_GetEnslaved = AddTextOption("$DF_GET_ENSLAVED", "$DF_CLICK_ME") 
    ;If HaveSimpleSlavery()
    OID_SendForAuction = AddTextOption("$DF_AUCTION_ME", "$DF_CLICK_ME")
    OID_SaveTog = AddTextOption("$DF_SAVESETT", "$DF_CLICK_ME")
    OID_LoadTog = AddTextOption("$DF_LOADSETT", "$DF_CLICK_ME")

    SetCursorPosition(22)
    AddHeaderOption("")
    SetCursorPosition(23)
    AddHeaderOption("")
    SetCursorPosition(24)
    
    OID_AddSlaveKit        = AddTextOption("$DF_ADD_SLAVE_KIT", "$DF_CLICK_ME")
    OID_AddChainsOfDebt    = AddTextOption("$DF_ADD_CHAINS_OF_DEBT", "$DF_CLICK_ME")
    OID_AddBlindfold       = AddTextOption("$DF_ADD_BLINDFOLD", "$DF_CLICK_ME")
    OID_AddGag             = AddTextOption("$DF_ADD_GAG", "$DF_CLICK_ME")
    OID_AddCollar          = AddTextOption("$DF_ADD_COLLAR", "$DF_CLICK_ME")
    OID_AddNipplePiercing  = AddTextOption("$DF_ADD_NIP_PIERCING", "$DF_CLICK_ME")
    OID_AddBra             = AddTextOption("$DF_ADD_BRA", "$DF_CLICK_ME")
    OID_AddHobbleDress     = AddTextOption("$DF_ADD_HOBBLE", "$DF_CLICK_ME")
    OID_AddArmCuffs        = AddTextOption("$DF_ADD_ARM_CUFFS", "$DF_CLICK_ME")
    OID_AddGloves          = AddTextOption("$DF_ADD_GLOVES", "$DF_CLICK_ME")
    OID_AddMittens         = AddTextOption("$DF_ADD_MITTENS", "$DF_CLICK_ME")
    OID_AddHeavyBondage    = AddTextOption("$DF_ADD_HEAVY_BONDAGE", "$DF_CLICK_ME")
    OID_AddCorsetHarness   = AddTextOption("$DF_ADD_CORSET", "$DF_CLICK_ME")
    OID_AddVaginalPiercing = AddTextOption("$DF_ADD_VAG_PIERCING", "$DF_CLICK_ME")
    OID_AddVaginalPlug     = AddTextOption("$DF_ADD_VAG_PLUG", "$DF_CLICK_ME")
    OID_AddAnalPlug        = AddTextOption("$DF_ADD_ANAL_PLUG", "$DF_CLICK_ME")
    OID_AddBelt            = AddTextOption("$DF_ADD_BELT", "$DF_CLICK_ME")
    OID_AddLegCuffs        = AddTextOption("$DF_ADD_LEG_CUFFS", "$DF_CLICK_ME")
    OID_AddBoots           = AddTextOption("$DF_ADD_BOOTS", "$DF_CLICK_ME")
    OID_AddPrisonerChains  = AddTextOption("$DF_ADD_PRISONER_CHAINS", "$DF_CLICK_ME")
    OID_AddPetSuit         = AddTextOption("$DF_ADD_PET_SUIT", "$DF_CLICK_ME")
    OID_AddFullSet         = AddTextOption("$DF_ADD_FULL_SET", "$DF_CLICK_ME")
    OID_AddWhoreArmor      = AddTextOption("Add Whore Armor", "$DF_CLICK_ME")

    If IsDebug()
        AddEmptyOption()
        
        Actor whoMaster = Tick.GetCrosshairTarget As Actor
        If !whoMaster
            whoMaster = Follower.GetActorRef()
        EndIf
        If whoMaster
            Int isMaster = StorageUtil.GetIntValue(whoMaster, Tool.TagMaster, -1)
            Int neverDevious = StorageUtil.GetIntValue(whoMaster, Tool.TagNeverDevious, -1)
        
            Float lastHire = StorageUtil.GetFloatValue(whoMaster, Tool.TagLastHireTime, -1.0)
            Float boredom =  StorageUtil.GetFloatValue(whoMaster, Tool.TagBoredom, -1.0)
            Float days =  StorageUtil.GetFloatValue(whoMaster, Tool.TagMasterDays, -1.0)
            
            Float hiredFor = (Utility.GetCurrentGameTime() - lastHire) * 24.0
            
            AddTextOption("Is Master", "" + isMaster, OPTION_FLAG_DISABLED)
            AddTextOption("Never Devious", "" + neverDevious, OPTION_FLAG_DISABLED)
            AddTextOption("Hired for", "" + hiredFor + " hours", OPTION_FLAG_DISABLED)
            AddSliderOption("Boredom", boredom, "{1}", OPTION_FLAG_DISABLED)
            AddSliderOption("Previous Days", days, "{2}", OPTION_FLAG_DISABLED)
        
            String[] personalities = New String[7]
            personalities[0] = "Default"
            personalities[1] = "Slaver"
            personalities[2] = "Profiteer"
            personalities[3] = "Sexy"
            personalities[4] = "Sadist"
            personalities[5] = "Moral"
            personalities[6] = "Nightmare"
            
            Int personality = StorageUtil.GetIntValue(whoMaster, Tool.TagPersonality, -1)
             AddTextOption("Personality", "" + personality, OPTION_FLAG_DISABLED)
            
            If personality >= 0
                AddTextOption("Personality type", "" + personalities[personality], OPTION_FLAG_DISABLED)
                
                Int aggression = StorageUtil.GetIntValue(whoMaster, Tool.TagAggression, -1)
                Int greed = StorageUtil.GetIntValue(whoMaster, Tool.TagGreed, -1)
                Int honor = StorageUtil.GetIntValue(whoMaster, Tool.TagHonor, -1)
                Int lust = StorageUtil.GetIntValue(whoMaster, Tool.TagLust, -1)
                Int control = StorageUtil.GetIntValue(whoMaster, Tool.TagControl, -1)
                Int playful = StorageUtil.GetIntValue(whoMaster, Tool.TagPlayful, -1)
                
                AddTextOption("Aggression", "" + aggression, OPTION_FLAG_DISABLED)
                AddTextOption("Greed", "" + greed, OPTION_FLAG_DISABLED)
                AddTextOption("Honor", "" + honor, OPTION_FLAG_DISABLED)
                AddTextOption("Lust", "" + lust, OPTION_FLAG_DISABLED)
                AddTextOption("Control", "" + control, OPTION_FLAG_DISABLED)
                AddTextOption("Playful", "" + playful, OPTION_FLAG_DISABLED)
            EndIf
        EndIf
    EndIf
    
    SetCursorPosition(25)

    AddEmptyOption()
    OID_RemoveHood            = AddTextOption("$DF_REMOVE_HOOD", "$DF_CLICK_ME")
    OID_RemoveBlindfold       = AddTextOption("$DF_REMOVE_BLINDFOLD", "$DF_CLICK_ME")
    OID_RemoveGag             = AddTextOption("$DF_REMOVE_GAG", "$DF_CLICK_ME")
    OID_RemoveCollar          = AddTextOption("$DF_REMOVE_COLLAR", "$DF_CLICK_ME")
    OID_RemoveNipplePiercing  = AddTextOption("$DF_REMOVE_NIP_PIERCING", "$DF_CLICK_ME")
    OID_RemoveBra             = AddTextOption("$DF_REMOVE_BRA", "$DF_CLICK_ME")
    OID_RemoveHobbleDress     = AddTextOption("$DF_REMOVE_HOBBLE", "$DF_CLICK_ME")
    OID_RemoveArmCuffs        = AddTextOption("$DF_REMOVE_ARM_CUFFS", "$DF_CLICK_ME")
    OID_RemoveGloves          = AddTextOption("$DF_REMOVE_GLOVES", "$DF_CLICK_ME")
    OID_RemoveMittens         = AddTextOption("$DF_REMOVE_MITTENS", "$DF_CLICK_ME")
    OID_RemoveHeavyBondage    = AddTextOption("$DF_REMOVE_HEAVY_BONDAGE", "$DF_CLICK_ME")
    OID_RemoveCorsetHarness   = AddTextOption("$DF_REMOVE_CORSET", "$DF_CLICK_ME")
    OID_RemoveVaginalPiercing = AddTextOption("$DF_REMOVE_VAG_PIERCING", "$DF_CLICK_ME")
    OID_RemoveVaginalPlug     = AddTextOption("$DF_REMOVE_VAG_PLUG", "$DF_CLICK_ME")
    OID_RemoveAnalPlug        = AddTextOption("$DF_REMOVE_ANAL_PLUG", "$DF_CLICK_ME")
    OID_RemoveBelt            = AddTextOption("$DF_REMOVE_BELT", "$DF_CLICK_ME")
    OID_RemoveLegCuffs        = AddTextOption("$DF_REMOVE_LEG_CUFFS", "$DF_CLICK_ME")
    OID_RemoveBoots           = AddTextOption("$DF_REMOVE_BOOTS", "$DF_CLICK_ME")
    OID_RemoveSuit            = AddTextOption("$DF_REMOVE_SUIT", "$DF_CLICK_ME")
    
    If IsDebug()
        AddEmptyOption()
        AddEmptyOption()
        Float willLost = 10.0 - Will.GetValue()
        Float pcLevelsGained = (PlayerRef.GetLevel() - 1) As Float
        Float totalDeals = (DC.Deals As Float)
        AddTextOption("Will delta", FormatFloat_N1(_DFResistanceWillDelta * willLost), OPTION_FLAG_DISABLED)
        AddTextOption("Deal delta", FormatFloat_N1(_DFResistanceDealDelta * totalDeals), OPTION_FLAG_DISABLED)
        AddTextOption("Level delta", FormatFloat_N1(_DFResistanceLevelDelta * pcLevelsGained), OPTION_FLAG_DISABLED)
        AddTextOption("Device delta", FormatFloat_N1(GetDeviceResistanceDelta()), OPTION_FLAG_DISABLED)
        AddTextOption("Max Resist", FormatFloat_N1(GetMaxResist() As Float), OPTION_FLAG_DISABLED)
        AddTextOption("Found Resist", FormatFloat_N1(Tool.FindMaxResist(Will.GetValue() As Float, GetMaxResist())), OPTION_FLAG_DISABLED)
        AddTextOption("Punishment Score", StorageUtil.GetIntValue(PlayerRef, "DF_Enslaved_PunishCount", -1), OPTION_FLAG_DISABLED)
        AddTextOption("Total Punishment Score", StorageUtil.GetIntValue(PlayerRef, "DF_Enslaved_TotalPunishCount", -1), OPTION_FLAG_DISABLED)
        AddTextOption("All Punishment Score", StorageUtil.GetIntValue(PlayerRef, "DF_Enslaved_TotalPunishCount_AllFollowers", -1), OPTION_FLAG_DISABLED)
        AddEmptyOption()
        OID_Test = AddTextOption("TEST 1", "CLICK TO TEST")
        OID_Test2 = AddTextOption("TEST 2", "CLICK TO TEST")
    EndIf
    
EndFunction


Function DoHelpPageMenu()

    SetCursorFillMode(LEFT_TO_RIGHT)

    AddHeaderOption("$DF_HELP_HEADER")
    AddHeaderOption("")

    OID_helpIntro_1             = AddTextOption("$DF_ABOUT_INTRO_1", "$DF_CLICK_TO_READ")
    OID_helpIntro_2             = AddTextOption("$DF_ABOUT_INTRO_2", "$DF_CLICK_TO_READ")
    OID_helpDebt_1              = AddTextOption("$DF_ABOUT_DEBT_1", "$DF_CLICK_TO_READ")
    OID_helpDeals_1             = AddTextOption("$DF_ABOUT_DEALS_1", "$DF_CLICK_TO_READ")

    OID_helpWillpower_1         = AddTextOption("$DF_ABOUT_WILL_1", "$DF_CLICK_TO_READ")
    OID_helpResistance_1        = AddTextOption("$DF_ABOUT_RESISTANCE_1", "$DF_CLICK_TO_READ")
    OID_helpLives_1             = AddTextOption("$DF_ABOUT_LIVES_1", "$DF_CLICK_TO_READ")
    OID_helpSleep_1             = AddTextOption("$DF_ABOUT_SLEEP_1", "$DF_CLICK_TO_READ")

    OID_helpGames_1             = AddTextOption("$DF_ABOUT_GAMES_1", "$DF_CLICK_TO_READ")
    OID_helpDevices_1           = AddTextOption("$DF_ABOUT_DEVICES_1", "$DF_CLICK_TO_READ")
    OID_helpDevices_2           = AddTextOption("$DF_ABOUT_DEVICES_2", "$DF_CLICK_TO_READ")
    OID_helpDevices_3           = AddTextOption("$DF_ABOUT_DEVICES_3", "$DF_CLICK_TO_READ")

    OID_helpGoldControl_1       = AddTextOption("$DF_ABOUT_GOLDCONTROL_1", "$DF_CLICK_TO_READ")
    OID_helpGoldControl_2       = AddTextOption("$DF_ABOUT_GOLDCONTROL_2", "$DF_CLICK_TO_READ")
    OID_helpGambling_1          = AddTextOption("$DF_ABOUT_GAMBLING_1", "$DF_CLICK_TO_READ")
    OID_helpBoredom_1           = AddTextOption("$DF_ABOUT_BOREDOM_1", "$DF_CLICK_TO_READ")
    
    OID_helpFatigue_1           = AddTextOption("$DF_ABOUT_FATIGUE_1", "$DF_CLICK_TO_READ")
    OID_helpChaos_1             = AddTextOption("$DF_ABOUT_CHAOS_1", "$DF_CLICK_TO_READ")
    OID_helpPause_1             = AddTextOption("$DF_ABOUT_PAUSE_1", "$DF_CLICK_TO_READ")
    OID_helpDealConfiguration_1 = AddTextOption("$DF_ABOUT_DEAL_CONFIG_1", "$DF_CLICK_TO_READ") 

    OID_helpEnslavement_1       = AddTextOption("$DF_ABOUT_ENSLAVEMENT_1", "$DF_CLICK_TO_READ")
    OID_helpEnslavement_2       = AddTextOption("$DF_ABOUT_ENSLAVEMENT_2", "$DF_CLICK_TO_READ")
    OID_helpExclusion_1         = AddTextOption("$DF_ABOUT_EXCLUSION_1", "$DF_CLICK_TO_READ")
    OID_helpExclusion_2         = AddTextOption("$DF_ABOUT_EXCLUSION_2", "$DF_CLICK_TO_READ")

EndFunction


Function ShowClassicDealOptions(Int start, String name, Int stage)
    AddHeaderOption(name)
    If stage <= 0
        AddTextOption("$NO_DEAL_MADE_YET", "")
    Else
        If stage >= 1
            AddTextOption("$DF_DEAL1", DealInfos[start])
        EndIf
        If stage >= 2
            AddTextOption("$DF_DEAL2", DealInfos[start+1])
        EndIf
        If stage == 3
            AddTextOption("$DF_DEAL3", DealInfos[start+2])
        EndIf
        If stage == 4
            AddTextOption("$DF_DEAL3", DealInfos[start+3])
        EndIf
    EndIf
EndFunction

Event OnOptionInputOpen(int option) 

EndEvent

event OnOptionInputAccept(int a_option, string a_value)

    
    SetInputOptionValue(a_option, a_value)
endEvent


Event OnOptionHighlight(Int option)
    ; FOLDSTART - General
    If option == OID_MinimumContractSlider
        SetInfoText("$DF_MINIMUMCONTRACT_DESC")
    ElseIf option == OID_DebtDifficulty
        SetInfoText("$DF_DEBT_DIFFICULTY")
    ElseIf option == OID_CustomCurve
        SetInfoText("$DF_CUSTOM_CURVE_DESC")
    ElseIf option == OID_DebtPerDayLoLevel
        SetInfoText("$DF_DEBT_PER_DAY_LO_DESC")
    ElseIf option == OID_DebtPerDayHiLevel
        SetInfoText("$DF_DEBT_PER_DAY_HI_DESC")
    ElseIf option == OID_DailyDebtIncrement
        SetInfoText("$_DFDailyDebtIncrement_DESC")
    ElseIf option == OID_IntrestSlider
        SetInfoText("$DF_INTDAILY_DESC")
    ElseIf option == OID_DebtPerFollowerSlider
        SetInfoText("$DF_DEBTPERFLW_DESC")
    ElseIf option == OID_EnslavementSlider
        SetInfoText("$DF_MAXDEBT_DESC")
    ElseIf option == OID_EnslavFailSlider
        SetInfoText("$DF_SLAVEFAILDEBT_DESC")
    ElseIf option == OID_FreedomSlider
        SetInfoText("$DF_FREEDOMPRICE_DESC")
    ElseIf option == OID_HoursTillBillSlider
        SetInfoText("$DF_HOURSNEXTBILL_DESC")
    ElseIf option == OID_DFlowItemsPerRemovedSlider
        SetInfoText("$DF_PERCITEMSTAKEN_DESC")
    ElseIf option == OID_FollowerEventCDSlider
        SetInfoText("$DF_FLWCDOWNDAYS_DESC")
    ElseIf option == OID_ResistanceFatigueLimit
        SetInfoText("$DF_RESISTANCE_FATIGUE_LIMIT_DESC")
    ElseIf option == OID_DFPunDebtSlider
        SetInfoText("$DF_PUNISHDEBT_DESC")
    ElseIf option == OID_LivesSlider
        SetInfoText("$DF_FLWLIFES_DESC")
    ElseIf option == OID_WillText
        SetInfoText(("$DF_WILLPOWER_DESC"))
    ElseIf option == OID_ResistText
        SetInfoText("$DF_RESIST_DESC")
    ElseIf option == OID_FatigueText
        SetInfoText("$_DFFatigue_DESC")
        
    ElseIf option == OID_MinWillRegain
        SetInfoText("$DF_MIN_WILL_REGAIN_DESC")
    ElseIf option == OID_MaxWillRegain
        SetInfoText("$DF_MAX_WILL_REGAIN_DESC")
    ElseIf option == OID_DFMaxResistMCMSlider
        SetInfoText("$_DFMaxResistMCM_DESC")
    ElseIf option == OID_DFMaxResistMinSlider
        SetInfoText("$_DFMaxResistMin_DESC")
    ElseIf option == OID_DFMaxResistDevicesTog
        SetInfoText("$_DFMaxResistDevices_DESC")
        
    ElseIf option == OID_ResistanceWillSlider
        SetInfoText("$_DFResistanceWillDelta_DESC")
    ElseIf option == OID_ResistanceDealSlider
        SetInfoText("$_DFResistanceDealDelta_DESC")
    ElseIf option == OID_ResistanceLevelDelta
        SetInfoText("$_DFResistanceLevelDelta_DESC")
        
    ElseIf option == OID_FatigueRateSlider
        SetInfoText("$_DFFatigueRate_DESC")
    ElseIf option == OID_GoldPerFatigueSlider
        SetInfoText("$_DFGoldPerFatigue_DESC")
    ElseIf option== OID_DFAnimalContTog
        SetInfoText("$DFANIMALCONT_DESC")
    ElseIf option == OID_DFLivesFollowerRapeTog
        SetInfoText(("$DF_FLWVICTIMLIFELOST_DESC"))
    ElseIf option == OID_DflowEndlessModeTog
        SetInfoText(("$DF_DISABLE_REGULAR_SLAVERY_DESC"))
    ElseIf option==OID_SkipToTheEndTog ; Ignore deals when punished for excessive debt. Endless mode will not work with this.
        SetInfoText("$DF_SkipToTheEnd_DESC")
    ElseIf option == OID_DFLocNotiTog
        SetInfoText("$DF_LOCCHANGENOTI_DESC")
    ElseIf option == OID_DebtText
        SetInfoText("$DF_DEBT_DESC")
    ElseIf option == OID_BoredomIntervalSlider
        SetInfoText("$DF_BOREDOM_INTERVAL_DESC")
        
    ; FOLDEND - General


    ElseIf option == OID_SexPreferences
        SetInfoText("$DF_SEX_PREFERENCE_OPTION_DESC")
    ElseIf option == OID_DismissalOption
        SetInfoText("$DF_DISMISSAL_RESTRICTION_DESC")
    ElseIf option == OID_HardCoreMode
        SetInfoText("$DF_HARDCORE_MODE_DESC")
    ElseIf option == OID_ContractRemaining    
        SetInfoText("$DF_CONTRACTREMAIN_DESC")
    ElseIf option == OID_BoredomText
        SetInfoText("$DF_BOREDOM_DESC")
    ElseIf option == OID_DiscountText
        SetInfotext("$DF_DISCOUNT_DESC")
    ElseIf (option == OID_MaxTatsSlider)
        SetInfoText("$DF_MAXSLAVETATS_DESC")
    ElseIf (option == OID_DflowGoldModeMaxSlider)
        SetInfoText("$DF_GOLDMODMAX_DESC")
    ElseIf (option == OID_DflowGoldModeMinSlider)
        SetInfoText("$DF_GOLDMODMIN_DESC")
        
    ElseIf option == OID_DfcSlaverySlider
        SetInfoText("$DF_DFCSLAVECHANCE_DESC")
    ElseIf option == OID_LolaSlider
        SetInfoText("$DF_LOLACHANCE_DESC")
    ElseIf option == OID_SimplePerSlider
        SetInfoText("$DF_SSLVCHANCE_DESC")
    ElseIf option == OID_EnableTog
    
    ElseIf option == OID_EndlessSoldWeight
        SetInfoText("$DF_ENDLESS_SOLD_WT_DESC")
    ElseIf option == OID_EndlessSlaveWeight
        SetInfoText("$DF_ENDLESS_SLAVE_WT_DESC")
    ElseIf option == OID_EndlessLolaWeight
        SetInfoText("$DF_ENDLESS_LOLA_WT_DESC")
    ElseIf option == OID_EndlessAuctionWeight
        SetInfoText("$DF_ENDLESS_AUCT_WT_DESC")
    
        SetInfoText("$DF_MODPAUSED_DESC")
    ElseIf option == OID_ResetTog
        SetInfoText("$DF_RESET_DESC")
    ElseIf option == OID_RestoreControls
        SetInfoText("$DF_RESTORE_CTLS_DESC")
    ElseIf option == OID_AddDebtDebug100
        SetInfoText("$DF_ADD100DEBT_DESC")
    ;ElseIf option == OID_DebugDiaTog
    ;    SetInfoText("$DF_BLOCKDIAL_DESC")
    ElseIf option == OID_AddDebtDebugTog
        SetInfoText("$DF_ADD1KDEBT_DESC")
    ElseIf option == OID_DebugResistance
        SetInfoText("$DF_DEBUG_RESISTANCE_DESC")
    ElseIf option == OID_DebugBoredom
        SetInfoText("$DF_DEBUG_BOREDOM_DESC")
    ElseIf option == OID_AddFollowerDebug
        SetInfoText("$DF_DEBUGADDFLW_DESC")
    ElseIf (option == OID_DflowDealBasePriceSlider)
        SetInfoText("$DF_GOLDREMDEAL_DESC")
    ElseIf (option == OID_DflowDealBaseDebtSlider)
        SetInfoText("$DF_DEALREMDEBT_DESC")
    ElseIf (option == OID_DflowDealBaseDaysSlider)
        SetInfoText("$DF_DEALDUR_DESC")
    ElseIf (option == OID_DflowDealMultiSlider)
        SetInfoText("$DF_EARLYREMMULT_DESC")
    ElseIf (option == OID_DFlowRemovalIncSlider)
        SetInfoText("$DF_PRICEINCRPERREM_DESC")
    ElseIf (option == OID_DFlowRemovalDebtTimesSlider)
        SetInfoText("$DF_COSTMULTDEPT_DESC")
    ElseIf (option == OID_DflowRemovalBasePriceSlider)
        SetInfoText("$DF_DEVREMBASEPRICE_DESC")
    ElseIf (option == OID_DFlowGambleJPotSlider)
        SetInfoText("$DF_JACKPOTVAL_DESC")
    ElseIf option == OID_DiscountLimitSlider
        SetInfoText("$DF_DISCOUNT_LIMIT_DESC")
    ElseIf option == OID_DeepDebtDifficulty
        SetInfoText("$DF_DEEP_DEBT_DIFFICULTY_DESC")
    
    ElseIf option == OID_Spanking
        SetInfoText("$DF_SPANKING_AVAIL_DESC")
    ElseIf option == OID_SpankingAnims
        SetInfoText("$DF_SPANKING_ANIMS_DESC")
    ElseIf option == OID_SpankingCode
        SetInfoText("$DF_SPANKING_CODE_DESC")
        
    ElseIf (option == OID_DflowGoldModeTog)
        SetInfoText(("$DF_GOLDM_DESC"))
    ElseIf (option == OID_DFlowWarmCompTog)
        SetInfoText("$DF_FFALLHELP_DESC")
    ElseIf (option == OID_SaveTog)
        SetInfoText("$DF_SAVESETT_DESC")
    ElseIf (option == OID_LoadTog)
        SetInfoText("$DF_LOADSETT_DESC")
    ElseIf option == OID_DFDebtperdayMaxSlider
        SetInfoText("$DF_MAXDAILYDEBT_DESC")
    ElseIf option == OID_DFDebtperdayMinSlider
        SetInfoText("$DF_MINDAILYDEBT_DESC")
    ElseIf option == OID_DFDebtMaxPLSlider
        SetInfoText("$DF_MAXDEBTPERLVL_DESC")
    ElseIf option == OID_DFDebtMinPLSlider
        SetInfoText("$DF_MINDEBTPERLVL_DESC")
    ElseIf option == OID_DFRemovalMaxSlider
        SetInfoText("$DF_MAXDEVREMPRICE_DESC")
    ElseIf option == OID_DFRemovalMinSlider
        SetInfoText("$DF_MINDEVREMPRICE_DESC")
    ElseIf option == OID_DFRemovalIncMaxSlider
        SetInfoText("$DF_MAXDEVREMINCR_DESC")
    ElseIf option == OID_DFRemovalIncMinSlider
        SetInfoText("$DF_MINDEVREMINCR_DESC")
    ElseIf option == OID_DFDealsMaxPriceSlider
        SetInfoText("$DF_MAXDEALREMCOST_DESC")
    ElseIf option == OID_DFDealsMinPriceSlider
        SetInfoText("$DF_MINDEALREMCOST_DESC")
    ElseIf option == OID_DFDealsMaxDebtSlider
        SetInfoText("$DF_MAXDEBTREMDEAL_DESC")
    ElseIf option == OID_DFDealsMinDebtSlider
        SetInfoText("$DF_MINDEBTREMDEAL_DESC")
    ElseIf option == OID_DFDealsMaxPTimeSlider
        SetInfoText("$DF_MAXDEALDUR_DESC")
    ElseIf option == OID_DFDealsMinPTimeSlider
        SetInfoText("$DF_MINDEALDUR_DESC")
    ElseIf option == OID_DFLivesChaoMaxSlider
        SetInfoText("$DF_MAXLIFES_DESC")
    ElseIf option == OID_DFLivesChaoMinSlider
        SetInfoText("$DF_MINLIFES_DESC")
    ElseIf option == OID_DFChaosPercentSlider
        SetInfoText("$DF_MAXDAILYDEBTCHANGEPERC_DESC")
    ElseIf option == OID_DFChaosDaysSlider
        SetInfoText("$DF_DAYSTILLCHAOSREROLL_DESC")
    ElseIf option == OID_DFDealsMaxMultiSlider
        SetInfoText("$DF_MAXDEALDAYMULT_DESC")
    ElseIf option == OID_DFDealsMinMultiSlider
        SetInfoText("$DF_MINDEALDAYMULT_DESC")
    ElseIf option == OID_DFChaoGoTog
        SetInfoText("$DF_ACTIVATECM_DESC")
    ElseIf option == OID_DFChaoConcealedTog
        SetInfoText("$DF_CONCELVAL_DESC")
    ElseIf option == OID_DFRemovalMultiMaxSlider
        SetInfoText("$DF_MAXDEVREMMULT_DESC")
    ElseIf option == OID_DFRemovalMultiMinSlider
        SetInfoText("$DF_MINDEVREMMULT_DESC")
    ElseIf option == OID_DFPunDebtMaxSlider
        SetInfoText("$DF_MAXPUNISHDEBT_DESC")
    ElseIf option == OID_DFPunDebtMinSlider
        SetInfoText("$DF_MINPUNISHDEBT_DESC")
    ElseIf option == OID_DFTheifsBoolTog
        SetInfoText("$DF_GOLD_THEFT_DESC")
    ElseIf option == OID_DFMaxStolenPerSlider
        SetInfoText("$DF_MAXGOLDSTOLEN_DESC")
    ElseIf option == OID_DFMinStolenPerSlider
        SetInfoText("$DF_MINGOLDSTOLEN_DESC")
    ElseIf option == OID_DFWillBoolTog
        SetInfoText("$DF_LESSWILLTHEFT_DESC")
    ElseIf option == OID_LicenseEnable
        SetInfoText("$DF_LICENSE_ENABLE_DESC")
    ElseIf option == OID_ForcedLicenses
        SetInfoText("$DF_LICENSE_FORCED_DESC")
    ElseIf option == OID_LicenseBasePrice
        SetInfoText("$DF_LICENSE_BASE_PRICE_DESC")
    ElseIf option == OID_LicenseMarkup
        SetInfoText("$DF_LICENSE_MARKUP_DESC")
    ElseIf option == OID_DFSWeightDSlider
        SetInfoText("$DF_DEALENSLAVE_DESC")
    ElseIf option == OID_DFSWeightESlider
        SetInfoText("$DF_NORMALENSLAVE_DESC")
    ElseIf option == OID_DFSWeightEDSlider
        SetInfoText("$DF_NORMALDEALENSLAVE_DESC")
    ElseIf option == OID_ScanTog
        SetInfoText("$DF_EXCLNPC_DESC")
    ElseIf option == OID_Scan2Tog
        SetInfoText("$DF_SSLVNPCSLAVER_DESC")
    ElseIf option ==OID_DFKeyDiffS
        SetInfoText("$DF_KEYDIF_DESC")
    ElseIf option ==OID_DFKConcealSlider
        SetInfoText("$DF_KEYCON_DESC")
    ElseIf option ==OID_DFRemovalModeS
        SetInfoText("$DF_REMOVAL_MODE_DESC")
    ElseIf option ==OID_DFGStay0Tog
        SetInfoText("$DF_STAYZERO_MODE_DESC")
    ElseIf option ==OID_DFGKnockDownTog
        SetInfoText("$DF_KNOCKDOWN_MODE_DESC")
    ElseIf option ==OID_DFGOtherTog
        SetInfoText("$DF_OTHER_MODE_DESC")
    ElseIf option ==OID_DFGDecaySlider
        SetInfoText("$DF_DECAY_MODE_DESC")
    ElseIf option ==OID_DFGRedGoldModSlider
        SetInfoText("$DF_REDMOD_MODE_DESC")
    ElseIf option ==OID_DFDealSCustArmorTog
        SetInfoText("$DF_SIGNCA_DESC")
    ElseIf option == OID_DFGCredToLeaveSlider
        SetInfoText("$DF_CRED2L_DESC")
        
    ElseIf option == OID_SpankingCooldown
        SetInfoText("$DF_SPANKING_COOLDOWN_DESC")
    ElseIf option == OID_ActualDealCountText
        SetInfoText("$DF_DEAL_COUNT_DESC")
    ElseIf option == OID_ExpectedDealCountText
        SetInfoText("$DF_EXPECTED_DEAL_COUNT_DESC")
    ElseIf option == OID_ExpectedDealLimitSlider
        SetInfoText("$DF_EXPECTED_DEAL_LIMIT_DESC")
    ElseIf option == OID_DealBias
        SetInfoText("$DF_DEAL_BIAS_DESC")
    ElseIf option==OID_DFSoldTog
        SetInfoText("$DF_SOLDACTIVE_DESC")
    ElseIf option == OID_debtReduction
        SetInfoText("$DF_PUNISHMENT_DEBT_REDUCTION_DESC")
    ElseIf option == OID_dealReduction
        SetInfoText("$DF_PUNISHMENT_DEAL_REDUCTION_DESC")

    ElseIf option==OID_DFSoldTimerMax
        SetInfoText("$DFSOLDTIMERMAX_DESC")
    ElseIf option==OID_DFSoldTimerMin
        SetInfoText("$DFSOLDTIMERMIN_DESC")
    ElseIf option==OID_DFSoldDeals
        SetInfoText("$DFSOLDDEALS_DESC")

    ElseIf option == OID_DFPotionQTog
        SetInfoText("$DF_POTIONENABLE_DESC")
    ElseIf option == OID_DFPotionQETog    
        SetInfoText("$DF_POTIONENABLEEVIL_DESC")
    ElseIf option == OID_DFPotionQSlider    
        SetInfoText("$DFPOTIONDEALS_DESC")
    ElseIf option == OID_DFPotionQESlider    
        SetInfoText("$DFPOTIONDEALSEVIL_DESC")
    ElseIf option == OID_DFPotionQDelayMin    
        SetInfoText("$DFPOTIONTIMERMIN_DESC")
    ElseIf option == OID_DFPotionQDelayMax    
        SetInfoText("$DFPOTIONTIMERMAX_DESC")
        
    ElseIf option==OID_DFShowRollMsgTog
        SetInfoText("$DF_SHOWROLLS_DESC")
    ElseIf option==OID_DFZAZAutoPause
        SetInfoText("$DF_AUTOPAUSE_DESC")
    ElseIf option == OID_PermitForceStart
        SetInfoText("$DF_ALLOW_FORCESTART_DESC")
    ElseIf option == OID_ToggleFollower
        SetInfoText("$DF_TOGGLE_FOLLOWER_DESC")
    ElseIf option==OID_DFDealSSignTog
        SetInfoText("$DFDEALSIGNTOG_DESC")

    ElseIf option==OID_DFMDTimerSlider
        SetInfoText("$DFMDTimer_Desc")
    ElseIf option==OID_LDCInitTog
        SetInfoText("$DF_LDCINITTOG_DESC")
    ElseIf option == OID_SendResumeTog
        SetInfoText("$DF_SENDRESUME_DESC")
    ElseIf option == OID_SuspendOutPut
        SetInfoText("$DF_SUSPEND_OUTPUT_DESC")
    ElseIf option == OID_EndScene
        SetInfoText("$DF_END_SCENE_DESC")
    ElseIf option == OID_RepairFollower
        SetInfoText("$DF_REPAIR_FOLLOWER_DESC")
    ElseIf option == OID_RemoveFollower
        SetInfoText("$DF_REMOVE_FOLLOWER_DESC")
    ElseIf option == OID_GetEnslaved
        SetInfoText("$DF_GET_ENSLAVED_DESC")
    ElseIf option == OID_SendForAuction
        SetInfoText("$DF_AUCTION_ME_DESC")
    ElseIf option == OID_AddSlaveKit
        SetInfoText("$DF_ADD_SLAVE_KIT_DESC")    
    ElseIf option == OID_AddChainsOfDebt
        SetInfoText("$DF_ADD_CHAINS_OF_DEBT_DESC")    
    ElseIf option == OID_AddBlindfold || option == OID_AddGag || option == OID_AddCollar || option == OID_AddNipplePiercing \
        || option == OID_AddBra || option == OID_AddHobbleDress || option == OID_AddArmCuffs || option == OID_AddGloves || option == OID_AddMittens \
        || option == OID_AddHeavyBondage || option == OID_AddCorsetHarness || option == OID_AddVaginalPiercing || option == OID_AddVaginalPlug \
        || option == OID_AddAnalPlug || option == OID_AddBelt || option == OID_AddLegCuffs || option == OID_AddBoots || option == OID_AddPetSuit
        SetInfoText("$DF_ADD_GENERIC_DESC")    
    ElseIf option == OID_AddPrisonerChains
        SetInfoText("$DF_ADD_PRISONER_CHAINS_DESC")    
    ElseIf option == OID_AddFullSet
        SetInfoText("$DF_ADD_FULL_SET_DESC")    
        
    ElseIf option == OID_RemoveHood || option == OID_RemoveBlindfold || option == OID_RemoveGag || option == OID_RemoveCollar || option == OID_RemoveNipplePiercing \
        || option == OID_RemoveBra || option == OID_RemoveHobbleDress || option == OID_RemoveArmCuffs || option == OID_RemoveGloves || option == OID_RemoveMittens \
        ||  option == OID_RemoveCorsetHarness || option == OID_RemoveVaginalPiercing || option == OID_RemoveVaginalPlug \
        || option == OID_RemoveAnalPlug || option == OID_RemoveBelt || option == OID_RemoveLegCuffs || option == OID_RemoveBoots 
        SetInfoText("$DF_REMOVE_GENERIC_DESC")
    ElseIf option == OID_RemoveHeavyBondage
        SetInfoText("$DF_REMOVE_HEAVY_BONDAGE_DESC")
    ElseIf option == OID_RemoveSuit
        SetInfoText("$DF_REMOVE_SUIT_DESC")
        
    ElseIf option == OID_AFTcount
        SetInfoText("$DF_AFT_PRESENT")
    ElseIf option == OID_EFFcount
        SetInfoText("$DF_EFF_PRESENT")
    ElseIf option == OID_NFFcount
        SetInfoText("$DF_NFF_PRESENT")
    ElseIf option == OID_ExpensiveDeal
        SetInfoText("$DF_EXPENSIVE_DEAL_DESC")
        
    ElseIf option == OID_ExploreDifficulty
        SetInfoText("$DF_EXPLORE_DIFFICULTY_DESC")
    ElseIf option == OID_ExploreExponent
        SetInfoText("$DF_EXPLORE_EXPONENT_DESC")
    ElseIf option == OID_ExploreLoPrice
        SetInfoText("$DF_EXPLORE_LO_PRICE_DESC")
    ElseIf option == OID_ExploreHiPrice
        SetInfoText("$DF_EXPLORE_HI_PRICE_DESC")
    ElseIf option == OID_CopyToSettings
        SetInfoText("$COPY_TO_SETTINGS_DESC")
        
    ElseIf option == OID_helpIntro_1
        SetInfoText("$DF_ABOUT_INTRO_1_DESC")
    ElseIf option == OID_helpIntro_2
        SetInfoText("$DF_ABOUT_INTRO_2_DESC")
    ElseIf option == OID_helpDebt_1
        SetInfoText("$DF_ABOUT_DEBT_1_DESC")
    ElseIf option == OID_helpDeals_1
        SetInfoText("$DF_ABOUT_DEALS_1_DESC")
    ElseIf option == OID_helpWillpower_1
        SetInfoText("$DF_ABOUT_WILL_1_DESC")
    ElseIf option == OID_helpResistance_1
        SetInfoText("$DF_ABOUT_RESISTANCE_1_DESC")
    ElseIf option == OID_helpLives_1
        SetInfoText("$DF_ABOUT_LIVES_1_DESC")
    ElseIf option == OID_helpSleep_1
        SetInfoText("$DF_ABOUT_SLEEP_1_DESC")
    ElseIf option == OID_helpGames_1
        SetInfoText("$DF_ABOUT_GAMES_1_DESC")
    ElseIf option == OID_helpDevices_1
        SetInfoText("$DF_ABOUT_DEVICES_1_DESC")
    ElseIf option == OID_helpDevices_2
        SetInfoText("$DF_ABOUT_DEVICES_2_DESC")
    ElseIf option == OID_helpDevices_3
        SetInfoText("$DF_ABOUT_DEVICES_3_DESC")
    ElseIf option == OID_helpGoldControl_1
        SetInfoText("$DF_ABOUT_GOLDCONTROL_1_DESC")
    ElseIf option == OID_helpGoldControl_2
        SetInfoText("$DF_ABOUT_GOLDCONTROL_2_DESC")
    ElseIf option == OID_helpGambling_1
        SetInfoText("$DF_ABOUT_GAMBLING_1_DESC")
    ElseIf option == OID_helpBoredom_1
        SetInfoText("$DF_ABOUT_BOREDOM_1_DESC")
    ElseIf option == OID_helpFatigue_1
        SetInfoText("$DF_ABOUT_FATIGUE_1_DESC")
    ElseIf option == OID_helpChaos_1
        SetInfoText("$DF_ABOUT_CHAOS_1_DESC")
    ElseIf option == OID_helpPause_1
        SetInfoText("$DF_ABOUT_PAUSE_1_DESC")
    ElseIf option == OID_helpDealConfiguration_1
        SetInfoText("$DF_ABOUT_DEAL_CONFIG_1_DESC")
    ElseIf option == OID_helpEnslavement_1
        SetInfoText("$DF_ABOUT_ENSLAVEMENT_1_DESC")
    ElseIf option == OID_helpEnslavement_2
        SetInfoText("$DF_ABOUT_ENSLAVEMENT_2_DESC")
    ElseIf option == OID_helpExclusion_1
        SetInfoText("$DF_ABOUT_EXCLUSION_1_DESC")
    ElseIf option == OID_helpExclusion_2
        SetInfoText("$DF_ABOUT_EXCLUSION_2_DESC")
    Endif
    
    String rulePath = StorageUtil.GetStringValue(none, "DF_RULE_STATUS_" + option, "")
    if rulePath != ""
        Debug.Trace("DF - SetInfoText - Rule = " + rulePath)
        SetInfoText(DealManager.GetRuleInfo(rulePath))
    endIf
EndEvent


Function SetTextOptionWorking(Int option)
    SetTextOptionValue(option, "$DF_WORKING")
    SetOptionFlags(option, OPTION_FLAG_DISABLED)
EndFunction

Function SetTextOptionDone(Int option, Bool reAllow = False)
    If reAllow
        SetTextOptionValue(option, "$DF_CLICK_ME")
        SetOptionFlags(option, OPTION_FLAG_NONE)
    Else
        SetTextOptionValue(option, "$DF_DONE")
    EndIf
EndFunction


Event OnOptionMenuOpen(Int option)

    If option == OID_DebtDifficulty
        SetMenuDialogStartIndex(DebtDifficulty)
        SetMenuDialogDefaultIndex(3)
        SetMenuDialogOptions(debtExponentNames)
        
    ElseIf option == OID_ExploreDifficulty
        SetMenuDialogStartIndex(exploreDifficulty)
        SetMenuDialogDefaultIndex(3)
        SetMenuDialogOptions(debtExponentNames)
        
    ElseIf option == OID_SexPreferences
        SetMenuDialogStartIndex(SexPreferenceIndex)
        SetMenuDialogDefaultIndex(0)
        SetMenuDialogOptions(sexPreferenceOptions)
        
    ElseIf option == OID_DismissalOption
        SetMenuDialogStartIndex(DismissalIndex)
        SetMenuDialogDefaultIndex(0)
        SetMenuDialogOptions(dismissalOptions)
    ElseIf option == OID_RulesCurrentGroup
        SetMenuDialogStartIndex(groupIndex)
        SetMenuDialogDefaultIndex(0)
        SetMenuDialogOptions(groupNames)
    EndIf

EndEvent

Event OnOptionMenuAccept(Int option, Int index)

    If option == OID_DebtDifficulty
        DebtDifficulty = index
        SetMenuOptionValue(option, debtExponentNames[index])
        
        Int editCurve = OPTION_FLAG_DISABLED
        If 7 == DebtDifficulty
            editCurve = OPTION_FLAG_NONE
        EndIf
        SetOptionFlags(OID_CustomCurve, editCurve)
        
        Float exponent = debtExponents[index]
        _DflowDebtExponent.SetValue(exponent)
        CalculateScaledDebts()
        
    ElseIf option == OID_ExploreDifficulty
        exploreDifficulty = index
        SetMenuOptionValue(option, debtExponentNames[index])
        ForcePageReset()
        
    ElseIf option == OID_SexPreferences
        SexPreferenceIndex = index
        SetMenuOptionValue(option, sexPreferenceOptions[index])
        Tool.SetScanGenders(index)
        
    ElseIf option == OID_DismissalOption
        DismissalIndex = index
        SetMenuOptionValue(option, dismissalOptions[index])
        SetDismissalRules(index)
    elseIf option == OID_RulesCurrentGroup
        groupIndex = index
        SetMenuOptionValue(option, groupNames[index])
        ForcePageReset()
    EndIf
    
EndEvent

Event OnOptionSelect(Int option)

    Keyword addItemKeyword = None
    Keyword removeItemKeyword = None

    If option == OID_EnableTog
    
        If Pause.GetValue() != 0.0
            Pause.SetValue(0.0) ; PAUSED - change immediately so menu works... These are set by the pause code too. But later.
            SetToggleOptionValue(OID_EnableTog, True)
        Else
            Pause.SetValue(1.0) ; NOT PAUSED
            _DFPauseModsList.Revert() ; Forcing unpaused, clear the pause list...
            SetToggleOptionValue(OID_EnableTog, False)
        EndIf
        
        Int eventHandle = ModEvent.Create("DF-Pause")
        If eventHandle
            ModEvent.PushBool(eventHandle, 0.0 == Pause.GetValue()) ; true if pausing, false if resuming.
            ModEvent.PushForm(eventHandle, Q) ; The form that is the event source - be consistent.
            ModEvent.Send(eventHandle)
        EndIf

    ElseIf option == OID_SendResumeTog
    
        SetTextOptionWorking(option)
        Tick.UnblockEvents()
        Tool.ResumeAll()
        Game.SetPlayerAIDriven(False)
        If tick.Suspend == 1 && Tool.Suspend == 0
            SetTextOptionValue(OID_SuspendOutPut, "$DF_SUSPENDOTHER")
        ElseIf Tick.Suspend == 1 && Tool.Suspend == 1
            SetTextOptionValue(OID_SuspendOutPut, "$DF_SUSPENDMOD")
        Else
            SetTextOptionValue(OID_SuspendOutPut, "$DF_SUSPENDOK")
        EndIf
        Utility.WaitMenuMode(1.0)
        SetTextOptionDone(option)
        
    ElseIf option == OID_ResetTog
    
        SetTextOptionWorking(option)
        ResetQuests()
        Utility.WaitMenuMode(1.0)
        SetTextOptionDone(option)
        Reseted.Show()
        
    ElseIf option == OID_RestoreControls
    
        SetTextOptionWorking(option)
        Utility.Wait(0.3) ; Block
        Debug.Notification("$DF_RESTORE_CTLS_START")
        Game.DisablePlayerControls(true, true, true,  true, true, true,  true, true, 0)
        Game.SetPlayerAIDriven(true)
        ; It's possible the player is stuck because they can't move, not because their controls are disabled.
        PlayerRef.SetAV("SpeedMult", 100.0)
        PlayerRef.ForceAV("SpeedMult", 100.0)
        PlayerRef.RestoreAV("SpeedMult", 100.0)
        PlayerRef.SetAV("Paralysis", 0.0)
        PlayerRef.ForceAV("Paralysis", 0.0)
        Utility.Wait(3.0) ; This wait is to let Skyrim sort out its internal AI drive state and let scripts catch up
        Game.SetPlayerAIDriven(false)
        ; Clearly, you can just call EPC any time and it's virtually instant. However, in most cases, it isn't enough.
        Game.EnablePlayerControls(true, true, true,  true, true, true,  true, true, 0)
        Debug.Notification("$DF_RESTORE_CTLS_END")
        
    ; ElseIf option == OID_DebugDiaTog
        ; This item is no longer in the menu - it used to toggle 'Dia' which contained _DflowDiaToggle
        ; This used to be set to 1 to enable the old blocking dialogs.
        ; Those haven't really been supported since late 1.X and always caused problems.
        ; I'm now actively stripping them out.

    ElseIf option == OID_EndScene
    
        SetTextOptionWorking(option)
        Tick.UnblockEvents()
        Tool.EndScene()
        Utility.WaitMenuMode(3.0)
        If playerref.GetCurrentScene()
            SetTextOptionValue(option, "$DF_FAILED")
        Else
            SetTextOptionValue(option, "$DF_DONE")
        EndIf
        
    ElseIf option == OID_RepairFollower
        SetTextOptionWorking(option)
        ;Q.RepairFollower()
        They()
        Utility.WaitMenuMode(3.0)
        SetTextOptionValue(option, "$DF_DONE")

    ElseIf option == OID_RemoveFollower
        SetTextOptionValue(option, "$DF_EXIT_MCM")
        Q.ExternalRemoveFollower() ; As if SS were doing it.
        ResetQuests(True) ; Reset will, resist, strange potion, etc.
        Utility.Wait(1.0)
        
    ElseIf option == OID_GetEnslaved
        SetTextOptionValue(option, "$DF_EXIT_MCM")
        SetOptionFlags(option, OPTION_FLAG_DISABLED)
        Utility.Wait(0.3)
        Q.EnslaveDirect()
        
    ElseIf option == OID_SendForAuction
        SetTextOptionValue(option, "$DF_EXIT_MCM")
        SetOptionFlags(option, OPTION_FLAG_DISABLED)
        Utility.Wait(0.3)
        
        If Tool.HaveSimpleSlavery()
            ; Enslave via Simple Slavery - if it exists
            SendModEvent("PlayerRefEnslaved")
            ; Fake version for testing, skips the auction.
            SendModEvent("SSLV Entry", "", 0.0)
            Utility.Wait(30.0)
            SendModEvent("DFEnslave", "", 0.0)
        EndIf
        Utility.Wait(10.0)
        
    ElseIf option == OID_AddDebtDebug100
    
        SetTextOptionWorking(option)
        Q.Debt(100)
        Utility.WaitMenuMode(0.7)
        SetTextOptionDone(option, True)
        
    ElseIf option == OID_AddDebtDebugTog
    
        SetTextOptionWorking(option)
        Q.Debt(1000)
        Utility.WaitMenuMode(0.7)
        SetTextOptionDone(option, True)
        
    ElseIf option == OID_DebugResistance
    
        SetTextOptionWorking(option)
        Tool.ReduceResistFloat(1.0)
        ;SendModEvent("DF-ResistanceLossWithSeverity", "1", 10.0)
        Utility.WaitMenuMode(0.3)
        SetTextOptionDone(option, True)
        
    ElseIf option == OID_DebugBoredom

        SetTextOptionWorking(option)
        _DFBoredom.SetValue(_DFBoredom.GetValue() + 1.0)
        Utility.WaitMenuMode(0.3)
        SetTextOptionDone(option, True)
    
    ElseIf option == OID_AddFollowerDebug
    
        Q.Delay = 0.0 ; This is a delay that cooldowns normal recruitment, but reset it here as it may resolve some player bugs
        If ADFD.GetValue() == 1
            ADFD.SetValue(0)
            SetToggleOptionValue(option, False)
        ElseIf ADFD.GetValue() == 0
            ADFD.SetValue(1)
            SetToggleOptionValue(option, True)
        EndIf
        
    ElseIf option == OID_DFLivesFollowerRapeTog
    
        If _DFLivesFollowerRape.GetValue() == 1
            _DFLivesFollowerRape.SetValue(0)
            SetToggleOptionValue(OID_DFLivesFollowerRapeTog, False)
        ElseIf _DFLivesFollowerRape.GetValue() == 0
            _DFLivesFollowerRape.SetValue(1)
            SetToggleOptionValue(OID_DFLivesFollowerRapeTog, True)
        EndIf
        
    ElseIf option == OID_DflowEndlessModeTog
        If _DflowEndlessMode.GetValue() == 1
            SetToggleOptionValue(option, False)
            _DflowEndlessMode.SetValue(0)
        ElseIf _DflowEndlessMode.GetValue() == 0
            SetToggleOptionValue(option, True)
            _DflowEndlessMode.SetValue(1)
            ; Endless mode disables skip to the end.
            SkipToTheEnd = False
            SetToggleOptionValue(OID_SkipToTheEndTog, False)
        EndIf
        
    ElseIf option == OID_DflowGoldModeTog
    
        ; Gah! Active and Enabled are back to front here.
        If GoldCont.Active == 1 && GoldCont.Enabled == 0
            GoldCont.Active = False
            SetToggleOptionValue(option, False)
        ElseIf  GoldCont.Active == 0
            GoldCont.Active = True
            SetToggleOptionValue(option, True)
        EndIf
        
    ElseIf option == OID_DFlowWarmCompTog
    
        If 0 != _DFlowWarmComp.GetValue()
            _DFlowWarmComp.SetValue(0)
            SetToggleOptionValue(option, False)
        Else
            _DFlowWarmComp.SetValue(1)
            SetToggleOptionValue(option, True)
        Endif
        
    ElseIf option == OID_LoadTog
    
        SetTextOptionWorking(option)
        If ShowMessage("$DF_LOAD_MSG")
            ImportSettings()
            ForcePageReset()
        Else
            SetTextOptionDone(option, True) ; Allow player to click again if they didn't load
        EndIf
        
    ElseIf option == OID_SaveTog
    
        SetTextOptionWorking(option)
        If ShowMessage("$DF_SAVE_MSG")
            ExportSettings()
            SetTextOptionDone(option) ; Save doesn't need a page reset ... what was that all about?
        Else
            SetTextOptionDone(option, True) ; Allow player to click again if they didn't save
        EndIf
        
    ElseIf option == OID_DFChaoGoTog

        _DFChaoGo = !_DFChaoGo
        SetToggleOptionValue(OID_DFChaoGoTog, _DFChaoGo)
        If _DFChaoGo
            ;If ShowMessage("$DF_CHAOSM_MESG")
            ; Don't need to warn now, can just turn Chaos on.
            Chaos(True)
            ForcePageReset()
        EndIf
        
    ElseIf option == OID_DFChaoConcealedTog
    
        _DFChaoConcealed = !_DFChaoConcealed
        SetToggleOptionValue(option, _DFChaoConcealed)
        ForcePageReset()
        
    ElseIf option == OID_DFTheifsBoolTog
    
        _DFTheifsBool = !_DFTheifsBool
        SetToggleOptionValue(option, _DFTheifsBool)
        
    ElseIf option == OID_DFWillBoolTog
    
        _DFWillBool = !_DFWillBool
        SetToggleOptionValue(option, _DFWillBool)
        
    ElseIf option == OID_ScanTog ; Disable NPC from DF
    
        If ShowMessage("$DF_EXITMENU_MSG")
            SetTextOptionWorking(option)
            IgnoreFollowers()
        EndIf
        
    ElseIf option == OID_Scan2Tog ; Add NPC as slaver
    
        If HaveValidSlaverTarget()
            SetTargetAsSlaverForSS()
            SetOptionFlags(option, OPTION_FLAG_DISABLED)
        EndIf
    
    ElseIf option == OID_DFLocNotiTog
    
        _DFLocNoti = !_DFLocNoti
        SetToggleOptionValue(option, _DFLocNoti)
    
    ElseIf option == OID_DFKeyDiffS
    
        If   _DFKeyDiffI == 0
            _DFKeyDiffI = 1
            _DFKeyDiffS = "$DF_KEYDIF_NORMAL"
        ElseIf _DFKeyDiffI == 1
            _DFKeyDiffI = 2
            _DFKeyDiffS = "$DF_KEYDIF_HARD"
        ElseIf _DFKeyDiffI == 2
            _DFKeyDiffI = 3
            _DFKeyDiffS = "$DF_KEYDIF_DEVIOUS"
        ElseIf  _DFKeyDiffI == 3
            _DFKeyDiffI = 4
            _DFKeyDiffS = "$DF_KEYDIF_SLAVE"
        ElseIf  _DFKeyDiffI == 4
            _DFKeyDiffI = 0
            _DFKeyDiffS = "$DF_KEYDIF_EASY"
        EndIf
        SetTextOptionValue(OID_DFKeyDiffS, _DFKeyDiffS)
        
    ElseIf option == OID_DFRemovalModeS
        ; 0 = full removal, 1 = limited removal, 2 = no removal
        If   _DFRemovalMode == 0
            _DFRemovalMode = 1
            _DFRemovalModeS = "$DF_REMOVAL_LIMITED"
        ElseIf _DFRemovalMode == 1
            _DFRemovalMode = 2
            _DFRemovalModeS = "$DF_REMOVAL_OFF"
        ElseIf _DFRemovalMode == 2
            _DFRemovalMode = 0
            _DFRemovalModeS = "$DF_REMOVAL_FULL"
        EndIf
        
        SetTextOptionValue(OID_DFRemovalModeS, _DFRemovalModeS)
        
    ElseIf option == OID_DFGStay0Tog
    
        GoldCont.Stay0 = !GoldCont.Stay0
        SetToggleOptionValue(option, GoldCont.Stay0)
        
    ElseIf option == OID_DFGKnockDownTog
    
        GoldCont.KnockDown = !GoldCont.KnockDown
        SetToggleOptionValue(option, GoldCont.KnockDown)
        
    ElseIf option == OID_DFGOtherTog
    
        GoldCont.Other = !GoldCont.Other
        SetToggleOptionValue(option, GoldCont.Other)
        
    ElseIf option == OID_DFDealSCustArmorTog
    
        _DFDealSCustArmor = !_DFDealSCustArmor
        SetToggleOptionValue(option, _DFDealSCustArmor)
        
    ElseIf option == OID_DFAnimalContTog
    
        _DFAnimalCont = !_DFAnimalCont
        SetToggleOptionValue(option, _DFAnimalCont)
        
    ElseIf option == OID_HardCoreMode
    
        _DFHardcoreMode.SetValue(1.0)
        ForcePageReset()
    ElseIf option == OID_DFSoldTog
    
        If DSold.Active
            DSold.Active = False
            DSold.Enable = False
        Else
            DSold.Active = True
        EndIf 
        SetToggleOptionValue(option, DSold.Active)
        
    ElseIf option == OID_LicenseEnable
    
        licenseStatusEnabledNew = !licenseStatusEnabledNew
        SetToggleOptionValue(option, licenseStatusEnabledNew)
        
    ElseIf option == OID_ForcedLicenses    
    
        GoldCont.IsEnabledForcedLicenseControl = !GoldCont.IsEnabledForcedLicenseControl
        SetToggleOptionValue(option, GoldCont.IsEnabledForcedLicenseControl)
        
    ElseIf option == OID_DFShowRollMsgTog
    
        _DFShowRollMsg = !_DFShowRollMsg
        SetToggleOptionValue(option, _DFShowRollMsg)
        
    ElseIf option == OID_DFZAZAutoPause
    
        _DFZAZAutoPause = !_DFZAZAutoPause
        SetToggleOptionValue(option, _DFZAZAutoPause)
        
    ElseIf option == OID_PermitForceStart
    
        If _DFAllowForceStart.GetValue() == 0.0
            _DFAllowForceStart.SetValue(1.0)
            SetToggleOptionValue(option, True)
        Else
            _DFAllowForceStart.SetValue(0.0)
            SetToggleOptionValue(option, False)
            
            _DFlowForcedStart.JustStopIt()
        EndIf
    Elseif option == OID_FNISCompatibility
        FNISCompatibility = !FNISCompatibility
        SetToggleOptionValue(option, FNISCompatibility)
    ElseIf option == OID_ToggleFollower
    
        If HaveValidToggleActorTarget()
            Bool enabled = ToggleActorEnable()
            If enabled
                SetTextOptionValue(option, "$DF_TOGGLE_FOLLOWER_DISABLE")
            Else
                SetTextOptionValue(option, "$DF_TOGGLE_FOLLOWER_ENABLE")
            EndIf
        EndIf
        
    ElseIf option == OID_DFDealSSignTog
    
        If (DealS As _DDeal).Stat == 0
            (DealS As _DDeal).Stat = 1
            SetToggleOptionValue(OID_DFDealSSignTog, True)
        Else
            (DealS As _DDeal).Stat = 0
            SetToggleOptionValue(OID_DFDealSSignTog, False)
        EndIf
            
    ElseIf option == OID_DFPotionQTog
    
        DFPotQ.Enabled = !DFPotQ.Enabled
        SetToggleOptionValue(option, DFPotQ.Enabled)
        
    ElseIf option == OID_DFPotionQETog 

        DFPotQ.EnabledEvil = !DFPotQ.EnabledEvil
        SetToggleOptionValue(option, DFPotQ.EnabledEvil)
        
    ElseIf option == OID_DFMaxResistDevicesTog
    
        _DFMaxResistDevices = !_DFMaxResistDevices
        SetToggleOptionValue(option, _DFMaxResistDevices)
        
    ElseIf option == OID_SkipToTheEndTog
    
        SkipToTheEnd = !SkipToTheEnd
        SetToggleOptionValue(option, SkipToTheEnd)
        If SkipToTheEnd
            ; Skip to the end disables endless mode.
            _DflowEndlessMode.SetValue(0)
            SetToggleOptionValue(OID_DflowEndlessModeTog, 0)
        EndIf
        
    ElseIf option == OID_LDCInitTog
    
        SetTextOptionWorking(option)
        LDC.Init()
        Utility.WaitMenuMode(1.0)
        SetTextOptionDone(option)
    
    ElseIf option == OID_AddSlaveKit
        SetTextOptionValue(option, "$DF_EXIT_MCM")
        SetOptionFlags(option, OPTION_FLAG_DISABLED)
        Q.FitSlaveKit()
    ElseIf option == OID_AddChainsOfDebt
        SetTextOptionValue(option, "$DF_EXIT_MCM")
        SetOptionFlags(option, OPTION_FLAG_DISABLED)
        Tool.FitChainsOfDebt()
    ElseIf option == OID_AddBlindfold
        addItemKeyword = LDC.Libs.zad_DeviousBlindfold
    ElseIf option == OID_AddGag
        addItemKeyword = LDC.Libs.zad_DeviousGag
    ElseIf option == OID_AddCollar
        addItemKeyword = LDC.Libs.zad_DeviousCollar
    ElseIf option == OID_AddNipplePiercing
        addItemKeyword = LDC.Libs.zad_DeviousPiercingsNipple
    ElseIf option == OID_AddBra
        addItemKeyword = LDC.Libs.zad_DeviousBra
    ElseIf option == OID_AddHobbleDress
        addItemKeyword = LDC.Libs.zad_DeviousHobbleSkirt
    ElseIf option == OID_AddArmCuffs
        addItemKeyword = LDC.Libs.zad_Deviousarmcuffs
    ElseIf option == OID_AddGloves
        addItemKeyword = LDC.Libs.zad_DeviousGloves
    ElseIf option == OID_AddMittens
        addItemKeyword = LDC.Libs.zad_DeviousBondageMittens
    ElseIf option == OID_AddHeavyBondage
        addItemKeyword = LDC.Libs.zad_DeviousArmbinder
    ElseIf option == OID_AddCorsetHarness
        addItemKeyword = LDC.Libs.zad_DeviousCorset
    ElseIf option == OID_AddVaginalPiercing
        addItemKeyword = LDC.Libs.zad_DeviousPiercingsVaginal
    ElseIf option == OID_AddVaginalPlug
        addItemKeyword = LDC.Libs.zad_DeviousPlugVaginal
    ElseIf option == OID_AddAnalPlug
        addItemKeyword = LDC.Libs.zad_DeviousPlugAnal
    ElseIf option == OID_AddBelt
        addItemKeyword = LDC.Libs.zad_DeviousBelt
    ElseIf option == OID_AddLegCuffs
        addItemKeyword = LDC.Libs.zad_DeviousLegCuffs
    ElseIf option == OID_AddBoots
        addItemKeyword = LDC.Libs.zad_DeviousBoots
    ElseIf option == OID_AddPrisonerChains
        SetTextOptionValue(option, "$DF_EXIT_MCM")
        SetOptionFlags(option, OPTION_FLAG_DISABLED)
        Tool.FitPrisonerChains()
    ElseIf option == OID_AddPetSuit
        addItemKeyword = LDC.Libs.zad_DeviousPetSuit
    ElseIf option == OID_AddWhoreArmor
        Tool.GiveWhoreArmor(false)
    ElseIf option == OID_AddFullSet
        SetTextOptionValue(option, "$DF_EXIT_MCM")
        SetOptionFlags(option, OPTION_FLAG_DISABLED)
        Tool.FitFullSet()

    ElseIf option == OID_RemoveHood
        removeItemKeyword = LDC.Libs.zad_DeviousHood
    ElseIf option == OID_RemoveBlindfold
        removeItemKeyword = LDC.Libs.zad_DeviousBlindfold
    ElseIf option == OID_RemoveGag
        removeItemKeyword = LDC.Libs.zad_DeviousGag
    ElseIf option == OID_RemoveCollar
        removeItemKeyword = LDC.Libs.zad_DeviousCollar
    ElseIf option == OID_RemoveNipplePiercing
        removeItemKeyword = LDC.Libs.zad_DeviousPiercingsNipple
    ElseIf option == OID_RemoveBra
        removeItemKeyword = LDC.Libs.zad_DeviousBra
    ElseIf option == OID_RemoveHobbleDress
        SetTextOptionWorking(option)
        LDC.Libs.ManipulateGenericDeviceByKeyword(PlayerRef, LDC.Libs.zad_DeviousSuit, False )
        Utility.WaitMenuMode(2.0)
        LDC.Libs.ManipulateGenericDeviceByKeyword(PlayerRef, LDC.Libs.zad_DeviousHobbleSkirt, False )
        Utility.WaitMenuMode(2.0)
        SetTextOptionValue(option, "$DF_DONE")
    ElseIf option == OID_RemoveArmCuffs
        removeItemKeyword = LDC.Libs.zad_Deviousarmcuffs
    ElseIf option == OID_RemoveGloves
        removeItemKeyword = LDC.Libs.zad_DeviousGloves
    ElseIf option == OID_RemoveMittens
        SetTextOptionWorking(option)
        LDC.Libs.ManipulateGenericDeviceByKeyword(PlayerRef, LDC.Libs.zad_DeviousGloves, False )
        Utility.WaitMenuMode(2.0)
        LDC.Libs.ManipulateGenericDeviceByKeyword(PlayerRef, LDC.Libs.zad_DeviousBondageMittens, False )
        Utility.WaitMenuMode(2.0)
        SetTextOptionValue(option, "$DF_DONE")
    ElseIf option == OID_RemoveHeavyBondage
        removeItemKeyword = LDC.Libs.zad_DeviousHeavyBondage
    ElseIf option == OID_RemoveCorsetHarness
        removeItemKeyword = LDC.Libs.zad_DeviousCorset
    ElseIf option == OID_RemoveVaginalPiercing
        removeItemKeyword = LDC.Libs.zad_DeviousPiercingsVaginal
    ElseIf option == OID_RemoveVaginalPlug
        removeItemKeyword = LDC.Libs.zad_DeviousPlugVaginal
    ElseIf option == OID_RemoveAnalPlug
        removeItemKeyword = LDC.Libs.zad_DeviousPlugAnal
    ElseIf option == OID_RemoveBelt
        removeItemKeyword = LDC.Libs.zad_DeviousBelt
    ElseIf option == OID_RemoveLegCuffs
        removeItemKeyword = LDC.Libs.zad_DeviousLegCuffs
    ElseIf option == OID_RemoveBoots
        removeItemKeyword = LDC.Libs.zad_DeviousBoots
    ElseIf option == OID_RemoveSuit
        removeItemKeyword = LDC.Libs.zad_DeviousSuit
    ElseIf option == OID_Test
        ;RunTest2()
		;SetTextOptionWorking(option)
        ; AddTestDeal()
        ;AddTestItem()
        ;AddBHODeals()
        SetTextOptionWorking(option)
        StartTestGame()
        Utility.Wait(0.3)
        
    ElseIf option == OID_Test2
        ;RunTest2()
		;SetTextOptionWorking(option)
        ; AddTestDeal()
        ;AddTestItem()
        ;AddBHODeals()
        SetTextOptionWorking(option)
        StartTest2()
        Utility.Wait(0.3)
        
    ElseIf option == OID_CopyToSettings
        ; Copy cost explorer settings to real settings.
        DebtDifficulty = exploreDifficulty
        If 7 == exploreDifficulty
            CustomDifficultyCurve = exploreExponent
            debtExponents[7] = exploreExponent
        EndIf
        DebtPerDayLoLevel = exploreLoPrice
        DebtPerDayHiLevel = exploreHiPrice
        Float exponent = debtExponents[DebtDifficulty]
        _DflowDebtExponent.SetValue(exponent)
        CalculateScaledDebts()
        
    ElseIf option == OID_helpIntro_1
        Debug.MessageBox("Any follower that you recruit will become \"Devious\" unless you explicitly exclude them via an option in the MCM Debug menu.  Devious followers demand payment for their services, and regularly add debt.  If you can pay off the debt promptly everything is fine.  If you pay off all the debt you can dismiss the follower, though there is an option for a minimum contract period.  If you can't pay, the follower will look for ways to recover their money that you may not like.")
    ElseIf option == OID_helpIntro_2
        Debug.MessageBox("Devious followers will not let you dismiss them if they have minimum contract duration remaining, or you owe them any money. They also cannot be killed (they are set ESSENTIAL) because killing followers to escape debt would be trivially easy. If this causes a problem with your game, you can either set the follower to not be 'devious' at all, or you can PAUSE the mod.")
    ElseIf option == OID_helpDebt_1
        Debug.MessageBox("You can configure how often followers update your debt.  Whenever this period elapses, the follower will update what you owe them for their time.  As long as you have the money, and enough willpower, you can pay off some debt whenever you like.  If your debt grows too large, the follower will take action, possibly forcing you into deals, or enslaving you.")
    ElseIf option == OID_helpDeals_1
        Debug.MessageBox("When you make a deal, the follower reduces your debt by a configurable amount.  You are then stuck in the deal until you can pay it off.  The amount you have to pay back is configurable separately, so it can be more or less than the initial debt-relief.  Each deal has various rules, and more deals can be added for more debt reduction (and pay out cost).  The rules are usually designed to demoralize you and make you more reliant on the follower.")
        
    ElseIf option == OID_helpWillpower_1 
        Debug.MessageBox("Willpower is a value that ranges from a max of 10 down to 0.  Once your willpower gets below 7 or so, you'll start to see consequences.  A low willpower of 3 or less means you are easily bullied and will often do what others ask without question, even if it's bad for you.  If your willpower is low  the follower may only take deals instead of payment, but they won't cheat you outright.  You'll only be enslaved if your debt is high enough.")
    ElseIf option == OID_helpResistance_1
        Debug.MessageBox("When demoralizing things happen, your willpower isn't reduced directly, instead your *resistance* is reduced.  When your resistance hits zero, your willpower is reduced by a point and your resistance reset to a new maximum value.  You can configure how this maximum resistance varies in the MCM.  Resistance fatigue can build up and reduce your maximum resistance.")
    ElseIf option == OID_helpLives_1
        Debug.MessageBox("When your follower goes into bleedout, they lose a life.  If you have low willpower, paying for device removal also uses lives, and some other events may also consume lives.  When your follower has zero lives they won't talk to you about DF topics.  When you ask a follower about your debt, they'll tell you how tired they are, and their tiredness is based on how many lives they have left.")
    ElseIf option == OID_helpSleep_1
        Debug.MessageBox("When you sleep for six or more hours at once, you can regain some willpower.  Your follower will also sleep when you sleep (even if it doesn't look like they do) and will regain all their lives.  Sleeping for less than six hours doesn't do anything though, even if the sleep periods are very close together.  Your follower can also sleep by themselves in some cases, in which case they regain their lives, but you don't regain any willpower.")
        
    ElseIf option == OID_helpGames_1
        Debug.MessageBox("If you are stuck in some restraints, and your willpower is low, it's possible the follower will take advantage and start a bondage game with you.  If you have enough willpower you may be able to avoid the game in exchange for more debt.  These \"games\" invariably require you to have a lot of sex while restrained.  They can be bad for your resistance, and may seriously damage your willpower.  If you're asked to head to a stable go to one near a city.")
    ElseIf option == OID_helpDevices_1
        Debug.MessageBox("Many deals will require you to wear a certain kind of restraint or device.  Usually it does not matter exactly what the device looks like, as long as it's broadly of the correct type.  e.g. the corset deal will also allow a harness.  The follower doesn't lock the devices on you, but will punish you with debt if you don't fulfil the terms of your deals, so you are encouraged to keep yourself bound.  You can try to cheat if you want.")
    ElseIf option == OID_helpDevices_2
        Debug.MessageBox("If a restraint is locked onto you, and it seriously impairs your ability to make money, your follower make help remove it for a configurable fee.  The fee may increase with each successive removal.  If your willpower is low, removal may also use up follower lives.  If you have a peculiar device (DD BlockGeneric), the follower may be reluctant to help.  Try asking them just after waking up from a good sleep, and they may agree to remove those difficult devices in exchange for deals.")
    ElseIf option == OID_helpDevices_3
        Debug.MessageBox("Sometimes your follower will give you something specific to wear, like a pretty ring, or some skimpy armor.  In that case you can't just substitute something similar.  If you lose the item, the follower may replace it for you, but there will likely be a fee involved.")
        
    ElseIf option == OID_helpGoldControl_1
        Debug.MessageBox("By choice, or due to excessive debt, your follower may take control of your gold.  You cannot dismiss a follower while gold control is active.  The follower sets an 'agreed' amount of gold you get to carry. You can set the range of this value in the MCM.  When you change location, the follower adjusts your gold.  If you have excess, the follower takes it so you have the agreed amount.  Whenever you spend or lose it, the follower tops you up.   (Continued in next section...)")
    ElseIf option == OID_helpGoldControl_2
        Debug.MessageBox("If the follower adds gold to your carried amount, your debt goes up. If the follower takes excess gold from you, your credit increases.  Over the day, the amount you can carry will reduce. You can ask to carry more, and the follower might allow it (set how much in the MCM).  Sleep to reset your carried gold to a new agreed amount.  You're only told your current 'real' debt or credit after waking from a sleep; your follower likes to keep you guessing.")
    ElseIf option == OID_helpGambling_1
        Debug.MessageBox("If your follower has lives left, they can play two gambling games with you.  One allows you to win keys and the other allows you to win cash.  Typically, even if you get a good reward you will get a lot of debt.  The games are deliberately unfair.  Don't play if you can't afford it - it's easy to get big debts from these games.")
    ElseIf option == OID_helpBoredom_1
        Debug.MessageBox("Boredom is a hidden value that builds up as the follower grows tired of you.  If you don't have enough deals to amuse them, or you aren't suffering other humiliations, the follower grows increasingly bored.  Bored followers may increase their fees and these increases can be susbstantial.  Taking enough deals, or simply dismissing the follower, are some ways to avoid boredom.")
        
    ElseIf option == OID_helpFatigue_1
        Debug.MessageBox("Resistance fatigue builds up from constantly paying the follower.  It reduces your maximum resistance after you regain willpower from sleeping.  In some cases, this may mean you lose willpower from sleeping instead of gaining it. Making donations to the divines via priests or priestesses restores your self-worth and removes some resistance fatigue.  Resistance fatigue carries over between followers; you can't erase it simply by dismissing a follower and hiring a new one.")
    ElseIf option == OID_helpChaos_1
        Debug.MessageBox("Chaos mode is configured in the MCM, and allows you to set a range, or scaling range, for various configurable values that you would normally set to a static value in the MCM.  This can spice up your game my making costs or penalties less predictable.  Set the min and max values the same to lock a value rather than letting it change randomly.")
    ElseIf option == OID_helpPause_1
        Debug.MessageBox("Sometimes things will happen that aren't compatible with DF, such as SD+ enslavement, or a DCL quest that takes over your game. You can pause the mod when this happens.  Your follower will turn back into a normal follower and your deals and debts will be suspended.  Don't worry, they'll be there waiting for you when you unpause the mod.")
    ElseIf option == OID_helpDealConfiguration_1
        Debug.MessageBox("There are two kinds of deals: 'classic' deals and 'modular' deals.  Classic deals have three progressive stages that follow a theme.  You can configure the maximum stage for each classic deal.  Setting this to zero disables the deal completely. Modular deals are individual deals with no theme. They come in two kinds: mild deals that can go in stage 1 or 2, and harsh deals that can only go in stage 3.  The modular deals fill their stages by picking from the entire modular deal pool.")
        
    ElseIf option == OID_helpEnslavement_1
        Debug.MessageBox("If things go badly wrong, and you exceed your debt limit, the follower may force you into slavery.  If you disable slavery and use 'endless' mode, then the follower will put some heavy restraints on you instead.  If you do end up enslaved, your deals are suspended, but slavery can be hard, and required restraints are not optional; the follower will lock them on.  You might be able to earn back your freedom, or you might just be sold to another follower.")
    ElseIf option == OID_helpEnslavement_2
        Debug.MessageBox("To exit slavery you must pay your entire debt.  Normally, you will start enslavement in gold control.  You need enough credit to leave gold control before you can pay off your slave debt. While you're in gold control, if you earning more money than you lose, your debt will go down automatically.  There's no daily cost while enslaved, so paying debt is easier unless you keep getting punished.  Punishments are 'half price' while enslaved, but your payments may also be reduced too.")
    ElseIf option == OID_helpExclusion_1
        Debug.MessageBox("If you want to stop a follower from becoming devious, before recruiting them, you can target them and use an option in the 'General' MCM to toggle their exclusion from the mod. You can re-enable them the same way. It won't work on any of your current followers, or on NPCs who can't be followers. Disabled/excluded followers won't become devious and aren't charged for, even if they're in a group with a DF.")
    ElseIf option == OID_helpExclusion_2
        Debug.MessageBox("If you want all followers non-devious by default, then use the option in the 'Debug' MCM to find all followers and make them all non-devious. You can then use the enable/disable toggle to enable just the ones you want. The auto scan will not disable any followers you explicitly enabled, and it will not modify current followers or vanilla hirelings, so it's safe to re-run it if you add more followers to your game.")
    Endif

    If removeItemKeyword
        SetTextOptionWorking(option)
        LDC.RemoveDeviceByKeyword(removeItemKeyword, PlayerRef)
        Utility.WaitMenuMode(3.0)
        SetTextOptionValue(option, "$DF_DONE")
        removeItemKeyword = None
    EndIf
    
    If addItemKeyword
        SetTextOptionWorking(option)
        LDC.EquipDeviceByKeyword(addItemKeyword)
        Utility.WaitMenuMode(3.0)
        SetTextOptionValue(option, "$DF_DONE")
        addItemKeyword = None
    EndIf

    String rulePath = StorageUtil.GetStringValue(none, "DF_RULE_STATUS_" + option, "")
    if rulePath != ""
        Debug.Trace("DF - OnOptionSelect - Rule = " + rulePath)
        GlobalVariable status = DealManager.GetRuleGlobal(rulePath)
        int val = status.GetValue() as int

        if val == 0
            _DFRuleTemplate rule = DealManager.GetRuleScript(rulePath) as _DFRuleTemplate

            Debug.Trace("DF - Rendering rules - rule = " + rule)
            if DealManager.CanEnableRule(rulePath) && rule.InternalIsValid()
                val = 1
            endIf
        elseIf val == 1 || val == 2
            if DealManager.CanDisableRule(rulePath)
                val = 0
            endIf
        endIf

        status.SetValue(val)

        SetTextOptionValue(option, TranslateStatus(val))
    endIf
    
EndEvent


Event OnOptionSliderOpen(Int option)

    If option == OID_MinimumContractSlider
        SetSliderDialogStartValue(_DFMinimumContract.GetValue())
        SetSliderDialogDefaultValue(0.0)
        SetSliderDialogRange(0.0, 120.0)
        SetSliderDialogInterval(1.0)
        
    ElseIf option == OID_CustomCurve
        SetSliderDialogStartValue(CustomDifficultyCurve)
        SetSliderDialogDefaultValue(0.5)
        SetSliderDialogRange(0.1, 4.0)
        SetSliderDialogInterval(0.02)
    ElseIf option == OID_DebtPerDayLoLevel
        SetSliderDialogStartValue(DebtPerDayLoLevel)
        SetSliderDialogDefaultValue(250.0)
        SetSliderDialogRange(10.0, 2000.0)
        SetSliderDialogInterval(10.0)
    ElseIf option == OID_DebtPerDayHiLevel
        SetSliderDialogStartValue(DebtPerDayHiLevel)
        SetSliderDialogDefaultValue(12000.0)
        SetSliderDialogRange(1000.0, 100000.0)
        SetSliderDialogInterval(1000.0)
        
    ElseIf option == OID_IntrestSlider
        SetSliderDialogStartValue(Intrest.GetValue())
        SetSliderDialogDefaultValue(50.0)
        SetSliderDialogRange(0, 500.0)
        SetSliderDialogInterval(5.0)
        
    ElseIf option == OID_EnslavementSlider
        SetSliderDialogStartValue(EnslavementDebtScale)
        SetSliderDialogDefaultValue(5.0)
        SetSliderDialogRange(1.0, 20.0)
        SetSliderDialogInterval(0.25) 
    ElseIf option == OID_EnslavFailSlider
        SetSliderDialogStartValue(FailureScale)
        SetSliderDialogDefaultValue(10.0)
        SetSliderDialogRange(1.0, 20.0)
        SetSliderDialogInterval(0.25)    
    ElseIf option == OID_FreedomSlider
        SetSliderDialogStartValue(FreedomCostScale)
        SetSliderDialogDefaultValue(5.0)
        SetSliderDialogRange(1.0, 20.0)
        SetSliderDialogInterval(0.25)
    ElseIf option == OID_debtReduction
        SetSliderDialogStartValue(Q.PunishmentDebtReduction)
        SetSliderDialogDefaultValue(25.0)
        SetSliderDialogRange(0.0, 100.0)
        SetSliderDialogInterval(1.0)      
    ElseIf option == OID_dealReduction
        SetSliderDialogStartValue(Q.PunishmentDealReduction)
        SetSliderDialogDefaultValue(4.0)
        SetSliderDialogRange(0.0, 30.0)
        SetSliderDialogInterval(1.0)      
    
    ElseIf option == OID_dealReduction
    
    ElseIf option == OID_DailyDebtIncrement
        SetSliderDialogStartValue(_DFDailyDebtIncrement.GetValue())
        SetSliderDialogDefaultValue(5.0)
        SetSliderDialogRange(0.0, 100.0)
        SetSliderDialogInterval(1.0)      
    
    ElseIf option == OID_HoursTillBillSlider
        SetSliderDialogStartValue((DebtPollhrs.GetValue()*24.0))
        SetSliderDialogDefaultValue(8.0)
        SetSliderDialogRange(1.0, 24.0)
        SetSliderDialogInterval(1.0)   		
    ElseIf (option == OID_DFlowItemsPerRemovedSlider) ; % items taken
        SetSliderDialogStartValue(_DFlowItemsPerRemoved.GetValue())
        SetSliderDialogDefaultValue(50.0)
        SetSliderDialogRange(0.0, 100.0)
        SetSliderDialogInterval(5.0)
    ElseIf option == OID_FollowerEventCDSlider
        SetSliderDialogStartValue(ETimerp.GetValue())
        SetSliderDialogDefaultValue(2.0)
        SetSliderDialogRange(0.5, 7.0)
        SetSliderDialogInterval(0.5) 
    ElseIf option == OID_ResistanceFatigueLimit
        SetSliderDialogStartValue(Tool.MaxResistanceFatigue)
        SetSliderDialogDefaultValue(100.0)
        SetSliderDialogRange(0.0, 500.0)
        SetSliderDialogInterval(5.0) 
    ElseIf option == OID_MaxTatsSlider
        SetSliderDialogStartValue((tats.GetValue()))
        SetSliderDialogDefaultValue(1.0)
        SetSliderDialogRange(0.0, 10.0)
        SetSliderDialogInterval(1.0)
         
    ElseIf option == OID_ExpectedDealLimitSlider
        SetSliderDialogStartValue(_DFExpectedDealLimit.GetValue())
        SetSliderDialogDefaultValue(9.0)
        SetSliderDialogRange(0.0, 50.0)
        SetSliderDialogInterval(1.0)
         
    ElseIf option == OID_DflowGoldModeMinSlider
        SetSliderDialogStartValue(GoldCont.AgreedGoldMin)
        SetSliderDialogDefaultValue(100.0)
        SetSliderDialogRange(0.0, GoldCont.AgreedGoldMax)
        SetSliderDialogInterval(50.0)
         
    ElseIf option == OID_DflowGoldModeMaxSlider
        SetSliderDialogStartValue(GoldCont.AgreedGoldMax)
        SetSliderDialogDefaultValue(2000.0)
        SetSliderDialogRange(GoldCont.AgreedGoldMin, 10000.0)
        SetSliderDialogInterval(50.0)
        
    ElseIf option == OID_ResistanceWillSlider
        SetSliderDialogStartValue(_DFResistanceWillDelta)
        SetSliderDialogDefaultValue(0.0)
        SetSliderDialogRange(-10.0, 10.0)
        SetSliderDialogInterval(1.0)

        ElseIf option == OID_ResistanceDealSlider
        SetSliderDialogStartValue(_DFResistanceDealDelta)
        SetSliderDialogDefaultValue(0.0)
        SetSliderDialogRange(-2.0, 2.0)
        SetSliderDialogInterval(0.1)

    ElseIf option == OID_ResistanceLevelDelta
        SetSliderDialogStartValue(_DFResistanceLevelDelta)
        SetSliderDialogDefaultValue(0.0)
        SetSliderDialogRange(-1.0, 1.0)
        SetSliderDialogInterval(0.01)
        
    ElseIf option == OID_FatigueRateSlider
        SetSliderDialogStartValue(_DFFatigueRate.GetValue())
        SetSliderDialogDefaultValue(1.0)
        SetSliderDialogRange(0.0, 10.0)
        SetSliderDialogInterval(0.1)

    ElseIf option == OID_GoldPerFatigueSlider
        SetSliderDialogStartValue(_DFGoldPerFatigue.GetValue())
        SetSliderDialogDefaultValue(200.0)
        SetSliderDialogRange(50.0, 2000.0)
        SetSliderDialogInterval(50.0)
        
    ElseIf option == OID_BoredomIntervalSlider
        SetSliderDialogStartValue(_DFBoredomIntervalDays.GetValue())
        SetSliderDialogDefaultValue(3.0)
        SetSliderDialogRange(0.25, 28.0)
        SetSliderDialogInterval(0.25)
        
    ElseIf option == OID_EnSlavFailerPerLevelSlider
        SetSliderDialogStartValue(EnslavePerLevel.GetValue())
        SetSliderDialogDefaultValue(30.0)
        SetSliderDialogRange(0, 3000.0)
        SetSliderDialogInterval(10.0)
    ElseIf option == OID_DebtPerFollowerSlider
        SetSliderDialogStartValue(DebtPerFollower.GetValue())
        SetSliderDialogDefaultValue(20.0)
        SetSliderDialogRange(0.0, 1000.0)
        SetSliderDialogInterval(5.0)
    ElseIf option == OID_LivesSlider
        SetSliderDialogStartValue(FollowerLivesMax)
        SetSliderDialogDefaultValue(11.0)
        SetSliderDialogRange(1.0, 100.0)
        SetSliderDialogInterval(1.0)
        
    ElseIf option == OID_DfcSlaverySlider
        SetSliderDialogStartValue(DfcSlaveryChance.GetValue())
        SetSliderDialogDefaultValue(100.0)
        SetSliderDialogRange(0.0, 100.0)
        SetSliderDialogInterval(1.0)
    ElseIf option == OID_LolaSlider
        SetSliderDialogStartValue(LolaChance.GetValue())
        SetSliderDialogDefaultValue(0.0)
        SetSliderDialogRange(0.0, 100.0)
        SetSliderDialogInterval(1.0)
    ElseIf option == OID_SimplePerSlider
        SetSliderDialogStartValue(SSO.GetValue())
        SetSliderDialogDefaultValue(0.0)
        SetSliderDialogRange(0.0, 100.0)
        SetSliderDialogInterval(1.0)


    ElseIf option == OID_EndlessSoldWeight
        SetSliderDialogStartValue(Q.EndlessSoldWeight)
        SetSliderDialogDefaultValue(100.0)
        SetSliderDialogRange(0.0, 100.0)
        SetSliderDialogInterval(1.0)
    ElseIf option == OID_EndlessSlaveWeight
        SetSliderDialogStartValue(Q.EndlessSlaveWeight)
        SetSliderDialogDefaultValue(100.0)
        SetSliderDialogRange(0.0, 100.0)
        SetSliderDialogInterval(1.0)
    ElseIf option == OID_EndlessLolaWeight
        SetSliderDialogStartValue(Q.EndlessLolaWeight)
        SetSliderDialogDefaultValue(0.0)
        SetSliderDialogRange(0.0, 100.0)
        SetSliderDialogInterval(1.0)
    ElseIf option == OID_EndlessAuctionWeight
        SetSliderDialogStartValue(Q.EndlessAuctionWeight)
        SetSliderDialogDefaultValue(0.0)
        SetSliderDialogRange(0.0, 100.0)
        SetSliderDialogInterval(1.0)

        
    ElseIf option == OID_DflowDealBasePriceSlider ; buyout
        SetSliderDialogStartValue(BaseDebtBuyout)
        SetSliderDialogDefaultValue(100.0)
        SetSliderDialogRange(0.0, 1000.0)
        SetSliderDialogInterval(10.0)
    ElseIf option == OID_DflowDealBaseDebtSlider ; debt relief 
        SetSliderDialogStartValue(BaseDebtRelief)
        SetSliderDialogDefaultValue(200.0)
        SetSliderDialogRange(10.0, 1000.0)
        SetSliderDialogInterval(10.0)
    ElseIf option == OID_DflowDealMultiSlider ; Premature removal additional scale (percentage)
        SetSliderDialogStartValue(DealEarlyMulti)
        SetSliderDialogDefaultValue(500.0)
        SetSliderDialogRange(0.0, 2000.0)
        SetSliderDialogInterval(10.0)
    ElseIf option == OID_DflowDealBaseDaysSlider
        SetSliderDialogStartValue(DealDurationDays)
        SetSliderDialogDefaultValue(2.0)
        SetSliderDialogRange(0.0, 100.0)
        SetSliderDialogInterval(1.0)
    ElseIf option == OID_DflowRemovalBasePriceSlider ; Device removal base
        SetSliderDialogStartValue(DeviceRemovalFirst)
        SetSliderDialogDefaultValue(100.0)
        SetSliderDialogRange(0.0, 500.0)
        SetSliderDialogInterval(5.0)
    ElseIf option == OID_DFlowRemovalIncSlider ; Device removal increment
        SetSliderDialogStartValue(DeviceRemovalInc)
        SetSliderDialogDefaultValue(50.0)
        SetSliderDialogRange(0.0, 500.0)
        SetSliderDialogInterval(5.0)
    ElseIf option == OID_DFlowRemovalDebtTimesSlider ; Multiplier for debt vs cash
        SetSliderDialogStartValue(_DFlowRemovalDebtTimes.GetValue())
        SetSliderDialogDefaultValue(115.0)
        SetSliderDialogRange(100.0, 500.0)
        SetSliderDialogInterval(5.0)
    ElseIf option == OID_DiscountLimitSlider
        SetSliderDialogStartValue(_DFDiscountLimit.GetValue() * 100.0)
        SetSliderDialogDefaultValue(90)
        SetSliderDialogRange(0.0, 100.0)
        SetSliderDialogInterval(1.0)
    ElseIf option == OID_DeepDebtDifficulty
        SetSliderDialogStartValue(_DFDeepDebtDifficulty.GetValue())
        SetSliderDialogDefaultValue(1.0)
        SetSliderDialogRange(0.1, 10.0)
        SetSliderDialogInterval(0.1)
    ElseIf (option == OID_DFlowGambleJPotSlider)
        SetSliderDialogStartValue(_DFlowGambleJPot.GetValue())
        SetSliderDialogDefaultValue(1500.0)
        SetSliderDialogRange(500.0, 50000.0)
        SetSliderDialogInterval(100.0)
    ElseIf option == OID_DFPunDebtSlider 
        SetSliderDialogStartValue(PunishmentDebt) ; PunishmentDebt percentage of daily debt
        SetSliderDialogDefaultValue(100.0)
        SetSliderDialogRange(10.0, 500.0)
        SetSliderDialogInterval(5.0)
        
    ; Chaos Mode
    ElseIf option == OID_DFChaosPercentSlider
        SetSliderDialogStartValue(_DFChaosPercent)
        SetSliderDialogDefaultValue(20.0)
        SetSliderDialogRange(10.0, 100.0)
        SetSliderDialogInterval(5.0)
        
    ElseIf option == OID_DFChaosDaysSlider
        SetSliderDialogStartValue(_DFChaosDays)
        SetSliderDialogDefaultValue(1.0)
        SetSliderDialogRange(1.0, 14.0)
        SetSliderDialogInterval(1.0)
        
    ElseIf option == OID_DFDebtperdayMaxSlider
        SetSliderDialogStartValue(_DFDebtperdayMax)
        SetSliderDialogDefaultValue(10.0)
        SetSliderDialogRange(0.1, 10.0)
        SetSliderDialogInterval(0.1)
    ElseIf option == OID_DFDebtperdayMinSlider
        SetSliderDialogStartValue(_DFDebtperdayMin)
        SetSliderDialogDefaultValue(0.1)
        SetSliderDialogRange(0.1, 10.0)
        SetSliderDialogInterval(0.1)
        
    ElseIf option == OID_DFPunDebtMaxSlider
        SetSliderDialogStartValue(_DFPunDebtMax)
        SetSliderDialogDefaultValue(10.0)
        SetSliderDialogRange(0.1, 10.0)
        SetSliderDialogInterval(0.1)
    ElseIf option == OID_DFPunDebtMinSlider
        SetSliderDialogStartValue(_DFPunDebtMin)
        SetSliderDialogDefaultValue(0.1)
        SetSliderDialogRange(0.1, 10.0)
        SetSliderDialogInterval(0.1)

    ElseIf option == OID_DFRemovalMaxSlider
        SetSliderDialogStartValue(_DFRemovalMax)
        SetSliderDialogDefaultValue(10.0)
        SetSliderDialogRange(0.1, 10.0)
        SetSliderDialogInterval(0.1)
    ElseIf option == OID_DFRemovalMinSlider
        SetSliderDialogStartValue(_DFRemovalMin)
        SetSliderDialogDefaultValue(0.1)
        SetSliderDialogRange(0.1, 10.0)
        SetSliderDialogInterval(0.1)

    ElseIf option == OID_DFRemovalIncMaxSlider
        SetSliderDialogStartValue(_DFRemovalIncMax)
        SetSliderDialogDefaultValue(10.0)
        SetSliderDialogRange(0.1, 10.0)
        SetSliderDialogInterval(0.1)
    ElseIf option == OID_DFRemovalIncMinSlider
        SetSliderDialogStartValue(_DFRemovalIncMin)
        SetSliderDialogDefaultValue(0.1)
        SetSliderDialogRange(0.1, 10.0)
        SetSliderDialogInterval(0.1)

    ElseIf option == OID_DFDealsMaxDebtSlider
        SetSliderDialogStartValue(_DFDealsMaxDebt)
        SetSliderDialogDefaultValue(10.0)
        SetSliderDialogRange(0.1, 10.0)
        SetSliderDialogInterval(0.1)
    ElseIf option == OID_DFDealsMinDebtSlider
        SetSliderDialogStartValue(_DFDealsMinDebt)
        SetSliderDialogDefaultValue(0.1)
        SetSliderDialogRange(0.1, 10.0)
        SetSliderDialogInterval(0.1)

    ElseIf option == OID_DFDealsMaxPriceSlider
        SetSliderDialogStartValue(_DFDealsMaxPrice)
        SetSliderDialogDefaultValue(10.0)
        SetSliderDialogRange(0.1, 10.0)
        SetSliderDialogInterval(0.1)
    ElseIf option == OID_DFDealsMinPriceSlider
        SetSliderDialogStartValue(_DFDealsMinPrice)
        SetSliderDialogDefaultValue(0.1)
        SetSliderDialogRange(0.1, 10.0)
        SetSliderDialogInterval(0.1)

    ElseIf option == OID_DFDealsMaxPTimeSlider
        SetSliderDialogStartValue(_DFDealsMaxPTime)
        SetSliderDialogDefaultValue(7.0)
        SetSliderDialogRange(0.0, 100.0)
        SetSliderDialogInterval(1.0)
    ElseIf option == OID_DFDealsMinPTimeSlider
        SetSliderDialogStartValue(_DFDealsMinPTime)
        SetSliderDialogDefaultValue(1.0)
        SetSliderDialogRange(0.0, 100.0)
        SetSliderDialogInterval(1.0)
        
    ElseIf option == OID_DFDealsMaxMultiSlider
        SetSliderDialogStartValue(_DFDealsMaxMulti)
        SetSliderDialogDefaultValue(10.0)
        SetSliderDialogRange(0.0, 20.0)
        SetSliderDialogInterval(1.0)
    ElseIf option == OID_DFDealsMinMultiSlider
        SetSliderDialogStartValue(_DFDealsMinMulti)
        SetSliderDialogDefaultValue(1.0)
        SetSliderDialogRange(0.0, 20.0)
        SetSliderDialogInterval(1.0)

    ElseIf option == OID_DFLivesChaoMaxSlider
        SetSliderDialogStartValue(_DFLivesChaoMax)
        SetSliderDialogDefaultValue(21.0)
        SetSliderDialogRange(1.0, 100.0)
        SetSliderDialogInterval(1)
    ElseIf option == OID_DFLivesChaoMinSlider
        SetSliderDialogStartValue(_DFLivesChaoMin)
        SetSliderDialogDefaultValue(6.0)
        SetSliderDialogRange(1.0, 100.0)
        SetSliderDialogInterval(1.0)
    ; End Chaos Mode
        
    ElseIf option == OID_DFMaxStolenPerSlider 
        SetSliderDialogStartValue(_DFMaxStolenPer )
        SetSliderDialogDefaultValue(30.0)
        SetSliderDialogRange(_DFMinStolenPer, 100.0)
        SetSliderDialogInterval(1.0)
    ElseIf option == OID_DFMinStolenPerSlider 
        SetSliderDialogStartValue(_DFMinStolenPer )
        SetSliderDialogDefaultValue(5.0)
        SetSliderDialogRange(0.0, _DFMaxStolenPer)
        SetSliderDialogInterval(1.0)
        
    ElseIf option == OID_DFSWeightDSlider
        SetSliderDialogStartValue(_DFSWeightD )
        SetSliderDialogDefaultValue(50.0)
        SetSliderDialogRange(0, 100.0)
        SetSliderDialogInterval(5.0)
    ElseIf option == OID_DFSWeightESlider
        SetSliderDialogStartValue(_DFSWeightE )
        SetSliderDialogDefaultValue(50.0)
        SetSliderDialogRange(0, 100.0)
        SetSliderDialogInterval(5.0)
    ElseIf option == OID_DFSWeightEDSlider
        SetSliderDialogStartValue(_DFSWeightED )
        SetSliderDialogDefaultValue(50.0)
        SetSliderDialogRange(0.0, 100.0)
        SetSliderDialogInterval(5.0)
        
    ElseIf option == OID_DFKConcealSlider
        SetSliderDialogStartValue(_DFKConceal )
        SetSliderDialogDefaultValue(30.0)
        SetSliderDialogRange(5.0, 100.0)
        SetSliderDialogInterval(5.0)
        
    ElseIf option == OID_DFGDecaySlider
        SetSliderDialogStartValue(GoldCont.Decay*100.0)
        SetSliderDialogDefaultValue(1.0) 
        SetSliderDialogRange(0.0, 10.0)
        SetSliderDialogInterval(0.5)
    ElseIf option == OID_DFGRedGoldModSlider
        SetSliderDialogStartValue(GoldCont.RedGoldMod*100.0)
        SetSliderDialogDefaultValue(1.0) 
        SetSliderDialogRange(0.0, 100.0)
        SetSliderDialogInterval(1.0)
    ElseIf option == OID_DFGCredToLeaveSlider
        SetSliderDialogStartValue(GoldCont.CredToLeave)
        SetSliderDialogDefaultValue(1000.0) 
        SetSliderDialogRange(0.0, 10000.0)
        SetSliderDialogInterval(100.0)
    ElseIf option == OID_SpankingCooldown
        SetSliderDialogStartValue(SpankingCooldownHours)
        SetSliderDialogDefaultValue(3.5) 
        SetSliderDialogRange(0.0, 48.0)
        SetSliderDialogInterval(0.25)
        
    ElseIf option == OID_DealBias
        SetSliderDialogStartValue(DC.DealBias)
        SetSliderDialogDefaultValue(50.0) 
        SetSliderDialogRange(0.0, 100.0)
        SetSliderDialogInterval(1.0)

    ElseIf option == OID_DFSoldTimerMax
        SetSliderDialogStartValue(DSold.TimerMax)
        SetSliderDialogDefaultValue(14.0) 
        SetSliderDialogRange(DSold.TimerMin, 60.0)
        SetSliderDialogInterval(0.5)

    ElseIf option == OID_DFSoldTimerMin
        SetSliderDialogStartValue(DSold.TimerMin)
        SetSliderDialogDefaultValue(7.0) 
        SetSliderDialogRange(0.5, DSold.TimerMax)
        SetSliderDialogInterval(0.5)
    ElseIf option == OID_DFSoldDeals
        SetSliderDialogStartValue(_DFSoldDeals.GetValue())
        SetSliderDialogDefaultValue(12.0) 
        SetSliderDialogRange(1.0, 30.0)
        SetSliderDialogInterval(1.0)	

    ElseIf option == OID_DFPotionQSlider 
        SetSliderDialogStartValue(DFPotQ._DFlowPotionDeal.GetValue())
        SetSliderDialogDefaultValue(9) 
        SetSliderDialogRange(1.0, 12.0)
        SetSliderDialogInterval(1.0)
    ElseIf option == OID_DFPotionQESlider
        SetSliderDialogStartValue(DFPotQ._DFlowPotionDealEvil.GetValue())
        SetSliderDialogDefaultValue(12.0)
        SetSliderDialogRange(1.0, 12.0)
        SetSliderDialogInterval(1.0)
        
    ElseIf option == OID_DFPotionQDelayMin
        SetSliderDialogStartValue(DFPotQ.DelayMin)
        SetSliderDialogDefaultValue(3.0)
        SetSliderDialogRange(0.25 , DFPotQ.DelayMax)
        SetSliderDialogInterval(0.25)
        
    ElseIf option == OID_DFPotionQDelayMax
        SetSliderDialogStartValue(DFPotQ.DelayMax)
        SetSliderDialogDefaultValue(11.0) 
        SetSliderDialogRange(DFPotQ.DelayMin, 33.0)
        SetSliderDialogInterval(0.25)
        
    ElseIf option == OID_MinWillRegain
        SetSliderDialogStartValue(MinWillRegain)
        SetSliderDialogDefaultValue(2.0) 
        SetSliderDialogRange(0.0 , 10.0)
        SetSliderDialogInterval(1.0)
    ElseIf option == OID_MaxWillRegain
        SetSliderDialogStartValue(MaxWillRegain)
        SetSliderDialogDefaultValue(7.0) 
        SetSliderDialogRange(1.0 , 10.0)
        SetSliderDialogInterval(1.0)
    ElseIf option == OID_DFMaxResistMCMSlider
        SetSliderDialogStartValue(_DFMaxResistMCM)
        SetSliderDialogDefaultValue(26.0) 
        SetSliderDialogRange(5.0 , 60.0)
        SetSliderDialogInterval(1.0)
    ElseIf option == OID_DFMaxResistMinSlider	
        SetSliderDialogStartValue(_DFMaxResistMin)
        SetSliderDialogDefaultValue(5.0) 
        SetSliderDialogRange(1.0, _DFMaxResistMCM)
        SetSliderDialogInterval(1.0)
    ElseIf option == OID_ModDealNumOfDeals
        SetSliderDialogStartValue(MDC.MaxModDealsSetting)
        SetSliderDialogDefaultValue(3.0) 
        SetSliderDialogRange(0.0, 5.0)
        SetSliderDialogInterval(1.0)
    ElseIf option == OID_DFMDTimerSlider
        SetSliderDialogStartValue(MDC.TimerSetting)
        SetSliderDialogDefaultValue(1.0) 
        SetSliderDialogRange(0.25, 7.0)
        SetSliderDialogInterval(0.25)
        
    ElseIf option == OID_LicenseBasePrice
        SetSliderDialogStartValue(_DFLicenses.BasePrice)
        SetSliderDialogDefaultValue(150.0) 
        SetSliderDialogRange(25.0, 5000.0)
        SetSliderDialogInterval(25.0)
    ElseIf option == OID_LicenseMarkup
        SetSliderDialogStartValue(_DFLicenses.Markup)
        SetSliderDialogDefaultValue(10.0) 
        SetSliderDialogRange(0.0, 200.0)
        SetSliderDialogInterval(1.0)

    ElseIf option == OID_ExploreExponent
        SetSliderDialogStartValue(exploreExponent)
        SetSliderDialogDefaultValue(0.5)
        SetSliderDialogRange(0.1, 4.0)
        SetSliderDialogInterval(0.02)
        
    ElseIf option == OID_ExploreLoPrice
        SetSliderDialogStartValue(exploreLoPrice)
        SetSliderDialogDefaultValue(250.0)
        SetSliderDialogRange(10.0, 2000.0)
        SetSliderDialogInterval(10.0)

    ElseIf option == OID_ExploreHiPrice
        SetSliderDialogStartValue(exploreHiPrice)
        SetSliderDialogDefaultValue(12000.0)
        SetSliderDialogRange(1000.0, 100000.0)
        SetSliderDialogInterval(1000.0)
    EndIf
EndEvent


Event OnOptionSliderAccept(Int option, Float value)

    If option == OID_MinimumContractSlider
        _DFMinimumContract.SetValue(value)
        SetSliderOptionValue(option, value, "$DF_0")
    ElseIf option == OID_CustomCurve
        CustomDifficultyCurve = value
        SetSliderOptionValue(option, value, "$DF_2")
        debtExponents[7] = CustomDifficultyCurve
        CalculateScaledDebts()
    ElseIf option == OID_DebtPerDayLoLevel
        DebtPerDayLoLevel = value
        SetSliderOptionValue(option, value, "$DF_0")
        CalculateScaledDebts()
    ElseIf option == OID_DebtPerDayHiLevel
        DebtPerDayHiLevel = value
        SetSliderOptionValue(option, value, "$DF_0")
        CalculateScaledDebts()
    ElseIf option == OID_IntrestSlider
        Intrest.SetValue(value)
        SetSliderOptionValue(option, value, "$DF_0%")
    ElseIf option == OID_DailyDebtIncrement
        _DFDailyDebtIncrement.SetValue(value)
        SetSliderOptionValue(option, value, "$DF_1%")
    ElseIf option == OID_DebtPerFollowerSlider
        DebtPerFollower.SetValue(value)
        SetSliderOptionValue(option, value, "$DF_0%")
        
    ElseIf option == OID_EnslavementSlider
        EnslavementDebtScale = value
        SetSliderOptionValue(option, value, "$DF_2")
        CalculateScaledDebts()
    ElseIf option == OID_EnslavFailSlider
        FailureScale = value
        SetSliderOptionValue(option, value, "$DF_2")
        CalculateScaledDebts()
    ElseIf option == OID_FreedomSlider
        FreedomCostScale = value
        SetSliderOptionValue(option, value, "$DF_2")
        CalculateScaledDebts()
    ElseIf option == OID_debtReduction
        Q.PunishmentDebtReduction = value
        SetSliderOptionValue(option, value, "$DF_0%")
    ElseIf option == OID_dealReduction
        Q.PunishmentDealReduction = value
        SetSliderOptionValue(option, value, "$DF_0")
        
    ElseIf option == OID_HoursTillBillSlider
        SetSliderOptionValue(option, value, "$DF_0HOURS")	
        DebtPollhrs.SetValue(value/24.0)
        Q.DTimerReset()
        CalculateScaledDebts()
    ElseIf (option == OID_DFlowItemsPerRemovedSlider)
        _DFlowItemsPerRemoved.SetValue(value)
        SetSliderOptionValue(option, value, "$DF_0%")
    ElseIf option == OID_FollowerEventCDSlider
        ETimerp.SetValue(value)
        SetSliderOptionValue(option, value, "$DF_1DAYS")
    ElseIf option == OID_ResistanceFatigueLimit
        Tool.MaxResistanceFatigue = value
        SetSliderOptionValue(option, value, "$DF_0")
    ElseIf option == OID_MaxTatsSlider
        tats.SetValue((value))
        SetSliderOptionValue(option, value, "$DF_0TATS")	
    ElseIf option == OID_ExpectedDealLimitSlider
        _DFExpectedDealLimit.SetValue(value)
        SetSliderOptionValue(option, value, "$DF_0")
    ElseIf option == OID_DflowGoldModeMaxSlider
        GoldCont.AgreedGoldMax = value As Int
        SetSliderOptionValue(option, value, "$DF_0GOLD")	
    ElseIf option == OID_DflowGoldModeMinSlider
        GoldCont.AgreedGoldMin = value As Int
        SetSliderOptionValue(option, value, "$DF_0GOLD")
        
    ElseIf option == OID_ResistanceWillSlider
        _DFResistanceWillDelta = value
        SetSliderOptionValue(option, value, "$DF_0")
    ElseIf option == OID_ResistanceDealSlider
        _DFResistanceDealDelta = value
        SetSliderOptionValue(option, value, "$DF_1")
    ElseIf option == OID_ResistanceLevelDelta
        _DFResistanceLevelDelta = value
        SetSliderOptionValue(option, value, "$DF_2")
        
    ElseIf option == OID_FatigueRateSlider
        _DFFatigueRate.SetValue(value)
        SetSliderOptionValue(option, value, "$DF_1")
    ElseIf option == OID_GoldPerFatigueSlider
        _DFGoldPerFatigue.SetValue(value)
        SetSliderOptionValue(option, value, "$DF_0")
    ElseIf option == OID_BoredomIntervalSlider
        If value < _DFBoredomIntervalDays.GetValue()
            ; Possibly update the timer so that event will occur sooner
            Float gameDays = GameDaysPassed.GetValue()
            Float boredomTimer = _DFBoredomTimer.GetValue()
            If gameDays + value < boredomTimer
                _DFBoredomTimer.SetValue(gameDays + value)
            EndIf
        EndIf
        _DFBoredomIntervalDays.SetValue(value)
        SetSliderOptionValue(option, value, "$DF_2")
    ElseIf option == OID_DiscountLimitSlider
        _DFDiscountLimit.SetValue(value/100.0)
        SetSliderOptionValue(option, value, "$DF_0%")
    ElseIf option == OID_DeepDebtDifficulty
        _DFDeepDebtDifficulty.SetValue(value)
        SetSliderOptionValue(option, value, "$DF_1")
    ElseIf option == OID_EnSlavFailerPerLevelSlider
        EnslavePerLevel.SetValue(value)
        SetSliderOptionValue(option, value, "$DF_0")
    ElseIf option == OID_LivesSlider
        FollowerLivesMax = value
        SetSliderOptionValue(option, value, "$DF_0LIFES")
        CalculateScaledDebts() ; This also handles the Chaos lives, lazy, I know...
        
    ElseIf option == OID_DfcSlaverySlider
        DfcSlaveryChance.SetValue(value)
        SetSliderOptionValue(option, value, "$DF_0")
        Tool.PickSlaveryDestination()
    ElseIf option == OID_LolaSlider
        LolaChance.SetValue(value)
        SetSliderOptionValue(option, value, "$DF_0")
        Tool.PickSlaveryDestination()
    ElseIf option == OID_SimplePerSlider
        SSO.SetValue(value)
        SetSliderOptionValue(option, value, "$DF_0")
        Tool.PickSlaveryDestination()

    ElseIf option == OID_EndlessSoldWeight
        Q.EndlessSoldWeight = value
        SetSliderOptionValue(option, value, "$DF_0")
        Q.PickEndlessSlaveryDestination()
    ElseIf option == OID_EndlessSlaveWeight
        Q.EndlessSlaveWeight = value
        SetSliderOptionValue(option, value, "$DF_0")
        Q.PickEndlessSlaveryDestination()
    ElseIf option == OID_EndlessLolaWeight
        Q.EndlessLolaWeight = value
        SetSliderOptionValue(option, value, "$DF_0")
        Q.PickEndlessSlaveryDestination()
    ElseIf option == OID_EndlessAuctionWeight
        Q.EndlessAuctionWeight = value
        SetSliderOptionValue(option, value, "$DF_0")
        Q.PickEndlessSlaveryDestination()
        
    ElseIf option == OID_DflowDealBasePriceSlider
        BaseDebtBuyout = value
        SetSliderOptionValue(option, value, "$DF_0%")
        CalculateScaledDebts()
    ElseIf option == OID_DflowDealBaseDebtSlider
        BaseDebtRelief = value
        SetSliderOptionValue(option, value, "$DF_0%")
        CalculateScaledDebts()
    ElseIf option == OID_DflowDealMultiSlider
        DealEarlyMulti = value
        SetSliderOptionValue(option, value, "$DF_0%")
        CalculateScaledDebts()
    ElseIf option == OID_DflowDealBaseDaysSlider
        DealDurationDays = value
        SetSliderOptionValue(option, value, "$DF_1")
        CalculateScaledDebts() ; DealDurationDays barely related to debts, but calling Chaos() is more bothersome.
    ElseIf option == OID_DFlowRemovalDebtTimesSlider
        _DFlowRemovalDebtTimes.SetValue(value)
        SetSliderOptionValue(option, value, "$DF_0%")
        CalculateScaledDebts()
    ElseIf option == OID_DflowRemovalBasePriceSlider
        DeviceRemovalFirst = value
        SetSliderOptionValue(option, value, "$DF_0%")
        CalculateScaledDebts()
    ElseIf option == OID_DFlowRemovalIncSlider
        DeviceRemovalInc = value
        SetSliderOptionValue(option, value, "$DF_0%")
        CalculateScaledDebts()
    ElseIf (option == OID_DFlowGambleJPotSlider)
        _DFlowGambleJPot.SetValue(value)
        SetSliderOptionValue(option, value, "$DF_0")
    ElseIf option == OID_DFPunDebtSlider 
        PunishmentDebt = value
        SetSliderOptionValue(option, value, "$DF_0%")
        CalculateScaledDebts()
        
    ; Chaos Mode    
    ElseIf option == OID_DFChaosPercentSlider
        _DFChaosPercent = value
        SetSliderOptionValue(option, value, "$DF_0%")
        chaosModified = True
        
    ElseIf option == OID_DFChaosDaysSlider
        _DFChaosDays = value
        SetSliderOptionValue(option, value, "$DF_1DAYS")
        chaosModified = True

    ElseIf option == OID_DFDebtperdayMaxSlider
        _DFDebtperdayMax = value
        SetSliderOptionValue(option, value, "$DF_1")
        _DFDebtperdayMin = Min(_DFDebtperdayMin, value)
        SetSliderOptionValue(OID_DFDebtperdayMinSlider, _DFDebtperdayMin, "$DF_1")
        chaosModified = True
    ElseIf option == OID_DFDebtperdayMinSlider
        _DFDebtperdayMin = value
        _DFDebtperdayMax = Max(_DFDebtperdayMax, value)
        SetSliderOptionValue(option, value, "$DF_1")
        SetSliderOptionValue(OID_DFDebtperdayMaxSlider, _DFDebtperdayMax, "$DF_1")
        chaosModified = True
        
    ElseIf option == OID_DFPunDebtMaxSlider
        _DFPunDebtMax = value
        _DFPunDebtMin = Min(_DFPunDebtMin, value)
        SetSliderOptionValue(option, value, "$DF_1")
        SetSliderOptionValue(OID_DFPunDebtMinSlider, _DFPunDebtMin, "$DF_1")
        chaosModified = True
    ElseIf option == OID_DFPunDebtMinSlider
        _DFPunDebtMin = value
        _DFPunDebtMax = Max(_DFPunDebtMax, value)
        SetSliderOptionValue(option, value, "$DF_1")
        SetSliderOptionValue(OID_DFPunDebtMaxSlider, _DFPunDebtMax, "$DF_1")
        chaosModified = True

    ElseIf option == OID_DFRemovalMaxSlider
        _DFRemovalMax = value
        _DFRemovalMin = Min(_DFRemovalMin, value)
        SetSliderOptionValue(option, value, "$DF_1")
        SetSliderOptionValue(OID_DFRemovalMinSlider, _DFRemovalMin, "$DF_1")
        chaosModified = True
    ElseIf option == OID_DFRemovalMinSlider
        _DFRemovalMin = value
        _DFRemovalMax = Max(_DFRemovalMax, value)
        SetSliderOptionValue(option, value, "$DF_1")
        SetSliderOptionValue(OID_DFRemovalMaxSlider, _DFRemovalMax, "$DF_1")
        chaosModified = True

    ElseIf option == OID_DFRemovalIncMaxSlider
        _DFRemovalIncMax = value
        _DFRemovalIncMin = Min(_DFRemovalIncMin, value)
        SetSliderOptionValue(option, value, "$DF_1")
        SetSliderOptionValue(OID_DFRemovalIncMinSlider, _DFRemovalIncMin, "$DF_1")
        chaosModified = True
    ElseIf option == OID_DFRemovalIncMinSlider
        _DFRemovalIncMin = value
        _DFRemovalIncMax =  Max(_DFRemovalIncMax, value)
        SetSliderOptionValue(option, value, "$DF_1")
        SetSliderOptionValue(OID_DFRemovalIncMaxSlider, _DFRemovalIncMax, "$DF_1")
        chaosModified = True

    ElseIf option == OID_DFDealsMaxDebtSlider
        _DFDealsMaxDebt = value
        _DFDealsMinDebt = Min(_DFDealsMinDebt, value)
        SetSliderOptionValue(option, value, "$DF_1")
        SetSliderOptionValue(OID_DFDealsMinDebtSlider, _DFDealsMinDebt, "$DF_1")
        chaosModified = True
    ElseIf option == OID_DFDealsMinDebtSlider
        _DFDealsMinDebt = value
        _DFDealsMaxDebt = Max(_DFDealsMaxDebt, value)
        SetSliderOptionValue(option, value, "$DF_1")
        SetSliderOptionValue(OID_DFDealsMaxDebtSlider, _DFDealsMaxDebt, "$DF_1")
        chaosModified = True

    ElseIf option == OID_DFDealsMaxPriceSlider
        _DFDealsMaxPrice = value
        _DFDealsMinPrice = Min(_DFDealsMinPrice, value)
        SetSliderOptionValue(option, value, "$DF_1")
        SetSliderOptionValue(OID_DFDealsMinPriceSlider, _DFDealsMinPrice, "$DF_1")
        chaosModified = True
    ElseIf option == OID_DFDealsMinPriceSlider
        _DFDealsMinPrice = value
        _DFDealsMaxPrice = Max(_DFDealsMaxPrice, value)
        SetSliderOptionValue(option, value, "$DF_1")
        SetSliderOptionValue(OID_DFDealsMaxPriceSlider, _DFDealsMaxPrice, "$DF_1")
        chaosModified = True

    ElseIf option == OID_DFDealsMaxPTimeSlider
        _DFDealsMaxPTime = value
        _DFDealsMinPTime = Min(_DFDealsMinPTime, value)
        SetSliderOptionValue(option, value, "$DF_0DAYS")
        SetSliderOptionValue(OID_DFDealsMinPTimeSlider, _DFDealsMinPTime, "$DF_0DAYS")
        chaosModified = True
    ElseIf option == OID_DFDealsMinPTimeSlider
        _DFDealsMinPTime = value
        _DFDealsMaxPTime = Max(_DFDealsMaxPTime, value)
        SetSliderOptionValue(option, value, "$DF_0DAYS")
        SetSliderOptionValue(OID_DFDealsMaxPTimeSlider, _DFDealsMaxPTime, "$DF_0DAYS")
        chaosModified = True

    ElseIf option == OID_DFDealsMaxMultiSlider
        _DFDealsMaxMulti = value
        _DFDealsMinMulti = Min(_DFDealsMinMulti, value)
        SetSliderOptionValue(option, value, "$DF_1")
        SetSliderOptionValue(OID_DFDealsMinMultiSlider, _DFDealsMinMulti, "$DF_1")
        chaosModified = True
    ElseIf option == OID_DFDealsMinMultiSlider
        _DFDealsMinMulti = value
        _DFDealsMaxMulti = Max(_DFDealsMaxMulti, value)
        SetSliderOptionValue(option, value, "$DF_1")
        SetSliderOptionValue(OID_DFDealsMaxMultiSlider, _DFDealsMaxMulti, "$DF_1")
        chaosModified = True
        
    ElseIf option == OID_DFLivesChaoMaxSlider
        _DFLivesChaoMax = value
        _DFLivesChaoMin = Min(_DFLivesChaoMin, value)
        SetSliderOptionValue(option, value, "$DF_0")
        SetSliderOptionValue(OID_DFLivesChaoMinSlider, _DFLivesChaoMin, "$DF_0")
        chaosModified = True
    ElseIf option == OID_DFLivesChaoMinSlider
        _DFLivesChaoMin = value
        _DFLivesChaoMax = Max(_DFLivesChaoMax, value)
        SetSliderOptionValue(option, value, "$DF_0")
        SetSliderOptionValue(OID_DFLivesChaoMaxSlider, _DFLivesChaoMax, "$DF_0")
        chaosModified = True
    ; End Chaos Mode    

    
    ElseIf option == OID_DFMaxStolenPerSlider 
        _DFMaxStolenPer = value As Int
        SetSliderOptionValue(option, value, "$DF_0%")
    ElseIf option == OID_DFMinStolenPerSlider 
        _DFMinStolenPer = value As Int
        SetSliderOptionValue(option, value, "$DF_0%")
    ElseIf option == OID_DFSWeightDSlider
        _DFSWeightD = value
        SetSliderOptionValue(option, value, "$DF_0")
    ElseIf option == OID_DFSWeightESlider
        _DFSWeightE = value
        SetSliderOptionValue(option, value, "$DF_0")
    ElseIf option == OID_DFSWeightEDSlider
        _DFSWeightED = value
        SetSliderOptionValue(option, value, "$DF_0")
    ElseIf option == OID_DFKConcealSlider	    	
        _DFKConceal = value
        SetSliderOptionValue(option, value, "$DF_0%")
    ElseIf option == OID_DFGDecaySlider
        GoldCont.Decay = value/100
        SetSliderOptionValue(option, value, "$DF_1%")
    ElseIf option == OID_DFGRedGoldModSlider
        GoldCont.RedGoldMod = value/100
        SetSliderOptionValue(option, value, "$DF_1%")
    ElseIf option == OID_DFGCredToLeaveSlider 
        GoldCont.CredToLeave = value As Int
        SetSliderOptionValue(option, value, "$DF_0GOLD")
    ElseIf option == OID_SpankingCooldown
        SpankingCooldownHours = value
        SetSliderOptionValue(option, value, "$DF_2HOURS")
        Tool.AllowSpanking()
        
    ElseIf option == OID_DealBias
        DC.DealBias = value
        SetSliderOptionValue(option, value, "$DF_0%")
    ElseIf option == OID_DFSoldTimerMax
        DSold.TimerMax = value
        SetSliderOptionValue(option, value, "$DF_1Days")

    ElseIf option == OID_DFSoldTimerMin
        DSold.TimerMin = value
        SetSliderOptionValue(option, value, "$DF_1Days")
    ElseIf option == OID_DFSoldDeals
        _DFSoldDeals.SetValue(value)
        SetSliderOptionValue(option, value)
        
    ElseIf option == OID_DFPotionQSlider 
        DFPotQ._DFlowPotionDeal.SetValue(value)
        SetSliderOptionValue(option, value)
    ElseIf option == OID_DFPotionQESlider
        DFPotQ._DFlowPotionDealEvil.SetValue(value)
        SetSliderOptionValue(option, value)
        
    ElseIf option == OID_DFPotionQDelayMin 
        DFPotQ.DelayMin = value
        SetSliderOptionValue(option, value, "$DF_2DAYS")
    ElseIf option == OID_DFPotionQDelayMax
        DFPotQ.DelayMax = value
        SetSliderOptionValue(option, value, "$DF_2DAYS")
    
    ElseIf option == OID_MinWillRegain
        MinWillRegain = value
        SetSliderOptionValue(option, value, "$DF_0")
        If MinWillRegain > MaxWillRegain
            MaxWillRegain = MinWillRegain
            SetSliderOptionValue(OID_MaxWillRegain, MaxWillRegain, "$DF_0")
        EndIf
    ElseIf option == OID_MaxWillRegain
        MaxWillRegain = value
        SetSliderOptionValue(option, value, "$DF_0")
        If MaxWillRegain < MinWillRegain
            MinWillRegain = MaxWillRegain
            SetSliderOptionValue(OID_MinWillRegain, MinWillRegain, "$DF_0")
        EndIf
           
    ElseIf option == OID_DFMaxResistMCMSlider
            _DFMaxResistMCM = value As Int
            SetSliderOptionValue(option, value, "$DF_0")
    ElseIf option == OID_DFMaxResistMinSlider
            _DFMaxResistMin = value As Int
            SetSliderOptionValue(option, value, "$DF_0")
            
    ElseIf option == OID_ModDealNumOfDeals
        MDC.TryChangeModularDealEnables(value As Int)
        SetSliderOptionValue(option, MDC.MaxModDealsSetting, "$DF_0") ; Whether it changed or not, this is now the value.
        Debug.Trace("DFF: Changing max modular deals")
    ElseIf option == OID_DFMDTimerSlider
        MDC.TimerSetting = value
        SetSliderOptionValue(option, value, "$DF_1Days")
        
        
    ElseIf option == OID_LicenseBasePrice
        _DFLicenses.BasePrice = value
        SetSliderOptionValue(option, value, "$DF_0")
    ElseIf option == OID_LicenseMarkup
        _DFLicenses.Markup = value
        SetSliderOptionValue(option, value, "$DF_0%")


    ElseIf option == OID_ExploreExponent
        ; This can't just stomp into debtExponents[] as that's for REAL settings.
        exploreExponent = value
        SetSliderOptionValue(option, exploreExponent)
        ForcePageReset()
        
    ElseIf option == OID_ExploreLoPrice
        exploreLoPrice = value
        SetSliderOptionValue(option, exploreLoPrice)
        ForcePageReset()

    ElseIf option == OID_ExploreHiPrice
        exploreHiPrice = value
        SetSliderOptionValue(option, exploreHiPrice)
        ForcePageReset()
    EndIf
EndEvent


Function ExportSettings()

    File = "../DeviousFollowers/Dflow.json"
    
    ExportFloat("_DFSettingsVersion", Version)
    ExportFloat("_DFMinimumContract", _DFMinimumContract.GetValue())
    ExportFloat("CustomDifficultyCurve", CustomDifficultyCurve)
    ExportFloat("DealDurationDays", DealDurationDays)
    ExportFloat("DealEarlyMulti", DealEarlyMulti)
    ExportFloat("DeviceRemovalFirst", DeviceRemovalFirst)
    ExportFloat("DeviceRemovalInc", DeviceRemovalInc)
    ExportFloat("_DFlowRemovalDebtTimes", _DFlowRemovalDebtTimes.GetValue())
    ExportFloat("_DFlowItemsPerRemoved", _DFlowItemsPerRemoved.GetValue())
    ExportFloat("_DFBoredomIntervalDays", _DFBoredomIntervalDays.GetValue())
    ExportFloat("_DFlowGambleJPot", _DFlowGambleJPot.GetValue())
    ExportFloat("_DflowEndlessMode", _DflowEndlessMode.GetValue())
    ExportFloat("_DflowGoldMode", GoldCont.Active As Float)
    ExportFloat("_DflowGoldModeMax",GoldCont.AgreedGoldMax As Float)
    ExportFloat("_DflowGoldModeMin",GoldCont.AgreedGoldMin As Float)
    ExportFloat("_DFlowWarmComp", _DFlowWarmComp.GetValue())
    ExportFloat("_DFDailyDebtIncrement", _DFDailyDebtIncrement.GetValue())
    ExportFloat("Intrest", Intrest.GetValue())
    ExportFloat("DebtDifficulty", DebtDifficulty As Float)
    ExportFloat("DebtPerDayLoLevel", DebtPerDayLoLevel)
    ExportFloat("DebtPerDayHiLevel", DebtPerDayHiLevel)
    ExportFloat("EnslavementDebtScale", EnslavementDebtScale)
    ExportFloat("FreedomCostScale", FreedomCostScale)
    ExportFloat("FailureScale", FailureScale)
    ExportFloat("BaseDebtRelief", BaseDebtRelief)
    ExportFloat("BaseDebtBuyout", BaseDebtBuyout)
    ExportFloat("_DFDiscountLimit", _DFDiscountLimit.GetValue())
    ExportFloat("DebtPollhrs", DebtPollhrs.GetValue())
    ExportFloat("ETimerp", ETimerp.GetValue())
    ExportFloat("Tats", Tats.GetValue())
    ExportFloat("FollowerLivesMax", FollowerLivesMax)
    ExportFloat("PunishmentDealReduction", Q.PunishmentDealReduction)
    ExportFloat("PunishmentDebtReduction", Q.PunishmentDebtReduction)
    ExportFloat("DfcEnslavement", DfcSlaveryChance.GetValue())
    ExportFloat("SSO", SSO.GetValue())
    ExportFloat("LolaChance", LolaChance.GetValue())
    ExportFloat("EndlessSlaveWeight", Q.EndlessSlaveWeight)
    ExportFloat("EndlessSoldWeight", Q.EndlessSoldWeight)
    ExportFloat("EndlessAuctionWeight", Q.EndlessAuctionWeight)
    ExportFloat("EndlessLolaWeight", Q.EndlessLolaWeight)
    ExportFloat("PunishmentDebt", PunishmentDebt)
    ExportFloat("_DFLivesFollowerRape",_DFLivesFollowerRape.GetValue())
    ExportFloat("_DFAllowForceStart", _DFAllowForceStart.GetValue())
    
    ExportFloat("_DFChaosTimer",_DFChaosTimer)
    ExportFloat("_DFChaosPercent",_DFChaosPercent)
    ExportFloat("_DFChaosDays",_DFChaosDays)
    ExportFloat("_DFDebtperdayMax",_DFDebtperdayMax)
    ExportFloat("_DFDebtperdayMin",_DFDebtperdayMin)
    ExportFloat("_DFPunDebtMax",_DFPunDebtMax)
    ExportFloat("_DFPunDebtMin",_DFPunDebtMin)
    ExportFloat("_DFRemovalMax",_DFRemovalMax)
    ExportFloat("_DFRemovalMin ",_DFRemovalMin)
    ExportFloat("_DFRemovalIncMax",_DFRemovalIncMax)
    ExportFloat("_DFRemovalIncMin",_DFRemovalIncMin)
    ExportFloat("_DFDealsMaxPrice",_DFDealsMaxPrice)
    ExportFloat("_DFDealsMinPrice",_DFDealsMinPrice)
    ExportFloat("_DFDealsMaxDebt",_DFDealsMaxDebt)
    ExportFloat("_DFDealsMinDebt",_DFDealsMinDebt)
    ExportFloat("_DFDealsMaxPTime",_DFDealsMaxPTime)
    ExportFloat("_DFDealsMinPTime",_DFDealsMinPTime)
    ExportFloat("_DFDealsMaxMulti",_DFDealsMaxMulti)
    ExportFloat("_DFDealsMinMulti",_DFDealsMinMulti)
    ExportFloat("_DFLivesChaoMax",_DFLivesChaoMax)
    ExportFloat("_DFLivesChaoMin",_DFLivesChaoMin)

    ExportFloat("_DFSWeightD",_DFSWeightD)
    ExportFloat("_DFSWeightE",_DFSWeightE)
    ExportFloat("_DFSWeightED",_DFSWeightED)
    ExportFloat("_DFMinStolenPer",_DFMinStolenPer)
    ExportFloat("_DFMaxStolenPer",_DFMaxStolenPer)
    ExportFloat("_DFWillBool",_DFWillBool As Float)
    ExportFloat("_DFLocNoti",_DFLocNoti As Float)
    ExportFloat("_DFTheifsBool",_DFTheifsBool As Float)
    ExportFloat("_DFKConceal",_DFKConceal)
    ExportFloat("_DFKeyDiffI",_DFKeyDiffI As Float)
    ExportFloat("_DFRemovalMode",_DFRemovalMode As Float)
    ExportFloat("GoldCont.Stay0",GoldCont.Stay0 As Float)
    ExportFloat("GoldCont.KnockDown",GoldCont.KnockDown As Float)
    ExportFloat("GoldCont.Other",GoldCont.Other As Float)
    ExportFloat("GoldCont.Decay",GoldCont.Decay As Float)
    ExportFloat("GoldCont.RedGoldMod",GoldCont.RedGoldMod As Float)
    ExportFloat("_DFDealSCustArmor", _DFDealSCustArmor As Float)
    ExportFloat("GoldCont.CredToLeave", GoldCont.CredToLeave As Float)
    ExportFloat("_DFAnimalCont",_DFAnimalCont As Float)
    ExportFloat("DC.DealBias", DC.DealBias)
    ExportFloat("DSold.Active",DSold.Active As Float)
    ExportFloat("DSold.TimerMax",DSold.TimerMax As Float)
    ExportFloat("DSold.TimerMin",DSold.TimerMin As Float)
    ExportFloat("_DFSoldDeals",_DFSoldDeals.GetValue() As Float)
    ExportFloat("_DFShowRollMsg",_DFShowRollMsg As Float)
    ExportFloat("_DFZAZAutoPause",_DFZAZAutoPause As Float)
    ExportFloat("_DDeal.Stat",(DealS As _DDeal).Stat As Float)
    ExportFloat("DFPotQ.Enabled",DFPotQ.Enabled	As Float)
    ExportFloat("DFPotQ._DFlowPotionDeal",DFPotQ._DFlowPotionDeal.GetValue() As Float)
    ExportFloat("DFPotQ.EnabledEvil",DFPotQ.EnabledEvil As Float)
    ExportFloat("DFPotQ._DFlowPotionDealEvil",DFPotQ._DFlowPotionDealEvil.GetValue() As Float)
    ExportFloat("DFPotQ.DelayMin",DFPotQ.DelayMin As Float)
    ExportFloat("DFPotQ.DelayMax",DFPotQ.DelayMax As Float)
    ExportFloat("MinWillRegain", MinWillRegain)
    ExportFloat("MaxWillRegain", MaxWillRegain)
    ExportFloat("_DFMaxResistMCM",_DFMaxResistMCM As Float)
    ExportFloat("_DFMaxResistMin",_DFMaxResistMin As Float)
    ExportFloat("_DFMaxResistDevices",_DFMaxResistDevices As Float)
    ExportFloat("MDC.MaxModDealsSetting",MDC.MaxModDealsSetting As Float)
    ExportFloat("MDC.TimerSetting",MDC.TimerSetting As Float)
    ExportFloat("_DFWillRegainMode", _DFWillRegainMode As Float)
    ExportFloat("_DFResistanceWillDelta", _DFResistanceWillDelta)
    ExportFloat("_DFResistanceDealDelta", _DFResistanceDealDelta)
    ExportFloat("_DFResistanceLevelDelta", _DFResistanceLevelDelta)
    ExportFloat("_DFFatigueRate", _DFFatigueRate.GetValue())
    ExportFloat("_DFExpectedDealLimit", _DFExpectedDealLimit.GetValue())
    ExportFloat("_DFSexPreferenceIndex", SexPreferenceIndex As Float)
    ExportFloat("LicenseEnable", licenseStatusEnabledNew As Float)
    ExportFloat("LicenseForced", GoldCont.IsEnabledForcedLicenseControl As Float)
    ExportFloat("LicenseBasePrice", _DFLicenses.BasePrice)
    ExportFloat("LicenseMarkup", _DFLicenses.Markup)
    
    
    
    ; This  purposely does not save animation names...
    ; It's not a bug, it's a feature.
    ; This allows players to customise their animation names by editing the JSON and then doing a load.
    ; And they can save first to update their settings, without overwriting the animation values.
    ; This allows people that installed the betas to fix their animations by doing a settings save and restore.
    
    Int ii = 1
    While ii <= MDC.DealsBuilt
        Float RuleValue = MDC.GetRuleState(ii)
        If RuleValue > 1.0
            RuleValue = 1.0
        EndIf
        ExportFloat(MDC.OIDText[ii],RuleValue)
        ii += 1
    EndWhile
    
    JsonUtil.Save(File, False)
    
EndFunction


Function ImportSettings()

    File = "../DeviousFollowers/Dflow.json"
    
    Float settingsVersion = ImportFloat("_DFSettingsVersion", 0.0)
    DebtDifficulty = ImportFloat("DebtDifficulty", DebtDifficulty) As Int
    CustomDifficultyCurve = ImportFloat("CustomDifficultyCurve", CustomDifficultyCurve)
    DebtPerDayLoLevel = ImportFloat("DebtPerDayLoLevel", DebtPerDayLoLevel)
    DebtPerDayHiLevel = ImportFloat("DebtPerDayHiLevel", DebtPerDayHiLevel)
    EnslavementDebtScale = ImportFloat("EnslavementDebtScale", EnslavementDebtScale)
    FreedomCostScale = ImportFloat("FreedomCostScale", FreedomCostScale)
    FailureScale = ImportFloat("FailureScale", FailureScale)
    BaseDebtRelief = ImportFloat("BaseDebtRelief", BaseDebtRelief)
    BaseDebtBuyout = ImportFloat("BaseDebtBuyout", BaseDebtBuyout)

    _DFMinimumContract.SetValue(ImportFloat("_DFMinimumContract", _DFMinimumContract.GetValue()))
    DealDurationDays = ImportFloat("DealDurationDays", DealDurationDays)
    DeviceRemovalFirst = ImportFloat("DeviceRemovalFirst", DeviceRemovalFirst)
    DeviceRemovalInc = ImportFloat("DeviceRemovalInc", DeviceRemovalInc)
    DealEarlyMulti = ImportFloat("DealEarlyMulti", DealEarlyMulti)
    _DFlowRemovalDebtTimes.SetValue(ImportFloat("_DFlowRemovalDebtTimes", _DFlowRemovalDebtTimes.GetValue()))
    _DFlowItemsPerRemoved.SetValue(ImportFloat("_DFlowItemsPerRemoved", _DFlowItemsPerRemoved.GetValue()))
    _DFBoredomIntervalDays.SetValue(ImportFloat("_DFBoredomIntervalDays", _DFBoredomIntervalDays.GetValue()))
    _DFlowGambleJPot.SetValue(ImportFloat("_DFlowGambleJPot", _DFlowGambleJPot.GetValue()))
    _DflowEndlessMode.SetValue(ImportFloat("_DflowEndlessMode", _DflowEndlessMode.GetValue()))
     GoldCont.Active = (ImportFloat("_DflowGoldMode", GoldCont.Active As Float)) As Bool
     GoldCont.AgreedGoldMax = (ImportFloat("_DflowGoldModeMax", GoldCont.AgreedGoldMax As Float)) As Int
     GoldCont.AgreedGoldMin =(ImportFloat("_DflowGoldModeMin", GoldCont.AgreedGoldMin As Float)) As Int
    GoldCont.Stay0 = ImportFloat("GoldCont.Stay0",GoldCont.Stay0 As Float) As Bool
    GoldCont.KnockDown = ImportFloat("GoldCont.KnockDown",GoldCont.KnockDown As Float) As Bool
    GoldCont.Other= ImportFloat("GoldCont.Other",GoldCont.Other As Float) As Bool
    GoldCont.Decay = ImportFloat("GoldCont.Decay",GoldCont.Decay As Float)
    GoldCont.RedGoldMod = ImportFloat("GoldCont.RedGoldMod",GoldCont.RedGoldMod As Float)
     
    _DFlowWarmComp.SetValue(ImportFloat("_DFlowWarmComp", _DFlowWarmComp.GetValue()))
    
    _DFDailyDebtIncrement.SetValue(ImportFloat("_DFDailyDebtIncrement", _DFDailyDebtIncrement.GetValue()))
    Intrest.SetValue(ImportFloat("Intrest", Intrest.GetValue()))
    _DFDiscountLimit.SetValue(ImportFloat("_DFDiscountLimit", _DFDiscountLimit.GetValue()))
    DebtPollhrs.SetValue(ImportFloat("DebtPollhrs", DebtPollhrs.GetValue()))
    ETimerp.SetValue(ImportFloat("ETimerp", ETimerp.GetValue()))
    Tats.SetValue(ImportFloat("Tats", Tats.GetValue()))
    FollowerLivesMax = ImportFloat("FollowerLivesMax", FollowerLivesMax)
    
    Q.PunishmentDealReduction = ImportFloat("PunishmentDealReduction", Q.PunishmentDealReduction)
    Q.PunishmentDebtReduction = ImportFloat("PunishmentDebtReduction", Q.PunishmentDebtReduction)
    
    DfcSlaveryChance.SetValue(ImportFloat("DfcSlaveryChance", DfcSlaveryChance.GetValue()))
    SSO.SetValue(ImportFloat("SSO", SSO.GetValue()))
    LolaChance.SetValue(ImportFloat("LolaChance", LolaChance.GetValue()))
    
    Q.EndlessSlaveWeight = ImportFloat("EndlessSlaveWeight", Q.EndlessSlaveWeight)
    Q.EndlessSoldWeight = ImportFloat("EndlessSoldWeight", Q.EndlessSoldWeight)
    Q.EndlessAuctionWeight = ImportFloat("EndlessAuctionWeight", Q.EndlessAuctionWeight)
    Q.EndlessLolaWeight = ImportFloat("EndlessLolaWeight", Q.EndlessLolaWeight)
    
    PunishmentDebt = ImportFloat("PunishmentDebt", PunishmentDebt)
    _DFLivesFollowerRape.SetValue(ImportFloat("_DFLivesFollowerRape",_DFLivesFollowerRape.GetValue()))
    _DFAllowForceStart.SetValue(ImportFloat("_DFAllowForceStart", _DFAllowForceStart.GetValue()))

    _DFChaosTimer = ImportFloat("_DFChaosTimer",_DFChaosTimer)
    _DFChaosPercent = ImportFloat("_DFChaosPercent",_DFChaosPercent)
    _DFChaosDays = ImportFloat("_DFChaosDays",_DFChaosDays)
    _DFDebtperdayMax = ImportFloat("_DFDebtperdayMax",_DFDebtperdayMax)
    _DFDebtperdayMin = ImportFloat("_DFDebtperdayMin",_DFDebtperdayMin)
    _DFPunDebtMax =ImportFloat("_DFPunDebtMax",_DFPunDebtMax)
    _DFPunDebtMin =IMportFloat("_DFPunDebtMin",_DFPunDebtMin)
    _DFRemovalMax = ImportFloat("_DFRemovalMax",_DFRemovalMax)
    _DFRemovalMin = ImportFloat("_DFRemovalMin ",_DFRemovalMin)
    _DFRemovalIncMax = ImportFloat("_DFRemovalIncMax",_DFRemovalIncMax)
    _DFRemovalIncMin = ImportFloat("_DFRemovalIncMin",_DFRemovalIncMin)
    _DFDealsMaxPrice = ImportFloat("_DFDealsMaxPrice",_DFDealsMaxPrice)
    _DFDealsMinPrice = ImportFloat("_DFDealsMinPrice",_DFDealsMinPrice)
    _DFDealsMaxDebt = ImportFloat("_DFDealsMaxDebt",_DFDealsMaxDebt)
    _DFDealsMinDebt = ImportFloat("_DFDealsMinDebt",_DFDealsMinDebt)
    _DFDealsMaxPTime = ImportFloat("_DFDealsMaxPTime",_DFDealsMaxPTime)
    _DFDealsMinPTime = ImportFloat("_DFDealsMinPTime",_DFDealsMinPTime)
    _DFDealsMaxMulti = ImportFloat("_DFDealsMaxMulti",_DFDealsMaxMulti)
    _DFDealsMinMulti = ImportFloat("_DFDealsMinMulti",_DFDealsMinMulti)
    _DFLivesChaoMax = ImportFloat("_DFLivesChaoMax",_DFLivesChaoMax)
    _DFLivesChaoMin = ImportFloat("_DFLivesChaoMin",_DFLivesChaoMin)

    _DFSWeightD =ImportFloat("_DFSWeightD",_DFSWeightD)
    _DFSWeightE=ImportFloat("_DFSWeightE",_DFSWeightE)
    _DFSWeightED=ImportFloat("_DFSWeightED",_DFSWeightED)
    _DFMinStolenPer=ImportFloat("_DFMinStolenPer",_DFMinStolenPer) As Int
    _DFMaxStolenPer=ImportFloat("_DFMaxStolenPer",_DFMaxStolenPer) As Int
    _DFWillBool=ImportFloat("_DFWillBool",_DFWillBool As Float)
    _DFTheifsBool=ImportFloat("_DFTheifsBool",_DFTheifsBool As Float)
    _DFLocNoti= ImportFloat("_DFLocNoti",_DFLocNoti As Float)
    _DFKeyDiffI= ImportFloat("_DFKeyDiffI",_DFKeyDiffI As Float) As Int
    If _DFKeyDiffI == 0
        _DFKeyDiffS = "$DF_KEYDIF_EASY"
    ElseIf _DFKeyDiffI == 1
        _DFKeyDiffS = "$DF_KEYDIF_NORMAL"
    ElseIf _DFKeyDiffI == 2
        _DFKeyDiffS = "$DF_KEYDIF_HARD"
    ElseIf _DFKeyDiffI == 3
        _DFKeyDiffS = "$DF_KEYDIF_DEVIOUS"
    ElseIf _DFKeyDiffI == 4
        _DFKeyDiffS = "$DF_KEYDIF_SLAVE"
    EndIf
    _DFRemovalMode= ImportFloat("_DFRemovalMode",_DFRemovalMode As Float) As Int
    If _DFRemovalMode == 0
        _DFRemovalModeS = "$DF_REMOVAL_FULL" ; Full = Heavy bondage, gags, hood, gloves, mittens, boots.
    ElseIf _DFRemovalMode == 1
        _DFRemovalModeS = "$DF_REMOVAL_LIMITED" ; Limited = Heavy bondage, blindfold, and mittens.
    ElseIf _DFRemovalMode == 2
        _DFRemovalModeS = "$DF_REMOVAL_OFF" ; Off = None.
    EndIf
    _DFLocNoti= ImportFloat("_DFLocNoti",_DFLocNoti As Float)
    _DFDealSCustArmor = ImportFloat("_DFDealSCustArmor", _DFDealSCustArmor As Float) As Bool
    GoldCont.CredToLeave = ImportFloat("GoldCont.CredToLeave", GoldCont.CredToLeave As Float) As Int
    _DFAnimalCont = ImportFloat("_DFAnimalCont",_DFAnimalCont As Float) As Bool
    DC.DealBias = ImportFloat("DC.DealBias", DC.DealBias)
    DSold.Active=importFloat("DSold.Active",DSold.Active As Float) As bool
    DSold.TimerMax=importFloat("DSold.TimerMax",DSold.TimerMax As Float)
    DSold.TimerMin=importFloat("DSold.TimerMin",DSold.TimerMin As Float)
    _DFSoldDeals.SetValue(importFloat("_DFSoldDeals", _DFSoldDeals.GetValue() As Float))
    _DFShowRollMsg=ImportFloat("_DFShowRollMsg", _DFShowRollMsg As Float) As bool
    _DFZAZAutoPause = ImportFloat("_DFZAZAutoPause", _DFZAZAutoPause As Float)  As bool
    (DealS As _DDeal).Stat = ImportFloat("_DDeal.Stat", (DealS As _DDeal).Stat As Float) As Int
    DFPotQ.Enabled = ImportFloat("DFPotQ.Enabled", DFPotQ.Enabled	As Float) As bool
    DFPotQ._DFlowPotionDeal.SetValue(ImportFloat("DFPotQ._DFlowPotionDeal", DFPotQ._DFlowPotionDeal.GetValue() As Float))
    DFPotQ.EnabledEvil = ImportFloat("DFPotQ.EnabledEvil", DFPotQ.EnabledEvil As Float) As Bool
    DFPotQ._DFlowPotionDealEvil.SetValue(ImportFloat("DFPotQ._DFlowPotionDealEvil", DFPotQ._DFlowPotionDealEvil.GetValue() As Float))
    DFPotQ.DelayMin = ImportFloat("DFPotQ.DelayMin", DFPotQ.DelayMin As Float)
    DFPotQ.DelayMax = ImportFloat("DFPotQ.DelayMax", DFPotQ.DelayMax As Float)
    MinWillRegain = ImportFloat("MinWillRegain", MinWillRegain)
    MaxWillRegain = ImportFloat("MaxWillRegain", MaxWillRegain)
    _DFMaxResistMCM=ImportFloat("_DFMaxResistMCM",_DFMaxResistMCM As Float) As Int
    _DFMaxResistMin=ImportFloat("_DFMaxResistMin",_DFMaxResistMin As Float) As Int
    _DFMaxResistDevices=ImportFloat("_DFMaxResistDevices",_DFMaxResistDevices As Float) As Bool
    MDC.MaxModDealsSetting = ImportFloat("MDC.MaxModDealsSetting",MDC.MaxModDealsSetting As Float) As Int 
    MDC.EnableDeals()
    _DFWillRegainMode = ImportFloat("_DFWillRegainMode", _DFWillRegainMode As Float) As Int
    _DFResistanceWillDelta = ImportFloat("_DFResistanceWillDelta", _DFResistanceWillDelta)
    _DFResistanceDealDelta = ImportFloat("_DFResistanceDealDelta", _DFResistanceDealDelta)
    _DFResistanceLevelDelta = ImportFloat("_DFResistanceLevelDelta", _DFResistanceLevelDelta)
    _DFFatigueRate.SetValue(ImportFloat("_DFFatigueRate", _DFFatigueRate.GetValue()))
    _DFExpectedDealLimit.SetValue(ImportFloat("_DFExpectedDealLimit", _DFExpectedDealLimit.GetValue()))
    SexPreferenceIndex = ImportFloat("_DFSexPreferenceIndex", SexPreferenceIndex As Float) As Int
    Tool.SetScanGenders(SexPreferenceIndex)
    DismissalIndex = ImportFloat("_DFDismissalIndex", DismissalIndex As Float) As Int
    SetDismissalRules(DismissalIndex)
    
    Tool.SpankAnimationNames = New String[3]
    Tool.SpankAnimationNames[0] = ImportString("Spank.AnimationInterior_0", "DF Nibbles Spanking (Chair)")
    Tool.SpankAnimationNames[1] = ImportString("Spank.AnimationInterior_1", "DF Nibbles Spanking (Paddle)")
    Tool.SpankAnimationNames[2] = ImportString("Spank.AnimationInterior_2", "DF Anubs Rape")
    
    Tool.SpankAnimationNamesExt = New String[3]
    Tool.SpankAnimationNamesExt[0] = ImportString("Spank.AnimationExterior_X0", "DF Anubs Spank")
    Tool.SpankAnimationNamesExt[1] = ImportString("Spank.AnimationExterior_X1", "DF Anubs Spank Fist")
    Tool.SpankAnimationNamesExt[2] = ImportString("Spank.AnimationExterior_X2", "DF Anubs Rape")
    
    Tool.SpankAnimationNamesExtAlt = New String[3]
    Tool.SpankAnimationNamesExtAlt[0] = ImportString("Spank.AnimationExterior_Y0", "DF Rydin Overlap Spanking")
    Tool.SpankAnimationNamesExtAlt[1] = ImportString("Spank.AnimationExterior_Y1", "DF Rydin Underarm Spanking")
    Tool.SpankAnimationNamesExtAlt[2] = ImportString("Spank.AnimationExterior_Y2", "DF Anubs Rape")
    
    licenseStatusEnabledNew = ImportFloat("LicenseEnable", licenseStatusEnabledNew As Float) As Bool
    GoldCont.IsEnabledForcedLicenseControl = ImportFloat("LicenseForced", GoldCont.IsEnabledForcedLicenseControl As Float) As Bool
    _DFLicenses.BasePrice = ImportFloat("LicenseBasePrice", _DFLicenses.BasePrice)
    _DFLicenses.Markup = ImportFloat("LicenseMarkup", _DFLicenses.Markup)

    
    MDC.TimerSetting = ImportFloat("MDC.TimerSetting",MDC.TimerSetting As Float)
    
    Int ii = 1
    Float NewRuleValue
    Float RuleValue
    While ii <= MDC.DealsBuilt
        RuleValue = MDC.GetRuleState(ii)
        NewRuleValue = importFloat(MDC.OIDText[ii], RuleValue)
        If RuleValue <= 1.0 && NewRuleValue >= 0
            MDC.SetRule(ii, NewRuleValue As Int)
        EndIf
        
        ii += 1
    EndWhile
    
    If settingsVersion < 212.01 
        SetupDebtDifficulty()
        ;Debug.MessageBox("$DF_OBSOLETE_SETTINGS") ; Doesn't work ... 
        Debug.MessageBox("Your settings file has no version and pre-dates DF 2.12.1\nSettings older than this cannot be cleanly restored. Some restored values have been overwritten with safe defaults.")
    EndIf
    
    CalculateScaledDebts()

EndFunction

Function ExportFloat(String name, Float value)
    JsonUtil.SetFloatValue(File, name, value)
EndFunction

Float Function ImportFloat(String name, Float defaultValue)
    Return JsonUtil.GetFloatValue(File, name, defaultValue)
EndFunction

Function ExportString(String name, String value)
    JsonUtil.SetStringValue(File, name, value)
EndFunction

String Function ImportString(String name, String defaultValue)
    Return JsonUtil.GetStringValue(File, name, defaultValue)
EndFunction

Function ResetQuests(Bool everything = False)

    Q.ResetDflowMain()
    QuestStage.SetValue(0.0) ; the saved quest stage for pause
    (DealController As  QF__DflowDealController_0A01C86D).ResetAllDeals()
    GoldCont.Endit()
    Dflow.Reset()
    DealB.reset()
    DealO.reset()
    DealH.reset()
    DealP.reset()
    DealS.reset()
    SEvents.Reset()
    Games.Reset()
    BoredomQuest.Reset()
    BoredomQuest.Start()
    Tool.ResetExpectations()

    _DFlowForcedStart.JustStopIt()
    _DFlowForcedStart.Reset()

    Dflow.SetStage(0)

    If everything
        Debt.SetValue(0.0)
        _DFFatigue.SetValue(0.0)
        Resist.SetValue(10)
        Will.SetValue(10)
        DFPotQ.ResetQuest()
    EndIf
    
    MDC.End()
    MDC.Update()
    
EndFunction

Function PauseMod()

    If !IsPaused
        IsPaused = True
        ; When pausing, it's possible there IS no DF, and nothing is running.
        Factor = Follower.GetActorReference() ; So we can restore them...

        PauseTimerElapsed = Q.Timer.GetValue() - Utility.GetCurrentGameTime()

        ; Don't save debt as it shouldn't be modified while we're paused.
        GoldCont.Pause() ; Can modify debt
        _DFLicenses.Pause(True)
        QuestStage.SetValue(DFlow.getstage())

        DealManager.Pause()
        
        Dflow.reset()
        SEvents.Reset()
        Games.Reset()
        Dflow.Stop()
        DS1.Stop()
        DS2.Stop()
        DSB.Stop()
        BoredomQuest.Stop()
        _DFlowForcedStart.Stop()
    EndIf
    Pause.SetValue(0.0)
    
EndFunction


Function ResumeMod()

    If IsPaused
        IsPaused = False
        If Factor

            If Factor.IsDead()
                ; Find a suitable replacement...?
                Actor replacement = Tool.FindNewFollower()
                If replacement
                    Factor = replacement
                Else
                    Factor.Resurrect() ; Could be a bit of a long-shot.
                EndIf
            EndIf
            
            ; In case player sneakily disabled them while we were paused.
            Q.ForceEnableDevious(Factor)

            Dflow.start()
            Dflow.Setstage(QuestStage.GetValue() As Int)

            _DFLicenses.Pause(False)

            DealManager.Resume()
            
            Tool.RestorePunishmentTracking(Factor)

            Follower.ForceRefTo(FActor)
            DSold.FixAliases(FActor)
            
            Q.Timer.SetValue(PauseTimerElapsed + Utility.GetCurrentGameTime())
        
        Else
            ; No follower ... Can pause with no follower, should come back cleanly.
            Dflow.start()
            Dflow.Setstage(0)
            DealB.SetStage(0)
            DealO.SetStage(0)
            DealH.SetStage(0)
            DealP.SetStage(0)
            DealS.SetStage(0)
            Q.Timer.SetValue(Utility.GetCurrentGameTime())
        EndIf
        
        Pause.SetValue(1.0) ; Check to see if this needs to happen here and is used by the other function calls?
        MDC.Resume()
        DS1.Start()
        DS2.Start()
        DSB.Start()
        BoredomQuest.Start()
        _DFlowForcedStart.Start()
        GoldCont.Unpause() ; Can modify debt
        DC.PickRandomDeal()
        Debug.Notification("$DF_UNPAUSED")
    EndIf
    Pause.SetValue(1.0)
    
EndFunction

Function Chaos(Bool forceFullUpdate = False)

    If forceFullUpdate || (_DFChaoGo && _DFChaosTimer <= GameDaysPassed.GetValue())
    
        _DFChaosTimer = GameDaysPassed.GetValue() + _DFChaosDays
        Float weight = _DFChaosPercent * 0.01
        If forceFullUpdate
            weight = 1.0
        EndIf
        
        ChaosDailyDebt    = Chaosify(_DFDebtperdayMin,_DFDebtperdayMax, weight, ChaosDailyDebt) ; Y
        ChaosPunishmentDebt   = Chaosify(_DFPunDebtMin,_DFPunDebtMax, weight, ChaosPunishmentDebt)
        ChaosDeviceRemovalFirst = Chaosify(_DFRemovalMin,_DFRemovalMax, weight, ChaosDeviceRemovalFirst)
        ChaosDeviceRemovalInc   = Chaosify(_DFRemovalIncMin,_DFRemovalIncMax, weight, ChaosDeviceRemovalInc)
        ChaosDealRelief   = Chaosify(_DFDealsMinDebt,_DFDealsMaxDebt, weight, ChaosDealRelief) ; Y
        ChaosDealBuyout   = Chaosify(_DFDealsMinPrice,_DFDealsMaxPrice, weight, ChaosDealBuyout) ; Y
        
        ; This doesn't range from 0.1 to 10.0 but from 0.0 to 20.
        ; Map to the 0.1 to 10.0 range and back again.
        Float multiMin = _DFDealsMinMulti * 0.495 + 0.1
        Float multiMax = _DFDealsMaxMulti * 0.495 + 0.1
        Float multiCur = ChaosDealEarlyMulti * 0.495 + 0.1
        Float multiNew = Chaosify(multiMin, multiMax, weight, multiCur)
        ChaosDealEarlyMulti = (multiNew - 0.1) / 0.495

        Float v = Utility.RandomFloat(_DFDealsMinPTime, _DFDealsMaxPTime)
        ChaosDealDurationDays = weight * v + (1.0 - weight) * ChaosDealDurationDays
        
        v = Utility.RandomFloat(_DFLivesChaoMin, _DFLivesChaoMax)
        ChaosFollowerLivesMax = weight * v + (1.0 - weight) * ChaosFollowerLivesMax
        
        CalculateScaledDebts()
    Endif
    
EndFunction

Float Function Chaosify(Float lo, Float hi, Float weight, Float current)
    ; Calculate the random values and the historical blend in Log space
    ; This makes the scale values into LINEAR values, so the random distribution isn't utterly useless.
    ; Old chaos didn't use scales much ( but when it did, but it was awful at it)
    ; Now it's almost ALL scalars. We need them to work sensibly or chaos will not be useful.
    
    current = fClamp(lo, hi, current) ; Ensure current value starts within current chaos bounds
    Float logOld = Log10(current)
    Float logLo  = Log10(lo)
    Float logHi  = Log10(hi)
    Float logNew = Utility.RandomFloat(logLo, LogHi)
    
    Float blended = logNew * weight + logOld * (1.0 - weight)
    Float linearNew = Math.Pow(10.0, blended)
    
    If  linearNew < 0.1
        linearNew = 0.1
    ElseIf linearNew > 10.0
        linearNew = 10.0
    EndIf
    
    Return linearNew
EndFunction


Function CalculateScaledDebts()

    ; L = Lo-debt is at level 1
    ; H = Hi-debt is at level 101
    ; V = Level
    ; K = the exponent
    ; How get scale between this is based on a set of exponents K, which vary with difficulty
    ; debtScalar = L + (H - L) / Power((V - 1), K)
    Float level = PlayerRef.GetLevel() As Float
    
    Float dealDays = DealDurationDays
    Float livesMax = FollowerLivesMax
    Float dealEarlyBuyoutMulti = DealEarlyMulti * 0.01 ; Convert percentage to scale.
    
    Float chaosScaleDailyDebt = 1.0
    Float chaosScaleDebtRelief = 1.0
    Float chaosScaleDebtBuyout = 1.0
    Float chaosScalePunishmentDebt = 1.0
    Float chaosScaleDeviceRemovalFirst = 1.0
    Float chaosScaleDeviceRemovalInc = 1.0
    If _DFChaoGo
        dealDays = ChaosDealDurationDays
        livesMax = ChaosFollowerLivesMax
        dealEarlyBuyoutMulti = ChaosDealEarlyMulti
        
        chaosScaleDailyDebt = ChaosDailyDebt
        chaosScaleDebtRelief = ChaosDealRelief
        chaosScaleDebtBuyout = ChaosDealBuyout
        chaosScalePunishmentDebt = ChaosPunishmentDebt
        chaosScaleDeviceRemovalFirst = ChaosDeviceRemovalFirst
        chaosScaleDeviceRemovalInc = ChaosDeviceRemovalInc
    EndIf
    
    _DflowDealBaseDays.SetValue(dealDays)
    UpdateLivesMax(livesMax)
    
    Float exponent = debtExponents[DebtDifficulty]
    _DflowDebtExponent.SetValue(exponent)
    
    Float x100 = (DebtPerDayHiLevel - DebtPerDayLoLevel) / Math.Pow(100, exponent)
    DebtPerLevel.SetValue(x100)

    Float perDay = DebtPerDayLoLevel + x100 * Math.Pow(level - 1.0, exponent) * chaosScaleDailyDebt
    DebtPerDay.SetValue(perDay)

    Float enslaveAt = EnslavementDebtScale * perDay
    EnslavementDebt.SetValue(enslaveAt)
    
    HEDebt.SetValue(enslaveAt * 0.5)  
    
    Float failureDebt = enslaveAt + FailureScale * perDay
    Failure.SetValue(failureDebt)
    
    Float freedomCredit = FreedomCostScale * perDay
    FreedomCost.SetValue(freedomCredit)

    ; Deal pricing
    Float debtRelief = BaseDebtRelief * perDay * 0.01 * chaosScaleDebtRelief
    _DflowDealBaseDebt.SetValue(debtRelief)
    
    Float debtBuyout = BaseDebtBuyout * perDay * 0.01 * chaosScaleDebtBuyout
    _DflowDealBasePrice.SetValue(debtBuyout)

    ; Early deal buyout
    _DFlowDealMulti.SetValue(dealEarlyBuyoutMulti)
    
    
    ; PunishmentDebt
    _DFPunDebt.SetValue(perDay * PunishmentDebt * 0.01 * chaosScalePunishmentDebt)
    
    ; Device Removal
    _DflowRemovalBasePrice.SetValue(perDay * DeviceRemovalFirst * 0.01 * chaosScaleDeviceRemovalFirst)
    _DflowRemovalInc.SetValue(perDay * DeviceRemovalInc * 0.01 * chaosScaleDeviceRemovalInc)
    
EndFunction


Function UpdateLivesMax(Float newMaxLivesF)

        Int newMaxLives = (newMaxLivesF + 0.5) As Int

        Int currentLives = Lives.GetValue() As Int
        Int currentMaxLives = LivesM.GetValue() As Int
        
        If newMaxLives != currentMaxLives
        
            Int deltaLife = newMaxLives - currentMaxLives
            currentLives += deltaLife
            currentLives = iClamp(0, newMaxLives, currentLives)
            
            Lives.SetValue(currentLives As Float)
            LivesM.SetValue(newMaxLives As Float)
            
        EndIf

EndFunction



; No idea why this should Return anything, but it was declared to do so, and didn't, causing bogus log spam.
; The Return value should be deprecated. I do not see any code that uses the Return value of Noti.
Bool Function Noti(String msg, Int n = 0)

    They() ; Updates the local MCM follower alias
    
    If msg == "DebtAdd"
        Debug.Notification("$DF_DEBTADD_NOTI")
    ElseIf msg == "DebtOver"
        Debug.Notification("$DF_DEBTOVER_NOTI")
    ElseIf msg == "DebtTired"
        Debug.Notification("$DF_DEBTTIRED_NOTI")
    ElseIf msg == "TiredAdded"
        RemoveDebtNoti(n As Int)
        Debug.Notification("$DF_TIREDADDED2_NOTI")
    ElseIf msg == "NipP"
        Debug.Notification("$DF_NIPPELP_NOTI")
    ElseIf msg == "Piggy"
        Debug.Notification(""+n)
        Debug.Notification("$DF_PIGGY_NOTI")
        
    ElseIf msg == "NoH"
        Debug.notification("$DF_NOHORSE_NOTI") 
    ElseIf msg == "NoL"
        Debug.notification("$DF_NOREST_NOTI") 
    ElseIf msg == "6"
        Debug.notification("$DF_MIN6HSLEEP_NOTI")
    ElseIf msg == "H1"
        Debug.notification("$DF_HORSESEX2_NOTI")
        Debug.notification("$DF_HORSESEX1_NOTI") 
    ElseIf msg == "H2"
        Debug.notification("$DF_HORSECONT_NOTI")
    ElseIf msg == "H3"
        Debug.notification("$DF_HORSEEXH1_NOTI")
        Debug.notification("$DF_HORSEEXH2_NOTI")
    ElseIf msg == "S1"
        Debug.notification("$DF_SLEEPTIED_NOTI") 
    ElseIf msg == "S2"
        Debug.notification("$DF_SLEEPCOUGHT_NOTI")
    ElseIf msg == "Will"
    
        If n == 0 
            Debug.notification("$DF_WILLPOWER0_NOTI")
        ElseIf n == 1
            Debug.notification("$DF_WILLPOWER1_NOTI")
        ElseIf n == 2
            Debug.notification("$DF_WILLPOWER2_NOTI")
        ElseIf n == 3
            Debug.notification("$DF_WILLPOWER3_NOTI")
        ElseIf n == 4
            Debug.notification("$DF_WILLPOWER4_NOTI")
        ElseIf n == 5
            Debug.notification("$DF_WILLPOWER5_NOTI")
        ElseIf n == 6
            Debug.notification("$DF_WILLPOWER6_NOTI")
        ElseIf n == 7
            Debug.notification("$DF_WILLPOWER7_NOTI")
        ElseIf n == 8
            Debug.notification("$DF_WILLPOWER8_NOTI")
        ElseIf n == 9
            Debug.notification("$DF_WILLPOWER9_NOTI")
        ElseIf n == 10
            Debug.notification("$DF_WILLPOWER10_NOTI")
        EndIf
        
    ElseIf msg == "W1"
        Debug.notification("$DF_WAKERESTRAINT1_NOTI")
        Debug.notification("$DF_WAKERESTRAINT2_NOTI")
    ElseIf msg == "W2"
        Debug.notification("$DF_WAKEFREEFRESH_NOTI")
    ElseIf msg == "W3"
        Debug.notification("$DF_WAKEWILLPREST_NOTI")
    ElseIf msg == "W4"
        Debug.notification("$DF_WAKELSTRONGER_NOTI")
    ElseIf msg == "W5"
        Debug.notification("$DF_WAKELITTLEHLP_NOTI")
    ElseIf msg == "Pier"
            Debug.notification("$DF_PIERCSHOCK_NOTI")
    ElseIf msg == "Pier2"
        Debug.notification("$DF_PIERCTINGLE_NOTI")
    ElseIf msg == "Pier3"
        Debug.notification("$DF_PIERCMSHOCK_NOTI")
    ElseIf msg == "Pier4"
            Debug.notification("$DF_PIERCREWARD_NOTI")
    ElseIf msg == "JG"
        Debug.notification("$DF_JARLWHISTLE_NOTI")
    ElseIf msg == "JG1"
        Debug.notification("$DF_JARLWHISTLEA_NOTI")
    ElseIf msg == "JG2"
        Debug.notification("$DF_JARLGUARDSC_NOTI")
    ElseIf msg == "JG3"
        Debug.notification("$DF_JARLGUARDSOFF_NOTI")
    ElseIf msg == "Snap"
        Debug.notification("$DF_LIMBSSNAPBACK_NOTI")
    ElseIf msg == "Unsnap"
        Debug.notification("$DF_LIMBSUNSNAP_NOTI")
    ElseIf msg == "LocD" || msg == "LocDw" || msg == "LocT" || msg == "LocW"
        NotifyLocationChanged(msg)
    EndIf
    
    Return False
    
EndFunction


Function NotifyLocationChanged(String change)

    _currentLocationType = change
    
    If _DFLocNoti

        If change == "LocD"
            Debug.notification("$DF_DUNGEON")
        ElseIf change == "LocDw"
            Debug.notification("$DF_DWELLING")
        ElseIf change == "LocT"
            Debug.notification("$DF_TOWN")
        Else
            Debug.notification("$DF_WILDERNESS")
        EndIf
        
    EndIf
    
EndFunction


Function AddDebtNoti(Int n)
    Game.GetPlayer().AddItem(_DFDebt001, n) 
    Game.GetPlayer().RemoveItem(_DFDebt001, n,True) 
EndFunction


Function RemoveDebtNoti(Int n)
    Game.GetPlayer().AddItem(_DFDebt001, n,True) 
    Game.GetPlayer().RemoveItem(_DFDebt001, n) 
EndFunction


Function NotiGam(Float a=0.0, Int roll=0)

    If Roll==1
        Debug.notification("$DF_GAMEROLL1D_NOTI")
        AddDebtNoti((a*0.6) As Int)
    ElseIf Roll == 2
        Debug.notification("$DF_GAMEROLL2D_NOTI")
        AddDebtNoti((a*0.534) As Int)
    ElseIf roll == 3
        Debug.notification("$DF_GAMEROLL3D_NOTI")
        AddDebtNoti((a*0.4667) As Int)
    ElseIf roll == 4
        Debug.notification("$DF_GAMEROLL4D_NOTI")
        AddDebtNoti((a*0.4) As Int)
    ElseIf roll == 5
        Debug.notification("$DF_GAMEROLL5D_NOTI")
        AddDebtNoti((a*0.334) As Int)
    ElseIf roll == 6
        Debug.notification("$DF_GAMEROLL6D_NOTI")
        AddDebtNoti((a*0.267) As Int)
    EndIf

EndFunction


Function They()
    Actor who = Follower.GetActorReference()
    If who
        MCMFollower.ForceRefTo(who)
    Else
        MCMFollower.Clear()
    EndIf
EndFunction


Float Function GetWillAdjustedMaxResist(Float willpower, Float maxResist)

    ; This adds the per/will adjustment onto the maxResist from GetMaxResist()
    _Dutil.Info("DF - FindMaxResist: willpower " + willpower + ", maxResist " + maxResist)

    Float delta = _DFResistanceWillDelta
    
    Float willLost = 10.0 - willpower
    Float resistance = maxResist + delta*willLost
    
    Float minResistance = _DFMaxResistMin
    If resistance < minResistance
        resistance = minResistance
    EndIf
    
    _Dutil.Info("DF - FindMaxResist: delta " + delta + ", calculated resistance " + resistance)
    
    Return resistance
    
EndFunction


; Used by the DFtools code in ReduceResist() and RestoreResist()
; It may apply some tweaks to the MCM-configured max-resist value
; It modifies based on deals, or level, or devices worn, but NOT willpower.
; The willpower modification only occurs at the point we know the current willpower in _DFTools.
Int Function GetMaxResist()

    Float dealDelta = _DFResistanceDealDelta * (DC.Deals As Float)
    Float levelsGained = (PlayerRef.GetLevel() - 1) As Float
    Float levelDelta = _DFResistanceLevelDelta * levelsGained
    Float deviceDelta = GetDeviceResistanceDelta() ; Takes MCM toggle into account

    Float effectiveMaxResist = (_DFMaxResistMCM As Float) + dealDelta + levelDelta + deviceDelta
    
    If effectiveMaxResist < _DFMaxResistMin
        effectiveMaxResist = _DFMaxResistMin
    EndIf
    
    Int maxResist = effectiveMaxResist As Int
    
    If maxResist < 1
        maxResist = 1
    EndIf
    
    Return maxResist
    
EndFunction

Float Function GetDeviceResistanceDelta()
    ; This used to punish only up to 4.0 points, and included HeavyBondage.
    ; It now punishes explicitly only items that have no meaningful drawback of their own...
    ; Plus the rare FrontCuffs ... which just happens to be on Chains of Debt, making CoD a 4 point penalty by itself.
    Float delta = 0.0
    If _DFMaxResistDevices

    If PlayerRef.WornHasKeyword(Tool.libs.zad_DeviousCollar)
            delta -= 2.0
        EndIf
        If PlayerRef.WornHasKeyword(Tool.libs.zad_DeviousArmCuffs)
            delta -= 1.0
        EndIf
        If PlayerRef.WornHasKeyword(Tool.libs.zad_DeviousLegCuffs)
            delta -= 1.0
        EndIf
        If PlayerRef.WornHasKeyword(Tool.libs.zad_DeviousCuffsFront)
            delta -= 1.0
        EndIf
        
        If PlayerRef.WornHasKeyword(Tool.libs.zad_DeviousCorset)
            delta -= 1.0
        ElseIf PlayerRef.WornHasKeyword(Tool.libs.zad_DeviousHarness)
            delta -= 1.0
        EndIf
        
    EndIf
    Return delta
EndFunction

Float Function Min(Float x, Float y)
    If x < y
        Return x
    Else
        Return y
    EndIf
EndFunction

Float Function Max(Float x, Float y)
    If x > y
        Return x
    Else
        Return y
    EndIf
EndFunction

String Function FormatFloat_N2(Float value) Global
    Return FormatDecimal_x100((value * 100.0) as Int)
EndFunction

String Function FormatFloat_N1(Float value) Global
    Return FormatDecimal_x10((value * 10.0) as Int)
EndFunction

String Function FormatFloat_N0(Float value) Global
    Return "" + ((value+0.5) as Int)
EndFunction

String Function FormatFloatPercent_N0(Float value) Global
    Return "" + ((value+0.5) as Int) + "%"
EndFunction

String Function FormatFloatPercent_N1(Float value) Global
    Return FormatDecimal_x10((value * 10.0) as Int) + "%"
EndFunction

; Format single-digit fixed point integer as string.
String Function FormatDecimal_x10(Int value) Global
{Format an integer in fixed point format with a single digit of precision.}

    String sign = ""
    If value < 0
        sign = "-"
        value = -value
    EndIf
    
	Int x10 = value / 10
	Int remainder = value - (x10 * 10)
	
	return sign + (x10 as String) + "." + remainder
	
EndFunction

; Format two-digit fixed point integer as string.
String Function FormatDecimal_x100(Int value) Global
{Format an integer in fixed point format with two digits of precision.}

    String sign = ""
    If value < 0
        sign = "-"
        value = -value
    EndIf
    
	Int x10 = value / 10  ; e.g. 12456 => 12345
	Int x100 = x10 / 10   ; 123456 => 1234
	Int remainder1 = value - (x10 * 10) ; 123456 - 123450
	Int remainder2 = x10 - (x100 * 10) ; 12345 - 12340
	
	return sign + (x100 as String) + "." + remainder2 + remainder1
	
EndFunction

; Return a Float value bounded by upper and lower limits.
Float Function fClamp(Float lowerLimit, Float upperLimit, Float toBound) Global
{Clamps a FLOAT value within upper and lower limits.}
    If toBound > upperLimit
        Return upperLimit
    ElseIf toBound < lowerLimit
        Return lowerLimit
    Else
        Return toBound
    EndIf
EndFunction

; Return an Int value bounded by upper and lower limits.
Int Function iClamp(Int lowerLimit, Int upperLimit, Int toBound) Global
{Clamps an INT value within upper and lower limits.}
    If toBound > upperLimit
        Return upperLimit
    ElseIf toBound < lowerLimit
        Return lowerLimit
    Else
        Return toBound
    EndIf
EndFunction


; Skyrim Math script has no LOG function :(
; Never mind, we will overcome!
; And without recourse to a SKSE plugin this time...
; Fortunately, we only need to handle values from 0.1 to 10.0 with an interval of 0.1
; Values outside that range, including negatives, are clamped.
Float Function Log10(Float x)
    Int ii = (x * 10.0 + 0.5) As Int
    If ii < 1
        Return -1.0
    ElseIf ii > 100
        Return 1.0
    Else
        Float v = Logs[ii]
        Return v
    EndIf
EndFunction

Function BuildLogTable()
    Logs = New Float[101]
    Logs[0] = -1.0
    Logs[ 1] = -1.0
    Logs[ 2] = -0.698970
    Logs[ 3] = -0.522879
    Logs[ 4] = -0.397940
    Logs[ 5] = -0.301030
    Logs[ 6] = -0.221849
    Logs[ 7] = -0.154902
    Logs[ 8] = -0.096910
    Logs[ 9] = -0.045757
    Logs[10] = 0.0
    Logs[11] = 0.041393
    Logs[12] = 0.079181
    Logs[13] = 0.113943
    Logs[14] = 0.146128
    Logs[15] = 0.176091
    Logs[16] = 0.204120
    Logs[17] = 0.230449
    Logs[18] = 0.255273
    Logs[19] = 0.278754
    Logs[20] = 0.301030
    Logs[21] = 0.322219
    Logs[22] = 0.342423
    Logs[23] = 0.361728
    Logs[24] = 0.380211
    Logs[25] = 0.397940
    Logs[26] = 0.414973
    Logs[27] = 0.431364
    Logs[28] = 0.447158
    Logs[29] = 0.462398
    Logs[30] = 0.477121
    Logs[31] = 0.491362
    Logs[32] = 0.505150
    Logs[33] = 0.518514
    Logs[34] = 0.531479
    Logs[35] = 0.544068
    Logs[36] = 0.556303
    Logs[37] = 0.568202
    Logs[38] = 0.579784
    Logs[39] = 0.591065
    Logs[40] = 0.602060
    Logs[41] = 0.612784
    Logs[42] = 0.623249
    Logs[43] = 0.633468
    Logs[44] = 0.643453
    Logs[45] = 0.653213
    Logs[46] = 0.662758
    Logs[47] = 0.672098
    Logs[48] = 0.681241
    Logs[49] = 0.690196
    Logs[50] = 0.698970
    Logs[51] = 0.707570
    Logs[52] = 0.716003
    Logs[53] = 0.724276
    Logs[54] = 0.732394
    Logs[55] = 0.740363
    Logs[56] = 0.748188
    Logs[57] = 0.755875
    Logs[58] = 0.763428
    Logs[59] = 0.770852
    Logs[60] = 0.778151
    Logs[61] = 0.785330
    Logs[62] = 0.792392
    Logs[63] = 0.799341
    Logs[64] = 0.806180
    Logs[65] = 0.812913
    Logs[66] = 0.819544
    Logs[67] = 0.826075
    Logs[68] = 0.832509
    Logs[69] = 0.838849
    Logs[70] = 0.845098
    Logs[71] = 0.851258
    Logs[72] = 0.857332
    Logs[73] = 0.863323
    Logs[74] = 0.869232
    Logs[75] = 0.875061
    Logs[76] = 0.880814
    Logs[77] = 0.886491
    Logs[78] = 0.892095
    Logs[79] = 0.897627
    Logs[80] = 0.903090
    Logs[81] = 0.908485
    Logs[82] = 0.913814
    Logs[83] = 0.919078
    Logs[84] = 0.924279
    Logs[85] = 0.929419
    Logs[86] = 0.934498
    Logs[87] = 0.939519
    Logs[88] = 0.944483
    Logs[89] = 0.949390
    Logs[90] = 0.954243
    Logs[91] = 0.959041
    Logs[92] = 0.963788
    Logs[93] = 0.968483
    Logs[94] = 0.973128
    Logs[95] = 0.977724
    Logs[96] = 0.982271
    Logs[97] = 0.986772
    Logs[98] = 0.991226
    Logs[99] = 0.995635
    Logs[100] = 1.0
EndFunction

Function ResetAllOIDs()

    OID_AFTcount = -2
    OID_ActualDealCountText = -2
    OID_AddAnalPlug = -2
    OID_AddArmCuffs = -2
    OID_AddBelt = -2
    OID_AddBlindfold = -2
    OID_AddBoots = -2
    OID_AddBra = -2
    OID_AddChainsOfDebt = -2
    OID_AddCollar = -2
    OID_AddCorsetHarness = -2
    OID_AddDebtDebug100 = -2
    OID_AddDebtDebugTog = -2
    OID_AddFollowerDebug = -2
    OID_AddFullSet = -2
    OID_AddGag = -2
    OID_AddGloves = -2
    OID_AddHeavyBondage = -2
    OID_AddHobbleDress = -2
    OID_AddLegCuffs = -2
    OID_AddMittens = -2
    OID_AddNipplePiercing = -2
    OID_AddPetSuit = -2
    OID_AddPrisonerChains = -2
    OID_AddSlaveKit = -2
    OID_AddVaginalPiercing = -2
    OID_AddVaginalPlug = -2
    OID_BoredomIntervalSlider = -2
    OID_BoredomText = -2
    OID_ContractRemaining = -2
    OID_CopyToSettings = -2
    OID_CustomCurve = -2
    OID_DFAnimalContTog = -2
    OID_DFChaoConcealedTog = -2
    OID_DFChaoGoTog = -2
    OID_DFChaosDaysSlider = -2
    OID_DFChaosPercentSlider = -2
    OID_DFDealEffectWillTog = -2
    OID_DFDealSCustArmorTog = -2
    OID_DFDealSSignTog = -2
    OID_DFDealsMaxDebtSlider = -2
    OID_DFDealsMaxMultiSlider = -2
    OID_DFDealsMaxPTimeSlider = -2
    OID_DFDealsMaxPriceSlider = -2
    OID_DFDealsMinDebtSlider = -2
    OID_DFDealsMinMultiSlider = -2
    OID_DFDealsMinPTimeSlider = -2
    OID_DFDealsMinPriceSlider = -2
    OID_DFDebtMaxPLSlider = -2
    OID_DFDebtMinPLSlider = -2
    OID_DFDebtperdayMaxSlider = -2
    OID_DFDebtperdayMinSlider = -2
    OID_DFGCredToLeaveSlider = -2
    OID_DFGDecaySlider = -2
    OID_DFGKnockDownTog = -2
    OID_DFGOtherTog = -2
    OID_DFGRedGoldModSlider = -2
    OID_DFGStay0Tog = -2
    OID_DFKConcealSlider = -2
    OID_DFKeyDiffS = -2
    OID_DFLivesChaoMaxSlider = -2
    OID_DFLivesChaoMinSlider = -2
    OID_DFLivesFollowerRapeTog = -2
    OID_DFLocNotiTog = -2
    OID_DFMDTimerSlider = -2
    OID_DFMaxResistDealTog = -2
    OID_DFMaxResistDevicesTog = -2
    OID_DFMaxResistMCMSlider = -2
    OID_DFMaxResistMinSlider = -2
    OID_DFMaxStolenPerSlider = -2
    OID_DFMinStolenPerSlider = -2
    OID_DFPotionQDelayMin = -2
    OID_DFPotionQDelayMax = -2
    OID_DFPotionQESlider = -2
    OID_DFPotionQETog = -2
    OID_DFPotionQSlider = -2
    OID_DFPotionQTog = -2
    OID_DFPunDebtMaxSlider = -2
    OID_DFPunDebtMinSlider = -2
    OID_DFPunDebtSlider = -2
    OID_DFRemovalIncMaxSlider = -2
    OID_DFRemovalIncMinSlider = -2
    OID_DFRemovalMaxSlider = -2
    OID_DFRemovalMinSlider = -2
    OID_DFRemovalModeS = -2
    OID_DFRemovalMultiMaxSlider = -2
    OID_DFRemovalMultiMinSlider = -2
    OID_DFSWeightDSlider = -2
    OID_DFSWeightEDSlider = -2
    OID_DFSWeightESlider = -2
    OID_DFShowRollMsgTog = -2
    OID_DFSoldDeals = -2
    OID_DFSoldTimerMax = -2
    OID_DFSoldTimerMin = -2
    OID_DFSoldTog = -2
    OID_debtReduction = -2
    OID_dealReduction = -2
    OID_DFTheifsBoolTog = -2
    OID_DFWillBoolTog = -2
    OID_DFZAZAutoPause = -2
    OID_DFlowGambleJPotSlider = -2
    OID_DFlowItemsPerRemovedSlider = -2
    OID_DFlowRemovalDebtTimesSlider = -2
    OID_DFlowRemovalIncSlider = -2
    OID_DFlowWarmCompTog = -2
    OID_DailyDebtIncrement = -2
    OID_DealBias = -2
    OID_DebtDifficulty = -2
    OID_DebtPerDayHiLevel = -2
    OID_DebtPerDayLoLevel = -2
    OID_DebtPerDaySlider = -2
    OID_DebtPerFollowerSlider = -2
    OID_DebtText = -2
    OID_DebugBoredom = -2
    OID_DebugDiaTog = -2
    OID_DebugResistance = -2
    OID_DeepDebtDifficulty = -2
    OID_DflowDealBaseDaysSlider = -2
    OID_DflowDealBaseDebtSlider = -2
    OID_DflowDealBasePriceSlider = -2
    OID_DflowDealMultiSlider = -2
    OID_DflowEndlessModeTog = -2
    OID_DflowGoldModeMaxSlider = -2
    OID_DflowGoldModeMinSlider = -2
    OID_DflowGoldModeTog = -2
    OID_DflowRemovalBasePriceSlider = -2
    OID_DiscountLimitSlider = -2
    OID_DiscountText = -2
    OID_DismissalOption = -2
    OID_EFFcount = -2
    OID_EnSlavFailerPerLevelSlider = -2
    OID_EnableTog = -2
    OID_EndScene = -2
    OID_EnslavFailSlider = -2
    OID_EnslavementSlider = -2
    OID_ExpectedDealCountText = -2
    OID_ExpectedDealLimitSlider = -2
    OID_ExploreDifficulty = -2
    OID_ExploreExponent = -2
    OID_ExploreHiPrice = -2
    OID_ExploreLoPrice = -2
    OID_FatigueRateSlider = -2
    OID_FatigueText = -2
    OID_FollowerEventCDSlider = -2
    OID_FreedomSlider = -2
    OID_GetEnslaved = -2
    OID_GoldPerFatigueSlider = -2
    OID_HardCoreMode = -2
    OID_HoursTillBillSlider = -2
    OID_IntrestSlider = -2
    OID_LDCInitTog = -2
    OID_LivesSlider = -2
    OID_LoadTog = -2
    OID_MaxTatsSlider = -2
    OID_MaxWillRegain = -2
    OID_MinWillRegain = -2
    OID_MinimumContractSlider = -2
    OID_Mme = -2
    OID_LicenseEnable = -2
    OID_ForcedLicenses = -2
    OID_LicenseBasePrice = -2
    OID_LicenseMarkup = -2
    OID_ModDealNumOfDeals = -2
    OID_NFFcount = -2
    OID_PermitForceStart = -2
    OID_RegiveTog = -2
    OID_RemoveAnalPlug = -2
    OID_RemoveArmCuffs = -2
    OID_RemoveBelt = -2
    OID_RemoveBlindfold = -2
    OID_RemoveBoots = -2
    OID_RemoveBra = -2
    OID_RemoveCollar = -2
    OID_RemoveCorsetHarness = -2
    OID_RemoveFollower = -2
    OID_RemoveGag = -2
    OID_RemoveGloves = -2
    OID_RemoveHeavyBondage = -2
    OID_RemoveHobbleDress = -2
    OID_RemoveHood = -2
    OID_RemoveLegCuffs = -2
    OID_RemoveMittens = -2
    OID_RemoveNipplePiercing = -2
    OID_RemoveSuit = -2
    OID_RemoveVaginalPiercing = -2
    OID_RemoveVaginalPlug = -2
    OID_RepairFollower = -2
    OID_ResetTog = -2
    OID_ResistText = -2
    OID_ResistanceDealSlider = -2
    OID_ResistanceDeltaSlider = -2
    OID_ResistanceFatigueLimit = -2
    OID_ResistanceLevelDelta = -2
    OID_ResistanceWillSlider = -2
    OID_RestoreControls = -2
    OID_SaveTog = -2
    OID_Scan2Tog = -2
    OID_ScanTog = -2
    OID_SendForAuction = -2
    OID_SendResumeTog = -2
    OID_SexPreferences = -2
    OID_DfcSlaverySlider = -2
    OID_LolaSlider = -2
    OID_SimplePerSlider = -2
    OID_EndlessSoldWeight = -2
    OID_EndlessSlaveWeight = -2
    OID_EndlessLolaWeight = -2
    OID_EndlessAuctionWeight = -2
    OID_SkipToTheEndTog = -2
    OID_SkoomaWhore = -2
    OID_Spanking = -2
    OID_SpankingAnims = -2
    OID_SpankingCode = -2
    OID_SpankingCooldown = -2
    OID_SuspendOutPut = -2
    OID_Test = -2
    OID_Test2 = -2
    OID_ToggleFollower = -2
    OID_WillRegainMode = -2
    OID_WillText = -2
    OID__DebtPerLevelSlider = -2
    
    MDC_OIDs = new Int[1]

EndFunction

Function SetDismissalRules(Int ruleIndex)

    _DFDismissRule.SetValue(ruleIndex As Float)
    ; 0 = no restriction
    ; 1 = location OR will
    ; 2 = location

EndFunction


String Function GetTargetActorName()
    String cursorName = ""
    Actor cursorTarget = Tick.GetCrosshairTarget As Actor
    If cursorTarget
        cursorName = cursorTarget.GetBaseObject().GetName()
    EndIf
    Return cursorName
EndFunction

Bool Function HaveValidToggleActorTarget()
    Actor cursorTarget = Tick.GetCrosshairTarget As Actor
    Actor currentFollower = Follower.GetActorReference()
    Return cursorTarget \
        && cursorTarget != currentFollower \
        && (cursorTarget.GetFactionRank(PotentialFollowerFaction) >= -1 || cursorTarget.GetFactionRank(HirelingFollowerFaction) >= -1)
EndFunction

Bool Function IsToggleActorTargetEnabled()
    Actor cursorTarget = Tick.GetCrosshairTarget As Actor
    Return cursorTarget && !Q.IsIgnore(cursorTarget)
EndFunction

Bool Function IsCurrentTargetActiveDF()
    Actor cursorTarget = Tick.GetCrosshairTarget As Actor
    Actor currentFollower = Follower.GetActorReference()
    Return cursorTarget && cursorTarget == currentFollower
EndFunction

Bool Function HaveValidSlaverTarget()
    Actor cursorTarget = Tick.GetCrosshairTarget As Actor
    Return cursorTarget \
            && !Q.IsIgnore(cursorTarget) \
            && (cursorTarget.GetFactionRank(PotentialFollowerFaction) >= -1 || cursorTarget.GetFactionRank(HirelingFollowerFaction) >= -1)
EndFunction

Function SetTargetAsSlaverForSS()
    Actor cursorTarget = Tick.GetCrosshairTarget As Actor
    If cursorTarget
        Q.ScanActor = cursorTarget
    EndIf
EndFunction



; Returns whether the actor is enabled once completed
Bool Function ToggleActorEnable()
    Actor cursorTarget = Tick.GetCrosshairTarget As Actor
    
    If IsToggleActorTargetEnabled()
        ; Disable as a DF, set ignored
        cursorTarget.RemoveFromFaction(EnabledFollowerFaction) ; This doesn't "unignore" a follower, it just makes them not get picked up in the all unflagged followers scan.
        cursorTarget.RemoveFromFaction(_DFMaster)
        cursorTarget.SetFactionRank(_DFDisable, 0)
        StorageUtil.SetIntValue(cursorTarget, Tool.TagNeverDevious, 1)
        Return False
    Else
        ; Enable as a DF
        cursorTarget.SetFactionRank(EnabledFollowerFaction, 0)
        cursorTarget.RemoveFromFaction(_DFDisable)
        StorageUtil.UnsetIntValue(cursorTarget, Tool.TagNeverDevious)
        Return True
    EndIf
EndFunction

Function IgnoreFollowers()

    Debug.TraceConditional("DF - IgnoreFollowers - Begin", True)
    Int totalProcessed = 0
    
    UnflaggedFollowersScan.Stop()
    UnflaggedFollowersScan.Reset()
    Utility.Wait(1.1)
    
    UnflaggedFollowersScan.Start()
    Utility.Wait(1.1)

    Int processed = -1
    Int numAliases = UnflaggedFollowersScan.GetNumAliases()
    
    While 0 != processed
        Debug.TraceConditional("DF - IgnoreFollowers - IsRunning", True)
        processed = 0
        
        Int ii = 0
        While ii < numAliases
            ReferenceAlias followerAlias = UnflaggedFollowersScan.GetNthAlias(ii) As ReferenceAlias
            If followerAlias
            
                Actor ignore = followerAlias.GetActorRef()
                If ignore
                    ignore.SetFactionRank(_DFDisable, 0)
                    ignore.RemoveFromFaction(_DFMaster)
                    StorageUtil.SetIntValue(ignore, Tool.TagNeverDevious, 1)
                    processed += 1
                    Debug.TraceConditional("DF - IgnoreFollowers - alias " + ii + " contains " + ignore.GetActorBase().GetName(), True)
                Else
                    Debug.TraceConditional("DF - IgnoreFollowers - alias " + ii + " -empty-", True)
                EndIf
                
            EndIf
            
            ii += 1
        EndWhile
        UnflaggedFollowersScan.Stop()
        Utility.Wait(0.1)
        
        If 0 == processed
            Debug.TraceConditional("DF - IgnoreFollowers - is stopping!", True)
        Else
            totalProcessed += processed
            UnflaggedFollowersScan.Reset()
            UnflaggedFollowersScan.Start()
            Debug.TraceConditional("DF - IgnoreFollowers - is scanning again...", True)
            Utility.Wait(1.0)
        EndIf
        
        
    EndWhile
    Debug.TraceConditional("DF - IgnoreFollowers - processed " + totalProcessed + " followers", True)
    
    Debug.Notification("$DF_IGNORE_COMPLETE_1")
    Debug.Notification("$DF_IGNORE_COMPLETE_2")
    Debug.TraceConditional("DF - IgnoreFollowers - End", True)

EndFunction

Function StartTestGame()

    ;Q.SetStage(200)
    ;Utility.Wait(3.0)
    ;_DFlowGames.SetStage(400) ; _DFlowGames quest
    ;Actor[] guards = New Actor[3]
    ;Int found = Tool.GuardScan(guards)
    ;Debug.Notification("Found " + found + " guards")
    ;Tool.Rapetime()
    ;If Tool.Horsetime()
    ;    Debug.Notification("Fucked some horses!")
    ;Else
    ;    Debug.Notification("Nope!")
    ;EndIf
    
    ;If Q.GetStage() >= 10 && Q.GetStage() < 98
    ;    Tool.PauseAll()
    ;    Q.EnslavedDueToDebt()
    ;    Tool.ResumeALL()
    ;Else
    ;    Tool.PunDebt()
    ;EndIf
    
    Bool a = tool.horsetime()
    Utility.wait(2.0)
    Debt.setvalue(0)
    If a
      tool.ReduceResist(5)
    Else
      Noti("NoH") 
    EndIf

EndFunction

Function RunTest()
    Utility.Wait(5.0)
    Debug.Notification("Run test")
    Form testBoss = Game.GetForm(0x220950AF) ; 0x000E1BA9
    If testBoss
        Debug.Notification("Obtained")
        If !(testBoss As ObjectReference).IsNearPlayer()
            Debug.Notification("Moved")
            (testBoss As Actor).MoveTo(PlayerRef, 100.0, 0.0, 0.0, False)
            Utility.Wait(5.0)
        EndIf
        ; Int h = ModEvent.Create("DF-AddFollower")
        ; If h
            ; ModEvent.PushForm(h, self)
            ; ModEvent.PushForm(h, testBoss)
            ; ModEvent.PushInt(h, 2000)
            ; ModEvent.PushBool(h, false)
            ; ModEvent.PushFloat(h, 27.0)
            ; ModEvent.Send(h)
            ; Debug.Notification("Sent...")
        ; EndIf
        Debug.Notification("Spanking")
        Tool.Spank(testBoss As Actor)
    Else
        Debug.Notification("No boss")
    EndIf
EndFunction

Function StartTest2()
    ;Tool.SpankAnimationNames = New String[3]
    ;Tool.SpankAnimationNamesExt = New String[3]
    ;Tool.SpankAnimationNamesExtAlt = New String[3]
    ;AddDealByNewId(11) ; slut deal
    String name = "DF Anubs Rape"
    sslBaseAnimation searchAnim = SexLabUtil.GetAPI().GetAnimationByName(name)
    If searchAnim
        Actor[] actors = New Actor[2]
        actors[0] = PlayerRef
        actors[1] = Follower.GetActorRef()
        Tool.PlaySexAnimation(actors, False, searchAnim)
    EndIf
EndFunction

Function AddTestDeal()
    ;AddPiercingDeal()
    ;AddSlutDeal()

    ; 100 = bear deal
    ; 18 Key(3), 19 Skooma(3), 20 Milk(3), 21 Spank, 22 Sex, 23 Lactacid, 24 Ring, 25 Amulet, 26 Circlet
    ;AddDealByNewId(100 + 24)
    ;AddDealByNewId(100 + 25)
    
    ;AddDealByNewId(200 + 26)
    ;AddDealByNewId(200 + 21)
    
    AddDealByNewId(300 + 21)
    AddDealByNewId(300 + 22)
    AddDealByNewId(300 + 19)
    
    AddDealByNewId(400 + 23)
    AddDealByNewId(400 + 24)
    AddDealByNewId(400 + 18)

    ;AddDealByNewId(500 + 3)
    ;AddDealByNewId(500 + 4)
    ;AddDealByNewId(500 + 20)
    
EndFunction

Function AddTestItem()
    LDC.AddDeviceByKeyword(LDC.Libs.zad_deviouspiercingsvaginal)
EndFunction

Function AddBHODeals()

    AddDealByNewId(1)
    AddDealByNewId(11)
    AddDealByNewId(21)

    AddDealByNewId(2)
    AddDealByNewId(12)
    AddDealByNewId(22)


EndFunction

Function AddPiercingDeal()
    Quest dealQuest = DC.DealP
    Int stage = dealQuest.GetStage() As Int
    If stage < 3
        AddDealByNewId(31 + stage)
    EndIf
EndFunction

Function AddSlutDeal()
    Quest dealQuest = DC.DealH
    Int stage = dealQuest.GetStage() As Int
    If stage < 3
        AddDealByNewId(21 + stage)
    EndIf
EndFunction

Function AddDealByNewId(Int id)

    _DFDealUberController dealControl = (DC As Quest) As _DFDealUberController
    dealControl.AddDealById(id)

EndFunction

Bool Function IsSkoomaWhorePresent()
    Return 0.0 != _DFModSkoomaWhorePresent.GetValue()
EndFunction

Bool Function IsMmePresent()
    Return 0.0 != _DFModMmePresent.GetValue()
EndFunction

Bool Function IsSlsPresent()
    Return 0.0 != _DFModSlsPresent.GetValue()
EndFunction


; FOLDSTART - OIDs
Int OIDTxtPush ; unused
Int OID_AFTcount
Int OID_ActualDealCountText
Int OID_AddAnalPlug
Int OID_AddArmCuffs
Int OID_AddBelt
Int OID_AddBlindfold
Int OID_AddBoots
Int OID_AddBra
Int OID_AddChainsOfDebt
Int OID_AddCollar
Int OID_AddCorsetHarness
Int OID_AddDebtDebug100
Int OID_AddDebtDebugTog
Int OID_AddFollowerDebug
Int OID_AddFullSet
Int OID_AddWhoreArmor
Int OID_AddGag
Int OID_AddGloves
Int OID_AddHeavyBondage
Int OID_AddHobbleDress
Int OID_AddLegCuffs
Int OID_AddMittens
Int OID_AddNipplePiercing
Int OID_AddPetSuit
Int OID_AddPrisonerChains
Int OID_AddSlaveKit
Int OID_AddVaginalPiercing
Int OID_AddVaginalPlug
Int OID_BoredomIntervalSlider
Int OID_BoredomText
Int OID_ContractRemaining
Int OID_CopyToSettings
Int OID_CustomCurve
Int OID_DFAnimalContTog
Int OID_DFChaoConcealedTog
Int OID_DFChaoGoTog
Int OID_DFChaosDaysSlider
Int OID_DFChaosPercentSlider
Int OID_DFDealEffectWillTog ; unused
Int OID_DFDealSCustArmorTog
Int OID_DFDealSSignTog
Int OID_DFDealsMaxDebtSlider
Int OID_DFDealsMaxMultiSlider
Int OID_DFDealsMaxPTimeSlider
Int OID_DFDealsMaxPriceSlider
Int OID_DFDealsMinDebtSlider
Int OID_DFDealsMinMultiSlider
Int OID_DFDealsMinPTimeSlider
Int OID_DFDealsMinPriceSlider
Int OID_DFDebtMaxPLSlider
Int OID_DFDebtMinPLSlider
Int OID_DFDebtperdayMaxSlider
Int OID_DFDebtperdayMinSlider
Int OID_DFGCredToLeaveSlider
Int OID_DFGDecaySlider
Int OID_DFGKnockDownTog
Int OID_DFGOtherTog
Int OID_DFGRedGoldModSlider
Int OID_DFGStay0Tog
Int OID_DFKConcealSlider
Int OID_DFKeyDiffS
Int OID_DFLivesChaoMaxSlider
Int OID_DFLivesChaoMinSlider
Int OID_DFLivesFollowerRapeTog
Int OID_DFLocNotiTog
Int OID_DFMDTimerSlider
Int OID_DFMaxResistDealTog ; unused
Int OID_DFMaxResistDevicesTog
Int OID_DFMaxResistMCMSlider
Int OID_DFMaxResistMinSlider
Int OID_DFMaxStolenPerSlider
Int OID_DFMinStolenPerSlider
Int OID_DFPotionQTog
Int OID_DFPotionQDelayMin
Int OID_DFPotionQDelayMax
Int OID_DFPotionQESlider
Int OID_DFPotionQETog
Int OID_DFPotionQSlider
Int OID_DFPunDebtMaxSlider
Int OID_DFPunDebtMinSlider
Int OID_DFPunDebtSlider
Int OID_DFRemovalIncMaxSlider
Int OID_DFRemovalIncMinSlider
Int OID_DFRemovalMaxSlider
Int OID_DFRemovalMinSlider
Int OID_DFRemovalModeS
Int OID_DFRemovalMultiMaxSlider
Int OID_DFRemovalMultiMinSlider
Int OID_DFSWeightDSlider
Int OID_DFSWeightEDSlider
Int OID_DFSWeightESlider
Int OID_DFShowRollMsgTog
Int OID_DFSoldDeals
Int OID_DFSoldTimerMax
Int OID_DFSoldTimerMin
Int OID_DFSoldTog
Int OID_debtReduction
Int OID_dealReduction
Int OID_DFTheifsBoolTog
Int OID_DFWillBoolTog
Int OID_DFZAZAutoPause
Int OID_DFlowGambleJPotSlider
Int OID_DFlowItemsPerRemovedSlider
Int OID_DFlowRemovalDebtTimesSlider
Int OID_DFlowRemovalIncSlider
Int OID_DFlowWarmCompTog
Int OID_DailyDebtIncrement
Int OID_DealBias
Int OID_DebtDifficulty
Int OID_DebtPerDayHiLevel
Int OID_DebtPerDayLoLevel
Int OID_DebtPerDaySlider
Int OID_DebtPerFollowerSlider
Int OID_DebtText
Int OID_DebugBoredom
Int OID_DebugDiaTog
Int OID_DebugResistance
Int OID_DeepDebtDifficulty
Int OID_DflowDealBaseDaysSlider
Int OID_DflowDealBaseDebtSlider
Int OID_DflowDealBasePriceSlider
Int OID_DflowDealMultiSlider
Int OID_DflowEndlessModeTog
Int OID_DflowGoldModeMaxSlider
Int OID_DflowGoldModeMinSlider
Int OID_DflowGoldModeTog
Int OID_DflowRemovalBasePriceSlider
Int OID_DiscountLimitSlider
Int OID_DiscountText
Int OID_DismissalOption
Int OID_EFFcount
Int OID_EnSlavFailerPerLevelSlider
Int OID_EnableTog
Int OID_EndScene
Int OID_EnslavFailSlider
Int OID_EnslavementSlider
Int OID_ExpectedDealCountText
Int OID_ExpectedDealLimitSlider
Int OID_ExpensiveDeal
Int OID_ExploreDifficulty
Int OID_ExploreExponent
Int OID_ExploreHiPrice
Int OID_ExploreLoPrice
Int OID_FatigueRateSlider
Int OID_FatigueText
Int OID_FollowerEventCDSlider
Int OID_FreedomSlider
Int OID_GetEnslaved
Int OID_GoldPerFatigueSlider
Int OID_HardCoreMode
Int OID_HoursTillBillSlider
Int OID_IntrestSlider
Int OID_LDCInitTog
Int OID_LivesSlider
Int OID_LoadTog
Int OID_MaxTatsSlider
Int OID_MaxWillRegain
Int OID_MinWillRegain
Int OID_MinimumContractSlider
Int OID_Mme
Int OID_LicenseEnable
Int OID_ForcedLicenses
Int OID_LicenseBasePrice
Int OID_LicenseMarkup
Int OID_ModDealNumOfDeals
Int OID_NFFcount
Int OID_FNISCompatibility
Int OID_PermitForceStart
Int OID_RegiveTog
Int OID_RemoveAnalPlug
Int OID_RemoveArmCuffs
Int OID_RemoveBelt
Int OID_RemoveBlindfold
Int OID_RemoveBoots
Int OID_RemoveBra
Int OID_RemoveCollar
Int OID_RemoveCorsetHarness
Int OID_RemoveFollower
Int OID_RemoveGag
Int OID_RemoveGloves
Int OID_RemoveHeavyBondage
Int OID_RemoveHobbleDress
Int OID_RemoveHood
Int OID_RemoveLegCuffs
Int OID_RemoveMittens
Int OID_RemoveNipplePiercing
Int OID_RemoveSuit
Int OID_RemoveVaginalPiercing
Int OID_RemoveVaginalPlug
Int OID_RepairFollower
Int OID_ResetTog
Int OID_ResistText
Int OID_ResistanceDealSlider
Int OID_ResistanceDeltaSlider ; No longer used
Int OID_ResistanceFatigueLimit
Int OID_ResistanceLevelDelta
Int OID_ResistanceWillSlider 
Int OID_RestoreControls
Int OID_SaveTog
Int OID_Scan2Tog
Int OID_ScanTog
Int OID_SendForAuction
Int OID_SendResumeTog
Int OID_SexPreferences
Int OID_DfcSlaverySlider
Int OID_LolaSlider
Int OID_SimplePerSlider
Int OID_SkipToTheEndTog
Int OID_SkoomaWhore
Int OID_Spanking
Int OID_SpankingAnims
Int OID_SpankingCode
Int OID_SpankingCooldown
Int OID_SuspendOutPut
Int OID_Test
Int OID_Test2
Int OID_ToggleFollower
Int OID_WillRegainMode ; Not used at this time
Int OID_WillText
Int OID__DebtPerLevelSlider ; No longer used
Int OID_EndlessSoldWeight
Int OID_EndlessSlaveWeight
Int OID_EndlessLolaWeight
Int OID_EndlessAuctionWeight

Int OID_helpBoredom_1
Int OID_helpChaos_1
Int OID_helpDealConfiguration_1
Int OID_helpDeals_1
Int OID_helpDebt_1
Int OID_helpDevices_1
Int OID_helpDevices_2
Int OID_helpDevices_3
Int OID_helpEnslavement_1
Int OID_helpEnslavement_2
Int OID_helpExclusion_1
Int OID_helpExclusion_2
Int OID_helpFatigue_1
Int OID_helpGambling_1
Int OID_helpGames_1
Int OID_helpGoldControl_1
Int OID_helpGoldControl_2
Int OID_helpIntro_1
Int OID_helpIntro_2
Int OID_helpLives_1
Int OID_helpPause_1
Int OID_helpResistance_1
Int OID_helpSleep_1
Int OID_helpWillpower_1
Int[] MDC_OIDs
; FOLDEND - OIDs