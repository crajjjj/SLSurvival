Scriptname CreatureFrameworkConfig extends SKI_ConfigBase
{The Mod Configuration Menu script | Creature Framework}

; General properties
CreatureFramework property API auto hidden

; General settings
bool property GenSexLab = true auto hidden
bool property GenAroused = true auto hidden
int property GenArousalThreshold = 35 auto hidden

; Debug settings
bool property DbgOutputLog = false auto hidden
bool property DbgOutputConsole = false auto hidden

; Performance settings
GlobalVariable property CFCloakCreatures auto ; To enhace the performance since now the cloak just detect the creatures without aroused body.
int property PrfCloakCreatures hidden
	int function get()
		return 	CFCloakCreatures.GetValueInt()
	endFunction
	function set(int value)
		CFCloakCreatures.SetValueInt(value)
	endFunction
endProperty

GlobalVariable property CFCloakRange auto ; To be used as the PrfCloakRange for the aliaas conditions, i don't replace the PrfCloakRange to avoid issues for now.
float property PrfCloakRange hidden
	float function get()
		return 	CFCloakRange.GetValue()
	endFunction
	function set(float value)
		CFCloakRange.SetValue(value)
	endFunction
endProperty

Float property PrfTimeout = 15.0 auto hidden

; Puppeteer settings
int property PupTargetKey = 49 auto hidden

; Creatures page stuff
int jCreatureRacesArr
int jCreatureOptionsArr
int creaturesRaceCount
int creaturePages
int creaturePage

; Get the version of the mod
int function GetVersion()
	return CreatureFrameworkUtility.GetVersion()
endFunction

; Get the textual representation of the version of the mod
string function GetVersionString()
	return CreatureFrameworkUtility.GetVersionString()
endFunction

; The mod has been updated
event OnVersionUpdate(int version)
	; Don't need to do anything yet
endEvent

; The game has been loaded
event OnGameReload()
	parent.OnGameReload()
	Utility.Wait(3)

	Pages = new string[4]
	Pages[0] = "$General"
	Pages[1] = "$Performance"
	Pages[2] = "$Creatures"
	Pages[3] = "$Puppeteer"

	creaturePage = 1
	API = CreatureFrameworkUtility.GetAPI()
	API.Initialize()
endEvent

; The config menu has been opened
event OnConfigOpen()
	if !API.IsMuckingAboutAllowed()
		ShowMessage("$CF_Message_NoMuckingAbout", false, "$OK")
	endIf
endEvent

; The config menu has been closed
event OnConfigClose()
	JValue.ZeroLifetime(jCreatureRacesArr)
	JValue.ZeroLifetime(jCreatureOptionsArr)
	jCreatureOptionsArr = JValue.Release(jCreatureOptionsArr)
	jCreatureRacesArr = JValue.Release(jCreatureRacesArr)
endEvent

; A config page is being displayed
event OnPageReset(string page)
	if page == "$General"
		PageGeneral()
	elseIf page == "$Performance"
		PagePerformance()
	elseIf page == "$Creatures"
		PageCreatures()
	elseIf page == "$Puppeteer"
		PagePuppeteer()
	else
		PageEmpty()
	endIf
endEvent

; Make the options for no page selection
function PageEmpty()
	SetCursorFillMode(TOP_TO_BOTTOM)
	AddTextOption("Creature Framework", "", OPTION_FLAG_DISABLED)
	AddTextOption("$Version:", GetVersionString(), OPTION_FLAG_DISABLED)
	AddEmptyOption()
	if API.SexLab != none
		AddTextOption("$SexLab version:", SexLabUtil.GetStringVer(), OPTION_FLAG_DISABLED)
	else
		AddTextOption("$SexLab version:", "$Not installed", OPTION_FLAG_DISABLED)
	endIf
	if API.SexLabAroused != none
		AddTextOption("$SexLab Aroused version:", API.SexLabAroused.GetVersion(), OPTION_FLAG_DISABLED)
	else
		AddTextOption("$SexLab Aroused version:", "$Not installed", OPTION_FLAG_DISABLED)
	endIf
endFunction



;----------------------------------------------------------------
; Page: General							|
;----------------------------------------------------------------

