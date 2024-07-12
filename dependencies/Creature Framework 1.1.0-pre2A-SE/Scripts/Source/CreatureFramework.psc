Scriptname CreatureFramework extends Quest
{The framework script to interact with | Creature Framework}

; General properties
CFConfigMenu property Config auto hidden
Armor property FakeSkin auto
Keyword property ArmorNormalKeyword auto
Keyword property ArmorArousedKeyword auto
Keyword property CreatureKeyword auto
Race property ArgonianRace auto
Race property ArgonianVampireRace auto
Race property KhajiitRace auto
Race property KhajiitVampireRace auto
Race property WerewolfRace auto
Race property VampireLordRace auto hidden
SexLabFramework property SexLab auto hidden
slaUtilScr property SexLabAroused auto hidden
Faction property ArousedFaction auto hidden

; The currently installed version
int version = 0

; JContainers
int jMainMap = -1
int jModsMap = -1
int jRacesMap = -1
int jSkinsMap = -1
int jCreaturesMap = -1
int jEventsMap = -1
int jActiveActorsArr = -1
int jLoadedFiles = -1

; Various things
string[] types
int[] armorSlots
string[] genders
string[] genderSources
string[] arousalSources
string[] overrideArousals

; Whether or not the active actors are being restarted
bool restartingActiveActors = false

; Whether or not we're in the middle of parsing the JSON files
bool loadingJSON = false

; Counter for how many things are telling us to prevent mucking about
int muckingAboutPreventor = 0

; Timers
int formDBClearTimer = 0
int genderClearTimer = 0

; Puppet!
Actor puppet

; Initialise (needs to be run on each startup)
function Initialize()
	PreventMuckingAbout()
	CFDebug.Log("[Framework] Creature Framework " + GetVersionString() + " (" + GetVersion() +") is initialising")
	Config = CreatureFrameworkUtil.GetConfig()

	; Validate JContainers version
	if (JContainers.APIVersion() > 3 || JContainers.APIVersion() == 3 && JContainers.FeatureVersion() >= 2) && JContainers.IsInstalled()
		CFDebug.Log("[Framework] JContainers " + JContainers.APIVersion() + "." + JContainers.FeatureVersion() + " is installed")
	else
		CFDebug.Log("[Framework] Bad JContainers; IsInstalled=" + JContainers.IsInstalled() + " APIVersion=" + JContainers.APIVersion() + " FeatureVersion=" + JContainers.FeatureVersion())
		CFDebug.Log("[Framework] Aborting initialisation")
		Debug.MessageBox("Your installed JContainers version is incompatible with Creature Framework, or you don't have JContainers at all. Things will be very broken!")
		return
	endIf

	; Obtain the main container
	jMainMap = JDB.SolveObj(".CreatureFramework")
	if jMainMap == 0
		CFDebug.Log("[Framework] Main data map is missing; initialising")
		jMainMap = JMap.Object()
		JDB.SetObj("CreatureFramework", jMainMap)
	endIf

	; Initialise the containers
	jModsMap = InitializeContainer("mods", 0)
	jRacesMap = InitializeContainer("races", 1)
	jSkinsMap = InitializeContainer("skins", 1)
	jCreaturesMap = InitializeContainer("creatures", 1)
	jEventsMap = InitializeContainer("events", 0)
	jActiveActorsArr = InitializeContainer("activeActors", 2)
	jLoadedFiles = InitializeContainer("loadedFiles", 2)

	; Set registration types
	types = new string[3]
	types[0] = "events"
	types[1] = "armors"
	types[2] = "both"

	; Set armour slots
	armorSlots = new int[5]
	armorSlots[0] = 0x00000001 ; Head
	armorSlots[1] = 0x00000004 ; Body
	armorSlots[2] = 0x00000008 ; Hands
	armorSlots[3] = 0x00000080 ; Feet
	armorSlots[4] = 0x00000040 ; Ring (for vampire lords)

	; Set genders
	genders = new string[3]
	genders[0] = "$Unspecified"
	genders[1] = "$Male"
	genders[2] = "$Female"

	; Set gender sources
	genderSources = new string[4]
	genderSources[0] = "$None"
	genderSources[1] = "$Skyrim"
	genderSources[2] = "$SexLab"
	genderSources[3] = "$Override"

	; Set arousal sources
	arousalSources = new string[5]
	arousalSources[0] = "$None"
	arousalSources[1] = "$SexLab animation"
	arousalSources[2] = "$SexLab Aroused"
	arousalSources[3] = "$Override"
	arousalSources[4] = "$Override strip"

	; Set arousal overrides
	overrideArousals = new string[4]
	overrideArousals[0] = "$Unspecified"
	overrideArousals[1] = "$Unaroused"
	overrideArousals[2] = "$Aroused"
	overrideArousals[3] = "$Stripped aroused"

	; Get soft dependencies
	VampireLordRace = Game.GetFormFromFile(0x283A, "Dawnguard.esm") as Race
	SexLab = Game.GetFormFromFile(0xD62, "SexLab.esm") as SexLabFramework
	if SexLab != none
		CFDebug.Log("[Framework] SexLab " + SexLabUtil.GetStringVer() + " is installed")

		SexLabAroused = Game.GetFormFromFile(0x4290F, "SexLabAroused.esm") as slaUtilScr
		if SexLabAroused != none
			if SexLabAroused.GetVersion() > 0
				CFDebug.Log("[Framework] SexLab Aroused " + SexLabAroused.GetVersion() + " is installed")
			else
				CFDebug.Log("[Framework] SexLab Aroused is installed, but the version cannot be determined due to its late initialisation")
			endIf
			ArousedFaction = SexLabAroused.slaArousal
		else
			ArousedFaction = none
		endIf
	else
		SexLabAroused = none
		ArousedFaction = none
	endIf

	; Deal with Form DB keys on 1.1.0-pre1 and below
	if version <= 10020 && version != 0
		; Transfer old Form DB to new key
		if JDB.SolveObj(".CFForm") == 0
			CFDebug.Log("[Framework] Transferring .CreatureFrameworkForm to .CFForm in JDB")
			JDB.SetObj("CFForm", JDB.SolveObj(".CreatureFrameworkForm"))
		endIf

		; Wipe out old ones
		if JDB.SolveObj(".CreatureFrameworkFormLog") != 0
			CFDebug.Log("[Framework] Wiping out old JDB keys")
			JDB.SetObj("CreatureFrameworkForm", 0)
			JDB.SetObj("CreatureFrameworkFormLog", 0)
		endIf
	endIf

	; Display version notification
	if version == 0
		CFDebug.Log("[Framework] Installed")
		Debug.Notification("$CF_InstallNotification")
	elseIf version < GetVersion()
		CFDebug.Log("[Framework] Upgraded from version " + version)
		Debug.Notification("$CF_UpdateNotification")
	elseIf version > GetVersion()
		CFDebug.Log("[Framework] Downgraded from version " + version)
		CFDebug.Log("[Framework] Aborting initialisation")
		Debug.MessageBox("Creature Framework has been downgraded to " + GetVersionString() + ". Things will be broken!")
		return
	endIf
	version = GetVersion()

	Utility.Wait(3)
	SendRegisterEvent()
	Utility.Wait(2)
	LoadJSONRegistrations()
	ClearInvalidActiveActors()
	RestartActiveActors()
	ClearLogFormDB()
	AllowMuckingAbout()
	RegisterForModEvent("AnimationStart", "OnSexLabAnimationStart")
	RegisterForModEvent("AnimationEnd", "OnSexLabAnimationEnd")
	RegisterForSingleUpdate(60)
	CFDebug.Log("[Framework] Creature Framework is done initialising")
endFunction

; Initialize a container if necessary; type 0 = JMap, 1 = JFormMap, 2 = JArray
int function InitializeContainer(string containerKey, int containerType)
	if JMap.ValueType(jMainMap, containerKey) == 5
		return JMap.GetObj(jMainMap, containerKey)
	else
		CFDebug.Log("[Framework] Data map is missing \"" + containerKey + "\"; initialising")
		int obj
		if containerType == 0
			obj = JMap.Object()
		elseIf containerType == 1
			obj = JFormMap.Object()
		elseIf containerType == 2
			obj = JArray.Object()
		endIf
		JMap.SetObj(jMainMap, containerKey, obj)
		return obj
	endIf
