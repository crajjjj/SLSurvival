Scriptname _SLS_LicenceUtil extends Quest Conditional 

Event OnInit()
	If Self.IsRunning()
		SetupSlotMasks()
		SetupLicTypeStrArray()
		BuildBuyBackPerkArray()
		UpdateGlobalLicVariables()
		SetMagicCurseGlobalStatus()
		RegisterForSingleUpdateGameTime(Math.Ceiling(Utility.GetCurrentGameTime()))
	EndIf
EndEvent

Function PlayerLoadsGame()
	LicNameMaintenance()
EndFunction

Event OnUpdateGameTime()
	
	Float Temp = NextMagicExpiry - Math.Ceiling(Utility.GetCurrentGameTime())
	If Temp == 0 || Temp == 1 || Temp == 2 || Temp == 3 || Temp == 7
		LicenceExpiryNotify("magic ", NextMagicExpiry)
	EndIf
	
	Temp = NextWeaponExpiry - Math.Ceiling(Utility.GetCurrentGameTime())
	If Temp == 0 || Temp == 1 || Temp == 2 || Temp == 3 || Temp == 7
		LicenceExpiryNotify("weapon ", NextWeaponExpiry)
	EndIf
	
	Temp = NextArmorExpiry - Math.Ceiling(Utility.GetCurrentGameTime())
	If Temp == 0 || Temp == 1 || Temp == 2 || Temp == 3 || Temp == 7
		LicenceExpiryNotify("armor ", NextArmorExpiry)
	EndIf

	Temp = NextBikiniExpiry - Math.Ceiling(Utility.GetCurrentGameTime())
	If Temp == 0 || Temp == 1 || Temp == 2 || Temp == 3 || Temp == 7
		LicenceExpiryNotify("bikini ", NextBikiniExpiry)
	EndIf
	
	Temp = NextClothesExpiry - Math.Ceiling(Utility.GetCurrentGameTime())
	If Temp == 0 || Temp == 1 || Temp == 2 || Temp == 3 || Temp == 7
		LicenceExpiryNotify("clothes ", NextClothesExpiry)
	EndIf
	
	Temp = NextCurfewExpiry - Math.Ceiling(Utility.GetCurrentGameTime())
	If Temp == 0 || Temp == 1 || Temp == 2 || Temp == 3 || Temp == 7
		LicenceExpiryNotify("curfew ", NextCurfewExpiry)
	EndIf
	
	Temp = NextWhoreExpiry - Math.Ceiling(Utility.GetCurrentGameTime())
	If Temp == 0 || Temp == 1 || Temp == 2 || Temp == 3 || Temp == 7
		LicenceExpiryNotify("whore ", NextWhoreExpiry)
	EndIf
	
	Temp = NextFreedomExpiry - Math.Ceiling(Utility.GetCurrentGameTime())
	If Temp == 0 || Temp == 1 || Temp == 2 || Temp == 3 || Temp == 7
		LicenceExpiryNotify("freedom ", NextFreedomExpiry)
	EndIf
	
	Temp = NextPropertyExpiry - Math.Ceiling(Utility.GetCurrentGameTime())
	If Temp == 0 || Temp == 1 || Temp == 2 || Temp == 3 || Temp == 7
		LicenceExpiryNotify("property ", NextPropertyExpiry)
	EndIf
	
	UpdateConditionals()
	Float CurrentTime = Utility.GetCurrentGameTime()
	Float UpdateTime = ((Math.Ceiling(CurrentTime) - CurrentTime) * 24.0) + 0.1
	RegisterForSingleUpdateGameTime(UpdateTime)
EndEvent

Function LicNameMaintenance()
	_SLS_LicenceCupcakeArmor.SetName(LicArmorDerogName)
	_SLS_LicenceCupcakeBikini.SetName(LicBikiniDerogName)
	_SLS_LicenceCupcakeClothes.SetName(LicClothesDerogName)
	_SLS_LicenceCupcakeMagic.SetName(LicMagicDerogName)
	_SLS_LicenceCupcakeWeapon.SetName(LicWeaponDerogName)
	_SLS_LicenceCupcakeCurfew.SetName(LicCurfewDerogName)
	_SLS_LicenceCupcakeWhore.SetName(LicWhoreDerogName)
	_SLS_LicenceCupcakeFreedom.SetName(LicFreedomDerogName)
	_SLS_LicenceCupcakeProperty.SetName(LicPropertyDerogName)
	
	_SLS_LicenceIssuerArmor.SetName(LicArmorIssuerName)
	_SLS_LicenceIssuerBikini.SetName(LicBikiniIssuerName)
	_SLS_LicenceIssuerClothes.SetName(LicClothesIssuerName)
	_SLS_LicenceIssuerMagic.SetName(LicMagicIssuerName)
	_SLS_LicenceIssuerWeapon.SetName(LicWeaponIssuerName)
	_SLS_LicenceIssuerCurfew.SetName(LicCurfewIssuerName)
	_SLS_LicenceIssuerWhore.SetName(LicWhoreIssuerName)
	_SLS_LicenceIssuerFreedom.SetName(LicFreedomIssuerName)
	_SLS_LicenceIssuerProperty.SetName(LicPropertyIssuerName)
	
	_SLS_LicenceExpiryArmor.SetName(LicExpiryArmor)
	_SLS_LicenceExpiryBikini.SetName(LicExpiryBikini)
	_SLS_LicenceExpiryClothes.SetName(LicExpiryClothes)
	_SLS_LicenceExpiryMagic.SetName(LicExpiryMagic)
	_SLS_LicenceExpiryWeapon.SetName(LicExpiryWeapon)
	_SLS_LicenceExpiryCurfew.SetName(LicExpiryCurfew)
	_SLS_LicenceExpiryWhore.SetName(LicExpiryWhore)
	_SLS_LicenceExpiryFreedom.SetName(LicExpiryFreedom)
	_SLS_LicenceExpiryProperty.SetName(LicExpiryProperty)
EndFunction

Function UpdateConditionals()
	Float DaysPassed = Math.Ceiling(Utility.GetCurrentGameTime())
	If NextMagicExpiry - DaysPassed > 0.0
		HasValidMagicLicence = true
	Else
		HasValidMagicLicence = false
	EndIf
	
	If NextWeaponExpiry - DaysPassed > 0.0
		HasValidWeaponLicence = true
	Else
		HasValidWeaponLicence = false
	EndIf
	
	If NextArmorExpiry - DaysPassed > 0.0
		HasValidArmorLicence = true
	Else
		HasValidArmorLicence = false
	EndIf
	
	If NextBikiniExpiry - DaysPassed > 0.0
		HasValidBikiniLicence = true
	Else
		HasValidBikiniLicence = false
	EndIf
	
	If NextClothesExpiry - DaysPassed > 0.0
		HasValidClothesLicence = true
	Else
		HasValidClothesLicence = false
	EndIf
	
	If NextCurfewExpiry - DaysPassed > 0.0
		HasValidCurfewLicence = true
	Else
		HasValidCurfewLicence = false
	EndIf
	
	If NextWhoreExpiry - DaysPassed > 0.0
		HasValidWhoreLicence = true
	Else
		HasValidWhoreLicence = false
	EndIf
	
	If NextFreedomExpiry - DaysPassed > 0.0
		HasValidFreedomLicence = true
	Else
		HasValidFreedomLicence = false
	EndIf
	
	If NextPropertyExpiry - DaysPassed > 0.0
		HasValidPropertyLicence = true
	Else
		HasValidPropertyLicence = false
	EndIf
	
	UpdateGlobalLicVariables()
	CheckForBikiniCurse()
EndFunction

Function UpdateGlobalLicVariables()
	If Init.LicencesEnable
		If LicMagicEnable
			StorageUtil.SetIntValue(None, "_SLS_HasValidMagicLicence", HasValidMagicLicence as Int)
		Else
			StorageUtil.SetIntValue(None, "_SLS_HasValidMagicLicence", -1)
		EndIf
		
		StorageUtil.SetIntValue(None, "_SLS_HasValidWeaponLicence", HasValidWeaponLicence as Int)
		StorageUtil.SetIntValue(None, "_SLS_HasValidArmorLicence", HasValidArmorLicence as Int)
		
		If LicBikiniEnable
			StorageUtil.SetIntValue(None, "_SLS_HasValidBikiniLicence", HasValidBikiniLicence as Int)
		Else
			StorageUtil.SetIntValue(None, "_SLS_HasValidBikiniLicence", -1)
		EndIf
		
		If LicClothesEnable > 0
			StorageUtil.SetIntValue(None, "_SLS_HasValidClothesLicence", HasValidClothesLicence as Int)
		Else
			StorageUtil.SetIntValue(None, "_SLS_HasValidClothesLicence", -1)
		EndIf
		
		If LicCurfewEnable
			StorageUtil.SetIntValue(None, "_SLS_HasValidCurfewLicence", HasValidCurfewLicence as Int)
		Else
			StorageUtil.SetIntValue(None, "_SLS_HasValidCurfewLicence", -1)
		EndIf
		
		If LicWhoreEnable
			StorageUtil.SetIntValue(None, "_SLS_HasValidWhoreLicence", HasValidWhoreLicence as Int)
		Else
			StorageUtil.SetIntValue(None, "_SLS_HasValidWhoreLicence", -1)
		EndIf
		
		If LicPropertyEnable
			StorageUtil.SetIntValue(None, "_SLS_HasValidPropertyLicence", HasValidPropertyLicence as Int)
		Else
			StorageUtil.SetIntValue(None, "_SLS_HasValidPropertyLicence", -1)
		EndIf
		
		If LicFreedomEnable > 0
			StorageUtil.SetIntValue(None, "_SLS_HasValidFreedomLicence", HasValidFreedomLicence as Int)
		Else
			StorageUtil.SetIntValue(None, "_SLS_HasValidFreedomLicence", -1)
		EndIf
		
	Else
		StorageUtil.SetIntValue(None, "_SLS_HasValidMagicLicence", -1)
		StorageUtil.SetIntValue(None, "_SLS_HasValidWeaponLicence", -1)
		StorageUtil.SetIntValue(None, "_SLS_HasValidArmorLicence", -1)
		StorageUtil.SetIntValue(None, "_SLS_HasValidBikiniLicence", -1)
		StorageUtil.SetIntValue(None, "_SLS_HasValidClothesLicence", -1)
		StorageUtil.SetIntValue(None, "_SLS_HasValidCurfewLicence", -1)
		StorageUtil.SetIntValue(None, "_SLS_HasValidWhoreLicence", -1)
		StorageUtil.SetIntValue(None, "_SLS_HasValidFreedomLicence", -1)
		StorageUtil.SetIntValue(None, "_SLS_HasValidPropertyLicence", -1)
	EndIf
	Util.Api.SendLicenceStateUpdateEvent()
EndFunction

String Function GetDerogName()
	Int i = JsonUtil.StringListCount("SL Survival/LicenceNames.json", "_SLS_LicenceNames")
	Int Index = Utility.RandomInt(0, i - 1)
	Return JsonUtil.StringListGet("SL Survival/LicenceNames.json", "_SLS_LicenceNames", Index)
EndFunction

ObjectReference Function IssueLicence(Actor Issuer, Int LicenceType = -1, Int LicenceTerm = -1, Bool DeductGold = true, Bool IsModEvent = false)
	; LicenceType: 0 - Magic, 1 - weapons, 2 - Armor, 3 - Bikini, 4 - Clothes. 5 - Curfew, 6 - Whore, 7 - Freedom, 8 - Property. -1 = Not set -> set via dialogue
	; TermDuration: 0 - Short term, 1 - Long term, 2 - Perpetual. -1 = Not set -> set via dialogue
	
	; Set mod event parameters
	If LicenceType > -1 && LicenceTerm > -1
		BuyLicenceType = LicenceType
		BuyLicenceTerm = LicenceTerm
	EndIf
	
	Debug.Trace("_SLS_: BuyLicenceType: " + BuyLicenceType + ". BuyLicenceTerm: " + BuyLicenceTerm)
	
	LicenceIntroDone = true

	Int GoldCost
	If BuyLicenceTerm == 0
		GoldCost = _SLS_LicCostShort.GetValueInt()
	ElseIf BuyLicenceTerm == 1
		GoldCost = _SLS_LicCostLong.GetValueInt()
	ElseIf BuyLicenceTerm == 2
		GoldCost = _SLS_LicCostPer.GetValueInt()
	EndIf
	;Debug.Messagebox("Lic: " + _SLS_LicenceListBaseForms.GetAt(BuyLicenceType).GetName())
	ObjectReference Licence = PlayerRef.PlaceAtMe(_SLS_LicenceListBaseForms.GetAt(BuyLicenceType), aiCount = 1, abForcePersist = false, abInitiallyDisabled = false)
	(Licence as _SLS_Licence).InitLicence(BuyLicenceType, BuyLicenceTerm)
	StorageUtil.FormListAdd(None, "_SLS_LicenceList" + LicTypesString[BuyLicenceType], Licence, AllowDuplicate = false)
	ReferenceAlias AliasSelect = _SLS_LicenceAliases.GetNthAlias((BuyLicenceType * 3) + BuyLicenceTerm) as ReferenceAlias
	ObjectReference OldLic = AliasSelect.GetReference()
	If OldLic
		StorageUtil.FormListRemove(None, "_SLS_LicenceList" + LicTypesString[BuyLicenceType], OldLic, AllInstances = true)
		If PlayerRef.GetItemCount(OldLic) > 0
			PlayerRef.RemoveItem(OldLic)
		EndIf
		OldLic.Disable()
		OldLic.Delete()
	EndIf
	AliasSelect.ForceRefTo(Licence)

	String DerogName = GetDerogName()
	String IssuerName = Issuer.GetBaseObject().GetName()
	String ExpiryString
	If BuyLicenceTerm == 2
		ExpiryString = "Perpetual "
	Else
		ExpiryString = GetExiryDateAsReadableString(StorageUtil.GetFloatValue(Licence, "_SLS_LicenceExpiry"))
	EndIf
	If BuyLicenceType == 0 ; Magic 
		_SLS_LicenceCupcakeMagic.SetName(DerogName)
		_SLS_LicenceIssuerMagic.SetName(IssuerName)
		_SLS_LicenceExpiryMagic.SetName(ExpiryString)
		LicMagicDerogName = DerogName
		LicMagicIssuerName = IssuerName
		LicExpiryMagic = ExpiryString
		
	ElseIf BuyLicenceType == 1 ; Weapons
		_SLS_LicenceCupcakeWeapon.SetName(DerogName)
		_SLS_LicenceIssuerWeapon.SetName(IssuerName)
		_SLS_LicenceExpiryWeapon.SetName(ExpiryString)
		LicWeaponDerogName = DerogName
		LicWeaponIssuerName = IssuerName
		LicExpiryWeapon = ExpiryString
	
	ElseIf BuyLicenceType == 2 ; Armor
		_SLS_LicenceCupcakeArmor.SetName(DerogName)
		_SLS_LicenceIssuerArmor.SetName(IssuerName)
		_SLS_LicenceExpiryArmor.SetName(ExpiryString)
		LicArmorDerogName = DerogName
		LicArmorIssuerName = IssuerName
		LicExpiryArmor = ExpiryString
		
	ElseIf BuyLicenceType == 3 ; Bikini
		_SLS_LicenceCupcakeBikini.SetName(DerogName)
		_SLS_LicenceIssuerBikini.SetName(IssuerName)
		_SLS_LicenceExpiryBikini.SetName(ExpiryString)
		LicBikiniDerogName = DerogName
		LicBikiniIssuerName = IssuerName
		LicExpiryBikini = ExpiryString
		
	ElseIf BuyLicenceType == 4 ; Clothes
		_SLS_LicenceCupcakeClothes.SetName(DerogName)
		_SLS_LicenceIssuerClothes.SetName(IssuerName)
		_SLS_LicenceExpiryClothes.SetName(ExpiryString)
		LicClothesDerogName = DerogName
		LicClothesIssuerName = IssuerName
		LicExpiryClothes = ExpiryString
		
	ElseIf BuyLicenceType == 5 ; Curfew
		_SLS_LicenceCupcakeCurfew.SetName(DerogName)
		_SLS_LicenceIssuerCurfew.SetName(IssuerName)
		_SLS_LicenceExpiryCurfew.SetName(ExpiryString)
		LicCurfewDerogName = DerogName
		LicCurfewIssuerName = IssuerName
		LicExpiryCurfew = ExpiryString
	
	ElseIf BuyLicenceType == 6 ; Whore
		_SLS_LicenceCupcakeWhore.SetName(DerogName)
		_SLS_LicenceIssuerWhore.SetName(IssuerName)
		_SLS_LicenceExpiryWhore.SetName(ExpiryString)
		LicWhoreDerogName = DerogName
		LicWhoreIssuerName = IssuerName
		LicExpiryWhore = ExpiryString
		
		; Make Public Whore
		Int Handle = ModEvent.create("PW_MakePublicWhore")
		ModEvent.PushInt(Handle, -1) ; -1 use PWs last location
		ModEvent.Send(Handle)
	
	ElseIf BuyLicenceType == 7 ; Freedom
		_SLS_LicenceCupcakeFreedom.SetName(DerogName)
		_SLS_LicenceIssuerFreedom.SetName(IssuerName)
		_SLS_LicenceExpiryFreedom.SetName(ExpiryString)
		LicFreedomDerogName = DerogName
		LicFreedomIssuerName = IssuerName
		LicExpiryFreedom = ExpiryString
	
	ElseIf BuyLicenceType == 8 ; Property
		_SLS_LicenceCupcakeProperty.SetName(DerogName)
		_SLS_LicenceIssuerProperty.SetName(IssuerName)
		_SLS_LicenceExpiryProperty.SetName(ExpiryString)
		LicPropertyDerogName = DerogName
		LicPropertyIssuerName = IssuerName
		LicExpiryProperty = ExpiryString
		PropLic.ScheduleLicenceExpiry(Licence) ; Schedule expiry of property licence so player is evicted on expiry date with or without getting caught without the licence

	EndIf
	
	;Licence.MoveTo(_SLS_LicenceDumpRef)
	Licence.SetActorOwner(None) ; Clear ownership. If ownership is set to the player then guards confiscate it during bounty clear dialogue. (Wait, I know you.)
	
	If DeductGold
		PlayerRef.RemoveItem(Gold001, GoldCost)
	EndIf
	
	If !IsModEvent
		PlayerRef.AddItem(Licence)

		If RequestedContainerHasItems
			Utility.WaitMenuMode(1.5)
			RecoverObjects(Issuer)
		;ElseIf BuyLicenceType == 0
		;	UnNullifyMagic(PlayerRef)
		EndIf
		
		If BuyLicenceType == 0
			RemoveMagicCurseFromAll()
		EndIf
	EndIf
	
	Utility.Wait(2.0)
	CheckForBikiniCurse()
	Return Licence
EndFunction

String Function GetExiryDateAsReadableString(Float ExpiryDate)
	String ExpiryAsString = Utility.GameTimeToString(Math.Ceiling(ExpiryDate))
	String Month = GetMonth(StringUtil.Substring(ExpiryAsString, startIndex = 0, len = 2))
	String Day = StringUtil.Substring(ExpiryAsString, startIndex = 3, len = 2)
	;Debug.Trace("_SLS_: ExpiryAsString: " + ExpiryAsString + ". Month:" + Month + ". Day: " + Day)
	Return ((Day as Int) + 1) + GetDayDescrip(Day) + "of " + Month
EndFunction

String Function GetMonth(String MonthAsString) ; 'January' is 00 not 01
	If MonthAsString == "00"
		Return "Morning Star. "
	ElseIf MonthAsString == "01"
		Return "Sun's Dawn. "
	ElseIf MonthAsString == "02"
		Return "First Seed. "
	ElseIf MonthAsString == "03"
		Return "Rain's Hand. "
	ElseIf MonthAsString == "04"
		Return "Second Seed. "
	ElseIf MonthAsString == "05"
		Return "Mid Year. "
	ElseIf MonthAsString == "06"
		Return "Sun's Height. "
	ElseIf MonthAsString == "07"
		Return "Last Seed. "
	ElseIf MonthAsString == "08"
		Return "Hearthfire. "
	ElseIf MonthAsString == "09"
		Return "Frost Fall. "
	ElseIf MonthAsString == "10"
		Return "Sun's Dusk. "
	ElseIf MonthAsString == "11"
		Return "Evening Star. "
	Else
		Debug.Trace("_SLS_: GetMonth error - out of range")
	EndIf
