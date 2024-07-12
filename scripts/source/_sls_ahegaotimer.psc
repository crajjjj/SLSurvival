Scriptname _SLS_AhegaoTimer extends Quest

Function BeginAhegao(Float Timer)
	;Debug.Messagebox("Ahegao for " + Timer + " seconds")
	RegisterForSingleUpdate(Timer)
EndFunction

Event OnUpdate()
	Ahegao.EndAhegao()
	UnRegisterForUpdate()
EndEvent

_SLS_Ahegao Property Ahegao Auto
