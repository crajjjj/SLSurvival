Scriptname _SLS_MapAndCompassAlias extends ReferenceAlias  

Event OnInit()
	AddInventoryEventFilter(_SLS_MapAndCompass)
	RegisterForMenu("MapMenu")	
	If PlayerRef.GetItemCount(_SLS_MapAndCompass) > 0
		ToggleCompass(true)
	Else
		ToggleCompass(false)
	EndIf
EndEvent

Event OnPlayerLoadGame()
	If Devious.GetIsInterfaceActive()
		GoToState("Devious")
	Else
		GoToState("")
	EndIf
	
	;/ Unnecessary i think
	While UI.GetNumber("HUD Menu", "_root.HUDMovieBaseInstance.CompassShoutMeterHolder._alpha") == 0.0
		Utility.Wait(0.1)
		Debug.Trace("SLS_: Waiting")
	EndWhile
	Debug.Trace("SLS_: executing")
	/;
	
	ReinitNav()
EndEvent

State Devious
	Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
		If akBaseObject.HasKeyword(Devious.zad_DeviousBlindfold)
			ToggleCompass(false)
		EndIf
	EndEvent

	Event OnObjectUnEquipped(Form akBaseObject, ObjectReference akReference)
		If akBaseObject.HasKeyword(Devious.zad_DeviousBlindfold)
			ReinitNav()
		EndIf
	EndEvent
EndState

; Empty State - NOT Devious devices
Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
EndEvent

Event OnObjectUnEquipped(Form akBaseObject, ObjectReference akReference)
EndEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	If !Devious.IsPlayerBlindfolded()
		ToggleCompass(true)
	EndIf
EndEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	If PlayerRef.GetItemCount(_SLS_MapAndCompass) == 0
		ToggleCompass(false)
	EndIf
EndEvent

Event OnMenuOpen(String MenuName)
	If Init.IsPlayerInside && Menu.FastTravelDisable
		Game.EnableFastTravel(false)
	EndIf
	If (PlayerRef.GetItemCount(_SLS_MapAndCompass) == 0 && !TempAccess) || Devious.IsPlayerBlindfolded()
		Game.DisablePlayerControls(!Game.IsMovementControlsEnabled(), !Game.IsFightingControlsEnabled(), !Game.IsCamSwitchControlsEnabled(), !Game.IsLookingControlsEnabled(), !Game.IsSneakingControlsEnabled(), true, !Game.IsActivateControlsEnabled(), !Game.IsJournalControlsEnabled())
		Game.EnablePlayerControls(Game.IsMovementControlsEnabled(), Game.IsFightingControlsEnabled(), Game.IsCamSwitchControlsEnabled(), Game.IsLookingControlsEnabled(), Game.IsSneakingControlsEnabled(), true, Game.IsActivateControlsEnabled(), Game.IsJournalControlsEnabled())
		Debug.Notification("I don't have a map")
	EndIf
EndEvent

Function ReinitNav()
	If (PlayerRef.GetItemCount(_SLS_MapAndCompass) == 0 && !TempAccess) || Devious.IsPlayerBlindfolded()
		ToggleCompass(false)
		
		If Menu.CompassHideMethod == 0 || Menu.CompassHideMethod == 2
			Utility.Wait(2.0) ; Check again that something hasn't flipped the compass back on
			While UI.GetNumber("HUD Menu", "_root.HUDMovieBaseInstance.CompassShoutMeterHolder._alpha") > 0.0 ; This shouldn't happen much if at all but just in case
				ToggleCompass(false)
				debug.trace("SLS: Compass flip")
				Utility.WaitMenuMode(1.0)
			EndWhile
		EndIf
		
	Else
		ToggleCompass(true)
	EndIf
EndFunction

Function ToggleCompass(bool EnableCompass)
	If Menu.CompassHideMethod == 0 || Menu.CompassHideMethod == 2
		UI.SetNumber("HUD Menu", "_root.HUDMovieBaseInstance.CompassShoutMeterHolder._alpha", 100.0 * (EnableCompass as Float))
		UI.SetNumber("HUD Menu", "_root.HUDMovieBaseInstance.CompassShoutMeterHolder.Compass.DirectionRect._alpha",  100.0 * (EnableCompass as Float))
		UI.SetNumber("HUD Menu", "_root.HUDMovieBaseInstance.CompassShoutMeterHolder.Compass.CompassFrame._alpha",  100.0 * (EnableCompass as Float))
	EndIf
	If Menu.CompassHideMethod >= 1
		Utility.SetINIBool("bShowCompass:Interface", EnableCompass)
	EndIf
EndFunction

;/
Function EnableCompassMechanics(Bool IsEnabled)
	If IsEnabled
		AddInventoryEventFilter(_SLS_MapAndCompass)
		If PlayerRef.GetItemCount(_SLS_MapAndCompass) > 0
			HasNavTools = true
			If PlayerRef.WornHasKeyword(Devious.zad_DeviousBlindfold)
				ToggleCompass(false)
			Else
				ToggleCompass(true)
			EndIf
		EndIf
	Else
		RemoveInventoryEventFilter(_SLS_MapAndCompass)
		HasNavTools = true
		ToggleCompass(true)
	EndIf
EndFunction
/;

Function ResetCompass()
	Utility.SetINIBool("bShowCompass:Interface", true)
	UI.SetNumber("HUD Menu", "_root.HUDMovieBaseInstance.CompassShoutMeterHolder._alpha", 100.0)
	UI.SetNumber("HUD Menu", "_root.HUDMovieBaseInstance.CompassShoutMeterHolder.Compass.DirectionRect._alpha",  100.0)
	UI.SetNumber("HUD Menu", "_root.HUDMovieBaseInstance.CompassShoutMeterHolder.Compass.CompassFrame._alpha",  100.0)
	ReinitNav()
EndFunction

Function BeginTempAccess()
	TempAccess = true
	ToggleCompass(true)
	RegisterForSingleUpdate(Menu.ReplaceMapsTimer)
EndFunction

Event OnUpdate()
	TempAccess = false
	ReinitNav()
EndEvent

Bool Property TempAccess = false Auto Hidden

MiscObject Property _SLS_MapAndCompass Auto

Actor Property PlayerRef Auto

SLS_Init Property Init Auto
SLS_Mcm Property Menu Auto
_SLS_InterfaceDevious Property Devious Auto
