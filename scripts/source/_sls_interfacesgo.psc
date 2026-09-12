Scriptname _SLS_InterfaceSgo extends Quest  

; Soulgem Oven IV - Insemination Fantasies. SGO4IF's own scripts resolve their forms with
; Game.GetFormFromFile(0x821,"SGO4IF.esp"), so the hardcoded FormIDs below are no more
; fragile than the mod itself - an ESL-flagged SGO4IF would break SGO4IF before it broke us.
String Property SgoPlugin = "SGO4IF.esp" AutoReadOnly Hidden

Faction FactionPregnantPercent
Faction FactionMilkPercent
Faction FactionIsLactating
Faction FactionIncubationType
Faction FactionProduceGems
Faction FactionProduceMilk

Event OnInit()
	RegisterForModEvent("_SLS_Int_PlayerLoadsGame", "On_SLS_Int_PlayerLoadsGame")
EndEvent

Event On_SLS_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
	PlayerLoadsGame()
EndEvent

Function PlayerLoadsGame()
	If Game.GetModByName(SgoPlugin) != 255
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
	FactionPregnantPercent = Game.GetFormFromFile(0x00081D, SgoPlugin) as Faction
	FactionIsLactating = Game.GetFormFromFile(0x000820, SgoPlugin) as Faction
	FactionProduceGems = Game.GetFormFromFile(0x000871, SgoPlugin) as Faction
	FactionProduceMilk = Game.GetFormFromFile(0x000872, SgoPlugin) as Faction
	FactionIncubationType = Game.GetFormFromFile(0x000A46, SgoPlugin) as Faction
	FactionMilkPercent = Game.GetFormFromFile(0x000A4C, SgoPlugin) as Faction
EndEvent

Bool Function GetIsInterfaceActive()
	If GetState() == "Installed"
		Return true
	EndIf
	Return false
EndFunction

State Installed
	Float Function GetPregnancyPercent(Actor akTarget)
		Return _SLS_IntSgo.GetPercent(FactionPregnantPercent, akTarget)
	EndFunction
	
	Bool Function GetIsPregnant(Actor akTarget)
		Return _SLS_IntSgo.GetEnum(FactionIncubationType, akTarget) > 0
	EndFunction
	
	Int Function GetIncubationType(Actor akTarget)
		Return _SLS_IntSgo.GetEnum(FactionIncubationType, akTarget)
	EndFunction
	
	Float Function GetMilkPercent(Actor akTarget)
		Return _SLS_IntSgo.GetPercent(FactionMilkPercent, akTarget)
	EndFunction
	
	Bool Function GetIsLactating(Actor akTarget)
		Return _SLS_IntSgo.GetEnum(FactionIsLactating, akTarget) > 0
	EndFunction
	
	Bool Function GetProducesGems(Actor akTarget)
		Return _SLS_IntSgo.GetIsMember(FactionProduceGems, akTarget)
	EndFunction
	
	Bool Function GetProducesMilk(Actor akTarget)
		Return _SLS_IntSgo.GetIsMember(FactionProduceMilk, akTarget)
	EndFunction
EndState

Float Function GetPregnancyPercent(Actor akTarget)
	Return 0.0
EndFunction

Bool Function GetIsPregnant(Actor akTarget)
	Return false
EndFunction

Int Function GetIncubationType(Actor akTarget)
	Return 0
EndFunction

Float Function GetMilkPercent(Actor akTarget)
	Return 0.0
EndFunction

Bool Function GetIsLactating(Actor akTarget)
	Return false
EndFunction

Bool Function GetProducesGems(Actor akTarget)
	Return false
EndFunction

Bool Function GetProducesMilk(Actor akTarget)
	Return false
EndFunction
