Scriptname _SLS_LocTrackCentral extends Quest Conditional

; Sends mod event _SLS_PlayerIsInSlavetown when entering/leaving slavetown jurisdiction
; Also sets var PlayerIsInSlavetown

Event OnInit()
	If Self.IsRunning()
		LastTracker = Game.GetFormFromFile(0x0CD3FE, "SL Survival.esp") as ObjectReference ; dummy tracker in Storage to avoid operations on none
		LoadSlaverunLocations()
		SetupLists()
		SetupInnPrices()
	EndIf
EndEvent

Function PlayerLocChange(Location akOldLoc, Location akNewLoc)
	String OldJurisdiction = PlayerCurrentLocString
	PlayerCurrentLocString = ResolveLocation(akNewLoc)
	If PlayerCurrentLocString != OldJurisdiction ; Do stuff that needs to be done when town changes entirely.
		;Debug.Messagebox("NOT same jurisdiction")
		PlayerCurrentLocIndex = StorageUtil.StringListFind(Self, "_SLS_LocIndex", PlayerCurrentLocString)
		SetIsInsideWalls(PlayerCurrentLocIndex)
		SetIsPlayerInSlavetownByString(PlayerCurrentLocString)
		Curfew.UpdateCurfewVariables()
		;SetInnCostByIndex(PlayerCurrentLocIndex)
		SetInnCostByString(PlayerCurrentLocString)
		;Debug.Notification("Location: '" + PlayerCurrentLocString + "'\nInnCostHere: " + _SLS_CurfewInnCostAtLocation.GetValueInt())
		TownCheck.PlayerLocationChange(PlayerCurrentLocIndex, akNewLoc)
	
	;Else
		;Debug.Messagebox("Same jurisdiction")
	EndIf
	Curfew.IsViolatingCurfew()
	
	;Debug.Messagebox("Loc change: " + PlayerCurrentLocString + "\n_SLS_CurfewViolation: " + Curfew._SLS_CurfewViolation.GetValueInt() + "\nPlayerIsInSlavetown: " + PlayerIsInSlavetown + "\n\nakOldLoc: " + akOldLoc + "\nakNewLoc: " + akNewLoc)
EndFunction

Function TrackingMarkerCellAttach(ObjectReference Marker)
	;Debug.Messagebox("ATTACh: " + Marker)
	LastTracker = Marker
	PlayerLocChange(akOldLoc = None, akNewLoc = PlayerRef.GetCurrentLocation())
	SetIsPlayerInSlavetownByLocation(PlayerRef.GetCurrentLocation())
	_SLS_CurfewInnCostAtLocation.SetValue(GetInnCostByString(StorageUtil.StringListGet(Self, "_SLS_LocIndex", _SLS_LocTrackersAll.Find(Marker))))
	;TownCheck.MarkerAttach(Marker)
	;Debug.Messagebox("Marker: " + Marker + "\nRegion: " + PlayerCurrentLocString + "\n_SLS_CurfewViolation: " + Curfew._SLS_CurfewViolation.GetValueInt() + "\nPlayerIsInSlavetown: " + PlayerIsInSlavetown)
EndFunction

Function TrackingMarkerCellDetatch(ObjectReference Marker)
	;TownCheck.MarkerDetach(Marker)
EndFunction

