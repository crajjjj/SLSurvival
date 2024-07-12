Scriptname SLIF_Menu_Bodymorphs Hidden

Function OnPageReset(SLIF_Menu menu) Global
	menu.SetCursorFillMode(menu.LEFT_TO_RIGHT)
	
	String bodymorph            = GetBodyMorphTypes()[menu.CurrentSelection]
	String path                 = GetBodyMorphPathTypes()[menu.CurrentSelection]
	menu.OID_bodymorph          = menu.AddMenuOption("$Bodymorph", bodymorph)
	menu.OID_bodymorph_category = menu.AddMenuOption("$Category", GetBodyMorphCategories()[menu.CurrentCategory])
	menu.AddHeaderOption("$slif_set_values")
	menu.AddHeaderOption("$slif_set_values")
	menu.OID_bm_def_option      = SetupBodyMorphDefaultOption(menu, true)
	menu.OID_bm_def_option_npc  = SetupBodyMorphDefaultOption(menu, false)
	menu.OID_do_it              = menu.AddTextOption("$slif_set_default_value", "")
	menu.OID_do_it_npc          = menu.AddTextOption("$slif_set_default_value", "")
	menu.OID_copy_it            = menu.AddTextOption("$slif_copy_values", "")
	menu.OID_copy_it_npc        = menu.AddTextOption("$slif_copy_values", "")
	menu.AddHeaderOption("$Player")
	menu.AddHeaderOption("$NPCs")
	StorageUtil.IntListClear(menu, "slif_morph_oid_list")
	StorageUtil.StringListClear(menu, "slif_morph_member_list")
	int index         = GetIndexByCategory(menu)
	String json       = GetJsonByCategory(menu)
	if (menu.CurrentCategory == 0)
		AddNioOption(menu, index, "NiOverride", path, 100.0)
		StorageUtil.StringListAdd(menu, "slif_morph_member_list", "NiOverride")
	endIf
	String[] members  = JsonUtil.PathMembers(json, path)
	int idx = 0
	while(idx < members.length)
		String member = members[idx]
		if (menu.CurrentCategory == 0)
			if (member != "NiOverride")
				AddNioOption(menu, index, member, path, 0.0)
				StorageUtil.StringListAdd(menu, "slif_morph_member_list", member)
			endIf
		else
			int reverse = SLIF_Util.GetPathReverse(json, path, member) as int
			SetupBodyMorphOptions(menu, index, member, path, reverse)
			StorageUtil.StringListAdd(menu, "slif_morph_member_list", member)
		endIf
		idx += 1
	endWhile
EndFunction

Function OnOptionSelect(SLIF_Menu menu, int option) Global
	bool player      = GetPlayerByOID(menu, option)
	String member    = GetMemberFromOID(menu, option)
	float default    = GetBodyMorphDefault(menu.CurrentCategory, member)
	String json      = GetJsonByCategory(menu)
	String type      = GetMorphTypeByCategory(menu)
	String path      = GetBodyMorphPathTypes()[menu.CurrentSelection]
	bool reverse     = SLIF_Util.GetPathReverse(json, path, member)
	float value      = GetValueByPlayer(menu, player, default)
	bool doit        = option == menu.OID_do_it || option == menu.OID_do_it_npc
	bool copy        = option == menu.OID_copy_it || option == menu.OID_copy_it_npc
	String interval  = GetIntervalByCategory(menu)
	if (doit || copy)
		String[] members = JsonUtil.PathMembers(json, path)
		int size         = members.length
		int idx          = 0
		while(idx < size)
			member  = members[idx]
			int oid = StorageUtil.IntListGet(menu, "slif_morph_oid_list", ((StorageUtil.StringListFind(menu, "slif_morph_member_list", member) * 2) + ((!player) as int)))
			if (menu.CurrentCategory == 0)
				default = SLIF_Util.GetDefaultValueNiOverride(member)
			elseIf (menu.CurrentCategory == 2)
				default = SLIF_Util.GetPathReverse(json, path, member) as float
			endIf
			int index = GetIndexByCategory(menu)
			if (copy)
				value = SLIF_Morphs.GetValue(type, path, member, index, !player, default)
			endIf
			if (SLIF_Morphs.GetValue(type, path, member, index, player, default) != value)
				SLIF_Morphs.SetValue(type, path, member, index, player, value)
				if (menu.CurrentCategory == 2)
					menu.SetToggleOptionValue(oid, value as bool)
				else
					menu.SetSliderOptionValue(oid, value, interval)
				endIf
			endIf
			idx += 1
		endWhile
	elseIf (option == menu.OID_bm_def_option || option == menu.OID_bm_def_option_npc)
		if (menu.CurrentCategory == 2)
			int toggle = Math.LogicalXor(1, value as int)
			SetValueByPlayer(menu, player, toggle)
			menu.SetToggleOptionValue(option, toggle as bool)
		endIf
	else
		if (menu.CurrentCategory == 2)
			int index = GetIndexByCategory(menu)
			int toggle = Math.LogicalXor(1, SLIF_Morphs.GetValue(type, path, member, index, player, reverse as int) as int)
			SLIF_Morphs.SetValue(type, path, member, index, player, toggle)
			menu.SetToggleOptionValue(option, toggle as bool)
		endIf
	endIf
