Scriptname SLIF_Menu extends SKI_ConfigBase
;/
	You can find the Documentation in the following places:
		- SLIF_Main.psc
		- on my blog: https://www.loverslab.com/blog/396/entry-2043-sexlab-inflation-framework-implementation/
/;
Actor Property PlayerRef Auto

String Property Interval = "{2}" Auto Hidden

int Property OID_languages Auto Hidden

int Property OID_actors Auto Hidden
int Property OID_mods Auto Hidden
int Property OID_mod_list Auto Hidden
int Property OID_modus Auto Hidden
int Property OID_category Auto Hidden

int Property OID_actor_list Auto Hidden

int Property OID_register_player Auto Hidden

int Property OID_uninstall_mod Auto Hidden

int Property OID_action_type Auto Hidden
int Property OID_current_value Auto Hidden
int Property OID_search_npc Auto Hidden
int Property OID_rename_npc Auto Hidden

int Property OID_move_npc_to_player Auto Hidden
int Property OID_move_player_to_npc Auto Hidden

int Property OID_gender Auto Hidden

int Property OID_inflation_type Auto Hidden

int Property OID_calculation_type Auto Hidden

int Property OID_sort_type Auto Hidden

int Property OID_sort_actor_list Auto Hidden

int Property OID_top_x Auto Hidden

int Property OID_update_interval Auto Hidden
int Property OID_scanner_range Auto Hidden

int Property OID_scanner_active Auto Hidden
int Property OID_scanner_on_load Auto Hidden
int Property OID_scanner_over_time Auto Hidden
int Property OID_scanner_on_sleep Auto Hidden
int Property OID_scanner_purge_dead Auto Hidden
int Property OID_scanner_update_actors Auto Hidden

int Property OID_notification Auto Hidden
int Property OID_debug Auto Hidden
int Property OID_hidden Auto Hidden
int Property OID_auto_register_slif Auto Hidden
int Property OID_auto_register_slif_player Auto Hidden
int Property OID_morph_auto_register_slif Auto Hidden
int Property OID_morph_auto_register_slif_player Auto Hidden
int Property OID_non_unique_npcs_use_nio Auto Hidden
int Property OID_inflate_on_menu_exit Auto Hidden
int Property OID_treat_trans_as_male Auto Hidden
int Property OID_treat_male_as_female Auto Hidden

int Property OID_bodymorph Auto Hidden
int Property OID_bodymorph_category Auto Hidden

int Property OID_timer_active Auto Hidden

int Property OID_inflate_scrotum_update Auto Hidden
int Property OID_inflate_scrotum Auto Hidden
int Property OID_deflate_scrotum Auto Hidden
int Property OID_inflate_scrotum_min Auto Hidden
int Property OID_inflate_scrotum_max Auto Hidden
int Property OID_inflate_scrotum_absolute_max Auto Hidden

int Property OID_bm_def_option Auto Hidden
int Property OID_bm_def_option_npc Auto Hidden

int Property OID_do_it Auto Hidden
int Property OID_do_it_npc Auto Hidden

int Property OID_copy_it Auto Hidden
int Property OID_copy_it_npc Auto Hidden

Actor Property CrosshairRef Auto Hidden

Actor Property CurrentActor Auto Hidden
String Property CurrentName Auto Hidden
String Property CurrentNameToString Auto Hidden

String Property CurrentMod Auto Hidden
int Property CurrentSelection Auto Hidden
String Property CurrentModusList Auto Hidden
int Property CurrentCategory Auto Hidden
String Property CurrentCategoryList Auto Hidden
String Property CurrentSuffix Auto Hidden
float Property CurrentDefault Auto Hidden
float Property CurrentMinimum Auto Hidden
float Property CurrentMaximum Auto Hidden
float Property CurrentInterval Auto Hidden

String Property CurrentModus = "$Default_Modus" Auto Hidden
bool Property morph_modus = false Auto Hidden

int Property CurrentIndex Auto Hidden

int Property CurrentListSize = 30 Auto Hidden

String Property FilterByCategory = "$All Categories" Auto Hidden

String Property slif_actor = "slif_actor" Auto Hidden
String Property slif_actor_list = "slif_actor_list" Auto Hidden
String Property slif_actor_name_list = "slif_actor_name_list" Auto Hidden
String Property slif_mod_list = "slif_mod_list" Auto Hidden
String Property slif_mod_selection = "slif_mod_selection" Auto Hidden
String Property slif_current_mod_list = "slif_current_mod_list" Auto Hidden
String Property slif_modus_selection = "slif_modus_selection" Auto Hidden
String Property slif_category_selection = "slif_category_selection" Auto Hidden
String Property slif_actor_selection = "slif_actor_selection" Auto Hidden
String Property slif_current_actor_list = "slif_current_actor_list" Auto Hidden

String Property nioverride_json = "SexLab Inflation Framework/NiOverride.json" Auto Hidden
String Property bodymorphs_json = "SexLab Inflation Framework/Bodymorphs.json" Auto Hidden
String Property config_json     = "SexLab Inflation Framework/Config.json" Auto Hidden
String Property presets_json    = "SexLab Inflation Framework/Presets.json" Auto Hidden
String Property modlist_json    = "SexLab Inflation Framework/Modlist.json" Auto Hidden
String Property lists_json      = "SexLab Inflation Framework/Lists.json" Auto Hidden

Function StartScanner()
	SLIF_Scanner Scanner = Game.GetFormFromFile(0x801, "SexLab Inflation Framework.esp") as SLIF_Scanner
	if (Scanner.IsRunning() == false)
		SLIF_Debug.Trace("[SLIF_Menu] Starting Scanner")
		Scanner.RegisterForSingleUpdate(0.1)
	endIf
EndFunction

Function StopScanner()
	SLIF_Scanner Scanner = Game.GetFormFromFile(0x801, "SexLab Inflation Framework.esp") as SLIF_Scanner
	if (Scanner.IsStopped() == false)
		SLIF_Debug.Trace("[SLIF_Menu] Stopping Scanner")
		Scanner.UnregisterForUpdate()
		Scanner.Stop()
	endIf
EndFunction

Function StartTimer()
	SLIF_Timer Timer = Game.GetFormFromFile(0x801, "SexLab Inflation Framework.esp") as SLIF_Timer
	SLIF_Debug.Trace("[SLIF_Menu] Starting Timer")
	Timer.initializeTimer(0.1)
EndFunction

Function StopTimer()
	SLIF_Timer Timer = Game.GetFormFromFile(0x801, "SexLab Inflation Framework.esp") as SLIF_Timer
	SLIF_Debug.Trace("[SLIF_Menu] Stopping Timer")
	Timer.uninstallTimer()
EndFunction

int Function GetVersion()
	return SLIF_Main.GetScriptVersion()
EndFunction

Event OnVersionUpdate(int version)
	if (version > CurrentVersion && CurrentVersion != 0)
		StorageUtil.SetIntValue(none, "slif_updating", 1)
        Debug.Trace(self + ": Updating script to version " + version)
        Debug.Notification(SLIF_Language.VersionUpdate(version))
		float start = Utility.GetCurrentRealTime()
		SLIF_Debug.Trace("[SLIF_Menu] Updating script to version " + version)
		self.install()
		Debug.Trace(self + ": Done updating script to version " + version)
        Debug.Notification(SLIF_Language.VersionUpdateDone())
		float end = Utility.GetCurrentRealTime()
		SLIF_Debug.Trace("[SLIF_Menu] Updating done, time_diff: " + (end - start))
		StorageUtil.UnsetIntValue(none, "slif_updating")
	endIf
EndEvent

Event OnConfigInit()
	
	Debug.Notification(SLIF_Language.SetupStarted())
	SLIF_Debug.Trace("Setup started!")
	
	self.install()
	
	Debug.Notification(SLIF_Language.SetupFinished())
	SLIF_Debug.Trace("Setup finished!")
	
EndEvent

Event OnConfigOpen()
	
	StorageUtil.SetIntValue(self, "slif_in_menu", 1)
	
	self.Interval = "{2}"
	
	self.Pages = new String[9]
	self.Pages[0] = "$Config"
	self.Pages[1] = "$Toggles"
	self.Pages[2] = "$Values_and_sliders"
	self.Pages[3] = "$Bodymorphs"
	self.Pages[4] = "$Presets"
	self.Pages[5] = "$Set_List_Category"
	self.Pages[6] = "$Queue"
	self.Pages[7] = "$Scanner"
	self.Pages[8] = "$Mod_Extras"
	
EndEvent

Function install()
	self.ModName = "$SL_Inflation_Framework"
	StorageUtil.SetIntValue(none, "slif_working", 1)
	SetTitleText("$slif_working")
	(GetAlias(0) as SLIF_ScannerAlias).RegisterForModEvents()
	self.CrosshairRef = none
	self.PlayerRef = Game.GetPlayer()
	self.update()
	StorageUtil.SetIntValue(none, "slif_working", 0)
	StorageUtil.SetIntValue(none, "slif_installed", 1)
EndFunction

Function SetCurrentActor(Actor kActor)
	if (kActor)
		self.CurrentActor        = kActor
		self.CurrentName         = SLIF_Util.GetActorName(self.CurrentActor)
		self.CurrentNameToString = SLIF_Util.ActorToString(self.CurrentActor, self.CurrentName)
		SLIF_Main.GetGender(self.CurrentActor)
		self.SetActorSelection(self.CurrentActor, self.CurrentName, "$Default_Modus")
		self.SetActorSelection(self.CurrentActor, self.CurrentName, "$Morph_Modus")
	endIf
EndFunction

Function SetActorSelection(Actor kActor, String name, String modus)
	bool morph_modus_var               = self.morph_modus_function(modus)
	String slif_actor_list_var         = self.slif_actor_list_function(morph_modus_var)
	String slif_actor_name_list_var    = self.slif_actor_name_list_function(morph_modus_var)
	String slif_actor_selection_var    = self.slif_actor_selection_function(morph_modus_var)
	String slif_current_actor_list_var = self.slif_current_actor_list_function(morph_modus_var)
	
	int index = StorageUtil.FormListFind(none, slif_actor_list_var, kActor)
	if (index != -1)
		if (StorageUtil.StringListGet(none, slif_actor_name_list_var, index) != name)
			StorageUtil.StringListSet(none, slif_actor_name_list_var, index, name)
		endIf
		StorageUtil.SetIntValue(self, slif_actor_selection_var,    index % 128)
		StorageUtil.SetIntValue(self, slif_current_actor_list_var, index / 128)
	else
		StorageUtil.SetIntValue(self, slif_actor_selection_var,    0)
		StorageUtil.SetIntValue(self, slif_current_actor_list_var, 0)
	endIf
EndFunction

Bool Function morph_modus_function(String modus)
	return modus == "$Morph_Modus"
EndFunction

String Function slif_actor_function(bool morph_modus_var)
	if (morph_modus_var)
		return "slif_morph_actor"
	endIf
	return "slif_actor"
EndFunction

String Function slif_actor_list_function(bool morph_modus_var)
	if (morph_modus_var)
		return "slif_morph_actor_list"
	endIf
	return "slif_actor_list"
EndFunction

String Function slif_actor_name_list_function(bool morph_modus_var)
	if (morph_modus_var)
		return "slif_morph_actor_name_list"
	endIf
	return "slif_actor_name_list"
EndFunction

String Function slif_mod_list_function(bool morph_modus_var)
	if (morph_modus_var)
		return "slif_morph_mod_list"
	endIf
	return "slif_mod_list"
EndFunction

String Function slif_mod_selection_function(bool morph_modus_var)
	if (morph_modus_var)
		return "slif_morph_mod_selection"
	endIf
	return "slif_mod_selection"
EndFunction

String Function slif_modus_selection_function(bool morph_modus_var)
	if (morph_modus_var)
		return "slif_morph_modus_selection"
	endIf
	return "slif_modus_selection"
EndFunction

String Function slif_category_selection_function(bool morph_modus_var)
	if (morph_modus_var)
		return "slif_morph_category_selection"
	endIf
	return "slif_category_selection"
EndFunction

String Function slif_actor_selection_function(bool morph_modus_var)
	if (morph_modus_var)
		return "slif_morph_actor_selection"
	endIf
	return "slif_actor_selection"
EndFunction

String Function slif_current_actor_list_function(bool morph_modus_var)
	if (morph_modus_var)
		return "slif_current_morph_actor_list"
	endIf
	return "slif_current_actor_list"
EndFunction

String Function slif_current_mod_list_function(bool morph_modus_var)
	if (morph_modus_var)
		return "slif_current_morph_mod_list"
	endIf
	return "slif_current_mod_list"
EndFunction

Function clearActorLists()
	
	self.clearActorList("$Default_Modus")
	self.clearActorList("$Morph_Modus")
	
	self.CurrentActor = none
	self.CurrentName = none
	self.CurrentNameToString = none
	
EndFunction

Function clearActorList(String modus)
	bool morph_modus_var               = self.morph_modus_function(modus)
	String slif_actor_list_var         = self.slif_actor_list_function(morph_modus_var)
	String slif_actor_name_list_var    = self.slif_actor_name_list_function(morph_modus_var)
	String slif_mod_selection_var      = self.slif_mod_selection_function(morph_modus_var)
	String slif_current_mod_list_var   = self.slif_current_mod_list_function(morph_modus_var)
	String slif_modus_selection_var    = self.slif_modus_selection_function(morph_modus_var)
	String slif_category_selection_var = self.slif_category_selection_function(morph_modus_var)
	String slif_actor_selection_var    = self.slif_actor_selection_function(morph_modus_var)
	String slif_current_actor_list_var = self.slif_current_actor_list_function(morph_modus_var)
	
	int actorCount = StorageUtil.FormListCount(none, slif_actor_list_var)
	while(actorCount > 0)
		actorCount -= 1
		Actor kActor = StorageUtil.FormListGet(none, slif_actor_list_var, actorCount) as Actor
		SLIF_Util.UnsetIntValueConditional(kActor, slif_mod_selection_var)
		SLIF_Util.UnsetIntValueConditional(kActor, slif_current_mod_list_var)
		SLIF_Util.UnsetIntValueConditional(kActor, slif_modus_selection_var)
		SLIF_Util.UnsetIntValueConditional(kActor, slif_category_selection_var)
		if (morph_modus_var)
			SLIF_Morph.unregisterActor(kActor)
		else
			SLIF_Main.unregisterActor(kActor)
		endIf
	endWhile
	SLIF_Util.UnsetIntValueConditional(self, slif_actor_selection_var)
	SLIF_Util.UnsetIntValueConditional(self, slif_current_actor_list_var)
EndFunction

Function uninstall()
	StorageUtil.UnsetIntValue(none, "slif_installed")
	StorageUtil.SetIntValue(none, "slif_working", 1)
	self.SetTitleText("$slif_working")
	
	(GetAlias(0) as SLIF_ScannerAlias).UnregisterForModEvents()
	
	self.StopScanner()
	self.StopTimer()
	
	self.UnregisterForAllKeys()
	self.clearActorLists()
	
	self.CrosshairRef = none
	
	SLIF_Util.UnsetIntValueConditional(self, "slif_mod_selection")
	SLIF_Util.UnsetIntValueConditional(self, "slif_current_mod_list")
	SLIF_Util.UnsetIntValueConditional(self, "slif_modus_selection")
	SLIF_Util.UnsetIntValueConditional(self, "slif_category_selection")
	
	SLIF_Util.UnsetIntValueConditional(self, "slif_morph_mod_selection")
	SLIF_Util.UnsetIntValueConditional(self, "slif_current_morph_mod_list")
	SLIF_Util.UnsetIntValueConditional(self, "slif_morph_modus_selection")
	SLIF_Util.UnsetIntValueConditional(self, "slif_morph_category_selection")
	
	SLIF_Util.UnsetIntValueConditional(none, "slif_timer_active")
	
	self.OID_actors = 0
	self.OID_mods = 0
	self.OID_mod_list = 0
	self.OID_modus = 0
	self.OID_category = 0
	self.OID_actor_list = 0
	self.OID_action_type = 0
	self.OID_current_value = 0
	self.OID_search_npc = 0
	self.OID_rename_npc = 0
	
	self.OID_move_npc_to_player = 0
	self.OID_move_player_to_npc = 0
	
	self.OID_languages = 0
	
	self.OID_register_player = 0
	
	self.OID_gender = 0
	
	self.OID_inflation_type = 0

	self.OID_calculation_type = 0
	
	self.OID_sort_type = 0
	
	self.OID_sort_actor_list = 0
	
	self.OID_top_x = 0
	
	self.OID_update_interval = 0
	self.OID_scanner_range = 0
	
	self.OID_scanner_active = 0
	self.OID_scanner_on_load = 0
	self.OID_scanner_over_time = 0
	self.OID_scanner_on_sleep = 0
	self.OID_scanner_purge_dead = 0
	self.OID_scanner_update_actors = 0
	
	self.OID_notification = 0
	self.OID_debug = 0
	self.OID_hidden = 0
	self.OID_auto_register_slif = 0
	self.OID_auto_register_slif_player = 0
	self.OID_morph_auto_register_slif = 0
	self.OID_morph_auto_register_slif_player = 0
	self.OID_non_unique_npcs_use_nio = 0
	self.OID_inflate_on_menu_exit = 0
	self.OID_treat_trans_as_male = 0
	self.OID_treat_male_as_female = 0
	
	self.OID_bodymorph = 0
	self.OID_bodymorph_category = 0
	
	self.OID_timer_active = 0
	
	self.OID_inflate_scrotum_update = 0
	self.OID_inflate_scrotum = 0
	self.OID_deflate_scrotum = 0
	self.OID_inflate_scrotum_min = 0
	self.OID_inflate_scrotum_max = 0
	self.OID_inflate_scrotum_absolute_max = 0
		
	StorageUtil.IntListClear(self, "slif_oid_list")
	
	StorageUtil.UnsetIntValue(none, "slif_working")
EndFunction

Function Reload()
	self.UnregisterForAllKeys()
	self.RegisterForKey(SLIF_Config.GetInt("register_key", 49)) ;N
	self.RegisterForCrosshairRef()
EndFunction

Event OnKeyDown(int keyCode)
	if keyCode == SLIF_Config.GetInt("register_key", 49) && !Utility.IsInMenuMode()
		self.SetTargetActor()
	endIf
EndEvent

Event OnCrosshairRefChange(ObjectReference ActorRef)
	self.CrosshairRef = none
	if ActorRef
		self.CrosshairRef = ActorRef as Actor
	endIf
EndEvent

Function SetTargetActor()
	if self.CrosshairRef
		if (StorageUtil.FormListHas(none, "slif_actor_list", self.CrosshairRef) && StorageUtil.FormListHas(none, "slif_morph_actor_list", self.CrosshairRef))
			self.SetCurrentActor(self.CrosshairRef)
			if (SLIF_Util.registerSLIF(self.CurrentActor, self.CurrentName, self.CurrentNameToString) || SLIF_Morph_Util.registerSLIF(self.CurrentActor, self.CurrentName, self.CurrentNameToString))
				Debug.Notification(SLIF_Language.TargetRegisteredForSLIF(self.CurrentName))
			else
				Debug.Notification(SLIF_Language.TargetAlreadyRegistered(self.CurrentName))
				SLIF_Main.updateActor(self.CurrentActor)
				SLIF_Morph.updateActor(self.CurrentActor)
			endIf
		else
			if (SLIF_Util.isValidActor(self.CrosshairRef))
				SLIF_Main.registerActor(self.CrosshairRef, "SL Inflation Framework")
				SLIF_Morph.registerActor(self.CrosshairRef, "SL Inflation Framework")
				self.SetCurrentActor(self.CrosshairRef)
			else
				Debug.Notification(SLIF_Language.TargetNotValid())
			endIf
		endIf
	else
		Debug.Notification(SLIF_Language.NoTargetSelected())
	endIf
EndFunction

bool Function KeyConflict(String conflictControl, String conflictName)
	if (conflictControl != "")
		String msg
		if (conflictName != "")
			msg = "$slif_key_already_mapped{'" + conflictControl + "'}{\n(" + conflictName + ")}"
		else
			msg = "$slif_key_already_mapped{'" + conflictControl + "'}{}"
		endIf
		return self.ShowMessage(msg, true, "$Yes", "$No")
	endIf
	return false
EndFunction

Function SetRegisterKey(int newKeyCode)
	self.UnregisterForKey(SLIF_Config.GetInt("register_key", 49))
	SLIF_Config.SetInt("register_key", newKeyCode)
	self.RegisterForKey(newKeyCode)
	self.SetKeyMapOptionValueST(newKeyCode)
EndFunction

state TargetActor
	Event OnKeyMapChangeST(int newKeyCode, String conflictControl, String conflictName)
		if !self.KeyConflict(conflictControl, conflictName)
			self.SetRegisterKey(newKeyCode)
		endIf
	EndEvent
	Event OnDefaultST()
		self.SetRegisterKey(49)
	EndEvent
	Event OnHighlightST()
		self.SetInfoText("$slif_target_actor_info")
	EndEvent
endState

state CurrentModus
	Event OnMenuOpenST()
		self.OpenMenu(self.GetCurrentModusList(), self.GetCurrentModusIndex(), 0)
	EndEvent
	Event OnMenuAcceptST(int index)
		if (self.GetCurrentModusIndex() != index)
			self.CurrentModus = self.GetCurrentModusList()[index]
			self.FilterByCategory = "$All Categories"
			self.ForcePageReset()
		endIf
	EndEvent
	Event OnHighlightST()
	EndEvent
endState

state FilterByCategory
	Event OnMenuOpenST()
		String[] list = self.GetCategoryList()
		int count = list.length
		int index = 0
		int i = 0
		while(i < count)
			if (self.FilterByCategory == list[i])
				index = i
				i = count
			endIf
			i += 1
		endWhile
		self.OpenMenu(list, index, 0)
	EndEvent
	Event OnMenuAcceptST(int index)
		String[] list = self.GetCategoryList()
		if (self.FilterByCategory != list[index])
			self.FilterByCategory = list[index]
			self.ForcePageReset()
		endIf
	EndEvent
	Event OnHighlightST()
	EndEvent
endState

state CurrentListSize
	Event OnSliderOpenST()
		int val = StorageUtil.GetIntValue(self, "slif_current_list_size", self.CurrentListSize)
		self.SetSliderOpen(val, 30, 10, 50, 10)
	EndEvent
	Event OnSliderAcceptST(float value)
		int val = value as int
		if (StorageUtil.GetIntValue(self, "slif_current_list_size") != val)
			StorageUtil.SetIntValue(self, "slif_current_list_size", val)
			self.ForcePageReset()
		endIf
	EndEvent
	Event OnDefaultST()
		if (StorageUtil.GetIntValue(self, "slif_current_list_size") != 30)
			StorageUtil.SetIntValue(self, "slif_current_list_size", 30)
			self.ForcePageReset()
		endIf
	EndEvent
	Event OnHighlightST()
	EndEvent
endState

state CurrentListIndex
	Event OnSliderOpenST()
		int val = StorageUtil.GetIntValue(self, "slif_current_list_index") + 1
		int max = StorageUtil.StringListCount(self, "slif_valid_key_list") / self.CurrentListSize + 1
		self.SetSliderOpen(val, 1, 1, max, 1)
	EndEvent
	Event OnSliderAcceptST(float value)
		int val = (value - 1) as int
		if (StorageUtil.GetIntValue(self, "slif_current_list_index") != val)
			StorageUtil.SetIntValue(self, "slif_current_list_index", val)
			self.ForcePageReset()
		endIf
	EndEvent
	Event OnDefaultST()
		if (StorageUtil.GetIntValue(self, "slif_current_list_index") != 0)
			StorageUtil.SetIntValue(self, "slif_current_list_index", 0)
			self.ForcePageReset()
		endIf
	EndEvent
	Event OnHighlightST()
	EndEvent
endState

String[] Function GetModusList()
	String[] modus_list
	if (self.CurrentPage == "$Presets")
		modus_list = new String[5]
		modus_list[0] = "$slif_inflation_type"
		modus_list[1] = "$Minimum"
		modus_list[2] = "$Maximum"
		modus_list[3] = "$slif_current_sliders_mult"
		modus_list[4] = "$slif_current_sliders_increment"
	elseIf (self.CurrentMod == "All Mods")
		if (self.morph_modus)
			modus_list = new String[1]
			modus_list[0] = "$slif_current_values"
		else
			modus_list = new String[2]
			modus_list[0] = "$slif_current_values"
			modus_list[1] = "$slif_hidden_nodes"
		endIf
	else
		if (self.morph_modus)
			modus_list = new String[2]
			modus_list[0] = "$slif_current_values"
			modus_list[1] = "$slif_current_sliders"
		else
			modus_list = new String[6]
			modus_list[0] = "$slif_current_values"
			modus_list[1] = "$slif_current_sliders"
			modus_list[2] = "$Minimum"
			modus_list[3] = "$Maximum"
			modus_list[4] = "$slif_current_sliders_mult"
			modus_list[5] = "$slif_current_sliders_increment"
		endIf
	endIf
	return modus_list
EndFunction

