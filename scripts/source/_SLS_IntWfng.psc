Scriptname _SLS_IntWfng Hidden
{WetFunction NG wrappers - the only place referencing WetFunctionNG's natives. Callers gate on
Game.GetModByName("WetFunctionNG.esp"): a call into a script that is not installed aborts the caller.
WetFunction NG keeps wetness from 0 to its own cap (GetWetnessCap, 10 by default).}

Float Function GetWetness(Actor akActor) Global
	Return WetFunctionNG.GetWetness(akActor)
EndFunction

Float Function GetWetnessCap() Global
	Return WetFunctionNG.GetWetnessCap()
EndFunction

Function SetWetness(Actor akActor, Float afWetness) Global
	WetFunctionNG.SetWetness(akActor, afWetness)
EndFunction
