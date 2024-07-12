Scriptname aaaKNNPlayPerkPullBarAnimQuest extends Quest

;Quest Property POV auto
Quest Property animCtrl auto
;Spell Property aaaKNNPlayPerkPullBarSpell auto
;Spell Property aaaKNNPlayPerkPullBarLowSpell auto

Function ActivatePullBar(ObjectReference akTargetRef, Actor akActor)
	if KNNPlugin_Utility.IsTeammateFavor()
		akTargetRef.Activate(akActor)
		return
	endIf
	(animCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState()
	string animEvent = ""
	float[] waitTime = new float[2]
	if akActor.GetPositionZ() - akTargetRef.GetPositionZ() > -81.5
		;aaaKNNPlayPerkPullBarLowSpell.Cast(akActor)
		if !akActor.IsSneaking()
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				animEvent = "KNNLowPullBar"
			else
				animEvent = "KNNLowPullBar_M"
			endIf
			waitTime[0] = 0.8
			waitTime[1] = 1.6
		else
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				animEvent = "KNNLowPullBarSneaking"
			else
				animEvent = "KNNLowPullBarSneaking_M"
			endIf
			waitTime[0] = 0.8
			waitTime[1] = 1.7
		endIf
	else
		;aaaKNNPlayPerkPullBarSpell.Cast(akActor)
		if !akActor.IsSneaking()
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				animEvent = "KNNPullBar"
			else
				animEvent = "KNNPullBar_M"
			endIf
			waitTime[0] = 0.63
			waitTime[1] = 1.57
		else
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				animEvent = "KNNPullBarSneaking"
			else
				animEvent = "KNNPullBarSneaking_M"
			endIf
			waitTime[0] = 0.7
			waitTime[1] = 1.8
		endIf
	endIf
	Debug.SendAnimationEvent(akActor, animEvent)
	Utility.wait(waitTime[0])
	akTargetRef.Activate(akActor)
	Utility.wait(waitTime[1])
	(animCtrl as aaaKNNAnimControlQuest).ReturnCameraState()
EndFunction