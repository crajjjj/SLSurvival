Scriptname	_JSW_SUB_ScheduledUpdater	extends	Quest

_JSW_BB_Storage						Property	Storage			Auto	; Storage data helper
_JSW_BB_Utility						Property	Util			Auto
_JSW_SUB_EventHandler				Property	FMEventHandler	Auto
_JSW_SUB_MatchMaker					Property	MatchMaker		Auto	; the script for matchmaking
_JSW_SUB_MiscUtilQuest				Property	FMMiscUtil		Auto	; script to calculate conception chance and stuff

_JSW_SUB_GVHolderScript				Property	GVHolder		Auto	;

_JSW_SUB_SchdUpdtHlpr				Property	SchdUpdtHlpr	Auto	; the helper script for full updates

Actor			Property	PlayerRef		Auto			; Reference to the player. Game.GetPlayer() is slow

Potion			Property	BreastMilk		Auto			; "Jug of Milk"
; 2.13
Faction			Property	FMDailyActorUpdtFact	Auto	; when added to this faction, the DailyActorUpdate ME goes active
; 2.15
GlobalVariable	Property	FMEPresent		Auto			; GV to indicate w234aew's future mod is present
; 2.18
Quest			Property	RhiadaQuest		Auto			; on-demand quest that makes Rhiada temporarality persistent while I need her to be

ReferenceAlias	Property	LoveInterest	Auto			; The actor reference of the player's spouse

int[]			Property	RandomIntArray	Auto			; an array to hold pre-generated random ints for fast retrieval when needed

form	playerRefForm										; playerRef as form

bool	_newDay = false
int		_autoInseminateChance
int		_cycleDuration
int		_recoveryDuration
int		_seed = 42
int		_trimesterDuration		=	4
string	_playerName
;bool	eventRunning			=	false
bool	isPlayerFemale
; 2.15
bool	FMEFound				=	false
; 2.25
bool	autoInsemNPC
bool	autoInsemPC
int		spouseInsemChance
float	spermLifeFloat

function	ScheduledUpdaterUnregister()

	UnregisterForAllModEvents()

endFunction

bool	function	ScheduledUpdaterStartup()
{register for modevents and sound off}

	_seed += Utility.RandomInt()

    if (Storage.FMValues[0] != 0)
		_trimesterDuration	=	Storage.FMValues[0]
	else
		_trimesterDuration	=	4
		Storage.FMValues[0]	=	4
	endIf
;	deprecated 2.23
;    RegisterForModEvent("FMSingleUpdateFullEvent", "FMSingleUpdateHelper") ; added
	playerRefForm = playerRef as form
	GoToState("")
	return true

endFunction

state	Busy

	function	UpdateStatusAll(bool isRegularPoll = true, bool isNewDay = false)
	endFunction

	function	PlayerOnlyClear()
	endFunction

	function	RefreshRandoms(int iterations = 20, int replacements = 0)
	endFunction

	event	OnBeginState()
		_autoInseminateChance	=	GVHolder.AutoInseminateChance
		_cycleDuration			=	GVHolder.CycleDuration
		_trimesterDuration		=	Storage.FMValues[0]
		_playerName				=	PlayerRef.GetDisplayName()
		; 2.25 4 new script vars
		autoInsemNPC			=	GVHolder.AutoInseminateNpc
		autoInsemPC				=	GVHolder.AutoInseminatePC
		spouseInsemChance		=	GVHolder.SpouseInseminateChance
		spermLifeFloat			=	GVHolder.SpermLife as float
		playerRefForm			=	playerRef as form
		FMEFound				=	(FMEPresent.GetValue() as bool)
		(SchdUpdtHlpr as quest).SetCurrentStageID(10)
		RegisterForSingleupdate(90.0)
	endEvent

	event	OnEndState()
		(SchdUpdtHlpr as quest).SetCurrentStageID(20)
	endEvent

	event	OnUpdate()
		GoToState("")
	endEvent

endState

function	UpdateStatusAll(bool isRegularPoll = true, bool isNewDay = false)
{update all current tracked actors}

	; 2.03
	GoToState("Busy")
	; 2.25 move what I can to state
;	(SchdUpdtHlpr as quest).SetCurrentStageID(10)
;	eventRunning = false
	_newDay = isNewDay
