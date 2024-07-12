ScriptName mzinBatheMCMMenu Extends SKI_ConfigBase
{ this script displays the MCM menu for mod configuration }

Int Property BathingInSkyrimVersion = 11 AutoReadOnly

; libraries
import FISSFactory

; references
Actor Property Player Auto

Spell Property GetDirtyOverTimeReactivatorCloakSpell Auto
FormList Property GetDirtyOverTimeSpellList Auto

; toggle values
GlobalVariable Property BathingInSkyrimEnabled Auto
GlobalVariable Property DialogTopicEnabled Auto
GlobalVariable Property WaterRestrictionEnabled Auto

; soap settings
GlobalVariable Property GetSoapyStyle Auto
GlobalVariable Property GetSoapyStyleFollowers Auto

; hotkey settings
mzinBatheCheckStatusQuest Property CheckStatusQuest Auto
mzinBatheQuest Property BatheQuest Auto
GlobalVariable Property CheckStatusKeyCode Auto
GlobalVariable Property BatheKeyCode Auto
GlobalVariable Property ShowerKeyCode Auto

; animation settings
FormList Property BathingAnimationLoopCountList Auto
FormList Property BathingAnimationLoopCountListFollowers Auto
GlobalVariable Property BathingAnimationStyle Auto
GlobalVariable Property BathingAnimationStyleFollowers Auto
GlobalVariable Property ShoweringAnimationStyle Auto
GlobalVariable Property ShoweringAnimationStyleFollowers Auto

; undress settings
GlobalVariable Property GetDressedAfterBathingEnabled Auto
GlobalVariable Property GetDressedAfterBathingEnabledFollowers Auto
GlobalVariable Property BathingIgnoredArmorSlotsMask Auto
GlobalVariable Property BathingIgnoredArmorSlotsMaskFollowers Auto

; dirtiness settings
FormList Property DirtyActors Auto
FormList Property DirtinessSpellList Auto
FormList Property DirtinessThresholdList Auto
GlobalVariable Property DirtinessUpdateInterval Auto
GlobalVariable Property DirtinessPercentage Auto
GlobalVariable Property DirtinessPerHourSettlement Auto
GlobalVariable Property DirtinessPerHourDungeon Auto
GlobalVariable Property DirtinessPerHourWilderness Auto

; soap lists
FormList Property SoapFormList Auto
FormList Property SoapBonusSpellList Auto

; leveled lists
LeveledItem Property LeveledItemListGeneral Auto
LeveledItem Property LeveledItemListInnkeeper Auto

; deprecated
FormList Property LegacySpellList Auto
GlobalVariable Property BathingAnimationEnabled Auto

; local variables
String[] BathingAnimationStyleArray
String[] ShoweringAnimationStyleArray
String[] GetSoapyStyleArray

Bool[] UndressArmorSlotArray
Bool[] UndressArmorSlotArrayFollowers
Bool[] TrackedActorsToggleValuesArray

; constants
String DisplayFormatPercentage = "{1}%"
String DisplayFormatDecimal = "{2}"

Int Function GetVersion()
	Return BathingInSkyrimVersion
EndFunction

; initialize events
Event OnConfigInit()
	; pages
	Pages = new String[4]
	Pages[0] = "$BIS_PAGE_SETTINGS"
	Pages[1] = "$BIS_PAGE_ANIMATIONS"
	Pages[2] = "$BIS_PAGE_ANIMATIONS_FOLLOWERS"
	Pages[3] = "$BIS_PAGE_TRACKED_ACTORS"
	
	; bathing animation styles
	BathingAnimationStyleArray = new String[5]
	BathingAnimationStyleArray[0] = "$BIS_L_BATHING_ANIM_STYLE_NONE"
	BathingAnimationStyleArray[1] = "$BIS_L_BATHING_ANIM_STYLE_DEFAULT"
	BathingAnimationStyleArray[2] = "$BIS_L_BATHING_ANIM_STYLE_CUSTOM1"
	BathingAnimationStyleArray[3] = "$BIS_L_BATHING_ANIM_STYLE_CUSTOM2"
	BathingAnimationStyleArray[4] = "$BIS_L_BATHING_ANIM_STYLE_CUSTOM3"

	; showering animation styles
	ShoweringAnimationStyleArray = new String[3]
	ShoweringAnimationStyleArray[0] = "$BIS_L_SHOWERING_ANIM_STYLE_NONE"
	ShoweringAnimationStyleArray[1] = "$BIS_L_SHOWERING_ANIM_STYLE_DEFAULT"
	ShoweringAnimationStyleArray[2] = "$BIS_L_SHOWERING_ANIM_STYLE_CUSTOM1"

	; soap effect styles
	GetSoapyStyleArray = new String[3]
	GetSoapyStyleArray[0] = "$BIS_L_SOAP_STYLE_NONE"
	GetSoapyStyleArray[1] = "$BIS_L_SOAP_STYLE_STATIC"
	GetSoapyStyleArray[2] = "$BIS_L_SOAP_STYLE_ANIMATED"
	
	; undress array
	UndressArmorSlotArray = new Bool[32]
	UndressArmorSlotArrayFollowers = new Bool[32]
	UndressArmorSlotToggleIDs = new Int[32]
	UndressArmorSlotToggleIDsFollowers = new Int[32]

	; tracked actors array
	TrackedActorsToggleIDs = new Int[128]
EndEvent
Event OnVersionUpdate(Int Version)
	OnConfigInit()

	; 1.02
	If Version >= 2 && CurrentVersion < 2
		Debug.Trace(Self + ": Updating Bathing in Skyrim to version 1.02")
		; n/a
		Debug.Trace(Self + ": Update complete")
	EndIf
	
	; 1.03
	If Version >= 3 && CurrentVersion < 3
		Debug.Trace(Self + ": Updating Bathing in Skyrim to version 1.03")
		
		RemoveSpells(Game.GetPlayer(), LegacySpellList)
		
		DisableBathingInSkyrim()
		EnableBathingInSkyrim()
		
		AddSoapToVendors()
		
		Debug.Trace(Self + ": Update complete")
	EndIf
	
	; 1.04
	If Version >= 4 && CurrentVersion < 4
		Debug.Trace(Self + ": Updating Bathing in Skyrim to version 1.04")
		; n/a
		Debug.Trace(Self + ": Update complete")
	EndIf

	; 1.05
	If Version >= 5 && CurrentVersion < 5
		Debug.Trace(Self + ": Updating Bathing in Skyrim to version 1.05")
		
		Bool WasEnabled = BathingInSkyrimEnabled.GetValue() As Bool		

		CheckStatusQuest.UnregisterHotKeys()
		CheckStatusQuest.Stop()
		
		DisableBathingInSkyrim()
		If WasEnabled
			Utility.WaitMenuMode(0.1)
			EnableBathingInSkyrim()
		EndIf

		Debug.Trace(Self + ": Update complete")
	EndIf

	; 1.10
	If Version >= 10 && CurrentVersion < 10
		Debug.Trace(Self + ": Updating Bathing in Skyrim to version 1.10")

		Int Index = 0
		While Index != DirtyActors.GetSize()
			Actor DirtyActor = DirtyActors.GetAt(Index) As Actor
			RemoveSpells(DirtyActor, LegacySpellList)
		EndWhile

		Bool WasEnabled = BathingInSkyrimEnabled.GetValue() As Bool
		DisableBathingInSkyrim()
		If WasEnabled
			Utility.WaitMenuMode(0.1)
			EnableBathingInSkyrim()
		EndIf

		BatheQuest.UpdateDangerousWater()

		Debug.Trace(Self + ": Update complete")
	EndIf

	; 1.11
	If Version >= 11 && CurrentVersion < 11
		Debug.Trace(Self + ": Updating Bathing in Skyrim to version 1.11")
		BatheQuest.UpdateDangerousWater()
		Debug.Trace(Self + ": Update complete")
	EndIf
EndEvent
Event OnPageReset(String Page)
	If Page == ""
		DisplaySplashPage()
	ElseIf Page == "$BIS_PAGE_SETTINGS"
		DisplaySettingsPage()
	ElseIf Page == "$BIS_PAGE_ANIMATIONS"
		DisplayAnimationsPage()
	ElseIf Page == "$BIS_PAGE_ANIMATIONS_FOLLOWERS"
		DisplayAnimationsPageFollowers()
	ElseIf Page == "$BIS_PAGE_TRACKED_ACTORS"
		DisplayTrackedActorsPage()
	EndIf		
