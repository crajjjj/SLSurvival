Scriptname MME_RND_SemenScr extends activemagiceffect Hidden

Event OnEffectStart( Actor akTarget, Actor akCaster )
	if Game.GetPlayer() == akTarget
		MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
		int RND_SuccubusSatitation = 0
		
		if MilkQ.isSuccubus(akTarget)
			if MilkQ.Plugin_PSQ
				MilkQ.PSQ.AddEnergy()
			endif
			if MilkQ.Plugin_RealisticNeedsandDiseases
				RND_SuccubusSatitation = 45
			endif
		endif
		MilkQ.RND.Hunger(RND_SuccubusSatitation)
		MilkQ.RND.Thirst()
	endif
EndEvent