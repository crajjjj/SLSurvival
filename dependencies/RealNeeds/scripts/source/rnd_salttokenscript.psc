Scriptname RND_SaltTokenScript extends ObjectReference  

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
  if akNewContainer == Game.GetPlayer()
	Game.GetPlayer().addItem(EmptyBottle, count)
    Game.GetPlayer().addItem(SaltPile, 1, true)
	Game.GetPlayer().removeItem(SaltToken, 1, true )
  endIf
endEvent

Ingredient Property SaltPile Auto
MiscObject Property SaltToken Auto
Potion Property EmptyBottle Auto
int Property count Auto

