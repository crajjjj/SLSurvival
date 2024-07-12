Scriptname _SLS_KennelResDealTimer extends Quest  

Event OnInit()
	If Self.IsRunning()
		SetDeadline()
	EndIf
EndEvent

Function SetDeadline()
	DidCheckIn = false
	RegisterForSingleUpdateGameTime((24.0 - GameHour.GetValue()) + 0.1)
EndFunction

Event OnUpdateGameTime()
	If Init.KennelResDeal == 2 ; Reset failed state
		;Debug.Messagebox("Reset!")
		Init.KennelResDeal = 0
	
	Else
		If DidCheckIn
			;Debug.Messagebox("Update!")
			SetDeadline()
		Else
			;Debug.Messagebox("Revoke!")
			RevokePrivileges()
			RegisterForSingleUpdateGameTime(24.0 * 7.0)
		EndIf
	EndIf
EndEvent

Function RevokePrivileges()
	Debug.Notification("Kennel privileges revoked!")
	Init.KennelResDeal = 2
	_SLS_KennelResDealLoc.SetValueInt(-1)
	PlayerRef.RemoveItem(PrivLicenceBase, 100)
	_SLS_KennelResDealLicExpiry.SetValue(-1.0)
EndFunction

Bool Property DidCheckIn = true Auto Hidden

Form Property PrivLicenceBase Auto Hidden

Actor Property PlayerRef Auto

GlobalVariable Property GameHour Auto
GlobalVariable Property _SLS_KennelResDealLoc Auto
GlobalVariable Property _SLS_KennelResDealLicExpiry Auto

SLS_Init Property Init Auto
