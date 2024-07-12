Scriptname aaaKNNBasicNeedsAlias extends ReferenceAlias 

GlobalVariable Property aaaAnimRegisterCustomPotion auto
ReferenceAlias Property detectFood auto
ReferenceAlias Property RegisterPotion auto
ReferenceAlias Property ateFood auto
FormList Property aaaKNNRawFoodList auto
FormList Property aaaKNNVanillaAlcoholList auto
FormList Property aaaKNNVanillaFoodList auto
FormList Property aaaKNNVanillaSoupList auto
FormList Property aaaKNNVanillaWaterList auto
FormList Property aaaKNNNoFoodNoDrinkList auto
FormList Property aaaKNNPotionHotkeyCustomList auto
Message Property aaaKNNMsgDetectNewFood auto
Message Property aaaKNNMsgDetectNewFoodWithName auto
Message Property aaaKNNMsgRegisterForm auto
Message Property aaaKNNMsgRegisterFormWithName auto
Message Property aaaKNNMsgAteFoods auto
Message Property aaaKNNMsgAteFoodsWithName auto
Message Property aaaKNNMsgDrankDrinks auto
Message Property aaaKNNMsgDrankDrinksWithName auto

Quest Property PreAnimQuest auto

Event OnDetectNewFood(Form equipFoodForm, bool IsTakeFood)
	;Debug.Notification("OnDetectNewFood")
	int iButton
	if detectFood
		ObjectReference dummy = GetRef().PlaceAtMe(equipFoodForm, 1, false, true)
		detectFood.forceRefTo(dummy)
		iButton = aaaKNNMsgDetectNewFoodWithName.Show()
		dummy.delete()
	else
		iButton = aaaKNNMsgDetectNewFood.Show()
	endIf
	if iButton == 0
		return
	elseIf iButton == 1
		aaaKNNVanillaWaterList.AddForm(equipFoodForm)
		;KNNPlugin_Utility.AddFoodsList(iButton - 1, equipFoodForm)
		if IsTakeFood
			KNNPlugin_Utility.AddMealValue("thirsty", equipFoodForm.GetWeight())
		endIf
	elseIf iButton == 2
		aaaKNNVanillaAlcoholList.AddForm(equipFoodForm)
		;KNNPlugin_Utility.AddFoodsList(iButton - 1, equipFoodForm)
		if IsTakeFood
			KNNPlugin_Utility.AddMealValue("drunkness", equipFoodForm.GetWeight())
		endIf
	elseIf iButton == 3
		aaaKNNVanillaFoodList.AddForm(equipFoodForm)
		;KNNPlugin_Utility.AddFoodsList(iButton - 1, equipFoodForm)
		if IsTakeFood
			KNNPlugin_Utility.AddMealValue("hungry", equipFoodForm.GetWeight())
		endIf
	elseIf iButton == 4
		aaaKNNVanillaSoupList.AddForm(equipFoodForm)
		;KNNPlugin_Utility.AddFoodsList(iButton - 1, equipFoodForm)
		if IsTakeFood
			KNNPlugin_Utility.AddMealValue("hungry", equipFoodForm.GetWeight())
			KNNPlugin_Utility.AddMealValue("thirsty", equipFoodForm.GetWeight())
		endIf
	elseIf iButton == 5
		aaaKNNRawFoodList.AddForm(equipFoodForm)
		;NNPlugin.AddFoodsList(iButton - 1, equipFoodForm)
		if IsTakeFood
			KNNPlugin_Utility.AddMealValue("hungry", equipFoodForm.GetWeight() * -1)
		endIf
	elseIf iButton == 6
		aaaKNNNoFoodNoDrinkList.AddForm(equipFoodForm)
		;KNNPlugin_Utility.AddFoodsList(iButton - 1, equipFoodForm)
	endIf
EndEvent


;Spell Property aaaKNNPlayRegisterPotionSpell auto
Event OnPlayRegisterPotion(Actor player, Form thisPotion)
	int iButton
	if RegisterPotion
		ObjectReference dummy = GetRef().PlaceAtMe(thisPotion, 1, false, true)
		RegisterPotion.forceRefTo(dummy)
		iButton = aaaKNNMsgRegisterFormWithName.Show()
		dummy.delete()
	else
		iButton = aaaKNNMsgRegisterForm.Show()
	endIf
	if iButton == 0
		aaaKNNPotionHotkeyCustomList.AddForm(thisPotion)
		if 0 == aaaAnimRegisterCustomPotion.GetValueInt() || player.IsWeaponDrawn() || player.IsInCombat() || player.IsSwimming() || 0 != player.GetSitState() || 0 != player.GetSleepState()
			return
		elseIf player.GetAnimationVariableBool("bAnimationDriven") || player.GetAnimationVariableBool("bInJumpState") || 5 <= player.GetAnimationVariableFloat("Speed")
			return
		endIf
		Game.DisablePlayerControls()
		Utility.Wait(0.5)
		Game.EnablePlayerControls()
		_KNNPrePlayAnimationQuest preq = PreAnimQuest as _KNNPrePlayAnimationQuest
		preq.StartPlayerAnimation(player, preq.TYPE_REGISTER_POTIONS, thisPotion)
		;aaaKNNPlayRegisterPotionSpell.Cast(player)
	endIf
EndEvent

;IsFoods: foods or drinks
Event OnTakeMeals(Form meals, bool IsFoods)
	if ateFood
		ObjectReference dummy = GetRef().PlaceAtMe(meals, 1, false, true)
		ateFood.forceRefTo(dummy)
		if IsFoods
			aaaKNNMsgAteFoodsWithName.Show()
		else
			aaaKNNMsgDrankDrinksWithName.Show()
		endIf
		dummy.delete()
	else
		if IsFoods
			aaaKNNMsgAteFoods.Show()
		else
			aaaKNNMsgDrankDrinks.Show()
		endIf
	endIf
EndEvent