Scriptname	_JSW_SUB_SchdUpdtHlpr	extends		Quest

_JSW_BB_Storage						Property	Storage				Auto	; Storage data helper
_JSW_BB_Utility						Property	Util				Auto	; misc common utilities
_JSW_SUB_EventHandler				Property	FMEventHandler		Auto
_JSW_SUB_ScheduledUpdater			Property	SchedUpdatr			Auto	; the script this one helps

_JSW_SUB_GVHolderScript				Property	GVHolder			Auto	; the script that holds varaibles common to other scripts

_JSW_SUB_AdoptionScript				Property	FMAdoptScript		Auto

GlobalVariable	Property		FMEPresent		Auto			; GV to indicate w234aew's future mod is present

actor			Property		playerRef		Auto			; 

faction			Property		GenericFaction	Auto			; not used by me, probably needed by w234aew

Message			Property		AbortMessage	Auto			; Notification when a pregnancy is aborted

Quest			Property		FMAdoptQuest	Auto			; the adoption quest

;Sound[]			Property		BabyAmused		Auto

; 2.21 convert all sound arrays to formlists
FormList		Property		BabyAmused		Auto			; 
FormList		Property		BabyCry			Auto			;
FormList		Property		BabyGiggle		Auto			; 
FormList		Property		BabyLaugh		Auto			; 
FormList		Property		BabySneeze		Auto			; 
FormList		Property		LaborSound		Auto			; 

;Sound[]			Property		BabyGiggle		Auto
;Sound[]			Property		BabyLaugh		Auto
;Sound[]			Property		BabySneeze		Auto
;Sound[]			Property		LaborSound		Auto

Spell			Property		w234aew01		Auto			; 3 new blank spells in my ESP
Spell			Property		w234aew02		Auto
Spell			Property		w234aew03		Auto

;	script variables
int		_pregnancyDuration
int		_trimesterDuration = 4
string	_playerName

; Event lock codes
int _eventNone = 0
;int _eventLabor = 1
int _eventSpawn = 2

event	OnInit()

	_playerName = PlayerRef.GetDisplayName()
	_pregnancyDuration = GVHolder.PregnancyDuration
	if (Storage as quest).IsRunning()
		_trimesterDuration = Storage.FMValues[0]
	endIf
	if (FMEPresent.GetValue() == 1.0)
		GoToState("FMEUpdatePath")
	else
		GoToState("")
	endIf

endEvent

bool	function	UpdateOvulationStatus(int actorIndex, int birthDay,  float now)
{Updates the current egg status for the given actor}

	; profiling at usually 0ms, occasionally 7msec
	; split from Util script.   Generic-for-every-actor stuff in here, player-only stuff stays there
	int cycleDay = Storage.DayOfCycle[actorIndex]
    float ovulLast = Storage.LastOvulation[actorIndex]
	; 1.57 first bool to determine if status changed aka faction needs to change
	bool startOvul = (ovulLast != 0.0)
	; new for 1.2, first check first: if menstruating comes first and overrides all other
    if (cycleDay < GVHolder.OvulationBegin)
        Storage.LastInsemination[actorIndex] = 0.0
        Storage.SpermCount[actorIndex] = 0
		; Clear ovulation status, the actor is menstruating. maybe.  Ok, it might be an early day of the cycle- which we still track-
		; and they're pregnant...
        if (Storage.LastConception[actorIndex] == 0.0)	; ...and if they're NOT pregnant, remove daddy issues
			Storage.LastFatherForm[actorIndex] = none
			Storage.CurrentFatherForm[actorIndex] = none
        endIf
        ovulLast = 0.0									
    elseIf startOvul
        ; Add time to the egg's lifespan. It dies after N days
		; new for 1.2, clear ovulation if it somehow happened during recovery period
        ovulLast += (now - Storage.LastGameHours[actorIndex])
        if (ovulLast > GVHolder.EggLife) || (Storage.TimesDelivered[actorIndex] && (birthDay < GVHolder.RecoveryDuration))
            ovulLast = 0.0
        endif
		; 1.59 added check for OvulationBlock
    elseIf ((Storage.OvulationBlock[actorIndex] == 0) && (Storage.LastConception[actorIndex] == 0.0) && \
	((cycleDay + 2) > Storage.FMValues[1]) && (cycleDay < (Storage.FMValues[1] + 2)))
		; 1.56 increase this to help people with iNeed or similar mods that require them to sleep
		; 1.56 re-use birthDay instead of declaring new variable
		birthDay = 3				; 2% chance each actor update cycle
		if (cycleDay > Storage.FMValues[1])
			birthDay *= 3				; tripled day after ovulation due
		elseIf ((cycleDay + 1) > Storage.FMValues[1])
			birthDay *= 2				; doubled on day of ovulation
		endIf
		if (SchedUpdatr.FetchRandom(cycleDay) < birthDay)	;/ throw some variance at the cycle, most women aren't clocks!
												 she may even miss ovulating occasionally- but factors such
												 as stress can cause this- and what's more stressful than 
												 FUCKING DRAGONS HAVE RETURNED!!!
												 right now, there's a chance of it happening on days 9, 10 or 11
												 for the 14, 21, 28 day cycles: 2% chance per hour, 5% for 7 day /;
			ovulLast = 0.001
			Storage.Ovulationblock[actorIndex] = 1
			if GVHolder.VerboseMode
				Debug.Notification((Storage.TrackedActors[actorIndex] as actor).GetDisplayName() + " has ovulated.")
			endIf
		endIf
    endIf
	Storage.LastOvulation[actorIndex] = ovulLast
	; new 1.57 is faction update needed?
	if (startOvul == (ovulLast == 0.0))
		Util.UpdateNPCFactions(none, actorIndex)
	endIf
	return (ovulLast != 0.0)

