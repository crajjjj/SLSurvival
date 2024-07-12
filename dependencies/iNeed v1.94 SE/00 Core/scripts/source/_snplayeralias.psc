Scriptname _SNPlayerAlias extends ReferenceAlias  

;====================================================================================

Message Property _SNFoodSaltMsg Auto
Message Property _SNWaterUnknownMsg Auto
Message Property _SNFoodUnknownDrinkMsg Auto
Message Property _SNFoodUnknownFoodMsg Auto
Message Property _SNFoodUnknownFoodSpoilMsg Auto
Message Property _SNFoodUnknownMsg Auto

Keyword Property _SNThirstServing Auto
Keyword Property _SNThirstServing_Unknown Auto
Keyword Property FurnitureSpecial Auto

Quest Property _SNApplyFollowerQuest Auto

Form Food

_SNQuestScript Property _SNQuest Auto
_SNDLCQuestScript Property _SNDLCQuest Auto

Float HungerChange
Float HungerRandom
Float ThirstChange
Float ThirstRandom
Float FatigueChange
Float FatigueRandom
Float HungerState
Float ThirstState
Float FatigueState

Bool AnimationPlaying

Int BreakableWaterskins
Int FollowerEatCount
Int ActionCount
Int BreakCount
Int DiseaseStage
Int HasSalmonella
Int SitCount
Int WaterskinSaltCount
Int Waterskin03Count
Int Waterskin02Count
Int ArrayIndex = -1

Actor targ

;====================================================================================

Int Function FormIndex(Form[] MyArray, Form MyForm)
	Int i = 0
	While i < MyArray.Length
		If MyArray[i] == MyForm
			Return i
		Else
			i += 1
		EndIf
	EndWhile
	Return -1
EndFunction

Function CheckRecentFood(Form FoodItem)
	If _SNQuest.HungerState < 110.0
		Form[] FoodRecentList = _SNQuest.FoodRecentList
		If ArrayIndex > 2
			ArrayIndex = 0
		Else
			ArrayIndex += 1
		EndIf
		FoodRecentList[ArrayIndex] = FoodItem
		If FoodRecentList[0] == FoodRecentList[1] && FoodRecentList[0] == FoodRecentList[2] && FoodRecentList[0] == FoodRecentList[3] && FoodRecentList[1] == FoodRecentList[2] && FoodRecentList[1] == FoodRecentList[3] && FoodRecentList[2] == FoodRecentList[3]
			_SNQuest.VariedDietCount -= 2
		ElseIf FoodRecentList[0] != FoodRecentList[1] && FoodRecentList[0] != FoodRecentList[2] && FoodRecentList[1] != FoodRecentList[2]
			_SNQuest.VariedDietCount += 1
		EndIf
	EndIf
EndFunction

Function HarmfulRawFood()
	If !targ.HasKeyword(_SNQuest.Vampire) && !_SNQuest.IsWerewolfHuman
		If ThirstState > 0.0
			SetNeedsChange(Utility.RandomFloat(2.5, 25.0), Utility.RandomFloat(1.0, 4.0), 0.0, 0)
		Else
			SetNeedsChange(Utility.RandomFloat(2.5, 25.0), 0.0, 0.0, 0)
		EndIf
		If _SNQuest._SNDiseaseToggle.GetValue() as Int == 1
			If HasSalmonella == 0 && !_SNQuest.IsVanillaDiseased && _SNQuest._SNDiseaseStage.GetValue() as Int == 0 && Utility.RandomInt(1, 3) == 2
				_SNQuest.CauseStomachRot()
			EndIf
		ElseIf Utility.RandomInt(1, 3) == 2
			_SNQuest.CauseStomachRot(true)
		EndIf
	EndIf
EndFunction

Function PlayConsumeIdles(Float Thirst, Int Animation)
	If Thirst >= 25.0
		If targ.GetSitState() == 0
			If Animation == 2
				Debug.SendAnimationEvent(targ, "idleDrinkingStandingStart")
				Utility.Wait(7.5)
				targ.PlayIdle(_SNQuest.IdleStop_Loose)
			EndIf
		Else
			Debug.SendAnimationEvent(targ, "ChairDrinkingStart")
		EndIf
	Else
		If Animation == 2
			Debug.SendAnimationEvent(targ, "idleEatingStandingStart")
			Utility.Wait(7.0)
			targ.PlayIdle(_SNQuest.IdleStop_Loose)
		EndIf
		Debug.SendAnimationEvent(targ, "ChairEatingStart")
	EndIf
