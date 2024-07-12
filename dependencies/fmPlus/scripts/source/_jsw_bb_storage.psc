Scriptname		_JSW_BB_Storage		extends		Quest

_JSW_SUB_GVAlias		Property	GVAlias		Auto	; 
_JSW_SUB_GVHolderScript	Property	GVHolder	Auto	;

; the females
form[]		Property	TrackedActors			Auto	; Currently tracked female actors
string[]	Property	LastMotherLocation		Auto	; The last location where the female actor was encountered
form[]		Property	CurrentFatherForm		Auto	; formID of the current inseminator
; 2.15 also get father Race immediately
form[]		Property	CurrentFatherRace		Auto	; 
; 2.13 LastFather is deprecated and no longer updated.   UpdateSpell will shrink to zero length.
; 2.20 drop the array entirely.
;string[]	Property	LastFather				Auto	; The father name of the previous completed pregnancy
; 2.24
;	oxFFFFFFFF	=	not unique actor ( -1 )  added 2.25
;	0x00000001	=	has family relationship
;	0x00000002	=	has sibling
;	0x00000004	=	has Parent/Child
;	0x00000008	=	has Aunt/Uncle
;	0x00000010	=	has Grandparent/Grandchild
int[]		Property	ATFlags					Auto	; flags for AssociationTypes
form[]		Property	LastFatherForm			Auto	; formID of the current father
float[]		Property	LastGameHours			Auto	; Game time when the actor was last updated
float[]		Property	LastInsemination		Auto	; Game time when the actor was last inseminated (0.0 when no sperm is present)
float[]		Property	LastOvulation			Auto	; Game time when the actor released an egg
float[]		Property	LastConception			Auto	; Game time when the actor conceived (0.0 when not pregnant)
float[]		Property	LastBirth				Auto	; Game time when the actor last gave birth
int[]		Property	FatherRaceId			Auto	; The current father's Race form ID from the last completed pregnancy
int[]		Property	SpermCount				Auto	; The total amount of sperm currently active in any given female
float[]		Property	BabyAdded				Auto	; Game time when the actor was given a baby item
int[]		Property	EventLock				Auto	; Lock codes to avoid double-firing actor events such as labor and child spawns
int[]		Property	DayOfCycle				Auto	; an actor's day of their cycle
int[]		Property	TimesDelivered			Auto	; how many babies the tracked actor has delivered.  Or soul gems. 
int[]		Property	OvulationBlock			Auto	; to prevent an (additional) ovulation during the current tracked actor's cycle
form[]		Property	FemHasLoveInterest		Auto	; an array for the females to store a relevant love interest
int[]		Property	FemAttached				Auto	; 0 = no attachment		1 = spouse		2 = Courting relationship
form[]		Property	ActorLocation			Auto	; Form array for actor location as form, just the name string is too vague
; 2.24
form[]		Property	ActorLocParent			Auto	; location's parent, if the parent has Habitation flag.  Can be current loc
														; if the current location has that flag
int[]		Property	Fidelity				Auto	; modifier to spouse fidelity

; the males
form[]		Property	TrackedFathers			Auto	; Currently tracked male actors
string[]	Property	LastFatherLocation		Auto	; The last location where the male actor was encountered
int[]		Property	RefractoryPeriod		Auto	; replaces former FatherInseminationLock
form[]		Property	MaleHasLoveInterest		Auto	; an array for the males to store a relevant love interest
int[]		Property	MaleAttached			Auto	; 0 = no attachment		1 = spouse		2 = Courting relationship
form[]		Property	FatherLocation			Auto	; father location as form, just the name string is too vague
; 2.24
form[]		Property	FatherLocParent			Auto	; location's parent, if the parent has Habitation flag.  Can be current loc
														; if the current location has that flag
int[]		Property	ChildrenFathered		Auto	; number of children fathered by this actor
; 2.25
int[]		Property	ATFlagsMale				Auto	; AssociationType flags, see female array for meanings

; the next two differ that ActorBlackList is for individual actors, BlackListByName is for all actors with that name
form[]		Property	ActorBlackList			Auto	; Actors that should not be tracked
string[]	Property	BlackListByName			Auto	; Actor names that should not be tracked

