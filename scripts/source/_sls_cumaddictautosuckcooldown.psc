Scriptname _SLS_CumAddictAutoSuckCooldown extends Quest  

Event OnInit()
	If Self.IsRunning()
		_SLS_CumAddictAutoSuckCreatureQuest.Stop()
		If (MQ101.GetCurrentStageID() >= 240)
			RegisterForSingleUpdateGameTime(Menu.CumAddictAutoSuckCooldown)
		Else
			Self.Stop()
		EndIf
	EndIf
EndEvent

Event OnUpdateGameTime()
	If Init.SlsCreatureEvents && CumAddict.GetHungerState() >= Menu.CumHungerAutoSuck
		_SLS_CumAddictAutoSuckCreatureQuest.Start()
	EndIf
	Self.Stop()
EndEvent

Quest Property MQ101 Auto
Quest Property _SLS_CumAddictAutoSuckCreatureQuest Auto

SLS_Mcm Property Menu Auto
SLS_Init Property Init Auto
_SLS_CumAddict Property CumAddict Auto
