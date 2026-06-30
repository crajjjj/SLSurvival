Scriptname FWEffectMenstruationBlood Extends ActiveMagicEffect  

Actor a

Event OnEffectStart(Actor target, Actor caster)
	a = target
	RegisterForSingleUpdate(2.0)
EndEvent

Event OnUpdate()
	If ! a || a.IsSwimming()
		Dispel()
	EndIf
	RegisterForSingleUpdate(2.0)
EndEvent