Scriptname SLS_KennelKeeper extends ObjectReference 

import JsonUtil

Function AcceptDeal(Bool Paid)
	If Paid
		PlayerRef.RemoveItem(Gold001, _SLS_KennelCellCost.GetValueInt())
		PlayerRef.AddItem(_SLS_CellKey, 1)
		If !Devious.AreHandsAvailable(PlayerRef)
			Debug.Notification("He pops a key into your mouth")
		EndIf
	EndIf
	FadeToBlackImod.Apply()
	SendModEvent("dhlp-Suspend") ; Doesn't seem to help
	Int i = PlayerRef.GetNumItems()
	While i > 0
		i -= 1
		Form ItemSelect = PlayerRef.GetNthForm(i)
		If ((ItemSelect.HasKeyword(ClothingBody) || ItemSelect.HasKeyword(ArmorCuirass)) && !(ItemSelect.HasKeyword(SexlabNoStrip))) || (ItemSelect.HasKeyword(VendorItemFood) && !ItemSelect as Potion) || ItemSelect.HasKeyword(VendorItemFoodRaw) || ItemSelect as Weapon
			PlayerRef.RemoveItem(ItemSelect, PlayerRef.GetItemCount(ItemSelect), true, LinkedChest)
		EndIf
	EndWhile
	If IsKennelResDealLocation()
		ResDealTimer.DidCheckIn = true
	EndIf
	Utility.Wait(2.0)
	FadeToBlackBackImod.Apply()
	If LinkedGate.Is3dLoaded()
		_SLS_KennelGateClose.Play(LinkedGate)
	EndIf
	PlayerRef.MoveTo(InsideGateMarker)
	LinkedGate.SetLockLevel(255)
	LinkedGate.Lock(true)
	LoadDoor.SetLockLevel(255)
	LoadDoor.Lock(true)
	LinkedChest.SetLockLevel(255)
	LinkedChest.Lock(true)
	CellDoor.SetLockLevel(255)
	CellDoor.Lock(true)
		
	; Unlock gate at 6am
	;/
	float Time = Utility.GetCurrentGameTime()
	Time -= Math.Floor(Time) ; Remove "previous in-game days passed" bit
	Time *= 24
	
	If Time < 5.5 ; 2.5 & !3.0 to allow for error in calc causing update spam
		Debug.trace("SLS_: Kennel gate updating in " + (6.0 - Time))
		RegisterForSingleUpdateGameTime(6.0 - Time)
	Else
		Debug.trace("SLS_: Kennel gate updating in " + (30.0 - Time))
		RegisterForSingleUpdateGameTime(30.0 - Time)
	Endif
	/;
	Float Hour = GameHour.GetValue()
	Float HoursToUpdate
	If Hour < 6.0
		HoursToUpdate = 6.0 - Hour
	Else
		HoursToUpdate = (24.0 - Hour) + 6.0
	EndIf
	DoGifts()
	Debug.Trace("_SLS_: Unlock kennel gate in " + HoursToUpdate + ". Current Hour: " + Hour)
	RegisterForSingleUpdateGameTime(HoursToUpdate)
EndFunction

Function DoGifts()
	If IsKennelResDealLocation()
		; 0 - Not addicted - 0
		; 1 - Experimentation - 1
		; 2 - Regular Use - 1
		; 3 - Risky Use - 2
		; 4 - Dependence - 2
		; 5 - Addiction - 3

		bool DidGift = false
		Int MinGift = GetMinSkooma()
		If MinGift > 0 && (PlayerRef.GetItemCount(Skooma) + _SLS_KennelStash.GetItemCount(Skooma)) < MinGift
			PlayerRef.AddItem(Skooma, MinGift - PlayerRef.GetItemCount(Skooma))
			DidGift = true
		EndIf
		
		MinGift = GetCumGiftCount() - (CumAddict.CountCumPotions(PlayerRef) + CumAddict.CountCumPotions(_SLS_KennelStash))
		Formlist FlSelect = _SLS_CumPotionHuman
		If Init.SlsCreatureEvents
			FlSelect = _SLS_CumPotionAll
		EndIf
		While MinGift > 0
			MinGift -= 1
			PlayerRef.AddItem(FlSelect.GetAt(Utility.RandomInt(0, FlSelect.GetSize() - 1)))
			DidGift = true
		EndWhile
		
		If DidGift
			Debug.Notification("Keeper: Here's a little something for you sweetie")
		EndIf
	EndIf
EndFunction

