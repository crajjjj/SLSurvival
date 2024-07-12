ScriptName		_JSW_SUB_GVHolderScript		Extends		Quest

_JSW_BB_Storage		Property	Storage				Auto	; Storage data helper

GlobalVariable		Property	GVBellyScMax		Auto	; 
GlobalVariable		Property	GVBellyScMult		Auto	; 
GlobalVariable		Property	GVBreastScMult		Auto	; 
GlobalVariable		Property	GVBirthType			Auto	; The action taken upon birth (0=nothing, 1=soul gem, 2=baby item)
GlobalVariable		Property	GVEnabled			Auto	; GV representing whether the mod is enabled
GlobalVariable		Property	GVForceGender		Auto	; GV for player forced gender override
GlobalVariable		Property	GVLaborDuration		Auto	; GV for labor duration
GlobalVariable		Property	GVLaborEnabled		Auto	; GV for labor enabled
GlobalVariable		Property	GVMiscarriageEn		Auto	; GV for miscarriage mechanics enabled
; 2.27
GlobalVariable		Property	GVNPCDrinkPots		Auto	; GV have NPCs drink potions?
GlobalVariable		Property	GVPollInterval		Auto	; GV for polling interval- used by FA
GlobalVariable		Property	GVPregDuration		Auto	; GV pregnancy duration- used by FA
GlobalVariable		Property	GVScaleMethod		Auto	; GV for scaling method.  NYI
GlobalVariable		Property	GVUniqueMenOnly		Auto	; GV to not track non-unique males
GlobalVariable		Property	GVUniqueWomenOnly	Auto	; GV to not track non-unique females
GlobalVariable		Property	GVVerboseMode		Auto	; GV for verbose mode
; 2.09
GlobalVariable		Property	GVGameDaysPassed	Auto	; GV equiv to GetCurrentGameTime() but alledgedly faster

Bool	Property	AbortSpellAdded			=	false	Auto	; bool 0
Bool	Property	AdoptionEnabled			=	true	Auto	; bool 1
Bool	Property	AllowCreatures			=	false	Auto	; bool 0
Bool	Property	AutoInseminateNpc		=	true	Auto	; bool 1
Bool	Property	AutoInseminatePc		=	true	Auto	; bool 1
Bool	Property	AutoInseminatePcSleep	=	false	Auto	; bool 0
Bool	Property	BirthSpellAdded			=	false	Auto	; bool 0
Bool	Property	Enabled					=	false	Auto	; bool 0
; 2.17
Bool	Property	FADetected				=	false	Auto	; is Fertility Adventures installed?
Bool	Property	ImpregnateSpellAdded	=	false	Auto	; Adds or removes a spell to force pregnancy bool 0
Bool	Property	InseminateSpellAdded	=	false	Auto	; Adds or removes a spell to force insemination bool 0
Bool	Property	LaborEnabled			=	true	Auto	; Whether labor animations are played or not bool 1
; 2.23
Bool	Property	MapWidgetKey			=	true	Auto	; map the widget hotkey?
Bool	Property	MiscarriageEnabled		=	false	Auto	; Whether baby health calculations are performed bool 0
Bool	Property	PlayerOnly				=	false	Auto	; Tracking only includes the player and relevant NPCs bool 0
Bool	Property	SpawnEnabled			=	true	Auto	; Whether babies grow into children bool 1
Bool	Property	TrainingEnabled			=	true	Auto	; Whether spawns are sent to training unconditionally or if adoption fails bool 1
Bool	Property	UniqueMenOnly			=	false	Auto	; Only track men with the IsUnique flag enabled bool 0
Bool	Property	UniqueWomenOnly			=	false	Auto	; Only track women with the IsUnique flag enabled bool 0
Bool	Property	VerboseMode				=	true	Auto	; Show verbose notification messages bool 1
Bool	Property	WidgetShown				=	true	Auto	; True if the widget is visible, false if not bool 1

Float	Property	BellyScaleMax			=	5.0		Auto	; The maximum belly size for NiOverride (breasts piggy back on it) float? 5.0
Float	Property	BellyScaleMult			=	1.0		Auto	; The amount of breast scaling relative to belly scaling float? 1.0
Float	Property	BreastScaleMult			=	0.5		Auto	; The amount of breast scaling relative to belly scaling float 0.5
Float	Property	EggLife					=	1.0		Auto	; int 1 - keep as float, may want to change in the future.
Float	Property	LaborDuration			=	60.0	Auto	; The number of seconds labor takes to complete float 60 
Float	Property	PollingInterval			=	1.0		Auto	; How often we run the update loop float 1.0
Float	Property	SoundVolume				=	1.0		Auto	; Specifies a [0.0,1.0] clamped volume for sounds (eg. labor and baby) float 1.0

