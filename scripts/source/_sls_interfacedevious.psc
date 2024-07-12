Scriptname _SLS_InterfaceDevious extends Quest Conditional

Import JsonUtil

Event OnInit()
	RegisterForModEvent("_SLS_Int_PlayerLoadsGame", "On_SLS_Int_PlayerLoadsGame")
EndEvent

Event On_SLS_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
	PlayerLoadsGame()
EndEvent

Function PlayerLoadsGame()
	If Game.GetModByName("Devious Devices - Expansion.esm") != 255
		If GetState() != "Installed"
			GoToState("Installed")
		EndIf
	
	Else
		If GetState() != ""
			GoToState("")
		EndIf
	EndIf
EndFunction

Bool Function GetIsInterfaceActive()
	If GetState() == "Installed"
		Return true
	EndIf
	Return false
EndFunction

Event OnEndState()
	Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet.
	
	libsQuest = Game.GetFormFromFile(0x00F624, "Devious Devices - Integration.esm") as Quest
	
	zad_DeviousHood = Game.GetFormFromFile(0x02AFA2, "Devious Devices - Assets.esm") as Keyword
	zad_DeviousAnkleShackles = Game.GetFormFromFile(0x05F4BB, "Devious Devices - Integration.esm") as Keyword
	zad_DeviousBlindfold = Game.GetFormFromFile(0x011B1A, "Devious Devices - Assets.esm") as Keyword
	zad_DeviousBoots = Game.GetFormFromFile(0x027F29, "Devious Devices - Assets.esm") as Keyword
	zad_DeviousCollar = Game.GetFormFromFile(0x003DF7, "Devious Devices - Assets.esm") as Keyword
	zad_DeviousHarness = Game.GetFormFromFile(0x017C43, "Devious Devices - Assets.esm") as Keyword
	zad_DeviousCorset = Game.GetFormFromFile(0x027F28, "Devious Devices - Assets.esm") as Keyword
	zad_DeviousArmCuffs = Game.GetFormFromFile(0x003DF9, "Devious Devices - Assets.esm") as Keyword
	zad_DeviousLegCuffs = Game.GetFormFromFile(0x003DF8, "Devious Devices - Assets.esm") as Keyword
	zad_DeviousGag = Game.GetFormFromFile(0x007EB8, "Devious Devices - Assets.esm") as Keyword
	zad_DeviousGloves = Game.GetFormFromFile(0x02AFA1, "Devious Devices - Assets.esm") as Keyword
	zad_DeviousPiercingsNipple = Game.GetFormFromFile(0x00CA39, "Devious Devices - Assets.esm") as Keyword
	zad_DeviousPiercingsVaginal = Game.GetFormFromFile(0x023E70, "Devious Devices - Assets.esm") as Keyword
	zad_PermitOral = Game.GetFormFromFile(0x00FAC9, "Devious Devices - Assets.esm") as Keyword
	zad_DeviousBelt = Game.GetFormFromFile(0x003330, "Devious Devices - Assets.esm") as Keyword
	zad_DeviousBra = Game.GetFormFromFile(0x003DFA, "Devious Devices - Assets.esm") as Keyword
	zad_DeviousArmbinder = Game.GetFormFromFile(0x00CA3A, "Devious Devices - Assets.esm") as Keyword
	zad_DeviousYoke = Game.GetFormFromFile(0x02C531, "Devious Devices - Assets.esm") as Keyword
	zad_DeviousPlugAnal = Game.GetFormFromFile(0x01DD7D, "Devious Devices - Assets.esm") as Keyword
	zad_DeviousPlugVaginal = Game.GetFormFromFile(0x01DD7C, "Devious Devices - Assets.esm") as Keyword
	zad_DeviousSuit = Game.GetFormFromFile(0x02AFA3, "Devious Devices - Assets.esm") as Keyword
	zad_Lockable = Game.GetFormFromFile(0x003894, "Devious Devices - Assets.esm") as Keyword
	zad_InventoryDevice = Game.GetFormFromFile(0x02B5F0, "Devious Devices - Integration.esm") as Keyword
	
	zad_DeviousPetSuit = Game.GetFormFromFile(0x086C1D, "Devious Devices - Integration.esm") as Keyword
	zad_DeviousStraitJacket = Game.GetFormFromFile(0x060A46, "Devious Devices - Integration.esm") as Keyword
	zad_DeviousHeavyBondage = Game.GetFormFromFile(0x05226C, "Devious Devices - Integration.esm") as Keyword
	zad_DeviousArmbinderElbow = Game.GetFormFromFile(0x062539, "Devious Devices - Integration.esm") as Keyword
	zad_DeviousYokeBB = Game.GetFormFromFile(0x062538, "Devious Devices - Integration.esm") as Keyword
	
	zad_DialGagHard = Game.GetFormFromFile(0x07C51F, "Devious Devices - Integration.esm") as Keyword
	zad_BlockGeneric  = Game.GetFormFromFile(0x0429FB, "Devious Devices - Integration.esm") as Keyword
	zad_armBinderHisec_Inventory = Game.GetFormFromFile(0x068BDE, "Devious Devices - Integration.esm") as Armor
	
	
	If Game.GetModByName("DeviousFollowers.esp") != 255
		_DList_TownCollar = Game.GetFormFromFile(0x009A12, "DeviousFollowers.esp") as Keyword
	Else
		_DList_TownCollar = _SLS_UnusedDummyKw
	EndIf
	
	_SLS_IncPickPocketLootKeys.AddForm(Game.GetFormFromFile(0x01775F, "Devious Devices - Integration.esm"))
	_SLS_IncPickPocketLootKeys.AddForm(Game.GetFormFromFile(0x008A4F, "Devious Devices - Integration.esm"))
	
	DeviousSlots = new Int[17]
	DeviousSlots[0] = 30 ; Head (Hood)
	DeviousSlots[1] = 32 ; Body
	DeviousSlots[2] = 33 ; Gloves
	DeviousSlots[3] = 37 ; Boots
	DeviousSlots[4] = 44 ; Gag
	DeviousSlots[5] = 45 ; Collar
	DeviousSlots[6] = 46 ; Armbinder
	DeviousSlots[7] = 48 ; Anal Plug
	DeviousSlots[8] = 49 ; Chastity Belt
	DeviousSlots[9] = 50 ; Vaginal Piercing
	DeviousSlots[10] = 51 ; Nipple Piercings
	DeviousSlots[11] = 53 ; Leg Cuffs
	DeviousSlots[12] = 55 ; Blindfold
	DeviousSlots[13] = 56 ; Chastity Bra
	DeviousSlots[14] = 57 ; Vaginal Plug
	DeviousSlots[15] = 58 ; Harness/Corset
	DeviousSlots[16] = 59 ; Arm Cuffs
	
	DeviousKeywords = new Keyword[24]
	DeviousKeywords[0] = zad_DeviousHood
	DeviousKeywords[1] = zad_DeviousAnkleShackles
	DeviousKeywords[2] = zad_DeviousBoots
	DeviousKeywords[3] = zad_DeviousCollar
	DeviousKeywords[4] = zad_DeviousHarness
	DeviousKeywords[5] = zad_DeviousCorset
	DeviousKeywords[6] = zad_DeviousArmCuffs
	DeviousKeywords[7] = zad_DeviousLegCuffs
	DeviousKeywords[8] = zad_DeviousGag
	DeviousKeywords[9] = zad_DeviousGloves
	DeviousKeywords[10] = zad_DeviousPiercingsNipple
	DeviousKeywords[11] = zad_DeviousPiercingsVaginal
	DeviousKeywords[12] = zad_PermitOral
	DeviousKeywords[13] = zad_DeviousBelt
	DeviousKeywords[14] = zad_DeviousBra
	DeviousKeywords[15] = zad_DeviousArmbinder
	DeviousKeywords[16] = zad_DeviousYoke
	DeviousKeywords[17] = zad_DeviousPlugAnal
	DeviousKeywords[18] = zad_DeviousPlugVaginal
	DeviousKeywords[19] = zad_DeviousSuit
	DeviousKeywords[20] = zad_DeviousPetSuit
	DeviousKeywords[21] = zad_DeviousStraitJacket
	DeviousKeywords[22] = zad_DeviousArmbinderElbow
	DeviousKeywords[23] = zad_DeviousYokeBB
	
	DoDevicePatchup()
