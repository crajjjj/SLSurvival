ScriptName	_JSW_SUB_CompactArrays	Extends	ActiveMagicEffect

_JSW_SUB_GVAlias					Property	GVAlias				Auto	; 
;_JSW_SUB_HandlerQuestAliasScript	Property	Handler				Auto	; Storage data helper
_JSW_BB_Storage						Property	Storage				Auto	; 

actor					Property	playerRef			Auto

spell					Property	CompactArraySpell	Auto	; 
; 2.25
spell					Property	FMUpdateSpell		Auto	; spell that does forced updates
; 2.05
; removed 2.25
;faction[]				Property	DefunctFactions		Auto	

event OnEffectStart(Actor akTarget, Actor akCaster)

	RegisterForSingleUpdate(0.05)

endEvent

event OnUpdate()

	if playerRef.HasSpell(FMUpdateSpell as form)
		RegisterForSingleUpdate(0.05)
		return
	else
		int verifyResult = 0
		CompactArrays()
		verifyResult = VerifyArrays()
		if (verifyResult != 0)
			Debug.Trace("Error: FM+ CompactArrays errorcode: " + verifyResult, 2)
		else
			Debug.Trace("FM+ info: Array Compaction completed")
		endIf
		; 2.05
		; removed in 2.25, these should all be long gone by now
;/		verifyResult = DefunctFactions.Length
		while (verifyResult > 0)
			verifyResult -= 1
			playerRef.RemoveFromFaction(DefunctFactions[verifyResult])
		endWhile/;
		VerifyRaceNames()
	endIf
	playerRef.RemoveSpell(CompactArraySpell)

endEvent

function CompactArrays()
{compresses arrays, filling in "holes" from deletions with live data}

	int index = 0
	int emptyIndex = -1
	int recordLengthOld = 0
	int recordLengthNew = 0
	bool continue = true
	bool makeNoise = (!Storage.FMValues[5] || GVAlias.GVHolder.VerboseMode)
	int var1 = 0

	if makeNoise && (Storage.FMValues[5] == 0)
		Debug.Notification("FM+ Array Defragmentation started")
		if !Storage.FMValues[5]
			Debug.Notification("This first run can be lengthy, please be patient!")
		endIf
	endIf
	emptyIndex = Storage.TrackedActors.Find(none)
	recordLengthOld = Math.LogicalAnd(Storage.TrackedActors.Length, 0x00000FFF)
		; emptyindex == -1 if there are no "none" records.  We can't compress an array if it only has one element
	while continue && (emptyIndex != -1) && (recordLengthOld > 1)
		; will return 0 if none found, else the index of the next non-empty element
		index = ArrayHasLiveDataAfter((emptyIndex + 1), true)
		if index
			; call function to copy over records from the "live" elements to the empty ones
			CopyActorsFromTo(index, emptyIndex)
			var1 += 1
		else
			; if ActorsHasLiveDataAfter returned zero, stop looping
			continue = false
		endIf
		emptyIndex = Storage.TrackedActors.Find(none)
	endWhile

	if makeNoise && (Storage.FMValues[5] == 0)
		Debug.Notification("FM+: step 1 of 4 finished, " + var1 + " female records defragmented")
		var1 = 0
	endIf

	continue = true	; each "while" will set this to false when that particular while is finished,
		; so we have to keep re-setting it to true
	emptyIndex = Storage.TrackedFathers.Find(none)
	recordLengthOld = Math.LogicalAnd(Storage.TrackedFathers.Length, 0x00000FFF)
	while continue && (emptyIndex != -1) && (recordLengthOld > 1)
		index = ArrayHasLiveDataAfter((emptyIndex + 1), false)
		if index
			CopyFathersFromTo(index, emptyIndex)
			var1 += 1
		else
			continue = false
		endIf
		emptyIndex = Storage.TrackedFathers.Find(none)
	endWhile

	if makeNoise && (Storage.FMValues[5] == 0)
		Debug.Notification("FM+: step 2 of 4 finished, " + var1 + " male records defragmented")
		var1 = 0
	endIf

	continue = true
	recordLengthOld = Math.LogicalAnd(Storage.TrackedActors.Length, 0x00000FFF)
	recordLengthNew = (RecordLengthOld - 1)
		; trim "trailing whitespace" records from TrackedActors' associated arrays
	while continue && (recordLengthOld > 1) && (Storage.TrackedActors[(recordLengthNew)] == none)
		continue = TruncateTrackedActors(recordLengthNew)
		recordLengthOld = Math.LogicalAnd(Storage.TrackedActors.Length, 0x00000FFF)
		recordLengthNew = (RecordLengthOld - 1)
		var1 += 1
	endWhile

	if makeNoise && (Storage.FMValues[5] == 0)
		Debug.Notification("FM+: step 3 of 4 finished, " + var1 + " empty female records truncated")
		var1 = 0
	endIf
	
	continue = true	
	recordLengthOld = Math.LogicalAnd(Storage.TrackedFathers.Length, 0x00000FFF)
	recordLengthNew = (RecordLengthOld - 1)
	while continue && (recordLengthOld > 1) && (Storage.TrackedFathers[(recordLengthNew)] == none)
		continue = TruncateTrackedFathers(recordLengthNew)
		recordLengthOld = Math.LogicalAnd(Storage.TrackedFathers.Length, 0x00000FFF)
		recordLengthNew = (RecordLengthOld - 1)
		var1 += 1
	endWhile

	if makeNoise && (Storage.FMValues[5] == 0)
		Debug.Notification("FM+: completed! " + var1 + " empty male records truncated")
		Storage.FMValues[5] = 1
	elseIf makeNoise
		Debug.Notification("FM+ Array Defragmentation completed.")
	endIf