String[] Function GetGenders()
	String[] genders = new String[7]
	genders[0] = "$slif_male"
	genders[1] = "$slif_female"
	genders[2] = "$slif_shemale"
	genders[3] = "$slif_futanari"
	genders[4] = "$slif_genderless"
	genders[5] = "$slif_male_creature"
	genders[6] = "$slif_female_creature"
	return genders
EndFunction

String[] Function GetCurrentModusList()
	String[] modus_list = new String[2]
	modus_list[0] = "$Default_Modus"
	modus_list[1] = "$Morph_Modus"
	return modus_list
EndFunction

String[] Function GetCategoryList()
	String lists = GetDefaultLists()
	String[] list_array = SLIF_Util.GetLists(lists)
	String[] list = Utility.CreateStringArray(list_array.length + 1)
	list[0] = "$All Categories"
	int i = 1
	while(i < list.length)
		list[i] = list_array[i - 1]
		i += 1
	endWhile
	return list
EndFunction

int Function GetCurrentModusIndex()
	return self.morph_modus as int
EndFunction

Int Function GetGender()
	return StorageUtil.GetIntValue(self.CurrentActor, "slif_gender")
EndFunction

String[] Function GetInflationTypes()
	String[] inflation_types = new String[2]
	inflation_types[0] = "$slif_incremental"
	inflation_types[1] = "$slif_instant"
	return inflation_types
EndFunction

String[] Function GetCalculationTypes()
	String[] calculation_types = new String[6]
	calculation_types[0] = "$slif_top_x"
	calculation_types[1] = "$slif_highest_wins"
	calculation_types[2] = "$slif_substract_one"
	calculation_types[3] = "$slif_square_root"
	calculation_types[4] = "$slif_average"
	calculation_types[5] = "$slif_additive"
	return calculation_types
EndFunction

Int Function GetCalculationType()
	return SLIF_Config.GetInt("calculation_type")
EndFunction

String[] Function GetSortTypes()
	String[] sort_types = new String[2]
	sort_types[0] = "$slif_sort_ascending"
	sort_types[1] = "$slif_sort_descending"
	return sort_types
EndFunction

Int Function GetSortType()
	return Math.LogicalXor(1, SLIF_Config.GetInt("sort_actors_ascending", 1))
EndFunction

String[] Function GetActionTypes()
	float value = StorageUtil.GetFloatValue(self, "slif_current_value", self.CurrentDefault)
	String[] action_types = new String[9]
	action_types[0] = "$slif_no_action"
	action_types[1] = "$slif_set_actor_values_to_{" + value + "}"
	action_types[2] = "$slif_update_actor"
	action_types[3] = "$slif_update_all_actors"
	action_types[4] = "$slif_reset_actor"
	action_types[5] = "$slif_reset_all_actors"
	action_types[6] = "$slif_unregister_actor"
	action_types[7] = "$slif_unregister_all_actors"
	action_types[8] = "$slif_remove_actor"
	return action_types
EndFunction

String[] Function GetPresetActionTypes()
	float value   = StorageUtil.GetFloatValue(self, "slif_current_value", self.CurrentDefault)
	String sValue = ""
	if (self.CurrentModusList == "$slif_inflation_type")
		sValue = self.GetInflationTypes()[value as int]
	else
		sValue = value as String
	endIf
	String[] action_types = new String[2]
	action_types[0] = "$slif_no_action"
	action_types[1] = "$slif_set_actor_values_to_{" + sValue + "}"
	return action_types
EndFunction

String[] Function GetLanguages()
	String[] languages = new String[17]
	languages[0] = "$Chinese"
	languages[1] = "$Czech"
	languages[2] = "$Danish"
	languages[3] = "$English"
	languages[4] = "$Finnish"
	languages[5] = "$French"
	languages[6] = "$German"
	languages[7] = "$Greek"
	languages[8] = "$Italian"
	languages[9] = "$Japanese"
	languages[10] = "$Norwegian"
	languages[11] = "$Polish"
	languages[12] = "$Portuguese"
	languages[13] = "$Russian"
	languages[14] = "$Spanish"
	languages[15] = "$Swedish"
	languages[16] = "$Turkish"
	return languages
EndFunction

String[] Function GetCategories()
	return SLIF_Util.PendToArray(SLIF_Util.GetLists(self.GetDefaultLists()), "$")
EndFunction

String Function SetModName(String mod)
	if (mod == "All Mods")
		return "$" + mod
	endIf
	return mod
EndFunction

Event OnPageReset(String page)
	if (page == "")
		self.LoadCustomContent("SexLab Inflation Framework/logo.dds", 0, 0)
		return
	else
		self.UnloadCustomContent()
	endIf
	
	bool installed = StorageUtil.GetIntValue(none, "slif_installed") as bool
	
	if (StorageUtil.GetIntValue(none, "slif_working") as bool)
		self.SetTitleText("$slif_working")
		return
	endIf
	
	StorageUtil.IntListClear(self, "slif_oid_list")
	StorageUtil.StringListClear(self, "slif_valid_key_list")
	
	self.morph_modus             = self.morph_modus_function(self.CurrentModus)
	self.slif_actor              = self.slif_actor_function(self.morph_modus)
	self.slif_actor_list         = self.slif_actor_list_function(self.morph_modus)
	self.slif_actor_name_list    = self.slif_actor_name_list_function(self.morph_modus)
	self.slif_mod_list           = self.slif_mod_list_function(self.morph_modus)
	self.slif_mod_selection      = self.slif_mod_selection_function(self.morph_modus)
	self.slif_current_mod_list   = self.slif_current_mod_list_function(self.morph_modus)
	self.slif_modus_selection    = self.slif_modus_selection_function(self.morph_modus)
	self.slif_category_selection = self.slif_category_selection_function(self.morph_modus)
	self.slif_actor_selection    = self.slif_actor_selection_function(self.morph_modus)
	self.slif_current_actor_list = self.slif_current_actor_list_function(self.morph_modus)
	
	self.CurrentIndex = 0
	self.CurrentMod = ""
	self.CurrentActor = none
	if (page == "$Presets")
		self.CurrentMod = self.CalculateModName(self)
	elseIf (page == "$Config" || page == "$Values_and_sliders")
		self.SetCurrentActor(self.CalculateActor())
		self.CurrentMod = self.CalculateModName(self.CurrentActor)
	endIf
	if (page == "$Bodymorphs")
		self.CurrentSelection = StorageUtil.GetIntValue(self, "slif_bodymorph_selection")
		self.CurrentCategory  = StorageUtil.GetIntValue(self, "slif_bodymorph_category")
	elseIf (self.CurrentMod != "")
		self.CurrentSelection = self.GetModusSelection()
		self.CurrentCategory  = self.GetCategorySelection()
	endIf
	self.CurrentModusList    = self.GetModusList()[self.CurrentSelection]
	self.CurrentCategoryList = self.GetCategories()[self.CurrentCategory]
	self.CurrentSuffix       = self.GetSuffix()
	self.CurrentDefault      = self.GetDefValue(self.CurrentModusList)
	self.CurrentMinimum      = self.GetMinValue()
	self.CurrentMaximum      = self.GetMaxValue()
	self.CurrentInterval     = self.GetInterval()
	
	float value = StorageUtil.GetFloatValue(self, "slif_current_value", self.CurrentDefault)
	
	self.CurrentListSize = StorageUtil.GetIntValue(self, "slif_current_list_size", self.CurrentListSize)
	
	if (page == "$Values_and_sliders")
		if (self.CurrentActor && self.CurrentMod != "")
			String lists = GetDefaultLists()
			String list  = SLIF_Util.GetListByCategory(lists, self.CurrentCategory)
			int count    = SLIF_Util.GetListSize(lists, list)
			int i = 0
			while(i < count)
				String sKey = SLIF_Util.GetListEntry(lists, list, i)
				self.AddValidKey(lists, sKey)
				i += 1
			endWhile
		endIf
	else
		String lists = GetDefaultLists()
		String list  = GetDefaultList()
		int count    = SLIF_Util.GetListSize(lists, list)
		int i = 0
		while(i < count)
			String sKey = SLIF_Util.GetListEntry(lists, list, i)
			self.AddValidKey(lists, sKey)
			i += 1
		endWhile
	endIf
	
	if ((StorageUtil.GetIntValue(self, "slif_current_list_index") * self.CurrentListSize) >= StorageUtil.StringListCount(self, "slif_valid_key_list"))
		StorageUtil.SetIntValue(self, "slif_current_list_index", 0)
	endIf
	
	if (page == "$Config")
		
		if (installed)
			self.SetCursorFillMode(LEFT_TO_RIGHT)
			
			self.AddMenuOptionST("CurrentModus", "$slif_current_modus", self.CurrentModus)
			self.AddSliderOptionST("CurrentListSize", "$slif_current_list_size", self.CurrentListSize)
			self.OID_register_player  = self.AddTextOption("$slif_register_player", "")
			self.AddSliderOptionST("CurrentListIndex", "$slif_current_list_index", StorageUtil.GetIntValue(self, "slif_current_list_index") + 1)
			
			self.SetCursorFillMode(TOP_TO_BOTTOM)
			
			If (self.CurrentActor)
				self.OID_actors       = self.AddMenuOption("$slif_current_actor", self.CurrentNameToString)
				self.OID_actor_list   = self.AddSliderOption("$slif_actor_list", StorageUtil.GetIntValue(self, self.slif_current_actor_list) + 1)
			else
				self.AddEmptyOption()
				self.AddEmptyOption()
			endIf
			if (self.CurrentMod != "")
				if (self.CurrentMod == "All Mods")
					if (self.CurrentSelection > 1)
						self.CurrentSelection = 0
						StorageUtil.SetIntValue(self.CurrentActor, self.slif_modus_selection, self.CurrentSelection)
					endIf
				endIf
				self.OID_category    = self.AddMenuOption("$Category", self.CurrentCategoryList)
				self.OID_modus       = self.AddMenuOption("$slif_current_modus", self.CurrentModusList)
			else
				self.AddEmptyOption()
				self.AddEmptyOption()
			endIf
			self.OID_uninstall_mod   = self.AddTextOption("$slif_uninstall_mod", "")
			self.OID_languages		 = self.AddMenuOption("$Language", GetLanguages()[SLIF_Config.GetInt("language", 3)])
			If (self.CurrentActor)
				self.OID_gender      = self.AddMenuOption("$slif_gender", GetGenders()[GetGender()])
			else
				self.AddEmptyOption()
			endIf
			if (self.CurrentMod != "")
				self.OID_inflation_type = self.AddMenuOption("$slif_inflation_type", self.GetInflationTypes()[SLIF_Config.GetInflationType(self.CurrentMod, 1)])
			else
				self.AddEmptyOption()
			endIf
			if (self.morph_modus)
				self.AddEmptyOption()
				self.AddEmptyOption()
			else
				int CalculationType  = SLIF_Config.GetInt("calculation_type")
				self.OID_calculation_type = self.AddMenuOption("$slif_calculation_type", self.GetCalculationTypes()[CalculationType])
				if (CalculationType == 0)
					self.OID_top_x        = self.AddSliderOption("$slif_top_x", SLIF_Config.GetInt("top_x", 3))
				else
					self.AddEmptyOption()
				endIf
			endIf
			
			SetCursorPosition(5)
			
			If (self.CurrentActor)
				if (self.CurrentMod != "")
					self.OID_mods     = self.AddMenuOption("$slif_current_mod", self.SetModName(self.CurrentMod))
					self.OID_mod_list = self.AddSliderOption("$slif_mod_list", StorageUtil.GetIntValue(self.CurrentActor, "slif_current_mod_list") + 1)
				else
					self.AddEmptyOption()
					self.AddEmptyOption()
				endIf
				self.OID_action_type   = self.AddMenuOption("$slif_action_type", "$slif_no_action")
				self.OID_current_value = self.AddSliderOption("$slif_current_value", value, self.Interval)
				self.OID_search_npc    = self.AddInputOption("$slif_search_npc", "")
				self.OID_rename_npc    = self.AddInputOption("$slif_rename_npc", self.CurrentName)
				self.OID_move_npc_to_player = self.AddTextOption("$slif_move_npc_to_player", "")
				self.OID_move_player_to_npc = self.AddTextOption("$slif_move_player_to_npc", "")
			else
				self.AddEmptyOption()
				self.AddEmptyOption()
				self.AddEmptyOption()
				self.AddEmptyOption()
				self.AddEmptyOption()
				self.AddEmptyOption()
				self.AddEmptyOption()
				self.AddEmptyOption()
			endIf
			self.OID_sort_type        = self.AddMenuOption("$slif_sort_types", GetSortTypes()[GetSortType()])
			self.OID_sort_actor_list  = self.AddTextOption("$slif_sort_actor_list", "")
			self.AddKeyMapOptionST("TargetActor", "$slif_target_actor", SLIF_Config.GetInt("register_key", 49))
			
		else
			self.AddEmptyOption()
			self.AddEmptyOption()
			self.AddEmptyOption()
			self.AddEmptyOption()
			self.AddEmptyOption()
			self.AddEmptyOption()
			self.OID_uninstall_mod = self.AddTextOption("$slif_install_mod", "")
		endIf
		
	elseIf (page == "$Toggles")
		
		if (installed)
			self.SetCursorFillMode(TOP_TO_BOTTOM)
			self.OID_notification                    = self.AddToggleOption("$slif_notification",         SLIF_Config.GetInt("show_notifications", 1)     as bool)
			self.OID_debug                           = self.AddToggleOption("$slif_debug",                SLIF_Config.GetInt("show_debug_messages")       as bool)
			self.OID_hidden                          = self.AddToggleOption("$slif_hidden",               SLIF_Config.GetInt("show_hidden_values")        as bool)
			self.OID_auto_register_slif_player       = self.AddToggleOption("$slif_auto_register_player", SLIF_Config.GetInt("auto_register_slif_player") as bool)
			self.OID_inflate_on_menu_exit            = self.AddToggleOption("$slif_inflate_on_menu_exit", SLIF_Config.GetInt("inflate_on_menu_exit", 1)   as bool)
			self.AddHeaderOption("$Morphs")
			self.OID_morph_auto_register_slif_player = self.AddToggleOption("$slif_auto_register_player", SLIF_Config.GetInt("morph_auto_register_slif_player") as bool)
			self.SetCursorPosition(1)
			self.OID_treat_trans_as_male       = self.AddToggleOption("$slif_treat_trans_as_male",     SLIF_Config.GetInt("treat_trans_as_male")       as bool)
			self.OID_treat_male_as_female      = self.AddToggleOption("$slif_treat_male_as_female",    SLIF_Config.GetInt("treat_male_as_female")      as bool)
			self.OID_non_unique_npcs_use_nio   = self.AddToggleOption("$slif_non_unique_npcs_use_nio", SLIF_Config.GetInt("non_unique_npcs_use_nio")   as bool)
			self.OID_auto_register_slif        = self.AddToggleOption("$slif_auto_register",           SLIF_Config.GetInt("auto_register_slif")        as bool)
			self.AddEmptyOption()
			self.AddEmptyOption()
			self.OID_morph_auto_register_slif  = self.AddToggleOption("$slif_auto_register",           SLIF_Config.GetInt("morph_auto_register_slif")  as bool)
		endIf
		
	elseIf (page == "$Values_and_sliders")
		
		if (installed)
			self.SetCursorFillMode(LEFT_TO_RIGHT)
			
			self.AddMenuOptionST("CurrentModus", "$slif_current_modus", self.CurrentModus)
			self.AddSliderOptionST("CurrentListSize", "$slif_current_list_size", self.CurrentListSize)
			self.OID_register_player   = self.AddTextOption("$slif_register_player", "")
			self.AddSliderOptionST("CurrentListIndex", "$slif_current_list_index", StorageUtil.GetIntValue(self, "slif_current_list_index") + 1)
			
			self.SetCursorFillMode(TOP_TO_BOTTOM)
			
			if (self.CurrentActor)
				self.OID_actors        = self.AddMenuOption("$slif_current_actor", self.CurrentNameToString)
				self.OID_actor_list    = self.AddSliderOption("$slif_actor_list", StorageUtil.GetIntValue(self, self.slif_current_actor_list) + 1)
			else
				self.AddEmptyOption()
				self.AddEmptyOption()
			endIf
			if (self.CurrentActor && self.CurrentMod != "")
				if (self.CurrentMod == "All Mods")
					if (self.CurrentSelection >= self.GetModusList().length)
						self.CurrentSelection = 0
						StorageUtil.SetIntValue(self.CurrentActor, self.slif_modus_selection, self.CurrentSelection)
					endIf
				endIf
				self.OID_category      = self.AddMenuOption("$Category", self.CurrentCategoryList)
				self.OID_modus         = self.AddMenuOption("$slif_current_modus", self.CurrentModusList)
			else
				self.AddEmptyOption()
				self.AddEmptyOption()
			endIf
			
			SetCursorPosition(5)
			
			if (self.CurrentActor && self.CurrentMod != "")
				self.OID_mods          = self.AddMenuOption("$slif_current_mod", self.SetModName(self.CurrentMod))
				self.OID_mod_list      = self.AddSliderOption("$slif_mod_list", StorageUtil.GetIntValue(self.CurrentActor, self.slif_current_mod_list) + 1)
			else
				self.AddEmptyOption()
				self.AddEmptyOption()
			endIf
			if (self.CurrentActor)
				self.OID_action_type   = self.AddMenuOption("$slif_action_type", "$slif_no_action")
				self.OID_current_value = self.AddSliderOption("$slif_current_value", value, self.Interval)
			else
				self.AddEmptyOption()
				self.AddEmptyOption()
			endIf
			
			self.SetCursorFillMode(LEFT_TO_RIGHT)
			
			self.SetCursorPosition(12)
			
			int i = 0
			int count = self.CurrentListSize
			if (((StorageUtil.GetIntValue(self, "slif_current_list_index") + 1) * self.CurrentListSize) > StorageUtil.StringListCount(self, "slif_valid_key_list"))
				count = StorageUtil.StringListCount(self, "slif_valid_key_list") % self.CurrentListSize
			endIf
			while(i < count)
				String sKey = StorageUtil.StringListGet(self, "slif_valid_key_list", (StorageUtil.GetIntValue(self, "slif_current_list_index") * self.CurrentListSize) + i)
				int oid     = self.SetOptionOID(sKey)
				StorageUtil.IntListAdd(self, "slif_oid_list", oid)
				i += 1
			endWhile
			
		endIf
		
	elseIf (page == "$Bodymorphs")
		
		if (installed)
			SLIF_Menu_Bodymorphs.OnPageReset(self)
		endIf
		
	elseIf (page == "$Presets")
		
		if (installed)
			SLIF_Menu_Preset.OnPageReset(self, value)
		endIf
		
	elseIf (page == "$Set_List_Category")
		
		if (installed)
			self.SetCursorFillMode(LEFT_TO_RIGHT)
			
			self.AddMenuOptionST("CurrentModus", "$slif_current_modus", self.CurrentModus)
			self.AddSliderOptionST("CurrentListSize", "$slif_current_list_size", self.CurrentListSize)
			self.AddMenuOptionST("FilterByCategory", "$slif_filter_by_category", self.FilterByCategory)
			self.AddSliderOptionST("CurrentListIndex", "$slif_current_list_index", StorageUtil.GetIntValue(self, "slif_current_list_index") + 1)
			
			int i = 0
			int count = self.CurrentListSize
			if (((StorageUtil.GetIntValue(self, "slif_current_list_index") + 1) * self.CurrentListSize) > StorageUtil.StringListCount(self, "slif_valid_key_list"))
				count = StorageUtil.StringListCount(self, "slif_valid_key_list") % self.CurrentListSize
			endIf
			while(i < count)
				String sKey = StorageUtil.StringListGet(self, "slif_valid_key_list", (StorageUtil.GetIntValue(self, "slif_current_list_index") * self.CurrentListSize) + i)
				int oid     = self.SetOptionOID(sKey)
				StorageUtil.IntListAdd(self, "slif_oid_list", oid)
				i += 1
			endWhile
		endIf
		
	elseIf (page == "$Queue")
		
		if (installed)
			int actorCount = StorageUtil.FormListCount(self, "slif_inflate_on_menu_exit_actors")
			if (actorCount > 0)
				self.SetCursorFillMode(TOP_TO_BOTTOM)
				Actor kActor     = StorageUtil.FormListGet(self, "slif_inflate_on_menu_exit_actors", StorageUtil.GetIntValue(self, "slif_queue_actor")) as Actor
				String name      = SLIF_Util.GetActorName(kActor)
				String aToString = SLIF_Util.ActorToString(kActor, name)
				if (kActor)
					self.OID_actors     = self.AddMenuOption("$slif_current_actor", aToString)
					self.OID_actor_list = self.AddSliderOption("$slif_actor_list", StorageUtil.GetIntValue(self, "slif_queue_actor_list") + 1)
					self.SetCursorPosition(1)
					String mod = StorageUtil.StringListGet(kActor, "slif_inflate_on_menu_exit_mods", StorageUtil.GetIntValue(kActor, "slif_queue_mod"))
					if (mod != "")
						self.OID_mods     = self.AddMenuOption("$slif_current_mod", self.SetModName(mod))
						self.OID_mod_list = self.AddSliderOption("$slif_mod_list", StorageUtil.GetIntValue(kActor, "slif_queue_mod_list") + 1)
					endIf
					self.SetCursorFillMode(LEFT_TO_RIGHT)
					self.SetCursorPosition(4)
					String[] nodes = StorageUtil.StringListToArray(kActor, "slif_inflate_on_menu_exit_keys" + mod)
					Float[] values = StorageUtil.FloatListToArray( kActor, "slif_inflate_on_menu_exit_values" + mod)
					int i = 0
					while(i < nodes.length)
						self.AddTextOption(nodes[i], values[i])
						i += 1
					endWhile
				endIf
			endIf
		endIf
		
	elseIf (page == "$Scanner")
	
		if (installed)
			SLIF_Scanner Scanner = Game.GetFormFromFile(0x801, "SexLab Inflation Framework.esp") as SLIF_Scanner
			Float fRange = Scanner.pScannerRange.GetValue()
			Float fTimer = Scanner.UpdateTimer.GetValue()
			
			SetCursorFillMode(TOP_TO_BOTTOM)
			
			self.AddHeaderOption("$slif_scanner_active")
			self.OID_scanner_active        = self.AddToggleOption("$slif_scanner_active", SLIF_Config.GetPathInt(".scanner", ".active") as bool)
			self.AddHeaderOption("$slif_scanner_performance")
			self.OID_update_interval       = self.AddSliderOption("$slif_scanner_interval", fTimer, "$slif_scanner_seconds")
			self.OID_scanner_range         = self.AddSliderOption("$slif_scanner_range", fRange, "$slif_scanner_units")
			self.AddTextOption("", CreateScannerDisplay((fRange * 0.014282) As Int, (fRange * 0.046875) As Int), OPTION_FLAG_DISABLED)
			self.AddHeaderOption("$slif_scanner_options")
			self.OID_scanner_on_load       = self.AddToggleOption("$slif_scanner_on_load",       SLIF_Config.GetPathInt(".scanner", ".on_load")       as bool)
			self.OID_scanner_over_time     = self.AddToggleOption("$slif_scanner_over_time",     SLIF_Config.GetPathInt(".scanner", ".over_time")     as bool)
			self.OID_scanner_on_sleep      = self.AddToggleOption("$slif_scanner_on_sleep",      SLIF_Config.GetPathInt(".scanner", ".on_sleep")      as bool)
			self.OID_scanner_purge_dead    = self.AddToggleOption("$slif_scanner_purge_dead",    SLIF_Config.GetPathInt(".scanner", ".purge_dead")    as bool)
			self.OID_scanner_update_actors = self.AddToggleOption("$slif_scanner_update_actors", SLIF_Config.GetPathInt(".scanner", ".update_actors") as bool)
		endIf
		
	elseIf (page == "$Mod_Extras")
		
		if (installed)
			Actor kActor = Game.GetPlayer()			
			self.SetCursorFillMode(TOP_TO_BOTTOM)
			self.SetCursorPosition(1)
			self.AddHeaderOption("$slif_timer_active")
			self.OID_timer_active                 = self.AddToggleOption("$slif_timer_active",                 StorageUtil.GetIntValue(none, "slif_timer_active") as bool)		
			self.AddHeaderOption("$slif_inflate_scrotum_update")
			self.OID_inflate_scrotum_update       = self.AddSliderOption("$slif_inflate_scrotum_update",       StorageUtil.GetFloatValue(kActor, "slif_inflate_scrotum_update",        1.0),  "{1}")
			self.AddHeaderOption("$slif_deflate_scrotum")
			self.OID_deflate_scrotum              = self.AddSliderOption("$slif_deflate_scrotum",              StorageUtil.GetFloatValue(kActor, "slif_deflate_scrotum",               0.5),  self.Interval)
			self.AddHeaderOption("$slif_inflate_scrotum")
			self.OID_inflate_scrotum              = self.AddSliderOption("$slif_inflate_scrotum",              StorageUtil.GetFloatValue(kActor, "slif_inflate_scrotum",               0.01), self.Interval)
			self.OID_inflate_scrotum_min          = self.AddSliderOption("$slif_inflate_scrotum_min",          StorageUtil.GetFloatValue(kActor, "slif_inflate_scrotum_min",           1.0),  self.Interval)
			self.OID_inflate_scrotum_max          = self.AddSliderOption("$slif_inflate_scrotum_max",          StorageUtil.GetFloatValue(kActor, "slif_inflate_scrotum_max",           2.0),  self.Interval)
			self.OID_inflate_scrotum_absolute_max = self.AddSliderOption("$slif_inflate_scrotum_absolute_max", StorageUtil.GetFloatValue(kActor, "slif_inflate_scrotum_absolute_max", 10.0),  self.Interval)
		endIf
		
	endIf
	
