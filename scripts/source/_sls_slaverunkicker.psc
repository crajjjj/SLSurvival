Scriptname _SLS_SlaverunKicker extends Quest  

_SLS_InterfaceSlaverun Property Slaverun Auto
SLS_Mcm Property Menu Auto

Event OnInit()
	If Slaverun.GetIsInterfaceActive()
		If Slaverun.IsFreeTownWhiterun()
			If Self.IsRunning()
				RegisterForSingleUpdateGameTime((Utility.RandomInt(Menu.SlaverunAutoMin as Int, Menu.SlaverunAutoMax as Int) * 24.0))
				If Menu.SlaverunAutoMin == Menu.SlaverunAutoMax && Menu.SlaverunAutoMin != 0.0
					Debug.Notification("Slaverun starting in " + Menu.SlaverunAutoMin + " days.")
				Else
					Debug.Notification("Slaverun starting in " + Menu.SlaverunAutoMin + " - " + Menu.SlaverunAutoMax + " days.")
				EndIf
			EndIf
		Else
			Debug.Trace("_SLS_: Whiterun already enslaved")
		EndIf
	EndIf
EndEvent

Event OnUpdateGameTime()
	If Slaverun.GetIsInterfaceActive()
		If Slaverun.IsFreeTownWhiterun()
			Slaverun.BeginSlaverun()		
		EndIf
	EndIf
	Self.Stop()
EndEvent
