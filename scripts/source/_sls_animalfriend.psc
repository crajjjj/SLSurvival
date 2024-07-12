Scriptname _SLS_AnimalFriend extends Quest

Event OnInit()
	If Self.IsRunning()
		RegInitEvents()
	EndIf
EndEvent
;/
Function AddCustomRaceFactions()
	Int i = 0
	While i < JsonUtil.FormListCount("SL Survival/CreatureTiers.json", "factions")
		_SLS_AnimalFriendCheckedFactions.AddForm(JsonUtil.FormListGet("SL Survival/CreatureTiers.json", "factions", i))
		i += 1
	EndWhile
Endfunction
/;
Function PlayerLoadsGame()
	CheckRaceDoorFlags()
EndFunction

Function RegInitEvents()
	RegisterForModEvent("_SLS_PlayerCombatChange", "On_SLS_PlayerCombatChange")
	RegisterForModEvent("HookAnimationStarting", "OnAnimationStarting")
EndFunction

Function SleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
	SleepBeginTime = afSleepStartTime
EndFunction

Function SleepStop(bool abInterrupted)
	;Debug.Messagebox("Sleep stop\nTime: " + ((Utility.GetCurrentGameTime() - SleepBeginTime) * 24.0))
	Utility.Wait(1.0)
	If (Utility.GetCurrentGameTime() - SleepBeginTime) * 24.0 >= 6.0
	;	Debug.Messagebox("reset bleedout")
		ResetAllBleedoutCounts()
	;Else
	;	Debug.Messagebox("Nope")
	EndIf
EndFunction

Event On_SLS_PlayerCombatChange(Bool InCombat)
	;Debug.Messagebox("Combat: " + InCombat)
	If InCombat
		_SLS_CreatureFleeAliases.Stop()
		_SLS_CreatureFleeAliases.Start()
	Else
		Withdraw(ForceStop = true)
	EndIf
EndEvent

; ================================================================================

Bool Function IsFriendSexAnim(Int tid, Bool HasPlayer)
	If HasPlayer && HasAnimFriend(tid)
		Return true
	EndIf
	Return false
EndFunction

Bool Function HasAnimFriend(Int tid)
	Actor[] SexActors = SexLab.HookActors(tid as string)
	Int i = 0
	While i < SexActors.Length
		If SexActors[i].IsInFaction(_SLS_AnimalFriendFaction)
			Return true
		EndIf
		i += 1
	EndWhile
	Return false
Endfunction

Event OnAnimationStarting(int tid, bool HasPlayer)
	If IsFriendSexAnim(tid, HasPlayer)
		RegForEvents()
	EndIf
EndEvent

Event OnOrgasmStart(int tid, bool HasPlayer)
	OrgasmEvent(ActorRef = None, tid = tid, HasPlayer = HasPlayer)
EndEvent

Event OnSexLabOrgasmSeparate(Form ActorRef, Int tid)
	OrgasmEvent(ActorRef = ActorRef as Actor, tid = tid, HasPlayer = Sexlab.FindPlayerController() == tid)
EndEvent

Event On_SLS_PlayerSwallowedCum(Form akSource, Bool Swallowed, Float LoadSize, Float LoadSizeBase, Bool IsCumPotion)
	If Swallowed && !IsCumPotion && akSource as Actor
		StorageUtil.SetIntValue(akSource, "_SLS_PlayerDrankCumTemp", 1)
	EndIf
EndEvent

Function OrgasmEvent(Actor ActorRef = None, Int tid, Bool HasPlayer)
	;Debug.Messagebox("Orgasm\nActorRef: " + ActorRef)
	If HasPlayer && ActorRef != PlayerRef
		If !Init.SlsoInstalled ; SLSO not installed
			ReferenceAlias AliasSelect
			Actor[] SexActors = SexLab.HookActors(tid as string)
			Int i = 0
			While i < SexActors.Length
				If SexActors[i] != PlayerRef
					StorageUtil.SetIntValue(ActorRef, "_SLS_PlayerMadeOrgasmTemp", 1)
				EndIf
				i += 1
			EndWhile
		Else
			;If ActorRef.IsInFaction(_SLS_AnimalFriendFaction)
				StorageUtil.SetIntValue(ActorRef, "_SLS_PlayerMadeOrgasmTemp", 1)
			;EndIf
		EndIf		
	EndIf
EndFunction

Event OnAnimationEnd(int tid, bool HasPlayer)
	If HasPlayer
		UnRegisterForModEvent("HookAnimationEnd")
		UnRegisterForModEvent("_SLS_PlayerSwallowedCum")
		UnRegisterForModEvent("SexLabOrgasmSeparate")
		UnRegisterForModEvent("HookOrgasmStart")
		SexEnd(tid)
	EndIf
EndEvent

Function SexEnd(Int tid)
	ReferenceAlias AliasSelect
	Actor[] SexActors = SexLab.HookActors(tid as string)
	Int i = 0
	While i < SexActors.Length
		If SexActors[i].IsInFaction(_SLS_AnimalFriendFaction) && StorageUtil.GetIntValue(SexActors[i], "_SLS_PlayerMadeOrgasmTemp", Missing = -1) == 1
			AliasSelect = GetAliasRef(SexActors[i])
			If AliasSelect
				(AliasSelect as _SLS_AnimalFriendAlias).SetUpdate(GetNextBreedingSession(SexActors[i]))
			EndIf
			StorageUtil.UnSetIntValue(SexActors[i], "_SLS_PlayerMadeOrgasmTemp")
		EndIf
		i += 1
	EndWhile
Endfunction

State TamingSex
	Event OnBeginState()
		RegForEvents()
	EndEvent
	
	Function SexEnd(Int tid)
		Actor[] SexActors = SexLab.HookActors(tid as string)
		Int i = 0
		While i < SexActors.Length
			If StorageUtil.GetIntValue(SexActors[i], "_SLS_PlayerMadeOrgasmTemp", Missing = -1) == 1
				TameCreature(SexActors[i])
				StorageUtil.UnSetIntValue(SexActors[i], "_SLS_PlayerMadeOrgasmTemp")
			EndIf
			i += 1
		EndWhile
		GoToState("")
	Endfunction
EndState

Function TameCreature(Actor akActor)
	If !akActor.IsInFaction(_SLS_AnimalFriendFaction)
		ReferenceAlias AliasSelect = GetAliasRef(akActor)
		If AliasSelect != None
			Float AllureCost = GetAllureCost(akActor)
			Debug.Notification("I've made a new friend (Allure -" + (AllureCost as Int) + ")")
			Wildling.AllureSpent += AllureCost
			akActor.AddToFaction(_SLS_AnimalFriendFaction)
			AliasSelect.ForceRefTo(akActor)
			ObjectReference HomeMarker = GetHomeMarker(akActor)
			HomeMarker.MoveTo(akActor)
			;(AliasSelect as _SLS_AnimalFriendAlias).SetupFriend()
			;akActor.SetNoBleedoutRecovery(true)
			akActor.SetNotShowOnStealthMeter(true)
			FriendizeActor(akActor)
			UnFleeCreature(akActor)
			;akActor.EvaluatePackage()
			Utility.Wait(3.0) ; Wait for cum effects to be applied, Gems to be added, Cum to be added to holes etc
			(AliasSelect as _SLS_AnimalFriendAlias).SetUpdate(GetNextBreedingSession(akActor))
		EndIf
	Else
		Debug.Trace("_SLS_: TameCreature(): Creature is already tamed: " + akActor)
	EndIf
Endfunction

Function RegForEvents()
	RegisterForModEvent("HookAnimationEnd", "OnAnimationEnd")
	RegisterForModEvent("_SLS_PlayerSwallowedCum", "On_SLS_PlayerSwallowedCum")
	If Game.GetModByName("SLSO.esp") != 255
		RegisterForModEvent("SexLabOrgasmSeparate", "OnSexLabOrgasmSeparate")
	Else
		RegisterForModEvent("HookOrgasmStart", "OnOrgasmStart")
	EndIf