; Make the options for the general page
function PageGeneral()
	SetCursorFillMode(TOP_TO_BOTTOM)

	AddHeaderOption("$Arousal")
	if API.IsSexLabInstalled()
		AddToggleOptionST("GEN_SexLab", "$CF_SettingName_GenSexLab", GenSexLab)
	else
		AddToggleOption("$CF_SettingName_GenSexLab", GenSexLab, OPTION_FLAG_DISABLED)
	endIf
	if API.IsArousedInstalled()
		AddToggleOptionST("GEN_Aroused", "$CF_SettingName_GenAroused", GenAroused)
	else
		AddToggleOption("$CF_SettingName_GenAroused", GenAroused, OPTION_FLAG_DISABLED)
	endIf
	if API.IsArousedEnabled()
		AddSliderOptionST("GEN_ArousalThreshold", "$CF_SettingName_GenArousalThreshold", GenArousalThreshold)
	else
		AddSliderOption("$CF_SettingName_GenArousalThreshold", GenArousalThreshold, "{0}", OPTION_FLAG_DISABLED)
	endIf

	AddEmptyOption()
	AddHeaderOption("$Debug")
	AddToggleOptionST("DBG_OutputLog", "$CF_SettingName_DbgOutputLog", DbgOutputLog)
	AddToggleOptionST("DBG_OutputConsole", "$CF_SettingName_DbgOutputConsole", DbgOutputConsole)
	AddTextOptionST("DBG_Dump", "$CF_SettingName_DbgDump", "")

	SetCursorPosition(1)

	AddHeaderOption("$Cleaning")
	AddTextOptionST("CLN_ClearEvents", "$CF_SettingName_ClnClearEvents", "")
	AddTextOptionST("CLN_ClearFormDB", "$CF_SettingName_ClnClearFormDB", "")
	AddTextOptionST("CLN_ClearCreatures", "$CF_SettingName_ClnClearCreatures", "")
	if API.IsMuckingAboutAllowed()
		AddTextOptionST("CLN_Reregister", "$CF_SettingName_ClnReregister", "")
		AddTextOptionST("CLN_Uninstall", "$CF_SettingName_ClnUninstall", "")
	else
		AddTextOptionST("CLN_Reregister", "$CF_SettingName_ClnReregister", "", OPTION_FLAG_DISABLED)
		AddTextOptionST("CLN_Uninstall", "$CF_SettingName_ClnUninstall", "", OPTION_FLAG_DISABLED)
	endIf
endFunction

; General setting: SexLab integration (toggle)
state GEN_SexLab
	event OnSelectST()
		GenSexLab = !GenSexLab
		SetToggleOptionValueST(GenSexLab)
	endEvent
	event OnDefaultST()
		GenSexLab = true
		SetToggleOptionValueST(GenSexLab)
	endEvent
	event OnHighlightST()
		SetInfoText("$CF_SettingInfo_GenSexLab")
	endEvent
endState

; General setting: SexLab Aroused integration (toggle)
state GEN_Aroused
	event OnSelectST()
		GenAroused = !GenAroused
		SetToggleOptionValueST(GenAroused)
		API.ArousedSettingChanged()
	endEvent
	event OnDefaultST()
		GenAroused = true
		SetToggleOptionValueST(GenAroused)
		API.ArousedSettingChanged()
	endEvent
	event OnHighlightST()
		SetInfoText("$CF_SettingInfo_GenAroused")
	endEvent
endState

; General setting: Arousal threshold (slider)
state GEN_ArousalThreshold
	event OnSliderOpenST()
		SetSliderDialogStartValue(GenArousalThreshold)
		SetSliderDialogDefaultValue(35.0)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	endEvent
	event OnSliderAcceptST(float value)
		GenArousalThreshold = value as int
		SetSliderOptionValueST(GenArousalThreshold)
		API.ArousedSettingChanged()
	endEvent
	event OnDefaultST()
		GenArousalThreshold = 35
		SetSliderOptionValueST(GenArousalThreshold)
		API.ArousedSettingChanged()
	endEvent
	event OnHighlightST()
		SetInfoText("$CF_SettingInfo_GenArousalThreshold")
	endEvent
