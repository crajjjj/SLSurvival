Scriptname _SLS_InterfaceIneed extends Quest

Event OnInit()
	RegisterForModEvent("_SLS_Int_PlayerLoadsGame", "On_SLS_Int_PlayerLoadsGame")
EndEvent

Event On_SLS_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
	PlayerLoadsGame()
EndEvent

Function PlayerLoadsGame()
	If Game.GetModByName("iNeed.esp") != 255
		If GetState() != "Installed"
			GoToState("Installed")
		EndIf
		
	Else
		If GetState() != ""
			GoToState("")
		EndIf
	EndIf
	;RegisterForKey(21)
EndFunction
;/
Event OnKeyDown(Int KeyCode)
	Debug.Messagebox("FatigueBeforeModding: " + GetFatigue())
EndEvent
/;
Bool Function GetIsInterfaceActive()
	If GetState() == "Installed"
		Return true
	EndIf
	Return false
EndFunction

Event OnEndState()
	Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet.
	
	SnQuest = Game.GetFormFromFile(0x000D62, "iNeed.esp") as Quest
	
	_SNBuffHungerFX = Game.GetFormFromFile(0x004E65, "iNeed.esp") as MagicEffect ; Satiated
	_SNDmgHungerFX_1 = Game.GetFormFromFile(0x0012D8, "iNeed.esp") as MagicEffect ; Mild hunger
	_SNDmgHungerFX_2 = Game.GetFormFromFile(0x0012D9, "iNeed.esp") as MagicEffect ; Moderate hunger
	_SNDmgHungerFX_3 = Game.GetFormFromFile(0x0012DA, "iNeed.esp") as MagicEffect ; Severe hunger
	
	_SNBuffThirstFX = Game.GetFormFromFile(0x004E68, "iNeed.esp") as MagicEffect ; Well hydrated
	_SNDmgThirstFX_1 = Game.GetFormFromFile(0x0048F8, "iNeed.esp") as MagicEffect ; Mild thirst
	_SNDmgThirstFX_2 = Game.GetFormFromFile(0x0048F9, "iNeed.esp") as MagicEffect ; Moderate thirst
	_SNDmgThirstFX_3 = Game.GetFormFromFile(0x0048FA, "iNeed.esp") as MagicEffect ; Severe thirst

	_SNDmgFatigueFX_1 = Game.GetFormFromFile(0x0012D5, "iNeed.esp") as MagicEffect ; Mild fatigue
	_SNDmgFatigueFX_2 = Game.GetFormFromFile(0x0012D6, "iNeed.esp") as MagicEffect ; Moderate fatigue
	_SNDmgFatigueFX_3  = Game.GetFormFromFile(0x0012D7, "iNeed.esp") as MagicEffect ; Severe fatigue
EndEvent