EndFunction

Function FondleStart(Actor akSpeaker)
	GoToState("TamingSex")
	DoSound(akSpeaker, "Neigh")
EndFunction

ReferenceAlias Function GetAliasRef(Actor ActorRef)
	Int i = 0
	ReferenceAlias FreeAlias
	ReferenceAlias AliasSelect
	Bool FoundFreeAlias = false
	While i < _SLS_AnimalFriendAliases.GetNumAliases()
		AliasSelect = _SLS_AnimalFriendAliases.GetNthAlias(i) as ReferenceAlias
		If AliasSelect.GetReference() as Actor == ActorRef
			Return AliasSelect
		ElseIf AliasSelect.GetReference() == None
			FoundFreeAlias = true
			FreeAlias = AliasSelect
		EndIf
		i += 1
	EndWhile
	If FoundFreeAlias
		Return FreeAlias
	Else
		Debug.Notification("No free animal friend slots remaining")
	EndIf
	Return None
EndFunction

Int Function GetAliasIndex(Actor ActorRef)
	Int i = 0
	ReferenceAlias AliasSelect
	Bool FoundFreeAlias = false
	While i < _SLS_AnimalFriendAliases.GetNumAliases()
		AliasSelect = _SLS_AnimalFriendAliases.GetNthAlias(i) as ReferenceAlias
		If AliasSelect.GetReference() as Actor == ActorRef
			Return i
		EndIf
		i += 1
	EndWhile
	Return -1
EndFunction

ObjectReference Function GetHomeMarker(Actor Friend)
	Int AliasIndex = GetAliasIndex(Friend)
	If AliasIndex == 0
		Return _SLS_AnimalFriendHomeMarkerOne
	EndIf
EndFunction

Function DismissFriend(Actor akSpeaker, Bool MoveHome = false)
	_SLS_AnimalFriendFgQuest.Stop()
	DoSound(akSpeaker, "Agitated")
	ReferenceAlias AliasSelect = GetAliasRef(akSpeaker)
	ObjectReference HomeMarker = GetHomeMarker(akSpeaker)
	If AliasSelect.GetReference() != None
		;akSpeaker.SetNoBleedoutRecovery(false)
		akSpeaker.SetNotShowOnStealthMeter(false)
		AliasSelect.Clear()
		akSpeaker.RemoveFromFaction(_SLS_AnimalFriendFaction)
		akSpeaker.EvaluatePackage()
		If MoveHome
			ObjectReference LinkedRef = akSpeaker.GetLinkedRef()
			If LinkedRef
				akSpeaker.MoveTo(LinkedRef)
			Else
				akSpeaker.MoveTo(HomeMarker)
			EndIf
		EndIf
		Float AllureCost = GetAllureCost(akSpeaker)
		Wildling.AllureSpent -= AllureCost
		RestoreAiData(akSpeaker)
		Util.SlacExclude(akSpeaker, Exclude = false)
		StorageUtil.FormListRemove(None, "_SLS_AnimalFriendsList", akSpeaker)
	Else
		Debug.Trace("_SLS_: DismissFriend: Actor not found in aliases: " + akSpeaker)
	EndIf
EndFunction

Bool Function BeginHornyFg(Actor HornyFriend)
	If !ApproachingFriend && !PlayerRef.IsInFaction(SexlabAnimatingFaction)
		ApproachingFriend = HornyFriend
		HornyFriend.SetFactionRank(_SLS_AnimalFriendFgFact, StorageUtil.GetIntValue(HornyFriend, "_SLS_AnimalFriendApproachCount", missing = 0))
		Util.SetupCreatureSex(HornyFriend)
		DoSound(HornyFriend, "Agitated")
		;_SLS_AnimalFriendApproachCount.SetValueInt(StorageUtil.GetIntValue(HornyFriend, "_SLS_AnimalFriendApproachCount", missing = 0))
		_SLS_AnimalFriendFgQuest.Start()
		(_SLS_AnimalFriendFgQuest.GetNthAlias(0) as ReferenceAlias).ForceRefTo(HornyFriend)
		HornyFriend.EvaluatePackage()
		Return true
	EndIf
	Return false
EndFunction

Function PostponeAnimalFriendSex(Actor HornyFriend)
	_SLS_AnimalFriendFgQuest.Stop()
	HornyFriend.RemoveFromFaction(_SLS_AnimalFriendFgFact)
	ApproachingFriend = None
	DoSound(HornyFriend, "Agitated")
	StorageUtil.AdjustIntValue(HornyFriend, "_SLS_AnimalFriendApproachCount", 1)
	ReferenceAlias AliasSelect = GetAliasRef(HornyFriend)
	If AliasSelect.GetReference() != None
		(AliasSelect as _SLS_AnimalFriendAlias).SetUpdate(0.5)
	Else
		Debug.Trace("_SLS_: PostponeAnimalFriendSex: Got None alias for: " + HornyFriend)
	EndIf
EndFunction

Function WalkAway(Actor akSpeaker)
	_SLS_AnimalFriendFgQuest.Stop()
	akSpeaker.RemoveFromFaction(_SLS_AnimalFriendFgFact)
	ApproachingFriend = None
	DoSound(akSpeaker, "Agitated")
	If StorageUtil.GetIntValue(akSpeaker, "_SLS_AnimalFriendApproachCount", Missing = 0) <= 1
		PostponeAnimalFriendSex(akSpeaker)
	Else
		String Name = akSpeaker.GetDisplayName()
		If !Name
			Name = akSpeaker.GetLeveledActorBase().GetName()
		EndIf
		Debug.Notification("<font color='#CC0000'>" + Name + " has become bored and is going home (Allure +" + (GetAllureCost(akSpeaker) as Int) + ")</font>")
		DismissFriend(akSpeaker, MoveHome = false)
		If Utility.RandomFloat(0.0, 100.0) > 50.0 ; rape that dismissive bitch
			
			AnimalFriendSex(akSpeaker, GetRandomSexType(), Victim = PlayerRef)
			
			Utility.Wait(5.0)
			Debug.Notification("Fed up with my cock teasing, " + akSpeaker.GetDisplayName() + " mounts me aggressively")
		EndIf
	EndIf
EndFunction

Function AnimalFriendSex(Actor AnimalFriend, String SexType, Actor Victim = None)
	_SLS_AnimalFriendFgQuest.Stop()
	AnimalFriend.RemoveFromFaction(_SLS_AnimalFriendFgFact)
	ApproachingFriend = None
	DoSound(AnimalFriend, "Neigh")
	sslBaseAnimation[] Animations = Sexlab.GetCreatureAnimationsByRaceTags(2, AnimalFriend.GetRace(), SexType, TagSuppress = "", RequireAll = true)
	
	If SexType == "Blowjob" && Animations.Length == 0 ; Stupid tags
		Animations = Sexlab.GetCreatureAnimationsByRaceTags(2, AnimalFriend.GetRace(), "Oral", TagSuppress = "", RequireAll = true)
	EndIf
	
	If Animations.Length > 0
		;StorageUtil.SetFloatValue(AnimalFriend, "SLAroused.ActorExposure", 100.0)
		If !Victim ; Don't track if event is breeding session postponement dismissal
			Util.FondleArousalIncrease(AnimalFriend, IncFondleCount = true)
			;GoToState("TamingSex")
		EndIf
		actor[] sexActors =  new actor[2]
		SexActors[0] = PlayerRef
		SexActors[1] = AnimalFriend
		Sexlab.StartSex(sexActors, animations, Victim)
		Utility.Wait(0.5)
		AnimalFriend.MoveTo(PlayerRef)
	Else
		Debug.Trace("_SLS_: AnimalFriendSex: No animations found for race: " + AnimalFriend.GetRace() + " of type: " + SexType)
	EndIf
