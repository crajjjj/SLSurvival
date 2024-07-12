Scriptname	_JSW_SUB_GVAlias	extends	ReferenceAlias  

_JSW_SUB_GVHolderScript		Property	GVHolder			Auto	;

_JSW_BB_Storage				Property	Storage				Auto	; Storage data helper
;_JSW_BB_Utility				Property	Util				Auto	; Independent helper functions

Actor			Property	playerRef			Auto		;	

Faction			Property	ScanFemFact			Auto		;	
Faction			Property	ScanMaleFact		Auto		;	
Faction			Property	ScanMaleCRFact		Auto		;	
; 2.24 added
form[]			Property	ChildLocs			Auto		; children of habatation location - these will be unique entries
															; and will have the Dwelling keyword
form[]			Property	HabitationLocs		Auto		; locations with the Habitation keyword - NOT unique entries (can/will have dupes)
; 2.25 loctypedwelling removed
;Keyword			Property	LocTypeDwelling		Auto		; keywords for dwellings
Keyword			Property	LocTypeHabitation	Auto		; keyword for settlements


Spell			Property	CellScanSpell		Auto		; 
Spell			Property	CompactArraySpell	Auto		; 

form[]			Property	TACopy				Auto	Hidden	; periodic copy of storage.trackedactors[]
form[]			Property	TFCopy				Auto	Hidden	; periodic copy of storage.trackedfathers[]
form[]			Property	BlacklistCopy		Auto	Hidden	; periodic copy of storage.actorsblacklist[]
string[]		Property	BLByNameCopy		Auto	Hidden	; periodic copy of storage.blacklistbyname[]
location		Property	here	=	none	Auto	Hidden	; where we be

event	OnLocationChange(Location akOldLoc, Location akNewLoc)

	here = akNewLoc
	UnregisterForUpdate()
	if GVHolder.Enabled
		; 2.24
		if akNewLoc && akOldLoc
			UpdateLocationMap(akOldLoc, akNewLoc)
		endIf
		if akNewLoc
			if ((storage as quest) as _JSW_BB_Utility).GetActorGender(playerRef)
				GoToState("FemalePC")
				UpdatePCLocation(akNewLoc)
			else
				GoToState("")
				UpdatePCLocation(akNewLoc)
			endIf
		endIf
		RegisterForSingleUpdate(0.1)
	endIf

endEvent

event	OnInit()

	if (GVHolder as quest).IsRunning()
		OnPlayerLoadGame()
		
	endIf

endEvent

event	OnUpdate()

	if playerRef.HasSpell(CompactArraySpell as form)
		RegisterForSingleUpdate(0.5)
		return
	endIf
	if GVHolder.ScanOptionsChanged
		UpdateFactions()
	endIf
	if !playerRef.HasSpell(CellScanSpell as form)
		TACopy			=	Utility.ResizeFormArray(Storage.TrackedActors, Math.LogicalAnd(Storage.TrackedActors.Length, 0xFFF))
		TFCopy			=	Utility.ResizeFormArray(Storage.TrackedFathers, Math.LogicalAnd(Storage.TrackedFathers.Length, 0xFFF))
		BlacklistCopy	=	Utility.ResizeFormArray(Storage.ActorBlackList, Math.LogicalAnd(Storage.ActorBlackList.Length, 0xFFF))
		BLByNameCopy	=	Utility.ResizeStringArray(Storage.BlackListByName, Math.LogicalAnd(Storage.BlackListByName.Length, 0xFFF))
		playerRef.AddSpell(CellScanSpell, false)
	endIf
	RegisterForSingleUpdate(12.0)

endEvent

event	OnPlayerLoadGame()

;/	if !ChildLocs.Length
		ChildLocs = Utility.ResizeFormArray(ChildLocs, 0)
	endIf
	if !HabitationLocs.Length
		HabitationLocs = Utility.ResizeFormArray(HabitationLocs, 0)
	endIf/;
	playerRef.RemoveSpell(CellScanSpell)
	GVHolder.PlayerLoadedGame()
