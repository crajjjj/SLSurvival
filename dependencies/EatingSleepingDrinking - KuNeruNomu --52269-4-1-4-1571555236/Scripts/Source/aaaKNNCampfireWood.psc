Scriptname aaaKNNCampfireWood extends ObjectReference  

;MiscObject Property campFirewood auto
;Furniture Property campfireCooking auto
Quest Property AnimCtrl auto
Keyword Property MagicDamageFire auto
Keyword Property MagicShout auto
Keyword Property ShoutFireBreath auto

Auto State Ready
	Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
		if !akAggressor || !akSource || !akProjectile
			return
		elseIf !(akSource as Spell)
			return
		endIf
	
		Spell thisSpell = akSource as Spell
		if !thisSpell
			;Debug.Trace("!thisSpell")
			return
		endIf
		if !thisSpell.IsHostile()
			;Debug.Trace("!IsHostile")
			return
		endIf
		if thisSpell.HasKeyword(MagicDamageFire)
			GoToState("Busy")
			if !(AnimCtrl as aaaKNNFirewoodControlQuest).SetCampfire(Self)
				GoToState("Ready")
			endIf
			return
		endIf
	EndEvent

	Event OnMagicEffectApply(ObjectReference akCaster, MagicEffect akEffect)
		if !akCaster || !akEffect || !(akCaster as Actor)
			return
		endIf
		if !akEffect.HasKeyword(MagicDamageFire) || !akEffect.HasKeyword(MagicShout) || !akEffect.HasKeyword(ShoutFireBreath)
			return
		endIf
		GoToState("Busy")
		if !(AnimCtrl as aaaKNNFirewoodControlQuest).SetCampfire(Self)
			GoToState("Ready")
			return
		endIf
	EndEvent

	Event OnActivate(ObjectReference akActionRef)
		GoToState("Busy")
		(AnimCtrl as aaaKNNFirewoodControlQuest).AddCampfirewood(Self, akActionRef)
	EndEvent
EndState

State Busy
EndState