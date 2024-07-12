scriptname sslFurnitureMarkers extends Quest conditional

sslSystemConfig property Config auto hidden

; Function libraries
sslActorLibrary property ActorLib auto
sslThreadLibrary property ThreadLib auto

; Data
Actor property PlayerRef auto
float[] property CenterLocation auto hidden
ObjectReference MarkerRef
EffectShader property HighlightFXS auto

; Furniture Types
bool property HasBedRoll = false auto conditional hidden
bool property HasSingledBed = false auto conditional hidden
bool property HasDoubleBed = false auto conditional hidden
bool property HasChair = false auto conditional hidden
bool property HasThrone = false auto conditional hidden
bool property HasBench = false auto conditional hidden
bool property HasBenchTable = false auto conditional hidden
bool property HasTable = false auto conditional hidden
bool property HasCounter = false auto conditional hidden
bool property HasWorkbench = false auto conditional hidden
bool property HasAlchemyWorkbench = false auto conditional hidden
bool property HasEnchantingWorkbench = false auto conditional hidden
bool property HasCoffin = false auto conditional hidden
bool property HasWall = false auto conditional hidden
bool property HasPillory = false auto conditional hidden
bool property HasRack = false auto conditional hidden
bool property HasPole = false auto conditional hidden
bool property HasXCross = false auto conditional hidden
bool property HasTiltedWheel = false auto conditional hidden
bool property HasRPost1 = false auto conditional hidden
bool property HasRPost2 = false auto conditional hidden
bool property HasRPost3 = false auto conditional hidden
bool property HasRPost4 = false auto conditional hidden
bool property HasRPost5 = false auto conditional hidden
bool property HasRPost6 = false auto conditional hidden
bool property HasWoodenHorse = false auto conditional hidden
bool property HasShackleWall = false auto conditional hidden
bool property HasStockade = false auto conditional hidden
bool property HasHorizontalPole = false auto conditional hidden

bool function LeveledAngle(ObjectReference ObjectRef, float Tolerance = 5.0)
	return ObjectRef && Math.Abs(ObjectRef.GetAngleX()) <= Tolerance && Math.Abs(ObjectRef.GetAngleY()) <= Tolerance
endFunction

bool function SameFloor(ObjectReference ObjectRef, float Z, float Tolerance = 15.0)
	return ObjectRef && Math.Abs(Z - ObjectRef.GetPositionZ()) <= Tolerance
endFunction

bool Function LocationHasKeyword(Location LocationRef, Keyword LocKeyword)
	If !LocationRef || LocationRef == none
		Return False
	EndIf
	Return (LocationRef.HasKeyword(LocKeyword))
EndFunction

Faction CurrentFollowerFaction ; TODO: Update the function to use the MiscUtil.ScanCellNPCsByFaction of the PapyrusUtil SE
Actor function FindAvailableActorInFaction(Faction FactionRef, ObjectReference arCenterRef, float Radius = 5000.0, int FindGender = -1, Actor IgnoreRef1 = none, Actor IgnoreRef2 = none, Actor IgnoreRef3 = none, Actor IgnoreRef4 = none, bool HasFaction = True, string RaceKey = "", bool JustSameFloor = False)
	if !arCenterRef || !FactionRef || FindGender > 3 || FindGender < -1 || Radius < 0.1
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
	Actor[] FoundRef = MiscUtil.ScanCellNPCs(arCenterRef, Radius)
	FoundRef = PapyrusUtil.RemoveActor(FoundRef ,arCenterRef as Actor)
	FoundRef = PapyrusUtil.RemoveActor(FoundRef ,IgnoreRef1)
	FoundRef = PapyrusUtil.RemoveActor(FoundRef ,IgnoreRef2)
	FoundRef = PapyrusUtil.RemoveActor(FoundRef ,IgnoreRef3)
	FoundRef = PapyrusUtil.RemoveActor(FoundRef ,IgnoreRef4)
	float Z = arCenterRef.GetPositionZ()
	int i = FoundRef.Length
	while i > 0
		i -= 1
		if (FoundRef[i] && (!JustSameFloor || SameFloor(FoundRef[i], Z, 200)) && ThreadLib.CheckActor(FoundRef[i], FindGender) && FoundRef[i].IsInFaction(FactionRef) == HasFaction && (RaceKey == "" || sslCreatureAnimationSlots.GetAllRaceKeys(FoundRef[i].GetLeveledActorBase().GetRace()).Find(RaceKey) != -1))
			return FoundRef[i] ; None means no actor in radius, give up now
		endIf
	endWhile
	; No actor found in attempts
	return none
endFunction

Actor function FindAvailableActorWornForm(int slotMask, ObjectReference arCenterRef, float Radius = 5000.0, int FindGender = -1, Actor IgnoreRef1 = none, Actor IgnoreRef2 = none, Actor IgnoreRef3 = none, Actor IgnoreRef4 = none, bool AvoidNoStripKeyword = True, bool HasWornForm = True, string RaceKey = "", bool JustSameFloor = False)
	if !arCenterRef || slotMask < 1 || FindGender > 3 || FindGender < -1 || Radius < 0.1
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
	Actor[] FoundRef = MiscUtil.ScanCellNPCs(arCenterRef, Radius)
	FoundRef = PapyrusUtil.RemoveActor(FoundRef ,arCenterRef as Actor)
	FoundRef = PapyrusUtil.RemoveActor(FoundRef ,IgnoreRef1)
	FoundRef = PapyrusUtil.RemoveActor(FoundRef ,IgnoreRef2)
	FoundRef = PapyrusUtil.RemoveActor(FoundRef ,IgnoreRef3)
	FoundRef = PapyrusUtil.RemoveActor(FoundRef ,IgnoreRef4)
	float Z = arCenterRef.GetPositionZ()
	int i = FoundRef.Length
	while i > 0
		i -= 1
		if (FoundRef[i] && (!JustSameFloor || SameFloor(FoundRef[i], Z, 200)) && ThreadLib.CheckActor(FoundRef[i], FindGender) && (RaceKey == "" || sslCreatureAnimationSlots.GetAllRaceKeys(FoundRef[i].GetLeveledActorBase().GetRace()).Find(RaceKey) != -1))
			Form ItemRef = FoundRef[i].GetWornForm(slotMask)
			if ((ItemRef && ItemRef != none) == HasWornForm) && (!AvoidNoStripKeyword || !(StorageUtil.FormListHas(none, "NoStrip", ItemRef) || SexLabUtil.HasKeywordSub(ItemRef, "NoStrip")))
				return FoundRef[i] ; None means no actor in radius, give up now
			endIf
		endIf
	endWhile
	; No actor found in attempts
	return none
