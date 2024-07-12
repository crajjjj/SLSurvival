Scriptname aaaKNNPlayPerkPuzzleWheelAnimQuest extends Quest

;Quest Property POV auto
Quest Property animCtrl auto
;Spell Property aaaKNNPlayPerkWheelLSpell auto
;Spell Property aaaKNNPlayPerkWheelMSpell auto
;Spell Property aaaKNNPlayPerkWheelSSpell auto
;Spell Property aaaKNNPlayPerkWheelHSpell auto

Function ActivatePuzzleWheel(ObjectReference akTargetRef, Actor akActor, int piaceType)
	if KNNPlugin_Utility.IsTeammateFavor()
		akTargetRef.Activate(akActor)
		return
	endIf
	float angleZ = akActor.GetHeadingAngle(akTargetRef)
	string animEvent = ""
	float[] waitTime = new float[2]
	if piaceType == 3			
		if angleZ > -75.0 && angleZ < -30.0
			(animCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState()
			;aaaKNNPlayPerkWheelLSpell.Cast(akActor)
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				animEvent = "KNNActiLargePuzzleWheelRight"
			else
				animEvent = "KNNActiLargePuzzleWheelRight_M"
			endIf
			waitTime[0] = 0.52
			waitTime[1] = 2.18
		elseIf -30.0 <= angleZ && angleZ <= 30.0
			(animCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState()
			;aaaKNNPlayPerkWheelLSpell.Cast(akActor)
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				animEvent = "KNNActiLargePuzzleWheelCenter"
			else
				animEvent = "KNNActiLargePuzzleWheelCenter_M"
			endIf
			waitTime[0] = 0.52
			waitTime[1] = 3.28
		elseIf angleZ > 30.0 && angleZ < 75.0
			(animCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState()
			;aaaKNNPlayPerkWheelLSpell.Cast(akActor)
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				animEvent = "KNNActiLargePuzzleWheelLeft"
			else
				animEvent = "KNNActiLargePuzzleWheelLeft_M"
			endIf
			waitTime[0] = 0.52
			waitTime[1] = 3.18
		else
			akTargetRef.Activate(akActor)
			return
		endIf
	else
		if angleZ >= -70 && angleZ <= 70
			if piaceType == 2
				(animCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState()
				;aaaKNNPlayPerkWheelMSpell.Cast(akActor)
				if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
					animEvent = "KNNActiMidiumPuzzleWheel"
				else
					animEvent = "KNNActiMidiumPuzzleWheel_M"
				endIf
				waitTime[0] = 0.52
				waitTime[1] = 2.48
			elseIf piaceType == 1
				(animCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState()
				;aaaKNNPlayPerkWheelSSpell.Cast(akActor)
				if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
					animEvent = "KNNActiSmallPuzzleWheel"
				else
					animEvent = "KNNActiSmallPuzzleWheel_M"
				endIf
				waitTime[0] = 0.52
				waitTime[1] = 2.68
			elseIf piaceType == 4
				if !KNNPlugin_Utility.HasFittingDragonCrow(akTargetRef, akActor)
					akTargetRef.Activate(akActor)
					return
				endIf
				(animCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState()
				;aaaKNNPlayPerkWheelHSpell.Cast(akActor)
				if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
					animEvent = "KNNActiPuzzleWheelHole"
				else
					animEvent = "KNNActiPuzzleWheelHole_M"
				endIf
				waitTime[0] = 0.0
				waitTime[1] = 3.0
			endIf
		else
			akTargetRef.Activate(akActor)
			return
		endIf
	endIf
	Debug.SendAnimationEvent(akActor, animEvent)
	if 0.0 < waitTime[0]
		Utility.wait(waitTime[0])
	endIf
	akTargetRef.Activate(akActor)
	Utility.wait(waitTime[1])
	(animCtrl as aaaKNNAnimControlQuest).ReturnCameraState()
EndFunction