; Installed state ==================================================
State Installed

	; Foreign function calls =============================
	Bool Function IsNeedsModActive()
		Return _SLS_IntIneed.IsNeedsModActive(SnQuest)
	EndFunction

	Function Eat(Float FoodPoints)
		;Debug.MessageBox("Ate: " + FoodPoints + " points")
		_SLS_IntIneed.Eat(FoodPoints, SnQuest)
	EndFunction

	Function Drink(Float WaterPoints)
		_SLS_IntIneed.Drink(WaterPoints, SnQuest)
	EndFunction

	Function ModFatigue(Float SleepAmount) ; -SleepAmount = Remove Fatigue. +SleepAmount = Add Fatigue
		_SLS_IntIneed.ModFatigue(-(SleepAmount), SnQuest)
	EndFunction
	
	Float Function GetLastHungerUpdateTime()
		Return _SLS_IntIneed.GetLastHungerUpdateTime(SnQuest)
	EndFunction
	
	Float Function GetFatigue()
		;Return _SLS_IntIneed.GetFatigue(SnQuest)
		Float FatigueTotal = _SLS_IntIneed.GetFatigue(SnQuest)
		If PlayerRef.HasMagicEffect(_SNDmgFatigueFX_3)
			;Debug.MessageBox("Severe fatigued")
			Return FatigueTotal
		ElseIf PlayerRef.HasMagicEffect(_SNDmgFatigueFX_2)
			;Debug.MessageBox("Moderately fatigued")
			Return FatigueTotal + 110.0
		ElseIf PlayerRef.HasMagicEffect(_SNDmgFatigueFX_1)
			;Debug.MessageBox("Mild fatigued")
			Return FatigueTotal + 220.0
		Else
			;Debug.MessageBox("ELSE")
			Return FatigueTotal + 330.0
		EndIf
	EndFunction

	; No foreign function calls =========================
	Function ModFatigueDesiredEffect(MagicEffect DesiredEffect)
		ModFatigue(1000.0) ; remove all fatigue
		Int Timeout = 10
		While !PlayerRef.HasMagicEffect(DesiredEffect) && Timeout > 0
			ModFatigue(-1000.0)
			Timeout -= 1
		EndWhile
	EndFunction

	Bool Function IsDesperate()
		If PlayerRef.HasMagicEffect(_SNDmgHungerFX_3) || PlayerRef.HasMagicEffect(_SNDmgThirstFX_3)
			Return true
		EndIf
		Return false
	EndFunction

	Bool Function GetBegIsHungry()
		If PlayerRef.HasMagicEffect(_SNDmgHungerFX_2) || PlayerRef.HasMagicEffect(_SNDmgHungerFX_3)
			Return true
		EndIf
		Return false
	EndFunction

	Bool Function GetBegIsThirsty()
		If PlayerRef.HasMagicEffect(_SNDmgThirstFX_2) || PlayerRef.HasMagicEffect(_SNDmgThirstFX_3)
			Return true
		EndIf
		Return false
	EndFunction

	Float Function GetBellyScale()
		If PlayerRef.HasMagicEffect(_SNBuffHungerFX) ; Satiated
			Return BellyScaleIneed00
		ElseIf PlayerRef.HasMagicEffect(_SNDmgHungerFX_1) ; Mild hunger
			Return BellyScaleIneed01
		ElseIf PlayerRef.HasMagicEffect(_SNDmgHungerFX_2) ; Moderate hunger
			Return BellyScaleIneed02
		ElseIf PlayerRef.HasMagicEffect(_SNDmgHungerFX_3) ; Severe hunger
			Return BellyScaleIneed03
		Else
			Return -1.0 ; magic effect is currently being swapped out - wait
		EndIf
	EndFunction

	String Function GetConditionsStatement(Float SleepPenalty)
		Float TargetFatigue = 440.0 - (SleepPenalty * 440.0) ; Reverse scale :s
		String ConditionString = "Maximum rest in these conditions is: "	
		If TargetFatigue > 330.0
			Return ConditionString + "Well rested"
		ElseIf TargetFatigue > 220.0
			Return ConditionString + "Mild fatigue"
		ElseIf TargetFatigue > 110.0
			Return ConditionString + "Moderate fatigue"
		Else
			Return ConditionString + "Severe fatigue"
		EndIf
	EndFunction

	Function CorrectFatigue(Float SleepPenalty, Float StartingFatigue, Float HoursSlept)
		; Express iNeed (an aspirin) as a full linear scale
		; Convert iNeed to a range of 0.0 - 110.0. With 4 levels, rested - severe fatigue
		; 4 * 110.0 = 0.0 - 440.0.
		; 0.0 = dead. 440.0 = totally rested
		
		; Determine new fatigue based on SleepPenalty, StartingFatigue and HoursSlept
		Float TargetFatigue = 440.0 - ((SleepPenalty * 440.0) - 1.0) ; Reverse scale :s -1.0 cuz there's a rounding error somewhere but I'm sick of looking at this.
		;Float Delta = GetFatigue() - TargetFatigue
		;Float ThisNapFatigue = (Delta / 8.0) * HoursSlept ; 8 hours of sleeping to reach target fatigue
		
		; Determine if sleep has been affected
		;Float CurrentFatigue = GetFatigue()
		
		Float CurrentFatigue = GetFatigue()
		If CurrentFatigue > TargetFatigue
			If TargetFatigue <= 110.0
				ModFatigueDesiredEffect(_SNDmgFatigueFX_3)
			ElseIf TargetFatigue <= 220.0
				ModFatigueDesiredEffect(_SNDmgFatigueFX_2)
			ElseIf TargetFatigue <= 330.0
				ModFatigueDesiredEffect(_SNDmgFatigueFX_1)
			EndIf
			
		Else
			HoursSleptAtFatigueZero = 0.0
		EndIf
		
		
		;/
		Float CurrentFatigue = GetFatigue()
		Debug.Messagebox("SleepPenalty: " + SleepPenalty + ". TargetFatigue: " + TargetFatigue + "CurrentFatigue: " + CurrentFatigue)
		If StartingFatigue < TargetFatigue ; Player was more tired when sleep began - cap rest gained
			If CurrentFatigue > TargetFatigue 
				Float Delta = (TargetFatigue) - CurrentFatigue
				Debug.Messagebox("Delta: " + Delta)
				ModFatigue(Delta)
			;Else	; Else player is still more tired than the cap - Do nothing
			EndIf

		; Just cap fatigue because iNeeds recovery system is horseshit. 1 hour sleep = a bit fatigued.
		Else ; Player was less tired when sleep began - slowly decrease rest to target
			
			;Float Delta = (CurrentFatigue - (TargetFatigue + (CurrentFatigue + StartingFatigue))); + StartingFatigue)
			
			Float Delta = StartingFatigue - TargetFatigue
			
			; rest is declining - Jump to last starting fatigue = (CurrentFatigue - StartingFatigue)
			Float ThisNapFatigue = -((CurrentFatigue - StartingFatigue) + (Delta / 8.0) * HoursSlept) ; 8 hours of sleeping to reach target fatigue
			Debug.MessageBox("ThisNapFatigue: " + ThisNapFatigue)
			ModFatigue(ThisNapFatigue as Int)
		EndIf
		/;	
	EndFunction

	Float Function GetHungerSleepPenalty()
		If PlayerRef.HasMagicEffect(_SNBuffHungerFX) ; Satiated
			Return JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "hunger_ineed_satiated") ; -0.05
		ElseIf PlayerRef.HasMagicEffect(_SNDmgHungerFX_1) ; Mild hunger
			Return JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "hunger_ineed_mildhunger") ; 0.0
		ElseIf PlayerRef.HasMagicEffect(_SNDmgHungerFX_2) ; Moderate hunger
			Return JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "hunger_ineed_moderatehunger") ; 0.15
		ElseIf PlayerRef.HasMagicEffect(_SNDmgHungerFX_3) ; Severe hunger
			Return JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "hunger_ineed_severehunger") ; 0.30
		Else
			Return 0.0
		EndIf
	EndFunction

	Float Function GetThirstSleepPenalty()
		If PlayerRef.HasMagicEffect(_SNBuffThirstFX) ; Well hydrated
			Return JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "thirst_ineed_wellhydrated") ; -0.05
		ElseIf PlayerRef.HasMagicEffect(_SNDmgThirstFX_1) ; Mild thirst
			Return JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "thirst_ineed_mildthirst") ; 0.0
		ElseIf PlayerRef.HasMagicEffect(_SNDmgThirstFX_2) ; Moderate thirst
			Return JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "thirst_ineed_moderatethirst") ; 0.15
		ElseIf PlayerRef.HasMagicEffect(_SNDmgThirstFX_3) ; Severe thirst
			Return JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "thirst_ineed_severethirst") ; 0.30
		Else
			Return 0.0
		EndIf
	EndFunction
	
	String Function GetAioHunger()
		If PlayerRef.HasMagicEffect(_SNBuffHungerFX) ; Satiated
			Return "Satiated"
		ElseIf PlayerRef.HasMagicEffect(_SNDmgHungerFX_1) ; Mild hunger
			Return "Mild hunger"
		ElseIf PlayerRef.HasMagicEffect(_SNDmgHungerFX_2) ; Moderate hunger
			Return "Moderate hunger"
		ElseIf PlayerRef.HasMagicEffect(_SNDmgHungerFX_3) ; Severe hunger
			Return "Severe hunger"
		EndIf
	EndFunction

	String Function GetAioThirst()
		If PlayerRef.HasMagicEffect(_SNBuffThirstFX) ; Well hydrated
			Return "Well hydrated"
		ElseIf PlayerRef.HasMagicEffect(_SNDmgThirstFX_1) ; Mild thirst
			Return "Mild thirst"
		ElseIf PlayerRef.HasMagicEffect(_SNDmgThirstFX_2) ; Moderate thirst
			Return "Moderate thirst"
		ElseIf PlayerRef.HasMagicEffect(_SNDmgThirstFX_3) ; Severe thirst
			Return "Severe thirst"
		Else
			Return "hydrated"
		EndIf
	EndFunction

	String Function GetAioFatigue()
		If PlayerRef.HasMagicEffect(_SNDmgFatigueFX_3)
			Return "Severe fatigue"
		ElseIf PlayerRef.HasMagicEffect(_SNDmgFatigueFX_2)
			Return "Moderate fatigue"
		ElseIf PlayerRef.HasMagicEffect(_SNDmgFatigueFX_1)
			Return "Mild fatigue"
		Else
			Return "Rested"
		EndIf
	EndFunction
