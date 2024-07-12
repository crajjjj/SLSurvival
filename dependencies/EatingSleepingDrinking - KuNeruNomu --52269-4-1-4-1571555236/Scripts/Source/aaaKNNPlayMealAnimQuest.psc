Scriptname aaaKNNPlayMealAnimQuest extends Quest

;Event OnPlayerMeal(Actor player, Spell animSpell)
	;Debug.Notification("OnPlayerMeal" + ", AnimType : " + AnimType + ", SitState : " + SitState)
;	if player && animSpell
;		animSpell.Cast(player)
;	endIf
;EndEvent

;Spell Property aaaKNNPlayDrinkMoveSpell auto

;Event OnPlayerMovingDrink(Actor player, Spell animSpell)
;	if player && animSpell
;		animSpell.Cast(player)
;	endIf
;EndEvent

;Spell Property aaaKNNPlayFillWaterBottleSpell auto
;Event OnPlayerFillWaterBottle(Actor player, Spell animSpell)
	;Debug.Notification("OnPlayerFillWaterBottle")
;	if player && animSpell
;		animSpell.Cast(player)
;	endIf
;EndEvent

Event OnPlayerGetEmptyBottle(Actor player, potion bottle, int count)
	;Debug.Notification("OnPlayerGetEmptyBottle")
	player.AddItem(bottle, count, true)
EndEvent

Event OnPlayerGetWaterBottle(Actor player, potion bottle)
	;Debug.Notification("OnPlayerGetWaterBottle")
	player.AddItem(bottle, 1, true)
EndEvent

;Event KNNOnLoadGame()
;	;Debug.Trace("MealAnimQuest -> KNNOnLoadGame")
;	RegisterMealAnimModEvent()
;EndEvent

GlobalVariable Property PlayerFollowerCount auto
GlobalVariable Property aaaKNNFollowerPlayMeal auto
Keyword Property aaaKNNFollowerMealKey auto
;ReferenceAlias Property Follower auto
Function SetFollowerMealAnimEvent(int IsStartFeature)	;From MCM
	if 1 == IsStartFeature
		((Self as Quest) as aaaKNNAnimControlQuest).SetQuestControl(true)
		;if !Self.IsRunning()
		;	Self.Start()
			;Debug.Notification("SetFollowerMealAnimEvent -> StartQuest")
		;endIf
		RegisterMealAnimModEvent()
	else
		UnregisterForModEvent("KNNSendMealAnim")
		((Self as Quest) as aaaKNNAnimControlQuest).SetQuestControl(false)
		;if Self.IsRunning()
		;	Self.Stop()
			;Debug.Notification("SetFollowerMealAnimEvent -> StopQuest")
		;endIf
	endIf
EndFunction

Function RegisterMealAnimModEvent()
	RegisterForModEvent("KNNSendMealAnim", "KNNOnFollowerPlayMealAnim")
EndFunction

Event KNNOnFollowerPlayMealAnim(Form playedActor, Form actionActor, int foodTypeIndex, int alwaysNULL)
	if playedActor as Actor
		Actor thisActor = playedActor as Actor
		if thisActor
			;Debug.Trace(thisActor.GetBaseObject().GetName())
			if thisActor != Game.GetPlayer() || 0 == aaaKNNFollowerPlayMeal.GetValueInt() || 1 > PlayerFollowerCount.GetValueInt()
				return
			endIf
	
			;foodTypeIndex
			;1 : eating
			;2 : driking
			;3 : a hand full of water
			ObjectReference actionRef = none
			if actionActor && actionActor as Actor
				actionRef = actionActor as ObjectReference
			endIf
			bool isSeikou = aaaKNNFollowerMealKey.SendStoryEventAndWait(none, actionRef, none, foodTypeIndex, 0)
			;Debug.Notification("OnFollowerPlayMealAnim -> foods -> SendStoryEventAndWait : " + isSeikou)
		endIf
	endIf
EndEvent