;/	_autoInseminateChance	=	GVHolder.AutoInseminateChance
	_cycleDuration			=	GVHolder.CycleDuration/;
	_recoveryDuration		=	GVHolder.RecoveryDuration
;/	_trimesterDuration		=	Storage.FMValues[0]
	_playerName = PlayerRef.GetDisplayName()
	; 2.25 4 new script vars
	autoInsemNPC			=	GVHolder.AutoInseminateNpc
	autoInsemPC				=	GVHolder.AutoInseminatePC
	spouseInsemChance		=	GVHolder.SpouseInseminateChance
	spermLifeFloat			=	GVHolder.SpermLife as float
	playerRefForm = playerRef as form
	; 2.15
	FMEFound = (FMEPresent.GetValue() as bool)/;

	_seed += _RecoveryDuration

	isPlayerFemale = (Util.GetActorGender(PlayerRef) == 1)
;    int recycleInt = 0

    if GVHolder.PlayerOnly
		; 2.08 move to own function
		PlayerOnlyClear()
    endIf
	Util.AddToTracking(playerRef)

	int index = 0
	if isRegularPoll
		int tempInt = 0
		; update (decrement) the refractory period for random inseminations
		index = Math.LogicalAnd(Storage.TrackedFathers.Length, 0x00000FFF)
		while (index > 0)
			index -= 1
			tempInt = Math.LogicalAnd(Storage.RefractoryPeriod[index], 0x0000001F)
			if (tempInt > 0)
			; 2.25 change this
;				tempInt -= 1
;				Storage.RefractoryPeriod[recycleInt] = tempInt
				Storage.RefractoryPeriod[index] = (tempInt - 1)
			endIf
		endWhile
		tempInt = 0
		index = Math.LogicalAnd(Storage.TrackedActors.Length, 0x00000FFF)
		Actor trackedActor = none
		actor pcSpouse = LoveInterest.GetReference() as Actor
		; ok, UpdateStatusSingle* wants to know the time it runs.   Rather than calling that
		; function potentially hundreds of times, we call it once here and pass it on
		float now = GVHolder.GVGameDaysPassed.GetValue()
		while (tempInt < index)
			trackedActor = (Storage.TrackedActors[tempInt] as Actor)
			if trackedActor
				UpdateStatusSingleFull(trackedActor, tempInt, now, (trackedActor == playerRef), pcSpouse)
				; new for 1.42, clear the trackedActor for next iteration
				trackedActor = none
			endIf
			tempInt += 1
		endWhile
	endIf

	; various player-only updates
	if isPlayerFemale
		if GVHolder.Enabled
			ModEvent.Send(ModEvent.Create("FMPUpdateWidgetContent"))
			ModEvent.Send(ModEvent.Create("FMPPlayerFactStat"))
		endIf
		bool hasBaby = false
		; reuse already declared index
		index = Math.LogicalAnd(Storage.BirthBabyRace.Length, 0x0000007F)
		while (index && !hasBaby)
			index -= 1
			hasBaby = (PlayerRef.GetItemCount(Storage.BirthBabyRace[index]) > 0)
		endWhile

		if hasBaby
			SchdUpdtHlpr.PlayBabySound(PlayerRef)
		endIf
	endIf

    if (_newDay && isRegularPoll)
		; 2.13 change to spell
;		ModEvent.Send(ModEvent.Create("FertilityModeActorMaint"))
		; 2.18 start Rhiada quest
		RhiadaQuest.SetCurrentStageID(10)
		playerRef.SetFactionRank(FMDailyActorUpdtFact, 20)
    endIf
	if isRegularPoll
		index = ModEvent.Create("FertilityModeActorsUpdated")
		if index
			ModEvent.PushBool(index, false)
			ModEvent.Send(index)
		endIf
	endIf
	; 2.03
	GoToState("")
;	if !eventRunning
	; 2.25 move to state
;		(SchdUpdtHlpr as quest).SetCurrentStageID(20)
;	endIf

endFunction

function	UpdateStatusSingleFull(Actor akActor, int actorIndex, float timeNow, bool isPlayerChar, actor pcSpouse)
{Update the selected tracked actor}