EndFunction

Function AnimationStart(Float ThirstValue, Int AnimateOption)
	If targ.GetAnimationVariableInt("i1stPerson") as Int == 1
		If _SNQuest.ForceThird
			Game.ForceThirdPerson()
		EndIf
		PlayConsumeIdles(ThirstValue, AnimateOption)
		If !_SNQuest.IsSitting && _SNQuest.ForceThird
			Game.ForceFirstPerson()
		EndIf
	Else
		PlayConsumeIdles(ThirstValue, AnimateOption)
	EndIf
EndFunction

;====================================================================================

Function RemoveFromAllLists(FormList FoodList)
	_SNQuest._SNFood_MedList.RemoveAddedForm(Food)
	_SNQuest._SNFood_SoupList.RemoveAddedForm(Food)
	_SNQuest._SNFood_HeavyList.RemoveAddedForm(Food)
	_SNQuest._SNFood_LightList.RemoveAddedForm(Food)
	_SNQuest._SNFood_DrinkList.RemoveAddedForm(Food)
	_SNQuest._SNFood_DrinkNoAlcList.RemoveAddedForm(Food)
	_SNQuest._SNFood_RawList.RemoveAddedForm(Food)
	_SNQuest._SNFood_NoSpoilList.RemoveAddedForm(Food)
	FoodList.AddForm(Food)
EndFunction

Function IdentifyFood()
	If _SNQuest._SNFood_MedList.HasForm(Food)
		Debug.Notification(_SNQuest.RecategorizeStartText+_SNQuest.RecategorizeMedText)
	ElseIf _SNQuest._SNFood_SoupList.HasForm(Food)
		Debug.Notification(_SNQuest.RecategorizeStartText+_SNQuest.RecategorizeSoupText)
	ElseIf _SNQuest._SNFood_HeavyList.HasForm(Food)
		Debug.Notification(_SNQuest.RecategorizeStartText+_SNQuest.RecategorizeHeavyText)
	ElseIf _SNQuest._SNFood_LightList.HasForm(Food)
		Debug.Notification(_SNQuest.RecategorizeStartText+_SNQuest.RecategorizeLightText)
	ElseIf _SNQuest._SNFood_DrinkList.HasForm(Food)
		Debug.Notification(_SNQuest.RecategorizeStartText+_SNQuest.RecategorizeDrinkText)
	ElseIf _SNQuest._SNFood_DrinkNoAlcList.HasForm(Food)
		Debug.Notification(_SNQuest.RecategorizeStartText+_SNQuest.RecategorizeDrinkNoAlcText)
	ElseIf _SNQuest._SNFood_RawList.HasForm(Food)
		Debug.Notification(_SNQuest.RecategorizeStartText+_SNQuest.RecategorizeRawText)
	Else
		Debug.Notification(_SNQuest.RecategorizeStartText+_SNQuest.RecategorizeUnknownText)
	EndIf
EndFunction

Function Categorize()
	Int UnknownOption = _SNFoodUnknownMsg.Show()
	If UnknownOption == 0
		Int UnknownFoodOption = _SNFoodUnknownFoodMsg.Show()
		If UnknownFoodOption == 0
			RemoveFromAllLists(_SNQuest._SNFood_HeavyList)
		ElseIf UnknownFoodOption == 1
			RemoveFromAllLists(_SNQuest._SNFood_MedList)
		ElseIf UnknownFoodOption == 2
			RemoveFromAllLists(_SNQuest._SNFood_SoupList)
		ElseIf UnknownFoodOption == 3
			RemoveFromAllLists(_SNQuest._SNFood_LightList)
		ElseIf UnknownFoodOption == 4
			RemoveFromAllLists(_SNQuest._SNFood_RawList)
		EndIf
		If UnknownFoodOption < 5
			Int UnknownFoodSpoilOption = _SNFoodUnknownFoodSpoilMsg.Show()
			If UnknownFoodSpoilOption == 1
				_SNQuest._SNFood_NoSpoilList.AddForm(Food)
			EndIf
		EndIf
		targ.AddItem(Food, 1, true)
	ElseIf UnknownOption == 1
		Int UnknownDrinkOption = _SNFoodUnknownDrinkMsg.Show()
		If UnknownDrinkOption == 0
			RemoveFromAllLists(_SNQuest._SNFood_DrinkList)
		ElseIf UnknownDrinkOption == 1
			RemoveFromAllLists(_SNQuest._SNFood_DrinkNoAlcList)
		ElseIf UnknownDrinkOption == 2
			RemoveFromAllLists(_SNQuest._SNFood_BloodList)
		EndIf
		targ.AddItem(Food, 1, true)
	ElseIf UnknownOption == 2
		RemoveFromAllLists(_SNQuest._SNFood_IgnoreList)
	Else
		targ.AddItem(Food, 1, true)
	EndIf
