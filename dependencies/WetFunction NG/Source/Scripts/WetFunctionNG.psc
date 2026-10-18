Scriptname WetFunctionNG Hidden

; Compile-time header for _SLS_IntWfng only, never shipped: WetFunction NG's own script provides these
; natives at runtime. Not the mod's source - the signatures were read off the WetFunction NG calls in a
; compiled _SLS_IntWfng.pex built against the real header (SL Survival Repack 0.716.1-alpha1). Keep the
; argument counts as they are: the VM rejects a native call whose argument count differs.

Float Function GetWetness(Actor akActor) Global Native
Float Function GetWetnessCap() Global Native
Function SetWetness(Actor akActor, Float afWetness) Global Native
