Scriptname ZazEquipWeaponScript extends ObjectReference  

actor Property victim auto
Weapon Property zbfWeapon Auto



	

function OnSitEnter(ObjectReference akActionRef)
		
	if akActionRef == game.GetPlayer() as ObjectReference
		victim.equipItem(zbfWeapon)
		
		
	
	endIf
endFunction