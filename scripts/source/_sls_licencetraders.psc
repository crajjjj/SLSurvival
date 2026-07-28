Scriptname _SLS_LicenceTraders extends ReferenceAlias  

Event OnInit()
	AddInventoryEventFilter(_SLS_NeverAddedItem)
	DoDependencyCheck()
	RegisterForMenu("BarterMenu")
EndEvent

Event OnPlayerLoadGame()
	DoDependencyCheck()
	; Inventory event filters are runtime-only and do NOT survive save/load. Without this,
	; a load leaves the whitelist empty (all item events fire) until the next barter closes
	; and re-arms it - so the handler would classify every item picked up in between.
	; Re-slam it shut on load; OnMenuOpen re-opens it per barter as needed.
	AddInventoryEventFilter(_SLS_NeverAddedItem)
EndEvent

Function DoDependencyCheck()
	MwaInstalled = false
	If Game.GetModByName("Mortal Weapons & Armor.esp") != 255
		MwaInstalled = true
	EndIf
EndFunction

Event OnMenuOpen(String MenuName)
	; The owning quest is stopped whenever trade restrictions are off - which the master
	; Licences toggle forces when the whole licence system is disabled. Quest.Stop() does NOT
	; clear RegisterForMenu though (same stale-registration trap as the 0.710 ahegao bug), so
	; this event still fires on a stopped quest; bail on the quest state so a disabled licence
	; system never enforces at the counter. Re-arm the filter first in case a prior session
	; left it off (e.g. a barter closed without OnMenuClose), so no transaction event slips in.
	If !GetOwningQuest().IsRunning()
		AddInventoryEventFilter(_SLS_NeverAddedItem)
		Return
	EndIf
	SaveSpeech()
	Trader = Game.GetCurrentCrosshairRef() as Actor
	If Trader && !_SLS_TraderListExceptions.HasForm(Trader) && !Trader.IsInFaction(JobFenceFaction) && !Trader.IsInFaction(KhajiitCaravanFaction)
		; Order matters: town state and the licence snapshot must be ready before the
		; filter comes off and transaction events can flow. The cache warm runs last -
		; it is only an accelerator, so an abort there (e.g. Papyrus Extender missing)
		; still leaves enforcement working through the classify-on-first-sight path.
		GetIsEnslavedTown()
		SnapshotLicences()
		ResetTradeSession()
		RemoveAllInventoryEventFilters()
		WarmCategoryCache()
	EndIf
EndEvent

Event OnMenuClose(String MenuName)
	AddInventoryEventFilter(_SLS_NeverAddedItem)
	ResetTradeSession() ; the verdict lists are per-barter scratch - keep them out of the save
EndEvent

Function ResetTradeSession()
	StorageUtil.FormListClear(None, "_SLS_TradeSeen")
	StorageUtil.FormListClear(None, "_SLS_TradeBlockBuy")
	StorageUtil.FormListClear(None, "_SLS_TradeBlockSell")
EndFunction

; The per-event work here must stay minimal: the engine caps how many Papyrus events it
; dispatches per frame, and every external call unlocks this script - a slow handler loses
; the race against spam-clicked purchases, which force illegal items through (reported by
; the OSL Licenses author, who hit the same wall). Verdicts are baked per barter session:
; licence state is snapshotted at menu open (barter pauses the game, and the MCM cannot
; open mid-barter, so exception-list membership is equally fixed), and each form's verdict
; is computed once into per-session seen/blocked lists - rebuilt fresh every barter, so
; nothing persists to go stale (mod updates, KID/SPID keywords, runtime form edits) and
; nothing accumulates in the save. The seen list is what makes the warm window safe: a
; blocklist alone cannot tell "checked and legal" from "not yet checked".

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	If akBaseItem == Gold001
		LastGoldAmount = aiItemCount

	Else
		If !StorageUtil.FormListHas(None, "_SLS_TradeSeen", akBaseItem)
			; First sight - classify now. Covers cell-placed vendor items too (vanilla
			; sells havoked refs with no source container, so no prefilter can
			; enumerate them - but they are unique refs with no stack to spam).
			ClassifyForm(akBaseItem)
		EndIf
		If StorageUtil.FormListHas(None, "_SLS_TradeBlockBuy", akBaseItem)
			CeaseTrading(akBaseItem, aiItemCount, akSourceContainer, Transaction = false)
		EndIf
		SaveSpeech()
	EndIf
EndEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	If akBaseItem == Gold001
		LastGoldAmount = aiItemCount

	Else
		If !StorageUtil.FormListHas(None, "_SLS_TradeSeen", akBaseItem)
			ClassifyForm(akBaseItem)
		EndIf
		If StorageUtil.FormListHas(None, "_SLS_TradeBlockSell", akBaseItem)
			CeaseTrading(akBaseItem, aiItemCount, akDestContainer, Transaction = true)
		EndIf
		SaveSpeech()
	EndIf
EndEvent

; Classify one form and bake its buy/sell verdicts into this barter session's lists.
; The armor exceptions list exempts buying only (selling has never consulted it); the
; weapon list exempts both directions; staffs and tomes consult no exception list.
; The form goes on the seen list LAST, so a racing event can never see "seen" before
; the verdicts have landed - the worst race outcome is a harmless double classify.
Function ClassifyForm(Form akBaseItem)
	Bool BlockBuy = false
	Bool BlockSell = false
	If akBaseItem as Armor
		If (akBaseItem as Armor).GetWeightClass() < 2 ; real armor - enchantment never mattered here
			BlockSell = !SnapArmorLic && !SnapBikiniLic
		Else ; clothing
			BlockSell = GetClothesRuleBlocks()
			If !BlockSell && SnapMagicEnable && !SnapMagicLic
				BlockSell = (akBaseItem as Armor).GetEnchantment() != None
			EndIf
		EndIf
		If BlockSell
			BlockBuy = !_SLS_LicExceptionsArmor.HasForm(akBaseItem)
		EndIf
	ElseIf akBaseItem as Weapon || akBaseItem as Ammo
		If akBaseItem.HasKeyword(VendorItemStaff)
			BlockBuy = SnapMagicEnable && !SnapMagicLic
		Else
			BlockBuy = !SnapWeaponLic && !_SLS_LicExceptionsWeapon.HasForm(akBaseItem)
		EndIf
		BlockSell = BlockBuy
	ElseIf akBaseItem.HasKeyword(VendorItemSpellTome)
		BlockBuy = SnapMagicEnable && !SnapMagicLic
		BlockSell = BlockBuy
	EndIf

	If BlockBuy
		StorageUtil.FormListAdd(None, "_SLS_TradeBlockBuy", akBaseItem, allowDuplicate = false)
	EndIf
	If BlockSell
		StorageUtil.FormListAdd(None, "_SLS_TradeBlockSell", akBaseItem, allowDuplicate = false)
	EndIf
	StorageUtil.FormListAdd(None, "_SLS_TradeSeen", akBaseItem, allowDuplicate = false)
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
		If !StorageUtil.FormListHas(None, "_SLS_TradeSeen", Items[i])
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
