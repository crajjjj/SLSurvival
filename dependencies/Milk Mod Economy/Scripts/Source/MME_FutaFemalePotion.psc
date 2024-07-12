Scriptname MME_FutaFemalePotion extends activemagiceffect Hidden

Event OnEffectStart( Actor akTarget, Actor akCaster )
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	MilkQ.SLA.UpdateActorExposureRate(akTarget, MilkQ.SLA.GetActorExposureRate(akTarget)/3)

	if MilkQ.Plugin_SOS
		MilkQ.SOS.DecreaseSOS(akTarget)
	endif
EndEvent