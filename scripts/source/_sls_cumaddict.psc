Scriptname _SLS_CumAddict extends Quest  

; _SLS_CumAddictionPool:
; 0 - 100	: Cum averse
; 100 - 200	: Cum tolerant
; 200 - 300	: Cum addict
; 300 - 400	: Cum dump
; 400+		: Cum junkie

; _SLS_CumAddictionHunger:
; 0 - 0.5		: Satisfied
; 0.5 - 1.3		: Peckish
; 1.3 - 2.0		: Hungry
; 2.6 - 3.1	: Starving
; 3.1+ 		: Ravenous

; _SLS_CumAddictionHunger + Encourage Beastiality + Level 4 cum addiction:
; 0 - 2.0		: Satisfied
; 2.0 - 5.2		: Peckish
; 5.2 - 8.0		: Hungry
; 8.0 - 12.4	: Starving
; 12.4+ 		: Ravenous

Event OnInit()
	If Self.IsRunning()
		HungerStateStrings = new String[5]
		HungerStateStrings[0] = "satisfied"
		HungerStateStrings[1] = "peckish"
		HungerStateStrings[2] = "hungry"
		HungerStateStrings[3] = "starving"
		HungerStateStrings[4] = "ravenous"
		
		AddictionStateStrings = New String[5]
		AddictionStateStrings[0] = "unaffected"
		AddictionStateStrings[1] = "cum tolerant"
		AddictionStateStrings[2] = "cum addict"
		AddictionStateStrings[3] = "cum dump"
		AddictionStateStrings[4] = "cum junkie"
		
		_SLS_CumAddictionPool.SetValue(0.0)
		_SLS_CumAddictionHunger.SetValue(0.0)
		
		LastUpdateTime = Utility.GetCurrentGameTime()
		LastAddictionState =  GetAddictionState()
		
		LoadNewHungerThresholds()
		PlayerRef.AddSpell(_SLS_CumAddictStatusSpell, false)
		Utility.Wait(0.1)
		PlayerRef.AddSpell(_SLS_CumAddictHungerSpell, false)
		InitCumPotionIndexLists()
		RegForEvents()
		RegisterForSingleUpdateGameTime(1.0)
		;SetNotifyKey(Menu.CumAddictKey)
	EndIf
EndEvent

Function RegForEvents()
	UnRegisterForAllModEvents()
	RegisterForModEvent("_SLS_PlayerSwallowedCum", "On_SLS_PlayerSwallowedCum")
	RegisterForModEvent("HookAnimationStarting", "OnAnimationStarting")
	;RegisterForModEvent("HookAnimationStart", "OnAnimationStart")
	RegisterForModEvent("HookAnimationEnd", "OnAnimationEnd")
	
	If Game.GetModByName("SLSO.esp") != 255
		RegisterForModEvent("SexLabOrgasmSeparate", "OnSexLabOrgasmSeparate")
	Else
		RegisterForModEvent("HookOrgasmStart", "OnOrgasmStart")
	EndIf
	RegForArousal()
EndFunction

Function RegForArousal()
	If StorageUtil.GetFloatValue(Menu, "CumAddictDayDreamArousal", Missing = 101.0) < 101.0
		RegisterForModEvent("sla_UpdateComplete", "On_sla_UpdateComplete")
	Else
		UnRegisterForModEvent("sla_UpdateComplete")
	EndIf
EndFunction

Function LoadGameMaintenance()
	Voices.LoadGameMaintenance()
	If IsDaydreaming
		MushroomSwap(DoCocks = true)
		If StorageUtil.GetIntValue(Menu, "CumAddictDayDreamButterflys", Missing = 1) == 1
			;Debug.Messagebox("HIHI")
			ButterflySwap(DoSexy = true)
		EndIf
	Else
		MushroomSwap(DoCocks = false)
		ButterflySwap(DoSexy = false)
	EndIf
EndFunction

Event OnAnimationStarting(int tid, bool HasPlayer)
	If HasPlayer
		CumCountOnAnimStart = Sexlab.CountCum(PlayerRef)
	EndIf
EndEvent
;/
Event OnAnimationStart(int tid, bool HasPlayer)
	If HasPlayer && SexStartMsg != ""
		Utility.Wait(1.0)
		Debug.Notification(SexStartMsg)
		SexStartMsg = ""
	EndIf
EndEvent
/;
Event OnAnimationEnd(int tid, bool HasPlayer)
	If HasPlayer && Menu.CumAddictBatheRefuseTime > 0.0
		If Sexlab.CountCum(PlayerRef) > CumCountOnAnimStart ; Player took a fresh load
			If GetHungerState() >= 2 ; Player is hungry
				_SLS_CumAddictBathingTimerQuest.Stop()
				_SLS_CumAddictBathingTimerQuest.Start()
			EndIf
		EndIf
	EndIf
EndEvent

;/
Function SetNotifyKey(Int KeyCode)
	UnRegisterForKey(Menu.CumAddictKey)
	RegisterForKey(KeyCode)
	Menu.CumAddictKey = KeyCode
EndFunction
/;

Event OnKeyDown(Int KeyCode)
	If !Utility.IsInMenuMode() && _SLS_CumAddictionPool.GetValue() >= 100.0
		DoKeyDownNotify()
	EndIf
EndEvent

Event OnUpdateGameTime()
	;Debug.Messagebox("Update game time. Hours Passed: " + ((Utility.GetCurrentGameTime() - LastUpdateTime) * 24.0))
	DoUpdate()
	;LastUpdateTime = Utility.GetCurrentGameTime()
EndEvent

