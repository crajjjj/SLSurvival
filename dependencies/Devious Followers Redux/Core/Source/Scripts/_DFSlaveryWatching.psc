Scriptname _DFSlaveryWatching extends Quest  

QF__Gift_09000D62 Property Q Auto
_Dtick Property Tick Auto
_DflowSleepQuestScript Property _DflowSleepQuest Auto
_DFTools Property Tool Auto

Float Property LastDaysEnslaved Auto

GlobalVariable Property vkjSubmissionScore Auto

; Stage 10 - start up and enslave - set objective
; Stage 50 - wait for dialog or end
; Stage 60 - wait for end
; Stage 80 - take back from SLTR
; Stage 90 - stop event listeners
; Stage 100 - done - clear objective



; On load handling
Event Init()
    GotoState("InEvent")
    
    Debug.TraceConditional("DF - _DFSlaveryWatcher - Init", True)
    Int stageIs = GetStage()
    If  stageIs >= 10 && stageIs < 90
        InitHandler()
    EndIf
    
    GotoState("")
EndEvent


Function InitHandler()
    
    Debug.Notification("Watcher started at stage " + GetStage())
    Debug.TraceConditional("Watcher started at stage " + GetStage(), True)
    
    Q = Quest.GetQuest("_DFlow") As QF__Gift_09000D62
    Tick = Quest.GetQuest("_Dtick") As _Dtick
    
    Int lolaIndex = Game.GetModByName("submissivelola_est.esp")
    If 255 != lolaIndex && LolaSupported()
    
        ; Register listeners because DTick is no longer listening...
        ; Need to handle two cases:
        ;   1) SL signals player release
        ;   2) SL loses control of the PC in a way that means we should abort the Devious Follower relationship. (e.g. sold into SD+)
        
        RegisterForModEvent("SLTR Exit", "HandleLolaExit")
        
        RegisterForModEvent("PlayerRefEnslaved", "HandleZapEnslave") ; This is sent by SS in response to a PEnslaveCheck event based on membership of the zbfFactionSlave
        RegisterForModEvent("PlayerRefFreed", "HandleZapFreedom") ; This is sent by SS in response to a PEnslaveCheck event.
        RegisterForModEvent("SSLV Entry", "HandleSSEntry") ; Called by mods to send player to Simple Slavery auction.
    Else
        ; Abort, because SLTR has gone away! (Or the PC is already Lola)
        Int stageIs = GetStage()
        If  stageIs >= 10 && stageIs < 80
            SetStage(80)
        EndIf
    EndIf

    ; Sleep quest isn't stopped in pause, but it does change behavior.
    
EndFunction


Function Unregister()

    UnregisterForModEvent("SLTR Exit")
    UnregisterForModEvent("PlayerRefEnslaved")
    UnregisterForModEvent("PlayerRefFreed")
    UnregisterForModEvent("SSLV Entry")
   
EndFunction


Function StartExternalSlavery()

    Debug.TraceConditional("DF - StartExternalSlavery - start", True)
    Debug.Notification("Starting external slavery")
    
    InitHandler()


    Bool started = False
    
    LastDaysEnslaved = 0.0
    
    ; SLTR_DF_Entry(Form ownerActor, int minDays=0, int minScore=0, Form slaveCollar, Form slaveBoots, Form kwSlaveBoots, Form slaveMittens)
    Actor owner = Q.Alias__DMaster.GetActorRef()
    
    ; If there's no owner we're in a bit of trouble...
    If owner
    
        Debug.TraceConditional("DF - StartExternalSlavery - wait for pause", True)
        Int eventID = ModEvent.Create("SLTR DF Entry")
        If eventID
        
            ; Find owner personality type
            Int personality = Q.GetPersonality(owner)
            Int control = Q.GetControl(owner)
    
            Int baseDays = 7
            If Tool.PersonalityProfiteer == personality
                baseDays = 5 ; Get back to work soon slacker!
            ElseIf Tool.PersonalitySlaver == personality
                baseDays = 10
            ElseIf Tool.PersonalityNightmare
                baseDays = Utility.RandomInt(5, 14)
            EndIf
            
            Int submissionTarget = 40 ; Higher submission scores than 50 are difficult to get, so use with caution
            submissionTarget += (control / 5)
        
            ModEvent.PushForm(eventID, owner)
            ModEvent.PushInt(eventID, baseDays)
            ModEvent.PushInt(eventID, submissionTarget)
            ModEvent.PushForm(eventID, Q.CollarR)
            ModEvent.PushForm(eventID, Q.BootsR)
            ModEvent.PushForm(eventID, Q._DFCrawlRequired)
            ModEvent.PushForm(eventID, Q.MittsR)

            Tick.FirePauseEvent(True)
            
            Debug.TraceConditional("DF - StartExternalSlavery - wait for pause", True)
            Tick.WaitForPause()
            

            Debug.TraceConditional("DF - StartExternalSlavery - send Lola entry event", True)
            Debug.Notification("Triggering Lola")
            ModEvent.Send(eventID)
            started = True
        Else
            Debug.TraceConditional("DF - StartExternalSlavery - no event", True)
        EndIf
    Else
        Debug.TraceConditional("DF - StartExternalSlavery - no owner", True)
    EndIf
    
    
    If started
        ; Wait for SLTR to respond
        Utility.Wait(10.0) 
        started = InLola()
    EndIf
   
    
    If started
        Debug.TraceConditional("DF - StartExternalSlavery - reduce debts", True)
        Q.AdjustPostSlaveryDebt() ; Remove the debt immediately - it's not contingent on the hand-back.
    Else
        Debug.TraceConditional("DF - StartExternalSlavery - terminate quest prematurely", True)
        ; Terminate the enslavement mode without having started it properly.
        Q._DFSlaveryWatcher.SetStage(90)
    EndIf

    Debug.TraceConditional("DF - StartExternalSlavery - end", True)
    
