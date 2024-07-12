Scriptname aaaKNNPerkChestStandingQL extends activemagiceffect

;aaaKNNAnimControlQuest Property POV auto
Quest Property animCtrl auto
bool Property IsInstant auto
bool IsActivate = false
bool IsAnimFinished = false
bool IsAnimEnd = false
bool IsUpdateCrosshair = false
Actor thisActor
string standingStart
string standingEnd
string standingEnd_Done
string standingStartIns
string standingLootInsEnd_Done
string standingLootStart
string standingLootRestart
string standingLootEnd
string standingLootEnd_Done

Function RegisterAnimEvent(Actor akTarget)
	;Debug.trace("aaaKNNPerkChestStandingQL")
	RegisterForAnimationEvent(akTarget, "JumpDown")
	RegisterForAnimationEvent(akTarget, "KNNOpenChestStandingQLStartFinished")
	RegisterForAnimationEvent(akTarget, "KNNOpenChestStandingLootQLStartFinished")
	if (animCtrl as aaaKNNAnimControlQuest).GetGender(akTarget)
		standingStart = "KNNOpenChestStandingQLStart"
		standingStartIns = "KNNOpenChestStandQLInstantStart"
		standingEnd = "KNNOpenChestStandingQLEnd"
		standingLootEnd = "KNNOpenChestStandingLootQLEnd"
		standingLootStart = "KNNOpenChestStandingLootQLStart"
		standingLootRestart = "KNNOpenChestStandingLootQLStart_REENTER"

		standingEnd_Done = "KNNOpenChestStandingQLEnd_DONE"
		standingLootEnd_Done = "KNNOpenChestStandingLootQLEnd_DONE"
		standingLootInsEnd_Done = "KNNOpenChestStandQLInstantEnd_DONE"
	else
		standingStart = "KNNOpenChestStandingQLStart_M"
		standingStartIns = "KNNOpenChestStandQLInstantStart_M"
		standingEnd = "KNNOpenChestStandingQLEnd_M"
		standingLootEnd = "KNNOpenChestStandingLootQLEnd_M"
		standingLootStart = "KNNOpenChestStandingLootQLStart_M"
		standingLootRestart = "KNNOpenChestStandingLootQLStart_M_REENTER"

		standingEnd_Done = "KNNOpenChestStandingQLEnd_M_DONE"
		standingLootEnd_Done = "KNNOpenChestStandingLootQLEnd_M_DONE"
		standingLootInsEnd_Done = "KNNOpenChestStandQLInstantEnd_M_DONE"
	endIf
	RegisterForAnimationEvent(akTarget, standingEnd_Done)
	RegisterForAnimationEvent(akTarget, standingLootEnd_Done)
	RegisterForAnimationEvent(akTarget, standingLootInsEnd_Done)
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
		Debug.SendAnimationEvent(akTarget, standingStart)
	else
		Debug.SendAnimationEvent(akTarget, standingStartIns)
	endIf
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	;Debug.Notification("OnEffectFinish")
	if !IsAnimFinished
		if !IsActivate
			Debug.SendAnimationEvent(akTarget, standingEnd)
		else
			Debug.SendAnimationEvent(akTarget, standingLootEnd)
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
				Debug.SendAnimationEvent(thisActor, standingLootStart)
			else
				Debug.SendAnimationEvent(thisActor, standingLootRestart)
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
			Debug.SendAnimationEvent(akTarget, standingEnd)
		else
			Debug.SendAnimationEvent(akTarget, standingLootEnd)
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
	if asEventName == "KNNOpenChestStandingQLStartFinished"
		;Debug.Notification("OnAnimationEvent" + asEventName)
		IsActivate = false
		RegisterForControl("Activate")
		RegisterForControl("Forward")
		RegisterForControl("Back")
		RegisterForControl("Strafe Left")
		RegisterForControl("Strafe Right")
		RegisterForControl("Move")
		if IsAnimEnd && thisActor
			Debug.SendAnimationEvent(thisActor, standingEnd)
			return
		endIf
		GoToState("AnimControl")
	elseIf asEventName == "KNNOpenChestStandingLootQLStartFinished"
		;Debug.Notification("OnAnimationEvent : " + asEventName)
		IsActivate = true
		RegisterForControl("Activate")
		RegisterForControl("Forward")
		RegisterForControl("Back")
		RegisterForControl("Strafe Left")
		RegisterForControl("Strafe Right")
		RegisterForControl("Move")
		if IsAnimEnd && IsActivate
			Debug.SendAnimationEvent(akSource, standingLootEnd)
			return
		endIf
		GoToState("AnimControl")
	elseIf asEventName == standingLootInsEnd_Done  || asEventName == "JumpDown"
		GoToState("")
		IsAnimFinished = true
		self.Dispel()
	elseIf asEventName == standingEnd_Done || asEventName == standingLootEnd_Done
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