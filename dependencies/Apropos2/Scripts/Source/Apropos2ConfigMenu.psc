ScriptName Apropos2ConfigMenu Extends SKI_ConfigBase

Import Apropos2Util
Import ApUtil

; Framework
Actor Property PlayerRef Auto
SexLabFramework Property SexLab  Auto
Apropos2Framework Property Framework Auto
Apropos2SystemConfig Property Config Auto
Apropos2SystemAlias Property SystemAlias Auto
Apropos2AnimationPatchups Property Patchups Auto
Apropos2DescriptionDb Property Database Auto
Apropos2Actors Property ActorsLib Auto
Apropos2PeriodicPlayerDescriptions Property PlayerDescriptions Auto

; Common Data
Actor TargetRef
Int TargetFlag
String TargetName
String PlayerName

Int _horizontalAnchorOID
Int _horizontalOffsetOID
Int _verticalAnchorOID
Int  _verticalOffsetOID

String Function GetVersionString()
    Return Apropos2Util.GetVersionString()
EndFunction

Event OnVersionUpdate(Int version)
    LoadLibs(False)
    If CurrentVersion > 0 && CurrentVersion < Apropos2Util.GetVersion()
        ResetAllQuests()
        LoadLibs(True)
        SystemAlias.SetupSystem()
    ; ElseIf CurrentVersion == 0 && Config.DebugMode
    ;     LoadLibs(True)
    ;     SystemAlias.SetupSystem()
    EndIf
EndEvent

Event OnGameReload()
    Parent.OnGameReload()
    Debug("OnGameReload: Apropos2 MCM Loaded CurrentVersion: " + CurrentVersion + " / " + Apropos2Util.GetVersion())
EndEvent

; Event OnGameReload()
;     parent.OnGameReload()

;     If ValidateJContainers() != "Valid"
;         Return
;     EndIf   

;     InitPages()    

;     MainQuest.GameLoaded()
;     Widgets.GameLoaded()
; EndEvent

Function LoadLibs(Bool forced = False)
    If forced || !Framework || !Config
        Form fx = GetFramework()
        If fx
            Framework     = fx As Apropos2Framework
            Config        = fx As Apropos2SystemConfig
            SystemAlias   = Framework.GetNthAlias(0) As Apropos2SystemAlias
        EndIf
    EndIf

    If !Framework
        Config.Verbose("LoadLibs: Apropos2Framework not found", source="Apropos2ConfigMenu")
    EndIf
    
    If !Config
        Config.Verbose("LoadLibs: Apropos2SystemConfig not found", source="Apropos2ConfigMenu")
    EndIf

    If !SystemAlias
        Config.Verbose("LoadLibs: Apropos2SystemAlias not found", source="Apropos2ConfigMenu")
    EndIf

    If forced || !PlayerRef
        PlayerRef = Game.GetPlayer()
    EndIf
EndFunction

Event OnPageReset(String page)
    If !SystemAlias.IsInstalled
        UnloadCustomContent()
        InstallMenu()
        Return
        
    ElseIf page == ""
        LoadCustomContent("Apropos/Apropos.dds",125 ,35.5)
        Return
    EndIf
    
    UnloadCustomContent()
    
    If page == "$APR_General"
        General()

    ElseIf page == "$APR_WearAndTear"
        WearAndTear()
        
    ElseIf page == "$APR_WearAndTearActors"
        WearAndTearActors()

    ElseIf page == "$APR_MessagePreferences"
        MessagePreferences()
        
    ElseIf page == "$APR_EventsAndMessages"
        EventsAndMessages()

    ElseIf page == "$APR_MessageWidgetSettings"
        MessageWidgetSettings()      

    ElseIf page == "$APR_AnimationHints"
        AnimationHints()

    ElseIf page == "$APR_MiscEffects"
        MiscEffects()        

    ElseIf page == "$APR_RebuildClean"
        RebuildClean()

    EndIf
    
EndEvent

Event OnConfigOpen()

    Log("OnConfigOpen")    

    LoadLibs()
    
    If !SystemAlias.IsInstalled
        Pages = New String[1]
        Pages[0] = "Install"
    Else
        Pages = New String[9]
        Pages[0] = "$APR_General"
        Pages[1] = "$APR_WearAndTear"
        Pages[2] = "$APR_WearAndTearActors"
        Pages[3] = "$APR_MessagePreferences"
        Pages[4] = "$APR_EventsAndMessages"
        Pages[5] = "$APR_MessageWidgetSettings"
        Pages[6] = "$APR_AnimationHints"
        Pages[7] = "$APR_MiscEffects"
        Pages[8] = "$APR_RebuildClean"
    EndIf
    
    playerName = PlayerRef.GetLeveledActorBase().GetName()

    targetRef = SexLab.Config.TargetRef
    If targetRef && targetRef.Is3DLoaded()
        targetName = targetRef.GetLeveledActorBase().GetName()
    Else
        targetRef = PlayerRef
        targetName = playerName
    EndIf   

    If Voices.Length != 3 || Voices.Find("") != -1
        Voices = New String[3]        
        Voices[0] = "1st Person"
        Voices[1] = "2nd Person"
        Voices[2] = "3rd Person"
    EndIf

    If HorizontalAnchors.Length != 3 || HorizontalAnchors.Find("") != -1
        HorizontalAnchors = New String[3]
        HorizontalAnchors[0] = "$APR_Left"
        HorizontalAnchors[1] = "$APR_Center"
        HorizontalAnchors[2] = "$APR_Right"
    EndIf

    If VerticalAnchors.Length != 3 || VerticalAnchors.Find("") != -1
        VerticalAnchors = New String[3]
        VerticalAnchors[0] = "$APR_Top"
        VerticalAnchors[1] = "$APR_Center"
        VerticalAnchors[2] = "$APR_Bottom"        
    EndIf

    If PeriodicPlayerDescriptionsOptions.Length != 3 || PeriodicPlayerDescriptionsOptions.Find("") != -1
        PeriodicPlayerDescriptionsOptions = New String[3]
        PeriodicPlayerDescriptionsOptions[0] = "Use hotkey"
        PeriodicPlayerDescriptionsOptions[1] = "Timed msg"
        PeriodicPlayerDescriptionsOptions[2] = "Disabled"
    Endif    

    If PlayerRef.GetActorBase().GetSex() == 0
        genderFlag = OPTION_FLAG_DISABLED
        
    ElseIf PlayerRef.GetActorBase().GetSex() == 1
        genderFlag = OPTION_FLAG_NONE
    EndIf    
    
EndEvent

Function InstallMenu()
    SetCursorFillMode(TOP_TO_BOTTOM)

    AddHeaderOption("Apropos2 v<font color='#FF9900'>" + GetVersionString() + "</font>")
    AddHeaderOption("$APR_PrerequisiteCheck")
    SystemCheckOptions()

    SetCursorPosition(1)
    AddHeaderOption("Apropos2 v<font color='#FF9900'>" + GetVersionString() + "</font> by Gooser@LoversLab.com")

    ; Check for critical failure from missing SystemAlias not being found.
    If !Framework || !SystemAlias || !Config
        AddTextOptionST("InstallError", "CRITICAL ERROR: File Integrity", "README")
        SetInfoText("CRITICAL ERROR: File Integrity Framework quest / files overwritten...\nUnable to resolve needed variables. Install unable continue as result.\nUsually caused by incompatible Apropos addons. Disable other Apropos addons (NOT Apropos.esm) one by one and trying again until this message goes away. Alternatively, with TES5Edit after the background loader finishes check for any mods overriding Apropos.esm's Quest records.\nIf using Mod Organizer, check that no mods are overwriting any of Apropos Frameworks files. There should be no red - symbol under flags for your Apropos Framework install in Mod Organizer.")
        Return
    EndIf

    ; Install/Update button
    String aliasState = SystemAlias.GetState()
    Int opt = OPTION_FLAG_NONE
    If aliasState == "Updating" || aliasState == "Installing"
        opt = OPTION_FLAG_DISABLED
    EndIf
    
    AddTextOptionST("InstallSystem","","$APR_InstallUpdate{" + GetVersionString() + "}", opt)
    AddTextOptionST("InstallSystem","","$APR_ClickHere", opt)

    If AliasState == "Updating"
        AddTextOption("$APR_CurrentlyUpdating", "!")
    ElseIf AliasState == "Installing"
        AddTextOption("$APR_CurrentlyInstalling", "!")
    EndIf

EndFunction

Function General()
    SetCursorFillMode(TOP_TO_BOTTOM)
    AddHeaderOption("<font color='#FF9900'>$APR_General</font>")
    AddEmptyOption()
    AddHeaderOption("Apropos2 v<font color='#FFCC66'>" + GetVersionString() + "</font>")
    AddEmptyOption()

    AddToggleOptionST("DebugMessages", "$APR_EnableDebugMessages", Config.DebugMessagesEnabled)
    AddToggleOptionST("TraceMessages", "$APR_EnableDetailedTraceMessages", Config.TraceMessagesEnabled)
    AddToggleOptionST("LogActorStats", "$APR_EnableActorSexLabStats", Config.LogActorStatsEnabled)
    AddToggleOptionST("EnableConsoleOutput", "$APR_EnableConsoleOutput", Config.EnableConsoleOutput)
