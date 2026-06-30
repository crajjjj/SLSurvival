Scriptname BFA_AbilityEffectPMSFaint extends activemagiceffect  

actor PlayerRef

Event OnEffectStart(Actor target, Actor caster)
	PlayerRef = target
	
	If PlayerRef
		PlayerRef.ModActorValue("Carryweight", -50)
		PlayerRef.ModActorValue("Stamina", -80)
		PlayerRef.ModActorValue("StaminaRateMult", -20)
		RegisterForSingleUpdateGameTime(2)
	Else
		Dispel()
	EndIf
EndEvent

Event onUpdateGameTime()
	If PlayerRef
		PlayerRef.DamageActorValue("Stamina", (PlayerRef.GetBaseActorValue("Stamina") / 100) * 20);
		RegisterForSingleUpdateGameTime(2)
	Else
		Dispel()
	EndIf
EndEvent

Event OnEffectFinish(Actor target, Actor caster)
	If PlayerRef
		PlayerRef.ModActorValue("Carryweight", 50)
		PlayerRef.ModActorValue("Stamina", 80)
		PlayerRef.ModActorValue("StaminaRateMult", 20)
	EndIf
EndEvent
