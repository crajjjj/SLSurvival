Scriptname SLIF_Menu_Preset Hidden

Function OnPageReset(SLIF_Menu menu, float value) Global
	menu.SetCursorFillMode(menu.LEFT_TO_RIGHT)
	
	menu.AddMenuOptionST("CurrentModus", "$slif_current_modus", menu.CurrentModus)
	if (!menu.morph_modus)
		menu.AddSliderOptionST("CurrentListSize", "$slif_current_list_size", menu.CurrentListSize)
		menu.AddEmptyOption()
		menu.AddSliderOptionST("CurrentListIndex", "$slif_current_list_index", StorageUtil.GetIntValue(menu, "slif_current_list_index") + 1)
	endIf
	
	menu.SetCursorFillMode(menu.TOP_TO_BOTTOM)
	
	if (menu.CurrentMod != "" && !menu.morph_modus);TODO preset functions excluded for morphs atm
		menu.AddEmptyOption()
		menu.AddEmptyOption()
		
		menu.OID_category = menu.AddMenuOption("$Category", menu.CurrentCategoryList)
		menu.OID_modus    = menu.AddMenuOption("$slif_current_modus", menu.CurrentModusList)
		
		menu.SetCursorPosition(5)
		
		menu.OID_mods        = menu.AddMenuOption("$slif_current_mod", menu.SetModName(menu.CurrentMod))
		menu.OID_mod_list    = menu.AddSliderOption("$slif_mod_list", SLIF_Config.ModCount() / 128 + 1)
		menu.OID_action_type = menu.AddMenuOption("$slif_action_type", "$slif_no_action")
		if (menu.CurrentModusList == "$slif_inflation_type")
			menu.OID_current_value = menu.AddMenuOption("$slif_current_value", menu.GetInflationTypes()[value as int])
		else
			menu.OID_current_value = menu.AddSliderOption("$slif_current_value", value, menu.Interval)
		endIf
		
		menu.AddEmptyOption()
		
		menu.SetCursorFillMode(menu.LEFT_TO_RIGHT)
		
		menu.SetCursorPosition(12)
		
		int i = 0
		int count = menu.CurrentListSize
		if (((StorageUtil.GetIntValue(menu, "slif_current_list_index") + 1) * menu.CurrentListSize) > StorageUtil.StringListCount(menu, "slif_valid_key_list"))
			count = StorageUtil.StringListCount(menu, "slif_valid_key_list") % menu.CurrentListSize
		endIf
		while(i < count)
			String sKey = StorageUtil.StringListGet(menu, "slif_valid_key_list", (StorageUtil.GetIntValue(menu, "slif_current_list_index") * menu.CurrentListSize) + i)
			int oid     = AddPresetSliderOption(menu, sKey)
			StorageUtil.IntListAdd(menu, "slif_oid_list", oid)
			i += 1
		endWhile
		
	endIf
EndFunction

Function OnOptionMenuOpen(SLIF_Menu menu, int option) Global
	if (option == menu.OID_current_value)
		if (menu.CurrentMod != "")
			menu.OpenMenu(menu.GetInflationTypes(), StorageUtil.GetFloatValue(menu, "slif_current_value", menu.CurrentDefault) as int, menu.CurrentDefault as int)
		endIf
	elseIf (option == menu.OID_mods)
		String[] slice = new String[128]
		JsonUtil.StringListSlice(menu.modlist_json, "mod_list", slice, menu.GetModListStartIndex(none))
		if (slice[0] == "All Mods")
			slice[0] = "$" + slice[0]
		endIf
		menu.OpenMenu(slice, StorageUtil.GetIntValue(menu, "slif_mod_selection"), 0)
	elseIf (option == menu.OID_action_type)
		menu.OpenMenu(menu.GetPresetActionTypes(), 0, 0)
	elseIf (option == menu.OID_modus)
		if (menu.CurrentMod != "")
			menu.OpenMenu(menu.GetModusList(), menu.CurrentSelection, 0)
		endIf
	elseIf (option == menu.OID_category)
		if (menu.CurrentMod != "")
			menu.OpenMenu(menu.GetCategories(), menu.CurrentCategory, 0)
		endIf
	else
		if (menu.CurrentMod != "")
			PresetListOpen(menu, option)
		endIf
	endIf
