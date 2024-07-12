Scriptname _MA_MainKicker extends Quest  

Event OnInit()
	While (MQ101.GetCurrentStageID() < 240)
		Utility.Wait(30)
	EndWhile
	Main.UpdateKicker()
EndEvent

Quest Property MQ101 Auto
_MA_Main Property Main Auto