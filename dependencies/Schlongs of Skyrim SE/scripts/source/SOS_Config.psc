scriptname SOS_Config extends SKI_ConfigBase
{Schlongs Of Skyrim Mod Configuration Menu}

SOS_PlayerAliasScript Property PlayerAliasScript Auto
SOS_SetupQuest_Script Property SOS_Quest Auto
GlobalVariable Property SOS_LItemChanceNone Auto

; option OIDs
int oidSchlongificationEnabled
int oidGlobalSchlongSizeBoostFactor
int oidMinSchlongSize
int oidMaxSchlongSize
int oidDialogSettings
int oidGlobalSchlongSizeDistribution
int oidGlobalSchlongTypeProbability
int oidPotionsEnabled

int oidPlayerArmorRevealing
int oidNPCArmorRevealing

int oidBendUpKey
int oidBendDownKey
int oidBendPlayerModifierKey

int oidErectionSpellsEnabled
int oidRestart
int oidCleanArmors
int oidRemove
int oidImport
int oidExport
int oidNotificationsEnabled

int oidPlayerSchlong
int oidPlayerSize
int property iPlayerSize auto hidden

int oidNPCSchlong
int oidNPCSize
int property iNPCSize auto hidden
int oidPlayerDebug
int oidNPCDebug

int oidNoNPCselected

int[] oidsOfCurrentAddon	; holds the oids of the options of the current addon page, their meaning is dereived from the index in this array
int currentAddonIndex		; the addon index of the currently displayed addon settings page

String[] sDialogSettingsLabels
String[] sGenderLabels

; option properties
float property fGlobalSchlongSizeBoostFactor auto hidden			; factor that can be used to influence the size of schlong addons
int property iDialogSettings auto hidden						; the index and at the same time faction rank of the sos dialog settings
int property iGlobalSchlongSizeDistribution auto hidden			; only used to set addons settings, has no direct influcene itself
float property fGlobalSchlongTypeProbability auto hidden		; only used to set addons settings, has no direct influence itself
int property iBendUpKey auto hidden
int property iBendDownKey auto hidden
int property iBendPlayerModifierKey auto hidden
bool property bNotificationsEnabled auto hidden
bool property bPotionsEnabled = true auto hidden

bool property bErectionSpellsEnabled auto hidden
bool bPlayerArmorRevealing
bool bNPCArmorRevealing

; not changeable configuration settings
int property iMinSchlongSize auto hidden
GlobalVariable Property SOS_MinSchlongSize Auto
int property iMaxSchlongSize auto hidden
GlobalVariable Property SOS_MaxSchlongSize Auto


int Function GetVersion()
	; TODO: increment this on *every* release that changed something
	return 3
EndFunction

; mcm events


; ATTENTION: it seems that the MCM version update is buggy
; documentation suggests MCM calls this method if it detects that the internally managed "CurrentVersion" does not align with what
; is returned by the mods GetVersion() fucntion. However we have dozens of save files where debugging shows that CurrentVersion and GetVersion()
; do not align, yet this function does not get called
; Therefore we now trigger this call manually from the update mechanism of the SOS_SetupQuest, and change the value of CurrentVersion ourselves
; (which should not be necessary if MCM worked the way it is documented)
Function PerformVersionUpdate(int newVersion)
	If newVersion == 300002
		sGenderLabels = new String[3]
		sGenderLabels[0] = "$Male"
		sGenderLabels[1] = "$Female"
		sGenderLabels[2] = "$Both"
	EndIf
EndFunction

Event OnVersionUpdate(int newVersion)
	{initialize stuff that has changed for each version}
	PerformVersionUpdate(newVersion)
EndEvent

Event OnConfigInit()
	{Called when the config menu is initialized.}
	Debug.Trace("SOS config: first initialization, currentVersion: " + currentVersion)
	bErectionSpellsEnabled = true
	fGlobalSchlongSizeBoostFactor = 0.0
	sDialogSettingsLabels = new String[2]
	sDialogSettingsLabels[0] = "$Off"
	sDialogSettingsLabels[1] = "$Campy"
	sGenderLabels = new String[3]
	sGenderLabels[0] = "$Male"
	sGenderLabels[1] = "$Female"
	sGenderLabels[2] = "$Both"
	iDialogSettings = 0
	bNotificationsEnabled = true
	bPotionsEnabled = true

	iGlobalSchlongSizeDistribution = 0
	fGlobalSchlongTypeProbability = 10
	iBendUpKey = 201				; PgUp
	iBendDownKey = 209				; PgDown
	iBendPlayerModifierKey = 42		; Left Shift

	iMinSchlongSize = 4
	iMaxSchlongSize = 10

	InitPages()

EndEvent

Event OnConfigOpen()
	{Called when the config menu is opened.}

	InitPages()
EndEvent

