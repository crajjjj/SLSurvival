Scriptname _SLS_ScreamForHelpCombat extends Quest  

Actor Property PlayerRef Auto

Event OnInit()
	RegisterForSingleUpdate(4.0)
EndEvent

Event OnUpdate()
	If PlayerRef.IsInCombat()
		RegisterForSingleUpdate(4.0)
	Else
		Self.Stop()
	EndIf
EndEvent
