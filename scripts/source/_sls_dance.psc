Scriptname _SLS_Dance extends Quest  

Event OnInit()
	If Self.IsRunning()
		BuildDancesArray()
		BuildJunkList()
		BuildSpecActionLists()
	EndIf
EndEvent

State Dancing
	Event OnUpdate()
		AddSpectator()
		;/
		Actor akActor = ((_SLS_DanceSpecQuest.GetNthAlias(Utility.RandomInt(0, 2)) as ReferenceAlias).GetReference() as Actor)
		If akActor
			akActor.AddToFaction(Game.GetFormFromFile(0x0FE961, "SL Survival.esp") as Faction)
			akActor.EvaluatePackage()
			Debug.Notification("Add to faction")
		EndIf
		/;
		LastPerfFactor = GetPerformanceFactor()
		PlayerRef.DamageAv("Stamina", 10.0)
		PlayerRef.DamageAv("Magicka", 10.0)
		;Debug.Messagebox("CurrentExpFactor: " + GetExperienceFactor() + "\nCurrentPrepFactor: " + GetPreparationFactor() + "\nPerf: " + GetPerformanceFactor())
		If !CanDance()
			EndDance(PlayerRef)
		Else
			_SLS_DanceCrowdHate.SetValueInt(IsCrowdHatingPerf() as Int)
			RegisterForSingleUpdate(2.0)
		EndIf
	EndEvent
	
	Event OnControlDown(string control)
		If !UI.IsMenuOpen("InventoryMenu") && !UI.IsMenuOpen("ContainerMenu") && !UI.IsMenuOpen("Journal Menu")
			EndDance(PlayerRef)
		EndIf
	EndEvent
EndState

State NotDancing
	Event OnUpdate()
	EndEvent
EndState

Float Function GetPerfRating(Bool RefreshVals = false)
	If RefreshVals ; Prep and exp generally won't change mid dance so only refresh when needed
		Return GetPerformanceFactor() * ((GetPreparationFactor() * 0.7) + (GetExperienceFactor() * 0.3))
	EndIf
	Return GetPerformanceFactor() * ((LastPrepFactor * 0.7) + (LastExpFactor * 0.3))
EndFunction

Float Function GetPreparationFactor()
	LastPrepFactor = 0.01 + (GetBodyFactor() * 0.19) + (GetFashionFactorOverall() * 0.30) + (GetLooksFactor() * 0.50)
	Return LastPrepFactor
EndFunction

Float Function GetExperienceFactor()
	LastExpFactor = (0.5 * (StorageUtil.GetIntValue(PlayerRef, "_SLS_DanceExp") / 100)) + (0.5 * (StorageUtil.GetIntValue(PlayerRef, "_SLS_DanceExp" + LastDance) / 10))
	Return LastExpFactor
EndFunction

Float Function GetPerformanceFactor()
	;Debug.Messagebox("Health: " + PlayerRef.GetActorValuePercentage("Health") + "\nStamina: " + PlayerRef.GetActorValuePercentage("Stamina") + "\nMagicka: " + PlayerRef.GetActorValuePercentage("Magicka"))
	LastPerfFactor = 0.001 + (0.333 * PlayerRef.GetActorValuePercentage("Health")) + (0.333 * PlayerRef.GetActorValuePercentage("Stamina")) + (0.333 * PlayerRef.GetActorValuePercentage("Magicka"))
	Return LastPerfFactor
EndFunction

Float Function GetLooksFactor()
	Float LooksFactor
	If 	BikCurse.IsWearingHeels(PlayerRef)
		LooksFactor += 0.2
	ElseIf !PlayerRef.GetWornForm(0x00000080) ; Barefoot better than ugly boots
		LooksFactor += 0.1
	Else
		LooksFactor -= 0.2
	EndIf
	
	If Sla.IsWearingStockings(PlayerRef)
		LooksFactor += 0.2
	Else
		LooksFactor -= 0.2
	EndIf
	
	If _SLS_BodyCoverStatus.GetValueInt() == 0 ; Naked
		LooksFactor += 0.6
	ElseIf _SLS_BodyCoverStatus.GetValueInt() == 1 ; bikini/slooty
		LooksFactor += 0.4
	Else ; Normal/clothes armor
		LooksFactor -= 0.6
	EndIf
	Return LooksFactor
