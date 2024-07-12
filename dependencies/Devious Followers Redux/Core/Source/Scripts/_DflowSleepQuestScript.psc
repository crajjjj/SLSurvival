ScriptName _DflowSleepQuestScript extends Quest

GlobalVariable Property NewProperty  Auto ; Garbage, left over from some aborted edit? Not used anyway.

_Dftools Property Tool Auto
_DFlowMCM Property MCM Auto
Keyword Property LocTypeInn Auto
QF__Gift_09000D62 Property Q  Auto  
_DFGoldConQScript Property GoldCon Auto
GlobalVariable Property _DflowEnable Auto


Message Property _DFlowDebtCreditMsg Auto

Bool Property ERest Auto
Float Property ND auto ; ND is basically the NEXT time you can sleep and recover will; there's a cooldown so you can't chain-sleep your will back up.
Float Property NR auto ; Start Time

GlobalVariable Property Lives  Auto
GlobalVariable Property LivesMax  Auto
GlobalVariable Property _DFFollowerHasMaxLives Auto

Event OnSleepStart(Float startTime, Float endTime)

    ; Normally, in pause, do nothing here. Freeze everything.
    Bool isPaused = 0.0 == _DflowEnable.GetValue()
    SleepStartHandler(startTime, endTime, isPaused)

endEvent

Event OnSleepStop(Bool abInterrupted)

    ; Normally, in pause, do nothing here. Freeze everything.
    Bool isPaused = 0.0 == _DflowEnable.GetValue()
    SleepStopHandler(abInterrupted, isPaused)

EndEvent


Function SleepStartHandler(Float startTime, Float endTime, Bool isPaused)

    Float sleepDuration = endTime - startTime
    
    ; 5/24 = 0.208, 6/24 = 0.25
    ERest = sleepDuration > 0.23
    ; ERest used to determine "up front" whether rest was possible, then any interruption blocked it.
    ; Now, we simply look at how much sleep the PC *actually* got, and decide if they're eligible for recovery.
    ; ERest is set anyway, in case it has been used in some stealthy way.
    
    NR = startTime

Endfunction


Function SleepStopHandler(Bool abInterrupted, Bool isPaused)
    ; OK to spam this, it has a timer check
    Tool.UpdateChaos()

    ; Interruption is irrelevant, all that matters is "did we get enough sleep?"
    Float sleepDuration = Utility.GetCurrentGameTime() - NR
    
    If sleepDuration > 0.23 ; See OnSleepStart ... around 5.5 hours
        
        Q.PriceReset() ; Reset device removal prices
        
        Lives.SetValue(LivesMax.GetValue()) ; Reset Lives to MAX, always MAX.
        _DFFollowerHasMaxLives.SetValue(1.0)
        
        If !isPaused
            MCM.MDC.CheckAndClearDealRequests()
        EndIf

        ; NR is startTime
        if NR > ND
        
            ; Moved gold control update within cooldown gated check, so player can't just sleep and retry gold control
            If !isPaused
                GoldCon.Recalc()

                If GoldCon.Enabled && MCM.GetStage() < 100
                    GoldCon.ResetAgreedGold()
                Endif
                
                Tool.SleepGameCheck()
            EndIf
            
            Tool.RestoreResist()
            
            ND = NR + 0.8 ; Next sleep time is this sleepStart + 19 hours. e.g. At least 13 hours between sleeps.
            
        ElseIf ND > NR + 0.81
            ND = NR + 0.8 ; If ND somehow gets pushed waaaay out, clamp it back.
        Endif
        
    Else 
        MCM.noti("6")
    Endif
    
EndFunction


Bool Function CanRecover()

    Return ND < Utility.GetCurrentGameTime()

EndFunction

