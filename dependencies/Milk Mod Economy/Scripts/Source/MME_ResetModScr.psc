Scriptname MME_ResetModScr extends activemagiceffect Hidden

Event OnEffectStart(Actor akTarget, Actor akCaster)
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	MilkQ.VarSetup()
EndEvent