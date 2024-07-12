Scriptname _SLS_InterfacePaySexCrime extends Quest

Quest PscQuest

Event OnInit()
	RegisterForModEvent("_SLS_Int_PlayerLoadsGame", "On_SLS_Int_PlayerLoadsGame")
EndEvent

Event On_SLS_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
	PlayerLoadsGame()
EndEvent

Function PlayerLoadsGame()
	If Game.GetModByName("Sexlab_PaySexCrime.esp") != 255
		If GetState() != "Installed"
			GoToState("Installed")
		EndIf
	
	Else
		If GetState() != ""
			GoToState("")
		EndIf
	EndIf
EndFunction

Event OnEndState()
	Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet.
	PscQuest = Game.GetFormFromFile(0x002862,"Sexlab_PaySexCrime.esp") as Quest
EndEvent

Bool Function GetIsInterfaceActive()
	If GetState() == "Installed"
		Return true
	EndIf
	Return false
EndFunction

Int Function GetPscBountyWhiterun()
	Return 0
EndFunction

Int Function GetPscBountySolitude()
	Return 0
EndFunction

Int Function GetPscBountyMarkarth()
	Return 0
EndFunction

Int Function GetPscBountyWindhelm()
	Return 0
EndFunction

Int Function GetPscBountyRiften()
	Return 0
EndFunction

State Installed
	Int Function GetPscBountyWhiterun()
		Return _SLS_IntPsc.GetPscBountyWhiterun(PscQuest)
	EndFunction

	Int Function GetPscBountySolitude()
		Return _SLS_IntPsc.GetPscBountySolitude(PscQuest)
	EndFunction

	Int Function GetPscBountyMarkarth()
		Return _SLS_IntPsc.GetPscBountyMarkarth(PscQuest)
	EndFunction

	Int Function GetPscBountyWindhelm()
		Return _SLS_IntPsc.GetPscBountyWindhelm(PscQuest)
	EndFunction

	Int Function GetPscBountyRiften()
		Return _SLS_IntPsc.GetPscBountyRiften(PscQuest)
	EndFunction
EndState
