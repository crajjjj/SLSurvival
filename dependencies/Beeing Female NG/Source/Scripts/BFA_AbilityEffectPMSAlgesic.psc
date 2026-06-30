Scriptname BFA_AbilityEffectPMSAlgesic extends activemagiceffect  

float DamageResistMod
float PoisonResistMod
float FireResistMod
float ElectricResistMod
float FrostResistMod
float MagicResistMod
actor PlayerRef

Event OnEffectStart(Actor target, Actor caster)
	PlayerRef = target
	
	If PlayerRef
		DamageResistMod = PlayerRef.GetBaseActorValue("DamageResist") * 0.3
		PoisonResistMod = PlayerRef.GetBaseActorValue("PoisonResist") * 0.3
		FireResistMod = PlayerRef.GetBaseActorValue("FireResist") * 0.3
		ElectricResistMod = PlayerRef.GetBaseActorValue("ElectricResist") * 0.3
		FrostResistMod = PlayerRef.GetBaseActorValue("FrostResist") * 0.3
		MagicResistMod = PlayerRef.GetBaseActorValue("MagicResist") * 0.3
		
		PlayerRef.ModActorValue("DamageResist", -DamageResistMod)
		PlayerRef.ModActorValue("PoisonResist", -PoisonResistMod)
		PlayerRef.ModActorValue("FireResist", -FireResistMod)
		PlayerRef.ModActorValue("ElectricResist", -ElectricResistMod)
		PlayerRef.ModActorValue("FrostResist", -FrostResistMod)
		PlayerRef.ModActorValue("MagicResist", -MagicResistMod)
	Else
		Dispel()
	EndIf
EndEvent

Event OnEffectFinish(Actor target, Actor caster)
	If PlayerRef
		PlayerRef.ModActorValue("DamageResist", DamageResistMod)
		PlayerRef.ModActorValue("PoisonResist", PoisonResistMod)
		PlayerRef.ModActorValue("FireResist", FireResistMod)
		PlayerRef.ModActorValue("ElectricResist", ElectricResistMod)
		PlayerRef.ModActorValue("FrostResist", FrostResistMod)
		PlayerRef.ModActorValue("MagicResist", MagicResistMod)
	EndIf
EndEvent