EndFunction

Function OnOptionMenuAccept(SLIF_Menu menu, int option, int index) Global
	if (option == menu.OID_current_value)
		if (menu.CurrentMod != "")
			if (StorageUtil.GetFloatValue(menu, "slif_current_value", menu.CurrentDefault) as int != index)
				StorageUtil.SetFloatValue(menu, "slif_current_value", index)
				menu.SetMenuOptionValue(option, menu.GetInflationTypes()[index])
			endIf
		endIf
	elseIf (option == menu.OID_mods)
		if (StorageUtil.GetIntValue(menu, "slif_mod_selection") != index)
			StorageUtil.SetIntValue(menu, "slif_mod_selection", index)
			menu.ForcePageReset()
		endIf
	elseIf (option == menu.OID_action_type)
		if (index == 1 && menu.CurrentMod != "")
			bool changed = false
			float value  = StorageUtil.GetFloatValue(menu, "slif_current_value", menu.CurrentDefault)
			int intValue = value as int
			
			if (SLIF_Config.GetInflationType(menu.CurrentMod, 1) != intValue && menu.CurrentModusList == "$slif_inflation_type" && menu.CurrentCategory == 0 && !menu.morph_modus)
				SLIF_Config.SetInflationType(menu.CurrentMod, intValue)
				changed = true
			endIf
			
			String prefix = menu.GetMorphPrefix()
			String lists  = menu.GetDefaultLists()
			String list   = SLIF_Util.GetListByCategory(lists, menu.CurrentCategory)
			int count     = SLIF_Util.GetListSize(lists, list)
			int i         = 0
			while(i < count)
				String node     = SLIF_Util.GetListEntry(lists, list, i)
				bool has_values = SLIF_Preset.FloatListHasValues(menu.CurrentMod, prefix + node)
				if (SLIF_Preset.FloatListGet(menu.CurrentMod, prefix + node, menu.CurrentSelection, menu.CurrentDefault) != value && has_values) || (menu.CurrentDefault != value && !has_values)
					SLIF_Preset.FloatListSet(menu.CurrentMod, prefix + node, menu.CurrentSelection, value)
					changed = true
				endIf
				i += 1
			endWhile
			
			if (changed)
				menu.ForcePageReset()
			endIf
		endIf
	elseIf (option == menu.OID_modus)
		if (menu.CurrentMod != "")
			if (menu.GetModusSelection() != index)
				menu.SetModusSelection(index)
				StorageUtil.SetFloatValue(menu, "slif_current_value", menu.GetDefValue(menu.GetModusList()[index]))
				menu.ForcePageReset()
			endIf
		endIf
	elseIf (option == menu.OID_category)
		if (menu.CurrentMod != "")
			if (menu.GetCategorySelection() != index)
				menu.SetCategorySelection(index)
				menu.ForcePageReset()
			endIf
		endIf
	else
		if (menu.CurrentMod != "")
			SetPresetValue(menu, option, index)
		endIf
	endIf
EndFunction

Function OnOptionSliderOpen(SLIF_Menu menu, int option) Global
	if (option == menu.OID_mod_list)
		int list = StorageUtil.GetIntValue(menu, "slif_current_mod_list")
		menu.SetSliderOpen(list + 1, 1, 1, SLIF_Config.ModCount() / 128 + 1, 1)
	else
		if (menu.CurrentMod != "")
			PresetListOpen(menu, option)
		endIf
	endIf
EndFunction