endFunction

int function VerifyArrays()
{verifies the integrity of data in the arrays on game load}

	Actor thisActor = none
	float _inseminateLast = 0.0
	int _countSperm = 0
	int mIndex = Math.LogicalAnd(Storage.TrackedActors.Length, 0x00000FFF)
	int negatives = 0
	int reason = 0

	while (mIndex)
		mIndex -= 1
		thisActor = (Storage.TrackedActors[mIndex] as Actor)
		if thisActor
			_inseminateLast = Storage.LastInsemination[mIndex]
			_countSperm = Storage.SpermCount[mIndex]

			if (Storage.LastGameHours[mIndex] < 0.0)
				Storage.LastGameHours[mIndex] = 0.0
				reason = Math.LogicalOr(reason, 0x40000000)
				negatives += 1
			endIf
			if (_inseminateLast < 0.0)
				_inseminateLast = 0.0
				reason = Math.LogicalOr(reason, 0x20000000)
				negatives += 1
			endIf
			if (Storage.LastOvulation[mIndex] < 0.0)
				Storage.LastOvulation[mIndex] = 0.0
				reason = Math.LogicalOr(reason, 0x10000000)
				negatives += 1
			endIf
			if (Storage.LastConception[mIndex] < 0.0)
				Storage.LastConception[mIndex] = 0.0
				reason = Math.LogicalOr(reason, 0x08000000)
				negatives += 1
			endIf
			; 2.04
			if Storage.LastConception[mIndex] == 0.0
				((Storage as quest) as _JSW_BB_Utility).ClearBellyBreastScale(thisActor)
			endIf
			if (Storage.LastBirth[mIndex] < 0.0)
				Storage.LastBirth[mIndex] = 0.0
				reason = Math.LogicalOr(reason, 0x04000000)
				negatives += 1
			endIf
			if (_countSperm < 0)
				_countSperm = 0
				reason = Math.LogicalOr(reason, 0x02000000)
				negatives += 1
			endIf
			if (Storage.BabyAdded[mIndex] < 0.0)
				Storage.BabyAdded[mIndex] = 0.0
				reason = Math.LogicalOr(reason, 0x01000000)
				negatives += 1
			endIf
			if (Storage.DayOfCycle[mIndex] < 1)
				Storage.DayOfCycle[mIndex] = 1
				reason = Math.LogicalOr(reason, 0x00800000)
				negatives += 1
			endIf
			if (Storage.TimesDelivered[mIndex] < 0)
				Storage.TimesDelivered[mIndex] = 0
				reason = Math.LogicalOr(reason, 0x00400000)
				negatives += 1
			endIf
			if ((_inseminateLast == 0.0) || (_countSperm == 0))
				_inseminateLast = 0.0
				_countSperm = 0
				Storage.SpermCount[mIndex] = _countSperm
				Storage.LastInsemination[mIndex] = _inseminateLast
			endIf

			thisActor = none
		endIf
	endWhile

	return Math.LogicalOr(reason, negatives)