EndEvent

Function DoDevicePatchup()
	RunPonyGearPatchUp()
	Menu.UpdateMenuText(Menu.RunDevicePatchUpOID_T, "Done! ")
	Utility.WaitMenuMode(0.6)
	Menu.UpdateMenuText(Menu.RunDevicePatchUpOID_T, "")
EndFunction

Function RunPonyGearPatchUp()
	; Clear storageUtil variables from devices it's already been added to
	Menu.UpdateMenuText(Menu.RunDevicePatchUpOID_T, "Clearing Pony Gear")
	Form akItem
	Int i = _SLS_DeviceListPony.GetSize()
	While i > 0
		i -= 1
		akItem = _SLS_DeviceListPony.GetAt(i)
		StorageUtil.UnSetIntValue(akItem, "_SLS_IsPonyGear")
	EndWhile
	_SLS_DeviceListPony.Revert()

	; Load devices from Json and set storageUtil variable
	Menu.UpdateMenuText(Menu.RunDevicePatchUpOID_T, "Adding Pony Gear")
	i = JsonUtil.FormListCount("SL Survival/DeviceList.json", "ponygear")
	While i > 0
		i -= 1
		akItem = JsonUtil.FormListGet("SL Survival/DeviceList.json", "ponygear", i)
		If akItem
			StorageUtil.SetIntValue(akItem, "_SLS_IsPonyGear", 1)
			_SLS_DeviceListPony.AddForm(akItem)
		EndIf
	EndWhile
EndFunction

