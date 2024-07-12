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
	If Game.GetModByName("Frostfall.esp") != 255
		If GetState() != "Installed"
			GoToState("Installed")
		EndIf
	
	Else
		If GetState() != ""
			GoToState("")
		EndIf
	EndIf
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

; Not Installed ====================================

Event OnEndState()
	Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet.
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

Int LicencesLost = 0
Int Property MaxLicsToLose = 1 Auto Hidden

Formlist Property _SLS_Tents Auto
Formlist Property _SLS_TentsInvObjects Auto

Actor Property PlayerRef Auto

Form Mortar

Spell WeatherSense

_SLS_LicenceUtil Property LicUtil Auto
