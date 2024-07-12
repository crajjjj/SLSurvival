Scriptname SLIF_Morphs Hidden

bool function HasValue(String type, String path, String morph, int category, bool player) global
	String json = GetJsonFromType(type)
	int idx = ((category * 2) + ((!player) as int)) as int
	return JsonUtil.CanResolvePath(json, path + morph + "[" + idx + "]")
endFunction

float function GetValue(String type, String path, String morph, int category, bool player, float default = 0.0) global
	String json = GetJsonFromType(type)
	int idx = ((category * 2) + ((!player) as int)) as int
	return JsonUtil.GetPathFloatValue(json, path + morph + "[" + idx + "]", default)
endFunction

function SetValue(String type, String path, String morph, int category, bool player, float value) global
	String json = GetJsonFromType(type)
	Float[] arr = Utility.CreateFloatArray(2)
	if (type != "NiOverride")
		arr = Utility.CreateFloatArray(10)
		arr[0] = JsonUtil.GetPathFloatValue(json, path + morph + "[0]",  0.0)
		arr[1] = JsonUtil.GetPathFloatValue(json, path + morph + "[1]",  0.0)
		arr[2] = JsonUtil.GetPathFloatValue(json, path + morph + "[2]",  0.0)
		arr[3] = JsonUtil.GetPathFloatValue(json, path + morph + "[3]",  0.0)
		arr[4] = JsonUtil.GetPathFloatValue(json, path + morph + "[4]", 10.0)
		arr[5] = JsonUtil.GetPathFloatValue(json, path + morph + "[5]", 10.0)
		arr[6] = JsonUtil.GetPathFloatValue(json, path + morph + "[6]",  0.0)
		arr[7] = JsonUtil.GetPathFloatValue(json, path + morph + "[7]",  0.0)
		arr[8] = JsonUtil.GetPathFloatValue(json, path + morph + "[8]", 20.0)
		arr[9] = JsonUtil.GetPathFloatValue(json, path + morph + "[9]", 20.0)
	else
		arr[0] = JsonUtil.GetPathFloatValue(json, path + morph + "[0]",  0.0)
		arr[1] = JsonUtil.GetPathFloatValue(json, path + morph + "[1]",  0.0)
	endIf
	if (!HasValue(type, path, morph, category, player))
		JsonUtil.SetPathFloatArray(json, path + morph, arr)
	endIf
	int idx = ((category * 2) + ((!player) as int)) as int
	JsonUtil.SetPathFloatValue(json, path + morph + "[" + idx + "]", value)
	SLIF_Util.SaveJson(json)
endFunction

bool function CanResolve(String type, String path, String morph) global
	String json = GetJsonFromType(type)
	return JsonUtil.CanResolvePath(json, path + morph)
endFunction
	
function SetArray(String type, String path, String morph, float[] arr) global
	String json = GetJsonFromType(type)
	JsonUtil.SetPathFloatArray(json, path + morph, arr)
	SLIF_Util.SaveJson(json)
endFunction

String function GetJsonFromType(String type) global
	if (type == "NiOverride")
		return "SexLab Inflation Framework/NiOverride_Settings.json"
	endIf
	return "SexLab Inflation Framework/Bodymorph_Settings.json"
endFunction
