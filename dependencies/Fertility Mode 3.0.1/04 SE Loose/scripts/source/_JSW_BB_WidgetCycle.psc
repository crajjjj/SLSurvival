Scriptname _JSW_BB_WidgetCycle extends SKI_WidgetBase

Actor Property PlayerRef  Auto                          ; Reference to the player. Game.GetPlayer() is slow

_JSW_BB_Storage Property Storage  Auto                  ; Storage data helper

GlobalVariable Property Enabled  Auto                   ; Whether the mod is actively running or not

GlobalVariable Property PregnancyDuration  Auto         ; Full duration of a pregnancy, eg. 30 days
GlobalVariable Property RecoveryDuration  Auto          ; Full duration of recovery from a pregnancy before becoming fertile, eg. 10 days
GlobalVariable Property CycleDuration  Auto             ; Full duration of the menstrual cycle, eg. 28 days
GlobalVariable Property MenstruationBegin  Auto         ; Starting day of menstruation, eg. day 0
GlobalVariable Property MenstruationEnd  Auto           ; Ending day of menstruation, eg. day 7
GlobalVariable Property OvulationBegin  Auto            ; Starting day of ovulation, eg. day 8
GlobalVariable Property OvulationEnd  Auto              ; Ending day of ovulation, eg. day 16
GlobalVariable Property EggLife  Auto                   ; The age an egg can reach before it is no longer viable, eg 1.0 days
GlobalVariable Property SpermLife  Auto                 ; Time before sperm is removed, eg. 5 days
GlobalVariable Property ConceptionChance  Auto          ; Maximum percentage for fertility calculations

MagicEffect Property EffectFertility  Auto              ; Magic effect for increased fertility
MagicEffect Property EffectContraception  Auto          ; Magic effect for decreased fertility

GlobalVariable Property WidgetShown  Auto               ; True if the widget is visible, false if not
GlobalVariable Property WidgetTop  Auto                 ; The Y position of the widget in pixels
GlobalVariable Property WidgetLeft  Auto                ; The X position of the widget in pixels

event OnWidgetLoad()
	parent.OnWidgetLoad()
	OnWidgetReset()
endEvent

event OnWidgetReset()
	parent.OnWidgetReset()
	
	X		= WidgetLeft.GetValueInt()
	Y		= WidgetTop.GetValueInt()
	HAnchor	= "left"
	VAnchor	= "top"
	
	UI.Invoke(HUD_MENU, WidgetRoot + ".initCommit")
	
	UpdateContent()
endEvent

String function GetWidgetType()
	return "_JSW_BB_WidgetCycle"
endFunction

String function GetWidgetSource()
	return "Fertility Mode/BeeingFemaleWid1.swf"
endFunction

