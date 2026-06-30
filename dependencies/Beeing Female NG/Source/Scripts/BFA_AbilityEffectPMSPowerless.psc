Scriptname BFA_AbilityEffectPMSPowerless extends activemagiceffect  

actor PlayerRef

Event OnEffectStart(Actor target, Actor caster)
	PlayerRef = target
	
	If PlayerRef
		PlayerRef.ModActorValue("Carryweight", -50)
		PlayerRef.ModActorValue("DestructionMod", -0.1)
		PlayerRef.ModActorValue("OneHandedMod", -0.3)
		PlayerRef.ModActorValue("TwoHandedMod", -0.3)
	Else
		Dispel()
	EndIf
EndEvent

Event OnEffectFinish(Actor target, Actor caster)
	If PlayerRef
		PlayerRef.ModActorValue("Carryweight", 50)
		PlayerRef.ModActorValue("DestructionMod", 0.1)
		PlayerRef.ModActorValue("OneHandedMod", 0.3)
		PlayerRef.ModActorValue("TwoHandedMod", 0.3)
	EndIf
EndEvent