EndFunction

;====================================================================================

Function SetAVChange(Float HealthValue, Float MagickaValue, Float StaminaValue)
	If _SNQuest.Restore
		If _SNQuest.HungerState == 110.0
			targ.RestoreActorValue("Health", HealthValue)
		EndIf
		If _SNQuest.ThirstState == 110.0
			targ.RestoreActorValue("Magicka", MagickaValue)
			targ.RestoreActorValue("Stamina", StaminaValue)
		EndIf
	EndIf
EndFunction

Function SetNeedsChange(Float Hunger, Float Thirst, Float Fatigue, Int FollowerEat, Bool Random = True, Bool Idles = True)
	Float SatiationMult = 1.0
	If _SNQuest.FoodSpoilage && Thirst < 24.0 && Idles
		Int iFood = FormIndex(_SNQuest.FoodInventoryList, Food)
		If iFood > -1
			SatiationMult = _SNQuest.SatiationList[iFood] / 100.0
		EndIf
	EndIf
	If Random
		HungerRandom = 0.0
		ThirstRandom = 0.0
		FatigueRandom = 0.0
		If Hunger > 0.0
			HungerRandom = Utility.RandomFloat(-2.5, 2.5)
		EndIf
		If Thirst > 0.0
			ThirstRandom = Utility.RandomFloat(-1.0, 1.0)
		EndIf
		If Fatigue > 0.0
			FatigueRandom = Utility.RandomFloat(-0.1, 0.1)
		EndIf
	EndIf
	HungerChange = Hunger
	ThirstChange = Thirst
	FatigueChange = Fatigue
	FollowerEatCount += FollowerEat
	Int AnimationOption = _SNQuest.Animations
	If !_SNQuest.NoAnimate && !AnimationPlaying && Idles && (AnimationOption == 2 || (AnimationOption == 1 && targ.GetSitState() as Int == 3)) && !_SNQuest.JustSlept
		AnimationPlaying = True
		If targ.IsWeaponDrawn()
			If _SNQuest.SKSEVersion > 0.0
				targ.SheatheWeapon()
				Utility.Wait(2.0)
				AnimationStart(Thirst, AnimationOption)
			EndIf
		Else
			AnimationStart(Thirst, AnimationOption)
		EndIf
		AnimationPlaying = False
	EndIf
	_SNQuest.TimePassed = 0
	DiseaseStage = _SNQuest._SNDiseaseStage.GetValue() as Int
	If _SNQuest._SNDiseaseToggle.GetValue() as Int == 1
		If DiseaseStage == 0 && HasSalmonella == 0 && SatiationMult < 1.0 && Utility.RandomInt(-400, 100) > (SatiationMult * 100.0) as Int
			_SNQuest.CauseStomachRot()
		EndIf
	ElseIf SatiationMult < 1.0 && Utility.RandomInt(-700, 100) > (SatiationMult * 100.0) as Int
		_SNQuest.CauseStomachRot(true)
	EndIf
	If HasSalmonella == 1
		SatiationMult = SatiationMult * 0.9
	ElseIf HasSalmonella == 2
		SatiationMult = SatiationMult * 0.8
	ElseIf HasSalmonella == 3
		SatiationMult = SatiationMult * 0.6
	ElseIf HasSalmonella == 4
		SatiationMult = SatiationMult * 0.2
	EndIf
	If !targ.HasKeyword(_SNQuest.Vampire) || _SNQuest._SNVampWereToggle.GetValue() as Int == 0
		If FatigueState > 0.0
			_SNQuest.ModFatigue((FatigueChange + FatigueRandom) * SatiationMult)
		EndIf
		_SNQuest.ModThirst((ThirstChange + ThirstRandom) * _SNQuest.DrinkMult * SatiationMult)
		_SNQuest.ModHunger((HungerChange + HungerRandom) * _SNQuest.FoodMult * SatiationMult)
	EndIf
	If Thirst > 23.0
		If _SNQuest.ConsumptionNotif
			_SNQuest.CheckStatusThirst()
		EndIf
		If _SNQuest.SKSEVersion > 0.0
			SendModEvent("_SN_PlayerConsumes", "IsDrinking")
		EndIf
	ElseIf Hunger > 0.0
		If _SNQuest.ConsumptionNotif
			_SNQuest.CheckStatusHunger()
		EndIf
		If _SNQuest.SKSEVersion > 0.0
			SendModEvent("_SN_PlayerConsumes", "IsEating")
		EndIf
	EndIf
	;Debug.Notification(_SNQuest.HungerState + " " + _SNQuest.ThirstState)
	;Debug.Notification(SatiationMult)