EndEvent
Event OnConfigClose()
EndEvent

; fiss functions
Function SaveSettings()
	FISSInterface FISS = FISSFactory.GetFISS()
	If FISS == None
		ShowMessage("$BIS_ERROR_NO_FISS")
		Return
	EndIf

	If ShowMessage("$BIS_MSG_ASK_SAVE", True) == False
		Return
	EndIf

	FISS.BeginSave("Bathing in Skyrim.xml", "Bathing in Skyrim")

	FISS.SaveInt("BathingInSkyrimEnabled", BathingInSkyrimEnabled.GetValue() As Int)
	FISS.SaveInt("DialogTopicEnabled", DialogTopicEnabled.GetValue() As Int)
	FISS.SaveInt("WaterRestrictionEnabled", WaterRestrictionEnabled.GetValue() As Int)

	FISS.SaveInt("GetSoapyStyle", GetSoapyStyle.GetValue() As Int)
	FISS.SaveInt("GetSoapyStyleFollowers", GetSoapyStyleFollowers.GetValue() As Int)

	FISS.SaveInt("CheckStatusKeyCode", CheckStatusKeyCode.GetValue() As Int)
	FISS.SaveInt("BatheKeyCode", BatheKeyCode.GetValue() As Int)
	FISS.SaveInt("ShowerKeyCode", ShowerKeyCode.GetValue() As Int)

	FISS.SaveInt("BathingAnimationStyle", BathingAnimationStyle.GetValue() As Int)
	FISS.SaveInt("BathingAnimationStyleFollowers", BathingAnimationStyleFollowers.GetValue() As Int)
	FISS.SaveInt("ShoweringAnimationStyle", ShoweringAnimationStyle.GetValue() As Int)
	FISS.SaveInt("ShoweringAnimationStyleFollowers", ShoweringAnimationStyleFollowers.GetValue() As Int)

	FISS.SaveInt("GetDressedAfterBathingEnabled", GetDressedAfterBathingEnabled.GetValue() As Int)
	FISS.SaveInt("GetDressedAfterBathingEnabledFollowers", GetDressedAfterBathingEnabledFollowers.GetValue() As Int)
	FISS.SaveInt("BathingIgnoredArmorSlotsMask", BathingIgnoredArmorSlotsMask.GetValue() As Int)
	FISS.SaveInt("BathingIgnoredArmorSlotsMaskFollowers", BathingIgnoredArmorSlotsMaskFollowers.GetValue() As Int)

	FISS.SaveFloat("DirtinessUpdateInterval", DirtinessUpdateInterval.GetValue() As Float)
	FISS.SaveFloat("DirtinessPercentage", DirtinessPercentage.GetValue() As Float)
	FISS.SaveFloat("DirtinessPerHourSettlement", DirtinessPerHourSettlement.GetValue() As Float)
	FISS.SaveFloat("DirtinessPerHourDungeon", DirtinessPerHourDungeon.GetValue() As Float)
	FISS.SaveFloat("DirtinessPerHourWilderness", DirtinessPerHourWilderness.GetValue() As Float)

	FISS.SaveFloat("DirtinessThreshold0", (DirtinessThresholdList.GetAt(0) As GlobalVariable).GetValue() As Float)
	FISS.SaveFloat("DirtinessThreshold1", (DirtinessThresholdList.GetAt(1) As GlobalVariable).GetValue() As Float)
	FISS.SaveFloat("DirtinessThreshold2", (DirtinessThresholdList.GetAt(2) As GlobalVariable).GetValue() As Float)

	FISS.SaveInt("BathingAnimationLoopCount0", (BathingAnimationLoopCountList.GetAt(0) As GlobalVariable).GetValue() As Int)
	FISS.SaveInt("BathingAnimationLoopCount1", (BathingAnimationLoopCountList.GetAt(1) As GlobalVariable).GetValue() As Int)
	FISS.SaveInt("BathingAnimationLoopCount2", (BathingAnimationLoopCountList.GetAt(2) As GlobalVariable).GetValue() As Int)
	FISS.SaveInt("BathingAnimationLoopCount3", (BathingAnimationLoopCountList.GetAt(3) As GlobalVariable).GetValue() As Int)

	FISS.SaveInt("BathingAnimationLoopCountFollowers0", (BathingAnimationLoopCountListFollowers.GetAt(0) As GlobalVariable).GetValue() As Int)
	FISS.SaveInt("BathingAnimationLoopCountFollowers1", (BathingAnimationLoopCountListFollowers.GetAt(1) As GlobalVariable).GetValue() As Int)
	FISS.SaveInt("BathingAnimationLoopCountFollowers2", (BathingAnimationLoopCountListFollowers.GetAt(2) As GlobalVariable).GetValue() As Int)
	FISS.SaveInt("BathingAnimationLoopCountFollowers3", (BathingAnimationLoopCountListFollowers.GetAt(3) As GlobalVariable).GetValue() As Int)

	String Result = FISS.EndSave()

	If Result != ""
		Debug.Trace(Result)
	EndIf

	ShowMessage("$BIS_MSG_COMPLETED_SAVE", False)
	ForcePageReset()
EndFunction
Function LoadSettings()
	FISSInterface FISS = FISSFactory.GetFISS()
	If FISS == None
		ShowMessage("$BIS_ERROR_NO_FISS")
		Return
	EndIf

	If ShowMessage("$BIS_MSG_ASK_LOAD", True) == False
		Return
	EndIf

	FISS.BeginLoad("Bathing in Skyrim.xml")

	BathingInSkyrimEnabled.SetValue(FISS.LoadInt("BathingInSkyrimEnabled"))
	DialogTopicEnabled.SetValue(FISS.LoadInt("DialogTopicEnabled"))
	WaterRestrictionEnabled.SetValue(FISS.LoadInt("WaterRestrictionEnabled"))

	GetSoapyStyle.SetValue(FISS.LoadInt("GetSoapyStyle"))
	GetSoapyStyleFollowers.SetValue(FISS.LoadInt("GetSoapyStyleFollowers"))

	CheckStatusKeyCode.SetValue(FISS.LoadInt("CheckStatusKeyCode"))
	BatheKeyCode.SetValue(FISS.LoadInt("BatheKeyCode"))
	ShowerKeyCode.SetValue(FISS.LoadInt("ShowerKeyCode"))

	BathingAnimationStyle.SetValue(FISS.LoadInt("BathingAnimationStyle"))
	BathingAnimationStyleFollowers.SetValue(FISS.LoadInt("BathingAnimationStyleFollowers"))
	ShoweringAnimationStyle.SetValue(FISS.LoadInt("ShoweringAnimationStyle"))
	ShoweringAnimationStyleFollowers.SetValue(FISS.LoadInt("ShoweringAnimationStyleFollowers"))

	GetDressedAfterBathingEnabled.SetValue(FISS.LoadInt("GetDressedAfterBathingEnabled"))
	GetDressedAfterBathingEnabledFollowers.SetValue(FISS.LoadInt("GetDressedAfterBathingEnabledFollowers"))
	BathingIgnoredArmorSlotsMask.SetValue(FISS.LoadInt("BathingIgnoredArmorSlotsMask"))
	BathingIgnoredArmorSlotsMaskFollowers.SetValue(FISS.LoadInt("BathingIgnoredArmorSlotsMaskFollowers"))

	DirtinessUpdateInterval.SetValue(FISS.LoadFloat("DirtinessUpdateInterval"))
	DirtinessPercentage.SetValue(FISS.LoadFloat("DirtinessPercentage"))
	DirtinessPerHourSettlement.SetValue(FISS.LoadFloat("DirtinessPerHourSettlement"))
	DirtinessPerHourDungeon.SetValue(FISS.LoadFloat("DirtinessPerHourDungeon"))
	DirtinessPerHourWilderness.SetValue(FISS.LoadFloat("DirtinessPerHourWilderness"))

	(DirtinessThresholdList.GetAt(0) As GlobalVariable).SetValue(FISS.LoadFloat("DirtinessThreshold0"))
	(DirtinessThresholdList.GetAt(1) As GlobalVariable).SetValue(FISS.LoadFloat("DirtinessThreshold1"))
	(DirtinessThresholdList.GetAt(2) As GlobalVariable).SetValue(FISS.LoadFloat("DirtinessThreshold2"))

	(BathingAnimationLoopCountList.GetAt(0) As GlobalVariable).SetValue(FISS.LoadInt("BathingAnimationLoopCount0"))
	(BathingAnimationLoopCountList.GetAt(1) As GlobalVariable).SetValue(FISS.LoadInt("BathingAnimationLoopCount1"))
	(BathingAnimationLoopCountList.GetAt(2) As GlobalVariable).SetValue(FISS.LoadInt("BathingAnimationLoopCount2"))
	(BathingAnimationLoopCountList.GetAt(3) As GlobalVariable).SetValue(FISS.LoadInt("BathingAnimationLoopCount3"))

	(BathingAnimationLoopCountListFollowers.GetAt(0) As GlobalVariable).SetValue(FISS.LoadInt("BathingAnimationLoopCountFollowers0"))
	(BathingAnimationLoopCountListFollowers.GetAt(1) As GlobalVariable).SetValue(FISS.LoadInt("BathingAnimationLoopCountFollowers1"))
	(BathingAnimationLoopCountListFollowers.GetAt(2) As GlobalVariable).SetValue(FISS.LoadInt("BathingAnimationLoopCountFollowers2"))
	(BathingAnimationLoopCountListFollowers.GetAt(3) As GlobalVariable).SetValue(FISS.LoadInt("BathingAnimationLoopCountFollowers3"))

	String Result = FISS.EndLoad()

	If Result != ""
		Debug.Trace(Result)
	EndIf

	BatheQuest.UpdateDangerousWater()

	ShowMessage("$BIS_MSG_COMPLETED_LOAD", False)
	ForcePageReset()
