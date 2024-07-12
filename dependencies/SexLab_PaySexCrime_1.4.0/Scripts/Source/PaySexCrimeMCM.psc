scriptname PaySexCrimeMCM extends SKI_ConfigBase

PSC_BountyDecay Property BountyDecayScript Auto
PSC_QuestScript Property QuestScript Auto
PSC_Functions Property Functions Auto
PSC_Scenes Property Scenes Auto
PSC_ApproachStart Property ApproachStart Auto

Faction Property CrimeFactionEastmarch Auto 
Faction Property CrimeFactionFalkreath Auto 
Faction Property CrimeFactionHaafingar Auto 
Faction Property CrimeFactionHjaalmarch Auto 
Faction Property CrimeFactionPale Auto 
Faction Property CrimeFactionReach Auto 
Faction Property CrimeFactionRift Auto 
Faction Property CrimeFactionWhiterun Auto 
Faction Property CrimeFactionWinterhold Auto

GlobalVariable Property Rejected Auto

Bool Property PSC_AllowRetry Auto
Bool Property PSC_UseArousal Auto

Bool Property PSC_RejectSelection_Oral Auto
Float Property _sliderPercent_RejectBounty_Oral Auto
Float Property _sliderPercent_RejectFixed_Oral Auto
Bool Property PSC_PaymentSelection_Oral Auto
float Property _sliderPercent_PaymentFixed_Oral Auto
float Property _sliderPercent_PaymentBounty_Oral Auto
float Property _sliderPercent_PardonTime_Oral Auto

Bool Property PSC_RejectSelection_Sex Auto
Float Property _sliderPercent_RejectBounty_Sex Auto
Float Property _sliderPercent_RejectFixed_Sex Auto
Bool Property PSC_PaymentSelection_Sex Auto
float Property _sliderPercent_PaymentFixed_Sex Auto
float Property _sliderPercent_PaymentBounty_Sex Auto
float Property _sliderPercent_PardonTime_Sex Auto

Bool Property PSC_RejectSelection_Anal Auto
Float Property _sliderPercent_RejectBounty_Anal Auto
Float Property _sliderPercent_RejectFixed_Anal Auto
Bool Property PSC_PaymentSelection_Anal Auto
float Property _sliderPercent_PaymentFixed_Anal Auto
float Property _sliderPercent_PaymentBounty_Anal Auto
float Property _sliderPercent_PardonTime_Anal Auto

Bool Property PSC_RejectSelection_Multiple Auto
Float Property _sliderPercent_RejectBounty_Multiple Auto
Float Property _sliderPercent_RejectFixed_Multiple Auto
Bool Property PSC_PaymentSelection_Multiple Auto
float Property _sliderPercent_PaymentFixed_Multiple Auto
float Property _sliderPercent_PaymentBounty_Multiple Auto
float Property _sliderPercent_PardonTime_Multiple Auto

Float Property _sliderPercent_SameGenderPenalty Auto

Faction Property GuardsCrimeFaction Auto
int Property CrimeFaction Auto
int[] Property SuccessTracker Auto
int[] Property BountyNonViolent Auto
int[] Property BountyViolent Auto
Float[] Property PardonEndTime Auto
Actor[] Property Guards Auto
Actor[] Property Teammates Auto

String Property SceneMain Auto
String Property SceneAdditional Auto
String Property Extra Auto


;MCM options

int _toggle_Retry
int _toggle_UseArousal

int _toggle_RejectSelection_Oral
int _slider_RejectBounty_Oral
int _slider_RejectFixed_Oral
int _toggle_PaymentSelection_Oral
int _slider_PaymentFixed_Oral
int _slider_PaymentBounty_Oral
int _slider_PardonTime_Oral

int _toggle_RejectSelection_Sex
int _slider_RejectBounty_Sex
int _slider_RejectFixed_Sex
int _toggle_PaymentSelection_Sex
int _slider_PaymentFixed_Sex
int _slider_PaymentBounty_Sex
int _slider_PardonTime_Sex

int _toggle_RejectSelection_Anal
int _slider_RejectBounty_Anal
int _slider_RejectFixed_Anal
int _toggle_PaymentSelection_Anal
int _slider_PaymentFixed_Anal
int _slider_PaymentBounty_Anal
int _slider_PardonTime_Anal

int _toggle_RejectSelection_Multiple
int _slider_RejectBounty_Multiple
int _slider_RejectFixed_Multiple
int _toggle_PaymentSelection_Multiple
int _slider_PaymentFixed_Multiple
int _slider_PaymentBounty_Multiple
int _slider_PardonTime_Multiple

Int _slider_SameGenderPenalty

int _slider_ActIncrease
float Property _sliderPercent_ActIncrease Auto
int _slider_TimeDecrease
float Property _sliderPercent_TimeDecrease Auto
float[] Property PSC_TimesPenalty Auto
float[] Property PSC_TimesPenaltyTracker Auto

int _slider_PardonEndPenaltyFixed
float Property _sliderPercent_PardonEndPenaltyFixed Auto
int _slider_PardonEndPenaltyBounty
float Property _sliderPercent_PardonEndPenaltyBounty Auto
int _toggle_PardonEndPenaltySelection
Bool Property PSC_PardonEndPenaltySelection Auto
int _slider_PardonedSexPercent
float Property _sliderPercent_PardonedSexPercent Auto
int _slider_PaymentPercent
float Property _sliderPercent_PaymentPercent Auto
int _slider_PardonPercent
float Property _sliderPercent_PardonPercent Auto
int _toggle_PardonAdd
Bool Property PSC_PardonAdd Auto

	;bounty change over time
int _slider_UpdatesPerDay
float Property _sliderPercent_UpdatesPerDay Auto
int _slider_PercentDrop
float Property _sliderPercent_PercentDrop Auto
int _slider_FixedDrop
float Property _sliderPercent_FixedDrop Auto
int _toggle_UseSettlements
Bool Property PSC_UseSettlements Auto
int _toggle_UseHolds
Bool Property PSC_UseHolds Auto



	;Approach
Bool Property PSC_AllowApproach Auto
int _toggle_AllowApproach
Int _slider_ApproachTriggerTime
Float Property _sliderPercent_ApproachTriggerTime Auto
Int _slider_ApproachTriggerChance
Float Property _sliderPercent_ApproachTriggerChance Auto
Int _slider_ApproachDelayMultiplier
Float Property _sliderPercent_ApproachDelayMultiplier Auto
Int _slider_ApproachTimeOut
Float Property _sliderPercent_ApproachTimeOut Auto
Int _toggle_UseApproachLocations
Bool Property PSC_UseApproachLocations Auto

int _slider_ApproachBounty
float Property _sliderPercent_ApproachBounty Auto
int _Slider_ApproachSexPercent
float Property _sliderPercent_ApproachSexPercent Auto
int _slider_ApproachRefusePenalty
float Property _sliderPercent_ApproachRefusePenalty Auto

Int Property ApproachTracker Auto
Int Property UpdateType Auto
Float Property ApproachStageDelay Auto	;in game hours


	;bounty collectors
int _slider_BCSexPercent
float Property _sliderPercent_BCSexPercent Auto
int _slider_BCPaymentPercent
float Property _sliderPercent_BCPaymentPercent Auto
int _slider_BCPardonPercent
float Property _sliderPercent_BCPardonPercent Auto
int _slider_BCPardonFixed
float Property _sliderPercent_BCPardonFixed Auto


