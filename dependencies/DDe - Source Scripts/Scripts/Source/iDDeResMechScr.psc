ScriptName iDDeResMechScr Extends zadEquipScript

Keyword[] Function GetDefEquipConflictingDevices()
	Keyword[] kws = NEW Keyword[10]
		kws[0] = libs.zad_DeviousArmbinder
		kws[1] = libs.zad_DeviousArmbinderElbow
		kws[2] = libs.zad_DeviousPetSuit
		kws[3] = libs.zad_DeviousBra
		kws[4] = libs.zad_DeviousArmCuffs
		kws[5] = libs.zad_DeviousHobbleSkirt
		kws[6] = libs.zad_DeviousStraitJacket
		kws[7] = libs.zad_DeviousGloves
		kws[8] = libs.zad_DeviousPetSuit
		kws[9] = libs.zad_DeviousBoots
	RETURN kws
EndFunction

Message Property iDDe_MechEqpMsg Auto
Message Property iDDe_MechUnEqpMsg Auto

Keyword Property iSUmKwdTypeMech Auto

Function SetDefaults()
	If (EquipConflictingDevices.Length < 1)
		EquipConflictingDevices = GetDefEquipConflictingDevices()
	EndIf
	NumberOfKeysNeeded = 2	
	If (!LockAccessDifficulty)
		LockAccessDifficulty = 33.3
	EndIf
	If (!KeyBreakChance)
		KeyBreakChance = 16.6
	EndIf
	If (!LockJamChance)
		LockJamChance = 6.6
	EndIf
	If (!BaseEscapeChance)
		BaseEscapeChance = 11.1
	EndIf
EndFunction

Event OnEquipped(Actor akActor)
	SetDefaults()
	Parent.OnEquipped(akActor)
EndEvent
	
INT Function OnEquippedFilter(actor akActor, bool silent=false)
	If (!akActor.IsEquipped(deviceRendered))
		If ((akActor != libs.PlayerRef) && ShouldEquipSilently(akActor))
			libs.Log("Avoiding FTM duplication bug (Mech).")
			RETURN 0
		EndIf
		If (IsEquipDeviceConflict(akActor))
			RETURN 2
		EndIf	
	EndIf
	If ((akActor != libs.PlayerRef) || silent)
		RETURN 0 ;Proceed.
	EndIf
		INT	iChoose = iDDe_MechEqpMsg.Show() ;Display menu
			If (iChoose == 0) ;Cancel
				RETURN 2
			ElseIf (iChoose == 1) ;Equip Device voluntarily
				UI.InvokeString("InventoryMenu", "_global.skse.CloseMenu", "InventoryMenu")
				RETURN 0
			EndIf
	libs.Error("Invalid menu option selected for Mech script.")
	RETURN Parent.OnEquippedFilter(akActor, silent)
EndFunction
Function OnEquippedPre(actor akActor, bool silent=false)
	If (!silent)
		libs.NotifyPlayer("Trembling, you step into the " +deviceName+ ", and it immediately takes over your body.", True)	
	EndIf
	Parent.OnEquippedPre(akActor, silent)
EndFunction
Function OnEquippedPost(actor akActor)
	akActor.UnEquipItemSlot(36) ; Unequip ring to avoid clipping
	Parent.OnEquippedPost(akActor)
EndFunction

Function DeviceMenu(Int msgChoice = 0)
	If (StorageUtil.GetIntValue(libs.PlayerRef, "iDDeResMechBusy", 0))
		libs.notify(deviceName+ " is busy. Try again later!", True)
	Else
		If (libs.PlayerRef.IsEquipped(deviceRendered) || libs.PlayerRef.IsEquipped(deviceInventory))
	  	msgChoice = iDDe_MechUnEqpMsg.Show()
			If (msgChoice == 0) ; Cancel
			ElseIf (msgChoice == 1)	; Remove device, with key
				UI.InvokeString("InventoryMenu", "_global.skse.CloseMenu", "InventoryMenu")
				DeviceMenuRemoveWithKey()
			ElseIf (msgChoice == 2) ; Remove device, without key
				UI.InvokeString("InventoryMenu", "_global.skse.CloseMenu", "InventoryMenu")
				DeviceMenuRemoveWithoutKey()
			EndIf
		EndIf
	EndIf
	DeviceMenuExt(msgChoice)	
	SyncInventory()