Event OnPageReset(String page)
	{Called when a new page is selected, including the initial empty page}

	if(page == "")
		; show the even more incredible logo!
		LoadCustomContent("SOS/logo.dds", 124, 0)
		return
	else
		UnloadCustomContent()
	endIf


	if(page == "$General Settings")

		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$Global Settings")
		oidMinSchlongSize = AddSliderOption("$Min schlong size", iMinSchlongSize, "{0}")
		oidMaxSchlongSize = AddSliderOption("$Max schlong size", iMaxSchlongSize, "{0}")
		oidGlobalSchlongSizeBoostFactor = AddSliderOption("$Schlong size multiplier", fGlobalSchlongSizeBoostFactor, "{0}%")
		oidDialogSettings = AddMenuOption("$NPC Dialogs", sDialogSettingsLabels[iDialogSettings])
		oidErectionSpellsEnabled = AddToggleOption("$Spells erections", bErectionSpellsEnabled)
		oidPotionsEnabled = AddToggleOption("$SOS potions", bPotionsEnabled)

		AddHeaderOption("$Addon Reconfiguration")
		oidGlobalSchlongSizeDistribution = AddSliderOption("$NPC size probability", iGlobalSchlongSizeDistribution, "{0}")
		oidGlobalSchlongTypeProbability = AddSliderOption("$NPC type probability", fGlobalSchlongTypeProbability, "{2}%")

		SetCursorPosition(1)
		AddHeaderOption("$Key bindings")
		oidBendUpKey = AddKeyMapOption("$Bend schlong up", iBendUpKey)
		oidBendDownKey = AddKeyMapOption("$Bend schlong down", iBendDownKey)
		oidBendPlayerModifierKey = AddKeyMapOption("$Bend Player schlong", iBendPlayerModifierKey)

		AddHeaderOption("$Mod management")
		oidNotificationsEnabled = AddToggleOption("$Display SOS notifications", bNotificationsEnabled)
		int count = SOS_Data.CountRevealingArmors() + SOS_Data.CountConcealingArmors()
		oidCleanArmors = AddTextOption("$Clean schlongified armors{" + count + "}", "")
		oidRestart = AddTextOption("$Restart SOS", "")
		oidRemove = AddTextOption("$Remove SOS", "")
		oidImport = AddTextOption("Import MCM settings", "")
		oidExport = AddTextOption("Export MCM settings", "")
	endif

	If page == "$Player NPC Settings"

		SetCursorFillMode(TOP_TO_BOTTOM)

		AddHeaderOption("$Player Settings")
		FillActorSettings(Game.GetPlayer(), true)

		SetCursorPosition(1)

		AddHeaderOption("$NPC Settings")
		FillActorSettings(PlayerAliasScript.selectedActor, false)
	EndIf

	int pageAddonIndex = GetAddonIndexForName(page)
	if(pageAddonIndex > -1)
		SetCursorFillMode(TOP_TO_BOTTOM)
		currentAddonIndex = pageAddonIndex
		oidsOfCurrentAddon = new int[128]
		oidsOfCurrentAddon[0] = AddSliderOption("$NPC size distribution", 0, "{0}")
		oidsOfCurrentAddon[2] = AddSliderOption("$NPC type probability", 10, "{2}%")
		oidsOfCurrentAddon[4] = AddTextOption("$Clean", "")
		oidsOfCurrentAddon[6] = AddTextOption("$Remove", "")
		oidsOfCurrentAddon[8] = AddEmptyOption()

		Form addon = SOS_Data.GetAddon(currentAddonIndex)
		int enabledGender = SOS_Data.GetGender(addon) ; 0=Male, 1=Female, 2=Both, 10=Both but disabled for females, 11=Both but disabled for males
		int index = enabledGender
		int flag = OPTION_FLAG_NONE
		If enabledGender > 2
			index -= 10
		ElseIf enabledGender < 2
			flag = OPTION_FLAG_DISABLED
		EndIf
		SetCursorPosition(1)
		oidsOfCurrentAddon[1] = AddMenuOption("$Gender options", sGenderLabels[index], flag)

		; loop options for each race
		int i = 0
		int raceCount = SOS_Data.CountCompatibleRaces(addon)
		while(i < raceCount)
			Race currentRace = SOS_Data.GetCompatibleRace(addon, i)
			bool raceEnabled = SOS_Data.FindEnabledRace(addon, currentRace) != -1
			int flags = 0
			if raceEnabled
				flags = OPTION_FLAG_NONE
			else
				flags = OPTION_FLAG_DISABLED
			endif
			String raceName = GetRaceName(currentRace)

			int optionBaseIndex = 10 + Math.Floor(i / 2) * 8 + i % 2
			SetCursorPosition(optionBaseIndex)
			oidsOfCurrentAddon[optionBaseIndex] = AddToggleOption(raceName, raceEnabled)
			oidsOfCurrentAddon[optionBaseIndex + 2] = AddSliderOption("$Size Probability", SOS_Data.GetRaceSize(addon, i), "{0}", flags)
			oidsOfCurrentAddon[optionBaseIndex + 4] = AddSliderOption("$Shape Probability", SOS_Data.GetRaceProbability(addon, i), "{2}%", flags)
			oidsOfCurrentAddon[optionBaseIndex + 6] = AddEmptyOption()
			i += 1
		endwhile
	else
		currentAddonIndex = -1
	endif

EndEvent

