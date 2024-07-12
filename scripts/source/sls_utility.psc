Scriptname SLS_Utility extends Quest  

Event OnInit()
	InitRaceLoadSize()
	InitFondleableVoices()
	SetupSwEffectsList()
	RegForEvents()
	StorageUtil.SetIntValue(Self, "ArmorBreakdownHelp", 1)
EndEvent

Function RegForEvents()
	RegisterForModEvent("_SLS_Int_PlayerLoadsGame", "On_SLS_Int_PlayerLoadsGame")
	RegisterForModEvent("dhlp-Suspend", "OnSuspend")
	RegisterForModEvent("dhlp-Resume", "OnResume")
EndFunction

Event OnSuspend(string eventName, string strArg, float numArg, Form sender)
	_SLS_dhlpSuspend.SetValueInt(1)
	_SLS_GuardWarnedQuest.Stop()
	_SLS_GuardWarnArmorEquippedDetectQuest.Stop()
	_SLS_GuardWarnDrugDetectionQuest.Stop()
	_SLS_GuardWarnPickDetectionQuest.Stop()
	_SLS_GuardWarnWeapDrawnDetectionQuest.Stop()
	_SLS_GuardWarnWeapEquippedDetectQuest.Stop()
EndEvent

Event OnResume(string eventName, string strArg, float numArg, Form sender)
	_SLS_dhlpSuspend.SetValueInt(0)
EndEvent

Event On_SLS_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
	If Game.GetModByName("ZaZAnimationPack.esm") != 255
		zbfWornDevice = Game.GetFormFromFile( 0x00A17C, "ZaZAnimationPack.esm") as Keyword ; zbfWornDevice
	Else
		zbfWornDevice = Game.GetFormFromFile(0x054B5B, "SL Survival.esp") as Keyword ; _SLS_UnusedDummyKw
	EndIf
EndEvent

Function DoCumSwallow(Actor CumSource = None, Float CumAmount = -1.0, Bool DidSwallow = true, Int AddCumToFace = 0)
	; CumAmount doesn't need to be specified if CumSource is provided.
	; CumAmount is balanced around guestimations that 1.0 = a standard sized human load. This is then translated into food/water quantities via SLS_Needs based on which needs mod is active. 
	; DidSwallow - Player tries her best to swallow everything. When false only a fraction of the load is swallowed. 
	; AddCumToFace - Add cum to player's face and set cum type data so it can be collected. 0 - No cum, 1 - 1 layer of cum, 2 - 2 layers of cum
	
	Float LoadSizeBase
	Float LoadSize
	If CumAmount == -1.0 && CumSource == None ; Neither CumAmount or CumSource was specified
		Debug.Trace("_SLS_: Error - DoCumSwallow received invalid parameters: CumSource: " + CumSource + ". CumAmount: " + CumAmount + ". DidSwallow: " + DidSwallow)
		Return
	ElseIf CumAmount != -1.0
		LoadSizeBase = CumAmount
	ElseIf CumSource
		LoadSizeBase = GetLoadSize(CumSource)
	EndIf

	LoadSize = GetLoadSizeActual(CumSource, LoadSizeBase)
	If DidSwallow && (LoadSize / LoadSizeBase) < (Menu.CumEffectVolThres / 100.0)
		Debug.Notification("You swallow but there isn't as much cum as you expected")
	EndIf
	SwallowCum(CumSource, LoadSizeBase, LoadSize, DidSwallow)
	Psq.AddSuccubusEnergy(Amount = (10.0 * LoadSize * Menu.SuccubusCumSwallowEnergyMult) + ((Menu.SuccubusCumSwallowEnergyPerRank as Float) * (Psq.GetSuccubusRank() - 1.0) * 10.0 * LoadSize * Menu.SuccubusCumSwallowEnergyMult), UpdateDisplay = true)

	If CumSource
		VoiceType CumVoice = CumSource.GetVoiceType()
		While AddCumToFace > 0
			AddCumToFace -= 1
			Sexlab.AddCum(PlayerRef, Vaginal = false, Oral = true, Anal = false)
			If AddCumToFace > 0
				Utility.Wait(1.0)
			EndIf
		EndWhile
		If _SLS_FondleableVoices.HasForm(CumVoice)
			StorageUtil.SetFormValue(PlayerRef, "_SLS_LastCumTypeForPotionOral", CumSource.GetVoiceType())
		Else
			StorageUtil.SetFormValue(PlayerRef, "_SLS_LastCumTypeForPotionOral", CumSource.GetRace())
		EndIf
		
		
		; Stats
		If !DidSwallow
			LoadSize = LoadSize / 5.0
			CumUnitsSpat += 4.0 * LoadSize
			LoadsSpat += 1
			
		Else
			LoadsSwallowed += 1
			CumUnitsSwallowed += LoadSize
			StorageUtil.SetIntValue(CumVoice, "_SLS_LoadsSwallowed", StorageUtil.GetIntValue(CumVoice, "_SLS_LoadsSwallowed", Missing = 0) + 1)
		EndIf
		StorageUtil.SetFloatValue(CumVoice, "_SLS_CumUnitsSwallowed", StorageUtil.GetFloatValue(CumVoice, "_SLS_CumUnitsSwallowed", Missing = 0.0) + LoadSize)
		If CumSource.GetRace().IsRaceFlagSet(0x00000001) ; Is playable race
			CumUnitsSwallowedHumanoid += LoadSize
			LoadsSwallowedHumanoid += 1
		EndIf
	EndIf
EndFunction

Function SwallowCum(Actor akSource, Float LoadSizeBase, Float LoadSize, Bool Swallowed, Bool DoEffects = true, Bool Inflate = true, Bool IsCumPotion = false)
	If !Swallowed
		LoadSize = LoadSize / 5.0
		;Debug.Messagebox("Player swallowed " + LoadSize + " units of cum")
	Else
		;Debug.Messagebox("SwallowCum(): Player swallowed " + LoadSize + " units of cum from " + akSource + "\nName: " + akSource.GetName())
		If Inflate
			CumSwallowInflate(LoadSize)
		EndIf
		If DoEffects
			DoCumSwallowEffects(LoadSize)
		EndIf
		LastLoadSize = LoadSize
		If Menu.CumBreath
			_SLS_CumBreathScript.Cast(PlayerRef, PlayerRef)
		EndIf
	EndIf
	Api.SendCumSwallowEvent(akSource, Swallowed, LoadSize, LoadSizeBase, IsCumPotion)
	;/
	If Swallowed && Inflate
		CumSwallowInflate(LoadSize)
	EndIf
	/;
	Needs.EatCum(LoadSize)
	Needs.DrinkCum(LoadSize)
	
	If HasCumLactacid(akSource)
		SwallowedCumLactacid(LoadSize, akSource)
	EndIf
EndFunction

Function CumSwallowInflate(Float CumAmount)
	;Debug.Messagebox("Inflate: Swallowed " + Amount + " units of cum")
	If Menu.CumSwallowInflate
		;Fhu.InflateTo(PlayerRef, 2, Time = 6.0, TargetLevel = (CumAmount / 2.5))
		
		; Thread off inflation for better synchronization. Hopefully.
		Int FhuInflate = ModEvent.Create("_SLS_FhuInflate")
		If (FhuInflate)
			ModEvent.PushForm(FhuInflate, PlayerRef) ; Target
			ModEvent.PushInt(FhuInflate, 2) ; Hole
			ModEvent.PushFloat(FhuInflate, 5.0) ; Time
			ModEvent.PushFloat(FhuInflate, (CumAmount / 2.5)) ; TargetLevel. FHU cum values are ROUGHLY (SLS CumAmounts / 2.5)
			ModEvent.Send(FhuInflate)
		EndIf
	EndIf
EndFunction

Bool Function IsEnjoyingCum()
	If PlayerRef.IsInFaction(SexLabAnimatingFaction)
		Int tid = Sexlab.FindPlayerController()
		If Sexlab.IsVictim(tid, PlayerRef)
			Return true
		EndIf
	
	ElseIf CumAddict.GetAddictionState() >= 2 ; Cum addict or worse
		Return true
	EndIf
	Return false
EndFunction

Function DoCumSwallowEffects(Float LoadSize)
	Bool EnjoysCum = IsEnjoyingCum()
	;Debug.Messagebox("Swallowed " + LoadSize + " units of cum" + "\nEnjoying Cum: " + EnjoysCum)
	If EnjoysCum
		_SLS_CumSwallowForcedMarker.Play(PlayerRef)
	Else
		_SLS_CumSwallowSatisfiedMarker.Play(PlayerRef)
	EndIf

	Float SwallowAmount = 1.0
	While LoadSize > 0.0
		_SLS_CumSwallowMarker.Play(PlayerRef)
		LoadSize -= SwallowAmount
		SwallowAmount = SwallowAmount * 3.0 ; Increase the amount swallowed each iteration so it doesn't go on too long. This should give Big: 2 swallows, massive: 3 etc
		If LoadSize > 0.0
			Utility.Wait(2.0 + Utility.RandomFloat(-0.2, 0.2))
		EndIf
	EndWhile
EndFunction

Bool Function HasCumLactacid(Actor akSource)
	If Menu.CumLactacidAll
		Return true
	ElseIf Menu.CumLactacidAllPlayable && akSource.GetRace().IsRaceFlagSet(0x00000001)
		Return true
	EndIf
	VoiceType Voice = akSource.GetVoiceType()
	If Voice
		If _SLS_CumHasLactacidVoices.HasForm(Voice)
			Return true
		EndIf
	EndIf
	Return false
EndFunction

Function SwallowedCumLactacid(Float CumAmount, Actor akSource)
	If Menu.CumIsLactacid > 0.0
		If !IsMilkMaid(PlayerRef)
			SendMakeMmeMilkMaidEvent(PlayerRef)
		EndIf
		StorageUtil.AdjustFloatValue(PlayerRef, "MME.MilkMaid.LactacidCount", (CumAmount * Menu.CumIsLactacid))
	EndIf
EndFunction

Function QueueCumPotion(Actor CumSource)
	StorageUtil.FormListAdd(Self, "_SLS_CumPotionQueue", CumSource, AllowDuplicate = true)
	If CumSource.IsInFaction(CreatureFaction)
		IncreamentCreatureCorruption()
	EndIf
	If !UI.IsMenuOpen("InventoryMenu")
		ProcCumPotionQueue()
	Else
		RegisterForMenu("InventoryMenu")
	EndIf
	;PlayerRef.AddItem(Game.GetFormFromFile(0x0FAE1C, "SL Survival.esp")) ; Empty cumtainer
	;PlayerRef.AddItem(Game.GetFormFromFile(0x105AA8, "SL Survival.esp")) ; Spent cumtainer
EndFunction

Function IncreamentCreatureCorruption(Float Inc = 1.0)
	StorageUtil.AdjustFloatValue(None, "_SLS_CreatureCorruption", Inc)
	_SLS_CreatureCorruptionGlob.SetValue(StorageUtil.GetFloatValue(None, "_SLS_CreatureCorruption"))
EndFunction

Event OnMenuClose(String MenuName)
	ProcCumPotionQueue()
EndEvent

Function ProcCumPotionQueue()
	;Debug.Messagebox("Proccessing " + StorageUtil.FormListCount(Self, "_SLS_CumPotionQueue") + " cum potions")
	UnRegisterForMenu("InventoryMenu")
	Float TotalCum = 0.0
	Form LastCumPotion = StorageUtil.FormListGet(Self, "_SLS_CumPotionQueue", StorageUtil.FormListCount(Self, "_SLS_CumPotionQueue") - 1)
	;Debug.Messagebox((StorageUtil.FormListCount(Self, "_SLS_CumPotionQueue") - 1) + "\n" + StorageUtil.FormListToArray(Self, "_SLS_CumPotionQueue"))
	While StorageUtil.FormListCount(Self, "_SLS_CumPotionQueue") > 0
		TotalCum += DrinkCumPotion(StorageUtil.FormListGet(Self, "_SLS_CumPotionQueue", 0) as Actor)
		StorageUtil.FormListRemoveAt(Self, "_SLS_CumPotionQueue", 0)
		;Debug.Messagebox("doing the thing")
	EndWhile
	If TotalCum > 0.0 ; RegisterForMenu in BikiniBreak is registering all scripts attached to main.....
		DoDrinkCumPotionEffects(TotalCum, LastCumPotion)
	EndIf
EndFunction

