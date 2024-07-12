Scriptname SLIF_ScannerAlias extends ReferenceAlias

bool function IsValidNiOverrideVersion() global
	int pluginVersion = SKSE.GetPluginVersion("NiOverride")
	int skeeVersion   = SKSE.GetPluginVersion("skee")
	int scriptVersion = NiOverride.GetScriptVersion()
	return ((pluginVersion >= 6 || skeeVersion >= 1) && scriptVersion >= 6)
endFunction

Function RegisterForModEvents()
	;inflate events
	RegisterForModEvent("SLIF_inflate",               "OnSLIF_inflate")
	RegisterForModEvent("SLIF_registerActor",         "OnSLIF_registerActor")
	RegisterForModEvent("SLIF_unregisterActor",       "OnSLIF_unregisterActor")
	RegisterForModEvent("SLIF_updateActor",           "OnSLIF_updateActor")
	RegisterForModEvent("SLIF_resetActor",            "OnSLIF_resetActor")
	RegisterForModEvent("SLIF_unregisterNode",        "OnSLIF_unregisterNode")
	RegisterForModEvent("SLIF_setDefaultValues",      "OnSLIF_setDefaultValues")
	RegisterForModEvent("SLIF_setMinMax",             "OnSLIF_setMinMax")
	RegisterForModEvent("SLIF_setMin",                "OnSLIF_setMinimum")
	RegisterForModEvent("SLIF_setMinimum",            "OnSLIF_setMinimum")
	RegisterForModEvent("SLIF_setMax",                "OnSLIF_setMaximum")
	RegisterForModEvent("SLIF_setMaximum",            "OnSLIF_setMaximum")
	RegisterForModEvent("SLIF_setMult",               "OnSLIF_setMultiplier")
	RegisterForModEvent("SLIF_setMultiplier",         "OnSLIF_setMultiplier")
	RegisterForModEvent("SLIF_setIncr",               "OnSLIF_setIncrement")
	RegisterForModEvent("SLIF_setIncrement",          "OnSLIF_setIncrement")
	RegisterForModEvent("SLIF_hideNode",              "OnSLIF_hideNode")
	RegisterForModEvent("SLIF_showNode",              "OnSLIF_showNode")
	;morph events
	RegisterForModEvent("SLIF_morph",                 "OnSLIF_morph")
	RegisterForModEvent("SLIF_registerMorphActor",    "OnSLIF_registerMorphActor")
	RegisterForModEvent("SLIF_unregisterMorphActor",  "OnSLIF_unregisterMorphActor")
	RegisterForModEvent("SLIF_updateMorphActor",      "OnSLIF_updateMorphActor")
	RegisterForModEvent("SLIF_resetMorphActor",       "OnSLIF_resetMorphActor")
	RegisterForModEvent("SLIF_unregisterMorph",       "OnSLIF_unregisterMorph")
	RegisterForModEvent("SLIF_setMorphDefaultValues", "OnSLIF_setMorphDefaultValues")
EndFunction

Function UnregisterForModEvents()
	;inflate events
	UnregisterForModEvent("SLIF_inflate")
	UnregisterForModEvent("SLIF_registerActor")
	UnregisterForModEvent("SLIF_unregisterActor")
	UnregisterForModEvent("SLIF_updateActor")
	UnregisterForModEvent("SLIF_resetActor")
	UnregisterForModEvent("SLIF_unregisterNode")
	UnregisterForModEvent("SLIF_setDefaultValues")
	UnregisterForModEvent("SLIF_setMinMax")
	UnregisterForModEvent("SLIF_setMin")
	UnregisterForModEvent("SLIF_setMinimum")
	UnregisterForModEvent("SLIF_setMax")
	UnregisterForModEvent("SLIF_setMaximum")
	UnregisterForModEvent("SLIF_setMult")
	UnregisterForModEvent("SLIF_setMultiplier")
	UnregisterForModEvent("SLIF_setIncr")
	UnregisterForModEvent("SLIF_setIncrement")
	UnregisterForModEvent("SLIF_hideNode")
	UnregisterForModEvent("SLIF_showNode")
	;morph events
	UnregisterForModEvent("SLIF_morph")
	UnregisterForModEvent("SLIF_registerMorphActor")
	UnregisterForModEvent("SLIF_unregisterMorphActor")
	UnregisterForModEvent("SLIF_updateMorphActor")
	UnregisterForModEvent("SLIF_resetMorphActor")
	UnregisterForModEvent("SLIF_unregisterMorph")
	UnregisterForModEvent("SLIF_setMorphDefaultValues")
