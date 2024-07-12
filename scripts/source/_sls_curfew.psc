Scriptname _SLS_Curfew extends Quest Conditional

Event OnInit()
	If Self.IsRunning()
		CheckCurfewState()
		RegisterForEvents()
		RegisterForModEvent("_SLS_PlayerIsInSlavetown", "On_SLS_PlayerIsInSlavetown")
	EndIf
EndEvent

Function RegisterForEvents()
	UnRegisterForAllModEvents()
	RegisterForModEvent("_SLS_PlayerIsInSlavetown", "On_SLS_PlayerIsInSlavetown")
	RegisterForModEvent("PCSubFree", "_On_SD_PCSubFree")
	RegisterForModEvent("SDEnslavedStart", "_On_SD_SDEnslavedStart")
EndFunction

Event On_SLS_PlayerIsInSlavetown(string eventName, string strArg, float numArg, Form sender)
	CheckCurfewState()
EndEvent

Event _On_SD_SDEnslavedStart(string eventName, string strArg, float numArg, Form sender)
	;Debug.Messagebox("_On_SD_SDEnslavedStart")
	_SLS_CurfewViolation.SetValueInt(0)
EndEvent

Event _On_SD_PCSubFree(string eventName, string strArg, float numArg, Form sender)
	;Debug.Messagebox("Freed")
	Utility.Wait(3.0)
	IsViolatingCurfew()
EndEvent

Event OnUpdateGameTime()
	Bool CurfewBefore = _SLS_CurfewIsInEffect.GetValueInt() as Bool
	CheckCurfewState()
	If CurfewBefore && !(_SLS_CurfewIsInEffect.GetValueInt()) ; Curfew was in effect but now has ended
		CurfewViolationCount = 0
	EndIf
EndEvent

State Active
	Function IsViolatingCurfew()
		If !PlayerRef.IsInInterior() && StorageUtil.GetIntValue(PlayerRef, "_SD_iEnslaved") != 1 && (LicUtil.LicCurfewEnable && !LicUtil.HasValidCurfewLicence && !LicUtil.HasValidWhoreLicence)
			;Debug.Messagebox("Pass")
			_SLS_PlayerIsAIDriven.SetValueInt((PlayerRef.GetCurrentPackage() != None) as Int)
			_SLS_CurfewViolation.SetValueInt(1)
			_SLS_CurfewGuardAliases.Stop()
			_SLS_CurfewGuardAliases.Start()
			;Return
		EndIf
		;Debug.Messagebox("Fail")
	EndFunction
EndState

Function IsViolatingCurfew()
	_SLS_CurfewViolation.SetValueInt(0)
	;Return false
EndFunction

Function SetUpdateTime(Float TargetHour)
	Float CurHour = GameHour.GetValue()
	If TargetHour > CurHour
	
		; Add 0.1 on to the update time to make sure updates occur after begin/end times. Otherwise errors in the calc cause updates to 
		; occur just before begin/end times resulting in many updates being made. It won't matter if curfew begins/ends slightly later than exactly 21:00/06:00
		; Also creates 'leeway' in curfew start time. 
		
		;Debug.Messagebox("Current Hour: " + CurHour + "\n\nUpdate 1: " + ((TargetHour + 0.1) - CurHour))
		RegisterForSingleUpdateGameTime((TargetHour + 0.1) - CurHour)
	Else
		;Debug.Messagebox("Current Hour: " + CurHour + "\n\nUpdate 2: " + ((24.0 - CurHour) + TargetHour))
		RegisterForSingleUpdateGameTime((24.0 - CurHour) + (TargetHour + 0.1))
	EndIf
EndFunction

