Scriptname _SLS_InterfaceEatSleepDrink extends Quest

Event OnInit()
	RegisterForModEvent("_SLS_Int_PlayerLoadsGame", "On_SLS_Int_PlayerLoadsGame")
EndEvent

Event On_SLS_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
	PlayerLoadsGame()
EndEvent

Function PlayerLoadsGame()
	If Game.GetModByName("EatingSleepingDrinking.esp") != 255
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

Event OnEndState()
	Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet.

	knnQuest = Game.GetFormFromFile(0x001D8f, "EatingSleepingDrinking.esp") as Quest
EndEvent


; Empty state ==================================================
Bool Function IsNeedsModActive()
	Return false
EndFunction

Function Eat(Float FoodPoints)
EndFunction

Function Drink(Float WaterPoints)
EndFunction

Function ModFatigue(Float SleepAmount)
EndFunction

Function ModFatigueDesiredEffect(MagicEffect DesiredEffect)
EndFunction

Bool Function IsDesperate()
	Return false
EndFunction

Bool Function GetBegIsHungry()
	Return false
EndFunction

Bool Function GetBegIsThirsty()
	Return false
EndFunction

Float Function GetBellyScale()
	Return 1.0
EndFunction

Float Function GetLastHungerUpdateTime()
	Return 0.0
EndFunction

Float Function GetFatigue()
	Return 0.0
EndFunction

String Function GetConditionsStatement(Float SleepPenalty)
	Return ""
EndFunction

Function CorrectFatigue(Float SleepPenalty, Float StartingFatigue, Float HoursSlept)
EndFunction

Float Function GetHungerSleepPenalty()
	Return 0.0
EndFunction

Float Function GetThirstSleepPenalty()
	Return 0.0
EndFunction

String Function GetAioHunger()
	Return ""
EndFunction

String Function GetAioThirst()
	Return ""
EndFunction

String Function GetAioFatigue()
	Return ""
EndFunction

; =============================================================


; Installed state ==================================================
State Installed

	; Foreign function calls =============================
	Bool Function IsNeedsModActive()
		Return _SLS_IntEsd.IsNeedsModActive(knnQuest)
	EndFunction

	Function Eat(Float FoodPoints)
		_SLS_IntEsd.Eat(FoodPoints)
	EndFunction

	Function Drink(Float WaterPoints)
        _SLS_IntEsd.Drink(WaterPoints)
	EndFunction

	Function ModFatigue(Float SleepAmount)
		_SLS_IntEsd.ModFatigue(-1.0 * (SleepAmount))
	EndFunction
		
	Float Function GetFatigue()
		Return _SLS_IntEsd.GetFatigue()
	EndFunction

	Bool Function IsDesperate()
		Return _SLS_IntEsd.GetHunger() <= -1440.0 || _SLS_IntEsd.GetThirst() <= -1440.0
	EndFunction

	Bool Function GetBegIsHungry()
        Return _SLS_IntEsd.GetHunger() <= 0.0
	EndFunction

	Bool Function GetBegIsThirsty()
        Return _SLS_IntEsd.GetThirst() <= 0.0
	EndFunction

	Function CorrectFatigue(Float SleepPenalty, Float StartingFatigue, Float HoursSlept)
		Float TargetFatigue = 1680.0 - ((SleepPenalty * 1680.0) - 1.0)
		Float CurrentFatigue = GetFatigue()

		If CurrentFatigue > TargetFatigue
			ModFatigue(CurrentFatigue - TargetFatigue)
		EndIf
		;Debug.Messagebox("Fatigue (Current | Target): " + CurrentFatigue + " | " + TargetFatigue)
	EndFunction

	; No foreign function calls =========================
	String Function GetConditionsStatement(Float SleepPenalty)
		Float TargetFatigue = 1680.0 - (SleepPenalty * 1680.0) ; Reverse scale :s
		String ConditionString = "Maximum rest in these conditions is: "	
		If TargetFatigue >= 1680.0
			Return ConditionString + "Well rested"
		ElseIf TargetFatigue > 1440.0
			Return ConditionString + "Mild fatigue"
		ElseIf TargetFatigue > 0.0
			Return ConditionString + "Moderate fatigue"
		Else
			Return ConditionString + "Severe fatigue"
		EndIf
	EndFunction

	Float Function GetLastHungerUpdateTime()
		Return 0.0
	EndFunction

	Float Function GetHungerSleepPenalty()
		Float currentHunger = _SLS_IntEsd.GetHunger()
		currentHunger = PapyrusUtil.ClampFloat(currentHunger, 0.0, 2880.0)
		Return (0.35 * (2880.0 - currentHunger) / 2880.0) - 0.05

		;; breakpoint style
		;If currentHunger >= 2880.0 ; Satiated
		;	Return -0.05
		;ElseIf currentHunger >= 1440.0 ; Mild hunger
		;	Return 0.0
		;ElseIf currentHunger >= 0.0 ; Moderate hunger
		;	Return 0.15
		;Else ; Severe hunger
		;	Return 0.30
		;EndIf
	EndFunction

	Float Function GetThirstSleepPenalty()
		Float currentThirst = _SLS_IntEsd.GetThirst()
		currentThirst = PapyrusUtil.ClampFloat(currentThirst, 0.0, 2880.0)
		Return (0.35 * (2880.0 - currentThirst) / 2880.0) - 0.05
	EndFunction
	
	String Function GetAioHunger()
		Return ""
	EndFunction

	String Function GetAioThirst()
		Return ""
	EndFunction

	String Function GetAioFatigue()
		Return ""
	EndFunction
EndState

Quest knnQuest

Actor Property PlayerRef Auto

SLS_Mcm Property Menu Auto