event OnConfigInit()
	ModName = "PaySexCrime"
	Pages = new string[3]
	Pages[0] = "Options"
	Pages[1] = "Pardon"
	Pages[2] = "Extra"
	PSC_AllowRetry = true
	PSC_RejectSelection_Oral = True
	_sliderPercent_RejectBounty_Oral = 100.0
	_sliderPercent_RejectFixed_Oral = 25.0
	PSC_PaymentSelection_Oral = True
	_sliderPercent_PaymentFixed_Oral = 10.0
	_sliderPercent_PaymentBounty_Oral = 0.0
	_sliderPercent_PardonTime_Oral = 360.0

	PSC_RejectSelection_Sex = True
	_sliderPercent_RejectBounty_Sex = 800.0
	_sliderPercent_RejectFixed_Sex = 50.0
	PSC_PaymentSelection_Sex = True
	_sliderPercent_PaymentFixed_Sex = 80.0
	_sliderPercent_PaymentBounty_Sex = 0.0
	_sliderPercent_PardonTime_Sex = 720.0

	PSC_RejectSelection_Anal = True
	_sliderPercent_RejectBounty_Anal = 1600.0
	_sliderPercent_RejectFixed_Anal = 75.0
	PSC_PaymentSelection_Anal = True
	_sliderPercent_PaymentFixed_Anal = 160.0
	_sliderPercent_PaymentBounty_Anal = 0.0
	_sliderPercent_PardonTime_Anal = 1080.0

	PSC_RejectSelection_Multiple = True
	_sliderPercent_RejectBounty_Multiple = 2500.0
	_sliderPercent_RejectFixed_Multiple = 100.0
	PSC_PaymentSelection_Multiple = True
	_sliderPercent_PaymentFixed_Multiple = 250.0
	_sliderPercent_PaymentBounty_Multiple = 0.0
	_sliderPercent_PardonTime_Multiple = 1440.0

	_sliderPercent_SameGenderPenalty = 0.0

	_sliderPercent_ActIncrease = 0.0
	_sliderPercent_TimeDecrease = 4.0
	PSC_TimesPenalty = new float[10]
	PSC_TimesPenalty [0] = 100.0
	PSC_TimesPenalty [1] = 100.0
	PSC_TimesPenalty [2] = 100.0
	PSC_TimesPenalty [3] = 100.0
	PSC_TimesPenalty [4] = 100.0
	PSC_TimesPenalty [5] = 100.0
	PSC_TimesPenalty [6] = 100.0
	PSC_TimesPenalty [7] = 100.0
	PSC_TimesPenalty [8] = 100.0
	PSC_TimesPenalty [9] = 100.0
	PSC_TimesPenaltyTracker = new float[10]
	PSC_TimesPenaltyTracker [0] = 0.0
	PSC_TimesPenaltyTracker [1] = 0.0
	PSC_TimesPenaltyTracker [2] = 0.0
	PSC_TimesPenaltyTracker [3] = 0.0
	PSC_TimesPenaltyTracker [4] = 0.0
	PSC_TimesPenaltyTracker [5] = 0.0
	PSC_TimesPenaltyTracker [6] = 0.0
	PSC_TimesPenaltyTracker [7] = 0.0
	PSC_TimesPenaltyTracker [8] = 0.0
	PSC_TimesPenaltyTracker [9] = 0.0

	_sliderPercent_PardonEndPenaltyFixed = 40.0
	_sliderPercent_PardonEndPenaltyBounty = 25.0
	PSC_PardonEndPenaltySelection = true
	_sliderPercent_PardonedSexPercent = 100.0
	_sliderPercent_PaymentPercent = 100.0
	_sliderPercent_PardonPercent = 100.0
	PSC_PardonAdd = true

	PSC_UseArousal = False

	SuccessTracker = new int[10]
	SuccessTracker[0] = 0
	SuccessTracker[1] = 0
	SuccessTracker[2] = 0
	SuccessTracker[3] = 0
	SuccessTracker[4] = 0
	SuccessTracker[5] = 0
	SuccessTracker[6] = 0
	SuccessTracker[7] = 0
	SuccessTracker[8] = 0
	SuccessTracker[9] = 0
	BountyNonViolent = new int[10]
	BountyNonViolent[0] = 0
	BountyNonViolent[1] = 0
	BountyNonViolent[2] = 0
	BountyNonViolent[3] = 0
	BountyNonViolent[4] = 0
	BountyNonViolent[5] = 0
	BountyNonViolent[6] = 0
	BountyNonViolent[7] = 0
	BountyNonViolent[8] = 0
	BountyNonViolent[9] = 0
	BountyViolent = new int[10]
	BountyViolent[0] = 0
	BountyViolent[1] = 0
	BountyViolent[2] = 0
	BountyViolent[3] = 0
	BountyViolent[4] = 0
	BountyViolent[5] = 0
	BountyViolent[6] = 0
	BountyViolent[7] = 0
	BountyViolent[8] = 0
	BountyViolent[9] = 0
	PardonEndTime = new Float[10]
	PardonEndTime[0] = 0.0
	PardonEndTime[1] = 0.0
	PardonEndTime[2] = 0.0
	PardonEndTime[3] = 0.0
	PardonEndTime[4] = 0.0
	PardonEndTime[5] = 0.0
	PardonEndTime[6] = 0.0
	PardonEndTime[7] = 0.0
	PardonEndTime[8] = 0.0
	PardonEndTime[9] = 0.0
	Guards = new Actor[1]
	Teammates = new Actor[1]

	_sliderPercent_UpdatesPerDay = 0.0
	_sliderPercent_PercentDrop = 0.0
	_sliderPercent_FixedDrop = 0.0
	PSC_UseSettlements = False
	PSC_UseHolds = False

	;Approach
	PSC_AllowApproach = False

	_sliderPercent_ApproachTriggerTime = 60.0
	_sliderPercent_ApproachTriggerChance = 100.0
	_sliderPercent_ApproachDelayMultiplier = 96.0
	_sliderPercent_ApproachTimeOut = 720.0
	PSC_UseApproachLocations = True
	_sliderPercent_ApproachBounty = 100.0
	_sliderPercent_ApproachSexPercent = 200.0
	_sliderPercent_ApproachRefusePenalty = 1000.0
	ApproachTracker = 0
	UpdateType = 0
	ApproachStageDelay = 0.0

	;Bounty Collectors.
	_sliderPercent_BCSexPercent = 100.0
	_sliderPercent_BCPaymentPercent = 100.0
	_sliderPercent_BCPardonPercent = 100.0
	_sliderPercent_BCPardonFixed = 1440.0


endEvent

