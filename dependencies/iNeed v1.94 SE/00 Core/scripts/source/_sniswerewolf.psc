Scriptname _SNIsWerewolf extends activemagiceffect  

;====================================================================================

Float CurrentFatigue

Bool Property WerewolfTransform Auto
Bool Property Adrenaline Auto
Bool Property Weary Auto

Actor targ

_SNQuestScript Property _SNQuest Auto

;====================================================================================

Event OnEffectStart(Actor akTarget, Actor akCaster)
	targ = akTarget
	If WerewolfTransform
		GoToState("WerewolfTransform")
	ElseIf Adrenaline
		GoToState("Adrenaline")
	ElseIf Weary
		GoToState("Weary")
	Else
		GoToState("Werewolf")
	EndIf
EndEvent

;====================================================================================

State WerewolfTransform

	Event OnBeginState()
		_SNQuest.IsWerewolf = True
		CurrentFatigue = _SNQuest.FatigueState
		_SNQuest.TimePassed = 0
		_SNQuest.ModFatigue(100.0)
		_SNQuest.ModHunger(0.0)
	EndEvent

	Event OnEffectFinish(Actor akTarget, Actor akCaster)
		_SNQuest.IsWerewolf = False
		_SNQuest.TimePassed = 0
		If CurrentFatigue > 30.0
			_SNQuest.FatigueState = CurrentFatigue - 30.0
		Else
			_SNQuest.FatigueState = CurrentFatigue - 0.0
		EndIf
		_SNQuest.ModHunger(0.0)
	EndEvent

EndState

State Werewolf

	Event OnBeginState()
		_SNQuest.IsWerewolfHuman = True
		_SNQuest.HarmfulRaw = False
		If _SNQuest.SKSEVersion > 0.0
			_SNQuest._SNSKConfigQuest.OnConfigInit()
		EndIf
	EndEvent

	Event OnEffectFinish(Actor akTarget, Actor akCaster)
		_SNQuest.IsWerewolfHuman = False
		_SNQuest.HarmfulRaw = True
		If _SNQuest.SKSEVersion > 0.0
			_SNQuest._SNSKConfigQuest.OnConfigInit()
		EndIf
	EndEvent

EndState

;====================================================================================

State Adrenaline

	Event OnBeginState()
		If !targ.HasSpell(_SNQuest._SNWearySpell) && (!targ.HasKeyword(_SNQuest.Vampire) || _SNQuest._SNVampWereToggle.GetValue() != 1)
			If _SNQuest.IsUnsafeLocation()
				_SNQuest.AdrenalineStart = Utility.GetCurrentGameTime()
				targ.AddSpell(_SNQuest._SNAdrenalineSpell, false)
			EndIf
		EndIf
	EndEvent
	
	Event OnUpdateGameTime()
		OnEffectFinish(targ, targ)
	EndEvent

	Event OnEffectFinish(Actor akTarget, Actor akCaster)
		_SNQuest.AdrenalineFinish = Utility.GetCurrentGameTime()
		If targ.HasSpell(_SNQuest._SNAdrenalineSpell) && ((_SNQuest.AdrenalineFinish - _SNQuest.AdrenalineStart) * 24.0) >= 2.0
			targ.AddSpell(_SNQuest._SNWearySpell, false)
		EndIf
		targ.RemoveSpell(_SNQuest._SNAdrenalineSpell)
	EndEvent

EndState

State Weary

	Event OnBeginState()
		_SNQuest.TimeInAdrenaline = (_SNQuest.AdrenalineFinish - _SNQuest.AdrenalineStart) * 24.0
		If _SNQuest.TimeInAdrenaline > 14.0
			_SNQuest.TimeInAdrenaline = 14.0
		EndIf
		RegisterForSingleUpdateGameTime(_SNQuest.TimeInAdrenaline / 2.0)
	EndEvent

	Event OnUpdateGameTime()
		Utility.Wait(3.0)
		targ.RemoveSpell(_SNQuest._SNWearySpell)
	EndEvent

EndState