State Installed

	Function DoMoan(Actor akActor = None)
		If akActor
			_SLS_IntDevious.DoMoan(libsQuest, akActor)
		Else
			_SLS_IntDevious.DoMoan(libsQuest, PlayerRef)
		EndIf
	EndFunction
	
	Bool Function IsWearingAnyDevice(Actor akActor)
		If akActor.WornHasKeyword(zad_Lockable) ; Npcs don't actually equip the inventory device so....
			Return true
		EndIf
		Return false	
	EndFunction
	
	Bool Function IsDeviousInvDevice(Form akArmor)
		If akArmor && akArmor.HasKeyword(zad_InventoryDevice)
			Return true
		EndIf
		Return false
	EndFunction
	
	Bool Function IsDeviousRenderDevice(Form akForm)
		Return akForm.HasKeyword(zad_Lockable)
	EndFunction
	
	Key Function GetDeviceKey(Armor Device)
		Return _SLS_IntDevious.GetDeviceKey(libsQuest, Device)
	EndFunction
	
	Function EquipDevice(Actor akActor, Armor deviceInventory)
		debug.trace("SLS_: Devious.EquipDevice: " + deviceInventory + " - " + deviceInventory.GetName())
		_SLS_IntDevious.EquipDevice(akActor, deviceInventory, libsQuest)
	EndFunction
	
	Function RemoveDevice(Actor akActor, Armor deviceInventory)
		debug.trace("SLS_: Devious.RemoveDevice: " + deviceInventory + " - " + deviceInventory.GetName())
		_SLS_IntDevious.RemoveDevice(akActor, deviceInventory, libsQuest)
	EndFunction
	
	Armor Function GetWornDeviceByKeyword(Actor akActor, Keyword kw)
		Return _SLS_IntDevious.GetWornDeviceByKeyword(akActor, kw, libsQuest)
	EndFunction
	
	Keyword Function GetDeviceKeyword(Armor Device)
		Return _SLS_IntDevious.GetDeviceKeyword(Device, libsQuest)
	EndFunction
	
	Armor Function GetRenderedDevice(Armor Device)
		Return _SLS_IntDevious.GetRenderedDevice(Device, libsQuest)
	EndFunction

	Bool Function AreHandsAvailable(Actor akActor)
		If akActor.WornHasKeyword(zad_DeviousArmbinder) || akActor.WornHasKeyword(zad_DeviousPetSuit) || akActor.WornHasKeyword(zad_DeviousStraitJacket) || akActor.WornHasKeyword(zad_DeviousYoke) || akActor.WornHasKeyword(zad_DeviousYokeBB) || akActor.WornHasKeyword(zad_DeviousArmbinderElbow)
			Return false
		EndIf
		Return true
	EndFunction
	
	Function MakeHandsAvailable(Actor akActor)
		If akActor.WornHasKeyword(zad_DeviousHeavyBondage)
			RemoveDevice(akActor, deviceInventory = GetWornDeviceByKeyword(akActor, zad_DeviousHeavyBondage))
		EndIf
	EndFunction
	
	Bool Function IsHandAnimChangeDevice(Form akForm)
		; Is this a device that changes the animation of the hands - Used to detect if a device will break the naked cover animation
		If akForm.HasKeyword(zad_DeviousArmbinder) || akForm.HasKeyword(zad_DeviousPetSuit) || akForm.HasKeyword(zad_DeviousStraitJacket) || akForm.HasKeyword(zad_DeviousYoke) || akForm.HasKeyword(zad_DeviousYokeBB)
			Return true
		EndIf
		Return false
	EndFunction
	
	Function EquipRandomDds(Actor akActor, Int Quantity)
		String[] FreeSlots = new String[20]
		Int i = 0
		While i < Quantity
			Int Index = 0
			If !akActor.WornHasKeyword(zad_DeviousBoots)
				FreeSlots[Index] = "Boots"
				Index += 1
			EndIf
			If !akActor.WornHasKeyword(zad_DeviousCollar); && !akActor.WornHasKeyword(zad_DeviousHarness)
				FreeSlots[Index] = "Collars"
				Index += 1
			EndIf
			If !akActor.WornHasKeyword(zad_DeviousCorset) && !akActor.WornHasKeyword(zad_DeviousHarness) ; Occupies the same slots
				FreeSlots[Index] = "Corsets"
				Index += 1
			EndIf
			If !akActor.WornHasKeyword(zad_DeviousArmCuffs)
				FreeSlots[Index] = "CuffsArms"
				Index += 1
			EndIf
			If !akActor.WornHasKeyword(zad_DeviousLegCuffs)
				FreeSlots[Index] = "CuffsLegs"
				Index += 1
			EndIf
			If !akActor.WornHasKeyword(zad_DeviousGag)
				FreeSlots[Index] = "Gags"
				Index += 1
			EndIf
			If !akActor.WornHasKeyword(zad_DeviousGloves)
				FreeSlots[Index] = "Gloves"
				Index += 1
			EndIf
			If !akActor.WornHasKeyword(zad_DeviousHarness) && !akActor.WornHasKeyword(zad_DeviousCollar) && !akActor.WornHasKeyword(zad_DeviousCorset)
				FreeSlots[Index] = "Harnesses"
				Index += 1
			EndIf
			If !akActor.WornHasKeyword(zad_DeviousPiercingsNipple)
				FreeSlots[Index] = "PiercingsNipples"
				Index += 1
			EndIf
			If !akActor.WornHasKeyword(zad_DeviousPiercingsVaginal)
				FreeSlots[Index] = "PiercingsVagina"
				Index += 1
			EndIf
			If Index > 0
				String DeviceType = FreeSlots[Utility.RandomInt(0, (Index - 1))]
				Int RanDeviceIndex = Utility.RandomInt(0, (FormListCount(DeviceFile, DeviceType) - 1))
				Armor DdSelect = FormListGet(DeviceFile, DeviceType, RanDeviceIndex) as Armor
				EquipDevice(akActor, DdSelect)
				Debug.Trace("SLS_: EquipRandomDds: " + i + ") Selected: " + DeviceType + " is " + DdSelect.GetName())
			Else
				Debug.Trace("SLS_: EquipRandomDds: No device slots left")
			EndIf
			i += 1
			If i < Quantity
				Utility.Wait(0.2)
			EndIf
		EndWhile
		If akActor == PlayerRef
			Init.FreeDeviceSlots = GetNumFreeSlots(akActor)
			Debug.Trace("SLS_: EquipRandomDds: Free slots: " + Init.FreeDeviceSlots)
		EndIf
	EndFunction
	
	Int Function GetNumFreeSlots(Actor akActor)
		Int NumFreeSlots = 0
		If !akActor.WornHasKeyword(zad_DeviousBoots)
			NumFreeSlots += 1
		EndIf
		If !akActor.WornHasKeyword(zad_DeviousCollar) ; Collar keyword is included with harness render devices
			NumFreeSlots += 1
		EndIf
		If !akActor.WornHasKeyword(zad_DeviousCorset) && !akActor.WornHasKeyword(zad_DeviousHarness) ; Occupies the same slots
			NumFreeSlots += 1
		EndIf
		If !akActor.WornHasKeyword(zad_DeviousArmCuffs)
			NumFreeSlots += 1
		EndIf
		If !akActor.WornHasKeyword(zad_DeviousLegCuffs)
			NumFreeSlots += 1
		EndIf
		If !akActor.WornHasKeyword(zad_DeviousGag)
			NumFreeSlots += 1
		EndIf
		If !akActor.WornHasKeyword(zad_DeviousGloves)
			NumFreeSlots += 1
		EndIf
		;If !akActor.WornHasKeyword(zad_DeviousHarness) && (!akActor.WornHasKeyword(zad_DeviousCollar) || !akActor.WornHasKeyword(zad_DeviousCorset))
		;	NumFreeSlots += 1
		;EndIf
		If !akActor.WornHasKeyword(zad_DeviousPiercingsNipple)
			NumFreeSlots += 1
		EndIf
		If !akActor.WornHasKeyword(zad_DeviousPiercingsVaginal)
			NumFreeSlots += 1
		EndIf
		Debug.Trace("SLS_: GetNumFreeSlots: Freeslots: " + NumFreeSlots)
		Return NumFreeSlots
	EndFunction
	
	Function EquipRandomDeviceByCategory(Actor akActor, String DeviceCategory)
		; Device Categories:
		; Boots
		; Pony_Boots
		; Pony_PlugsAnal
		; PlugsAnal
		; PlugsVaginal
		; Collars
		; Corsets
		; CuffsArms
		; CuffsLegs
		; Gags
		; Gloves
		; Harnesses
		; PiercingsNipples
		; PiercingsVagina
		; Armbinders
		; HobbleSkirts
		; StraitJackets
		; PetSuits
		; Blindfolds
		; ChastityBelts
		; Hoods
		; Mitts
		; RingGag

		Int Index = Utility.RandomInt(0,FormListCount(DeviceFile, DeviceCategory) - 1)
		Armor Device = FormListGet(DeviceFile, DeviceCategory, Index) as Armor
		If Device
			EquipDevice(akActor, Device)
		Else
			Debug.Trace("_SLS_: Error: EquipRandomDeviceByCategory: akActor: " + akActor + ". DeviceCategory: " + DeviceCategory + ". Invalid Device")
		EndIf
	EndFunction
	
	Armor Function GetMagicBlockingDevice(Actor akTarget, Bool RemoveGenericDevice)
		Armor Device
		
		; Collars
		If akTarget.WornHasKeyword(zad_DeviousCollar)
			Device = GetWornDeviceByKeyword(akTarget, zad_DeviousCollar)
			Bool IsDeviousDevice = true
			If !Device ; No device returned by DDs but player has keyword....? Lola
				IsDeviousDevice = false
				Device = PlayerRef.GetWornForm(0x00008000) as Armor
				If !Device.HasKeyword(zad_DeviousCollar)
					Device = None
				EndIf				
			EndIf
			If Device && RemoveGenericDevice && !Device.HasKeyword(zad_BlockGeneric) && !akTarget.WornHasKeyword(_DList_TownCollar) ; If it's not a quest type Device or DF town collar, remove it.
				If IsDeviousDevice
					RemoveDevice(akTarget, Device)
				EndIf
				Return JsonUtil.FormListGet("SL Survival/DeviceList.json", "SteelCollars", Utility.RandomInt(0, JsonUtil.FormListCount("SL Survival/DeviceList.json", "SteelCollars") - 1)) as Armor
			EndIf
		Else
			Return JsonUtil.FormListGet("SL Survival/DeviceList.json", "SteelCollars", Utility.RandomInt(0, JsonUtil.FormListCount("SL Survival/DeviceList.json", "SteelCollars") - 1)) as Armor
		EndIf
			
		; Arm Cuffs
		If akTarget.WornHasKeyword(zad_DeviousArmCuffs)
			Device = GetWornDeviceByKeyword(akTarget, zad_DeviousArmCuffs)
			If RemoveGenericDevice && !Device.HasKeyword(zad_BlockGeneric)
				RemoveDevice(akTarget, GetWornDeviceByKeyword(akTarget, zad_DeviousArmCuffs))
				Return JsonUtil.FormListGet("SL Survival/DeviceList.json", "SteelArmCuffs", Utility.RandomInt(0, JsonUtil.FormListCount("SL Survival/DeviceList.json", "SteelArmCuffs") - 1)) as Armor
			EndIf
		Else
			Return JsonUtil.FormListGet("SL Survival/DeviceList.json", "SteelArmCuffs", Utility.RandomInt(0, JsonUtil.FormListCount("SL Survival/DeviceList.json", "SteelArmCuffs") - 1)) as Armor
		EndIf
		
		; Leg Cuffs
		If akTarget.WornHasKeyword(zad_DeviousLegCuffs)
			Device = GetWornDeviceByKeyword(akTarget, zad_DeviousLegCuffs)
			If RemoveGenericDevice && !Device.HasKeyword(zad_BlockGeneric)
				RemoveDevice(akTarget, GetWornDeviceByKeyword(akTarget, zad_DeviousLegCuffs))
				Return JsonUtil.FormListGet("SL Survival/DeviceList.json", "SteelLegCuffs", Utility.RandomInt(0, JsonUtil.FormListCount("SL Survival/DeviceList.json", "SteelLegCuffs") - 1)) as Armor
			EndIf
		Else
			Return JsonUtil.FormListGet("SL Survival/DeviceList.json", "SteelLegCuffs", Utility.RandomInt(0, JsonUtil.FormListCount("SL Survival/DeviceList.json", "SteelLegCuffs") - 1)) as Armor
		EndIf
		
		Return None
	EndFunction	
	
	Bool Function IsPlayerBlindfolded()
		If PlayerRef.WornHasKeyword(zad_DeviousBlindfold)
			Return true
		EndIf
		Return false
	EndFunction

	Bool Function IsPlayerGagged()
		If PlayerRef.WornHasKeyword(zad_DeviousGag)
			Return true
		EndIf
		Return false
	EndFunction

	Int Function GetNumOfEquippedDevices(Actor akTarget)
		_SLS_WornDeviceList.Revert()
		Form ArmorTemp
		Int i = DeviousSlots.Length
		While i > 0
			i -= 1
			ArmorTemp = akTarget.GetWornForm(Armor.GetMaskForSlot(DeviousSlots[i]))
			;Debug.Trace("SLS_: DeviousSlots[" + i + "] = " + DeviousSlots[i] + " = " + ArmorTemp)
			If ArmorTemp != None
				If ArmorTemp.HasKeyword(zad_Lockable)
					_SLS_WornDeviceList.AddForm(ArmorTemp) ; Duplicate forms won't be added - Dds that occupy more than one slot
				EndIf
			EndIf
		EndWhile
		Return _SLS_WornDeviceList.GetSize()
	EndFunction

	Function CheckCanDos()
		CanDoArmCuffs = false
		CanDoLegCuffs = false
		CanDoBoots = false
		CanDoGloves = false
		CanDoPiercingsNipples = false
		CanDoPiercingsVaginal = false
		CanDoGags = false
		CanDoCollar = false
		CanDoHarness = false
		CanDoCorsets = false
		CanDoBeltAndPlugs = false
		CanDoBelt = false
		CanDoSuits = false
		CanDoBlindfolds = false
		If !PlayerRef.WornHasKeyword(zad_DeviousCollar)
			CanDoCollar = true
			If !PlayerRef.WornHasKeyword(zad_DeviousHarness)
				CanDoHarness = true
			EndIf
		EndIf
		If !PlayerRef.WornHasKeyword(zad_DeviousCorset) && !PlayerRef.WornHasKeyword(zad_DeviousHarness)
			CanDoCorsets = true
		EndIf
		If !PlayerRef.WornHasKeyword(zad_DeviousArmCuffs)
			CanDoArmCuffs = true
		EndIf
		If !PlayerRef.WornHasKeyword(zad_DeviousLegCuffs)
			CanDoLegCuffs = true
		EndIf
		If !PlayerRef.WornHasKeyword(zad_DeviousBoots)
			CanDoBoots = true
		EndIf
		If !PlayerRef.WornHasKeyword(zad_DeviousGloves)
			CanDoGloves = true
		EndIf
		If !PlayerRef.WornHasKeyword(zad_DeviousPiercingsNipple)
			CanDoPiercingsNipples = true
		EndIf
		If !PlayerRef.WornHasKeyword(zad_DeviousPiercingsVaginal)
			CanDoPiercingsVaginal = true
		EndIf
		If !PlayerRef.WornHasKeyword(zad_DeviousGag)
			CanDoGags = true
		EndIf
		If !PlayerRef.WornHasKeyword(zad_DeviousSuit)
			CanDoSuits = true
		EndIf
		If !PlayerRef.WornHasKeyword(zad_DeviousBlindfold)
			CanDoBlindfolds = true
		EndIf
		If !PlayerRef.WornHasKeyword(zad_DeviousBelt) 
			CanDoBelt = true
			If !PlayerRef.WornHasKeyword(zad_DeviousPlugAnal) && !PlayerRef.WornHasKeyword(zad_DeviousPlugVaginal)
				CanDoBeltAndPlugs = true
			EndIf
		EndIf
	EndFunction

	Bool Function CanEquipArmbinder(Actor akTarget)
		If !akTarget.WornHasKeyword(zad_DeviousArmbinder) && !akTarget.WornHasKeyword(zad_DeviousArmbinderElbow) && !akTarget.WornHasKeyword(zad_DeviousYoke) && !akTarget.WornHasKeyword(zad_DeviousYokeBB) && !akTarget.WornHasKeyword(zad_DeviousPetSuit)
			Return true
		EndIf
		Return false
	EndFunction

	Function EquipMandatoryRestaints(Int MandatoryRestraints)
		;Debug.MessageBox(MandatoryRestraints)
		If MandatoryRestraints == 1 ; Armbinder
			If AreHandsAvailable(PlayerRef)
				EquipRandomDeviceByCategory(PlayerRef, "armbinders")
			EndIf
			
		ElseIf MandatoryRestraints == 2 ; Yoke
			If !PlayerRef.WornHasKeyword(zad_DeviousPetSuit)
				RemoveMandatoryRestraints(MandatoryRestraints - 1)
				EquipRandomDeviceByCategory(PlayerRef, "yokes")
			EndIf
		
		ElseIf MandatoryRestraints == 3 ; Yoke + Boots + Gag
			If !PlayerRef.WornHasKeyword(zad_DeviousPetSuit)
				If AreHandsAvailable(PlayerRef)
					EquipRandomDeviceByCategory(PlayerRef, "yokes")
				EndIf
			EndIf
			EquipRandomDeviceByCategory(PlayerRef, "Boots")
			EquipRandomDeviceByCategory(PlayerRef, "Gags")
			
		ElseIf MandatoryRestraints == 4 ; Yoke + Boots + Gag + ankle chains
			If !PlayerRef.WornHasKeyword(zad_DeviousPetSuit)
				If AreHandsAvailable(PlayerRef)
					EquipRandomDeviceByCategory(PlayerRef, "yokes")
				EndIf
			EndIf
			EquipRandomDeviceByCategory(PlayerRef, "Boots")
			EquipRandomDeviceByCategory(PlayerRef, "Gags")
			If Game.GetModByName("Deviously Cursed Loot.esp") != 255
				If PlayerRef.WornHasKeyword(zad_DeviousLegCuffs)
					RemoveDevice(PlayerRef, GetWornDeviceByKeyword(PlayerRef, zad_DeviousLegCuffs))
				EndIf
				EquipDevice(PlayerRef, Game.GetFormFromFile(0x06F30C, "Deviously Cursed Loot.esp") as Armor)
			EndIf
		EndIf
	EndFunction

	Function RemoveMandatoryRestraints(Int MandatoryRestraints)
		If MandatoryRestraints > 0 ; Armbinder
			If MandatoryRestraints == 1
				RemoveMandResOne()
				
			ElseIf MandatoryRestraints == 2 ; Yoke
				RemoveMandResTwo()
				
			ElseIf MandatoryRestraints == 3 ; Yoke + Boots + Gag
				RemoveMandResThree()
			
			ElseIf MandatoryRestraints == 4 ; Yoke + Boots + Gag + ankle chains (DCL)
				RemoveMandResFour()
			EndIf
		EndIf
	EndFunction

	Function RemoveMandResOne()
		Armor Dd
		If PlayerRef.WornHasKeyword(zad_DeviousArmbinder)
			Dd = GetWornDeviceByKeyword(PlayerRef, zad_DeviousArmbinder)
			If !Dd.HasKeyword(zad_BlockGeneric)
				RemoveDevice(PlayerRef, GetWornDeviceByKeyword(PlayerRef, zad_DeviousArmbinder))
			EndIf
		EndIf
		If PlayerRef.WornHasKeyword(zad_DeviousArmbinderElbow)
			Dd = GetWornDeviceByKeyword(PlayerRef, zad_DeviousArmbinderElbow)
			If !Dd.HasKeyword(zad_BlockGeneric)
				RemoveDevice(PlayerRef, GetWornDeviceByKeyword(PlayerRef, zad_DeviousArmbinderElbow))
			EndIf
		EndIf
	EndFunction

	Function RemoveMandResTwo()
		Armor Dd
		If PlayerRef.WornHasKeyword(zad_DeviousYoke)
			Dd = GetWornDeviceByKeyword(PlayerRef, zad_DeviousYoke)
			If !Dd.HasKeyword(zad_BlockGeneric)
				RemoveDevice(PlayerRef, GetWornDeviceByKeyword(PlayerRef, zad_DeviousYoke))
			EndIf
		EndIf
		If PlayerRef.WornHasKeyword(zad_DeviousYokeBB)
			Dd = GetWornDeviceByKeyword(PlayerRef, zad_DeviousYokeBB)
			If !Dd.HasKeyword(zad_BlockGeneric)
				RemoveDevice(PlayerRef, GetWornDeviceByKeyword(PlayerRef, zad_DeviousYokeBB))
			EndIf
		EndIf
	EndFunction

	Function RemoveMandResThree()
		RemoveMandResTwo()
		Armor Dd
		If PlayerRef.WornHasKeyword(zad_DeviousBoots)
			Dd = GetWornDeviceByKeyword(PlayerRef, zad_DeviousBoots)
			If !Dd.HasKeyword(zad_BlockGeneric)
				RemoveDevice(PlayerRef, GetWornDeviceByKeyword(PlayerRef, zad_DeviousBoots))
			EndIf
		EndIf
		If PlayerRef.WornHasKeyword(zad_DeviousGag)
			Dd = GetWornDeviceByKeyword(PlayerRef, zad_DeviousGag)
			If !Dd.HasKeyword(zad_BlockGeneric)
				RemoveDevice(PlayerRef, GetWornDeviceByKeyword(PlayerRef, zad_DeviousGag))
			EndIf
		EndIf
	EndFunction

	Function RemoveMandResFour()
		RemoveMandResThree()
		Armor Dd
		If Game.GetModByName("Deviously Cursed Loot.esp") != 255
			If PlayerRef.WornHasKeyword(zad_DeviousAnkleShackles) ; zad_DeviousAnkleShackles
				Dd = GetWornDeviceByKeyword(PlayerRef, zad_DeviousAnkleShackles)
				If !Dd.HasKeyword(zad_BlockGeneric)
					RemoveDevice(PlayerRef, Game.GetFormFromFile(0x06F30C, "Deviously Cursed Loot.esp") as Armor)
				EndIf
			EndIf
		EndIf
	EndFunction

	Bool Function IsProperlyRestrained(Int RestraintLevel)
		;Debug.MessageBox("Req restraints level: " + RestraintLevel)
		If RestraintLevel == 1
			Return IsProperlyRestrainedOne()
		ElseIf RestraintLevel == 2
			Return IsProperlyRestrainedTwo()
		ElseIf RestraintLevel == 3
			Return IsProperlyRestrainedThree()
		ElseIf RestraintLevel == 4
			Return IsProperlyRestrainedFour()
		EndIf
		Debug.Trace("_SLS_: Unknown restraints level: " + RestraintLevel)
		Return true
	EndFunction

	Bool Function IsProperlyRestrainedOne()
		If PlayerRef.WornHasKeyword(zad_DeviousArmbinder) || PlayerRef.WornHasKeyword(zad_DeviousArmbinderElbow)
			Return true
		EndIf
		Return false
	EndFunction

	Bool Function IsProperlyRestrainedTwo()
		If PlayerRef.WornHasKeyword(zad_DeviousYoke) || PlayerRef.WornHasKeyword(zad_DeviousYokeBB)
			Return true
		EndIf
		Return false
	EndFunction

	Bool Function IsProperlyRestrainedThree()
		If IsProperlyRestrainedTwo() && PlayerRef.WornHasKeyword(zad_DeviousGag) && PlayerRef.WornHasKeyword(zad_DeviousBoots)
			Return true
		EndIf
		Return false
	EndFunction

	Bool Function IsProperlyRestrainedFour()
		If IsProperlyRestrainedThree()
			If Game.GetModByName("Deviously Cursed Loot.esp") != 255
				If PlayerRef.WornHasKeyword(zad_DeviousAnkleShackles)
					Return true
				EndIf
			Else
				Return true
			EndIf
		EndIf
		Return false
	EndFunction
	
	Bool Function GetCanEquipDeviousBoots(Actor akTarget)
		If akTarget.WornHasKeyword(zad_DeviousBoots)
			Return false
		EndIf
		Return true
	EndFunction
	
	Armor Function GetEquippablePonyDevice(Actor akTarget, ObjectReference akContainer)
		; Find a pony girl type devious device in a container that the actor can equip (the slot is not occupied)
		
		If akContainer && akTarget
			Form akItem
			Armor akArmor
			Keyword Kw
			Int i = akContainer.GetNumItems()
			;If i <= 20 ; Limit the number of items a container can have ?
				While i > 0
					i -= 1
					akItem = akContainer.GetNthForm(i)
					If akItem as Armor
						If StorageUtil.GetIntValue(akItem, "_SLS_IsPonyGear", Missing = -1) == 1
							akArmor = akItem as Armor
							Kw = GetDeviceKeyword(akArmor)
							;Debug.MessageBox(Kw)
							;Debug.Trace("_SLS_: " + akItem + " IS pony gear")
							If Kw && !akTarget.WornHasKeyword(Kw)
								If Kw == zad_DeviousHarness
									If !akTarget.WornHasKeyword(zad_DeviousCorset)
										Return akArmor
									EndIf
								Else
									Return akArmor
								EndIf
							EndIf
						;Else
						;	Debug.Trace("_SLS_: " + akItem + " is NOT pony gear")
						EndIf
					EndIf
				EndWhile
			
			;Else
			;	Return None
			;EndIf
			
		Else
			Return None
		EndIf
	EndFunction
	
	Function BeginForcedMilking()
		Keyword[] DeviousKwds = new Keyword[4]
		DeviousKwds[0] = zad_DeviousHeavyBondage
		DeviousKwds[1] = zad_DeviousPiercingsNipple
		DeviousKwds[2] = zad_DeviousGag
		DeviousKwds[3] = zad_DeviousSuit
		
		Int i = DeviousKwds.Length
		Armor Device
		While i > 0
			i -= 1
			Device = GetWornDeviceByKeyword(PlayerRef, DeviousKwds[i])
			If Device
				StorageUtil.FormListAdd(None, "_SLS_Int_ForcedMilkingDevices", Device)
				RemoveDevice(PlayerRef, Device)
			EndIf
		EndWhile
	EndFunction
	
	Function EndForcedMilking()
		Int i = StorageUtil.FormListCount(None, "_SLS_Int_ForcedMilkingDevices")
		While i > 0
			i -= 1
			EquipDevice(PlayerRef, StorageUtil.FormListGet(None, "_SLS_Int_ForcedMilkingDevices", i) as Armor)
		EndWhile
		StorageUtil.FormListClear(None, "_SLS_Int_ForcedMilkingDevices")
	EndFunction
	
	Bool Function CanDoOral(Actor akTarget)
		If akTarget.WornHasKeyword(zad_PermitOral)
			Return true
		ElseIf akTarget.WornHasKeyword(zad_DeviousGag)
			Return false
		EndIf
		Return true
	EndFunction
	
	String[] Function StringListAllDevices(Actor akTarget)
		StorageUtil.StringListClear(Self, "ListAllDevicesStrings")
		StorageUtil.FormListClear(Self, "ListAllDevicesForms")
		Form akForm
		Int i = 0
		While i < DeviousKeywords.Length
			If akTarget.WornHasKeyword(DeviousKeywords[i])
				If StorageUtil.StringListAdd(Self, "ListAllDevicesStrings", GetWornDeviceByKeyword(akTarget, DeviousKeywords[i]).GetName(), AllowDuplicate = false) > -1 ; Don't add the same device twice - some devices have multiple keywords
					StorageUtil.FormListAdd(Self, "ListAllDevicesForms", DeviousKeywords[i], AllowDuplicate = false)
					;Debug.Trace("_SLS_: StringListAllDevices(): " + akTarget + " HAS keyword: " + DeviousKeywords[i] + " - " + GetWornDeviceByKeyword(akTarget, DeviousKeywords[i]))
				;Else
				;	Debug.MessageBox("Got Dup: " + DeviousKeywords[i])
				EndIf
			Else
				Debug.Trace("_SLS_: StringListAllDevices(): " + akTarget + " Has not keyword: " + DeviousKeywords[i])
			EndIf
			i += 1
		EndWhile
		Return StorageUtil.StringListToArray(Self, "ListAllDevicesStrings")
	EndFunction
	
	Bool Function TryUnlockNpcDevice(Int DeviceSelect, Actor akTarget)
		Armor Device = GetWornDeviceByKeyword(akTarget, StorageUtil.FormListGet(Self, "ListAllDevicesForms", DeviceSelect) as Keyword)
		If Device
			Key UnlockKey = GetDeviceKey(Device)
			If UnlockKey
				If PlayerRef.GetItemCount(UnlockKey) > 0
					Debug.SendAnimationEvent(PlayerRef, "IdleLockPick")
					Utility.Wait(1.5)
					RemoveDevice(akTarget, Device)
					PlayerRef.RemoveItem(UnlockKey, 1)
					PlayerRef.AddItem(Device, 1)
					Return true
				Else
					Debug.Notification("I don't have a " + UnlockKey.GetName() + " to do that")
				EndIf
			Else
				Debug.Notification("I don't know what key unlocks that device")
			EndIf
		Else
			Debug.Trace("_SLS_: TryUnlockNpcDevice(): Error getting Device for DeviceSelect: " + DeviceSelect)
		EndIf
		Return false
	EndFunction
	
	Key Function ExamineDevice(Int DeviceSelect, Actor akTarget)
		Key UnlockKey
		Armor Device = GetWornDeviceByKeyword(akTarget, StorageUtil.FormListGet(Self, "ListAllDevicesForms", DeviceSelect) as Keyword)
		If Device
			UnlockKey = GetDeviceKey(Device)
		EndIf
		Return UnlockKey
	EndFunction
	
	Function CatchBreath(Actor akTarget)
		_SLS_IntDevious.CatchBreath(akTarget, libsQuest)
	EndFunction
	
	Function CatchBreathWithoutMoan(Actor akTarget)
		PlayThirdPersonAnimation(akTarget, "ft_out_of_breath_reg", 5, true)
	EndFunction
	
	Function PlayThirdPersonAnimation(Actor akActor, String Animation, Int Duration, Bool PermitRestrictive = false)
		_SLS_IntDevious.PlayThirdPersonAnimation(akActor, Animation, Duration, PermitRestrictive, libsQuest)
	EndFunction
	
	Bool Function IsHardGagged(Actor akActor)
		Return akActor.WornHasKeyword(zad_DialGagHard)
	EndFunction
	
	Int Function VibrateEffect(Actor akActor, Int VibStrength, Int Duration, Bool TeaseOnly = false, Bool Silent = false)
		; VibStrength: 1 - 5: very weak to very strong sound
		Return _SLS_IntDevious.VibrateEffect(libsQuest, akActor, vibStrength, duration, teaseOnly, silent)
	EndFunction