endFunction

; An update event has triggered
event OnUpdate()
	; Tick the timers
	if Config.PrfFormDBClearRate > 0
		formDBClearTimer += 1
	endIf
	if Config.PrfGenderClearRate > 0
		genderClearTimer += 1
	endIf

	; Do stuff if it's time
	if formDBClearTimer >= Config.PrfFormDBClearRate
		formDBClearTimer = 0
		ClearLogFormDB()
		CFDebug.Log("[Framework] Form DB clear timer reset for " + Config.PrfFormDBClearRate + " minutes from now")
	endIf
	if genderClearTimer >= Config.PrfGenderClearRate
		genderClearTimer = 0
		ClearOverrideGenders()
		CFDebug.Log("[Framework] Gender clear timer reset for " + Config.PrfGenderClearRate + " minutes from now")
	endIf

	RegisterForSingleUpdate(60)
endEvent



;/----------------------------------------\
 | Mod-related methods                    |
 \----------------------------------------/;

; Register a mod to the framework
function RegisterMod(string modId, string modName)
	; Create the map for the mod and add it
	int modMap = JMap.Object()
	JMap.SetStr(modMap, "name", modName)
	JMap.SetObj(modMap, "races", JArray.Object())
	JMap.SetObj(modMap, "skins", JArray.Object())
	JMap.SetObj(jModsMap, modId, modMap)

	CFDebug.Log("[Framework] Registered mod with ID \"" + modId + "\" and name \"" + modName + "\"")
endFunction

; Unregister a mod from the framework
function UnregisterMod(string modId)
	UnregisterAllCreaturesFromMod(modId)
	JMap.RemoveKey(jModsMap, modId)
	CFDebug.Log("[Framework] Unregistered mod with ID \"" + modId + "\"")
endFunction

; Unregister all mods from the framework
function UnregisterAllMods()
	JMap.Clear(jModsMap)
	JFormMap.Clear(jCreaturesMap)
	JFormMap.Clear(jRacesMap)
	JFormMap.Clear(jSkinsMap)
	CFDebug.Log("[Framework] Unregistered all mods")
endFunction

; Unregister all mods and send the register event
function ReregisterAllMods()
	if IsMuckingAboutAllowed()
		PreventMuckingAbout()
		CFDebug.Log("[Framework] Reregistering all mods")
		UnregisterAllMods()
		SendRegisterEvent()
		ResetLoadedFiles()
		LoadJSONRegistrations()
		AllowMuckingAbout()
	else
		CFDebug.Log("[Framework] Not reregistering all mods; no mucking about!")
	endIf
endFunction

; Get a JArray of all of the registered mod IDs
int function GetRegisteredMods()
	return JMap.AllKeys(jModsMap)
endFunction

; Test to see if a mod is registered
bool function IsModRegistered(string modId)
	return JMap.HasKey(jModsMap, modId)
endFunction

; Get a mod's name
string function GetModName(string modId)
	return JMap.GetStr(JMap.GetObj(jModsMap, modId), "name")
endFunction

; Send the register event
function SendRegisterEvent()
	int handle = ModEvent.Create("CFRegister")
	if handle
		CFDebug.Log("[Framework] Sending register event")
		ModEvent.PushForm(handle, self)
		ModEvent.Send(handle)
	else
		CFDebug.Log("[Framework] Unable to send register event; invalid handle")
	endIf
endFunction



;/----------------------------------------\
 | Creature-related methods               |
 \----------------------------------------/;

; Register a creature to a mod
function RegisterCreatureToMod(string modId, Race raceForm, Armor skinForm, string raceName, string skinName, int type, Armor normalArmor = none, Armor arousedArmor = none, bool stripArmor = false, bool stripWeapons = true, Form[] stripFormBlacklist = none, int[] stripSlotBlacklist = none, int[] restrictedSlots = none)
	Armor realSkin = GetSkinOrFake(skinForm)

	if IsModRegistered(modId)
		if type >= 0 && type < types.length
			; Add the race/skin to all the relevant maps
			if !IsRaceRegistered(raceForm)
				if raceName == ""
					raceName = raceForm.GetName()
				endIf

				int jRaceMap = JMap.Object()
				JMap.SetStr(jRaceMap, "name", raceName)
				JMap.SetObj(jRaceMap, "mods", JArray.Object())
				JMap.SetObj(jRaceMap, "skins", JArray.Object())
				JFormMap.SetObj(jRacesMap, raceForm, jRaceMap)
				JFormMap.SetObj(jCreaturesMap, raceForm, JFormMap.Object())
				CFDebug.Log("[Framework] Added race " + CreatureFrameworkUtil.GetDetailedFormName(raceForm))
			endIf
			if !IsCreatureRegistered(raceForm, realSkin, false)
				if realSkin == FakeSkin
					skinName = ""
				endIf

				int jCreatureMap = JMap.Object()
				JMap.SetStr(jCreatureMap, "activeMod", modId)
				JMap.SetObj(jCreatureMap, "mods", JMap.Object())
				JFormMap.SetObj(JFormMap.GetObj(jCreaturesMap, raceForm), realSkin, jCreatureMap)

				JArray.AddForm(JMap.GetObj(JFormMap.GetObj(jRacesMap, raceForm), "skins"), realSkin)

				int jSkinMap = JMap.Object()
				JMap.SetStr(jSkinMap, "name", skinName)
				JMap.SetObj(jSkinMap, "mods", JArray.Object())
				JFormMap.SetObj(jSkinsMap, realSkin, jSkinMap)

				CFDebug.Log("[Framework] Added skin " + CreatureFrameworkUtil.GetDetailedFormName(realSkin) + " to race " + CreatureFrameworkUtil.GetDetailedFormName(raceForm))
			endIf

			; Add the race and skin to the mod and the mod to the race and skin
			if !IsRaceRegisteredToMod(modId, raceForm)
				JArray.AddForm(JMap.GetObj(JMap.GetObj(jModsMap, modId), "races"), raceForm)
				int jRaceModsMap = JMap.GetObj(JFormMap.GetObj(jRacesMap, raceForm), "mods")
				if JArray.FindStr(jRaceModsMap, modId) == -1
					JArray.AddStr(jRaceModsMap, modId)
				endIf
			endIf
			if !IsSkinRegisteredToMod(modId, realSkin)
				JArray.AddForm(JMap.GetObj(JMap.GetObj(jModsMap, modId), "skins"), realSkin)
				JArray.AddStr(JMap.GetObj(JFormMap.GetObj(jSkinsMap, realSkin), "mods"), modId)
				int jSkinModsMap = JMap.GetObj(JFormMap.GetObj(jSkinsMap, realSkin), "mods")
				if JArray.FindStr(jSkinModsMap, modId) == -1
					JArray.AddStr(jSkinModsMap, modId)
				endIf
			endIf

			; Create and add the mod map for the creature
			int jCreatureModMap = JMap.Object()
			JMap.SetInt(jCreatureModMap, "type", type)
			if type == 1 || type == 2
				JMap.SetForm(jCreatureModMap, "normalArmor", normalArmor)
				JMap.SetForm(jCreatureModMap, "arousedArmor", arousedArmor)
			endIf
			JMap.SetInt(jCreatureModMap, "stripArmor", stripArmor as int)
			JMap.SetInt(jCreatureModMap, "stripWeapons", stripWeapons as int)
			JMap.SetObj(jCreatureModMap, "stripFormBlacklist", CreatureFrameworkUtil.JArrayObjectFromForms(stripFormBlacklist))
			JMap.SetObj(jCreatureModMap, "stripSlotBlacklist", JArray.ObjectWithInts(stripSlotBlacklist))
			JMap.SetObj(jCreatureModMap, "restrictedSlots", JArray.ObjectWithInts(restrictedSlots))
			JMap.SetObj(JMap.GetObj(JFormMap.GetObj(JFormMap.GetObj(jCreaturesMap, raceForm), realSkin), "mods"), modId, jCreatureModMap)

			CFDebug.Log("[Framework] Registered " + CreatureFrameworkUtil.GetDetailedFormName(raceForm) + CreatureFrameworkUtil.GetDetailedFormName(realSkin) + " " + types[type] + " to mod \"" + modId + "\"")
		else
			CFDebug.Log("[Framework] Failed to register " + CreatureFrameworkUtil.GetDetailedFormName(raceForm) + CreatureFrameworkUtil.GetDetailedFormName(realSkin) + " type " + type + " to mod \"" + modId + "\"; invalid type")
		endIf
	else
		CFDebug.Log("[Framework] Failed to register " + CreatureFrameworkUtil.GetDetailedFormName(raceForm) + CreatureFrameworkUtil.GetDetailedFormName(realSkin) + " type " + type + " to mod \"" + modId + "\"; mod isn't registered")
	endIf
