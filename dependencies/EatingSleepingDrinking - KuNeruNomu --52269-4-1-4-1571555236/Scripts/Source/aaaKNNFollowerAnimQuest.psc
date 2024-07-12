Scriptname aaaKNNFollowerAnimQuest extends Quest

Quest Property animCtrl auto
;Spell Property aaaKNNPlayPerkHarvestSittingSpell auto
;Spell Property aaaKNNPlayPerkHarvestChouchingSpell auto
;Spell Property aaaKNNPlayPerkHarvestStandingSpell auto
;Spell Property aaaKNNPlayPerkHarvestJumpingSpell auto
;Spell Property aaaKNNPlayPerkHarvestFishingSpell auto
Event OnFollowerHarvestPlants(Actor akActor, float PosZ, float actorHeight)
	if PosZ <= 0 || PosZ / actorHeight < 0.3125
		if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
			Debug.SendAnimationEvent(akActor, "KNNharvestPlants")
		else
			Debug.SendAnimationEvent(akActor, "KNNharvestPlants_M")
		endIf
	elseIf PosZ / actorHeight >= 0.3125 && PosZ / actorHeight < 0.85
		if 0 == Utility.RandomInt(0, 1)
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				Debug.SendAnimationEvent(akActor, "KNNharvestPlantsCrouchingPosition")
			else
				Debug.SendAnimationEvent(akActor, "KNNharvestPlantsCrouchingPosition_M")
			endIf
		else
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				Debug.SendAnimationEvent(akActor, "KNNHarvestPlantsCrouchingBasketStart")
			else
				Debug.SendAnimationEvent(akActor, "KNNHarvestPlantsCrouchingBasketStart_M")
			endIf
		endIf
	elseIf PosZ / actorHeight >= 0.85 && PosZ / actorHeight < 1.05
		if 0 == Utility.RandomInt(0, 1)
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				RegisterForAnimationEvent(akActor, "KNNharvestPlantsChestHeight")
			else
				RegisterForAnimationEvent(akActor, "KNNharvestPlantsChestHeight_M")
			endIf
		else
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				RegisterForAnimationEvent(akActor, "KNNharvestPlantsChestHeightTypeB")
			else
				RegisterForAnimationEvent(akActor, "KNNharvestPlantsChestHeightTypeB_M")
			endIf
		endIf
	else
		if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
			RegisterForAnimationEvent(akActor, "KNNHarvestFloraJumpStart")
		else
			RegisterForAnimationEvent(akActor, "KNNHarvestFloraJumpStart_M")
		endIf
	endIf
EndEvent

Event OnFollowerHarvestFishes(Actor akActor, float PosZ, float actorHeight)
	if PosZ / actorHeight >= 0.3125
		if 0 == Utility.RandomInt(0, 1)
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				Debug.SendAnimationEvent(akActor, "KNNharvestPlantsCrouchingPosition")
			else
				Debug.SendAnimationEvent(akActor, "KNNharvestPlantsCrouchingPosition_M")
			endIf
		else
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				Debug.SendAnimationEvent(akActor, "KNNHarvestPlantsCrouchingBasketStart")
			else
				Debug.SendAnimationEvent(akActor, "KNNHarvestPlantsCrouchingBasketStart_M")
			endIf
		endIf
	else
		if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
			RegisterForAnimationEvent(akActor, "KNNharvestPlantsGrabFish")
		else
			RegisterForAnimationEvent(akActor, "KNNharvestPlantsGrabFish_M")
		endIf
	endIf
EndEvent

;Spell Property aaaKNNPlayPerkDoorOpenSpell auto
;Spell Property aaaKNNPlayPerkDoorCloseSpell auto
Event OnFollowerActiDoor(Actor akActor, int OpenState)
	;if OpenState == 3
	;	aaaKNNPlayPerkDoorOpenSpell.Cast(akActor)
	;elseIf OpenState == 1
	;	aaaKNNPlayPerkDoorCloseSpell.Cast(akActor)
	;endIf
EndEvent

