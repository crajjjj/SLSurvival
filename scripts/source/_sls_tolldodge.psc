Scriptname _SLS_TollDodge extends Quest Conditional

Function TollGateLoad(String ItsLocation, Bool IsInteriorDoor)
	If IsInteriorDoor
		;Debug.Messagebox("Doing it")
		LastTollLocation = ItsLocation
		CheckGrace(LastTollLocation)
		CheckOtherTolls(ItsLocation)
		If !TollIsDue && (!LocTrackCentral.HasHomeAtLoc() || _SLS_CurfewIsInEffect.GetValue() || TollUtil.IsGrounded(LocTrackCentral.PlayerCurrentLocIndex, akSpeaker = None))
			BeginTollDueDetection()
		ElseIf LocTrackCentral.ResidentsDontPayTolls && LocTrackCentral.HasHomeAtLoc()
			Init.IsTollPaid = true
			PaidToll()

		EndIf
		PlayerHasLeftCity = false
		
	Else
		PlayerLeavesCity()
	EndIf
EndFunction

Function BeginTollDueDetection()
	_SLS_TollDodgeTollDueDetectionQuest.Stop()
	_SLS_TollDodgeTollDueDetectionQuest.Start()
EndFunction

Function PaidToll()
	SetTollDue(LastTollLocation, false)
EndFunction

Function SetTollDue(String TollLocation, Bool IsDue)
	If LastTollLocation == "Whiterun"
		TollDueInWhiterun = IsDue
		If !IsDue
			DodgedTollWhiterun = false
		EndIf
		
	ElseIf LastTollLocation == "Solitude"
		TollDueInSolitude = IsDue
		If !IsDue
			DodgedTollSolitude = false
		EndIf
		
	ElseIf LastTollLocation == "Riften"
		TollDueInRiften = IsDue
		If !IsDue
			DodgedTollRiften = false
		EndIf
		
	ElseIf LastTollLocation == "Windhelm"
		TollDueInWindhelm = IsDue
		If !IsDue
			DodgedTollWindhelm = false
		EndIf
		
	ElseIf  LastTollLocation == "Markarth"
		TollDueInMarkarth = IsDue
		If !IsDue
			DodgedTollMarkarth = false
		EndIf
		
	Else
		Debug.Messagebox("Loc not known")
		
	EndIf
	TollIsDue = IsDue
	;Debug.Messagebox("Toll due in " + TollLocation + ": " + IsDue)
EndFunction

Function PlayerLeavesCity()
	If Menu.TollDodging
		;Debug.Messagebox("PLAYER LEAVES CITY")
		;_SLS_TollDodgeHuntQuest.Stop()
		DodgeHunt.Shutdown()
		_SLS_TollDodgeTollDueDetectionQuest.Stop()
		BeginGrace(LastTollLocation)
		AlreadyNotified = false
		LastTollLocation = ""
		;PlayerHasLeftCity = true
		;If TollIsDue
			TollIsDue = false
			;Debug.Notification("It won't be long before the guards notice I'm missing")
			;Debug.Messagebox("naughty girl")
			;RegisterForSingleUpdateGameTime(1.0)
		;Else
			;PlayerDodgedToll = false
			;Debug.Messagebox("Good girl")
			;DodgeAlias.GoToState("")
		;EndIf
	EndIf
EndFunction

Function BeginGrace(String TargetLoc)
	PlayerHasLeftCity = true
	;ToggleGuardWarningQuests(Active = false)
	If TargetLoc == "Whiterun"
		If TollDueInWhiterun
			IsInGraceWhiterun = true
			DodgeTrackWhiterun.BeginTollDodge(Menu.TollDodgeGracePeriod)
		EndIf
	
	ElseIf TargetLoc == "Solitude"
		If TollDueInSolitude
			IsInGraceSolitude = true
			DodgeTrackSolitude.BeginTollDodge(Menu.TollDodgeGracePeriod)
		EndIf
	
	ElseIf TargetLoc == "Riften"
		If TollDueInRiften
			IsInGraceRiften = true
			DodgeTrackRiften.BeginTollDodge(Menu.TollDodgeGracePeriod)
		EndIf
	
	ElseIf TargetLoc == "Windhelm"
		If TollDueInWindhelm
			IsInGraceWindhelm = true
			DodgeTrackWindhelm.BeginTollDodge(Menu.TollDodgeGracePeriod)
		EndIf
	
	ElseIf TargetLoc == "Markarth"
		If TollDueInMarkarth
			IsInGraceMarkarth = true
			DodgeTrackMarkarth.BeginTollDodge(Menu.TollDodgeGracePeriod)
		EndIf
	EndIf
EndFunction

