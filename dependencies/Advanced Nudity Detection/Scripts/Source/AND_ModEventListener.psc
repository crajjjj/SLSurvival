ScriptName AND_ModEventListener extends Quest

Event OnInit()
	InitializeModEvents()
EndEvent

Function InitializeModEvents()
	RegisterForModEvent("AdvancedNudityDetection_GetModestyRank", "OnGetModestyRank")
	RegisterForModEvent("AdvancedNudityDetection_GetTopModestyRank", "OnGetTopModestyRank")
	RegisterForModEvent("AdvancedNudityDetection_GetBottomModestyRank", "OnGetBottomModestyRank")
	
	RegisterForModEvent("AdvancedNudityDetection_GetShowingBra", "OnGetShowingBra")
	RegisterForModEvent("AdvancedNudityDetection_GetShowingUnderwear", "OnGetShowingUnderwear")
	RegisterForModEvent("AdvancedNudityDetection_GetShowingChest", "OnGetShowingChest")
	RegisterForModEvent("AdvancedNudityDetection_GetShowingGenitals", "OnGetShowingGenitals")
	RegisterForModEvent("AdvancedNudityDetection_GetShowingAss", "OnGetShowingAss")
	RegisterForModEvent("AdvancedNudityDetection_GetTopless", "OnGetTopless")
	RegisterForModEvent("AdvancedNudityDetection_GetBottomless", "OnGetBottomless")
	RegisterForModEvent("AdvancedNudityDetection_GetNude", "OnGetNude")
	
	RegisterForModEvent("AdvancedNudityDetection_RegisterMod", "OnRegisterMod")
	RegisterForModEvent("AdvancedNudityDetection_UnregisterMod", "OnUnregisterMod")
	
	RegisterForModEvent("AdvancedNudityDetection_EnableDynamicModesty", "OnEnableDynamicModesty")
	
	RegisterForModEvent("AdvancedNudityDetection_SetMinModesty", "OnSetMinimumStrictModestyRank")
	RegisterForModEvent("AdvancedNudityDetection_GetMinModesty", "OnGetMinimumStrictModestyRank")
	RegisterForModEvent("AdvancedNudityDetection_SetMinTopModesty", "OnSetMinimumTopModestyRank")
	RegisterForModEvent("AdvancedNudityDetection_GetMinTopModesty", "OnGetMinimumTopModestyRank")
	RegisterForModEvent("AdvancedNudityDetection_SetMinBottomModesty", "OnSetMinimumBottomModestyRank")
	RegisterForModEvent("AdvancedNudityDetection_GetMinBottomModesty", "OnGetMinimumBottomModestyRank")
	
	RegisterForModEvent("AdvancedNudityDetection_SetUseDynamicModesty", "OnSetUseDynamicModesty")
	RegisterForModEvent("AdvancedNudityDetection_GetUseDynamicModesty", "OnGetUseDynamicModesty")
	RegisterForModEvent("AdvancedNudityDetection_SetStrictModestyRules", "OnSetStrictModestyRules")
	RegisterForModEvent("AdvancedNudityDetection_GetStrictModestyRules", "OnGetStrictModestyRules")
	RegisterForModEvent("AdvancedNudityDetection_SetHardcore", "OnSetHardcore")
	RegisterForModEvent("AdvancedNudityDetection_GetHardcore", "OnGetHardcore")
	RegisterForModEvent("AdvancedNudityDetection_SetCorruption", "OnSetCorruption")
	RegisterForModEvent("AdvancedNudityDetection_GetCorruption", "OnGetCorruption")
	RegisterForModEvent("AdvancedNudityDetection_SetPermShameless", "OnSetShameless")
	RegisterForModEvent("AdvancedNudityDetection_GetPermShameless", "OnGetShameless")
	RegisterForModEvent("AdvancedNudityDetection_SetModestyUpgradeBlocked", "OnSetModestyUpgradeBlocked")
	RegisterForModEvent("AdvancedNudityDetection_GetModestyUpgradeBlocked", "OnGetModestyUpgradeBlocked")
	RegisterForModEvent("AdvancedNudityDetection_SetImmodestyTime", "OnSetImmodestyTime")
	RegisterForModEvent("AdvancedNudityDetection_GetImmodestyTime", "OnGetImmodestyTime")
