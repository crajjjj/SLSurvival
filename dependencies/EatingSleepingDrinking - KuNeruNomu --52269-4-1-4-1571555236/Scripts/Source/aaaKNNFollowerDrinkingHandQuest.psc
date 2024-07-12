Scriptname aaaKNNFollowerDrinkingHandQuest extends Quest  

;ReferenceAlias Property Follower auto
;Spell Property aaaKNNPlayIdleDrinkWaterSpell auto
;Package Property aaaKNNFollowerDrinkingHandPackage auto
Quest Property animCtrl auto
Quest Property pre auto

Function SetFollowerDrinkWaterUsingHand(Actor aliasActor)
	;Actor thisActor = Follower.GetActorReference()
	if aliasActor && Self.IsRunning()
		;Debug.Trace("SetFollowerDrinkWaterUsingHand -> SetFollowerDrinkWaterUsingHand")
		;RegisterForAnimationEvent(aliasActor, "KNNScoopHandfulsWaterEnd_DONE")
		;RegisterForAnimationEvent(aliasActor, "KNNDrinkWaterCrouchingEnd_DONE")
		;RegisterForAnimationEvent(aliasActor, "KNNScoopHandfulsWaterEnd_M_DONE")
		;RegisterForAnimationEvent(aliasActor, "KNNDrinkWaterCrouchingEnd_M_DONE")
		;aaaKNNPlayIdleDrinkWaterSpell.Cast(aliasActor)
		Form shield = aliasActor.GetWornForm(0x00000200)
		if shield
			aliasActor.UnequipItemEx(shield)
		endIf
		bool IsFemale = (AnimCtrl as aaaKNNAnimControlQuest).GetGender(aliasActor)
		string[] animData = KNNPlugin_Utility.GetAnimation((pre as _KNNPrePlayAnimationQuest).TYPE_DRINKWATER_HANDS, IsFemale, none, "random")
		if 2 != animData.Length
			Stop()
		endIf
		Debug.SendAnimationEvent(aliasActor, animData[0])
		float duration = animData[1] as float
		if 10.0 < duration
			duration = 10.0
		endIf
		RegisterForSingleUpdate(duration)
	endIf
EndFunction

Event OnUpdate()
	Stop()
ENdEvent

;Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	;if asEventName == "KNNScoopHandfulsWaterEnd_DONE" || asEventName == "KNNDrinkWaterCrouchingEnd_DONE" || asEventName == "KNNScoopHandfulsWaterEnd_M_DONE" || asEventName == "KNNDrinkWaterCrouchingEnd_M_DONE"
		;Debug.Notification("OnAnimationEvent : " + asEventName)
		;Debug.sendAnimationEvent(akSource, "idleStop")
	;	if Self.IsRunning()
	;		Self.Stop()
			;Debug.Trace("SetFollowerDrinkWaterUsingHand -> StopQuest")
	;	endIf
	;endIf
;EndEvent