EndFunction

; display pages
Function DisplaySplashPage()
	UnloadCustomContent()
	LoadCustomContent("Bathing in Skyrim.dds", 56, 63)
EndFunction
Function DisplayAnimationsPage()
	UnloadCustomContent()
	
	SetCursorFillMode(TOP_TO_BOTTOM)
		
	AddHeaderOption("$BIS_HEADER_ANIM_STYLE")
	BathingAnimationStyleMenuID = AddMenuOption("$BIS_L_BATHING_ANIM_STYLE", BathingAnimationStyleArray[BathingAnimationStyle.GetValue() As Int])
	ShoweringAnimationStyleMenuID = AddMenuOption("$BIS_L_SHOWERING_ANIM_STYLE", ShoweringAnimationStyleArray[ShoweringAnimationStyle.GetValue() As Int])
	GetSoapyStyleMenuID = AddMenuOption("$BIS_L_SOAP_STYLE", GetSoapyStyleArray[GetSoapyStyle.GetValue() As Int])
	AddHeaderOption("$BIS_HEADER_ANIM_LOOP")
	BathingAnimationLoopsTier0SliderID = AddSliderOption("$BIS_L_ANIM_LOOP_CLEAN", (BathingAnimationLoopCountList.GetAt(0) As GlobalVariable).GetValue(), "{0}")
	BathingAnimationLoopsTier1SliderID = AddSliderOption("$BIS_L_ANIM_LOOP_NOT_DIRTY", (BathingAnimationLoopCountList.GetAt(1) As GlobalVariable).GetValue(), "{0}")
	BathingAnimationLoopsTier2SliderID = AddSliderOption("$BIS_L_ANIM_LOOP_DIRTY", (BathingAnimationLoopCountList.GetAt(2) As GlobalVariable).GetValue(), "{0}")
	BathingAnimationLoopsTier3SliderID = AddSliderOption("$BIS_L_ANIM_LOOP_FILTHY", (BathingAnimationLoopCountList.GetAt(3) As GlobalVariable).GetValue(), "{0}")

	SetCursorPosition(1)

	UndressArmorSlotArray = GetUnignoredArmorSlots(BathingIgnoredArmorSlotsMask)	

	AddHeaderOption("$BIS_HEADER_GET_DRESSED")
	GetDressedAfterBathingEnabledToggleID = AddToggleOption("$BIS_L_ENABLED", GetDressedAfterBathingEnabled.GetValue() As Bool)	
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
	UnloadCustomContent()
	
	SetCursorFillMode(TOP_TO_BOTTOM)
		
	AddHeaderOption("$BIS_HEADER_ANIM_STYLE_FOLLOWERS")
	BathingAnimationStyleMenuIDFollowers = AddMenuOption("$BIS_L_BATHING_ANIM_STYLE", BathingAnimationStyleArray[BathingAnimationStyleFollowers.GetValue() As Int])
	ShoweringAnimationStyleMenuIDFollowers = AddMenuOption("$BIS_L_SHOWERING_ANIM_STYLE", ShoweringAnimationStyleArray[ShoweringAnimationStyleFollowers.GetValue() As Int])
	GetSoapyStyleMenuIDFollowers = AddMenuOption("$BIS_L_SOAP_STYLE", GetSoapyStyleArray[GetSoapyStyleFollowers.GetValue() As Int])
	AddHeaderOption("$BIS_HEADER_ANIM_LOOP")
	BathingAnimationLoopsTier0SliderIDFollowers = AddSliderOption("$BIS_L_ANIM_LOOP_CLEAN", (BathingAnimationLoopCountListFollowers.GetAt(0) As GlobalVariable).GetValue(), "{0}")
	BathingAnimationLoopsTier1SliderIDFollowers = AddSliderOption("$BIS_L_ANIM_LOOP_NOT_DIRTY", (BathingAnimationLoopCountListFollowers.GetAt(1) As GlobalVariable).GetValue(), "{0}")
	BathingAnimationLoopsTier2SliderIDFollowers = AddSliderOption("$BIS_L_ANIM_LOOP_DIRTY", (BathingAnimationLoopCountListFollowers.GetAt(2) As GlobalVariable).GetValue(), "{0}")
	BathingAnimationLoopsTier3SliderIDFollowers = AddSliderOption("$BIS_L_ANIM_LOOP_FILTHY", (BathingAnimationLoopCountListFollowers.GetAt(3) As GlobalVariable).GetValue(), "{0}")

	SetCursorPosition(1)

	UndressArmorSlotArrayFollowers = GetUnignoredArmorSlots(BathingIgnoredArmorSlotsMaskFollowers)	

	AddHeaderOption("$BIS_HEADER_GET_DRESSED")
	GetDressedAfterBathingEnabledToggleIDFollowers = AddToggleOption("$BIS_L_ENABLED", GetDressedAfterBathingEnabledFollowers.GetValue() As Bool)	
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
	Int SaveLoadOptionFlag = OPTION_FLAG_NONE
	If FISSFactory.GetFISS() == None
		SaveLoadOptionFlag = OPTION_FLAG_DISABLED
	EndIf

	UnloadCustomContent()
	
	SetCursorFillMode(TOP_TO_BOTTOM)
	
	AddHeaderOption("$BIS_HEADER_GENERAL")
	BathingInSkyrimEnableToggleID = AddToggleOption("$BIS_L_ENABLED", BathingInSkyrimEnabled.GetValue() As Bool)
	DialogTopicEnableToggleID = AddToggleOption("$BIS_L_ENABLED_DIALOG_TOPIC", DialogTopicEnabled.GetValue() As Bool)
	WaterRestrictionEnableToggleID = AddToggleOption("$BIS_L_WATER_RESTRICT",WaterRestrictionEnabled.GetValue() As Bool)
	UpdateIntervalSliderID = AddSliderOption("$BIS_L_UPDATE_INTERVAL", DirtinessUpdateInterval.GetValue(), DisplayFormatDecimal)
	AddHeaderOption("$BIS_HEADER_HOTKEYS")
	CheckStatusKeyMapID = AddKeyMapOption("$BIS_L_STATUS_HOTKEY", CheckStatusKeyCode.GetValue() As Int)
	BatheKeyMapID = AddKeyMapOption("$BIS_L_BATHE_HOTKEY", BatheKeyCode.GetValue() As Int)
	ShowerKeyMapID = AddKeyMapOption("$BIS_L_SHOWER_HOTKEY", ShowerKeyCode.GetValue() As Int)
	AddHeaderOption("$BIS_HEADER_SAVELOAD")
	If FISSFactory.GetFISS()
		SaveSettingsID = AddTextOption("$BIS_L_SAVE_SETTINGS", "$BIS_L_SAVE", SaveLoadOptionFlag)
		LoadSettingsID = AddTextOption("$BIS_L_LOAD_SETTINGS", "$BIS_L_LOAD", SaveLoadOptionFlag)
	Else
		AddTextOption("$BIS_ERROR_NO_FISS", "", OPTION_FLAG_DISABLED)
	EndIf

	SetCursorPosition(1)

	AddHeaderOption("$BIS_HEADER_DIRT_RATE")
	DirtinessPerHourSettlementSliderID = AddSliderOption("$BIS_L_IN_SETTLEMENTS", DirtinessPerHourSettlement.GetValue() * 100, DisplayFormatPercentage)
	DirtinessPerHourDungeonSliderID = AddSliderOption("$BIS_L_IN_DUNGEONS", DirtinessPerHourDungeon.GetValue() * 100, DisplayFormatPercentage)
	DirtinessPerHourWildernessSliderID = AddSliderOption("$BIS_L_IN_WILDERNESS", DirtinessPerHourWilderness.GetValue() * 100, DisplayFormatPercentage)
	AddHeaderOption("$BIS_HEADER_DIRT_THRESHOLDS")
	DirtinessThresholdTier1SliderID = AddSliderOption("$BIS_L_GET_NOT_DIRTY", (DirtinessThresholdList.GetAt(0) As GlobalVariable).GetValue() * 100, DisplayFormatPercentage)
	DirtinessThresholdTier2SliderID = AddSliderOption("$BIS_L_GET_DIRTY", (DirtinessThresholdList.GetAt(1) As GlobalVariable).GetValue() * 100, DisplayFormatPercentage)
	DirtinessThresholdTier3SliderID = AddSliderOption("$BIS_L_GET_FILTHY", (DirtinessThresholdList.GetAt(2) As GlobalVariable).GetValue() * 100, DisplayFormatPercentage)
