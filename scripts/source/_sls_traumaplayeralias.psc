Scriptname _SLS_TraumaPlayerAlias extends ReferenceAlias  

Event OnInit()
	RegisterForModEvent("_SLS_ToggleCombatTrauma", "On_SLS_ToggleCombatTrauma")
EndEvent

Event On_SLS_ToggleCombatTrauma(string eventName, string strArg, float numArg, Form sender)
	GoToState(Trauma.GetAliasState(Self.GetOwningQuest()))
EndEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	;Debug.Messagebox("Player Hit")
	Trauma.PlayerHit(akAggressor, akSource, akProjectile, abPowerAttack, abSneakAttack, abBashAttack, abHitBlocked)
EndEvent

State Off
	Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
		;Debug.Messagebox("Player  Off")
	EndEvent
EndState

_SLS_Trauma Property Trauma Auto
