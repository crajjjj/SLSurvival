Scriptname _SLS_InterfaceSpankThatAss extends Quest  

Event OnInit()
	RegisterForModEvent("_SLS_Int_PlayerLoadsGame", "On_SLS_Int_PlayerLoadsGame")
EndEvent

Event On_SLS_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
	PlayerLoadsGame()
EndEvent

Function PlayerLoadsGame()
	If Game.GetModByName("Spank That Ass.esp") != 255
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
	Int Function GetPlayerMasochismAttitude()
		Return _SLS_IntSta.GetPlayerMasochismAttitude(SpankQuest)
	EndFunction
	
	String Function GetMasochismAttitudeString()
		Return Attitudes[GetPlayerMasochismAttitude() + 2]
	EndFunction
	
	Float Function GetPlayerMasochism()
		Return _SLS_IntSta.GetPlayerMasochism(SpankQuest)
	EndFunction
	
	Float Function GetMasochismStepSize()
		Return _SLS_IntSta.GetMasochismStepSize(SpankQuest)
	EndFunction
	
	Function QueueComment(Topic WhatToSay, Bool PriorityComment, Bool ForcedGagComment = false)
		; This is a ridiculous way of gating dialogue from Npcs but the usual magic effect filtering method is not working from the outside...
		_SLS_StaDialogQuest.Start() 
		_SLS_IntSta.QueueComment(DialogQuest, WhatToSay, PriorityComment, ForcedGagComment)
		Utility.Wait(4.0) ; Wait too low (0.1) = line not spoken. Wait not long enough (3.0) = CTD....
		_SLS_StaDialogQuest.Stop()
		;PlayerRef.RemoveSpell(_SLS_DialogOutSpell)
	EndFunction
EndState

; Not Installed ====================================

Event OnEndState()
	Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet.
	SpankQuest = Game.GetFormFromFile(0x000D62, "Spank That Ass.esp") as Quest
	DialogQuest = Game.GetFormFromFile(0x004E23, "Spank That Ass.esp") as Quest
	
	Attitudes = new String[5]
	Attitudes[0] = "Hates"
	Attitudes[1] = "Dislikes"
	Attitudes[3] = "Likes"
	Attitudes[4] = "Loves"
EndEvent

Int Function GetPlayerMasochismAttitude()
	Return -2
EndFunction

Function QueueComment(Topic WhatToSay, Bool PriorityComment, Bool ForcedGagComment = false)
EndFunction

String Function GetMasochismAttitudeString()
	Return ""
EndFunction

Float Function GetPlayerMasochism()
	Return 0.0
EndFunction

Float Function GetMasochismStepSize()
	Return 1.0
EndFunction

String[] Attitudes

Quest SpankQuest
Quest DialogQuest

Quest Property _SLS_StaDialogQuest Auto

Actor Property PlayerRef Auto
