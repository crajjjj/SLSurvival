Scriptname SOS_IO Extends Quest

int RESULT_OK = 0
int INVALID_FILE = -1
int INVALID_CONTENT = -2

Bool Function ExportSettings()
	ExportGeneralSettings()
	ExportAddons()
	Bool result = Save(getFileName())
	Return result
EndFunction

String Function getFileName() Global
	Return "Data/SOS.json"
EndFunction

Int Function ImportSettings()
	bool ok = Load(getFileName())
	If ok
		int result = ImportGeneralSettings()
		If result == RESULT_OK
			ImportAddons()
			SOS.SendModEvent("ReSchlongify", "ScaleSchlongs")
		EndIf
		Return result
	EndIf
	Return INVALID_FILE
EndFunction

Function ExportGeneralSettings()
	setInt(MIN_SCHLONG_SIZE, SOS.iMinSchlongSize)
	setInt(MAX_SCHLONG_SIZE, SOS.iMaxSchlongSize)
	setFloat(GLOBAL_SCHLONG_SIZE_BOOST_FACTOR, SOS.fGlobalSchlongSizeBoostFactor)
	setInt(DIALOG_SETTINGS, SOS.iDialogSettings)
	setInt(ERECTION_SPELLS_ENABLED, SOS.bErectionSpellsEnabled as int)
	setInt(POTIONS_ENABLED, SOS.bPotionsEnabled as int)
	setInt(BEND_UP_KEY, SOS.iBendUpKey)
	setInt(BEND_DOWN_KEY, SOS.iBendDownKey)
	setInt(BEND_PLAYER_MODIFIER_KEY, SOS.iBendPlayerModifierKey)
EndFunction

Function ExportAddons()
	int i = 0
	int count = SOS_Data.CountAddons()
	String[] sAddons = Utility.CreateStringArray(count)
	Int[] iGenders = Utility.CreateIntArray(count)
	While i < count
		SOS_AddonQuest_Script addon = SOS_Data.GetAddon(i)
		sAddons[i] = addon.getAddonName()
		iGenders[i] = SOS_Data.GetGender(addon)
		ExportRaces(addon, i)
		i += 1
	EndWhile
	setIntList(GENDERS, iGenders)
	setStringList(ADDONS, sAddons)
EndFunction

Function ExportRaces(Form addon, int index)
	int i = 0
	int count = SOS_Data.CountCompatibleRaces(addon)
	Int[] enabledRaces = Utility.CreateIntArray(count)
	Int[] sizes = Utility.CreateIntArray(count)
	Float[] probabilities = Utility.CreateFloatArray(count)
	While i < count
		enabledRaces[i] = (SOS_Data.FindEnabledRace(addon, SOS_Data.GetCompatibleRace(addon, i)) != -1) as Int
		sizes[i] = SOS_Data.GetRaceSize(addon, i)
		probabilities[i] = SOS_Data.GetRaceProbability(addon, i)
		i += 1
	EndWhile
	setIntList(ENABLED_RACES_ADDON + index, enabledRaces)
	setIntList(SIZES_ADDON + index, sizes)
	setFloatList(PROBABILITIES_ADDON + index, probabilities)
EndFunction

Int Function ImportGeneralSettings()
	int iMinSchlongSize = getInt(MIN_SCHLONG_SIZE)
	int iMaxSchlongSize = getInt(MAX_SCHLONG_SIZE)
	If !(iMinSchlongSize > 0 && iMinSchlongSize < 8)
		; Missing entry or invalid value. Something went wrong with this file
		Return INVALID_CONTENT
	EndIf
	SOS.iMinSchlongSize = iMinSchlongSize
	If !(iMaxSchlongSize > 0 && iMaxSchlongSize < 21)
		; Missing entry or invalid value. Something went wrong with this file
		Return INVALID_CONTENT
	EndIf
	SOS.iMaxSchlongSize = iMaxSchlongSize
	SOS.fGlobalSchlongSizeBoostFactor = getFloat(GLOBAL_SCHLONG_SIZE_BOOST_FACTOR)
	SOS.SetDialogSettings(getInt(DIALOG_SETTINGS))
	SOS.SetErectionSpellsEnabled(getInt(ERECTION_SPELLS_ENABLED) as Bool)
	SOS.SetPotionsEnabled(getInt(POTIONS_ENABLED) as Bool)
	SOS.iBendUpKey = getInt(BEND_UP_KEY)
	SOS.iBendDownKey = getInt(BEND_DOWN_KEY)
	SOS.iBendPlayerModifierKey = getInt(BEND_PLAYER_MODIFIER_KEY)
	SOS.PlayerAliasScript.ReRegisterKeys()
	Return RESULT_OK
