Scriptname SLIF_Calc Hidden

Function InitializeDefaultValues(Actor kActor, String aToString, String modName, String node, String oldModName, float minimum, float maximum, float multiplier, float increment) Global
	if (node != "")
		float value = -1.0
		if (oldModName != "")
			SLIF_Scale.RemoveNodeTransformScales(kActor, node, oldModName)
		endIf
		float minDef  =   0.0
		float maxDef  = 100.0
		float multDef =   1.0
		float incrDef =   0.1
		if (minimum != -1.0 && maximum != -1.0 && minimum != minDef && maximum != maxDef)
			minimum = SLIF_Math.SetBounds(minimum, 0.0, 100.0)
			maximum = SLIF_Math.SetBounds(maximum, 0.0, 100.0)
			float tempMin = minimum
			float tempMax = maximum
			if (tempMin != tempMax)
				minimum = SLIF_Math.MinFloat(tempMin, tempMax)
				maximum = SLIF_Math.MaxFloat(tempMin, tempMax)
			endIf
		else
			if (minimum != -1.0 && minimum != minDef)
				minimum = SLIF_Math.SetBounds(minimum, 0.0, 100.0)
			endIf
			if (maximum != -1.0 && maximum != maxDef)
				maximum = SLIF_Math.SetBounds(maximum, 0.0, 100.0)
			endIf
		endIf
		if (multiplier != -1.0 && multiplier != multDef)
			multiplier = SLIF_Math.SetBounds(multiplier, 0.01, 10.0)
		endIf
		if (increment != -1.0 && increment != incrDef)
			increment = SLIF_Math.SetBounds(increment, 0.01, 1.0)
		endIf
		float inflation_type = SLIF_Util.GetDefaultInflationType()
		if (SLIF_Preset.FloatListCount("All Mods", "." + node) > 0)
			inflation_type = SLIF_Preset.FloatListGet("All Mods", "." + node, 0, inflation_type)
			minimum        = SLIF_Util.NotEqual(SLIF_Preset.FloatListGet("All Mods", "." + node, 1, minDef),  minDef,  minimum)
			maximum        = SLIF_Util.NotEqual(SLIF_Preset.FloatListGet("All Mods", "." + node, 2, maxDef),  maxDef,  maximum)
			multiplier     = SLIF_Util.NotEqual(SLIF_Preset.FloatListGet("All Mods", "." + node, 3, multDef), multDef, multiplier)
			increment      = SLIF_Util.NotEqual(SLIF_Preset.FloatListGet("All Mods", "." + node, 4, incrDef), incrDef, increment)
		endIf
		if (SLIF_Preset.FloatListCount(modName, "." + node) > 0)
			inflation_type = SLIF_Preset.FloatListGet(modName, "." + node, 0, inflation_type)
			minimum        = SLIF_Util.NotEqual(SLIF_Preset.FloatListGet(modName, "." + node, 1, minDef),  minDef,  minimum)
			maximum        = SLIF_Util.NotEqual(SLIF_Preset.FloatListGet(modName, "." + node, 2, maxDef),  maxDef,  maximum)
			multiplier     = SLIF_Util.NotEqual(SLIF_Preset.FloatListGet(modName, "." + node, 3, multDef), multDef, multiplier)
			increment      = SLIF_Util.NotEqual(SLIF_Preset.FloatListGet(modName, "." + node, 4, incrDef), incrDef, increment)
		endIf
		minimum    = SLIF_Util.Equal(minDef,  -1.0, minimum)
		maximum    = SLIF_Util.Equal(maxDef,  -1.0, maximum)
		multiplier = SLIF_Util.Equal(multDef, -1.0, multiplier)
		increment  = SLIF_Util.Equal(incrDef, -1.0, increment)
		if (value != -1.0)
			value = SLIF_Math.SetBounds(value, minimum, maximum)
		endIf
		if (SLIF_Preset.FloatListGet(modName, "." + node, 0, 1) != inflation_type)
			SLIF_Preset.FloatListSet(modName, "." + node, 0, inflation_type)
		endIf
		SLIF_Util.SetFloatValue(kActor, modName, node, minimum,    "_min",       false)
		SLIF_Util.SetFloatValue(kActor, modName, node, maximum,    "_max",       false)
		SLIF_Util.SetFloatValue(kActor, modName, node, multiplier, "_mult",      false)
		SLIF_Util.SetFloatValue(kActor, modName, node, increment,  "_increment", false)
		SLIF_Util.SetFloatValue(kActor, modName, node, value,      "",           false)
	endIf
