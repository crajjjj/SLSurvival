Scriptname aaaKNNVendorQuestScript extends Quest  

Potion Property towelPotion  Auto
GlobalVariable Property nextSellTowelTime  Auto
GlobalVariable Property SellTowelInterval  Auto
FormList Property aaaKNNVanillaWaterList Auto
GlobalVariable Property nextSellWaterTime  Auto
GlobalVariable Property SellWaterInterval  Auto
GlobalVariable Property _KNNAddedTowelMax Auto
GlobalVariable Property _KNNAddedTowelMin Auto
GlobalVariable Property _KNNAddedWaterBottleMax Auto
GlobalVariable Property _KNNAddedWaterBottleMin Auto

Function AddTowelPotion(Actor thisActor)
	int count = Utility.RandomInt(_KNNAddedTowelMin.GetValueInt(), _KNNAddedTowelMax.GetValueInt())
	if 0 < count
		thisActor.AddItem(towelPotion, count, true)
		nextSellTowelTime.SetValue(Utility.GetCurrentGameTime() + SellTowelInterval.GetValue())
	endIf
EndFunction

Function AddWaterBottle(Actor thisActor)
	int listSize = aaaKNNVanillaWaterList.GetSize()
	int startIndex = 0
	while startIndex < listSize
		int count = Utility.RandomInt(_KNNAddedWaterBottleMin.GetValueInt(), _KNNAddedWaterBottleMax.GetValueInt())
		if 0 < count
			Form waterBottle = aaaKNNVanillaWaterList.GetAt(startIndex)
			thisActor.AddItem(waterBottle, count, true)
		endIf
		startIndex += 1
	endWhile
	nextSellWaterTime.SetValue(Utility.GetCurrentGameTime() + SellWaterInterval.GetValue())
EndFunction