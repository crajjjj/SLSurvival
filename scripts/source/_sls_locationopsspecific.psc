Scriptname _SLS_LocationOpsSpecific extends Quest  

Event OnInit()
	If Self.IsRunning()
		;Setup()
	EndIf
EndEvent
;/
Function Setup()
	; Stringlist index positions determined by formlist _SLS_LocsAll
	; Stringlist order corresponds with equivalent Slaverun town Jurisdictions.
	; Eg: 13 - Ivarstead will follow the rules for Riften enslavement
	
	StorageUtil.StringListClear(Self, "_SLS_SlaverunJurisdictions")
	StorageUtil.StringListAdd(Self, "_SLS_SlaverunJurisdictions", "Whiterun") ; Whiterun
	StorageUtil.StringListAdd(Self, "_SLS_SlaverunJurisdictions", "Solitude") ; Solitude
	StorageUtil.StringListAdd(Self, "_SLS_SlaverunJurisdictions", "Markarth") ; Markarth
	StorageUtil.StringListAdd(Self, "_SLS_SlaverunJurisdictions", "Riften") ; Riften
	StorageUtil.StringListAdd(Self, "_SLS_SlaverunJurisdictions", "Windhelm") ; Windhelm
	StorageUtil.StringListAdd(Self, "_SLS_SlaverunJurisdictions", "Dawnstar") ; Dawnstar
	StorageUtil.StringListAdd(Self, "_SLS_SlaverunJurisdictions", "Falkreath") ; Falkreath
	StorageUtil.StringListAdd(Self, "_SLS_SlaverunJurisdictions", "Morthal") ; Morthal
	StorageUtil.StringListAdd(Self, "_SLS_SlaverunJurisdictions", "Riverwood") ; Riverwood
	StorageUtil.StringListAdd(Self, "_SLS_SlaverunJurisdictions", "Riverwood") ; Rorikstead - No enslavement of Rorikstead. Consider Rorikstead enslaved when Riverwood is
	StorageUtil.StringListAdd(Self, "_SLS_SlaverunJurisdictions", "Winterhold") ; Winterhold
	StorageUtil.StringListAdd(Self, "_SLS_SlaverunJurisdictions", "Solitude") ; Dragonbridge
	StorageUtil.StringListAdd(Self, "_SLS_SlaverunJurisdictions", "Windhelm") ; Kynesgrove
	StorageUtil.StringListAdd(Self, "_SLS_SlaverunJurisdictions", "Riften") ; ShorsStone
	StorageUtil.StringListAdd(Self, "_SLS_SlaverunJurisdictions", "Riften") ; Ivarstead
	StorageUtil.StringListAdd(Self, "_SLS_SlaverunJurisdictions", "Markarth") ; Karthwasten
	StorageUtil.StringListAdd(Self, "_SLS_SlaverunJurisdictions", "Dawnstar") ; Nightgate
	StorageUtil.StringListAdd(Self, "_SLS_SlaverunJurisdictions", "Markarth") ; OldHroldan
EndFunction

Bool Function GetIsFreeTown(Int LocIndex)
	;Debug.Messagebox("LocIndex: " + LocIndex)
	GoToState(StorageUtil.StringListGet(Self, "_SLS_SlaverunJurisdictions", LocIndex))
	Return IsFreeTown()
EndFunction
/;
Bool Function GetIsFreeTownByString(String Town)
	; See _SLS_LocTrackCentral for accepted string arguments - StringList _SLS_LocIndex
	
	;Debug.Messagebox("GetIsFreeTownByString: " + Town)
	GoToState(Town)
	Return IsFreeTown()
EndFunction

Int Function GetInnCostByString(String Town)
	GoToState(Town)
	Return GetInnCost()
EndFunction

Bool Function GetHasHomeAtLoc(String Town)
	GoToState(Town)
	Return HasHomeAtLoc()
EndFunction

Bool Function GetHasVanillaHomeAtLoc(String Town)
	GoToState(Town)
	Return HasVanillaHomeAtLoc()
EndFunction

Bool Function GetHasVanillaHomeInHold(String Town)
	GoToState(Town)
	Return HasVanillaHomeInHold()
EndFunction

Bool Function GetHasWartimesHomeInHold(String Town)
	GoToState(Town)
	Return HasWartimesHomeInHold()
EndFunction

Bool Function GetHasKennelAtLoc(String Town)
	GoToState(Town)
	Return HasKennelAtLoc()
EndFunction

Bool Function GetHasKennelInHold(String Town)
	GoToState(Town)
	Return HasKennelInHold()
EndFunction

Bool Function GetHasBeggarLairAtLoc(String Town)
	GoToState(Town)
	Return HasBeggarLairAtLoc()
EndFunction

Bool Function GetHasBeggarLairInHold(String Town)
	GoToState(Town)
	Return HasBeggarLairInHold()
EndFunction

Form[] Function DoGetHomeDoorList(String Town)
	GoToState(Town)
	Return GetHomeDoorList()
EndFunction

Bool Function GetIsEvictedAtLoc(String Town)
	GoToState(Town)
	Return IsEvictedAtLoc()
EndFunction

ObjectReference Function GetInnDoorByString(String Town)
	GoToState(Town)
	Return GetInnDoor()
EndFunction

Float Function GetDanceLocThresholdByString(String Town)
	GoToState(Town)
	Return GetDanceLocThreshold()
EndFunction

ObjectReference Function GetForcedEscortTpMarkerByString(String Town)
	GoToState(Town)
	Return GetForcedEscortTpMarker()
EndFunction

Formlist Function GetEnforcerListByString(String Town)
	GoToState(Town)
	Return GetEnforcerList()
EndFunction

Bool Function HasWartimesHome()
	If Game.GetModByName("pchsWartimes.esp") != 255
		If (Game.GetFormFromFile(0x005932, "pchsWartimes.esp") as Cell).GetFactionOwner() == PlayerFaction && (!(Game.GetFormFromFile(0x005A16, "pchsWartimes.esp") as Actor).IsDead() || \
		!(Game.GetFormFromFile(0x005A12, "pchsWartimes.esp") as Actor).IsDead()) && \
		(Game.GetFormFromFile(0x5A17, "pchsWartimes.esp") as Quest).GetCurrentStageId() >= 130 && StorageUtil.GetIntValue(None, "pchsWtWartimesHomeAccess", Missing = 0) == 1
			Return true
		EndIf
	EndIf
	Return false
EndFunction

; Empty state ===========================================

Bool Function IsFreeTown()
	Return true
EndFunction

Int Function GetInnCost()
	Return 90
EndFunction