Function DoUpdate()
	Float HoursPassed = ((Utility.GetCurrentGameTime() - LastUpdateTime) * 24.0)
	AddictionUpdate(HoursPassed)
	Int HungerStateOld = GetHungerState()
	Int AddictLevel = GetAddictionState()
	Int AddictLevelAdjusted = AddictLevel - 1
	If AddictLevelAdjusted == -1
		AddictLevelAdjusted = 0
	EndIf

	If AddictLevel > 0
		ClampHunger(_SLS_CumAddictionHunger.GetValue() + (HoursPassed * (1.0 - Util.GetCumStuffedFactor(PlayerRef)) * (Menu.CumAddictionHungerRate + ((Menu.CumAddictBeastLevels as Float) * (AddictLevelAdjusted * Menu.CumAddictionHungerRate)))))
		DoHungerNotification(HungerStateOld, GetHungerState())
	Else
		ClampHunger(_SLS_CumAddictionHunger.GetValue() - 0.2)
	EndIf

	LastUpdateTime = Utility.GetCurrentGameTime()
	LastAddictionState = AddictLevel
	RegisterForSingleUpdateGameTime(1.0)
EndFunction

Event On_SLS_PlayerSwallowedCum(Form akSource, Bool DidSwallow, Float CumAmount, Float LoadSizeBase, Bool IsCumPotion)
	SwallowedCum(akSource, DidSwallow, CumAmount)
	Int AddictionStateNew = GetAddictionState()
	DoAddictionStateChangeNotif(LastAddictionState, AddictionStateNew)
	LastAddictionState = AddictionStateNew
EndEvent

Function AddictionUpdate(Float HoursPassed)
	Float SkinCumAddiction = ProcSkinCumAddiction(DoProc = true, HoursPassed = HoursPassed) ; ProcSkinCumAddiction() adds addiction itself
	Float AnalCumAddiction = ProcAnalCumAddiction(DoProc = true, HoursPassed = HoursPassed) ; Adds addiction
	Float VagCumAddiction = ProcVagCumAddiction(DoProc = true, HoursPassed = HoursPassed) ; Adds addiction
	If (SkinCumAddiction + AnalCumAddiction + VagCumAddiction == 0.0) || !CumBlocksAddictionDecay ; Decay addiction
		ClampAddiction(_SLS_CumAddictionPool.GetValue() - ((HoursPassed * Menu.CumAddictionDecayPerHour * Menu.CumAddictionSpeed) + (HoursPassed * _SLS_CumRemedyDecay.GetValue())))
	EndIf
	Int NewAddictionState = GetAddictionState()
	DoAddictionStateChangeNotif(LastAddictionState, NewAddictionState)
	LastAddictionState = NewAddictionState
EndFunction

Int Function GetHungerState()
	Return CalcHungerState(_SLS_CumAddictionHunger.GetValue())
EndFunction

Int Function CalcHungerState(Float Hunger)
	If Hunger < _SLS_CumHunger0.GetValue() ; Satisfied - Default < 0.5
		Return 0
	ElseIf Hunger < _SLS_CumHunger1.GetValue() ; Peckish - Default < 1.3
		Return 1
	ElseIf Hunger < _SLS_CumHunger2.GetValue() ; Hungry - Default < 2.0
		Return 2
	ElseIf Hunger < _SLS_CumHunger3.GetValue() ; Starving - Default < 2.6
		Return 3
	Else ; Ravenous - Default >= 2.6
		Return 4
	EndIf
EndFunction

Function LoadNewHungerThresholds()
	Int AddictLevel = GetAddictionState() - 1 ; - 1: No additional effect at level 1 addiction
	If AddictLevel == -1
		AddictLevel = 0
	EndIf
	_SLS_CumHunger0.SetValue(StockSatisfied + ((Menu.CumAddictBeastLevels as Float) * (AddictLevel * StockSatisfied)))
	_SLS_CumHunger1.SetValue(StockPeckish + ((Menu.CumAddictBeastLevels as Float) * (AddictLevel * StockPeckish)))
	_SLS_CumHunger2.SetValue(StockHungry + ((Menu.CumAddictBeastLevels as Float) * (AddictLevel * StockHungry)))
	_SLS_CumHunger3.SetValue(StockStarving + ((Menu.CumAddictBeastLevels as Float) * (AddictLevel * StockStarving)))
EndFunction

Int Function GetAddictionState()
	Float Addiction = _SLS_CumAddictionPool.GetValue()
	If Addiction < 100.0 ; Unaffected
		Return 0
	ElseIf Addiction < 200.0 ; Tolerant
		Return 1
	ElseIf Addiction < 300.0 ; Addict
		Return 2
	ElseIf Addiction < 400.0 ; Dump
		Return 3
	Else ; Junkie
		Return 4
	EndIf
EndFunction

Function DoAddictionStateChangeNotif(Int AddictionOld, Int AddictionNew)
	If AddictionNew != AddictionOld
		LoadNewHungerThresholds()
		If AddictionNew > AddictionOld
			Debug.Notification("I've become more addicted to cum - " + AddictionStateStrings[AddictionNew])
		Else
			Debug.Notification("I've become less addicted to cum - " + AddictionStateStrings[AddictionNew])
		EndIf
	EndIf
EndFunction

Function SwallowedCum(Form akSource, Bool DidSwallow, Float CumAmount)
	Int HungerStateOld = GetHungerState()
	Float Hunger = _SLS_CumAddictionHunger.GetValue() - (CumAmount * Menu.CumSatiation)
	ClampHunger(Hunger)
	DoHungerNotification(HungerStateOld, GetHungerState())
	
	Float NewAddiction = _SLS_CumAddictionPool.GetValue() + (CumAmount * Menu.CumAddictionSpeed * 5.0)
	ClampAddiction(NewAddiction)
EndFunction

Float Function CalcSatiationChange(Float LoadSize)
	Int HungerStateOld = GetHungerState()
	Int HungerStateNew = CalcHungerState(_SLS_CumAddictionHunger.GetValue() - (LoadSize * Menu.CumSatiation))
	Return HungerStateOld - HungerStateNew
EndFunction

Function DoHungerNotification(Int HungerStateOld, Int HungerStateNew)
	If HungerStateNew != HungerStateOld
		SatiationLevelChange(HungerStateOld, HungerStateNew)
		Debug.Notification("Cum Hunger: I'm " + HungerStateStrings[HungerStateNew] + " now.")
	EndIf
EndFunction