EndFunction

Float Function GetNextBreedingSession(Actor akActor)
	Float HoursToNextBreeding = BreedingCooloffBase
	Float CoveredInCum = Sexlab.CountCum(PlayerRef) / 6.0
	HoursToNextBreeding += CoveredInCum * BreedingCooloffCumCovered
	Float Pregnancy = 0.0
	If Game.GetModByName("dcc-soulgem-oven-000.esm") != 255
		Float GemCount = Sgo.ActorGemGetCount(PlayerRef) as Float
		Float GemsMax = Sgo.GetGemCapacityMax() as Float
		Pregnancy = GemCount / GemsMax
		;Debug.Messagebox("GemCount: " + GemCount + "\nGemsMax: " + GemsMax)
		
	ElseIf Game.GetModByName("BeeingFemale.esm") != 255
		Int BfPreg = StorageUtil.GetIntValue(PlayerRef, "FW.CurrentState")
		If BfPreg >= 4 && BfPreg <= 6
			Pregnancy = 1.0
		EndIf
		
	ElseIf Game.GetModByName("Fertility Mode.esm") != 255
		If Fm.GetIsPregnant(PlayerRef)
			Pregnancy = 1.0
		EndIf
	EndIf
	HoursToNextBreeding += Pregnancy * BreedingCooloffPregnancy

	Float CumFilled = Util.GetCumStuffedFactor(PlayerRef)
	;/
	If Game.GetModByName("sr_FillHerUp.esp") != 255
		Float CumTotal = StorageUtil.GetFloatValue(PlayerRef, "sr.inflater.cum.anal", missing = 0.0) + StorageUtil.GetFloatValue(PlayerRef, "sr.inflater.cum.vaginal", missing = 0.0)
		Float CumMax = 1.0 ; Simple check that FHU is actually working first
		If CumTotal != 0.0
			CumMax = Fhu.GetCumCapacityMax()
		EndIf
		CumFilled = CumTotal / (CumMax * 2.0)
		If CumFilled > 1.0
			CumFilled = 1.0
		EndIf		
	EndIf
	/;
	HoursToNextBreeding += CumFilled * BreedingCooloffCumFilled

	Bool DidSwallow = StorageUtil.GetIntValue(akActor, "_SLS_PlayerDrankCumTemp", Missing = -1) == 1
	If DidSwallow
		HoursToNextBreeding += SwallowBonus
		StorageUtil.UnSetIntValue(akActor, "_SLS_PlayerDrankCumTemp")
	EndIf

	;Debug.Messagebox("HoursToNextBreeding: " + HoursToNextBreeding + "\nCoveredInCum: " + CoveredInCum + "\nPregnancy: " + Pregnancy + "\nCumFilled: " + CumFilled + ". Swallowed: " + DidSwallow + " - " + SwallowBonus)
	Debug.Trace("_SLS_: HoursToNextBreeding: " + HoursToNextBreeding + ". CoveredInCum: " + CoveredInCum + ". Pregnancy: " + Pregnancy + ". CumFilled: " + CumFilled + ". Swallowed: " + DidSwallow + " - " + SwallowBonus)
	Return HoursToNextBreeding
EndFunction

Function DoSound(Actor akSpeaker, String SoundType)
	If akSpeaker.Is3dLoaded()
		VoiceType Voice = akSpeaker.GetVoiceType()
		If Voice == CrHorseVoice
			If SoundType == "Sniffs"
				_SLS_HorseSniffs.Play(akSpeaker)
			ElseIf SoundType == "Neigh"
				_SLS_HorseNeigh.Play(akSpeaker)
			ElseIf SoundType == "Agitated"
				_SLS_HorseAgitated.Play(akSpeaker)
			EndIf
		EndIf
	EndIf
EndFunction

String Function GetRandomSexType()
	Float RanFloat = Utility.RandomFloat(0.0, 100.0)
	If RanFloat < 33.0
		Return "Blowjob"
	ElseIf RanFloat < 66.0
		Return "Vaginal"
	Else
		Return "Anal"
	EndIf
EndFunction

Function DisplayStats(Actor akTarget)
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	ListMenu.AddEntryItem("Health: " + (akTarget.GetAv("Health") as Int))
	ListMenu.AddEntryItem("Stamina: " + (akTarget.GetAv("Stamina") as Int))
	ListMenu.AddEntryItem("Unarmed Damage: " + akTarget.GetAv("UnarmedDamage"))
	Weapon akWeapon =  akTarget.GetEquippedWeapon(abLeftHand = false)
	If akWeapon
		ListMenu.AddEntryItem(akWeapon.GetName() + " Damage: " + akWeapon.GetBaseDamage())
	EndIf
	
	ListMenu.AddEntryItem("Damage Resist: " + (akTarget.GetAv("DamageResist") as Int))
	ListMenu.AddEntryItem("Arousal: " + akTarget.GetFactionRank(Game.GetFormFromFile(0x03FC36, "SexLabAroused.esm") as Faction) + "%")
	ListMenu.AddEntryItem("Cum Fullness: " + (Util.GetLoadFullnessMod(akTarget) as Int) + "%")
	ListMenu.OpenMenu(akTarget)
	;Return ListMenu.GetResultInt()
EndFunction

Function WaitFollow(Actor akTarget)
	If akTarget.IsInFaction(_SLS_AnimalFriendWaitFact)
		akTarget.RemoveFromFaction(_SLS_AnimalFriendWaitFact)
		akTarget.EvaluatePackage()
	Else
		akTarget.AddToFaction(_SLS_AnimalFriendWaitFact)
		akTarget.EvaluatePackage()
	EndIf
EndFunction

Function SetMemberName(Actor akTarget)
	UITextEntryMenu TextMenu = UIExtensions.GetMenu("UITextEntryMenu") as UITextEntryMenu
	TextMenu.SetPropertyString("text", akTarget.GetLeveledActorBase().GetName())
	TextMenu.OpenMenu(PlayerRef)
	;MainName = TextMenu.GetResultString()
	
	String Name = TextMenu.GetResultString()
	If Name != ""
		akTarget.SetDisplayName(Name)
	EndIf
EndFunction

Function ToggleFighting(Actor akTarget)
	If akTarget.IsInFaction(_SLS_AnimalFriendAvoidCombatFact)
		akTarget.RemoveFromFaction(_SLS_AnimalFriendAvoidCombatFact)
	Else
		akTarget.AddToFaction(_SLS_AnimalFriendAvoidCombatFact)
	EndIf
	akTarget.EvaluatePackage()
EndFunction

Function AttemptTame(Actor akTarget, Bool DebugTame = false)
	VoiceType akVoice = akTarget.GetVoiceType()
	ActorBase akBase = akTarget.GetLeveledActorBase()
	Int Index = JsonUtil.FormListFind("SL Survival/CreatureTiers.json", "creatures", akVoice)
	;Debug.Messagebox("Index: " + Index)
	If Index > -1 && !akBase.IsUnique()
		Float CreatureTier = JsonUtil.FloatListGet("SL Survival/CreatureTiers.json", "tiers", Index)
		;debug.Messagebox("CreatureTier: " + CreatureTier)
		If Wildling._SLS_WildlingLevel.GetValue() >= CreatureTier
			If (Wildling.AllurePool - Wildling.AllureSpent) - CreatureTier > -1
				If DebugTame
					TameCreature(akTarget)
				Else
					Debug.Notification(akBase.GetName() + " cautiously accepts my approach")
					GoToState("TamingSex")
					Util.DoCreatureSex(Receiver = PlayerRef, akSpeaker = akTarget, SexType = GetRandomSexType(), Victim = None, IsCreatureFondle = true, DoTeleport = false)
				EndIf
			Else
				Debug.Notification("I don't have enough allure to tame " + akBase.GetName() + " (" + ((Wildling.AllurePool - Wildling.AllureSpent) as Int) + ")")
			EndIf
		Else
			Debug.Notification(akBase.GetName() + " is to fiercesome for me to tame")
		EndIf
	Else
		Debug.Notification(akBase.GetName() + " rejects all of my attempts to tame him (not tameable)")
		Debug.Trace("_SLS_: AttemptTame(): Fail to find creature voice in json. akTarget: " + akTarget + ". Voice: " + akVoice)
	EndIf