endFunction

ObjectReference[] function FindBedsByType(int aiType = -1, ObjectReference arCenterRef, float Radius = 1000.0, bool IgnoreUsed = true, ObjectReference IgnoreRef1 = none, ObjectReference IgnoreRef2 = none)
	ObjectReference[] BedRef
	if !arCenterRef || arCenterRef == none || Radius < 1.0
		return BedRef ; Invalid args
	endIf
	; Current elevation to determine furniture being on same floor
	float Z = arCenterRef.GetPositionZ()
	FormList TempFurnitureLists
	if aiType == 1
		TempFurnitureLists = Config.BedRollsList
	;elseIf aiType == 2 ; Can't be done for now
	;	Form[] TempBeds = PapyrusUtil.GetDiffForm(BedsList.ToArray(), DoubleBedsList.ToArray())
	;	TempBeds = PapyrusUtil.GetDiffForm(TempBeds, BedRollsList.ToArray())
	;	TempFurnitureLists.AddForms(TempBeds)
	elseIf aiType == 3
		TempFurnitureLists = Config.DoubleBedsList
	else
		TempFurnitureLists = Config.BedsList
	endIf
	
	if !TempFurnitureLists || TempFurnitureLists.GetSize() < 1
		return BedRef ; Invalid Furniture List
	endIf
	BedRef = PO3_SKSEFunctions.FindAllReferencesOfType(arCenterRef, TempFurnitureLists, Radius)
	BedRef = PapyrusUtil.RemoveObjRef(BedRef ,IgnoreRef1)
	BedRef = PapyrusUtil.RemoveObjRef(BedRef ,IgnoreRef2)
	int i = BedRef.Length
	; Search a couple times for a nearby furniture on the same elevation first before looking for random
	while i
		i -= 1
		if !BedRef[i]
			if !(SameFloor(BedRef[i], Z, 200) && LeveledAngle(BedRef[i]) && CheckFurniture(BedRef[i], IgnoreUsed))
				BedRef[i] = none ; suppress from list
			endIf
		endIf
	endWhile
	return PapyrusUtil.RemoveObjRef(BedRef ,none)
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
	sslThreadController[] Threads = Config.ThreadSlots.Threads
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
	return FurnitureRef && FurnitureRef.IsEnabled() && !FurnitureRef.IsDeleted() && FurnitureRef.Is3DLoaded() && (!IgnoreUsed || IsFurnitureAvailable(FurnitureRef))
endFunction

bool function SetActorFurniture(Actor akActor, ObjectReference akFurniture, bool Restrictive = true)
	if !akActor || akActor == none
		return false
	endIf
	; Check actor in current thread
	sslThreadController[] Threads = Config.ThreadSlots.Threads
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

ObjectReference[] function FindFurnituresByType(int aiType = -1, ObjectReference arCenterRef, float Radius = 1000.0, bool IgnoreUsed = true, ObjectReference IgnoreRef1 = none, ObjectReference IgnoreRef2 = none)
	ObjectReference[] FurnitureRef
	if !arCenterRef || arCenterRef == none || Radius < 1.0 || aiType < 0
		return FurnitureRef ; Invalid args
	endIf
	; Current elevation to determine furniture being on same floor
	float Z = arCenterRef.GetPositionZ()
	FormList TempFurnitureLists
	if aiType < Config.FurnitureExtraLists.Length
		TempFurnitureLists = Config.FurnitureExtraLists[aiType]
	elseIf aiType >= Config.FurnitureExtraLists.Length && aiType < Config.FurnitureExtraLists.Length + Config.FurnitureRestrainLists.Length
		TempFurnitureLists = Config.FurnitureRestrainLists[aiType-Config.FurnitureExtraLists.Length]
	else
		return FurnitureRef ; Invalid aiType
	endIf
	
	if !TempFurnitureLists || TempFurnitureLists.GetSize() < 1
		return FurnitureRef ; Invalid Furniture List
	endIf
	FurnitureRef = PO3_SKSEFunctions.FindAllReferencesOfType(arCenterRef, TempFurnitureLists, Radius)
	FurnitureRef = PapyrusUtil.RemoveObjRef(FurnitureRef ,IgnoreRef1)
	FurnitureRef = PapyrusUtil.RemoveObjRef(FurnitureRef ,IgnoreRef2)
	int i = FurnitureRef.Length
	; Search a couple times for a nearby furniture on the same elevation first before looking for random
	while i
		i -= 1
		if !FurnitureRef[i]
			if !(SameFloor(FurnitureRef[i], Z, Radius * 0.5) && LeveledAngle(FurnitureRef[i]) && CheckFurniture(FurnitureRef[i], IgnoreUsed))
				FurnitureRef[i] = none ; suppress from list
			endIf
		endIf
	endWhile
	return PapyrusUtil.RemoveObjRef(FurnitureRef ,none)
endFunction

