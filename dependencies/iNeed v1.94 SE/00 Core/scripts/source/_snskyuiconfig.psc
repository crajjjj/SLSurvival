Scriptname _SNSkyUIConfig extends SKI_ConfigBase 

;====================================================================================

_SNQuestScript Property _SNQuest Auto

Quest Property _SNFoodSpoilageQuest Auto

String[] Pages
String[] WidgetPosList
String[] NotifHUDList
String[] NotifTextList
String[] WidgetOrientList
String[] AnimationsList
String[] StatusList
String[] PerspectiveList
String[] DisplayPercentList
String[] ForceThirdList
String[] DefaultColorList
String[] FoodPriorityList
String[] FollowerMealsList
String[] FoodRemovalList
String[] ImpairmentList
String[] FoodStatsList
String[] VampireList
String[] VisibleWaterskinsList
String[] FollowerNeedsTypeList

String ModName

Int RestartOption
Int HungerRateOption
Int ThirstRateOption
Int FatigueRateOption
Int FollowerHungerRateOption
Int FollowerThirstRateOption
Int HungerVolOption
Int ThirstVolOption
Int FatigueVolOption
Int FoodRemovalOption
Int FollowerMealsOption
Int NotifHUDOption
Int NotifTextOption
Int NotifAutoTextOption
Int WidgetPosOption
Int WidgetXOffsetOption
Int WidgetYOffsetOption
Int WidgetOrientOption
Int WidgetAlphaOption
Int SetTimescaleOption
Int TimescaleValueOption
Int AutoHungerOption
Int AutoThirstOption
Int AutoKeyEatOption
Int AutoKeyDrinkOption
Int AutoKeyRestOption
Int AutoKeyNeedsOption
Int AutoKeyAlphaOption
Int CombatIncreaseNeedsOption
Int FollowerNeedsTypeOption
Int FollowerPurchaseOption
Int HorseNeedsOption
Int CannibalismOption
Int VampireOption
Int AnimationsOption
Int AnimationsFollowersOption
Int DeathOption
Int UnknownAllOption
Int FoodMultOption
Int DrinkMultOption
Int DiseaseOption
Int FoodNoEffectOption
Int EnableModOption
Int FoodPriorityOption
Int InfoWaterskinsOption
Int InfoWaterBarrelsOption
Int InfoWellBucketsOption
Int InfoRefillsOption
Int InfoConsumptionOption
Int InfoAlcoholOption
Int InfoPenaltiesOption
Int InfoRandomizationOption
Int InfoFoodSpoilageLimitsOption
Int InfoFoodSpoilageWorldOption
Int InfoLargeSaltPileOption
Int InfoCureDangDiseaseOption
Int InfoSnowHydrationOption
Int InfoInteractionFollowersOption
Int InfoINeedsRestartUpdateOption
Int PerspectiveOption
Int NoSaltOption
Int CategorizeOption
Int HarmfulRawOption
Int AdrenalineOption
Int ActionsSpellOption
Int ImpairmentOption
Int CarryWeightOption
Int DisplayPercentOption
Int ForceThirdOption
Int DefaultColorOption
Int WidgetVisDelayOption
Int BreakableWaterskinsOption
Int WidgetDiseaseOption
Int DiseaseNotifOption
Int ValuedHarvestsOption
Int FoodStatsOption
Int AlcoholDehydratesOption
Int RawFreshnessOption
Int LightFreshnessOption
Int MedFreshnessOption
Int HeavyFreshnessOption
Int VisibleWaterskinsOption

Int Property FollowerNeedsType Auto
Int WidgetPos
Int WidgetXOffset
Int WidgetYOffset
Int WidgetOrient
Int DisplayPercent
Int CarryWeight
Int NotifHUD
Int HungerRate
Int ThirstRate
Int FatigueRate
Int CombatIncreaseNeeds
Int FollowerHungerRate
Int FollowerThirstRate
Int TimescaleValue
Int AutoKeyEat = -1
Int AutoKeyDrink = -1
Int AutoKeyRest = -1
Int AutoKeyNeeds = -1
Int AutoKeyAlpha = -1
Int Animations
Int Status
Int Perspective
Int ForceThird
Int DefaultColor
Int FoodPriority
Int BreakableWaterskins
Int NotifTxt
Int FollowerMeals
Int FoodRemoval
Int Impairment
Int FoodStats
Int Vampire
Int VisibleWaterskins

Float[] HungerRateList
Float[] ThirstRateList
Float[] FatigueRateList
Float[] CombatIncreaseNeedsList
Float[] FollowerHungerRateList
Float[] FollowerThirstRateList

Float HungerVol
Float ThirstVol
Float FatigueVol
Float WidgetAlpha
Float FoodMult
Float DrinkMult
Float WidgetVisDelay
Float RawFreshness
Float LightFreshness
Float MedFreshness
Float HeavyFreshness

Bool UnknownWarning
Bool Restart
Bool NotifAutoText
Bool SetTimescale
Bool AutoHunger
Bool AutoThirst
Bool FollowerPurchase
Bool HorseNeeds
Bool Cannibalism
Bool AnimationsFollowers
Bool Death
Bool UnknownAll
Bool Disease
Bool FoodNoEffect
Bool NoSalt
Bool Categorize
Bool HarmfulRaw
Bool Adrenaline
Bool ActionsSpell
Bool WidgetDisease
Bool DiseaseNotif
Bool ValuedHarvests
Bool AlcoholDehydrates

;====================================================================================

Int Function ParseArray(Float[] ArrayList, Float Rate)
	Int i = 7
	While i > -1
		If ArrayList[i] == Rate
			Return i
		Else
			i -= 1
		EndIf
	EndWhile
EndFunction

;====================================================================================

