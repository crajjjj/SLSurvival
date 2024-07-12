Scriptname _SLS_TraumaDynamicCombatAlias extends ReferenceAlias

Event OnInit()
	If Self.GetReference() as Actor
		RegisterForAnimationEvent(Self.GetReference(), "getupstart")
	EndIf
EndEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	If Trauma.NpcCandidatePush(akSource as Actor)
		Self.Clear()
	EndIf
EndEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	If Trauma.NpcCandidateHit(Self.GetReference() as Actor, akAggressor, akSource, akProjectile, abPowerAttack, abSneakAttack, abBashAttack, abHitBlocked)
		Self.Clear()
	EndIf
EndEvent

_SLS_Trauma Property Trauma Auto
