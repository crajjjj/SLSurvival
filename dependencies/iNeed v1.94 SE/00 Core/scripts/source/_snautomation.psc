Scriptname _SNAutomation extends activemagiceffect  

;====================================================================================

Spell Property _SNFollowerSpell Auto

Faction Property _SNThirstyFaction Auto
Faction Property _SNHungryFaction Auto
Faction Property _SNEatingFaction Auto

Keyword Property _SNRefillable Auto
Keyword Property _SNThirstServing_Unknown Auto

_SNQuestScript Property _SNQuest Auto

String FollowerName

Int CombatState
Int ActionCount
Int BreakableWaterskins
Int FollowerSex

Bool Property IsFollower Auto
Bool Property IsFollowerPurchase Auto
Bool Property IsFollowerPurchaseWater Auto
Bool Property Water Auto
Bool Eating

Actor targ

;====================================================================================

Function PlayDrink()
	targ.RemoveFromFaction(_SNThirstyFaction)
	Utility.Wait(0.75)
	If _SNQuest.AnimationsFollowers && CombatState == 0 && !targ.IsInFaction(_SNEatingFaction)
		If targ.GetSitState() == 0
			Debug.SendAnimationEvent(targ, "idleDrinkingStandingStart")
		Else
			Debug.SendAnimationEvent(targ, "ChairDrinkingStart")
		EndIf
		Utility.Wait(7.0)
		targ.PlayIdle(_SNQuest.IdleStop_Loose)
	EndIf
	RegisterForSingleUpdateGameTime(_SNQuest.FollowerThirstRate)
EndFunction

Function PlayEat()
	targ.RemoveFromFaction(_SNHungryFaction)
	Utility.Wait(0.75)
	If _SNQuest.AnimationsFollowers && CombatState == 0
		targ.AddToFaction(_SNEatingFaction)
		Debug.SendAnimationEvent(targ, "idleEatingStandingStart")
		Debug.SendAnimationEvent(targ, "ChairEatingStart")
		Utility.Wait(7.0)
		targ.PlayIdle(_SNQuest.IdleStop_Loose)
		targ.RemoveFromFaction(_SNEatingFaction)
	EndIf
	RegisterForSingleUpdateGameTime(_SNQuest.FollowerHungerRate)
EndFunction

;====================================================================================

Event OnEffectStart(Actor akTarget, Actor akCaster)
	targ = akTarget
	If IsFollower
		If _SNQuest.SKSEVersion > 0.0
			FollowerName = targ.GetBaseObject().GetName()
		EndIf
		If _SNQuest.BreakableWaterskins == 0 || !Water
			GoToState("Follower")
		Else
			GoToState("FollowerBreakWater")
		EndIf
	ElseIf IsFollowerPurchase
		FollowerName = targ.GetBaseObject().GetName()
		GoToState("FollowerPurchase")
	ElseIf IsFollowerPurchaseWater
		FollowerName = targ.GetBaseObject().GetName()
		GoToState("FollowerPurchaseWater")
	Else
		GoToState("Automate")
	EndIf
EndEvent

;====================================================================================

Function FollowerEats()
	Int FollowerNeedsType = _SNQuest._SNFollowerNeedsToggle.GetValue() as Int
	If FollowerNeedsType == 1 && _SNQuest.AutoEat(targ)
		PlayEat()
	ElseIf FollowerNeedsType == 2
		PlayEat()
	Else
		targ.AddToFaction(_SNHungryFaction)
		Debug.Notification(FollowerName + _SNQuest.FollowerNFoodText)
		RegisterForSingleUpdateGameTime(0.25)
	EndIf
EndFunction

