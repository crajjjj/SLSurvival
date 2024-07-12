Scriptname _SLS_Needs extends Quest Conditional

Bool Property BegIsHungry = false Auto Hidden Conditional
Bool Property BegIsThirsty = false Auto Hidden Conditional

Float Property LastSleepPenalty = -1.0 Auto Hidden
Float Property SaltyCum = 1.0 Auto Hidden
Float Property CumFoodMult = 1.0 Auto Hidden
Float Property CumDrinkMult = 1.0 Auto Hidden
Float Property BaseBellyScale = 1.0 Auto Hidden
Float Property CampingFatigue = 0.0 Auto Hidden

Float Property FatigueBeforeModding Auto Hidden

Keyword Property SexLabNoStrip Auto
Keyword Property Vampire Auto

Actor Property PlayerRef Auto

Faction Property PlayerBedOwnership Auto

GlobalVariable Property GameHour Auto

_SLS_InterfaceRnd Property Rnd Auto
_SLS_InterfaceIneed Property Ineed Auto
_SLS_InterfaceEatSleepDrink Property EatSleepDrink Auto
_SLS_InterfaceFrostfall Property FrostInterface Auto
_SLS_InterfaceDevious Property Devious Auto
_SLS_InterfaceSpankThatAss Property Sta Auto

Bool DoSleepDeprivMessage = true

Event OnInit()
	If Game.GetModByName("RealisticNeedsandDiseases.esp") != 255
		GoToState("Rnd")
	ElseIf Game.GetModByName("iNeed.esp") != 255
		GoToState("iNeed")
	ElseIf Game.GetModByName("EatingSleepingDrinking.esp") != 255
		GoToState("Esd")
	EndIf
	RegisterForMenu("Sleep/Wait Menu")
	RegisterForControl("Wait")
	;Debug.Messagebox("Needs state: " + Self.GetState())
EndEvent

Event OnControlDown(string control)
	DoSleepDeprivMessage = false
	Utility.WaitMenuMode(1.0)
	DoSleepDeprivMessage = true
EndEvent

Event OnMenuOpen(String MenuName)
	Utility.WaitMenuMode(0.1)
	If DoSleepDeprivMessage
		GetSleepPenalty(ShowConditions = true, IsSleeping = false)
	EndIf
EndEvent

Function ToggleSleepDepriv(Bool StartUp)
	If StartUp
		LastSleepPenalty = 0.0
		RegisterForMenu("Sleep/Wait Menu")
	Else
		LastSleepPenalty = -1.0
		UnRegisterForMenu("Sleep/Wait Menu")
	EndIf
EndFunction

