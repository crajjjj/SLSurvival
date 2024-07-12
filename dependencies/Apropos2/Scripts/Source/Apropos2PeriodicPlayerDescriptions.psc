ScriptName Apropos2PeriodicPlayerDescriptions Extends Apropos2SystemLibrary

Import ApUtil
Import Apropos2Util

SslThreadController currentPlayerThread

Int _playerDescriptionsHotKey = -1
Int Property PlayerDescriptionsHotKey
    Int Function get()
        Return _playerDescriptionsHotKey
    EndFunction

    Function set(Int a_val)
        If a_val != _playerDescriptionsHotKey
            UnregisterForKey(_playerDescriptionsHotKey)
            _playerDescriptionsHotKey = a_val
            If _playerDescriptionsHotKey != -1
                RegisterForKey(_playerDescriptionsHotKey)
            EndIf
        EndIf
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

    If Config.DebugMessagesEnabled
        Debug("GameLoaded - Ready")
    EndIf   
EndFunction

Function UnregisterForEvents()
    Debug("UnregisterForEvents")
    UnregisterForModEvent("HookAnimationEnd")
    UnregisterForModEvent("HookAnimationStart")
    UnregisterForModEvent("HookStageStart")
EndFunction

Function RegisterForEvents()
    Debug("RegisterForEvents")
    RegisterForModEvent("HookAnimationEnd", "AnimationEnd")
    RegisterForModEvent("HookAnimationStart", "AnimationStart")
    RegisterForModEvent("HookStageStart", "StageStart")
EndFunction

Bool Function CheckCanRun(String meth)
    Trace("CheckCanRun: " + meth)
    If !Self || !SexLab || !Config
        Error("Critical error - " + meth)
        Return False
    EndIf    

    If !Config.Enabled
        Debug("Config.Enabled=" + Config.Enabled)        
        Return False
    EndIf    
    Return True
EndFunction

Event OnKeyDown(Int keyCode)
    If keyCode == _playerDescriptionsHotKey && Config.PeriodicPCMessagesHotKeyEnabled()
        If currentPlayerThread
            Debug("Player pressed PlayerDescriptionsHotKey hotkey - active PC thread.")
            Descriptions.DisplayAnimationStartChangeOrStageStartMessage(currentPlayerThread, currentPlayerThread.Stage, False)
        Else
            Debug("Player pressed PlayerDescriptionsHotKey hotkey - Player not animating.")
        EndIf
    EndIf
EndEvent

Event AnimationStart(int threadID, bool HasPlayer)
    If !CheckCanRun("AnimationStart")
        Return
    EndIf

    If HasPlayer
        currentPlayerThread = SexLab.GetController(threadID)
    EndIf
EndEvent

Event AnimationEnd(int threadID, bool HasPlayer)
    If !CheckCanRun("AnimationEnd")
        Return
    EndIf

    SslThreadController thread = SexLab.GetController(threadID)    
    If HasPlayer
        currentPlayerThread = None
    EndIf
EndEvent

Event StageStart(int threadID, bool HasPlayer)
    If !CheckCanRun("StageStart")
        Return
    EndIf

    If !HasPlayer
        Return
    EndIf

    If Config.PeriodicPCMessagesHotKeyEnabled() || Config.PeriodicPCMessagesDisabled()
        Return
    EndIf

    If !currentPlayerThread
        Return
    EndIf

    Float[] timers

    If currentPlayerThread.Victims && currentPlayerThread.Victims.Length > 0 
        timers = SexLab.Config.StageTimerAggr
    Else
        timers = SexLab.Config.StageTimer
    EndIf

    Int currentStage = currentPlayerThread.stage ; stage is 1-based indexing
    Float timer
    ;Debug("CurrentStage=" + currentStage)
    If currentStage > 0 
        If currentStage < timers.Length 
            timer = timers[currentStage]
        Else ;; currentStage has exceed timers array length, it must be in the '+' 
            timer = timers[timers.Length - 1]
        EndIf
        Debug("timer=" + timer)
    EndIf

    Float widgetSecondsToDisplay = Config.WidgetSecondsToDisplay
    Float limit = (widgetSecondsToDisplay * 2) + 1
    ;Debug("limit=" + limit)
    ; schedule a single description display per stage, if there is enough time 
    ; 'enough' time is determined by time in this stage > time display the normal description (10s usually) plus another time display.
    ; plus 1 second buffer.
    ; So if timer is 30s, and widget display is 10s, 30 > ((10 * 2) + 1) or 30 > 21
    ; but not if timer is 15s, 15 Not GT ((10 * 2) + 1) or 15 Not GT 21
    If timer > limit
        RegisterForSingleUpdate(widgetSecondsToDisplay + 1) ; wait for normal description, plus 1 seconds
    EndIf
EndEvent

Event OnUpdate()
    If !currentPlayerThread
        Return
    EndIf
    Debug("Running scheduled description!")
    If currentPlayerThread
        Descriptions.DisplayAnimationStartChangeOrStageStartMessage(currentPlayerThread, currentPlayerThread.Stage, False)
    EndIf
EndEvent

Function Debug(String msg)
    Config.Log(msg, source="Apropos2PeriodicPlayerDescriptions")
EndFunction

Function Trace(String msg)
    If !Config.TraceMessagesEnabled
        Return
    EndIf

    Config.Debug(msg, source="Apropos2PeriodicPlayerDescriptions")
EndFunction