Scriptname BFA_AbilityEffectPMSDisqualify extends activemagiceffect  

actor PlayerRef

Event OnEffectStart(Actor target, Actor caster)
	PlayerRef = target
	
	If PlayerRef
		PlayerRef.ModActorValue("AlchemyMod", -0.3)
		PlayerRef.ModActorValue("SmithingMod", -0.2)
		PlayerRef.ModActorValue("EnchantingMod", -0.2)
	EndIf
EndEvent

Event OnEffectFinish(Actor target, Actor caster)
	If PlayerRef
		PlayerRef.ModActorValue("AlchemyMod", 0.3)
		PlayerRef.ModActorValue("SmithingMod", 0.2)
		PlayerRef.ModActorValue("EnchantingMod", 0.2)
	EndIf
EndEvent
