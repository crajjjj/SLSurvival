ScriptName Apropos2Framework Extends Apropos2SystemLibrary

Import ApUtil
Import Apropos2Util

;#   Apropos2Disabled - Sent when Apropos is Disabled                                                                                         # 
;#   Apropos2Enabled - Sent when Apropos is Enabled                                                                                           # 
;#   Apropos2ConfigClose - Sent when the MCM of Apropos is closed                                                                             # 
;#   Apropos2Reset - This ModEvent is sent when Apropos executes a Setup or a System Cleanup                                                  # 
;#   Apropos2GameLoaded - Sent every time the player load a game                                                                              # 
;#   Apropos2DebugMode - Sent when Apropos is set to Debug mode                                                                               # 
;#   Apropos2DatabaseRefreshed - Sent when Apropos has Refreshed database                                                                     #

Int Function GetVersion()
    Return Apropos2Util.GetVersion()
EndFunction

String Function GetVersionString()
    Return Apropos2Util.GetVersionString()
EndFunction

Bool Property Enabled Hidden
    Bool Function get()
        Return GetState() != "Disabled"
    EndFunction
EndProperty

Function Setup()
    Debug("Setup")
    GameLoaded()
EndFunction

Function GameLoaded()
    Debug("GameLoaded")

    UnregisterForEvents()

    If !Config.CheckSystemComponent("JContainers")
        Return
    EndIf

    RegisterForEvents()

    SendModEventWithString(eventName="AproposTest", arg="Test2")

    If Config.DebugMessagesEnabled
        Debug("GameLoaded - Ready")
    EndIf   
EndFunction

Function UnregisterForEvents()
    Debug("UnregisterForEvents")
    UnregisterForModEvent("HookOrgasmStart")
    UnregisterForModEvent("SexLabOrgasmSeparate")
    UnregisterForModEvent("HookAnimationStart")
    UnregisterForModEvent("HookAnimationChange")
    UnregisterForModEvent("HookStageStart")
    UnregisterForModEvent("AproposCustomFemaleMessage")
    UnregisterForModEvent("AproposInitWT")
    UnregisterForModEvent("AproposDisplaySimplePlayerMessage")
    UnregisterForModEvent("AproposDisplaySimpleMessage")
EndFunction

Function RegisterForEvents()
    Debug("RegisterForEvents")

    RegisterForModEvent("HookOrgasmStart", "OrgasmStart")
    RegisterForModEvent("HookOrgasmEnd", "OrgasmEnd")
    RegisterForModEvent("HookAnimationStart", "AnimationStart")
    RegisterForModEvent("HookAnimationChange", "AnimationChange")
    RegisterForModEvent("HookStageStart", "StageStart")
    RegisterForModEvent("AproposCustomFemaleMessage", "AproposCustomFemaleMessage")
    RegisterForModEvent("AproposInitWT", "AproposInitWT")
    RegisterForModEvent("AproposDisplaySimplePlayerMessage", "DisplaySimplePlayerMessage")
    RegisterForModEvent("AproposDisplaySimpleMessage", "DisplaySimpleMessage")

    RegisterForModEvent("SexLabOrgasmSeparate", "OrgasmStartSSO")    

    ;RegisterForModEvent("StageEnd", "StageEnd" )
    ;RegisterForModEvent("HookOrgasmEnd", "OrgasmEnd")
    ;RegisterForModEvent("ActorChangeStart", "ActorChangeStart")
    ;RegisterForModEvent("ActorChangeEnd", "ActorChangeEnd")
    ;RegisterForModEvent("PositionChange", "PositionChange")
EndFunction

Bool Function CheckCanRun(String meth)
    Trace("CheckCanRun: " + meth)    
    If !Self || !SexLab || !Config
        Error("Critical error - " + meth)
        Return False
    EndIf    

    If !Config.Enabled || GetState() != "Enabled"
        Debug("Config.Enabled=" + Config.Enabled + ", GetState=" + GetState())        
        Return False
    EndIf    
    Return True
EndFunction

Event AproposInitWT(Form aForm, Int vaginalLevel, Int analLevel, Int oralLevel, Bool updateAbuse, Bool updateCreatureAbuse, Bool updateDaedricAbuse) 
    If !CheckCanRun("AproposInitWT")
        Return
    EndIf

    Actor anActor = aForm as Actor

    If !anActor
        Return
    EndIf

    Debug("AproposInitWT called for actor " + anActor.GetDisplayName() + " V:" + vaginalLevel + "A:" + analLevel + "O:" + oralLevel)

    If vaginalLevel < 0 || vaginalLevel > 9 
        Return
    EndIf

    If analLevel < 0 || analLevel > 9 
        Return
    EndIf

    If oralLevel < 0 || oralLevel > 9 
        Return
    EndIf

    OverrideVaginalWearAndTear(anActor, vaginalLevel, updateAbuse=updateAbuse, updateCreatureAbuse=updateCreatureAbuse, updateDaedricAbuse=updateDaedricAbuse)
    OverrideAnalWearAndTear(anActor, analLevel, updateAbuse=updateAbuse, updateCreatureAbuse=updateCreatureAbuse, updateDaedricAbuse=updateDaedricAbuse)
    OverrideOralWearAndTear(anActor, oralLevel, updateAbuse=updateAbuse, updateCreatureAbuse=updateCreatureAbuse, updateDaedricAbuse=updateDaedricAbuse)

    UpdateWearTearEffectsAndAbuseTextures(anActor)

    Debug("AproposInitWT processed!")