EndFunction

String Function GetDayDescrip(String DayAsString)
	Int DayAsInt = StringUtil.Substring(DayAsString, startIndex = 1, len = 1) as Int
	If DayAsInt == 0 ; '1st' is 00 not 01
		Return "st "
	ElseIf DayAsInt == 1
		Return "nd "
	ElseIf DayAsInt == 2
		Return "rd "
	ElseIf DayAsInt >= 3
		Return "th "
	EndIf
EndFunction

Function CheckAllLicencesExpiry()
	Int i = 0
	While i <= 8
		BeginUpdateLicenceExpiry(i)
		i += 1
	EndWhile
EndFunction

Function BeginUpdateLicenceExpiry(Int LicenceType)
	If LicenceType == 0 ; "magic "
		UpdateLicenceExpiry(NextMagicExpiry, LicenceType)
		LicenceExpiryNotify(LicTypesString[LicenceType], NextMagicExpiry)
	ElseIf LicenceType == 1 ; "weapon "
		UpdateLicenceExpiry(NextWeaponExpiry, LicenceType)
		LicenceExpiryNotify(LicTypesString[LicenceType], NextWeaponExpiry)
	ElseIf LicenceType == 2 ; "armor "
		UpdateLicenceExpiry(NextArmorExpiry, LicenceType)
		LicenceExpiryNotify(LicTypesString[LicenceType], NextArmorExpiry)
	ElseIf LicenceType == 3 ; "bikini "
		UpdateLicenceExpiry(NextBikiniExpiry, LicenceType)
		LicenceExpiryNotify(LicTypesString[LicenceType], NextBikiniExpiry)
	ElseIf LicenceType == 4 ; "clothes "
		UpdateLicenceExpiry(NextClothesExpiry, LicenceType)
		LicenceExpiryNotify(LicTypesString[LicenceType], NextClothesExpiry)
	ElseIf LicenceType == 5 ; "curfew "
		UpdateLicenceExpiry(NextCurfewExpiry, LicenceType)
		LicenceExpiryNotify(LicTypesString[LicenceType], NextCurfewExpiry)
	ElseIf LicenceType == 6 ; "whore "
		UpdateLicenceExpiry(NextWhoreExpiry, LicenceType)
		LicenceExpiryNotify(LicTypesString[LicenceType], NextWhoreExpiry)
	ElseIf LicenceType == 7 ; "freedom "
		UpdateLicenceExpiry(NextFreedomExpiry, LicenceType)
		LicenceExpiryNotify(LicTypesString[LicenceType], NextFreedomExpiry)
	ElseIf LicenceType == 8 ; "property "
		UpdateLicenceExpiry(NextPropertyExpiry, LicenceType)
		LicenceExpiryNotify(LicTypesString[LicenceType], NextPropertyExpiry)
	Else
		Debug.Trace("_SLS_: BeginUpdateLicenceExpiry: Unknown licence type: " + LicenceType)
	EndIf
EndFunction

Function UpdateLicenceExpiry(Float CurrentExpiry, Int LicenceType)
	ObjectReference LicenceSelect
	Float ExpiryTemp = -1.0
	Float ExpiryMax = -1.0
	Int i = 0
	While i < StorageUtil.FormListCount(None, "_SLS_LicenceList" + LicTypesString[LicenceType])
	
	
		LicenceSelect = StorageUtil.FormListGet(None, "_SLS_LicenceList" + LicTypesString[LicenceType], i) as ObjectReference
		If PlayerRef.GetItemCount(LicenceSelect) > 0
			ExpiryTemp = StorageUtil.GetFloatValue(LicenceSelect, "_SLS_LicenceExpiry", -1.0)
			If ExpiryTemp > ExpiryMax
				ExpiryMax = ExpiryTemp
			EndIf
		EndIf
		i += 1
	EndWhile
	
	If LicenceType == 0
		NextMagicExpiry = ExpiryMax
		_SLS_LicenceMagicValidUntil.SetValue(ExpiryMax)
		StorageUtil.SetFloatValue(None, "_SLS_LicenceMagicValidUntil", ExpiryMax)
		
	ElseIf LicenceType == 1
		NextWeaponExpiry = ExpiryMax
		_SLS_LicenceWeaponValidUntil.SetValue(ExpiryMax)
		StorageUtil.SetFloatValue(None, "_SLS_LicenceWeaponValidUntil", ExpiryMax)
		
	ElseIf LicenceType == 2
		NextArmorExpiry = ExpiryMax
		_SLS_LicenceArmorValidUntil.SetValue(ExpiryMax)
		StorageUtil.SetFloatValue(None, "_SLS_LicenceArmorValidUntil", ExpiryMax)

	ElseIf LicenceType == 3
		NextBikiniExpiry = ExpiryMax
		_SLS_LicenceBikiniValidUntil.SetValue(ExpiryMax)
		StorageUtil.SetFloatValue(None, "_SLS_LicenceBikiniValidUntil", ExpiryMax)
		
	ElseIf LicenceType == 4
		NextClothesExpiry = ExpiryMax
		_SLS_LicenceClothesValidUntil.SetValue(ExpiryMax)
		StorageUtil.SetFloatValue(None, "_SLS_LicenceClothesValidUntil", ExpiryMax)
		
	ElseIf LicenceType == 5
		NextCurfewExpiry = ExpiryMax
		_SLS_LicenceCurfewValidUntil.SetValue(ExpiryMax)
		StorageUtil.SetFloatValue(None, "_SLS_LicenceCurfewValidUntil", ExpiryMax)
		
	ElseIf LicenceType == 6
		NextWhoreExpiry = ExpiryMax
		_SLS_LicenceWhoreValidUntil.SetValue(ExpiryMax)
		StorageUtil.SetFloatValue(None, "_SLS_LicenceWhoreValidUntil", ExpiryMax)
		
	ElseIf LicenceType == 7
		NextFreedomExpiry = ExpiryMax
		_SLS_LicenceFreedomValidUntil.SetValue(ExpiryMax)
		StorageUtil.SetFloatValue(None, "_SLS_LicenceFreedomValidUntil", ExpiryMax)
		
	ElseIf LicenceType == 8
		NextPropertyExpiry = ExpiryMax
		_SLS_LicencePropertyValidUntil.SetValue(ExpiryMax)
		StorageUtil.SetFloatValue(None, "_SLS_LicencePropertyValidUntil", ExpiryMax)
	EndIf
	
	UpdateConditionals()
EndFunction

String Function LicenceExpiryNotify(String LicenceType, Float Expiry, Bool Notify = true)
	String ExpireString = "My " + LicenceType + " licence " + GetExpiryStatement(Expiry)
	If Notify
		Debug.Notification("My " + LicenceType + " licence " + GetExpiryStatement(Expiry))
	EndIf
	Return ExpireString
EndFunction

String Function GetExpiryStatement(Float ExpiryDate)
	Int Expiry = (ExpiryDate as Int) - Math.Ceiling(Utility.GetCurrentGameTime())
	If Expiry < 1
		Return "has expired"
	Elseif Expiry == 1
		Return "expires tomorrow"
	ElseIf Expiry > 1000
		Return "never expires"
	Else
		Return "expires in " + Expiry + " days."
	EndIf
EndFunction

Function GateLicenceCheckActLeave()
	_SLS_LicenceForceGreetQuest.Stop()
EndFunction

Function GateLicenceCheck(Int ActivatorLocation) ; ActivatorLocation: 0 - Whiterun, 1 - Solitude, 2 - Markarth, 3 - Windhelm, 4 - Riften
	
	; Infraction types
	; -1 - In process
	; -2 - Clear to proceed (no infractions)
	; 0 - Stop for Magic collar
	; 1 - Stop for weapons
	; 2 - Stop for all armors
	; 3 - Stop for non bikini armors
	; 4 - Stop for clothes
	; 5 - Stop for magic items
	; 6 - Stop for follower contraband
	; 7 - Stop for property
	; 8 - Stop for freedom
	; 9 - Stop for hairy pussy
	
	; NeedsMandGag = Needs to be mandatorily gagged when entering the city
	; NeedsMandRestraints = Needs to be mandatorily restrained when entering the city

	Bool OiYou = false
	Bool GetFollowupInfrac = true
	LicInfractionType = -1
	NeedsMandGag = false
	IsMandatorilyGagged = false
	NeedsMandRestraints = false
	LastLicCheckTime = Utility.GetCurrentGameTime()
	;_SLS_LicenceForceGreetQuest.Start()
	(Game.GetFormFromFile(0x0D9760, "SL Survival.esp") as Quest).Start() ; _SLS_LicenceForceGreetKickerQuest
	
	SetIsPlayerAiDriven()
	
	MandatoryRestraints = TollDodge.GetRestraintLevel(ActivatorLocation)
	Bool IsRestrained = Devious.IsProperlyRestrained(MandatoryRestraints)
	If MandatoryRestraints > 0 && !IsRestrained
		;LicInfractionType = 7
		NeedsMandRestraints = true
		OiYou = true
	EndIf
	
	If GetIsMandatoryGagged(ActivatorLocation)
		If !Devious.IsPlayerGagged()
			NeedsMandGag = true
			OiYou = true
		Else
			IsMandatorilyGagged = true
		EndIf
	EndIf

	If GetFollowupInfrac && LicMagicEnable && !HasValidMagicLicence && (!PlayerRef.HasMagicEffect(_SLS_MagicLicenceCollarMgef) || (FollowerLicStyle == 1 && !AllFollowersAreMagicCursed()))
		;Debug.Messagebox("Stop for magic")
		LicInfractionType = 0
		GetFollowupInfrac = false
		OiYou = true
	ElseIf GetFollowupInfrac && LicMagicEnable && !HasValidMagicLicence && BeginGetHasMagicItem(PlayerRef)
		LicInfractionType = 5
		GetFollowupInfrac = false
		OiYou = true
	ElseIf GetFollowupInfrac && !HasValidWeaponLicence && BeginGetHasWeapon(PlayerRef)
		;Debug.Messagebox("Stop for weapons")
		LicInfractionType = 1
		GetFollowupInfrac = false
		OiYou = true
	ElseIf GetFollowupInfrac && BeginGetHasArmor(PlayerRef)
		; Infraction type set in GateLicenceCheckArmor(PlayerRef)
		GetFollowupInfrac = false
		OiYou = true
		
	ElseIf GetFollowupInfrac && GateLicenceCheckClothes(PlayerRef, ActivatorLocation)
		LicInfractionType = 4
		GetFollowupInfrac = false
		OiYou = true

	ElseIf GetFollowupInfrac && FolContrabandCheck.GateLicenceCheckFollowers(MustBeLoaded = true, LocationInt = ActivatorLocation)
		LicInfractionType = 6
		GetFollowupInfrac = false
		OiYou = true

	ElseIf GetFollowupInfrac && LicPropertyEnable && OwnsProperty && !HasValidPropertyLicence && !Menu.Eviction.IsLicenceEvicted
		LicInfractionType = 7
		GetFollowupInfrac = false
		OiYou = true
		
	ElseIf !IsHairyPussyTaxed(ActivatorLocation) && Fashion.GetPubicHairStage() > 0 && IsPubicZoneVisible(PlayerRef)
		LicInfractionType = 9
		GetFollowupInfrac = false
		OiYou = true
		
	;Else
	;	Debug.Messagebox("ok to pass")
	EndIf
	;Debug.Messagebox("LicInfractionType: " + LicInfractionType)
	If !OiYou
		;Actor TheDude = (_SLS_LicenceForceGreetQuest.GetNthAlias(0) as ReferenceAlias).GetReference() as Actor
		;If TheDude && !PlayerRef.IsInDialogueWithPlayer()
		;	_SLS_LicenceForceGreetQuest.Stop()
		;	TheDude.EvaluatePackage()
		;EndIf
		;Utility.Wait(1.5)
		
		LicInfractionType = -2
	Else
		_SLS_LicenceForceGreetQuest.Start()
	EndIf
	;FollowerProc.ProcAllFollowersAllLics(true)
	ActIsInSlaverunFreeTown = IsSlaverunFreeTown(ActivatorLocation)
	;Debug.Messagebox("LICUTIL FIN")
	Debug.Trace("_SLS_: Licence infraction type: " + LicInfractionType + ". Mandatory restraints level: " + MandatoryRestraints + ". Is properly restrained: " + IsRestrained)
EndFunction

Bool Function BeginGetHasArmor(ObjectReference akTarget)
	Bool Result = HasArmor(akTarget)
	Int i = StorageUtil.FormListCount(akTarget, "_SLS_LicenceSearchContainers")
	While !Result && i > 0
		i -= 1
		Result = HasArmor(StorageUtil.FormListGet(akTarget, "_SLS_LicenceSearchContainers", i) as ObjectReference)
	EndWhile
	Return Result
EndFunction

Bool Function HasArmor(ObjectReference akTarget)
	If LicBikiniEnable
		If (!HasValidArmorLicence && !HasValidBikiniLicence) && ActorHasArmor(akTarget)
			;Debug.Messagebox("Stop for all armors")
			LicInfractionType = 2
			Return true
		ElseIf (!HasValidArmorLicence && HasValidBikiniLicence) && IsActorWearingNonBikiniArmor(akTarget)
			;Debug.Messagebox("Stop for non bikini armors")
			LicInfractionType = 3
			Return true
		EndIf
	Else
		If !HasValidArmorLicence && ActorHasArmor(akTarget)
			;Debug.Messagebox("Stop for all armors - bikinis disabled")
			LicInfractionType = 2
			Return true
		EndIf
	EndIf
	Return false
EndFunction

Bool Function BeginGetHasClothes(ObjectReference akTarget)
	Bool Result = HasClothes(akTarget)
	Int i = StorageUtil.FormListCount(akTarget, "_SLS_LicenceSearchContainers")
	While !Result && i > 0
		i -= 1
		Result = HasClothes(StorageUtil.FormListGet(akTarget, "_SLS_LicenceSearchContainers", i) as ObjectReference)
	EndWhile
	Return Result
EndFunction

Bool Function HasClothes(ObjectReference akTarget)
	Actor akTargetActor = akTarget as Actor
	Int i = akTarget.GetNumItems()
	Form Item
	While i > 0
		i -= 1
		Item = akTarget.GetNthForm(i)
		If Item as Armor && (Item as Armor).GetWeightClass() == 2
			If Item.HasKeyword(VendorItemClothing) && !Item.HasKeyword(SexLabNoStrip) && Item.IsPlayable() && !_SLS_LicExceptionsArmor.HasForm(Item) && Item.GetName() != ""
				If akTargetActor == PlayerRef
					Return true
				Else
					If !akTargetActor.IsEquipped(Item) || FollowerLicStyle == 1
						Return true
					Else
						If akTargetActor.GetItemCount(Item) > 1
							Return true
						EndIf
					EndIf						
				EndIf
			EndIf
		EndIf
	EndWhile
	Return false
EndFunction

Bool Function GateLicenceCheckClothes(ObjectReference akTarget, Int LocationInt)
	If LicClothesEnable == 1 ; Always
		If !HasValidClothesLicence && BeginGetHasClothes(akTarget)
			LicInfractionType = 4
			;Debug.Messagebox("Stop for clothes - always")
			Return true
		EndIf
	ElseIf LicClothesEnable == 2 ; Slaverun
		If !HasValidClothesLicence && !IsSlaverunFreeTown(LocationInt) && BeginGetHasClothes(akTarget)
			LicInfractionType = 4
			;Debug.Messagebox("Stop for clothes - slaverun")
			Return true
		EndIf
	EndIf
	Return false
EndFunction

Bool Function BeginGetHasMagicItem(ObjectReference akTarget)
	Bool Result = HasMagicItem(akTarget)
	Int i = StorageUtil.FormListCount(akTarget, "_SLS_LicenceSearchContainers")
	While !Result && i > 0
		i -= 1
		Result = HasMagicItem(StorageUtil.FormListGet(akTarget, "_SLS_LicenceSearchContainers", i) as ObjectReference)
	EndWhile
	Return Result
EndFunction

Bool Function HasMagicItem(ObjectReference akTarget)
	Actor akTargetActor = akTarget as Actor
	Int i = akTarget.GetNumItems()
	Form Item
	While i > 0
		i -= 1
		Item = akTarget.GetNthForm(i)
		If Item as Armor
			If (Item as Armor).GetWeightClass() == 2
				If (Item as Armor).GetEnchantment() != None
					If !Item.HasKeyword(ArmorJewelry) && !Item.HasKeyword(SexLabNoStrip) && Item.IsPlayable() && !_SLS_LicExceptionsArmor.HasForm(Item) && Item.GetName() != ""
						If akTargetActor == PlayerRef
							;Debug.Messagebox("Contraband Magic Item: \n" + Item.GetName() + "\n" + Item)
							Return true
						Else
							If !akTargetActor.IsEquipped(Item) || FollowerLicStyle == 1
								;Debug.Messagebox("Contraband Magic Item: \n" + Item.GetName() + "\n" + Item)
								Return true
							Else
								If akTargetActor.GetItemCount(Item) > 1
									;Debug.Messagebox("Contraband Magic Item: \n" + Item.GetName() + "\n" + Item)
									Return true
								EndIf
							EndIf						
						EndIf
					EndIf
				EndIf
			EndIf
		
		ElseIf Item as Weapon
			If Item.HasKeyword(VendorItemStaff)
				;Debug.Messagebox("Contraband Magic Item: \n" + Item.GetName() + "\n" + Item)
				Return true
			EndIf
			
		ElseIf Item as Book
			If Item.HasKeyword(VendorItemSpellTome)
				;Debug.Messagebox("Contraband Magic Item: \n" + Item.GetName() + "\n" + Item)
				Return true
			EndIf
		
		ElseIf Item as Scroll
			;Debug.Messagebox("Contraband Magic Item: \n" + Item.GetName() + "\n" + Item)
			Return true
		EndIf
	EndWhile
	Return false
EndFunction

Function SetIsPlayerAiDriven()
	_SLS_PlayerIsAIDriven.SetValueInt((PlayerRef.GetCurrentPackage() != None) as Int)
EndFunction

Function SetIsSlaverunFreeTownByPos()
	While LocTrack.PlayerIsInSlavetown == -1
		Utility.Wait(0.1)
	EndWhile
	ActIsInSlaverunFreeTown = LocTrack.PlayerIsInSlavetown as Bool
EndFunction

Function SetIsSlaverunFreeTown(Int LocationInt)
	ActIsInSlaverunFreeTown = IsSlaverunFreeTown(LocationInt)
EndFunction

Bool Function IsSlaverunFreeTown(Int LocationInt)
	Return LocTrack.GetIsFreeTownByInt(LocationInt)
	
	;/
	If LocationInt == 0
		Return Slaverun.IsFreeTownWhiterun()
	ElseIf LocationInt == 1
		Return Slaverun.IsFreeTownSolitude()
	ElseIf LocationInt == 2
		Return Slaverun.IsFreeTownMarkarth()
	ElseIf LocationInt == 3
		Return Slaverun.IsFreeTownWindhelm()
	ElseIf LocationInt == 4
		Return Slaverun.IsFreeTownRiften()
		
	ElseIf LocationInt == 5
		Return Slaverun.IsFreeTownRiverwood()
	ElseIf LocationInt == 6
		Return Slaverun.IsFreeTownFalkreath()
	ElseIf LocationInt == 7
		Return Slaverun.IsFreeTownDawnstar()
	ElseIf LocationInt == 8
		Return Slaverun.IsFreeTownWinterhold()
	ElseIf LocationInt == 9 ; RORIKSTEAD
		Return Slaverun.IsFreeTownRiverwood()
	ElseIf LocationInt == 10 ; SHORS STONE
		Return Slaverun.IsFreeTownRiften()
	ElseIf LocationInt == 11 ; Ivarstead
		Return Slaverun.IsFreeTownRiften()
	ElseIf LocationInt == 12 ; Dragon Bridge
		Return Slaverun.IsFreeTownSolitude()
	ElseIf LocationInt == 13 ; Morthal
		Return Slaverun.IsFreeTownMorthal()
	ElseIf LocationInt == 14 ; Kynesgrove
		Return Slaverun.IsFreeTownWindhelm()
	EndIf
	/;
EndFunction