Function FillActorSettings(Actor akActor, Bool isPlayer)

	AddEmptyOption()
	If !akActor || akActor as String == "[Actor <None>]"
		oIdNoNPCselected = AddTextOption("$No NPC selected", "")
		Return
	EndIf

	AddTextOption("$Name{" + akActor.GetLeveledActorBase().GetName() + "}", "")
	AddEmptyOption()

	If !SOS_Quest.IsSkeletonSOSCompatible(akActor)
		AddTextOption("$No SOS skeleton", "")
		Return
	EndIf

	int size = 1
	String addonName = "$No schlong"
	int flags = OPTION_FLAG_DISABLED
	SOS_AddonQuest_Script addon = SOS_Quest.GetActiveAddon(akActor)
	If addon
		addonName = addon.GetAddonName()
		Faction addonFaction = SOS_Data.GetFaction(addon)
		size = akActor.GetFactionRank(addonFaction)
		flags = OPTION_FLAG_NONE
	EndIf

	If isPlayer
		oidPlayerSchlong = AddMenuOption(addonName, "$Change")
		iPlayerSize = size
		If isPlayer && SOS_Quest.SOSRaceMenuInstalled()
			AddMenuOption("$Schlong size", "SOSRacemenu", OPTION_FLAG_DISABLED)
		Else
			oidPlayerSize = AddSliderOption("$Schlong size", iPlayerSize, "{0}", flags)
		EndIf
	Else
		oidNPCSchlong = AddMenuOption(addonName, "$Change")
		iNPCSize = size
		oidNPCSize = AddSliderOption("$Schlong size", iNPCSize, "{0}", flags)
	EndIf

	AddEmptyOption()

	String armorName = "$None"
	flags = OPTION_FLAG_DISABLED
	Bool isRevealing = false
	Bool hasRevealingKeyword = false
	String optionName = "$Revealing"

	Armor akArmor = akActor.GetWornForm(0x00000004) as Armor
	If akArmor
		armorName = akArmor.GetName()

		; check if armor is revealing
		isRevealing = SOS_SKSE.IsRevealing(akArmor)

		If isRevealing && SOS_Quest.HasRevealingKeyword(akArmor)
			; built-in revealing armors can't be modified
			optionName += " (built-in)"
		Else
			flags = OPTION_FLAG_NONE
		EndIf
	EndIf

	AddTextOption("$Equipped armor{" + armorName + "}", "")
	If isPlayer
		bPlayerArmorRevealing = isRevealing
		oidPlayerArmorRevealing = AddToggleOption(optionName, isRevealing, flags)
	Else
		bNPCArmorRevealing = isRevealing
		oidNPCArmorRevealing = AddToggleOption(optionName, isRevealing, flags)
	EndIf

	AddEmptyOption()
	If isPlayer
		oidPlayerDebug = AddTextOption("$SOS internal information", "")
	Else
		oidNPCDebug = AddTextOption("$SOS internal information", "")
	EndIf
EndFunction

Event OnOptionSelect(int option)
	{Called when a non-interactive option has been selected}

	if(option == oidErectionSpellsEnabled)
		bErectionSpellsEnabled = !bErectionSpellsEnabled
		SetErectionSpellsEnabled(bErectionSpellsEnabled)
		SetToggleOptionValue(oidErectionSpellsEnabled, bErectionSpellsEnabled)
	elseif option == oidRestart
		bool accepted = ShowMessage("$warn_restart_SOS", true)
		If accepted
			SOS_Quest.Restart()
		EndIf
	elseif option == oidRemove
		bool accepted = ShowMessage("$warn_remove_SOS_1", true)
		If accepted
			SOS_Quest.Remove()
			ShowMessage("$warn_remove_SOS_2", false)
		EndIf
	elseif option == oidImport
		int result = (Quest.GetQuest("SOS_Misc") as SOS_IO).ImportSettings()
		If result == 0
			ForcePageReset()
			ShowMessage("Import OK", false) ; todo
		Else
			ShowMessage("Import failed\nEither the settings file is missing or it has invalid content (\"" + SOS_IO.getFileName() + "\")", false) ; todo
		EndIf
	elseif option == oidExport
		bool ok = (Quest.GetQuest("SOS_Misc") as SOS_IO).ExportSettings()
		If ok
			ShowMessage("File \"" + SOS_IO.getFileName() + "\" created", false) ; todo
		Else
			ShowMessage("Export failed", false) ; todo
		EndIf
	elseif option == oidNotificationsEnabled
		bNotificationsEnabled = !bNotificationsEnabled
		SetToggleOptionValue(oidNotificationsEnabled, bNotificationsEnabled)
	elseif option == oidCleanArmors
		int count = SOS_Quest.CleanSchlongifiedArmors()
		ShowMessage("$Cleaned armors{" + count + "}", false)
	elseif option == oidPlayerArmorRevealing
		SOS_Quest.ToggleRevealingArmor(Game.GetPlayer())
		SetToggleOptionValue(option, !bPlayerArmorRevealing)
	elseif option == oidNPCArmorRevealing
		SOS_Quest.ToggleRevealingArmor(PlayerAliasScript.selectedActor)
		SetToggleOptionValue(option, !bNPCArmorRevealing)
	elseif option == oidPotionsEnabled
		SetPotionsEnabled(!bPotionsEnabled)
		SetToggleOptionValue(oidPotionsEnabled, bPotionsEnabled)
	ElseIf option == oidPlayerDebug
		SOS_Quest.CastDebugSpell(Game.GetPlayer())
		CloseMCM()
	ElseIf option == oidNPCDebug
		SOS_Quest.CastDebugSpell(PlayerAliasScript.selectedActor)
		CloseMCM()
	endif

	if(currentAddonIndex > -1)
		int raceIndex = GetAddonOptionRaceIndex(option)
		Form addon = SOS_Data.GetAddon(currentAddonIndex)
		if(raceIndex > -1 && IsAddonOptionRaceEnable(option))
			Race changedRace = SOS_Data.GetCompatibleRace(addon, raceIndex)
			if(changedRace)
				bool enableRace = SOS_Data.FindEnabledRace(addon, changedRace) == -1
				int flags = 0
				if(enableRace)
					SOS_Data.AddEnabledRace(addon, changedRace)
					flags = OPTION_FLAG_NONE
				else
					SOS_Data.RemoveEnabledRace(addon, changedRace)
					flags = OPTION_FLAG_DISABLED
				endif
				SetOptionFlags(option+2, flags, true)
				SetOptionFlags(option+4, flags)
				SetToggleOptionValue(option, enableRace)
			endif
		elseif(IsAddonOptionClean(option))
			bool accepted = ShowMessage("$warn_clean_addon_1", true)
			if(accepted)
				int cleanedActors = SOS_Quest.CleanSchlongifiedActors(addon, false)
				SendModEvent("ReSchlongify")
				ShowMessage("$warn_clean_addon_2{" + cleanedActors + "}", false)
			endif
		elseif(IsAddonOptionRemove(option))
			bool accepted = ShowMessage("$warn_remove_addon_1", true)
			if(accepted)
				; disable schlong spreading here, otherwise it might happen that during removal actors get the schlong which is to be removed assigned
				SOS_Quest.StopSpreading()
				SOS_Quest.RemoveSchlongAddon(addon, false)
				SOS_Quest.StartSpreading()
				SendModEvent("ReSchlongify")
				ShowMessage("$warn_remove_addon_2{" + addon.GetName() + "}", false)
			endif
		;else
		;	bool accepted = ShowMessage("Non interactive Addon option: " + option + "\nYes ?", true)
		endif
	endif
