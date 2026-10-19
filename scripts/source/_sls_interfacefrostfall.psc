Scriptname _SLS_InterfaceFrostfall extends Quest  

Event OnInit()
	RegisterForModEvent("_SLS_Int_PlayerLoadsGame", "On_SLS_Int_PlayerLoadsGame")
EndEvent

Event On_SLS_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
	PlayerLoadsGame()
EndEvent

Function RegisterForDrenchEvent(Bool Reg)
	If Reg
		LicencesLost = 0
		RegisterForModEvent("Frostfall_UpdateWetnessMeter", "On_Frostfall_UpdateWetnessMeter")
	Else
		UnRegisterForModEvent("Frostfall_UpdateWetnessMeter")
	EndIf	
EndFunction

Event On_Frostfall_UpdateWetnessMeter()
	; MAX_WETNESS 		= 750.0
	If !IsDrenched && GetWetness() >= 750 ; Player is max wet
		IsDrenched = true
		RegisterForSingleUpdate(0.1)
		;/
		LicencesLost += 1
		LicUtil.GotDrenched()
	ElseIf Wetness <= 549.9 ; Player dried off to 'damp'
		LicencesLost = 0
		/;
	EndIf
EndEvent

Event OnUpdate()
	;Debug.MessageBox("UPDATE")
	If GetWetness() >= 550.0
		If LicencesLost < MaxLicsToLose && LicUtil.GotDrenched()
			LicencesLost += 1
		EndIf
		RegisterForSingleUpdate(4.0)
	Else
		IsDrenched = false
		LicencesLost = 0
		UnRegisterForUpdate()
	EndIf
EndEvent