Bool Function IsObjectContraband(Form akBaseItem, Int LocationInt)
	If akBaseItem as Armor
		If !_SLS_LicExceptionsArmor.HasForm(akBaseItem) && akBaseItem.IsPlayable() && !akBaseItem.HasKeyword(SexLabNoStrip) && akBaseItem.GetName() != ""
			If (akBaseItem as Armor).GetWeightClass() < 2 ; armor
				If !HasValidArmorLicence && !HasValidBikiniLicence
					LicInfractionType = 2
					Return true
				EndIf		
			
				;/
				If akBaseItem.HasKeyword(_SLS_BikiniArmor)
					If !HasValidBikiniLicence && !HasValidArmorLicence
						LicInfractionType = 2
						Return true
					EndIf
					
				ElseIf !HasValidArmorLicence
					LicInfractionType = 3
					Return true
				EndIf
				/;
				
			Else ; Clothes
				If (akBaseItem as Armor).GetEnchantment() != None && !HasValidMagicLicence && !akBaseItem.HasKeyword(ArmorJewelry)
					LicInfractionType = 5
					Return true
				EndIf
				
				If LicClothesEnable == 1 ; Always
					If !HasValidClothesLicence
						LicInfractionType = 4
						Return true
					EndIf
				
				ElseIf LicClothesEnable == 2 ; Slaverun
					If !IsSlaverunFreeTown(LocationInt) && !HasValidClothesLicence
						LicInfractionType = 4
						Return true
					EndIf
				EndIf
			EndIf
		EndIf

	ElseIf akBaseItem as Weapon || akBaseItem as Ammo
		If !HasValidWeaponLicence && !_SLS_LicExceptionsWeapon.HasForm(akBaseItem) && !akBaseItem.HasKeyword(VendorItemStaff)
			LicInfractionType = 1
			Return true
			
		ElseIf akBaseItem.HasKeyword(VendorItemStaff)
			If !HasValidMagicLicence
				LicInfractionType = 5
				Return true
			EndIf
		EndIf
		
	ElseIf akBaseItem as Book
		If akBaseItem.HasKeyword(VendorItemSpellTome)
			If !HasValidMagicLicence
				LicInfractionType = 5
				Return true
			EndIf
		EndIf
		
	ElseIf akBaseItem as Scroll
		If !HasValidMagicLicence
			LicInfractionType = 5
			Return true
		EndIf	
	EndIf
	Return false
EndFunction

Bool Function IsMagicCollarCompliant(Actor akTarget)
	If LicMagicEnable && !HasValidMagicLicence && (!akTarget.HasMagicEffect(_SLS_MagicLicenceCollarMgef) || (FollowerLicStyle == 1 && !AllFollowersAreMagicCursed()))
		Return false
	EndIf
	Return true
EndFunction

Bool Function HasAnyContraband(ObjectReference akTarget, Int LocationInt)
	If BeginGetHasArmor(akTarget)
		;Debug.Messagebox("Returning true on Armor check")
		Return true
		
	ElseIf !HasValidWeaponLicence && BeginGetHasWeapon(akTarget)
		;Debug.Messagebox("Returning true on weapon check")
		LicInfractionType = 1
		Return true
		
	ElseIf LicMagicEnable && !HasValidMagicLicence && BeginGetHasMagicItem(akTarget)
		;Debug.Messagebox("Returning true on HasMagicItem")
		LicInfractionType = 6
		Return true
		
	ElseIf GateLicenceCheckClothes(akTarget, LocationInt)
		;Debug.Messagebox("Returning true on clothes check")
		Return true
	EndIf
	Return false
EndFunction

Bool Function ActorHasArmor(ObjectReference akTarget)
	Actor akTargetActor = akTarget as Actor
	Int i = akTarget.GetNumItems()
	Form Item
	While i > 0
		i -= 1
		Item = akTarget.GetNthForm(i)
		If Item as Armor && (Item as Armor).GetWeightClass() < 2
			If Item.HasKeyword(VendorItemArmor) && !Item.HasKeyword(SexLabNoStrip) && Item.IsPlayable() && Item.GetName() != ""
				If akTargetActor == PlayerRef
					Return true
				Else
					If !akTargetActor.IsEquipped(Item) || FollowerLicStyle == 1
						Return true
					Else
						If akTargetActor.GetItemCount(Item) > 1
							Return true
						EndIf
					EndIf						
				EndIf
			EndIf
		EndIf
	EndWhile
	Return false
EndFunction

Bool Function ActorHasNonBikiniArmor(ObjectReference akTarget) ; Not necessary any more?
	Actor akTargetActor = akTarget as Actor
	Int i = akTarget.GetNumItems()
	Form Item
	While i > 0
		i -= 1
		Item = akTarget.GetNthForm(i)
		If Item as Armor && (Item as Armor).GetWeightClass() < 2 && Item.HasKeyword(VendorItemArmor)
			If !Item.HasKeyword(_SLS_BikiniArmor) && StorageUtil.GetIntValue(Item, "SLAroused.IsBikiniArmor", Missing = -1) <= 0 && !Item.HasKeyword(SexLabNoStrip) && Item.IsPlayable() && Item.GetName() != ""
				If akTargetActor == PlayerRef
					Return true
				Else
					If !akTargetActor.IsEquipped(Item) || FollowerLicStyle == 1
						Return true
					Else
						If akTargetActor.GetItemCount(Item) > 1
							Return true
						EndIf
					EndIf						
				EndIf
			EndIf
		EndIf
	EndWhile
	Return false
EndFunction

Bool Function IsActorWearingNonBikiniArmor(ObjectReference akTarget)
	Actor akTargetActor = akTarget as Actor
	If akTargetActor == PlayerRef ; Only player needs to be checked for worn full armors
		Form akBaseItem
		Int i = SlotMasks.Length
		While i > 0
			i -= 1
			akBaseItem = akTargetActor.GetWornForm(SlotMasks[i])
			If akBaseItem
				If (akBaseItem as Armor).GetWeightClass() < 2
					If !akBaseItem.HasKeyword(_SLS_BikiniArmor) && StorageUtil.GetIntValue(akBaseItem, "SLAroused.IsBikiniArmor", Missing = -1) <= 0 && !akBaseItem.HasKeyword(SexLabNoStrip) && akBaseItem.GetName() != "" && !akBaseItem.HasKeyword(ArmorShield) && !_SLS_LicExceptionsArmor.HasForm(akBaseItem) && !akBaseItem.HasKeyword(ArmorBoots) && !akBaseItem.HasKeyword(ArmorGauntlets) && !akBaseItem.HasKeyword(ArmorHelmet)
						Return true
					EndIf
				EndIf
			EndIf
		EndWhile
	EndIf
	Return false
EndFunction

Bool Function BeginGetHasWeapon(ObjectReference akTarget)
	Bool Result = HasWeapon(akTarget)
	Int i = StorageUtil.FormListCount(akTarget, "_SLS_LicenceSearchContainers")
	;Debug.Trace("_SLS_: BeginGetHasWeapon: FormListCount:" + i)
	;Debug.Messagebox("_SLS_: BeginGetHasWeapon: FormListCount:" + i)
	While !Result && i > 0
		i -= 1
		Result = HasWeapon(StorageUtil.FormListGet(akTarget, "_SLS_LicenceSearchContainers", i) as ObjectReference)
	EndWhile
	Return Result
EndFunction

Bool Function HasWeapon(ObjectReference akTarget)
	;Debug.Trace("_SLS_: HasWeapon: akTarget:" + akTarget)
	;Debug.Messagebox("_SLS_: HasWeapon: akTarget:" + akTarget)
	Actor akTargetActor = akTarget as Actor
	Int i = akTarget.GetNumItems()
	Form Item
	While i > 0
		i -= 1
		Item = akTarget.GetNthForm(i)
		If Item as Weapon
			If Item.HasKeyword(VendorItemWeapon) && !_SLS_LicExceptionsWeapon.HasForm(Item)
				If akTargetActor == PlayerRef
					Return true
				Else
					If !akTargetActor.IsEquipped(Item) || FollowerLicStyle == 1
						Return true
					Else
						If akTargetActor.GetItemCount(Item) > 1
							Return true
						EndIf
					EndIf						
				EndIf
			EndIf
		ElseIf Item as Ammo
			If akTargetActor == PlayerRef
				Return true
			Else
				If !akTargetActor.IsEquipped(Item)
					Return true
				Else
					If akTargetActor.GetItemCount(Item) > 1
						Return true
					EndIf
				EndIf						
			EndIf
		EndIf
	EndWhile
	Return false
EndFunction

Function DoGateObjectInspection()
	
	; Weapons
	If !HasValidWeaponLicence && BeginGetHasWeapon(PlayerRef)
		BeginConfiscateWeapons(PlayerRef)
	EndIf
	
	; Magic
	If LicMagicEnable && !HasValidMagicLicence && (!PlayerRef.HasMagicEffect(_SLS_MagicLicenceCollarMgef) || (FollowerLicStyle == 1 && !AllFollowersAreMagicCursed()))
		NullifyMagic(PlayerRef)
	EndIf
	If LicMagicEnable && !HasValidMagicLicence && BeginGetHasMagicItem(PlayerRef)
		BeginConfiscateMagicItems(PlayerRef)
	EndIf
	
	; Armor
	If LicBikiniEnable
		If (!HasValidArmorLicence && !HasValidBikiniLicence) && BeginGetHasArmor(PlayerRef)
			BeginConfiscateArmors(PlayerRef)
		ElseIf HasValidBikiniLicence
			ConfiscateWornFullArmors(PlayerRef)
		EndIf
		;If (!HasValidArmorLicence && HasValidBikiniLicence) && ActorHasNonBikiniArmor(PlayerRef)
		;	ConfiscateNonBikiniArmors(PlayerRef)
		;EndIf
	Else
		If !HasValidArmorLicence && BeginGetHasArmor(PlayerRef)
			BeginConfiscateArmors(PlayerRef)
		EndIf
	EndIf
	
	; Clothes
	If LicClothesEnable == 1 ; Always
		If !HasValidClothesLicence && BeginGetHasClothes(PlayerRef)
			BeginConfiscateClothes(PlayerRef)
			;ProcFollowerClothes()
		EndIf
	ElseIf LicClothesEnable == 2 ; Slaverun
		If !Slaverun.IsFreeArea(PlayerRef.GetCurrentLocation()) && !HasValidClothesLicence && BeginGetHasClothes(PlayerRef)
			BeginConfiscateClothes(PlayerRef)
			;ProcFollowerClothes()
		EndIf
	EndIf
	
	; Property
	If LicPropertyEnable && !HasValidPropertyLicence && OwnsProperty; && Evic
		PropLic.EvictFromAll(DoEvict = true, DoImmediately = true)
	EndIf
	
	ProcAllFollowers(MustBeLoaded = true)
	SendModEvent("_BC_UpdateBackPackWeight")
EndFunction

Function NullifyMagic(Actor akTarget)
	If LicMagicEnable
		If Init.DdsInstalled && LicMagicCursedDevices
			CollarMiscreant(akTarget)
			StorageUtil.SetIntValue(None, "_SLS_PlayerIsMagicCursed", 2)
		Else
			
			akTarget.RemoveSpell(_SLS_MagicLicenceCurse)
			Utility.Wait(0.1)
			akTarget.AddSpell(_SLS_MagicLicenceCurse, abVerbose = false)
			CheckOrdinatior(Equipped = true)
			StorageUtil.SetIntValue(None, "_SLS_PlayerIsMagicCursed", 1)
		EndIf
		If CurseTats
			Util.BeginOverlay(akTarget, 0.9, "\\SL Survival\\magic_silence_collar.dds", Menu.OverlayAreas[Menu.MagicCurseArea])
		EndIf
		(Game.GetFormFromFile(0x0D6696, "SL Survival.esp") as Spell).Cast(akTarget, akTarget) ; visual effect only
		If akTarget == PlayerRef && FollowerLicStyle == 1 ; Curse all followers if party wide licence system
			Quest CurseFollowersQuest = Game.GetFormFromFile(0x0D669C, "SL Survival.esp") as Quest
			(CurseFollowersQuest as _SLS_LicMagicCurseFollowers).ClearAllAliases()
			CurseFollowersQuest.Stop()
			CurseFollowersQuest.Start()
		
		ElseIf akTarget != PlayerRef
			akTarget.RemoveSpell(_SLS_MagicLicenceCurse)
			Utility.Wait(0.1)
			akTarget.AddSpell(_SLS_MagicLicenceCurse, abVerbose = false)
		EndIf
	
	Else
		Debug.Trace("_SLS_: NullifyMagic(): Magic licence not enabled. Target: " + akTarget)
	EndIf
EndFunction

Function UnNullifyMagic(Actor akTarget)
	If akTarget == PlayerRef
		If IsCollared		
			Devious.RemoveDevice(akTarget, MagicLicenceCollarAlias.GetReference().GetBaseObject() as Armor)
			MagicLicenceCollarAlias.Clear()
			
		Else
			akTarget.RemoveSpell(_SLS_MagicLicenceCurse)
			CheckOrdinatior(Equipped = false)
			StorageUtil.SetIntValue(None, "_SLS_PlayerIsMagicCursed", 0)
		EndIf

	Else ; Follower
		Armor Device = StorageUtil.GetFormValue(akTarget, "_SLS_MagicCurseDeviceInv") as Armor
		If Device
			Devious.RemoveDevice(akTarget, Device)
			StorageUtil.UnSetFormValue(akTarget, "_SLS_MagicCurseDeviceInv")
			StorageUtil.UnSetFormValue(akTarget, "_SLS_MagicCurseDeviceRender")
		EndIf
		akTarget.RemoveSpell(_SLS_MagicLicenceCurse)
	EndIf
	Util.RemoveOverlay(akTarget, "\\SL Survival\\magic_silence_collar.dds", Menu.OverlayAreas[Menu.MagicCurseArea])
EndFunction

Function CollarMiscreant(Actor akTarget)
	Armor BlockingDevice = Devious.GetMagicBlockingDevice(akTarget, RemoveGenericDevice = true)
	;Debug.Messagebox("BlockingDevice: " + BlockingDevice.GetName())
	If BlockingDevice != None
		If akTarget == PlayerRef
			CollarHer(akTarget, BlockingDevice)
		Else
			StorageUtil.SetFormValue(akTarget, "_SLS_MagicCurseDeviceInv", BlockingDevice)
			StorageUtil.SetFormValue(akTarget, "_SLS_MagicCurseDeviceRender", Devious.GetRenderedDevice(BlockingDevice))
			Devious.EquipDevice(akTarget, BlockingDevice)
		EndIf
		
	Else
		;Debug.Messagebox("Applying curse")
		akTarget.RemoveSpell(_SLS_MagicLicenceCurse)
		Utility.Wait(0.5)
		akTarget.AddSpell(_SLS_MagicLicenceCurse, abVerbose = false)
	EndIf
EndFunction

Function CollarHer(Actor akTarget, Armor CollarToUse = None)
	ObjectReference CollarRef = MagicLicenceCollarAlias.GetReference()
	If CollarRef
		If akTarget.GetItemCount(CollarRef) == 0
			CollarRef = None
		EndIf
	EndIf
	If CollarRef == None ; If collar was not yet created, create it
		CollarRef = akTarget.PlaceAtMe(CollarToUse)
		CollarRef.SetDisplayName("Cursed " + CollarToUse.GetName())
		MagicLicenceCollarAlias.ForceRefTo(CollarRef)
		akTarget.Additem(CollarRef)
		
	Else
		CollarToUse = CollarRef.GetBaseObject() as Armor
		If akTarget.GetItemCount(CollarRef) == 0 ; Add existing collar if not in player inventory
			akTarget.AddItem(CollarRef)
		EndIf
	EndIf
	Devious.EquipDevice(akTarget, CollarToUse)
	LicenceMagicCollarPlayerAlias.SetWatchObject(CollarToUse)
EndFunction

Function CollarItemRemovedFromInv()
	;Debug.Messagebox("Collar object removed from inv")
	LicenceMagicCollar.CheckCollar()
EndFunction

Function CheckOrdinatior(Bool Equipped)
	If OrdinSupress
		If Game.GetModByName("Ordinator - Perks of Skyrim.esp") != 255
			Perk ORD_Alt50_IntuitiveMagic_Perk_50 = Game.GetFormFromFile(0x01B57F, "Ordinator - Perks of Skyrim.esp") as Perk ; Ordinator perks that reduce spell costs to nothing
			Perk ORD_Alt50_IntuitiveMagic_Perk_80 = Game.GetFormFromFile(0x01B580, "Ordinator - Perks of Skyrim.esp") as Perk
			
			Perk ORD_Res20_DescendingLight_Perk_20 = Game.GetFormFromFile(0x01435F, "Ordinator - Perks of Skyrim.esp") as Perk 
			
			If Equipped
				If PlayerRef.HasPerk(ORD_Alt50_IntuitiveMagic_Perk_80) || StorageUtil.GetIntValue(PlayerRef, "_SLS_OrdinatorIntuitiveMagicPerk", Missing = -1) == 2
					StorageUtil.SetIntValue(PlayerRef, "_SLS_OrdinatorIntuitiveMagicPerk", 2)
					PlayerRef.RemovePerk(ORD_Alt50_IntuitiveMagic_Perk_80)
					PlayerRef.RemovePerk(ORD_Alt50_IntuitiveMagic_Perk_50)
					
				ElseIf PlayerRef.HasPerk(ORD_Alt50_IntuitiveMagic_Perk_50) || StorageUtil.GetIntValue(PlayerRef, "_SLS_OrdinatorIntuitiveMagicPerk", Missing = -1) == 1
					StorageUtil.SetIntValue(PlayerRef, "_SLS_OrdinatorIntuitiveMagicPerk", 1)
					PlayerRef.RemovePerk(ORD_Alt50_IntuitiveMagic_Perk_50)
				
				Else
					StorageUtil.SetIntValue(PlayerRef, "_SLS_OrdinatorIntuitiveMagicPerk", 0)
				EndIf
				
				If PlayerRef.HasPerk(ORD_Res20_DescendingLight_Perk_20) || StorageUtil.GetIntValue(PlayerRef, "_SLS_OrdinatorDescendingLightPerk", Missing = -1) == 1
					StorageUtil.SetIntValue(PlayerRef, "_SLS_OrdinatorDescendingLightPerk", 1)
					PlayerRef.RemovePerk(ORD_Res20_DescendingLight_Perk_20)
				Else
					StorageUtil.SetIntValue(PlayerRef, "_SLS_OrdinatorDescendingLightPerk", 0)
				EndIf
				;Debug.Messagebox("Equipped - OrdinatorPerkLevel: " + OrdinatorPerkLevel)
			
			Else
				If StorageUtil.GetIntValue(PlayerRef, "_SLS_OrdinatorIntuitiveMagicPerk", Missing = -1) == 2
					PlayerRef.AddPerk(ORD_Alt50_IntuitiveMagic_Perk_50)
					PlayerRef.AddPerk(ORD_Alt50_IntuitiveMagic_Perk_80)
				ElseIf StorageUtil.GetIntValue(PlayerRef, "_SLS_OrdinatorIntuitiveMagicPerk", Missing = -1) == 1
					PlayerRef.AddPerk(ORD_Alt50_IntuitiveMagic_Perk_50)
				EndIf
				If StorageUtil.GetIntValue(PlayerRef, "_SLS_OrdinatorDescendingLightPerk", Missing = -1) == 1
					PlayerRef.AddPerk(ORD_Res20_DescendingLight_Perk_20)
				EndIf
				;Debug.Messagebox("UNEquipped - OrdinatorPerkLevel: " + OrdinatorPerkLevel)
			EndIf
		EndIf
	EndIf
EndFunction

