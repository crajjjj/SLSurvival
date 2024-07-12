Scriptname _JSW_BB_Utility extends Quest

_JSW_BB_Storage				Property	Storage				Auto	; Storage data helper
_JSW_SUB_GVHolderScript		Property	GVHolder			Auto	;
; 2.14
_JSW_SUB_MiscUtilQuest		Property	FMMiscUtil			Auto	; 

Actor				Property	PlayerRef					Auto	; Reference to the player. Game.GetPlayer() is slow

Faction				Property	GenericFaction				Auto	; faction for pregnant NPCs

Keyword				Property	ActorTypeNPC				Auto	; Only NPC tagged actors can be tracked
Keyword				Property	ActorTypeCreature			Auto	; Keyword for identifying creature types

int			forceGender
int			scalingMethod
bool		uniqueMenOnly
bool		uniqueWomenOnly

function UtilUnregister()

	GoToState("")
	UnregisterForAllModEvents()

endFunction

bool function StartUpFunction()
{called by OnInit and OnPlayerLoadGame}

	RegisterForModEvent("FMUtilityCacheVars", "FMUtilCacheVariables")
	FMUtilCacheVariables()
	return true

endFunction

event FMUtilCacheVariables()

	forceGender		=	GVHolder.ForceGender
	scalingMethod	=	GVHolder.ScalingMethod
	uniqueMenOnly	=	GVHolder.UniqueMenOnly
	uniqueWomenOnly	=	GVHolder.UniqueWomenOnly

	UpdateScaleMethod()

endEvent

function UpdateScaleMethod()

	if ((scalingMethod == 3) && (Storage.FMValues[4] == 0))
		scalingMethod = 0
		GVHolder.ScalingMethod = scalingMethod
		GVHolder.UpdateGVs()
	endIf
	GoToState("MyState" + scalingMethod)

endFunction

; new 1.43 - consolidated AddActor and AddFather into one function
function AddToTracking(Actor akActor, int actorGender = -1, string locName = "", location where = none)
{Add a new character to the tracking list}

    if !akActor
        return	; invalid actor
    endIf
	if (actorGender == -1)
		if akActor == playerRef
			actorGender = GetActorGender(akActor)
		else
			actorGender = akActor.GetLeveledActorBase().GetSex()
		endIf
	endIf
	if !((actorGender == 0) || (actorGender == 1))
		return	; only continue for allowed genders
	endIf

	if actorGender
		if (Storage.TrackedActors.Find(akActor as form) != -1)
			return	; is female and already tracked
		endIf
	elseif (Storage.TrackedFathers.Find(akActor as form) != -1)
		return		; is male or male creature and already tracked
	endIf

	race actorRace = akActor.GetRace()
	String actorName = akActor.GetDisplayName()
	if (!actorRace || !actorName)
		return	; if we can't figure out name or race, going further is pointless
	endIf

; 2.12 this has been filtered via ME conditions for a while now.
;		Storage.RaceBlacklist.Find(actorRace)	==	-1 && \
;/    if (Storage.ActorBlackList.Find(akActor)	==	-1 && Storage.BlackListByName.Find(actorName)	==	-1 && \
        !akActor.IsDead() && !akActor.IsChild() && !akActor.IsGhost() && (actorRace.HasKeyword(ActorTypeNPC) || \
		((actorGender == 0) && (GVHolder.AllowCreatures && actorRace.HasKeyword(ActorTypeCreature)))))/;
	; 2.24 we already know the race, so faster IsRaceFlagSet() vs IsChild()
    if (Storage.ActorBlackList.Find(akActor)	==	-1 && Storage.BlackListByName.Find(actorName)	==	-1 && \
        !akActor.IsDead() && !actorRace.IsRaceFlagSet(0x04) && !akActor.IsGhost() && (actorRace.HasKeyword(ActorTypeNPC) || \
		((actorGender == 0) && (GVHolder.AllowCreatures && actorRace.HasKeyword(ActorTypeCreature)))))

		if actorGender
			if (!uniqueWomenOnly || akActor.GetLeveledActorBase().IsUnique())
				Storage.TrackedActorAdd(akActor, locName, where, -2, none)
			endIf
		elseIf (!uniqueMenOnly || akActor.GetLeveledActorBase().IsUnique())
			Storage.TrackedFatherAdd(akActor, locName, where, -2, none)
		endIf
    endIf
endFunction

