Scriptname CFConfigMenu extends SKI_ConfigBase
{The Mod Configuration Menu script | Creature Framework}

; General properties
CFQuestMain property MainQuest auto
CreatureFramework property API auto hidden

; General settings
bool property GenSexLab = true auto hidden
bool property GenAroused = true auto hidden
int property GenArousalThreshold = 50 auto hidden

; Gender settings
int property GndDefault = 0 auto hidden
bool property GndMaleFallback = true auto hidden
bool property GndUseSexLab = true auto hidden
bool property GndSexLabExcludeTransformations = true auto hidden

; Debug settings
bool property DbgOutputLog = true auto hidden
bool property DbgOutputConsole = false auto hidden

; Performance settings
int property PrfCloakRate = 5 auto hidden
int property PrfCloakDuration = 1 auto hidden
int property PrfCloakRange = 288 auto hidden
int property PrfCloakCooldown = 60 auto hidden
int property PrfArousalPollRate = 10 auto hidden
int property PrfFormDBClearRate = 15 auto hidden
int property PrfGenderClearRate = 15 auto hidden

; Puppeteer settings
int property PupTargetKey = 49 auto hidden

; The default gender entries
string[] genders

; Creatures page stuff
int jCreatureRacesArr
int jCreatureOptionsArr
int creaturesRaceCount
int creaturePages
int creaturePage

; Get the version of the mod
int function GetVersion()
	return CreatureFrameworkUtil.GetVersion()
endFunction

; Get the textual representation of the version of the mod
string function GetVersionString()
	return CreatureFrameworkUtil.GetVersionString()
endFunction

; The mod has been updated
event OnVersionUpdate(int version)
	; Don't need to do anything yet
endEvent

; The game has been loaded
event OnGameReload()
	parent.OnGameReload()
	Utility.Wait(3)

	genders = new string[3]
	genders[0] = "$Random"
	genders[1] = "$Male"
	genders[2] = "$Female"

	Pages = new string[4]
	Pages[0] = "$General"
	Pages[1] = "$Performance"
	Pages[2] = "$Creatures"
	Pages[3] = "$Puppeteer"

	creaturePage = 1

	API = CreatureFrameworkUtil.GetAPI()
	API.Initialize()
	MainQuest.Maintenance()
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



;/----------------------------------------\
 | Page: General                          |
 \----------------------------------------/;

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

	AddHeaderOption("$Genders")
	AddMenuOptionST("GND_Default", "$CF_SettingName_GndDefault", genders[GndDefault])
	AddToggleOptionST("GND_MaleFallback", "$CF_SettingName_GndMaleFallback", GndMaleFallback)
	if API.IsSexLabInstalled()
		AddToggleOptionST("GND_UseSexLab", "$CF_SettingName_GndUseSexLab", GndUseSexLab)
	else
		AddToggleOptionST("GND_UseSexLab", "$CF_SettingName_GndUseSexLab", GndUseSexLab, OPTION_FLAG_DISABLED)
	endIf
	if API.IsSexLabInstalled() && GndUseSexLab
		AddToggleOptionST("GND_SexLabExcludeTransformations", "$CF_SettingName_GndSexLabExcludeTransformations", GndSexLabExcludeTransformations)
	else
		AddToggleOptionST("GND_SexLabExcludeTransformations", "$CF_SettingName_GndSexLabExcludeTransformations", GndSexLabExcludeTransformations, OPTION_FLAG_DISABLED)
	endIf

	SetCursorPosition(1)

	AddHeaderOption("$Debug")
	AddToggleOptionST("DBG_OutputLog", "$CF_SettingName_DbgOutputLog", DbgOutputLog)
	AddToggleOptionST("DBG_OutputConsole", "$CF_SettingName_DbgOutputConsole", DbgOutputConsole)
	AddTextOptionST("DBG_Dump", "$CF_SettingName_DbgDump", "")
	AddEmptyOption()

	AddHeaderOption("$Cleaning")
	AddTextOptionST("CLN_ClearEvents", "$CF_SettingName_ClnClearEvents", "")
	AddTextOptionST("CLN_ClearFormDB", "$CF_SettingName_ClnClearFormDB", "")
	AddTextOptionST("CLN_ClearCreatures", "$CF_SettingName_ClnClearCreatures", "")
	if API.IsMuckingAboutAllowed()
		AddTextOptionST("CLN_Reregister", "$CF_SettingName_ClnReregister", "")
	else
		AddTextOptionST("CLN_Reregister", "$CF_SettingName_ClnReregister", "", OPTION_FLAG_DISABLED)
	endIf
	if API.IsMuckingAboutAllowed()
		AddTextOptionST("CLN_Uninstall", "$CF_SettingName_ClnUninstall", "")
	else
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
		ModEvent.Send(ModEvent.Create("CFInternal_ArousedSettingChanged"))
	endEvent
	event OnDefaultST()
		GenAroused = true
		SetToggleOptionValueST(GenAroused)
		ModEvent.Send(ModEvent.Create("CFInternal_ArousedSettingChanged"))
	endEvent
	event OnHighlightST()
		SetInfoText("$CF_SettingInfo_GenAroused")
	endEvent
