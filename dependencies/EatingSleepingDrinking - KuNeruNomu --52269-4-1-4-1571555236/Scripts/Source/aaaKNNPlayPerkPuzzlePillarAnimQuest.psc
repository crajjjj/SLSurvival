Scriptname aaaKNNPlayPerkPuzzlePillarAnimQuest extends Quest

;Quest Property POV auto
Quest Property animCtrl auto
;Spell Property aaaKNNPlayPerkPazzlePillarSpell auto

Function ActivatePuzzlePillar(ObjectReference akTargetRef, Actor akActor)
	if KNNPlugin_Utility.IsTeammateFavor()
		akTargetRef.Activate(akActor)
		return
	endIf
	float angleZ = akActor.GetHeadingAngle(akTargetRef)
	if angleZ >= -45.0 && angleZ <= 45.0
		string animEvent = ""
		float[] waitTime = new float[2]
		(animCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState()
		;aaaKNNPlayPerkPazzlePillarSpell.Cast(akActor)
		;Debug.sendAnimationEvent(akActor, "idleStop")
		;Utility.wait(0.1)
		if !akActor.IsSneaking()
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				animEvent = "KNNActivatePazzlePillar"
			else
				animEvent = "KNNActivatePazzlePillar_M"
			endIf
			waitTime[0] = 0.96
			waitTime[1] = 1.6
		else
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				animEvent = "KNNActivatePuzzlePillarSneaking"
			else
				animEvent = "KNNActivatePuzzlePillarSneaking_M"
			endIf
			waitTime[0] = 1.1
			waitTime[1] = 1.46
		endIf
		Debug.SendAnimationEvent(akActor, animEvent)
		Utility.wait(waitTime[0])
		akTargetRef.Activate(akActor)
		Utility.wait(waitTime[1])
		(animCtrl as aaaKNNAnimControlQuest).ReturnCameraState()
	else
		akTargetRef.Activate(akActor)
	endIf
EndFunction