Scriptname _SLS_Trauma extends Quest  

Event OnInit()
	If Self.IsRunning()
		AliasStates = new String[3]
		AliasStates[0] = "" ; Player
		AliasStates[1] = "" ; Follower
		AliasStates[2] = "" ; Npc
		SetupTextureArrays()
		RegForSexEvents()
		SetPushChance()
		RegisterForCombat()
		RegisterForSingleUpdateGameTime(1.0)
	EndIf
EndEvent

Function BeginUpdates()
	If Self.IsRunning()
		RegisterForSingleUpdateGameTime(1.0)
	EndIf
EndFunction

Function RegisterForCombat()
	If DynamicTrauma && DynamicCombat
		RegisterForModEvent("_SLS_PlayerCombatChange", "On_SLS_PlayerCombatChange")
	Else
		UnRegisterForModEvent("_SLS_PlayerCombatChange")
	EndIf
EndFunction

Event On_SLS_PlayerCombatChange(Bool InCombat)
	If InCombat
		_SLS_TraumaDynamicCombatQuest.Start()
	Else
		_SLS_TraumaDynamicCombatQuest.Stop()
	EndIf
EndEvent

Function RegForSexEvents()
	UnRegisterForModEvent("HookAnimationStart")
	UnRegisterForModEvent("HookStageStart")
	UnRegisterForModEvent("HookAnimationEnd")
	If SexChancePlayer > 0.0 || SexChanceFollower > 0.0 || SexChanceNpc > 0.0
		RegisterForModEvent("HookAnimationStart", "OnAnimationStart")
		RegisterForModEvent("HookStageStart", "OnStageStart")
		RegisterForModEvent("HookAnimationEnd", "OnAnimationEnd")
	EndIf
EndFunction

Function SetPushChance(Bool OverrideOff = false)
	If !OverrideOff && PushChance > 0.0
		RegisterForAnimationEvent(PlayerRef, "getupstart")
		RegisterAliasesForGetUpEvent(_SLS_TraumaDynamicQuest, Register = true)
		RegisterAliasesForGetUpEvent(_SLS_TraumaAssignedQuest, Register = true)
	Else
		UnRegisterForAnimationEvent(PlayerRef, "getupstart")
		RegisterAliasesForGetUpEvent(_SLS_TraumaDynamicQuest, Register = false)
		RegisterAliasesForGetUpEvent(_SLS_TraumaAssignedQuest, Register = false)
	EndIf
EndFunction