event OnPageReset(string a_page)
	if (a_page == "")

	elseif (a_page == "Options")
		SetCursorFillMode(TOP_TO_BOTTOM)
		_toggle_Retry  = AddToggleOption("Allow Retry", PSC_AllowRetry)
		SetCursorPosition(2)
		AddHeaderOption("Oral: Rejection Options")
		_toggle_RejectSelection_Oral = AddToggleOption("Rejection Selection", PSC_RejectSelection_Oral)
		_slider_RejectBounty_Oral = AddSliderOption("Bounty Based", _sliderPercent_RejectBounty_Oral, "At {0}")
		_slider_RejectFixed_Oral = AddSliderOption("Fixed Percentage", _sliderPercent_RejectFixed_Oral, "At {0}")
		SetCursorPosition(10)
		AddHeaderOption("Sex: Rejection Options")
		_toggle_RejectSelection_Sex = AddToggleOption("Rejection Selection", PSC_RejectSelection_Sex)
		_slider_RejectBounty_Sex = AddSliderOption("Bounty Based", _sliderPercent_RejectBounty_Sex, "At {0}")
		_slider_RejectFixed_Sex = AddSliderOption("Fixed Percentage", _sliderPercent_RejectFixed_Sex, "At {0}")
		SetCursorPosition(18)
		AddHeaderOption("Anal: Rejection Options")
		_toggle_RejectSelection_Anal = AddToggleOption("Rejection Selection", PSC_RejectSelection_Anal)
		_slider_RejectBounty_Anal = AddSliderOption("Bounty Based", _sliderPercent_RejectBounty_Anal, "At {0}")
		_slider_RejectFixed_Anal = AddSliderOption("Fixed Percentage", _sliderPercent_RejectFixed_Anal, "At {0}")
		SetCursorPosition(26)
		AddHeaderOption("Multple: Rejection Options")
		_toggle_RejectSelection_Multiple = AddToggleOption("Rejection Selection", PSC_RejectSelection_Multiple)
		_slider_RejectBounty_Multiple = AddSliderOption("Bounty Based", _sliderPercent_RejectBounty_Multiple, "At {0}")
		_slider_RejectFixed_Multiple = AddSliderOption("Fixed Percentage", _sliderPercent_RejectFixed_Multiple, "At {0}")
		SetCursorPosition(34)
		AddHeaderOption("Rejection Extras")
		_slider_SameGenderPenalty = AddSliderOption("Same Gender Penalty", _sliderPercent_SameGenderPenalty, "At {0}")
		_toggle_UseArousal  = AddToggleOption("Use Arousal", PSC_UseArousal)

		;Right column
		SetCursorPosition(3)
		AddHeaderOption("Oral: Payment Options")
		;_toggle_PaymentSelection_Oral = AddToggleOption("Payment Selection", PSC_PaymentSelection_Oral)
		_slider_PaymentFixed_Oral = AddSliderOption("Fixed Amount", _sliderPercent_PaymentFixed_Oral, "At {0}")
		_slider_PaymentBounty_Oral = AddSliderOption("Percentage Of Bounty", _sliderPercent_PaymentBounty_Oral, "At {0}")
		_slider_PardonTime_Oral = AddSliderOption("Pardon Time", _sliderPercent_PardonTime_Oral, "At {0}")
		SetCursorPosition(11)
		AddHeaderOption("Sex: Payment Options")
		;_toggle_PaymentSelection_Sex = AddToggleOption("Payment Selection", PSC_PaymentSelection_Sex)
		_slider_PaymentFixed_Sex = AddSliderOption("Fixed Amount", _sliderPercent_PaymentFixed_Sex, "At {0}")
		_slider_PaymentBounty_Sex = AddSliderOption("Percentage Of Bounty", _sliderPercent_PaymentBounty_Sex, "At {0}")
		_slider_PardonTime_Sex = AddSliderOption("Pardon Time", _sliderPercent_PardonTime_Sex, "At {0}")
		SetCursorPosition(19)
		AddHeaderOption("Anal: Payment Options")
		;_toggle_PaymentSelection_Anal = AddToggleOption("Payment Selection", PSC_PaymentSelection_Anal)
		_slider_PaymentFixed_Anal = AddSliderOption("Fixed Amount", _sliderPercent_PaymentFixed_Anal, "At {0}")
		_slider_PaymentBounty_Anal = AddSliderOption("Percentage Of Bounty", _sliderPercent_PaymentBounty_Anal, "At {0}")
		_slider_PardonTime_Anal = AddSliderOption("Pardon Time", _sliderPercent_PardonTime_Anal, "At {0}")
		SetCursorPosition(27)
		AddHeaderOption("Multiple: Payment Options")
		;_toggle_PaymentSelection_Multiple = AddToggleOption("Payment Selection", PSC_PaymentSelection_Multiple)
		_slider_PaymentFixed_Multiple = AddSliderOption("Fixed Amount", _sliderPercent_PaymentFixed_Multiple, "At {0}")
		_slider_PaymentBounty_Multiple = AddSliderOption("Percentage Of Bounty", _sliderPercent_PaymentBounty_Multiple, "At {0}")
		_slider_PardonTime_Multiple = AddSliderOption("Pardon Time", _sliderPercent_PardonTime_Multiple, "At {0}")
		SetCursorPosition(35)
		AddHeaderOption("Times And Timing Penalty")
		_slider_ActIncrease = AddSliderOption("Act increase penalty", _sliderPercent_ActIncrease, "At {0}")
		_slider_TimeDecrease = AddSliderOption("Time decreace penalty", _sliderPercent_TimeDecrease, "At {0}")
	
	elseif (a_page == "Pardon")
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("Faction --- Bounty --- Pardon")
		if (((BountyNonViolent[1] + BountyViolent[1]) > 0) && (CrimeFactionEastmarch.GetCrimeGold() == 0))
			if (PardonEndTime[1] - (Utility.GetCurrentGameTime() * 24) > 0)
				AddSliderOption("Eastmarch: " + (BountyNonViolent[1] + BountyViolent[1]) + ", " , (PardonEndTime[1] - (Utility.GetCurrentGameTime() * 24)), "{2}", OPTION_FLAG_DISABLED)
			else
				AddSliderOption("Eastmarch: " + (BountyNonViolent[1] + BountyViolent[1]) + ", " , 0.00, "{2}", OPTION_FLAG_DISABLED)
			endif
		elseif (((BountyNonViolent[1] + BountyViolent[1]) > 0) && (CrimeFactionEastmarch.GetCrimeGold() > 0))
			if (PardonEndTime[1] - (Utility.GetCurrentGameTime() * 24) > 0)
				AddSliderOption("Eastmarch: " + (BountyNonViolent[1] + BountyViolent[1]) + " (VOID!), " , (PardonEndTime[1] - (Utility.GetCurrentGameTime() * 24)), "{2}", OPTION_FLAG_DISABLED)
			else
				AddSliderOption("Eastmarch: " + (BountyNonViolent[1] + BountyViolent[1]) + " (VOID!), " , 0.00, "{2}", OPTION_FLAG_DISABLED)
			endif
		else
			AddSliderOption("Eastmarch: No Bounty" , 0.00, "{2}", OPTION_FLAG_DISABLED)
		endif
		if (((BountyNonViolent[2] + BountyViolent[2]) > 0) && (CrimeFactionFalkreath.GetCrimeGold() == 0))
			if (PardonEndTime[2] - (Utility.GetCurrentGameTime() * 24) > 0)
				AddSliderOption("Falkreath: " + (BountyNonViolent[2] + BountyViolent[2]) + ", " , (PardonEndTime[2] - (Utility.GetCurrentGameTime() * 24)), "{2}", OPTION_FLAG_DISABLED)
			else
				AddSliderOption("Falkreath: " + (BountyNonViolent[2] + BountyViolent[2]) + ", " , 0.00, "{2}", OPTION_FLAG_DISABLED)
			endif
		elseif (((BountyNonViolent[2] + BountyViolent[2]) > 0) && (CrimeFactionFalkreath.GetCrimeGold() > 0))
			if (PardonEndTime[2] - (Utility.GetCurrentGameTime() * 24) > 0)
				AddSliderOption("Falkreath: " + (BountyNonViolent[2] + BountyViolent[2]) + " (VOID!), " , (PardonEndTime[2] - (Utility.GetCurrentGameTime() * 24)), "{2}", OPTION_FLAG_DISABLED)
			else
				AddSliderOption("Falkreath: " + (BountyNonViolent[2] + BountyViolent[2]) + " (VOID!), " , 0.00, "{2}", OPTION_FLAG_DISABLED)
			endif
		else
			AddSliderOption("Falkreath: No Bounty" , 0.00, "{2}", OPTION_FLAG_DISABLED)
		endif
		if (((BountyNonViolent[3] + BountyViolent[3]) > 0) && (CrimeFactionHaafingar.GetCrimeGold() == 0))
			if (PardonEndTime[3] - (Utility.GetCurrentGameTime() * 24) > 0)
				AddSliderOption("Haafingar: " + (BountyNonViolent[3] + BountyViolent[3]) + ", " , (PardonEndTime[3] - (Utility.GetCurrentGameTime() * 24)), "{2}", OPTION_FLAG_DISABLED)
			else
				AddSliderOption("Haafingar: " + (BountyNonViolent[3] + BountyViolent[3]) + ", " , 0.00, "{2}", OPTION_FLAG_DISABLED)
			endif
		elseif (((BountyNonViolent[3] + BountyViolent[3]) > 0) && (CrimeFactionHaafingar.GetCrimeGold() > 0))
			if (PardonEndTime[3] - (Utility.GetCurrentGameTime() * 24) > 0)
				AddSliderOption("Haafingar: " + (BountyNonViolent[3] + BountyViolent[3]) + " (VOID!), " , (PardonEndTime[3] - (Utility.GetCurrentGameTime() * 24)), "{2}", OPTION_FLAG_DISABLED)
			else
				AddSliderOption("Haafingar: " + (BountyNonViolent[3] + BountyViolent[3]) + " (VOID!), " , 0.00, "{2}", OPTION_FLAG_DISABLED)
			endif
		else
			AddSliderOption("Haafingar: No Bounty" , 0.00, "{2}", OPTION_FLAG_DISABLED)
		endif
		if (((BountyNonViolent[4] + BountyViolent[4]) > 0) && (CrimeFactionHjaalmarch.GetCrimeGold() == 0))
			if (PardonEndTime[4] - (Utility.GetCurrentGameTime() * 24) > 0)
				AddSliderOption("Hjaalmarch: " + (BountyNonViolent[4] + BountyViolent[4]) + ", " , (PardonEndTime[4] - (Utility.GetCurrentGameTime() * 24)), "{2}", OPTION_FLAG_DISABLED)
			else
				AddSliderOption("Hjaalmarch: " + (BountyNonViolent[4] + BountyViolent[4]) + ", " , 0.00, "{2}", OPTION_FLAG_DISABLED)
			endif
		elseif (((BountyNonViolent[4] + BountyViolent[4]) > 0) && (CrimeFactionHjaalmarch.GetCrimeGold() > 0))
			if (PardonEndTime[4] - (Utility.GetCurrentGameTime() * 24) > 0)
				AddSliderOption("Hjaalmarch: " + (BountyNonViolent[4] + BountyViolent[4]) + " (VOID!), " , (PardonEndTime[4] - (Utility.GetCurrentGameTime() * 24)), "{2}", OPTION_FLAG_DISABLED)
			else
				AddSliderOption("Hjaalmarch: " + (BountyNonViolent[4] + BountyViolent[4]) + " (VOID!), " , 0.00, "{2}", OPTION_FLAG_DISABLED)
			endif
		else
			AddSliderOption("Hjaalmarch: No Bounty" , 0.00, "{2}", OPTION_FLAG_DISABLED)
		endif
		if (((BountyNonViolent[5] + BountyViolent[5]) > 0) && (CrimeFactionPale.GetCrimeGold() == 0))
			if (PardonEndTime[5] - (Utility.GetCurrentGameTime() * 24) > 0)
				AddSliderOption("Pale: " + (BountyNonViolent[5] + BountyViolent[5]) + ", " , (PardonEndTime[5] - (Utility.GetCurrentGameTime() * 24)), "{2}", OPTION_FLAG_DISABLED)
			else
				AddSliderOption("Pale: " + (BountyNonViolent[5] + BountyViolent[5]) + ", " , 0.00, "{2}", OPTION_FLAG_DISABLED)
			endif
		elseif (((BountyNonViolent[5] + BountyViolent[5]) > 0) && (CrimeFactionPale.GetCrimeGold() > 0))
			if (PardonEndTime[5] - (Utility.GetCurrentGameTime() * 24) > 0)
				AddSliderOption("Pale: " + (BountyNonViolent[5] + BountyViolent[5]) + " (VOID!), " , (PardonEndTime[5] - (Utility.GetCurrentGameTime() * 24)), "{2}", OPTION_FLAG_DISABLED)
			else
				AddSliderOption("Pale: " + (BountyNonViolent[5] + BountyViolent[5]) + " (VOID!), " , 0.00, "{2}", OPTION_FLAG_DISABLED)
			endif
		else
			AddSliderOption("Pale: No Bounty" , 0.00, "{2}", OPTION_FLAG_DISABLED)
		endif
		if (((BountyNonViolent[6] + BountyViolent[6]) > 0) && (CrimeFactionReach.GetCrimeGold() == 0))
			if (PardonEndTime[6] - (Utility.GetCurrentGameTime() * 24) > 0)
				AddSliderOption("Reach: " + (BountyNonViolent[6] + BountyViolent[6]) + ", " , (PardonEndTime[6] - (Utility.GetCurrentGameTime() * 24)), "{2}", OPTION_FLAG_DISABLED)
			else
				AddSliderOption("Reach: " + (BountyNonViolent[6] + BountyViolent[6]) + ", " , 0.00, "{2}", OPTION_FLAG_DISABLED)
			endif
		elseif (((BountyNonViolent[6] + BountyViolent[6]) > 0) && (CrimeFactionReach.GetCrimeGold() > 0))
			if (PardonEndTime[6] - (Utility.GetCurrentGameTime() * 24) > 0)
				AddSliderOption("Reach: " + (BountyNonViolent[6] + BountyViolent[6]) + " (VOID!), " , (PardonEndTime[6] - (Utility.GetCurrentGameTime() * 24)), "{2}", OPTION_FLAG_DISABLED)
			else
				AddSliderOption("Reach: " + (BountyNonViolent[6] + BountyViolent[6]) + " (VOID!), " , 0.00, "{2}", OPTION_FLAG_DISABLED)
			endif
		else
			AddSliderOption("Reach: No Bounty" , 0.00, "{2}", OPTION_FLAG_DISABLED)
		endif
		if (((BountyNonViolent[7] + BountyViolent[7]) > 0) && (CrimeFactionRift.GetCrimeGold() == 0))
			if (PardonEndTime[7] - (Utility.GetCurrentGameTime() * 24) > 0)
				AddSliderOption("Rift: " + (BountyNonViolent[7] + BountyViolent[7]) + ", " , (PardonEndTime[7] - (Utility.GetCurrentGameTime() * 24)), "{2}", OPTION_FLAG_DISABLED)
			else
				AddSliderOption("Rift: " + (BountyNonViolent[7] + BountyViolent[7]) + ", " , 0.00, "{2}", OPTION_FLAG_DISABLED)
			endif
		elseif (((BountyNonViolent[7] + BountyViolent[7]) > 0) && (CrimeFactionRift.GetCrimeGold() > 0))
			if (PardonEndTime[7] - (Utility.GetCurrentGameTime() * 24) > 0)
				AddSliderOption("Rift: " + (BountyNonViolent[7] + BountyViolent[7]) + " (VOID!), " , (PardonEndTime[7] - (Utility.GetCurrentGameTime() * 24)), "{2}", OPTION_FLAG_DISABLED)
			else
				AddSliderOption("Rift: " + (BountyNonViolent[7] + BountyViolent[7]) + " (VOID!), " , 0.00, "{2}", OPTION_FLAG_DISABLED)
			endif
		else
			AddSliderOption("Rift: No Bounty" , 0.00, "{2}", OPTION_FLAG_DISABLED)
		endif
		if (((BountyNonViolent[8] + BountyViolent[8]) > 0) && (CrimeFactionWhiterun.GetCrimeGold() == 0))
			if (PardonEndTime[8] - (Utility.GetCurrentGameTime() * 24) > 0)
				AddSliderOption("Whiterun: " + (BountyNonViolent[8] + BountyViolent[8]) + ", " , (PardonEndTime[8] - (Utility.GetCurrentGameTime() * 24)), "{2}", OPTION_FLAG_DISABLED)
			else
				AddSliderOption("Whiterun: " + (BountyNonViolent[8] + BountyViolent[8]) + ", " , 0.00 , "{2}", OPTION_FLAG_DISABLED)
			endif
		elseif (((BountyNonViolent[8] + BountyViolent[8]) > 0) && (CrimeFactionWhiterun.GetCrimeGold() > 0))
			if (PardonEndTime[8] - (Utility.GetCurrentGameTime() * 24) > 0)
				AddSliderOption("Whiterun: " + (BountyNonViolent[8] + BountyViolent[8]) + " (VOID!), " , (PardonEndTime[8] - (Utility.GetCurrentGameTime() * 24)), "{2}", OPTION_FLAG_DISABLED)
			else
				AddSliderOption("Whiterun: " + (BountyNonViolent[8] + BountyViolent[8]) + " (VOID!), " , 0.00 , "{2}", OPTION_FLAG_DISABLED)
			endif
		else
			AddSliderOption("Whiterun: No Bounty" , 0.00, "{2}", OPTION_FLAG_DISABLED)
		endif
		if (((BountyNonViolent[9] + BountyViolent[9]) > 0) && (CrimeFactionWinterhold.GetCrimeGold() == 0))
			if (PardonEndTime[9] - (Utility.GetCurrentGameTime() * 24) > 0)
				AddSliderOption("Winterhold: " + (BountyNonViolent[9] + BountyViolent[9]) + ", " , (PardonEndTime[9] - (Utility.GetCurrentGameTime() * 24)), "{2}", OPTION_FLAG_DISABLED)
			else
				AddSliderOption("Winterhold: " + (BountyNonViolent[9] + BountyViolent[9]) + ", " , 0.00, "{2}", OPTION_FLAG_DISABLED)
			endif
		elseif (((BountyNonViolent[9] + BountyViolent[9]) > 0) && (CrimeFactionWinterhold.GetCrimeGold() > 0))
			if (PardonEndTime[9] - (Utility.GetCurrentGameTime() * 24) > 0)
				AddSliderOption("Winterhold: " + (BountyNonViolent[9] + BountyViolent[9]) + " (VOID!), " , (PardonEndTime[9] - (Utility.GetCurrentGameTime() * 24)), "{2}", OPTION_FLAG_DISABLED)
			else
				AddSliderOption("Winterhold: " + (BountyNonViolent[9] + BountyViolent[9]) + " (VOID!), " , 0.00, "{2}", OPTION_FLAG_DISABLED)
			endif
		else
			AddSliderOption("Winterhold: No Bounty" , 0.00, "{2}", OPTION_FLAG_DISABLED)
		endif
		if ((BountyNonViolent[0] + BountyViolent[0]) > 0)
			if (PardonEndTime[0] - (Utility.GetCurrentGameTime() * 24) > 0)
				AddSliderOption("Other: " + (BountyNonViolent[0] + BountyViolent[0]) + ", " , (PardonEndTime[0] - (Utility.GetCurrentGameTime() * 24)), "{2}", OPTION_FLAG_DISABLED)
			else
				AddSliderOption("Other: " + (BountyNonViolent[0] + BountyViolent[0]) + ", " , 0.00, "{2}", OPTION_FLAG_DISABLED)
			endif
		else
			AddSliderOption("Other: No Bounty" , 0.00, "{2}", OPTION_FLAG_DISABLED)
		endif

		;Right column
		SetCursorPosition(1)
		AddHeaderOption("Pardon End Penalty")
		_toggle_PardonEndPenaltySelection  = AddToggleOption("Selection", PSC_PardonEndPenaltySelection)
		_slider_PardonEndPenaltyFixed = AddSliderOption("Fixed Amount", _sliderPercent_PardonEndPenaltyFixed, "At {0}")
		_slider_PardonEndPenaltyBounty = AddSliderOption("Percentage Of Bounty", _sliderPercent_PardonEndPenaltyBounty, "At {0}")
		AddHeaderOption("While Pardoned Options")
		_Slider_PardonedSexPercent  = AddSliderOption("Percent of accept chance", _sliderPercent_PardonedSexPercent, "At {0}")
		_slider_PaymentPercent = AddSliderOption("Percent of standard payment", _sliderPercent_PaymentPercent, "At {0}")
		_slider_PardonPercent = AddSliderOption("Percent of standard pardon time", _sliderPercent_PardonPercent, "At {0}")
		_toggle_PardonAdd  = AddToggleOption("Add to pardon or reset pardon", PSC_PardonAdd)
		AddHeaderOption("Bounty Change Over Time")
		_Slider_UpdatesPerDay  = AddSliderOption("Updates per day", _sliderPercent_UpdatesPerDay, "At {0}")
		_Slider_PercentDrop  = AddSliderOption("Percent of bounty", _sliderPercent_PercentDrop, "At {0}")
		_slider_FixedDrop = AddSliderOption("Fixed amount", _sliderPercent_FixedDrop, "At {0}")
		_toggle_UseSettlements  = AddToggleOption("Avoid primary settlements?", PSC_UseSettlements)
		_toggle_UseHolds  = AddToggleOption("Avoid entire holds?", PSC_UseHolds)

	elseif (a_page == "Extra")
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("Guard Approach")
		_toggle_AllowApproach  = AddToggleOption("Approach On", PSC_AllowApproach)
		_slider_ApproachTriggerTime = AddSliderOption("Trigger time.", _sliderPercent_ApproachTriggerTime, "At {0}")
		_slider_ApproachDelayMultiplier = AddSliderOption("Delay multiplier.", _sliderPercent_ApproachDelayMultiplier, "At {0}")
		_slider_ApproachTriggerChance = AddSliderOption("Trigger chance.", _sliderPercent_ApproachTriggerChance, "At {0}")
		_slider_ApproachTimeOut = AddSliderOption("Approach timeout.", _sliderPercent_ApproachTimeOut, "At {0}")
		_toggle_UseApproachLocations  = AddToggleOption("Approach locations", PSC_UseApproachLocations)
		_slider_ApproachBounty = AddSliderOption("Approach difficulty.", _sliderPercent_ApproachBounty, "At {0}")
		_Slider_ApproachSexPercent  = AddSliderOption("Percent of accept chance.", _sliderPercent_ApproachSexPercent, "At {0}")
		_Slider_ApproachRefusePenalty  = AddSliderOption("Refusal penalty.", _sliderPercent_ApproachRefusePenalty, "At {0}")

		;Right column
		SetCursorPosition(1)
		AddHeaderOption("Bounty Collectors")
		_Slider_BCSexPercent  = AddSliderOption("Percent of accept chance", _sliderPercent_BCSexPercent, "At {0}")
		_slider_BCPaymentPercent = AddSliderOption("Percent of standard payment", _sliderPercent_BCPaymentPercent, "At {0}")
		_slider_BCPardonPercent = AddSliderOption("Percent of standard pardon time", _sliderPercent_BCPardonPercent, "At {0}")
		_slider_BCPardonFixed = AddSliderOption("Additional pardon time", _sliderPercent_BCPardonFixed, "At {0}")

	endif