Function ToggleOrdinSuppression()
	Perk ORD_Alt50_IntuitiveMagic_Perk_50 = Game.GetFormFromFile(0x01B57F, "Ordinator - Perks of Skyrim.esp") as Perk ; Ordinator perks that reduce spell costs to nothing
	Perk ORD_Alt50_IntuitiveMagic_Perk_80 = Game.GetFormFromFile(0x01B580, "Ordinator - Perks of Skyrim.esp") as Perk
	Perk ORD_Res20_DescendingLight_Perk_20 = Game.GetFormFromFile(0x01435F, "Ordinator - Perks of Skyrim.esp") as Perk 
	
	Bool IsMagicCursed = PlayerRef.HasMagicEffect(_SLS_MagicLicenceCollarMgef)
	
	If OrdinSupress
		If PlayerRef.HasPerk(ORD_Alt50_IntuitiveMagic_Perk_80) || StorageUtil.GetIntValue(PlayerRef, "_SLS_OrdinatorIntuitiveMagicPerk", Missing = -1) == 2
			StorageUtil.SetIntValue(PlayerRef, "_SLS_OrdinatorIntuitiveMagicPerk", 2)
			If IsMagicCursed
				PlayerRef.RemovePerk(ORD_Alt50_IntuitiveMagic_Perk_80)
				PlayerRef.RemovePerk(ORD_Alt50_IntuitiveMagic_Perk_50)
			EndIf
		ElseIf PlayerRef.HasPerk(ORD_Alt50_IntuitiveMagic_Perk_50) || StorageUtil.GetIntValue(PlayerRef, "_SLS_OrdinatorIntuitiveMagicPerk", Missing = -1) == 1
			StorageUtil.SetIntValue(PlayerRef, "_SLS_OrdinatorIntuitiveMagicPerk", 1)
			If IsMagicCursed
				PlayerRef.RemovePerk(ORD_Alt50_IntuitiveMagic_Perk_50)
			EndIf
		Else
			StorageUtil.SetIntValue(PlayerRef, "_SLS_OrdinatorIntuitiveMagicPerk", 0)
		EndIf
		
		If PlayerRef.HasPerk(ORD_Res20_DescendingLight_Perk_20) || StorageUtil.GetIntValue(PlayerRef, "_SLS_OrdinatorDescendingLightPerk", Missing = -1) == 1
			StorageUtil.SetIntValue(PlayerRef, "_SLS_OrdinatorDescendingLightPerk", 1)
			If IsMagicCursed
				PlayerRef.RemovePerk(ORD_Res20_DescendingLight_Perk_20)
			EndIf
		Else
			StorageUtil.SetIntValue(PlayerRef, "_SLS_OrdinatorDescendingLightPerk", 0)
		EndIf
	Else
		If StorageUtil.GetIntValue(PlayerRef, "_SLS_OrdinatorIntuitiveMagicPerk", Missing = -1) == 2
			;If !IsMagicCursed
				PlayerRef.AddPerk(ORD_Alt50_IntuitiveMagic_Perk_80)
				PlayerRef.AddPerk(ORD_Alt50_IntuitiveMagic_Perk_50)
			;EndIf
		ElseIf StorageUtil.GetIntValue(PlayerRef, "_SLS_OrdinatorIntuitiveMagicPerk", Missing = -1) == 1
			;If !IsMagicCursed
				PlayerRef.AddPerk(ORD_Alt50_IntuitiveMagic_Perk_50)
			;EndIf
		EndIf
		If StorageUtil.GetIntValue(PlayerRef, "_SLS_OrdinatorDescendingLightPerk", Missing = -1) == 1
			;If !IsMagicCursed
				PlayerRef.AddPerk(ORD_Res20_DescendingLight_Perk_20)
			;EndIf
		EndIf
	EndIf
EndFunction

Function BeginConfiscateWeapons(ObjectReference akTarget)
	ConfiscateWeapons(akTarget)
	Int i = StorageUtil.FormListCount(akTarget, "_SLS_LicenceSearchContainers")
	While i > 0
		i -= 1
		ConfiscateWeapons(StorageUtil.FormListGet(akTarget, "_SLS_LicenceSearchContainers", i) as ObjectReference)
	EndWhile
EndFunction

Function ConfiscateWeapons(ObjectReference akTarget)
	Int i = akTarget.GetNumItems()
	Form Item
	While i > 0
		i -= 1
		Item = akTarget.GetNthForm(i)
		If Item as Weapon
			If Item.HasKeyword(VendorItemWeapon) && !_SLS_LicExceptionsWeapon.HasForm(Item)
				akTarget.RemoveItem(Item, akTarget.GetItemCount(Item), abSilent = true, akOtherContainer = _SLS_LicenceConfiscationsWeapons)
			EndIf
		ElseIf Item as Ammo
			akTarget.RemoveItem(Item, akTarget.GetItemCount(Item), abSilent = true, akOtherContainer = _SLS_LicenceConfiscationsWeapons)
		EndIf
	EndWhile
EndFunction

Function BeginConfiscateArmors(ObjectReference akTarget)
	ConfiscateArmors(akTarget)
	Int i = StorageUtil.FormListCount(akTarget, "_SLS_LicenceSearchContainers")
	While i > 0
		i -= 1
		ConfiscateArmors(StorageUtil.FormListGet(akTarget, "_SLS_LicenceSearchContainers", i) as ObjectReference)
	EndWhile
EndFunction

Function ConfiscateArmors(ObjectReference akTarget)
	Int i = akTarget.GetNumItems()
	Form Item
	While i > 0
		i -= 1
		Item = akTarget.GetNthForm(i)
		If Item as Armor
			If (Item as Armor).GetWeightClass() < 2
				If Item.HasKeyword(VendorItemArmor) && !Item.HasKeyword(SexLabNoStrip) && Item.IsPlayable() && Item.GetName() != "" && !_SLS_LicExceptionsArmor.HasForm(Item)
					;If Item.HasKeyword(_SLS_BikiniArmor)
					;	akTarget.RemoveItem(Item, akTarget.GetItemCount(Item), abSilent = true, akOtherContainer = _SLS_LicenceConfiscationsBikinis)
					;Else
						akTarget.RemoveItem(Item, akTarget.GetItemCount(Item), abSilent = true, akOtherContainer = _SLS_LicenceConfiscationsArmors)
					;EndIf
				EndIf
			EndIf
		EndIf
	EndWhile
EndFunction

Function ConfiscateWornFullArmors(Actor akTarget)
	Form akBaseItem
	Int i = SlotMasks.Length
	While i > 0
		i -= 1
		akBaseItem = akTarget.GetWornForm(SlotMasks[i])
		If akBaseItem
			If (akBaseItem as Armor).GetWeightClass() < 2
				If !akBaseItem.HasKeyword(_SLS_BikiniArmor) && StorageUtil.GetIntValue(akBaseItem, "SLAroused.IsBikiniArmor", Missing = -1) <= 0 && !akBaseItem.HasKeyword(SexLabNoStrip) && akBaseItem.GetName() != "" && !akBaseItem.HasKeyword(ArmorShield) && !_SLS_LicExceptionsArmor.HasForm(akBaseItem) && !akBaseItem.HasKeyword(ArmorBoots) && !akBaseItem.HasKeyword(ArmorGauntlets) && !akBaseItem.HasKeyword(ArmorHelmet)
					akTarget.RemoveItem(akBaseItem, akTarget.GetItemCount(akBaseItem), abSilent = true, akOtherContainer = _SLS_LicenceConfiscationsArmors)
				EndIf
			EndIf
		EndIf
	EndWhile
EndFunction

Function BeginConfiscateMagicItems(ObjectReference akTarget)
	ConfiscateMagicItems(akTarget)
	Int i = StorageUtil.FormListCount(akTarget, "_SLS_LicenceSearchContainers")
	While i > 0
		i -= 1
		ConfiscateMagicItems(StorageUtil.FormListGet(akTarget, "_SLS_LicenceSearchContainers", i) as ObjectReference)
	EndWhile
EndFunction

Function ConfiscateMagicItems(ObjectReference akTarget)
	Int i = akTarget.GetNumItems()
	Form Item
	Armor akArmor
	While i > 0
		i -= 1
		Item = akTarget.GetNthForm(i)
		If Item as Armor
			akArmor = Item as Armor
			If akArmor.GetWeightClass() == 2 && akArmor.GetEnchantment() != None
				If !Item.HasKeyword(ArmorJewelry) && !Item.HasKeyword(SexLabNoStrip) && Item.IsPlayable() && Item.GetName() != "" && !_SLS_LicExceptionsArmor.HasForm(Item)
					akTarget.RemoveItem(Item, akTarget.GetItemCount(Item), abSilent = true, akOtherContainer = _SLS_LicenceConfiscationsMagic)
				EndIf
			EndIf
			
		ElseIf Item as Weapon
			If Item.HasKeyword(VendorItemStaff)
				akTarget.RemoveItem(Item, akTarget.GetItemCount(Item), abSilent = true, akOtherContainer = _SLS_LicenceConfiscationsMagic)
			EndIf
		
		ElseIf Item as Book
			If Item.HasKeyword(VendorItemSpellTome)
				akTarget.RemoveItem(Item, akTarget.GetItemCount(Item), abSilent = true, akOtherContainer = _SLS_LicenceConfiscationsMagic)
			EndIf
			
		ElseIf Item as Scroll
			akTarget.RemoveItem(Item, akTarget.GetItemCount(Item), abSilent = true, akOtherContainer = _SLS_LicenceConfiscationsMagic)
		EndIf
	EndWhile
EndFunction

Function BeginConfiscateNonBikiniArmors(ObjectReference akTarget)
	ConfiscateNonBikiniArmors(akTarget)
	Int i = StorageUtil.FormListCount(akTarget, "_SLS_LicenceSearchContainers")
	While i > 0
		i -= 1
		ConfiscateNonBikiniArmors(StorageUtil.FormListGet(akTarget, "_SLS_LicenceSearchContainers", i) as ObjectReference)
	EndWhile
EndFunction

Function ConfiscateNonBikiniArmors(ObjectReference akTarget)
	Int i = akTarget.GetNumItems()
	Form Item
	While i > 0
		i -= 1
		Item = akTarget.GetNthForm(i)
		If Item as Armor
			If (Item as Armor).GetWeightClass() < 2
				If Item.HasKeyword(VendorItemArmor) && !Item.HasKeyword(SexLabNoStrip) && Item.IsPlayable() && Item.GetName() != "" && !_SLS_LicExceptionsArmor.HasForm(Item)
					If !Item.HasKeyword(_SLS_BikiniArmor) && StorageUtil.GetIntValue(Item, "SLAroused.IsBikiniArmor", Missing = -1) <= 0
						akTarget.RemoveItem(Item, akTarget.GetItemCount(Item), abSilent = true, akOtherContainer = _SLS_LicenceConfiscationsArmors)
					EndIf
				EndIf
			EndIf
		EndIf
	EndWhile
EndFunction

Function BeginConfiscateClothes(ObjectReference akTarget)
	ConfiscateClothes(akTarget)
	Int i = StorageUtil.FormListCount(akTarget, "_SLS_LicenceSearchContainers")
	While i > 0
		i -= 1
		ConfiscateClothes(StorageUtil.FormListGet(akTarget, "_SLS_LicenceSearchContainers", i) as ObjectReference)
	EndWhile
EndFunction

Function ConfiscateClothes(ObjectReference akTarget)
	Int i = akTarget.GetNumItems()
	Form Item
	While i > 0
		i -= 1
		Item = akTarget.GetNthForm(i)
		If Item as Armor
			If (Item as Armor).GetWeightClass() == 2
				If Item.HasKeyword(VendorItemClothing) && !Item.HasKeyword(SexLabNoStrip) && Item.IsPlayable() && Item.GetName() != "" && !_SLS_LicExceptionsArmor.HasForm(Item)
					akTarget.RemoveItem(Item, akTarget.GetItemCount(Item), abSilent = true, akOtherContainer = _SLS_LicenceConfiscationsClothes)
				EndIf
			EndIf
		EndIf
	EndWhile
EndFunction

Function GateCheckLicenceExpiredRemove(Actor Inspector = None)
;/
	Int i = _SLS_LicenceListAll.GetSize()
	ObjectReference LicenceSelect
	Float DaysPassed = Math.Ceiling(Utility.GetCurrentGameTime())
	Bool Invalid = false
	While i > 0
		i -= 1
		LicenceSelect = _SLS_LicenceListAll.GetAt(i) as ObjectReference
		If StorageUtil.GetFloatValue(LicenceSelect, "_SLS_LicenceExpiry", -1.0) - DaysPassed <= 0
			PlayerRef.RemoveItem(LicenceSelect, 1, abSilent = true, akOtherContainer = _SLS_LicenceDumpRef)
			Invalid = true
		EndIf
	EndWhile
	If Inspector
		Debug.Notification(Inspector.GetBaseObject().GetName() + " tears up your expired licence")
	EndIf
/;
	
	Float DaysPassed = Math.Ceiling(Utility.GetCurrentGameTime())
	ObjectReference LicenceSelect
	Int i = 0
	While i < LicTypesString.Length
		Int j = StorageUtil.FormListCount(None, "_SLS_LicenceList" + LicTypesString[i])
		While j > 0
			j -= 1
			LicenceSelect = StorageUtil.FormListGet(None, "_SLS_LicenceList" + LicTypesString[i], j) as ObjectReference
			If LicenceSelect
				If StorageUtil.GetFloatValue(LicenceSelect, "_SLS_LicenceExpiry", -1.0) - DaysPassed <= 0
					StorageUtil.FormListRemove(None, "_SLS_LicenceList" + LicTypesString[i], LicenceSelect, AllInstances = true)
					PlayerRef.RemoveItem(LicenceSelect, 1, abSilent = true, akOtherContainer = _SLS_LicenceDumpRef)
					LicenceSelect.Disable()
					LicenceSelect.Delete()
				EndIf
			Else
				Debug.Trace("_SLS_: GateCheckLicenceExpiredRemove(): Removing None from licence list")
				StorageUtil.FormListRemove(None, "_SLS_LicenceList" + LicTypesString[i], None, AllInstances = true)
			EndIf
		EndWhile
		i += 1
	EndWhile
	If Inspector
		Debug.Notification(Inspector.GetBaseObject().GetName() + " tears up your expired licence")
	EndIf
EndFunction

Function UpdateLicenceCosts()
	Float Discount
	If BuyLicenceType == 0 ; Magic
		Discount = GetLicenceDiscountMagic()
		_SLS_LicCostShort.SetValueInt(LicCostMagicShort - (Math.Floor(LicCostMagicShort * Discount)))
		_SLS_LicCostLong.SetValueInt(LicCostMagicLong - (Math.Floor(LicCostMagicLong * Discount)))
		_SLS_LicCostPer.SetValueInt(LicCostMagicPer - (Math.Floor(LicCostMagicPer * Discount)))
		
	ElseIf BuyLicenceType == 1 ; Weapons
		Discount = GetLicenceDiscountWeapons()
		_SLS_LicCostShort.SetValueInt(LicCostWeaponShort - (Math.Floor(LicCostWeaponShort * Discount)))
		_SLS_LicCostLong.SetValueInt(LicCostWeaponLong - (Math.Floor(LicCostWeaponLong * Discount)))
		_SLS_LicCostPer.SetValueInt(LicCostWeaponPer - (Math.Floor(LicCostWeaponPer * Discount)))
		
	ElseIf BuyLicenceType == 2 ; Armor
		Discount = GetLicenceDiscountArmor()
		_SLS_LicCostShort.SetValueInt(LicCostArmorShort - (Math.Floor(LicCostArmorShort * Discount)))
		_SLS_LicCostLong.SetValueInt(LicCostArmorLong - (Math.Floor(LicCostArmorLong * Discount)))
		_SLS_LicCostPer.SetValueInt(LicCostArmorPer - (Math.Floor(LicCostArmorPer * Discount)))

	ElseIf BuyLicenceType == 3 ; Bikini
		Discount = GetLicenceDiscountArmor()
		_SLS_LicCostShort.SetValueInt(LicCostBikiniShort - (Math.Floor(LicCostBikiniShort * Discount)))
		_SLS_LicCostLong.SetValueInt(LicCostBikiniLong - (Math.Floor(LicCostBikiniLong * Discount)))
		_SLS_LicCostPer.SetValueInt(LicCostBikiniPer - (Math.Floor(LicCostBikiniPer * Discount)))
		
	ElseIf BuyLicenceType == 4 ; Clothes
		_SLS_LicCostShort.SetValueInt(LicCostClothesShort)
		_SLS_LicCostLong.SetValueInt(LicCostClothesLong)
		_SLS_LicCostPer.SetValueInt(LicCostClothesPer)
		
	ElseIf BuyLicenceType == 5 ; Curfew
		_SLS_LicCostShort.SetValueInt(LicCostCurfewShort)
		_SLS_LicCostLong.SetValueInt(LicCostCurfewLong)
		_SLS_LicCostPer.SetValueInt(LicCostCurfewPer)
	
	ElseIf BuyLicenceType == 6 ; Whore
		_SLS_LicCostShort.SetValueInt(LicCostWhoreShort)
		_SLS_LicCostLong.SetValueInt(LicCostWhoreLong)
		_SLS_LicCostPer.SetValueInt(LicCostWhorePer)
		
	ElseIf BuyLicenceType == 7 ; Freedom
		_SLS_LicCostShort.SetValueInt(LicCostFreedomShort)
		_SLS_LicCostLong.SetValueInt(LicCostFreedomLong)
		_SLS_LicCostPer.SetValueInt(LicCostFreedomPer)
		
	ElseIf BuyLicenceType == 8 ; Property
		_SLS_LicCostShort.SetValueInt(LicCostPropertyShort)
		_SLS_LicCostLong.SetValueInt(LicCostPropertyLong)
		_SLS_LicCostPer.SetValueInt(LicCostPropertyPer)
	EndIf

	UpdateCurrentInstanceGlobal(_SLS_LicCostShort)
	UpdateCurrentInstanceGlobal(_SLS_LicCostLong)
	UpdateCurrentInstanceGlobal(_SLS_LicCostPer)
EndFunction

Function SetLicenceRequestType(Int RequestType)
	RequestedContainerHasItems = false
	If RequestType == 0 ; Magic
		BuyLicenceType = 0
		RecoveryRequest = 4
		If _SLS_LicenceConfiscationsMagic.GetNumItems() > 0
			RequestedContainerHasItems = true
		EndIf
		
	ElseIf RequestType == 1 ; Weapon
		BuyLicenceType = 1
		RecoveryRequest = 1
		If _SLS_LicenceConfiscationsWeapons.GetNumItems() > 0
			RequestedContainerHasItems = true
		EndIf
		
	ElseIf RequestType == 2 ; Armor
		BuyLicenceType = 2
		RecoveryRequest = 0
		If _SLS_LicenceConfiscationsArmors.GetNumItems() > 0
			RequestedContainerHasItems = true
		EndIf
		
	ElseIf RequestType == 3 ; Bikini
		BuyLicenceType = 3
		RecoveryRequest = 2
		If _SLS_LicenceConfiscationsArmors.GetNumItems() > 0
			RequestedContainerHasItems = true
		EndIf
		
	ElseIf RequestType == 4 ; Clothes
		BuyLicenceType = 4
		RecoveryRequest = 3
		If _SLS_LicenceConfiscationsClothes.GetNumItems() > 0
			RequestedContainerHasItems = true
		EndIf
		
	ElseIf RequestType == 5 ; Curfew
		BuyLicenceType = 5
		RecoveryRequest = -1
		RequestedContainerHasItems = false
		
	ElseIf RequestType == 6 ; Whore
		BuyLicenceType = 6
		RecoveryRequest = -1
		RequestedContainerHasItems = false
		
	ElseIf RequestType == 7 ; Freedom
		BuyLicenceType = 7
		RecoveryRequest = -1
		RequestedContainerHasItems = false
		
	ElseIf RequestType == 8 ; Property
		BuyLicenceType = 8
		RecoveryRequest = -1
		RequestedContainerHasItems = false
	EndIf
	UpdateLicenceCosts()
EndFunction

