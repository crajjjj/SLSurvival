ScriptName PSQLureRegisterScript Extends ActiveMagicEffect  

PlayerSuccubusQuestScript Property PSQ Auto

Event OnEffectStart(Actor Target, Actor Caster)
	PSQ.RegisterFish(Target, PSQ.PSQLureRegisterSpell.GetNthEffectMagnitude(0) as Int)
EndEvent