Int Function GetMinSkooma()
	; 0 - Not addicted - 0
	; 1 - Experimentation - 1
	; 2 - Regular Use - 1
	; 3 - Risky Use - 2
	; 4 - Dependence - 2
	; 5 - Addiction - 3
	
	Int SwAddiction = Menu.Util.GetSkoomaJunkieLevel(PlayerRef, false)
	If SwAddiction >= 5
		Return 4
	ElseIf SwAddiction >= 3
		Return 3
	ElseIf SwAddiction >= 1
		Return 2
	EndIf
	Return 1 ; Give at least one to get started
EndFunction

Int Function GetCumGiftCount()
	Int CumAddictStage = CumAddict.GetAddictionState()
	If CumAddictStage >= 4 ; Junkie
		Return 3
	ElseIf CumAddictStage >= 3 ; Dump
		Return 2
	ElseIf CumAddictStage >= 2 ; Addict
		Return 2
	ElseIf CumAddictStage >= 1 ; Tolerant
		Return 1
	EndIf
	Return 1 ; Give at least one to get started
EndFunction

Function EquipDevices()
	
	; Armbinder / Yoke / YokeBB
	If PlayerRef.WornHasKeyword(Devious.zad_DeviousArmbinder)
		WasArmsRestrained = Devious.GetWornDeviceByKeyword(PlayerRef, Devious.zad_DeviousArmbinder)
	ElseIf PlayerRef.WornHasKeyword(Devious.zad_DeviousYoke)
		WasArmsRestrained = Devious.GetWornDeviceByKeyword(PlayerRef, Devious.zad_DeviousYoke)
	ElseIf PlayerRef.WornHasKeyword(Devious.zad_DeviousYokeBB)
		WasArmsRestrained = Devious.GetWornDeviceByKeyword(PlayerRef, Devious.zad_DeviousYokeBB)
	ElseIf PlayerRef.WornHasKeyword(Devious.zad_DeviousArmbinderElbow)
		WasArmsRestrained = Devious.GetWornDeviceByKeyword(PlayerRef, Devious.zad_DeviousArmbinderElbow)
	EndIf
	If WasArmsRestrained != None
		Devious.RemoveDevice(PlayerRef, WasArmsRestrained)
	EndIf
	
	; Harness
	If PlayerRef.WornHasKeyword(Devious.zad_DeviousHarness)
		WasWearingHarness =Devious.GetWornDeviceByKeyword(PlayerRef, Devious.zad_DeviousHarness)
		Devious.RemoveDevice(PlayerRef, WasWearingHarness)
	EndIf
	
	; Belt
	If PlayerRef.WornHasKeyword(Devious.zad_DeviousBelt)
		WasWearingBelt = Devious.GetWornDeviceByKeyword(PlayerRef, Devious.zad_DeviousBelt)
		Devious.RemoveDevice(PlayerRef, WasWearingBelt)
	EndIf
	
	; Bra
	If PlayerRef.WornHasKeyword(Devious.zad_DeviousBra)
		WasWearingBra = Devious.GetWornDeviceByKeyword(PlayerRef, Devious.zad_DeviousBra)
		Devious.RemoveDevice(PlayerRef, WasWearingBra)
	EndIf
	
	; Body
	If PlayerRef.WornHasKeyword(Devious.zad_DeviousSuit)
		WasWearingSuit = Devious.GetWornDeviceByKeyword(PlayerRef, Devious.zad_DeviousSuit)
		Devious.RemoveDevice(PlayerRef, WasWearingSuit)
	EndIf
	
	If StorageUtil.GetIntValue(Menu, "KennelSuits", Missing = 0) == 1
		Int RanInt = Utility.RandomInt(1, 3)
		If RanInt == 1
			Devious.EquipRandomDeviceByCategory(akActor = PlayerRef, DeviceCategory = "HobbleSkirts")
		ElseIf RanInt == 2
			Devious.EquipRandomDeviceByCategory(akActor = PlayerRef, DeviceCategory = "StraitJackets")
		Else
			Devious.EquipRandomDeviceByCategory(akActor = PlayerRef, DeviceCategory = "PetSuits")
		EndIf
	EndIf
	
	; Boots
	If PlayerRef.WornHasKeyword(Devious.zad_DeviousBoots)
		WasWearingBoots = Devious.GetWornDeviceByKeyword(PlayerRef, Devious.zad_DeviousBoots)
		Devious.RemoveDevice(PlayerRef, WasWearingBoots)
	EndIf
	Devious.EquipRandomDeviceByCategory(akActor = PlayerRef, DeviceCategory = "Pony_Boots")
	
	; Anal Plug
	If PlayerRef.WornHasKeyword(Devious.zad_DeviousPlugAnal)
		WasWearingAnalPlug = Devious.GetWornDeviceByKeyword(PlayerRef, Devious.zad_DeviousPlugAnal)
		Devious.RemoveDevice(PlayerRef, WasWearingAnalPlug)
	EndIf
	Devious.EquipRandomDeviceByCategory(akActor = PlayerRef, DeviceCategory = "Pony_PlugsAnal")
	
	; Gloves - Leave mitts until last. They seem to stop other devices equipping successfully
	If PlayerRef.WornHasKeyword(Devious.zad_DeviousGloves)
		WasWearingGloves = Devious.GetWornDeviceByKeyword(PlayerRef, Devious.zad_DeviousGloves)
		Devious.RemoveDevice(PlayerRef, WasWearingGloves)
	EndIf
	Devious.EquipRandomDeviceByCategory(akActor = PlayerRef, DeviceCategory = "Mitts")