Function CheckCurfewState()
	Float CurHour = GameHour.GetValue()
	
	GlobalVariable CurfewStart
	GlobalVariable CurfewEnd
	If LocTrackCentral.PlayerIsInSlavetown == 1
		CurfewStart = _SLS_CurfewSlavetownBegin
		CurfewEnd = _SLS_CurfewSlavetownEnd
	Else
		CurfewStart = _SLS_CurfewBegin
		CurfewEnd = _SLS_CurfewEnd
	EndIf
	
	If CurfewEnd.GetValue() > CurfewStart.GetValue() ; Curfew ends on the same day. This will probably never be a thing.
		If CurHour >= CurfewStart.GetValue() && CurHour < CurfewEnd.GetValue() - 0.1 && LicUtil.LicCurfewEnable
			If DoCurfewNotification && _SLS_CurfewIsInEffect.GetValueInt() == 0
				Debug.Notification("Curfew has begun")
			EndIf
			_SLS_CurfewIsInEffect.SetValueInt(1)
			GoToState("Active")
			TollUtil.RecheckGateConditions()
			If Menu.TollDodging
				TollDodge.TollGateLoad(LocTrackCentral.PlayerCurrentLocString, Main.Init.IsPlayerInside)
			EndIf
			SetUpdateTime(TargetHour = CurfewEnd.GetValue() - 0.1)
			IsViolatingCurfew()
		Else
			If DoCurfewNotification && _SLS_CurfewIsInEffect.GetValueInt() == 1
				Debug.Notification("Curfew is ending")
			EndIf
			_SLS_CurfewIsInEffect.SetValueInt(0)
			_SLS_CurfewViolation.SetValueInt(0)
			GoToState("")
			_SLS_CurfewGuardAliases.Stop()
			TollUtil.RecheckGateConditions()
			If Main.Init.TollEnable
				If Menu.TollDodging
					TollDodge.TollGateLoad(LocTrackCentral.PlayerCurrentLocString, Main.Init.IsPlayerInside)
				EndIf
				If LocTrackCentral.ResidentsDontPayTolls && LocTrackCentral.HasHomeAtLoc()
					Main.Init.IsTollPaid = true
					TollDodge.PaidToll()
				EndIf
			EndIf
			SetUpdateTime(TargetHour = CurfewStart.GetValue())
		EndIf
	
	Else ; Curfew ends the day after
		If CurHour >= CurfewStart.GetValue() || CurHour < CurfewEnd.GetValue() - 0.1 && LicUtil.LicCurfewEnable
			If DoCurfewNotification && _SLS_CurfewIsInEffect.GetValueInt() == 0
				Debug.Notification("Curfew has begun")
			EndIf
			_SLS_CurfewIsInEffect.SetValueInt(1)
			GoToState("Active")
			TollUtil.RecheckGateConditions()
			If Menu.TollDodging
				TollDodge.TollGateLoad(LocTrackCentral.PlayerCurrentLocString, Main.Init.IsPlayerInside)
			EndIf
			SetUpdateTime(TargetHour = CurfewEnd.GetValue() - 0.1)
			IsViolatingCurfew()
		Else
			If DoCurfewNotification && _SLS_CurfewIsInEffect.GetValueInt() == 1
				Debug.Notification("Curfew is ending")
			EndIf
			_SLS_CurfewIsInEffect.SetValueInt(0)
			_SLS_CurfewViolation.SetValueInt(0)
			GoToState("")
			_SLS_CurfewGuardAliases.Stop()
			TollUtil.RecheckGateConditions()
			If Main.Init.TollEnable
				If Menu.TollDodging
					TollDodge.TollGateLoad(LocTrackCentral.PlayerCurrentLocString, Main.Init.IsPlayerInside)
				EndIf
				If LocTrackCentral.ResidentsDontPayTolls && LocTrackCentral.HasHomeAtLoc()
					Main.Init.IsTollPaid = true
					TollDodge.PaidToll()
				EndIf
			EndIf
			SetUpdateTime(TargetHour = CurfewStart.GetValue())
		EndIf
	EndIf
EndFunction

Function EndIntro()
	;Debug.Messagebox("END")
	_SLS_CurfewGuardAliases.Stop()
	_SLS_CurfewViolation.SetValueInt(0)
	;_SLS_CurfewIsInEffect.SetValueInt(0)
	GoToState("")
	Self.SetStage(10)
	CurfewTimer.SetRestartDelay(Delay = TimeToClearStreets)
	CurfewViolationCount += 2