Function ApplySettings()
	If VisibleWaterskins != _SNQuest._SNWaterskinEquipToggle.GetValue() as Int
		_SNQuest._SNWaterskinEquipToggle.SetValue(0)
	EndIf
	_SNQuest.HungerRate = HungerRateList[HungerRate]
	_SNQuest._SNHungerRate.SetValue(HungerRateList[HungerRate])
	If HungerRate == 0
		_SNQuest.ModHunger(100.0)
	EndIf
	_SNQuest.ThirstRate = ThirstRateList[ThirstRate]
 	_SNQuest._SNThirstRate.SetValue(ThirstRateList[ThirstRate])
	If ThirstRate == 0
		_SNQuest.ModThirst(100.0)
	EndIf
	_SNQuest.FatigueRate = FatigueRateList[FatigueRate]
	_SNQuest._SNFatigueRate.SetValue(FatigueRateList[FatigueRate])
	If FatigueRate == 0
		_SNQuest.ModFatigue(100.0)
	EndIf
	_SNQuest.FollowerHungerRate = FollowerHungerRateList[FollowerHungerRate]
	_SNQuest.FollowerThirstRate = FollowerThirstRateList[FollowerThirstRate]
	_SNQuest.HungerVol = HungerVol
	_SNQuest.ThirstVol = ThirstVol
	_SNQuest.FatigueVol = FatigueVol
	_SNQuest.RawFreshness = RawFreshness
	_SNQuest.LightFreshness = LightFreshness
	_SNQuest.MedFreshness = MedFreshness
	_SNQuest.HeavyFreshness = HeavyFreshness
	If FoodRemoval == 0
		_SNQuest._SNFoodRemovalToggle.SetValue(0)
	ElseIf FoodRemoval == 1
		_SNQuest.FoodLeveledList()
		_SNQuest._SNFoodRemovalToggle.SetValue(0)
	ElseIf FoodRemoval == 2
		_SNQuest._SNFoodRemovalToggle.SetValue(1)
	Else
		_SNQuest.FoodLeveledList()
		_SNQuest._SNFoodRemovalToggle.SetValue(1)
	EndIf
	If FoodStats == 0
		_SNQuest.FoodWeight = False
		_SNQuest.FoodPrice = False
	ElseIf FoodStats == 1
		_SNQuest.FoodWeight = True
		_SNQuest.FoodPrice = False
	ElseIf FoodStats == 2
		_SNQuest.FoodWeight = False
		_SNQuest.FoodPrice = True
	Else
		_SNQuest.FoodWeight = True
		_SNQuest.FoodPrice = True
	EndIf
	If FollowerMeals == 0
		_SNQuest._SNFollowerToggle.SetValue(0)
		_SNQuest.ForceFollowerConsume = False
	ElseIf FollowerMeals == 1
		_SNQuest._SNFollowerToggle.SetValue(1)
		_SNQuest.ForceFollowerConsume = False
	ElseIf FollowerMeals == 2
		_SNQuest._SNFollowerToggle.SetValue(0)
		_SNQuest.ForceFollowerConsume = True
	Else
		_SNQuest._SNFollowerToggle.SetValue(1)
		_SNQuest.ForceFollowerConsume = True
	EndIf
	If Disease
		_SNQuest._SNDiseaseToggle.SetValue(1)
		_SNQuest.SetPotionLeveledLists()
	Else
		If _SNQuest._SNDiseaseToggle.GetValue() as Int == 1
			_SNQuest.CureDisease()
			_SNQuest._SNDiseaseToggle.SetValue(0)
			_SNQuest.SetPotionLeveledLists(true)
		EndIf
	EndIf
	If NotifTxt == 0
		_SNQuest.NotifText = False
		_SNQuest.ConsumptionNotif = False
	ElseIf NotifTxt == 1
		_SNQuest.NotifText = True
		_SNQuest.ConsumptionNotif = False
	ElseIf NotifTxt == 2
		_SNQuest.NotifText = False
		_SNQuest.ConsumptionNotif = True
	Else
		_SNQuest.NotifText = True
		_SNQuest.ConsumptionNotif = True
	EndIf
	_SNQuest.NotifAutoText = NotifAutoText
	_SNQuest.WidgetPos = WidgetPos
	_SNQuest.WidgetXOffset = WidgetXOffset
	_SNQuest.WidgetYOffset = WidgetYOffset * -1
	_SNQuest.WidgetOrient = WidgetOrient
	_SNQuest.WidgetAlpha = WidgetAlpha
	_SNQuest.NotifHUD = NotifHUD
	_SNQuest.CombatIncreaseNeeds = CombatIncreaseNeedsList[CombatIncreaseNeeds]
	_SNQuest.Animations = Animations
	_SNQuest.AnimationsFollowers = AnimationsFollowers
	_SNQuest.Death = Death
	_SNQuest.FoodMult = FoodMult
	_SNQuest.DrinkMult = DrinkMult
	_SNQuest.FoodNoEffect = FoodNoEffect
	_SNQuest.NoSalt = NoSalt
	_SNQuest.Recategorize = Categorize
	_SNQuest.HarmfulRaw = HarmfulRaw
	_SNQuest.AlcoholDehydrates = AlcoholDehydrates
	If Impairment == 0
		_SNQuest.EnableAlcohol = False
		_SNQuest.EnableSkooma = False
	ElseIf Impairment == 1
		_SNQuest.EnableAlcohol = True
		_SNQuest.EnableSkooma = False
	ElseIf Impairment == 2
		_SNQuest.EnableAlcohol = False
		_SNQuest.EnableSkooma = True
	Else
		_SNQuest.EnableAlcohol = True
		_SNQuest.EnableSkooma = True
	EndIf
	_SNQuest.DefaultColor = DefaultColor
	_SNQuest.FoodPriority = FoodPriority
	_SNQuest.BreakableWaterskins = BreakableWaterskins
	_SNQuest.WidgetDisease = WidgetDisease
	_SNQuest.DiseaseNotif = DiseaseNotif
	_SNQuest.EnableActionsSpell = ActionsSpell
	If ActionsSpell
		_SNQuest.PlayerRef.AddSpell(_SNQuest._SNOldConfigSpell, false)
	Else
		_SNQuest.PlayerRef.RemoveSpell(_SNQuest._SNOldConfigSpell)
	EndIf
	If UnknownAll
		_SNQuest._SNUnknownAllToggle.SetValue(1)
	Else
		_SNQuest._SNUnknownAllToggle.SetValue(0)
	EndIf
	If FollowerPurchase
		_SNQuest._SNFollowerPurchaseToggle.SetValue(1)
	Else
		_SNQuest._SNFollowerPurchaseToggle.SetValue(0)
	EndIf
	If Adrenaline
		_SNQuest._SNAdrenalineToggle.SetValue(1)
	Else
		_SNQuest._SNAdrenalineToggle.SetValue(0)
	EndIf
	If ForceThird == 0
		_SNQuest.ForceThird = True
	Else
		_SNQuest.ForceThird = False
	EndIf
	_SNQuest._SNCarryWeightMag.SetValue(CarryWeight)
	If DisplayPercent > 0
		_SNFoodSpoilageQuest.Start()
		If !_SNQuest.FoodSpoilage
			Debug.Notification(_SNQuest.SpoilageReminder)
		EndIf
		_SNQuest.FoodSpoilage = True
		If DisplayPercent == 1
			_SNQuest.DisplayPercent = True
		Else
			_SNQuest.DisplayPercent = False
		EndIf
	Else
		_SNFoodSpoilageQuest.Stop()
		_SNQuest.FoodSpoilage = False
	EndIf
	If Perspective == 1
		_SNQuest.SetPerspective(true)
	Else
		_SNQuest.SetPerspective()
	EndIf
	UnregisterForKey(AutoKeyEat)
	UnregisterForKey(AutoKeyDrink)
	UnregisterForKey(AutoKeyRest)
	UnregisterForKey(AutoKeyNeeds)
	UnregisterForKey(AutoKeyAlpha)
	If AutoKeyEat > -1
		RegisterForKey(AutoKeyEat)
	EndIf
	If AutoKeyDrink > -1
		RegisterForKey(AutoKeyDrink)
	EndIf
	If AutoKeyRest > -1
		RegisterForKey(AutoKeyRest)
	EndIf
	If AutoKeyNeeds > -1
		RegisterForKey(AutoKeyNeeds)
	EndIf
	If AutoKeyAlpha > -1 && NotifHUD == 1
		RegisterForKey(AutoKeyAlpha)
	Else
		WidgetVisDelay = 0.0
	EndIf
	If AutoHunger
		_SNQuest._SNAutoHungerToggle.SetValue(1)
	Else
		_SNQuest._SNAutoHungerToggle.SetValue(0)
	EndIf
	If AutoThirst
		_SNQuest._SNAutoThirstToggle.SetValue(1)
	Else
		_SNQuest._SNAutoThirstToggle.SetValue(0)
	EndIf
	If ValuedHarvests
		_SNQuest._SNValuedHarvestsToggle.SetValue(1)
	Else
		_SNQuest._SNValuedHarvestsToggle.SetValue(0)
	EndIf
	_SNQuest._SNFollowerNeedsToggle.SetValue(FollowerNeedsType)
	If HorseNeeds
		_SNQuest._SNHorseNeedsToggle.SetValue(1)
	Else
		_SNQuest._SNHorseNeedsToggle.SetValue(0)
	EndIf
	_SNQuest._SNVampWereToggle.SetValue(Vampire)
	If Cannibalism
		_SNQuest._SNCannibalToggle.SetValue(1)
		Race targRace = _SNQuest.PlayerRef.GetRace()
		If targRace == _SNQuest.WoodelfRace || targRace == _SNQuest.WoodelfRaceVampire
			_SNQuest.PlayerIsWoodelf = True
		Else
			_SNQuest.PlayerIsWoodelf = False
		EndIf
	Else
		_SNQuest._SNCannibalToggle.SetValue(0)
	EndIf
	If SetTimescale
		_SNQuest.Timescale.SetValue(TimescaleValue)
	EndIf
	If WidgetVisDelay != 0.0
		_SNQuest.WidgetHide = True
	Else
		_SNQuest.WidgetHide = False
	EndIf
	If Status == 1
		_SNQuest.EnableMod = True
		If Restart
			_SNQuest.Restart()
		Else
			_SNQuest.EnableMod()
		EndIf
	Else
		_SNQuest.EnableMod = False
		_SNQuest.ModFatigue(100.0)
		_SNQuest.ModThirst(100.0)
		_SNQuest.ModHunger(100.0)
		_SNQuest.NotifHUD = 2
		_SNQuest.DisableMod()
	EndIf
	If _SNQuest.PlayerRef.GetActorBase().GetSex() == 0
		_SNQuest.IsMale = True
	Else
		_SNQuest.IsMale = False
	EndIf
	Utility.Wait(0.5)
	_SNQuest._SNWaterskinEquipToggle.SetValue(VisibleWaterskins)
	Restart = False
	SendModEvent("_SN_UIConfigured")
EndFunction

;====================================================================================

