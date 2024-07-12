Scriptname aaaKNNPlayPerkCritterAquaticAnimQuest extends Quest

;Quest Property POV auto
;Quest Property PerkAnimUtility auto
Quest Property animCtrl auto
;Spell Property aaaKNNPlayPerkHarvestChouchingSpell auto
;Spell Property aaaKNNPlayPerkHarvestFishingSpell auto
;Spell[] Property AnimSpell auto
;String crouching
;String grab

Function HarvestCritterAquatic(ObjectReference akTargetRef, Actor akActor)
	if KNNPlugin_Utility.IsTeammateFavor()
		akTargetRef.Activate(akActor)
		return
	endIf
	float offset = KNNPlugin_Utility.GetHeadDiffarencePercent(akActor, akTargetRef, 0.91 , 0.9)
	string animEvent = ""
	float[] waitTime = new float[2]
	(animCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState()
	if offset < 0.3125
		;AnimSpell[0].Cast(akActor)
		if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
			animEvent = "KNNharvestPlantsCrouchingPosition"
			waitTime[0] = 1.36
			waitTime[1] = 1.24
		else
			animEvent = "KNNharvestPlantsCrouchingPosition_M"
			waitTime[0] = 1.36
			waitTime[1] = 1.24
		endIf
	else
		;AnimSpell[1].Cast(akActor)
		if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
			animEvent = "KNNharvestPlantsGrabFish"
			waitTime[0] = 1.54
			waitTime[1] = 1.76
		else
			animEvent = "KNNharvestPlantsGrabFish_M"
			waitTime[0] = 1.54
			waitTime[1] = 1.76
		endIf
	endIf
	Debug.SendAnimationEvent(akActor, animEvent)
	Utility.wait(waitTime[0])
	akTargetRef.Activate(akActor)
	Utility.wait(waitTime[1])
	(animCtrl as aaaKNNAnimControlQuest).ReturnCameraState()
EndFunction