EndFunction

State DebugMessages
    Event OnSelectST()
        Config.DebugMessagesEnabled = !Config.DebugMessagesEnabled
        SetToggleOptionValueST(Config.DebugMessagesEnabled)
    EndEvent
    Event OnDefaultST()
        Config.DebugMessagesEnabled = True
        SetToggleOptionValueST(Config.DebugMessagesEnabled)
    EndEvent
    Event OnHighlightST()
        SetInfoText("$APR_InfoDebugMessages")
    EndEvent
EndState

State TraceMessages
    Event OnSelectST()
        Config.TraceMessagesEnabled = !Config.TraceMessagesEnabled
        SetToggleOptionValueST(Config.TraceMessagesEnabled)
    EndEvent
    Event OnDefaultST()
        Config.TraceMessagesEnabled = False
        SetToggleOptionValueST(Config.TraceMessagesEnabled)
    EndEvent
    Event OnHighlightST()
        SetInfoText("$APR_InfoTraceMessages")
    EndEvent    
EndState

State LogActorStats
    Event OnSelectST()
        Config.LogActorStatsEnabled = !Config.LogActorStatsEnabled
        SetToggleOptionValueST(Config.LogActorStatsEnabled)
    EndEvent
    Event OnDefaultST()
        Config.LogActorStatsEnabled = False
        SetToggleOptionValueST(Config.LogActorStatsEnabled)
    EndEvent
    Event OnHighlightST()
        SetInfoText("$APR_InfoLogActorStats")
    EndEvent
EndState

State EnableConsoleOutput
    Event OnSelectST()
        Config.EnableConsoleOutput = !Config.EnableConsoleOutput
        SetToggleOptionValueST(Config.EnableConsoleOutput)
    EndEvent
    Event OnDefaultST()
        Config.EnableConsoleOutput = True
        SetToggleOptionValueST(Config.EnableConsoleOutput)
    EndEvent
    Event OnHighlightST()
        SetInfoText("$APR_InfoEnableConsoleOutput")
    EndEvent
EndState

Function WearAndTear()
    SetCursorFillMode(TOP_TO_BOTTOM)
    SetCursorPosition(0)

    AddHeaderOption("<font color='#FF9900'>$APR_WearAndTear</font>")

    AddToggleOptionST("EnableWearAndTear", "$APR_EnableWearAndTear", Config.WearAndTearEnabled)
    AddToggleOptionST("EnableNPCWearAndTear", "$APR_EnableNPCWearAndTear", Config.NPCWearAndTearEnabled)
    AddSliderOptionST("WearTearDegradeFactor", "$APR_WearTearDegradeFactor", Config.WTDegradeFactor, "{1}")
    AddSliderOptionST("MaxWearTearValue", "$APR_MaxWearTearValue", Config.MaxWearTearAmount)
    AddSliderOptionST("FrequencyWearTearDegrade", "$APR_FrequencyWearTearDegrade", Config.FrequencyWearTearDegrade, "{0} hr")
    AddSliderOptionST("ChanceWTDegrade", "$APR_ChanceWTDegrade", Config.ChanceWTDegrade, "{0}%")
    AddToggleOptionST("ConsumablesIncreaseArousal", "$APR_ConsumablesIncreaseArousal", Config.ConsumablesIncreaseArousal)
    AddSliderOptionST("MinConsumableArousalIncr", "Min Consumables Arousal Increase", Config.MinConsumableArousalIncr, "{0}")
    AddSliderOptionST("MaxConsumableArousalIncr", "Max Consumables Arousal Increase", Config.MaxConsumableArousalIncr, "{0}")

    AddHeaderOption("<font color='#FF9900'>$APR_WearAndTearConsequences</font>")
    AddToggleOptionST("EnableWearTearEffects", "$APR_EnableWearTearEffects", Config.WTEffectsEnabled)
    AddToggleOptionST("EnableHardcoreWearTearEffects", "$APR_EnableHardcoreWearTearEffects", Config.HardcoreWTEffectsEnabled)
    AddToggleOptionST("AutoMasturbateEnabled", "Enable Auto-Masturbate", Config.AutoMasturbateEnabled)
    AddSliderOptionST("MinArousalAutoMasturbate", "Min Arousal for  Auto-Masturbate", Config.MinArousalAutoMasturbate)
    AddTextOptionST("TearWTPlayer", "Test W&T on Player", "TEST")

    SetCursorPosition(1)

    AddHeaderOption("<font color='#FF9900'>Tats for W&T 'Abuse' - Slavetats req.</font>")

    Bool slaveTatsPresent = Config.CheckSystemComponent("Slavetats")
    Int svlFlag = IntIfElse(slaveTatsPresent, OPTION_FLAG_NONE, OPTION_FLAG_DISABLED)

    AddTextOption("<font color='#FFCC66'>Slavetats Mod status</font>", StringIfElse(slaveTatsPresent, "Found Slavetats", "Did not find Slavetats"))
    AddToggleOptionST("EnableSkinTextures", "$APR_EnableSkinTextures", Config.EnableSkinTextures, slvflag)
    AddToggleOptionST("EnableAfterEffects", "$APR_EnableAfterEffects", Config.EnableAfterEffects, slvflag)
    AddToggleOptionST("EnableCutScratches", "$APR_EnableCutScratches", Config.EnableCutScratches, slvflag)
    AddToggleOptionST("EnableDaedricScars", "$APR_EnableDaedricScars", Config.EnableDaedricScars, slvflag)
    AddToggleOptionST("EnableTearsAndSobs", "$APR_EnableTearsAndSobs", Config.EnableTearsAndSobs, slvflag)
    AddToggleOptionST("EnableMascaraSmears", "$APR_EnableMascaraSmears", Config.EnableMascaraSmears, slvflag)
    AddColorOptionST("TatsColorTint", "$APR_TatsColorTint", Config.TatsColorTint, slvflag)
    AddColorOptionST("MascaraTatsColorTint", "$APR_MascaraTatsColorTint", Config.MascaraTatsColorTint, slvflag)
EndFunction

State TearWTPlayer
    Event OnSelectST()

        SendModEventWithString("AproposDisplaySimplePlayerMessage", "Test1")
        SendModEventWithString("AproposDisplaySimpleMessage", "Test2")
        SendModEventWithString(eventName="AproposTest", arg="TestApropos from Config Menu")

        Int handle = ModEvent.Create("AproposInitWT")
        If handle
           ModEvent.PushForm(handle, PlayerRef) ;  push actor to receive W&T
           ModEvent.PushInt(handle, 9) ; level, valid values = 0 through 9
           ModEvent.PushInt(handle, 8)
           ModEvent.PushInt(handle, 7)
           ModEvent.PushBool(handle, True)
           ModEvent.PushBool(handle, True)
           ModEvent.PushBool(handle, False)
           Debug("Calling AproposInitWT")
           ShowMessage("Setting test W&T levels on Player...")
           ModEvent.Send(handle)
        EndIf
        ShowMessage("Player has been given high W&T levels.")
    EndEvent
    Event OnHighlightST()
        SetInfoText("Will set the Player to have high levels of W&T.")
    EndEvent   
EndState

State TatsColorTint
    Event OnColorOpenST()
        SetColorDialogStartColor(Config.TatsColorTint)
        SetColorDialogDefaultColor(0x990033)
    EndEvent
    Event OnColorAcceptST(int new_color)
        Log("New tats tint color accepted : " + new_color)
        Config.TatsColorTint = new_color
        SetColorOptionValueST(new_color)
    EndEvent
    Event OnDefaultST()
        Config.TatsColorTint = 0x990033
        SetColorOptionValueST(0x990033)
    EndEvent
EndState

State MascaraTatsColorTint
    Event OnColorOpenST()
        SetColorDialogStartColor(Config.MascaraTatsColorTint)
        SetColorDialogDefaultColor(0x000000)
    EndEvent
    Event OnColorAcceptST(int new_color)
        Log("New mascara tint color accepted : " + new_color)
        Config.MascaraTatsColorTint = new_color
        SetColorOptionValueST(new_color)
    EndEvent
    Event OnDefaultST()
        Config.MascaraTatsColorTint = 0x000000
        SetColorOptionValueST(0x000000)
    EndEvent
EndState

State EnableWearAndTear
    Event OnSelectST()
        Config.WearAndTearEnabled = !Config.WearAndTearEnabled
        SetToggleOptionValueST(Config.WearAndTearEnabled)
    EndEvent
    Event OnDefaultST()
        Config.WearAndTearEnabled = True
        SetToggleOptionValueST(Config.WearAndTearEnabled)
    EndEvent
EndState

State EnableNPCWearAndTear
    Event OnSelectST()
        Config.NPCWearAndTearEnabled = !Config.NPCWearAndTearEnabled
        SetToggleOptionValueST(Config.NPCWearAndTearEnabled)
    EndEvent
    Event OnDefaultST()
        Config.NPCWearAndTearEnabled = False
        SetToggleOptionValueST(Config.NPCWearAndTearEnabled)
    EndEvent
EndState