String Function ResolveLocation(Location akNewLoc)
	If PlayerRef.IsInInterior()
		If akNewLoc
			Formlist FlSelect
			Int i = 0
			While i < _SLS_LocsAll.GetSize()
				FlSelect = _SLS_LocsAll.GetAt(i) as Formlist
				If FlSelect.HasForm(akNewLoc)
					Return StorageUtil.StringListGet(Self, "_SLS_LocIndex", i)
				EndIf
				i += 1
			EndWhile
		EndIf
	Else
		Int i = _SLS_LocTrackersAll.Find(LastTracker)
		If i <= 17 ; Single tracker system
			If LastTracker.Is3dLoaded()
				If i >= 5 ; Is not a walled city
					If PlayerRef.GetDistance(LastTracker) > 12000.0 ; Too far from small town to be considered in it
						Return ""
					Else
						Return StorageUtil.StringListGet(Self, "_SLS_LocIndex", i)
					EndIf
				Else
					Return StorageUtil.StringListGet(Self, "_SLS_LocIndex", i)
				EndIf
			EndIf
		Else ; Multi tracker system - Area has more than one tracker covering it. Eg whiterun exterior, honningbrew, whitewatch, western watchtower.
			If IsAtLeastOneCityExteriorTrackerClose(LastTracker)
				Return StorageUtil.StringListGet(Self, "_SLS_LocIndex", i)
			EndIf
		EndIf
	EndIf
	Return ""
EndFunction

Bool Function IsAtLeastOneCityExteriorTrackerClose(ObjectReference Tracker)
	Formlist FlSelect = _SLS_LocTrackersCityExtList.GetAt(StorageUtil.GetIntValue(Tracker, "_SLS_TrackerHoldListIndex")) as Formlist
	Int i = 0
	While i < FlSelect.GetSize()
		If PlayerRef.GetDistance(FlSelect.GetAt(i) as ObjectReference) <= 12000
			Return true
		EndIf
		i += 1
	EndWhile
	Return false
EndFunction

;/

; oriignl
String Function ResolveLocation(Location akNewLoc)
	If PlayerRef.IsInInterior()
		If akNewLoc
			Formlist FlSelect
			Int i = 0
			While i < _SLS_LocsAll.GetSize()
				FlSelect = _SLS_LocsAll.GetAt(i) as Formlist
				If FlSelect.HasForm(akNewLoc)
					Return StorageUtil.StringListGet(Self, "_SLS_LocIndex", i)
				EndIf
				i += 1
			EndWhile
		EndIf
	Else
		If LastTracker.Is3dLoaded()
			Int i = _SLS_LocTrackersAll.Find(LastTracker)
			If i >= 5 ; Is not a walled city
				If PlayerRef.GetDistance(LastTracker) > 12000.0 ; Too far from small town to be considered in it
					Return ""
				Else
					Return StorageUtil.StringListGet(Self, "_SLS_LocIndex", i)
				EndIf
			Else
				Return StorageUtil.StringListGet(Self, "_SLS_LocIndex", i)
			EndIf
		EndIf
	EndIf
	Return ""
EndFunction
/;

Bool Function GetIsFreeTownByInt(Int LocInt)
	Return GetIsFreeTownByString(StorageUtil.StringListGet(Self, "_SLS_LocIndex", LocInt))
EndFunction

Bool Function GetIsFreeTownByString(String Town)
	Return LocOps.GetIsFreeTownByString(Town)
EndFunction

Int Function SetIsPlayerInSlavetownByString(String Town)
	Return SetIsPlayerInSlavetown(LocOps.GetIsFreeTownByString(Town))
EndFunction

Int Function SetIsPlayerInSlavetownByLocation(Location PlayerLoc)
	Return SetIsPlayerInSlavetown(Slaverun.IsFreeArea(PlayerLoc))
EndFunction

Int Function SetIsPlayerInSlavetown(Bool IsInFreeArea)
	Bool WasInSlavetown =  PlayerIsInSlavetown as Bool
	PlayerIsInSlavetown = -1
	PlayerIsInSlavetown = (!IsInFreeArea) as Int
	If WasInSlavetown != (PlayerIsInSlavetown as Bool)
		Curfew.CheckCurfewState()
		Api.SendSlavetownEvent(PlayerIsInSlavetown)
	EndIf
	;Debug.Messagebox("Slavetown: " + PlayerIsInSlavetown + "\nIsInFreeArea: " + IsInFreeArea)
	Return PlayerIsInSlavetown
EndFunction