EndEvent

Event OnOptionSliderOpen(int option)
	{Called when a slider option has been selected}

	if(option == oidGlobalSchlongSizeBoostFactor)
		SetSliderDialogStartValue(fGlobalSchlongSizeBoostFactor)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(-50, 300)
		SetSliderDialogInterval(1)
	elseIf(option == oidMinSchlongSize)
		SetSliderDialogStartValue(iMinSchlongSize)
		SetSliderDialogDefaultValue(4)
		SetSliderDialogRange(1, 7)
		SetSliderDialogInterval(1)
	elseIf(option == oidMaxSchlongSize)
		SetSliderDialogStartValue(iMaxSchlongSize)
		SetSliderDialogDefaultValue(10)
		SetSliderDialogRange(2, 20)
		SetSliderDialogInterval(1)
	elseIf(option == oidPlayerSize)
		SetSliderDialogStartValue(iPlayerSize)
		SetSliderDialogDefaultValue(10)
		SetSliderDialogRange(1, 20)
		SetSliderDialogInterval(1)
	elseIf(option == oidNPCSize)
		SetSliderDialogStartValue(iNPCSize)
		SetSliderDialogDefaultValue(10)
		SetSliderDialogRange(1, 20)
		SetSliderDialogInterval(1)
	elseif(option == oidGlobalSchlongSizeDistribution)
		SetSliderDialogStartValue(iGlobalSchlongSizeDistribution)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(-100, 100)
		SetSliderDialogInterval(1)
	elseif(option == oidGlobalSchlongTypeProbability)
		SetSliderDialogStartValue(fGlobalSchlongTypeProbability)
		SetSliderDialogDefaultValue(10)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(0.01)
	elseif(currentAddonIndex > -1)
		int raceIndex = GetAddonOptionRaceIndex(option)
		Form addon = SOS_Data.GetAddon(currentAddonIndex)

		if(IsAddonOptionSetAllSizes(option))
			SetSliderDialogStartValue(iGlobalSchlongSizeDistribution)
			SetSliderDialogDefaultValue(0)
			SetSliderDialogRange(-100, 100)
			SetSliderDialogInterval(1)
		elseif(IsAddonOptionSetAllProbabilities(option))
			SetSliderDialogStartValue(fGlobalSchlongTypeProbability)
			SetSliderDialogDefaultValue(10)
			SetSliderDialogRange(0, 100)
			SetSliderDialogInterval(0.01)
		elseif(raceIndex > -1)
			if(IsAddonOptionRaceSize(option))
				SetSliderDialogStartValue(SOS_Data.GetRaceSize(addon, raceIndex))
				SetSliderDialogDefaultValue(0)
				SetSliderDialogRange(-100, 100)
				SetSliderDialogInterval(1)
			elseif(IsAddonOptionRaceProbability(option))
				SetSliderDialogStartValue(SOS_Data.GetRaceProbability(addon, raceIndex))
				SetSliderDialogDefaultValue(10)
				SetSliderDialogRange(0, 100)
				SetSliderDialogInterval(0.01)
			endif
		endif
	endif

EndEvent

