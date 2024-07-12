Scriptname aaaKNNHTIdleEffect extends activemagiceffect

Quest Property animCtrl auto
Spell Property HTIdleSpell auto
Actor thisActor
int random = 0
string[] startAnimName
string[] fnishEventName
string[] idleEventName

int Property AnimIndex
	int Function Get()
		return random
	EndFunction
	Function Set(int value)
		random = value
	EndFunction
EndProperty

int iIsInstantFnished = 0
int Property InstantFnished
	int Function Get()
		return iIsInstantFnished
	EndFunction
	Function Set(int value)
		if 0 == value
			iIsInstantFnished = 0
		else
			iIsInstantFnished += value
		endIf
	EndFunction
EndProperty

int iFnishAnim = 0
int Property ShouleBeFnished
	int Function Get()
		return iFnishAnim
	EndFunction
	Function Set(int value)
		iFnishAnim += value
	EndFunction
EndProperty

Function RegisterAnimEventString(Actor akTarget)
	RegisterForAnimationEvent(akTarget, "KNNHTI_DONE")
	RegisterForAnimationEvent(akTarget, "KNNHTIST")
	startAnimName = new string[4]
	fnishEventName = new string[4]
	idleEventName = new string[4]
	if (animCtrl as aaaKNNAnimControlQuest).GetGender(akTarget)
		startAnimName[0] = "KNNHTIdleHandOnHipStart"
		startAnimName[1] = "KNNHTIdleBothHandsOnHipStart"
		startAnimName[2] = "KNNHTIdleHoldingHandsBackStart"
		startAnimName[3] = "KNNHTIdleCrossingArmsStart"

		fnishEventName[0] = "KNNHTIdleHandOnHipEnd"
		fnishEventName[1] = "KNNHTIdleBothHandsOnHipEnd"
		fnishEventName[2] = "KNNHTIdleHoldingHandsBackEnd"
		fnishEventName[3] = "KNNHTIdleCrossingArmsEnd"

		idleEventName[0] = "KNNHTIdleHandOnHipLoop"
		idleEventName[1] = "KNNHTIdleBothHandsOnHipLoop"
		idleEventName[2] = "KNNHTIdleHoldingHandsBackLoop"
		idleEventName[3] = "KNNHTIdleCrossingArmsLoop"
	else
		startAnimName[0] = "KNNHTIdleHandOnHipStart_M"
		startAnimName[1] = "KNNHTIdleBothHandsOnHipStart_M"
		startAnimName[2] = "KNNHTIdleHoldingHandsBackStart_M"
		startAnimName[3] = "KNNHTIdleCrossingArmsStart_M"

		fnishEventName[0] = "KNNHTIdleHandOnHipEnd_M"
		fnishEventName[1] = "KNNHTIdleBothHandsOnHipEnd_M"
		fnishEventName[2] = "KNNHTIdleHoldingHandsBackEnd_M"
		fnishEventName[3] = "KNNHTIdleCrossingArmsEnd_M"

		idleEventName[0] = "KNNHTIdleHandOnHipLoop_M"
		idleEventName[1] = "KNNHTIdleBothHandsOnHipLoop_M"
		idleEventName[2] = "KNNHTIdleHoldingHandsBackLoop_M"
		idleEventName[3] = "KNNHTIdleCrossingArmsLoop_M"
	endIf
EndFunction

Event OnEffectStart(Actor akTarget, Actor akCaster)
	;Debug.Trace("OnEffectStart : " + akTarget.GetBaseObject().GetName())
	GoToState("START")
	;Debug.sendAnimationEvent(akTarget, "idleStop")
	thisActor = akTarget
	RegisterForControl("Forward")
	RegisterForControl("Back")
	RegisterForControl("Strafe Left")
	RegisterForControl("Strafe Right")
	RegisterForControl("Move")	
	RegisterAnimEventString(akTarget)
	StartIdleAnimation(akTarget)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	;Debug.Trace("OnEffectFinish : " + akTarget.GetBaseObject().GetName())
	if 0 < InstantFnished
		Debug.SendAnimationEvent(akTarget, "IdleForceDefaultState")
		;Debug.Trace("OnEffectFinish -> IdleForceDefaultState")
	elseIf 0 < AnimIndex
		;Debug.Trace("OnEffectFinish -> FinishIdleAnimation")
		FinishIdleAnimation(akTarget)
	endIf
