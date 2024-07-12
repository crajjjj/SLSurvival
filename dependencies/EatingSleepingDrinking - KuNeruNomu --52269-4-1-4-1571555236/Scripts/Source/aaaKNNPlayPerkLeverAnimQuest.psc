Scriptname aaaKNNPlayPerkLeverAnimQuest extends Quest

;Quest Property POV auto
Quest Property animCtrl auto
;Spell Property aaaKNNPlayPerkLeverSpell auto

Function ActivateLever(ObjectReference akTargetRef, Actor akActor)
	if KNNPlugin_Utility.IsTeammateFavor()
		akTargetRef.Activate(akActor)
		return
	endIf
	;Debug.Notification("ActivateLever")	
	int animType = KNNPlugin_Utility.SetActivateLeverAnim(akTargetRef ,akActor)
	if animType == 0
		akTargetRef.Activate(akActor)
		return
	endIf
	(animCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState()
	;aaaKNNPlayPerkLeverSpell.Cast(akTargetRef, akActor)
	;Debug.SendAnimationEvent(akActor, "idleStop")	
	;Utility.wait(0.1)
	string animEvent = ""
	float[] waitTime = new float[2]
	if animType == 1		
		if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
			animEvent = "KNNActivateLeverUp"
		else
			animEvent = "KNNActivateLeverUp_M"
		endIf
		waitTime[0] = 0.96
		waitTime[1] = 1.37
	elseIf animType == 2
		if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
			animEvent = "KNNActivateLeverDown"
		else
			animEvent = "KNNActivateLeverDown_M"
		endIf
		waitTime[0] = 0.96
		waitTime[1] = 1.37
	elseIf animType == 3
		if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
			animEvent = "KNNActivateLeverFront"
		else
			animEvent = "KNNActivateLeverFront_M"
		endIf
		waitTime[0] = 0.83
		waitTime[1] = 2.27
	elseIf animType == 4
		if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
			animEvent = "KNNActivateLeverRight"
		else
			animEvent = "KNNActivateLeverRight_M"
		endIf
		waitTime[0] = 1.0
		waitTime[1] = 2.27
	elseIf animType == 5
		if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
			animEvent = "KNNActivateLeverLeft"
		else
			animEvent = "KNNActivateLeverLeft_M"
		endIf
		waitTime[0] = 1.0
		waitTime[1] = 1.33
	elseIf animType == 6
		if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
			animEvent = "KNNActivateLeverBack"
		else
			animEvent = "KNNActivateLeverBack_M"
		endIf
		waitTime[0] = 0.83
		waitTime[1] = 1.5
	endIf
	Debug.SendAnimationEvent(akActor, animEvent)
	Utility.wait(waitTime[0])
	akTargetRef.Activate(akActor)
	Utility.wait(waitTime[1])
	(animCtrl as aaaKNNAnimControlQuest).ReturnCameraState()
EndFunction

Function ActivateFurnitureLever(ObjectReference akTargetRef, Actor akActor)
	;if KNNPlugin_Utility.IsTeammateFavor()
	;	return
	;endIf
	;if !POV.SetThirdPersonCameraState()
	;	akTargetRef.Activate(akActor)
	;	return
	;endIf
	;aaaKNNPlayPerkLeverSpell.Cast(akTargetRef, akActor)
	;Debug.SendAnimationEvent(akActor, "idleStop")		
	;KNNPlugin_Utility.GetFurnitureLeverAnim(akTargetRef ,akActor)
	;Utility.wait(0.1)
	
	;POV.ReturnCameraState()
EndFunction