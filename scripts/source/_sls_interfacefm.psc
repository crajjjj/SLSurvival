Scriptname _SLS_InterfaceFm extends Quest  

Quest FmQuest

Event OnInit()
	RegisterForModEvent("_SLS_Int_PlayerLoadsGame", "On_SLS_Int_PlayerLoadsGame")
EndEvent

Event On_SLS_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
	PlayerLoadsGame()
EndEvent

Function PlayerLoadsGame()
	If Game.GetModByName("Fertility Mode.esm") != 255
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
	FmQuest = Game.GetFormFromFile(0x000D62,"Fertility Mode.esm") as Quest
EndEvent

Bool Function GetIsInterfaceActive()
	Return GetState() == "Installed"
EndFunction

State Installed
	Bool Function GetIsPregnant(Actor akActor)
		Return _SLS_IntFm.GetIsPregnant(FmQuest, akActor)
	EndFunction
	
	Bool Function GetGaveBirth(Actor akActor)
		Return _SLS_IntFm.GetGaveBirth(FmQuest, akActor)
	EndFunction
	
	Race Function GetPregnancyRace(Actor PregnantActor)
		Return _SLS_IntFm.GetPregnancyRace(FmQuest, PregnantActor)
	EndFunction
EndState

Bool Function GetIsPregnant(Actor akActor)
	Return false
EndFunction

Bool Function GetGaveBirth(Actor akActor)
	Return false
EndFunction

Race Function GetPregnancyRace(Actor PregnantActor)
	Return None
EndFunction