EndState

; Empty state ==========================================================

Function DoMoan(Actor akActor = None)
EndFunction

Bool Function IsWearingAnyDevice(Actor akActor)
	Return false	
EndFunction

Bool Function IsDeviousInvDevice(Form akArmor)
	Return false
EndFunction

Bool Function IsDeviousRenderDevice(Form akForm)
	Return false
EndFunction

Key Function GetDeviceKey(Armor Device)
	Return None
EndFunction

Function EquipDevice(Actor akActor, Armor deviceInventory)
EndFunction

Function RemoveDevice(Actor akActor, Armor deviceInventory)
EndFunction

Armor Function GetWornDeviceByKeyword(Actor akActor, Keyword kw)
	Return None
EndFunction

Keyword Function GetDeviceKeyword(Armor Device)
	Return None
EndFunction

Armor Function GetRenderedDevice(Armor Device)
	Return None
EndFunction

Bool Function AreHandsAvailable(Actor akActor)
	Return true
EndFunction

Function MakeHandsAvailable(Actor akActor)
EndFunction

Bool Function IsHandAnimChangeDevice(Form akForm)
	Return false
EndFunction

Function EquipRandomDds(Actor akActor, Int Quantity)
EndFunction

Int Function GetNumFreeSlots(Actor akActor)
	Return 0
