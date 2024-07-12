Scriptname SLIF_Morph_Util Hidden

Bool Function validParameters(String modName, String morphName) Global
	Return SLIF_Util.validParameters(modName, morphName)
EndFunction

function morphQueue(Actor kActor, string modName, string morphName, String oldModName) global
	if (!StorageUtil.HasIntValue(kActor, "slif_" + modName + "_" + morphName + "_working_queue"))
		StorageUtil.SetIntValue(kActor, "slif_" + modName + "_" + morphName + "_working_queue", 1)
		
		String name      = SLIF_Util.GetActorName(kActor)
		String aToString = SLIF_Util.ActorToString(kActor, name)
		
		if (SLIF_Util.AddEntry("morph_lists", "000_morphs", morphName))
			SLIF_Util.SaveJson("SexLab Inflation Framework/Lists.json")
		endIf
		
		if (oldModName != "")
			if (NiOverride.HasBodyMorph(kActor, morphName, oldModName))
				NiOverride.ClearBodyMorph(kActor, morphName, oldModName)
			endIf
		endIf
		
		SLIF_Morph.registerActor(kActor, modName, morphName)
		
		while(StorageUtil.FloatListCount(kActor, "slif_" + modName + "_" + morphName + "_working_queue") > 0)
			float value = StorageUtil.FloatListShift(kActor, "slif_" + modName + "_" + morphName + "_working_queue")
			
			float new_value = 0
			int count = StorageUtil.StringListCount(kActor, "slif_morph_mod_list_" + morphName)
			int i = 0
			while(i < count)
				String mod = StorageUtil.StringListGet(kActor, "slif_morph_mod_list_" + morphName, i)
				if (mod == modName)
					new_value += value
				else
					new_value += StorageUtil.GetFloatValue(kActor, "slif_" + mod + "_" + morphName)
				endIf
				i += 1
			endWhile
			
			StorageUtil.SetFloatValue(kActor, "slif_" + morphName, new_value)
			
			SetAndUpdateMorphs(kActor, morphName, new_value)
		endWhile
		
		StorageUtil.UnsetIntValue(kActor, "slif_" + modName + "_" + morphName + "_working_queue")
	endIf
endFunction

function unregisterMorph(Actor kActor, String morphName, string modName) global
	if (!StorageUtil.HasIntValue(kActor, "slif_" + modName + "_" + morphName + "_working_deque"))
		StorageUtil.SetIntValue(kActor, "slif_" + modName + "_" + morphName + "_working_deque", 1)
		
		String name      = SLIF_Util.GetActorName(kActor)
		String aToString = SLIF_Util.ActorToString(kActor, name)
		
		if (modName == "All Mods")
			int modCount = StorageUtil.StringListCount(kActor, "slif_morph_mod_list")
			while(modCount > 1)
				modCount -= 1
				String mod = StorageUtil.StringListGet(kActor, "slif_morph_mod_list", modCount) as String
				unregisterMorph(kActor, morphName, mod)
			endWhile
			return
		endIf
		if (StorageUtil.HasFloatValue(kActor, "slif_" + modName + "_" + morphName))
			StorageUtil.UnsetFloatValue(kActor, "slif_" + modName + "_" + morphName)
			StorageUtil.UnsetFloatValue(kActor, "slif_" + modName + "_" + morphName + "_min")
			StorageUtil.UnsetFloatValue(kActor, "slif_" + modName + "_" + morphName + "_max")
			StorageUtil.UnsetFloatValue(kActor, "slif_" + modName + "_" + morphName + "_mult")
			StorageUtil.UnsetFloatValue(kActor, "slif_" + modName + "_" + morphName + "_increment")
			
			StorageUtil.StringListRemove(kActor, "slif_morph_list_" + modName, morphName)
			CheckIfMorphRelevantForActorRemoveIfNot(kActor, aToString, modName, morphName)
		endIf
		
		StorageUtil.UnsetIntValue(kActor, "slif_" + modName + "_" + morphName + "_working_deque")
	endIf