Function FollowerDrinks()
	Int FollowerNeedsType = _SNQuest._SNFollowerNeedsToggle.GetValue() as Int
	If FollowerNeedsType == 1
		If targ.GetItemCount(_SNQuest._SNWaterskin_1) as Int > 0
			targ.EquipItem(_SNQuest._SNWaterskin_1)
			If _SNQuest.EFFInstalled
				_SNQuest.PlayerRef.AddItem(_SNQuest._SNWaterskin_0, 1, true)
				Utility.Wait(0.1)
				_SNQuest.PlayerRef.RemoveItem(_SNQuest._SNWaterskin_0, 1, true, targ)
			Else
				targ.AddItem(_SNQuest._SNWaterskin_0)
			EndIf
			PlayDrink()
			If _SNQuest.NotifAutoText
				Debug.Notification(FollowerName + _SNQuest.FollowerAutoConsumeText + _SNQuest._SNWaterskin_1.GetName() + ".")
			EndIf
		ElseIf targ.GetItemCount(_SNQuest._SNWaterskin_2) as Int > 0
			targ.EquipItem(_SNQuest._SNWaterskin_2)
			targ.AddItem(_SNQuest._SNWaterskin_1)
			PlayDrink()
			If _SNQuest.NotifAutoText
				Debug.Notification(FollowerName + _SNQuest.FollowerAutoConsumeText + _SNQuest._SNWaterskin_2.GetName() + ".")
			EndIf
		ElseIf targ.GetItemCount(_SNQuest._SNWaterskin_3) as Int > 0
			targ.EquipItem(_SNQuest._SNWaterskin_3)
			targ.AddItem(_SNQuest._SNWaterskin_2)
			PlayDrink()
			If _SNQuest.NotifAutoText
				Debug.Notification(FollowerName + _SNQuest.FollowerAutoConsumeText + _SNQuest._SNWaterskin_3.GetName() + ".")
			EndIf
		ElseIf _SNQuest.AutoConsume(targ, _SNQuest._SNFood_DrinkNoAlcList, _SNQuest._SNFood_DrinkList, _SNQuest._SNFood_DrinkSnowList)
			PlayDrink()
		Else
			targ.AddToFaction(_SNThirstyFaction)
			Debug.Notification(FollowerName + _SNQuest.FollowerNWaterText)
			RegisterForSingleUpdateGameTime(0.25)
		EndIf
	Else
		PlayDrink()
	EndIf
EndFunction

Function FollowerBegin()
	If Water
		FollowerSex = targ.GetActorBase().GetSex() as Int
		RegisterForModEvent("_SN_WaterRefill", "OnWaterRefill")
		RegisterForModEvent("_SN_PlayerConsumes", "OnPlayerConsumes")
		RegisterForModEvent("_SN_PlayerSits", "OnPlayerSits")
		RegisterForModEvent("_SN_CheckStatus", "OnCheckStatus")
		RegisterForSingleUpdateGameTime(_SNQuest.FollowerThirstRate / 1.25)
	Else
		RegisterForSingleUpdateGameTime(_SNQuest.FollowerHungerRate / 1.25)
	EndIf
EndFunction

Function FollowerUpdate()
	If targ
		If Water
			FollowerDrinks()
		Else
			FollowerEats()
		EndIf
	EndIf
EndFunction

Function FollowerFinish()
	If targ
		If Water
			If _SNQuest.ModUpdated 
				targ.RemoveSpell(_SNFollowerSpell)
				Utility.Wait(0.1)
				targ.AddSpell(_SNFollowerSpell)
			Else
				Utility.Wait(1.5)
				targ.AddSpell(_SNFollowerSpell)
			EndIf
		EndIf
		targ.RemoveFromFaction(_SNEatingFaction)
	EndIf
	GoToState("Dead")
EndFunction


State Follower

	Event OnBeginState()
		FollowerBegin()
	EndEvent

	Event OnUpdateGameTime()
		FollowerUpdate()
	EndEvent

	Event OnCombatStateChanged(Actor akTarget, Int aeCombatState)
		CombatState = aeCombatState
	EndEvent

	Event OnEffectFinish(Actor akTarget, Actor akCaster)
		FollowerFinish()
	EndEvent

EndState