endFunction

function CopyActorsFromTo(int fromIndex, int toIndex)
{copies array entries from fromIndex to toIndex}

	Storage.TrackedActors[toIndex]				=	Storage.TrackedActors[fromIndex]
	Storage.LastMotherLocation[toIndex]			=	Storage.LastMotherLocation[fromIndex]
	Storage.CurrentFatherForm[toIndex]			=	Storage.CurrentFatherForm[fromIndex]
;	Storage.LastFather[toIndex]					=	Storage.LastFather[fromIndex]
	; 2.08
	Storage.LastFatherForm[toIndex]				=	Storage.LastFatherForm[fromIndex]
	Storage.LastGameHours[toIndex]				=	Storage.LastGameHours[fromIndex]
	Storage.LastInsemination[toIndex]			=	Storage.LastInsemination[fromIndex]
	Storage.LastOvulation[toIndex]				=	Storage.LastOvulation[fromIndex]
	Storage.LastConception[toIndex]				=	Storage.LastConception[fromIndex]
	Storage.LastBirth[toIndex]					=	Storage.LastBirth[fromIndex]
; 2.15	Storage.FatherRaceId[toIndex]				=	Storage.FatherRaceId[fromIndex]
	Storage.SpermCount[toIndex]					=	Storage.SpermCount[fromIndex]
	Storage.BabyAdded[toIndex]					=	Storage.BabyAdded[fromIndex]
	Storage.EventLock[toIndex]					=	Storage.EventLock[fromIndex]
	Storage.DayOfCycle[toIndex]					=	Storage.DayOfCycle[fromIndex]
	Storage.TimesDelivered[toIndex]				=	Storage.TimesDelivered[fromIndex]
	Storage.OvulationBlock[toIndex]				=	Storage.OvulationBlock[fromIndex]
	Storage.FemHasLoveInterest[toIndex]			=	Storage.FemHasLoveInterest[fromIndex]
	Storage.FemAttached[toIndex]				=	Storage.FemAttached[fromIndex]
	Storage.ActorLocation[toIndex]				=	Storage.ActorLocation[fromIndex]
	; 2.10
	Storage.Fidelity[toIndex]					=	Storage.Fidelity[fromIndex]
	; 2.15
	Storage.CurrentFatherRace[toIndex]			=	Storage.CurrentFatherRace[fromIndex]
	; 2.24
	Storage.ATFlags[toIndex]					=	Storage.ATFlags[fromIndex]
	Storage.ActorLocParent[toIndex]				=	Storage.ActorLocParent[fromIndex]

	Storage.TrackedActorRemove(fromIndex, true)

endFunction

