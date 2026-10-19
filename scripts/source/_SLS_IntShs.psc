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
Function ModFatigue(Float SleepAmount, Quest _SHFatigueQuest) Global ; +SleepAmount = Add Fatigue (more tired). -SleepAmount = Remove Fatigue (matches the RND/iNeed adapters)
    If (SleepAmount >= 0.0) ; More Tired
        (_SHFatigueQuest as _SHFatigueSystem).IncreaseFatiguelevel(SleepAmount)
    Else ; Less Tired
        ; DecreaseFatigueLevel SUBTRACTS its argument, so it needs the magnitude - passing the
        ; raw negative here double-negated and ADDED fatigue instead (the pre-0.714 bug).
        ; It also applies SunHelm's own sleep perk bonuses on top, which is what we want.
        (_SHFatigueQuest as _SHFatigueSystem).DecreaseFatiguelevel(-SleepAmount)
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
    Return FatigueLevels ; Missing pre-0.714: the caller got None and every threshold read as 0
EndFunction


; Cold API ============================================================================
; Cold runs from 0 (warm) up to _SHColdLevelCap (900); stage floors 25/150/250/450/700.
Function DecreaseColdLevel(Float Amount, Quest _SHColdQuest) Global
    _SHColdSystem Cold = _SHColdQuest as _SHColdSystem
    If !Cold
        Return
    EndIf
    ; Not Cold.DecreaseColdLevel: away from a fire it floors the level at the area's cold
    ; limit, and a player still below that limit is snapped UP to it, so warming her would
    ; chill her. Body heat warms like a fire does, down to 0; SunHelm's own tick then climbs
    ; back toward the area's limit.
    Float OldLevel = Cold._SHCurrentColdLevel.GetValue()
    Float Level = OldLevel - Amount
    If Level < 0.0
        Level = 0.0
    EndIf
    If Level == OldLevel
        Return
    EndIf
    Int OldStage = Cold.CurrentColdStage
    Cold._SHCurrentColdLevel.SetValue(Level)
    Cold.SetColdStage()
    ; Not SetColdLevel either: its ApplyColdEffects ends in CheckColdDamage, which hurts at
    ; stage 5 on every call, so a warming tick every 3 s would bite while still Freezing.
    ; Effects only need refreshing when the stage moves, and warming never moves INTO stage 5.
    If Cold.CurrentColdStage != OldStage
        Cold.ApplyColdEffects()
    EndIf
EndFunction

Function IncreaseColdLevel(Float Amount, Quest _SHColdQuest) Global
    ; never colder than the area's limit, like SunHelm's own tick
    (_SHColdQuest as _SHColdSystem).IncreaseColdLevel(Amount)
EndFunction