EndFunction
Function DisplayTrackedActorsPage()
	Int TrackedActorsCount = DirtyActors.GetSize()
	If TrackedActorsCount > 128
		TrackedActorsCount = 128
	EndIf

	UnloadCustomContent()
	
	SetCursorFillMode(TOP_TO_BOTTOM)

	AddHeaderOption("$BIS_HEADER_TRACKED_ACTORS")
	Int Index = TrackedActorsCount
	While Index
		Index -= 1
		Actor DirtyActor = DirtyActors.GetAt(Index) As Actor
		String DirtinessString = ""
		If DirtyActor.HasSpell(DirtinessSpellList.GetAt(0) As Spell)
			DirtinessString = "Clean"
		EndIf
		If DirtyActor.HasSpell(DirtinessSpellList.GetAt(1) As Spell)
			DirtinessString = "Not Dirty"
		EndIf
		If DirtyActor.HasSpell(DirtinessSpellList.GetAt(2) As Spell)
			DirtinessString = "Dirty"
		EndIf
		If DirtyActor.HasSpell(DirtinessSpellList.GetAt(3) As Spell)
			DirtinessString = "Filthy"
		EndIf
		TrackedActorsToggleIDs[Index] = AddTextOption(DirtyActor.GetActorBase().GetName(), DirtinessString, OPTION_FLAG_NONE)
	EndWhile
EndFunction

