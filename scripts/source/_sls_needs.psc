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

; The drug comedown (_SLS_DrugFatigueInc): the rest a dose gave is owed back, with DrugEndFatigueInc
; of its strength on top, when the effect wears off. Doses add to one debt, because a second dose
; recasts the effect, which ends the running one, and that end must not charge the first dose early.
Float Property DrugFatigueOwed = 0.0 Auto Hidden

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
; Filled by the optional SunHelm patch plugin (SL Survival Sunhelm Patch.esp); None without it
_SLS_InterfaceShs Property Shs Auto

; Creation Club Survival Mode, looked up in IsCcsEnabled (no plugin edits needed)
Quest CcsHungerQuest
Quest CcsExhaustionQuest
GlobalVariable CcsModeEnabled
GlobalVariable CcsHungerValue
GlobalVariable CcsExhaustionValue
Float Property CcsFatigueScale = 2.0 Auto Hidden ; Retired in 0.806 for GetFatigueScale(), kept because saves hold it

; Survival Mode belly ladder, added to the base belly scale, one rung per hunger stage (00 Well Fed .. 05
; Ravenous). Like the other needs mods' ladders, by default only the fullest stage shows, and only a little.
; GetBellyRungDefault in State Ccs repeats these literals - keep the two in step.
Float Property BellyScaleCcs00 = 0.3 Auto Hidden
Float Property BellyScaleCcs01 = 0.0 Auto Hidden
Float Property BellyScaleCcs02 = 0.0 Auto Hidden
Float Property BellyScaleCcs03 = 0.0 Auto Hidden
Float Property BellyScaleCcs04 = 0.0 Auto Hidden
Float Property BellyScaleCcs05 = 0.0 Auto Hidden

Bool DoSleepDeprivMessage = true
String LastConditions ; Breakdown from the most recent GetSleepPenalty() call, minus the flavor statement
Float ConditionsShownRT = -3600.0 ; Real-time stamp of the last on-screen breakdown (Sleep/Wait menu hook path)
Bool SleptInFurniture ; Player was already in the bed when the applied penalty was computed (Go To Bed-style flow)
Keyword BedrollKeyword ; Skyrim.esm FurnitureBedRoll, fetched on first use
Form VampireCoffin

Event OnInit()
	PickNeedsState()
	RegisterForModEvent("_SLS_Int_PlayerLoadsGame", "On_SLS_Int_PlayerLoadsGame")
	RegisterForMenu("Sleep/Wait Menu")
	RegisterForControl("Wait")
	;Debug.Messagebox("Needs state: " + Self.GetState())
EndEvent

Event On_SLS_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
	PickNeedsState() ; Re-pick each load so installing/removing a needs mod mid-save takes effect
EndEvent

Function PickNeedsState()
	If Game.GetModByName("RealisticNeedsandDiseases.esp") != 255
		GoToState("Rnd")
	ElseIf Game.GetModByName("iNeed.esp") != 255
		GoToState("iNeed")
	ElseIf Game.GetModByName("EatingSleepingDrinking.esp") != 255
		GoToState("Esd")
	ElseIf Game.GetModByName("SunHelmSurvival.esp") != 255 && Shs ; needs the optional SunHelm patch plugin
		GoToState("Shs")
	ElseIf Game.GetModByName("ccqdrsse001-survivalmode.esl") != 255
		; On the plugin, not the switch: a new game runs this before the player answers Survival Mode's
		; prompt. Every Ccs function checks the switch itself and acts like the empty state while it is off.
		GoToState("Ccs")
	Else
		GoToState("")
	EndIf
EndFunction

