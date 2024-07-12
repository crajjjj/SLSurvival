scriptname sslAnimationSlots extends Quest

import PapyrusUtil

Alias[] Objects
string[] Registry
int property Slotted auto hidden
sslBaseAnimation[] property Animations hidden
	sslBaseAnimation[] function get()
		return GetSlots(1, 128)
	endFunction
endProperty

Actor property PlayerRef auto
sslSystemConfig property Config auto
sslActorLibrary property ActorLib auto
sslThreadLibrary property ThreadLib auto

; ------------------------------------------------------- ;
; --- Animation Filtering                             --- ;
; ------------------------------------------------------- ;

sslBaseAnimation[] function GetByTags(int ActorCount, string Tags, string TagsSuppressed = "", bool RequireAll = true)
	Log("GetByTags(ActorCount="+ActorCount+", Tags="+Tags+", TagsSuppressed="+TagsSuppressed+", RequireAll="+RequireAll+")")
	; Making the tags lists and optimize for CACHE
	string[] Suppress = StringSplit(TagsSuppressed)
	Suppress = ClearEmpty(Suppress)
	SortStringArray(Suppress)
	string[] Search   = StringSplit(Tags)
	Search = ClearEmpty(Search)
	SortStringArray(Search)
	; Check Cache
	string CacheName = ActorCount+":"+Search+":"+Suppress+":"+RequireAll
	sslBaseAnimation[] Output = CheckCache(CacheName)
	if Output || IsCached(CacheName)
		return Output
	endIf
	; Search
	;  bool[] Valid      = Utility.CreateBoolArray(Slotted)
	int ValidCount
	int RandomInt
	int PlusInt = 11

	sslBaseAnimation[] TempOutput = new sslBaseAnimation[125]
	int i = Slotted
	while i
		i -= 1
		if Objects[i]
			sslBaseAnimation Slot = Objects[i] as sslBaseAnimation
			;  Valid[i] = Slot.Enabled && ActorCount == Slot.PositionCount && Slot.TagSearch(Search, Suppress, RequireAll)
			If Slot.Enabled && ActorCount == Slot.PositionCount && Slot.TagSearch(Search, Suppress, RequireAll)
				If ValidCount >= 125
					If PlusInt > 10 || RandomInt + PlusInt >= 125
						RandomInt = Utility.RandomInt(0, 124)
						PlusInt = 0
					EndIf
					TempOutput[ RandomInt + PlusInt ] = Slot
					PlusInt += 1
				Else	
					TempOutput[ValidCount] = Slot
				EndIf
				ValidCount += 1
			endIf
		endIf
	endWhile
	;  Output = GetList(Valid)
	If ValidCount >= 125
		Output = TempOutput
	Else
		; Get list
		Output = sslUtility.AnimationArray(ValidCount)
		i = Output.Length
		while i
			i -= 1
			Output[i] = TempOutput[i]
		endWhile
	EndIf
	CacheAnims(CacheName, Output)
	return Output
endFunction

sslBaseAnimation[] function GetByCommonTags(int ActorCount, string CommonTags, string Tags, string TagsSuppressed = "", bool RequireAll = true)
	Log("GetByCommonTags(ActorCount="+ActorCount+", CommonTags="+CommonTags+", Tags="+Tags+", TagsSuppressed="+TagsSuppressed+", RequireAll="+RequireAll+")")
	; Making the tags lists and optimize for CACHE
	string[] SearchCommon   = StringSplit(CommonTags)
	SearchCommon = ClearEmpty(SearchCommon)
	; Check if this function is really required 
	if !SearchCommon || SearchCommon.Length < 1
		return GetByTags(ActorCount, Tags, TagsSuppressed, RequireAll)
	ElseIf RequireAll
		return GetByTags(ActorCount, StringJoin(MergeStringArray(StringSplit(Tags), SearchCommon, True)), TagsSuppressed, RequireAll)
	endIf
	SortStringArray(SearchCommon)
	string[] Suppress = StringSplit(TagsSuppressed)
	Suppress = ClearEmpty(Suppress)
	SortStringArray(Suppress)
	string[] Search   = StringSplit(Tags)
	Search = ClearEmpty(Search)
	SortStringArray(Search)
	int i = SearchCommon.Length
	If SKSE.GetScriptVersionRelease() >= 64
		Search = GetDiffString(Search, SearchCommon)
	Else
		while i
			i -= 1
			if Search.Length > 0
				Search = RemoveString(Search, SearchCommon[i])
			endIf
		endWhile
	EndIf
	; Check Cache
	string CacheName = ActorCount+":"+SearchCommon+":"+Search+":"+Suppress+":"+RequireAll
	sslBaseAnimation[] Output = CheckCache(CacheName)
	if Output || IsCached(CacheName)
		return Output
	endIf
	; Search
	;  bool[] Valid = Utility.CreateBoolArray(Slotted)
	int ValidCount
	int RandomInt
	int PlusInt = 11

	sslBaseAnimation[] TempOutput = new sslBaseAnimation[125]
	i = Slotted
	while i
		i -= 1
		if Objects[i]
			sslBaseAnimation Slot = Objects[i] as sslBaseAnimation
			;  Valid[i] = Slot.Enabled && ActorCount == Slot.PositionCount && Slot.HasAllTag(SearchCommon) && Slot.TagSearch(Search, Suppress, RequireAll)
			If Slot.Enabled && ActorCount == Slot.PositionCount && Slot.HasAllTag(SearchCommon) && Slot.TagSearch(Search, Suppress, RequireAll)
				If ValidCount >= 125
					If PlusInt > 10 || RandomInt + PlusInt >= 125
						RandomInt = Utility.RandomInt(0, 124)
						PlusInt = 0
					EndIf
					TempOutput[ RandomInt + PlusInt ] = Slot
					PlusInt += 1
				Else	
					TempOutput[ValidCount] = Slot
				EndIf
				ValidCount += 1
			endIf
		endIf
	endWhile
	;  Output = GetList(Valid)
	If ValidCount >= 125
		Output = TempOutput
	Else
		; Get list
		Output = sslUtility.AnimationArray(ValidCount)
		i = Output.Length
		while i
			i -= 1
			Output[i] = TempOutput[i]
		endWhile
	EndIf
	CacheAnims(CacheName, Output)
	return Output
endFunction