Function RecoverObjects(Actor akSpeaker)
	If RecoveryRequest >= 0
		ObjectReference Chest
		Faction ShopFaction
		
		If RecoveryRequest == 0
			Chest = _SLS_LicenceConfiscationsArmors
			ShopFaction = _SLS_LicQuartermasterArmorFaction
		ElseIf RecoveryRequest == 1
			Chest = _SLS_LicenceConfiscationsWeapons
			ShopFaction = _SLS_LicQuartermasterWeaponsFaction
		ElseIf RecoveryRequest == 2
			Chest = _SLS_LicenceConfiscationsArmors
			ShopFaction = _SLS_LicQuartermasterArmorFaction
		ElseIf RecoveryRequest == 3
			Chest = _SLS_LicenceConfiscationsClothes
			ShopFaction = _SLS_LicQuartermasterClothesFaction
		ElseIf RecoveryRequest == 4
			Chest = _SLS_LicenceConfiscationsMagic
			ShopFaction = _SLS_LicQuartermasterMagicFaction
		EndIf
		If BuyBack
			_SLS_LicBuyBackQuest.Start()
			Chest.RemoveAllItems(akTransferTo = _SLS_LicenceConfiscationsShopChest, abKeepOwnership = true, abRemoveQuestItems = true)
			;Utility.WaitMenuMode(5.0)
			(_SLS_LicBuyBackQuest.GetNthAlias(1) as ReferenceAlias).ForceRefTo(Chest)
			ModBuyBackDiscountPerk(AddPerkToPlayer = true)
			
			;akSpeaker.AddToFaction(ShopFaction)
			;Utility.WaitMenuMode(1.0)
			akSpeaker.ShowBarterMenu()
			;Utility.WaitMenuMode(1.5)
			;Debug.Messagebox("Faction: " + ShopFaction + "\nIsIn: " + akSpeaker.IsInFaction(ShopFaction))
			;akSpeaker.RemoveFromFaction(ShopFaction)
		Else
			Chest.Activate(PlayerRef)
		EndIf
	EndIf
EndFunction

Function BuildBuyBackPerkArray()
	BuyBackPerks = new Perk[5]
	BuyBackPerks[0] = Game.GetFormFromFile(0x085BA5, "SL Survival.esp") as Perk
	BuyBackPerks[1] = Game.GetFormFromFile(0x085BA4, "SL Survival.esp") as Perk
	BuyBackPerks[2] = Game.GetFormFromFile(0x085BA3, "SL Survival.esp") as Perk
	BuyBackPerks[3] = Game.GetFormFromFile(0x085BA2, "SL Survival.esp") as Perk
	BuyBackPerks[4] = Game.GetFormFromFile(0x085BA1, "SL Survival.esp") as Perk
EndFunction

Function ModBuyBackDiscountPerk(Bool AddPerkToPlayer)
	; Buy prices seem to be limited to minimum 25%. Tried various settings for game settings fBarterBuyMin and fBarterMin but nothing seems to work. 

	;Debug.Messagebox("fBarterBuyMin: " + Game.GetGameSettingFloat("fBarterBuyMin"))
	If Menu.BuyBackPrice != 5
		Perk akPerk = BuyBackPerks[Menu.BuyBackPrice]
		If AddPerkToPlayer
			;fBarterBuyMin = Game.GetGameSettingFloat("fBarterBuyMin")
			;Game.SetGameSettingFloat("fBarterBuyMin", 0.5)
			;Game.SetGameSettingFloat("fBarterMin", 0.5)
			
			PlayerRef.AddPerk(akPerk)
		Else
			;Game.SetGameSettingFloat("fBarterBuyMin", fBarterBuyMin)
			PlayerRef.RemovePerk(akPerk)
		EndIf
	EndIf
EndFunction

Function CheckForFines(Actor akSpeaker)
	Int Bounty
	Faction CrimeFaction = akSpeaker.GetCrimeFaction()
	Bounty += CrimeFaction.GetCrimeGold()
	If Init.PscInstalled
		If CrimeFaction == CrimeFactionWhiterun
			Bounty += Psc.GetPscBountyWhiterun()
		ElseIf CrimeFaction == CrimeFactionHaafingar
			Bounty += Psc.GetPscBountySolitude()
		ElseIf CrimeFaction == CrimeFactionRift
			Bounty += Psc.GetPscBountyRiften()
		ElseIf CrimeFaction == CrimeFactionEastmarch
			Bounty += Psc.GetPscBountyWindhelm()
		ElseIf CrimeFaction == CrimeFactionReach
			Bounty += Psc.GetPscBountyMarkarth()
		Else
			Debug.Trace("_SLS_: CheckForFines: Crime faction not found for: " + akSpeaker)
		EndIf
	EndIf
	If Bounty > 0
		HasOutstandingFines = true
	Else
		HasOutstandingFines = false
	EndIf
EndFunction

Function DoLicenceExpiryMessagebox()
	String ExpSt = "Licence expiry details\n\n"
	Float GameTime = Utility.GetCurrentGameTime()
	
	Float Expiry = NextMagicExpiry
	If Expiry > GameTime
		ExpSt += LicenceExpiryNotify("magic ", Expiry) + "\n"
	EndIf
	
	Expiry = NextWeaponExpiry
	If Expiry > GameTime
		ExpSt += LicenceExpiryNotify("weapon ", Expiry) + "\n"
	EndIf
	
	Expiry = NextArmorExpiry
	If Expiry > GameTime
		ExpSt += LicenceExpiryNotify("armor ", Expiry) + "\n"
	EndIf
	
	Expiry = NextBikiniExpiry
	If Expiry > GameTime
		ExpSt += LicenceExpiryNotify("bikini ", Expiry) + "\n"
	EndIf
	
	Expiry = NextClothesExpiry
	If Expiry > GameTime
		ExpSt += LicenceExpiryNotify("clothes ", Expiry) + "\n"
	EndIf
	
	Expiry = NextCurfewExpiry
	If Expiry > GameTime
		ExpSt += LicenceExpiryNotify("curfew ", Expiry) + "\n"
	EndIf
	
	Expiry = NextWhoreExpiry
	If Expiry > GameTime
		ExpSt += LicenceExpiryNotify("whore ", Expiry) + "\n"
	EndIf
	
	Expiry = NextFreedomExpiry
	If Expiry > GameTime
		ExpSt += LicenceExpiryNotify("freedom ", Expiry) + "\n"
	EndIf
	
	Expiry = NextPropertyExpiry
	If Expiry > GameTime
		ExpSt += LicenceExpiryNotify("property ", Expiry) + "\n"
	EndIf
	
	If ExpSt != "Licence expiry details\n\n"
		Debug.Messagebox(ExpSt)
	EndIf
EndFunction

Function EquipMandatoryRestaints()
	Devious.EquipMandatoryRestaints(MandatoryRestraints)
	If NeedsMandGag
		EquipMandatoryGag()
	EndIf
EndFunction

Function RemoveMandatoryRestraints(Actor akSpeaker)
	Devious.RemoveMandatoryRestraints(MandatoryRestraints)
	RemoveMandatoryGag(akSpeaker)
EndFunction

Function TollGuardTossOut(ObjectReference akSpeaker)
	ReferenceAlias TollDoor = (akSpeaker as SLS_TollGuard).AssociatedDoor
	(TollDoor.GetReference() as ObjectReference).Activate(PlayerRef)
EndFunction

;/
Function DumbFollowerEnforceActor(Actor Follower, ObjectReference akDestContainer, Bool Notify)
	Int ItemCount = Follower.GetNumItems()
	Int i = ItemCount
	Form Item
	While i > 0
		i -= 1
		Item = Follower.GetNthForm(i)
		If Item as Armor
			If !Item.HasKeyword(SexLabNoStrip)
				If (Item as Armor).GetWeightClass() < 2 ; Armor
					If Item.HasKeyword(_SLS_BikiniArmor) && !(HasValidArmorLicence || HasValidBikiniLicence) ; Bikini
						;If !Follower.IsEquipped(Item)
							Follower.RemoveItem(Item, Follower.GetItemCount(Item), false, akDestContainer)
						;ElseIf Follower.GetItemCount(Item) > 1
						;	Follower.RemoveItem(Item, Follower.GetItemCount(Item) - 1, false, akDestContainer)
						;EndIf
						
					ElseIf !HasValidArmorLicence ; Armor
						;If !Follower.IsEquipped(Item)
							Follower.RemoveItem(Item, Follower.GetItemCount(Item), false, akDestContainer)
						;ElseIf Follower.GetItemCount(Item) > 1
						;	Follower.RemoveItem(Item, Follower.GetItemCount(Item) - 1, false, akDestContainer)
						;EndIf
					EndIf
					
				Else ; Clothes
					; Complicated
				EndIf
			EndIf
			
		ElseIf Item as Weapon && !HasValidWeaponLicence
			;If !Follower.IsEquipped(Item)
				Follower.RemoveItem(Item, Follower.GetItemCount(Item), false, akDestContainer)
			;ElseIf Follower.GetItemCount(Item) > 1
			;	Follower.RemoveItem(Item, Follower.GetItemCount(Item) - 1, false, akDestContainer)
			;EndIf
			
		ElseIf Item as Book
			If Item.HasKeyword(VendorItemSpellTome)
				Follower.RemoveItem(Item, Follower.GetItemCount(Item), false, akDestContainer)
			EndIf
		EndIf
	EndWhile
	If Notify
		If ItemCount != Follower.GetNumItems()
			Debug.Notification(Follower.GetBaseObject().GetName() + ": I'm not carrying your contraband")
		EndIf
	EndIf
EndFunction
/;

Function DumbFollowerEnforceObjRef(ObjectReference Follower, Actor CrosshairRef, ObjectReference akDestContainer, Bool Notify)
	Actor FollowerActor = Follower as Actor
	Bool DidGiveContraband = false
	Int ItemCount
	Int i = Follower.GetNumItems()
	Form Item
	While i > 0
		i -= 1
		Item = Follower.GetNthForm(i)
		If Item as Armor
			If !Item.HasKeyword(SexLabNoStrip) && !_SLS_LicExceptionsArmor.HasForm(Item) && Item.GetName() != "" && Item.IsPlayable()
				If (Item as Armor).GetWeightClass() < 2 ; Armor
					If ;/Item.HasKeyword(_SLS_BikiniArmor) &&/; !(HasValidArmorLicence || HasValidBikiniLicence) ; Bikini
						ItemCount = Follower.GetItemCount(Item)
						If !FollowerActor.IsEquipped(Item)
							Follower.RemoveItem(Item, ItemCount, false, akDestContainer)
							DidGiveContraband = true
						Else
							If ItemCount > 1
								Follower.RemoveItem(Item, ItemCount - 1, false, akDestContainer)
								DidGiveContraband = true
							EndIf
						EndIf
						
					;ElseIf !HasValidArmorLicence ; Armor
					;	ItemCount = Follower.GetItemCount(Item)
					;	If !FollowerActor.IsEquipped(Item)
					;		Follower.RemoveItem(Item, ItemCount, false, akDestContainer)
					;		DidGiveContraband = true
					;	Else
					;		If ItemCount > 1
					;			Follower.RemoveItem(Item, ItemCount - 1, false, akDestContainer)
					;			DidGiveContraband = true
					;		EndIf
					;	EndIf
					EndIf
					
				Else ; Clothes
					; Complicated
				EndIf
			EndIf
			
		ElseIf (Item as Weapon || Item as Ammo)
			If !HasValidWeaponLicence && !_SLS_LicExceptionsWeapon.HasForm(Item) && !Item.HasKeyword(VendorItemStaff) ; Weapons
				ItemCount = Follower.GetItemCount(Item)
				If !FollowerActor.IsEquipped(Item)
					Follower.RemoveItem(Item, ItemCount, false, akDestContainer)
					DidGiveContraband = true
				Else
					If ItemCount > 1
						Follower.RemoveItem(Item, ItemCount - 1, false, akDestContainer)
						DidGiveContraband = true
					EndIf
				EndIf
			
			ElseIf !HasValidMagicLicence && Item.HasKeyword(VendorItemStaff) ; Staves
				ItemCount = Follower.GetItemCount(Item)
				If !FollowerActor.IsEquipped(Item)
					Follower.RemoveItem(Item, ItemCount, false, akDestContainer)
					DidGiveContraband = true
				Else
					If ItemCount > 1
						Follower.RemoveItem(Item, ItemCount - 1, false, akDestContainer)
						DidGiveContraband = true
					EndIf
				EndIf
			EndIf
			
		ElseIf Item as Book
			If Item.HasKeyword(VendorItemSpellTome) && !HasValidMagicLicence
				Follower.RemoveItem(Item, Follower.GetItemCount(Item), false, akDestContainer)
				DidGiveContraband = true
			EndIf
			
		ElseIf Item as Scroll && !HasValidMagicLicence
			Follower.RemoveItem(Item, Follower.GetItemCount(Item), false, akDestContainer)
			DidGiveContraband = true
			
		ElseIf Item as Key
			If FollowerWontCarryKeys
				Follower.RemoveItem(Item, Follower.GetItemCount(Item), false, akDestContainer)
			EndIf
		EndIf
	EndWhile
	
	If Notify && CrosshairRef
		If DidGiveContraband
			Debug.Notification(CrosshairRef.GetBaseObject().GetName() + ": I'm not carrying your contraband")
		EndIf
		
		; Is follower naked?
		Follower.AddItem(_SLS_DummyObject, 1)
		FollowerActor.EquipItem(_SLS_DummyObject)
		Follower.RemoveItem(_SLS_DummyObject)
		If _SLS_FollowerNakedClothesLockQuest.IsRunning()
			ReferenceAlias AliasSelect = _SLS_FollowerNakedClothesLockQuest.GetNthAlias(0) as ReferenceAlias
			If AliasSelect.GetReference() == Follower
				(AliasSelect as _SLS_FollowerNakedClothesLock).DoClothesCheck()
			EndIf
			
		Else
			If FollowerActor.GetWornForm(0x00000004) == None
				_SLS_FollowerNakedFgQuest.Start()
				NakedFollower.ForceRefTo(Follower)
				FollowerActor.EvaluatePackage()
			EndIf
		EndIf
	EndIf
EndFunction

Function ProcFollowerClothes()
	ObjectReference Follower
	If Game.GetModByName("EFFCore.esm") != 255
		Formlist FollowerList = Game.GetFormFromFile(0x000F53, "EFFCore.esm") as Formlist
		Int i = FollowerList.GetSize()
		While i > 0
			i -= 1
			Follower = FollowerList.GetAt(i) as ObjectReference
			;Debug.Messagebox("Follower: " + Follower)
			If Follower
				ScanForClothes(Follower)
			EndIf
		EndWhile
	Else
		Int i = DialogueFollower.GetNumAliases()
		While i > 0
			i -= 1
			Follower = (DialogueFollower.GetNthAlias(i) as ReferenceAlias).GetReference()
			If Follower
				ScanForClothes(Follower)
			EndIf
		EndWhile
	EndIf
EndFunction

Function ScanForClothes(ObjectReference Follower)
	Int i = Follower.GetNumItems()
	Form Item
	While i > 0
		i -= 1
		Item = Follower.GetNthForm(i)
		If Item as Armor
			If !Item.HasKeyword(SexLabNoStrip) && Item.GetName() != "" && Item.IsPlayable()
				If (Item as Armor).GetWeightClass() == 2 ; Armor
					Follower.RemoveItem(Item, Follower.GetItemCount(Item), true, _SLS_LicenceConfiscationsClothes)
				EndIf
			EndIf
		EndIf
	EndWhile
EndFunction

ObjectReference UnhappyNakedFollower
Function ProcAllFollowers(Bool MustBeLoaded)
	If CheckFollowers
		UnhappyNakedFollower = None
		ObjectReference Follower
		If Game.GetModByName("EFFCore.esm") != 255
			Formlist FollowerList = Game.GetFormFromFile(0x000F53, "EFFCore.esm") as Formlist
			Int i = FollowerList.GetSize()
			While i > 0
				i -= 1
				Follower = FollowerList.GetAt(i) as ObjectReference
				If Follower && (StorageUtil.GetIntValue(Follower, "DF_FollowerMaster") < 0 || ForceCheckDF)
					If !MustBeLoaded || (MustBeLoaded && Follower.Is3dLoaded())
						ConfiscateFollowerAllLics(Follower)

						ObjectReference EffInv = Eff.GetEffInv(Follower)
						If EffInv
							ConfiscateFollowerAllLics(Follower)
						EndIf
					EndIf
				EndIf
			EndWhile
			UnhappyNakedFollower = Follower
			
		Else
			Int i = DialogueFollower.GetNumAliases()
			While i > 0
				i -= 1
				Follower = (DialogueFollower.GetNthAlias(i) as ReferenceAlias).GetReference() as ObjectReference
				If Follower && (StorageUtil.GetIntValue(Follower, "DF_FollowerMaster") < 0 || ForceCheckDF)
					ConfiscateFollowerAllLics(Follower)
					UnhappyNakedFollower = Follower
				EndIf
			EndWhile
		EndIf
		
		Utility.Wait(1.0)
		If UnhappyNakedFollower && FolTakeClothes
			If (UnhappyNakedFollower as Actor).GetWornForm(0x00000004) == None
				If !HasBodyClothes(UnhappyNakedFollower)
					If HasBodyClothes(PlayerRef)
						RegisterForMenu("Dialogue Menu")
					EndIf
				EndIf
			EndIf
		EndIf
	EndIf
EndFunction

Event OnMenuClose(String MenuName)
	If UnhappyNakedFollower
		;Debug.Messagebox("Doing it")
		;While _SLS_LicenceForceGreetQuest.IsRunning()
		;	Utility.Wait(1.0)
		;EndWhile
		Utility.Wait(1.0)
		_SLS_FollowerNakedFgQuest.Start()
		NakedFollower.ForceRefTo(UnhappyNakedFollower)
		(UnhappyNakedFollower as Actor).EvaluatePackage()
		UnRegisterForMenu("Dialogue Menu")
	EndIf
EndEvent

Function ConfiscateFollowerAllLics(ObjectReference Follower)
	If FollowerLicStyle == 0
		ConfiscateFollowerPlayerLicenceStyle(Follower)
	Else
		ConfiscateFollowerPartyLicenceStyle(Follower)
	EndIf
EndFunction

Function ConfiscateFollowerPlayerLicenceStyle(ObjectReference Follower)
	Actor FollowerActor = Follower as Actor
	Int ItemCount 
	Int i = Follower.GetNumItems()
	Form Item
	If Game.GetModByName("EFFCore.esm") == 255
		Outfit FollowerOutfit = FollowerActor.GetActorBase().GetOutfit()
		If FollowerOutfit != _SLS_DummyOutfit
			;Utility.Wait(3.0)
			(Follower as Actor).SetOutfit(_SLS_DummyOutfit)
			DoOutfitSetup(FollowerActor, FollowerOutfit)
			Utility.Wait(0.5)
		EndIf
	EndIf
	;DoOutfitSetup(Follower as Actor)
	While i > 0
		i -= 1
		Item = Follower.GetNthForm(i)
		If Item as Armor
			If !Item.HasKeyword(SexLabNoStrip) && !_SLS_LicExceptionsArmor.HasForm(Item) && Item.IsPlayable() && Item.GetName() != ""
				If (Item as Armor).GetWeightClass() < 2 ; Armors
					If !HasValidArmorLicence && !HasValidBikiniLicence; Armor
						ItemCount = Follower.GetItemCount(Item)
						If !FollowerActor.IsEquipped(Item)
							Follower.RemoveItem(Item, Follower.GetItemCount(Item), false, _SLS_LicenceConfiscationsArmors)
						Else
							If ItemCount > 1
								Follower.RemoveItem(Item, ItemCount - 1, false, _SLS_LicenceConfiscationsArmors)
							EndIf
						EndIf
						;Debug.Messagebox("Removing: " + Item + " - Armor")
					EndIf
					
					
				Else ; Clothes
					If !HasValidClothesLicence
						If LicClothesEnable == 1 ; Always
							ItemCount = Follower.GetItemCount(Item)
							If !FollowerActor.IsEquipped(Item)
								Follower.RemoveItem(Item, ItemCount, false, _SLS_LicenceConfiscationsClothes)
							Else
								If ItemCount > 1
									Follower.RemoveItem(Item, ItemCount - 1, false, _SLS_LicenceConfiscationsClothes)
								EndIf
							EndIf
							
						ElseIf LicClothesEnable == 2 ; Slaverun
							If !ActIsInSlaverunFreeTown
								ItemCount = Follower.GetItemCount(Item)
								If !FollowerActor.IsEquipped(Item)
									Follower.RemoveItem(Item, ItemCount, false, _SLS_LicenceConfiscationsClothes)
								Else
									Follower.RemoveItem(Item, ItemCount - 1, false, _SLS_LicenceConfiscationsClothes)
								EndIf
								;Debug.Messagebox("Removing: " + Item + " - Slaverun")
							EndIf
						EndIf
					EndIf
				EndIf
			EndIf
			
		ElseIf (Item as Weapon || Item as Ammo)
			If !HasValidWeaponLicence && !_SLS_LicExceptionsWeapon.HasForm(Item) && !Item.HasKeyword(VendorItemStaff) ; Weapons
				ItemCount = Follower.GetItemCount(Item)
				If !FollowerActor.IsEquipped(Item)
					Follower.RemoveItem(Item, ItemCount, false, _SLS_LicenceConfiscationsWeapons)
				Else
					Follower.RemoveItem(Item, ItemCount - 1, false, _SLS_LicenceConfiscationsWeapons)
				EndIf
				
			ElseIf !HasValidMagicLicence && Item.HasKeyword(VendorItemStaff) ; Staves
				ItemCount = Follower.GetItemCount(Item)
				If !FollowerActor.IsEquipped(Item)
					Follower.RemoveItem(Item, ItemCount, false, _SLS_LicenceConfiscationsMagic)
				Else
					Follower.RemoveItem(Item, ItemCount - 1, false, _SLS_LicenceConfiscationsMagic)
				EndIf
			EndIf
			
		ElseIf Item as Book
			If Item.HasKeyword(VendorItemSpellTome) && !HasValidMagicLicence
				Follower.RemoveItem(Item, Follower.GetItemCount(Item), false, _SLS_LicenceConfiscationsMagic)
			EndIf
		
		ElseIf Item as Scroll && !HasValidMagicLicence
			Follower.RemoveItem(Item, Follower.GetItemCount(Item), false, _SLS_LicenceConfiscationsMagic)
		EndIf
	EndWhile