; Creation Club Survival Mode is in the plugin list on AE whether or not it is switched on, so the switch decides,
; not the plugin. Fetches the forms on first use; True only while Survival Mode is running.
Bool Function IsCcsEnabled()
	If Game.GetModByName("ccqdrsse001-survivalmode.esl") == 255
		Return false
	EndIf
	If !CcsModeEnabled
		CcsModeEnabled = Game.GetFormFromFile(0x000826, "ccqdrsse001-survivalmode.esl") as GlobalVariable ; Survival_ModeEnabled
		CcsHungerValue = Game.GetFormFromFile(0x00081A, "ccqdrsse001-survivalmode.esl") as GlobalVariable ; Survival_HungerNeedValue
		CcsExhaustionValue = Game.GetFormFromFile(0x000816, "ccqdrsse001-survivalmode.esl") as GlobalVariable ; Survival_ExhaustionNeedValue
		CcsHungerQuest = Game.GetFormFromFile(0x000894, "ccqdrsse001-survivalmode.esl") as Quest ; Survival_NeedHungerQuest
		CcsExhaustionQuest = Game.GetFormFromFile(0x000899, "ccqdrsse001-survivalmode.esl") as Quest ; Survival_NeedExhaustionQuest
	EndIf
	Return CcsModeEnabled && CcsModeEnabled.GetValueInt() == 1 && CcsHungerQuest && CcsExhaustionQuest
EndFunction

; Stage 0..5 of a Survival Mode need from its current value
Int Function GetCcsStage(Quest NeedQuest, GlobalVariable NeedValue)
	Float[] Stages = _SLS_IntCcs.GetStageValues(NeedQuest)
	Float Value = NeedValue.GetValue()
	Int i = 5
	While i > 0
		If Value >= Stages[i]
			Return i
		EndIf
		i -= 1
	EndWhile
	Return 0
EndFunction

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
	; Go To Bed-style mods put the player IN the bed before sleep starts, which empties the
	; crosshair - the furniture being occupied is the truth then. Vanilla sleeps via the menu
	; with the player still standing (no furniture), so the crosshair fallback covers that path.
	ObjectReference Bed = PlayerRef.GetFurnitureReference()
	If IsSleeping
		SleptInFurniture = Bed != None ; The menu-hook box is unreliable in this flow - the wake-up fallback keys off this
	EndIf
	If !Bed
		Bed = Game.GetCurrentCrosshairRef()
		If Bed && !(Bed.GetBaseObject() as Furniture) ; a chest or a corpse in the crosshair is no bed
			Bed = None
		EndIf
	EndIf
	;Debug.Messagebox("Bed: " + Bed.GetBaseObject().GetName())
	If Bed
		Faction OwningFaction = Bed.GetFactionOwner()
		ActorBase Owner = Bed.GetActorOwner()
		If ((;/OwningFaction == PlayerBedOwnership ||/; OwningFaction == None || PlayerRef.IsInFaction(OwningFaction)) && (Owner == None || Owner == PlayerRef.GetActorBase())); || (OwningFaction == None && Bed.GetActorOwner() == None) ; Not someone elses bed
			HasBed = true
			String BedName = Bed.GetBaseObject().GetName()
			; The keyword is on every vanilla and DLC bedroll and hay pile, and on most modded ones, in any
			; game language; the English names stay as a fallback for a modded bedroll that lacks it.
			; A translated hay pile has no "Hay" to find, so it scores as a bedroll.
			If !BedrollKeyword
				BedrollKeyword = Game.GetFormFromFile(0x0E4AD6, "Skyrim.esm") as Keyword
			EndIf
			If !VampireCoffin
				VampireCoffin = Game.GetFormFromFile(0x000801, "HearthFires.esm") ; BYOHVampireCoffinVert01 carries the keyword but is a vampire's bed
			EndIf
			If (Bed.HasKeyword(BedrollKeyword) && Bed.GetBaseObject() != VampireCoffin) || StringUtil.Find(BedName, "Roll") != -1 || StringUtil.Find(BedName, "Hay Pile") != -1  || StringUtil.Find(BedName, "Bedding") != -1 ; Bedding = 'Rough Bedding'
				If StringUtil.Find(BedName, "Hay") == -1 && StringUtil.Find(BedName, "Bedding") == -1
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
				Conditions += "Bed - Cosy: " + ((ValTemp * 100.0) as Int) + "%"
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
			Conditions += "Weather - Severe: " + ((ValTemp * 100.0) as Int) + "%\n"
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
			ValTemp = JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "time_pen_vamp_morning") ; -0.1
			Conditions += "Morning: " + ((ValTemp * 100.0) as Int) + "%\n"
			SleepPenalty += ValTemp
		ElseIf CurrentGameHour < JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "time_evening_begin")
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
	
	; Milk: shown in the breakdown but never added to the penalty before 0.806
	Float MilkCount = StorageUtil.GetFloatValue(PlayerRef, "MME.MilkMaid.MilkCount", Missing = -1.0)
	Float MilkMax = StorageUtil.GetFloatValue(PlayerRef, "MME.MilkMaid.MilkMaximum", Missing = 0.0)
	If MilkCount >= 0.0 && MilkMax > 0.0 ; now that it counts, a zero maximum must not divide into the penalty
		Float MilkPen = (0.1 * 2.0 * (-0.5 + (MilkCount / MilkMax))) * JsonUtil.GetFloatValue("SL Survival/SleepDepriv.json", "mme_milkfullnessmult")
		Conditions += "Milk fullness: " + (((MilkPen * 100.0) as Int)) + "%\n"
		SleepPenalty += MilkPen
	EndIf
	
	; Cap it in case
	SleepPenalty = PapyrusUtil.ClampFloat(SleepPenalty, 0.0, 1.0)
	
	;Conditions += "Sleep penalty: " + ((SleepPenalty * 100.0) as Int) + "%"
	Conditions += "\nFinal sleep penalty: " + ((SleepPenalty * 100.0) as Int) + "%\n"
	LastConditions = Conditions ; Kept for the wake-up fallback display (Go To Bed never opens the Sleep/Wait menu)
	If ShowConditions
		Conditions += "\n" + GetConditionsStatement(SleepPenalty)
		Debug.Messagebox(Conditions)
		ConditionsShownRT = Utility.GetCurrentRealTime()
	EndIf
	LastSleepPenalty = SleepPenalty
	Return SleepPenalty
