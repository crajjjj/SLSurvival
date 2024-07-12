scriptName _KNNPlayAnimationAlias extends ReferenceAlias

;Event OnCombatStateChanged(Actor akTarget, Int aeCombatState)
;	if akTarget == GetActorReference()
;		if 1 == aeCombatState || 2 == aeCombatState
;			GetOwningQuest().SetStage(255)
;			(GetOwningQuest() as _KNNPlayAnimationQuest).FroceIdle(GetActorReference())
;		endIf
;	endIf
;EndEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	if akAggressor && akAggressor != GetReference()
		(GetOwningQuest() as _KNNPlayAnimationQuest).ForcedQuestStop(GetActorReference(), true)
	endIf
EndEvent