endFunction

function CalculateMorphValue(Actor kActor, String morphName) global
	float value = 0
	int count = StorageUtil.StringListCount(kActor, "slif_morph_mod_list_" + morphName)
	int i = 0
	while(i < count)
		String mod = StorageUtil.StringListGet(kActor, "slif_morph_mod_list_" + morphName, i)
		value += StorageUtil.GetFloatValue(kActor, "slif_" + mod + "_" + morphName)
		i += 1
	endWhile
	StorageUtil.SetFloatValue(kActor, "slif_" + morphName, value)
endFunction

function CheckIfMorphRelevantForActorRemoveIfNot(Actor kActor, String aToString, String modName, String morphName) global
	bool has_morph = false
	int modCount = StorageUtil.StringListCount(kActor, "slif_morph_mod_list")
	while(modCount > 1 && has_morph == false)
		modCount -= 1
		String mod = StorageUtil.StringListGet(kActor, "slif_morph_mod_list", modCount)
		if (StorageUtil.HasFloatValue(kActor, "slif_" + mod + "_" + morphName))
			has_morph = true
		endIf
	endWhile
	bool has_mod = false
	int count = StorageUtil.StringListCount(kActor, "slif_morph_list")
	int i = 0
	while(i < count && has_mod == false)
		String morph = StorageUtil.StringListGet(kActor, "slif_morph_list", i)
		if (StorageUtil.HasFloatValue(kActor, "slif_" + modName + "_" + morph))
			has_mod = true
		endIf
		i += 1
	endWhile
	if (has_mod == false)
		StorageUtil.StringListRemove(kActor, "slif_morph_mod_list", modName)
		StorageUtil.UnsetIntValue(kActor, modName + "slif_morph_initialize")
	endIf
	StorageUtil.StringListRemove(kActor, "slif_morph_mod_list_" + morphName, modName)
	CalculateMorphValue(kActor, morphName)
	if (has_morph == false)
		StorageUtil.StringListRemove(kActor, "slif_morph_list", morphName)
		UnsetAllModsKey(kActor, morphName)
	endIf
	if (StorageUtil.StringListCount(kActor, "slif_morph_mod_list") < 2)
		unregisterActorForAllMods(kActor, aToString)
	endIf
	SLIF_Util.SetModListCount(kActor, "slif_morph_mod_list")
	float value = StorageUtil.GetFloatValue(kActor, "slif_" + morphName)
	SetAndUpdateMorphs(kActor, morphName, value)
endFunction

function unregisterMod(Actor kActor, String aToString, string modName) global
	SLIF_Debug.Trace("[SLIF_Util] Unregistering Actor:  " + aToString + " for mod " + modName)
	
	int count = SLIF_Util.GetListSize("morph_lists", "000_morphs")
	int i = 0
	while (i < count)
		String morphName = SLIF_Util.GetListEntry("morph_lists", "000_morphs", i)
		unregisterMorph(kActor, morphName, modName)
		i += 1
	endWhile
endFunction

function unregisterActorForAllMods(Actor kActor, String aToString) global
	
	SLIF_Util.RemoveActorFromList(kActor, aToString, "slif_morph_actor")
	
	StorageUtil.StringListClear(kActor, "slif_morph_mod_list")
	
	SLIF_Util.UnsetIntValueConditional(kActor, "slif_morph_mod_list_count")
	
	SLIF_Util.UnsetIntValueConditional(kActor, "All Mods" + "slif_morph_initialize")
	
endFunction

bool function registerSLIF(Actor kActor, String name, String aToString) global
	bool isPlayer    = SLIF_Scale.IsPlayer(kActor)
	bool auto_npc    = SLIF_Config.GetInt("morph_auto_register_slif") as bool
	bool auto_player = SLIF_Config.GetInt("morph_auto_register_slif_player") as bool
	if ((isPlayer && auto_player) || (!isPlayer && auto_npc))
		registerModComplete(kActor, name, aToString, "SL Inflation Framework")
		return true
	endIf
	return false