;/	TACopy			=	Utility.ResizeFormArray(TACopy, 0)
	TFCopy			=	Utility.ResizeFormArray(TFCopy, 0)
	BlacklistCopy	=	Utility.ResizeFormArray(BlacklistCopy, 0)
	BLByNameCopy	=	Utility.ResizeStringArray(BLByNameCopy, 0)/;
	UpdateFactions()
	; 2.12
	CheckConflicts()
	; 2.24
	CheckEmpties()

endEvent

function	UpdateFactions()
{updates faction info, used by cell scan for new NPCs to add to tracking}

	GVHolder.UpdateGVs()
	; 2.21
	bool playerFemale = ((Storage as quest) as _JSW_BB_Utility).GetActorGender(playerRef) as bool

	if (!GVHolder.PlayerOnly && GVHolder.AutoInseminateNpc)
		if GVHolder.AllowCreatures
			playerRef.SetFactionRank(ScanMaleCRFact, 0)
			playerRef.RemoveFromFaction(ScanMaleFact)
		else
			playerRef.SetFactionRank(ScanMaleFact, 0)
			playerRef.RemoveFromFaction(ScanMaleCRFact)
		endIf
		playerRef.SetFactionRank(ScanFemFact, 0)
	elseIf (!GVHolder.PlayerOnly || !playerFemale)
		playerRef.SetFactionRank(ScanFemFact, 0)
		playerRef.RemoveFromFaction(ScanMaleFact)
		playerRef.RemoveFromFaction(ScanMaleCRFact)
	elseIf (GVHolder.AutoInseminateNpc && (!GVHolder.PlayerOnly || playerFemale))
		if GVHolder.AllowCreatures
			playerRef.SetFactionRank(ScanMaleCRFact, 0)
			playerRef.RemoveFromFaction(ScanMaleFact)
		else
			playerRef.SetFactionRank(ScanMaleFact, 0)
			playerRef.RemoveFromFaction(ScanMaleCRFact)
		endIf
		playerRef.RemoveFromFaction(ScanFemFact)
	else
		playerRef.RemoveFromFaction(ScanFemFact)
		playerRef.RemoveFromFaction(ScanMaleFact)
		playerRef.RemoveFromFaction(ScanMaleCRFact)
	endIf

	GVHolder.ScanOptionsChanged = false

endFunction

; 2.12 check for known conflicting patches
function	CheckConflicts()
{checks for presence of known conflicting mods}

	if (Game.GetModByName("Fertility Mode - RSChildren Patch Patch.esp") != 255)
		Debug.Messagebox("Newer versions of FM+ no longer require the old\n'Fertility Mode - RSChildren Patch Patch'!\nPlease exit the game and uninstall the Patch Patch")
		Debug.Trace("FM+: Error RSChildren Patch Patch installed", 2)
	endIf
	if (Game.GetModByName("Fertility Mode - Flower Girls.esp") != 255)
		Debug.Messagebox("The 'Fertility Mode - Flower Girls' patch does nothing anymore and\n should be removed from your mod list.")
		Debug.Trace("FM+: Error FG patch still installed", 1)
	endIf
	if (Game.GetModByName("Fertility Mode - RSChildren.esp") != 255)
		Debug.Messagebox("The 'Fertility Mode - RSChildren.esp' patch from Fertility Mode serves no purpose and will conflict.\nPlease exit the game and uninstall the 'Fertility Mode - RSChildren' patch.")
		Debug.Trace("FM+: Error FM-RSChildren patch loaded", 1)
	endIf
	if (Game.GetModByName("TAF_Fertility_Mode.esp") != 255) || (Game.GetModByName("TAF_Fertility_Mode_TKAA.esp") != 255) || (Game.GetModByName("TAF-TLD_Unified_Fertility_Mode_Patch.esp") != 255)
		Debug.Trace("FM+: Error TAF/TLD FM patches loaded", 1)
	endIf