State WearTearDegradeFactor
    Event OnSliderOpenST()
        SetSliderDialogStartValue(Config.WTDegradeFactor)
        SetSliderDialogDefaultValue(1.2)
        SetSliderDialogRange(1.0, 3.0)
        SetSliderDialogInterval(0.1)        
    EndEvent
    Event OnSliderAcceptST(Float value)
        Config.WTDegradeFactor = value
        SetSliderOptionValueST(Config.WTDegradeFactor, "{1}")
    EndEvent
    Event OnDefaultST()
        Config.WTDegradeFactor = 1.2
        SetSliderOptionValueST(Config.WTDegradeFactor, "{1}")
    EndEvent
    Event OnHighlightST()
        SetInfoText("$APR_InfoWearTearDegradeFactor")
    EndEvent
EndState

State MaxWearTearValue
    Event OnSliderOpenST()
        SetSliderDialogStartValue(Config.MaxWearTearAmount)
        SetSliderDialogDefaultValue(2000)
        SetSliderDialogRange(500, 10000)
        SetSliderDialogInterval(200)      
    EndEvent
    Event OnSliderAcceptST(Float value)
        Config.MaxWearTearAmount = value As Int
        SetSliderOptionValueST(Config.MaxWearTearAmount)
    EndEvent
    Event OnDefaultST()
        Config.MaxWearTearAmount = 2000
        SetSliderOptionValueST(Config.MaxWearTearAmount)
    EndEvent
    Event OnHighlightST()
        SetInfoText("$APR_InfoMaxWearTearValue")
    EndEvent    
EndState

State FrequencyWearTearDegrade
    Event OnSliderOpenST()
        SetSliderDialogStartValue(Config.FrequencyWearTearDegrade)
        SetSliderDialogDefaultValue(12)
        SetSliderDialogRange(1, 24)
        SetSliderDialogInterval(1)     
    EndEvent
    Event OnSliderAcceptST(Float value)
        Config.FrequencyWearTearDegrade = value As Int
        SetSliderOptionValueST(Config.FrequencyWearTearDegrade, "{0} hr")
    EndEvent
    Event OnDefaultST()
        Config.FrequencyWearTearDegrade = 12
        SetSliderOptionValueST(Config.FrequencyWearTearDegrade, "{0} hr")
    EndEvent
    Event OnHighlightST()
        SetInfoText("$APR_InfoFrequencyWearTearDegrade")
    EndEvent     
EndState

State ChanceWTDegrade
    Event OnSliderOpenST()
        SetSliderDialogStartValue(Config.ChanceWTDegrade)
        SetSliderDialogDefaultValue(5)
        SetSliderDialogRange(0, 100)
        SetSliderDialogInterval(5)     
    EndEvent
    Event OnSliderAcceptST(Float value)
        Config.ChanceWTDegrade = value As Int
        SetSliderOptionValueST(Config.ChanceWTDegrade, "{0}%")
    EndEvent
    Event OnDefaultST()
        Config.ChanceWTDegrade = 5
        SetSliderOptionValueST(Config.ChanceWTDegrade, "{0}%")
    EndEvent
    Event OnHighlightST()
        SetInfoText("$APR_InfoChanceWTDegrade")
    EndEvent     
EndState

State ConsumablesIncreaseArousal
    Event OnSelectST()
        Config.ConsumablesIncreaseArousal = !Config.ConsumablesIncreaseArousal
        SetToggleOptionValueST(Config.ConsumablesIncreaseArousal)
    EndEvent
    Event OnDefaultST()
        Config.ConsumablesIncreaseArousal = True
        SetToggleOptionValueST(Config.ConsumablesIncreaseArousal)
    EndEvent
EndState

State MinConsumableArousalIncr
    Event OnSliderOpenST()
        SetSliderDialogStartValue(Config.MinConsumableArousalIncr)
        SetSliderDialogDefaultValue(2)
        SetSliderDialogRange(1, 100)
        SetSliderDialogInterval(1)        
    EndEvent
    Event OnSliderAcceptST(Float value)
        Config.MinConsumableArousalIncr = value As Int
        SetSliderOptionValueST(Config.MinConsumableArousalIncr, "{0}")
    EndEvent
    Event OnDefaultST()
        Config.MinConsumableArousalIncr = 2
        SetSliderOptionValueST(Config.MinConsumableArousalIncr, "{0}")
    EndEvent
EndState

State MaxConsumableArousalIncr
    Event OnSliderOpenST()
        SetSliderDialogStartValue(Config.MaxConsumableArousalIncr)
        SetSliderDialogDefaultValue(15)
        SetSliderDialogRange(1, 100)
        SetSliderDialogInterval(1)        
    EndEvent
    Event OnSliderAcceptST(Float value)
        Config.MaxConsumableArousalIncr = value As Int
        SetSliderOptionValueST(Config.MaxConsumableArousalIncr, "{0}")
    EndEvent
    Event OnDefaultST()
        Config.MaxConsumableArousalIncr = 15
        SetSliderOptionValueST(Config.MaxConsumableArousalIncr, "{0}")
    EndEvent
EndState

State EnableWearTearEffects
    Event OnSelectST()
        Config.WTEffectsEnabled = !Config.WTEffectsEnabled
        SetToggleOptionValueST(Config.WTEffectsEnabled)
    EndEvent
    Event OnDefaultST()
        Config.WTEffectsEnabled = True
        SetToggleOptionValueST(Config.WTEffectsEnabled)
    EndEvent
EndState

State EnableHardcoreWearTearEffects
    Event OnSelectST()
        Config.HardcoreWTEffectsEnabled = !Config.HardcoreWTEffectsEnabled
        SetToggleOptionValueST(Config.HardcoreWTEffectsEnabled)
    EndEvent
    Event OnDefaultST()
        Config.HardcoreWTEffectsEnabled = False
        SetToggleOptionValueST(Config.HardcoreWTEffectsEnabled)
    EndEvent
EndState

State AutoMasturbateEnabled
    Event OnSelectST()
        Config.AutoMasturbateEnabled = !Config.AutoMasturbateEnabled
        SetToggleOptionValueST(Config.AutoMasturbateEnabled)
    EndEvent
    Event OnDefaultST()
        Config.AutoMasturbateEnabled = True
        SetToggleOptionValueST(Config.AutoMasturbateEnabled)
    EndEvent
EndState

State MinArousalAutoMasturbate
    Event OnSliderOpenST()
        SetSliderDialogStartValue(Config.MinArousalAutoMasturbate)
        SetSliderDialogDefaultValue(80)
        SetSliderDialogRange(0, 100)
        SetSliderDialogInterval(5)     
    EndEvent
    Event OnSliderAcceptST(Float value)
        Config.MinArousalAutoMasturbate = value As Int
        SetSliderOptionValueST(Config.MinArousalAutoMasturbate, "{0}")
    EndEvent
    Event OnDefaultST()
        Config.MinArousalAutoMasturbate = 80
        SetSliderOptionValueST(Config.MinArousalAutoMasturbate, "{0}")
    EndEvent
    Event OnHighlightST()
        SetInfoText("Minimum arousal to auto-masturbate when W&T has reduced.")
    EndEvent     
EndState

State EnableSkinTextures
    Event OnSelectST()
        Config.EnableSkinTextures = !Config.EnableSkinTextures
        SetToggleOptionValueST(Config.EnableSkinTextures)
    EndEvent
    Event OnDefaultST()
        Config.EnableSkinTextures = False
        SetToggleOptionValueST(Config.EnableSkinTextures)
    EndEvent
    Event OnHighlightST()
        SetInfoText("$APR_InfoEnableSkinTextures")
    EndEvent      
EndState

State EnableAfterEffects
    Event OnSelectST()
        Config.EnableAfterEffects = !Config.EnableAfterEffects
        SetToggleOptionValueST(Config.EnableAfterEffects)
    EndEvent
    Event OnDefaultST()
        Config.EnableAfterEffects = True
        SetToggleOptionValueST(Config.EnableAfterEffects)
    EndEvent
    Event OnHighlightST()
        SetInfoText("$APR_InfoEnableAfterEffects")
    EndEvent       
EndState

State EnableCutScratches
    Event OnSelectST()
        Config.EnableCutScratches = !Config.EnableCutScratches
        SetToggleOptionValueST(Config.EnableCutScratches)
    EndEvent
    Event OnDefaultST()
        Config.EnableCutScratches = True
        SetToggleOptionValueST(Config.EnableCutScratches)
    EndEvent
    Event OnHighlightST()
        SetInfoText("$APR_InfoEnableCutScratches")
    EndEvent    
EndState

State EnableDaedricScars
    Event OnSelectST()
        Config.EnableDaedricScars = !Config.EnableDaedricScars
        SetToggleOptionValueST(Config.EnableDaedricScars)
    EndEvent
    Event OnDefaultST()
        Config.EnableDaedricScars = True
        SetToggleOptionValueST(Config.EnableDaedricScars)
    EndEvent
    Event OnHighlightST()
        SetInfoText("$APR_InfoEnableDaedricScars")
    EndEvent      
EndState

State EnableTearsAndSobs
    Event OnSelectST()
        Config.EnableTearsAndSobs = !Config.EnableTearsAndSobs
        SetToggleOptionValueST(Config.EnableTearsAndSobs)
    EndEvent
    Event OnDefaultST()
        Config.EnableTearsAndSobs = True
        SetToggleOptionValueST(Config.EnableTearsAndSobs)
    EndEvent
    Event OnHighlightST()
        SetInfoText("$APR_InfoEnableTearsAndSobs")
    EndEvent      