Function SetupLists()
	; Normal location list for operations on specific towns. Matches order of _SLS_LocsAll & _SLS_LocTrackersAll
	StorageUtil.StringListClear(Self, "_SLS_LocIndex")
	StorageUtil.StringListAdd(Self, "_SLS_LocIndex", "Whiterun") ; Whiterun - 0
	StorageUtil.StringListAdd(Self, "_SLS_LocIndex", "Solitude") ; Solitude - 1
	StorageUtil.StringListAdd(Self, "_SLS_LocIndex", "Markarth") ; Markarth - 2
	StorageUtil.StringListAdd(Self, "_SLS_LocIndex", "Windhelm") ; Windhelm - 3
	StorageUtil.StringListAdd(Self, "_SLS_LocIndex", "Riften") ; Riften - 4
	StorageUtil.StringListAdd(Self, "_SLS_LocIndex", "Dawnstar") ; Dawnstar - 5
	StorageUtil.StringListAdd(Self, "_SLS_LocIndex", "Falkreath") ; Falkreath - 6
	StorageUtil.StringListAdd(Self, "_SLS_LocIndex", "Morthal") ; Morthal - 7
	StorageUtil.StringListAdd(Self, "_SLS_LocIndex", "Riverwood") ; Riverwood - 8
	StorageUtil.StringListAdd(Self, "_SLS_LocIndex", "Rorikstead") ; Rorikstead - 9
	StorageUtil.StringListAdd(Self, "_SLS_LocIndex", "Winterhold") ; Winterhold - 10
	StorageUtil.StringListAdd(Self, "_SLS_LocIndex", "Dragonbridge") ; Dragonbridge - 11
	StorageUtil.StringListAdd(Self, "_SLS_LocIndex", "Kynesgrove") ; Kynesgrove - 12
	StorageUtil.StringListAdd(Self, "_SLS_LocIndex", "ShorsStone") ; ShorsStone - 13
	StorageUtil.StringListAdd(Self, "_SLS_LocIndex", "Ivarstead") ; Ivarstead - 14
	StorageUtil.StringListAdd(Self, "_SLS_LocIndex", "Karthwasten") ; Karthwasten - 15
	StorageUtil.StringListAdd(Self, "_SLS_LocIndex", "Nightgate") ; Nightgate - 16
	StorageUtil.StringListAdd(Self, "_SLS_LocIndex", "OldHroldan") ; OldHroldan - 17
	
	; City exterior trackers
	StorageUtil.StringListAdd(Self, "_SLS_LocIndex", "WhiterunExterior") ; Whiterun Gate - 18
	StorageUtil.StringListAdd(Self, "_SLS_LocIndex", "WhiterunExterior") ; Honningbrew - 19
	StorageUtil.StringListAdd(Self, "_SLS_LocIndex", "WhiterunExterior") ; Whitewatch - 20
	StorageUtil.StringListAdd(Self, "_SLS_LocIndex", "WhiterunExterior") ; Watchtower - 21
	
	StorageUtil.StringListAdd(Self, "_SLS_LocIndex", "SolitudeExterior") ; Solitude Gate - 22
	StorageUtil.StringListAdd(Self, "_SLS_LocIndex", "SolitudeExterior") ; Solitude CaveSide - 23

	StorageUtil.StringListAdd(Self, "_SLS_LocIndex", "MarkarthExterior") ; Markarth Gate - 24
	
	StorageUtil.StringListAdd(Self, "_SLS_LocIndex", "WindhelmExterior") ; Windhelm Gate - 25
	StorageUtil.StringListAdd(Self, "_SLS_LocIndex", "WindhelmExterior") ; Windhelm Docks - 26
	
	StorageUtil.StringListAdd(Self, "_SLS_LocIndex", "RiftenExterior") ; Riften Gate - 27
	StorageUtil.StringListAdd(Self, "_SLS_LocIndex", "RiftenExterior") ; Riften Docks - 28
	StorageUtil.StringListAdd(Self, "_SLS_LocIndex", "RiftenExterior") ; Riften Farm - 29
	StorageUtil.StringListAdd(Self, "_SLS_LocIndex", "RiftenExterior") ; Riften Back Gate - 30
	
	
	StorageUtil.SetIntValue(_SLS_LocTrackersAll.GetAt(18), "_SLS_TrackerHoldListIndex", 0) ; Whiterun Gate
	StorageUtil.SetIntValue(_SLS_LocTrackersAll.GetAt(19), "_SLS_TrackerHoldListIndex", 0) ; Honningbrew
	StorageUtil.SetIntValue(_SLS_LocTrackersAll.GetAt(20), "_SLS_TrackerHoldListIndex", 0) ; Whitewatch
	StorageUtil.SetIntValue(_SLS_LocTrackersAll.GetAt(21), "_SLS_TrackerHoldListIndex", 0) ; Watchtower
	
	StorageUtil.SetIntValue(_SLS_LocTrackersAll.GetAt(22), "_SLS_TrackerHoldListIndex", 1) ; Solitude Gate
	StorageUtil.SetIntValue(_SLS_LocTrackersAll.GetAt(23), "_SLS_TrackerHoldListIndex", 1) ; Solitude CaveSide
	
	StorageUtil.SetIntValue(_SLS_LocTrackersAll.GetAt(24), "_SLS_TrackerHoldListIndex", 2) ; Markarth Gate
	
	StorageUtil.SetIntValue(_SLS_LocTrackersAll.GetAt(25), "_SLS_TrackerHoldListIndex", 3) ; Windhelm Gate
	StorageUtil.SetIntValue(_SLS_LocTrackersAll.GetAt(26), "_SLS_TrackerHoldListIndex", 3) ; Windhelm Docks
	
	StorageUtil.SetIntValue(_SLS_LocTrackersAll.GetAt(27), "_SLS_TrackerHoldListIndex", 4) ; Riften Gate
	StorageUtil.SetIntValue(_SLS_LocTrackersAll.GetAt(28), "_SLS_TrackerHoldListIndex", 4) ; Riften Docks
	StorageUtil.SetIntValue(_SLS_LocTrackersAll.GetAt(29), "_SLS_TrackerHoldListIndex", 4) ; Riften Farm
	StorageUtil.SetIntValue(_SLS_LocTrackersAll.GetAt(30), "_SLS_TrackerHoldListIndex", 4) ; Riften Back Gate
