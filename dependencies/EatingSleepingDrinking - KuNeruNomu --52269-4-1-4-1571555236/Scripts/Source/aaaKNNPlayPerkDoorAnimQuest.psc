Scriptname aaaKNNPlayPerkDoorAnimQuest extends Quest

;Quest Property POV auto
Quest Property animCtrl auto
ReferenceAlias Property targetRefAlias auto

bool Function CanPlayDoorAnim(ObjectReference akTargetRef, Actor akActor)
	float angleZ = akActor.GetHeadingAngle(akTargetRef)
	;if angleZ > -135.0 && angleZ < -45.0
	;	return false
	;elseIf angleZ > 45.0 && angleZ < 135.0
	;	return false
	;endIf
	if angleZ >= -45.0 && angleZ <= 45.0
		return true
	endIf
	return false
EndFunction

bool Function CanBeOpenDoor(ObjectReference doorRef, Actor akActor)
	if !doorRef.IsLocked()
		return true
	endIf
	Key doorKey = doorRef.GetKey()
	if doorKey && akActor.GetItemCount(doorKey) > 0
		return true
	endIf
	return false
EndFunction

MiscObject Property TG08SkeletonKey auto
MiscObject Property Lockpick auto
bool Function IsShowLockPickAnim(ObjectReference doorRef, Actor akActor)
	if doorRef.GetLockLevel() != 255
		if akActor.GetItemCount(Lockpick) > 0 || akActor.GetItemCount(TG08SkeletonKey) > 0
			return true
		endIf
	endIf
	return false
EndFunction

;1 : default open door anim
;2 : unlock door anim
;0 : no anim
int Function GetDoorAnimType(ObjectReference doorRef, Actor akActor)
	if !doorRef.IsLocked()
		return 1
	endif
	Key doorKey = doorRef.GetKey()
	if doorRef.GetLockLevel() != 255 && !doorKey
		if akActor.GetItemCount(Lockpick) > 0 || akActor.GetItemCount(TG08SkeletonKey) > 0
			return 2
		endIf
		return 0
	endIf
	if doorKey && akActor.GetItemCount(doorKey) > 0
		return 1
	endIf
	return 0
EndFunction

Function SetEventName(Actor akActor, int animType, bool IsActorSneaking)
	string doorEvent = ""
	if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
		if 1 == animType
			if !IsActorSneaking
				doorEvent = "KNNUnlockDoorStart"
			else
				doorEvent = "KNNUnlockDoorSneakingStart"
			endIf
		elseIf 2 == animType
			if !IsActorSneaking
				doorEvent = "KNNActivateDoorClose"
			else
				doorEvent = "KNNActivateDoorSneakingClose"
			endIf
		elseIf 3 == animType
			if !IsActorSneaking
				doorEvent = "KNNOpenDoorOffsetStanding"
			else
				doorEvent = "KNNOpenDoorOffsetSneaking"
			endIf
		elseIf 4 == animType
			if !IsActorSneaking	
				doorEvent = "KNNCloseDoorOffsetStanding"
			else
				doorEvent = "KNNCloseDoorOffsetSneaking"
			endIf
		else
			if !IsActorSneaking	
				doorEvent = "KNNActivateDoor"
			else
				doorEvent = "KNNActivateDoorSneaking"
			endIf
		endIf
	else
		if 1 == animType
			if !IsActorSneaking
				doorEvent = "KNNUnlockDoorStart_M"
			else
				doorEvent = "KNNUnlockDoorSneakingStart_M"
			endIf
		elseIf 2 == animType
			if !IsActorSneaking
				doorEvent = "KNNActivateDoorClose_M"
			else
				doorEvent = "KNNActivateDoorSneakingClose_M"
			endIf
		elseIf 3 == animType
			if !IsActorSneaking
				doorEvent = "KNNOpenDoorOffsetStanding_M"
			else
				doorEvent = "KNNOpenDoorOffsetSneaking_M"
			endIf
		elseIf 4 == animType
			if !IsActorSneaking	
				doorEvent = "KNNCloseDoorOffsetStanding_M"
			else
				doorEvent = "KNNCloseDoorOffsetSneaking_M"
			endIf
		else
			if !IsActorSneaking	
				doorEvent = "KNNActivateDoor_M"
			else
				doorEvent = "KNNActivateDoorSneaking_M"
			endIf
		endIf
	endIf
	Debug.SendAnimationEvent(akActor, doorEvent)
EndFunction