Function SatiationLevelChange(Int HungerStateOld, Int HungerStateNew)
	If HungerStateNew < 2
		If _SLS_CumAddictBathingTimerQuest.IsRunning()
			_SLS_CumAddictBathingTimerQuest.Stop()
			Util.PermitBathing(PlayerRef)
		EndIf
	EndIf
	
	;Debug.Messagebox("Sate change: HungerStateNew: " + HungerStateNew + ". CumHungerAutoSuck: " + Menu.CumHungerAutoSuck + ". _SLS_CumAddictAutoSuckCooldownQuest.IsRunning(): " + _SLS_CumAddictAutoSuckCooldownQuest.IsRunning())
	If Init.SlsCreatureEvents && HungerStateNew >= Menu.CumHungerAutoSuck && !_SLS_CumAddictAutoSuckCooldownQuest.IsRunning()
		_SLS_CumAddictAutoSuckCreatureQuest.Start()
	Else
		_SLS_CumAddictAutoSuckCreatureQuest.Stop()
	EndIf
	
	CumDesperationEffects(HungerStateNew)
	Api.SendCumHungerChangeEvent(HungerStateNew)
EndFunction

Float Function ProcSkinCumAddiction(Bool DoProc = true, Float HoursPassed)
	; Gain addiction for every layer of cum on your body
	
	Float Addiction = Sexlab.CountCum(PlayerRef) * 1.0 * Menu.CumAddictionSpeed * HoursPassed
	If DoProc
		ClampAddiction(_SLS_CumAddictionPool.GetValue() + Addiction)
	EndIf
	Return Addiction
EndFunction

Float Function ProcAnalCumAddiction(Bool DoProc = true, Float HoursPassed)
	Float Addiction = Fhu.GetCurrentCumAnal(PlayerRef) * Menu.CumAddictionSpeed * HoursPassed
	If DoProc
		ClampAddiction(_SLS_CumAddictionPool.GetValue() + Addiction)
	EndIf
	Return Addiction
EndFunction

Float Function ProcVagCumAddiction(Bool DoProc = true, Float HoursPassed)
	Float Addiction = Fhu.GetCurrentCumVaginal(PlayerRef) * Menu.CumAddictionSpeed * HoursPassed
	If DoProc
		ClampAddiction(_SLS_CumAddictionPool.GetValue() + Addiction)
	EndIf
	Return Addiction
EndFunction

Function ClampAddiction(Float Addiction)
	Addiction = PapyrusUtil.ClampFloat(Addiction, 0.0, 550.0)
	_SLS_CumAddictionPool.SetValue(Addiction)
EndFunction

Function ClampHunger(Float Hunger)
	Hunger = PapyrusUtil.ClampFloat(Hunger, 0.0, GetMaxHunger())
	_SLS_CumAddictionHunger.SetValue(Hunger)
EndFunction

Float Function GetMaxHunger()
	Int AddictLevel = GetAddictionState()
	Int AddictLevelAdjusted = AddictLevel - 1
	If AddictLevelAdjusted == -1
		AddictLevelAdjusted = 0
	EndIf
	If Menu.CumAddictClampHunger
		If AddictLevel == 1 ; Cum tolerant
			Return (StockPeckish + (AddictLevelAdjusted * StockPeckish)) - 0.01
		ElseIf AddictLevel == 2 ; Cum addict
			Return (StockHungry + (AddictLevelAdjusted * StockHungry)) - 0.01
		ElseIf AddictLevel == 3 ; Cum dump
			Return (StockStarving + (AddictLevelAdjusted * StockStarving)) - 0.01
		ElseIf AddictLevel == 4 ; Cum junkie
			Return	(StockHungerMax + (AddictLevelAdjusted * StockHungerMax))
		EndIf
		Return (StockSatisfied + (AddictLevelAdjusted * StockSatisfied)) - 0.01 ; Unaffected
	
	Else
		If Menu.CumAddictBeastLevels
			Return StockHungerMax + (AddictLevelAdjusted * StockHungerMax)
		Else
			Return StockHungerMax
		EndIf
	EndIf
EndFunction

String Function GetCurrentAddictionString()
	Return AddictionStateStrings[GetAddictionState()]
EndFunction

String Function GetCurrentHungerString()
	Return HungerStateStrings[GetHungerState()]
EndFunction

Function DoKeyDownNotify()
	Debug.Notification(GetStatusMessage())
EndFunction

String Function GetStatusMessage()
	Return ("Cum Addict: " + AddictionStateStrings[GetAddictionState()] + ". Hunger: " + HungerStateStrings[GetHungerState()])
EndFunction

Bool Function IsReflexCumSwallow()
	; higher chance to auto swallow the higher addiction or hunger is
	
	If (GetAddictionState() as Float / 4.0) > Utility.RandomFloat(0.0, 1.0) || (GetHungerState() as Float / 4.0) * Menu.CumAddictReflexSwallow > Utility.RandomFloat(0.0, 1.0)
		Return true
	EndIf
	Return false
EndFunction

