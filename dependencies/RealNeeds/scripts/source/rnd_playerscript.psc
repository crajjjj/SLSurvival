Scriptname RND_PlayerScript extends ReferenceAlias
{this script tracks player stat, needs work}

GlobalVariable Property RND_State Auto
GlobalVariable Property RND_HasSKSE Auto
GlobalVariable Property RND_HasSkyUI Auto
GlobalVariable Property RND_DiseaseChanceRawFood Auto

GlobalVariable Property RND_CheckNeedsKey Auto
GlobalVariable Property RND_DrinkWaterKey Auto

Actor Player

FormList Property RND_RawFoodList Auto
FormList Property RND_SnackFoodList Auto
FormList Property RND_MediumFoodList Auto
FormList Property RND_AbundantFoodList Auto
FormList Property RND_BeverageList Auto
FormList Property RND_AlcoholBeverageList Auto
Form Food

GlobalVariable Property RND_HungerPoints Auto
GlobalVariable Property RND_HungerPointsPerHour Auto
GlobalVariable Property RND_HungerLastUpdateTimeStamp Auto

RND_PlayerScript Property RND_Player Auto
RND_HungerCountScript Property HungerScript Auto

GlobalVariable Property RND_AnimEat Auto
GlobalVariable Property RND_1stPersonMsg Auto

Idle Property ChairEatingStart Auto
Idle Property idleEatingStandingStart Auto
Idle Property idleStop_Loose Auto

GlobalVariable Property RND_FoodPointsSnack Auto
GlobalVariable Property RND_FoodPointsMedium Auto 
GlobalVariable Property RND_FoodPointsFilling Auto 
GlobalVariable Property RND_ForceSatiation Auto

Spell Property RND_HungerSpell00 Auto
Spell Property RND_HungerSpell01 Auto
Spell Property RND_HungerSpell02 Auto
Spell Property RND_HungerSpell03 Auto
Spell Property RND_HungerSpell04 Auto
Spell Property RND_HungerSpell05 Auto

GlobalVariable Property RND_HungerLevel00 Auto
GlobalVariable Property RND_HungerLevel01 Auto
GlobalVariable Property RND_HungerLevel02 Auto
GlobalVariable Property RND_HungerLevel03 Auto
GlobalVariable Property RND_HungerLevel04 Auto
GlobalVariable Property RND_HungerLevel05 Auto

Message Property RND_HungerLevel00ConsumeMessage Auto
Message Property RND_HungerLevel01ConsumeMessage Auto
Message Property RND_HungerLevel02ConsumeMessage Auto
Message Property RND_HungerLevel03ConsumeMessage Auto
Message Property RND_HungerLevel04ConsumeMessage Auto
Message Property RND_HungerLevel05ConsumeMessage Auto

Message Property RND_HungerLevel00ConsumeMessageB Auto
Message Property RND_HungerLevel01ConsumeMessageB Auto
Message Property RND_HungerLevel02ConsumeMessageB Auto
Message Property RND_HungerLevel03ConsumeMessageB Auto
Message Property RND_HungerLevel04ConsumeMessageB Auto
Message Property RND_HungerLevel05ConsumeMessageB Auto

GlobalVariable Property RND_ThirstPoints Auto
GlobalVariable Property RND_ThirstPointsPerHour Auto
GlobalVariable Property RND_ThirstLastUpdateTimeStamp Auto

GlobalVariable Property RND_WaterPointsMid  Auto

RND_ThirstCountScript Property ThirstScript Auto

GlobalVariable Property RND_AnimDrink Auto

Idle Property idleDrink Auto
Idle Property ChairDrinkingStart Auto
Idle Property idleBarDrinkingStart Auto

Spell Property RND_ThirstSpell00 Auto
Spell Property RND_ThirstSpell01 Auto
Spell Property RND_ThirstSpell02 Auto
Spell Property RND_ThirstSpell03 Auto
Spell Property RND_ThirstSpell04 Auto

GlobalVariable Property RND_ThirstLevel00 Auto
GlobalVariable Property RND_ThirstLevel01 Auto
GlobalVariable Property RND_ThirstLevel02 Auto
GlobalVariable Property RND_ThirstLevel03 Auto
GlobalVariable Property RND_ThirstLevel04 Auto

Message Property RND_ThirstLevel00ConsumeMessage Auto
Message Property RND_ThirstLevel01ConsumeMessage Auto
Message Property RND_ThirstLevel02ConsumeMessage Auto
Message Property RND_ThirstLevel03ConsumeMessage Auto
Message Property RND_ThirstLevel04ConsumeMessage Auto

