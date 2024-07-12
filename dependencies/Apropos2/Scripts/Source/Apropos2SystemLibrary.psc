ScriptName Apropos2SystemLibrary Extends Quest Hidden

Import Apropos2Util
Import ApUtil

Apropos2SystemConfig Property Config Auto 
Apropos2WidgetManager Property Widgets Auto 
Apropos2DescriptionDb Property Database Auto 
Apropos2Descriptions Property Descriptions Auto 
Apropos2AnimationPatchups Property Patchups Auto 
Apropos2MiscSexEffects Property MiscEffects Auto
Apropos2PeriodicPlayerDescriptions Property PlayerDescriptions Auto

SexLabFramework Property SexLab Auto
Apropos2Actors Property ActorsLib Auto
Apropos2Framework Property Framework Auto
slaUtilScr Property SlaUtil Auto 

String Property VAGINAL = "Vaginal" AutoReadOnly
String Property ORAL = "Oral" AutoReadOnly
String Property ANAL = "Anal" AutoReadOnly
String Property BOOBJOB = "Boobjob" AutoReadOnly
String Property HANDJOB = "Handjob" AutoReadOnly
String Property FOOTJOB = "Footjob" AutoReadOnly
String Property FISTING = "Fisting" AutoReadOnly
String Property GANGBANG = "Gangbang" AutoReadOnly
String Property AGGRESSIVE = "Aggressive" AutoReadOnly
String Property ROUGH = "Rough" AutoReadOnly
String Property FORCED = "Forced" AutoReadOnly
String Property FOREPLAY = "Foreplay" AutoReadOnly
String Property LESBIAN = "Lesbian" AutoReadOnly
String Property CUNNILINGUS = "Cunnilingus" AutoReadOnly
String Property BLOWJOB = "Blowjob" AutoReadOnly

String Property FIRSTPERSON = "1st Person" AutoReadOnly
String Property SECONDPERSON = "2nd Person" AutoReadOnly
String Property THIRDPERSON = "3rd Person" AutoReadOnly
String Property MODNAME = "Apropos2" AutoReadOnly

Int Property MALE = 0 AutoReadOnly
Int Property FEMALE = 1 AutoReadOnly

String Property ACTIVE_NAME_TOKEN             = "{ACTIVE}" AutoReadOnly ; token that represents the name of the active participant
String Property PRIMARY_NAME_TOKEN            = "{PRIMARY}" AutoReadOnly ; token that represents the name of the 'primary' participant
String Property WEARTEAR_ANAL_TOKEN           = "{WTANAL}" AutoReadOnly ; description of the current anal wear/tear
String Property WEARTEAR_VAGINAL_TOKEN        = "{WTVAGINAL}" AutoReadOnly
String Property WEARTEAR_ORAL_TOKEN           = "{WTORAL}" AutoReadOnly
String Property PASSIVE_ACTOR_ADJECTIVE_TOKEN = "{PASSIVE_ACTOR_ADJECTIVE}" AutoReadOnly
String Property ACTIVE_ACTOR_ADJECTIVE_TOKEN  = "{ACTIVE_ACTOR_ADJECTIVE}" AutoReadOnly
String Property BOOBS_TOKEN                   = "{BOOBS}" AutoReadOnly ; synonym for boobs
String Property ASS_TOKEN                     = "{ASS}" AutoReadOnly
String Property MOUTH_TOKEN                   = "{MOUTH}" AutoReadOnly
String Property PUSSY_TOKEN                   = "{PUSSY}" AutoReadOnly
String Property COCK_TOKEN                    = "{COCK}" AutoReadOnly
String Property STRAPON_TOKEN                 = "{STRAPON}" AutoReadOnly
String Property MALE_CUM_TOKEN                = "{CUM}" AutoReadOnly
String Property FEMALE_CUM_TOKEN              = "{PUSSY_JUICE}" AutoReadOnly
String Property READINESS_TOKEN               = "{READINESS}" AutoReadOnly
String Property FEMALE_AROUSAL_TOKEN          = "{FAROUSAL}" AutoReadOnly
String Property MALE_AROUSAL_TOKEN            = "{MAROUSAL}" AutoReadOnly

Actor Property PlayerRef Auto

Function CheckLibLoaded(Form frm, String msg)
    If !frm
        Config.Debug("LoadLibs... " + msg + " did not load!", Source="Apropos2SystemLibrary")
    EndIf
EndFunction

Function LoadLibs(Bool forced = False)
    ;Debug("Apropos2SystemLibrary.LoadLibs(forced="+forced+")")
    If forced || !Config || !Widgets || !Framework || !Database || !Descriptions || !ActorsLib || !Patchups
        Form fx  = GetFramework()
        If fx
            Config             = fx as Apropos2SystemConfig
            Framework          = fx as Apropos2Framework
            Database           = fx As Apropos2DescriptionDb
            Descriptions       = fx As Apropos2Descriptions
            Patchups           = fx As Apropos2AnimationPatchups
            MiscEffects        = fx As Apropos2MiscSexEffects
            PlayerDescriptions = fx As Apropos2PeriodicPlayerDescriptions

            CheckLibLoaded(Config, "Config")
            CheckLibLoaded(Framework, "Framework")
            CheckLibLoaded(Database, "Database")
            CheckLibLoaded(Descriptions, "Descriptions")
            CheckLibLoaded(Patchups, "Patchups")
            CheckLibLoaded(PlayerDescriptions, "PlayerDescriptions")
        EndIf
    EndIf

    If forced || !Widgets
        Widgets = GetWidgetManager()
        CheckLibLoaded(Widgets, "Widgets")
    EndIf

    If forced || !ActorsLib
        ActorsLib = GetActorsLib()
        CheckLibLoaded(ActorsLib, "ActorsLib")
    EndIf

    If forced || !SexLab
        SexLab = GetSexLab()
    EndIf

    ; Sync data
    If forced || !PlayerRef
        PlayerRef = Game.GetPlayer()
    EndIf

    If forced || !SlaUtil
        SlaUtil = GetSLA()
    EndIf

    ; Watch for Apropos2Debug event
    RegisterForModEvent("Apropos2Debug", "SetDebugMode")

    ;Debug("Apropos2SystemLibrary.LoadLibs exit")
EndFunction

Function Setup()
    Config.Log("Setup", Source="Apropos2SystemLibrary")
    UnregisterForUpdate()
    GoToState("")
    LoadLibs(True)
EndFunction

Event OnInit()
    LoadLibs(False)
    Config.Log("OnInit", Source="Apropos2SystemLibrary")
EndEvent

Bool Property InDebugMode Auto Hidden

Event SetDebugMode(Bool toMode)
    InDebugMode = toMode
EndEvent