Event OnOptionSliderAccept(int option, float value)
	{Called when a slider dialog has been confirmed}
	if(option == oidGlobalSchlongSizeBoostFactor)
		fGlobalSchlongSizeBoostFactor = value
		ShowMessage("$warn_reschlongify{$OK}", false)
		SendModEvent("ReSchlongify", "ScaleSchlongs")
		SetSliderOptionValue(option, fGlobalSchlongSizeBoostFactor, "{0}%")
	elseif(option == oidMinSchlongSize)
		iMinSchlongSize = value as int
		SOS_MinSchlongSize.setValue(iMinSchlongSize)
		SetSliderOptionValue(option, iMinSchlongSize, "{0}")
		if(iMinSchlongSize > iMaxSchlongSize)
			iMaxSchlongSize = iMinSchlongSize + 1
			SetSliderOptionValue(oidMaxSchlongSize, iMaxSchlongSize, "{0}")
		endif
	elseif(option == oidMaxSchlongSize)
		iMaxSchlongSize = value as int
		SOS_MaxSchlongSize.setValue(iMaxSchlongSize)
		SetSliderOptionValue(option, iMaxSchlongSize, "{0}")
		if(iMaxSchlongSize < iMinSchlongSize)
			iMinSchlongSize = iMaxSchlongSize - 1
			SetSliderOptionValue(oidMinSchlongSize, iMinSchlongSize, "{0}")
		endif
	elseif(option == oidPlayerSize)
		iPlayerSize = value as int
		SchlongSizeSliderAccept(Game.GetPlayer(), iPlayerSize)
		SetSliderOptionValue(option, iPlayerSize, "{0}")
	elseif(option == oidNPCSize)
		iNPCSize = value as int
		SchlongSizeSliderAccept(PlayerAliasScript.selectedActor, iNPCSize)
		SetSliderOptionValue(option, iNPCSize, "{0}")
	elseif(option == oidGlobalSchlongSizeDistribution)
		iGlobalSchlongSizeDistribution = value as int
		SetRaceSizesForAllAddons(value)
		SetSliderOptionValue(option, iGlobalSchlongSizeDistribution, "{0}")
	elseif(option == oidGlobalSchlongTypeProbability)
		fGlobalSchlongTypeProbability = value
		SetRaceProbabilitiesForAllAddons(value)
		SetSliderOptionValue(option, fGlobalSchlongTypeProbability, "{2}%")
	elseif(currentAddonIndex > -1)
		int raceIndex = GetAddonOptionRaceIndex(option)
		Form addon = SOS_Data.GetAddon(currentAddonIndex)

		if(IsAddonOptionSetAllSizes(option))
			SetRaceSizesForAllRaces(addon, value, 2)
		elseif(IsAddonOptionSetAllProbabilities(option))
			SetRaceProbabilitiesForAllRaces(addon, value, 4)
		elseif(raceIndex > -1)
			if(IsAddonOptionRaceSize(option))
				SOS_Data.SetRaceSize(addon, raceIndex, value as Int)
				SetSliderOptionValue(option, value, "{0}")
			elseif(IsAddonOptionRaceProbability(option))
				SOS_Data.SetRaceProbability(addon, raceIndex, value)
				SetSliderOptionValue(option, value, "{2}%")
			endif
		endif
	endif

EndEvent

Event OnOptionKeyMapChange(int option, int keyCode, String conflictControl, String conflictName)
	{Called when a key has been remapped}
	bool overrideConflict = true
	if(conflictControl != "")
		if(conflictName == "")
			conflictName = "$Vanilla"
		endif
		overrideConflict = ShowMessage("$warn_keybinding{" + conflictName + "}{$"  + conflictControl + "}", true)
	endif

	if(overrideConflict)
		if(option == oidBendUpKey)
			iBendUpKey = keyCode
			SetKeyMapOptionValue(option, iBendUpKey)
			PlayerAliasScript.ReRegisterKeys()
		elseif(option == oidBendDownKey)
			iBendDownKey = keyCode
			SetKeyMapOptionValue(option, iBendDownKey)
			PlayerAliasScript.ReRegisterKeys()
		elseif(option == oidBendPlayerModifierKey)
			iBendPlayerModifierKey = keyCode
			SetKeyMapOptionValue(option, iBendPlayerModifierKey)
			PlayerAliasScript.ReRegisterKeys()
		endif
	endif
EndEvent

String Function GetCustomControl(int keyCode)
	{called to determine if this mods key configs conflict with anothers}
	if(keyCode == iBendUpKey)
		return "$Bend Schlongs up"
	elseif(keyCode == iBendDownKey)
		return "$Bend Schlongs down"
	else
		return ""
	endIf
EndFunction

Event OnOptionDefault(int option)
	{Called when the user wants to reset the option to "factory" settings}

	If(option == oidErectionSpellsEnabled)
		SetErectionSpellsEnabled(true)
		SetToggleOptionValue(option, bErectionSpellsEnabled)
	elseif(option == oidGlobalSchlongSizeBoostFactor)
		fGlobalSchlongSizeBoostFactor = 0
		;Debug.MessageBox("After pressing OK please wait for the reschlongification to finish")
		SendModEvent("ReSchlongify", "ScaleSchlongs")
		SetSliderOptionValue(oidGlobalSchlongSizeBoostFactor, 0, "{0}%")
	elseif(option == oidMinSchlongSize)
		iMinSchlongSize = 4
		SOS_MinSchlongSize.setValue(iMinSchlongSize)
		SetSliderOptionValue(oidMinSchlongSize, 4, "{0}")
	elseif(option == oidMaxSchlongSize)
		iMaxSchlongSize = 10
		SOS_MaxSchlongSize.setValue(iMaxSchlongSize)
		SetSliderOptionValue(oidMaxSchlongSize, 10, "{0}")
	elseif(option == oidPotionsEnabled)
		bPotionsEnabled = true
		SetPotionsEnabled(bPotionsEnabled)
		SetToggleOptionValue(oidPotionsEnabled, bPotionsEnabled)
	elseif(option == oidPlayerSchlong)
		; nothing
	elseif(option == oidPlayerSize)
		iPlayerSize = 1
		SchlongSizeSliderAccept(Game.GetPlayer(), iPlayerSize)
		SetSliderOptionValue(oidPlayerSize, iPlayerSize, "{0}")
	elseif(option == oidNPCSchlong)
		; nothing
	elseif(option == oidNPCSize)
		iNPCSize = 1
		SchlongSizeSliderAccept(PlayerAliasScript.selectedActor, iNPCSize)
		SetSliderOptionValue(oidNPCSize, iNPCSize, "{0}")
	elseif(option == oidDialogSettings)
		SetDialogSettings(false)
		SetMenuOptionValue(oidDialogSettings, sDialogSettingsLabels[0])
	elseif(option == oidGlobalSchlongSizeDistribution)
		iGlobalSchlongSizeDistribution = 0
		SetRaceSizesForAllAddons(iGlobalSchlongSizeDistribution)
		SetSliderOptionValue(oidGlobalSchlongSizeDistribution, iGlobalSchlongSizeDistribution, "{0}")
	elseif(option == oidGlobalSchlongTypeProbability)
		fGlobalSchlongTypeProbability = 10.0
		SetRaceProbabilitiesForAllAddons(fGlobalSchlongTypeProbability)
		SetSliderOptionValue(oidGlobalSchlongTypeProbability, fGlobalSchlongTypeProbability, "{2}%")
	elseif(option == oidBendUpKey)
		iBendUpKey = 201	; PgUp
		SetKeyMapOptionValue(oidBendUpKey, iBendUpKey)
	elseif(option == oidBendDownKey)
		iBendDownKey = 209	; PgDown
		SetKeyMapOptionValue(oidBendDownKey, iBendDownKey)
	elseif(option == oidBendPlayerModifierKey)
		iBendPlayerModifierKey = 42	; Left Shift
		SetKeyMapOptionValue(oidBendPlayerModifierKey, iBendPlayerModifierKey)
	endif

	;TODO: Add addon options ?