ObjectReference[] function FindAvailableFurnituresByTags(string FurnitureTags, ObjectReference arCenterRef, float Radius = 1000.0, bool IgnoreUsed = true, ObjectReference IgnoreRef1 = none, ObjectReference IgnoreRef2 = none)
	ObjectReference[] output
	if !Config.AllowFurniture || !arCenterRef || !Config.FurnitureExtraLists || Config.FurnitureExtraLists.Length < 1 || Radius < 1.0
		return output ; Invalid args
	endIf
	string[] Search   = PapyrusUtil.StringSplit(FurnitureTags)
	Search = PapyrusUtil.ClearEmpty(Search)
	if !Search || Search.Length < 1
		return output ; Invalid args
	endIf
	Log("FindAvailableFurnitures() -- FurnitureTags:"+Search+"; CenterRef:"+arCenterRef+"; Radius:"+Radius+"; IgnoreUsed:"+IgnoreUsed+"; IgnoreRef1:"+IgnoreRef1+"; IgnoreRef2:"+IgnoreRef2)
	float Z = arCenterRef.GetPositionZ()
	
	Config.TempFurnitureLists.Revert() ; The empty FormList defined in the ESP file for this purpose
	if Search.Find("Bed") >= 0
		if Config.BedsList
			Log("Looking for Furniture Type Bed")
			Config.TempFurnitureLists.AddForms(Config.BedsList.ToArray())
		endIf
	else
		if Config.BedRollsList && Search.Find("BedRoll") >= 0
			Log("Looking for Furniture Type BedRoll")
			Config.TempFurnitureLists.AddForms(Config.BedRollsList.ToArray())
		endIf
		if Config.DoubleBedsList && Search.Find("DoubleBed") >= 0
			Log("Looking for Furniture Type DoubleBed")
			Config.TempFurnitureLists.AddForms(Config.DoubleBedsList.ToArray())
		endIf
		if Config.BedsList && Search.Find("SingleBed") >= 0
			Log("Looking for Furniture Type SingleBed")
			Form[] TempBeds
			If SKSE.GetScriptVersionRelease() >= 64
				TempBeds = PapyrusUtil.GetDiffForm(Config.BedsList.ToArray(), Config.DoubleBedsList.ToArray()) ; SSE
				TempBeds = PapyrusUtil.GetDiffForm(TempBeds, Config.BedRollsList.ToArray()) ; SSE
			Else
				TempBeds = GetDiffForm(Config.BedsList.ToArray(), Config.DoubleBedsList.ToArray()) ; SLE
				TempBeds = GetDiffForm(TempBeds, Config.BedRollsList.ToArray()) ; SLE
			EndIf
			Config.TempFurnitureLists.AddForms(TempBeds)
		endIf
	endIf
	int i = Config.FurnitureTags.Length
	while i > 0
		i -= 1
		if Search.Find(Config.FurnitureTags[i]) >= 0
			Log("Looking for Furniture TypeTag:'"+Config.FurnitureTags[i]+"'; TagIndex:"+i)
			if i < Config.FurnitureExtraLists.Length
				if Config.FurnitureExtraLists[i] && Config.FurnitureExtraLists[i].GetSize() > 0
					Config.TempFurnitureLists.AddForms(Config.FurnitureExtraLists[i].ToArray())
				endIf
			elseIf i >= Config.FurnitureExtraLists.Length
				if Config.FurnitureRestrainLists[i-Config.FurnitureExtraLists.Length] && Config.FurnitureRestrainLists[i-Config.FurnitureExtraLists.Length].GetSize() > 0
					Config.TempFurnitureLists.AddForms(Config.FurnitureRestrainLists[i-Config.FurnitureExtraLists.Length].ToArray())
				endIf
			endIf
		endIf
	endWhile
	output = PO3_SKSEFunctions.FindAllReferencesOfType(arCenterRef, Config.TempFurnitureLists, Radius)
	Log("FindAvailableFurnituresByTags found:"+output.Length+" ObjectReference")
	output = PapyrusUtil.RemoveObjRef(output ,IgnoreRef1)
	output = PapyrusUtil.RemoveObjRef(output ,IgnoreRef2)
	Log("FindAvailableFurnituresByTags have:"+output.Length+" ObjectReference after remove the IgnoredRef")
	i = output.Length
	; Search a couple times for a nearby furniture on the same elevation first before looking for random
	while i
		i -= 1
		if !output[i]
			if !(SameFloor(output[i], Z, Radius * 0.5) && LeveledAngle(output[i]) && CheckFurniture(output[i], IgnoreUsed))
				output[i] = none ; suppress from list
			endIf
		endIf
	endWhile
	output = PapyrusUtil.RemoveObjRef(output ,none)
	Log("FindAvailableFurnituresByTags have:"+output.Length+" ObjectReference after remove the invalid reference")
	return output
endFunction