EndFunction

Function CurfewBeginChat()
	CaughtBreakingCurfew()
	CurfewTimer.SetRestartDelay(Delay = TimeToClearStreets)
EndFunction

Function CaughtBreakingCurfew()
	_SLS_CurfewGuardAliases.Stop()
	_SLS_CurfewViolation.SetValueInt(0)
	CurfewViolationCount += 1
EndFunction

Function RestartCurfewLaw()
	CheckCurfewState()
	If !PlayerRef.IsInInterior()
		_SLS_CurfewGuardAliases.Stop()
		_SLS_CurfewGuardAliases.Start()
	EndIf
EndFunction

Function UpdateCurfewVariables()
	PlayerLocationIndex = LocTrackCentral.PlayerCurrentLocIndex
	OwnsHomeAtLocation = LocTrackCentral.HasHomeAtLoc()
	IsEvictedAtLocation = LocTrackCentral.IsEvictedAtLoc()
	LocationHasInn = LocTrackCentral.PlayerCurrentLocString != ""
	;Debug.Messagebox("Update" + "\nPlayerCurrentLocString: " + LocTrackCentral.PlayerCurrentLocString + "\nPlayerLocationIndex: " + PlayerLocationIndex + "\nLocationHasInn: " + LocationHasInn + "\nOwnsHomeAtLocation: " + OwnsHomeAtLocation + "\nIsEvictedAtLocation: " + IsEvictedAtLocation)
EndFunction

Function UpdateDecisionFactors(Actor akSpeaker)
	_SLS_CurfewViolation.SetValueInt(0)
	PlayerLocationIndex = LocTrackCentral.PlayerCurrentLocIndex
	If PlayerLocationIndex > -1
		LocationHasInn = true
		OwnsHomeAtLocation = LocTrackCentral.HasHomeAtLoc()
		IsEvictedAtLocation = LocTrackCentral.IsEvictedAtLoc()
	Else
		OwnsHomeAtLocation = false
		IsEvictedAtLocation = false
		LocationHasInn = false
	EndIf
	
	StopOtherGuards(akSpeaker)
	SetCurfewHomeVars(akSpeaker)
	;Debug.Messagebox("DecisionFactors\nPlayerCurrentLocString: " + LocTrackCentral.PlayerCurrentLocString +"\nPlayerLocationIndex: " + PlayerLocationIndex + "\nLocationHasInn: " + LocationHasInn + "\nOwnsHomeAtLocation: " + OwnsHomeAtLocation + "\nIsEvictedAtLocation: " + IsEvictedAtLocation)
EndFunction