endFunction
; 2.24
function	UpdateLocationMap(location akOldLoc, location akNewLoc)
{build parent/child location mapping used for random inseminations}

	int anInt = ChildLocs.Find(akOldLoc as form)
	if (akNewLoc == none) || (akOldLoc == none) || ((anInt != -1) && (ChildLocs.Find(akNewLoc as form) != -1))
		return
	endIf
	form childLoc
	form parentLoc
	if akNewLoc.HasKeyword(LocTypeHabitation) && akNewLoc.IsChild(akOldLoc)
		parentLoc = akNewLoc as form
		childLoc = akOldLoc as form
	elseIf akOldLoc.HasKeyword(LocTypeHabitation) && akOldLoc.IsChild(akNewLoc)
		parentLoc = akOldLoc as form
		childLoc = akNewLoc as form
	; 2.25
	elseIf akOldLoc.HasCommonParent(akNewLoc, LocTypeHabitation)
		int newInt = ChildLocs.Find(akNewLoc as form)
		if (anInt == -1) && (newInt != -1)
			childLoc = akOldLoc as form
			parentLoc = HabitationLocs[newInt]
		elseIf (anInt != -1) && (newInt == -1)
			childLoc = akNewLoc as form
			parentLoc = HabitationLocs[anInt]
		endIf
	endIf
	if childLoc && parentLoc && (ChildLocs.Find(childLoc) == -1)
		anInt = ChildLocs.Find(none)
		if (anInt != -1)
			ChildLocs[anInt] = childLoc
			HabitationLocs[anInt] = parentLoc
		else
			anInt = Math.LogicalAnd((ChildLocs.Length + 1), 0x000003FF)
			ChildLocs		=	Utility.ResizeFormArray(ChildLocs, anInt, childLoc)
			HabitationLocs	=	Utility.ResizeFormArray(HabitationLocs, anInt, parentLoc)
			debug.trace("FM+: " + parentLoc.GetName() + " is the parent location of " + childLoc.GetName())
		endIf
	endIf

endFunction

function	CheckEmpties()
{changes invalid entries to none in case of mod removal mod-game}

	int index = Math.LogicalAND(ChildLocs.Length, 0xFFF)
	while (index > 0)
		index -= 1
		if !(ChildLocs[index] as location) || !(HabitationLocs[index] as location)
			ChildLocs[index] = none
			HabitationLocs[index] = none
		endIf
	endWhile

endFunction
; 2.25
function	UpdatePCLocation(location here)
{update PC's location, male version}

	string locName = here.GetName()
	if !locName
		locName = "Skyrim"
	endIf
	location parentLoc
	int index
	if (HabitationLocs.Find(here as form) != -1)
		parentLoc = here
	else
		index = ChildLocs.Find(here as form)
		if (index != -1)
			parentLoc = HabitationLocs[index] as location
		endIf
	endIf
	index = Storage.TrackedFathers.Find(playerRef as form)
	if (index != -1)
		Storage.FatherLocation[index] = here as form
		Storage.FatherLocParent[index] = parentLoc as form
		Storage.LastFatherLocation[index] = locName
	endIf

endFunction
; 2.26
bool	function	ImHere()
	return true
	debug.trace("GValias triggered")
endFunction

state	FemalePC

	function	UpdatePCLocation(location here)
	{updates PC's location, female version}

		string locName = here.GetName()
		if !locName
			locName = "Skyrim"
		endIf
		location parentLoc
		int index
		if (HabitationLocs.Find(here as form) != -1)
			parentLoc = here
		else
			index = ChildLocs.Find(here as form)
			if (index != -1)
				parentLoc = HabitationLocs[index] as location
			endIf
		endIf
		index = Storage.TrackedActors.Find(playerRef as form)
		if (index != -1)
			Storage.ActorLocation[index] = here as form
			Storage.ActorLocParent[index] = parentLoc as form
			Storage.LastMotherLocation[index] = locName
		endIf

	endFunction

endState
