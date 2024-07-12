Scriptname aaaKNNPlayPerkDisplayCaseAnimQuest extends Quest

;Quest Property POV auto
Quest Property animCtrl auto
;Spell Property aaaKNNPlayPerkDisplayCaseOpenSpell auto
;Spell Property aaaKNNPlayPerkDisplayCaseCloseSpell auto

Function ActivateDisplayCase(ObjectReference akTargetRef, Actor akActor)
	if KNNPlugin_Utility.IsTeammateFavor()
		akTargetRef.Activate(akActor)
		return
	endIf
	float angleZ = akActor.GetHeadingAngle(akTargetRef)
	if angleZ >= -45.0 && angleZ <= 45.0
		;int caseType = -1
		;Form baseForm = akTargetRef.GetBaseObject()
		;if baseForm
		;	caseType = aaaKNNDisplayCase.Find(baseForm)
		;endIf
		;if caseType == -1
		;	return
		;endIf
		int OpenState = akTargetRef.GetOpenState()
		;Debug.sendAnimationEvent(akActor, "idleStop")
		;Utility.wait(0.1)
		if !OpenState || 2 == OpenState || 4 == OpenState
			akTargetRef.Activate(akActor)
			return
		endIf
		(animCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState()
		string animEvent = ""
		float[] waitTime = new float[2]
		if OpenState == 3
			;aaaKNNPlayPerkDisplayCaseOpenSpell.Cast(akActor)
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				animEvent = "KNNOpenDisplayCaseStart"
			else
				animEvent = "KNNOpenDisplayCaseStart_M"
			endIf
			waitTime[0] = 0.6
			waitTime[1] = 1.9
		elseIf OpenState == 1
			;aaaKNNPlayPerkDisplayCaseCloseSpell.Cast(akActor)
			if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
				animEvent = "KNNCloseDisplayCaseStart"
			else
				animEvent = "KNNCloseDisplayCaseStart_M"
			endIf
			waitTime[0] = 1.0
			waitTime[1] = 1.83
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