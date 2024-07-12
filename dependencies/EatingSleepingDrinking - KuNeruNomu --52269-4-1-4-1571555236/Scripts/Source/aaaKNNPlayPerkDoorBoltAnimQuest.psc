Scriptname aaaKNNPlayPerkDoorBoltAnimQuest extends Quest

;Quest Property POV auto
Quest Property animCtrl auto
;Spell Property aaaKNNPlayPerkBoltCloseSpell auto
;Spell Property aaaKNNPlayPerkBoltOpenSpell auto

Function ActivateDoorBolt(ObjectReference akTargetRef, Actor akActor, int OpenState)
	if KNNPlugin_Utility.IsTeammateFavor()
		akTargetRef.Activate(akActor)
		return
	endIf
	float angleZ = akActor.GetHeadingAngle(akTargetRef)
	if angleZ >= -45.0 && angleZ <= 45.0
		string animEvent = ""
		float[] waitTime = new float[2]
		(animCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState()
		if OpenState == 3
			;aaaKNNPlayPerkBoltOpenSpell.Cast(akActor)
			if !akActor.IsSneaking()
				if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
					animEvent = "KNNOpenDoorBar"
				else
					animEvent = "KNNOpenDoorBar_M"
				endIf
			else
				if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
					animEvent = "KNNOpenDoorBarSneaking"
				else
					animEvent = "KNNOpenDoorBarSneaking_M"
				endIf
			endIf
			waitTime[0] = 1.06
			waitTime[1] = 1.54
		else		
			;aaaKNNPlayPerkBoltCloseSpell.Cast(akActor)
			if !akActor.IsSneaking()
				if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
					animEvent = "KNNCloseDoorBar"
				else
					animEvent = "KNNCloseDoorBar_M"
				endIf
			else
				if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
					animEvent = "KNNCloseDoorBarSneaking"
				else
					animEvent = "KNNCloseDoorBarSneaking_M"
				endIf
			endIf
			waitTime[0] = 1.06
			waitTime[1] = 1.54
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