Function CheckGrace(String TargetLoc)
	If TargetLoc == "Whiterun"
		If IsInGraceWhiterun
			DodgeTrackWhiterun.PlayerReturnedInTime()
			IsInGraceWhiterun = false
		EndIf
		
	ElseIf TargetLoc == "Solitude"
		If IsInGraceSolitude
			DodgeTrackSolitude.PlayerReturnedInTime()
			IsInGraceSolitude = false
		EndIf
	ElseIf TargetLoc == "Riften" 
		If IsInGraceRiften
			DodgeTrackMarkarth.PlayerReturnedInTime()
			IsInGraceRiften = false
		EndIf
	ElseIf TargetLoc == "Windhelm" 
		If IsInGraceWindhelm
			DodgeTrackWindhelm.PlayerReturnedInTime()
			IsInGraceWindhelm = false
		EndIf
	ElseIf TargetLoc == "Markarth" 
		If IsInGraceMarkarth
			DodgeTrackRiften.PlayerReturnedInTime()
			IsInGraceMarkarth = false
		EndIf
	EndIf
EndFunction

Function GraceExpired(String TargetLoc)
	If TargetLoc == "Whiterun"
		If IsInGraceWhiterun
			DodgedTollWhiterun = true
			IsInGraceWhiterun = false
		EndIf
		
	ElseIf TargetLoc == "Solitude" 
		If IsInGraceSolitude
			DodgedTollSolitude = true
			IsInGraceSolitude = false
		EndIf
		
	ElseIf TargetLoc == "Riften" 
		If IsInGraceRiften
			DodgedTollRiften = true
			IsInGraceRiften = false
		EndIf
		
	ElseIf TargetLoc == "Windhelm" 
		If IsInGraceWindhelm
			DodgedTollWindhelm = true
			IsInGraceWindhelm = false
		EndIf
		
	ElseIf TargetLoc == "Markarth" 
		If IsInGraceMarkarth
			DodgedTollMarkarth = true
			IsInGraceMarkarth = false
		EndIf
	EndIf
EndFunction

Function HasDodgedToll(String TargetLoc)
	If Menu.TollDodging
		If TargetLoc == "Whiterun" && DodgedTollWhiterun
			DodgedTollNotify()
			BeginHunt()
		ElseIf TargetLoc == "Solitude" && DodgedTollSolitude
			DodgedTollNotify()
			BeginHunt()
		ElseIf TargetLoc == "Riften" && DodgedTollRiften
			DodgedTollNotify()
			BeginHunt()
		ElseIf TargetLoc == "Windhelm" && DodgedTollWindhelm
			DodgedTollNotify()
			BeginHunt()
		ElseIf TargetLoc == "Markarth" && DodgedTollMarkarth
			DodgedTollNotify()
			BeginHunt()
		EndIf
	EndIf
EndFunction

Function BeginHunt()
	RegisterForMenu("Dialogue Menu")
	_SLS_PlayerIsInDialogue.SetValueInt(UI.IsMenuOpen("Dialogue Menu") as Int)
	;Debug.Messagebox("BEGIN HUNT")
	If !DodgeHunt.SawPlayerChangeCell
		;Debug.Messagebox("IN IF")
		;_SLS_TollDodgeHuntQuest.Stop()
		DodgeHunt.Shutdown()
		_SLS_TollDodgeHuntQuest.Start()
		
	;Else
	;	Debug.Messagebox("NOT IN IF")
	EndIf
EndFunction

Function DodgedTollNotify()
	If !AlreadyNotified
		AlreadyNotified = true
		Debug.Notification("The guards here will be on the look out for me after my little indiscretion")
	EndIf
EndFunction

Function CheckOtherTolls(String TollLocation) ; If player arrives at another gate with a due toll then they skipped the toll in another city.
	If LastTollLocation == "Whiterun"
		CheckTollSolitude()
		CheckTollMarkarth()
		CheckTollWindhelm()
		CheckTollRiften()
	ElseIf LastTollLocation == "Solitude"
		CheckTollWhiterun()
		CheckTollMarkarth()
		CheckTollWindhelm()
		CheckTollRiften()
	ElseIf LastTollLocation == "Riften"
		CheckTollWhiterun()
		CheckTollSolitude()
		CheckTollMarkarth()
		CheckTollWindhelm()
	ElseIf LastTollLocation == "Windhelm"
		CheckTollWhiterun()
		CheckTollSolitude()
		CheckTollMarkarth()
		CheckTollRiften()
	ElseIf LastTollLocation == "Markarth"
		CheckTollWhiterun()
		CheckTollSolitude()
		CheckTollWindhelm()
		CheckTollRiften()
	Else
		CheckTollWhiterun()
		CheckTollSolitude()
		CheckTollMarkarth()
		CheckTollWindhelm()
		CheckTollRiften()
	EndIf
EndFunction

Function CheckTollWhiterun()
	If TollDueInWhiterun
		DodgedTollWhiterun = true
		;Debug.Messagebox("Dodged toll in whiterun")
	EndIf
EndFunction

Function CheckTollSolitude()
	If TollDueInSolitude
		DodgedTollSolitude = true
		;Debug.Messagebox("Dodged toll in solitude")
	EndIf
EndFunction

Function CheckTollMarkarth()
	If TollDueInMarkarth
		DodgedTollMarkarth = true
		;Debug.Messagebox("Dodged toll in markarth")
	EndIf
EndFunction

