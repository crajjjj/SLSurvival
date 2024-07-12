Scriptname _SLS_LostFoundAlias extends ReferenceAlias  

Function Setup(ObjectReference ObjRef)
	Self.ForceRefTo(ObjRef)
	ObjRef.BlockActivation(abBlocked = True)
EndFunction

Event OnActivate(ObjectReference akActionRef)
	ObjectReference ObjRef = Self.GetReference()	
	If akActionRef == LostFound.PlayerRef
		LostFound.PlayerRef.AddItem(Self.GetReference())
		Form akBaseItem = ObjRef.GetBaseObject()
		If LostFound.PlayerRef.IsInCombat()
			If akBaseItem as Weapon || (akBaseItem as Armor && (akBaseItem as Armor).IsShield())
				ReEquipItem(ObjRef, akBaseItem)
			EndIf			
		Else
			ReEquipItem(ObjRef, akBaseItem)
		EndIf
		ObjectReference TrigRef = StorageUtil.GetFormValue(ObjRef, "_SLS_DroppedItemTriggerRef") as ObjectReference
		If TrigRef
			(TrigRef as _SLS_DroppedItemTrigger).PickedUp(ObjRef)
		EndIf
		StorageUtil.UnSetFormValue(ObjRef, "_SLS_DroppedItemTriggerRef")
		ClearAlias()
		LostFound.UpdateLostCount()
	EndIf
EndEvent

Function ClearAlias()
	Self.GetReference().BlockActivation(false)
	Self.Clear()
EndFunction

Function ReEquipItem(ObjectReference ObjRef, Form akBaseItem)
	If akBaseItem as Weapon 
		If LostFound.PlayerRef.GetEquippedWeapon(abLeftHand = false) == None ; Was not replaced before now
			LostFound.PlayerRef.EquipItemEx(akBaseItem, equipSlot = 1, preventUnequip = false, equipSound = true)
		EndIf
	Else
		Form akForm = LostFound.PlayerRef.GetWornForm((akBaseItem as Armor).GetSlotMask())
		If !akForm || (akForm && !akForm.GetName()) ; If the PC is wearing something already or that item is hidden
		;Debug.Messagebox(LostFound.PlayerRef.GetWornForm((akBaseItem as Armor).GetSlotMask()))
			;If LostFound.PlayerRef.GetWornForm((akBaseItem as Armor).GetSlotMask()) == None ; Was not replaced before now
				LostFound.PlayerRef.EquipItemEx(akBaseItem, equipSlot = 0, preventUnequip = false, equipSound = true)
			;EndIf
		EndIf
	EndIf
EndFunction

_SLS_LostFound Property LostFound Auto