EndFunction

Function ConfiscateFollowerPartyLicenceStyle(ObjectReference Follower)
	Actor FollowerActor = Follower as Actor
	Int ItemCount 
	Int i = Follower.GetNumItems()
	Form Item
	If Game.GetModByName("EFFCore.esm") == 255
		Outfit FollowerOutfit = FollowerActor.GetActorBase().GetOutfit()
		If FollowerOutfit != _SLS_DummyOutfit
			;Utility.Wait(3.0)
			(Follower as Actor).SetOutfit(_SLS_DummyOutfit)
			DoOutfitSetup(FollowerActor, FollowerOutfit)
			Utility.Wait(0.5)
		EndIf
	EndIf
	;DoOutfitSetup(Follower as Actor)
	While i > 0
		i -= 1
		Item = Follower.GetNthForm(i)
		If Item as Armor
			If !Item.HasKeyword(SexLabNoStrip) && !_SLS_LicExceptionsArmor.HasForm(Item) && Item.IsPlayable() && Item.GetName() != ""
				If (Item as Armor).GetWeightClass() < 2 ; Armors
					If !HasValidArmorLicence && !HasValidBikiniLicence; Armor
						Follower.RemoveItem(Item, Follower.GetItemCount(Item), false, _SLS_LicenceConfiscationsArmors)
						;Debug.Messagebox("Removing: " + Item + " - Armor")
					EndIf
					
					
				Else ; Clothes
					If !HasValidClothesLicence
						If LicClothesEnable == 1 ; Always
							Follower.RemoveItem(Item, Follower.GetItemCount(Item), false, _SLS_LicenceConfiscationsClothes)
							
						ElseIf LicClothesEnable == 2 ; Slaverun
							If !ActIsInSlaverunFreeTown
								Follower.RemoveItem(Item, Follower.GetItemCount(Item), false, _SLS_LicenceConfiscationsClothes)
								;Debug.Messagebox("Removing: " + Item + " - Slaverun")
							EndIf
						EndIf
					EndIf
				EndIf
			EndIf
			
		ElseIf (Item as Weapon || Item as Ammo)
			If !HasValidWeaponLicence && !_SLS_LicExceptionsWeapon.HasForm(Item) && !Item.HasKeyword(VendorItemStaff) ; Weapons
				Follower.RemoveItem(Item, Follower.GetItemCount(Item), false, _SLS_LicenceConfiscationsWeapons)
				
			ElseIf !HasValidMagicLicence && Item.HasKeyword(VendorItemStaff) ; Staves
				Follower.RemoveItem(Item, Follower.GetItemCount(Item), false, _SLS_LicenceConfiscationsMagic)
			EndIf
			
		ElseIf Item as Book
			If Item.HasKeyword(VendorItemSpellTome) && !HasValidMagicLicence
				Follower.RemoveItem(Item, Follower.GetItemCount(Item), false, _SLS_LicenceConfiscationsMagic)
			EndIf
		
		ElseIf Item as Scroll && !HasValidMagicLicence
			Follower.RemoveItem(Item, Follower.GetItemCount(Item), false, _SLS_LicenceConfiscationsMagic)
		EndIf
	EndWhile
EndFunction

Function DoOutfitSetup(Actor Follower, Outfit FollowerOutfit)
	Form Item
	Int i = FollowerOutfit.GetNumParts()
	While i > 0
		i -= 1
		Item = FollowerOutfit.GetNthPart(i)
		Follower.AddItem(Item, 1)
		;Debug.Messagebox(Item + "\nCount: " + Follower.GetItemCount(Item))
	EndWhile
	Follower.AddItem(_SLS_DummyObject, 1)
	Follower.EquipItem(_SLS_DummyObject)
	Follower.RemoveItem(_SLS_DummyObject)
	Utility.Wait(1.0)
EndFunction

Form Function HasBodyClothes(ObjectReference akTarget)
	Int i = akTarget.GetNumItems()
	Form Item
	Armor ItemAsArmor
	While i > 0
		i -= 1
		Item = akTarget.GetNthForm(i)
		ItemAsArmor = Item as Armor
		If ItemAsArmor
			If ItemAsArmor.GetWeightClass() == 2
				If !Item.HasKeyword(SexLabNoStrip) && Item.GetName() != "" && Item.IsPlayable()
					If Math.LogicalAnd(ItemAsArmor.GetSlotMask(), 4) == 4
						Return Item
					EndIf
				EndIf
			EndIf
		EndIf
	EndWhile
	Return None
EndFunction

Function FollowerTakesPlayerClothes(Actor Follower)
	Form ArmorToTake = PlayerRef.GetWornForm(0x00000004)
	If !ArmorToTake && !ArmorToTake.HasKeyword(SexLabNoStrip) && ArmorToTake.GetName() != "" && ArmorToTake.IsPlayable()
		ArmorToTake = HasBodyClothes(PlayerRef)
	EndIf
	Debug.SendAnimationEvent(Follower, "IdleTake")
	PlayerRef.RemoveItem(ArmorToTake, 1, false, Follower)
	Follower.EquipItem(ArmorToTake)
	_SLS_FollowerNakedClothesLockQuest.Stop()
	_SLS_FollowerNakedClothesLockQuest.Start()
	(_SLS_FollowerNakedClothesLockQuest.GetNthAlias(0) as ReferenceAlias).ForceRefTo(Follower)
	_SLS_FemaleGasp.Play(PlayerRef)
EndFunction

Float Function GetLicenceDiscountMagic()
	Int FactionRank =  PlayerRef.GetFactionRank(CollegeofWinterholdFaction)
	If FactionRank >= 0
		Return (LicFactionDiscount / 7.0) * (FactionRank + 1) ; Faction ranks begin at 0
	EndIf
	Return 0.0
EndFunction

Float Function GetLicenceDiscountWeapons()
	Int FactionRank =  PlayerRef.GetFactionRank(CompanionsFaction)
	If FactionRank >= 0
		Return (LicFactionDiscount / 4.0) * (FactionRank + 1) ; Faction ranks begin at 0
	EndIf
	Return 0.0
EndFunction

Int Function GetCwRank()
	If CW01A.GetCurrentStageId() >= 200 || CW01B.GetCurrentStageId() >= 200 ; playerAllegiance is set on new games even if the player hasn't picked a side... *sigh*
		If Cw.playerAllegiance == 1 ; Player is imperial
			If CWObj.GetCurrentStageID() >= 255 ; Civil war completed
				Return 6
			ElseIf CWMission04.GetCurrentStageID() >= 200 ; Compelling Tribute
				Return 5
			ElseIf CWMission07.GetCurrentStageID() >= 200 ; Rescue from Fort Kastav
				Return 4
			ElseIf CWMission03.GetCurrentStageID() >= 200 ; A False Front
				Return 3
			ElseIf CW03.GetCurrentStageID() >= 210 ; Message to Whiterun
				Return 2
			ElseIf CW02A.GetCurrentStageID() >= 200 ; The Jagged Crown
				Return 1
			Else ; Just joined
				Return 0
			EndIf

		ElseIf Cw.playerAllegiance == 2 ; Player is stormcloak
			If CWObj.GetCurrentStageID() >= 255 ; Civil war completed
				Return 6
			ElseIf CWMission03.GetCurrentStageID() >= 200 ; A False Front
				Return 5
			ElseIf CWMission07.GetCurrentStageID() >= 200 ; Compelling Tribute
				Return 4
			ElseIf CWMission04.GetCurrentStageID() >= 200 ; Rescue from Fort Neugrad
				Return 3
			ElseIf CW03.GetCurrentStageID() >= 240 ; Message to Whiterun
				Return 2
			ElseIf CW02B.GetCurrentStageID() >= 200 ; The Jagged Crown
				Return 1
			Else ; Just joined
				Return 0
			EndIf
		EndIf
		
	Else ; Player hasn't picked a side
		Return -1
	EndIf
EndFunction

String Function GetCwRankString()
	Int Rank
	If CW01A.GetCurrentStageId() >= 200 || CW01B.GetCurrentStageId() >= 200
		If Cw.playerAllegiance == 1 ; Player is imperial
			Rank = GetCwRank()
			If Rank == 0
				Return "0 - Recruit"
			ElseIf Rank == 1
				Return "1 - Soldier"
			ElseIf Rank == 2
				Return "2 - Auxiliary"
			ElseIf Rank == 3
				Return "3 - Quaestor"
			ElseIf Rank == 4
				Return "4 - Praefect"
			ElseIf Rank == 5
				Return "5 - Tribune"
			ElseIf Rank == 6
				Return "6 - Legate"
			Else
				Return "None"
			EndIf

		ElseIf Cw.playerAllegiance == 2 ; Player is stormcloak
			Rank = GetCwRank()
			If Rank == 0
				Return "0 - Recruit"
			ElseIf Rank == 1
				Return "1 - Soldier"
			ElseIf Rank == 2
				Return "2 - Unblooded"
			ElseIf Rank == 3
				Return "3 - Ice-Veins"
			ElseIf Rank == 4
				Return "4 - Bone-Breaker"
			ElseIf Rank == 5
				Return "5 - Snow-Hammer"
			ElseIf Rank == 6
				Return "6 - Stormblade"
			Else
				Return "None"
			EndIf
		EndIf
		
	Else
		Return ""
	EndIf
EndFunction

Float Function GetLicenceDiscountArmor()
	Int FactionRank =  GetCwRank()
	If FactionRank >= 0
		Return (LicFactionDiscount / 7.0) * (FactionRank + 1) ; Faction ranks begin at 0
	EndIf
	Return 0.0
EndFunction

Function CheckForBikiniCurse()
	If HasValidBikiniLicence && !HasValidArmorLicence
		ToggleBikiniCurse(true)
	Else
		ToggleBikiniCurse(false)
	EndIf
EndFunction

Function ToggleBikiniCurse(Bool Active)
	If Active && BikiniCurseEnable
		If !PlayerRef.HasMagicEffect(Game.GetFormFromFile(0x063A83, "SL Survival.esp") as MagicEffect) && !PlayerRef.HasMagicEffect(Game.GetFormFromFile(0x063A85, "SL Survival.esp") as MagicEffect)
			(Game.GetFormFromFile(0x0D6699, "SL Survival.esp") as Spell).Cast(PlayerRef, PlayerRef) ; _SLS_LicBikiniCurseVisualEffectSpell
			(((Game.GetFormFromFile(0x063A8C, "SL Survival.esp") as Quest).GetNthAlias(0) as ReferenceAlias) as _SLS_LicBikiniCurse).DoShortBreathEffect((Game.GetFormFromFile(0x063A84, "SL Survival.esp") as GlobalVariable).GetValueInt())
		EndIf
		PlayerRef.AddSpell(_SLS_LicBikiniCurseSpell)
		;_SLS_LicBikiniCurseQuest.Start()
		If CurseTats
			If !Util.HasOverlay(PlayerRef, "\\SL Survival\\bikini_curse_body.dds", Menu.OverlayAreas[Menu.BikiniCurseArea])
				Util.BeginOverlay(PlayerRef, 0.9, "\\SL Survival\\bikini_curse_body.dds", Menu.OverlayAreas[Menu.BikiniCurseArea])
			EndIf
		EndIf
		
		
	Else
		PlayerRef.RemoveSpell(_SLS_LicBikiniCurseSpell)
		;_SLS_LicBikiniCurseQuest.Stop()
		Util.RemoveOverlay(PlayerRef, "\\SL Survival\\bikini_curse_body.dds", Menu.OverlayAreas[Menu.BikiniCurseArea])
	EndIf
EndFunction

Function SetupSlotMasks()
	SlotMasks = new Int[32]
	SlotMasks[0] = 1 ; kSlotMask30
	SlotMasks[1] = 2 ; kSlotMask31
	SlotMasks[2] = 4 ; kSlotMask32
	SlotMasks[3] = 8 ; kSlotMask33
	SlotMasks[4] = 16 ; kSlotMask34
	SlotMasks[5] = 32 ; kSlotMask35
	SlotMasks[6] = 64 ; kSlotMask36
	SlotMasks[7] = 128 ; kSlotMask37
	SlotMasks[8] = 256 ; kSlotMask38
	SlotMasks[9] = 512 ; kSlotMask39
	SlotMasks[10] = 1024 ; kSlotMask40
	SlotMasks[11] = 2048 ; kSlotMask41
	SlotMasks[12] = 4096 ; kSlotMask42
	SlotMasks[13] = 8192 ; kSlotMask43
	SlotMasks[14] = 16384 ; kSlotMask44
	SlotMasks[15] = 32768 ; kSlotMask45
	SlotMasks[16] = 65536 ; kSlotMask46
	SlotMasks[17] = 131072 ; kSlotMask47
	SlotMasks[18] = 262144 ; kSlotMask48
	SlotMasks[19] = 524288 ; kSlotMask49
	SlotMasks[20] = 1048576 ; kSlotMask50
	SlotMasks[21] = 2097152 ; kSlotMask51
	SlotMasks[22] = 4194304 ; kSlotMask52
	SlotMasks[23] = 8388608 ; kSlotMask53
	SlotMasks[24] = 16777216 ; kSlotMask54
	SlotMasks[25] = 33554432 ; kSlotMask55
	SlotMasks[26] = 67108864 ; kSlotMask56
	SlotMasks[27] = 134217728 ; kSlotMask57
	SlotMasks[28] = 268435456 ; kSlotMask58
	SlotMasks[29] = 536870912 ; kSlotMask59
	SlotMasks[30] = 1073741824 ; kSlotMask60
	SlotMasks[31] = 0x80000000 ; kSlotMask61 - Use hex otherwise number ends up being 1 short....?
EndFunction

Function SetupLicTypeStrArray()
	LicTypesString = new String[9]
	LicTypesString[0] = "Magic"
	LicTypesString[1] = "Weapon"
	LicTypesString[2] = "Armor"
	LicTypesString[3] = "Bikini"
	LicTypesString[4] = "Clothes"
	LicTypesString[5] = "Curfew"
	LicTypesString[6] = "Whore"
	LicTypesString[7] = "Freedom"
	LicTypesString[8] = "Property"
EndFunction

String Function GetLicTypeByInt(Int LicType)
	Return LicTypesString[LicType]
EndFunction

Function SetMandatoryGag(Actor akSpeaker)
	Faction akCrimeFaction = akSpeaker.GetCrimeFaction()
	Float CurTime = Utility.GetCurrentGameTime()
	If akCrimeFaction
		If akCrimeFaction == CrimeFactionWhiterun
			If MandGagWhiterun > CurTime ; Is already mandatorily gagged - Add a day
				If (MandGagWhiterun + 1.0) - CurTime <= 3.0 ; Only add a day if total resulting duration less 3 days or more. 
					MandGagWhiterun += 1.0
				EndIf
			Else ; Is not already mandatorily gagged - Set base duration (default 3 days)
				MandGagWhiterun = CurTime + MandGagDuration
			EndIf
			
		ElseIf akCrimeFaction == CrimeFactionHaafingar
			If MandGagSolitude > CurTime
				If (MandGagSolitude + 1.0) - CurTime <= 3.0
					MandGagSolitude += 1.0
				EndIf
			Else
				MandGagSolitude = CurTime + MandGagDuration
			EndIf

		ElseIf akCrimeFaction == CrimeFactionReach
			If MandGagMarkarth > CurTime
				If (MandGagMarkarth + 1.0) - CurTime <= 3.0
					MandGagMarkarth += 1.0
				EndIf
			Else
				MandGagMarkarth = CurTime + MandGagDuration
			EndIf

		ElseIf akCrimeFaction == CrimeFactionEastmarch
			If MandGagWindhelm > CurTime
				If (MandGagWindhelm + 1.0) - CurTime <= 3.0
					MandGagWindhelm += 1.0
				EndIf
			Else
				MandGagWindhelm = CurTime + MandGagDuration
			EndIf

		ElseIf akCrimeFaction == CrimeFactionRift
			If MandGagRiften > CurTime
				If (MandGagRiften + 1.0) - CurTime <= 3.0
					MandGagRiften += 1.0
				EndIf
			Else
				MandGagRiften = CurTime + MandGagDuration
			EndIf
			
		Else
			Debug.Trace("_SLS_: SetMandatoryGag: Crime faction not known: " + akCrimeFaction)
		EndIf
	Else
		Debug.Trace("_SLS_: SetMandatoryGag: None crime faction!")
	EndIf
EndFunction

Bool Function GetIsMandatoryGagged(Int ActivatorLocation, Actor akSpeaker = None)
	; ActivatorLocation: 0 - Whiterun, 1 - Solitude, 2 - Markarth, 3 - Windhelm, 4 - Riften
	If ActivatorLocation < 0
		If akSpeaker
			ActivatorLocation = GetActivatorLocationFromCrimeFaction(akSpeaker)
		Else
			Debug.Trace("_SLS_: GetIsMandatoryGagged: None akSpeaker")
			Return false
		EndIf
	EndIf
	
	Float CurTime = Utility.GetCurrentGameTime()
	If ActivatorLocation == 0
		Return MandGagWhiterun > CurTime
	ElseIf ActivatorLocation == 1
		Return MandGagSolitude > CurTime
	ElseIf ActivatorLocation == 2
		Return MandGagMarkarth > CurTime
	ElseIf ActivatorLocation == 3
		Return MandGagWindhelm > CurTime
	ElseIf ActivatorLocation == 4
		Return MandGagRiften > CurTime
	Else
		Debug.Trace("_SLS_: GetIsMandatoryGagged: Unknown ActivatorLocation: " + ActivatorLocation)
		Return false
	EndIf
EndFunction

Int Function GetActivatorLocationFromCrimeFaction(Actor akActor)
	If akActor
		Faction akCrimeFaction = akActor.GetCrimeFaction()
		If akCrimeFaction
			If akCrimeFaction == CrimeFactionWhiterun
				Return 0
			ElseIf akCrimeFaction == CrimeFactionHaafingar
				Return 1
			ElseIf akCrimeFaction == CrimeFactionReach
				Return 2
			ElseIf akCrimeFaction == CrimeFactionEastmarch
				Return 4
			ElseIf akCrimeFaction == CrimeFactionRift
				Return 5
			Else
				Debug.Trace("_SLS_: GetActivatorLocationFromCrimeFaction: Unknown crime faction: " + akCrimeFaction)
				Return -1
			EndIf
		Else
			Debug.Trace("_SLS_: GetActivatorLocationFromCrimeFaction: None crime faction!")
			Return -1
		EndIf
	Else
		Debug.Trace("_SLS_: GetActivatorLocationFromCrimeFaction: Received a none akActor!")
		Return -1
	EndIf
EndFunction

Function EquipMandatoryGag()
	If !Devious.IsPlayerGagged()
		Devious.EquipRandomDeviceByCategory(PlayerRef, "Gags")
	EndIf
EndFunction

Function RemoveMandatoryGag(Actor akSpeaker, Bool ForceRemove = false)
	If Devious.IsPlayerGagged()
		If ForceRemove || GetIsMandatoryGagged(-1, akSpeaker)
			Devious.RemoveDevice(PlayerRef, Devious.GetWornDeviceByKeyword(PlayerRef, Devious.zad_DeviousGag))
		EndIf
	EndIf
