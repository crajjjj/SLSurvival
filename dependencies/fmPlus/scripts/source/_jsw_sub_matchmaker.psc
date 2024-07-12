Scriptname	_JSW_SUB_MatchMaker	extends	Quest

_JSW_BB_Storage				Property	Storage				Auto	; Storage data helper
_JSW_SUB_GVHolderScript		Property	GVHolder			Auto	;

Actor			Property	PlayerRef			Auto	; Reference to the player. Game.GetPlayer() is slow
; 2.24 added
Formlist		Property	ExcludeAT			Auto	; associations used for eliminating random inseminators
; 2.24 added
Keyword			Property	LocTypeHabitation	Auto	; 

;	----	Script Variables    ----
bool	autoInsemPC
bool	bFaithful
form	theForm
int		combinedFlags
int		femFlags
int		actorIndex
int		maleFlags
int		noSexHours
int		playerFatherIndex
int		potentialIndex
int		result
int		TFLength
int[]	potentialFathers

function MatchMakerUnregister()

	UnregisterForAllModEvents()

endFunction

; 1.62
bool function InitializeMatchMaker()
{registers for event and returns true}

	potentialFathers	=	new int[32]
;	RegisterForModEvent("FMFindNearbyPartner", "RelaxedFindRandomFather")
	return true

endFunction

; new for 1.59
int function FindSexPartner(int herIndex, actor femActor, int spouseInsemChance, int faithRoll)
{if an actor has a spouse/courting association try to locate them}

	actorIndex = herIndex
	bFaithful = ((spouseInsemChance + Storage.Fidelity[actorIndex]) > faithRoll)
	if (Storage.FemAttached[actorIndex] != 0) && bFaithful
		theForm = Storage.FemHasLoveInterest[actorIndex]
		if theForm
			return Storage.TrackedFathers.Find(theForm)
		endIf
	endIf

	; 2.25
	femFlags = Storage.ATFlags[actorIndex]
	theForm = Storage.ActorLocParent[actorIndex]
	result = Storage.FatherLocParent.Find(theForm)
	TFLength = Math.LogicalAnd(Storage.TrackedFathers.Length, 0x00000FFF)
	if (result == -1) || (TFLength < 1)
		return -1
	endIf
	potentialIndex = 0
	noSexHours = (Math.RightShift(Storage.FMValues[11], 1) + 1)
	autoInsemPC = GVHolder.AutoInseminatePc
	playerFatherIndex = Storage.TrackedFathers.Find(PlayerRef as form)
	if Storage.ActorLocParent[actorIndex] as location
		if (FemFlags < 2)
			GoToState("NoRelationsTown")
		else
			GoToState("RelationsTown")
		endIf
		return FindHabitationFather(femActor)
	else
		theForm = Storage.ActorLocation[actorIndex]
		if (theForm as location) && (Storage.FatherLocation.Find(theForm) != -1)
			if (FemFlags < 2)
				GoToState("NoRelationsNowhere")
			else
				GoToState("RelationsNowhere")
			endIf
			return FindHabitationFather(femActor)
		endIf
	endIf
	return -1

endFunction

int	function	FindHabitationFather(actor femActor)
endFunction

state	RelationsTown

	int	function	FindHabitationFather(actor femActor)
	{the female is in a habitation, so try to find a "nearby" partner - version for actors with close relatives}

		actor maleActor = none
			
		; Identify up to 32 potential fathers in the same location as the mother
		; very arbitrary decision to limit it to 32 matches
		while (result != -1) && (potentialIndex < 32)
			maleActor = Storage.TrackedFathers[result] as actor
			if maleActor && (Storage.RefractoryPeriod[result] < noSexHours) && (!bFaithful || (Storage.MaleAttached[result] == 0))
				; 2.25
				maleFlags = Storage.ATFlagsMale[result]
				if (maleFlags > 1) && (femFlags > 1)
					combinedFlags = Math.LogicalAND(femFlags, maleFlags)
				endIf
				if (autoInsemPC || (result != playerFatherIndex)) && ((combinedFlags < 2) || !IsBloodRelative(femActor, maleActor)) && \
					!femActor.IsHostileToActor(maleActor)
					potentialFathers[potentialIndex] = result
					potentialIndex += 1
				endIf
				combinedFlags = 0
			endIf
			if ((result + 1) < TFLength)
				result = Storage.FatherLocParent.Find(theForm, (result + 1))
			else
				result = -1
			endIf
			maleActor = none
		endWhile

		if (potentialIndex == 0)
			return -1
		elseIf (potentialIndex == 1)
			return potentialFathers[0]
		endIf

		; select one male at random from those in the right place at the right time
		result = Utility.RandomInt(0, (potentialIndex - 1))
		return potentialFathers[result]

	endFunction

endState