EndFunction


Function EndExternalSlavery()

    Debug.TraceConditional("DF - EndExternalSlavery - start", True)
    
    Debug.Notification("Ending external slavery")
    
    
    ; Better if these were removed on a daily basis. So that's a to-do.
    ;
    Q.ReduceExpectedDeals(LastDaysEnslaved) ; every day served is worth a deal removed ... nice
    
    Float fatigueAdd = LastDaysEnslaved * 3.0 ; 7 days = 21 fatigue, 30 days = 90 fatigue 
    Q.Tool.AddFatigueValue(fatigueAdd)
    Debug.TraceConditional("DF - updated for " + LastDaysEnslaved + " days enslaved, and " + fatigueAdd + " fatigue", True)
    
    
    Tick.FirePauseEvent(False)
    Bool followerOK = Tick.WaitForUnpause()
    If followerOK
        Debug.Notification("Your follower tells you what's what!")
        Debug.TraceConditional("DF - Follower OK after unpause", True)
        Actor who = Q.Alias__DMaster.GetActorRef()
        If who
            Debug.TraceConditional("DF - Say actor available after unpause", True)
            Topic toSay = Game.GetFormFromFile(0x003221C1, "DeviousFollowers.esp") As Topic ; You seemed to like that...
            If toSay
                Debug.TraceConditional("DF - Say form available after unpause", True)
                Utility.Wait(5.0)
                who.Say(toSay, who, False)
            EndIf
        EndIf
        
        Q.SetPostSlaveryDeals()

    EndIf
    
    Debug.TraceConditional("DF - EndExternalSlavery - end", True)

EndFunction


Bool Function LolaSupported()

    Int lolaIndex = Game.GetModByName("submissivelola_est.esp")
    If 255 != lolaIndex
        ; Quest.GetQuest("vkjReturnToDFC") -- not working.
        Quest lolaDfQuest = Game.GetFormFromFile(0x000604C5, "submissivelola_est.esp") As Quest 
        If !lolaDfQuest
            Return False
        EndIf

        Return !InLola()
    
    EndIf
    Return False

EndFunction


Bool Function InLola()

    Int lolaIndex = Game.GetModByName("submissivelola_est.esp")
    If 255 != lolaIndex
        ; Quest lolaQuest = Quest.GetQuest("vkjMQ") -- not working.
        Quest lolaQuest = Game.GetFormFromFile(0x00026EC9, "submissivelola_est.esp") As Quest 
        Return lolaQuest && lolaQuest.IsRunning()
    EndIf
    Return False
    
EndFunction






Event HandleLolaExit(String source, Form ownerActor, Float score, Float daysEnslaved)
    GotoState("InEvent")
    Debug.TraceConditional("DF - HandleLolaExit", True)
    
    If source == "SLTR DF Entry"
    
        LastDaysEnslaved = daysEnslaved
        
        SetStage(80)  ; Release player
    Else
        SetStage(90) ; Just stop listening.
    EndIf
    
    GotoState("")
EndEvent


Event HandleZapEnslave()
    GotoState("InEvent")
    Debug.TraceConditional("DF - HandleZapEnslave", True)
    SetStage(90) ; Stop listening
    GotoState("")
EndEvent

Event HandleZapFreedom()
    GotoState("InEvent")
    Debug.TraceConditional("DF - HandleZapFreedom", True)
    SetStage(90)
    GotoState("")
EndEvent

Event HandleSSEntry()
    GotoState("InEvent")
    Debug.TraceConditional("DF - HandleSSEntry", True)
    SetStage(90)
    GotoState("")
EndEvent


State InEvent

    Event Init()
    EndEvent
    
    Event HandleLolaExit(String source, Form ownerActor, Float score, Float daysEnslaved)
    EndEvent

    Event HandleZapEnslave()
    EndEvent

    Event HandleZapFreedom()
    EndEvent

    Event HandleSSEntry()
    EndEvent
    
EndState