Message Property RND_ThirstLevel00ConsumeMessageB Auto
Message Property RND_ThirstLevel01ConsumeMessageB Auto
Message Property RND_ThirstLevel02ConsumeMessageB Auto
Message Property RND_ThirstLevel03ConsumeMessageB Auto
Message Property RND_ThirstLevel04ConsumeMessageB Auto

GlobalVariable Property RND_InebriationPoints Auto
GlobalVariable Property RND_InebriationPointsPerHour Auto
GlobalVariable Property RND_InebriationLastUpdateTimeStamp Auto

RND_InebriationCountScript Property InebriationScript Auto

Spell Property RND_InebriationSpell00 Auto
Spell Property RND_InebriationSpell01 Auto
Spell Property RND_InebriationSpell02 Auto
Spell Property RND_InebriationSpell03 Auto

GlobalVariable Property RND_InebriationLevel00 Auto
GlobalVariable Property RND_InebriationLevel01 Auto
GlobalVariable Property RND_InebriationLevel02 Auto
GlobalVariable Property RND_InebriationLevel03 Auto
GlobalVariable Property RND_InebriationLevel04 Auto

GlobalVariable Property RND_AlcoholPointsNormal Auto

Event OnInit()
	
	Player = Game.GetPlayer()	
	if RND_HasSKSE.GetValue() == 1
		RegisterForKey(RND_CheckNeedsKey.GetValueInt())
		RegisterForKey(RND_DrinkWaterKey.GetValueInt())
	endif
	chkDLC()
	RegisterForSleep()
	AddInventoryEventFilter(WineBottle01AEmpty)
	AddInventoryEventFilter(WineBottle01BEmpty)
	AddInventoryEventFilter(WineBottle02AEmpty)
	AddInventoryEventFilter(WineBottle02BEmpty)
	AddInventoryEventFilter(WineSolitudeSpicedBottleEmpty)

EndEvent

;---------------------------------------------------

MiscObject Property WineBottle01AEmpty Auto
MiscObject Property WineBottle01BEmpty Auto
MiscObject Property WineBottle02AEmpty Auto
MiscObject Property WineBottle02BEmpty Auto
MiscObject Property WineSolitudeSpicedBottleEmpty Auto

Potion Property RND_EmptyBottle03 Auto
Potion Property RND_EmptyBottle02 Auto
Potion Property RND_EmptyBottle01 Auto
Potion Property RND_WaterskinEmpty Auto

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)

	; replace vanilla wine bottles with RND empty bottles
	if akBaseItem == WineBottle01AEmpty || akBaseItem == WineBottle01BEmpty
		Player.RemoveItem(akBaseItem, aiItemCount, true)
		Player.AddItem(RND_EmptyBottle03, aiItemCount, true)
	elseif akBaseItem == WineBottle02AEmpty || akBaseItem == WineBottle02BEmpty || akBaseItem == WineSolitudeSpicedBottleEmpty
		Player.RemoveItem(akBaseItem, aiItemCount, true)
		Player.AddItem(RND_EmptyBottle02, aiItemCount, true)
	endif

EndEvent

;---------------------------------------------------

Spell Property RND_CheckNeedsSpell Auto
Spell Property RND_DrinkFromWaterSource Auto

Event OnKeyDown(int keyCode)

	if Utility.IsInMenuMode()
		if !UI.IsTextInputEnabled ()
			if keyCode == RND_DrinkWaterKey.GetValueInt()
				emptyBottle()
			endif
		endif
	else
		if keyCode == RND_CheckNeedsKey.GetValueInt()
			RND_CheckNeedsSpell.Cast(Player, Player)
		elseif keyCode == RND_DrinkWaterKey.GetValueInt()
			RND_DrinkFromWaterSource.Cast(Player, Player)
		endif
	endif	
EndEvent

Function mapKey()
	if RND_HasSKSE.GetValue() == 1
		UnregisterForAllKeys()
		RegisterForKey(RND_CheckNeedsKey.GetValueInt())
		RegisterForKey(RND_DrinkWaterKey.GetValueInt())
	endif
EndFunction

FormList Property RND_Bottle01List Auto
FormList Property RND_Bottle02List Auto
FormList Property RND_Bottle03List Auto
FormList Property RND_WaterskinList Auto

Form Property RND_SpoiledJunk Auto
Form Property RND_SpoiledJunkB Auto
Ingredient Property RND_Mold Auto
Ingredient Property RND_RottenFlesh Auto
GlobalVariable Property RND_CollectChance Auto

