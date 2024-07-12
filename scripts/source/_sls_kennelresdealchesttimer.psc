Scriptname _SLS_KennelResDealChestTimer extends Quest  

Event OnInit()
	If Self.IsRunning()
		BeginTimer()
	EndIf
EndEvent

Function BeginTimer()
	_SLS_KennelStash.Lock(false)
	RegisterForSingleUpdateGameTime(1.0)
EndFunction

Event OnUpdateGameTime()
	_SLS_KennelStash.Lock(true)
	_SLS_KennelStash.SetLockLevel(255)
	Self.Stop()
EndEvent

ObjectReference Property _SLS_KennelStash Auto