EndEvent

Event AproposCustomFemaleMessage(Form primaryFemale, int mapId)
    If !CheckCanRun("AproposCustomFemaleMessage")
        Return
    EndIf

    Bool isValidMap = LogJMapContents(mapId)
    If isValidMap
        ; Required parameters - ModName and EventName
        ; Strip out of the map and continue down.
        String aModName = JMap.getStr(mapId, "ModName")
        String eventName = JMap.getStr(mapId, "EventName")
        If aModName && eventName 
            JMap.removeKey(mapId, "ModName")
            JMap.removeKey(mapId, "EventName")
            Descriptions.DisplayCustomFemaleMessage(primaryFemale As Actor, aModName, eventName, mapId)
        Else
            Error("AproposCustomFemaleMessage - missing ModName or EventName in supplied JMap.")
        EndIf
    EndIf

EndEvent

Event OrgasmStart(int threadId, bool HasPlayer)
    If !CheckCanRun("OrgasmStart")
        Return
    EndIf

    SslThreadController thread = SexLab.GetController(threadId)
    ProcessOrgasmStart(thread)
EndEvent

Event OrgasmStartSSO(Form actorRef, Int threadId)
    If !CheckCanRun("OrgasmStartSSO")
        Return
    EndIf
  
    sslThreadController thread = SexLab.HookController(threadId As String)
    ProcessOrgasmStart(thread)
EndEvent

Function ProcessOrgasmStart(SslThreadController thread)
    Debug("ProcessOrgasmStart")        
    LogEventInfo("ProcessOrgasmStart", thread)
    Descriptions.DisplayOrgasmStartMessage(thread)    
EndFunction

Event AnimationStart(int threadID, bool HasPlayer)
    If !CheckCanRun("AnimationStart")
        Return
    EndIf

    SslThreadController thread = SexLab.GetController(threadID)
    If Config.DebugMessagesEnabled
        LogEventInfo("AnimationStart", thread)
    EndIf
    Descriptions.DisplayAnimationStartChangeOrStageStartMessage(thread, 0, False)
EndEvent

Event AnimationChange(int threadID, bool HasPlayer)
    If !CheckCanRun("AnimationChange")
        Return
    EndIf

    SslThreadController thread = SexLab.GetController(threadID)
    
    If Config.DebugMessagesEnabled
        LogEventInfo("AnimationChange", thread)
    EndIf
    
    Descriptions.DisplayAnimationStartChangeOrStageStartMessage(thread, 0, True)
EndEvent

Event StageStart(int threadID, bool HasPlayer)
    If !CheckCanRun("StageStart")
        Return
    EndIf

    SslThreadController thread = SexLab.GetController(threadID)
    
    ; If Config.DebugMessagesEnabled
    ;     LogAnimationStage("StageStart", thread)
    ; EndIf
    If Config.DebugMessagesEnabled
        LogEventInfo("StageStart", thread)
    EndIf
    Descriptions.DisplayAnimationStartChangeOrStageStartMessage(thread, thread.Stage, False)
EndEvent

Event OrgasmEnd(int threadID, bool HasPlayer)
    If !CheckCanRun("OrgasmEnd")
        Return
    EndIf

    SslThreadController thread = SexLab.GetController(threadID)    
    If Config.DebugMessagesEnabled
        LogEventInfo("OrgasmEnd", thread)       
    EndIf
    Descriptions.DisplayOrgasmEndMessage(thread) 
EndEvent

Event DisplaySimplePlayerMessage(String msg)
    Debug("DisplaySimplePlayerMessage")         
    Widgets.DisplayPlayerDescriptionMessage(msg)
EndEvent

Event DisplaySimpleMessage(String msg)
    Debug("DisplaySimpleMessage")         
    Widgets.EnqueueDescriptionMessage(msg, section="MISC")
EndEvent

; Event OnInit()
;     Debug.OpenUserLog("Apropos2")
;     Setup()
; EndEvent

; State Disabled
;     Event OnBeginState()
;         Debug("Disabled.OnBeginState") 
;         Apropos2Util.Log("Apropos2 - Disabled")
;         ApUtil.SendModEvent("Apropos2Disabled")
;     EndEvent
; EndState

