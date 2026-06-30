ScriptName mzinBatheMCMMenu Extends SKI_ConfigBase
{ this script displays the MCM menu for mod configuration }

import JsonUtil
import PapyrusUtil
import PO3_SKSEFunctions

; core
mzinBathePlayerAlias Property BathePlayer Auto
mzinBatheQuest Property BatheQuest Auto
mzinTextureUtility Property TexUtil Auto
mzinOverlayUtility Property OlUtil Auto
mzinUtility Property mzinUtil Auto
mzinInit Property Init Auto
Quest Property mzinBatheFollowerDialogQuest Auto
FormList Property GetDirtyOverTimeSpellList Auto
Message Property MessageConfigWarn  Auto 
Keyword Property ActorTypeNPC Auto

; integration settings
Bool Property WadeDetection = true Auto Hidden
Float Property FadeTatsFadeTime = 8.0 Auto Hidden
Float Property FadeTatsSoapMult = 2.0 Auto Hidden
Float Property DirtinessPerSexActor = 0.04 Auto Hidden
Float Property VictimMult = 2.5 Auto Hidden
Bool Property FadeDirtSex = true Auto Hidden
Float Property SexIntervalDirt = 35.0 Auto Hidden
Float Property SexInterval = 1.0 Auto Hidden

; effects settings
GlobalVariable Property DirtShaderEnabled Auto
Float Property OverlayApplyAt = 0.40 Auto Hidden
Float Property StartingAlpha = 0.15 Auto Hidden
Int Property OverlayTint = 0xFFFFFF Auto Hidden
Float Property TimeToClean = 10.0 Auto Hidden
Float Property TimeToCleanInterval = 0.25 Auto Hidden
Bool Property TexSetOverride = False Auto Hidden

; references
Actor Property PlayerRef Auto

; factions
Faction Property TrackedBatherFaction Auto

; toggle values
GlobalVariable Property BathingInSkyrimEnabled Auto
GlobalVariable Property DialogTopicEnabled Auto
GlobalVariable Property WaterRestrictionEnabled Auto
GlobalVariable Property AutomateFollowerBathing Auto

; misc settings
GlobalVariable Property ShynessDistance Auto
GlobalVariable Property CleansingSwim Auto

; soap settings
GlobalVariable Property GetSoapyStyle Auto
GlobalVariable Property GetSoapyStyleFollowers Auto

; hotkey settings
GlobalVariable Property CheckStatusKeyCode Auto
GlobalVariable Property BatheKeyCode Auto
GlobalVariable Property ModifierKeyCode Auto

; animation settings - player
FormList Property BathingAnimationLoopCountList Auto
GlobalVariable Property BathingAnimationStyle Auto
GlobalVariable Property ShoweringAnimationStyle Auto
Bool Property AutoHideUI = True Auto Hidden
Bool Property AutoPlayerTFC = False Auto Hidden
Float[] Property AnimCustomMSet Auto
Float Property AnimCustomMSet1Freq = 0.00 Auto
Float[] Property AnimCustomFSet Auto
Float Property AnimCustomFSet1Freq = 0.00 Auto
Float Property AnimCustomFSet2Freq = 0.00 Auto
Float Property AnimCustomFSet3Freq = 0.00 Auto
Int Property AnimCustomTierCond = 1 Auto

; animation settings - follower
FormList Property BathingAnimationLoopCountListFollowers Auto
GlobalVariable Property BathingAnimationStyleFollowers Auto
GlobalVariable Property ShoweringAnimationStyleFollowers Auto
Float[] Property AnimCustomMSetFollowers Auto
Float Property AnimCustomMSet1FreqFollowers = 0.00 Auto
Float[] Property AnimCustomFSetFollowers Auto
Float Property AnimCustomFSet1FreqFollowers = 0.00 Auto
Float Property AnimCustomFSet2FreqFollowers = 0.00 Auto
Float Property AnimCustomFSet3FreqFollowers = 0.00 Auto
Int Property AnimCustomTierCondFollowers = 1 Auto

; undress settings
GlobalVariable Property GetDressedAfterBathingEnabled Auto
GlobalVariable Property GetDressedAfterBathingEnabledFollowers Auto

; dirtiness settings
FormList Property DirtinessSpellList Auto
FormList Property DirtinessThresholdList Auto
GlobalVariable Property DirtinessUpdateInterval Auto
GlobalVariable Property DirtinessPercentage Auto
GlobalVariable Property DirtinessPerHourPlayerHouse Auto
GlobalVariable Property DirtinessPerHourSettlement Auto
GlobalVariable Property DirtinessPerHourDungeon Auto
GlobalVariable Property DirtinessPerHourWilderness Auto

; auxiliary settings
Bool Property GameMessage = True Auto Hidden
Bool Property LogNotification = True Auto Hidden
Bool Property LogTrace = False Auto Hidden
bool Property ConfigWarn = True Auto Hidden
Bool Property SkipItemHash = False Auto Hidden

; local variables
string[] ModVersionCache
String[] BathingAnimationStyleArray
String[] ShoweringAnimationStyleArray
String[] GetSoapyStyleArray
String[] AutomateFollowerBathingArray
String[] AnimCustomTierCondArray
Int[] Property ArmorSlotArray Auto
Int[] Property ArmorSlotArrayFollowers Auto
Bool[] UndressArmorSlotArray
Bool[] UndressArmorSlotArrayFollowers
Bool IsConfigOpen = false
Actor CrosshairActor
Actor[] TrackedActors

; local variables - constants
String DF_Percentage_Dirt = "$BIS_DF_PERCENTAGE_DIRT"
String DF_Percentage = "$BIS_DF_PERCENTAGE"
String DF_Decimal = "$BIS_DF_DECIMAL"
String DF_Units = "$BIS_DF_UNITS"
String config = "../../../Interface/Bathing in Skyrim/Settings.json"

Int Property cachedSoftCheck = 0 Auto Hidden

Bool Property ShowTierCondConfig
	Bool Function Get()
		return Init.IsMalignisAnimInstalled
	EndFunction
EndProperty

Bool Property ShowIntegrations
	Bool Function Get()
		return Init.IsSexLabInstalled || Init.IsOStimInstalled || Init.IsFadeTattoosInstalled || Init.IsWadeInWaterInstalled
	EndFunction
EndProperty

String Function GetModName()
	return modname
EndFunction

String Function GetModVersion()
	return mzinAPI.GetModVersion()
EndFunction

Int Function GetVersion()
	Return mzinAPI.GetConfigVersion()
EndFunction

bool Function CheckVersionConflict()
	; potential conflict if config version number is incremented across a different or new major or minor version.
	string[] ModVersionCurrent = StringSplit(GetModVersion(), ".")
	if !ModVersionCache
		return true
	elseIf (ModVersionCache[0] != ModVersionCurrent[0]) || (ModVersionCache[1] != ModVersionCurrent[1]) || (ModVersionCurrent[2] as int == 0) ; invalid strings are displayed as 0, which is fine
		return true
	endIf
	return false
EndFunction

Event OnVersionUpdate(int version)
	if (CurrentVersion != 0) && (version > CurrentVersion)
		mzinUtil.LogTrace("Found BiSR MCM version " + GetVersion(), true)
		mzinUtil.LogNotification("Detected a newer config version. Refreshing...", true)
		RegisterForSingleUpdate(2.0)
	endIf
EndEvent

Event OnUpdate()
	VersionUpdate()
	mzinUtil.LogTrace("Finished update cycle.", true)
EndEvent

Function VersionUpdate()
	if CheckVersionConflict()
		if ConfigWarn && MessageConfigWarn.Show() == 0
			mzinUtil.ResetMCM()
			return
		else
			mzinUtil.LogNotification("Detected potential config version conflict.", true)
		endIf
	endIf
	OnConfigInit()
	mzinUtil.LogNotification("Updated internal configuration for " + GetModVersion(), true)
EndFunction

Event OnConfigInit()
	; automate follower bathing
	AutomateFollowerBathingArray = new String[3]
	AutomateFollowerBathingArray[0] = "$BIS_L_AUTOMATE_FOLLOWER_BATHING_DISABLED"
	AutomateFollowerBathingArray[1] = "$BIS_L_AUTOMATE_FOLLOWER_BATHING_TRACKEDONLY"
	AutomateFollowerBathingArray[2] = "$BIS_L_AUTOMATE_FOLLOWER_BATHING_ALL"

	; bathing animation styles
	BathingAnimationStyleArray = new String[3]
	BathingAnimationStyleArray[0] = "$BIS_L_ANIM_STYLE_NONE"
	BathingAnimationStyleArray[1] = "$BIS_L_ANIM_STYLE_DEFAULT"
	BathingAnimationStyleArray[2] = "$BIS_L_ANIM_STYLE_CUSTOM"

	; showering animation styles
	ShoweringAnimationStyleArray = new String[4]
	ShoweringAnimationStyleArray[0] = "$BIS_L_OVDE_STYLE_NONE"
	ShoweringAnimationStyleArray[1] = "$BIS_L_OVDE_STYLE_DEFAULT"
	ShoweringAnimationStyleArray[2] = "$BIS_L_OVDE_STYLE_CUSTOM"

	; soap effect styles
	GetSoapyStyleArray = new String[3]
	GetSoapyStyleArray[0] = "$BIS_L_SOAP_STYLE_NONE"
	GetSoapyStyleArray[1] = "$BIS_L_SOAP_STYLE_STATIC"
	GetSoapyStyleArray[2] = "$BIS_L_SOAP_STYLE_ANIMATED"

	; set tiered conditioning
	AnimCustomTierCondArray = new String[3]
	AnimCustomTierCondArray[0] = "$BIS_L_ANIM_TIERCOND_NONE"
	AnimCustomTierCondArray[1] = "$BIS_L_ANIM_TIERCOND_DIRTINESS"
	AnimCustomTierCondArray[2] = "$BIS_L_ANIM_TIERCOND_DANGER"

	ModVersionCache = StringSplit(GetModVersion(), ".")
EndEvent

Event OnConfigRegister()
	if JsonExists(config)
		Load(config)
	endIf
	mzinUtil.LogNotification("Installed Bathing in Skyrim " + GetModVersion(), true)
	mzinUtil.LogTrace("Installed Bathing in Skyrim " + GetModVersion(), true)
	if BathingInSkyrimEnabled.GetValue() == 0 && GetIntValue(config, "!!doautostart") == 1
		GoToState("AutoStartST")
	endIf
EndEvent

Event OnConfigOpen()
	UnregisterForUpdate()
	GoToState("")

	IsConfigOpen = true
	If BathingInSkyrimEnabled.GetValue() == 1
		Pages = new String[8]
		Pages[0] = "$BIS_PAGE_SYSTEM_OVERVIEW"
		Pages[1] = "$BIS_PAGE_SETTINGS"
		Pages[2] = "$BIS_PAGE_EFFECTS"
		Pages[3] = "$BIS_PAGE_ANIMATIONS"
		Pages[4] = "$BIS_PAGE_ANIMATIONS_FOLLOWERS"
		Pages[5] = "$BIS_PAGE_TRACKED_ACTORS"
		Pages[6] = "$BIS_PAGE_INTEGRATIONS"
		Pages[7] = "$BIS_PAGE_AUXILIARY"
	else
		Pages = new String[1]
		Pages[0] = "$BIS_PAGE_SYSTEM_OVERVIEW"
	endIf
EndEvent

Event OnConfigClose()
	IsConfigOpen = false
EndEvent

String Function GetModState()
	if BathingInSkyrimEnabled.GetValue() == 1
		return "$BIS_TXT_ENABLED"
	elseIf BathingInSkyrimEnabled.GetValue() == 0
		return "$BIS_TXT_DISABLED"
	elseIf BathingInSkyrimEnabled.GetValue() == -1
		return "$BIS_TXT_WORKING"
	else
		return "$BIS_TXT_ERRORED" ; function default
	endIf
EndFunction

Event OnPageReset(String Page)
	UnloadCustomContent()
	SetCursorFillMode(TOP_TO_BOTTOM)
	If !(BathingInSkyrimEnabled.GetValue() as bool) || (Page == "$BIS_PAGE_SYSTEM_OVERVIEW")
		DisplaySystemOverviewPage()
	ELseIf Page == ""
		DisplaySplashPage()
	ElseIf Page == "$BIS_PAGE_SETTINGS"
		DisplaySettingsPage()
	ElseIf Page == "$BIS_PAGE_EFFECTS"
		DisplayEffectsPage()
	ElseIf Page == "$BIS_PAGE_ANIMATIONS"
		DisplayAnimationsPage()
	ElseIf Page == "$BIS_PAGE_ANIMATIONS_FOLLOWERS"
		DisplayAnimationsPageFollowers()
	ElseIf Page == "$BIS_PAGE_TRACKED_ACTORS"
		DisplayTrackedActorsPage()
	ElseIf Page == "$BIS_PAGE_INTEGRATIONS"
		DisplayIntegrationsPage()
	ElseIf Page == "$BIS_PAGE_AUXILIARY"
		DisplayAuxiliaryPage()
	EndIf		
EndEvent

Function SetLocalArrays()
	; tracked actors array
	TrackedActors = new Actor[128]
	TrackedActorsToggleIDs = new Int[128]
	
	; animation frequency arrays
	AnimCustomMSet = new Float[1]
	AnimCustomMSet[0] = AnimCustomMSet1Freq
	AnimCustomFSet = new Float[3]
	AnimCustomFSet[0] = AnimCustomFSet1Freq
	AnimCustomFSet[1] = AnimCustomFSet2Freq
	AnimCustomFSet[2] = AnimCustomFSet3Freq
	AnimCustomMSetFollowers = new Float[1]
	AnimCustomMSetFollowers[0] = AnimCustomMSet1FreqFollowers
	AnimCustomFSetFollowers = new Float[3]
	AnimCustomFSetFollowers[0] = AnimCustomFSet1FreqFollowers
	AnimCustomFSetFollowers[1] = AnimCustomFSet2FreqFollowers
	AnimCustomFSetFollowers[2] = AnimCustomFSet3FreqFollowers

	; undress array
	UndressArmorSlotArray = new Bool[32]
	UndressArmorSlotArray = mzinUtil.RetrieveSlotState(ArmorSlotArray, UndressArmorSlotArray)
	ArmorSlotArray = mzinUtil.RenewSlotState(ArmorSlotArray, UndressArmorSlotArray)
	UndressArmorSlotArrayFollowers = new Bool[32]
	UndressArmorSlotArrayFollowers = mzinUtil.RetrieveSlotState(ArmorSlotArrayFollowers, UndressArmorSlotArrayFollowers)
	ArmorSlotArrayFollowers = mzinUtil.RenewSlotState(ArmorSlotArrayFollowers, UndressArmorSlotArrayFollowers)
	UndressArmorSlotToggleIDs = new Int[32]
	UndressArmorSlotToggleIDsFollowers = new Int[32]
EndFunction

State AutoStartST
	Event OnBeginState()
		RegisterForSingleUpdate(10.0)
	EndEvent
	Event OnUpdate()
		BathingInSkyrimEnabled.SetValue(-1)
		EnableBathingInSkyrim(GetIntValue(config, "!!doautoload") == 1)
		GoToState("")
	EndEvent
EndState

; display pages
Function DisplaySplashPage()
	LoadCustomContent("Bathing in Skyrim.dds", 56, 63)
EndFunction
Function DisplaySystemOverviewPage()
	AddHeaderOption("$BIS_HEADER_SETUP")
	ModStateOID_T = AddTextOption("$BIS_L_MODSTATE", GetModState())
	AddEmptyOption()
	AddHeaderOption("$BIS_HEADER_CONFIG")
	PapSetSaveOID_T = AddTextOption("$BIS_L_SAVE_SETTINGS", "", (BathingInSkyrimEnabled.GetValue() != 1) as int)
	PapSetLoadOID_T = AddTextOption("$BIS_L_LOAD_SETTINGS", "", (BathingInSkyrimEnabled.GetValue() != 1) as int)
	SetCursorPosition(1)
	AddHeaderOption("")
	AddTextOption("$BIS_L_MODVERSION", GetModVersion(), OPTION_FLAG_DISABLED)
	AddTextOption("$BIS_L_VERSION", GetVersion(), OPTION_FLAG_DISABLED)
	if init.DoHardCheck()
		AddTextOption("$BIS_L_DEPENDENCY_CHECK", "$BIS_TXT_SAFE", OPTION_FLAG_DISABLED)
	else
		AddTextOption("$BIS_L_DEPENDENCY_CHECK", "$BIS_TXT_FAILED", OPTION_FLAG_DISABLED)
	endIf
	AddTextOption("$BIS_L_RESTRICTED_STATE", BatheQuest.IsConditionallyRestricted(PlayerRef), OPTION_FLAG_DISABLED)