EndFunction

Float Function GetBodyFactor()
	Return _SLS_BodyInflationScale.GetValue()
EndFunction

Float Function GetFashionFactorOverall()
	If Fashion.GetState() == "Installed"
		Float FashionFactor = GetFashionFactor("yps_LipstickColor", "yps_LipstickSmudged")
		FashionFactor += GetFashionFactor("yps_EyeShadowColor", "yps_EyeShadowSmudged")
		FashionFactor += GetFashionFactor("yps_FingerNailPolishColor", "yps_FingerNailPolishSmudged")
		FashionFactor += GetFashionFactor("yps_ToeNailPolishColor", "yps_ToeNailPolishSmudged")
		
		If StorageUtil.GetIntValue(None, "YpsCurrentHairLengthStage") < 8 ; Less than shoulder length = penalty (need to check 4 is shoulder length)
			FashionFactor += (-0.3 * ((8 - StorageUtil.GetIntValue(None, "YpsCurrentHairLengthStage")) / 8))
		Else
			FashionFactor += (0.3 * (StorageUtil.GetIntValue(None, "YpsCurrentHairLengthStage") / 21))
		EndIf
		Return FashionFactor
	EndIf
	Return 0.0
EndFunction

Float Function GetFashionFactor(String Area, String Smudged)
	If StorageUtil.GetStringValue(None, Area) != "" ; Colored
		If StorageUtil.GetIntValue(None, Smudged) == 0 ; Not smudged
			Return 0.175
		Else ; Colored but smudged
			Return -0.175
		EndIf
	EndIf
	Return 0.0 ; Not colored
EndFunction

Function GetItem(Actor akActor)
	Float RanNum = Utility.RandomFloat(0.0, 100.0)
	If RanNum >= 50.0
		PlayerRef.AddItem(Gold001, Utility.RandomInt((MaxGold * LastPerfFactor - ((MaxGold * LastPerfFactor) * 0.33)) as Int, (MaxGold * LastPerfFactor + ((MaxGold * LastPerfFactor) * 0.33)) as Int))
	Else
		ThrowGold()
	EndIf
EndFunction

Function Whistle(Actor akActor)
	Util.DoCatCall(akActor)
EndFunction

Function ThrowGold()
	_SLS_TossedCoinsMarker.MoveTo(PlayerRef, Utility.RandomInt(-100, 100) * Math.Sin(PlayerRef.GetAngleZ()), Utility.RandomInt(-100, 100) * Math.Cos(PlayerRef.GetAngleZ()), PlayerRef.GetHeight() - 25.0)
	ObjectReference Coins = _SLS_TossedCoinsMarker.PlaceAtMe(_SLS_DancingCoins01, 1)
	Float Pc = (MaxGold * LastPerfFactor) * 0.2
	(Coins as _SLS_DancingCoins).CoinMin = (MaxGold * LastPerfFactor - ((MaxGold * LastPerfFactor) * 0.33)) as Int
	(Coins as _SLS_DancingCoins).CoinMax = (MaxGold * LastPerfFactor + ((MaxGold * LastPerfFactor) * 0.33)) as Int
	Coins.SetActorOwner(Player)
EndFunction

Function ThrowJunk(Actor akActor, Actor akTarget)
	;Float Opp = Math.Sin(akActor.GetHeadingAngle(akTarget)) * 40.0
	;Float Opp = Math.Sin(akActor.GetAngleZ()) * 40.0
	Debug.SendAnimationEvent(akActor, "IdleStop")
	Utility.Wait(0.5)
	Debug.SendAnimationEvent(akActor, "IdleTake")
	Utility.Wait(0.2)
	ObjectReference Junk = akActor.PlaceAtMe(JunkItems[Utility.RandomInt(0, JunkItems.Length - 1)], 1, abInitiallyDisabled = true)
	Float Power = Utility.RandomFloat(30.0, 35.0)
	If Junk.GetBaseObject() != JunkItems[2] ; Tankard
		Power = Power * 0.5
	EndIf
	
	;Junk.MoveTo(akActor, afXOffset = (Math.Cos(GameAngleZ) * 40.0), afYOffset = Math.Sin(GameAngleZ) * 40.0, afZOffset = 100.0)
	Junk.MoveTo(akActor, 40.0 * Math.Sin(akActor.GetAngleZ()), 40.0 * Math.Cos(akActor.GetAngleZ()), akActor.GetHeight() - 20.0)
	Junk.Enable()
	Utility.Wait(0.01)
	Junk.ApplyHavokImpulse(akTarget.GetPositionX() - Junk.GetPositionX(), akTarget.GetPositionY() - Junk.GetPositionY(), Utility.RandomFloat(-0.2, 0.4), Power)