EndFunction

Function EquipRandomDeviceByCategory(Actor akActor, String DeviceCategory)
EndFunction

Armor Function GetMagicBlockingDevice(Actor akTarget, Bool RemoveGenericDevice)
	Return None
EndFunction

Bool Function IsPlayerBlindfolded()
	Return false
EndFunction

Bool Function IsPlayerGagged()
	Return false
EndFunction

Int Function GetNumOfEquippedDevices(Actor akTarget)
	Return 0
EndFunction

Function CheckCanDos()
	CanDoArmCuffs = false
	CanDoLegCuffs = false
	CanDoBoots = false
	CanDoGloves = false
	CanDoPiercingsNipples = false
	CanDoPiercingsVaginal = false
	CanDoGags = false
	CanDoCollar = false
	CanDoHarness = false
	CanDoCorsets = false
	CanDoBeltAndPlugs = false
	CanDoBelt = false
	CanDoSuits = false
	CanDoBlindfolds = false
EndFunction

Bool Function CanEquipArmbinder(Actor akTarget)
	Return false
EndFunction

Function EquipMandatoryRestaints(Int MandatoryRestraints)
EndFunction

Function RemoveMandatoryRestraints(Int MandatoryRestraints)
EndFunction

Function RemoveMandResOne()
EndFunction

