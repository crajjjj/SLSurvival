Scriptname _SLS_DeviousEffectsGagTrade extends Quest  

Event OnInit()
	ToggleActive()
EndEvent

Function ToggleActive()
	If Menu.DevEffNoGagTrading
		RegisterForMenu("BarterMenu")
	Else
		UnregisterForMenu("BarterMenu")
	EndIf
EndFunction

Event OnMenuOpen(String MenuName)
	If Devious.IsPlayerGagged()
		CeaseTrading()
	EndIf
EndEvent

Function CeaseTrading()
	While Utility.IsInMenuMode()
		;Debug.Messagebox("KeY: " + Input.GetMappedKey("Tween Menu", DeviceType = 0xFF))
		;Input.TapKey(Input.GetMappedKey("Tween Menu", DeviceType = 0xFF))
		UI.InvokeString("BarterMenu", "_root.Menu_mc.onExitButtonPress", "")
		Utility.WaitMenuMode(0.1)
	EndWhile

	Debug.Notification("I can't trade while I am gagged")
EndFunction

SLS_Mcm Property Menu Auto
_SLS_InterfaceDevious Property Devious Auto
