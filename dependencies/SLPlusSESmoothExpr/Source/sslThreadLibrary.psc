scriptname sslThreadLibrary extends sslSystemLibrary

import StorageUtil

; Data
FormList property BedsList auto hidden
FormList property DoubleBedsList auto hidden
FormList property BedRollsList auto hidden
Keyword property FurnitureBedRoll auto hidden

; ------------------------------------------------------- ;
; --- Object Locators                                 --- ;
; ------------------------------------------------------- ;

bool function CheckActor(Actor CheckRef, int CheckGender = -1)
	if !CheckRef || CheckRef == none
		return false ; Invalid args
	endIf
	int IsGender = ActorLib.GetGender(CheckRef)
	return ((CheckGender < 2 && IsGender < 2) || (CheckGender >= 2 && IsGender >= 2)) && (CheckGender == -1 || IsGender == CheckGender) && ActorLib.IsValidActor(CheckRef)
endFunction

ObjectReference function FindHiddenReference(actor[] Positions, Form HiddenRef, ObjectReference CenterRef, float Radius = 3000.0)
	int ActorCount = Positions.Length
	actor[] ActorsRef = Positions
	if !HiddenRef || !CenterRef || Radius < 1.0 || ActorCount < 1
		return none ; Invalid args
	endIf
	Actor[] IgnoreRef = new Actor[4]
	ObjectReference TempRef
	int i = 0
	float PrivateRadius = 900.0
	if CenterRef.IsInInterior()
		Radius = Radius * 0.5
		PrivateRadius = 600.0
		if LocationHasKeyword(CenterRef.GetCurrentLocation(), Keyword.GetKeyword("LocTypeInn"))
			PrivateRadius = 300.0
		endIf
	endIf
	if Radius <= PrivateRadius
		return none ; Invalid args
	endIf
	if ActorsRef.Find(CenterRef as Actor)
		if !(CenterRef as Actor).GetWornForm(0x00000004) && !ActorLib.IsCreature(CenterRef as Actor)
			Log("FindHiddenReference() -- Find:"+CenterRef+" - Naked")
			return none ; Exhibitionist Location
		endIf
		ActorsRef = PapyrusUtil.RemoveActor(ActorsRef, CenterRef as Actor)
		ActorCount = ActorsRef.Length
	EndIf
	if !CurrentFollowerFaction
		CurrentFollowerFaction = Game.GetFormFromFile(0x5C84E, "Skyrim.esm") as Faction
	endIf
	while i < IgnoreRef.Length
		if i < ActorCount
			if !ActorsRef[i].GetWornForm(0x00000004) && !ActorLib.IsCreature(ActorsRef[i])
				Log("FindHiddenReference() -- Find:"+ActorsRef[i]+" - Naked")
				return none ; Exhibitionist Location
			endIf
			IgnoreRef[i] = ActorsRef[i]
		else
			TempRef = FindAvailableActorInFaction(CurrentFollowerFaction, CenterRef, Radius, -1, IgnoreRef[0], IgnoreRef[1], IgnoreRef[2], IgnoreRef[3])
			if TempRef
				IgnoreRef[i] = TempRef as Actor
			else
				i = IgnoreRef.Length
			endIf
		endIf
		i += 1
	endWhile
		
	if !FindAvailableActorWornForm(0x00000004, CenterRef, PrivateRadius, -1, IgnoreRef[0], IgnoreRef[1], IgnoreRef[2], IgnoreRef[3], JustSameFloor = PrivateRadius < 600.0)
		Log("FindHiddenReference() -- Find:"+CenterRef+" - Hidden")
		return none ; Exhibitionist Location
	endIf
	
	; Current elevation to determine Marker being on same floor
	Keyword RefKeyword
	if HiddenRef.GetNumKeywords()
		RefKeyword = HiddenRef.GetNthKeyword(0)
	endIf
	ObjectReference[] XMarkerRef = MiscUtil.ScanCellObjects(HiddenRef.GetType(), CenterRef, Radius, RefKeyword)
	float Z = CenterRef.GetPositionZ()
	i = XMarkerRef.Length
	int iMax = 10	; Max of HiddenRef objects to check for performace reasons
	while i > 0 && iMax > 0
		i -= 1
		if XMarkerRef[i] && XMarkerRef[i] != none && XMarkerRef[i].GetBaseObject() == HiddenRef && !XMarkerRef[i].IsDisabled() && !XMarkerRef[i].IsOffLimits() && SameFloor(XMarkerRef[i], Z, Radius * 0.5) && LeveledAngle(XMarkerRef[i]); && XMarkerRef.Find(XMarkerRef[i]) == i
			if XMarkerRef[i].GetDistance(CenterRef) <= 300 ; Min PrivateRadius
				Log("FindHiddenReference() -- Find:"+XMarkerRef[i]+" - Too Near")
			elseIf Game.FindClosestActorFromRef(XMarkerRef[i], XMarkerRef[i].GetLength())
				Log("FindHiddenReference() -- Find:"+XMarkerRef[i]+" - InUse") ; Prevent Mannequin
				iMax -= 1
			else
				ActorsRef[0].SetLookAt(XMarkerRef[i], false)
				if !FindAvailableActorWornForm(0x00000004, XMarkerRef[i], PrivateRadius, -1, IgnoreRef[0], IgnoreRef[1], IgnoreRef[2], IgnoreRef[3], JustSameFloor = PrivateRadius < 600.0)
					Log("FindHiddenReference() -- Find:"+XMarkerRef[i]+" - Hidden")
					ActorsRef[0].ClearLookAt()
					return XMarkerRef[i]
				endIf
				Log("FindHiddenReference() -- Find:"+XMarkerRef[i]+" - Public")
				iMax -= 1
			endIf
		endIf
	endWhile
	ActorsRef[0].ClearLookAt()
	; No reference found in attempts
	return none
endFunction

bool Function LocationHasKeyword(Location LocationRef, Keyword LocKeyword)
	If !LocationRef || LocationRef == none
		Return False
	EndIf
	Return (LocationRef.HasKeyword(LocKeyword))
EndFunction

; TODO: Update the function to use the MiscUtil.ScanCellNPCs of the PapyrusUtil SE once be fixed
Actor function FindAvailableActor(ObjectReference CenterRef, float Radius = 5000.0, int FindGender = -1, Actor IgnoreRef1 = none, Actor IgnoreRef2 = none, Actor IgnoreRef3 = none, Actor IgnoreRef4 = none, string RaceKey = "")
	if !CenterRef || FindGender > 3 || FindGender < -1 || Radius < 0.1
		return none ; Invalid args
	endIf
	; Normalize creature genders search
	if RaceKey != "" || FindGender >= 2
		if FindGender == 0 || !Config.UseCreatureGender
			FindGender = 2
		elseIf FindGender == 1
			FindGender = 3
		endIf
	endIf
	; Create supression list
	Form[] Suppressed = new Form[25]
	Suppressed[24] = CenterRef
	Suppressed[23] = IgnoreRef1
	Suppressed[22] = IgnoreRef2
	Suppressed[21] = IgnoreRef3
	Suppressed[20] = IgnoreRef4
	; Attempt 20 times before giving up.
	int i = Suppressed.Length - 5
	while i > 0
		i -= 1
		Actor FoundRef = Game.FindRandomActorFromRef(CenterRef, Radius)
		if !FoundRef || FoundRef == none || (Suppressed.Find(FoundRef) == -1 && CheckActor(FoundRef, FindGender) && (RaceKey == "" || sslCreatureAnimationSlots.GetAllRaceKeys(FoundRef.GetLeveledActorBase().GetRace()).Find(RaceKey) != -1))
			return FoundRef ; None means no actor in radius, give up now
		endIf
		Suppressed[i] = FoundRef
	endWhile
	; No actor found in attempts
	return none
endFunction

