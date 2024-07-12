Scriptname aaaKNNPlayPerkShrineAnimQuest extends Quest

Quest Property AnimCtrl auto
;Spell Property aaaKNNPlayPerkPraySpell auto

Function ActivateShrine(ObjectReference akTargetRef, Actor akActor)
	if KNNPlugin_Utility.IsTeammateFavor()
		akTargetRef.Activate(akActor)
		return
	endIf
	float angleZ = akActor.GetHeadingAngle(akTargetRef)
	if angleZ >= -45.0 && angleZ <= 45.0
		string[] animEvent = new string[2]
		if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
			animEvent[0] = "KNNPrayForDiseaseEnter"
			animEvent[1] = "KNNPrayForDiseaseExit"
		else
			animEvent[0] = "KNNPrayForDiseaseEnter_M"
			animEvent[1] = "KNNPrayForDiseaseExit_M"
		endIf
		(AnimCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState()
		;aaaKNNPlayPerkPraySpell.Cast(akActor)
		KNNPlugin_Utility.SetExpressionState(0x04)
		;(AnimCtrl as aaaKNNExpressionQuestScript).ClearPlayerExpression()
		;Debug.sendAnimationEvent(akActor, "idleStop")
		;Utility.wait(0.1)
		Debug.sendAnimationEvent(akActor, animEvent[0])
		Utility.wait(3.1)
		;(AnimCtrl as aaaKNNExpressionQuestScript).SetPlayerExpression("Pray")
		Utility.wait(2.0)
		akTargetRef.Activate(akActor)
		Utility.wait(4.0)
		Debug.SendAnimationEvent(akActor, animEvent[1])
		Utility.wait(2.4)
		KNNPlugin_Utility.ClearExpressionState(0x04)
		;(AnimCtrl as aaaKNNExpressionQuestScript).ClearPlayerExpression()
		(AnimCtrl as aaaKNNAnimControlQuest).ReturnCameraState()
	else
		akTargetRef.Activate(akActor)
	endIf
EndFunction