endState

; General setting: Arousal threshold (slider)
state GEN_ArousalThreshold
	event OnSliderOpenST()
		SetSliderDialogStartValue(GenArousalThreshold)
		SetSliderDialogDefaultValue(50)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	endEvent
	event OnSliderAcceptST(float value)
		GenArousalThreshold = value as int
		SetSliderOptionValueST(GenArousalThreshold)
		ModEvent.Send(ModEvent.Create("CFInternal_ArousedSettingChanged"))
	endEvent
	event OnDefaultST()
		GenArousalThreshold = 50
		SetSliderOptionValueST(GenArousalThreshold)
		ModEvent.Send(ModEvent.Create("CFInternal_ArousedSettingChanged"))
	endEvent
	event OnHighlightST()
		SetInfoText("$CF_SettingInfo_GenArousalThreshold")
	endEvent
endState

; Gender setting: Default gender (menu)
state GND_Default
	event OnMenuOpenST()
		SetMenuDialogStartIndex(GndDefault)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(genders)
	endEvent
	event OnMenuAcceptST(int index)
		GndDefault = index
		SetMenuOptionValueST(genders[GndDefault])
	endEvent
	event OnDefaultST()
		GndDefault = 0
		SetMenuOptionValueST(genders[GndDefault])
	endEvent
	event OnHighlightST()
		SetInfoText("$CF_SettingInfo_GndDefault")
	endEvent
endState

; Gender setting: Male fallback (toggle)
state GND_MaleFallback
	event OnSelectST()
		GndMaleFallback = !GndMaleFallback
		SetToggleOptionValueST(GndMaleFallback)
	endEvent
	event OnDefaultST()
		GndMaleFallback = true
		SetToggleOptionValueST(GndMaleFallback)
	endEvent
	event OnHighlightST()
		SetInfoText("$CF_SettingInfo_GndMaleFallback")
	endEvent
endState

; Gender setting: Use SexLab gender (toggle)
state GND_UseSexLab
	event OnSelectST()
		GndUseSexLab = !GndUseSexLab
		SetToggleOptionValueST(GndUseSexLab)
		ForcePageReset()
	endEvent
	event OnDefaultST()
		GndUseSexLab = true
		SetToggleOptionValueST(GndUseSexLab)
		ForcePageReset()
	endEvent
	event OnHighlightST()
		SetInfoText("$CF_SettingInfo_GndUseSexLab")
	endEvent
endState

; Gender setting: Ignore SexLab gender for transformations (toggle)
state GND_SexLabExcludeTransformations
	event OnSelectST()
		GndSexLabExcludeTransformations = !GndSexLabExcludeTransformations
		SetToggleOptionValueST(GndSexLabExcludeTransformations)
	endEvent
	event OnDefaultST()
		GndSexLabExcludeTransformations = true
		SetToggleOptionValueST(GndSexLabExcludeTransformations)
	endEvent
	event OnHighlightST()
		SetInfoText("$CF_SettingInfo_GndSexLabExcludeTransformations")
	endEvent