endState

; Debug setting: File logging (toggle)
state DBG_OutputLog
	event OnSelectST()
		DbgOutputLog = !DbgOutputLog
		SetToggleOptionValueST(DbgOutputLog)
	endEvent
	event OnDefaultST()
		DbgOutputLog = false
		SetToggleOptionValueST(DbgOutputLog)
	endEvent
	event OnHighlightST()
		SetInfoText("$CF_SettingInfo_DbgOutputLog")
	endEvent
endState

; Debug setting: Console logging (toggle)
state DBG_OutputConsole
	event OnSelectST()
		DbgOutputConsole = !DbgOutputConsole
		SetToggleOptionValueST(DbgOutputConsole)
	endEvent
	event OnDefaultST()
		DbgOutputConsole = false
		SetToggleOptionValueST(DbgOutputConsole)
	endEvent
	event OnHighlightST()
		SetInfoText("$CF_SettingInfo_DbgOutputConsole")
	endEvent
endState

; Debug setting: Dump data (text)
state DBG_Dump
	event OnSelectST()
		API.Dump()
		ShowMessage("$CF_Message_DumpSuccess", false)
	endEvent
	event OnHighlightST()
		SetInfoText("$CF_SettingInfo_DbgDump")
	endEvent
endState

; Cleaning setting: Clear events (text)
state CLN_ClearEvents
	event OnSelectST()
		if ShowMessage("$CF_Message_ConfirmClearEvents", true, "$Yes", "$No")
			API.ClearEvents()
		endIf
	endEvent
	event OnHighlightST()
		SetInfoText("$CF_SettingInfo_ClnClearEvents")
	endEvent
endState

; Cleaning setting: Clear Form DB (text)
state CLN_ClearFormDB
	event OnSelectST()
		API.ClearFormDB()
	endEvent
	event OnHighlightST()
		SetInfoText("$CF_SettingInfo_ClnClearFormDB")
	endEvent
endState

; Cleaning setting: Clear creatures (text)
state CLN_ClearCreatures
	event OnSelectST()
		if ShowMessage("$CF_Message_ConfirmClearCreatures", true, "$Yes", "$No")
			API.ClearCreatures()
		endIf
	endEvent
	event OnHighlightST()
		SetInfoText("$CF_SettingInfo_ClnClearCreatures")
	endEvent
endState

; Cleaning setting: Reregister mods (text)
state CLN_Reregister
	event OnSelectST()
		if ShowMessage("$CF_Message_ConfirmReregister", true, "$Yes", "$No")
			API.ReregisterAllMods()
			API.ClearLogFormDB()
			ForcePageReset()
		endIf
	endEvent
	event OnHighlightST()
		SetInfoText("$CF_SettingInfo_ClnReregister")
	endEvent
endState

; Cleaning setting: Uninstall (text)
state CLN_Uninstall
	event OnSelectST()
		if API.IsMuckingAboutAllowed()
			if ShowMessage("$CF_Message_ConfirmUninstall", true, "$Yes", "$No")
				API.Uninstall()
				ForcePageReset()
			endIf
		else
			CreatureFrameworkUtility.Log("[Config] Not uninstalling; no mucking about!")
		endIf
	endEvent
	event OnHighlightST()
		SetInfoText("$CF_SettingInfo_ClnUninstall")
	endEvent
endState



;----------------------------------------------------------------
; Page: Performance						|
;----------------------------------------------------------------

; Make the options for the performance page
function PagePerformance()
	SetCursorFillMode(TOP_TO_BOTTOM)
	AddHeaderOption("$Performance")
	AddSliderOptionST("PRF_CloakRange", "$CF_SettingName_PrfCloakRange", PrfCloakRange)
	AddSliderOptionST("PRF_CloakMaxCreature", "$CF_SettingName_PrfCloakMaxCreatures", PrfCloakCreatures, "{0}")
	AddSliderOptionST("PRF_CloakCooldown", "$CF_SettingName_PrfCloakCooldown", PrfTimeout, "$CF_SettingFormat_Seconds")
endFunction