Endfunction

Float Function GetAllureCost(Actor akTarget)
	Return JsonUtil.FloatListGet("SL Survival/CreatureTiers.json", "tiers", JsonUtil.FormListFind("SL Survival/CreatureTiers.json", "creatures", akTarget.GetVoiceType()))
EndFunction

Function UnFleeCreature(Actor akActor)
	akActor.RemoveFromFaction(_SLS_TameableCreatureFact)
	Int i = 0
	While i < _SLS_CreatureFleeAliases.GetNumAliases()
		If (_SLS_CreatureFleeAliases.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor == akActor
			(_SLS_CreatureFleeAliases.GetNthAlias(i) as ReferenceAlias).Clear()
		EndIf
		i += 1
	EndWhile
	akActor.ClearLookAt()
	akActor.EvaluatePackage()
EndFunction

Function FriendizeActor(Actor akActor)
	While StorageUtil.FormListFind(Self, "InProcFriends", akActor) > -1
		Utility.Wait(3.0)
	EndWhile
	StorageUtil.FormListAdd(Self, "InProcFriends", akActor, AllowDuplicate = false)
	
	StorageUtil.FormListAdd(None, "_SLS_AnimalFriendsList", akActor, AllowDuplicate = false)
	
	; Can't open doors
	Race akRace = akActor.GetRace()
	If GetFriendsOfSameRaceCount(akActor) == 1 && akRace.IsRaceFlagSet(0x00100000) ; kRace_CantOpenDoors
		StorageUtil.FormListAdd(Self, "_SLS_AnimalFriendVarsCantOpenDoors", akRace, AllowDuplicate = false)
		akActor.GetRace().ClearRaceFlag(0x00100000) ; kRace_CantOpenDoors
	EndIf

	; Aggression & confidence
	StorageUtil.SetFloatValue(akActor, "_SLS_AnimalFriendVarsAggression", akActor.GetAV("Aggression"))
	StorageUtil.SetFloatValue(akActor, "_SLS_AnimalFriendVarsConfidence", akActor.GetAV("Confidence"))
	akActor.SetAV("Aggression", 1)
	akActor.SetAV("Confidence", 3)
	
	; Factions
	CheckFactions(akActor)	
	
	akActor.RestoreAv("Health", 999999.0)
	
	akActor.StopCombatAlarm()
	akActor.Stopcombat()

	;akActor.SetPlayerTeammate(true) ; Actor doesn't seem to re-follow after being told to wait!!
	akActor.EvaluatePackage()
	
	Util.SlacExclude(akActor, Exclude = true)
	
	StorageUtil.FormListRemove(Self, "InProcFriends", akActor)
EndFunction

Function CheckFactions(Actor akActor)
	Faction akFaction
	Int Rank
	Int i
	While i < _SLS_AnimalFriendCheckedFactions.GetSize()
		akFaction = _SLS_AnimalFriendCheckedFactions.GetAt(i) as Faction
		If akActor.GetFactionRank(akFaction) >= 0
			ClearAndSaveFaction(akActor, akFaction)
		EndIf
		i += 1
	EndWhile
	
	Int j = 0
	String ModName
	While j < JsonUtil.StringListCount("SL Survival/CreatureTiers.json", "factionmods") ; For every faction mod
		ModName = JsonUtil.StringListGet("SL Survival/CreatureTiers.json", "factionmods", j)
		If Game.GetModByName(ModName) != 255
			i = 0
			While i < JsonUtil.FormListCount("SL Survival/CreatureTiers.json", ModName) ; For every faction of that mod
				ClearAndSaveFaction(akActor, JsonUtil.FormListGet("SL Survival/CreatureTiers.json", ModName, i) as Faction)
				i += 1
			EndWhile
		EndIf
		j += 1
	EndWhile
EndFunction

Function ClearAndSaveFaction(Actor akActor, Faction akFaction)
	If akActor && akFaction && StorageUtil.FormListFind(akActor, "_SLS_AnimalFriendFactions", akFaction) == -1
		StorageUtil.FormListAdd(akActor, "_SLS_AnimalFriendFactions", akFaction)
		StorageUtil.IntListAdd(akActor, "_SLS_AnimalFriendFactionRanks", akActor.GetFactionRank(akFaction))
		akActor.RemoveFromFaction(akFaction)
	EndIf
EndFunction

Function RecheckAnimalFriendFactions(Actor akActor)
	If akActor && akActor.IsInFaction(_SLS_AnimalFriendFaction)
		CheckFactions(akActor)
		Debug.Notification(akActor.GetDisplayName() + ": Faction recheck complete")
	Else
		Debug.Notification("Not a valid target: " + akActor)
	EndIf
EndFunction

Function RestoreAiData(Actor akActor)
	While StorageUtil.FormListFind(Self, "InProcFriends", akActor) > -1
		Utility.Wait(3.0)
	EndWhile
	StorageUtil.FormListAdd(Self, "InProcFriends", akActor, AllowDuplicate = false)
	
	; Can't open doors
	Race akRace = akActor.GetRace()
	If GetFriendsOfSameRaceCount(akActor) == 1 && StorageUtil.FormListFind(Self, "_SLS_AnimalFriendVarsCantOpenDoors", akRace) > -1 ; Last friend of that race and flag was cleared
		akRace.SetRaceFlag(0x00100000)
		StorageUtil.FormListRemove(Self, "_SLS_AnimalFriendVarsCantOpenDoors", akRace)
	EndIf
	
	; Aggression & confidence
	akActor.SetAV("Aggression", StorageUtil.GetFloatValue(akActor, "_SLS_AnimalFriendVarsAggression", Missing = 1))
	akActor.SetAV("Confidence", StorageUtil.GetFloatValue(akActor, "_SLS_AnimalFriendVarsConfidence", Missing = 3))
	
	; Factions
	Faction akFaction
	Int Rank
	While StorageUtil.FormListCount(akActor, "_SLS_AnimalFriendFactions") > 0
		akFaction = StorageUtil.FormListPop(akActor, "_SLS_AnimalFriendFactions") as Faction
		Rank = StorageUtil.IntListPop(akActor, "_SLS_AnimalFriendFactionRanks")
		akActor.SetFactionRank(akFaction, Rank)
	EndWhile
	
	StorageUtil.UnSetIntValue(akActor, "_SLS_AnimalFriendVarsCantOpenDoors")
	StorageUtil.UnSetFloatValue(akActor, "_SLS_AnimalFriendVarsAggression")
	StorageUtil.UnSetFloatValue(akActor, "_SLS_AnimalFriendVarsConfidence")
	StorageUtil.FormListClear(akActor, "_SLS_AnimalFriendFactions")
	StorageUtil.FormListClear(akActor, "_SLS_AnimalFriendFactionRanks")
	
	StorageUtil.FormListRemove(Self, "InProcFriends", akActor)
EndFunction

Form[] Function GetFriendsOfSameRace(Actor akActor, Bool IncludeSource = false)
	; IncludeSource = Include akActor in returned array
	Race akRace = akActor.GetRace()
	Actor akFriend
	Int Count
	Int i = 0
	While i < _SLS_AnimalFriendAliases.GetNumAliases()
		akFriend = (_SLS_AnimalFriendAliases.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
		If akFriend && akFriend.GetRace() == akRace && (IncludeSource || akFriend != akActor)
			StorageUtil.FormListAdd(Self, "_SLS_FriendsOfSameRaceList", akFriend, AllowDuplicate = false)
		EndIf
		i += 1
	EndWhile
	Form[] Result = StorageUtil.FormListToArray(Self, "_SLS_FriendsOfSameRaceList")
	StorageUtil.FormListClear(Self, "_SLS_FriendsOfSameRaceList")
	Return Result
Endfunction

Int Function GetFriendsOfSameRaceCount(Actor akActor, Bool IncludeSource = false)
	; IncludeSource = Count akActor in returned count
	Race akRace = akActor.GetRace()
	Actor akFriend
	Int Count
	Int i = 0
	While i < _SLS_AnimalFriendAliases.GetNumAliases()
		akFriend = (_SLS_AnimalFriendAliases.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
		If akFriend && akFriend.GetRace() == akRace && (IncludeSource || akFriend != akActor)
			Count += 1	
		EndIf
		i += 1
	EndWhile
	Return Count
EndFunction

Bool Function FriendDeath(Actor akActor, Actor akKiller, Bool ForceKill = false)
	If StorageUtil.GetFloatValue(akActor, "_SLS_AnimalFriendBleedoutCount", Missing  = 0.0) > 3.0 || ForceKill
		If akKiller
			Debug.Notification("<font color='#CC0000'>" + akActor.GetDisplayName() + " was killed by " + akKiller.GetDisplayName() + " (Allure +" + (GetAllureCost(akActor) as Int) + ")</font>")
		Else
			Debug.Notification("<font color='#CC0000'>" + akActor.GetDisplayName() + " died" + " (Allure +" + (GetAllureCost(akActor) as Int) + ")</font>")
		EndIf
		DismissFriend(akActor)
		Return true
		
	Else
		akActor.AddToFaction(_SLS_AnimalFriendKnockedOut)
		If akKiller
			Debug.Notification("<font color='#FF8000'>" + akActor.GetDisplayName() + " was downed by " + akKiller.GetDisplayName() + "</font>")
		Else
			Debug.Notification("<font color='#FF8000'>" + akActor.GetDisplayName() + " was downed</font>")
		EndIf
		BeginBleedout(akActor)
		Return false
	EndIf
	;akActor.BlockActivation(true)
EndFunction

Event EnterBleedout(Actor akActor)
	;/ Works ok but actors in bleedout block pathing badly
	;akActor.SetNoBleedoutRecovery(true)
	;akActor.AddSpell(_SLS_AnimalFriendBleedoutSpell)
	akActor.SetUnconscious(true)
	PlayerRef.PushActorAway(akActor, 2.0)
	;_SLS_AnimalFriendBleedoutSpell.Cast(akActor, akActor)
	
	Utility.Wait(1.0)
	akActor.ModActorValue("Paralysis", 1)
	akActor.AddToFaction(dunPrisonerFaction)
	akActor.AddToFaction(_SLS_AnimalFriendKnockedOut)
	akActor.SetMotionType(4, true)
	akActor.TranslateTo(akActor.GetPositionX(), akActor.GetPositionY(), akActor.GetPositionZ(), akActor.GetAngleX(), akActor.GetAngleY(), akActor.GetAngleZ(), 1.0)
	/;
EndEvent

Function BeginBleedout(Actor akActor)
	Int AliasIndex = GetAliasIndex(akActor)
	If AliasIndex > -1
		((_SLS_AnimalFriendBleedoutAliases.GetNthAlias(AliasIndex) as ReferenceAlias) as _SLS_AnimalFriendBleedout).BeginBleedout(akActor)
	Else
		Debug.Trace("_SLS_: BeginBleedout(): Could not get alias index for " + akActor)
	EndIf
EndFunction

Function BleedoutExpire(Actor akActor)
	FriendDeath(akActor, None, ForceKill = true)
EndFunction

Function Revive(Actor akActor)
	_SLS_AnimalFriendClosestEnemy.Stop()
	_SLS_AnimalFriendClosestEnemy.Start()
	Utility.Wait(0.1)
	Actor akEnemy = (_SLS_AnimalFriendClosestEnemy.GetNthAlias(0) as ReferenceAlias).GetReference() as Actor
	If PlayerRef.IsInCombat()
		Debug.Notification("I can't do that while fighting")
	ElseIf akEnemy && akEnemy.GetDistance(PlayerRef) <= 1024.0
		Debug.Notification("The enemy is too close to try that now")
	Else
		
		akActor.RemoveFromFaction(_SLS_AnimalFriendKnockedOut)
		akActor.Resurrect()
		ReferenceAlias AliasSelect = GetAliasRef(akActor)
		(AliasSelect as _SLS_AnimalFriendAlias).SetUpdate(GetNextBreedingSession(akActor))
		
		Int AliasIndex = GetAliasIndex(akActor)
		((_SLS_AnimalFriendBleedoutAliases.GetNthAlias(AliasIndex) as ReferenceAlias) as _SLS_AnimalFriendBleedout).Revive(akActor)
		;/
		akActor.RemoveFromFaction(dunPrisonerFaction)
		akActor.ForceActorValue("Paralysis", 0)
		akActor.SetUnconscious(false)
		akActor.RestoreAv("Health", 5 - akActor.GetAv("Health"))
		/;
	EndIf
	Debug.Messagebox("Enemy: " + akEnemy + "\nDist: " + akEnemy.GetDistance(PlayerRef))
EndFunction

Function RefreshAllPackages()
	Actor akActor
	Int i = 0
	While i < _SLS_AnimalFriendAliases.GetNumAliases()
		akActor = (_SLS_AnimalFriendAliases.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
		If akActor
			akActor.EvaluatePackage()
		EndIf
		i += 1
	EndWhile
EndFunction

Function CheckRaceDoorFlags()
	Int i = 0
	Race akRace
	While i < StorageUtil.FormListCount(Self, "_SLS_AnimalFriendVarsCantOpenDoors")
		akRace = StorageUtil.FormListGet(Self, "_SLS_AnimalFriendVarsCantOpenDoors", i) as Race
		akRace.ClearRaceFlag(0x00100000) ; kRace_CantOpenDoors
		i += 1
	EndWhile
EndFunction

String Function GetWithdrawMenuString()
	If _SLS_AnimalFriendWithdrawAliases.IsRunning()
		Return "Engage "
	EndIf
	Return "Withdraw "
EndFunction

Function Withdraw(Bool ForceStop = false)
	If ForceStop || _SLS_AnimalFriendWithdrawAliases.IsRunning()
		_SLS_AnimalFriendWithdrawAliases.Stop()
	Else
		_SLS_AnimalFriendWithdrawAliases.Start()
	EndIf
	RefreshAllPackages()
EndFunction

Function GetBehindMe(Actor akActor)
	akActor.MoveTo(PlayerRef, 250.0 * Math.Sin(PlayerRef.GetAngleZ() + 180.0), 250.0 * Math.Cos(PlayerRef.GetAngleZ() + 180.0), PlayerRef.GetHeight())
EndFunction

Function Fondle(Actor akTarget)
	;Reset first in case it didn't terminate right last time
	(_SLS_CreatureForceGreet.GetNthAlias(0) as ReferenceAlias).Clear()
	_SLS_CreatureForceGreet.Stop()
	(akTarget as Actor).EvaluatePackage()

	Debug.Notification(akTarget.GetBaseObject().GetName() + " arousal level: " + (akTarget as Actor).GetFactionRank(Game.GetFormFromFile(0x03FC36, "SexLabAroused.esm") as Faction))

	; begin
	TalkingCreature.ForceRefTo(akTarget)
	_SLS_CreatureForceGreet.Start()
	ActorUtil.AddPackageOverride((akTarget as Actor), _SLS_CreatureForceGreetPackage, 100) ; For Untamed
	(akTarget as Actor).EvaluatePackage()
	Util.SetupCreatureSex(akTarget as Actor)
	Debug.Notification("Weighing them in your hands you guess his balls are " + Util.GetCumFullnessString(akTarget as Actor))

	; Remove papyrusutil package later just in case.
	Utility.Wait (0.5)
	ActorUtil.RemovePackageOverride((akTarget as Actor), _SLS_CreatureForceGreetPackage)
EndFunction

Function ResetAllBleedoutCounts()
	Int i = 0
	Actor akActor
	While i < _SLS_AnimalFriendAliases.GetNumAliases()
		akActor = (_SLS_AnimalFriendAliases.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
		If akActor
			StorageUtil.SetFloatValue(akActor, "_SLS_AnimalFriendBleedoutCount", 0)
		EndIf
		i += 1
	EndWhile
Endfunction
;/
Actor Function GetFollowingFriendWithMostCum()
	Int i = 0
	Actor akActor
	Actor FriendWithMostCum
	While i < _SLS_AnimalFriendAliases.GetNumAliases()
		If akActor && !akActor.IsInFaction(_SLS_AnimalFriendWaitFact) && !akActor.IsInFaction(_SLS_AnimalFriendKnockedOut)
			
		EndIf
		i += 1
	EndWhile
Endfunction
/;
; Menus ==================================================================================================

Function CreatureMainMenu(Actor akTarget)
	Int MenuResult = ShowCreatureMainMenu(akTarget)
	If MenuResult == 0 ;  More
		CreatureMoreMenu(akTarget)
	ElseIf MenuResult == 1 ; Fondle
		Fondle(akTarget)
	ElseIf MenuResult == 2 ; Wait/Follow
		WaitFollow(akTarget)
	ElseIf MenuResult == 3 ; Stats
		DisplayStats(akTarget)
	ElseIf MenuResult == 4 ; Ride
		akTarget.Activate(PlayerRef)
	ElseIf MenuResult == 5 ; Pack List
		ShowPackList()
	ElseIf MenuResult == 6 ; Log
		Wildling.DisplayLog()
	ElseIf MenuResult == 7 ; Get Behind
		GetBehindMe(akTarget)
	EndIf
EndFunction

Int Function ShowCreatureMainMenu(Actor akTarget)
	String WaitFollowStr = "Wait "
	If akTarget.IsInFaction(_SLS_AnimalFriendWaitFact)
		WaitFollowStr = "Follow "
	EndIf
	
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 0, value = "More ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 1, value = "Fondle ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 2, value = WaitFollowStr)
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 3, value = "Stats ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 4, value = "Ride ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 5, value = "Pack List")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 6, value = "Wildling Log")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 7, value = "Get Behind Me")

	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 0, value = "More ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 1, value = "Fondle ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 2, value = WaitFollowStr)
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 3, value = "Stats ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 4, value = "Ride ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 5, value = "Pack List")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 6, value = "Wildling Log")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 7, value = "Get Behind Me")
	
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 3, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 4, value = _SLS_MountableFriends.HasForm(akTarget.GetRace()))
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 5, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 6, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 7, value = true)
	
	Return wheelMenu.OpenMenu(akTarget)