endState

; Gender setting: Reset genders (text)
state GND_Reset
	event OnSelectST()
		if ShowMessage("$CF_Message_ConfirmResetGenders", true, "$Yes", "$No")
			API.ClearOverrideGenders(ShowMessage("$CF_Message_ResetGendersType", true, "$Unloaded", "$All"))
		endIf
	endEvent
	event OnHighlightST()
		SetInfoText("$CF_SettingInfo_GndReset")
	endEvent
endState

; Debug setting: File logging (toggle)
state DBG_OutputLog
	event OnSelectST()
		DbgOutputLog = !DbgOutputLog
		SetToggleOptionValueST(DbgOutputLog)
	endEvent
	event OnDefaultST()
		DbgOutputLog = true
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
		DbgOutputConsole = true
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
			ModEvent.Send(ModEvent.Create("CFInternal_ClearCreatures"))
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
				ModEvent.Send(ModEvent.Create("CFInternal_ClearCreatures"))
				ModEvent.Send(ModEvent.Create("CFInternal_Uninstall"))
				API.UnregisterAllMods()
				API.ClearOverrideGenders()
				API.ClearFormDB()
				ForcePageReset()
			endIf
		else
			CFDebug.Log("[Config] Not uninstalling; no mucking about!")
		endIf
	endEvent
	event OnHighlightST()
		SetInfoText("$CF_SettingInfo_ClnUninstall")
	endEvent
endState



;/----------------------------------------\
 | Page: Performance                      |
 \----------------------------------------/;

; Make the options for the performance page
function PagePerformance()
	SetCursorFillMode(TOP_TO_BOTTOM)
	AddHeaderOption("$Performance")
	AddSliderOptionST("PRF_CloakRate", "$CF_SettingName_PrfCloakRate", PrfCloakRate, "$CF_SettingFormat_Seconds")
	AddSliderOptionST("PRF_CloakDuration", "$CF_SettingName_PrfCloakDuration", PrfCloakDuration, "$CF_SettingFormat_SecondsDecimal")
	AddSliderOptionST("PRF_CloakRange", "$CF_SettingName_PrfCloakRange", PrfCloakRange / 192.0, "$CF_SettingFormat_CellsDecimal")
	AddSliderOptionST("PRF_CloakCooldown", "$CF_SettingName_PrfCloakCooldown", PrfCloakCooldown, "$CF_SettingFormat_Seconds")
	if API.IsArousedEnabled()
		AddSliderOptionST("PRF_ArousalPollRate", "$CF_SettingName_PrfArousalPollRate", PrfArousalPollRate, "$CF_SettingFormat_Seconds")
	else
		AddSliderOption("$CF_SettingName_PrfArousalPollRate", PrfArousalPollRate, "$CF_SettingFormat_Seconds", OPTION_FLAG_DISABLED)
	endIf
	AddSliderOptionST("PRF_FormDBClearRate", "$CF_SettingName_PrfFormDBClearRate", PrfFormDBClearRate, "$CF_SettingFormat_Minutes")
	AddSliderOptionST("PRF_GenderClearRate", "$CF_SettingName_PrfGenderClearRate", PrfGenderClearRate, "$CF_SettingFormat_Minutes")
endFunction

; Performance setting: Cloak rate (slider)
state PRF_CloakRate
	event OnSliderOpenST()
		SetSliderDialogStartValue(PrfCloakRate)
		SetSliderDialogDefaultValue(5)
		SetSliderDialogRange(0, 60)
		SetSliderDialogInterval(1)
	endEvent
	event OnSliderAcceptST(float value)
		PrfCloakRate = value as int
		SetSliderOptionValueST(PrfCloakRate, "$CF_SettingFormat_Seconds")
		ModEvent.Send(ModEvent.Create("CFInternal_CloakSettingChanged"))
	endEvent
	event OnDefaultST()
		PrfCloakRate = 5
		SetSliderOptionValueST(PrfCloakRate, "$CF_SettingFormat_Seconds")
	endEvent
	event OnHighlightST()
		SetInfoText("$CF_SettingInfo_PrfCloakRate")
	endEvent
