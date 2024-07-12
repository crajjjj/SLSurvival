Scriptname SLIF_Config Hidden

int function ModCount() global
	return JsonUtil.StringListCount("SexLab Inflation Framework/Modlist.json", "mod_list")
endFunction

String function GetMod(int index) global
	return JsonUtil.StringListGet("SexLab Inflation Framework/Modlist.json", "mod_list", index)
endFunction

int function FindMod(String modName) global
	return JsonUtil.StringListFind("SexLab Inflation Framework/Modlist.json", "mod_list", modName)
endFunction

bool function HasMod(String modName) global
	return JsonUtil.StringListHas("SexLab Inflation Framework/Modlist.json", "mod_list", modName)
endFunction

bool function InsertMod(String modName, int index) global
	String file  = "SexLab Inflation Framework/Modlist.json"
	bool success = JsonUtil.StringListInsertAt(file, "mod_list", index, modName)
	SLIF_Util.SaveJson(file)
	return success
endFunction

bool function AddMod(String modName) global
	String file  = "SexLab Inflation Framework/Modlist.json"
	bool success = JsonUtil.StringListAdd(file, "mod_list", modName, false) != -1
	SLIF_Util.SaveJson(file)
	return success
endFunction

bool function CanResolvePath(String path, String sKey) global
	return JsonUtil.CanResolvePath("SexLab Inflation Framework/Config.json", (path + sKey))
endFunction

float function GetPathFloat(String path, String sKey, float default = 0.0) global
	return JsonUtil.GetPathFloatValue("SexLab Inflation Framework/Config.json", (path + sKey), default)
endFunction

function SetPathFloat(String path, String sKey, float value) global
	JsonUtil.SetPathFloatValue("SexLab Inflation Framework/Config.json", (path + sKey), value)
endFunction

function SetPathFloatArray(String path, String sKey, float[] values) global
	JsonUtil.SetPathFloatArray("SexLab Inflation Framework/Config.json", (path + sKey), values)
endFunction

int function GetPathInt(String path, String sKey, int default = 0) Global
	return JsonUtil.GetPathIntValue("SexLab Inflation Framework/Config.json", (path + sKey), default)
endFunction

function SetPathInt(String path, String sKey, int value) global
	JsonUtil.SetPathIntValue("SexLab Inflation Framework/Config.json", (path + sKey), value)
endFunction

function SetPathIntArray(String path, String sKey, int[] values) global
	JsonUtil.SetPathIntArray("SexLab Inflation Framework/Config.json", (path + sKey), values)
endFunction

function SetInflationType(String modName, int value) Global
	modName = SLIF_Util.SplitAndJoinString(modName, " ", "_")
	JsonUtil.SetPathIntValue("SexLab Inflation Framework/Config.json", ".inflation_type." + modName, value)
endFunction

int function GetInflationType(String modName, int default = 0) Global
	modName = SLIF_Util.SplitAndJoinString(modName, " ", "_")
	return JsonUtil.GetPathIntValue("SexLab Inflation Framework/Config.json", ".inflation_type." + modName, default)
endFunction

function SetInt(String sKey, int value) Global
	JsonUtil.SetIntValue("SexLab Inflation Framework/Config.json", sKey, value)
endFunction

function SetFloat(String sKey, float value) Global
	JsonUtil.SetFloatValue("SexLab Inflation Framework/Config.json", sKey, value)
endFunction

function SetString(String sKey, String value) Global
	JsonUtil.SetStringValue("SexLab Inflation Framework/Config.json", sKey, value)
endFunction

function SetForm(String sKey, Form value) Global
	JsonUtil.SetFormValue("SexLab Inflation Framework/Config.json", sKey, value)
endFunction

int function GetInt(String sKey, int missing = 0) Global
	return JsonUtil.GetIntValue("SexLab Inflation Framework/Config.json", sKey, missing)
endFunction

float function GetFloat(String sKey, float missing = 0.0) Global
	return JsonUtil.GetFloatValue("SexLab Inflation Framework/Config.json", sKey, missing)
endFunction

String function GetString(String sKey, String missing = "") Global
	return JsonUtil.GetStringValue("SexLab Inflation Framework/Config.json", sKey, missing)
endFunction

Form function GetForm(String sKey, Form missing = none) Global
	return JsonUtil.GetFormValue("SexLab Inflation Framework/Config.json", sKey, missing)
endFunction

bool function HasInt(String sKey) Global
	return JsonUtil.HasIntValue("SexLab Inflation Framework/Config.json", sKey)
endFunction

bool function HasFloat(String sKey) Global
	return JsonUtil.HasFloatValue("SexLab Inflation Framework/Config.json", sKey)
endFunction

bool function HasString(String sKey) Global
	return JsonUtil.HasStringValue("SexLab Inflation Framework/Config.json", sKey)
endFunction

bool function HasForm(String sKey) Global
	return JsonUtil.HasFormValue("SexLab Inflation Framework/Config.json", sKey)
endFunction
