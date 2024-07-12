Scriptname MME_SLSD extends Quest Hidden

bool Function IsIntegraged ()
	Return True
EndFunction

bool Function IsMilkingBlocked_Bra_SLSD (Actor akActor)
	Bool IsMilkingBlocked = false
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	if MilkQ.Plugin_SLSD
		if akActor.WornHasKeyword((Game.GetFormFromFile(0x4395 , "SexLab-StoriesDevious.esp") as Keyword)) || akActor.WornHasKeyword((Game.GetFormFromFile(0x18D18 , "SexLab-StoriesDevious.esp") as Keyword))
			IsMilkingBlocked = true
		endif
	endif
	Return IsMilkingBlocked
EndFunction