EndFunction

;====================================================================================

Event OnInit()
	targ = _SNQuest.PlayerRef
	If _SNQuest.SKSEVersion > 0.0
		UnregisterForAnimationEvent(targ, "BeginCastLeft")
		UnregisterForAnimationEvent(targ, "BeginCastRight")
		UnregisterForAnimationEvent(targ, "weaponSwing")
		UnregisterForAnimationEvent(targ, "weaponLeftSwing")
		UnregisterForAnimationEvent(targ, "arrowRelease")
		UnregisterForAnimationEvent(targ, "SoundPlay.WPNSwingUnarmed")
	EndIf
	BreakableWaterskins = 59 - (_SNQuest.BreakableWaterskins * 2)
	If _SNQuest.CombatIncreaseNeeds > 0.0 && _SNQuest.BreakableWaterskins == 0
		GoToState("CombatNeeds")
	ElseIf _SNQuest.CombatIncreaseNeeds == 0.0 && _SNQuest.BreakableWaterskins > 0
		UnregisterForActorAction(0)
		UnregisterForActorAction(2)
		UnregisterForActorAction(6)
		GoToState("Breakable")
	ElseIf _SNQuest.CombatIncreaseNeeds > 0.0 && _SNQuest.BreakableWaterskins > 0
		GoToState("CombatBreakable")
	Else
		UnregisterForActorAction(0)
		UnregisterForActorAction(2)
		UnregisterForActorAction(6)
	EndIf
EndEvent

Event OnPlayerLoadGame()
	_SNQuest.Maintenance()
	OnInit()
