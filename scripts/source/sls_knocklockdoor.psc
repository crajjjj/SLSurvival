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
EndFunction

; Unused since 0.802 (kept because saves hold it): Simply Knock's LinkedDoor alias, which this
; used to refill after the stay. Nothing cleared it afterwards, so Simply Knock kept unlocking the
; door of that house for good; SLS_Main.EndKnockStay now sees the stay out instead.
ReferenceAlias Property SkDoorAlias Auto