EndFunction

Function SetupInnPrices()
	InnCosts = new Int[18]
	InnCosts[0] = 150 ; Whiterun
	InnCosts[1] = 200 ; Solitude
	InnCosts[2] = 125 ; Markarth
	InnCosts[3] = 150 ; Windhelm
	InnCosts[4] = 125 ; Riften
	InnCosts[5] = 75 ; Dawnstar
	InnCosts[6] = 75 ; Falkreath
	InnCosts[7] = 75 ; Morthal
	InnCosts[8] = 100 ; Riverwood
	InnCosts[9] = 75 ; Rorikstead
	InnCosts[10] = 50 ; Winterhold
	InnCosts[11] = 100 ; Dragonbridge
	InnCosts[12] = 100 ; Kynesgrove
	InnCosts[13] = 100 ; Shors stone
	InnCosts[14] = 75 ; Ivarstead
	InnCosts[15] = 75 ; Karthwasten
	InnCosts[16] = 75 ; Nightgate
	InnCosts[17] = 75 ; Old Hroldan
	;/
	InnCosts[18] = 150 ; Whiterun Exterior
	InnCosts[19] = 200 ; Solitude Exterior
	InnCosts[20] = 125 ; Markarth Exterior
	InnCosts[21] = 150 ; Windhelm Exterior
	InnCosts[22] = 125 ; Riften Exterior
	/;
	;/
	InnCosts[23] = 100
	InnCosts[24] = 100
	/;