Function CheckTollWindhelm()
	If TollDueInWindhelm
		DodgedTollWindhelm = true
		;Debug.Messagebox("Dodged toll in windhelm")
	EndIf
EndFunction

Function CheckTollRiften()
	If TollDueInRiften
		DodgedTollRiften = true
		;Debug.Messagebox("Dodged toll in riften")
	EndIf
EndFunction

Function HuntSuccess(Actor akSpeaker)
	Debug.Trace("_SLS_: akSpeaker: " + akSpeaker)
	;Debug.Messagebox("_SLS_: akSpeaker: " + akSpeaker)
	StopHunting()
	FirstTimeInDeviceLoop = true
	_SLS_TollDodgeWalkAwayProcQuest.Start()
	WalkAway.akSpeaker = akSpeaker
	GetValidLicenceCount()
	BuildSellList()
	Devious.CheckCanDos()
	UnDodgeToll()
EndFunction

Function StopHunting()
	;Debug.Messagebox("STOP HUNTING")
	;_SLS_TollDodgeHuntQuest.Stop()
	DodgeHunt.Shutdown()
	UnRegisterForMenu("Dialogue Menu")
	
	Int i = _SLS_TollDodgeHuntQuest.GetNumAliases()
	ReferenceAlias AliasSelect
	Actor Hunter
	While i > 0
		i -= 1
		AliasSelect = _SLS_TollDodgeHuntQuest.GetNthAlias(i) as ReferenceAlias
		Hunter = AliasSelect.GetReference() as Actor
		If Hunter
			Debug.Trace("_SLS_: StopHunting(): Clearing alias " + i + " - Actor: " + Hunter)
			AliasSelect.Clear()
			Hunter.EvaluatePackage()
		EndIf
	EndWhile
	
	_SLS_TollDodgeGuardSearch.Stop()
EndFunction

Function UnDodgeToll()
	If LastTollLocation == "Whiterun"
		DodgedTollWhiterun = false
	ElseIf LastTollLocation == "Solitude"
		DodgedTollSolitude = false
	ElseIf LastTollLocation == "Riften"
		DodgedTollRiften = false
	ElseIf LastTollLocation == "Windhelm"
		DodgedTollWindhelm = false
	ElseIf LastTollLocation == "Markarth"
		DodgedTollMarkarth = false
	Else
		Debug.Trace("_SLS_: UnDodgeToll(): LastTollLocation unknown")
	EndIf
EndFunction

Function HuntSuccessTakeGold(Actor Hunter)
	CrimeGold = _SLS_TollCost.GetValueInt() * 5
	Int PlayerGold = PlayerRef.GetItemCount(Gold001)
	If PlayerGold > CrimeGold
		PlayerGold = CrimeGold
	EndIf
	CrimeGold -= PlayerGold
	;Debug.Messagebox("PlayerGold: " + PlayerGold + ". CrimeGold: " + CrimeGold)
	PlayerRef.RemoveItem(Gold001, aiCount = PlayerGold, abSilent = false, akOtherContainer = Hunter)
	WalkAway.WalkAwayState = 1
EndFunction

Event OnMenuOpen(String MenuName)
	If MenuName == "Dialogue Menu"
		_SLS_PlayerIsInDialogue.SetValueInt(1)
	EndIf
EndEvent

Event OnMenuClose(String MenuName)
	If MenuName == "GiftMenu"
		UnRegisterForMenu("GiftMenu")
		_SLS_TollDodgeGiftMenuQuest.Stop()
	ElseIf MenuName == "Dialogue Menu"
		_SLS_PlayerIsInDialogue.SetValueInt(0)
	EndIf
EndEvent

Function AddBounty()
	Debug.Notification(CrimeGold + " added to your bounty in " + LastTollLocation + ". Total: " + (GetBounty() + CrimeGold))
	If CrimeGold > 0
		If LastTollLocation == "Whiterun"
			CrimeFactionWhiterun.ModCrimeGold(CrimeGold)
		ElseIf LastTollLocation == "Solitude"
			CrimeFactionHaafingar.ModCrimeGold(CrimeGold)
		ElseIf LastTollLocation == "Riften"
			CrimeFactionRift.ModCrimeGold(CrimeGold)
		ElseIf LastTollLocation == "Windhelm"
			CrimeFactionEastmarch.ModCrimeGold(CrimeGold)
		ElseIf LastTollLocation == "Markarth"
			CrimeFactionReach.ModCrimeGold(CrimeGold)
		Else
			Debug.Trace("_SLS_: AddBounty: LastTollLocation unknown")
		EndIf
	EndIf
	CrimeGold -= CrimeGold
EndFunction

Int Function GetBounty()
	If LastTollLocation == "Whiterun"
		Return CrimeFactionWhiterun.GetCrimeGold()
	ElseIf LastTollLocation == "Solitude"
		Return CrimeFactionHaafingar.GetCrimeGold()
	ElseIf LastTollLocation == "Riften"
		Return CrimeFactionRift.GetCrimeGold()
	ElseIf LastTollLocation == "Windhelm"
		Return CrimeFactionEastmarch.GetCrimeGold()
	ElseIf LastTollLocation == "Markarth"
		Return CrimeFactionReach.GetCrimeGold()
	Else
		Debug.Trace("_SLS_: AddBounty: LastTollLocation unknown")
	EndIf