endEvent

Event OnOptionSelect(int option)
	if (option == _toggle_Retry)
		if (PSC_AllowRetry)
			PSC_AllowRetry = false
			SetToggleOptionValue(_toggle_Retry, false)
		else
			PSC_AllowRetry = true
			SetToggleOptionValue(_toggle_Retry, true)
		endIf
	elseif (option == _toggle_RejectSelection_Oral)
		if (PSC_RejectSelection_Oral)
			PSC_RejectSelection_Oral = false
			SetToggleOptionValue(_toggle_RejectSelection_Oral, false)
		else
			PSC_RejectSelection_Oral = true
			SetToggleOptionValue(_toggle_RejectSelection_Oral, true)
		endIf
	;elseif (option == _toggle_PaymentSelection_Oral)
	;	if (PSC_PaymentSelection_Oral)
	;		PSC_PaymentSelection_Oral = false
	;		SetToggleOptionValue(_toggle_PaymentSelection_Oral, false)
	;	else
	;		PSC_PaymentSelection_Oral = true
	;		SetToggleOptionValue(_toggle_PaymentSelection_Oral, true)
	;	endIf
	elseif (option == _toggle_RejectSelection_Sex)
		if (PSC_RejectSelection_Sex)
			PSC_RejectSelection_Sex = false
			SetToggleOptionValue(_toggle_RejectSelection_Sex, false)
		else
			PSC_RejectSelection_Sex = true
			SetToggleOptionValue(_toggle_RejectSelection_Sex, true)
		endIf
	;elseif (option == _toggle_PaymentSelection_Sex)
	;	if (PSC_PaymentSelection_Sex)
	;		PSC_PaymentSelection_Sex = false
	;		SetToggleOptionValue(_toggle_PaymentSelection_Sex, false)
	;	else
	;		PSC_PaymentSelection_Sex = true
	;		SetToggleOptionValue(_toggle_PaymentSelection_Sex, true)
	;	endIf
	elseif (option == _toggle_RejectSelection_Anal)
		if (PSC_RejectSelection_Anal)
			PSC_RejectSelection_Anal = false
			SetToggleOptionValue(_toggle_RejectSelection_Anal, false)
		else
			PSC_RejectSelection_Anal = true
			SetToggleOptionValue(_toggle_RejectSelection_Anal, true)
		endIf
	;elseif (option == _toggle_PaymentSelection_Anal)
	;	if (PSC_PaymentSelection_Anal)
	;		PSC_PaymentSelection_Anal = false
	;		SetToggleOptionValue(_toggle_PaymentSelection_Anal, false)
	;	else
	;		PSC_PaymentSelection_Anal = true
	;		SetToggleOptionValue(_toggle_PaymentSelection_Anal, true)
	;	endIf
	elseif (option == _toggle_RejectSelection_Multiple)
		if (PSC_RejectSelection_Multiple)
			PSC_RejectSelection_Multiple = false
			SetToggleOptionValue(_toggle_RejectSelection_Multiple, false)
		else
			PSC_RejectSelection_Multiple = true
			SetToggleOptionValue(_toggle_RejectSelection_Multiple, true)
		endIf
	;elseif (option == _toggle_PaymentSelection_Multiple)
	;	if (PSC_PaymentSelection_Multiple)
	;		PSC_PaymentSelection_Multiple = false
	;		SetToggleOptionValue(_toggle_PaymentSelection_Multiple, false)
	;	else
	;		PSC_PaymentSelection_Multiple = true
	;		SetToggleOptionValue(_toggle_PaymentSelection_Multiple, true)
	;	endIf
	elseif (option == _toggle_UseArousal)
		if (PSC_UseArousal)
			PSC_UseArousal = false
			SetToggleOptionValue(_toggle_UseArousal, false)
		else
			PSC_UseArousal = true
			SetToggleOptionValue(_toggle_UseArousal, true)
		endIf
	elseif (option == _toggle_PardonEndPenaltySelection)
		if (PSC_PardonEndPenaltySelection)
			PSC_PardonEndPenaltySelection = false
			SetToggleOptionValue(_toggle_PardonEndPenaltySelection, false)
		else
			PSC_PardonEndPenaltySelection = true
			SetToggleOptionValue(_toggle_PardonEndPenaltySelection, true)
		endIf
	elseif (option == _toggle_PardonAdd)
		if (PSC_PardonAdd)
			PSC_PardonAdd = false
			SetToggleOptionValue(_toggle_PardonAdd, false)
		else
			PSC_PardonAdd = true
			SetToggleOptionValue(_toggle_PardonAdd, true)
		endIf
	elseif (option == _toggle_UseSettlements)
		if (PSC_UseSettlements)
			PSC_UseSettlements = false
			SetToggleOptionValue(_toggle_UseSettlements, false)
		else
			PSC_UseSettlements = true
			SetToggleOptionValue(_toggle_UseSettlements, true)
		endIf
	elseif (option == _toggle_UseHolds)
		if (PSC_UseHolds)
			PSC_UseHolds = false
			SetToggleOptionValue(_toggle_UseHolds, false)
		else
			PSC_UseHolds = true
			SetToggleOptionValue(_toggle_UseHolds, true)
		endIf

	elseif (option == _toggle_AllowApproach)
		if (PSC_AllowApproach)
			PSC_AllowApproach = false
			SetToggleOptionValue(_toggle_AllowApproach, false)
			ApproachStart.StopApproach()
			ApproachStart.StopRun()
		else
			PSC_AllowApproach = true
			SetToggleOptionValue(_toggle_AllowApproach, true)
			If (PSC_UseApproachLocations)
				If (QuestScript.IsApprovedLocation(Game.GetPlayer().GetCurrentLocation()))
					ApproachStart.StageOne()
				EndIf
			Else
				ApproachStart.StageOne()
			EndIf
		endIf
	elseif (option == _toggle_UseApproachLocations)
		if (PSC_UseApproachLocations)
			PSC_UseApproachLocations = false
			SetToggleOptionValue(_toggle_UseApproachLocations, false)
			If (PSC_AllowApproach)
				ApproachStart.StageOne()
			EndIf
		else
			PSC_UseApproachLocations = true
			SetToggleOptionValue(_toggle_UseApproachLocations, true)
			If !(QuestScript.IsApprovedLocation(Game.GetPlayer().GetCurrentLocation()))
				ApproachStart.StopApproach()
			EndIf
		endIf
	endif