EndFunction

function addToValues(float[] top_x_arr, int size, float value, int start = 0) global
	int i = start
	while (i < size)
		float temp = top_x_arr[i]
		if (temp < value)
			top_x_arr[i] = value
			int j = i + 1
			if (j < size)
				addToValues(top_x_arr, size, temp, j)
			endIf
			return
		endIf
		i += 1
	endWhile
endFunction

float function calculateValue(Actor kActor, String aToString, String modName, String node, float value) global
	String calculationType = SLIF_Util.CalculationTypeToString(SLIF_Config.GetInt("calculation_type"))
	String inflationType   = SLIF_Util.InflationTypeToString(SLIF_Preset.FloatListGet(modName, "." + node, 0) as int)
	       value           = SLIF_Util.InflateZero(modName, node, value)
	float oldValue         = StorageUtil.GetFloatValue(kActor, "All Mods" + node, 1.0)
	SLIF_Util.SetFloatValue(kActor, modName, node, value)
	float start            = Utility.GetCurrentRealTime()
	float currentValue     = addCalculationType(kActor, node)
	float difference       = currentValue - oldValue
	float end              = Utility.GetCurrentRealTime()
	SLIF_Debug.Trace("[SLIF_Calc] Calculation:          " + aToString + " node: " + node + ", result: " + currentValue + ", old: " + oldValue + ", diff: " + difference + ", calc_type: " + calculationType + ", infl_type: " + inflationType + ", mod: " + modName + ", time_diff: " + (end - start))
	return difference
endFunction

float function calculateValueAllMods(Actor kActor, String aToString, String node) global
	String calculationType = SLIF_Util.CalculationTypeToString(SLIF_Config.GetInt("calculation_type"))
	String inflationType   = SLIF_Util.InflationTypeToString(SLIF_Preset.FloatListGet("All Mods", "." + node, 0) as int)
	float oldValue         = StorageUtil.GetFloatValue(kActor, "All Mods" + node, 1.0)
	float start            = Utility.GetCurrentRealTime()
	float currentValue     = addCalculationType(kActor, node)
	float difference       = currentValue - oldValue
	float end              = Utility.GetCurrentRealTime()
	SLIF_Debug.Trace("[SLIF_Calc] Calculation:          " + aToString + " node: " + node + ", result: " + currentValue + ", old: " + oldValue + ", diff: " + difference + ", calc_type: " + calculationType + ", infl_type: " + inflationType + ", mod: " + "All Mods" + ", time_diff: " + (end - start))
	return currentValue
endFunction

