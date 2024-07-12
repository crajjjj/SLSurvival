
Scriptname _Dtrick extends ObjectReference  

Armor Property deviceRendered Auto			
Armor Property deviceInventory Auto
Armor Property This Auto	
Zadlibs Property libs Auto
Message Property CurseMSG Auto
int temp = -1 

Event OnEquipped(Actor akActor)
	While UI.IsMenuOpen("InventoryMenu")  || UI.IsMenuOpen("ContainerMenu")
		Utility.wait(4)
	Endwhile
	if (akActor == libs.playerref) 
		
		Armor a = libs.PlayerRef.GetWornForm(0x00000002) as Armor
		Armor b = libs.PlayerRef.GetWornForm(0x00000004) as Armor
		Armor c = libs.PlayerRef.GetWornForm(0x00000008) as Armor
		Armor d = libs.PlayerRef.GetWornForm(0x00000080) as Armor


		If !a.HasKeyword(libs.zad_Lockable)
			libs.PlayerRef.RemoveItem(a, abSilent = True)
		endif

		If !c.HasKeyword(libs.zad_Lockable)
			libs.PlayerRef.RemoveItem(c,abSilent = True)
		endif

		If !d.HasKeyword(libs.zad_Lockable)
			libs.PlayerRef.RemoveItem(d,abSilent = True)
		endif

		If !b.HasKeyword(libs.zad_Lockable)
			libs.PlayerRef.RemoveItem(b,abSilent = True)
		endif
		libs.equipDevice(akActor, deviceInventory , deviceRendered, libs.zad_DeviousHeavyBondage, skipevents = false, skipmutex = true)
		Utility.wait(4)
		CurseMSG.show()
	endif
EndEvent