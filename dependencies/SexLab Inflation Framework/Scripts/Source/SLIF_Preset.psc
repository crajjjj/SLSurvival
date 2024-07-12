Scriptname SLIF_Preset Hidden

Int Function FloatListCount(String modName, String node) Global
	if (SLIF_Main.IsInMaintenance())
		return 0
	endIf
	string file = "SexLab Inflation Framework/Presets.json"
	modName = SLIF_Util.SplitAndJoinString(modName, " ", "_")
	node = SLIF_Util.SplitAndJoinString(node, "[", "(")
	node = SLIF_Util.SplitAndJoinString(node, "]", ")")
	return JsonUtil.PathCount(file, modName + node)
EndFunction

Bool Function FloatListHasValues(String modName, String node) Global
	if (SLIF_Main.IsInMaintenance())
		return false
	endIf
	return FloatListCount(modName, node) > 0
EndFunction

Function FloatListCopy(String modName, String node, float[] values) Global
	if (SLIF_Main.IsInMaintenance())
		return
	endIf
	string file = "SexLab Inflation Framework/Presets.json"
	modName = SLIF_Util.SplitAndJoinString(modName, " ", "_")
	node = SLIF_Util.SplitAndJoinString(node, "[", "(")
	node = SLIF_Util.SplitAndJoinString(node, "]", ")")
	JsonUtil.SetPathFloatArray(file, modName + node, values)
EndFunction

Float Function FloatListGet(String modName, String node, int index, float value = 0.0) Global
	if (SLIF_Main.IsInMaintenance())
		return value
	endIf
	string file = "SexLab Inflation Framework/Presets.json"
	modName = SLIF_Util.SplitAndJoinString(modName, " ", "_")
	node = SLIF_Util.SplitAndJoinString(node, "[", "(")
	node = SLIF_Util.SplitAndJoinString(node, "]", ")")
	return JsonUtil.GetPathFloatValue(file, modName + node + "[" + index + "]", value)
EndFunction

Function FloatListSet(String modName, String node, int index, float value) Global
	if (SLIF_Main.IsInMaintenance())
		return
	endIf
	string file = "SexLab Inflation Framework/Presets.json"
	modName = SLIF_Util.SplitAndJoinString(modName, " ", "_")
	if (!FloatListHasValues(modName, node))
		InitializePreset(modName, node)
	endIf
	node = SLIF_Util.SplitAndJoinString(node, "[", "(")
	node = SLIF_Util.SplitAndJoinString(node, "]", ")")
	JsonUtil.SetPathFloatValue(file, modName + node + "[" + index + "]", value)
EndFunction

Function InitializePreset(String modName, String node) Global
	if (SLIF_Main.IsInMaintenance())
		return
	endIf
	string file = "SexLab Inflation Framework/Presets.json"
	modName = SLIF_Util.SplitAndJoinString(modName, " ", "_")
	bool morph_modus = SLIF_Util.StartsWith(node, ".morphs.")
	float[] values = new float[5]
	values[0] = SLIF_Util.GetDefaultInflationType()
	values[1] = SLIF_Util.GetDefaultMinimum(morph_modus)
	values[2] = SLIF_Util.GetDefaultMaximum()
	values[3] = SLIF_Util.GetDefaultMultiplier()
	values[4] = SLIF_Util.GetDefaultIncrement()
	FloatListCopy(modName, node, values)
EndFunction
