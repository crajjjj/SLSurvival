Scriptname _SLS_SpankRandomPeriodic extends Quest  

Event OnInit()
	If Self.IsRunning()
		RegisterForModEvent("_STA_RandomRunUpAndSpankComplete", "On_STA_RandomRunUpAndSpankComplete")
		RegisterForSingleUpdate(0.0)
	EndIf
EndEvent

Event On_STA_RandomRunUpAndSpankComplete(string eventName, string strArg, float numArg, Form sender)
	;Debug.Messagebox("Complete")
	RegisterForSingleUpdate(0.1)
EndEvent

Event OnUpdate()
	Util.SendDoRandomSpankEvent(Timeout = 5.0, AllowNpcInFurniture = true)
	RegisterForSingleUpdate(5.5)
EndEvent

SLS_Utility Property Util Auto
