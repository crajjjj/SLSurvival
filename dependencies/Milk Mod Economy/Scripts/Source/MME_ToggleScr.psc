Scriptname MME_ToggleScr extends activemagiceffect Hidden

Event OnEffectStart(Actor akTarget, Actor akCaster)
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	MilkQ.Modtoggle()
EndEvent