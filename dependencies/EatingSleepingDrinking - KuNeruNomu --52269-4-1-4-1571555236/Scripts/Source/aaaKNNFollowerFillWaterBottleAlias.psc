Scriptname aaaKNNFollowerFillWaterBottleAlias extends ReferenceAlias  

Quest Property animCtrl auto
Package Property FillWaterPackage auto

Event OnPackageStart(Package akNewPackage)
	if akNewPackage == FillWaterPackage
		FollowerPlayFillWaterBottle()
	endIf
EndEvent

FormList Property aaaKNNEmptyBottleList auto
FormList Property aaaKNNWaterBottleForDialogueList auto
;FormList Property aaaKNNAnimFillWaterBottleSpellList auto

Function FollowerPlayFillWaterBottle()
	;Debug.Trace("FollowerPlayFillWaterBottle")
	Actor thisActor = Self.GetActorReference()
	if thisActor		
		if aaaKNNEmptyBottleList && aaaKNNWaterBottleForDialogueList && aaaKNNEmptyBottleList.GetSize() == aaaKNNWaterBottleForDialogueList.GetSize()
			int size = aaaKNNEmptyBottleList.GetSize()
			int i = 0
			while i < size
				Form emptyBottle = aaaKNNEmptyBottleList.GetAt(i)
				Form waterBottle = aaaKNNWaterBottleForDialogueList.GetAt(i)
				if emptyBottle && waterBottle
					int itemCount = thisActor.GetItemCount(emptyBottle)
					if itemCount > 0
						thisActor.AddItem(waterBottle, itemCount, true)
						thisActor.RemoveItem(emptyBottle, itemCount, true)
					endIf
				endIf
				i += 1
			endwhile
		endIf
		RegisterAnimEvent(thisActor)
	endIf
EndFunction

Function RegisterAnimEvent(Actor thisActor)
	bool IsFemale = (animCtrl as aaaKNNAnimControlQuest).GetGender(thisActor)
		;RegisterForAnimationEvent(thisActorRef, "KNNFillWaterBottleCrouchingEnd_DONE")
		;RegisterForAnimationEvent(thisActorRef, "KNNAnimObjectFillWaterBottleEnd_DONE")
		;RegisterForAnimationEvent(thisActorRef, "KNNFillWaterBlackBottleCrouchingEnd_DONE")
		;RegisterForAnimationEvent(thisActorRef, "KNNAnimObjectFillWaterBlackBottleEnd_DONE")
		;RegisterForAnimationEvent(thisActorRef, "KNNFillWaterMeadBottleCrouchingEnd_DONE")
		;RegisterForAnimationEvent(thisActorRef, "KNNAnimObjectFillMeadWaterBottleEnd_DONE")
	string[] animData = KNNPlugin_Utility.GetAnimation(9, IsFemale, none, "wine")
	if 2 != animData.Length
		GetOwningQuest().Stop()	
	endIf
	Debug.SendAnimationEvent(thisActor, animData[0])
	float interval = animData[1] as float
	if 10.0 < interval
		interval = 10.0
	endIf
	RegisterForSingleUpdate(interval)
	;else
		;RegisterForAnimationEvent(thisActorRef, "KNNFillWaterBottleCrouchingEnd_M_DONE")
		;RegisterForAnimationEvent(thisActorRef, "KNNAnimObjectFillWaterBottleEnd_M_DONE")
		;RegisterForAnimationEvent(thisActorRef, "KNNFillWaterBlackBottleCrouchingEnd_M_DONE")
		;RegisterForAnimationEvent(thisActorRef, "KNNAnimObjectFillWaterBlackBottleEnd_M_DONE")
		;RegisterForAnimationEvent(thisActorRef, "KNNFillWaterMeadBottleCrouchingEnd_M_DONE")
		;RegisterForAnimationEvent(thisActorRef, "KNNAnimObjectFillMeadWaterBottleEnd_M_DONE")
	;	string[] animData = KNNPlugin_Utility.GetAnimation(9, false, "wine")
	;	if 2 != animData.Length
	;		GetOwningQuest().Stop()	
	;	endIf
	;	Debug.SendAnimationEvent(thisActor, "KNNFillWaterBottleCrouching")
	;endIf
EndFunction
Event OnUpdate()
	GetOwningQuest().Stop()	
EndEvent
;Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	;if asEventName == "KNNAnimObjectFillWaterBottleEnd_DONE" || asEventName == "KNNFillWaterBottleCrouchingEnd" || asEventName == "JumpDown"
	;if asEventName == "KNNFillWaterBottleCrouchingEnd_DONE" || asEventName == "KNNAnimObjectFillWaterBottleEnd_DONE" || asEventName == "KNNFillWaterBlackBottleCrouchingEnd_DONE" || asEventName == "KNNAnimObjectFillWaterBlackBottleEnd_DONE" || asEventName == "KNNFillWaterMeadBottleCrouchingEnd_DONE" || asEventName == "KNNAnimObjectFillMeadWaterBottleEnd_DONE"
		;Debug.Notification("OnAnimationEvent : " + asEventName)
		;Debug.sendAnimationEvent(akSource, "idleStop")
	;	GetOwningQuest().Stop()
	;elseIf asEventName == "KNNFillWaterBottleCrouchingEnd_M_DONE" || asEventName == "KNNAnimObjectFillWaterBottleEnd_M_DONE" || asEventName == "KNNFillWaterBlackBottleCrouchingEnd_M_DONE" || asEventName == "KNNAnimObjectFillWaterBlackBottleEnd_M_DONE" || asEventName == "KNNFillWaterMeadBottleCrouchingEnd_M_DONE" || asEventName == "KNNAnimObjectFillMeadWaterBottleEnd_M_DONE"
		;Debug.Notification("OnAnimationEvent : " + asEventName)
		;Debug.sendAnimationEvent(akSource, "idleStop")
	;	GetOwningQuest().Stop()	
	;endIf
;EndEvent