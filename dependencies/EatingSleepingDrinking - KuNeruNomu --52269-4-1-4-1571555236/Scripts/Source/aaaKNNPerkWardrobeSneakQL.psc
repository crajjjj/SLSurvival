Scriptname aaaKNNPerkWardrobeSneakQL extends activemagiceffect

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
	RegisterForAnimationEvent(akTarget, "KNNOpenWardrobeSneakQLStartFinished")
	RegisterForAnimationEvent(akTarget, "KNNOpenWardrobeSneakQLActivateFinished")
	if (animCtrl as aaaKNNAnimControlQuest).GetGender(akTarget)
		containerStart = "KNNOpenWardrobeSneakQLStart"
		containerStartIns = "KNNOpenWardrobeSneakQLInstantStart"
		containerEnd = "KNNOpenWardrobeSneakQLEnd"
		containerLootEnd = "KNNOpenWardrobeSneakQLActivateEnd"
		containerLootStart = "KNNOpenWardrobeSneakQLActivate"

		containerEnd_Done = "KNNOpenWardrobeSneakQLEnd_DONE"
		containerLootEnd_Done = "KNNOpenWardrobeSneakQLActivateEnd_DONE"
		containerLootInsEnd_Done = "KNNOpenWardrobeSneakQLActivateInstantEnd_DONE"
	else
		containerStart = "KNNOpenWardrobeSneakQLStart_M"
		containerStartIns = "KNNOpenWardrobeSneakQLInstantStart_M"
		containerEnd = "KNNOpenWardrobeSneakQLEnd_M"
		containerLootEnd = "KNNOpenWardrobeSneakQLActivateEnd_M"
		containerLootStart = "KNNOpenWardrobeSneakQLActivate_M"

		containerEnd_Done = "KNNOpenWardrobeSneakQLEnd_M_DONE"
		containerLootEnd_Done = "KNNOpenWardrobeSneakQLActivateEnd_M_DONE"
		containerLootInsEnd_Done = "KNNOpenWardrobeSneakQLActivateInstantEnd_M_DONE"
	endIf
	RegisterForAnimationEvent(akTarget, containerEnd_Done)
	RegisterForAnimationEvent(akTarget, containerLootEnd_Done)
	RegisterForAnimationEvent(akTarget, containerLootInsEnd_Done)
EndFunction

Event OnEffectStart(Actor akTarget, Actor akCaster)
	;Debug.Notification("OpenWardrobeSneak")
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
		Debug.SendAnimationEvent(thisActor, containerStartIns)
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
			UnregisterForAllControls()
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
	if asEventName == "KNNOpenWardrobeSneakQLStartFinished"
		;Debug.Notification("OnAnimationEvent : " + asEventName)
		IsActivate = false
		RegisterForControl("Activate")
		RegisterForControl("Forward")
		RegisterForControl("Back")
		RegisterForControl("Strafe Left")
		RegisterForControl("Strafe Right")
		RegisterForControl("Move")
		GoToState("AnimControl")
	elseIf asEventName == "KNNOpenWardrobeSneakQLActivateFinished"
		;Debug.Notification("OnAnimationEvent : " + asEventName)
		IsActivate = true
		;UnregisterForControl("Activate")
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
	elseIf asEventName == containerLootInsEnd_Done || asEventName == "JumpDown"
		;Debug.Notification("OnAnimationEvent : " + asEventName)
		GoToState("")
		IsAnimFinished = true
		self.Dispel()
	elseIf asEventName == containerLootEnd_Done || asEventName == containerEnd_Done
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
		;Debug.Notification("OnUpdate : IdleForceDefaultState")
		Debug.SendAnimationEvent(thisActor, "IdleForceDefaultState")
		RegisterForSingleUpdate(1.0)
		return
	endIf
	;Debug.Notification("OnUpdate : Dispel")
	self.Dispel()	
EndEvent