;Spell Property aaaKNNPlayPerkBoltCloseSpell auto
;Spell Property aaaKNNPlayPerkBoltOpenSpell auto
Event OnFollowerActiDoorBolt(Actor akActor, int OpenState)
	if OpenState == 3
		if !akActor.IsSneaking()
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				Debug.SendAnimationEvent(akActor, "KNNOpenDoorBar")
			else
				Debug.SendAnimationEvent(akActor, "KNNOpenDoorBar_M")
			endIf
		else
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				Debug.SendAnimationEvent(akActor, "KNNOpenDoorBarSneaking")
			else
				Debug.SendAnimationEvent(akActor, "KNNOpenDoorBarSneaking_M")
			endIf
		endIf
	elseIf OpenState == 1
		if !akActor.IsSneaking()
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				Debug.SendAnimationEvent(akActor, "KNNCloseDoorBar")
			else
				Debug.SendAnimationEvent(akActor, "KNNCloseDoorBar_M")
			endIf
		else
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				Debug.SendAnimationEvent(akActor, "KNNCloseDoorBarSneaking")
			else
				Debug.SendAnimationEvent(akActor, "KNNCloseDoorBarSneaking_M")
			endIf
		endIf
	endIf
EndEvent

;Spell Property aaaKNNPlayPerkPazzlePillarSpell auto
Event OnFollowerActiPuzzlePillar(Actor akActor)
	if !akActor.IsSneaking()
		if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
			Debug.SendAnimationEvent(akActor, "KNNActivatePazzlePillar")
		else
			Debug.SendAnimationEvent(akActor, "KNNActivatePazzlePillar_M")
		endIf
	else
		if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
			Debug.SendAnimationEvent(akActor, "KNNActivatePuzzlePillarSneaking")
		else
			Debug.SendAnimationEvent(akActor, "KNNActivatePuzzlePillarSneaking_M")
		endIf
	endIf
EndEvent

;Spell Property aaaKNNPlayPerkPraySpell auto
Event OnFollowerActiShrine(Actor akActor)
	if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
		Debug.sendAnimationEvent(akActor, "KNNPrayForDiseaseEnter")
		Utility.wait(4.0)
		Debug.SendAnimationEvent(akActor, "KNNPrayForDiseaseExit")
	else
		Debug.sendAnimationEvent(akActor, "KNNPrayForDiseaseEnter_M")
		Utility.wait(4.0)
		Debug.SendAnimationEvent(akActor, "KNNPrayForDiseaseExit_M")
	endIf
EndEvent

;Spell Property aaaKNNPlayPerkPullChainSpell auto
;Spell Property aaaKNNPlayPerkPullChainLowSpell auto
Event OnFollowerActiPullChain(Actor akActor, float subPosZ)
	if subPosZ > -130
		if !akActor.IsSneaking()
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				Debug.SendAnimationEvent(akActor, "KNNLowPullChain")
			else
				Debug.SendAnimationEvent(akActor, "KNNLowPullChain_M")
			endIf
		else
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				Debug.SendAnimationEvent(akActor, "KNNLowPullChainSneaking")
			else
				Debug.SendAnimationEvent(akActor, "KNNLowPullChainSneaking_M")
			endIf
		endIf
	else
		if !akActor.IsSneaking()
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				Debug.SendAnimationEvent(akActor, "KNNPullChain")
			else
				Debug.SendAnimationEvent(akActor, "KNNPullChain_M")
			endIf
		else
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				Debug.SendAnimationEvent(akActor, "KNNPullChainSneaking")
			else
				Debug.SendAnimationEvent(akActor, "KNNPullChainSneaking_M")
			endIf
		endIf
	endIf
EndEvent

;Spell Property aaaKNNPlayPerkPullBarSpell auto
;Spell Property aaaKNNPlayPerkPullBarLowSpell auto
Event OnFollowerActiPullBar(Actor akActor, float subPosZ)
	if subPosZ > -81.5
		if !akActor.IsSneaking()
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				Debug.SendAnimationEvent(akActor, "KNNLowPullBar")
			else
				Debug.SendAnimationEvent(akActor, "KNNLowPullBar_M")
			endIf
		else
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				Debug.SendAnimationEvent(akActor, "KNNLowPullBarSneaking")
			else
				Debug.SendAnimationEvent(akActor, "KNNLowPullBarSneaking_M")
			endIf
		endIf
	else
		if !akActor.IsSneaking()
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				Debug.SendAnimationEvent(akActor, "KNNPullBar")
			else
				Debug.SendAnimationEvent(akActor, "KNNPullBar_M")
			endIf
		else
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				Debug.SendAnimationEvent(akActor, "KNNPullBarSneaking")
			else
				Debug.SendAnimationEvent(akActor, "KNNPullBarSneaking_M")
			endIf
		endIf
	endIf
EndEvent

;Spell Property aaaKNNPlayPerkChestCrouchingSpell auto
;Spell Property aaaKNNPlayPerkChestHunchingSpell auto
;Spell Property aaaKNNPlayPerkChestStandingSpell auto
;Spell Property aaaKNNPlayPerkChestOnTipToeSpell auto
Event OnFollowerActiChest(Actor akActor, float PosZ)
	PlayStandardChest(akActor, PosZ)