Function DoDrinkCumPotionEffects(Float TotalCum, Form LastCumPotion)
	If !PlayerRef.IsInFaction(SexLabAnimatingFaction) && !PlayerRef.IsOnMount()
		Debug.SendAnimationEvent(PlayerRef, "IdleDrinkPotion")
	EndIf
	DoCumSwallowEffects(TotalCum)
	CumSwallowInflate(TotalCum)
	Sexlab.AddCum(PlayerRef, Vaginal = false, Oral = true, Anal = false)
	;Debug.Messagebox("LastCumPotion: " + LastCumPotion + "\nTotalCum: " + TotalCum)
	StorageUtil.SetFormValue(PlayerRef, "_SLS_LastCumTypeForPotionOral", LastCumPotion)
EndFunction

Float Function DrinkCumPotion(Actor CumSource)
	StorageUtil.SetFloatValue(CumSource, "_SLS_LastOrgasmTime", -7.0)
	Float LoadSizeBase = GetLoadSize(CumSource)
	SwallowCum(CumSource, LoadSizeBase, LoadSizeBase, Swallowed = true, DoEffects = false, Inflate = false, IsCumPotion = true) ; Swallowed cum actual IS LoadSizeBase - Potions don't have balls to be replenished. DoEffects and Inflate later
	Return LoadSizeBase
EndFunction

Bool Function IsMilkMaid(Actor Maid)
	If StorageUtil.GetFloatValue(Maid, "MME.MilkMaid.MilkCount", Missing = -1.0) >= 0.0
		Return true
	EndIf
	Return false		
EndFunction

Function SendMakeMmeMilkMaidEvent(Actor MilkMaidToBe)
	Int MakeMaid = ModEvent.Create("MME_AddMilkMaid")
	If (MakeMaid)
		ModEvent.PushForm(MakeMaid, MilkMaidToBe)
		ModEvent.Send(MakeMaid)
	EndIf
EndFunction

Function InitRaceLoadSize()
	Form CurrentRace
	Int LoadSize
	; Vanill races
	Formlist FlSelect
	Int i = 0
	While i < _SLS_CumList_a_All.GetSize()
		FlSelect = _SLS_CumList_a_All.GetAt(i) as Formlist
		Int j = 0
		While j < FlSelect.GetSize()
			CurrentRace = FlSelect.GetAt(j)
			StorageUtil.SetIntValue(CurrentRace, "_SLS_LoadSize", i)
			;Debug.Trace("Setting race: " + CurrentRace + " cum size to: " + i)
			_SLS_CumList_z_SetForms.AddForm(CurrentRace)
			j += 1
		EndWhile		
		i += 1
	EndWhile
	
	; Custom races
	i = JsonUtil.FormListCount("SL Survival/RaceLoadSizes.json", "LoadRace")
	While i > 0
		i -= 1
		CurrentRace = JsonUtil.FormListGet("SL Survival/RaceLoadSizes.json", "LoadRace", i)
		LoadSize = JsonUtil.IntListGet("SL Survival/RaceLoadSizes.json", "LoadSize", i)
		Storageutil.SetIntValue(CurrentRace, "_SLS_LoadSize", LoadSize)
		_SLS_CumList_z_SetForms.AddForm(CurrentRace)
	EndWhile
EndFunction

Int Function GetLoadTier(Actor CumSource)
	; 0 - tiny - Skeever/Hare
	; 1 - small - Dog/Wolf
	; 2 - average - Most playable races
	; 3 - Above Average - Orcs/Nords
	; 4 - Big - Troll/Horse/Bear/Sabrecat
	; 5 - Huge - Mammoth
	; 6 - Massive - Dragon
	
	;If Needs.GetState() != "" ; Why is this check here???
		Race LoadRace = CumSource.GetRace()
		Int LoadSize = StorageUtil.GetIntValue(LoadRace, "_SLS_LoadSize", Missing = -1)
		;Debug.Messagebox("GetLoadTier: LoadSize: " + LoadSize)
		If LoadSize == -1
			LoadSize = _SLS_LoadSizeQueryMsg.Show()
			JsonUtil.FormListAdd("SL Survival/RaceLoadSizes.json", "LoadRace", LoadRace)
			JsonUtil.IntListAdd("SL Survival/RaceLoadSizes.json", "LoadSize", LoadSize)
			JsonUtil.Save("SL Survival/RaceLoadSizes.json")
			
			StorageUtil.SetIntValue(LoadRace, "_SLS_LoadSize", LoadSize)
		EndIf
		Debug.Trace("_SLS_: Actor: " + CumSource.GetName() + ". Cum Tier: " + LoadSize)
		Return LoadSize
	
	;Else
	;	Return 2
	;EndIf
EndFunction

Float Function GetLoadSize(Actor CumSource, Int LoadTier = -1)
	Int LoadType = LoadTier
	If LoadType == -1
		LoadType = GetLoadTier(CumSource)
		;Debug.Messagebox("LoadType: " + LoadType)
	EndIf
	Float LoadSize
	If LoadType == 0 ; Tiny
		LoadSize = 0.3 
	ElseIf LoadType == 1 ; Small
		LoadSize = 0.7
	ElseIf LoadType == 2 ; Average
		LoadSize = 1.0
	ElseIf LoadType == 3 ; Above Average
		LoadSize = 1.4
	ElseIf LoadType == 4 ; Big
		LoadSize =  5.0
	ElseIf LoadType == 5 ; Huge
		LoadSize = 20.0
	ElseIf LoadType == 6 ; Massive
		LoadSize = 50.0
	Else
		Debug.Trace("_SLS_: Error - No match found for load type: " + LoadType)
		Return 0.0
	EndIf
	LoadSize = LoadSize + Utility.RandomFloat(-(LoadSize/4.0), (LoadSize/4.0))
	If CumSource
		Debug.Trace("_SLS_: Actor: " + CumSource.GetName() + ". Cum LoadSize: " + LoadSize)
	EndIf
	;Debug.Messagebox("GetLoadSize: LoadSize: " + LoadSize)
	Return LoadSize
EndFunction

Float Function GetLoadSizeActual(Actor CumSource, Float LoadSizeBase)
	; Males don't have an endless supply of cum. Get their load size based on the last time they orgasmed
	
	;Debug.Messagebox((Utility.GetCurrentGameTime() - StorageUtil.GetFloatValue(CumSource, "_SLS_LastOrgasmTime", Missing = -7.0)))
	If CumSource
		Float LoadMod = GetLoadFullnessMod(CumSource)
		;Debug.MessageBox("LoadMod: " + LoadMod)
		Return (LoadMod * LoadSizeBase)
	EndIf
	Return LoadSizeBase
EndFunction

Float Function GetLoadFullnessMod(Actor akTarget)
	; Returns cum fullness as 0.0 (Empty) -> 1.0 (Full)
	If Menu.CumRegenTime > 0.0
		Return PapyrusUtil.ClampFloat((Utility.GetCurrentGameTime() - StorageUtil.GetFloatValue(akTarget, "_SLS_LastOrgasmTime", Missing = -7.0)) / (Menu.CumRegenTime / 24.0), 0.0, 1.0)
	EndIf
	Return 1.0
EndFunction

String Function GetCumFullnessString(Actor akActor)
	Float Fullness = GetCumFullness(akActor)
	;Debug.Messagebox("Fullness: " + Fullness)
	If Fullness >= 1.0
		Return "bursting with cum"
	ElseIf Fullness >= (Menu.CumEffectVolThres / 100.0)
		Return "almost full of cum"
	ElseIf Fullness >= 0.5
		Return "about half full"
	ElseIf Fullness >= ((Menu.CumEffectVolThres / 100.0) / 2.0)
		Return "almost empty"
	Else
		Return "empty"
	EndIf
EndFunction

Float Function GetCumFullness(Actor akActor)
	Float LoadSizeBase = GetLoadSize(akActor)
	Float LoadSizeActual = GetLoadSizeActual(akActor, LoadSizeBase)
	;Debug.Messagebox("LoadSizeBase: " + LoadSizeBase + "\nLoadSizeActual: " + LoadSizeActual)
	Return GetLoadSizeActual(akActor, LoadSizeBase) / LoadSizeBase
EndFunction

Function SendCumSwallowEvent(Form akSource, Bool DidSwallow, Float CumAmount, Float LoadSizeBase, Bool IsCumPotion)
    Int CumSwallowEvent = ModEvent.Create("_SLS_PlayerSwallowedCum")
    If (CumSwallowEvent)
		ModEvent.PushForm(CumSwallowEvent, akSource)
        ModEvent.PushBool(CumSwallowEvent, DidSwallow)
		ModEvent.PushFloat(CumSwallowEvent, CumAmount)
		ModEvent.PushFloat(CumSwallowEvent, LoadSizeBase)
		ModEvent.PushBool(CumSwallowEvent, IsCumPotion)
        ModEvent.Send(CumSwallowEvent)
    EndIf
EndFunction

Function ScreamForHelpBegin()
	Int Scream
	If CanSpeak(PlayerRef)
		Scream = _SLS_ScreamForHelpMarker.Play(PlayerRef)
		If PlayerRef.IsInCombat()
			_SLS_ScreamForHelpAliases.Stop()
			_SLS_ScreamForHelpAliases.Start()
		
		ElseIf PlayerRef.IsInFaction(SexLabAnimatingFaction)
			;If AreEnemiesInScene()
			;	_SLS_ScreamForHelpAliases.Stop()
			;	_SLS_ScreamForHelpAliases.Start()	
		;
			;Else
				;_SLS_ScreamForHelpSpectateQuest.Stop()
				_SLS_ScreamForHelpSpectateQuest.Start()
			;EndIf
		
		Else

			_SLS_ScreamForHelpCrazyBitchQuest.Stop()
			_SLS_ScreamForHelpCrazyBitchQuest.Start()
		EndIf
		
		Actor Guard = (_SLS_ScreamForHelpCrazyBitchQuest.GetNthAlias(0) as ReferenceAlias).GetReference() as Actor
		If Guard
			If Guard.GetDistance(PlayerRef) < 500.0
				Debug.SendAnimationEvent(Guard, "staggerStart")
			EndIf
		EndIf
	
	Else
		Scream = _SLS_GagTalkMarker.Play(PlayerRef)
	EndIf
EndFunction

;/ Unnecessary. And GetFactionReaction doesn't seem to work, at least during defeat scenes. Just draw the guard with spectate and he will act accordingly
Bool Function AreEnemiesInScene()
	_SLS_ScreamForHelpGuardSearch.Stop()
	_SLS_ScreamForHelpGuardSearch.Start()
	Actor Guard = (_SLS_ScreamForHelpGuardSearch.GetNthAlias(0) as ReferenceAlias).GetReference() as Actor
	Int tid = Sexlab.FindPlayerController()
	If Guard && tid > -1
		Actor[] actorList = SexLab.HookActors(tid as string)
		Actor Rapist
		Int i = actorList.Length

		While i > 0
			i -= 1
			Rapist = actorList[i]
			Debug.MessageBox("Guard: " + Guard + "\nRapist: " + Rapist + "\nGetFactionReaction: " + Rapist.GetFactionReaction(Guard))

			;If Rapist.GetFactionReaction(Guard) == 1
			;	Debug.MessageBox("Is being raped by enemy")
			;	Return true
			;EndIf
			
		EndWhile
		Debug.MessageBox("Is not being raped by enemy")
	EndIf
	Return false
EndFunction
/;
Bool Function CanSpeak(Actor akTarget)
	If Devious.IsPlayerGagged()
		Return false
	EndIf
	If PlayerRef.IsInFaction(SexLabAnimatingFaction)
		If Sexlab.IsMouthOpen(akTarget)
			Return false
		EndIf
	EndIf
	Return true
EndFunction

Function CrazyBitchSex()
	Actor Guard = (_SLS_ScreamForHelpCrazyBitchQuest.GetNthAlias(0) as ReferenceAlias).GetReference() as Actor
	_SLS_ScreamForHelpCrazyBitchQuest.Stop()
	Main.StartSexAnal(Guard, SexCat = 0, DecWillIncFame = true, Victim = PlayerRef, TeleportType = 0)
EndFunction

Function CrazyBitchGag()
	_SLS_ScreamForHelpCrazyBitchQuest.Stop()
	Devious.EquipRandomDeviceByCategory(PlayerRef, "Gags")
EndFunction