Function StopOtherGuards(Actor akSpeaker)
	Int i = 0
	Actor Guard
	While i < _SLS_CurfewGuardAliases.GetNumAliases()
		Guard = (_SLS_CurfewGuardAliases.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
		If Guard && Guard != akSpeaker
			(_SLS_CurfewGuardAliases.GetNthAlias(i) as ReferenceAlias).Clear()
			Guard.EvaluatePackage()
		EndIf
		i += 1
	EndWhile
EndFunction
;/
Bool Function GetHasHomeAtLocationByIndex(Int CrimeFactIndex)
	If CrimeFactIndex == 0 ; Whiterun
		If Eviction.OwnsWhiterun
			Return true
		EndIf
	ElseIf CrimeFactIndex == 1 ; Solitude
		If Eviction.OwnsSolitude
			Return true
		EndIf
	ElseIf CrimeFactIndex == 2 ; Markarth
		If Eviction.OwnsMarkarth
			Return true
		EndIf
	ElseIf CrimeFactIndex == 3 ; Windhelm
		If Eviction.OwnsWindhelm
			Return true
		EndIf
	ElseIf CrimeFactIndex == 4 ; Riften
		If Eviction.OwnsRiften
			Return true
		EndIf
	EndIf
	Return false
EndFunction
/;
;/
Bool Function GetIsEvictedAtLocationByIndex(Int CrimeFactIndex)
	If CrimeFactIndex == 0 ; Whiterun
		If Eviction.IsBarredWhiterun
			Return true
		EndIf
	ElseIf CrimeFactIndex == 1 ; Solitude
		If Eviction.IsBarredSolitude
			Return true
		EndIf
	ElseIf CrimeFactIndex == 2 ; Markarth
		If Eviction.IsBarredMarkarth
			Return true
		EndIf
	ElseIf CrimeFactIndex == 3 ; Windhelm
		If Eviction.IsBarredWindhelm
			Return true
		EndIf
	ElseIf CrimeFactIndex == 4 ; Riften
		If Eviction.IsBarredRiften
			Return true
		EndIf
	EndIf
	Return false
EndFunction
/;
;/
Int Function GetInnCostAtLocation(Int LocIndex)
	Return _SLS_CurfewInnCostAtLocation.GetValue()
EndFunction
/;

Function PortToBeggarLair(Actor akSpeaker)
	If akSpeaker.GetCrimeFaction() == CrimeFactions[2]
		PortToTheWarrens(akSpeaker)
	Else
		PortToBeggarsRow(akSpeaker)
	EndIf
EndFunction

Function PortToTheWarrens(Actor akSpeaker)
	CaughtBreakingCurfew()
	Utility.WaitMenuMode(2.5)
	(Game.GetFormFromFile(0x16F6D, "Skyrim.esm") as ObjectReference).Activate(PlayerRef)
EndFunction

Function PortToBeggarsRow(Actor akSpeaker)
	CaughtBreakingCurfew()
	Utility.WaitMenuMode(2.5)
	(Game.GetFormFromFile(0x089D60, "Skyrim.esm") as ObjectReference).Activate(PlayerRef)
EndFunction

Function PortToKennel(Actor akSpeaker)
	CaughtBreakingCurfew()
	Utility.WaitMenuMode(2.5)
	Util.SendToKennel(akSpeaker)
EndFunction

Function PortToInn(Actor akSpeaker)
	CaughtBreakingCurfew()
	Utility.WaitMenuMode(2.5)
	Faction CrimeFact = akSpeaker.GetCrimeFaction()
	If CrimeFact
		Int i = CrimeFactions.Find(CrimeFact)
		If i > -1
			ObjectReference InnDoorRef = GetInnDoor()
			If InnDoorRef
				InnDoorRef.Activate(PlayerRef)
			EndIf
		EndIf
	Else
		Debug.Trace("_SLS_: PortToInn(): Could not resolve: akSpeaker: " + akSpeaker + ". CrimeFact: " + CrimeFact)
	EndIf
EndFunction

Function PortToHome(Actor akSpeaker)
	; Debug.CenterOnCell("WhiterunBreezehome") - causes the game to hang for some reason....
	CaughtBreakingCurfew()
	Utility.WaitMenuMode(2.5)
	;/
	Int i = CrimeFactions.Find(akSpeaker.GetCrimeFaction())
	If i > -1
		If i == 0
			ActivateDoor(Game.GetFormFromFile(0x1A6F9, "Skyrim.esm") as ObjectReference)
		ElseIf i == 1
			ActivateDoor(Game.GetFormFromFile(0x3AF95, "Skyrim.esm") as ObjectReference)
		ElseIf i == 2
			ActivateDoor(Game.GetFormFromFile(0x7BDBD, "Skyrim.esm") as ObjectReference)
		ElseIf i == 3
			ActivateDoor(Game.GetFormFromFile(0x16970, "Skyrim.esm") as ObjectReference)
		ElseIf i == 4
			ActivateDoor(Game.GetFormFromFile(0x42277, "Skyrim.esm") as ObjectReference)
		EndIf
	Else
		Debug.Trace("_SLS_: PortToHome(): Crimefaction: " + akSpeaker.GetCrimeFaction() + " for speaker: " + akSpeaker + " not found in list")
	EndIf	/;
	LocTrackCentral.PortPlayerToHomeByCrimeFaction(akSpeaker)
EndFunction

Function PortToWartimesHome(Actor akSpeaker)
	CaughtBreakingCurfew()
	Utility.WaitMenuMode(2.5)
	ObjectReference TheDoor = Game.GetFormFromFile(0x5A0D, "pchsWartimes.esp") as ObjectReference
	If TheDoor.IsLocked()
		TheDoor.Lock(abLock = false, abAsOwner = true)
	EndIf
	TheDoor.Activate(PlayerRef)
EndFunction

Function ActivateDoor(ObjectReference TheDoor)
	If TheDoor.IsLocked()
		TheDoor.Lock(abLock = false, abAsOwner = true)
	EndIf
	TheDoor.Activate(PlayerRef)
EndFunction

ObjectReference Function GetInnDoor()
	Return LocTrackCentral.GetInnDoor()
EndFunction

;/
ObjectReference Function GetInnDoorRefByIndex(Int Index)
	If !PlayerRef.IsInInterior() ; GetDistance won't work from interiors (equal large distance returned). Need to add cell check in case of exterior?
		If Index == 0 ; Whiterun hold
			Float DistMare = PlayerRef.GetDistance(Game.GetFormFromFile(0x1A6F4, "Skyrim.esm") as ObjectReference) ; Bannered Mare
			Float DistGiant = PlayerRef.GetDistance(Game.GetFormFromFile(0x13424, "Skyrim.esm") as ObjectReference) ; Sleeping Giant
			Float DistFrost = PlayerRef.GetDistance(Game.GetFormFromFile(0x177D1, "Skyrim.esm") as ObjectReference) ; Frostfruit Inn
			If DistGiant < DistMare && DistGiant < DistFrost ; Go To Sleeping giant
				Return Game.GetFormFromFile(0x13424, "Skyrim.esm") as ObjectReference
			ElseIf DistFrost < DistMare && DistFrost < DistGiant
				Return Game.GetFormFromFile(0x177D1, "Skyrim.esm") as ObjectReference
			Else
				Return Game.GetFormFromFile(0x1A6F4, "Skyrim.esm") as ObjectReference
			EndIf
		
		ElseIf Index == 1 ; Haafingar
			If PlayerRef.GetDistance(Game.GetFormFromFile(0x1775D, "Skyrim.esm") as ObjectReference) < PlayerRef.GetDistance(Game.GetFormFromFile(0x37F25, "Skyrim.esm") as ObjectReference) ; FourShields < WinkingSkeever
				Return Game.GetFormFromFile(0x1775D, "Skyrim.esm") as ObjectReference ; Four Shields
			Else
				Return Game.GetFormFromFile(0x37F25, "Skyrim.esm") as ObjectReference ; Winking Skeever
			EndIf
			
		ElseIf Index == 2 ; Reach
			If PlayerRef.GetDistance(Game.GetFormFromFile(0x1762F, "Skyrim.esm") as ObjectReference) < PlayerRef.GetDistance(Game.GetFormFromFile(0x16E3B, "Skyrim.esm") as ObjectReference) ; OldHroldan < SilverBlood
				Return Game.GetFormFromFile(0x1762F, "Skyrim.esm") as ObjectReference ; OldHroldan
			Else
				Return Game.GetFormFromFile(0x16E3B, "Skyrim.esm") as ObjectReference ; SilverBlood
			EndIf
			
		ElseIf Index == 3 ; Eastmarch
			If PlayerRef.GetDistance(Game.GetFormFromFile(0x177A5, "Skyrim.esm") as ObjectReference) < PlayerRef.GetDistance(Game.GetFormFromFile(0xD18B1, "Skyrim.esm") as ObjectReference) ; Braidwood < Candlehearth
				Return Game.GetFormFromFile(0x177A5, "Skyrim.esm") as ObjectReference ; Braidwood
			Else
				Return Game.GetFormFromFile(0xD18B1, "Skyrim.esm") as ObjectReference ; Candlehearth
			EndIf
			
		ElseIf Index == 4 ; Riften
			If PlayerRef.GetDistance(Game.GetFormFromFile(0x17797, "Skyrim.esm") as ObjectReference) < PlayerRef.GetDistance(Game.GetFormFromFile(0x430A6, "Skyrim.esm") as ObjectReference) ; Vilemyr < BeeAndBarb
				Return Game.GetFormFromFile(0x17797, "Skyrim.esm") as ObjectReference ; Vilemyr
			Else
				Return Game.GetFormFromFile(0x430A6, "Skyrim.esm") as ObjectReference ; BeeAndBarb
			EndIf
			
		ElseIf Index == 7 ; The Pale
			If PlayerRef.GetDistance(Game.GetFormFromFile(0x17786, "Skyrim.esm") as ObjectReference) < PlayerRef.GetDistance(Game.GetFormFromFile(0x17636, "Skyrim.esm") as ObjectReference) ; Nightgate <	 Windpeak
				Return Game.GetFormFromFile(0x17786, "Skyrim.esm") as ObjectReference ; Nightgate
			Else
				Return Game.GetFormFromFile(0x17636, "Skyrim.esm") as ObjectReference ; Windpeak
			EndIf
			
		Else
			Return _SLS_InnDoorsList.GetAt(Index) as ObjectReference ; Was there even any point in creating a list with all the exceptions?
		EndIf	
	EndIf
	Return None
EndFunction
/;
Function UpdatePunishmentDecisions()
	If PlayerRef.GetWornForm(0x00000004) != _SLS_HalfNakedCoverArmor ; Remove half naked covers left in inventory so it doesn't confuse GetKeywordItemCount.
		PlayerRef.RemoveItem(_SLS_HalfNakedCoverArmor, 999, true)
	EndIf
	Util.UpdateAddictions()
	Util.SetNumFreeDeviceSlots()
	Main.CheckFreeSlavetats()
EndFunction

Function PunishDrugs(Actor akSpeaker)
	(Game.GetFormFromFile(0x000D64, "SL Survival.esp") as _SLS_ForcedDrugging).DoRapeDrugs(PlayerRef, Quantity = 2, Silent = false)
	DidWalkAwayFromPunishment(akSpeaker)
EndFunction

Function PunishDevices(Actor akSpeaker)
	Devious.EquipRandomDds(PlayerRef, Quantity = 2)
	DidWalkAwayFromPunishment(akSpeaker)
EndFunction

Function PunishFine(Actor akSpeaker)
	PlayerRef.RemoveItem(Gold001, 100, false, akSpeaker)
	DidWalkAwayFromPunishment(akSpeaker)
EndFunction

Function PunishBounty(Actor akSpeaker)
	(akSpeaker.GetCrimeFaction()).ModCrimeGold(100)
	DidWalkAwayFromPunishment(akSpeaker)
EndFunction

Function PunishStrip(Actor akSpeaker)
	Form Clothes = PlayerRef.GetWornForm(0x00000004)
	If Clothes
		PlayerRef.RemoveItem(Clothes, 1, false, akSpeaker)
	EndIf
	DidWalkAwayFromPunishment(akSpeaker)
EndFunction

Function PunishGround(Actor akSpeaker)
	Util.IncreaseGroundTime(akSpeaker, LocInt = -1, Days = 1)
	DidWalkAwayFromPunishment(akSpeaker)
EndFunction

Function PunishTats(Actor akSpeaker)
	Int i = 0
	While i < TollUtil.TollCostTattoos
		SendModEvent("RapeTattoos_addTattoo")
		Utility.Wait(1.0)
		i += 1
	EndWhile
	DidWalkAwayFromPunishment(akSpeaker)
EndFunction

Function DidWalkAwayFromPunishment(Actor akSpeaker)
	If !akSpeaker.IsInDialogueWithPlayer()
		_SLS_CurfewGuardAliases.Stop()
		If Utility.RandomInt(0, 1) == 0
			PortToKennel(akSpeaker)
		Else
			PortToInn(akSpeaker)
		EndIf
	EndIf
EndFunction

Function SetCurfewHomeVars(Actor akSpeaker)
	HasVanillaHomeAtLoc = LocTrackCentral.HasVanillaHomeAtLoc()
	HasVanillaHomeInHold = LocTrackCentral.HasVanillaHomeInHold()
	HasKennelAtLoc = LocTrackCentral.HasKennelAtLoc()
	HasKennelInHold = LocTrackCentral.HasKennelInHold()
	HasBeggarLairAtLoc = LocTrackCentral.HasBeggarLairAtLoc()
	HasBeggarLairInHold = LocTrackCentral.HasBeggarLairInHold()
	HasWartimesHomeAtLoc = LocTrackCentral.HasWartimesHomeInHold()
EndFunction

Bool Property HasVanillaHomeAtLoc = false Auto Hidden Conditional
Bool Property HasVanillaHomeInHold = false Auto Hidden Conditional
Bool Property HasKennelAtLoc = false Auto Hidden Conditional
Bool Property HasKennelInHold = false Auto Hidden Conditional
;Bool Property HasInnAtLoc = false Auto Hidden Conditional ; Every tracked location has an inn....
Bool Property HasWartimesHomeAtLoc = false Auto Hidden Conditional
Bool Property HasBeggarLairAtLoc = false Auto Hidden Conditional
Bool Property HasBeggarLairInHold = false Auto Hidden Conditional

Bool Property DoCurfewNotification = true Auto Hidden
Bool Property LocationHasInn = false Auto Hidden Conditional
Bool Property OwnsHomeAtLocation = false Auto Hidden Conditional
Bool Property IsEvictedAtLocation = false Auto Hidden Conditional
Int Property PlayerLocationIndex = -1 Auto Hidden Conditional
Int Property CurfewViolationCount = 0 Auto Hidden Conditional
Int Property InnCostHere = 100 Auto Hidden
Float Property TimeToClearStreets = 60.0 Auto Hidden

Faction[] Property CrimeFactions Auto ; 0 - Whiterun, 1 - Solitude, 2 - Markarth, 3 - Windhelm, 4 - Riften, 5 - Falkreath, 6 - Morthal, 7 - Dawnstar, 8 - Winterhold

GlobalVariable Property GameHour Auto
GlobalVariable Property _SLS_CurfewBegin Auto
GlobalVariable Property _SLS_CurfewEnd Auto
GlobalVariable Property _SLS_CurfewSlavetownBegin Auto
GlobalVariable Property _SLS_CurfewSlavetownEnd Auto
GlobalVariable Property _SLS_CurfewIsInEffect Auto
GlobalVariable Property _SLS_CurfewViolation Auto
GlobalVariable Property _SLS_CurfewInnCostAtLocation Auto
GlobalVariable Property _SLS_PlayerIsAIDriven Auto

MiscObject Property Gold001 Auto

Formlist Property _SLS_InnDoorsList Auto ; 0 - Whiterun, 1 - Solitude, 2 - Markarth, 3 - Windhelm, 4 - Riften, 5 - Falkreath, 6 - Morthal, 7 - Dawnstar, 8 - Winterhold

Quest Property _SLS_CurfewGuardAliases Auto

Actor Property PlayerRef Auto

Armor Property _SLS_HalfNakedCoverArmor Auto

SLS_EvictionTrack Property Eviction Auto
SLS_Main Property Main Auto
SLS_Mcm Property Menu Auto
SLS_Utility Property Util Auto
_SLS_CurfewTimer Property CurfewTimer Auto
_SLS_LicenceUtil Property LicUtil Auto
_SLS_LocTrackCentral Property LocTrackCentral Auto
_SLS_TollUtil Property TollUtil Auto
_SLS_TollDodge Property TollDodge Auto

_SLS_InterfaceDevious Property Devious Auto