; Performance setting: Cloak Max Creature (slider)
state PRF_CloakMaxCreature
	event OnSliderOpenST()
		SetSliderDialogStartValue(PrfCloakCreatures)
		SetSliderDialogDefaultValue(6)
		SetSliderDialogRange(0, API.CFQuestDetectCreature.GetNumAliases())
		SetSliderDialogInterval(2)
	endEvent
	event OnSliderAcceptST(float value)
		PrfCloakCreatures = value as int
		SetSliderOptionValueST(PrfCloakCreatures, "{0}")
	endEvent
	event OnDefaultST()
		PrfCloakCreatures = 6
		SetSliderOptionValueST(PrfCloakCreatures, "{0}")
	endEvent
	event OnHighlightST()
		SetInfoText("$CF_SettingInfo_PrfCloakMaxCreatures")
	endEvent
endState

; Performance setting: Cloak range (slider)
state PRF_CloakRange
	event OnSliderOpenST()
		SetSliderDialogStartValue(PrfCloakRange)
		SetSliderDialogDefaultValue(2000.0)
		SetSliderDialogRange(1000.0, 4000.0)
		SetSliderDialogInterval(200.0)
	endEvent
	event OnSliderAcceptST(float value)
		PrfCloakRange = value
		SetSliderOptionValueST(value)
	endEvent
	event OnDefaultST()
		PrfCloakRange = 2000.0
		SetSliderOptionValueST(2000.0)
	endEvent
	event OnHighlightST()
		SetInfoText("$CF_SettingInfo_PrfCloakRange")
	endEvent
endState

; Performance setting: Cloak cooldown (slider)
state PRF_CloakCooldown
	event OnSliderOpenST()
		SetSliderDialogStartValue(PrfTimeout)
		SetSliderDialogDefaultValue(15.0)
		SetSliderDialogRange(5.0, 30.0)
		SetSliderDialogInterval(5.0)
	endEvent
	event OnSliderAcceptST(float value)
		PrfTimeout = value
		SetSliderOptionValueST(PrfTimeout, "$CF_SettingFormat_Seconds")
		API.TimeSettingChanged()
	endEvent
	event OnDefaultST()
		PrfTimeout = 15.0
		SetSliderOptionValueST(PrfTimeout, "$CF_SettingFormat_Seconds")
		API.TimeSettingChanged()
	endEvent
	event OnHighlightST()
		SetInfoText("$CF_SettingInfo_PrfCloakCooldown")
	endEvent
endState

;----------------------------------------------------------------
; Page: Creatures						|
;----------------------------------------------------------------