EndFunction
Function DeviceMenuEquip()
  EquipDevice(libs.PlayerRef)
	libs.NotifyPlayer("Trembling, you step into the " +deviceName+ ", and it immediately takes over your body.", True)	
EndFunction
Function DeviceMenuRemoveWithKey()
  If (!IsUnEquipDeviceConflict(libs.PlayerRef) && RemoveDeviceWithKey())
		libs.NotifyPlayer("You succesfully unlock the " +deviceName+", and it reluctantly releases you.", True)
	Else
		libs.NotifyPlayer("The " +deviceName+" seems to mock you, 'Nice try!' and turns the vibrators inside you to full power to keep your mind preocupied!", True)
		PunisHer(libs.PlayerRef, 5, 77)
	Endif
EndFunction
Function DeviceMenuRemoveWithoutKey()
	If (IsUnEquipDeviceConflict(libs.PlayerRef))
		RETURN
	Endif
		INT deviceRemoveOption = zad_DeviceRemoveMsg.show()
			If (deviceRemoveOption == 0) ; Lockpicking
	      If (!CheckLockShield())
	        RETURN
	      EndIf
				DeviceMenuPickLock()
			ElseIf (deviceRemoveOption == 1) ; Magicking
				DeviceMenuMagic()
			ElseIf (deviceRemoveOption == 2) ; Brute force
				DeviceMenuBruteForce()
			ElseIf (deviceRemoveOption == 3)
				DeviceMenuCarryOn()
			EndIf
EndFunction
Function DeviceMenuPickLock()
	libs.notify("The " +deviceName+ " won't allow you to use a lockpick on it and turns the vibrators inside you to full power to keep your mind off such things!", True)
	PunisHer(libs.PlayerRef, 5, 77)
EndFunction
Function DeviceMenuMagic()
	libs.notify("The " +deviceName+ " won't allow you to use magic on it and turns the vibrators inside you to full power!", True)
	PunisHer(libs.PlayerRef, 5, 77)
EndFunction
Function DeviceMenuBruteForce()
  libs.notify("With your arms secured tightly behind your back, the " +deviceName+ " ignores your desire to be released. Instead, it turns the plugs inside you on.", True)
	PunisHer(libs.PlayerRef, 4)
EndFunction
Function DeviceMenuCarryOn()
	libs.notify("The " +deviceName+ " senses your desire for freedom and starts using the vibrators inside you to tease you into submission.", True)
	PunisHer(libs.PlayerRef, 1, 100)
EndFunction

INT Function OnContainerChangedFilter(ObjectReference akNewContainer, ObjectReference akOldContainer)
	If (!akNewContainer && akOldContainer && deviceRendered.HasKeyword(iSUmKwdTypeMech))
		Actor akActor = (akOldContainer AS Actor)
			If (!akActor.IsEquipped(deviceInventory) && !akActor.IsEquipped(deviceRendered))
				libs.Log(deviceName+ " dropped.")
				Self.Delete()
				RETURN 1
			EndIf
	EndIf
	RETURN Parent.OnContainerChangedFilter(akNewContainer, akOldContainer)
EndFunction

INT Function PunisHer(Actor aSlave, INT iPower = 5, INT iDuration = 66)
	INT iReturn = 0
		StorageUtil.SetIntValue(aSlave, "iDDeResMechBusy", 1)
		Utility.Wait(0.1) ;for menus to close
		libs.ShockActor(aSlave)
		libs.AttrDrain(aSlave, "Health")
		libs.AttrDrain(aSlave, "Magicka")
		libs.AttrDrain(aSlave, "Stamina")
		iReturn = libs.VibrateEffect(aSlave, iPower, iDuration, False, False)
		libs.ShockActor(aSlave)
		libs.AttrDrain(aSlave, "Health")
		libs.AttrDrain(aSlave, "Magicka")
		libs.AttrDrain(aSlave, "Stamina")
		libs.ShockActor(aSlave)
		libs.ActorOrgasm(aSlave, 7, -1)
		libs.ShockActor(aSlave)
		Utility.Wait(7.7)
		;libs.StopVibrating(akSlave)
		StorageUtil.UnSetIntValue(aSlave, "iDDeResMechBusy")
		libs.Log("iDDeResMechScr.PunisHer():-> Done, returned " +iReturn+ ".")
	RETURN iReturn
EndFunction
