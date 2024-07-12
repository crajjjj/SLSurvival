Scriptname _SLS_Taunt extends ReferenceAlias  

Event OnInit()
	akTarget = Self.GetReference() as Actor
	If akTarget 
		If PlayerRef.IsInCombat()
			;If akTarget.GetEquippedItemType(1) <= 6 ; Has built-in condition check on alias
				;akTarget.SetLookAt(PlayerRef, abPathingLookAt = true) ; Doesn't work anyway
				RegisterForSingleUpdate(0.0)
			;EndIf
		Else
			_SLS_TauntHitSpell.Cast(PlayerRef, akTarget)
		EndIf
	EndIf
EndEvent

Event OnUpdate()
	Debug.Trace("_SLS_: Taunt: Actor: " + akTarget + ". Pack: " + akTarget.GetCurrentPackage() + ". Target: " + akTarget.GetCombatTarget())
	;RegisterForSingleUpdate(0.1)
	If !akTarget.IsDead() && akTarget.GetCombatTarget() != PlayerRef && Timeout > 0
		;_SLS_TauntHitSpell.Cast(PlayerRef, akTarget)
		TimeOut -= 1
		RegisterForSingleUpdate(1.0)
	Else
		;akTarget.ClearLookAt()
		Self.GetOwningQuest().Stop()
	EndIf
EndEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	; Stop trying to path to the player dumbly if target keeps getting hit
	If HitCount >= 3
		;akTarget.ClearLookAt()
		Self.GetOwningQuest().Stop()
	Else
		HitCount += 1
	EndIf
EndEvent

Int HitCount = 0
Int Timeout = 6

Actor akTarget

Spell Property _SLS_TauntHitSpell Auto

Actor Property PlayerRef Auto