Function AutoSuck(Actor akTarget)
	If Init.SlsCreatureEvents
		;Float Arousal = StorageUtil.GetFloatValue(akTarget, "SLAroused.ActorExposure")
		Float Arousal = akTarget.GetFactionRank(Game.GetFormFromFile(0x03FC36, "SexLabAroused.esm") as Faction)
		sslBaseAnimation[] AnimsOral = Sexlab.GetCreatureAnimationsByRaceTags(2, akTarget.GetLeveledActorBase().GetRace(), "Blowjob,Oral", TagSuppress = "Cunnilingus", RequireAll = false)
		;Debug.Messagebox(akTarget.GetLeveledActorBase().GetRace())
		If AnimsOral.Length > 0 && Arousal > Menu.CumAddictAutoSuckCreatureArousal && Util.GetLoadFullnessMod(akTarget) > 0.7
			If (GetHungerState() / 4.0) * Menu.CumAddictAutoSuckCreature >= Utility.RandomFloat(0.0, 1.0)
				If Devious.CanDoOral(PlayerRef) 
					;Debug.Notification("Mmm, look at that lovely fat cock... Maybe just a little taste")
					Actor[] SexActors = new Actor[2]
					SexActors[0] = PlayerRef
					SexActors[1] = akTarget
					If AutoSuckVictim
						Sexlab.StartSex(SexActors, AnimsOral, Victim = PlayerRef, CenterOn = none, AllowBed = false)
					Else
						Sexlab.StartSex(SexActors, AnimsOral, Victim = none, CenterOn = none, AllowBed = false)
					EndIf
					Debug.Trace("_SLS_: CumAddict Auto Suck: Sucky start - Target: " + akTarget + ". Arousal: " + Arousal + ". AnimCount: " + AnimsOral.Length)
					;SexStartMsg = "Mmm, look at that lovely fat cock... Maybe just a little taste"
					Voices.DoVoices(_SLS_HeadVoicesAutoSuckSM, MinWait = 4.0, MaxWait = 4.0)
					_SLS_CumAddictAutoSuckCooldownQuest.Start()
				
				Else
					Voices.DoVoices(_SLS_HeadVoicesAutoSuckGagSM, MinWait = 4.0, MaxWait = 4.0)
					;Debug.Notification("Damn! If I hadn't got this stupid gag in my mouth I'd suck those balls dry!")
				EndIf
			Else
				Voices.DoVoices(_SLS_HeadVoicesAutoSuckFailSM, MinWait = 4.0, MaxWait = 4.0)
				;Debug.Notification("Mmm, look at that lovely fat cock... But I better not")
			EndIf
		Else
			Debug.Trace("_SLS_: CumAddict Auto Suck: Event but no sucky - Target: " + akTarget + ". Arousal: " + Arousal + ". AnimCount: " + AnimsOral.Length)
		EndIf
	EndIf
EndFunction

Function SetAutoSuckBeginStage()
	If GetHungerState() >= Menu.CumHungerAutoSuck
		If !_SLS_CumAddictAutoSuckCooldownQuest.IsRunning()
			_SLS_CumAddictAutoSuckCreatureQuest.Start()
		EndIf
	Else
		_SLS_CumAddictAutoSuckCreatureQuest.Stop()
	EndIf
EndFunction

Event On_sla_UpdateComplete(string eventName, string strArg, float numArg, Form sender)
	CumDesperationEffects(GetHungerState())
EndEvent

Function CumDesperationEffects(Int HungerState)
	If StorageUtil.GetIntValue(Menu, "CumAddictDayDream", Missing = 1) == 1
	;Debug.Messagebox("Arousal: " + PlayerRef.GetFactionRank(Game.GetFormFromFile(0x03FC36, "SexLabAroused.esm") as Faction) + "\nvalue: " + StorageUtil.GetFloatValue(Menu, "CumAddictDayDreamArousal", Missing = 101.0))
		If HungerState >= 2 || (PlayerRef.GetFactionRank(Game.GetFormFromFile(0x03FC36, "SexLabAroused.esm") as Faction)) >= StorageUtil.GetFloatValue(Menu, "CumAddictDayDreamArousal", Missing = 101.0) ; Hungry or worse
			If !IsDaydreaming
				IsDaydreaming = true
				MushroomSwap(DoCocks = true)
				If StorageUtil.GetIntValue(Menu, "CumAddictDayDreamButterflys", Missing = 1)
					ButterflySwap(DoSexy = true)
				EndIf
				_SLS_CumDesperationEffectsQuest.Start()
				Cf.SetArousalThreshold(-2)
			EndIf
		Else
			If IsDaydreaming
				IsDaydreaming = false
				MushroomSwap(DoCocks = false)
				If StorageUtil.GetIntValue(Menu, "CumAddictDayDreamButterflys", Missing = 1)
					ButterflySwap(DoSexy = false)
				EndIf
				;_SLS_CumDesperationEffectsQuest.Stop()
				StopEffects()
				Cf.ResetArousalThreshold()
			EndIf	
		EndIf
	EndIf
EndFunction