Function PlayerLoadsGame()
	WfngOn = Game.GetModByName("WetFunctionNG.esp") != 255
	If Game.GetModByName("Frostfall.esp") != 255
		If GetState() != "Installed"
			GoToState("Installed")
		EndIf

	ElseIf WfngOn || Game.GetModByName("ccqdrsse001-survivalmode.esl") != 255 || Game.GetModByName("SunHelmSurvival.esp") != 255
		If GetState() != "Local"
			GoToState("Local")
		EndIf
		; the drench check polls WetFunction NG; re-arm it every load (Frostfall's mod event registration persisted on its own)
		RegisterForDrenchEvent(LicUtil.DrenchLicDestroyChance > 0.0)
	
	Else
		If GetState() != ""
			GoToState("")
		EndIf
	EndIf
EndFunction

; Creation Club Survival Mode: True only while it is switched on. Fetches the forms on first use.
Bool Function CcsOn()
	If Game.GetModByName("ccqdrsse001-survivalmode.esl") == 255
		Return false
	EndIf
	If !CcsModeEnabled
		CcsModeEnabled = Game.GetFormFromFile(0x000826, "ccqdrsse001-survivalmode.esl") as GlobalVariable ; Survival_ModeEnabled
		CcsColdQuest = Game.GetFormFromFile(0x000896, "ccqdrsse001-survivalmode.esl") as Quest ; Survival_NeedColdQuest
		CcsHeatQuest = Game.GetFormFromFile(0x000895, "ccqdrsse001-survivalmode.esl") as Quest ; Survival_HeatCheckQuest
	EndIf
	Return CcsModeEnabled && CcsModeEnabled.GetValueInt() == 1 && CcsColdQuest && CcsHeatQuest
EndFunction

; SunHelm: True while its cold system runs (SunHelm's MCM can switch cold off). Fetches the quest on first use, so the
; optional SunHelm patch plugin is not needed for warmth.
Bool Function ShsColdOn()
	If Game.GetModByName("SunHelmSurvival.esp") == 255
		Return false
	EndIf
	If !ShsColdQuest
		ShsColdQuest = Game.GetFormFromFile(0x6A13C2, "SunHelmSurvival.esp") as Quest ; _SHColdQuest (_SHColdSystem)
	EndIf
	Return ShsColdQuest && ShsColdQuest.IsRunning()
EndFunction

; True when ModExposure reaches a cold system, i.e. warmth from sex has somewhere to go
Bool Function HasColdSystem()
	Return false
EndFunction

Bool Function GetIsInterfaceActive()
	If GetState() == "Installed"
		Return true
	EndIf
	Return false
EndFunction

; Installed =======================================

State Installed
	Bool Function IsPlayerWarming()
		If _SLS_IntFrost.GetPlayerHeatSourceLevel() > 0
			Return true
		EndIf
		Return false
	EndFunction

	Bool Function IsColdEnvironment()
		If _SLS_IntFrost.IsColdEnvironment() < 10
			Return true
		EndIf
		Return false
	EndFunction

	Int Function GetTemperature()
		Return _SLS_IntFrost.GetTemperature()
	EndFunction
	
	Float Function GetWetness()
		Return FrostUtil.GetPlayerWetness()
	EndFunction

	Function ModWetness(Float Amount) ; amount: The amount to modify the player's wetness by. Positive numbers increase wetness, negative values decrease wetness.
		_SLS_IntFrost.ModWetness(Amount)
	EndFunction

	Function ModExposure(Float Amount) ; amount: The amount to modify the player's exposure by. Positive numbers increase exposure, negative values decrease exposure.
		_SLS_IntFrost.ModExposure(Amount)
	EndFunction

	Bool Function HasColdSystem()
		Return true
	EndFunction

	Bool Function IsCurrentWeatherSevere()
		Return _SLS_IntFrost.IsCurrentWeatherSevere()
	EndFunction

	ObjectReference Function GetCurrentTent()
		Return _SLS_IntFrost.GetCurrentTent()
	EndFunction

	Bool Function IsPlayerSheltered(ObjectReference Bed) ; Is used to detect whether player has something over their head that isn't a tent (rock/roof) but NOT a tent :S
		If Bed == None
			Bed = GetCurrentTent()
		EndIf
		If Bed == None
			Bed = PlayerRef
		EndIf
		
		ObjectReference Tent = Game.FindClosestReferenceOfAnyTypeInListFromRef(_SLS_Tents, Bed, 192.0)
		;Debug.MessageBox("Tent: " + Tent)
		If Tent == None
			Return _SLS_IntFrost.IsPlayerTakingShelter()
		Else
			Return true
		EndIf
	EndFunction
	
	Bool Function OpenAlchemyCrafting()
		If PlayerRef.GetItemCount(Mortar) > 0
			(Mortar as CampUsableMiscItem).OnEquipped(PlayerRef)
			ObjectReference MortarObjRef = PlayerRef.PlaceAtMe(Mortar, aiCount = 1, abForcePersist = false, abInitiallyDisabled = true)
			;MortarObjRef.MoveTo(PlayerRef, 0.0, 0.0, PlayerRef.GetHeight() - 200.0)
			;MortarObjRef.Enable()
			(MortarObjRef as CampUsableMiscItem).OnEquipped(PlayerRef)
			MortarObjRef.Delete()
			Return true
		Else
			Debug.Notification("I don't have a mortar & pestle")
			Return false
		EndIf
	EndFunction
	
	Function PlaceTent()
		Int i = 0
		Form akTentForm
		While i < _SLS_TentsInvObjects.GetSize()
			akTentForm = _SLS_TentsInvObjects.GetAt(i)
			If PlayerRef.GetItemCount(akTentForm) > 0
				ObjectReference TentObjRef = PlayerRef.PlaceAtMe(akTentForm, aiCount = 1, abForcePersist = false, abInitiallyDisabled = true)
				(TentObjRef as CampPlaceableMiscItem).OnEquipped(PlayerRef)
				TentObjRef.Delete()
				Return
			EndIf
			i += 1
		EndWhile
		Debug.Notification("I don't have a tent")
	EndFunction
	
	Function ShowMeters()
		WeatherSense.Cast(PlayerRef, PlayerRef)
	EndFunction
EndState

; Local: WetFunction NG + Survival Mode + SunHelm cold ======================================
; Frostfall scales kept for the callers: wetness 0..750 (550 = damp, 750 = drenched), exposure + colder / - warmer
; on a ~120 point meter, temperature 10 = neutral and lower = cold. Only exposure reaches SunHelm.

State Local
	Bool Function IsPlayerWarming()
		If CcsOn()
			Return _SLS_IntCcs.IsPlayerNearHeat(CcsHeatQuest)
		EndIf
		Return true
	EndFunction

	Bool Function IsColdEnvironment()
		If CcsOn()
			Return _SLS_IntCcs.GetColdLevel(CcsColdQuest) >= _SLS_IntCcs.GetChillyColdLevel(CcsColdQuest)
		EndIf
		Return false
	EndFunction

	Int Function GetTemperature()
		If IsColdEnvironment()
			Return 5
		EndIf
		Return 10
	EndFunction

	Float Function GetWetness()
		If WfngOn
			Float Cap = _SLS_IntWfng.GetWetnessCap()
			If Cap > 0.0
				Return _SLS_IntWfng.GetWetness(PlayerRef) / Cap * 750.0
			EndIf
		EndIf
		Return 0.0
	EndFunction

	Function ModWetness(Float Amount)
		If WfngOn
			Float Cap = _SLS_IntWfng.GetWetnessCap()
			_SLS_IntWfng.SetWetness(PlayerRef, _SLS_IntWfng.GetWetness(PlayerRef) + Amount / 750.0 * Cap)
		EndIf
	EndFunction

	Function ModExposure(Float Amount)
		If CcsOn()
			If Amount > 0.0
				_SLS_IntCcs.IncreaseCold(CcsColdQuest, Amount * ExposureToCold)
			ElseIf Amount < 0.0
				_SLS_IntCcs.DecreaseCold(CcsColdQuest, -Amount * ExposureToCold)
			EndIf
		EndIf
		; not ElseIf: each cold system that is running tracks the player on its own
		If ShsColdOn()
			If Amount > 0.0
				_SLS_IntShs.IncreaseColdLevel(Amount * ExposureToShsCold, ShsColdQuest)
			ElseIf Amount < 0.0
				_SLS_IntShs.DecreaseColdLevel(-Amount * ExposureToShsCold, ShsColdQuest)
			EndIf
		EndIf
	EndFunction

	Bool Function HasColdSystem()
		Return CcsOn() || ShsColdOn()
	EndFunction

	; WetFunction NG sends no wetness event: poll while the licence destroy chance is set
	Function RegisterForDrenchEvent(Bool Reg)
		LicencesLost = 0
		IsDrenched = false
		DrenchPoll = Reg && WfngOn
		If DrenchPoll
			RegisterForSingleUpdate(5.0)
		Else
			UnRegisterForUpdate()
		EndIf
	EndFunction

	Event OnUpdate()
		If !DrenchPoll
			Return
		EndIf
		Float Wet = GetWetness()
		If IsDrenched
			If Wet >= 550.0
				If LicencesLost < MaxLicsToLose && LicUtil.GotDrenched()
					LicencesLost += 1
				EndIf
				RegisterForSingleUpdate(4.0)
				Return
			EndIf
			IsDrenched = false ; dried off to 'damp'
			LicencesLost = 0
		ElseIf Wet >= 749.0 ; soaked through
			IsDrenched = true
			RegisterForSingleUpdate(0.1)
			Return
		EndIf
		RegisterForSingleUpdate(5.0)
	EndEvent
EndState

; Not Installed ====================================

Event OnEndState()
	Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet.
	If Game.GetModByName("Frostfall.esp") == 255 ; "Local" needs none of Frostfall's or Campfire's forms
		Return
	EndIf
	_SLS_Tents.Revert()
	_SLS_Tents.AddForm(Game.GetFormFromFile(0x052A98, "Campfire.esm")) ; _Camp_Tent_LargeHideStaticExterior
	_SLS_Tents.AddForm(Game.GetFormFromFile(0x052A9A, "Campfire.esm")) ; _Camp_Tent_LargeLeatherStaticExterior
	_SLS_Tents.AddForm(Game.GetFormFromFile(0x052A99, "Campfire.esm")) ; _Camp_Tent_SmallHideStaticExterior
	_SLS_Tents.AddForm(Game.GetFormFromFile(0x052A8E, "Campfire.esm")) ; _Camp_Tent_SmallLeatherStaticExterior
	
	_SLS_TentsInvObjects.Revert()
	_SLS_TentsInvObjects.AddForm(Game.GetFormFromFile(0x01A33D, "Campfire.esm")) ; _Camp_Tent_FurLarge4BR_MISC
	_SLS_TentsInvObjects.AddForm(Game.GetFormFromFile(0x01A33E, "Campfire.esm")) ; _Camp_Tent_FurLarge3BR_MISC
	_SLS_TentsInvObjects.AddForm(Game.GetFormFromFile(0x038CBE, "Campfire.esm")) ; _Camp_Tent_LeatherLarge3BR_MISC
	_SLS_TentsInvObjects.AddForm(Game.GetFormFromFile(0x01A347, "Campfire.esm")) ; _Camp_Tent_FurLarge2BR_MISC
	_SLS_TentsInvObjects.AddForm(Game.GetFormFromFile(0x038CBD, "Campfire.esm")) ; _Camp_Tent_LeatherLarge2BR_MISC
	_SLS_TentsInvObjects.AddForm(Game.GetFormFromFile(0x0624FB, "Campfire.esm")) ; _Camp_Tent_FurSmall2BR_MISC
	_SLS_TentsInvObjects.AddForm(Game.GetFormFromFile(0x036B70, "Campfire.esm")) ; _Camp_Tent_LeatherSmall2BR_MISC
	_SLS_TentsInvObjects.AddForm(Game.GetFormFromFile(0x01A348, "Campfire.esm")) ; _Camp_Tent_FurLarge1BR_MISC
	_SLS_TentsInvObjects.AddForm(Game.GetFormFromFile(0x038CBC, "Campfire.esm")) ; _Camp_Tent_LeatherLarge1BR_MISC
	_SLS_TentsInvObjects.AddForm(Game.GetFormFromFile(0x036B4E, "Campfire.esm")) ; _Camp_Tent_FurSmall1BR_MISC
	_SLS_TentsInvObjects.AddForm(Game.GetFormFromFile(0x01A314, "Campfire.esm")) ; _Camp_Tent_LeatherSmall1BR_MISC
	_SLS_TentsInvObjects.AddForm(Game.GetFormFromFile(0x0536E4, "Campfire.esm")) ; _Camp_Tent_HayPile1BR_Misc	
	
	Mortar = Game.GetFormFromFile(0x038689, "Campfire.esm")
	
	WeatherSense = Game.GetFormFromFile(0x016215, "Frostfall.esp") as Spell
EndEvent

Bool Function IsPlayerWarming()
	Return true
EndFunction

Bool Function IsColdEnvironment()
	Return false
EndFunction

Int Function GetTemperature()
	Return 10
EndFunction

Float Function GetWetness()
	Return 0.0
EndFunction

Function ModWetness(Float Amount)
EndFunction

Function ModExposure(Float Amount)
EndFunction

Bool Function IsCurrentWeatherSevere()
	Return false
EndFunction

ObjectReference Function GetCurrentTent()
	Return None
EndFunction

Bool Function IsPlayerSheltered(ObjectReference Bed)
	Return true
EndFunction

Bool Function OpenAlchemyCrafting()
	Return false
EndFunction

Function PlaceTent()
EndFunction

Function ShowMeters()
EndFunction

Bool IsDrenched = false
Bool WfngOn = false
Bool DrenchPoll = false
GlobalVariable CcsModeEnabled
Quest CcsColdQuest
Quest CcsHeatQuest
Float Property ExposureToCold = 8.0 Auto Hidden ; Frostfall exposure (~120) -> Survival Mode cold (1000)
Quest ShsColdQuest
Float Property ExposureToShsCold = 7.5 Auto Hidden ; Frostfall exposure (~120) -> SunHelm cold (cap 900)

Int LicencesLost = 0
Int Property MaxLicsToLose = 1 Auto Hidden

Formlist Property _SLS_Tents Auto
Formlist Property _SLS_TentsInvObjects Auto

Actor Property PlayerRef Auto

Form Mortar

Spell WeatherSense

_SLS_LicenceUtil Property LicUtil Auto