EndFunction

Function CreatureMoreMenu(Actor akTarget)
	Int MenuResult = ShowCreatureMoreMenu(akTarget)
	If MenuResult == -1
		CreatureMainMenu(akTarget)
	ElseIf MenuResult == 0 ; Dismiss
		If AreYouSure(akTarget)
			DismissFriend(akTarget, MoveHome = false)
		EndIf
	ElseIf MenuResult == 1 ; Set Name
		SetMemberName(akTarget)
	ElseIf MenuResult == 2 ; Fight/Flight
		ToggleFighting(akTarget)
	ElseIf MenuResult == 3 ; Fuck Npc
		FuckNpcMenu(akTarget)
	ElseIf MenuResult == 4 ; Feed
		FeedMenu(akTarget)
	EndIf
EndFunction

Int Function ShowCreatureMoreMenu(Actor akTarget)
	String FightFlight = "Flee "
	If akTarget.IsInFaction(_SLS_AnimalFriendAvoidCombatFact)
		FightFlight = "Fight "
	EndIf
	
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 0, value = "Dismiss ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 1, value = "Set Name")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 2, value = FightFlight)
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 3, value = "Fuck Npc")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 4, value = "Feed ")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 0, value = "Dismiss ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 1, value = "Set Name")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 2, value = FightFlight)
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 3, value = "Fuck Npc")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 4, value = "Feed ")
	
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 3, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 4, value = true)
	
	Return wheelMenu.OpenMenu(akTarget)