EndFunction

Bool Function GetConditionsShownRecently()
{True if the conditions box was shown in the last couple of minutes - i.e. the Sleep/Wait menu hook fired for this sleep.}
	Float Delta = Utility.GetCurrentRealTime() - ConditionsShownRT
	Return Delta >= 0.0 && Delta < 120.0 ; Negative = stale stamp from before a game load
EndFunction

Bool Function GetSleptInFurniture()
{True when the applied penalty was computed with the player already occupying the bed - Go To Bed etc.}
	Return SleptInFurniture
EndFunction

Function ShowLastConditions(Float SleepPenalty)
{Wake-up fallback: show the breakdown captured when the sleep penalty was actually applied.
Rides out other wake-up boxes first (the engine renders one modal at a time, and a second box
fired alongside can be swallowed) and the get-out-of-bed state (a box fired while still bedded
is eaten - the same suppression that hides the pre-sleep box under Go To Bed).}
	If !LastConditions
		Return
	EndIf
	Int Tries = 60 ; ~30s of active gameplay, then show anyway; Wait() doesn't tick while a menu/box is up
	While Tries > 0 && (Utility.IsInMenuMode() || PlayerRef.GetFurnitureReference())
		Utility.Wait(0.5)
		Tries -= 1
	EndWhile
	Debug.Messagebox(LastConditions + "\n" + GetConditionsStatement(SleepPenalty))
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

Function SyncBedrollSleepFlag() ; No-op unless the needs mod has a bedroll latch to correct (SunHelm)
EndFunction

; Straight after a dose's ModFatigue: owe back what the dose actually took, measured, so a meter that
; was already full is not charged for rest it never gave. Capped at the dose's strength, because
; iNeed's reading jumps a whole stage when a dose lifts its meter off empty.
Function OweDrugFatigue(Float Strength, Float ExtraMult)
	If IsNeedsModActive()
		Float Taken = PapyrusUtil.ClampFloat(Math.Abs(GetFatigue() - FatigueBeforeModding), 0.0, Strength)
		DrugFatigueOwed += Taken + (Strength * ExtraMult)
	EndIf
EndFunction

; From _SLS_DrugFatigueInc's end. A re-dose ends the running effect as well; then the newer dose's
; effect is up after the wait and pays the whole debt when it ends.
Function DrugEffectEnded(MagicEffect DrugEffect)
	Utility.Wait(0.5)
	If DrugEffect && PlayerRef.HasMagicEffect(DrugEffect)
		Return
	EndIf
	Float Owed = DrugFatigueOwed
	DrugFatigueOwed = 0.0
	If Owed > 0.0 && IsNeedsModActive()
		ModFatigue(Math.Ceiling(Owed))
		_SLS_Debuff.Notify("Comedown", "Comedown: the drug wears off and the tiredness comes flooding back")
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

