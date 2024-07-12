Scriptname SLIF_Util Hidden

;/
	Only use functions in this script, if you know, what you are doing,
	they are mostly internally used functions by SLIF_Main
	and are normally not recommended to call directly.
/;
;Game.GetModbyName("SexLab Inflation Framework.esp") != 255
Bool Function isModInstalled(String mod) Global
	Return Game.GetModbyName(mod) != 255
Endfunction

Bool Function validParameters(String modName, String node) Global
	Return SLIF_Main.IsInstalled() && !IsEmpty(modName) && !IsEmpty(node)
EndFunction

int Function GetListSize(String list_type, String list) Global
	String file = "SexLab Inflation Framework/Lists.json"
	if (list_type == "stringList")
		return JsonUtil.StringListCount(file, list)
	endIf
	return JsonUtil.PathStringElements(file, "." + list_type + "." + list).length
EndFunction

String Function GetListEntry(String list_type, String list, int index) Global
	String file = "SexLab Inflation Framework/Lists.json"
	if (list_type == "stringList")
		return JsonUtil.StringListGet(file, list, index)
	endIf
	return JsonUtil.GetPathStringValue(file, "." + list_type + "." + list + "[" + index + "]")
EndFunction

bool function HasListEntry(String list_type, String list, String entry) global
	return FindListEntry(list_type, list, entry) != -1
endFunction

int Function FindListEntry(String list_type, String list, String entry) Global
	String file = "SexLab Inflation Framework/Lists.json"
	if (list_type == "stringList")
		return JsonUtil.StringListFind(file, list, entry)
	endIf
	int i = 0
	int count = JsonUtil.PathStringElements(file, "." + list_type + "." + list).length
	while (i < count)
		if (entry == JsonUtil.GetPathStringValue(file, "." + list_type + "." + list + "[" + i + "]"))
			return i
		endIf
		i += 1
	endWhile
	return -1
EndFunction

Bool Function RemoveEntry(String list_type, String list, String entry) Global
	String file = "SexLab Inflation Framework/Lists.json"
	if (!HasListEntry(list_type, list, entry))
		return false
	endIf
	if (list_type == "stringList")
		return JsonUtil.StringListRemove(file, list, entry) > 0
	endIf
	String[] arr = JsonUtil.PathStringElements(file, "." + list_type + "." + list)
	int count = arr.length
	int i = 0
	int index = -1
	while(i < count)
		if (arr[i] == entry)
			index = i
			i = count
		endIf
		i += 1
	endWhile
	int temp_count = count - 1
	String[] temp = Utility.CreateStringArray(temp_count)
	if (index != -1)
		i = 0
		while(i < temp_count)
			if (i < index)
				temp[i] = arr[i]
			else
				temp[i] = arr[(i + 1)]
			endIf
			i += 1
		endWhile
		JsonUtil.SetPathStringArray(file, "." + list_type + "." + list, temp)
		return true
	endIf
	return false
EndFunction

Bool Function AddEntry(String list_type, String list, String entry) Global
	String file = "SexLab Inflation Framework/Lists.json"
	if (HasListEntry(list_type, list, entry))
		return false
	endIf
	if (list_type == "stringList")
		JsonUtil.StringListAdd(file, list, entry, false)
		return true
	endIf
	String[] temp = new String[1]
	temp[0] = entry
	JsonUtil.SetPathStringArray(file, "." + list_type + "." + list, temp, true)
	return true
EndFunction

Function SetList(String list_type, String list, String[] arr) Global
	String file = "SexLab Inflation Framework/Lists.json"
	if (list_type == "stringList")
		JsonUtil.StringListCopy(file, list, arr)
		return
	endIf
	JsonUtil.SetPathStringArray(file, "." + list_type + "." + list, arr)
EndFunction

String[] Function GetList(String list_type, String list) Global
	String file = "SexLab Inflation Framework/Lists.json"
	if (list_type == "stringList")
		return JsonUtil.StringListToArray(file, list)
	endIf
	return JsonUtil.PathStringElements(file, "." + list_type + "." + list)
EndFunction

String[] Function GetLists(String list_type) Global
	String file = "SexLab Inflation Framework/Lists.json"
	return JsonUtil.PathMembers(file, "." + list_type + ".")
EndFunction

String Function GetListByCategory(String list_type, int category) Global
	return GetLists(list_type)[category]
EndFunction

string function GetSyncKeyFromNodes(String leftNode, String rightNode) global
	int leftIndex  = FindListEntry("stringList", "left_nodes",  leftNode)
	int rightIndex = FindListEntry("stringList", "right_nodes", rightNode)
	if (leftIndex != -1 && rightIndex != -1 && leftIndex == rightIndex)
		return GetListEntry("stringList", "sync_keys", leftIndex)
	endIf
	return ""
endFunction

int function GetSyncIndexFromNode(String node) global
	int leftIndex  = FindListEntry("stringList", "left_nodes",  node)
	int rightIndex = FindListEntry("stringList", "right_nodes", node)
	if (leftIndex != -1)
		return leftIndex
	elseIf (rightIndex != -1)
		return rightIndex
	endIf
	return -1
endFunction

string function GetSyncKeyFromNode(String node) global
	int leftIndex  = FindListEntry("stringList", "left_nodes",  node)
	int rightIndex = FindListEntry("stringList", "right_nodes", node)
	if (leftIndex != -1)
		return GetListEntry("stringList", "sync_keys", leftIndex)
	elseIf (rightIndex != -1)
		return GetListEntry("stringList", "sync_keys", rightIndex)
	endIf
	return ""
endFunction

String Function ConvertToSyncKey(String syncKey) Global
	if (syncKey == "slif_breasts")
		return "slif_breast"
	elseIf (syncKey == "slif_breasts01")
		return "slif_breast01"
	elseIf (syncKey == "slif_breasts_p1")
		return "slif_breast_p1"
	elseIf (syncKey == "slif_breasts_p2")
		return "slif_breast_p2"
	elseIf (syncKey == "slif_breasts_p3")
		return "slif_breast_p3"
	elseIf (syncKey == "slif_breasts_p")
		return "slif_breast_p"
	elseIf (syncKey == "slif_prebreasts")
		return "slif_prebreast"
	endIf
	return syncKey
EndFunction

bool function IgnoreKey(String sKey) Global
	return JsonUtil.StringListFind("SexLab Inflation Framework/Lists.json", "ignore_keys", sKey) != -1
endFunction

Int Function GetDefaultInflationType() Global
	return 1
EndFunction

Float Function GetDefaultMinimum(bool morph_modus) Global
	if (morph_modus)
		return -100.0
	endIf
	return 0.0
EndFunction

Float Function GetDefaultMaximum() Global
	return 100.0
