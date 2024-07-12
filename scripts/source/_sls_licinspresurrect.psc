Scriptname _SLS_LicInspResurrect extends Actor  

Event OnDeath(Actor akKiller)
	Float RespawnDur = (Game.GetFormFromFile(0x000D64, "SL Survival.esp") as SLS_Mcm).EnforcerRespawnDur
	If RespawnDur > 0.0
		RegisterForSingleUpdateGameTime(RespawnDur * 24.0)
	EndIf
EndEvent

Event OnUpdateGameTime()
	;Debug.Messagebox("Resurrect")
	Resurrect() ; Resurrect before reset to stop Npcs being... sideways
	Reset()
EndEvent
