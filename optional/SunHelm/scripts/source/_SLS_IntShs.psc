Scriptname _SLS_IntShs Hidden 

; Hunger API =========================================================================
Function DecreaseHungerLevel(Float FoodPoints, Quest _SHHungerQuest) Global
    (_SHHungerQuest as _SHHungerSystem).DecreaseHungerLevel(FoodPoints)
EndFunction

Int Function GetHungerStage(Quest _SHHungerQuest) Global
    Return (_SHHungerQuest as _SHHungerSystem).CurrentHungerStage
EndFunction


; Thirst API =========================================================================
Function IncreaseThirstLevel(Float WaterPoints, Quest _SHThirstQuest) Global
    (_SHThirstQuest as _SHThirstSystem).IncreaseThirstLevel(WaterPoints)
Endfunction

Function DecreaseThirstLevel(Float WaterPoints, Quest _SHThirstQuest) Global
    (_SHThirstQuest as _SHThirstSystem).DecreaseThirstLevel(WaterPoints)
Endfunction    

Int Function GetThirstStage(Quest _SHThirstQuest) Global
    Return (_SHThirstQuest as _SHThirstSystem).CurrentThirstStage
EndFunction


; Fatigue API =========================================================================
Function ModFatigue(Float SleepAmount, Quest _SHFatigueQuest) Global ; +SleepAmount = Remove Fatigue. -SleepAmount = Add Fatigue
    If (SleepAmount >= 0.0) ; More Tired
        (_SHFatigueQuest as _SHFatigueSystem).IncreaseFatiguelevel(SleepAmount)
    Else ; Less Tired
        ; This function checks for Sunhelm specific sleep perks and applies bonuses on top
        ; Probably a good middle ground between SLS sleep deprivation and Sunhelm Fatigue System. 
        (_SHFatigueQuest as _SHFatigueSystem).DecreaseFatiguelevel(SleepAmount)
    EndIf
EndFunction

Int Function GetFatigueStage(Quest _SHFatigueQuest) Global
    Return (_SHFatigueQuest as _SHFatigueSystem).CurrentFatigueStage
EndFunction

; Gets the lower bound of each fatigue level
Int[] Function GetFatigueLevels(Quest _SHFatigueQuest) Global
    _SHFatigueSystem FatigueSystem = (_SHFatigueQuest as _SHFatigueSystem)
    Int[] FatigueLevels = new Int[6]
    FatigueLevels[0] = FatigueSystem._SHFatigueStage0
    FatigueLevels[1] = FatigueSystem._SHFatigueStage1
    FatigueLevels[2] = FatigueSystem._SHFatigueStage2
    FatigueLevels[3] = FatigueSystem._SHFatigueStage3
    FatigueLevels[4] = FatigueSystem._SHFatigueStage4
    FatigueLevels[5] = FatigueSystem._SHFatigueStage5
EndFunction