float function addCalculationType(Actor kActor, String node) global
	float top_x_value         = 0.0
	float highest_wins_value  = 0.0
	float substract_one_value = 1.0
	float square_root_value   = 0.0
	float average_value       = 0.0
	float additive_value      = 0.0
	
	int calculation_type = SLIF_Config.GetInt("calculation_type")
	
	bool calculation_type_top_x         = calculation_type == 0
	bool calculation_type_highest_wins  = calculation_type == 1
	bool calculation_type_substract_one = calculation_type == 2
	bool calculation_type_square_root   = calculation_type == 3
	bool calculation_type_average       = calculation_type == 4
	bool calculation_type_additive      = calculation_type == 5
	
	int top_x = SLIF_Config.GetInt("top_x", 3)
	float[] top_x_arr
	
	int averageCount = 0
	float[] average_arr
	
	int modCount = StorageUtil.StringListCount(kActor, "slif_mod_list")
	if (modCount > 0)
		if (top_x > modCount)
			top_x = modCount
		endIf
		top_x_arr   = Utility.CreateFloatArray(top_x)
		average_arr = Utility.CreateFloatArray(modCount)
		int i = 1
		while(i < modCount)
			String mod = StorageUtil.StringListGet(kActor, "slif_mod_list", i)
			if (mod != "")
				if (StorageUtil.HasFloatValue(kActor, mod + node))
					float tempValue = StorageUtil.GetFloatValue(kActor, mod + node,            0.0)
					float tempMin   = StorageUtil.GetFloatValue(kActor, mod + node + "_min",   0.0)
					float tempMax   = StorageUtil.GetFloatValue(kActor, mod + node + "_max", 100.0)
					float tempMult  = StorageUtil.GetFloatValue(kActor, mod + node + "_mult",  1.0)
					
					tempValue = SLIF_Math.SetBounds(tempValue, tempMin, tempMax) * tempMult
					
					if (tempValue > 0.0)
						addToValues(top_x_arr, top_x, tempValue)
						substract_one_value += (tempValue - 1.0)
						square_root_value   += (tempValue * tempValue)
						averageCount        += 1
						addToValues(average_arr, modCount, tempValue)
						additive_value      += tempValue
					endIf
				endIf
			endIf
			i += 1
		endWhile

		int x = 0
		while (x < top_x)
			if (top_x_arr[x] > 0.0)
				if (x == 0)
					top_x_value += top_x_arr[x]
				else
					top_x_value += (top_x_arr[x] / (3 * x))
				endIf
				x += 1
			else
				x = top_x
			endIf
		endWhile
		
		highest_wins_value = top_x_arr[0]
		
		if (square_root_value > 0.0)
			square_root_value = Math.sqrt(square_root_value)
		endIf
		
		if (averageCount > 0)
			int a = 0
			while (a < modCount)
				if (average_arr[a] > 0.0)
					average_value += (average_arr[a] / averageCount)
					a += 1
				else
					a = modCount
				endIf
			endWhile
		endIf
	endIf
	
	if (top_x_value <= 0.0)
		top_x_value = 1.0
	endIf
	if (highest_wins_value <= 0.0)
		highest_wins_value = 1.0
	endIf
	substract_one_value = SLIF_Math.MaxFloat(0.0, substract_one_value)
	if (square_root_value <= 0.0)
		square_root_value = 1.0
	endIf
	if (average_value <= 0.0)
		average_value = 1.0
	endIf
	if (additive_value <= 0.0)
		additive_value = 1.0
	endIf
	
	if (calculation_type_top_x)
		return SLIF_Util.SetFloatValue(kActor, "All Mods", node, top_x_value,         "_top_x")
	elseIf (calculation_type_highest_wins)
		return SLIF_Util.SetFloatValue(kActor, "All Mods", node, highest_wins_value,  "_highest_wins")
	elseIf (calculation_type_substract_one)
		return SLIF_Util.SetFloatValue(kActor, "All Mods", node, substract_one_value, "_substract_one")
	elseIf (calculation_type_square_root)
		return SLIF_Util.SetFloatValue(kActor, "All Mods", node, square_root_value,   "_square_root")
	elseIf (calculation_type_average)
		return SLIF_Util.SetFloatValue(kActor, "All Mods", node, average_value,       "_average")
	elseIf (calculation_type_additive)
		return SLIF_Util.SetFloatValue(kActor, "All Mods", node, additive_value,      "_additive")
	endIf
	
	return 1.0
endFunction