EndFunction

Float Function GetDefaultMultiplier() Global
	return 1.0
EndFunction

Float Function GetDefaultIncrement() Global
	return 0.1
EndFunction

float function InflateZero(String modName, String sKey, float value) global
	return value
endFunction

bool function InflateInstant(String modName, String node) global
	return SLIF_Preset.FloatListGet(modName, "." + node, 0, GetDefaultInflationType()) as bool
endFunction

function inflateNode(Actor kActor, String aToString, String modName, String node, float oldValue, float value) global
	
	if (kActor)
		if (InflateInstant(modName, node))
			InflateNodeInstant(kActor, aToString, modName, node, oldValue, value)
		else
			SLIF_Calc.AddToQueue(kActor, aToString, modName, node, value)
			
			SLIF_Calc.StartQueue(kActor, aToString, modName, node)
		endIf
	endIf
	
endFunction

function inflateNodes(Actor kActor, String aToString, String modName, String syncKey, String leftNode, String rightNode, float oldValue, float value) global
	
	if (kActor)
		if (InflateInstant(modName, leftNode) || InflateInstant(modName, rightNode))
			InflateTwoNodesInstant(kActor, aToString, modName, leftNode, rightNode, oldValue, value)
		else
			SLIF_Calc.AddToQueue(kActor, aToString, modName, syncKey, value)
			
			SLIF_Calc.DoSyncQueue(kActor, aToString, modName, syncKey, leftNode, rightNode)
		endIf
	endIf
	
endFunction

;/
	float[] Function CreateFloatArray(int size, float fill = 0.0) global native
	int[] Function CreateIntArray(int size, int fill = 0) global native
	bool[] Function CreateBoolArray(int size, bool fill = false) global native
	string[] Function CreateStringArray(int size, string fill = "") global native
	Form[] Function CreateFormArray(int size, Form fill = None) global native
	Alias[] Function CreateAliasArray(int size, Alias fill = None) global native
/;

function inflateMultipleNodes(Actor kActor, String aToString, String modName, String[] nodes, float[] oldValues, float[] values) global
	
	if (kActor)
		
				 nodes = SLIF_Main.ConvertMultipleToNode(nodes)
		int size       = nodes.length
		
		int currentIndex = 0
		
		String[] tempSyncKeys   = Utility.CreateStringArray(size)
		String[] tempLeftNodes  = Utility.CreateStringArray(size)
		String[] tempRightNodes = Utility.CreateStringArray(size)
		Float[] tempOldValues   = Utility.CreateFloatArray(size)
		Float[] tempValues      = Utility.CreateFloatArray(size)
		
		int i = 0
		while(i < size)
			int syncIndex        = GetSyncIndexFromNode(nodes[i])
			if (syncIndex != -1)
				String syncKey   = GetListEntry("stringList", "sync_keys",   syncIndex)
				String leftNode  = GetListEntry("stringList", "left_nodes",  syncIndex)
				String rightNode = GetListEntry("stringList", "right_nodes", syncIndex)
				int index        = -1
				if (HasListEntry("stringList", "left_nodes", nodes[i]))
					index        = nodes.Find(rightNode)
				elseIf (HasListEntry("stringList", "right_nodes", nodes[i]))
					index        = nodes.Find(leftNode)
				endIf
				if (index > i)
					tempSyncKeys[currentIndex]   = syncKey
					tempLeftNodes[currentIndex]  = leftNode
					tempRightNodes[currentIndex] = rightNode
					tempOldValues[currentIndex]  = SLIF_Math.Average(oldValues[i], oldValues[index])
					tempValues[currentIndex]     = SLIF_Math.Average(values[i], values[index])
					currentIndex += 1
				endIf
			else
				inflateNode(kActor, aToString, modName, nodes[i], oldValues[i], values[i])
			endIf
			i += 1
		endWhile
		
		i = 0
		while(i < size)
			if (tempSyncKeys[i] != "")
				inflateNodes(kActor, aToString, modName, tempSyncKeys[i], tempLeftNodes[i], tempRightNodes[i], tempOldValues[i], tempValues[i])
				i += 1
			else
				return
			endIf
		endWhile
		
	endIf
	
endFunction

function InflateNodeInstant(Actor kActor, String aToString, String modName, String node, float oldValue, float value) global
	RemoveModEntriesFromQueue(kActor, node, modName)
;	float currentValue = StorageUtil.GetFloatValue(kActor, modName + node, 0)
;	float difference = 0
;	if (value != currentValue)
	float difference = SLIF_Calc.calculateValue(kActor, aToString, modName, node, value)
;	endIf
	SLIF_Scale.SetNodeScale(kActor, aToString, node, (oldValue + difference))
endFunction

function InflateTwoNodesInstant(Actor kActor, String aToString, String modName, String leftNode, String rightNode, float oldValue, float value) global
	int leftIndex  = FindListEntry("stringList", "left_nodes",  leftNode)
	int rightIndex = FindListEntry("stringList", "right_nodes", rightNode)
	if (leftIndex != -1)
		RemoveModEntriesFromQueue(kActor, GetListEntry("stringList", "left_nodes",  leftIndex),  modName)
	endIf
	if (rightIndex != -1)
		RemoveModEntriesFromQueue(kActor, GetListEntry("stringList", "right_nodes", rightIndex), modName)
	endIf
	RemoveModEntriesFromQueue(kActor, leftNode,  modName)
	RemoveModEntriesFromQueue(kActor, rightNode, modName)
;	float leftCurrentValue  = StorageUtil.GetFloatValue(kActor, modName + leftNode,  0)
;	float rightCurrentValue = StorageUtil.GetFloatValue(kActor, modName + rightNode, 0)
;	float leftDifference  = 0
;	float rightDifference = 0
;	if (leftCurrentValue != value || rightCurrentValue != value)
	float leftDifference  = SLIF_Calc.calculateValue(kActor, aToString, modName, leftNode,  value)
	float rightDifference = SLIF_Calc.calculateValue(kActor, aToString, modName, rightNode, value)
;	endIf
	float leftValue  = oldValue + leftDifference
	float rightValue = oldValue + rightDifference
	SLIF_Scale.SetNodeScales(kActor, aToString, leftNode, rightNode, leftValue, rightValue)
endFunction

bool function HasScale(Actor kActor, String node, String list = "slif_mod_list") global
	int count = StorageUtil.StringListCount(kActor, list)
	int i = 1
	while (i < count)
		String mod = StorageUtil.StringListGet(kActor, list, i) as String
		if (mod == "SL Inflation Framework")
			if (StorageUtil.GetFloatValue(kActor, mod + node, 0.0) != 0.0)
				return true
			endIf
		else
			if (StorageUtil.HasFloatValue(kActor, mod + node))
				return true
			endIf
		endIf
		i += 1
	endWhile
	return false