endEvent

event OnOptionSliderOpen(int a_option)
	if (a_option == _slider_RejectBounty_Oral)
		SetSliderDialogStartValue(_sliderPercent_RejectBounty_Oral)
		SetSliderDialogDefaultValue(100)
		SetSliderDialogRange(0, 100000)
		SetSliderDialogInterval(10)
	elseif (a_option == _slider_RejectFixed_Oral)
		SetSliderDialogStartValue(_sliderPercent_RejectFixed_Oral)
		SetSliderDialogDefaultValue(25)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	elseif (a_option == _slider_PaymentFixed_Oral)
		SetSliderDialogStartValue(_sliderPercent_PaymentFixed_Oral)
		SetSliderDialogDefaultValue(10)
		SetSliderDialogRange(0, 100000)
		SetSliderDialogInterval(10)
	elseif (a_option == _slider_PaymentBounty_Oral)
		SetSliderDialogStartValue(_sliderPercent_PaymentBounty_Oral)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	elseif (a_option == _slider_PardonTime_Oral)
		SetSliderDialogStartValue(_sliderPercent_PardonTime_Oral)
		SetSliderDialogDefaultValue(360)
		SetSliderDialogRange(0, 10080)
		SetSliderDialogInterval(1)

	elseif (a_option == _slider_RejectBounty_Sex)
		SetSliderDialogStartValue(_sliderPercent_RejectBounty_Sex)
		SetSliderDialogDefaultValue(800)
		SetSliderDialogRange(0, 100000)
		SetSliderDialogInterval(10)
	elseif (a_option == _slider_RejectFixed_Sex)
		SetSliderDialogStartValue(_sliderPercent_RejectFixed_Sex)
		SetSliderDialogDefaultValue(50)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	elseif (a_option == _slider_PaymentFixed_Sex)
		SetSliderDialogStartValue(_sliderPercent_PaymentFixed_Sex)
		SetSliderDialogDefaultValue(80)
		SetSliderDialogRange(0, 100000)
		SetSliderDialogInterval(10)
	elseif (a_option == _slider_PaymentBounty_Sex)
		SetSliderDialogStartValue(_sliderPercent_PaymentBounty_Sex)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	elseif (a_option == _slider_PardonTime_Sex)
		SetSliderDialogStartValue(_sliderPercent_PardonTime_Sex)
		SetSliderDialogDefaultValue(720)
		SetSliderDialogRange(0, 10080)
		SetSliderDialogInterval(1)

	elseif (a_option == _slider_RejectBounty_Anal)
		SetSliderDialogStartValue(_sliderPercent_RejectBounty_Anal)
		SetSliderDialogDefaultValue(1600)
		SetSliderDialogRange(0, 100000)
		SetSliderDialogInterval(10)
	elseif (a_option == _slider_RejectFixed_Anal)
		SetSliderDialogStartValue(_sliderPercent_RejectFixed_Anal)
		SetSliderDialogDefaultValue(75)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	elseif (a_option == _slider_PaymentFixed_Anal)
		SetSliderDialogStartValue(_sliderPercent_PaymentFixed_Anal)
		SetSliderDialogDefaultValue(160)
		SetSliderDialogRange(0, 100000)
		SetSliderDialogInterval(10)
	elseif (a_option == _slider_PaymentBounty_Anal)
		SetSliderDialogStartValue(_sliderPercent_PaymentBounty_Anal)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	elseif (a_option == _slider_PardonTime_Anal)
		SetSliderDialogStartValue(_sliderPercent_PardonTime_Anal)
		SetSliderDialogDefaultValue(1080)
		SetSliderDialogRange(0, 10080)
		SetSliderDialogInterval(1)

	elseif (a_option == _slider_RejectBounty_Multiple)
		SetSliderDialogStartValue(_sliderPercent_RejectBounty_Multiple)
		SetSliderDialogDefaultValue(2500)
		SetSliderDialogRange(0, 100000)
		SetSliderDialogInterval(10)
	elseif (a_option == _slider_RejectFixed_Multiple)
		SetSliderDialogStartValue(_sliderPercent_RejectFixed_Multiple)
		SetSliderDialogDefaultValue(100)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	elseif (a_option == _slider_PaymentFixed_Multiple)
		SetSliderDialogStartValue(_sliderPercent_PaymentFixed_Multiple)
		SetSliderDialogDefaultValue(250)
		SetSliderDialogRange(0, 100000)
		SetSliderDialogInterval(10)
	elseif (a_option == _slider_PaymentBounty_Multiple)
		SetSliderDialogStartValue(_sliderPercent_PaymentBounty_Multiple)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	elseif (a_option == _slider_PardonTime_Multiple)
		SetSliderDialogStartValue(_sliderPercent_PardonTime_Multiple)
		SetSliderDialogDefaultValue(1440)
		SetSliderDialogRange(0, 10080)
		SetSliderDialogInterval(1)

	elseif (a_option == _slider_SameGenderPenalty)
		SetSliderDialogStartValue(_sliderPercent_SameGenderPenalty)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)

	elseif (a_option == _slider_ActIncrease)
		SetSliderDialogStartValue(_sliderPercent_ActIncrease)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	elseif (a_option == _slider_TimeDecrease)
		SetSliderDialogStartValue(_sliderPercent_TimeDecrease)
		SetSliderDialogDefaultValue(4)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)

	elseif (a_option == _slider_PardonEndPenaltyFixed)
		SetSliderDialogStartValue(_sliderPercent_PardonEndPenaltyFixed)
		SetSliderDialogDefaultValue(40)
		SetSliderDialogRange(0, 100000)
		SetSliderDialogInterval(10)
	elseif (a_option == _slider_PardonEndPenaltyBounty)
		SetSliderDialogStartValue(_sliderPercent_PardonEndPenaltyBounty)
		SetSliderDialogDefaultValue(25)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	elseif (a_option == _slider_PardonedSexPercent)
		SetSliderDialogStartValue(_sliderPercent_PardonedSexPercent)
		SetSliderDialogDefaultValue(100)
		SetSliderDialogRange(0, 200)
		SetSliderDialogInterval(1)
	elseif (a_option == _slider_PaymentPercent)
		SetSliderDialogStartValue(_sliderPercent_PaymentPercent)
		SetSliderDialogDefaultValue(100)
		SetSliderDialogRange(0, 200)
		SetSliderDialogInterval(1)
	elseif (a_option == _slider_PardonPercent)
		SetSliderDialogStartValue(_sliderPercent_PardonPercent)
		SetSliderDialogDefaultValue(100)
		SetSliderDialogRange(0, 200)
		SetSliderDialogInterval(1)

	elseif (a_option == _slider_UpdatesPerDay)
		SetSliderDialogStartValue(_sliderPercent_UpdatesPerDay)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 4)
		SetSliderDialogInterval(1)
	elseif (a_option == _slider_PercentDrop)
		SetSliderDialogStartValue(_sliderPercent_PercentDrop)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(-100, 100)
		SetSliderDialogInterval(1)
	elseif (a_option == _slider_FixedDrop)
		SetSliderDialogStartValue(_sliderPercent_FixedDrop)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(-100, 100)
		SetSliderDialogInterval(1)

	;Approach.
	elseif (a_option == _slider_ApproachTriggerTime)
		SetSliderDialogStartValue(_sliderPercent_ApproachTriggerTime)
		SetSliderDialogDefaultValue(60)
		SetSliderDialogRange(0, 7200)
		SetSliderDialogInterval(10)
	elseif (a_option == _slider_ApproachTriggerChance)
		SetSliderDialogStartValue(_sliderPercent_ApproachTriggerChance)
		SetSliderDialogDefaultValue(100)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	elseif (a_option == _slider_ApproachDelayMultiplier)
		SetSliderDialogStartValue(_sliderPercent_ApproachDelayMultiplier)
		SetSliderDialogDefaultValue(96)
		SetSliderDialogRange(0, 500)
		SetSliderDialogInterval(1)
	elseif (a_option == _slider_ApproachTimeOut)
		SetSliderDialogStartValue(_sliderPercent_ApproachTimeOut)
		SetSliderDialogDefaultValue(720)
		SetSliderDialogRange(0, 14400)
		SetSliderDialogInterval(10)
	elseif (a_option == _slider_ApproachBounty)
		SetSliderDialogStartValue(_sliderPercent_ApproachBounty)
		SetSliderDialogDefaultValue(100)
		SetSliderDialogRange(0, 100000)
		SetSliderDialogInterval(10)
	elseif (a_option == _slider_ApproachSexPercent)
		SetSliderDialogStartValue(_sliderPercent_ApproachSexPercent)
		SetSliderDialogDefaultValue(200)
		SetSliderDialogRange(0, 500)
		SetSliderDialogInterval(1)
	elseif (a_option == _slider_ApproachRefusePenalty)
		SetSliderDialogStartValue(_sliderPercent_ApproachRefusePenalty)
		SetSliderDialogDefaultValue(1000)
		SetSliderDialogRange(0, 100000)
		SetSliderDialogInterval(10)

	;Bounty collector
	elseif (a_option == _slider_BCSexPercent)
		SetSliderDialogStartValue(_sliderPercent_BCSexPercent)
		SetSliderDialogDefaultValue(100)
		SetSliderDialogRange(0, 200)
		SetSliderDialogInterval(1)
	elseif (a_option == _slider_BCPaymentPercent)
		SetSliderDialogStartValue(_sliderPercent_BCPaymentPercent)
		SetSliderDialogDefaultValue(100)
		SetSliderDialogRange(0, 200)
		SetSliderDialogInterval(1)
	elseif (a_option == _slider_BCPardonPercent)
		SetSliderDialogStartValue(_sliderPercent_BCPardonPercent)
		SetSliderDialogDefaultValue(100)
		SetSliderDialogRange(0, 200)
		SetSliderDialogInterval(1)
	elseif (a_option == _slider_BCPardonFixed)
		SetSliderDialogStartValue(_sliderPercent_BCPardonFixed)
		SetSliderDialogDefaultValue(1440)
		SetSliderDialogRange(0, 10080)
		SetSliderDialogInterval(1)

	endIf