Function CrazyBitchComply()
	_SLS_ScreamForHelpCrazyBitchQuest.Stop()
	_SLS_ScreamCrazyBitchCooloffSpell.Cast(PlayerRef, PlayerRef)
EndFunction

Function CrazyBitchDoAny()
	;_SLS_ScreamForHelpCrazyBitchQuest.Stop()
	If Init.DdsInstalled
		If Utility.RandomInt(0, 1)
			CrazyBitchGag()
		Else
			CrazyBitchSex()
		EndIf
	Else
		CrazyBitchSex()
	EndIf
EndFunction

Function AddIncPickPocketLoot(ObjectReference akTargetRef)
	Actor akTarget = akTargetRef as Actor
	If akTarget
		akTarget.AddItem(_SLS_IncPickPocketLootToken, 1)
		If !akTarget.IsInFaction(Init.SbcFaction) && !akTarget.IsInFaction(Init.ZazSlaveFaction)
			
			; Gold
			akTarget.AddItem(_SLS_PpGoldRoot, 1)
			akTarget.AddItem(Gold001, Utility.RandomInt(0, 9))
			
			; Loot
			Int i = Utility.RandomInt(PpLootLootMin, PpLootLootMax)
			While i > 0
					akTarget.AddItem(_SLS_PpLootRootList, 1)
				i -= 1
			EndWhile
		EndIf
	EndIf
EndFunction

Function GiveMortalObject(Form akTarget, Form akBaseObject, Float DurMinMod, Float DurMaxMod, Bool Silent, Bool FitLoosely, Float CursedChance)
	Int MWA = ModEvent.Create("_MWA_AddFittedObject")
	If (MWA)
		ModEvent.PushForm(MWA, akTarget)
		ModEvent.PushForm(MWA, akBaseObject)
		ModEvent.PushFloat(MWA, DurMinMod)
		ModEvent.PushFloat(MWA, DurMaxMod)
		ModEvent.PushBool(MWA, Silent)
		ModEvent.PushBool(MWA, FitLoosely)
		ModEvent.PushFloat(MWA, CursedChance)
		ModEvent.Send(MWA)
	EndIf
EndFunction

Function RestoreDeviousFollowerLives()
	If Game.GetModByName("DeviousFollowers.esp") != 255
		GlobalVariable Lives = Game.GetFormFromFile(0x02DB9E, "DeviousFollowers.esp") as GlobalVariable
		GlobalVariable LivesMax = Game.GetFormFromFile(0x02E663, "DeviousFollowers.esp") as GlobalVariable
		If Lives.GetValueInt() < LivesMax.GetValueInt()
			Lives.SetValueInt(LivesMax.GetValueInt())
			Debug.Notification("Your follower had a great nights rest")
		EndIf
	EndIf
EndFunction

Function FondleArousalIncrease(Actor akActor, Bool IncFondleCount)
	;/
	; Nonsense!
	Float Arousal = StorageUtil.GetFloatValue(akActor, "SLAroused.ActorExposure") + CreatureFondleCount
	If Arousal > 100.0
		Arousal = 100.0
	EndIf
	StorageUtil.SetFloatValue(akActor, "SLAroused.ActorExposure", Arousal)
	/;
	ModArousal(akActor, CreatureFondleCount)
	If IncFondleCount
		CreatureFondleCount += 1.0
	EndIf
EndFunction

Function ResetFondleAnimationVariables()
	Init.ThreepAnimAvailable = false
	Init.FourpAnimAvailable = false
	Init.OralAnimAvailable = false
	Init.AnalAnimAvailable = false
	Init.VaginalAnimAvailable = false
	;/
	AnimsOral = None
	AnimsAnal = None
	AnimsVaginal = None
	AnimsThreeP = None
	AnimsFourP = None
	/;
EndFunction