Faction CurrentFollowerFaction ; TODO: Update the function to use the MiscUtil.ScanCellNPCsByFaction of the PapyrusUtil SE
Actor function FindAvailableActorInFaction(Faction FactionRef, ObjectReference CenterRef, float Radius = 5000.0, int FindGender = -1, Actor IgnoreRef1 = none, Actor IgnoreRef2 = none, Actor IgnoreRef3 = none, Actor IgnoreRef4 = none, bool HasFaction = True, string RaceKey = "", bool JustSameFloor = False)
	if !CenterRef || !FactionRef || FindGender > 3 || FindGender < -1 || Radius < 0.1
		return none ; Invalid args
	endIf
	; Normalize creature genders search
	if RaceKey != "" || FindGender >= 2
		if FindGender == 0 || !Config.UseCreatureGender
			FindGender = 2
		elseIf FindGender == 1
			FindGender = 3
		endIf
	endIf
	; Create supression list
	Form[] Suppressed = new Form[15] ; Reduce from 25 to 15 to gain speed
	Suppressed[14] = CenterRef
	Suppressed[13] = IgnoreRef1
	Suppressed[12] = IgnoreRef2
	Suppressed[11] = IgnoreRef3
	Suppressed[10] = IgnoreRef4
	; Attempt 20 times before giving up.
	float Z = CenterRef.GetPositionZ()
	int i = Suppressed.Length - 5
	while i > 0
		i -= 1
		Actor FoundRef = Game.FindRandomActorFromRef(CenterRef, Radius)
		if !FoundRef || (Suppressed.Find(FoundRef) == -1 && (!JustSameFloor || SameFloor(FoundRef, Z, 200)) && CheckActor(FoundRef, FindGender) && FoundRef.IsInFaction(FactionRef) == HasFaction && (RaceKey == "" || sslCreatureAnimationSlots.GetAllRaceKeys(FoundRef.GetLeveledActorBase().GetRace()).Find(RaceKey) != -1))
			return FoundRef ; None means no actor in radius, give up now
		endIf
		Suppressed[i] = FoundRef
	endWhile
	; No actor found in attempts
	return none
endFunction

Actor function FindAvailableActorWornForm(int slotMask, ObjectReference CenterRef, float Radius = 5000.0, int FindGender = -1, Actor IgnoreRef1 = none, Actor IgnoreRef2 = none, Actor IgnoreRef3 = none, Actor IgnoreRef4 = none, bool AvoidNoStripKeyword = True, bool HasWornForm = True, string RaceKey = "", bool JustSameFloor = False)
	if !CenterRef || slotMask < 1 || FindGender > 3 || FindGender < -1 || Radius < 0.1
		return none ; Invalid args
	endIf
	; Normalize creature genders search
	if RaceKey != "" || FindGender >= 2
		if FindGender == 0 || !Config.UseCreatureGender
			FindGender = 2
		elseIf FindGender == 1
			FindGender = 3
		endIf
	endIf
	; Create supression list
	Form[] Suppressed = new Form[15] ; Reduce from 25 to 15 to gain speed
	Suppressed[14] = CenterRef
	Suppressed[13] = IgnoreRef1
	Suppressed[12] = IgnoreRef2
	Suppressed[11] = IgnoreRef3
	Suppressed[10] = IgnoreRef4
	; Attempt 20 times before giving up.
	float Z = CenterRef.GetPositionZ()
	int i = Suppressed.Length - 5
	while i > 0
		i -= 1
		Actor FoundRef = Game.FindRandomActorFromRef(CenterRef, Radius)
		if !FoundRef || FoundRef == none
			return FoundRef ; None means no actor in radius, give up now
		endIf
		if (Suppressed.Find(FoundRef) == -1 && (!JustSameFloor || SameFloor(FoundRef, Z, 200)) && CheckActor(FoundRef, FindGender) && (RaceKey == "" || sslCreatureAnimationSlots.GetAllRaceKeys(FoundRef.GetLeveledActorBase().GetRace()).Find(RaceKey) != -1))
			
			Form ItemRef = FoundRef.GetWornForm(slotMask)
			if ((ItemRef && ItemRef != none) == HasWornForm) && (!AvoidNoStripKeyword || !(StorageUtil.FormListHas(none, "NoStrip", ItemRef) || SexLabUtil.HasKeywordSub(ItemRef, "NoStrip")))
				return FoundRef ; None means no actor in radius, give up now
			endIf
		endIf
		Suppressed[i] = FoundRef
	endWhile
	; No actor found in attempts
	return none
endFunction

; TODO: probably needs some love
Actor[] function FindAvailablePartners(actor[] Positions, int total, int males = -1, int females = -1, float radius = 10000.0)
	actor[] ActorsRef = PapyrusUtil.RemoveActor(PapyrusUtil.PushActor(Positions, none), none)
	int ActorCount = ActorsRef.Length
	int needed = (total - ActorCount)
	if needed <= 0
		return Positions ; Nothing to do
	endIf
	; Get needed gender counts based on current counts
	int[] Genders = ActorLib.GenderCount(ActorsRef)
	males -= Genders[0]
	females -= Genders[1]
	; Loop through until filled or we give up
	int attempts = 30
	while needed && attempts
		; Determine needed gender
		int findGender = -1
		if males > 0 && females < 1
			findGender = 0
		elseif females > 0 && males < 1
			findGender = 1
		endIf
		; Locate actor
		actor FoundRef
		if ActorCount == 2
			FoundRef = FindAvailableActor(ActorsRef[0], radius, findGender, ActorsRef[1])
		elseif ActorCount == 3
			FoundRef = FindAvailableActor(ActorsRef[0], radius, findGender, ActorsRef[1], ActorsRef[2])
		elseif ActorCount == 4
			FoundRef = FindAvailableActor(ActorsRef[0], radius, findGender, ActorsRef[1], ActorsRef[2], ActorsRef[3])
		else
			FoundRef = FindAvailableActor(ActorsRef[0], radius, findGender)
		endIf
		; Validate/Add them
		if !FoundRef
			return ActorsRef ; None means no actor in radius, give up now
		elseIf ActorsRef.Find(FoundRef) == -1
			; Add actor
			ActorsRef = PapyrusUtil.PushActor(ActorsRef, FoundRef)
			; Update search counts
			int gender = ActorLib.GetGender(FoundRef)
			males   -= (gender == 0) as int
			females -= (gender == 1) as int
			needed  -= 1
		endIf
		attempts -= 1
	endWhile
	; Output whatever we have at this point
	return ActorsRef
endFunction

Actor[] function FindAnimationPartners(sslBaseAnimation Animation, ObjectReference CenterRef, float Radius = 5000.0, Actor IncludedRef1 = none, Actor IncludedRef2 = none, Actor IncludedRef3 = none, Actor IncludedRef4 = none)
	if !Animation || !CenterRef
		return PapyrusUtil.ActorArray(0)
	endIf
	
	Actor[] IncludedActors = sslUtility.MakeActorArray(IncludedRef1, IncludedRef2, IncludedRef3, IncludedRef4)
	Actor[] Positions = PapyrusUtil.ActorArray(5)
	int i
	while i < Animation.PositionCount
		; Determine needed gender and race
		string RaceKey = ""
		int FindGender = Animation.GetGender(i)
		if FindGender > 1
			RaceKey = Animation.GetRaceTypes()[i]
		elseif FindGender > 0 && !(Animation.HasTag("Vaginal") || Animation.HasTag("Pussy") || Animation.HasTag("Cunnilingus") || Animation.HasTag("Futa"))
			FindGender = -1
		elseif FindGender == 0 && Config.UseStrapons && Animation.UseStrapon(i, 1)
			FindGender = -1
		endIf

		; Locate the actor between the included actors
		int a = IncludedActors.Length
		while a > 0 
			a -= 1
			if CheckActor(IncludedActors[a], FindGender) && (RaceKey == "" || sslCreatureAnimationSlots.GetAllRaceKeys(IncludedActors[a].GetLeveledActorBase().GetRace()).Find(RaceKey) != -1)
				Positions[i] = IncludedActors[a]
				IncludedActors = PapyrusUtil.RemoveActor(IncludedActors, IncludedActors[a])
				a = 0
			endIf
		endWhile
		
		; Find the nearby actor
		if !Positions[i] || Positions[i] == none
			Positions[i] = FindAvailableActor(CenterRef, Radius, FindGender, Positions[1], Positions[2], Positions[3], Positions[4], RaceKey)
			; One more time just in case
			if !Positions[i] || Positions[i] == none
				Positions[i] = FindAvailableActor(CenterRef, Radius, FindGender, Positions[1], Positions[2], Positions[3], Positions[4], RaceKey)
			endIf
		endIf
		
		
		if !Positions[i] || Positions[i] == none
			return PapyrusUtil.RemoveActor(Positions, none)
		elseIf IncludedActors.Length > 0
			IncludedActors = PapyrusUtil.RemoveActor(IncludedActors, Positions[i])
		endIf
		i += 1
	endWhile
	; Output whatever we have at this point
	return PapyrusUtil.RemoveActor(Positions, none)