EndFunction

Function ImportAddons()
	int i = 0
	String[] sAddons = getStringList(ADDONS)
	Int[] iGenders = getIntList(GENDERS)
	int count = sAddons.Length
	While i < count
		; is this addon installed?
		int installedIdx = SOS.GetAddonIndexForName(sAddons[i])
		If installedIdx != -1
			SOS_AddonQuest_Script addon = SOS_Data.GetAddon(installedIdx)
			SOS_Data.SetGender(addon, iGenders[i])
			ImportRaces(addon, i)
		EndIf
		i += 1
	EndWhile
EndFunction

Function ImportRaces(Form addon, int index)
	Int[] enabledRaces = getIntList(ENABLED_RACES_ADDON + index)
	Int[] sizes = getIntList(SIZES_ADDON + index)
	Float[] probabilities = getFloatList(PROBABILITIES_ADDON + index)
	int i = 0
	int count = enabledRaces.Length
	While i < count
		bool enabledRace = enabledRaces[i] as Bool
		Race aRace = SOS_Data.GetCompatibleRace(addon, i)
		bool alreadyEnabled = SOS_Data.FindEnabledRace(addon, aRace) != -1
		If enabledRace && !alreadyEnabled
			SOS_Data.AddEnabledRace(addon, aRace)
		ElseIf !enabledRace && alreadyEnabled
			SOS_Data.RemoveEnabledRace(addon, aRace)
		EndIf
		SOS_Data.SetRaceSize(addon, i, sizes[i])
		SOS_Data.SetRaceProbability(addon, i, probabilities[i])
		i += 1
	EndWhile
EndFunction

SOS_Config Property SOS Auto

String MIN_SCHLONG_SIZE = "iMinSchlongSize"
String MAX_SCHLONG_SIZE = "iMaxSchlongSize"
String GLOBAL_SCHLONG_SIZE_BOOST_FACTOR = "fGlobalSchlongSizeBoostFactor"
String DIALOG_SETTINGS = "iDialogSettings"
String ERECTION_SPELLS_ENABLED = "bErectionSpellsEnabled"
String POTIONS_ENABLED = "bPotionsEnabled"
String BEND_UP_KEY = "iBendUpKey"
String BEND_DOWN_KEY = "iBendDownKey"
String BEND_PLAYER_MODIFIER_KEY = "iBendPlayerModifierKey"
String GENDERS = "iGenders"
String ADDONS = "sAddons"
String ENABLED_RACES_ADDON = "iEnabledRacesAddon"
String SIZES_ADDON = "iSizesAddon"
String PROBABILITIES_ADDON = "fProbabilitiesAddon"

Function setInt(String key, Int value) Global Native
Function setFloat(String key, Float value) Global Native
Function setIntList(String key, Int[] value) Global Native
Function setFloatList(String key, Float[] value) Global Native
Function setStringList(String key, String[] value) Global Native

Int Function getInt(String key) Global Native
Float Function getFloat(String key) Global Native
Int[] Function getIntList(String key) Global Native
Float[] Function getFloatList(String key) Global Native
String[] Function getStringList(String key) Global Native

Bool Function Save(String file) Global Native
Bool Function Load(String file) Global Native