EndEvent

Form Function GetFormIDByPage()
	if (self.CurrentPage == "$Presets")
		return self
	endIf
	return self.CurrentActor
EndFunction

int Function GetModusSelection()
	return StorageUtil.GetIntValue(self.GetFormIDByPage(), self.slif_modus_selection)
EndFunction

Function SetModusSelection(int selection)
	self.CurrentSelection = selection
	StorageUtil.SetIntValue(self.GetFormIDByPage(), self.slif_modus_selection, selection)
EndFunction

int Function GetCategorySelection()
	return StorageUtil.GetIntValue(self.GetFormIDByPage(), self.slif_category_selection)
EndFunction

Function SetCategorySelection(int category)
	self.CurrentCategory = category
	StorageUtil.SetIntValue(self.GetFormIDByPage(), self.slif_category_selection, category)
EndFunction

Actor Function GetQueueActor()
	int index = StorageUtil.GetIntValue(self, "slif_queue_actor_list") * 128 + StorageUtil.GetIntValue(self, "slif_queue_actor")
	return StorageUtil.FormListGet(self, "slif_inflate_on_menu_exit_actors", index) as Actor
EndFunction

Int Function GetActorListStartIndex()
	return StorageUtil.GetIntValue(self, self.slif_current_actor_list) * 128
EndFunction

Int Function CalculateActorListIndex()
	return StorageUtil.GetIntValue(self, self.slif_actor_selection) + self.GetActorListStartIndex()
EndFunction

Actor Function CalculateActor()
	if (StorageUtil.FormListCount(none, self.slif_actor_list) > 0)
		return StorageUtil.FormListGet(none, self.slif_actor_list, self.CalculateActorListIndex()) as Actor
	endIf
	return none
EndFunction

Int Function GetModListStartIndex(Form ObjKey)
	return StorageUtil.GetIntValue(ObjKey, self.slif_current_mod_list) * 128
EndFunction

Int Function CalculateModListIndex(Form ObjKey)
	return StorageUtil.GetIntValue(ObjKey, self.slif_mod_selection) + GetModListStartIndex(ObjKey)
EndFunction

Int Function GetModListCount(Form ObjKey)
	if (ObjKey == self)
		return SLIF_Config.ModCount()
	endIf
	return StorageUtil.StringListCount(ObjKey, self.slif_mod_list)
EndFunction

String Function GetMod(Form ObjKey, int index)
	if (ObjKey == self)
		return SLIF_Config.GetMod(index)
	endIf
	return StorageUtil.StringListGet(ObjKey, self.slif_mod_list, index)
EndFunction

String Function CalculateModName(Form ObjKey)
	if (ObjKey)
		int index = self.CalculateModListIndex(ObjKey)
		int count = self.GetModListCount(ObjKey)
		if (index >= count || index < 0)
			if (ObjKey != self)
				SLIF_Util.SetModListCount(ObjKey, self.slif_mod_list)
			endIf
			StorageUtil.SetIntValue(ObjKey, self.slif_mod_selection, 0)
			StorageUtil.SetIntValue(ObjKey, self.slif_current_mod_list, 0)
			index = 0
		endIf
		if (count > 0)
			return self.GetMod(ObjKey, index)
		endIf
	endIf
	return ""
EndFunction

Function AddValidKey(String lists, String sKey)
	if (self.CurrentPage == "$Values_and_sliders")
		if (lists == "morph_lists")
			if (!StorageUtil.HasFloatValue(self.CurrentActor, "slif_" + self.CurrentMod + "_" + sKey) && !(SLIF_Config.GetInt("show_hidden_values") as bool))
				return
			endIf
		elseIf (lists == "node_lists")
			if (!StorageUtil.HasFloatValue(self.CurrentActor, self.CurrentMod + sKey) && !(SLIF_Config.GetInt("show_hidden_values") as bool))
				return
			endIf
		endIf
	elseIf (self.CurrentPage == "$Set_List_Category")
		String[] list_array = SLIF_Util.GetLists(lists)
		if (self.FilterByCategory != "$All Categories" && !SLIF_Util.HasListEntry(lists, self.FilterByCategory, sKey))
			return
		elseIf (self.FilterByCategory == list_array[0])
			int count = list_array.length
			while(count > 1)
				count -= 1
				String list = list_array[count]
				if (SLIF_Util.HasListEntry(lists, list, sKey))
					return
				endIf
			endWhile
		endIf
	endIf
	StorageUtil.StringListAdd(self, "slif_valid_key_list", sKey)
EndFunction

int Function SetOptionOID(String sKey)
	
	String lists = GetDefaultLists()
	
	if (self.CurrentPage == "$Set_List_Category")
		
		String[] list_array = SLIF_Util.GetLists(lists)
		int count = list_array.length
		while(count > 0)
			count -= 1
			String list = list_array[count]
			if (SLIF_Util.HasListEntry(lists, list, sKey))
				return self.AddMenuOption(sKey, list)
			endIf
		endWhile
		
	else
		
		if (lists == "morph_lists")
			float value = 0.0
			if (self.CurrentMod == "All Mods")
				value = StorageUtil.GetFloatValue(self.CurrentActor, "slif_" + sKey)
			else
				value = StorageUtil.GetFloatValue(self.CurrentActor, "slif_" + self.CurrentMod + "_" + sKey + self.CurrentSuffix, self.CurrentDefault)
			endIf
			if (self.CurrentModusList == "$slif_current_values")
				return self.AddTextOption(sKey, value)
			elseIf (self.CurrentMod != "All Mods")
				return self.AddSliderOption(sKey, value, self.Interval)
			endIf
		elseIf (lists == "node_lists")
			if (self.CurrentModusList == "$slif_current_values")
				float value = 0.0
				if (SLIF_Main.IsNodeHidden(self.CurrentActor, sKey))
					value = StorageUtil.GetFloatValue(self.CurrentActor, sKey + "_hidden", 0.0000001)
				else
					value = SLIF_Main.GetValue(self.CurrentActor, self.CurrentMod, sKey, SLIF_Util.DefaultValue(self.CurrentMod))
				endIf
				return self.AddTextOption(sKey, value)
			elseIf (self.CurrentMod == "All Mods" && self.CurrentModusList == "$slif_hidden_nodes")
				return self.AddToggleOption(sKey, SLIF_Main.IsNodeHidden(self.CurrentActor, sKey))
			elseIf (self.CurrentMod != "All Mods")
				return self.AddSliderOption(sKey, StorageUtil.GetFloatValue(self.CurrentActor, self.CurrentMod + sKey + self.CurrentSuffix, self.CurrentDefault), self.Interval)
			endIf
		endIf
		
	endIf
	
	return 0
EndFunction

Event OnOptionInputOpen(int option)
	if (self.CurrentPage == "$Config")
		if (option == self.OID_search_npc)
			
		elseIf (option == self.OID_rename_npc)
			self.SetInputDialogStartText(self.CurrentName)
		endIf
	endIf
EndEvent

Event OnOptionInputAccept(int option, string sInput)
	if (self.CurrentPage == "$Config")
		if (option == self.OID_search_npc)
			if (sInput != "")
				int inputLength = StringUtil.GetLength(sInput)
				int contains = -1
				int count = StorageUtil.StringListCount(none, self.slif_actor_name_list)
				int i = 0
				while (i < count && contains == -1)
					String name = StorageUtil.StringListGet(none, self.slif_actor_name_list, i)
					int nameLength = StringUtil.GetLength(name)
					Actor kActor = StorageUtil.FormListGet(none, self.slif_actor_list, i) as Actor
					if (kActor != Game.GetPlayer())
						if (inputLength <= nameLength)
							if (StringUtil.Find(name, sInput) != -1)
								self.SetCurrentActor(kActor)
								self.ForcePageReset()
								return
							endIf
							int difference = nameLength - inputLength
							int j = 1
							while (j < difference && contains == -1)
								if (StringUtil.Find(name, sInput, j) != -1)
									contains = i
								else
									j += 1
								endIf
							endWhile
						endIf
					endIf
					i += 1
				endWhile
				if (contains != -1)
					self.SetCurrentActor(StorageUtil.FormListGet(none, self.slif_actor_list, contains) as Actor)
					self.ForcePageReset()
					return
				endIf
			endIf
		elseIf (option == self.OID_rename_npc)
			if (sInput != "")
				if (self.ChangeActorName(self.CurrentActor, "$Default_Modus", sInput) || self.ChangeActorName(self.CurrentActor, "$Morph_Modus", sInput))
					self.CurrentActor.SetDisplayName(sInput, true)
					self.ForcePageReset()
				endIf
			endIf
		endIf
	endIf
EndEvent

bool Function ChangeActorName(Actor kActor, String modus, String newName)
	bool morph_modus_var            = self.morph_modus_function(modus)
	String slif_actor_list_var      = self.slif_actor_list_function(morph_modus_var)
	String slif_actor_name_list_var = self.slif_actor_name_list_function(morph_modus_var)
	
	int index = StorageUtil.FormListFind(none, slif_actor_list_var, kActor)
	if (index != -1)
		if (StorageUtil.StringListGet(none, slif_actor_name_list_var, index) != newName)
			StorageUtil.StringListSet(none, slif_actor_name_list_var, index, newName)
			return true
		endIf
	endIf
	return false
EndFunction

String Function CreateScannerDisplay(Int Meters, Int Feet)
	Return "$slif_scanner_range_{" + Meters + "}_{" + Feet + "}"
EndFunction

Function SetHidden(int option, int index)
	if (index != -1)
		String list = SLIF_Util.GetListByCategory("node_lists", self.CurrentCategory)
		String node = SLIF_Util.GetListEntry("node_lists", list, index)
		if (SLIF_Main.IsNodeHidden(self.CurrentActor, node))
			SLIF_Main.showNode(self.CurrentActor, "SL Inflation Framework", node)
			self.SetToggleOptionValue(option, false)
		else
			SLIF_Main.hideNode(self.CurrentActor, "SL Inflation Framework", node)
			self.SetToggleOptionValue(option, true)
		endIf
	endIf
EndFunction

bool Function SetConfigToggle(int option, String sKey, int default = 0)
	int toggle = Math.LogicalXor(1, SLIF_Config.GetInt(sKey, default))
	SLIF_Config.SetInt(sKey, toggle)
	self.SetToggleOptionValue(option, toggle as bool)
	return toggle as bool
EndFunction

bool Function SetConfigPathToggle(int option, String path, String sKey, int default = 0)
	int toggle = Math.LogicalXor(1, SLIF_Config.GetPathInt(path, sKey, default))
	SLIF_Config.SetPathInt(path, sKey, toggle)
	self.SetToggleOptionValue(option, toggle as bool)
	return toggle as bool
EndFunction

Event OnOptionSelect(int option)
	
	if (self.CurrentPage == "$Config" || self.CurrentPage == "$Values_and_sliders")
		
		if (self.CurrentPage == "$Config")
			if (option == self.OID_uninstall_mod)
				if (SLIF_Main.IsInstalled())
					if (self.ShowMessage("$slif_uninstall_message", true, "$Yes", "$No"))
						uninstall()
						self.ShowMessage("$slif_done_uninstalling", false, "$Okay")
					endIf
				else
					if (self.ShowMessage("$slif_install_message", true, "$Yes", "$No"))
						install()
						self.ShowMessage("$slif_done_installing", false, "$Okay")
					endIf
				endIf
				self.ForcePageReset()
			elseIf (option == self.OID_sort_actor_list)
				if (self.ShowMessage("$slif_sort_actor_list_message", true, "$Yes", "$No"))
					SLIF_Sort.QuickSortActorList(self.slif_actor)
					self.ForcePageReset()
					self.ShowMessage("$slif_sort_actor_list_done", false, "$Okay")
				endIf
			elseIf (option == self.OID_move_npc_to_player)
				if (self.CurrentActor != Game.GetPlayer())
					if (self.ShowMessage("$slif_move_npc_to_player_message", true, "$Yes", "$No"))
						self.CurrentActor.MoveTo(Game.GetPlayer())
					endIf
				else
					self.ShowMessage("$slif_cant_move_player_to_player", false, "$Okay")
				endIf
			elseIf (option == self.OID_move_player_to_npc)
				if (self.CurrentActor != Game.GetPlayer())
					if (self.ShowMessage("$slif_move_player_to_npc_message", true, "$Yes", "$No"))
						Game.GetPlayer().MoveTo(self.CurrentActor)
					endIf
				else
					self.ShowMessage("$slif_cant_move_player_to_player", false, "$Okay")
				endIf
			endIf
		elseIf (self.CurrentPage == "$Values_and_sliders")
			int index = StorageUtil.IntListFind(self, "slif_oid_list", option)
			if (index != -1 && self.CurrentMod != "")
				if (self.CurrentModusList == "$slif_current_values")
					String sKey = StorageUtil.StringListGet(self, "slif_valid_key_list", (StorageUtil.GetIntValue(self, "slif_current_list_index") * self.CurrentListSize) + index)
					if (self.ShowMessage("$slif_unregister_node_{" + sKey + "}_for_{" + self.CurrentMod + "}", true, "$Yes", "$No"))
						if (self.morph_modus)
							SLIF_Morph.unregisterMorph(self.CurrentActor, sKey, self.CurrentMod)
						else
							SLIF_Main.unregisterNode(self.CurrentActor, sKey, self.CurrentMod)
						endIf
						if (!StorageUtil.StringListHas(self.CurrentActor, self.slif_mod_list, self.CurrentMod))
							SLIF_Util.SetModListCount(self.CurrentActor, self.slif_mod_list)
							StorageUtil.SetIntValue(self.CurrentActor, self.slif_mod_selection, 0)
							StorageUtil.SetIntValue(self.CurrentActor, self.slif_current_mod_list, 0)
						endIf
						self.ShowMessage("$slif_done_unregister_node_{" + sKey + "}_for_{" + self.CurrentMod + "}", false, "$Okay")
						self.ForcePageReset()
					endIf
				elseIf (self.CurrentModusList == "$slif_hidden_nodes")
					SetHidden(option, index)
				endIf
			endIf
		endIf
		
		if (option == self.OID_register_player)
			PlayerRef        = Game.GetPlayer()
			String name      = SLIF_Util.GetActorName(PlayerRef)
			String aToString = SLIF_Util.ActorToString(PlayerRef, name)
			if (StorageUtil.FormListHas(none, self.slif_actor_list, PlayerRef) == false)
				if (self.morph_modus)
					SLIF_Morph.registerActor(PlayerRef, "SL Inflation Framework")
				else
					SLIF_Main.registerActor(PlayerRef, "SL Inflation Framework")
				endIf
				self.SetCurrentActor(PlayerRef)
				self.ShowMessage("$slif_done_registering_player", false, "$Okay")
				self.ForcePageReset()
			else
				bool not_registered = false
				if (self.morph_modus)
					not_registered = SLIF_Morph_Util.registerSLIF(PlayerRef, name, aToString)
				else
					not_registered = SLIF_Util.registerSLIF(PlayerRef, name, aToString)
				endIf
				if (not_registered)
					self.ShowMessage("$slif_player_registered_for_slif", false, "$Okay")
					self.ForcePageReset()
				else
					self.ShowMessage("$slif_player_already_registered", false, "$Okay")
				endIf
			endIf
		endIf
		
	elseIf (self.CurrentPage == "$Toggles")
		
		if (option == self.OID_notification)
			SetConfigToggle(option, "show_notifications", 1)
		elseIf (option == self.OID_debug)
			SetConfigToggle(option, "show_debug_messages")
		elseIf (option == self.OID_hidden)
			SetConfigToggle(option, "show_hidden_values")
		elseIf (option == self.OID_auto_register_slif)
			SetConfigToggle(option, "auto_register_slif")
		elseIf (option == self.OID_auto_register_slif_player)
			SetConfigToggle(option, "auto_register_slif_player")
		elseIf (option == self.OID_morph_auto_register_slif)
			SetConfigToggle(option, "morph_auto_register_slif")
		elseIf (option == self.OID_morph_auto_register_slif_player)
			SetConfigToggle(option, "morph_auto_register_slif_player")
		elseIf (option == self.OID_non_unique_npcs_use_nio)
			SetConfigToggle(option, "non_unique_npcs_use_nio")
		elseIf (option == self.OID_inflate_on_menu_exit)
			if (!SetConfigToggle(option, "inflate_on_menu_exit", 1))
				executeInflationQueue()
			endIf
		elseIf (option == self.OID_treat_trans_as_male)
			SetConfigToggle(option, "treat_trans_as_male")
			SLIF_SexLab_Script.ForceSexLabGenderForActorList()
		elseIf (option == self.OID_treat_male_as_female)
			SetConfigToggle(option, "treat_male_as_female")
			SLIF_SexLab_Script.ForceSexLabGenderForActorList()
		endIf
		
	elseIf (self.CurrentPage == "$Bodymorphs")
		
		SLIF_Menu_Bodymorphs.OnOptionSelect(self, option)
		
	elseIf (self.CurrentPage == "$Scanner")
		
		if (option == self.OID_scanner_active)
			if (SetConfigPathToggle(option, ".scanner", ".active"))
				StartScanner()
			else
				StopScanner()
			endIf
		elseIf (option == self.OID_scanner_on_load)
			SetConfigPathToggle(option, ".scanner", ".on_load")
		elseIf (option == self.OID_scanner_over_time)
			SetConfigPathToggle(option, ".scanner", ".over_time")
		elseIf (option == self.OID_scanner_on_sleep)
			SetConfigPathToggle(option, ".scanner", ".on_sleep")
		elseIf (option == self.OID_scanner_purge_dead)
			SetConfigPathToggle(option, ".scanner", ".purge_dead")
		elseIf (option == self.OID_scanner_update_actors)
			SetConfigPathToggle(option, ".scanner", ".update_actors")
		endIf
		
	elseIf (self.CurrentPage == "$Mod_Extras")
		
		if (option == self.OID_timer_active)
			int toggle = Math.LogicalXor(1, StorageUtil.GetIntValue(none, "slif_timer_active"))
			StorageUtil.SetIntValue(none, "slif_timer_active", toggle)
			bool toggled = toggle as bool
			self.SetToggleOptionValue(option, toggled)
			if (toggled)
				StartTimer()
			else
				StopTimer()
			endIf
		endIf
		
	endIf
	
EndEvent

Function OpenMenu(String[] menu, int index, int default)
	SetMenuDialogOptions(menu)
	SetMenuDialogStartIndex(index)
	SetMenuDialogDefaultIndex(default)
EndFunction

Event OnOptionMenuOpen(int option)
	
	if (self.CurrentPage == "$Config" || self.CurrentPage == "$Values_and_sliders")
		
		if (self.CurrentPage == "$Config")
			
			if (option == self.OID_gender)
				self.OpenMenu(self.GetGenders(), self.GetGender(), 1)
			elseIf (option == self.OID_inflation_type)
				if (self.CurrentMod != "")
					self.OpenMenu(self.GetInflationTypes(), SLIF_Config.GetInflationType(self.CurrentMod, 1), 1)
				endIf
			elseIf (option == self.OID_calculation_type)
				self.OpenMenu(self.GetCalculationTypes(), self.GetCalculationType(), 0)
			elseIf (option == self.OID_sort_type)
				self.OpenMenu(self.GetSortTypes(), self.GetSortType(), 0)
			elseIf (option == self.OID_languages)
				self.OpenMenu(self.GetLanguages(), SLIF_Config.GetInt("language", 3), 0)
			endIf
			
		endIf
		
		if (self.CurrentPage == "$Config" || self.CurrentPage == "$Values_and_sliders")
			
			if (option == self.OID_modus)
				if (self.CurrentMod != "")
					self.OpenMenu(self.GetModusList(), self.CurrentSelection, 0)
				endIf
			elseIf (option == self.OID_category)
				if (self.CurrentMod != "")
					self.OpenMenu(self.GetCategories(), self.CurrentCategory, 0)
				endIf
			elseIf (option == self.OID_actors)
				String[] slice = new String[128]
				StorageUtil.StringListSlice(none, self.slif_actor_name_list, slice, self.GetActorListStartIndex())
				self.OpenMenu(slice, StorageUtil.GetIntValue(self, self.slif_actor_selection), 0)
			elseIf (option == self.OID_mods)
				String[] slice = new String[128]
				StorageUtil.StringListSlice(self.CurrentActor, self.slif_mod_list, slice, self.GetModListStartIndex(self.CurrentActor))
				if (slice[0] == "All Mods")
					slice[0] = "$" + slice[0]
				endIf
				self.OpenMenu(slice, StorageUtil.GetIntValue(self.CurrentActor, self.slif_mod_selection), 0)
			elseIf (option == self.OID_action_type)
				self.OpenMenu(self.GetActionTypes(), 0, 0)
			endIf
			
		endIf
		
	elseIf (self.CurrentPage == "$Bodymorphs")
		
		SLIF_Menu_Bodymorphs.OnOptionMenuOpen(self, option)
		
	elseIf (self.CurrentPage == "$Presets")
		
		SLIF_Menu_Preset.OnOptionMenuOpen(self, option)
		
	elseIf (self.CurrentPage == "$Set_List_Category")
		
		int index = StorageUtil.IntListFind(self, "slif_oid_list", option)
		if (index != -1)
			String lists = GetDefaultLists()
			String sKey = StorageUtil.StringListGet(self, "slif_valid_key_list", (StorageUtil.GetIntValue(self, "slif_current_list_index") * self.CurrentListSize) + index)
			String[] list_array = SLIF_Util.GetLists(lists)
			int count = list_array.length
			while(count > 0)
				count -= 1
				if (SLIF_Util.HasListEntry(lists, list_array[count], sKey))
					self.CurrentIndex = count
					count = 0
				endIf
			endWhile
			self.OpenMenu(list_array, self.CurrentIndex, 0)
		endIf
		
	elseIf (self.CurrentPage == "$Queue")
		
		if (option == self.OID_actors)
			String[] slice = new String[128]
			StorageUtil.StringListSlice(self, "slif_inflate_on_menu_exit_names", slice, StorageUtil.GetIntValue(self, "slif_queue_actor_list") * 128)
			self.OpenMenu(slice, StorageUtil.GetIntValue(self, "slif_queue_actor"), 0)
		elseIf (option == self.OID_mods)
			String[] slice = new String[128]
			Actor kActor = self.GetQueueActor()
			StorageUtil.StringListSlice(kActor, "slif_inflate_on_menu_exit_mods", slice, StorageUtil.GetIntValue(kActor, "slif_queue_mod_list") * 128)
			if (slice[0] == "All Mods")
				slice[0] = "$" + slice[0]
			endIf
			self.OpenMenu(slice, StorageUtil.GetIntValue(kActor, "slif_queue_mod"), 0)
		endIf
		
	endIf
EndEvent