endFunction

state	FMEUpdatePath

	function	UpdatePregnancy(Actor akActor, int actorIndex, float now, int pregnantDay = 0)
		{Update or complete the current pregnancy}
	
		;	profiling shows this function at 11-45ms.
		; update: 0-33ms after pseudo-random RNG
		
		pregnantDay = (now - Storage.LastConception[actorIndex]) as int
		if (pregnantDay >= 0)
			if akActor.is3DLoaded()
				akActor.AddSpell(w234aew01)
				akActor.AddSpell(w234aew02)
			endIf
			; ok, order of operations.   We have to check for miscarriage first
			if (akActor == PlayerRef)
				if GVHolder.MiscarriageEnabled
				; when loading a save, the time difference can sometimes show extreme values, so cap them
					Storage.BabyHealth -= Math.LogicalAnd((now - Storage.LastSleep) as int, 0x00000007)
					; because I'm a prick.  Each day without sleep increases the health
					; penalty.   Miscarriage occurs ~10 hours into day 4 w/o sleep
					if (Storage.BabyHealth < 1)
						; Remove all pregnancy metrics for an abortion/miscarriage
						int handle = ModEvent.Create("FertilityModeAbort")
						if handle
							ModEvent.PushForm(handle, PlayerRef as form)
							ModEvent.Send(handle)
						endIf
						pregnantDay = 0	; update this so the "going into labor" check below doesn't happen
						AbortMessage.Show()
					endIf
				endIf
			endIf
	
			if (pregnantDay > (_pregnancyDuration - 2))
				if (akActor == PlayerRef)
					; Play a random labor sound, starting day before "due date"
;					Sound.SetInstanceVolume(LaborSound[Utility.RandomInt(0, LaborSound.Length - 1)].Play(akActor), GVHolder.SoundVolume)
; 2.21 change from array to formlias
					Sound.SetInstanceVolume((LaborSound.GetAt(Utility.RandomInt(0, LaborSound.GetSize() - 1)) as sound).Play(akActor), GVHolder.SoundVolume)
				endIf
				; split this up into non-exclusive checks instead of an elseIf
				; I don't think "going into labor" and "labor sounds" should 
				; be mutually exclusive
	
				; add an escalating chance of labor, starting the day before the "due date"
				; recycle pregnantDay to be % chance of labor
				if (pregnantDay > _pregnancyDuration)
					pregnantDay = 10
				elseIf (pregnantDay == _pregnancyDuration)
					pregnantDay = 3
				else
					pregnantDay = 1
				endIf
				if (SchedUpdatr.FetchRandom(pregnantDay) < pregnantDay)
					FMEventHandler.FMLaborEvent("", akActor as form, actorIndex)
				endIf
			endIf
		endIf
		; 2.16 don't do event firing to avoid stack dumping
		Storage.LastInsemination[actorIndex] = 0.0
		Storage.SpermCount[actorIndex] = 0
		Storage.LastOvulation[actorIndex] = 0.0
	
