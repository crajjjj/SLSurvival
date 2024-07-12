Scriptname SLS_KnockLockDoor extends ReferenceAlias

Int DoorLockLevel

State LockdownDoor
	Event OnLockStateChanged()
		ObjectReference DoorRef= Self.GetReference()
		if !DoorRef.IsLocked()
			DoorRef.Lock(true, true)
			DoorRef.SetLockLevel(255)
		endIf
	endEvent
EndState

Function InitDoor()
	GoToState("LockDownDoor")
	ObjectReference DoorRef = Self.GetReference()
	DoorLockLevel = DoorRef.GetLockLevel()
	DoorRef.Lock(true, true)
	DoorRef.SetLockLevel(255)
EndFunction

Function RemoveLockdown()
	GoToState("")
	ObjectReference DoorRef = Self.GetReference()
	DoorRef.SetLockLevel(DoorLockLevel )
	DoorRef.Lock(false, true)
	SkDoorAlias.ForceRefTo(DoorRef)
EndFunction

ReferenceAlias Property SkDoorAlias Auto