Function MushroomSwap(Bool DoCocks)
	;Debug.Messagebox("DoCocks: " + DoCocks)
	String TexPathPrefix = ""
	If DoCocks
		TexPathPrefix = "SL Survival/Aradia/"
	EndIf
	If (Game.GetFormFromFile(0xE1FB2, "Skyrim.esm")).GetWorldModelPath() != TexPathPrefix + "plants/floranirnroot01.nif"
		(Game.GetFormFromFile(0xE1FB2, "Skyrim.esm")).SetWorldModelPath(TexPathPrefix + "plants/floranirnroot01.nif") ; TreeFloraNirnroot01
		(Game.GetFormFromFile(0xB6FB9, "Skyrim.esm")).SetWorldModelPath(TexPathPrefix + "plants/floranirnroot01red.nif") ; TreeFloraNirnrootRed01
		(Game.GetFormFromFile(0x4D9FF, "Skyrim.esm")).SetWorldModelPath(TexPathPrefix + "plants/floramushroom01.nif") ; FloraMushroom01
		(Game.GetFormFromFile(0x4DA03, "Skyrim.esm")).SetWorldModelPath(TexPathPrefix + "plants/floramushroom01small.nif") ; FloraMushroom01Small
		(Game.GetFormFromFile(0x4DA04, "Skyrim.esm")).SetWorldModelPath(TexPathPrefix + "plants/floramushroom02.nif") ; FloraMushroom02
		(Game.GetFormFromFile(0x4DA05, "Skyrim.esm")).SetWorldModelPath(TexPathPrefix + "plants/floramushroom02small.nif") ; FloraMushroom02Small
		(Game.GetFormFromFile(0x4DA06, "Skyrim.esm")).SetWorldModelPath(TexPathPrefix + "plants/floramushroom03.nif") ; FloraMushroom03
		(Game.GetFormFromFile(0x4DA07, "Skyrim.esm")).SetWorldModelPath(TexPathPrefix + "plants/floramushroom03small.nif") ; FloraMushroom03Small
		(Game.GetFormFromFile(0xECA59, "Skyrim.esm")).SetWorldModelPath(TexPathPrefix + "plants/floramushroom03.nif") ; FloraMushroom03ReachDirt01 (White Cap - Fairy ring)
		(Game.GetFormFromFile(0x4DA08, "Skyrim.esm")).SetWorldModelPath(TexPathPrefix + "plants/floramushroom04.nif") ; FloraMushroom04
		(Game.GetFormFromFile(0x4DA09, "Skyrim.esm")).SetWorldModelPath(TexPathPrefix + "plants/floramushroom04small.nif") ; FloraMushroom04Small
		(Game.GetFormFromFile(0x4DA0A, "Skyrim.esm")).SetWorldModelPath(TexPathPrefix + "plants/floramushroom05.nif") ; FloraMushroom05
		(Game.GetFormFromFile(0x4DA0B, "Skyrim.esm")).SetWorldModelPath(TexPathPrefix + "plants/floramushroom05small.nif") ; FloraMushroom05Small
		(Game.GetFormFromFile(0x4DA0C, "Skyrim.esm")).SetWorldModelPath(TexPathPrefix + "plants/floramushroom06.nif") ; FloraMushroom06
		(Game.GetFormFromFile(0x4DA1F, "Skyrim.esm")).SetWorldModelPath(TexPathPrefix + "plants/floramushroom06small.nif") ; FloraMushroom06Small
		(Game.GetFormFromFile(0x7EE00, "Skyrim.esm")).SetWorldModelPath(TexPathPrefix + "plants/glowingmushroomcluster01.nif") ; GlowingMushroomCluster
		(Game.GetFormFromFile(0x9748B, "Skyrim.esm")).SetWorldModelPath(TexPathPrefix + "plants/glowingmushroomsingle01.nif") ; GlowingMushroomSingle
		
		; Ingredients
		(Game.GetFormFromFile(0x59B86, "Skyrim.esm")).SetWorldModelPath(TexPathPrefix + "plants/nirnroot01.nif") ; Nirnroot
		(Game.GetFormFromFile(0xB701A, "Skyrim.esm")).SetWorldModelPath(TexPathPrefix + "plants/nirnroot01red.nif") ; NirnrootRed
		(Game.GetFormFromFile(0x4DA00, "Skyrim.esm")).SetWorldModelPath(TexPathPrefix + "plants/mushroom01.nif") ; Mushroom01
		(Game.GetFormFromFile(0x4DA20, "Skyrim.esm")).SetWorldModelPath(TexPathPrefix + "plants/mushroom02.nif") ; Mushroom02
		(Game.GetFormFromFile(0x4DA22, "Skyrim.esm")).SetWorldModelPath(TexPathPrefix + "plants/mushroom03.nif") ; Mushroom03
		(Game.GetFormFromFile(0x4DA23, "Skyrim.esm")).SetWorldModelPath(TexPathPrefix + "plants/mushroom04.nif") ; Mushroom04
		(Game.GetFormFromFile(0x4DA24, "Skyrim.esm")).SetWorldModelPath(TexPathPrefix + "plants/mushroom05.nif") ; Mushroom05
		(Game.GetFormFromFile(0x4DA25, "Skyrim.esm")).SetWorldModelPath(TexPathPrefix + "plants/mushroom06.nif") ; Mushroom06
		(Game.GetFormFromFile(0x7EE01, "Skyrim.esm")).SetWorldModelPath(TexPathPrefix + "plants/glowingmushroom01.nif") ; GlowingMushroom
		
		_SLS_CumDesperationMushroomRefreshQuest.Stop()
		_SLS_CumDesperationMushroomRefreshQuest.Start()
	EndIf
EndFunction

Function ButterflySwap(Bool DoSexy)
	;Debug.Messagebox("DoSexy: " + DoSexy)
	String TexPathPrefix = ""
	If DoSexy
		TexPathPrefix = "SL Survival/MyBugs/"
	EndIf
	If (Game.GetFormFromFile(0xB97AF, "Skyrim.esm")).GetWorldModelPath() != TexPathPrefix + "Critters/Moths/CritterMothMonarch.nif"
		; Critters
		(Game.GetFormFromFile(0xB97AF, "Skyrim.esm")).SetWorldModelPath(TexPathPrefix + "Critters/Moths/CritterMothMonarch.nif") ; CritterMothMonarch
		(Game.GetFormFromFile(0x22219, "Skyrim.esm")).SetWorldModelPath(TexPathPrefix + "Critters/Moths/CritterMothBlue.nif") ; CritterMothBlue
		(Game.GetFormFromFile(0x2221E, "Skyrim.esm")).SetWorldModelPath(TexPathPrefix + "Critters/Moths/CritterMothGreen.nif") ; CritterMothLuna
		
		; Ingredients
		(Game.GetFormFromFile(0x727E0, "Skyrim.esm")).SetWorldModelPath(TexPathPrefix + "Clutter/Ingredients/MothWing02Monarch.nif") ; MothWingMonarch
		(Game.GetFormFromFile(0x727DF, "Skyrim.esm")).SetWorldModelPath(TexPathPrefix + "Clutter/Ingredients/MothWing01.nif") ; MothWingLuna
		(Game.GetFormFromFile(0x727DE, "Skyrim.esm")).SetWorldModelPath(TexPathPrefix + "Clutter/Ingredients/MothWing03Blue.nif") ; MothWingBlue

		; Jars
		(Game.GetFormFromFile(0xFBC3D, "Skyrim.esm")).SetWorldModelPath(TexPathPrefix + "Critters/Moths/MothLunarInJar.nif") ; dunUniqueMothInJar
		(Game.GetFormFromFile(0xFBC3C, "Skyrim.esm")).SetWorldModelPath(TexPathPrefix + "Critters/Moths/MothMonarchInJar.nif") ; dunUniqueButterflyInJar
		
		_SLS_CumDesperationButterflyRefreshQuest.Stop()
		_SLS_CumDesperationButterflyRefreshQuest.Start()
	EndIf
EndFunction

Function ToggleButterflys(Bool ToggleOn)
	If ToggleOn && IsDaydreaming
		ButterflySwap(DoSexy = true)
	Else
		ButterflySwap(DoSexy = false)
	EndIf
EndFunction