EndFunction

Function maintenance()
	StorageUtil.SetIntValue(none, "slif_valid_nioverride", IsValidNiOverrideVersion() as int)
	RegisterForModEvents()
EndFunction

Event OnInit()
	maintenance()
EndEvent

Event OnPlayerLoadGame()
	maintenance()
	SLIF_Menu menu = Game.GetFormFromFile(0x800, "SexLab Inflation Framework.esp") as SLIF_Menu
	menu.maintenance()
	SLIF_Scanner Scanner = Game.GetFormFromFile(0x801, "SexLab Inflation Framework.esp") as SLIF_Scanner
	
	int count = StorageUtil.FormListCount(none, "slif_complete_actor_list")
	int i = 0
	while(i < count)
		Actor kActor = StorageUtil.FormListGet(none, "slif_complete_actor_list", i) as Actor
		if (kActor)
			bool is_female = SLIF_Scale.IsFemale(kActor)
			String[] node_transforms = NiOverride.GetNodeTransformNames(kActor, false, is_female)
			int j = 0
			while(j < node_transforms.length)
				String node = node_transforms[j]
				NiOverride.RemoveNodeTransformScale(kActor, false, is_female, node, "SexLab Inflation Framework.esp")
				NiOverride.RemoveNodeTransformScale(kActor, true,  is_female, node, "SexLab Inflation Framework.esp")
				j += 1
			endWhile
			NiOverride.ClearBodyMorphKeys(kActor, "SexLab Inflation Framework.esp")
			if (StorageUtil.HasIntValue(kActor, "slif_scanning_actor") == false)
				SLIF_Main.updateActor(kActor)
				SLIF_Morph.updateActor(kActor)
			endIf
				node_transforms = NiOverride.GetNodeTransformNames(kActor, false, is_female)
				j = 0
			while(j < node_transforms.length)
				String node = node_transforms[j]
				NiOverride.UpdateNodeTransform(kActor, false, is_female, node)
				NiOverride.UpdateNodeTransform(kActor, true,  is_female, node)
				j += 1
			endWhile
		endIf
		NiOverride.UpdateModelWeight(kActor)
		i += 1
	endWhile
	
	if (SLIF_Config.GetPathInt(".scanner", ".on_load") as bool)
		Scanner.initializeScanner()
	endIf
EndEvent

;inflate events
Event OnSLIF_inflate(Form Sender, String modName, String node, float value, String oldModName = "")
	SLIF_Main.inflate(Sender as Actor, modName, node, value, -1, -1, oldModName)
EndEvent

Event OnSLIF_registerActor(Form Sender, String modName, String node = "", String oldModName = "", float minimum = -1.0, float maximum = -1.0, float multiplier = -1.0, float increment = -1.0)
	SLIF_Main.registerActor(Sender as Actor, modName, node, -1, oldModName, minimum, maximum, multiplier, increment)
EndEvent

Event OnSLIF_unregisterActor(Form Sender, String modName)
	SLIF_Main.unregisterActor(Sender as Actor, modName)
EndEvent

Event OnSLIF_updateActor(Form Sender, String modName, String node = "", String oldModName = "", float minimum = -1.0, float maximum = -1.0, float multiplier = -1.0, float increment = -1.0)
	SLIF_Main.updateActor(Sender as Actor, modName, node, -1, -1, -1, oldModName, minimum, maximum, multiplier, increment)
EndEvent

Event OnSLIF_resetActor(Form Sender, String modName, String node = "", float value = 1.0, String oldModName = "", float minimum = -1.0, float maximum = -1.0, float multiplier = -1.0, float increment = -1.0)
	SLIF_Main.resetActor(Sender as Actor, modName, node, value, -1, -1, -1, oldModName, minimum, maximum, multiplier, increment)