EndEvent

Event OnOptionMenuOpen(int option)
	{Called when a menu option has been selected}

	If option == oidDialogSettings
		SetMenuDialogStartIndex(iDialogSettings)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(sDialogSettingsLabels)
	ElseIf option == oidPlayerSchlong
		FillSchlongMenu(Game.GetPlayer())
	ElseIf option == oidNPCSchlong
		FillSchlongMenu(PlayerAliasScript.selectedActor)
	ElseIf IsOptionEnableGenders(option)
		Form addon = SOS_Data.GetAddon(currentAddonIndex)
		int index = SOS_Data.GetGender(addon) ; 0=Male, 1=Female, 2=Both, 10=Both but disabled for females, 11=Both but disabled for males
		If index > 2
			index -= 10
		EndIf
		SetMenuDialogStartIndex(index)
		SetMenuDialogDefaultIndex(2)
		SetMenuDialogOptions(sGenderLabels)
	EndIf

EndEvent

bool Function IsOptionEnableGenders(int option)
	return option - oidsOfCurrentAddon[0] == 1
EndFunction

Function FillSchlongMenu(Actor akActor)
	int i = 0
	int startIndex = 0
	int count = SOS_Data.CountAddons()
	Form currentAddon = SOS_Quest.GetActiveAddon(akActor)
	String[] options = Utility.CreateStringArray(count + 1)
	int sex = akActor.GetLeveledActorBase().GetSex()
	options[0] = "$No schlong"

	While i < count
		Form addon = SOS_Data.GetAddon(i)
		String label = addon.GetName()
		If !IsSchlongCompatible(addon, akActor, sex)
			label = label + " (*)"
		endIf
		options[i + 1] = label
		If addon == currentAddon
			startIndex = i + 1
		EndIf
		i += 1
	EndWhile

	SetMenuDialogStartIndex(startIndex)
	SetMenuDialogDefaultIndex(startIndex)
	SetMenuDialogOptions(options)
EndFunction

Event OnOptionMenuAccept(int option, int index)
	{Called when a menu entry has been accepted}
	if option == oidDialogSettings
		SetDialogSettings(index)
		SetMenuOptionValue(option, sDialogSettingsLabels[index])
	ElseIf option == oidPlayerSchlong
		SchlongTypeMenuAccept(Game.GetPlayer(), option, index)
	ElseIf option == oidNPCSchlong
		SchlongTypeMenuAccept(PlayerAliasScript.selectedActor, option, index)
	ElseIf IsOptionEnableGenders(option)
		Form addon = SOS_Data.GetAddon(currentAddonIndex)
		int gender = index
		If index != 2
			gender += 10
		EndIf
		SOS_Data.SetGender(addon, gender)
		SetMenuOptionValue(option, sGenderLabels[index])
	EndIf

EndEvent