endState

; Performance setting: Cloak duration (slider)
state PRF_CloakDuration
	event OnSliderOpenST()
		SetSliderDialogStartValue(PrfCloakDuration)
		SetSliderDialogDefaultValue(1)
		SetSliderDialogRange(0.25, 5)
		SetSliderDialogInterval(0.25)
	endEvent
	event OnSliderAcceptST(float value)
		PrfCloakDuration = value as int
		SetSliderOptionValueST(PrfCloakDuration, "$CF_SettingFormat_SecondsDecimal")
	endEvent
	event OnDefaultST()
		PrfCloakDuration = 1
		SetSliderOptionValueST(PrfCloakDuration, "$CF_SettingFormat_SecondsDecimal")
	endEvent
	event OnHighlightST()
		SetInfoText("$CF_SettingInfo_PrfCloakDuration")
	endEvent
endState

; Performance setting: Cloak range (slider)
state PRF_CloakRange
	event OnSliderOpenST()
		SetSliderDialogStartValue(PrfCloakRange / 192.0)
		SetSliderDialogDefaultValue(1.5)
		SetSliderDialogRange(0.25, 3)
		SetSliderDialogInterval(0.25)
	endEvent
	event OnSliderAcceptST(float value)
		PrfCloakRange = (value * 192) as int
		CreatureFrameworkUtil.GetCloakSpell().SetNthEffectMagnitude(0, PrfCloakRange)
		SetSliderOptionValueST(value, "$CF_SettingFormat_CellsDecimal")
	endEvent
	event OnDefaultST()
		PrfCloakRange = 288
		CreatureFrameworkUtil.GetCloakSpell().SetNthEffectMagnitude(0, PrfCloakRange)
		SetSliderOptionValueST(1.5, "$CF_SettingFormat_CellsDecimal")
	endEvent
	event OnHighlightST()
		SetInfoText("$CF_SettingInfo_PrfCloakRange")
	endEvent
endState

; Performance setting: Cloak cooldown (slider)
state PRF_CloakCooldown
	event OnSliderOpenST()
		SetSliderDialogStartValue(PrfCloakCooldown)
		SetSliderDialogDefaultValue(60)
		SetSliderDialogRange(5, 600)
		SetSliderDialogInterval(5)
	endEvent
	event OnSliderAcceptST(float value)
		PrfCloakCooldown = value as int
		CreatureFrameworkUtil.GetCreatureApplySpell().SetNthEffectDuration(0, PrfCloakCooldown)
		SetSliderOptionValueST(PrfCloakCooldown, "$CF_SettingFormat_Seconds")
	endEvent
	event OnDefaultST()
		PrfCloakCooldown = 60
		CreatureFrameworkUtil.GetCreatureApplySpell().SetNthEffectDuration(0, PrfCloakCooldown)
		SetSliderOptionValueST(PrfCloakCooldown, "$CF_SettingFormat_Seconds")
	endEvent
	event OnHighlightST()
		SetInfoText("$CF_SettingInfo_PrfCloakCooldown")
	endEvent
endState

; Performance setting: Arousal poll rate (slider)
state PRF_ArousalPollRate
	event OnSliderOpenST()
		SetSliderDialogStartValue(PrfArousalPollRate)
		SetSliderDialogDefaultValue(10)
		SetSliderDialogRange(0, 60)
		SetSliderDialogInterval(1)
	endEvent
	event OnSliderAcceptST(float value)
		PrfArousalPollRate = value as int
		SetSliderOptionValueST(PrfArousalPollRate, "$CF_SettingFormat_Seconds")
	endEvent
	event OnDefaultST()
		PrfArousalPollRate = 10
		SetSliderOptionValueST(PrfArousalPollRate, "$CF_SettingFormat_Seconds")
	endEvent
	event OnHighlightST()
		SetInfoText("$CF_SettingInfo_PrfArousalPollRate")
	endEvent
