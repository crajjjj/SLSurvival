Scriptname sr_QSTBeltScript extends zadBeltScript

Function DeviceMenu(Int msgChoice = 0)
    msgChoice = zad_DeviceMsg.Show() ; display menu
	if msgChoice == 0 ; Equip Device voluntarily
		DeviceMenuEquip()
	elseif msgChoice == 1	; Remove device, with key
		DeviceMenuRemoveWithKey()
	;	libs.Notify("The key is too big for the keyhole, making the belt seemingly impossible to open.", messageBox=true)
	elseif msgChoice == 2 ; Remove device, without key
		DeviceMenuRemoveWithoutKey()
	endif
	DeviceMenuExt(msgChoice)	
	SyncInventory()
EndFunction

Function DeviceMenuRemoveWithoutKey()
    int deviceRemoveOption = zad_DeviceRemoveMsg.show()
    if deviceRemoveOption == 0 ; Lockpicking
	;	DeviceMenuPickLock()
		libs.Notify("The " + deviceInventory.GetName() + " has a custom lock that can't be picked.", messageBox=true)
	elseif deviceRemoveOption == 1 ; Magicking
	;	DeviceMenuMagic()
		if libs.PlayerRef.GetAv("Magicka")<50
			libs.Notify("Your mental reserves are far too drained to attempt this task.", true)
		else
			libs.PlayerRef.DamageAV("Magicka", 50)
			libs.Notify("You flood the "+deviceInventory.GetName()+" with arcane energies, but everything you cast gets absorbed by the " + deviceName + ".", messageBox=true)
		endif
	elseif deviceRemoveOption == 2 ; Brute force
		DeviceMenuBruteForce()
	elseif deviceRemoveOption == 3
        DeviceMenuCarryOn()
    endif
EndFunction