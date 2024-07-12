Scriptname _JSW_SUB_DamageTracker extends ActiveMagicEffect

event OnEffectStart(Actor akTarget, Actor akCaster)

	RegisterForSingleUpdate(4.0)

endEvent

event OnUpdate()

	ModEvent.Send(ModEvent.Create("FertilityModeDamageMessage"))

endEvent

event OnHit(ObjectReference a, Form b, Projectile c, bool d, bool e, bool f, bool g)

	RegisterForSingleUpdate(3.0)

endEvent