endFunction

bool function registerSLIF(Actor kActor, String name, String aToString) global
	bool isPlayer    = SLIF_Scale.IsPlayer(kActor)
	bool auto_npc    = SLIF_Config.GetInt("auto_register_slif") as bool
	bool auto_player = SLIF_Config.GetInt("auto_register_slif_player") as bool
	if ((isPlayer && auto_player) || (!isPlayer && auto_npc))
		registerModComplete(kActor, name, aToString, "SL Inflation Framework")
		return true
	endIf
	return false
endFunction

function registerModComplete(Actor kActor, String name, String aToString, String modName) global
	registerMod(kActor, name, aToString, modName)
	
	int count = GetListSize("node_lists", "000_nodes")
	int i = 0
	while (i < count)
		String node = GetListEntry("node_lists", "000_nodes", i)
		if (!StorageUtil.HasFloatValue(kActor, modName + node))
			SetFloatValue(kActor, modName, node,   0.0, "",           false)
			SetFloatValue(kActor, modName, node,   0.0, "_min",       false)
			SetFloatValue(kActor, modName, node, 100.0, "_max",       false)
			SetFloatValue(kActor, modName, node,   1.0, "_mult",      false)
			SetFloatValue(kActor, modName, node,   0.1, "_increment", false)
		endIf
		if (!StorageUtil.HasFloatValue(kActor, "All Mods" + node))
			SetAllModsKey(kActor, node)
		endIf
		i += 1
	endWhile
endFunction

function registerMod(Actor kActor, String name, String aToString, String modName) global
	if (!StorageUtil.HasIntValue(kActor, modName + "slif_initialize"))
		SetIntValueConditional(kActor, modName    + "slif_initialize", 1)
		SetIntValueConditional(kActor, "All Mods" + "slif_initialize", 1)
		AddModToList(kActor, modName)
		SLIF_Debug.Notification(SLIF_Language.TargetRegistered(name, modName))
		SLIF_Debug.Trace("[SLIF_Util] Registering Actor:    " + aToString + " for mod " + modName)
	endIf
endFunction

function unregisterMod(Actor kActor, String aToString, string modName) global
	SLIF_Debug.Trace("[SLIF_Util] Unregistering Actor:  " + aToString + " for mod " + modName)
	
	int count = GetListSize("node_lists", "000_nodes")
	int i = 0
	while (i < count)
		String node = GetListEntry("node_lists", "000_nodes", i)
		unregisterNode(kActor, aToString, node, modName)
		i += 1
	endWhile
endFunction

function unregisterActorForAllMods(Actor kActor, String aToString) global
	
	UnsetIntValueConditional(kActor, "slif_gender")
	RemoveActorFromList(kActor, aToString)
	
	StorageUtil.StringListClear(kActor, "slif_mod_list")
	
	UnsetIntValueConditional(kActor, "slif_mod_list_count")
	
	UnsetIntValueConditional(kActor, "All Mods" + "slif_initialize")
	
	int count = GetListSize("node_lists", "000_nodes")
	int i = 0
	while (i < count)
		String node = GetListEntry("node_lists", "000_nodes", i)
		SLIF_Scale.RemoveNodeScale(kActor, aToString, node, "SexLab Inflation Framework.esp")
		UnsetAllModsKey(kActor, node)
		i += 1
	endWhile
	
endFunction

function updateNodes(Actor kActor, String aToString, String modName, String node, String oldModName, float minimum, float maximum, float multiplier, float increment) global
	if (node != "")
		int syncIndex = FindListEntry("stringList", "sync_keys", node)
		if (syncIndex != -1)
			updateSyncKeys(kActor, aToString, modName, syncIndex, oldModName, minimum, maximum, multiplier, increment)
		else
			updateNode(kActor, aToString, modName, node, oldModName, minimum, maximum, multiplier, increment)
		endIf
	else
		int count = StorageUtil.StringListCount(kActor, modName + "slif_node_list")
		int i = 0
		while (i < count)
			String tempNode = StorageUtil.StringListGet(kActor, modName + "slif_node_list", i)
			updateNodes(kActor, aToString, modName, tempNode, oldModName, minimum, maximum, multiplier, increment)
			i += 1
		endWhile
	endIf
endFunction

float function GetValueByCalculationType(Actor kActor, String node) Global
	int calculation_type = SLIF_Config.GetInt("calculation_type")
	
	bool calculation_type_top_x         = calculation_type == 0
	bool calculation_type_highest_wins  = calculation_type == 1
	bool calculation_type_substract_one = calculation_type == 2
	bool calculation_type_square_root   = calculation_type == 3
	bool calculation_type_average       = calculation_type == 4
	bool calculation_type_additive      = calculation_type == 5
	
	if (calculation_type_top_x)
		return StorageUtil.GetFloatValue(kActor, "All Mods" + node + "_top_x",         1.0)
	elseIf (calculation_type_highest_wins)
		return StorageUtil.GetFloatValue(kActor, "All Mods" + node + "_highest_wins",  1.0)
	elseIf (calculation_type_substract_one)
		return StorageUtil.GetFloatValue(kActor, "All Mods" + node + "_substract_one", 1.0)
	elseIf (calculation_type_square_root)
		return StorageUtil.GetFloatValue(kActor, "All Mods" + node + "_square_root",   1.0)
	elseIf (calculation_type_average)
		return StorageUtil.GetFloatValue(kActor, "All Mods" + node + "_average",       1.0)
	elseIf (calculation_type_additive)
		return StorageUtil.GetFloatValue(kActor, "All Mods" + node + "_additive",      1.0)
	endIf
	return 1.0
endFunction

function updateSyncKeys(Actor kActor, String aToString, String modName, int syncIndex, String oldModName, float minimum, float maximum, float multiplier, float increment) global
	String syncKey     = GetListEntry("stringList", "sync_keys",   syncIndex)
	String leftNode    = GetListEntry("stringList", "left_nodes",  syncIndex)
	String rightNode   = GetListEntry("stringList", "right_nodes", syncIndex)
	updateDefaultValues(kActor, modName, leftNode,  minimum, maximum, multiplier, increment)
	updateDefaultValues(kActor, modName, rightNode, minimum, maximum, multiplier, increment)
	bool hasLeftScale  = StorageUtil.HasFloatValue(kActor, "SexLab Inflation Framework.esp" + leftNode)
	bool hasRightScale = StorageUtil.HasFloatValue(kActor, "SexLab Inflation Framework.esp" + rightNode)
	if (hasLeftScale && hasRightScale)
		float start = Utility.GetCurrentRealTime()
		if (oldModName != "")
			SLIF_Scale.RemoveNodeScale(kActor, aToString, leftNode,  oldModName)
			SLIF_Scale.RemoveNodeScale(kActor, aToString, rightNode, oldModName)
		endIf
		float leftValue  = StorageUtil.GetFloatValue(kActor, "SexLab Inflation Framework.esp" + leftNode,  1.0)
		float rightValue = StorageUtil.GetFloatValue(kActor, "SexLab Inflation Framework.esp" + rightNode, 1.0)
		float value      = SLIF_Math.Average(leftValue, rightValue)
		SLIF_Scale.SetNodeScales(kActor, aToString, leftNode, rightNode, leftValue, rightValue)
		float end = Utility.GetCurrentRealTime()
		SLIF_Debug.Trace("[SLIF_Util] Updating Nodes:       " + aToString + " node: " + syncKey + ", value: " + value + ", time_diff: " + (end - start))
	endIf
