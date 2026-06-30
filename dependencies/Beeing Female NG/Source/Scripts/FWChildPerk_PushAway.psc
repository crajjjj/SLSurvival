Scriptname FWChildPerk_PushAway extends ActiveMagicEffect

int Property PushForce  Auto

Event OnEffectStart(actor Target, actor Caster)
	Caster.PushActorAway(Target, PushForce)
EndEvent