Float Function GetSleepPenalty(Bool ShowConditions = false, Bool IsSleeping)
	Armor Cuirass = PlayerRef.GetWornForm(0x00000004) as Armor
	String Conditions
	Float SleepPenalty
	Float CampingFatigueCurrent = CampingFatigue
	Float CampingFatigueGain = 0.0
	Float ValTemp
	
	; Armor
	If Cuirass
		;Debug.Messagebox(Cuirass + ". Class: " + Cuirass.GetWeightClass())
		If StorageUtil.GetIntValue(Cuirass, "SLAroused.IsNakedArmor", 0) == 1 || Cuirass.HasKeyword(SexLabNoStrip)
			ValTemp = JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "cuirass_naked") ; 0.05
			Conditions += "Armor - Snug: " + ((ValTemp * 100.0) as Int) + "%"
			SleepPenalty += ValTemp
		ElseIf Cuirass.GetWeightClass() <= 1
			;Debug.Messagebox("Slept in armor")
			ValTemp = JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "cuirass_armor") ; 0.20
			Conditions += "Armor - Very uncomfortable: " + ((ValTemp * 100.0) as Int) + "%"
			SleepPenalty += ValTemp
		Else
			ValTemp = JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "cuirass_cloth") ; 0.05
			Conditions += "Armor - Uncomfortable: " + ((ValTemp * 100.0) as Int) + "%"
			SleepPenalty += ValTemp
			;Debug.Messagebox("Slept in clothes")
		EndIf

	Else
		ValTemp = JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "cuirass_naked") ; -0.05
		Conditions += "Armor - Snug: " + ((ValTemp * 100.0) as Int) + "%"
		SleepPenalty += ValTemp
		;Debug.Messagebox("No cuirass")
	EndIf
	Conditions += "\n"

	; Bed?
	Bool HasBed = false
	ObjectReference Bed = Game.GetCurrentCrosshairRef()
	;Debug.Messagebox("Bed: " + Bed.GetBaseObject().GetName())
	If Bed
		Faction OwningFaction = Bed.GetFactionOwner()
		ActorBase Owner = Bed.GetActorOwner()
		If ((;/OwningFaction == PlayerBedOwnership ||/; OwningFaction == None || PlayerRef.IsInFaction(OwningFaction)) && (Owner == None || Owner == PlayerRef.GetActorBase())); || (OwningFaction == None && Bed.GetActorOwner() == None) ; Not someone elses bed
			HasBed = true
			String BedName = Bed.GetBaseObject().GetName()
			If StringUtil.Find(BedName, "Roll") != -1 || StringUtil.Find(BedName, "Hay Pile") != -1  || StringUtil.Find(BedName, "Bedding") != -1 ; Bedding = 'Rough Bedding'
				If StringUtil.Find(BedName, "Roll") != -1
					ValTemp = JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "bed_bedroll") ; 0.10
					Conditions += "Bed - Serviceable: " + ((ValTemp * 100.0) as Int) + "%"
					SleepPenalty += ValTemp
					;If IsSleeping
						CampingFatigueGain += JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "campfatigue_bedroll") ; 0.01
					;EndIf
				Else
					ValTemp = JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "bed_haypile") ; 0.15
					Conditions += "Bed - Serviceable: " + ((ValTemp * 100.0) as Int) + "%"
					SleepPenalty += ValTemp
					;If IsSleeping
						CampingFatigueGain += JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "campfatigue_haypile") ; 0.02
					;EndIf
				EndIf
			
			Else
				ValTemp = JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "bed_bed") ; -0.10
				Conditions += "Bed - Cosy: " + ((ValTemp * 100.0) as Int) + ""
				SleepPenalty += ValTemp
				;If IsSleeping
					CampingFatigueGain = 0.0
					CampingFatigueCurrent = 0.0
					If IsSleeping
						CampingFatigue = 0.0
					EndIf
				;EndIf
			EndIf

		;Else
			;Debug.Messagebox("someone elses bed")
		EndIf
	EndIf
	If !HasBed
		; Nothing - sleeping on ground
		ValTemp = JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "bed_ground") ; 0.40
		Conditions += "Bed - Terrible: " + ((ValTemp * 100.0) as Int) + "%"
		SleepPenalty += ValTemp
		;If IsSleeping
			CampingFatigueGain += JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "campfatigue_ground") ; 0.1
		;EndIf
	EndIf
	Conditions += "\n"

	; Inside/Outside ?
	If !PlayerRef.IsInInterior() ; Is outside?
		;Debug.Messagebox("Slept outside")
		
		;Debug.Messagebox("GetCurrentTent(): " + FrostInterface.GetCurrentTent())
		If FrostInterface.IsPlayerSheltered(Bed) || FrostInterface.GetCurrentTent() != None
			ValTemp = JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "location_outdoor_sheltered") ; 0.10
			Conditions += "Location - Outdoor (Sheltered): " + ((ValTemp * 100.0) as Int) + "%\n"
			SleepPenalty += ValTemp
			If CampingFatigueGain != 0.0
				CampingFatigueGain += JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "campfatigue_outdoor_sheltered") ; 0.01
			EndIf
		Else
			ValTemp = JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "location_outdoor_unsheltered") ; 0.30
			Conditions += "Location - Outdoor (Unsheltered): " + ((ValTemp * 100.0) as Int) + "%\n"
			SleepPenalty += ValTemp
			If CampingFatigueGain != 0.0
				CampingFatigueGain += JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "campfatigue_outdoor_unsheltered") ; 0.03
			EndIf
		EndIf
		If FrostInterface.IsCurrentWeatherSevere()
			ValTemp = JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "weather_severe") ; 0.20
			Conditions += "Weather - Severe: " + ((ValTemp * 100.0) as Int) + "\n"
			SleepPenalty += ValTemp
		Else
			ValTemp = JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "weather_calm") ; 0.0
			Conditions += "Weather - Calm: " + ((ValTemp * 100.0) as Int) + "%\n"
			SleepPenalty += ValTemp
			;SleepPenalty += 0.0
		EndIf		
		
		If FrostInterface.IsPlayerWarming()
			ValTemp = JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "temp_warm_fire") ; -0.05
			Conditions += "Temperature - Warm (Fire): " + ((ValTemp * 100.0) as Int) + "%\n"
			SleepPenalty += ValTemp
			
		Else
			Int Temp = FrostInterface.GetTemperature()
			If Temp < 10
				ValTemp = JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "temp_cold") ; 0.20
				Conditions += "Temperature - Cold: " + ((ValTemp * 100.0) as Int) + "%\n"
				SleepPenalty += ValTemp
			ElseIf Temp == 10
				ValTemp = JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "temp_neutral") ; 0.0
				Conditions += "Temperature - Neutral: " + ((ValTemp * 100.0) as Int) + "%\n"
				SleepPenalty += ValTemp
			Else
				ValTemp = JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "temp_warm") ; -0.05
				Conditions += "Temperature - Warm: " + ((ValTemp * 100.0) as Int) + "%\n"
				SleepPenalty += ValTemp
			EndIf
		EndIf
		
		;/
		If !FrostInterface.IsPlayerWarming() && FrostInterface.IsColdEnvironment()
			;Debug.Messagebox("Slept in the cold")
			Conditions += "Temperature - Cold: +20%\n"
			SleepPenalty += 0.20
			
		Else
			Conditions += "Temperature - Warm: +0%\n"
			SleepPenalty -= 0.05
		EndIf
		/;
		
	Else
		ValTemp = JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "location_indoor") ; -0.05
		Conditions += "Location - Indoor: " + ((ValTemp * 100.0) as Int) + "%\n"
		SleepPenalty += ValTemp
	EndIf

	If IsSleeping
		CampingFatigue += CampingFatigueGain
		If CampingFatigue > 0.5
			CampingFatigue = 0.5
		EndIf
	EndIf
	;String CampFatCurrent = StringUtil.Substring((CampingFatigueCurrent * 100.0), startIndex = 0, len = StringUtil.Find((CampingFatigueCurrent * 100.0), ".", startIndex = 0))
	;String CampFatGain = StringUtil.Substring((CampingFatigueGain * 100.0), startIndex = 0, len = StringUtil.Find((CampingFatigueGain * 100.0), ".", startIndex = 0))
	Conditions += "Camping Fatigue Current: " + ((CampingFatigueCurrent * 100.0) as Int) + "%\n"
	Conditions += "Camping Fatigue Gain Here: " + ((CampingFatigueGain * 100.0) as Int) + "%\n"
	SleepPenalty += CampingFatigue
	
	; Devices
	Int NumDevices = Devious.GetNumOfEquippedDevices(PlayerRef)
	Float MasochismAttitude = Sta.GetPlayerMasochismAttitude() as Float
	
	Float DeviceFactor
	If MasochismAttitude > 0 ; Masochist
						; ((1/2 * minimum devices) * penality per device) - 
		DeviceFactor = (((MasochismAttitude * 3.0) * 0.01 * MasochismAttitude) - (0.01 * NumDevices * MasochismAttitude)) * JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "sta_devicefactormult")
	Else
		DeviceFactor = (NumDevices * (0.01 * -(Sta.GetPlayerMasochismAttitude() as Float))) * JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "sta_devicefactormult")
	EndIf



	SleepPenalty += DeviceFactor
	Conditions += "Devious Factor - " + GetDeviousString(NumDevices, MasochismAttitude) + ((DeviceFactor * 100.0) as Int) + "%"
	Conditions += "\n"
	;Debug.Messagebox("NumDevices: " + NumDevices)
	
	; Arousal
	Conditions += "Arousal - "
	;Float Arousal = StorageUtil.GetFloatValue(PlayerRef, "SLAroused.ActorExposure")
	Float Arousal = PlayerRef.GetFactionRank(Game.GetFormFromFile(0x03FC36, "SexLabAroused.esm") as Faction)
	If Arousal <= 25.0
		ValTemp = JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "arousal_satisfied") ; -0.15
		Conditions += "Satisfied: " + ((ValTemp * 100.0) as Int) + "%\n"
		SleepPenalty += ValTemp
	ElseIf Arousal <= 50.0
		ValTemp = JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "arousal_wet") ; -0.07
		Conditions += "Wet: " + ((ValTemp * 100.0) as Int) + "%\n"
		SleepPenalty += ValTemp
	ElseIf Arousal <= 75.0
		ValTemp = JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "arousal_horny") ; 0.07
		Conditions += "Horny: " + ((ValTemp * 100.0) as Int) + "%\n"
		SleepPenalty += ValTemp
	Else
		ValTemp = JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "arousal_lustful") ; 0.15
		Conditions += "Lustful: " + ((ValTemp * 100.0) as Int) + "%\n"
		SleepPenalty += ValTemp
	EndIf
	
	; Time of day
	Float CurrentGameHour = GameHour.GetValue()
	If PlayerRef.HasKeyword(Vampire)
		Conditions += "Time of day (Vampire) - "
		If (CurrentGameHour >= JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "time_night_begin") && CurrentGameHour <= 24.0) || (CurrentGameHour < JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "time_morning_begin")) ; 21.0 - 4.0
			ValTemp = JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "time_pen_vamp_night") ; 0.20
			Conditions += "Night: " + ((ValTemp * 100.0) as Int) + "%\n"
			SleepPenalty += ValTemp
		ElseIf CurrentGameHour < JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "time_day_begin")
			ValTemp = JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "time_pen_vamp_night") ; -0.1
			Conditions += "Morning: " + ((ValTemp * 100.0) as Int) + "%\n"
			SleepPenalty += ValTemp
		ElseIf CurrentGameHour < JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "time_pen_vamp_morning")
			ValTemp = JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "time_pen_vamp_day") ; -0.2
			Conditions += "Day: " + ((ValTemp * 100.0) as Int) + "%\n"
			SleepPenalty += ValTemp
		Else
			ValTemp = JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "time_pen_vamp_evening") ; 0.0
			Conditions += "Evening: " + ((ValTemp * 100.0) as Int) + "%\n"
			SleepPenalty += ValTemp
		EndIf
	
	Else
		Conditions += "Time of day - "
		If (CurrentGameHour >= JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "time_night_begin") && CurrentGameHour <= 24.0) || (CurrentGameHour < JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "time_morning_begin"))
			ValTemp = JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "time_pen_night") ; -0.10
			Conditions += "Night: " + ((ValTemp * 100.0) as Int) + "%\n"
			SleepPenalty += ValTemp
		ElseIf CurrentGameHour < JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "time_day_begin")
			ValTemp = JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "time_pen_morning") ; 0.1
			Conditions += "Morning: " + ((ValTemp * 100.0) as Int) + "%\n"
			SleepPenalty += ValTemp
		ElseIf CurrentGameHour < JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "time_evening_begin")
			ValTemp = JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "time_pen_day") ; 0.2
			Conditions += "Day: " + ((ValTemp * 100.0) as Int) + "%\n"
			SleepPenalty += ValTemp
		Else
			ValTemp = JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "time_pen_evening") ; 0.0
			Conditions += "Evening: " + ((ValTemp * 100.0) as Int) + "%\n"
			SleepPenalty += ValTemp
		EndIf
	EndIf
	
	
	; Needs
	Conditions += "Hunger: "
	Float HungerPen = GetHungerSleepPenalty()
	If HungerPen >= 0.0
		Conditions += "+"
	EndIf
	Conditions += ((HungerPen * 100.0) as Int) + "%\n"
	SleepPenalty += HungerPen
	
	Float ThirstPen = GetThirstSleepPenalty()
	Conditions += "Thirst: "
	If ThirstPen >= 0.0
		Conditions += "+"
	EndIf
	Conditions += ((ThirstPen * 100.0) as Int) + "%\n"
	SleepPenalty += ThirstPen
	
	; Milk
	Float MilkCap = (StorageUtil.GetFloatValue(PlayerRef, "MME.MilkMaid.MilkCount", Missing = -1.0) / StorageUtil.GetFloatValue(PlayerRef, "MME.MilkMaid.MilkMaximum", Missing = 1.0))
	If MilkCap >= 0.0
		Float MilkPen = (0.1 * 2.0 * (-0.5 + MilkCap)) * JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "mme_milkfullnessmult")
		Conditions += "Milk fullness: " + (((MilkPen * 100.0) as Int)) + "%"
	EndIf
	
	; Cap it in case
	SleepPenalty = PapyrusUtil.ClampFloat(SleepPenalty, 0.0, 1.0)
	
	;Conditions += "Sleep penalty: " + ((SleepPenalty * 100.0) as Int) + "%"
	Conditions += "\nFinal sleep penalty: " + ((SleepPenalty * 100.0) as Int) + "%\n"
	If ShowConditions
		Conditions += "\n" + GetConditionsStatement(SleepPenalty)
		Debug.Messagebox(Conditions)
	EndIf
	LastSleepPenalty = SleepPenalty
	Return SleepPenalty
