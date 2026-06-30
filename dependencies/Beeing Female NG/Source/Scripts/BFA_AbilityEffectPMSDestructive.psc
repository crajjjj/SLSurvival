Scriptname BFA_AbilityEffectPMSDestructive extends activemagiceffect

actor PlayerRef

Event OnEffectStart(Actor target, Actor caster)
	PlayerRef=target
	
	If PlayerRef
		PlayerRef.ModActorValue("DestructionMod", 0.3)
		PlayerRef.ModActorValue("OneHandedMod", 0.2)
		PlayerRef.ModActorValue("TwoHandedMod", 0.2)
		PlayerRef.ModActorValue("IllusionMod", 0.3)
	Else
		Dispel()
	EndIf
EndEvent

Event OnEffectFinish(Actor target, Actor caster)
	If PlayerRef
		PlayerRef.ModActorValue("DestructionMod", -0.3)
		PlayerRef.ModActorValue("OneHandedMod", -0.2)
		PlayerRef.ModActorValue("TwoHandedMod", -0.2)
		PlayerRef.ModActorValue("IllusionMod", -0.3)
	EndIf
EndEvent