EndFunction

Function OnOptionMenuOpen(SLIF_Menu menu, int option) Global
	if (option == menu.OID_bodymorph)
		menu.OpenMenu(GetBodyMorphTypes(), menu.CurrentSelection, 0)
	elseIf (option == menu.OID_bodymorph_category)
		menu.OpenMenu(GetBodyMorphCategories(), menu.CurrentCategory, 0)
	endIf
EndFunction

Function OnOptionMenuAccept(SLIF_Menu menu, int option, int index) Global
	if (option == menu.OID_bodymorph)
		if (StorageUtil.GetIntValue(menu, "slif_bodymorph_selection") != index)
			StorageUtil.SetIntValue(menu, "slif_bodymorph_selection", index)
			ResetBodyMorphDefaultOptions(menu, StorageUtil.GetIntValue(menu, "slif_bodymorph_category"))
			menu.ForcePageReset()
		endIf
	elseIf (option == menu.OID_bodymorph_category)
		if (StorageUtil.GetIntValue(menu, "slif_bodymorph_category") != index)
			StorageUtil.SetIntValue(menu, "slif_bodymorph_category", index)
			ResetBodyMorphDefaultOptions(menu, index)
			menu.ForcePageReset()
		endIf
	endIf
EndFunction

Function OnOptionSliderOpen(SLIF_Menu menu, int option) Global
	bool player    = GetPlayerByOID(menu, option)
	String member  = GetMemberFromOID(menu, option)
	float default  = GetBodyMorphDefault(menu.CurrentCategory, member)
	String json    = GetJsonByCategory(menu)
	String type    = GetMorphTypeByCategory(menu)
	String path    = GetBodyMorphPathTypes()[menu.CurrentSelection]
	bool reverse   = SLIF_Util.GetPathReverse(json, path, member)
	float value    = GetValueByPlayer(menu, player, default)
	if (option == menu.OID_bm_def_option || option == menu.OID_bm_def_option_npc)
		if (menu.CurrentCategory <=  1)
			menu.SetSliderOpen(value, default, 0.0, 1000.0, 0.01)
		elseIf (menu.CurrentCategory == 3)
			menu.SetSliderOpen(value, default, 5.0,  100.0, 5.0)
		elseIf (menu.CurrentCategory == 4)
			menu.SetSliderOpen(value, default, 0.0,    1.0, 0.01)
		elseIf (menu.CurrentCategory == 5)
			menu.SetSliderOpen(value, default, 5.0,  100.0, 5.0)
		endIf
	else
		int index = GetIndexByCategory(menu)
		value = SLIF_Morphs.GetValue(type, path, member, index, player, default)
		if (menu.CurrentCategory <=  1)
			menu.SetSliderOpen(value, default, 0.0, 1000.0, 0.01)
		elseIf (menu.CurrentCategory == 3)
			menu.SetSliderOpen(value, default, 5.0,  100.0, 5.0)
		elseIf (menu.CurrentCategory == 4)
			menu.SetSliderOpen(value, default, 0.0,    1.0, 0.01)
		elseIf (menu.CurrentCategory == 5)
			menu.SetSliderOpen(value, default, 5.0,  100.0, 5.0)
		endIf
	endIf
EndFunction

Function OnOptionSliderAccept(SLIF_Menu menu, int option, float value) Global
	bool player     = GetPlayerByOID(menu, option)
	String member   = GetMemberFromOID(menu, option)
	float default   = GetBodyMorphDefault(menu.CurrentCategory, member)
	String json     = GetJsonByCategory(menu)
	String type     = GetMorphTypeByCategory(menu)
	String path     = GetBodyMorphPathTypes()[menu.CurrentSelection]
	bool reverse    = SLIF_Util.GetPathReverse(json, path, member)
	String interval = GetIntervalByCategory(menu)
	if (option == menu.OID_bm_def_option || option == menu.OID_bm_def_option_npc)
		if (menu.CurrentCategory != 2)
			if (GetValueByPlayer(menu, player, default) != value)
				SetValueByPlayer(menu, player, value)
				menu.SetSliderOptionValue(option, value, interval)
			endIf
		endIf
	else
		if (menu.CurrentCategory != 2)
			SetPathSliderFloatValue(menu, option, type, path, member, player, value, default)
		endIf
	endIf
