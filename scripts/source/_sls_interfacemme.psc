Scriptname _SLS_InterfaceMme extends Quest  

Quest MmeMilkQuest

Event OnInit()
	RegisterForModEvent("_SLS_Int_PlayerLoadsGame", "On_SLS_Int_PlayerLoadsGame")
EndEvent

Event On_SLS_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
	PlayerLoadsGame()
EndEvent

Function PlayerLoadsGame()
	If Game.GetModByName("MilkModNEW.esp") != 255
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
	MmeMilkQuest = Game.GetFormFromFile(0x00E209,"MilkModNEW.esp") as Quest
EndEvent

Bool Function GetIsInterfaceActive()
	If GetState() == "Installed"
		Return true
	EndIf
	Return false
EndFunction

State Installed
	Function MilkPlayer()
		_SLS_IntMme.MilkPlayer(MmeMilkQuest)
	EndFunction
	
	Function RefreshBreastSize(Actor akActor)
		_SLS_IntMme.RefreshBreastSize(MmeMilkQuest, akActor)
	EndFunction
EndState

Function MilkPlayer()
EndFunction

Function RefreshBreastSize(Actor akActor)
EndFunction
