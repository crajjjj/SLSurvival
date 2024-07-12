Scriptname SLIF_Morph Hidden

Bool Function IsRegistered(Actor kActor, String modName) Global
	return StorageUtil.HasIntValue(kActor, modName + "slif_morph_initialize")
EndFunction

Float Function GetValue(Actor kActor, string modName, string morphName, float default = 0.0) Global
	if (SLIF_Morph_Util.validParameters(modName, morphName))
		return StorageUtil.GetFloatValue(kActor, "slif_" + modName + "_" + morphName, default)
	endIf
	return 0.0
EndFunction

Float Function GetMinValue(Actor kActor, string modName, string morphName, float default = 0.0) Global
	if (SLIF_Morph_Util.validParameters(modName, morphName))
		return StorageUtil.GetFloatValue(kActor, "slif_" + modName + "_" + morphName + "_min", default)
	endIf
	return 0.0
EndFunction

Float Function GetMaxValue(Actor kActor, string modName, string morphName, float default = 100.0) Global
	if (SLIF_Morph_Util.validParameters(modName, morphName))
		return StorageUtil.GetFloatValue(kActor, "slif_" + modName + "_" + morphName + "_max", default)
	endIf
	return 100.0
EndFunction

Float Function GetMultValue(Actor kActor, string modName, string morphName, float default = 1.0) Global
	if (SLIF_Morph_Util.validParameters(modName, morphName))
		return StorageUtil.GetFloatValue(kActor, "slif_" + modName + "_" + morphName + "_mult", default)
	endIf
	return 1.0
EndFunction

Float Function GetIncrValue(Actor kActor, string modName, string morphName, float default = 0.1) Global
	if (SLIF_Morph_Util.validParameters(modName, morphName))
		return StorageUtil.GetFloatValue(kActor, "slif_" + modName + "_" + morphName + "_increment", default)
	endIf
	return 0.1
EndFunction

Bool Function HasScale(Actor kActor, String modName, String morphName) Global
	if (SLIF_Morph_Util.validParameters(modName, morphName))
		return StorageUtil.HasFloatValue(kActor, "slif_" + modName + "_" + morphName)
	endIf
	return false
EndFunction

Function SetMinValue(Actor kActor, string modName, string morphName, float value) Global
	if (SLIF_Morph_Util.validParameters(modName, morphName))
		float minimum = SLIF_Math.SetBounds(value, 0.0, 100.0)
		float maximum = GetMaxValue(kActor, modName, morphName)
		float tempMin = minimum
		float tempMax = maximum
		if (tempMin != tempMax)
			minimum = SLIF_Math.MinFloat(tempMin, tempMax)
			maximum = SLIF_Math.MaxFloat(tempMin, tempMax)
		endIf
		SLIF_Util.SetFloatValueConditional(kActor, "slif_" + modName + "_" + morphName + "_min", minimum, false)
		SLIF_Util.SetFloatValueConditional(kActor, "slif_" + modName + "_" + morphName + "_max", maximum, false)
	endIf
EndFunction

Function SetMaxValue(Actor kActor, string modName, string morphName, float value) Global
	if (SLIF_Morph_Util.validParameters(modName, morphName))
		if (value < 0.0)
			value = 100.0
		endIf
		float minimum = GetMinValue(kActor, modName, morphName)
		float maximum = SLIF_Math.SetBounds(value, 0.0, 100.0)
		float tempMin = minimum
		float tempMax = maximum
		if (tempMin != tempMax)
			minimum = SLIF_Math.MinFloat(tempMin, tempMax)
			maximum = SLIF_Math.MaxFloat(tempMin, tempMax)
		endIf
		SLIF_Util.SetFloatValueConditional(kActor, "slif_" + modName + "_" + morphName + "_min", minimum, false)
		SLIF_Util.SetFloatValueConditional(kActor, "slif_" + modName + "_" + morphName + "_max", maximum, false)
	endIf
EndFunction

Function SetMultValue(Actor kActor, string modName, string morphName, float value) Global
	if (SLIF_Morph_Util.validParameters(modName, morphName))
		if (value < 0.0)
			value = 1.0
		endIf
		SLIF_Util.SetFloatValueConditional(kActor, "slif_" + modName + "_" + morphName + "_mult", SLIF_Math.SetBounds(value, 0.01, 10.0), false)
	endIf
EndFunction

Function SetIncrValue(Actor kActor, string modName, string morphName, float value) Global
	if (SLIF_Morph_Util.validParameters(modName, morphName))
		if (value < 0.0)
			value = 0.1
		endIf
		SLIF_Util.SetFloatValueConditional(kActor, "slif_" + modName + "_" + morphName + "_increment", SLIF_Math.SetBounds(value, 0.01, 1.0), false)
	endIf