EndFunction

Function OnOptionDefault(SLIF_Menu menu, int option) Global
	bool player     = GetPlayerByOID(menu, option)
	String member   = GetMemberFromOID(menu, option)
	float default   = GetBodyMorphDefault(menu.CurrentCategory, member)
	String json     = GetJsonByCategory(menu)
	String type     = GetMorphTypeByCategory(menu)
	String path     = GetBodyMorphPathTypes()[menu.CurrentSelection]
	bool reverse    = SLIF_Util.GetPathReverse(json, path, member)
	float value     = GetValueByPlayer(menu, player, default)
	String interval = GetIntervalByCategory(menu)
	if (option == menu.OID_bm_def_option || option == menu.OID_bm_def_option_npc)
		if (value != default)
			SetValueByPlayer(menu, player, default)
			if (menu.CurrentCategory == 2)
				menu.SetToggleOptionValue(option, default as bool)
			else
				menu.SetSliderOptionValue(option, default, interval)
			endIf
		endIf
	else
		if (menu.CurrentCategory == 2)
			int toggle = reverse as int
			SetPathToggleIntValue(  menu, option, type, path, member, player, toggle, toggle)
		else
			SetPathSliderFloatValue(menu, option, type, path, member, player, default, default)
		endIf
	endIf
EndFunction

Function OnOptionHighlight(SLIF_Menu menu, int option) Global
	if (option == menu.OID_bodymorph)
	elseIf (option == menu.OID_bodymorph_category)
	else
	endIf
EndFunction

String[] Function GetBodyMorphCategories() Global
	String[] categories = new String[6]
	categories[0] = "NiOverride"
	categories[1] = "$Percentages"
	categories[2] = "$Reverse_Scaling"
	categories[3] = "$Steps"
	categories[4] = "$Minimum"
	categories[5] = "$Maximum"
	return categories
EndFunction

Int Function SetupBodyMorphDefaultOption(SLIF_Menu menu, bool player) Global
	float default   = GetBodyMorphDefault(menu.CurrentCategory)
	float value     = GetValueByPlayer(menu, player, default)
	String interval = GetIntervalByCategory(menu)
	if (menu.CurrentCategory == 2)
		return menu.AddToggleOption("$slif_default_value", value as bool)
	endIf
	return menu.AddSliderOption("$slif_default_value", value, interval)
EndFunction

bool Function GetPlayerByOID(SLIF_Menu menu, int option) Global
	if (option == menu.OID_bm_def_option_npc || option == menu.OID_copy_it_npc || option == menu.OID_do_it_npc)
		return false
	endIf
	int index = StorageUtil.IntListFind(menu, "slif_morph_oid_list", option)
	if (index != -1)
		return index % 2 == 0
	endIf
	return true
EndFunction

String Function GetMemberFromOID(SLIF_Menu menu, int option) Global
	int index = StorageUtil.IntListFind(menu, "slif_morph_oid_list", option)
	if (index != -1)
		if (index % 2 == 1)
			index -= 1
		endIf
		index /= 2
		return StorageUtil.StringListGet(menu, "slif_morph_member_list", index)
	endIf
	return ""
EndFunction

float Function GetBodyMorphDefault(int category, String member = "") Global
	if (category == 0 && member == "NiOverride")
		return 100.0
	elseIf (category == 3)
		return 10.0
	elseIf (category == 5)
		return 20.0
	endIf
	return  0.0
EndFunction

String Function GetIntervalByCategory(SLIF_Menu menu) Global
	if (menu.CurrentCategory <= 1)
		return menu.Interval + "%"
	elseIf (menu.CurrentCategory == 4)
		return menu.Interval
	endIf
	return "{0}"
EndFunction

int Function GetIndexByCategory(SLIF_Menu menu) Global
	if (menu.CurrentCategory > 0)
		return menu.CurrentCategory - 1
	endIf
	return 0
EndFunction

String Function GetJsonByCategory(SLIF_Menu menu) Global
	if (menu.CurrentCategory == 0)
		return menu.nioverride_json
	endIf
	return menu.bodymorphs_json
EndFunction

Function SetupBodyMorphOptions(SLIF_Menu menu, int index, String type, String path, int reverse) Global
	SetupBodyMorphOption(menu, index, type, path, reverse, true)
	SetupBodyMorphOption(menu, index, type, path, reverse, false)