; State Enabled
;     Event OnBeginState()
;         Debug("Enabled.OnBeginState") 
;         Apropos2Util.Log("Apropos2 - Enabled")
;         ApUtil.SendModEvent("Apropos2Enabled")
;     EndEvent
; EndState

Int _widgetTestHotkey = -1
Int Property DefaultWidgetTestHotkey = -1 AutoReadonly

Int Property WidgetTestHotkey
    Int Function get()
        Return _widgetTestHotkey
    EndFunction

    Function set(Int a_val)
        If a_val != _widgetTestHotkey
            UnregisterForKey(_widgetTestHotkey)
            _widgetTestHotkey = a_val
            If _widgetTestHotkey != -1
                RegisterForKey(_widgetTestHotkey)
            EndIf
        EndIf
    EndFunction
EndProperty

Event OnKeyDown(Int keyCode)
    If keyCode == _widgetTestHotkey
        Widgets.PerformVisualTest()
    EndIf
EndEvent

Event Stop()
    UnregisterForAllKeys()
    Parent.Stop()
EndEvent

Function UpdateWearTearEffectsAndAbuseTextures(Actor anActor)
    If Config.DebugMessagesEnabled
        DebugActor(anActor, "UpdateWearTearEffectsAndAbuseTextures")
    EndIf    
    SendUpdateEffectsAndTatsEvent(anActor, increasingAbuse=True)
    
EndFunction

Function LogWearAndTearApplication(String area, Actor anActor, string damageClass, Bool isRapeOrAggressive, Bool isDaedricCreatureOrDremora, Bool isCreature) 
    If Config.DebugMessagesEnabled
        DebugActor(anActor, area + ": " + damageClass + "," + StringIfElse(isRapeOrAggressive, "rape", "consensual") + "," + StringIfElse(isDaedricCreatureOrDremora, "Daedric/dremora") + "," + StringIfElse(isCreature, "Creature", "Non-Creature"))
    EndIf
EndFunction

Function OverrideVaginalWearAndTear(Actor anActor, Int amount, Bool updateAbuse, Bool updateCreatureAbuse, Bool updateDaedricAbuse) 
   SendOverrideWearAndTearEvent(anActor, "Vaginal", amount, updateAbuse=updateAbuse, updateCreatureAbuse=updateCreatureAbuse, updateDaedricAbuse=updateDaedricAbuse)
EndFunction

Function OverrideAnalWearAndTear(Actor anActor, Int amount, Bool updateAbuse, Bool updateCreatureAbuse, Bool updateDaedricAbuse) 
   SendOverrideWearAndTearEvent(anActor, "Anal", amount, updateAbuse=updateAbuse, updateCreatureAbuse=updateCreatureAbuse, updateDaedricAbuse=updateDaedricAbuse)
EndFunction

Function OverrideOralWearAndTear(Actor anActor, Int amount, Bool updateAbuse, Bool updateCreatureAbuse, Bool updateDaedricAbuse) 
   SendOverrideWearAndTearEvent(anActor, "Oral", amount, updateAbuse=updateAbuse, updateCreatureAbuse=updateCreatureAbuse, updateDaedricAbuse=updateDaedricAbuse)
EndFunction

; Function ApplyVaginalWearAndTear(Actor anActor, string damageClass, Bool isRapeOrAggressive, Bool isDaedricCreatureOrDremora, Bool isCreature)
;     LogWearAndTearApplication("ApplyVaginalWearAndTear", anActor, damageClass, isRapeOrAggressive, isDaedricCreatureOrDremora, isCreature)
;     SendApplyWearAndTearEvent(anActor, "vaginal", damageClass, isRapeOrAggressive, isDaedricCreatureOrDremora, isCreature)
; EndFunction

; Function ApplyOralWearAndTear(Actor anActor, string damageClass, Bool isRapeOrAggressive, Bool isDaedricCreatureOrDremora, Bool isCreature)
;     LogWearAndTearApplication("ApplyOralWearAndTear", anActor, damageClass, isRapeOrAggressive, isDaedricCreatureOrDremora, isCreature)   
;     SendApplyWearAndTearEvent(anActor, "oral", damageClass, isRapeOrAggressive, isDaedricCreatureOrDremora, isCreature)
; EndFunction

; Function ApplyAnalWearAndTear(Actor anActor, string damageClass, Bool isRapeOrAggressive, Bool isDaedricCreatureOrDremora, Bool isCreature)
;     LogWearAndTearApplication("ApplyAnalWearAndTear", anActor, damageClass, isRapeOrAggressive, isDaedricCreatureOrDremora, isCreature)   
;     SendApplyWearAndTearEvent(anActor, "anal", damageClass, isRapeOrAggressive, isDaedricCreatureOrDremora, isCreature)
; EndFunction