Event OnOptionMenuAccept(int option, int index)
	
	if (self.CurrentPage == "$Config" || self.CurrentPage == "$Values_and_sliders")
		
		if (self.CurrentPage == "$Config")
			
			If (option == self.OID_gender)
				if (StorageUtil.GetIntValue(self.CurrentActor, "slif_gender") != index)
					StorageUtil.SetIntValue(self.CurrentActor, "slif_gender", index)
					SLIF_SexLab_Script.ForceSexLabGender(self.CurrentActor)
					self.SetMenuOptionValue(option, GetGenders()[index])
				endIf
			elseIf (option == self.OID_inflation_type)
				if (SLIF_Config.GetInflationType(self.CurrentMod, 1) != index)
					String newType = self.GetInflationTypes()[index]
					if (self.ShowMessage("$slif_set_inflation_type_for_{"+self.CurrentMod+"}_to_{"+newType+"}_message", true, "$Yes", "$No"))
						if (self.CurrentMod == "All Mods")
							int modCount = SLIF_Config.ModCount()
							int i = 0
							while(i < modCount)
								SetInflationTypeForMod(SLIF_Config.GetMod(i), index)
								i += 1
							endWhile
						else
							SetInflationTypeForMod(self.CurrentMod, index)
						endIf
						self.ShowMessage("$slif_done_setting_inflation_type_for_{"+self.CurrentMod+"}_to_{"+newType+"}", false, "$Okay")
						self.ForcePageReset()
					endIf
				endIf
			elseIf (option == self.OID_calculation_type)
				if (SLIF_Config.GetInt("calculation_type") != index)
					SLIF_Config.SetInt("calculation_type", index)
					;self.SetMenuOptionValue(option, self.GetCalculationTypes()[index])
					self.ForcePageReset()
				endIf
			elseIf (option == self.OID_sort_type)
				if (SLIF_Config.GetInt("sort_actors_ascending", 1) == index)
					SLIF_Config.SetInt("sort_actors_ascending", Math.LogicalXor(1, index))
					SLIF_Sort.QuickSortActorList(self.slif_actor)
					self.ForcePageReset()
				endIf
			elseIf (option == self.OID_languages)
				if (SLIF_Config.GetInt("language", 3) != index)
					SLIF_Config.SetInt("language", index)
					self.SetMenuOptionValue(option, self.GetLanguages()[index])
				endIf
			endIf
			
		endIf
		
		if (self.CurrentPage == "$Config" || self.CurrentPage == "$Values_and_sliders")
			
			if (option == self.OID_modus)
				if (self.CurrentMod != "")
					if (self.GetModusSelection() != index)
						self.SetModusSelection(index)
						StorageUtil.SetFloatValue(self, "slif_current_value", self.GetDefValue(self.GetModusList()[index]))
						self.ForcePageReset()
					endIf
				endIf
			elseIf (option == self.OID_category)
				if (self.CurrentMod != "")
					if (self.GetCategorySelection() != index)
						self.SetCategorySelection(index)
						self.ForcePageReset()
					endIf
				endIf
			elseIf (option == self.OID_actors)
				if (StorageUtil.GetIntValue(self, self.slif_actor_selection) != index)
					StorageUtil.SetIntValue(self, self.slif_actor_selection, index)
					self.SetCurrentActor(self.CalculateActor())
					self.ForcePageReset()
				endIf
			elseIf (option == self.OID_mods)
				if (StorageUtil.GetIntValue(self.CurrentActor, self.slif_mod_selection) != index)
					StorageUtil.SetIntValue(self.CurrentActor, self.slif_mod_selection, index)
					self.ForcePageReset()
				endIf
			elseIf (option == self.OID_action_type)
				if (index > 0)
					if (index == 1)
						if (self.CurrentMod != "")
							float value = StorageUtil.GetFloatValue(self, "slif_current_value", self.CurrentDefault)
							if (self.CurrentModusList == "$slif_current_sliders_mult")
								value = SLIF_Math.SetBounds(value, 0.01, 10.0)
							elseIf (self.CurrentModusList == "$slif_current_sliders_increment")
								value = SLIF_Math.SetBounds(value, 0.01, 1.0)
							endIf
							if (self.ShowMessage("$slif_set_actor_values_to_{"+value+"}_message", true, "$Yes", "$No"))
								self.SetWorking(true)
								if (self.morph_modus)
									SLIF_Morph_Util.setActorMorphsToValue(self.CurrentActor, self.CurrentMod, value, true, self.CurrentSuffix)
								else
									SLIF_Util.setActorKeysToValue(self.CurrentActor, self.CurrentMod, value, true, self.CurrentSuffix)
								endIf
								self.ShowMessage("$slif_done_setting_actor_values_to_{"+value+"}", false, "$Okay")
								self.SetWorking(false)
							endIf
						endIf
					elseIf (index == 2)
						if (self.CurrentMod != "")
							if (self.ShowMessage("$slif_update_actor_message", true, "$Yes", "$No"))
								self.SetWorking(true)
								if (self.morph_modus)
									SLIF_Morph.updateActor(self.CurrentActor, self.CurrentMod)
								else
									SLIF_Main.updateActor(self.CurrentActor, self.CurrentMod)
								endIf
								self.ShowMessage("$slif_done_updating_actor", false, "$Okay")
								self.SetWorking(false)
							endIf
						endIf
					elseIf (index == 3)
						if (self.CurrentMod != "")
							if (self.ShowMessage("$slif_update_all_actors_message", true, "$Yes", "$No"))
								self.SetWorking(true)
								if (self.morph_modus)
									SLIF_Morph.updateActorList(self.CurrentMod)
								else
									SLIF_Main.updateActorList(self.CurrentMod)
								endIf
								self.ShowMessage("$slif_done_updating_all_actors", false, "$Okay")
								self.SetWorking(false)
							endIf
						endIf
					elseIf (index == 4)
						if (self.CurrentMod != "")
							if (self.ShowMessage("$slif_reset_actor_message", true, "$Yes", "$No"))
								self.SetWorking(true)
								if (self.morph_modus)
									SLIF_Morph.resetActor(self.CurrentActor, self.CurrentMod)
								else
									SLIF_Main.resetActor(self.CurrentActor, self.CurrentMod)
								endIf
								self.ShowMessage("$slif_done_updating_actor", false, "$Okay")
								self.SetWorking(false)
							endIf
						endIf
					elseIf (index == 5)
						if (self.CurrentMod != "")
							if (self.ShowMessage("$slif_reset_all_actors_message", true, "$Yes", "$No"))
								self.SetWorking(true)
								if (self.morph_modus)
									SLIF_Morph.resetActorList(self.CurrentMod)
								else
									SLIF_Main.resetActorList(self.CurrentMod)
								endIf
								self.ShowMessage("$slif_done_updating_all_actors", false, "$Okay")
								self.SetWorking(false)
							endIf
						endIf
					elseIf (index == 6)
						if (self.ShowMessage("$slif_unregister_actor_message", true, "$Yes", "$No"))
							self.SetWorking(true)
							String mod = self.CurrentMod
							if (StorageUtil.GetIntValue(self.CurrentActor, self.slif_mod_selection) == 0 || self.CurrentMod == "")
								mod = "All Mods"
							else
								StorageUtil.SetIntValue(self.CurrentActor, self.slif_mod_selection, 0)
							endIf
							if (self.morph_modus)
								SLIF_Morph.unregisterActor(self.CurrentActor, mod)
							else
								SLIF_Main.unregisterActor(self.CurrentActor, mod)
							endIf
							int count = StorageUtil.FormListCount(none, self.slif_actor_list)
							if (count > 0)
								int currentListCount = count / 128
								if (StorageUtil.GetIntValue(self, self.slif_current_actor_list) > currentListCount)
									StorageUtil.SetIntValue(self, self.slif_current_actor_list, currentListCount)
								endIf
								StorageUtil.SetIntValue(self, self.slif_actor_selection, 0)
							else
								self.CurrentActor = none
								self.CurrentName = none
								self.CurrentNameToString = none
								StorageUtil.SetIntValue(self, self.slif_actor_selection, 0)
								StorageUtil.SetIntValue(self, self.slif_current_actor_list, 0)
							endIf
							self.ShowMessage("$slif_done_unregistering_actor", false, "$Okay")
							self.SetWorking(false)
						endIf
					elseIf (index == 7)
						if (self.ShowMessage("$slif_unregister_all_actors_message", true, "$Yes", "$No"))
							self.SetWorking(true)
							if (StorageUtil.GetIntValue(self.CurrentActor, self.slif_mod_selection) == 0 || self.CurrentMod == "")
								clearActorList(self.CurrentModus)
							else
								int count = StorageUtil.FormListCount(none, self.slif_actor_list)
								int i = 0
								while(i < count)
									Actor kActor = StorageUtil.FormListGet(none, self.slif_actor_list, i) as Actor
									if (self.morph_modus)
										SLIF_Morph.unregisterActor(kActor, self.CurrentMod)
									else
										SLIF_Main.unregisterActor(kActor, self.CurrentMod)
									endIf
									i += 1
								endWhile
							endIf
							self.ShowMessage("$slif_done_unregistering_all_actors", false, "$Okay")
							self.SetWorking(false)
						endIf
					elseIf (index == 8)
						if (self.ShowMessage("$slif_remove_actor_message", true, "$Yes", "$No"))
							SLIF_Util.RemoveActor(self.CurrentActor, self.CurrentNameToString, self.CalculateActorListIndex(), self.slif_actor)
							self.CurrentActor = none
							self.CurrentName = none
							self.CurrentNameToString = none
							StorageUtil.SetIntValue(self, self.slif_actor_selection, 0)
						endIf
					endIf
					self.ForcePageReset()
				endIf
			endIf
			
		endIf
		
	elseIf (self.CurrentPage == "$Bodymorphs")
		
		SLIF_Menu_Bodymorphs.OnOptionMenuAccept(self, option, index)
		
	elseIf (self.CurrentPage == "$Presets")
		
		SLIF_Menu_Preset.OnOptionMenuAccept(self, option, index)
		
	elseIf (self.CurrentPage == "$Set_List_Category")
		
		if (self.CurrentIndex != index)
			int idx = StorageUtil.IntListFind(self, "slif_oid_list", option)
			if (idx != -1)
				String lists = GetDefaultLists()
				String list  = GetDefaultList()
				int current_list_index = (StorageUtil.GetIntValue(self, "slif_current_list_index") * self.CurrentListSize) + idx
				String sKey  = StorageUtil.StringListGet(self, "slif_valid_key_list", current_list_index)
				String[] list_array = SLIF_Util.GetLists(lists)
				String current_list = list_array[self.CurrentIndex]
				String new_list = list_array[index]
				
				bool changed = false
				
				if (current_list != list)
					SLIF_Util.RemoveEntry(lists, current_list, sKey)
					changed = true
				endIf
				
				if (new_list != list)
					SLIF_Util.AddEntry(lists, new_list, sKey)
					changed = true
				endIf
				
				if (changed)
					SLIF_Util.SaveJson("SexLab Inflation Framework/Lists.json")
					if (self.FilterByCategory == "$All Categories")
						self.SetMenuOptionValue(option, new_list)
					else
						self.ForcePageReset()
					endIf
				endIf
				
			endIf
		endIf
		
	elseIf (self.CurrentPage == "$Queue")
		
		if (option == self.OID_actors)
			if (StorageUtil.GetIntValue(self, "slif_queue_actor") != index)
				StorageUtil.SetIntValue(self, "slif_queue_actor", index)
				self.ForcePageReset()
			endIf
		elseIf (option == self.OID_mods)
			Actor kActor = GetQueueActor()
			if (StorageUtil.GetIntValue(kActor, "slif_queue_mod") != index)
				StorageUtil.SetIntValue(kActor, "slif_queue_mod", index)
				self.ForcePageReset()
			endIf
		endIf
		
	endIf
EndEvent

String Function GetSuffix()
	if (self.CurrentModusList == "$Minimum")
		return "_min"
	elseIf (self.CurrentModusList == "$Maximum")
		return "_max"
	elseIf (self.CurrentModusList == "$slif_current_sliders_mult")
		return "_mult"
	elseIf (self.CurrentModusList == "$slif_current_sliders_increment")
		return "_increment"
	endIf
	return ""
EndFunction

float Function GetDefValue(String modus_list)
	if (modus_list == "$slif_inflation_type")
		return SLIF_Util.GetDefaultInflationType()
	elseIf (modus_list == "$Minimum")
		return SLIF_Util.GetDefaultMinimum(self.morph_modus)
	elseIf (modus_list == "$Maximum")
		return SLIF_Util.GetDefaultMaximum()
	elseIf (modus_list == "$slif_current_sliders_mult")
		return SLIF_Util.GetDefaultMultiplier()
	elseIf (modus_list == "$slif_current_sliders_increment")
		return SLIF_Util.GetDefaultIncrement()
	endIf
	return 0.0
EndFunction

float Function GetMinValue()
	if (self.CurrentModusList == "$slif_current_sliders_mult" || self.CurrentModusList == "$slif_current_sliders_increment")
		return 0.01
	endIf
	if (self.morph_modus)
		return -100.0
	endIf
	return 0.0
EndFunction

float Function GetMaxValue()
	if (self.CurrentModusList == "$slif_current_sliders_mult")
		return 10.0
	elseIf (self.CurrentModusList == "$slif_current_sliders_increment")
		return  1.0
	endIf
	return 100.0
EndFunction

float Function GetInterval()
	return 0.01
EndFunction

bool Function SetInflationTypeForMod(String mod, int index, bool modified = false)
	if (SLIF_Config.GetInflationType(mod, 1) != index)
		SLIF_Config.SetInflationType(mod, index)
		modified  = true
	endIf
	String prefix = self.GetMorphPrefix()
	String lists  = self.GetDefaultLists()
	String list   = SLIF_Util.GetListByCategory(lists, 0)
	int count     = SLIF_Util.GetListSize(lists, list)
	int i         = 0
	while(i < count)
		String node = SLIF_Util.GetListEntry(lists, list, i)
		if (SLIF_Preset.FloatListGet(mod, prefix + node, 0, 1) != index)
			SLIF_Preset.FloatListSet(mod, prefix + node, 0, index)
		endIf
		i += 1
	endWhile
	return modified
EndFunction

Function SetWorking(bool working)
	if (working)
		SetTitleText("$slif_working")
	else
		SetTitleText(self.CurrentPage)
	endIf
	StorageUtil.SetIntValue(none, "slif_working", working as int)
EndFunction

Function SetSliderOpen(float val, float def, float min, float max, float ival)
	SetSliderDialogStartValue(val)
	SetSliderDialogDefaultValue(def)
	SetSliderDialogRange(min, max)
	SetSliderDialogInterval(ival)
EndFunction

Function SliderListOpen(int option)
	int index = StorageUtil.IntListFind(self, "slif_oid_list", option)
	if (index != -1)
		String sKey = StorageUtil.StringListGet(self, "slif_valid_key_list", (StorageUtil.GetIntValue(self, "slif_current_list_index") * self.CurrentListSize) + index)
		float val   = StorageUtil.GetFloatValue(self.CurrentActor, self.GetNodeName(sKey) + self.CurrentSuffix, self.CurrentDefault)
		self.SetSliderOpen(val, self.CurrentDefault, self.CurrentMinimum, self.CurrentMaximum, self.CurrentInterval)
	endIf
EndFunction

Event OnOptionSliderOpen(int option)
	
	if (option == self.OID_current_value)
		
		if (self.CurrentMod != "")
			self.SetSliderOpen(StorageUtil.GetFloatValue(self, "slif_current_value", self.CurrentDefault), self.CurrentDefault, self.CurrentMinimum, self.CurrentMaximum, self.CurrentInterval)
		endIf
		
	elseIf (self.CurrentPage == "$Config" || self.CurrentPage == "$Values_and_sliders")
		
		if (self.CurrentPage == "$Config")
			
			if (option == self.OID_top_x)
				self.SetSliderOpen(SLIF_Config.GetInt("top_x", 3), 3, 2, 10, 1)
			endIf
			
		elseIf (self.CurrentPage == "$Values_and_sliders")
			
			if (self.CurrentMod != "")
				SliderListOpen(option)
			endIf
			
		endIf
		
		if (option == self.OID_actor_list)
			int count = StorageUtil.GetIntValue(none, "slif_actor_name_list_count", 1)
			int list  = StorageUtil.GetIntValue(self, "slif_current_actor_list")
			self.SetSliderOpen(list + 1, 1, 1, count, 1)
		elseIf (option == self.OID_mod_list)
			int count = StorageUtil.GetIntValue(self.CurrentActor, "slif_mod_list_count",   1)
			int list  = StorageUtil.GetIntValue(self.CurrentActor, "slif_current_mod_list")
			self.SetSliderOpen(list + 1, 1, 1, count, 1)
		endIf
		
	elseIf (self.CurrentPage == "$Bodymorphs")
		
		SLIF_Menu_Bodymorphs.OnOptionSliderOpen(self, option)
		
	elseIf (self.CurrentPage == "$Presets")
		
		SLIF_Menu_Preset.OnOptionSliderOpen(self, option)
		
	elseIf (self.CurrentPage == "$Queue")
		
		if (option == self.OID_actor_list)
			int max  = StorageUtil.FormListCount(self, "slif_inflate_on_menu_exit_actors") / 128 + 1
			int list = StorageUtil.GetIntValue(self, "slif_queue_actor_list")
			self.SetSliderOpen(list + 1, 1, 1, max, 1)
		elseIf (option == self.OID_mod_list)
			Actor kActor = GetQueueActor()
			int max  = StorageUtil.StringListCount(kActor, "slif_inflate_on_menu_exit_mods") / 128 + 1
			int list = StorageUtil.GetIntValue(kActor, "slif_queue_mod_list")
			self.SetSliderOpen(list + 1, 1, 1, max, 1)
		endIf
		
	elseIf (self.CurrentPage == "$Scanner")
		
		if (option == self.OID_update_interval)
			SLIF_Scanner Scanner = Game.GetFormFromFile(0x801, "SexLab Inflation Framework.esp") as SLIF_Scanner
			self.SetSliderOpen(Scanner.UpdateTimer.GetValue(), 30.0, 10.0, 300.0, 1.0)
		elseIf (option == self.OID_scanner_range)
			SLIF_Scanner Scanner = Game.GetFormFromFile(0x801, "SexLab Inflation Framework.esp") as SLIF_Scanner
			self.SetSliderOpen(Scanner.pScannerRange.GetValue(), 2048.0, 256.0, 2560.0, 128.0)
		endIf
		
	elseIf (self.CurrentPage == "$Mod_Extras")
		
		Actor kActor = Game.GetPlayer()
		
		if (option == self.OID_inflate_scrotum_update)
			self.SetSliderOpen(StorageUtil.GetFloatValue(kActor, "slif_inflate_scrotum_update",        1.0),   1.0,  0.1,   2.0, 0.1)
		elseIf (option == self.OID_inflate_scrotum)
			self.SetSliderOpen(StorageUtil.GetFloatValue(kActor, "slif_inflate_scrotum",               0.01),  0.01, 0.01,  1.0, 0.01)
		elseIf (option == self.OID_deflate_scrotum)
			self.SetSliderOpen(StorageUtil.GetFloatValue(kActor, "slif_deflate_scrotum",               0.5),   0.5,  0.01,  1.0, 0.01)
		elseIf (option == self.OID_inflate_scrotum_min)
			self.SetSliderOpen(StorageUtil.GetFloatValue(kActor, "slif_inflate_scrotum_min",           1.0),   1.0,  0.0,  99.0, 0.01)
		elseIf (option == self.OID_inflate_scrotum_max)
			self.SetSliderOpen(StorageUtil.GetFloatValue(kActor, "slif_inflate_scrotum_max",           2.0),   2.0,  1.0, 100.0, 0.01)
		elseIf (option == self.OID_inflate_scrotum_absolute_max)
			self.SetSliderOpen(StorageUtil.GetFloatValue(kActor, "slif_inflate_scrotum_absolute_max", 10.0),  10.0,  1.0, 100.0, 0.01)	
		endIf
		
	endIf
EndEvent

String Function GetMorphPrefix()
	if (self.morph_modus)
		return ".morphs."
	endIf
	return "."
EndFunction

String Function GetDefaultLists()
	if (self.morph_modus)
		return "morph_lists"
	endIf
	return "node_lists"
EndFunction

String Function GetDefaultList()
	if (self.morph_modus)
		return "000_morphs"
	endIf
	return "000_nodes"
EndFunction

String Function GetNodeName(String node)
	if (self.morph_modus)
		return "slif_" + self.CurrentMod + "_" + node
	endIf
	return self.CurrentMod + node
EndFunction

Function InflateSliderAccept(int option, float value)
	if (self.CurrentMod != "")
		int index = StorageUtil.IntListFind(self, "slif_oid_list", option)
		if (index != -1)
			String sKey = StorageUtil.StringListGet(self, "slif_valid_key_list", (StorageUtil.GetIntValue(self, "slif_current_list_index") * self.CurrentListSize) + index)
			string NodeName = self.GetNodeName(sKey)
			if (self.CurrentModusList == "$slif_current_sliders")
				self.SetSliderOptionValue(option, value, self.Interval)
				inflateConditional(self.CurrentActor, self.CurrentMod, sKey, value)
			elseIf (self.CurrentModusList == "$Minimum")
				float size = StorageUtil.GetFloatValue(self.CurrentActor, NodeName, 0.0)
				float max  = StorageUtil.GetFloatValue(self.CurrentActor, NodeName + "_max", 100.0)
					SetSliderFloatValue(self.CurrentActor, option, NodeName + "_min", value)
				if (max < value)
					SetSliderFloatValue(self.CurrentActor, option, NodeName + "_max", value)
				endIf
				if (value > size)
					self.SetSliderOptionValue(option, value, self.Interval)
					inflateConditional(self.CurrentActor, self.CurrentMod, sKey, size)
				endIf
			elseIf (self.CurrentModusList == "$Maximum")
				float size = StorageUtil.GetFloatValue(self.CurrentActor, NodeName, 0.0)
				float min  = StorageUtil.GetFloatValue(self.CurrentActor, NodeName + "_min", 0.0)
					SetSliderFloatValue(self.CurrentActor, option, NodeName + "_max", value)
				if (min > value)
					SetSliderFloatValue(self.CurrentActor, option, NodeName + "_min", value)
				endIf
				if (value < size)
					self.SetSliderOptionValue(option, value, self.Interval)
					inflateConditional(self.CurrentActor, self.CurrentMod, sKey, size)
				endIf
			elseIf (self.CurrentModusList == "$slif_current_sliders_mult")
				float size = StorageUtil.GetFloatValue(self.CurrentActor, NodeName, 0.0)
				SetSliderFloatValue(self.CurrentActor, option, NodeName + "_mult", value)
				inflateConditional(self.CurrentActor, self.CurrentMod, sKey, size)
			elseIf (self.CurrentModusList == "$slif_current_sliders_increment")
				SetSliderFloatValue(self.CurrentActor, option, NodeName + "_increment", value)
			endIf
		endIf
	endIf
EndFunction

Function inflateConditional(Actor kActor, String mod, String node, float value)
	if (SLIF_Config.GetInt("inflate_on_menu_exit", 1) as bool)
		if (StorageUtil.FormListAdd(self, "slif_inflate_on_menu_exit_actors", kActor, false) != -1)
			String name = SLIF_Util.GetActorName(kActor)
			StorageUtil.StringListAdd(self, "slif_inflate_on_menu_exit_names", name)
		endIf
		StorageUtil.StringListAdd(kActor, "slif_inflate_on_menu_exit_mods", mod, false)
		if (!StorageUtil.StringListHas(kActor, "slif_inflate_on_menu_exit_keys" + mod, node))
			StorageUtil.StringListAdd(kActor, "slif_inflate_on_menu_exit_keys" + mod, node)
			StorageUtil.FloatListAdd(kActor, "slif_inflate_on_menu_exit_values" + mod, value)
		else
			int index = StorageUtil.StringListFind(kActor, "slif_inflate_on_menu_exit_keys" + mod, node)
			StorageUtil.FloatListSet(kActor, "slif_inflate_on_menu_exit_values" + mod, index, value)
		endIf
	else
		if (StorageUtil.StringListHas(kActor, "slif_inflate_on_menu_exit_keys" + mod, node))
			int index = StorageUtil.StringListFind(kActor, "slif_inflate_on_menu_exit_keys" + mod, node)
			StorageUtil.StringListRemoveAt(kActor, "slif_inflate_on_menu_exit_keys" + mod, index)
			StorageUtil.FloatListRemoveAt(kActor, "slif_inflate_on_menu_exit_values" + mod, index)
		endIf
		if (StorageUtil.StringListCount(kActor, "slif_inflate_on_menu_exit_keys" + mod) == 0)
			StorageUtil.StringListRemove(kActor, "slif_inflate_on_menu_exit_mods", mod)
		endIf
		if (StorageUtil.StringListCount(kActor, "slif_inflate_on_menu_exit_mods") == 0)
			int index = StorageUtil.FormListFind(self, "slif_inflate_on_menu_exit_actors", kActor)
			StorageUtil.FormListRemoveAt(self, "slif_inflate_on_menu_exit_actors", index)
			StorageUtil.StringListRemoveAt(self, "slif_inflate_on_menu_exit_names", index)
		endIf
		if (self.morph_modus)
			SLIF_Morph.morph(kActor, mod, node, value)
		else
			SLIF_Main.inflate(kActor, mod, node, value)
		endIf
	endIf
EndFunction

float Function SetSliderFloatValue(Form ObjKey, int oid, String node, float value, String ival = "{2}")
	StorageUtil.SetFloatValue(ObjKey, node, value)
	self.SetSliderOptionValue(oid, value, ival)
	return value
EndFunction

