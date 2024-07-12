Scriptname aaaKNNPerkChestCrouchSneakACTIChestQL extends activemagiceffect

;aaaKNNAnimControlQuest Property POV auto
Quest Property animCtrl auto
bool Property IsInstant auto 
bool IsActivate = false
bool IsAnimFinished = false
bool IsAnimEnd = false
bool IsUpdateCrosshair = false
Actor thisActor
string crouchingStart
string crouchingEnd
string crouchingEnd_Done
string crouchingLootStartIns
string crouchingLootInsEnd_Done
string crouchingActiStart
string crouchingActiEnd
string crouchingActiEnd_Done

Function RegisterAnimEvent(Actor akTarget)
	RegisterForAnimationEvent(akTarget, "JumpDown")
	RegisterForAnimationEvent(akTarget, "KNNOpenChestCrouchingSneakingQLStartFinished")
	RegisterForAnimationEvent(akTarget, "KNNOpenChestCrouchingSneakingQLACTIChestFinished")
	if (animCtrl as aaaKNNAnimControlQuest).GetGender(akTarget)
		crouchingStart = "KNNOpenChestCrouchingSneakingQLStart"
		crouchingEnd = "KNNOpenChestCrouchingSneakingQLEnd"
		crouchingLootStartIns = "KNNOpenChestCrouchSneakQLLootNPCInstantStart"
		crouchingActiStart = "KNNOpenChestCrouchingSneakingQLACTIChest"
		crouchingActiEnd = "KNNOpenChestCrouchingSneakingQLACTIChestEnd"

		crouchingEnd_Done = "KNNOpenChestCrouchingSneakingQLEnd_DONE"
		crouchingActiEnd_Done = "KNNOpenChestCrouchingSneakingQLACTIChestEnd_DONE"
		crouchingLootInsEnd_Done = "KNNOpenChestCrouchSneakQLLootNPCInstantEnd_DONE"
	else
		crouchingStart = "KNNOpenChestCrouchingSneakingQLStart_M"
		crouchingEnd = "KNNOpenChestCrouchingSneakingQLEnd_M"
		crouchingLootStartIns = "KNNOpenChestCrouchSneakQLLootNPCInstantStart_M"
		crouchingActiStart = "KNNOpenChestCrouchingSneakingQLACTIChest_M"
		crouchingActiEnd = "KNNOpenChestCrouchingSneakingQLACTIChestEnd_M"

		crouchingEnd_Done = "KNNOpenChestCrouchingSneakingQLEnd_M_DONE"
		crouchingActiEnd_Done = "KNNOpenChestCrouchingSneakingQLACTIChestEnd_M_DONE"
		crouchingLootInsEnd_Done = "KNNOpenChestCrouchSneakQLLootNPCInstantEnd_M_DONE"
	endIf
	RegisterForAnimationEvent(akTarget, crouchingEnd_Done)
	RegisterForAnimationEvent(akTarget, crouchingActiEnd_Done)
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
			Debug.SendAnimationEvent(akTarget, crouchingActiEnd)
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
			Debug.SendAnimationEvent(thisActor, crouchingActiStart)
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
			Debug.SendAnimationEvent(akTarget, crouchingActiEnd)
		endIf
	EndEvent
EndState

Event OnEndChestAnim(Actor akTarget, bool IsCrosshairUpdate)
	IsUpdateCrosshair = IsCrosshairUpdate
	IsAnimEnd = true
EndEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	if GetTargetActor() != akSource
		return
	endIf
	if asEventName == "KNNOpenChestCrouchingSneakingQLStartFinished"
		;Debug.Notification("OnAnimationEvent : " + asEventName)
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
	elseIf asEventName == "KNNOpenChestCrouchingSneakingQLACTIChestFinished"
		;Debug.Notification("OnAnimationEvent : " + asEventName)
		IsActivate = true
		RegisterForControl("Forward")
		RegisterForControl("Back")
		RegisterForControl("Strafe Left")
		RegisterForControl("Strafe Right")
		RegisterForControl("Move")
		if IsAnimEnd && IsActivate
			Debug.SendAnimationEvent(akSource, crouchingActiEnd)
			return
		endIf
		GoToState("AnimControl")
	elseIf asEventName == crouchingLootInsEnd_Done || asEventName == "JumpDown"
		;Debug.Notification("OnAnimationEvent : " + asEventName)
		GoToState("")
		IsAnimFinished = true
		self.Dispel()
	elseIf asEventName == crouchingActiEnd_Done || asEventName == crouchingEnd_Done
		GoToState("")
		UnregisterForAllControls()
		IsAnimFinished = true
		Utility.Wait(1.0)
		if !thisActor.GetAnimationVariableBool("bAnimationDriven")
			self.Dispel()
		else
			RegisterForSingleUpdate(1.0)
		endIf
	endIf
EndEvent

Event OnUpdate()
	if thisActor.GetAnimationVariableBool("bAnimationDriven")
		Debug.SendAnimationEvent(thisActor, "IdleForceDefaultState")
		RegisterForSingleUpdate(1.0)
		return
	endIf
	self.Dispel()
EndEvent