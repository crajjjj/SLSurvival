Scriptname BFA_AbilityEffectPMSHeadageHurts extends activemagiceffect  

FWAddOnManager property Manager auto

int count
int property MaxCount = 4 Auto
actor PlayerRef

Event OnEffectStart(Actor target, Actor caster)
	PlayerRef = target
	If PlayerRef
		RegisterForSingleUpdateGameTime(1)
	Else
		Dispel()
	EndIf
endEvent

Event  OnUpdateGameTime()
	If PlayerRef && isFormValid() ;***Edit by Bane
		int v = Utility.RandomInt(0, 5)
		if v > 4
			count = 0
			RegisterForSingleUpdate(4)
		elseif v > 2
			PlayerRef.DamageActorValue("magicka", (PlayerRef.GetBaseActorValue("magicka") / 100) * 30);
		endIf
		RegisterForSingleUpdateGameTime(1)
	Else
		Dispel()
	EndIf
endEvent

event onUpdate()
	If PlayerRef && isFormValid() ;***Edit by Bane
		PlayerRef.DamageActorValue("magicka", (PlayerRef.GetBaseActorValue("magicka") / 100) * 10);
		PlayerRef.DamageActorValue("Health", ((PlayerRef.GetBaseActorValue("Health") / 100) * 4) * Manager.getActorDamageScale(2, PlayerRef));
		count += 1
		if count <= MaxCount
			RegisterForSingleUpdate(4)
		endIf
	Else
		Dispel()
	EndIf
endEvent

Event OnEffectFinish(Actor target, Actor caster)
	if isFormValid() ;***Added by Bane
		UnregisterForUpdateGameTime()
	endif
endEvent

bool Function isFormValid() ;***Added by Bane
	return (PlayerRef as form) != none && (PlayerRef.GetLeveledActorBase() as ActorBase) != none
endfunction
