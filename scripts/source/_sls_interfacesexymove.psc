Scriptname _SLS_InterfaceSexyMove extends Quest  


Quest SmQuest

Event OnInit()
	RegisterForModEvent("_SLS_Int_PlayerLoadsGame", "On_SLS_Int_PlayerLoadsGame")
EndEvent

Event On_SLS_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
	PlayerLoadsGame()
EndEvent

Function PlayerLoadsGame()
	If Game.GetModByName("FNISSexyMove.esp") != 255
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
	SmQuest = Game.GetFormFromFile(0x0012C7, "FNISSexyMove.esp") as Quest
EndEvent

Bool Function GetIsInterfaceActive()
	If GetState() == "Installed"
		Return true
	EndIf
	Return false
EndFunction

State Installed
	Function ChangeAnimationSet(Int MenuSelect, Actor akTarget)
		_SLS_IntSexyMove.ChangeAnimationSet(SmQuest, MenuSelect, akTarget)
	EndFunction
EndState

Function ChangeAnimationSet(Int MenuSelect, Actor akTarget)
EndFunction
