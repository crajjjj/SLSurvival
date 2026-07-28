Scriptname _SLS_LicenceTraders extends ReferenceAlias  

Event OnInit()
	AddInventoryEventFilter(_SLS_NeverAddedItem)
	DoDependencyCheck()
	RegisterForMenu("BarterMenu")
EndEvent

Event OnPlayerLoadGame()
	DoDependencyCheck()
EndEvent

Function DoDependencyCheck()
	MwaInstalled = false
	If Game.GetModByName("Mortal Weapons & Armor.esp") != 255
		MwaInstalled = true
	EndIf
EndFunction

Event OnMenuOpen(String MenuName)
	SaveSpeech()
	Trader = Game.GetCurrentCrosshairRef() as Actor
	If Trader && !_SLS_TraderListExceptions.HasForm(Trader) && !Trader.IsInFaction(JobFenceFaction) && !Trader.IsInFaction(KhajiitCaravanFaction)
		; Order matters: town state and the licence snapshot must be ready before the
		; filter comes off and transaction events can flow. The cache warm runs last -
		; it is only an accelerator, so an abort there (e.g. Papyrus Extender missing)
		; still leaves enforcement working through the classify-on-first-sight path.
		GetIsEnslavedTown()
		SnapshotLicences()
		RemoveAllInventoryEventFilters()
		WarmCategoryCache()
	EndIf
EndEvent

Event OnMenuClose(String MenuName)
	AddInventoryEventFilter(_SLS_NeverAddedItem)
EndEvent