Function emptyBottle()

	if RND_HasSKSE.GetValue() == 1

		int bottleID = UI.GetInt ("InventoryMenu", "_root.Menu_mc.inventoryLists.panelContainer.itemList.selectedEntry.formId")
		form bottle = Game.GetForm (bottleID)
		if (bottle as Potion).isFood()
			; empty bottles
			if RND_Bottle03List.hasForm(bottle)
				Player.RemoveItem(bottle, 1)
				Player.Additem(RND_EmptyBottle03, 1)	
			elseif RND_Bottle02List.hasForm(bottle)
				Player.RemoveItem(bottle, 1)
				Player.Additem(RND_EmptyBottle02, 1)
			elseif RND_Bottle01List.hasForm(bottle)
				Player.RemoveItem(bottle, 1)
				Player.Additem(RND_EmptyBottle01, 1)
			elseif RND_WaterskinList.hasForm(bottle)
				Player.RemoveItem(bottle, 1)
				Player.Additem(RND_WaterskinEmpty, 1)
				
			; search junkpots			
			elseif bottle == RND_SpoiledJunk
				Player.RemoveItem(bottle, 1)
				if Utility.RandomInt(0,100) < RND_CollectChance.getValue()
					Player.AddItem(RND_Mold, 1)
				endif
			elseif bottle == RND_SpoiledJunkB
				Player.RemoveItem(bottle, 1)
				if Utility.RandomInt(0,100) < RND_CollectChance.getValue()
					Player.AddItem(RND_RottenFlesh, 1)
				endif	
			
			endif
		endif
	endif
EndFunction

;---------------------------------------------------
; player sleep script

Spell Property RND_Rested Auto
Spell Property RND_WellRested Auto
Spell Property RND_RestlessBeast Auto
Spell Property RND_MarriageRested Auto

Spell Property RND_SleepSpell00 Auto
Spell Property RND_SleepSpell01 Auto
Spell Property RND_SleepSpell02 Auto
Spell Property RND_SleepSpell03 Auto
Spell Property RND_SleepSpell04 Auto

GlobalVariable Property RND_SleepLevel00 Auto
GlobalVariable Property RND_SleepLevel01 Auto
GlobalVariable Property RND_SleepLevel02 Auto
GlobalVariable Property RND_SleepLevel03 Auto
GlobalVariable Property RND_SleepLevel04 Auto

Message Property RND_RestedMessage  Auto  
Message Property RND_WellRestedMessage  Auto  
Message Property RND_MarriageRestedMessage  Auto  
Message Property RND_BeastBloodMessage  Auto

ReferenceAlias Property LoveInterest Auto
Keyword Property LocTypeInn Auto
Keyword Property LocTypePlayerHouse Auto
Quest Property RelationshipMarriageFIN Auto
Spell Property pDoomLoverAbility Auto

Spell Property RND_SleepDisease Auto

GlobalVariable Property RND_SleepPoints Auto
GlobalVariable Property RND_SleepPointsPerHour Auto
GlobalVariable Property RND_SleepLastUpdateTimeStamp Auto
Location Property SleepLastUpdateLocation Auto

Int Property SleepRecoverBasePoints = 10 Auto

Function RemoveSleepSpells()
	Player.RemoveSpell(RND_Rested)
	Player.RemoveSpell(RND_WellRested)
	Player.RemoveSpell(RND_RestlessBeast)
	Player.RemoveSpell(RND_MarriageRested)	
	Player.RemoveSpell(RND_SleepSpell00)
	Player.RemoveSpell(RND_SleepSpell01)
	Player.RemoveSpell(RND_SleepSpell02)
	Player.RemoveSpell(RND_SleepSpell03)
	Player.RemoveSpell(RND_SleepSpell04)
EndFunction

Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)

	RemoveSleepSpells()
	
	float NumOfHours = (afDesiredSleepEndTime - afSleepStartTime) * 24	

	if RND_SleepPointsPerHour.GetValue() * 2 >= SleepRecoverBasePoints
		RND_SleepPoints.SetValue(RND_SleepPoints.GetValue() - RND_SleepPointsPerHour.GetValue() * 2 * NumOfHours)
	else
		RND_SleepPoints.SetValue(RND_SleepPoints.GetValue() - SleepRecoverBasePoints * NumOfHours)
	endif
	
	if RND_DiseaseFatigue.GetValue() == 1
		float DiseaseFatiguePoints = getDisFatigue() * NumOfHours
		RND_SleepPoints.SetValue(RND_SleepPoints.GetValue() + DiseaseFatiguePoints)
	
		if DiseaseFatiguePoints > 0 && RND_SleepPoints.GetValue() <= 0
			RND_SleepPoints.SetValue(RND_SleepLevel01.GetValue() * 0.5)
		endif	
	endif
	
	; Sleep points cap between 0-RND_SleepLevel04, 
	if RND_SleepPoints.GetValue() > RND_SleepLevel04.GetValue()
		RND_SleepPoints.SetValue(RND_SleepLevel04.GetValue())
	elseif RND_SleepPoints.GetValue() < 0
		RND_SleepPoints.SetValue(0)
	endif
	