endState

; Performance setting: Form DB clear rate (slider)
state PRF_FormDBClearRate
	event OnSliderOpenST()
		SetSliderDialogStartValue(PrfFormDBClearRate)
		SetSliderDialogDefaultValue(15)
		SetSliderDialogRange(0, 120)
		SetSliderDialogInterval(1)
	endEvent
	event OnSliderAcceptST(float value)
		PrfFormDBClearRate = value as int
		API.ResetFormDBClearTimer()
		SetSliderOptionValueST(PrfFormDBClearRate, "$CF_SettingFormat_Minutes")
	endEvent
	event OnDefaultST()
		PrfFormDBClearRate = 15
		API.ResetFormDBClearTimer()
		SetSliderOptionValueST(PrfFormDBClearRate, "$CF_SettingFormat_Minutes")
	endEvent
	event OnHighlightST()
		SetInfoText("$CF_SettingInfo_PrfFormDBClearRate")
	endEvent
endState

; Performance setting: Gender clear rate (slider)
state PRF_GenderClearRate
	event OnSliderOpenST()
		SetSliderDialogStartValue(PrfGenderClearRate)
		SetSliderDialogDefaultValue(15)
		SetSliderDialogRange(0, 120)
		SetSliderDialogInterval(1)
	endEvent
	event OnSliderAcceptST(float value)
		PrfGenderClearRate = value as int
		API.ResetGenderClearTimer()
		SetSliderOptionValueST(PrfGenderClearRate, "$CF_SettingFormat_Minutes")
	endEvent
	event OnDefaultST()
		PrfGenderClearRate = 15
		API.ResetGenderClearTimer()
		SetSliderOptionValueST(PrfGenderClearRate, "$CF_SettingFormat_Minutes")
	endEvent
	event OnHighlightST()
		SetInfoText("$CF_SettingInfo_PrfGenderClearRate")
	endEvent
endState



;/----------------------------------------\
 | Page: Creatures                        |
 \----------------------------------------/;

; Make the options for the creatures page
function PageCreatures()
	SetCursorFillMode(LEFT_TO_RIGHT)

	; Get the list of races, and figure out how many pages to split them into
	if !JValue.IsExists(jCreatureRacesArr)
		jCreatureRacesArr = API.GetRegisteredRaces()
		JValue.Retain(jCreatureRacesArr)
		creaturesRaceCount = JArray.Count(jCreatureRacesArr)
		creaturePages = Math.Ceiling(creaturesRaceCount / 5.0)
		if creaturePages < 1
			creaturePages = 1
		endIf
		if creaturePage > creaturePages
			creaturePage = 1
		endIf
		CFDebug.Log("[Config] Creatures page opened; Race count: " + creaturesRaceCount + "; pages: " + creaturePages + "; current page: " + creaturePage)
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
	int startIndex = (creaturePage - 1) * 5
	int endIndex = startIndex + 5
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
			if JArray.FindForm(jSkinsArr, API.FakeSkin) != -1
				; Get the active mod name
				string theModName = API.GetActiveModName(raceForm, API.FakeSkin)
				if theModName == ""
					theModName = "$Disabled"
				endIf

				; Add it to the options
				int jCreatureOptionMap = JMap.Object()
				JMap.SetInt(jCreatureOptionMap, "id", AddMenuOption("$All skins", theModName))
				JMap.SetForm(jCreatureOptionMap, "race", raceForm)
				JMap.SetForm(jCreatureOptionMap, "skin", API.FakeSkin)
				JArray.AddObj(jCreatureOptionsArr, jCreatureOptionMap)
			endIf

			; Add all other skins
			int s = 0
			while s < skinsSize
				Armor skinForm = JArray.GetForm(jSkinsArr, s) as Armor

				if skinForm != API.FakeSkin
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