Bool Function HasHomeAtLoc()
	Return false
EndFunction

Bool Function HasVanillaHomeAtLoc()
	Return false
EndFunction

Bool Function HasVanillaHomeInHold()
	Return false
EndFunction

Bool Function HasWartimesHomeInHold()
	Return false
EndFunction

Bool Function IsEvictedAtLoc()
	Return false
EndFunction

Bool Function HasKennelAtLoc()
	Return false
EndFunction

Bool Function HasKennelInHold()
	Return false
EndFunction

Bool Function HasBeggarLairAtLoc()
	Return false
EndFunction

Bool Function HasBeggarLairInHold()
	Return false
EndFunction

Form[] Function GetHomeDoorList()
	Return None
EndFunction

ObjectReference Function GetInnDoor()
	Return None
EndFunction

Float Function GetDanceLocThreshold()
	Return 0.25
EndFunction

ObjectReference Function GetForcedEscortTpMarker()
	Return _SLS_EscortTpWhiterun
EndFunction

Formlist Function GetEnforcerList()
	Return None
EndFunction

; Areas with individual slaverun jurisdictions =================================================================
State Whiterun
	Bool Function IsFreeTown()
		Return Slaverun.IsFreeTownWhiterun()
	EndFunction
	
	Int Function GetInnCost()
		Return LocCentral.InnCosts[0]
	EndFunction
	
	Bool Function HasHomeAtLoc()
		If HasVanillaHomeAtLoc() || HasVanillaHomeInHold() || HasWartimesHome() || _SLS_KennelResDealLoc.GetValueInt() == 0 || StorageUtil.FormListCount(None, "_SLS_TempPassWhiterun") > 0
			Return true
		EndIf
		Return false
	EndFunction
	
	Bool Function HasVanillaHomeAtLoc()
		Return (Eviction.OwnsWhiterun && !Eviction.IsBarredWhiterun && StorageUtil.GetIntValue(None, "_SLS_HasValidPropertyLicence", Missing = -1) != 0)
	EndFunction

	Bool Function HasVanillaHomeInHold()
		Return HasVanillaHomeAtLoc()
	EndFunction
	
	Bool Function HasWartimesHomeInHold()
		Return HasWartimesHome()
	EndFunction
	
	Form[] Function GetHomeDoorList()
		If Game.GetModByName("pchsWartimes.esp") != 255 && (Game.GetFormFromFile(0x005932, "pchsWartimes.esp") as Cell).GetFactionOwner() == PlayerFaction
			StorageUtil.FormListAdd(Self, "HomeDoorList", Game.GetFormFromFile(0x5A0D, "pchsWartimes.esp"))
		ElseIf Eviction.OwnsWhiterun && !Eviction.IsBarredWhiterun
			StorageUtil.FormListAdd(Self, "HomeDoorList", Game.GetFormFromFile(0x1A6F9, "Skyrim.esm")) ; Breezehome
		EndIf
		Form[] DoorList = StorageUtil.FormListToArray(Self, "HomeDoorList")
		StorageUtil.FormListClear(Self, "HomeDoorList")
		Return DoorList
	EndFunction
	
	Bool Function IsEvictedAtLoc()
		Return (Eviction.IsBarredWhiterun && Eviction.OwnsWhiterun)
	EndFunction
	
	Bool Function HasKennelAtLoc()
		Return true
	EndFunction

	Bool Function HasKennelInHold()
		Return true
	EndFunction
	
	Bool Function HasBeggarLairAtLoc()
		Return false
	EndFunction

	Bool Function HasBeggarLairInHold()
		Return false
	EndFunction

	ObjectReference Function GetInnDoor()
		Return Game.GetFormFromFile(0x1A6F4, "Skyrim.esm") as ObjectReference
	EndFunction
	
	Float Function GetDanceLocThreshold()
		Return 0.40
	EndFunction
	
	ObjectReference Function GetForcedEscortTpMarker()
		Return _SLS_EscortTpWhiterun
	EndFunction
	
	Formlist Function GetEnforcerList()
		Return None
	EndFunction
EndState

State Solitude
	Bool Function IsFreeTown()
		Return Slaverun.IsFreeTownSolitude()
	EndFunction
	
	Int Function GetInnCost()
		Return LocCentral.InnCosts[1]
	EndFunction
	
	Bool Function HasHomeAtLoc()
		If HasVanillaHomeAtLoc() || HasVanillaHomeInHold() || _SLS_KennelResDealLoc.GetValueInt() == 1 || StorageUtil.FormListCount(None, "_SLS_TempPassSolitude") > 0
			Return true
		EndIf
		Return false
	EndFunction
	
	Bool Function HasVanillaHomeAtLoc()
		Return (Eviction.OwnsSolitude && !Eviction.IsBarredSolitude && StorageUtil.GetIntValue(None, "_SLS_HasValidPropertyLicence", Missing = -1) != 0)
	EndFunction

	Bool Function HasVanillaHomeInHold()
		Return HasVanillaHomeAtLoc()
	EndFunction
	
	Bool Function HasWartimesHomeInHold()
		Return false
	EndFunction
	
	Form[] Function GetHomeDoorList()
		If Eviction.OwnsSolitude && !Eviction.IsBarredSolitude
			StorageUtil.FormListAdd(Self, "HomeDoorList", Game.GetFormFromFile(0x3AF95, "Skyrim.esm")) ; Proudspire manor
		EndIf
		Form[] DoorList = StorageUtil.FormListToArray(Self, "HomeDoorList")
		StorageUtil.FormListClear(Self, "HomeDoorList")
		Return DoorList
	EndFunction
	
	Bool Function IsEvictedAtLoc()
		Return (Eviction.IsBarredSolitude && Eviction.OwnsSolitude)
	EndFunction
	
	Bool Function HasKennelAtLoc()
		Return true
	EndFunction

	Bool Function HasKennelInHold()
		Return true
	EndFunction
	
	Bool Function HasBeggarLairAtLoc()
		Return false
	EndFunction

	Bool Function HasBeggarLairInHold()
		Return false
	EndFunction
	
	ObjectReference Function GetInnDoor()
		Return Game.GetFormFromFile(0x37F25, "Skyrim.esm") as ObjectReference
	EndFunction
	
	Float Function GetDanceLocThreshold()
		Return 0.50
	EndFunction
	
	ObjectReference Function GetForcedEscortTpMarker()
		Return _SLS_EscortTpSolitude
	EndFunction
	
	Formlist Function GetEnforcerList()
		Return None
	EndFunction
EndState