EndFunction

String Function GetDeviousString(Int NumDevices, Float MasochismAttitude)
	If MasochismAttitude < 0 ; Hates/Dislikes being bound
		If NumDevices == 0
			Return "Unaffected: +"
		ElseIf NumDevices <= 3
			Return "Bound girl: +"
		ElseIf NumDevices <= 6
			Return "Disobedient girl: +"
		ElseIf NumDevices <= 9
			Return "Slave in training: +"
		Else
			Return "Forced slave: +"
		EndIf
	
	ElseIf MasochismAttitude == 1 ; Likes being bound
		If NumDevices <= 2
			Return "Unbound slut: +"
		ElseIf NumDevices == 3
			Return "Content slut: "
		ElseIf NumDevices <= 5
			Return "Experimenting slut: "
		ElseIf NumDevices <= 7
			Return "Eager slut: "
		Else
			Return "Trained slave: "
		EndIf
	
	Else ; Loves
		If NumDevices <= 2
			Return "Unbound slut: +"
		ElseIf NumDevices <= 5
			Return "Loosely bound slut: +"
		ElseIf NumDevices == 6
			Return "Content slut: +"
		ElseIf NumDevices <= 8
			Return "Eager slut: "
		Else
			Return "Trained slave: "
		EndIf
	EndIf