function ClearBellyBreastScale(Actor akActor)
endFunction
function SLIFMorph(Actor akActor, string morphName, float scale, bool reset = false)
endFunction

State MyState0

	function ClearBellyBreastScale(Actor akActor)
	{Helper function for clearing the specified actor's belly/breast scaling with the current method}

		; 1.55 added none actor check
		if !akActor
			return
		endIf
		NiOverride.ClearBodyMorph(akActor, "PregnancyBelly", "Fertility Mode")
		NiOverride.ClearBodyMorph(akActor, "BreastsSH", "Fertility Mode")
		NiOverride.ClearBodyMorph(akActor, "BreastsNewSH", "Fertility Mode")
		NiOverride.UpdateModelWeight(akActor)
	endFunction

endState

State MyState1

	function ClearBellyBreastScale(Actor akActor)
	{Helper function for clearing the specified actor's belly/breast scaling with the current method}

		; 1.55 added none actor check
		if !akActor
			return
		endIf
		; NetImmerse
		NetImmerse.SetNodeScale(akActor, "NPC Belly", 1.0, false)
		NetImmerse.SetNodeScale(akActor, "NPC Belly", 1.0, true)
		NetImmerse.SetNodeScale(akActor, "NPC L Breast", 1.0, false)
		NetImmerse.SetNodeScale(akActor, "NPC L Breast", 1.0, true)
		NetImmerse.SetNodeScale(akActor, "NPC R Breast", 1.0, false)
		NetImmerse.SetNodeScale(akActor, "NPC R Breast", 1.0, true)
	endFunction

endState

State MyState2

	function ClearBellyBreastScale(Actor akActor)
	{Helper function for clearing the specified actor's belly/breast scaling with the current method}

		; 1.55 added none actor check
		if !akActor
			return
		endIf
		; NiOverride
		NiOverride.RemoveNodeTransformScale(akActor, false, true, "NPC Belly", "Fertility Mode")
		NiOverride.RemoveNodeTransformScale(akActor, true, true, "NPC Belly", "Fertility Mode")
		NiOverride.RemoveNodeTransformScale(akActor, false, true, "NPC L Breast", "Fertility Mode")
		NiOverride.RemoveNodeTransformScale(akActor, true, true, "NPC L Breast", "Fertility Mode")
		NiOverride.RemoveNodeTransformScale(akActor, false, true, "NPC R Breast", "Fertility Mode")
		NiOverride.RemoveNodeTransformScale(akActor, true, true, "NPC R Breast", "Fertility Mode")
		NiOverride.UpdateNodeTransform(akActor, false, true, "NPC Belly")
		NiOverride.UpdateNodeTransform(akActor, true, true, "NPC Belly")
		NiOverride.UpdateNodeTransform(akActor, false, true, "NPC L Breast")
		NiOverride.UpdateNodeTransform(akActor, true, true, "NPC L Breast")
		NiOverride.UpdateNodeTransform(akActor, false, true, "NPC R Breast")
		NiOverride.UpdateNodeTransform(akActor, true, true, "NPC R Breast")
	endFunction

endState

state MyState3

	function ClearBellyBreastScale(Actor akActor)
	{Helper function for clearing the specified actor's belly/breast scaling with the current method}

		; 1.55 added none actor check
		if !akActor
			return
		endIf
		; SexLab Inflation Framework
		SLIFMorph(akActor, "PregnancyBelly", 0.0, true)
		SLIFMorph(akActor, "BreastsSH", 0.0, true)
		SLIFMorph(akActor, "BreastsNewSH", 0.0, true)
	endFunction

	function SLIFMorph(Actor akActor, string morphName, float scale, bool reset = false)
	{Helper function for scaling morphs through SLIF}

		int handle = 0
		if !reset
			handle = ModEvent.Create("SLIF_morph")
			if handle
				ModEvent.PushForm(handle, akActor as form)
				ModEvent.PushString(handle, "Fertility Mode")
				ModEvent.PushString(handle, morphName)
				ModEvent.PushFloat(handle, scale)
				ModEvent.PushString(handle, "Fertility Mode.esm")
				ModEvent.Send(handle)
			endIf
		else
			handle = ModEvent.Create("SLIF_unregisterMorph")
			if handle
				ModEvent.PushForm(handle, akActor as form)
				ModEvent.PushString(handle, "Fertility Mode")
				ModEvent.PushString(handle, morphName)
				ModEvent.Send(handle)
			endIf
		endIf

	endFunction

endState

State MyState4

endState

int function GetActorGender(Actor akActor)
{Identify the actor's gender}

	if !akActor
		return -1
	elseIf ((akActor == playerRef) && (forceGender != 2))
		return forceGender; if it's the player and they've overridden gender in MCM that takes precedence
	endIf

	return akActor.GetLeveledActorBase().GetSex()

endFunction

function SendTrackingEvent(string eventName, Form akSender, int iTrackingIndex)
{Fire a custom tracking event where the sender is the tracked actor}

    int handle = ModEvent.Create(eventName)
    if (handle)
        ModEvent.PushString(handle, eventName)
        ModEvent.PushForm(handle, akSender)
        ModEvent.PushInt(handle, iTrackingIndex)
        ModEvent.Send(handle)
    endIf

endFunction

function SendDetailedTrackingEvent(string eventName, Form akSender, string motherName, string fatherName, int iTrackingIndex)
{Fire a custom tracking event where the sender is the tracked actor}

	int handle = ModEvent.Create(eventName)
    if (handle)
        ModEvent.PushString(handle, eventName)
        ModEvent.PushForm(handle, akSender)
        ModEvent.PushString(handle, motherName)
        ModEvent.PushString(handle, fatherName)
        ModEvent.PushInt(handle, iTrackingIndex)
        ModEvent.Send(handle)
    endIf

endFunction

;	0 : ovulation phase, before egg
;	1 : ovulation phase, with egg
;	2 : luteal - ovulation phase, after egg has died
;	3 : menstruation
;	4 : first trimester
;	5 : second trimester
;	6 : third trimester
;	7 : ovulation is blocked this cycle
;	8 : recovery from birth
;	20: full-term pregnancy
; 1.59 moved from compatibility script
function UpdateNPCFactions(actor akActor = none, int index = -1)
{updates the faction memberships for a single actor}

	if (!GVHolder.Enabled || (!akActor && (index == -1)))
		return ; we have no actionable actor info or FM isn't enabled
	endIf
	if !akActor
		akActor = Storage.TrackedActors[index] as actor
		if !akActor
			return	; if we can't get actor info, GTFO
		endIf
	elseIf (index == -1)
		index = Storage.TrackedActors.Find(akActor as form)
		if index == -1
			akActor.RemoveFromFaction(GenericFaction)
			return	; if they're not tracked, clear all and GTFO
		endIf
	endIf

; new 2.14
	int stateID = FMMiscUtil.GetActorStateID(index)
	if stateID == -1
		akActor.RemoveFromFaction(GenericFaction)
	elseIf ((stateID == 4) || (stateID == 5) || (stateID == 6) || (stateID == 20))
		index = Math.LogicalAnd((((GVHolder.GVGameDaysPassed.GetValue() - Storage.LastConception[index]) / GVHolder.PregnancyDuration as float) * 100.0) as int, 0x0000007F)
		akActor.SetFactionRank(GenericFaction, index)
	elseIf (stateID == 8)
		index = Math.LogicalAnd((((GVHolder.GVGameDaysPassed.GetValue() - Storage.LastBirth[index]) / GVHolder.RecoveryDuration as float) * 36.0) as int, 0x0000003F)
		if (index > 36)
			index = 36
		endIf
		akActor.SetFactionRank(GenericFaction, (-85 - index))
	else
		akActor.SetFactionRank(GenericFaction, ((stateId * -10) - 5))
	endIf

endFunction
; 2.18
form	function	CheckDefinedChild(form theMother, int actorIndex)

	int uniqueLength = Storage.UniqueMothers.Length
;	debug.trace("FM+: checking for defined children, UniqueMothers: " + uniqueLength + " UniqueFathers: " + Storage.UniqueFathers.Length + " UniqueChildren: " + Storage.UniqueChildren.Length)
	if (uniqueLength < 1) || (uniqueLength != Storage.UniqueFathers.Length) || (uniqueLength != Storage.UniqueChildren.Length)
		return none
	endIf
	form father = Storage.LastFatherForm[actorIndex]
	if !theMother || !father
		return none
	endIf
	form theChild
	int index = 0
	while (index < uniqueLength)
		theChild = Storage.UniqueChildren[index]
		if (Storage.UniqueMothers[index] == theMother) && (Storage.UniqueFathers[index] == father) && (Storage.ChildrenSpawned.Find(theChild) == -1)
			return theChild
		endIf
		theChild = none
		index += 1
	endWhile

	return none

endFunction
