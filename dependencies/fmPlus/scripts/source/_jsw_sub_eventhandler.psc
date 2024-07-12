Scriptname	_JSW_SUB_EventHandler	extends	Quest
; This script will handle miscellaneous "little" events

_JSW_BB_Utility				Property	Util				Auto	; Independent helper functions
_JSW_SUB_ScheduledUpdater	Property	ScheduledUpdater	Auto
_JSW_BB_Storage				Property	Storage				Auto	; Storage data helper

_JSW_SUB_GVHolderScript		Property	GVHolder			Auto	;

Actor				Property	PlayerRef					Auto	; Reference to the player. Game.GetPlayer() is slow

Keyword				Property	ActorTypeNPC				Auto	; Only NPC tagged actors can be tracked
Keyword				Property	ActorTypeCreature			Auto	; Keyword for identifying creature types

function EventHandlerUnregister()

	UnregisterForAllModEvents()

endFunction

bool function FMReregisterEvents()

    RegisterForModEvent("FertilityModeAddSperm", "FMAddSpermEvent")
    RegisterForModEvent("FMPlusConception", "FMConceptionEvent")
    RegisterForModEvent("FertilityModeImpregnate", "FMImpregnateEvent")
    RegisterForModEvent("FMPlusLabor", "FMLaborEvent")
    RegisterForModEvent("FertilityModeModSperm", "FMModSpermEvent")
	; 2.20
	RegisterForModEvent("FMPlusBlockOvulation", "FMBlockOvulationEvent")
	RegisterForModEvent("FMPlusUnblockOvulation", "FMUnblockOvulationEvent")
	return true

endfunction

event FMAddSpermEvent(Form akTarget = none, string fatherName = "", form father = none)
{Mod handler for insemination requests}

    RegisterForModEvent("FertilityModeAddSperm", "FMAddSpermEvent")
	if (!akTarget || !GVHolder.Enabled || ((fatherName == "") && !father))
        return
    endIf
	int index = Storage.TrackedActors.Find(akTarget)
	bool femaleTarget = (Util.GetActorGender(akTarget as actor) == 1)
	if (femaleTarget && (index == -1))
		Util.AddToTracking(akTarget as actor, 1)	; if female and not tracked, try to track them
		index = Storage.TrackedActors.Find(akTarget)
	endIf

	;/	lots of changes for 1.42 related to gender.   We don't track M-M events or
		male-creature events, and probably never will, but the message that it occurred
		will now be displayed.   I don't know if this was never allowed in FM or if I
		accidentally broke it in an earlier version, but either way the message is enabled now/;

    int maleIndex = -1
	; 1.56 added direct name lookup if we have the father actor info
	if father
		fatherName = (father as actor).GetDisplayName()
		maleIndex = Storage.TrackedFathers.Find(father)
	endIf
	;/	1.43 added check for empty or unknown fatherName.  It may look
		redundant, but I want maleindex to be -1 for "unknown" fathers /;
	if ((fatherName == "") || (fatherName == "Unknown"))
		fatherName = "Unknown"
	endIf

	float recycleFloat = 0.0
	if (maleIndex != -1)
		; 1.57 only do this if the index is a valid array index
		recycleFloat = Storage.RefractoryPeriod[maleIndex] as float
	endIf
	int newSperm = (ScheduledUpdater.FetchRandom() + ScheduledUpdater.FetchRandom() + ScheduledUpdater.FetchRandom())
	if (maleIndex != -1)
		int _refractoryPeriod = Storage.FMValues[11]
		if (recycleFloat != 0.0)
			newSperm = ((newSperm * (_refractoryPeriod as float + 1.0 - recycleFloat) / (_refractoryPeriod + 1)) as int) as int
			recycleFloat = 0.0
		endIf
		Storage.RefractoryPeriod[maleIndex] = _refractoryPeriod
	endIf
	if (femaleTarget && (index != -1))
		if father && (Storage.CurrentFatherForm[index] == father)
			; above recycleFloat is male's refractory period, below currentgametime
;			recycleFloat = Utility.GetCurrentGameTime()
			recycleFloat = GVHolder.GVGameDaysPassed.GetValue()
			; 1.42 if sperm is on last day of life, replace old with new
			if ((recycleFloat - Storage.LastInsemination[index]) > (GVHolder.SpermLife - 1))
				Storage.LastInsemination[index] = recycleFloat
				Storage.SpermCount[index] = newSperm
			else
				; 1.42 ..... otherwise, add new to old but do NOT update the time
				Storage.SpermCount[index] = (Storage.SpermCount[index] + newSperm)
			endIf
		elseIf (Storage.SpermCount[index] < newSperm)
			Storage.SpermCount[index] = newSperm
			Storage.LastInsemination[index] = GVHolder.GVGameDaysPassed.GetValue()
			if (Storage.LastConception[index] == 0.0) && father
				; 1.56 only try to update raceindex if we have actor info
				Storage.CurrentFatherForm[index] = father
				race fatherRace = (father as actor).GetRace()
				; 1.47 added check for NPC keyword to prevent "weird" child races
				;2.08 both in one, flag playable
				if fatherRace && fatherRace.IsRaceFlagSet(0x00000001)
				;!fatherRace.HasKeyword(ActorTypeCreature) && fatherRace.HasKeyword(ActorTypeNPC)
					; 2.15
					Storage.CurrentFatherRace[index] = fatherRace as form
;					Storage.FatherRaceId[index] = fatherRace.GetFormID()
				else
					; 2.15