EndFunction

ObjectReference Function GetInnDoor()
	Return LocOps.GetInnDoorByString(PlayerCurrentLocString)
EndFunction

Function SetInnCostByString(String Town)
	Int Cost = GetInnCostByString(Town)
	If Cost > -1
		_SLS_CurfewInnCostAtLocation.SetValue(Cost)
		SetInnCost(Cost)
	Else
		_SLS_CurfewInnCostAtLocation.SetValue(90)
		SetInnCost(90)
	EndIf
EndFunction
;/
Function SetInnCostByIndex(Int LocIndex)
	If LocIndex > -1
		Int Cost = GetInnCostAtTown(LocIndex)
		_SLS_CurfewInnCostAtLocation.SetValue(Cost)
		SetInnCost(Cost)
	Else
		_SLS_CurfewInnCostAtLocation.SetValue(90)
		SetInnCost(90)
	EndIf
EndFunction
/;
Function SetInnCost(Int Cost)
	If SetInnPrices
		RoomCost.SetValueInt(Cost)
		DialogueGeneric.UpdateCurrentInstanceGlobal(RoomCost)
		DialogueRiverwood_Revised.UpdateCurrentInstanceGlobal(RoomCost)
	EndIf
EndFunction
;/
Int Function GetInnCostAtTown(Int LocIndex)
	If LocIndex > -1
		Return InnCosts[LocIndex]
	EndIf
	Return 90
EndFunction
/;

Int Function GetInnCostByString(String Town)
	;Debug.Messagebox("InnCost: " + LocOps.GetInnCostByString(Town))
	Return LocOps.GetInnCostByString(Town)
	;/
	Int i = StorageUtil.StringListFind(Self, "_SLS_LocIndex", Town)
	
	If i > -1
		Return InnCosts[i]
	EndIf
	Return -1
	/;
EndFunction

Bool Function HasHomeAtLoc()
	Return LocOps.GetHasHomeAtLoc(PlayerCurrentLocString)
EndFunction

Bool Function HasVanillaHomeAtLoc()
	Return LocOps.GetHasVanillaHomeAtLoc(PlayerCurrentLocString)
EndFunction

Bool Function HasWartimesHomeInHold()
	Return LocOps.GetHasWartimesHomeInHold(PlayerCurrentLocString)
EndFunction

Bool Function IsEvictedAtLoc()
	Return LocOps.GetIsEvictedAtLoc(PlayerCurrentLocString)
EndFunction

Bool Function HasVanillaHomeInHold()
	Return LocOps.GetHasVanillaHomeInHold(PlayerCurrentLocString)
EndFunction

Bool Function HasKennelAtLoc()
	Return LocOps.GetHasKennelAtLoc(PlayerCurrentLocString)
EndFunction

Bool Function HasKennelInHold()
	Return LocOps.GetHasKennelInHold(PlayerCurrentLocString)
EndFunction

Bool Function HasBeggarLairAtLoc()
	Return LocOps.GetHasBeggarLairAtLoc(PlayerCurrentLocString)
EndFunction

Bool Function HasBeggarLairInHold()
	Return LocOps.GetHasBeggarLairInHold(PlayerCurrentLocString)
EndFunction

Function SetIsInsideWalls(Int LocIndex)
	Bool WasInside = Init.IsPlayerInside
	Init.IsPlayerInside = (LocIndex >= 0 && LocIndex <= 4)
	;Debug.Messagebox("WasInside: " + WasInside + "\nInit.IsPlayerInside: " + Init.IsPlayerInside + "\nLocIndex: " + LocIndex)
	If WasInside && !Init.IsPlayerInside ; Was inside and now is outside
		;Debug.Messagebox("Was inside and now is outside")
		Init.ResetCanDos()
		TollDodge.PlayerLeavesCity()
		ToggleGuardWarningQuests(Active = false)
		TollDisguise.SetGuardDistance(PlayerCurrentLocIndex)
	
	ElseIf !WasInside && Init.IsPlayerInside ; Was outside and now is inside
		Init.IsTollPaid = false
		;Debug.Messagebox("Was outside and now is inside")
		TollDodge.TollGateLoad(PlayerCurrentLocString, true)
		TollDodge.HasDodgedToll(PlayerCurrentLocString)
		ToggleGuardWarningQuests(Active = true)
		TollDisguise.SetGuardDistance(PlayerCurrentLocIndex)
	EndIf	
