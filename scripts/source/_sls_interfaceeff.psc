Scriptname _SLS_InterfaceEff extends Quest  

Event OnInit()
	RegisterForModEvent("_SLS_Int_PlayerLoadsGame", "On_SLS_Int_PlayerLoadsGame")
EndEvent

Event On_SLS_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
	PlayerLoadsGame()
EndEvent

Function PlayerLoadsGame()
	If Game.GetModByName("EFFCore.esm") != 255
		If GetState() != "Installed"
			GoToState("Installed")
		EndIf
	
	Else
		If GetState() != ""
			GoToState("")
		EndIf
	EndIf
EndFunction

Bool Function GetIsInterfaceActive()
	If GetState() == "Installed"
		Return true
	EndIf
	Return false
EndFunction

Event OnEndState()
	Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet.
	
	EffQuest = Game.GetFormFromFile(0x000EFF, "EFFCore.esm") as Quest
EndEvent

State Installed
	ObjectReference Function GetEffInv(ObjectReference FollowerObjRef)
		Actor FollowerActor = FollowerObjRef as Actor
		If FollowerActor
			_SLS_IntEff.GetEffInv(FollowerActor, EffQuest)
			
		Else
			Return None
		EndIf
	EndFunction
	
	Function AddFollower(ObjectReference Follower)
		_SLS_IntEff.AddFollower(Follower, EffQuest)
	EndFunction
EndState

ObjectReference Function GetEffInv(ObjectReference FollowerObjRef)
	Return None
EndFunction

Function AddFollower(ObjectReference Follower)
EndFunction

Quest EffQuest
