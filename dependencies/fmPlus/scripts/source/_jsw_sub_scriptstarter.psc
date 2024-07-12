Scriptname	_JSW_SUB_ScriptStarter	extends	ActiveMagicEffect

_JSW_BB_Storage					Property	Storage				Auto	; Storage data helper
_JSW_BB_Utility					Property	Util				Auto	; Independent helper functions
_JSW_SUB_ActorUpdates			Property	ActorUpdates		Auto	; a second utility-type script
_JSW_SUB_EventHandler			Property	FMEventHandler		Auto
_JSW_SUB_MatchMaker				Property	MatchMaker			Auto	; the script for matchmaking
_JSW_SUB_ScheduledUpdater		Property	ScheduledUpdater	Auto
_JSW_SUB_SpellHandler			Property	FMSpellHandler		Auto
; 2.25
Actor							Property	playerRef			Auto	; 
Spell							Property	ScriptRollCall		Auto	; 

string		errorPrefix		=		"FM+: Error "
; 2.09
Spell 							Property	FMUpdateSpell		Auto	; spell added to PC when Storage.UpdateRequired = true
; 2.25
Spell							Property	CompactArrays		Auto	; spell for array maintenence
; 2.11
FormList						Property	ChildrenToSpawn		Auto	; the formlist of PC's children to spawn
FormList						Property	FMBabyBirthRace		Auto	; to be copied to Storage.BabyBirthRace[]
FormList						Property	FMSupportedRaces	Auto	; the names of these forms are copied to Storage.ParentStrings[]
; 2.12
FormList						Property	FollowerChildren	Auto	; 
; 2.13
FormList						Property	NameBlackList		Auto	; TODO: importable name blacklist, to be copied to GVAlias script, add GVAlias property here
;		---- begin 2.18 ----
FormList						Property	UniqueChildren		Auto	; 
FormList						Property	UniqueFathers		Auto	; 
FormList						Property	UniqueMothers		Auto	; 
;		---- end 2.18  ----
; 2.14
GlobalVariable					Property	GameDaysPassed		Auto	;	
GlobalVariable					Property	NextMornSick		Auto	;	
; 2.21 LeveledList and Potions moved from main handler script
LeveledItem						Property	LeveledList			Auto	; Supported leveled list for potions

Potion							Property	PotionAbort			Auto	; Potion object for inducing abortion
Potion							Property	PotionContraception	Auto	; Potion object for inducing reduced fertility
Potion							Property	PotionFertility		Auto	; Potion object for inducing increased fertility
Potion							Property	PotionWashout		Auto	; Potion object for removing sperm

event	OnEffectStart(Actor akTarget, Actor akCaster)

	; 2.09
	playerRef.RemoveSpell(FMUpdateSpell)
	DoRollCallOne()
;	CheckOrder()
	DoRollCallTwo()
	; 2.10
	UpdateFormLists()
	; 2.09
	if Storage.UpdateRequired
		playerRef.AddSpell(FMUpdateSpell, false)
	endIf
	; 2.14
	if GameDaysPassed.GetValue() as int > NextMornSick.GetValue() as int
		NextMornSick.SetValue((GameDaysPassed.GetValue() as int) as float + 0.02)
	endIf
	; 2.15
	ImportBlackList()
	; 2.21 moved here from main handler
	UpdateLeveledLists()
	; 2.25
	playerRef.AddSpell(CompactArrays, false)

	RegisterForSingleUpdate(0.10)

endEvent

event	OnUpdate()

	if playerRef.HasSpell(CompactArrays as form)
		RegisterForSingleUpdate(0.05)
		return
	endIf
	ModEvent.Send(ModEvent.Create("FMWidgetFactions"))
	; 2.18
	SendModEvent("FMCheckNames")
	Debug.Trace("FM+ Script Roll Call completed!")
	; 2.23
	int handle = ModEvent.Create("FertilityModeActorsUpdated")
	if handle
		ModEvent.PushBool(handle, false)
		ModEvent.Send(handle)
	endIf
	playerRef.RemoveSpell(ScriptRollCall)

endEvent

function	DoRollCallOne()

	; have other scripts Unregister for any old modevents that they may be registered for
	Util.UtilUnregister()
	ActorUpdates.AUUnregister()
	FMEventHandler.EventHandlerUnregister()
	MatchMaker.MatchMakerUnregister()
	ScheduledUpdater.ScheduledUpdaterUnregister()
	FMSpellHandler.SpellHandlerUnregister()