EndState

State EnableMascaraSmears
    Event OnSelectST()
        Config.EnableMascaraSmears = !Config.EnableMascaraSmears
        SetToggleOptionValueST(Config.EnableMascaraSmears)
    EndEvent
    Event OnDefaultST()
        Config.EnableMascaraSmears = False
        SetToggleOptionValueST(Config.EnableMascaraSmears)
    EndEvent
    Event OnHighlightST()
        SetInfoText("$APR_InfoEnableMascaraSmears")
    EndEvent      
EndState

Function WearAndTearActors()
    SetCursorFillMode(TOP_TO_BOTTOM)
    SetCursorPosition(0)
    
    AddHeaderOption("<font color='#FF9900'>$APR_CurrentPlayerWTValues</font>")
    Apropos2ActorAlias playerAlias = ActorsLib.GetAproposActor(PlayerRef)
    If !playerAlias
        AddTextOption("$APR_PlayerNotTracked", "", OPTION_FLAG_DISABLED)
    Else
        AddMenuOptionST("PlayerVaginalState", "$APR_VaginalState", Database.GetMCMWearAndTearDescriptor(playerAlias.VaginalWearTearState), genderFlag)
        AddMenuOptionST("PlayerAnalState", "$APR_AnalState", Database.GetMCMWearAndTearDescriptor(playerAlias.AnalWearTearState))
        AddMenuOptionST("PlayerOralState", "$APR_OralState", Database.GetMCMWearAndTearDescriptor(playerAlias.OralWearTearState))
        If Config.EnableSkinTextures
            AddHeaderOption("Wear and Tear Abuse Statistics")
            AddTextOption("General Avg Abuse: ", Database.GetMCMWearAndTearDescriptor(playerAlias.AverageAbuseState))
            AddTextOption("Creature Avg Abuse: ", Database.GetMCMWearAndTearDescriptor(playerAlias.AverageCreatureAbuseState))
            AddTextOption("Daedric Avg Abuse: ", Database.GetMCMWearAndTearDescriptor(playerAlias.AverageDaedricAbuseState))
        EndIf
    EndIf   
    SetCursorPosition(1)
    AddHeaderOption("<font color='#FF9900'>$APR_CurrentNPCWTValues</font>")

    If !Config.NPCWearAndTearEnabled
        AddTextOption("Wear and Tear is currently disabled for NPCs", "", OPTION_FLAG_DISABLED)
    Else
        String[] alist = ActorsLib.GetTrackedActorList()

        Bool anyTrackedNpcs = False

        Int i = 0 
        While i < alist.Length
            If alist[i] != ""
                AddTextOption(alist[i], "")
                anyTrackedNpcs = True
            EndIf
            i += 1
        EndWhile
        
        If anyTrackedNpcs
            AddTextOptionST("ClearNPCTrackings", "$APR_ClearNPCTrackings", "$APR_Clear")
        Else
            AddTextOption("$APR_NoNPCToClear", "", OPTION_FLAG_DISABLED)
        EndIf
    EndIf
EndFunction

State ClearNPCTrackings
    Event OnSelectST()
        If ShowMessage("$APR_WarnClearNPCTrackings")
            SetOptionFlagsST(OPTION_FLAG_DISABLED)
            SetTextOptionValueST("$APR_Clearing")          
            ActorsLib.ClearTrackedNPCActors()
            ShowMessage("$APR_RunClearNPCTrackings", False)
            SetTextOptionValueST("$APR_Clear")
            SetOptionFlagsST(OPTION_FLAG_NONE)
        EndIf        
    EndEvent
EndState

State PlayerVaginalState
    Event OnMenuOpenST()
        Apropos2ActorAlias playerAlias = ActorsLib.GetAproposActor(PlayerRef)
        If playerAlias
            Int index = playerAlias.VaginalWearTearState
            SetMenuDialogStartIndex(index)
            SetMenuDialogDefaultIndex(index)
            SetMenuDialogOptions(Database.GetAllMCMWearAndTearDescriptors())
        EndIf        
    EndEvent    
    Event OnMenuAcceptST(Int index)
        Apropos2ActorAlias playerAlias = ActorsLib.GetAproposActor(PlayerRef)
        String[] wearAndTearDescriptors = Database.GetAllMCMWearAndTearDescriptors()        
        If playerAlias
            playerAlias.OverrideVaginalWearTearState(index, updateAbuse=True, updateCreatureAbuse=True, updateDaedricAbuse=True)

            If index == 0
                SetIntValue(PlayerRef, "hadVaginalSex", 0)
            EndIf
            SetMenuOptionValueST(wearAndTearDescriptors[index])
            ForcePageReset()
        EndIf       
    EndEvent    
    Event OnHighlightST()
        SetInfoText("$APR_InfoPlayerVaginalState")
    EndEvent
    Event OnSelectST()
        Apropos2ActorAlias playerAlias = ActorsLib.GetAproposActor(PlayerRef)
        If playerAlias
            Int index = playerAlias.VaginalWearTearState
            SetMenuDialogStartIndex(index)
            SetMenuDialogDefaultIndex(index)
            SetMenuDialogOptions(Database.GetAllMCMWearAndTearDescriptors())
        EndIf        
    EndEvent
EndState

State PlayerAnalState
    Event OnMenuOpenST()
        Apropos2ActorAlias playerAlias = ActorsLib.GetAproposActor(PlayerRef)
        If playerAlias
            Int index = playerAlias.AnalWearTearState
            SetMenuDialogStartIndex(index)
            SetMenuDialogDefaultIndex(index)
            SetMenuDialogOptions(Database.GetAllMCMWearAndTearDescriptors())
        EndIf        
    EndEvent    
    Event OnMenuAcceptST(Int index)
        Apropos2ActorAlias playerAlias = ActorsLib.GetAproposActor(PlayerRef)
        String[] wearAndTearDescriptors = Database.GetAllMCMWearAndTearDescriptors()        
        If playerAlias
            playerAlias.OverrideAnalWearTearState(index, updateAbuse=True, updateCreatureAbuse=True, updateDaedricAbuse=True)

            If index == 0
                SetIntValue(PlayerRef, "hadAnalSex", 0)
            EndIf
            SetMenuOptionValueST(wearAndTearDescriptors[index])
            ForcePageReset()
        EndIf       
    EndEvent    
    Event OnHighlightST()
        SetInfoText("$APR_InfoPlayerAnalState")
    EndEvent
    Event OnSelectST()
        Apropos2ActorAlias playerAlias = ActorsLib.GetAproposActor(PlayerRef)
        If playerAlias
            Int index = playerAlias.AnalWearTearState
            SetMenuDialogStartIndex(index)
            SetMenuDialogDefaultIndex(index)
            SetMenuDialogOptions(Database.GetAllMCMWearAndTearDescriptors())
        EndIf        
    EndEvent
EndState

State PlayerOralState
    Event OnMenuOpenST()
        Apropos2ActorAlias playerAlias = ActorsLib.GetAproposActor(PlayerRef)
        If playerAlias
            Int index = playerAlias.OralWearTearState
            SetMenuDialogStartIndex(index)
            SetMenuDialogDefaultIndex(index)
            SetMenuDialogOptions(Database.GetAllMCMWearAndTearDescriptors())
        EndIf        
    EndEvent    
    Event OnMenuAcceptST(Int index)
        Apropos2ActorAlias playerAlias = ActorsLib.GetAproposActor(PlayerRef)
        String[] wearAndTearDescriptors = Database.GetAllMCMWearAndTearDescriptors()        
        If playerAlias
            playerAlias.OverrideOralWearTearState(index, updateAbuse=True, updateCreatureAbuse=True, updateDaedricAbuse=True)

            If index == 0
                SetIntValue(PlayerRef, "hadOralSex", 0)
            EndIf
            SetMenuOptionValueST(wearAndTearDescriptors[index])
            ForcePageReset()
        EndIf       
    EndEvent    
    Event OnHighlightST()
        SetInfoText("$APR_InfoPlayerOralState")
    EndEvent
    Event OnSelectST()
        Apropos2ActorAlias playerAlias = ActorsLib.GetAproposActor(PlayerRef)
        If playerAlias
            Int index = playerAlias.OralWearTearState
            SetMenuDialogStartIndex(index)
            SetMenuDialogDefaultIndex(index)
            SetMenuDialogOptions(Database.GetAllMCMWearAndTearDescriptors())
        EndIf        
    EndEvent
EndState

Function MessagePreferences()
    SetCursorFillMode(TOP_TO_BOTTOM)
    SetCursorPosition(0)

    AddHeaderOption("<font color='#FF9900'>Narrative Mode (Grammatical Person)</font>")
    AddMenuOptionST("NarrativeMode", "$APR_Person", Config.NarrativeMode)
    AddEmptyOption()
    AddTextOptionST("RefreshDatabase", "<font color='#FFCC66'>$APR_RefreshDatabase</font>", "$APR_ClickHere")
    AddTextOptionST("RunPatchups","SexLab Animation Patchups", "$APR_RunPatchups")
    SetCursorPosition(1)
    DefineMCMParagraph("Click Refresh anytime you have modified an Apropos2 control file. Control files include:\n\nSynonyms.txt\nUniqueAnimations.txt\nAnimationHints.txt\nand WearAndTear_....txt files.")