EndFunction

Function GiftedItem(Form akBaseObject, Int ItemCount, ObjectReference Giftee)
	If !akBaseObject.HasKeyword(SexLabNoStrip)
		Int ItemValue = ((GetAdjustedSellPrice(akBaseObject) * ItemCount) * Menu.TollDodgeItemValueMod) as Int
		CrimeGold -= ItemValue
		If CrimeGold < 0
			CrimeGold = 0
		EndIf
		Debug.Notification("Bounty reduced by " + ItemValue + ". Remaining bounty: " + CrimeGold)
	Else
		Debug.Notification(Giftee.GetBaseObject().GetName() + ": I don't want that junk")
		PlayerRef.RemoveItem(Giftee, ItemCount, true, PlayerRef)
	EndIf
EndFunction

Function BeginTakeStuff(Actor Hunter)
	If CrimeGold > 0
		If Init.TollDodgeGiftMenu
			_SLS_TollDodgeGiftMenuQuest.Start()
			RegisterForMenu("GiftMenu")
			;Utility.Wait(1.0)
			Hunter.ShowGiftMenu(true, apFilterList = None, abShowStolenItems = true)
		Else
			DoTakeStuff(Hunter, CrimeGoldToAdd = 0, NotifyType = 0)
		EndIf
	EndIf
	WalkAway.WalkAwayState = 1
EndFunction

Function DoTakeStuff(Actor Hunter, Int CrimeGoldToAdd = 0, Int NotifyType = 0)
	Form Item
	Int ItemValue
	Int TotalValue = 0
	Int ItemCount
	String Compensation ; = Hunter.GetBaseObject().GetName() + " took the following as compensation: \n\n"
	Float ValueModifier = Menu.TollDodgeItemValueMod
	_SLS_TollDodgeTakenStuff.Revert()
	Debug.Trace("_SLS_: CrimeGold: " + CrimeGold + ". CrimeGoldToAdd: " + CrimeGoldToAdd)
	CrimeGold += CrimeGoldToAdd
	While CrimeGold > 0 && _SLS_TollDodgeSellList.GetSize() > 0
		Item = _SLS_TollDodgeSellList.GetAt(Utility.RandomInt(0, _SLS_TollDodgeSellList.GetSize() - 1))
		ItemValue = (GetAdjustedSellPrice(Item) * ValueModifier) as Int
		
		ItemCount = PlayerRef.GetItemCount(Item)
		ItemCount = Utility.RandomInt(1, ItemCount)
		
		TotalValue += (ItemValue * ItemCount)
		CrimeGold -= (ItemValue * ItemCount)
		If CrimeGold < 0
			CrimeGold = 0
		EndIf
		;ItemCount = PlayerRef.GetItemCount(Item)
		;ItemCount = Utility.RandomInt(1, ItemCount)
		PlayerRef.RemoveItem(Item, aiCount = ItemCount, abSilent = true, akOtherContainer = Hunter)
		
		Debug.Trace("_SLS_: Item: " + Item + ". Count: " + ItemCount + ". Value: " + (ItemValue * ItemCount) + ". Total: " + TotalValue)
		
		_SLS_TollDodgeTakenStuff.AddForm(Item)
		StorageUtil.SetIntValue(Item, "_SLS_TollDodgeTakenStuffCount", (ItemCount + StorageUtil.GetIntValue(Item, "_SLS_TollDodgeTakenStuffCount", 0)))
		StorageUtil.SetIntValue(Item, "_SLS_TollDodgeItemValue", ItemValue)
		
		If PlayerRef.GetItemCount(Item) == 0
			_SLS_TollDodgeSellList.RemoveAddedForm(Item)
		EndIf
	EndWhile
	
	Int i = 0
	Int LineCount = 0
	While i < _SLS_TollDodgeTakenStuff.GetSize()
		Item = _SLS_TollDodgeTakenStuff.GetAt(i)
		ItemValue = StorageUtil.GetIntValue(Item, "_SLS_TollDodgeItemValue")
		ItemCount = StorageUtil.GetIntValue(Item, "_SLS_TollDodgeTakenStuffCount", 0)
		Compensation += ItemCount + " x " + Item.GetName() + " - Value: " + (ItemCount * ItemValue) + " septims\n"
		i += 1
		LineCount += 1
		If LineCount > 20 || i >= _SLS_TollDodgeTakenStuff.GetSize()
			CompensationNotify(NotifyType, TotalValue, CrimeGold, Hunter, Compensation)
			Compensation = ""
			LineCount = 0
		EndIf
	EndWhile
	StorageUtil.ClearIntValuePrefix("_SLS_TollDodgeTakenStuffCount") ; CleanUp
	StorageUtil.ClearIntValuePrefix("_SLS_TollDodgeItemValue")
EndFunction

