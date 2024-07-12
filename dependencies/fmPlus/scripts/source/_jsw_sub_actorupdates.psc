Scriptname	_JSW_SUB_ActorUpdates	extends	Quest

;_JSW_SUB_GVAlias			Property	GVAlias				Auto	; 
_JSW_BB_Storage				Property	Storage				Auto	; Storage data helper

AssociationType		Property	assocSpouse		Auto		; added for findsexpartner check
AssociationType		Property	assocCourting	Auto		; added for findsexpartner check
; 2.26
referenceAlias		Property	GVAlias			Auto		; 
; 1.62
;Keyword			Property	ActorTypeCreature	Auto		; Keyword for identifying creature types
_JSW_SUB_GVAlias	GVAliasSC

function AUUnregister()

	UnregisterForAllModEvents()

endFunction

bool function RunAtGoFunction()
{called by ScriptStarter onplayerloadgame}

;    RegisterForModEvent("FertilityModeActorMaint", "OnFertilityModeActorMaint")
	RegisterForModEvent("FMPatchIncActorUpdate", "IncrementalStatusUpdate")
	; 2.26
	if (GVAliasSC == none) || !GVAliasSC.ImHere()
		GVAliasSC = GVAlias as _JSW_SUB_GVAlias
	endIf
	return true

endFunction

event IncrementalStatusUpdate(int howMany = 8)
{update "x" actors and fathers each time player changes location}

	; 2.16
	UnregisterForModEvent("FMPatchIncActorUpdate")
	int maxIndex = 0
	int minIndex = 0
	minIndex = Storage.FMValues[14]
	maxIndex = Math.LogicalAnd((Storage.TrackedActors.Length), 0x00000FFF)
	int recordLengthOld = maxIndex
	if (minIndex > maxIndex)
		minIndex = 0
	endIf
	GoToState("")
	if ((minIndex + howMany + 1) < maxIndex)
		maxIndex = (minIndex + howMany + 1)
	endIf
	CheckDeadActors(minIndex, maxIndex)
;	UpdateLocations(minIndex, maxIndex)
	UpdateRelationships(minIndex, maxIndex)
	
	if ((maxIndex + 2) > recordLengthOld)
		Storage.FmValues[14] = 0
	else
		Storage.FMValues[14] = (maxIndex - 1)
	endIf

	minIndex = Storage.FMValues[15]
	maxIndex = Math.LogicalAnd((Storage.TrackedFathers.Length), 0x00000FFF)
	recordLengthOld = maxIndex
	if (minIndex > maxIndex)
		minIndex = 0
	endIf
	GoToState("Males")
	if ((minIndex + howMany + 1) < maxIndex)
		maxIndex = (minIndex + howMany + 1)
	endIf
	CheckDeadActors(minIndex, maxIndex)
;	UpdateLocations(minIndex, maxIndex)
	UpdateRelationships(minIndex, maxIndex)
	
	if ((maxIndex + 2) > recordLengthOld)
		Storage.FmValues[15] = 0
	else
		Storage.FMValues[15] = (maxIndex - 1)
	endIf

	GoToState ("")
	; 2.16
	RegisterForModEvent("FMPatchIncActorUpdate", "IncrementalStatusUpdate")

endEvent