Event OnConfigInit()
	ModName = "iNeed"

	Pages = New String[5]
	Pages[0] = "$Basics"
	Pages[1] = "$Advanced"
	Pages[2] = "$Difficulty"
	Pages[3] = "$Notifications"
	Pages[4] = "$Guide"

	DefaultColorList = New String[2]
	DefaultColorList[0] = "$White"
	DefaultColorList[1] = "$Green"

	WidgetPosList = New String[8]
	WidgetPosList[0] = "$Bottom, Right"
	WidgetPosList[1] = "$Bottom, Left"
	WidgetPosList[2] = "$Top, Right"
	WidgetPosList[3] = "$Top, Left"
	WidgetPosList[4] = "$Middle, Right"
	WidgetPosList[5] = "$Middle, Left"
	WidgetPosList[6] = "$Bottom, Middle"
	WidgetPosList[7] = "$Top, Middle"

	WidgetOrientList = New String[2]
	WidgetOrientList[0] = "$Vertical"
	WidgetOrientList[1] = "$Horizontal"

	DisplayPercentList = New String[3]
	DisplayPercentList[0] = "$Disabled"
	DisplayPercentList[1] = "$Numbers"
	DisplayPercentList[2] = "$Words"

	NotifHUDList = New String[4]
	NotifHUDList[0] = "$Disabled"
	NotifHUDList[1] = "$Color-based"
	NotifHUDList[2] = "$Alpha-based"
	NotifHUDList[3] = "$Alpha/Color-based"

	AnimationsList = New String[3]
	AnimationsList[0] = "$Disabled"
	AnimationsList[1] = "$Sitting Only"
	AnimationsList[2] = "$Enabled"

	StatusList = New String[2]
	StatusList[0] = "$Disabled"
	StatusList[1] = "$Enabled"

	PerspectiveList = New String[2]
	PerspectiveList[0] = "$3rd Person"
	PerspectiveList[1] = "$1st Person"

	ForceThirdList = New String[2]
	ForceThirdList[0] = "$Force Camera"
	ForceThirdList[1] = "$Do Not Force"

	FoodPriorityList = New String[2]
	FoodPriorityList[0] = "$Most Filling First"
	FoodPriorityList[1] = "$Least Filling First"

	ImpairmentList = New String[4]
	ImpairmentList[0] = "$Disabled"
	ImpairmentList[1] = "$Alcohol"
	ImpairmentList[2] = "$Skooma"
	ImpairmentList[3] = "$Both"

	NotifTextList = New String[4]
	NotifTextList[0] = "$Disabled"
	NotifTextList[1] = "$Intervals"
	NotifTextList[2] = "$Consumption"
	NotifTextList[3] = "$Both"
	
	FollowerMealsList = New String[4]
	FollowerMealsList[0] = "$Disabled"
	FollowerMealsList[1] = "$Simple"
	FollowerMealsList[2] = "$Shared"
	FollowerMealsList[3] = "$Both"
	
	FollowerNeedsTypeList = New String[4]
	FollowerNeedsTypeList[0] = "$Disabled"
	FollowerNeedsTypeList[1] = "$Default"
	FollowerNeedsTypeList[2] = "$Simulated"

	FoodRemovalList = New String[4]
	FoodRemovalList[0] = "$Disabled"
	FoodRemovalList[1] = "$Containers"
	FoodRemovalList[2] = "$Interiors"
	FoodRemovalList[3] = "$Both"

	FoodStatsList = New String[4]
	FoodStatsList[0] = "$Disabled"
	FoodStatsList[1] = "$Weight"
	FoodStatsList[2] = "$Value"
	FoodStatsList[3] = "$Both"

	VampireList = New String[3]
	VampireList[0] = "$Mortal"
	VampireList[1] = "$Hybrid"
	VampireList[2] = "$Pure"
	
	VisibleWaterskinsList = New String[4]
	VisibleWaterskinsList[0] = "$Disabled"
	VisibleWaterskinsList[1] = "$Front, Right"
	VisibleWaterskinsList[2] = "$Front, Left"
	VisibleWaterskinsList[3] = "$Back, Low"

	HungerRateList = New Float[8]
	HungerRateList[0] = 0.0
	HungerRateList[1] = 4.5
	HungerRateList[2] = 6.5
	HungerRateList[3] = 8.5
	HungerRateList[4] = 10.5
	HungerRateList[5] = 12.5
	HungerRateList[6] = 14.5
	HungerRateList[7] = 16.5

	ThirstRateList = New Float[8]
	ThirstRateList[0] = 0.0
	ThirstRateList[1] = 7.0
	ThirstRateList[2] = 9.0
	ThirstRateList[3] = 11.0
	ThirstRateList[4] = 13.0
	ThirstRateList[5] = 15.0
	ThirstRateList[6] = 17.0
	ThirstRateList[7] = 19.0

	FatigueRateList = New Float[8]
	FatigueRateList[0] = 0.0
	FatigueRateList[1] = 2.0
	FatigueRateList[2] = 3.0
	FatigueRateList[3] = 4.0
	FatigueRateList[4] = 5.0
	FatigueRateList[5] = 6.0
	FatigueRateList[6] = 7.0
	FatigueRateList[7] = 8.0

	CombatIncreaseNeedsList = New Float[8]
	CombatIncreaseNeedsList[0] = 0.0
	CombatIncreaseNeedsList[1] = 0.25
	CombatIncreaseNeedsList[2] = 0.5
	CombatIncreaseNeedsList[3] = 0.75
	CombatIncreaseNeedsList[4] = 1.0
	CombatIncreaseNeedsList[5] = 1.25
	CombatIncreaseNeedsList[6] = 1.5
	CombatIncreaseNeedsList[7] = 1.75

	FollowerHungerRateList = New Float[8]
	FollowerHungerRateList[0] = 0.0
	FollowerHungerRateList[1] = 5.0
	FollowerHungerRateList[2] = 4.5
	FollowerHungerRateList[3] = 4.0
	FollowerHungerRateList[4] = 3.5
	FollowerHungerRateList[5] = 3.0
	FollowerHungerRateList[6] = 2.5
	FollowerHungerRateList[7] = 2.0

	FollowerThirstRateList = New Float[8]
	FollowerThirstRateList[0] = 0.0
	FollowerThirstRateList[1] = 4.5
	FollowerThirstRateList[2] = 4.0
	FollowerThirstRateList[3] = 3.5
	FollowerThirstRateList[4] = 3.0
	FollowerThirstRateList[5] = 2.5
	FollowerThirstRateList[6] = 2.0
	FollowerThirstRateList[7] = 1.5

	HungerRate = ParseArray(HungerRateList, _SNQuest.HungerRate)
	ThirstRate = ParseArray(ThirstRateList, _SNQuest.ThirstRate)
	FatigueRate = ParseArray(FatigueRateList, _SNQuest.FatigueRate)
	CombatIncreaseNeeds = ParseArray(CombatIncreaseNeedsList, _SNQuest.CombatIncreaseNeeds)
	FollowerHungerRate = ParseArray(FollowerHungerRateList, _SNQuest.FollowerHungerRate)
	FollowerThirstRate = ParseArray(FollowerThirstRateList, _SNQuest.FollowerThirstRate)
	HungerVol = _SNQuest.HungerVol
	ThirstVol = _SNQuest.ThirstVol
	FatigueVol = _SNQuest.FatigueVol
	RawFreshness = _SNQuest.RawFreshness
	LightFreshness = _SNQuest.LightFreshness
	MedFreshness = _SNQuest.MedFreshness
	HeavyFreshness = _SNQuest.HeavyFreshness
	VisibleWaterskins = _SNQuest._SNWaterskinEquipToggle.GetValue() as Int
	If !_SNQuest.SetLeveledLists && _SNQuest._SNFoodRemovalToggle.GetValue() as Int == 0
		FoodRemoval = 0
	ElseIf _SNQuest.SetLeveledLists && _SNQuest._SNFoodRemovalToggle.GetValue() as Int == 0
		FoodRemoval = 1
	ElseIf !_SNQuest.SetLeveledLists && _SNQuest._SNFoodRemovalToggle.GetValue() as Int == 1
		FoodRemoval = 2
	Else
		FoodRemoval = 3
	EndIf

	If _SNQuest.FoodWeight == False && _SNQuest.FoodPrice == False
		FoodStats = 0
	ElseIf _SNQuest.FoodWeight == True && _SNQuest.FoodPrice == False
		FoodStats = 1
	ElseIf _SNQuest.FoodWeight == False && _SNQuest.FoodPrice == True
		FoodStats = 2
	Else
		FoodStats = 3
	EndIf

	DefaultColor = _SNQuest.DefaultColor
	FoodPriority = _SNQuest.FoodPriority
	WidgetDisease = _SNQuest.WidgetDisease

	If _SNQuest._SNFollowerToggle.GetValue() as Int == 0 && !_SNQuest.ForceFollowerConsume
		FollowerMeals = 0
	ElseIf _SNQuest._SNFollowerToggle.GetValue() as Int == 1 && !_SNQuest.ForceFollowerConsume
		FollowerMeals = 1
	ElseIf _SNQuest._SNFollowerToggle.GetValue() as Int == 0 && _SNQuest.ForceFollowerConsume
		FollowerMeals = 2
	Else
		FollowerMeals = 3
	EndIf
	If _SNQuest._SNFollowerPurchaseToggle.GetValue() as Int == 0
		FollowerPurchase = False
	Else
		FollowerPurchase = True
	EndIf

	If !_SNQuest.EnableAlcohol && !_SNQuest.EnableSkooma
		Impairment = 0
	ElseIf _SNQuest.EnableAlcohol && !_SNQuest.EnableSkooma
		Impairment = 1
	ElseIf !_SNQuest.EnableAlcohol && _SNQuest.EnableSkooma
		Impairment = 2
	Else
		Impairment = 3
	EndIf
	
	NotifHUD = _SNQuest.NotifHUD
	If !_SNQuest.NotifText && !_SNQuest.ConsumptionNotif
		NotifTxt = 0
	ElseIf _SNQuest.NotifText && !_SNQuest.ConsumptionNotif
		NotifTxt = 1
	ElseIf !_SNQuest.NotifText && _SNQuest.ConsumptionNotif
		NotifTxt = 2
	Else
		NotifTxt = 3
	EndIf
	NotifAutoText = _SNQuest.NotifAutoText
	WidgetPos = _SNQuest.WidgetPos
	WidgetXOffset = _SNQuest.WidgetXOffset
	WidgetYOffset = (_SNQuest.WidgetYOffset * -1)
	WidgetAlpha = _SNQuest.WidgetAlpha
	WidgetOrient = _SNQuest.WidgetOrient
	Animations = _SNQuest.Animations
	AnimationsFollowers = _SNQuest.AnimationsFollowers
	Death = _SNQuest.Death
	FoodMult = _SNQuest.FoodMult
	DrinkMult = _SNQuest.DrinkMult
	FoodNoEffect = _SNQuest.FoodNoEffect
	NoSalt = _SNQuest.NoSalt
	Categorize = _SNQuest.Recategorize
	HarmfulRaw = _SNQuest.HarmfulRaw
	BreakableWaterskins = _SNQuest.BreakableWaterskins
	DiseaseNotif = _SNQuest.DiseaseNotif
	AlcoholDehydrates = _SNQuest.AlcoholDehydrates
	ActionsSpell = _SNQuest.EnableActionsSpell
	If _SNQuest.ForceThird
		ForceThird = 0
	Else
		ForceThird = 1
	EndIf
	If _SNQuest.FoodSpoilage 
		If _SNQuest.DisplayPercent
			DisplayPercent = 1
		Else
			DisplayPercent = 2
		EndIf
	Else
		DisplayPercent = 0
	EndIf
	CarryWeight = _SNQuest._SNCarryWeightMag.GetValue() as Int
	If _SNQuest.EnableMod
		Status = 1
	Else
		Status = 0
	EndIf
	If _SNQuest._SNAdrenalineToggle.GetValue() as Int == 1
		Adrenaline = True
	Else
		Adrenaline = False
	EndIf
	If _SNQuest._SNUnknownAllToggle.GetValue() as Int == 1
		UnknownAll = True
	Else
		UnknownAll = False
	EndIf
	If _SNQuest._SNValuedHarvestsToggle.GetValue() as Int == 1
		ValuedHarvests = True
	Else
		ValuedHarvests = False
	EndIf
	FollowerNeedsType = _SNQuest._SNFollowerNeedsToggle.GetValue() as Int
	If _SNQuest._SNHorseNeedsToggle.GetValue() as Int == 1
		HorseNeeds = True
	Else
		HorseNeeds = False
	EndIf
	If _SNQuest._SNAutoHungerToggle.GetValue() as Int == 1
		AutoHunger = True
	Else
		AutoHunger = False
	EndIf
	If _SNQuest._SNAutoThirstToggle.GetValue() as Int == 1
		AutoThirst = True
	Else
		AutoThirst = False
	EndIf
	If _SNQuest._SNCannibalToggle.GetValue() as Int == 1
		Cannibalism = True
	Else
		Cannibalism = False
	EndIf
	Vampire = _SNQuest._SNVampWereToggle.GetValue() as Int
	If _SNQuest._SNDiseaseToggle.GetValue() as Int == 1
		Disease = True
	Else
		Disease = False
	EndIf
	TimescaleValue = _SNQuest.Timescale.GetValue() as Int
