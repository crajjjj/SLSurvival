Scriptname aaaKNNPerkChestCrouchingBaseSneakingQL extends activemagiceffect

;aaaKNNAnimControlQuest Property POV auto
Quest Property animCtrl auto
bool Property IsInstant auto
bool IsActivate = false
bool IsAnimFinished = false
bool IsAnimEnd = false
bool IsUpdateCrosshair = false
Actor thisActor
String crouchingStart
String crouchingEnd
String crouchingEnd_Done
String crouchingLootStartIns
String crouchingLootInsEnd_Done
String crouchingLootStart
String crouchingLootRestart
String crouchingLootEnd
String crouchingLootEnd_Done

Function RegisterAnimEvent(Actor akTarget)
	RegisterForAnimationEvent(akTarget, "JumpDown")
	RegisterForAnimationEvent(akTarget, "KNNOpenChestCrouchingSneakingQLStartFinished")
	RegisterForAnimationEvent(akTarget, "KNNOpenChestCrouchSneakQLLootNPCFinished")
	if (animCtrl as aaaKNNAnimControlQuest).GetGender(akTarget)
		crouchingStart = "KNNOpenChestCrouchingSneakingQLStart"
		crouchingEnd = "KNNOpenChestCrouchingSneakingQLEnd"
		crouchingLootStartIns = "KNNOpenChestCrouchSneakQLLootNPCInstantStart"
		crouchingLootStart = "KNNOpenChestCrouchSneakQLLootNPC"
		crouchingLootRestart = "KNNOpenChestCrouchSneakQLLootNPC_REENTER"
		crouchingLootEnd = "KNNOpenChestCrouchSneakQLLootNPCEnd"

		crouchingEnd_Done = "KNNOpenChestCrouchingSneakingQLEnd_DONE"
		crouchingLootEnd_Done = "KNNOpenChestCrouchSneakQLLootNPCEnd_DONE"
		crouchingLootInsEnd_Done = "KNNOpenChestCrouchSneakQLLootNPCInstantEnd_DONE"
	else
		crouchingStart = "KNNOpenChestCrouchingSneakingQLStart_M"
		crouchingEnd = "KNNOpenChestCrouchingSneakingQLEnd_M"
		crouchingLootStartIns = "KNNOpenChestCrouchSneakQLLootNPCInstantStart_M"
		crouchingLootStart = "KNNOpenChestCrouchSneakQLLootNPC_M"
		crouchingLootRestart = "KNNOpenChestCrouchSneakQLLootNPC_M_REENTER"
		crouchingLootEnd = "KNNOpenChestCrouchSneakQLLootNPCEnd_M"
		
		crouchingEnd_Done = "KNNOpenChestCrouchingSneakingQLEnd_M_DONE"
		crouchingLootEnd_Done = "KNNOpenChestCrouchSneakQLLootNPCEnd_M_DONE"
		crouchingLootInsEnd_Done = "KNNOpenChestCrouchSneakQLLootNPCInstantEnd_M_DONE"
	endIf
	RegisterForAnimationEvent(akTarget, crouchingEnd_Done)
	RegisterForAnimationEvent(akTarget, crouchingLootEnd_Done)
	RegisterForAnimationEvent(akTarget, crouchingLootInsEnd_Done)
EndFunction

Event OnEffectStart(Actor akTarget, Actor akCaster)
	GoToState("")
	thisActor = akTarget
	IsAnimFinished = false
	IsActivate = false
	IsAnimEnd = false
	IsUpdateCrosshair = false
	RegisterAnimEvent(akTarget)
	(animCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState()
	if !IsInstant
		Debug.SendAnimationEvent(akTarget, crouchingStart)
	else
		Debug.SendAnimationEvent(akTarget, crouchingLootStartIns)
	endIf
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	;Debug.Notification("OnEffectFinish")
	if !IsAnimFinished
		if !IsActivate
			Debug.SendAnimationEvent(akTarget, crouchingEnd)
		else
			Debug.SendAnimationEvent(akTarget, crouchingLootEnd)
		endIf
	else
		if IsUpdateCrosshair
			KNNPlugin_Utility.ForceCrosshairUpdate()
		endIf
	endIf
	(animCtrl as aaaKNNAnimControlQuest).ReturnCameraState()
EndEvent

State AnimControl
	Event OnControlDown(string control)
		if control == "Activate"
			GoToState("")
			UnregisterForAllControls()
			if !IsActivate
				Debug.SendAnimationEvent(thisActor, crouchingLootStart)
			else
				Debug.SendAnimationEvent(thisActor, crouchingLootRestart)
			endIf
		elseIf control == "Forward" || control == "Back" || control == "Strafe Left" || control == "Strafe Right" || control == "Move"
			GoToState("")
			UnregisterForAllControls()
			Debug.SendAnimationEvent(thisActor, "IdleForceDefaultState")
			self.Dispel()
		EndIf
	EndEvent

	Event OnEndChestAnim(Actor akTarget, bool IsCrosshairUpdate)
		;Debug.Notification("OnEndChestAnim")
		IsUpdateCrosshair = IsCrosshairUpdate
		if !IsActivate
			Debug.SendAnimationEvent(akTarget, crouchingEnd)
		else
			Debug.SendAnimationEvent(akTarget, crouchingLootEnd)
		endIf
	EndEvent
EndState

Event OnEndChestAnim(Actor akTarget, bool IsCrosshairUpdate)
	;Debug.Notification("OnEndChestAnim : Empty State")
	IsUpdateCrosshair = IsCrosshairUpdate
	IsAnimEnd = true
EndEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	if GetTargetActor() != akSource
		return
	endIf
	if asEventName == "KNNOpenChestCrouchingSneakingQLStartFinished"
		IsActivate = false
		RegisterForControl("Activate")
		RegisterForControl("Forward")
		RegisterForControl("Back")
		RegisterForControl("Strafe Left")
		RegisterForControl("Strafe Right")
		RegisterForControl("Move")
		if IsAnimEnd
			Debug.SendAnimationEvent(akSource, crouchingEnd)
			return
		endIf
		GoToState("AnimControl")
	elseIf asEventName == "KNNOpenChestCrouchSneakQLLootNPCFinished"
		;Debug.Notification("OnAnimationEvent : " + asEventName)
		IsActivate = true
		RegisterForControl("Activate")
		RegisterForControl("Forward")
		RegisterForControl("Back")
		RegisterForControl("Strafe Left")
		RegisterForControl("Strafe Right")
		RegisterForControl("Move")
		if IsAnimEnd && IsActivate
			Debug.SendAnimationEvent(akSource, crouchingLootEnd)
			return
		endIf
		GoToState("AnimControl")
	elseIf asEventName == crouchingLootInsEnd_Done || asEventName == "JumpDown"
		GoToState("")
		IsAnimFinished = true
		self.Dispel()
	elseIf asEventName == crouchingLootEnd_Done || asEventName == crouchingEnd_Done
		GoToState("")
		UnregisterForAllControls()
		IsAnimFinished = true
		;Utility.Wait(1.0)
		;if !thisActor.GetAnimationVariableBool("bAnimationDriven")
			self.Dispel()
		;else
		;	RegisterForSingleUpdate(1.0)
		;endIf
	endIf
EndEvent

;Event OnUpdate()
;	if thisActor.GetAnimationVariableBool("bAnimationDriven")
;		Debug.SendAnimationEvent(thisActor, "IdleForceDefaultState")
;		RegisterForSingleUpdate(1.0)
;		return
;	endIf
;	self.Dispel()
;EndEvent