Function RemoveMandResTwo()
EndFunction

Function RemoveMandResThree()
EndFunction

Function RemoveMandResFour()
EndFunction

Bool Function IsProperlyRestrained(Int RestraintLevel)
	Return true
EndFunction

Bool Function IsProperlyRestrainedOne()
	Return true
EndFunction

Bool Function IsProperlyRestrainedTwo()
	Return true
EndFunction

Bool Function IsProperlyRestrainedThree()
	Return true
EndFunction

Bool Function IsProperlyRestrainedFour()
	Return true
EndFunction

Bool Function GetCanEquipDeviousBoots(Actor akTarget)
	Return false
EndFunction

Armor Function GetEquippablePonyDevice(Actor akTarget, ObjectReference akContainer)
	Return None
EndFunction

Function BeginForcedMilking()
EndFunction

Function EndForcedMilking()
EndFunction

Bool Function CanDoOral(Actor akTarget)
	Return true
EndFunction

String[] Function StringListAllDevices(Actor akTarget)
	String[] Blah
	Return Blah
EndFunction

Bool Function TryUnlockNpcDevice(Int DeviceSelect, Actor akTarget)
	Return false
EndFunction

Key Function ExamineDevice(Int DeviceSelect, Actor akTarget)
	Return None
EndFunction