endFunction

function registerModComplete(Actor kActor, String name, String aToString, String modName) global
	registerMod(kActor, name, aToString, modName)
	
	int count = SLIF_Util.GetListSize("morph_lists", "000_morphs")
	int i = 0
	while (i < count)
		String morphName = SLIF_Util.GetListEntry("morph_lists", "000_morphs", i)
		SLIF_Util.SetFloatValueConditional(kActor, "slif_" + modName + "_" + morphName,                0.0)
		SLIF_Util.SetFloatValueConditional(kActor, "slif_" + modName + "_" + morphName + "_min",       0.0)
		SLIF_Util.SetFloatValueConditional(kActor, "slif_" + modName + "_" + morphName + "_max",     100.0)
		SLIF_Util.SetFloatValueConditional(kActor, "slif_" + modName + "_" + morphName + "_mult",      1.0)
		SLIF_Util.SetFloatValueConditional(kActor, "slif_" + modName + "_" + morphName + "_increment", 0.1)
		StorageUtil.StringListAdd(kActor, "slif_morph_mod_list_" + morphName, modName, false)
		StorageUtil.StringListAdd(kActor, "slif_morph_list",            morphName, false)
		StorageUtil.StringListAdd(kActor, "slif_morph_list_" + modName, morphName, false)
		SetAllModsKey(kActor, morphName)
		i += 1
	endWhile
endFunction

function registerMod(Actor kActor, String name, String aToString, String modName) global
	if (!StorageUtil.HasIntValue(kActor, modName + "slif_morph_initialize"))
		SLIF_Util.SetIntValueConditional(kActor, modName    + "slif_morph_initialize", 1)
		SLIF_Util.SetIntValueConditional(kActor, "All Mods" + "slif_morph_initialize", 1)
		SLIF_Util.AddModToList(kActor, modName, "slif_morph_mod_list")
		SLIF_Debug.Notification(SLIF_Language.TargetRegistered(name, modName))
		SLIF_Debug.Trace("[SLIF_Util] Registering Actor:    " + aToString + " for mod " + modName)
	endIf
endFunction

function SetAllModsKey(Actor kActor, String morphName, float value = 0.0) global
	String modName = "All Mods"
	StorageUtil.StringListAdd(kActor, "slif_morph_list_" + modName, morphName, false)
	SLIF_Util.SetFloatValueConditional(kActor, "slif_" + modName + "_" + morphName, value)
endFunction

function UnsetAllModsKey(Actor kActor, String morphName) global
	String modName = "All Mods"
	StorageUtil.StringListRemove(kActor, "slif_morph_list_" + modName, morphName)
	SLIF_Util.UnsetFloatValueConditional(kActor, "slif_" + modName + "_" + morphName)
	SLIF_Util.UnsetFloatValueConditional(kActor, "slif_" + morphName)
endFunction

function setActorMorphsToValue(Actor kActor, String modName, float value, bool menu = false, String suffix = "") global
	if (modName == "All Mods")
		int modCount = StorageUtil.StringListCount(kActor, "slif_morph_mod_list")
		while (modCount > 1)
			modCount -= 1
			String tempMod = StorageUtil.StringListGet(kActor, "slif_morph_mod_list", modCount) as String
			setActorMorphsToValueByModName(kActor, tempMod, value, menu, suffix)
		endWhile
	else
		setActorMorphsToValueByModName(kActor, modName, value, menu, suffix)
	endIf
endFunction

