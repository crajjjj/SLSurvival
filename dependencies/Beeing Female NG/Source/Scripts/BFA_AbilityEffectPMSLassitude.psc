Scriptname BFA_AbilityEffectPMSLassitude extends activemagiceffect  

float SpeedMultMod
actor PlayerRef

Event OnEffectStart(Actor target, Actor caster)
	PlayerRef = target
	
	If PlayerRef
		PlayerRef.ModActorValue("Stamina", -20)
		PlayerRef.ModActorValue("StaminaRateMult", -20)
		SpeedMultMod = PlayerRef.GetBaseActorValue("SpeedMult") * 0.08
		PlayerRef.ModActorValue("SpeedMult", -SpeedMultMod)
	Else
		Dispel()
	EndIf
EndEvent

Event OnEffectFinish(Actor target, Actor caster)
	If PlayerRef
		PlayerRef.ModActorValue("Stamina", 20)
		PlayerRef.ModActorValue("StaminaRateMult", 20)
		PlayerRef.ModActorValue("SpeedMult", SpeedMultMod)
	EndIf
EndEvent