State Markarth
	Bool Function IsFreeTown()
		Return Slaverun.IsFreeTownMarkarth()
	EndFunction
	
	Int Function GetInnCost()
		Return LocCentral.InnCosts[2]
	EndFunction
	
	Bool Function HasHomeAtLoc()
		If HasVanillaHomeAtLoc() || HasVanillaHomeInHold() || _SLS_KennelResDealLoc.GetValueInt() == 2 || StorageUtil.FormListCount(None, "_SLS_TempPassMarkarth") > 0
			Return true
		EndIf
		Return false
	EndFunction
	
	Bool Function HasVanillaHomeAtLoc()
		Return (Eviction.OwnsMarkarth && !Eviction.IsBarredMarkarth && StorageUtil.GetIntValue(None, "_SLS_HasValidPropertyLicence", Missing = -1) != 0)
	EndFunction

	Bool Function HasVanillaHomeInHold()
		Return HasVanillaHomeAtLoc()
	EndFunction
	
	Bool Function HasWartimesHomeInHold()
		Return false
	EndFunction
	
	Form[] Function GetHomeDoorList()
		If Eviction.OwnsMarkarth && !Eviction.IsBarredMarkarth
			StorageUtil.FormListAdd(Self, "HomeDoorList", Game.GetFormFromFile(0x7BDBD, "Skyrim.esm")) ; markarth place
		EndIf
		Form[] DoorList = StorageUtil.FormListToArray(Self, "HomeDoorList")
		StorageUtil.FormListClear(Self, "HomeDoorList")
		Return DoorList
	EndFunction
	
	Bool Function IsEvictedAtLoc()
		Return (Eviction.IsBarredMarkarth && Eviction.OwnsMarkarth)
	EndFunction
	
	Bool Function HasKennelAtLoc()
		Return true
	EndFunction

	Bool Function HasKennelInHold()
		Return true
	EndFunction
	
	Bool Function HasBeggarLairAtLoc()
		Return true
	EndFunction

	Bool Function HasBeggarLairInHold()
		Return true
	EndFunction
	
	ObjectReference Function GetInnDoor()
		Return Game.GetFormFromFile(0x16E3B, "Skyrim.esm") as ObjectReference
	EndFunction
	
	Float Function GetDanceLocThreshold()
		Return 0.30
	EndFunction
	
	ObjectReference Function GetForcedEscortTpMarker()
		Return _SLS_EscortTpMarkarth
	EndFunction
	
	Formlist Function GetEnforcerList()
		Return None
	EndFunction
EndState

State Windhelm
	Bool Function IsFreeTown()
		Return Slaverun.IsFreeTownWindhelm()
	EndFunction
	
	Int Function GetInnCost()
		Return LocCentral.InnCosts[3]
	EndFunction
	
	Bool Function HasHomeAtLoc()
		If HasVanillaHomeAtLoc() || HasVanillaHomeInHold() || _SLS_KennelResDealLoc.GetValueInt() == 3 || StorageUtil.FormListCount(None, "_SLS_TempPassWindhelm") > 0
			Return true
		EndIf
		Return false
	EndFunction
	
	Bool Function HasVanillaHomeAtLoc()
		Return (Eviction.OwnsWindhelm && !Eviction.IsBarredWindhelm && StorageUtil.GetIntValue(None, "_SLS_HasValidPropertyLicence", Missing = -1) != 0)
	EndFunction

	Bool Function HasVanillaHomeInHold()
		Return HasVanillaHomeAtLoc()
	EndFunction
	
	Bool Function HasWartimesHomeInHold()
		Return false
	EndFunction
	
	Form[] Function GetHomeDoorList()
		If Eviction.OwnsWindhelm && !Eviction.IsBarredWindhelm
			StorageUtil.FormListAdd(Self, "HomeDoorList", Game.GetFormFromFile(0x16970, "Skyrim.esm")) ; windhelm place
		EndIf
		Form[] DoorList = StorageUtil.FormListToArray(Self, "HomeDoorList")
		StorageUtil.FormListClear(Self, "HomeDoorList")
		Return DoorList
	EndFunction
	
	Bool Function IsEvictedAtLoc()
		Return (Eviction.IsBarredWindhelm && Eviction.OwnsWindhelm)
	EndFunction
	
	Bool Function HasKennelAtLoc()
		Return false
	EndFunction

	Bool Function HasKennelInHold()
		Return false
	EndFunction
	
	Bool Function HasBeggarLairAtLoc()
		Return false
	EndFunction

	Bool Function HasBeggarLairInHold()
		Return false
	EndFunction
	
	ObjectReference Function GetInnDoor()
		Return Game.GetFormFromFile(0xD18B1, "Skyrim.esm") as ObjectReference
	EndFunction
	
	Float Function GetDanceLocThreshold()
		Return 0.5
	EndFunction
	
	ObjectReference Function GetForcedEscortTpMarker()
		Return _SLS_EscortTpWindhelm
	EndFunction
	
	Formlist Function GetEnforcerList()
		Return None
	EndFunction
EndState

State Riften
	Bool Function IsFreeTown()
		Return Slaverun.IsFreeTownRiften()
	EndFunction
	
	Int Function GetInnCost()
		Return LocCentral.InnCosts[4]
	EndFunction
	
	Bool Function HasHomeAtLoc()
		If HasVanillaHomeAtLoc() || HasVanillaHomeInHold() || _SLS_KennelResDealLoc.GetValueInt() == 5 || StorageUtil.FormListCount(None, "_SLS_TempPassRiften") > 0
			Return true
		EndIf
		Return false
	EndFunction
	
	Bool Function HasVanillaHomeAtLoc()
		Return (Eviction.OwnsRiften && !Eviction.IsBarredRiften && StorageUtil.GetIntValue(None, "_SLS_HasValidPropertyLicence", Missing = -1) != 0)
	EndFunction

	Bool Function HasVanillaHomeInHold()
		Return HasVanillaHomeAtLoc()
	EndFunction
	
	Bool Function HasWartimesHomeInHold()
		Return false
	EndFunction
	
	Form[] Function GetHomeDoorList()
		If Eviction.OwnsRiften && !Eviction.IsBarredRiften
			StorageUtil.FormListAdd(Self, "HomeDoorList", Game.GetFormFromFile(0x42277, "Skyrim.esm")) ; Honeyside
		EndIf
		Form[] DoorList = StorageUtil.FormListToArray(Self, "HomeDoorList")
		StorageUtil.FormListClear(Self, "HomeDoorList")
		Return DoorList
	EndFunction
	
	Bool Function IsEvictedAtLoc()
		Return (Eviction.IsBarredRiften && Eviction.OwnsRiften)
	EndFunction
	
	Bool Function HasKennelAtLoc()
		Return false
	EndFunction

	Bool Function HasKennelInHold()
		Return false
	EndFunction
	
	Bool Function HasBeggarLairAtLoc()
		Return true
	EndFunction

	Bool Function HasBeggarLairInHold()
		Return true
	EndFunction
	
	ObjectReference Function GetInnDoor()
		Return Game.GetFormFromFile(0x430A6, "Skyrim.esm") as ObjectReference
	EndFunction
	
	Float Function GetDanceLocThreshold()
		Return 0.3
	EndFunction
	
	ObjectReference Function GetForcedEscortTpMarker()
		Return _SLS_EscortTpRiften
	EndFunction
	
	Formlist Function GetEnforcerList()
		Return None
	EndFunction