endFunction

; Register a creature to a mod using the events type
string function RegisterCreatureEventsToMod(string modId, Race raceForm, Armor skinForm, string raceName, string skinName, bool stripArmor = true, bool stripWeapons = true, Form[] stripFormBlacklist = none, int[] stripSlotBlacklist = none, int[] restrictedSlots = none)
	RegisterCreatureToMod(modId, raceForm, skinForm, raceName, skinName, 0, none, none, stripArmor, stripWeapons, stripFormBlacklist, stripSlotBlacklist, restrictedSlots)
	return "CFArousalChange_" + modId
endFunction

; Register a creature to a mod using the swap type
function RegisterCreatureArmorSwapToMod(string modId, Race raceForm, Armor skinForm, string raceName, string skinName, Armor normalArmor, Armor arousedArmor = none, bool stripArmor = true, bool stripWeapons = true, Form[] stripFormBlacklist = none, int[] stripSlotBlacklist = none, int[] restrictedSlots = none)
	RegisterCreatureToMod(modId, raceForm, skinForm, raceName, skinName, 1, normalArmor, arousedArmor, stripArmor, stripWeapons, stripFormBlacklist, stripSlotBlacklist, restrictedSlots)
endFunction

; Register a creature to a mod using both a swap and event
string function RegisterCreatureArmorSwapAndEventsToMod(string modId, Race raceForm, Armor skinForm, string raceName, string skinName, Armor normalArmor, Armor arousedArmor = none, bool stripArmor = true, bool stripWeapons = true, Form[] stripFormBlacklist = none, int[] stripSlotBlacklist = none, int[] restrictedSlots = none)
	RegisterCreatureToMod(modId, raceForm, skinForm, raceName, skinName, 2, normalArmor, arousedArmor, stripArmor, stripWeapons, stripFormBlacklist, stripSlotBlacklist, restrictedSlots)
	return "CFArousalChange_" + modId
endFunction

; Register a female variant to a creature
function AddFemaleVariantToCreature(string modId, Race raceForm, Armor skinForm, Armor normalArmor = none, Armor arousedArmor = none)
	Armor realSkin = GetSkinOrFake(skinForm)

	if IsModRegistered(modId)
		if IsCreatureRegisteredToMod(modId, raceForm, realSkin)
			int jCreatureModMap = JMap.GetObj(JMap.GetObj(JFormMap.GetObj(JFormMap.GetObj(jCreaturesMap, raceForm), GetSkinOrFake(skinForm)), "mods"), modId)
			JMap.SetForm(jCreatureModMap, "normalArmorFemale", normalArmor)
			JMap.SetForm(jCreatureModMap, "arousedArmorFemale", arousedArmor)
			CFDebug.Log("[Framework] Added female variant to mod \"" + modId + "\"'s creature " + CreatureFrameworkUtil.GetDetailedFormName(raceForm) + CreatureFrameworkUtil.GetDetailedFormName(realSkin))
		else
			CFDebug.Log("[Framework] Failed to add female variant to mod \"" + modId + "\"'s creature " + CreatureFrameworkUtil.GetDetailedFormName(raceForm) + CreatureFrameworkUtil.GetDetailedFormName(realSkin) + "; creature isn't registered")
		endIf
	else
		CFDebug.Log("[Framework] Failed to add female variant to mod \"" + modId + "\"'s creature " + CreatureFrameworkUtil.GetDetailedFormName(raceForm) + CreatureFrameworkUtil.GetDetailedFormName(realSkin) + "; mod isn't registered")
	endIf
endFunction

; Unregister all creatures from a mod
function UnregisterAllCreaturesFromMod(string modId)
	; Clear the active mod of creatures that have it set to this one
	ClearActiveForMod(modId)

	; Clear the mod's races and skins
	JArray.Clear(JMap.GetObj(JMap.GetObj(jModsMap, modId), "races"))
	JArray.Clear(JMap.GetObj(JMap.GetObj(jModsMap, modId), "skins"))

	; Remove the mod from all creatures
	Form cr = JFormMap.NextKey(jCreaturesMap)
	while cr
		int jCreatureRaceMap = JFormMap.GetObj(jCreaturesMap, cr)
		Form cs = JFormMap.NextKey(jCreatureRaceMap)
		while cs
			int jCreatureMap = JFormMap.GetObj(jCreatureRaceMap, cs)
			JMap.RemoveKey(JMap.GetObj(jCreatureMap, "mods"), modId)
			cs = JFormMap.NextKey(jCreatureRaceMap, cs)
		endWhile
		cr = JFormMap.NextKey(jCreaturesMap, cr)
	endWhile

	; Remove the mod from all races
	Form r = JFormMap.NextKey(jRacesMap)
	while r
		int jRaceMap = JFormMap.GetObj(jRacesMap, r)
		int jRaceModsArr = JMap.GetObj(jRaceMap, "mods")
		JArray.EraseIndex(jRaceModsArr, JArray.FindStr(jRaceModsArr, modId))
		r = JFormMap.NextKey(jRacesMap, r)
	endWhile

	; Remove the mod from all skins
	Form s = JFormMap.NextKey(jSkinsMap)
	while s
		int jSkinMap = JFormMap.GetObj(jSkinsMap, s)
		int jSkinModsArr = JMap.GetObj(jSkinMap, "mods")
		JArray.EraseIndex(jSkinModsArr, JArray.FindStr(jSkinModsArr, modId))
		s = JFormMap.NextKey(jSkinsMap, s)
	endWhile

	CFDebug.Log("[Framework] Unregistered all creatures from mod ID \"" + modId + "\"")
endFunction

; Get the JFormMap of all registered creatures
int function GetRegisteredCreatures()
	return jCreaturesMap
endFunction