EndEvent


Event OnSleepStop(bool abInterrupted)

	if RND_SleepPoints.GetValue() <= 0.0
	
		if isWerewolf()			
			Player.AddSpell(RND_RestlessBeast, false)
			RND_BeastBloodMessage.Show()
			
		elseif Player.HasSpell(pDoomLoverAbility) == 1			
			Player.AddSpell(RND_SleepSpell00, false)
			RND_RestedMessage.Show()
			
		else
			
			if RelationshipMarriageFIN.IsRunning() == True && RelationshipMarriageFIN.GetStage() > 10 \
					&& Player.GetCurrentLocation() == LoveInterest.GetActorRef().GetCurrentLocation()
					Player.AddSpell(RND_MarriageRested, false)
					RND_MarriageRestedMessage.Show()
			else
				Location Loc = Player.GetCurrentLocation()				
				if Loc != None
					if (Loc.HasKeyword(LocTypeInn) == True) || (Loc.HasKeyword(LocTypePlayerHouse) == True)
						Player.AddSpell(RND_WellRested, false)
						RND_WellRestedMessage.Show()					
					else
						Player.AddSpell(RND_Rested, false)
						RND_RestedMessage.Show()
					endif
				else				
					Player.AddSpell(RND_Rested, false)
					RND_RestedMessage.Show()
				endif
			endif
		endif
		
	elseif RND_SleepPoints.GetValue() > 0 && RND_SleepPoints.GetValue() < RND_SleepLevel01.GetValue()
			Player.AddSpell(RND_SleepSpell00, false)		
			
	elseif RND_SleepPoints.GetValue() >= RND_SleepLevel01.GetValue() && RND_SleepPoints.GetValue() < RND_SleepLevel02.GetValue()
			Player.AddSpell(RND_SleepSpell01, false)
			
	elseif RND_SleepPoints.GetValue() >= RND_SleepLevel02.GetValue() && RND_SleepPoints.GetValue() < RND_SleepLevel03.GetValue()
			Player.AddSpell(RND_SleepSpell02, false)
			
	elseif RND_SleepPoints.GetValue() >= RND_SleepLevel03.GetValue() && RND_SleepPoints.GetValue() < RND_SleepLevel04.GetValue()
			Player.AddSpell(RND_SleepSpell03, false)
			
	elseif RND_SleepPoints.GetValue() >= RND_SleepLevel04.GetValue()
			Player.AddSpell(RND_SleepSpell04, false)
	
	endif
	
	RND_SleepDisease.Cast(Player, Player)
	
EndEvent

;---------------------------------------------------

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)

	If akBaseObject as Potion
		Food = akBaseObject
		If RND_RawFoodList.HasForm(Food)
			applyRandomDisease(RND_DiseaseChanceRawFood.GetValueInt())
			EatFood()
		ElseIf RND_SnackFoodList.HasForm(Food) || RND_MediumFoodList.HasForm(Food) || RND_AbundantFoodList.HasForm(Food)
			EatFood()
		ElseIf RND_BeverageList.HasForm(Food)
			DrinkWater()
		ElseIf RND_AlcoholBeverageList.HasForm(Food)
			DrinkAlcohol()
		EndIf
	EndIf	

EndEvent