ObjectReference function FindFurnitureForAnimations(actor[] akPositions, sslBaseAnimation[] Animations, ObjectReference arCenterRef, float Radius = 1000.0, bool AskPlayer = true, int aiBedType = -1, int aiFurnitureType = -1, int aiHiddenType = -1, bool IgnoreUsed = true, ObjectReference IgnoreRef1 = none, ObjectReference IgnoreRef2 = none)
	int ActorCount = akPositions.Length
	if ((!Config.AllowFurniture || aiFurnitureType < 0) && aiBedType < 0) || !arCenterRef || ActorCount < 1 || !Config.FurnitureExtraLists || Config.FurnitureExtraLists.Length < 1 || Config.ActiveFurnitureTags.Length < 1 || Radius < 1.0
		return none ; Invalid args
	endIf
	Log("FindFurnitureForAnimations() -- ActorCount:"+ActorCount+"; Animations:"+Animations.Length+"; CenterRef:"+arCenterRef+"; Radius:"+Radius+"; BedType:"+aiBedType+"; FurnitureType:"+aiFurnitureType+"; HiddenType:"+aiHiddenType+"; IgnoreUsed:"+IgnoreUsed+"; IgnoreRef1:"+IgnoreRef1+"; IgnoreRef2:"+IgnoreRef2)
	int[] Genders = ActorLib.GenderCount(akPositions)
	int Creatures = Genders[2] + Genders[3]
	bool IsCreature = Creatures > 0
	bool HasPlayer  = akPositions.Find(PlayerRef) != -1
	string[] ActiveFurnitureTags ; Not the same as Config.ActiveFurnitureTags
	string[] AnimationsTags
	
	int i = 0
	if Config.AllowFurniture && aiFurnitureType >= 0 && (!Animations || Animations.Length < 1)
		sslBaseAnimation[] FurnitureAnimations
		if IsCreature
			FurnitureAnimations = Config.CreatureSlots.GetByCreatureActorsTags(ActorCount, akPositions, PapyrusUtil.StringJoin(Config.ActiveFurnitureTags), "", False)
		else
			FurnitureAnimations = Config.AnimSlots.GetByCommonTags(ActorCount, "Furniture", PapyrusUtil.StringJoin(Config.ActiveFurnitureTags), "", False)
		endIf
		if FurnitureAnimations.Length < 1 && aiBedType < 0
			return none ; None Furniture Animations
		endIf
		; Remove any animations without filtered gender tags
		if Config.RestrictGenderTag && ActorCount < 3
			string DefGenderTag = ""
			i = ActorCount
			int[] GendersAll = ActorLib.GetGendersAll(akPositions)
			int[] Futas = ActorLib.TransCount(akPositions)
			int[] FutasAll = ActorLib.GetTransAll(akPositions)
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
				FurnitureAnimations = sslUtility.FilterTaggedAnimations(FurnitureAnimations, GenderTag, true)
				if FurnitureAnimations.Length < 1 && aiBedType < 0
					return none ; None Furniture Animations
				endIf
			endIf
		endIf
		AnimationsTags = sslUtility.GetAllAnimationTagsInArray(FurnitureAnimations)
	else
		AnimationsTags = sslUtility.GetAllAnimationTagsInArray(Animations)
	endIf
	If SKSE.GetScriptVersionRelease() >= 64
		ActiveFurnitureTags = PapyrusUtil.GetMatchingString(Config.ActiveFurnitureTags, AnimationsTags) ; SSE
	Else
		ActiveFurnitureTags = GetMatchingString(Config.ActiveFurnitureTags, AnimationsTags) ; SSE
	EndIf
	if aiBedType >= 0
		If ActorCount < 4
			ActiveFurnitureTags = PapyrusUtil.PushString(ActiveFurnitureTags, "Bed") ; All Beds
		Else
			ActiveFurnitureTags = PapyrusUtil.PushString(ActiveFurnitureTags, "BedRoll")
		;	ActiveFurnitureTags = PapyrusUtil.PushString(ActiveFurnitureTags, "SingleBed")
			ActiveFurnitureTags = PapyrusUtil.PushString(ActiveFurnitureTags, "DoubleBed")
		endIf
	endIf
	