Function SetupCreatureSex(Actor akSpeaker)
	If akSpeaker
		ResetFondleAnimationVariables()
		_SLS_CreatureGangVoices.Revert()
		_SLS_CreatureGangVoices.AddForm(akSpeaker.GetVoiceType())
		_SLS_CreatureSexSearchQuest.Stop()
		_SLS_CreatureSexSearchQuest.Start()
		Race CreatureRace = akSpeaker.GetLeveledActorBase().GetRace()

		AnimsOral = Sexlab.GetCreatureAnimationsByRaceTags(2, CreatureRace, "Blowjob,Oral", TagSuppress = "Cunnilingus", RequireAll = false)
		;Debug.Messagebox("Oral anims: " + AnimsOral.Length + "\n\nAnims: " + AnimsOral)
		If AnimsOral.Length > 0
			Init.OralAnimAvailable = true
		EndIf
		AnimsAnal = Sexlab.GetCreatureAnimationsByRaceTags(2, CreatureRace, "Anal", TagSuppress = "Cunnilingus", RequireAll = true)
		If AnimsAnal.Length > 0
			Init.AnalAnimAvailable = true
		EndIf
		AnimsVaginal = Sexlab.GetCreatureAnimationsByRaceTags(2, CreatureRace, "Vaginal", TagSuppress = "Cunnilingus", RequireAll = true)
		If AnimsVaginal.Length > 0
			Init.VaginalAnimAvailable = true
		EndIf
		AnimsThreeP = Sexlab.GetCreatureAnimationsByRace(3, CreatureRace)
		If AnimsThreeP.Length > 0
			Init.ThreepAnimAvailable = true
		EndIf
		AnimsfourP = Sexlab.GetCreatureAnimationsByRace(4, CreatureRace)
		If AnimsfourP.Length > 0
			Init.FourpAnimAvailable = true
		EndIf
		
		If Init.DebugMode
			Debug.Messagebox("OralAnimAvailable: " + Init.OralAnimAvailable + "\nAnalAnimAvailable: " + Init.AnalAnimAvailable + "\nVaginalAnimAvailable: " + Init.VaginalAnimAvailable + "\nThreepAnimAvailable: " + Init.ThreepAnimAvailable + "\nFourpAnimAvailable: " + Init.FourpAnimAvailable)
			;Debug.Messagebox("List has creature: " + (Game.GetFormFromFile(0x331E, "SL Survival.esp") as Formlist).Find(akSpeaker.GetVoiceType()))
		EndIf
		
		Init.GangbangCreaturesAvailable = 0
		Int CreatureCount = 0
		Int i = _SLS_CreatureSexSearchQuest.GetNumAliases()
		Actor Creature
		While i > 0
			i -= 1
			Creature = (_SLS_CreatureSexSearchQuest.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
			If Creature && Creature != akSpeaker
				CreatureCount += 1
			EndIf
		EndWhile
		Init.GangbangCreaturesAvailable = CreatureCount
		
	Else
		Debug.Trace("_SLS_: SetupCreatureSex: Recieved none" )
	EndIf
EndFunction

Function DoCreatureSex(Actor Receiver, Actor akSpeaker = None, String SexType = "Vaginal", Actor Victim = None, Bool IsCreatureFondle = false, Bool DoTeleport = false)
	; SexType - Oral, Anal, Vaginal, 3P, 4P
	
	If IsCreatureFondle
		_SLS_CreatureFondlePacifyQuest.Start()
		(_SLS_CreatureFondlePacifyQuest.GetNthAlias(0) as ReferenceAlias).ForceRefTo(akSpeaker)
		FondleArousalIncrease(akSpeaker, IncFondleCount = true)
		If _SLS_AnimalFriendQuest.IsRunning()
			AnimalFriend.FondleStart(akSpeaker)
		EndIf
		EndCreatureFg(akSpeaker)
	EndIf
	
	Race CreatureRace = akSpeaker.GetRace()
	Actor[] SexActors
	sslBaseAnimation[] Animations
	If SexType == "3P" || SexType == "4P"
		Int CreatureCount = 0
		Int i = _SLS_CreatureSexSearchQuest.GetNumAliases()
		Actor Creature
		Actor CreatureA
		Actor CreatureB
		While i > 0
			i -= 1
			Creature = (_SLS_CreatureSexSearchQuest.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
			If Creature && Creature != akSpeaker
				CreatureCount += 1
				If CreatureA == None
					CreatureA = Creature
				Else
					CreatureB = Creature
				EndIf
			EndIf
		EndWhile
		If CreatureA
			(_SLS_CreatureFondlePacifyQuest.GetNthAlias(1) as ReferenceAlias).ForceRefTo(CreatureA)
		EndIf
		If CreatureB
			(_SLS_CreatureFondlePacifyQuest.GetNthAlias(2) as ReferenceAlias).ForceRefTo(CreatureB)
		EndIf
		
		;Debug.Messagebox("CreatureA: " + CreatureA + "\nCreatureB: " + CreatureB + "\nInit.GangbangCreaturesAvailable: " + Init.GangbangCreaturesAvailable)
		
		If SexType == "3P"
			SexActors = new Actor[3]
			SexActors[2] = CreatureA
			FondleArousalIncrease(CreatureA, IncFondleCount = false)
			Animations = AnimsThreeP
		
		Else
			SexActors = new Actor[4]
			SexActors[2] = CreatureA
			SexActors[3] = CreatureB
			FondleArousalIncrease(CreatureA, IncFondleCount = false)
			FondleArousalIncrease(CreatureB, IncFondleCount = false)
			Animations = AnimsFourP
		EndIf

	Else
		SexActors= new Actor[2]
		If SexType == "Oral"
			Animations = AnimsOral
			
		ElseIf SexType == "Anal"
			Animations = AnimsAnal
			
		ElseIf SexType == "Vaginal"
			Animations = AnimsVaginal
		EndIf
	EndIf
	;Debug.Messagebox("SexActors: " + SexActors)
	SexActors[0] = Receiver
	SexActors[1] = akSpeaker
	If DoTeleport
		Int i = SexActors.Length
		While i > 1
			i -= 1
			SexActors[i].MoveTo(Receiver)
		EndWhile
	EndIf
	Sexlab.StartSex(sexActors, animations, Victim)
EndFunction

Function EndCreatureFg(Actor akSpeaker)
	(_SLS_CreatureForceGreet.GetNthAlias(0) as ReferenceAlias).Clear()
	_SLS_CreatureForceGreet.Stop()
	(akSpeaker).EvaluatePackage()
EndFunction

Function DoCreatureSound(Actor akSpeaker, String SoundType)
	VoiceType Voice = akSpeaker.GetVoiceType()
	If Voice == CrHorseVoice
		If SoundType == "Yes"
			_SLS_HorseNeigh.Play(akSpeaker)
		EndIf
		
	Else ; Everything else
	
	EndIf
EndFunction

Function InitFondleableVoices()
	_SLS_FondleableVoices.Revert()
	Int i = JsonUtil.FormlistCount("SL Survival/FondleableVoices.json", "skyrimvoices")
	While i > 0
		i -= 1
		_SLS_FondleableVoices.AddForm(JsonUtil.FormlistGet("SL Survival/FondleableVoices.json", "skyrimvoices", i))
	EndWhile
	
	If Game.GetModByName("Dawnguard.esm") != 255
		i = JsonUtil.FormlistCount("SL Survival/FondleableVoices.json", "dawnguardvoices")
		While i > 0
			i -= 1
			_SLS_FondleableVoices.AddForm(JsonUtil.FormlistGet("SL Survival/FondleableVoices.json", "dawnguardvoices", i))
		EndWhile
	EndIf
	
	If Game.GetModByName("Dragonborn.esm") != 255
		i = JsonUtil.FormlistCount("SL Survival/FondleableVoices.json", "dragonbornvoices")
		While i > 0
			i -= 1
			_SLS_FondleableVoices.AddForm(JsonUtil.FormlistGet("SL Survival/FondleableVoices.json", "dragonbornvoices", i))
		EndWhile
	EndIf
	
	i = JsonUtil.FormlistCount("SL Survival/FondleableVoices.json", "customvoices")
	While i > 0
		i -= 1
		_SLS_FondleableVoices.AddForm(JsonUtil.FormlistGet("SL Survival/FondleableVoices.json", "customvoices", i))
	EndWhile
EndFunction

Int Function BeginOverlay(Actor akTarget, Float Alpha, String TextureToApply, String Area, Int SlotToUse = -1)
	Bool Gender = akTarget.GetLeveledActorBase().GetSex() as Bool
	Debug.Trace("_SLS_: Applying overlay " + TextureToApply + " to " + akTarget.GetBaseObject().GetName())
	Return ReadyOverlay(akTarget, Gender, Area, SlotToUse, TextureToApply, Alpha)
EndFunction

Int Function ReadyOverlay(Actor akTarget, Bool Gender, String Area, Int SlotToUse = -1, String TextureToApply, Float Alpha)
	If SlotToUse == -1
		SlotToUse = GetEmptySlot(akTarget, Gender, Area)
	EndIf
	If SlotToUse != -1
		ApplyOverlay(akTarget, Gender, Area, SlotToUse, TextureToApply, Alpha)
	Else
		Debug.Trace("_SLS_: Error applying overlay to area: " + Area)
	EndIf
	Return SlotToUse
EndFunction

Function ApplyOverlay(Actor akTarget, Bool Gender, String Area, String OverlaySlot, String TextureToApply, Float Alpha)
	String Node = Area + " [ovl" + OverlaySlot + "]"
	ApplyOverlayAtNode(akTarget, Gender, Area + " [ovl" + OverlaySlot + "]", TextureToApply, Alpha)
EndFunction

Function ApplyOverlayAtNode(Actor akTarget, Bool Gender, String Node, String TextureToApply, Float Alpha)
	;/
	If !NiOverride.HasOverlays(akTarget)
		NiOverride.AddOverlays(akTarget)
	EndIf
	NiOverride.AddNodeOverrideString(akTarget, Gender, Node, 9, 0, TextureToApply, TRUE)
	NiOverride.AddNodeOverrideInt(akTarget, Gender, Node, 0, 0, 0, TRUE) ; Emissive color
	NiOverride.AddNodeOverrideInt(akTarget, Gender, Node, 7, 0, 0, TRUE) ; Tint color
	
	NiOverride.AddNodeOverrideInt(akTarget, Gender, Node, 0, -1, 0, TRUE) ; Emissive color
	NiOverride.AddNodeOverrideInt(akTarget, Gender, Node, 7, -1, 0, TRUE) ; Tint color
   
    NiOverride.AddNodeOverrideFloat(akTarget, Gender, Node, 8, -1, Alpha, TRUE) ; ShaderAlpha
	NiOverride.AddNodeOverrideFloat(akTarget, Gender, Node, 2, -1, 0.0, TRUE) ; ShaderGlossiness
	NiOverride.AddNodeOverrideFloat(akTarget, Gender, Node, 3, -1, 0.0, TRUE) ; ShaderSpecularStrength
	NiOverride.ApplyNodeOverrides(akTarget)
	Debug.Trace("_SLS_: Applied overlay at node: " + Node + " on target: " + akTarget.GetLeveledActorBase().GetName())
	/;
	ApplyOverlayAtNodeWithColors(akTarget, Gender, Node, TextureToApply, Alpha, TintColor = 0, EmissiveColor = 0)
EndFunction

Function ApplyOverlayAtNodeWithColors(Actor akTarget, Bool Gender, String Node, String TextureToApply, Float Alpha, Int TintColor, Int EmissiveColor)
	; AddNodeOverrideInt(ObjectReference ref, bool isFemale, string node, int key, int index, int value, bool persist)
	
	; Valid keys
	; ID - TYPE - Name
	; 0 - int - ShaderEmissiveColor
	; 1 - float - ShaderEmissiveMultiple
	; 2 - float - ShaderGlossiness
	; 3 - float - ShaderSpecularStrength
	; 4 - float - ShaderLightingEffect1
	; 5 - float - ShaderLightingEffect2
	; 6 - TextureSet - ShaderTextureSet
	; 7 - int - ShaderTintColor
	; 8 - float - ShaderAlpha
	; 9 - string - ShaderTexture (index 0-8)
	; 20 - float - ControllerStartStop (-1.0 for stop, anything else indicates start time)
	; 21 - float - ControllerStartTime
	; 22 - float - ControllerStopTime
	; 23 - float - ControllerFrequency
	; 24 - float - ControllerPhase
	
	; Indexes are for controller index (0-255)
	; -1 indicates not relevant, use it when not using controller based properties

	If !NiOverride.HasOverlays(akTarget)
		NiOverride.AddOverlays(akTarget)
	EndIf
	NiOverride.AddNodeOverrideString(akTarget, Gender, Node, 9, 0, TextureToApply, TRUE)
	
	NiOverride.AddNodeOverrideInt(akTarget, Gender, Node, 0, 0, EmissiveColor, TRUE) ; Emissive color
	NiOverride.AddNodeOverrideInt(akTarget, Gender, Node, 7, 0, TintColor, TRUE) ; Tint color
	
	NiOverride.AddNodeOverrideInt(akTarget, Gender, Node, 0, -1, EmissiveColor, TRUE) ; Emissive color
	NiOverride.AddNodeOverrideInt(akTarget, Gender, Node, 7, -1, TintColor, TRUE) ; Tint color
   
    NiOverride.AddNodeOverrideFloat(akTarget, Gender, Node, 8, -1, Alpha, TRUE) ; ShaderAlpha
	NiOverride.AddNodeOverrideFloat(akTarget, Gender, Node, 2, -1, 0.0, TRUE) ; ShaderGlossiness
	NiOverride.AddNodeOverrideFloat(akTarget, Gender, Node, 3, -1, 0.0, TRUE) ; ShaderSpecularStrength
	NiOverride.ApplyNodeOverrides(akTarget)
	Debug.Trace("_SLS_: Applied overlay at node: " + Node + " on target: " + akTarget.GetLeveledActorBase().GetName())
EndFunction

Function UpdateAlpha(Actor akTarget, Float Alpha, String TextureToUpdate, String Area) ; Unused
	Int Slot = GetOverlaySlot(akTarget, TextureToUpdate, Area)
	If Slot == -1
		BeginOverlay(akTarget, Alpha, TextureToUpdate, Area)
		Slot = GetOverlaySlot(akTarget, TextureToUpdate, Area)
		If Slot == -1
			Debug.Trace("_SLS_: Critical error getting spank overlay slot")
			Return
		EndIf
	EndIf

	;Debug.Trace("_SLS_: Update alpha on " + akTarget.GetBaseObject().GetName() + " to " + Alpha)
	String Node = Area + " [ovl" + Slot + "]"
	Bool Gender = akTarget.GetLeveledActorBase().GetSex() as Bool
	NiOverride.AddNodeOverrideFloat(akTarget, Gender, Node, 8, -1, Alpha, TRUE)
EndFunction

Int Function GetEmptySlot(Actor akTarget, Bool Gender, String Area)
	Int i = GetNumSlots(Area)
	String TexPath
	While i > 0
		i -= 1
		TexPath = NiOverride.GetNodeOverrideString(akTarget, Gender, Area + " [ovl" + i + "]", 9, 0)
		If TexPath == "" || TexPath == "actors\\character\\overlays\\default.dds"
			Debug.Trace("_SLS_: GetEmptySlot: Slot " + i + " chosen for area: " + area + " on " + akTarget.GetBaseObject().GetName())
			Return i
		EndIf
	EndWhile
	Debug.Trace("_SLS_: GetEmptySlot: Warning: Could not find a free slot in area: " + Area + " on "  + akTarget.GetBaseObject().GetName())
	Return -1
EndFunction

Int Function CountEmptySlots(Actor akTarget, String Area)
	Bool Gender = akTarget.GetLeveledActorBase().GetSex() as Bool
	Int Count
	Int i = GetNumSlots(Area)
	String TexPath
	While i > 0
		i -= 1
		TexPath = NiOverride.GetNodeOverrideString(akTarget, Gender, Area + " [ovl" + i + "]", 9, 0)
		If TexPath == "" || TexPath == "actors\\character\\overlays\\default.dds"
			Count += 1
		EndIf
	EndWhile
	Return Count
EndFunction

Int Function GetOverlaySlot(Actor akTarget, String TextureToUpdate, String Area)
	String Node
	;Bool Result = false	
	Bool Gender = akTarget.GetLeveledActorBase().GetSex() as Bool
	String MatchString = TextureToUpdate
	Int j = GetNumSlots(Area)
	While j > 0; && !Result
		j -= 1
		Node = Area + " [ovl" + j + "]"
		If NiOverride.GetNodeOverrideString(akTarget, Gender, Node, 9, 0) == MatchString
			Return j
		EndIf
	EndWhile
	Return -1
EndFunction

Bool Function HasOverlay(Actor akTarget, String TextureToUpdate, String Area)
	If GetOverlaySlot(akTarget, TextureToUpdate, Area) >= 0
		Return true
	EndIf
	Return false
EndFunction

Int Function RemoveOverlay(Actor akTarget, String TextureToRemove, String Area)
	Debug.Trace("_SLS_: RemoveOverlay : " + TextureToRemove + " called on " + akTarget.GetLeveledActorBase().GetName() + " from area: " + Area)
	Bool Gender = akTarget.GetActorBase().GetSex() as Bool
	String TexPath
	Int j = 0
	While j < GetNumSlots(Area)
		String Node = Area + " [ovl" + j + "]"
		TexPath = NiOverride.GetNodeOverrideString(akTarget, Gender, Node, 9, 0)
		If TexPath == TextureToRemove
			ClearOverlaySlot(akTarget, Gender, Node)
			Return j
		EndIf
		j += 1
	EndWhile
	Return -1
EndFunction

Function ClearOverlaySlot(Actor akTarget, Bool Gender, String Node)
	NiOverride.AddNodeOverrideString(akTarget, Gender, Node, 9, 0, "actors\\character\\overlays\\default.dds", true)
	NiOverride.RemoveNodeOverride(akTarget, Gender, Node, 9, 0)
	NiOverride.RemoveNodeOverride(akTarget, Gender, Node, 7, -1)
	NiOverride.RemoveNodeOverride(akTarget, Gender, Node, 0, -1)
	NiOverride.RemoveNodeOverride(akTarget, Gender, Node, 8, -1)
	NiOverride.RemoveNodeOverride(akTarget, Gender, Node, 2, -1)
	NiOverride.RemoveNodeOverride(akTarget, Gender, Node, 3, -1)
	Debug.Trace("_SLS_: Removing overlay from node " + Node + " on " + akTarget.GetLeveledActorBase().GetName())
EndFunction

Int Function GetNumSlots(String Area)
	If Area == "Body"
		Return NiOverride.GetNumBodyOverlays()
	ElseIf Area == "Face"
		Return NiOverride.GetNumFaceOverlays()
	ElseIf Area == "Hands"
		Return NiOverride.GetNumHandOverlays()
	Else
		Return NiOverride.GetNumFeetOverlays()
	EndIf
EndFunction

Function SendCombatChangeEvent(Bool InCombat)
	;Debug.Messagebox("InCombat: " + InCombat)
	Int CombatEvent = ModEvent.Create("_SLS_PlayerCombatChange")
    If (CombatEvent)
        ModEvent.PushBool(CombatEvent, InCombat)
        ModEvent.Send(CombatEvent)
    EndIf
	
	If !InCombat
		_SLS_FlyYouFoolsQuest.Stop()
	EndIf
EndFunction

Function StripCuirassOrBikini(Actor akTarget)
	Armor Cuirass 
	If _SLS_HalfNakedCoverQuest.IsRunning()
		Cuirass = akTarget.GetWornForm(HalfNaked.SlotMasks[(Menu.HalfNakedPanty - 30)]) as Armor
		If Cuirass
			If !Cuirass.HasKeyword(SexlabNoStrip)
				akTarget.UnequipItem(Cuirass)
				If Menu.DropItems
					;akTarget.DropObject(Cuirass)
					LostFound.DropItem(akTarget, Cuirass)
				EndIf
			EndIf
		EndIf
		Cuirass = akTarget.GetWornForm(HalfNaked.SlotMasks[(Menu.HalfNakedBra - 30)]) as Armor
		If Cuirass
			If !Cuirass.HasKeyword(SexlabNoStrip)
				akTarget.UnequipItem(Cuirass)
				If Menu.DropItems
					;akTarget.DropObject(Cuirass)
					LostFound.DropItem(akTarget, Cuirass)
				EndIf
			EndIf
		EndIf
	EndIf
	
	Cuirass = akTarget.GetWornForm(0x00000004) as Armor
	If Cuirass
		If !Cuirass.HasKeyword(SexlabNoStrip) && !Cuirass.HasKeyword(_SLS_HalfNakedCoverKw)
			akTarget.UnequipItem(Cuirass)
			If Menu.DropItems
				;akTarget.DropObject(Cuirass)
				LostFound.DropItem(akTarget, Cuirass)
			EndIf
		EndIf
	EndIf
EndFunction

Function StripBodyClothesTo(ObjectReference Receiver, Bool DoAnimation = true)
	Armor Cuirass = PlayerRef.GetWornForm(0x00000004) as Armor
	If Cuirass
		If Cuirass.IsPlayable() && !Cuirass.HasKeyword(SexlabNoStrip) && !Devious.IsDeviousInvDevice(Cuirass)
			If DoAnimation
				Debug.SendAnimationEvent(PlayerRef, "Arrok_Undress_G1")
				Utility.Wait(1.0)
			EndIf
			PlayerRef.RemoveItem(Cuirass, 1, false, Receiver)
		
		Else
			Debug.Trace("_SLS_: StripBodyClothesTo: Armor is a devious device or is not playable")
		EndIf
		
	Else
		Debug.Trace("_SLS_: StripBodyClothesTo: No body clothes/armor found")
	EndIf
EndFunction

Function SendDoRandomSpankEvent(Float Timeout, Bool AllowNpcInFurniture)
	int SpankEvent = ModEvent.Create("STA_DoRandomNpcSpank")
	
	if (SpankEvent)
		ModEvent.PushFloat(SpankEvent, Timeout)
		ModEvent.PushBool(SpankEvent, AllowNpcInFurniture)
		ModEvent.PushFloat(SpankEvent, Menu.AssSlapResistLoss * _SLS_CoveringNakedStatus.GetValueInt())
		ModEvent.Send(SpankEvent)
	endIf
EndFunction

Function SendDoSpecificNpcSpankEvent(Float Timeout, Bool AllowNpcInFurniture, Actor akActor, Bool DialogWait = true)
	; AllowNpcInFurniture needs to be removed?!?!?!?!?!??!?!?!?!?!?!?!?!?!?!?!?!?!?!?!?!!?!?!?!?!?!?!?!?!?!?!?!?!?!???!?!?
	
	If DialogWait
		While UI.IsMenuOpen("Dialogue Menu")
			Utility.Wait(0.05)
		EndWhile
	EndIf
	Int SpankEvent = ModEvent.Create("STA_DoNpcSpankSpecific")
	If (SpankEvent)
		ModEvent.PushFloat(SpankEvent, Timeout)
		ModEvent.PushForm(SpankEvent, (akActor as Form))
		ModEvent.PushBool(SpankEvent, ProxSpankComment)
		ModEvent.PushFloat(SpankEvent,  Menu.AssSlapResistLoss * _SLS_CoveringNakedStatus.GetValueInt())
		ModEvent.Send(SpankEvent)
	EndIf
EndFunction

Function SendDoSpecificNpcSpankEventCustom(Float Timeout, Bool AllowNpcInFurniture, Actor akActor, Bool DialogWait = true)
	If DialogWait
		While UI.IsMenuOpen("Dialogue Menu")
			Utility.Wait(0.05)
		EndWhile
	EndIf
	Int SpankEvent = ModEvent.Create("STA_DoNpcSpankSpecific")
	If (SpankEvent)
		ModEvent.PushFloat(SpankEvent, Timeout)
		ModEvent.PushForm(SpankEvent, (akActor as Form))
		ModEvent.PushForm(SpankEvent, (None))
		ModEvent.PushForm(SpankEvent, (None)) ; Need to add end topic here!
		ModEvent.PushFloat(SpankEvent,  Menu.AssSlapResistLoss * _SLS_CoveringNakedStatus.GetValueInt())
		ModEvent.Send(SpankEvent)
	EndIf
EndFunction

Function SuspendSwAddicted()
	Int Suspend = ModEvent.Create("PlayerTrack_Start")
    If (Suspend)
        ModEvent.PushForm(Suspend, Self)
        ModEvent.PushInt(Suspend, -1)
        ModEvent.Send(Suspend)
    EndIf
EndFunction

Function ResumeSwAddicted()
	Int Resume = ModEvent.Create("PlayerTrack_End")
    If (Resume)
        ModEvent.PushForm(Resume, Self)
        ModEvent.PushInt(Resume, -1)
        ModEvent.Send(Resume)
    EndIf
EndFunction

Function PlayerReadysWeapon(Bool WeapReadiedDelayed)
	SendModEvent(eventName = "_SLS_IntWeaponReadied", strArg = "", numArg = 0.0)
	; WeapReadiedDelayed - Weapon is still readied after x seconds, allows a certain amount of grace.
	If WeapReadiedDelayed
		StartWeaponDrawnDetection()
	EndIf
EndFunction

Function PlayerUnreadysWeapon()
	;Debug.messagebox("State: " + MinAv.GetState())
	;Debug.Messagebox("Unready weapon")
	_SLS_GuardWarnWeapDrawnQuest.Stop()
	If Menu.MinAvToggleT
		MinAv.ForceUpdate()
	EndIf
EndFunction

Function StartWeaponDrawnDetection()
	If Menu.GuardBehavWeapDrawn
		_SLS_GuardWarnWeapDrawnQuest.Start()
		;/
		_SLS_GuardWarnDoApproach.SetValueInt(0) ; Disable approach until it can be determined whether to do initial warning or punishment. Avoids guards greeting you with nothing to say if started close to a guard (timing issue)
		_SLS_GuardWarnWeapDrawnDetectionQuest.Stop()
		_SLS_GuardWarnWeapDrawnDetectionQuest.Start()
		Actor Guard = (_SLS_GuardWarnWeapDrawnDetectionQuest.GetNthAlias(0) as ReferenceAlias).GetReference() as Actor
		If Guard ; Detected
			If Guard.IsInFaction(_SLS_GuardBehaviourWarningFact)
				_SLS_GuardWarnWeapDrawnDetectionQuest.Stop()
				SendBeginGuardWarnPunishEvent(_SLS_GuardWarnWeapDrawnDetectionQuest, Guard)
			EndIf
			_SLS_GuardWarnDoApproach.SetValueInt(1)
			Guard.EvaluatePackage()
			Return true
		Else ; Not detected
			Return false
		EndIf
		/;
	EndIf
EndFunction

Function ModArousal(Actor akActor, Float Amount)
    Int ModArousalEvent = ModEvent.Create("slaUpdateExposure")
    ModEvent.PushForm(ModArousalEvent, akActor)
    ModEvent.PushFloat(ModArousalEvent, Amount)
    ModEvent.Send(ModArousalEvent)
EndFunction

Function FondleMakeHarder(Actor akTarget)
	FadeToBlack.Apply()
	Int ArousalBefore = akTarget.GetFactionRank(Game.GetFormFromFile(0x03FC36, "SexLabAroused.esm") as Faction)
	ModArousal(akTarget, CreatureFondleCount + 2.0)
	Utility.Wait(2.0)
	PassHours(0.5)
	Int ArousalAfter = akTarget.GetFactionRank(Game.GetFormFromFile(0x03FC36, "SexLabAroused.esm") as Faction)
	Debug.Messagebox("You spend some time stroking his enormous member with your hands, grinding your ass against him and teasing him with your mouth and tongue.\n\nYou've increased his arousal by " + (ArousalAfter - ArousalBefore) + " points. \nNew arousal: " + ArousalAfter)
EndFunction
;/
Function ModDfDebt(Float Amount) ; +Amount = add debt, -Amount = Remove debt
	If Init.DflowInstalled
		GlobalVariable Debt = Game.GetFormFromFile(0x00C54F, "DeviousFollowers.esp") as GlobalVariable
		Float CurDebt = Debt.GetValue()
		CurDebt += Amount
		If CurDebt < 0
			CurDebt = 0
		EndIf
		Debt.SetValue(CurDebt)
	EndIf
EndFunction
/;

Function PassHours(Float Hours)
	Float Time = GameHour.GetValue()
	Time += Hours
	If Time > 23.99
		Time = 23.99
	EndIf
	GameHour.SetValue(Time)
EndFunction

Function IncreaseBounty(Actor akActor, Int Bounty, Bool Verbose = true)
	; Increase the players bounty with akActors crime faction
	Faction CrimeFact = akActor.GetCrimeFaction()
	If CrimeFact
		CrimeFact.ModCrimeGold(aiAmount = Bounty, abViolent = false)
		If Verbose
			Debug.Notification("Your bounty has increased by " + Bounty + " septims")
		EndIf
	Else
		Debug.Trace("_SLS_: Failed to get crime faction for: " + akActor.GetActorBase().GetName() + " - " + akActor)
	EndIf	
EndFunction

Function IncreaseFame(String FameType, Int Points)
	; Indirect but function provided here as Util is handier to access. 

	; Fame types: 
	; Whore
	; Slut
	; Slave
	; Beast
	; Skooma
	
	SexFame.IncreaseSexFame(FameType, Points)
EndFunction

Function DecResistWithSeverity(Float Amount = 1.0, Bool DoNotify = true, String Severity)
	Dflow.DecResistWithSeverity(Amount, DoNotify, Severity)
EndFunction

Function BegSelfDegradationResistLoss()
	Dflow.DecResistWithSeverity(Amount = 5.0, DoNotify = true, Severity = "1")
EndFunction

Function StripAll(Actor akActor, Bool Drop, Bool DoAnim)
	If StripBody(akActor, Drop, DoAnim)
		Utility.Wait(Utility.RandomFloat(0.4, 0.8))
	EndIf
	If StripBraAndPanty(akActor, Drop, DoAnim)
		Utility.Wait(Utility.RandomFloat(0.4, 0.8))
	EndIf
	If StripFeet(akActor, Drop, false)
		Utility.Wait(Utility.RandomFloat(0.4, 0.8))
	EndIf
	If StripHands(akActor, Drop, false)
		Utility.Wait(Utility.RandomFloat(0.4, 0.8))
	EndIf
	If StripHead(akActor, Drop, false)
		Utility.Wait(Utility.RandomFloat(0.4, 0.8))
	EndIf
EndFunction

Bool Function StripBody(Actor akActor, Bool Drop, Bool DoAnim)
	Form ArmorSelect = akActor.GetWornForm(0x00000004)
	If ArmorSelect != None  && !ArmorSelect.HasKeyword(SexlabNoStrip)
		If DoAnim
			Debug.SendAnimationEvent(akActor, "Arrok_Undress_G1")
			Utility.Wait(1.5)
		EndIf
		If Drop
			;akActor.DropObject(ArmorSelect, 1)
			LostFound.DropItem(akActor, ArmorSelect)
		Else
			akActor.UnequipItem(ArmorSelect)
		EndIf
		Return true
	EndIf
	Return false
EndFunction

Bool Function StripBraAndPanty(Actor akActor, Bool Drop, Bool DoAnim)
	Bool FoundUndies = false
	If _SLS_HalfNakedCoverQuest.IsRunning()
		; Strip bra
		Form akUnderwear = akActor.GetWornForm(HalfNaked.SlotMasks[(Menu.HalfNakedBra - 30)])
		Bool DidAnim = false
		
		If akUnderWear && !akUnderWear.HasKeyword(SexlabNoStrip)
			FoundUndies = true
			If DoAnim
				Debug.SendAnimationEvent(akActor, "Arrok_Undress_G1")
				DidAnim = true
				Utility.Wait(1.5)
			EndIf
			If Drop
				;akActor.DropObject(akUnderwear, 1)
				LostFound.DropItem(akActor, akUnderwear)
			Else
				akActor.UnequipItem(akUnderwear)
			EndIf
		EndIf
		
		; Strip panty
		akUnderwear = akActor.GetWornForm(HalfNaked.SlotMasks[(Menu.HalfNakedPanty - 30)])
		If akUnderWear && !akUnderWear.HasKeyword(SexlabNoStrip)
			FoundUndies = true
			If DoAnim && !DidAnim
				Debug.SendAnimationEvent(akActor, "Arrok_Undress_G1")
				Utility.Wait(1.5)
			EndIf
			If Drop
				;akActor.DropObject(akUnderwear, 1)
				LostFound.DropItem(akActor, akUnderwear)
			Else
				akActor.UnequipItem(akUnderwear)
			EndIf
		EndIf
	EndIf
	Return FoundUndies
EndFunction

Bool Function StripFeet(Actor akActor, Bool Drop, Bool DoAnim)
	Form ArmorSelect = akActor.GetWornForm(0x00000080)
	If ArmorSelect != None && !ArmorSelect.HasKeyword(SexlabNoStrip)
		If DoAnim
			Debug.SendAnimationEvent(akActor, "Arrok_Undress_G1")
			Utility.Wait(1.5)
		EndIf
		If Drop
			;akActor.DropObject(ArmorSelect, 1)
			LostFound.DropItem(akActor, ArmorSelect)
		Else
			akActor.UnequipItem(ArmorSelect)
		EndIf
		Return true
	EndIf
	Return false
EndFunction

Bool Function StripHands(Actor akActor, Bool Drop, Bool DoAnim)
	Form ArmorSelect = akActor.GetWornForm(0x00000008)
	If ArmorSelect != None && !ArmorSelect.HasKeyword(SexlabNoStrip)
		If DoAnim
			Debug.SendAnimationEvent(akActor, "Arrok_Undress_G1")
			Utility.Wait(1.5)
		EndIf
		If Drop
			;akActor.DropObject(ArmorSelect, 1)
			LostFound.DropItem(akActor, ArmorSelect)
		Else
			akActor.UnequipItem(ArmorSelect)
		EndIf
		Return true
	EndIf
	Return false
EndFunction

Bool Function StripHead(Actor akActor, Bool Drop, Bool DoAnim)
	Form ArmorSelect = akActor.GetWornForm(0x00000002)
	If ArmorSelect != None && !ArmorSelect.HasKeyword(SexlabNoStrip)
		If DoAnim
			Debug.SendAnimationEvent(akActor, "Arrok_Undress_G1")
			Utility.Wait(1.5)
		EndIf
		If Drop
			;akActor.DropObject(ArmorSelect, 1)
			LostFound.DropItem(akActor, ArmorSelect)
		Else
			akActor.UnequipItem(ArmorSelect)
		EndIf
		Return true
	EndIf
	Return false
EndFunction

Function GuardWarnPlayer(Actor Guard)
	If Guard
		If !Guard.IsInFaction(_SLS_GuardBehaviourWarningFact)
			Guard.AddToFaction(_SLS_GuardBehaviourWarningFact)
			Guard.ModFactionRank(_SLS_GuardBehaviourWarningFact, 1)
		Else ; Might do more severe punishments or something later if number of warnings is greater than x...
			Guard.ModFactionRank(_SLS_GuardBehaviourWarningFact, 1)
		EndIf
	Else
		Debug.Trace("_SLS_: GuardWarnPlayer: Received a none")
	EndIf
EndFunction

Function StopGuardWarning()
	_SLS_GuardWarnedQuest.Stop()
	WIRemoveItem01.Stop()
	WICastMagicQuest03.Stop()
EndFunction

Function DoGuardWarningOutcome(Actor akSpeaker)
;/
	If Init.GuardWarnedOutcome == 0 ; Skooma
		SuspendSwAddicted()
		SwallowRandomDrugs(2)
		Utility.Wait(0.5)
		ResumeSwAddicted()
	ElseIf Init.GuardWarnedOutcome == 1 ; Lactacid
		SuspendSwAddicted()
		SwallowLactacid(2)
		Utility.Wait(0.5)
		ResumeSwAddicted()
	/;
	If Init.GuardWarnedOutcome <= 1 ; Drugs
		(Game.GetFormFromFile(0x000D64, "SL Survival.esp") as _SLS_ForcedDrugging).DoRapeDrugs(PlayerRef, Quantity = 2, Silent = false)
	ElseIf Init.GuardWarnedOutcome == 2 ; Devices
		Devious.EquipRandomDds(PlayerRef, 3)
	ElseIf Init.GuardWarnedOutcome == 3 ; Kennel
		SendToKennel(akSpeaker)
	ElseIf Init.GuardWarnedOutcome == 4 ; Bribe
		PlayerRef.RemoveItem(Gold001, 100)
	ElseIf Init.GuardWarnedOutcome == 5 ; Stocks
	
	ElseIf Init.GuardWarnedOutcome == 6 ; Ground
		IncreaseGroundTime(akSpeaker, LocInt = -1, Days = 1)
	ElseIf Init.GuardWarnedOutcome == 7 ; Bounty
		IncreaseBounty(akSpeaker, 200, Verbose = true)
	EndIf
EndFunction

Function IncreaseGroundTime(Actor akSpeaker, Int LocInt = -1, Int Days)
	; LocInt: 0 - Whiterun, 1 - Solitude, 2 - Markarth, 3 - Windhelm, 4 - Riften
	Faction CrimeFact = None
	If akSpeaker
		CrimeFact = akSpeaker.GetCrimeFaction()
	EndIf
	Float CurTime = Utility.GetCurrentGameTime()
	Float GroundTime

	If CrimeFact == CrimeFactionWhiterun || LocInt == 0 ; Whiterun
		GroundTime = TollUtil.GroundedUntilWhiterun
	ElseIf CrimeFact == CrimeFactionHaafingar || LocInt == 1 ; Solitude
		GroundTime = TollUtil.GroundedUntilSolitude
	ElseIf CrimeFact == CrimeFactionReach || LocInt == 2 ; Markarth
		GroundTime = TollUtil.GroundedUntilMarkarth
	ElseIf CrimeFact == CrimeFactionEastmarch || LocInt == 3 ; Windhelm
		GroundTime = TollUtil.GroundedUntilWindhelm
	ElseIf CrimeFact == CrimeFactionRift || LocInt == 4 ; Riften
		GroundTime = TollUtil.GroundedUntilRiften
	Else
		Debug.Trace("_SLS_: IncreaseGroundTime: Unknown crime faction: " + CrimeFact + " or LocInt: " + LocInt)
		Return
	EndIf

	If GroundTime > CurTime ; then add another day
		GroundTime += Days
	Else ; Set to current day + 1
		GroundTime = (CurTime + Days) as Int
	EndIf
	
	If CrimeFact == CrimeFactionWhiterun || LocInt == 0 ; Whiterun
		TollUtil.GroundedUntilWhiterun = GroundTime
	ElseIf CrimeFact == CrimeFactionHaafingar || LocInt == 1 ; Solitude
		TollUtil.GroundedUntilSolitude = GroundTime
	ElseIf CrimeFact == CrimeFactionReach || LocInt == 2 ; Markarth
		TollUtil.GroundedUntilMarkarth = GroundTime
	ElseIf CrimeFact == CrimeFactionEastmarch || LocInt == 3 ; Windhelm
		TollUtil.GroundedUntilWindhelm = GroundTime
	ElseIf CrimeFact == CrimeFactionRift || LocInt == 4 ; Riften
		TollUtil.GroundedUntilRiften = GroundTime
	EndIf
	TollUtil.RecheckGateConditions()
EndFunction

Function SwallowRandomDrugs(Int Count)
	Form SwDrug
	While Count > 0
		Count -= 1
		SwDrug = Init._SLS_DrugsListWoLactacid.GetAt(Utility.RandomInt(0,((Init._SLS_DrugsListWoLactacid.GetSize()) - 1)))
		PlayerRef.AddItem(SwDrug, 1, abSilent = true)
		PlayerRef.EquipItem(SwDrug, abSilent = true)
	EndWhile
EndFunction

Function SwallowLactacid(Int Count)
	While Count > 0
		Count -= 1
		PlayerRef.EquipItem(Init.MME_Lactacid, abSilent = true)
	EndWhile
EndFunction

Function SendToKennel(Actor akActor = None, String Hold = "")
	ObjectReference DoorRef = GetKennelDoorRef(akActor, Hold)
	If DoorRef
		(DoorRef as SLS_KennelOutsideDoorScript).OnActivate(PlayerRef)
		KennelKeeper.EquipDevices()
		Init.KennelState = 2
		KennelKeeper.AcceptDeal(false)
	Else
		Debug.Trace("_SLS_: SendToKennel() Failed. akActor: " + akActor + ". Hold: " + Hold)
	EndIf
EndFunction

ObjectReference Function GetKennelDoorRef(Actor akActor, String Hold)
	If akActor
		Faction CrimeFact = akActor.GetCrimeFaction()
		If CrimeFact
			Int i = _SLS_CrimeFactionsList.Find(CrimeFact)
			If i > -1
				Return _SLS_KennelOutsideDoors.GetAt(i) as ObjectReference
			EndIf
		EndIf
		Debug.Trace("_SLS_: GetKennelDoorRef(): Faction not determined for: " + akActor + ". CrimeFact: " + CrimeFact)
		
	Else
		If Hold == "Whiterun"
			Return _SLS_KennelOutsideDoors.GetAt(0) as ObjectReference
		ElseIf Hold == "Solitude"
			Return _SLS_KennelOutsideDoors.GetAt(1) as ObjectReference
		ElseIf Hold == "Markarth"
			Return _SLS_KennelOutsideDoors.GetAt(2) as ObjectReference
		ElseIf Hold == "Windhelm"
			Return _SLS_KennelOutsideDoors.GetAt(3) as ObjectReference
		ElseIf Hold == "Riften"
			Return _SLS_KennelOutsideDoors.GetAt(4) as ObjectReference
		Else
			Debug.Trace("_SLS_: GetKennelDoorRef(): Hold not found: " + Hold)
		EndIf
	EndIf
	Return None
EndFunction

Function CloseLockpickMenu()
	While UI.IsMenuOpen("Lockpicking Menu")
		;UI.InvokeString("Lockpicking Menu", "_root.Menu_mc.onExitButtonPress", "") ; Didn't work
		Input.TapKey(Input.GetMappedKey("Tween Menu", DeviceType = 0xFF))
		Utility.WaitMenuMode(0.1)
	EndWhile
EndFunction

Function SendChainQuestsEvent(Quest QuestToStop, Quest QuestToStart)
	Int ChainQuests = ModEvent.Create("_SLS_Int_ChainQuestsEvent")
	If (ChainQuests)
		ModEvent.PushForm(ChainQuests, QuestToStop)
		ModEvent.PushForm(ChainQuests, QuestToStart)
		ModEvent.Send(ChainQuests)
	EndIf
EndFunction

Function SendBeginGuardWarnPunishEvent(Quest QuestToStop, Actor Guard)
	Int ChainQuests = ModEvent.Create("_SLS_Int_BeginGuardWarnPunishEvent")
	If (ChainQuests)
		ModEvent.PushForm(ChainQuests, QuestToStop)
		ModEvent.PushForm(ChainQuests, Guard)
		ModEvent.Send(ChainQuests)
	EndIf
EndFunction

Function StopAllGuardWarnApproachQuests(Actor akSpeaker, Bool DoCooldown = true)
	; Because some quests aren't stopping and I can't figure out why. WICastMagicQuest03
	
	_SLS_GuardWarnDoApproach.SetValueInt(0)
	WICastMagicQuest03.Stop()
	WIRemoveItem01.Stop()
	_SLS_GuardWarnedQuest.Stop()
	_SLS_GuardWarnPickDetectionQuest.Stop()
	_SLS_GuardWarnDrugDetectionQuest.Stop()
	_SLS_GuardWarnWeapDrawnQuest.Stop()
	_SLS_GuardWarnWeapDrawnDetectionQuest.Stop()
	_SLS_GuardWarnArmorEquippedDetectQuest.Stop()
	_SLS_GuardWarnWeapEquippedDetectQuest.Stop()
	If akSpeaker
		akSpeaker.RemoveFromFaction(_SLS_GuardWarnApproachFact)
		akSpeaker.EvaluatePackage()
	EndIf
	If DoCooldown
		BeginGuardWarnCooldown()
	EndIf
EndFunction

Function BeginGuardWarnCooldown()
	_SLS_GuardWarnCooldownQuest.Stop()
	_SLS_GuardWarnCooldownQuest.Start()
EndFunction

;/
Function NotifyGuardPunishInfraction(Int Type)
	If Type == 0
		Debug.Notification("You're being punished for dropping weapons")
	ElseIf Type == 1
		Debug.Notification("You're being punished for having weapons drawn")
	ElseIf Type == 2
		Debug.Notification("You're being punished for picking locks")
	ElseIf Type == 3
		Debug.Notification("You're being punished for consuming drugs")
	ElseIf Type == 4
		Debug.Notification("You're being punished for shouting")
	ElseIf Type == 5
		Debug.Notification("You're being punished for having armor equipped")
	ElseIf Type == 6
		Debug.Notification("You're being punished for having weapons equipped")
	
	ElseIf Type == 7
		Debug.Notification("You're being punished for ")
	ElseIf Type == 8
		Debug.Notification("You're being punished for ")
	ElseIf Type == 9
		Debug.Notification("You're being punished for ")
	
	EndIf
EndFunction
/;
Function UpdateAddictions()
	Main.UpdateMaAddictionPool()
	Main.UpdateSwDrugPool()
EndFunction

Function SetNumFreeDeviceSlots()
	Init.FreeDeviceSlots = Devious.GetNumFreeSlots(PlayerRef)
EndFunction

Function DoCatCall(Actor akSpeaker)
	Int CatCall = _SLS_CatCallsSM.Play(akSpeaker)
	Sound.SetInstanceVolume(CatCall, (Menu.CatCallVol / 100.0))
	If Menu.CatCallWillLoss > 0.0
		If !Dflow.IsOldDeviousFollowers()
			Dflow.DecDflowWill(Amount = (Menu.CatCallWillLoss * _SLS_CoveringNakedStatus.GetValueInt()), DoNotify = false)
		EndIf
	EndIf
EndFunction

Function PutWeaponAway(Actor akTarget)
	akTarget.SheatheWeapon()
EndFunction

Function ForbidBathing(Actor akTarget, String Notif)
	Int ForbidBathing = ModEvent.Create("BiS_ForbidBathing")
	If (ForbidBathing)
		ModEvent.PushForm(ForbidBathing, Self)
		ModEvent.PushForm(ForbidBathing, akTarget)
		ModEvent.PushString(ForbidBathing, Notif)
		ModEvent.Send(ForbidBathing)
	EndIf
EndFunction

Function PermitBathing(Actor akTarget)
	Int BiS_PermitBathing = ModEvent.Create("BiS_PermitBathing")
	If (BiS_PermitBathing)
		ModEvent.PushForm(BiS_PermitBathing, Self)
		ModEvent.PushForm(BiS_PermitBathing, akTarget)
		ModEvent.Send(BiS_PermitBathing)
	EndIf
EndFunction

Function GuardWarnPortToMilkMachine(Actor akSpeaker)
	SendModEvent("dhlp-Suspend")
	FadeToBlack.Apply()
	StopAllGuardWarnApproachQuests(akSpeaker, DoCooldown = false)
	akSpeaker.EvaluatePackage()
	ObjectReference Marker = _SLS_GuardWarnMilkMarkers.GetAt(_SLS_CrimeFactionsList.Find(akSpeaker.GetCrimeFaction())) as ObjectReference
	Devious.BeginForcedMilking()
	Utility.Wait(2.5)
	FadeToBlackHoldImod.Apply()
	While UI.IsMenuOpen("Dialogue Menu")
		Utility.Wait(0.2)
	EndWhile
	PlayerRef.MoveTo(Marker, afXOffset = 80.0, afYOffset = 0.0, afZOffset = 0.0, abMatchRotation = false)
	akSpeaker.MoveTo(Marker, afXOffset = 80.0, afYOffset = 120.0, afZOffset = 0.0, abMatchRotation = false)
	Utility.Wait(0.1)
	FadeToBlackHoldImod.Remove()
	GuardWarnMilkMachine = Marker.PlaceAtMe(Game.GetFormFromFile(0x034955, "MilkModNEW.esp"))
	Utility.Wait(0.5)
	_SLS_GuardWarnMilkPunishQuest.Start()
	(_SLS_GuardWarnMilkPunishQuest.GetNthAlias(0) as ReferenceAlias).ForceRefTo(akSpeaker)
	;Debug.Messagebox("SetStage, Current: " + _SLS_GuardWarnMilkPunishQuest.GetCurrentStageID() + "\nPack: " + akSpeaker.GetCurrentPackage())
	;_SLS_GuardWarnMilkPunishQuest.SetCurrentStageID(10)
	akSpeaker.EvaluatePackage()
EndFunction

Function GuardWarnGetInPump()
	SuspendSwAddicted()
	GuardWarnMilkMachine.Activate(PlayerRef)
	_SLS_ScreamForHelpSpectateQuest.Start()
EndFunction

Function GuardWarnMilkingEnd(Actor akSpeaker, Bool TakeMilk)
	If TakeMilk
		TakeAllMmeMilk(PlayerRef, akSpeaker as ObjectReference)
	EndIf
	GuardWarnMilkMachine.Disable()
	GuardWarnMilkMachine.Delete()
	GuardWarnMilkMachine = None
	Devious.EndForcedMilking()
	SendModEvent("dhlp-Resume")
EndFunction

Function TakeAllMmeMilk(Actor akTarget, ObjectReference akContainer = None)
	If Init.MmeInstalled
		Form akForm
		Keyword MME_Milk = Init.MME_Milk
		Int i = akTarget.GetNumItems()
		While i > 0
			i -= 1
			akForm = akTarget.GetNthForm(i)
			If akForm as Potion
				If akForm.HasKeyword(MME_Milk)
					akTarget.RemoveItem(akForm, akTarget.GetItemCount(akForm), abSilent = true, akOtherContainer = akContainer)
				EndIf
			EndIf
		EndWhile
	EndIf
EndFunction

Form[] Function GetFollowers()
	StorageUtil.FormListClear(Self, "_SLS_TempFollowerList")
	Actor Follower
	If Game.GetModByName("EFFCore.esm") != 255
		Formlist FollowerList = Game.GetFormFromFile(0x000F53, "EFFCore.esm") as Formlist
		Return FollowerList.ToArray()
		;/
		Int i = FollowerList.GetSize()
		While i > 0
			i -= 1
			Follower = FollowerList.GetAt(i) as Actor
			If Follower
				StorageUtil.FormListAdd(Self, "_SLS_TempFollowerList", Follower)
			EndIf
		EndWhile
		/;
	Else
		StorageUtil.FormListClear(Self, "_SLS_TempFollowerList")
		Int i = DialogueFollower.GetNumAliases()
		While i > 0
			i -= 1
			Follower = (DialogueFollower.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
			If Follower
				StorageUtil.FormListAdd(Self, "_SLS_TempFollowerList", Follower)
			EndIf
		EndWhile
	EndIf
	Return StorageUtil.FormListToArray(Self, "_SLS_TempFollowerList")
EndFunction

Function ProximityPush(Actor PushTarget, Actor Bully)
	PushTarget(PushTarget, Bully)
	(Game.GetFormFromFile(0x0E651A, "SL Survival.esp") as _SLS_PushPlayerCooloff).BeginCooloff()
EndFunction

Function CollidePush(Actor PushTarget, Actor Bully)
	PushTarget(PushTarget, Bully)
	(Game.GetFormFromFile(0x0E651A, "SL Survival.esp") as _SLS_PushPlayerCooloff).BeginCooloff()
EndFunction

Function PushTarget(Actor PushTarget, Actor Bully)
	Utility.Wait(0.2)
	Debug.SendAnimationEvent(Bully, "IdleTake")
	Int PushType = Menu.PushEvents
	If PushType  == 1
		DoStagger(PushTarget)
	ElseIf PushType == 2
		DoParalysis(PushTarget, Bully)
	ElseIf PushType == 3
		If Utility.RandomInt(0,100) > 50
			DoStagger(PushTarget)
		Else
			DoParalysis(PushTarget, Bully)
		EndIf
	EndIf
	Utility.Wait(1.0)
	If PushTarget == PlayerRef
		Debug.Notification(Bully.GetBaseObject().GetName() + ": Get out of my way " + GetAbuse() + "!")
	EndIf
EndFunction

Function DoStagger(Actor PushTarget)
	Debug.SendAnimationEvent(PushTarget, "staggerStart")
EndFunction

Function DoParalysis(Actor PushTarget, Actor Bully)
	If !PushTarget.IsInFaction(_SLS_NoParalyzeFact)
		Bully.PushActorAway(PushTarget, 1.5)
		;_SLS_PushPlayerSpell.Cast(PushTarget, PushTarget)
	EndIf
EndFunction

String Function GetAbuse()
	Int i = Utility.RandomInt(0, 4)
	If i == 0
		Return "woman"
	ElseIf i == 1
		Return "girl"
	ElseIf i == 2
		Return "bitch"
	ElseIf i == 3
		Return "slut"
	ElseIf i == 4
		Return "whore"
	EndIf
EndFunction

Bool Function IsDrugged(Actor akTarget, Bool CheckSkooma, Bool CheckSW, Bool CheckLactacid)
	If CheckSkooma && IsHighOnSkooma(akTarget)
		Return true
	EndIf
	If CheckSW && IsHighOnSkoomaWhoreDrugs(akTarget)
		Return true
	EndIf
	If CheckLactacid && IsHighOnLactacid(akTarget)
		Return true
	EndIf
	Return false
EndFunction

Bool Function IsHighOnSkooma(Actor akTarget)
	If Init.SkoomaWhoreInstalled
		Return akTarget.HasMagicEffect(Game.GetFormFromFile(0x0012D8, "SexLabSkoomaWhore.esp") as MagicEffect)
	Else
		Return akTarget.HasMagicEffect(Game.GetFormFromFile(0x03EB16, "Skyrim.esm") as MagicEffect)
	EndIf
EndFunction

Bool Function IsHighOnSkoomaWhoreDrugs(Actor akTarget)
	If Init.SkoomaWhoreInstalled
		Int i = 0
		MagicEffect Drug
		While i < _SLS_SkoomaWhoreMagicEffects.GetSize()
			Drug = _SLS_SkoomaWhoreMagicEffects.GetAt(i) as MagicEffect
			If akTarget.HasMagicEffect(Drug)
				Return true
			EndIf
			i += 1
		EndWhile
	EndIf
	Return false
EndFunction

Int Function GetSkoomaJunkieLevel(Actor akTarget, Bool IsWithdrawing)
	; IsWithdrawing: true - Withdrawal effect must be active. False - Don't care
	
	; Addiction Levels
	; 0 - Not addicted
	; 1 - Experimentation
	; 2 - Regular Use
	; 3 - Risky Use
	; 4 - Dependence
	; 5 - Addiction
	
	If Game.GetModByName("SexLabSkoomaWhore.esp") != 255
		Int AddictionLevel = (Game.GetFormFromFile(0x01441D, "SexLabSkoomaWhore.esp") as GlobalVariable).GetValueInt()
		If IsWithdrawing 
			If akTarget.HasMagicEffect(Game.GetFormFromFile(0x0012CB, "SexLabSkoomaWhore.esp") as MagicEffect)
				Return AddictionLevel
			Else
				Return 0
			EndIf
		Else
			Return AddictionLevel
		EndIf
	EndIf
	Return 0
EndFunction

Bool Function IsHighOnLactacid(Actor akTarget)
	If Init.MilkAddictInstalled
		Return akTarget.HasMagicEffect(Game.GetFormFromFile(0x0038A2, "Milk Addict.esp") as MagicEffect)
	EndIf
	Return false
EndFunction

Function SetupSwEffectsList()
	If Game.GetModByName("SexLabSkoomaWhore.esp") != 255
		_SLS_SkoomaWhoreMagicEffects.Revert()
		;_SLS_SkoomaWhoreMagicEffects.AddForm(Game.GetFormFromFile(0x0012D8, "SexLabSkoomaWhore.esp")) ; Skooma - Has it's own check
		_SLS_SkoomaWhoreMagicEffects.AddForm(Game.GetFormFromFile(0x01647A, "SexLabSkoomaWhore.esp")) ; Boethia's Deception
		_SLS_SkoomaWhoreMagicEffects.AddForm(Game.GetFormFromFile(0x017A32, "SexLabSkoomaWhore.esp")) ; Elendr's Flask
		;_SLS_SkoomaWhoreMagicEffects.AddForm(Game.GetFormFromFile(0x0012D8, "SexLabSkoomaWhore.esp")) ; Leaf Skooma - same as skooma
		_SLS_SkoomaWhoreMagicEffects.AddForm(Game.GetFormFromFile(0x019008, "SexLabSkoomaWhore.esp")) ; Mage's Friend
		_SLS_SkoomaWhoreMagicEffects.AddForm(Game.GetFormFromFile(0x018518, "SexLabSkoomaWhore.esp")) ; Morgul's Touch
		_SLS_SkoomaWhoreMagicEffects.AddForm(Game.GetFormFromFile(0x018FFA, "SexLabSkoomaWhore.esp")) ; Ocato's Pallatine
		_SLS_SkoomaWhoreMagicEffects.AddForm(Game.GetFormFromFile(0x014EE5, "SexLabSkoomaWhore.esp")) ; Rose of Azura
		_SLS_SkoomaWhoreMagicEffects.AddForm(Game.GetFormFromFile(0x019017, "SexLabSkoomaWhore.esp")) ; The Arch Mage
		_SLS_SkoomaWhoreMagicEffects.AddForm(Game.GetFormFromFile(0x017FA7, "SexLabSkoomaWhore.esp")) ; The Contortionist
		_SLS_SkoomaWhoreMagicEffects.AddForm(Game.GetFormFromFile(0x017A24, "SexLabSkoomaWhore.esp")) ; The Second Brain
		_SLS_SkoomaWhoreMagicEffects.AddForm(Game.GetFormFromFile(0x0174B4, "SexLabSkoomaWhore.esp")) ; Thiefs Delight
		_SLS_SkoomaWhoreMagicEffects.AddForm(Game.GetFormFromFile(0x018A88, "SexLabSkoomaWhore.esp")) ; Tough Flesh
		;_SLS_SkoomaWhoreMagicEffects.AddForm(Game.GetFormFromFile(0x01EBE5, "SexLabSkoomaWhore.esp")) ; Vermina's Price - Doesn't seem to have a lasting effect?
	EndIf
EndFunction

Function TownGroundSleepPunish(Actor Guard, Quest ApproachQuest)
	If Game.GetModByName("xazPrisonOverhaulPatched.esp") != 255
		Game.DisablePlayerControls()
		ApproachQuest.Stop()
		SendModEvent("xpoArrestPC", "", 2000)
	Else
		;(Guard.GetCrimeFaction()).ModCrimeGold(2000)
		;Utility.Wait(0.5)
		;Guard.StopCombatAlarm()
		;Guard.StopCombat()
		If !Devious.AreHandsAvailable(PlayerRef)
			Devious.MakeHandsAvailable(PlayerRef)
			Devious.EquipRandomDds(PlayerRef, Quantity = 3) ; Equip some other stuff to balance as we're not re-equipping the heavy bondage
		EndIf
		(Guard.GetCrimeFaction()).SendPlayerToJail()
		ApproachQuest.Stop()
	EndIf
EndFunction

Bool Function IsAnimating(Actor akTarget, Bool CheckCombat)
	If akTarget.IsInFaction(SexLabAnimatingFaction) || akTarget.GetSitState() != 0 || akTarget.IsInFaction(Init.zbfFactionAnimating) || akTarget.IsOnMount() || akTarget.IsSwimming() || akTarget.GetCurrentScene() != None || (CheckCombat && akTarget.IsInCombat()) || (CheckCombat && akTarget.IsWeaponDrawn())
		Return true
	EndIf
	Return false
EndFunction

Function DoFemalePainSound(Actor akActor, Float Volume)
	Int TraumaSound = _SLS_PainSM.Play(akActor)
	Sound.SetInstanceVolume(TraumaSound, Volume * PainSoundVol)
EndFunction

Function DoHitSound(Actor akActor, Float Volume)
	Int TraumaSound = _SLS_TraumaHitSM.Play(akActor)
	Sound.SetInstanceVolume(TraumaSound, Volume * HitSoundVol)
EndFunction

Function DoTraumaHitSound(Actor akActor, Bool PlayerSqueaks)
	; Sound.Play(ObjRef) appears to be a piece of shit and does not take into account the distance or direction from the player to the origin of the sound. So sounds always sound close-by. Great!
	Float Volume = (1.0 - (0.1 * (PlayerRef.GetDistance(akActor) / 128.0))) ; Reduce volume by 10% for every 128 units away from the player
	DoHitSound(akActor, Volume)
	If PlayerSqueaks && akActor == PlayerRef ;akActor.GetLeveledActorBase().GetSex() == 1
		DoFemalePainSound(akActor, Volume)
	EndIf
EndFunction

Float Function GetCumStuffedFactor(Actor akActor)
	; Return value 0.0 - 1.0 based on how Full of cum the actor is. Both vag and anal
	Float CumFilled = 0.0
	If Game.GetModByName("sr_FillHerUp.esp") != 255
		Float CumTotal = StorageUtil.GetFloatValue(akActor, "sr.inflater.cum.anal", missing = 0.0) + StorageUtil.GetFloatValue(akActor, "sr.inflater.cum.vaginal", missing = 0.0)
		Float CumMax = 1.0 ; Simple check that FHU is actually working first
		If CumTotal != 0.0
			CumMax = Fhu.GetCumCapacityMax()
		EndIf
		CumFilled = CumTotal / (CumMax * 2.0)
		If CumFilled > 1.0
			CumFilled = 1.0
		EndIf		
	EndIf
	Return CumFilled
EndFunction

Bool Function HasZazInvKeyword(Form akForm)
	Return akForm.HasKeyword(zbfWornDevice)
EndFunction

Function SlacExclude(Actor akActor, Bool Exclude)
	If Game.GetModByName("SexLab Aroused Creatures.esp") != 255
		If Exclude
			akActor.AddToFaction(Game.GetFormFromFile(0x08D7E9, "SexLab Aroused Creatures.esp") as Faction)
		Else
			akActor.RemoveFromFaction(Game.GetFormFromFile(0x08D7E9, "SexLab Aroused Creatures.esp") as Faction)
		EndIf
	EndIf
EndFunction

Bool Function GetIsTempReference(ObjectReference ObjRef)
	
EndFunction

sslBaseAnimation[] Property AnimsOral Auto Hidden
sslBaseAnimation[] Property AnimsAnal Auto Hidden
sslBaseAnimation[] Property AnimsVaginal Auto Hidden
sslBaseAnimation[] Property AnimsThreeP Auto Hidden
sslBaseAnimation[] Property AnimsFourP Auto Hidden

ObjectReference GuardWarnMilkMachine

Bool Property SlaxInstalled = false Auto Hidden
Bool Property ProxSpankComment = false Auto Hidden

Int Property PpLootLootMin = 0 Auto Hidden
Int Property PpLootLootMax = 8 Auto Hidden
Int Property LoadsSwallowed = 0 Auto Hidden
Int Property LoadsSwallowedHumanoid = 0 Auto Hidden
Int Property LoadsSpat = 0 Auto Hidden

Int Property BegSexCount = 0 Auto Hidden
Int Property BegCreatureSexCount = 0 Auto Hidden
Int Property BegBlowjobs = 0 Auto Hidden
Int Property BegLickings = 0 Auto Hidden
Int Property BegVagSex = 0 Auto Hidden
Int Property BegAnalSex = 0 Auto Hidden
Int Property BegDogSex = 0 Auto Hidden
Int Property BegWolfSex = 0 Auto Hidden
Int Property BegHorseSex = 0 Auto Hidden
Int Property BegGangbangs = 0 Auto Hidden

Float Property CreatureFondleCount = 0.0 Auto Hidden
Float Property LastLoadSize Auto Hidden
Float Property CumUnitsSwallowed = 0.0 Auto Hidden
Float Property CumUnitsSwallowedHumanoid = 0.0 Auto Hidden
Float Property CumUnitsSpat = 0.0 Auto Hidden
Float Property PainSoundVol = 0.5 Auto Hidden
Float Property HitSoundVol = 0.5 Auto Hidden

Sound Property _SLS_ScreamForHelpMarker Auto
Sound Property _SLS_GagTalkMarker Auto
Sound Property _SLS_CatCallsSM Auto

Quest Property _SLS_FlyYouFoolsQuest Auto
Quest Property _SLS_ScreamForHelpAliases Auto
Quest Property _SLS_ScreamForHelpCrazyBitchQuest Auto
Quest Property _SLS_ScreamForHelpSpectateQuest Auto
Quest Property _SLS_CreatureForceGreet Auto
Quest Property _SLS_CreatureSexSearchQuest Auto
Quest Property _SLS_HalfNakedCoverQuest Auto
Quest Property _SLS_AnimalFriendQuest Auto
Quest Property _SLS_CreatureFondlePacifyQuest Auto
Quest Property _SLS_GuardWarnedQuest Auto
Quest Property WIRemoveItem01 Auto
Quest Property WICastMagicQuest03 Auto ; There's a script by the same name
Quest Property _SLS_GuardWarnPickDetectionQuest Auto
Quest Property _SLS_GuardWarnDrugDetectionQuest Auto
Quest Property _SLS_GuardWarnWeapDrawnQuest Auto
Quest Property _SLS_GuardWarnWeapDrawnDetectionQuest Auto
Quest Property _SLS_GuardWarnArmorEquippedDetectQuest Auto
Quest Property _SLS_GuardWarnWeapEquippedDetectQuest Auto
Quest Property _SLS_GuardWarnCooldownQuest Auto
Quest Property _SLS_GuardWarnMilkPunishQuest Auto
Quest Property DialogueFollower Auto

ReferenceAlias Property GuardWarnedAlias Auto

Actor Property PlayerRef Auto

Faction Property SexLabAnimatingFaction Auto
Faction Property _SLS_ActiveSpankerFact Auto
Faction Property CreatureFaction Auto
Faction Property _SLS_NoParalyzeFact Auto
Faction Property _SLS_GuardWarnApproachFact Auto
Faction Property _SLS_GuardBehaviourWarningFact Auto
Faction Property CrimeFactionWhiterun Auto ; Whiterun
Faction Property CrimeFactionEastmarch Auto ; Windhelm
Faction Property CrimeFactionHaafingar Auto ; Solitude
Faction Property CrimeFactionReach Auto ; Markarth
Faction Property CrimeFactionRift Auto ; Riften

MiscObject Property Gold001 Auto
MiscObject Property _SLS_IncPickPocketLootToken Auto

Message Property _SLS_LoadSizeQueryMsg Auto

Formlist Property _SLS_CumList_z_SetForms Auto
Formlist Property _SLS_CumList_a_All Auto
Formlist Property _SLS_CreatureGangVoices Auto ; Used in search aliases
Formlist Property _SLS_FondleableVoices Auto
Formlist Property _SLS_CumHasLactacidVoices Auto
Formlist Property _SLS_CrimeFactionsList Auto
Formlist Property _SLS_GuardWarnMilkMarkers Auto
Formlist Property _SLS_KennelOutsideDoors Auto
Formlist Property _SLS_SkoomaWhoreMagicEffects Auto

LeveledItem Property _SLS_PpLootRootList Auto
LeveledItem Property _SLS_PpGoldRoot Auto

Spell Property _SLS_CumBreathScript Auto
Spell Property _SLS_ScreamCrazyBitchCooloffSpell Auto
Spell Property _SLS_PushPlayerSpell Auto

Sound Property _SLS_CumSwallowMarker Auto
Sound Property _SLS_CumSwallowSatisfiedMarker Auto
Sound Property _SLS_CumSwallowForcedMarker Auto
Sound Property _SLS_TraumaHitSM Auto
Sound Property _SLS_PainSM Auto

Sound Property _SLS_HorseNeigh Auto
Sound Property _SLS_HorseAgitated Auto
Sound Property _SLS_HorseSniffs Auto

VoiceType Property CrHorseVoice Auto

Keyword Property SexlabNoStrip Auto
Keyword Property _SLS_BikiniArmor Auto
Keyword Property _SLS_HalfNakedCoverKw Auto
Keyword Property zbfWornDevice Auto Hidden

ImageSpaceModifier Property FadeToBlack Auto
ImageSpaceModifier Property FadeToBlackHoldImod Auto

GlobalVariable Property GameHour Auto
GlobalVariable Property _SLS_GuardWarnDoApproach Auto
GlobalVariable Property _SLS_CoveringNakedStatus Auto
GlobalVariable Property _SLS_dhlpSuspend Auto
GlobalVariable Property _SLS_CreatureCorruptionGlob Auto

_SLS_AnimalFriend Property AnimalFriend Auto
SLS_Init Property Init Auto
SLS_Main Property Main Auto
SLS_Mcm Property Menu Auto
_SLS_Api Property Api Auto
_SLS_Needs Property Needs Auto
SexLabFramework Property Sexlab Auto
_SLS_InterfaceDevious Property Devious Auto
_SLS_InterfaceDeviousFollowers Property Dflow Auto
_SLS_HalfNakedCover Property HalfNaked Auto
SLS_MinAv Property MinAv Auto
SLS_KennelKeeper Property KennelKeeper Auto
_SLS_CumSwallow Property CumSwallow Auto
_SLS_CumAddict Property CumAddict Auto
_SLS_TollUtil Property TollUtil Auto
_SLS_LostFound Property LostFound Auto

_SLS_InterfaceFhu Property Fhu Auto
_SLS_InterfaceSlsf Property SexFame Auto
_SLS_InterfacePsq Property Psq Auto
