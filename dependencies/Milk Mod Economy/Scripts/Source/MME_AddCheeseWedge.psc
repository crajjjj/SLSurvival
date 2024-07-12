Scriptname MME_AddCheeseWedge Extends ActiveMagicEffect Hidden

Event OnEffectStart(Actor akTarget, Actor akCaster)
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	akCaster.AddItem(MilkQ.MME_Foods.GetAt(0), 7)
EndEvent