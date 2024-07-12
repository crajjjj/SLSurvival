Scriptname _SLS_ScreamForHelpSpectate extends Quest  

Event OnInit()
	RegisterForModEvent("HookAnimationEnd", "OnAnimationEnd")
	RegisterForSingleUpdate(60.0)
	
EndEvent

Event OnAnimationEnd(int tid, bool HasPlayer)
	If HasPlayer
		Utility.Wait(5.0)
		Self.Stop()
	EndIf
EndEvent

Event OnUpdate()

	; Stop the quest after 60 secs regardless
	Self.Stop()
EndEvent