Event OnOptionSliderAccept(int option, float value)
	
	if (option == self.OID_current_value)
		
		if (StorageUtil.GetFloatValue(self, "slif_current_value", self.CurrentDefault) != value)
			StorageUtil.SetFloatValue(self, "slif_current_value", value)
			self.SetSliderOptionValue(option, value, self.Interval)
		endIf
		
	elseIf (self.CurrentPage == "$Config" || self.CurrentPage == "$Values_and_sliders")
		
		if (self.CurrentPage == "$Config")
			if (option == self.OID_top_x)
				SLIF_Config.SetInt("top_x", (value as Int))
				self.SetSliderOptionValue(option, value)
			endIf
		elseIf (self.CurrentPage == "$Values_and_sliders")
			if (self.CurrentMod != "")
				self.InflateSliderAccept(option, value)
			endIf
		endIf
		
		if (option == self.OID_actor_list)
			int intVal = value as int
			int minusOne = (intVal - 1)
			if (StorageUtil.GetIntValue(self, "slif_current_actor_list") != minusOne)
				StorageUtil.SetIntValue(self, "slif_actor_selection", 0)
				StorageUtil.SetIntValue(self, "slif_current_actor_list", minusOne)
				StorageUtil.SetIntValue(self.CurrentActor, "slif_mod_selection", 0)
				StorageUtil.SetIntValue(self.CurrentActor, "slif_current_mod_list", 0)
				self.SetSliderOptionValue(option, intVal)
				self.SetCurrentActor(CalculateActor())
				self.ForcePageReset()
			endIf
		elseIf (option == self.OID_mod_list)
			int intVal = value as int
			int minusOne = (intVal - 1)
			if (StorageUtil.GetIntValue(self.CurrentActor, "slif_current_mod_list") != minusOne)
				StorageUtil.SetIntValue(self.CurrentActor, "slif_mod_selection", 0)
				StorageUtil.SetIntValue(self.CurrentActor, "slif_current_mod_list", minusOne)
				self.SetSliderOptionValue(option, intVal)
				self.ForcePageReset()
			endIf
		endIf
		
	elseIf (self.CurrentPage == "$Bodymorphs")
		
		SLIF_Menu_Bodymorphs.OnOptionSliderAccept(self, option, value)
		
	elseIf (self.CurrentPage == "$Presets")
		
		SLIF_Menu_Preset.OnOptionSliderAccept(self, option, value)
		
	elseIf (self.CurrentPage == "$Queue")
		
		if (option == self.OID_actor_list)
			int intVal = value as int
			int minusOne = (intVal - 1)
			if (StorageUtil.GetIntValue(self, "slif_queue_actor_list") != minusOne)
				StorageUtil.SetIntValue(self, "slif_queue_actor_list", minusOne)
				self.SetSliderOptionValue(option, intVal)
				self.ForcePageReset()
			endIf
		elseIf (option == self.OID_mod_list)
			int intVal = value as int
			int minusOne = (intVal - 1)
			Actor kActor = GetQueueActor()
			if (StorageUtil.GetIntValue(kActor, "slif_queue_mod_list") != minusOne)
				StorageUtil.SetIntValue(kActor, "slif_queue_mod_list", minusOne)
				self.SetSliderOptionValue(option, intVal)
				self.ForcePageReset()
			endIf
		endIf
		
	elseIf (self.CurrentPage == "$Scanner")
		SLIF_Scanner Scanner = Game.GetFormFromFile(0x801, "SexLab Inflation Framework.esp") as SLIF_Scanner
		
		if (option == self.OID_update_interval)
			if (Scanner.UpdateTimer.GetValue() != value)
				Scanner.UpdateTimer.SetValue(value)
				self.SetSliderOptionValue(option, value)
			endIf
		elseIf (option == self.OID_scanner_range)
			if (Scanner.pScannerRange.GetValue() != value)
				Scanner.pScannerRange.SetValue(value)
				self.SetSliderOptionValue(option, value)
			endIf
		endIf
		
	elseIf (self.CurrentPage == "$Mod_Extras")
		
		Actor kActor = Game.GetPlayer()
		float min    = StorageUtil.GetFloatValue(kActor, "slif_inflate_scrotum_min",           1.0)
		float max    = StorageUtil.GetFloatValue(kActor, "slif_inflate_scrotum_max",           2.0)
		float abs    = StorageUtil.GetFloatValue(kActor, "slif_inflate_scrotum_absolute_max", 10.0)
		
		if (option == self.OID_inflate_scrotum_update)
			SetSliderFloatValue(kActor, option, "slif_inflate_scrotum_update", value, "{1}")
		elseIf (option == self.OID_inflate_scrotum)
			SetSliderFloatValue(kActor, option, "slif_inflate_scrotum", value)
		elseIf (option == self.OID_deflate_scrotum)
			SetSliderFloatValue(kActor, option, "slif_deflate_scrotum", value)
		elseIf (option == self.OID_inflate_scrotum_min)
			min = SetSliderFloatValue(kActor, option, "slif_inflate_scrotum_min", SLIF_Math.MinFloat(value, max))
		elseIf (option == self.OID_inflate_scrotum_max)
			max = SetSliderFloatValue(kActor, option, "slif_inflate_scrotum_max", SLIF_Math.SetBounds(value, min, abs))
		elseIf (option == self.OID_inflate_scrotum_absolute_max)
			abs = SetSliderFloatValue(kActor, option, "slif_inflate_scrotum_absolute_max", SLIF_Math.MaxFloat(value, max))
		endIf
	
	endIf
EndEvent

bool Function SetConfigToggleDefault(int option, String sKey, int default = 0)
	if (SLIF_Config.GetInt(sKey, default) != default)
		SLIF_Config.SetInt(sKey, default)
		self.SetToggleOptionValue(option, default as bool)
		return true
	endIf
	return false
EndFunction

bool Function SetConfigPathToggleDefault(int option, String path, String sKey, int default = 0)
	if (SLIF_Config.GetPathInt(path, sKey, default) != default)
		SLIF_Config.SetPathInt(path, sKey, default)
		self.SetToggleOptionValue(option, default as bool)
		return true
	endIf
	return false
EndFunction

Event OnOptionDefault(int option)
	
	if (option == self.OID_current_value)
		
		if (self.CurrentMod != "")
			if (StorageUtil.GetFloatValue(self, "slif_current_value", self.CurrentDefault) != self.CurrentDefault)
				StorageUtil.SetFloatValue(self, "slif_current_value", self.CurrentDefault)
				if (self.CurrentModusList == "$slif_inflation_type")
					self.SetMenuOptionValue(option, self.GetInflationTypes()[self.CurrentDefault as int])
				else
					self.SetSliderOptionValue(option, self.CurrentDefault, self.Interval)
				endIf
			endIf
		endIf
		
	elseIf (self.CurrentPage == "$Config" || self.CurrentPage == "$Values_and_sliders")
		
		if (self.CurrentPage == "$Config")
		
			if (option == self.OID_top_x)
				if (SLIF_Config.GetInt("top_x", 3) != 3)
					SLIF_Config.SetInt("top_x", 3)
					self.SetSliderOptionValue(option, 3)
				endIf
			endIf
			
		elseIf (self.CurrentPage == "$Values_and_sliders")
			
			if (self.CurrentMod != "")
				self.InflateSliderAccept(option, self.CurrentDefault)
			endIf
			
		endIf
		
	elseIf (self.CurrentPage == "$Toggles")
		
		if (option == self.OID_notification)
			SetConfigToggleDefault(option, "show_notifications", 1)
		elseIf (option == self.OID_debug)
			SetConfigToggleDefault(option, "show_debug_messages")
		elseIf (option == self.OID_hidden)
			SetConfigToggleDefault(option, "show_hidden_values")
		elseIf (option == self.OID_auto_register_slif)
			SetConfigToggleDefault(option, "auto_register_slif")
		elseIf (option == self.OID_auto_register_slif_player)
			SetConfigToggleDefault(option, "auto_register_slif_player")
		elseIf (option == self.OID_morph_auto_register_slif)
			SetConfigToggleDefault(option, "morph_auto_register_slif")
		elseIf (option == self.OID_morph_auto_register_slif_player)
			SetConfigToggleDefault(option, "morph_auto_register_slif_player")
		elseIf (option == self.OID_non_unique_npcs_use_nio)
			SetConfigToggleDefault(option, "non_unique_npcs_use_nio")
		elseIf (option == self.OID_inflate_on_menu_exit)
			if (SetConfigToggleDefault(option, "inflate_on_menu_exit", 1))
				executeInflationQueue()
			endIf
		elseIf (option == self.OID_treat_trans_as_male)
			SetConfigToggleDefault(option, "treat_trans_as_male")
		elseIf (option == self.OID_treat_male_as_female)
			SetConfigToggleDefault(option, "treat_male_as_female")
		endIf
		
	elseIf (self.CurrentPage == "$Bodymorphs")
		
		SLIF_Menu_Bodymorphs.OnOptionDefault(self, option)
		
	elseIf (self.CurrentPage == "$Presets")
		
		SLIF_Menu_Preset.OnOptionDefault(self, option)
		
	elseIf (self.CurrentPage == "$Queue")
		
		if (option == self.OID_actor_list)
			if (StorageUtil.GetIntValue(self, "slif_queue_actor_list") != 0)
				StorageUtil.SetIntValue(self, "slif_queue_actor_list", 0)
				self.SetSliderOptionValue(option, 1)
				self.ForcePageReset()
			endIf
		elseIf (option == self.OID_mod_list)
			Actor kActor = GetQueueActor()
			if (StorageUtil.GetIntValue(kActor, "slif_queue_mod_list") != 0)
				StorageUtil.SetIntValue(kActor, "slif_queue_mod_list", 0)
				self.SetSliderOptionValue(option, 1)
				self.ForcePageReset()
			endIf
		endIf
		
	elseIf (self.CurrentPage == "$Mod_Extras")
		
		Actor kActor = Game.GetPlayer()
		float min    = StorageUtil.GetFloatValue(kActor, "slif_inflate_scrotum_min",           1.0)
		float max    = StorageUtil.GetFloatValue(kActor, "slif_inflate_scrotum_max",           2.0)
		float abs    = StorageUtil.GetFloatValue(kActor, "slif_inflate_scrotum_absolute_max", 10.0)
		
		if (option == self.OID_timer_active)
			if (StorageUtil.GetIntValue(none, "slif_timer_active") as bool)
				StorageUtil.SetIntValue(none, "slif_timer_active", 0)
				StopTimer()
				self.SetToggleOptionValue(option, false)
			endIf
		elseIf (option == self.OID_inflate_scrotum_update)
			SetSliderFloatValue(kActor, option, "slif_inflate_scrotum_update", 0.1, "{1}")
		elseIf (option == self.OID_inflate_scrotum)
			SetSliderFloatValue(kActor, option, "slif_inflate_scrotum", 0.01)
		elseIf (option == self.OID_deflate_scrotum)
			SetSliderFloatValue(kActor, option, "slif_deflate_scrotum", 0.5)
		elseIf (option == self.OID_inflate_scrotum_min)
			min = SetSliderFloatValue(kActor, option, "slif_inflate_scrotum_min", 1.0)
		elseIf (option == self.OID_inflate_scrotum_max)
			max = SetSliderFloatValue(kActor, option, "slif_inflate_scrotum_max", 2.0)
			if (min > max)
				min = SetSliderFloatValue(kActor, self.OID_inflate_scrotum_min, "slif_inflate_scrotum_min", max)
			endIf
			if (abs < max)
				abs = SetSliderFloatValue(kActor, self.OID_inflate_scrotum_absolute_max, "slif_inflate_scrotum_absolute_max", max)
			endIf
		elseIf (option == self.OID_inflate_scrotum_absolute_max)
			abs = SetSliderFloatValue(kActor, option, "slif_inflate_scrotum_absolute_max", 10.0)
			if (min > abs)
				min = SetSliderFloatValue(kActor, self.OID_inflate_scrotum_min, "slif_inflate_scrotum_min", abs)
			endIf
			if (max > abs)
				max = SetSliderFloatValue(kActor, self.OID_inflate_scrotum_max, "slif_inflate_scrotum_max", abs)
			endIf
		endIf
		
	elseIf (self.CurrentPage == "$Scanner")
	
		if (option == self.OID_scanner_active)
			if (SetConfigPathToggleDefault(option, ".scanner", ".active"))
				StopScanner()
			endIf
		elseIf (option == self.OID_scanner_on_load)
			SetConfigPathToggleDefault(option, ".scanner", ".on_load")
		elseIf (option == self.OID_scanner_over_time)
			SetConfigPathToggleDefault(option, ".scanner", ".over_time")
		elseIf (option == self.OID_scanner_on_sleep)
			SetConfigPathToggleDefault(option, ".scanner", ".on_sleep")
		elseIf (option == self.OID_scanner_purge_dead)
			SetConfigPathToggleDefault(option, ".scanner", ".purge_dead")
		elseIf (option == self.OID_scanner_update_actors)
			SetConfigPathToggleDefault(option, ".scanner", ".update_actors")
		elseIf (option == self.OID_update_interval)
			SLIF_Scanner Scanner = Game.GetFormFromFile(0x801, "SexLab Inflation Framework.esp") as SLIF_Scanner
			if (Scanner.UpdateTimer.GetValue() != 30.0)
				Scanner.UpdateTimer.SetValue(30.0)
				self.SetSliderOptionValue(option, 30.0, "$slif_scanner_seconds")
				self.ForcePageReset()
			endIf
		elseIf (option == self.OID_scanner_range)
			SLIF_Scanner Scanner = Game.GetFormFromFile(0x801, "SexLab Inflation Framework.esp") as SLIF_Scanner
			if (Scanner.pScannerRange.GetValue() != 2048.0)
				Scanner.pScannerRange.SetValue(2048.0)
				self.SetSliderOptionValue(option, 2048.0, "$slif_scanner_units")
				self.ForcePageReset()
			endIf
		endIf
	
	endIf
EndEvent

Event OnOptionHighlight(int option)
	
	if (self.CurrentPage == "$Config" || self.CurrentPage == "$Values_and_sliders")
		
		if (self.CurrentPage == "$Config")
			
			If (option == self.OID_gender)
				self.SetInfoText("$slif_gender_info")
			elseIf (option == self.OID_inflation_type)
				int inflation_type = SLIF_Config.GetInflationType(self.CurrentMod, 1)
				if (inflation_type == 0)
					self.SetInfoText("$slif_incremental_info")
				elseIf (inflation_type == 1)
					self.SetInfoText("$slif_instant_info")
				endIf
			elseIf (option == self.OID_calculation_type)
				int calculation_type = SLIF_Config.GetInt("calculation_type")
				if (calculation_type == 0)
					self.SetInfoText("$slif_top_x_info")
				elseIf (calculation_type == 1)
					self.SetInfoText("$slif_highest_wins_info")
				elseIf (calculation_type == 2)
					self.SetInfoText("$slif_substract_one_info")
				elseIf (calculation_type == 3)
					self.SetInfoText("$slif_square_root_info")
				elseIf (calculation_type == 4)
					self.SetInfoText("$slif_average_info")
				elseIf (calculation_type == 5)
					self.SetInfoText("$slif_additive_info")
				endIf
			elseIf (option == self.OID_sort_type)
				self.SetInfoText("$slif_sort_types_info")
			elseIf (option == self.OID_top_x)
				self.SetInfoText("$slif_top_x_info")
			elseIf (option == self.OID_sort_actor_list)
				self.SetInfoText("$slif_sort_actor_list_info")
			elseIf (option == self.OID_languages)
				self.SetInfoText("$slif_language_info")
			elseIf (option == self.OID_move_npc_to_player)
				self.SetInfoText("$slif_move_npc_to_player_info")
			elseIf (option == self.OID_move_player_to_npc)
				self.SetInfoText("$slif_move_player_to_npc_info")
			endIf
			
		elseIf (self.CurrentPage == "$Values_and_sliders")
			
		endIf
		
		if (option == self.OID_modus)
			self.SetInfoText("$slif_current_modus_info")
		elseIf (option == self.OID_category)
			self.SetInfoText("$CategoryInfo")
		elseIf (option == self.OID_actors)
			self.SetInfoText("$slif_current_actor_info")
		elseIf (option == self.OID_actor_list)
			self.SetInfoText("$slif_actor_list_info")
		elseIf (option == self.OID_mods)
			self.SetInfoText("$slif_current_mod_info")
		elseIf (option == self.OID_mod_list)
			self.SetInfoText("$slif_mod_list_info")
		elseIf (option == self.OID_register_player)
			self.SetInfoText("$slif_register_player_info")
		elseIf (option == self.OID_action_type)
			self.SetInfoText("$slif_action_type_info")
		elseIf (option == self.OID_current_value)
			self.SetInfoText("$slif_current_value_info")
		elseIf (option == self.OID_uninstall_mod)
			if (SLIF_Main.IsInstalled())
				self.SetInfoText("$slif_uninstall_mod_info")
			else
				self.SetInfoText("$slif_install_mod_info")
			endIf
		endIf
		
	elseIf (self.CurrentPage == "$Toggles")
		
		if (option == self.OID_notification)
			self.SetInfoText("$slif_notification_info")
		elseIf (option == self.OID_debug)
			self.SetInfoText("$slif_debug_info")
		elseIf (option == self.OID_hidden)
			self.SetInfoText("$slif_hidden_info")
		elseIf (option == self.OID_auto_register_slif)
			self.SetInfoText("$slif_auto_register_info")
		elseIf (option == self.OID_auto_register_slif_player)
			self.SetInfoText("$slif_auto_register_player_info")
		elseIf (option == self.OID_morph_auto_register_slif)
			self.SetInfoText("$slif_auto_register_info")
		elseIf (option == self.OID_morph_auto_register_slif_player)
			self.SetInfoText("$slif_auto_register_player_info")
		elseIf (option == self.OID_non_unique_npcs_use_nio)
			self.SetInfoText("$slif_non_unique_npcs_use_nio_info")
		elseIf (option == self.OID_inflate_on_menu_exit)
			self.SetInfoText("$slif_inflate_on_menu_exit_info")
		elseIf (option == self.OID_treat_trans_as_male)
			self.SetInfoText("$slif_treat_trans_as_male_info")
		elseIf (option == self.OID_treat_male_as_female)
			self.SetInfoText("$slif_treat_male_as_female_info")
		endIf
		
	elseIf (self.CurrentPage == "$Bodymorphs")
		
		SLIF_Menu_Bodymorphs.OnOptionHighlight(self, option)
		
	elseIf (self.CurrentPage == "$Presets")
		
		SLIF_Menu_Preset.OnOptionHighlight(self, option)
		
	elseIf (self.CurrentPage == "$Queue")
		
		if (option == self.OID_actors)
			self.SetInfoText("$slif_current_actor_info")
		elseIf (option == self.OID_actor_list)
			self.SetInfoText("$slif_actor_list_info")
		elseIf (option == self.OID_mods)
			self.SetInfoText("$slif_current_mod_info")
		elseIf (option == self.OID_mod_list)
			self.SetInfoText("$slif_mod_list_info")
		endIf
		
	elseIf (self.CurrentPage == "$Scanner")
		
		if (option == self.OID_scanner_active)
			self.SetInfoText("$slif_scanner_active_info")
		elseIf (option == self.OID_scanner_on_load)
			self.SetInfoText("$slif_scanner_on_load_info")
		elseIf (option == self.OID_scanner_over_time)
			self.SetInfoText("$slif_scanner_over_time_info")
		elseIf (option == self.OID_scanner_on_sleep)
			self.SetInfoText("$slif_scanner_on_sleep_info")
		elseIf (option == self.OID_scanner_purge_dead)
			self.SetInfoText("$slif_scanner_purge_dead_info")
		elseIf (option == self.OID_scanner_update_actors)
			self.SetInfoText("$slif_scanner_update_actors_info")
		elseIf (option == self.OID_update_interval)
			self.SetInfoText("$slif_scanner_interval_info")
		elseIf (option == self.OID_scanner_range)
			self.SetInfoText("$slif_scanner_range_info")
		endIf
		
	elseIf (self.CurrentPage == "$Mod_Extras")
		
		if (option == self.OID_timer_active)
			self.SetInfoText("$slif_timer_active_info")
		elseIf (option == self.OID_inflate_scrotum_update)
			self.SetInfoText("$slif_inflate_scrotum_update_info")
		elseIf (option == self.OID_inflate_scrotum)
			self.SetInfoText("$slif_inflate_scrotum_info")
		elseIf (option == self.OID_deflate_scrotum)
			self.SetInfoText("$slif_deflate_scrotum_info")
		elseIf (option == self.OID_inflate_scrotum_min)
			self.SetInfoText("$slif_inflate_scrotum_min_info")
		elseIf (option == self.OID_inflate_scrotum_max)
			self.SetInfoText("$slif_inflate_scrotum_max_info")
		elseIf (option == self.OID_inflate_scrotum_absolute_max)
			self.SetInfoText("$slif_inflate_scrotum_absolute_max_info")
		endIf
		
	endIf
	
EndEvent

Function executeInflationQueue()
	StorageUtil.UnsetIntValue(self, "slif_queue_actor")
	StorageUtil.UnsetIntValue(self, "slif_queue_actor_list")
	StorageUtil.StringListClear(self, "slif_inflate_on_menu_exit_names")
	while(StorageUtil.FormListCount(self, "slif_inflate_on_menu_exit_actors") > 0)
		Actor kActor = StorageUtil.FormListShift(self, "slif_inflate_on_menu_exit_actors") as Actor
		StorageUtil.UnsetIntValue(kActor, "slif_queue_mod")
		StorageUtil.UnsetIntValue(kActor, "slif_queue_mod_list")
		while(StorageUtil.StringListCount(kActor, "slif_inflate_on_menu_exit_mods") > 0)
			String mod = StorageUtil.StringListShift(kActor, "slif_inflate_on_menu_exit_mods")
			String[] nodes = StorageUtil.StringListToArray(kActor, "slif_inflate_on_menu_exit_keys" + mod)
			Float[] values = StorageUtil.FloatListToArray(kActor, "slif_inflate_on_menu_exit_values" + mod)
			int i = 0
			while(i < nodes.length)
				String node = nodes[i]
				float value = values[i]
				if (SLIF_Util.HasListEntry("morph_lists", "000_morphs", node))
					SLIF_Morph.morph(kActor, mod, node, value)
				else
					SLIF_Main.inflate(kActor, mod, node, value)
				endIf
				i += 1
			endWhile
			StorageUtil.StringListClear(kActor, "slif_inflate_on_menu_exit_keys" + mod)
			StorageUtil.FloatListClear(kActor, "slif_inflate_on_menu_exit_values" + mod)
		endWhile
	endWhile
EndFunction

Event OnConfigClose()
	StorageUtil.UnsetIntValue(self, "slif_in_menu")
	SLIF_Util.SaveJson(self.config_json)
	SLIF_Util.SaveJson(self.presets_json)
	executeInflationQueue()
EndEvent
;/
bool Function updateAddModKeyPreset(String file, String mod, String sKey, int index, bool changed)
	float inflation_type_default = SLIF_Util.GetInflationTypeDefault()
	float minimum_default        = SLIF_Util.GetMinimumDefault()
	float maximum_default        = SLIF_Util.GetMaximumDefault()
	float multiplier_default     = SLIF_Util.GetMultiplierDefault()
	float increment_default      = SLIF_Util.GetIncrementDefault()
	float inflation_type         = JsonUtil.FloatListGet(file, mod, index)
	float minimum                = JsonUtil.FloatListGet(file, mod, index + 1)
	float maximum                = JsonUtil.FloatListGet(file, mod, index + 2)
	float multiplier             = JsonUtil.FloatListGet(file, mod, index + 3)
	float increment              = JsonUtil.FloatListGet(file, mod, index + 4)
	if (inflation_type != inflation_type_default || minimum != minimum_default || maximum != maximum_default || multiplier != multiplier_default || increment != increment_default)
		float[] values = new float[5]
		values[0] = inflation_type
		values[1] = minimum
		values[2] = maximum
		values[3] = multiplier
		values[4] = increment
		StorageUtil.StringListAdd(none, "slif_update_mod_list", mod + "." + sKey)
		StorageUtil.FloatListCopy(none, mod + "." + sKey, values)
		changed = true
	endIf
	return changed
EndFunction
/;
Function RemoveNodeFromActorByMod(Actor kActor, String modName, String node)
	StorageUtil.UnsetFloatValue(kActor, modName + node)
	StorageUtil.StringListRemove(kActor, "slif_node_list", node)
	StorageUtil.StringListRemove(none, modName + "slif_node_list", node)
EndFunction

Function RemoveKeyFromActorByMod(Actor kActor, String modName, String sKey)
	StorageUtil.UnsetFloatValue(kActor, modName + sKey)
	StorageUtil.UnsetFloatValue(kActor, modName + sKey + "_min")
	StorageUtil.UnsetFloatValue(kActor, modName + sKey + "_max")
	StorageUtil.UnsetFloatValue(kActor, modName + sKey + "_mult")
	StorageUtil.UnsetFloatValue(kActor, modName + sKey + "_increment")
	StorageUtil.UnsetIntValue(kActor, modName + sKey + "_hidden")
	StorageUtil.StringListRemove(none, modName + "slif_key_list", sKey)
EndFunction

Function RemoveKeyFromActor(Actor kActor, String sKey)
	StorageUtil.UnsetFloatValue(kActor, sKey + "_hidden")
	StorageUtil.UnsetIntValue(kActor, sKey + "_hidden")
	StorageUtil.UnsetFloatValue(kActor, "All Mods" + sKey)
	StorageUtil.StringListRemove(kActor, "slif_key_list", sKey)
	StorageUtil.FloatListClear( kActor, sKey + "_values")
	StorageUtil.StringListClear(kActor, sKey + "_values")
	StorageUtil.StringListClear(kActor, sKey + "slif_queue_mods")
	StorageUtil.FloatListClear(kActor, sKey + "slif_queue_old_values")
	StorageUtil.FloatListClear(kActor, sKey + "slif_queue_values")
	StorageUtil.FloatListClear(kActor, sKey + "slif_queue_original_differences")
	StorageUtil.FloatListClear(kActor, sKey + "slif_queue_differences")
	StorageUtil.UnsetIntValue(kActor, sKey + "slif_queue_started")
