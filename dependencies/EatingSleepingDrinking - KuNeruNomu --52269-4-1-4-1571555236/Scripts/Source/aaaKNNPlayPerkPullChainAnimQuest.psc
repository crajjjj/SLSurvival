Scriptname aaaKNNPlayPerkPullChainAnimQuest extends Quest

;Quest Property POV auto
Quest Property animCtrl auto
;Spell Property aaaKNNPlayPerkPullChainSpell auto
;Spell Property aaaKNNPlayPerkPullChainLowSpell auto

Function ActivatePullChain(ObjectReference akTargetRef, Actor akActor, Bool IsFurniture)
	if KNNPlugin_Utility.IsTeammateFavor()
		akTargetRef.Activate(akActor)
		return
	endIf	
	(animCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState()
	string animEvent = ""
	float[] waitTime = new float[2]
	if !IsFurniture && akActor.GetPositionZ() - akTargetRef.GetPositionZ() > -130.0
		;aaaKNNPlayPerkPullChainLowSpell.Cast(akActor)
		if !akActor.IsSneaking()
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				animEvent = "KNNLowPullChain"
			else
				animEvent = "KNNLowPullChain_M"
			endIf
		else
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				animEvent = "KNNLowPullChainSneaking"
			else
				animEvent = "KNNLowPullChainSneaking_M"
			endIf
		endIf
		waitTime[0] = 0.8
		waitTime[1] = 1.2
	else
		;aaaKNNPlayPerkPullChainSpell.Cast(akActor)
		if !akActor.IsSneaking()
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				animEvent = "KNNPullChain"
			else
				animEvent = "KNNPullChain_M"
			endIf
		else
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				animEvent = "KNNPullChainSneaking"
			else
				animEvent = "KNNPullChainSneaking_M"
			endIf
		endIf
		waitTime[0] = 0.8
		waitTime[1] = 1.2
	endIf
	Debug.SendAnimationEvent(akActor, animEvent)
	Utility.wait(waitTime[0])
	akTargetRef.Activate(akActor)
	Utility.wait(waitTime[1])
	(animCtrl as aaaKNNAnimControlQuest).ReturnCameraState()
EndFunction