;/----------------------------------------\
 | Page: Puppeteer                        |
 \----------------------------------------/;

; Make the options for the puppeteer page
function PagePuppeteer()
	Actor puppet = API.GetPuppet()
	if puppet
		string name = CreatureFrameworkUtil.GetActorName(puppet)
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
		string hasEffect = "$No"
		if puppet.HasMagicEffect(CreatureFrameworkUtil.GetCreatureEffect())
			hasEffect = "$Yes"
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
		string gender = API.GetGenderText(API.GetGender(puppet))
		string genderSource = API.GetGenderSourceText(API.GetGenderSource(puppet))

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
		AddTextOption("$Has effect", hasEffect, OPTION_FLAG_DISABLED)
		AddTextOptionST("PUP_TriggerUpdate", "$CF_SettingName_PupTriggerUpdate", "")

		SetCursorPosition(1)

		AddKeyMapOptionST("PUP_TargetKey", "$CF_SettingName_PupTargetKey", PupTargetKey)
		AddEmptyOption()

		AddHeaderOption("$Gender")
		AddTextOption("$Gender", gender, OPTION_FLAG_DISABLED)
		AddTextOption("$Gender source", genderSource, OPTION_FLAG_DISABLED)
		AddMenuOptionST("PUP_OverrideGender", "$CF_SettingName_PupOverrideGender", API.GetGenderText(API.GetOverrideGender(puppet)))
		AddEmptyOption()

		AddHeaderOption("$Arousal")
		AddTextOption("$Aroused", aroused, OPTION_FLAG_DISABLED)
		AddTextOption("$Arousal source", arousalSource, OPTION_FLAG_DISABLED)
		AddTextOption("$SexLab Aroused rating", arousalRating, OPTION_FLAG_DISABLED)
		AddMenuOptionST("PUP_OverrideArousal", "$CF_SettingName_PupOverrideArousal", API.GetOverrideArousalText(API.GetOverrideArousal(puppet)))
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
			ModEvent.Send(ModEvent.Create("CFInternal_PuppetTargetKeyChanged"))
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

; Puppeteer setting: Override gender (menu)
state PUP_OverrideGender
	event OnMenuOpenST()
		SetMenuDialogStartIndex(API.GetOverrideGender(API.GetPuppet()))
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(API.GetGenderTexts())
	endEvent
	event OnMenuAcceptST(int index)
		Actor puppet = API.GetPuppet()
		API.SetOverrideGender(puppet, index)
		SetMenuOptionValueST(API.GetGenderText(index))
		API.TriggerUpdateForActor(puppet)
		ForcePageReset()
	endEvent
	event OnDefaultST()
		Actor puppet = API.GetPuppet()
		API.SetOverrideGender(puppet, 0)
		SetMenuOptionValueST(API.GetGenderText(0))
		API.TriggerUpdateForActor(puppet)
		ForcePageReset()
	endEvent
	event OnHighlightST()
		SetInfoText("$CF_SettingInfo_PupOverrideGender")
	endEvent
endState

; Puppeteer setting: Override arousal (menu)
state PUP_OverrideArousal
	event OnMenuOpenST()
		SetMenuDialogStartIndex(API.GetOverrideArousal(API.GetPuppet()))
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(API.GetOverrideArousalTexts())
	endEvent
	event OnMenuAcceptST(int index)
		Actor puppet = API.GetPuppet()
		API.SetOverrideArousal(puppet, index)
		SetMenuOptionValueST(API.GetOverrideArousalText(index))
		API.TriggerUpdateForActor(puppet)
		ForcePageReset()
	endEvent
	event OnDefaultST()
		Actor puppet = API.GetPuppet()
		API.SetOverrideArousal(puppet, 0)
		SetMenuOptionValueST(API.GetOverrideArousalText(0))
		API.TriggerUpdateForActor(puppet)
		ForcePageReset()
	endEvent
	event OnHighlightST()
		SetInfoText("$CF_SettingInfo_PupOverrideArousal")
	endEvent
endState