endFunction

; TODO: probably needs more work
Actor[] function SortFurnitureActors(Actor[] Positions, int FurniturePosition)
	int ActorCount = Positions.Length
	if ActorCount < 2 || FurniturePosition < 0 || FurniturePosition >= ActorCount
		return Positions ; No need to sort actors.
	endIf
	; Check first occurance of priority furniture.
	int[] GendersAll = ActorLib.GetGendersAll(Positions)
	; Sort actors of priority furniture into start of array
	Actor[] Sorted
	GendersAll[FurniturePosition] = -1
	Sorted = PapyrusUtil.PushActor(Sorted, Positions[FurniturePosition])
	; Insert remaining actors
	int i = 0
	while i < ActorCount
		if GendersAll[i] != -1
			Sorted = PapyrusUtil.PushActor(Sorted, Positions[i])
		endIf
		i += 1
	endWhile
	; Return sorted actor array
	Log("SortFurnitureActors("+Positions+", "+FurniturePosition+") -- Return:"+Sorted)
	return Sorted
endFunction

Actor[] function SortActors(Actor[] Positions, bool FemaleFirst = true)
	int ActorCount = Positions.Length
	int Priority   = FemaleFirst as int
	if ActorCount < 2 || (ActorCount == 2 && ActorLib.GetGender(Positions[0]) == Priority)
		return Positions ; No need to sort actors.
	endIf
	; Check first occurance of priority gender.
	int[] GendersAll = ActorLib.GetGendersAll(Positions)
	int i = GendersAll.Find(Priority)
	if i == -1 ;|| (i == 0 && GendersAll.RFind(Priority) == 0)
		return Positions ; Prefered gender not present
	endIf
	; Sort actors of priority gender into start of array
	Actor[] Sorted
	while i < ActorCount
		; Priority gender or last actor, just add them.
		if GendersAll[i] == Priority
			GendersAll[i] = -1
			Sorted = PapyrusUtil.PushActor(Sorted, Positions[i])
		endIf
		i += 1
	endwhile
	; Insert remaining actors
	i = 0
	while i < ActorCount
		if GendersAll[i] != -1
			Sorted = PapyrusUtil.PushActor(Sorted, Positions[i])
		endIf
		i += 1
	endWhile
	; Return sorted actor array
	Log("SortActors("+Positions+") -- Return:"+Sorted)
	return Sorted
endFunction

bool Function IsLesserGender(int i, int n)
	; Male < Female < M.Cr < F.Cr
	return n != i && (i == 1 || i == 3 && n == 2 || i < n)
EndFunction

Actor[] function SortActorsByAnimation(actor[] Positions, sslBaseAnimation Animation = none)
	int ActorCount = Positions.Length
	if ActorCount < 2
		return Positions ; Nothing to sort
	endIf
	int[] Genders = ActorLib.GenderCount(Positions)
	int[] Futas = ActorLib.TransCount(Positions)
	int Creatures = Genders[2] + Genders[3]
	int HumanFutaCount = Futas[0] + Futas[1]
	if Creatures < 1
		if (HumanFutaCount >= 1 && (HumanFutaCount == ActorCount || (!Config.RestrictSameSex && Config.UseStrapons && !Animation.HasTag("Straight") && Genders[0] <= Futas[0]))) || (HumanFutaCount < 1 && (Genders[0] == ActorCount || Genders[1] == ActorCount))
			return Positions ; Nothing to sort
		elseIf Animation && Animation != none
			if Animation.Males < 1 || Animation.Females < 1 ;|| Genders == Animation.Genders
				return Positions ; Nothing to sort
			endIf
		endIf
	else
		return SortCreatures(Positions, Animation)
	endIf
	Actor[] Sorted = PapyrusUtil.ActorArray(ActorCount)
	int pos
	int i
	if !Animation || Animation == none || !Config.RestrictGenderTag
		return Positions
	elseIf !(Animation.HasTag("Straight") || Animation.HasTag("Vaginal") || Animation.HasTag("Pussy") || Animation.HasTag("Cunnilingus") || Animation.HasTag("Futa"))
		return Positions
	elseIf ActorCount != Animation.PositionCount
		return SortActors(Positions)
	else
		int[] GendersAll = ActorLib.GetGendersAll(Positions)
		int[] FutasAll = ActorLib.GetTransAll(Positions)

		pos = Positions.Length
		bool[] AnimStraponsPos = Utility.CreateBoolArray(pos)
		while pos > 0
			pos -= pos
			AnimStraponsPos[pos] = Animation.MalePosition(pos)
			i = Animation.StageCount
			while i > 0 && !AnimStraponsPos[pos]
				AnimStraponsPos[pos] = Animation.UseStrapon(pos, i)
				i -= 1
			endWhile
		endWhile

		i = 0
		while i < Animation.PositionCount
			int futa = -1
			int better = -1
			int alt = -1
			int first = -1
			pos = 0
			while pos < ActorCount
				if (!Sorted[i] || Sorted[i] == none) 
					if Sorted.Find(Positions[pos]) < 0
						if HumanFutaCount < 1 && (Genders[1] < 1 || Genders[0] < 1 || (Animation.Females == Genders[1] && !(!Config.RestrictGenderTag || Animation.HasTag("Straight") || Animation.HasTag("Vaginal") || Animation.HasTag("Pussy") || Animation.HasTag("Cunnilingus"))))
							Sorted[i] = Positions[pos]
						else
							if better < 0 && FutasAll[pos] == -1 && Animation.GetGender(i) == GendersAll[pos]
								better = pos
							elseIf futa < 0 && FutasAll[pos] != -1 ;&& (!Animation.HasTag("Futa") || GendersAll[pos] == FutasAll[pos])
								futa = pos
							elseIf alt < 0 && Animation.GetGender(i) == GendersAll[pos]
								alt = pos
							elseIf first < 0
								first = pos
							endIf
							If (pos + 1) >= ActorCount
								if Animation.HasTag("Futa") && !AnimStraponsPos[i] ; For futa animations the Futa actors are the priority
									if futa >= 0
										Sorted[i] = Positions[futa]
									elseIf better >= 0
										Sorted[i] = Positions[better]
									elseIf alt >= 0
										Sorted[i] = Positions[alt]
									elseIf first >= 0
										Sorted[i] = Positions[first]
									endIf
								else
									if better >= 0
										Sorted[i] = Positions[better]
									elseIf futa >= 0
										Sorted[i] = Positions[futa]
									elseIf alt >= 0
										Sorted[i] = Positions[alt]
									elseIf first >= 0
										Sorted[i] = Positions[first]
									endIf
								endIf
							endIf
						endIf
					elseIf (pos + 1) >= ActorCount 
						if Animation.HasTag("Futa") && !AnimStraponsPos[i] ; For futa animations the Futa actors are the priority
							if futa >= 0
								Sorted[i] = Positions[futa]
							elseIf better >= 0
								Sorted[i] = Positions[better]
							elseIf alt >= 0
								Sorted[i] = Positions[alt]
							elseIf first >= 0
								Sorted[i] = Positions[first]
							endIf
						else
							if better >= 0
								Sorted[i] = Positions[better]
							elseIf futa >= 0
								Sorted[i] = Positions[futa]
							elseIf alt >= 0
								Sorted[i] = Positions[alt]
							elseIf first >= 0
								Sorted[i] = Positions[first]
							endIf
						endIf
					endIf
				endIf
				pos += 1
			endWhile
			i += 1
		endWhile
	endIf
	if Sorted.Find(none) < 0
		Log("SortActorsByAnimation("+Positions+", "+Animation+") -- Return:"+Sorted)
		return Sorted
	else
		Log("SortActorsByAnimation("+Positions+", "+Animation+") -- Failed to sort actors '"+Sorted+"' -- They were unable to fill an actor position","FATAL")
		return Positions
	endIf