; Test to see if a creature is registered (will still return true if the FakeSkin is registered, but the specified skin isn't)
bool function IsCreatureRegistered(Race raceForm, Armor skinForm, bool checkFake = true)
	return JFormMap.HasKey(jCreaturesMap, raceForm) && (JFormMap.HasKey(JFormMap.GetObj(jCreaturesMap, raceForm), GetSkinOrFake(skinForm)) || (checkFake && JFormMap.HasKey(JFormMap.GetObj(jCreaturesMap, raceForm), FakeSkin)))
endFunction

; Test to see if an exact creature is registered (will not return true if the FakeSkin is registered, but the specified skin isn't)
bool function IsExactCreatureRegistered(Race raceForm, Armor skinForm)
	return JFormMap.HasKey(jCreaturesMap, raceForm) && JFormMap.HasKey(JFormMap.GetObj(jCreaturesMap, raceForm), GetSkinOrFake(skinForm))
endFunction

; Get a JFormMap with Race keys and JFormMap values with Armor keys and JMap values of creatures registered to a mod
int function GetCreaturesRegisteredToMod(string modId)
	return JMap.GetObj(JMap.GetObj(jModsMap, modId), "creatures")
endFunction

; Test to see if a creature is registered to a mod
bool function IsCreatureRegisteredToMod(string modId, Race raceForm, Armor skinForm)
	return JFormMap.HasKey(jCreaturesMap, raceForm) && JFormMap.HasKey(JFormMap.GetObj(jCreaturesMap, raceForm), GetSkinOrFake(skinForm)) && JMap.HasKey(JMap.GetObj(JFormMap.GetObj(JFormMap.GetObj(jCreaturesMap, raceForm), GetSkinOrFake(skinForm)), "mods"), modId)
endFunction

; Get a JArray of all of the races that are registered
int function GetRegisteredRaces()
	return JFormMap.AllKeys(jCreaturesMap)
endFunction

; Get the number of race forms that are registered
int function GetRegisteredRaceCount()
	return JArray.Count(GetRegisteredRaces())
endFunction

; Test to see if a race is registered
bool function IsRaceRegistered(Race raceForm)
	return JFormMap.HasKey(jRacesMap, raceForm)
endFunction

; Get a JArray of all of the races registered to a mod
int function GetRacesRegisteredToMod(string modId)
	return JMap.GetObj(JMap.GetObj(jModsMap, modId), "races")
endFunction

; Get the number of races registered to a mod
int function GetRaceCountRegisteredToMod(string modId)
	return JArray.Count(GetRacesRegisteredToMod(modId))
endFunction

; Test to see if a race is registered to a mod
bool function IsRaceRegisteredToMod(string modId, Race raceForm)
	return JArray.FindForm(JMap.GetObj(JMap.GetObj(jModsMap, modId), "races"), raceForm) != -1
endFunction

; Get a JArray of all of the skins that are registered
int function GetRegisteredSkins()
	return JFormMap.AllKeys(jSkinsMap)
endFunction

; Get the number of skins that are registered
int function GetRegisteredSkinCount()
	return JArray.Count(GetRegisteredSkins())
endFunction

; Test to see if a skin is registered
bool function IsSkinRegistered(Armor skinForm)
	return JFormMap.HasKey(jSkinsMap, GetSkinOrFake(skinForm))
endFunction

; Get a JArray of all of the skins registered to a mod
int function GetSkinsRegisteredToMod(string modId)
	return JMap.GetObj(JMap.GetObj(jModsMap, modId), "skins")
endFunction

; Get the number of skins registered to a mod
int function GetSkinCountRegisteredToMod(string modId)
	return JArray.Count(GetSkinsRegisteredToMod(modId))
endFunction

; Test to see if a skin is registered to a mod
bool function IsSkinRegisteredToMod(string modId, Armor skinForm)
	return JArray.FindForm(JMap.GetObj(JMap.GetObj(jModsMap, modId), "skins"), GetSkinOrFake(skinForm)) != -1
endFunction

; Get a JArray of all of the skins that are registered to a race
int function GetSkinsRegisteredToRace(Race raceForm)
	return JMap.GetObj(JFormMap.GetObj(jRacesMap, raceForm), "skins")
endFunction

; Get the number of skins registered to a race
int function GetSkinCountRegisteredToRace(Race raceForm)
	return JArray.Count(GetSkinsRegisteredToRace(raceForm))
endFunction

; Get a JArray of all of the mod IDs that are registered for a race
int function GetModsRegisteredWithRace(Race raceForm)
	return JMap.GetObj(JFormMap.GetObj(jRacesMap, raceForm), "mods")
endFunction

; Get the number of mods registered for a race
int function GetModCountRegisteredWithRace(Race raceForm)
	return JArray.Count(GetModsRegisteredWithRace(raceForm))
endFunction

; Get a JArray of all of the mod IDs that are registered for a skin
int function GetModsRegisteredWithSkin(Armor skinForm)
	return JMap.GetObj(JFormMap.GetObj(jSkinsMap, GetSkinOrFake(skinForm)), "mods")
endFunction

; Get the number of mods registered for a skin
int function GetModCountRegisteredWithSkin(Armor skinForm)
	return JArray.Count(GetModsRegisteredWithSkin(skinForm))
endFunction

; Get a JArray of all of the mod IDs that are registered for a creature
int function GetModsRegisteredWithCreature(Race raceForm, Armor skinForm)
	return JMap.AllKeys(JMap.GetObj(JFormMap.GetObj(JFormMap.GetObj(jCreaturesMap, raceForm), GetSkinOrFake(skinForm)), "mods"))
endFunction

; Get the number of mods registered for a creature
int function GetModCountRegisteredWithCreature(Race raceForm, Armor skinForm)
	return JArray.Count(GetModsRegisteredWithCreature(raceForm, skinForm))
endFunction

; Get a JMap of a creature registration's properties
int function GetCreatureModMap(string modId, Race raceForm, Armor skinForm)
	return JMap.GetObj(JMap.GetObj(JFormMap.GetObj(JFormMap.GetObj(jCreaturesMap, raceForm), GetSkinOrFake(skinForm)), "mods"), modId)
endFunction

; Get the type of a creature registration
int function GetModCreatureType(string modId, Race raceForm, Armor skinForm)
	return JMap.GetInt(GetCreatureModMap(modId, raceForm, skinForm), "type")
endFunction

; Get the normal armour of a creature registration
Armor function GetModCreatureNormalArmor(string modId, Race raceForm, Armor skinForm)
	return JMap.GetForm(GetCreatureModMap(modId, raceForm, skinForm), "normalArmor") as Armor
endFunction

; Get the aroused armour of a creature registration
Armor function GetModCreatureArousedArmor(string modId, Race raceForm, Armor skinForm)
	return JMap.GetForm(GetCreatureModMap(modId, raceForm, skinForm), "arousedArmor") as Armor
endFunction

; Get whether or not the armour will be stripped for a creature registration
bool function GetModCreatureStripArmor(string modId, Race raceForm, Armor skinForm)
	return JMap.GetInt(GetCreatureModMap(modId, raceForm, skinForm), "stripArmor") as bool
endFunction

; Get whether or not the weapons will be stripped for a creature registration
bool function GetModCreatureStripWeapons(string modId, Race raceForm, Armor skinForm)
	return JMap.GetInt(GetCreatureModMap(modId, raceForm, skinForm), "stripWeapons") as bool
endFunction

; Get the JArray of blacklisted forms for stripping of a creature registration
int function GetModCreatureStripFormBlacklist(string modId, Race raceForm, Armor skinForm)
	return JMap.GetObj(GetCreatureModMap(modId, raceForm, skinForm), "stripFormBlacklist")
endFunction

; Get the JArray of blacklisted slots for stripping of a creature registration
int function GetModCreatureStripSlotBlacklist(string modId, Race raceForm, Armor skinForm)
	return JMap.GetObj(GetCreatureModMap(modId, raceForm, skinForm), "stripSlotBlacklist")
endFunction

; Get the JArray of restricted slots of a creature registration
int function GetModCreatureRestrictedSlots(string modId, Race raceForm, Armor skinForm)
	return JMap.GetObj(GetCreatureModMap(modId, raceForm, skinForm), "restrictedSlots")
endFunction

; Get the name of a race
string function GetRaceName(Race raceForm)
	if raceForm != none
		return JMap.GetStr(JFormMap.GetObj(jRacesMap, raceForm), "name")
	else
		return ""
	endIf
endFunction

; Get the name of a skin
string function GetSkinName(Armor skinForm)
	if skinForm != none && skinForm != FakeSkin
		return JMap.GetStr(JFormMap.GetObj(jSkinsMap, skinForm), "name")
	else
		return ""
	endIf
endFunction



;/----------------------------------------\
 | JSON registration methods              |
 \----------------------------------------/;

; Parses any JSON files in the creatures.d directory and registers mods/creatures from them
function LoadJSONRegistrations(bool reload = false)
	if loadingJSON
		CFDebug.Log("[Framework] Not loading JSON registrations; already loading")
		return
	endIf

	PreventMuckingAbout()
	loadingJSON = true
	CFDebug.Log("[Framework] Beginning JSON registration")

	int jsonFiles = JValue.ReadFromDirectory("Data/creatures.d", ".json")
	if jsonFiles == 0
		CFDebug.Log("[Framework] Unable to read creatures.d directory")
	elseIf JMap.Count(jsonFiles) == 0
		CFDebug.Log("[Framework] Didn't find any JSON files in creatures.d")
	else
		JValue.Retain(jsonFiles)
		CFDebug.Log("[Framework] Found " + JMap.Count(jsonFiles) + " JSON files in creatures.d")

		string fileName = JMap.NextKey(jsonFiles)
		while fileName
			if reload || JArray.FindStr(jLoadedFiles, fileName) == -1
				int fileMap = JMap.GetObj(jsonFiles, fileName)
				if fileMap != 0 && JMap.Count(fileMap) > 0
					CFDebug.Log("[Framework] Reading file " + fileName)
					string modID = JMap.GetStr(fileMap, "modID")
					string modName = JMap.GetStr(fileMap, "modName")
					int modCreatures = JMap.GetObj(fileMap, "creatures")
					int modCreatureCount = JArray.Count(modCreatures)
					if modID != "" && modName != "" && modCreatures != 0 && modCreatureCount > 0
						if !IsModRegistered(modID)
							RegisterMod(modID, modName)
						endIf

						int c = 0
						while c < modCreatureCount
							int modCreatureMap = JArray.GetObj(modCreatures, c)
							Race raceForm = JMap.GetForm(modCreatureMap, "raceForm") as Race
							string raceName = JMap.GetStr(modCreatureMap, "raceName")
							if raceForm != none && raceName != ""
								Armor skinForm = JMap.GetForm(modCreatureMap, "skinForm") as Armor
								if !IsCreatureRegisteredToMod(modID, raceForm, skinForm)
									string skinName = JMap.GetStr(modCreatureMap, "skinName")
									Armor normalArmor = JMap.GetForm(modCreatureMap, "normalArmor") as Armor
									Armor arousedArmor = JMap.GetForm(modCreatureMap, "arousedArmor") as Armor
									bool stripArmor = JMap.GetInt(modCreatureMap, "stripArmor") as bool
									bool stripWeapons = !JMap.HasKey(modCreatureMap, "stripWeapons") || JMap.GetInt(modCreatureMap, "stripWeapons")
									Form[] stripFormBlacklist = CreatureFrameworkUtil.FormArrayFromJArray(JMap.GetObj(modCreatureMap, "stripFormBlacklist"))
									int[] stripSlotBlacklist = CreatureFrameworkUtil.IntArrayFromJArray(JMap.GetObj(modCreatureMap, "stripSlotBlacklist"))
									int[] restrictedSlots = CreatureFrameworkUtil.IntArrayFromJArray(JMap.GetObj(modCreatureMap, "restrictedSlots"))
									Armor normalArmorFemale = JMap.GetForm(modCreatureMap, "normalArmorFemale") as Armor
									Armor arousedArmorFemale = JMap.GetForm(modCreatureMap, "arousedArmorFemale") as Armor
									RegisterCreatureArmorSwapToMod(modID, raceForm, skinForm, raceName, skinName, normalArmor, arousedArmor, stripArmor, stripWeapons, stripFormBlacklist, stripSlotBlacklist, restrictedSlots)
									if normalArmorFemale != none || arousedArmorFemale != none
										AddFemaleVariantToCreature(modID, raceForm, skinForm, normalArmorFemale, arousedArmorFemale)
									endIf
								endIf
							else
								CFDebug.Log("[Framework] File " + filename + " creature " + c + " is missing its race or race name")
							endIf
							c += 1
						endWhile

						JArray.AddStr(jLoadedFiles, fileName)
					else
						CFDebug.Log("[Framework] File " + fileName + " is missing a mod ID or name, or has no creatures")
					endIf
				else
					CFDebug.Log("[Framework] File " + fileName + " is invalid or empty")
				endIf
			else
				CFDebug.Log("[Framework] Already loaded file " + fileName + "; skipping")
			endIf

			fileName = JMap.NextKey(jsonFiles, fileName)
		endWhile

		JArray.Unique(jLoadedFiles)
		JValue.Release(jsonFiles)
		JValue.ZeroLifetime(jsonFiles)
	endIf

	CFDebug.Log("[Framework] Finished JSON registration")
	loadingJSON = false
	AllowMuckingAbout()
endFunction

; Get whether or not the JSON registrations are being loaded
bool function IsJSONLoading()
	return loadingJSON
endFunction

; Clears the list of loaded JSON files
function ResetLoadedFiles()
	CFDebug.Log("[Framework] Reset loaded JSON files")
	JArray.Clear(jLoadedFiles)
endFunction



;/----------------------------------------\
 | Active mod methods                     |
 \----------------------------------------/;

; Select an active mod for a creature
function SetActiveMod(Race raceForm, Armor skinForm, string modId)
	Armor realSkin = GetSkinOrFake(skinForm)

	if modId != ""
		if IsCreatureRegisteredToMod(modId, raceForm, realSkin)
			JMap.SetStr(JFormMap.GetObj(JFormMap.GetObj(jCreaturesMap, raceForm), realSkin), "activeMod", modId)
			TriggerUpdate(raceForm, realSkin)
			CFDebug.Log("[Framework] Set the active mod to \"" + modId + "\" for " + CreatureFrameworkUtil.GetDetailedFormName(raceForm) + CreatureFrameworkUtil.GetDetailedFormName(realSkin))
		else
			CFDebug.Log("[Framework] Failed to set the active mod to \"" + modId + "\" for " + CreatureFrameworkUtil.GetDetailedFormName(raceForm) + CreatureFrameworkUtil.GetDetailedFormName(realSkin) + "; creature not registered")
		endIf
	else
		JMap.SetStr(JFormMap.GetObj(JFormMap.GetObj(jCreaturesMap, raceForm), realSkin), "activeMod", modId)
		TriggerUpdate(raceForm, realSkin)
		CFDebug.Log("[Framework] Cleared the active mod for " + CreatureFrameworkUtil.GetDetailedFormName(raceForm) + CreatureFrameworkUtil.GetDetailedFormName(realSkin))
	endIf
endFunction

; Select an active mod for a creature using the mod's relative index rather than the ID
function SetActiveModUsingIndex(Race raceForm, Armor skinForm, int modIndex)
	If modIndex != -1
		SetActiveMod(raceForm, skinForm, JArray.GetStr(GetModsRegisteredWithCreature(raceForm, skinForm), modIndex))
	else
		SetActiveMod(raceForm, skinForm, "")
	endIf
endFunction

; Clear active mod of creatures that had it set to a specific one
function ClearActiveForMod(string modId)
	int races = GetRegisteredRaces()
	int racesSize = JArray.Count(races)
	int r = 0
	while r < racesSize
		Race raceForm = JArray.GetForm(races, r) as Race
		int skins = GetSkinsRegisteredToRace(raceForm)
		int skinsSize = JArray.Count(skins)
		int s = 0
		while s < skinsSize
			Armor skinForm = JArray.GetForm(skins, s) as Armor
			if GetActiveMod(raceForm, skinForm) == modId
				SetActiveMod(raceForm, skinForm, "")
			endIf
			s += 1
		endWhile
		r += 1
	endWhile
endFunction

; Get the active mod's ID for a creature
string function GetActiveMod(Race raceForm, Armor skinForm)
	return JMap.GetStr(JFormMap.GetObj(JFormMap.GetObj(jCreaturesMap, raceForm), GetSkinOrFake(skinForm)), "activeMod")
endFunction

; Get the active mod's relative index for a creature
int function GetActiveModIndex(Race raceForm, Armor skinForm)
	return JArray.FindStr(GetModsRegisteredWithCreature(raceForm, skinForm), GetActiveMod(raceForm, skinForm))
endFunction

; Get the active mod's name for a creature
string function GetActiveModName(Race raceForm, Armor skinForm)
	return GetModName(GetActiveMod(raceForm, skinForm))
endFunction

; Trigger an update for a creature
function TriggerUpdate(Race raceForm, Armor skinForm)
	int handle = ModEvent.Create("CFInternal_Update_" + raceForm.GetFormID() + "_" + GetSkinOrFake(skinForm).GetFormID())
	if handle
		CFDebug.Log("[Framework] Triggering creature update for " + CreatureFrameworkUtil.GetDetailedFormName(raceForm) + CreatureFrameworkUtil.GetDetailedFormName(skinForm))
		ModEvent.Send(handle)
	else
		CFDebug.Log("[Framework] Unable to trigger creature update for " + CreatureFrameworkUtil.GetDetailedFormName(raceForm) + CreatureFrameworkUtil.GetDetailedFormName(skinForm) + "; invalid handle")
	endIf
endFunction

; Trigger an update for an actor
function TriggerUpdateForActor(Actor actorForm)
	int handle = ModEvent.Create("CFInternal_Update_" + actorForm)
	if handle
		CFDebug.Log("[Framework] Triggering update for " + CreatureFrameworkUtil.GetDetailedActorName(actorForm))
		ModEvent.Send(handle)
	else
		CFDebug.Log("[Framework] Unable to trigger update for " + CreatureFrameworkUtil.GetDetailedActorName(actorForm) + "; invalid handle")
	endIf
endFunction



;/----------------------------------------\
 | Gender methods                         |
 \----------------------------------------/;

; Set an actor's override gender (0 = unspecified, 1 = male, 2 = female)
function SetOverrideGender(Actor actorForm, int gender)
	if actorForm != none && (gender > -1 && gender < 3)
		JFormDB.SetInt(actorForm, ".CFFormGender.Gnd", gender)
		CFDebug.Log("[Framework] Set override gender for creature " + CreatureFrameworkUtil.GetDetailedActorName(actorForm) + " to " + genders[gender])
	else
		CFDebug.Log("[Framework] Failed to set override gender for creature " + CreatureFrameworkUtil.GetDetailedActorName(actorForm) + "; invalid actor or gender")
	endIf
endFunction

; Get an actor's override gender (0 = unspecified, 1 = male, 2 = female)
int function GetOverrideGender(Actor actorForm)
	return JFormDB.GetInt(actorForm, ".CFFormGender.Gnd")
endFunction

; Get an actor's gender (1 = male, 2 = female)
int function GetGender(Actor actorForm)
	if actorForm == none
		return 0
	endIf

	; Check the override gender
	int overrideGender = JFormDB.GetInt(actorForm, ".CFFormGender.Gnd")
	if overrideGender != 0
		return overrideGender
	endIf

	; Check SexLab's gender (according to comment, 0 = male, 1 = female, 2 = male creature, 3 = female creature)
	if IsSexLabInstalled() && Config.GndUseSexLab
		if !Config.GndSexLabExcludeTransformations || !IsTransformation(actorForm)
			int sexlabGender = SexLab.GetGender(actorForm)
			return (sexlabGender % 2) + 1
		endIf
	endIf

	; Check Skyrim's gender (0 = male, 1 = female, 2 = creature)
	ActorBase base = actorForm.GetActorBase()
	if base == none
		base = actorForm.GetLeveledActorBase()
	endIf
	if base != none
		int skyrimGender = base.GetSex()
		if skyrimGender < 2
			return skyrimGender + 1
		endIf
	endIf

	; Set the override gender since none others can be used
	int newGender
	if Config.GndDefault == 0
		newGender = Utility.RandomInt(1, 2)
	else
		newGender = Config.GndDefault
	endIf
	CFDebug.Log("[Framework] Setting override gender from GetGender")
	SetOverrideGender(actorForm, newGender)
	return newGender
endFunction

; Get the source of a creature's gender (0 = none, 1 = Skyrim, 2 = SexLab, 3 = override)
int function GetGenderSource(Actor actorForm)
	if actorForm == none
		return 0
	endIf

	; Check the override gender
	if JFormDB.GetInt(actorForm, ".CFFormGender.Gnd") != 0
		return 3
	endIf

	; Check SexLab's gender (according to comment, 0 = male, 1 = female, 2 = male creature, 3 = female creature)
	if IsSexLabInstalled() && Config.GndUseSexLab
		if !Config.GndSexLabExcludeTransformations || actorForm.GetRace() != WerewolfRace && (VampireLordRace == none || actorForm.GetRace() != VampireLordRace)
			return 2
		endIf
	endIf

	; Check Skyrim's gender (0 = male, 1 = female, 2 = creature)
	ActorBase base = actorForm.GetActorBase()
	if base == none
		base = actorForm.GetLeveledActorBase()
	endIf
	if base != none
		if base.GetSex() < 2
			return 1
		endIf
	endIf

	return 0
endFunction

; Clear override genders for creatures
function ClearOverrideGenders(bool onlyUnloaded = true)
	if onlyUnloaded
		int eventHandle = ModEvent.Create("CFInternal_SaveGenders")
		if eventHandle
			JDB.SetObj("CFFormGender", 0)
			CFDebug.Log("[Framework] All override genders cleared; sending event to re-save")
			ModEvent.Send(eventHandle)
		endIf
	else
		JDB.SetObj("CFFormGender", 0)
		CFDebug.Log("[Framework] All override genders cleared")
	endIf
endFunction

; Reset the gender clear timer
function ResetGenderClearTimer()
	genderClearTimer = 0
	if Config.PrfGenderClearRate > 0
		CFDebug.Log("[Framework] Reset gender clear timer; will trigger " + Config.PrfGenderClearRate + " minutes from now")
	else
		CFDebug.Log("[Framework] Reset gender clear timer; won't trigger")
	endIf
endFunction

; Get the textual form of a gender
string function GetGenderText(int gender)
	if gender > -1 && gender < genders.length
		return genders[gender]
	else
		return "$None"
	endIf
endFunction

; Get the textual form of a gender source
string function GetGenderSourceText(int genderSource)
	if genderSource > -1 && genderSource < genderSources.length
		return genderSources[genderSource]
	else
		return "$None"
	endIf
endFunction

; Get the list of gender texts
string[] function GetGenderTexts()
	return genders
endFunction



;/----------------------------------------\
 | Arousal methods                        |
 \----------------------------------------/;

; Set an actor's override arousal (0 = unspecified, 1 = unaroused, 2 = aroused, 3 = aroused w/ stripping)
function SetOverrideArousal(Actor actorForm, int arousal)
	if actorForm != none && (arousal > -1 && arousal < 4)
		JFormDB.SetInt(actorForm, ".CFFormArousal.Arsl", arousal)
		CFDebug.Log("[Framework] Set override arousal for creature " + CreatureFrameworkUtil.GetDetailedActorName(actorForm) + " to " + overrideArousals[arousal])
	else
		CFDebug.Log("[Framework] Failed to set override arousal for creature " + CreatureFrameworkUtil.GetDetailedActorName(actorForm) + "; invalid actor or arousal")
	endIf
endFunction

; Get an actor's override arousal (0 = unspecified, 1 = unaroused, 2 = aroused, 3 = aroused w/ stripping)
int function GetOverrideArousal(Actor actorForm)
	return JFormDB.GetInt(actorForm, ".CFFormArousal.Arsl")
endFunction

; Test to see if a creature is aroused
bool function IsAroused(Actor actorForm, bool havingSex = false)
	int overrideArousal = JFormDB.GetInt(actorForm, ".CFFormArousal.Arsl")
	if overrideArousal == 1
		return false
	elseIf overrideArousal > 1
		return true
	elseIf havingSex || (IsSexLabEnabled() && actorForm.IsInFaction(SexLab.AnimatingFaction))
		return true
	elseIf IsArousedEnabled() && actorForm.GetFactionRank(ArousedFaction) >= Config.GenArousalThreshold
		return true
	else
		return false
	endIf
endFunction

; Get the source of arousal for a creature
int function GetArousalSource(Actor actorForm, bool havingSex = false)
	int overrideArousal = JFormDB.GetInt(actorForm, ".CFFormArousal.Arsl")
	if overrideArousal == 1
		return 3
	elseIf overrideArousal > 1
		return overrideArousal + 1
	elseIf havingSex || (IsSexLabEnabled() && actorForm.IsInFaction(SexLab.AnimatingFaction))
		return 1
	elseIf IsArousedEnabled() && actorForm.GetFactionRank(ArousedFaction) >= Config.GenArousalThreshold
		return 2
	else
		return 0
	endIf
endFunction

; Get the textual form of an arousal override
string function GetOverrideArousalText(int arousal)
	if arousal > -1 && arousal < overrideArousals.length
		return overrideArousals[arousal]
	else
		return "$None"
	endIf
endFunction

; Get the textual form of an arousal source
string function GetArousalSourceText(int arousalSource)
	if arousalSource > -1 && arousalSource < arousalSources.length
		return arousalSources[arousalSource]
	else
		return "$None"
	endIf
endFunction

; Get the list of arousal override texts
string[] function GetOverrideArousalTexts()
	return overrideArousals
endFunction



;/----------------------------------------\
 | Event methods                          |
 \----------------------------------------/;

; Fire an arousal event
string function FireEvent(string modId, Actor actorForm, bool aroused, Race raceForm = none, Armor skinForm = none, bool fromSex = true, bool fromArousal = false, bool fromUnequip = false, int arousalRating = -1, Armor unequippedArmor = none)
	; Create the event
	int eventHandle = ModEvent.Create("CFArousalChange_" + modId)
	if eventHandle
		ModEvent.PushForm(eventHandle, self)

		; Make a unique event ID
		string eventId = modId + "_" + actorForm.GetFormID() + "_" + Utility.RandomInt(-100000, 100000)
		ModEvent.PushString(eventHandle, eventId)

		; Grab the race and skin if they haven't been provided
		if raceForm == none
			raceForm = actorForm.GetRace()
		endIf
		if skinForm == none
			skinForm = GetSkinOrFakeFromActor(actorForm)
			if !IsCreatureRegisteredToMod(modId, raceForm, skinForm) && skinForm != FakeSkin
				skinForm = FakeSkin
			endIf
		endIf

		; Get the arousal rating of the actor if it isn't provided
		if arousalRating == -1 && IsArousedEnabled()
			arousalRating = actorForm.GetFactionRank(ArousedFaction)
		endIf

		; Make the map for the event and add it
		int eventMap = JMap.Object()
		JMap.SetStr(eventMap, "id", eventId)
		JMap.SetForm(eventMap, "actor", actorForm)
		JMap.SetInt(eventMap, "aroused", aroused as int)
		JMap.SetForm(eventMap, "race", raceForm)
		JMap.SetForm(eventMap, "skin", skinForm)
		JMap.SetInt(eventMap, "arousal", arousalRating)
		JMap.SetForm(eventMap, "unequippedArmor", unequippedArmor)
		JMap.SetInt(eventMap, "fromSex", fromSex as int)
		JMap.SetInt(eventMap, "fromArousal", fromArousal as int)
		JMap.SetInt(eventMap, "fromUnequip", fromUnequip as int)
		JMap.SetObj(jEventsMap, eventId, eventMap)

		; Fire away
		CFDebug.Log("[Framework] Firing event \"" + eventId + "\" for " + CreatureFrameworkUtil.GetDetailedActorName(actorForm))
		ModEvent.Send(eventHandle)
		return eventId
	else
		CFDebug.Log("[Framework] Unable to fire event for " + CreatureFrameworkUtil.GetDetailedActorName(actorForm) + "; invalid handle")
	endIf

	return none
endFunction

; Dispose of an event
function FinishEvent(string eventId)
	JMap.RemoveKey(jEventsMap, eventId)
endFunction

; Get the event data JMap
int function GetEventData(string eventId)
	return JMap.GetObj(jEventsMap, eventId)
endFunction

; Get the actor that an event is triggered for
Actor function GetEventActor(string eventId)
	return JMap.GetForm(GetEventData(eventId), "actor") as Actor
endFunction

; Get whether or not the actor the event is triggered for is aroused
bool function IsEventAroused(string eventId)
	return JMap.GetInt(GetEventData(eventId), "aroused") as bool
endFunction

; Get the race of the actor the event is triggered for
Race function GetEventRace(string eventId)
	return JMap.GetForm(GetEventData(eventId), "race") as Race
endFunction

; Get the skin of the actor the event is triggered for
Armor function GetEventSkin(string eventId)
	return JMap.GetForm(GetEventData(eventId), "skin") as Armor
endFunction

; Get the arousal rating of the actor the event is triggered for
int function GetEventArousal(string eventId)
	return JMap.GetInt(GetEventData(eventId), "arousal")
endFunction

; Get the unequipped armour that triggered the event
Armor function GetEventUnequippedArmor(string eventId)
	return JMap.GetForm(GetEventData(eventId), "unequippedArmor") as Armor
endFunction

; Get whether or not the event was triggered from sex
bool function IsEventFromSex(string eventId)
	return JMap.GetInt(GetEventData(eventId), "fromSex") as bool
endFunction

; Get whether or not the event was triggered from arousal
bool function IsEventFromArousal(string eventId)
	return JMap.GetInt(GetEventData(eventId), "fromArousal") as bool
endFunction

; Get whether or not the event was triggered from an unequip event
bool function IsEventFromUnequip(string eventId)
	return JMap.GetInt(GetEventData(eventId), "fromUnequip") as bool
endFunction

; Clear the events
function ClearEvents()
	JMap.Clear(jEventsMap)
endFunction



;/----------------------------------------\
 | Active actor methods                   |
 \----------------------------------------/;

; Add an active actor
bool function ActivateActor(Actor actorForm)
	if !restartingActiveActors
		if !actorForm.HasMagicEffect(CreatureFrameworkUtil.GetCreatureEffect())
			CFDebug.Log("[Framework] Activating actor " + CreatureFrameworkUtil.GetDetailedActorName(actorForm))
			if JArray.FindForm(jActiveActorsArr, actorForm) == -1
				JArray.AddForm(jActiveActorsArr, actorForm)
			else
				CFDebug.Log("[Framework] Already present in active actors array")
			endIf
			Spell creatureSpell = CreatureFrameworkUtil.GetCreatureSpell()
			actorForm.RemoveSpell(creatureSpell)
			Utility.Wait(0.25)
			actorForm.AddSpell(creatureSpell, false)
		else
			CFDebug.Log("[Framework] Didn't activate actor " + CreatureFrameworkUtil.GetDetailedActorName(actorForm) + "; already has effect")
			if JArray.FindForm(jActiveActorsArr, actorForm) == -1
				CFDebug.Log("[Framework] Restoring missing entry in active actors array")
				JArray.AddForm(jActiveActorsArr, actorForm)
			endIf
		endIf
	else
		CFDebug.Log("[Framework] Didn't activate actor " + CreatureFrameworkUtil.GetDetailedActorName(actorForm) + "; restarting")
		return false
	endIf
	return true
endFunction

; Remove an active actor
bool function DeactivateActor(Actor actorForm)
	if !restartingActiveActors
		int index = JArray.FindForm(jActiveActorsArr, actorForm)
		if index != -1
			JArray.EraseIndex(jActiveActorsArr, index)
			CFDebug.Log("[Framework] Deactivated actor " + CreatureFrameworkUtil.GetDetailedActorName(actorForm))
			return true
		else
			CFDebug.Log("[Framework] Didn't deactivate actor " + CreatureFrameworkUtil.GetDetailedActorName(actorForm) + "; not active")
			return false
		endIf
	else
		CFDebug.Log("[Framework] Didn't deactivate actor " + CreatureFrameworkUtil.GetDetailedActorName(actorForm) + "; restarting")
		return false
	endIf
endFunction

; Test to see if an actor is active
bool function IsActorActive(Actor actorForm)
	return JArray.FindForm(jActiveActorsArr, actorForm) != -1
endFunction

; Remove the active actors that are no longer valid
function ClearInvalidActiveActors()
	int a = 0
	while a < JArray.Count(jActiveActorsArr)
		if JArray.GetForm(jActiveActorsArr, a) as Actor
			a += 1
		else
			JArray.EraseIndex(jActiveActorsArr, a)
		endIf
	endWhile
endFunction

; Force all active actors' creature spells to be removed and re-added
function RestartActiveActors()
	if restartingActiveActors
		CFDebug.Log("[Framework] Not restarting active actors; already restarting")
		return
	endIf

	restartingActiveActors = true
	CFDebug.Log("[Framework] Forcing active actor restart")

	Spell creatureSpell = CreatureFrameworkUtil.GetCreatureSpell()
	Spell creatureApplySpell = CreatureFrameworkUtil.GetCreatureApplySpell()

	; Remove the spells from all active actors
	int size = JArray.Count(jActiveActorsArr)
	int a = 0
	while a < size
		Actor actorForm = JArray.GetForm(jActiveActorsArr, a) as Actor
		actorForm.RemoveSpell(creatureSpell)
		actorForm.RemoveSpell(creatureApplySpell)
		a += 1
	endWhile

	Utility.Wait(2)

	; Add the apply spell to all active actors
	a = 0
	while a < size
		Actor actorForm = JArray.GetForm(jActiveActorsArr, a) as Actor
		actorForm.AddSpell(creatureSpell)
		a += 1
	endWhile

	restartingActiveActors = false
endFunction

; Get whether or not the active actors are being restarted
bool function AreActiveActorsRestarting()
	return restartingActiveActors
endFunction



;/----------------------------------------\
 | SexLab animation events                |
 \----------------------------------------/;

event OnSexLabAnimationStart(string eventName, string strArg, float numArg, Form sender)
	if IsSexLabEnabled()
		Actor[] actors = SexLab.HookActors(strArg)
		int a
		while a < actors.length
			if JArray.FindForm(jActiveActorsArr, actors[a]) != -1
				int eventHandle = ModEvent.Create("CFInternal_SexLabSceneStart_" + actors[a])
				if eventHandle
					CFDebug.Log("[Framework] Sending SexLabSceneStart event for " + CreatureFrameworkUtil.GetDetailedActorName(actors[a]))
					ModEvent.Send(eventHandle)
				else
					CFDebug.Log("[Framework] Unable to send SexLabSceneStart event for " + CreatureFrameworkUtil.GetDetailedActorName(actors[a]) + "; invalid handle")
				endIf
			endIf
			a += 1
		endWhile
	endIf
endEvent

event OnSexLabAnimationEnd(string eventName, string strArg, float numArg, Form sender)
	if IsSexLabEnabled()
		Actor[] actors = SexLab.HookActors(strArg)
		int a
		while a < actors.length
			if JArray.FindForm(jActiveActorsArr, actors[a]) != -1
				int eventHandle = ModEvent.Create("CFInternal_SexLabSceneEnd_" + actors[a])
				if eventHandle
					CFDebug.Log("[Framework] Sending SexLabSceneEnd event for " + CreatureFrameworkUtil.GetDetailedActorName(actors[a]))
					ModEvent.Send(eventHandle)
				else
					CFDebug.Log("[Framework] Unable to send SexLabSceneEnd event for " + CreatureFrameworkUtil.GetDetailedActorName(actors[a]) + "; invalid handle")
				endIf
			endIf
			a += 1
		endWhile
	endIf
endEvent



;/----------------------------------------\
 | Puppet methods                         |
 \----------------------------------------/;

; Set the puppet
function SetPuppet(Actor actorForm)
	puppet = actorForm
	CFDebug.Log("[Framework] Set puppet to " + CreatureFrameworkUtil.GetDetailedActorName(puppet))
endFunction

; Get the puppet
Actor function GetPuppet()
	return puppet
endFunction

;/----------------------------------------\
 | Form DB methods                        |
 \----------------------------------------/;

 ; Clear the entire Form DB
 function ClearFormDB()
 	JDB.SetObj("CFForm", 0)
	JDB.SetObj("CFFormLog", 0)
 	CFDebug.Log("[Framework] Cleared Form DB")
 endFunction

; Clear the log Form DB
function ClearLogFormDB()
	JDB.SetObj("CFFormLog", 0)
	CFDebug.Log("[Framework] Cleared log Form DB")
endFunction

; Reset the Form DB clear timer
function ResetFormDBClearTimer()
	formDBClearTimer = 0
	if Config.PrfFormDBClearRate > 0
		CFDebug.Log("[Framework] Reset Form DB clear timer; will trigger " + Config.PrfFormDBClearRate + " minutes from now")
	else
		CFDebug.Log("[Framework] Reset Form DB clear timer; won't trigger")
	endIf
endFunction



;/----------------------------------------\
 | Utility methods                        |
 \----------------------------------------/;

; Get the version of the mod
int function GetVersion()
	return CreatureFrameworkUtil.GetVersion()
endFunction

; Get the textual representation of the version of the mod
string function GetVersionString()
	return CreatureFrameworkUtil.GetVersionString()
endFunction

; Test to see if SexLab is installed
bool function IsSexLabInstalled()
	return SexLab != none
endFunction

; Test to see if SexLab is enabled
bool function IsSexLabEnabled()
	return SexLab != none && Config.GenSexLab
endFunction

; Test to see if SexLab Aroused is installed
bool function IsArousedInstalled()
	return SexLabAroused != none
endFunction

; Test to see if SexLab Aroused is enabled
bool function IsArousedEnabled()
	return SexLabAroused != none && Config.GenAroused
endFunction

; Test to see if an actor is a creature
bool function IsCreature(Actor actorForm)
	return IsCreatureRace(actorForm.GetRace())
endFunction

; Test to see if an actor is a player beast (Khajiit or Argonian)
bool function IsBeast(Actor actorForm)
	return IsBeastRace(actorForm.GetRace())
endFunction

; Test to see if an actor is a creature or beast (Khajiit or Argonian)
bool function IsCreatureOrBeast(Actor actorForm)
	return IsCreatureOrBeastRace(actorForm.GetRace())
endFunction

; Test to see if an actor is a transformation (werewolf or vampire lord)
bool function IsTransformation(Actor actorForm)
	return IsTransformationRace(actorForm.GetRace())
endFunction

; Test to see if a race is a creature race
bool function IsCreatureRace(Race raceForm)
	return raceForm.HasKeyword(CreatureKeyword) || (VampireLordRace != none && raceForm == VampireLordRace)
endFunction

; Test to see if a race is a player beast race (Khajiit or Argonian)
bool function IsBeastRace(Race raceForm)
	return raceForm == ArgonianRace || raceForm == ArgonianVampireRace || raceForm == KhajiitRace || raceForm == KhajiitVampireRace
endFunction

; Test to see if a race is a creature race or a player beast race (Khajiit or Argonian)
bool function IsCreatureOrBeastRace(Race raceForm)
	return IsCreatureRace(raceForm) || IsBeastRace(raceForm)
endFunction

; Test to see if a race is a transformation (werewolf or vampire lord)
bool function IsTransformationRace(Race raceForm)
	return raceForm == WerewolfRace || (VampireLordRace != none && raceForm == VampireLordRace)
endFunction

; Get the fake skin if the skin passed is none, or the skin itself if not
Armor function GetSkinOrFake(Armor skinForm)
	if skinForm != none
		return skinForm
	else
		return FakeSkin
	endIf
endFunction

; Get the real skin from an Actor
Armor function GetSkinOrFakeFromActor(Actor actorForm)
	if actorForm != none
		Armor skinForm = actorForm.GetActorBase().GetSkin()
		if skinForm != none
			return skinForm
		else
			skinForm = actorForm.GetLeveledActorBase().GetSkin()
			if skinForm != none
				return skinForm
			else
				return GetSkinOrFake(actorForm.GetRace().GetSkin())
			endIf
		endIf
	else
		return FakeSkin
	endIf
endFunction

; Remove the unaroused and aroused armours from an actor
function RemoveArmors(Actor actorForm, bool removeNormal = true, bool removeAroused = true)
	int i
	while i < actorForm.GetNumItems()
		Form item = actorForm.GetNthForm(i)
		if (removeNormal && item.HasKeyword(ArmorNormalKeyword)) || (removeAroused && item.HasKeyword(ArmorArousedKeyword))
			actorForm.UnequipItem(item, false, true)
			actorForm.RemoveItem(item, 5, true)
		else
			i += 1
		endIf
	endWhile
endFunction

; Get the array of armour slots
int[] function GetArmorSlots()
	return armorSlots
endFunction

; Prevent mucking about with stuff while stuff is happening
function PreventMuckingAbout()
	muckingAboutPreventor += 1
endFunction

; Reallow mucking about
function AllowMuckingAbout()
	muckingAboutPreventor -= 1
	if muckingAboutPreventor < 0
		muckingAboutPreventor = 0
	endIf
endFunction

; Reset all mucking about prevention
function ResetMuckingAboutPrevention()
	muckingAboutPreventor = 0
endFunction

; Get whether or not we're allowed to muck about
bool function IsMuckingAboutAllowed()
	return muckingAboutPreventor == 0
endFunction

; Dump the framework data to "CreatureFramework.json"
function Dump()
	JValue.WriteToFile(jMainMap, "CreatureFramework.json")
	CFDebug.Log("[Framework] Dumped framework data to Skyrim directory")
endFunction