EndFunction

Function RemoveSyncKeyFromActor(Actor kActor, String syncKey)
	StorageUtil.StringListClear(kActor, syncKey + "slif_queue_mods")
	StorageUtil.FloatListClear(kActor, syncKey + "slif_queue_old_values")
	StorageUtil.FloatListClear(kActor, syncKey + "slif_queue_values")
	StorageUtil.FloatListClear(kActor, syncKey + "slif_queue_original_differences")
	StorageUtil.FloatListClear(kActor, syncKey + "slif_queue_differences")
	StorageUtil.UnsetIntValue(kActor, syncKey + "slif_queue_started")
EndFunction

Function AddMissingConfigBodyMorphArrays(String json)
	String[] paths = SLIF_Menu_Bodymorphs.GetBodyMorphPathTypes()
	int len = paths.length
	int idx = 0
	while(idx < len)
		AddMissingConfigArrays(json, paths[idx])
		idx += 1
	endWhile
EndFunction

Function AddMissingConfigArrays(String json, String path)
	String[] members  = JsonUtil.PathMembers(json, path)
	int idx = 0
	while(idx < members.length)
		String member = members[idx]
		if (json == self.nioverride_json)
			float default = SLIF_Util.GetDefaultValueNiOverride(member)
			String type = "NiOverride"
			if (!SLIF_Morphs.CanResolve(type, path, (member + "[0]")))
				Float[] arr = new Float[2]
				arr[0] = default
				arr[1] = default
				SLIF_Morphs.SetArray(type, path, member, arr)
			endIf
		else
			int reverse = SLIF_Util.GetPathReverse(json, path, member) as int
			String type = "BodyMorph"
			if (!SLIF_Morphs.CanResolve(type, path, (member + "[0]")))
				Float[] arr = Utility.CreateFloatArray(10)
				arr[2] = reverse
				arr[3] = reverse
				arr[4] = 10.0
				arr[5] = 10.0
				arr[8] = 20.0
				arr[9] = 20.0
				SLIF_Morphs.SetArray(type, path, member, arr)
			endIf
		endIf
		idx += 1
	endWhile
EndFunction

Int PapyrusUtilVersion = 0

Function maintenance()
	
	PapyrusUtilVersion = PapyrusUtil.GetVersion()
	
	if (PapyrusUtilVersion < 33)
		Debug.MessageBox("You are not using the correct version of PapyrusUtil, you need at least version 3.3, which is required!\nSexLab Framework 1.62 does not come with the newest version of PapyrusUtil.\nMake sure PapyrusUtil isn't overwritten by another mod and has the newest version, SexLab Inflation Framework won't update otherwise.")
		return
	endIf
	
	if (SLIF_Main.IsInMaintenance() == false)
		StorageUtil.SetIntValue(none, "slif_maintenance", 1)
		float start = Utility.GetCurrentRealTime()
		SLIF_Debug.Trace("[SLIF_Menu] Doing Maintenance")
		
		self.presets_json = "SexLab Inflation Framework/Presets.json"
		
		Reload()
		
		String slif     = "SL Inflation Framework"
		String all_mods = "All Mods"
		
		if (StorageUtil.FormListCount(none, "slif_actor_list") == 0)
			StorageUtil.SetIntValue(PlayerRef, "slif_gender", PlayerRef.GetLeveledActorBase().GetSex())
			SLIF_Main.registerActor(PlayerRef, slif)
			self.SetCurrentActor(PlayerRef)
		else
			if (!self.CurrentActor)
				self.SetCurrentActor(StorageUtil.FormListGet( none, "slif_actor_list", 0) as Actor)
			endIf
		endIf
		
		int actor_count    = StorageUtil.FormListCount(  none, "slif_actor_list")
		int name_count     = StorageUtil.StringListCount(none, "slif_actor_name_list")
		bool rename_actors = false
		if (actor_count != name_count)
			StorageUtil.StringListClear(none, "slif_actor_name_list")
			rename_actors = true
		endIf
		int i = 0
		while (i < actor_count)
			Actor kActor = StorageUtil.FormListGet(none, "slif_actor_list", i) as Actor
			if (kActor)
				String name = kActor.GetLeveledActorBase().GetName()
				if (StorageUtil.StringListHas(   kActor, "slif_mod_list", ""))
					StorageUtil.StringListRemove(kActor, "slif_mod_list", "")
				endIf
				if (rename_actors)
					StorageUtil.StringListAdd(none, "slif_actor_name_list", name)
				elseIf (StorageUtil.StringListGet(none, "slif_actor_name_list", i) == "")
					StorageUtil.StringListSet(none, "slif_actor_name_list", i, name)
				endIf
				
				StorageUtil.SetIntValue(kActor, "slif_mod_list_count", (StorageUtil.StringListCount(kActor, "slif_mod_list") / 128 + 1))
			endIf
			i += 1
		endWhile
		
		StorageUtil.SetIntValue(none, "slif_actor_name_list_count", (StorageUtil.StringListCount(none, "slif_actor_name_list") / 128 + 1))
		
		if (CurrentVersion <= 104)
			
			if (JsonUtil.PathCount(self.presets_json, "floatList") > 0)
				JsonUtil.ClearAll(self.presets_json)
				SLIF_Util.SaveJson(self.presets_json)
			endIf
			
			bool changed = false
			int count = StorageUtil.StringListCount(none, "slif_mod_list")
			int j = 0
			while(j < count)
				String mod = StorageUtil.StringListGet(none, "slif_mod_list", j)
				if (!SLIF_Config.HasMod(mod))
					SLIF_Util.AddModSorted(mod)
					changed = true
				endIf
				j += 1
			endWhile
			StorageUtil.StringListClear(none, "slif_mod_list")
			StorageUtil.UnsetIntValue(none, "slif_mod_list_count")
			if (changed)
				SLIF_Util.SaveJson(self.config_json)
			endIf
		endIf
		
		bool changed = false
		
		if (JsonUtil.PathCount(self.bodymorphs_json, ".") <= 0)
			
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".breasts.Breasts.reverse", "true")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".breasts.BreastsSmall.reverse", "true")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".breasts.BreastsSH.reverse", "false")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".breasts.BreastsSSH.reverse", "false")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".breasts.BreastGravity.reverse", "false")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".breasts.BreastFlatness.reverse", "false")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".breasts.NipplePerkiness.reverse", "false")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".breasts.NippleLength.reverse", "false")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".breasts.NippleSize.reverse", "true")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".breasts.NippleAreola.reverse", "false")
			
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".belly.Belly.reverse", "false")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".belly.BigBelly.reverse", "false")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".belly.PregnancyBelly.reverse", "false")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".belly.AppleCheeks.reverse", "false")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".belly.BigButt.reverse", "false")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".belly.Butt.reverse", "false")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".belly.ButtSmall.reverse", "false")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".belly.ChubbyButt.reverse", "false")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".belly.Waist.reverse", "false")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".belly.WideWaistLine.reverse", "false")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".belly.ChubbyWaist.reverse", "false")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".belly.Hips.reverse", "false")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".belly.HipBone.reverse", "false")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".belly.Thighs.reverse", "false")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".belly.SlimThighs.reverse", "true")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".belly.Legs.reverse", "true")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".belly.ChubbyLegs.reverse", "false")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".belly.CalfSize.reverse", "false")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".belly.CalfSmooth.reverse", "false")
			
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".butt.AppleCheeks.reverse", "false")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".butt.BigButt.reverse", "false")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".butt.Butt.reverse", "false")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".butt.ButtSmall.reverse", "false")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".butt.ChubbyButt.reverse", "false")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".butt.Waist.reverse", "false")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".butt.WideWaistLine.reverse", "false")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".butt.ChubbyWaist.reverse", "false")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".butt.Hips.reverse", "false")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".butt.HipBone.reverse", "false")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".butt.Thighs.reverse", "false")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".butt.SlimThighs.reverse", "true")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".butt.Legs.reverse", "true")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".butt.ChubbyLegs.reverse", "false")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".butt.CalfSize.reverse", "false")
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".butt.CalfSmooth.reverse", "false")
			
			changed = true
		endIf
		
		if (JsonUtil.PathCount(self.bodymorphs_json, ".breasts.BreastPerkiness.") <= 0)
			JsonUtil.SetPathStringValue(self.bodymorphs_json, ".breasts.BreastPerkiness.reverse", "false")
			changed = true
		endIf
		
		if (changed)
			SLIF_Util.SaveJson(self.bodymorphs_json)
		endIf
		
		changed = false
		
		String[] arr = new String[1]
		if (JsonUtil.PathCount(self.nioverride_json, ".") <= 0)
			arr[0] = "NPC Belly"
			JsonUtil.SetPathStringArray(self.nioverride_json, ".belly.NiOverride.nodes", arr)
			
			arr = new String[2]
			arr[0] = "NPC L Butt"
			arr[1] = "NPC R Butt"
			JsonUtil.SetPathStringArray(self.nioverride_json, ".butt.NiOverride.nodes", arr)
			
			arr[0] = "NPC L Breast"
			arr[1] = "NPC R Breast"
			JsonUtil.SetPathStringArray(self.nioverride_json, ".breasts.NiOverride.nodes", arr)
			
			arr[0] = "NPC L Breast01"
			arr[1] = "NPC R Breast01"
			JsonUtil.SetPathStringArray(self.nioverride_json, ".breasts.Breasts01.nodes", arr)
			
			arr[0] = "NPC L Breast P1"
			arr[1] = "NPC R Breast P1"
			JsonUtil.SetPathStringArray(self.nioverride_json, ".breasts.BreastsP1.nodes", arr)
			
			arr[0] = "NPC L Breast P2"
			arr[1] = "NPC R Breast P2"
			JsonUtil.SetPathStringArray(self.nioverride_json, ".breasts.BreastsP2.nodes", arr)
			
			arr[0] = "NPC L Breast P3"
			arr[1] = "NPC R Breast P3"
			JsonUtil.SetPathStringArray(self.nioverride_json, ".breasts.BreastsP3.nodes", arr)
			
			arr[0] = "NPC L PreBreast"
			arr[1] = "NPC R PreBreast"
			JsonUtil.SetPathStringArray(self.nioverride_json, ".breasts.PreBreasts.nodes", arr)
			
			changed = true
		endIf
		
		arr = new String[1]
		arr[0] = "Breast"
		changed = SetPathStringArray(self.nioverride_json, ".breasts.Breast.nodes", arr, changed)
		
		arr = new String[2]
		arr[0] = "CME L Breast"
		arr[1] = "CME R Breast"
		changed = SetPathStringArray(self.nioverride_json, ".breasts.BreastsCME.nodes", arr, changed)
		
		arr[0] = "CME L PreBreast"
		arr[1] = "CME R PreBreast"
		changed = SetPathStringArray(self.nioverride_json, ".breasts.PreBreastsCME.nodes", arr, changed)
		
		arr[0] = "CME L PreBreastRoot"
		arr[1] = "CME R PreBreastRoot"
		changed = SetPathStringArray(self.nioverride_json, ".breasts.PreBreastRootsCME.nodes", arr, changed)
		
		if (changed)
			SLIF_Util.SaveJson(self.nioverride_json)
		endIf
		
		if (SLIF_Config.GetPathInt(".scanner", ".active") as bool)
			StartScanner()
		else
			StopScanner()
		endIf
		if (StorageUtil.GetIntValue(none, "slif_timer_active") as bool)
			StartTimer()
		else
			StopTimer()
		endIf
		
		AddMissingConfigBodyMorphArrays(self.bodymorphs_json)
		AddMissingConfigBodyMorphArrays(self.nioverride_json)
		
		int size1 = JsonUtil.StringListCount(config_json, "mod_list")
		int size2 = JsonUtil.StringListCount(modlist_json, "mod_list")
		if (size1 > 0 && size2 == 0)
			int c = 0
			while(c < size1)
				String mod = JsonUtil.StringListGet(config_json, "mod_list", c)
				JsonUtil.StringListAdd(modlist_json, "mod_list", mod, false)
				c += 1
			endWhile
		endIf
		
		int actorCount = StorageUtil.FormListCount(none, "slif_actor_list")
			i = 0
		while (i < actorCount)
			Actor kActor = StorageUtil.FormListGet(none, "slif_actor_list", i) as Actor
			SLIF_Util.AddModSorted(all_mods, kActor)
			i += 1
		endWhile
		
		String[] files = JsonUtil.JsonInFolder("SexLab Inflation Framework/")
		int f = 0
		bool has_preset_file = false
		bool has_lists_file = false
		while(f < files.length && has_preset_file == false && has_lists_file == false)
			if (files[f] == "Presets.json")
				has_preset_file = true
			elseIf (files[f] == "Lists.json")
				has_lists_file = true
			endIf
			f += 1
		endWhile
		if (has_preset_file)
			bool has_records = false
			int count = JsonUtil.PathCount(self.presets_json, ".")
			if (count > 0)
				String[] members = JsonUtil.PathMembers(self.presets_json, ".")
				StorageUtil.StringListCopy(self, "slif_temp_presets_members_array", members)
				i = 0
				while(i < count)
					String member = members[i]
					String[] keys = JsonUtil.PathMembers(self.presets_json, "." + member + ".")
					StorageUtil.StringListCopy(self, "slif_temp_presets_keys_array_" + member, keys)
					int j = 0
					while(j < keys.length)
						String sKey = keys[j]
						if (SLIF_Util.FindListEntry("stringList", "convert_keys", sKey) != -1)
							if (JsonUtil.CanResolvePath(self.presets_json, "." + member + "." + sKey))
								float[] values = JsonUtil.PathFloatElements(self.presets_json, "." + member + "." + sKey)
								StorageUtil.FloatListCopy(self, "slif_temp_presets_values_array_" + member + "_" + sKey, values)
								has_records = true
							endIf
						endIf
						j += 1
					endWhile
					i += 1
				endWhile
			endIf
			if (has_records)
				JsonUtil.ClearAll(self.presets_json)
				
				String[] members = StorageUtil.StringListToArray(self, "slif_temp_presets_members_array")
				StorageUtil.StringListClear(self, "slif_temp_presets_members_array")
				i = 0
				while(i < count)
					String member = members[i]
					String[] keys = StorageUtil.StringListToArray(self, "slif_temp_presets_keys_array_" + member)
					StorageUtil.StringListClear(self, "slif_temp_presets_keys_array_" + member)
					int j = 0
					while(j < keys.length)
						String sKey = keys[j]
						if (StorageUtil.FloatListCount(self, "slif_temp_presets_values_array_" + member + "_" + sKey) > 0)
							float[] values = StorageUtil.FloatListToArray(self, "slif_temp_presets_values_array_" + member + "_" + sKey)
							StorageUtil.FloatListClear(self, "slif_temp_presets_values_array_" + member + "_" + sKey)
							String node = SLIF_Util.GetListEntry("stringList", "convert_nodes", SLIF_Util.FindListEntry("stringList", "convert_keys", sKey))
							node = SLIF_Util.SplitAndJoinString(node, "[", "(")
							node = SLIF_Util.SplitAndJoinString(node, "]", ")")
							JsonUtil.SetPathFloatArray(self.presets_json, "." + member + "." + node, values)
						endIf
						j += 1
					endWhile
					i += 1
				endWhile
				
				SLIF_Util.SaveJson(self.presets_json)
			endIf
		endIf
		
		if (CurrentVersion <= 120 || has_lists_file == false)
			GenerateListsFile(has_lists_file)
		endIf
		
		float end = Utility.GetCurrentRealTime()
		SLIF_Debug.Trace("[SLIF_Menu] Doing Maintenance Done, time_diff: " + (end - start))
		StorageUtil.UnsetIntValue(none, "slif_maintenance")
	endIf
	
EndFunction

Bool Function SetPathStringArray(String file, String path, String[] arr, bool changed)
	if (!JsonUtil.CanResolvePath(file, path))
		JsonUtil.SetPathStringArray(file, path, arr)
		return true
	endIf
	return changed
EndFunction