EndEvent

Event OnPageReset(String Page)
	If Page == ""
		LoadCustomContent("foodandsleep/title.dds")
		Return
	Else
		UnloadCustomContent()
	EndIf
	If Page == "$Basics"
		SetCursorFillMode(TOP_TO_BOTTOM)
		EnableModOption = AddMenuOption("$iNeed Status:", StatusList[Status])
		AddEmptyOption()

		If Status == 1
			AddHeaderOption("$Player")
			HungerRateOption = AddSliderOption("$Hunger Rate", HungerRate, "{0}")
			ThirstRateOption = AddSliderOption("$Thirst Rate", ThirstRate, "{0}")
			FatigueRateOption = AddSliderOption("$Fatigue Rate", FatigueRate, "{0}")
			VisibleWaterskinsOption = AddMenuOption("$Visible Waterskins", VisibleWaterskinsList[VisibleWaterskins])
			AnimationsOption = AddMenuOption("$Eat/Drink Animations", AnimationsList[Animations])
			If Animations > 0
				ForceThirdOption = AddTextOption("", ForceThirdList[ForceThird])
			Else
				ForceThirdOption = AddTextOption("", ForceThirdList[ForceThird], OPTION_FLAG_DISABLED)
			EndIf

			SetCursorPosition(1)
			SetTimescaleOption = AddToggleOption("$Set Timescale", SetTimescale)
			If SetTimescale
				TimescaleValueOption = AddSliderOption("", TimescaleValue as float)
			Else
				AddEmptyOption()
			EndIf

			AddHeaderOption("$Automation")
			AutoKeyEatOption = AddKeyMapOption("$Eat Hotkey", AutoKeyEat, OPTION_FLAG_WITH_UNMAP)
			AutoKeyDrinkOption = AddKeyMapOption("$Drink/Refill Hotkey", AutoKeyDrink, OPTION_FLAG_WITH_UNMAP)
			AutoKeyRestOption = AddKeyMapOption("$Sit Hotkey", AutoKeyRest, OPTION_FLAG_WITH_UNMAP)
			ActionsSpellOption = AddToggleOption("$Actions: iNeed", ActionsSpell)
			If HungerRate > 0
				AutoHungerOption = AddToggleOption("$Automate Eating", AutoHunger)
			Else
				AutoHungerOption = AddToggleOption("$Automate Eating", AutoHunger, OPTION_FLAG_DISABLED)
			EndIf
			If ThirstRate > 0
				AutoThirstOption = AddToggleOption("$Automate Drinking", AutoThirst)
			Else
				AutoThirstOption = AddToggleOption("$Automate Drinking", AutoThirst, OPTION_FLAG_DISABLED)
			EndIf
			If (AutoKeyEat > -1) || AutoHunger || FollowerNeedsType > 0
				FoodPriorityOption = AddTextOption("", FoodPriorityList[FoodPriority])
			Else
				FoodPriorityOption = AddTextOption("", FoodPriorityList[FoodPriority], OPTION_FLAG_DISABLED)
			EndIf

		EndIf

	ElseIf Page == "$Advanced"
		If Status == 1
			SetCursorFillMode(TOP_TO_BOTTOM)

			AddHeaderOption("$NPCs")
			FollowerNeedsTypeOption = AddMenuOption("$Follower Needs", FollowerNeedsTypeList[FollowerNeedsType])
			FollowerMealsOption = AddMenuOption("$Meals with Followers", FollowerMealsList[FollowerMeals])
			If FollowerNeedsType > 0
				FollowerHungerRateOption = AddSliderOption("$Hunger Rate", FollowerHungerRate, "{0}")
				FollowerThirstRateOption = AddSliderOption("$Thirst Rate", FollowerThirstRate, "{0}")
				AnimationsFollowersOption = AddToggleOption("$Eat/Drink AnimationsF", AnimationsFollowers)
			Else
				FollowerHungerRateOption = AddSliderOption("$Hunger Rate", FollowerHungerRate, "{0}", OPTION_FLAG_DISABLED)
				FollowerThirstRateOption = AddSliderOption("$Thirst Rate", FollowerThirstRate, "{0}", OPTION_FLAG_DISABLED)
				AnimationsFollowersOption = AddToggleOption("$Eat/Drink AnimationsF", AnimationsFollowers, OPTION_FLAG_DISABLED)
			EndIf
			If FollowerNeedsType > 0
				FollowerPurchaseOption = AddToggleOption("$Followers Purchase Food", FollowerPurchase)
			Else
				FollowerPurchaseOption = AddToggleOption("$Followers Purchase Food", FollowerPurchase, OPTION_FLAG_DISABLED)
			EndIf
			HorseNeedsOption = AddToggleOption("$Horse Needs", HorseNeeds)

			SetCursorPosition(1)

			AddHeaderOption("$Gameplay")
			ImpairmentOption = AddMenuOption("$Substance Impairment", ImpairmentList[Impairment])
			VampireOption = AddMenuOption("$Vampires", VampireList[Vampire])
			AdrenalineOption = AddToggleOption("$Adrenaline/Weariness", Adrenaline)
			CannibalismOption = AddToggleOption("$Cannibalism", Cannibalism)

			AddEmptyOption()
			AddHeaderOption("$Food/Drink")
			FoodMultOption = AddSliderOption("$Satiation Multiplier", FoodMult, "{1}")
			DrinkMultOption = AddSliderOption("$Hydration Multiplier", DrinkMult, "{1}")
			CategorizeOption = AddToggleOption ("$Categorize", Categorize)
			NoSaltOption = AddToggleOption("$No Salt Requirement", NoSalt)
			;FoodNoEffectOption = AddToggleOption("$No Food Effects", FoodNoEffect)

		Else
			SetCursorFillMode(TOP_TO_BOTTOM)
			EnableModOption = AddMenuOption("$iNeed Status:", StatusList[Status], OPTION_FLAG_DISABLED)
		EndIf

	ElseIf Page == "$Difficulty"
		If Status == 1
			SetCursorFillMode(TOP_TO_BOTTOM)

			AddHeaderOption("$World")
			FoodRemovalOption = AddMenuOption("$Food Removal", FoodRemovalList[FoodRemoval])
			DisplayPercentOption = AddMenuOption("$Food Spoilage", DisplayPercentList[DisplayPercent])
			ValuedHarvestsOption = AddToggleOption("$Valued Harvests", ValuedHarvests)
			AddEmptyOption()
			AddHeaderOption("$Spoilage Rates")
			If DisplayPercent > 0
				RawFreshnessOption = AddSliderOption("$Raw", RawFreshness, "${1} Days")
				LightFreshnessOption = AddSliderOption("$Light", LightFreshness, "${1} Days")
				MedFreshnessOption = AddSliderOption("$Medium", MedFreshness, "${1} Days")
				HeavyFreshnessOption = AddSliderOption("$Heavy", HeavyFreshness, "${1} Days")
			Else
				RawFreshnessOption = AddSliderOption("$Raw", RawFreshness, "${1} Days", OPTION_FLAG_DISABLED)
				LightFreshnessOption = AddSliderOption("$Light", LightFreshness, "${1} Days", OPTION_FLAG_DISABLED)
				MedFreshnessOption = AddSliderOption("$Medium", MedFreshness, "${1} Days", OPTION_FLAG_DISABLED)
				HeavyFreshnessOption = AddSliderOption("$Heavy", HeavyFreshness, "${1} Days", OPTION_FLAG_DISABLED)
			EndIf
			SetCursorPosition(1)

			AddHeaderOption("$Gameplay")
			CombatIncreaseNeedsOption = AddSliderOption("$Combat Increases Needs", CombatIncreaseNeeds, "{0}")
			BreakableWaterskinsOption = AddSliderOption("$Breakable Waterskins", BreakableWaterskins, "{0}")
			CarryWeightOption = AddSliderOption("$Reduced Carry Weight", CarryWeight, "{0}")
			DiseaseOption = AddToggleOption("$Dangerous Diseases", Disease)
			UnknownAllOption = AddToggleOption("$Unknown Water", UnknownAll)
			DeathOption = AddToggleOption("$Death", Death)
			AddEmptyOption()
			AddHeaderOption("$Food/Drink")
			FoodStatsOption = AddMenuOption("$Increased Food Weight/Value", FoodStatsList[FoodStats])
			HarmfulRawOption = AddToggleOption("$Harmful Raw Food", HarmfulRaw)
			AlcoholDehydratesOption = AddToggleOption("$Alcohol Dehydrates", AlcoholDehydrates)

		Else
			SetCursorFillMode(TOP_TO_BOTTOM)
			EnableModOption = AddMenuOption("$iNeed Status:", StatusList[Status], OPTION_FLAG_DISABLED)
		EndIf

	ElseIf Page == "$Notifications"
		If Status == 1
			SetCursorFillMode(TOP_TO_BOTTOM)
			AddHeaderOption("$Sound")
			HungerVolOption = AddSliderOption("$Hunger", HungerVol, "{1}")
			ThirstVolOption = AddSliderOption("$Thirst", ThirstVol, "{1}")
			FatigueVolOption = AddSliderOption("$Fatigue", FatigueVol, "{1}")
			AddEmptyOption()

			AddHeaderOption("$Text")
			PerspectiveOption = AddTextOption("$Perspective", PerspectiveList[Perspective])
			NotifTextOption = AddMenuOption("$Current Needs", NotifTextList[NotifTxt])
			NotifAutoTextOption = AddToggleOption("$Automated Items Consumed", NotifAutoText)
			AutoKeyNeedsOption = AddKeyMapOption("$Check Status Hotkey", AutoKeyNeeds, OPTION_FLAG_WITH_UNMAP)
			If Disease																										;disease
				DiseaseNotifOption = AddToggleOption("$Disease Progression", DiseaseNotif)
			Else
				DiseaseNotifOption = AddToggleOption("$Disease Progression", DiseaseNotif, OPTION_FLAG_DISABLED)
			EndIf

			SetCursorPosition(1)

			AddHeaderOption("$Widget")
			NotifHUDOption = AddMenuOption("$Style", NotifHUDList[NotifHUD])
			If NotifHUD > 0
				DefaultColorOption = AddTextOption("$Default Color", DefaultColorList[DefaultColor])
				WidgetPosOption = AddMenuOption("$Position", WidgetPosList[WidgetPos])
				WidgetOrientOption = AddTextOption("$Orientation", WidgetOrientList[WidgetOrient])
				WidgetXOffsetOption = AddSliderOption("$X Offset", WidgetXOffset, "{0}")
				WidgetYOffsetOption = AddSliderOption("$Y Offset", WidgetYOffset, "{0}")
				If NotifHUD == 1
					WidgetAlphaOption = AddSliderOption("$Alpha", WidgetAlpha, "{0}")
					AutoKeyAlphaOption = AddKeyMapOption("$Toggle Widgets Hotkey", AutoKeyAlpha, OPTION_FLAG_WITH_UNMAP)
					If AutoKeyAlpha > -1
						WidgetVisDelayOption = AddSliderOption("", WidgetVisDelay, "${0} Seconds")
					Else
						WidgetVisDelayOption = AddSliderOption("", WidgetVisDelay, "${0} Seconds", OPTION_FLAG_DISABLED)
					EndIf
				Else
					UnregisterForKey(AutoKeyAlpha)
					WidgetAlpha = 100
					AutoKeyAlpha = -1
					WidgetAlphaOption = AddSliderOption("$Alpha", WidgetAlpha, "{0}", OPTION_FLAG_DISABLED)
					AutoKeyAlphaOption = AddKeyMapOption("$Toggle Widgets Hotkey", AutoKeyAlpha, OPTION_FLAG_DISABLED)
					WidgetVisDelayOption = AddSliderOption("", WidgetVisDelay, "${0} Seconds", OPTION_FLAG_DISABLED)
				EndIf
			Else
				DefaultColorOption = AddTextOption("$Default Color", DefaultColorList[DefaultColor], OPTION_FLAG_DISABLED)
				WidgetPosOption = AddMenuOption("$Position", WidgetPosList[WidgetPos], OPTION_FLAG_DISABLED)
				WidgetOrientOption = AddTextOption("$Orientation", WidgetOrientList[WidgetOrient], OPTION_FLAG_DISABLED)
				WidgetXOffsetOption = AddSliderOption("$X Offset", WidgetXOffset, "{0}", OPTION_FLAG_DISABLED)
				WidgetYOffsetOption = AddSliderOption("$Y Offset", WidgetYOffset, "{0}", OPTION_FLAG_DISABLED)
				WidgetAlphaOption = AddSliderOption("$Alpha", WidgetAlpha, "{0}", OPTION_FLAG_DISABLED)
				AutoKeyAlphaOption = AddKeyMapOption("$Toggle Widgets Hotkey", AutoKeyAlpha, OPTION_FLAG_DISABLED)
				WidgetVisDelayOption = AddSliderOption("", WidgetVisDelay, "${0} Seconds", OPTION_FLAG_DISABLED)
			EndIf
			WidgetDiseaseOption = AddToggleOption("$Track Disease", WidgetDisease)
		Else
			SetCursorFillMode(TOP_TO_BOTTOM)
			EnableModOption = AddMenuOption("$iNeed Status:", StatusList[Status], OPTION_FLAG_DISABLED)
		EndIf
	ElseIf Page == "$Guide"
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$Basics")
		InfoConsumptionOption = AddTextOption("$Tending Needs", None)
		InfoPenaltiesOption = AddTextOption("$Buffs and Debuffs", None)
		InfoWaterskinsOption = AddTextOption("$Obtaining Waterskins", None)
		InfoRefillsOption = AddTextOption("$Refilling Waterskins", None)
		InfoWaterBarrelsOption = AddTextOption("$Water Barrels/Kegs", None)
		InfoWellBucketsOption = AddTextOption("$Water Buckets", None)
		InfoAlcoholOption = AddTextOption("$Alcohol and Skooma", None)
		SetCursorPosition(1)
		AddHeaderOption("$Advanced")
		InfoRandomizationOption = AddTextOption("$Randomization", None)
		InfoSnowHydrationOption = AddTextOption("$Snow Hydration", None)
		InfoLargeSaltPileOption = AddTextOption("$Meat Preservation", None)
		InfoFoodSpoilageWorldOption = AddTextOption("$Spoilage in the World", None)
		InfoFoodSpoilageLimitsOption = AddTextOption("$Spoilage Limitations", None)
		InfoCureDangDiseaseOption = AddTextOption("$Curing Dangerous Diseases", None)
		InfoInteractionFollowersOption = AddTextOption("$Interaction Followers", None)
		InfoINeedsRestartUpdateOption = AddTextOption("$INeeds Restart Update", None)
		SetCursorPosition(1)
	EndIf