;	Log("FurnitureTags:'"+ActiveFurnitureTags+" from:"+AnimationsTags)
	if ActiveFurnitureTags.Length > 0
		
		if HasPlayer && AskPlayer
			ResetFurnitureAliases()
		EndIf
		
		Log("Looking for Animations with FurnitureTags:'"+ActiveFurnitureTags)
		ObjectReference[] UsedFurniture = new ObjectReference[5]
		i = 0
		while i < ActorCount
			UsedFurniture[i] = akPositions[i].GetFurnitureReference()
			if UsedFurniture[i] && UsedFurniture[i] != none 
				if UsedFurniture[i].GetDistance(arCenterRef) <= Radius
					int BedType = ThreadLib.GetBedType(UsedFurniture[i])
					if BedType > 0 && (ActiveFurnitureTags.Find("Bed") >= 0 || (BedType == 1 && ActiveFurnitureTags.Find("BedRoll") >= 0) || (BedType == 2 && ActiveFurnitureTags.Find("SingleBed") >= 0) || (BedType == 3 && ActiveFurnitureTags.Find("DoubleBed") >= 0))
						SetActorFurniture(akPositions[i], UsedFurniture[i], false)
						Log("FindFurnitureForAnimations() -- Find:"+UsedFurniture[i]+" - InUse")
					else
						int iFurn = GetFurnitureType(UsedFurniture[i])
						Log("Position["+i+"].FurnitureReference:'"+UsedFurniture[i].GetBaseObject()+"'; TagIndex:"+iFurn)
						if iFurn != -1 && ActiveFurnitureTags.Find(Config.FurnitureTags[iFurn]) >= 0
							SetActorFurniture(akPositions[i], UsedFurniture[i], iFurn >= Config.FurnitureExtraLists.Length)
							Log("FindFurnitureForAnimations() -- Find:"+UsedFurniture[i]+" - InUse")
						else
							Log("FindFurnitureForAnimations() -- Ignore:"+UsedFurniture[i]+" - InvalidForScene")
							UsedFurniture[i] = none
						endIf
					endIf
				else
					UsedFurniture[i] = none
				endIf
			endIf
			i += 1
		endWhile

		Actor[] IgnoreRef = new Actor[4]
		bool isExhibitionist = False
		float PrivateRadius = 900.0
		ObjectReference TempRef
		if aiHiddenType >= 0 
			if arCenterRef.IsInInterior()
				Radius = Radius * 0.5
				PrivateRadius = 600.0
				if LocationHasKeyword(arCenterRef.GetCurrentLocation(), Keyword.GetKeyword("LocTypeInn"))
					PrivateRadius = 300.0
				endIf
			endIf
			if Radius > PrivateRadius
				while i < IgnoreRef.Length && !isExhibitionist
					if i < ActorCount
						if !akPositions[i].GetWornForm(0x00000004)
							isExhibitionist = True
						endIf
						IgnoreRef[i] = akPositions[i]
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
					TempRef = FindAvailableActorInFaction(CurrentFollowerFaction, arCenterRef, Radius, -1, IgnoreRef[0], IgnoreRef[1], IgnoreRef[2], IgnoreRef[3])
					if TempRef
						IgnoreRef[i] = TempRef as Actor
						i += 1
					else
						i = IgnoreRef.Length
					endIf
				endWhile
			endIf
		endIf

		UsedFurniture = PapyrusUtil.RemoveObjRef(UsedFurniture, none)
		Log("FindFurnitureForAnimations() -- UsedFurnitures:"+UsedFurniture.Length)
		if UsedFurniture && UsedFurniture.Length > 0
			if HasPlayer && AskPlayer
				CenterOnObject(arCenterRef)
				If SetFurnitureAliases(UsedFurniture, False)
					if Radius < 300 || IgnoreUsed
						Utility.Wait(2.0)
						return GetFurnitureAliasRefByTypeID(Config.UseFurnitureMarker.Show())
					endIf
				endIf
			else
				i = UsedFurniture.Length
				TempRef = none
				while i
					i -= 1
					if aiHiddenType >= 0 && !isExhibitionist && Radius > PrivateRadius
						if ThreadLib.GetBedType(UsedFurniture[i]) > 0 || GetFurnitureType(UsedFurniture[i]) >= Config.FurnitureExtraLists.Length || !FindAvailableActorWornForm(0x00000004, UsedFurniture[i], PrivateRadius, -1, IgnoreRef[0], IgnoreRef[1], IgnoreRef[2], IgnoreRef[3], JustSameFloor = PrivateRadius < 600.0)
							Log("FindFurnitureForAnimations() -- Find:"+UsedFurniture[i]+" - Hidden")
							return UsedFurniture[i] ; Exhibitionist Location
						endIf
					endIf
					if !TempRef || TempRef == none || TempRef.GetDistance(arCenterRef) > UsedFurniture[i].GetDistance(arCenterRef)
						TempRef = UsedFurniture[i]
					endIf
				endWhile
				if TempRef && TempRef != none && aiHiddenType < 1
					Log("FindFurnitureForAnimations() -- Find:"+TempRef+" - Near")
					return TempRef
				endIf
			endIf
		EndIf
		
		ObjectReference[] FoundedFurnitures = FindAvailableFurnituresByTags(PapyrusUtil.StringJoin(ActiveFurnitureTags), arCenterRef, Radius, IgnoreUsed, IgnoreRef1, IgnoreRef2)
		Log("FindFurnitureForAnimations() -- FoundedFurnitures:"+FoundedFurnitures.Length)
		if FoundedFurnitures && FoundedFurnitures.Length > 0
			if HasPlayer && AskPlayer
				CenterOnObject(arCenterRef)
				If SetFurnitureAliases(FoundedFurnitures, IgnoreUsed)
					Utility.Wait(2.0)
					return GetFurnitureAliasRefByTypeID(Config.UseFurnitureMarker.Show())
				endIf
			else
				i = FoundedFurnitures.Length
				TempRef = none
				while i
					i -= 1
					if aiHiddenType >= 0 && !isExhibitionist && Radius > PrivateRadius
						if ThreadLib.GetBedType(FoundedFurnitures[i]) > 0 || GetFurnitureType(FoundedFurnitures[i]) >= Config.FurnitureExtraLists.Length || !FindAvailableActorWornForm(0x00000004, FoundedFurnitures[i], PrivateRadius, -1, IgnoreRef[0], IgnoreRef[1], IgnoreRef[2], IgnoreRef[3], JustSameFloor = PrivateRadius < 600.0)
							Log("FindFurnitureForAnimations() -- Find:"+FoundedFurnitures[i]+" - Hidden")
							return FoundedFurnitures[i] ; Exhibitionist Location
						endIf
					endIf
					if !TempRef || TempRef == none || TempRef.GetDistance(arCenterRef) > FoundedFurnitures[i].GetDistance(arCenterRef)
						TempRef = FoundedFurnitures[i]
					endIf
				endWhile
				if TempRef && TempRef != none && aiHiddenType < 1
					Log("FindFurnitureForAnimations() -- Find:"+TempRef+" - Near")
					return TempRef
				endIf
			endIf
		EndIf
	endIf
	return none ; Nothing found in search loop
endFunction

function UpdateFurnitureVars() 
	int i = 30
	While i
		i -= 1
		UpdateFurnitureVarsByTypeID(i)
	EndWhile
endFunction

function UpdateFurnitureVarsByTypeID(int aiType)  
	ObjectReference ObjectRef = GetFurnitureAliasRefByTypeID(aiType)
	SetFurnitureVarsByTypeID(aiType, ObjectRef && ObjectRef.Is3DLoaded() && ObjectRef.IsEnabled() && IsNear(ObjectRef))
endFunction

function SetFurnitureVarsByTypeID(int aiType, bool abValue)  
	if aiType == 1
		HasBedRoll = abValue
	elseIf aiType == 2
		HasSingledBed = abValue
	elseIf aiType == 3
		HasDoubleBed = abValue
	elseIf aiType == 4
		HasChair = abValue
	elseIf aiType == 5
		HasThrone = abValue
	elseIf aiType == 6
		HasBench = abValue
	elseIf aiType == 7
		HasBenchTable = abValue
	elseIf aiType == 8
		HasTable = abValue
	elseIf aiType == 9
		HasCounter = abValue
	elseIf aiType == 10
		HasWorkbench = abValue
	elseIf aiType == 11
		HasAlchemyWorkbench = abValue
	elseIf aiType == 12
		HasEnchantingWorkbench = abValue
	elseIf aiType == 13
		HasCoffin = abValue
	elseIf aiType == 14
		HasWall = abValue
	elseIf aiType == 15
		HasPillory = abValue
	elseIf aiType == 16
		HasRack = abValue
	elseIf aiType == 17
		HasPole = abValue
	elseIf aiType == 18
		HasXCross = abValue
	elseIf aiType == 19
		HasTiltedWheel = abValue
	elseIf aiType == 20
		HasRPost1 = abValue
	elseIf aiType == 21
		HasRPost2 = abValue
	elseIf aiType == 22
		HasRPost3 = abValue
	elseIf aiType == 23
		HasRPost4 = abValue
	elseIf aiType == 24
		HasRPost5 = abValue
	elseIf aiType == 25
		HasRPost6 = abValue
	elseIf aiType == 26
		HasWoodenHorse = abValue
	elseIf aiType == 27
		HasShackleWall = abValue
	elseIf aiType == 28
		HasStockade = abValue
	elseIf aiType == 29
		HasHorizontalPole = abValue
	EndIf
	bool Display = (abValue && Config.ShowInMap)
	if IsObjectiveDisplayed(aiType) != Display
		SetObjectiveDisplayed(aiType, Display)
		If Display
			DisplayedObjectives += 1
		Else
			DisplayedObjectives -= 1
		EndIf
	endIf