Function EatFood()

	Player = Game.GetPlayer()
	Int FoodPoints
	
	If RND_RawFoodList.HasForm(Food)
		FoodPoints = RND_FoodPointsSnack.GetValueInt()
	ElseIf RND_SnackFoodList.HasForm(Food)
		FoodPoints = RND_FoodPointsSnack.GetValueInt()	
	ElseIf RND_MediumFoodList.HasForm(Food)
		FoodPoints = RND_FoodPointsMedium.GetValueInt()	
	ElseIf RND_AbundantFoodList.HasForm(Food)
		FoodPoints = RND_FoodPointsFilling.GetValueInt()	
	EndIf
	
	if RND_Player.isVampire()
		RND_HungerPoints.SetValue(10)
		RemoveHungerSpells()	
	else
		; eat food
		int AdjPoints = Utility.RandomInt(-5,5)
		float HungerPoints = RND_HungerPoints.GetValue()
		RND_HungerPoints.SetValue(RND_HungerPoints.GetValue() - FoodPoints - AdjPoints)
		
		if RND_ForceSatiation.GetValue() == 1
			if HungerPoints >= RND_HungerLevel02.GetValue() && RND_HungerPoints.GetValue() < RND_HungerLevel01.GetValue()
				RND_HungerPoints.SetValue(RND_HungerLevel01.GetValue())
			endif
		endif

		; Hunger points cap between 0-RND_HungerLevel05, 
		; so you don't end up eating a lot and still starving
		; or eating one huge meal hoping to last for a week
		if RND_HungerPoints.GetValue() > RND_HungerLevel05.GetValue()
			RND_HungerPoints.SetValue(RND_HungerLevel05.GetValue())
		elseif RND_HungerPoints.GetValue() < 0
			RND_HungerPoints.SetValue(0)
		endif
	
		; update time stamp
		RND_HungerLastUpdateTimeStamp.SetValue(Utility.GetCurrentGameTime())
	
		; new spell to add
		Spell HungerSpell = RND_HungerSpell02
		Message HungerLevelMessage = None
	
		if RND_HungerPoints.GetValue() < RND_HungerLevel01.GetValue()
			HungerSpell = RND_HungerSpell00
			if RND_1stPersonMsg.GetValue() == 1
				HungerLevelMessage = RND_HungerLevel00ConsumeMessage
			else
				HungerLevelMessage = RND_HungerLevel00ConsumeMessageB
			endif
	
		elseif RND_HungerPoints.GetValue() >= RND_HungerLevel01.GetValue() && RND_HungerPoints.GetValue() < RND_HungerLevel02.GetValue()
			HungerSpell = RND_HungerSpell01
			if RND_1stPersonMsg.GetValue() == 1
				HungerLevelMessage = RND_HungerLevel01ConsumeMessage
			else
				HungerLevelMessage = RND_HungerLevel01ConsumeMessageB
			endif
	
		elseif RND_HungerPoints.GetValue() >= RND_HungerLevel02.GetValue() && RND_HungerPoints.GetValue() < RND_HungerLevel03.GetValue()
			HungerSpell = RND_HungerSpell02
			if RND_1stPersonMsg.GetValue() == 1
				HungerLevelMessage = RND_HungerLevel02ConsumeMessage
			else
				HungerLevelMessage = RND_HungerLevel02ConsumeMessageB
			endif
	
		elseif RND_HungerPoints.GetValue() >= RND_HungerLevel03.GetValue() && RND_HungerPoints.GetValue() < RND_HungerLevel04.GetValue()
			HungerSpell = RND_HungerSpell03
			if RND_1stPersonMsg.GetValue() == 1
				HungerLevelMessage = RND_HungerLevel03ConsumeMessage
			else
				HungerLevelMessage = RND_HungerLevel03ConsumeMessageB
			endif
	
		elseif RND_HungerPoints.GetValue() >= RND_HungerLevel04.GetValue() && RND_HungerPoints.GetValue() < RND_HungerLevel05.GetValue()
			HungerSpell = RND_HungerSpell04
			if RND_1stPersonMsg.GetValue() == 1
				HungerLevelMessage = RND_HungerLevel04ConsumeMessage
			else
				HungerLevelMessage = RND_HungerLevel04ConsumeMessageB
			endif
	
		elseif RND_HungerPoints.GetValue() >= RND_HungerLevel05.GetValue()
			HungerSpell = RND_HungerSpell05
			if RND_1stPersonMsg.GetValue() == 1
				HungerLevelMessage = RND_HungerLevel05ConsumeMessage
			else
				HungerLevelMessage = RND_HungerLevel05ConsumeMessageB
			endif
	
		endif
	
		if Player.HasSpell(HungerSpell)
			HungerLevelMessage.Show()
		else
			RemoveHungerSpells()
			Player.AddSpell(HungerSpell, false)
			HungerLevelMessage.Show()
		endIf
		
	endIf
	
	if RND_AnimEat.GetValue() == 1
		if Player.GetAnimationVariableInt("i1stPerson") != 1
		
			if Player.GetSitState () == 3
				;Player.PlayIdle(ChairEatingStart)
				Debug.sendAnimationEvent(player, "ChairEatingStart")
			else		
				Player.PlayIdle(idleEatingStandingStart)
			endif
			Utility.Wait(10)
			Player.PlayIdle(idleStop_Loose)
		endif
	endIf
	
	HungerScript.WidgetFade()