;Spell Property aaaKNNPlayPerkDoorOpenSpell auto
;Spell Property aaaKNNPlayPerkDoorCloseSpell auto
;Spell Property aaaKNNPlayPerkUnlockDoorSpell auto
;Spell Property aaaKNNPlayPerkDoorOpenOffsetSpell auto
Function ActivateDoor(ObjectReference akTargetRef, Actor akActor, int OpenState)
	if KNNPlugin_Utility.IsTeammateFavor()
		akTargetRef.Activate(akActor)
		return
	endIf
	;float angleZ = akActor.GetHeadingAngle(akTargetRef)
	;if angleZ >= -45.0 && angleZ <= 45.0
	if CanPlayDoorAnim(akTargetRef, akActor)
		if OpenState == 3
			;SetEventName(akActor)
			if CanBeOpenDoor(akTargetRef, akActor)
				PlayOpeningDoor(akTargetRef, akActor)
			else
				if IsShowLockPickAnim(akTargetRef, akActor) && (animCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState() && !KNNPlugin_Utility.IsTorchOut(akActor)
					;KNNPlugin_Utility.RegisterUnlockDoorAnimation(akTargetRef)
					targetRefAlias.ForceRefTo(akTargetRef)
					GoToState("STARTUP")
					;aaaKNNPlayPerkUnlockDoorSpell.Cast(akActor)
					;Debug.SendAnimationEvent(akActor, "idleStop")
					;Utility.Wait(0.1)
					SetEventName(akActor, 1, akActor.IsSneaking())
					;if !akActor.IsSneaking()
					;	Debug.SendAnimationEvent(akActor, unlockStart)
					;else
					;	Debug.SendAnimationEvent(akActor, unlockStartSneak)
					;endIf					
					Utility.wait(1.4)
				endIf
				akTargetRef.Activate(akActor)
			endIf
		elseIf OpenState == 1
			;SetEventName(akActor)
			if !KNNPlugin_Utility.IsTorchOut(akActor)
				;aaaKNNPlayPerkDoorCloseSpell.Cast(akActor)
				(animCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState()
				;Debug.sendAnimationEvent(akActor, "idleStop")
				;Utility.wait(0.1)
				SetEventName(akActor, 2, akActor.IsSneaking())
				;if !akActor.IsSneaking()
				;	Debug.SendAnimationEvent(akActor, closeDoor)
				;else
				;	Debug.SendAnimationEvent(akActor, closeDoorSneak)
				;endIf
				Utility.wait(1.46)
				akTargetRef.Activate(akActor)
				Utility.wait(0.94)
				;Debug.sendAnimationEvent(akActor, "idleStop")
			else
				;aaaKNNPlayPerkDoorOpenOffsetSpell.Cast(akActor)
				(animCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState()
				float[] waitTime = new float[2]
				if !akActor.IsSneaking()
					SetEventName(akActor, 4, false)
					;Debug.SendAnimationEvent(akActor, closeDoorOffsetStand)
					waitTime[0] = 1.2
					waitTime[0] = 1.1
				else
					SetEventName(akActor, 4, true)
					;Debug.SendAnimationEvent(akActor, closeDoorOffsetSneak)
					waitTime[0] = 1.2
					waitTime[0] = 1.25
				endIf
				Utility.wait(waitTime[0])
				akTargetRef.Activate(akActor)
				Utility.wait(waitTime[1])
				Debug.SendAnimationEvent(akActor, "OffsetStop")
				;akActor.DispelSpell(aaaKNNPlayPerkDoorOpenOffsetSpell)
			endIf
			(animCtrl as aaaKNNAnimControlQuest).ReturnCameraState()
		endIf		
	else
		akTargetRef.Activate(akActor)
	endIf
EndFunction

;SimplyKnock発動条件
;!akActor.IsInInterior() && !akActor.IsSneaking() && doorRef.GetLockLevel() != 255 && !doorRef.GetKey()
Function ActivateDoorLoad(ObjectReference akTargetRef, Actor akActor)
	if KNNPlugin_Utility.IsTeammateFavor()
		akTargetRef.Activate(akActor)
		return
	endIf
	;int SimplyKnockIndex = KNNPlugin_Utility.GetModInstalled("SimplyKnock.esp")
	;if 255 != SimplyKnockIndex
	;	if !akActor.IsInInterior() && !akActor.IsSneaking() && akTargetRef.IsLocked() && akTargetRef.GetLockLevel() != 255
	;		return
	;	endIf
	;	akTargetRef.Activate(akActor)
	;	return
	;endIf
	int animType = GetDoorAnimType(akTargetRef, akActor)
	;Debug.Trace("AnimType : " + animType)
	;Debug.Trace("ActivateDoorLoad -> " + akTargetRef + ", animType : " + animType)
	if 1 == animType
		;SetEventName(akActor)
		PlayOpeningDoor(akTargetRef, akActor)
	elseIf 2 == animType
		if 255 != Game.GetModByName("SimplyKnock.esp")
			if !akActor.IsInInterior() && !akActor.IsSneaking()
				return
			endIf
		endIf
		;IsCellLoadedDoor 人の家から出る時に必要。内から出る時はロックが掛かっていても扉を開けられる。これがないとアンロックアニメになる		
		if !KNNPlugin_Utility.IsCellLoadedDoor(akTargetRef)
			;Debug.Trace("IsCellLoadedDoor : false")
			if (animCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState() && !KNNPlugin_Utility.IsTorchOut(akActor)
				;SetEventName(akActor)
				;KNNPlugin_Utility.RegisterUnlockDoorAnimation(akTargetRef)
				targetRefAlias.ForceRefTo(akTargetRef)
				GoToState("STARTUP")
				;aaaKNNPlayPerkUnlockDoorSpell.Cast(akActor)
				;Debug.SendAnimationEvent(akActor, "idleStop")
				;Utility.Wait(0.1)
				SetEventName(akActor, 1, akActor.IsSneaking())
				;if !akActor.IsSneaking()
				;	Debug.SendAnimationEvent(akActor, unlockStart)
				;else
				;	Debug.SendAnimationEvent(akActor, unlockStartSneak)
				;endIf
				Utility.wait(1.4)
			endIf
			akTargetRef.Activate(akActor)
		else
			;Debug.Trace("IsCellLoadedDoor : true")
			;SetEventName(akActor)
			PlayOpeningDoor(akTargetRef, akActor)
		endIf
	else
		akTargetRef.Activate(akActor)
	endIf
EndFunction

Function PlayOpeningDoor(ObjectReference akTargetRef, Actor akActor)
	if !KNNPlugin_Utility.IsTorchOut(akActor)
		;aaaKNNPlayPerkDoorOpenSpell.Cast(akActor)
		(animCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState()
		;Debug.sendAnimationEvent(akActor, "idleStop")
		;Utility.wait(0.1)
		SetEventName(akActor, 0, akActor.IsSneaking())
		;if !akActor.IsSneaking()
		;	Debug.SendAnimationEvent(akActor, openDoor)
		;else
		;	Debug.SendAnimationEvent(akActor, openDoorSneak)
		;endIf
		Utility.wait(1.46)
		akTargetRef.Activate(akActor)
		;Utility.wait(0.94)
		;Debug.sendAnimationEvent(akActor, "idleStop")
	else
		;aaaKNNPlayPerkDoorOpenOffsetSpell.Cast(akActor)
		(animCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState()
		;Debug.sendAnimationEvent(akActor, "idleStop")
		float[] waitTime = new float[2]
		if !akActor.IsSneaking()
			SetEventName(akActor, 3, false)
			;Debug.SendAnimationEvent(akActor, openDoorOffsetStand)
			waitTime[0] = 1.2
			waitTime[0] = 1.1
		else
			SetEventName(akActor, 3, true)
			;Debug.SendAnimationEvent(akActor, openDoorOffsetSneak)
			waitTime[0] = 1.2
			waitTime[0] = 1.25
		endIf
		Utility.wait(waitTime[0])
		akTargetRef.Activate(akActor)
		Utility.wait(waitTime[1])
		Debug.SendAnimationEvent(akActor, "OffsetStop")
		;akActor.DispelSpell(aaaKNNPlayPerkDoorOpenOffsetSpell)
	endIf
	(animCtrl as aaaKNNAnimControlQuest).ReturnCameraState()
EndFunction

;String openStart
;String openStartSneek
;String doorEnd
;String doorSneakEnd
String[] AnimEvent
;String[] AnimTriggerEvent
;String openStartEnd_Done
;String openStartSneakEnd_Done
;String doorEnd_Done
;String doorSneakEnd_Done
State STARTUP
	Event OnBeginState()
		AnimEvent = new String[4]
		;AnimTriggerEvent = new String[3]
		;AnimTriggerEvent[0] = "JumpDown"
		;AnimTriggerEvent[1] = "KNNUnlockDoorStartFinished"
		;AnimTriggerEvent[2] = "KNNUnlockDoorSneakingStartFinished"
		Actor player = Game.GetPlayer()
		RegisterForAnimationEvent(player, "JumpDown")
		;int i = 0
		;while i < AnimTriggerEvent.Length
		;	RegisterForAnimationEvent(player, AnimTriggerEvent[i])
		;	i += 1	
		;endwhile
		RegisterForMenu("Lockpicking Menu")
		if (animCtrl as aaaKNNAnimControlQuest).GetGender(player)		
			;doorEnd_Done = "KNNUnlockDoorEnd_DONE"
			;doorSneakEnd_Done = "KNNUnlockDoorSneakingEnd_DONE"
			;openStartEnd_Done = "KNNUnlockDoorOpenEnd_DONE"
			;openStartSneakEnd_Done = "KNNUnlockDoorOpenSneakingEnd_DONE"
			AnimEvent[0] = "KNNUnlockDoorOpenStart"
			AnimEvent[1] = "KNNUnlockDoorOpenSneakingStart"
			AnimEvent[2] = "KNNUnlockDoorEnd"
			AnimEvent[3] = "KNNUnlockDoorSneakingEnd"
		else
			;doorEnd_Done = "KNNUnlockDoorEnd_M_DONE"
			;doorSneakEnd_Done = "KNNUnlockDoorSneakingEnd_M_DONE"
			;openStartEnd_Done = "KNNUnlockDoorOpenEnd_M_DONE"
			;openStartSneakEnd_Done = "KNNUnlockDoorOpenSneakingEnd_M_DONE"
			AnimEvent[0] = "KNNUnlockDoorOpenStart_M"
			AnimEvent[1] = "KNNUnlockDoorOpenSneakingStart_M"
			AnimEvent[2] = "KNNUnlockDoorEnd_M"
			AnimEvent[3] = "KNNUnlockDoorSneakingEnd_M"
		endIf
	ENdEvent

	Event OnEndState()
		;Debug.Trace("OnEndState")
		targetRefAlias.Clear()
		;Actor player = Game.GetPlayer()
		UnregisterForAnimationEvent(Game.GetPlayer(), "JumpDown")
		;int i = 0
		;while i < AnimTriggerEvent.Length
		;	UnregisterForAnimationEvent(player, AnimTriggerEvent[i])
		;	i += 1	
		;endwhile
		;UnregisterForAllControls()
		UnregisterForAllMenus()
	EndEvent

	Event OnAnimationEvent(ObjectReference akSource, string asEventName)
		;if asEventName == "KNNUnlockDoorStartFinished" || asEventName == "KNNUnlockDoorSneakingStartFinished"
			;Debug.Notification("OnAnimationEvent : " + asEventName)
			;UnregisterForAnimationEvent(akSource, "KNNUnlockDoorStartFinished")
			;UnregisterForAnimationEvent(akSource, "KNNUnlockDoorSneakingStartFinished")
			;RegisterForControl("Forward")
			;RegisterForControl("Back")
			;RegisterForControl("Strafe Left")
			;RegisterForControl("Strafe Right")
			;RegisterForControl("Move")
		if asEventName == "JumpDown"
			;Debug.Notification("OnAnimationEvent : " + asEventName)
			GoToState("")
		endIf
	EndEvent

	Event OnMenuClose(String MenuName)
		if "Lockpicking Menu"
			Actor player = Game.GetPlayer()
			bool IslockDoor = false
			ObjectReference ref = targetRefAlias.GetReference()
			if ref && ref.GetBaseObject() as Door
				IslockDoor = ref.IsLocked()
			endIf
			GoToState("")
			if IslockDoor
				if !player.IsSneaking()
					Debug.SendAnimationEvent(player, AnimEvent[2])
				else
					Debug.SendAnimationEvent(player, AnimEvent[3])
				endIf
			else
				if !player.IsSneaking()
					Debug.SendAnimationEvent(player, AnimEvent[0])
				else
					Debug.SendAnimationEvent(player, AnimEvent[1])
				endIf
			endIf
		endIf
	EndEvent

	;Event OnControlDown(string control)
		;if control == "Strafe Left" || control == "Strafe Right" || control == "Forward" || control == "Back" || control == "Move"
			;Debug.Notification("OnControlDown : " + control)
		;	Actor player = Game.GetPlayer()
		;	UnregisterEvent(player)
		;	Debug.SendAnimationEvent(player, "IdleForceDefaultState")
		;EndIf
	;EndEvent
EndState