;/		pregnantDay = ModEvent.Create("FertilityModeSpermRemoval")
		ModEvent.PushForm(pregnantDay, akActor as form)
		ModEvent.Send(pregnantDay)/;
	
	endFunction

	function    UpdateRecovery(Actor akActor, int actorIndex, float now)
		if akActor.is3DLoaded() || akActor == PlayerRef
			akActor.AddSpell(w234aew01)
			akActor.AddSpell(w234aew02)
		endIf
	endFunction

endState

function	UpdatePregnancy(Actor akActor, int actorIndex, float now, int pregnantDay = 0)
{Update or complete the current pregnancy}

;	profiling shows this function at 11-45ms.
; update: 0-33ms after pseudo-random RNG

    pregnantDay = (now - Storage.LastConception[actorIndex]) as int
	if (pregnantDay > 1)
		if (pregnantDay < (_trimesterDuration + 1))
			; do nothing, but skips the lower, slower checks
		elseIf (pregnantDay < (_trimesterDuration * 2 + 1))
			; Second trimester, play limited kicks (5%)
			if (SchedUpdatr.FetchRandom(pregnantDay) < 5)
				if (akActor == PlayerRef)
					Debug.Notification("You feel your baby kicking")
					; 2.21
;					Sound.SetInstanceVolume(LaborSound[0].Play(akActor), GVHolder.SoundVolume)
					Sound.SetInstanceVolume((LaborSound.GetAt(0) as sound).Play(akActor), GVHolder.SoundVolume)
				elseIf (akActor.Is3DLoaded() && (akActor.GetDistance(PlayerRef) < 512.0))
					Debug.Notification("It sounds like " + akActor.GetDisplayName() + "'s baby is kicking")
					; 2.21
;					Sound.SetInstanceVolume(LaborSound[0].Play(akActor), ((GVHolder.SoundVolume / 2.0) - (akActor.GetDistance(PlayerRef) / 1000.0)))
					Sound.SetInstanceVolume((LaborSound.GetAt(0) as sound).Play(akActor), ((GVHolder.SoundVolume / 2.0) - (akActor.GetDistance(PlayerRef) / 1000.0)))
				endIf
			endIf
		elseIf (SchedUpdatr.FetchRandom(pregnantDay) < 15)
			; Third trimester, play more frequent kicks (15%)
			if (akActor == PlayerRef)
				Debug.Notification("You feel your baby kicking")
				; 2.21
;				Sound.SetInstanceVolume(LaborSound[0].Play(akActor), GVHolder.SoundVolume)
				Sound.SetInstanceVolume((LaborSound.GetAt(0) as sound).Play(akActor), GVHolder.SoundVolume)
			elseIf (akActor.Is3DLoaded() && (akActor.GetDistance(PlayerRef) < 512.0))
				Debug.Notification("It sounds like " + akActor.GetDisplayName() + "'s baby is kicking")
				; 2.21
;				Sound.SetInstanceVolume(LaborSound[0].Play(akActor), ((GVHolder.SoundVolume / 2.0) - (akActor.GetDistance(PlayerRef) / 1000.0)))
				Sound.SetInstanceVolume((LaborSound.GetAt(0) as sound).Play(akActor), ((GVHolder.SoundVolume / 2.0) - (akActor.GetDistance(PlayerRef) / 1000.0)))
			endIf
		endIf
    
		; ok, order of operations.   We have to check for miscarriage first
		if (akActor == PlayerRef)
			if GVHolder.MiscarriageEnabled
			; when loading a save, the time difference can sometimes show extreme values, so cap them
				Storage.BabyHealth -= Math.LogicalAnd((now - Storage.LastSleep) as int, 0x00000007)
				; because I'm a prick.  Each day without sleep increases the health
				; penalty.   Miscarriage occurs ~10 hours into day 4 w/o sleep
				if (Storage.BabyHealth < 1)
					; Remove all pregnancy metrics for an abortion/miscarriage
					int handle = ModEvent.Create("FertilityModeAbort")
					if handle
						ModEvent.PushForm(handle, PlayerRef as form)
						ModEvent.Send(handle)
					endIf
					pregnantDay = 0	; update this so the "going into labor" check below doesn't happen
					AbortMessage.Show()
				endIf
			endIf
		endIf

		if (pregnantDay > (_pregnancyDuration - 2))
			if (akActor == PlayerRef)
				; Play a random labor sound, starting day before "due date"
				; 2.21