;	profiling 33-50ms
;	update: profiling 16-33ms with pseudo-random RNG

	;/	new 1.42 create one int, one float and one bool to be recycled in 
		various parts of later code /;
	int recycleInt = 0
	float recycleFloat = Storage.LastBirth[actorIndex]
	float lastConcept = Storage.LastConception[actorIndex]
	bool recycleBool = (lastConcept != 0.0)						; true if pregnant
	int birthDay = (timeNow - recycleFloat) as int
	; 1.42 stop updating DayOfCycle during recovery period
	if (_newday && !recycleBool && (!recycleFloat || (birthday > _recoveryDuration)))
		int dayToday = Math.LogicalAnd(Storage.DayOfCycle[actorIndex], 0x0000001F)
		dayToday += 1
		;/	while instead of if in case player shortened duration in MCM
			worst case it should need to loop 4x, we allow 5 before kill /;
		while ((dayToday > _cycleDuration) && (recycleInt < 5))
			dayToday -= _cycleDuration
			recycleInt += 1
		endWhile
		; 1.59 clear OvulationBlock if they're starting a new cycle
		if (dayToday == 1)
			if Storage.OvulationBlock[actorIndex] > 0
				Storage.OvulationBlock[actorIndex] = Storage.OvulationBlock[actorIndex] - 1
			endIf
		endIf
		Storage.DayOfCycle[actorIndex] = dayToday
		; clear recycleInt for lower usage
		recycleInt = 0
		if (recycleFloat && (birthDay < _recoveryDuration))
			; Give the actor daily milk during recovery
			akActor.AddItem(BreastMilk, 1, (akActor == playerRef))
		endIf
    endIf
; 2.15
	if (FMEFound && !recycleBool && recycleFloat && (birthDay < _recoveryDuration))
		SchdUpdtHlpr.UpdateRecovery(akActor, actorIndex, timeNow)
	endIf

    if !recycleBool
		if SchdUpdtHlpr.UpdateOvulationStatus(actorIndex, birthDay, timeNow)
			if Storage.SpermCount[actorIndex]
				recycleInt = FMMiscUtil.CalculateFertility(actorIndex, timeNow)
			endIf
		endIf
        if recycleInt
			if !Math.LogicalAnd(recycleInt, 0x00030000)	; true if neither bit 17 nor 18 is set
				; no magic effect roll - most likely scenario so check it first
				recycleInt = Math.LogicalAnd(recycleInt, 0x0000007F)
				recycleBool = (FetchRandom() < recycleInt)
			elseIf Math.LogicalAnd(recycleInt, 0x00010000)	; check if bit 17 is set
				; contraception effect rolls
				recycleInt = Math.LogicalAnd(recycleInt, 0x0000007F)
				recycleBool = ((FetchRandom() < recycleInt) && (FetchRandom() < recycleInt))
			else	; process of elimination, bit 18 must be set
				; fertility effect rolls
				recycleInt = Math.LogicalAnd(recycleInt, 0x0000007F)
				recycleBool = ((FetchRandom() < recycleInt) || (FetchRandom() < recycleInt))
			endIf

			if recycleBool
				FMEventHandler.FMImpregnateEvent(akActor as form)
				lastConcept = timeNow
            endIf
        endIf
		recycleInt = 0
	endIf
            
    ; Perform automation for new sperm if enabled
	; fail fast, fail early.   Splitting into 2 checks with the slow random coming only if warranted
	; added check for autoinseminatechance being non-zero
    if (((autoInsemNPC && !isPlayerChar) || (autoInsemPC && isPlayerChar)) && (_autoInseminateChance != 0))
		if (FetchRandom() < _autoInseminateChance)
			if ((Storage.TrackedFathers.Length != 0) && (akActor != pcSpouse))
				; 2.24 move a lot of this to MatchMaker
;				recycleInt = MatchMaker.FindSexPartner(actorIndex, akActor, ((Storage.FemAttached[actorIndex] != 0) && \
;					((GVHolder.SpouseInseminateChance + Storage.Fidelity[actorIndex]) > FetchRandom())))
				; 2.25
;				if (Storage.ATFlags[actorIndex] == -1) || (Storage.FemAttached[actorIndex] == 0)
				recycleInt = MatchMaker.FindSexPartner(actorIndex, akActor, spouseInsemChance, FetchRandom())
