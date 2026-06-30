Scriptname _SLS_InterfaceShs extends Quest

Event OnInit()
    RegisterForModEvent("_SLS_Int_PlayerLoadsGame", "On_SLS_Int_PlayerLoadsGame")
EndEvent

Event On_SLS_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
    PlayerLoadsGame()
EndEvent

Function PlayerLoadsGame()
    If Game.GetModByName("SunHelmSurvival.esp") != 255
        If GetState() != "Installed"
            GoToState("Installed")
        EndIf
        
    Else
        If GetState() != ""
            GoToState("")
        EndIf
    EndIf
endFunction

Bool Function GetIsInterfaceActive()
    Return GetState() == "Installed"
EndFunction

Event OnEndState()
    Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet.
    
    _SHHungerQuest = Game.GetFormFromFile(0x008EE8, "SunHelmSurvival.esp") as Quest
    _SHThirstQuest = Game.GetFormFromFile(0x05C470, "SunHelmSurvival.esp") as Quest
    _SHFatigueQuest = Game.GetFormFromFile(0x01E844, "SunHelmSurvival.esp") as Quest

    _SHHungerTimeStamp = Game.GetFormFromFile(0x00EAB0, "SunHelmSurvival.esp") as GlobalVariable

    _SHCurrentHungerLevel = Game.GetFormFromFile(0x00EAAE, "SunHelmSurvival.esp") as GlobalVariable
    _SHCurrentThirstLevel = Game.GetFormFromFile(0x05C472, "SunHelmSurvival.esp") as GlobalVariable
    _SHCurrentFatigueLevel = Game.GetFormFromFile(0x021E3F, "SunHelmSurvival.esp") as GlobalVariable
    
EndEvent

; Installed state ==================================================