sslBaseAnimation[] function GetByType(int ActorCount, int Males = -1, int Females = -1, int StageCount = -1, bool Aggressive = false, bool Sexual = true)
	Log("GetByType(ActorCount="+ActorCount+", Males="+Males+", Females="+Females+", StageCount="+StageCount+", Aggressive="+Aggressive+", Sexual="+Sexual+")")
	; Check Cache
	string CacheName = ActorCount+":"+Males+":"+Females+":"+StageCount+":"+Aggressive+":"+Sexual
	sslBaseAnimation[] Output = CheckCache(CacheName)
	if Output || IsCached(CacheName)
		return Output
	endIf
	; Search
	;  bool[] Valid = Utility.CreateBoolArray(Slotted)
	int ValidCount
	int RandomInt
	int PlusInt = 11

	sslBaseAnimation[] TempOutput = new sslBaseAnimation[125]
	bool RestrictAggressive = Config.RestrictAggressive
	string GenderTag = ActorLib.GetGenderTag(Females, Males)
	int i = Slotted
	while i
		i -= 1
		if Objects[i]
			sslBaseAnimation Slot = Objects[i] as sslBaseAnimation
			;  Valid[i] = Slot.Enabled && ActorCount == Slot.PositionCount && (!RestrictAggressive || Aggressive == Slot.HasTag("Aggressive")) \
			;  && (((Males == -1 || Males <= Slot.Males) && (Females == -1 || Females <= Slot.Females)) || Slot.HasTag(GenderTag)) && (StageCount == -1 || StageCount == Slot.StageCount) \
			;  && Sexual != Slot.HasTag("LeadIn")
			If Slot.Enabled && ActorCount == Slot.PositionCount && (!RestrictAggressive || Aggressive == Slot.HasTag("Aggressive")) \
			&& (((Males == -1 || Males <= Slot.Males) && (Females == -1 || Females <= Slot.Females)) || Slot.HasTag(GenderTag)) && (StageCount == -1 || StageCount == Slot.StageCount) \
			&& Sexual != Slot.HasTag("LeadIn")
				If ValidCount >= 125
					If PlusInt > 10 || RandomInt + PlusInt >= 125
						RandomInt = Utility.RandomInt(0, 124)
						PlusInt = 0
					EndIf
					TempOutput[ RandomInt + PlusInt ] = Slot
					PlusInt += 1
				Else	
					TempOutput[ValidCount] = Slot
				EndIf
				ValidCount += 1
			endIf
		endIf
	endWhile
	;  Output = GetList(Valid)
	If ValidCount >= 125
		Output = TempOutput
	Else
		; Get list
		Output = sslUtility.AnimationArray(ValidCount)
		i = Output.Length
		while i
			i -= 1
			Output[i] = TempOutput[i]
		endWhile
	EndIf
	CacheAnims(CacheName, Output)
	return Output
endFunction

sslBaseAnimation[] function PickByActors(Actor[] Positions, int Limit = 64, bool Aggressive = false)
	Log("PickByActors(Positions="+Positions+", Limit="+Limit+", Aggressive="+Aggressive+")")
	int[] Genders = ActorLib.GenderCount(Positions)
	sslBaseAnimation[] Matches = GetByDefault(Genders[0], Genders[1], Aggressive)
	if Matches.Length <= Limit
		return Matches
	endIf
	; Select random from within limit
	sslBaseAnimation[] Picked = sslUtility.AnimationArray(Limit)
	int i = Matches.Length
	while i && Limit
		i -= 1
		Limit -= 1
		; Check random index between 0 and before current
		int r = Utility.RandomInt(0, (i - 1))
		if Picked.Find(Matches[r]) == -1
			Picked[Limit] = Matches[r] ; Use random index
		else
			Picked[Limit] = Matches[i] ; Random index was used, use current index
		endIf
	endWhile
	return Matches
endFunction

sslBaseAnimation[] function GetByDefault(int Males, int Females, bool IsAggressive = false, bool UsingBed = false, bool RestrictAggressive = true)
	Log("GetByDefault(Males="+Males+", Females="+Females+", IsAggressive="+IsAggressive+", UsingBed="+UsingBed+", RestrictAggressive="+RestrictAggressive+")")
	if Males == 0 && Females == 0
		return none ; No actors passed or creatures present
	endIf
	; Info
	int ActorCount = (Males + Females)
	bool SameSex = (Females == 2 && Males == 0) || (Males == 2 && Females == 0)
	bool BedRemoveStanding = Config.BedRemoveStanding
	; Check Cache
	string CacheName = Males+":"+Females+":"+IsAggressive+":"+UsingBed+":"+BedRemoveStanding+":"+RestrictAggressive
	sslBaseAnimation[] Output = CheckCache(CacheName)
	if Output || IsCached(CacheName)
		return Output
	endIf
	; Search
	;  bool[] Valid = Utility.CreateBoolArray(Slotted)
	int ValidCount
	int RandomInt
	int PlusInt = 11

	sslBaseAnimation[] TempOutput = new sslBaseAnimation[125]
	bool Valid
	string GenderTag = ActorLib.GetGenderTag(Females, Males)
	int i = Slotted
	while i
		i -= 1
		if Objects[i]
			sslBaseAnimation Slot = Objects[i] as sslBaseAnimation
			; Check for appropiate enabled aniamtion
;/ 			Valid[i] = Slot.Enabled && ActorCount == Slot.PositionCount
			if Valid[i]
				string[] RawTags = Slot.GetRawTags()
				int[] Genders = Slot.Genders
				; Suppress standing animations if on a bed
				Valid[i] = Valid[i] && ((!UsingBed && RawTags.Find("BedOnly") == -1) || (UsingBed && RawTags.Find("Furniture") == -1 && (!BedRemoveStanding || RawTags.Find("Standing") == -1)))
				; Suppress or ignore aggressive animation tags
				Valid[i] = Valid[i] && (!RestrictAggressive || IsAggressive == (RawTags.Find("Aggressive") != -1))
				; Get SameSex + Non-SameSex
				if SameSex
					Valid[i] = Valid[i] && (RawTags.Find("FM") != -1 || (((Males == -1 || Males <= Genders[0]) && (Females == -1 || Females <= Genders[1])) || Slot.HasTag(GenderTag)))
				; Ignore genders for 3P+
				elseIf ActorCount < 3
					Valid[i] = Valid[i] && (((Males == -1 || Males <= Genders[0]) && (Females == -1 || Females <= Genders[1])) || Slot.HasTag(GenderTag))
				endIf
			endIf
 /;
			Valid = Slot.Enabled && ActorCount == Slot.PositionCount
			if Valid
				string[] RawTags = Slot.GetRawTags()
				int[] Genders = Slot.Genders
				; Suppress standing animations if on a bed
				Valid = Valid && ((!UsingBed && RawTags.Find("BedOnly") == -1) || (UsingBed && RawTags.Find("Furniture") == -1 && (!BedRemoveStanding || RawTags.Find("Standing") == -1)))
				; Suppress or ignore aggressive animation tags
				Valid = Valid && (!RestrictAggressive || IsAggressive == (RawTags.Find("Aggressive") != -1))
				; Get SameSex + Non-SameSex
				if SameSex
					Valid = Valid && (RawTags.Find("FM") != -1 || (((Males == -1 || Males <= Genders[0]) && (Females == -1 || Females <= Genders[1])) || Slot.HasTag(GenderTag)))
				; Ignore genders for 3P+
				elseIf ActorCount < 3
					Valid = Valid && (((Males == -1 || Males <= Genders[0]) && (Females == -1 || Females <= Genders[1])) || Slot.HasTag(GenderTag))
				endIf
				If Valid
					If ValidCount >= 125
						If PlusInt > 10 || RandomInt + PlusInt >= 125
							RandomInt = Utility.RandomInt(0, 124)
							PlusInt = 0
						EndIf
						TempOutput[ RandomInt + PlusInt ] = Slot
						PlusInt += 1
					Else	
						TempOutput[ValidCount] = Slot
					EndIf
					ValidCount += 1
				endIf
			endIf
		endIf
	endWhile
	;  Output = GetList(Valid)
	If ValidCount >= 125
		Output = TempOutput
	Else
		; Get list
		Output = sslUtility.AnimationArray(ValidCount)
		i = Output.Length
		while i
			i -= 1
			Output[i] = TempOutput[i]
		endWhile
	EndIf
	CacheAnims(CacheName, Output)
	return Output