Event OnOptionHighlight(int option)
	{Called on mouse hover of an option}

	if(option == oidSchlongificationEnabled)
		SetInfoText("$hl_schlongification_enabled")
	elseif(option == oidErectionSpellsEnabled)
		SetInfoText("$hl_erection_spells")
	elseif option == oidPlayerDebug || option == oidNPCDebug
		SetInfoText("$hl_debug_spells")
	elseif(option == oidMinSchlongSize)
		SetInfoText("$hl_min_size")
	elseif(option == oidMaxSchlongSize)
		SetInfoText("$hl_max_size")
	elseif(option == oidPotionsEnabled)
		SetInfoText("$hl_potions_enabled")
	elseif(option == oidPlayerSchlong || option == oidNPCSchlong)
		SetInfoText("$hl_player_schlong")
	elseif(option == oidPlayerSize)
		SetInfoText("$hl_player_size")
	elseif(option == oidNPCSchlong)
		SetInfoText("$hl_npc_schlong")
	elseif(option == oidNPCSize)
		SetInfoText("$hl_npc_size")
	elseif(option == oIdNoNPCselected)
		SetInfoText("$hl_no_npc")
	elseif(option == oidGlobalSchlongSizeBoostFactor)
		SetInfoText("$hl_global_boost")
	elseif(option == oidGlobalSchlongSizeDistribution)
		SetInfoText("$hl_global_size")
	elseif(option == oidGlobalSchlongTypeProbability)
		SetInfoText("$hl_global_type")
	elseif(option == oidBendUpKey)
		SetInfoText("$hl_bend_up")
	elseif(option == oidBendDownKey)
		SetInfoText("$hl_bend_down")
	elseif(option == oidBendPlayerModifierKey)
		SetInfoText("$hl_bend_player")
	elseif(option == oidRestart)
		SetInfoText("$hl_restart")
	elseif(option == oidRemove)
		SetInfoText("$hl_remove_SOS")
	elseif option == oidImport
		SetInfoText("Import MCM settings from file (\"" + SOS_IO.getFileName() + "\")") ; todo
	elseif option == oidExport
		SetInfoText("Export MCM settings to the \"" + SOS_IO.getFileName() + "\" file") ; todo
	elseif(option == oidNotificationsEnabled)
		SetInfoText("$hl_notifications_enabled")
	elseif(option == oidCleanArmors)
		SetInfoText("$hl_clean_armors")
	elseif option == oidPlayerArmorRevealing || option == oidNPCArmorRevealing
		SetInfoText("$hl_armor_revealing")
	elseif(currentAddonIndex > -1)
		if(option == oidsOfCurrentAddon[0])
			SetInfoText("$hl_addon_size")
		elseif(option == oidsOfCurrentAddon[2])
			SetInfoText("$hl_addon_probability")
		elseif(option == oidsOfCurrentAddon[4])
			SetInfoText("$hl_addon_clean")
		elseif(option == oidsOfCurrentAddon[6])
			SetInfoText("$hl_addon_remove")
		else
			; race specific setting
			;Debug.MessageBox("oid:" + option + " oidFirst:" + oidsOfCurrentAddon[0] + " -> index:" + optionIndex + " -> modulus:" + (optionIndex % 4))
			if(IsAddonOptionRaceEnable(option))
				SetInfoText("$hl_addon_race")
			elseif(IsAddonOptionRaceSize(option))
				SetInfoText("$hl_addon_race_size")
			elseif(IsAddonOptionRaceProbability(option))
				SetInfoText("$hl_addon_race_probability")
			elseif IsOptionEnableGenders(option)
				SetInfoText("$hl_gender_options")
			endif
		endif
	endif
EndEvent

;----------SOS-Functions----------

Function InitPages()
	{Reinitialize the mcm pages for schlong addons}
	int pageCount = SOS_Data.CountAddons() + 2
	if( pageCount > 127)
		pageCount = 127
	endif
	pages = Utility.CreateStringArray(pageCount)
	pages[0] = "$General Settings"
	pages[1] = "$Player NPC Settings"
	int i = 0
	int count = SOS_Data.CountAddons()
	while(i < count && i < 127)
		SOS_AddonQuest_Script sosAddon = SOS_Data.GetAddon(i)
		If sosAddon
			pages[i+2] = sosAddon.GetAddonName()
		Else
			pages[i+2] = "$missing_schlong"
		EndIf
		i += 1
	endwhile
	;Debug.trace("SOS MCM: " + i + " Addon Pages initialized")
EndFunction

int Function GetAddonIndexForName(String asAddonName)
	{Finds the addon of the given name in the list of addons and returns its index}
	int i = 0
	int count = SOS_Data.CountAddons()
	while(i < count && i < 127)
		SOS_AddonQuest_Script sosAddon = SOS_Data.GetAddon(i)
		if (sosAddon && sosAddon.GetAddonName() == asAddonName)
			return i
		endif
		i += 1
	endwhile
	return -1
EndFunction

Function SetRaceSizesForAllAddons(float value)
	int i = 0
	int addonCount = SOS_Data.CountAddons()
	while(i < addonCount)
		SetRaceSizesForAllRaces(SOS_Data.GetAddon(i), value)
		i += 1
	endwhile
EndFunction

Function SetRaceProbabilitiesForAllAddons(float value)
	int i = 0
	int addonCount = SOS_Data.CountAddons()
	while(i < addonCount)
		SetRaceProbabilitiesForAllRaces(SOS_Data.GetAddon(i), value)
		i += 1
	endwhile
EndFunction

Function SetRaceSizesForAllRaces(Form addon, float value, int aiOidOffset = -1)
	int i = 0
	int raceCount = SOS_Data.CountRaceSizes(addon)
	int optionId = -1
	while(i < raceCount)
		SOS_Data.SetRaceSize(addon, i, value as Int)
		if( currentAddonIndex > -1 && aiOidOffset > -1)
			; not so nice hardcodng
			optionId = oidsOfCurrentAddon[0] + 10 + Math.Floor(i / 2) * 8 + i % 2 + aiOidOffset
			SetSliderOptionValue(optionId, value, "{0}", true)
		endif
		i += 1
	endwhile
	if(optionId > -1 && aiOidOffset > -1)
		; redo the last update to force redraw
		SetSliderOptionValue(optionId, value, "{0}")
	endif
EndFunction

Function SetRaceProbabilitiesForAllRaces(Form addon, float value, int aiOidOffset = -1)
	int i = 0
	int raceCount = SOS_Data.CountRaceProbabilities(addon)
	int optionId = -1
	while(i < raceCount)
		SOS_Data.SetRaceProbability(addon, i, value)
		if( currentAddonIndex > -1 && aiOidOffset > -1)
			; not so nice hardcodng
			optionId = oidsOfCurrentAddon[0] + 10 + Math.Floor(i / 2) * 8 + i % 2 + aiOidOffset
			SetSliderOptionValue(optionId, value, "{2}%", true)
		endif
		i += 1
	endwhile
	if(optionId > -1 && aiOidOffset > -1)
		; redo the last update to force redraw
		SetSliderOptionValue(optionId, value, "{2}%")
	endif
