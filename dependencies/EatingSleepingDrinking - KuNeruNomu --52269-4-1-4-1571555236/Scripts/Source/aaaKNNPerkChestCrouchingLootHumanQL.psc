Scriptname aaaKNNPerkChestCrouchingLootHumanQL extends activemagiceffect

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
String crouchingHumanStart
String crouchingHumanRestart
String crouchingHumanEnd
String crouchingHumanEnd_Done

Function RegisterAnimEvent(Actor akTarget)
	RegisterForAnimationEvent(akTarget, "JumpDown")
	RegisterForAnimationEvent(akTarget, "KNNOpenChestCrouchingQLStartFinished")
	RegisterForAnimationEvent(akTarget, "KNNOpenChestCrouchingQLLootHuman_1stFinished")
	if (animCtrl as aaaKNNAnimControlQuest).GetGender(akTarget)
		crouchingStart = "KNNOpenChestCrouchingQLStart"
		crouchingLootStartIns = "KNNOpenChestCrouchingQLLootNPCStartInstant"
		crouchingEnd = "KNNOpenChestCrouchingQLEnd"
		crouchingHumanEnd = "KNNOpenChestCrouchingQLLootHumanEnd"
		crouchingHumanStart = "KNNOpenChestCrouchingQLLootHuman_1st"
		crouchingHumanRestart = "KNNOpenChestCrouchingQLLootHuman_1st_REENTER"

		crouchingEnd_Done = "KNNOpenChestCrouchingQLEnd_DONE"
		crouchingHumanEnd_Done = "KNNOpenChestCrouchingQLLootHumanEnd_DONE"
		crouchingLootInsEnd_Done = "KNNOpenChestCrouchingQLLootNPCInstantEnd_DONE"
	else
		crouchingStart = "KNNOpenChestCrouchingQLStart_M"
		crouchingLootStartIns = "KNNOpenChestCrouchingQLLootNPCStartInstant_M"
		crouchingEnd = "KNNOpenChestCrouchingQLEnd_M"
		crouchingHumanEnd = "KNNOpenChestCrouchingQLLootHumanEnd_M"
		crouchingHumanStart = "KNNOpenChestCrouchingQLLootHuman_1st_M"
		crouchingHumanRestart = "KNNOpenChestCrouchingQLLootHuman_1st_M_REENTER"

		crouchingEnd_Done = "KNNOpenChestCrouchingQLEnd_M_DONE"
		crouchingHumanEnd_Done = "KNNOpenChestCrouchingQLLootHumanEnd_M_DONE"
		crouchingLootInsEnd_Done = "KNNOpenChestCrouchingQLLootNPCInstantEnd_M_DONE"
	endIf
	RegisterForAnimationEvent(akTarget, crouchingEnd_Done)
	RegisterForAnimationEvent(akTarget, crouchingHumanEnd_Done)
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
			Debug.SendAnimationEvent(akTarget, crouchingHumanEnd)
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
				Debug.SendAnimationEvent(thisActor, crouchingHumanStart)
			else
				Debug.SendAnimationEvent(thisActor, crouchingHumanRestart)
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
			Debug.SendAnimationEvent(akTarget, crouchingHumanEnd)
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
	if asEventName == "KNNOpenChestCrouchingQLStartFinished"
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
	elseIf asEventName == "KNNOpenChestCrouchingQLLootHuman_1stFinished"
		;Debug.Notification("OnAnimationEvent : " + asEventName)
		IsActivate = true
		RegisterForControl("Activate")
		RegisterForControl("Forward")
		RegisterForControl("Back")
		RegisterForControl("Strafe Left")
		RegisterForControl("Strafe Right")
		RegisterForControl("Move")
		if IsAnimEnd && IsActivate
			Debug.SendAnimationEvent(akSource, crouchingHumanEnd)
			return
		endIf
		GoToState("AnimControl")
	elseIf asEventName == crouchingLootInsEnd_Done || asEventName == "JumpDown"
		;Debug.Notification("OnAnimationEvent : " + asEventName)
		GoToState("")
		IsAnimFinished = true
		self.Dispel()
	elseIf asEventName == crouchingHumanEnd_Done || asEventName == crouchingEnd_Done
		GoToState("")
		UnregisterForAllControls()
		IsAnimFinished = true
		Utility.Wait(0.5)
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