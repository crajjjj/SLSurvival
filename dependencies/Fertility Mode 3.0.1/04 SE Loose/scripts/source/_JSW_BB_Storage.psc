Scriptname _JSW_BB_Storage extends Quest

GlobalVariable Property CycleDuration  Auto     ; Full duration of the menstrual cycle, eg. 28 days
GlobalVariable Property BirthRace  Auto         ; The race inheritance of the baby (mother = 0, father = 1, random = 2, specific = 3)
GlobalVariable Property BirthRaceSpecific  Auto ; The specific unconditional race of the child

Form[] Property TrackedActors  Auto          ; Currently tracked female actors
Form[] Property TrackedFathers  Auto         ; Currently tracked male actors
Form[] Property ActorBlackList  Auto         ; Actors that should not be tracked
string[] Property CurrentFather  Auto        ; The father name of the current insemination or pregnancy
string[] Property LastFather  Auto           ; The father name of the previous completed pregnancy
int[] Property FatherRaceId  Auto			 ; The current father's Race form ID from the last completed pregnancy

int[] Property LastGameHoursDelta  Auto      ; Random adjustment to the game hours so actors don't all have synchronized cycles

string[] Property LastMotherLocation  Auto   ; The last location where the female actor was encountered
string[] Property LastFatherLocation  Auto   ; The last location where the male actor was encountered

float[] Property LastGameHours  Auto         ; Game time when the actor was last updated
float[] Property LastInsemination  Auto      ; Game time when the actor was last inseminated (0.0 when no sperm is present)
float[] Property LastOvulation  Auto         ; Game time when the actor released an egg
float[] Property LastConception  Auto        ; Game time when the actor conceived (0.0 when not pregnant)
float[] Property LastBirth  Auto             ; Game time when the actor last gave birth
float[] Property SpermCount  Auto            ; The total amount of sperm currently active in any given female
float[] Property BabyAdded  Auto             ; Game time when the actor was given a baby item

string[] Property PlayerChildName  Auto      ; The given name of the child
int[] Property PlayerChildActorIndex  Auto   ; Adult actor base index for identifying which NPC to spawn
int[] Property PlayerChildGender  Auto       ; The gender of the child
string[] Property PlayerChildRace  Auto      ; The race of the child
string[] Property PlayerChildClass  Auto     ; The randomly selected training class for the child (Mage, Warrior)

Race[] Property RaceBlackList  Auto          ; Races excluded from tracking
Race[] Property BirthMotherRace  Auto        ; Supported mother races
Race[] Property BirthChildRace  Auto         ; Supported child races (matches BirthMotherRace)
Armor[] Property BirthBabyRace  Auto         ; Supported baby races (matches BirthMotherRace)
ActorBase[] Property Children  Auto          ; Supported child actor NPC bases
ActorBase[] Property AdultChildren  Auto     ; Supported adult actor NPC bases

int[] Property EventLock  Auto               ; Lock codes to avoid double-firing actor events such as labor and child spawns
bool[] Property FatherInseminationLock  Auto ; Lock flag to avoid multiple inseminations per father per poll

Actor Property CurrentFollower = none  Auto  ; The currently summoned adult follower
int Property CurrentFollowerIndex = -1  Auto ; The index of the currently summoned adult follower
int Property BabyHealth = 100  Auto          ; Scalar health percentage for the player's baby
float Property LastSleep = 0.0  Auto         ; The time of the last sleep for the player to assist in managing the baby's health

string _updatedToVersion = ""

function UpdateStorage()
{Dynamic update for storage in the latest version}
	; Add father race IDs to current tracked actors
    if (FatherRaceId.Length != TrackedActors.Length)
    	FatherRaceId = Utility.ResizeIntArray(FatherRaceId, TrackedActors.Length + 1, -1)
    endIf
    
    ; Add SpermCount to current tracked actors
    if (SpermCount.Length != TrackedActors.Length)
        SpermCount = Utility.ResizeFloatArray(SpermCount, TrackedActors.Length + 1, 0.0)
    endIf
    
    ; Add EventLock to current tracked actors
    if (EventLock.Length != TrackedActors.Length)
        EventLock = Utility.ResizeIntArray(EventLock, TrackedActors.Length + 1, 0)
    endIf
    
    ; Add father insemination lock to current tracked fathers
    if (FatherInseminationLock.Length != TrackedFathers.Length)
    	FatherInseminationLock = Utility.ResizeBoolArray(FatherInseminationLock, FatherInseminationLock.Length + 1, false)
    endIf
    
    _updatedToVersion = "2.9.1"
endFunction

Actor function TrackedActorGet(int index)
{Get the tracked actor at the specified index}
    return TrackedActors[index] as Actor
endFunction

