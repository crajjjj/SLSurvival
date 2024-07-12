Scriptname _SLS_InterfaceSgo extends Quest  

Quest SgoQuest

Event OnInit()
	RegisterForModEvent("_SLS_Int_PlayerLoadsGame", "On_SLS_Int_PlayerLoadsGame")
EndEvent

Event On_SLS_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
	PlayerLoadsGame()
EndEvent

Function PlayerLoadsGame()
	If Game.GetModByName("dcc-soulgem-oven-000.esm") != 255
		If GetState() != "Installed"
			;GoToState("Installed")
			GoToState("")
		EndIf
	
	Else
		If GetState() != ""
			GoToState("")
		EndIf
	EndIf
EndFunction

Event OnEndState()
	Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet.
	SgoQuest = Game.GetFormFromFile(0x000D62,"dcc-soulgem-oven-000.esm") as Quest
EndEvent

Bool Function GetIsInterfaceActive()
	If GetState() == "Installed"
		Return true
	EndIf
	Return false
EndFunction

State Installed
	Int Function GetGemCapacityMax()
		Return _SLS_IntSgo.GetGemCapacityMax(SgoQuest)
	EndFunction
	
	Float Function ActorGemGetPercent(Actor akTarget)
		Return _SLS_IntSgo.ActorGemGetPercent(SgoQuest, akTarget)
	EndFunction
	
	Int Function ActorGemGetCount(Actor akTarget)
		Return _SLS_IntSgo.ActorGemGetCount(SgoQuest, akTarget)
	EndFunction
	
	Int Function GetMilkCapacity(Actor akTarget)
		Return _SLS_IntSgo.GetMilkCapacity(SgoQuest, akTarget)
	EndFunction
EndState

Int Function GetGemCapacityMax()
	Return 0
EndFunction

Float Function ActorGemGetPercent(Actor akTarget)
	Return 0.0
EndFunction

Int Function ActorGemGetCount(Actor akTarget)
	Return 0
EndFunction

Int Function GetMilkCapacity(Actor akTarget)
	Return 0
EndFunction