State Installed

    Bool Function IsNeedsModActive()
        Return _SHHungerQuest.IsRunning()
    EndFunction

    Function Eat(Float FoodPoints)
        _SLS_IntShs.DecreaseHungerLevel(FoodPoints, _SHHungerQuest)
    EndFunction
    
    Function Drink(Float WaterPoints)
        _SLS_IntShs.DecreaseThirstLevel(WaterPoints, _SHThirstQuest)
    EndFunction
    
    Function ModFatigue(Float SleepAmount) ; -SleepAmount = Remove Fatigue. +SleepAmount = Add Fatigue
        _SLS_IntShs.ModFatigue(SleepAmount, _SHFatigueQuest)
    EndFunction
    
    Float Function GetLastHungerUpdateTime()
        Return _SHHungerTimeStamp.GetValue()
    EndFunction
    
    Float Function GetFatigue()
        Return _SHCurrentFatigueLevel.GetValue()
    EndFunction

    ; TO-DO
    ; Probably not the most performant method to access hunger level since accessing script properties is slow
    ; Will need to improve on this later
    Int Function GetHungerStage()
        Return _SLS_IntShs.GetHungerStage(_SHHungerQuest)
    EndFunction
    
    ; TO-DO
    Int Function GetThirstStage()
        Return _SLS_IntShs.GetThirstStage(_SHThirstQuest)
    EndFunction

    ; TO-DO
    Int Function GetFatigueStage()
        Return _SLS_IntShs.GetFatigueStage(_SHFatigueQuest)
    EndFunction

    Bool Function IsDesperate()
        Return GetHungerStage() == 5 || GetThirstStage() == 5
    EndFunction

    Bool Function GetBegIsHungry()
        Return GetHungerStage() >= 3 ; Level 'Hungry' or above
    EndFunction
    
    Bool Function GetBegIsThirsty()
        Return GetThirstStage() >= 3 ; Level 'Parched' or above
    EndFunction

    ; TO-DO
    ; Maybe use an array lookup for this?
    Float Function GetBellyScale()
        int hungerStage = GetHungerStage()
        If hungerStage == 0 ; Satiated
            Return BellyScaleShs00
        ElseIf hungerStage == 1 ; Mild hunger
            Return BellyScaleShs01
        ElseIf hungerStage == 2 ; Moderate hunger
            Return BellyScaleShs02
        ElseIf hungerStage == 3 ; Severe hunger
            Return BellyScaleShs03
        ElseIf hungerStage == 4 ; Severe hunger
            Return BellyScaleShs04
        ElseIf hungerStage == 5 ; Severe hunger
            Return BellyScaleShs05
        Else
            Return -1.0 ; magic effect is currently being swapped out - wait
        EndIf
    EndFunction

    Function CorrectFatigue(Float SleepPenalty, Float StartingFatigue, Float HoursSlept)
        
        Int[] FatigueLevels = _SLS_IntShs.GetFatigueLevels(_SHFatigueQuest)
        
        Float TargetFatigue
        If SleepPenalty <= 0.2
            TargetFatigue = (SleepPenalty / 0.2) * FatigueLevels[1] ; Rested
        ElseIf SleepPenalty <= 0.4
            TargetFatigue = (SleepPenalty / 0.4) * FatigueLevels[2] ; Slightly Tired
        ElseIf SleepPenalty <= 0.6
            TargetFatigue = (SleepPenalty / 0.6) * FatigueLevels[2] ; Tired
        ElseIf SleepPenalty <= 0.8
            TargetFatigue = (SleepPenalty / 0.8) * FatigueLevels[2] ; Weary
        Else
            TargetFatigue = (SleepPenalty / 1.0) * (FatigueLevels[4] + FatigueLevels[5]) / 2 ; Set to midpoint between 'Weary' and 'Exhausted' levels
        EndIf
        
        ; Debug.Messagebox("SleepPenalty: " + SleepPenalty + ". TargetFatigue: " + TargetFatigue)
        Float CurrentFatigue = GetFatigue()
        If StartingFatigue < TargetFatigue ; Player is more tired after sleep - cap rest gained
            If CurrentFatigue > TargetFatigue 
                Float Delta = TargetFatigue - CurrentFatigue
                ; Debug.Messagebox("Delta: " + Delta)
                ModFatigue(Delta as Int)
            ;Else   ; Else player is still more tired than the cap - Do nothing
            EndIf

        Else ; Player is more refreshed after sleep - interpolate fatigue points using sleep duration 
                
            Float Delta = TargetFatigue - CurrentFatigue
            Float ThisNapFatigue = (Delta / 8.0) * HoursSlept ; 8 hours of sleeping to reach target fatigue
            ;Debug.MessageBox("ThisNapFatigue: " + ThisNapFatigue)
            ModFatigue(ThisNapFatigue)
        EndIf

    EndFunction

    String Function GetConditionsStatement(Float SleepPenalty)
        String ConditionString = "Maximum rest in these conditions is: "    
        If SleepPenalty <= 0.2
            Return ConditionString + "Rested. "
        ElseIf SleepPenalty <= 0.4
            Return ConditionString + "Slightly tired. "
        ElseIf SleepPenalty <= 0.6
            Return ConditionString + "Tired. "
        ElseIf SleepPenalty <= 0.8
            Return ConditionString + "Weary. "
        Else
            Return ConditionString + "Exhausted. "
        EndIf
    EndFunction

    Float Function GetHungerSleepPenalty()
        int hungerStage = GetHungerStage()
        If hungerStage == 0 ; Well Fed
            Return JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "hunger_shs_wellfed") ; -0.05
        ElseIf hungerStage == 1 ; Satisfied
            Return JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "hunger_shs_satisfied") ; -0.025
        ElseIf hungerStage == 2 ; Peckish
            Return JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "hunger_shs_peckish") ; 0.0
        ElseIf hungerStage == 3 ; Hungry
            Return JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "hunger_shs_hungry") ; 0.1
        ElseIf hungerStage == 4 ; Ravenous
            Return JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "hunger_shs_ravenous") ; 0.15
        ElseIf hungerStage == 5 ; Desperate
            Return JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "hunger_shs_desperate") ; 0.3
        EndIf
    EndFunction
    
    Float Function GetThirstSleepPenalty()
        int thirstStage = GetThirstStage()
        If thirstStage == 0 ; Quenched
            Return JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "thirst_shs_quenched") ; -0.05
        ElseIf thirstStage == 1 ; Sated
            Return JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "thirst_shs_sated") ; -0.05
        ElseIf thirstStage == 2 ; Thirsty
            Return JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "thirst_shs_thirsty") ; -0.05
        ElseIf thirstStage == 3 ; Parched
            Return JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "thirst_shs_parched") ; -0.05
        ElseIf thirstStage == 4 ; Dehydrated
            Return JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "thirst_shs_dehydrated") ; -0.05
        ElseIf thirstStage == 5 ; Desperate
            Return JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "thirst_shs_desperate") ; -0.05
        EndIf
    EndFunction
    
    String Function GetAioHunger()
        int hungerStage = GetHungerStage()
        If hungerStage == 0 ; Well Fed
            Return "Well fed"
        ElseIf hungerStage == 1 ; Satisfied
            Return "Satiated"
        ElseIf hungerStage == 2 ; Peckish
            Return "Peckish"
        ElseIf hungerStage == 3 ; Hungry
            Return "Hungry"
        ElseIf hungerStage == 4 ; Ravenous
            Return "Ravenous"
        ElseIf hungerStage == 5 ; Desperate
            Return "Desperate"
        EndIf
    EndFunction

    String Function GetAioThirst()
        int thirstStage = GetThirstStage()
        If thirstStage == 0 ; Quenched
            Return "Quenched"
        ElseIf thirstStage == 1 ; Sated
            Return "Sated"
        ElseIf thirstStage == 2 ; Thirsty
            Return "Thirsty"
        ElseIf thirstStage == 3 ; Parched
            Return "Parched"
        ElseIf thirstStage == 4 ; Dehydrated
            Return "Dehydrated"
        ElseIf thirstStage == 5 ; Desperate
            Return "Desperate"
        EndIf
    EndFunction
    
    String Function GetAioFatigue()
        int fatigueStage = GetFatigueStage()
        If fatigueStage == 0 ; Well Rested
            Return "Well rested"
        ElseIf fatigueStage == 1 ; Rested
            Return "Rested"
        ElseIf fatigueStage == 2 ; Slightly Tired
            Return "Slightly tired"
        ElseIf fatigueStage == 3 ; Tired
            Return "Tired"
        ElseIf fatigueStage == 4 ; Weary
            Return "Weary"
        ElseIf fatigueStage == 5 ; Exhausted
            Return "Exhausted"
        EndIf
    EndFunction

