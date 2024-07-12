Scriptname _SLS_DeviousDrowningPush extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	RegisterForSingleUpdate(0.0)
EndEvent

Event OnUpdate()
	PlayerRef.SetMotionType(1, abAllowActivate = true)
	;_SLS_DevDrownPushMarker.SetMotionType(1, abAllowActivate = true)

	_SLS_DevDrownPushMarker.MoveTo(PlayerRef, 0.0, 0.0, PlayerRef.GetHeight() + 160.0)
	PlayerRef.ApplyHavokImpulse(0.0, 0.0, 1.0, 10000.0)
	;PlayerRef.TranslateToRef(_SLS_DevDrownPushMarker, afSpeed = 1000.0, afMaxRotationSpeed = 0.0)

	Utility.Wait(0.5)
	PlayerRef.MoveTo(PlayerRef)
	;
	;_SLS_DevDrownPushMarker.PushActorAway(PlayerRef, 0.1)
	RegisterForSingleUpdate(0.1)
EndEvent

Actor  Property PlayerRef Auto

ObjectReference Property _SLS_DevDrownPushMarker Auto
