Scriptname _SLS_CumAddictBathingTimer extends Quest  

Event OnInit()
	If (MQ101.GetCurrentStageID() >= 240)
		Util.ForbidBathing(PlayerRef, "Not just yet. I want to savour the feel of fresh cum on my skin")
		RegisterForSingleUpdateGameTime(Menu.CumAddictBatheRefuseTime)
	EndIf
EndEvent

Event OnUpdateGameTime()
	Util.PermitBathing(PlayerRef)
	Self.Stop()
EndEvent

Actor Property PlayerRef Auto

Quest Property MQ101 Auto

SLS_Utility Property Util Auto
SLS_Mcm Property Menu Auto
