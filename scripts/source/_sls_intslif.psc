Scriptname _SLS_IntSlif Hidden

Function Inflate(Actor akTarget, String ModNameAppend = "", String NodeName, Float Value) Global
	SLIF_Main.Inflate(akTarget, "Sexlab Survival" + ModNameAppend, NodeName, Value, -1, -1)
EndFunction

Function Morph(Actor akTarget, String ModNameAppend = "", String MorphName, Float Value) Global
	SLIF_Morph.Morph(akTarget, "Sexlab Survival" + ModNameAppend, MorphName, Value)
EndFunction

Function UnRegisterActor(Actor akTarget, String ModNameAppend) Global
	SLIF_Main.UnRegisterActor(akTarget, "Sexlab Survival" + ModNameAppend)
EndFunction

Float Function GetInflateValue(Actor akTarget, String ModNameAppend = "", String NodeName) Global
	Return SLIF_Main.GetValue(akTarget, "Sexlab Survival" + ModNameAppend, NodeName)
EndFunction

Float Function GetMorphValue(Actor akTarget, String ModNameAppend, String MorphName) Global
	Return SLIF_Morph.GetValue(akTarget, "Sexlab Survival" + ModNameAppend, MorphName)
EndFunction

Float Function GetTotalInflateValue(Actor akTarget, String NodeName) Global
	Return SLIF_Main.GetValue(akTarget, "All Mods", NodeName)
EndFunction

Float Function GetTotalMorphValue(Actor akTarget, String MorphName) Global ; Doesn't seem to work....
	Return SLIF_Morph.GetValue(akTarget, "All Mods", MorphName, -1.0)
EndFunction