; the kiddies
string[]	Property	PlayerChildName			Auto	; The given name of the child
int[]		Property	PlayerChildActorIndex	Auto	; Adult actor base index for identifying which NPC to spawn
int[]		Property	PlayerChildGender		Auto	; The gender of the child
form[]		Property	PlayerChildRace			Auto	; The race of the child.  For real, not a string.
string[]	Property	PlayerChildClass		Auto	; The randomly selected training class for the child (Mage, Warrior)

form[]		Property	BirthBabyRace			Auto	; Supported baby races (matches ParentStrings) if no match found, use default
form[]		Property	Children				Auto	; Supported child actor NPC bases

form[]		Property	AdultChildren			Auto	Hidden	; supported adult follower children actorbases

actor	Property	CurrentFollower = none		Auto	; The currently summoned adult follower
int		Property	CurrentFollowerIndex = -1	Auto	; The index of the currently summoned adult follower

int			Property	BabyHealth = 105		Auto	; Scalar health percentage for the player's baby
float		Property	LastSleep = 0.0			Auto	; The time of the last sleep for the player
bool		Property	UpdateRequired			Auto	; new bool to decide if update spell needs to run

bool		Property	FormListToForm			Auto	; indicates whether or not the ActorBlackList[] has been populated

; 0Argonian 1Breton 2Dark Elf 3High Elf 4Imperial 5Khajiit 6Nord 7Orc 8Redguard 9Snow Elf 10Wood Elf
String[]	Property	ParentStrings			Auto	; strings for parent race lookups

Faction		Property	GenericFaction			Auto	; faction for pregnant NPCs
; 2.26
Faction		Property	PlayerRelatedFac		Auto	; is the female's state player-related?
Faction		Property	TrackedMaleFaction		Auto	; faction for tracked males

ReferenceAlias[]	Property	LaborRefs		Auto
; 2.24
Formlist	Property	ExcludeAT				Auto	; AssocitionTypes excluded from randon insems
;		---- begin 2.18 ----
int[]		Property	CouplesQuestions		Auto	; stored results of players' answers to whether couples should be pregnant
form[]		Property	ChildrenSpawned			Auto	; list of unique children already spawned
form[]		Property	UniqueChildren			Auto	; 
form[]		Property	UniqueFathers			Auto	; 
form[]		Property	UniqueMothers			Auto	; 
;		----  end 2.18  ----
; keep this list updated, idiot
; 0 - trimester duration,int	1 - ovulation day, int	2 - multithread, deprecated	3 - deprecated
; 4 - SLIFdetected, boolish		5-firstrun compactarray	6 - deprecated		7 - widget baby health boolish
; 8 - deprecated				9 - this patch major version		10 - this patch minor version	11 - refractory period
; 12 - 	deprecated						13 - deprecated					14 - TrackedActors update index	
; 15 - TrackedFathers update index		16 - deprecated		17 - deprecated

int[]		Property	FMValues				Auto	; store frequently-used variables.  Deprecated.

string _updatedToVersion = ""

bool	function	CheckPresence2()
{verifies that the storage script is running}

	return true

endFunction

function	InitializeStorage()
{separate out parts of UpdateStorage that only need to be done on new game}

	GoToState("")
	if FMValues.Length != 24
		FMValues = Utility.ResizeIntArray(FMValues, 24)
	endIf

endFunction

State	UpdateDone

	function UpdateStorage()
	endFunction

endState

function	UpdateStorage()
{Dynamic update for storage in the latest version}

	if FMValues.Length != 24
		FMValues = Utility.ResizeIntArray(FMValues, 24)
	endIf
	if ((FMValues[9] != 2) || (FMValues[10] != 27))
		FMValues[9] = 2
		FMValues[10] = 27
		UpdateRequired = true
	else
		UpdateRequired = false
	endIf
; 2.15
	int index = Math.LogicalAnd(TrackedActors.Length, 0x00000FFF)
	if index != CurrentFatherRace.Length
		if index == FatherRaceID.Length
			CurrentFatherRace = Utility.ResizeFormArray(CurrentFatherRace, index)
			int fatherRace
			while (index > 0)
				index -= 1
				fatherRace = FatherRaceID[index]
				if fatherRace != -1
					CurrentFatherRace[index] = Game.GetForm(fatherRace)
					fatherRace = -1
				endIf
			endWhile
			FatherRaceID = Utility.ResizeIntArray(FatherRaceID, 0)
		endif
	endIf
    _updatedToVersion = "patch 2.25"
	GoToState("UpdateDone")