EndEvent

Function PlayStandardChest(Actor akActor, float PosZ)
	if PosZ < 29
		PlayChestCrouching(akActor)
	elseIf PosZ < 50
		PlayChestHunching(akActor)
	elseIf PosZ <= 75
		PlayChestStanding(akActor)
	else
		PlayChestOnTiptoe(akActor)
	endIf
EndFunction

Function PlayChestCrouching(Actor akActor)
	if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
		Debug.SendAnimationEvent(akActor, "KNNOpenChestCrouching")
	else
		Debug.SendAnimationEvent(akActor, "KNNOpenChestCrouching_M")
	endIf
EndFunction
Function PlayChestHunching(Actor akActor)
	if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
		Debug.SendAnimationEvent(akActor, "KNNOpenChestHunching")
	else
		Debug.SendAnimationEvent(akActor, "KNNOpenChestHunching_M")
	endIf
EndFunction
Function PlayChestStanding(Actor akActor)
	if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
		Debug.SendAnimationEvent(akActor, "KNNOpenChestStanding")
	else
		Debug.SendAnimationEvent(akActor, "KNNOpenChestStanding_M")
	endIf
EndFunction
Function PlayChestOnTiptoe(Actor akActor)
	if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
		Debug.SendAnimationEvent(akActor, "KNNOpenChestStandingOnTiptoe")
	else
		Debug.SendAnimationEvent(akActor, "KNNOpenChestStandingOnTiptoe_M")
	endIf
EndFunction

Event OnFollowerActiBarrel(Actor akActor, float PosZ, float actorHeight, bool IsStandingContainer)
		if !IsStandingContainer
			;Debug.Notification("Horizontal barrel")
			if posZ > -49
				PlayChestCrouching(akActor)
			elseIf posZ >= -95
				PlayChestStanding(akActor)
			else
				PlayChestOnTiptoe(akActor)
			endIf
		else
			if posZ <= 0 || posZ / actorHeight < 0.3125
				PlayChestCrouching(akActor)
			elseIf posZ / actorHeight < 0.50
				PlayChestHunching(akActor)
			elseIf posZ / actorHeight < 1.05
				PlayChestStanding(akActor)
			else				
				PlayChestOnTiptoe(akActor)
			endIf
		endIf
EndEvent

;Spell Property aaaKNNPlayPerkCupBoardSpell auto
Event OnFollowerActiCupBoard(Actor akActor, float PosZ, bool IsStandingContainer)
	if !IsStandingContainer
		PlayStandardChest(akActor, PosZ)
	else				
		if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
			Debug.SendAnimationEvent(akActor, "KNNOpenCupBoard")
		else
			Debug.SendAnimationEvent(akActor, "KNNOpenCupBoard_M")
		endIf
	endIf
EndEvent

;Spell Property aaaKNNPlayPerkEndTableSpell auto
Event OnFollowerActiEndTable(Actor akActor, float PosZ, bool IsStandingContainer)
	if !IsStandingContainer
		PlayStandardChest(akActor, PosZ)
	else				
		if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
			Debug.SendAnimationEvent(akActor, "KNNOpenEndtable")
		else
			Debug.SendAnimationEvent(akActor, "KNNOpenEndtable_M")
		endIf
	endIf
EndEvent

;Spell Property aaaKNNPlayPerkWardrobeSpell auto
Event OnFollowerActiWardrobe(Actor akActor, float PosZ, bool IsStandingContainer)
	if !IsStandingContainer
		PlayStandardChest(akActor, PosZ)
	else				
		if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
			Debug.SendAnimationEvent(akActor, "KNNOpenWardrobe")
		else
			Debug.SendAnimationEvent(akActor, "KNNOpenWardrobe_M")
		endIf
	endIf
EndEvent

Event OnFollowerActiSack(Actor akActor, ObjectReference akActorRef)
		float playerPositionZ = akActor.GetPositionZ()
		float SackPositionZ = akActorRef.GetPositionZ()
		float offsetPosZ = playerPositionZ - SackPositionZ
		if playerPositionZ <= SackPositionZ  
			if offsetPosZ > 120.0
				PlayChestOnTiptoe(akActor)
			elseIf offsetPosZ > 70.0
				PlayChestStanding(akActor)
			elseIf offsetPosZ > 30.0
				PlayChestHunching(akActor)
			else
				PlayChestCrouching(akActor)
			endIf
		else
			PlayChestCrouching(akActor)
		endIf
EndEvent