function SetNodeValueIncrements(Actor kActor, String aToString, String syncKey, String leftNode, String rightNode) global
	float leftOldValue  = StorageUtil.GetFloatValue(kActor, "All Mods" + leftNode,  1.0)
	float rightOldValue = StorageUtil.GetFloatValue(kActor, "All Mods" + rightNode, 1.0)
	if (StorageUtil.StringListCount(kActor, syncKey + "slif_queue_mods") > 0)
		String modName  = StorageUtil.StringListGet(kActor, syncKey + "slif_queue_mods",   0)
		float value     = StorageUtil.FloatListGet( kActor, syncKey + "slif_queue_values", 0)
		if (SLIF_Util.InflateInstant(modName, leftNode) || SLIF_Util.InflateInstant(modName, rightNode))
			SLIF_Util.InflateTwoNodesInstant(kActor, aToString, modName, leftNode, rightNode, SLIF_Math.Average(leftOldValue, rightOldValue), value)
			return
		endIf
		float[] arr1  = CalculateDifference(kActor, aToString, modName, leftNode,  value, leftOldValue)
		float[] arr2  = CalculateDifference(kActor, aToString, modName, rightNode, value, rightOldValue)
		leftOldValue  = arr1[0]
		rightOldValue = arr2[0]
		if (arr1[1] == 0 && arr2[1] == 0 && modName == StorageUtil.StringListGet(kActor, syncKey + "slif_queue_mods", 0) && value == StorageUtil.FloatListGet(kActor, syncKey + "slif_queue_values", 0))
			RemoveFromQueue(kActor, aToString, syncKey)
		endIf
	elseIf (StorageUtil.StringListCount(kActor, leftNode + "slif_queue_mods") > 0 || StorageUtil.StringListCount(kActor, rightNode + "slif_queue_mods") > 0)
		SetNodeValueIncrement(kActor, aToString, leftNode)
		SetNodeValueIncrement(kActor, aToString, rightNode)
		return
	endIf
	SLIF_Scale.SetNodeScales(kActor, aToString, leftNode, rightNode, leftOldValue, rightOldValue)
endFunction

function SetNodeValueIncrement(Actor kActor, String aToString, String node) global
	float oldValue     = StorageUtil.GetFloatValue(kActor, "All Mods" + node, 1.0)
	if (StorageUtil.StringListCount(kActor, node + "slif_queue_mods") > 0)
		String modName = StorageUtil.StringListGet(kActor, node + "slif_queue_mods",   0)
		float value    = StorageUtil.FloatListGet( kActor, node + "slif_queue_values", 0)
		if (SLIF_Util.InflateInstant(modName, node))
			SLIF_Util.InflateNodeInstant(kActor, aToString, modName, node, oldValue, value)
			return
		endIf
		float[] arr = CalculateDifference(kActor, aToString, modName, node, value, oldValue)
		oldValue    = arr[0]
		if (arr[1] == 0.0 && modName == StorageUtil.StringListGet(kActor, node + "slif_queue_mods", 0) && value == StorageUtil.FloatListGet(kActor, node + "slif_queue_values", 0))
			RemoveFromQueue(kActor, aToString, node)
		endIf
	endIf
	SLIF_Scale.SetNodeScale(kActor, aToString, node, oldValue)
endFunction

float[] function CalculateDifference(Actor kActor, String aToString, String modName, String node, float value, float oldValue) global
	float difference = calculateValue(kActor, aToString, modName, node, value)
	float increment  = StorageUtil.GetFloatValue(kActor, modName + node + "_increment", 0.1)
	if (difference > 0.0)
		if ((difference - increment) > 0.0)
			oldValue += increment
			difference -= increment
		else
			oldValue += difference
			difference = 0.0
		endIf
	elseIf (difference < 0.0)
		if ((difference + increment) < 0.0)
			if ((oldValue - increment) > 0.0)
				oldValue -= increment
			else
				oldValue = 0.0
			endIf
			difference += increment
		else
			if ((oldValue + difference) > 0.0)
				oldValue += difference
			else
				oldValue = 0.0
			endIf
			difference = 0.0
		endIf
	endIf
	float[] arr = new float[2]
	arr[0] = oldValue
	arr[1] = difference
	return arr
endFunction

function AddToQueue(Actor kActor, String aToString, String modName, String node, float value) global
	if (node != "")
		SLIF_Util.RemoveModEntriesFromQueue(kActor, node, modName, true)
		int index = StorageUtil.StringListFind(kActor, node + "slif_queue_mods", modName)
		if (index != -1)
			StorageUtil.FloatListSet( kActor, node + "slif_queue_values", index, value)
		else
			StorageUtil.StringListAdd(kActor, node + "slif_queue_mods",   modName)
			StorageUtil.FloatListAdd( kActor, node + "slif_queue_values", value)
		endIf
		SLIF_Debug.Trace("[SLIF_Calc] Add To Queue:         " + aToString + " node: " + node + ", value: " + value + ", mod: " + modName)
	endIf
endFunction