; Make the options for the creatures page
function PageCreatures()
	SetCursorFillMode(LEFT_TO_RIGHT)

	; Get the list of races, and figure out how many pages to split them into
	if !JValue.IsExists(jCreatureRacesArr)
		jCreatureRacesArr = API.GetRegisteredRaces()
		JValue.Retain(jCreatureRacesArr)
		creaturesRaceCount = JArray.Count(jCreatureRacesArr)
		creaturePages = Math.Ceiling(creaturesRaceCount / 10.0)
		if creaturePages < 1
			creaturePages = 1
		endIf
		if creaturePage > creaturePages
			creaturePage = 1
		endIf
		CreatureFrameworkUtility.Log("[Config] Creatures page opened; Race count: " + creaturesRaceCount + "; pages: " + creaturePages + "; current page: " + creaturePage)
	endIf

	; Make the paginator
	AddSliderOptionST("CRE_Page", "$CF_SettingName_CrePage", creaturePage)
	AddTextOption("$CF_SettingName_CrePages", creaturePages, OPTION_FLAG_DISABLED)
	if creaturePages > 1
		AddTextOptionST("CRE_PrevPage", "$CF_SettingName_CrePrevPage", "")
		AddTextOptionST("CRE_NextPage", "$CF_SettingName_CreNextPage", "")
	else
		AddTextOptionST("CRE_PrevPage", "$CF_SettingName_CrePrevPage", "", OPTION_FLAG_DISABLED)
		AddTextOptionST("CRE_NextPage", "$CF_SettingName_CreNextPage", "", OPTION_FLAG_DISABLED)
	endIf
	AddEmptyOption()
	AddEmptyOption()

	; Get the relevant chunk of the races array
	int startIndex = (creaturePage - 1) * 10
	int endIndex = startIndex + 10
	if endIndex > creaturesRaceCount
		endIndex = creaturesRaceCount
	endIf
	int jRacesChunkArr = JArray.SubArray(jCreatureRacesArr, startIndex, endIndex)
	int racesChunkSize = JArray.Count(jRacesChunkArr)

	if racesChunkSize > 0
		jCreatureOptionsArr = JValue.ReleaseAndRetain(jCreatureOptionsArr, JArray.Object())
		int r = 0
		while r < racesChunkSize
			Race raceForm = JArray.GetForm(jRacesChunkArr, r) as Race
			AddHeaderOption(API.GetRaceName(raceForm))
			AddHeaderOption("")

			int jSkinsArr = API.GetSkinsRegisteredToRace(raceForm)
			int skinsSize = JArray.Count(jSkinsArr)

			; Add fake skin (we do this separately to make sure it's the first option in the list)
			if JArray.FindForm(jSkinsArr, API.CFFakeSkin) != -1
				; Get the active mod name
				string theModName = API.GetActiveModName(raceForm, API.CFFakeSkin)
				if theModName == ""
					theModName = "$Disabled"
				endIf

				; Add it to the options
				int jCreatureOptionMap = JMap.Object()
				JMap.SetInt(jCreatureOptionMap, "id", AddMenuOption("$All skins", theModName))
				JMap.SetForm(jCreatureOptionMap, "race", raceForm)
				JMap.SetForm(jCreatureOptionMap, "skin", API.CFFakeSkin)
				JArray.AddObj(jCreatureOptionsArr, jCreatureOptionMap)
			endIf

			; Add all other skins
			int s = 0
			while s < skinsSize
				Armor skinForm = JArray.GetForm(jSkinsArr, s) as Armor

				if skinForm != API.CFFakeSkin
					; Get the active mod name
					string theModName = API.GetActiveModName(raceForm, skinForm)
					if theModName == ""
						theModName = "$Disabled"
					endIf

					; Add it to the options
					int jCreatureOptionMap = JMap.Object()
					JMap.SetInt(jCreatureOptionMap, "id", AddMenuOption(API.GetSkinName(skinForm), theModName))
					JMap.SetForm(jCreatureOptionMap, "race", raceForm)
					JMap.SetForm(jCreatureOptionMap, "skin", skinForm)
					JArray.AddObj(jCreatureOptionsArr, jCreatureOptionMap)
				endIf

				s += 1
			endWhile

			; Add another option to make it even
			if skinsSize % 2 == 1
				AddEmptyOption()
			endIf

			r += 1
		endWhile
	else
		AddTextOption("$CF_Message_NoRegistrations", "", OPTION_FLAG_DISABLED)
	endIf
endFunction

; Creature page indicator
state CRE_Page
	event OnSliderOpenST()
		SetSliderDialogStartValue(creaturePage)
		SetSliderDialogDefaultValue(1)
		SetSliderDialogRange(1, creaturePages)
	endEvent
	event OnSliderAcceptST(float value)
		creaturePage = value as int
		ForcePageReset()
	endEvent
	event OnDefaultST()
		creaturePage = 1
		ForcePageReset()
	endEvent
endState

; Creatures next page
state CRE_NextPage
	event OnSelectST()
		creaturePage += 1
		if creaturePage > creaturePages
			creaturePage = 1
		endIf
		ForcePageReset()
	endEvent
endState

; Creatures previous page
state CRE_PrevPage
	event OnSelectST()
		creaturePage -= 1
		if creaturePage < 1
			creaturePage = creaturePages
		endIf
		ForcePageReset()
	endEvent
endState

; A creature option has opened
event OnOptionMenuOpen(int option)
	int creatureOptionsSize = JArray.Count(jCreatureOptionsArr)
	int o = 0
	while o < creatureOptionsSize
		int jOptionMap = JArray.GetObj(jCreatureOptionsArr, o)
		if option == JMap.GetInt(jOptionMap, "id")
			Race optionRace = JMap.GetForm(jOptionMap, "race") as Race
			Armor optionSkin = JMap.GetForm(jOptionMap, "skin") as Armor

			; Build the options array
			int mods = API.GetModsRegisteredWithCreature(optionRace, optionSkin)
			int modsSize = JArray.Count(mods)
			string[] options = Utility.CreateStringArray(modsSize + 1)
			options[0] = "$Disable"
			int m = 0
			while m < modsSize
				options[m + 1] = API.GetModName(JArray.GetStr(mods, m))
				m += 1
			endWhile

			; Set up the menu
			SetMenuDialogOptions(options)
			SetMenuDialogDefaultIndex(0)
			SetMenuDialogStartIndex(API.GetActiveModIndex(optionRace, optionSkin) + 1)
		endIf
		o += 1
	endWhile
endEvent

; A creature option has been accepted
event OnOptionMenuAccept(int option, int index)
	if index < 0
		index = 0
	endIf
	int creatureOptionsSize = JArray.Count(jCreatureOptionsArr)
	int o = 0
	while o < creatureOptionsSize
		int jOptionMap = JArray.GetObj(jCreatureOptionsArr, o)
		if option == JMap.GetInt(jOptionMap, "id")
			Race optionRace = JMap.GetForm(jOptionMap, "race") as Race
			Armor optionSkin = JMap.GetForm(jOptionMap, "skin") as Armor
			API.SetActiveModUsingIndex(optionRace, optionSkin, index - 1)
			string name
			if index == 0
				name = "$Disabled"
			else
				name = API.GetActiveModName(optionRace, optionSkin)
			endIf
			SetMenuOptionValue(option, name)
		endIf
		o += 1
	endWhile
endEvent

; A creature option has been highlighted
event OnOptionHighlight(int option)
	int creatureOptionsSize = JArray.Count(jCreatureOptionsArr)
	int o = 0
	while o < creatureOptionsSize
		int jOptionMap = JArray.GetObj(jCreatureOptionsArr, o)
		if option == JMap.GetInt(jOptionMap, "id")
			SetInfoText("$" + API.GetModCountRegisteredWithCreature(JMap.GetForm(jOptionMap, "race") as Race, JMap.GetForm(jOptionMap, "skin") as Armor) + " registered mods")
		endIf
		o += 1
	endWhile
endEvent

; A creature option has been defaulted
event OnOptionDefault(int option)
	int creatureOptionsSize = JArray.Count(jCreatureOptionsArr)
	int o = 0
	while o < creatureOptionsSize
		int jOptionMap = JArray.GetObj(jCreatureOptionsArr, o)
		if option == JMap.GetInt(jOptionMap, "id")
			API.SetActiveMod(JMap.GetForm(jOptionMap, "race") as Race, JMap.GetForm(jOptionMap, "skin") as Armor, -1)
			SetMenuOptionValue(option, "$Disabled")
		endIf
		o += 1
	endWhile
endEvent



;----------------------------------------------------------------
; Page: Puppeteer						|
;----------------------------------------------------------------

; Make the options for the puppeteer page
function PagePuppeteer()
	Actor puppet = API.GetPuppet()
	if puppet
		string name = CreatureFrameworkUtility.GetActorName(puppet)
		Race raceForm = puppet.GetRace()
		string raceName = API.GetRaceName(raceForm)
		if raceName == ""
			raceName = raceForm.GetName()
		endIf
		Armor skinForm = API.GetSkinOrFakeFromActor(puppet)
		string skinName = API.GetSkinName(skinForm)
		if skinName == ""
			skinName = "$Unknown"
		endIf
		string activeMod = API.GetActiveModName(raceForm, skinForm)
		if activeMod == ""
			activeMod = API.GetActiveModName(raceForm, none)
		endIf
		if activeMod == ""
			activeMod = "$None"
		endIf
		string active = "$No"
		if API.IsActorActive(puppet)
			active = "$Yes"
		endIf

		string aroused = "$No"
		if API.IsAroused(puppet)
			aroused = "$Yes"
		endIf
		string arousalSource = API.GetArousalSourceText(API.GetArousalSource(puppet))
		string arousalRating = "$Not installed"
		if API.IsArousedInstalled()
			arousalRating = puppet.GetFactionRank(API.ArousedFaction)
		endIf
		SetCursorFillMode(TOP_TO_BOTTOM)

		AddTextOption("$Puppet", name, OPTION_FLAG_DISABLED)
		AddEmptyOption()

		AddHeaderOption("$Registration")
		AddTextOption("$Race", raceName, OPTION_FLAG_DISABLED)
		AddTextOption("$Skin", skinName, OPTION_FLAG_DISABLED)
		AddTextOption("$Active mod", activeMod, OPTION_FLAG_DISABLED)
		AddEmptyOption()

		AddHeaderOption("$Status")
		AddTextOption("$Active", active, OPTION_FLAG_DISABLED)
		AddTextOptionST("PUP_TriggerUpdate", "$CF_SettingName_PupTriggerUpdate", "")

		SetCursorPosition(1)

		AddKeyMapOptionST("PUP_TargetKey", "$CF_SettingName_PupTargetKey", PupTargetKey)
		AddEmptyOption()

		AddHeaderOption("$Arousal")
		AddTextOption("$Aroused", aroused, OPTION_FLAG_DISABLED)
		AddTextOption("$Arousal source", arousalSource, OPTION_FLAG_DISABLED)
		if API.IsArousedInstalled()
			int Arousal = puppet.GetFactionRank(API.ArousedFaction)
			AddSliderOptionST("PUP_OverrideArousal", "$SexLab Aroused rating", Arousal)
		else
			AddTextOption("$SexLab Aroused rating", arousalRating, OPTION_FLAG_DISABLED)	
		endIf

	else
		SetCursorFillMode(LEFT_TO_RIGHT)
		AddTextOption("$CF_Message_NoPuppetTarget", "", OPTION_FLAG_DISABLED)
		AddKeyMapOptionST("PUP_TargetKey", "$CF_SettingName_PupTargetKey", PupTargetKey)
	endIf
endFunction

; Puppeteer setting: Target key (key)
state PUP_TargetKey
	event OnKeyMapChangeST(int newKeyCode, string conflictControl, string conflictName)
		bool continue = true
		if conflictControl != ""
			string confirmMessage
			if conflictName != ""
				confirmMessage = "This key is already mapped to:\n\"" + conflictControl + "\"\n(" + conflictName + ")\n\nAre you sure you want to continue?"
			else
				confirmMessage = "This key is already mapped to:\n\"" + conflictControl + "\"\n\nAre you sure you want to continue?"
			endIf
			continue = ShowMessage(confirmMessage, true, "$Yes", "$No")
		endIf
		if continue
			PupTargetKey = newKeyCode
			SetKeyMapOptionValueST(PupTargetKey)
			API.PuppetTargetKeyChange()
		endIf
	endEvent
	event OnDefaultST()
		PupTargetKey = 49
		SetKeyMapOptionValueST(PupTargetKey)
	endEvent
	event OnHighlightST()
		SetInfoText("$CF_SettingInfo_PupTargetKey")
	endEvent
endState

; Puppeteer setting: Trigger update (text)
state PUP_TriggerUpdate
	event OnSelectST()
		API.TriggerUpdateForActor(API.GetPuppet())
	endEvent
	event OnHighlightST()
		SetInfoText("$CF_SettingInfo_PupTriggerUpdate")
	endEvent
endState

; Puppeteer setting: Override Aroused rating (Slider)
state PUP_OverrideArousal
	event OnSliderOpenST() 
		int Arousal = API.GetPuppet().GetFactionRank(API.ArousedFaction)
		SetSliderDialogStartValue(Arousal)
		SetSliderDialogDefaultValue(Arousal)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	endEvent
	event OnSliderAcceptST(float value)
		Actor puppet = API.GetPuppet()
		SetSliderOptionValueST(value as int)
		API.SexLabAroused.SetActorExposure(puppet, value as int)
		puppet.SetFactionRank(API.ArousedFaction, value as int)
	endEvent
	event OnHighlightST()
		SetInfoText("$CF_SettingName_PupOverrideArousal")
	endEvent
endState
