Scriptname _STA_SpankKickerScript extends Quest  

_STA_SpankPlayerAlias Property SpankPlayerAlias Auto
Quest Property MQ101 Auto

Event OnInit()
	If (MQ101.GetCurrentStageID() < 240)
		While (MQ101.GetCurrentStageID() < 240)
			Utility.Wait(5.0)
		EndWhile
		SpankPlayerAlias.BeginGameTimeUpdates()
		Debug.Notification("Spank that ass started")
	
	Else
		SpankPlayerAlias.BeginGameTimeUpdates()
		Debug.Notification("Spank that ass started")
	EndIf
	Self.Stop()
EndEvent
