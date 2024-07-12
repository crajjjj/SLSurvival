Scriptname SLS_CellDoorScript extends ObjectReference

Event OnInit()
	StorageUtil.SetIntValue(None, "_SLS_KennelCellDoorHelp", 1)
EndEvent

Event OnCellAttach()
	Self.BlockActivation()
	If Self.GetOpenState() == 1
		Self.SetOpen(false)
	EndIf
	Self.SetLockLevel(255)
	Self.Lock(true)
	;Debug.Messagebox("Door locked: " + Self.IsLocked())
	PlayerLocked = Self.IsLocked()
EndEvent

;Int OldState = 0 ; 0 - Closed Locked, 1 - Closed Unlocked, 2 - Open, 

Bool PlayerLocked = true

Event OnActivate(ObjectReference akActionRef)
	If akActionRef == PlayerRef
		If StorageUtil.GetIntValue(None, "_SLS_KennelCellDoorHelp") == 1
			StorageUtil.UnSetIntValue(None, "_SLS_KennelCellDoorHelp")
			Debug.Messagebox("Welcome to your cell in a cell.\n\nTo keep yourself safe from the various nasty elements down here you should lock the cell with your key. To lock the door just close it and activate it again\n\nThis is the only time you'll get this warning")
		EndIf
		
		Int CurrentState = Self.GetOpenState()
		;Debug.Messagebox("Door locked: " + Self.IsLocked() + "\nPlayerLocked: " + PlayerLocked + "\nState: " + CurrentState)
		If CurrentState == 1 || PlayerRef.GetItemCount(_SLS_CellKey) == 0 ; Open
			Self.Activate(PlayerRef, true)
			PlayerLocked = false



		ElseIf CurrentState == 3 && PlayerRef.GetItemCount(_SLS_CellKey) > 0 && !Self.IsLocked() && !PlayerLocked
			Self.SetLockLevel(255)
			Self.Lock(true)
			_SLS_KennelGateUnlock.Play(Self)
			Debug.Notification("You lock the gate")
			PlayerLocked = true
			
		ElseIf CurrentState == 3 && PlayerRef.GetItemCount(_SLS_CellKey) > 0 && Self.IsLocked() && PlayerLocked
			Self.Lock(false)
			Self.Activate(PlayerRef, true)
			PlayerLocked = false
		EndIf
	EndIf
EndEvent

Actor Property PlayerRef Auto
Key Property _SLS_CellKey Auto
Sound Property _SLS_KennelGateUnlock Auto

;/
GetOpenState()
0: None (object can't be opened or closed)
1: Open
2: Opening
3: Closed
4: Closing
/;