endFunction

sslBaseAnimation[] function GetByDefaultTags(int Males, int Females, bool IsAggressive = false, bool UsingBed = false, bool RestrictAggressive = true, string Tags, string TagsSuppressed = "", bool RequireAll = true)
	Log("GetByDefaultTags(Males="+Males+", Females="+Females+", IsAggressive="+IsAggressive+", UsingBed="+UsingBed+", RestrictAggressive="+RestrictAggressive+", Tags="+Tags+", TagsSuppressed="+TagsSuppressed+", RequireAll="+RequireAll+")")
	if Males == 0 && Females == 0
		return none ; No actors passed or creatures present
	endIf
	; Info
	int ActorCount = (Males + Females)
	bool SameSex = (Females == 2 && Males == 0) || (Males == 2 && Females == 0)
	bool BedRemoveStanding = Config.BedRemoveStanding
	; Making the tags lists and optimize for CACHE
	string[] Suppress = StringSplit(TagsSuppressed)
	Suppress = ClearEmpty(Suppress)
	SortStringArray(Suppress)
	string[] Search   = StringSplit(Tags)
	Search = ClearEmpty(Search)
	SortStringArray(Search)
	; Cleaning the tags
	if UsingBed
		Search = RemoveString(Search, "Furniture")
		if BedRemoveStanding
			Search = RemoveString(Search, "Standing")
		endIf
	else
		Search = RemoveString(Search, "BedOnly")
	endIf
	if RestrictAggressive
		Search = RemoveString(Search, "Aggressive")
		Suppress = RemoveString(Suppress, "Aggressive")
	endIf
	Suppress = RemoveString(Suppress, GenderTag)
	; Check Cache
	string CacheName = Males+":"+Females+":"+IsAggressive+":"+UsingBed+":"+BedRemoveStanding+":"+RestrictAggressive+":"+Search+":"+Suppress+":"+RequireAll
	sslBaseAnimation[] Output = CheckCache(CacheName)
	if Output || IsCached(CacheName)
		return Output
	endIf
	; Search
	;  bool[] Valid      = Utility.CreateBoolArray(Slotted)
	int ValidCount
	int RandomInt
	int PlusInt = 11

	sslBaseAnimation[] TempOutput = new sslBaseAnimation[125]
	bool Valid
	string GenderTag = ActorLib.GetGenderTag(Females, Males)

	int i = Slotted
	while i
		i -= 1
		if Objects[i]
			sslBaseAnimation Slot = Objects[i] as sslBaseAnimation
			; Check for appropiate enabled aniamtion
;/ 			Valid[i] = Slot.Enabled && ActorCount == Slot.PositionCount
			if Valid[i]
				string[] RawTags = Slot.GetRawTags()
				int[] Genders = Slot.Genders
				; Suppress standing animations if on a bed
				Valid[i] = Valid[i] && ((!UsingBed && RawTags.Find("BedOnly") == -1) || (UsingBed && RawTags.Find("Furniture") == -1 && (!BedRemoveStanding || RawTags.Find("Standing") == -1)))
				; Suppress or ignore animation tags
				Valid[i] = Valid[i] && Slot.TagSearch(Search, Suppress, RequireAll) && (!RestrictAggressive || IsAggressive == (RawTags.Find("Aggressive") != -1))
				; Get SameSex + Non-SameSex
				if SameSex
					Valid[i] = Valid[i] && (RawTags.Find("FM") != -1 || (((Males == -1 || Males <= Genders[0]) && (Females == -1 || Females <= Genders[1])) || Slot.HasTag(GenderTag)))
				; Ignore genders for 3P+
				elseIf ActorCount < 3
					Valid[i] = Valid[i] && (((Males == -1 || Males <= Genders[0]) && (Females == -1 || Females <= Genders[1])) || Slot.HasTag(GenderTag))
				endIf
			endIf
 /;			
			Valid = Slot.Enabled && ActorCount == Slot.PositionCount
			if Valid
				string[] RawTags = Slot.GetRawTags()
				int[] Genders = Slot.Genders
				; Suppress standing animations if on a bed
				Valid = Valid && ((!UsingBed && RawTags.Find("BedOnly") == -1) || (UsingBed && RawTags.Find("Furniture") == -1 && (!BedRemoveStanding || RawTags.Find("Standing") == -1)))
				; Suppress or ignore animation tags
				Valid = Valid && Slot.TagSearch(Search, Suppress, RequireAll) && (!RestrictAggressive || IsAggressive == (RawTags.Find("Aggressive") != -1))
				; Get SameSex + Non-SameSex
				if SameSex
					Valid = Valid && (RawTags.Find("FM") != -1 || (((Males == -1 || Males <= Genders[0]) && (Females == -1 || Females <= Genders[1])) || Slot.HasTag(GenderTag)))
				; Ignore genders for 3P+
				elseIf ActorCount < 3
					Valid = Valid && (((Males == -1 || Males <= Genders[0]) && (Females == -1 || Females <= Genders[1])) || Slot.HasTag(GenderTag))
				endIf
				If Valid
					If ValidCount >= 125
						If PlusInt > 10 || RandomInt + PlusInt >= 125
							RandomInt = Utility.RandomInt(0, 124)
							PlusInt = 0
						EndIf
						TempOutput[ RandomInt + PlusInt ] = Slot
						PlusInt += 1
					Else	
						TempOutput[ValidCount] = Slot
					EndIf
					ValidCount += 1
				endIf
			endIf
		endIf
	endWhile
	;  Output = GetList(Valid)
	If ValidCount >= 125
		Output = TempOutput
	Else
		; Get list
		Output = sslUtility.AnimationArray(ValidCount)
		i = Output.Length
		while i
			i -= 1
			Output[i] = TempOutput[i]
		endWhile
	EndIf
	CacheAnims(CacheName, Output)
	return Output
endFunction

; ------------------------------------------------------- ;
; --- Registry Access                                     ;
; ------------------------------------------------------- ;

sslBaseAnimation function GetBySlot(int index)
	if index >= 0 && index < Slotted && Objects[index]
		return Objects[index] as sslBaseAnimation
	endIf
	return none
endFunction

sslBaseAnimation function GetByName(string FindName)
	return GetBySlot(FindByName(FindName))