EndState

State Dawnstar
	Bool Function IsFreeTown()
		Return Slaverun.IsFreeTownDawnstar()
	EndFunction
	
	Int Function GetInnCost()
		Return LocCentral.InnCosts[5]
	EndFunction
	
	Bool Function HasHomeAtLoc()
		If StorageUtil.FormListCount(None, "_SLS_TempPassDawnstar") > 0
			Return true
		EndIf
		Return false
	EndFunction
	
	Bool Function HasVanillaHomeAtLoc()
		Return false
	EndFunction

	Bool Function HasVanillaHomeInHold()
		Return false
	EndFunction
	
	Bool Function HasWartimesHomeInHold()
		Return false
	EndFunction
	
	Form[] Function GetHomeDoorList()
		Return None
	EndFunction
	
	Bool Function IsEvictedAtLoc()
		Return false
	EndFunction
	
	Bool Function HasKennelAtLoc()
		Return false
	EndFunction

	Bool Function HasKennelInHold()
		Return false
	EndFunction
	
	Bool Function HasBeggarLairAtLoc()
		Return false
	EndFunction

	Bool Function HasBeggarLairInHold()
		Return false
	EndFunction
	
	ObjectReference Function GetInnDoor()
		Return Game.GetFormFromFile(0x17636, "Skyrim.esm") as ObjectReference
	EndFunction
	
	Float Function GetDanceLocThreshold()
		Return 0.1
	EndFunction
	
	ObjectReference Function GetForcedEscortTpMarker()
		Return _SLS_EscortTpWindhelm
	EndFunction
	
	Formlist Function GetEnforcerList()
		Return _SLS_LicTownEnforcersList.GetAt(0) as Formlist
	EndFunction
EndState

State Falkreath
	Bool Function IsFreeTown()
		Return Slaverun.IsFreeTownFalkreath()
	EndFunction
	
	Int Function GetInnCost()
		Return LocCentral.InnCosts[6]
	EndFunction
	
	Bool Function HasHomeAtLoc()
		If StorageUtil.FormListCount(None, "_SLS_TempPassFalkreath") > 0
			Return true
		EndIf
		Return false
	EndFunction
	
	Bool Function HasVanillaHomeAtLoc()
		Return false
	EndFunction

	Bool Function HasVanillaHomeInHold()
		Return false
	EndFunction
	
	Bool Function HasWartimesHomeInHold()
		Return false
	EndFunction
	
	Form[] Function GetHomeDoorList()
		Return None
	EndFunction
	
	Bool Function IsEvictedAtLoc()
		Return false
	EndFunction
	
	Bool Function HasKennelAtLoc()
		Return false
	EndFunction

	Bool Function HasKennelInHold()
		Return false
	EndFunction
	
	Bool Function HasBeggarLairAtLoc()
		Return false
	EndFunction

	Bool Function HasBeggarLairInHold()
		Return false
	EndFunction
	
	ObjectReference Function GetInnDoor()
		Return Game.GetFormFromFile(0x17762, "Skyrim.esm") as ObjectReference
	EndFunction
	
	Float Function GetDanceLocThreshold()
		Return 0.1
	EndFunction
	
	ObjectReference Function GetForcedEscortTpMarker()
		Return _SLS_EscortTpWhiterun
	EndFunction
	
	Formlist Function GetEnforcerList()
		Return _SLS_LicTownEnforcersList.GetAt(1) as Formlist
	EndFunction
EndState

State Morthal
	Bool Function IsFreeTown()
		Return Slaverun.IsFreeTownMorthal()
	EndFunction
	
	Int Function GetInnCost()
		Return LocCentral.InnCosts[7]
	EndFunction
	
	Bool Function HasHomeAtLoc()
		If StorageUtil.FormListCount(None, "_SLS_TempPassMorthal") > 0
			Return true
		EndIf
		Return false
	EndFunction
	
	Bool Function HasVanillaHomeAtLoc()
		Return false
	EndFunction

	Bool Function HasVanillaHomeInHold()
		Return false
	EndFunction
	
	Bool Function HasWartimesHomeInHold()
		Return false
	EndFunction
	
	Form[] Function GetHomeDoorList()
		Return None
	EndFunction
	
	Bool Function IsEvictedAtLoc()
		Return false
	EndFunction
	
	Bool Function HasKennelAtLoc()
		Return false
	EndFunction

	Bool Function HasKennelInHold()
		Return false
	EndFunction
	
	Bool Function HasBeggarLairAtLoc()
		Return false
	EndFunction

	Bool Function HasBeggarLairInHold()
		Return false
	EndFunction
	
	ObjectReference Function GetInnDoor()
		Return Game.GetFormFromFile(0x177AF, "Skyrim.esm") as ObjectReference
	EndFunction
	
	Float Function GetDanceLocThreshold()
		Return 0.1
	EndFunction
	
	ObjectReference Function GetForcedEscortTpMarker()
		Return _SLS_EscortTpSolitude
	EndFunction
	
	Formlist Function GetEnforcerList()
		Return _SLS_LicTownEnforcersList.GetAt(2) as Formlist
	EndFunction
EndState