EndEvent

;====================================================================================

Event OnOptionSelect(Int Option)
	If Option == RestartOption
		Restart = !Restart
		SetToggleOptionValue(RestartOption, Restart)
	ElseIf Option == NotifAutoTextOption
		NotifAutoText = !NotifAutoText
		SetToggleOptionValue(NotifAutoTextOption, NotifAutoText)
	ElseIf Option == AutoHungerOption
		AutoHunger = !AutoHunger
		SetToggleOptionValue(AutoHungerOption, AutoHunger)
		ForcePageReset()
	ElseIf Option == AutoThirstOption
		AutoThirst = !AutoThirst
		SetToggleOptionValue(AutoThirstOption, AutoThirst)
		ForcePageReset()
	ElseIf Option == FollowerPurchaseOption
		FollowerPurchase = !FollowerPurchase
		SetToggleOptionValue(FollowerPurchaseOption, FollowerPurchase)
	ElseIf Option == HorseNeedsOption
		HorseNeeds = !HorseNeeds
		SetToggleOptionValue(HorseNeedsOption, HorseNeeds)
	ElseIf Option == CannibalismOption
		Cannibalism = !Cannibalism
		SetToggleOptionValue(CannibalismOption, Cannibalism)
	ElseIf Option == DiseaseNotifOption
		DiseaseNotif = !DiseaseNotif
		SetToggleOptionValue(DiseaseNotifOption, DiseaseNotif)
	ElseIf Option == FoodNoEffectOption
		FoodNoEffect = !FoodNoEffect
		SetToggleOptionValue(FoodNoEffectOption, FoodNoEffect)
	ElseIf Option == NoSaltOption
		NoSalt = !NoSalt
		SetToggleOptionValue(NoSaltOption, NoSalt)
	ElseIf Option == CategorizeOption
		Categorize = !Categorize
		SetToggleOptionValue(CategorizeOption, Categorize)
	ElseIf Option == HarmfulRawOption
		HarmfulRaw = !HarmfulRaw
		SetToggleOptionValue(HarmfulRawOption, HarmfulRaw)
	ElseIf Option == AdrenalineOption
		Adrenaline = !Adrenaline
		SetToggleOptionValue(AdrenalineOption, Adrenaline)
	ElseIf Option == ActionsSpellOption
		ActionsSpell = !ActionsSpell
		SetToggleOptionValue(ActionsSpellOption, ActionsSpell)
	ElseIf Option == WidgetDiseaseOption
		WidgetDisease = !WidgetDisease
		SetToggleOptionValue(WidgetDiseaseOption, WidgetDisease)
	ElseIf Option == DeathOption
		Death = !Death
		SetToggleOptionValue(DeathOption, Death)
	ElseIf Option == UnknownAllOption
		UnknownAll = !UnknownAll
		SetToggleOptionValue(UnknownAllOption, UnknownAll)
	ElseIf Option == AlcoholDehydratesOption
		AlcoholDehydrates = !AlcoholDehydrates
		SetToggleOptionValue(AlcoholDehydratesOption, AlcoholDehydrates)
	ElseIf Option == ValuedHarvestsOption
		ValuedHarvests = !ValuedHarvests
		If ValuedHarvests
			_SNQuest._SNValuedHarvestsDialogueToggle.SetValue(1)
		Else
			_SNQuest._SNValuedHarvestsDialogueToggle.SetValue(0)
		EndIf
		SetToggleOptionValue(ValuedHarvestsOption, ValuedHarvests)
	ElseIf Option == AnimationsFollowersOption
		AnimationsFollowers = !AnimationsFollowers
		SetToggleOptionValue(AnimationsFollowersOption, AnimationsFollowers)
	ElseIf Option == DiseaseOption
		Disease = !Disease
		SetToggleOptionValue(DiseaseOption, Disease)
		ForcePageReset()
	ElseIf Option == ForceThirdOption
		If ForceThird == 0
			ForceThird += 1
		Else
			ForceThird -= 1
		EndIf
		SetTextOptionValue(ForceThirdOption, ForceThirdList[ForceThird])
	ElseIf Option == SetTimescaleOption
		SetTimescale = !SetTimescale
		SetToggleOptionValue(SetTimescaleOption, SetTimescale)
		ForcePageReset()
	ElseIf Option == DefaultColorOption
		If DefaultColor == 0
			DefaultColor += 1
		Else
			DefaultColor -= 1
		EndIf
		SetTextOptionValue(DefaultColorOption, DefaultColorList[DefaultColor])
	ElseIf Option == WidgetOrientOption
		If WidgetOrient == 0
			WidgetOrient += 1
		Else
			WidgetOrient -= 1
		EndIf
		SetTextOptionValue(WidgetOrientOption, WidgetOrientList[WidgetOrient])
	ElseIf Option == PerspectiveOption
		If Perspective == 0
			Perspective += 1
		Else
			Perspective -= 1
		EndIf
		SetTextOptionValue(PerspectiveOption, PerspectiveList[Perspective])
	ElseIf Option == FoodPriorityOption
		If FoodPriority == 0
			FoodPriority += 1
		Else
			FoodPriority -= 1
		EndIf
		SetTextOptionValue(FoodPriorityOption, FoodPriorityList[FoodPriority])
	ElseIf Option == InfoWaterskinsOption
		ShowMessage("$SNWaterskins")
	ElseIf Option == InfoRefillsOption
		ShowMessage("$SNRefills")
	ElseIf Option == InfoWaterBarrelsOption
		ShowMessage("$SNWaterBarrelsKegs")
	ElseIf Option == InfoWellBucketsOption
		ShowMessage("$SNWaterBuckets")
	ElseIf Option == InfoConsumptionOption
		ShowMessage("$SNTendingNeeds")
	ElseIf Option == InfoAlcoholOption
		ShowMessage("$SNAlcohol")
	ElseIf Option == InfoPenaltiesOption
		ShowMessage("$SNPenalties")
	ElseIf Option == InfoRandomizationOption
		ShowMessage("$SNRandomization")
	ElseIf Option == InfoFoodSpoilageLimitsOption
		ShowMessage("$SNFoodSpoilageLimits")
	ElseIf Option == InfoFoodSpoilageWorldOption
		ShowMessage("$SNFoodSpoilageWorld")
	ElseIf Option == InfoLargeSaltPileOption
		ShowMessage("$SNMeatPreservation")
	ElseIf Option == InfoCureDangDiseaseOption
		ShowMessage("$SNCureDisease")
	ElseIf Option == InfoSnowHydrationOption
		ShowMessage("$SNSnowHydration")
	ElseIf Option == InfoInteractionFollowersOption
		ShowMessage("$SNInteractionFollowers")
	ElseIf Option == InfoINeedsRestartUpdateOption
		ShowMessage("$SNINeedsRestartUpdate")
	EndIf