endFunction

function	TrackedActorAdd(Actor akActor, String locName = "", location where = none, int flags = -2, location parentLoc = none)
{Try to add the specified actor to the tracking list}

	if !akActor || (TrackedActors.Find(akActor as form) != -1)
		return
	endIf

	; see?  I can use randomint if I really need to.  A few things with the below logics:
	; Each actor when added will be assigned a random day of their cycle. 
	; Also, they'll be checked if they should have ovulated- and if so, they are.
	int		cycleDay	=	Utility.RandomInt(1, GVHolder.CycleDuration)
	float	now			=	GVHolder.GVGameDaysPassed.GetValue()
	if !where && !locName
		where = akActor.GetCurrentLocation()
		if where
			locName = where.GetName()
			if locName == ""
				locName = "Skyrim"
			endIf
		else
			locName = "Tamriel"
		endIf
	elseIf !where
		where = akActor.GetCurrentLocation()
	elseIf !locName
		locName = where.GetName()
		if !locName
			locName = "Skyrim"
		endIf
	endIf
	; 2.24
	if (parentLoc == none) && where
		if (GVAlias.HabitationLocs.Find(where as form) != -1)
			parentLoc = where
		else
			int index = GVAlias.ChildLocs.Find(where as form)
			if index != -1
				parentLoc = GVAlias.HabitationLocs[index] as location
			endIf
		endIf
	endIf
	if flags == -2
		if !akActor.GetLeveledActorBase().IsUnique()
			flags = -1
		elseIf akActor.HasFamilyRelationship()
			flags = 0x01
			int FLLength = ExcludeAT.GetSize()
			int theCount = 0
			while (theCount < FLLength)
				if akActor.HasAssociation(ExcludeAT.GetAt(theCount) as AssociationType)
					flags = Math.LogicalOR(flags, Math.LeftShift(0x01, (theCount + 1)))
				endIf
				theCount += 1
			endWhile
		else
			flags = 0
		endIf
	endIf

	int anInt				=	Math.LogicalAnd((TrackedActors.Length + 1), 0x00000FFF)
	TrackedActors			=	Utility.ResizeFormArray(TrackedActors, anInt, akActor as form)
	LastMotherLocation		=	Utility.ResizeStringArray(LastMotherLocation, anInt, locName)
	CurrentFatherForm		=	Utility.ResizeFormArray(CurrentFatherForm, anInt)
	; 2.08
	LastFatherForm			=	Utility.ResizeFormArray(LastFatherForm, anInt)
	LastGameHours			=	Utility.ResizeFloatArray(LastGameHours, anInt, now)
	LastInsemination		=	Utility.ResizeFloatArray(LastInsemination, anInt)
	LastOvulation			=	Utility.ResizeFloatArray(LastOvulation, anInt)
	LastConception			=	Utility.ResizeFloatArray(LastConception, anInt)
	LastBirth				=	Utility.ResizeFloatArray(LastBirth, anInt)
	; 2.15
	CurrentFatherRace		=	Utility.ResizeFormArray(CurrentFatherRace, anInt)
	SpermCount				=	Utility.ResizeIntArray(SpermCount, anInt)
	BabyAdded				=	Utility.ResizeFloatArray(BabyAdded, anInt)
	EventLock				=	Utility.ResizeIntArray(EventLock, anInt)
	DayOfCycle				=	Utility.ResizeIntArray(DayOfCycle, anInt, cycleDay)
	TimesDelivered			=	Utility.ResizeIntArray(TimesDelivered, anInt)
	OvulationBlock			=	Utility.ResizeIntArray(OvulationBlock, anInt)
	FemHasLoveInterest		=	Utility.ResizeFormArray(FemHasLoveInterest, anInt)
	FemAttached				=	Utility.ResizeIntArray(FemAttached, anInt)
	ActorLocation			=	Utility.ResizeFormArray(ActorLocation, anInt, where as form)
	; 2.24
	ActorLocParent			=	Utility.ResizeFormArray(ActorLocParent, anInt, parentLoc as form)
	Fidelity				=	Utility.ResizeIntArray(Fidelity, anInt)
	ATFlags					=	Utility.ResizeIntArray(ATFlags, anint, flags)


	anInt = TrackedActors.RFind(akActor as form)
	if (cycleDay == (FMValues[1] + 1))
		if (anInt == -1)
			return
		endIf
		LastOvulation[anInt] = 0.5
		OvulationBlock[anInt] = 1
		if GVHolder.VerboseMode
			Debug.Notification(akActor.GetDisplayName() + " is ovulating!")
		endIf
	; 2.26 new modEvent for setting single actor faction