State Riverwood
	Bool Function IsFreeTown()
		Return Slaverun.IsFreeTownRiverwood()
	EndFunction
	
	Int Function GetInnCost()
		Return LocCentral.InnCosts[8]
	EndFunction
	
	Bool Function HasHomeAtLoc()
		GoToState("Whiterun")
		Return HasHomeAtLoc()
	EndFunction
	
	Bool Function HasVanillaHomeAtLoc()
		Return false
	EndFunction

	Bool Function HasVanillaHomeInHold()
		GoToState("Whiterun")
		Return HasVanillaHomeInHold()
	EndFunction
	
	Bool Function HasWartimesHomeInHold()
		GoToState("Whiterun")
		Return HasWartimesHomeInHold()
	EndFunction
	
	Form[] Function GetHomeDoorList()
		Return None
	EndFunction
	
	Bool Function IsEvictedAtLoc()
		GoToState("Whiterun")
		Return IsEvictedAtLoc()
	EndFunction
	
	Bool Function HasKennelAtLoc()
		Return false
	EndFunction

	Bool Function HasKennelInHold()
		Return true
	EndFunction
	
	Bool Function HasBeggarLairAtLoc()
		Return false
	EndFunction

	Bool Function HasBeggarLairInHold()
		Return false
	EndFunction
	
	ObjectReference Function GetInnDoor()
		Return Game.GetFormFromFile(0x13424, "Skyrim.esm") as ObjectReference
	EndFunction
	
	Float Function GetDanceLocThreshold()
		Return 0.1
	EndFunction
	
	ObjectReference Function GetForcedEscortTpMarker()
		Return _SLS_EscortTpWhiterun
	EndFunction
	
	Formlist Function GetEnforcerList()
		Return _SLS_LicTownEnforcersList.GetAt(3) as Formlist
	EndFunction
EndState

State Winterhold
	Bool Function IsFreeTown()
		Return Slaverun.IsFreeTownWinterhold()
	EndFunction
	
	Int Function GetInnCost()
		Return LocCentral.InnCosts[10]
	EndFunction
	
	Bool Function HasHomeAtLoc()
		If StorageUtil.FormListCount(None, "_SLS_TempPassWinterhold") > 0
			Return true
		EndIf
		Return false
	EndFunction
	
	Bool Function HasVanillaHomeAtLoc()
		Return false
	EndFunction

	Bool Function HasVanillaHomeInHold()
		Return false
	EndFunction
	
	Bool Function HasWartimesHomeInHold()
		Return false
	EndFunction
	
	Form[] Function GetHomeDoorList()
		Return None
	EndFunction
	
	Bool Function IsEvictedAtLoc()
		Return false
	EndFunction
	
	Bool Function HasKennelAtLoc()
		Return false
	EndFunction

	Bool Function HasKennelInHold()
		Return false
	EndFunction
	
	Bool Function HasBeggarLairAtLoc()
		Return false
	EndFunction

	Bool Function HasBeggarLairInHold()
		Return false
	EndFunction
	
	ObjectReference Function GetInnDoor()
		Return Game.GetFormFromFile(0x177FB, "Skyrim.esm") as ObjectReference
	EndFunction
	
	Float Function GetDanceLocThreshold()
		Return 0.1
	EndFunction
	
	ObjectReference Function GetForcedEscortTpMarker()
		Return _SLS_EscortTpWindhelm
	EndFunction
	
	Formlist Function GetEnforcerList()
		Return _SLS_LicTownEnforcersList.GetAt(5) as Formlist
	EndFunction
EndState

; City exteriors ===================================================================================================
State WhiterunExterior
	Bool Function IsFreeTown()
		Return Slaverun.IsFreeTownWhiterun()
	EndFunction
	
	Int Function GetInnCost()
		Return LocCentral.InnCosts[0]
	EndFunction
	
	Bool Function HasHomeAtLoc()
		GoToState("Whiterun")
		Return HasHomeAtLoc()
	EndFunction
	
	Bool Function HasVanillaHomeAtLoc()
		GoToState("Whiterun")
		Return HasVanillaHomeAtLoc()
	EndFunction

	Bool Function HasVanillaHomeInHold()
		GoToState("Whiterun")
		Return HasVanillaHomeInHold()
	EndFunction
	
	Bool Function HasWartimesHomeInHold()
		GoToState("Whiterun")
		Return HasWartimesHomeInHold()
	EndFunction
	
	Form[] Function GetHomeDoorList()
		GoToState("Whiterun")
		Return GetHomeDoorList()
	EndFunction
	
	Bool Function IsEvictedAtLoc()
		GoToState("Whiterun")
		Return IsEvictedAtLoc()
	EndFunction
	
	Bool Function HasKennelAtLoc()
		Return true
	EndFunction

	Bool Function HasKennelInHold()
		Return true
	EndFunction
	
	Bool Function HasBeggarLairAtLoc()
		Return false
	EndFunction

	Bool Function HasBeggarLairInHold()
		Return false
	EndFunction
	
	ObjectReference Function GetInnDoor()
		Return Game.GetFormFromFile(0x1A6F4, "Skyrim.esm") as ObjectReference
	EndFunction
	
	Float Function GetDanceLocThreshold()
		Return 0.5
	EndFunction
	
	ObjectReference Function GetForcedEscortTpMarker()
		Return _SLS_EscortTpWhiterun
	EndFunction
	
	Formlist Function GetEnforcerList()
		Return None
	EndFunction
EndState

State SolitudeExterior
	Bool Function IsFreeTown()
		Return Slaverun.IsFreeTownSolitude()
	EndFunction
	
	Int Function GetInnCost()
		Return LocCentral.InnCosts[1]
	EndFunction
	
	Bool Function HasHomeAtLoc()
		GoToState("Solitude")
		Return HasHomeAtLoc()
	EndFunction
	
	Bool Function HasVanillaHomeAtLoc()
		GoToState("Solitude")
		Return HasVanillaHomeAtLoc()
	EndFunction

	Bool Function HasVanillaHomeInHold()
		GoToState("Solitude")
		Return HasVanillaHomeInHold()
	EndFunction
	
	Bool Function HasWartimesHomeInHold()
		Return false
	EndFunction
	
	Form[] Function GetHomeDoorList()
		Return None
	EndFunction
	
	Bool Function IsEvictedAtLoc()
		GoToState("Solitude")
		Return IsEvictedAtLoc()
	EndFunction
	
	Bool Function HasKennelAtLoc()
		Return true
	EndFunction

	Bool Function HasKennelInHold()
		Return true
	EndFunction
	
	Bool Function HasBeggarLairAtLoc()
		Return false
	EndFunction

	Bool Function HasBeggarLairInHold()
		Return false
	EndFunction
	
	ObjectReference Function GetInnDoor()
		Return Game.GetFormFromFile(0x37F25, "Skyrim.esm") as ObjectReference
	EndFunction
	
	Float Function GetDanceLocThreshold()
		Return 0.5
	EndFunction
	
	ObjectReference Function GetForcedEscortTpMarker()
		Return _SLS_EscortTpSolitude
	EndFunction
	
	Formlist Function GetEnforcerList()
		Return None
	EndFunction
EndState

