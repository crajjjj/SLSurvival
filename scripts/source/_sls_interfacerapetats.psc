Scriptname _SLS_InterfaceRapeTats extends Quest  

Quest TatsQuest

Event OnInit()
	RegisterForModEvent("_SLS_Int_PlayerLoadsGame", "On_SLS_Int_PlayerLoadsGame")
EndEvent

Event On_SLS_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
	PlayerLoadsGame()
EndEvent

Function PlayerLoadsGame()
	If Game.GetModByName("RapeTattoos.esp") != 255
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
	TatsQuest = Game.GetFormFromFile(0x000D62,"RapeTattoos.esp") as Quest
EndEvent

Bool Function GetIsInterfaceActive()
	If GetState() == "Installed"
		Return true
	EndIf
	Return false
EndFunction

State Installed
	Function AddRapeTat(Actor akTarget)
		_SLS_IntRapeTats.AddRapeTat(TatsQuest, akTarget)
	EndFunction
EndState

Function AddRapeTat(Actor akTarget)
EndFunction