; How many of the needs mod's own fatigue units one SLS fatigue unit is. SLS amounts (drugs, milk,
; bondage furniture) are counted in RND's units, and RND gains 4 fatigue an hour awake, so one SLS
; unit is a quarter hour awake; a state converts at its mod's default rate per hour divided by 4.
; Before 0.806 only Survival Mode converted (x2), so the same skooma kept a SunHelm player awake 4
; hours and an Eating Sleeping Drinking player 40 minutes, against 10 on RND. GetFatigue, ModFatigue
; and FatigueBeforeModding speak SLS units; each CorrectFatigue works in its mod's own.
Float Function GetFatigueScale()
	Return 1.0
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

; --- Generic belly ladder, reached by the MCM -------------------------------
; The MCM reaches the per-hunger-stage ladder through this script, not through
; the needs adapters: only the state picked here knows which needs mod is
; active, and a state that has a ladder (Shs, Ccs) overrides these.
;
; Rung 0 is the fullest stomach, rung (Count - 1) the emptiest. Count 0 means
; the active needs mod exposes no ladder, and the MCM draws no sliders for it.
; A label is a $-prefixed translation key, owned by the state that knows its
; own hunger stage names.
Int Function GetBellyRungCount()
	Return 0
EndFunction

String Function GetBellyLadderName()
	Return ""
EndFunction

Float Function GetBellyRung(Int aiRung)
	Return 0.0
EndFunction

Float Function GetBellyRungDefault(Int aiRung)
	Return 0.0
EndFunction

Function SetBellyRung(Int aiRung, Float afValue)
EndFunction

String Function GetBellyRungLabel(Int aiRung)
	Return ""
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
		Rnd.CorrectFatigue(SleepPenalty, StartingFatigue * GetFatigueScale(), HoursSlept) ; every adapter works in its mod's own units
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
		; -1.0 is the adapter's "stage is being swapped, ask again" sentinel. Adding the
		; base to it makes it look like an ordinary scale, and the gluttony script's
		; retry test (ScaleAmount == -1.0) then never matches - it publishes the sum
		; instead of waiting, snapping the belly flat mid-swap.
		Float Raw = Rnd.GetBellyScale()
		If Raw == -1.0
			Return -1.0
		EndIf
		Return BaseBellyScale + Raw
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

	Float Function GetFatigueScale() ; iNeed: 5 fatigue an hour (counts rest down from 110)
		Return 1.25
	EndFunction

	Float Function GetFatigue() ; rest, not fatigue: higher is fresher
		Return Ineed.GetFatigue() / GetFatigueScale()
	EndFunction
	
	Function CorrectFatigue(Float SleepPenalty, Float StartingFatigue, Float HoursSlept)
		If IsNeedsModActive()
			Ineed.CorrectFatigue(SleepPenalty, StartingFatigue * GetFatigueScale(), HoursSlept)
		EndIf
	EndFunction

	Function ModFatigue(Float Amount)
		FatigueBeforeModding = GetFatigue()
		;Debug.Messagebox("FatigueBeforeModding: " + FatigueBeforeModding)
		Ineed.ModFatigue(Amount * GetFatigueScale())
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
		; -1.0 is the adapter's "stage is being swapped, ask again" sentinel. Adding the
		; base to it makes it look like an ordinary scale, and the gluttony script's
		; retry test (ScaleAmount == -1.0) then never matches - it publishes the sum
		; instead of waiting, snapping the belly flat mid-swap.
		Float Raw = Ineed.GetBellyScale()
		If Raw == -1.0
			Return -1.0
		EndIf
		Return BaseBellyScale + Raw
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

	Float Function GetFatigueScale() ; Eating Sleeping Drinking counts sleepiness in game minutes: 60 an hour
		Return 15.0
	EndFunction

	Float Function GetFatigue() ; rest, not fatigue: higher is fresher
		Return EatSleepDrink.GetFatigue() / GetFatigueScale()
	EndFunction

	Function CorrectFatigue(Float SleepPenalty, Float StartingFatigue, Float HoursSlept)
		EatSleepDrink.CorrectFatigue(SleepPenalty, StartingFatigue * GetFatigueScale(), HoursSlept)
	EndFunction

	Function ModFatigue(Float Amount)
		FatigueBeforeModding = GetFatigue()
		EatSleepDrink.ModFatigue((Amount * GetFatigueScale()) as Int)
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
		; -1.0 is the adapter's "stage is being swapped, ask again" sentinel. Adding the
		; base to it makes it look like an ordinary scale, and the gluttony script's
		; retry test (ScaleAmount == -1.0) then never matches - it publishes the sum
		; instead of waiting, snapping the belly flat mid-swap.
		Float Raw = EatSleepDrink.GetBellyScale()
		If Raw == -1.0
			Return -1.0
		EndIf
		Return BaseBellyScale + Raw
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