EndEvent

Event OnSLIF_unregisterNode(Form Sender, String modName, String node)
	SLIF_Main.unregisterNode(Sender as Actor, node, modName)
EndEvent

Event OnSLIF_setDefaultValues(Form Sender, String modName, String node, float minimum = 0.0, float maximum = 100.0, float multiplier = 1.0, float increment = 0.1)
	SLIF_Main.SetMinMaxMultIncrValue(Sender as Actor, modName, node, minimum, maximum, multiplier, increment)
EndEvent

Event OnSLIF_setMinMax(Form Sender, String modName, String node, float minimum = 0.0, float maximum = 100.0)
	SLIF_Main.SetMinMaxValue(Sender as Actor, modName, node, minimum, maximum)
EndEvent

Event OnSLIF_setMinimum(Form Sender, String modName, String node, float minimum = 0.0)
	SLIF_Main.SetMinValue(Sender as Actor, modName, node, minimum)
EndEvent

Event OnSLIF_setMaximum(Form Sender, String modName, String node, float maximum = 100.0)
	SLIF_Main.SetMaxValue(Sender as Actor, modName, node, maximum)
EndEvent

Event OnSLIF_setMultiplier(Form Sender, String modName, String node, float multiplier = 1.0)
	SLIF_Main.SetMultValue(Sender as Actor, modName, node, multiplier)
EndEvent

Event OnSLIF_setIncrement(Form Sender, String modName, String node, float increment = 0.1)
	SLIF_Main.SetIncrValue(Sender as Actor, modName, node, increment)
EndEvent

Event OnSLIF_hideNode(Form Sender, String modName, String node, float value = 0.0000001, String oldModName = "")
	SLIF_Main.hideNode(Sender as Actor, modName, node, value, oldModName)
EndEvent

Event OnSLIF_showNode(Form Sender, String modName, String node)
	SLIF_Main.showNode(Sender as Actor, modName, node)
EndEvent

;morph events
Event OnSLIF_morph(Form Sender, String modName, String morphName, float value, string oldModName = "")
	SLIF_Morph.morph(Sender as Actor, modName, morphName, value, oldModName)
EndEvent

Event OnSLIF_registerMorphActor(Form Sender, String modName, String morphName = "", String oldModName = "", float minimum = -1.0, float maximum = -1.0, float multiplier = -1.0, float increment = -1.0)
	SLIF_Morph.registerActor(Sender as Actor, modName, morphName, oldModName, minimum, maximum, multiplier, increment)
EndEvent

Event OnSLIF_unregisterMorphActor(Form Sender, String modName)
	SLIF_Morph.unregisterActor(Sender as Actor, modName)
EndEvent

Event OnSLIF_updateMorphActor(Form Sender, String modName, String morphName = "", String oldModName = "", float minimum = -1.0, float maximum = -1.0, float multiplier = -1.0, float increment = -1.0)
	SLIF_Morph.updateActor(Sender as Actor, modName, morphName, oldModName, minimum, maximum, multiplier, increment)
EndEvent

Event OnSLIF_resetMorphActor(Form Sender, String modName, String morphName = "", float value = 1.0, String oldModName = "", float minimum = -1.0, float maximum = -1.0, float multiplier = -1.0, float increment = -1.0)
	SLIF_Morph.resetActor(Sender as Actor, modName, morphName, value, oldModName, minimum, maximum, multiplier, increment)
EndEvent

Event OnSLIF_unregisterMorph(Form Sender, String modName, String morphName)
	SLIF_Morph.unregisterMorph(Sender as Actor, morphName, modName)
EndEvent

Event OnSLIF_setMorphDefaultValues(Form Sender, String modName, String morphName, float minimum = 0.0, float maximum = 100.0, float multiplier = 1.0, float increment = 0.1)
	SLIF_Morph.SetMinMaxMultIncrValue(Sender as Actor, modName, morphName, minimum, maximum, multiplier, increment)
EndEvent