function CopyFathersFromTo(int fromIndex, int toIndex)
{copies array entries from fromIndex to toIndex}

	Storage.TrackedFathers[toIndex]				=	Storage.TrackedFathers[fromIndex]
	Storage.LastFatherLocation[toIndex]			=	Storage.LastFatherLocation[fromIndex]
	Storage.RefractoryPeriod[toIndex]			=	Storage.RefractoryPeriod[fromIndex]
	Storage.MaleHasLoveInterest[toIndex]		=	Storage.MaleHasLoveInterest[fromIndex]
	Storage.MaleAttached[toIndex]				=	Storage.MaleAttached[fromIndex]
	Storage.FatherLocation[toIndex]				=	Storage.FatherLocation[fromIndex]
	Storage.ChildrenFathered[toIndex]			=	Storage.ChildrenFathered[fromIndex]
	; 2.24
	Storage.FatherLocParent[toIndex]			=	Storage.FatherLocParent[fromIndex]
	; 2.25
	Storage.ATFlagsMale[toIndex]				=	Storage.ATFlagsMale[fromIndex]

	Storage.TrackedFatherRemove(fromIndex, true)

endFunction

int function ArrayHasLiveDataAfter(int index, bool females = false)
{checks if there are live (undeleted) records in the designated array after the given number}

	int arrayLength = 0
	if females
		arrayLength = Math.LogicalAnd(Storage.TrackedActors.Length, 0x00000FFF)
	else
		arrayLength = Math.LogicalAnd(Storage.TrackedFathers.Length, 0x00000FFF)
	endIf

	if (index > (arrayLength - 2)) || (index < 0)
		return 0	; the starting index is the last record or an invalid index number
	endIf

	while (index < arrayLength)
		if females
			if (Storage.TrackedActors[index] != none)
				return index
			endIf
		elseIf (Storage.TrackedFathers[index] != none)
			return index
		endIf
		index += 1
	endWhile

	return 0

endFunction

bool function TruncateTrackedActors(int newLength = 0)
{truncates TrackedActors and associated arrays to length specified}

	if newLength < 1
		return false
	endIf

	newLength = Math.LogicalAnd(newLength, 0x00000FFF)

	Storage.TrackedActors			=	Utility.ResizeFormArray(Storage.TrackedActors, newLength)
	Storage.LastMotherLocation		=	Utility.ResizeStringArray(Storage.LastMotherLocation, newLength)
	Storage.CurrentFatherForm		=	Utility.ResizeFormArray(Storage.CurrentFatherForm, newLength)
;	Storage.LastFather				=	Utility.ResizeStringArray(Storage.LastFather, newLength)
	; 2.08
	Storage.LastFatherForm			=	Utility.ResizeFormArray(Storage.LastFatherForm, newLength)
	Storage.LastGameHours			=	Utility.ResizeFloatArray(Storage.LastGameHours, newLength)
	Storage.LastInsemination		=	Utility.ResizeFloatArray(Storage.LastInsemination, newLength)
	Storage.LastOvulation			=	Utility.ResizeFloatArray(Storage.LastOvulation, newLength)
	Storage.LastConception			=	Utility.ResizeFloatArray(Storage.LastConception, newLength)
	Storage.LastBirth				=	Utility.ResizeFloatArray(Storage.LastBirth, newLength)
; 2.15	Storage.FatherRaceId			=	Utility.ResizeIntArray(Storage.FatherRaceId, newLength)
	Storage.SpermCount				=	Utility.ResizeIntArray(Storage.SpermCount, newLength)
	Storage.BabyAdded				=	Utility.ResizeFloatArray(Storage.BabyAdded, newLength)
	Storage.EventLock				=	Utility.ResizeIntArray(Storage.EventLock, newLength)
	Storage.DayOfCycle				=	Utility.ResizeIntArray(Storage.DayOfCycle, newLength, 1)
	Storage.TimesDelivered			=	Utility.ResizeIntArray(Storage.TimesDelivered, newLength)
	Storage.OvulationBlock			=	Utility.ResizeIntArray(Storage.OvulationBlock, newLength)
	Storage.FemHasLoveInterest		=	Utility.ResizeFormArray(Storage.FemHasLoveInterest, newLength)
	Storage.FemAttached				=	Utility.ResizeIntArray(Storage.FemAttached, newLength)
	Storage.ActorLocation			=	Utility.ResizeFormArray(Storage.ActorLocation, newLength)
	; 2.10
	Storage.Fidelity				=	Utility.ResizeIntArray(Storage.Fidelity, newLength)
	; 2.15
	Storage.CurrentFatherRace		=	Utility.ResizeFormArray(Storage.CurrentFatherRace, newLength)
	; 2.24
	Storage.ATFlags					=	Utility.ResizeIntArray(Storage.ATFlags, newLength)
	Storage.ActorLocParent			=	Utility.ResizeFormArray(Storage.ActorLocParent, newLength)

	return true