Function RegisterAliasesForGetUpEvent(Quest akQuest, Bool Register)
	Int i = 0
	Actor akActor
	While i < akQuest.GetNumAliases()
		akActor = (akQuest.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
		If akActor
			If Register
				RegisterForAnimationEvent(akActor, "getupstart")
			Else
				UnRegisterForAnimationEvent(akActor, "getupstart")
			EndIf
		EndIf
		i += 1
	EndWhile
EndFunction

Function ToggleTrauma()
	If TraumaEnable
		Self.Start()
	Else
		SetPushChance(OverrideOff = true)
		ClearAllTraumaOverlays()
		_SLS_TraumaDynamicQuest.Stop()
		_SLS_TraumaAssignedQuest.Stop()
		StorageUtil.FormListClear(Self, "_SLS_ActorWipList")
		Self.Stop()
	EndIf
EndFunction

Function ToggleDynamicTrauma()
	If DynamicTrauma
		_SLS_TraumaDynamicQuest.Start()
	Else
		Int i = _SLS_TraumaDynamicQuest.GetNumAliases()
		Actor akActor
		While i > 0
			i -= 1
			akActor = (_SLS_TraumaDynamicQuest.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
			If akActor
				RemoveActorFromSystem(akActor, EmptyAlias = false) ; Quest is being shutdown. No need to empty alias
			EndIf
		EndWhile
		_SLS_TraumaDynamicQuest.Stop()
	EndIf
	RegisterForCombat()
EndFunction

Event OnUpdateGameTime()
	UpdateActor(PlayerRef)
	If DynamicTrauma
		RunUpdatesOnQuestAliases(_SLS_TraumaDynamicQuest)
	EndIf
	RunUpdatesOnQuestAliases(_SLS_TraumaAssignedQuest)
	RegisterForSingleUpdateGameTime(1.0)
EndEvent

Event OnAnimationStart(int tid, bool HasPlayer)
	Utility.Wait(2.0) ; Not high priority
	Actor[] ActorList = SexLab.GetController(tid).Positions
	If ActorList.Length > 1
		Int i = 0
		While i < ActorList.Length
			If Sexlab.IsVictim(tid, ActorList[i])
				If ActorList[i].IsInFaction(_SLS_TraumaFaction) || ActorList[i] == PlayerRef
					StorageUtil.IntListAdd(Self, "TidsOfInterest", tid, AllowDuplicate = false)
				ElseIf DynamicTrauma
					StorageUtil.IntListAdd(Self, "TidsOfInterest", tid, AllowDuplicate = false)
				EndIf
			EndIf
			i += 1
		EndWhile
	EndIf
EndEvent

Event OnAnimationEnd(int tid, bool HasPlayer)
	StorageUtil.IntListRemove(Self, "TidsOfInterest", tid, allInstances = true)
EndEvent

Event OnStageStart(int tid, bool HasPlayer)
	Utility.Wait(1.0)
	If StorageUtil.IntListHas(Self, "TidsOfInterest", tid)
		Actor[] ActorList = SexLab.GetController(tid).Positions
		Int i = 0
		While i < ActorList.Length
			If Sexlab.IsVictim(tid, ActorList[i])
				If ActorList[i] == PlayerRef
					DoSexTrauma(ActorList[i], SexHitsPlayer, SexChancePlayer)
				ElseIf ActorList[i].IsInFaction(PotentialFollowerFaction)
					DoSexTrauma(ActorList[i], SexHitsFollower, SexChanceFollower)
				Else
					DoSexTrauma(ActorList[i], SexHitsNpc, SexChanceNpc)
				EndIf
			EndIf
			i += 1
		EndWhile
	EndIf
EndEvent

Function DoSexTrauma(Actor akActor, Int Hits, Float Chance)
	Int i = Hits
	Bool WasHit = false
	While i > 0
		i -= 1
		If PassesTraumaChance(Chance)
			If !akActor.IsInFaction(_SLS_TraumaFaction) && DynamicTrauma
				GetEmptyOrOldestAlias(_SLS_TraumaDynamicQuest).ForceRefTo(akActor)
				StorageUtil.FormlistAdd(_SLS_TraumaDynamicQuest, "_SLS_TraumaActors", akActor, AllowDuplicate = false)
			EndIf
		
			If !WasHit
				WasHit = true
				Util.DoTraumaHitSound(akActor, PlayerSqueaks)
			EndIf
			AddRandomTrauma(akActor)
		EndIf
	EndWhile
EndFunction
;/
Function DoSexTraumaEffect(Actor akActor)
	; Sound.Play(ObjRef) appears to be a piece of shit and does not take into account the distance or direction from the player to the origin of the sound. So sounds always sound close-by. Great!
	Float Volume = (1.0 - (0.1 * (PlayerRef.GetDistance(akActor) / 128.0))) ; Reduce volume by 10% for every 128 units away from the player
	Int TraumaSound = _SLS_TraumaHitSM.Play(akActor)
	Sound.SetInstanceVolume(TraumaSound, Volume)
	If akActor == PlayerRef ;akActor.GetLeveledActorBase().GetSex() == 1
		TraumaSound = _SLS_PainSM.Play(akActor)
		Sound.SetInstanceVolume(TraumaSound, Volume / 2.0) ; Pain sounds are really loud - reduce them
	EndIf
EndFunction
/;
Bool Function PassesTraumaChance(Float Chance)
	If Chance > Utility.RandomFloat(0.0, 100.0)
		Return true
	EndIf
	Return false
EndFunction

Function ClearAllTraumaOverlays()
	RemoveActorFromSystem(PlayerRef)
	Actor akActor
	Int i = 0
	While i < _SLS_TraumaDynamicQuest.GetNumAliases()
		akActor =  (_SLS_TraumaDynamicQuest.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
		If akActor
			RemoveActorFromSystem(akActor)
		EndIf
		i += 1
	EndWhile
	
	i = 0
	While i < _SLS_TraumaAssignedQuest.GetNumAliases()
		akActor =  (_SLS_TraumaAssignedQuest.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
		If akActor
			RemoveActorFromSystem(akActor)
		EndIf
		i += 1
	EndWhile
EndFunction

Function SetupTextureArrays()
	ClearAllTraumaOverlays()
	
	String[] Files = MiscUtil.FilesInFolder("Data/textures/SL Survival/BattleWounds/Female/Face/", extension = "dds")
	Int i = 0
	While i < Files.Length
		StorageUtil.StringListAdd(Self, "_SLS_TexListFace", Files[i])
		i += 1
	EndWhile
	
	i = 0
	Files = MiscUtil.FilesInFolder("Data/textures/SL Survival/BattleWounds/Female/Body/", extension = "dds")
	While i < Files.Length
		StorageUtil.StringListAdd(Self, "_SLS_TexListBody", Files[i])
		i += 1
	EndWhile
	
	TexListFaceFemale = StorageUtil.StringListToArray(Self, "_SLS_TexListFace")
	TexListBodyFemale = StorageUtil.StringListToArray(Self, "_SLS_TexListBody")
	TexListAvailableFemaleMaster = PapyrusUtil.MergeStringArray(TexListFaceFemale, TexListBodyFemale, RemoveDupes = true)
	
	StorageUtil.StringListClear(Self, "_SLS_TexListFace")
	StorageUtil.StringListClear(Self, "_SLS_TexListBody")
	
	Files = MiscUtil.FilesInFolder("Data/textures/SL Survival/BattleWounds/Male/Face/", extension = "dds")
	i = 0
	While i < Files.Length
		StorageUtil.StringListAdd(Self, "_SLS_TexListFace", Files[i])
		i += 1
	EndWhile
	
	i = 0
	Files = MiscUtil.FilesInFolder("Data/textures/SL Survival/BattleWounds/Male/Body/", extension = "dds")
	While i < Files.Length
		StorageUtil.StringListAdd(Self, "_SLS_TexListBody", Files[i])
		i += 1
	EndWhile
	
	TexListFaceMale = StorageUtil.StringListToArray(Self, "_SLS_TexListFace")
	TexListBodyMale = StorageUtil.StringListToArray(Self, "_SLS_TexListBody")
	TexListAvailableMaleMaster = PapyrusUtil.MergeStringArray(TexListFaceMale, TexListBodyMale, RemoveDupes = true)
	
	StorageUtil.StringListClear(Self, "_SLS_TexListFace")
	StorageUtil.StringListClear(Self, "_SLS_TexListBody")
EndFunction

Function ToggleFollowerTracking(Actor akActor)
	If akActor.IsInFaction(_SLS_TraumaFaction) ; Remove
		RemoveActorFromSystem(akActor, EmptyAlias = true)
	Else ; Add
		ReferenceAlias AliasSelect = GetEmptyAlias(_SLS_TraumaAssignedQuest)
		If AliasSelect
			AliasSelect.ForceRefTo(akActor)
			StorageUtil.FormlistAdd(_SLS_TraumaAssignedQuest, "_SLS_TraumaActors", akActor, AllowDuplicate = false)
			SetupActor(akActor)
		Else
			Debug.Messagebox("No empty slots remaining. You must remove an existing tracked actor to add another")
		EndIf
	EndIf
EndFunction

Function SetupActor(Actor akActor)
	If akActor.GetLeveledActorBase().GetSex() == 1 ; Female
		StorageUtil.StringListCopy(akActor, "_SLS_TexListAvailable", TexListAvailableFemaleMaster)
	Else
		StorageUtil.StringListCopy(akActor, "_SLS_TexListAvailable", TexListAvailableMaleMaster)
	EndIf
	RegisterForAnimationEvent(akActor, "getupstart")
EndFunction

Function UnSetupActor(Actor akActor)
	UnregisterForAnimationEvent(akActor,  "getupstart")
	StorageUtil.StringListClear(akActor, "_SLS_TexListAvailable")
	StorageUtil.StringListClear(akActor, "_SLS_ActiveTraumas")
	StorageUtil.FloatListClear(akActor, "_SLS_ActiveTraumasBeginTimes")
	StorageUtil.UnSetFloatValue(akActor, "_SLS_LastTrauma")
	RemoveActorFromSystem(akActor, EmptyAlias = true)
EndFunction

Function RemoveActorFromSystem(Actor akActor, Bool EmptyAlias = false)
	; EmptyAlias - True - clears alias. False - doesn't clear alias. False when the actor is being swapped for another actor anyway
	RemoveAllTraumasFromActor(akActor)
	If StorageUtil.FormlistHas(_SLS_TraumaAssignedQuest, "_SLS_TraumaActors", akActor)
		StorageUtil.FormListRemove(_SLS_TraumaAssignedQuest, "_SLS_TraumaActors", akActor, allInstances = true)
		If EmptyAlias
			RemoveActorFromQuestAliases(akActor, _SLS_TraumaAssignedQuest)
		EndIf
	EndIf
	If StorageUtil.FormlistHas(_SLS_TraumaDynamicQuest, "_SLS_TraumaActors", akActor)
		StorageUtil.FormListRemove(_SLS_TraumaDynamicQuest, "_SLS_TraumaActors", akActor, allInstances = true)
		If EmptyAlias
			RemoveActorFromQuestAliases(akActor, _SLS_TraumaDynamicQuest)
		EndIf
	EndIf
EndFunction

Function RemoveActorFromQuestAliases(Actor akActor, Quest akQuest)
	Int i = akQuest.GetNumAliases()
	ReferenceAlias akAlias
	While i > 0
		i -= 1
		akAlias = akQuest.GetNthAlias(i) as ReferenceAlias
		If akAlias.GetReference() && akAlias.GetReference() as Actor == akActor
			akAlias.Clear()
			Return
		EndIf
	EndWhile	
EndFunction

Function RemoveAllTraumasFromActor(Actor akActor)
	Int i = StorageUtil.StringListCount(akActor, "_SLS_ActiveTraumas")
	While i > 0
		i -= 1
		RemoveTraumaAtIndex(akActor, i)
	EndWhile
EndFunction

Function AddRandomTrauma(Actor akActor)
	If StorageUtil.FormListFind(Self, "_SLS_ActorWipList", akActor) == -1
		StorageUtil.FormListAdd(Self, "_SLS_ActorWipList", akActor, AllowDuplicate = false)
		;If StorageUtil.StringListCount(akActor, "_SLS_TexListAvailable") <= 0
		If StorageUtil.CountObjStringListPrefix(akActor, "_SLS_TexListAvailable") <= 0
			SetupActor(akActor)
		EndIf
		
		Int TraumaCountMax = PlayerTraumaCountMax
		If akActor != PlayerRef
			If akActor.IsInFaction(PotentialFollowerFaction)
				TraumaCountMax = FollowerTraumaCountMax
			Else
				TraumaCountMax = NpcTraumaCountMax
			EndIf
		EndIf
		
		String NewTrauma = StorageUtil.StringListGet(akActor, "_SLS_TexListAvailable", Utility.RandomInt(0, StorageUtil.StringListCount(akActor, "_SLS_TexListAvailable") - 1))
		If NewTrauma
			If BeginAddOverlay(akActor, NewTrauma, TraumaCountMax) > -1
				StorageUtil.StringListRemove(akActor, "_SLS_TexListAvailable", NewTrauma)
				StorageUtil.StringListInsert(akActor, "_SLS_ActiveTraumas", 0, NewTrauma) ; Push new traumas into the start of the list. Oldest trauma is the last element
				StorageUtil.FloatListInsert(akActor, "_SLS_ActiveTraumasBeginTimes", 0, Utility.GetCurrentGameTime())
				StorageUtil.SetFloatValue(akActor, "_SLS_LastTrauma", Utility.GetCurrentGameTime())
			Else
				Debug.Trace("_SLS_: AddRandomTrauma(): Failed to get slot on actor" + akActor.GetLeveledActorBase().GetName() + " - " + akActor)
			EndIf			

		Else
			DumpInfo(akActor, NewTrauma)
			UnSetupActor(akActor)
		EndIf
		StorageUtil.FormListRemove(Self, "_SLS_ActorWipList", akActor, AllInstances = false)
	EndIf
EndFunction

Function DumpInfo(Actor akActor, String Trauma = "N/A")
	StorageUtil.StringListAdd(Self, "_SLS_TempLog", " ===== " + akActor.GetLeveledActorBase().GetName() + " ===== ")
	StorageUtil.StringListAdd(Self, "_SLS_TempLog", "Trauma: " + Trauma)
	StorageUtil.StringListAdd(Self, "_SLS_TempLog", "Active Count: " + StorageUtil.StringListCount(akActor, "_SLS_ActiveTraumas") + ". Avail Count: " + StorageUtil.StringListCount(akActor, "_SLS_TexListAvailable"))
	StorageUtil.StringListAdd(Self, "_SLS_TempLog", "Free Slots. Body: " + Util.CountEmptySlots(akActor, "Body") + "/" + Util.GetNumSlots("Body") +  ". Face: " + Util.CountEmptySlots(akActor, "Face") + "/" + Util.GetNumSlots("Face"))
	
	StorageUtil.StringListAdd(Self, "_SLS_TempLog", " ===== Active List ===== ")
	i = 0
	While i < StorageUtil.StringListCount(akActor, "_SLS_ActiveTraumas")
		StorageUtil.StringListAdd(Self, "_SLS_TempLog", i + ") " + StorageUtil.StringListGet(akActor, "_SLS_ActiveTraumas", i))
		i += 1
	EndWhile
	
	StorageUtil.StringListAdd(Self, "_SLS_TempLog", " ===== Avail List ===== ")
	Int i = 0
	While i < StorageUtil.StringListCount(akActor, "_SLS_TexListAvailable")
		StorageUtil.StringListAdd(Self, "_SLS_TempLog", i + ") " + StorageUtil.StringListGet(akActor, "_SLS_TexListAvailable", i))
		i += 1
	EndWhile
	
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	i = 0
	While i < StorageUtil.StringListCount(Self, "_SLS_TempLog")
		Debug.Trace("_SLS_: Trauma: " + StorageUtil.StringListGet(Self, "_SLS_TempLog", i))
		ListMenu.AddEntryItem(StorageUtil.StringListGet(Self, "_SLS_TempLog", i))
		i += 1
	EndWhile
	StorageUtil.StringListClear(Self, "_SLS_TempLog")
	ListMenu.OpenMenu()
EndFunction

Int Function RemoveTraumaAtIndex(Actor akActor, Int Index)
	;Debug.Messagebox("Index: " + Index + "\nAha: " + StorageUtil.StringListGet(akActor, "_SLS_ActiveTraumas", Index) + "\n\n" + StorageUtil.StringListToArray(akActor, "_SLS_ActiveTraumas"))
	String Trauma = StorageUtil.StringListGet(akActor, "_SLS_ActiveTraumas", Index)
	StorageUtil.StringListRemoveAt(akActor, "_SLS_ActiveTraumas", Index)
	StorageUtil.FloatListRemoveAt(akActor, "_SLS_ActiveTraumasBeginTimes", Index)
	StorageUtil.StringListAdd(akActor, "_SLS_TexListAvailable", Trauma)
	Int Slot = BeginRemoveOverlay(akActor, Trauma)
	
	If StorageUtil.StringListCount(akActor, "_SLS_ActiveTraumas") <= 0 && !StorageUtil.FormlistHas(_SLS_TraumaAssignedQuest, "_SLS_TraumaActors", akActor)
		UnSetupActor(akActor)
	EndIf
	Return Slot
EndFunction

Int Function RemoveOldestTrauma(Actor akActor, String Gender, String Area)
	Int i = StorageUtil.StringListCount(akActor, "_SLS_ActiveTraumas")
	While i > 0
		i -= 1
		If GetTextureArea(akActor, Gender, StorageUtil.StringListGet(akActor, "_SLS_ActiveTraumas", i)) == Area
			Return RemoveTraumaAtIndex(akActor, i)
		EndIf
	EndWhile
	Debug.Trace("_SLS_: RemoveOldestTrauma(): Failed! No active traumas on actor: " + akActor.GetLeveledActorBase().GetName() + " - " + akActor)
	Return -1
EndFunction

Int Function BeginAddOverlay(Actor akActor, String Texture, Int TraumaCountMax)
	String Gender = "Female"
	If akActor.GetLeveledActorBase().GetSex() != 1
		Gender = "Male"
	EndIf
	String AreaFolder = GetTextureArea(akActor, Gender, Texture)
	Int Slot
	If StorageUtil.StringListCount(akActor, "_SLS_ActiveTraumas") >= TraumaCountMax
		Slot = RemoveOldestTrauma(akActor, Gender, AreaFolder)
	Else
		Slot = Util.GetEmptySlot(akActor, (Gender == "Female") as Bool, AreaFolder)
		If Slot == -1
			Slot = RemoveOldestTrauma(akActor, Gender, AreaFolder)
		EndIf
	EndIf
	
	If Slot > -1
		Return Util.BeginOverlay(akActor, Alpha = StartingAlpha, TextureToApply = "\\SL Survival\\BattleWounds\\" + Gender + "\\" + AreaFolder + "\\" + Texture, Area = AreaFolder, SlotToUse = Slot)
	EndIf
	Debug.Trace("_SLS_: BeginAddOverlay(): Could not locate an empty slot in area: " + AreaFolder + " on actor: " + akActor.GetLeveledActorBase().GetName() + " - " + akActor)
	Return -1
EndFunction

Int Function BeginRemoveOverlay(Actor akActor, String Texture)
	String Gender = "Female"
	If akActor.GetLeveledActorBase().GetSex() != 1
		Gender = "Male"
	EndIf
	String AreaFolder = GetTextureArea(akActor, Gender, Texture)
	
	Return Util.RemoveOverlay(akActor, "\\SL Survival\\BattleWounds\\" + Gender + "\\" + AreaFolder + "\\" + Texture, Area = AreaFolder)
EndFunction

String Function GetTextureArea(Actor akActor, String Gender, String Texture)
	If Gender == "Male" && TexListFaceMale.Find(Texture) > -1
		Return "Face"
	ElseIf Gender == "Female" && TexListFaceFemale.Find(Texture) > -1
		Return "Face"
	EndIf
	Return "Body"
EndFunction

Function UpdateActor(Actor akActor)
	Int i = StorageUtil.StringListCount(akActor, "_SLS_ActiveTraumas")
	Float CurTime = Utility.GetCurrentGameTime()
	String[] FaceTexListForGender = TexListFaceFemale
	String Gender = "Female"
	If akActor.GetLeveledActorBase().GetSex() != 1
		Gender = "Male"
		FaceTexListForGender = TexListFaceMale
	EndIf
	While i > 0
		i -= 1
		UpdateAlpha(akActor, Gender, FaceTexListForGender, Texture = StorageUtil.StringListGet(akActor, "_SLS_ActiveTraumas", i), BeginTime = StorageUtil.FloatListGet(akActor, "_SLS_ActiveTraumasBeginTimes", i), CurTime = CurTime, TraumaIndex = i)
	EndWhile
	;/
	If StorageUtil.StringListCount(akActor, "_SLS_ActiveTraumas") <= 0
		UnSetupActor(akActor)
	EndIf/;
EndFunction

Function UpdateAlpha(Actor akActor, String Gender, String[] FaceTexList, String Texture, Float BeginTime, Float CurTime, Int TraumaIndex)
	Float Alpha
	If CurTime > BeginTime + (HoursToMaxAlpha / 24.0) ; Trauma has reached time to max alpha - use fade-out calc
		Alpha = Math.Tan(Math.Atan(MaxAlpha/((BeginTime + ((HoursToFadeOut + HoursToMaxAlpha) / 24.0)) - (BeginTime + (HoursToMaxAlpha / 24.0))))) * ((BeginTime + (HoursToMaxAlpha + HoursToFadeOut) / 24.0) - CurTime)
		;Debug.Messagebox("Alpha1: " + Alpha)
	Else ; Trauma is still fading in - use fade-in calc
		Alpha = StartingAlpha + ((Math.Tan(Math.Atan(MaxAlpha/((BeginTime + (HoursToMaxAlpha / 24.0)) - BeginTime))) * (CurTime - BeginTime)) * (MaxAlpha - StartingAlpha))
		;Debug.Messagebox("Alpha2: " + Alpha)
	EndIf
	
	If Alpha <= RemoveTraumaAlpha ; Remove trauma
		RemoveTraumaAtIndex(akActor, TraumaIndex)
		BeginRemoveOverlay(akActor, Texture)
	Else
		String AreaFolder = "Body"
		If FaceTexList.Find(Texture) > -1
			AreaFolder = "Face"
		EndIf
		Util.UpdateAlpha(akActor, Alpha, "\\SL Survival\\BattleWounds\\" + Gender + "\\" + AreaFolder + "\\" + Texture, AreaFolder)
	EndIf
EndFunction

ReferenceAlias Function GetEmptyAlias(Quest akQuest)
	Int i = 0
	ReferenceAlias akAlias
	While i < akQuest.GetNumAliases()
		akAlias = akQuest.GetNthAlias(i) as ReferenceAlias
		If !akAlias.GetReference()
			Return akAlias
		EndIf
		i += 1
	EndWhile
	Return None
EndFunction

ReferenceAlias Function GetEmptyOrOldestAlias(Quest akQuest)
	Int i = 0
	ReferenceAlias akAlias
	Int OldestAlias
	Float OldestAge = 10000000000.0
	While i < akQuest.GetNumAliases() && i < MaxDynamicNpcs
		akAlias = akQuest.GetNthAlias(i) as ReferenceAlias
		If !akAlias.GetReference()
			Return akAlias
		Else
			If StorageUtil.GetFloatValue(akAlias.GetReference(), "_SLS_LastTrauma") < OldestAge
				OldestAlias = i
				OldestAge = StorageUtil.GetFloatValue(akAlias.GetReference(), "_SLS_LastTrauma")
			EndIf
		EndIf
		i += 1
	EndWhile
	akAlias = akQuest.GetNthAlias(OldestAlias) as ReferenceAlias
	RemoveActorFromSystem(akAlias.GetReference() as Actor)
	Return akAlias
EndFunction

Function RunUpdatesOnQuestAliases(Quest akQuest)
	Int i = 0
	Actor akActor
	While i < akQuest.GetNumAliases()
		akActor = (akQuest.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
		If akActor
			UpdateActor(akActor)
		EndIf
		i += 1
	EndWhile
EndFunction

Function ToggleCombatTrauma()
	AliasStates[0] = "" ; Player
	AliasStates[1] = "" ; Follower
	AliasStates[2] = "" ; Npc
	If CombatChancePlayer <= 0.0
		AliasStates[0] = "off"
	EndIf
	If CombatChanceFollower <= 0.0
		AliasStates[1] = "off"
	EndIf
	If CombatChanceNpc <= 0.0
		AliasStates[2] = "off"
	EndIf
	SendModEvent("_SLS_ToggleCombatTrauma", strArg = "", numArg = 0.0)
EndFunction

String Function GetAliasState(Quest OwningQuest)
	; AliasType: 0 - Player, 1 - Follower, 2 - NpcHit
	If OwningQuest == _SLS_TraumaDynamicQuest
		Return AliasStates[2]
	ElseIf OwningQuest == _SLS_TraumaAssignedQuest
		Return AliasStates[1]
	Else
		Return AliasStates[0]
	EndIf
EndFunction

Function PlayerHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	;Debug.Messagebox("Hello")
	If CombatHitQualifies(abHitBlocked, akSource, CombatChancePlayer)
		If PlayerSqueaks && PlayerRef.GetLeveledActorBase().GetSex() == 1
			Util.DoFemalePainSound(PlayerRef, 1.0)
		EndIf
		AddRandomTrauma(PlayerRef)
	EndIf
EndFunction

Function FollowerHit(Actor akTarget, ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	If CombatHitQualifies(abHitBlocked, akSource, CombatChanceFollower)
		AddRandomTrauma(akTarget)
	EndIf
EndFunction

Function NpcHit(Actor akTarget, ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	If CombatHitQualifies(abHitBlocked, akSource, CombatChanceNpc)
		AddRandomTrauma(akTarget)
	EndIf
EndFunction

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	If PassesTraumaChance(PushChance)
		AddRandomTrauma(akSource as Actor)
	EndIf
EndEvent

Bool Function NpcCandidateHit(Actor akTarget, ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	If CombatHitQualifies(abHitBlocked, akSource, CombatChanceNpc)
		ReferenceAlias AliasSelect = GetEmptyOrOldestAlias(_SLS_TraumaDynamicQuest)
		If AliasSelect
			AliasSelect.ForceRefTo(akTarget)
			StorageUtil.FormlistAdd(_SLS_TraumaDynamicQuest, "_SLS_TraumaActors", akTarget, AllowDuplicate = false)
			AddRandomTrauma(akTarget)
			Return true
		EndIf
	EndIf
	Return false
EndFunction

Bool Function NpcCandidatePush(Actor akActor)
	If PassesTraumaChance(PushChance)
		ReferenceAlias AliasSelect = GetEmptyOrOldestAlias(_SLS_TraumaDynamicQuest)
		If AliasSelect
			AliasSelect.ForceRefTo(akActor)
			StorageUtil.FormlistAdd(_SLS_TraumaDynamicQuest, "_SLS_TraumaActors", akActor, AllowDuplicate = false)
			AddRandomTrauma(akActor)
			Return true
		EndIf
	EndIf
	Return false
EndFunction

Bool Function CombatHitQualifies(Bool abHitBlocked, Form akSource, Float Chance)
	If !abHitBlocked && akSource as Weapon && ((akSource as Weapon).GetBaseDamage() >= CombatDamageThreshold || (akSource as Weapon) == Unarmed) && PassesTraumaChance(Chance)
		Return true
	EndIf
	Return false
EndFunction

String[] AliasStates

String[] TexListAvailableFemaleMaster
String[] TexListFaceFemale
String[] TexListBodyFemale

String[] TexListAvailableMaleMaster
String[] TexListFaceMale
String[] TexListBodyMale

Bool Property TraumaEnable = true Auto Hidden
Bool Property DynamicTrauma = true Auto Hidden
Bool Property DynamicCombat = true Auto Hidden
Bool Property PlayerSqueaks = true Auto Hidden

Int Property PlayerTraumaCountMax = 15 Auto Hidden
Int Property FollowerTraumaCountMax = 15 Auto Hidden
Int Property NpcTraumaCountMax = 10 Auto Hidden
Int Property MaxDynamicNpcs = 20 Auto Hidden
Int Property SexHitsPlayer = 1 Auto Hidden
Int Property SexHitsFollower = 1 Auto Hidden
Int Property SexHitsNpc = 2 Auto Hidden
Int Property CombatDamageThreshold = 4 Auto Hidden

Float Property StartingAlpha = 0.5 Auto Hidden
Float Property MaxAlpha = 0.85 Auto Hidden
Float Property HoursToMaxAlpha = 4.0 Auto Hidden
Float Property HoursToFadeOut = 48.0 Auto Hidden
Float Property RemoveTraumaAlpha = 0.20 Auto Hidden
Float Property SexChancePlayer = 33.0 Auto Hidden
Float Property SexChanceFollower = 50.0 Auto Hidden
Float Property SexChanceNpc = 75.0 Auto Hidden
Float Property CombatChancePlayer = 25.0 Auto Hidden
Float Property CombatChanceFollower = 10.0 Auto Hidden
Float Property CombatChanceNpc = 25.0 Auto Hidden
Float Property PushChance = 33.0 Auto Hidden

Quest Property _SLS_TraumaDynamicQuest Auto
Quest Property _SLS_TraumaAssignedQuest Auto
Quest Property _SLS_TraumaDynamicCombatQuest Auto

Actor Property PlayerRef Auto

Faction Property PotentialFollowerFaction Auto
Faction Property _SLS_TraumaFaction Auto

Weapon Property Unarmed Auto

SLS_Utility Property Util Auto
SexlabFramework Property Sexlab Auto
