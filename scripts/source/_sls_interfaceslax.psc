Scriptname _SLS_InterfaceSlax extends Quest  

Int Property SlaVersion = -1 Auto Hidden

Quest SlaConfigQuest
Quest sla_FrameworkQuest
Quest sla_InternalQuest

Keyword Property SLA_HasStockings Auto Hidden
Keyword Property SlaBikiniKeyword Auto Hidden
Keyword Property _SLS_UnusedDummyKw Auto

Faction Property sla_Arousal Auto Hidden

Event OnInit()
	RegisterForModEvent("_SLS_Int_PlayerLoadsGame", "On_SLS_Int_PlayerLoadsGame")
EndEvent

Event On_SLS_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
	PlayerLoadsGame()
EndEvent

Function PlayerLoadsGame()
	If Game.GetModByName("SexLabAroused.esm") != 255
		If GetState() != "Installed"
			GoToState("Installed")
		EndIf
	
	Else
		If GetState() != ""
			GoToState("")
		EndIf
	EndIf
	If GetState() == "Installed"
		SlaVersion = GetVersion()
	Else
		SlaVersion = -1
	EndIf
EndFunction

Function RestartInterface()
	GoToState("")
	Utility.Wait(2.0)
	PlayerLoadsGame()
EndFunction

Event OnEndState()	
	Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet.
	SlaConfigQuest = Game.GetFormFromFile(0x01C6E0, "SexLabAroused.esm") as Quest
	sla_FrameworkQuest = Game.GetFormFromFile(0x04290F, "SexLabAroused.esm") as Quest
	sla_InternalQuest = Game.GetFormFromFile(0x083137, "SexLabAroused.esm") as Quest
	sla_Arousal = Game.GetFormFromFile(0x03FC36, "SexLabAroused.esm") as Faction
	If GetVersion() >= 29
		SlaBikiniKeyword = Game.GetFormFromFile(0x08E854, "SexLabAroused.esm") as Keyword
		SLA_HasStockings = Game.GetFormFromFile(0x08FEA3, "SexLabAroused.esm") as Keyword
	Else
		SlaBikiniKeyword = _SLS_UnusedDummyKw
		SLA_HasStockings = _SLS_UnusedDummyKw
	EndIf
EndEvent

Bool Function GetIsInterfaceActive()
	Return GetState() as Bool
	;/
	If GetState() == "Installed"
		Return true
	EndIf
	Return false
	/;
EndFunction

State Installed
	Int Function GetVersion()
		Return _SLS_IntSlax.GetVersion(SlaConfigQuest)
	EndFunction
	
	Bool Function WornHasBikiniKeyword(Actor akActor)
		If SlaVersion >= 29
			Return akActor.WornHasKeyword(SlaBikiniKeyword)
		EndIf
		Return false
	EndFunction
	
	Bool Function IsWearingStockings(Actor akActor)
		Return akActor.WornHasKeyword(SLA_HasStockings)
	EndFunction
	
	Int Function GetActorArousal(Actor who) ; Unused. Leaving here in case comes in handy later
		Return _SLS_IntSlax.GetActorArousal(sla_FrameworkQuest, who)
	EndFunction
	
	Int Function SetActorExposure(Actor who, Int newActorExposure)
		Return _SLS_IntSlax.SetActorExposure(sla_InternalQuest, who, newActorExposure)
	EndFunction
EndState

Int Function GetVersion()
	Return -1
EndFunction

Bool Function WornHasBikiniKeyword(Actor akActor)
	Return false
EndFunction

Bool Function IsWearingStockings(Actor akActor)
	Return false
EndFunction

Int Function GetActorArousal(Actor who) ; Unused. Leaving here in case comes in handy later
	Return 0
EndFunction

Int Function SetActorExposure(Actor who, Int newActorExposure)
	Return 0
EndFunction