;				Sound.SetInstanceVolume(LaborSound[Utility.RandomInt(0, LaborSound.Length - 1)].Play(akActor), GVHolder.SoundVolume)
				Sound.SetInstanceVolume((LaborSound.GetAt(Utility.RandomInt(0, LaborSound.GetSize() - 1)) as sound).Play(akActor), GVHolder.SoundVolume)
			endIf
			; split this up into non-exclusive checks instead of an elseIf
			; I don't think "going into labor" and "labor sounds" should 
			; be mutually exclusive

			; add an escalating chance of labor, starting the day before the "due date"
			; recycle pregnantDay to be % chance of labor
			if (pregnantDay > _pregnancyDuration)
				pregnantDay = 10
			elseIf (pregnantDay == _pregnancyDuration)
				pregnantDay = 3
			else
				pregnantDay = 1
			endIf
			if (SchedUpdatr.FetchRandom(pregnantDay) < pregnantDay)
				FMEventHandler.FMLaborEvent("", akActor as form, actorIndex)
			endIf
		endIf
	endIf
	; 2.16 don't do event firing to avoid stack dumping
	Storage.LastInsemination[actorIndex] = 0.0
	Storage.SpermCount[actorIndex] = 0
	Storage.LastOvulation[actorIndex] = 0.0

;/	pregnantDay = ModEvent.Create("FertilityModeSpermRemoval")
	ModEvent.PushForm(pregnantDay, akActor as form)
	ModEvent.Send(pregnantDay)/;

endFunction

function    UpdateRecovery(Actor akActor, int actorIndex, float now)
endFunction

function	CheckBabyGrowth(Actor akActor, int actorIndex, float now, actor pcSpouse)
{Apply baby spawn or removal checks for the PC and NPCs}
    if (Storage.EventLock[actorIndex] != _eventNone)
        return
    endIf
    
    Storage.EventLock[actorIndex] = _eventSpawn
    int recycleInt = Math.LogicalAnd(Storage.BirthBabyRace.Length, 0x0000007F)
    Armor baby = none
    ; Potential bug: this algorithm finds the first baby item in the
    ; actor's inventory. If the actor was given or has stolen a baby
    ; then there could be an unexpected count and/or unexpected race
    while (recycleInt > 0) && (baby == none)
        recycleInt -= 1
        
        if (akActor.GetItemCount(Storage.BirthBabyRace[recycleInt]) > 0)
            baby = Storage.BirthBabyRace[recycleInt] as armor
        endIf
    endWhile
	; 2.20
	bool timeToGrowUp = ((now - Storage.BabyAdded[actorIndex]) > GVHolder.BabyDuration)
	bool grewUp = false
; 2.18
	form child = none
	; 2.20
	if baby && timeToGrowUp && (Storage.UniqueMothers.Length > 0) && (Storage.UniqueMothers.Find(akActor as form) != -1)
		child = Util.CheckDefinedChild(akActor as form, actorIndex)
;		debug.trace("FM+: found defined child " + child + " for mother " + akActor.GetDisplayName())
	endIf

	if child
		grewUp = true
		Storage.ChildrenSpawned = Utility.ResizeFormArray(Storage.ChildrenSpawned, Math.LogicalAnd((Storage.ChildrenSpawned.Length + 1), 0x00000FF), child)
		Storage.LastFatherForm[actorIndex] = none
		(akActor as objectReference).PlaceAtMe(child, 1, false, false)
;		debug.trace("FM+: tried to spawn child " + child)
	endIf

    if !grewUp && ((akActor == PlayerRef) || (Storage.LastFatherForm[actorIndex] == playerRef as form) || (akActor == pcSpouse))
        ; Attempt to spawn one of the player's children
        if (baby && timeToGrowUp)
        	bool spawned = false

			FMAdoptQuest.SetCurrentStageID(10)
        	if GVHolder.AdoptionEnabled
        		child = FMAdoptScript.TrySpawnChildAdopt(akActor) as form
	            
	            if (child)
					grewUp = true