EndFunction

Function BeginThaneTracking()
	_SLS_ThaneStatusTrackQuest.Start()
	CheckAllThaneQuests()
EndFunction

Bool Function CheckThaneStatus(Int WhichHold)
	; WhichHold: 0 - Whiterun, 1 - Solitude, 2 - Markarth, 3 - Windhelm, 4 - Riften
	
	If WhichHold == 0 ; Whiterun
		If MQ104.GetCurrentStageID() >= 160 || Favor253.GetCurrentStageID() >= 25
			;Debug.Messagebox("I'm now Thane of Whiterun")
			IsThaneWhiterun = true
			ThaneRewardWhiterun = 1
			DoLicAwardedMessage(WhichHold)
			AwardRandomLicence(WhichHold = WhichHold, DoMessagebox = true)
			CheckAllThaneQuestsComplete()
			Return true
		EndIf
		
	ElseIf WhichHold == 1 ; Solitude
		If Favor252.GetCurrentStageID() >= 25
			;Debug.Messagebox("I'm now Thane of Solitude")
			IsThaneSolitude = true
			ThaneRewardSolitude = 1
			DoLicAwardedMessage(WhichHold)
			AwardRandomLicence(WhichHold = WhichHold, DoMessagebox = true)
			CheckAllThaneQuestsComplete()
			Return true
		EndIf
		
	ElseIf WhichHold == 2 ; Markarth
		If Favor250.GetCurrentStageID() >= 25
			;Debug.Messagebox("I'm now Thane of Markarth")
			IsThaneMarkarth = true
			ThaneRewardMarkarth = 1
			DoLicAwardedMessage(WhichHold)
			AwardRandomLicence(WhichHold = WhichHold, DoMessagebox = true)
			CheckAllThaneQuestsComplete()
			Return true
		EndIf
		
	ElseIf WhichHold == 3 ; Windhelm
		If Favor254.GetCurrentStageID() >= 25
			;Debug.Messagebox("I'm now Thane of Windhelm")
			IsThaneWindhelm = true
			ThaneRewardWindhelm = 1
			DoLicAwardedMessage(WhichHold)
			AwardRandomLicence(WhichHold = WhichHold, DoMessagebox = true)
			CheckAllThaneQuestsComplete()
			Return true
		EndIf
	
	ElseIf WhichHold == 4 ; Riften
		If FreeformRiftenThane.GetCurrentStageID() >= 200
			;Debug.Messagebox("I'm now Thane of Windhelm")
			IsThaneRiften = true
			ThaneRewardRiften = 1
			DoLicAwardedMessage(WhichHold)
			AwardRandomLicence(WhichHold = WhichHold, DoMessagebox = true)
			CheckAllThaneQuestsComplete()
			Return true
		EndIf
		
	EndIf
	Return false
EndFunction

Function DoLicAwardedMessage(Int WhichHold)
	If LicenceStyle == 1
		String Hold
		If WhichHold == 0
			Hold = "Whiterun "
		ElseIf WhichHold == 1
			Hold = "Solitude "
		ElseIf WhichHold == 1
			Hold = "Markarth "
		ElseIf WhichHold == 1
			Hold = "Windhelm "
		ElseIf WhichHold == 1
			Hold = "Riften "
		EndIf
		Debug.Messagebox("Upon gaining the title of Thane of " + Hold + "you have gained the privilege of access to one licence type. Talk to a quartermaster to decide the licence type")
	EndIf
EndFunction

Function CheckAllThaneQuests()
	AtLeastOneLicenceAvailable = false
	IsThaneWhiterun = false
	IsThaneSolitude = false
	IsThaneMarkarth = false
	IsThaneWindhelm = false
	IsThaneRiften = false
	If MQ104.GetCurrentStageID() >= 160 || Favor253.GetCurrentStageID() >= 25
		IsThaneWhiterun = true
		ThaneRewardWhiterun = 1
		AwardRandomLicence(WhichHold = 0, DoMessagebox = false)
	EndIf
	If Favor252.GetCurrentStageID() >= 25
		IsThaneSolitude = true
		ThaneRewardSolitude = 1
		AwardRandomLicence(WhichHold = 1, DoMessagebox = false)
	EndIf
	If Favor250.GetCurrentStageID() >= 25
		IsThaneMarkarth = true
		ThaneRewardMarkarth = 1
		AwardRandomLicence(WhichHold = 2, DoMessagebox = false)
	EndIf
	If Favor254.GetCurrentStageID() >= 25
		IsThaneWindhelm = true
		ThaneRewardWindhelm = 1
		AwardRandomLicence(WhichHold = 3, DoMessagebox = false)
	EndIf
	If FreeformRiftenThane.GetCurrentStageID() >= 200
		IsThaneRiften = true
		ThaneRewardRiften = 1
		AwardRandomLicence(WhichHold = 4, DoMessagebox = false)
	EndIf
	CheckAllThaneQuestsComplete()
EndFunction

Function CheckAllThaneQuestsComplete()
	If IsThaneWhiterun && IsThaneSolitude && IsThaneMarkarth && IsThaneWindhelm && IsThaneRiften
		_SLS_ThaneStatusTrackQuest.Stop()
	EndIf
EndFunction

Bool Function AwardLicence(String LicType, Bool DoMessagebox = true)

	; Do reward
	If LicType == "magic"
		IsAvailableLicMagic = true
	ElseIf LicType == "weapon"
		IsAvailableLicWeapon = true
	ElseIf LicType == "armor"
		IsAvailableLicArmor = true
	ElseIf LicType == "bikini"
		IsAvailableLicBikini = true
	ElseIf LicType == "clothes"
		IsAvailableLicClothes = true
	EndIf
	AtLeastOneLicenceAvailable = true
	If DoMessagebox
		Debug.Messagebox("You've been awarded access to " + LicType + " licences")
	EndIf
	
	;Debug.Messagebox("IsAvailableLicBikini: " + IsAvailableLicBikini + "\nAtLeastOneLicenceAvailable: " + AtLeastOneLicenceAvailable + "\nAlwaysAwardBikiniLicFirst: " + AlwaysAwardBikiniLicFirst)
	
	
	; Set thane variable as having been awarded now
	If ThaneRewardWhiterun == 1
		ThaneRewardWhiterun = 2
		Return true
	EndIf
	If ThaneRewardSolitude == 1
		ThaneRewardSolitude = 2
		Return true
	EndIf
	If ThaneRewardMarkarth == 1
		ThaneRewardMarkarth = 2
		Return true
	EndIf
	If ThaneRewardWindhelm == 1
		ThaneRewardWindhelm = 2
		Return true
	EndIf
	If ThaneRewardRiften == 1
		ThaneRewardRiften = 2
		Return true
	EndIf
	Return false
EndFunction

Function AwardRandomLicence(Int WhichHold, Bool DoMessagebox = true)
	; WhichHold: Which hold to mark as having issued the licence reward. Sets ThaneRewardxxxxxxx to 2 (awarded)

	If LicenceStyle == 2
		If !IsAvailableLicMagic
			StorageUtil.StringListAdd(None, "_SLS_AwardRandomLicList", "magic")
		EndIf
		If !IsAvailableLicWeapon
			StorageUtil.StringListAdd(None, "_SLS_AwardRandomLicList", "weapon")
		EndIf
		If !IsAvailableLicArmor
			If AlwaysAwardBikiniLicFirst && LicBikiniEnable
				If IsAvailableLicBikini
					StorageUtil.StringListAdd(None, "_SLS_AwardRandomLicList", "bikini")
				EndIf
			Else
				StorageUtil.StringListAdd(None, "_SLS_AwardRandomLicList", "armor")
			EndIf
		EndIf
		If !IsAvailableLicBikini && LicBikiniEnable
			StorageUtil.StringListAdd(None, "_SLS_AwardRandomLicList", "bikini")
		EndIf
		If !IsAvailableLicClothes && LicClothesEnable >= 1
			StorageUtil.StringListAdd(None, "_SLS_AwardRandomLicList", "clothes")
		EndIf
		
		String RanLic = StorageUtil.StringListGet(None, "_SLS_AwardRandomLicList", Utility.RandomInt(0, StorageUtil.StringListCount(None, "_SLS_AwardRandomLicList") - 1))
		If RanLic == "magic"
			IsAvailableLicMagic = true
		ElseIf RanLic == "weapon"
			IsAvailableLicWeapon = true
		ElseIf RanLic == "armor"
			IsAvailableLicArmor = true
		ElseIf RanLic == "bikini"
			IsAvailableLicBikini = true
		ElseIf RanLic == "clothes"
			IsAvailableLicClothes = true
		EndIf
		AtLeastOneLicenceAvailable = true
		
		If WhichHold == 0
			ThaneRewardWhiterun = 2
		ElseIf WhichHold == 1
			ThaneRewardSolitude = 2
		ElseIf WhichHold == 2
			ThaneRewardMarkarth = 2
		ElseIf WhichHold == 3
			ThaneRewardWindhelm = 2
		ElseIf WhichHold == 4
			ThaneRewardRiften = 2
		EndIf

		If DoMessagebox
			Debug.Messagebox("You've been awarded access to " + RanLic + " licences")
		EndIf
		StorageUtil.StringListClear(None, "_SLS_AwardRandomLicList")
	EndIf
EndFunction

Function ChangeLicenceStyle()
	GetIsAtLeastOneLicenceAvailable()
	If LicenceStyle == 0
		;AtLeastOneLicenceAvailable = true
		IsAvailableLicMagic = true
		IsAvailableLicWeapon = true
		IsAvailableLicArmor = true
		IsAvailableLicBikini = true
		IsAvailableLicClothes = true
		_SLS_ThaneStatusTrackQuest.Stop()
	
	ElseIf LicenceStyle == 1 || LicenceStyle == 2
		;AtLeastOneLicenceAvailable = false
		IsAvailableLicMagic = false
		IsAvailableLicWeapon = false
		IsAvailableLicArmor = false
		IsAvailableLicBikini = false
		IsAvailableLicClothes = false
		BeginThaneTracking()
		
	ElseIf LicenceStyle == 3
		;AtLeastOneLicenceAvailable = false
		IsAvailableLicMagic = false
		IsAvailableLicWeapon = false
		IsAvailableLicArmor = false
		IsAvailableLicBikini = false
		IsAvailableLicClothes = false
	EndIf
EndFunction

Function GetIsAtLeastOneLicenceAvailable()
	AtLeastOneLicenceAvailable = false
	If LicenceStyle == 0
		AtLeastOneLicenceAvailable = true
	Else
		If LicPropertyEnable || LicFreedomEnable > 0 || LicCurfewEnable || LicWhoreEnable
			AtLeastOneLicenceAvailable = true
		EndIf
	EndIf
EndFunction

Bool Function AllFollowersAreMagicCursed()
	Form[] Followers = Util.GetFollowers()
	Actor akFollower
	Int i = 0
	While i < Followers.Length
		akFollower = Followers[i] as Actor
		If akFollower && akFollower.Is3dLoaded()
			If !akFollower.HasMagicEffect(_SLS_MagicLicenceCollarMgef)
				Return false
			EndIf
		EndIf		
		i += 1
	EndWhile
	Return true
EndFunction

Function RemoveMagicCurseFromAll()
	UnNullifyMagic(PlayerRef)
	RemoveMagicCurseFromAllFollowers()
EndFunction

Function RemoveMagicCurseFromAllFollowers()
	Form[] Followers = Util.GetFollowers()
	Actor akFollower
	Int i = 0
	While i < Followers.Length
		akFollower = Followers[i] as Actor
		If akFollower
			UnNullifyMagic(akFollower)
		EndIf		
		i += 1
	EndWhile
EndFunction

Function RevokeAllLicences(ObjectReference ReceivingRef = None)
	Int i = 0
	While i < LicTypesString.Length
		RevokeLicence(LicType = LicTypesString[i], ReceivingRef = ReceivingRef)
		i += 1
	EndWhile
EndFunction

Function RevokeLicence(String LicType, ObjectReference ReceivingRef = None)
	; LicType - See LicTypesString array
	If !ReceivingRef
		ReceivingRef = _SLS_LicenceDumpRef
	EndIf
	ObjectReference LicRef
	Int i = StorageUtil.FormListCount(None, "_SLS_LicenceList" + LicType)
	While i > 0
		i -= 1
		LicRef = StorageUtil.FormListGet(None, "_SLS_LicenceList" + LicType, i) as ObjectReference
		If PlayerRef.GetItemCount(LicRef) > 0
			PlayerRef.RemoveItem(LicRef, 1, abSilent = true, akOtherContainer = ReceivingRef)
		EndIf
	EndWhile
EndFunction

String Function SelectRandomOwnedLicenceCategory(Bool ConsiderSlaverunJurisdiction)
	Float GameTime = Utility.GetCurrentGameTime()
	If LicMagicEnable && NextMagicExpiry > GameTime
		StorageUtil.StringListAdd(Self, "_SLS_RevokeLicLotto", "Magic")
	EndIf
	
	If NextWeaponExpiry > GameTime
		StorageUtil.StringListAdd(Self, "_SLS_RevokeLicLotto", "Weapon")
	EndIf
	
	If NextArmorExpiry > GameTime
		StorageUtil.StringListAdd(Self, "_SLS_RevokeLicLotto", "Armor")
	EndIf
	
	If LicBikiniEnable && NextBikiniExpiry > GameTime
		StorageUtil.StringListAdd(Self, "_SLS_RevokeLicLotto", "Bikini")
	EndIf
	
	If (LicClothesEnable == 1 || (LicClothesEnable == 2 && !Slaverun.IsFreeArea(PlayerRef.GetCurrentLocation()))) && NextClothesExpiry > GameTime ; Clothes = always OR (Slaverun towns + IS slaverun town)
		StorageUtil.StringListAdd(Self, "_SLS_RevokeLicLotto", "Clothes")
	EndIf
	
	If LicCurfewEnable && NextCurfewExpiry > GameTime
		StorageUtil.StringListAdd(Self, "_SLS_RevokeLicLotto", "Curfew")
	EndIf
	
	If LicWhoreEnable && NextWhoreExpiry > GameTime
		StorageUtil.StringListAdd(Self, "_SLS_RevokeLicLotto", "Whore")
	EndIf
	
	If LicFreedomEnable > 0 && NextFreedomExpiry > GameTime
		StorageUtil.StringListAdd(Self, "_SLS_RevokeLicLotto", "Freedom")
	EndIf
	
	If LicPropertyEnable && NextPropertyExpiry > GameTime
		StorageUtil.StringListAdd(Self, "_SLS_RevokeLicLotto", "Property")
	EndIf
	
	String Result = ""
	If StorageUtil.StringListCount(Self, "_SLS_RevokeLicLotto") > 0
		Result = StorageUtil.StringListGet(Self, "_SLS_RevokeLicLotto", Utility.RandomInt(0, StorageUtil.StringListCount(Self, "_SLS_RevokeLicLotto") - 1))
	EndIf
	StorageUtil.StringListClear(Self, "_SLS_RevokeLicLotto")
	Return Result
EndFunction

ObjectReference Function DestroyRandomOwnedLicence(ObjectReference ReceivingRef = None)
	ObjectReference Licence = GetRandomSingleLicenceInInv()
	If Licence
		Debug.Notification("My " + Licence.GetBaseObject().GetName() + " has been ruined")
		;PlayerRef.DropObject(Licence)
		If ReceivingRef
			Licence.MoveTo(ReceivingRef)
		Else
			Licence.MoveTo(_SLS_LicenceDumpRef)
		EndIf
	EndIf
	Return Licence
EndFunction

ObjectReference Function GetRandomSingleLicenceInInv()
	String LicTypeSelect = SelectRandomOwnedLicenceCategory(ConsiderSlaverunJurisdiction = false)
	If LicTypeSelect
		ObjectReference Licence
		Int i = StorageUtil.FormListCount(None, "_SLS_LicenceList" + LicTypeSelect)
		While i > 0
			i -= 1
			Licence = StorageUtil.FormListGet(None, "_SLS_LicenceList" + LicTypeSelect, i) as ObjectReference
			If PlayerRef.GetItemCount(Licence) > 0
				StorageUtil.FormListAdd(Self, "_SLS_DestroyLicenceListTemp", Licence, AllowDuplicate = false)
			EndIf
		EndWhile
		
		Licence = StorageUtil.FormListGet(Self, "_SLS_DestroyLicenceListTemp", Utility.RandomInt(0, StorageUtil.FormListCount(Self, "_SLS_DestroyLicenceListTemp") - 1)) as ObjectReference
		StorageUtil.FormListClear(Self, "_SLS_DestroyLicenceListTemp")
		Return Licence
	EndIf
	Return None
EndFunction

String Function RevokeRandomLicence(Actor akSpeaker = None, ObjectReference ReceivingRef = None)
	If Init.LicencesEnable	
		;/
		Float GameTime = Utility.GetCurrentGameTime()
		If LicMagicEnable && NextMagicExpiry > GameTime
			StorageUtil.StringListAdd(Self, "_SLS_RevokeLicLotto", "Magic")
		EndIf
		
		If NextWeaponExpiry > GameTime
			StorageUtil.StringListAdd(Self, "_SLS_RevokeLicLotto", "Weapon")
		EndIf
		
		If NextArmorExpiry > GameTime
			StorageUtil.StringListAdd(Self, "_SLS_RevokeLicLotto", "Armor")
		EndIf
		
		If LicBikiniEnable && NextBikiniExpiry > GameTime
			StorageUtil.StringListAdd(Self, "_SLS_RevokeLicLotto", "Bikini")
		EndIf
		
		If (LicClothesEnable == 1 || (LicClothesEnable == 2 && !Slaverun.IsFreeArea(PlayerRef.GetCurrentLocation()))) && NextClothesExpiry > GameTime ; Clothes = always OR (Slaverun towns + IS slaverun town)
			StorageUtil.StringListAdd(Self, "_SLS_RevokeLicLotto", "Clothes")
		EndIf
		
		If LicCurfewEnable && NextCurfewExpiry > GameTime
			StorageUtil.StringListAdd(Self, "_SLS_RevokeLicLotto", "Curfew")
		EndIf
		
		If LicWhoreEnable && NextWhoreExpiry > GameTime
			StorageUtil.StringListAdd(Self, "_SLS_RevokeLicLotto", "Whore")
		EndIf
		
		If LicFreedomEnable > 0 && NextFreedomExpiry > GameTime
			StorageUtil.StringListAdd(Self, "_SLS_RevokeLicLotto", "Freedom")
		EndIf
		
		If LicPropertyEnable && NextPropertyExpiry > GameTime
			StorageUtil.StringListAdd(Self, "_SLS_RevokeLicLotto", "Property")
		EndIf

		If StorageUtil.StringListCount(Self, "_SLS_RevokeLicLotto") > 0
			String LicTypeSelect = StorageUtil.StringListGet(Self, "_SLS_RevokeLicLotto", Utility.RandomInt(0, StorageUtil.StringListCount(Self, "_SLS_RevokeLicLotto") - 1))
		/;
		
		String LicTypeSelect = SelectRandomOwnedLicenceCategory(ConsiderSlaverunJurisdiction = true)
		If LicTypeSelect
			Int i = StorageUtil.FormListCount(None, "_SLS_LicenceList" + LicTypeSelect)
			ObjectReference Licence
			While i > 0
				i -= 1
				Licence = StorageUtil.FormListGet(None, "_SLS_LicenceList" + LicTypeSelect, i) as ObjectReference
				If PlayerRef.GetItemCount(Licence) > 0
					;PlayerRef.DropObject(Licence)
					If ReceivingRef
						Licence.MoveTo(ReceivingRef)
					Else
						Licence.MoveTo(_SLS_LicenceDumpRef)
					EndIf
				EndIf
			EndWhile
			
			If akSpeaker
				String NotifyString = akSpeaker.GetBaseObject().GetName() + " rips up your " + LicTypeSelect + " licence"
				Debug.Messagebox(NotifyString)
			EndIf
			Return LicTypeSelect
		Else
			Debug.Messagebox("You've no licences")
		EndIf
		;StorageUtil.StringListClear(Self, "_SLS_RevokeLicLotto")
	EndIf
	Return ""
EndFunction

