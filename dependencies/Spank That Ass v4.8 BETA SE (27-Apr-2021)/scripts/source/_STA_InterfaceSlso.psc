Scriptname _STA_InterfaceSlso extends Quest  

Quest Property SexLabQuestFramework Auto

Event OnInit()
	RegisterForModEvent("_STA_Int_PlayerLoadsGame", "On_STA_Int_PlayerLoadsGame")
	RegisterForSingleUpdate(15.0)
EndEvent

Event OnUpdate()
	PlayerLoadsGame()
EndEvent

Event On_STA_Int_PlayerLoadsGame()
	PlayerLoadsGame()
EndEvent

Function PlayerLoadsGame()
	If Game.GetModByName("SLSO.esp") != 255
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

; Installed =======================================

State Installed
	Function DoSpankModEnjoyment(Int CurrentTid, Actor akTarget, Int Enjoyment)
		;SexLab.GetController(CurrentTid).ActorAlias(akTarget).BonusEnjoyment(Ref = akTarget, experience = Enjoyment)
		_STA_IntSlso.DoSpankModEnjoyment(CurrentTid, akTarget, Enjoyment, SexLabQuestFramework)
	EndFunction
EndState

; Not Installed ====================================

Event OnEndState()
	Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet.
EndEvent

Function DoSpankModEnjoyment(Int CurrentTid, Actor akTarget, Int Enjoyment)
EndFunction