endFunction

sslBaseAnimation function GetByRegistrar(string Registrar)
	return GetBySlot(FindByRegistrar(Registrar))
endFunction

int function FindByRegistrar(string Registrar)
	if Registrar != ""
		return Registry.Find(Registrar)
	endIf
	return -1
endFunction

int function FindByName(string FindName)
	int i = Slotted
	while i
		i -= 1
		if GetBySlot(i) && GetBySlot(i).Name == FindName
			return i
		endIf
	endWhile
	return -1
endFunction

bool function IsRegistered(string Registrar)
	return FindByRegistrar(Registrar) != -1
endFunction

; ------------------------------------------------------- ;
; --- Object Utilities                                --- ;
; ------------------------------------------------------- ;

sslBaseAnimation[] function GetList(bool[] Valid)
	sslBaseAnimation[] Output
	if Valid && Valid.Length > 0 && Valid.Find(true) != -1
		int n = Valid.Find(true)
		int i = CountBool(Valid, true)
		; Trim over 100 to random selection
		if i > 125
			int end = Valid.RFind(true) - 1
			while i > 125
				int rand = Valid.Find(true, Utility.RandomInt(n, end))
				if rand != -1 && Valid[rand]
					Valid[rand] = false
					i -= 1
				endIf
				if i == 126 ; To be sure only 125 stay
					i = CountBool(Valid, true)
					n = Valid.Find(true)
					end = Valid.RFind(true) - 1
				endIf
			endWhile
		endIf
		; Get list
		Output = sslUtility.AnimationArray(i)
		while n != -1 && i > 0
			i -= 1
			Output[i] = Objects[n] as sslBaseAnimation
			n += 1
			if n < Slotted
				n = Valid.Find(true, n)
			else
				n = -1
			endIf
		endWhile
	else
		; Log("No Animations Found")
	endIf
	return Output
endFunction

string[] function GetRawNames(sslBaseAnimation[] SlotList)
	int i = SlotList.Length
	string[] Names = Utility.CreateStringArray(i)
	while i
		i -= 1
		if SlotList[i]
			Names[i] = SlotList[i].Name
		endIf
	endWhile
	return Names
endFunction

string[] function GetNames(sslBaseAnimation[] SlotList)
	int i = SlotList.Length
	string[] Names = GetRawNames(SlotList)
	if Names.Find("") != -1
		Names = RemoveString(Names, "")
	endIf
	return Names
endFunction

int function CountTag(sslBaseAnimation[] Anims, string Tags)
	string[] Checking = StringSplit(Tags)
	Checking = ClearEmpty(Checking)
	if Tags == "" || Checking.Length == 0
		return 0
	endIf
	int count
	int i = Anims.Length
	while i
		i -= 1
		count += Anims[i].HasOneTag(Checking) as int
	endWhile
	return count
endFunction

int function GetCount(bool IgnoreDisabled = true)
	if !IgnoreDisabled
		return Slotted
	endIf
	int Count
	int i = Slotted
	while i
		i -= 1
		Count += ((GetBySlot(i) && GetBySlot(i).Enabled) as int)
	endWhile
	return Count
endFunction

int function FindFirstTagged(string Tags, bool IgnoreDisabled = true, bool Reverse = false)
	string[] Checking = StringSplit(Tags)
	Checking = ClearEmpty(Checking)
	if Tags == "" || Checking.Length == 0
		return -1
	endIf
	int count
	int i = 0
	if !Reverse 
		i = Slotted
	endIf
	while (i && !Reverse) || (i < Slotted && Reverse)
		if !Reverse 
			i -= 1
		endIf
		if Objects[i]
			sslBaseAnimation Slot = Objects[i] as sslBaseAnimation
			if ((Slot.Enabled || !IgnoreDisabled) && Slot.HasAllTag(Checking))
				return i
			endIf
		endIf
		if Reverse 
			i += 1
		endIf
	endWhile
	return -1
endFunction

int function CountTagUsage(string Tags, bool IgnoreDisabled = true)
	string[] Checking = StringSplit(Tags)
	Checking = ClearEmpty(Checking)
	if Tags == "" || Checking.Length == 0
		return 0
	endIf
	int count
	int i = Slotted
	while i
		i -= 1
		if Objects[i]
			sslBaseAnimation Slot = Objects[i] as sslBaseAnimation
			count += ((Slot.Enabled || !IgnoreDisabled) && Slot.HasAllTag(Checking)) as int
		endIf
	endWhile
	return count
endfunction

string[] function GetAllTags(int ActorCount = -1, bool IgnoreDisabled = true)
	IgnoreDisabled = !IgnoreDisabled
	string[] Output
	int i = Slotted
	while i
		i -= 1
		if Objects[i]
			sslBaseAnimation Anim = Objects[i] as sslBaseAnimation
			if Anim && (IgnoreDisabled || Anim.Enabled) && (ActorCount == -1 || Anim.PositionCount == ActorCount)
				Output = MergeStringArray(Output, Anim.GetRawTags(), true)
			endif
		endIf
	endwhile
	SortStringArray(Output)
	return RemoveString(Output, "")
endFunction

; ------------------------------------------------------- ;
; --- Cached Tag Search
; ------------------------------------------------------- ;


int SlottedCache
string[] FilterCache
float[] CacheTimes
string[] FilterEmptyCache
float[] EmptyCacheTimes
sslBaseAnimation[] AnimCache0
sslBaseAnimation[] AnimCache1
sslBaseAnimation[] AnimCache2
sslBaseAnimation[] AnimCache3
sslBaseAnimation[] AnimCache4
sslBaseAnimation[] AnimCache5
sslBaseAnimation[] AnimCache6
sslBaseAnimation[] AnimCache7
sslBaseAnimation[] AnimCache8
sslBaseAnimation[] AnimCache9
sslBaseAnimation[] AnimCache10
sslBaseAnimation[] AnimCache11
sslBaseAnimation[] AnimCache12
sslBaseAnimation[] AnimCache13
sslBaseAnimation[] AnimCache14
sslBaseAnimation[] AnimCache15
sslBaseAnimation[] AnimCache16
sslBaseAnimation[] AnimCache17
sslBaseAnimation[] AnimCache18
sslBaseAnimation[] AnimCache19
sslBaseAnimation[] AnimCache20
sslBaseAnimation[] AnimCache21
sslBaseAnimation[] AnimCache22
sslBaseAnimation[] AnimCache23
sslBaseAnimation[] AnimCache24
sslBaseAnimation[] AnimCache25
sslBaseAnimation[] AnimCache26
sslBaseAnimation[] AnimCache27
sslBaseAnimation[] AnimCache28
sslBaseAnimation[] AnimCache29

