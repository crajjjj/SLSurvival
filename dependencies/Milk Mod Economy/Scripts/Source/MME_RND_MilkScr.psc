Scriptname MME_RND_MilkScr extends activemagiceffect Hidden

Event OnEffectStart( Actor akTarget, Actor akCaster )
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	if MilkQ.Plugin_RealisticNeedsandDiseases && Game.GetPlayer() == akTarget
		MilkQ.RND.Hunger()
		MilkQ.RND.Thirst()
	endif
EndEvent
