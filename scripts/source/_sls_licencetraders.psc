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
	Trader = Game.GetCurrentCrosshairRef() as Actor
	If Trader && !_SLS_TraderListExceptions.HasForm(Trader) && !Trader.IsInFaction(JobFenceFaction) && !Trader.IsInFaction(KhajiitCaravanFaction)
		RemoveAllInventoryEventFilters()
		GetIsEnslavedTown()
	EndIf
	SaveSpeech()
EndEvent

Event OnMenuClose(String MenuName)
	AddInventoryEventFilter(_SLS_NeverAddedItem)
EndEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	If akBaseItem == Gold001
		LastGoldAmount = aiItemCount
	
	Else
		If akBaseItem as Armor
			If !_SLS_LicExceptionsArmor.HasForm(akBaseItem)
				If (akBaseItem as Armor).GetWeightClass() < 2
					If !LicUtil.HasValidArmorLicence && !LicUtil.HasValidBikiniLicence
						CeaseTrading(akBaseItem, aiItemCount, akSourceContainer, Transaction = false)
					EndIf
				
				Else
					If (akBaseItem as Armor).GetEnchantment() != None
						If LicUtil.LicMagicEnable && !LicUtil.HasValidMagicLicence
							CeaseTrading(akBaseItem, aiItemCount, akSourceContainer, Transaction = false)
						EndIf
					EndIf
					If !LicUtil.HasValidClothesLicence
						If LicUtil.LicClothesEnable == 1
							CeaseTrading(akBaseItem, aiItemCount, akSourceContainer, Transaction = false)
						
						ElseIf LicUtil.LicClothesEnable == 2 && !IsFreeTown
							CeaseTrading(akBaseItem, aiItemCount, akSourceContainer, Transaction = false)
						EndIf
					EndIf
				EndIf
			EndIf
		
		ElseIf akBaseItem as Weapon || akBaseItem as Ammo
			If !LicUtil.HasValidWeaponLicence && !_SLS_LicExceptionsWeapon.HasForm(akBaseItem) && !akBaseItem.HasKeyword(VendorItemStaff)
				CeaseTrading(akBaseItem, aiItemCount, akSourceContainer, Transaction = false)
			ElseIf LicUtil.LicMagicEnable && !LicUtil.HasValidMagicLicence && akBaseItem.HasKeyword(VendorItemStaff)
				CeaseTrading(akBaseItem, aiItemCount, akSourceContainer, Transaction = false)
			EndIf
			
		ElseIf akBaseItem.HasKeyword(VendorItemSpellTome)
			If LicUtil.LicMagicEnable && !LicUtil.HasValidMagicLicence
				CeaseTrading(akBaseItem, aiItemCount, akSourceContainer, Transaction = false)
			EndIf
		EndIf
		SaveSpeech()
	EndIf
EndEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	If akBaseItem == Gold001
		LastGoldAmount = aiItemCount
	
	Else
		If akBaseItem as Armor
			If (akBaseItem as Armor).GetWeightClass() < 2
				If !LicUtil.HasValidArmorLicence && !LicUtil.HasValidBikiniLicence
					CeaseTrading(akBaseItem, aiItemCount, akDestContainer, Transaction = true)
				EndIf
			
			Else
				If (akBaseItem as Armor).GetEnchantment() != None
					If LicUtil.LicMagicEnable && !LicUtil.HasValidMagicLicence
						CeaseTrading(akBaseItem, aiItemCount, akDestContainer, Transaction = true)
					EndIf
				EndIf
				If !LicUtil.HasValidClothesLicence
					If LicUtil.LicClothesEnable == 1
						CeaseTrading(akBaseItem, aiItemCount, akDestContainer, Transaction = true)
					
					ElseIf LicUtil.LicClothesEnable == 2 && !IsFreeTown
						CeaseTrading(akBaseItem, aiItemCount, akDestContainer, Transaction = true)
					EndIf
				EndIf
			EndIf
		
		ElseIf akBaseItem as Weapon || akBaseItem as Ammo
			If !LicUtil.HasValidWeaponLicence && !_SLS_LicExceptionsWeapon.HasForm(akBaseItem) && !akBaseItem.HasKeyword(VendorItemStaff)
				CeaseTrading(akBaseItem, aiItemCount, akDestContainer, Transaction = true)
			ElseIf LicUtil.LicMagicEnable && !LicUtil.HasValidMagicLicence && akBaseItem.HasKeyword(VendorItemStaff)
				CeaseTrading(akBaseItem, aiItemCount, akDestContainer, Transaction = true)
			EndIf
			
		ElseIf akBaseItem.HasKeyword(VendorItemSpellTome)
			If LicUtil.LicMagicEnable && !LicUtil.HasValidMagicLicence
				CeaseTrading(akBaseItem, aiItemCount, akDestContainer, Transaction = true)
			EndIf
		EndIf
		SaveSpeech()
	EndIf
EndEvent

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