Function CompensationNotify(Int NotifyType, Int TotalValue, Int CrimeGold, Actor Hunter, String Compensation)
	If _SLS_TollDodgeTakenStuff.GetSize() > 0
		If NotifyType == 0
			Compensation = "Bounty reduced by: " + TotalValue + " gold." + "\nBounty remaining: " + CrimeGold + " gold." + "\n\n" + Hunter.GetBaseObject().GetName() + " took the following:\n" + Compensation
		ElseIf NotifyType == 1
			Compensation = Hunter.GetBaseObject().GetName() + " pins you down and starts taking some of your stuff!\n\nThey took: \n" + Compensation
		EndIf
		Debug.Messagebox(Compensation)
	EndIf
EndFunction

Function BuildSellList()
	_SLS_TollDodgeSellList.Revert()
	Int i = PlayerRef.GetNumItems()
	Form Item
	While i > 0
		i -= 1
		Item = PlayerRef.GetNthForm(i)
		If !_SLS_QuestItems.HasForm(Item)
			If Item as Armor
				If (Item.HasKeyword(VendorItemArmor) || Item.HasKeyword(VendorItemClothing) || Item.HasKeyword(VendorItemJewelry)) && Item.IsPlayable()
					If !Item.HasKeyword(SexLabNoStrip)
						_SLS_TollDodgeSellList.AddForm(Item)
					EndIf
				EndIf
			
			ElseIf Item as Weapon
				If Item.HasKeyword(VendorItemWeapon) || Item.HasKeyword(VendorItemStaff)
					_SLS_TollDodgeSellList.AddForm(Item)
				EndIf
				
			ElseIf Item as Potion
				If Item.HasKeyword(VendorItemPotion) || Item.HasKeyword(VendorItemFood) || Item.HasKeyword(VendorItemPoison)
					_SLS_TollDodgeSellList.AddForm(Item)
				EndIf
				
			ElseIf Item as MiscObject
				If Item.HasKeyword(VendorItemGem) || Item.HasKeyword(VendorItemTool)
					_SLS_TollDodgeSellList.AddForm(Item)
				EndIf
				
			ElseIf Item as SoulGem
				If Item.HasKeyword(VendorItemSoulGem)
					_SLS_TollDodgeSellList.AddForm(Item)
				EndIf
				
			ElseIf Item as Ingredient
				If Item.HasKeyword(VendorItemIngredient)
					_SLS_TollDodgeSellList.AddForm(Item)
				EndIf
			
			ElseIf Item as Book
				If Item.HasKeyword(VendorItemBook) && !_SLS_LicenceListBaseForms.HasForm(Item)
					_SLS_TollDodgeSellList.AddForm(Item)
				EndIf
			
			ElseIf Item as Scroll
				If Item.HasKeyword(VendorItemScroll)
					_SLS_TollDodgeSellList.AddForm(Item)
				EndIf
			EndIf
		EndIf
	EndWhile
EndFunction

Int Function GetAdjustedSellPrice(Form ObjectSelect) ; https://en.uesp.net/wiki/Skyrim:Speech
	Float SpeechSkill = PlayerRef.GetActorValue("Speechcraft")
	If SpeechSkill > 100
		SpeechSkill = 100
	EndIf
	Float JunkieFactor = 1.0 ; Milk Addict
	Float fBarterMin = Game.GetGameSettingFloat("fBarterMin")
	Float fBarterMax = Game.GetGameSettingFloat("fBarterMax")
	Float PriceFactor = fBarterMax - (fBarterMax - fBarterMin) * (SpeechSkill/100)
	
	Int FinalPrice = Math.Ceiling(JunkieFactor * ObjectSelect.GetGoldValue() * 1.1 / PriceFactor)
	;Debug.Trace("_MA_: _MA_AddictShopMenu: Sell Price for " + ObjectSelect.GetName() + ": " + FinalPrice)
	Return FinalPrice
EndFunction

Function GetValidLicenceCount()
	ValidLicenceCount = 0
	If Init.LicencesEnable
		If LicUtil.HasValidMagicLicence
			ValidLicenceCount += 1
		EndIf
		If LicUtil.HasValidWeaponLicence
			ValidLicenceCount += 1
		EndIf
		If LicUtil.HasValidArmorLicence
			ValidLicenceCount += 1
		EndIf
		If LicUtil.HasValidBikiniLicence
			ValidLicenceCount += 1
		EndIf
		If LicUtil.HasValidClothesLicence
			ValidLicenceCount += 1
		EndIf
	EndIf
EndFunction