EndEvent

;====================================================================================

Event OnOptionMenuOpen(Int Option)
	If Option == NotifHUDOption
		SetMenuDialogOptions(NotifHUDList)
		SetMenuDialogStartIndex(NotifHUD)
		SetMenuDialogDefaultIndex(2)
	ElseIf Option == WidgetPosOption
		SetMenuDialogOptions(WidgetPosList)
		SetMenuDialogStartIndex(WidgetPos)
		SetMenuDialogDefaultIndex(2)
	ElseIf Option == EnableModOption
		SetMenuDialogOptions(StatusList)
		SetMenuDialogStartIndex(Status)
		SetMenuDialogDefaultIndex(1)
	ElseIf Option == AnimationsOption
		SetMenuDialogOptions(AnimationsList)
		SetMenuDialogStartIndex(Animations)
		SetMenuDialogDefaultIndex(0)
	ElseIf Option == DisplayPercentOption
		SetMenuDialogOptions(DisplayPercentList)
		SetMenuDialogStartIndex(DisplayPercent)
		SetMenuDialogDefaultIndex(0)
	ElseIf Option == NotifTextOption
		SetMenuDialogOptions(NotifTextList)
		SetMenuDialogStartIndex(NotifTxt)
		SetMenuDialogDefaultIndex(0)
	ElseIf Option == FollowerNeedsTypeOption
		SetMenuDialogOptions(FollowerNeedsTypeList)
		SetMenuDialogStartIndex(FollowerNeedsType)
		SetMenuDialogDefaultIndex(0)
	ElseIf Option == FollowerMealsOption
		SetMenuDialogOptions(FollowerMealsList)
		SetMenuDialogStartIndex(FollowerMeals)
		SetMenuDialogDefaultIndex(3)
	ElseIf Option == FoodRemovalOption
		SetMenuDialogOptions(FoodRemovalList)
		SetMenuDialogStartIndex(FoodRemoval)
		SetMenuDialogDefaultIndex(0)
	ElseIf Option == ImpairmentOption
		SetMenuDialogOptions(ImpairmentList)
		SetMenuDialogStartIndex(Impairment)
		SetMenuDialogDefaultIndex(3)
	ElseIf Option == FoodStatsOption
		SetMenuDialogOptions(FoodStatsList)
		SetMenuDialogStartIndex(FoodStats)
		SetMenuDialogDefaultIndex(1)
	ElseIf Option == VampireOption
		SetMenuDialogOptions(VampireList)
		SetMenuDialogStartIndex(Vampire)
		SetMenuDialogDefaultIndex(1)
	ElseIf Option == VisibleWaterskinsOption
		SetMenuDialogOptions(VisibleWaterskinsList)
		SetMenuDialogStartIndex(VisibleWaterskins)
		SetMenuDialogDefaultIndex(3)						;change default
	EndIf
EndEvent

Event OnOptionMenuAccept(Int Option, Int Index)
	If Option == NotifHUDOption
		NotifHUD = Index
		SetMenuOptionValue(NotifHUDOption, NotifHUDList[NotifHUD])
	ElseIf Option == WidgetPosOption
		WidgetPos = Index
		SetMenuOptionValue(WidgetPosOption, WidgetPosList[WidgetPos])
		WidgetXOffset = 0
		WidgetYOffset = 0
		If WidgetPos == 6 || WidgetPos == 7
			WidgetOrient = 1
		EndIf
	ElseIf Option == EnableModOption
		Status = Index
		SetMenuOptionValue(EnableModOption, StatusList[Status])
	ElseIf Option == NotifTextOption
		NotifTxt = Index
		SetMenuOptionValue(NotifTextOption, NotifTextList[NotifTxt])
	ElseIf Option == AnimationsOption
		Animations = Index
		SetMenuOptionValue(AnimationsOption, AnimationsList[Animations])
	ElseIf Option == FollowerNeedsTypeOption
		FollowerNeedsType = Index
		SetMenuOptionValue(FollowerNeedsTypeOption, FollowerNeedsTypeList[FollowerNeedsType])
	ElseIf Option == FollowerMealsOption
		FollowerMeals = Index
		SetMenuOptionValue(FollowerMealsOption, FollowerMealsList[FollowerMeals])
	ElseIf Option == FoodRemovalOption
		FoodRemoval = Index
		SetMenuOptionValue(FoodRemovalOption, FoodRemovalList[FoodRemoval])
	ElseIf Option == ImpairmentOption
		Impairment = Index
		SetMenuOptionValue(ImpairmentOption, ImpairmentList[Impairment])
	ElseIf Option == FoodStatsOption
		FoodStats = Index
		SetMenuOptionValue(FoodStatsOption, FoodStatsList[FoodStats])
	ElseIf Option == VampireOption
		Vampire = Index
		SetMenuOptionValue(VampireOption, VampireList[Vampire])
	ElseIf Option == DisplayPercentOption
		DisplayPercent = Index
		SetMenuOptionValue(DisplayPercentOption, DisplayPercentList[DisplayPercent])
	ElseIf Option == VisibleWaterskinsOption
		VisibleWaterskins = Index
		SetMenuOptionValue(VisibleWaterskinsOption, VisibleWaterskinsList[VisibleWaterskins])
	EndIf
	ForcePageReset()
EndEvent

;====================================================================================

