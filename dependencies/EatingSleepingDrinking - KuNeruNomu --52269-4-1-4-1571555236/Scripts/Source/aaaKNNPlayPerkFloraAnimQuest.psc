Scriptname aaaKNNPlayPerkFloraAnimQuest extends Quest

Quest Property animCtrl auto
;Spell Property aaaKNNPlayPerkHarvestSittingSpell auto
;Spell Property aaaKNNPlayPerkHarvestChouchingSpell auto
;Spell Property aaaKNNPlayPerkHarvestStandingSpell auto
;Spell Property aaaKNNPlayPerkHarvestJumpingSpell auto
;Spell[] Property AnimSpell auto
;FormList Property aaaKNNFloatFloraList auto
;FormList Property aaaKNNFloraObjectCenterGravity auto

;0 : tree
;1 : insect
;2 : flora
Function HarvestFlora(ObjectReference akTargetRef, Actor akActor, int harvestType)
	if 0 == harvestType || 2 == harvestType
		if akTargetRef.IsHarvested()
			return
		endIf
	endIf
	if KNNPlugin_Utility.IsTeammateFavor()
		akTargetRef.Activate(akActor)
		return
	endIf
	float offsetZ = akActor.GetHeadingAngle(akTargetRef)
	if -55.0 > offsetZ || 55.0 < offsetZ
		akTargetRef.Activate(akActor)
		return
	endIf
	GoToState("BUSY")
	(animCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState()
	float offset = KNNPlugin_Utility.GetHeadDiffarencePercent(akActor, akTargetRef, 0.91 , 0.9)
	string AnimEvent = ""
	float[] waitTime = new float[2]
	;Debug.Notification("offset : " + offset)
	if offset < 0.3125		
		;AnimSpell[0].Cast(akActor)
		if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
			AnimEvent = "KNNharvestPlants"
			waitTime[0] = 1.63
			waitTime[1] = 1.07
		else
			AnimEvent = "KNNharvestPlants_M"
			waitTime[0] = 1.63
			waitTime[1] = 1.07
		endIf
	elseIf offset < 0.65;0.85
		;AnimSpell[1].Cast(akActor)
		if 0 == Utility.RandomInt(0, 1)
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				AnimEvent = "KNNharvestPlantsCrouchingPosition"
				waitTime[0] = 1.33
				waitTime[1] = 1.27
			else
				AnimEvent = "KNNharvestPlantsCrouchingPosition_M"
				waitTime[0] = 1.33
				waitTime[1] = 1.27
			endIf
		else
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				AnimEvent = "KNNHarvestPlantsCrouchingBasketStart"
				waitTime[0] = 1.33
				waitTime[1] = 1.5
			else
				AnimEvent = "KNNHarvestPlantsCrouchingBasketStart_M"
				waitTime[0] = 1.33
				waitTime[1] = 1.5
			endIf
		endIf
	elseIf offset < 0.91;OffsetChestHeight
		;AnimSpell[2].Cast(akActor)
		if 0 == Utility.RandomInt(0, 1)
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				AnimEvent = "KNNharvestPlantsChestHeight"
				waitTime[0] = 1.63
				waitTime[1] = 2.0
			else
				AnimEvent = "KNNharvestPlantsChestHeight_M"
				waitTime[0] = 1.63
				waitTime[1] = 2.0
			endIf
		else
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				AnimEvent = "KNNharvestPlantsChestHeightTypeB"
				waitTime[0] = 1.4
				waitTime[1] = 1.6
			else
				AnimEvent = "KNNharvestPlantsChestHeightTypeB_M"
				waitTime[0] = 1.4
				waitTime[1] = 1.6
			endIf
		endIf		
	else
		;AnimSpell[3].Cast(akActor)
		if harvestType == 1
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				AnimEvent = "KNNharvestInsectJump"
				waitTime[0] = 1.1
				waitTime[1] = 1.23
			else
				AnimEvent = "KNNharvestInsectJump_M"
				waitTime[0] = 1.1
				waitTime[1] = 1.23
			endIf
		else
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				AnimEvent = "KNNHarvestFloraJumpStart"
				waitTime[0] = 1.25
				waitTime[1] = 1.25
			else
				AnimEvent = "KNNHarvestFloraJumpStart_M"
				waitTime[0] = 1.25
				waitTime[1] = 1.25
			endIf
		endIf
	endIf
	Debug.SendAnimationEvent(akActor, AnimEvent)
	Utility.wait(waitTime[0])
	akTargetRef.Activate(akActor)
	Utility.wait(waitTime[1])
	(animCtrl as aaaKNNAnimControlQuest).ReturnCameraState()
	GoToState("")
EndFunction

State BUSY 
	Function HarvestFlora(ObjectReference akTargetRef, Actor akActor, int harvestType)
	EndFunction
EndState