Function EquipDevice(String DeviceType)
	Int Value
	If DeviceType == "Boots"
		Devious.CanDoBoots = false
		Value = 50
	ElseIf DeviceType == "Gloves"
		Devious.CanDoGloves = false
		Value = 50
	ElseIf DeviceType == "Collars"
		Devious.CanDoCollar = false
		Devious.CanDoHarness = false
		Value = 50
	ElseIf DeviceType == "Corsets"
		Devious.CanDoCorsets = false
		Devious.CanDoHarness = false
		Value = 50
	ElseIf DeviceType == "Harnesses"
		Devious.CanDoHarness = false
		Devious.CanDoCollar = false
		Devious.CanDoCorsets = false
		Value = 150
	ElseIf DeviceType == "CuffsArms"
		Devious.CanDoArmCuffs = false
		Value = 50
	ElseIf DeviceType == "CuffsLegs"
		Devious.CanDoLegCuffs = false
		Value = 50
	ElseIf DeviceType == "Gags"
		Devious.CanDoGags = false
		Value = 100
	ElseIf DeviceType == "PiercingsNipples"
		Devious.CanDoPiercingsNipples = false
		Value = 50
	ElseIf DeviceType == "PiercingsVagina"
		Devious.CanDoPiercingsVaginal = false
		Value = 50
	ElseIf DeviceType == "ChastityBelts"
		Devious.CanDoBelt = false
		Devious.CanDoBeltAndPlugs = false
		Value = 100
	ElseIf DeviceType == "BeltAndPlugs"
		Devious.CanDoBeltAndPlugs = false
		Devious.CanDoBelt = false
		Value = 200
		Devious.EquipRandomDeviceByCategory(PlayerRef, "PlugsAnal")
		Devious.EquipRandomDeviceByCategory(PlayerRef, "PlugsVaginal")
		DeviceType = "ChastityBelts"
	ElseIf DeviceType == "HobbleSkirts"
		Devious.CanDoSuits = false
		Value = 200
	ElseIf DeviceType == "StraitJackets"
		Devious.CanDoSuits = false
		Value = 300
	ElseIf DeviceType == "PetSuits"
		Devious.CanDoSuits = false
		Value = 300
	ElseIf DeviceType == "Blindfolds"
		Devious.CanDoBlindfolds = false
		Value = 100
	ElseIf DeviceType == "Suits"
		Devious.CanDoSuits = false
		Value = 50
	Else
		Debug.Trace("_SLS_: EquipDevice: DeviceType not found")
	EndIf
	CrimeGold -= Value
	If CrimeGold < 0
		CrimeGold = 0
	EndIf
	
	Debug.Notification("Bounty reduced by: " + Value + ". Remaining: " + CrimeGold + ". Total: " + (GetBounty() + CrimeGold))
	
	Devious.EquipRandomDeviceByCategory(PlayerRef, DeviceType)
	
	;/
	Debug.Trace("_SLS_: ==================================")
	Debug.Trace("_SLS_: CanDoArmCuffs" + Devious.CanDoArmCuffs)
	Debug.Trace("_SLS_: CanDoLegCuffs" + Devious.CanDoLegCuffs)
	Debug.Trace("_SLS_: CanDoBoots" + Devious.CanDoBoots)
	Debug.Trace("_SLS_: CanDoGloves" + Devious.CanDoGloves)
	Debug.Trace("_SLS_: CanDoPiercingsNipples" + Devious.CanDoPiercingsNipples)
	Debug.Trace("_SLS_: CanDoPiercingsVaginal" + Devious.CanDoPiercingsVaginal)
	Debug.Trace("_SLS_: CanDoGags" + Devious.CanDoGags)
	Debug.Trace("_SLS_: CanDoCollar" + Devious.CanDoCollar)
	Debug.Trace("_SLS_: CanDoHarness" + Devious.CanDoHarness)
	Debug.Trace("_SLS_: CanDoCorsets" + Devious.CanDoCorsets)
	Debug.Trace("_SLS_: CanDoBeltAndPlugs" + Devious.CanDoBeltAndPlugs)
	Debug.Trace("_SLS_: CanDoBelt" + Devious.CanDoBelt)
	Debug.Trace("_SLS_: CanDoSuits" + Devious.CanDoSuits)
	Debug.Trace("_SLS_: CanDoBlindfolds" + Devious.CanDoBlindfolds)
	/;

EndFunction

Function RipUpLicence(String LicType)
;/
	Formlist FlSelect
	If LicType == "magic"
		FlSelect = _SLS_LicenceListMagic
	ElseIf LicType == "weapon"
		FlSelect = _SLS_LicenceListWeapon
	ElseIf LicType == "armor"
		FlSelect = _SLS_LicenceListArmor
	ElseIf LicType == "bikini"
		FlSelect = _SLS_LicenceListBikini
	ElseIf LicType == "clothes"
		FlSelect = _SLS_LicenceListClothes
	EndIf
	
	Int i = FlSelect.GetSize()/;
	
	;StorageUtil.FormListAdd(None, "_SLS_LicenceList" + LicTypesString[BuyLicenceType], Licence, AllowDuplicate = false)
	Int i = 0
	
	ObjectReference CurLic
	While i < StorageUtil.FormListCount(None, "_SLS_LicenceList" + LicType)
		CurLic = StorageUtil.FormListGet(None, "_SLS_LicenceList" + LicType, i) as ObjectReference
		If PlayerRef.GetItemCount(CurLic) > 0
			PlayerRef.RemoveItem(CurLic, 1, abSilent = true, akOtherContainer = _SLS_LicenceDumpRef)
		EndIf
		i += 1
	EndWhile
	WalkAway.WalkAwayState = 3
EndFunction