function UpdateContent()
	if (Enabled.GetValueInt() && WidgetShown.GetValueInt() && Storage.TrackedActors.Find(PlayerRef) != -1)
		float now = Utility.GetCurrentGameTime()
		
		X = WidgetLeft.GetValueInt()
		Y = WidgetTop.GetValueInt()
		
		UI.InvokeString(HUD_MENU, WidgetRoot + ".setFillDirection", "right")
		UI.InvokeInt(HUD_MENU, WidgetRoot + ".setColor", 0x880044)
		UI.InvokeInt(HUD_MENU, WidgetRoot + ".setDarkColor", 0x880044)
		
		int actorIndex = Storage.TrackedActors.Find(PlayerRef)
		int cycleDay = Math.Ceiling(Storage.LastGameHours[actorIndex] + Storage.LastGameHoursDelta[actorIndex]) % (CycleDuration.GetValueInt() + 1)
		float birthDay = (now - Storage.LastBirth[actorIndex])
		int stateID = 2 ; Default to luteal phase
		
		if (Storage.LastConception[actorIndex] > 0.0)
			int pregnantDay = (now - Storage.LastConception[actorIndex]) as int
			int trimesterDuration = Math.Ceiling(PregnancyDuration.GetValueInt() / 3)
			
			if (pregnantDay < trimesterDuration)
				stateID = 4
			elseIf (pregnantDay < trimesterDuration * 2)
				stateID = 5
			elseIf (pregnantDay < PregnancyDuration.GetValueInt())
				stateID = 6
			else
				stateID = 20
			endIf
		elseIf (Storage.LastBirth[actorIndex] != 0.0 && birthDay < RecoveryDuration.GetValueInt())
			stateID = 8
		elseIf (cycleDay >= MenstruationBegin.GetValueInt() && cycleDay <= MenstruationEnd.GetValueInt() && !PlayerRef.HasMagicEffect(EffectFertility))
			stateID = 3
		elseIf ((cycleDay >= OvulationBegin.GetValueInt() && cycleDay <= OvulationEnd.GetValueInt()) || PlayerRef.HasMagicEffect(EffectFertility))
			if (Storage.LastOvulation[actorIndex] == 0.0)
				stateID = 1
			else
				stateID = 0
			endIf
		endIf
		
		string sperm = ""
		string added = ""
		string s = "Unknown"
		float percent = 0.0
		int fertility = 0
		
		if (PlayerRef.HasMagicEffect(EffectContraception))
			added = "(-)"
		elseIf (PlayerRef.HasMagicEffect(EffectFertility))
			added = "(+)"
		endIf
		
		if (Storage.LastOvulation[actorIndex] > 0.0 && Storage.LastOvulation[actorIndex] <= EggLife.GetValue())
			added += "(*)"
		endIf
		
		if (Storage.LastInsemination[actorIndex] > 0.0)
			sperm += "(!)"
		endIf
		
		float spermCount = Storage.SpermCount[actorIndex]
		int ovulationDay = ((OvulationEnd.GetValueInt() - OvulationBegin.GetValueInt()) / 2) + OvulationBegin.GetValueInt()
		int viableDayStart = ovulationDay - (SpermLife.GetValueInt() - 1)
		int viableDayEnd = ovulationDay + EggLife.GetValueInt()
		
		if (cycleDay >= viableDayStart && cycleDay < ovulationDay)
			; Increase fertility percentage up to half the viable period
			fertility = ConceptionChance.GetValueInt() / (ovulationDay - viableDayStart) * (cycleDay - viableDayStart + 1)
		elseIf (cycleDay < viableDayEnd && cycleDay >= ovulationDay)
			fertility = ConceptionChance.GetValueInt()
		endIf
		
		if (PlayerRef.HasMagicEffect(EffectContraception))
			fertility = 3
		elseIf (PlayerRef.HasMagicEffect(EffectFertility))
			fertility += ConceptionChance.GetValueInt()
		endIf
		
		; Clamp the fertility percentage
		if (fertility > ConceptionChance.GetValueInt())
			fertility = ConceptionChance.GetValueInt()
		elseIf (fertility < 0)
			fertility = 0
		endIf
		
		if (stateID == 1)
			; Follicular phase
			s = "Fertile: " + fertility + "% " + added + sperm
			percent = (cycleDay - OvulationBegin.GetValue()) as float / (OvulationEnd.GetValue() - OvulationBegin.GetValue())
		elseIf (stateID == 0)
			; Ovulation
			s = "Fertile: " + fertility + "% " + added + sperm
			percent = (cycleDay - OvulationBegin.GetValue()) as float / (OvulationEnd.GetValue() - OvulationBegin.GetValue())
		elseIf (stateID == 2)
			; Luteal phase
			s = "Fertile: " + fertility + "% " + added + sperm
			percent = (cycleDay - OvulationEnd.GetValue()) as float / (CycleDuration.GetValue() - OvulationEnd.GetValue())
		elseIf (stateID == 3)
			; Menstruation
			s = "Fertile: " + fertility + "% " + added + sperm
			percent = (cycleDay - MenstruationBegin.GetValue()) as float / (MenstruationEnd.GetValue() - MenstruationBegin.GetValue())
		elseIf (stateID == 8)
			; Recovery
			s = "Fertile: " + "0% "
			percent = birthDay as float / RecoveryDuration.GetValueInt()
		elseIf (stateID == 4 || stateID == 5 || stateID == 6 || stateID == 20)
			; Pregnant
			s = "Baby Health: " + Storage.BabyHealth + "%"
			percent = (now - Storage.LastConception[actorIndex]) / PregnancyDuration.GetValue()
		endIf
		
		UI.InvokeString(HUD_MENU, WidgetRoot + ".setPhase", s)
		UI.InvokeInt(HUD_MENU, WidgetRoot + ".setIcon", stateID)
		UI.InvokeFloat(HUD_MENU, WidgetRoot + ".setPercent", percent)
		
		Alpha = 100.0
	else
		Alpha = 0.0
	endIf
endFunction