State Shs ; SunHelmSurvival, only with the optional SunHelm patch plugin ========================================
	Bool Function IsNeedsModActive()
		Return Shs.IsNeedsModActive()
	EndFunction

	Function EatCum(Float Amount)
		ModHunger(Amount * 15.0 * CumFoodMult)
	EndFunction

	Function DrinkCum(Float Amount)
		ModThirst(Amount * 25.0 * CumDrinkMult * SaltyCum)
	EndFunction

	Function ModHunger(Float Amount)
		Shs.Eat(Amount as Int)
	EndFunction

	Function ModThirst(Float Amount)
		Shs.Drink(Amount as Int)
	EndFunction

	Float Function GetFatigueScale() ; SunHelm: 10 fatigue an hour (_SHFatigueRate)
		Return 2.5
	EndFunction

	Float Function GetFatigue()
		Return Shs.GetFatigue() / GetFatigueScale()
	EndFunction

	Function CorrectFatigue(Float SleepPenalty, Float StartingFatigue, Float HoursSlept)
		Shs.CorrectFatigue(SleepPenalty, StartingFatigue * GetFatigueScale(), HoursSlept) ; the adapter works in SunHelm's units
	EndFunction

	Function SyncBedrollSleepFlag()
		Shs.SyncBedrollSleepFlag()
	EndFunction

	Function ModFatigue(Float Amount)
		FatigueBeforeModding = GetFatigue()
		Shs.ModFatigue((Amount * GetFatigueScale()) as Int)
	EndFunction

	Bool Function IsDesperate() ; Condition used to determine if player will auto swallow cum
		Return Shs.IsDesperate()
	EndFunction

	Function GetBegIsHungy()
		BegIsHungry = Shs.GetBegIsHungry()
	EndFunction

	Function GetBegIsThirsty()
		BegIsThirsty = Shs.GetBegIsThirsty()
	EndFunction

	Float Function GetBellyScale()
		; -1.0 is the adapter's "stage is being swapped, ask again" sentinel. Adding the
		; base to it makes it look like an ordinary scale, and the gluttony script's
		; retry test (ScaleAmount == -1.0) then never matches - it publishes the sum
		; instead of waiting, snapping the belly flat mid-swap.
		Float Raw = Shs.GetBellyScale()
		If Raw == -1.0
			Return -1.0
		EndIf
		Return BaseBellyScale + Raw
	EndFunction

	Float Function GetLastHungerUpdateTime()
		Return Shs.GetLastHungerUpdateTime()
	EndFunction

	String Function GetConditionsStatement(Float SleepPenalty)
		Return Shs.GetConditionsStatement(SleepPenalty)
	EndFunction

	Float Function GetHungerSleepPenalty()
		Return Shs.GetHungerSleepPenalty()
	EndFunction

	Float Function GetThirstSleepPenalty()
		Return Shs.GetThirstSleepPenalty()
	EndFunction

	String Function GetAioHunger()
		Return Shs.GetAioHunger()
	EndFunction

	String Function GetAioThirst()
		Return Shs.GetAioThirst()
	EndFunction

	String Function GetAioFatigue()
		Return Shs.GetAioFatigue()
	EndFunction

	; SunHelm's own six hunger stages, in its own order and wording
	; (_SunHelmMain.psc): 0 Well Fed .. 5 Starving. Rung 0 is the fullest
	; stomach, which is also the biggest belly.
	Int Function GetBellyRungCount()
		Return 6
	EndFunction

	String Function GetBellyLadderName()
		Return "$SLS_hShsBellyScaling"
	EndFunction

	Float Function GetBellyRung(Int aiRung)
		If aiRung == 0
			Return Shs.BellyScaleShs00
		ElseIf aiRung == 1
			Return Shs.BellyScaleShs01
		ElseIf aiRung == 2
			Return Shs.BellyScaleShs02
		ElseIf aiRung == 3
			Return Shs.BellyScaleShs03
		ElseIf aiRung == 4
			Return Shs.BellyScaleShs04
		ElseIf aiRung == 5
			Return Shs.BellyScaleShs05
		EndIf
		Return 0.0
	EndFunction

	; The shipped property defaults, so the MCM's right-click reset restores what
	; the patch actually ships. Mirrors the literals on _SLS_InterfaceShs.psc's
	; BellyScaleShs00..05 property declarations - spelled out per rung rather than
	; derived from a pattern, which would silently stop matching the moment one of
	; them is retuned.
	Float Function GetBellyRungDefault(Int aiRung)
		If aiRung == 0
			Return 0.3
		ElseIf aiRung == 1
			Return 0.0
		ElseIf aiRung == 2
			Return 0.0
		ElseIf aiRung == 3
			Return 0.0
		ElseIf aiRung == 4
			Return 0.0
		ElseIf aiRung == 5
			Return 0.0
		EndIf
		Return 0.0
	EndFunction

	Function SetBellyRung(Int aiRung, Float afValue)
		If aiRung == 0
			Shs.BellyScaleShs00 = afValue
		ElseIf aiRung == 1
			Shs.BellyScaleShs01 = afValue
		ElseIf aiRung == 2
			Shs.BellyScaleShs02 = afValue
		ElseIf aiRung == 3
			Shs.BellyScaleShs03 = afValue
		ElseIf aiRung == 4
			Shs.BellyScaleShs04 = afValue
		ElseIf aiRung == 5
			Shs.BellyScaleShs05 = afValue
		EndIf
	EndFunction

	String Function GetBellyRungLabel(Int aiRung)
		If aiRung == 0
			Return "$SLS_BellyScaleShs00"
		ElseIf aiRung == 1
			Return "$SLS_BellyScaleShs01"
		ElseIf aiRung == 2
			Return "$SLS_BellyScaleShs02"
		ElseIf aiRung == 3
			Return "$SLS_BellyScaleShs03"
		ElseIf aiRung == 4
			Return "$SLS_BellyScaleShs04"
		ElseIf aiRung == 5
			Return "$SLS_BellyScaleShs05"
		EndIf
		Return ""
	EndFunction
