ScriptName Apropos2SystemAlias Extends ReferenceAlias

Import Apropos2Util
Import ApUtil

Apropos2SystemConfig Property Config Auto
Apropos2Framework Property Framework Auto

Apropos2Actors Property ActorsLib Auto
Apropos2Descriptions Property Descriptions Auto
Apropos2WidgetManager Property Widgets Auto
Apropos2DescriptionDb Property Database Auto
Apropos2AnimationPatchups Property Patchups Auto
Apropos2MiscSexEffects Property MiscEffects Auto
Apropos2PeriodicPlayerDescriptions Property PlayerDescriptions Auto

Actor PlayerRef

Event OnPlayerLoadGame()
    Debug.OpenUserLog("Apropos2")
    Config.Debug("OnPlayerLoadGame", source="Apropos2SystemAlias")
    
    LoadLibs()
    ; Config.DebugMode = True
    Config.Debug(Self + " OnPlayerLoadGame - Version " + CurrentVersion + " / " + Apropos2Util.GetVersion(), source="Apropos2SystemAlias")

    ; Check for install
    If CurrentVersion > 0 && Config.CheckSystem()
        Config.Reload()
        ; Stop quests
        UpdateSystem(CurrentVersion, Apropos2Util.GetVersion())
        ; Cleanup taks

        Framework.GameLoaded()
        ActorsLib.GameLoaded()
        MiscEffects.GameLoaded()
        Framework.GameLoaded()
        PlayerDescriptions.GameLoaded()

        SendModEvent("Apropos2GameLoaded")
    ElseIf !IsInstalled && !ForcedOnce && GetState() == "" && Config.CheckSystem()
        Utility.Wait(0.1)
        RegisterForSingleUpdate(30.0)
    ElseIf Version == 0 && GetState() == "Ready" && Config.CheckSystem()
        Utility.Wait(0.1)
        Config.Log("Apropos2 somehow failed to install but things it did, not sure how this happened and it never should, attempting to fix it automatically now... ")
        InstallSystem()
    EndIf
EndEvent

Event OnInit()
    Debug.OpenUserLog("Apropos2")
    Config.Debug("OnInit", "Apropo2SystemAlias")
    GoToState("")
    Version = 0
    LoadLibs(False)
    ForcedOnce = False
EndEvent

Int Version
Int Property CurrentVersion Hidden
    Int Function get()
        Return Version
    EndFunction
EndProperty

Bool ForcedOnce = False
Bool Property IsInstalled Hidden
    Bool Function get()
        Return Version > 0 && GetState() == "Ready"
    EndFunction
EndProperty

Bool Property UpdatePending Hidden
    Bool Function get()
        Return Version > 0 && Version < Apropos2Util.GetVersion()
    EndFunction
EndProperty

Bool Function SetupSystem()
    Version = Apropos2Util.GetVersion()

    Framework.GoToState("Disabled")
    GoToState("Installing")
    
    ; Framework
    LoadLibs(False)
    Framework.Setup()
    Config.Setup()

    Widgets.Setup()
    ActorsLib.Setup()
    Descriptions.Setup()
    Database.Setup()
    Patchups.Setup()
    MiscEffects.Setup()
    PlayerDescriptions.Setup()

    ; Various calls to .Setup() on other libraries, modules, registries.
    
    GoToState("Ready")
    Widgets.Enabled = True
    Framework.GoToState("Enabled")
    Config.Verbose("Apropos2 v" + GetVersionString() + " - Ready!", Source="Apropos2SystemAlias")
    Return True
EndFunction

Event UpdateSystem(Int oldVersion, Int newVersion)
    If oldVersion <= 0 || newVersion <= 0
        Debug.TraceAndBox("Apropos2 ERROR: Unknown call to system update: " + oldVersion + "->" + newVersion)

    ElseIf newVersion < oldVersion
        Debug.TraceAndBox("Apropos2 ERROR: Unsupported version rollback detected (" + oldVersion + "->" + newVersion + ") Proceed at your own risk!")

    ElseIf oldVersion < newVersion
        Config.Verbose("Apropos2 v" + GetVersionString() + " - Updating...", Source="Apropos2SystemAlias")
        Framework.GoToState("Disabled")
        GoToState("Updating")
        Version = newVersion
        
        Config.ExportSettings()

        If oldVersion < Apropos2Util.GetVersion()
            Widgets.Setup()
            ActorsLib.Setup()
            Descriptions.Setup()
            Database.Setup()
            Config.Setup()
            Patchups.Setup()
            MiscEffects.Setup()
            PlayerDescriptions.Setup()
        EndIf
        
        Config.ImportSettings()
        
        GoToState("Ready")
        Widgets.Enabled = True
        Framework.GoToState("Enabled")
        Config.Verbose("Apropos2 Update v" + Apropos2Util.GetVersionString() + " - Ready!")
        SendModEventWithInt("Apropos2Updated", CurrentVersion)
    EndIf
EndEvent

Event InstallSystem()
    Config.Log("Apropos2 v" + GetVersionString() + " - Installing...", Source="Apropos2SystemAlias")
    If SetupSystem()
        SendModEventWithInt("Apropos2Installed", CurrentVersion)
    Else
        Debug.TraceAndBox("Apropos2 v" + Apropos2Util.GetVersionString() + " - INSTALL ERROR, CHECK YOUR PAPYRUS LOGS!")
    EndIf
EndEvent

Function CheckLibLoaded(Form frm, String msg)
    If !frm && Config
        Config.Debug("LoadLibs... " + msg + " did not load!", Source="Apropos2SystemAlias")
    EndIf
EndFunction

Function LoadLibs(Bool forced = False)
    If forced || !Config || !Descriptions || !Widgets || !Database || !Patchups || !MiscEffects 
        Form fx = GetFramework()
        If fx
            Config             = fx As Apropos2SystemConfig
            Descriptions       = fx As Apropos2Descriptions
            Widgets            = fx As Apropos2WidgetManager
            Database           = fx As Apropos2DescriptionDb
            Patchups           = fx As Apropos2AnimationPatchups
            MiscEffects        = fx As Apropos2MiscSexEffects
            PlayerDescriptions = fx As Apropos2PeriodicPlayerDescriptions
        EndIf
    EndIf
    
    If forced || !PlayerRef
        PlayerRef = GetReference() As Actor
    EndIf

    If forced || !ActorsLib
        ActorsLib = GetActorsLib()
        CheckLibLoaded(ActorsLib, "ActorsLib")
    EndIf    
EndFunction

Event OnUpdate()
EndEvent