endFunction

int function FindNext(Actor[] Positions, sslBaseAnimation Animation, int offset, bool FindCreature)
	while offset
		offset -= 1
		if Animation.HasRace(Positions[offset].GetLeveledActorBase().GetRace()) == FindCreature
			return offset
		endIf
	endwhile
	return -1
endFunction

Actor[] function SortCreatures(actor[] Positions, sslBaseAnimation Animation = none)
	int ActorCount = Positions.Length
	if ActorCount < 2
		return Positions ; Nothing to sort
	endIf
	int[] Genders = ActorLib.GenderCount(Positions)
	int Creatures = Genders[2] + Genders[3]
	if Creatures < 1
		return SortActorsByAnimation(Positions, Animation) ; Nothing to sort
	endIf
	Actor[] Sorted = PapyrusUtil.ActorArray(ActorCount)
	int pos
	int i
	if !Animation || Animation == none
		i = ActorCount
		while i > 0
			i -= 1
			pos = ActorCount
			while pos > 0
				pos -= 1
				if (!Sorted[i] || Sorted[i] == none) && Sorted.Find(Positions[pos]) < 0
					; Put creatures last
					if Creatures > ActorLib.CreatureCount(Sorted)
						if ActorLib.IsCreature(Positions[i])
							Sorted[i] = Positions[pos]
							pos = 0
						endIf
					else
						if !ActorLib.IsCreature(Positions[i])
							Sorted[i] = Positions[pos]
							pos = 0
						endIf
					endIf
				endIf
			endWhile
		endWhile
	elseIf ActorCount != Animation.PositionCount || Creatures != Animation.Creatures
		Sorted = Positions
		while i < Sorted.Length
			; Put non creatures first
			if !Animation.HasRace(Sorted[i].GetLeveledActorBase().GetRace()) && i > pos
				Actor moved = Sorted[pos]
				Sorted[pos] = Sorted[i]
				Sorted[i] = moved
				pos += 1
			endIf
			i += 1
		endWhile
	else
		int[] GendersAll = ActorLib.GetGendersAll(Positions)
		int[] Futas = ActorLib.TransCount(Positions)
		int[] FutasAll = ActorLib.GetTransAll(Positions)
		int HumanFutaCount = Futas[0] + Futas[1]

		pos = Positions.Length
		bool[] AnimStraponsPos = Utility.CreateBoolArray(pos)
		while pos > 0
			pos -= pos
			AnimStraponsPos[pos] = Animation.MalePosition(pos)
			i = Animation.StageCount
			while i > 0 && !AnimStraponsPos[pos]
				AnimStraponsPos[pos] = Animation.UseStrapon(pos, i)
				i -= 1
			endWhile
		endWhile

		i = Animation.PositionCount
		while i > 0
			i -= 1
			int futa = -1
			int better = -1
			int alt = -1
			int first = -1
			pos = ActorCount
			while pos > 0
				pos -= 1
				if (!Sorted[i] || Sorted[i] == none)
					if Sorted.Find(Positions[pos]) < 0 ; Sorted[i] != Positions[pos]
						if Animation.CreaturePosition(i)
							if ActorLib.IsCreature(Positions[pos])
								if Animation.HasPostionRace(i,sslCreatureAnimationSlots.GetAllRaceKeys(Positions[pos].GetLeveledActorBase().GetRace()))
									if !Config.UseCreatureGender
										Sorted[i] = Positions[pos]
									else
										if better < 0 && FutasAll[pos] == -1 && Animation.GetGender(i) == GendersAll[pos]
											better = pos
										elseIf futa < 0 && FutasAll[pos] != -1 ;&& (!Animation.HasTag("Futa") || GendersAll[pos] == FutasAll[pos])
											futa = pos
										elseIf alt < 0 && Animation.GetGender(i) == GendersAll[pos]
											alt = pos
										elseIf first < 0
											first = pos
										endIf
										if pos < 1
											if Animation.HasTag("Futa") && !AnimStraponsPos[i] ; For futa animations the Futa actors are the priority
												if futa >= 0
													Sorted[i] = Positions[futa]
												elseIf better >= 0
													Sorted[i] = Positions[better]
												elseIf alt >= 0
													Sorted[i] = Positions[alt]
												elseIf first >= 0
													Sorted[i] = Positions[first]
												endIf
											else
												if better >= 0
													Sorted[i] = Positions[better]
												elseIf futa >= 0
													Sorted[i] = Positions[futa]
												elseIf alt >= 0
													Sorted[i] = Positions[alt]
												elseIf first >= 0
													Sorted[i] = Positions[first]
												endIf
											endIf
										endIf
									endIf
								elseIf pos < 1
									if Animation.HasTag("Futa") && !AnimStraponsPos[i] ; For futa animations the Futa actors are the priority
										if futa >= 0
											Sorted[i] = Positions[futa]
										elseIf better >= 0
											Sorted[i] = Positions[better]
										elseIf alt >= 0
											Sorted[i] = Positions[alt]
										elseIf first >= 0
											Sorted[i] = Positions[first]
										endIf
									else
										if better >= 0
											Sorted[i] = Positions[better]
										elseIf futa >= 0
											Sorted[i] = Positions[futa]
										elseIf alt >= 0
											Sorted[i] = Positions[alt]
										elseIf first >= 0
											Sorted[i] = Positions[first]
										endIf
									endIf
								endIf
							elseIf pos < 1
								if Animation.HasTag("Futa") && !AnimStraponsPos[i] ; For futa animations the Futa actors are the priority
									if futa >= 0
										Sorted[i] = Positions[futa]
									elseIf better >= 0
										Sorted[i] = Positions[better]
									elseIf alt >= 0
										Sorted[i] = Positions[alt]
									elseIf first >= 0
										Sorted[i] = Positions[first]
									endIf
								else
									if better >= 0
										Sorted[i] = Positions[better]
									elseIf futa >= 0
										Sorted[i] = Positions[futa]
									elseIf alt >= 0
										Sorted[i] = Positions[alt]
									elseIf first >= 0
										Sorted[i] = Positions[first]
									endIf
								endIf
							endIf
						else
							if !ActorLib.IsCreature(Positions[pos])
								if HumanFutaCount < 1 && (Animation.Females < 1 || Genders[1] < 1 || Animation.Males < 1 || Genders[0] < 1 || (Animation.Females == Genders[1] && !(!Config.RestrictGenderTag || Animation.HasTag("Straight") || Animation.HasTag("Vaginal") || Animation.HasTag("Pussy") || Animation.HasTag("Cunnilingus"))))
									Sorted[i] = Positions[pos]
								else
									if better < 0 && FutasAll[pos] == -1 && Animation.GetGender(i) == GendersAll[pos]
										better = pos
									elseIf futa < 0 && FutasAll[pos] != -1 ;&& (!Animation.HasTag("Futa") || GendersAll[pos] == FutasAll[pos])
										futa = pos
									elseIf alt < 0 && Animation.GetGender(i) == GendersAll[pos]
										alt = pos
									elseIf first < 0
										first = pos
									endIf
									if pos < 1
										if Animation.HasTag("Futa") && !AnimStraponsPos[i] ; For futa animations the Futa actors are the priority
											if futa >= 0
												Sorted[i] = Positions[futa]
											elseIf better >= 0
												Sorted[i] = Positions[better]
											elseIf alt >= 0
												Sorted[i] = Positions[alt]
											elseIf first >= 0
												Sorted[i] = Positions[first]
											endIf
										else
											if better >= 0
												Sorted[i] = Positions[better]
											elseIf futa >= 0
												Sorted[i] = Positions[futa]
											elseIf alt >= 0
												Sorted[i] = Positions[alt]
											elseIf first >= 0
												Sorted[i] = Positions[first]
											endIf
										endIf
									endIf
								endIf
							elseIf pos < 1
								if Animation.HasTag("Futa") && !AnimStraponsPos[i] ; For futa animations the Futa actors are the priority
									if futa >= 0
										Sorted[i] = Positions[futa]
									elseIf better >= 0
										Sorted[i] = Positions[better]
									elseIf alt >= 0
										Sorted[i] = Positions[alt]
									elseIf first >= 0
										Sorted[i] = Positions[first]
									endIf
								else
									if better >= 0
										Sorted[i] = Positions[better]
									elseIf futa >= 0
										Sorted[i] = Positions[futa]
									elseIf alt >= 0
										Sorted[i] = Positions[alt]
									elseIf first >= 0
										Sorted[i] = Positions[first]
									endIf
								endIf
							endIf
						endIf
					elseIf pos < 1
						if Animation.HasTag("Futa") && !AnimStraponsPos[i] ; For futa animations the Futa actors are the priority
							if futa >= 0
								Sorted[i] = Positions[futa]
							elseIf better >= 0
								Sorted[i] = Positions[better]
							elseIf alt >= 0
								Sorted[i] = Positions[alt]
							elseIf first >= 0
								Sorted[i] = Positions[first]
							endIf
						else
							if better >= 0
								Sorted[i] = Positions[better]
							elseIf futa >= 0
								Sorted[i] = Positions[futa]
							elseIf alt >= 0
								Sorted[i] = Positions[alt]
							elseIf first >= 0
								Sorted[i] = Positions[first]
							endIf
						endIf
					endIf
				endIf
			endWhile
		endWhile
	endIf
	if Sorted.Find(none) < 0
		Log("SortCreatures("+Positions+", "+Animation+") -- Return:"+Sorted)
		return Sorted
	else
		Log("SortCreatures("+Positions+", "+Animation+") -- Failed to sort actors '"+Sorted+"' -- They were unable to fill an actor position","FATAL")
		return Positions
	endIf
