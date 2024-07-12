Scriptname aaaKNNPlayPerkAnimCageQuest extends Quest

;aaaKNNAnimControlQuest Property POV auto
Quest Property animCtrl auto
;Spell Property aaaKNNPlayPerkCageOpenSpell auto
;Spell Property aaaKNNPlayPerkCageCloseSpell auto
MiscObject Property TG08SkeletonKey auto
MiscObject Property Lockpick auto

ObjectReference cage
Actor doorOpener
String unlockCageOpen
String cageStart
String cageClose
String lockCageOpen
String cageEnd

bool Function CanBeOpenCage(ObjectReference cageRef, Actor akActor)
	if !cageRef.IsLocked()
		return true
	endIf
	Key cageKey = cageRef.GetKey()
	if cageKey && akActor.GetItemCount(cageKey) > 0
		return true
	endIf
	return false
EndFunction

bool Function IsShowLockPick(ObjectReference cageRef, Actor akActor)
	if cageRef.GetLockLevel() != 255
		if akActor.GetItemCount(Lockpick) > 0 || akActor.GetItemCount(TG08SkeletonKey) > 0
			return true
		endIf
	endIf
	return false
EndFunction

Function SetEventName(Actor akActor)
	if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
		unlockCageOpen = "KNNActivateUnlockCageOpen"
		cageStart = "KNNActivateCageStart"
		cageClose = "KNNActivateCageClose"
		lockCageOpen = "KNNActivateLockCageOpen"
		cageEnd = "KNNActivateCageEnd"
	else
		unlockCageOpen = "KNNActivateUnlockCageOpen_M"
		cageStart = "KNNActivateCageStart_M"
		cageClose = "KNNActivateCageClose_M"
		lockCageOpen = "KNNActivateLockCageOpen_M"
		cageEnd = "KNNActivateCageEnd_M"
	endIf
EndFunction

Function ActivateCageGate(ObjectReference akTargetRef, Actor akActor, int OpenState)
	if KNNPlugin_Utility.IsTeammateFavor()
		return
	endIf
	float angleZ = akActor.GetHeadingAngle(akTargetRef)
	if angleZ >= -70 && angleZ <= 70
		SetEventName(akActor)
		(animCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState()		
		if OpenState == 3
			;aaaKNNPlayPerkCageOpenSpell.Cast(akActor)
			if CanBeOpenCage(akTargetRef, akActor)
				Debug.SendAnimationEvent(akActor, unlockCageOpen)
				Utility.wait(0.83)
				akTargetRef.Activate(akActor)
				Utility.wait(1.53)
				(animCtrl as aaaKNNAnimControlQuest).ReturnCameraState()
			else
				if IsShowLockPick(akTargetRef, akActor)
					RegisterForMenu("Lockpicking Menu")
					Debug.SendAnimationEvent(akActor, cageStart)
					Utility.wait(1.0)
					cage = akTargetRef
					doorOpener = akActor
				endIf
				akTargetRef.Activate(akActor)
			endIf
		elseIf OpenState == 1
			;aaaKNNPlayPerkCageCloseSpell.Cast(akActor)
			Debug.SendAnimationEvent(akActor, cageClose)
			Utility.wait(0.86)
			akTargetRef.Activate(akActor)
			Utility.wait(2.14)
			(animCtrl as aaaKNNAnimControlQuest).ReturnCameraState()
		endIf
	else
		akTargetRef.Activate(akActor)
	endIf
EndFunction

Event OnMenuClose(String MenuName)
	if MenuName == "Lockpicking Menu"
		UnregisterForMenu("Lockpicking Menu")
		if doorOpener && cage
			if !cage.IsLocked()
				Debug.SendAnimationEvent(doorOpener, lockCageOpen)
				Utility.wait(2.0)
			else
				Debug.SendAnimationEvent(doorOpener, cageEnd)
				Utility.wait(1.0)
			endIf
			doorOpener = none
			cage = none
		endIf
		(animCtrl as aaaKNNAnimControlQuest).ReturnCameraState()
	endIf
EndEvent