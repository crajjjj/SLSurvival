Scriptname MME_MilkWerewolf extends activemagiceffect Hidden

Event OnEffectStart( Actor akTarget, Actor akCaster )
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	CompanionsHousekeepingScript WereWolfQuest = Quest.GetQuest("C00") as CompanionsHousekeepingScript

	if akTarget == MilkQ.PlayerRef && MilkQ.MilkWerewolfTransform
		int ButtonPressed = (Game.GetFormFromFile(0x4E562, "MilkModNEW.esp") as message).Show()
		if ButtonPressed == 0
			WereWolfQuest.BeastForm.Cast(akTarget)
			if MilkQ.MILKmaid.find(akTarget) != -1
				Utility.Wait(10.0)
				MilkQ.CurrentSize(akTarget)
			endif
		endif
	endif
EndEvent