Function update()
	
	maintenance()
	
	if (PapyrusUtilVersion < 33)
		return
	endIf
	
	String slif     = "SL Inflation Framework"
	String all_mods = "All Mods"
	SLIF_Scanner Scanner = Game.GetFormFromFile(0x801, "SexLab Inflation Framework.esp") as SLIF_Scanner
	SLIF_Timer Timer = Game.GetFormFromFile(0x801, "SexLab Inflation Framework.esp") as SLIF_Timer
	
	if (CurrentVersion != 0)
		
		if (CurrentVersion <= 13)
			StorageUtil.StringListClear(none, "slif_actor_name_list_list")
		endIf
		
		if (CurrentVersion <= 14)
			StorageUtil.StringListClear(none, "slif_translation_list")
		endIf
		
		if (CurrentVersion <= 17)
			int actorCount = StorageUtil.FormListCount(none, "slif_actor_list")
			int i = 0
			while (i < actorCount)
				Actor kActor = StorageUtil.FormListGet(none, "slif_actor_list", i) as Actor
				if (CurrentVersion <= 12)
					int modCount = SLIF_Config.ModCount()
					if (modCount > 2)
						int j = 2
						while (j < modCount)
							String mod = SLIF_Config.GetMod(j)
							if (SLIF_Main.IsRegistered(kActor, mod))
								StorageUtil.StringListAdd(kActor, "slif_mod_list", mod)
							endIf
							j+=1
						endWhile
						StorageUtil.StringListSort(kActor, "slif_mod_list")
						if (!StorageUtil.StringListInsert(kActor, "slif_mod_list", 0, all_mods))
							StorageUtil.StringListAdd(kActor, "slif_mod_list", all_mods)
							StorageUtil.StringListAdd(kActor, "slif_mod_list", slif)
						else
							if (!StorageUtil.StringListInsert(kActor, "slif_mod_list", 1, slif))
								StorageUtil.StringListAdd(kActor, "slif_mod_list", slif)
							endIf
						endIf
					else
						StorageUtil.StringListAdd(kActor, "slif_mod_list", all_mods)
						StorageUtil.StringListAdd(kActor, "slif_mod_list", slif)
					endIf
				endIf
				if (CurrentVersion <= 13)
					StorageUtil.StringListClear(kActor, "slif_mod_list_list")
				endIf
				i+=1
			endWhile
		endIf
		
		if (CurrentVersion <= 11)
			bool modified = false
			if (StorageUtil.HasIntValue(none, "slif_notification"))
				int value = StorageUtil.GetIntValue(none, "slif_notification")
				StorageUtil.UnsetIntValue(none, "slif_notification")
				if (SLIF_Config.HasInt("show_notifications") == false)
					SLIF_Config.SetInt("show_notifications", value)
					modified = true
				endIf
			endIf
			if (StorageUtil.HasIntValue(none, "slif_debug"))
				int value = StorageUtil.GetIntValue(none, "slif_debug")
				StorageUtil.UnsetIntValue(none, "slif_debug")
				if (SLIF_Config.HasInt("show_debug_messages") == false)
					SLIF_Config.SetInt("show_debug_messages", value)
					modified = true
				endIf
			endIf
			if (StorageUtil.HasIntValue(none, "slif_hidden"))
				int value = StorageUtil.GetIntValue(none, "slif_hidden")
				StorageUtil.UnsetIntValue(none, "slif_hidden")
				if (SLIF_Config.HasInt("show_hidden_values") == false)
					SLIF_Config.SetInt("show_hidden_values", value)
					modified = true
				endIf
			endIf
			if (StorageUtil.HasIntValue(none, "slif_inflation_type"))
				int value = StorageUtil.GetIntValue(none, "slif_inflation_type")
				StorageUtil.UnsetIntValue(none, "slif_inflation_type")
			endIf
			if (StorageUtil.HasIntValue(none, "slif_inflation_type_backup"))
				StorageUtil.UnsetIntValue(none, "slif_inflation_type_backup")
			endIf
			if (StorageUtil.HasIntValue(none, "slif_calculation_type"))
				int value = StorageUtil.GetIntValue(none, "slif_calculation_type")
				StorageUtil.UnsetIntValue(none, "slif_calculation_type")
				if (SLIF_Config.HasInt("calculation_type") == false)
					SLIF_Config.SetInt("calculation_type", value)
					modified = true
				endIf
			endIf
			if (StorageUtil.HasIntValue(none, "slif_top_x"))
				int value = StorageUtil.GetIntValue(none, "slif_top_x")
				StorageUtil.UnsetIntValue(none, "slif_top_x")
				if (SLIF_Config.HasInt("top_x") == false)
					SLIF_Config.SetInt("top_x", value)
					modified = true
				endIf
			endIf
			if (modified)
				SLIF_Util.SaveJson(self.config_json)
			endIf
			
			int actorListCount = StorageUtil.FormListCount( none, "slif_actor_list" )
			int actorNameListCount = StorageUtil.StringListCount( none, "slif_actor_name_list" )
			bool actorListZero = actorListCount == 0 && actorNameListCount >  0
			bool listsNotEqual = actorListCount >  0 && actorNameListCount != actorListCount
			
			if (CurrentVersion <= 7)
				if (actorListZero || listsNotEqual)
					StorageUtil.StringListClear( none, "slif_actor_name_list" )
				endIf
			endIf
			
			if (CurrentVersion <= 10)
				if (StorageUtil.HasIntValue(none, "slif_scanner_initialized"))
					StorageUtil.UnsetIntValue(none, "slif_scanner_initialized")
				endIf
			endIf
			
			int i = 0
			
			while (i < actorListCount)
				Actor kActor = StorageUtil.FormListGet( none, "slif_actor_list", i ) as Actor
				
				if (kActor)
					
					String name = SLIF_Util.GetActorName(kActor)
					
					int gender = SLIF_Main.GetGender(kActor)
					
					if (CurrentVersion <= 10)
					
						int modListCount = StorageUtil.StringListCount( kActor, "slif_mod_list" )
					
						if (CurrentVersion <= 8)
						
							while (modListCount > 0)
								
								modListCount-=1
								
								String mod = StorageUtil.StringListGet( kActor, "slif_mod_list", modListCount)
								
								if (StorageUtil.HasFloatValue( kActor, mod + "slif_skirt02"))
									float value = StorageUtil.GetFloatValue( kActor, mod + "slif_skirt02")
									float value_min = StorageUtil.GetFloatValue( kActor, mod + "slif_skirt02" + "_min")
									float value_max = StorageUtil.GetFloatValue( kActor, mod + "slif_skirt02" + "_max")
									
									StorageUtil.SetFloatValue( kActor, mod + "slif_skirt_b_02", value)
									StorageUtil.SetFloatValue( kActor, mod + "slif_skirt_b_02" + "_min", value_min)
									StorageUtil.SetFloatValue( kActor, mod + "slif_skirt_b_02" + "_max", value_max)
									
									StorageUtil.UnsetFloatValue( kActor, mod + "slif_skirt02")
									StorageUtil.UnsetFloatValue( kActor, mod + "slif_skirt02" + "_min")
									StorageUtil.UnsetFloatValue( kActor, mod + "slif_skirt02" + "_max")
								endIf
								if (StorageUtil.HasFloatValue( kActor, mod + "slif_skirt03"))
									float value = StorageUtil.GetFloatValue( kActor, mod + "slif_skirt03")
									float value_min = StorageUtil.GetFloatValue( kActor, mod + "slif_skirt03" + "_min")
									float value_max = StorageUtil.GetFloatValue( kActor, mod + "slif_skirt03" + "_max")
									
									StorageUtil.SetFloatValue( kActor, mod + "slif_skirt_b_03", value)
									StorageUtil.SetFloatValue( kActor, mod + "slif_skirt_b_03" + "_min", value_min)
									StorageUtil.SetFloatValue( kActor, mod + "slif_skirt_b_03" + "_max", value_max)
									
									StorageUtil.UnsetFloatValue( kActor, mod + "slif_skirt03")
									StorageUtil.UnsetFloatValue( kActor, mod + "slif_skirt03" + "_min")
									StorageUtil.UnsetFloatValue( kActor, mod + "slif_skirt03" + "_max")
								endIf
								
							endWhile
						
						endIf
					
						int keyListCount = SLIF_Util.GetListSize("stringList", "convert_keys")
						
						while (keyListCount > 0)
							
							keyListCount-=1
							
							String sKey = SLIF_Util.GetListEntry("stringList", "convert_keys",  keyListCount)
							String node = SLIF_Util.GetListEntry("stringList", "convert_nodes", keyListCount)
							
							If (CurrentVersion <= 9)
								
								if (StorageUtil.HasFloatValue( kActor, all_mods + sKey + "_top_three"))
									;/
									Float top_x = StorageUtil.GetFloatValue( kActor, all_mods + sKey + "_top_three")
									StorageUtil.SetFloatValue( kActor, all_mods + sKey + "_top_x", top_x)
									/;
									StorageUtil.UnsetFloatValue( kActor, all_mods + sKey + "_top_three")
								endIf
							
							endIf							
							
							If (CurrentVersion <= 10)
								;/
								if (StorageUtil.HasFloatValue( kActor, all_mods + sKey + "_square_root") == false)
									StorageUtil.SetFloatValue( kActor, all_mods + sKey + "_square_root", 1.0)
								endIf
								/;
								modListCount = StorageUtil.StringListCount( kActor, "slif_mod_list" )
								
								while (modListCount > 2)
									
									modListCount-=1
									
									String mod = StorageUtil.StringListGet( kActor, "slif_mod_list", modListCount ) as String
									
									if (StorageUtil.HasFloatValue( kActor, mod + sKey ))
										if (StorageUtil.GetFloatValue( kActor, mod + sKey ) == 0.0)
											StorageUtil.UnsetFloatValue( kActor, mod + sKey )
											StorageUtil.UnsetFloatValue( kActor, mod + sKey + "_min" )
											StorageUtil.UnsetFloatValue( kActor, mod + sKey + "_max" )
										endIf
									endIf
									
								endWhile
								
							endIf
							
						endWhile
					
					endIf
					
					if (CurrentVersion <= 11)
						if (StorageUtil.HasIntValue(kActor, all_mods + "slif_initialize") == false)
							StorageUtil.SetIntValue(kActor, all_mods + "slif_initialize", 1)
						endIf
					endIf
					
					if (CurrentVersion <= 7)
						
						int keyListCount = SLIF_Util.GetListSize("stringList", "convert_keys")
						
						while (keyListCount > 0)
							
							keyListCount-=1
							
							String sKey = SLIF_Util.GetListEntry("stringList", "convert_keys",  keyListCount)
							String node = SLIF_Util.GetListEntry("stringList", "convert_nodes", keyListCount)
							
							int modListCount = StorageUtil.StringListCount( kActor, "slif_mod_list" )
							
							while (modListCount > 0)
								
								modListCount-=1
								
								String mod = StorageUtil.StringListGet( kActor, "slif_mod_list", modListCount ) as String
								
								if (CurrentVersion <= 6)
									String newMod = ""
									
									if (mod != "")
										
										if (mod == "$all_mods_")
											newMod = "All Mods"
										elseIf (mod == "$default_")
											newMod = "SL Inflation Framework"
										elseIf (mod == "$beeing_female_")
											newMod = "Beeing Female"
										elseIf (mod == "$fill_her_up_")
											newMod = "Fill Her Up"
										elseIf (mod == "$milk_mod_economy_")
											newMod = "Milk Mod Economy"
										elseIf (mod == "$sexlab_hormones_")
											newMod = "SexLab Hormones"
										endIf
										
										if (StorageUtil.HasFloatValue( kActor, mod + sKey))
										
											if ( mod != "$all_mods_" )
												float currentInflateValue    = StorageUtil.GetFloatValue( kActor, mod + sKey, 0.0)
												float currentInflateValueMin = StorageUtil.GetFloatValue( kActor, mod + sKey + "_min", 0.0)
												float currentInflateValueMax = StorageUtil.GetFloatValue( kActor, mod + sKey + "_max", 100.0)
												;/
												StorageUtil.SetFloatValue( kActor, newMod + sKey,          currentInflateValue )
												StorageUtil.SetFloatValue( kActor, newMod + sKey + "_min", currentInflateValueMin )
												StorageUtil.SetFloatValue( kActor, newMod + sKey + "_max", currentInflateValueMax )
												/;
												StorageUtil.UnsetFloatValue( kActor, mod + sKey )
												StorageUtil.UnsetFloatValue( kActor, mod + sKey + "_min" )
												StorageUtil.UnsetFloatValue( kActor, mod + sKey + "_max" )
											else
												float currentInflateValue = StorageUtil.GetFloatValue( kActor, mod + sKey, 1.0)
												;/
												if (currentInflateValue != 0.0)
													StorageUtil.SetFloatValue( kActor, newMod + sKey, currentInflateValue )
												else
													StorageUtil.SetFloatValue( kActor, newMod + sKey, 1.0 )
												endIf
												/;
												StorageUtil.UnsetFloatValue( kActor, mod + sKey )
											endIf
										
										endIf
										
										if (StorageUtil.HasIntValue( kActor, mod + "slif_initialize" ))
											StorageUtil.UnsetIntValue( kActor, mod + "slif_initialize" )
											StorageUtil.SetIntValue( kActor, newMod + "slif_initialize", 1 )
										endIf
										
										StorageUtil.StringListSet( kActor, "slif_mod_list", modListCount, newMod )
									endIf
									
								endIf
								
							endWhile
					
							if (listsNotEqual)
								StorageUtil.StringListAdd( none, "slif_actor_name_list", name )
							endIf
							
						endWhile
					endIf
					
				endIf
				
				i+=1
			endWhile
		endIf
		
		if (CurrentVersion <= 100)
			
			StorageUtil.IntListClear(none, "slif_oid_slider_list")
			StorageUtil.IntListClear(none, "slif_oid_slider_list_min")
			StorageUtil.IntListClear(none, "slif_oid_slider_list_max")
			StorageUtil.IntListClear(none, "slif_oid_slider_list_mult")
			StorageUtil.IntListClear(none, "slif_oid_slider_list_increment")
			
		endIf
		
		if (CurrentVersion <= 101)
			int active    = StorageUtil.GetIntValue(none, "slif_scanner_active")
			int on_load   = StorageUtil.GetIntValue(none, "slif_scanner_on_load")
			int over_time = StorageUtil.GetIntValue(none, "slif_scanner_over_time")
			int on_sleep  = StorageUtil.GetIntValue(none, "slif_scanner_on_sleep")
			SLIF_Config.SetPathInt(".scanner", ".active",    active)
			SLIF_Config.SetPathInt(".scanner", ".on_load",   on_load)
			SLIF_Config.SetPathInt(".scanner", ".over_time", over_time)
			SLIF_Config.SetPathInt(".scanner", ".on_sleep",  on_sleep)
			StorageUtil.UnsetIntValue(none, "slif_scanner_active")
			StorageUtil.UnsetIntValue(none, "slif_scanner_on_load")
			StorageUtil.UnsetIntValue(none, "slif_scanner_over_time")
			StorageUtil.UnsetIntValue(none, "slif_scanner_on_sleep")
			int actorCount = StorageUtil.FormListCount(none, "slif_actor_list")
			int i = 0
			while(i < actorCount)
				Actor kActor = StorageUtil.FormListGet(none, "slif_actor_list", i) as Actor
				StorageUtil.StringListClear(kActor, "slif_queue_keys")
				StorageUtil.UnsetIntValue(kActor, "slif_queue_started")
				int keyCount = SLIF_Util.GetListSize("stringList", "convert_keys")
				int j = 0
				while(j < keyCount)
					String sKey = SLIF_Util.GetListEntry("stringList", "convert_keys", j)
					String node = SLIF_Util.GetListEntry("stringList", "convert_nodes", j)
					StorageUtil.FloatListClear(kActor, sKey + "slif_queue_increments")
					StorageUtil.IntListClear(  kActor, sKey + "slif_queue_perspective")
					StorageUtil.IntListClear(  kActor, sKey + "slif_queue_inflation_type")
					if (SLIF_Util.GetSyncIndexFromNode(node) != -1)
						SLIF_Util.UnsetIntValueConditional(kActor, sKey + "slif_queue_started")
					endIf
					int modCount = StorageUtil.StringListCount(kActor, "slif_mod_list")
					int k = 1
					while(k < modCount)
						String mod = StorageUtil.StringListGet(kActor, "slif_mod_list", k)
						if (SLIF_Main.hasScale(kActor, mod, sKey))
							StorageUtil.UnsetFloatValue(kActor, all_mods + sKey + "_top_x")
							StorageUtil.UnsetFloatValue(kActor, all_mods + sKey + "_highest_wins")
							StorageUtil.UnsetFloatValue(kActor, all_mods + sKey + "_substract_one")
							StorageUtil.UnsetFloatValue(kActor, all_mods + sKey + "_square_root")
							StorageUtil.UnsetFloatValue(kActor, all_mods + sKey + "_average")
							StorageUtil.UnsetFloatValue(kActor, all_mods + sKey + "_additive")
						endIf
						k += 1
					endWhile
					j += 1
				endWhile
				i += 1
			endWhile
		endIf
		
		if (CurrentVersion <= 104)
			StorageUtil.StringListClear(none, "slif_node_list")
			StorageUtil.StringListClear(none, "slif_key_list")
			StorageUtil.StringListClear(none, "slif_dual_key_list")
			StorageUtil.UnsetFloatValue(none, "slif_valid_nioverride")
			
			StorageUtil.FormListClear(  none,   "slif_inflate_on_menu_exit")
			StorageUtil.StringListClear(none,   "slif_inflate_on_menu_exit")
			
			int actorCount = StorageUtil.FormListCount(none, "slif_actor_list")
			int i = 0
			while(i < actorCount)
				Actor kActor = StorageUtil.FormListGet(none, "slif_actor_list", i) as Actor
				
				StorageUtil.StringListClear(kActor, "slif_inflate_on_menu_exit")
				
				int keyCount = SLIF_Util.GetListSize("stringList", "convert_keys")
				int j = 0
				while(j < keyCount)
					String sKey = SLIF_Util.GetListEntry("stringList", "convert_keys", j)
					StorageUtil.FloatListClear(kActor, sKey + "slif_queue_old_values")
					StorageUtil.FloatListClear(kActor, sKey + "slif_queue_original_differences")
					StorageUtil.FloatListClear(kActor, sKey + "slif_queue_differences")
					j += 1
				endWhile
					keyCount = SLIF_Util.GetListSize("stringList", "sync_keys")
					j = 0
				while(j < keyCount)
					String syncKey = SLIF_Util.GetListEntry("stringList", "sync_keys", j)
					StorageUtil.FloatListClear(kActor, syncKey + "slif_queue_old_values")
					StorageUtil.FloatListClear(kActor, syncKey + "slif_queue_original_differences")
					StorageUtil.FloatListClear(kActor, syncKey + "slif_queue_differences")
					j += 1
				endWhile
				
				int modCount = SLIF_Config.ModCount()
				    j = 0
				while(j < modCount)
					String mod = SLIF_Config.GetMod(j)
					
					StorageUtil.StringListClear(kActor, "slif_inflate_on_menu_exit" + mod)
					StorageUtil.FloatListClear( kActor, "slif_inflate_on_menu_exit" + mod)
					
					StorageUtil.UnsetFloatValue(kActor, "SexLab Inflation Framework.esp" + "NPC L Breast01")
					StorageUtil.UnsetFloatValue(kActor, "SexLab Inflation Framework.esp" + "NPC R Breast01")
					StorageUtil.UnsetFloatValue(kActor, "SexLab Inflation Framework.esp" + "NPC L Breast P1")
					StorageUtil.UnsetFloatValue(kActor, "SexLab Inflation Framework.esp" + "NPC R Breast P1")
					StorageUtil.UnsetFloatValue(kActor, "SexLab Inflation Framework.esp" + "NPC L Breast P2")
					StorageUtil.UnsetFloatValue(kActor, "SexLab Inflation Framework.esp" + "NPC R Breast P2")
					StorageUtil.UnsetFloatValue(kActor, "SexLab Inflation Framework.esp" + "NPC L Breast P3")
					StorageUtil.UnsetFloatValue(kActor, "SexLab Inflation Framework.esp" + "NPC R Breast P3")
					StorageUtil.UnsetFloatValue(kActor, "SexLab Inflation Framework.esp" + "NPC L PreBreast")
					StorageUtil.UnsetFloatValue(kActor, "SexLab Inflation Framework.esp" + "NPC R PreBreast")
					
					RemoveNodeFromActorByMod(kActor, mod, "NPC L Breast01")
					RemoveNodeFromActorByMod(kActor, mod, "NPC R Breast01")
					RemoveNodeFromActorByMod(kActor, mod, "NPC L Breast P1")
					RemoveNodeFromActorByMod(kActor, mod, "NPC R Breast P1")
					RemoveNodeFromActorByMod(kActor, mod, "NPC L Breast P2")
					RemoveNodeFromActorByMod(kActor, mod, "NPC R Breast P2")
					RemoveNodeFromActorByMod(kActor, mod, "NPC L Breast P3")
					RemoveNodeFromActorByMod(kActor, mod, "NPC R Breast P3")
					RemoveNodeFromActorByMod(kActor, mod, "NPC L PreBreast")
					RemoveNodeFromActorByMod(kActor, mod, "NPC R PreBreast")
					
					RemoveKeyFromActorByMod(kActor, mod, "slif_left_breast01")
					RemoveKeyFromActorByMod(kActor, mod, "slif_right_breast01")
					RemoveKeyFromActorByMod(kActor, mod, "slif_left_breast_p1")
					RemoveKeyFromActorByMod(kActor, mod, "slif_right_breast_p1")
					RemoveKeyFromActorByMod(kActor, mod, "slif_left_breast_p2")
					RemoveKeyFromActorByMod(kActor, mod, "slif_right_breast_p2")
					RemoveKeyFromActorByMod(kActor, mod, "slif_left_breast_p3")
					RemoveKeyFromActorByMod(kActor, mod, "slif_right_breast_p3")
					RemoveKeyFromActorByMod(kActor, mod, "slif_left_prebreast")
					RemoveKeyFromActorByMod(kActor, mod, "slif_right_prebreast")
					
					j += 1
				endWhile
				
				RemoveKeyFromActor(kActor, "slif_left_breast01")
				RemoveKeyFromActor(kActor, "slif_right_breast01")
				RemoveKeyFromActor(kActor, "slif_left_breast_p1")
				RemoveKeyFromActor(kActor, "slif_right_breast_p1")
				RemoveKeyFromActor(kActor, "slif_left_breast_p2")
				RemoveKeyFromActor(kActor, "slif_right_breast_p2")
				RemoveKeyFromActor(kActor, "slif_left_breast_p3")
				RemoveKeyFromActor(kActor, "slif_right_breast_p3")
				RemoveKeyFromActor(kActor, "slif_left_prebreast")
				RemoveKeyFromActor(kActor, "slif_right_prebreast")
				
				RemoveSyncKeyFromActor(kActor, "slif_breast01")
				RemoveSyncKeyFromActor(kActor, "slif_breast_p1")
				RemoveSyncKeyFromActor(kActor, "slif_breast_p2")
				RemoveSyncKeyFromActor(kActor, "slif_breast_p3")
				RemoveSyncKeyFromActor(kActor, "slif_prebreast")
				
				i += 1
			endWhile
			
		endIf
		
		if (CurrentVersion <= 106)
			int actorCount = StorageUtil.FormListCount(none, "slif_actor_list")
			int i = 0
			while(i < actorCount)
				Actor kActor = StorageUtil.FormListGet(none, "slif_actor_list", i) as Actor
				int keyCount = SLIF_Util.GetListSize("stringList", "convert_keys")
				int j = 0
				while(j < keyCount)
					String sKey = SLIF_Util.GetListEntry("stringList", "convert_keys",  j)
					String node = SLIF_Util.GetListEntry("stringList", "convert_nodes", j)
					;/
					if (CurrentVersion <= 105)
						if (!StorageUtil.HasFloatValue(kActor, "All Mods" + sKey) && StorageUtil.HasFloatValue(kActor, "SexLab Inflation Framework.esp" + node))
							StorageUtil.UnsetFloatValue(kActor, "SexLab Inflation Framework.esp" + node)
						endIf
					endIf
					/;
					if (CurrentVersion <= 106)
						StorageUtil.FloatListClear( kActor, sKey + "_values")
						StorageUtil.StringListClear(kActor, sKey + "_values")
					endIf
					j += 1
				endWhile
				i += 1
			endWhile
		endIf
		
		if (CurrentVersion <= 107)
			StorageUtil.SetFloatValue(self, "slif_current_value", 0.0)
			;bool save = false
			int keyCount = SLIF_Util.GetListSize("stringList", "convert_keys")
			int i = 0
			while(i < keyCount)
				String sKey = SLIF_Util.GetListEntry("stringList", "convert_keys",  i)
				String node = SLIF_Util.GetListEntry("stringList", "convert_nodes", i)
				;/
				if (SLIF_Preset.FloatListGet("All Mods", "." + sKey, 0) != 1)
					SLIF_Preset.FloatListSet("All Mods", "." + sKey, 0, 1)
					save = true
				endIf
				/;
				int actorCount = StorageUtil.FormListCount(none, "slif_actor_list")
				int j = 0
				while(j < actorCount)
					Actor kActor     = StorageUtil.FormListGet(none, "slif_actor_list", j) as Actor
					String name      = SLIF_Util.GetActorName(kActor)
					String aToString = SLIF_Util.ActorToString(kActor, name)
					if (SLIF_Main.IsNodeHidden(kActor, node))
						float value = StorageUtil.GetFloatValue(kActor, node + "_hidden", 0.0000001)
						SLIF_Util.unregisterNode(kActor, aToString, node, "SL Inflation Framework")
						SLIF_Util.unregisterNode(kActor, aToString, node, "Amputator Framework")
						SLIF_Util.unregisterNode(kActor, aToString, node, "Devious Devices Integration")
						if (StorageUtil.GetFloatValue(kActor, "All Mods" + node, 1.0) == 0.0000001)
							StorageUtil.SetFloatValue(kActor, "All Mods" + node, 1.0)
						endIf
						SLIF_Main.hideNode(kActor, "SL Inflation Framework", node, value)
					endIf
					j += 1
				endWhile
				
				i += 1
			endWhile
			;/
			if (save)
				SLIF_Util.SaveJson(self.presets_json)
			endIf
			/;
		endIf
		
		if (CurrentVersion <= 109)
			int keyCount = SLIF_Util.GetListSize("stringList", "convert_keys")
			int i = 0
			while(i < keyCount)
				String sKey = SLIF_Util.GetListEntry("stringList", "convert_keys",  i)
				String node = SLIF_Util.GetListEntry("stringList", "convert_nodes", i)
				
				int actorCount = StorageUtil.FormListCount(none, "slif_actor_list")
				int j = 0
				while(j < actorCount)
					Actor kActor = StorageUtil.FormListGet(none, "slif_actor_list", j) as Actor
					if (!StorageUtil.HasFloatValue(kActor, "All Mods" + node))
						StorageUtil.UnsetFloatValue(kActor, "SexLab Inflation Framework.esp" + node)
					endIf
					
					if (StorageUtil.HasIntValue(kActor, sKey + "_hidden"))
						StorageUtil.SetIntValue(kActor, node + "_hidden", 1)
						StorageUtil.SetFloatValue(kActor, node + "_hidden", StorageUtil.GetFloatValue(kActor, sKey + "_hidden", 0.0000001))
					endIf
					
					int modCount = SLIF_Config.ModCount()
					int k = 0
					while(k < modCount)
						String mod = SLIF_Config.GetMod(k)
						if (StorageUtil.HasFloatValue(kActor, mod + sKey))
							StorageUtil.SetFloatValue(kActor, mod + node,                StorageUtil.GetFloatValue(kActor, mod + sKey,                0.0))
							StorageUtil.SetFloatValue(kActor, mod + node + "_min",       StorageUtil.GetFloatValue(kActor, mod + sKey + "_min",       0.0))
							StorageUtil.SetFloatValue(kActor, mod + node + "_max",       StorageUtil.GetFloatValue(kActor, mod + sKey + "_max",     100.0))
							StorageUtil.SetFloatValue(kActor, mod + node + "_mult",      StorageUtil.GetFloatValue(kActor, mod + sKey + "_mult",      1.0))
							StorageUtil.SetFloatValue(kActor, mod + node + "_increment", StorageUtil.GetFloatValue(kActor, mod + sKey + "_increment", 0.1))
						endIf
						k += 1
					endWhile
					
					j += 1
				endWhile
				
				i += 1
			endWhile
		endIf
		
		if (CurrentVersion <= 110)
			int modCount = SLIF_Config.ModCount()
			int j = 0
			while(j < modCount)
				String mod = SLIF_Config.GetMod(j)
				StorageUtil.UnsetIntValue(none, mod + "slif_modus_selection")
				StorageUtil.UnsetIntValue(none, mod + "slif_category_selection")
				j += 1
			endWhile
			int actorCount = StorageUtil.FormListCount(none, "slif_actor_list")
			int i = 0
			while(i < actorCount)
				Actor kActor = StorageUtil.FormListGet(none, "slif_actor_list", i) as Actor
				int keyCount = SLIF_Util.GetListSize("stringList", "convert_keys")
				int k = 0
				while(k < keyCount)
					String sKey = SLIF_Util.GetListEntry("stringList", "convert_keys",  k)
					String node = SLIF_Util.GetListEntry("stringList", "convert_nodes", k)
					SLIF_Calc.addCalculationType(kActor, node)
					k += 1
				endWhile
				i += 1
			endWhile
			
		endIf
		
		if (CurrentVersion <= 113)
			SLIF_Util.ChangeStorageForm(none, self, "int", "slif_bodymorph_selection")
;			SLIF_Util.ChangeStorageForm(none, self, "int", "slif_bodymorph_group")
			SLIF_Util.ChangeStorageForm(none, self, "int", "slif_actor_selection")
			SLIF_Util.ChangeStorageForm(none, self, "int", "slif_current_actor_list")
		endIf
		
		if (CurrentVersion <= 114)
			StorageUtil.UnsetIntValue(none, "slif_bodymorph_group")
			StorageUtil.UnsetIntValue(self, "slif_bodymorph_group")
		endIf
		
		if (CurrentVersion <= 115)
			StorageUtil.UnsetIntValue(Scanner, "slif_purging_actors")
		endIf
		
		if (CurrentVersion <= 116)
			if (Timer.IsStopped() == false)
				Timer.Stop()
			endIf
		endIf
		
		if (CurrentVersion <= 117)
			StorageUtil.UnsetIntValue(none, "slif_in_menu")
			StorageUtil.IntListClear(none, "slif_oid_list")
			
			int actorCount = StorageUtil.FormListCount(none, "slif_actor_list")
			int i = 0
			while(i < actorCount)
				Actor kActor = StorageUtil.FormListGet(none, "slif_actor_list", i) as Actor
				int modCount = SLIF_Config.ModCount()
				int j = 0
				while(j < modCount)
					String mod = SLIF_Config.GetMod(j)
					int keyCount = SLIF_Util.GetListSize("stringList", "convert_keys")
					int k = 0
					while(k < keyCount)
						String sKey = SLIF_Util.GetListEntry("stringList", "convert_keys",  k)
						String node = SLIF_Util.GetListEntry("stringList", "convert_nodes", k)
						if (StorageUtil.HasFloatValue(kActor, mod + sKey))
							StorageUtil.StringListAdd(kActor, mod + "slif_node_list", node, false)
						endIf
						k += 1
					endWhile
					StorageUtil.StringListClear(none, mod + "slif_key_list")
					StorageUtil.StringListClear(none, mod + "slif_node_list")
					j += 1
				endWhile
				StorageUtil.StringListClear(kActor, "slif_key_list")
				StorageUtil.StringListClear(kActor, "slif_node_list")
				i += 1
			endWhile
		endIf
		
		if (CurrentVersion <= 118)
			if (StorageUtil.GetIntValue(none, "slif_timer_active") as bool)
				Timer.RegisterForModEvent("SexLabOrgasmSeparate", "OnOrgasmSeparate")
			endIf
			SLIF_Util.ChangeStorageForm(none, self, "int", "slif_mod_selection")
			SLIF_Util.ChangeStorageForm(none, self, "int", "slif_current_mod_list")
			StorageUtil.UnsetFloatValue(none, "slif_inflate_scrotum_min")
			StorageUtil.UnsetFloatValue(none, "slif_inflate_scrotum_max")
			StorageUtil.UnsetFloatValue(none, "slif_inflate_scrotum_absolute_max")
			SLIF_Menu_Bodymorphs.ResetBodyMorphDefaultOptions(self, StorageUtil.GetIntValue(self, "slif_bodymorph_category"))
		endIf
		
		if (CurrentVersion <= 119)
			int modCount = SLIF_Config.ModCount()
			int i = 0
			while(i < modCount)
				String mod = SLIF_Config.GetMod(i)
				StorageUtil.UnsetIntValue(self, mod + "slif_modus_selection")
				StorageUtil.UnsetIntValue(self, mod + "slif_category_selection")
				int actorCount = StorageUtil.FormListCount(none, "slif_actor_list")
				int j = 0
				while(j < actorCount)
					Actor kActor = StorageUtil.FormListGet(none, "slif_actor_list", j) as Actor
					StorageUtil.FormListAdd(none, "slif_complete_actor_list", kActor, false)
					StorageUtil.UnsetIntValue(kActor, mod + "slif_modus_selection")
					StorageUtil.UnsetIntValue(kActor, mod + "slif_category_selection")
					j += 1
				endWhile
				i += 1
			endWhile
			StorageUtil.FormListSort(none, "slif_complete_actor_list")
			StorageUtil.UnsetFloatValue(self, "slif_current_preset_value")
		endIf
		
		if (CurrentVersion <= 120)
			int modCount = SLIF_Config.ModCount()
			int i = 0
			while(i < modCount)
				String mod = SLIF_Config.GetMod(i)
				int actorCount = StorageUtil.FormListCount(none, "slif_actor_list")
				int j = 0
				while(j < actorCount)
					Actor kActor = StorageUtil.FormListGet(none, "slif_actor_list", j) as Actor
					StorageUtil.StringListClear(kActor, mod + "slif_key_list")
					int listSize = SLIF_Util.GetListSize("stringList", "convert_keys")
					int k = 0
					while(k < listSize)
						String sKey = SLIF_Util.GetListEntry("stringList", "convert_keys", k)
						StorageUtil.UnsetFloatValue(kActor, mod + sKey)
						StorageUtil.UnsetFloatValue(kActor, mod + sKey + "_min")
						StorageUtil.UnsetFloatValue(kActor, mod + sKey + "_max")
						StorageUtil.UnsetFloatValue(kActor, mod + sKey + "_mult")
						StorageUtil.UnsetFloatValue(kActor, mod + sKey + "_increment")
						StorageUtil.UnsetIntValue(kActor, sKey + "_hidden")
						StorageUtil.UnsetFloatValue(kActor, sKey + "_hidden")
						StorageUtil.UnsetIntValue(kActor, sKey + "slif_queue_started")
						StorageUtil.StringListClear(kActor, sKey + "slif_queue_mods")
						StorageUtil.FloatListClear(kActor, sKey + "slif_queue_values")
						k += 1
					endWhile
					j += 1
				endWhile
				i += 1
			endWhile
			
		endIf
		
	endIf
	