EndEvent

State START
	Event OnAnimationEvent(ObjectReference akSource, string asEventName)
		if thisActor != akSource
			return
		endIf
		if asEventName == "JumpDown"
			GoToState("")
			AnimIndex = 0
			thisActor.DispelSpell(HTIdleSpell)
			;Debug.Trace("KNNHT START -> Empty State -> JumpDown -> DispelSpell")
			return
		elseIf asEventName == "KNNHTIST"
			if 0 < InstantFnished
				GoToState("")
				AnimIndex = 0
				InstantFnished = 0
				Utility.Wait(0.5)
				thisActor.DispelSpell(HTIdleSpell)
				;Debug.Trace("KNNHT START -> Empty State -> DispelSpell")
			elseIf 0 < ShouleBeFnished
				GoToState("FINISH")
				Utility.Wait(1.0)
				FinishIdleAnimation(thisActor)
				;Debug.Trace("KNNHT START -> FINISH State")
			else
				GoToState("READY")
				int val = AnimIndex
				Debug.SendAnimationEvent(akSource, idleEventName[val - 1])
				;Debug.Trace("KNNHT START -> Play Idle : " + idleEventName[val - 1] + " -> READY State")
			endIf
		endIf
	EndEvent

	Event OnPlayerFinishTalking(Actor akTarget)
		;Debug.Notification("OnPlayerFinishTalking")
		string stateName = GetState()
		if "START" == stateName
			ShouleBeFnished = 1
		elseIf "READY" == stateName
			GoToState("FINISH")
			FinishIdleAnimation(akTarget)
			;Debug.Trace("KNNHT START -> FINISH State")
		endIf
	EndEvent

	Event OnPlayerFinishTalkingInstant(Actor akTarget)
		;Debug.Notification("OnPlayerFinishTalkingInstant")
		string stateName = GetState()
		if "START" == stateName
			InstantFnished = 1
		elseIf "READY" == stateName
			InstantFnished = 1
		endIf
	EndEvent
EndState

State FINISH
	Event OnAnimationEvent(ObjectReference akSource, string asEventName)
		if thisActor != akSource
			return
		endIf
		if asEventName == "JumpDown"
			GoToState("")
			AnimIndex = 0
			InstantFnished = 0
			thisActor.DispelSpell(HTIdleSpell)
			;Debug.Trace("KNNHT FINISH -> Empty State -> JumpDown -> DispelSpell")
		elseIf asEventName == "KNNHTI_DONE"
			;Debug.Notification("OnAnimationEvent : " + asEventName)
			;Utility.Wait(0.5)
			GoToState("")
			AnimIndex = 0
			thisActor.DispelSpell(HTIdleSpell)
			Debug.SendAnimationEvent(akSource, "idleStop")
			;Debug.Trace("KNNHT FINISH -> Empty State")
		endIf
	EndEvent
EndState

State CHANGE
	Event OnAnimationEvent(ObjectReference akSource, string asEventName)
		if thisActor != akSource
			return
		endIf
		if asEventName == "JumpDown"
			GoToState("")
			AnimIndex = 0
			InstantFnished = 0
			thisActor.DispelSpell(HTIdleSpell)
			;Debug.Trace("KNNHT CHANGE -> Empty State -> JumpDown -> DispelSpell")
		elseIf asEventName == "KNNHTI_DONE"
			;Debug.Notification("OnAnimationEvent : " + asEventName)
			;Utility.Wait(0.5)
			if 0 < InstantFnished || 0 < ShouleBeFnished
				GoToState("")
				AnimIndex = 0
				thisActor.DispelSpell(HTIdleSpell)
				;Debug.Trace("KNNHT CHANGE -> Empty State -> DispelSpell")
			else
				GoToState("START")
				;Debug.SendAnimationEvent(akSource, "idleStop")
				Utility.Wait(0.6)
				AnimIndex = 0
				StartIdleAnimation(akSource as actor)
				;Debug.Trace("KNNHT CHANGE -> START State")
			endIf
		endIf
	EndEvent

	Event OnPlayerFinishTalking(Actor akTarget)
		;Debug.Notification("OnPlayerFinishTalking")
		string stateName = GetState()
		if "CHANGE" == stateName
			InstantFnished = 1
		elseIf "START" == stateName
			ShouleBeFnished = 1
		endIf
	EndEvent

	Event OnPlayerFinishTalkingInstant(Actor akTarget)
		;Debug.Notification("OnPlayerFinishTalkingInstant")
		string stateName = GetState()
		if "CHANGE" == stateName
			InstantFnished = 1
		elseIf "START" == stateName
			InstantFnished = 1
		endIf
	EndEvent