endFunction

function updateNode(Actor kActor, String aToString, String modName, String node, String oldModName, float minimum, float maximum, float multiplier, float increment) global
	node = SLIF_Main.ConvertToNode(node)
	updateDefaultValues(kActor, modName, node, minimum, maximum, multiplier, increment)
	if (StorageUtil.HasFloatValue(kActor, "SexLab Inflation Framework.esp" + node))
		float start = Utility.GetCurrentRealTime()
		if (oldModName != "")
			SLIF_Scale.RemoveNodeScale(kActor, aToString, node, oldModName)
		endIf
		float value = StorageUtil.GetFloatValue(kActor, "SexLab Inflation Framework.esp" + node, 1.0)
		SLIF_Scale.SetNodeScale(kActor, aToString, node, value)
		float end = Utility.GetCurrentRealTime()
		SLIF_Debug.Trace("[SLIF_Util] Updating Node:        " + aToString + " node: " + node + ", value: " + value + ", time_diff: " + (end - start))
	endIf
endFunction

function StringListAdd(Actor kActor, String modName, String node) global
	StorageUtil.StringListAdd(kActor, modName + "slif_node_list", node, false)
endFunction

function StringListRemove(Actor kActor, String modName, String node) global
	StorageUtil.StringListRemove(kActor, modName + "slif_node_list", node)
endFunction

function UnsetFloatValue(Actor kActor, String modName, String node, String suffix = "") global
	UnsetFloatValueConditional(kActor, modName + node + suffix)
endFunction

float function SetFloatValue(Actor kActor, String modName, String node, float value, String suffix = "", bool replace = true) global
	SetFloatValueConditional(kActor, modName + node + suffix, value, replace)
	return value
endFunction

function RemoveModEntriesFromQueue(Actor kActor, String node, String modName, bool leaveOne = false) global
	if (leaveOne)
		while(StorageUtil.StringListCountValue(kActor, node + "slif_queue_mods", modName) > 1)
			RemoveModEntryFromQueue(kActor, node, modName)
		endWhile
	else
		while(StorageUtil.StringListHas(kActor, node + "slif_queue_mods", modName))
			RemoveModEntryFromQueue(kActor, node, modName)
		endWhile
	endIf
endFunction

function RemoveModEntryFromQueue(Actor kActor, String node, String modName) global
	int index = StorageUtil.StringListFind(kActor, node + "slif_queue_mods", modName)
	if (index != -1)
		StorageUtil.StringListRemoveAt(kActor, node + "slif_queue_mods",   index)
		StorageUtil.FloatListRemoveAt( kActor, node + "slif_queue_values", index)
	endIf
endFunction

function unregisterNode(Actor kActor, String aToString, string node, string modName) global
	if (modName == "All Mods")
		int modCount = StorageUtil.StringListCount(kActor, "slif_mod_list")
		while(modCount > 1)
			modCount -= 1
			String mod = StorageUtil.StringListGet(kActor, "slif_mod_list", modCount) as String
			unregisterNode(kActor, aToString, node, mod)
		endWhile
		return
	endIf
	if (StorageUtil.HasFloatValue(kActor, modName + node))
		int leftIndex  = FindListEntry("stringList", "left_nodes",  node)
		int rightIndex = FindListEntry("stringList", "right_nodes", node)
		String syncKey = ""
		if (leftIndex != -1)
			   syncKey = GetListEntry("stringList", "left_nodes",  leftIndex)
		elseIf (rightIndex != -1)
			   syncKey = GetListEntry("stringList", "right_nodes", rightIndex)
		endIf
		if (syncKey != "")
			RemoveModEntriesFromQueue(kActor, syncKey, modName)
		endIf
		RemoveModEntriesFromQueue(kActor, node, modName)
		
		UnsetFloatValue(kActor, modName, node)
		UnsetFloatValue(kActor, modName, node, "_min")
		UnsetFloatValue(kActor, modName, node, "_max")
		UnsetFloatValue(kActor, modName, node, "_mult")
		UnsetFloatValue(kActor, modName, node, "_increment")
		StringListRemove(kActor, modName, node)
		
		CheckIfNodeRelevantForActorRemoveIfNot(kActor, aToString, modName, node)
	endIf
endFunction

function CheckIfNodeRelevantForActorRemoveIfNot(Actor kActor, String aToString, String modName, String node) global
	bool has_node = false
	int has_value_count = 0
	int modCount = StorageUtil.StringListCount(kActor, "slif_mod_list")
	while(modCount > 1 && has_node == false)
		modCount -= 1
		String mod = StorageUtil.StringListGet(kActor, "slif_mod_list", modCount) as String
		if (StorageUtil.HasFloatValue(kActor, mod + node))
			if (mod != "SL Inflation Framework" || StorageUtil.GetFloatValue(kActor, mod + node) != 0.0)
				has_value_count += 1
			endIf
			has_node = true
		endIf
	endWhile
	if (has_node)
		float value = SLIF_Calc.calculateValueAllMods(kActor, aToString, node)
		SLIF_Scale.SetNodeScale(kActor, aToString, node, value)
	else
		UnsetAllModsKey(kActor, node)
		SLIF_Main.showNode(kActor, modName, node)
	endIf
	if (!SLIF_Main.IsNodeHidden(kActor, node) && has_value_count == 0)
		SLIF_Scale.RemoveNodeScale(kActor, aToString, node, "SexLab Inflation Framework.esp")
	endIf
	if (!IsModRelevant(kActor, modName))
		RemoveModFromList(kActor, modName)
		StorageUtil.UnsetIntValue(kActor, modName + "slif_initialize")
		if (StorageUtil.StringListCount(kActor, "slif_mod_list") < 2)
			unregisterActorForAllMods(kActor, aToString)
		endIf
	endIf