function setActorMorphsToValueByModName(Actor kActor, String modName, float value, bool menu, String suffix) global
	int category     = StorageUtil.GetIntValue(kActor, "slif_morph_category_selection")
	String morphList = "000_morphs"
	if (menu)
		morphList    = SLIF_Util.GetListByCategory("morph_lists", category)
	endIf
	int count        = SLIF_Util.GetListSize("morph_lists", morphList)
	int i = 0
	while (i < count)
		String morphName = SLIF_Util.GetListEntry("morph_lists", morphList, i)
		if (StorageUtil.HasFloatValue(kActor, "slif_" + modName + "_" + morphName + suffix))
			if (suffix == "")
				SLIF_Morph.morph(kActor, modName, morphName, value)
			else
				SLIF_Util.SetFloatValueConditional(kActor, "slif_" + modName + "_" + morphName + suffix, value, true)
			endIf
		endIf
		i += 1
	endWhile
endFunction

function updateActor(Actor kActor, String aToString, string modName, string morphName, string oldModName, float minimum, float maximum, float multiplier, float increment, float value = -1000.0) global
	float start = Utility.GetCurrentRealTime()
	if (kActor)
	
		if (StorageUtil.HasIntValue(kActor, modName + "slif_morph_initialize"))
			
			if (value >= -100.0)
				SLIF_Debug.Trace("[SLIF_Util] Resetting Actor:      " + aToString + " for mod " + modName)
				setActorMorphsToValue(kActor, modName, value)
			else
				SLIF_Debug.Trace("[SLIF_Util] Updating Actor:       " + aToString + " for mod " + modName)
			endIf
			updateMorphs(kActor, aToString, modName, morphName, oldModName, minimum, maximum, multiplier, increment)
			SLIF_Scale.UpdateMorphs(kActor)
			
			float end = Utility.GetCurrentRealTime()
			if (value >= -100.0)
				SLIF_Debug.Trace("[SLIF_Util] Resetting Actor Done: " + aToString + " for mod " + modName + ", time_diff: " + (end - start))
			else
				SLIF_Debug.Trace("[SLIF_Util] Updating Actor Done:  " + aToString + " for mod " + modName + ", time_diff: " + (end - start))
			endIf
			
		endIf
	
	endIf
	
endFunction

function updateActorList(String modName, string morphName, string oldModName, float minimum, float maximum, float multiplier, float increment, float value = -1.0) global
	int count = StorageUtil.FormListCount(none, "slif_morph_actor_list")
	int i = 0
	while(i < count)
		Actor kActor     = StorageUtil.FormListGet(none, "slif_morph_actor_list", i) as Actor
		String name      = SLIF_Util.GetActorName(kActor)
		String aToString = SLIF_Util.ActorToString(kActor, name)
		updateActor(kActor, aToString, modName, morphName, oldModName, minimum, maximum, multiplier, increment, value)
		i+=1
	endWhile
endFunction

function updateMorphs(Actor kActor, String aToString, String modName, String morphName, String oldModName, float minimum, float maximum, float multiplier, float increment) global
	if (morphName != "")
		updateMorph(kActor, aToString, modName, morphName, oldModName, minimum, maximum, multiplier, increment)
	else
		int count = StorageUtil.StringListCount(kActor, "slif_morph_list_" + modName)
		int i = 0
		while (i < count)
			String morph = StorageUtil.StringListGet(kActor, "slif_morph_list_" + modName, i)
			updateMorphs(kActor, aToString, modName, morph, oldModName, minimum, maximum, multiplier, increment)
			i += 1
		endWhile
	endIf
endFunction

function updateMorph(Actor kActor, String aToString, String modName, String morphName, String oldModName, float minimum, float maximum, float multiplier, float increment) global
	updateDefaultValues(kActor, modName, morphName, minimum, maximum, multiplier, increment)
	if (StorageUtil.HasFloatValue(kActor, "slif_" + morphName))
		float start = Utility.GetCurrentRealTime()
		if (oldModName != "")
			NiOverride.ClearBodyMorph(kActor, morphName, oldModName)
		endIf
		float value = StorageUtil.GetFloatValue(kActor, "slif_" + morphName)
		SetAndUpdateMorphs(kActor, morphName, value)
		float end = Utility.GetCurrentRealTime()
		SLIF_Debug.Trace("[SLIF_Util] Updating Morph:       " + aToString + " morph: " + morphName + ", value: " + value + ", time_diff: " + (end - start))
	endIf