EndFunction

Function SetMinMaxValue(Actor kActor, string modName, string morphName, float minimum, float maximum) Global
	if (SLIF_Morph_Util.validParameters(modName, morphName))
		if (maximum < 0.0)
			maximum = 100.0
		endIf
		minimum = SLIF_Math.SetBounds(minimum, 0.0, 100.0)
		maximum = SLIF_Math.SetBounds(maximum, 0.0, 100.0)
		float tempMin = minimum
		float tempMax = maximum
		if (tempMin != tempMax)
			minimum = SLIF_Math.MinFloat(tempMin, tempMax)
			maximum = SLIF_Math.MaxFloat(tempMin, tempMax)
		endIf
		SLIF_Util.SetFloatValueConditional(kActor, "slif_" + modName + "_" + morphName + "_min", minimum, false)
		SLIF_Util.SetFloatValueConditional(kActor, "slif_" + modName + "_" + morphName + "_max", maximum, false)
	endIf
EndFunction

Function SetMinMaxMultIncrValue(Actor kActor, string modName, string morphName, float minimum = -1.0, float maximum = -1.0, float multiplier = -1.0, float increment = -1.0) Global
	if (SLIF_Morph_Util.validParameters(modName, morphName))
		SetMinMaxValue(kActor, modName, morphName, minimum, maximum)
		SetMultValue(kActor, modName, morphName, multiplier)
		SetIncrValue(kActor, modName, morphName, increment)
	endIf
EndFunction

Function morph(Actor kActor, string modName, string morphName, float value, string oldModName = "", float minimum = -1.0, float maximum = -1.0, float multiplier = -1.0, float increment = -1.0) Global
	if (!SLIF_Morph_Util.validParameters(modName, morphName) || !SLIF_Util.IsValidActor(kActor) || SLIF_Main.IsUpdating())
		return
	endIf
	if (StorageUtil.GetFloatValue(kActor, "slif_" + modName + "_" + morphName) == value)
		return
	endIf
	StorageUtil.SetFloatValue(kActor, "slif_" + modName + "_" + morphName, value)
	
	StorageUtil.FloatListAdd(kActor, "slif_" + modName + "_" + morphName + "_working_queue", value)
	
	if (!StorageUtil.HasIntValue(kActor, "slif_" + modName + "_" + morphName + "_working_queue"))
		SLIF_Morph_Util.morphQueue(kActor, modName, morphName, oldModName)
	endIf
EndFunction

Function morphMultiple(Actor kActor, string modName, string[] morphNames, float[] values, string oldModName, float[] minimum, float[] maximum, float[] multiplier, float[] increment) Global
	float start = Utility.GetCurrentRealTime()
	
	if (!SLIF_Main.IsInstalled() || SLIF_Util.IsEmpty(modName) || SLIF_Main.IsUpdating())
		return
	endIf
	if (SLIF_Util.IsValidActor(kActor))
		
		String name         = SLIF_Util.GetActorName(kActor)
		String aToString    = SLIF_Util.ActorToString(kActor, name)
		
		int size = morphNames.length
		if (size > 0)
			
			if (minimum.length != size)
				minimum = Utility.CreateFloatArray(size)
			endIf
			if (maximum.length != size)
				maximum = Utility.CreateFloatArray(size, 100.0)
			endIf
			if (multiplier.length != size)
				multiplier = Utility.CreateFloatArray(size, 1.0)
			endIf
			if (increment.length != size)
				increment = Utility.CreateFloatArray(size, 0.1)
			endIf
			
			int i = 0
			while(i < size)
				morph(kActor, modName, morphNames[i], values[i], oldModName, minimum[i], maximum[i], multiplier[i], increment[i])
				i += 1
			endWhile
			
		endIf
	
	endIf
	
EndFunction

Function unregisterMorph(Actor kActor, string morphName, string modName = "All Mods") Global
	if (kActor)
		if (!StorageUtil.HasIntValue(kActor, "slif_" + modName + "_" + morphName + "_working_deque"))
			SLIF_Morph_Util.unregisterMorph(kActor, morphName, modName)
		endIf
	endIf
EndFunction