EndFunction

;===SKSE Functions===

Int Function GetModestyRank(Form ActorForm) Global Native
Int Function GetTopModestyRank(Form ActorForm) Global Native
Int Function GetBottomModestyRank(Form ActorForm) Global Native

Bool Function GetShowingBra(Form ActorForm) Global Native
Bool Function GetShowingUnderwear(Form ActorForm) Global Native
Bool Function GetShowingChest(Form ActorForm) Global Native
Bool Function GetShowingGenitals(Form ActorForm) Global Native
Bool Function GetShowingAss(Form ActorForm) Global Native
Bool Function GetTopless(Form ActorForm) Global Native
Bool Function GetBottomless(Form ActorForm) Global Native
Bool Function GetNude(Form ActorForm) Global Native


;/
=====================================================
Example - Request Modesty Faction Rank for an actor:

Int EventHandle = ModEvent.Create("AdvancedNudityDetection_GetModestyRank")
ModEvent.PushForm(EventHandle, ActorForm)
ModEvent.Send(EventHandle)
=====================================================

=====================================================
Example - Receive the information from our previous example:

RegisterForModEvent("AdvancedNudityDetection_ReturnModestyRank", "OnReceiveModestyRank")

Event OnReceiveModestyRank(Int Rank)
	Debug.Notification("Modesty Rank is:" + Rank)
	;Or do other things with this data
EndEvent
=====================================================
/;

Event OnGetModestyRank(Form ActorForm)
	Int Rank = GetModestyRank(ActorForm)
	
	Int EventHandle = ModEvent.Create("AdvancedNudityDetection_ReturnModestyRank")
	ModEvent.PushInt(EventHandle, Rank)
	ModEvent.Send(EventHandle)
EndEvent

Event OnGetTopModestyRank(Form ActorForm)
	Int Rank = GetTopModestyRank(ActorForm)
	
	Int EventHandle = ModEvent.Create("AdvancedNudityDetection_ReturnTopModestyRank")
	ModEvent.PushInt(EventHandle, Rank)
	ModEvent.Send(EventHandle)
EndEvent

Event OnGetBottomModestyRank(Form ActorForm)
	Int Rank = GetBottomModestyRank(ActorForm)
	
	Int EventHandle = ModEvent.Create("AdvancedNudityDetection_ReturnBottomModestyRank")
	ModEvent.PushInt(EventHandle, Rank)
	ModEvent.Send(EventHandle)
EndEvent

Event OnGetShowingBra(Form ActorForm)
	Bool IsShowingBra = GetShowingBra(ActorForm)
	
	Int EventHandle = ModEvent.Create("AdvancedNudityDetection_ReturnIsShowingBra")
	ModEvent.PushBool(EventHandle, IsShowingBra)
	ModEvent.Send(EventHandle)
EndEvent

Event OnGetShowingUnderwear(Form ActorForm)
	Bool IsShowingUnderwear = GetShowingUnderwear(ActorForm)
	
	Int EventHandle = ModEvent.Create("AdvancedNudityDetection_ReturnIsShowingUnderwear")
	ModEvent.PushBool(EventHandle, IsShowingUnderwear)
	ModEvent.Send(EventHandle)
EndEvent

Event OnGetShowingChest(Form ActorForm)
	Bool IsShowingChest = GetShowingChest(ActorForm)
	
	Int EventHandle = ModEvent.Create("AdvancedNudityDetection_ReturnIsShowingChest")
	ModEvent.PushBool(EventHandle, IsShowingChest)
	ModEvent.Send(EventHandle)
EndEvent