endFunction

int DisplayedObjectives
function ResetFurnitureAliases()
	UnregisterForUpdate()
	int i = GetNumAliases()
	While i
		SetFurnitureVarsByTypeID(i, false)
		i -= 1
		TryToClear(GetNthAlias(i) as ReferenceAlias)
	EndWhile
	DisplayedObjectives = 0
endFunction

int Function SetupAnimObjectsByFurnitureTag(string asFurnitureTag) global
	If SKSE.GetScriptVersionRelease() >= 64 && sslUtility.Trim(asFurnitureTag) != ""
		string File = "../SexLab/AnimatedObjects.json"
		string[] ANIO = JsonUtil.StringListToArray(File, "SexLab."+asFurnitureTag+".ANIO")
		if !ANIO || ANIO.Length < 1
			ANIO = new string[1]
			ANIO[0] = "TestName"
			JsonUtil.StringListCopy(File, "SexLab."+asFurnitureTag+".ANIO", ANIO)
			return 1
		endIf
		return 0
	endIf
	return -1
endFunction

int Function DisableAnimObjectsByFurnitureTag(string asFurnitureTag) global
	If SKSE.GetScriptVersionRelease() >= 64 && asFurnitureTag
		string File = "../SexLab/AnimatedObjects.json"
		string[] ANIO = JsonUtil.StringListToArray(File, "SexLab."+asFurnitureTag+".ANIO")
		bool Ignored
		form currentANIO
		int output = 0
		int ao = ANIO.Length
	;	[Ignored]	0x00001000
	;	[Deleted]	0x00000020
	;	[Unknown9]	0x00000200
	;	[NoPlayable]	0x00000004
		If ao
			while ao
				ao -= 1
				if ANIO[ao]
					currentANIO = PO3_SKSEFunctions.GetFormFromEditorID(ANIO[ao])
					string ModelPath
					if currentANIO && currentANIO.GetType() == 83
						PO3_SKSEFunctions.SetRecordFlag(currentANIO, 0x00001000) ; Ignored
						ModelPath = currentANIO.GetWorldModelPath()
						If StringUtil.Find(ModelPath, "[Ignored]") < 0
							ModelPath += "[Ignored]"
							currentANIO.SetWorldModelPath(ModelPath)
						EndIf
						Ignored = PO3_SKSEFunctions.IsRecordFlagSet(currentANIO, 0x00001000) ; Ignored
						output += 1
					EndIf
					Debug.Trace("SEXLAB - "+"DisableAnimObjectsByFurnitureTag("+asFurnitureTag+")"+Ignored+"; ModelPath:"+ModelPath+"; ANIO:"+ANIO[ao]+"; "+currentANIO)
				EndIf
			EndWhile
		Else
			SetupAnimObjectsByFurnitureTag(asFurnitureTag)
		EndIf
		return output
	endIf
	return -1
endFunction

int Function EnableAnimObjectsByFurnitureTag(string asFurnitureTag) global
	If SKSE.GetScriptVersionRelease() >= 64 && asFurnitureTag
		string File = "../SexLab/AnimatedObjects.json"
		string[] ANIO = JsonUtil.StringListToArray(File, "SexLab."+asFurnitureTag+".ANIO")
		bool Ignored
		form currentANIO
		int output = 0
		int ao = ANIO.Length
	;	[Ignored]	0x00001000
	;	[Deleted]	0x00000020
	;	[Unknown9]	0x00000200
	;	[NoPlayable]	0x00000004
		while ao
			ao -= 1
			if ANIO[ao]
				currentANIO = PO3_SKSEFunctions.GetFormFromEditorID(ANIO[ao])
				string ModelPath
				if currentANIO && currentANIO.GetType() == 83
					PO3_SKSEFunctions.ClearRecordFlag(currentANIO, 0x00001000) ; Ignored
					ModelPath = currentANIO.GetWorldModelPath()
					int StrPos = StringUtil.Find(ModelPath, "[Ignored]")
					If StrPos > 0
						ModelPath = StringUtil.Substring(ModelPath, 0, StrPos)
						currentANIO.SetWorldModelPath(ModelPath)
					EndIf
					Ignored = PO3_SKSEFunctions.IsRecordFlagSet(currentANIO, 0x00001000) ; Ignored
					output += 1
				EndIf
				Debug.Trace("SEXLAB - "+"EnableAnimObjectsByFurnitureTag("+asFurnitureTag+")"+Ignored+"; ModelPath:"+ModelPath+"; ANIO:"+ANIO[ao]+"; "+currentANIO)
			EndIf
		EndWhile
		return output
	endIf
	return -1
endFunction

bool Function IsNear(ObjectReference akObject)
	If !akObject || !MarkerRef
		return false
	EndIf
	Cell targetCell = akObject.GetParentCell()
	Cell MarkerCell = MarkerRef.GetParentCell()
	
	if (targetCell != MarkerCell)
		; Marker and target are in different cells
		if (targetCell && targetCell.IsInterior()) || (MarkerCell && MarkerCell.IsInterior())
			; in different cells and at least one is an interior
			;  -- we can safely enable or disable
			return false
		else
			; both in an exterior -- no means of testing 
			;  worldspace at the moment, so this will do.
			if (MarkerRef.GetDistance(akObject) > 3000)
				; pretty darned far away -- safe
				return false
			else
				; too close for comfort
				return true
			endif
		endif
	else
		; in the same cell -- err on the side of caution
		return true
	endif
endFunction