EndFunction

Function AddSpectator()
	_SLS_DanceSearchQuest.Stop()
	_SLS_DanceSearchQuest.Start()
	
	Actor akSpec = (_SLS_DanceSearchQuest.GetNthAlias(0) as ReferenceAlias).GetReference() as Actor
	If akSpec
		ReferenceAlias akAlias = GetEmptyAlias(_SLS_DanceSpecQuest)
		If akAlias
			SpecCount += 1.0
			ThresTotal += (SetupActor(akSpec) + CurLocThres)
			(akAlias as ReferenceAlias).ForceRefTo(akSpec)
			(akAlias as _SLS_DancePlayerSpecAlias).BeginSpectating(akSpec)
			akSpec.SetLookAt(PlayerRef)
			_SLS_DanceSpecs.AddForm(akSpec) ; REMOVE ------------------------------------------------------------<<<<<<
			If GetBudget(akSpec) > 0
				;akSpec.AddToFaction(_SLS_DancePayFact)
				_SLS_DancePayingSpecs.AddForm(akSpec)
			Else
				_SLS_DanceSpecs.AddForm(akSpec)
			EndIf
		EndIf
	EndIf
EndFunction

Function BeginDance(Actor akActor, String Dance)
	If CanDance()
		GoToState("Dancing")
		akActor.AddToFaction(_SLS_DancingFaction)
		CurLocThres = GetLocationThreshold()
		
		
		LastDance = Dance
		SetMaxGold()
		GetPerfRating(RefreshVals = true)
		Debug.SendAnimationEvent(akActor, Dance)
		RegisterForAnimationEvent(PlayerRef, "FootLeft")
		RegisterForAnimationEvent(PlayerRef, "FootRight")
		RegisterForAnimationEvent(PlayerRef, "JumpUp")
		RegisterForAnimationEvent(PlayerRef, "IdlePlayer")
		RegisterForAnimationEvent(PlayerRef, "IdleForceDefaultState")
		RegisterForAnimationEvent(PlayerRef, "IdleStop")
		RegForControls()
		_SLS_DanceSpecQuest.Start()
		RegisterForSingleUpdate(2.0)
	EndIf
EndFunction

Function RegForControls()
	RegisterForControl("Move")
	RegisterForControl("Forward")
	RegisterForControl("Back")
	RegisterForControl("Strafe Left")
	RegisterForControl("Strafe Right")
EndFunction

Function UnRegForControls()
	UnRegisterForControl("Move")
	UnRegisterForControl("Forward")
	UnRegisterForControl("Back")
	UnRegisterForControl("Strafe Left")
	UnRegisterForControl("Strafe Right")
EndFunction

Function SetMaxGold()
	MaxGold = 1 + ((((GetPreparationFactor() * 0.5) + (GetExperienceFactor() * 0.5)) * (30 - 1)) as Int)
	;Debug.Messagebox("MaxGold: " + MaxGold)
EndFunction

Bool Function CanDance()
	If PlayerRef.GetAv("Stamina") < 10.0 || PlayerRef.GetAv("Magicka") < 10.0
		Debug.Notification("I'm too exhausted to dance")
		Return false
	EndIf
	Return true
EndFunction

Event OnAnimationEvent(ObjectReference akSource, string asEventName) ; Moving ends dancing
	Debug.Messagebox(asEventName)
	EndDance(PlayerRef)
EndEvent