endEvent

event OnOptionSliderAccept(int a_option, Float a_value)
	if (a_option == _slider_RejectBounty_Oral)
		_sliderPercent_RejectBounty_Oral = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")
	elseif (a_option == _slider_RejectFixed_Oral)
		_sliderPercent_RejectFixed_Oral = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")
	elseif (a_option == _slider_PaymentFixed_Oral)
		_sliderPercent_PaymentFixed_Oral = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")
	elseif (a_option == _slider_PaymentBounty_Oral)
		_sliderPercent_PaymentBounty_Oral = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")
	elseif (a_option == _slider_PardonTime_Oral)
		_sliderPercent_PardonTime_Oral = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")

	elseif (a_option == _slider_RejectBounty_Sex)
		_sliderPercent_RejectBounty_Sex = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")
	elseif (a_option == _slider_RejectFixed_Sex)
		_sliderPercent_RejectFixed_Sex = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")
	elseif (a_option == _slider_PaymentFixed_Sex)
		_sliderPercent_PaymentFixed_Sex = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")
	elseif (a_option == _slider_PaymentBounty_Sex)
		_sliderPercent_PaymentBounty_Sex = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")
	elseif (a_option == _slider_PardonTime_Sex)
		_sliderPercent_PardonTime_Sex = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")

	elseif (a_option == _slider_RejectBounty_Anal)
		_sliderPercent_RejectBounty_Anal = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")
	elseif (a_option == _slider_RejectFixed_Anal)
		_sliderPercent_RejectFixed_Anal = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")
	elseif (a_option == _slider_PaymentFixed_Anal)
		_sliderPercent_PaymentFixed_Anal = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")
	elseif (a_option == _slider_PaymentBounty_Anal)
		_sliderPercent_PaymentBounty_Anal = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")
	elseif (a_option == _slider_PardonTime_Anal)
		_sliderPercent_PardonTime_Anal = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")

	elseif (a_option == _slider_RejectBounty_Multiple)
		_sliderPercent_RejectBounty_Multiple = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")
	elseif (a_option == _slider_RejectFixed_Multiple)
		_sliderPercent_RejectFixed_Multiple = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")
	elseif (a_option == _slider_PaymentFixed_Multiple)
		_sliderPercent_PaymentFixed_Multiple = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")
	elseif (a_option == _slider_PaymentBounty_Multiple)
		_sliderPercent_PaymentBounty_Multiple = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")
	elseif (a_option == _slider_PardonTime_Multiple)
		_sliderPercent_PardonTime_Multiple = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")

	elseif (a_option == _slider_SameGenderPenalty)
		_sliderPercent_SameGenderPenalty = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")

	elseif (a_option == _slider_ActIncrease)
		_sliderPercent_ActIncrease = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")
	elseif (a_option == _slider_TimeDecrease)
		_sliderPercent_TimeDecrease = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")

	elseif (a_option == _slider_PardonEndPenaltyFixed)
		_sliderPercent_PardonEndPenaltyFixed = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")
	elseif (a_option == _slider_PardonEndPenaltyBounty)
		_sliderPercent_PardonEndPenaltyBounty = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")
	elseif (a_option == _slider_PardonedSexPercent)
		_sliderPercent_PardonedSexPercent = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")
	elseif (a_option == _slider_PaymentPercent)
		_sliderPercent_PaymentPercent = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")
	elseif (a_option == _slider_PardonPercent)
		_sliderPercent_PardonPercent = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")

	elseif (a_option == _slider_UpdatesPerDay)
		_sliderPercent_UpdatesPerDay = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")
		BountyDecayScript.RegisterUpdateTime()	;register for new update time
	elseif (a_option == _slider_PercentDrop)
		_sliderPercent_PercentDrop = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")
	elseif (a_option == _slider_FixedDrop)
		_sliderPercent_FixedDrop = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")

	;Approach.
	elseif (a_option == _slider_ApproachTriggerTime)
		_sliderPercent_ApproachTriggerTime = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")
	elseif (a_option == _slider_ApproachTriggerChance)
		_sliderPercent_ApproachTriggerChance = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")
	elseif (a_option == _slider_ApproachDelayMultiplier)
		_sliderPercent_ApproachDelayMultiplier = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")
	elseif (a_option == _slider_ApproachTimeOut)
		_sliderPercent_ApproachTimeOut = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")
	elseif (a_option == _slider_ApproachBounty)
		_sliderPercent_ApproachBounty = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")
	elseif (a_option == _slider_ApproachSexPercent)
		_sliderPercent_ApproachSexPercent = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")
	elseif (a_option == _slider_ApproachRefusePenalty)
		_sliderPercent_ApproachRefusePenalty = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")

	;bounty collector.
	elseif (a_option == _slider_BCSexPercent)
		_sliderPercent_BCSexPercent = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")
	elseif (a_option == _slider_BCPaymentPercent)
		_sliderPercent_BCPaymentPercent = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")
	elseif (a_option == _slider_BCPardonPercent)
		_sliderPercent_BCPardonPercent = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")
	elseif (a_option == _slider_BCPardonFixed)
		_sliderPercent_BCPardonFixed = a_value
		SetSliderOptionValue(a_option, a_value, "At {0}")


	endIf
