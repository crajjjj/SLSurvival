Scriptname _SLS_PickpocketFailBlock extends ReferenceAlias  

Function BeginBlock()
	Actor Me = Self.GetReference() as Actor
	If Me
		Self.GetRef().BlockActivation(abBlocked = True)
		RegisterForSingleUpdateGameTime(6.0)
	Else
		StopBlock()
	EndIf
EndFunction

Function StopBlock()
	Self.GetRef().BlockActivation(abBlocked = false)
	Self.Clear()
EndFunction

Event OnUpdateGameTime()
	StopBlock()
EndEvent

Event OnActivate(ObjectReference akActionRef)
	If akActionRef == PlayerRef
		If !PlayerRef.IsSneaking()
			Self.GetRef().BlockActivation(abBlocked = false)
			GoToState("IgnoreActivate")
			Self.GetReference().Activate(PlayerRef)
			GoToState("")
			Self.GetRef().BlockActivation(abBlocked = true)
		Else
			Debug.Notification("You've already been caught pickpocketing " + Self.GetReference().GetBaseObject().GetName())
		EndIf
	EndIf
EndEvent

State IgnoreActivate
	Event OnActivate(ObjectReference akActionRef)
	EndEvent
EndState

Actor Property PlayerRef Auto
