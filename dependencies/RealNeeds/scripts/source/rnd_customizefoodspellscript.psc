Scriptname RND_CustomizeFoodSpellScript extends activemagiceffect

Keyword Property VendorItemFood Auto
Keyword Property VendorItemFoodRaw Auto
Message Property RND_CustomizeFoodMessage Auto
FormList Property RND_RawFoodList Auto
FormList Property RND_SnackFoodList Auto
FormList Property RND_MediumFoodList Auto
FormList Property RND_AbundantFoodList Auto
FormList Property RND_BeverageList Auto
FormList Property RND_AlcoholBeverageList Auto
FormList Property RND_VanillaFoodList Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

	ObjectReference SelectedRef = Game.GetCurrentCrosshairRef() as ObjectReference
	Potion SelectedFood = SelectedRef.GetBaseObject() as Potion
	If (SelectedFood.HasKeyword(VendorItemFood) || SelectedFood.HasKeyword(VendorItemFoodRaw)) && !RND_VanillaFoodList.HasForm(SelectedFood)
		If (!RND_RawFoodList.HasForm(SelectedFood) && !RND_SnackFoodList.HasForm(SelectedFood) && !RND_MediumFoodList.HasForm(SelectedFood) && !RND_AbundantFoodList.HasForm(SelectedFood) && !RND_BeverageList.HasForm(SelectedFood) && !RND_AlcoholBeverageList.HasForm(SelectedFood))
			Int iButton = RND_CustomizeFoodMessage.Show() as Int
			If iButton == 0
				RND_RawFoodList.AddForm(SelectedFood)
				SelectedFood.SetName(SelectedFood.GetName() + " (Raw Food)")
			ElseIf iButton == 1
				RND_SnackFoodList.AddForm(SelectedFood)
				SelectedFood.SetName(SelectedFood.GetName() + " (Snack)")					
			ElseIf iButton == 2
				RND_MediumFoodList.AddForm(SelectedFood)
				SelectedFood.SetName(SelectedFood.GetName() + " (Medium Meal)")					
			ElseIf iButton == 3
				RND_AbundantFoodList.AddForm(SelectedFood)
				SelectedFood.SetName(SelectedFood.GetName() + " (Abundant Meal)")					
			ElseIf iButton == 4
				RND_BeverageList.AddForm(SelectedFood)
				SelectedFood.SetName(SelectedFood.GetName() + " (Beverage)")					
			ElseIf iButton == 5
				RND_AlcoholBeverageList.AddForm(SelectedFood)
				SelectedFood.SetName(SelectedFood.GetName() + " (Alcohol)")					
			ElseIf iButton == 6
				return
			EndIf
		ElseIf (RND_RawFoodList.HasForm(SelectedFood) || RND_SnackFoodList.HasForm(SelectedFood) || RND_MediumFoodList.HasForm(SelectedFood) || RND_AbundantFoodList.HasForm(SelectedFood) || RND_BeverageList.HasForm(SelectedFood) || RND_AlcoholBeverageList.HasForm(SelectedFood))
			Debug.Messagebox("This item is already classIfied as functional food, no adaption needed!")	
		EndIf	
	ElseIf (SelectedFood.HasKeyword(VendorItemFood) || SelectedFood.HasKeyword(VendorItemFoodRaw)) && RND_VanillaFoodList.HasForm(SelectedFood)
		Debug.Messagebox("This item is food by default, no adaption needed!")
	EndIf

EndEvent