Function CatchBreath(Actor akTarget)
EndFunction

Function CatchBreathWithoutMoan(Actor akTarget)
EndFunction

Function PlayThirdPersonAnimation(Actor akActor, String Animation, Int Duration, Bool PermitRestrictive = false)
EndFunction

Bool Function IsHardGagged(Actor akActor)
	Return false
EndFunction

Int Function VibrateEffect(Actor akActor, Int VibStrength, Int Duration, Bool TeaseOnly = false, Bool Silent = false)
	Return 0
EndFunction

; ====================================================================

Quest libsQuest

Int[] DeviousSlots

Keyword[] DeviousKeywords

SLS_Mcm Property Menu Auto
SLS_Init Property Init Auto

String Property DeviceFile = "SL Survival/DeviceList.json" Auto Hidden

Bool Property CanDoArmCuffs = false Auto Hidden Conditional
Bool Property CanDoLegCuffs = false Auto Hidden Conditional
Bool Property CanDoBoots = false Auto Hidden Conditional
Bool Property CanDoGloves = false Auto Hidden Conditional
Bool Property CanDoPiercingsNipples = false Auto Hidden Conditional
Bool Property CanDoPiercingsVaginal = false Auto Hidden Conditional
Bool Property CanDoGags = false Auto Hidden Conditional
Bool Property CanDoCollar = false Auto Hidden Conditional
Bool Property CanDoHarness = false Auto Hidden Conditional
Bool Property CanDoCorsets = false Auto Hidden Conditional
Bool Property CanDoBeltAndPlugs = false Auto Hidden Conditional
Bool Property CanDoBelt = false Auto Hidden Conditional
Bool Property CanDoSuits = false Auto Hidden Conditional
Bool Property CanDoBlindfolds = false Auto Hidden Conditional