function RemoveFromQueue(Actor kActor, String aToString, String node) global
	if (node != "")
		SLIF_Util.RemoveModEntriesFromQueue(kActor, node, StorageUtil.StringListGet(kActor, node + "slif_queue_mods", 0))
		SLIF_Debug.Trace("[SLIF_Calc] Remove From Queue:    " + aToString + " node: " + node)
	endIf
endFunction

function StartQueue(Actor kActor, String aToString, String modName, String node) global
	
	String syncKey = SLIF_Util.GetSyncKeyFromNode(node)
	
	if (syncKey != "")
		int syncIndex = SLIF_Util.FindListEntry("stringList", "sync_keys", syncKey)
		if !StorageUtil.GetIntValue(kActor, syncKey + "slif_queue_started") as bool
			DoQueue(kActor, aToString, modName, node, syncKey, syncIndex)
		endIf
	else
		if !StorageUtil.GetIntValue(kActor, node + "slif_queue_started") as bool
			DoQueue(kActor, aToString, modName, node)
		endIf
	endIf
	
endFunction

function DoQueue(Actor kActor, String aToString, String modName, String node, String syncKey = "", int syncIndex = -1) global
	
	if (syncKey != "")
		String leftNode   = SLIF_Util.GetListEntry("stringList", "left_nodes",  syncIndex)
		String rightNode  = SLIF_Util.GetListEntry("stringList", "right_nodes", syncIndex)
		
		DoSyncQueue(kActor, aToString, modName, syncKey, leftNode, rightNode)
	else
		if !StorageUtil.GetIntValue(kActor, node + "slif_queue_started") as bool
			StorageUtil.SetIntValue(kActor, node + "slif_queue_started", 1)
			
			DoSingleQueue(kActor, aToString, modName, node)
			
			StorageUtil.SetIntValue(kActor, node + "slif_queue_started", 0)
		endIf
	endIf
	
endFunction

function DoSyncQueue(Actor kActor, String aToString, String modName, String syncKey, String leftNode, String rightNode) global
	if !StorageUtil.GetIntValue(kActor, syncKey + "slif_queue_started") as bool
		StorageUtil.SetIntValue(kActor, syncKey + "slif_queue_started", 1)
		
		DoMultiQueue(kActor, aToString, modName, syncKey, leftNode, rightNode)
		
		StorageUtil.SetIntValue(kActor, syncKey + "slif_queue_started", 0)
	endIf
endFunction

function DoMultiQueue(Actor kActor, String aToString, String modName, String syncKey, String leftNode, String rightNode) global
	float start      = Utility.GetCurrentRealTime()
	while(StorageUtil.StringListCount(kActor, syncKey + "slif_queue_mods") > 0 || StorageUtil.StringListCount(kActor, leftNode + "slif_queue_mods") > 0 || StorageUtil.StringListCount(kActor, rightNode + "slif_queue_mods") > 0)
		SetNodeValueIncrements(kActor, aToString, syncKey, leftNode, rightNode)
	endWhile
	float leftValue  = StorageUtil.GetFloatValue(kActor, "All Mods" + leftNode, 1.0)
	float rightValue = StorageUtil.GetFloatValue(kActor, "All Mods" + rightNode, 1.0)
	float value      = SLIF_Math.Average(leftValue, rightValue)
	float end        = Utility.GetCurrentRealTime()
	SLIF_Debug.Trace("[SLIF_Calc] Multi Queue:          " + aToString + " node: " + syncKey + ", value: " + value + ", mod: " + modName + ", time_diff: " + (end - start))
endFunction

function DoSingleQueue(Actor kActor, String aToString, String modName, String node) global
	float start = Utility.GetCurrentRealTime()
	while(StorageUtil.StringListCount(kActor, node + "slif_queue_mods") > 0)
		SetNodeValueIncrement(kActor, aToString, node)
	endWhile
	float value  = StorageUtil.GetFloatValue(kActor, "All Mods" + node, 1.0)
	float end    = Utility.GetCurrentRealTime()
	SLIF_Debug.Trace("[SLIF_Calc] Single Queue:         " + aToString + " node: " + node + ", value: " + value + ", mod: " + modName + ", time_diff: " + (end - start))
endFunction