Int		Property	AutoInseminateChance	=	5		Auto	; int 5
Int		Property	BabyDuration			=	28		Auto	; int 28
Int		Property	BirthRace				=	0		Auto	; The race inheritance of the baby (mother=0, father=1, random=2, specific=3)int0
Int		Property	BirthRaceSpecific		=	0		Auto	; The specific unconditional race of the child int? 0
Int		Property	BirthType				=	2		Auto	; The action taken upon birth (0=nothing, 1=soul gem, 2=baby item) int 2
Int		Property	ConceptionChance		=	3		Auto	; base percentage for fertility calculations int 3
Int		Property	CycleBuffDebuff			=	10		Auto	; max % from buffs/debuffs int 10
Int		Property	CycleDuration			=	28		Auto	; Full duration of the menstrual cycle, eg. 28 days int 28
Int		Property	ForceGender				=	2		Auto	; 0 = force male, 1 = force female, 2 = autodetect
Int		Property	OvulationBegin			=	7		Auto	; Starting day of ovulation, eg. day 8 int 7
Int		Property	OvulationEnd			=	21		Auto	; Ending day of ovulation, eg. day 16 int 21
Int		Property	PregnancyDuration		=	30		Auto	; Full duration of a pregnancy, eg. 30 days int? 30
Int		Property	RecoveryDuration		=	29		Auto	; Full duration of recovery from a pregnancy int 29
Int		Property	ScalingMethod			=	0		Auto	; The scaling method for bellies and breasts int 0
Int		Property	SpermLife				=	4		Auto	; Time before sperm is removed, eg. 5 days int 4
; 2.10 change default to 90% now that relationship rank is factored in
Int		Property	SpouseInseminateChance	=	90		Auto	; spouse/love interest fidelity percent int 90
Int		Property	WidgetHotKey			=	10		Auto	; Hot key code for showing and hiding the widget int 10
Int		Property	WidgetLeft				=	900		Auto	; The X position of the widget in pixels int 900
Int		Property	WidgetTop				=	100		Auto	; The Y position of the widget in pixels int 100
; 2.17
Int		Property	TrackPageLength			=	8		Auto	; number of females per MCM tracking page, males will be double this

Quest	Property	MiscUtilQ						Auto	; 

bool	Property	ScanOptionsChanged	=	true	Auto	; flag for GVAlias to update its cell scan conditions

function	PlayerLoadedGame()

	if !MiscUtilQ.IsRunning()
		MiscUtilQ.SetCurrentStageID(10)
	endIf
	; 2.17
	FADetected = (Game.GetModByName("Fertility Adventures.esp") != 255)
	if FADetected
		if PregnancyDuration < 12
			PregnancyDuration = 12
		endIf
	endIf
	; 2.21 move this after check for pregnancy duration to ensure it gets updated
	UpdateGVs()

endFunction

function	UpdateGVs()

	GVBirthType.SetValue(BirthType as float)
	GVEnabled.SetValue(Enabled as float)
	GVForceGender.SetValue(ForceGender as float)
	GVLaborDuration.SetValue(LaborDuration)
	GVLaborEnabled.SetValue(LaborEnabled as float)
	GVUniqueMenOnly.SetValue(UniqueMenOnly as float)
	GVUniqueWomenOnly.SetValue(UniqueWomenOnly as float)
	GVVerboseMode.SetValue(VerboseMode as float)
	GVMiscarriageEn.SetValue(MiscarriageEnabled as float)
	GVPollInterval.SetValue(PollingInterval)
	GVPregDuration.SetValue(PregnancyDuration as float)
	GVScaleMethod.SetValue(ScalingMethod as float)
	GVBellyScMax.SetValue(BellyScaleMax)
	GVBellyScMult.SetValue(BellyScaleMult)
	GVBreastScMult.SetValue(BreastScaleMult)
	; 2.14 existence check added 2.16
	If Storage.FMValues.Length
		Storage.FMValues[0] = (PregnancyDuration / 3) as int
		Storage.FMValues[1] = ((OvulationBegin + OvulationEnd) / 2) as int
	endIf

endFunction

form	function	GetMeMyForm(int formNumber, string pluginName)

	int theLO = Game.GetModByName(pluginName)
	if ((theLO == 255) || (theLO == 0)) ; 255 = not found, 0 = no skse
		Debug.Trace(pluginName + " not loaded or SKSE not found", 1)
		return	none
	elseIf (theLO > 255) ; > 255 = ESL
		; the first FIVE hex digits in an ESL are its address, so a formNumber exceeding 0xFFF or below 0x800 is invalid
		if ((Math.LogicalAnd(0xFFFFF000, formNumber) != 0) || (Math.LogicalAnd(0x00000800, formNumber) == 0))
			Debug.Trace("FM+: Invalid FormID " + formNumber + " requested from " + pluginName, 2)
			return	none
		endIf
		theLO -= 256
		return	Game.GetFormEx(Math.LogicalOr(Math.LogicalOr(0xFE000000, Math.LeftShift(theLO, 12)), formNumber))
	else	; regular ESL-free plugin
		return	Game.GetFormEx(Math.LogicalOr(Math.LeftShift(theLO, 24), formNumber))
	endIf

endFunction
