Scriptname BFA_AbilityEffectPMSDepressive extends activemagiceffect  

Float ModHealthAmount
Float ModHealthRegenAmount
actor PlayerRef

Event OnEffectStart(Actor target, Actor caster)
	PlayerRef=target
	
	If PlayerRef
		ModHealthAmount = PlayerRef.GetBaseActorValue("Health") * 0.3
		ModHealthRegenAmount = PlayerRef.GetBaseActorValue("HealRate") * 0.4
		PlayerRef.ModActorValue("Health", -ModHealthAmount)
		PlayerRef.ModActorValue("HealRate", -ModHealthRegenAmount)
	Else
		Dispel()
	EndIf
EndEvent

Event OnEffectFinish(Actor target, Actor caster)
	If PlayerRef
		PlayerRef.ModActorValue("Health", ModHealthAmount)
		PlayerRef.ModActorValue("HealRate", ModHealthRegenAmount)
	EndIf
EndEvent