EndFunction

Function GenerateListsFile(bool has_file)
	
	if (has_file)
		JsonUtil.ClearAll(lists_json)
	endIf
	
	arr = new String[25]
	arr[0] = "NPC L Breast01"
	arr[1] = "NPC R Breast01"
	arr[2] = "NPC L Breast P1"
	arr[3] = "NPC R Breast P1"
	arr[4] = "NPC L Breast P2"
	arr[5] = "NPC R Breast P2"
	arr[6] = "NPC L Breast P3"
	arr[7] = "NPC R Breast P3"
	arr[8] = "NPC L PreBreast"
	arr[9] = "NPC R PreBreast"
	arr[10] = "slif_left_breast01"
	arr[11] = "slif_right_breast01"
	arr[12] = "slif_left_breast_p1"
	arr[13] = "slif_right_breast_p1"
	arr[14] = "slif_left_breast_p2"
	arr[15] = "slif_right_breast_p2"
	arr[16] = "slif_left_breast_p3"
	arr[17] = "slif_right_breast_p3"
	arr[18] = "slif_left_prebreast"
	arr[19] = "slif_right_prebreast"
	arr[20] = "slif_breast01"
	arr[21] = "slif_breast_p1"
	arr[22] = "slif_breast_p2"
	arr[23] = "slif_breast_p3"
	arr[24] = "slif_prebreast"
	JsonUtil.StringListCopy(lists_json, "ignore_keys", arr)
	
	String[] arr = new String[15]
	arr[0] = "slif_breast"
	arr[1] = "slif_butt"
	arr[2] = "slif_scrotums"
	arr[3] = "slif_pussy01"
	arr[4] = "slif_pussy02"
	arr[5] = "slif_clavicle"
	arr[6] = "slif_upperarm"
	arr[7] = "slif_bicep_01"
	arr[8] = "slif_bicep_02"
	arr[9] = "slif_forearm"
	arr[10] = "slif_arm_flexor_01"
	arr[11] = "slif_hand"
	arr[12] = "slif_thigh"
	arr[13] = "slif_calf"
	arr[14] = "slif_foot"
	JsonUtil.StringListCopy(lists_json, "sync_keys", arr)
	
	arr = new String[15]
	arr[0] = "NPC L Breast"
	arr[1] = "NPC L Butt"
	arr[2] = "NPC L GenitalsScrotum [LGenScrot]"
	arr[3] = "NPC L Pussy01"
	arr[4] = "NPC L Pussy02"
	arr[5] = "NPC L Clavicle [LClv]"
	arr[6] = "NPC L UpperArm [LUar]"
	arr[7] = "NPC L UpperarmTwist1 [LUt1]"
	arr[8] = "NPC L UpperarmTwist2 [LUt2]"
	arr[9] = "NPC L Forearm [LLar]"
	arr[10] = "NPC L ForearmTwist1 [LLt1]"
	arr[11] = "NPC L Hand [LHnd]"
	arr[12] = "NPC L Thigh [LThg]"
	arr[13] = "NPC L Calf [LClf]"
	arr[14] = "NPC L Foot [Lft ]"
	JsonUtil.StringListCopy(lists_json, "left_nodes", arr)
	
	arr = new String[15]
	arr[0] = "NPC R Breast"
	arr[1] = "NPC R Butt"
	arr[2] = "NPC R GenitalsScrotum [RGenScrot]"
	arr[3] = "NPC R Pussy01"
	arr[4] = "NPC R Pussy02"
	arr[5] = "NPC R Clavicle [RClv]"
	arr[6] = "NPC R UpperArm [RUar]"
	arr[7] = "NPC R UpperarmTwist1 [RUt1]"
	arr[8] = "NPC R UpperarmTwist2 [RUt2]"
	arr[9] = "NPC R Forearm [RRar]"
	arr[10] = "NPC R ForearmTwist1 [RRt1]"
	arr[11] = "NPC R Hand [RHnd]"
	arr[12] = "NPC R Thigh [RThg]"
	arr[13] = "NPC R Calf [RClf]"
	arr[14] = "NPC R Foot [Rft ]"
	JsonUtil.StringListCopy(lists_json, "right_nodes", arr)
	
	arr = new String[59]
	arr[0] = "slif_left_breast"
	arr[1] = "slif_right_breast"
	arr[2] = "slif_left_butt"
	arr[3] = "slif_right_butt"
	arr[4] = "slif_belly"
	arr[5] = "slif_schlong"
	arr[6] = "slif_scrotum"
	arr[7] = "slif_left_scrotum"
	arr[8] = "slif_right_scrotum"
	arr[9] = "slif_genitals_01"
	arr[10] = "slif_genitals_02"
	arr[11] = "slif_genitals_03"
	arr[12] = "slif_genitals_04"
	arr[13] = "slif_genitals_05"
	arr[14] = "slif_genitals_06"
	arr[15] = "slif_left_pussy01"
	arr[16] = "slif_right_pussy01"
	arr[17] = "slif_left_pussy02"
	arr[18] = "slif_right_pussy02"
	arr[19] = "slif_left_clavicle"
	arr[20] = "slif_right_clavicle"
	arr[21] = "slif_pelvis"
	arr[22] = "slif_left_upperarm"
	arr[23] = "slif_right_upperarm"
	arr[24] = "slif_left_bicep_01"
	arr[25] = "slif_right_bicep_01"
	arr[26] = "slif_left_bicep_02"
	arr[27] = "slif_right_bicep_02"
	arr[28] = "slif_left_forearm"
	arr[29] = "slif_right_forearm"
	arr[30] = "slif_left_arm_flexor_01"
	arr[31] = "slif_right_arm_flexor_01"
	arr[32] = "slif_left_hand"
	arr[33] = "slif_right_hand"
	arr[34] = "slif_left_thigh"
	arr[35] = "slif_right_thigh"
	arr[36] = "slif_left_calf"
	arr[37] = "slif_right_calf"
	arr[38] = "slif_left_foot"
	arr[39] = "slif_right_foot"
	arr[40] = "slif_skirt_b_01"
	arr[41] = "slif_skirt_b_02"
	arr[42] = "slif_skirt_b_03"
	arr[43] = "slif_skirt_f_01"
	arr[44] = "slif_skirt_f_02"
	arr[45] = "slif_skirt_f_03"
	arr[46] = "slif_skirt_l_01"
	arr[47] = "slif_skirt_l_02"
	arr[48] = "slif_skirt_l_03"
	arr[49] = "slif_skirt_r_01"
	arr[50] = "slif_skirt_r_02"
	arr[51] = "slif_skirt_r_03"
	arr[52] = "slif_npc_size"
	arr[53] = "slif_npc_size_multiplier"
	arr[54] = "slif_spine"
	arr[55] = "slif_spine_01"
	arr[56] = "slif_spine_02"
	arr[57] = "slif_neck"
	arr[58] = "slif_head"
	JsonUtil.StringListCopy(lists_json, "convert_keys", arr)
	
	arr = new String[59]
	arr[0] = "NPC L Breast"
	arr[1] = "NPC R Breast"
	arr[2] = "NPC L Butt"
	arr[3] = "NPC R Butt"
	arr[4] = "NPC Belly"
	arr[5] = "NPC GenitalsBase [GenBase]"
	arr[6] = "NPC GenitalsScrotum [GenScrot]"
	arr[7] = "NPC L GenitalsScrotum [LGenScrot]"
	arr[8] = "NPC R GenitalsScrotum [RGenScrot]"
	arr[9] = "NPC Genitals01 [Gen01]"
	arr[10] = "NPC Genitals02 [Gen02]"
	arr[11] = "NPC Genitals03 [Gen03]"
	arr[12] = "NPC Genitals04 [Gen04]"
	arr[13] = "NPC Genitals05 [Gen05]"
	arr[14] = "NPC Genitals06 [Gen06]"
	arr[15] = "NPC L Pussy01"
	arr[16] = "NPC R Pussy01"
	arr[17] = "NPC L Pussy02"
	arr[18] = "NPC R Pussy02"
	arr[19] = "NPC L Clavicle [LClv]"
	arr[20] = "NPC R Clavicle [RClv]"
	arr[21] = "NPC Pelvis [Pelv]"
	arr[22] = "NPC L UpperArm [LUar]"
	arr[23] = "NPC R UpperArm [RUar]"
	arr[24] = "NPC L UpperarmTwist1 [LUt1]"
	arr[25] = "NPC R UpperarmTwist1 [RUt1]"
	arr[26] = "NPC L UpperarmTwist2 [LUt2]"
	arr[27] = "NPC R UpperarmTwist2 [RUt2]"
	arr[28] = "NPC L Forearm [LLar]"
	arr[29] = "NPC R Forearm [RLar]"
	arr[30] = "NPC L ForearmTwist1 [LLt1]"
	arr[31] = "NPC R ForearmTwist1 [RLt1]"
	arr[32] = "NPC L Hand [LHnd]"
	arr[33] = "NPC R Hand [RHnd]"
	arr[34] = "NPC L Thigh [LThg]"
	arr[35] = "NPC R Thigh [RThg]"
	arr[36] = "NPC L Calf [LClf]"
	arr[37] = "NPC R Calf [RClf]"
	arr[38] = "NPC L Foot [Lft ]"
	arr[39] = "NPC R Foot [Rft ]"
	arr[40] = "SkirtBBone01"
	arr[41] = "SkirtBBone02"
	arr[42] = "SkirtBBone03"
	arr[43] = "SkirtFBone01"
	arr[44] = "SkirtFBone02"
	arr[45] = "SkirtFBone03"
	arr[46] = "SkirtLBone01"
	arr[47] = "SkirtLBone02"
	arr[48] = "SkirtLBone03"
	arr[49] = "SkirtRBone01"
	arr[50] = "SkirtRBone02"
	arr[51] = "SkirtRBone03"
	arr[52] = "NPC"
	arr[53] = "NPC Root [Root]"
	arr[54] = "NPC Spine [Spn0]"
	arr[55] = "NPC Spine1 [Spn1]"
	arr[56] = "NPC Spine2 [Spn2]"
	arr[57] = "NPC Neck [Neck]"
	arr[58] = "NPC Head [Head]"
	JsonUtil.StringListCopy(lists_json, "convert_nodes", arr)
	
	arr = new String[65]
	arr[0] = "NPC L Breast"
	arr[1] = "NPC R Breast"
	arr[2] = "NPC L Butt"
	arr[3] = "NPC R Butt"
	arr[4] = "NPC Belly"
	arr[5] = "NPC GenitalsBase [GenBase]"
	arr[6] = "NPC GenitalsScrotum [GenScrot]"
	arr[7] = "NPC L GenitalsScrotum [LGenScrot]"
	arr[8] = "NPC R GenitalsScrotum [RGenScrot]"
	arr[9] = "NPC Genitals01 [Gen01]"
	arr[10] = "NPC Genitals02 [Gen02]"
	arr[11] = "NPC Genitals03 [Gen03]"
	arr[12] = "NPC Genitals04 [Gen04]"
	arr[13] = "NPC Genitals05 [Gen05]"
	arr[14] = "NPC Genitals06 [Gen06]"
	arr[15] = "CME Genitals01 [Gen01]"
	arr[16] = "CME Genitals02 [Gen02]"
	arr[17] = "CME Genitals03 [Gen03]"
	arr[18] = "CME Genitals04 [Gen04]"
	arr[19] = "CME Genitals05 [Gen05]"
	arr[20] = "CME Genitals06 [Gen06]"
	arr[21] = "NPC L Pussy01"
	arr[22] = "NPC R Pussy01"
	arr[23] = "NPC L Pussy02"
	arr[24] = "NPC R Pussy02"
	arr[25] = "NPC L Clavicle [LClv]"
	arr[26] = "NPC R Clavicle [RClv]"
	arr[27] = "NPC Pelvis [Pelv]"
	arr[28] = "NPC L UpperArm [LUar]"
	arr[29] = "NPC R UpperArm [RUar]"
	arr[30] = "NPC L UpperarmTwist1 [LUt1]"
	arr[31] = "NPC R UpperarmTwist1 [RUt1]"
	arr[32] = "NPC L UpperarmTwist2 [LUt2]"
	arr[33] = "NPC R UpperarmTwist2 [RUt2]"
	arr[34] = "NPC L Forearm [LLar]"
	arr[35] = "NPC R Forearm [RLar]"
	arr[36] = "NPC L ForearmTwist1 [LLt1]"
	arr[37] = "NPC R ForearmTwist1 [RLt1]"
	arr[38] = "NPC L Hand [LHnd]"
	arr[39] = "NPC R Hand [RHnd]"
	arr[40] = "NPC L Thigh [LThg]"
	arr[41] = "NPC R Thigh [RThg]"
	arr[42] = "NPC L Calf [LClf]"
	arr[43] = "NPC R Calf [RClf]"
	arr[44] = "NPC L Foot [Lft ]"
	arr[45] = "NPC R Foot [Rft ]"
	arr[46] = "SkirtBBone01"
	arr[47] = "SkirtBBone02"
	arr[48] = "SkirtBBone03"
	arr[49] = "SkirtFBone01"
	arr[50] = "SkirtFBone02"
	arr[51] = "SkirtFBone03"
	arr[52] = "SkirtLBone01"
	arr[53] = "SkirtLBone02"
	arr[54] = "SkirtLBone03"
	arr[55] = "SkirtRBone01"
	arr[56] = "SkirtRBone02"
	arr[57] = "SkirtRBone03"
	arr[58] = "NPC"
	arr[59] = "NPC Root [Root]"
	arr[60] = "NPC Spine [Spn0]"
	arr[61] = "NPC Spine1 [Spn1]"
	arr[62] = "NPC Spine2 [Spn2]"
	arr[63] = "NPC Neck [Neck]"
	arr[64] = "NPC Head [Head]"
	JsonUtil.SetPathStringArray(lists_json, ".node_lists.000_nodes.", arr)
	
	arr = new String[10]
	arr[0] = "NPC L Breast"
	arr[1] = "NPC R Breast"
	arr[2] = "NPC L Butt"
	arr[3] = "NPC R Butt"
	arr[4] = "NPC Belly"
	arr[5] = "NPC Pelvis [Pelv]"
	arr[6] = "NPC L Pussy01"
	arr[7] = "NPC R Pussy01"
	arr[8] = "NPC L Pussy02"
	arr[9] = "NPC R Pussy02"
	JsonUtil.SetPathStringArray(lists_json, ".node_lists.001_primary_nodes.", arr)
	
	arr = new String[16]
	arr[0] = "NPC GenitalsBase [GenBase]"
	arr[1] = "NPC GenitalsScrotum [GenScrot]"
	arr[2] = "NPC L GenitalsScrotum [LGenScrot]"
	arr[3] = "NPC R GenitalsScrotum [RGenScrot]"
	arr[4] = "NPC Genitals01 [Gen01]"
	arr[5] = "NPC Genitals02 [Gen02]"
	arr[6] = "NPC Genitals03 [Gen03]"
	arr[7] = "NPC Genitals04 [Gen04]"
	arr[8] = "NPC Genitals05 [Gen05]"
	arr[9] = "NPC Genitals06 [Gen06]"
	arr[10] = "CME Genitals01 [Gen01]"
	arr[11] = "CME Genitals02 [Gen02]"
	arr[12] = "CME Genitals03 [Gen03]"
	arr[13] = "CME Genitals04 [Gen04]"
	arr[14] = "CME Genitals05 [Gen05]"
	arr[15] = "CME Genitals06 [Gen06]"
	JsonUtil.SetPathStringArray(lists_json, ".node_lists.002_schlong_nodes.", arr)
	
	arr = new String[14]
	arr[0] = "NPC L Clavicle [LClv]"
	arr[1] = "NPC R Clavicle [RClv]"
	arr[2] = "NPC L UpperArm [LUar]"
	arr[3] = "NPC R UpperArm [RUar]"
	arr[4] = "NPC L UpperarmTwist1 [LUt1]"
	arr[5] = "NPC R UpperarmTwist1 [RUt1]"
	arr[6] = "NPC L UpperarmTwist2 [LUt2]"
	arr[7] = "NPC R UpperarmTwist2 [RUt2]"
	arr[8] = "NPC L Forearm [LLar]"
	arr[9] = "NPC R Forearm [RLar]"
	arr[10] = "NPC L ForearmTwist1 [LLt1]"
	arr[11] = "NPC R ForearmTwist1 [RLt1]"
	arr[12] = "NPC L Hand [LHnd]"
	arr[13] = "NPC R Hand [RHnd]"
	JsonUtil.SetPathStringArray(lists_json, ".node_lists.003_arm_nodes.", arr)
	
	arr = new String[6]
	arr[0] = "NPC L Thigh [LThg]"
	arr[1] = "NPC R Thigh [RThg]"
	arr[2] = "NPC L Calf [LClf]"
	arr[3] = "NPC R Calf [RClf]"
	arr[4] = "NPC L Foot [Lft ]"
	arr[5] = "NPC R Foot [Rft ]"
	JsonUtil.SetPathStringArray(lists_json, ".node_lists.004_leg_nodes.", arr)
	
	arr = new String[12]
	arr[0] = "SkirtBBone01"
	arr[1] = "SkirtBBone02"
	arr[2] = "SkirtBBone03"
	arr[3] = "SkirtFBone01"
	arr[4] = "SkirtFBone02"
	arr[5] = "SkirtFBone03"
	arr[6] = "SkirtLBone01"
	arr[7] = "SkirtLBone02"
	arr[8] = "SkirtLBone03"
	arr[9] = "SkirtRBone01"
	arr[10] = "SkirtRBone02"
	arr[11] = "SkirtRBone03"
	JsonUtil.SetPathStringArray(lists_json, ".node_lists.005_skirt_bone_nodes.", arr)
	
	arr = new String[7]
	arr[0] = "NPC"
	arr[1] = "NPC Root [Root]"
	arr[2] = "NPC Spine [Spn0]"
	arr[3] = "NPC Spine1 [Spn1]"
	arr[4] = "NPC Spine2 [Spn2]"
	arr[5] = "NPC Neck [Neck]"
	arr[6] = "NPC Head [Head]"
	JsonUtil.SetPathStringArray(lists_json, ".node_lists.006_root_nodes.", arr)
	
	arr = new String[57]
	arr[0] = "Breasts"
	arr[1] = "BreastsSmall"
	arr[2] = "BreastsSH"
	arr[3] = "BreastsSSH"
	arr[4] = "BreastsFantasy"
	arr[5] = "DoubleMelon"
	arr[6] = "BreastCleavage"
	arr[7] = "BreastFlatness"
	arr[8] = "BreastGravity"
	arr[9] = "PushUp"
	arr[10] = "BreastHeight"
	arr[11] = "BreastPerkiness"
	arr[12] = "BreastWidth"
	arr[13] = "NippleDistance"
	arr[14] = "NipplePerkiness"
	arr[15] = "NippleLength"
	arr[16] = "NippleSize"
	arr[17] = "NippleAreola"
	arr[18] = "NippleUp"
	arr[19] = "NippleDown"
	arr[20] = "NippleTip"
	arr[21] = "Arms"
	arr[22] = "ChubbyArms"
	arr[23] = "ShoulderSmooth"
	arr[24] = "ShoulderWidth"
	arr[25] = "BigTorso"
	arr[26] = "Waist"
	arr[27] = "WideWaistLine"
	arr[28] = "ChubbyWaist"
	arr[29] = "Belly"
	arr[30] = "BigBelly"
	arr[31] = "PregnancyBelly"
	arr[32] = "TummyTuck"
	arr[33] = "Back"
	arr[34] = "Hipbone"
	arr[35] = "Hips"
	arr[36] = "ButtCrack"
	arr[37] = "Butt"
	arr[38] = "ButtSmall"
	arr[39] = "ButtShape2"
	arr[40] = "BigButt"
	arr[41] = "ChubbyButt"
	arr[42] = "AppleCheeks"
	arr[43] = "RoundAss"
	arr[44] = "Groin"
	arr[45] = "SlimThighs"
	arr[46] = "Thighs"
	arr[47] = "ChubbyLegs"
	arr[48] = "Legs"
	arr[49] = "KneeHeight"
	arr[50] = "CalfSize"
	arr[51] = "CalfSmooth"
	arr[52] = "Ankles"
	arr[53] = "SmallSeam"
	arr[54] = "ShoulderTweak"
	arr[55] = "Samuel"
	arr[56] = "Samson"
	JsonUtil.SetPathStringArray(lists_json, ".morph_lists.000_morphs.", arr)
	
	arr = new String[13]
	arr[0] = "Breasts"
	arr[1] = "BreastsSmall"
	arr[2] = "BreastsSH"
	arr[3] = "BreastsSSH"
	arr[4] = "BreastsFantasy"
	arr[5] = "DoubleMelon"
	arr[6] = "BreastCleavage"
	arr[7] = "BreastFlatness"
	arr[8] = "BreastGravity"
	arr[9] = "PushUp"
	arr[10] = "BreastHeight"
	arr[11] = "BreastPerkiness"
	arr[12] = "BreastWidth"
	JsonUtil.SetPathStringArray(lists_json, ".morph_lists.001_breast_morphs.", arr)
	
	arr = new String[8]
	arr[0] = "NippleDistance"
	arr[1] = "NipplePerkiness"
	arr[2] = "NippleLength"
	arr[3] = "NippleSize"
	arr[4] = "NippleAreola"
	arr[5] = "NippleUp"
	arr[6] = "NippleDown"
	arr[7] = "NippleTip"
	JsonUtil.SetPathStringArray(lists_json, ".morph_lists.002_nipple_morphs.", arr)
	
	arr = new String[5]
	arr[0] = "Arms"
	arr[1] = "ChubbyArms"
	arr[2] = "ShoulderSmooth"
	arr[3] = "ShoulderWidth"
	arr[4] = "ShoulderTweak"
	JsonUtil.SetPathStringArray(lists_json, ".morph_lists.003_arm_morphs.", arr)
	
	arr = new String[4]
	arr[0] = "BigTorso"
	arr[1] = "Back"
	arr[2] = "Groin"
	arr[3] = "SmallSeam"
	JsonUtil.SetPathStringArray(lists_json, ".morph_lists.004_root_morphs.", arr)
	
	arr = new String[3]
	arr[0] = "Waist"
	arr[1] = "WideWaistLine"
	arr[2] = "ChubbyWaist"
	JsonUtil.SetPathStringArray(lists_json, ".morph_lists.005_waist_morphs.", arr)
	
	arr = new String[4]
	arr[0] = "Belly"
	arr[1] = "BigBelly"
	arr[2] = "PregnancyBelly"
	arr[3] = "TummyTuck"
	JsonUtil.SetPathStringArray(lists_json, ".morph_lists.006_belly_morphs.", arr)
	
	arr = new String[2]
	arr[0] = "Hipbone"
	arr[1] = "Hips"
	JsonUtil.SetPathStringArray(lists_json, ".morph_lists.007_hip_morphs.", arr)
	
	arr = new String[8]
	arr[0] = "ButtCrack"
	arr[1] = "Butt"
	arr[2] = "ButtSmall"
	arr[3] = "ButtShape2"
	arr[4] = "BigButt"
	arr[5] = "ChubbyButt"
	arr[6] = "AppleCheeks"
	arr[7] = "RoundAss"
	JsonUtil.SetPathStringArray(lists_json, ".morph_lists.008_butt_morphs.", arr)
	
	arr = new String[8]
	arr[0] = "SlimThighs"
	arr[1] = "Thighs"
	arr[2] = "ChubbyLegs"
	arr[3] = "Legs"
	arr[4] = "KneeHeight"
	arr[5] = "CalfSize"
	arr[6] = "CalfSmooth"
	arr[7] = "Ankles"
	JsonUtil.SetPathStringArray(lists_json, ".morph_lists.009_leg_morphs.", arr)
	
	arr = new String[2]
	arr[0] = "Samuel"
	arr[1] = "Samson"
	JsonUtil.SetPathStringArray(lists_json, ".morph_lists.010_male_morphs.", arr)
	
	SLIF_Util.SaveJson(lists_json)
	
EndFunction
