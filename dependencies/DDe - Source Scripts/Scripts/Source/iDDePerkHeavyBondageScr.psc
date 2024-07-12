;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 5
Scriptname iDDePerkHeavyBondageScr Extends Perk Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
;Eat it
	If (akTargetRef.HasKeyword(VendorItemIngredient))
		Ingredient inYummy = akTargetRef.GetBaseObject() AS Ingredient ;30
		akActor.EquipItem(inYummy, abPreventRemoval = False, abSilent = True)
	Else
		Potion poYummy = akTargetRef.GetBaseObject() AS Potion ;46
		akActor.EquipItem(poYummy, abPreventRemoval = False, abSilent = True)
	EndIf
akTargetRef.Delete()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Keyword Property VendorItemIngredient Auto