endFunction

bool function IsBedRoll(ObjectReference BedRef)
	if BedRef 
		return BedRef.HasKeyword(FurnitureBedRoll) || BedRollsList.HasForm(BedRef.GetBaseObject()) \
			|| StringUtil.Find(BedRef.GetDisplayName(), "roll") != -1 || StringUtil.Find(BedRef.GetDisplayName(), "pile") != -1
	endIf
	return false
endFunction

bool function IsDoubleBed(ObjectReference BedRef)
	return BedRef && DoubleBedsList.HasForm(BedRef.GetBaseObject())
endFunction

bool function IsSingleBed(ObjectReference BedRef)
	return BedRef && BedsList.HasForm(BedRef.GetBaseObject()) && !BedRollsList.HasForm(BedRef.GetBaseObject()) && !DoubleBedsList.HasForm(BedRef.GetBaseObject())
endFunction

int function GetBedType(ObjectReference BedRef)
	if BedRef
		Form BaseRef = BedRef.GetBaseObject()
		if !BedsList.HasForm(BaseRef)
			return 0
		elseIf IsBedRoll(Bedref);BedRollsList.HasForm(BedRef.GetBaseObject()) || BedRef.HasKeyword(FurnitureBedRoll)
			return 1
		elseIf DoubleBedsList.HasForm(BaseRef)
			return 3
		else
			return 2
		endIf
	endIf
	return 0
endFunction

bool function IsBedAvailable(ObjectReference BedRef)
	; Check furniture use
	if !BedRef || BedRef.IsFurnitureInUse(true)
		return false
	endIf
	; Check if used by a current thread
	sslThreadController[] Threads = ThreadSlots.Threads
	int i
	while i < 15
		if Threads[i].BedRef == BedRef
			return false
		endIf
		i += 1
	endwhile
	; Bed is free for use
	return true
endFunction

bool function CheckBed(ObjectReference BedRef, bool IgnoreUsed = true)
	return BedRef && BedRef.IsEnabled() && !BedRef.IsDeleted() && BedRef.Is3DLoaded() && (!IgnoreUsed || (IgnoreUsed && IsBedAvailable(BedRef)))
endFunction

bool function LeveledAngle(ObjectReference ObjectRef, float Tolerance = 5.0)
	return ObjectRef && Math.Abs(ObjectRef.GetAngleX()) <= Tolerance && Math.Abs(ObjectRef.GetAngleY()) <= Tolerance
endFunction

bool function SameFloor(ObjectReference BedRef, float Z, float Tolerance = 15.0)
	return BedRef && Math.Abs(Z - BedRef.GetPositionZ()) <= Tolerance
endFunction

ObjectReference function FindBed(ObjectReference CenterRef, float Radius = 1000.0, bool IgnoreUsed = true, ObjectReference IgnoreRef1 = none, ObjectReference IgnoreRef2 = none)
	if !CenterRef || CenterRef == none || Radius < 1.0
		return none ; Invalid args
	endIf
	;try with the one in use
	ObjectReference BedRef
	if (CenterRef as Actor)
		BedRef = (CenterRef as Actor).GetFurnitureReference()
		if BedRef && BedsList.HasForm(BedRef) && (BedRef != IgnoreRef1 && BedRef != IgnoreRef2 && CheckBed(BedRef, false))
			return BedRef
		endIf
	endIf
	; Current elevation to determine bed being on same floor
	float Z = CenterRef.GetPositionZ()
	; Search a couple times for a nearby bed on the same elevation first before looking for random
	BedRef = Game.FindClosestReferenceOfAnyTypeInListFromRef(BedsList, CenterRef, Radius)
	if !BedRef || (BedRef != IgnoreRef1 && BedRef != IgnoreRef2 && SameFloor(BedRef, Z) && LeveledAngle(BedRef) && CheckBed(BedRef, IgnoreUsed))
		return BedRef
	endIf
	ObjectReference NearRef
	Form[] Suppressed = new Form[10]
	Suppressed[9] = BedRef
	Suppressed[8] = IgnoreRef1
	Suppressed[7] = IgnoreRef2
	int LastNull = Suppressed.RFind(none)
	int i = BedsList.GetSize()
	while i
		i -= 1
		Form BedType = BedsList.GetAt(i)
		if BedType
			BedRef = Game.FindClosestReferenceOfTypeFromRef(BedType, CenterRef, Radius)
			if BedRef && Suppressed.Find(BedRef) == -1
				if SameFloor(BedRef, Z, 200) && LeveledAngle(BedRef) && CheckBed(BedRef, IgnoreUsed)
					if (!NearRef || BedRef.GetDistance(CenterRef) < NearRef.GetDistance(CenterRef))
						NearRef = BedRef
					endIf
				elseIf LastNull >= 0
					Suppressed[LastNull]
					LastNull = Suppressed.RFind(none)
				endIf
			endIf
		endIf
	endWhile
	if NearRef && NearRef != none
		return NearRef
	endIf
;	BedRef = Game.FindRandomReferenceOfAnyTypeInListFromRef(BedsList, CenterRef, Radius)
;	if !BedRef || (BedRef != IgnoreRef1 && BedRef != IgnoreRef2 && SameFloor(BedRef, Z) && LeveledAngle(BedRef) && CheckBed(BedRef, IgnoreUsed))
;		return BedRef
;	endIf
;	BedRef = Game.FindRandomReferenceOfAnyTypeInListFromRef(BedsList, CenterRef, Radius)
;	if !BedRef || (BedRef != IgnoreRef1 && BedRef != IgnoreRef2 && SameFloor(BedRef, Z) && LeveledAngle(BedRef) && CheckBed(BedRef, IgnoreUsed))
;		return BedRef
;	endIf
	; Failover to any random useable bed
	i = LastNull + 1
	while i
		i -= 1
		BedRef = Game.FindRandomReferenceOfAnyTypeInListFromRef(BedsList, CenterRef, Radius)
		if !BedRef || (Suppressed.Find(BedRef) == -1 && SameFloor(BedRef, Z, Radius * 0.5) && LeveledAngle(BedRef) && CheckBed(BedRef, IgnoreUsed))
			return BedRef ; Found valid bed or none nearby and we should give up
		else
			Suppressed[i] = BedRef ; Add to suppression list
		endIf
	endWhile
	return none ; Nothing found in search loop
