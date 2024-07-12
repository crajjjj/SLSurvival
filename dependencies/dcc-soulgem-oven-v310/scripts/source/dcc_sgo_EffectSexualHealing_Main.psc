Scriptname dcc_sgo_EffectSexualHealing_Main extends ActiveMagicEffect

Event OnEffectStart(Actor Who, Actor From)
{restore 20% of the actors basic values when drinking this potion.}

	Who.RestoreActorValue("Health",Who.GetBaseActorValue("Health") * 0.20)
	Who.RestoreActorValue("Stamina",Who.GetBaseActorValue("Stamina") * 0.20)
	Who.RestoreActorValue("Magicka",Who.GetBaseActorValue("Magicka") * 0.20)
	Return
EndEvent
