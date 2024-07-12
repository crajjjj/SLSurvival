Scriptname PSQCheesePotionsEffectScript Extends ActiveMagicEffect  

Potion Property FoodItem Auto  
Int Property Count Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	akCaster.AddItem(FoodItem, Count)
EndEvent