endFunction

int function GetFurnitureType(ObjectReference FurnitureRef)
	if FurnitureRef
		return Config.GetFurnitureType(FurnitureRef.GetBaseObject())
	endIf
	return -1
endFunction

bool function IsFurnitureAvailable(ObjectReference FurnitureRef)
	; Check furniture use
	if !FurnitureRef || FurnitureRef.IsFurnitureInUse(true)
		return false
	endIf
	; Check if used by a current thread
	sslThreadController[] Threads = ThreadSlots.Threads
	int i
	while i < 15
		if Threads[i].FurnitureRef == FurnitureRef
			return false
		endIf
		i += 1
	endwhile
	; Bed is free for use
	return true
endFunction

bool function CheckFurniture(ObjectReference FurnitureRef, bool IgnoreUsed = true)
	return FurnitureRef && FurnitureRef.IsEnabled() && !FurnitureRef.IsDeleted() && FurnitureRef.Is3DLoaded() && (!IgnoreUsed || (IgnoreUsed && IsFurnitureAvailable(FurnitureRef)))
endFunction

bool function SetActorFurniture(Actor akActor, ObjectReference akFurniture, bool Restrictive = true)
	if !akActor || akActor == none
		return false
	endIf
	; Check actor in current thread
	sslThreadController[] Threads = ThreadSlots.Threads
	sslActorAlias Slot
	int i
	while i < 15
		Slot = Threads[i].ActorAlias(akActor)
		if Slot != none
			Slot.SetFurnitureRef(akFurniture, Restrictive)
			return true
		endIf
		i += 1
	endwhile
	return false
endFunction

ObjectReference function FindFurnitureByType(int Type = -1, ObjectReference CenterRef, float Radius = 1000.0, bool IgnoreUsed = true, ObjectReference IgnoreRef1 = none, ObjectReference IgnoreRef2 = none)
	if !CenterRef || CenterRef == none || Radius < 1.0 || Type < 0
		return none ; Invalid args
	endIf
	; Current elevation to determine furniture being on same floor
	float Z = CenterRef.GetPositionZ()
	; Search a couple times for a nearby furniture on the same elevation first before looking for random
	FormList TempFurnitureLists
	if Type < Config.FurnitureExtraLists.Length
		TempFurnitureLists = Config.FurnitureExtraLists[Type]
	elseIf Type >= Config.FurnitureExtraLists.Length
		TempFurnitureLists = Config.FurnitureRestrainLists[Type-Config.FurnitureExtraLists.Length]
	endIf
	;try with the one in use
	ObjectReference FurnitureRef
	if (CenterRef as Actor)
		FurnitureRef = (CenterRef as Actor).GetFurnitureReference()
		if FurnitureRef && TempFurnitureLists.HasForm(FurnitureRef) && (FurnitureRef != IgnoreRef1 && FurnitureRef != IgnoreRef2 && CheckFurniture(FurnitureRef, false))
			return FurnitureRef
		endIf
	endIf
	FurnitureRef = Game.FindClosestReferenceOfAnyTypeInListFromRef(TempFurnitureLists, CenterRef, Radius)
	if !FurnitureRef || (FurnitureRef != IgnoreRef1 && FurnitureRef != IgnoreRef2 && SameFloor(FurnitureRef, Z) && LeveledAngle(FurnitureRef) && CheckFurniture(FurnitureRef, IgnoreUsed))
		return FurnitureRef
	endIf
	ObjectReference NearRef
	Form[] Suppressed = new Form[10]
	Suppressed[9] = FurnitureRef
	Suppressed[8] = IgnoreRef1
	Suppressed[7] = IgnoreRef2
	int i = TempFurnitureLists.GetSize()
	int LastNull = Suppressed.RFind(none)
	while i
		i -= 1
		Form FurnitureType = TempFurnitureLists.GetAt(i)
		if FurnitureType
			FurnitureRef = Game.FindClosestReferenceOfTypeFromRef(FurnitureType, CenterRef, Radius)
			if FurnitureRef && Suppressed.Find(FurnitureRef) == -1
				if SameFloor(FurnitureRef, Z, 200) && LeveledAngle(FurnitureRef) && CheckFurniture(FurnitureRef, IgnoreUsed)
					if (!NearRef || FurnitureRef.GetDistance(CenterRef) < NearRef.GetDistance(CenterRef))
						NearRef = FurnitureRef
					endIf
				elseIf LastNull >= 0
					Suppressed[LastNull]
					LastNull = Suppressed.RFind(none)
				endIf
			endIf
		endIf
	endWhile
	if NearRef && NearRef != none
		return NearRef
	endIf
;	FurnitureRef = Game.FindRandomReferenceOfAnyTypeInListFromRef(TempFurnitureLists, CenterRef, Radius)
;	if !FurnitureRef || (Suppressed.Find(FurnitureRef) == -1 && SameFloor(FurnitureRef, Z) && LeveledAngle(FurnitureRef) && CheckFurniture(FurnitureRef, IgnoreUsed))
;		return FurnitureRef
;	endIf
;	FurnitureRef = Game.FindRandomReferenceOfAnyTypeInListFromRef(TempFurnitureLists, CenterRef, Radius)
;	if !FurnitureRef || (Suppressed.Find(FurnitureRef) == -1 && SameFloor(FurnitureRef, Z) && LeveledAngle(FurnitureRef) && CheckFurniture(FurnitureRef, IgnoreUsed))
;		return FurnitureRef
;	endIf
	; Failover to any random useable Furniture
	i = LastNull + 1
	while i
		i -= 1
		FurnitureRef = Game.FindRandomReferenceOfAnyTypeInListFromRef(TempFurnitureLists, CenterRef, Radius)
		if !FurnitureRef || (Suppressed.Find(FurnitureRef) == -1 && SameFloor(FurnitureRef, Z, Radius * 0.5) && LeveledAngle(FurnitureRef) && CheckFurniture(FurnitureRef, IgnoreUsed))
			return FurnitureRef ; Found valid Furniture or none nearby and we should give up
		else
			Suppressed[i] = FurnitureRef ; Add to suppression list
		endIf
	endWhile
	return none
endFunction