Event OnGetShowingGenitals(Form ActorForm)
	Bool IsShowingGenitals = GetShowingGenitals(ActorForm)
	
	Int EventHandle = ModEvent.Create("AdvancedNudityDetection_ReturnIsShowingGenitals")
	ModEvent.PushBool(EventHandle, IsShowingGenitals)
	ModEvent.Send(EventHandle)
EndEvent

Event OnGetShowingAss(Form ActorForm)
	Bool IsShowingAss = GetShowingAss(ActorForm)
	
	Int EventHandle = ModEvent.Create("AdvancedNudityDetection_ReturnIsShowingAss")
	ModEvent.PushBool(EventHandle, IsShowingAss)
	ModEvent.Send(EventHandle)
EndEvent

Event OnGetTopless(Form ActorForm)
	Bool IsTopless = GetTopless(ActorForm)
	
	Int EventHandle = ModEvent.Create("AdvancedNudityDetection_ReturnIsTopless")
	ModEvent.PushBool(EventHandle, IsTopless)
	ModEvent.Send(EventHandle)
EndEvent

Event OnGetBottomless(Form ActorForm)
	Bool IsBottomless = GetBottomless(ActorForm)
	
	Int EventHandle = ModEvent.Create("AdvancedNudityDetection_ReturnIsBottomless")
	ModEvent.PushBool(EventHandle, IsBottomless)
	ModEvent.Send(EventHandle)
EndEvent

Event OnGetNude(Form ActorForm)
	Bool IsNude = GetNude(ActorForm)
	
	Int EventHandle = ModEvent.Create("AdvancedNudityDetection_ReturnIsNude")
	ModEvent.PushBool(EventHandle, IsNude)
	ModEvent.Send(EventHandle)
EndEvent

;/
===========================================
Registry Events
===========================================
/;

Event OnRegisterMod(String PluginName)
	RegisterPlugin(PluginName)
EndEvent
Function RegisterPlugin(String PluginName) Global Native


Event OnUnregisterMod(String PluginName)
	UnregisterPlugin(PluginName)
EndEvent
Function UnregisterPlugin(String PluginName) Global Native

;/
===========================================
Modesty Events
===========================================
/;

Event OnEnableDynamicModesty(String Plugin, Bool Enabled)
	EnableDynamicModesty(Plugin, Enabled)
EndEvent
Function EnableDynamicModesty(String Plugin, Bool Enabled) Global Native

Event OnGetUseDynamicModesty()
	Int EventHandle = ModEvent.Create("AdvancedNudityDetection_ReturnUseDynamicModesty")
	ModEvent.PushBool(EventHandle, GetIsDynamicModestyEnabled())
	ModEvent.Send(EventHandle)
EndEvent
Bool Function GetIsDynamicModestyEnabled() Global Native

Event OnSetStrictModestyRules(String Plugin, Bool Strict)
	SetStrictModestyRules(Plugin, Strict)
EndEvent
Function SetStrictModestyRules(String Plugin, Bool Strict) Global Native

Event OnGetStrictModestyRules()
	Int EventHandle = ModEvent.Create("AdvancedNudityDetection_ReturnStrictModestyRules")
	ModEvent.PushBool(EventHandle, GetStrictRulesEnabled())
	ModEvent.Send(EventHandle)
EndEvent
Bool Function GetStrictRulesEnabled() Global Native

Event OnSetMinimumStrictModestyRank(String Plugin, Int Rank)
	SetMinimumStrictModestyRank(Plugin, Rank)
EndEvent
Function SetMinimumStrictModestyRank(String Plugin, Int Rank) Global Native

Event OnGetMinimumStrictModestyRank()
	Int EventHandle = ModEvent.Create("AdvancedNudityDetection_ReturnMinimumModestyRank")
	ModEvent.PushInt(EventHandle, GetMinimumStrictModestyRank())
	ModEvent.Send(EventHandle)
EndEvent
Int Function GetMinimumStrictModestyRank() Global Native