;		akActor.SetFactionRank(GenericFaction, -15)
;	else
;		akActor.SetFactionRank(GenericFaction, -1)
	endIf

	; 2.26
	((self as quest) as _JSW_SUB_SpellHandler).FMSetSingleActorFactionEvent("", "", anInt as float, none)

	return

endFunction

function	TrackedFatherAdd(Actor akActor, String locName = "", location where = none, int flags = -2, location parentLoc = none)
{Try to add the specified male to the tracking list}

	if !akActor || (TrackedFathers.Find(akActor as form) != -1)
		return
	endIf

	if !where && !locName
		where = akActor.GetCurrentLocation()
		if where
			locName = where.GetName()
			if locName == ""
				locName = "Skyrim"
			endIf
		else
			locName = "Tamriel"
		endIf
	elseIf !where
		where = akActor.GetCurrentLocation()
	elseIf (locName == "")
		locName = where.GetName()
		if locName == ""
			locName = "Skyrim"
		endIf
	endIf

	; 2.24
	if (parentLoc == none) && where
		if (GVAlias.HabitationLocs.Find(where as form) != -1)
			parentLoc = where
		else
			int index = GVAlias.ChildLocs.Find(where as form)
			if index != -1
				parentLoc = GVAlias.HabitationLocs[index] as location
			endIf
		endIf
	endIf
	if flags == -2
		if !akActor.GetLeveledActorBase().IsUnique()
			flags = -1
		elseIf akActor.HasFamilyRelationship()
			flags = 0x01
			int FLLength = ExcludeAT.GetSize()
			int theCount = 0
			while (theCount < FLLength)
				if akActor.HasAssociation(ExcludeAT.GetAt(theCount) as AssociationType)
					flags = Math.LogicalOR(flags, Math.LeftShift(0x01, (theCount + 1)))
				endIf
				theCount += 1
			endWhile
		else
			flags = 0
		endIf
	endIf

	int TFLength			=	Math.LogicalAnd((TrackedFathers.Length + 1), 0x00000FFF)
	TrackedFathers			=	Utility.ResizeFormArray(TrackedFathers, TFLength, akActor as form)
	LastFatherLocation		=	Utility.ResizeStringArray(LastFatherLocation, TFLength, locName)
	RefractoryPeriod		=	Utility.ResizeIntArray(RefractoryPeriod, TFLength)
	MaleHasLoveInterest		=	Utility.ResizeFormArray(MaleHasLoveInterest, TFLength)
	MaleAttached			=	Utility.ResizeIntArray(MaleAttached, TFLength)
	FatherLocation			=	Utility.ResizeFormArray(FatherLocation, TFLength, where as form)
	ChildrenFathered		=	Utility.ResizeIntArray(ChildrenFathered, TFLength)
	; 2.21
	akActor.SetFactionRank(TrackedMaleFaction, -1)
	FatherLocParent			=	Utility.ResizeFormArray(FatherLocParent, TFLength, parentLoc as form)
	; 2.25
	ATFlagsMale				=	Utility.ResizeIntArray(ATFLagsMale, TFLength, flags)

    return

endFunction