;					Storage.FatherRaceID[index] = -1
					Storage.CurrentFatherRace[index] = none
				endIf
			else
				; 2.15
;				Storage.FatherRaceID[index] = -1
				Storage.CurrentFatherRace[index] = none
			endIf
		endIf
	endIf
	; new 1.42, only update widget if appropriate
	if (akTarget == PlayerRef as form)
		ModEvent.Send(ModEvent.Create("FMPUpdateWidgetContent"))
	endIf
	if GVHolder.VerboseMode
		Debug.Notification(fatherName + " came inside " + (akTarget as actor).GetDisplayName() + " " + newSperm as int)
	endIf
endEvent

event FMConceptionEvent(string EventName = "", Form akSender, string motherName, string fatherName, int iTrackingIndex)
{Stub for if I ever want to handle this event}
endEvent

event FMLaborEvent(string eventName = "", Form targetActor, int actorIndex = -1)
{applies labor spell to target actor}

    RegisterForModEvent("FMPlusLabor", "FMLaborEvent")
	if (!targetActor && (actorIndex == -1))
		return
	elseIf !targetActor
		targetActor = Storage.TrackedActors[actorIndex]
	else
		actorIndex = Storage.TrackedActors.Find(targetActor)
	endIf
	if (!targetActor || (actorIndex == -1))
		return
	endIf
	bool ready = false
	int index = 6
	while (!ready && (index > 0))
		index -= 1
		ready = (Storage.LaborRefs[index].GetReference() == none)
	endWhile
	if !ready
		return
	endIf
	Storage.LaborRefs[index].ForceRefTo(targetActor as actor)
	; 2.12 use the LaborRefs[x].GetOwningQuest
;	Storage.LaborQuests[index].SetCurrentStageID(10)
;	if (Storage.LaborQuests[index]).IsRunning()
	Storage.LaborRefs[index].GetOwningQuest().SetCurrentStageID(10)
	if Storage.LaborRefs[index].GetOwningQuest().IsRunning()
		if GVHolder.VerboseMode
			Debug.Notification((targetActor as actor).GetDisplayName() + " is giving birth")
		endIf
	endIf

endEvent

event FMModSpermEvent(Form akTarget = none, int amount)
{blindly processed handler for external add sperm requests}

    RegisterForModEvent("FertilityModeModSperm", "FMModSpermEvent")
	if (!akTarget || !GVHolder.Enabled)
		return
	endIf
	Actor kActor = akTarget as Actor
	int recycleInt = Util.GetActorGender(kActor)
	; 1.43 fix bad logic
	if (recycleInt != 1)
		return	; target is not female
	else
		Util.AddToTracking(kActor, recycleInt)
		; above this, recycleInt is gender, below is the array index
		recycleInt = Storage.TrackedActors.Find(akTarget)
	endIf
	
    if (recycleInt != -1)	; check if actor is female and tracked
		; 1.42 prevent overflow to negative value.  Edit: overflow can be quite literal in this case
        Storage.SpermCount[recycleInt] = Math.LogicalAnd((Storage.SpermCount[recycleInt] + amount), 0x7FFFFFFF)
		if (kActor == PlayerRef)
			ModEvent.Send(ModEvent.Create("FMPUpdateWidgetContent"))
		endIf
    endIf
endEvent

event FMImpregnateEvent(Form akTarget)
{Mod handler for external impregnation requests}

    RegisterForModEvent("FertilityModeImpregnate", "FMImpregnateEvent")
    Actor kActor = akTarget as Actor
    if (!kActor || !GVHolder.Enabled)
        return
    endIf

	int recycleInt = Storage.TrackedActors.Find(akTarget)
	; 1.56
	if (recycleInt == -1) || (Storage.SpermCount[recycleInt] == 0) || (Storage.LastConception[recycleInt] != 0.0)
		return	; is not tracked and cannot be tracked, no sperm, or is already pregnant
	endIf
	Storage.LastConception[recycleInt] = GVHolder.GVGameDaysPassed.GetValue()
	; 1.56 clear sperm and ovulation-related values
	Storage.LastInsemination[recycleInt] = 0.0
	Storage.SpermCount[recycleInt] = 0
	Storage.LastOvulation[recycleInt] = 0.0
	if (kActor == PlayerRef)
		; 1.56 whoops!  update lastsleep and babyhealth!
		; 1.57 set max babyhealth to 105
		Storage.BabyHealth = 105
		Storage.LastSleep = Storage.LastConception[recycleInt]
		ModEvent.Send(ModEvent.Create("FMPUpdateWidgetContent"))
	endIf
	; 1.57 update faction for tracked actor
	Util.UpdateNPCFactions(kActor, recycleInt)
	if GVHolder.VerboseMode
		Debug.Notification(kActor.GetDisplayName() + " is pregnant by " + (Storage.CurrentFatherForm[recycleInt] as actor).GetDisplayName() + "!")
	endIf
	; informs FA, or any other listening mod, of the event
	Util.SendDetailedTrackingEvent("FertilityModeConception", akTarget, kActor.GetDisplayName(), (Storage.CurrentFatherForm[recycleInt] as actor).GetDisplayName(), recycleInt)
endEvent

event	FMBlockOvulationEvent(form her)

	int index = Storage.TrackedActors.Find(her)
	if index == -1
		return
	endIf
	Storage.LastOvulation[index] = 0.0
	Storage.OvulationBlock[index] = 9999

endEvent

event	FMUnblockOvulationEvent(form her)

	int index = Storage.TrackedActors.Find(her)
	if index == -1
		return
	endIf
	Storage.OvulationBlock[index] = 0

endEvent
