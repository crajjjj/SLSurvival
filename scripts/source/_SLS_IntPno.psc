Scriptname _SLS_IntPno Hidden
{Private Needs - Orgasm (PNO) wrappers - the only place referencing PNO's scripts. Callers gate on
Game.IsPluginInstalled("Private Needs - Orgasm.esp") (the plugin is ESL-flagged, so GetModByName
can't see it): a call into a script that is not installed aborts the caller.}

; PNO's universal hotkey: its own pee or poop menu. Refuses in the same cases the hotkey does.
Function UniversalMenu() Global
	PNO_UtilityScript Util = Quest.GetQuest("PNO_Config") as PNO_UtilityScript
	If !Util || !Util.PNO_Config
		Debug.Notification("Private Needs isn't ready yet")
		Return
	EndIf
	PNO_ConfigScript Config = Util.PNO_Config
	If !Config.PNO_MainQuest || !Config.PNO_MainQuest.IsRunning()
		Debug.Notification("Private Needs is switched off in its MCM")
		Return
	EndIf
	If !Config.bladdertoggleVal
		Debug.Notification("Private Needs: the bladder is switched off in its MCM")
		Return
	EndIf
	Util.PNMenu()
EndFunction
