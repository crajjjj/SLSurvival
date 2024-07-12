Scriptname _SLS_WeaponReady extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Util.PlayerReadysWeapon(false)
	TargetActor = akTarget
	RegisterForSingleUpdate(1.0)
EndEvent

Event OnUpdate()
	If TargetActor
		If TargetActor.IsWeaponDrawn()
			Util.PlayerReadysWeapon(true)
		EndIf
	EndIf
EndEvent

Actor TargetActor

SLS_Utility Property Util Auto
