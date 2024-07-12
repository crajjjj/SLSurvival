Scriptname aaaKNNPlayPerkDweBottonAnimQuest extends Quest

Quest Property POV auto
;Spell Property aaaKNNPlayPerkDweBottonSpell auto
Function ActivateDweBotton(ObjectReference akTargetRef, Actor akActor)
	if KNNPlugin_Utility.IsTeammateFavor()
		akTargetRef.Activate(akActor)
		return
	endIf
	float angleZ = akActor.GetHeadingAngle(akTargetRef)
	if angleZ >= -45.0 && angleZ <= 45.0
		(POV as aaaKNNAnimControlQuest).SetThirdPersonCameraState()
		;aaaKNNPlayPerkDweBottonSpell.Cast(akActor)
		;Debug.sendAnimationEvent(akActor, "idleStop")
		;Utility.wait(0.1)
		if (POV as aaaKNNAnimControlQuest).GetGender(akActor)
			Debug.SendAnimationEvent(akActor, "KNNActivateDweBotton")
		else
			Debug.SendAnimationEvent(akActor, "KNNActivateDweBotton_M")
		endIf
		Utility.wait(1.5)
		akTargetRef.Activate(akActor)
		Utility.wait(1.0)
		(POV as aaaKNNAnimControlQuest).ReturnCameraState()
	else
		akTargetRef.Activate(akActor)
	endIf
EndFunction