Int Function GetRestraintLevel(Int Town) ; ActivatorLocation: 0 - Whiterun, 1 - Solitude, 2 - Markarth, 3 - Windhelm, 4 - Riften
	Float GameTime = Utility.GetCurrentGameTime()
	Float RestrainedUntil
	Int RestraintLevel = 0
	If Town == 0
		RestrainedUntil = RestraintReqWhiterun
		RestraintLevel = RestraintLevelWhiterun
	ElseIf Town == 1
		RestrainedUntil = RestraintReqSolitude
		RestraintLevel = RestraintLevelSolitude
	ElseIf Town == 2
		RestrainedUntil = RestraintReqMarkarth
		RestraintLevel = RestraintLevelMarkarth
	ElseIf Town == 3
		RestrainedUntil = RestraintReqWindhelm
		RestraintLevel = RestraintLevelWindhelm
	ElseIf Town == 4
		RestrainedUntil = RestraintReqRiften
		RestraintLevel = RestraintLevelRiften
	EndIf
	
	If RestrainedUntil > GameTime
		Return RestraintLevel
	EndIf
	Return 0
EndFunction

Function SetRetraintsMandatory()
	;Debug.Messagebox("Settiung restraint mand in: " + LastTollLocation)
	If LastTollLocation == "Whiterun"
		RestraintReqWhiterun = Utility.GetCurrentGameTime() + 7.0
		RestraintLevelWhiterun += 1
		If RestraintLevelWhiterun > 4 ; Cap it
			RestraintLevelWhiterun = 4
		EndIf
		LicUtil.MandatoryRestraints = RestraintLevelWhiterun
		
	ElseIf LastTollLocation == "Solitude"
		RestraintReqSolitude = Utility.GetCurrentGameTime() + 7.0
		RestraintLevelSolitude += 1
		If RestraintLevelSolitude > 4 ; Cap it
			RestraintLevelSolitude = 4
		EndIf
		LicUtil.MandatoryRestraints = RestraintLevelSolitude
		
	ElseIf LastTollLocation == "Riften"
		RestraintReqRiften = Utility.GetCurrentGameTime() + 7.0
		RestraintLevelRiften += 1
		If RestraintLevelRiften > 4 ; Cap it
			RestraintLevelRiften = 4
		EndIf
		LicUtil.MandatoryRestraints = RestraintLevelRiften
		
	ElseIf LastTollLocation == "Windhelm"
		RestraintReqWindhelm = Utility.GetCurrentGameTime() + 7.0
		RestraintLevelWindhelm += 1
		If RestraintLevelWindhelm > 4 ; Cap it
			RestraintLevelWindhelm = 4
		EndIf
		LicUtil.MandatoryRestraints = RestraintLevelWindhelm
		
	ElseIf LastTollLocation == "Markarth"
		RestraintReqMarkarth = Utility.GetCurrentGameTime() + 7.0
		RestraintLevelMarkarth += 1
		If RestraintLevelMarkarth > 4 ; Cap it
			RestraintLevelMarkarth = 4
		EndIf
		LicUtil.MandatoryRestraints = RestraintLevelMarkarth
		
	ElseIf LastTollLocation == ""
		Debug.Messagebox("Blank loc")
	EndIf
	
	If _SLS_TollDodgeMandatoryRestraintsDecayQuest.IsRunning()
		MandResDecay.SetNextUpdate()
	Else
		_SLS_TollDodgeMandatoryRestraintsDecayQuest.Start()
	EndIf
EndFunction

Function UpdateHunterPackage()
	Int UpdateHunter = ModEvent.Create("_SLS_UpdateTollHunterPackage")
	If (UpdateHunter)
        ModEvent.Send(UpdateHunter)
    EndIf
EndFunction
;/
Function ToggleGuardWarningQuests(Bool Active) ; Guard harassment quests in city if weapons/armor equipped
	;Debug.Messagebox("ToggleGuardWarningQuests - Active: " + Active)
	If Active
		If Menu.GuardBehavArmorEquip
			_SLS_GuardWarnArmorEquippedQuest.Start()
		EndIf
		If Menu.GuardBehavWeapEquip
			_SLS_GuardWarnWeapEquippedQuest.Start()
		EndIf
	Else
		_SLS_GuardWarnArmorEquippedQuest.Stop()
		_SLS_GuardWarnWeapEquippedQuest.Stop()
	EndIf
EndFunction
/;
Bool Property TollIsDue = false Auto Hidden
Bool Property PlayerHasLeftCity = true Auto Hidden
Bool Property PlayerDodgedToll = false Auto Hidden
Bool Property IsInGracePeriod = false Auto Hidden

Bool Property TollDueInWhiterun = false Auto Hidden
Bool Property TollDueInSolitude = false Auto Hidden
Bool Property TollDueInMarkarth = false Auto Hidden
Bool Property TollDueInWindhelm = false Auto Hidden
Bool Property TollDueInRiften = false Auto Hidden

Bool Property IsInGraceWhiterun = false Auto Hidden
Bool Property IsInGraceSolitude = false Auto Hidden
Bool Property IsInGraceMarkarth = false Auto Hidden
Bool Property IsInGraceWindhelm = false Auto Hidden
Bool Property IsInGraceRiften = false Auto Hidden