EndFunction

State NarrativeMode
    Event OnMenuOpenST()
        SetMenuDialogStartIndex(Voices.Find(Config.NarrativeMode))
        SetMenuDialogDefaultIndex(1)
        SetMenuDialogOptions(Voices)
    EndEvent
    Event OnMenuAcceptST(Int index)
        Config.NarrativeMode = Voices[index]
        SetMenuOptionValueST(Voices[index])
    EndEvent
    Event OnDefaultST()
        Config.NarrativeMode = "2nd Person"
        SetMenuOptionValueST(Config.NarrativeMode)        
    EndEvent
    Event OnHighlightST()
        SetInfoText("$APR_InfoNarrativeMode")
    EndEvent
EndState

State RefreshDatabase
    Event OnSelectST()
        Database.Setup()
        ShowMessage("Database Refreshed.")
        SendModEvent("AproposDatabaseRefreshed")
    EndEvent
    Event OnHighlightST()
        SetInfoText("$APR_InfoRefreshDatabase")
    EndEvent        
EndState

State RunPatchups
    Event OnSelectST()
        If ShowMessage("$APR_WarnAnimationPatchups")
            Patchups.ApplyPatchups()
            ShowMessage("$APR_RunAnimationPatchups", False)
        EndIf
    EndEvent
    Event OnHighlightST()
        SetInfoText("$APR_InfoAnimationPatchups")
    EndEvent    
EndState

Function EventsAndMessages()
    SetCursorFillMode(TOP_TO_BOTTOM)
    SetCursorPosition(0)

    AddHeaderOption("<font color='#FF9900'>$APR_EventsAndMessages</font>")

    AddToggleOptionST("EnableAnimationStartMessages", "Enable Animation Start Messages", Config.ShowAnimationStartMessages)
    AddToggleOptionST("EnableAnimationChangeMessages", "Enable Animation Change Messages", Config.ShowAnimationChangeMessages)
    AddToggleOptionST("EnableAnimationAllStageMessages", "Enable Stage Progression Messages", Config.ShowAllStageMessages)
    AddToggleOptionST("ShowSexDescriptions", "$APR_ShowDescriptions", Config.ShowSexDescriptions)
    AddToggleOptionST("ShowVirginityLostMessages", "$APR_ShowVirginityLostMessages", Config.ShowVirginityLostMessages)
    AddToggleOptionST("ShowWTChangedMessages", "$APR_ShowWTChangedMessages", Config.ShowWTChangedMessages)
    AddMenuOptionST("PeriodicPlayerDescriptionMode", "Periodic PC Messages Mode", Config.PeriodicPlayerDescriptionsOption)
    AddKeyMapOptionST("PlayerDescriptionsHotKey", "Key to Generate Player Messages", PlayerDescriptions.PlayerDescriptionsHotKey, OPTION_FLAG_WITH_UNMAP)
    AddSliderOptionST("MinArousalForHugeLoad", "Min Arousal for huge load", Config.MinArousalForHugeLoad, "{0}")
    AddSliderOptionST("MinArousalForLargeLoad", "Min Arousal for Large load", Config.MinArousalForLargeLoad, "{0}")
    SetCursorPosition(1)
    DefineMCMParagraph("To disable Huge or Large load messages, set MinArousalForHugeLoad / MinArousalForLargeLoad to 0.")
EndFunction

State MinArousalForLargeLoad
    Event OnSliderOpenST()
        SetSliderDialogStartValue(Config.MinArousalForLargeLoad)
        SetSliderDialogRange(0, 100)
        SetSliderDialogInterval(5)
        SetSliderDialogDefaultValue(30)
    EndEvent
    Event OnSliderAcceptST(Float value)
        Config.MinArousalForLargeLoad = value As Int
        SetSliderOptionValueST(Config.MinArousalForLargeLoad, "{0}")
    EndEvent
    Event OnDefaultST()
        Config.MinArousalForLargeLoad = 30
        SetSliderOptionValueST(Config.MinArousalForLargeLoad, "{0}")
    EndEvent
    Event OnHighlightST()
        SetInfoText("Minimum aggressor arousal to generate a LARGELOAD message.")
    EndEvent  
EndState

State MinArousalForHugeLoad
    Event OnSliderOpenST()
        SetSliderDialogStartValue(Config.MinArousalForHugeLoad)
        SetSliderDialogRange(0, 100)
        SetSliderDialogInterval(5)
        SetSliderDialogDefaultValue(50)
    EndEvent
    Event OnSliderAcceptST(Float value)
        Config.MinArousalForHugeLoad = value As Int
        SetSliderOptionValueST(Config.MinArousalForHugeLoad, "{0}")
    EndEvent
    Event OnDefaultST()
        Config.MinArousalForHugeLoad = 30
        SetSliderOptionValueST(Config.MinArousalForHugeLoad, "{0}")
    EndEvent
    Event OnHighlightST()
        SetInfoText("Minimum aggressor arousal to generate a HUGELOAD message.")
    EndEvent  
EndState

State EnableAnimationStartMessages
    Event OnSelectST()
        Config.ShowAnimationStartMessages = !Config.ShowAnimationStartMessages
        SetToggleOptionValueST(Config.ShowAnimationStartMessages)
    EndEvent
    Event OnDefaultST()
        Config.ShowAnimationStartMessages = False
        SetToggleOptionValueST(Config.ShowAnimationStartMessages)
    EndEvent
EndState

State EnableAnimationChangeMessages
    Event OnSelectST()
        Config.ShowAnimationChangeMessages = !Config.ShowAnimationChangeMessages
        SetToggleOptionValueST(Config.ShowAnimationChangeMessages)
    EndEvent
    Event OnDefaultST()
        Config.ShowAnimationChangeMessages = True
        SetToggleOptionValueST(Config.ShowAnimationChangeMessages)
    EndEvent
EndState

State EnableAnimationAllStageMessages
    Event OnSelectST()
        Config.ShowAllStageMessages = !Config.ShowAllStageMessages
        SetToggleOptionValueST(Config.ShowAllStageMessages)
    EndEvent
    Event OnDefaultST()
        Config.ShowAllStageMessages = True
        SetToggleOptionValueST(Config.ShowAllStageMessages)
    EndEvent
EndState

State ShowSexDescriptions
    Event OnSelectST()
        Config.ShowSexDescriptions = !Config.ShowSexDescriptions
        SetToggleOptionValueST(Config.ShowSexDescriptions)
    EndEvent
    Event OnDefaultST()
        Config.ShowSexDescriptions = True
        SetToggleOptionValueST(Config.ShowSexDescriptions)
    EndEvent
    Event OnHighlightST()
        SetInfoText("$APR_InfoShowDescriptions")
    EndEvent      
EndState

State ShowVirginityLostMessages
    Event OnSelectST()
        Config.ShowVirginityLostMessages = !Config.ShowVirginityLostMessages
        SetToggleOptionValueST(Config.ShowVirginityLostMessages)
    EndEvent
    Event OnDefaultST()
        Config.ShowVirginityLostMessages = True
        SetToggleOptionValueST(Config.ShowVirginityLostMessages)
    EndEvent
    Event OnHighlightST()
        SetInfoText("$APR_InfoShowVirginityLostMessages")
    EndEvent        
EndState

State ShowWTChangedMessages
    Event OnSelectST()
        Config.ShowWTChangedMessages = !Config.ShowWTChangedMessages
        SetToggleOptionValueST(Config.ShowWTChangedMessages)
    EndEvent
    Event OnDefaultST()
        Config.ShowWTChangedMessages = True
        SetToggleOptionValueST(Config.ShowWTChangedMessages)
    EndEvent
    Event OnHighlightST()
        SetInfoText("$APR_InfoShowWTChangedMessages")
    EndEvent     
EndState

State PeriodicPlayerDescriptionMode
    Event OnMenuOpenST()
        SetMenuDialogStartIndex(PeriodicPlayerDescriptionsOptions.Find(Config.PeriodicPlayerDescriptionsOption))
        SetMenuDialogDefaultIndex(1)
        SetMenuDialogOptions(PeriodicPlayerDescriptionsOptions)
    EndEvent
    Event OnMenuAcceptST(Int index)
        Config.PeriodicPlayerDescriptionsOption = PeriodicPlayerDescriptionsOptions[index]
        SetMenuOptionValueST(PeriodicPlayerDescriptionsOptions[index])
    EndEvent
    Event OnDefaultST()
        Config.PeriodicPlayerDescriptionsOption = "Timed msg"
        SetMenuOptionValueST(Config.PeriodicPlayerDescriptionsOption)        
    EndEvent
    Event OnHighlightST()
        SetInfoText("Periodic Player Descriptions Mode")
    EndEvent
EndState