Event OnSetMinimumTopModestyRank(String Plugin, Int Rank)
	SetMinimumTopModestyRank(Plugin, Rank)
EndEvent
Function SetMinimumTopModestyRank(String Plugin, Int Rank) Global Native

Event OnGetMinimumTopModestyRank()
	Int EventHandle = ModEvent.Create("AdvancedNudityDetection_ReturnMinimumTopModestyRank")
	ModEvent.PushInt(EventHandle, GetMinimumTopModestyRank())
	ModEvent.Send(EventHandle)
EndEvent
Int Function GetMinimumTopModestyRank() Global Native

Event OnSetMinimumBottomModestyRank(String Plugin, Int Rank)
	SetMinimumBottomModestyRank(Plugin, Rank)
EndEvent
Function SetMinimumBottomModestyRank(String Plugin, Int Rank) Global Native

Event OnGetMinimumBottomModestyRank()
	Int EventHandle = ModEvent.Create("AdvancedNudityDetection_ReturnMinimumTopModestyRank")
	ModEvent.PushInt(EventHandle, GetMinimumBottomModestyRank())
	ModEvent.Send(EventHandle)
EndEvent
Int Function GetMinimumBottomModestyRank() Global Native

Event OnSetHardcore(String Plugin, Bool HardcoreModeEnabled)
	SetHardcore(Plugin, HardcoreModeEnabled)
EndEvent
Function SetHardcore(String Plugin, Bool HardcoreModeEnabled) Global Native

Event OnGetHardcore()
	Int EventHandle = ModEvent.Create("AdvancedNudityDetection_ReturnHardcore")
	ModEvent.PushBool(EventHandle, GetHardcore())
	ModEvent.Send(EventHandle)
EndEvent
Bool Function GetHardcore() Global Native

Event OnSetCorruption(String Plugin, Bool Corruption)
	SetCorruption(Plugin, Corruption)
EndEvent
Function SetCorruption(String Plugin, Bool Corruption) Global Native

Event OnGetCorruption()
	Int EventHandle = ModEvent.Create("AdvancedNudityDetection_ReturnCorruption")
	ModEvent.PushBool(EventHandle, GetCorruption())
	ModEvent.Send(EventHandle)
EndEvent
Bool Function GetCorruption() Global Native

Event OnSetShameless(String Plugin, Bool AllowShameless)
	SetShameless(Plugin, AllowShameless)
EndEvent
Function SetShameless(String Plugin, Bool AllowShameless) Global Native

Event OnGetShameless()
	Int EventHandle = ModEvent.Create("AdvancedNudityDetection_ReturnPermShameless")
	ModEvent.PushBool(EventHandle, GetShameless())
	ModEvent.Send(EventHandle)
EndEvent
Bool Function GetShameless() Global Native

Event OnSetModestyUpgradeBlocked(String Plugin, Bool BlockUpgrade)
	SetModestyUpgradeBlocked(Plugin, BlockUpgrade)
EndEvent
Function SetModestyUpgradeBlocked(String Plugin, Bool BlockUpgrade) Global Native

Event OnGetModestyUpgradeBlocked()
	Int EventHandle = ModEvent.Create("AdvancedNudityDetection_ReturnUpgradeBlocked")
	ModEvent.PushBool(EventHandle, GetModestyUpgradeBlocked())
	ModEvent.Send(EventHandle)
EndEvent
Bool Function GetModestyUpgradeBlocked() Global Native

Event OnSetImmodestyTime(String Plugin, Int ImmodestyTime)
	SetImmodestyTime(Plugin, ImmodestyTime)
EndEvent
Function SetImmodestyTime(String Plugin, Int ImmodestyTime) Global Native

Event OnGetImmodestyTime()
	Int EventHandle = ModEvent.Create("AdvancedNudityDetection_ReturnImmodestyTime")
	ModEvent.PushInt(EventHandle, GetImmodestyTime())
	ModEvent.Send(EventHandle)
EndEvent
int Function GetImmodestyTime() Global Native