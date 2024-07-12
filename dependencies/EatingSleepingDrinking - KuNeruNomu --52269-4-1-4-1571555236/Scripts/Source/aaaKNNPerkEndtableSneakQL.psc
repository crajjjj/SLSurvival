Scriptname aaaKNNPerkEndtableSneakQL extends activemagiceffect

;aaaKNNAnimControlQuest Property POV auto
Quest Property animCtrl auto
bool Property IsInstant auto 
bool IsActivate = false
bool IsAnimFinished = false
bool IsAnimEnd = false
bool IsUpdateCrosshair = false
Actor thisActor
string containerStart
string containerEnd
string containerEnd_Done
string containerStartIns
string containerLootInsEnd_Done
string containerLootStart
string containerLootEnd
string containerLootEnd_Done

Function RegisterAnimEvent(Actor akTarget)
	RegisterForAnimationEvent(akTarget, "JumpDown")
	RegisterForAnimationEvent(akTarget, "KNNOpenEndtableSneakQLStartFinished")
	RegisterForAnimationEvent(akTarget, "KNNOpenEndtableSneakQLActivateFinished")
	if (animCtrl as aaaKNNAnimControlQuest).GetGender(akTarget)
		containerStart = "KNNOpenEndtableSneakQLStart"
		containerStartIns = "KNNOpenEndtableSneakQLInstantStart"
		containerEnd = "KNNOpenEndtableSneakQLEnd"
		containerLootEnd = "KNNOpenEndtableSneakQLActivateEnd"
		containerLootStart = "KNNOpenEndtableSneakQLActivate"

		containerEnd_Done = "KNNOpenEndtableSneakQLEnd_DONE"
		containerLootEnd_Done = "KNNOpenEndtableSneakQLActivateEnd_DONE"
		containerLootInsEnd_Done = "KNNOpenEndtableSneakQLActivateInstantEnd_DONE"
	else
		containerStart = "KNNOpenEndtableSneakQLStart_M"
		containerStartIns = "KNNOpenEndtableSneakQLInstantStart_M"
		containerEnd = "KNNOpenEndtableSneakQLEnd_M"
		containerLootEnd = "KNNOpenEndtableSneakQLActivateEnd_M"
		containerLootStart = "KNNOpenEndtableSneakQLActivate_M"

		containerEnd_Done = "KNNOpenEndtableSneakQLEnd_M_DONE"
		containerLootEnd_Done = "KNNOpenEndtableSneakQLActivateEnd_M_DONE"
		containerLootInsEnd_Done = "KNNOpenEndtableSneakQLActivateInstantEnd_M_DONE"
	endIf
	RegisterForAnimationEvent(akTarget, containerEnd_Done)
	RegisterForAnimationEvent(akTarget, containerLootEnd_Done)
	RegisterForAnimationEvent(akTarget, containerLootInsEnd_Done)
EndFunction

Event OnEffectStart(Actor akTarget, Actor akCaster)
	;Debug.Notification("OpenEndtableSneak")
	GoToState("")
	thisActor = akTarget
	IsAnimFinished = false
	IsActivate = false
	IsAnimEnd = false
	IsUpdateCrosshair = false
	RegisterAnimEvent(akTarget)
	(animCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState()
	if !IsInstant
		Debug.SendAnimationEvent(akTarget, containerStart)
	else
		Debug.SendAnimationEvent(akTarget, containerStartIns)
	endIf
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	;Debug.Notification("OnEffectFinish")
	if !IsAnimFinished
		if !IsActivate
			Debug.SendAnimationEvent(akTarget, containerEnd)
		else
			Debug.SendAnimationEvent(akTarget, containerLootEnd)
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
			Debug.SendAnimationEvent(thisActor, containerLootStart)
		elseIf control == "Forward" || control == "Back" || control == "Strafe Left" || control == "Strafe Right" || control == "Move"
			GoToState("")
			Debug.SendAnimationEvent(thisActor, "IdleForceDefaultState")
			self.Dispel()
		EndIf
	EndEvent

	Event OnEndChestAnim(Actor akTarget, bool IsCrosshairUpdate)
		;Debug.Notification("OnEndChestAnim")
		IsUpdateCrosshair = IsCrosshairUpdate
		if !IsActivate
			Debug.SendAnimationEvent(akTarget, containerEnd)
		else
			Debug.SendAnimationEvent(akTarget, containerLootEnd)
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
	if asEventName == "KNNOpenEndtableSneakQLStartFinished"
		;Debug.Notification("OnAnimationEvent : " + asEventName)
		IsActivate = false
		RegisterForControl("Activate")
		RegisterForControl("Forward")
		RegisterForControl("Back")
		RegisterForControl("Strafe Left")
		RegisterForControl("Strafe Right")
		RegisterForControl("Move")
		GoToState("AnimControl")
	elseIf asEventName == "KNNOpenEndtableSneakQLActivateFinished"
		;Debug.Notification("OnAnimationEvent : " + asEventName)
		IsActivate = true
		RegisterForControl("Forward")
		RegisterForControl("Back")
		RegisterForControl("Strafe Left")
		RegisterForControl("Strafe Right")
		RegisterForControl("Move")
		if IsAnimEnd && IsActivate
			Debug.SendAnimationEvent(akSource, containerLootEnd)
			return
		endIf
		GoToState("AnimControl")
	elseIf asEventName == containerLootInsEnd_Done ||  asEventName == "JumpDown"
		;Debug.Notification("OnAnimationEvent : " + asEventName)
		GoToState("")
		IsAnimFinished = true
		self.Dispel()
	elseIf asEventName == containerEnd_Done || asEventName == containerLootEnd_Done
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