endFunction

function updateDefaultValues(Actor kActor, string modName, string morphName, float minimum, float maximum, float multiplier, float increment) global
	float min   = StorageUtil.GetFloatValue(kActor, "slif_" + modName + "_" + morphName + "_min",       SLIF_Util.GetDefaultMinimum(true))
	float max   = StorageUtil.GetFloatValue(kActor, "slif_" + modName + "_" + morphName + "_max",       SLIF_Util.GetDefaultMaximum())
	float mult  = StorageUtil.GetFloatValue(kActor, "slif_" + modName + "_" + morphName + "_mult",      SLIF_Util.GetDefaultMultiplier())
	float incr  = StorageUtil.GetFloatValue(kActor, "slif_" + modName + "_" + morphName + "_increment", SLIF_Util.GetDefaultIncrement())
	if (minimum != -1.0 && minimum != min)
		SLIF_Util.SetFloatValueConditional(kActor, "slif_" + modName + "_" + morphName + "_min", minimum, true)
	endIf
	if (maximum != -1.0 && maximum != max)
		SLIF_Util.SetFloatValueConditional(kActor, "slif_" + modName + "_" + morphName + "_max", maximum, true)
	endIf
	if (multiplier != -1.0 && multiplier != mult)
		SLIF_Util.SetFloatValueConditional(kActor, "slif_" + modName + "_" + morphName + "_mult", multiplier, true)
	endIf
	if (increment != -1.0 && increment != incr)
		SLIF_Util.SetFloatValueConditional(kActor, "slif_" + modName + "_" + morphName + "_increment", increment, true)
	endIf
endFunction

Function SetAndUpdateMorphs(Actor kActor, string morphName, float value) Global
	String slif            = "SexLab Inflation Framework.esp"
	;/
	String json            = "SexLab Inflation Framework/Bodymorphs.json"
	String[] breast_morphs = JsonUtil.PathMembers(json, ".breasts.")
	String[] belly_morphs  = JsonUtil.PathMembers(json, ".belly.")
	String[] butt_morphs   = JsonUtil.PathMembers(json, ".butt.")
	bool has_breasts       = StorageUtil.HasFloatValue(kActor, slif + "NPC L Breast") || StorageUtil.HasFloatValue(kActor, slif + "NPC R Breast")
	bool has_belly         = StorageUtil.HasFloatValue(kActor, slif + "NPC Belly")
	bool has_butt          = StorageUtil.HasFloatValue(kActor, slif + "NPC L Butt") || StorageUtil.HasFloatValue(kActor, slif + "NPC R Butt")
	float breast_value     = (StorageUtil.GetFloatValue(kActor, slif + "NPC L Breast", 1.0) + StorageUtil.GetFloatValue(kActor, slif + "NPC R Breast", 1.0)) / 2
	float belly_value      = StorageUtil.GetFloatValue(kActor, slif + "NPC Belly", 1.0)
	float butt_value       = (StorageUtil.GetFloatValue(kActor, slif + "NPC L Butt", 1.0) + StorageUtil.GetFloatValue(kActor, slif + "NPC R Butt", 1.0)) / 2
	bool isPlayer          = SLIF_Scale.IsPlayer(kActor)
	
	SLIF_Scale.SetBodyMorphs(kActor, slif, json, isPlayer, morphName, breast_morphs, belly_morphs, butt_morphs, has_breasts, has_belly, has_butt, breast_value, belly_value, butt_value)
	/;
	value += StorageUtil.GetFloatValue(kActor, "slif_scale_" + morphName)
	SLIF_Scale.SetBodyMorph(kActor, slif, morphName, value)
	SLIF_Scale.UpdateMorphs(kActor)
EndFunction

Function InitializeDefaultValues(Actor kActor, String aToString, String modName, String morphName, String oldModName, float minimum, float maximum, float multiplier, float increment) Global
	;TODO
EndFunction
