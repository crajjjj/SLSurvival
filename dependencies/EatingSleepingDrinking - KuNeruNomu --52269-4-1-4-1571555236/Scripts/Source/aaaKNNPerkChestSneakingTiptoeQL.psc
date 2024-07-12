Scriptname aaaKNNPerkChestSneakingTiptoeQL extends activemagiceffect

;aaaKNNAnimControlQuest Property POV auto
Quest Property animCtrl auto
bool Property IsInstant auto
bool IsAnimFinished = false
bool IsAnimEnd = false
bool IsUpdateCrosshair = false
Actor thisActor
string tipToeStart
string tipToeEnd
string tipToeEnd_Done
string tipToeStartIns
string tipToeLootInsEnd_Done

Function RegisterAnimEvent(Actor akTarget)
	RegisterForAnimationEvent(akTarget, "JumpDown")
	RegisterForAnimationEvent(akTarget, "KNNOpenChestSneakTiptoeQLStartFinished")
	if (animCtrl as aaaKNNAnimControlQuest).GetGender(akTarget)
		tipToeStart = "KNNOpenChestSneakTiptoeQLStart"
		tipToeStartIns = "KNNOpenChestSneakTiptoeQLInstantStart"
		tipToeEnd = "KNNOpenChestSneakTiptoeQLEnd"

		tipToeEnd_Done = "KNNOpenChestSneakTiptoeQLEnd_DONE"
		tipToeLootInsEnd_Done = "KNNOpenChestSneakTiptoeQLInstantEnd_DONE"
	else
		tipToeStart = "KNNOpenChestSneakTiptoeQLStart_M"
		tipToeStartIns = "KNNOpenChestSneakTiptoeQLInstantStart_M"
		tipToeEnd = "KNNOpenChestSneakTiptoeQLEnd_M"

		tipToeEnd_Done = "KNNOpenChestSneakTiptoeQLEnd_M_DONE"
		tipToeLootInsEnd_Done = "KNNOpenChestSneakTiptoeQLInstantEnd_M_DONE"
	endIf
	RegisterForAnimationEvent(akTarget, tipToeEnd_Done)
	RegisterForAnimationEvent(akTarget, tipToeLootInsEnd_Done)
EndFunction

Event OnEffectStart(Actor akTarget, Actor akCaster)
	GoToState("")
	thisActor = akTarget
	IsAnimFinished = false
	IsAnimEnd = false
	IsUpdateCrosshair = false
	RegisterAnimEvent(akTarget)
	(animCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState()
	if !IsInstant
		Debug.SendAnimationEvent(akTarget, tipToeStart)
	else
		Debug.SendAnimationEvent(akTarget, tipToeStartIns)
	endIf
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	;Debug.Notification("OnEffectFinish")
	if !IsAnimFinished
		Debug.SendAnimationEvent(akTarget, tipToeEnd)
	else
		if IsUpdateCrosshair
			KNNPlugin_Utility.ForceCrosshairUpdate()
		endIf
	endIf
	(animCtrl as aaaKNNAnimControlQuest).ReturnCameraState()
EndEvent

State AnimControl
	Event OnControlDown(string control)
		If control == "Forward" || control == "Back" || control == "Strafe Left" || control == "Strafe Right" || control == "Move"
			GoToState("")
			UnregisterForAllControls()
			Debug.SendAnimationEvent(thisActor, "IdleForceDefaultState")
			self.Dispel()
		EndIf
	EndEvent

	Event OnEndChestAnim(Actor akTarget, bool IsCrosshairUpdate)
		;Debug.Notification("OnEndChestAnim")
		IsUpdateCrosshair = IsCrosshairUpdate
		Debug.SendAnimationEvent(akTarget, tipToeEnd)
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
	if asEventName == "KNNOpenChestSneakTiptoeQLStartFinished"
		;Debug.Notification("OnAnimationEvent : " + asEventName)
		RegisterForControl("Forward")
		RegisterForControl("Back")
		RegisterForControl("Strafe Left")
		RegisterForControl("Strafe Right")
		RegisterForControl("Move")
		if IsAnimEnd
			Debug.SendAnimationEvent(akSource, tipToeEnd)
			return
		endIf
		GoToState("AnimControl")
	elseIf asEventName == tipToeLootInsEnd_Done || asEventName == "JumpDown"
		GoToState("")
		IsAnimFinished = true
		self.Dispel()
	elseIf asEventName == tipToeEnd_Done
		GoToState("")
		UnregisterForAllControls()
		IsAnimFinished = true
		Utility.Wait(1.0)
		if !thisActor.GetAnimationVariableBool("bAnimationDriven")
			;Debug.Notification(asEventName + " : Dispel")
			self.Dispel()
		else
			;Debug.Notification(asEventName + " : RegisterForSingleUpdate")
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