Formlist Property _SLS_WornDeviceList Auto
Formlist Property _SLS_IncPickPocketLootKeys Auto
Formlist Property _SLS_DeviceListPony Auto

Actor Property PlayerRef Auto

Keyword Property _DList_TownCollar Auto Hidden
Keyword Property _SLS_UnusedDummyKw Auto

Keyword Property zad_DeviousHood Auto Hidden
Keyword Property zad_DeviousAnkleShackles Auto Hidden
Keyword Property zad_DeviousBlindfold Auto Hidden
Keyword Property zad_DeviousBoots Auto Hidden
Keyword Property zad_DeviousCollar Auto Hidden
Keyword Property zad_DeviousHarness Auto Hidden
Keyword Property zad_DeviousCorset Auto Hidden
Keyword Property zad_DeviousArmCuffs Auto Hidden
Keyword Property zad_DeviousLegCuffs Auto Hidden
Keyword Property zad_DeviousGag Auto Hidden
Keyword Property zad_DeviousGloves Auto Hidden
Keyword Property zad_DeviousPiercingsNipple Auto Hidden
Keyword Property zad_DeviousPiercingsVaginal Auto Hidden
Keyword Property zad_DeviousHeavyBondage Auto Hidden
Keyword Property zad_PermitOral Auto Hidden
Keyword Property zad_DeviousBelt Auto Hidden
Keyword Property zad_DeviousBra Auto Hidden
Keyword Property zad_DeviousArmbinder Auto Hidden
Keyword Property zad_DeviousArmbinderElbow Auto Hidden
Keyword Property zad_DeviousYoke Auto Hidden
Keyword Property zad_DeviousYokeBB Auto Hidden
Keyword Property zad_DeviousPlugAnal Auto Hidden
Keyword Property zad_DeviousPlugVaginal Auto Hidden
Keyword Property zad_DeviousSuit Auto Hidden
Keyword Property zad_DeviousPetSuit  Auto Hidden
Keyword Property zad_DeviousStraitJacket Auto Hidden
Keyword Property zad_DialGagHard Auto Hidden
Keyword Property zad_Lockable Auto Hidden
Keyword Property zad_BlockGeneric Auto Hidden
Keyword Property zad_InventoryDevice Auto Hidden

Armor Property zad_armBinderHisec_Inventory Auto Hidden