endFunction

function	DoRollCallTwo()

	; iterate through current scripts, verifying they're present and have them perform their startup routines
	if !Storage.CheckPresence2()
		Debug.Messagebox(errorPrefix + "_JSW_BB_Storage script is being overwritten\n by either a loose file or another mod!\nThis patch cannot function properly!")
		Debug.Trace(errorPrefix + "_JSW_BB_Storage script error", 2)
	endIf

	if !Util.StartupFunction()
		Debug.Messagebox(errorPrefix + "_JSW_BB_Utility script is being overwritten\n by either a loose file or another mod!\nThis patch cannot function properly!")
		Debug.Trace(errorPrefix + "_JSW_BB_Utility script error", 2)
	endIf

	if !ActorUpdates.RunAtGoFunction()
		Debug.Messagebox(errorPrefix + "ActorUpdates Script is non-responsive")
		Debug.Trace(errorPrefix + "_JSW_SUB_ActorUpdates script error", 2)
	endIf

	if !FMEventHandler.FMReregisterEvents()
		Debug.Messagebox(errorPrefix + "EventHandler Script is non-responsive")
		Debug.Trace(errorPrefix + "_JSW_SUB_EbentHandler script error", 2)
	endIf

	if !MatchMaker.InitializeMatchMaker()
		Debug.Messagebox("FM+:  Warning _JSW_SUB_MatchMaker script is non-responsive")
		Debug.Trace("FM+:  Warning _JSW_SUB_MatchMaker script error: other", 2)
	endIf

	if !ScheduledUpdater.ScheduledUpdaterStartup()
		Debug.Messagebox(errorPrefix + "_JSW_SUB_ScheduledUpdater script is non-responsive")
		Debug.Trace(errorPrefix + "_JSW_SUB_ScheduledUpdater script error", 2)
	endIf

	if !FMSpellHandler.SpellHandlerListener()
		Debug.Messagebox(errorPrefix + "SpellHandler Script is non-responsive")
	endIf

endFunction

function	UpdateFormLists()

	Storage.Children = ChildrenToSpawn.ToArray()
	Storage.BirthBabyRace = FMBabyBirthRace.ToArray()
		; 2.12
	Storage.AdultChildren = FollowerChildren.ToArray()
	int index = FMSupportedRaces.GetSize()
	Storage.ParentStrings = Utility.ResizeStringArray(Storage.ParentStrings, index)
	while (index > 0)
		index -= 1
		Storage.ParentStrings[index] = FMSupportedRaces.GetAt(index).GetName()
	endWhile
	; ---- begin 2.18 ----
	Storage.UniqueChildren	=	UniqueChildren.ToArray()
	Storage.UniqueFathers	=	UniqueFathers.ToArray()
	Storage.UniqueMothers	=	UniqueMothers.ToArray()
	; ----  end 2.18  ----

endFunction

function	ImportBlackList()

	if (Storage.BlacklistByName.Find("ghost") == -1)
		Storage.BlacklistByName = Utility.ResizeStringArray(Storage.BlacklistByName, Math.LogicalAnd((Storage.BlacklistByName.Length + 1), 0x00000FFF), "ghost")
		Debug.Trace("FM+ : ghost added to blacklist")
	endIf

	int importLength = NameBlackList.GetSize()
	int imports = 0
	int iterations = 0
	string theName
	while (iterations < importLength)
		theName = NameBlackList.GetAt(iterations).GetName()
		if theName && (Storage.BlackListByName.Find(theName) == -1)
			Storage.BlackListByName = Utility.ResizeStringArray(Storage.BlackListByName, Math.LogicalAnd((Storage.BlacklistByName.Length + 1), 0x00000FFF), theName)
			imports += 1
			theName = ""
		endIf
		iterations += 1
	endWhile
	if imports > 0
		Debug.MessageBox(imports + " names imported to FM+ BlackList")
	endIf

endFunction

function	UpdateLeveledLists()
{Dynamically adds potions to specified leveled lists}

	LeveledList.AddForm(PotionAbort as form, 1, 1)
	LeveledList.AddForm(PotionWashout as form, 1, 1)
	LeveledList.AddForm(PotionFertility as form, 1, 1)
	LeveledList.AddForm(PotionContraception as form, 1, 1)

endFunction
