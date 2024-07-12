Scriptname _SLS_ThaneStatusTrackAlias extends ReferenceAlias  

Event OnLoad()
	;Debug.Messagebox("Loaded")
	RegisterForMenu("Dialogue Menu")
EndEvent

Event OnUnload()
	;Debug.Messagebox("UNLoaded")
	UnregisterForAllMenus()
EndEvent

Event OnMenuClose(String MenuName)
	; This isn't high priority so let other OnMenuClose events take precedence
	RegisterForSingleUpdate(2.0)
EndEvent

Event OnUpdate()
	;Debug.Messagebox("Update")

	; Check was player made thane
	If (Game.GetFormFromFile(0x0420BB, "SL Survival.esp") as _SLS_LicenceUtil).CheckThaneStatus(WhichHold)
		UnregisterForAllMenus()
		GoToState("Off")
	EndIf
EndEvent

State Off
	Event OnLoad()
	EndEvent

	Event OnUnload()
	EndEvent
EndState

Int Property WhichHold Auto ; WhichHold: 0 - Whiterun, 1 - Solitude, 2 - Markarth, 3 - Windhelm, 4 - Riften