EndFunction

Function SetupBodyMorphOption(SLIF_Menu menu, int index, String type, String path, int reverse, bool player) Global
	if (menu.CurrentCategory == 1)
		StorageUtil.IntListAdd(menu, "slif_morph_oid_list", menu.AddSliderOption(type, SLIF_Morphs.GetValue("BodyMorph", path, type, index, player), menu.Interval + "%"))
	elseIf (menu.CurrentCategory == 2)
		StorageUtil.IntListAdd(menu, "slif_morph_oid_list", menu.AddToggleOption(type, SLIF_Morphs.GetValue("BodyMorph", path, type, index, player, reverse) as bool))
	elseIf (menu.CurrentCategory == 3)
		StorageUtil.IntListAdd(menu, "slif_morph_oid_list", menu.AddSliderOption(type, SLIF_Morphs.GetValue("BodyMorph", path, type, index, player, 10.0)))
	elseIf (menu.CurrentCategory == 4)
		StorageUtil.IntListAdd(menu, "slif_morph_oid_list", menu.AddSliderOption(type, SLIF_Morphs.GetValue("BodyMorph", path, type, index, player), menu.Interval))
	elseIf (menu.CurrentCategory == 5)
		StorageUtil.IntListAdd(menu, "slif_morph_oid_list", menu.AddSliderOption(type, SLIF_Morphs.GetValue("BodyMorph", path, type, index, player, 20.0)))
	endIf
EndFunction

Float Function GetValueByPlayer(SLIF_Menu menu, bool player, float default) Global
	if (player)
		return StorageUtil.GetFloatValue(menu, "slif_player_value", default)
	endIf
	return StorageUtil.GetFloatValue(menu, "slif_npc_value", default)
EndFunction

Function SetValueByPlayer(SLIF_Menu menu, bool player, float value) Global
	if (player)
		StorageUtil.SetFloatValue(menu, "slif_player_value", value)
	else
		StorageUtil.SetFloatValue(menu, "slif_npc_value", value)
	endIf
EndFunction

Function ResetBodyMorphDefaultOptions(SLIF_Menu menu, int category) Global
	float value = GetBodyMorphDefault(category)
	StorageUtil.SetFloatValue(menu, "slif_player_value", value)
	StorageUtil.SetFloatValue(menu, "slif_npc_value",    value)
EndFunction

Function SetPathSliderFloatValue(SLIF_Menu menu, int oid, String type, String path, String member, bool player, float value, float default) Global
	int index = GetIndexByCategory(menu)
	String interval = GetIntervalByCategory(menu)
	if (SLIF_Morphs.GetValue(type, path, member, index, player, default) != value)
		SLIF_Morphs.SetValue(type, path, member, index, player, value)
		menu.SetSliderOptionValue(oid, value, interval)
	endIf
EndFunction

Function SetPathToggleIntValue(SLIF_Menu menu, int oid, String type, String path, String member, bool player, int toggle, int default) Global
	int index = GetIndexByCategory(menu)
	if (SLIF_Morphs.GetValue(type, path, member, index, player, default) != toggle)
		SLIF_Morphs.SetValue(type, path, member, index, player, toggle)
		menu.SetToggleOptionValue(oid, toggle as bool)
	endIf
EndFunction

String[] Function GetBodyMorphTypes() Global
	String[] bodymorphs = new String[3]
	bodymorphs[0] = "$Breasts"
	bodymorphs[1] = "$Belly"
	bodymorphs[2] = "$Butt"
	return bodymorphs
EndFunction

String[] Function GetBodyMorphPathTypes() Global
	String[] bodymorphs = new String[3]
	bodymorphs[0] = ".breasts."
	bodymorphs[1] = ".belly."
	bodymorphs[2] = ".butt."
	return bodymorphs
EndFunction

String Function GetMorphTypeByCategory(SLIF_Menu menu) Global
	if (menu.CurrentCategory > 0)
		return "BodyMorph"
	endIf
	return "NiOverride"
EndFunction

Function AddNioOption(SLIF_Menu menu, int index, String type, String path, float value) Global
	StorageUtil.IntListAdd(menu, "slif_morph_oid_list", menu.AddSliderOption(type, SLIF_Morphs.GetValue("NiOverride", path, type, index, true,  value), menu.Interval + "%"))
	StorageUtil.IntListAdd(menu, "slif_morph_oid_list", menu.AddSliderOption(type, SLIF_Morphs.GetValue("NiOverride", path, type, index, false, value), menu.Interval + "%"))
EndFunction