EndState

State READY
	Event OnControlDown(string control)
		If control == "Forward" || control == "Back" || control == "Strafe Left" || control == "Strafe Right" || control == "Move"
			GoToState("")
			AnimIndex = 0
			InstantFnished = 1
			thisActor.DispelSpell(HTIdleSpell)
			;Debug.Trace("KNNHT READY -> Empty State -> -> Keydown -> DispelSpell")
		EndIf
	EndEvent

	Event OnAnimationEvent(ObjectReference akSource, string asEventName)
		if thisActor != akSource
			return
		endIf
		if asEventName == "JumpDown"
			GoToState("")
			AnimIndex = 0
			InstantFnished = 0
			thisActor.DispelSpell(HTIdleSpell)
			;Debug.Trace("KNNHT READY -> Empty State -> JumpDown -> DispelSpell")
		endIf
	EndEvent

	Event OnPlayerFinishTalking(Actor akTarget)
		;Debug.Notification("OnPlayerFinishTalking")
		GoToState("FINISH")
		FinishIdleAnimation(akTarget)
		;Debug.Trace("KNNHT READY -> OnPlayerFinishTalking -> FINISH State -> FinishIdleAnimation")
		;self.Dispel()
	EndEvent

	Event OnPlayerChangeIdleAnim(Actor akTarget)
		;Debug.Trace("OnPlayerChangeIdleAnim")
		GoToState("CHANGE")
		FinishIdleAnimation(akTarget)
		;Debug.Trace("KNNHT READY -> OnPlayerChangeIdleAnim -> CHANGE State -> FinishIdleAnimation")
	EndEvent

	Event OnPlayerFinishTalkingInstant(Actor akTarget)
		;Debug.Trace("OnPlayerFinishTalkingInstant")
		GoToState("")
		InstantFnished = 1
		AnimIndex == 0
		thisActor.DispelSpell(HTIdleSpell)
		;Debug.Trace("KNNHT READY -> Empty State -> InstantFinish -> DispelSpell")
	EndEvent
EndState

Event OnPlayerFinishTalking(Actor akTarget)
	;Debug.Notification("OnPlayerFinishTalking : empty state")
EndEvent

Event OnPlayerFinishTalkingInstant(Actor akTarget)
	;Debug.Notification("OnPlayerFinishTalkingInstant : empty state")
EndEvent

Event OnPlayerChangeIdleAnim(Actor akTarget)
	;Debug.Notification("OnPlayerChangeIdleAnim : empty state")
EndEvent

Function StartIdleAnimation(Actor akTarget)
	;Debug.sendAnimationEvent(akTarget, "idleStop")
	Utility.Wait(0.1)
	int val = GetRandomInt()
	AnimIndex = val
	Debug.SendAnimationEvent(akTarget, startAnimName[val - 1])
	;Debug.Trace("Start Idle -> " + startAnimName[val - 1])
EndFunction

Function FinishIdleAnimation(Actor akTarget)
	int val = AnimIndex
	Utility.Wait(0.5)
	if 0 < val || 5 > val
		Debug.SendAnimationEvent(akTarget, fnishEventName[val - 1])
	endIf
EndFunction

int Function GetRandomInt()
	int randomVal = Utility.RandomInt(1, 4)
	if randomVal == AnimIndex
		bool finished = false
		;int startIndex = 0
		while !finished
			randomVal = Utility.RandomInt(1, 4)
			if randomVal != AnimIndex
				finished = true
			endIf
			;Debug.Notification("startIndex : " + startIndex)
			;startIndex += 1
		endwhile
	endIf
	return randomVal
EndFunction