EndFunction
Function DisplayAnimationsPage()
	AddHeaderOption("$BIS_HEADER_PLAYER_SETTINGS")
	BathingAnimationStyleMenuID = AddMenuOption("$BIS_L_ANIM_STYLE", BathingAnimationStyleArray[BathingAnimationStyle.GetValue() As Int])
	ShoweringAnimationStyleMenuID = AddMenuOption("$BIS_L_OVDE_STYLE", ShoweringAnimationStyleArray[ShoweringAnimationStyle.GetValue() As Int], (!(BathingAnimationStyle.GetValue() as bool)) as int)
	GetSoapyStyleMenuID = AddMenuOption("$BIS_L_SOAP_STYLE", GetSoapyStyleArray[GetSoapyStyle.GetValue() As Int])
	AutoHideUIID = AddToggleOption("$BIS_L_AUTOHIDEUI", AutoHideUI)
	AutoPlayerTFCID = AddToggleOption("$BIS_L_AUTOPLAYERTFC", AutoPlayerTFC)

	AddHeaderOption("$BIS_HEADER_ANIM_LOOP")
	int ANIM_LOOP_FLAG = GetAnimOptionFlag(1)
	BathingAnimationLoopsTier0SliderID = AddSliderOption("$BIS_L_ANIM_LOOP_CLEAN", (BathingAnimationLoopCountList.GetAt(0) As GlobalVariable).GetValue(), "{0}", ANIM_LOOP_FLAG)
	BathingAnimationLoopsTier1SliderID = AddSliderOption("$BIS_L_ANIM_LOOP_NOT_DIRTY", (BathingAnimationLoopCountList.GetAt(1) As GlobalVariable).GetValue(), "{0}", ANIM_LOOP_FLAG)
	BathingAnimationLoopsTier2SliderID = AddSliderOption("$BIS_L_ANIM_LOOP_SLIGHTLY_DIRTY", (BathingAnimationLoopCountList.GetAt(2) As GlobalVariable).GetValue(), "{0}", ANIM_LOOP_FLAG)
	BathingAnimationLoopsTier3SliderID = AddSliderOption("$BIS_L_ANIM_LOOP_QUITE_DIRTY", (BathingAnimationLoopCountList.GetAt(3) As GlobalVariable).GetValue(), "{0}", ANIM_LOOP_FLAG)
	BathingAnimationLoopsTier4SliderID = AddSliderOption("$BIS_L_ANIM_LOOP_FILTHY", (BathingAnimationLoopCountList.GetAt(4) As GlobalVariable).GetValue(), "{0}", ANIM_LOOP_FLAG)

	AddHeaderOption("$BIS_HEADER_CUSTOM_FREQ")
	int CUSTOM_FREQ_FLAG = GetAnimOptionFlag(2)
	AnimCustomMSet1SliderID = AddSliderOption("$BIS_L_ANIM_STYLE_CUSTOM_MSet1", AnimCustomMSet1Freq, "{0}", CUSTOM_FREQ_FLAG)
	AnimCustomFSet1SliderID = AddSliderOption("$BIS_L_ANIM_STYLE_CUSTOM_FSet1", AnimCustomFSet1Freq, "{0}", CUSTOM_FREQ_FLAG)
	AnimCustomFSet2SliderID = AddSliderOption("$BIS_L_ANIM_STYLE_CUSTOM_FSet2", AnimCustomFSet2Freq, "{0}", CUSTOM_FREQ_FLAG)
	if Init.IsMalignisAnimInstalled
		AnimCustomFSet3SliderID = AddSliderOption("$BIS_L_ANIM_STYLE_CUSTOM_FSet3", AnimCustomFSet3Freq, "{0}", CUSTOM_FREQ_FLAG)
	endIf
	if ShowTierCondConfig
		AddHeaderOption("$BIS_HEADER_COND_ANIM")
		AnimCustomTierCondMenuID = AddMenuOption("$BIS_L_ANIM_TIERCOND", AnimCustomTierCondArray[AnimCustomTierCond], CUSTOM_FREQ_FLAG)
	endIf

	SetCursorPosition(1)	

	AddHeaderOption("$BIS_HEADER_GET_DRESSED")
	GetDressedAfterBathingEnabledToggleID = AddToggleOption("$BIS_TXT_TOGGLE", GetDressedAfterBathingEnabled.GetValue() As Bool)	
	AddHeaderOption("$BIS_HEADER_GET_NAKED_BASIC")
	UndressArmorSlotToggleIDs[0]  = AddToggleOption("$BIS_L_SLOT_30", UndressArmorSlotArray[0])
	UndressArmorSlotToggleIDs[1]  = AddToggleOption("$BIS_L_SLOT_31", UndressArmorSlotArray[1])
	UndressArmorSlotToggleIDs[2]  = AddToggleOption("$BIS_L_SLOT_32", UndressArmorSlotArray[2])
	UndressArmorSlotToggleIDs[3]  = AddToggleOption("$BIS_L_SLOT_33", UndressArmorSlotArray[3])
	UndressArmorSlotToggleIDs[4]  = AddToggleOption("$BIS_L_SLOT_34", UndressArmorSlotArray[4])
	UndressArmorSlotToggleIDs[5]  = AddToggleOption("$BIS_L_SLOT_35", UndressArmorSlotArray[5])
	UndressArmorSlotToggleIDs[6]  = AddToggleOption("$BIS_L_SLOT_36", UndressArmorSlotArray[6])
	UndressArmorSlotToggleIDs[7]  = AddToggleOption("$BIS_L_SLOT_37", UndressArmorSlotArray[7])
	UndressArmorSlotToggleIDs[8]  = AddToggleOption("$BIS_L_SLOT_38", UndressArmorSlotArray[8])
	UndressArmorSlotToggleIDs[9]  = AddToggleOption("$BIS_L_SLOT_39", UndressArmorSlotArray[9])
	UndressArmorSlotToggleIDs[10] = AddToggleOption("$BIS_L_SLOT_40", UndressArmorSlotArray[10])
	UndressArmorSlotToggleIDs[11] = AddToggleOption("$BIS_L_SLOT_41", UndressArmorSlotArray[11])
	UndressArmorSlotToggleIDs[12] = AddToggleOption("$BIS_L_SLOT_42", UndressArmorSlotArray[12])
	UndressArmorSlotToggleIDs[13] = AddToggleOption("$BIS_L_SLOT_43", UndressArmorSlotArray[13])	
	AddHeaderOption("$BIS_HEADER_GET_NAKED_EXTENDED")
	UndressArmorSlotToggleIDs[14] = AddToggleOption("$BIS_L_SLOT_44", UndressArmorSlotArray[14])
	UndressArmorSlotToggleIDs[15] = AddToggleOption("$BIS_L_SLOT_45", UndressArmorSlotArray[15])
	UndressArmorSlotToggleIDs[16] = AddToggleOption("$BIS_L_SLOT_46", UndressArmorSlotArray[16])
	UndressArmorSlotToggleIDs[17] = AddToggleOption("$BIS_L_SLOT_47", UndressArmorSlotArray[17])
	UndressArmorSlotToggleIDs[18] = AddToggleOption("$BIS_L_SLOT_48", UndressArmorSlotArray[18])
	UndressArmorSlotToggleIDs[19] = AddToggleOption("$BIS_L_SLOT_49", UndressArmorSlotArray[19])
	UndressArmorSlotToggleIDs[20] = AddToggleOption("$BIS_L_SLOT_50", UndressArmorSlotArray[20])
	UndressArmorSlotToggleIDs[21] = AddToggleOption("$BIS_L_SLOT_51", UndressArmorSlotArray[21])
	UndressArmorSlotToggleIDs[22] = AddToggleOption("$BIS_L_SLOT_52", UndressArmorSlotArray[22])
	UndressArmorSlotToggleIDs[23] = AddToggleOption("$BIS_L_SLOT_53", UndressArmorSlotArray[23])
	UndressArmorSlotToggleIDs[24] = AddToggleOption("$BIS_L_SLOT_54", UndressArmorSlotArray[24])
	UndressArmorSlotToggleIDs[25] = AddToggleOption("$BIS_L_SLOT_55", UndressArmorSlotArray[25])
	UndressArmorSlotToggleIDs[26] = AddToggleOption("$BIS_L_SLOT_56", UndressArmorSlotArray[26])
	UndressArmorSlotToggleIDs[27] = AddToggleOption("$BIS_L_SLOT_57", UndressArmorSlotArray[27])
	UndressArmorSlotToggleIDs[28] = AddToggleOption("$BIS_L_SLOT_58", UndressArmorSlotArray[28])
	UndressArmorSlotToggleIDs[29] = AddToggleOption("$BIS_L_SLOT_59", UndressArmorSlotArray[29])
	UndressArmorSlotToggleIDs[30] = AddToggleOption("$BIS_L_SLOT_60", UndressArmorSlotArray[30])
	UndressArmorSlotToggleIDs[31] = AddToggleOption("$BIS_L_SLOT_61", UndressArmorSlotArray[31])
EndFunction
Function DisplayAnimationsPageFollowers()
	AddHeaderOption("$BIS_HEADER_FOLLOWER_SETTINGS")
	BathingAnimationStyleMenuIDFollowers = AddMenuOption("$BIS_L_ANIM_STYLE", BathingAnimationStyleArray[BathingAnimationStyleFollowers.GetValue() As Int])
	ShoweringAnimationStyleMenuIDFollowers = AddMenuOption("$BIS_L_OVDE_STYLE", ShoweringAnimationStyleArray[ShoweringAnimationStyleFollowers.GetValue() As Int], (!(BathingAnimationStyleFollowers.GetValue() as bool)) as int)
	GetSoapyStyleMenuIDFollowers = AddMenuOption("$BIS_L_SOAP_STYLE", GetSoapyStyleArray[GetSoapyStyleFollowers.GetValue() As Int])

	AddHeaderOption("$BIS_HEADER_ANIM_LOOP")
	int ANIM_LOOP_FLAG = GetAnimOptionFlag_Followers(1)
	BathingAnimationLoopsTier0SliderIDFollowers = AddSliderOption("$BIS_L_ANIM_LOOP_CLEAN", (BathingAnimationLoopCountListFollowers.GetAt(0) As GlobalVariable).GetValue(), "{0}", ANIM_LOOP_FLAG)
	BathingAnimationLoopsTier1SliderIDFollowers = AddSliderOption("$BIS_L_ANIM_LOOP_NOT_DIRTY", (BathingAnimationLoopCountListFollowers.GetAt(1) As GlobalVariable).GetValue(), "{0}", ANIM_LOOP_FLAG)
	BathingAnimationLoopsTier2SliderIDFollowers = AddSliderOption("$BIS_L_ANIM_LOOP_SLIGHTLY_DIRTY", (BathingAnimationLoopCountListFollowers.GetAt(2) As GlobalVariable).GetValue(), "{0}", ANIM_LOOP_FLAG)
	BathingAnimationLoopsTier3SliderIDFollowers = AddSliderOption("$BIS_L_ANIM_LOOP_QUITE_DIRTY", (BathingAnimationLoopCountListFollowers.GetAt(3) As GlobalVariable).GetValue(), "{0}", ANIM_LOOP_FLAG)
	BathingAnimationLoopsTier4SliderIDFollowers = AddSliderOption("$BIS_L_ANIM_LOOP_FILTHY", (BathingAnimationLoopCountListFollowers.GetAt(4) As GlobalVariable).GetValue(), "{0}", ANIM_LOOP_FLAG)

	AddHeaderOption("$BIS_HEADER_CUSTOM_FREQ")
	int CUSTOM_FREQ_FLAG = GetAnimOptionFlag_Followers(2)
	AnimCustomMSet1SliderIDFollowers = AddSliderOption("$BIS_L_ANIM_STYLE_CUSTOM_MSet1", AnimCustomMSet1FreqFollowers, "{0}", CUSTOM_FREQ_FLAG)
	AnimCustomFSet1SliderIDFollowers = AddSliderOption("$BIS_L_ANIM_STYLE_CUSTOM_FSet1", AnimCustomFSet1FreqFollowers, "{0}", CUSTOM_FREQ_FLAG)
	AnimCustomFSet2SliderIDFollowers = AddSliderOption("$BIS_L_ANIM_STYLE_CUSTOM_FSet2", AnimCustomFSet2FreqFollowers, "{0}", CUSTOM_FREQ_FLAG)
	if Init.IsMalignisAnimInstalled
		AnimCustomFSet3SliderIDFollowers = AddSliderOption("$BIS_L_ANIM_STYLE_CUSTOM_FSet3", AnimCustomFSet3FreqFollowers, "{0}", CUSTOM_FREQ_FLAG)
	endIf
	if ShowTierCondConfig
		AddHeaderOption("$BIS_HEADER_COND_ANIM")
		AnimCustomTierCondMenuIDFollowers = AddMenuOption("$BIS_L_ANIM_TIERCOND", AnimCustomTierCondArray[AnimCustomTierCondFollowers], CUSTOM_FREQ_FLAG)
	endIf

	SetCursorPosition(1)

	AddHeaderOption("$BIS_HEADER_GET_DRESSED")
	GetDressedAfterBathingEnabledToggleIDFollowers = AddToggleOption("$BIS_TXT_TOGGLE", GetDressedAfterBathingEnabledFollowers.GetValue() As Bool)	
	AddHeaderOption("$BIS_HEADER_GET_NAKED_BASIC")
	UndressArmorSlotToggleIDsFollowers[0]  = AddToggleOption("$BIS_L_SLOT_30", UndressArmorSlotArrayFollowers[0])
	UndressArmorSlotToggleIDsFollowers[1]  = AddToggleOption("$BIS_L_SLOT_31", UndressArmorSlotArrayFollowers[1])
	UndressArmorSlotToggleIDsFollowers[2]  = AddToggleOption("$BIS_L_SLOT_32", UndressArmorSlotArrayFollowers[2])
	UndressArmorSlotToggleIDsFollowers[3]  = AddToggleOption("$BIS_L_SLOT_33", UndressArmorSlotArrayFollowers[3])
	UndressArmorSlotToggleIDsFollowers[4]  = AddToggleOption("$BIS_L_SLOT_34", UndressArmorSlotArrayFollowers[4])
	UndressArmorSlotToggleIDsFollowers[5]  = AddToggleOption("$BIS_L_SLOT_35", UndressArmorSlotArrayFollowers[5])
	UndressArmorSlotToggleIDsFollowers[6]  = AddToggleOption("$BIS_L_SLOT_36", UndressArmorSlotArrayFollowers[6])
	UndressArmorSlotToggleIDsFollowers[7]  = AddToggleOption("$BIS_L_SLOT_37", UndressArmorSlotArrayFollowers[7])
	UndressArmorSlotToggleIDsFollowers[8]  = AddToggleOption("$BIS_L_SLOT_38", UndressArmorSlotArrayFollowers[8])
	UndressArmorSlotToggleIDsFollowers[9]  = AddToggleOption("$BIS_L_SLOT_39", UndressArmorSlotArrayFollowers[9])
	UndressArmorSlotToggleIDsFollowers[10] = AddToggleOption("$BIS_L_SLOT_40", UndressArmorSlotArrayFollowers[10])
	UndressArmorSlotToggleIDsFollowers[11] = AddToggleOption("$BIS_L_SLOT_41", UndressArmorSlotArrayFollowers[11])
	UndressArmorSlotToggleIDsFollowers[12] = AddToggleOption("$BIS_L_SLOT_42", UndressArmorSlotArrayFollowers[12])
	UndressArmorSlotToggleIDsFollowers[13] = AddToggleOption("$BIS_L_SLOT_43", UndressArmorSlotArrayFollowers[13])	
	AddHeaderOption("$BIS_HEADER_GET_NAKED_EXTENDED")
	UndressArmorSlotToggleIDsFollowers[14] = AddToggleOption("$BIS_L_SLOT_44", UndressArmorSlotArrayFollowers[14])
	UndressArmorSlotToggleIDsFollowers[15] = AddToggleOption("$BIS_L_SLOT_45", UndressArmorSlotArrayFollowers[15])
	UndressArmorSlotToggleIDsFollowers[16] = AddToggleOption("$BIS_L_SLOT_46", UndressArmorSlotArrayFollowers[16])
	UndressArmorSlotToggleIDsFollowers[17] = AddToggleOption("$BIS_L_SLOT_47", UndressArmorSlotArrayFollowers[17])
	UndressArmorSlotToggleIDsFollowers[18] = AddToggleOption("$BIS_L_SLOT_48", UndressArmorSlotArrayFollowers[18])
	UndressArmorSlotToggleIDsFollowers[19] = AddToggleOption("$BIS_L_SLOT_49", UndressArmorSlotArrayFollowers[19])
	UndressArmorSlotToggleIDsFollowers[20] = AddToggleOption("$BIS_L_SLOT_50", UndressArmorSlotArrayFollowers[20])
	UndressArmorSlotToggleIDsFollowers[21] = AddToggleOption("$BIS_L_SLOT_51", UndressArmorSlotArrayFollowers[21])
	UndressArmorSlotToggleIDsFollowers[22] = AddToggleOption("$BIS_L_SLOT_52", UndressArmorSlotArrayFollowers[22])
	UndressArmorSlotToggleIDsFollowers[23] = AddToggleOption("$BIS_L_SLOT_53", UndressArmorSlotArrayFollowers[23])
	UndressArmorSlotToggleIDsFollowers[24] = AddToggleOption("$BIS_L_SLOT_54", UndressArmorSlotArrayFollowers[24])
	UndressArmorSlotToggleIDsFollowers[25] = AddToggleOption("$BIS_L_SLOT_55", UndressArmorSlotArrayFollowers[25])
	UndressArmorSlotToggleIDsFollowers[26] = AddToggleOption("$BIS_L_SLOT_56", UndressArmorSlotArrayFollowers[26])
	UndressArmorSlotToggleIDsFollowers[27] = AddToggleOption("$BIS_L_SLOT_57", UndressArmorSlotArrayFollowers[27])
	UndressArmorSlotToggleIDsFollowers[28] = AddToggleOption("$BIS_L_SLOT_58", UndressArmorSlotArrayFollowers[28])
	UndressArmorSlotToggleIDsFollowers[29] = AddToggleOption("$BIS_L_SLOT_59", UndressArmorSlotArrayFollowers[29])
	UndressArmorSlotToggleIDsFollowers[30] = AddToggleOption("$BIS_L_SLOT_60", UndressArmorSlotArrayFollowers[30])
	UndressArmorSlotToggleIDsFollowers[31] = AddToggleOption("$BIS_L_SLOT_61", UndressArmorSlotArrayFollowers[31])
EndFunction

Function DisplaySettingsPage()
	AddHeaderOption("$BIS_HEADER_GENERAL")

	DialogTopicEnableToggleID = AddToggleOption("$BIS_L_ENABLED_DIALOG_TOPIC", DialogTopicEnabled.GetValue() As Bool)
	AutomateFollowerBathingMenuID = AddMenuOption("$BIS_L_AUTOMATE_FOLLOWER_BATHING", AutomateFollowerBathingArray[AutomateFollowerBathing.GetValue() As Int])
	WaterRestrictionEnableToggleID = AddToggleOption("$BIS_L_WATER_RESTRICT",WaterRestrictionEnabled.GetValue() As Bool)
	UpdateIntervalSliderID = AddSliderOption("$BIS_L_UPDATE_INTERVAL", DirtinessUpdateInterval.GetValue(), DF_Decimal)
	AddHeaderOption("$BIS_HEADER_HOTKEYS")
	CheckStatusKeyMapID = AddKeyMapOption("$BIS_L_STATUS_HOTKEY", CheckStatusKeyCode.GetValue() As Int, OPTION_FLAG_WITH_UNMAP)
	BatheKeyMapID = AddKeyMapOption("$BIS_L_BATHE_HOTKEY", BatheKeyCode.GetValue() As Int, OPTION_FLAG_WITH_UNMAP)
	ModifierKeyMapID = AddKeyMapOption("$BIS_L_MODIFIER_HOTKEY", ModifierKeyCode.GetValue() As Int, OPTION_FLAG_WITH_UNMAP)
	AddHeaderOption("$BIS_HEADER_MISC")
	ShynessDistanceOID_S = AddSliderOption("$BIS_L_SHYNESSDISTANCE", ShynessDistance.GetValue(), DF_Units)
	CleansingSwimOID_S = AddSliderOption("$BIS_L_CLEANSINGSWIM", CleansingSwim.GetValue() * 100, DF_Percentage)
	
	SetCursorPosition(1)
	AddHeaderOption("$BIS_HEADER_DIRT_RATE")
	DirtinessPerHourPlayerHouseSliderID = AddSliderOption("$BIS_L_IN_PLAYERHOUSE", DirtinessPerHourPlayerHouse.GetValue() * 100, DF_Percentage)
	DirtinessPerHourSettlementSliderID = AddSliderOption("$BIS_L_IN_SETTLEMENTS", DirtinessPerHourSettlement.GetValue() * 100, DF_Percentage)
	DirtinessPerHourDungeonSliderID = AddSliderOption("$BIS_L_IN_DUNGEONS", DirtinessPerHourDungeon.GetValue() * 100, DF_Percentage)
	DirtinessPerHourWildernessSliderID = AddSliderOption("$BIS_L_IN_WILDERNESS", DirtinessPerHourWilderness.GetValue() * 100, DF_Percentage)
	AddHeaderOption("$BIS_HEADER_DIRT_THRESHOLDS")
	DirtinessThresholdTier1SliderID = AddSliderOption("$BIS_L_GET_NOT_DIRTY", (DirtinessThresholdList.GetAt(1) As GlobalVariable).GetValue() * 100, DF_Percentage)
	DirtinessThresholdTier2SliderID = AddSliderOption("$BIS_L_GET_SLIGHTLY_DIRTY", (DirtinessThresholdList.GetAt(2) As GlobalVariable).GetValue() * 100, DF_Percentage)
	DirtinessThresholdTier3SliderID = AddSliderOption("$BIS_L_GET_QUITE_DIRTY", (DirtinessThresholdList.GetAt(3) As GlobalVariable).GetValue() * 100, DF_Percentage)
	DirtinessThresholdTier4SliderID = AddSliderOption("$BIS_L_GET_FILTHY", (DirtinessThresholdList.GetAt(4) As GlobalVariable).GetValue() * 100, DF_Percentage)