Actor function TrackedFatherGet(int index)
{Get the tracked father at the specified index}
    return TrackedFathers[index] as Actor
endFunction

Actor function TrackedFatherGetByName(string fatherName)
{Get the tracked father with a given display name, or None if not found}
    int index = TrackedFathers.Length
    
    while (index)
        index -= 1
        
        if ((TrackedFathers[index] as Actor).GetDisplayName() == fatherName)
            return TrackedFathers[index] as Actor
        endIf
    endWhile
    
    return none
endFunction

function TrackedActorBlock(Actor akActor)
	if (ActorBlackList.Find(akActor) != -1)
		; The specified actor is already blocked
		return
	endIf
	
	int index = ActorBlackList.Find(none)
    
    if (index == -1)
    	ActorBlackList = Utility.ResizeFormArray(ActorBlackList, ActorBlackList.Length + 1, none)
    	index = TrackedActors.Find(none)
    endIf
    
    ActorBlackList[index] = akActor
endFunction

function TrackedActorUnblock(Actor akActor)
	int index = ActorBlackList.Find(akActor)
	
	if (index == -1)
		; The specified actor is not currently blocked
		return
	endIf
	
	ActorBlackList[index] = none
endFunction

int function TrackedActorAdd(Actor akActor)
{Try to add the specified actor to the tracking list}
    int index = TrackedActors.Find(akActor)
    
    ; Don't add if the actor is already being tracked
    if (index != -1)
        return index
    endIf
    
    index = TrackedActors.Find(none)
    
    if (index == -1)
        TrackedActors = Utility.ResizeFormArray(TrackedActors, TrackedActors.Length + 1, none)
        LastMotherLocation = Utility.ResizeStringArray(LastMotherLocation, LastMotherLocation.Length + 1, "")
        CurrentFather = Utility.ResizeStringArray(CurrentFather, CurrentFather.Length + 1, "")
        LastFather = Utility.ResizeStringArray(LastFather, LastFather.Length + 1, "")
        LastGameHoursDelta = Utility.ResizeIntArray(LastGameHoursDelta, LastGameHoursDelta.Length + 1, 0)
        LastGameHours = Utility.ResizeFloatArray(LastGameHours, LastGameHours.Length + 1, 0.0)
        LastInsemination = Utility.ResizeFloatArray(LastInsemination, LastInsemination.Length + 1, 0.0)
        LastOvulation = Utility.ResizeFloatArray(LastOvulation, LastOvulation.Length + 1, 0.0)
        LastConception = Utility.ResizeFloatArray(LastConception, LastConception.Length + 1, 0.0)
        LastBirth = Utility.ResizeFloatArray(LastBirth, LastBirth.Length + 1, 0.0)
        FatherRaceId = Utility.ResizeIntArray(FatherRaceId, TrackedActors.Length + 1, -1)
        SpermCount = Utility.ResizeFloatArray(SpermCount, SpermCount.Length + 1, 0.0)
        BabyAdded = Utility.ResizeFloatArray(BabyAdded, BabyAdded.Length + 1, 0.0)
        EventLock = Utility.ResizeIntArray(EventLock, EventLock.Length + 1, 0)
        index = TrackedActors.Find(none)
    endIf
    
    TrackedActors[index] = akActor
    LastMotherLocation[index] = akActor.GetCurrentLocation().GetName()
    CurrentFather[index] = ""
    LastFather[index] = ""
    LastGameHoursDelta[index] = Utility.RandomInt(0, CycleDuration.GetValueInt())
    LastGameHours[index] = Utility.GetCurrentGameTime()
    LastInsemination[index] = 0.0
    LastOvulation[index] = 0.0
    LastConception[index] = 0.0
    LastBirth[index] = 0.0
    FatherRaceId[index] = -1
    SpermCount[index] = 0.0
    BabyAdded[index] = 0.0
    EventLock[index] = 0
    
    return index
endFunction

int function TrackedFatherAdd(Actor akActor)
{Try to add the specified actor to the tracking list}
    int index = TrackedFathers.Find(akActor)
    
    ; Don't add if the actor is already being tracked
    if (index != -1)
        return index
    endIf
    
    index = TrackedFathers.Find(none)
    
    if (index == -1)
        TrackedFathers = Utility.ResizeFormArray(TrackedFathers, TrackedFathers.Length + 1, none)
        LastFatherLocation = Utility.ResizeStringArray(LastFatherLocation, LastFatherLocation.Length + 1, "")
        FatherInseminationLock = Utility.ResizeBoolArray(FatherInseminationLock, FatherInseminationLock.Length + 1, false)
        index = TrackedFathers.Find(none)
    endIf
    
    TrackedFathers[index] = akActor
    LastFatherLocation[index] = akActor.GetCurrentLocation().GetName()
    FatherInseminationLock[index] = false
    
    return index