endFunction

function SetAllModsKey(Actor kActor, String node, float value = 1.0) global
	String modName = "All Mods"
	StringListAdd(kActor, modName, node)
	SetFloatValue(kActor, modName, node, value, "", false)
endFunction

function UnsetAllModsKey(Actor kActor, String node) global
	String modName = "All Mods"
	StringListRemove(kActor, modName, node)
	UnsetFloatValue(kActor, modName, node)
	UnsetFloatValueConditional(kActor, "SexLab Inflation Framework.esp" + node)
endFunction

function updateActor(Actor kActor, String aToString, string modName, String node, string oldModName, float minimum, float maximum, float multiplier, float increment, float value = -1.0) global
	float start = Utility.GetCurrentRealTime()
	if (kActor)
	
		if (StorageUtil.HasIntValue(kActor, modName + "slif_initialize"))
			
			if (value >= 0.0)
				SLIF_Debug.Trace("[SLIF_Util] Resetting Actor:      " + aToString + " for mod " + modName)
				setActorKeysToValue(kActor, modName, value)
			else
				SLIF_Debug.Trace("[SLIF_Util] Updating Actor:       " + aToString + " for mod " + modName)
			endIf
			updateNodes(kActor, aToString, modName, node, oldModName, minimum, maximum, multiplier, increment)
			SLIF_Scale.UpdateMorphs(kActor)
			
			float end = Utility.GetCurrentRealTime()
			if (value >= 0.0)
				SLIF_Debug.Trace("[SLIF_Util] Resetting Actor Done: " + aToString + " for mod " + modName + ", time_diff: " + (end - start))
			else
				SLIF_Debug.Trace("[SLIF_Util] Updating Actor Done:  " + aToString + " for mod " + modName + ", time_diff: " + (end - start))
			endIf
			
		endIf
	
	endIf
	
endFunction

function updateDefaultValues(Actor kActor, string modName, String node, float minimum, float maximum, float multiplier, float increment) global
	float min   = StorageUtil.GetFloatValue(kActor, modName + node + "_min",       GetDefaultMinimum(false))
	float max   = StorageUtil.GetFloatValue(kActor, modName + node + "_max",       GetDefaultMaximum())
	float mult  = StorageUtil.GetFloatValue(kActor, modName + node + "_mult",      GetDefaultMultiplier())
	float incr  = StorageUtil.GetFloatValue(kActor, modName + node + "_increment", GetDefaultIncrement())
	if (minimum != -1.0 && minimum != min)
		SetFloatValue(kActor, modName, node, minimum, "_min")
	endIf
	if (maximum != -1.0 && maximum != max)
		SetFloatValue(kActor, modName, node, maximum, "_max")
	endIf
	if (multiplier != -1.0 && multiplier != mult)
		SetFloatValue(kActor, modName, node, multiplier, "_mult")
	endIf
	if (increment != -1.0 && increment != incr)
		SetFloatValue(kActor, modName, node, increment, "_increment")
	endIf
endFunction

function updateActorList(String modName, string node, string oldModName, float minimum, float maximum, float multiplier, float increment, float value = -1.0) global
	
	int actorCount = StorageUtil.FormListCount(none, "slif_actor_list")
	int i = 0
	while(i < actorCount)
		Actor kActor     = StorageUtil.FormListGet(none, "slif_actor_list", i) as Actor
		String name      = GetActorName(kActor)
		String aToString = ActorToString(kActor, name)
		updateActor(kActor, aToString, modName, node, oldModName, minimum, maximum, multiplier, increment, value)
		i+=1
	endWhile
	
endFunction

function setActorKeysToValue(Actor kActor, String modName, float value, bool menu = false, String suffix = "") global
	if (modName == "All Mods")
		int modCount = StorageUtil.StringListCount(kActor, "slif_mod_list")
		while (modCount > 1)
			modCount -= 1
			String tempMod = StorageUtil.StringListGet(kActor, "slif_mod_list", modCount) as String
			setActorKeysToValueByModName(kActor, tempMod, value, menu, suffix)
		endWhile
	else
		setActorKeysToValueByModName(kActor, modName, value, menu, suffix)
	endIf
endFunction

function setActorKeysToValueByModName(Actor kActor, String modName, float value, bool menu, String suffix) global
	int category = StorageUtil.GetIntValue(kActor, "slif_category_selection")
	String nodeList = "000_nodes"
	if (menu)
		nodeList = GetListByCategory("node_lists", category)
	endIf
	int count = GetListSize("node_lists", nodeList)
	int i = 0
	while (i < count)
		String node = GetListEntry("node_lists", nodeList, i)
		if (StorageUtil.HasFloatValue(kActor, modName + node + suffix))
			if (suffix == "")
				String tempNode = node
				int leftIndex   = FindListEntry("stringList", "left_nodes",  node)
				int rightIndex  = FindListEntry("stringList", "right_nodes", node)
				if (leftIndex != -1)
					String rightNode = GetListEntry("stringList", "right_nodes", leftIndex)
					String syncKey  = GetListEntry("stringList", "sync_keys",  leftIndex)
					if (StorageUtil.HasFloatValue(kActor, modName + rightNode))
						tempNode = syncKey
					endIf
				elseIf (rightIndex != -1)
					String leftNode = GetListEntry("stringList", "left_nodes", rightIndex)
					if (StorageUtil.HasFloatValue(kActor, modName + leftNode))
						tempNode = ""
					endIf
				endIf
				if (tempNode != "")
					SLIF_Main.inflate(kActor, modName, tempNode, value)
				endIf
			else
				SetFloatValue(kActor, modName, node, value, suffix)
			endIf
		endIf
		i += 1
	endWhile
endFunction

string function GenderToString(int gender) global
	bool male            = gender == 0
	bool female          = gender == 1
	bool shemale         = gender == 2
	bool futanari        = gender == 3
	bool genderless      = gender == 4
	bool male_creature   = gender == 5
	bool female_creature = gender == 6
	
	if (male)
		return "Male"
	elseIf (female)
		return "Female"
	elseIf (shemale)
		return "Shemale"
	elseIf (futanari)
		return "Futanari"
	elseIf (genderless)
		return "Genderless"
	elseIf (male_creature)
		return "Male Creature"
	elseIf (female_creature)
		return "Female Creature"
	endIf
	return ""
endFunction