EndFunction

; Empty state functions ============================================================
Bool Function IsNeedsModActive()
	Return false
EndFunction
	
Function EatCum(Float Amount)
EndFunction

Function DrinkCum(Float Amount)
EndFunction

Function ModHunger(Float Amount)
EndFunction

Function ModThirst(Float Amount)
EndFunction

Float Function GetFatigue()
	Return 0.0
EndFunction

Function CorrectFatigue(Float SleepPenalty, Float StartingFatigue, Float HoursSlept)
EndFunction

Function ModFatigue(Float Amount)
EndFunction

Bool Function IsDesperate() ; Condition used to determine if player will auto swallow cum
	Return false
EndFunction

Function GetBegIsHungy()
	BegIsHungry = false
EndFunction

Function GetBegIsThirsty()
	BegIsThirsty = false
EndFunction

Float Function GetBellyScale()
	Return -2.0
EndFunction

Float Function GetLastHungerUpdateTime()
	Return 0.0
EndFunction

String Function GetConditionsStatement(Float SleepPenalty)
	Return ""
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

State Rnd ; RND =======================================================================================
	Bool Function IsNeedsModActive()
		Return Rnd.IsNeedsModActive()
	EndFunction
	
	Function EatCum(Float Amount)
		;Debug.Messagebox("Swallowed " + (Amount * 15.0 * CumFoodMult) + " units of RND Cum food")
		ModHunger(Amount * 10.0 * CumFoodMult)
	EndFunction
	
	Function DrinkCum(Float Amount)
		;Debug.Messagebox("Swallowed " + (Amount * 25.0 * CumDrinkMult * SaltyCum) + " units of RND Cum drink. SaltyCum: " + SaltyCum)
		ModThirst(Amount * 20.0 * CumDrinkMult * SaltyCum)
	EndFunction

	Function ModHunger(Float Amount)
		Rnd.Eat(Amount as Int)
	EndFunction

	Function ModThirst(Float Amount)
		Rnd.Drink(Amount as Int)
	EndFunction

	Float Function GetFatigue()
		Return Rnd.GetFatigue()
	EndFunction

	Function CorrectFatigue(Float SleepPenalty, Float StartingFatigue, Float HoursSlept) ; Not Tired - 0.0, Slightly Tired - 30.0, Tired - 60.0, Very Tired - 120.0, Exhausted - 240.0. Capped between 0.0 - 240.0
		Rnd.CorrectFatigue(SleepPenalty, StartingFatigue, HoursSlept)
	EndFunction

	Function ModFatigue(Float Amount)
		FatigueBeforeModding = Rnd.GetFatigue()
		Rnd.ModFatigue(Amount as Int, Notify = false)
	EndFunction
	
	Bool Function IsDesperate() ; Condition used to determine if player will auto swallow cum
		Return Rnd.IsDesperate()
	EndFunction
	
	Function GetBegIsHungy()
		BegIsHungry = Rnd.GetBegIsHungry()
	EndFunction

	Function GetBegIsThirsty()
		BegIsThirsty = Rnd.GetBegIsThirsty()
	EndFunction
	
	Float Function GetBellyScale()
		Return BaseBellyScale + Rnd.GetBellyScale()
	EndFunction
	
	Float Function GetLastHungerUpdateTime()
		Return Rnd.RND_HungerLastUpdateTimeStamp.GetValue()	
	EndFunction
	
	String Function GetConditionsStatement(Float SleepPenalty)
		Return Rnd.GetConditionsStatement(SleepPenalty)
	EndFunction
	
	Float Function GetHungerSleepPenalty()
		Return Rnd.GetHungerSleepPenalty()
	EndFunction

	Float Function GetThirstSleepPenalty()
		Return Rnd.GetThirstSleepPenalty()
	EndFunction
	
	String Function GetAioHunger()
		Return Rnd.GetAioHunger()
	EndFunction
	
	String Function GetAioThirst()
		Return Rnd.GetAioThirst()
	EndFunction
	
	String Function GetAioFatigue()
		Return Rnd.GetAioFatigue()
	EndFunction
