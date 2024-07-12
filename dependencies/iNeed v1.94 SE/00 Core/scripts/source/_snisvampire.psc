Scriptname _SNIsVampire extends activemagiceffect 

_SNQuestScript Property _SNQuest Auto

Actor targ

Bool Property Vampire Auto
Bool Property WarmWater Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	targ = akTarget
	If Vampire
		GoToState("VampireHybrid")
	ElseIf WarmWater
		GoToState("WarmWater")
	Else
		GoToState("Wellness")
	EndIf
EndEvent

State VampireHybrid

	Event OnBeginState()
		_SNQuest.TimePassed = 0
		_SNQuest.ModThirst(100.0)
		_SNQuest.ModHunger(100.0)
	EndEvent

EndState

State WarmWater

	Event OnBeginState()
		_SNQuest.IsInWarmWater = True
	EndEvent
	
	Event OnEffectFinish(Actor akTarget, Actor akCaster)
		Utility.Wait(0.5)
		_SNQuest.IsInWarmWater = False
	EndEvent

EndState

State Wellness

	Event OnBeginState()
		RegisterForSingleUpdateGameTime(120.0)
	EndEvent
	
	Event OnUpdateGameTime()
		If _SNQuest.WellnessNeeds > 3
			_SNQuest._SNWellnessLevel.Mod(1)
		ElseIf _SNQuest.WellnessNeeds < 2
			_SNQuest._SNWellnessLevel.Mod(-1)
		EndIf
		If _SNQuest.VariedDietCount > 14
			_SNQuest._SNVariedDietLevel.Mod(1)
		ElseIf _SNQuest.VariedDietCount < 0
			_SNQuest._SNVariedDietLevel.Mod(-1)
		EndIf
		Int WellnessLevel = _SNQuest._SNWellnessLevel.GetValue() as Int
		Int VariedDietLevel = _SNQuest._SNVariedDietLevel.GetValue() as Int
		If WellnessLevel < 0
			_SNQuest._SNWellnessLevel.SetValue(0)
		ElseIf WellnessLevel > 20
			_SNQuest._SNWellnessLevel.SetValue(20)
		EndIf
		If VariedDietLevel < 0
			_SNQuest._SNVariedDietLevel.SetValue(0)
		ElseIf VariedDietLevel > 20
			_SNQuest._SNVariedDietLevel.SetValue(20)
		EndIf
		_SNQuest.WellnessNeeds = 5
		_SNQuest.VariedDietCount = 5
		RegisterForSingleUpdateGameTime(120.0)
	EndEvent
	
	Event OnEffectFinish(Actor akTarget, Actor akCaster)
		_SNQuest.WellnessNeeds = 5
		_SNQuest.VariedDietCount = 5
	EndEvent

EndState