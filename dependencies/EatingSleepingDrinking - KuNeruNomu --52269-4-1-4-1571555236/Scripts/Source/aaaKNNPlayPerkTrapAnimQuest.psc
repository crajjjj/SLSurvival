Scriptname aaaKNNPlayPerkTrapAnimQuest extends Quest

;Quest Property POV auto
Quest Property animCtrl auto
;Spell Property aaaKNNPlayPerkChestOnTipToeSpell auto
;Spell Property aaaKNNPlayPerkChestStandingSpell auto
;Spell Property aaaKNNPlayPerkChestHunchingSpell auto
;Spell Property aaaKNNPlayPerkChestCrouchingSpell auto

Function ActivateTraps(ObjectReference akTargetRef, Actor akActor)
	if KNNPlugin_Utility.IsTeammateFavor()
		akTargetRef.Activate(akActor)
		return
	endIf
	float offsetPosZ = akTargetRef.GetPositionZ() - akActor.GetPositionZ()
	string animEvent = ""
	float[] waitTime = new float[2]
	(animCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState()
	if offsetPosZ > 150.0
		;aaaKNNPlayPerkChestOnTipToeSpell.Cast(akActor)
		if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
			animEvent = "KNNOpenChestStandingOnTiptoe"
			waitTime[0] = 0.8
			waitTime[1] = 1.2
		else
			animEvent = "KNNOpenChestStandingOnTiptoe_M"
			waitTime[0] = 0.8
			waitTime[1] = 1.2
		endIf
	elseIf offsetPosZ > 70.0
		;aaaKNNPlayPerkChestStandingSpell.Cast(akActor)
		if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
			animEvent = "KNNOpenChestStanding"
			waitTime[0] = 0.73
			waitTime[1] = 1.17
		else
			animEvent = "KNNOpenChestStanding_M"
			waitTime[0] = 0.73
			waitTime[1] = 1.17
		endIf
	elseIf offsetPosZ > 15.0
		;aaaKNNPlayPerkChestHunchingSpell.Cast(akActor)
		if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
			animEvent = "KNNOpenChestHunching"
			waitTime[0] = 1.0
			waitTime[1] = 1.2
		else
			animEvent = "KNNOpenChestHunching_M"
			waitTime[0] = 1.0
			waitTime[1] = 1.2
		endIf
	else
		;aaaKNNPlayPerkChestCrouchingSpell.Cast(akActor)
		if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
			animEvent = "KNNOpenChestCrouching"
			waitTime[0] = 0.83
			waitTime[1] = 1.37
		else	
			animEvent = "KNNOpenChestCrouching_M"
			waitTime[0] = 0.83
			waitTime[1] = 1.37
		endIf
	endIf
	Debug.SendAnimationEvent(akActor, animEvent)
	Utility.wait(waitTime[0])
	akTargetRef.Activate(akActor)
	Utility.wait(waitTime[1])
	(animCtrl as aaaKNNAnimControlQuest).ReturnCameraState()
EndFunction