Event OnOptionSliderOpen(Int Option)
	If Option == HungerRateOption
		SetSliderDialogStartValue(HungerRate)
		SetSliderDialogDefaultValue(4.0)
		SetSliderDialogRange(0.0, 7.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == ThirstRateOption
		SetSliderDialogStartValue(ThirstRate)
		SetSliderDialogDefaultValue(4.0)
		SetSliderDialogRange(0.0, 7.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == CombatIncreaseNeedsOption
		SetSliderDialogStartValue(CombatIncreaseNeeds)
		SetSliderDialogDefaultValue(4.0)
		SetSliderDialogRange(0.0, 7.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == FollowerHungerRateOption
		SetSliderDialogStartValue(FollowerHungerRate)
		SetSliderDialogDefaultValue(4.0)
		SetSliderDialogRange(1.0, 7.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == FollowerThirstRateOption
		SetSliderDialogStartValue(FollowerThirstRate)
		SetSliderDialogDefaultValue(4.0)
		SetSliderDialogRange(1.0, 7.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == FatigueRateOption
		SetSliderDialogStartValue(FatigueRate)
		SetSliderDialogDefaultValue(4.0)
		SetSliderDialogRange(0.0, 7.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == HungerVolOption
		SetSliderDialogStartValue(HungerVol)
		SetSliderDialogDefaultValue(0.5)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.1)
	ElseIf Option == FoodMultOption
		SetSliderDialogStartValue(FoodMult)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.5, 1.5)
		SetSliderDialogInterval(0.1)
	ElseIf Option == DrinkMultOption
		SetSliderDialogStartValue(DrinkMult)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.5, 1.5)
		SetSliderDialogInterval(0.1)
	ElseIf Option == ThirstVolOption
		SetSliderDialogStartValue(ThirstVol)
		SetSliderDialogDefaultValue(0.5)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.1)
	ElseIf Option == FatigueVolOption
		SetSliderDialogStartValue(FatigueVol)
		SetSliderDialogDefaultValue(0.5)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.1)
	ElseIf Option == WidgetXOffsetOption
		SetSliderDialogStartValue(WidgetXOffset)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-300.0, 300.0)
		SetSliderDialogInterval(5.0)
	ElseIf Option == WidgetYOffsetOption
		SetSliderDialogStartValue(WidgetYOffset)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-200.0, 200.0)
		SetSliderDialogInterval(5.0)
	ElseIf Option == WidgetAlphaOption
		SetSliderDialogStartValue(WidgetAlpha)
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(5.0, 100.0)
		SetSliderDialogInterval(5.0)
	ElseIf Option == TimescaleValueOption
		SetSliderDialogStartValue(TimescaleValue)
		SetSliderDialogDefaultValue(20.0)
		SetSliderDialogRange(8.0, 20.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == CarryWeightOption
		SetSliderDialogStartValue(CarryWeight)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 200.0)
		SetSliderDialogInterval(50.0)
	ElseIf Option == WidgetVisDelayOption
		SetSliderDialogStartValue(WidgetVisDelay)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 20.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == BreakableWaterskinsOption
		SetSliderDialogStartValue(BreakableWaterskins)
		SetSliderDialogDefaultValue(4.0)
		SetSliderDialogRange(0.0, 7.0)
		SetSliderDialogInterval(1.0)
	ElseIf Option == RawFreshnessOption
		SetSliderDialogStartValue(RawFreshness)
		SetSliderDialogDefaultValue(0.6)
		SetSliderDialogRange(0.2, 6.0)
		SetSliderDialogInterval(0.1)
	ElseIf Option == LightFreshnessOption
		SetSliderDialogStartValue(LightFreshness)
		SetSliderDialogDefaultValue(5.0)
		SetSliderDialogRange(1.1, 14.0)
		SetSliderDialogInterval(0.1)
	ElseIf Option == MedFreshnessOption
		SetSliderDialogStartValue(MedFreshness)
		SetSliderDialogDefaultValue(1.1)
		SetSliderDialogRange(0.3, 9.0)
		SetSliderDialogInterval(0.1)
	ElseIf Option == HeavyFreshnessOption
		SetSliderDialogStartValue(HeavyFreshness)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.3, 9.0)
		SetSliderDialogInterval(0.1)
	EndIf
EndEvent

Event OnOptionSliderAccept(Int Option, Float Value)
	If Option == HungerRateOption
		HungerRate = Value as Int
		SetSliderOptionValue(HungerRateOption, HungerRate, "{0}")
		ForcePageReset()
	ElseIf Option == ThirstRateOption
		ThirstRate = Value as Int
		SetSliderOptionValue(ThirstRateOption, ThirstRate, "{0}")
		ForcePageReset()
	ElseIf Option == CombatIncreaseNeedsOption
		CombatIncreaseNeeds = Value as Int
		SetSliderOptionValue(CombatIncreaseNeedsOption, CombatIncreaseNeeds, "{0}")
	ElseIf Option == FollowerHungerRateOption
		FollowerHungerRate = Value as Int
		SetSliderOptionValue(FollowerHungerRateOption, FollowerHungerRate, "{0}")
	ElseIf Option == FollowerThirstRateOption
		FollowerThirstRate = Value as Int
		SetSliderOptionValue(FollowerThirstRateOption, FollowerThirstRate, "{0}")
	ElseIf Option == FatigueRateOption
		FatigueRate = Value as Int
		SetSliderOptionValue(FatigueRateOption, FatigueRate, "{0}")
	ElseIf Option == FoodMultOption
		FoodMult = Value
		SetSliderOptionValue(FoodMultOption, FoodMult, "{1}")
	ElseIf Option == DrinkMultOption
		DrinkMult = Value
		SetSliderOptionValue(DrinkMultOption, DrinkMult, "{1}")
	ElseIf Option == HungerVolOption
		HungerVol = Value
		SetSliderOptionValue(HungerVolOption, HungerVol, "{1}")
	ElseIf Option == ThirstVolOption
		ThirstVol = Value
		SetSliderOptionValue(ThirstVolOption, ThirstVol, "{1}")
	ElseIf Option == FatigueVolOption
		FatigueVol = Value
		SetSliderOptionValue(FatigueVolOption, FatigueVol, "{1}")
	ElseIf Option == WidgetXOffsetOption
		WidgetXOffset = Value as Int
		SetSliderOptionValue(WidgetXOffsetOption, WidgetXOffset, "{0}")
	ElseIf Option == WidgetYOffsetOption
		WidgetYOffset = Value as Int
		SetSliderOptionValue(WidgetYOffsetOption, WidgetYOffset, "{0}")
	ElseIf Option == WidgetAlphaOption
		WidgetAlpha = Value
		SetSliderOptionValue(WidgetAlphaOption, WidgetAlpha, "{0}")
	ElseIf Option == TimescaleValueOption
		TimescaleValue = Value as Int
		SetSliderOptionValue(TimescaleValueOption, TimescaleValue, "{0}")
	ElseIf Option == CarryWeightOption
		CarryWeight = Value as Int
		SetSliderOptionValue(CarryWeightOption, CarryWeight, "{0}")
	ElseIf Option == WidgetVisDelayOption
		WidgetVisDelay = Value
		SetSliderOptionValue(WidgetVisDelayOption, WidgetVisDelay, "${0} Seconds")
	ElseIf Option == BreakableWaterskinsOption
		BreakableWaterskins = Value as Int
		SetSliderOptionValue(BreakableWaterskinsOption, BreakableWaterskins, "{0}")
	ElseIf Option == RawFreshnessOption
		RawFreshness = Value
		SetSliderOptionValue(RawFreshnessOption, RawFreshness, "${1} Days")
	ElseIf Option == LightFreshnessOption
		LightFreshness = Value
		SetSliderOptionValue(LightFreshnessOption, LightFreshness, "${1} Days")
	ElseIf Option == MedFreshnessOption
		MedFreshness = Value
		SetSliderOptionValue(MedFreshnessOption, MedFreshness, "${1} Days")
	ElseIf Option == HeavyFreshnessOption
		HeavyFreshness = Value
		SetSliderOptionValue(HeavyFreshnessOption, HeavyFreshness, "${1} Days")
	EndIf
EndEvent

;====================================================================================

Event OnOptionKeyMapChange(Int Option, Int KeyCode, String ConflictControl, String ConflictName)
	If Option == AutoKeyEatOption
		UnregisterForKey(AutoKeyEat)
		AutoKeyEat = KeyCode
		SetKeyMapOptionValue(AutoKeyEatOption, AutoKeyEat, OPTION_FLAG_WITH_UNMAP)
	ElseIf Option == AutoKeyDrinkOption
		UnregisterForKey(AutoKeyDrink)
		AutoKeyDrink = KeyCode
		SetKeyMapOptionValue(AutoKeyDrinkOption, AutoKeyDrink, OPTION_FLAG_WITH_UNMAP)
	ElseIf Option == AutoKeyRestOption
		UnregisterForKey(AutoKeyRest)
		AutoKeyRest = KeyCode
		SetKeyMapOptionValue(AutoKeyRestOption, AutoKeyRest, OPTION_FLAG_WITH_UNMAP)
	ElseIf Option == AutoKeyNeedsOption
		UnregisterForKey(AutoKeyNeeds)
		AutoKeyNeeds = KeyCode
		SetKeyMapOptionValue(AutoKeyNeedsOption, AutoKeyNeeds, OPTION_FLAG_WITH_UNMAP)
	ElseIf Option == AutoKeyAlphaOption
		UnregisterForKey(AutoKeyAlpha)
		AutoKeyAlpha = KeyCode
		SetKeyMapOptionValue(AutoKeyAlphaOption, AutoKeyAlpha, OPTION_FLAG_WITH_UNMAP)
	EndIf
	ForcePageReset()
EndEvent

;====================================================================================

