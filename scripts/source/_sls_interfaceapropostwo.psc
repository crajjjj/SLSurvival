Scriptname _SLS_InterfaceAproposTwo extends Quest  

Event OnInit()
	RegisterForModEvent("_SLS_Int_PlayerLoadsGame", "On_SLS_Int_PlayerLoadsGame")
	RegisterForModEvent("_SLS_PlayerSwallowedCum", "On_SLS_PlayerSwallowedCum")
EndEvent

Event On_SLS_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
	PlayerLoadsGame()
EndEvent

Function PlayerLoadsGame()
	If Game.GetModByName("Apropos2.esp") != 255
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
	Event On_SLS_PlayerSwallowedCum(Form akSource, Bool Swallowed, Float LoadSize, Float LoadSizeBase, Bool IsCumPotion)
		If Swallowed && (LoadSize / LoadSizeBase) >= (Menu.CumEffectVolThres / 100.0)
			If akSource as Actor
				VoiceType CumVoice = (akSource as Actor).GetVoiceType()
				If CumVoice == CrTrollVoice
					RegisterForSingleUpdate(5.0)
				EndIf
			EndIf
		EndIf
	EndEvent

	Function HealAllHoles(Actor akTarget, Int HealAmount, Float IncArousal, Bool DoMoan)
		If AproposTwoAlias == None
			GetAproposAlias(akTarget)
		ElseIf AproposTwoAlias.GetReference() as Actor != akTarget
			GetAproposAlias(akTarget)
		EndIf
		
		If AproposTwoAlias && AproposTwoAlias.GetReference() as Actor == akTarget
			_SLS_IntAproposTwo.HealAllHoles(AproposTwoAlias, akTarget, HealAmount)
			If IncArousal > 0.0 && _SLS_IntAproposTwo.ConsumablesIncreaseArousal(AproposTwoAlias)
				UpdateActorArousalExposure(akTarget, IncArousal)
			EndIf
			If DoMoan
				sslBaseVoice voice = SexLab.PickVoice(akTarget)
				voice.Moan(akTarget, 10, False)
			EndIf
		EndIf
	EndFunction
	
	Function GetAproposAlias(Actor akTarget)
		; Search Apropos2 actor aliases as the player alias is not set in stone
		; Look up by editor ID, not a hardcoded FormID: Apropos2 is now shipped ESL-flagged, which
		; compacts FormIDs (0x02902C -> 0x1B), so Game.GetFormFromFile(0x02902C) returns None. The
		; editor ID is stable across the eslified/non-eslified "disparity". (See the Apropos ESL patch.)
		Quest AproposQuest = Quest.GetQuest("Apropos2Actors")
		AproposTwoAlias = None
		Int i = 0
		ReferenceAlias AliasSelect
		While i < AproposQuest.GetNumAliases() && AproposTwoAlias == None
			AliasSelect = AproposQuest.GetNthAlias(i) as ReferenceAlias
			If AliasSelect.GetReference() as Actor == akTarget
				AproposTwoAlias = AliasSelect
			EndIf
			i += 1
		EndWhile
	EndFunction
	
	String Function GetWearTear(Actor akActor)
		Return _SLS_IntAproposTwo.GetWearTear(ActorsQuest, akActor)
	EndFunction
	
	Event OnUpdate()
		HealAllHoles(PlayerRef, HealAmount = Menu.AproTwoTrollHealAmount, IncArousal = 0.0, DoMoan = false)
	EndEvent
EndState

; Not Installed ====================================

Event On_SLS_PlayerSwallowedCum(Form akSource, Bool Swallowed, Float LoadSize, Float LoadSizeBase, Bool IsCumPotion)
EndEvent

Event OnUpdate()
EndEvent

Function HealAllHoles(Actor akTarget, Int HealAmount, Float IncArousal, Bool DoMoan)
EndFunction

Function UpdateActorArousalExposure(Actor anActor, Float amount = 2.0)
	Int eid = ModEvent.Create("slaUpdateExposure")
	ModEvent.PushForm(eid, anActor)
	ModEvent.PushFloat(eid, amount)
	ModEvent.Send(eid)
EndFunction

Function GetAproposAlias(Actor akTarget)
EndFunction

String Function GetWearTear(Actor akActor)
	Return ""
EndFunction

Event OnEndState()
	Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet.
	ActorsQuest = Quest.GetQuest("Apropos2Actors") ; editor-ID lookup: survives Apropos2's ESL FormID compaction
EndEvent

Quest ActorsQuest

ReferenceAlias AproposTwoAlias

Actor Property PlayerRef Auto

VoiceType Property CrTrollVoice Auto

SexlabFramework Property Sexlab Auto
SLS_Mcm Property Menu Auto
