Scriptname SuccubusDrainStaminaSpellScript Extends ActiveMagicEffect

Spell Property SuccubusCanFeedMarkSpell Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If akTarget.GetActorValue("Stamina") <= 0
		Debug.SendAnimationEvent(akTarget, "BleedOutStart")
		SuccubusCanFeedMarkSpell.Cast(akTarget)
		Utility.Wait(10.0)
		Debug.SendAnimationEvent(akTarget, "BleedOutStop")
	EndIf
EndEvent
