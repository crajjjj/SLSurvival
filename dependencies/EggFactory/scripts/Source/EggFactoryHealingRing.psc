Scriptname EggFactoryHealingRing extends ActiveMagicEffect  

actor property myself auto hidden
faction property EggFactoryFaction auto
faction property EggFactoryActiveFaction auto
bool property recharging=false auto hidden

EVENT OnEffectStart(Actor Target, Actor Caster)
	mySelf = caster
endEVENT

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)

	if (myself.GetActorValuePercentage("Health")<0.25 && recharging == false && myself.GetFactionRank(EggFactoryActiveFaction)>0)
		int rank = myself.GetFactionRank(EggFactoryFaction)
		if(rank == -2)
			myself.AddToFaction(EggFactoryFaction)
		endif
		myself.ModFactionRank(EggFactoryFaction,1)
		myself.RestoreActorValue("Health",1000)
		recharging=true
		RegisterForSingleUpdate(300)
	endif

endEvent
 
Event OnUpdate()
	recharging = false
EndEvent