function ClearAnimCache()
	SlottedCache = Slotted
	FilterCache = new string[30]
	CacheTimes = new float[30]
	FilterEmptyCache = new string[90]
	EmptyCacheTimes = new float[90]
	AnimCache0 = sslUtility.AnimationArray(0)
	AnimCache1 = sslUtility.AnimationArray(0)
	AnimCache2 = sslUtility.AnimationArray(0)
	AnimCache3 = sslUtility.AnimationArray(0)
	AnimCache4 = sslUtility.AnimationArray(0)
	AnimCache5 = sslUtility.AnimationArray(0)
	AnimCache6 = sslUtility.AnimationArray(0)
	AnimCache7 = sslUtility.AnimationArray(0)
	AnimCache8 = sslUtility.AnimationArray(0)
	AnimCache9 = sslUtility.AnimationArray(0)
	AnimCache10 = sslUtility.AnimationArray(0)
	AnimCache11 = sslUtility.AnimationArray(0)
	AnimCache12 = sslUtility.AnimationArray(0)
	AnimCache13 = sslUtility.AnimationArray(0)
	AnimCache14 = sslUtility.AnimationArray(0)
	AnimCache15 = sslUtility.AnimationArray(0)
	AnimCache16 = sslUtility.AnimationArray(0)
	AnimCache17 = sslUtility.AnimationArray(0)
	AnimCache18 = sslUtility.AnimationArray(0)
	AnimCache19 = sslUtility.AnimationArray(0)
	AnimCache20 = sslUtility.AnimationArray(0)
	AnimCache21 = sslUtility.AnimationArray(0)
	AnimCache22 = sslUtility.AnimationArray(0)
	AnimCache23 = sslUtility.AnimationArray(0)
	AnimCache24 = sslUtility.AnimationArray(0)
	AnimCache25 = sslUtility.AnimationArray(0)
	AnimCache26 = sslUtility.AnimationArray(0)
	AnimCache27 = sslUtility.AnimationArray(0)
	AnimCache28 = sslUtility.AnimationArray(0)
	AnimCache29 = sslUtility.AnimationArray(0)
;	Log("AnimCache: Cleared!")
endFunction

bool function ValidateCache()
	; Check for change on the amount of registered animations or corrupted arrays probably as concequence of a corrupt save
	if SlottedCache != Slotted || FilterCache.Length < 30 || CacheTimes.Length < 30 || FilterEmptyCache.Length < 90 || EmptyCacheTimes.Length < 90
		Log("AnimCache: INVALIDATED! "+SlottedCache+" -> "+Slotted)
		ClearAnimCache()
		return false
	endIf
	; SlottedCache = Slotted
	return true
endFunction

bool function IsCached(string CacheName)
	return ValidateCache() && (FilterCache.Find(CacheName) != -1 || FilterEmptyCache.Find(CacheName) != -1)
endFunction

sslBaseAnimation[] function CheckCache(string CacheName)
	sslBaseAnimation[] Output
	if ValidateCache() && CacheName
		int i = FilterCache.Find(CacheName)
		if i != -1
			Output = GetCacheSlot(i)
		;	float LiveTime = Math.Abs(Utility.GetCurrentGameTime() - CacheTimes[i]) * 24
			Log("AnimCache: HIT["+i+"] -- "+CacheName+" -- Count["+Output.Length+"]")
			if Output.Length >= 125 ; || LiveTime > 1.5
				InvalidateBySlot(i)
			else
				CacheTimes[i] = Utility.GetCurrentGameTime()
			endIf
		else
			i = FilterEmptyCache.Find(CacheName)
			if i != -1
				Log("AnimCache: HIT["+i+"] -- "+CacheName+" -- Count[0]")
			else
				Log("AnimCache: MISS -- "+CacheName)
			endIf
		endIf
	endIf
	return Output
endFunction

sslBaseAnimation[] function GetCacheByName(string CacheName)
	sslBaseAnimation[] Output
	if ValidateCache() && CacheName
		int i = FilterCache.Find(CacheName)
		if i != -1
			Output = GetCacheSlot(i)
			Log("AnimCache: HIT["+i+"] -- "+CacheName+" -- Count["+Output.Length+"]")
		else
			i = FilterEmptyCache.Find(CacheName)
			if i != -1
				Log("AnimCache: HIT["+i+"] -- "+CacheName+" -- Count[0]")
			else
				Log("AnimCache: MISS -- "+CacheName)
			endIf
		endIf
	endIf
	return Output
endFunction

function CacheAnims(string CacheName, sslBaseAnimation[] Anims)
	if !CacheName
		return
	endIf
	if !Anims ; CACHE for Empty Animation lists
		; Pick cache slot
		int i = FilterEmptyCache.Find(CacheName)
		if i != -1
			Log("AnimCache: Refreshing EmptySlot: "+i)
		else
			i = FilterEmptyCache.Find("")
			if i != -1
				Log("AnimCache: Using EmptySlot: "+i)
			else
				i = OldestEmptyCache()
				Log("AnimCache: Replacing oldest EmptySlot: "+i)
			endIf
		endIf
		FilterEmptyCache[i] = CacheName
		EmptyCacheTimes[i] = Utility.GetCurrentGameTime()
		return
	endIf
	; Pick cache slot
	int i = FilterCache.Find(CacheName)
	if i != -1
		Log("AnimCache: Refreshing Slot: "+i+" -- Count["+Anims.Length+"]")
	else
		i = FilterCache.Find("")
		if i != -1
			Log("AnimCache: Using Slot: "+i+" -- Count["+Anims.Length+"]")
		else
			i = OldestCache()
			Log("AnimCache: Replacing oldest Slot: "+i+" -- Count["+Anims.Length+"]")
		endIf
	endIf
	; Set cache slot
	if i <= 9 && i >= 0
		if i == 0
			AnimCache0 = Anims
		elseIf i == 1
			AnimCache1 = Anims
		elseIf i == 2
			AnimCache2 = Anims
		elseIf i == 3
			AnimCache3 = Anims
		elseIf i == 4
			AnimCache4 = Anims
		elseIf i == 5
			AnimCache5 = Anims
		elseIf i == 6
			AnimCache6 = Anims
		elseIf i == 7
			AnimCache7 = Anims
		elseIf i == 8
			AnimCache8 = Anims
		elseIf i == 9
			AnimCache9 = Anims
		endIf
	elseIf i <= 19
		if i == 10
			AnimCache10 = Anims
		elseIf i == 11
			AnimCache11 = Anims
		elseIf i == 12
			AnimCache12 = Anims
		elseIf i == 13
			AnimCache13 = Anims
		elseIf i == 14
			AnimCache14 = Anims
		elseIf i == 15
			AnimCache15 = Anims
		elseIf i == 16
			AnimCache16 = Anims
		elseIf i == 17
			AnimCache17 = Anims
		elseIf i == 18
			AnimCache18 = Anims
		elseIf i == 19
			AnimCache19 = Anims
		endIf
	elseIf i <= 29
		if i == 20
			AnimCache20 = Anims
		elseIf i == 21
			AnimCache21 = Anims
		elseIf i == 22
			AnimCache22 = Anims
		elseIf i == 23
			AnimCache23 = Anims
		elseIf i == 24
			AnimCache24 = Anims
		elseIf i == 25
			AnimCache25 = Anims
		elseIf i == 26
			AnimCache26 = Anims
		elseIf i == 27
			AnimCache27 = Anims
		elseIf i == 28
			AnimCache28 = Anims
		elseIf i == 29
			AnimCache29 = Anims
		endIf
	else
		Log("AnimCache: Invalid cache slot. This shouldn't be possible!")
		return
	endIf
	FilterCache[i] = CacheName
	CacheTimes[i] = Utility.GetCurrentGameTime()