EndFunction
Function DisplayEffectsPage()
	AddHeaderOption("$BIS_HEADER_SHADERS")
	DirtShaderEnabledOID_T = AddToggleOption("$BIS_L_DIRTSHADERENABLED", DirtShaderEnabled.GetValue() As Bool)

	SetCursorPosition(1)
	AddHeaderOption("$BIS_HEADER_OVERLAYS")
	OverlayApplyAtOID_S = AddSliderOption("$BIS_L_OVERLAYAPPLY", OverlayApplyAt * 100.0, DF_Percentage_Dirt)
	StartingAlphaOID_S = AddSliderOption("$BIS_L_OVERLAYALPHA", StartingAlpha * 100.0, DF_Percentage)
	OverlayTintOID_C = AddColorOption("$BIS_L_OVERLAYTINT", OverlayTint)
	TimeToCleanOID_S = AddSliderOption("$BIS_L_OVERLAYTIMETOCLEAN", TimeToClean, DF_Decimal)
	TimeToCleanIntervalOID_S = AddSliderOption("$BIS_L_OVERLAYTIMETOCLEANINTERVAL", TimeToCleanInterval, DF_Decimal)
	AddEmptyOption()
	TexSetOverrideID = AddTextOption("$BIS_L_OVERLAYTEXSETOVERRIDE", TexSetOverride)
	AddEmptyOption()
	TexSetCountOID_T = AddTextOption("$BIS_L_OVERLAYTEXSETCOUNT_{" + TexUtil.DirtSetCount[0] + "}{" + TexUtil.DirtSetCount[1] + "}", "")
	RedetectDirtSetsOID_T = AddTextOption("$BIS_L_OVERLAYREDETECT", "")
	RemoveAllOverlaysOID_T = AddTextOption("$BIS_L_OVERLAYREMOVEALL", "")
	OverlayProgressOID_T = AddTextOption("", "$BIS_L_INACTIVE")
EndFunction
Function DisplayIntegrationsPage()
	if !ShowIntegrations
		AddTextOption("$BIS_TXT_EMPTY", "", OPTION_FLAG_DISABLED)
	else
		If Init.IsSexLabInstalled || Init.IsOStimInstalled
			AddHeaderOption("$BIS_HEADER_SEX")
			DirtinessPerSexOID_S = AddSliderOption("$BIS_L_DIRTPERSEX", DirtinessPerSexActor * 100.0, DF_Percentage)
			VictimMultOID_S = AddSliderOption("$BIS_L_VICTIMMULT", VictimMult, DF_Decimal)
			FadeDirtSexToggleID = AddToggleOption("$BIS_L_FADEDIRTSEX", FadeDirtSex)
			SexIntervalDirtOID_S = AddSliderOption("$BIS_L_SEXINTERVALDIRT", SexIntervalDirt, DF_Decimal, (!FadeDirtSex) as int)
			SexIntervalOID_S = AddSliderOption("$BIS_L_SEXINTERVAL", SexInterval, DF_Decimal, (!FadeDirtSex) as int)
			SetCursorPosition(1)
			AddHeaderOption("$BIS_HEADER_FADEDIRTSEX")
			AddTextOption("$BIS_L_FADEDIRT_NPCNV_{" + ((DirtinessPerSexActor / SexIntervalDirt) * 100.0) + "}", "", OPTION_FLAG_DISABLED)
			AddTextOption("$BIS_L_FADEDIRT_NPCV_{" + (((DirtinessPerSexActor * VictimMult)/ SexIntervalDirt) * 100.0) + "}", "", OPTION_FLAG_DISABLED)
			AddTextOption("$BIS_L_FADEDIRT_CREATURENV_{" + (((DirtinessPerSexActor * 2) / SexIntervalDirt) * 100.0) + "}", "", OPTION_FLAG_DISABLED)
			AddTextOption("$BIS_L_FADEDIRT_CREATUREV_{" + (((DirtinessPerSexActor * 2 * VictimMult) / SexIntervalDirt) * 100.0) + "}", "", OPTION_FLAG_DISABLED)
			SetCursorPosition(12)
		EndIf
		If Init.IsFadeTattoosInstalled
			AddHeaderOption("$BIS_HEADER_FADE_TATTOOS")
			FadeTatsFadeTimeOID_S = AddSliderOption("$BIS_L_FADETATSADVANCE", FadeTatsFadeTime, DF_Decimal)
			FadeTatsSoapMultOID_S = AddSliderOption("$BIS_L_FADETATSMULT", FadeTatsSoapMult, DF_Decimal)
		EndIf
		If Init.IsWadeInWaterInstalled
			AddHeaderOption("$BIS_HEADER_WATER_DEPTH")
			WadeDetectionOID_T = AddToggleOption("$BIS_L_WADEDETECTION", WadeDetection)
		EndIf
	endIf
EndFunction
Function DisplayTrackedActorsPage()
	AddHeaderOption("$BIS_HEADER_TARGETED_ACTOR")
	CrosshairActor = Game.GetCurrentCrosshairRef() as Actor
	If !(CrosshairActor && CrosshairActor.HasKeyword(ActorTypeNPC))
		AddTextOption("$BIS_TXT_EMPTY", "", OPTION_FLAG_DISABLED)
	Else
		String DisplayString = ""
		If BatheQuest.HasGDOTSpell(CrosshairActor)
			DisplayString = "$BIS_BUTTON_UNTRACK"
		Else
			DisplayString = "$BIS_BUTTON_TRACK"
		EndIF
		TargetedActorControlOID = AddTextOption(CrosshairActor.GetActorBase().GetName(), DisplayString)
	EndIf

	AddHeaderOption("$BIS_HEADER_TRACKED_ACTORS")
	TrackedActors = GetMatchingActor(GetAllActorsInFaction(TrackedBatherFaction), GetActorsByProcessingLevel(0))
	If TrackedActors.Length < 128
		TrackedActorsToggleIDs = Utility.CreateIntArray(TrackedActors.Length)
	Else
		TrackedActorsToggleIDs = new Int[128]
	EndIf
	If !TrackedActors.Length
		AddTextOption("$BIS_TXT_EMPTY", "", OPTION_FLAG_DISABLED)
	Else
		Int Index = 0
		While Index < TrackedActorsToggleIDs.Length
			Actor DirtyActor = TrackedActors[Index]
			String DirtinessString = ""
			If DirtyActor.HasSpell(DirtinessSpellList.GetAt(0) As Spell)
				DirtinessString = "$BIS_TXT_CLEAN"
			ElseIf DirtyActor.HasSpell(DirtinessSpellList.GetAt(1) As Spell)
				DirtinessString = "$BIS_TXT_NOTDIRTY"
			ElseIf DirtyActor.HasSpell(DirtinessSpellList.GetAt(2) As Spell)
				DirtinessString = "$BIS_TXT_SLIGHTLYDIRTY"
			ElseIf DirtyActor.HasSpell(DirtinessSpellList.GetAt(3) As Spell)
				DirtinessString = "$BIS_TXT_QUITEDIRTY"
			ElseIf DirtyActor.HasSpell(DirtinessSpellList.GetAt(4) As Spell)
				DirtinessString = "$BIS_TXT_FILTHY"
			Else
				DirtinessString = "$BIS_TXT_MISSINGSPELL"
			EndIf
			TrackedActorsToggleIDs[Index] = AddTextOption(DirtyActor.GetActorBase().GetName(), DirtinessString, OPTION_FLAG_NONE)
			Index += 1
		EndWhile
	EndIf
EndFunction
Function DisplayAuxiliaryPage()
	AddHeaderOption("$BIS_HEADER_DEBUG")
	ResetMenuOID_T = AddTextOption("$BIS_L_RESETMENU", "")
	StopAnimationsOID_T = AddTextOption("$BIS_L_STOPANIMATIONS", "")
	UnForbidOID_T = AddTextOption("$BIS_L_UNFORBID", "")
	AddEmptyOption()
	AddHeaderOption("$BIS_HEADER_ADVANCED_SETTINGS")
	GameMessageID_T = AddToggleOption("$BIS_L_GAMEMESSAGE", GameMessage)
	LogNotificationID_T = AddToggleOption("$BIS_L_LOGNOTIFICATION", LogNotification)
	LogTraceID_T = AddToggleOption("$BIS_L_LOGTRACE", LogTrace)
	ConfigWarnID_T = AddToggleOption("$BIS_L_CONFIGWARN", ConfigWarn)
	SkipItemHashID_T = AddToggleOption("$BIS_L_SKIPITEMHASH", SkipItemHash)
	
	SetCursorPosition(1)

	AddHeaderOption("$BIS_HEADER_HARD_DEPENDENCIES")
	AddTextOption("$BIS_L_PAPYUTIL", init.PAPYUTILstate)
	AddTextOption("$BIS_L_PO3PE", init.PO3PEstate)
	AddTextOption("$BIS_L_SKEE64", init.SKEE64state)
	AddTextOption("$BIS_L_SPE", init.SPEstate)
	if cachedSoftCheck
		AddEmptyOption()
		AddHeaderOption("$BIS_HEADER_AVAILABLE_INTEGRATIONS")
		if init.IsDeviousDevicesInstalled
			AddTextOption("$BIS_L_DeviousDevices", "")
		endIf
		if init.IsFadeTattoosInstalled
			AddTextOption("$BIS_L_FadeTattoos", "")
		endIf
		if init.IsFrostFallInstalled
			AddTextOption("$BIS_L_FrostFall", "")
		endIf
		if init.IsOCumInstalled
			AddTextOption("$BIS_L_OCum", "")
		endIf
		if init.IsOStimInstalled
			AddTextOption("$BIS_L_OStim", "")
		endIf
		if init.IsSexLabInstalled
			AddTextOption("$BIS_L_SexLab", "")
		endIf
		if init.IsSexLabArousedInstalled
			AddTextOption("$BIS_L_SexLabAroused", "")
		endIf
		if init.IsWadeInWaterInstalled
			AddTextOption("$BIS_L_WadeInWater", "")
		endIf
	endIf
EndFunction