EndFunction

Bool Function AreYouSure(Actor akTarget = None)
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 2, value = "Yes ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 6, value = "No ")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 2, value = "Yes ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 6, value = "No ")
	
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 6, value = true)

	Int Result = wheelMenu.OpenMenu(akTarget)
	If Result == 6
		Return false
	EndIf
	Return true
Endfunction

Function FeedMenu(Actor akTarget)
	Int MenuResult = ShowFeedMenu(akTarget)
	If MenuResult == - 1
		CreatureMoreMenu(akTarget)
	ElseIf MenuResult == 0
		FeedFood(akTarget)
	ElseIf MenuResult == 1
		BreastFeedMenu(akTarget)
	EndIf
EndFunction

Int Function ShowFeedMenu(Actor akTarget)
	Bool CanBreastFeed = StorageUtil.GetFloatValue(PlayerRef, "MME.MilkMaid.MilkCount", Missing = -1.0) != -1.0
	
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 0, value = "Feed Food")

	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 0, value = "Feed Food")

	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 0, value = true)
	
	If CanBreastFeed
		wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 1, value = "Breastfeed ")
		wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 1, value = "Breastfeed ")
		wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 1, value = true)
	EndIf
	
	Return wheelMenu.OpenMenu(akTarget)
EndFunction

Function FeedFood(Actor akTarget)
	_SLS_AnimalFriendFeedQuest.Start()
	(_SLS_AnimalFriendFeedQuest.GetNthAlias(0) as ReferenceAlias).ForceRefTo(akTarget)
	akTarget.ShowGiftMenu(;/abGiving = /;true, apFilterList = _SLS_AnimalFriendFoodList, abShowStolenItems = true, abUseFavorPoints = false)
	_SLS_FoodEatSM.Play(akTarget)
EndFunction

Function GotFed(Actor akActor, Form akBaseItem, Int aiItemCount)
	akActor.RestoreAv("Health", (ActorValueInfo.GetActorValueInfoByName("Health").GetMaximumValue(akActor) / 5.0) * aiItemCount)
	;UI.InvokeString("GiftMenu", "_root.Menu_mc.onExitButtonPress", "")
	Input.TapKey(Input.GetMappedKey("Tween Menu", DeviceType = 0xFF))
	FeedMenu(akActor)
EndFunction

Function BreastFeedMenu(Actor akTarget)
	Int MenuResult = ShowBreastFeedMenu(akTarget)
	If MenuResult == -1
		FeedMenu(akTarget)
	ElseIf MenuResult == 0
		FeedToFullHealth(akTarget)
	ElseIf MenuResult == 1
		BreastFeed(akTarget, Quantity = 1.0)
	ElseIf MenuResult == 2
		BreastFeed(akTarget, Quantity = 2.0)
	ElseIf MenuResult == 3
		BreastFeed(akTarget, Quantity = 4.0)
	ElseIf MenuResult == 4
		BreastFeed(akTarget, Quantity = 6.0)
	ElseIf MenuResult == 5
		BreastFeed(akTarget, Quantity = 8.0)
	ElseIf MenuResult == 6
		BreastFeed(akTarget, Quantity = 10.0)
	EndIf