Function OnOptionSliderAccept(SLIF_Menu menu, int option, float value) Global
	if (option == menu.OID_mod_list)
		int intValue = value as int
		int minusOne = (intValue - 1)
		if (StorageUtil.GetIntValue(menu, "slif_current_mod_list") != minusOne)
			StorageUtil.SetIntValue(menu, "slif_mod_selection", 0)
			StorageUtil.SetIntValue(menu, "slif_current_mod_list", minusOne)
			menu.SetSliderOptionValue(option, intValue)
			menu.ForcePageReset()
		endIf
	else
		if (menu.CurrentMod != "")
			SetPresetValue(menu, option, value)
		endIf
	endIf
EndFunction

Function OnOptionDefault(SLIF_Menu menu, int option) Global
	if (menu.CurrentMod != "")
		SetPresetValue(menu, option, menu.CurrentDefault)
	endIf
EndFunction

Function OnOptionHighlight(SLIF_Menu menu, int option) Global
	if (option == menu.OID_modus)
		menu.SetInfoText("$slif_current_modus_info")
	elseIf (option == menu.OID_category)
		menu.SetInfoText("$CategoryInfo")
	elseIf (option == menu.OID_actors)
		menu.SetInfoText("$slif_current_actor_info")
	elseIf (option == menu.OID_actor_list)
		menu.SetInfoText("$slif_actor_list_info")
	elseIf (option == menu.OID_mods)
		menu.SetInfoText("$slif_current_mod_info")
	elseIf (option == menu.OID_mod_list)
		menu.SetInfoText("$slif_mod_list_info")
	elseIf (option == menu.OID_action_type)
		menu.SetInfoText("$slif_action_type_info")
	elseIf (option == menu.OID_current_value)
		menu.SetInfoText("$slif_current_value_info")
	endIf
EndFunction

int Function AddPresetSliderOption(SLIF_Menu menu, String node) Global
	float default = SLIF_Preset.FloatListGet(menu.CurrentMod, menu.GetMorphPrefix() + node, menu.CurrentSelection, menu.CurrentDefault)
	if (menu.CurrentModusList == "$slif_inflation_type")
		return menu.AddMenuOption(node, menu.GetInflationTypes()[default as int])
	endIf
	return menu.AddSliderOption(node, default, menu.Interval)
EndFunction

Function PresetListOpen(SLIF_Menu menu, int option) Global
	int index = StorageUtil.IntListFind(menu, "slif_oid_list", option)
	if (index != -1)
		String prefix = menu.GetMorphPrefix()
		String sKey   = StorageUtil.StringListGet(menu, "slif_valid_key_list", (StorageUtil.GetIntValue(menu, "slif_current_list_index") * menu.CurrentListSize) + index)
		float value   = SLIF_Preset.FloatListGet(menu.CurrentMod, prefix + sKey, menu.CurrentSelection, menu.CurrentDefault)
		if (menu.CurrentModusList == "$slif_inflation_type")
			menu.OpenMenu(menu.GetInflationTypes(), value as int, menu.CurrentDefault as int)
		else
			menu.SetSliderOpen(value, menu.CurrentDefault, menu.CurrentMinimum, menu.CurrentMaximum, menu.CurrentInterval)
		endIf
	endIf
EndFunction

Function SetPresetValue(SLIF_Menu menu, int option, float value) Global
	int index = StorageUtil.IntListFind(menu, "slif_oid_list", option)
	if (index != -1)
		String prefix = menu.GetMorphPrefix()
		String sKey   = StorageUtil.StringListGet(menu, "slif_valid_key_list", (StorageUtil.GetIntValue(menu, "slif_current_list_index") * menu.CurrentListSize) + index)
		if (SLIF_Preset.FloatListGet(menu.CurrentMod, prefix + sKey, menu.CurrentSelection, menu.CurrentDefault) != value)
			SLIF_Preset.FloatListSet(menu.CurrentMod, prefix + sKey, menu.CurrentSelection, value)
			if (menu.CurrentModusList == "$slif_inflation_type")
				menu.SetMenuOptionValue(option, menu.GetInflationTypes()[value as int])
			else
				menu.SetSliderOptionValue(option, value, menu.Interval)
			endIf
		endIf
	endIf
EndFunction