EndFunction

Function LoadSlaverunLocations()
	If Game.GetModByName("Slaverun_Reloaded.esp") != 255
		_SLS_LocsWhiterunExterior.AddForm(Game.GetFormFromFile(0x66C1E5, "Slaverun_Reloaded.esp")) ; SLV_ColosseumLocation - is both indoors and outdoors ; Is this necessaary anymore since LocTrackCentral?
		_SLS_LocsWhiterunExterior.AddForm(Game.GetFormFromFile(0x77AC6B, "Slaverun_Reloaded.esp")) ; SLV_ColosseumTrainingLocation ; Is this necessaary anymore since LocTrackCentral?
		
		_SLS_LocsWhiterun.AddForm(Game.GetFormFromFile(0x66C1E5, "Slaverun_Reloaded.esp")) ; SLV_ColosseumLocation - is both indoors and outdoors
		_SLS_LocsWhiterun.AddForm(Game.GetFormFromFile(0x203EC4, "Slaverun_Reloaded.esp")) ; SLV_Dungeon - Might be problems. This is used for some 'unlinked' cells and I'm not sure which city they are associated with.
		_SLS_LocsWhiterun.AddForm(Game.GetFormFromFile(0x1314E5, "Slaverun_Reloaded.esp")) ; SLV_SlaveArenaLocation
		_SLS_LocsWhiterun.AddForm(Game.GetFormFromFile(0x8319C9, "Slaverun_Reloaded.esp")) ; SLV_ColosseumEnforcerLocation
		_SLS_LocsWhiterun.AddForm(Game.GetFormFromFile(0x6A4276, "Slaverun_Reloaded.esp")) ; SLV_BuildingSiteLocation
	EndIf
EndFunction

Function ToggleGuardWarningQuests(Bool Active) ; Guard harassment quests in city if weapons/armor equipped
	;Debug.Messagebox("ToggleGuardWarningQuests - Active: " + Active)
	If Active
		If Menu.GuardBehavArmorEquip
			_SLS_GuardWarnArmorEquippedQuest.Start()
		EndIf
		If Menu.GuardBehavWeapEquip
			_SLS_GuardWarnWeapEquippedQuest.Start()
		EndIf
	Else
		_SLS_GuardWarnArmorEquippedQuest.Stop()
		_SLS_GuardWarnWeapEquippedQuest.Stop()
	EndIf
EndFunction

Function PortPlayerToHomeByCrimeFaction(Actor akActor)
	Form[] HomeDoors = LocOps.DoGetHomeDoorList(GetTownStringByCrimeFaction(akActor))
	If HomeDoors
		ObjectReference ClosestDoor = GetClosestObjectInArray(HomeDoors)
		If ClosestDoor.IsLocked()
			ClosestDoor.Lock(abLock = false, abAsOwner = true)
		EndIf
		ClosestDoor.Activate(PlayerRef)
	Else
		Debug.Trace("_SLS_: PortPlayerToHomeByCrimeFaction(): HomeDoors is None!!")
	EndIf
EndFunction

String Function GetTownStringByCrimeFaction(Actor akActor)
	Int i = CrimeFactions.Find(akActor.GetCrimeFaction())
	If i > -1
		Return CtimeFactionTownStrings[i]
	EndIf
	Debug.Trace("_SLS_: GetTownStringByCrimeFaction(): Crimefaction: " + akActor.GetCrimeFaction() + " for speaker: " + akActor + " not found in list")
	Return ""
