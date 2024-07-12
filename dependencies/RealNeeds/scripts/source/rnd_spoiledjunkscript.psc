Scriptname RND_SpoiledJunkScript extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)

	if Utility.RandomInt(0,100) < RND_CollectChance.getValue()
		Game.GetPlayer().AddItem(RND_Ingredient, 1)
	endif
EndEvent

Ingredient Property RND_Ingredient Auto

GlobalVariable Property RND_CollectChance Auto


