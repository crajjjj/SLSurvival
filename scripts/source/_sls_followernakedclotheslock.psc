Scriptname _SLS_FollowerNakedClothesLock extends ReferenceAlias  

_SLS_LicenceUtil Property LicUtil Auto

Actor Property PlayerRef Auto
MiscObject Property _SLS_NeverAddedItem Auto

Bool DoInventoryCheck = false

Event OnInit()
	RegisterForMenu("ContainerMenu")
	AddInventoryEventFilter(_SLS_NeverAddedItem)
	RegisterForSingleUpdateGameTime(24.0)
EndEvent

Event OnUpdateGameTime()
	Self.GetOwningQuest().Stop()
EndEvent

Event OnMenuOpen(String MenuName)
	RemoveAllInventoryEventFilters()
EndEvent

Event OnMenuClose(String MenuName)
	AddInventoryEventFilter(_SLS_NeverAddedItem)
	If DoInventoryCheck
		DoClothesCheck()
	EndIf
EndEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	If akBaseItem as Armor
		If akDestContainer == PlayerRef
			AddInventoryEventFilter(_SLS_NeverAddedItem)
			DoInventoryCheck = true
		EndIf
	EndIf
EndEvent

Function DoClothesCheck()
	DoInventoryCheck = false
	Actor Follower = Self.GetReference() as Actor
	If Follower
		If Follower.GetWornForm(0x00000004) == None
			Form PlayerClothes = LicUtil.HasBodyClothes(PlayerRef)
			If PlayerClothes != None
				PlayerRef.RemoveItem(PlayerClothes, 1, false, Follower)
				Debug.Notification(Follower.GetBaseObject().GetName() + ": Unh unh baby. That's mine. Get your own.")
			EndIf
		EndIf
	EndIf
EndFunction