State FollowerBreakWater

	Event OnBeginState()
		BreakableWaterskins = 49 - (_SNQuest.BreakableWaterskins * 2)
		FollowerBegin()
	EndEvent

	Event OnUpdateGameTime()
		FollowerUpdate()
	EndEvent

	Event OnCombatStateChanged(Actor akTarget, Int aeCombatState)
		CombatState = aeCombatState
	EndEvent

	Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
		If akAggressor && akSource as Weapon
			If ActionCount > BreakableWaterskins
				_SNQuest.BreakWater(targ)
				ActionCount = 0
			Else
				ActionCount +=1
			EndIf
		EndIf
	EndEvent

	Event OnEffectFinish(Actor akTarget, Actor akCaster)
		FollowerFinish()
	EndEvent

EndState

;====================================================================================

State FollowerPurchase

	Event OnBeginState()
		RegisterForSingleUpdate(5.0)
	EndEvent

	Event OnUpdate()
		Bool NoGold
		If targ
			Int FoodCount = _SNQuest.FormCount(_SNQuest.FoodFollowerList)
			If FoodCount > 0
				Int iRandomIndex = Utility.RandomInt(1, FoodCount) - 1
				If iRandomIndex < _SNQuest.FoodFollowerList.Length
					Form RandomFood = _SNQuest.FoodFollowerList[iRandomIndex]
					If RandomFood
						Int RandomFoodValue = (RandomFood.GetGoldValue() as Int * 4)
						If RandomFoodValue > 0
							If targ.GetItemCount(_SNQuest.Gold001) as Int >= RandomFoodValue
								targ.AddItem(RandomFood)
								targ.RemoveItem(_SNQuest.Gold001, RandomFoodValue)
							Else
								Debug.Notification(FollowerName + _SNQuest.FollowerNoGoldText)
								NoGold = True
							EndIf
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf
		If NoGold
			RegisterForSingleUpdate(10.0)
		Else
			RegisterForSingleUpdate(3.0)
		EndIf
	EndEvent

	Event OnEffectFinish(Actor akTarget, Actor akCaster)
		GoToState("Dead")
	EndEvent

EndState

State FollowerPurchaseWater

	Event OnBeginState()
		RegisterForSingleUpdate(5.0)
	EndEvent

	Event OnUpdate()
		If targ
			Int Cost = (targ.GetItemCount(_SNRefillable) as Int) * 5
			If targ.GetItemCount(_SNQuest.Gold001) as Int >= Cost
				_SNQuest.Refill(targ)
				targ.RemoveItem(_SNQuest.Gold001, Cost)
			Else
				Debug.Notification(FollowerName + _SNQuest.FollowerNoGoldText)
			EndIf
			RegisterForSingleUpdate(10.0)
		EndIf
	EndEvent

	Event OnEffectFinish(Actor akTarget, Actor akCaster)
		GoToState("Dead")
	EndEvent

EndState

;====================================================================================

State Automate

	Event OnBeginState()
		RegisterForSingleUpdate(0.0)
	EndEvent

	Event OnUpdate()
		If targ
			If _SNQuest.SKSEVersion > 0.0
				If !UI.IsMenuOpen("Dialogue Menu")
					If Water
						If _SNQuest._SNThirstPenalty.GetValue() as Int > -1
							If _SNQuest.EnableAlcohol
								_SNQuest.AutoDrinkNoAlc(targ)
							Else
								_SNQuest.AutoDrink(targ)
							EndIf
						EndIf
					ElseIf 	_SNQuest._SNHungerPenalty.GetValue() as Int > -1
						_SNQuest.AutoEat(targ)
					EndIf
				EndIf
			Else
				If Water
					If _SNQuest._SNThirstPenalty.GetValue() as Int > -1
						If _SNQuest.EnableAlcohol
							_SNQuest.AutoDrinkNoAlc(targ)
						Else
							_SNQuest.AutoDrink(targ)
						EndIf
					EndIf
				ElseIf 	_SNQuest._SNHungerPenalty.GetValue() as Int > -1
					_SNQuest.AutoEat(targ)
				EndIf
			EndIf
		EndIf
		RegisterForSingleUpdate(10.0)
	EndEvent

	Event OnEffectFinish(Actor akTarget, Actor akCaster)
		GoToState("Dead")
	EndEvent