; OnOptionDefault
Event OnOptionDefault(Int OptionID)
	If CurrentPage == "$BIS_PAGE_SETTINGS"
		HandleOnOptionDefaultSettingsPage(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_ANIMATIONS"
		HandleOnOptionDefaultAnimationsPage(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_ANIMATIONS_FOLLOWERS"
		HandleOnOptionDefaultAnimationsPageFollowers(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_TRACKED_ACTORS"
		HandleOnOptionDefaultTrackedActorsPage(OptionID)
	EndIf
EndEvent
Function HandleOnOptionDefaultAnimationsPage(Int OptionID)
	; menus
	If OptionID == BathingAnimationStyleMenuID
		BathingAnimationStyle.SetValue(1)
		SetMenuOptionValue(OptionID, BathingAnimationStyleArray[BathingAnimationStyle.GetValue() As Int])
	ElseIf OptionID == ShoweringAnimationStyleMenuID
		ShoweringAnimationStyle.SetValue(1)
		SetMenuOptionValue(OptionID, ShoweringAnimationStyleArray[ShoweringAnimationStyle.GetValue() As Int])
	ElseIf OptionID == GetSoapyStyleMenuID
		GetSoapyStyle.SetValue(1)
		SetMenuOptionValue(OptionID, GetSoapyStyleArray[GetSoapyStyle.GetValue() As Int])

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

	; toggles
	ElseIf OptionID == GetDressedAfterBathingEnabledToggleID
		GetDressedAfterBathingEnabled.SetValue(1)
		SetToggleOptionValue(OptionID, GetDressedAfterBathingEnabled.GetValue() As Bool)
	Else 
		Int UndressArmorSlotIndex = UndressArmorSlotToggleIDs.Find(OptionID)
		If UndressArmorSlotIndex >= 0
			If UndressArmorSlotIndex <= 13 ; undress 30-43 by default
				IgnoreArmorSlot(BathingIgnoredArmorSlotsMask, UndressArmorSlotIndex + 30, False)
				SetToggleOptionValue(OptionID, True)
			Else ; ignore 44-62 by default
				IgnoreArmorSlot(BathingIgnoredArmorSlotsMask, UndressArmorSlotIndex + 30, True)
				SetToggleOptionValue(OptionID, False)
			EndIf
		EndIf
	EndIf	
EndFunction
Function HandleOnOptionDefaultAnimationsPageFollowers(Int OptionID)	
	; menus
	If OptionID == BathingAnimationStyleMenuIDFollowers
		BathingAnimationStyleFollowers.SetValue(1)
		SetMenuOptionValue(OptionID, BathingAnimationStyleArray[BathingAnimationStyleFollowers.GetValue() As Int])
	ElseIf OptionID == ShoweringAnimationStyleMenuIDFollowers
		ShoweringAnimationStyleFollowers.SetValue(1)
		SetMenuOptionValue(OptionID, BathingAnimationStyleArray[BathingAnimationStyleFollowers.GetValue() As Int])
	ElseIf OptionID == GetSoapyStyleMenuIDFollowers
		GetSoapyStyleFollowers.SetValue(1)
		SetMenuOptionValue(OptionID, GetSoapyStyleArray[GetSoapyStyleFollowers.GetValue() As Int])

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

	; toggles
	ElseIf OptionID == GetDressedAfterBathingEnabledToggleIDFollowers
		GetDressedAfterBathingEnabledFollowers.SetValue(1)
		SetToggleOptionValue(OptionID, GetDressedAfterBathingEnabledFollowers.GetValue() As Bool)
	Else 
		Int UndressArmorSlotIndex = UndressArmorSlotToggleIDsFollowers.Find(OptionID)
		If UndressArmorSlotIndex >= 0
			If UndressArmorSlotIndex <= 13 ; undress 30-43 by default
				IgnoreArmorSlot(BathingIgnoredArmorSlotsMaskFollowers, UndressArmorSlotIndex + 30, False)
				SetToggleOptionValue(OptionID, True)
			Else ; ignore 44-62 by default
				IgnoreArmorSlot(BathingIgnoredArmorSlotsMaskFollowers, UndressArmorSlotIndex + 30, True)
				SetToggleOptionValue(OptionID, False)
			EndIf
		EndIf
	EndIf	
EndFunction
Function HandleOnOptionDefaultSettingsPage(Int OptionID)
	; toggles
	If OptionID == BathingInSkyrimEnableToggleID
		BathingInSkyrimEnabled.SetValue(1)
		SetToggleOptionValue(OptionID, BathingInSkyrimEnabled.GetValue() As Bool)
		EnableBathingInSkyrim()
	ElseIf OptionID == DialogTopicEnableToggleID
		DialogTopicEnabled.SetValue(1)
		SetToggleOptionValue(OptionID, DialogTopicEnabled.GetValue() As Bool)
	ElseIf OptionID == WaterRestrictionEnableToggleID
		WaterRestrictionEnabled.SetValue(1)
		SetToggleOptionValue(OptionID, WaterRestrictionEnabled.GetValue() As Bool)
		BatheQuest.UpdateDangerousWater()
	
	; sliders
	ElseIf OptionID == UpdateIntervalSliderID
		DirtinessUpdateInterval.SetValue(1.0)
		SetSliderOptionValue(OptionID, DirtinessUpdateInterval.GetValue(), DisplayFormatDecimal)
	ElseIf OptionID == DirtinessPerHourSettlementSliderID
		DirtinessPerHourSettlement.SetValue(0.01)
		SetSliderOptionValue(OptionID, DirtinessPerHourSettlement.GetValue() * 100, DisplayFormatPercentage)
	ElseIf OptionID == DirtinessPerHourDungeonSliderID
		DirtinessPerHourDungeon.SetValue(0.025)
		SetSliderOptionValue(OptionID, DirtinessPerHourDungeon.GetValue() * 100, DisplayFormatPercentage)
	ElseIf OptionID == DirtinessPerHourWildernessSliderID
		DirtinessPerHourWilderness.SetValue(0.015)
		SetSliderOptionValue(OptionID, DirtinessPerHourWilderness.GetValue() * 100, DisplayFormatPercentage)
	ElseIf OptionID == DirtinessThresholdTier1SliderID
		(DirtinessThresholdList.GetAt(0) As GlobalVariable).SetValue(0.20)
		SetSliderOptionValue(OptionID, (DirtinessThresholdList.GetAt(0) As GlobalVariable).GetValue() * 100, DisplayFormatPercentage)
	ElseIf OptionID == DirtinessThresholdTier2SliderID
		(DirtinessThresholdList.GetAt(1) As GlobalVariable).SetValue(0.60)
		SetSliderOptionValue(OptionID, (DirtinessThresholdList.GetAt(1) As GlobalVariable).GetValue() * 100, DisplayFormatPercentage)
	ElseIf OptionID == DirtinessThresholdTier3SliderID
		(DirtinessThresholdList.GetAt(2) As GlobalVariable).SetValue(0.98)
		SetSliderOptionValue(OptionID, (DirtinessThresholdList.GetAt(2) As GlobalVariable).GetValue() * 100, DisplayFormatPercentage)			
	EndIf
EndFunction
Function HandleOnOptionDefaultTrackedActorsPage(Int OptionID)
EndFunction

; OnOptionHighlight
Event OnOptionHighlight(Int OptionID)
	If CurrentPage == "$BIS_PAGE_SETTINGS"
		HandleOnOptionHighlightSettingsPage(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_ANIMATIONS"
		HandleOnOptionHighlightAnimationsPage(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_ANIMATIONS_FOLLOWERS"
		HandleOnOptionHighlightAnimationsPageFollowers(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_TRACKED_ACTORS"
		HandleOnOptionHighlightTrackedActorsPage(OptionID)
	EndIf	
EndEvent
Function HandleOnOptionHighlightAnimationsPage(Int OptionID)
	If OptionID == BathingAnimationStyleMenuID
		SetInfoText("$BIS_DESC_BATHING_ANIM_STYLE")
	ElseIf OptionID == ShoweringAnimationStyleMenuID
		SetInfoText("$BIS_DESC_SHOWERING_ANIM_STYLE")
	ElseIf OptionID == GetSoapyStyleMenuID
		SetInfoText("$BIS_DESC_SOAP_STYLE")
	ElseIf OptionId == BathingAnimationLoopsTier0SliderID
		SetInfoText("$BIS_DESC_ANIM_LOOP_TIER0")
	ElseIf OptionId == BathingAnimationLoopsTier1SliderID
		SetInfoText("$BIS_DESC_ANIM_LOOP_TIER1")
	ElseIf OptionId == BathingAnimationLoopsTier2SliderID
		SetInfoText("$BIS_DESC_ANIM_LOOP_TIER2")
	ElseIf OptionId == BathingAnimationLoopsTier3SliderID
		SetInfoText("$BIS_DESC_ANIM_LOOP_TIER3")
	ElseIf OptionID == GetDressedAfterBathingEnabledToggleID
		SetInfoText("$BIS_DESC_GET_DRESSED")
	Else
		SetInfoText("$BIS_DESC_GET_NAKED")
	EndIf
EndFunction
Function HandleOnOptionHighlightAnimationsPageFollowers(Int OptionID)
	If OptionID == BathingAnimationStyleMenuIDFollowers
		SetInfoText("$BIS_DESC_BATHING_ANIM_STYLE")
	ElseIf OptionID == ShoweringAnimationStyleMenuIDFollowers
		SetInfoText("$BIS_DESC_SHOWERING_ANIM_STYLE")
	ElseIf OptionID == GetSoapyStyleMenuIDFollowers
		SetInfoText("$BIS_DESC_SOAP_STYLE")
	ElseIf OptionId == BathingAnimationLoopsTier0SliderIDFollowers
		SetInfoText("$BIS_DESC_ANIM_LOOP_TIER0")
	ElseIf OptionId == BathingAnimationLoopsTier1SliderIDFollowers
		SetInfoText("$BIS_DESC_ANIM_LOOP_TIER1")
	ElseIf OptionId == BathingAnimationLoopsTier2SliderIDFollowers
		SetInfoText("$BIS_DESC_ANIM_LOOP_TIER2")
	ElseIf OptionId == BathingAnimationLoopsTier3SliderIDFollowers
		SetInfoText("$BIS_DESC_ANIM_LOOP_TIER3")
	ElseIf OptionID == GetDressedAfterBathingEnabledToggleIDFollowers
		SetInfoText("$BIS_DESC_GET_DRESSED")
	Else
		SetInfoText("$BIS_DESC_GET_NAKED")
	EndIf
EndFunction
Function HandleOnOptionHighlightSettingsPage(Int OptionID)
	If OptionID == BathingInSkyrimEnableToggleID
		SetInfoText("$BIS_DESC_ENABLE_MOD")
	ElseIf OptionID == DialogTopicEnableToggleID
		SetInfoText("$BIS_DESC_ENABLE_DIALOG_TOPIC")
	ElseIf OptionID == WaterRestrictionEnableToggleID
		SetInfoText("$BIS_DESC_WATER_RESTRICT")
	ElseIf OptionID == UpdateIntervalSliderID
		SetInfoText("$BIS_DESC_UPDATE_INTERVAL")
	ElseIf OptionID == CheckStatusKeyMapID
		SetInfoText("$BIS_DESC_STATUS_HOTKEY")
	ElseIf OptionID == BatheKeyMapID
		SetInfoText("$BIS_DESC_BATHE_HOTKEY")
	ElseIf OptionID == ShowerKeyMapID
		SetInfoText("$BIS_DESC_SHOWER_HOTKEY")
	ElseIf OptionID == SaveSettingsID
		SetInfoText("$BIS_DESC_SAVE_SETTINGS")
	ElseIf OptionID == LoadSettingsID
		SetInfoText("$BIS_DESC_LOAD_SETTINGS")
	ElseIf OptionID == DirtinessPerHourSettlementSliderID
		SetInfoText("$BIS_DESC_RATE_IN_SETTLEMENT")
	ElseIf OptionID == DirtinessPerHourDungeonSliderID
		SetInfoText("$BIS_DESC_RATE_IN_DUNGEON")
	ElseIf OptionID == DirtinessPerHourWildernessSliderID
		SetInfoText("$BIS_DESC_RATE_IN_WILDERNESS")
	ElseIf OptionId == DirtinessThresholdTier1SliderID
		SetInfoText("$BIS_DESC_THRESHOLD_1")
	ElseIf OptionId == DirtinessThresholdTier2SliderID
		SetInfoText("$BIS_DESC_THRESHOLD_2")
	ElseIf OptionId == DirtinessThresholdTier3SliderID
		SetInfoText("$BIS_DESC_THRESHOLD_3")
	EndIf
EndFunction
Function HandleOnOptionHighlightTrackedActorsPage(Int OptionID)
	Int Index = TrackedActorsToggleIDs.Find(OptionID)	
	If Index >= 0
		If TrackedActorsToggleValuesArray[Index] == False
			SetInfoText("$BIS_DESC_STOP_TRACKING_ACTOR")
		EndIf
	EndIf
EndFunction

; OnOptionKeyMapChange
Event OnOptionKeyMapChange(Int OptionID, Int KeyCode, String ConflictControl, String ConflictName)
	Bool Continue = True
	
	If ConflictControl != ""			
		String ConflictMessage = "This key is already mapped to:\n" + ConflictControl
		
		If ConflictName != ""
			 ConflictMessage += "\n(" + ConflictName + ")"
		EndIf

		ConflictMessage += "\n\nAre you sure you want to continue?"

		Continue = ShowMessage(ConflictMessage, True)			
	EndIf
	
	If Continue == True
		If OptionID == CheckStatusKeyMapID
			CheckStatusKeyCode.Value = KeyCode
		ElseIf OptionID == BatheKeyMapID
			BatheKeyCode.Value = KeyCode
			
		ElseIf OptionID == ShowerKeyMapID
			ShowerKeyCode.Value = KeyCode
		EndIf
		BatheQuest.RegisterHotKeys()
		SetKeymapOptionValue(OptionID, KeyCode)
	EndIf
EndEvent

; OnOptionSelect
Event OnOptionSelect(Int OptionID)
	If CurrentPage == "$BIS_PAGE_SETTINGS"
		HandleOnOptionSelectSettingsPage(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_ANIMATIONS"
		HandleOnOptionSelectAnimationsPage(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_ANIMATIONS_FOLLOWERS"
		HandleOnOptionSelectAnimationsPageFollowers(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_TRACKED_ACTORS"
		HandleOnOptionSelectTrackedActorsPage(OptionID)
	EndIf	
EndEvent
Function HandleOnOptionSelectAnimationsPage(Int OptionID)
	If OptionID == GetDressedAfterBathingEnabledToggleID
		GetDressedAfterBathingEnabled.SetValue((!GetDressedAfterBathingEnabled.GetValue() As Bool) As Int)
		SetToggleOptionValue(OptionID, GetDressedAfterBathingEnabled.GetValue() As Bool)
	Else
		Int UndressArmorSlotIndex = UndressArmorSlotToggleIDs.Find(OptionID)
		If UndressArmorSlotIndex >= 0
			UndressArmorSlotArray[UndressArmorSlotIndex] = !UndressArmorSlotArray[UndressArmorSlotIndex]
			IgnoreArmorSlot(BathingIgnoredArmorSlotsMask, UndressArmorSlotIndex + 30, !UndressArmorSlotArray[UndressArmorSlotIndex])
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
			IgnoreArmorSlot(BathingIgnoredArmorSlotsMaskFollowers, UndressArmorSlotIndex + 30, !UndressArmorSlotArrayFollowers[UndressArmorSlotIndex])
			SetToggleOptionValue(OptionID, UndressArmorSlotArrayFollowers[UndressArmorSlotIndex])
		EndIf
	EndIf
EndFunction
Function HandleOnOptionSelectSettingsPage(Int OptionID)
	If OptionID == BathingInSkyrimEnableToggleID
		If BathingInSkyrimEnabled.GetValue() As Bool == True && ShowMessage("$BIS_MSG_ASK_DISABLE", True) == True
			BathingInSkyrimEnabled.SetValue(False As Int)
			DisableBathingInSkyrim()
		Else
			BathingInSkyrimEnabled.SetValue(True As Int)
			EnableBathingInSkyrim()
		EndIf
		SetToggleOptionValue(OptionID, BathingInSkyrimEnabled.GetValue() As Bool)
	ElseIf OptionID == DialogTopicEnableToggleID
		DialogTopicEnabled.SetValue((!DialogTopicEnabled.GetValue() As Bool) As Int)
		SetToggleOptionValue(OptionID, DialogTopicEnabled.GetValue() As Bool)
	ElseIf OptionID == WaterRestrictionEnableToggleID
		WaterRestrictionEnabled.SetValue((!WaterRestrictionEnabled.GetValue() As Bool) As Int)
		SetToggleOptionValue(OptionID, WaterRestrictionEnabled.GetValue() As Bool)
		BatheQuest.UpdateDangerousWater()
	ElseIf OptionID == SaveSettingsID
		SaveSettings()
	ElseIf OptionID == LoadSettingsID
		LoadSettings()
	EndIf	
EndFunction
Function HandleOnOptionSelectTrackedActorsPage(Int OptionID)
	Int Index = TrackedActorsToggleIDs.Find(OptionID)
	If Index >= 0
		If ShowMessage("$BIS_MSG_ASK_STOP_TRACK", True) == True
			Actor DirtyActor = DirtyActors.GetAt(Index) As Actor
			RemoveSpells(DirtyActor, GetDirtyOverTimeSpellList)
			RemoveSpells(DirtyActor, DirtinessSpellList)
			RemoveSpells(DirtyActor, SoapBonusSpellList)
			RemoveSpells(DirtyActor, LegacySpellList)
			DirtyActors.RemoveAddedForm(DirtyActor)
			ForcePageReset()
		EndIf
	EndIf
EndFunction

; OnOptionMenuAccept
Event OnOptionMenuAccept(Int OptionID, Int MenuItemIndex)
	If CurrentPage == "$BIS_PAGE_ANIMATIONS"
		HandleOnOptionMenuAcceptAnimationsPage(OptionID, MenuItemIndex)
	ElseIf CurrentPage == "$BIS_PAGE_ANIMATIONS_FOLLOWERS"
		HandleOnOptionMenuAcceptAnimationsPageFollowers(OptionID, MenuItemIndex)
	EndIf
EndEvent
Function HandleOnOptionMenuAcceptAnimationsPage(Int OptionID, Int MenuItemIndex)
	If OptionID == BathingAnimationStyleMenuID
		If MenuItemIndex >= 0 && MenuItemIndex < BathingAnimationStyleArray.Length
			SetMenuOptionValue(OptionID, BathingAnimationStyleArray[MenuItemIndex])
			BathingAnimationStyle.SetValue(MenuItemIndex)
		EndIf
	ElseIf OptionID == ShoweringAnimationStyleMenuID
		If MenuItemIndex >= 0 && MenuItemIndex < ShoweringAnimationStyleArray.Length
			SetMenuOptionValue(OptionID, ShoweringAnimationStyleArray[MenuItemIndex])
			ShoweringAnimationStyle.SetValue(MenuItemIndex)
		EndIf
	ElseIf OptionID == GetSoapyStyleMenuID
		If MenuItemIndex >= 0 && MenuItemIndex < GetSoapyStyleArray.Length
			SetMenuOptionValue(OptionID, GetSoapyStyleArray[MenuItemIndex])
			GetSoapyStyle.SetValue(MenuItemIndex)
		EndIf
	EndIf
EndFunction
Function HandleOnOptionMenuAcceptAnimationsPageFollowers(Int OptionID, Int MenuItemIndex)
	If OptionID == BathingAnimationStyleMenuIDFollowers
		If MenuItemIndex >= 0 && MenuItemIndex < BathingAnimationStyleArray.Length
			SetMenuOptionValue(OptionID, BathingAnimationStyleArray[MenuItemIndex])
			BathingAnimationStyleFollowers.SetValue(MenuItemIndex)
		EndIf
	ElseIf OptionID == ShoweringAnimationStyleMenuIDFollowers
		If MenuItemIndex >= 0 && MenuItemIndex < ShoweringAnimationStyleArray.Length
			SetMenuOptionValue(OptionID, ShoweringAnimationStyleArray[MenuItemIndex])
			ShoweringAnimationStyleFollowers.SetValue(MenuItemIndex)
		EndIf
	ElseIf OptionID == GetSoapyStyleMenuIDFollowers
		If MenuItemIndex >= 0 && MenuItemIndex < GetSoapyStyleArray.Length
			SetMenuOptionValue(OptionID, GetSoapyStyleArray[MenuItemIndex])
			GetSoapyStyleFollowers.SetValue(MenuItemIndex)
		EndIf
	EndIf
EndFunction

; OnOptionMenuOpen
Event OnOptionMenuOpen(Int OptionID)
	If CurrentPage == "$BIS_PAGE_ANIMATIONS"
		HandleOnOptionMenuOpenAnimationsPage(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_ANIMATIONS_FOLLOWERS"
		HandleOnOptionMenuOpenAnimationsPageFollowers(OptionID)
	EndIf
EndEvent
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
		SetMenuDialogDefaultIndex(1)
	ElseIf OptionID == GetSoapyStyleMenuIDFollowers
		SetMenuDialogOptions(GetSoapyStyleArray)
		SetMenuDialogStartIndex(GetSoapyStyleFollowers.GetValue() As Int)
		SetMenuDialogDefaultIndex(1)
	EndIf
EndFunction

; OnOptionSliderAccept
Event OnOptionSliderAccept(Int OptionID, Float OptionValue)
	If CurrentPage == "$BIS_PAGE_SETTINGS"
		HandleOnOptionSliderAcceptSettingsPage(OptionID, OptionValue)
	ElseIf CurrentPage == "$BIS_PAGE_ANIMATIONS"
		HandleOnOptionSliderAcceptAnimationsPage(OptionID, OptionValue)
	ElseIf CurrentPage == "$BIS_PAGE_ANIMATIONS_FOLLOWERS"
		HandleOnOptionSliderAcceptAnimationsPageFollowers(OptionID, OptionValue)
	EndIf	
EndEvent
Function HandleOnOptionSliderAcceptAnimationsPage(Int OptionID, Float OptionValue)
	Float SliderValue = OptionValue

	If OptionID == BathingAnimationLoopsTier0SliderID
		(BathingAnimationLoopCountList.GetAt(0) As GlobalVariable).SetValue(SliderValue)
	ElseIf OptionID == BathingAnimationLoopsTier1SliderID
		(BathingAnimationLoopCountList.GetAt(1) As GlobalVariable).SetValue(SliderValue)
	ElseIf OptionID == BathingAnimationLoopsTier2SliderID
		(BathingAnimationLoopCountList.GetAt(2) As GlobalVariable).SetValue(SliderValue)
	ElseIf OptionID == BathingAnimationLoopsTier3SliderID
		(BathingAnimationLoopCountList.GetAt(3) As GlobalVariable).SetValue(SliderValue)
	EndIf
		
	SetSliderOptionValue(OptionID, SliderValue, "{0}")	
EndFunction
Function HandleOnOptionSliderAcceptAnimationsPageFollowers(Int OptionID, Float OptionValue)
	Float SliderValue = OptionValue

	If OptionID == BathingAnimationLoopsTier0SliderIDFollowers
		(BathingAnimationLoopCountListFollowers.GetAt(0) As GlobalVariable).SetValue(SliderValue)
	ElseIf OptionID == BathingAnimationLoopsTier1SliderIDFollowers
		(BathingAnimationLoopCountListFollowers.GetAt(1) As GlobalVariable).SetValue(SliderValue)
	ElseIf OptionID == BathingAnimationLoopsTier2SliderIDFollowers
		(BathingAnimationLoopCountListFollowers.GetAt(2) As GlobalVariable).SetValue(SliderValue)
	ElseIf OptionID == BathingAnimationLoopsTier3SliderIDFollowers
		(BathingAnimationLoopCountListFollowers.GetAt(3) As GlobalVariable).SetValue(SliderValue)
	EndIf
		
	SetSliderOptionValue(OptionID, SliderValue, "{0}")	
EndFunction
Function HandleOnOptionSliderAcceptSettingsPage(Int OptionID, Float OptionValue)
	Float SliderValue = OptionValue
	String DisplayFormat = DisplayFormatPercentage

	If OptionID == UpdateIntervalSliderID
		DisplayFormat = DisplayFormatDecimal
		DirtinessUpdateInterval.SetValue(SliderValue)
	ElseIf OptionID == DirtinessPerHourSettlementSliderID
		DisplayFormat = DisplayFormatPercentage
		SliderValue = OptionValue / 100.0
		DirtinessPerHourSettlement.SetValue(SliderValue)
	ElseIf OptionID == DirtinessPerHourDungeonSliderID
		DisplayFormat = DisplayFormatPercentage
		SliderValue = OptionValue / 100.0
		DirtinessPerHourDungeon.SetValue(SliderValue)
		DisplayFormat = DisplayFormatPercentage
	ElseIf OptionID == DirtinessPerHourWildernessSliderID
		SliderValue = OptionValue / 100.0	
		DirtinessPerHourWilderness.SetValue(SliderValue)

	ElseIf OptionID == DirtinessThresholdTier1SliderID
	
		DisplayFormat = DisplayFormatPercentage
		SliderValue = OptionValue / 100.0

		; clamp threshold
		If SliderValue > (DirtinessThresholdList.GetAt(1) As GlobalVariable).GetValue()
			SliderValue = (DirtinessThresholdList.GetAt(1) As GlobalVariable).GetValue()
		EndIf
		
		(DirtinessThresholdList.GetAt(0) As GlobalVariable).SetValue(SliderValue)
		
	ElseIf OptionID == DirtinessThresholdTier2SliderID
	
		DisplayFormat = DisplayFormatPercentage
		SliderValue = OptionValue / 100.0

		; clamp threshold
		If SliderValue > (DirtinessThresholdList.GetAt(2) As GlobalVariable).GetValue()
			SliderValue = (DirtinessThresholdList.GetAt(2) As GlobalVariable).GetValue()
		ElseIf SliderValue < (DirtinessThresholdList.GetAt(0) As GlobalVariable).GetValue()
			SliderValue = (DirtinessThresholdList.GetAt(0) As GlobalVariable).GetValue()
		EndIf

		(DirtinessThresholdList.GetAt(1) As GlobalVariable).SetValue(SliderValue)
		
	ElseIf OptionID == DirtinessThresholdTier3SliderID
	
		DisplayFormat = DisplayFormatPercentage
		SliderValue = OptionValue / 100.0

		; clamp threshold
		If SliderValue < (DirtinessThresholdList.GetAt(1) As GlobalVariable).GetValue()
			SliderValue = (DirtinessThresholdList.GetAt(1) As GlobalVariable).GetValue()
		EndIf
	
		(DirtinessThresholdList.GetAt(2) As GlobalVariable).SetValue(SliderValue)
		
	EndIf
	
	SetSliderOptionValue(OptionID, OptionValue, DisplayFormat)
EndFunction

; OnOptionSliderOpen
Event OnOptionSliderOpen(Int OptionID)
	If CurrentPage == "$BIS_PAGE_SETTINGS"
		HandleOnOptionSliderOpenSettingsPage(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_ANIMATIONS"
		HandleOnOptionSliderOpenAnimationsPage(OptionID)
	ElseIf CurrentPage == "$BIS_PAGE_ANIMATIONS_FOLLOWERS"
		HandleOnOptionSliderOpenAnimationsPageFollowers(OptionID)
	EndIf		
EndEvent
Function HandleOnOptionSliderOpenAnimationsPage(Int OptionID)
	; set slider range and increment
	SetSliderDialogRange(1.0, 10.0)
	SetSliderDialogInterval(1.0)
	
	; get slider values
	Float SliderValue = 0.0
	If OptionID == BathingAnimationLoopsTier0SliderID
		SetSliderDialogDefaultValue(1.0)
		SliderValue = (BathingAnimationLoopCountList.GetAt(0) As GlobalVariable).GetValue() As Int
	ElseIf OptionID == BathingAnimationLoopsTier1SliderID
		SetSliderDialogDefaultValue(1.0)
		SliderValue = (BathingAnimationLoopCountList.GetAt(1) As GlobalVariable).GetValue() As Int
	ElseIf OptionID == BathingAnimationLoopsTier2SliderID
		SetSliderDialogDefaultValue(1.0)
		SliderValue = (BathingAnimationLoopCountList.GetAt(2) As GlobalVariable).GetValue() As Int
	ElseIf OptionID == BathingAnimationLoopsTier3SliderID
		SetSliderDialogDefaultValue(1.0)
		SliderValue = (BathingAnimationLoopCountList.GetAt(3) As GlobalVariable).GetValue() As Int
	EndIf
	
	; set slider value
	SetSliderDialogStartValue(SliderValue)
	SetSliderOptionValue(OptionID, SliderValue, "{0}")
EndFunction
Function HandleOnOptionSliderOpenAnimationsPageFollowers(Int OptionID)
	; set slider range and increment
	SetSliderDialogRange(1.0, 10.0)
	SetSliderDialogInterval(1.0)
	
	; get slider values
	Float SliderValue = 0.0
	If OptionID == BathingAnimationLoopsTier0SliderIDFollowers
		SetSliderDialogDefaultValue(1.0)
		SliderValue = (BathingAnimationLoopCountListFollowers.GetAt(0) As GlobalVariable).GetValue() As Int
	ElseIf OptionID == BathingAnimationLoopsTier1SliderIDFollowers
		SetSliderDialogDefaultValue(1.0)
		SliderValue = (BathingAnimationLoopCountListFollowers.GetAt(1) As GlobalVariable).GetValue() As Int
	ElseIf OptionID == BathingAnimationLoopsTier2SliderIDFollowers
		SetSliderDialogDefaultValue(1.0)
		SliderValue = (BathingAnimationLoopCountListFollowers.GetAt(2) As GlobalVariable).GetValue() As Int
	ElseIf OptionID == BathingAnimationLoopsTier3SliderIDFollowers
		SetSliderDialogDefaultValue(1.0)
		SliderValue = (BathingAnimationLoopCountListFollowers.GetAt(3) As GlobalVariable).GetValue() As Int
	EndIf
	
	; set slider value
	SetSliderDialogStartValue(SliderValue)
	SetSliderOptionValue(OptionID, SliderValue, "{0}")
EndFunction
Function HandleOnOptionSliderOpenSettingsPage(Int OptionID)
	Float SliderValue = 0.0
	String DisplayFormat = DisplayFormatPercentage

	; get slider value
	If OptionID == UpdateIntervalSliderID
		DisplayFormat = DisplayFormatDecimal
		SetSliderDialogRange(0.25, 5.0)
		SetSliderDialogInterval(0.25)
		SetSliderDialogDefaultValue(1.0)
		SliderValue = (DirtinessUpdateInterval.GetValue())
	ElseIf OptionID == DirtinessPerHourSettlementSliderID
		DisplayFormat = DisplayFormatPercentage
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(0.5)
		SetSliderDialogDefaultValue(1.0)
		SliderValue = (DirtinessPerHourSettlement.GetValue() * 100.0)
	ElseIf OptionID == DirtinessPerHourDungeonSliderID
		DisplayFormat = DisplayFormatPercentage
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(0.5)
		SetSliderDialogDefaultValue(2.5)
		SliderValue = (DirtinessPerHourDungeon.GetValue() * 100.0)
	ElseIf OptionID == DirtinessPerHourWildernessSliderID
		DisplayFormat = DisplayFormatPercentage
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(0.5)
		SetSliderDialogDefaultValue(1.5)
		SliderValue = (DirtinessPerHourWilderness.GetValue() * 100.0)
	ElseIf OptionID == DirtinessThresholdTier1SliderID
		DisplayFormat = DisplayFormatPercentage
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(0.5)
		SetSliderDialogDefaultValue(20.0)
		SliderValue = ((DirtinessThresholdList.GetAt(0) As GlobalVariable).GetValue() * 100.0)
	ElseIf OptionID == DirtinessThresholdTier2SliderID
		DisplayFormat = DisplayFormatPercentage
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(0.5)
		SetSliderDialogDefaultValue(60.0)
		SliderValue = ((DirtinessThresholdList.GetAt(1) As GlobalVariable).GetValue() * 100.0)
	ElseIf OptionID == DirtinessThresholdTier3SliderID
		DisplayFormat = DisplayFormatPercentage
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(0.5)
		SetSliderDialogDefaultValue(98.0)
		SliderValue = ((DirtinessThresholdList.GetAt(2) As GlobalVariable).GetValue() * 100.0)
	EndIf
	
	; set slider value
	SetSliderDialogStartValue(SliderValue)
	SetSliderOptionValue(OptionID, SliderValue, DisplayFormat)
EndFunction

; helper functions
Function EnableBathingInSkyrim()
	Player.AddSpell(GetDirtyOverTimeSpellList.GetAt(1) As Spell, False)
	Player.AddSpell(GetDirtyOverTimeReactivatorCloakSpell, False)

	BatheQuest.Start()
	BatheQuest.RegisterHotKeys()

	BathingInSkyrimEnabled.SetValue(1)
EndFunction
Function DisableBathingInSkyrim()
	Player.RemoveSpell(GetDirtyOverTimeReactivatorCloakSpell)

	RemoveSpells(Player, GetDirtyOverTimeSpellList)
	RemoveSpells(Player, DirtinessSpellList)
	RemoveSpells(Player, SoapBonusSpellList)
	RemoveSpells(Player, LegacySpellList)

	Int DirtyActorIndex = DirtyActors.Getsize()
	If DirtyActorIndex > 0
		While DirtyActorIndex
			DirtyActorIndex -= 1
			Actor DirtyActor = DirtyActors.GetAt(DirtyActorIndex) As Actor
			RemoveSpells(DirtyActor, GetDirtyOverTimeSpellList)
			RemoveSpells(DirtyActor, DirtinessSpellList)
			RemoveSpells(DirtyActor, SoapBonusSpellList)
			RemoveSpells(DirtyActor, LegacySpellList)
		EndWhile
		DirtyActors.Revert()
	EndIf

	BatheQuest.Stop()
			
	BathingInSkyrimEnabled.SetValue(0)
EndFunction
Function AddSoapToVendors()
	Int Index = SoapFormList.GetSize()
	While Index
		Index -= 1
		LeveledItemListGeneral.AddForm(SoapFormList.GetAt(Index), 1, 5)
		LeveledItemListInnkeeper.AddForm(SoapFormList.GetAt(Index), 1, 5)
	EndWhile	
EndFunction
Function RemoveSpells(Actor DirtyActor, FormList SpellFormList)
	Int SpellListIndex = SpellFormList.GetSize()
	While SpellListIndex
		SpellListIndex -= 1
		DirtyActor.RemoveSpell(SpellFormList.GetAt(SpellListIndex) As Spell)	
	EndWhile
EndFunction

Bool[] Function GetUnignoredArmorSlots(GlobalVariable IgnoredArmorSlotsMask)
	Bool[] UnignoredArmorSlots = new Bool[32]
	
	Int CurrentBathingIgnoredArmorSlotsMask = IgnoredArmorSlotsMask.GetValue() As Int
	
	Int Index = UnignoredArmorSlots.Length
	While Index
		Index -= 1
		Int ArmorSlotMask = Armor.GetMaskForSlot(Index + 30)
		If Math.LogicalAnd(ArmorSlotMask, CurrentBathingIgnoredArmorSlotsMask) == ArmorSlotMask		
			UnignoredArmorSlots[Index] = False	
		Else
			UnignoredArmorSlots[Index] = True
		EndIf
	EndWhile
	
	Return UnignoredArmorSlots
EndFunction
Function IgnoreArmorSlot(GlobalVariable IgnoredArmorSlotsMask, Int ArmorSlot, Bool Ignore)
	Int ArmorSlotMask = Armor.GetMaskForSlot(ArmorSlot)
	Int CurrentBathingIgnoredArmorSlotsMask = IgnoredArmorSlotsMask.GetValue() As Int
	
	Int NewBathingIgnoredArmorSlotsMask
	If Ignore == True
		NewBathingIgnoredArmorSlotsMask = Math.LogicalOr(ArmorSlotMask, CurrentBathingIgnoredArmorSlotsMask)
	Else
		NewBathingIgnoredArmorSlotsMask = Math.LogicalXor(ArmorSlotMask, CurrentBathingIgnoredArmorSlotsMask)
	EndIf
	
	IgnoredArmorSlotsMask.SetValue(NewBathingIgnoredArmorSlotsMask)
EndFunction

; ---------- MCM Internal Variables ----------

; menu - Settings
Int BathingInSkyrimEnableToggleID
Int DialogTopicEnableToggleID
Int WaterRestrictionEnableToggleID
Int UpdateIntervalSliderID
Int DirtinessPerHourSettlementSliderID
Int DirtinessPerHourDungeonSliderID
Int DirtinessPerHourWildernessSliderID
Int DirtinessThresholdTier1SliderID
Int DirtinessThresholdTier2SliderID
Int DirtinessThresholdTier3SliderID
Int CheckStatusKeyMapID
Int BatheKeyMapID
Int ShowerKeyMapID
Int SaveSettingsID
Int LoadSettingsID

; menu - Animations - Left
Int BathingAnimationStyleMenuID
Int ShoweringAnimationStyleMenuID
Int GetSoapyStyleMenuID
Int BathingAnimationLoopsTier0SliderID
Int BathingAnimationLoopsTier1SliderID
Int BathingAnimationLoopsTier2SliderID
Int BathingAnimationLoopsTier3SliderID

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

; menu - Animations - Followers - Right
Int   GetDressedAfterBathingEnabledToggleIDFollowers
Int[] UndressArmorSlotToggleIDsFollowers

; menu - Tracked NPCs
Int[] TrackedActorsToggleIDs

; --------------------------------------------