Function EndDance(Actor akActor)
	Debug.Messagebox("Stop")
	GoToState("NotDancing")
	UnRegisterForUpdate()
	akActor.RemoveFromFaction(_SLS_DancingFaction)
	UnRegisterForAnimationEvent(PlayerRef, "FootLeft")
	UnRegisterForAnimationEvent(PlayerRef, "FootRight")
	UnRegisterForAnimationEvent(PlayerRef, "JumpUp")
	UnRegisterForAnimationEvent(PlayerRef, "IdleForceDefaultState")
	UnRegisterForAnimationEvent(PlayerRef, "IdleStop")
	SpecCount = 0.0
	ThresTotal = 0.0
	_SLS_DancePayingSpecs.Revert()
	_SLS_DanceSpecs.Revert()
	IncDanceExp(akActor, LastDance)
	Debug.SendAnimationEvent(akActor, "IdleForceDefaultState")
	StopPlayerSpectating()
EndFunction

Function IncDanceExp(Actor akActor, String Dance)
	StorageUtil.AdjustIntValue(akActor, "_SLS_DanceExp_" + Dance, 1)
	StorageUtil.AdjustIntValue(akActor, "_SLS_DanceExp", 1)
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

Function StopPlayerSpectating()
	Int i = _SLS_DanceSpecQuest.GetNumAliases()
	Actor akActor
	While i > 0
		i -= 1
		akActor = (_SLS_DanceSpecQuest.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
		If akActor
			(_SLS_DanceSpecQuest.GetNthAlias(i) as ReferenceAlias).Clear()
			akActor.RemoveFromFaction(_SLS_DanceActionFaction)
			akActor.EvaluatePackage()
		EndIf
	EndWhile
	_SLS_DanceSpecQuest.Stop()
EndFunction

Function SetSelectedDanceList(Int ModSelect)
	SelectedDanceList = JsonUtil.StringListToArray("SL Survival/DanceAnims.json", DanceMods[ModSelect])
EndFunction

Float Function GetLocationThreshold()
	; Some locations are more suitable than others....
	Float LocThres = LocTrack.GetDanceLocThreshold() ; 0.0 - 0.5 depending on how affluent the location. 

	; Modifers
	Location akLoc = PlayerRef.GetCurrentLocation()
	If PlayerRef.IsInInterior()
		LocThres -= 0.10
		If akLoc.HasKeyword(LocTypeInn)
			LocThres -= 0.10
		EndIf
	EndIf
	Return LocThres
EndFunction

Float Function SetupActor(Actor akActor)
	Float Thres = GetActorThreshold(akActor)
	If StorageUtil.GetFloatValue(akActor, "_SLS_LastDanceSession", Missing = -1.0) == -1.0 || Utility.GetCurrentGameTime() - StorageUtil.GetFloatValue(akActor, "_SLS_LastDanceSession", Missing = -1.0) >= 1.0 ; Budget never set or set 1 day ago. 
		StorageUtil.SetFloatValue(akActor, "_SLS_LastDanceSession", Utility.GetCurrentGameTime())
		SetActorBudget(akActor, Thres)	
	EndIf
	Debug.Messagebox("Actor: " + akActor.GetLeveledActorBase().GetName() + "\nThres: " + Thres + "\nLocThres: " + CurLocThres + "\n\nThresTotal: " + (ThresTotal + Thres + CurLocThres))
	Return Thres
EndFunction

Bool Function IsEnjoyingPerf(Actor akActor)
	If LastPerfFactor * (LastExpFactor + LastPrepFactor) >= GetActorThreshold(akActor) + CurLocThres
		Return true
	EndIf
	Return false
EndFunction

Bool Function IsHatingPerf(Actor akActor)
	If (GetActorThreshold(akActor) + CurLocThres) - (LastPerfFactor * (LastExpFactor + LastPrepFactor)) >= 0.1
		Return true
	EndIf
	Return false
EndFunction

Bool Function IsCrowdHatingPerf()
;/
	If SpecCount > 0.0
		Debug.Messagebox("Avg Threshold: " + (ThresTotal / SpecCount) + \
						"\n\nLastPerfFactor: " + LastPerfFactor + "\nLastExpFactor: " + LastExpFactor + "\nLastPrepFactor: " + LastPrepFactor + \
						"\n\n_SLS_DanceSpecs: " + _SLS_DanceSpecs.GetSize() + "\n_SLS_DancePayingSpecs: " + _SLS_DancePayingSpecs.GetSize() + \
						"\n\nPerf overall: " + GetPerfRating(RefreshVals = false))
	EndIf
	/;
	If SpecCount > 0.0 && (ThresTotal / SpecCount) - (LastPerfFactor * (LastExpFactor + LastPrepFactor)) >= 0.1 && ;/_SLS_DancePayingSpecs.GetSize() == 0 &&/; _SLS_DanceSpecs.GetSize() >= 2
		Return true
	EndIf
	Return false
EndFunction

Int Function GetBudget(Actor akActor)
	Return StorageUtil.GetIntValue(akActor, "_SLS_DanceBudget", Missing = 0)
EndFunction

Function SetActorBudget(Actor akActor, Float Thres)
	StorageUtil.SetIntValue(akActor, "_SLS_DanceBudget", ((Thres * 400) as Int) + Utility.RandomInt((Thres * 400 * -0.2) as Int, (Thres * 400 * 0.2) as Int))
EndFunction

Float Function GetActorThreshold(Actor akActor)
	; Rich Npcs are less interested in poor performances. Need to up your game to get gold from them
	; Rich Npcs have a higher threshold = higher budget too.
	
	; Going to have to make a lot of assumptions here.....
	Armor akArmor = akActor.GetWornForm(0x00000004) as Armor
	If akArmor
		If akArmor.IsClothingRich()
			Return 0.5
		ElseIf akArmor.GetWeightClass() <= 1 ; Light or heavy
			If akArmor.GetGoldValue() >= 400 ; Rich armor
				Return 0.4
			Else ; Average
				Return 0.25
			EndIf
		ElseIf akArmor.IsClothingPoor()
			Return 0.0
		Else ; Normal clothes
			Return 0.2
		EndIf
	
	Else ; Poor
		Return 0.0
	EndIf
EndFunction

Function FinishAction(Actor akActor, Int ActionFactionRank)
	akActor.SetFactionRank(_SLS_DanceActionFaction, ActionFactionRank)
	;akActor.EvaluatePackage()
EndFunction

String Function PrintActionFactionList(Actor akActor)
	Int FactRank = akActor.GetFactionRank(_SLS_DanceActionFaction)
	If FactRank == 0
		Return FactRank + ": Hate Idle"
	ElseIf FactRank == 1
		Return FactRank + ": Booo"
	ElseIf FactRank == 2
		Return FactRank + ": ThrowJunk"
	ElseIf FactRank == 3
		Return FactRank + ": Mock"
	ElseIf FactRank == 10
		Return FactRank + ": Love Idle"
	ElseIf FactRank == 11
		Return FactRank + ": Complement"
	ElseIf FactRank == 12
		Return FactRank + ": WolfWhistle"
	ElseIf FactRank == 13
		Return FactRank + ": Gold"
	ElseIf FactRank == 14
		Return FactRank + ": ThrowGold"
	EndIf
EndFunction

Function BuildDancesArray()
	StorageUtil.StringListAdd(Self, "_SLS_DanceModsTemp", "Stop Dancing")
	StorageUtil.StringListAdd(Self, "_SLS_DanceModsTemp", "Random Dance")
	
	Int i = 0
	String FileName
	String ModName
	While i < JsonUtil.StringListCount("SL Survival/DanceAnims.json", "dancefiles")
		FileName = JsonUtil.StringListGet("SL Survival/DanceAnims.json", "dancefiles", i)
		If MiscUtil.FileExists(FileName)
			Debug.Trace("_SLS_: BuildDancesArray(): Does exist: " + FileName)
			ModName = JsonUtil.StringListGet("SL Survival/DanceAnims.json", "dancemods", i)
			StorageUtil.StringListAdd(Self, "_SLS_DanceModsTemp", ModName)
			
			Int j = 0
			While j < JsonUtil.StringListCount("SL Survival/DanceAnims.json", ModName)
				Debug.Trace("_SLS_: BuildDancesArray(): Adding: " + JsonUtil.StringListGet("SL Survival/DanceAnims.json", ModName, i))
				StorageUtil.StringListAdd(Self, "_SLS_DanceAnimsTemp", JsonUtil.StringListGet("SL Survival/DanceAnims.json", ModName, i))
				j += 1
			EndWhile
		Else
			Debug.Trace("_SLS_: BuildDancesArray(): Does NOT exist: " + FileName)
		EndIf
		i += 1
	EndWhile
	
	DanceMods = StorageUtil.StringListToArray(Self, "_SLS_DanceModsTemp")
	DancesList = StorageUtil.StringListToArray(Self, "_SLS_DanceAnimsTemp")
	StorageUtil.StringListClear(Self, "_SLS_DanceAnimsTemp")
	StorageUtil.StringListClear(Self, "_SLS_DanceModsTemp")
EndFunction

Function BuildJunkList()
	JunkItems = new Form[3]
	JunkItems[0] = Game.GetFormFromFile(0x0FFEED, "SL Survival.esp") ; tomato
	JunkItems[1] = Game.GetFormFromFile(0x0FFEEE, "SL Survival.esp") ; cabbage
	JunkItems[2] = Game.GetFormFromFile(0x0FFEEF, "SL Survival.esp") ; tankard
EndFunction

Function BuildSpecActionLists()
	DanceHateActions = new String[5]
	DanceHateActions[0] = "HateIdle"
	DanceHateActions[1] = "Booo"
	DanceHateActions[2] = "ThrowJunk"
	DanceHateActions[3] = "Mock"
	DanceHateActions[4] = "Laugh"
	
	DanceLoveActions = new String[5]
	DanceLoveActions[0] = "LoveIdle"
	DanceLoveActions[1] = "Complement"
	DanceLoveActions[2] = "WolfWhistle"
	DanceLoveActions[3] = "Gold"
	;DanceLoveActions[4] = "ThrowGold"
EndFunction

;/
Function ShowPerformanceStats()
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	
	ListMenu.AddEntryItem(Dance.SelectedDanceList[i])
	
	ListMenu.OpenMenu()
	;Debug.Messagebox(ListMenu.GetResultInt())
	Return ListMenu.GetResultInt()
EndFunction
/;
Int Property MaxGold = 30 Auto Hidden

Float SpecCount
Float CurLocThres
Float ThresTotal
Float Property LastPerfFactor Auto Hidden
Float LastExpFactor
Float LastPrepFactor

String LastDance

String[] Property DancesList Auto Hidden
String[] Property DanceMods Auto Hidden
String[] Property SelectedDanceList Auto Hidden
String[] Property DanceHateActions Auto Hidden
String[] Property DanceLoveActions Auto Hidden

Form[] JunkItems

Actor Property PlayerRef Auto

ActorBase Property Player Auto

Keyword Property LocTypeInn Auto

Faction Property _SLS_DancingFaction Auto

Faction Property _SLS_DanceActionFaction Auto
; Ranks
; 0 - Hate Idle, 1 - Booo, 2 - ThrowJunk, 3 - Mock, 4 - Laugh
; 10 - Love Idle, 11 - Complement, 12 - WolfWhistle, 13 - Gold, 14 - ThrowGold

Formlist Property _SLS_DanceSpecs Auto
Formlist Property _SLS_DancePayingSpecs Auto

ObjectReference Property _SLS_TossedCoinsMarker Auto

MiscObject Property _SLS_DancingCoins01 Auto
MiscObject Property Gold001 Auto

Quest Property _SLS_DanceSearchQuest Auto
Quest Property _SLS_DanceSpecQuest Auto

GlobalVariable Property _SLS_BodyInflationScale Auto
GlobalVariable Property _SLS_BodyCoverStatus Auto ; 0 - Naked, 1 - Bikini/Slooty armor/clothes, 2 - Non skimpy armor/clothes
GlobalVariable Property _SLS_DanceCrowdHate Auto

SLS_Utility Property Util Auto
_SLS_LocTrackCentral Property LocTrack Auto
_SLS_LicBikiniCurse Property BikCurse Auto
_SLS_InterfaceFashion Property Fashion Auto
_SLS_InterfaceSlax Property Sla Auto
