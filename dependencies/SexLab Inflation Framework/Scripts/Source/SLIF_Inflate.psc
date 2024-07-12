Scriptname SLIF_Inflate Hidden

Bool Function HasScale(Actor kActor, String ModName, String Type) Global
	if (Type == "Breast")
		return SLIF_Main.HasScale(kActor, ModName, "NPC L Breast")
	elseIf (Type == "Belly")
		return SLIF_Main.HasScale(kActor, ModName, "NPC Belly")
	elseIf (Type == "Butt")
		return SLIF_Main.HasScale(kActor, ModName, "NPC L Butt")
	elseIf (Type == "NPC")
		return SLIF_Main.HasScale(kActor, ModName, "NPC")
	endIf
	return false
EndFunction

Float Function GetScale(Actor kActor, String ModName, String Type, float default = 1.0) Global
	if (Type == "Breast")
		return SLIF_Main.GetValue(kActor, ModName, "NPC L Breast",   default)
	elseIf (Type == "Belly")
		return SLIF_Main.GetValue(kActor, ModName, "NPC Belly",      default)
	elseIf (Type == "Butt")
		return SLIF_Main.GetValue(kActor, ModName, "NPC L Butt",     default)
	elseIf (Type == "NPC")
		return SLIF_Main.GetValue(kActor, ModName, "NPC",            default)
	endIf
	return default
EndFunction

Float Function SetScale(Actor kActor, String ModName, String Type, float value) Global
	if (Type == "Breast")
		SLIF_Main.inflate(kActor, ModName, "slif_breast",   value)
	elseIf (Type == "Belly")
		SLIF_Main.inflate(kActor, ModName, "NPC Belly",     value)
	elseIf (Type == "Butt")
		SLIF_Main.inflate(kActor, ModName, "slif_butt",     value)
	elseIf (Type == "NPC")
		SLIF_Main.inflate(kActor, ModName, "NPC",           value)
	endIf
	return value
EndFunction

Float Function Inflate(Actor kActor, String ModName, String Type, float Value, float Max, float Default) Global
	float newValue = GetScale(kActor, ModName, Type, Default)
	newValue += Value
	If newValue > Max
		newValue = Max
	EndIf
	return SetScale(kActor, ModName, Type, newValue)
EndFunction

Float Function Deflate(Actor kActor, String ModName, String Type, float Value, float Min, float Default) Global
	float newValue = SLIF_Inflate.GetScale(kActor, ModName, Type, Default)
	newValue -= Value
	If newValue < Min
		newValue = Min
	EndIf
	return SetScale(kActor, ModName, Type, newValue)
EndFunction