endFunction

bool function TrackedActorRemove(int index)
{Remove the tracked actor at the specified index}
    if (index >= 0 && index < TrackedActors.Length)
        TrackedActors[index] = none
        return true
    endIf
    
    return false
endFunction

bool function TrackedFatherRemove(int index)
{Remove the tracked actor at the specified index}
    if (index >= 0 && index < TrackedFathers.Length)
        TrackedFathers[index] = none
        return true
    endIf
    
    return false
endFunction

function TrackedActorClear()
{Removes all entries and shrinks arrays to 0 length}
	TrackedActors = Utility.ResizeFormArray(TrackedActors, 0, none)
    LastMotherLocation = Utility.ResizeStringArray(LastMotherLocation, 0, "")
    CurrentFather = Utility.ResizeStringArray(CurrentFather, 0, "")
    LastFather = Utility.ResizeStringArray(LastFather, 0, "")
    LastGameHoursDelta = Utility.ResizeIntArray(LastGameHoursDelta, 0, 0)
    LastGameHours = Utility.ResizeFloatArray(LastGameHours, 0, 0.0)
    LastInsemination = Utility.ResizeFloatArray(LastInsemination, 0, 0.0)
    LastOvulation = Utility.ResizeFloatArray(LastOvulation, 0, 0.0)
    LastConception = Utility.ResizeFloatArray(LastConception, 0, 0.0)
    LastBirth = Utility.ResizeFloatArray(LastBirth, 0, 0.0)
    FatherRaceId = Utility.ResizeIntArray(FatherRaceId, 0, -1)
    SpermCount = Utility.ResizeFloatArray(SpermCount, 0, 0.0)
    BabyAdded = Utility.ResizeFloatArray(BabyAdded, 0, 0.0)
    EventLock = Utility.ResizeIntArray(EventLock, 0, 0)
endFunction

function TrackedFatherClear()
{Removes all entries and shrinks arrays to 0 length}
	TrackedFathers = Utility.ResizeFormArray(TrackedFathers, 0, none)
	LastFatherLocation = Utility.ResizeStringArray(LastFatherLocation, 0, "")
	FatherInseminationLock = Utility.ResizeBoolArray(FatherInseminationLock, 0, false)
endFunction

function PlayerChildAdd(Actor akActor, string name, int gender)
{Adds a training birth record}
    PlayerChildName = Utility.ResizeStringArray(PlayerChildName, PlayerChildName.Length + 1, name)
    PlayerChildGender = Utility.ResizeIntArray(PlayerChildGender, PlayerChildGender.Length + 1, gender)
    
    int trainIndex = Utility.RandomInt(0, 1)
    string trainingClass = "Warrior"
		
	if (trainIndex == 0)
		trainingClass = "Mage"
	elseIf (trainIndex == 1)
		trainingClass = "Warrior"
	endIf
	
	PlayerChildClass = Utility.ResizeStringArray(PlayerChildClass, PlayerChildClass.Length + 1, trainingClass)
	
	int actorIndex = TrackedActors.Find(akActor)
	int raceIndex = -1
	
	if (BirthRace.GetValueInt() == 0)
	    raceIndex = BirthMotherRace.Find(akActor.GetLeveledActorBase().GetRace())
	elseIf (BirthRace.GetValueInt() == 1)
		if (FatherRaceId[actorIndex] == -1)
			; Safety check for a missing father race, use the mother
			raceIndex = BirthMotherRace.Find(akActor.GetLeveledActorBase().GetRace())
		else
			raceIndex = BirthMotherRace.Find(Game.GetForm(FatherRaceId[actorIndex]) as Race)
		endIf
	elseIf (BirthRace.GetValueInt() == 2)
		if (FatherRaceId[actorIndex] == -1)
			; Safety check for a missing father race, use the mother
			raceIndex = BirthMotherRace.Find(akActor.GetLeveledActorBase().GetRace())
		elseIf (Utility.RandomInt(1, 100) < 50)
			raceIndex = BirthMotherRace.Find(akActor.GetLeveledActorBase().GetRace())
		else
			raceIndex = BirthMotherRace.Find(Game.GetForm(FatherRaceId[actorIndex]) as Race)
		endIf
    else
    	raceIndex = BirthRaceSpecific.GetValueInt()
    endIf
    
    int childRaceIndex = (2 * raceIndex + gender) + (trainIndex * 40)
    string childRace = AdultChildren[childRaceIndex].GetRace().GetName()
	
	PlayerChildActorIndex = Utility.ResizeIntArray(PlayerChildActorIndex, PlayerChildActorIndex.Length + 1, childRaceIndex)
	PlayerChildRace = Utility.ResizeStringArray(PlayerChildRace, PlayerChildRace.Length + 1, childRace)
endFunction