Bool Function IsAnalVirgin(Actor anActor)
    ; First consult SL's skill level in area
    ; A value of 0 does not necessarily denote virginity
    ; BUT a value over 0 does.
    Int analSkill = SexLab.GetSkill(anActor, "Anal")
    If Config.DebugMessagesEnabled
        Log("SexLab.GetSkill(" + anActor.GetLeveledActorBase().GetName() + ", Anal) = " + analSkill)
    EndIf
    If analSkill > 0
        Return False
    EndIf
    Int hadAnalSex = GetIntValue(anActor, "hadAnalSex")
    If Config.DebugMessagesEnabled
        Log("GetIntValue(" + anActor.GetLeveledActorBase().GetName() + ", hadAnalSex) = " + hadAnalSex)
    EndIf    
    Return hadAnalSex == 0
EndFunction

Bool Function IsVaginalVirgin(Actor anActor)
    ; First consult SL's skill level in area
    ; A value of 0 does not necessarily denote virginity
    ; BUT a value over 0 does.
    Int vaginalSkill = SexLab.GetSkill(anActor, "Vaginal")
    If Config.DebugMessagesEnabled
        Log("SexLab.GetSkill(" + anActor.GetLeveledActorBase().GetName() + ", Vaginal) = " + vaginalSkill)
    EndIf
    If vaginalSkill > 0
        Return False
    EndIf
    Int hadVaginalSex = GetIntValue(anActor, "hadVaginalSex")
    If Config.DebugMessagesEnabled
        Log("GetIntValue(" + anActor.GetLeveledActorBase().GetName() + ", hadVaginalSex) = " + hadVaginalSex)
    EndIf    
    Return hadVaginalSex == 0    
EndFunction

Bool Function IsOralVirgin(Actor anActor)
    ; First consult SL's skill level in area
    ; A value of 0 does not necessarily denote virginity
    ; BUT a value over 0 does.
    Int oralSkill = SexLab.GetSkill(anActor, "Oral")
    If Config.DebugMessagesEnabled
        Log("SexLab.GetSkill(" + anActor.GetLeveledActorBase().GetName() + ", Oral) = " + oralSkill)
    EndIf
    If oralSkill > 0
        Return False
    EndIf
    Int hadOralSex = GetIntValue(anActor, "hadOralSex")
    If Config.DebugMessagesEnabled
        Log("GetIntValue(" + anActor.GetLeveledActorBase().GetName() + ", hadOralSex) = " + hadOralSex)
    EndIf    
    Return hadOralSex == 0       
EndFunction

Bool Function IsActorQuiesced(Actor anActor)
    Bool isQuiesced = anActor.GetCombatState() == 0 && !SexLab.IsActorActive(anActor)
    If !isQuiesced && Config.DebugMessagesEnabled
        LogActor(anActor, "is either in combat, searching for combat, or currently animating")
    EndIf
    Return isQuiesced
EndFunction

Bool Function IsValidActor(Actor anActor)
    Return anActor && !anActor.IsDead() && !anActor.IsDisabled() && anActor.Is3DLoaded()
EndFunction

Bool Function IsValidForAutoMasturbate(Actor anActor)
    Return anActor.GetCombatState() == 0 && !anActor.IsOnMount() && !anActor.IsTrespassing() && !anActor.IsGhost()
EndFunction

Int Function GetActorArousal(Actor anActor)
    Return SlaUtil.GetActorArousal(anActor)
EndFunction

Function Masturbate(Actor anActor)
    Actor[] sexActor = New actor[1]
    sexActor[0] = anActor
    sslBaseAnimation[] anims = SexLab.GetAnimationsByTag(1, "F,Masturbation", TagSuppress="Estrus", RequireAll=True)
    Sexlab.StartSex(sexActor, anims)        
EndFunction

Function Log(String msg)
    Config.Log(msg, source="Apropos2Framework")
EndFunction

Function Trace(String msg)
    If !Config.TraceMessagesEnabled
        Return
    EndIf

    Config.Debug(msg, source="Apropos2PeriodicPlayerDescriptions")
EndFunction

Function Debug(String msg)
    Config.Debug(msg, source="Apropos2Framework")
EndFunction

Function LogActor(Actor anActor, String msg)
    Log(anActor.GetDisplayName() + " " + msg)
EndFunction

Function DebugActor(Actor anActor, String msg)
    Debug(anActor.GetDisplayName() + " " + msg)
EndFunction

Function LogEventInfo(String eventName, sslThreadController thread)
    Config.LogEventInfo(eventName, thread, source="Apropos2Framework")
EndFunction

; Function LogAnimationStage(String eventName, sslThreadController thread)
;     Config.LogAnimationStage(eventName, thread, source="Apropos2Framework")
; EndFunction