EndState

State iNeed ; iNeed ====================================================================================================
	Bool Function IsNeedsModActive()
		Return Ineed.IsNeedsModActive()
	EndFunction
	
	Function EatCum(Float Amount)
		ModHunger(Amount * 7.5 * CumFoodMult)
	EndFunction
	
	Function DrinkCum(Float Amount)
		ModThirst(Amount * 12.5 * CumDrinkMult * SaltyCum)
	EndFunction
	
	Function ModHunger(Float Amount)
		Ineed.Eat(Amount)
	EndFunction

	Function ModThirst(Float Amount)
		Ineed.Drink(Amount)
	EndFunction

	Float Function GetFatigue()
		Return Ineed.GetFatigue()
	EndFunction
	
	Function CorrectFatigue(Float SleepPenalty, Float StartingFatigue, Float HoursSlept)
		If IsNeedsModActive()
			Ineed.CorrectFatigue(SleepPenalty, StartingFatigue, HoursSlept)
		EndIf
	EndFunction

	Function ModFatigue(Float Amount)
		FatigueBeforeModding = Ineed.GetFatigue()
		;Debug.Messagebox("FatigueBeforeModding: " + FatigueBeforeModding)
		Ineed.ModFatigue(Amount)
	EndFunction
	
	Bool Function IsDesperate() ; Condition used to determine if player will auto swallow cum
		Return Ineed.IsDesperate()
	EndFunction
	
	Function GetBegIsHungy()
		BegIsHungry = Ineed.GetBegIsHungry()
	EndFunction

	Function GetBegIsThirsty()
		BegIsThirsty = Ineed.GetBegIsThirsty()
	EndFunction
	
	Float Function GetBellyScale()
		Return BaseBellyScale + Ineed.GetBellyScale()
	EndFunction
	
	Float Function GetLastHungerUpdateTime()
		Return Ineed.GetLastHungerUpdateTime()
	EndFunction
	
	String Function GetConditionsStatement(Float SleepPenalty)
		Return Ineed.GetConditionsStatement(SleepPenalty)
	EndFunction
	
	Float Function GetHungerSleepPenalty()
		Return Ineed.GetHungerSleepPenalty()
	EndFunction

	Float Function GetThirstSleepPenalty()
		Return Ineed.GetThirstSleepPenalty()
	EndFunction
	
	String Function GetAioHunger()
		Return iNeed.GetAioHunger()
	EndFunction
	
	String Function GetAioThirst()
		Return iNeed.GetAioThirst()
	EndFunction
	
	String Function GetAioFatigue()
		Return iNeed.GetAioFatigue()
	EndFunction
