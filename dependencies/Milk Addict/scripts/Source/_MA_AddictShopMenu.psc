Scriptname _MA_AddictShopMenu extends ReferenceAlias  

Event OnInit()
	RegisterForMenu("BarterMenu")
	AddInventoryEventFilter(_MA_InventoryFilterBlocker as Form)
	AddictedQuest.PlayerLoadsGame()
EndEvent

Event OnPlayerLoadGame()
	RegisterForMenu("BarterMenu")
	AddictedQuest.PlayerLoadsGame()
EndEvent

Event OnMenuOpen(String MenuName)
	Debug.Trace("_MA_: Shop Menu")
	RemoveAllInventoryEventFilters()
	AddInventoryEventFilter(Gold001 as Form)
	SendBeginSortInvEvent()
	;ObjectReference ShopGuy = Game.GetCurrentCrosshairRef() as Actor
	;PrepareSellList(ShopGuy as Actor)
EndEvent

Event OnMenuClose(String MenuName)
	RemoveAllInventoryEventFilters()
	AddInventoryEventFilter(_MA_InventoryFilterBlocker as Form)
EndEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	TryAutoAction(akSourceContainer)
EndEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	TryAutoAction(akDestContainer)
EndEvent

Function TryAutoAction(ObjectReference TargetContainer)
	If TargetContainer != None
		If TargetContainer.GetBaseObject() as Container
			If ScanForMilk(TargetContainer)
				Debug.Trace("_MA_: _MA_AddictShopMenu: Begin")
				If Init.ClearToTryAutoAction()
					
					RemoveAllInventoryEventFilters()
					AddInventoryEventFilter(_MA_InventoryFilterBlocker as Form)
					_MA_AddictSoldList.Revert()
					Debug.Trace("_MA_: _MA_AddictShopMenu: Caved in")

					_MA_AddictItemAddedQuest.Stop()
					_MA_AddictContainerQuest.Stop()
					ShopContainer.ForceRefTo(TargetContainer)
					_MA_AddictContainerQuest.Start()
					SendBuildSellListEvent()

					Form MilkSelect
					Bool FirstTime = true
					Int CostTotal = 0
					While _MA_AddictBuyList.GetSize() > 0 || FirstTime;) && (Main.AutoActionChance > Utility.RandomFloat(0.0, 100.0) 
						FirstTime = false
						MilkSelect = _MA_AddictBuyList.GetAt(Utility.RandomInt(0, (_MA_AddictBuyList.GetSize() - 1)))
						Int GoldValue = GetAdjustedBuyPrice(MilkSelect)
						
						While !BuyMilk(MilkSelect, GoldValue, TargetContainer) && _MA_AddictBuyList.GetSize() > 0
							MilkSelect = _MA_AddictBuyList.GetAt(Utility.RandomInt(0, (_MA_AddictBuyList.GetSize() - 1)))
							GoldValue = GetAdjustedBuyPrice(MilkSelect)
						EndWhile
						
						If MilkSelect != None
							If PlayerRef.GetItemCount(Gold001) < GoldValue
								SellToBuyMilk(GoldValue, TargetContainer)
							EndIf
							CostTotal += GoldValue
						EndIf
					EndWhile
					PlayerRef.RemoveItem(Gold001, CostTotal, false, TargetContainer)
					If _MA_AddictSoldList.GetSize() > 0
						Int i = 0
						String WhatISold = "You sold the following items to pay for milk: "
						While i < _MA_AddictSoldList.GetSize() - 1
							WhatISold += "\n" + (i + 1) + ") " + _MA_AddictSoldList.GetAt(i).GetName()
							i += 1
						EndWhile
						Debug.Messagebox(WhatISold)
					EndIf
					;_MA_AddictContainerQuest.Start()
					_MA_AddictItemAddedQuest.Start()
					
					RemoveAllInventoryEventFilters()
					AddInventoryEventFilter(_MA_InventoryFilterBlocker as Form)
					Input.TapKey(15)
					;AddictedQuest.ResetVariables()
					Debug.Notification("You can't help yourself")
					If !PlayerRef.HasMagicEffect(_MA_fortifyspeed)
						PlayerRef.EquipItem(MilkSelect)
					EndIf
					
				Else
					Debug.Trace("_MA_: _MA_AddictShopMenu: Resisted")
					RemoveAllInventoryEventFilters()
					AddInventoryEventFilter(_MA_InventoryFilterBlocker as Form)
				EndIf
			EndIf
		EndIf
	EndIf
EndFunction

Int Function GetAdjustedBuyPrice(Form MilkSelect) ; https://en.uesp.net/wiki/Skyrim:Speech
	Float SpeechSkill = PlayerRef.GetActorValue("Speechcraft")
	If SpeechSkill > 100
		SpeechSkill = 100
	EndIf
	Float JunkieFactor = 1.20
	Float fBarterMin = Game.GetGameSettingFloat("fBarterMin")
	Float fBarterMax = Game.GetGameSettingFloat("fBarterMax")
	Float PriceFactor = fBarterMax - (fBarterMax - fBarterMin) * (SpeechSkill/100)
	
	Int FinalPrice =  Math.Ceiling(JunkieFactor * MilkSelect.GetGoldValue() * 0.91 * PriceFactor)
	;Debug.Trace("_MA_: _MA_AddictShopMenu: Buy Price for " + MilkSelect.GetName() + ": " + FinalPrice)
	Return FinalPrice
EndFunction

Int Function GetAdjustedSellPrice(Form ObjectSelect) ; https://en.uesp.net/wiki/Skyrim:Speech
	Float SpeechSkill = PlayerRef.GetActorValue("Speechcraft")
	If SpeechSkill > 100
		SpeechSkill = 100
	EndIf
	Float JunkieFactor = 0.80
	Float fBarterMin = Game.GetGameSettingFloat("fBarterMin")
	Float fBarterMax = Game.GetGameSettingFloat("fBarterMax")
	Float PriceFactor = fBarterMax - (fBarterMax - fBarterMin) * (SpeechSkill/100)
	
	Int FinalPrice = Math.Ceiling(JunkieFactor * ObjectSelect.GetGoldValue() * 1.1 / PriceFactor)
	;Debug.Trace("_MA_: _MA_AddictShopMenu: Sell Price for " + ObjectSelect.GetName() + ": " + FinalPrice)
	Return FinalPrice
EndFunction

Bool Function BuyMilk(Form MilkSelect, Int GoldValue, ObjectReference TargetContainer)
	Debug.Trace("_MA_: _MA_AddictShopMenu: Bought: " + MilkSelect.GetName())
	Int MilkCountBefore = PlayerRef.GetItemCount(MilkSelect)
	TargetContainer.RemoveItem(MilkSelect, 1, true, PlayerRef)
	If PlayerRef.GetItemcount(MilkSelect) > MilkCountBefore ; Need to check milk object count on the player because calling GetItemCount on containers with leveledlists is (:shocked face:) unreliable...
		Return true
	Else
		_MA_AddictBuyList.RemoveAddedForm(MilkSelect)
		Return false
	EndIf
	
EndFunction

Function SellToBuyMilk(Int GoldValue, ObjectReference TargetContainer)
	While AddictedQuest.AddictContainerState != 3
		Utility.WaitMenuMode(0.2)
	EndWhile
	If _MA_AddictSellList.GetSize() > 0
		Form ObjectSelect
		Formlist FlSelect
		Int ObjectValue
		While PlayerRef.GetItemCount(Gold001) < GoldValue && _MA_AddictSellList.GetSize() > 0
			FlSelect = _MA_AddictSellList.GetAt(Utility.RandomInt(0, (_MA_AddictSellList.GetSize() - 1))) as Formlist
			ObjectSelect = FlSelect.GetAt(Utility.RandomInt(0, (_MA_AddictSellList.GetSize() - 1)))
			If ObjectSelect
				Debug.Trace("_MA_: _MA_AddictShopMenu: Sold: " + ObjectSelect.GetName())
				ObjectValue = GetAdjustedSellPrice(ObjectSelect)
				PlayerRef.AddItem(Gold001, ObjectValue, abSilent = true)
				PlayerRef.RemoveItem(ObjectSelect, 1, true, TargetContainer)
				_MA_AddictSoldList.AddForm(ObjectSelect)
				If PlayerRef.GetItemCount(ObjectSelect) == 0
					FlSelect.RemoveAddedForm(ObjectSelect)
					If FlSelect.GetSize() == 0
						_MA_AddictSellList.RemoveAddedForm(FlSelect)
					EndIf
				EndIf
			Else
				_MA_AddictSellList.RemoveAddedForm(FlSelect)
			EndIf
		EndWhile
	EndIf
EndFunction

Bool Function ScanForMilk(ObjectReference TargetContainer)
	_MA_AddictBuyList.Revert()
	Int i = TargetContainer.GetNumItems()
	Form akBaseItem
	While i > 0
		i -= 1
		akBaseItem = TargetContainer.GetNthForm(i)
		If akBaseItem as Potion
			If akBaseItem.HasKeyword(MME_Milk)
				_MA_AddictBuyList.AddForm(akBaseItem)
				Debug.Trace("_MA_: _MA_AddictShopMenu: ScanForMilk - Added " + akBaseItem.GetName() + " to _MA_AddictBuyList")
			EndIf
		EndIf
	EndWhile
	If _MA_AddictBuyList.GetSize() > 0
		Return true
	Else
		Return false
	EndIf
EndFunction

Function SendBeginSortInvEvent() ; Thread off sorting of player inventory so this script can continue to be run
	Int SortInvEvent = ModEvent.Create("_MA_BeginSortPlayerInventory")
	If (SortInvEvent)
		ModEvent.Send(SortInvEvent)
	EndIf
EndFunction

Function SendBuildSellListEvent()
	Int BuildSellList = ModEvent.Create("_MA_BuildSellList") ; Thread off creation of the sell list so this script can continue to be run
	If (BuildSellList)
		ModEvent.Send(BuildSellList)
	EndIf
EndFunction

Armor Property _MA_InventoryFilterBlocker Auto

MiscObject Property Gold001 Auto

Faction Property JobApothecaryFaction Auto
Faction Property JobInnkeeperFaction Auto
Faction Property JobMiscFaction Auto
Faction Property CaravanMerchant Auto
Faction Property JobBlacksmithFaction Auto

Formlist Property _MA_AddictBuyList Auto
Formlist Property _MA_AddictSellList Auto
Formlist Property _MA_AddictSoldList Auto

MagicEffect Property _MA_fortifyspeed Auto

Actor Property PlayerRef Auto

Keyword Property MME_Milk Auto
Keyword Property VendorItemFood Auto
Keyword Property VendorItemFoodRaw Auto

Quest Property _MA_AddictItemAddedQuest Auto
Quest Property _MA_AddictContainerQuest Auto

ReferenceAlias Property ShopContainer Auto

_MA_AddictContainerQuestScript Property AddictedQuest Auto
_MA_Init Property Init Auto
_MA_Main Property Main Auto