Bool Function IsPubicZoneVisible(Actor akActor)
	Form Cuirass = PlayerRef.GetWornForm(0x00000004)
	If Cuirass && Cuirass != Menu.HalfNakedCover._SLS_HalfNakedCoverArmor && StorageUtil.GetIntValue(Cuirass, "SLAroused.IsSlootyArmor", Missing = -1) <= 0
		;Debug.Messagebox("Not visisble")
		Return false
	EndIf
	;Debug.Messagebox("IS visisble\n\nCuirass: " + Cuirass + "\nHalfNakedCoverArmor: " + (Cuirass != Menu.HalfNakedCover._SLS_HalfNakedCoverArmor) + "\nIsSlootyArmor: " + (StorageUtil.GetIntValue(Cuirass, "SLAroused.IsSlootyArmor", Missing = -1) == 1))
	Return true
EndFunction

Bool Function SetHairyPussyTax(Actor akSpeaker)
	Faction CrimeFact = akSpeaker.GetCrimeFaction()
	If CrimeFact == CrimeFactionWhiterun
		Fashion.HairyPussyTaxWhiterun = true
		Return true
	ElseIf CrimeFact == CrimeFactionHaafingar
		Fashion.HairyPussyTaxSolitude = true
		Return true
	ElseIf CrimeFact == CrimeFactionReach
		Fashion.HairyPussyTaxMarkarth = true
		Return true
	ElseIf CrimeFact == CrimeFactionEastmarch
		Fashion.HairyPussyTaxWindhelm = true
		Return true
	ElseIf CrimeFact == CrimeFactionRift
		Fashion.HairyPussyTaxRiften = true
		Return true
	EndIf
	Debug.Trace("_SLS_: SetHairyPussyTax(): Failed to resolve crimefaction: " + CrimeFact + " for actor: " + akSpeaker)
	Return false
EndFunction

Bool Function IsHairyPussyTaxed(Int ActLoc)
	If ActLoc == 0
		Return Fashion.HairyPussyTaxWhiterun
	ElseIf ActLoc == 1
		Return Fashion.HairyPussyTaxSolitude
	ElseIf ActLoc == 2
		Return Fashion.HairyPussyTaxMarkarth
	ElseIf ActLoc == 3
		Return Fashion.HairyPussyTaxWindhelm
	ElseIf ActLoc == 4
		Return Fashion.HairyPussyTaxRiften
	EndIf
	Return false
EndFunction

Bool Function GotDrenched()
	If DrenchLicDestroyChance > Utility.RandomFloat(0.0, 100.0)
		DestroyRandomOwnedLicence()
		Return true
	EndIf
	Return false
	;/
	ObjectReference Licence = DestroyRandomOwnedLicence()
	If Licence
		Debug.Notification("My " + (Licence as _SLS_Licence).LicenceTypeStr + " licence has been ruined")
	EndIf
	/;
EndFunction

Function SetMagicCurseGlobalStatus()
	If !LicMagicEnable
		StorageUtil.SetIntValue(None, "_SLS_PlayerIsMagicCursed", -1)
	Else
		If PlayerRef.HasMagicEffect(_SLS_MagicLicenceCollarMgef)
			If IsCollared
				StorageUtil.SetIntValue(None, "_SLS_PlayerIsMagicCursed", 2)
			Else
				StorageUtil.SetIntValue(None, "_SLS_PlayerIsMagicCursed", 1)
			EndIf
		Else
			StorageUtil.SetIntValue(None, "_SLS_PlayerIsMagicCursed", 0)
		EndIf
	EndIf
EndFunction

Int Property LicenceStyle = 0 Auto Hidden Conditional ; Licence system style: 0 - Default, 1 - Thaneship Choice, 2 - Thaneship Random, 3 - Purchace Unlock

Bool Property AlwaysAwardBikiniLicFirst = true Auto Hidden Conditional ; Thane awards always award the bikini licence first

; 0 - Not awarded, 1 - Available, 2 - Awarded and spent
Int Property ThaneRewardWhiterun = 0 Auto Hidden Conditional
Int Property ThaneRewardSolitude = 0 Auto Hidden Conditional
Int Property ThaneRewardMarkarth = 0 Auto Hidden Conditional
Int Property ThaneRewardWindhelm = 0 Auto Hidden Conditional
Int Property ThaneRewardRiften = 0 Auto Hidden Conditional

Bool Property IsThaneWhiterun = false Auto Hidden Conditional
Bool Property IsThaneSolitude = false Auto Hidden Conditional
Bool Property IsThaneMarkarth = false Auto Hidden Conditional
Bool Property IsThaneWindhelm = false Auto Hidden Conditional
Bool Property IsThaneRiften = false Auto Hidden Conditional

; Which licences the player has unlocked to buy
Bool Property AtLeastOneLicenceAvailable = true Auto Hidden Conditional
Bool Property IsAvailableLicMagic = true Auto Hidden Conditional
Bool Property IsAvailableLicWeapon = true Auto Hidden Conditional
Bool Property IsAvailableLicArmor = true Auto Hidden Conditional
Bool Property IsAvailableLicBikini = true Auto Hidden Conditional
Bool Property IsAvailableLicClothes = true Auto Hidden Conditional

Bool Property HasValidMagicLicence = false Auto Hidden Conditional
Bool Property HasValidWeaponLicence = false Auto Hidden Conditional
Bool Property HasValidArmorLicence = false Auto Hidden Conditional
Bool Property HasValidBikiniLicence = false Auto Hidden Conditional
Bool Property HasValidClothesLicence = false Auto Hidden Conditional
Bool Property HasValidCurfewLicence = false Auto Hidden Conditional
Bool Property HasValidWhoreLicence = false Auto Hidden Conditional
Bool Property HasValidFreedomLicence = false Auto Hidden Conditional
Bool Property HasValidPropertyLicence = false Auto Hidden Conditional

Bool Property NeedsMandGag = false Auto Hidden Conditional
Bool Property IsMandatorilyGagged = false Auto Hidden Conditional
Bool Property NeedsMandRestraints = false Auto Hidden Conditional

Bool Property CheckFollowers = true Auto Hidden
Bool Property ForceCheckDF = true Auto Hidden
Bool Property OwnsProperty = false Auto Hidden
Bool Property BountyMustBePaid = true Auto Hidden Conditional
Bool Property BuyBack = false Auto Hidden
Bool Property FolTakeClothes = true Auto Hidden
Bool Property OrdinSupress = false Auto Hidden
Bool Property FollowerWontCarryKeys = true Auto Hidden Conditional
Bool Property LicenceIntroDone = false Auto Hidden Conditional
Bool Property IsCollared = false Auto Hidden Conditional
Bool Property HasOutstandingFines = false Auto Hidden Conditional
Bool Property RequestedContainerHasItems = false Auto Hidden Conditional
Bool Property ActIsInSlaverunFreeTown = false Auto Hidden Conditional ; Triggered licence activator is NOT in a slaverun enslaved town
Bool Property LicBikiniEnable = true Auto Hidden Conditional
Bool Property LicMagicEnable = true Auto Hidden Conditional ; Enable/disable the magic licence
Bool Property LicPropertyEnable = true Auto Hidden Conditional
Bool Property LicCurfewEnable = true Auto Hidden Conditional
Bool Property LicWhoreEnable = true Auto Hidden Conditional
Bool Property LicMagicCursedDevices = true Auto Hidden
Bool Property CurseTats = true Auto Hidden
Bool Property BikiniCurseEnable = true Auto Hidden
Int Property LicClothesEnable = 2 Auto Hidden Conditional ; 0 - Never, 1 - Always, 2 - Slaverun
Int Property LicFreedomEnable = 2 Auto Hidden Conditional ; 0 - Never, 1 - Always, 2 - Slaverun

Int Property BuyLicenceType Auto Hidden Conditional; 0 - Magic, 1 - Weapons, 2 - Armor, 3 - Bikini, 4 - Clothes
Int Property BuyLicenceTerm Auto Hidden ; 0 - Short term, 1 - Long term, 2 - Perpetual
Int Property RecoveryRequest Auto Hidden Conditional ; 0 - armor, 1 - weapons, 2 - Bikini, 3 - Clothes
Int Property LicCostRequested Auto Hidden Conditional ; Used in licence buying dialogue
Int Property LicInfractionType Auto Hidden Conditional ; 0 - Collar, 1 - Weapons, 2 - Armor, 3 - Non Bikini armor, 4 - Clothes, 5 - Follower, 6 - Magic
Int Property MandatoryRestraints = 0 Auto Hidden Conditional ; 0 - Nothing, 1- armbinder, 2 - yoke, 3 - AB/Yoke + ankle chains, 4 - AB/Yoke + Chains + Hobble?

Int Property LicCostArmorShort = 3000 Auto Hidden ; Mcm settings
Int Property LicCostArmorLong = 9000 Auto Hidden
Int Property LicCostArmorPer = 30000 Auto Hidden
Int Property LicCostBikiniShort = 1000 Auto Hidden
Int Property LicCostBikiniLong = 3000 Auto Hidden
Int Property LicCostBikiniPer = 15000 Auto Hidden
Int Property LicCostClothesShort = 500 Auto Hidden
Int Property LicCostClothesLong = 1500 Auto Hidden
Int Property LicCostClothesPer = 10000 Auto Hidden
Int Property LicCostWeaponShort = 1000 Auto Hidden
Int Property LicCostWeaponLong = 3000 Auto Hidden
Int Property LicCostWeaponPer = 15000 Auto Hidden
Int Property LicCostMagicShort = 1000 Auto Hidden
Int Property LicCostMagicLong = 3000 Auto Hidden
Int Property LicCostMagicPer = 20000 Auto Hidden
Int Property LicCostCurfewShort = 1000 Auto Hidden
Int Property LicCostCurfewLong = 3000 Auto Hidden
Int Property LicCostCurfewPer = 20000 Auto Hidden
Int Property LicCostWhoreShort = 100 Auto Hidden
Int Property LicCostWhoreLong = 300 Auto Hidden
Int Property LicCostWhorePer = 1000 Auto Hidden
Int Property LicCostFreedomShort = 500 Auto Hidden
Int Property LicCostFreedomLong = 5000 Auto Hidden
Int Property LicCostFreedomPer = 250000 Auto Hidden
Int Property LicCostPropertyShort = 1000 Auto Hidden
Int Property LicCostPropertyLong = 6000 Auto Hidden
Int Property LicCostPropertyPer = 100000 Auto Hidden
Int Property FollowerLicStyle = 0 Auto Hidden

Float Property LicShortDur = 7.0 Auto Hidden
Float Property LicLongDur = 28.0 Auto Hidden
Float Property LicFactionDiscount = 0.5 Auto Hidden

Float Property MandGagDuration = 3.0 Auto Hidden
Float Property MandGagWhiterun = 0.0 Auto Hidden
Float Property MandGagSolitude = 0.0 Auto Hidden
Float Property MandGagMarkarth = 0.0 Auto Hidden
Float Property MandGagWindhelm = 0.0 Auto Hidden
Float Property MandGagRiften = 0.0 Auto Hidden

Float Property DrenchLicDestroyChance = 0.0 Auto Hidden

Keyword Property ArmorBoots Auto
Keyword Property ArmorGauntlets Auto
Keyword Property ArmorHelmet Auto
Keyword Property ArmorJewelry Auto
Keyword Property ArmorShield Auto
Keyword Property VendorItemWeapon Auto
Keyword Property VendorItemArmor Auto
Keyword Property VendorItemClothing Auto
Keyword Property VendorItemSpellTome Auto
Keyword Property VendorItemStaff Auto
Keyword Property SexLabNoStrip Auto
Keyword Property _SLS_BikiniArmor Auto

ObjectReference Property _SLS_LicenceConfiscationsWeapons Auto
ObjectReference Property _SLS_LicenceConfiscationsArmors Auto
;ObjectReference Property _SLS_LicenceConfiscationsBikinis Auto
ObjectReference Property _SLS_LicenceConfiscationsClothes Auto
ObjectReference Property _SLS_LicenceConfiscationsMagic Auto
ObjectReference Property _SLS_LicenceDumpRef Auto

ObjectReference Property _SLS_LicenceConfiscationsShopChest Auto

ReferenceAlias Property MagicLicenceCollarAlias Auto

Actor Property PlayerRef Auto

Armor Property _SLS_DummyObject Auto
Armor Property ClothesFarmClothes01 Auto

ActorBase Property _SLS_LicenceCupcakeArmor Auto
ActorBase Property _SLS_LicenceCupcakeBikini Auto
ActorBase Property _SLS_LicenceCupcakeClothes Auto
ActorBase Property _SLS_LicenceCupcakeMagic Auto
ActorBase Property _SLS_LicenceCupcakeWeapon Auto
ActorBase Property _SLS_LicenceCupcakeCurfew Auto
ActorBase Property _SLS_LicenceCupcakeWhore Auto
ActorBase Property _SLS_LicenceCupcakeFreedom Auto
ActorBase Property _SLS_LicenceCupcakeProperty Auto
ActorBase Property _SLS_LicenceIssuerArmor Auto
ActorBase Property _SLS_LicenceIssuerBikini Auto
ActorBase Property _SLS_LicenceIssuerClothes Auto
ActorBase Property _SLS_LicenceIssuerMagic Auto
ActorBase Property _SLS_LicenceIssuerWeapon Auto
ActorBase Property _SLS_LicenceIssuerCurfew Auto
ActorBase Property _SLS_LicenceIssuerWhore Auto
ActorBase Property _SLS_LicenceIssuerFreedom Auto
ActorBase Property _SLS_LicenceIssuerProperty Auto
ActorBase Property _SLS_LicenceExpiryArmor Auto
ActorBase Property _SLS_LicenceExpiryBikini Auto
ActorBase Property _SLS_LicenceExpiryClothes Auto
ActorBase Property _SLS_LicenceExpiryMagic Auto
ActorBase Property _SLS_LicenceExpiryWeapon Auto
ActorBase Property _SLS_LicenceExpiryCurfew Auto
ActorBase Property _SLS_LicenceExpiryWhore Auto
ActorBase Property _SLS_LicenceExpiryFreedom Auto
ActorBase Property _SLS_LicenceExpiryProperty Auto

Quest Property _SLS_LicenceForceGreetQuest Auto
Quest Property DialogueFollower Auto
Quest Property _SLS_FollowerNakedFgQuest Auto
Quest Property _SLS_FollowerNakedClothesLockQuest Auto
Quest Property _SLS_LicBikiniCurseQuest Auto
Quest Property _SLS_LicBuyBackQuest Auto
Quest Property _SLS_LicenceAliases Auto

; Can't seem to find imperial/stormcloak factions with player ranks. So check quests instead :S
Quest Property CWObj Auto
Quest Property CWMission04 Auto
Quest Property CWMission07 Auto
Quest Property CWMission03 Auto
Quest Property CW03 Auto
Quest Property CW02A Auto
Quest Property CW02B Auto
Quest Property CW01A Auto
Quest Property CW01B Auto

; Thane quests
Quest Property _SLS_ThaneStatusTrackQuest Auto
Quest Property MQ104 Auto ; Whiterun
Quest Property Favor253 Auto ; Whiterun
Quest Property Favor252 Auto ; Solitude
Quest Property Favor250 Auto ; Markarth
Quest Property Favor254 Auto ; Windhelm
Quest Property FreeformRiftenThane Auto ; Riften

ReferenceAlias Property NakedFollower Auto

Spell Property _SLS_MagicLicenceCurse Auto
Spell Property _SLS_LicBikiniCurseSpell Auto

MagicEffect Property _SLS_MagicLicenceCollarMgef Auto

MiscObject Property Gold001 auto

Outfit Property _SLS_DummyOutfit Auto

Formlist Property _SLS_LicenceListAll Auto
Formlist Property _SLS_LicenceListArmor Auto
Formlist Property _SLS_LicenceListBikini Auto
Formlist Property _SLS_LicenceListClothes Auto
Formlist Property _SLS_LicenceListMagic Auto
Formlist Property _SLS_LicenceListWeapon Auto
Formlist Property _SLS_LicencePerpetualList Auto
Formlist Property _SLS_BikiniArmorList Auto
Formlist Property _SLS_LicExceptionsArmor Auto
Formlist Property _SLS_LicExceptionsWeapon Auto
Formlist Property _SLS_LicenceListBaseForms Auto

Faction Property _SLS_LicQuartermasterArmorFaction Auto
Faction Property _SLS_LicQuartermasterClothesFaction Auto
Faction Property _SLS_LicQuartermasterMagicFaction Auto
Faction Property _SLS_LicQuartermasterWeaponsFaction Auto

Faction Property CrimeFactionWhiterun Auto
Faction Property CrimeFactionHaafingar Auto
Faction Property CrimeFactionReach Auto
Faction Property CrimeFactionEastmarch Auto
Faction Property CrimeFactionRift Auto

Faction Property CollegeofWinterholdFaction Auto
Faction Property CompanionsFaction Auto

GlobalVariable Property _SLS_LicenceArmorValidUntil Auto
GlobalVariable Property _SLS_LicenceBikiniValidUntil Auto
GlobalVariable Property _SLS_LicenceClothesValidUntil Auto
GlobalVariable Property _SLS_LicenceMagicValidUntil Auto
GlobalVariable Property _SLS_LicenceWeaponValidUntil Auto
GlobalVariable Property _SLS_LicenceCurfewValidUntil Auto
GlobalVariable Property _SLS_LicenceWhoreValidUntil Auto
GlobalVariable Property _SLS_LicenceFreedomValidUntil Auto
GlobalVariable Property _SLS_LicencePropertyValidUntil Auto
GlobalVariable Property _SLS_PlayerIsAIDriven Auto

GlobalVariable Property _SLS_LicCostShort Auto
GlobalVariable Property _SLS_LicCostLong Auto
GlobalVariable Property _SLS_LicCostPer Auto

Sound Property _SLS_FemaleGasp Auto

Int[] SlotMasks
String[] LicTypesString
Perk[] BuyBackPerks

Float Property LastLicCheckTime = -1.0 Auto Hidden

Float Property NextMagicExpiry = -1.0 Auto Hidden
Float Property NextWeaponExpiry = -1.0 Auto Hidden
Float Property NextArmorExpiry = -1.0 Auto Hidden
Float Property NextBikiniExpiry = -1.0 Auto Hidden
Float Property NextClothesExpiry = -1.0 Auto Hidden
Float Property NextCurfewExpiry = -1.0 Auto Hidden
Float Property NextWhoreExpiry = -1.0 Auto Hidden
Float Property NextFreedomExpiry = -1.0 Auto Hidden
Float Property NextPropertyExpiry = -1.0 Auto Hidden

String LicArmorDerogName
String LicBikiniDerogName
String LicClothesDerogName
String LicWeaponDerogName
String LicMagicDerogName
String LicCurfewDerogName
String LicWhoreDerogName
String LicFreedomDerogName
String LicPropertyDerogName

String LicArmorIssuerName
String LicBikiniIssuerName
String LicClothesIssuerName
String LicWeaponIssuerName
String LicMagicIssuerName
String LicCurfewIssuerName
String LicWhoreIssuerName
String LicFreedomIssuerName
String LicPropertyIssuerName

String LicExpiryArmor
String LicExpiryBikini
String LicExpiryClothes
String LicExpiryWeapon
String LicExpiryMagic
String LicExpiryCurfew
String LicExpiryWhore
String LicExpiryFreedom
String LicExpiryProperty

_SLS_LocTrackCentral Property LocTrack Auto
_SLS_LicenceProperty Property PropLic Auto
SLS_Mcm Property Menu Auto
SLS_Utility Property Util Auto
_SLS_TollDodge Property TollDodge Auto
_SLS_InterfaceDevious Property Devious Auto
_SLS_InterfacePaySexCrime Property Psc Auto
_SLS_InterfaceSlaverun Property Slaverun Auto
SLS_Init Property Init Auto
_SLS_LicenceMagicCollar  Property LicenceMagicCollar Auto
_SLS_LicenceMagicCollarPlayerAlias Property LicenceMagicCollarPlayerAlias Auto
_SLS_LicFollowerProc Property FollowerProc Auto
_SLS_LicFolContrabandCheck Property FolContrabandCheck Auto
_SLS_InterfaceEff Property Eff Auto
_SLS_InterfaceSos Property Sos Auto
_SLS_InterfaceFashion Property Fashion Auto

CWScript Property Cw Auto