EndState

State Ccs ; Creation Club Survival Mode ======================================================================
	; Survival Mode has hunger, exhaustion and cold but no thirst: drinking and thirst calls do nothing here.
	; Hunger 0..1000: Well Fed / Satisfied / Peckish / Hungry / Starving / Ravenous.
	; Exhaustion 0..960: Well Rested / Rested / Slightly Tired / Tired / Weary / Debilitated.
	Bool Function IsNeedsModActive()
		Return IsCcsEnabled()
	EndFunction

	Function EatCum(Float Amount)
		ModHunger(Amount * 15.0 * CumFoodMult)
	EndFunction

	Function DrinkCum(Float Amount)
	EndFunction

	Function ModHunger(Float Amount) ; positive = food, like the other needs adapters
		If !IsCcsEnabled()
			Return
		EndIf
		If Amount > 0.0
			_SLS_IntCcs.DecreaseHunger(CcsHungerQuest, Amount)
		ElseIf Amount < 0.0
			_SLS_IntCcs.IncreaseHunger(CcsHungerQuest, -Amount)
		EndIf
	EndFunction

	Function ModThirst(Float Amount)
	EndFunction

	Float Function GetFatigueScale() ; Survival Mode: 9 exhaustion an hour (Survival_ExhaustionNeedRate)
		Return 2.25
	EndFunction

	Float Function GetFatigue() ; SLS fatigue units: Survival Mode exhaustion / GetFatigueScale()
		If !IsCcsEnabled()
			Return 0.0
		EndIf
		Return CcsExhaustionValue.GetValue() / GetFatigueScale()
	EndFunction

	Function ModFatigue(Float Amount) ; + more tired, - less tired
		If !IsCcsEnabled()
			Return
		EndIf
		FatigueBeforeModding = GetFatigue()
		If Amount > 0.0
			_SLS_IntCcs.IncreaseExhaustion(CcsExhaustionQuest, Amount * GetFatigueScale())
		ElseIf Amount < 0.0
			_SLS_IntCcs.DecreaseExhaustion(CcsExhaustionQuest, -Amount * GetFatigueScale())
		EndIf
	EndFunction

	Function CorrectFatigue(Float SleepPenalty, Float StartingFatigue, Float HoursSlept)
		; Same structure as the SunHelm/RND adapters: runs ~5s after Survival Mode's own sleep restore and pulls
		; exhaustion back up to the floor the sleep conditions imply.
		If !IsCcsEnabled()
			Return
		EndIf
		Float[] Levels = _SLS_IntCcs.GetStageValues(CcsExhaustionQuest)
		Float TargetFatigue
		If SleepPenalty <= 0.2
			TargetFatigue = (SleepPenalty / 0.2) * Levels[1] ; up to 'Rested'
		ElseIf SleepPenalty <= 0.4
			TargetFatigue = (SleepPenalty / 0.4) * Levels[2] ; 'Slightly Tired'
		ElseIf SleepPenalty <= 0.6
			TargetFatigue = (SleepPenalty / 0.6) * Levels[3] ; 'Tired'
		ElseIf SleepPenalty <= 0.8
			TargetFatigue = (SleepPenalty / 0.8) * Levels[4] ; 'Weary'
		Else
			TargetFatigue = (SleepPenalty / 1.0) * ((Levels[4] + Levels[5]) / 2.0) ; between 'Weary' and 'Debilitated'
		EndIf
		TargetFatigue = TargetFatigue / GetFatigueScale()

		Float CurrentFatigue = GetFatigue()
		If StartingFatigue > TargetFatigue ; more tired than the cap when sleep began - cap the rest gained
			If CurrentFatigue < TargetFatigue
				ModFatigue(TargetFatigue - CurrentFatigue)
			EndIf
		ElseIf CurrentFatigue < TargetFatigue ; fresher than the floor - bad conditions wear the player down to it in 8 hours
			ModFatigue((TargetFatigue - CurrentFatigue) * PapyrusUtil.ClampFloat(HoursSlept / 8.0, 0.0, 1.0))
		EndIf
	EndFunction

	Bool Function IsDesperate() ; Condition used to determine if player will auto swallow cum
		Return IsCcsEnabled() && GetCcsStage(CcsHungerQuest, CcsHungerValue) >= 5
	EndFunction

	Function GetBegIsHungy()
		BegIsHungry = IsCcsEnabled() && GetCcsStage(CcsHungerQuest, CcsHungerValue) >= 3 ; 'Hungry' or worse
	EndFunction

	Function GetBegIsThirsty()
		BegIsThirsty = false
	EndFunction

	Float Function GetBellyScale()
		If !IsCcsEnabled()
			Return -2.0
		EndIf
		Return BaseBellyScale + GetBellyRung(GetCcsStage(CcsHungerQuest, CcsHungerValue))
	EndFunction

	Int Function GetBellyRungCount()
		If !IsCcsEnabled()
			Return 0
		EndIf
		Return 6
	EndFunction

	String Function GetBellyLadderName()
		Return "$SLS_hCcsBellyScaling"
	EndFunction

	Float Function GetBellyRung(Int aiRung)
		If aiRung == 0
			Return BellyScaleCcs00
		ElseIf aiRung == 1
			Return BellyScaleCcs01
		ElseIf aiRung == 2
			Return BellyScaleCcs02
		ElseIf aiRung == 3
			Return BellyScaleCcs03
		ElseIf aiRung == 4
			Return BellyScaleCcs04
		ElseIf aiRung == 5
			Return BellyScaleCcs05
		EndIf
		Return 0.0
	EndFunction

	Float Function GetBellyRungDefault(Int aiRung) ; the BellyScaleCcs00..05 declaration literals
		If aiRung == 0
			Return 0.3
		EndIf
		Return 0.0
	EndFunction

	Function SetBellyRung(Int aiRung, Float afValue)
		If aiRung == 0
			BellyScaleCcs00 = afValue
		ElseIf aiRung == 1
			BellyScaleCcs01 = afValue
		ElseIf aiRung == 2
			BellyScaleCcs02 = afValue
		ElseIf aiRung == 3
			BellyScaleCcs03 = afValue
		ElseIf aiRung == 4
			BellyScaleCcs04 = afValue
		ElseIf aiRung == 5
			BellyScaleCcs05 = afValue
		EndIf
	EndFunction

	String Function GetBellyRungLabel(Int aiRung)
		If aiRung == 0
			Return "$SLS_BellyScaleCcs00"
		ElseIf aiRung == 1
			Return "$SLS_BellyScaleCcs01"
		ElseIf aiRung == 2
			Return "$SLS_BellyScaleCcs02"
		ElseIf aiRung == 3
			Return "$SLS_BellyScaleCcs03"
		ElseIf aiRung == 4
			Return "$SLS_BellyScaleCcs04"
		ElseIf aiRung == 5
			Return "$SLS_BellyScaleCcs05"
		EndIf
		Return ""
	EndFunction

	Float Function GetLastHungerUpdateTime() ; game days, like Utility.GetCurrentGameTime()
		If !IsCcsEnabled()
			Return 0.0
		EndIf
		Return _SLS_IntCcs.GetLastUpdateHours(CcsHungerQuest) / 24.0
	EndFunction

	String Function GetConditionsStatement(Float SleepPenalty)
		If !IsCcsEnabled()
			Return ""
		EndIf
		String ConditionString = "Maximum rest in these conditions is: "
		If SleepPenalty <= 0.2
			Return ConditionString + "Rested. "
		ElseIf SleepPenalty <= 0.4
			Return ConditionString + "Slightly tired. "
		ElseIf SleepPenalty <= 0.6
			Return ConditionString + "Tired. "
		ElseIf SleepPenalty <= 0.8
			Return ConditionString + "Weary. "
		EndIf
		Return ConditionString + "Debilitated. "
	EndFunction

	Float Function GetHungerSleepPenalty() ; keys may be added to SleepDepriv.json, the defaults mirror the SunHelm ones
		If !IsCcsEnabled()
			Return 0.0
		EndIf
		Int Stage = GetCcsStage(CcsHungerQuest, CcsHungerValue)
		String File = "SL Survival/SleepDepriv.json"
		If Stage == 0
			Return JsonUtil.GetFloatValue(File, "hunger_ccs_wellfed", -0.05)
		ElseIf Stage == 1
			Return JsonUtil.GetFloatValue(File, "hunger_ccs_satisfied", -0.025)
		ElseIf Stage == 2
			Return JsonUtil.GetFloatValue(File, "hunger_ccs_peckish", 0.0)
		ElseIf Stage == 3
			Return JsonUtil.GetFloatValue(File, "hunger_ccs_hungry", 0.1)
		ElseIf Stage == 4
			Return JsonUtil.GetFloatValue(File, "hunger_ccs_starving", 0.15)
		EndIf
		Return JsonUtil.GetFloatValue(File, "hunger_ccs_ravenous", 0.3)
	EndFunction

	Float Function GetThirstSleepPenalty()
		Return 0.0
	EndFunction

	String Function GetAioHunger()
		If !IsCcsEnabled()
			Return ""
		EndIf
		Int Stage = GetCcsStage(CcsHungerQuest, CcsHungerValue)
		If Stage == 0
			Return "Well fed"
		ElseIf Stage == 1
			Return "Satisfied"
		ElseIf Stage == 2
			Return "Peckish"
		ElseIf Stage == 3
			Return "Hungry"
		ElseIf Stage == 4
			Return "Starving"
		EndIf
		Return "Ravenous"
	EndFunction

	String Function GetAioThirst()
		Return ""
	EndFunction

	String Function GetAioFatigue()
		If !IsCcsEnabled()
			Return ""
		EndIf
		Int Stage = GetCcsStage(CcsExhaustionQuest, CcsExhaustionValue)
		If Stage == 0
			Return "Well rested"
		ElseIf Stage == 1
			Return "Rested"
		ElseIf Stage == 2
			Return "Slightly tired"
		ElseIf Stage == 3
			Return "Tired"
		ElseIf Stage == 4
			Return "Weary"
		EndIf
		Return "Debilitated"
	EndFunction
EndState