EndEvent

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	If _SNQuest.EnableMod && (akBaseObject as Potion || akBaseObject as Ingredient)
		Food = akBaseObject
		If !_SNQuest.Recategorize

			HungerState = _SNQuest.HungerState
			ThirstState = _SNQuest.ThirstState
			FatigueState = _SNQuest.FatigueState
			HasSalmonella = _SNQuest.HasSalmonella

			If Food.HasKeyword(_SNThirstServing)

				If Food == _SNQuest._SNWaterskin_3
					targ.AddItem(_SNQuest._SNWaterskin_2, 1, true)
				ElseIf Food == _SNQuest._SNWaterskin_2
					targ.AddItem(_SNQuest._SNWaterskin_1, 1, true)
				Else
					targ.AddItem(_SNQuest._SNWaterskin_0)
				EndIf
				
				SetAVChange(0.0, 35.0, 35.0)
				SetNeedsChange(0.0, 55.0, 0.5, 3)

			ElseIf Food.HasKeyword(_SNThirstServing_Unknown)

				Int WaterOption = _SNWaterUnknownMsg.Show()

				If WaterOption == 0
					If Food == _SNQuest._SNWaterskin_3_Unknown
						targ.AddItem(_SNQuest._SNWaterskin_2_Unknown, 1, true)
					ElseIf Food == _SNQuest._SNWaterskin_2_Unknown
						targ.AddItem(_SNQuest._SNWaterskin_1_Unknown, 1, true)
					Else
						targ.AddItem(_SNQuest._SNWaterskin_0)
					EndIf
					
					SetAVChange(0.0, 35.0, 35.0)
					SetNeedsChange(0.0, 55.0, 0.5, 3)
					
					If _SNQuest._SNDiseaseToggle.GetValue() as Int == 1
						If DiseaseStage == 0 && Utility.RandomInt(1, 20) == 10
							_SNQuest.CauseStomachRot()
						EndIf
					ElseIf Utility.RandomInt(1, 20) == 10
						_SNQuest.CauseStomachRot(true)
					EndIf
				ElseIf WaterOption == 1
					If Food == _SNQuest._SNWaterskin_3_Unknown
						_SNQuest._SNWaterskinEmptyLP.Play(targ)
						targ.RemoveItem(_SNQuest._SNWaterSkin_3_Unknown, 1, true)
					ElseIf Food == _SNQuest._SNWaterskin_2_Unknown
						_SNQuest._SNWaterskinEmptyLP.Play(targ)
						targ.RemoveItem(_SNQuest._SNWaterSkin_2_Unknown, 1, true)
					Else
						_SNQuest._SNWaterskinEmptyLP.Play(targ)
						targ.RemoveItem(_SNQuest._SNWaterSkin_1_Unknown, 1, true)
					EndIf
					targ.AddItem(_SNQuest._SNWaterskin_0)
					Utility.Wait(0.1)
					Utility.Wait(0.1)
					targ.PlayIdle(_SNQuest.IdleStop_Loose)
				Else
					targ.AddItem(Food, 1, true)
					Utility.Wait(0.1)
					Utility.Wait(0.1)
					targ.PlayIdle(_SNQuest.IdleStop_Loose)
				EndIf
			ElseIf _SNQuest._SNFood_MedList.HasForm(Food)

				CheckRecentFood(Food)
				SetAVChange(35.0, 0.0, 0.0)
				SetNeedsChange(40.0, 0.0, 0.25, 7)
				If !_SNDLCQuest.CACOInstalled
					_SNQuest.CheckCheese(targ, Food)
				EndIF

			ElseIf _SNQuest._SNFood_SoupList.HasForm(Food) || (_SNDLCQuest.HunterbornInstalled && Food.HasKeyword( _SNDLCQuest._DS_KW_Food_Soup ))

				CheckRecentFood(Food)
				SetAVChange(35.0, 20.0, 20.0)
				SetNeedsChange(45.0, 25.0, 0.25, 8)

			ElseIf _SNQuest._SNFood_HeavyList.HasForm(Food)

				CheckRecentFood(Food)
				SetAVChange(45.0, 0.0, 0.0)
				SetNeedsChange(50.0, 0.0, 0.5, 10)

			ElseIf _SNQuest._SNFood_LightList.HasForm(Food)

				CheckRecentFood(Food)
				SetAVChange(25.0, 0.0, 0.0)
				If ThirstState > 0.0
					SetNeedsChange(25.0, 1.0, 0.1, 3)
				Else
					SetNeedsChange(25.0, 0.0, 0.1, 3)
				EndIf
				If !_SNDLCQuest.CACOInstalled
					_SNQuest.CheckCheese(targ, Food)
				EndIF

			ElseIf _SNQuest._SNFood_DrinkList.HasForm(Food)

				If _SNQuest.EnableAlcohol
					_SNQuest.Drunk()
				EndIf
				If _SNQuest.AlcoholDehydrates
					_SNQuest.DrunkAlcohol += 1
				EndIf

				SetAVChange(0.0, 20.0, 20.0)
				If HungerState > 0.0
					SetNeedsChange(7.0, 45.0, 0.25, 3)
				Else
					SetNeedsChange(0.0, 45.0, 0.25, 3)
				EndIf

			ElseIf _SNQuest._SNFood_DrinkNoAlcList.HasForm(Food)

				SetAVChange(0.0, 30.0, 30.0)
				If HungerState > 0.0
					SetNeedsChange(3.0, 50.0, 0.25, 3)
				Else
					SetNeedsChange(0.0, 50.0, 0.25, 3)
				EndIf

			ElseIf _SNQuest._SNFood_DrinkSnowList.HasForm(Food)

				SetAVChange(0.0, 12.5, 12.5)
				SetNeedsChange(-10.0, 25.0, 0.25, 0)

			ElseIf _SNQuest._SNFood_RawList.HasForm(Food)
				If _SNQuest._SNCannibalToggle.GetValue() as Int == 1 && (_SNQuest.PlayerIsWoodelf || targ.IsEquipped(_SNQuest.DA11RingofNamira))
					CheckRecentFood(Food)
					If ThirstState > 0.0
						SetNeedsChange(Utility.RandomFloat(15.0, 40.0), Utility.RandomFloat(1.0, 4.0), 0.0, 0)
					Else
						SetNeedsChange(Utility.RandomFloat(15.0, 40.0), 0.0, 0.0, 0)
					EndIf
				Else
					If _SNQuest.HarmfulRaw
						If _SNQuest.FoodSpoilage
							Int iFood = FormIndex(_SNQuest.FoodInventoryList, Food)
							If iFood > -1 && _SNQuest.SatiationList[iFood] < 101.0
								Int SaltOption = _SNFoodSaltMsg.Show()
								If SaltOption == 0
									If iFood > -1 && _SNQuest.SatiationList[iFood] == 101.0
										SetNeedsChange(Utility.RandomFloat(10.0, 25.0), Utility.RandomFloat(-35.0, -15.0), 0.0, 0)
									Else
										HarmfulRawFood()
									EndIf
								ElseIf SaltOption == 1
									If iFood > -1
										If _SNQuest.SatiationList[iFood] == 100.0
											If targ.GetItemCount(_SNQuest.SaltPile) as Int > 4
												_SNQuest.SatiationList[iFood] = 101.0
												UI.InvokeString("HUD Menu", "_global.skse.CloseMenu", "InventoryMenu")
												targ.RemoveItem(_SNQuest.SaltPile, 7)
												_SNQuest._SNSaltMeatLP.Play(targ)
											Else
												Debug.Notification(_SNQuest.NoSaltText)
											EndIf
										Else
											Debug.Notification(_SNQuest.NoSaltDecayText)
										EndIf
									EndIf
									targ.AddItem(Food, 1, true)
								Else
									targ.AddItem(Food, 1, true)
								EndIf
								Utility.Wait(0.1)
								Utility.Wait(0.1)
								targ.PlayIdle(_SNQuest.IdleStop_Loose)
							Else
								SetNeedsChange(Utility.RandomFloat(10.0, 30.0), Utility.RandomFloat(-45.0, -20.0), 0.0, 0)
							EndIf
						Else
							HarmfulRawFood()
						EndIf
					Else
						If ThirstState > 0.0
							SetNeedsChange(Utility.RandomFloat(10.0, 40.0), Utility.RandomFloat(1.0, 4.0), 0.0, 0)
						Else
							SetNeedsChange(Utility.RandomFloat(10.0, 40.0), 0.0, 0.0, 0)
						EndIf
					EndIf
				EndIf
			ElseIf _SNQuest._SNFood_SkoomaList.HasForm(Food) && _SNQuest.EnableSkooma

				_SNQuest.Skooma()

			ElseIf _SNQuest._SNFood_BloodList.HasForm(Food) && targ.HasKeyword(_SNQuest.Vampire)

				SetAVChange(40.0, 40.0, 40.0)
				_SNQuest.ModFatigue(110.0)
				_SNQuest.ModThirst(110.0)
				_SNQuest.ModHunger(110.0)

			ElseIf Food.HasKeyword(_SNQuest.VendorItemFood) && Utility.IsInMenuMode() && !_SNQuest._SNFood_IgnoreList.HasForm(Food)

				Categorize()
				
			EndIf
		Else
		
			IdentifyFood()
			Categorize()
			
		EndIf

		BreakableWaterskins = 59 - (_SNQuest.BreakableWaterskins * 2)

		If _SNQuest._SNFollowerToggle.GetValue() as Int == 1
			If FollowerEatCount >= 10
				_SNApplyFollowerQuest.Start()
				SitCount = 0
				FollowerEatCount = 0
			EndIf
			RegisterForSingleUpdateGameTime(0.25)
		Else
			FollowerEatCount = 0
		EndIf
	EndIf
	Utility.Wait(0.1)