State PlayerDescriptionsHotKey
    Event OnKeyMapChangeST(Int keyCode, String conflictControl, String conflictName)
        Bool accepted = True
        If conflictControl != ""
            String msg
            If conflictName != ""
                msg = "This key is already mapped to:\n\n" + conflictName + "." + conflictControl + "\n\nAre you sure you want to continue?"
            Else
                msg = "This key is already mapped to:\n\n" + conflictControl + "\n\nAre you sure you want to continue?"
            EndIf
            accepted = ShowMessage(msg, True)
        EndIf
        If accepted
            PlayerDescriptions.PlayerDescriptionsHotKey = keyCode
            SetKeymapOptionValueST(PlayerDescriptions.PlayerDescriptionsHotKey)
        EndIf        
    EndEvent
    Event OnHighlightST()
        SetInfoText("Map a Hotkey to be used to generate additional Player descriptions during animations. Not used if mode is set to Timed msg.")
    EndEvent  
EndState

Function MessageWidgetSettings()
    SetCursorFillMode(TOP_TO_BOTTOM)
    SetCursorPosition(0)

    AddHeaderOption("<font color='#FF9900'>$APR_WidgetPosition</font>")

    _horizontalAnchorOID = AddMenuOption("$APR_HorizontalAnchor", Config.WidgetHorizontalAnchor)
    _horizontalOffsetOID = AddSliderOption("$APR_HorizontalOffset", Config.WidgetHorizontalOffset, "{0} px")
    _verticalAnchorOID = AddMenuOption("$APR_VerticalAnchor", Config.WidgetVerticalAnchor)
    _verticalOffsetOID = AddSliderOption("$APR_VerticalOffset", Config.WidgetVerticalOffset, "{0} px")

    AddHeaderOption("<font color='#FF9900'>$APR_WidgetAppearance</font>")
    AddSliderOptionST("FontSize", "$APR_FontSize", Config.WidgetFontSize, "{0} pt")
    AddSliderOptionST("PlayerFontSize", "$APR_PlayerFontSize", Config.WidgetPlayerFontSize, "{0} pt")
    AddSliderOptionST("WidgetSpacing", "$APR_WidgetSpacing", Config.WidgetSpacing, "{0} px")
    AddSliderOptionST("SecondsToDisplay", "$APR_SecondsToDisplay", Config.WidgetSecondsToDisplay, "{1} s")
    AddSliderOptionST("WidgetWidth", "Widget width", Config.WidgetWidth, "{0} px")
    SetCursorPosition(1)

    AddToggleOptionST("WidgetTestMode", "$APR_WidgetTestMode", Config.WidgetTestMode)
    AddKeyMapOptionST("WidgetTestHotKey", "$APR_WidgetTestHotKey", Framework.WidgetTestHotkey, OPTION_FLAG_WITH_UNMAP)
EndFunction

State WidgetWidth
    Event OnSliderOpenST()
        SetSliderDialogStartValue(Config.WidgetWidth)
        SetSliderDialogRange(250, 400)
        SetSliderDialogDefaultValue(300)
        SetSliderDialogInterval(10)
    EndEvent
    Event OnSliderAcceptST(Float value)
        Config.WidgetWidth = value As Int
        SetSliderOptionValueST(Config.WidgetWidth, "{0} px")
    EndEvent
    Event OnDefaultST()
        Config.WidgetWidth = 300
        SetSliderOptionValueST(Config.WidgetWidth, "{0} px")
    EndEvent
EndState

Event OnOptionHighlight(Int option)
    If option == _horizontalAnchorOID
        SetInfoText("$APR_InfoHorizontalAnchor")
    ElseIf option == _horizontalOffsetOID
        SetInfoText("$APR_InfoHorizontalOffset")
    ElseIf option == _verticalAnchorOID
        SetInfoText("$APR_InfoVerticalAnchor")
    ElseIf option == _verticalOffsetOID
        SetInfoText("$APR_InfoVerticalOffset")
    EndIf
EndEvent

Event OnOptionDefault(Int option)
    If option == _horizontalAnchorOID
        Config.WidgetHorizontalAnchor = Config.DefaultWidgetHorizontalAnchor
        Config.WidgetHorizontalOffset = Config.DefaultWidgetHorizontalOffset
        SetMenuOptionValue(_horizontalAnchorOID, Config.WidgetHorizontalAnchor, True)
        SetSliderOptionValue(_horizontalOffsetOID, Config.WidgetHorizontalOffset, "{0} px")
    ElseIf option == _verticalAnchorOID
        Config.WidgetVerticalAnchor = Config.DefaultWidgetVerticalAnchor
        Config.WidgetVerticalOffset = Config.DefaultWidgetVerticalOffset
        SetMenuOptionValue(_verticalAnchorOID, Config.WidgetVerticalAnchor, True)
        SetSliderOptionValue(_verticalOffsetOID, Config.WidgetVerticalOffset, "{0} px")
    ElseIf option == _horizontalOffsetOID
        If Config.WidgetHorizontalAnchor == "$APR_Left" || Config.WidgetHorizontalAnchor == "Left"
            Config.WidgetHorizontalOffset = Config.DefaultWidgetHorizontalOffset
        ElseIf Config.WidgetHorizontalAnchor == "$APR_Center" || Config.WidgetHorizontalAnchor == "Center"
            Config.WidgetHorizontalOffset = 0
        ElseIf Config.WidgetHorizontalAnchor == "$APR_Right" || Config.WidgetHorizontalAnchor == "Right"
            Config.WidgetHorizontalOffset = -Config.DefaultWidgetHorizontalOffset
        EndIf
        SetSliderOptionValue(_horizontalOffsetOID, Config.WidgetHorizontalOffset, "{0} px")
    ElseIf option == _verticalOffsetOID
        If Config.WidgetVerticalAnchor == "$APR_Top" || Config.WidgetVerticalAnchor == "Top"
            Config.WidgetVerticalOffset = Config.DefaultWidgetVerticalOffset
        ElseIf Config.WidgetVerticalAnchor == "$APR_Center" || Config.WidgetVerticalAnchor == "Center"
            Config.WidgetVerticalOffset = 0
        ElseIf Config.WidgetVerticalAnchor == "$APR_Bottom" || Config.WidgetVerticalAnchor == "Bottom"
            Config.WidgetVerticalOffset = -Config.DefaultWidgetVerticalOffset
        EndIf
        SetSliderOptionValue(_verticalOffsetOID, Config.WidgetVerticalOffset, "{0} px")        
    EndIf
EndEvent

Event OnOptionMenuOpen(Int option)
    If option == _horizontalAnchorOID
        SetMenuDialogStartIndex(HorizontalAnchors.Find(Config.WidgetHorizontalAnchor))
        SetMenuDialogDefaultIndex(0)
        SetMenuDialogOptions(HorizontalAnchors)
    ElseIf option == _verticalAnchorOID
        SetMenuDialogStartIndex(VerticalAnchors.Find(Config.WidgetVerticalAnchor))
        SetMenuDialogDefaultIndex(0)
        SetMenuDialogOptions(VerticalAnchors)
    EndIf
EndEvent

Event OnOptionSliderOpen(Int option)
    If option == _horizontalOffsetOID
        SetSliderDialogStartValue(Config.WidgetHorizontalOffset)
        If Config.WidgetHorizontalAnchor == "$APR_Left" || Config.WidgetHorizontalAnchor == "Left"
            SetSliderDialogRange(0, 500)
            SetSliderDialogDefaultValue(Config.DefaultWidgetHorizontalOffset)
        ElseIf Config.WidgetHorizontalAnchor == "$APR_Center" || Config.WidgetHorizontalAnchor == "Center"
            SetSliderDialogRange(-250, 250)
            SetSliderDialogDefaultValue(0)
        ElseIf Config.WidgetHorizontalAnchor == "$APR_Right" || Config.WidgetHorizontalAnchor == "Right"
            SetSliderDialogRange(-500, 0)
            SetSliderDialogDefaultValue(-Config.DefaultWidgetHorizontalOffset)
        EndIf
        SetSliderDialogInterval(1)
    ElseIf option == _verticalOffsetOID
        SetSliderDialogStartValue(Config.WidgetVerticalOffset)
        If Config.WidgetVerticalAnchor == "$APR_Top" || Config.WidgetVerticalAnchor == "Top"
            SetSliderDialogRange(0, 250)
            SetSliderDialogDefaultValue(Config.DefaultWidgetVerticalOffset)
        ElseIf Config.WidgetVerticalAnchor == "$APR_Center" || Config.WidgetVerticalAnchor == "Center"
            SetSliderDialogRange(-125, 125)
            SetSliderDialogDefaultValue(0)
        ElseIf Config.WidgetVerticalAnchor == "$APR_Bottom" || Config.WidgetVerticalAnchor == "Bottom"
            SetSliderDialogRange(-250, 0)
            SetSliderDialogDefaultValue(-Config.DefaultWidgetVerticalOffset)
        EndIf
        SetSliderDialogInterval(1)   
    EndIf     
EndEvent

Event OnOptionSliderAccept(Int option, Float value)
    If option == _horizontalOffsetOID
        Config.WidgetHorizontalOffset = value As Int
        SetSliderOptionValue(_horizontalOffsetOID, Config.WidgetHorizontalOffset, "{0} px")
    ElseIf option == _verticalOffsetOID
        Config.WidgetVerticalOffset = value As Int
        SetSliderOptionValue(_verticalOffsetOID, Config.WidgetVerticalOffset, "{0} px")    
    EndIf
EndEvent