EndFunction

Function RemoveHungerSpells()
	Actor PlayerRef = Game.GetPlayer()
	PlayerRef.RemoveSpell(RND_HungerSpell00)
	PlayerRef.RemoveSpell(RND_HungerSpell01)
	PlayerRef.RemoveSpell(RND_HungerSpell02)
	PlayerRef.RemoveSpell(RND_HungerSpell03)
	PlayerRef.RemoveSpell(RND_HungerSpell04)
	PlayerRef.RemoveSpell(RND_HungerSpell05)
EndFunction

;---------------------------------------------------

Function DrinkWater()

	Player = Game.GetPlayer()
	
	if RND_Player.isVampire()
		RND_ThirstPoints.SetValue(10)
		RemoveThirstSpells()
	else
		; drink water
		int AdjPoints = Utility.RandomInt(-5,5)
		RND_ThirstPoints.SetValue(RND_ThirstPoints.GetValue() - RND_WaterPointsMid.GetValue() - AdjPoints)

		if RND_ThirstPoints.GetValue() > RND_ThirstLevel04.GetValue()
			RND_ThirstPoints.SetValue(RND_ThirstLevel04.GetValue())
		elseif RND_ThirstPoints.GetValue() < 0
			RND_ThirstPoints.SetValue(0)
		endif
	
		RND_ThirstLastUpdateTimeStamp.SetValue(Utility.GetCurrentGameTime())
	
		; new spell to add
		Spell ThirstSpell = RND_ThirstSpell02
		Message ThirstLevelMessage = None
	
		if RND_ThirstPoints.GetValue() < RND_ThirstLevel01.GetValue()
			ThirstSpell = RND_ThirstSpell00
			if RND_1stPersonMsg.GetValue() == 1
				ThirstLevelMessage = RND_ThirstLevel00ConsumeMessage
			else
				ThirstLevelMessage = RND_ThirstLevel00ConsumeMessageB
			endif
	
		elseif RND_ThirstPoints.GetValue() >= RND_ThirstLevel01.GetValue() && RND_ThirstPoints.GetValue() < RND_ThirstLevel02.GetValue()
			ThirstSpell = RND_ThirstSpell01
			if RND_1stPersonMsg.GetValue() == 1
				ThirstLevelMessage = RND_ThirstLevel01ConsumeMessage
			else
				ThirstLevelMessage = RND_ThirstLevel01ConsumeMessageB
			endif
	
		elseif RND_ThirstPoints.GetValue() >= RND_ThirstLevel02.GetValue() && RND_ThirstPoints.GetValue() < RND_ThirstLevel03.GetValue()
			ThirstSpell = RND_ThirstSpell02
			if RND_1stPersonMsg.GetValue() == 1
				ThirstLevelMessage = RND_ThirstLevel02ConsumeMessage
			else
				ThirstLevelMessage = RND_ThirstLevel02ConsumeMessageB
			endif
	
		elseif RND_ThirstPoints.GetValue() >= RND_ThirstLevel03.GetValue() && RND_ThirstPoints.GetValue() < RND_ThirstLevel04.GetValue()
			ThirstSpell = RND_ThirstSpell03
			if RND_1stPersonMsg.GetValue() == 1
				ThirstLevelMessage = RND_ThirstLevel03ConsumeMessage
			else
				ThirstLevelMessage = RND_ThirstLevel03ConsumeMessageB
			endif
	
		elseif RND_ThirstPoints.GetValue() >= RND_ThirstLevel04.GetValue() 
			ThirstSpell = RND_ThirstSpell04
			if RND_1stPersonMsg.GetValue() == 1
				ThirstLevelMessage = RND_ThirstLevel04ConsumeMessage
			else
				ThirstLevelMessage = RND_ThirstLevel04ConsumeMessageB
			endif
	
		endif
	
		if Player.HasSpell(ThirstSpell)
			ThirstLevelMessage.Show()
		else
			RemoveThirstSpells()
			Player.AddSpell(ThirstSpell, false)
			ThirstLevelMessage.Show()
		endif
		
	endif
	
	if RND_AnimDrink.GetValue() == 1 && idleDrink
		if !Player.GetAnimationVariableInt("i1stPerson") == 1
		
			if player.GetSitState () == 3
				Player.PlayIdle(ChairDrinkingStart)
				Utility.Wait(10)
				Player.PlayIdle(idleStop_Loose)
			else
				Player.PlayIdle(idleDrink)
			endif
		endif
	endif
	
	ThirstScript.WidgetFade()

