Scriptname ZazEquipBindsTMG extends ObjectReference  

actor Property victim auto
Armor Property zbfOutfitBound Auto
Armor Property zbfOutfitBound2 Auto
Armor Property zbfOutfitBound3 Auto


	

function OnActivate(ObjectReference akActionRef)
		
	if akActionRef == game.GetPlayer() as ObjectReference
		victim.equipItem(zbfOutfitBound)
		victim.equipItem(zbfOutfitBound2)
		victim.equipItem(zbfOutfitBound3)

	
	endIf
endFunction