EndFunction

ObjectReference Function GetClosestObjectInArray(Form[] Doors)
	Debug.Trace("_SLS_: GetClosestObjectInArray(): Procing: " + Doors[0])
	ObjectReference Closest = Doors[0] as ObjectReference
	Float LowestDist = Closest.GetDistance(PlayerRef)
	Int i = 1
	While i < Doors.Length
		Debug.Trace("_SLS_: GetClosestObjectInArray(): Procing: " + Doors[i])
		If (Doors[i] as ObjectReference).GetDistance(PlayerRef) < LowestDist
			Closest = Doors[i] as ObjectReference
			LowestDist = Closest.GetDistance(PlayerRef)
		EndIf
		i += 1
	EndWhile
	Return Closest
EndFunction

Float Function GetDanceLocThreshold()
	Return LocOps.GetDanceLocThresholdByString(PlayerCurrentLocString)
EndFunction

Function SetPlayerKennelLocation(Int Loc)
	 ; -1 = Not in a kennel, 0 - Whiterun, 1 - Solitude, 2 - Markarth, 3 - Windhelm, 4 - Riften
	 PlayerKennelLocation = Loc
EndFunction

ObjectReference Function GetForcedEscortTpMarker()
	Return LocOps.GetForcedEscortTpMarkerByString(PlayerCurrentLocString)
EndFunction

Formlist Function GetEnforcerList()
	Return LocOps.GetEnforcerListByString(PlayerCurrentLocString)
EndFunction

Int[] Property InnCosts Auto Hidden

Bool Property ResidentsDontPayTolls = true Auto Hidden
Bool Property SetInnPrices = false Auto Hidden
;Bool Property LastTrackerIsInWalledCity = false Auto Hidden Conditional
Int Property PlayerIsInSlavetown = 0 Auto Hidden Conditional ; 0 - not slavetown, 1 - IS slavetown, -1 - In process
Int Property PlayerCurrentLocIndex = -1 Auto Hidden ; -1 = Don't care location
Int Property PlayerKennelLocation = -1 Auto Hidden Conditional ; -1 = Not in a kennel, 0 - Whiterun, 1 - Solitude, 2 - Markarth, 3 - Windhelm, 4 - Riften
String Property PlayerCurrentLocString = "" Auto Hidden ; "" = Don't care location.  

Actor Property PlayerRef Auto

Formlist Property _SLS_LocTrackersAll Auto
Formlist Property _SLS_LocsAll Auto
Formlist Property _SLS_LocsWhiterunExterior Auto
Formlist Property _SLS_LocsWhiterun Auto
Formlist Property _SLS_LocTrackersCityExtList Auto

GlobalVariable Property RoomCost Auto
GlobalVariable Property _SLS_CurfewInnCostAtLocation Auto

ObjectReference Property LastTracker Auto Hidden

Quest Property DialogueGeneric Auto
Quest Property DialogueRiverwood_Revised Auto
Quest Property _SLS_GuardWarnArmorEquippedQuest Auto
Quest Property _SLS_GuardWarnWeapEquippedQuest Auto

Faction[] Property CrimeFactions Auto ; 0 - Whiterun, 1 - Solitude, 2 - Markarth, 3 - Windhelm, 4 - Riften, 5 - Falkreath, 6 - Morthal, 7 - Dawnstar, 8 - Winterhold
String[] Property CtimeFactionTownStrings Auto ; Same as above. Except strings

_SLS_LicTownCheck Property TownCheck Auto
_SLS_Api Property Api Auto
SLS_Init Property Init Auto
SLS_Mcm Property Menu Auto
_SLS_Curfew Property Curfew Auto
_SLS_TollDodge Property TollDodge Auto
_SLS_TollDodgeDisguise Property TollDisguise Auto
_SLS_LocationOpsSpecific Property LocOps Auto

_SLS_InterfaceSlaverun Property Slaverun Auto