endEvent

event OnOptionHighlight(int option)
	if (option == _toggle_Retry)
		SetInfoText("Active: Allows multiple attempts.")
	elseIf (option == _toggle_RejectSelection_Oral)
		SetInfoText("Active: Uses bounty based rejection.   Deactive: Uses fixed pecentage Rejection.")
	elseIf (option == _toggle_PaymentSelection_Oral)
		SetInfoText("Active: Uses fixed amount payment.   Deactive: Uses percent of bounty as payment.")
	elseIf (option == _toggle_RejectSelection_Sex)
		SetInfoText("Active: Uses bounty based rejection.   Deactive: Uses fixed pecentage Rejection.")
	elseIf (option == _toggle_PaymentSelection_Sex)
		SetInfoText("Active: Uses fixed amount payment.   Deactive: Uses percent of bounty as payment.")
	elseIf (option == _toggle_RejectSelection_Anal)
		SetInfoText("Active: Uses bounty based rejection.   Deactive: Uses fixed pecentage Rejection.")
	elseIf (option == _toggle_PaymentSelection_Anal)
		SetInfoText("Active: Uses fixed amount payment.   Deactive: Uses percent of bounty as payment.")
	elseIf (option == _toggle_RejectSelection_Multiple)
		SetInfoText("Active: Uses bounty based rejection.   Deactive: Uses fixed pecentage Rejection.")
	elseIf (option == _toggle_PaymentSelection_Multiple)
		SetInfoText("Active: Uses fixed amount payment.   Deactive: Uses percent of bounty as payment.")
	elseIf (option == _toggle_UseArousal)
		SetInfoText("Active: Guards arousal affects rejection (when using bounty based rejection). (Uses SexLab Aroused)")
	elseIf (option == _slider_RejectBounty_Oral)
		SetInfoText("The value of the act. Bounties higher than this will be less successful, While bounties lower will be more successful.")
	elseIf (option == _slider_RejectBounty_Sex)
		SetInfoText("The value of the act. Bounties higher than this will be less successful, While bounties lower will be more successful.")
	elseIf (option == _slider_RejectBounty_Anal)
		SetInfoText("The value of the act. Bounties higher than this will be less successful, While bounties lower will be more successful.")
	elseIf (option == _slider_RejectBounty_Multiple)
		SetInfoText("The value of the act. Bounties higher than this will be less successful, While bounties lower will be more successful.")
	elseIf (option == _slider_RejectFixed_Oral)
		SetInfoText("The chance of the attempt being accepted.")
	elseIf (option == _slider_RejectFixed_Sex)
		SetInfoText("The chance of the attempt being accepted.")
	elseIf (option == _slider_RejectFixed_Anal)
		SetInfoText("The chance of the attempt being accepted.")
	elseIf (option == _slider_RejectFixed_Multiple)
		SetInfoText("The chance of the attempt being accepted.")
	elseIf (option == _slider_PaymentFixed_Oral)
		SetInfoText("The Amount removed from the bounty.")
	elseIf (option == _slider_PaymentFixed_Sex)
		SetInfoText("The Amount removed from the bounty.")
	elseIf (option == _slider_PaymentFixed_Anal)
		SetInfoText("The Amount removed from the bounty.")
	elseIf (option == _slider_PaymentFixed_Multiple)
		SetInfoText("The Amount removed from the bounty.")
	elseIf (option == _slider_PaymentBounty_Oral)
		SetInfoText("The pecentage of the bounty removed.")
	elseIf (option == _slider_PaymentBounty_Sex)
		SetInfoText("The pecentage of the bounty removed.")
	elseIf (option == _slider_PaymentBounty_Anal)
		SetInfoText("The pecentage of the bounty removed.")
	elseIf (option == _slider_PaymentBounty_Multiple)
		SetInfoText("The pecentage of the bounty removed.")
	elseIf (option == _slider_PardonTime_Oral)
		SetInfoText("The amount of time (in game minutes) before the bounty is returned.")
	elseIf (option == _slider_PardonTime_Sex)
		SetInfoText("The amount of time (in game minutes) before the bounty is returned.")
	elseIf (option == _slider_PardonTime_Anal)
		SetInfoText("The amount of time (in game minutes) before the bounty is returned.")
	elseIf (option == _slider_PardonTime_Multiple)
		SetInfoText("The amount of time (in game minutes) before the bounty is returned.")
	elseIf (option == _slider_SameGenderPenalty)
		SetInfoText("The penalty for being the same gender as the guard. (0: No effect.   100: Same gender is always rejected.)")

	elseIf (option == _toggle_PardonEndPenaltySelection)
		SetInfoText("Active: Uses fixed amount for penalty.   Deactive: Uses percent of bounty for penalty.")
	elseIf (option == _toggle_PardonAdd)
		SetInfoText("Active: Adds to existing pardon.   Deactive: Replaces existing pardon.")
	elseIf (option == _slider_ActIncrease)
		SetInfoText("The amount the Times penalty increases per act.")
	elseIf (option == _slider_TimeDecrease)
		SetInfoText("The amount the Times penalty decreases per hour.")
	elseIf (option == _slider_PardonEndPenaltyFixed)
		SetInfoText("The extra amount added to bounty when a pardon ends.")
	elseIf (option == _slider_PardonEndPenaltyBounty)
		SetInfoText("The percentage of bounty added to bounty when a pardon ends.")
	elseIf (option == _slider_PardonedSexPercent)
		SetInfoText("The percentage of standard chance of being accepted, used when pardoned.")
	elseIf (option == _slider_PaymentPercent)
		SetInfoText("The percentage of standard payment, used when pardoned.")
	elseIf (option == _slider_PardonPercent)
		SetInfoText("The percentage of standard Pardon, used when pardoned.")

	elseIf (option == _toggle_UseSettlements)
		SetInfoText("If set to true, for your bounty to change you must be outside of that factions primary settlement at the update time.")
	elseIf (option == _toggle_UseHolds)
		SetInfoText("If set to true, for your bounty to change you must be completely outside of that hold at the update time. (May not reliably prevent change in the wilderness of a hold.)")
	elseIf (option == _slider_UpdatesPerDay)
		SetInfoText("The number of times a day the bounty is changed. (0: Never updates.   1: Updates at midnight.   2: Updates at midnight and noon.   etc.")
	elseIf (option == _slider_PercentDrop)
		SetInfoText("Determines the basic proportion of your bounty that is lost when updated. (Negative increases bounty.)")
	elseIf (option == _slider_FixedDrop)
		SetInfoText("Determines the fixed change in bounty, after the above percentage-based loss. (Negative increases bounty.)")

	;Approach.
	elseIf (option == _toggle_AllowApproach)
		SetInfoText("Guards approach demanding sex.")
	elseIf (option == _slider_ApproachTriggerTime)
		SetInfoText("Amount of time (in game minutes) before an approach is triggered.")
	elseIf (option == _slider_ApproachDelayMultiplier)
		SetInfoText("The percentage of a random time delay before approach is triggered. (100% is maximum of 24 in game hours, lower times are more likely.)")
	elseIf (option == _slider_ApproachTriggerChance)
		SetInfoText("The chance an approach will start tring to trigger.")
	elseIf (option == _slider_ApproachTimeOut)
		SetInfoText("Amount of time (in game minutes) before approach is ended.")
	elseIf (option == _toggle_UseApproachLocations)
		SetInfoText("Approaches only happen when staying in curtain locations (e.g. major Town / Cities).")
	elseIf (option == _slider_ApproachBounty)
		SetInfoText("The difficulty in getting the guard to accept offer. (used with bounty base rejection.")
	elseIf (option == _slider_ApproachSexPercent)
		SetInfoText("The percentage of standard chance of being accepted.")
	elseIf (option == _slider_ApproachRefusePenalty)
		SetInfoText("Amount added to bounty if guard is refused.")

	;Bounty Collectors.
	elseIf (option == _slider_BCSexPercent)
		SetInfoText("The percentage of standard chance of being accepted, used for Bounty collectors.")
	elseIf (option == _slider_BCPaymentPercent)
		SetInfoText("The percentage of standard payment, used for Bounty collectors.")
	elseIf (option == _slider_BCPardonPercent)
		SetInfoText("The percentage of standard Pardon, used for Bounty collectors.")
	elseIf (option == _slider_BCPardonFixed)
		SetInfoText("Additional Pardon (in game minutes), used for Bounty collectors.")


	endIf
endEvent