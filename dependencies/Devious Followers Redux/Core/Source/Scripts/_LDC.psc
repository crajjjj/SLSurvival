Scriptname _LDC extends Quest  Conditional

zadxlibs2 Property xlibs2 auto
zadxlibs Property xlibs auto
zadlibs Property libs auto
Bool JsonBuilt 
Bool StorUtilBuilt
String File = "../Lozeak Device Controller/Device Settings.json"
String Version 
String DDVersion
String DDxVersion
Float SetTimer

;/ Welcome to Lozeak's Device Controller
Mods that uses this script!!!!
Devious followers 2.0+

Link to support page! 
None! (will when add when I officially release this!)

What is this...

A Cross mod random device equipper and adder for modders and User that does not require a esp
Benefits- No need for modder to make a item randomizer just use this script and your done!
User can control it via the Json and the settings will be global (cross save)
Can add, additional items to this from other sources and other mods will use them.
For example say cool dude 64 makes the best cuffs ever and he create a script to add them to this Device Controller then all mod that use this script will use them!

Basic use... for Users
If you delete a device in ../Lozeak Device Controller/Device Settings.json it will never be used.
If you delete a set in ../Lozeak Device Controller/Device Settings.json it will never be used.
If you delete Delete This To Rebuild Item List in Delete This To Rebuild Item List in ../Lozeak Device Controller/Device Settings.json the next time init() is used it will rebuild this list (AKA start a new game and wait! if the modder has used init() correctly

Basic use... for Modders!
Put this in your mod, make sure the property's are filled in the CK and use the functions.
Init() this script before using will save time it only needs to be init() once per game but it can work with out this. On first use user may experience delay.

Device manipulation Functions! All of these just need a keyword to work but if you send a actor it will use them instead of the player.
EquipDeviceByKeyword.. You can equip a item to player by sending just a keyword e.g EquipDeviceByKeyword(libs.zad_DeviousArmCuffs)

EquipDeviceByKeywordNoneSet will do the same but ignore sets

AddDeviceByKeyword and AddDeviceByKeywordNoneSet work the same but just give the item to the player/actor rather than equip.

RemoveDeviceByKeyword as above but will remove item if it's a Generic Device all over devices will not be handled by this script

UnequipAll this will remove all generic devices. 

There are AndDestory versions of some commands will destroy device at same time.

Advanced use.

Once mod has finished building it's init() it will SendModEvent("LDCAddExtraDevices")
Using this script you can add devices to the random list use RegisterAddtionalDeviceByKw(YourDevice, "Unique mod name")
Then RegisterAddtionalSets("Dark Blue", "Unique mod name")
Once you have added all your items use 
CompletedAddingAddtionalContent("Unique mod name")

Once this is done all mods that use this script even if it's on there own quest will use your items.
User can delete them from the list.

Of course no mod uses this script YET... Devious Followers will in 2.0

Permissions
Do anything you want with this without crediting me or anything but it uses DDs so you'll have to follow permissions for that!

ponzipyramid [9/11/23]
all funcs: 
used funcs are EquipDeviceByKeyword, AddDeviceByKeyword, RemoveDeviceByKeyword, RemoveAndDestroyDeviceByKeyword


/;
Function Init()
	Version = "Script Version = 1.0.1"
	DDVersion = "DD Version = 4.2"
	DDxVersion = "DDx Version = 4.2"
	Utility.Wait(Utility.RandomInt(0,3)) ; stagger multiple scripts firing at the same time and remake Json multiple times
	if StorageUtil.IntListFind(none, "LDCDevices", 1) == -1 ;Since running this multiple time will cause problems!
		StorageUtil.IntListAdd(none, "LDCDevices", 1)
		if JsonUtil.StringListFind(File, "Settings" , "Delete This To Rebuild Item List") == -1 
			JsonBuilt = False
		Else
			JsonBuilt = True
		endIf
		If !JsonBuilt 
			Debug.Notification("Building Device Setting.Json")
		endIf
		if !JsonBuilt || !StorUtilBuilt
			RegisterDevices()
			RegisterSets()
			If !JsonBuilt
				JsonUtil.StringListClear(File, "Versions")
				JsonUtil.StringListAdd(File, "Versions" , Version , false)
				JsonUtil.StringListAdd(File, "Versions" , DDVersion , false)
				JsonUtil.StringListAdd(File, "Versions" , DDxVersion , false)
				JsonUtil.StringListAdd(File, "Settings" , "Delete This To Rebuild Item List" , false)
				JsonUtil.Save(File, false)
				Debug.Notification("Built Device Setting.Json")
			endIf
		endIf
		SendModEvent("LDCAddExtraDevices")
		StorageUtil.IntListRemove(none, "LDCDevices", 1)
	else
		;Debug.Notification("")
		if JsonUtil.StringListFind(File, "Settings" , "Delete This To Rebuild Item List") == -1 
			JsonBuilt = False
		Else
			JsonBuilt = True
		endIf
	endIf
endFunction

Function RegisterDeviceByKeyword(Armor inventoryDevice, Keyword kw) ; This should not be used by other mods as it will not add your devices. Please read Mod Description
		StorageUtil.FormListAdd(kw, "LDCDevices", inventoryDevice, false)
		if !JsonBuilt
			JsonUtil.StringListAdd(File, kw.GetString() , inventoryDevice.GetName() , false)
		endIf
endFunction

Function RegisterAdditionalDeviceByKeyword(Armor inventoryDevice, Keyword kw, String ModName) ;Adding Additional devices from other mods.
		StorageUtil.FormListAdd(kw, "LDCDevices", inventoryDevice, false)
		if JsonUtil.StringListFind(File, "Settings" , "Delete This To ReAdd "+ ModName + " Items.") != -1
			JsonUtil.StringListAdd(File, kw.GetString() , inventoryDevice.GetName() , false)
		endIf
endFunction

Function CompletedAddingAdditionalContent(String ModName) ;Needs to used once mod has finished adding items.
		JsonUtil.StringListAdd(File, "Settings" , "Delete This To ReAdd "+ ModName + " Items." , false)
		JsonUtil.Save(File, false)
endFunction


Function RegisterAdditionalSets(String Set, String ModName)
	if JsonUtil.StringListFind(File, "Settings" , "Delete This To ReAdd "+ ModName + " Items.") != -1
		JsonUtil.StringListAdd(File, "Sets" , Set , false)
	endif 
endFunction

Function RegisterSets()
	JsonUtil.StringListAdd(File, "Sets" , "Steel" , false)
	JsonUtil.StringListAdd(File, "Sets" , "Iron" , false)
	JsonUtil.StringListAdd(File, "Sets" , "Black Leather" , false)
	JsonUtil.StringListAdd(File, "Sets" , "White Leather" , false)
	JsonUtil.StringListAdd(File, "Sets" , "Red Leather" , false)
	JsonUtil.StringListAdd(File, "Sets" , "Black Ebonite" , false)
	JsonUtil.StringListAdd(File, "Sets" , "White Ebonite" , false)
	JsonUtil.StringListAdd(File, "Sets" , "Red Ebonite" , false)
	JsonUtil.StringListAdd(File, "Sets" , "Rope" , false)
	JsonUtil.StringListAdd(File, "Settings" , "Change Y to N if you don't want to use sets" , false)
	if JsonUtil.StringListFind(File, "Settings" , "Use Sets - (N)") == -1 
		JsonUtil.StringListAdd(File, "Settings" , "Use Sets - (Y)" , false)
	endIf
EndFunction

Function LockSet(String ItemName)
	if StorageUtil.StringListCount(none, "LDCDevices") == 0
		int n = JsonUtil.StringListCount(File, "Sets")
		int i = 0
		String set = ""
		If n
			while i < n
				Set = JsonUtil.StringListGet(File, "Sets", i) 
				
				if StringUtil.Find(ItemName, Set) != -1
					
					StorageUtil.StringListAdd(none, "LDCDevices",Set,False)
					SetTimer = Utility.GetCurrentGameTime() + 0.03
					return
				endif	
				i += 1
			endWhile
		endIf
	endIf
endFunction

Function UnlockSet()
	If SetTimer < Utility.GetCurrentGameTime()
		if StorageUtil.StringListCount(none, "LDCDevices") > 0
			If !libs.PlayerRef.WornHasKeyword(libs.Zad_Lockable)
				StorageUtil.StringListRemoveAt(none, "LDCDevices", 0)
			endIf
		endIf
	endIf
EndFunction


Armor Function GetGenericDeviceByKeyword(Keyword kw, Bool useSet = True)

    If !StorUtilBuilt
        Init()
    Endif
    
    Int n = JsonUtil.StringListCount(file, kw.GetString())
    Int i = 0
    Int times = 1
    Int save = -1
    String itemName = ""
    Armor device = none

    ;Debug.TraceConditional("LDC - GetGenericDeviceByKeyword " + kw.GetString() + " => " + n + ", file " + file, True)

    ; Check for a device in a set.
    if StorageUtil.StringListCount(none, "LDCDevices") != 0 && useSet

        String setName = StorageUtil.StringListGet(none, "LDCDevices", 0)

        ;Debug.TraceConditional("LDC - LDCDevices useSet " + useSet + ", setName " + setName, True)
        
        if n > 0
            While i < n
                itemName = JsonUtil.StringListGet(file, kw.GetString(), i)
                ;Debug.TraceConditional("LDC - itemName " + itemName + ", i " + i + ", n " + n, True)
                
                If StringUtil.Find(itemName, setName) != -1
                    ;Debug.TraceConditional("LDC - itemName " + itemName + ", Set " + setName, True)
                    If save == -1
                        ;Debug.TraceConditional("LDC - save -1", True)
                        save = i
                    ElseIf Utility.RandomInt(0, times) == 0
                        ;Debug.TraceConditional("LDC - save " + i + ", times " + times, True)
                        save = i
                        times += 1
                    EndIf	
                EndIf
                i+=1
            EndWhile
        EndIf
        If save != -1
            itemName = JsonUtil.StringListGet(file, kw.GetString(), save)
            ;Debug.TraceConditional("LDC - no-save, itemName " + itemName, True)
            
            device = GetItem(kw, itemName)
        EndIf
    EndIf

    
    While device == none && n > 0
        ; Fetch a random device
        i = Utility.RandomInt(0, n - 1)
        itemName = JsonUtil.StringListGet(file, kw.GetString(), i)
        
        ;Debug.TraceConditional("LDC - itemName " + itemName + ", from i " + i, True)
        
        device = GetItem(kw, itemName)
        If device == none
            ;Debug.TraceConditional("LDC - CLEAR itemName " + itemName + ", kw " + kw.GetString() + ", at i " + i, True)
            
            ; Remove the index from the list if it's none, and avoid clearing the list completely
            JsonUtil.FormListRemoveAt(file, kw.GetString(), i)
            JsonUtil.StringListAdd(file, "Broken " + kw.GetString(), itemName, False) 
            n = JsonUtil.StringListCount(file, kw.GetString())
        EndIf
    EndWhile


    If useSet && StorageUtil.StringListCount(none, "LDCDevices") == 0
        ;Debug.TraceConditional("LDC - useSet && no LDCDevices - LockSet " + itemName, True)
        LockSet(itemName)
    EndIf
    
    If device
        Debug.TraceConditional("LDC - got a device for keyword '" + kw.GetString() + "', itemName '" + itemName + "'", True)
    Else
        Debug.TraceConditional("LDC - no device found for keyword " + kw.GetString(), True)
    EndIf

    Return device 
    
EndFunction

Function EquipDeviceByKeyword(Keyword kw, Actor AkActor=none)
	If AkActor == none
		AkActor = libs.playerref
	Endif

	If AkActor.WornHasKeyword(kw)
		Return
	endif
	
	Armor device = DeviceManager.GetRandomDeviceByKeyword(AkActor, kw)

	Debug.Trace("DF - Equipping " + device + " on " + AkActor)

	libs.LockDevice(AkActor, device)
endFunction

Function ForceEquipDeviceByKeyword(Keyword kw,Actor AkActor=none)
	If AkActor == none
		AkActor = libs.playerref
	Endif
	
	Armor device = DeviceManager.GetRandomDeviceByKeyword(AkActor, kw)
	
	Debug.Trace("DF - Force Equipping " + device + " on " + AkActor)
	
	libs.LockDevice(AkActor, device, true)
endFunction

int Function CheckForConflicts(Armor Device, keyword kw) 
{ -1 = Can not equip item of this type ever
0 = Can't equip this item but could of this type
1 = No conflicts 
}
	If libs.playerref.WornHasKeyword(kw)
		Return -1
	endif
	
	if Device.HasKeyword(libs.zad_DeviousHarness)
		Utility.wait(1)
		If libs.playerref.WornHasKeyword(libs.zad_DeviousCollar) || libs.playerref.WornHasKeyword(libs.zad_DeviousBelt) || libs.playerref.WornhasKeyword(libs.zad_DeviousCorset)
			return -1
		endIf
	endif
	
	if Device.HasKeyword(libs.zad_DeviousCorset)
		Utility.wait(1)
		If libs.playerref.WornhasKeyword(libs.zad_DeviousHarness)
			return -1
		endIf
	endif
	
	if Device.HasKeyword(libs.zad_DeviousCollar)
		Utility.wait(1)
		If libs.playerref.WornhasKeyword(libs.zad_DeviousPiercingsNipple)
			return 0
		endIf
	endif
	return 1
	
EndFunction


Function EquipDeviceByKeywordNoneSet(Keyword kw,Actor AkActor=none)
	If AkActor == none
		AkActor = libs.playerref
	Endif
	If StorUtilBuilt != True
		Init()
	Endif
	Armor DeviceI = GetGenericDeviceByKeyword(kw, False)
	Armor DeviceR = Libs.GetRenderedDevice(DeviceI)
	int Temp =  CheckForConflicts(DeviceR,kw)
	if Temp == 1
		libs.EquipDevice(AkActor, DeviceI, DeviceR, kw)
	elseif Temp == 0
		EquipDeviceByKeywordNoneSet(kw)
	endIf
endFunction

Function EquipDeviceByKeywordNoneSetLast(Keyword kw,Actor AkActor=none)
	Utility.Wait(5)
	If AkActor == none
		AkActor = libs.playerref
	Endif
	If StorUtilBuilt != True
		Init()
	Endif
	Armor DeviceI = GetGenericDeviceByKeyword(kw, False)
	Armor DeviceR = Libs.GetRenderedDevice(DeviceI)
	int Temp =  CheckForConflicts(DeviceR,kw)
	if Temp == 1
		libs.EquipDevice(AkActor, DeviceI, DeviceR, kw)
	endIf
endFunction

Function AddDeviceByKeyword(Keyword kw,Actor AkActor=none)
	If AkActor == none
		AkActor = libs.playerref
	Endif
	
	Armor device = DeviceManager.GetRandomDeviceByKeyword(AkActor, kw)
	
	Debug.Trace("DF - Adding " + device + " to " + AkActor)
	
	AkActor.AddItem(device, 1) 
endFunction


Function AddDeviceByKeywordNoneSet(Keyword kw,Actor AkActor=none)
	If AkActor == none
		AkActor = libs.playerref
	Endif
	
	Armor device = DeviceManager.GetRandomDeviceByKeyword(AkActor, kw)
	
	AkActor.AddItem(device, 1)
endFunction

Armor Function GetItem(Keyword kw, String ItemName)
	int n = StorageUtil.FormListCount(kw, "LDCDevices")
	Armor device = none
	int i = 0
	Int Save = -1
	Int times = 1
	while n > 0 && i < n
		device = StorageUtil.FormListGet(kw, "LDCDevices", i) as Armor
		if device.GetName() == ItemName
			;Debug.Notification(ItemName + " Found at " + i + " in Key " + kw.GetString() )
			If Save == -1
				Save = i
			elseif Utility.RandomInt(0,times) == 0
				Save = i
				times += 1
			endIf
		endif	
		i += 1
	endWhile
	device = StorageUtil.FormListGet(kw, "LDCDevices", Save) as Armor
	if Save != -1
		;Debug.Notification(ItemName + " Used at " + i + " in Key " + kw.GetString() )
		Return Device
	else
		Device = none
		Return Device
	endif
endFunction

Bool Function RemoveDeviceByKeyword(Keyword kw,Actor AkActor=none)
	If kw == libs.zad_DeviousArmbinder || kw == libs.zad_deviousarmbinderelbow ||kw ==  libs.zad_deviouspetsuit || kw == libs.zad_deviousstraitjacket || kw == libs.zad_deviousyoke ||kw ==  libs.zad_deviousyokebb
		kw = libs.zad_DeviousHeavybondage
	endif
	if kw == libs.zad_deviousankleshackles
		kw = libs.zad_DeviousLegCuffs
	endIf
	if kw == libs.zad_devioushobbleskirt || kw == libs.zad_devioushobbleskirtrelaxed
		kw = libs.zad_DeviousSuit
	endIf
	If AkActor == none
		AkActor = libs.playerref
	endIf
	
	Armor DeviceI = DeviceManager.GetWornItemByKeyword(AkActor, kw)

	Debug.Trace("DF - Removing " + DeviceI + " on " + AkActor)

	if DeviceI
		Return libs.UnlockDevice(AkActor, DeviceI)
	endIf
	Return False
EndFunction

Bool Function RemoveAndDestroyDeviceByKeyword(Keyword kw, Actor akActor=none)
	If kw == libs.zad_DeviousArmbinder || kw == libs.zad_deviousarmbinderelbow ||kw ==  libs.zad_deviouspetsuit || kw == libs.zad_deviousstraitjacket || kw == libs.zad_deviousyoke ||kw ==  libs.zad_deviousyokebb
		kw = libs.zad_DeviousHeavybondage
	endif
	if kw == libs.zad_deviousankleshackles
		kw = libs.zad_DeviousLegCuffs
	endIf
	if kw == libs.zad_devioushobbleskirt || kw == libs.zad_devioushobbleskirtrelaxed
		kw = libs.zad_DeviousSuit
	endIf
	If AkActor == none
		AkActor = libs.playerref
	endIf
	
	Armor DeviceI = DeviceManager.GetWornItemByKeyword(AkActor, kw)
	
	Debug.Trace("DF - Removing " + DeviceI + " on " + AkActor)

	If DeviceI
        bool result = Libs.UnlockDevice(akActor, DeviceI)

		if result
			akActor.Removeitem(DeviceI, 1, True)
		endIf

		return result
	EndIf
    
    ;_fw_utils.Info("RemoveAndDestroyDeviceByKeyword: failed")
	Return False
EndFunction

Function UnequipAndDestroyAll(Actor AkActor = None)

	If AkActor == None
		AkActor = libs.playerref
	endIf
    
	If libs.playerref.WornHasKeyword(libs.zad_DeviousLegCuffs)
		RemoveAndDestroyDeviceByKeyword(libs.zad_DeviousLegCuffs)
	endIf
	If libs.playerref.WornHasKeyword(libs.zad_deviousarmcuffs)
		RemoveAndDestroyDeviceByKeyword(libs.zad_deviousarmcuffs)
	endIf
	If libs.playerref.WornHasKeyword(libs.zad_deviousbelt)
		RemoveAndDestroyDeviceByKeyword(libs.zad_deviousbelt)
	endIf
	If libs.playerref.WornHasKeyword(libs.zad_deviousblindfold)
		RemoveAndDestroyDeviceByKeyword(libs.zad_deviousblindfold)
	endIf
	If libs.playerref.WornHasKeyword(libs.zad_deviousbondagemittens)
		RemoveAndDestroyDeviceByKeyword(libs.zad_deviousbondagemittens)
	endIf
	If libs.playerref.WornHasKeyword(libs.zad_deviousboots)
		RemoveAndDestroyDeviceByKeyword(libs.zad_deviousboots)
	endIf
	If libs.playerref.WornHasKeyword(libs.zad_deviousbra)
		RemoveAndDestroyDeviceByKeyword(libs.zad_deviousbra)
	endIf
	If libs.playerref.WornHasKeyword(libs.zad_deviouscollar)
		RemoveAndDestroyDeviceByKeyword(libs.zad_deviouscollar)
	endIf
	If libs.playerref.WornHasKeyword(libs.zad_deviouscorset)
		RemoveAndDestroyDeviceByKeyword(libs.zad_deviouscorset)
	endIf
	If libs.playerref.WornHasKeyword(libs.zad_deviousgag)
		RemoveAndDestroyDeviceByKeyword(libs.zad_deviousgag)
	endIf
	If libs.playerref.WornHasKeyword(libs.zad_deviousgloves)
		RemoveAndDestroyDeviceByKeyword(libs.zad_deviousgloves)
	endIf
	If libs.playerref.WornHasKeyword(libs.zad_deviousharness)
		RemoveAndDestroyDeviceByKeyword(libs.zad_deviousharness)
	endIf
	If libs.playerref.WornHasKeyword(libs.zad_deviousheavybondage)
		RemoveAndDestroyDeviceByKeyword(libs.zad_deviousheavybondage)
	endIf
	If libs.playerref.WornHasKeyword(libs.zad_devioushood)
		RemoveAndDestroyDeviceByKeyword(libs.zad_devioushood)
	endIf
	If libs.playerref.WornHasKeyword(libs.zad_deviouspiercingsnipple)
		RemoveAndDestroyDeviceByKeyword(libs.zad_deviouspiercingsnipple)
	endIf
	If libs.playerref.WornHasKeyword(libs.zad_deviouspiercingsvaginal)
		RemoveAndDestroyDeviceByKeyword(libs.zad_deviouspiercingsvaginal)
	endIf
	If libs.playerref.WornHasKeyword(libs.zad_deviouspluganal)
		RemoveAndDestroyDeviceByKeyword(libs.zad_deviouspluganal)
	endIf
	If libs.playerref.WornHasKeyword(libs.zad_deviousplugvaginal)
		RemoveAndDestroyDeviceByKeyword(libs.zad_deviousplugvaginal)
	endIf
	If libs.playerref.WornHasKeyword(libs.zad_devioussuit)
		RemoveAndDestroyDeviceByKeyword(libs.zad_devioussuit)
	endIf
endFunction

Function UnequipAll(Actor AkActor = none)
	If AkActor == none
		AkActor = libs.playerref
	endIf
	If libs.playerref.WornHasKeyword(libs.zad_DeviousLegCuffs)
		RemoveDeviceByKeyword(libs.zad_DeviousLegCuffs)
	endIf
	If libs.playerref.WornHasKeyword(libs.zad_deviousarmcuffs)
		RemoveDeviceByKeyword(libs.zad_deviousarmcuffs)
	endIf
	If libs.playerref.WornHasKeyword(libs.zad_deviousbelt)
		RemoveDeviceByKeyword(libs.zad_deviousbelt)
	endIf
	If libs.playerref.WornHasKeyword(libs.zad_deviousblindfold)
		RemoveDeviceByKeyword(libs.zad_deviousblindfold)
	endIf
	If libs.playerref.WornHasKeyword(libs.zad_deviousbondagemittens)
		RemoveDeviceByKeyword(libs.zad_deviousbondagemittens)
	endIf
	If libs.playerref.WornHasKeyword(libs.zad_deviousboots)
		RemoveDeviceByKeyword(libs.zad_deviousboots)
	endIf
	If libs.playerref.WornHasKeyword(libs.zad_deviousbra)
		RemoveDeviceByKeyword(libs.zad_deviousbra)
	endIf
	If libs.playerref.WornHasKeyword(libs.zad_deviouscollar)
		RemoveDeviceByKeyword(libs.zad_deviouscollar)
	endIf
	If libs.playerref.WornHasKeyword(libs.zad_deviouscorset)
		RemoveDeviceByKeyword(libs.zad_deviouscorset)
	endIf
	If libs.playerref.WornHasKeyword(libs.zad_deviousgag)
		RemoveDeviceByKeyword(libs.zad_deviousgag)
	endIf
	If libs.playerref.WornHasKeyword(libs.zad_deviousgloves)
		RemoveDeviceByKeyword(libs.zad_deviousgloves)
	endIf
	If libs.playerref.WornHasKeyword(libs.zad_deviousharness)
		RemoveDeviceByKeyword(libs.zad_deviousharness)
	endIf
	If libs.playerref.WornHasKeyword(libs.zad_deviousheavybondage)
		RemoveDeviceByKeyword(libs.zad_deviousheavybondage)
	endIf
	If libs.playerref.WornHasKeyword(libs.zad_devioushood)
		RemoveDeviceByKeyword(libs.zad_devioushood)
	endIf
	If libs.playerref.WornHasKeyword(libs.zad_deviouspiercingsnipple)
		RemoveDeviceByKeyword(libs.zad_deviouspiercingsnipple)
	endIf
	If libs.playerref.WornHasKeyword(libs.zad_deviouspiercingsvaginal)
		RemoveDeviceByKeyword(libs.zad_deviouspiercingsvaginal)
	endIf
	If libs.playerref.WornHasKeyword(libs.zad_deviouspluganal)
		RemoveDeviceByKeyword(libs.zad_deviouspluganal)
	endIf
	If libs.playerref.WornHasKeyword(libs.zad_deviousplugvaginal)
		RemoveDeviceByKeyword(libs.zad_deviousplugvaginal)
	endIf
	If libs.playerref.WornHasKeyword(libs.zad_devioussuit)
		RemoveDeviceByKeyword(libs.zad_devioussuit)
	endIf
endFunction




Function RegisterDevices() ; Register Device please use Init() not this!
	RegisterDeviceByKeyword(libs.beltPadded , libs.zad_DeviousBelt                                          )        	       ; Inventory Device
	RegisterDeviceByKeyword(libs.beltIron ,  libs.zad_DeviousBelt                                         )        	     ; Inventory Device
	RegisterDeviceByKeyword(libs.braPadded , libs.zad_DeviousBra   	)        	      ; Inventory Device
	RegisterDeviceByKeyword(libs.cuffsPaddedArms ,     libs.zad_DeviousArmCuffs                                      )        	    ; Inventory Device
	RegisterDeviceByKeyword(libs.cuffsPaddedLegs ,     libs.zad_DeviousLegCuffs                                      )        	    ; Inventory Device
	RegisterDeviceByKeyword(libs.cuffsPaddedCollar ,    libs.zad_DeviousCollar                                       )        	      ; Inventory Device
	RegisterDeviceByKeyword(libs.collarPosture ,  libs.zad_DeviousCollar                                         )        	  ; Inventory Device
	RegisterDeviceByKeyword(libs.armbinder ,   libs.zad_DeviousArmbinder                                        )        	  ; Inventory Device
	RegisterDeviceByKeyword(libs.gagBall ,       libs.zad_DeviousGag                                    )
	RegisterDeviceByKeyword(libs.gagPanel ,  libs.zad_DeviousGag                                         )
	RegisterDeviceByKeyword(libs.gagRing ,       libs.zad_DeviousGag                                    )
	RegisterDeviceByKeyword(libs.gagStrapBall ,    libs.zad_DeviousGag                                       )                   ; Inventory Device
	RegisterDeviceByKeyword(libs.gagStrapRing ,    libs.zad_DeviousGag                                       )                   ; Inventory Device
	RegisterDeviceByKeyword(libs.blindfold ,       libs.zad_DeviousBlindfold                                    )                        ; Inventory Device
	RegisterDeviceByKeyword(libs.cuffsLeatherArms ,    libs.zad_DeviousArmCuffs                                       )                 ; Inventory Device
	RegisterDeviceByKeyword(libs.cuffsLeatherLegs ,    libs.zad_DeviousLegCuffs                                       )                 ; Inventory Device
	RegisterDeviceByKeyword(libs.cuffsLeatherCollar ,   libs.zad_DeviousCollar                                        )               ; Inventory Device
	RegisterDeviceByKeyword(libs.harnessBody ,          libs.zad_DeviousHarness                                 )                          ; Inventory Device
	RegisterDeviceByKeyword(libs.harnessCollar ,        libs.zad_DeviousCollar                                   )                  ; Inventory Device
	RegisterDeviceByKeyword(libs.collarPostureLeather ,     libs.zad_DeviousCollar                                      )
	RegisterDeviceByKeyword(libs.plugIronVag ,          libs.zad_DeviousPlugVaginal                                 )                  ; Internal Device
	RegisterDeviceByKeyword(libs.plugIronAn ,             libs.zad_DeviousPlugAnal                              )                  ; Internal Device
	RegisterDeviceByKeyword(libs.plugPrimitiveVag ,   libs.zad_DeviousPlugVaginal                                        )                  ; Internal Device
	RegisterDeviceByKeyword(libs.plugPrimitiveAn ,        libs.zad_DeviousPlugAnal                                   )                  ; Internal Device
	RegisterDeviceByKeyword(libs.plugSoulgemVag ,     libs.zad_DeviousPlugVaginal                                      )                  ; Internal Device
	RegisterDeviceByKeyword(libs.plugSoulgemAn ,           libs.zad_DeviousPlugAnal                                )                  ; Internal Device
	RegisterDeviceByKeyword(libs.plugInflatableVag ,   libs.zad_DeviousPlugVaginal                                        )                  ; Internal Device
	RegisterDeviceByKeyword(libs.plugInflatableAn ,         libs.zad_DeviousPlugAnal                                  )                  ; Internal Device
	RegisterDeviceByKeyword(libs.beltPaddedOpen ,              libs.zad_DeviousBelt                             )        	       ; Inventory Device
	RegisterDeviceByKeyword(libs.plugChargeableVag ,   libs.zad_DeviousPlugVaginal                                        )
	RegisterDeviceByKeyword(libs.plugTrainingVag ,    libs.zad_DeviousPlugVaginal                                       )
	RegisterDeviceByKeyword(libs.collarRestrictive ,      libs.zad_DeviousCollar                                     )
	RegisterDeviceByKeyword(libs.corset ,                    libs.zad_DeviousCorset                       )
	RegisterDeviceByKeyword(libs.glovesRestrictive ,          libs.zad_DeviousGloves                                 )
	RegisterDeviceByKeyword(libs.yoke ,                     libs.zad_DeviousYoke                      )
	RegisterDeviceByKeyword(libs.piercingVSoul ,                   libs.zad_DeviousPiercingsVaginal                        )
	RegisterDeviceByKeyword(libs.piercingNSoul ,               libs.zad_DeviousPiercingsNipple                            )
	RegisterDeviceByKeyword(xlibs.blindfoldBlocking ,            libs.zad_DeviousBlindfold                               )
	RegisterDeviceByKeyword(xlibs.bootsLocking ,             libs.zad_DeviousBoots                              )
	RegisterDeviceByKeyword(xlibs.restrictiveBoots ,         libs.zad_DeviousBoots                                  )
	RegisterDeviceByKeyword(xlibs.PlugsGreaterSoulVag ,      libs.zad_DeviousPlugVaginal                                     )
	RegisterDeviceByKeyword(xlibs.PlugsGreaterSoulAnl ,              libs.zad_DeviousPlugAnal                             )
	RegisterDeviceByKeyword(xlibs.PlugsGrandSoulVag ,      libs.zad_DeviousPlugVaginal                                     )
	RegisterDeviceByKeyword(xlibs.PlugsGrandSoulAnl ,          libs.zad_DeviousPlugAnal                                 )
	RegisterDeviceByKeyword(xlibs.PlugsBlackSoulVag ,   libs.zad_DeviousPlugVaginal                                        )
	RegisterDeviceByKeyword(xlibs.PlugsBlackSoulAnl ,          libs.zad_DeviousPlugAnal                                 )
	RegisterDeviceByKeyword(xlibs.PlugsFilledSoulVag ,  libs.zad_DeviousPlugVaginal                                         )
	RegisterDeviceByKeyword(xlibs.PlugsFilledSoulAnl ,         libs.zad_DeviousPlugAnal                                  )
	RegisterDeviceByKeyword(xlibs.PlugsShockSoulVag ,    libs.zad_DeviousPlugVaginal                                       )
	RegisterDeviceByKeyword(xlibs.PlugsShockSoulAnl ,          libs.zad_DeviousPlugAnal                                 )
	RegisterDeviceByKeyword(xlibs.PiercingsCommonSoulVag , libs.zad_DeviousPiercingsVaginal                                          )
	RegisterDeviceByKeyword(xlibs.PiercingsCommonSoulNips ,      libs.zad_DeviousPiercingsNipple                                     )
	RegisterDeviceByKeyword(xlibs.PiercingsShockSoulVag ,     libs.zad_DeviousPiercingsVaginal                                      )
	RegisterDeviceByKeyword(xlibs.PiercingsShockSoulNips ,     libs.zad_DeviousPiercingsNipple                                      )
	RegisterDeviceByKeyword(xlibs.cuffsEboniteArms ,           libs.zad_DeviousArmCuffs                                )
	RegisterDeviceByKeyword(xlibs.cuffsEboniteLegs ,            libs.zad_DeviousLegCuffs                               )
	RegisterDeviceByKeyword(xlibs.cuffsEboniteCollar ,           libs.zad_DeviousCollar                                )
	RegisterDeviceByKeyword(xlibs.eboniteArmbinder ,          libs.zad_DeviousArmbinder                                 )
	RegisterDeviceByKeyword(xlibs.eboniteHarnessBody ,        libs.zad_DeviousHarness                                   ) ; "normal" version, works as a chastity belt
	RegisterDeviceByKeyword(xlibs.eboniteHarnessCollar ,      libs.zad_DeviousCollar                                     )
	RegisterDeviceByKeyword(xlibs.eboniteBlindfold ,          libs.zad_DeviousBlindfold                                 )
	RegisterDeviceByKeyword(xlibs.gagEboniteBall ,             libs.zad_DeviousGag                              )
	JsonUtil.Save(File, false)
	RegisterDeviceByKeyword(xlibs.gagEboniteRing ,             libs.zad_DeviousGag                              )
	RegisterDeviceByKeyword(xlibs.gagEbonitePanel ,            libs.zad_DeviousGag                               )
	RegisterDeviceByKeyword(xlibs.gagEboniteStrapBall ,      libs.zad_DeviousGag                                     )
	RegisterDeviceByKeyword(xlibs.gagEboniteStrapRing ,        libs.zad_DeviousGag                                   )
	RegisterDeviceByKeyword(xlibs.collarPostureEbonite ,        libs.zad_DeviousCollar                                   )
	RegisterDeviceByKeyword(xlibs.EbharnessUnlocked ,           libs.zad_DeviousHarness                                )
	RegisterDeviceByKeyword(xlibs.EbblindfoldBlocking ,           libs.zad_DeviousBlindfold                                )
	RegisterDeviceByKeyword(xlibs.EbRestrictiveCorset ,           libs.zad_DeviousCorset                                )
	RegisterDeviceByKeyword(xlibs.EbRestrictiveCollar ,            libs.zad_DeviousCollar                               )
	RegisterDeviceByKeyword(xlibs.EbRestrictiveGloves ,            libs.zad_DeviousGloves                               )
	RegisterDeviceByKeyword(xlibs.EbRestrictiveBoots ,             libs.zad_DeviousBoots                              )
	RegisterDeviceByKeyword(xlibs.cuffsWTEboniteArms ,             libs.zad_DeviousArmCuffs                              )
	RegisterDeviceByKeyword(xlibs.cuffsWTEboniteLegs ,             libs.zad_DeviousLegCuffs                              )
	RegisterDeviceByKeyword(xlibs.cuffsWTEboniteCollar ,           libs.zad_DeviousCollar                                )
	RegisterDeviceByKeyword(xlibs.wtEboniteArmbinder ,            libs.zad_DeviousArmbinder                               )
	RegisterDeviceByKeyword(xlibs.wtEboniteHarnessBody ,            libs.zad_DeviousHarness                               ) 
	RegisterDeviceByKeyword(xlibs.wtEboniteHarnessCollar ,           libs.zad_DeviousCollar                                )
	RegisterDeviceByKeyword(xlibs.wtEboniteBlindfold ,               libs.zad_DeviousBlindfold                            )
	RegisterDeviceByKeyword(xlibs.gagWTEboniteBall ,                 libs.zad_DeviousGag                          )
	RegisterDeviceByKeyword(xlibs.gagWTEboniteRing ,                  libs.zad_DeviousGag                         )
	RegisterDeviceByKeyword(xlibs.gagWTEbonitePanel ,                 libs.zad_DeviousGag                          )
	RegisterDeviceByKeyword(xlibs.gagWTEboniteStrapBall ,              libs.zad_DeviousGag                             )
	RegisterDeviceByKeyword(xlibs.gagWTEboniteStrapRing ,             libs.zad_DeviousGag                              )
	RegisterDeviceByKeyword(xlibs.collarPostureWTEbonite ,            libs.zad_DeviousCollar                               )
	RegisterDeviceByKeyword(xlibs.WTEblindfoldBlocking ,                     libs.zad_DeviousBlindfold                      )
	RegisterDeviceByKeyword(xlibs.WTErestrictiveCorset ,           libs.zad_DeviousCorset                                )
	RegisterDeviceByKeyword(xlibs.WTErestrictiveCollar ,           libs.zad_DeviousCollar                                )
	RegisterDeviceByKeyword(xlibs.WTErestrictiveGloves ,           libs.zad_DeviousGloves                                )
	RegisterDeviceByKeyword(xlibs.WTErestrictiveBoots ,    libs.zad_DeviousBoots                                       )
	RegisterDeviceByKeyword(xlibs.wtEboniteRegularHarness ,     libs.zad_DeviousHarness                                      ) 
	RegisterDeviceByKeyword(xlibs.cuffsWTLeatherArms ,          libs.zad_DeviousArmCuffs                                 )
	RegisterDeviceByKeyword(xlibs.cuffsWTLeatherLegs ,            libs.zad_DeviousLegCuffs                               )
	RegisterDeviceByKeyword(xlibs.cuffsWTLeatherCollar ,           libs.zad_DeviousCollar                                )
	RegisterDeviceByKeyword(xlibs.wtLeatherArmbinder ,             libs.zad_DeviousArmbinder                              )
	RegisterDeviceByKeyword(xlibs.wtLeatherHarnessBody ,                libs.zad_DeviousHarness                          ) 
	RegisterDeviceByKeyword(xlibs.wtLeatherHarnessCollar ,                  libs.zad_DeviousCollar                         )
	RegisterDeviceByKeyword(xlibs.wtLeatherBlindfold ,      libs.zad_DeviousBlindfold                                     )
	RegisterDeviceByKeyword(xlibs.gagWTLeatherBall ,          libs.zad_DeviousGag                                 )
	RegisterDeviceByKeyword(xlibs.gagWTLeatherRing ,      libs.zad_DeviousGag                                     )
	JsonUtil.Save(File, false)
	RegisterDeviceByKeyword(xlibs.gagWTLeatherPanel ,     libs.zad_DeviousGag                                      )
	RegisterDeviceByKeyword(xlibs.gagWTLeatherStrapBall , libs.zad_DeviousGag                                          )
	RegisterDeviceByKeyword(xlibs.gagWTLeatherStrapRing ,     libs.zad_DeviousGag                                      )
	RegisterDeviceByKeyword(xlibs.collarPostureWTLeather ,     libs.zad_DeviousCollar                                      )
	RegisterDeviceByKeyword(xlibs.WTLblindfoldBlocking ,          libs.zad_DeviousBlindfold                                 )
	RegisterDeviceByKeyword(xlibs.WTLrestrictiveCorset ,         libs.zad_DeviousCorset                                  )
	RegisterDeviceByKeyword(xlibs.WTLrestrictiveCollar ,         libs.zad_DeviousCollar                                  )
	RegisterDeviceByKeyword(xlibs.WTLrestrictiveGloves ,         libs.zad_DeviousGloves                                  )
	RegisterDeviceByKeyword(xlibs.WTLrestrictiveBoots ,          libs.zad_DeviousBoots                                 )
	RegisterDeviceByKeyword(xlibs.wtLeatherRegularHarness ,      libs.zad_DeviousHarness                                     ) 
	RegisterDeviceByKeyword(xlibs.cuffsRDEboniteArms ,           libs.zad_DeviousArmCuffs                                )
	RegisterDeviceByKeyword(xlibs.cuffsRDEboniteLegs ,           libs.zad_DeviousLegCuffs                                )
	RegisterDeviceByKeyword(xlibs.cuffsRDEboniteCollar ,        libs.zad_DeviousCollar                                   )
	RegisterDeviceByKeyword(xlibs.rdEboniteArmbinder ,      libs.zad_DeviousArmbinder                                     )
	RegisterDeviceByKeyword(xlibs.rdEboniteHarnessBody ,      libs.zad_DeviousHarness                                     ) 
	RegisterDeviceByKeyword(xlibs.rdEboniteHarnessCollar ,      libs.zad_DeviousCollar                                     )
	RegisterDeviceByKeyword(xlibs.rdEboniteBlindfold ,          libs.zad_DeviousBlindfold                                 )
	RegisterDeviceByKeyword(xlibs.gagRDEboniteBall ,          libs.zad_DeviousGag                                 )
	RegisterDeviceByKeyword(xlibs.gagRDEboniteRing ,            libs.zad_DeviousGag                               )
	RegisterDeviceByKeyword(xlibs.gagRDEbonitePanel ,          libs.zad_DeviousGag                                 )
	RegisterDeviceByKeyword(xlibs.gagRDEboniteStrapBall ,       libs.zad_DeviousGag                                    )
	RegisterDeviceByKeyword(xlibs.gagRDEboniteStrapRing ,       libs.zad_DeviousGag                                    )
	RegisterDeviceByKeyword(xlibs.collarPostureRDEbonite ,     libs.zad_DeviousCollar                                      )
	RegisterDeviceByKeyword(xlibs.RDEblindfoldBlocking ,        libs.zad_DeviousBlindfold                                   )
	RegisterDeviceByKeyword(xlibs.RDErestrictiveCorset ,         libs.zad_DeviousCorset                                  )
	RegisterDeviceByKeyword(xlibs.RDErestrictiveCollar ,         libs.zad_DeviousCollar                                  )
	RegisterDeviceByKeyword(xlibs.RDErestrictiveGloves ,        libs.zad_DeviousGloves                                   )
	RegisterDeviceByKeyword(xlibs.RDErestrictiveBoots ,          libs.zad_DeviousBoots                                 )
	RegisterDeviceByKeyword(xlibs.rdEboniteRegularHarness ,     libs.zad_DeviousHarness                                      ) 
	RegisterDeviceByKeyword(xlibs.cuffsRDLeatherArms ,          libs.zad_DeviousArmCuffs                                 )
	RegisterDeviceByKeyword(xlibs.cuffsRDLeatherLegs ,          libs.zad_DeviousLegCuffs                                 )
	RegisterDeviceByKeyword(xlibs.cuffsRDLeatherCollar ,       libs.zad_DeviousCollar                                    )
	RegisterDeviceByKeyword(xlibs.rdLeatherArmbinder ,          libs.zad_DeviousArmbinder                                 )
	RegisterDeviceByKeyword(xlibs.rdLeatherHarnessBody ,       libs.zad_DeviousHarness                                    ) 
	RegisterDeviceByKeyword(xlibs.rdLeatherHarnessCollar ,      libs.zad_DeviousCollar                                     )
	RegisterDeviceByKeyword(xlibs.rdLeatherBlindfold ,          libs.zad_DeviousBlindfold                                 )
	RegisterDeviceByKeyword(xlibs.gagRDLeatherBall ,            libs.zad_DeviousGag                               )
	RegisterDeviceByKeyword(xlibs.gagRDLeatherRing ,           libs.zad_DeviousGag                                )
	RegisterDeviceByKeyword(xlibs.gagRDLeatherPanel ,          libs.zad_DeviousGag                                 )
	RegisterDeviceByKeyword(xlibs.gagRDLeatherStrapBall ,       libs.zad_DeviousGag                                    )
	RegisterDeviceByKeyword(xlibs.gagRDLeatherStrapRing ,       libs.zad_DeviousGag                                    )
	RegisterDeviceByKeyword(xlibs.collarPostureRDLeather ,      libs.zad_DeviousCollar                                     )
	RegisterDeviceByKeyword(xlibs.RDLblindfoldBlocking ,        libs.zad_DeviousBlindfold                                   )
	RegisterDeviceByKeyword(xlibs.RDLrestrictiveCorset ,        libs.zad_DeviousCorset                                   )
	RegisterDeviceByKeyword(xlibs.RDLrestrictiveCollar ,        libs.zad_DeviousCollar                                   )
	RegisterDeviceByKeyword(xlibs.RDLrestrictiveGloves ,       libs.zad_DeviousGloves                                    )
	RegisterDeviceByKeyword(xlibs.RDLrestrictiveBoots ,         libs.zad_DeviousBoots                                  )
	RegisterDeviceByKeyword(xlibs.rdLeatherRegularHarness ,      libs.zad_DeviousHarness                                     ) 
	RegisterDeviceByKeyword(xlibs.PonyBoots ,            libs.zad_DeviousBoots                               )
	RegisterDeviceByKeyword(xlibs.EbonitePonyBoots ,      libs.zad_DeviousBoots                                     )
	RegisterDeviceByKeyword(xlibs.RDLeatherPonyBoots ,     libs.zad_DeviousBoots                                      )
	RegisterDeviceByKeyword(xlibs.WTLeatherPonyBoots ,     libs.zad_DeviousBoots                                      )
	RegisterDeviceByKeyword(xlibs.RDEbonitePonyBoots ,      libs.zad_DeviousBoots                                     )
	RegisterDeviceByKeyword(xlibs.WTEbonitePonyBoots ,      libs.zad_DeviousBoots                                     )
	RegisterDeviceByKeyword(xlibs.zadx_HR_BridleBaseInventory ,    libs.zad_DeviousGag                                       )
	RegisterDeviceByKeyword(xlibs.zadx_HR_BridleHalfInventory ,   libs.zad_DeviousGag                                        )
	RegisterDeviceByKeyword(xlibs.zadx_HR_BridleFullInventory ,      libs.zad_DeviousGag                                     )
	RegisterDeviceByKeyword(xlibs.zadx_HR_RustyBridleBaseInventory ,    libs.zad_DeviousGag                                       )
	RegisterDeviceByKeyword(xlibs.zadx_HR_RustyBridleHalfInventory ,     libs.zad_DeviousGag                                      )
	RegisterDeviceByKeyword(xlibs.zadx_HR_RustyBridleFullInventory ,     libs.zad_DeviousGag                                      )
	;RegisterDeviceByKeyword(xlibs.zadx_HR_ChainHarnessArmsInventory ,      libs.zad_DeviousArmCuffs                                     )
	;RegisterDeviceByKeyword(xlibs.zadx_HR_ChainHarnessBodyInventory ,       libs.zad_DeviousHarness                                    )
	;RegisterDeviceByKeyword(xlibs.zadx_HR_ChainHarnessBraInventory ,         libs.zad_DeviousBra                                  )
	;RegisterDeviceByKeyword(xlibs.zadx_HR_ChainHarnessBootsInventory ,   libs.zad_DeviousBoots                                        )
	;RegisterDeviceByKeyword(xlibs.zadx_HR_ChainHarnessGlovesInventory ,     libs.zad_DeviousBondageMittens                                      )
	;RegisterDeviceByKeyword(xlibs.zadx_HR_ChainHarnessLegsInventory ,         libs.zad_DeviousLegCuffs                                  )
	;RegisterDeviceByKeyword(xlibs.zadx_HR_RustyChainHarnessArmsInventory ,    libs.zad_DeviousArmCuffs                                       )
	;RegisterDeviceByKeyword(xlibs.zadx_HR_RustyChainHarnessBodyInventory ,   libs.zad_DeviousHarness                                        )
	;RegisterDeviceByKeyword(xlibs.zadx_HR_RustyChainHarnessBraInventory ,     libs.zad_DeviousBra                                      )
	;RegisterDeviceByKeyword(xlibs.zadx_HR_RustyChainHarnessBootsInventory ,    libs.zad_DeviousBoots                                       )
	JsonUtil.Save(File, false)
	;RegisterDeviceByKeyword(xlibs.zadx_HR_RustyChainHarnessGlovesInventory ,    libs.zad_DeviousBondageMittens                                       )
	;RegisterDeviceByKeyword(xlibs.zadx_HR_RustyChainHarnessLegsInventory ,      libs.zad_DeviousLegCuffs                                     )
	RegisterDeviceByKeyword(xlibs.zadx_HR_IronPearAnalBellBlackInventory ,      libs.zad_DeviousPlugAnal                                     )
	RegisterDeviceByKeyword(xlibs.zadx_HR_IronPearAnalBlackInventory ,         libs.zad_DeviousPlugAnal                                  )
	RegisterDeviceByKeyword(xlibs.zadx_HR_IronPearAnalChainBlackInventory ,     libs.zad_DeviousPlugAnal                                      )
	RegisterDeviceByKeyword(xlibs.zadx_HR_IronPearAnalSignBlackInventory ,      libs.zad_DeviousPlugAnal                                     )
	RegisterDeviceByKeyword(xlibs.zadx_HR_IronPearVaginalBellBlackInventory ,      libs.zad_DeviousPlugVaginal                                     )
	RegisterDeviceByKeyword(xlibs.zadx_HR_IronPearVaginalBlackInventory ,      libs.zad_DeviousPlugVaginal                                     )
	RegisterDeviceByKeyword(xlibs.zadx_HR_IronPearVaginalChainBlackInventory ,  libs.zad_DeviousPlugVaginal                                         )
	RegisterDeviceByKeyword(xlibs.zadx_HR_RustyIronPearAnalInventory ,        libs.zad_DeviousPlugAnal                                   )
	RegisterDeviceByKeyword(xlibs.zadx_HR_RustyIronPearAnalBellInventory ,       libs.zad_DeviousPlugAnal                                    )
	RegisterDeviceByKeyword(xlibs.zadx_HR_RustyIronPearAnalSignInventory ,       libs.zad_DeviousPlugAnal                                    )
	RegisterDeviceByKeyword(xlibs.zadx_HR_RustyIronPearAnalChainInventory ,       libs.zad_DeviousPlugAnal                                    )
	RegisterDeviceByKeyword(xlibs.zadx_HR_RustyIronPearVaginalInventory ,           libs.zad_DeviousPlugVaginal                                )
	RegisterDeviceByKeyword(xlibs.zadx_HR_RustyIronPearVaginalBellInventory ,       libs.zad_DeviousPlugVaginal                                    )
	RegisterDeviceByKeyword(xlibs.zadx_HR_RustyIronPearVaginalChainInventory ,      libs.zad_DeviousPlugVaginal                                     )
	RegisterDeviceByKeyword(xlibs.zadx_HR_RustyNippleClampsInventory ,        libs.zad_DeviousPiercingsNipple                                   )
	RegisterDeviceByKeyword(xlibs.zadx_HR_NipplePiercingsInventory ,             libs.zad_DeviousPiercingsNipple                              )
	RegisterDeviceByKeyword(xlibs.zadx_HR_RustyNipplePiercingsInventory ,         libs.zad_DeviousPiercingsNipple                                  )
	RegisterDeviceByKeyword(xlibs.zadx_HR_PearGagInventory ,             libs.zad_DeviousGag                              )
	RegisterDeviceByKeyword(xlibs.zadx_HR_RustyPearGagInventory ,        libs.zad_DeviousGag                                   )
	RegisterDeviceByKeyword(xlibs.zadx_HR_NippleChainCollarInventory ,      libs.zad_DeviousCollar                                     )
	RegisterDeviceByKeyword(xlibs.zadx_HR_RustyNippleChainCollarInventory ,  libs.zad_DeviousCollar                                         )
	RegisterDeviceByKeyword(xlibs.zadx_HR_IronCollarInventory ,              libs.zad_DeviousCollar                             )
	RegisterDeviceByKeyword(xlibs.zadx_HR_RustyIronCollarInventory ,         libs.zad_DeviousCollar                                  )
	RegisterDeviceByKeyword(xlibs.zadx_HR_MaskofShameInventory ,          libs.zad_DeviousHood                                 )
	RegisterDeviceByKeyword(xlibs.zadx_HR_WristShacklesInventory ,         libs.zad_DeviousArmCuffs                                  )
	RegisterDeviceByKeyword(xlibs.zadx_HR_RustyWristShacklesInventory ,     libs.zad_DeviousArmCuffs                                      )
	RegisterDeviceByKeyword(xlibs.zadx_HR_IronBitGagInventory ,             libs.zad_DeviousGag                              )
	RegisterDeviceByKeyword(xlibs.zadx_HR_IronBitGagWoodInventory ,        libs.zad_DeviousGag                                   )
	RegisterDeviceByKeyword(xlibs.zadx_HR_IronRingGagInventory ,          libs.zad_DeviousGag                                 )
	RegisterDeviceByKeyword(xlibs.zadx_HR_RustyIronBitGagInventory ,        libs.zad_DeviousGag                                   )
	RegisterDeviceByKeyword(xlibs.zadx_HR_RustyIronBitGagWoodInventory ,     libs.zad_DeviousGag                                      )
	RegisterDeviceByKeyword(xlibs.zadx_HR_RustyIronRingGagInventory ,        libs.zad_DeviousGag                                   )
	RegisterDeviceByKeyword(xlibs.zadx_HR_IronBalletBootsInventory ,          libs.zad_DeviousBoots                                 )
	RegisterDeviceByKeyword(xlibs.zadx_HR_IronBalletBootsHeelInventory ,      libs.zad_DeviousBoots                                     )
	RegisterDeviceByKeyword(xlibs.zadx_HR_RustyIronBalletBootsInventory ,      libs.zad_DeviousBoots                                     )
	RegisterDeviceByKeyword(xlibs.zadx_HR_RustyIronBalletBootsHeelInventory ,     libs.zad_DeviousBoots                                      )
	RegisterDeviceByKeyword(xlibs.zadx_HR_BBYokeInventory ,          libs.zad_DeviousYokeBB                                 )
	RegisterDeviceByKeyword(xlibs.zadx_HR_PrisonerChains01Inventory ,         libs.zad_DeviousHeavyBondage                                  )
	RegisterDeviceByKeyword(xlibs.zadx_HR_RustyPrisonerChains01Inventory ,     libs.zad_DeviousHeavyBondage                                      )
	RegisterDeviceByKeyword(xlibs.zadx_HR_IronCuffsFrontInventory ,         libs.zad_DeviousArmbinder                                  )
	RegisterDeviceByKeyword(xlibs.zadx_HR_RustyIronCuffsFrontInventory ,     libs.zad_DeviousArmbinder                                      )
	RegisterDeviceByKeyword(xlibs.zadx_HobbleDressInventory ,            libs.zad_DeviousHobbleSkirt                               )
	RegisterDeviceByKeyword(xlibs.zadx_HobbleDressRedInventory ,       libs.zad_DeviousHobbleSkirt                                    )
	RegisterDeviceByKeyword(xlibs.zadx_HobbleDressWhiteInventory ,     libs.zad_DeviousHobbleSkirt                                      )
	RegisterDeviceByKeyword(xlibs.zadx_HobbleDressOpenInventory ,       libs.zad_DeviousHobbleSkirt                                    )
	RegisterDeviceByKeyword(xlibs.zadx_HobbleDressRedOpenInventory ,      libs.zad_DeviousHobbleSkirt                                     )
	RegisterDeviceByKeyword(xlibs.zadx_HobbleDressWhiteOpenInventory ,     libs.zad_DeviousHobbleSkirt                                      )
	RegisterDeviceByKeyword(xlibs.zadx_HobbleDressLatexInventory ,        libs.zad_DeviousHobbleSkirt                                   )
	RegisterDeviceByKeyword(xlibs.zadx_HobbleDressLatexRedInventory ,      libs.zad_DeviousHobbleSkirt                                     )
	RegisterDeviceByKeyword(xlibs.zadx_HobbleDressLatexWhiteInventory ,     libs.zad_DeviousHobbleSkirt                                      )
	RegisterDeviceByKeyword(xlibs.zadx_HobbleDressLatexOpenInventory ,     libs.zad_DeviousHobbleSkirt                                      )
	RegisterDeviceByKeyword(xlibs.zadx_HobbleDressLatexRedOpenInventory ,      libs.zad_DeviousHobbleSkirt                                     )
	RegisterDeviceByKeyword(xlibs.zadx_HobbleDressLatexWhiteOpenInventory ,    libs.zad_DeviousHobbleSkirt                                       )
	RegisterDeviceByKeyword(xlibs.zadx_HobbleDressRelaxedInventory ,       libs.zad_DeviousHobbleSkirtRelaxed                                    )
	RegisterDeviceByKeyword(xlibs.zadx_HobbleDressRedRelaxedInventory ,     libs.zad_DeviousHobbleSkirtRelaxed                                      )
	RegisterDeviceByKeyword(xlibs.zadx_HobbleDressWhiteRelaxedInventory ,    libs.zad_DeviousHobbleSkirtRelaxed                                       )
	RegisterDeviceByKeyword(xlibs.zadx_HobbleDressOpenRelaxedInventory ,      libs.zad_DeviousHobbleSkirtRelaxed                                     )
	RegisterDeviceByKeyword(xlibs.zadx_HobbleDressRedOpenRelaxedInventory ,     libs.zad_DeviousHobbleSkirtRelaxed                                      )
	RegisterDeviceByKeyword(xlibs.zadx_HobbleDressWhiteOpenRelaxedInventory ,   libs.zad_DeviousHobbleSkirtRelaxed                                        )
	RegisterDeviceByKeyword(xlibs.zadx_HobbleDressLatexRelaxedInventory ,         libs.zad_DeviousHobbleSkirtRelaxed                                  )
	RegisterDeviceByKeyword(xlibs.zadx_HobbleDressLatexRedRelaxedInventory ,      libs.zad_DeviousHobbleSkirtRelaxed                                     )
	RegisterDeviceByKeyword(xlibs.zadx_HobbleDressLatexWhiteRelaxedInventory ,     libs.zad_DeviousHobbleSkirtRelaxed                                      )
	RegisterDeviceByKeyword(xlibs.zadx_HobbleDressLatexOpenRelaxedInventory ,         libs.zad_DeviousHobbleSkirtRelaxed                                  )
	RegisterDeviceByKeyword(xlibs.zadx_HobbleDressLatexRedOpenRelaxedInventory ,   libs.zad_DeviousHobbleSkirtRelaxed                                        )
	RegisterDeviceByKeyword(xlibs.zadx_HobbleDressLatexWhiteOpenRelaxedInventory ,      libs.zad_DeviousHobbleSkirtRelaxed                                     )
	RegisterDeviceByKeyword(xlibs.zadx_ElegantHobbleDressInventory ,    libs.zad_DeviousHobbleSkirt                                       )
	RegisterDeviceByKeyword(xlibs.zadx_ElegantHobbleDressRedInventory ,     libs.zad_DeviousHobbleSkirt                                      )
	RegisterDeviceByKeyword(xlibs.zadx_ElegantHobbleDressWhiteInventory ,    libs.zad_DeviousHobbleSkirt                                       )
	RegisterDeviceByKeyword(xlibs.zadx_ElegantHobbleDressLatexInventory ,       libs.zad_DeviousHobbleSkirt                                    )
	RegisterDeviceByKeyword(xlibs.zadx_ElegantHobbleDressLatexRedInventory ,     libs.zad_DeviousHobbleSkirt                                      )
	RegisterDeviceByKeyword(xlibs.zadx_ElegantHobbleDressLatexWhiteInventory ,   libs.zad_DeviousHobbleSkirt                                        )
	RegisterDeviceByKeyword(xlibs.zadx_SlaveHighHeelsInventory ,             libs.zad_DeviousBoots                              )
	RegisterDeviceByKeyword(xlibs.zadx_SlaveHighHeelsRedInventory ,        libs.zad_DeviousBoots                                   )
	RegisterDeviceByKeyword(xlibs.zadx_SlaveHighHeelsWhiteInventory ,       libs.zad_DeviousBoots                                    )
	RegisterDeviceByKeyword(xlibs.zadx_PawBondageMittensInventory ,         libs.zad_DeviousBondageMittens                                  )
	RegisterDeviceByKeyword(xlibs.zadx_PawBondageMittensRedInventory ,       libs.zad_DeviousBondageMittens                                    )
	RegisterDeviceByKeyword(xlibs.zadx_PawBondageMittensWhiteInventory ,      libs.zad_DeviousBondageMittens                                     )
	RegisterDeviceByKeyword(xlibs.zadx_PawBondageMittensLatexInventory ,       libs.zad_DeviousBondageMittens                                    )
	RegisterDeviceByKeyword(xlibs.zadx_PawBondageMittensRedLatexInventory ,     libs.zad_DeviousBondageMittens                                      )
	RegisterDeviceByKeyword(xlibs.zadx_PawBondageMittensWhiteLatexInventory ,    libs.zad_DeviousBondageMittens                                       )
	RegisterDeviceByKeyword(xlibs.zadx_StraitJacketLeatherLegsBlackInventory ,    libs.zad_DeviousStraitJacket                                       )
	RegisterDeviceByKeyword(xlibs.zadx_StraitJacketLeatherLegsRedInventory ,       libs.zad_DeviousStraitJacket                                    )
	RegisterDeviceByKeyword(xlibs.zadx_StraitJacketLeatherLegsWhiteInventory ,     libs.zad_DeviousStraitJacket                                      )
	RegisterDeviceByKeyword(xlibs.zadx_StraitJacketLatexLegsBlackInventory ,         libs.zad_DeviousStraitJacket                                  )
	RegisterDeviceByKeyword(xlibs.zadx_StraitJacketLatexLegsRedInventory ,          libs.zad_DeviousStraitJacket                                 )
	RegisterDeviceByKeyword(xlibs.zadx_StraitJacketLatexLegsWhiteInventory ,        libs.zad_DeviousStraitJacket                                   )
	JsonUtil.Save(File, false)
	RegisterDeviceByKeyword(xlibs.zadx_StraitJacketLeatherBlackInventory ,          libs.zad_DeviousStraitJacket                                 )
	RegisterDeviceByKeyword(xlibs.zadx_StraitJacketLeatherRedInventory ,            libs.zad_DeviousStraitJacket                               )
	RegisterDeviceByKeyword(xlibs.zadx_StraitJacketLeatherWhiteInventory ,          libs.zad_DeviousStraitJacket                                 )
	RegisterDeviceByKeyword(xlibs.zadx_StraitJacketLatexBlackInventory ,           libs.zad_DeviousStraitJacket                                )
	RegisterDeviceByKeyword(xlibs.zadx_StraitJacketLatexRedInventory ,            libs.zad_DeviousStraitJacket                               )
	RegisterDeviceByKeyword(xlibs.zadx_StraitJacketLatexWhiteInventory ,           libs.zad_DeviousStraitJacket                                )
	RegisterDeviceByKeyword(xlibs.zadx_StraitJacketLeatherToplessBlackInventory ,   libs.zad_DeviousStraitJacket                                        )
	RegisterDeviceByKeyword(xlibs.zadx_StraitJacketLeatherToplessRedInventory ,     libs.zad_DeviousStraitJacket                                      )
	RegisterDeviceByKeyword(xlibs.zadx_StraitJacketLeatherToplessWhiteInventory ,   libs.zad_DeviousStraitJacket                                        )
	RegisterDeviceByKeyword(xlibs.zadx_StraitJacketLatexToplessBlackInventory ,     libs.zad_DeviousStraitJacket                                      )
	RegisterDeviceByKeyword(xlibs.zadx_StraitJacketLatexToplessRedInventory ,      libs.zad_DeviousStraitJacket                                     )
	RegisterDeviceByKeyword(xlibs.zadx_StraitJacketLatexToplessWhiteInventory ,      libs.zad_DeviousStraitJacket                                     )
	RegisterDeviceByKeyword(xlibs.zadx_StraitJacketLeatherLegsToplessBlackInventory ,  libs.zad_DeviousStraitJacket                                         )
	RegisterDeviceByKeyword(xlibs.zadx_StraitJacketLeatherLegsToplessRedInventory ,     libs.zad_DeviousStraitJacket                                      )
	RegisterDeviceByKeyword(xlibs.zadx_StraitJacketLeatherLegsToplessWhiteInventory ,   libs.zad_DeviousStraitJacket                                        )
	RegisterDeviceByKeyword(xlibs.zadx_StraitJacketLatexLegsToplessBlackInventory ,      libs.zad_DeviousStraitJacket                                     )
	RegisterDeviceByKeyword(xlibs.zadx_StraitJacketLatexLegsToplessRedInventory ,       libs.zad_DeviousStraitJacket                                    )
	RegisterDeviceByKeyword(xlibs.zadx_StraitJacketLatexLegsToplessWhiteInventory ,     libs.zad_DeviousStraitJacket                                      )
	RegisterDeviceByKeyword(xlibs.zadx_StraitJacketLatexDressBlackInventory ,            libs.zad_DeviousStraitJacket                               )
	RegisterDeviceByKeyword(xlibs.zadx_StraitJacketLatexDressToplessBlackInventory ,       libs.zad_DeviousStraitJacket                                    )
	RegisterDeviceByKeyword(xlibs.zadx_dud_Pony_BitGag_Chin_Ebonite_BlackInventory ,       libs.zad_DeviousGag                                    )
	RegisterDeviceByKeyword(xlibs.zadx_dud_Pony_BitGag_Chin_Leather_BlackInventory ,       libs.zad_DeviousGag                                    )
	RegisterDeviceByKeyword(xlibs.zadx_dud_Pony_BitGag_Simple_Ebonite_BlackInventory ,     libs.zad_DeviousGag                                      )
	RegisterDeviceByKeyword(xlibs.zadx_dud_Pony_BitGag_Simple_Leather_BlackInventory ,      libs.zad_DeviousGag                                    )
	RegisterDeviceByKeyword(xlibs.zadx_dud_Pony_Harness_Blinders_Leather_BlackInventory ,   libs.zad_DeviousGag                                        )
	RegisterDeviceByKeyword(xlibs.zadx_dud_Pony_Harness_Blinders_Ebonite_BlackInventory ,   libs.zad_DeviousGag                                        )
	RegisterDeviceByKeyword(xlibs.zadx_dud_Pony_Harness_Ears_Leather_BlackInventory ,       libs.zad_DeviousGag                                    )
	RegisterDeviceByKeyword(xlibs.zadx_dud_Pony_Harness_Ears_Ebonite_BlackInventory ,       libs.zad_DeviousGag                                    )
	RegisterDeviceByKeyword(xlibs.zadx_dud_Pony_Harness_Secure_Leather_BlackInventory ,     libs.zad_DeviousGag                                      )
	RegisterDeviceByKeyword(xlibs.zadx_dud_Pony_Harness_Secure_Ebonite_BlackInventory ,           libs.zad_DeviousGag                                )
	RegisterDeviceByKeyword(xlibs.zadx_dud_Pony_BitGag_Chin_White_Ebonite_Inventory ,              libs.zad_DeviousGag                             )
	RegisterDeviceByKeyword(xlibs.zadx_dud_Pony_BitGag_Chin_White_Leather_Inventory ,      libs.zad_DeviousGag                                     )
	RegisterDeviceByKeyword(xlibs.zadx_dud_Pony_BitGag_Simple_White_Ebonite_Inventory ,  libs.zad_DeviousGag                                         )
	RegisterDeviceByKeyword(xlibs.zadx_dud_Pony_BitGag_Simple_White_Leather_Inventory ,   libs.zad_DeviousGag                                        )
	RegisterDeviceByKeyword(xlibs.zadx_dud_Pony_Harness_Blinders_White_Leather_Inventory , libs.zad_DeviousGag                                          )
	RegisterDeviceByKeyword(xlibs.zadx_dud_Pony_Harness_Blinders_White_Ebonite_Inventory ,  libs.zad_DeviousGag                                         )
	RegisterDeviceByKeyword(xlibs.zadx_dud_Pony_Harness_Ears_White_Leather_Inventory ,      libs.zad_DeviousGag                                     )
	RegisterDeviceByKeyword(xlibs.zadx_dud_Pony_Harness_Ears_White_Ebonite_Inventory ,      libs.zad_DeviousGag                                     )
	RegisterDeviceByKeyword(xlibs.zadx_dud_Pony_Harness_Secure_White_Leather_Inventory ,     libs.zad_DeviousGag                                      )
	RegisterDeviceByKeyword(xlibs.zadx_dud_Pony_Harness_Secure_White_Ebonite_Inventory ,     libs.zad_DeviousGag                                      )
	RegisterDeviceByKeyword(xlibs.zadx_dud_Pony_BitGag_Chin_Red_Ebonite_Inventory ,         libs.zad_DeviousGag                                  )
	RegisterDeviceByKeyword(xlibs.zadx_dud_Pony_BitGag_Chin_Red_Leather_Inventory ,         libs.zad_DeviousGag                                  )
	RegisterDeviceByKeyword(xlibs.zadx_dud_Pony_BitGag_Simple_Red_Ebonite_Inventory ,       libs.zad_DeviousGag                                    )
	RegisterDeviceByKeyword(xlibs.zadx_dud_Pony_BitGag_Simple_Red_Leather_Inventory ,        libs.zad_DeviousGag                                   )
	RegisterDeviceByKeyword(xlibs.zadx_dud_Pony_Harness_Blinders_Red_Leather_Inventory ,      libs.zad_DeviousGag                                     )
	RegisterDeviceByKeyword(xlibs.zadx_dud_Pony_Harness_Blinders_Red_Ebonite_Inventory ,     libs.zad_DeviousGag                                      )
	RegisterDeviceByKeyword(xlibs.zadx_dud_Pony_Harness_Ears_Red_Leather_Inventory ,          libs.zad_DeviousGag                                 )
	RegisterDeviceByKeyword(xlibs.zadx_dud_Pony_Harness_Ears_Red_Ebonite_Inventory ,         libs.zad_DeviousGag                                  )
	RegisterDeviceByKeyword(xlibs.zadx_dud_Pony_Harness_Secure_Red_Leather_Inventory ,         libs.zad_DeviousGag                                  )
	RegisterDeviceByKeyword(xlibs.zadx_dud_Pony_Harness_Secure_Red_Ebonite_Inventory ,      libs.zad_DeviousGag                                     )
	RegisterDeviceByKeyword(xlibs.zadx_restrictiveBootsTrans_Inventory ,             libs.zad_DeviousBoots                              )
	RegisterDeviceByKeyword(xlibs.zadx_restrictiveCollarTrans_Inventory ,        libs.zad_DeviousCollar                                   )
	RegisterDeviceByKeyword(xlibs.zadx_restrictiveCorsetTrans_Inventory ,        libs.zad_DeviousCorset                                   )
	JsonUtil.Save(File, false)
	RegisterDeviceByKeyword(xlibs.zadx_chastitybelt_Padded_Gold_Inventory ,   libs.zad_DeviousBelt                                        )
	RegisterDeviceByKeyword(xlibs.zadx_chastitybra_Padded_Gold_Inventory ,       libs.zad_DeviousBra                                    )
	RegisterDeviceByKeyword(xlibs.zadx_chastitybelt_Padded_Silver_Inventory ,   libs.zad_DeviousBelt                                        )
	RegisterDeviceByKeyword(xlibs.zadx_chastitybra_Padded_Silver_Inventory ,    libs.zad_DeviousBra                                       )
	RegisterDeviceByKeyword(xlibs.zadx_Collar_Posture_Gold_Inventory ,         libs.zad_DeviousCollar                                  )
	RegisterDeviceByKeyword(xlibs.zadx_Collar_Posture_Silver_Inventory ,          libs.zad_DeviousCollar                                 )
	RegisterDeviceByKeyword(xlibs.zadx_cuffs_Padded_Arms_Gold_Inventory ,         libs.zad_DeviousArmCuffs                                  )
	RegisterDeviceByKeyword(xlibs.zadx_cuffs_Padded_Legs_Gold_Inventory ,         libs.zad_DeviousLegCuffs                                  )
	RegisterDeviceByKeyword(xlibs.zadx_cuffs_Padded_Collar_Gold_Inventory ,       libs.zad_DeviousCollar                                    )
	RegisterDeviceByKeyword(xlibs.zadx_cuffs_Padded_Arms_Silver_Inventory ,       libs.zad_DeviousArmCuffs                                    )
	RegisterDeviceByKeyword(xlibs.zadx_cuffs_Padded_Legs_Silver_Inventory ,       libs.zad_DeviousLegCuffs                                    )
	RegisterDeviceByKeyword(xlibs.zadx_cuffs_Padded_Collar_Silver_Inventory ,       libs.zad_DeviousCollar                                    )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_black_Inventory ,           libs.zad_DeviousSuit                                )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_blue_Inventory ,           libs.zad_DeviousSuit                                )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_cyan_Inventory ,            libs.zad_DeviousSuit                               )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_dgreen_Inventory ,           libs.zad_DeviousSuit                                )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_dgrey_Inventory ,            libs.zad_DeviousSuit                               )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_dred_Inventory ,             libs.zad_DeviousSuit                              )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gold_Inventory ,             libs.zad_DeviousSuit                              )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_green_Inventory ,            libs.zad_DeviousSuit                               )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_lgrey_Inventory ,            libs.zad_DeviousSuit                               )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_orange_Inventory ,           libs.zad_DeviousSuit                                )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_pink_Inventory ,             libs.zad_DeviousSuit                              )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_purple_Inventory ,           libs.zad_DeviousSuit                                )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_red_Inventory ,              libs.zad_DeviousSuit                             )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_redwhite_Inventory ,          libs.zad_DeviousSuit                                 )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_white_Inventory ,           libs.zad_DeviousSuit                                )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_yellow_Inventory ,          libs.zad_DeviousSuit                                 )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_balletboots_black_Inventory ,    libs.zad_DeviousBoots                                       )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_balletboots_blue_Inventory ,     libs.zad_DeviousBoots                                      )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_balletboots_cyan_Inventory ,      libs.zad_DeviousBoots                                     )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_balletboots_dgreen_Inventory ,     libs.zad_DeviousBoots                                      )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_balletboots_dgrey_Inventory ,      libs.zad_DeviousBoots                                     )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_balletboots_dred_Inventory ,        libs.zad_DeviousBoots                                   )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_balletboots_gold_Inventory ,       libs.zad_DeviousBoots                                    )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_balletboots_green_Inventory ,      libs.zad_DeviousBoots                                     )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_balletboots_lgrey_Inventory ,       libs.zad_DeviousBoots                                    )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_balletboots_orange_Inventory ,      libs.zad_DeviousBoots                                     )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_balletboots_pink_Inventory ,        libs.zad_DeviousBoots                                   )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_balletboots_purple_Inventory ,      libs.zad_DeviousBoots                                     )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_balletboots_red_Inventory ,         libs.zad_DeviousBoots                                  )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_balletboots_white_Inventory ,       libs.zad_DeviousBoots                                    )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_balletboots_yellow_Inventory ,      libs.zad_DeviousBoots                                     )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_collar_black_Inventory ,        libs.zad_DeviousCollar                                   )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_collar_blue_Inventory ,         libs.zad_DeviousCollar                                  )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_collar_cyan_Inventory ,         libs.zad_DeviousCollar                                  )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_collar_dgreen_Inventory ,       libs.zad_DeviousCollar                                    )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_collar_dgrey_Inventory ,        libs.zad_DeviousCollar                                   )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_collar_dred_Inventory ,         libs.zad_DeviousCollar                                  )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_collar_gold_Inventory ,          libs.zad_DeviousCollar                                 )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_collar_green_Inventory ,         libs.zad_DeviousCollar                                  )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_collar_lgrey_Inventory ,          libs.zad_DeviousCollar                                 )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_collar_orange_Inventory ,  libs.zad_DeviousCollar)
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_collar_pink_Inventory ,          libs.zad_DeviousCollar                                 )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_collar_purple_Inventory ,           libs.zad_DeviousCollar                                )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_collar_red_Inventory ,               libs.zad_DeviousCollar                            )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_collar_white_Inventory ,          libs.zad_DeviousCollar                                 )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_collar_yellow_Inventory ,         libs.zad_DeviousCollar                                  )                         
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_longgloves_black_Inventory ,      libs.zad_DeviousGloves                                     )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_longgloves_blue_Inventory ,        libs.zad_DeviousGloves                                   )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_longgloves_cyan_Inventory ,         libs.zad_DeviousGloves                                  )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_longgloves_dgreen_Inventory ,        libs.zad_DeviousGloves                                   )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_longgloves_dgrey_Inventory ,           libs.zad_DeviousGloves                                )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_longgloves_dred_Inventory ,              libs.zad_DeviousGloves                             )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_longgloves_gold_Inventory ,              libs.zad_DeviousGloves                             )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_longgloves_green_Inventory ,            libs.zad_DeviousGloves                               )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_longgloves_lgrey_Inventory ,         libs.zad_DeviousGloves                                  )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_longgloves_orange_Inventory ,        libs.zad_DeviousGloves                                   )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_longgloves_pink_Inventory ,          libs.zad_DeviousGloves                                 )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_longgloves_purple_Inventory ,        libs.zad_DeviousGloves                                   )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_longgloves_red_Inventory ,            libs.zad_DeviousGloves                               )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_longgloves_white_Inventory ,       libs.zad_DeviousGloves                                    )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_longgloves_yellow_Inventory ,     libs.zad_DeviousGloves                                      )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_black_Inventory ,         libs.zad_DeviousHood                                  )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_transparent_Inventory ,        libs.zad_DeviousSuit                                   )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_boots_transparent_Inventory ,   libs.zad_DeviousBoots                                        )
	RegisterDeviceByKeyword(xlibs.zadx_hood_rubber_black_Inventory ,           libs.zad_DeviousHood                                )
	RegisterDeviceByKeyword(xlibs.zadx_hood_leather_black_Inventory ,          libs.zad_DeviousHood                                 )
	RegisterDeviceByKeyword(xlibs.zadx_hood_rubber_openeyesmouth_black_Inventory ,      libs.zad_DeviousHood                                     )
	RegisterDeviceByKeyword(xlibs.zadx_hood_rubber_openeyes_black_Inventory ,          libs.zad_DeviousHood                                 )
	RegisterDeviceByKeyword(xlibs.zadx_hood_rubber_openface_black_Inventory ,       libs.zad_DeviousHood                                    )
	RegisterDeviceByKeyword(xlibs.zadx_yoke_steel_Inventory ,      libs.zad_DeviousYoke                                     )
	RegisterDeviceByKeyword(xlibs.zadx_shackles_steel_Inventory ,         libs.zad_DeviousArmbinder                                  )
	RegisterDeviceByKeyword(xlibs.zadx_AnkleShackles_Black_Inventory ,      libs.zad_DeviousAnkleShackles                                     )
	RegisterDeviceByKeyword(xlibs.zadx_AnkleShackles_Silver_Inventory ,      libs.zad_DeviousAnkleShackles                                     )
	RegisterDeviceByKeyword(xlibs.zadx_ElbowbinderInventory ,         libs.zad_DeviousArmbinderElbow                                  )
	RegisterDeviceByKeyword(xlibs.zadx_ElbowbinderRedInventory ,       libs.zad_DeviousArmbinderElbow                                    )
	RegisterDeviceByKeyword(xlibs.zadx_ElbowbinderWhiteInventory ,      libs.zad_DeviousArmbinderElbow                                     )
	RegisterDeviceByKeyword(xlibs.zadx_ElbowbinderEboniteInventory ,      libs.zad_DeviousArmbinderElbow                                     )
	RegisterDeviceByKeyword(xlibs.zadx_ElbowbinderEboniteRedInventory ,       libs.zad_DeviousArmbinderElbow                                    )
	RegisterDeviceByKeyword(xlibs.zadx_ElbowbinderEboniteWhiteInventory ,     libs.zad_DeviousArmbinderElbow                                      )
	RegisterDeviceByKeyword(xlibs.zadx_GagEboniteStrapBallBig_Inventory ,      libs.zad_DeviousGag                                     )
	RegisterDeviceByKeyword(xlibs.zadx_GagEboniteHarnessBallBig_Inventory ,     libs.zad_DeviousGag                                      )
	RegisterDeviceByKeyword(xlibs.zadx_blindfold_Rope_Inventory ,           libs.zad_DeviousBlindfold                                )
	RegisterDeviceByKeyword(xlibs.zadx_gag_rope_ball_Inventory ,         libs.zad_DeviousGag                                  )
	RegisterDeviceByKeyword(xlibs.zadx_gag_rope_bit_Inventory ,          libs.zad_DeviousGag                                 )
	RegisterDeviceByKeyword(xlibs.zadx_Collar_Rope_1_Inventory ,          libs.zad_DeviousCollar                                 )
	RegisterDeviceByKeyword(xlibs.zadx_Collar_Rope_2_Inventory ,         libs.zad_DeviousCollar                                  )
	RegisterDeviceByKeyword(xlibs.zadx_Armbinder_Rope_Inventory ,         libs.zad_DeviousArmbinder                                  )
	RegisterDeviceByKeyword(xlibs.zadx_Armbinder_Rope_Strict_Inventory ,      libs.zad_DeviousArmbinderElbow                                     )
	RegisterDeviceByKeyword(xlibs.zadx_Harness_Rope_Full_Inventory ,         libs.zad_DeviousHarness                                  )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_blue_Inventory ,     libs.zad_DeviousHood                                      )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_cyan_Inventory ,      libs.zad_DeviousHood                                     )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_dgreen_Inventory ,      libs.zad_DeviousHood                                     )
	JsonUtil.Save(File, false)
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_dgrey_Inventory ,       libs.zad_DeviousHood                                    )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_dred_Inventory ,        libs.zad_DeviousHood                                   )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_gold_Inventory ,         libs.zad_DeviousHood                                  )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_green_Inventory ,        libs.zad_DeviousHood                                   )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_lgrey_Inventory ,       libs.zad_DeviousHood                                    )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_orange_Inventory ,       libs.zad_DeviousHood                                    )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_pink_Inventory ,         libs.zad_DeviousHood                                  )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_purple_Inventory ,     libs.zad_DeviousHood                                      )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_red_Inventory ,         libs.zad_DeviousHood                                  )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_white_Inventory ,       libs.zad_DeviousHood                                    )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_yellow_Inventory ,     libs.zad_DeviousHood                                      )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_filter_black_Inventory ,     libs.zad_DeviousHood                                      )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_filter_blue_Inventory ,      libs.zad_DeviousHood                                     )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_filter_cyan_Inventory ,       libs.zad_DeviousHood                                    )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_filter_dgreen_Inventory ,      libs.zad_DeviousHood                                     )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_filter_dgrey_Inventory ,      libs.zad_DeviousHood                                     )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_filter_dred_Inventory ,       libs.zad_DeviousHood                                    )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_filter_gold_Inventory ,        libs.zad_DeviousHood                                   )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_filter_green_Inventory ,       libs.zad_DeviousHood                                    )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_filter_lgrey_Inventory ,       libs.zad_DeviousHood                                    )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_filter_orange_Inventory ,     libs.zad_DeviousHood                                      )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_filter_pink_Inventory ,        libs.zad_DeviousHood                                   )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_filter_purple_Inventory ,     libs.zad_DeviousHood                                      )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_filter_red_Inventory ,       libs.zad_DeviousHood                                    )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_filter_white_Inventory ,     libs.zad_DeviousHood                                      )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_filter_yellow_Inventory ,    libs.zad_DeviousHood                                       )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_rebr_black_Inventory ,     libs.zad_DeviousHood                                      )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_rebr_blue_Inventory ,       libs.zad_DeviousHood                                    )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_rebr_cyan_Inventory ,      libs.zad_DeviousHood                                     )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_rebr_dgreen_Inventory ,    libs.zad_DeviousHood                                       )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_rebr_dgrey_Inventory ,    libs.zad_DeviousHood                                       )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_rebr_dred_Inventory ,    libs.zad_DeviousHood                                       )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_rebr_gold_Inventory ,    libs.zad_DeviousHood                                      )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_rebr_green_Inventory ,   libs.zad_DeviousHood                                        )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_rebr_lgrey_Inventory ,  libs.zad_DeviousHood                                         )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_rebr_orange_Inventory , libs.zad_DeviousHood                                          )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_rebr_pink_Inventory ,     libs.zad_DeviousHood                                      )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_rebr_purple_Inventory ,   libs.zad_DeviousHood                                        )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_rebr_red_Inventory ,     libs.zad_DeviousHood                                      )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_rebr_white_Inventory ,   libs.zad_DeviousHood                                        )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_rebr_yellow_Inventory ,  libs.zad_DeviousHood                                         )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_tube_black_Inventory ,   libs.zad_DeviousHood                                        )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_tube_blue_Inventory ,    libs.zad_DeviousHood                                       )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_tube_cyan_Inventory ,     libs.zad_DeviousHood                                      )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_tube_dgreen_Inventory ,    libs.zad_DeviousHood                                       )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_tube_dgrey_Inventory ,       libs.zad_DeviousHood                                    )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_tube_dred_Inventory ,      libs.zad_DeviousHood                                     )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_tube_gold_Inventory ,     libs.zad_DeviousHood                                      )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_tube_green_Inventory ,     libs.zad_DeviousHood                                      )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_tube_lgrey_Inventory ,     libs.zad_DeviousHood                                      )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_tube_orange_Inventory ,    libs.zad_DeviousHood                                       )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_tube_pink_Inventory ,     libs.zad_DeviousHood                                      )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_tube_purple_Inventory ,   libs.zad_DeviousHood                                        )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_tube_red_Inventory ,     libs.zad_DeviousHood                                      )
	JsonUtil.Save(File, false)
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_tube_white_Inventory ,  libs.zad_DeviousHood                                         )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gasmask_tube_yellow_Inventory ,   libs.zad_DeviousHood                                        )
	RegisterDeviceByKeyword(xlibs.zadx_HR_PlugPonyTail01Inventory ,          libs.zad_DeviousPlugAnal                                 )
	RegisterDeviceByKeyword(xlibs.zadx_HR_PlugPonyTail02BowInventory ,         libs.zad_DeviousPlugAnal                                  )
	RegisterDeviceByKeyword(xlibs.zadx_HR_PlugPonyTail02Inventory ,           libs.zad_DeviousPlugAnal                                )
	RegisterDeviceByKeyword(xlibs.zadx_HR_PlugPonyTail03Inventory ,           libs.zad_DeviousPlugAnal                                )
	RegisterDeviceByKeyword(xlibs.zadx_HR_IronCollarChain01Inventory ,       libs.zad_DeviousCollar                                    )
	RegisterDeviceByKeyword(xlibs.zadx_HR_IronCollarChain01x2Inventory ,      libs.zad_DeviousCollar                                     )
	RegisterDeviceByKeyword(xlibs.zadx_HR_IronCollarChain01x3Inventory ,       libs.zad_DeviousCollar                                    )
	RegisterDeviceByKeyword(xlibs.zadx_HR_IronCollarChain01x4Inventory ,        libs.zad_DeviousCollar                                   )
	RegisterDeviceByKeyword(xlibs.zadx_HR_RustyIronCollarChain01Inventory ,     libs.zad_DeviousCollar                                      )
	RegisterDeviceByKeyword(xlibs.zadx_HR_RustyIronCollarChain01x2Inventory ,    libs.zad_DeviousCollar                                       )
	RegisterDeviceByKeyword(xlibs.zadx_HR_RustyIronCollarChain01x3Inventory ,    libs.zad_DeviousCollar                                       )
	RegisterDeviceByKeyword(xlibs.zadx_HR_RustyIronCollarChain01x4Inventory ,     libs.zad_DeviousCollar                                      )
	RegisterDeviceByKeyword(xlibs.zadx_ZaZ_IronChainShacklesInventory ,        libs.zad_deviousankleshackles                                   )
	RegisterDeviceByKeyword(xlibs.zadx_ZaZ_RustyIronChainShacklesInventory ,     libs.zad_deviousankleshackles                                      )
	RegisterDeviceByKeyword(xlibs.zadx_HR_BallChain01Inventory ,       libs.zad_DeviousAnkleShackles                                    )
	RegisterDeviceByKeyword(xlibs.zadx_HR_BallChain02Inventory ,        libs.zad_DeviousAnkleShackles                                   )
	RegisterDeviceByKeyword(xlibs.zadx_HR_RustyBallChain01Inventory ,      libs.zad_DeviousAnkleShackles                                     )
	RegisterDeviceByKeyword(xlibs.zadx_HR_RustyBallChain02Inventory ,    libs.zad_DeviousAnkleShackles                                       )
	RegisterDeviceByKeyword(xlibs.zadx_HobbleDressTransparentInventory ,    libs.zad_DeviousHobbleSkirt                                       )
	RegisterDeviceByKeyword(xlibs.zadx_hood_rubber_transparent_Inventory ,      libs.zad_DeviousHood                                     )
	RegisterDeviceByKeyword(xlibs.zadx_hood_rubber_openface_transparent_Inventory ,     libs.zad_DeviousHood                                      )
	RegisterDeviceByKeyword(xlibs.zadx_hood_rubber_openeyesmouth_transparent_Inventory ,  libs.zad_DeviousHood                                         )
	RegisterDeviceByKeyword(xlibs.zadx_gag_facemask_biz_black_Inventory ,        libs.zad_DeviousHood                                   )
	RegisterDeviceByKeyword(xlibs.zadx_gag_facemask_biz_transparent_Inventory ,   libs.zad_DeviousHood                                        )
	RegisterDeviceByKeyword(xlibs.zadx_XinEbonitePonyBoots_Play_Inventory ,      libs.zad_DeviousBoots                                     )
	RegisterDeviceByKeyword(xlibs2.zadx_PetSuit_Black_Inventory ,      libs.zad_DeviousPetSuit                                     )
	RegisterDeviceByKeyword(xlibs2.zadx_PetSuit_Red_Inventory ,        libs.zad_DeviousPetSuit                                   )
	RegisterDeviceByKeyword(xlibs2.zadx_PetSuit_White_Inventory ,          libs.zad_DeviousPetSuit                                 )
	RegisterDeviceByKeyword(xlibs2.zadx_PetSuit_Ebonite_Black_Inventory ,    libs.zad_DeviousPetSuit                                       )
	RegisterDeviceByKeyword(xlibs2.zadx_PetSuit_Ebonite_Red_Inventory ,      libs.zad_DeviousPetSuit                                     )
	RegisterDeviceByKeyword(xlibs2.zadx_PetSuit_Ebonite_White_Inventory ,     libs.zad_DeviousPetSuit                                      )
	RegisterDeviceByKeyword(xlibs2.zadx_gag_tape_Inventory ,                   libs.zad_DeviousGag                        )
	RegisterDeviceByKeyword(xlibs2.zadx_gag_tape_large_Inventory ,             libs.zad_DeviousGag                              )
	RegisterDeviceByKeyword(xlibs2.zadx_gag_tape_full_Inventory ,              libs.zad_DeviousGag                             )
	;RegisterDeviceByKeyword(xlibs.zadx_catsuit_longgloves_transparent_Inventory ,    libs.zad_DeviousGloves                                       ) Currently not working`
	;RegisterDeviceByKeyword(xlibs.zadx_HR_RustyChainHarnessNippleInventory ,     libs.zad_DeviousCollar                                      )
	;RegisterDeviceByKeyword(xlibs.zadx_HR_ChainHarnessNippleInventory ,    libs.zad_DeviousPiercingsNipple                                       )Not Complete
	JsonUtil.Save(File, false)
	StorUtilBuilt = True
endFunction

Function RegisterCatsuitSockandHand() ; These items look back or incomplete this shouldn't be used but if here if a modder wants to.
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gloves_black_Inventory ,       libs.zad_DeviousGloves                                    )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gloves_blue_Inventory ,            libs.zad_DeviousGloves                               )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gloves_cyan_Inventory ,          libs.zad_DeviousGloves                                 )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gloves_dgreen_Inventory ,        libs.zad_DeviousGloves                                   )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gloves_dgrey_Inventory ,         libs.zad_DeviousGloves                                  )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gloves_dred_Inventory ,         libs.zad_DeviousGloves                                  )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gloves_gold_Inventory ,           libs.zad_DeviousGloves                                )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gloves_green_Inventory ,         libs.zad_DeviousGloves                                  )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gloves_lgrey_Inventory ,          libs.zad_DeviousGloves                                 )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gloves_orange_Inventory ,         libs.zad_DeviousGloves                                  )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gloves_pink_Inventory ,          libs.zad_DeviousGloves                                 )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gloves_purple_Inventory ,        libs.zad_DeviousGloves                                   )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gloves_red_Inventory ,           libs.zad_DeviousGloves                                )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gloves_white_Inventory ,        libs.zad_DeviousGloves                                   )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gloves_redwhite_Inventory ,      libs.zad_DeviousGloves                                     )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_gloves_yellow_Inventory ,         libs.zad_DeviousGloves     )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_boots_black_Inventory ,           libs.zad_DeviousBoots                                )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_boots_blue_Inventory ,           libs.zad_DeviousBoots                                )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_boots_cyan_Inventory ,          libs.zad_DeviousBoots                                 )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_boots_dgreen_Inventory ,        libs.zad_DeviousBoots                                   )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_boots_dgrey_Inventory ,        libs.zad_DeviousBoots                                   )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_boots_dred_Inventory ,         libs.zad_DeviousBoots                                  )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_boots_gold_Inventory ,         libs.zad_DeviousBoots                                  )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_boots_green_Inventory ,        libs.zad_DeviousBoots                                   )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_boots_lgrey_Inventory ,        libs.zad_DeviousBoots                                   )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_boots_orange_Inventory ,       libs.zad_DeviousBoots                                    )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_boots_pink_Inventory ,         libs.zad_DeviousBoots                                  )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_boots_purple_Inventory ,       libs.zad_DeviousBoots                                    )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_boots_red_Inventory ,          libs.zad_DeviousBoots                                 )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_boots_redwhite_Inventory ,     libs.zad_DeviousBoots                                      )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_boots_white_Inventory ,        libs.zad_DeviousBoots                                   )
	RegisterDeviceByKeyword(xlibs.zadx_catsuit_boots_yellow_Inventory ,       libs.zad_DeviousBoots                                    )

endFunction