Function ToggleDaydreaming(Bool ToggleOn)
	If ToggleOn
		If GetHungerState() >= 2
			IsDaydreaming = true
			MushroomSwap(DoCocks = true)
			If StorageUtil.GetIntValue(Menu, "CumAddictDayDreamButterflys", Missing = 1)
				ButterflySwap(DoSexy = true)
			EndIf
			_SLS_CumDesperationEffectsQuest.Start()
			Cf.SetArousalThreshold(-2)
		Else
			IsDaydreaming = false
			MushroomSwap(DoCocks = false)
			If StorageUtil.GetIntValue(Menu, "CumAddictDayDreamButterflys", Missing = 1)
				ButterflySwap(DoSexy = false)
			EndIf
			;_SLS_CumDesperationEffectsQuest.Stop()
			StopEffects()
			Cf.ResetArousalThreshold()
		EndIf
	Else
		IsDaydreaming = false
		MushroomSwap(DoCocks = false)
		If StorageUtil.GetIntValue(Menu, "CumAddictDayDreamButterflys", Missing = 1)
			ButterflySwap(DoSexy = false)
		EndIf
		;_SLS_CumDesperationEffectsQuest.Stop()
		StopEffects()
		Cf.ResetArousalThreshold()
	EndIf
EndFunction