EndFunction

Int Function ShowBreastFeedMenu(Actor akTarget)
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 0, value = "Feed To Full Health")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 1, value = "Feed One")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 2, value = "Feed Two")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 3, value = "Feed Four")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 4, value = "Feed Six")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 5, value = "Feed Eight")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 6, value = "Feed Ten")

	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 0, value = "Feed To Full Health")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 1, value = "Feed One")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 2, value = "Feed Two")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 3, value = "Feed Four")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 4, value = "Feed Six")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 5, value = "Feed Eight")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 6, value = "Feed Ten")

	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 0, value = StorageUtil.GetFloatValue(PlayerRef, "MME.MilkMaid.MilkCount", Missing = 0.0) >= 1.0)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 1, value = StorageUtil.GetFloatValue(PlayerRef, "MME.MilkMaid.MilkCount", Missing = 0.0) >= 1.0)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 2, value = StorageUtil.GetFloatValue(PlayerRef, "MME.MilkMaid.MilkCount", Missing = 0.0) >= 2.0)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 3, value = StorageUtil.GetFloatValue(PlayerRef, "MME.MilkMaid.MilkCount", Missing = 0.0) >= 4.0)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 4, value = StorageUtil.GetFloatValue(PlayerRef, "MME.MilkMaid.MilkCount", Missing = 0.0) >= 6.0)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 5, value = StorageUtil.GetFloatValue(PlayerRef, "MME.MilkMaid.MilkCount", Missing = 0.0) >= 8.0)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 6, value = StorageUtil.GetFloatValue(PlayerRef, "MME.MilkMaid.MilkCount", Missing = 0.0) >= 10.0)
	
	Return wheelMenu.OpenMenu(akTarget)
EndFunction

Function FeedToFullHealth(Actor akTarget)
	Float FullHealth = ActorValueInfo.GetActorValueInfoByName("Health").GetMaximumValue(akTarget)
	Float HealingPerMilk = GetHealingPerMilk(PlayerRef)
	Float MilkNeeded = Math.Ceiling((FullHealth - akTarget.GetAv("Health")) / HealingPerMilk)
	If MilkNeeded > StorageUtil.GetFloatValue(PlayerRef, "MME.MilkMaid.MilkCount", Missing = 0.0)
		MilkNeeded = (StorageUtil.GetFloatValue(PlayerRef, "MME.MilkMaid.MilkCount", Missing = 0.0) as Int) as Float
	EndIf
	BreastFeed(akTarget, MilkNeeded)
EndFunction

Function BreastFeed(Actor akTarget, Float Quantity)
	Float HealingPerMilk = GetHealingPerMilk(PlayerRef)
	StorageUtil.AdjustFloatValue(PlayerRef, "MME.MilkMaid.MilkCount", -(Quantity))
	StorageUtil.AdjustFloatValue(PlayerRef,"MME.MilkMaid.TimesMilked", Quantity)
	akTarget.RestoreAv("Health", HealingPerMilk * Quantity)
	_SLS_SlurpSM.Play(akTarget)
	Mme.RefreshBreastSize(PlayerRef)
	
	Float OneMoment = 1.0 / 10.0
	Util.PassHours(OneMoment * Quantity)
	BreastFeedMenu(akTarget)
EndFunction

Float Function GetHealingPerMilk(Actor akActor)
	Float BaseHeal = 20.0
	Float MaidLevel = StorageUtil.GetFloatValue(akActor, "MME.MilkMaid.Level", Missing = 0.0)
	Return BaseHeal + (BaseHeal * MaidLevel)
EndFunction

