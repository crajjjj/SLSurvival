Scriptname zazGetTrappedIntoScript extends ObjectReference  

actor Property victim auto
Armor Property zbfOutfitBound Auto
Armor Property zbfOutfitBound2 Auto
Armor Property zbfOutfitBound3 Auto
ObjectReference Property xmarkhead auto

	

function OnTriggerEnter(ObjectReference akActionRef)
		
	if akActionRef == game.GetPlayer() as ObjectReference
		game.GetPlayer().MoveTo(xmarkhead, 0.000000, 0.000000, 0.000000, true)
		victim.equipItem(zbfOutfitBound)
		victim.equipItem(zbfOutfitBound2)
		victim.equipItem(zbfOutfitBound3)

	
	endIf
endFunction

