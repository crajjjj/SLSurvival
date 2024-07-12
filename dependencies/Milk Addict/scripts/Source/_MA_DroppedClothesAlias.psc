Scriptname _MA_DroppedClothesAlias extends ReferenceAlias  

; EquipItem does not apply player created enchantments. Way to go Bethesda. Use EquipItemEx instead.

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	If akNewContainer == PlayerRef
	
		; If player is not in combat and the slot is not already occupied -> automatically reequip dropped item
		If !PlayerRef.IsInCombat() && !SexLab.IsActorActive(PlayerRef)
			Armor DroppedItem = Self.GetReference().GetBaseObject() as Armor
			int SlotMask = (DroppedItem as Armor).GetSlotMask()
			
			Armor EquippedArmor
			; Body
			If Math.LogicalAnd(4, SlotMask) == 4
				EquippedArmor = PlayerRef.GetWornForm(4) as Armor
				If EquippedArmor == None || !EquippedArmor.IsPlayable() || StringUtil.Find(EquippedArmor.GetName(), "Nails ") == -1
					PlayerRef.EquipItemEx(DroppedItem, 0, preventUnequip = false, equipSound = true)
				EndIf
				
			; Hands
			ElseIf Math.LogicalAnd(8, SlotMask) == 8
				EquippedArmor = PlayerRef.GetWornForm(8) as Armor
				If EquippedArmor == None || !EquippedArmor.IsPlayable() || StringUtil.Find(EquippedArmor.GetName(), "Nails ") == -1
					PlayerRef.EquipItemEx(DroppedItem, 0, preventUnequip = false, equipSound = true)
				EndIf
				
			; Feet
			ElseIf Math.LogicalAnd(128, SlotMask) == 128
				EquippedArmor = PlayerRef.GetWornForm(128) as Armor
				If EquippedArmor == None || !EquippedArmor.IsPlayable() || StringUtil.Find(EquippedArmor.GetName(), "Nails ") == -1
					PlayerRef.EquipItemEx(DroppedItem, 0, preventUnequip = false, equipSound = true)
				EndIf
				
			; Hair
			ElseIf Math.LogicalAnd(2, SlotMask) == 2
				EquippedArmor = PlayerRef.GetWornForm(2) as Armor
				If EquippedArmor == None || !EquippedArmor.IsPlayable() || StringUtil.Find(EquippedArmor.GetName(), "Nails ") == -1
					PlayerRef.EquipItemEx(DroppedItem, 0, preventUnequip = false, equipSound = true)
				EndIf
			EndIf
		EndIf
		Self.Clear()
	EndIf
EndEvent

Actor Property PlayerRef Auto

SexLabFramework Property SexLab Auto