Function registerActor(Actor kActor, string modName, string morphName = "", string oldModName = "", float minimum = -1.0, float maximum = -1.0, float multiplier = -1.0, float increment = -1.0) Global
	
	if (!SLIF_Main.IsInstalled() || SLIF_Util.IsEmpty(modName))
		return
	endIf
	
	if (modName != "All Mods")
		if (SLIF_Util.IsValidActor(kActor))
			String name      = SLIF_Util.GetActorName(kActor)
			String aToString = SLIF_Util.ActorToString(kActor, name)
			int gender       = SLIF_Main.GetGender(kActor)
			if (name != "")
				SLIF_Util.AddActorToList(kActor, name, aToString, "slif_morph_actor")
				SLIF_Morph_Util.registerSLIF(kActor, name, aToString)
				
				if (modName != "SL Inflation Framework")
					SLIF_Morph_Util.registerMod(kActor, name, aToString, modName)
				endIf
				
				if (morphName != "")
					StorageUtil.StringListAdd(kActor, "slif_morph_mod_list_" + morphName, modName, false)
					StorageUtil.StringListAdd(kActor, "slif_morph_list",            morphName, false)
					StorageUtil.StringListAdd(kActor, "slif_morph_list_" + modName, morphName, false)
					SLIF_Morph_Util.SetAllModsKey(kActor, morphName)
					if (!HasScale(kActor, modName, morphName))
						SLIF_Morph_Util.InitializeDefaultValues(kActor, aToString, modName, morphName, oldModName, minimum, maximum, multiplier, increment)
					endIf
				endIf
				
			endIf
		endIf
	endIf
	
EndFunction

Function updateActor(Actor kActor, string modName = "All Mods", string morphName = "", string oldModName = "", float minimum = -1.0, float maximum = -1.0, float multiplier = -1.0, float increment = -1.0) Global
	if (!SLIF_Main.IsInstalled() || SLIF_Util.IsEmpty(modName))
		return
	endIf
	String name      = SLIF_Util.GetActorName(kActor)
	String aToString = SLIF_Util.ActorToString(kActor, name)
	SLIF_Morph_Util.updateActor(kActor, aToString, modName, morphName, oldModName, minimum, maximum, multiplier, increment)
EndFunction

Function resetActor(Actor kActor, string modName = "All Mods", string morphName = "", float value = 0.0, string oldModName = "", float minimum = -1.0, float maximum = -1.0, float multiplier = -1.0, float increment = -1.0) Global
	if (!SLIF_Main.IsInstalled() || SLIF_Util.IsEmpty(modName))
		return
	endIf
	String name      = SLIF_Util.GetActorName(kActor)
	String aToString = SLIF_Util.ActorToString(kActor, name)
	SLIF_Morph_Util.updateActor(kActor, aToString, modName, morphName, oldModName, minimum, maximum, multiplier, increment, value)
EndFunction

Function updateActorList(String modName = "All Mods", string morphName = "", string oldModName = "", float minimum = -1.0, float maximum = -1.0, float multiplier = -1.0, float increment = -1.0) Global
	if (!SLIF_Main.IsInstalled() || SLIF_Util.IsEmpty(modName))
		return
	endIf
	SLIF_Morph_Util.updateActorList(modName, morphName, oldModName, minimum, maximum, multiplier, increment)
EndFunction

Function resetActorList(String modName = "All Mods", string morphName = "", float value = 1.0, string oldModName = "", float minimum = -1.0, float maximum = -1.0, float multiplier = -1.0, float increment = -1.0) Global
	if (!SLIF_Main.IsInstalled() || SLIF_Util.IsEmpty(modName))
		return
	endIf
	SLIF_Morph_Util.updateActorList(modName, morphName, oldModName, minimum, maximum, multiplier, increment, value)
EndFunction

Function unregisterActor(Actor kActor, string modName = "All Mods") Global
	
	if (SLIF_Util.IsEmpty(modName))
		return
	endIf
	if (kActor)
		if (!IsRegistered(kActor, modName))
			return
		endIf
		
		String name      = SLIF_Util.GetActorName(kActor)
		String aToString = SLIF_Util.ActorToString(kActor, name)
		
		if (modName != "All Mods")
			
			SLIF_Morph_Util.unregisterMod(kActor, aToString, modName)
			
		else
			
			int modCount = StorageUtil.StringListCount(kActor, "slif_morph_mod_list")
			if (modCount > 1)
				while(modCount > 1)
					modCount -= 1
					String mod = StorageUtil.StringListGet(kActor, "slif_morph_mod_list", modCount)
					SLIF_Morph_Util.unregisterMod(kActor, aToString, mod)
				endWhile
			else
				SLIF_Morph_Util.unregisterActorForAllMods(kActor, aToString)
			endIf
			
		endIf
		
	endIf
	
EndFunction
