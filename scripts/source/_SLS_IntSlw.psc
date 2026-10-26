Scriptname _SLS_IntSlw Hidden
{SL Widgets wrappers - the only place referencing SL Widgets' scripts. Callers gate on
Game.IsPluginInstalled("SLWidgets.esp") (the plugin is ESL-flagged, so GetModByName can't see
it): a call into a script that is not installed aborts the caller.}

; What SL Widgets' crosshair hotkey does (slw_config.OnKeyDown, 3.0.1): clears the actor's NPC
; slot if it has one, else assigns the first free slot. Same checks and notifications as the
; hotkey, so the wheel and the hotkey read alike.
Function ToggleTrackNpc(Actor akActor) Global
	slw_config Config = Quest.GetQuest("SLWidgetsConfig") as slw_config
	If !Config || !akActor
		Return
	EndIf
	; Refused while SL Widgets is disabled: its modules return early when stopped, so a new slot
	; would get a name label with no icons under it
	If Config.slw_stopped
		Debug.Notification("SLWidgets: enable the mod first in MCM")
		Return
	EndIf
	Int Existing = Config.findNpcSlot(akActor)
	If Existing > 0
		Config.clearNpcSlot(Existing)
		Debug.Notification("SLWidgets: cleared NPC slot " + Existing + " (" + akActor.GetDisplayName() + ")")
		Return
	EndIf
	slw_widget_controller Controller = Config.widget_controller
	If Controller && !Controller.hasBarsAPI()
		Debug.Notification("SLWidgets: NPC tracking needs iWant Status Bars 2.10 or newer (see Debug page)")
		Return
	EndIf
	Int Empty = Config.findFirstEmptyNpcSlot()
	If Empty == 0
		Debug.Notification("SLWidgets: All NPC slots full - clear one in MCM.")
		Return
	EndIf
	Config.setNpcSlot(Empty, akActor)
	Debug.Notification("SLWidgets: tracking " + akActor.GetDisplayName() + " in NPC slot " + Empty)
	If Controller
		Controller.reloadNpcSlot(Empty)
	EndIf
EndFunction
