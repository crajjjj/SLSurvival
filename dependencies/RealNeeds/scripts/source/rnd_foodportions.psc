Scriptname RND_FoodPortions extends activemagiceffect  

Potion Property FoodItem  Auto  
Int Property Count  Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

	Game.GetPlayer().AddItem(FoodItem, Count)

EndEvent