EndFunction

Function RemoveDevices()

	; Gloves
	If PlayerRef.WornHasKeyword(Devious.zad_DeviousGloves)
		Devious.RemoveDevice(PlayerRef, Devious.GetWornDeviceByKeyword(PlayerRef, Devious.zad_DeviousGloves))
	EndIf
	If WasWearingGloves != None
		Devious.EquipDevice(PlayerRef, WasWearingGloves)
	EndIf
	
	; Harness
	If PlayerRef.WornHasKeyword(Devious.zad_DeviousHarness)
		Devious.RemoveDevice(PlayerRef, Devious.GetWornDeviceByKeyword(PlayerRef, Devious.zad_DeviousHarness))
	EndIf
	If WasWearingHarness != None
		Devious.EquipDevice(PlayerRef, WasWearingHarness)
	EndIf
	
	; Belt
	If PlayerRef.WornHasKeyword(Devious.zad_DeviousBelt)
		Devious.RemoveDevice(PlayerRef, Devious.GetWornDeviceByKeyword(PlayerRef, Devious.zad_DeviousBelt))
	EndIf
	If WasWearingBelt != None
		Devious.EquipDevice(PlayerRef, WasWearingBelt)
	EndIf
	
	; Bra
	If PlayerRef.WornHasKeyword(Devious.zad_DeviousBra)
		Devious.RemoveDevice(PlayerRef, Devious.GetWornDeviceByKeyword(PlayerRef, Devious.zad_DeviousBra))
	EndIf
	If WasWearingBra != None
		Devious.EquipDevice(PlayerRef, WasWearingBra)
	EndIf
	
	; Suit
	If PlayerRef.WornHasKeyword(Devious.zad_DeviousSuit)
		Devious.RemoveDevice(PlayerRef, Devious.GetWornDeviceByKeyword(PlayerRef, Devious.zad_DeviousSuit))
	ElseIf PlayerRef.WornHasKeyword(Devious.zad_DeviousPetSuit)
		Devious.RemoveDevice(PlayerRef, Devious.GetWornDeviceByKeyword(PlayerRef, Devious.zad_DeviousPetSuit))
	EndIf
	If WasWearingSuit != None
		Devious.EquipDevice(PlayerRef, WasWearingSuit)
	EndIf
	
	; Boots
	If PlayerRef.WornHasKeyword(Devious.zad_DeviousBoots)
		Devious.RemoveDevice(PlayerRef, Devious.GetWornDeviceByKeyword(PlayerRef, Devious.zad_DeviousBoots))
	EndIf
	If WasWearingBoots != None
		Devious.EquipDevice(PlayerRef, WasWearingBoots)
	EndIf
	
	; Plug
	If PlayerRef.WornHasKeyword(Devious.zad_DeviousPlugAnal)
		Devious.RemoveDevice(PlayerRef, Devious.GetWornDeviceByKeyword(PlayerRef, Devious.zad_DeviousPlugAnal))
	EndIf
	If WasWearingAnalPlug != None
		Devious.EquipDevice(PlayerRef, WasWearingAnalPlug)
	EndIf
	
	; Armbinder / Yoke / YokeBB
	If WasArmsRestrained
		Devious.EquipDevice(PlayerRef, WasArmsRestrained)
	EndIf
	
	WasWearingHarness = None
	WasWearingGloves = None
	WasWearingBelt = None
	WasWearingBra = None
	WasWearingAnalPlug = None
	WasWearingBoots = None
	WasWearingSuit = None
	WasArmsRestrained = None
EndFunction

Function AskToLeaveKennel()
	RemoveDevices()
	Leaving()
	If Init.KennelResDeal == -1
		Init.KennelResDeal = 0 ; Deal proposed
	EndIf
EndFunction