int function SetFurnitureAliases(ObjectReference[] arFurnitureObjects, bool IgnoreUsed = True) 
	int output = 0
	int Type
	int i = arFurnitureObjects.Length
	ObjectReference ObjectRef
	While i
		i -= 1
		if CheckFurniture(arFurnitureObjects[i], IgnoreUsed)
			Type = ThreadLib.GetBedType(arFurnitureObjects[i])
			if Type < 1
				Type = GetFurnitureType(arFurnitureObjects[i])
				if Type >= 0
					Type = Type + 4
				endIf
			endIf
			if Type > 0
				ObjectRef = GetFurnitureAliasRefByTypeID(Type)
				if !CheckFurniture(ObjectRef, false) || ObjectRef.GetDistance(MarkerRef) > arFurnitureObjects[i].GetDistance(MarkerRef)
					If SetFurnitureAliasRefByTypeID(arFurnitureObjects[i], Type)
						SetFurnitureVarsByTypeID(Type, True)
						output += 1
					EndIf
				EndIf
			endIf
		endIf
	EndWhile
	Return output
endFunction

ObjectReference function GetFurnitureAliasRefByTypeID(int aiType) 
	Alias FurnitureAlias = GetAliasById(aiType)
	if FurnitureAlias
		ObjectReference FurnitureRef = (FurnitureAlias as ReferenceAlias).GetReference()
		Log("FurnitureRef: "+FurnitureRef,"GetFurnitureAliasRefByTypeID("+aiType+")")
		If HighlightFXS && FurnitureRef
			HighlightFXS.Stop(FurnitureRef)
		endIf
		Return FurnitureRef
	endIf
	Log("FurnitureAlias: "+FurnitureAlias,"GetFurnitureAliasRefByTypeID("+aiType+")")
	Return none
endFunction

int function SetFurnitureAliasRefByTypeID(ObjectReference arFurnitureObject, int aiType) 
	Alias FurnitureAlias = GetAliasById(aiType)
	if FurnitureAlias
		UnregisterForUpdate()
		if arFurnitureObject
			ForceRefTo(FurnitureAlias as ReferenceAlias, arFurnitureObject)
		Else
			TryToClear(FurnitureAlias as ReferenceAlias)
		endIf
		RegisterForSingleUpdate(30.0)
		Return aiType
	endIf
	Return -1
endFunction

string function SetFurnitureAliasRefByTypeName(ObjectReference arFurnitureObject, string asType) 
	Alias FurnitureAlias = GetAliasByName(asType)
	if FurnitureAlias
		if arFurnitureObject
			ForceRefTo(FurnitureAlias as ReferenceAlias, arFurnitureObject)
		Else
			TryToClear(FurnitureAlias as ReferenceAlias)
		endIf
		Return asType
	endIf
	Return ""
endFunction

Function ForceRefTo(ReferenceAlias arFurnitureRefAlias, ObjectReference akNewRef)
	If arFurnitureRefAlias && akNewRef
		ObjectReference FurnitureRef = arFurnitureRefAlias.GetReference()
		arFurnitureRefAlias.ForceRefTo(akNewRef)
		If HighlightFXS
			If FurnitureRef
				HighlightFXS.Stop(FurnitureRef)
			endIf
			If akNewRef
				HighlightFXS.Play(akNewRef)
			endIf
		EndIf
	EndIf
endFunction

bool function TryToClear(ReferenceAlias arFurnitureRefAlias)
	If arFurnitureRefAlias
		ObjectReference FurnitureRef = arFurnitureRefAlias.GetReference()
		If FurnitureRef
			If HighlightFXS && FurnitureRef
				HighlightFXS.Stop(FurnitureRef)
			endIf
			arFurnitureRefAlias.Clear()
			Return true
		EndIf
	EndIf
	Return false
endFunction

; Gets the cell this object is in
Cell Function GetParentCell()
	if MarkerRef
		Return MarkerRef.GetParentCell()
	endIf
	Return none
endFunction

String[] function RemoveDupeString(String[] ArrayValues) global
	String[] Output = PapyrusUtil.StringArray(ArrayValues.Length)
	int n = 0
	int i = 0
	while i < ArrayValues.Length && n < Output.Length
		If Output.Find(ArrayValues[i]) == -1 ; Also remove None
			Output[n] = ArrayValues[i]
			n += 1
		EndIf
		i += 1
	endWhile
	If n < Output.Length
		return PapyrusUtil.ResizeStringArray(Output, n)
	EndIf
	return Output
endFunction

string[] function GetMatchingString(string[] ArrayValues1, string[] ArrayValues2)
	string[] Output
	if !ArrayValues1 || !ArrayValues2
		Return Output
	endIf
	int n = 0
	int i = 0
	Output = PapyrusUtil.StringArray(ArrayValues1.Length)
	while i < ArrayValues1.Length && n < Output.Length ; In theory the ArrayValues1.Length can change while this function is executed.
		If ArrayValues2.Find(ArrayValues1[i]) != -1 && output.Find(ArrayValues1[i]) == -1 ; Also remove Dupes and None
			output[n] = ArrayValues1[i]
			n += 1
		EndIf
		i += 1
	EndWhile
	If n < Output.Length
		return PapyrusUtil.ResizeStringArray(Output, n)
	EndIf
	return Output
endFunction

Form[] function RemoveDupeForm(Form[] ArrayValues) global
	Form[] Output = PapyrusUtil.FormArray(ArrayValues.Length)
	int n = 0
	int i = 0
	while i < ArrayValues.Length && n < Output.Length
		If Output.Find(ArrayValues[i]) == -1 ; Also remove None
			Output[n] = ArrayValues[i]
			n += 1
		EndIf
		i += 1
	endWhile
	If n < Output.Length
		return PapyrusUtil.ResizeFormArray(Output, n)
	EndIf
	return Output
endFunction