EndEvent

Event OnSit(ObjectReference akFurniture)
	If akFurniture
		If akFurniture.HasKeyword(_SNQuest.CraftingCookPot)
			WaterskinSaltCount = targ.GetItemCount(_SNQuest._SNWaterSkin_Salt) as Int
			Waterskin03Count = targ.GetItemCount(_SNQuest._SNWaterSkin_3) as Int
			Waterskin02Count = targ.GetItemCount(_SNQuest._SNWaterSkin_2) as Int
			_SNQuest.IsCooking = True
		ElseIf _SNQuest.CraftOven && akFurniture.HasKeyword(_SNQuest.CraftOven)
			_SNQuest.IsCooking = True
		ElseIf !akFurniture.HasKeyword(FurnitureSpecial)
			_SNQuest.IsSitting = True
		EndIf
	EndIf
EndEvent

Event OnGetUp(ObjectReference akFurniture)
	If SitCount > 0
		_SNApplyFollowerQuest.Stop()
		SitCount = 0
	Else
		SitCount += 1
	EndIf
	If akFurniture && akFurniture.HasKeyword(_SNQuest.CraftingCookPot)
		targ.AddItem(_SNquest._SNWaterSkin_0, WaterskinSaltCount - targ.GetItemCount(_SNQuest._SNWaterSkin_Salt) as Int)
		If !_SNDLCQuest.CACOInstalled
			targ.AddItem(_SNquest._SNWaterSkin_1, Waterskin03Count - targ.GetItemCount(_SNQuest._SNWaterSkin_3) as Int)
			targ.AddItem(_SNquest._SNWaterSkin_0, Waterskin02Count - targ.GetItemCount(_SNQuest._SNWaterSkin_2) as Int)
		EndIF
	EndIf
	_SNQuest.IsCooking = False
	_SNQuest.IsSitting = False
	RegisterForSingleUpdate(5.0)