bool	function	TrackedActorRemove(int index, bool compaction = false)
{Remove the tracked actor at the specified index}

	int TALength = Math.LogicalAnd(TrackedActors.Length, 0x00000FFF)
    if ((index > -1) && (index < TALength))
		actor thisActor = TrackedActors[index] as actor
		; 2.26 don't delete any info during array compaction
		if thisActor && !compaction
			thisActor.RemoveFromFaction(GenericFaction)
			; 2.26
			thisActor.RemoveFromFaction(PlayerRelatedFac)
			; 1.59 if they're removed from tracking they must also be removed from the malehasloveinterest array
			int maleIndex = MaleHasLoveInterest.Find(thisActor as form)
			while (maleIndex != -1)
				MaleHasLoveInterest[maleIndex] = none
				if ((maleIndex + 1) < TrackedFathers.Length)
					maleIndex = MaleHasLoveInterest.Find(thisActor as form, (maleIndex + 1))
				else
					maleIndex = -1
				endIf
			endWhile
		endIf

        TrackedActors[index]		=	none
        LastMotherLocation[index]	=	""
		CurrentFatherForm[index]	=	none
		LastFatherForm[index]		=	none
        LastGameHours[index]		=	0.0
        LastInsemination[index]		=	0.0
        LastOvulation[index]		=	0.0
        LastConception[index]		=	0.0
        LastBirth[index]			=	0.0
		; 2.15
		CurrentFatherRace[index]	=	none
        SpermCount[index]			=	0
        BabyAdded[index]			=	0.0
        EventLock[index]			=	0
		DayOfCycle[index]			=	1
		TimesDelivered[index]		=	0
		OvulationBlock[index]		=	0
		FemHasLoveInterest[index]	=	none
		FemAttached[index]			=	0
		ActorLocation[index]		=	none
		Fidelity[index]				=	0
		; 2.24
		ATFlags[index]				=	0
		ActorLocParent[index]		=	none
        return true
    endIf

    return false
endFunction

bool	function	TrackedFatherRemove(int index, bool compaction = false)
{Remove the tracked father at the specified index}

    if ((index > -1) && index < (TrackedFathers.Length))

		; 1.59 if they're removed from tracking they must also be removed from the femhasloveinterest array
		actor thisActor = TrackedFathers[index] as actor
		; 2.26 don;t delete data during array compaction
		if thisActor && !compaction
			int femIndex = FemHasLoveInterest.Find(thisActor as form)
			int femLength = Math.LogicalAnd(FemHasLoveInterest.Length, 0x00000FFF)
			while (femIndex != -1)
				FemHasLoveInterest[femIndex] = none
				if ((femIndex + 1) < femLength)
					femIndex = FemHasLoveInterest.Find(thisActor as form, (femIndex + 1))
				else
					femIndex = -1
				endIf
			endWhile
			; 2.21
			thisActor.RemoveFromFaction(TrackedMaleFaction)
		endIf

        TrackedFathers[index]		=	none
        LastFatherLocation[index]	=	""
		RefractoryPeriod[index]		=	0
		MaleHasLoveInterest[index]	=	none
		MaleAttached[index]			=	0
		FatherLocation[index]		=	none
		ChildrenFathered[index]		=	0
		; 2.24
		FatherLocParent[index]		=	none
		; 2.25
		ATFlagsMale[index]			=	0
        return true
    endIf
    return false

endFunction

function	TrackedActorClear()
{Removes all entries and shrinks arrays to 0 length}

	; 2.26  whoops, removing them frm factions should've been done sooner
	int index = TrackedActors.Length
	actor thisActor
	while (index > 0)
		index -= 1
		thisActor = TrackedActors[index] as actor
		if thisActor
			thisActor.RemoveFromFaction(GenericFaction)
			thisActor.RemoveFromFaction(PlayerRelatedFac)
		endIf
	endWhile

	TrackedActors			=	Utility.ResizeFormArray(TrackedActors, 0)
    LastMotherLocation		=	Utility.ResizeStringArray(LastMotherLocation, 0)
	CurrentFatherForm		=	Utility.ResizeFormArray(CurrentFatherForm, 0)
	LastFatherForm			=	Utility.ResizeFormArray(LastFatherForm, 0)
    LastGameHours			=	Utility.ResizeFloatArray(LastGameHours, 0)
    LastInsemination		=	Utility.ResizeFloatArray(LastInsemination, 0)
    LastOvulation			=	Utility.ResizeFloatArray(LastOvulation, 0)
    LastConception			=	Utility.ResizeFloatArray(LastConception, 0)
    LastBirth				=	Utility.ResizeFloatArray(LastBirth, 0)
	; 2.15
	CurrentFatherRace		=	Utility.ResizeFormArray(CurrentFatherRace, 0)
    SpermCount				=	Utility.ResizeIntArray(SpermCount, 0)
    BabyAdded				=	Utility.ResizeFloatArray(BabyAdded, 0)
    EventLock				=	Utility.ResizeIntArray(EventLock, 0)
    DayOfCycle				=	Utility.ResizeIntArray(DayOfCycle, 0)
    TimesDelivered			=	Utility.ResizeIntArray(TimesDelivered, 0)
	OvulationBlock			=	Utility.ResizeIntArray(OvulationBlock, 0)
	FemHasLoveInterest		=	Utility.ResizeFormArray(FemHasLoveInterest, 0)
	FemAttached				=	Utility.ResizeIntArray(FemAttached, 0)
	ActorLocation			=	Utility.ResizeFormArray(ActorLocation, 0)
	Fidelity				=	Utility.ResizeIntArray(Fidelity, 0)
	; 2.24
	ATFlags					=	Utility.ResizeIntArray(ATFlags, 0)
	ActorLocParent			=	Utility.ResizeFormArray(ActorLocParent, 0)

