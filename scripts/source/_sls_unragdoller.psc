Scriptname _SLS_UnRagdoller extends Quest  

Event OnInit()
	If IsRunning()
		RegisterForAnimationEvent(PlayerRef, "RemoveCharacterControllerFromWorld")
		;RegisterForAnimationEvent(Game.GetPlayer(), "getupend")
	EndIf
EndEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	GoToState("Fallen")
EndEvent

Event OnUpdate()
EndEvent

State Fallen
	Event OnBeginState()
		UnRegisterForAnimationEvent(PlayerRef, "RemoveCharacterControllerFromWorld")
		RegisterForAnimationEvent(PlayerRef, "getupend")
		UnragdollMarker.MoveTo(PlayerRef)
		Count = 0
		RegisterForSingleUpdate(1.0)
		;Debug.Messagebox("FALLEN")
	EndEvent

	Event OnAnimationEvent(ObjectReference akSource, string asEventName)
		;Debug.Messagebox("GotUP")
		GoToState("")
	EndEvent
	
	Event OnUpdate()
		;Debug.Trace("_SLS_: TEST: bIsInMT: " + Game.GetPlayer().GetAnimationVariableBool("bIsInMT"))
		If PlayerRef.GetDistance(UnragdollMarker) > 0.1 ; Still sliding
			UnragdollMarker.MoveTo(PlayerRef)
			RegisterForSingleUpdate(1.0)
		Else
			If Count > 3
				;Debug.Messagebox("STUCK")
				Int Button = _SLS_UnRagdollMsg.Show()
				If Button == 0
					PlayerRef.PushActorAway(PlayerRef, 1.5)
				EndIf
				GoToState("")
			Else
				Count += 1
				RegisterForSingleUpdate(1.0)
			EndIf
		EndIf
	EndEvent

	Event OnEndState()
		UnRegisterForUpdate()
		UnRegisterForAnimationEvent(PlayerRef, "getupend")
		RegisterForAnimationEvent(PlayerRef, "RemoveCharacterControllerFromWorld")
	EndEvent
EndState

Int Count

Actor Property PlayerRef Auto

ObjectReference Property UnragdollMarker Auto

Message Property _SLS_UnRagdollMsg Auto