Bool Property DodgedTollWhiterun = false Auto Hidden
Bool Property DodgedTollSolitude = false Auto Hidden
Bool Property DodgedTollMarkarth = false Auto Hidden
Bool Property DodgedTollWindhelm = false Auto Hidden
Bool Property DodgedTollRiften = false Auto Hidden

Bool Property AlreadyNotified = false Auto Hidden

Bool Property FirstTimeInDeviceLoop = true Auto Hidden Conditional

Int Property CrimeGold = 0 Auto Hidden Conditional
Int Property ValidLicenceCount = 0 Auto Hidden Conditional

Float Property RestraintReqWhiterun = 0.0 Auto Hidden
Float Property RestraintReqSolitude = 0.0 Auto Hidden
Float Property RestraintReqMarkarth = 0.0 Auto Hidden
Float Property RestraintReqWindhelm = 0.0 Auto Hidden
Float Property RestraintReqRiften = 0.0 Auto Hidden

Int Property RestraintLevelWhiterun = 0 Auto Hidden
Int Property RestraintLevelSolitude = 0 Auto Hidden
Int Property RestraintLevelMarkarth = 0 Auto Hidden
Int Property RestraintLevelWindhelm = 0 Auto Hidden
Int Property RestraintLevelRiften = 0 Auto Hidden

String Property LastTollLocation = "" Auto Hidden

Quest Property _SLS_TollDodgeHuntQuest Auto
Quest Property _SLS_TollDodgeGuardSearch Auto
Quest Property _SLS_TollDodgeGiftMenuQuest Auto
Quest Property _SLS_TollDodgeMandatoryRestraintsDecayQuest Auto
Quest Property _SLS_TollDodgeTollDueDetectionQuest Auto
Quest Property _SLS_TollDodgeWalkAwayProcQuest Auto
Quest Property _SLS_GuardWarnArmorEquippedQuest Auto
Quest Property _SLS_GuardWarnWeapEquippedQuest Auto

Formlist Property _SLS_TollDodgeSellList Auto
Formlist Property _SLS_LicenceListArmor Auto
Formlist Property _SLS_LicenceListBikini Auto
Formlist Property _SLS_LicenceListClothes Auto
Formlist Property _SLS_LicenceListMagic Auto
Formlist Property _SLS_LicenceListWeapon Auto
Formlist Property _SLS_LicenceListBaseForms Auto
Formlist Property _SLS_TollDodgeTakenStuff Auto
Formlist Property _SLS_QuestItems Auto

Faction Property CrimeFactionWhiterun Auto
Faction Property CrimeFactionHaafingar Auto ; Solitude
Faction Property CrimeFactionReach Auto ; Markarth
Faction Property CrimeFactionEastmarch Auto ; Windhelm
Faction Property CrimeFactionRift Auto

Keyword Property SexLabNoStrip Auto
Keyword Property VendorItemArmor Auto
Keyword Property VendorItemClothing Auto
Keyword Property VendorItemJewelry Auto
Keyword Property VendorItemWeapon Auto
Keyword Property VendorItemStaff Auto
Keyword Property VendorItemFood Auto
Keyword Property VendorItemPotion Auto
Keyword Property VendorItemPoison Auto
Keyword Property VendorItemGem Auto
Keyword Property VendorItemSoulGem Auto
Keyword Property VendorItemIngredient Auto
Keyword Property VendorItemScroll Auto
Keyword Property VendorItemBook Auto
Keyword Property VendorItemTool Auto

MiscObject Property Gold001 Auto

GlobalVariable Property _SLS_TollCost Auto
GlobalVariable Property _SLS_PlayerIsInDialogue Auto
GlobalVariable Property _SLS_CurfewIsInEffect Auto

Actor Property PlayerRef Auto

ObjectReference Property _SLS_LicenceDumpRef Auto

;ReferenceAlias Property _SLS_TollGateRiftenJkDoorInterior Auto
;ReferenceAlias Property _SLS_TollGateRiftenJkDoorExterior Auto

_SLS_DodgeTrack Property DodgeTrackWhiterun Auto
_SLS_DodgeTrack Property DodgeTrackSolitude Auto
_SLS_DodgeTrack Property DodgeTrackMarkarth Auto
_SLS_DodgeTrack Property DodgeTrackWindhelm Auto
_SLS_DodgeTrack Property DodgeTrackRiften Auto

_SLS_LocTrackCentral Property LocTrackCentral Auto
_SLS_TollDodgeWalkAway Property WalkAway Auto
_SLS_TollDodgeHunt Property DodgeHunt Auto
_SLS_TollDodgeMandResDecay Property MandResDecay Auto
_SLS_InterfaceDevious Property Devious Auto
;_SLS_TollDodgePlayerAlias Property DodgeAlias Auto
_SLS_LicenceUtil Property LicUtil Auto
_SLS_TollUtil Property TollUtil Auto
SLS_Init Property Init Auto
SLS_Mcm Property Menu Auto