; The per-event work here must stay minimal: the engine caps how many Papyrus events it
; dispatches per frame, and every external call unlocks this script - a slow handler loses
; the race against spam-clicked purchases, which force illegal items through (reported by
; the OSL Licenses author, who hit the same wall). Static form facts (armor class,
; enchantment, keywords) are classified once per form into a persistent StorageUtil int;
; licence state is snapshotted at menu open (it can't change while barter pauses the game).
; Exception-list membership is deliberately NOT cached - the MCM can add/remove exceptions
; at runtime - but those lookups only run for items already failing on licences.

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	If akBaseItem == Gold001
		LastGoldAmount = aiItemCount

	Else
		Int Cat = StorageUtil.GetIntValue(akBaseItem, "_SLS_TradeCat", missing = -1)
		If Cat == -1
			; First sight (cell-placed vendor item, mid-menu addition) - classify once.
			; Vanilla lets merchants sell havoked items placed in the owned cell; those
			; have no source container so no prefilter can enumerate them, but they are
			; unique refs (no stack to spam), so the slow path is safe for them.
			Cat = ClassifyForm(akBaseItem)
		EndIf
		If IsTradeBlocked(Cat, akBaseItem, IsBuying = true)
			CeaseTrading(akBaseItem, aiItemCount, akSourceContainer, Transaction = false)
		EndIf
		SaveSpeech()
	EndIf
EndEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	If akBaseItem == Gold001
		LastGoldAmount = aiItemCount

	Else
		Int Cat = StorageUtil.GetIntValue(akBaseItem, "_SLS_TradeCat", missing = -1)
		If Cat == -1
			Cat = ClassifyForm(akBaseItem)
		EndIf
		If IsTradeBlocked(Cat, akBaseItem, IsBuying = false)
			CeaseTrading(akBaseItem, aiItemCount, akDestContainer, Transaction = true)
		EndIf
		SaveSpeech()
	EndIf
EndEvent

; Static classification, cached per form for the whole save. Categories: 0 - never
; licence-relevant, 1 - real armor (weight class < 2), 2 - plain clothing, 3 - enchanted
; clothing, 4 - weapon/ammo, 5 - staff, 6 - spell tome. Player-enchanted items are new
; dynamic forms, so they classify fresh; StorageUtil purges deleted forms on load.
Int Function ClassifyForm(Form akBaseItem)
	Int Cat = 0
	If akBaseItem as Armor
		If (akBaseItem as Armor).GetWeightClass() < 2
			Cat = 1
		ElseIf (akBaseItem as Armor).GetEnchantment() != None
			Cat = 3
		Else
			Cat = 2
		EndIf
	ElseIf akBaseItem as Weapon || akBaseItem as Ammo
		If akBaseItem.HasKeyword(VendorItemStaff)
			Cat = 5
		Else
			Cat = 4
		EndIf
	ElseIf akBaseItem.HasKeyword(VendorItemSpellTome)
		Cat = 6
	EndIf
	StorageUtil.SetIntValue(akBaseItem, "_SLS_TradeCat", Cat)
	Return Cat
EndFunction

Bool Function IsTradeBlocked(Int Cat, Form akBaseItem, Bool IsBuying)
	; In-script snapshot checks come first so the external exception-list lookups only
	; run for items that already fail on licences. The armor exceptions list exempts
	; buying only (selling has never consulted it); the weapon list exempts both ways.
	If Cat == 1
		If !SnapArmorLic && !SnapBikiniLic
			Return !IsBuying || !_SLS_LicExceptionsArmor.HasForm(akBaseItem)
		EndIf
	ElseIf Cat == 2 || Cat == 3
		If (Cat == 3 && SnapMagicEnable && !SnapMagicLic) || GetClothesRuleBlocks()
			Return !IsBuying || !_SLS_LicExceptionsArmor.HasForm(akBaseItem)
		EndIf
	ElseIf Cat == 4
		If !SnapWeaponLic
			Return !_SLS_LicExceptionsWeapon.HasForm(akBaseItem)
		EndIf
	ElseIf Cat == 5 || Cat == 6
		Return SnapMagicEnable && !SnapMagicLic
	EndIf
	Return false
EndFunction

Bool Function GetClothesRuleBlocks()
	If SnapClothesEnable == 1
		Return !SnapClothesLic
	ElseIf SnapClothesEnable == 2
		Return !SnapClothesLic && !IsFreeTown
	EndIf
	Return false
EndFunction

Function SnapshotLicences()
	SnapArmorLic = LicUtil.HasValidArmorLicence
	SnapBikiniLic = LicUtil.HasValidBikiniLicence
	SnapClothesLic = LicUtil.HasValidClothesLicence
	SnapWeaponLic = LicUtil.HasValidWeaponLicence
	SnapMagicLic = LicUtil.HasValidMagicLicence
	SnapMagicEnable = LicUtil.LicMagicEnable
	SnapClothesEnable = LicUtil.LicClothesEnable
EndFunction

Function WarmCategoryCache()
	; Pre-classify the vendor's container stock so its first spam-click session is
	; already on the fast path. Vendors sell from merchant chests (via faction vendor
	; data), their own inventory, and cell-placed refs - the last group has no
	; container to walk and warms through classify-on-first-sight instead.
	WarmForms(PO3_SKSEFunctions.AddAllItemsToArray(Trader, abNoEquipped = false))
	Faction[] TraderFactions = Trader.GetFactions(-128, 127)
	Int i = 0
	While i < TraderFactions.Length
		ObjectReference MerchantChest = TraderFactions[i].GetMerchantContainer()
		If MerchantChest
			WarmForms(PO3_SKSEFunctions.AddAllItemsToArray(MerchantChest, abNoEquipped = false))
		EndIf
		i += 1
	EndWhile
EndFunction

Function WarmForms(Form[] Items)
	Int i = 0
	While i < Items.Length
		If StorageUtil.GetIntValue(Items[i], "_SLS_TradeCat", missing = -1) == -1
			ClassifyForm(Items[i])
		EndIf
		i += 1
	EndWhile
EndFunction

Function CeaseTrading(Form akBaseItem, Int aiItemCount, ObjectReference akDestContainer, Bool Transaction) ; Transaction - true = selling, false = buying
	While Utility.IsInMenuMode()
		;Debug.Messagebox("KeY: " + Input.GetMappedKey("Tween Menu", DeviceType = 0xFF))
		;Input.TapKey(Input.GetMappedKey("Tween Menu", DeviceType = 0xFF))
		UI.InvokeString("BarterMenu", "_root.Menu_mc.onExitButtonPress", "")
		Utility.WaitMenuMode(0.1)
	EndWhile

	If Transaction ; Player is selling
		akDestContainer.RemoveItem(akBaseItem, aiItemCount, abSilent = true, akOtherContainer = PlayerRef)
		PlayerRef.RemoveItem(Gold001, aiCount = LastGoldAmount, abSilent = true, akOtherContainer = akDestContainer)
		
	Else ; Player is buying
		;Debug.Messagebox("Container: " + akDestContainer + "\nItem: " + akBaseItem)
		akDestContainer.RemoveItem(Gold001, aiCount = LastGoldAmount, abSilent = true, akOtherContainer = PlayerRef)
		If MwaInstalled ; When buying with MWA wait for it to initialize object and return it to inventory
			;Int Timeout = 10
			Utility.Wait(2.0)
			;While PlayerRef.Get
		EndIf
		PlayerRef.RemoveItem(akBaseItem, aiItemCount, abSilent = true, akOtherContainer = akDestContainer)
		
	EndIf
	RestoreSpeech()
	If Trader
		Debug.Notification(Trader.GetBaseObject().GetName() + ": I'm not getting in trouble for you. Get out!")
	EndIf
EndFunction

Function GetIsEnslavedTown()
	IsFreeTown = true
	If Trader
		If _SLS_TraderListRiverwood.HasForm(Trader)
			IsFreeTown = Slaverun.IsFreeTownRiverwood()
		ElseIf _SLS_TraderListWhiterun.HasForm(Trader)
			IsFreeTown = Slaverun.IsFreeTownWhiterun()
		ElseIf _SLS_TraderListSolitude.HasForm(Trader)
			IsFreeTown = Slaverun.IsFreeTownSolitude()
		ElseIf _SLS_TraderListRiften.HasForm(Trader)
			IsFreeTown = Slaverun.IsFreeTownRiften()
		ElseIf _SLS_TraderListWindhelm.HasForm(Trader)
			IsFreeTown = Slaverun.IsFreeTownWindhelm()
		ElseIf _SLS_TraderListMarkarth.HasForm(Trader)
			IsFreeTown = Slaverun.IsFreeTownMarkarth()
		ElseIf _SLS_TraderListDawnstar.HasForm(Trader)
			IsFreeTown = Slaverun.IsFreeTownDawnstar()
		ElseIf _SLS_TraderListFalkreath.HasForm(Trader)
			IsFreeTown = Slaverun.IsFreeTownFalkreath()
		ElseIf _SLS_TraderListMorthal.HasForm(Trader)
			IsFreeTown = Slaverun.IsFreeTownMorthal()
		ElseIf _SLS_TraderListRavenRock.HasForm(Trader)
			IsFreeTown = Slaverun.IsFreeTownRavenRock()
		ElseIf _SLS_TraderListWinterhold.HasForm(Trader)
			IsFreeTown = Slaverun.IsFreeTownWinterhold()
		EndIf
	EndIf
EndFunction

Function SaveSpeech()
	SpeechLevel = PlayerRef.GetBaseActorValue("Speechcraft")
	SpeechExp = ActorValueInfo.GetActorValueInfoByName("Speechcraft").GetSkillExperience()
	LevelProg = Game.GetPlayerExperience()
EndFunction

Function RestoreSpeech()
	PlayerRef.SetActorValue("Speechcraft", SpeechLevel)
	ActorValueInfo.GetActorValueInfoByName("Speechcraft").SetSkillExperience(SpeechExp)
	Game.SetPlayerExperience(LevelProg)
EndFunction

Int LastGoldAmount
Actor Trader
Bool IsFreeTown = true
Bool MwaInstalled = false

; Licence state snapshotted at barter open - barter pauses the game, so it cannot
; change mid-session, and reading it per event was most of the handler's latency
Bool SnapArmorLic
Bool SnapBikiniLic
Bool SnapClothesLic
Bool SnapWeaponLic
Bool SnapMagicLic
Bool SnapMagicEnable
Int SnapClothesEnable

Float SpeechExp
Float SpeechLevel
Float LevelProg

Actor Property PlayerRef Auto

Faction Property JobFenceFaction Auto
Faction Property KhajiitCaravanFaction Auto

MiscObject Property _SLS_NeverAddedItem Auto
MiscObject Property Gold001 Auto

Keyword Property VendorItemSpellTome Auto
Keyword Property VendorItemStaff Auto

Formlist Property _SLS_TraderListAll Auto
Formlist Property _SLS_TraderListDawnstar Auto
Formlist Property _SLS_TraderListFalkreath Auto
Formlist Property _SLS_TraderListMarkarth Auto
Formlist Property _SLS_TraderListMorthal Auto
Formlist Property _SLS_TraderListRavenRock Auto
Formlist Property _SLS_TraderListRiften Auto
Formlist Property _SLS_TraderListRiverwood Auto
Formlist Property _SLS_TraderListSolitude Auto
Formlist Property _SLS_TraderListWhiterun Auto
Formlist Property _SLS_TraderListWindhelm Auto
Formlist Property _SLS_TraderListWinterhold Auto
Formlist Property _SLS_TraderListExceptions Auto
Formlist Property _SLS_LicExceptionsArmor Auto
Formlist Property _SLS_LicExceptionsWeapon Auto

_SLS_InterfaceSlaverun Property Slaverun Auto
_SLS_LicenceUtil Property LicUtil Auto
SLS_Mcm Property Menu Auto