Event OnOptionHighlight(Int Option)
	If Option == FoodRemovalOption
		SetInfoText("$SNFoodRemoval")
	ElseIf Option == FoodStatsOption
		SetInfoText("$SNFoodStats")
	ElseIf Option == FollowerMealsOption
		SetInfoText("$SNFollowerMeals")
	ElseIf Option == NotifTextOption
		SetInfoText("$SNNotifText")
	ElseIf Option == NotifAutoTextOption
		SetInfoText("$SNNotifAutoText")
	ElseIf Option == NotifHUDOption
		SetInfoText("$SNNotifHUD")
	ElseIf Option == WidgetPosOption || Option == WidgetAlphaOption || Option == WidgetXOffsetOption || Option == WidgetYOffsetOption || Option == WidgetOrientOption
		SetInfoText("$SNWidgetMod")
	ElseIf Option == HungerRateOption || Option == FatigueRateOption || Option == ThirstRateOption
		SetInfoText("$SNNeedRate")
	ElseIf Option == FollowerHungerRateOption || Option == FollowerThirstRateOption
		SetInfoText("$SNFollowerRate")
	ElseIf Option == HungerVolOption || Option == FatigueVolOption || Option == ThirstVolOption
		SetInfoText("$SNVol")
	ElseIf Option == SetTimescaleOption || Option == TimescaleValueOption
		SetInfoText("$SNTimescale")
	ElseIf Option == AutoHungerOption || Option == AutoThirstOption
		SetInfoText("$SNAutoNeeds")
	ElseIf Option == CombatIncreaseNeedsOption
		SetInfoText("$SNCombatIncreaseNeeds")
	ElseIf Option == FollowerNeedsTypeOption
		SetInfoText("$SNFollowerNeedsType")
	ElseIf Option == HorseNeedsOption
		SetInfoText("$SNHorseNeeds")
	ElseIf Option == CannibalismOption
		SetInfoText("$SNCannibalism")
	ElseIf Option == VampireOption
		SetInfoText("$SNVampire")
	ElseIf Option == AnimationsOption || Option == ForceThirdOption
		SetInfoText("$SNAnimations")
	ElseIf Option == DeathOption
		SetInfoText("$SNDeath")
	ElseIf Option == UnknownAllOption
		SetInfoText("$SNUnknownAll")
	ElseIf Option == AlcoholDehydratesOption
		SetInfoText("$SNAlcoholDehydrates")
	ElseIf Option == DiseaseOption
		SetInfoText("$SNDangDisease")
	ElseIf Option == FoodNoEffectOption
		SetInfoText("$SNFoodNoEffect")
	ElseIf Option == AnimationsFollowersOption
		SetInfoText("$SNAnimationsFollowers")
	ElseIf Option == FoodMultOption || Option == DrinkMultOption
		SetInfoText("$SNFoodMult")
	ElseIf Option == AutoKeyEatOption
		SetInfoText("$SNAutoKeyEat")
	ElseIf Option == AutoKeyDrinkOption
		SetInfoText("$SNAutoKeyDrink")
	ElseIf Option == AutoKeyRestOption
		SetInfoText("$SNAutoKeyRest")
	ElseIf Option == AutoKeyNeedsOption
		SetInfoText("$SNAutoKeyStatus")
	ElseIf Option == PerspectiveOption
		SetInfoText("$SNPerspective")
	ElseIf Option == NoSaltOption
		SetInfoText("$SNNoSalt")
	ElseIf Option == CategorizeOption
		SetInfoText("$SNCategorize")
	ElseIf Option == HarmfulRawOption
		SetInfoText("$SNHarmfulRaw")
	ElseIf Option == AdrenalineOption
		SetInfoText("$SNAdrenaline")
	ElseIf Option == ActionsSpellOption
		SetInfoText("$SNActionsSpell")
	ElseIf Option == AutoKeyAlphaOption
		SetInfoText("$SNToggleWidgets")
	ElseIf Option == CarryWeightOption
		SetInfoText("$SNCarryWeight")
	ElseIf Option == DisplayPercentOption
		SetInfoText("$SNSpoilDescriptor")
	ElseIf Option == DefaultColorOption
		SetInfoText("$SNDefaultColor")
	ElseIf Option == ImpairmentOption
		SetInfoText("$SNSubstanceImpairment")
	ElseIf Option == WidgetVisDelayOption
		SetInfoText("$SNAutoKeyAlpha")
	ElseIf Option == FoodPriorityOption
		SetInfoText("$SNFoodPriority")
	ElseIf Option == BreakableWaterskinsOption
		SetInfoText("$SNBreakableWaterskins")
	ElseIf Option == WidgetDiseaseOption
		SetInfoText("$SNWidgetDisease")
	ElseIf Option == DiseaseNotifOption
		SetInfoText("$SNDiseaseNotif")
	ElseIf Option == FollowerPurchaseOption
		SetInfoText("$SNFollowerPurchase")
	ElseIf Option == ValuedHarvestsOption
		SetInfoText("$SNHarvests")
	ElseIf Option == VisibleWaterskinsOption
		SetInfoText("$SNVisibleWaterskins")
	ElseIf Option == RawFreshnessOption || Option == LightFreshnessOption || Option == MedFreshnessOption || Option == HeavyFreshnessOption
		SetInfoText("$SNFreshness")
	EndIf
EndEvent

;====================================================================================

Event OnKeyDown(Int KeyCode)
	Actor targ = _SNQuest.PlayerRef
	UnregisterForKey(AutoKeyAlpha)
	UnregisterForKey(AutoKeyEat)
	UnregisterForKey(AutoKeyDrink)
	UnregisterForKey(AutoKeyNeeds)
	If !UI.IsTextInputEnabled() && !Utility.IsInMenuMode()
		If KeyCode == AutoKeyAlpha
			Utility.Wait(0.25)
			If Input.IsKeyPressed(AutoKeyAlpha)
				_SNQuest.CheckInventory()
			Else
				If WidgetVisDelay == 0.0
					_SNQuest.WidgetHide = !_SNQuest.WidgetHide
					SendModEvent("_SN_UIConfigured")
				ElseIf _SNQuest.WidgetHide
					_SNQuest.WidgetHide = False
					SendModEvent("_SN_UIConfigured")
					Utility.Wait(WidgetVisDelay)
					If WidgetVisDelay != 0.0 && !_SNQuest.WidgetHide
						_SNQuest.WidgetHide = True
						SendModEvent("_SN_UIConfigured")
					EndIf
				EndIf
			EndIf
			Utility.Wait(0.75)
		ElseIf KeyCode == AutoKeyEat
			Utility.Wait(0.25)
			If Input.IsKeyPressed(AutoKeyEat)
				If FoodPriority == 1
					_SNQuest.FoodPriority = 0
				Else
					_SNQuest.FoodPriority = 1
				EndIf
				_SNQuest.AutoEat(targ)
				_SNQuest.FoodPriority = FoodPriority
			Else
				_SNQuest.AutoEat(targ)
			EndIf
			Utility.Wait(0.75)
		ElseIf KeyCode == AutoKeyDrink
			Utility.Wait(0.25)
			If Input.IsKeyPressed(AutoKeyDrink)
				;Debug.Notification(targ.GetPositionX() as Int+", "+targ.GetPositionY() as Int)						;DEBUG
				If _SNQuest.IsInWater && !_SNQuest.IsInSaltWater()
					If !targ.IsRunning() && !targ.IsSprinting()
						If _SNQuest.IsSafeLocation(targ.GetCurrentLocation())
							If _SNQuest.Refill(targ, true)
								If !_SNQuest.RefillAnimate
									_SNQuest._SNWaterskinWaterBodyRefillLP.Play(targ)
								EndIf
							Else
								If _SNQuest.NotifAutoText
									Debug.Notification(_SNQuest.DrinkWaterText)
								EndIf
								_SNQuest.Drink(targ)
							EndIf
						Else
							If _SNQuest.RefillUnknown(targ)
								If !_SNQuest.RefillAnimate
									_SNQuest._SNWaterskinWaterBodyRefillLP.Play(targ)
								EndIf
							Else
								If !UnknownWarning
									Debug.Notification(_SNQuest.UnknownWaterText)
									UnknownWarning = True
									RegisterForSingleUpdate(10.0)
								Else
									_SNQuest.Drink(targ)
									_SNQuest.DiseaseRoll()
									RegisterForSingleUpdate(0.0)
								EndIf
							EndIf
						EndIf
					EndIf
				ElseIf Game.FindClosestReferenceOfAnyTypeInListFromRef(_SNQuest._SNSnowStatList, targ, 384.0)
					_SNQuest._SNSnowGatherLP.PlayandWait(targ)
					targ.Additem(_SNQuest._SNSnowPile, Utility.RandomInt(1, 2))
				Else
					Debug.Notification(_SNQuest.NoWaterSourceText)
				EndIf
				Utility.Wait(0.75)
			Else
				_SNQuest.AutoDrink(targ)
				Utility.Wait(0.75)
			EndIf
		ElseIf KeyCode == AutoKeyRest
			Game.ForceThirdPerson()
			Game.DisablePlayerControls(false, false, true, false, false, false, false)
			Debug.SendAnimationEvent(targ, "IdleSitCrossLeggedEnter")
			_SNQuest.IsSitting = True
			Utility.Wait(0.25)
			If Input.IsKeyPressed(AutoKeyRest) && FollowerNeedsType > 0
				SendModEvent("_SN_PlayerSits")
			EndIf
			RegisterForAnimationEvent(_SNQuest.PlayerRef, "JumpUp")
			Utility.Wait(0.75)
		Else
			Utility.Wait(0.25)
			If Input.IsKeyPressed(AutoKeyNeeds)
				_SNQuest.CheckInventory()
			Else
				_SNQuest.CheckStatus()
			EndIf
			Utility.Wait(0.75)
		EndIf
	Else
		Utility.Wait(1.0)
	EndIf
	If AutoKeyAlpha > -1
		RegisterForKey(AutoKeyAlpha)
	EndIf
	If AutoKeyEat > -1
		RegisterForKey(AutoKeyEat)
	EndIf
	If AutoKeyDrink > -1
		RegisterForKey(AutoKeyDrink)
	EndIf
	If AutoKeyNeeds > -1
		RegisterForKey(AutoKeyNeeds)
	EndIf
EndEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	Game.EnablePlayerControls()
	_SNQuest.IsSitting = False
	SendModEvent("_SN_PlayerSits", "Jumping")
	UnregisterForAnimationEvent(_SNQuest.PlayerRef, "JumpUp")
EndEvent

Event OnConfigClose()
	ApplySettings()
EndEvent

Event OnUpdate()
	UnknownWarning = False
EndEvent