endFunction

sslBaseAnimation[] function GetCacheSlot(int i)
	if i <= 9 && i >= 0
		if i == 0
			return AnimCache0
		elseIf i == 1
			return AnimCache1
		elseIf i == 2
			return AnimCache2
		elseIf i == 3
			return AnimCache3
		elseIf i == 4
			return AnimCache4
		elseIf i == 5
			return AnimCache5
		elseIf i == 6
			return AnimCache6
		elseIf i == 7
			return AnimCache7
		elseIf i == 8
			return AnimCache8
		elseIf i == 9
			return AnimCache9
		endIf
	elseIf i <= 19
		if i == 10
			return AnimCache10
		elseIf i == 11
			return AnimCache11
		elseIf i == 12
			return AnimCache12
		elseIf i == 13
			return AnimCache13
		elseIf i == 14
			return AnimCache14
		elseIf i == 15
			return AnimCache15
		elseIf i == 16
			return AnimCache16
		elseIf i == 17
			return AnimCache17
		elseIf i == 18
			return AnimCache18
		elseIf i == 19
			return AnimCache19
		endIf
	elseIf i <= 29
		if i == 20
			return AnimCache20
		elseIf i == 21
			return AnimCache21
		elseIf i == 22
			return AnimCache22
		elseIf i == 23
			return AnimCache23
		elseIf i == 24
			return AnimCache24
		elseIf i == 25
			return AnimCache25
		elseIf i == 26
			return AnimCache26
		elseIf i == 27
			return AnimCache27
		elseIf i == 28
			return AnimCache28
		elseIf i == 29
			return AnimCache29
		endIf
	endIf
	Log("AnimCache: GetCacheSlot("+i+") - INVALID CACHE SLOT")
	return sslUtility.AnimationArray(0)
endFunction

int function OldestCache()
	float var = CacheTimes[0]
	int index = 0
	int i = 1
	while i < CacheTimes.Length
		if CacheTimes[i] < var
			var = CacheTimes[i]
			index = i
		endIf
		i += 1
	endWhile
	return index
endFunction

int function OldestEmptyCache()
	float var = EmptyCacheTimes[0]
	int index = 0
	int i = 1
	while i < EmptyCacheTimes.Length
		if EmptyCacheTimes[i] < var
			var = EmptyCacheTimes[i]
			index = i
		endIf
		i += 1
	endWhile
	return index
endFunction

function InvalidateByAnimation(sslBaseAnimation removing)
	int i = 0
	while i < FilterCache.Length
		sslBaseAnimation[] arr = GetCacheSlot(i)
		if arr && FilterCache[i] != "" && arr.Find(removing) != -1
			Log("InvalidateByAnimation: Found invalid animation in slot["+i+"]: "+FilterCache[i])
			InvalidateBySlot(i)
		endIf
		i += 1
	endWhile
endFunction

function InvalidateByRegistrar(string Registrar)
	InvalidateByAnimation(GetByRegistrar(Registrar))
endFunction

function InvalidateByTags(string Tags)
	if Tags != ""
		string[] Search   = StringSplit(Tags)
		Search = ClearEmpty(Search)
		if Tags != "" && Search.Length > 0
			If Search.Find("Aggressive") >= 0 || Search.Find("LeadIn") >= 0 || Search.Find("BedOnly") >= 0 || Search.Find("Furniture") >= 0 || (Config.BedRemoveStanding && Search.Find("Standing") >= 0)
				ClearAnimCache()
			Else
				int i = 0
				int n = 0
				while n < Search.Length
					while i < FilterCache.Length
						if FilterCache[i] != "" && StringUtil.Find(FilterCache[i], "\""+Search[n]+"\"") >= 0
							Log("InvalidateByTags: Found invalid tag in slot["+i+"]: "+FilterCache[i])
							InvalidateBySlot(i)
						endIf
						i += 1
					endWhile
					i = 0
					while i < FilterEmptyCache.Length
						if FilterEmptyCache[i] != "" && StringUtil.Find(FilterEmptyCache[i], "\""+Search[n]+"\"") >= 0
							Log("InvalidateEmptyByTags: Found invalid tag in slot["+i+"]: "+FilterEmptyCache[i])
							InvalidateEmptyBySlot(i)
						endIf
						i += 1
					endWhile
					i = 0
					n += 1
				endWhile
			endIf
		endIf
	endIf
endFunction

function InvalidateBySlot(int i)
	FilterCache[i] = ""
	CacheTimes[i] = 0.0
	StorageUtil.SetIntValue(Config, CacheID, SexLabUtil.GetCurrentGameTimeSeconds() as int) ; This one will reset the Tag Cache once all the Menu be closed.
endFunction

function InvalidateEmptyBySlot(int i)
	FilterEmptyCache[i] = ""
	EmptyCacheTimes[i] = 0.0
endFunction

string function CacheInfo(int i)
	sslBaseAnimation[] arr = GetCacheSlot(i)
	return "["+i+"] -- Name: "+FilterCache[i]+" -- Timestamp: "+CacheTimes[i]+" -- Count: "+arr.Length
endfunction

string function EmptyCacheInfo(int i)
	return "["+i+"] -- Name: "+FilterEmptyCache[i]+" -- Timestamp: "+EmptyCacheTimes[i]+" -- Count: 0"
endfunction

function OutputCacheLog()
	int i = 0
	while i < FilterCache.Length
		Log(CacheInfo(i))
		i += 1
	endWhile
endFunction

function OutputEmptyCacheLog()
	int i = 0
	while i < FilterEmptyCache.Length
		Log(EmptyCacheInfo(i))
		i += 1
	endWhile
endFunction

; ------------------------------------------------------- ;
; --- Object MCM Pagination                               ;
; ------------------------------------------------------- ;

int function PageCount(int perpage = 125)
	return ((Slotted as float / perpage as float) as int) + 1
endFunction

int function FindPage(string Registrar, int perpage = 125)
	int i = Registry.Find(Registrar)
	if i != -1
		return ((i as float / perpage as float) as int) + 1
	endIf
	return -1
endFunction

string[] function GetSlotNames(int page = 1, int perpage = 125)
	;  return GetNames(GetSlots(page, perpage))
	String[] Names = GetRawSlotNames(page, perpage)
	if Names.Find("") != -1
		Names = RemoveString(Names, "")
	endIf
	return Names
endfunction