State MarkarthExterior
	Bool Function IsFreeTown()
		Return Slaverun.IsFreeTownMarkarth()
	EndFunction
	
	Int Function GetInnCost()
		Return LocCentral.InnCosts[2]
	EndFunction
	
	Bool Function HasHomeAtLoc()
		GoToState("Markarth")
		Return HasHomeAtLoc()
	EndFunction
	
	Bool Function HasVanillaHomeAtLoc()
		GoToState("Markarth")
		Return HasVanillaHomeAtLoc()
	EndFunction

	Bool Function HasVanillaHomeInHold()
		GoToState("Markarth")
		Return HasVanillaHomeInHold()
	EndFunction
	
	Bool Function HasWartimesHomeInHold()
		Return false
	EndFunction
	
	Form[] Function GetHomeDoorList()
		Return None
	EndFunction
	
	Bool Function IsEvictedAtLoc()
		GoToState("Markarth")
		Return IsEvictedAtLoc()
	EndFunction
	
	Bool Function HasKennelAtLoc()
		Return true
	EndFunction

	Bool Function HasKennelInHold()
		Return true
	EndFunction
	
	Bool Function HasBeggarLairAtLoc()
		Return true
	EndFunction

	Bool Function HasBeggarLairInHold()
		Return true
	EndFunction
	
	ObjectReference Function GetInnDoor()
		Return Game.GetFormFromFile(0x16E3B, "Skyrim.esm") as ObjectReference
	EndFunction
	
	Float Function GetDanceLocThreshold()
		Return 0.5
	EndFunction
	
	ObjectReference Function GetForcedEscortTpMarker()
		Return _SLS_EscortTpMarkarth
	EndFunction
	
	Formlist Function GetEnforcerList()
		Return None
	EndFunction
EndState

State WindhelmExterior
	Bool Function IsFreeTown()
		Return Slaverun.IsFreeTownWindhelm()
	EndFunction
	
	Int Function GetInnCost()
		Return LocCentral.InnCosts[3]
	EndFunction
	
	Bool Function HasHomeAtLoc()
		GoToState("Windhelm")
		Return HasHomeAtLoc()
	EndFunction
	
	Bool Function HasVanillaHomeAtLoc()
		GoToState("Windhelm")
		Return HasVanillaHomeAtLoc()
	EndFunction

	Bool Function HasVanillaHomeInHold()
		GoToState("Windhelm")
		Return HasVanillaHomeInHold()
	EndFunction
	
	Bool Function HasWartimesHomeInHold()
		Return false
	EndFunction
	
	Form[] Function GetHomeDoorList()
		Return None
	EndFunction
	
	Bool Function IsEvictedAtLoc()
		GoToState("Windhelm")
		Return IsEvictedAtLoc()
	EndFunction
	
	Bool Function HasKennelAtLoc()
		Return true
	EndFunction

	Bool Function HasKennelInHold()
		Return true
	EndFunction
	
	Bool Function HasBeggarLairAtLoc()
		Return false
	EndFunction

	Bool Function HasBeggarLairInHold()
		Return false
	EndFunction
	
	ObjectReference Function GetInnDoor()
		Return Game.GetFormFromFile(0xD18B1, "Skyrim.esm") as ObjectReference
	EndFunction
	
	Float Function GetDanceLocThreshold()
		Return 0.5
	EndFunction
	
	ObjectReference Function GetForcedEscortTpMarker()
		Return _SLS_EscortTpWindhelm
	EndFunction
	
	Formlist Function GetEnforcerList()
		Return None
	EndFunction
EndState

State RiftenExterior
	Bool Function IsFreeTown()
		Return Slaverun.IsFreeTownRiften()
	EndFunction
	
	Int Function GetInnCost()
		Return LocCentral.InnCosts[4]
	EndFunction
	
	Bool Function HasHomeAtLoc()
		GoToState("Riften")
		Return HasHomeAtLoc()
	EndFunction
	
	Bool Function HasVanillaHomeAtLoc()
		GoToState("Riften")
		Return HasVanillaHomeAtLoc()
	EndFunction

	Bool Function HasVanillaHomeInHold()
		GoToState("Riften")
		Return HasVanillaHomeInHold()
	EndFunction
	
	Bool Function HasWartimesHomeInHold()
		Return false
	EndFunction
	
	Bool Function IsEvictedAtLoc()
		GoToState("Riften")
		Return IsEvictedAtLoc()
	EndFunction
	
	Bool Function HasKennelAtLoc()
		Return true
	EndFunction

	Bool Function HasKennelInHold()
		Return true
	EndFunction
	
	Bool Function HasBeggarLairAtLoc()
		Return true
	EndFunction

	Bool Function HasBeggarLairInHold()
		Return true
	EndFunction
	
	Form[] Function GetHomeDoorList()
		Return None
	EndFunction
	
	ObjectReference Function GetInnDoor()
		Return Game.GetFormFromFile(0x430A6, "Skyrim.esm") as ObjectReference
	EndFunction
	
	Float Function GetDanceLocThreshold()
		Return 0.5
	EndFunction
	
	ObjectReference Function GetForcedEscortTpMarker()
		Return _SLS_EscortTpRiften
	EndFunction
	
	Formlist Function GetEnforcerList()
		Return None
	EndFunction
EndState

; Small towns ===========================================================================================
State Rorikstead
	Bool Function IsFreeTown()
		Return Slaverun.IsFreeTownRiverwood()
	EndFunction
	
	Int Function GetInnCost()
		Return LocCentral.InnCosts[9]
	EndFunction
	
	Bool Function HasHomeAtLoc()
		GoToState("Whiterun")
		Return HasHomeAtLoc()
	EndFunction
	
	Bool Function HasVanillaHomeAtLoc()
		Return false
	EndFunction

	Bool Function HasVanillaHomeInHold()
		GoToState("Whiterun")
		Return HasVanillaHomeInHold()
	EndFunction
	
	Bool Function HasWartimesHomeInHold()
		GoToState("Whiterun")
		Return HasWartimesHomeInHold()
	EndFunction
	
	Form[] Function GetHomeDoorList()
		Return None
	EndFunction
	
	Bool Function IsEvictedAtLoc()
		GoToState("Whiterun")
		Return IsEvictedAtLoc()
	EndFunction
	
	Bool Function HasKennelAtLoc()
		Return false
	EndFunction

	Bool Function HasKennelInHold()
		Return true
	EndFunction
	
	Bool Function HasBeggarLairAtLoc()
		Return false
	EndFunction

	Bool Function HasBeggarLairInHold()
		Return false
	EndFunction
	
	ObjectReference Function GetInnDoor()
		Return Game.GetFormFromFile(0x177D1, "Skyrim.esm") as ObjectReference
	EndFunction
	
	Float Function GetDanceLocThreshold()
		Return 0.3
	EndFunction
	
	ObjectReference Function GetForcedEscortTpMarker()
		Return _SLS_EscortTpWhiterun
	EndFunction
	
	Formlist Function GetEnforcerList()
		Return _SLS_LicTownEnforcersList.GetAt(4) as Formlist
	EndFunction
