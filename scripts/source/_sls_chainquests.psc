Scriptname _SLS_ChainQuests extends Quest  

Event OnInit()
	RegisterForModEvent("_SLS_Int_ChainQuests", "On_SLS_Int_ChainQuests")
	RegisterForModEvent("_SLS_Int_BeginGuardWarnPunishEvent", "On_SLS_Int_BeginGuardWarnPunishEvent")
EndEvent

Event On_SLS_Int_ChainQuests(Form QuestToStop, Form QuestToStart)
	; Stop QuestToStop and wait until stopped. Then start QuestToStart - Avoid alias factions getting removed because of timing

	Quest QuestToStopAsQuest = QuestToStop as Quest
	Quest QuestToStartAsQuest = QuestToStart as Quest
	
	If QuestToStopAsQuest
		While QuestToStopAsQuest.IsRunning()
			QuestToStopAsQuest.Stop()
			Utility.Wait(0.01)
		EndWhile
	EndIf
	
	QuestToStartAsQuest.Start()
EndEvent

Event On_SLS_Int_BeginGuardWarnPunishEvent(Form QuestToStop, Form Guard)
	; Stop QuestToStop and wait until stopped. Then start QuestToStart - Avoid alias factions getting removed because of timing

	Quest QuestToStopAsQuest = QuestToStop as Quest
	Actor GuardAsActor = Guard as Actor
	
	If QuestToStopAsQuest
		While QuestToStopAsQuest.IsRunning()
			QuestToStopAsQuest.Stop()
			Utility.Wait(0.2)
		EndWhile
	EndIf
	;Debug.Messagebox("_SLS_: " + QuestToStopAsQuest + " is stopped")
	Debug.Trace("_SLS_: " + QuestToStopAsQuest + " is stopped")

	If GuardAsActor
		GuardAsActor.AddToFaction(_SLS_GuardWarnApproachFact)
		_SLS_GuardWarnedQuest.Start()
		GuardWarnedAlias.ForceRefTo(GuardAsActor)
	EndIf
EndEvent

ReferenceAlias Property GuardWarnedAlias Auto

Faction Property _SLS_GuardWarnApproachFact Auto

Quest Property _SLS_GuardWarnedQuest Auto