string function CalculationTypeToString(int calculation_type) global
	bool calculation_type_top_x         = calculation_type == 0
	bool calculation_type_highest_wins  = calculation_type == 1
	bool calculation_type_substract_one = calculation_type == 2
	bool calculation_type_square_root   = calculation_type == 3
	bool calculation_type_average       = calculation_type == 4
	bool calculation_type_additive      = calculation_type == 5
	
	if (calculation_type_top_x)
		return "Top Three"
	elseIf (calculation_type_highest_wins)
		return "Highest Wins"
	elseIf (calculation_type_substract_one)
		return "Substract And Add One"
	elseIf (calculation_type_square_root)
		return "Square Root"
	elseIf (calculation_type_average)
		return "Average"
	elseIf (calculation_type_additive)
		return "Additive"
	endIf
endFunction

string function GetActorNameByList(Actor kActor, String slif_actor = "slif_actor") global
	int index      = StorageUtil.FormListFind(   none, slif_actor + "_list", kActor)
	int count      = StorageUtil.FormListCount(  none, slif_actor + "_list")
	int name_count = StorageUtil.StringListCount(none, slif_actor + "_name_list")
	if (count == name_count && index != -1)
		return StorageUtil.StringListGet(none, slif_actor + "_name_list", index)
	endIf
	return ""
endFunction
	
string function GetActorName(Actor kActor) global
	String default_name = GetActorNameByList(kActor)
	String morph_name   = GetActorNameByList(kActor, "slif_morph_actor")
	if (default_name != "")
		return default_name
	endIf
	if (morph_name != "")
		return morph_name
	endIf
	return kActor.GetLeveledActorBase().GetName()
endFunction

string function ActorToString(Actor kActor, String name) global
	return name + " [" + ConvertFormToHexString(kActor) + "]"
endFunction

;/
[defaultGhostScript < (000590F0)>] converts to 000590F0
/;
string function ConvertFormToHexString(Form f) global
	string[] arr = PapyrusUtil.StringSplit(""+f, "(")
	int idx = arr.length - 1
	string s = arr[idx]
	string res = ""
	int i = 0
	while(i < 8)
		res += StringUtil.GetNthChar(s, i)
		i += 1
	endWhile
	return res
endFunction

string function OldModNameToString(String oldModName) global
	if (oldModName != "")
		return ", old_mod: " + oldModName
	endIf
	return ""
endFunction

string function InflationTypeToString(int inflation_type) global
	bool incremental = inflation_type == 0
	bool instant     = inflation_type == 1
	
	if (incremental)
		return "Incremental"
	elseIf (instant)
		return "Instant"
	endIf
endFunction

bool function IsValidActor(Actor kActor) global
	;/
	if (isModInstalled("SexLab.esm"))
		return (Game.GetFormFromFile(0xD62,"SexLab.esm") as SexLabFramework).IsValidActor(kActor)
	else
		return !kActor.isChild()
	endIf
	/;
	if (kActor)
		return !kActor.isChild()
	endIf
	return false
endFunction

function AddModToList(Actor kActor, String modName, String list = "slif_mod_list") global
	AddModSorted(modName, kActor, list)
	AddModSorted(modName, none,   list)
endFunction

function AddMod(Form ObjKey, String modName, int index = -1, String list = "slif_mod_list") global
	if (ObjKey == none)
		if (!SLIF_Config.HasMod(modName))
			if (index != -1)
				if (!SLIF_Config.InsertMod(modName, index))
					SLIF_Config.AddMod(modName)
				endIf
			else
				SLIF_Config.AddMod(modName)
			endIf
		endIf
	else
		if (!StorageUtil.StringListHas(ObjKey, list, modName))
			if (index != -1)
				if (!StorageUtil.StringListInsert(ObjKey, list, index, modName))
					StorageUtil.StringListAdd(ObjKey, list, modName, false)
				endIf
			else
				StorageUtil.StringListAdd(ObjKey, list, modName, false)
			endIf
		endIf
		SetModListCount(ObjKey, list)
	endIf
endFunction

String function GetMod(Form ObjKey, int index, String list = "slif_mod_list") global
	if (ObjKey == none)
		return SLIF_Config.GetMod(index)
	endIf
	return StorageUtil.StringListGet(ObjKey, list, index)
endFunction

bool function HasMod(Form ObjKey, String modName, String list = "slif_mod_list") global
	if (ObjKey == none)
		return SLIF_Config.HasMod(modName)
	endIf
	return StorageUtil.StringListHas(ObjKey, list, modName)
endFunction

int function ModCount(Form ObjKey, String list = "slif_mod_list") global
	if (ObjKey == none)
		return SLIF_Config.ModCount()
	endIf
	return StorageUtil.StringListCount(ObjKey, list)
endFunction

int function GetModStartIndex(bool has_slif) global
	if (has_slif)
		return 2
	endIf
	return 1
endFunction

function AddModSorted(String modName, Form ObjKey = none, String list = "slif_mod_list") global
	if (modName == "")
		return
	endIf
	String all_mods = "All Mods"
	String slif     = "SL Inflation Framework"
	bool has_slif   = HasMod(ObjKey, slif)
	if (ObjKey != none)
		StorageUtil.StringListRemove(ObjKey, list, all_mods, true)
		if (has_slif)
			StorageUtil.StringListRemove(ObjKey, list, slif, true)
		endIf
	endIf
	if (modName != slif && modName != all_mods)
		if (ObjKey != none)
			AddMod(ObjKey, modName, -1, list)
			StorageUtil.StringListSort(ObjKey, list)
		else
			int index  = GetModStartIndex(has_slif)
			int count  = ModCount(ObjKey)
			bool added = false
			while(index < count && !added)
				String mod = GetMod(ObjKey, index)
				if (SLIF_Sort.CompareStringsWithOrder(modName, mod, true) < 0)
					AddMod(ObjKey, modName, index, list)
					added = true
				endIf
				index += 1
			endWhile
			if (!added)
				AddMod(ObjKey, modName, -1, list)
			endIf
		endIf
	endIf
	AddMod(ObjKey, all_mods, 0, list)
	if (has_slif || modName == slif)
		AddMod(ObjKey, slif, 1, list)
	endIf
	SetModListCount(ObjKey, list)
endFunction

function RemoveModFromList(Form ObjKey, String modName, String list = "slif_mod_list") global
	StorageUtil.StringListRemove(ObjKey, list, modName, true)
	SetModListCount(ObjKey, list)
endFunction

function SetModListCount(Form ObjKey, String list = "slif_mod_list") global
	int count = StorageUtil.StringListCount(ObjKey, list) / 128 + 1
	StorageUtil.SetIntValue(ObjKey, list + "_count", count)
endFunction