Int Function ShowPackList()
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	;ListMenu.AddEntryItem("<font color='f00' font-style='italic' font-weight='bold' text-decoration='underline'>Name - Allure Cost - Orders - Health - Injuries</font>")
	ListMenu.AddEntryItem("Name-Allure-Orders Health-Injuries-Cum")
	Actor akActor
	String CurPackage
	Int i = 0
	Int MemberIndex
	While i < _SLS_AnimalFriendAliases.GetNumAliases()
		akActor = (_SLS_AnimalFriendAliases.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
		If akActor
			If akActor.IsInFaction(_SLS_AnimalFriendWaitFact)
				CurPackage = "Wait"
			Else
				CurPackage = "Follow"
			EndIf
			MemberIndex += 1
			ListMenu.AddEntryItem(MemberIndex + ") " + akActor.GetDisplayName() + " - " + (GetAllureCost(akActor) as Int) + " - " + CurPackage + " - " + ((akActor.GetAvPercentage("Health") * 100.0) as Int) + "% - " + (((StorageUtil.GetFloatValue(akActor, "_SLS_AnimalFriendBleedoutCount", Missing = 0.0) / 3.0) * 100.0) as Int) + "%" + " - " + ((Util.GetLoadFullnessMod(akActor) * 100.0) as Int) + "%")
		EndIf
		i += 1
	EndWhile
	ListMenu.OpenMenu()
	Return ListMenu.GetResultInt()
EndFunction

Function FuckNpcMenu(Actor akTarget)
	Int MenuResult = ShowFuckNpcMenu()
	If MenuResult == -1
		CreatureMoreMenu(akTarget)
	Else
		Actor akReceiver = (_SLS_AnimalFriendFuckNpcSearch.GetNthAlias(MenuResult) as ReferenceAlias).GetReference() as Actor
		FuckNpcInThe(akTarget, akReceiver)
	EndIf
EndFunction

Int Function ShowFuckNpcMenu()
	_SLS_AnimalFriendFuckNpcSearch.Stop()
	_SLS_AnimalFriendFuckNpcSearch.Start()
	Utility.Wait(0.1)
	
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	Actor akActor
	Int i = 0
	While i < _SLS_AnimalFriendFuckNpcSearch.GetNumAliases()
		akActor = (_SLS_AnimalFriendFuckNpcSearch.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
		If akActor
			ListMenu.AddEntryItem(akActor.GetDisplayName())
		EndIf
		i += 1
	EndWhile
	ListMenu.OpenMenu()
	Return ListMenu.GetResultInt()
EndFunction

Function FuckNpcInThe(Actor akCreature, Actor akReceiver)
	String SexType = ShowFuckNpcInTheMenu(akCreature)
	If SexType == ""
		CreatureMoreMenu(akCreature)
	Else
		
		Form[] Creatures = GetFriendsOfSameRace(akCreature, IncludeSource = false)		
		Actor[] SexActors = new Actor[2]
		sslBaseAnimation[] Animations
		If SexType == "3P"
			SexActors = new Actor[3]
			SexActors[2] = Creatures[0] as Actor
			Animations = Util.AnimsThreeP
		ElseIf SexType == "4P"
			SexActors = new Actor[4]
			SexActors[2] =  Creatures[0] as Actor
			SexActors[3] =  Creatures[1] as Actor
			Animations = Util.AnimsfourP
		Else
			SexActors = new Actor[2]
			SexActors[1] = akCreature
			If SexType == "Oral"
				Animations = Util.AnimsOral
			ElseIf SexType == "Vaginal"
				Animations = Util.AnimsVaginal
			Else
				Animations = Util.AnimsAnal
			EndIf
		EndIf
		SexActors[0] = akReceiver
		SexActors[1] = akCreature
		
		Int SexSuccess = CanFuckNpc(SexActors)		
		Debug.Messagebox("SexSuccess: " + SexSuccess)
		If SexSuccess == 1
			;Util.DoCreatureSex(akReceiver, akCreature, SexType, Victim = None, IsCreatureFondle = false, DoTeleport = false)
			Sexlab.StartSex(sexActors, animations, Victim = None)
		ElseIf SexSuccess == 2
			;Util.DoCreatureSex(akReceiver, akCreature, SexType, Victim = akReceiver, IsCreatureFondle = false, DoTeleport = false)
			Sexlab.StartSex(sexActors, animations, Victim = akReceiver)
		EndIf
	EndIf
EndFunction

String Function ShowFuckNpcInTheMenu(Actor akCreature)
	Util.SetupCreatureSex(akCreature)
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	
	Int FriendsOfSameRaceCount = GetFriendsOfSameRaceCount(akCreature, IncludeSource = true)
	
	If Init.OralAnimAvailable
		ListMenu.AddEntryItem("Fuck Her Face")
		StorageUtil.StringListAdd(Self, "_SLS_SexTypesAvailTemp", "Oral")
	EndIf
	If Init.VaginalAnimAvailable
		ListMenu.AddEntryItem("Fuck Her Pussy")
		StorageUtil.StringListAdd(Self, "_SLS_SexTypesAvailTemp", "Vaginal")
	EndIf
	If Init.AnalAnimAvailable
		ListMenu.AddEntryItem("Fuck Her Ass")
		StorageUtil.StringListAdd(Self, "_SLS_SexTypesAvailTemp", "Anal")
	EndIf
	If Init.ThreepAnimAvailable && FriendsOfSameRaceCount >= 2
		ListMenu.AddEntryItem("3P Gangbang")
		StorageUtil.StringListAdd(Self, "_SLS_SexTypesAvailTemp", "3P")
	EndIf
	If Init.FourpAnimAvailable && FriendsOfSameRaceCount >= 3
		ListMenu.AddEntryItem("4P Gangbang")
		StorageUtil.StringListAdd(Self, "_SLS_SexTypesAvailTemp", "4P")
	EndIf
	
	ListMenu.OpenMenu()
	Int MenuResult = ListMenu.GetResultInt()
	If MenuResult == -1
		Return ""
	Else
		String Result = StorageUtil.StringListGet(Self, "_SLS_SexTypesAvailTemp", MenuResult)
		StorageUtil.StringListClear(Self, "_SLS_SexTypesAvailTemp")
		Return Result
	EndIf
EndFunction

Int Function CanFuckNpc(Actor[] SexActors)
	;SexActors 0 - Target, 1 - 3 creatures
	; Returns 0 - Resists, 1 - Submits, 2 - Resist fail
	If SexActors[0].IsInFaction(Init.ZazSlaveFaction) || SexActors[0].IsInFaction(Init.SbcFaction)
		Debug.Notification(SexActors[0].GetDisplayName() + " is a slave")
		Return 1
	ElseIf SexActors[0].IsInFaction(Init.PahFaction) && SexActors[0].GetFactionRank(Game.GetFormFromFile(0x0047EB, "paradise_halls.esm") as Faction) >= 90 ; PAHSubmission
		Debug.Notification(SexActors[0].GetDisplayName() + " is a PAH slave & submissive")
		Return 1
	Else
		Float StaminaDef = SexActors[0].GetAv("Stamina")
		Float StaminaAgg
		
		Int i = 1
		While i < SexActors.Length
			StaminaAgg += SexActors[i].GetAv("Stamina")
			i += 1
		EndWhile
		
		If StaminaAgg > StaminaDef
			Return 2
		EndIf
	EndIf
	Debug.Notification(SexActors[0].GetDisplayName() + " resists")
	Return 0
Endfunction

Function PlayerStatsMenu()
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	ListMenu.AddEntryItem("Wildling Level: " + Wildling._SLS_WildlingLevel.GetValueInt())
	ListMenu.AddEntryItem("Wildling Points: " + SnipToDecimalPlaces(Wildling._SLS_WildlingPoints.GetValue(), 3))
	ListMenu.AddEntryItem("Allure Pool: " + SnipToDecimalPlaces(Wildling.AllurePool, 2))
	ListMenu.AddEntryItem("Allure Spent: " + SnipToDecimalPlaces(Wildling.AllureSpent, 2))
	ListMenu.AddEntryItem("Allure Remaining: " + SnipToDecimalPlaces((Wildling.AllurePool - Wildling.AllureSpent), 2))
	ListMenu.AddEntryItem(" === Allure Costs === ")
	Int i = 0
	While i < JsonUtil.StringListCount("SL Survival/CreatureTiers.json", "names")
		ListMenu.AddEntryItem(JsonUtil.StringListGet("SL Survival/CreatureTiers.json", "names", i) + ": " + (JsonUtil.FloatListGet("SL Survival/CreatureTiers.json", "tiers", i) as Int))
		i += 1
	EndWhile
	ListMenu.OpenMenu()
	;Return ListMenu.GetResultInt()
EndFunction

String Function SnipToDecimalPlaces(String StrInput, Int Places)
	Return StringUtil.Substring(StrInput, startIndex = 0, len =  Places + 1 + StringUtil.Find(StrInput, ".", startIndex = 0))
EndFunction

Float Property BreedingCooloffBase = 3.0 Auto Hidden
Float Property BreedingCooloffPregnancy = 12.0 Auto Hidden
Float Property BreedingCooloffCumCovered = 6.0 Auto Hidden
Float Property BreedingCooloffCumFilled = 12.0 Auto Hidden
Float Property SwallowBonus = 12.0 Auto Hidden

Float SleepBeginTime

Actor ApproachingFriend

;GlobalVariable Property _SLS_AnimalFriendApproachCount Auto

ReferenceAlias Property TalkingCreature Auto

Quest Property _SLS_AnimalFriendFgQuest Auto
Quest Property _SLS_CreatureFleeAliases Auto
Quest Property _SLS_AnimalFriendAliases Auto
Quest Property _SLS_AnimalFriendClosestEnemy Auto
Quest Property _SLS_AnimalFriendFuckNpcSearch Auto
Quest Property _SLS_AnimalFriendWithdrawAliases Auto
Quest Property _SLS_CreatureForceGreet Auto
Quest Property _SLS_AnimalFriendBleedoutAliases Auto
Quest Property _SLS_AnimalFriendFeedQuest Auto

Package Property _SLS_CreatureForceGreetPackage Auto

Actor Property PlayerRef Auto

Sound Property _SLS_HorseAgitated Auto
Sound Property _SLS_HorseSniffs Auto
Sound Property _SLS_HorseNeigh Auto
Sound Property _SLS_FoodEatSM Auto
Sound Property _SLS_SlurpSM Auto

VoiceType Property CrHorseVoice Auto

Formlist Property _SLS_AnimalBreedVoices Auto ; A list of voices that can be your breeders
Formlist Property _SLS_MountableFriends Auto ; Creatures that should have the 'ride' option available
Formlist Property _SLS_AnimalFriendCheckedFactions Auto
Formlist Property _SLS_AnimalFriendFoodList Auto

Faction Property _SLS_AnimalFriendFgFact Auto
Faction Property _SLS_AnimalFriendKnockedOut Auto
Faction Property _SLS_AnimalFriendFaction Auto
Faction Property _SLS_AnimalFriendWaitFact Auto
Faction Property _SLS_TameableCreatureFact Auto
Faction Property _SLS_AnimalFriendAvoidCombatFact Auto
Faction Property dunPrisonerFaction Auto
Faction Property SexlabAnimatingFaction Auto

ObjectReference Property _SLS_AnimalFriendHomeMarkerOne Auto

SexlabFramework Property Sexlab Auto
_SLS_Wildling Property Wildling Auto
SLS_Utility Property Util Auto
SLS_Init Property Init Auto
_SLS_InterfaceSgo Property Sgo Auto
_SLS_InterfaceFhu Property Fhu Auto
_SLS_InterfaceFm Property Fm Auto
_SLS_InterfaceMme Property Mme Auto