state	NoRelationsTown

	int	function	FindHabitationFather(actor femActor)
		{the female is in a habitation, so try to find a "nearby" partner - version for actors with no close relatives}

		actor maleActor = none
			
		; Identify up to 32 potential fathers in the same location as the mother
		; very arbitrary decision to limit it to 32 matches
		while (result != -1) && (potentialIndex < 32)
			maleActor = Storage.TrackedFathers[result] as actor
			if maleActor && (Storage.RefractoryPeriod[result] < noSexHours) && \
				(!bFaithful || (Storage.MaleAttached[result] == 0)) && (autoInsemPC || (result != playerFatherIndex)) && \
				!femActor.IsHostileToActor(maleActor)
				potentialFathers[potentialIndex] = result
				potentialIndex += 1
			endIf
			if ((result + 1) < TFLength)
				result = Storage.FatherLocParent.Find(theForm, (result + 1))
			else
				result = -1
			endIf
			maleActor = none
		endWhile

		if (potentialIndex == 0)
			return -1
		elseIf (potentialIndex == 1)
			return potentialFathers[0]
		endIf

		; select one male at random from those in the right place at the right time
		result = Utility.RandomInt(0, (potentialIndex - 1))
		return potentialFathers[result]

	endFunction

endState

state	RelationsNowhere

	int	function	FindHabitationFather(actor femActor)
	{the female is not in a habitation, so try to find a "nearby" partner - version for actors with close relatives}

		actor maleActor = none
			
		; Identify up to 32 potential fathers in the same location as the mother
		; very arbitrary decision to limit it to 32 matches
		while (result != -1) && (potentialIndex < 32)
			maleActor = Storage.TrackedFathers[result] as actor
			if maleActor && (Storage.RefractoryPeriod[result] < noSexHours) && (!bFaithful || (Storage.MaleAttached[result] == 0))
				; 2.25
				maleFlags = Storage.ATFlagsMale[result]
				if (maleFlags > 1) && (femFlags > 1)
					combinedFlags = Math.LogicalAND(femFlags, maleFlags)
				endIf
				if (autoInsemPC || (result != playerFatherIndex)) && \
					((combinedFlags < 2) || !IsBloodRelative(femActor, maleActor)) && \
					!femActor.IsHostileToActor(maleActor)
					potentialFathers[potentialIndex] = result
					potentialIndex += 1
				endIf
				combinedFlags = 0
			endIf
			if ((result + 1) < TFLength)
				result = Storage.FatherLocation.Find(theForm, (result + 1))
			else
				result = -1
			endIf
			maleActor = none
		endWhile

		if (potentialIndex == 0)
			return -1
		elseIf (potentialIndex == 1)
			return potentialFathers[0]
		endIf

		; select one male at random from those in the right place at the right time
		result = Utility.RandomInt(0, (potentialIndex - 1))
		return potentialFathers[result]

	endFunction

endState

state	NoRelationsNowhere

	int	function	FindHabitationFather(actor femActor)
	{the female is not in a habitation, so try to find a "nearby" partner - version for actors with no close relatives}

		actor maleActor = none

		; Identify up to 32 potential fathers in the same location as the mother
		; very arbitrary decision to limit it to 32 matches
		while (result != -1) && (potentialIndex < 32)
			maleActor = Storage.TrackedFathers[result] as actor
			if maleActor && (Storage.RefractoryPeriod[result] < noSexHours) && (!bFaithful || (Storage.MaleAttached[result] == 0))
				if (autoInsemPC || (result != playerFatherIndex)) && !femActor.IsHostileToActor(maleActor)
					potentialFathers[potentialIndex] = result
					potentialIndex += 1
				endIf
			endIf
			if ((result + 1) < TFLength)
				result = Storage.FatherLocation.Find(theForm, (result + 1))
			else
				result = -1
			endIf
			maleActor = none
		endWhile

		if (potentialIndex == 0)
			return -1
		elseIf (potentialIndex == 1)
			return potentialFathers[0]
		endIf

		; select one male at random from those in the right place at the right time
		result = Utility.RandomInt(0, (potentialIndex - 1))
		return potentialFathers[result]

endFunction

endState

int function FindRandomMother(int recycleInt)
{Attempt to identify a random mother in the same cell as the tracked male actor with actorIndex}

	theForm = Storage.FatherLocation[recycleInt]
	; recycleInt starts as actorIndex, becomes storage.trackedactors.length
	recycleInt = Math.LogicalAnd((Storage.TrackedActors.Length - 1), 0x00000FFF)
	actorIndex = Storage.ActorLocation.Find(theForm)
	if ((actorIndex == -1) || (recycleInt < 1))
		return -1	; none found or none tracked
	endIf

    ; Identify a "random" potential mother in the same location as the potential father
	while ((actorIndex != -1) && (actorIndex < recycleInt))
		if !Storage.LastInsemination[actorIndex]
			return actorIndex
		endIf
		actorIndex = Storage.ActorLocation.Find(theForm, (actorIndex + 1))
	endWhile

    return -1
endFunction

; 2.24 rewrite
;	0xFFFFFFFF	=	not unique actor ( -1 ) added 2.25
;	0x00000001	=	has family relationship
;	0x00000002	=	has sibling
;	0x00000004	=	has Parent/Child
;	0x00000008	=	has Aunt/Uncle
;	0x00000010	=	has Grandparent/Grandchild
bool function IsBloodRelative(actor firstActor, actor secondActor)
{returns true if they're blood relatives closer than first cousins}

	int index = ExcludeAT.GetSize()
	bool related
	while !related && (index > 0)
		index -= 1
		related = (Math.LogicalAND(combinedFlags, Math.LeftShift(0x01, (index + 1))) as bool) && firstActor.HasAssociation(ExcludeAT.GetAt(index) as AssociationType, secondActor)
	endWhile
	return related

endFunction
