Scriptname _MA_AddictContainerQuestScript extends Quest  

Int Property AddictContainerState = 0 Auto Hidden ; 0 - reset, 1 - Building inv cat lists, 2 - Building _MA_AddictSellList, 3 - complete

Bool Property ContainerHasClothes = false Auto Hidden
Bool Property ContainerHasArmor = false Auto Hidden
Bool Property ContainerHasWeapons = false Auto Hidden
Bool Property ContainerHasJewelry = false Auto Hidden
Bool Property ContainerHasPotions = false Auto Hidden
Bool Property ContainerHasGems = false Auto Hidden
Bool Property ContainerHasFood = false Auto Hidden

Event On_MA_BeginSortPlayerInventory()
	SortPlayerInventory()
EndEvent

Event On_MA_BuildSellList()
	BuildSellList()
EndEvent

Function PlayerLoadsGame()
	RegEvents()
EndFunction

Function RegEvents()
	RegisterForModEvent("_MA_BeginSortPlayerInventory", "On_MA_BeginSortPlayerInventory")
	RegisterForModEvent("_MA_BuildSellList", "On_MA_BuildSellList")
EndFunction

Function ResetVariables()
	ContainerHasClothes = false
	ContainerHasArmor = false
	ContainerHasWeapons = false
	ContainerHasJewelry = false
	ContainerHasPotions = false
	ContainerHasGems = false
	ContainerHasFood = false
EndFunction

Function BuildSellList()
	;Debug.Messagebox("Building sell list")
	Utility.WaitMenuMode(0.2)
	If ContainerHasClothes
		_MA_AddictSellList.AddForm(_MA_AddictSellListClothing)
	EndIf
	If ContainerHasArmor || ContainerHasWeapons
		_MA_AddictSellList.AddForm(_MA_AddictSellListArmorWeapons)
	EndIf
	If ContainerHasJewelry
		_MA_AddictSellList.AddForm(_MA_AddictSellListJewelry)
	EndIf
	If ContainerHasPotions
		_MA_AddictSellList.AddForm(_MA_AddictSellListPotions)
	EndIf
	If ContainerHasGems
		_MA_AddictSellList.AddForm(_MA_AddictSellListGems)
	EndIf
	If ContainerHasFood
		_MA_AddictSellList.AddForm(_MA_AddictSellListFood)
	EndIf
	
	ResetVariables()
	While AddictContainerState != 2
		Utility.WaitMenuMode(0.2)
	EndWhile
	AddictContainerState = 3
	;Debug.Messagebox("List complete")
EndFunction

Function SortPlayerInventory()
	AddictContainerState = 1
	;Debug.Messagebox("SortPlayerInventory")
	_MA_AddictSellList.Revert()
	_MA_AddictSellListClothing.Revert()
	_MA_AddictSellListArmorWeapons.Revert()
	_MA_AddictSellListPotions.Revert()
	_MA_AddictSellListFood.Revert()
	_MA_AddictSellListGems.Revert()
	;_MA_AddictSellListIngredients.Revert()
	_MA_AddictSellListJewelry.Revert()
	
	Int i = PlayerRef.GetNumItems()
	Form akBaseItem

	While i > 0
		i -= 1
		akBaseItem = PlayerRef.GetNthForm(i)
		If !akBaseItem.HasKeyword(SexLabNoStrip) && akBaseItem.IsPlayable() && akBaseItem.GetGoldValue() > 0
			Debug.Trace("_MA_: Procing: " + akBaseItem.GetName())
			
			If akBaseItem as Ingredient ; Filter ingredients first. Low weight-> can have many in Inventory
				;_MA_AddictSellListIngredients.AddForm(akBaseItem) ; Don't bother with ingredients for now - Too little value. mostly.
			
			ElseIf akBaseItem.HasKeyword(ArmorClothing)
				_MA_AddictSellListClothing.AddForm(akBaseItem)
			
			ElseIf (akBaseItem.HasKeyword(VendorItemArmor) || akBaseItem.HasKeyword(VendorItemWeapon))
				_MA_AddictSellListArmorWeapons.AddForm(akBaseItem)
			
			ElseIf akBaseItem as Potion
				If !akBaseItem.HasKeyword(MME_Milk)
					If akBaseItem.HasKeyword(VendorItemFood)
						If !_MA_LactacidFoods.HasForm(akBaseItem)
							_MA_AddictSellListFood.AddForm(akBaseItem)
						EndIf
					Else
						_MA_AddictSellListPotions.AddForm(akBaseItem)
					EndIf
				EndIf
			
			ElseIf akBaseItem.HasKeyword(VendorItemGem)
				_MA_AddictSellListGems.AddForm(akBaseItem)
			
			ElseIf akBaseItem.HasKeyword(VendorItemJewelry)
				_MA_AddictSellListJewelry.AddForm(akBaseItem)
			EndIf
		EndIf
	EndWhile
	AddictContainerState = 2
	;Debug.Messagebox("Finished sorting inventory")
EndFunction

Formlist Property _MA_LactacidFoods Auto

Formlist Property _MA_AddictSellList Auto
Formlist Property _MA_AddictSellListClothing Auto
Formlist Property _MA_AddictSellListArmorWeapons Auto
Formlist Property _MA_AddictSellListPotions Auto
Formlist Property _MA_AddictSellListFood Auto
Formlist Property _MA_AddictSellListGems Auto
Formlist Property _MA_AddictSellListIngredients Auto
Formlist Property _MA_AddictSellListJewelry Auto

Keyword Property ArmorClothing Auto
Keyword Property VendorItemArmor Auto
Keyword Property VendorItemWeapon Auto
Keyword Property VendorItemPotion Auto
Keyword Property VendorItemFood Auto
Keyword Property MME_Milk Auto
Keyword Property VendorItemGem Auto
Keyword Property VendorItemJewelry Auto
Keyword Property SexLabNoStrip Auto

Actor Property PlayerRef Auto