EndState

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

Quest SnQuest

Float HoursSleptAtFatigueZero = 0.0

Float Property BellyScaleIneed00 = 0.9 Auto Hidden
Float Property BellyScaleIneed01 = 0.6 Auto Hidden
Float Property BellyScaleIneed02 = 0.3 Auto Hidden
Float Property BellyScaleIneed03 = 0.0 Auto Hidden

MagicEffect Property _SNBuffHungerFX Auto Hidden ; Satiated
MagicEffect Property _SNDmgHungerFX_1 Auto Hidden ; Mild Hunger
MagicEffect Property _SNDmgHungerFX_2 Auto Hidden ; Moderate Hunger
MagicEffect Property _SNDmgHungerFX_3 Auto Hidden ; Severe Hunger

MagicEffect Property _SNDmgFatigueFX_1 Auto Hidden ; Mild fatigue
MagicEffect Property _SNDmgFatigueFX_2 Auto Hidden ; Moderate fatigue
MagicEffect Property _SNDmgFatigueFX_3 Auto Hidden ; Severe fatigue

MagicEffect Property _SNBuffThirstFX Auto Hidden ; Well Hydrated
MagicEffect Property _SNDmgThirstFX_1 Auto Hidden ; Mild Thirst
MagicEffect Property _SNDmgThirstFX_2 Auto Hidden ; Moderate Thirst
MagicEffect Property _SNDmgThirstFX_3 Auto Hidden ; Severe Thirst

Actor Property PlayerRef Auto

SLS_Mcm Property Menu Auto