EndFunction

Function RemoveThirstSpells()
	Actor PlayerRef = Game.GetPlayer()
	PlayerRef.RemoveSpell(RND_ThirstSpell00)
	PlayerRef.RemoveSpell(RND_ThirstSpell01)
	PlayerRef.RemoveSpell(RND_ThirstSpell02)
	PlayerRef.RemoveSpell(RND_ThirstSpell03)
	PlayerRef.RemoveSpell(RND_ThirstSpell04)
EndFunction

;---------------------------------------------------


Function DrinkAlcohol()

	Player = Game.GetPlayer()
		
	if RND_Player.isVampire()
		RND_InebriationPoints.SetValue(10)
		RemoveInebriationSpells()
	else
		; drink Alcohol
		int AdjPoints = Utility.RandomInt(-5,5)
		RND_InebriationPoints.SetValue(RND_InebriationPoints.GetValue() + RND_AlcoholPointsNormal.GetValue() + AdjPoints)

		; Inebriation points cap between 0-RND_InebriationLevel04, 
		if RND_InebriationPoints.GetValue() > RND_InebriationLevel04.GetValue()
			RND_InebriationPoints.SetValue(RND_InebriationLevel04.GetValue())
		elseif RND_InebriationPoints.GetValue() < 0
			RND_InebriationPoints.SetValue(0)
		endif
	
		; update time stamp
		RND_InebriationLastUpdateTimeStamp.SetValue(Utility.GetCurrentGameTime())
	
		; new spell to add
		Spell InebriationSpell = RND_InebriationSpell00
	
		if RND_InebriationPoints.GetValue() < RND_InebriationLevel01.GetValue()
			InebriationSpell = RND_InebriationSpell00
	
		elseif RND_InebriationPoints.GetValue() >= RND_InebriationLevel01.GetValue() && RND_InebriationPoints.GetValue() < RND_InebriationLevel02.GetValue()
			InebriationSpell = RND_InebriationSpell01
	
		elseif RND_InebriationPoints.GetValue() >= RND_InebriationLevel02.GetValue() && RND_InebriationPoints.GetValue() < RND_InebriationLevel03.GetValue()
			InebriationSpell = RND_InebriationSpell02
	
		elseif RND_InebriationPoints.GetValue() >= RND_InebriationLevel03.GetValue()
			InebriationSpell = RND_InebriationSpell03
	
		endif
	
		if !Player.HasSpell(InebriationSpell)
			RemoveInebriationSpells()
			Player.AddSpell(InebriationSpell, false)
		endif
		
	endif
	
	if RND_AnimDrink.GetValue() == 1
		if Player.GetAnimationVariableInt("i1stPerson") != 1		
			if player.GetSitState () == 3
				Player.PlayIdle(ChairDrinkingStart)
				Utility.Wait(10)
				Player.PlayIdle(idleStop_Loose)
			else
				Player.PlayIdle(idleDrink)
			endif
		endif
	endif
	
	InebriationScript.WidgetFade()

EndFunction

Function RemoveInebriationSpells()
	Actor PlayerRef = Game.GetPlayer()
	PlayerRef.RemoveSpell(RND_InebriationSpell00)
	PlayerRef.RemoveSpell(RND_InebriationSpell01)
	PlayerRef.RemoveSpell(RND_InebriationSpell02)
	PlayerRef.RemoveSpell(RND_InebriationSpell03)
EndFunction

;---------------------------------------------------

Spell Property VampireVampirism Auto
Spell Property VampirePoisonResist Auto
GlobalVariable Property RND_MortalVamp Auto
PlayerVampireQuestScript Property PlayerVampireQuest Auto

bool Function isVampire()

	if RND_MortalVamp.GetValue() == 1
		Return False
	endif

	if PlayerVampireQuest.VampireStatus != 0	
		Return True
	elseif Player.HasSpell(VampireVampirism) || Player.HasSpell(VampirePoisonResist)
		Return True
	else	
		Return False
	endif

EndFunction

Spell Property WerewolfChange Auto
Spell Property WerewolfImmunity Auto
CompanionsHousekeepingScript Property CHScript Auto

bool Function isWerewolf()

	if CHScript.PlayerHasBeastBlood == 1
		Return True
	elseif Player.HasSpell(WerewolfChange) || Player.HasSpell(WerewolfImmunity)
		Return True
	else
		Return False
	endif

EndFunction

Keyword property ActorTypeCreature Auto