Function Leaving()
	Slaverun.DecreaseResistance()
	Init.KennelState = 1
	PlayerRef.RemoveItem(_SLS_CellKey, PlayerRef.GetItemCount(_SLS_CellKey))
	SendModEvent("dhlp-Resume")
	LinkedGate.Lock(true)
	LoadDoor.Lock(false)
	LinkedChest.Lock(false)
	LinkedChest.RemoveAllItems(akTransferTo = PlayerRef, abKeepOwnership = true, abRemoveQuestItems = true)
	If IsKennelResDealLocation()
		_SLS_KennelResDealChestTimerQuest.Start()
	EndIf
EndFunction

Event OnUpdateGameTime()
	Init.KennelState = 6
	LinkedGate.Lock(false)
	_SLS_KennelGateUnlock.Play(LinkedGate)
	Debug.Notification("The kennel gate has been unlocked")
EndEvent

Function SelectKennelResDealLic(Int LicType)
	Init.KennelDealLicence = LicType
EndFunction

Function BeginKennelResDeal(Actor akSpeaker)
	Int KennelLocation = Menu.LocTrack.PlayerKennelLocation
	_SLS_KennelResDealLoc.SetValueInt(KennelLocation)
	_SLS_KennelResDealChestTimerQuest.Start()
	_SLS_KennelResDealTimerQuest.Stop()
	_SLS_KennelResDealTimerQuest.Start()
	ObjectReference Licence = Menu.LicUtil.IssueLicence(Issuer = StorageUtil.FormListGet(None, "_SLS_LicenceQuartermastersList", KennelLocation) as Actor, LicenceType = Init.KennelDealLicence, LicenceTerm = 0, DeductGold = false, IsModEvent = true)
	ResDealTimer.PrivLicenceBase = Licence.GetBaseObject()
	;Debug.Messagebox("LicObjRef: " + Licence + "\nBase: " + Licence.GetBaseObject() + "\nLink: " + ResDealTimer.PrivLicenceBase)
	PlayerRef.AddItem(Licence)
	
	Utility.Wait(3.0) ; Wait for expiry to change
	String LicTypeStr = Menu.LicUtil.GetLicTypeByInt(Init.KennelDealLicence)
	_SLS_KennelResDealLicExpiry.SetValue(StorageUtil.GetFloatValue(None, "_SLS_Licence" + LicTypeStr + "ValidUntil"))
EndFunction

Bool Function IsKennelResDealLocation()
	Return _SLS_KennelResDealLoc.GetValueInt() == Menu.LocTrack.PlayerKennelLocation
EndFunction

MiscObject Property Gold001 Auto

Formlist Property _SLS_CumPotionAll Auto
Formlist Property _SLS_CumPotionHuman Auto

Potion Property Skooma Auto

ImageSpaceModifier Property FadeToBlackBackImod Auto
ImageSpaceModifier Property FadeToBlackImod Auto

Sound Property _SLS_KennelGateClose Auto
Sound Property _SLS_KennelGateUnlock Auto

Keyword Property VendorItemFood Auto
Keyword Property VendorItemFoodRaw Auto
Keyword Property SexlabNoStrip Auto
Keyword Property ClothingBody Auto
Keyword Property ArmorCuirass Auto

ObjectReference Property LinkedGate Auto
ObjectReference Property CellDoor Auto
ObjectReference Property InsideGateMarker Auto
ObjectReference Property LinkedChest Auto
ObjectReference Property LoadDoor Auto
ObjectReference Property _SLS_KennelStash Auto

Armor WasWearingHarness
Armor WasWearingBelt
Armor WasWearingBra
Armor WasWearingSuit
Armor WasWearingBoots
Armor WasWearingGloves
Armor WasWearingAnalPlug
Armor WasWearingPetSuit
Armor WasArmsRestrained

Key Property _SLS_CellKey Auto

Quest Property _SLS_KennelResDealChestTimerQuest Auto
Quest Property _SLS_KennelResDealTimerQuest Auto

Actor Property PlayerRef Auto

GlobalVariable Property GameHour Auto
GlobalVariable Property _SLS_KennelCellCost Auto
GlobalVariable Property _SLS_KennelResDealLoc Auto
GlobalVariable Property _SLS_KennelResDealLicExpiry Auto

SLS_Init Property Init Auto
SLS_Main Property Main Auto
SLS_Mcm Property Menu Auto
_SLS_CumAddict Property CumAddict Auto
_SLS_KennelResDealTimer Property ResDealTimer Auto
_SLS_InterfaceSlaverun Property Slaverun Auto
_SLS_InterfaceDevious Property Devious Auto