EndState

State Dragonbridge
	Bool Function IsFreeTown()
		Return Slaverun.IsFreeTownSolitude()
	EndFunction
	
	Int Function GetInnCost()
		Return LocCentral.InnCosts[11]
	EndFunction
	
	Bool Function HasHomeAtLoc()
		GoToState("Solitude")
		Return HasHomeAtLoc()
	EndFunction
	
	Bool Function HasVanillaHomeAtLoc()
		Return false
	EndFunction

	Bool Function HasVanillaHomeInHold()
		GoToState("Solitude")
		Return HasVanillaHomeInHold()
	EndFunction
	
	Bool Function HasWartimesHomeInHold()
		Return false
	EndFunction
	
	Form[] Function GetHomeDoorList()
		Return None
	EndFunction
	
	Bool Function IsEvictedAtLoc()
		GoToState("Solitude")
		Return IsEvictedAtLoc()
	EndFunction
	
	Bool Function HasKennelAtLoc()
		Return false
	EndFunction

	Bool Function HasKennelInHold()
		Return true
	EndFunction
	
	Bool Function HasBeggarLairAtLoc()
		Return false
	EndFunction

	Bool Function HasBeggarLairInHold()
		Return false
	EndFunction
	
	ObjectReference Function GetInnDoor()
		Return Game.GetFormFromFile(0x1775D, "Skyrim.esm") as ObjectReference
	EndFunction
	
	Float Function GetDanceLocThreshold()
		Return 0.3
	EndFunction
	
	ObjectReference Function GetForcedEscortTpMarker()
		Return _SLS_EscortTpSolitude
	EndFunction
	
	Formlist Function GetEnforcerList()
		Return _SLS_LicTownEnforcersList.GetAt(6) as Formlist
	EndFunction
EndState

State Kynesgrove
	Bool Function IsFreeTown()
		Return Slaverun.IsFreeTownWindhelm()
	EndFunction
	
	Int Function GetInnCost()
		Return LocCentral.InnCosts[12]
	EndFunction
	
	Bool Function HasHomeAtLoc()
		GoToState("Windhelm")
		Return HasHomeAtLoc()
	EndFunction
	
	Bool Function HasVanillaHomeAtLoc()
		Return false
	EndFunction

	Bool Function HasVanillaHomeInHold()
		GoToState("Windhelm")
		Return HasVanillaHomeInHold()
	EndFunction
	
	Bool Function HasWartimesHomeInHold()
		Return false
	EndFunction
	
	Form[] Function GetHomeDoorList()
		Return None
	EndFunction
	
	Bool Function IsEvictedAtLoc()
		GoToState("Windhelm")
		Return IsEvictedAtLoc()
	EndFunction
	
	Bool Function HasKennelAtLoc()
		Return false
	EndFunction

	Bool Function HasKennelInHold()
		Return true
	EndFunction
	
	Bool Function HasBeggarLairAtLoc()
		Return false
	EndFunction

	Bool Function HasBeggarLairInHold()
		Return false
	EndFunction
	
	ObjectReference Function GetInnDoor()
		Return Game.GetFormFromFile(0x177A5, "Skyrim.esm") as ObjectReference
	EndFunction
	
	Float Function GetDanceLocThreshold()
		Return 0.3
	EndFunction
	
	ObjectReference Function GetForcedEscortTpMarker()
		Return _SLS_EscortTpWindhelm
	EndFunction
	
	Formlist Function GetEnforcerList()
		Return _SLS_LicTownEnforcersList.GetAt(7) as Formlist
	EndFunction
EndState

State ShorsStone
	Bool Function IsFreeTown()
		Return Slaverun.IsFreeTownRiften()
	EndFunction
	
	Int Function GetInnCost()
		Return LocCentral.InnCosts[13]
	EndFunction
	
	Bool Function HasHomeAtLoc()
		GoToState("Riften")
		Return HasHomeAtLoc()
	EndFunction
	
	Bool Function HasVanillaHomeAtLoc()
		Return false
	EndFunction

	Bool Function HasVanillaHomeInHold()
		GoToState("Riften")
		Return HasVanillaHomeInHold()
	EndFunction
	
	Bool Function HasWartimesHomeInHold()
		Return false
	EndFunction
	
	Form[] Function GetHomeDoorList()
		Return None
	EndFunction
	
	Bool Function IsEvictedAtLoc()
		GoToState("Riften")
		Return IsEvictedAtLoc()
	EndFunction
	
	Bool Function HasKennelAtLoc()
		Return false
	EndFunction

	Bool Function HasKennelInHold()
		Return true
	EndFunction
	
	Bool Function HasBeggarLairAtLoc()
		Return false
	EndFunction

	Bool Function HasBeggarLairInHold()
		Return true
	EndFunction
	
	ObjectReference Function GetInnDoor()
		Return Game.GetFormFromFile(0x430A6, "Skyrim.esm") as ObjectReference ; Bee and barb
	EndFunction
	
	Float Function GetDanceLocThreshold()
		Return 0.3
	EndFunction
	
	ObjectReference Function GetForcedEscortTpMarker()
		Return _SLS_EscortTpRiften
	EndFunction
	
	Formlist Function GetEnforcerList()
		Return _SLS_LicTownEnforcersList.GetAt(8) as Formlist
	EndFunction
EndState

State Ivarstead
	Bool Function IsFreeTown()
		Return Slaverun.IsFreeTownRiften()
	EndFunction
	
	Int Function GetInnCost()
		Return LocCentral.InnCosts[14]
	EndFunction
	
	Bool Function HasHomeAtLoc()
		GoToState("Riften")
		Return HasHomeAtLoc()
	EndFunction
	
	Bool Function HasVanillaHomeAtLoc()
		Return false
	EndFunction

	Bool Function HasVanillaHomeInHold()
		GoToState("Riften")
		Return HasVanillaHomeInHold()
	EndFunction
	
	Bool Function HasWartimesHomeInHold()
		Return false
	EndFunction
	
	Form[] Function GetHomeDoorList()
		Return None
	EndFunction
	
	Bool Function IsEvictedAtLoc()
		GoToState("Riften")
		Return IsEvictedAtLoc()
	EndFunction
	
	Bool Function HasKennelAtLoc()
		Return false
	EndFunction

	Bool Function HasKennelInHold()
		Return true
	EndFunction
	
	Bool Function HasBeggarLairAtLoc()
		Return false
	EndFunction

	Bool Function HasBeggarLairInHold()
		Return true
	EndFunction
	
	ObjectReference Function GetInnDoor()
		Return Game.GetFormFromFile(0x17797, "Skyrim.esm") as ObjectReference
	EndFunction
	
	Float Function GetDanceLocThreshold()
		Return 0.3
	EndFunction
	
	ObjectReference Function GetForcedEscortTpMarker()
		Return _SLS_EscortTpRiften
	EndFunction
	
	Formlist Function GetEnforcerList()
		Return _SLS_LicTownEnforcersList.GetAt(9) as Formlist
	EndFunction