endFunction

bool function TruncateTrackedFathers(int newlength = 0)
{truncates TrackedFathers and associated arrays to length specified}

	if newLength < 1
		return false	; we should have never arrived here in the first place, send abort!
	endIf
	; sanity check, limit newLength to 4095 or less
	NewLength = Math.LogicalAnd(newLength, 0x00000FFF)
	Storage.TrackedFathers				=	Utility.ResizeFormArray(Storage.TrackedFathers, newLength)
	Storage.LastFatherLocation			=	Utility.ResizeStringArray(Storage.LastFatherLocation, newLength)
	Storage.RefractoryPeriod			=	Utility.ResizeIntArray(Storage.RefractoryPeriod, newLength)
	Storage.MaleHasLoveInterest			=	Utility.ResizeFormArray(Storage.MaleHasLoveInterest, newLength)
	Storage.MaleAttached				=	Utility.ResizeIntArray(Storage.MaleAttached, newLength)
	Storage.FatherLocation				=	Utility.ResizeFormArray(Storage.FatherLocation, newLength)
	Storage.ChildrenFathered			=	Utility.ResizeIntArray(Storage.ChildrenFathered, newLength)
	; 2.24
	Storage.FatherLocParent				=	Utility.ResizeFormArray(Storage.FatherLocParent, newLength)
	; 2.25
	Storage.ATFlagsMale					=	Utility.ResizeIntArray(Storage.ATFlagsMale, newLength)

	return true

endFunction

function	VerifyRaceNames()

	Game.GetForm(0x00013740).SetName("Argonian")	; Argonian
	Game.GetForm(0x0008883a).SetName("Argonian")	; Argonian Vampire
	Game.GetForm(0x00013741).SetName("Breton")		; breton
	Game.GetForm(0x0008883c).SetName("Breton")		; breton vampire
	Game.GetForm(0x00097a3d).SetName("Breton")		; afflicted
	Game.GetForm(0x00013742).SetName("Dark Elf")	; dark elf
	Game.GetForm(0x0008883d).SetName("Dark Elf")	; dark elf vampire
	Game.GetForm(0x00013743).SetName("High Elf")	; high elf
	Game.GetForm(0x00088840).SetName("High Elf")	; high elf vampire
	Game.GetForm(0x00013744).SetName("Imperial")	; imperial
	Game.GetForm(0x00088844).SetName("Imperial")	; imperial vampire
	Game.GetForm(0x00013745).SetName("Khajiit")		; khajiit
	Game.GetForm(0x00088845).SetName("Khajiit")		; khajiit vampire
	Game.GetForm(0x00013746).SetName("Nord")		; nord
	Game.GetForm(0x0007eaf3).SetName("Nord")		; astrid - useless for our purposes since not flagged playable
	Game.GetForm(0x00088794).SetName("Nord")		; nord vampire
	Game.GetForm(0x00013747).SetName("Orc")			; orc - why doesn't Imperious change this to Orsimer??
	Game.GetForm(0x000a82b9).SetName("Orc")			; orc vampire
	Game.GetForm(0x00013748).SetName("Redguard")	; redguard
	Game.GetForm(0x00088846).SetName("Redguard")	; redguard vampire
	Game.GetForm(0x00013749).SetName("Wood Elf")	; wood elf
	Game.GetForm(0x00088884).SetName("Wood Elf")	; wood elf vampire
	; 2.09
	Game.GetForm(0x0200377D).SetName("Snow Elf")	; snow elves, which DG calls high elves for some reason...

endFunction
