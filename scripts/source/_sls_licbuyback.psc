Scriptname _SLS_LicBuyBack extends ReferenceAlias  

Event OnInit()
	RegisterForMenu("BarterMenu")
	AddInventoryEventFilter(Gold001)
EndEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	_SLS_LicenceConfiscationsShopChest.RemoveItem(Gold001, _SLS_LicenceConfiscationsShopChest.GetItemCount(Gold001))
EndEvent

Event OnMenuClose(String MenuName)
	Quest MyQuest = Self.GetOwningQuest()
	_SLS_LicenceConfiscationsShopChest.RemoveAllItems(akTransferTo = (MyQuest.GetNthAlias(1) as ReferenceAlias).GetReference(), abKeepOwnership = true, abRemoveQuestItems = true)
	LicUtil.ModBuyBackDiscountPerk(AddPerkToPlayer = false)
	MyQuest.Stop()
EndEvent

ObjectReference Property _SLS_LicenceConfiscationsShopChest Auto

MiscObject Property Gold001 Auto

_SLS_LicenceUtil Property LicUtil Auto
