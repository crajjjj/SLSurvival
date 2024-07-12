Scriptname _SLS_CurfewTimer extends Quest  

Function SetRestartDelay(Float Delay)
	RegisterForSingleUpdate(Delay)
EndFunction

Event OnUpdate()
	Curfew.RestartCurfewLaw()	
EndEvent

_SLS_Curfew Property Curfew Auto