;	                Storage.LastFather[actorIndex] = ""
					; 2.08
					Storage.LastFatherForm[actorIndex] = none
	                Storage.BabyHealth = 105
	                FMAdoptScript.RenameChild(child as actor)
	                spawned = true
	            endIf
			elseIf !GVHolder.TrainingEnabled
				int raceIndex = Storage.GetRaceIndex(akActor, actorIndex)
				ActorBase childBase = Storage.Children[2 * raceIndex + ((SchedUpdatr.FetchRandom() < 50) as int)] as actorbase
				
				; Match hair color to the parent
				childBase.SetHairColor(akActor.GetActorBase().GetHairColor())
				
				child = PlayerRef.PlaceActorAtMe(childBase) as form
				FMAdoptScript.RenameChild(child as actor)
				grewUp = true
;				Storage.LastFather[actorIndex] = ""
				; 2.08
				Storage.LastFatherForm[actorIndex] = none
				Storage.BabyHealth = 105
				spawned = true
				
				Debug.Notification((child as objectreference).GetDisplayName() + " fled to Whiterun")
        	endIf
        	
        	if (!spawned && GVHolder.TrainingEnabled)
                
			    string kidName = "son"
			    recycleInt = (SchedUpdatr.FetchRandom() < 50) as int
			    if (recycleInt == 1)
			        kidName = "daughter"
			    endIf
			    ;kidName = "evil spawn of Satan:"
			    kidName = FMAdoptScript.GenerateName("Name your " + kidName)
			    
			    Storage.PlayerChildAdd(akActor, kidName, recycleInt)
			    Debug.Notification(kidName + " can now be summoned from the MCM")
				grewUp = true
;                Storage.LastFather[actorIndex] = ""
				; 2.08
				Storage.LastFatherForm[actorIndex] = none
                Storage.BabyHealth = 105
        	endIf
;			FMAdoptQuest.SetCurrentStageID(20)
        endIf
    endIf

	if grewUp || (baby && timeToGrowUp)
        akActor.RemoveItem(baby, 1)
        Storage.BabyAdded[actorIndex] = 0.0
	endIf
    Storage.EventLock[actorIndex] = _eventNone

endfunction

function	PlayBabySound(Actor akActor)
{Conditionally play a baby sound in suitable situations}

    if (akActor.IsInCombat())
        return
    endIf
	; weatherClass definitions, used lower
;	int _weatherPleasant	=	0	; const
;	int _weatherCloudy		=	1	; const - currently unused
;	int _weatherRainy		=	2	; const
;	int _weatherSnow		=	3	; const


    Weather currentWeather = Weather.GetCurrentWeather()
    
    if (currentWeather == none || (SchedUpdatr.FetchRandom() < 34))
        return
    endIf

    int weatherClass = currentWeather.GetClassification()

	if (weatherClass == 1)
	elseIf (weatherClass == 0)
        ; 50% between laughing and giggling; there *is* a difference
        if (SchedUpdatr.FetchRandom() < 50) && (BabyLaugh.GetSize() > 0)
            Sound.SetInstanceVolume((BabyLaugh.GetAt(Utility.RandomInt(0, BabyLaugh.GetSize() - 1)) as sound).Play(akActor), GVHolder.SoundVolume)
        elseIf (BabyGiggle.GetSize() > 0)
            Sound.SetInstanceVolume((BabyGiggle.GetAt(Utility.RandomInt(0, BabyGiggle.GetSize() - 1)) as sound).Play(akActor), GVHolder.SoundVolume)
        endIf
    elseIf (weatherClass == 2) && (BabyCry.GetSize() > 0)
        Sound.SetInstanceVolume((BabyCry.GetAt(Utility.RandomInt(0, BabyCry.GetSize() - 1))as Sound).Play(akActor), GVHolder.SoundVolume)
    elseIf (weatherClass == 3)
        ; 30% sneeze versus amusement at the snow
        if (SchedUpdatr.FetchRandom() < 70) && (BabyAmused.GetSize() > 0)
            Sound.SetInstanceVolume((BabyAmused.GetAt(Utility.RandomInt(0, BabyAmused.GetSize() - 1)) as sound).Play(akActor), GVHolder.SoundVolume)
        elseIf (BabySneeze.GetSize() > 0)
            Sound.SetInstanceVolume((BabySneeze.GetAt(Utility.RandomInt(0, BabySneeze.GetSize() - 1)) as sound).Play(akActor), GVHolder.SoundVolume)
        endIf
    endIf

endFunction