EndEvent

Event OnUpdateGameTime()
	FollowerEatCount = 0
EndEvent

Function CombatBegin()
	RegisterForActorAction(0)
	RegisterForActorAction(2)
	RegisterForActorAction(6)
EndFunction

Function CombatActorAction()
	If _SNQuest.EnableMod
		Float HungerIncrease
		Float ThirstIncrease
		Float FatigueIncrease
		Int iTimescale = _SNQuest.Timescale.GetValue() as Int
		Float TimescaleEightieth = (iTimescale / 80.0) * _SNQuest.CombatIncreaseNeeds
		Float TimescaleFortieth = (iTimescale / 40.0) * _SNQuest.CombatIncreaseNeeds
		If _SNQuest.HasKeyword(_SNQuest.Vampire) && _SNQuest._SNVampWereToggle.GetValue() as Int == 1
			HungerRandom = 0.0
			ThirstRandom = 0.0
			FatigueRandom = Utility.RandomFloat(-TimescaleEightieth / 4.0, TimescaleEightieth / 4.0)
			FatigueIncrease = -TimescaleFortieth / 4.0
		Else
			HungerRandom = Utility.RandomFloat(0.0, TimescaleFortieth)
			ThirstRandom = Utility.RandomFloat(0.0, TimescaleFortieth)
			FatigueRandom = Utility.RandomFloat(-TimescaleEightieth, TimescaleEightieth)
			HungerIncrease = -TimescaleFortieth
			ThirstIncrease = -TimescaleFortieth
			FatigueIncrease = -TimescaleFortieth
		EndIf
		SetNeedsChange(HungerIncrease, ThirstIncrease, FatigueIncrease, 0, false, false)
	EndIf
EndFunction

Function BreakableHit()
	If BreakCount > BreakableWaterskins
		_SNQuest.BreakWater(targ)
		BreakCount = 0
	Else
		BreakCount +=1
	EndIf
EndFunction

State CombatNeeds

	Event OnBeginState()
		CombatBegin()
	EndEvent

	Event OnActorAction(int actionType, Actor akActor, Form source, int slot)
		If ActionCount > 29
			CombatActorAction()
			ActionCount = 0
		Else
			If ActionType == 0
				ActionCount += 1
			ElseIf ActionType == 2
				ActionCount += 2
			Else
				ActionCount += 3
			EndIf
		EndIf
	EndEvent

EndState

State Breakable

	Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
		If akAggressor && akSource as Weapon && !abHitBlocked
			BreakableHit()
		EndIf
	EndEvent

EndState

State CombatBreakable

	Event OnBeginState()
		CombatBegin()
	EndEvent

	Event OnActorAction(int actionType, Actor akActor, Form source, int slot)
		If ActionCount > 29
			CombatActorAction()
			ActionCount = 0
		Else
			If ActionType == 0
				ActionCount += 1
			ElseIf ActionType == 2
				ActionCount += 2
			Else
				ActionCount += 3
			EndIf
		EndIf
	EndEvent

	Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
		If akAggressor && akSource as Weapon && !abHitBlocked
			BreakableHit()
		EndIf
	EndEvent

EndState