Scriptname _SLS_DancePlayerSpecAlias extends ReferenceAlias  

Function BeginSpectating(Actor akActor)
	Spectator = akActor
	RegisterForSingleUpdate(1.0)
EndFunction

Event OnUpdate()
	If Spectator
		;String WTF = Spectator.GetLeveledActorBase().GetName()
		If Dance.IsEnjoyingPerf(Spectator)
			;WTF += "Enjoying: " + Dance.DanceLoveActions[Utility.RandomInt(0, Dance.DanceLoveActions.Length - 1)]
			GoToState(Dance.DanceLoveActions[Utility.RandomInt(0, Dance.DanceLoveActions.Length - 1)])
		Else;/If Dance.IsHatingPerf(Spectator)/;
			;WTF +=  ". Hating: " + Dance.DanceHateActions[Utility.RandomInt(0, Dance.DanceHateActions.Length - 1)]
			GoToState(Dance.DanceHateActions[Utility.RandomInt(0, Dance.DanceHateActions.Length - 1)])
		EndIf
		;Debug.Messagebox(WTF)
		DoSomething()
		Debug.Messagebox(Spectator.GetLeveledActorBase().GetName() + " - " + GetState() + "\n\n" + Dance.PrintActionFactionList(Spectator))
		RegisterForSingleUpdate(Utility.RandomFloat(4.0, 8.0))
	EndIf
EndEvent

Function DoSomething()
	;Debug.Messagebox(Spectator.GetLeveledActorBase().GetName() + " - " + GetState())
EndFunction

; Love
State LoveIdle
	Function DoSomething()
		Spectator.SetFactionRank(_SLS_DanceActionFaction, 10)
		If Spectator.GetCurrentPackage() != _SLS_DancePlayerCrowdHateIdlePack ; Don't evaulate package if the actor is already running the idle package. Causes twitching
			Spectator.EvaluatePackage()
		EndIf
	EndFunction
EndState

State Complement
	Function DoSomething()
		Spectator.SetFactionRank(_SLS_DanceActionFaction, 11)
		Spectator.EvaluatePackage()
	EndFunction
EndState

State WolfWhistle
	Function DoSomething()
		Spectator.SetFactionRank(_SLS_DanceActionFaction, 12)
		Spectator.EvaluatePackage()
	EndFunction
EndState

State Gold
	Function DoSomething()
		Spectator.SetFactionRank(_SLS_DanceActionFaction, 13)
		Spectator.EvaluatePackage()
	EndFunction
EndState
;/
State ThrowGold
	Function DoSomething()
		Spectator.SetFactionRank(_SLS_DanceActionFaction, 14)
		Spectator.EvaluatePackage()
	EndFunction
EndState
/;
; Hate
State HateIdle
	Function DoSomething()
		Spectator.SetFactionRank(_SLS_DanceActionFaction, 0)
		If Spectator.GetCurrentPackage() != _SLS_DancePlayerCrowdHateIdlePack ; Don't evaulate package if the actor is already running the idle package. Causes twitching
			Spectator.EvaluatePackage()
		EndIf
	EndFunction
EndState

State Booo
	Function DoSomething()
		Spectator.SetFactionRank(_SLS_DanceActionFaction, 1)
		Spectator.EvaluatePackage()
	EndFunction
EndState

State ThrowJunk
	Function DoSomething()
		Spectator.SetFactionRank(_SLS_DanceActionFaction, 2)
		Spectator.EvaluatePackage()
	EndFunction
EndState

State Mock
	Function DoSomething()
		Spectator.SetFactionRank(_SLS_DanceActionFaction, 3)
		Spectator.EvaluatePackage()
	EndFunction
EndState

State Laugh
	Function DoSomething()
		;Debug.Messagebox(Spectator.GetLeveledActorBase().GetName() + "\nLaugh")
		Spectator.SetFactionRank(_SLS_DanceActionFaction, 4)
		Spectator.EvaluatePackage()
	EndFunction
EndState

Actor Spectator

Package Property _SLS_DancePlayerCrowdHateIdlePack Auto
Package Property _SLS_DancePlayerCrowdLoveIdlePack Auto

_SLS_Dance Property Dance Auto

Faction Property _SLS_DanceActionFaction Auto
; Ranks
; 0 - Hate Idle, 1 - Booo, 2 - ThrowJunk, 3 - Mock, 4 - Laugh
; 10 - Love Idle, 11 - Complement, 12 - WolfWhistle, 13 - Gold, 14 - ThrowGold