ObjectReference function FindFurnitureForAnimation(actor[] Positions, sslBaseAnimation Animation, ObjectReference CenterRef, float Radius = 1000.0, bool IgnoreUsed = true, ObjectReference IgnoreRef1 = none, ObjectReference IgnoreRef2 = none, int HiddenType = -1)
	int ActorCount = Positions.Length
	if !Config.AllowFurniture || !CenterRef || ActorCount < 1 || !Config.FurnitureExtraLists || Config.FurnitureExtraLists.Length < 1 || Radius < 1.0
		return none ; Invalid args
	endIf
	Log("FindFurnitureForAnimation() -- ActorCount:"+ActorCount+"; Animation:"+Animation+"; CenterRef:"+CenterRef+"; Radius:"+Radius+"; IgnoreUsed:"+IgnoreUsed+"; IgnoreRef1:"+IgnoreRef1+"; IgnoreRef2:"+IgnoreRef2+"; HiddenType:"+HiddenType)
	int[] Genders = ActorLib.GenderCount(Positions)
	int Creatures = Genders[2] + Genders[3]
	bool IsCreature = Creatures > 0
	bool HasPlayer  = Positions.Find(PlayerRef) != -1
	
	ObjectReference[] UsedFurniture = new ObjectReference[5]
	int i = 0
	if !Animation || Animation == none
		sslBaseAnimation[] Animations
		if IsCreature
			Animations = CreatureSlots.GetByCreatureActorsTags(ActorCount, Positions, PapyrusUtil.StringJoin(Config.ActiveFurnitureTags), "", False)
			; Remove filtered tags from animations
			Animations = sslUtility.FilterTaggedAnimations(Animations, PapyrusUtil.StringArray(1, "Furniture"), true)
		else
			Animations = AnimSlots.GetByCommonTags(ActorCount, "Furniture", PapyrusUtil.StringJoin(Config.ActiveFurnitureTags), "", False)
		endIf
		if Animations.Length < 1
			return none ; None Furniture Animations
		endIf
		; Remove any animations without filtered gender tags
		if Config.RestrictGenderTag && ActorCount < 3
			string DefGenderTag = ""
			i = ActorCount
			int[] GendersAll = ActorLib.GetGendersAll(Positions)
			int[] Futas = ActorLib.TransCount(Positions)
			int[] FutasAll = ActorLib.GetTransAll(Positions)
			while i ;Make Position Gender Tag
				i -= 1
				if GendersAll[i] == 0
					DefGenderTag = "M" + DefGenderTag
				elseIf GendersAll[i] == 1
					DefGenderTag = "F" + DefGenderTag
				elseIf GendersAll[i] >= 2
					DefGenderTag = "C" + DefGenderTag
				endIf
			endWhile
			if DefGenderTag != ""
				string[] GenderTag = Utility.CreateStringArray(1, DefGenderTag)
				;Make Extra Position Gender Tag if actor is Futa or female use strapon
				i = ActorCount
				while i
					i -= 1
					if (Config.UseStrapons && GendersAll[i] == 1) || (FutasAll[i] == 1)
						if StringUtil.GetNthChar(DefGenderTag, ActorCount - i) == "F"
							GenderTag = PapyrusUtil.PushString(GenderTag, StringUtil.Substring(DefGenderTag, 0, ActorCount - i) + "M" + StringUtil.Substring(DefGenderTag, (ActorCount - i) + 1))
						endIf
					elseIf (FutasAll[i] == 0)
						if StringUtil.GetNthChar(DefGenderTag, ActorCount - i) == "M"
							GenderTag = PapyrusUtil.PushString(GenderTag, StringUtil.Substring(DefGenderTag, 0, ActorCount - i) + "F" + StringUtil.Substring(DefGenderTag, (ActorCount - i) + 1))
						endIf
					endIf
				endWhile
				;Add the Default Gender Tag to get more valid results
				if Config.UseStrapons
					DefGenderTag = ActorLib.GetGenderTag(0, Genders[0] + Genders[1], Creatures)
					if GenderTag.Find(DefGenderTag) < 0
						GenderTag = PapyrusUtil.PushString(GenderTag, DefGenderTag)
					endIf
				endIf
				DefGenderTag = ActorLib.GetGenderTag(Genders[1], Genders[0], Creatures)
				if GenderTag.Find(DefGenderTag) < 0
					GenderTag = PapyrusUtil.PushString(GenderTag, DefGenderTag)
				endIf
				DefGenderTag = ActorLib.GetGenderTag(Genders[1] + Futas[0] - Futas[1], Genders[0] - Futas[0] + Futas[1], Creatures)
				if GenderTag.Find(DefGenderTag) < 0
					GenderTag = PapyrusUtil.PushString(GenderTag, DefGenderTag)
				endIf
				; Remove filtered gender tags from primary
				Animations = sslUtility.FilterTaggedAnimations(Animations, GenderTag, true)
				if Animations.Length < 1
					return none ; None Furniture Animations
				endIf
			endIf
		endIf
		i = 0
		while i < ActorCount
			UsedFurniture[i] = Positions[i].GetFurnitureReference()
			if UsedFurniture[i] && UsedFurniture[i] != none && UsedFurniture[i].GetDistance(CenterRef) <= Radius
				if GetBedType(UsedFurniture[i]) > 0
					Log("FindFurnitureForAnimation() -- Find:"+UsedFurniture[i]+" - InUse")
					return UsedFurniture[i]
				else
					int iFurn = GetFurnitureType(UsedFurniture[i])
					Log("Position["+i+"].FurnitureReference:'"+UsedFurniture[i].GetBaseObject()+"'; TagIndex:"+iFurn)
					if iFurn != -1 && Config.ActiveFurnitureTags.Find(Config.FurnitureTags[iFurn]) >= 0
						Log("Looking for Animations with FurnitureTags:'"+Config.FurnitureTags[iFurn]+"'; TagIndex:"+iFurn)
						if sslUtility.FilterTaggedAnimations(Animations, PapyrusUtil.StringArray(1, Config.FurnitureTags[iFurn]), true).Length > 0
							SetActorFurniture(Positions[i], UsedFurniture[i], iFurn >= Config.FurnitureExtraLists.Length)
							Log("FindFurnitureForAnimation() -- Find:"+UsedFurniture[i]+" - InUse")
							return UsedFurniture[i]
						endIf
					endIf
				endIf
			endIf
			i += 1
		endWhile
		
		ObjectReference TempRef
		i = Config.FurnitureTags.Length
		int FoundID = -1
		while i > 0 && FoundID < 4
			i -= 1
			if Config.ActiveFurnitureTags.Find(Config.FurnitureTags[i]) >= 0 && sslUtility.FilterTaggedAnimations(Animations, PapyrusUtil.StringArray(1, Config.FurnitureTags[i]), true).Length > 0
				Log("Looking for Furniture TypeTag:'"+Config.FurnitureTags[i]+"'; TagIndex:"+i)
				TempRef = FindFurnitureByType(i, CenterRef, Radius, IgnoreUsed, IgnoreRef1, IgnoreRef2)
				if TempRef && TempRef != none
					FoundID += 1
					UsedFurniture[FoundID] = TempRef
					Log("Furniture:"+UsedFurniture[FoundID]+" of Type:'"+Config.FurnitureTags[i]+"' Founded")
				endIf
			endIf
		endWhile
		if FoundID >= 0
			Actor[] IgnoreRef = new Actor[4]
			bool isExhibitionist = False
			float PrivateRadius = 900.0
			if HiddenType >= 0 && Radius > PrivateRadius
				while i < IgnoreRef.Length && !isExhibitionist
					if i < ActorCount
						if !Positions[i].GetWornForm(0x00000004)
							isExhibitionist = True
						endIf
						IgnoreRef[i] = Positions[i]
					else
						i = IgnoreRef.Length
					endIf
					i += 1
				endWhile
				if !CurrentFollowerFaction
					CurrentFollowerFaction = Game.GetFormFromFile(0x5C84E, "Skyrim.esm") as Faction
				endIf
				i = IgnoreRef.Length - ActorCount
				while i && i < IgnoreRef.Length
					TempRef = FindAvailableActorInFaction(CurrentFollowerFaction, CenterRef, Radius, -1, IgnoreRef[0], IgnoreRef[1], IgnoreRef[2], IgnoreRef[3])
					if TempRef
						IgnoreRef[i] = TempRef as Actor
						i += 1
					else
						i = IgnoreRef.Length
					endIf
				endWhile
				if CenterRef.IsInInterior()
					Radius = Radius * 0.5
					PrivateRadius = 600.0
					if LocationHasKeyword(CenterRef.GetCurrentLocation(), Keyword.GetKeyword("LocTypeInn"))
						PrivateRadius = 300.0
					endIf
				endIf
			endIf
			TempRef = none
			while FoundID >= 0
				if HiddenType >= 0 && !isExhibitionist && Radius > PrivateRadius
					if !FindAvailableActorWornForm(0x00000004, UsedFurniture[FoundID], PrivateRadius, -1, IgnoreRef[0], IgnoreRef[1], IgnoreRef[2], IgnoreRef[3], JustSameFloor = PrivateRadius < 600.0)
						Log("FindFurnitureForAnimation() -- Find:"+UsedFurniture[FoundID]+" - Hidden")
						return UsedFurniture[FoundID] ; Exhibitionist Location
					endIf
				endIf
				if !TempRef || TempRef == none || TempRef.GetDistance(CenterRef) > UsedFurniture[FoundID].GetDistance(CenterRef)
					TempRef = UsedFurniture[FoundID]
				endIf
				FoundID -= 1
			endWhile
			if TempRef && TempRef != none && HiddenType < 1
				Log("FindFurnitureForAnimation() -- Find:"+TempRef+" - Near")
				return TempRef
			endIf
		endIf
	elseIf Animation && Animation != none
		IsCreature = Animation.IsCreature
		while i < ActorCount
			UsedFurniture[i] = Positions[i].GetFurnitureReference()
			if UsedFurniture[i] && UsedFurniture[i] != none && UsedFurniture[i].GetDistance(CenterRef) <= Radius
				if !Animation.HasTag("Furniture") 
					if GetBedType(UsedFurniture[i]) > 0
						Log("FindFurnitureForAnimation() -- Find:"+UsedFurniture[i]+" - InUse")
						return UsedFurniture[i]
					endIf
				else
					int iFurn = GetFurnitureType(UsedFurniture[i])
					if iFurn != -1 && Config.ActiveFurnitureTags.Find(Config.FurnitureTags[iFurn]) >= 0 && Animation.HasTag(Config.FurnitureTags[iFurn])
						SetActorFurniture(Positions[i], UsedFurniture[i], iFurn >= Config.FurnitureExtraLists.Length)
						Log("FindFurnitureForAnimation() -- Find:"+UsedFurniture[i]+" - InUse")
						return UsedFurniture[i]
					endIf
				endIf
			endIf
			i += 1
		endWhile	
		
		ObjectReference TempRef
		Actor[] IgnoreRef = new Actor[4]
		bool isExhibitionist = False
		float PrivateRadius = 900.0
		if HiddenType >= 0 && Radius > PrivateRadius
			while i < IgnoreRef.Length && !isExhibitionist
				if i < ActorCount
					if !Positions[i].GetWornForm(0x00000004)
						isExhibitionist = True
					endIf
					IgnoreRef[i] = Positions[i]
				else
					i = IgnoreRef.Length
				endIf
				i += 1
			endWhile
			i = IgnoreRef.Length - ActorCount
			if !CurrentFollowerFaction
				CurrentFollowerFaction = Game.GetFormFromFile(0x5C84E, "Skyrim.esm") as Faction
			endIf
			while i && i < IgnoreRef.Length
				TempRef = FindAvailableActorInFaction(CurrentFollowerFaction, CenterRef, Radius, -1, IgnoreRef[0], IgnoreRef[1], IgnoreRef[2], IgnoreRef[3])
				if TempRef
					IgnoreRef[i] = TempRef as Actor
					i += 1
				else
					i = IgnoreRef.Length
				endIf
			endWhile
			if CenterRef.IsInInterior()
				Radius = Radius * 0.5
				PrivateRadius = 600.0
				if LocationHasKeyword(CenterRef.GetCurrentLocation(), Keyword.GetKeyword("LocTypeInn"))
					PrivateRadius = 300.0
				endIf
			endIf
		endIf
		TempRef = none
		if Animation.HasTag("Furniture")
			i = Config.FurnitureTags.Length
			while i > 0
				i -= 1
				if Animation.HasTag(Config.FurnitureTags[i]) && Config.ActiveFurnitureTags.Find(Config.FurnitureTags[i]) >= 0
					Log("Looking for Furniture TypeTag:'"+Config.FurnitureTags[i]+"'; TagIndex:"+i)
					int FoundID = 0
					while FoundID < 3
						UsedFurniture[FoundID] = FindFurnitureByType(i, CenterRef, Radius, IgnoreUsed, UsedFurniture[0], UsedFurniture[1])
						if UsedFurniture[FoundID] && UsedFurniture[FoundID] != none
							if HiddenType >= 0 && !isExhibitionist && Radius > PrivateRadius
								if !FindAvailableActorWornForm(0x00000004, UsedFurniture[FoundID], PrivateRadius, -1, IgnoreRef[0], IgnoreRef[1], IgnoreRef[2], IgnoreRef[3], JustSameFloor = PrivateRadius < 600.0)
									Log("FindFurnitureForAnimation() -- Find:"+UsedFurniture[FoundID]+" - Hidden")
									return UsedFurniture[FoundID] ; Exhibitionist Location
								endIf
							endIf
							if !TempRef || TempRef == none || TempRef.GetDistance(CenterRef) > UsedFurniture[FoundID].GetDistance(CenterRef)
								TempRef = UsedFurniture[FoundID]
							endIf
							FoundID += 1
						else
							FoundID = 3
						endIf
					endWhile
					if TempRef && TempRef != none ;&& HiddenType < 1
						Log("FindFurnitureForAnimation() -- Find:"+TempRef+" - Near")
						return TempRef
					endIf
				endIf
			endWhile	
		endIf
	endIf
	return none ; Nothing found in search loop
