Scriptname RND_ReturnEmptyBottle extends activemagiceffect  

Potion Property RND_EmptyBottle Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

	Game.GetPlayer().AddItem(RND_EmptyBottle, 1)
	
EndEvent