;金庫/焼死体/ノルドの小骨壷?
Event OnFollowerActiMiscContainer(Actor akActor, ObjectReference akActorRef)
	float playerPositionZ = akActor.GetPositionZ()
	float SackPositionZ = akActorRef.GetPositionZ()
	float offsetPosZ = Math.sqrt((playerPositionZ - SackPositionZ) * (playerPositionZ - SackPositionZ))
	if playerPositionZ <= SackPositionZ  
		if offsetPosZ > 120.0
			PlayChestOnTiptoe(akActor)
		elseIf offsetPosZ > 70.0
			PlayChestStanding(akActor)
		elseIf offsetPosZ > 30.0
			PlayChestHunching(akActor)
		else
			PlayChestCrouching(akActor)
		endIf
	else
		PlayChestCrouching(akActor)
	endIf
EndEvent


Function FollowerCantDoIt(Actor akSpeakerRef)
	bool IsSuccess = aaaKNNFollowerSleepingKey.SendStoryEventAndWait(none, akSpeakerRef, none, 3, 0)
	;Debug.Trace("FollowerCantDoIt : " + IsSuccess)
EndFunction
Function FollowerPlayStrikeBedroll(Actor akSpeakerRef)
	if akSpeakerRef
		ObjectReference bedRef = Game.FindClosestReferenceOfAnyTypeInListFromRef(Bedroll_FURN_List, akSpeakerRef, 800.0)
		if bedRef && !bedRef.IsDisabled()
			if KNNPlugin_Utility.AreYouAlright(akSpeakerRef as ObjectReference)
				bool IsSuccess = aaaKNNFollowerSleepingKey.SendStoryEventAndWait(none, akSpeakerRef, bedRef, 2, 0)
				;Debug.Trace("FollowerPlayStrikeBedroll : " + IsSuccess)
			endIf
		else
			FollowerCantDoIt(akSpeakerRef)
		endIf
	endIf
EndFunction

FormList Property Bedroll_ACTI_List auto
FormList Property Bedroll_FURN_List auto
Keyword Property aaaKNNFollowerSleepingKey auto
Function FollowerPlayMakingBedroll(Actor akSpeakerRef)
	if akSpeakerRef
		ObjectReference bedRef = Game.FindClosestReferenceOfAnyTypeInListFromRef(Bedroll_ACTI_List, akSpeakerRef, 800.0)
		if bedRef && !bedRef.IsDisabled()
			if KNNPlugin_Utility.AreYouAlright(akSpeakerRef as ObjectReference)
				bool IsSuccess = aaaKNNFollowerSleepingKey.SendStoryEventAndWait(none, akSpeakerRef, bedRef, 1, 0)
				;Debug.Trace("FollowerPlayMakingBedroll : " + IsSuccess)
			endIf
		else
			FollowerCantDoIt(akSpeakerRef)
		endIf
	endIf
EndFunction

Keyword Property aaaKNNFollowerFillWaterBottleKey auto
Function FollowerPlayFillWaterBottle(ObjectReference akSpeakerRef)
	Actor follower = akSpeakerRef as Actor
	if follower && KNNPlugin_Utility.IsInWater(follower) && KNNPlugin_Utility.AreYouAlright(follower as ObjectReference)
		bool IsSuccess = aaaKNNFollowerFillWaterBottleKey.SendStoryEventAndWait(none, akSpeakerRef, none, 0, 0)
		;Debug.Trace("FollowerPlayFillWaterBottle : " + IsSuccess)
	endIf
EndFunction
Keyword Property aaaKNNFollowerWashBodyKey auto
Function FollowerPlayWashBody(ObjectReference akSpeakerRef)
	Actor follower = akSpeakerRef as Actor
	if follower && KNNPlugin_Utility.IsInWater(follower) && KNNPlugin_Utility.AreYouAlright(follower as ObjectReference)
		bool IsSuccess = aaaKNNFollowerWashBodyKey.SendStoryEventAndWait(none, akSpeakerRef, none, 0, 0)
		;Debug.Trace("FollowerPlayWashBody : " + IsSuccess)
	endIf
EndFunction
FormList Property Bedroll_MISC_List auto
Function FollowerDropBedroll(ObjectReference akSpeakerRef)
	if akSpeakerRef
		return
	endIf
	int i = 0
	while i < Bedroll_MISC_List.GetSize()
		form bed = Bedroll_MISC_List.GetAt(i)
		if bed
			int count = akSpeakerRef.GetItemCount(bed)
			while 0 < count
				akSpeakerRef.DropObject(bed)
				count -= 1
			endwhile
		endIf
		i += 1
	endwhile
EndFunction