endFunction

; ------------------------------------------------------- ;
; --- Actor Tracking                                  --- ;
; ------------------------------------------------------- ;

function TrackActor(Actor ActorRef, string Callback)
	FormListAdd(Config, "TrackedActors", ActorRef, false)
	StringListAdd(ActorRef, "SexLabEvents", Callback, false)
endFunction

function TrackFaction(Faction FactionRef, string Callback)
	FormListAdd(Config, "TrackedFactions", FactionRef, false)
	StringListAdd(FactionRef, "SexLabEvents", Callback, false)
endFunction

function UntrackActor(Actor ActorRef, string Callback)
	StringListRemove(ActorRef, "SexLabEvents", Callback, true)
	if StringListCount(ActorRef, "SexLabEvents") < 1
		FormListRemove(Config, "TrackedActors", ActorRef, true)
	endif
endFunction

function UntrackFaction(Faction FactionRef, string Callback)
	StringListRemove(FactionRef, "SexLabEvents", Callback, true)
	if StringListCount(FactionRef, "SexLabEvents") < 1
		FormListRemove(Config, "TrackedFactions", FactionRef, true)
	endif
endFunction

bool function IsActorTracked(Actor ActorRef)
	if ActorRef == PlayerRef || StringListCount(ActorRef, "SexLabEvents") > 0
		return true
	endIf
	int i = FormListCount(Config, "TrackedFactions")
	while i
		i -= 1
		Faction FactionRef = FormListGet(Config, "TrackedFactions", i) as Faction
		if FactionRef && ActorRef.IsInFaction(FactionRef)
			return true
		endIf
	endWhile
	return false
endFunction

function SendTrackedEvent(Actor ActorRef, string Hook = "", int id = -1)
	; Append hook type, global if empty
	if Hook != ""
		Hook = "_"+Hook
	endIf
	; Send generic player callback event
	if ActorRef == PlayerRef
		SetupActorEvent(PlayerRef, "PlayerTrack"+Hook, id)
	endIf
	; Send actor callback events
	int i = StringListCount(ActorRef, "SexLabEvents")
	while i
		i -= 1
		SetupActorEvent(ActorRef, StringListGet(ActorRef, "SexLabEvents", i)+Hook, id)
	endWhile
	; Send faction callback events
	i = FormListCount(Config, "TrackedFactions")
	while i
		i -= 1
		Faction FactionRef = FormListGet(Config, "TrackedFactions", i) as Faction
		if FactionRef && ActorRef.IsInFaction(FactionRef)
			int n = StringListCount(FactionRef, "SexLabEvents")
			while n
				n -= 1
				SetupActorEvent(ActorRef, StringListGet(FactionRef, "SexLabEvents", n)+Hook, id)
			endwhile
		endIf
	endWhile
endFunction

function SetupActorEvent(Actor ActorRef, string Callback, int id = -1)
	int eid = ModEvent.Create(Callback)
	ModEvent.PushForm(eid, ActorRef)
	ModEvent.PushInt(eid, id)
	ModEvent.Send(eid)
endFunction

; ------------------------------------------------------- ;
; --- System use only                                 --- ;
; ------------------------------------------------------- ;

function Setup()
	parent.Setup()
	BedsList       = Config.BedsList
	DoubleBedsList = Config.DoubleBedsList
	BedRollsList   = Config.BedRollsList
	FurnitureBedRoll = Config.FurnitureBedRoll
endFunction