; OnOptionDefault
Event OnOptionDefault(Int OptionID)
	If CurrentPage == "$BIS_PAGE_SETTINGS"
		HandleOnOptionDefaultSettingsPage(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_EFFECTS"
		HandleOnOptionDefaultEffectsPage(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_ANIMATIONS"
		HandleOnOptionDefaultAnimationsPage(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_ANIMATIONS_FOLLOWERS"
		HandleOnOptionDefaultAnimationsPageFollowers(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_TRACKED_ACTORS"
		HandleOnOptionDefaultTrackedActorsPage(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_INTEGRATIONS"
		HandleOnOptionDefaultIntegrationsPage(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_AUXILIARY"
		HandleOnOptionDefaultAuxiliaryPage(OptionID)
	EndIf
EndEvent
Function HandleOnOptionDefaultAnimationsPage(Int OptionID)
	; menus
	If OptionID == BathingAnimationStyleMenuID
		BathingAnimationStyle.SetValue(1)
		SetMenuOptionValue(OptionID, BathingAnimationStyleArray[BathingAnimationStyle.GetValue() As Int], true)
		ForcePageReset()
	ElseIf OptionID == ShoweringAnimationStyleMenuID
		ShoweringAnimationStyle.SetValue(1)
		SetMenuOptionValue(OptionID, ShoweringAnimationStyleArray[ShoweringAnimationStyle.GetValue() As Int], true)
		ForcePageReset()
	ElseIf OptionID == GetSoapyStyleMenuID
		GetSoapyStyle.SetValue(1)
		SetMenuOptionValue(OptionID, GetSoapyStyleArray[GetSoapyStyle.GetValue() As Int])
	ElseIf OptionID == AnimCustomTierCondMenuID
		AnimCustomTierCond = 1
		SetMenuOptionValue(OptionID, AnimCustomTierCondArray[AnimCustomTierCond])

	; sliders
	ElseIf OptionID == BathingAnimationLoopsTier0SliderID
		(BathingAnimationLoopCountList.GetAt(0) As GlobalVariable).SetValue(1)
		SetSliderOptionValue(OptionID, (BathingAnimationLoopCountList.GetAt(0) As GlobalVariable).GetValue(), "{0}")
	ElseIf OptionID == BathingAnimationLoopsTier1SliderID
		(BathingAnimationLoopCountList.GetAt(1) As GlobalVariable).SetValue(1)
		SetSliderOptionValue(OptionID, (BathingAnimationLoopCountList.GetAt(1) As GlobalVariable).GetValue(), "{0}")
	ElseIf OptionID == BathingAnimationLoopsTier2SliderID
		(BathingAnimationLoopCountList.GetAt(2) As GlobalVariable).SetValue(1)
		SetSliderOptionValue(OptionID, (BathingAnimationLoopCountList.GetAt(2) As GlobalVariable).GetValue(), "{0}")
	ElseIf OptionID == BathingAnimationLoopsTier3SliderID
		(BathingAnimationLoopCountList.GetAt(3) As GlobalVariable).SetValue(1)
		SetSliderOptionValue(OptionID, (BathingAnimationLoopCountList.GetAt(3) As GlobalVariable).GetValue(), "{0}")
	ElseIf OptionID == BathingAnimationLoopsTier4SliderID
		(BathingAnimationLoopCountList.GetAt(4) As GlobalVariable).SetValue(1)
		SetSliderOptionValue(OptionID, (BathingAnimationLoopCountList.GetAt(4) As GlobalVariable).GetValue(), "{0}")
	
	ElseIf OptionID == AnimCustomMSet1SliderID
		AnimCustomMSet1Freq = 0
		AnimCustomMSet[0] = AnimCustomMSet1Freq
		SetSliderOptionValue(OptionID, AnimCustomMSet1Freq, "{0}")
	ElseIf OptionID == AnimCustomFSet1SliderID
		AnimCustomFSet1Freq = 0
		AnimCustomFSet[0] = AnimCustomFSet1Freq
		SetSliderOptionValue(OptionID, AnimCustomFSet1Freq, "{0}")
	ElseIf OptionID == AnimCustomFSet2SliderID
		AnimCustomFSet2Freq = 0
		AnimCustomFSet[1] = AnimCustomFSet2Freq
		SetSliderOptionValue(OptionID, AnimCustomFSet2Freq, "{0}")
	ElseIf OptionID == AnimCustomFSet3SliderID
		AnimCustomFSet3Freq = 0
		AnimCustomFSet[2] = AnimCustomFSet3Freq
		SetSliderOptionValue(OptionID, AnimCustomFSet3Freq, "{0}")

	; toggles
	ElseIf OptionID == AutoHideUIID
		AutoHideUI = True
	ElseIf OptionID == AutoPlayerTFCID
		AutoPlayerTFC = False
	ElseIf OptionID == GetDressedAfterBathingEnabledToggleID
		GetDressedAfterBathingEnabled.SetValue(1)
		SetToggleOptionValue(OptionID, GetDressedAfterBathingEnabled.GetValue() As Bool)
	Else 
		Int UndressArmorSlotIndex = UndressArmorSlotToggleIDs.Find(OptionID)
		If UndressArmorSlotIndex >= 0
			If UndressArmorSlotIndex <= 13 ; undress 30-43 by default
				ArmorSlotArray[UndressArmorSlotIndex] = UndressArmorSlotIndex + 30
				SetToggleOptionValue(OptionID, True)
			Else ; ignore 44-62 by default
				ArmorSlotArray[UndressArmorSlotIndex] = 0
				SetToggleOptionValue(OptionID, False)
			EndIf
		EndIf
	EndIf	
EndFunction
Function HandleOnOptionDefaultAnimationsPageFollowers(Int OptionID)	
	; menus
	If OptionID == BathingAnimationStyleMenuIDFollowers
		BathingAnimationStyleFollowers.SetValue(1)
		SetMenuOptionValue(OptionID, BathingAnimationStyleArray[BathingAnimationStyleFollowers.GetValue() As Int], true)
		ForcePageReset()
	ElseIf OptionID == ShoweringAnimationStyleMenuIDFollowers
		ShoweringAnimationStyleFollowers.SetValue(0)
		SetMenuOptionValue(OptionID, ShoweringAnimationStyleArray[ShoweringAnimationStyleFollowers.GetValue() As Int], true)
		ForcePageReset()
	ElseIf OptionID == GetSoapyStyleMenuIDFollowers
		GetSoapyStyleFollowers.SetValue(1)
		SetMenuOptionValue(OptionID, GetSoapyStyleArray[GetSoapyStyleFollowers.GetValue() As Int])
	ElseIf OptionID == AnimCustomTierCondMenuIDFollowers
		AnimCustomTierCondFollowers = 1
		SetMenuOptionValue(OptionID, AnimCustomTierCondArray[AnimCustomTierCondFollowers])

	; sliders
	ElseIf OptionID == BathingAnimationLoopsTier0SliderIDFollowers
		(BathingAnimationLoopCountListFollowers.GetAt(0) As GlobalVariable).SetValue(1)
		SetSliderOptionValue(OptionID, (BathingAnimationLoopCountListFollowers.GetAt(0) As GlobalVariable).GetValue(), "{0}")
	ElseIf OptionID == BathingAnimationLoopsTier1SliderIDFollowers
		(BathingAnimationLoopCountListFollowers.GetAt(1) As GlobalVariable).SetValue(1)
		SetSliderOptionValue(OptionID, (BathingAnimationLoopCountListFollowers.GetAt(1) As GlobalVariable).GetValue(), "{0}")
	ElseIf OptionID == BathingAnimationLoopsTier2SliderIDFollowers
		(BathingAnimationLoopCountListFollowers.GetAt(2) As GlobalVariable).SetValue(1)
		SetSliderOptionValue(OptionID, (BathingAnimationLoopCountListFollowers.GetAt(2) As GlobalVariable).GetValue(), "{0}")
	ElseIf OptionID == BathingAnimationLoopsTier3SliderIDFollowers
		(BathingAnimationLoopCountListFollowers.GetAt(3) As GlobalVariable).SetValue(1)
		SetSliderOptionValue(OptionID, (BathingAnimationLoopCountListFollowers.GetAt(3) As GlobalVariable).GetValue(), "{0}")
	ElseIf OptionID == BathingAnimationLoopsTier4SliderIDFollowers
		(BathingAnimationLoopCountListFollowers.GetAt(4) As GlobalVariable).SetValue(1)
		SetSliderOptionValue(OptionID, (BathingAnimationLoopCountListFollowers.GetAt(4) As GlobalVariable).GetValue(), "{0}")

	ElseIf OptionID == AnimCustomMSet1SliderIDFollowers
		AnimCustomMSet1FreqFollowers = 0
		AnimCustomMSetFollowers[0] = AnimCustomMSet1FreqFollowers
		SetSliderOptionValue(OptionID, AnimCustomMSet1FreqFollowers, "{0}")
	ElseIf OptionID == AnimCustomFSet1SliderIDFollowers
		AnimCustomFSet1FreqFollowers = 0
		AnimCustomFSetFollowers[0] = AnimCustomFSet1FreqFollowers
		SetSliderOptionValue(OptionID, AnimCustomFSet1FreqFollowers, "{0}")
	ElseIf OptionID == AnimCustomFSet2SliderIDFollowers
		AnimCustomFSet2FreqFollowers = 0
		AnimCustomFSetFollowers[1] = AnimCustomFSet2FreqFollowers
		SetSliderOptionValue(OptionID, AnimCustomFSet2FreqFollowers, "{0}")
	ElseIf OptionID == AnimCustomFSet3SliderIDFollowers
		AnimCustomFSet3FreqFollowers = 0
		AnimCustomFSetFollowers[2] = AnimCustomFSet3FreqFollowers
		SetSliderOptionValue(OptionID, AnimCustomFSet3FreqFollowers, "{0}")

	; toggles
	ElseIf OptionID == GetDressedAfterBathingEnabledToggleIDFollowers
		GetDressedAfterBathingEnabledFollowers.SetValue(1)
		SetToggleOptionValue(OptionID, GetDressedAfterBathingEnabledFollowers.GetValue() As Bool)
	Else 
		Int UndressArmorSlotIndex = UndressArmorSlotToggleIDsFollowers.Find(OptionID)
		If UndressArmorSlotIndex >= 0
			If UndressArmorSlotIndex <= 13 ; undress 30-43 by default
				ArmorSlotArrayFollowers[UndressArmorSlotIndex] = UndressArmorSlotIndex + 30
				SetToggleOptionValue(OptionID, True)
			Else ; ignore 44-62 by default
				ArmorSlotArrayFollowers[UndressArmorSlotIndex] = 0
				SetToggleOptionValue(OptionID, False)
			EndIf
		EndIf
	EndIf	
EndFunction
Function HandleOnOptionDefaultSettingsPage(Int OptionID)
	; toggles
	If OptionID == DialogTopicEnableToggleID
		DialogTopicEnabled.SetValue(1)
		SetToggleOptionValue(OptionID, DialogTopicEnabled.GetValue() As Bool)
	ElseIf OptionID == WaterRestrictionEnableToggleID
		WaterRestrictionEnabled.SetValue(1)
		SetToggleOptionValue(OptionID, WaterRestrictionEnabled.GetValue() As Bool)
	; sliders
	ElseIf OptionID == UpdateIntervalSliderID
		DirtinessUpdateInterval.SetValue(1.0)
		SetSliderOptionValue(OptionID, DirtinessUpdateInterval.GetValue(), DF_Decimal)
	ElseIf OptionID == DirtinessPerHourPlayerHouseSliderID
		DirtinessPerHourPlayerHouse.SetValue(0.00)
		SetSliderOptionValue(OptionID, DirtinessPerHourPlayerHouse.GetValue() * 100, DF_Percentage)
	ElseIf OptionID == DirtinessPerHourSettlementSliderID
		DirtinessPerHourSettlement.SetValue(0.01)
		SetSliderOptionValue(OptionID, DirtinessPerHourSettlement.GetValue() * 100, DF_Percentage)
	ElseIf OptionID == DirtinessPerHourDungeonSliderID
		DirtinessPerHourDungeon.SetValue(0.025)
		SetSliderOptionValue(OptionID, DirtinessPerHourDungeon.GetValue() * 100, DF_Percentage)
	ElseIf OptionID == DirtinessPerHourWildernessSliderID
		DirtinessPerHourWilderness.SetValue(0.015)
		SetSliderOptionValue(OptionID, DirtinessPerHourWilderness.GetValue() * 100, DF_Percentage)
	ElseIf OptionID == DirtinessThresholdTier1SliderID
		(DirtinessThresholdList.GetAt(1) As GlobalVariable).SetValue(ClampDirtinessThreshold(1, 0.20))
		SetSliderOptionValue(OptionID, (DirtinessThresholdList.GetAt(1) As GlobalVariable).GetValue() * 100, DF_Percentage)
	ElseIf OptionID == DirtinessThresholdTier2SliderID
		(DirtinessThresholdList.GetAt(2) As GlobalVariable).SetValue(ClampDirtinessThreshold(2, 0.60))
		SetSliderOptionValue(OptionID, (DirtinessThresholdList.GetAt(2) As GlobalVariable).GetValue() * 100, DF_Percentage)
	ElseIf OptionID == DirtinessThresholdTier3SliderID
		(DirtinessThresholdList.GetAt(3) As GlobalVariable).SetValue(ClampDirtinessThreshold(3, 0.98))
		SetSliderOptionValue(OptionID, (DirtinessThresholdList.GetAt(3) As GlobalVariable).GetValue() * 100, DF_Percentage)
	ElseIf OptionID == DirtinessThresholdTier4SliderID
		(DirtinessThresholdList.GetAt(4) As GlobalVariable).SetValue(ClampDirtinessThreshold(4, 1.00))
		SetSliderOptionValue(OptionID, (DirtinessThresholdList.GetAt(4) As GlobalVariable).GetValue() * 100, DF_Percentage)
	ElseIf OptionID == ShynessDistanceOID_S
		ShynessDistance.SetValue(0.0)
		SetSliderOptionValue(OptionID, ShynessDistance.GetValue(), DF_Units)
	ElseIf OptionID == CleansingSwimOID_S
		CleansingSwim.SetValue(0.2)
		SetSliderOptionValue(OptionID, CleansingSwim.GetValue() * 100, DF_Percentage)
	; menus
	ElseIf OptionID == AutomateFollowerBathingMenuID
		AutomateFollowerBathing.SetValue(1)
		SetMenuOptionValue(OptionID, AutomateFollowerBathingArray[AutomateFollowerBathing.GetValue() As Int])
	; hotkeys
	ElseIf OptionID == CheckStatusKeyMapID
		CheckStatusKeyCode.SetValue(-1)
		BathePlayer.RegisterHotKeys()
		SetKeymapOptionValue(OptionID, CheckStatusKeyCode.GetValue() as int)
	ElseIf OptionID == BatheKeyMapID
		BatheKeyCode.SetValue(-1)
		BathePlayer.RegisterHotKeys()
		SetKeymapOptionValue(OptionID, BatheKeyCode.GetValue() as int)
	ElseIf OptionID == ModifierKeyMapID
		ModifierKeyCode.SetValue(-1)
		SetKeymapOptionValue(OptionID, ModifierKeyCode.GetValue() as int)
	EndIf
EndFunction
Function HandleOnOptionDefaultEffectsPage(Int OptionID)
	If OptionID == DirtShaderEnabledOID_T
		DirtShaderEnabled.SetValue(1.0)
		SetToggleOptionValue(OptionID, DirtShaderEnabled.GetValue() as Bool)
	ElseIf OptionID == OverlayTintOID_C
		OverlayTint = 0xFFFFFF
		SetColorOptionValue(OptionID, 0xFFFFFF)
	ElseIf OptionID == TexSetOverrideID
		TexSetOverride = false
		SetTextOptionValue(OptionID, TexSetOverride)
	EndIf
EndFunction
Function HandleOnOptionDefaultTrackedActorsPage(Int OptionID)
EndFunction
Function HandleOnOptionDefaultIntegrationsPage(Int OptionID)
	If OptionID == FadeDirtSexToggleID
		FadeDirtSex = true
		SetOptionFlags(SexIntervalDirtOID_S, OPTION_FLAG_NONE, true)
		SetOptionFlags(SexIntervalOID_S, OPTION_FLAG_NONE, true)
		SetToggleOptionValue(OptionID, FadeDirtSex)
	ElseIf OptionID == SexIntervalDirtOID_S
		SexIntervalDirt = 35.0
		SetSliderOptionValue(OptionID, SexIntervalDirt, DF_Decimal)
	ElseIf OptionID == SexIntervalOID_S
		SexIntervalDirt = 1.0
		SetSliderOptionValue(OptionID, SexIntervalDirt, DF_Decimal)
	ElseIf OptionID == WadeDetectionOID_T
		WadeDetection = true
		SetToggleOptionValue(OptionID, WadeDetection)
	EndIf
EndFunction
Function HandleOnOptionDefaultAuxiliaryPage(Int OptionID)
	If OptionID == GameMessageID_T
		GameMessage = true
		SetToggleOptionValue(OptionID, GameMessage)
	ElseIf OptionID == LogNotificationID_T
		LogNotification = true
		SetToggleOptionValue(OptionID, LogNotification)
	ElseIf OptionID == LogTraceID_T
		LogTrace = false
		SetToggleOptionValue(OptionID, LogTrace)
	ElseIf OptionID == ConfigWarnID_T
		ConfigWarn = true
		SetToggleOptionValue(OptionID, ConfigWarn)
	ElseIf OptionID == SkipItemHashID_T
		SkipItemHash = false
		SetToggleOptionValue(OptionID, SkipItemHash)
	Endif
EndFunction

; OnOptionHighlight
Event OnOptionHighlight(Int OptionID)
	If CurrentPage == "$BIS_PAGE_SYSTEM_OVERVIEW" || CurrentPage == ""
		HandleOnOptionHighlightSystemOverviewPage(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_SETTINGS"
		HandleOnOptionHighlightSettingsPage(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_EFFECTS"
		HandleOnOptionHighlightEffectsPage(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_ANIMATIONS"
		HandleOnOptionHighlightAnimationsPage(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_ANIMATIONS_FOLLOWERS"
		HandleOnOptionHighlightAnimationsPageFollowers(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_TRACKED_ACTORS"
		HandleOnOptionHighlightTrackedActorsPage(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_INTEGRATIONS"
		HandleOnOptionHighlightIntegrationsPage(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_AUXILIARY"
		HandleOnOptionHighlightAuxiliaryPage(OptionID)
	EndIf	
EndEvent
Function HandleOnOptionHighlightAnimationsPage(Int OptionID)
	If OptionID == BathingAnimationStyleMenuID
		SetInfoText("$BIS_DESC_ANIM_STYLE")
	ElseIf OptionID == ShoweringAnimationStyleMenuID
		SetInfoText("$BIS_DESC_OVDE_STYLE")
	ElseIf OptionID == GetSoapyStyleMenuID
		SetInfoText("$BIS_DESC_SOAP_STYLE")
	ElseIf OptionID == AutoHideUIID
		SetInfoText("$BIS_DESC_AUTOHIDEUI")
	ElseIf OptionID == AutoPlayerTFCID
		SetInfoText("$BIS_DESC_AUTOPLAYERTFC")
	ElseIf OptionID == BathingAnimationLoopsTier0SliderID
		SetInfoText("$BIS_DESC_ANIM_LOOP_TIER0")
	ElseIf OptionID == BathingAnimationLoopsTier1SliderID
		SetInfoText("$BIS_DESC_ANIM_LOOP_TIER1")
	ElseIf OptionID == BathingAnimationLoopsTier2SliderID
		SetInfoText("$BIS_DESC_ANIM_LOOP_TIER2")
	ElseIf OptionID == BathingAnimationLoopsTier3SliderID
		SetInfoText("$BIS_DESC_ANIM_LOOP_TIER3")
	ElseIf OptionID == BathingAnimationLoopsTier4SliderID
		SetInfoText("$BIS_DESC_ANIM_LOOP_TIER4")
	ElseIf OptionID == AnimCustomMSet1SliderID
		SetInfoText("$BIS_DESC_ANIM_STYLE_CUSTOM_MSet1")
	ElseIf OptionID == AnimCustomFSet1SliderID
		SetInfoText("$BIS_DESC_ANIM_STYLE_CUSTOM_FSet1")
	ElseIf OptionID == AnimCustomFSet2SliderID
		SetInfoText("$BIS_DESC_ANIM_STYLE_CUSTOM_FSet2")
	ElseIf OptionID == AnimCustomFSet3SliderID
		SetInfoText("$BIS_DESC_ANIM_STYLE_CUSTOM_FSet3")
	ElseIf OptionID == AnimCustomTierCondMenuID
		SetInfoText("$BIS_DESC_ANIM_TIERCOND")
	ElseIf OptionID == GetDressedAfterBathingEnabledToggleID
		SetInfoText("$BIS_DESC_GET_DRESSED")
	Else
		int index = UndressArmorSlotToggleIDs.Find(OptionID)
		if index != -1
			Armor equippedArmor = PlayerRef.GetEquippedArmorInSlot(ArmorSlotArray[index])
			if equippedArmor && equippedArmor.GetName() != ""
				SetInfoText("$BIS_DESC_GET_NAKED_{" + equippedArmor.GetName() + "}")
			else
				SetInfoText("$BIS_DESC_GET_NAKED")
			endIf
		endIf
	EndIf
EndFunction
Function HandleOnOptionHighlightAnimationsPageFollowers(Int OptionID)
	If OptionID == BathingAnimationStyleMenuIDFollowers
		SetInfoText("$BIS_DESC_ANIM_STYLE")
	ElseIf OptionID == ShoweringAnimationStyleMenuIDFollowers
		SetInfoText("$BIS_DESC_OVDE_STYLE")
	ElseIf OptionID == GetSoapyStyleMenuIDFollowers
		SetInfoText("$BIS_DESC_SOAP_STYLE")
	ElseIf OptionID == BathingAnimationLoopsTier0SliderIDFollowers
		SetInfoText("$BIS_DESC_ANIM_LOOP_TIER0")
	ElseIf OptionID == BathingAnimationLoopsTier1SliderIDFollowers
		SetInfoText("$BIS_DESC_ANIM_LOOP_TIER1")
	ElseIf OptionID == BathingAnimationLoopsTier2SliderIDFollowers
		SetInfoText("$BIS_DESC_ANIM_LOOP_TIER2")
	ElseIf OptionID == BathingAnimationLoopsTier3SliderIDFollowers
		SetInfoText("$BIS_DESC_ANIM_LOOP_TIER3")
	ElseIf OptionID == BathingAnimationLoopsTier4SliderIDFollowers
		SetInfoText("$BIS_DESC_ANIM_LOOP_TIER4")
	ElseIf OptionID == AnimCustomMSet1SliderIDFollowers
		SetInfoText("$BIS_DESC_ANIM_STYLE_CUSTOM_MSet1")
	ElseIf OptionID == AnimCustomFSet1SliderIDFollowers
		SetInfoText("$BIS_DESC_ANIM_STYLE_CUSTOM_FSet1")
	ElseIf OptionID == AnimCustomFSet2SliderIDFollowers
		SetInfoText("$BIS_DESC_ANIM_STYLE_CUSTOM_FSet2")
	ElseIf OptionID == AnimCustomFSet3SliderIDFollowers
		SetInfoText("$BIS_DESC_ANIM_STYLE_CUSTOM_FSet3")
	ElseIf OptionID == AnimCustomTierCondMenuIDFollowers
		SetInfoText("$BIS_DESC_ANIM_TIERCOND")
	ElseIf OptionID == GetDressedAfterBathingEnabledToggleIDFollowers
		SetInfoText("$BIS_DESC_GET_DRESSED")
	ElseIf UndressArmorSlotToggleIDsFollowers.Find(OptionID) != -1
		SetInfoText("$BIS_DESC_GET_NAKED")
	EndIf
EndFunction
Function HandleOnOptionHighlightSystemOverviewPage(Int OptionID)
	If OptionID == ModStateOID_T
		SetInfoText("$BIS_DESC_ENABLE_MOD")
	ElseIf OptionID == PapSetSaveOID_T
		SetInfoText("$BIS_DESC_SAVE_SETTINGS")
	ElseIf OptionID == PapSetLoadOID_T
		SetInfoText("$BIS_DESC_LOAD_SETTINGS")
	EndIf
EndFunction
Function HandleOnOptionHighlightSettingsPage(Int OptionID)
	If OptionID == DialogTopicEnableToggleID
		SetInfoText("$BIS_DESC_ENABLE_DIALOG_TOPIC")
	ElseIf OptionID == AutomateFollowerBathingMenuID
		SetInfoText("$BIS_DESC_AUTOMATE_FOLLOWER_BATHING")
	ElseIf OptionID == WaterRestrictionEnableToggleID
		SetInfoText("$BIS_DESC_WATER_RESTRICT")
	ElseIf OptionID == UpdateIntervalSliderID
		SetInfoText("$BIS_DESC_UPDATE_INTERVAL")
	ElseIf OptionID == CheckStatusKeyMapID
		SetInfoText("$BIS_DESC_STATUS_HOTKEY")
	ElseIf OptionID == BatheKeyMapID
		SetInfoText("$BIS_DESC_BATHE_HOTKEY")
	ElseIf OptionID == ModifierKeyMapID
		SetInfoText("$BIS_DESC_MODIFIER_HOTKEY")
	ElseIf OptionID == DirtinessPerHourPlayerHouseSliderID
		SetInfoText("$BIS_DESC_RATE_IN_PLAYERHOUSE")
	ElseIf OptionID == DirtinessPerHourSettlementSliderID
		SetInfoText("$BIS_DESC_RATE_IN_SETTLEMENT")
	ElseIf OptionID == DirtinessPerHourDungeonSliderID
		SetInfoText("$BIS_DESC_RATE_IN_DUNGEON")
	ElseIf OptionID == DirtinessPerHourWildernessSliderID
		SetInfoText("$BIS_DESC_RATE_IN_WILDERNESS")
	ElseIf OptionID == DirtinessThresholdTier1SliderID
		SetInfoText("$BIS_DESC_THRESHOLD_1")
	ElseIf OptionID == DirtinessThresholdTier2SliderID
		SetInfoText("$BIS_DESC_THRESHOLD_2")
	ElseIf OptionID == DirtinessThresholdTier3SliderID
		SetInfoText("$BIS_DESC_THRESHOLD_3")
	ElseIf OptionID == DirtinessThresholdTier4SliderID
		SetInfoText("$BIS_DESC_THRESHOLD_4")
	ElseIf OptionID == ShynessDistanceOID_S
		SetInfoText("$BIS_DESC_SHYNESSDISTANCE")
	ElseIf OptionID == CleansingSwimOID_S
		SetInfoText("$BIS_DESC_CLEANSINGSWIM")
	EndIf
EndFunction
Function HandleOnOptionHighlightEffectsPage(int OptionID)
	If OptionID == DirtShaderEnabledOID_T
		SetInfoText("$BIS_DESC_DIRTSHADERENABLED")
	ElseIf OptionID == OverlayApplyAtOID_S
		SetInfoText("$BIS_DESC_OVERLAYAPPLY")
	ElseIf OptionID == StartingAlphaOID_S
		SetInfoText("$BIS_DESC_OVERLAYALPHA")
	ElseIf OptionID == OverlayTintOID_C
		SetInfoText("$BIS_DESC_OVERLAYTINT")
	ElseIf OptionID == TimeToCleanOID_S
		SetInfoText("$BIS_DESC_TIMETOCLEAN")
	ElseIf OptionID == TimeToCleanIntervalOID_S
		SetInfoText("$BIS_DESC_TIMETOCLEANINTERVAL")
	ElseIf OptionID == TexSetOverrideID
		SetInfoText("$BIS_DESC_TEXSETOVERRIDE")
	ElseIf OptionID == TexSetCountOID_T
		SetInfoText("$BIS_DESC_OVERLAYTEXSETCOUNT")
	ElseIf OptionID == RedetectDirtSetsOID_T
		SetInfoText("$BIS_DESC_OVERLAYREDETECT")
	ElseIf OptionID == RemoveAllOverlaysOID_T
		SetInfoText("$BIS_DESC_OVERLAYREMOVEALL")
	ElseIf OptionID == OverlayProgressOID_T
		SetInfoText("$BIS_DESC_OVERLAYPROGRESS")
	EndIf
EndFunction
Function HandleOnOptionHighlightIntegrationsPage(int OptionID)
	If OptionID == DirtinessPerSexOID_S
		SetInfoText("$BIS_DESC_DIRTPERSEX")
	ElseIf OptionID == VictimMultOID_S
		SetInfoText("$BIS_DESC_VICTIMMULT")
	ElseIf OptionID == FadeDirtSexToggleID
		SetInfoText("$BIS_DESC_FADEDIRTSEX")
	ElseIf OptionID == SexIntervalDirtOID_S
		SetInfoText("$BIS_DESC_SEXINTERVALDIRT")
	ElseIf OptionID == SexIntervalOID_S
		SetInfoText("$BIS_DESC_SEXINTERVAL")

	ElseIf OptionID == FadeTatsFadeTimeOID_S
		SetInfoText("$BIS_DESC_FADETATSADVANCE")
	ElseIf OptionID == FadeTatsSoapMultOID_S
		SetInfoText("$BIS_DESC_FADETATSMULT")

	ElseIf OptionID == WadeDetectionOID_T
		SetInfoText("$BIS_DESC_WADEDETECTION")
	EndIf
EndFunction
Function HandleOnOptionHighlightTrackedActorsPage(Int OptionID)
	If OptionID == TargetedActorControlOID
		SetInfoText("$BIS_DESC_MOD_TARGETED_ACTOR")
	ElseIf TrackedActorsToggleIDs.Find(OptionID) != -1
		SetInfoText("$BIS_DESC_STOP_TRACKING_ACTOR")
	EndIf
EndFunction
Function HandleOnOptionHighlightAuxiliaryPage(Int OptionID)
	If OptionID == ResetMenuOID_T
		SetInfoText("$BIS_DESC_RESETMENU")
	ElseIf OptionID == StopAnimationsOID_T
		SetInfoText("$BIS_DESC_STOPANIMATIONS")
	ElseIf OptionID == UnForbidOID_T
		SetInfoText("$BIS_DESC_UNFORBID")
	ElseIf OptionID == ConfigWarnID_T
		SetInfoText("$BIS_DESC_CONFIGWARN")
	ElseIf OptionID == SkipItemHashID_T
		SetInfoText("$BIS_DESC_SKIPITEMHASH")
	endIf
EndFunction

; OnOptionKeyMapChange
Event OnOptionKeyMapChange(Int OptionID, Int KeyCode, String ConflictControl, String ConflictName)
	Bool Continue = True
	
	If ConflictControl != ""
		
		If ConflictName != ""
			ConflictName = "(" + ConflictName + ")"
		EndIf

		Continue = ShowMessage("$BIS_MSG_KEYMAPCONFLICT_{" + ConflictControl + "}{" + ConflictName + "}", True)		
	EndIf
	
	If Continue
		If OptionID == CheckStatusKeyMapID
			BathePlayer.UnregisterForKey(CheckStatusKeyCode.GetValue() as int)
			CheckStatusKeyCode.SetValue(KeyCode)
			BathePlayer.RegisterForKey(KeyCode)
		ElseIf OptionID == BatheKeyMapID
			BathePlayer.UnregisterForKey(BatheKeyCode.GetValue() as int)
			BatheKeyCode.SetValue(KeyCode)
			BathePlayer.RegisterForKey(KeyCode)
		ElseIf OptionID == ModifierKeyMapID
			ModifierKeyCode.SetValue(KeyCode)
		EndIf
		SetKeymapOptionValue(OptionID, KeyCode)
	EndIf
EndEvent

String Function GetCustomControl(int keyCode)
	If keyCode == CheckStatusKeyCode.GetValue()
		Return "$BIS_L_STATUS_HOTKEY"
	ElseIf keyCode == BatheKeyCode.GetValue()
		Return "$BIS_L_BATHE_HOTKEY"
	ElseIf keyCode == ModifierKeyCode.GetValue()
		Return "$BIS_L_MODIFIER_HOTKEY"
	EndIf
EndFunction

; OnOptionColorOpen
Event OnOptionColorOpen(Int OptionID)
	If CurrentPage == "$BIS_PAGE_EFFECTS"
		HandleOnOptionColorOpenEffectsPage(OptionID)
	EndIf
EndEvent
Function HandleOnOptionColorOpenEffectsPage(Int OptionID)
	If OptionID == OverlayTintOID_C
		SetColorDialogStartColor(OverlayTint)
		SetColorDialogDefaultColor(0xFFFFFF)
	EndIf
EndFunction
; OnOptionColorAccept
Event OnOptionColorAccept(Int OptionID, Int Color)
	If CurrentPage == "$BIS_PAGE_EFFECTS"
		HandleOnOptionColorAcceptEffectsPage(OptionID, Color)
	EndIf
EndEvent
Function HandleOnOptionColorAcceptEffectsPage(Int OptionID, Int Color)
	If OptionID == OverlayTintOID_C
		OverlayTint = Color
	EndIf
	SetColorOptionValue(OptionID, Color)
EndFunction
; OnOptionSelect
Event OnOptionSelect(Int OptionID)
	If CurrentPage == "$BIS_PAGE_SYSTEM_OVERVIEW" || CurrentPage == ""
		HandleOnOptionSelectSystemOverviewPage(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_SETTINGS"
		HandleOnOptionSelectSettingsPage(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_EFFECTS"
		HandleOnOptionSelectEffectsPage(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_ANIMATIONS"
		HandleOnOptionSelectAnimationsPage(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_ANIMATIONS_FOLLOWERS"
		HandleOnOptionSelectAnimationsPageFollowers(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_TRACKED_ACTORS"
		HandleOnOptionSelectTrackedActorsPage(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_INTEGRATIONS"
		HandleOnOptionSelectIntegrationsPage(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_AUXILIARY"
		HandleOnOptionSelectAuxiliaryPage(OptionID)
	EndIf	
EndEvent
Function HandleOnOptionSelectAnimationsPage(Int OptionID)
	If OptionID == AutoHideUIID
		AutoHideUI = !AutoHideUI
		SetToggleOptionValue(OptionID, AutoHideUI)
	ElseIf OptionID == AutoPlayerTFCID
		AutoPlayerTFC = !AutoPlayerTFC
		SetToggleOptionValue(OptionID, AutoPlayerTFC)
	ElseIf OptionID == GetDressedAfterBathingEnabledToggleID
		GetDressedAfterBathingEnabled.SetValue((!GetDressedAfterBathingEnabled.GetValue() As Bool) As Int)
		SetToggleOptionValue(OptionID, GetDressedAfterBathingEnabled.GetValue() As Bool)
	Else
		Int UndressArmorSlotIndex = UndressArmorSlotToggleIDs.Find(OptionID)
		If UndressArmorSlotIndex >= 0
			UndressArmorSlotArray[UndressArmorSlotIndex] = !UndressArmorSlotArray[UndressArmorSlotIndex]
			if UndressArmorSlotArray[UndressArmorSlotIndex]
				ArmorSlotArray[UndressArmorSlotIndex] = UndressArmorSlotIndex + 30
			else
				ArmorSlotArray[UndressArmorSlotIndex] = 0
			endIf
			SetToggleOptionValue(OptionID, UndressArmorSlotArray[UndressArmorSlotIndex])
		EndIf
	EndIf
EndFunction
Function HandleOnOptionSelectAnimationsPageFollowers(Int OptionID)
	If OptionID == GetDressedAfterBathingEnabledToggleIDFollowers
		GetDressedAfterBathingEnabledFollowers.SetValue((!GetDressedAfterBathingEnabledFollowers.GetValue() As Bool) As Int)
		SetToggleOptionValue(OptionID, GetDressedAfterBathingEnabledFollowers.GetValue() As Bool)
	Else
		Int UndressArmorSlotIndex = UndressArmorSlotToggleIDsFollowers.Find(OptionID)
		If UndressArmorSlotIndex >= 0
			UndressArmorSlotArrayFollowers[UndressArmorSlotIndex] = !UndressArmorSlotArrayFollowers[UndressArmorSlotIndex]
			if UndressArmorSlotArrayFollowers[UndressArmorSlotIndex]
				ArmorSlotArrayFollowers[UndressArmorSlotIndex] = UndressArmorSlotIndex + 30
			else
				ArmorSlotArrayFollowers[UndressArmorSlotIndex] = 0
			endIf
			SetToggleOptionValue(OptionID, UndressArmorSlotArrayFollowers[UndressArmorSlotIndex])
		EndIf
	EndIf
EndFunction
Function HandleOnOptionSelectSystemOverviewPage(Int OptionID)
	If OptionID == ModStateOID_T
		If BathingInSkyrimEnabled.GetValue() == 1
			if ShowMessage("$BIS_MSG_ASK_DISABLE", True) == True
				BathingInSkyrimEnabled.SetValue(-1)
				SetTextOptionValue(OptionID, "$BIS_TXT_WORKING", false)
				DisableBathingInSkyrim()
			endIf
		ElseIf BathingInSkyrimEnabled.GetValue() == 0
			BathingInSkyrimEnabled.SetValue(-1)
			SetTextOptionValue(OptionID, "$BIS_TXT_WORKING", false)
			ShowMessage("$BIS_MSG_ASK_ENABLE", false)
			EnableBathingInSkyrim(GetIntValue(config, "!!doautoload") == 1)
		EndIf
	ElseIf OptionID == PapSetSaveOID_T
		SetTextOptionValue(PapSetSaveOID_T, "$BIS_TXT_SAVING", false)
		if SavePapyrusSettings()
			SetTextOptionValue(PapSetSaveOID_T, "$BIS_TXT_DONE", false)
		else
			SetTextOptionValue(PapSetLoadOID_T, "$BIS_TXT_ERRORED", false)
		endIf
	ElseIf OptionID == PapSetLoadOID_T
		SetTextOptionValue(PapSetLoadOID_T, "$BIS_TXT_LOADING", false)
		if LoadPapyrusSettings()
			SetTextOptionValue(PapSetLoadOID_T, "$BIS_TXT_DONE", false)
		else
			SetTextOptionValue(PapSetLoadOID_T, "$BIS_TXT_ERRORED", false)
		endIf
	EndIf
EndFunction
Function HandleOnOptionSelectSettingsPage(Int OptionID)
	If OptionID == DialogTopicEnableToggleID
		DialogTopicEnabled.SetValue((!DialogTopicEnabled.GetValue() As Bool) As Int)
		SetToggleOptionValue(OptionID, DialogTopicEnabled.GetValue() As Bool)
	ElseIf OptionID == WaterRestrictionEnableToggleID
		WaterRestrictionEnabled.SetValue((!WaterRestrictionEnabled.GetValue() As Bool) As Int)
		SetToggleOptionValue(OptionID, WaterRestrictionEnabled.GetValue() As Bool)
	EndIf	
EndFunction
Function HandleOnOptionSelectEffectsPage(Int OptionID)
	If OptionID == DirtShaderEnabledOID_T
		DirtShaderEnabled.SetValue((!DirtShaderEnabled.GetValue() As Bool) As Int)
		SetToggleOptionValue(OptionID, DirtShaderEnabled.GetValue() As Bool)
	ElseIf OptionID == TexSetOverrideID
		if !TexSetOverride && TexUtil.DirtSetCount[0] < 2 && TexUtil.DirtSetCount[1] < 2
			ShowMessage("$BIS_MSG_TEXSETOVERRIDE_WARN", false)
		else
			TexSetOverride = !TexSetOverride
		endIf
		SetTextOptionValue(OptionID, TexSetOverride)
	ElseIf OptionID == RedetectDirtSetsOID_T
		TexUtil.DirtSetCount[0] = TexUtil.InitTexSets(0)
		TexUtil.DirtSetCount[1] = TexUtil.InitTexSets(1)
		SetTextOptionValue(OverlayProgressOID_T, "$BIS_TXT_DONE", false)
		ForcePageReset()
	ElseIf OptionID == RemoveAllOverlaysOID_T
		RemoveAllOverlays()
	EndIf
EndFunction
Function HandleOnOptionSelectIntegrationsPage(Int OptionID)
	If OptionID == FadeDirtSexToggleID
		FadeDirtSex = !FadeDirtSex
		SetOptionFlags(SexIntervalDirtOID_S, (!FadeDirtSex) as int, true)
		SetOptionFlags(SexIntervalOID_S, (!FadeDirtSex) as int, true)
		SetToggleOptionValue(OptionID, FadeDirtSex)
	ElseIf OptionID == WadeDetectionOID_T
		WadeDetection = !WadeDetection
		SetToggleOptionValue(OptionID, WadeDetection)
	EndIf
EndFunction
Function HandleOnOptionSelectTrackedActorsPage(Int OptionID)
	If OptionID == TargetedActorControlOID
		If BatheQuest.HasGDOTSpell(CrosshairActor)
			If ShowMessage("$BIS_MSG_ASK_STOP_TRACK", True) == True
				BatheQuest.UntrackActor(CrosshairActor)
				ForcePageReset()
			EndIf
		Else
			CrosshairActor.AddSpell(GetDirtyOverTimeSpellList.GetAt(0) As Spell, False)
			ShowMessage("$BIS_MSG_START_TRACK", False)
			ForcePageReset()
		EndIf
	ElseIf TrackedActorsToggleIDs.Find(OptionID) != -1
		If ShowMessage("$BIS_MSG_ASK_STOP_TRACK", True) == True
			BatheQuest.UntrackActor(TrackedActors[TrackedActorsToggleIDs.Find(OptionID)])
			ForcePageReset()
		EndIf
	EndIf
EndFunction
Function HandleOnOptionSelectAuxiliaryPage(Int OptionID)
	If OptionID == ResetMenuOID_T
		if ShowMessage("$BIS_MSG_RESETMENU_1")
			SetTextOptionValue(OptionID, "$BIS_TXT_WORKING", false)
			ShowMessage("$BIS_MSG_RESETMENU_2", false)
			mzinUtil.ResetMCM()
		endIf
	ElseIf OptionID == StopAnimationsOID_T
		SetTextOptionValue(OptionID, "$BIS_TXT_WORKING", false)
		StopAnimations()
		SetTextOptionValue(OptionID, "$BIS_TXT_DONE", false)
	ElseIf OptionID == UnForbidOID_T
		SetTextOptionValue(OptionID, "$BIS_TXT_WORKING", false)
		UnForbidAllActor()
		SetTextOptionValue(OptionID, "$BIS_TXT_DONE", false)
	ElseIf OptionID == GameMessageID_T
		GameMessage = !GameMessage
		SetToggleOptionValue(OptionID, GameMessage)
	ElseIf OptionID == LogNotificationID_T
		LogNotification = !LogNotification
		SetToggleOptionValue(OptionID, LogNotification)
	ElseIf OptionID == LogTraceID_T
		LogTrace = !LogTrace
		SetToggleOptionValue(OptionID, LogTrace)
	ElseIf OptionID == ConfigWarnID_T
		ConfigWarn = !ConfigWarn
		SetToggleOptionValue(OptionID, ConfigWarn)
	ElseIf OptionID == SkipItemHashID_T
		SkipItemHash = !SkipItemHash
		SetToggleOptionValue(OptionID, SkipItemHash)
	Endif
EndFunction

; OnOptionMenuAccept
Event OnOptionMenuAccept(Int OptionID, Int MenuItemIndex)
	If CurrentPage == "$BIS_PAGE_SETTINGS"
		HandleOnOptionMenuAcceptSettingsPage(OptionID, MenuItemIndex)
	ElseIf CurrentPage == "$BIS_PAGE_ANIMATIONS"
		HandleOnOptionMenuAcceptAnimationsPage(OptionID, MenuItemIndex)
	ElseIf CurrentPage == "$BIS_PAGE_ANIMATIONS_FOLLOWERS"
		HandleOnOptionMenuAcceptAnimationsPageFollowers(OptionID, MenuItemIndex)
	EndIf
EndEvent
Function HandleOnOptionMenuAcceptSettingsPage(Int OptionID, Int MenuItemIndex)
	If OptionID == AutomateFollowerBathingMenuID
		If MenuItemIndex >= 0 && MenuItemIndex < AutomateFollowerBathingArray.Length
			SetMenuOptionValue(OptionID, AutomateFollowerBathingArray[MenuItemIndex])
			AutomateFollowerBathing.SetValue(MenuItemIndex)
		EndIf
	endIf
EndFunction
Function HandleOnOptionMenuAcceptAnimationsPage(Int OptionID, Int MenuItemIndex)
	If OptionID == BathingAnimationStyleMenuID
		If MenuItemIndex >= 0 && MenuItemIndex < BathingAnimationStyleArray.Length
			SetMenuOptionValue(OptionID, BathingAnimationStyleArray[MenuItemIndex], true)
			BathingAnimationStyle.SetValue(MenuItemIndex)
			ForcePageReset()
		EndIf
	ElseIf OptionID == ShoweringAnimationStyleMenuID
		If MenuItemIndex >= 0 && MenuItemIndex < ShoweringAnimationStyleArray.Length
			SetMenuOptionValue(OptionID, ShoweringAnimationStyleArray[MenuItemIndex], true)
			ShoweringAnimationStyle.SetValue(MenuItemIndex)
			ForcePageReset()
		EndIf
	ElseIf OptionID == GetSoapyStyleMenuID
		If MenuItemIndex >= 0 && MenuItemIndex < GetSoapyStyleArray.Length
			SetMenuOptionValue(OptionID, GetSoapyStyleArray[MenuItemIndex])
			GetSoapyStyle.SetValue(MenuItemIndex)
		EndIf
	ElseIf OptionID == AnimCustomTierCondMenuID
		If MenuItemIndex >= 0 && MenuItemIndex < AnimCustomTierCondArray.Length
			SetMenuOptionValue(OptionID, AnimCustomTierCondArray[MenuItemIndex])
			AnimCustomTierCond = MenuItemIndex
		EndIf
	EndIf
EndFunction
Function HandleOnOptionMenuAcceptAnimationsPageFollowers(Int OptionID, Int MenuItemIndex)
	If OptionID == BathingAnimationStyleMenuIDFollowers
		If MenuItemIndex >= 0 && MenuItemIndex < BathingAnimationStyleArray.Length
			SetMenuOptionValue(OptionID, BathingAnimationStyleArray[MenuItemIndex], true)
			BathingAnimationStyleFollowers.SetValue(MenuItemIndex)
			ForcePageReset()
		EndIf
	ElseIf OptionID == ShoweringAnimationStyleMenuIDFollowers
		If MenuItemIndex >= 0 && MenuItemIndex < ShoweringAnimationStyleArray.Length
			SetMenuOptionValue(OptionID, ShoweringAnimationStyleArray[MenuItemIndex], true)
			ShoweringAnimationStyleFollowers.SetValue(MenuItemIndex)
			ForcePageReset()
		EndIf
	ElseIf OptionID == GetSoapyStyleMenuIDFollowers
		If MenuItemIndex >= 0 && MenuItemIndex < GetSoapyStyleArray.Length
			SetMenuOptionValue(OptionID, GetSoapyStyleArray[MenuItemIndex])
			GetSoapyStyleFollowers.SetValue(MenuItemIndex)
		EndIf
	ElseIf OptionID == AnimCustomTierCondMenuIDFollowers
		If MenuItemIndex >= 0 && MenuItemIndex < AnimCustomTierCondArray.Length
			SetMenuOptionValue(OptionID, AnimCustomTierCondArray[MenuItemIndex])
			AnimCustomTierCondFollowers = MenuItemIndex
		EndIf
	EndIf
EndFunction

; OnOptionMenuOpen
Event OnOptionMenuOpen(Int OptionID)
	If CurrentPage == "$BIS_PAGE_SETTINGS"
		HandleOnOptionMenuOpenSettingsPage(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_ANIMATIONS"
		HandleOnOptionMenuOpenAnimationsPage(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_ANIMATIONS_FOLLOWERS"
		HandleOnOptionMenuOpenAnimationsPageFollowers(OptionID)
	EndIf
EndEvent
Function HandleOnOptionMenuOpenSettingsPage(Int OptionID)
	If OptionID == AutomateFollowerBathingMenuID
		SetMenuDialogOptions(AutomateFollowerBathingArray)
		SetMenuDialogStartIndex(AutomateFollowerBathing.GetValue() As Int)
		SetMenuDialogDefaultIndex(1)
	EndIf
EndFunction
Function HandleOnOptionMenuOpenAnimationsPage(Int OptionID)
	If OptionID == BathingAnimationStyleMenuID
		SetMenuDialogOptions(BathingAnimationStyleArray)
		SetMenuDialogStartIndex(BathingAnimationStyle.GetValue() As Int)
		SetMenuDialogDefaultIndex(1)
	ElseIf OptionID == ShoweringAnimationStyleMenuID
		SetMenuDialogOptions(ShoweringAnimationStyleArray)
		SetMenuDialogStartIndex(ShoweringAnimationStyle.GetValue() As Int)
		SetMenuDialogDefaultIndex(1)
	ElseIf OptionID == GetSoapyStyleMenuID
		SetMenuDialogOptions(GetSoapyStyleArray)
		SetMenuDialogStartIndex(GetSoapyStyle.GetValue() As Int)
		SetMenuDialogDefaultIndex(1)
	ElseIf OptionID == AnimCustomTierCondMenuID
		SetMenuDialogOptions(AnimCustomTierCondArray)
		SetMenuDialogStartIndex(AnimCustomTierCond)
		SetMenuDialogDefaultIndex(1)
	EndIf
EndFunction
Function HandleOnOptionMenuOpenAnimationsPageFollowers(Int OptionID)
	If OptionID == BathingAnimationStyleMenuIDFollowers
		SetMenuDialogOptions(BathingAnimationStyleArray)
		SetMenuDialogStartIndex(BathingAnimationStyleFollowers.GetValue() As Int)
		SetMenuDialogDefaultIndex(1)
	ElseIf OptionID == ShoweringAnimationStyleMenuIDFollowers
		SetMenuDialogOptions(ShoweringAnimationStyleArray)
		SetMenuDialogStartIndex(ShoweringAnimationStyleFollowers.GetValue() As Int)
		SetMenuDialogDefaultIndex(0)
	ElseIf OptionID == GetSoapyStyleMenuIDFollowers
		SetMenuDialogOptions(GetSoapyStyleArray)
		SetMenuDialogStartIndex(GetSoapyStyleFollowers.GetValue() As Int)
		SetMenuDialogDefaultIndex(1)
	ElseIf OptionID == AnimCustomTierCondMenuIDFollowers
		SetMenuDialogOptions(AnimCustomTierCondArray)
		SetMenuDialogStartIndex(AnimCustomTierCond)
		SetMenuDialogDefaultIndex(1)
	EndIf
EndFunction

; OnOptionSliderAccept
Event OnOptionSliderAccept(Int OptionID, Float OptionValue)
	If CurrentPage == "$BIS_PAGE_SETTINGS"
		HandleOnOptionSliderAcceptSettingsPage(OptionID, OptionValue)
	ElseIf CurrentPage == "$BIS_PAGE_EFFECTS"
		HandleOnOptionSliderAcceptEffectsPage(OptionID, OptionValue)
	ElseIf CurrentPage == "$BIS_PAGE_ANIMATIONS"
		HandleOnOptionSliderAcceptAnimationsPage(OptionID, OptionValue)
	ElseIf CurrentPage == "$BIS_PAGE_ANIMATIONS_FOLLOWERS"
		HandleOnOptionSliderAcceptAnimationsPageFollowers(OptionID, OptionValue)
	ElseIf CurrentPage == "$BIS_PAGE_INTEGRATIONS"
		HandleOnOptionSliderAcceptIntegrationsPage(OptionID, OptionValue)
	EndIf	
EndEvent
Function HandleOnOptionSliderAcceptAnimationsPage(Int OptionID, Float OptionValue)
	Float SliderValue = OptionValue
	String DisplayFormat = "{0}"

	If OptionID == BathingAnimationLoopsTier0SliderID
		(BathingAnimationLoopCountList.GetAt(0) As GlobalVariable).SetValue(SliderValue)
	ElseIf OptionID == BathingAnimationLoopsTier1SliderID
		(BathingAnimationLoopCountList.GetAt(1) As GlobalVariable).SetValue(SliderValue)
	ElseIf OptionID == BathingAnimationLoopsTier2SliderID
		(BathingAnimationLoopCountList.GetAt(2) As GlobalVariable).SetValue(SliderValue)
	ElseIf OptionID == BathingAnimationLoopsTier3SliderID
		(BathingAnimationLoopCountList.GetAt(3) As GlobalVariable).SetValue(SliderValue)
	ElseIf OptionID == BathingAnimationLoopsTier4SliderID
		(BathingAnimationLoopCountList.GetAt(4) As GlobalVariable).SetValue(SliderValue)

	ElseIf OptionID == AnimCustomMSet1SliderID
		AnimCustomMSet1Freq = SliderValue
		AnimCustomMSet[0] = AnimCustomMSet1Freq
	ElseIf OptionID == AnimCustomFSet1SliderID
		AnimCustomFSet1Freq = SliderValue
		AnimCustomFSet[0] = AnimCustomFSet1Freq
	ElseIf OptionID == AnimCustomFSet2SliderID
		AnimCustomFSet2Freq = SliderValue
		AnimCustomFSet[1] = AnimCustomFSet2Freq
	ElseIf OptionID == AnimCustomFSet3SliderID
		AnimCustomFSet3Freq = SliderValue
		AnimCustomFSet[2] = AnimCustomFSet3Freq
	EndIf
		
	SetSliderOptionValue(OptionID, SliderValue, DisplayFormat)	
EndFunction
Function HandleOnOptionSliderAcceptAnimationsPageFollowers(Int OptionID, Float OptionValue)
	Float SliderValue = OptionValue
	String DisplayFormat = "{0}"

	If OptionID == BathingAnimationLoopsTier0SliderIDFollowers
		(BathingAnimationLoopCountListFollowers.GetAt(0) As GlobalVariable).SetValue(SliderValue)
	ElseIf OptionID == BathingAnimationLoopsTier1SliderIDFollowers
		(BathingAnimationLoopCountListFollowers.GetAt(1) As GlobalVariable).SetValue(SliderValue)
	ElseIf OptionID == BathingAnimationLoopsTier2SliderIDFollowers
		(BathingAnimationLoopCountListFollowers.GetAt(2) As GlobalVariable).SetValue(SliderValue)
	ElseIf OptionID == BathingAnimationLoopsTier3SliderIDFollowers
		(BathingAnimationLoopCountListFollowers.GetAt(3) As GlobalVariable).SetValue(SliderValue)
	ElseIf OptionID == BathingAnimationLoopsTier4SliderIDFollowers
		(BathingAnimationLoopCountListFollowers.GetAt(4) As GlobalVariable).SetValue(SliderValue)

	ElseIf OptionID == AnimCustomMSet1SliderIDFollowers
		AnimCustomMSet1FreqFollowers = SliderValue
		AnimCustomMSetFollowers[0] = AnimCustomMSet1FreqFollowers
	ElseIf OptionID == AnimCustomFSet1SliderIDFollowers
		AnimCustomFSet1FreqFollowers = SliderValue
		AnimCustomFSetFollowers[0] = AnimCustomFSet1FreqFollowers
	ElseIf OptionID == AnimCustomFSet2SliderIDFollowers
		AnimCustomFSet2FreqFollowers = SliderValue
		AnimCustomFSetFollowers[1] = AnimCustomFSet2FreqFollowers
	ElseIf OptionID == AnimCustomFSet3SliderIDFollowers
		AnimCustomFSet3FreqFollowers = SliderValue
		AnimCustomFSetFollowers[2] = AnimCustomFSet3FreqFollowers
	EndIf
		
	SetSliderOptionValue(OptionID, SliderValue, DisplayFormat)	
EndFunction
Function HandleOnOptionSliderAcceptSettingsPage(Int OptionID, Float OptionValue)
	Float SliderValue = OptionValue
	String DisplayFormat

	If OptionID == UpdateIntervalSliderID
		DisplayFormat = DF_Decimal
		DirtinessUpdateInterval.SetValue(SliderValue)
	ElseIf OptionID == DirtinessPerHourPlayerHouseSliderID
		DisplayFormat = DF_Percentage
		SliderValue = OptionValue / 100.0
		DirtinessPerHourPlayerHouse.SetValue(SliderValue)
	ElseIf OptionID == DirtinessPerHourSettlementSliderID
		DisplayFormat = DF_Percentage
		SliderValue = OptionValue / 100.0
		DirtinessPerHourSettlement.SetValue(SliderValue)
	ElseIf OptionID == DirtinessPerHourDungeonSliderID
		DisplayFormat = DF_Percentage
		SliderValue = OptionValue / 100.0
		DirtinessPerHourDungeon.SetValue(SliderValue)
	ElseIf OptionID == DirtinessPerHourWildernessSliderID
		DisplayFormat = DF_Percentage
		SliderValue = OptionValue / 100.0	
		DirtinessPerHourWilderness.SetValue(SliderValue)
	ElseIf OptionID == DirtinessThresholdTier1SliderID
		DisplayFormat = DF_Percentage
		SliderValue = OptionValue / 100.0
		(DirtinessThresholdList.GetAt(1) As GlobalVariable).SetValue(SliderValue)
	ElseIf OptionID == DirtinessThresholdTier2SliderID
		DisplayFormat = DF_Percentage
		SliderValue = OptionValue / 100.0
		(DirtinessThresholdList.GetAt(2) As GlobalVariable).SetValue(SliderValue)
	ElseIf OptionID == DirtinessThresholdTier3SliderID
		DisplayFormat = DF_Percentage
		SliderValue = OptionValue / 100.0
		(DirtinessThresholdList.GetAt(3) As GlobalVariable).SetValue(SliderValue)
	ElseIf OptionID == DirtinessThresholdTier4SliderID
		DisplayFormat = DF_Percentage
		SliderValue = OptionValue / 100.0
		(DirtinessThresholdList.GetAt(4) As GlobalVariable).SetValue(SliderValue)
	ElseIf OptionID == ShynessDistanceOID_S
		DisplayFormat = DF_Units
		SliderValue = OptionValue
		ShynessDistance.SetValue(SliderValue)
	ElseIf OptionID == CleansingSwimOID_S
		DisplayFormat = DF_Percentage
		if OptionValue < 0
			OptionValue = -1
		endIf
		SliderValue = OptionValue / 100
		CleansingSwim.SetValue(SliderValue)
	EndIf
	
	SetSliderOptionValue(OptionID, OptionValue, DisplayFormat)
EndFunction
Function HandleOnOptionSliderAcceptEffectsPage(Int OptionID, Float OptionValue)
	Float SliderValue = OptionValue
	String DisplayFormat

	If OptionID == OverlayApplyAtOID_S
		DisplayFormat = DF_Percentage_Dirt
		SliderValue = OptionValue
		OverlayApplyAt = SliderValue / 100.0
		UpdateAllActors()
	ElseIf OptionID == StartingAlphaOID_S
		DisplayFormat = DF_Percentage
		SliderValue = OptionValue
		StartingAlpha = SliderValue / 100.0
		UpdateAllActors()
	ElseIf OptionID == TimeToCleanOID_S
		DisplayFormat = DF_Decimal
		SliderValue = OptionValue
		TimeToClean = SliderValue
	ElseIf OptionID == TimeToCleanIntervalOID_S
		DisplayFormat = DF_Decimal
		SliderValue = OptionValue
		TimeToCleanInterval = SliderValue
	EndIf

	SetSliderOptionValue(OptionID, OptionValue, DisplayFormat)
EndFunction
Function HandleOnOptionSliderAcceptIntegrationsPage(Int OptionID, Float OptionValue)
	Float SliderValue = OptionValue
	String DisplayFormat

	If OptionID == DirtinessPerSexOID_S
		DisplayFormat = DF_Percentage
		SliderValue = OptionValue
		DirtinessPerSexActor = SliderValue / 100.0
		ForcePageReset()
	ElseIf OptionID == VictimMultOID_S
		DisplayFormat = DF_Decimal
		SliderValue = OptionValue
		VictimMult = SliderValue
		ForcePageReset()
	ElseIf OptionID == SexIntervalDirtOID_S
		DisplayFormat = DF_Decimal
		SliderValue = OptionValue
		SexIntervalDirt = SliderValue
		ForcePageReset()
	ElseIf OptionID == SexIntervalOID_S
		DisplayFormat = DF_Decimal
		SliderValue = OptionValue
		SexInterval = SliderValue

	ElseIf OptionID == FadeTatsFadeTimeOID_S
		DisplayFormat = DF_Decimal
		SliderValue = OptionValue
		FadeTatsFadeTime = SliderValue
	ElseIf OptionID == FadeTatsSoapMultOID_S
		DisplayFormat = DF_Decimal
		SliderValue = OptionValue
		FadeTatsSoapMult = SliderValue
	EndIf

	SetSliderOptionValue(OptionID, OptionValue, DisplayFormat)
EndFunction

; OnOptionSliderOpen
Event OnOptionSliderOpen(Int OptionID)
	If CurrentPage == "$BIS_PAGE_SETTINGS"
		HandleOnOptionSliderOpenSettingsPage(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_EFFECTS"
		HandleOnOptionSliderOpenEffectsPage(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_ANIMATIONS"
		HandleOnOptionSliderOpenAnimationsPage(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_ANIMATIONS_FOLLOWERS"
		HandleOnOptionSliderOpenAnimationsPageFollowers(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_INTEGRATIONS"
		HandleOnOptionSliderOpenIntegrationsPage(OptionID)
	EndIf		
EndEvent
Function HandleOnOptionSliderOpenAnimationsPage(Int OptionID)
	Float SliderValue = 0.0
	String DisplayFormat

	If OptionID == BathingAnimationLoopsTier0SliderID
		DisplayFormat = "{0}"
		SetSliderDialogRange(1.0, 10.0)
		SetSliderDialogInterval(1.0)
		SetSliderDialogDefaultValue(1.0)
		SliderValue = (BathingAnimationLoopCountList.GetAt(0) As GlobalVariable).GetValue() As Int
	ElseIf OptionID == BathingAnimationLoopsTier1SliderID
		DisplayFormat = "{0}"
		SetSliderDialogRange(1.0, 10.0)
		SetSliderDialogInterval(1.0)
		SetSliderDialogDefaultValue(1.0)
		SliderValue = (BathingAnimationLoopCountList.GetAt(1) As GlobalVariable).GetValue() As Int
	ElseIf OptionID == BathingAnimationLoopsTier2SliderID
		DisplayFormat = "{0}"
		SetSliderDialogRange(1.0, 10.0)
		SetSliderDialogInterval(1.0)
		SetSliderDialogDefaultValue(1.0)
		SliderValue = (BathingAnimationLoopCountList.GetAt(2) As GlobalVariable).GetValue() As Int
	ElseIf OptionID == BathingAnimationLoopsTier3SliderID
		DisplayFormat = "{0}"
		SetSliderDialogRange(1.0, 10.0)
		SetSliderDialogInterval(1.0)
		SetSliderDialogDefaultValue(1.0)
		SliderValue = (BathingAnimationLoopCountList.GetAt(3) As GlobalVariable).GetValue() As Int
	ElseIf OptionID == BathingAnimationLoopsTier4SliderID
		DisplayFormat = "{0}"
		SetSliderDialogRange(1.0, 10.0)
		SetSliderDialogInterval(1.0)
		SetSliderDialogDefaultValue(1.0)
		SliderValue = (BathingAnimationLoopCountList.GetAt(4) As GlobalVariable).GetValue() As Int

	ElseIf OptionID == AnimCustomMSet1SliderID
		DisplayFormat = "{0}"
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(5.0)
		SetSliderDialogDefaultValue(0.0)
		SliderValue = AnimCustomMSet1Freq
	ElseIf OptionID == AnimCustomFSet1SliderID
		DisplayFormat = "{0}"
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(5.0)
		SetSliderDialogDefaultValue(0.0)
		SliderValue = AnimCustomFSet1Freq
	ElseIf OptionID == AnimCustomFSet2SliderID
		DisplayFormat = "{0}"
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(5.0)
		SetSliderDialogDefaultValue(0.0)
		SliderValue = AnimCustomFSet2Freq
	ElseIf OptionID == AnimCustomFSet3SliderID
		DisplayFormat = "{0}"
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(5.0)
		SetSliderDialogDefaultValue(0.0)
		SliderValue = AnimCustomFSet3Freq
	EndIf

	; set slider value
	SetSliderDialogStartValue(SliderValue)
	SetSliderOptionValue(OptionID, SliderValue, DisplayFormat)
EndFunction
Function HandleOnOptionSliderOpenAnimationsPageFollowers(Int OptionID)
	Float SliderValue = 0.0
	String DisplayFormat

	If OptionID == BathingAnimationLoopsTier0SliderIDFollowers
		DisplayFormat = "{0}"
		SetSliderDialogRange(1.0, 10.0)
		SetSliderDialogInterval(1.0)
		SetSliderDialogDefaultValue(1.0)
		SliderValue = (BathingAnimationLoopCountListFollowers.GetAt(0) As GlobalVariable).GetValue() As Int
	ElseIf OptionID == BathingAnimationLoopsTier1SliderIDFollowers
		DisplayFormat = "{0}"
		SetSliderDialogRange(1.0, 10.0)
		SetSliderDialogInterval(1.0)
		SetSliderDialogDefaultValue(1.0)
		SliderValue = (BathingAnimationLoopCountListFollowers.GetAt(1) As GlobalVariable).GetValue() As Int
	ElseIf OptionID == BathingAnimationLoopsTier2SliderIDFollowers
		DisplayFormat = "{0}"
		SetSliderDialogRange(1.0, 10.0)
		SetSliderDialogInterval(1.0)
		SetSliderDialogDefaultValue(1.0)
		SliderValue = (BathingAnimationLoopCountListFollowers.GetAt(2) As GlobalVariable).GetValue() As Int
	ElseIf OptionID == BathingAnimationLoopsTier3SliderIDFollowers
		DisplayFormat = "{0}"
		SetSliderDialogRange(1.0, 10.0)
		SetSliderDialogInterval(1.0)
		SetSliderDialogDefaultValue(1.0)
		SliderValue = (BathingAnimationLoopCountListFollowers.GetAt(3) As GlobalVariable).GetValue() As Int
	ElseIf OptionID == BathingAnimationLoopsTier4SliderIDFollowers
		DisplayFormat = "{0}"
		SetSliderDialogRange(1.0, 10.0)
		SetSliderDialogInterval(1.0)
		SetSliderDialogDefaultValue(1.0)
		SliderValue = (BathingAnimationLoopCountListFollowers.GetAt(4) As GlobalVariable).GetValue() As Int

	ElseIf OptionID == AnimCustomMSet1SliderIDFollowers
		DisplayFormat = "{0}"
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(5.0)
		SetSliderDialogDefaultValue(0.0)
		SliderValue = AnimCustomMSet1FreqFollowers
	ElseIf OptionID == AnimCustomFSet1SliderIDFollowers
		DisplayFormat = "{0}"
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(5.0)
		SetSliderDialogDefaultValue(0.0)
		SliderValue = AnimCustomFSet1FreqFollowers
	ElseIf OptionID == AnimCustomFSet2SliderIDFollowers
		DisplayFormat = "{0}"
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(5.0)
		SetSliderDialogDefaultValue(0.0)
		SliderValue = AnimCustomFSet2FreqFollowers
	ElseIf OptionID == AnimCustomFSet3SliderIDFollowers
		DisplayFormat = "{0}"
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(5.0)
		SetSliderDialogDefaultValue(0.0)
		SliderValue = AnimCustomFSet3FreqFollowers
	EndIf

	; set slider value
	SetSliderDialogStartValue(SliderValue)
	SetSliderOptionValue(OptionID, SliderValue, DisplayFormat)
EndFunction
Function HandleOnOptionSliderOpenSettingsPage(Int OptionID)
	Float SliderValue = 0.0
	String DisplayFormat

	; get slider value
	If OptionID == UpdateIntervalSliderID
		DisplayFormat = DF_Decimal
		SetSliderDialogRange(0.25, 5.0)
		SetSliderDialogInterval(0.25)
		SetSliderDialogDefaultValue(1.0)
		SliderValue = (DirtinessUpdateInterval.GetValue())
	ElseIf OptionID == DirtinessPerHourPlayerHouseSliderID
		DisplayFormat = DF_Percentage
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(0.5)
		SetSliderDialogDefaultValue(1.0)
		SliderValue = (DirtinessPerHourPlayerHouse.GetValue() * 100.0)
	ElseIf OptionID == DirtinessPerHourSettlementSliderID
		DisplayFormat = DF_Percentage
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(0.5)
		SetSliderDialogDefaultValue(1.0)
		SliderValue = (DirtinessPerHourSettlement.GetValue() * 100.0)
	ElseIf OptionID == DirtinessPerHourDungeonSliderID
		DisplayFormat = DF_Percentage
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(0.5)
		SetSliderDialogDefaultValue(2.5)
		SliderValue = (DirtinessPerHourDungeon.GetValue() * 100.0)
	ElseIf OptionID == DirtinessPerHourWildernessSliderID
		DisplayFormat = DF_Percentage
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(0.5)
		SetSliderDialogDefaultValue(1.5)
		SliderValue = (DirtinessPerHourWilderness.GetValue() * 100.0)
	ElseIf OptionID == DirtinessThresholdTier1SliderID
		DisplayFormat = DF_Percentage
		SetSliderDialogRange(GetDirtinessThresholdSliderMin(1), GetDirtinessThresholdSliderMax(1))
		SetSliderDialogInterval(0.5)
		SetSliderDialogDefaultValue(ClampDirtinessThreshold(1, 0.20) * 100)
		SliderValue = ((DirtinessThresholdList.GetAt(1) As GlobalVariable).GetValue() * 100.0)
	ElseIf OptionID == DirtinessThresholdTier2SliderID
		DisplayFormat = DF_Percentage
		SetSliderDialogRange(GetDirtinessThresholdSliderMin(2), GetDirtinessThresholdSliderMax(2))
		SetSliderDialogInterval(0.5)
		SetSliderDialogDefaultValue(ClampDirtinessThreshold(2, 0.60) * 100)
		SliderValue = ((DirtinessThresholdList.GetAt(2) As GlobalVariable).GetValue() * 100.0)
	ElseIf OptionID == DirtinessThresholdTier3SliderID
		DisplayFormat = DF_Percentage
		SetSliderDialogRange(GetDirtinessThresholdSliderMin(3), GetDirtinessThresholdSliderMax(3))
		SetSliderDialogInterval(0.5)
		SetSliderDialogDefaultValue(ClampDirtinessThreshold(3, 0.98) * 100)
		SliderValue = ((DirtinessThresholdList.GetAt(3) As GlobalVariable).GetValue() * 100.0)
	ElseIf OptionID == DirtinessThresholdTier4SliderID
		DisplayFormat = DF_Percentage
		SetSliderDialogRange(GetDirtinessThresholdSliderMin(4), GetDirtinessThresholdSliderMax(4))
		SetSliderDialogInterval(0.5)
		SetSliderDialogDefaultValue(ClampDirtinessThreshold(4, 1.00) * 100)
		SliderValue = ((DirtinessThresholdList.GetAt(4) As GlobalVariable).GetValue() * 100.0)
	ElseIf OptionID == ShynessDistanceOID_S
		DisplayFormat = DF_Units
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-100.0, 6000.0)
		SetSliderDialogInterval(100.0)
		SliderValue = ShynessDistance.GetValue()
	ElseIf OptionID == CleansingSwimOID_S
		DisplayFormat = DF_Percentage
		SetSliderDialogRange(-1.0, 100.0)
		SetSliderDialogInterval(0.5)
		SetSliderDialogDefaultValue(20.0)
		SliderValue = CleansingSwim.GetValue() * 100.0
	EndIf
	
	; set slider value
	SetSliderDialogStartValue(SliderValue)
	SetSliderOptionValue(OptionID, SliderValue, DisplayFormat)
EndFunction
Function HandleOnOptionSliderOpenEffectsPage(int OptionID)
	Float SliderValue = 0.0
	String DisplayFormat

	If OptionID == OverlayApplyAtOID_S
		DisplayFormat = DF_Percentage_Dirt
		SetSliderDialogDefaultValue(40.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(0.5)
		SliderValue = OverlayApplyAt * 100.0	
	ElseIf OptionID == StartingAlphaOID_S
		DisplayFormat = DF_Percentage
		SetSliderDialogDefaultValue(15.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(0.5)
		SliderValue = StartingAlpha * 100.0
	ElseIf OptionID == TimeToCleanOID_S
		DisplayFormat = DF_Decimal
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0, 30.0)
		SetSliderDialogInterval(0.5)
		SliderValue = TimeToClean
	ElseIf OptionID == TimeToCleanIntervalOID_S
		DisplayFormat = DF_Decimal
		SetSliderDialogDefaultValue(0.25)
		SetSliderDialogRange(0.01, 5.0)
		SetSliderDialogInterval(0.01)
		SliderValue = TimeToCleanInterval
	EndIf

	; set slider value
	SetSliderDialogStartValue(SliderValue)
	SetSliderOptionValue(OptionID, SliderValue, DisplayFormat)
EndFunction
Function HandleOnOptionSliderOpenIntegrationsPage(int OptionID)
	Float SliderValue = 0.0
	String DisplayFormat

	If OptionID == DirtinessPerSexOID_S
		DisplayFormat = DF_Percentage
		SetSliderDialogDefaultValue(4.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(0.5)
		SliderValue = DirtinessPerSexActor * 100.0
	ElseIf OptionID == VictimMultOID_S
		DisplayFormat = DF_Decimal
		SetSliderDialogDefaultValue(2.5)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.1)
		SliderValue = VictimMult
	ElseIf OptionID == SexIntervalDirtOID_S
		DisplayFormat = DF_Decimal
		SetSliderDialogDefaultValue(35.0)
		SetSliderDialogRange(0.0, 200.0)
		SetSliderDialogInterval(0.5)
		SliderValue = SexIntervalDirt
	ElseIf OptionID == SexIntervalOID_S
		DisplayFormat = DF_Decimal
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.5, 10.0)
		SetSliderDialogInterval(0.5)
		SliderValue = SexInterval

	ElseIf OptionID == FadeTatsFadeTimeOID_S
		DisplayFormat = DF_Decimal
		SetSliderDialogDefaultValue(8.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1.0)
		SliderValue = FadeTatsFadeTime
	ElseIf OptionID == FadeTatsSoapMultOID_S
		DisplayFormat = DF_Decimal
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.1)
		SliderValue = FadeTatsSoapMult
	EndIf

	; set slider value
	SetSliderDialogStartValue(SliderValue)
	SetSliderOptionValue(OptionID, SliderValue, DisplayFormat)
EndFunction

; helper functions
Function EnableBathingInSkyrim(Bool abAutoLoad)
	Utility.Wait(1.0)
	
	mzinUtil.reset()
	mzinUtil.stop()
	while !mzinUtil.IsStopped()
		Utility.Wait(0.1)
	endWhile
	if !mzinUtil.start()
		mzinUtil.LogNotification("Failed to initialize utility script.", true)
		mzinUtil.LogTrace("Player failed to enable Bathing in Skyrim. Mod version: " + GetModVersion() + "; Script version: " + GetVersion(), true)
		BathingInSkyrimEnabled.SetValue(0)
		return
	endIf
	mzinUtil.ReloadMCMVariables()

	ConfigWarn = true

	BatheQuest.Start()
	BatheQuest.RegForEvents()
	mzinBatheFollowerDialogQuest.Start()

	PlayerRef.AddSpell(GetDirtyOverTimeSpellList.GetAt(1) As Spell, False)

	if abAutoLoad && LoadPapyrusSettings(true)
		mzinUtil.LogNotification("Auto loaded configuration.", true)
	endIf

	BathingInSkyrimEnabled.SetValue(1)

	mzinUtil.LogNotification("Enabled Bathing in Skyrim.", true)
	mzinUtil.LogTrace("Player enabled Bathing in Skyrim. Mod version: " + GetModVersion() + "; Script version: " + GetVersion(), true)
EndFunction
Function DisableBathingInSkyrim()
	RemoveAllOverlays(false)
	
	BatheQuest.UntrackActor(PlayerRef, false)
	BatheQuest.UpdateActorDirtPercent(PlayerRef, 0.0)

	Actor[] arrDirtyActors = GetAllActorsInFaction(TrackedBatherFaction)
	Int i = arrDirtyActors.Length
	If i > 0
		While i
			i -= 1
			BatheQuest.UntrackActor(arrDirtyActors[i], false)
		EndWhile
	EndIf

	Quest.GetQuest("mzinBatheQuest").reset()
	Quest.GetQuest("mzinBatheQuest").stop()
	Quest.GetQuest("mzinBatheFollowerDialogQuest").reset()
	Quest.GetQuest("mzinBatheFollowerDialogQuest").stop()
			
	BathingInSkyrimEnabled.SetValue(0)

	mzinUtil.LogNotification("Disabled Bathing in Skyrim.", true)
	mzinUtil.LogTrace("Player disabled Bathing in Skyrim.", true)

	if IsConfigOpen
		SetTextOptionValue(ModStateOID_T, "$BIS_TXT_DISABLED", false)
	endIf

	ForcePageReset()
EndFunction

Function UpdateProgressRedetectDirtSets(String CurrentTex)
	If IsConfigOpen
		SetTextOptionValue(OverlayProgressOID_T, "$BIS_NOTIF_CHECKINGSET_{" + CurrentTex + "}", false)
	EndIF
EndFunction

Function RemoveAllOverlays(bool displayProgress = true)
	; Do player
	DoRemoveOverlays(PlayerRef, displayProgress)
	
	; Do other Npcs
	Actor[] arrDirtyActors = GetAllActorsInFaction(TrackedBatherFaction)
	Int i = arrDirtyActors.Length
	While i > 0
		i -= 1
		DoRemoveOverlays(arrDirtyActors[i], displayProgress)
	EndWhile
	If IsConfigOpen && displayProgress
		SetTextOptionValue(OverlayProgressOID_T, "$BIS_TXT_DONE", false)
	EndIf
EndFunction

Function DoRemoveOverlays(Actor akTarget, bool displayProgress = true)
	If IsConfigOpen && displayProgress
		SetTextOptionValue(OverlayProgressOID_T, "$BIS_NOTIF_PROCING_{" + akTarget.GetBaseObject().GetName() + "}", false)
	EndIf
	OlUtil.ClearDirtGameLoad(akTarget)
EndFunction

Bool Function SavePapyrusSettings()
	if JsonExists(config)
		if IsPendingSave(config)
			if !ShowMessage("$BIS_MSG_SAVE_WARN_1")
				return false
			endIf
		else
			if !ShowMessage("$BIS_MSG_ASK_SAVE")
				return false
			endIf
		endIf
	endIf

	; Set safety values
	SetStringValue(config, "Mod Name", modname)
	SetStringValue(config, "Mod Version", GetModVersion())
	SetIntValue(config, "Mod Config Version", GetVersion())

	; Set all other values
	SetIntValue(config, "DialogTopicEnabled", DialogTopicEnabled.GetValue() as int)
	SetIntValue(config, "AutomateFollowerBathing", AutomateFollowerBathing.GetValue() as int)
	SetIntValue(config, "WaterRestrictionEnabled", WaterRestrictionEnabled.GetValue() as int)
	SetIntValue(config, "GetSoapyStyle", GetSoapyStyle.GetValue() as int)
	SetIntValue(config, "GetSoapyStyleFollowers", GetSoapyStyleFollowers.GetValue() as int)
	SetIntValue(config, "CheckStatusKeyCode", CheckStatusKeyCode.GetValue() as int)
	SetIntValue(config, "BatheKeyCode", BatheKeyCode.GetValue() as int)
	SetIntValue(config, "ModifierKeyCode", ModifierKeyCode.GetValue() as int)
	
	SetIntValue(config, "BathingAnimationStyle", BathingAnimationStyle.GetValue() as int)
	SetIntValue(config, "BathingAnimationStyleFollowers", BathingAnimationStyleFollowers.GetValue() as int)
	SetIntValue(config, "ShoweringAnimationStyle", ShoweringAnimationStyle.GetValue() as int)
	SetIntValue(config, "ShoweringAnimationStyleFollowers", ShoweringAnimationStyleFollowers.GetValue() as int)
	
	SetIntValue(config, "GetDressedAfterBathingEnabled", GetDressedAfterBathingEnabled.GetValue() as int)
	SetIntValue(config, "GetDressedAfterBathingEnabledFollowers", GetDressedAfterBathingEnabledFollowers.GetValue() as int)
	IntListCopy(config, "ArmorSlotArray", ArmorSlotArray)
	IntListCopy(config, "ArmorSlotArrayFollowers", ArmorSlotArrayFollowers)
	
	SetFloatValue(config, "DirtinessUpdateInterval", DirtinessUpdateInterval.GetValue())
	SetFloatValue(config, "DirtinessPercentage", DirtinessPercentage.GetValue())
	SetFloatValue(config, "DirtinessPerHourPlayerHouse", DirtinessPerHourPlayerHouse.GetValue())
	SetFloatValue(config, "DirtinessPerHourSettlement", DirtinessPerHourSettlement.GetValue())
	SetFloatValue(config, "DirtinessPerHourDungeon", DirtinessPerHourDungeon.GetValue())
	SetFloatValue(config, "DirtinessPerHourWilderness", DirtinessPerHourWilderness.GetValue())
	
	SetFloatValue(config, "DirtinessThreshold1", (DirtinessThresholdList.GetAt(1) As GlobalVariable).GetValue())
	SetFloatValue(config, "DirtinessThreshold2", (DirtinessThresholdList.GetAt(2) As GlobalVariable).GetValue())
	SetFloatValue(config, "DirtinessThreshold3", (DirtinessThresholdList.GetAt(3) As GlobalVariable).GetValue())
	
	SetIntValue(config, "BathingAnimationLoopCount0", (BathingAnimationLoopCountList.GetAt(0) As GlobalVariable).GetValue() as int)
	SetIntValue(config, "BathingAnimationLoopCount1", (BathingAnimationLoopCountList.GetAt(1) As GlobalVariable).GetValue() as int)
	SetIntValue(config, "BathingAnimationLoopCount2", (BathingAnimationLoopCountList.GetAt(2) As GlobalVariable).GetValue() as int)
	SetIntValue(config, "BathingAnimationLoopCount3", (BathingAnimationLoopCountList.GetAt(3) As GlobalVariable).GetValue() as int)
	
	SetIntValue(config, "BathingAnimationLoopCountFollowers0", (BathingAnimationLoopCountListFollowers.GetAt(0) As GlobalVariable).GetValue() as int)
	SetIntValue(config, "BathingAnimationLoopCountFollowers1", (BathingAnimationLoopCountListFollowers.GetAt(1) As GlobalVariable).GetValue() as int)
	SetIntValue(config, "BathingAnimationLoopCountFollowers2", (BathingAnimationLoopCountListFollowers.GetAt(2) As GlobalVariable).GetValue() as int)
	SetIntValue(config, "BathingAnimationLoopCountFollowers3", (BathingAnimationLoopCountListFollowers.GetAt(3) As GlobalVariable).GetValue() as int)

	SetFloatValue(config, "AnimCustomMSet1Freq", AnimCustomMSet1Freq)
	SetFloatValue(config, "AnimCustomFSet1Freq", AnimCustomFSet1Freq)
	SetFloatValue(config, "AnimCustomFSet2Freq", AnimCustomFSet2Freq)
	SetFloatValue(config, "AnimCustomFSet3Freq", AnimCustomFSet3Freq)
	SetIntValue(config, "AnimCustomTierCond", AnimCustomTierCond)
	
	SetFloatValue(config, "AnimCustomMSet1FreqFollowers", AnimCustomMSet1FreqFollowers)
	SetFloatValue(config, "AnimCustomFSet1FreqFollowers", AnimCustomFSet1FreqFollowers)
	SetFloatValue(config, "AnimCustomFSet2FreqFollowers", AnimCustomFSet2FreqFollowers)
	SetFloatValue(config, "AnimCustomFSet3FreqFollowers", AnimCustomFSet3FreqFollowers)
	SetIntValue(config, "AnimCustomTierCondFollowers", AnimCustomTierCondFollowers)
	
	SetFloatValue(config, "DirtinessPerSexActor", DirtinessPerSexActor)
	SetFloatValue(config, "VictimMult", VictimMult)
	SetFloatValue(config, "OverlayApplyAt", OverlayApplyAt)
	SetFloatValue(config, "StartingAlpha", StartingAlpha)
	SetIntValue(config, "OverlayTint", OverlayTint)
	SetFloatValue(config, "SexIntervalDirt", SexIntervalDirt)
	SetFloatValue(config, "SexInterval", SexInterval)
	SetFloatValue(config, "TimeToClean", TimeToClean)
	SetFloatValue(config, "TimeToCleanInterval", TimeToCleanInterval)
	SetIntValue(config, "DirtShaderEnabled", DirtShaderEnabled.GetValue() as int)

	SetFloatValue(config, "ShynessDistance", ShynessDistance.GetValue())
	SetFloatValue(config, "CleansingSwim", CleansingSwim.GetValue())
	
	SetIntValue(config, "FadeDirtSex", FadeDirtSex as int)
	SetIntValue(config, "WadeDetection", WadeDetection as int)
	SetIntValue(config, "AutoHideUI", AutoHideUI as int)
	SetIntValue(config, "AutoPlayerTFC", AutoPlayerTFC as int)
	SetIntValue(config, "TexSetOverride", TexSetOverride as int)

	SetFloatValue(config, "FadeTatsFadeTime", FadeTatsFadeTime)
	SetFloatValue(config, "FadeTatsSoapMult", FadeTatsSoapMult)

	SetIntValue(config, "GameMessage", GameMessage as int)
	SetIntValue(config, "LogNotification", LogNotification as int)
	SetIntValue(config, "LogTrace", LogTrace as int)
	SetIntValue(config, "ConfigWarn", ConfigWarn as int)
	SetIntValue(config, "SkipItemHash", SkipItemHash as int)
	
	Save(config)

	ShowMessage("$BIS_MSG_COMPLETED_SAVE", False)
	return True
EndFunction

Bool Function LoadPapyrusSettings(Bool abSilent = false)
	if !abSilent
		; Simple config health check
		if !JsonExists(config)
			ShowMessage("$BIS_MSG_LOAD_WARN_1", false)
			return false
		ElseIf !(Load(config) && IsGood(config))
			ShowMessage("$BIS_MSG_LOAD_WARN_2", false)
			return false
		else
			if GetVersion() != GetIntValue(config, "Mod Config Version")
				ShowMessage("$BIS_MSG_LOAD_WARN_3", false)
			endIf
			if !ShowMessage("$BIS_MSG_ASK_LOAD")
				return false
			endIf
		endIf
	endIf

	DialogTopicEnabled.SetValue(GetIntValue(config, "DialogTopicEnabled", DialogTopicEnabled.GetValue() as int))
	AutomateFollowerBathing.SetValue(GetIntValue(config, "AutomateFollowerBathing", AutomateFollowerBathing.GetValue() as int))
	WaterRestrictionEnabled.SetValue(GetIntValue(config, "WaterRestrictionEnabled", WaterRestrictionEnabled.GetValue() as int))
	GetSoapyStyle.SetValue(GetIntValue(config, "GetSoapyStyle", GetSoapyStyle.GetValue() as int))
	GetSoapyStyleFollowers.SetValue(GetIntValue(config, "GetSoapyStyleFollowers", GetSoapyStyleFollowers.GetValue() as int))
	CheckStatusKeyCode.SetValue(GetIntValue(config, "CheckStatusKeyCode", CheckStatusKeyCode.GetValue() as int))
	BatheKeyCode.SetValue(GetIntValue(config, "BatheKeyCode", BatheKeyCode.GetValue() as int))
	ModifierKeyCode.SetValue(GetIntValue(config, "ModifierKeyCode", ModifierKeyCode.GetValue() as int))
	
	BathingAnimationStyle.SetValue(GetIntValue(config, "BathingAnimationStyle", BathingAnimationStyle.GetValue() as int))
	BathingAnimationStyleFollowers.SetValue(GetIntValue(config, "BathingAnimationStyleFollowers", BathingAnimationStyleFollowers.GetValue() as int))
	ShoweringAnimationStyle.SetValue(GetIntValue(config, "ShoweringAnimationStyle", ShoweringAnimationStyle.GetValue() as int))
	ShoweringAnimationStyleFollowers.SetValue(GetIntValue(config, "ShoweringAnimationStyleFollowers", ShoweringAnimationStyleFollowers.GetValue() as int))
	
	GetDressedAfterBathingEnabled.SetValue(GetIntValue(config, "GetDressedAfterBathingEnabled", GetDressedAfterBathingEnabled.GetValue() as int))
	GetDressedAfterBathingEnabledFollowers.SetValue(GetIntValue(config, "GetDressedAfterBathingEnabledFollowers", GetDressedAfterBathingEnabledFollowers.GetValue() as int))

	ArmorSlotArray = IntListToArray(config, "ArmorSlotArray")
	ArmorSlotArrayFollowers = IntListToArray(config, "ArmorSlotArrayFollowers")
	
	DirtinessUpdateInterval.SetValue(GetFloatValue(config, "DirtinessUpdateInterval", DirtinessUpdateInterval.GetValue()))
	DirtinessPercentage.SetValue(GetFloatValue(config, "DirtinessPercentage", DirtinessPercentage.GetValue()))
	DirtinessPerHourPlayerHouse.SetValue(GetFloatValue(config, "DirtinessPerHourPlayerHouse", DirtinessPerHourPlayerHouse.GetValue()))
	DirtinessPerHourSettlement.SetValue(GetFloatValue(config, "DirtinessPerHourSettlement", DirtinessPerHourSettlement.GetValue()))
	DirtinessPerHourDungeon.SetValue(GetFloatValue(config, "DirtinessPerHourDungeon", DirtinessPerHourDungeon.GetValue()))
	DirtinessPerHourWilderness.SetValue(GetFloatValue(config, "DirtinessPerHourWilderness", DirtinessPerHourWilderness.GetValue()))
	
	(DirtinessThresholdList.GetAt(1) As GlobalVariable).SetValue(GetFloatValue(config, "DirtinessThreshold1", (DirtinessThresholdList.GetAt(1) As GlobalVariable).GetValue()))
	(DirtinessThresholdList.GetAt(2) As GlobalVariable).SetValue(GetFloatValue(config, "DirtinessThreshold2", (DirtinessThresholdList.GetAt(2) As GlobalVariable).GetValue()))
	(DirtinessThresholdList.GetAt(3) As GlobalVariable).SetValue(GetFloatValue(config, "DirtinessThreshold3", (DirtinessThresholdList.GetAt(3) As GlobalVariable).GetValue()))
	(DirtinessThresholdList.GetAt(4) As GlobalVariable).SetValue(GetFloatValue(config, "DirtinessThreshold4", (DirtinessThresholdList.GetAt(4) As GlobalVariable).GetValue()))
	
	(BathingAnimationLoopCountList.GetAt(0) As GlobalVariable).SetValue(GetIntValue(config, "BathingAnimationLoopCount0", (BathingAnimationLoopCountList.GetAt(0) As GlobalVariable).GetValue() as int))
	(BathingAnimationLoopCountList.GetAt(1) As GlobalVariable).SetValue(GetIntValue(config, "BathingAnimationLoopCount1", (BathingAnimationLoopCountList.GetAt(1) As GlobalVariable).GetValue() as int))
	(BathingAnimationLoopCountList.GetAt(2) As GlobalVariable).SetValue(GetIntValue(config, "BathingAnimationLoopCount2", (BathingAnimationLoopCountList.GetAt(2) As GlobalVariable).GetValue() as int))
	(BathingAnimationLoopCountList.GetAt(3) As GlobalVariable).SetValue(GetIntValue(config, "BathingAnimationLoopCount3", (BathingAnimationLoopCountList.GetAt(3) As GlobalVariable).GetValue() as int))
	(BathingAnimationLoopCountList.GetAt(4) As GlobalVariable).SetValue(GetIntValue(config, "BathingAnimationLoopCount4", (BathingAnimationLoopCountList.GetAt(4) As GlobalVariable).GetValue() as int))
	
	(BathingAnimationLoopCountListFollowers.GetAt(0) As GlobalVariable).SetValue(GetIntValue(config, "BathingAnimationLoopCountFollowers0", (BathingAnimationLoopCountListFollowers.GetAt(0) As GlobalVariable).GetValue() as int))
	(BathingAnimationLoopCountListFollowers.GetAt(1) As GlobalVariable).SetValue(GetIntValue(config, "BathingAnimationLoopCountFollowers1", (BathingAnimationLoopCountListFollowers.GetAt(1) As GlobalVariable).GetValue() as int))
	(BathingAnimationLoopCountListFollowers.GetAt(2) As GlobalVariable).SetValue(GetIntValue(config, "BathingAnimationLoopCountFollowers2", (BathingAnimationLoopCountListFollowers.GetAt(2) As GlobalVariable).GetValue() as int))
	(BathingAnimationLoopCountListFollowers.GetAt(3) As GlobalVariable).SetValue(GetIntValue(config, "BathingAnimationLoopCountFollowers3", (BathingAnimationLoopCountListFollowers.GetAt(3) As GlobalVariable).GetValue() as int))
	(BathingAnimationLoopCountListFollowers.GetAt(4) As GlobalVariable).SetValue(GetIntValue(config, "BathingAnimationLoopCountFollowers4", (BathingAnimationLoopCountListFollowers.GetAt(4) As GlobalVariable).GetValue() as int))
	
	AnimCustomMSet1Freq = GetFloatValue(config, "AnimCustomMSet1Freq", AnimCustomMSet1Freq)
	AnimCustomFSet1Freq = GetFloatValue(config, "AnimCustomFSet1Freq", AnimCustomFSet1Freq)
	AnimCustomFSet2Freq = GetFloatValue(config, "AnimCustomFSet2Freq", AnimCustomFSet2Freq)
	AnimCustomFSet3Freq = GetFloatValue(config, "AnimCustomFSet3Freq", AnimCustomFSet3Freq)
	AnimCustomTierCond = GetIntValue(config, "AnimCustomTierCond", AnimCustomTierCond)

	AnimCustomMSet1FreqFollowers = GetFloatValue(config, "AnimCustomMSet1FreqFollowers", AnimCustomMSet1FreqFollowers)
	AnimCustomFSet1FreqFollowers = GetFloatValue(config, "AnimCustomFSet1FreqFollowers", AnimCustomFSet1FreqFollowers)
	AnimCustomFSet2FreqFollowers = GetFloatValue(config, "AnimCustomFSet2FreqFollowers", AnimCustomFSet2FreqFollowers)
	AnimCustomFSet3FreqFollowers = GetFloatValue(config, "AnimCustomFSet3FreqFollowers", AnimCustomFSet3FreqFollowers)
	AnimCustomTierCondFollowers = GetIntValue(config, "AnimCustomTierCondFollowers", AnimCustomTierCondFollowers)

	DirtinessPerSexActor = GetFloatValue(config, "DirtinessPerSexActor", DirtinessPerSexActor)
	StartingAlpha = GetFloatValue(config, "StartingAlpha", StartingAlpha)
	OverlayTint = GetIntValue(config, "OverlayTint", OverlayTint)
	VictimMult = GetFloatValue(config, "VictimMult", VictimMult)
	OverlayApplyAt = GetFloatValue(config, "OverlayApplyAt", OverlayApplyAt)
	SexIntervalDirt = GetFloatValue(config, "SexIntervalDirt", SexIntervalDirt)
	SexInterval = GetFloatValue(config, "SexInterval", SexInterval)
	TimeToClean = GetFloatValue(config, "TimeToClean", TimeToClean)
	TimeToCleanInterval = GetFloatValue(config, "TimeToCleanInterval", TimeToCleanInterval)
	DirtShaderEnabled.SetValue(GetIntValue(config, "DirtShaderEnabled", DirtShaderEnabled.GetValue() as Int))
	
	ShynessDistance.SetValue(GetFloatValue(config, "ShynessDistance", ShynessDistance.GetValue()))
	CleansingSwim.SetValue(GetFloatValue(config, "CleansingSwim", CleansingSwim.GetValue()))
	
	FadeDirtSex = GetIntValue(config, "FadeDirtSex", FadeDirtSex as int)
	WadeDetection = GetIntValue(config, "WadeDetection", WadeDetection as int)
	AutoHideUI = GetIntValue(config, "AutoHideUI", AutoHideUI as int)
	AutoPlayerTFC = GetIntValue(config, "AutoPlayerTFC", AutoPlayerTFC as int)
	TexSetOverride = GetIntValue(config, "TexSetOverride", TexSetOverride as int)

	FadeTatsFadeTime = GetFloatValue(config, "FadeTatsFadeTime", FadeTatsFadeTime)
	FadeTatsSoapMult = GetFloatValue(config, "FadeTatsSoapMult", FadeTatsFadeTime)

	GameMessage = GetIntValue(config, "GameMessage", GameMessage as int)
	LogNotification = GetIntValue(config, "LogNotification", LogNotification as int)
	LogTrace = GetIntValue(config, "LogTrace", LogTrace as int)
	ConfigWarn = GetIntValue(config, "ConfigWarn", ConfigWarn as int)
	SkipItemHash = GetIntValue(config, "SkipItemHash", SkipItemHash as int)
	
	SetLocalArrays()
	BathePlayer.RegisterHotKeys()

	CorrectInvalidSettings()
	
	if !abSilent
		ShowMessage("$BIS_MSG_COMPLETED_LOAD", False)
	endIf
	return true
EndFunction

Function UpdateAllActors()
	int BiS_UpdateAllActorsEvent = ModEvent.Create("BiS_UpdateActorsAll")
    If (BiS_UpdateAllActorsEvent)
        ModEvent.Send(BiS_UpdateAllActorsEvent)
    EndIf
EndFunction

Function UnForbidAllActor()
	Int i = StorageUtil.FormListCount(none, "BiS_ForbiddenActors")
	Actor CurrentActor
	While i > 0
		i -= 1
		CurrentActor = StorageUtil.FormlistGet(none, "BiS_ForbiddenActors", i) as Actor
		StorageUtil.StringListClear(CurrentActor, "BiS_ForbiddenString")
		StorageUtil.FormListClear(CurrentActor, "BiS_ForbiddenSenders")
	EndWhile
	StorageUtil.FormListClear(none, "BiS_ForbiddenActors")
EndFunction

Function StopAnimations()
	mzinUtil.RescueActor(PlayerRef, true)

	Actor[] arrDirtyActors = GetAllActorsInFaction(TrackedBatherFaction)
	Int i = arrDirtyActors.Length
	If i > 0
		While i
			i -= 1
			mzinUtil.RescueActor_NPC(arrDirtyActors[i], true)
		EndWhile
	EndIf
EndFunction

Function CorrectInvalidSettings()
	if !Init.IsMalignisAnimInstalled
		float fDefault = 0.0
		AnimCustomFSet3Freq = fDefault
		AnimCustomFSet3FreqFollowers = fDefault
		AnimCustomFSet[2] = fDefault
		AnimCustomFSetFollowers[2] = fDefault
	endIf
	if TexSetOverride && TexUtil.DirtSetCount[0] < 2 && TexUtil.DirtSetCount[1] < 2
		TexSetOverride = false
	endIf

	int i = 1
	if (DirtinessThresholdList.GetAt(0) As GlobalVariable).GetValue() != 0.0
		(DirtinessThresholdList.GetAt(0) As GlobalVariable).SetValue(0.0)
	endIf
	if (DirtinessThresholdList.GetAt(DirtinessThresholdList.GetSize() - 1) As GlobalVariable).GetValue() != 1.0
		(DirtinessThresholdList.GetAt(DirtinessThresholdList.GetSize() - 1) As GlobalVariable).SetValue(1.0)
	endIf
	while i < (DirtinessThresholdList.GetSize() - 2)
		(DirtinessThresholdList.GetAt(i) As GlobalVariable).SetValue(ClampDirtinessThreshold(i, (DirtinessThresholdList.GetAt(i) As GlobalVariable).GetValue()))
		i += 1
	endWhile
EndFunction

Float Function ClampDirtinessThreshold(int iTier, float fVal)
	if fVal < (DirtinessThresholdList.GetAt(iTier - 1) As GlobalVariable).GetValue()
		return (DirtinessThresholdList.GetAt(iTier - 1) As GlobalVariable).GetValue()
	elseIf fVal > (DirtinessThresholdList.GetAt(iTier + 1) As GlobalVariable).GetValue()
		return (DirtinessThresholdList.GetAt(iTier + 1) As GlobalVariable).GetValue()
	endIf
	return fVal
EndFunction

Float Function GetDirtinessThresholdSliderMin(int iTier)
	return (DirtinessThresholdList.GetAt(iTier - 1) As GlobalVariable).GetValue() * 100.0
EndFunction

Float Function GetDirtinessThresholdSliderMax(int iTier)
	return (DirtinessThresholdList.GetAt(iTier + 1) As GlobalVariable).GetValue() * 100.0
EndFunction

Int Function GetAnimOptionFlag(int i)
	if ((BathingAnimationStyle.GetValue() as int) == i) || (((BathingAnimationStyle.GetValue() as bool)) && ((ShoweringAnimationStyle.GetValue() as int) == i))
		return OPTION_FLAG_NONE
	else
		return OPTION_FLAG_DISABLED
	endIf
EndFunction

Int Function GetAnimOptionFlag_Followers(int i)
	if ((BathingAnimationStyleFollowers.GetValue() as int) == i) || (((BathingAnimationStyleFollowers.GetValue() as bool)) && ((ShoweringAnimationStyleFollowers.GetValue() as int) == i))
		return OPTION_FLAG_NONE
	else
		return OPTION_FLAG_DISABLED
	endIf
EndFunction

; ---------- MCM Internal Variables ----------

; menu - System Overview
Int PapSetSaveOID_T
Int PapSetLoadOID_T

; menu - Settings
Int ModStateOID_T
Int DialogTopicEnableToggleID
Int AutomateFollowerBathingMenuID
Int WaterRestrictionEnableToggleID
Int UpdateIntervalSliderID
Int DirtinessPerHourPlayerHouseSliderID
Int DirtinessPerHourSettlementSliderID
Int DirtinessPerHourDungeonSliderID
Int DirtinessPerHourWildernessSliderID
Int DirtinessThresholdTier1SliderID
Int DirtinessThresholdTier2SliderID
Int DirtinessThresholdTier3SliderID
Int DirtinessThresholdTier4SliderID
Int CheckStatusKeyMapID
Int BatheKeyMapID
Int ModifierKeyMapID
Int ShynessDistanceOID_S
Int CleansingSwimOID_S

; menu - Effects
Int DirtShaderEnabledOID_T
Int OverlayApplyAtOID_S
Int StartingAlphaOID_S
Int OverlayTintOID_C
Int TimeToCleanOID_S
Int TimeToCleanIntervalOID_S
Int TexSetOverrideID
Int TexSetCountOID_T
Int RedetectDirtSetsOID_T
Int RemoveAllOverlaysOID_T
Int OverlayProgressOID_T

; menu - Animations - Left
Int BathingAnimationStyleMenuID
Int ShoweringAnimationStyleMenuID
Int GetSoapyStyleMenuID
Int AutoHideUIID
Int AutoPlayerTFCID
Int BathingAnimationLoopsTier0SliderID
Int BathingAnimationLoopsTier1SliderID
Int BathingAnimationLoopsTier2SliderID
Int BathingAnimationLoopsTier3SliderID
Int BathingAnimationLoopsTier4SliderID
Int AnimCustomMSet1SliderID
Int AnimCustomFSet1SliderID
Int AnimCustomFSet2SliderID
Int AnimCustomFSet3SliderID
Int AnimCustomTierCondMenuID

; menu - Animations - Right
Int   GetDressedAfterBathingEnabledToggleID
Int[] UndressArmorSlotToggleIDs

; menu - Animations - Followers - Left
Int BathingAnimationStyleMenuIDFollowers
Int ShoweringAnimationStyleMenuIDFollowers
Int GetSoapyStyleMenuIDFollowers
Int BathingAnimationLoopsTier0SliderIDFollowers
Int BathingAnimationLoopsTier1SliderIDFollowers
Int BathingAnimationLoopsTier2SliderIDFollowers
Int BathingAnimationLoopsTier3SliderIDFollowers
Int BathingAnimationLoopsTier4SliderIDFollowers
Int AnimCustomMSet1SliderIDFollowers
Int AnimCustomFSet1SliderIDFollowers
Int AnimCustomFSet2SliderIDFollowers
Int AnimCustomFSet3SliderIDFollowers
Int AnimCustomTierCondMenuIDFollowers

; menu - Animations - Followers - Right
Int   GetDressedAfterBathingEnabledToggleIDFollowers
Int[] UndressArmorSlotToggleIDsFollowers

; menu - Tracked NPCs
Int   TargetedActorControlOID
Int[] TrackedActorsToggleIDs

; menu - Integrations
Int WadeDetectionOID_T
Int FadeTatsFadeTimeOID_S
Int FadeTatsSoapMultOID_S
Int DirtinessPerSexOID_S
Int VictimMultOID_S
Int SexIntervalDirtOID_S
Int SexIntervalOID_S
Int FadeDirtSexToggleID

; menu - Auxiliary
Int ResetMenuOID_T
Int StopAnimationsOID_T
Int UnForbidOID_T
Int GameMessageID_T
Int LogNotificationID_T
Int LogTraceID_T
Int ConfigWarnID_T
Int SkipItemHashID_T

; --------------------------------------------
