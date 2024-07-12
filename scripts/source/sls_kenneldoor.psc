Scriptname SLS_KennelDoor extends ObjectReference  

Event OnLoad()
	Self.SetLockLevel(255)
	Self.Lock(true)
EndEvent

Event OnLockStateChanged()
	If !Self.IsLocked()
		If Init.KennelState != 6
			Self.SetLockLevel(255)
			Self.Lock(true)
		EndIf
	EndIf
EndEvent

SLS_Init Property Init Auto