function CheckDeadActors(int startIndex, int endIndex)
{checks if they're alive, or not}

	string		locName		=	""
	form		where		=	none
	actor		thisActor	=	none
	; 2.24
	form		parentLoc	=	none
	int			anInt
	location	oldWhere	=	none
	while (startIndex < endIndex)
		thisActor = Storage.TrackedActors[startIndex] as actor
		if thisActor
			if ((Storage.ActorBlackList.Find(thisActor as form) != -1) || thisActor.IsDead())
				Storage.TrackedActorRemove(startIndex, false)
			else
				where = thisActor.GetCurrentLocation() as form
				if where
					; 2.24
					oldWhere = Storage.ActorLocation[startIndex] as location
					if oldWhere && ((oldWhere as form) != where) && ((GVAliasSC.HabitationLocs.Find(where) == -1) || (GVAliasSC.ChildLocs.Find(where) == -1))
						GVAliasSC.UpdateLocationMap(oldWhere, where as location)
						oldwhere = none
					endIf
					if (GVAliasSC.HabitationLocs.Find(where) != -1)
						parentLoc = where
					else
						anInt = GVAliasSC.ChildLocs.Find(where)
						if anInt != -1
							parentLoc = GVAliasSC.HabitationLocs[anInt]
						endIf
					endIf
					; end 2.24
					locName = where.GetName()
					if locName == ""
						locName = "Skyrim"
					endIf
				else
					locName = "Tamriel"
				endIf
				Storage.LastMotherLocation[startIndex] = locName
				Storage.ActorLocation[startIndex] = where
				; 2.24
				Storage.ActorLocParent[startIndex] = parentLoc
				locName = ""
				where = none
				parentLoc = none
			endIf
			thisActor = none
		else
			Storage.TrackedActorRemove(startIndex, false)
		endIf
		startIndex += 1
	endWhile

endFunction

function UpdateRelationships(int startIndex, int endIndex)
	{updates relationship records for the selected set of actors}

	actor thisActor = none
	actor thatActor = none
	int hasLover = 0
	int thatIndex = 0
	while (startIndex < endIndex)
		thisActor = Storage.TrackedActors[startIndex] as actor
		if thisActor
			; 2.25
			if Storage.ATFlags[startIndex] == -1
				hasLover = 0
			elseIf thisActor.HasAssociation(assocCourting)
				hasLover = 2
			else
				hasLover = thisActor.HasAssociation(assocSpouse) as int
			endIf
			Storage.FemAttached[startIndex] = hasLover
			if (hasLover == 0)
				Storage.FemHasLoveInterest[startIndex] = none
				; 2.10
				Storage.Fidelity[startIndex] = 0
			elseIf (hasLover == 1)
				thatActor = Storage.FemHasLoveInterest[startIndex] as actor
				if !thisActor.HasAssociation(assocSpouse, thatActor)
					thatActor = none
				endIf
				if !thatActor
					thatIndex = Math.LogicalAnd(Storage.TrackedFathers.Length, 0x00000FFF)
					while thatIndex
						thatIndex -= 1
						thatActor = Storage.TrackedFathers[thatIndex] as actor
						if thatActor
							if thisActor.HasAssociation(assocSpouse, thatActor)
								Storage.FemHasLoveInterest[startIndex] = thatActor as form
								Storage.MaleAttached[thatIndex] = 1
								Storage.MaleHasLoveInterest[thatIndex] = thisActor as form
								; 2.10
								int mod = thisActor.GetRelationshipRank(thatActor)
								if (mod > 0)
									Storage.Fidelity[startIndex] = (mod * 2.5) as int
								else
									Storage.Fidelity[startIndex] = (mod * 10)
								endIf
								debug.trace("FM+ info: " + (Storage.TrackedActors[startIndex] as actor).GetDisplayName() + " spouse of " + (Storage.TrackedFathers[thatIndex] as actor).GetDisplayName())
								thatIndex = 0
							endIf
							thatActor = none
						endIf
					endWhile
				endIf
			else	; then it must be 2
				thatActor = Storage.FemHasLoveInterest[startIndex] as actor
				if !thisActor.HasAssociation(assocCourting, thatActor)
					thatActor = none
				endIf
				if !thatActor
					thatIndex = Math.LogicalAnd(Storage.TrackedFathers.Length, 0x00000FFF)
					while thatIndex
						thatIndex -= 1
						thatActor = Storage.TrackedFathers[thatIndex] as actor
						if thatActor
							if thisActor.HasAssociation(assocCourting, thatActor)
								Storage.FemHasLoveInterest[startIndex] = thatActor as form
								Storage.MaleAttached[thatIndex] = 2
								Storage.MaleHasLoveInterest[thatIndex] = thisActor as form
								; 2.10
								int mod = thisActor.GetRelationshipRank(thatActor)
								if (mod > 0)
									Storage.Fidelity[startIndex] = (mod * 2.5) as int
								else
									Storage.Fidelity[startIndex] = (mod * 10)
								endIf
								debug.trace("FM+ info: " + (Storage.TrackedActors[startIndex] as actor).GetDisplayName() + " GF of " + (Storage.TrackedFathers[thatIndex] as actor).GetDisplayName())
								thatIndex = 0
							endIf
							thatActor = none
						endIf
					endWhile
				endIf
			endIf
		endIf
		startIndex += 1
	endWhile

endFunction

state Males

	function CheckDeadActors(int startIndex, int endIndex)
	{checks if they're alive, or not}

		string		locName		=	""
		form		where		=	none
		actor		thisActor	=	none
		; 2.24
		form		parentLoc	=	none
		int			anInt
		location	oldWhere	=	none
		while (startIndex < endIndex)
			thisActor = Storage.TrackedFathers[startIndex] as actor
			if thisActor
				if ((Storage.ActorBlackList.Find(thisActor as form) != -1) || thisActor.IsDead())
					Storage.TrackedFatherRemove(startIndex, false)
				else
					where = thisActor.GetCurrentLocation() as form
					if where
						; 2.24
						oldWhere = Storage.FatherLocation[startIndex] as location
						if oldWhere && ((oldWhere as form) != where) && ((GVAliasSC.HabitationLocs.Find(where) == -1) || (GVAliasSC.ChildLocs.Find(where) == -1))
							GVAliasSC.UpdateLocationMap(oldWhere, where as location)
							oldwhere = none
						endIf
						if (GVAliasSC.HabitationLocs.Find(where) != -1)
							parentLoc = where
						else
							anInt = GVAliasSC.ChildLocs.Find(where)
							if anInt != -1
								parentLoc = GVAliasSC.HabitationLocs[anInt]
							endIf
						endIf
						; end 2.24
						locName = where.GetName()
						if locName == ""
							locName = "Skyrim"
						endIf
					else
						locName = "Tamriel"
					endIf
					Storage.LastFatherLocation[startIndex] = locName
					Storage.FatherLocation[startIndex] = where
					; 2.24
					Storage.FatherLocParent[startIndex] = parentLoc
					locName = ""
					where = none
					parentLoc = none
				endIf
				thisActor = none
			else
				Storage.TrackedFatherRemove(startIndex, false)
			endIf
			startIndex += 1
		endWhile

	endFunction

	function UpdateRelationships(int startIndex, int endIndex)
	{updates relationship records for the selected set of actors}
	
		actor thisActor = none
		actor thatActor = none
		int hasLover = 0
		int thatIndex = 0
		while (startIndex < endIndex)
			thisActor = Storage.TrackedFathers[startIndex] as actor
				if thisActor
				; 2.25
				if Storage.ATFlagsMale[startIndex] == -1
					hasLover = 0
				elseIf thisActor.HasAssociation(assocCourting)
					hasLover = 2
				else
					hasLover = thisActor.HasAssociation(assocSpouse) as int
				endIf
				Storage.MaleAttached[startIndex] = hasLover
				if (hasLover == 0)
					Storage.MaleHasLoveInterest[startIndex] = none
				elseIf (hasLover == 1)
					thatActor = Storage.MaleHasLoveInterest[startIndex] as actor
					if !thisActor.HasAssociation(assocSpouse, thatActor)
						thatActor = none
					endIf
					if !thatActor
						thatIndex = Math.LogicalAnd(Storage.TrackedActors.Length, 0x00000FFF)
						while thatIndex
							thatIndex -= 1
							thatActor = Storage.TrackedActors[thatIndex] as actor
							if thatActor
								if thisActor.HasAssociation(assocSpouse, thatActor)
									Storage.MaleHasLoveInterest[startIndex] = thatActor as form
									Storage.FemAttached[thatIndex] = 1
									Storage.FemHasLoveInterest[thatIndex] = thisActor as form
									; 2.10
									int mod = thisActor.GetRelationshipRank(thatActor)
									if (mod > 0)
										Storage.Fidelity[thatIndex] = (mod * 2.5) as int
									else
										Storage.Fidelity[thatIndex] = (mod * 10)
									endIf
									debug.trace("FM+ info: " + (Storage.TrackedFathers[startIndex] as actor).GetDisplayName() + " spouse of " + (Storage.TrackedActors[thatIndex] as actor).GetDisplayName())
									thatIndex = 0
								endIf
								thatActor = none
							endIf
						endWhile
					endIf
				else	; then it must be 2
					thatActor = Storage.MaleHasLoveInterest[startIndex] as actor
					if !thisActor.HasAssociation(assocCourting, thatActor)
						thatActor = none
					endIf
					if !thatActor
						thatIndex = Math.LogicalAnd(Storage.TrackedActors.Length, 0x00000FFF)
						while thatIndex
							thatIndex -= 1
							thatActor = Storage.TrackedActors[thatIndex] as actor
							if thatActor
								if thisActor.HasAssociation(assocCourting, thatActor)
									Storage.MaleHasLoveInterest[startIndex] = thatActor as form
									Storage.FemAttached[thatIndex] = 2
									Storage.FemHasLoveInterest[thatIndex] = thisActor as form
									int mod = thisActor.GetRelationshipRank(thatActor)
									if (mod > 0)
										Storage.Fidelity[thatIndex] = (mod * 2.5) as int
									else
										Storage.Fidelity[thatIndex] = (mod * 10)
									endIf
									debug.trace("FM+ info: " + (Storage.TrackedFathers[startIndex] as actor).GetDisplayName() + " BF of " + (Storage.TrackedActors[thatIndex] as actor).GetDisplayName())
									thatIndex = 0
								endIf
								thatActor = none
							endIf
						endWhile
					endIf
				endIf
			endIf
			startIndex += 1
		endWhile

	endFunction

endState