endFunction

function	TrackedFatherClear()
{Removes all entries and shrinks arrays to 0 length}

	; 2.26  whoops, removing them frm factions should've been done sooner
	int index = TrackedFathers.Length
	actor thisActor
	while (index > 0)
		index -= 1
		thisActor = TrackedFathers[index] as actor
		if thisActor
			thisActor.RemoveFromFaction(TrackedMaleFaction)
		endIf
	endWhile

	TrackedFathers			=	Utility.ResizeFormArray(TrackedFathers, 0)
	LastFatherLocation		=	Utility.ResizeStringArray(LastFatherLocation, 0)
	RefractoryPeriod		=	Utility.ResizeIntArray(RefractoryPeriod, 0)
	MaleHasLoveInterest		=	Utility.ResizeFormArray(MaleHasLoveInterest, 0)
	MaleAttached			=	Utility.ResizeIntArray(MaleAttached, 0)
	FatherLocation			=	Utility.ResizeFormArray(FatherLocation, 0)
	ChildrenFathered		=	Utility.ResizeIntArray(ChildrenFathered, 0)
	; 2.24
	FatherLocParent			=	Utility.ResizeFormArray(FatherLocParent, 0)
	; 2.25
	ATFlagsMale				=	Utility.ResizeIntArray(ATFlagsMale, 0)

endFunction

function	PlayerChildAdd(Actor akActor, string name, int gender = -1)
{Adds a training birth record}

	if !((gender == 0) || (gender == 1))
		return
	endIf
    int trainIndex = Utility.RandomInt(0, 1)
    string trainingClass = "Warrior"
	if (trainIndex == 0)
		trainingClass = "Mage"
	endIf

	int raceIndex = GetRaceIndex(akActor)
	if (raceIndex == -1)
		return
	endIf

    int		childRaceIndex	=	(2 * raceIndex + gender) + (trainIndex * 2 * ParentStrings.Length)
	race	childRace		=	(AdultChildren[childRaceIndex] as actorbase).GetRace()

	int PCALength			=	Math.LogicalAnd((PlayerChildActorIndex.Length + 1), 0x00000FFF)
    PlayerChildName			=	Utility.ResizeStringArray(PlayerChildName, PCALength, name)
    PlayerChildGender		=	Utility.ResizeIntArray(PlayerChildGender, PCALength, gender)
	PlayerChildActorIndex	=	Utility.ResizeIntArray(PlayerChildActorIndex, PCALength, childRaceIndex)
	PlayerchildRace			=	Utility.ResizeFormArray(PlayerChildRace, PCALength, childRace as form)
	PlayerChildClass		=	Utility.ResizeStringArray(PlayerChildClass, PCALength, trainingClass)

endFunction

