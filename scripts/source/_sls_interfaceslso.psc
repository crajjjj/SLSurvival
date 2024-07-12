Scriptname _SLS_InterfaceSlso extends Quest

Event OnInit()
	RegisterForModEvent("_SLS_Int_PlayerLoadsGame", "On_SLS_Int_PlayerLoadsGame")
EndEvent

Event On_SLS_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
	PlayerLoadsGame()
EndEvent

Function PlayerLoadsGame()
	If Game.GetModByName("SLSO.esp") != 255
		If GetState() != "Installed"
			Ahegao.RegForEvents()
			GoToState("Installed")
		EndIf
	
	Else
		If GetState() != ""
			Ahegao.RegForEvents()
			GoToState("")
		EndIf
	EndIf
EndFunction

Event OnEndState()
	Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet.
EndEvent

Bool Function GetIsInterfaceActive()
	If GetState() == "Installed"
		Return true
	EndIf
	Return false
EndFunction

State Installed
	Int Function GetEnjoyment(Int tid, Actor akTarget)
		Return _SLS_IntSlso.GetEnjoyment(Sexlab, tid, akTarget)
	EndFunction
	
	Function ModEnjoyment(Int tid, Actor akTarget, Int Enjoyment)
		_SLS_IntSlso.ModEnjoyment(Sexlab, tid, akTarget, Enjoyment) 
	EndFunction
	
	Function Orgasm(Int tid, Actor akTarget, bool Force = true)
		_SLS_IntSlso.Orgasm(Sexlab, tid, akTarget, Force)
	EndFunction
EndState

Int Function GetEnjoyment(Int tid, Actor akTarget)
	Return 0
EndFunction

Function ModEnjoyment(Int tid, Actor akTarget, Int Enjoyment)
EndFunction

Function Orgasm(Int tid, Actor akTarget, bool Force = true)
EndFunction

_SLS_Ahegao Property Ahegao Auto
SexlabFramework Property Sexlab Auto
