Scriptname _SLS_OrgasmFatigueAlcohol extends ReferenceAlias  

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	If akBaseObject as Potion && AlcoholicDrinksList.HasForm(akBaseObject)
		OrgFat.DrinkAlcohol(akBaseObject)
	EndIf
EndEvent

Formlist Property AlcoholicDrinksList Auto

_SLS_OrgasmFatigue Property OrgFat Auto