Form[] function GetDiffForm(Form[] ArrayValues1, Form[] ArrayValues2, bool CompareBoth = false, bool IncludeDupes = false)
	Form[] output
	if !ArrayValues1 && !ArrayValues2
		Return output
	elseIf !ArrayValues1
		If CompareBoth
			If !IncludeDupes
				Return RemoveDupeForm(ArrayValues2)
			Else
				Return ArrayValues2
			endIf
		Else
			Return output
		endIf
	elseIf !ArrayValues2
		Return RemoveDupeForm(ArrayValues1)
	endIf
	Output =  PapyrusUtil.FormArray(ArrayValues1.Length + (CompareBoth as int * ArrayValues2.Length))
	int n = 0
	int i = 0
	While i < ArrayValues1.Length && n < Output.Length ; the ArrayValues1.Length can change while this function is executed and the output is limited anyway.
		if (ArrayValues2.Find(ArrayValues1[i]) == -1) && (IncludeDupes || output.Find(ArrayValues2[i]) == -1)
			output[n] = ArrayValues1[i]
			n += 1
		EndIf
		i += 1
	EndWhile

	if (CompareBoth) ; Will merge both arrays
		i = 0
		While i < ArrayValues2.Length && n < Output.Length ; the ArrayValues1.Length can change while this function is executed and the output is limited anyway.
			if (ArrayValues1.Find(ArrayValues2[i]) == -1) && (IncludeDupes || output.Find(ArrayValues1[i]) == -1)
				output[n] = ArrayValues2[i]
				n += 1
			EndIf
			i += 1
		EndWhile
	endIf
	If n < Output.Length
		return PapyrusUtil.ResizeFormArray(Output, n)
	EndIf
	Return Output
endFunction

function CenterOnObject(ObjectReference CenterOn, bool resync = true)
	if CenterOn
		; Get Position.
		if !CenterLocation || CenterLocation.Length < 6
			CenterLocation = new float[6]
		endIf
		CenterLocation[0] = CenterOn.GetPositionX()
		CenterLocation[1] = CenterOn.GetPositionY()
		CenterLocation[2] = CenterOn.GetPositionZ()
		CenterLocation[3] = CenterOn.GetAngleX()
		CenterLocation[4] = CenterOn.GetAngleY()
		CenterLocation[5] = CenterOn.GetAngleZ()
		if resync
			if MarkerRef
				MarkerRef.Disable()
				MarkerRef.Delete()
				MarkerRef = none
			endIf
			if !MarkerRef
				MarkerRef = CenterOn.PlaceAtMe(Config.BaseMarker)
				int cycle
				while !MarkerRef.Is3DLoaded() && cycle < 50
					Utility.Wait(0.1)
					cycle += 1
				endWhile
				if cycle
					Log("Waited ["+cycle+"] cycles for MarkerRef["+MarkerRef+"]")
				endIf
			endIf
			MarkerRef.SetPosition(CenterLocation[0], CenterLocation[1], CenterLocation[2])
			MarkerRef.SetAngle(CenterLocation[3], CenterLocation[4], CenterLocation[5])
		endIf
	endIf
endFunction

function CenterOnCoords(float LocX = 0.0, float LocY = 0.0, float LocZ = 0.0, float RotX = 0.0, float RotY = 0.0, float RotZ = 0.0, bool resync = true)
	if !CenterLocation || CenterLocation.Length < 6
		CenterLocation = new float[6]
	endIf
	CenterLocation[0] = LocX
	CenterLocation[1] = LocY
	CenterLocation[2] = LocZ
	CenterLocation[3] = RotX
	CenterLocation[4] = RotY
	CenterLocation[5] = RotZ
	if resync
		if MarkerRef
			MarkerRef.Disable()
			MarkerRef.Delete()
			MarkerRef = none
		endIf
		if !MarkerRef
			MarkerRef = PlayerRef.PlaceAtMe(Config.BaseMarker)
			int cycle
			while !MarkerRef.Is3DLoaded() && cycle < 50
				Utility.Wait(0.1)
				cycle += 1
			endWhile
			if cycle
				Log("Waited ["+cycle+"] cycles for MarkerRef["+MarkerRef+"]")
			endIf
		endIf
		MarkerRef.SetPosition(CenterLocation[0], CenterLocation[1], CenterLocation[2])
		MarkerRef.SetAngle(CenterLocation[3], CenterLocation[4], CenterLocation[5])
	endIf
endFunction

function Setup()
	UnregisterForUpdate()
	GoToState("")
	LoadLibs(true)
	RegisterEvents()
endFunction

event OnInit()
	LoadLibs(false)
	RegisterEvents()
	Debug.Trace("SEXLAB -- Init "+self)
endEvent

Event OnUpdate()
	Utility.Wait(0.1)
	ResetFurnitureAliases()
endEvent

Event OnMenuOpen(String Menu)
	If Menu == "MessageBoxMenu" && DisplayedObjectives > 0 && IsRunning()
		UI.SetInt("MiniMapMenu", "_root._alpha", 100)
	EndIf
endEvent

Event OnMenuClose(String Menu)
;	If Menu == "MessageBoxMenu"
;		UI.SetInt("MiniMapMenu", "_root._alpha", 0)
;	EndIf
endEvent

function LoadLibs(bool Forced = false)
	; Sync function Libraries - SexLabQuestFramework
	if Forced || !Config || !ThreadLib || !ActorLib
		Form SexLabQuestFramework  = Game.GetFormFromFile(0xD62, "SexLab.esm")
		if SexLabQuestFramework
			Config      = SexLabQuestFramework as sslSystemConfig
			ThreadLib   = SexLabQuestFramework as sslThreadLibrary
			ActorLib    = SexLabQuestFramework as sslActorLibrary
		endIf
	endIf
	if !CenterLocation || CenterLocation.Length < 6
		CenterLocation = new float[6]
	endIf
	; Sync data
	if Forced || !PlayerRef
		PlayerRef = Game.GetPlayer()
	endIf
endFunction

function RegisterEvents()
    UnregisterForAllMenus()
    RegisterForMenu("MessageBoxMenu")
endFunction

function Log(string msg, string asType = "NOTICE")
	msg = asType+": "+msg
	if Config.InDebugMode
		SexLabUtil.PrintConsole(msg)
		Debug.TraceUser("SexLabDebug", msg)
	endIf
	if asType == "FATAL"
		Debug.TraceStack("SEXLAB - "+msg)
	else
		Debug.Trace("SEXLAB - "+msg)
	endIf
endFunction
