Scriptname _JSW_SUB_FGNPCApply extends ActiveMagicEffect  

Spell Property MonitorSpell Auto

event OnEffectStart(Actor akTarget, Actor akCaster)

	akTarget.AddSpell(MonitorSpell)

endEvent
