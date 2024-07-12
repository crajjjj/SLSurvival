Scriptname aaaKNNPerkChestHunchSneakQL extends activemagiceffect

;aaaKNNAnimControlQuest Property POV auto
Quest Property animCtrl auto
bool Property IsInstant auto
bool IsActivate = false
bool IsAnimFinished = false
bool IsAnimEnd = false
bool IsUpdateCrosshair = false
Actor thisActor
string hunchingStart
string hunchingEnd
string hunchingEnd_Done
string hunchingStartIns
string hunchingLootInsEnd_Done
string hunchingLootStart
string hunchingLootRestart
string hunchingLootEnd
string hunchingLootEnd_Done

Function RegisterAnimEvent(Actor akTarget)
	RegisterForAnimationEvent(akTarget, "JumpDown")
	RegisterForAnimationEvent(akTarget, "KNNOpenChestHunchSneakQLStartFinished")
	RegisterForAnimationEvent(akTarget, "KNNOpenChestHunchSneakQLLootFinished")
	if (animCtrl as aaaKNNAnimControlQuest).GetGender(akTarget)
		hunchingStart = "KNNOpenChestHunchSneakQLStart"
		hunchingStartIns = "KNNOpenChestHunchSneakQLInstantStart"
		hunchingEnd = "KNNOpenChestHunchSneakQLEnd"
		hunchingLootEnd = "KNNOpenChestHunchSneakQLLootEnd"
		hunchingLootStart = "KNNOpenChestHunchSneakQLLoot"
		hunchingLootRestart = "KNNOpenChestHunchSneakQLLoot_REENTER"

		hunchingEnd_Done = "KNNOpenChestHunchSneakQLEnd_DONE"
		hunchingLootEnd_Done = "KNNOpenChestHunchSneakQLLootEnd_DONE"
		hunchingLootInsEnd_Done = "KNNOpenChestHunchSneakQLLootInstantEnd_DONE"
	else
		hunchingStart = "KNNOpenChestHunchSneakQLStart_M"
		hunchingStartIns = "KNNOpenChestHunchSneakQLInstantStart_M"
		hunchingEnd = "KNNOpenChestHunchSneakQLEnd_M"
		hunchingLootEnd = "KNNOpenChestHunchSneakQLLootEnd_M"
		hunchingLootStart = "KNNOpenChestHunchSneakQLLoot_M"
		hunchingLootRestart = "KNNOpenChestHunchSneakQLLoot_M_REENTER"

		hunchingEnd_Done = "KNNOpenChestHunchSneakQLEnd_M_DONE"
		hunchingLootEnd_Done = "KNNOpenChestHunchSneakQLLootEnd_M_DONE"
		hunchingLootInsEnd_Done = "KNNOpenChestHunchSneakQLLootInstantEnd_M_DONE"
	endIf
	RegisterForAnimationEvent(akTarget, hunchingEnd_Done)
	RegisterForAnimationEvent(akTarget, hunchingLootEnd_Done)
	RegisterForAnimationEvent(akTarget, hunchingLootInsEnd_Done)
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
		Debug.SendAnimationEvent(akTarget, hunchingStart)
	else
		Debug.SendAnimationEvent(akTarget, hunchingStartIns)
	endIf
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	;Debug.Notification("OnEffectFinish")
	if !IsAnimFinished
		if !IsActivate
			Debug.SendAnimationEvent(akTarget, hunchingEnd)
		else
			Debug.SendAnimationEvent(akTarget, hunchingLootEnd)
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
				Debug.SendAnimationEvent(thisActor, hunchingLootStart)
			else
				Debug.SendAnimationEvent(thisActor, hunchingLootRestart)
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
			Debug.SendAnimationEvent(akTarget, hunchingEnd)
		else
			Debug.SendAnimationEvent(akTarget, hunchingLootEnd)
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
	if asEventName == "KNNOpenChestHunchSneakQLStartFinished"
		;Debug.Notification("OnAnimationEvent : " + asEventName)
		IsActivate = false
		RegisterForControl("Activate")
		RegisterForControl("Forward")
		RegisterForControl("Back")
		RegisterForControl("Strafe Left")
		RegisterForControl("Strafe Right")
		RegisterForControl("Move")
		if IsAnimEnd
			Debug.SendAnimationEvent(thisActor, hunchingEnd)
			return
		endIf
		GoToState("AnimControl")
	elseIf asEventName == "KNNOpenChestHunchSneakQLLootFinished"
		;Debug.Notification("OnAnimationEvent : " + asEventName)
		IsActivate = true
		RegisterForControl("Activate")
		RegisterForControl("Forward")
		RegisterForControl("Back")
		RegisterForControl("Strafe Left")
		RegisterForControl("Strafe Right")
		RegisterForControl("Move")
		if IsAnimEnd && IsActivate
			Debug.SendAnimationEvent(thisActor, hunchingLootEnd)
			return
		endIf
		GoToState("AnimControl")
	elseIf asEventName == hunchingLootInsEnd_Done || asEventName == "JumpDown"
		;Debug.Notification("OnAnimationEvent : " + asEventName)
		GoToState("")
		IsAnimFinished = true
		self.Dispel()
	elseIf asEventName == hunchingEnd_Done || asEventName == hunchingLootEnd_Done
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