string[] function GetRawSlotNames(int page = 1, int perpage = 125)
	;  return GetRawNames(GetSlots(page, perpage))
	String[] Names
	if page > PageCount(perpage) || page < 1
		return Names
	endIf
	int n
	if page == PageCount(perpage)
		n = Slotted
		Names = Utility.CreateStringArray((Slotted - ((page - 1) * perpage)))
	else
		n = page * perpage
		Names = Utility.CreateStringArray(perpage)
	endIf
	sslBaseAnimation Slot
	int i = Names.Length
	while i
		i -= 1
		n -= 1
		Slot = GetBySlot(n)
		if Slot
			Names[i] = Slot.Name
		endIf
	endWhile
	return Names
endfunction

string[] function GetRawSlottedNames()
	String[] Names
	If Slotted
		int i = Slotted
		Names = Utility.CreateStringArray(i)
		sslBaseAnimation Slot
		while i
			i -= 1
			Slot = GetBySlot(i)
			if Slot
				Names[i] = Slot.Name
			endIf
		endWhile
	endIf
	return Names
endfunction

sslBaseAnimation[] function GetSlots(int page = 1, int perpage = 125)
	perpage = ClampInt(perpage, 1, 128)
	if page > PageCount(perpage) || page < 1
		return sslUtility.AnimationArray(0)
	endIf
	int n
	sslBaseAnimation[] PageSlots
	if page == PageCount(perpage)
		n = Slotted
		PageSlots = sslUtility.AnimationArray((Slotted - ((page - 1) * perpage)))
	else
		n = page * perpage
		PageSlots = sslUtility.AnimationArray(perpage)
	endIf
	int i = PageSlots.Length
	while i
		i -= 1
		n -= 1
		if Objects[n]
			PageSlots[i] = Objects[n] as sslBaseAnimation
		endIf
	endWhile
	return PageSlots
endFunction

; ------------------------------------------------------- ;
; --- Object Registration                                 ;
; ------------------------------------------------------- ;

function RegisterSlots()
	ClearAnimCache()
	ClearTagCache()
	; Register default animation
	PreloadCategoryLoaders()
	(Game.GetFormFromFile(0x639DF, "SexLab.esm") as sslAnimationDefaults).LoadAnimations()
	; Send mod event for 3rd party animation
	ModEvent.Send(ModEvent.Create("SexLabSlotAnimations"))
	Debug.Notification("$SSL_NotifyAnimationInstall")
endFunction

bool RegisterLock
int function Register(string Registrar)
	if Registrar == "" || !Registry || Registry.Length < 1
		return -1
	elseIf Registry.Find(Registrar) != -1 || Slotted >= GetNumAliases()
		return -1
	elseIf IsSuppressed(Registrar)
		Log("SKIPPING -- "+Registrar)
		return -1
	endIf

	; Thread lock registration
	float failsafe = Utility.GetCurrentRealTime() + 6.0
	while RegisterLock && failsafe < Utility.GetCurrentRealTime()
		Utility.WaitMenuMode(0.5)
		Log("Register("+Registrar+") - Lock wait...")
	endWhile
	RegisterLock = true

	ClearAnimCache()
	ClearTagCache()

	int i = Slotted
	Slotted += 1
	if i >= Registry.Length
		int n = Registry.Length + 32
		if n > GetNumAliases()
			n = GetNumAliases()
		endIf
		Log("Resizing animation registry slots: "+Registry.Length+" -> "+n)
		Registry = Utility.ResizeStringArray(Registry, n)
		Objects  = Utility.ResizeAliasArray(Objects, n, GetNthAlias(0))
		while n
			n -= 1
			if Registry[n] == ""
				Objects[n] = none
			endIf
		endWhile
		i = Registry.Find("")
	endIf
	Registry[i] = Registrar
	Objects[i]  = GetNthAlias(i)

	; Release lock
	RegisterLock = false
	return i
endFunction

sslBaseAnimation function RegisterAnimation(string Registrar, Form CallbackForm = none, ReferenceAlias CallbackAlias = none)
	; Return existing Animation
	if FindByRegistrar(Registrar) != -1
		return GetbyRegistrar(Registrar)
	endIf
	; Get free Animation slot
	int id = Register(Registrar)
	sslBaseAnimation Slot = GetBySlot(id)
	if id != -1 && Slot != none
		Slot.Initialize()
		Slot.Registry = Registrar
		Slot.Enabled  = true
		sslObjectFactory.SendCallback(Registrar, id, CallbackForm, CallbackAlias)
	endIf
	return Slot
endFunction

bool function UnregisterAnimation(string Registrar)
	if Registrar != "" && Registry.Find(Registrar) != -1
		ClearAnimCache()
		ClearTagCache()
		int Slot = Registry.Find(Registrar)
		(Objects[Slot] as sslBaseAnimation).Initialize()
		Objects[Slot] = none
		Registry[Slot] = ""
		Config.Log("Animation["+Slot+"] "+Registrar, "UnregisterAnimation()")
		return true	
	endIf
	return false
endFunction

bool function IsSuppressed(string Registrar)
	return JsonUtil.StringListHas("../SexLab/SuppressedAnimations.json", "suppress", Registrar)
endFunction

function NeverRegister(string Registrar)
	if !IsSuppressed(Registrar)
		JsonUtil.StringListAdd("../SexLab/SuppressedAnimations.json", "suppress", Registrar, false)
		JsonUtil.Save("../SexLab/SuppressedAnimations.json", true)
	endIf
endFunction

function AllowRegister(string Registrar)
	if IsSuppressed(Registrar)
		JsonUtil.StringListRemove("../SexLab/SuppressedAnimations.json", "suppress", Registrar, true)
		JsonUtil.Save("../SexLab/SuppressedAnimations.json", true)
	endIf
endFunction

int function ClearSuppressed()
	int i = JsonUtil.StringListClear("../SexLab/SuppressedAnimations.json", "suppress")
	JsonUtil.Save("../SexLab/SuppressedAnimations.json", true)
	return i
endFunction

int function GetDisabledCount()
	int count
	int i = Slotted
	while i
		i -= 1
		if Objects[i]
			sslBaseAnimation Slot = Objects[i] as sslBaseAnimation
			if Slot.Registered && !Slot.Enabled
				count += 1
			endIf
		endIf
	endWhile
	return count
endFunction

int function GetSuppressedCount()
	return JsonUtil.StringListCount("../SexLab/SuppressedAnimations.json", "suppress")
endFunction

int function SuppressDisabled()
	int count
	int i = Slotted
	while i
		i -= 1
		if Objects[i]
			sslBaseAnimation Slot = Objects[i] as sslBaseAnimation
			if Slot.Registered && !Slot.Enabled
				NeverRegister(Slot.Registry)
				count += 1
			endIf
		endIf
	endWhile
	return count
endFunction

string[] function GetSuppressedList()
	return JsonUtil.StringListToArray("../SexLab/SuppressedAnimations.json", "suppress")
endFunction