EndState

State Esd ; EatingSleepingDrinking =======================================================================================
	Bool Function IsNeedsModActive()
		Return EatSleepDrink.IsNeedsModActive()
	EndFunction
	
	Function EatCum(Float Amount)
		ModHunger(Amount * 240.0 * CumFoodMult)
	EndFunction
	
	Function DrinkCum(Float Amount)
		ModThirst(Amount * 360.0 * CumDrinkMult * SaltyCum)
	EndFunction

	Function ModHunger(Float Amount)
		EatSleepDrink.Eat(Amount as Int)
	EndFunction

	Function ModThirst(Float Amount)
		EatSleepDrink.Drink(Amount as Int)
	EndFunction

	Float Function GetFatigue()
		Return EatSleepDrink.GetFatigue()
	EndFunction

	Function CorrectFatigue(Float SleepPenalty, Float StartingFatigue, Float HoursSlept)
		EatSleepDrink.CorrectFatigue(SleepPenalty, StartingFatigue, HoursSlept)
	EndFunction

	Function ModFatigue(Float Amount)
		FatigueBeforeModding = EatSleepDrink.GetFatigue()
		EatSleepDrink.ModFatigue(Amount as Int)
	EndFunction
	
	Bool Function IsDesperate() ; Condition used to determine if player will auto swallow cum
		Return EatSleepDrink.IsDesperate()
	EndFunction
	
	Function GetBegIsHungy()
		BegIsHungry = EatSleepDrink.GetBegIsHungry()
	EndFunction

	Function GetBegIsThirsty()
		BegIsThirsty = EatSleepDrink.GetBegIsThirsty()
	EndFunction
	
	Float Function GetBellyScale()
		Return BaseBellyScale + EatSleepDrink.GetBellyScale()
	EndFunction
	
	Float Function GetLastHungerUpdateTime()
		Return EatSleepDrink.GetLastHungerUpdateTime()	
	EndFunction
	
	String Function GetConditionsStatement(Float SleepPenalty)
		Return EatSleepDrink.GetConditionsStatement(SleepPenalty)
	EndFunction
	
	Float Function GetHungerSleepPenalty()
		Return EatSleepDrink.GetHungerSleepPenalty()
	EndFunction

	Float Function GetThirstSleepPenalty()
		Return EatSleepDrink.GetThirstSleepPenalty()
	EndFunction
	
	String Function GetAioHunger()
		Return EatSleepDrink.GetAioHunger()
	EndFunction
	
	String Function GetAioThirst()
		Return EatSleepDrink.GetAioThirst()
	EndFunction
	
	String Function GetAioFatigue()
		Return EatSleepDrink.GetAioFatigue()
	EndFunction
EndState