function	TrackedActorNameBlock(String actorName, Bool FMVerbose = False)
{block NPCs by name- will block ALL with the same display name}

	if !actorName || (BlacklistByName.Find(actorName) != -1)
		; The specified actor is already blacklisted or has no name
		return
	endIf
	int multiPurposeIndex	=	BlackListByName.Find("")
    if (multiPurposeIndex == -1)
    	BlacklistByName		=	Utility.ResizeStringArray(BlacklistByName, (BlacklistByName.Length + 1), actorName)
    else
		BlacklistByName[multiPurposeIndex]	=	actorName
	endIf
	;/	new 1.42: if, after all the above attempts to add and find them in the blacklist we
		somehow still fail, abort this function before we start using obviously bad values
		while deleting records /;
	if (BlacklistByName.Find(actorName) == -1)
		return
	endIf
	; below is new for 1.3, *IMMEDIATELY* remove blacklisted NPCs from tracking
	int TADeleted = 0
	; 2.16 change to objectreference
	; 2.23 cahnge back to actor for non-persistent actors
	actor thisActor
	multiPurposeIndex = Math.LogicalAnd(TrackedActors.Length, 0x00000FFF)
	while (multiPurposeIndex > 0)
		multiPurposeIndex -= 1
		; 2.16
		thisActor = TrackedActors[multiPurposeIndex] as actor
		if thisActor
			if actorName == thisActor.GetDisplayName()
				TrackedActorRemove(multiPurposeIndex)
				TADeleted += 1
			endIf
			thisActor = none
		endIf
	endWhile
	int TFDeleted = 0
	multiPurposeIndex = Math.LogicalAnd(TrackedFathers.Length, 0x00000FFF)
	while (multiPurposeIndex > 0)
		multiPurposeIndex -= 1
		; 2.16
		thisActor = TrackedFathers[multiPurposeIndex] as actor
		if thisActor
			if actorName == thisActor.GetDisplayName()
				TrackedFatherRemove(multiPurposeIndex)
				TFDeleted += 1
			endIf
			thisActor = none
		endIf
	endWhile
	if FMVerbose
		Debug.Messagebox(TADeleted + " tracked females and " + TFDeleted + " tracked males removed!")
	endIf
endFunction

function	TrackedActorNameUnblock(String actorName)
{unblock actor by display name- will affect ALL with that display name!}

	int index = BlacklistByName.Find(actorName)
	if (index != -1)
		BlacklistByName[index] = ""
	endIf

endFunction

function	TrackedActorBlock(Actor akActor)

	if (ActorBlackList.Find(akActor as form) != -1)
		; The specified actor is already blocked
		return
	endIf
	int index = ActorBlackList.Find(none)
    if (index == -1)
    	ActorBlackList	=	Utility.ResizeFormArray(ActorBlackList, (ActorBlackList.Length + 1), none)
		index			=	ActorBlackList.RFind(none)
    endIf
    ActorBlackList[index] = akActor as form

endFunction

function	TrackedActorUnblock(Actor akActor)

	int index = ActorBlackList.Find(akActor as form)
	if (index == -1)
		; The specified actor is not currently blocked
		return
	endIf
	ActorBlackList[index] = none

endFunction

Actor	function	TrackedActorGet(int index)
{Get the tracked actor at the specified index - used by Fertility Adventures}

	if (index == -1) || (index > (TrackedActors.Length - 1))
		return none
	endIf
    return TrackedActors[index] as Actor

endFunction

float	function	GetActorConception(form akActor)

	if !akActor
		return -1.0
	endIf
	int index = TrackedActors.Find(akActor)
	if (index == -1)
		return -1.0
	endIf
	return LastConception[index]

endFunction

int	function	GetRaceIndex(Actor akActor, int actorIndex = -1, bool forMCM = false)
{Retrieve the race index of the specified actor with given settings}

; (mother=0, father=1, random=2, specific=3)
	int anInt = GVHolder.BirthRace
	if (anInt == 3)
		return GVHolder.BirthRaceSpecific; * 2
	endIf
	string raceName
	if !forMcm && (actorIndex == -1)
		actorIndex = TrackedActors.Find(akActor as form)
		if (actorIndex == -1)
			return -1
		endIf
	endIf

; 2.15
	if forMCM || (anInt == 0) || ((anInt == 1) && (CurrentFatherRace[actorIndex] == none)) || ((anInt == 2) && \
			((CurrentFatherRace[actorIndex] == none) || Utility.RandomInt(0, 1)))
		raceName = (akActor.GetLeveledActorBase().GetRace() as form).GetName()
	else
	; 2.15
		raceName = CurrentFatherRace[actorIndex].GetName()
	endIf
	bool found = false
	anInt = Math.LogicalAnd(ParentStrings.Length, 0x0000001F)
	while (anInt > 0) && !found
		anInt -= 1
		found = (StringUtil.Find(raceName, ParentStrings[anInt]) != -1)
	endWhile
	if found
		return anInt
	endIf

	return -1
    
endFunction
; 2.16 added for FA
string	function	GetCurrentFathersName(actor theMother)

	int index = TrackedActors.Find(theMother as form)
	actor father = CurrentFatherForm[index] as actor
	if father
		return father.GetDisplayName()
	endIf
	return ""

endFunction
; dummy for FA compile
;string[]	property	currentfather	auto
