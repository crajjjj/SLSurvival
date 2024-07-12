Scriptname RND_WaterTokenScript extends ObjectReference  

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
  if akNewContainer == Game.GetPlayer()
	Game.GetPlayer().addItem(EmptyBottle, count)
    Game.GetPlayer().addItem(RND_FlagonWater, num, true)
	Game.GetPlayer().removeItem(WaterToken, 1, true )
  endIf
endEvent

Potion Property RND_FlagonWater Auto
int Property num Auto
MiscObject Property WaterToken Auto
Potion Property EmptyBottle Auto
int Property count Auto