Event OnOptionMenuAccept(Int option, Int index)
    If option == _horizontalAnchorOID
        Config.WidgetHorizontalAnchor = HorizontalAnchors[index]
        Config.WidgetHorizontalOffset = -Config.DefaultWidgetHorizontalOffset * (index - 1)
        SetMenuOptionValue(_horizontalAnchorOID, Config.WidgetHorizontalAnchor, True)
        SetSliderOptionValue(_horizontalOffsetOID, Config.WidgetHorizontalOffset, "{0} px")
    ElseIf option == _verticalAnchorOID
        Config.WidgetVerticalAnchor = VerticalAnchors[index]
        Config.WidgetVerticalOffset = -Config.DefaultWidgetVerticalOffset * (index - 1)
        SetMenuOptionValue(_verticalAnchorOID, Config.WidgetVerticalAnchor, True)
        SetSliderOptionValue(_verticalOffsetOID, Config.WidgetVerticalOffset, "{0} px")
    EndIf
EndEvent

State FontSize
    Event OnSliderOpenST()
        SetSliderDialogStartValue(Config.WidgetFontSize)
        SetSliderDialogRange(12, 20)
        SetSliderDialogInterval(1)
        SetSliderDialogDefaultValue(Config.DefaultWidgetFontSize)
    EndEvent
    Event OnSliderAcceptST(Float value)
        Config.WidgetFontSize = value as Int
        SetSliderOptionValueST(Config.WidgetFontSize, "{0} pt")
    EndEvent
    Event OnDefaultST()
        Config.WidgetFontSize = Config.DefaultWidgetFontSize
        SetSliderOptionValueST(Config.WidgetFontSize, "{0} pt")
    EndEvent
    Event OnHighlightST()
        SetInfoText("$APR_InfoFontSize")
    EndEvent      
EndState

State PlayerFontSize
    Event OnSliderOpenST()
        SetSliderDialogStartValue(Config.WidgetPlayerFontSize)
        SetSliderDialogRange(12, 20)
        SetSliderDialogInterval(1)
        SetSliderDialogDefaultValue(Config.DefaultWidgetPlayerFontSize)
    EndEvent
    Event OnSliderAcceptST(Float value)
        Config.WidgetPlayerFontSize = value as Int
        SetSliderOptionValueST(Config.WidgetPlayerFontSize, "{0} pt")
    EndEvent
    Event OnDefaultST()
        Config.WidgetPlayerFontSize = Config.DefaultWidgetPlayerFontSize
        SetSliderOptionValueST(Config.WidgetPlayerFontSize, "{0} pt")
    EndEvent
    Event OnHighlightST()
        SetInfoText("$APR_InfoPlayerFontSize")
    EndEvent      
EndState

State WidgetSpacing
    Event OnSliderOpenST()
        SetSliderDialogStartValue(Config.WidgetSpacing)
        SetSliderDialogRange(-10, 10)
        SetSliderDialogInterval(1)
        SetSliderDialogDefaultValue(Config.DefaultWidgetSpacing)  
    EndEvent
    Event OnSliderAcceptST(Float value)
        Config.WidgetSpacing = value as Int
        SetSliderOptionValueST(Config.WidgetSpacing, "{0} px")
    EndEvent
    Event OnDefaultST()
        Config.WidgetSpacing = Config.DefaultWidgetSpacing
        SetSliderOptionValueST(Config.WidgetSpacing, "{0} px")
    EndEvent
    Event OnHighlightST()
        SetInfoText("$APR_InfoWidgetSpacing")
    EndEvent      
EndState

State SecondsToDisplay
    Event OnSliderOpenST()
        SetSliderDialogStartValue(Config.WidgetSecondsToDisplay)
        SetSliderDialogRange(0.0, 10.0)
        SetSliderDialogInterval(0.5)
        SetSliderDialogDefaultValue(Config.DefaultWidgetSecondsToDisplay)    
    EndEvent
    Event OnSliderAcceptST(Float value)
        Config.WidgetSecondsToDisplay = value
        SetSliderOptionValueST(Config.WidgetSecondsToDisplay, "{1} s")
    EndEvent
    Event OnDefaultST()
        Config.WidgetSecondsToDisplay = Config.DefaultWidgetSecondsToDisplay
        SetSliderOptionValueST(Config.WidgetSecondsToDisplay, "{1} s")
    EndEvent
    Event OnHighlightST()
        SetInfoText("$APR_InfoSecondsToDisplay")
    EndEvent  
EndState

State WidgetTestMode
    Event OnSelectST()
        Config.WidgetTestMode = !Config.WidgetTestMode
        SetToggleOptionValueST(Config.WidgetTestMode)
    EndEvent
    Event OnHighlightST()
        SetInfoText("$APR_InfoWidgetTestMode")
    EndEvent    
EndState

State WidgetTestHotKey
    Event OnKeyMapChangeST(Int keyCode, String conflictControl, String conflictName)
        Bool accepted = True
        If conflictControl != ""
            String msg
            If conflictName != ""
                msg = "This key is already mapped to:\n\n" + conflictName + "." + conflictControl + "\n\nAre you sure you want to continue?"
            Else
                msg = "This key is already mapped to:\n\n" + conflictControl + "\n\nAre you sure you want to continue?"
            EndIf
            accepted = ShowMessage(msg, True)
        EndIf
        If accepted
            Framework.WidgetTestHotkey = keyCode
            SetKeymapOptionValueST(Framework.WidgetTestHotkey)
        EndIf        
    EndEvent
EndState

Function AnimationHints()
    SetCursorFillMode(TOP_TO_BOTTOM)
    SetCursorPosition(0)

    AddHeaderOption("<font color='#FF9900'>Under Construction</font>")
EndFunction

; Function MessageThemes()
;     AddHeaderOption("Message Themes")
;     Int mapId = JDB.solveObj(QueryKey("themes-raw"))
;     String[] allKeys = StringArrayFromJMapKeys(mapId)
;     Int i = 0
;     While i < allKeys.Length
;         Int val = JDB.solveInt(QueryKey("themes-raw", allKeys[i], "weight"))
;         AddTextOption(allKeys[i], (val As String))
;         i += 1
;     EndWhile
; EndFunction

Function RebuildClean()
    SetCursorFillMode(TOP_TO_BOTTOM)
    SetCursorPosition(0)    

    AddHeaderOption("Apropos2 v<font color='#FF9900'>" + GetVersionString() + "</font> by Gooser@LoversLab.com")
    if Framework.Enabled
        AddTextOptionST("DisableSystem","$APR_EnabledSystem", "$APR_DoDisable")
    else
        AddTextOptionST("EnableSystem","$APR_DisabledSystem", "$APR_DoEnable")
    endIf
    AddTextOptionST("CleanSystem","$APR_CleanSystem", "$APR_ClickHere")
    AddTextOptionST("CleanJContainers", "$APR_CleanJContainers", "$APR_ClickHere")

    AddHeaderOption("$APR_Maintenance")
    AddTextOptionST("RestoreDefaultSettings","$APR_RestoreDefaultSettings", "$APR_ClickHere")
    ;AddTextOptionST()

    SetCursorPosition(1)
    AddToggleOptionST("DebugMode","$APR_DebugMode", Config.DebugMode)

    AddTextOptionST("ExportSettings","$APR_ExportSettings", "$APR_ClickHere")
    AddTextOptionST("ImportSettings","$APR_ImportSettings", "$APR_ClickHere")

    AddHeaderOption("System Requirements")
    SystemCheckOptions()    

EndFunction

State EnableSystem
    Event OnSelectST()
        If ShowMessage("$APR_WarnEnable")
            Framework.GoToState("Enabled")
        EndIf
        ForcePageReset()
    EndEvent
EndState

State DisableSystem
    Event OnSelectST()
        If ShowMessage("$APR_WarnDisable")
            Framework.GoToState("Disabled")
        EndIf
        ForcePageReset()
    EndEvent
EndState

State CleanSystem
    Event OnSelectST()
        If ShowMessage("$APR_WarnCleanSystem")
            ShowMessage("$APR_RunCleanSystem", false)
            Utility.Wait(0.1)

            ; Setup & clean system
            ResetAllQuests()
            SystemAlias.SetupSystem()

            SendModEvent("Apropos2Reset")
            Config.CleanSystemFinish.Show()
        EndIf
    EndEvent
EndState

State CleanJContainers
    Event OnSelectST()
        If ShowMessage("$APR_WarnCleanJContainers")
            ShowMessage("$APR_RunCleanJContainers", false)
            JValue.releaseObjectsWithTag("Apropos2")
            Config.CleanJContainersFinish.Show()
        EndIf
    EndEvent
EndState

State RestoreDefaultSettings
    Event OnSelectST()
        If ShowMessage("$APR_WarnRestoreDefaults")
            SetOptionFlagsST(OPTION_FLAG_DISABLED)
            SetTextOptionValueST("$APR_Resetting")          
            Config.SetDefaults()
            ShowMessage("$APR_RunRestoreDefaults", false)
            SetTextOptionValueST("$APR_ClickHere")
            SetOptionFlagsST(OPTION_FLAG_NONE)
        EndIf
    EndEvent
EndState

State DebugMode
    Event OnSelectST()
        Config.DebugMode = !Config.DebugMode
        SetToggleOptionValueST(Config.DebugMode)
    EndEvent
    Event OnHighlightST()
        SetInfoText("$APR_InfoDebugMode")
    EndEvent