EndState

Event OnWaterRefill(string a_eventName, string a_strArg, float a_numArg, Form a_sender)
	If targ && _SNQuest.Refill(targ)
		If FollowerSex == 0
			Debug.Notification(FollowerName + _SNQuest.FollowerSharedRefillMText)
		Else
			Debug.Notification(FollowerName + _SNQuest.FollowerSharedRefillFText)
		EndIf
	EndIf
EndEvent

Event OnPlayerConsumes(string a_eventName, string a_strArg, float a_numArg, Form a_sender)
	If targ && _SNQuest.ForceFollowerConsume
		If a_strArg == "IsEating"
			FollowerEats()
		Else
			FollowerDrinks()
		EndIf
	EndIf
EndEvent

Event OnPlayerSits(string a_eventName, string a_strArg, float a_numArg, Form a_sender)
	If targ
		If a_strArg != "Jumping"
			Debug.SendAnimationEvent(targ, "IdleSitCrossLeggedEnter")
		Else
			Debug.SendAnimationEvent(targ, "IdleForceDefaultState")
		EndIf
	EndIf
EndEvent

Event OnCheckStatus(string a_eventName, string a_strArg, float a_numArg, Form a_sender)
	If targ
		Int FoodCount
		If _SNQuest._SNCannibalToggle.GetValue() as Int == 1
			Race targRace = targ.GetRace()
			If targRace == _SNQuest.WoodelfRace || targRace == _SNQuest.WoodelfRaceVampire || targ.IsEquipped(_SNQuest.DA11RingofNamira)
				FoodCount = targ.GetItemCount(_SNQuest._SNFood_HeavyList) as Int +  targ.GetItemCount(_SNQuest._SNFood_MedList) as Int +  targ.GetItemCount(_SNQuest._SNFood_SoupList) as Int +  targ.GetItemCount(_SNQuest._SNFood_LightList) as Int +  targ.GetItemCount(_SNQuest._SNFood_RawList) as Int
			Else
				FoodCount = targ.GetItemCount(_SNQuest._SNFood_HeavyList) as Int +  targ.GetItemCount(_SNQuest._SNFood_MedList) as Int +  targ.GetItemCount(_SNQuest._SNFood_SoupList) as Int +  targ.GetItemCount(_SNQuest._SNFood_LightList) as Int
			EndIf
		Else
			FoodCount = targ.GetItemCount(_SNQuest._SNFood_HeavyList) as Int +  targ.GetItemCount(_SNQuest._SNFood_MedList) as Int +  targ.GetItemCount(_SNQuest._SNFood_SoupList) as Int +  targ.GetItemCount(_SNQuest._SNFood_LightList) as Int
		EndIf
		Int DrinkCount = targ.GetItemCount(_SNQuest._SNWaterskin_1) as Int + (targ.GetItemCount(_SNQuest._SNWaterskin_2) as Int * 2) + (targ.GetItemCount(_SNQuest._SNWaterskin_3) as Int * 3) + targ.GetItemCount(_SNQuest._SNFood_DrinkList) as Int + targ.GetItemCount(_SNQuest._SNFood_DrinkNoAlcList) as Int
		If FollowerSex == 0
			Debug.Notification(FollowerName + _SNQuest.FollowerStatusMText_1 + FoodCount + _SNQuest.FollowerStatusText_2 + DrinkCount + _SNQuest.FollowerStatusText_3)
		Else
			Debug.Notification(FollowerName + _SNQuest.FollowerStatusFText_1 + FoodCount + _SNQuest.FollowerStatusText_2 + DrinkCount + _SNQuest.FollowerStatusText_3)
		EndIf
	EndIf
EndEvent

State Dead
EndState