EndFunction

String Function GetRaceName(Race akRace)
	String name = akRace.GetName()
	If akRace.HasKeywordString("Vampire")
		name = "$RacenameVampire{" + name + "}"
	ElseIf akRace.GetFormId() == 0x97a3d
		name = "$Afflicted"
	EndIf
	return name
EndFunction

Function SetPotionsEnabled(bool enable)
	bPotionsEnabled = enable

	If enable
		SOS_LItemChanceNone.SetValueInt(25)
	Else
		SOS_LItemChanceNone.SetValueInt(100)
	EndIf
EndFunction

bool Function IsSchlongCompatible(Form addon, Actor akActor, Int sex)
	bool addonCompatible = SOS_Quest.IsSchlongRaceCompatible(addon, akActor) \
			&& SOS_Quest.IsSchlongGenderAllowed(addon, sex)
	return addonCompatible
EndFunction

; just some convenience functions so the logic is not copied everywhere and can be adjusted at one place

int Function GetAddonOptionRaceIndex(int optionId)
	{For the given option id the race index that should be affected by this option is determined}
	return Math.Floor((optionId - oidsOfCurrentAddon[0] - 10) / 8) * 2 + optionId % 2
EndFunction

bool Function IsAddonOptionRaceEnable(int optionId)
	return (optionId - oidsOfCurrentAddon[0] - 10 - optionId % 2) % 8 == 0
EndFunction

bool Function IsAddonOptionRaceSize(int optionId)
	return (optionId - oidsOfCurrentAddon[0] - 10 - optionId % 2) % 8 == 2
EndFunction

bool Function IsAddonOptionRaceProbability(int optionId)
	return (optionId - oidsOfCurrentAddon[0] - 10 - optionId % 2) % 8 == 4
EndFunction

bool Function IsAddonOptionSetAllSizes(int optionId)
	return optionId - oidsOfCurrentAddon[0] == 0
EndFunction

bool Function IsAddonOptionSetAllProbabilities(int optionId)
	return optionId - oidsOfCurrentAddon[0] == 2
EndFunction

bool Function IsAddonOptionClean(int optionId)
	return optionId - oidsOfCurrentAddon[0] == 4
EndFunction

bool Function IsAddonOptionRemove(int optionId)
	return optionId - oidsOfCurrentAddon[0] == 6
EndFunction

Function SchlongTypeMenuAccept(Actor akActor, int option, int index)
	Form oldAddon = SOS_Quest.GetActiveAddon(akActor)
	int idSize = oidPlayerSize
	If option == oidNPCSchlong
		idSize = oidNPCSize
	EndIf

	If index == 0 && oldAddon
		; remove schlong
		SOS_Quest.RemoveSchlongFromActor(oldAddon, akActor)
		SOS_Data.AddBlacklisted(akActor)
		SetOptionFlags(idSize, OPTION_FLAG_DISABLED) ; disable schlong size option
	ElseIf index > 0
		Form newAddon = SOS_Data.GetAddon(index - 1)
		If !newAddon || newAddon == oldAddon
			Return
		EndIf

		bool addonCompatible = IsSchlongCompatible(newAddon, akActor, akActor.GetLeveledActorBase().GetSex())
		; Check for Design Compatibility or warn the user about possible addon shape mismatch/compatibility
		If addonCompatible || ShowMessage("$warn_custom_actor", true)
			SOS_Quest.SetSchlong(akActor, newAddon, true)
			SetOptionFlags(idSize, OPTION_FLAG_NONE) ; enable schlong size option
		EndIf
	EndIf
EndFunction

Function SchlongSizeSliderAccept(Actor akActor, int size)
	Form addon = SOS_Quest.GetActiveAddon(akActor)
	If addon
		SOS_Quest.SetSchlongSize(addon, akActor, size)
	EndIf
EndFunction

Function SetDialogSettings(bool enable)
	iDialogSettings = enable as int
	Game.GetPlayer().SetFactionRank(SOS_Quest.SOS_DialogSetup, iDialogSettings)
EndFunction

Function SetErectionSpellsEnabled(bool enable)
	bErectionSpellsEnabled = enable
	SOS_Quest.GiveOrRemoveInteractionSpells(enable, false)
EndFunction

Function CloseMCM()
	UI.Invoke("Journal Menu", "_root.QuestJournalFader.Menu_mc.ConfigPanelClose")
	UI.Invoke("Journal Menu", "_root.QuestJournalFader.Menu_mc.CloseMenu")
EndFunction

; DEPRECATED PROPERTIES
FormList Property SOS_AddonLock Auto
FormList Property SOS_Addons Auto
FormList Property SOS_CompatibleRaces Auto
FormList Property SOS_EnabledRaces Auto
FormList Property SOS_RaceSizes Auto
FormList Property SOS_RaceProbabilities Auto
LeveledItem Property SOS_LItemDragonEssence Auto
LeveledItem Property SOS_LItemFalmerEssence Auto
LeveledItem Property SOS_LItemTrollEssence Auto
Potion Property SOS_DragonEssence Auto
Potion Property SOS_FalmerEssence Auto
Potion Property SOS_TrollEssence Auto