;				else
;					recycleInt = MatchMaker.FindSexPartner(actorIndex, akActor, ((spouseInsemChance + Storage.Fidelity[actorIndex]) > FetchRandom()))
;				endIf
				if (recycleInt != -1)
					actor father = Storage.TrackedFathers[recycleInt] as actor
					if (father != none)
						FMEventHandler.FMAddSpermEvent((akActor as form), father.GetDisplayName(), (father as form))
					endIf
				endIf
				recycleInt = 0
			endIf
		endIf
    endIf
            
	; Update existing sperm.  We're generous and do this after the conception check.
	recycleInt = Storage.SpermCount[actorIndex]
    if (!recycleBool && recycleInt)
        if ((timeNow - Storage.LastInsemination[actorIndex]) > spermLifeFloat)
			recycleInt = 0
		else
			; escalating rate of sperm die-off as they age
			recycleInt -= ((4.0 * (timeNow - Storage.LastInsemination[actorIndex])) as int)
		endIf
        if (recycleInt < 1)
            ; too few, clear all spermie-related values.
			recycleInt = 0
			Storage.LastInsemination[actorIndex] = 0.0
			Storage.CurrentFatherForm[actorIndex] = none
			Storage.CurrentFatherRace[actorIndex] = none
        endIf
		Storage.SpermCount[actorIndex] = recycleInt
    endIf
		; Run the pregnancy update check last, just in case the actor conceived during the update
	if recycleBool
		SchdUpdtHlpr.UpdatePregnancy(akActor, actorIndex, timeNow)
	endIf
	; Check for baby growth
	if Storage.BabyAdded[actorIndex] > 0.0
		SchdUpdtHlpr.CheckBabyGrowth(akActor, actorIndex, timeNow, pcSpouse)
	endIf
    Storage.LastGameHours[actorIndex] = timeNow

endFunction

int	function	FetchRandom(int tempInt = 1)
{tries to return a pre-generated random from our array, if that fails generate one}

	; if there's something wrong with the array, GTFO
	if (RandomIntArray.Length != 1024)
		return Utility.RandomInt(0, 99)
	endIf
	if (tempInt == 1)
		; whole lotta nothin going on here
	elseIf (tempInt == 0)
		tempInt = 1
	else
		tempInt = Math.LogicalAnd(tempInt, 0x000001FF)
	endIf
	tempInt = Math.LogicalAnd((_seed + tempInt), 0x000003FF)
	_seed = tempInt
	tempInt = RandomIntArray[tempInt]
	if ((tempInt > -1) && (tempInt < 100))	; paranoid check to ensure our response is in bounds
		return tempInt
	else
		return Utility.RandomInt(0, 99)
	endIf

endFunction

function	RefreshRandoms(int iterations = 20, int replacements = 0)
{when called, re-rolls 20 of the values stored in the random array}

	if RandomIntArray.Length != 1024
		return
	endIf
	replacements = Math.LogicalAnd(_seed, 0x000003FF)
	while (iterations)
		if (replacements > 1023)
			replacements -= 1024
		endIf
		RandomIntArray[replacements] = Utility.RandomInt(0, 99)
		iterations -= 1
		replacements += 1
	endWhile
	_seed = replacements

endFunction

function	PlayerOnlyClear()

	int index
   	; Clear tracking lists of all actors not "related" to the player
   	if isPlayerFemale
   		index = Math.LogicalAnd(Storage.TrackedActors.Length, 0x00000FFF)
   		; Remove all women who are not the player
   		while (index > 0)
   			index -= 1
   			if (Storage.TrackedActors[index] != PlayerRefForm)
   				Storage.TrackedActorRemove(index)
   			endIf
   		endWhile
   	else
   		; The player is male
   		index = Math.LogicalAnd(Storage.TrackedActors.Length, 0x00000FFF)
		while (index > 0)
   			index -= 1
   			; Remove women who are not currently inseminated or pregnant by the
   			; player, and women who have not previously had the player's child.
   			if ((Storage.CurrentFatherForm[index] != playerRefForm) && (Storage.LastFatherForm[index] != playerRefForm))
   				Storage.TrackedActorRemove(index)
   			endIf
   		endWhile
   	endIf
	; 2.08 clear it for both males and felames
	; The player will be added back shortly
	Storage.TrackedFatherClear()

endFunction