function PreloadCategoryLoaders()
	string[] Files = JsonUtil.JsonInFolder(JLoaders)
	if !Files
		return ; No JSON Animation Loaders
	endIf

	; Clear existing lists
	StorageUtil.StringListClear(self, "categories")
	StorageUtil.ClearObjStringListPrefix(self, "cat.")

	; Load files into categories
	int i = Files.Length
	while i
		i -= 1
		; Ignore the 2 example files.
		if Files[i] != "ArrokReverseCowgirl.json" && Files[i] != "TrollGrabbing.json"
			string Category = JsonUtil.GetPathStringValue(JLoaders+Files[i], ".category", "Misc")
			StorageUtil.StringListAdd(self, "categories", Category, false)
			StorageUtil.StringListAdd(self, "cat."+Category, Files[i], false)
		endIf
	endWhile
endFunction

;/ function RegisterJSONFolder()
	string[] Files = JsonUtil.JsonInFolder(JLoaders)
	if !Files
		Log("No JSON Animations Found: "+JLoaders)
		return
	endIf
	Log("JSON Files: "+Files)
	; int fl = StringUtil.GetLength(Folder) - 1
	int i = Files.Length
	while i
		i -= 1
		string Registrar = StringUtil.Substring(Files[i], 0, StringUtil.GetLength(Files[i]) - 5)
		RegisterJSON(JLoaders+Files[i], Registrar)
	endWhile
endFunction /;

; ------------------------------------------------------- ;
; --- System Use Only                                 --- ;
; ------------------------------------------------------- ;

string property JLoaders auto hidden

function Setup()
	GoToState("Locked")
	ClearEvents()
	Slotted  = 0
	Registry = new string[128] ; Utility.CreateStringArray(164)
	Objects  = new Alias[128] ; Utility.CreateAliasArray(164, GetNthAlias(0))
	PlayerRef = Game.GetPlayer()
	if !Config || !ActorLib || !ThreadLib
		Form SexLabQuestFramework = Game.GetFormFromFile(0xD62, "SexLab.esm")
		if SexLabQuestFramework
			Config    = SexLabQuestFramework as sslSystemConfig
			ThreadLib = SexLabQuestFramework as sslThreadLibrary
			ActorLib  = SexLabQuestFramework as sslActorLibrary
		endIf
	endIf

	JLoaders = "../SexLab/Animations/"
	if self == Config.CreatureSlots
		JLoaders += "Creatures/"
	endIf

	CacheID = "SexLab.AnimationTags"

	RegisterLock = false
	RegisterSlots()
	RegisterEvents()
	GoToState("")
endFunction

function RegisterEvents()
	string e = "SexLabSlotAnimations_"
	if self == Config.CreatureSlots
		e = "SexLabSlotCreatureAnimations_"
	endIf
	; Quick Events
	RegisterForModEvent(e+"InvalidateByRegistrar", "InvalidateByRegistrar")
	RegisterForModEvent(e+"InvalidateByTags", "InvalidateByTags")
endFunction

function ClearEvents()
	string e = "SexLabSlotAnimations_"
	if self == Config.CreatureSlots
		e = "SexLabSlotCreatureAnimations_"
	endIf
	; Quick Events
	UnregisterForModEvent(e+"InvalidateByRegistrar")
	UnregisterForModEvent(e+"InvalidateByTags")
endFunction


string property CacheID auto hidden
string[] function GetTagCache(bool IgnoreCache = false)
	if IgnoreCache || !StorageUtil.StringListHas(Config, CacheID, "Vaginal") || (StorageUtil.HasIntValue(Config, CacheID) && (SexLabUtil.GetCurrentGameTimeSeconds() as int) > StorageUtil.GetIntValue(Config, CacheID))
		DoCache()
	endIf
	return StorageUtil.StringListToArray(Config, CacheID)
endFunction

bool function HasTagCache(string Tag ,bool IgnoreCache = false)
	if !Tag || Tag == ""
		return False
	endIf
	if IgnoreCache || !StorageUtil.StringListHas(Config, CacheID, "Vaginal") || (StorageUtil.HasIntValue(Config, CacheID) && (SexLabUtil.GetCurrentGameTimeSeconds() as int) > StorageUtil.GetIntValue(Config, CacheID))
		DoCache()
	endIf
	return StorageUtil.StringListHas(Config, CacheID, Tag)
endFunction

function ClearTagCache()
	StorageUtil.StringListClear(Config, CacheID)
	StorageUtil.UnsetIntValue(Config, CacheID)
endFunction

function DoCache()
	if !CacheID
		Log("FAILED TO CACHE TAGS, CACHEID NOT SET")
		return
	endIf

	float time = Utility.GetCurrentRealTime()

	; Tags to ignore and will be pushed to front of list later.
	string[] Override = new string[9]
	Override[0] = "Vaginal"
	Override[1] = "Anal"
	Override[2] = "Oral"
	Override[3] = "Cowgirl"
	Override[4] = "Laying"
	Override[5] = "Missionary"
	Override[6] = "Standing"
	Override[7] = "Dirty"
	Override[8] = "Loving"

	; Find unique tags
	StorageUtil.StringListClear(Config, CacheID)
	int Slot
	while Slot < Slotted
		if Objects[Slot]
			string[] Tags = (Objects[Slot] as sslBaseAnimation).GetRawTags()
			int t = Tags.Length
			while t > 0
				t -= 1
				if Tags[t] != "" && Override.Find(Tags[t]) == -1
					StorageUtil.StringListAdd(Config, CacheID, Tags[t], false)
				endIf
			endWhile
		endIf
		Slot += 1
	endWhile
	StorageUtil.StringListSort(Config, CacheID)
	
	; Push common/important tags to front
	int i = Override.Length
	while i
		i -= 1
		StorageUtil.StringListInsert(Config, CacheID, 0, Override[i])
	endWhile

	StorageUtil.UnsetIntValue(Config, CacheID)
	Log(CacheID+" finished caching ("+StorageUtil.StringListCount(Config, CacheID)+") tags in ("+(Utility.GetCurrentRealTime() - time)+") seconds -- ");+StorageUtil.StringListToArray(Config, CacheID))
endFunction

function Log(string msg)
	if Config.DebugMode
		MiscUtil.PrintConsole(msg)
		Debug.TraceUser("SexLabDebug", msg)
	endIf
	Debug.Trace("SEXLAB - "+msg)
endFunction

state Locked
	function Setup()
	endFunction
endState

bool function TestSlots()
	return true
endFunction

; ------------------------------------------------------- ;
; --- Legacy Use Only                                 --- ;
; ------------------------------------------------------- ;

sslBaseAnimation[] function RemoveTagged(sslBaseAnimation[] Anims, string Tags)
	return sslUtility.FilterTaggedAnimations(Anims, StringSplit(Tags), false)
endFunction

sslBaseAnimation[] function MergeLists(sslBaseAnimation[] List1, sslBaseAnimation[] List2)
	return sslUtility.MergeAnimationLists(List1, List2)
endFunction

bool[] function FindTagged(sslBaseAnimation[] Anims, string Tags)
	return sslUtility.FindTaggedAnimations(Anims, StringSplit(Tags))
endFunction