function AddActorToList(Actor kActor, String name, String aToString, String slif_actor = "slif_actor") global
	if (!StorageUtil.FormListHas(none, slif_actor + "_list", kActor))
		Actor PlayerRef = Game.GetPlayer()
		if (kActor != PlayerRef)
			AddActorSorted(kActor, name, PlayerRef, slif_actor)
		else
			AddActor(PlayerRef, name, 0, slif_actor)
		endIf
		int count = StorageUtil.StringListCount(none, slif_actor + "_name_list") / 128 + 1
		StorageUtil.SetIntValue(none, slif_actor + "_name_list_count", count)
		SLIF_Debug.Notification(SLIF_Language.TargetAddedToList(name))
		SLIF_Debug.Trace("[SLIF_Util] Adding Actor:         " + aToString + " to the list!")
	endIf
endFunction

function AddActorSorted(Actor kActor, String name, Actor PlayerRef, String slif_actor = "slif_actor") global
	bool added = false
	int size = StorageUtil.FormListCount(none, slif_actor + "_list")
	int i = 0
	if (StorageUtil.FormListHas(none, slif_actor + "_list", PlayerRef))
		i = 1
	endIf
	while(i < size && !added)
		String tempName = StorageUtil.StringListGet(none, slif_actor + "_name_list", i)
		bool ascending = SLIF_Config.GetInt("sort_actors_ascending", 1) as bool
		int compare = SLIF_Sort.CompareStringsWithOrder(name, tempName, ascending)
		if (compare < 0)
			AddActor(kActor, name, i, slif_actor)
			added = true
		endIf
		i += 1
	endWhile
	if (!added)
		AddActor(kActor, name, -1, slif_actor)
	endIf
endFunction

function AddActor(Actor kActor, String name, int index = -1, String slif_actor = "slif_actor") global
	if (!StorageUtil.FormListHas(none, slif_actor + "_list", kActor))
		if (index != -1)
			if (StorageUtil.FormListInsert(none, slif_actor + "_list", index, kActor))
				StorageUtil.StringListInsert(none, slif_actor + "_name_list", index, name)
			else
				if (StorageUtil.FormListAdd(none, slif_actor + "_list", kActor, false) != -1)
					StorageUtil.StringListAdd(none, slif_actor + "_name_list", name)
				endIf
			endIf
		else
			if (StorageUtil.FormListAdd(none, slif_actor + "_list", kActor, false) != -1)
				StorageUtil.StringListAdd(none, slif_actor + "_name_list", name)
			endIf
		endIf
	endIf
	StorageUtil.FormListAdd(none, "slif_complete_actor_list", kActor, false)
	StorageUtil.FormListSort(none, "slif_complete_actor_list")
endFunction

function RemoveActor(Actor kActor, String aToString, int index = -1, String slif_actor = "slif_actor") global
	if (index == -1)
		if (StorageUtil.FormListHas(none, slif_actor + "_list", kActor))
			index = StorageUtil.FormListFind(none, slif_actor + "_list", kActor)
		else
			return
		endIf
	endIf
	if (index != -1)
		StorageUtil.FormListRemoveAt(  none, slif_actor + "_list",      index)
		StorageUtil.StringListRemoveAt(none, slif_actor + "_name_list", index)
		int count = StorageUtil.StringListCount(none, slif_actor + "_name_list") / 128 + 1
		StorageUtil.SetIntValue(none, slif_actor + "_name_list_count", count)
		if (kActor)
			SLIF_Debug.Trace("[SLIF_Util] Removing Actor:       " + aToString + " from the list!")
		endIf
	endIf
	if (!StorageUtil.FormListHas(none, "slif_actor_list", kActor) && !StorageUtil.FormListHas(none, "slif_morph_actor_list", kActor))
		StorageUtil.FormListRemove(none, "slif_complete_actor_list", kActor, true)
	endIf
endFunction

function RemoveActorFromList(Actor kActor, String aToString, String slif_actor = "slif_actor") global
	RemoveActor(kActor, aToString, -1, slif_actor)
endFunction

bool function UnsetFormValueConditional(Form ObjKey, String sKey) global
	if (StorageUtil.HasFormValue(  ObjKey, sKey))
		StorageUtil.UnsetFormValue(ObjKey, sKey)
		return true
	endIf
	return false
endFunction

bool function UnsetStringValueConditional(Form ObjKey, String sKey) global
	if (StorageUtil.HasStringValue(  ObjKey, sKey))
		StorageUtil.UnsetStringValue(ObjKey, sKey)
		return true
	endIf
	return false
endFunction

bool function UnsetIntValueConditional(Form ObjKey, String sKey) global
	if (StorageUtil.HasIntValue(  ObjKey, sKey))
		StorageUtil.UnsetIntValue(ObjKey, sKey)
		return true
	endIf
	return false
endFunction

bool function UnsetFloatValueConditional(Form ObjKey, String sKey) global
	if (StorageUtil.HasFloatValue(  ObjKey, sKey))
		StorageUtil.UnsetFloatValue(ObjKey, sKey)
		return true
	endIf
	return false
endFunction

bool function SetFormValueConditional(Form ObjKey, String sKey, Form value, bool replace = false) global
	if (StorageUtil.HasFormValue(ObjKey, sKey) == false)
		StorageUtil.SetFormValue(ObjKey, sKey, value)
		return true
	elseIf (replace)
		if (StorageUtil.GetFormValue(ObjKey, sKey) != value)
			StorageUtil.SetFormValue(ObjKey, sKey, value)
			return true
		endIf
	endIf
	return false
endFunction

bool function SetStringValueConditional(Form ObjKey, String sKey, String value, bool replace = false) global
	if (StorageUtil.HasStringValue(ObjKey, sKey) == false)
		StorageUtil.SetStringValue(ObjKey, sKey, value)
		return true
	elseIf (replace)
		if (StorageUtil.GetStringValue(ObjKey, sKey) != value)
			StorageUtil.SetStringValue(ObjKey, sKey, value)
			return true
		endIf
	endIf
	return false
endFunction

bool function SetIntValueConditional(Form ObjKey, String sKey, int value, bool replace = false) global
	if (StorageUtil.HasIntValue(ObjKey, sKey) == false)
		StorageUtil.SetIntValue(ObjKey, sKey, value)
		return true
	elseIf (replace)
		if (StorageUtil.GetIntValue(ObjKey, sKey) != value)
			StorageUtil.SetIntValue(ObjKey, sKey, value)
			return true
		endIf
	endIf
	return false
endFunction

bool function SetFloatValueConditional(Form ObjKey, String sKey, float value, bool replace = false) global
	if (StorageUtil.HasFloatValue(ObjKey, sKey) == false)
		StorageUtil.SetFloatValue(ObjKey, sKey, value)
		return true
	elseIf (replace)
		if (StorageUtil.GetFloatValue(ObjKey, sKey) != value)
			StorageUtil.SetFloatValue(ObjKey, sKey, value)
			return true
		endIf
	endIf
	return false
endFunction