EndState

; Empty state ==================================================

Bool Function IsNeedsModActive()
    Return false
EndFunction

Function Eat(Float FoodPoints)
EndFunction

Function Drink(Float WaterPoints)
EndFunction

Function ModFatigue(Float SleepAmount)
EndFunction

Bool Function IsDesperate()
    Return false
EndFunction

Bool Function GetBegIsHungry()
    Return false
EndFunction

Bool Function GetBegIsThirsty()
    Return false
EndFunction

Float Function GetBellyScale()
    Return 1.0
EndFunction

Float Function GetLastHungerUpdateTime()
    Return 0.0
EndFunction

Float Function GetFatigue()
    Return 0.0
EndFunction

String Function GetConditionsStatement(Float SleepPenalty)
    Return ""
EndFunction

Function CorrectFatigue(Float SleepPenalty, Float StartingFatigue, Float HoursSlept)
EndFunction

Float Function GetHungerSleepPenalty()
    Return 0.0
EndFunction

Float Function GetThirstSleepPenalty()
    Return 0.0
EndFunction

String Function GetAioHunger()
    Return ""
EndFunction

String Function GetAioThirst()
    Return ""
EndFunction

String Function GetAioFatigue()
    Return ""
EndFunction

Int Function GetHungerStage()
    Return 0
EndFunction

Int Function GetThirstStage()
    Return 0
EndFunction

Int Function GetFatigueStage()
    Return 0
EndFunction

; Properties =============================================================

; Needs Quest
Quest _SHHungerQuest
Quest _SHThirstQuest
Quest _SHFatigueQuest

; Needs Timestamp (Float)
GlobalVariable Property _SHHungerTimeStamp Auto Hidden

; Needs Level (Float)
GlobalVariable Property _SHCurrentHungerLevel Auto Hidden
GlobalVariable Property _SHCurrentThirstLevel Auto Hidden
GlobalVariable Property _SHCurrentFatigueLevel Auto Hidden

; Belly scale values
Float Property BellyScaleShs00 = 1.5 Auto Hidden
Float Property BellyScaleShs01 = 1.2 Auto Hidden
Float Property BellyScaleShs02 = 0.9 Auto Hidden
Float Property BellyScaleShs03 = 0.6 Auto Hidden
Float Property BellyScaleShs04 = 0.3 Auto Hidden
Float Property BellyScaleShs05 = 0.0 Auto Hidden