Function InitCumPotionIndexLists()
	
	; A list of races
	StorageUtil.FormListClear(Self, "_SLS_CumPotionToHumanRaceList")
	StorageUtil.FormListAdd(Self, "_SLS_CumPotionToHumanRaceList", Game.GetFormFromFile(0x013740, "Skyrim.esm"), AllowDuplicate = true) ; Argonian
	StorageUtil.FormListAdd(Self, "_SLS_CumPotionToHumanRaceList", Game.GetFormFromFile(0x013741, "Skyrim.esm"), AllowDuplicate = true) ; Breton
	StorageUtil.FormListAdd(Self, "_SLS_CumPotionToHumanRaceList", Game.GetFormFromFile(0x013742, "Skyrim.esm"), AllowDuplicate = true) ; Dark Elf
	StorageUtil.FormListAdd(Self, "_SLS_CumPotionToHumanRaceList", Game.GetFormFromFile(0x013743, "Skyrim.esm"), AllowDuplicate = true) ; High Elf
	StorageUtil.FormListAdd(Self, "_SLS_CumPotionToHumanRaceList", Game.GetFormFromFile(0x013744, "Skyrim.esm"), AllowDuplicate = true) ; Imperial
	StorageUtil.FormListAdd(Self, "_SLS_CumPotionToHumanRaceList", Game.GetFormFromFile(0x013745, "Skyrim.esm"), AllowDuplicate = true) ; Khajiit
	StorageUtil.FormListAdd(Self, "_SLS_CumPotionToHumanRaceList", Game.GetFormFromFile(0x013746, "Skyrim.esm"), AllowDuplicate = true) ; Nord
	StorageUtil.FormListAdd(Self, "_SLS_CumPotionToHumanRaceList", Game.GetFormFromFile(0x013747, "Skyrim.esm"), AllowDuplicate = true) ; Orc
	StorageUtil.FormListAdd(Self, "_SLS_CumPotionToHumanRaceList", Game.GetFormFromFile(0x013748, "Skyrim.esm"), AllowDuplicate = true) ; Redguard
	StorageUtil.FormListAdd(Self, "_SLS_CumPotionToHumanRaceList", Game.GetFormFromFile(0x013749, "Skyrim.esm"), AllowDuplicate = true) ; Wood elf
	
	; A list of voice types
	StorageUtil.FormListClear(Self, "_SLS_CumPotionToCreatureVoiceList")
	StorageUtil.FormListAdd(Self, "_SLS_CumPotionToCreatureVoiceList", Game.GetFormFromFile(0x01F14E, "Skyrim.esm"), AllowDuplicate = true) ; Bear
	StorageUtil.FormListAdd(Self, "_SLS_CumPotionToCreatureVoiceList", Game.GetFormFromFile(0x01F152, "Skyrim.esm"), AllowDuplicate = true) ; Chaurus
	StorageUtil.FormListAdd(Self, "_SLS_CumPotionToCreatureVoiceList", Game.GetFormFromFile(0x01F152, "Skyrim.esm"), AllowDuplicate = true) ; Chaurus (because there's chaurus and chaurus reaper in the list
	StorageUtil.FormListAdd(Self, "_SLS_CumPotionToCreatureVoiceList", Game.GetFormFromFile(0x041FBA, "Skyrim.esm"), AllowDuplicate = true) ; Deer
	StorageUtil.FormListAdd(Self, "_SLS_CumPotionToCreatureVoiceList", Game.GetFormFromFile(0x01F180, "Skyrim.esm"), AllowDuplicate = true) ; Dog
	StorageUtil.FormListAdd(Self, "_SLS_CumPotionToCreatureVoiceList", Game.GetFormFromFile(0x01F1CD, "Skyrim.esm"), AllowDuplicate = true) ; Draugr
	StorageUtil.FormListAdd(Self, "_SLS_CumPotionToCreatureVoiceList", Game.GetFormFromFile(0x01F1CE, "Skyrim.esm"), AllowDuplicate = true) ; Dremora
	StorageUtil.FormListAdd(Self, "_SLS_CumPotionToCreatureVoiceList", Game.GetFormFromFile(0x01F1D2, "Skyrim.esm"), AllowDuplicate = true) ; Falmer
	StorageUtil.FormListAdd(Self, "_SLS_CumPotionToCreatureVoiceList", Game.GetFormFromFile(0x10F677, "Skyrim.esm"), AllowDuplicate = true) ; Fox
	StorageUtil.FormListAdd(Self, "_SLS_CumPotionToCreatureVoiceList", Game.GetFormFromFile(0x01F225, "Skyrim.esm"), AllowDuplicate = true) ; Giant
	StorageUtil.FormListAdd(Self, "_SLS_CumPotionToCreatureVoiceList", Game.GetFormFromFile(0x01F22A, "Skyrim.esm"), AllowDuplicate = true) ; Goat
	StorageUtil.FormListAdd(Self, "_SLS_CumPotionToCreatureVoiceList", Game.GetFormFromFile(0x01F232, "Skyrim.esm"), AllowDuplicate = true) ; Horse
	StorageUtil.FormListAdd(Self, "_SLS_CumPotionToCreatureVoiceList", Game.GetFormFromFile(0x01F287, "Skyrim.esm"), AllowDuplicate = true) ; Mammoth
	StorageUtil.FormListAdd(Self, "_SLS_CumPotionToCreatureVoiceList", Game.GetFormFromFile(0x01920C, "Skyrim.esm"), AllowDuplicate = true) ; Sabrecat
	StorageUtil.FormListAdd(Self, "_SLS_CumPotionToCreatureVoiceList", Game.GetFormFromFile(0x019FE5, "Skyrim.esm"), AllowDuplicate = true) ; Skeever
	StorageUtil.FormListAdd(Self, "_SLS_CumPotionToCreatureVoiceList", Game.GetFormFromFile(0x01F21D, "Skyrim.esm"), AllowDuplicate = true) ; Spider
	StorageUtil.FormListAdd(Self, "_SLS_CumPotionToCreatureVoiceList", Game.GetFormFromFile(0x02AFD9, "Skyrim.esm"), AllowDuplicate = true) ; Spider Giant
	StorageUtil.FormListAdd(Self, "_SLS_CumPotionToCreatureVoiceList", Game.GetFormFromFile(0x01F289, "Skyrim.esm"), AllowDuplicate = true) ; Troll
	StorageUtil.FormListAdd(Self, "_SLS_CumPotionToCreatureVoiceList", Game.GetFormFromFile(0x01F2E6, "Skyrim.esm"), AllowDuplicate = true) ; Werewolf
	StorageUtil.FormListAdd(Self, "_SLS_CumPotionToCreatureVoiceList", Game.GetFormFromFile(0x01F6A7, "Skyrim.esm"), AllowDuplicate = true) ; Wolf
	
	; Set cum sources on cum potions. Used in pouring cum
	Int i = 0
	While i < _SLS_CumPotionHuman.GetSize()
		StorageUtil.SetFormValue(_SLS_CumPotionHuman.GetAt(i), "_SLS_CumPotionSource", StorageUtil.FormListGet(Self, "_SLS_CumPotionToHumanRaceList", i))
		i += 1
	EndWhile
	
	i = 0
	While i < _SLS_CumPotionCreature.GetSize()
		StorageUtil.SetFormValue(_SLS_CumPotionCreature.GetAt(i), "_SLS_CumPotionSource", StorageUtil.FormListGet(Self, "_SLS_CumPotionToCreatureVoiceList", i))
		i += 1
	EndWhile
EndFunction

Event OnSexLabOrgasmSeparate(Form ActorRef, Int tid)
	OrgasmEvent(ActorRef, tid)
EndEvent

Event OnOrgasmStart(int tid, bool HasPlayer)
	OrgasmEvent(None, tid)
EndEvent

Function OrgasmEvent(Form ActorRef, Int tid)
	; Attempt to tag areas of the body with what type of cum is added

	Utility.Wait(1.0) ; Not important. Wait.
	Actor[] SexActors = SexLab.GetController(tid).Positions
	;Debug.Messagebox(SexActors)
	If SexActors[0] == PlayerRef && ActorRef != PlayerRef
		; Player is in the receiving position and orgasm wasn't the player
		
		If ActorRef == None ; Not SLSO. Need to determine source of cum
			Int i = SexActors.Length
			While !ActorRef && ActorRef == PlayerRef
				i -= 1
				ActorRef = SexActors[i]
			EndWhile
		EndIf
		
		String Area
		String[] Tags = sexlab.HookAnimation(tid).GetTags()
		;Debug.Messagebox(Tags)
		If Tags.Find("Oral") > -1
			Area = "Oral"
		ElseIf Tags.Find("Vaginal") > -1
			Area = "Vaginal"
		ElseIf Tags.Find("Anal") > -1
			Area = "Anal"
		EndIf
		
		If Area
			If Sexlab.CreatureCount(SexActors) > 0 ; Creature animation - Use voice
				StorageUtil.SetFormValue(PlayerRef, "_SLS_LastCumTypeForPotion" + Area, (ActorRef as Actor).GetVoiceType())
			Else ; Humanoid animation - Use race
				StorageUtil.SetFormValue(PlayerRef, "_SLS_LastCumTypeForPotion" + Area, (ActorRef as Actor).GetRace())
			EndIf
		EndIf
	EndIf
EndFunction

Potion Function GetCumPotionFromBodyArea(Actor akActor, String Area)
	Form CumType = StorageUtil.GetFormValue(akActor, "_SLS_LastCumTypeForPotion" + Area)
	;Debug.Messagebox(CumType)
	Potion CumPotion = _SLS_CumGeneric
	If CumType
		If CumType as Actor
			If _SLS_CumPotionHuman.HasForm((CumType as Actor).GetRace())
				CumType = (CumType as Actor).GetRace()
			Else
				CumType = (CumType as Actor).GetVoiceType()
			EndIf
		EndIf
		
		Int i
		If CumType as Race ; Humanoid (race)
			i = StorageUtil.FormListFind(Self, "_SLS_CumPotionToHumanRaceList", CumType)
			If i > -1
				CumPotion = _SLS_CumPotionHuman.GetAt(i) as Potion
			EndIf
		
		Else ; Creature (VoiceType)
			i = StorageUtil.FormListFind(Self, "_SLS_CumPotionToCreatureVoiceList", CumType)
			If i > -1
				CumPotion = _SLS_CumPotionCreature.GetAt(i) as Potion
			EndIf
		EndIf	
	EndIf
	Return CumPotion
EndFunction

Potion Function GetCumPotionFromActor(Actor akActor)
	Race akRace = akActor.GetRace()
	Int Index = StorageUtil.FormListFind(Self, "_SLS_CumPotionToHumanRaceList", akActor.GetRace())
	If Index > -1
		Return _SLS_CumPotionHuman.GetAt(Index) as Potion
	Else
		Index = StorageUtil.FormListFind(Self, "_SLS_CumPotionToCreatureVoiceList", akActor.GetVoiceType())
		If Index > -1
			Return _SLS_CumPotionCreature.GetAt(Index) as Potion
		EndIf
	EndIf
	Return _SLS_CumGeneric
EndFunction

Bool Function HasCumtainer(Actor akActor)
	If akActor.GetItemCount(_SLS_CumEmpty) > 0
		Return true
	EndIf
	Debug.Notification("I need an empty cumtainer to do that")
	Return false
EndFunction

Function FillCumtainerFromFace(Actor akActor)
	If HasCumtainer(akActor)
		Int CumVag = Sexlab.CountCumVaginal(akActor)
		Int CumAnal = Sexlab.CountCumAnal(akActor)
		Sexlab.ClearCum(akActor)
		Sexlab.AddCum(akActor, Vaginal = CumVag as Bool, Oral = false, Anal = CumAnal as Bool)
		Utility.Wait(1.0)
		Sexlab.AddCum(akActor, Vaginal = PapyrusUtil.ClampInt(CumVag - 1, 0, 1) as Bool, Oral = false, Anal = PapyrusUtil.ClampInt(CumAnal - 1, 0, 1) as Bool)
		akActor.AddItem(GetCumPotionFromBodyArea(akActor, "Oral"))
		akActor.RemoveItem(_SLS_CumEmpty, 1, true)
	EndIf
EndFunction

Function FillCumtainerFromPussy(Actor akActor)
	If HasCumtainer(akActor)
		Int CumAnal = Sexlab.CountCumAnal(akActor)
		Int CumOral = Sexlab.CountCumOral(akActor)
		Sexlab.ClearCum(akActor)
		Sexlab.AddCum(akActor, Vaginal = false, Oral = false, Anal = CumAnal as Bool)
		Utility.Wait(1.0)
		Sexlab.AddCum(akActor, Vaginal = false, Oral = PapyrusUtil.ClampInt(CumOral - 1, 0, 1) as Bool, Anal = PapyrusUtil.ClampInt(CumAnal - 1, 0, 1) as Bool)
		akActor.AddItem(GetCumPotionFromBodyArea(akActor, "Vaginal"))
		akActor.RemoveItem(_SLS_CumEmpty, 1, true)
	EndIf
EndFunction

Function FillCumtainerFromAss(Actor akActor)
	If HasCumtainer(akActor)
		Int CumVag = Sexlab.CountCumVaginal(akActor)
		Int CumOral = Sexlab.CountCumOral(akActor)
		Sexlab.ClearCum(akActor)
		Sexlab.AddCum(akActor, Vaginal = CumVag as Bool, Oral = CumOral, Anal = false)
		Utility.Wait(1.0)
		Sexlab.AddCum(akActor, Vaginal = PapyrusUtil.ClampInt(CumVag - 1, 0, 1) as Bool, Oral = PapyrusUtil.ClampInt(CumOral - 1, 0, 1) as Bool, Anal = false)
		akActor.AddItem(GetCumPotionFromBodyArea(akActor, "Anal"))
		akActor.RemoveItem(_SLS_CumEmpty, 1, true)
	EndIf
EndFunction

Function StopEffects()
	Effects.OnMenuClose("Dialogue Menu")
	_SLS_CumDesperationEffectsQuest.Stop()
EndFunction

Int Function CountCumPotions(ObjectReference ObjRef)
	Int Count
	Int i = _SLS_CumPotionAll.GetSize()
	While i > 0
		i -= 1
		Count += ObjRef.GetItemCount(_SLS_CumPotionAll.GetAt(i))
	EndWhile
	Return Count	
EndFunction

String[] HungerStateStrings
String[] AddictionStateStrings

Float LastUpdateTime
Float StockSatisfied = 0.5
Float StockPeckish = 1.3
Float StockHungry = 2.0
Float StockStarving = 2.6
Float StockHungerMax = 3.1

Int LastAddictionState
Int CumCountOnAnimStart

;String SexStartMsg

Bool Property CumBlocksAddictionDecay = true Auto Hidden
Bool Property IsDaydreaming = false Auto Hidden
Bool Property AutoSuckVictim = true Auto Hidden

GlobalVariable Property _SLS_CumRemedyDecay  Auto
GlobalVariable Property _SLS_CumAddictionPool Auto
GlobalVariable Property _SLS_CumAddictionHunger Auto
GlobalVariable Property _SLS_CumHunger0 Auto ; < Satisfied
GlobalVariable Property _SLS_CumHunger1 Auto ; < Peckish
GlobalVariable Property _SLS_CumHunger2 Auto ; < Hungry
GlobalVariable Property _SLS_CumHunger3 Auto ; < Starving, >= Ravenous

Spell Property _SLS_CumAddictHungerSpell Auto
Spell Property _SLS_CumAddictStatusSpell Auto

Actor Property PlayerRef Auto

Quest Property _SLS_CumAddictBathingTimerQuest Auto
Quest Property _SLS_CumAddictAutoSuckCreatureQuest Auto
Quest Property _SLS_CumAddictAutoSuckCooldownQuest Auto
Quest Property _SLS_CumDesperationMushroomRefreshQuest Auto
Quest Property _SLS_CumDesperationButterflyRefreshQuest Auto
Quest Property _SLS_CumDesperationEffectsQuest Auto

Formlist Property _SLS_CumPotionCreature Auto
Formlist Property _SLS_CumPotionHuman Auto
Formlist Property _SLS_CumPotionAll Auto

Potion Property _SLS_CumGeneric Auto
Potion Property _SLS_CumEmpty Auto
Potion Property _SLS_CumEmptySpent Auto

Sound Property _SLS_HeadVoicesAutoSuckSM Auto
Sound Property _SLS_HeadVoicesAutoSuckGagSM Auto
Sound Property _SLS_HeadVoicesAutoSuckFailSM Auto

SLS_Mcm Property Menu Auto
SexlabFramework Property Sexlab Auto

_SLS_InterfaceDevious Property Devious Auto
_SLS_InterfaceFhu Property Fhu Auto
_SLS_InterfaceCreatureFramework Property Cf Auto
_SLS_CumDesperateEffects Property Effects Auto
_SLS_CumDesperationVoices Property Voices Auto
_SLS_Api Property Api Auto
SLS_Utility Property Util Auto
SLS_Init Property Init Auto