EndState

State Kartwasten
	Bool Function IsFreeTown()
		Return Slaverun.IsFreeTownMarkarth()
	EndFunction
	
	Int Function GetInnCost()
		Return LocCentral.InnCosts[15]
	EndFunction
	
	Bool Function HasHomeAtLoc()
		GoToState("Markarth")
		Return HasHomeAtLoc()
	EndFunction
	
	Bool Function HasVanillaHomeAtLoc()
		Return false
	EndFunction

	Bool Function HasVanillaHomeInHold()
		GoToState("Markarth")
		Return HasVanillaHomeInHold()
	EndFunction
	
	Bool Function HasWartimesHomeInHold()
		Return false
	EndFunction
	
	Form[] Function GetHomeDoorList()
		Return None
	EndFunction
	
	Bool Function IsEvictedAtLoc()
		GoToState("Markarth")
		Return IsEvictedAtLoc()
	EndFunction
	
	Bool Function HasKennelAtLoc()
		Return false
	EndFunction

	Bool Function HasKennelInHold()
		Return true
	EndFunction
	
	Bool Function HasBeggarLairAtLoc()
		Return false
	EndFunction

	Bool Function HasBeggarLairInHold()
		Return true
	EndFunction
	
	ObjectReference Function GetInnDoor()
		Return Game.GetFormFromFile(0x17798, "Skyrim.esm") as ObjectReference ; Miner's Barracks
	EndFunction
	
	Float Function GetDanceLocThreshold()
		Return 0.3
	EndFunction
	
	ObjectReference Function GetForcedEscortTpMarker()
		Return _SLS_EscortTpMarkarth
	EndFunction
	
	Formlist Function GetEnforcerList()
		Return None
	EndFunction
EndState

State Nightgate
	Bool Function IsFreeTown()
		Return Slaverun.IsFreeTownDawnstar()
	EndFunction
	
	Int Function GetInnCost()
		Return LocCentral.InnCosts[16]
	EndFunction
	
	Bool Function HasHomeAtLoc()
		GoToState("Dawnstar")
		Return HasHomeAtLoc()
	EndFunction
	
	Bool Function HasVanillaHomeAtLoc()
		Return false
	EndFunction

	Bool Function HasVanillaHomeInHold()
		GoToState("Dawnstar")
		Return HasVanillaHomeInHold()
	EndFunction
	
	Bool Function HasWartimesHomeInHold()
		Return false
	EndFunction
	
	Form[] Function GetHomeDoorList()
		Return None
	EndFunction
	
	Bool Function IsEvictedAtLoc()
		GoToState("Dawnstar")
		Return IsEvictedAtLoc()
	EndFunction
	
	Bool Function HasKennelAtLoc()
		Return false
	EndFunction

	Bool Function HasKennelInHold()
		Return false
	EndFunction
	
	Bool Function HasBeggarLairAtLoc()
		Return false
	EndFunction

	Bool Function HasBeggarLairInHold()
		Return false
	EndFunction
	
	ObjectReference Function GetInnDoor()
		Return Game.GetFormFromFile(0x17786, "Skyrim.esm") as ObjectReference
	EndFunction
	
	Float Function GetDanceLocThreshold()
		Return 0.3
	EndFunction
	
	ObjectReference Function GetForcedEscortTpMarker()
		Return _SLS_EscortTpWindhelm
	EndFunction
	
	Formlist Function GetEnforcerList()
		Return None
	EndFunction
EndState

State OldHroldan
	Bool Function IsFreeTown()
		Return Slaverun.IsFreeTownMarkarth()
	EndFunction
	
	Int Function GetInnCost()
		Return LocCentral.InnCosts[17]
	EndFunction
	
	Bool Function HasHomeAtLoc()
		GoToState("Markarth")
		Return HasHomeAtLoc()
	EndFunction
	
	Bool Function HasVanillaHomeAtLoc()
		Return false
	EndFunction

	Bool Function HasVanillaHomeInHold()
		GoToState("Markarth")
		Return HasVanillaHomeInHold()
	EndFunction
	
	Bool Function HasWartimesHomeInHold()
		Return false
	EndFunction
	
	Form[] Function GetHomeDoorList()
		Return None
	EndFunction
	
	Bool Function IsEvictedAtLoc()
		GoToState("Markarth")
		Return IsEvictedAtLoc()
	EndFunction
	
	Bool Function HasKennelAtLoc()
		Return false
	EndFunction

	Bool Function HasKennelInHold()
		Return true
	EndFunction
	
	Bool Function HasBeggarLairAtLoc()
		Return false
	EndFunction

	Bool Function HasBeggarLairInHold()
		Return true
	EndFunction
	
	ObjectReference Function GetInnDoor()
		Return Game.GetFormFromFile(0x1762F, "Skyrim.esm") as ObjectReference
	EndFunction
	
	Float Function GetDanceLocThreshold()
		Return 0.3
	EndFunction
	
	ObjectReference Function GetForcedEscortTpMarker()
		Return _SLS_EscortTpMarkarth
	EndFunction
	
	Formlist Function GetEnforcerList()
		Return None
	EndFunction
EndState

ObjectReference Property _SLS_EscortTpWhiterun Auto
ObjectReference Property _SLS_EscortTpSolitude Auto
ObjectReference Property _SLS_EscortTpMarkarth Auto
ObjectReference Property _SLS_EscortTpWindhelm Auto
ObjectReference Property _SLS_EscortTpRiften Auto

Faction Property PlayerFaction Auto

Formlist Property _SLS_LicTownEnforcersList Auto

GlobalVariable Property _SLS_KennelResDealLoc Auto

_SLS_LocTrackCentral Property LocCentral Auto
_SLS_InterfaceSlaverun Property Slaverun Auto
SLS_EvictionTrack Property Eviction Auto