bool Function isBeast()

	if Player.GetRace().HasKeyword(ActorTypeCreature)
		Return True
	else
		Return False
	endif

EndFunction

;---------------------------------------------------

FormList Property RND_DiseaseSpells Auto

Function applyRandomDisease(Int DiseaseChance)

	if isBeast()
		DiseaseChance = 0
	endif

	if Utility.RandomInt(0,100) < DiseaseChance	
		int i = Utility.RandomInt(0, RND_DiseaseSpells.GetSize() - 1)		
		Player.DoCombatSpellApply(RND_DiseaseSpells.GetAt(i) as Spell, Player)
	endIf
EndFunction

;---------------------------------------------------

GlobalVariable Property RND_DiseaseFatigue Auto
GlobalVariable Property RND_DiseaseFatigueLow Auto
GlobalVariable Property RND_DiseaseFatigueMid Auto
GlobalVariable Property RND_DiseaseFatigueHigh Auto

FormList Property RND_DiseaseMild Auto
FormList Property RND_DiseaseModerate Auto
FormList Property RND_DiseaseSevere Auto

float Function getDisFatigue()

	if RND_DiseaseFatigue.Getvalue() == 0
		return 0.0
	endif

	float DisFatigue = 0.0
	
	float DisFatigueCap = SleepRecoverBasePoints * 0.9
	if RND_SleepPointsPerHour.GetValue() * 2 >= SleepRecoverBasePoints
		DisFatigueCap = RND_SleepPointsPerHour.GetValue() * 2 * 0.9
	endif
	
	int i = RND_DiseaseSevere.GetSize()	
	while i > 0
		i -= 1
		if Player.HasMagicEffect(RND_DiseaseSevere.GetAt(i) as MagicEffect)
			DisFatigue += RND_DiseaseFatigueHigh.GetValue()
		endif
	endWhile
	
	i = RND_DiseaseModerate.GetSize()	
	while i > 0
		i -= 1
		if Player.HasMagicEffect(RND_DiseaseModerate.GetAt(i) as MagicEffect)
			DisFatigue += RND_DiseaseFatigueMid.GetValue()
		endif
	endWhile
	
	i = RND_DiseaseMild.GetSize()
	while i > 0
		i -= 1
		if Player.HasMagicEffect(RND_DiseaseMild.GetAt(i) as MagicEffect)
			DisFatigue += RND_DiseaseFatigueLow.GetValue()
		endif
	endWhile

	if DisFatigue > DisFatigueCap
		DisFatigue = DisFatigueCap
	endif
		
	return DisFatigue
EndFunction

;---------------------------------------------------

WorldSpace Property Tamriel Auto
WorldSpace Property DLC2SolstheimWorld Auto

bool Function isInSeawater()

	if Player.GetWorldSpace() == Tamriel

		if Player.GetPositionY() > 104000.0
			Return True
		elseif Player.GetPositionY() > 86500.0 && Player.GetPositionX() < -10800.0
			Return True
		elseif Player.GetPositionY() > 50250.0 && Player.GetPositionX() > 109250.0
			Return True
		else
			Return False
		endif
		
	elseif DLC2SolstheimWorld != None && Player.GetWorldSpace() == DLC2SolstheimWorld
		if Player.GetPositionX() < 31070.0
			Return True
		elseif Player.GetPositionY() < 24385.0
			Return True
		elseif Player.GetPositionY() > 79100.0
			Return True
		elseif Player.GetPositionX() > 76350.0
			Return True	
		else
			Return False
		endif
		
	else
		Return False
	endif
endFunction

;---------------------------------------------------

MiscObject Property RND_Straw Auto

bool Function feedCow()
	if RND_Straw != None && Player.GetItemCount(RND_Straw) >= 1
		Player.removeItem(RND_Straw, 1)
		Return True
	else
		Return False
	endif
endFunction


;---------------------------------------------------

Function chkDLC()

	if Game.GetFormFromFile(0x00000800, "Dragonborn.esm")
		DLC2SolstheimWorld = Game.GetFormFromFile(0x00000800, "Dragonborn.esm") as WorldSpace
	else
		DLC2SolstheimWorld = None
		Debug.Trace("RND: Dragonborn DLC not found...")
	endif
	
	if Game.GetFormFromFile(0x00005A68, "HearthFires.esm")
		RND_Straw = Game.GetFormFromFile(0x00005A68, "HearthFires.esm") as MiscObject
	else
		RND_Straw = None
		Debug.Trace("RND: HearthFires DLC not found...")
	endif

EndFunction