function printModList(Form ObjKey, String list = "slif_mod_list") global
	int modCount = 0
	if (ObjKey == none)
		modCount = SLIF_Config.ModCount()
	else
		modCount = StorageUtil.StringListCount(ObjKey, list)
	endIf
	int count = 0
	while (count < modCount)
		string mod = ""
		if (ObjKey == none)
			mod = SLIF_Config.GetMod(count)
		else
			mod = StorageUtil.StringListGet(ObjKey, list, count)
		endIf
		SLIF_Debug.Trace("[SLIF_Util] Printing Mod List:    FORM: " + ObjKey + " MOD: " + mod)
		count += 1
	endWhile
endFunction

String Function ReplaceString(String sKey, String delim = ",", String replace = " ") Global
	int keyLength = StringUtil.GetLength(sKey)
	int delimLength = StringUtil.GetLength(delim)
	int index = StringUtil.Find(sKey, delim)
	if (index == -1)
		return sKey
	endIf
	int newIdx = index + delimLength
	if (keyLength > newIdx)
		return StringUtil.Substring(sKey, 0, index) + replace + StringUtil.Substring(sKey, newIdx, keyLength)
	endIf
	return StringUtil.Substring(sKey, 0, index) + replace
EndFunction

String Function SplitAndJoinString(String sKey, String delim = ",", String replace = " ", bool papyutil = false) Global
	If (delim != "")
		If (papyutil)
			String[] split = PapyrusUtil.StringSplit(sKey, delim)
			Return PapyrusUtil.StringJoin(split, replace)
		Else
			String[] split = StringUtil.Split(sKey, delim)
			int size = split.length
			If (size > 1)
				String result = ""
				int i = 0
				While(i < size)
					If (i < size - 1)
						result += split[i] + replace
					Else
						result += ReplaceString(split[i], delim, replace)
					EndIf
					i += 1
				EndWhile
				Return result
			Else
				return ReplaceString(sKey, delim, replace)
			EndIf
		EndIf
	EndIf
	Return sKey
EndFunction

Int[] Function InitializeIntegerArray(int size, int value) Global
	Int[] values = Utility.CreateIntArray(size)
	int i = 0
	while(i < size)
		values[i] = value
		i += 1
	endWhile
	return values
EndFunction

Float[] Function InitializeFloatArrayConditionally(int size, float min, float max, float default, float value = -1.0) Global
	if (value >= 0.0)
		return Utility.CreateFloatArray(size, SLIF_Math.SetBounds(value, min, max))
	endIf
	return Utility.CreateFloatArray(size, default)
EndFunction

bool function StartsWith(String tar, String sub) global
	int tarLen = StringUtil.GetLength(tar)
	int subLen = StringUtil.GetLength(sub)
	if (tarLen == 0 || subLen == 0 || tarLen < subLen)
		return false
	endIf
	if (sub == StringUtil.Substring(tar, 0, subLen))
		return true
	endIf
	return false
endFunction

bool function IsEmpty(String s) global
	if (s == "")
		return true
	endIf
	return false
endFunction

float function DefaultValue(String modName) global
	if (modName == "All Mods")
		return 1.0
	endIf
	return 0.0
endFunction

bool function IsModRelevant(Actor kActor, String modName) global
	int count = GetListSize("node_lists", "000_nodes")
	int i = 0
	while (i < count)
		String node = GetListEntry("node_lists", "000_nodes", i)
		if (StorageUtil.HasFloatValue(kActor, modName + node))
			return true
		endIf
		i += 1
	endWhile
	return false
endFunction

bool function IsNodeRelevant(String modName, String node, String slif_actor = "slif_actor") global
	int count = StorageUtil.StringListCount(none, slif_actor + "_list")
	int i = 0
	while (i < count)
		Actor kActor = StorageUtil.FormListGet(none, slif_actor + "_list", i) as Actor
		if (StorageUtil.HasFloatValue(kActor, modName + node))
			return true
		endIf
		i += 1
	endWhile
	return false
endFunction

bool Function StringArrayHas(String[] vars, String val) global
	int idx = 0
	while(idx < vars.length)
		if (vars[idx] == val)
			return true
		endIf
		idx += 1
	endWhile
	return false
EndFunction

int Function StringArrayFind(String[] vars, String val) global
	int idx = 0
	while(idx < vars.length)
		if (vars[idx] == val)
			return idx
		endIf
		idx += 1
	endWhile
	return -1
EndFunction

Function ChangeStorageForm(Form origin, Form target, String type, String sKey, float adjust = 0.0) global
	if (type == "int")
		if (StorageUtil.HasIntValue(  origin, sKey))
			StorageUtil.SetIntValue(  target, sKey, (StorageUtil.GetIntValue(origin, sKey) + (adjust as int)))
			StorageUtil.UnsetIntValue(origin, sKey)
		endIf
	elseIf (type == "float")
		if (StorageUtil.HasFloatValue(  origin, sKey))
			StorageUtil.SetFloatValue(  target, sKey, (StorageUtil.GetFloatValue(origin, sKey) + adjust))
			StorageUtil.UnsetFloatValue(origin, sKey)
		endIf
	elseIf (type == "string")
		if (StorageUtil.HasStringValue(  origin, sKey))
			StorageUtil.SetStringValue(  target, sKey, StorageUtil.GetStringValue(origin, sKey))
			StorageUtil.UnsetStringValue(origin, sKey)
		endIf
	elseIf (type == "form")
		if (StorageUtil.HasFormValue(  origin, sKey))
			StorageUtil.SetFormValue(  target, sKey, StorageUtil.GetFormValue(origin, sKey))
			StorageUtil.UnsetFormValue(origin, sKey)
		endIf
	endIf
EndFunction

bool Function GetPathReverse(String json, String path, String member) global
	return JsonUtil.GetPathStringValue(json, path + member + ".reverse") == "true"
EndFunction

String[] Function GetPathNodes(String json, String path, String member) global
	return JsonUtil.PathStringElements(json, path + member + ".nodes")
EndFunction

function SaveJson(String file) Global
	if (JsonUtil.IsPendingSave(file))
		JsonUtil.Save(file)
	endIf
endFunction

float function GetDefaultValueNiOverride(String member) global
	if (member == "NiOverride")
		return 100.0
	endIf
	return 0.0
endFunction

float function Equal(float first, float second, float actual) global
	if (actual == second)
		return first
	endIf
	return actual
endFunction

float function NotEqual(float first, float second, float actual) global
	if (first != second)
		return first
	endIf
	return actual
endFunction

String[] function PendToArray(String[] arr, String pre = "", String ap = "") global
	int i = 0
	while(i < arr.length)
		arr[i] = pre + arr[i] + ap
		i += 1
	endWhile
	return arr
endFunction
