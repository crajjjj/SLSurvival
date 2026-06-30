Scriptname mzinInterfaceOStim

; BUILD-ONLY STUB for SLSurvival compilation.
; The real implementation needs OStim's OThread/OActor/OMetadata types, which are not
; installed here (this setup uses SexLab, not OStim). The installed Bathing in Skyrim -
; Renewed .pex provides the real behavior at runtime; SLSurvival never calls these.
; Signatures preserved for the compile closure.

Actor[] Function GetActors(Int tid) Global
    Actor[] result
    return result
EndFunction

Float Function GetExcitementPercentage(Actor act) Global
    return 0.0
EndFunction

Bool Function IsActorActive(Actor act) Global
    return false
EndFunction

Bool Function IsActorVictim(Actor act, Int tid) Global
    return false
EndFunction

Bool Function IsSceneAggressive(Int tid) Global
    return false
EndFunction

Bool Function IsSceneSexual(String sid) Global
    return false
EndFunction

Bool Function IsSceneTransition(String sid) Global
    return false
EndFunction
