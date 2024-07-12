Scriptname SLV_Arousal extends Quest  


Faction Property SLV_ArousalDummyFaction Auto


int Function GetArousalRank(Actor NPCActor)

if Game.GetModByName("SexLabAroused.esm")!= 255
	Faction sla_Arousal = Game.GetFormFromFile(0x03FC36, "SexLabAroused.esm") as Faction
	return NPCActor.GetFactionRank(sla_Arousal)
else
	return NPCActor.GetFactionRank(SLV_ArousalDummyFaction)
endif
EndFunction
