Scriptname aaaKNNFollowerMealQuest extends Quest

;Spell Property defaultDrinkingSpell auto
;Spell Property defaultEatingSpell auto
Quest Property AnimCtrl auto

;Function Startup()
;	RegisterForSingleUpdate(1200.0)
;EndFunction

Event OnUpdate()
	Stop()
EndEvent

Function StartFollowerMeal(Actor thisActor, bool IsFoodAnim)
	if thisActor
		bool IsFemale = (AnimCtrl as aaaKNNAnimControlQuest).GetGender(thisActor)
		Form food = KNNPlugin_Utility.GetFood(thisActor, IsFoodAnim)
		Form shield = thisActor.GetWornForm(0x00000200)
		if shield
			thisActor.UnequipItemEx(shield)
		endIf
		if food
			int foodTyep = 16
			string callName = "bread"
			if !IsFoodAnim
				foodTyep = 13
				callName = "tankard"
			endIf
			string[] animData = KNNPlugin_Utility.GetAnimation(foodTyep, IsFemale, food, callName)
			if 2 == animData.Length
				if 0 < thisActor.GetItemCount(food)
					thisActor.RemoveItem(food, 1, true, None)
					;actorfollower.EquipItem(food, false, true)
				endIf
				Utility.wait(0.1)
				Debug.SendAnimationEvent(thisActor, animData[0])
				float duration = animData[1] as float
				if 60.0 < duration
					duration = 60.0
				endIf
				RegisterForSingleUpdate(duration)
				return
			endIf
		endIf
		string defaultAnim = "idleEatingStandingStart"
		if !IsFoodAnim
			defaultAnim = "idleDrinkingStandingStart"
		endIf
		Debug.SendAnimationEvent(thisActor, defaultAnim)
		RegisterForSingleUpdate(7.0)
	endIf
EndFunction