EndState

State ExportSettings
    Event OnSelectST()
        If ShowMessage("$APR_WarnExportSettings")
            If Config.ExportSettings()
                ShowMessage("$APR_RunExportSettings", false)
            EndIf
        EndIf
    EndEvent
    Event OnHighlightST()
        SetInfoText("$APR_InfoExportSettings")
    EndEvent
EndState

State ImportSettings
    Event OnSelectST()
        If ShowMessage("$APR_WarnImportSettings")
            If Config.ImportSettings()
                ShowMessage("$APR_RunImportSettings", false)
            EndIf
        EndIf
    EndEvent
    Event OnHighlightST()
        SetInfoText("$APR_InfoImportSettings")
    EndEvent
EndState

Function SystemCheckOptions()
    AddTextOptionST("CheckSKSE", "Skyrim Script Extender (1.7.3+)", StringIfElse(Config.CheckSystemComponent("SKSE"), "ok", "X"), OPTION_FLAG_DISABLED)
    AddTextOptionST("JContainers", "JContainers.dll SKSE Plugin  (3.2.5+)", StringIfElse(Config.CheckSystemComponent("JContainers"), "ok", "X"), OPTION_FLAG_DISABLED)
    AddTextOptionST("SexLabAroused", "SexLabAroused.esm  (2.7)", StringIfElse(Config.CheckSystemComponent("SexLabAroused"), "ok", "X"), OPTION_FLAG_DISABLED)
    AddTextOptionST("Slavetats", "Slavetats  (1.1.1)", StringIfElse(Config.CheckSystemComponent("Slavetats"), "ok", "X"), OPTION_FLAG_DISABLED)
EndFunction

State InstallSystem
    Event OnSelectST()
        SetOptionFlagsST(OPTION_FLAG_DISABLED)
        SetTextOptionValueST("Working")

        SystemAlias.InstallSystem()

        SetTextOptionValueST("$APR_ClickHere")
        SetOptionFlagsST(OPTION_FLAG_NONE)
        ForcePageReset()
    EndEvent
EndState

State InstallError
    Event OnHighlightST()
        SetInfoText("CRITICAL ERROR: File Integrity Framework quest / files overwritten...\nUnable to resolve needed variables. Install unable continue as result.\nUsually caused by incompatible Apropos2 addons. Disable other Apropos2 addons (NOT Apropos2.esp) one by one and trying again until this message goes away.\nIf using Mod Organizer, check that no mods are overwriting any of Apropos2 Frameworks files. There should be no red - symbol under flags for your Apropos2 Framework install in Mod Organizer.")
    EndEvent
EndState

Function MiscEffects()
    SetCursorFillMode(TOP_TO_BOTTOM)
    SetCursorPosition(0)

    AddHeaderOption("<font color='#FF9900'>$APR_MiscEffects</font>")
    AddSliderOptionST("RapeAnimationSwitchChance", "$APR_RapeAnimationSwitchChance", Config.RapeAnimationSwitchChance, "{0}%")
    AddSliderOptionST("GoBackAggressorFactor", "Go Back Aggressor Factor", Config.GoBackAggressorFactor, "{0}%")
    AddSliderOptionST("MaxGoBacksPerAnimation", "Max Go Backs per anim.", Config.MaxGoBacksPerAnimation, "{0}")

    SetCursorPosition(1)
    DefineMCMParagraph("To disable rapist animation switch, set RapeAnimationSwitchChance to 0.\n\nTo disable Stage Go Back, set GoBack Aggressor Factor to 0.")
EndFunction

State MaxGoBacksPerAnimation
    Event OnSliderOpenST()
        SetSliderDialogStartValue(Config.MaxGoBacksPerAnimation)
        SetSliderDialogRange(1, 10)
        SetSliderDialogInterval(1)
        SetSliderDialogDefaultValue(2)
    EndEvent
    Event OnSliderAcceptST(Float value)
        Config.MaxGoBacksPerAnimation = value As Int
        SetSliderOptionValueST(Config.MaxGoBacksPerAnimation, "{0}")
    EndEvent
    Event OnDefaultST()
        Config.MaxGoBacksPerAnimation = 30
        SetSliderOptionValueST(Config.MaxGoBacksPerAnimation, "{0}")
    EndEvent
    Event OnHighlightST()
        SetInfoText("Maximum number of times an aggressor can backup the current animation by one stage.")
    EndEvent  
EndState

State RapeAnimationSwitchChance
    Event OnSliderOpenST()
        SetSliderDialogStartValue(Config.RapeAnimationSwitchChance)
        SetSliderDialogRange(0, 100)
        SetSliderDialogInterval(5)
        SetSliderDialogDefaultValue(30)    
    EndEvent
    Event OnSliderAcceptST(Float value)
        Config.RapeAnimationSwitchChance = value As Int
        SetSliderOptionValueST(Config.RapeAnimationSwitchChance, "{0}%")
    EndEvent
    Event OnDefaultST()
        Config.RapeAnimationSwitchChance = 30
        SetSliderOptionValueST(Config.RapeAnimationSwitchChance, "{0}%")
    EndEvent
    Event OnHighlightST()
        SetInfoText("$APR_InfoRapeAnimationSwitchChance")
    EndEvent  
EndState

State GoBackAggressorFactor
    Event OnSliderOpenST()
        SetSliderDialogStartValue(Config.GoBackAggressorFactor)
        SetSliderDialogRange(0, 100)
        SetSliderDialogInterval(5)
        SetSliderDialogDefaultValue(30)    
    EndEvent
    Event OnSliderAcceptST(Float value)
        Config.GoBackAggressorFactor = value As Int
        SetSliderOptionValueST(Config.GoBackAggressorFactor, "{0}%")
    EndEvent
    Event OnDefaultST()
        Config.GoBackAggressorFactor = 30
        SetSliderOptionValueST(Config.GoBackAggressorFactor, "{0}%")
    EndEvent
    Event OnHighlightST()
        SetInfoText("Factor applied to an aggressor's arousal when determining whether to move the current animation back one stage.")
    EndEvent  
EndState

Int slvflag
Int genderFlag

String[] Voices
String[] HorizontalAnchors
String[] VerticalAnchors
String[] PeriodicPlayerDescriptionsOptions

Event OnConfigClose()
    Log("OnConfigClose")
    SendModEvent("Apropos2ConfigClose")
EndEvent

Function ResetAllQuests()
    Bool SaveDebug = Config.DebugMode
    ; Reset relevant quests
    ; ResetQuest(Game.GetFormFromFile(0x00D62, "SexLab.esm") as Quest) ; SexLabFramework Quest
    ; ResetQuest(Game.GetFormFromFile(0x639DF, "SexLab.esm") as Quest) ; animationsslots
    ; ResetQuest(Game.GetFormFromFile(0x664FB, "SexLab.esm") as Quest) ; creationanimationslots, voiceslots, expressionslots
    ; ResetQuest(Game.GetFormFromFile(0x78818, "SexLab.esm") as Quest) ; obj factory
    Config.DebugMode = SaveDebug
EndFunction

Function ResetQuest(Quest a_quest)
    If a_quest
        While a_quest.IsStarting()
            Utility.WaitMenuMode(0.1)
        EndWhile
        a_quest.Stop()
        While a_quest.IsStopping()
            Utility.WaitMenuMode(0.1)
        EndWhile
        If !a_quest.Start()
            a_quest.Start()
            Config.Log("Failed to start quest!", "ResetQuest(" + a_quest + ")")
        EndIf
    Else
        Config.Log("Invalid quest!", "ResetQuest(" + a_quest + ")")
    EndIf
EndFunction

Function Log(String msg)
    Config.Log(msg, Source="Apropos2ConfigMenu")
EndFunction

Function Debug(String msg)
    Config.Debug(msg, Source="Apropos2ConfigMenu")
EndFunction

Function DefineMCMParagraph(string some_text, int flags = 0x1) ;disabled type text by default
    ;display a paragraph of text, parsing for long lines and newlines
    int maxLength = 47
    int i = 0
    int foundLocation  ;used for location of found character
    While StringUtil.GetLength(some_text) > maxLength
        foundLocation = StringUtil.Find(some_text, "\n")
        if (foundLocation < maxLength) && (foundLocation != -1)  ;if there's a newline character shorter than max line length
            AddTextOption(StringUtil.SubString(some_text, 0, foundLocation), "", flags)
            some_text = StringUtil.SubString(some_text, foundLocation + 1)    ;shorten the text string as we go
        Else
            foundLocation = maxLength
            While (StringUtil.GetNthChar(some_text, foundLocation) != " ") || (foundLocation < 0)    ;find the furthest space character starting from max line length and working backwards
                foundLocation -= 1
            EndWhile
            if foundLocation < 0   ;just in case there's no space at all, break the line at max line length
                foundLocation = maxLength
            EndIf
            AddTextOption(StringUtil.SubString(some_text, 0, foundLocation), "", flags)
            some_text = StringUtil.SubString(some_text, foundLocation + 1)    ;shorten the text string as we go
        EndIf
    EndWhile
    AddTextOption(some_text, "", flags) ;send the last line
EndFunction
