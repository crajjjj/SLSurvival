Scriptname _SLS_PickPocketFailDetect extends Quest  

Actor PickPocketee

Actor Property PlayerRef Auto

Faction Property CurrentFollowerFaction Auto

Int BlockedIndex = 0
Bool IsInScene = false

Event OnInit()
	RegisterForMenu("ContainerMenu")
EndEvent

Event OnMenuOpen(String MenuName)
	If PlayerRef.IsSneaking()
		Actor akTarget = Game.GetCurrentCrosshairRef() as Actor
		If akTarget as Actor
			If !akTarget.IsDead()
				If !akTarget.IsInFaction(CurrentFollowerFaction)
					;Debug.Messagebox("2 Name: " + akTarget.GetBaseObject().GetName() + "Pack: " + akTarget.GetCurrentPackage() + "\nScene: " + akTarget.GetCurrentScene())
					If !akTarget.isHostileToActor(PlayerRef) && akTarget.GetCurrentScene() == None ; Don't start if actor is in a scene. Scene packages take priority over quest alias packages even at 100 priority
						PickPocketee = akTarget
						GoToState("Monitor")
					EndIf
				EndIf
			EndIf
		EndIf
	EndIf
EndEvent

Event OnMenuClose(String MenuName)
EndEvent

State Monitor
	Event OnMenuClose(String MenuName)
		Utility.Wait(0.2)
		;Bool WasCaught = false
		If PickPocketee.isHostileToActor(PlayerRef)
			;WasCaught = true
			;PickPocketee.AddToFaction(_SLS_PickPocketFailFaction)
			_SLS_PickPocketFailFgQuest.Start()
			FgAlias.ForceRefTo(PickPocketee)
			PickPocketee.EvaluatePackage()
			_SLS_PickPocketFailCalmQuest.Stop()
			_SLS_PickPocketFailCalmQuest.Start()
			PlayerRef.StopCombatAlarm()
			Utility.Wait(0.2)
			;Debug.Messagebox("2 Name: " + PickPocketee.GetBaseObject().GetName() + "Pack: " + PickPocketee.GetCurrentPackage() + "\nScene: " + PickPocketee.GetCurrentScene())
			_SLS_PickPocketFailCalmOthersQuest.Stop()
			_SLS_PickPocketFailCalmOthersQuest.Start()
			GoToState("")
			
			TollDodge.BuildSellList()
			AssignBlocking()
		EndIf

		; Double check that shit is not 'going down'
		Utility.Wait(1.0)
		If PickPocketee.IsInCombat()
			;Debug.Messagebox("Still in combat")
			(_SLS_PickPocketFailCalmQuest.GetNthAlias(0) as ReferenceAlias).ForceRefTo(PickPocketee)
			_SLS_PickPocketFailCalmOthersQuest.Stop()
			_SLS_PickPocketFailCalmOthersQuest.Start()
			PickPocketee.StopCombat()
			PickPocketee.StopCombatAlarm()
		
		;Else
			;Debug.Messagebox("Else")
		EndIf
		
		;If WasCaught
			
			
		;EndIf
	EndEvent
EndState

Function EndPickpocketFailFg(Actor akTarget)
	;akTarget.RemoveFromFaction(_SLS_PickPocketFailFaction)
	FgAlias.Clear()
	_SLS_PickPocketFailFgQuest.Stop()
	akTarget.EvaluatePackage()
EndFunction

Function AssignBlocking()
	ReferenceAlias AliasSelect = _SLS_PickPocketFailBlockQuest.GetNthAlias(BlockedIndex) as ReferenceAlias
	If AliasSelect.GetReference() != None
		(AliasSelect as _SLS_PickpocketFailBlock).StopBlock()
	EndIf
	AliasSelect.ForceRefTo(PickPocketee)
	(AliasSelect as _SLS_PickpocketFailBlock).BeginBlock()
	BlockedIndex += 1
	If BlockedIndex >= _SLS_PickPocketFailBlockQuest.GetNumAliases()
		BlockedIndex = 0
	EndIf
EndFunction

;Faction Property _SLS_PickPocketFailFaction Auto

ReferenceAlias Property FgAlias Auto

Quest Property _SLS_PickPocketFailCalmQuest Auto
Quest Property _SLS_PickPocketFailCalmOthersQuest Auto
Quest Property _SLS_PickPocketFailFgQuest Auto
Quest Property _SLS_PickPocketFailBlockQuest Auto

_SLS_TollDodge Property TollDodge Auto
