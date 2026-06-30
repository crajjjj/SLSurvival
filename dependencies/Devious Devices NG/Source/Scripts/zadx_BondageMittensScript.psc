Scriptname zadx_BondageMittensScript extends zadRestraintScript

Float Property KeyInsertSuccessfullyChance = 20.0 Auto      ; Chance to successfully insert a key and open the lock.
Float Property KeyLostonFailureChance = 20.0 Auto           ; Chance that the key will get destroyed/lost on failed unlock attempts.

Function DeviceMenu(Int msgChoice = 0)
    msgChoice = zad_DeviceMsg.Show() ; display menu
    if msgChoice == 0 ; Equip Device voluntarily
        DeviceMenuEquip()
    elseif msgChoice == 1    ; Remove device, with key
        If StorageUtil.GetIntValue(libs.playerref, "zad_Equipped" + libs.LookupDeviceType(zad_DeviousDevice) + "_ManipulatedStatus") == 1
            ; Device is manipulated. Remove it without doing anything with keys
            libs.Notify("As you have manipulated the " + deviceName + ", you are able to slip out of the device with ease!", messageBox = True)
            StorageUtil.SetIntValue(libs.playerref, "zad_UntightenToken" + deviceInventory, 1)
            RemoveDevice(libs.playerref)
            Return
        ElseIf CheckLockAccess() ; Check for cooldown and lock access *before* key drop check.
            If Utility.RandomFloat(0.0, 99.9) < KeyInsertSuccessfullyChance
                libs.Notify("With a lot of patience and a little luck you manage to insert the key into the lock and turn it.", messagebox = true)
                ; Calling CheckLockAccess resets the "tired" unlock cooldown.
                ; DeviceMenuRemoveWithKey then *also* checks it and will think it's on cooldown...
                ; As an ugly workaround, we remove the cooldown temporarily, then put it back.
                ; This can be removed if the core logic in zadEquipScript is ever cleaned up.
                float cd = UnlockCooldown
                UnlockCooldown = -1.0
                DeviceMenuRemoveWithKey() ; <- This can still prevent unlock by e.g. lock shields, wrong key, etc.
                UnlockCooldown = cd
            else
                if Utility.RandomFloat(0.0, 99.9) < KeyLostonFailureChance
                    libs.Notify("You try to insert the key into the lock, but it slips away and falls to the ground. You can't find it anywhere.", messagebox = true)
                    libs.playerref.RemoveItem(devicekey, 1)
                Else
                    libs.Notify("You try to insert the key into the lock, but it slips away and falls to the ground. Maybe you can pick it up again?", messagebox = true)
                    libs.playerref.DropObject(devicekey, 1)
                Endif
                return
            EndIf
        endif
    elseif msgChoice == 2 ; Remove device, without key
        DeviceMenuRemoveWithoutKey()
    endif
    DeviceMenuExt(msgChoice)
EndFunction

Function OnEquippedPre(actor akActor, bool silent=false)
    string msg = ""
    if akActor == libs.PlayerRef
        msg = "You slip your hands into the bondage mittens and press the locks shut. You won't be able to use your hands while locked in them."
    Else
        msg = "You slip "+GetMessageName(akActor)+"'s hands into the bondage mittens and press the locks shut."
    EndIf
    if !silent
        libs.NotifyActor(msg, akActor, true)
    EndIf
    Parent.OnEquippedPre(akActor, silent)
EndFunction