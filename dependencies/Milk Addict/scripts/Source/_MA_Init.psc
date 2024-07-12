Scriptname _MA_Init extends Quest Conditional

Bool WasMwaInstalled
Bool WasSgoInstalled
Bool WasPahInstalled
Bool WasSlifInstalled
Bool WasAproposInstalled
Bool WasAproposTwoInstalled
Bool IsInit = True

; MA
_MA_Mcm Property Menu Auto
_MA_Main Property Main Auto

; Interfaces
_MA_Sgo Property SgoInt Auto
_MA_Pah Property PahInt Auto
_MA_Slif Property SlifInt Auto
_MA_Apropos Property AproposInt Auto
_MA_AproposTwo Property AproposTwoInt Auto

; Soft dependencies
Quest Property SgoQuest Auto Hidden
Quest Property PahQuest Auto Hidden
Quest Property AproposTwo Auto Hidden

Keyword Property zad_DeviousGag Auto Hidden
Keyword Property zad_DeviousGagPanel Auto Hidden
Keyword Property zad_PermitOral Auto Hidden

 ; Properties ===============================================================================================
Bool Property IsMwaInstalled Auto Hidden
Bool Property SgoInstalled Auto Conditional Hidden
Bool Property PahExtInstalled Auto Conditional Hidden
Bool Property SlifInstalled Auto Hidden
Bool Property AproposInstalled Auto Hidden
Bool Property AproposTwoInstalled Auto Hidden
Bool Property DeviousFollowersInstalled Auto Conditional Hidden
Bool Property DeviousDevicesInstalled Auto Hidden
Bool Property DflowFirstGame = true Auto Conditional Hidden
Int Property DflowGameResult = 0 Auto Conditional Hidden
Bool Property IsSgoMilkable Auto Conditional Hidden
Bool Property IsMmeMilkable Auto Conditional Hidden
Bool Property IsRepairable = false Auto Conditional Hidden
Bool Property TripMountEvent = false Auto Conditional  Hidden; Used for 'hello' dialog during mount events
Bool Property MountEventCooldown = false Auto Hidden ; Cooldown flag to stop player being mounted continously. Set during trip script. Unset with cooldown spell

Int Property PahSubmissionFactionRank = -2 Auto Conditional Hidden

Actor Property PlayerRef Auto

Faction Property PahSubmissionFaction Auto Hidden
Faction Property SexLabAnimatingFaction Auto

Quest Property _MA_TornArmor Auto
Quest Property _MA_AddictItemAddedQuest Auto

Enchantment Property RepairedEnchantment Auto Hidden
Enchantment Property LastTornEnchantment Auto Hidden

MagicEffect Property _MA_fortifyspeed Auto
MagicEffect Property _MA_ElixirEffect Auto

Armor Property RepairedArmor Auto Hidden
Armor Property LastTornArmor Auto Hidden

ObjectReference Property _MA_TornOverflow Auto
ObjectReference Property CurrentTornClothes Auto Hidden
ReferenceAlias Property CurrentTornClothesAlias Auto Hidden
ReferenceAlias Property AproposTwoPlayerAlias Auto Hidden

Alias Property AproposAlias Auto Hidden

MiscObject Property _MA_StealBountyItem Auto

FormList Property _MA_MountCreatures Auto
Formlist Property _MA_Milk_TypeList Auto
Formlist Property _MA_NpcMilkAddList Auto
Formlist Property _MA_TailorList Auto

GlobalVariable Property _MA_PahSubmissionThreshold Auto
GlobalVariable Property Dflow_Debt Auto Hidden

Float Property SgoOptMilkProduceTime = 8.0 Auto Hidden
Float Property MilkUnits = 0.0 Auto Conditional Hidden

; Getters and setters for soft dependencies ================================================================

; Paradise Halls
Function UpdateLocalPahRunAwayValueGlobal()
	_MA_PahSubmissionThreshold.SetValueInt(PahInt.IF_GetSubThreshold(PahQuest))
EndFunction

; Soulgem Oven
Int Function SgoActorMilkGetCapacity(Actor Cow)
	Return SgoInt.IF_ActorMilkGetCapacity(SgoQuest, Cow)
EndFunction

Function SgoActorMilkRemove(Actor Cow)
	SgoInt.IF_ActorMilkRemove(SgoQuest, Cow)
EndFunction

Int Function GetSgoActorMilkGetCount(Actor Cow)
	Return SgoInt.IF_ActorMilkGetCount(SgoQuest, Cow)
EndFunction

Function SetSgoMilkTime()
	SgoInt.IF_SetSgoMilkTime(SgoQuest)
EndFunction

Float Function GetSgoMilkTime()
	SgoOptMilkProduceTime = SgoInt.IF_GetSgoMilkTime(SgoQuest)
	Return SgoOptMilkProduceTime
EndFunction

; Sexlab Inflation Framework

Function SetMaSlifDefaults()
	SlifInt.IF_SetMaSlifDefaults()
EndFunction

Function ResetMaSlif()
	SlifInt.IF_ResetMaSlif()
EndFunction

	; Ass
Float Function GetSlifAss()
	Return SlifInt.IF_GetSlifAss()
EndFunction

Float Function GetMaSlifAss()
	Return SlifInt.IF_GetMaSlifAss()
EndFunction

Function InflateMaSlifAss(Float ScaleAmount)
	SlifInt.IF_InflateMaSlifAss(ScaleAmount)
EndFunction

	; Belly
Float Function GetSlifBelly()
	Return SlifInt.IF_GetSlifBelly()
EndFunction

; Apropos
Function AproposHeal(Int HealAmount)
	AproposInt.IF_AproposHeal(AproposAlias, HealAmount)
EndFunction

; AproposTwo
Function AproposTwoHeal(Int HealAmount)
	If AproposTwoPlayerAlias== None || AproposTwoPlayerAlias.GetReference() as Actor != PlayerRef
		Int AliasSelect = GetAproposTwoPlayerAlias()
		If AliasSelect != -1
			AproposTwoPlayerAlias = AproposTwo.GetNthAlias(AliasSelect) as ReferenceAlias
		Else
			Debug.Trace("_MA_: Init - AproposTwoHeal: Player alias not found")
			Return
		EndIf
	EndIf
	AproposTwoInt.IF_AproposHeal(AproposTwoPlayerAlias, HealAmount)
EndFunction

 ; Events ====================================================================================================

Event OnInit()
	Debug.Trace("_MA_: Milk Addict soft dependency check BEGIN (Init) ===================")
	
	; Dawnguard - OnInit - Can't see people uninstalling and reinstalling dawnguard
	If Game.GetModByName("Dawnguard.esm") != 255
		VoiceType MuttVoice = Game.GetFormFromFile(0x00011687, "Dawnguard.esm") as VoiceType ; Husky voice type
		_MA_MountCreatures.AddForm(MuttVoice)
		Debug.Trace("_MA_: Dawnguard installed: TRUE")
	Else
		Debug.Trace("_MA_: Dawnguard installed: FALSE")
	EndIf
	
	DoSoftModCheck()
	IsInit = false
EndEvent

 ; Functions ================================================================================================
 
Function PlayerReloadsGame()
	DoSoftModCheck()
EndFunction

Function DoSoftModCheck()
	Debug.Trace("_MA_: Milk Addict soft dependency check BEGIN ==============================")
	
	; MWA
	IsMwaInstalled = false
	If Game.GetModByName("Mortal Weapons & Armor.esp") != 255
		IsMwaInstalled = true
		If WasMwaInstalled != IsMwaInstalled
			WasMwaInstalled = IsMwaInstalled
			If IsMwaInstalled
				ToggleTailorNpcs(false)
			Else
				ToggleTailorNpcs(true)
			EndIf
		EndIf
	EndIf
	Debug.Trace("_MA_: Mortal Weapons & Armors installed: " + IsMwaInstalled)
	
	; SGO
	SgoInstalled = false
	If Game.GetModByName("dcc-soulgem-oven-000.esm") != 255
		SgoQuest = Game.GetFormFromFile(0xd62,"dcc-soulgem-oven-000.esm") as Quest
		SgoInstalled = True
	EndIf
	If SgoInstalled != WasSgoInstalled
		If !IsInit
			Debug.MessageBox("Milk Addict detected soft dependency change for SGO. Did you add/remove it? If so you should reinstall Milk Addict. Clean saving should not be necessary")
		EndIf
		WasSgoInstalled = SgoInstalled
	EndIf
	Debug.Trace("_MA_: Soulgem Oven installed: " + SgoInstalled)
	
	; Paradise Halls
	PahExtInstalled = false
	If Game.GetModByName("paradise_halls_SLExtension.esp") != 255
		PahQuest = Game.GetFormFromFile(0x9157,"paradise_halls_SLExtension.esp") as Quest
		PahSubmissionFaction = Game.GetFormFromFile(0x47EB,"paradise_halls.esm") as Faction ; We'll assume the ESM is also installed
		PahExtInstalled = true
		; PahMcm.runAwayValue = PAH submission threshold MCM setting
	EndIf
	If PahExtInstalled != WasPahInstalled
		If !IsInit
			Debug.MessageBox("Milk Addict detected soft dependency change for Paradise Halls. Did you add/remove it? If so you should reinstall Milk Addict. Clean saving should not be necessary")
		EndIf
		WasPahInstalled = PahExtInstalled
	EndIf
	Debug.Trace("_MA_: Paradise Halls installed: " + SgoInstalled)
	
	; Selab Inflation Framework
	SlifInstalled = false
	If Game.GetModByName("Sexlab Inflation Framework.esp") != 255
		SlifInstalled = true
	EndIf
	If SlifInstalled != WasSlifInstalled
		If !IsInit
			Debug.MessageBox("Milk Addict detected soft dependency change for Sexlab Inflation Framework. Did you add/remove it? If so you should reinstall Milk Addict. Clean saving should not be necessary")
		EndIf
		WasSlifInstalled = SlifInstalled
	EndIf
	Debug.Trace("_MA_: Sexlab Inflation Framework installed: " + SlifInstalled)

	; Apropos
	AproposInstalled = false
	If Game.GetModByName("Apropos.esp") != 255
		Quest AproposQuest = Game.GetFormFromFile(0xD62,"Apropos.esp") as Quest
		AproposAlias = AproposQuest.GetNthAlias(20) as Alias
		AproposInstalled = true
	EndIf
	If AproposInstalled != WasAproposInstalled
		If !IsInit
			Debug.MessageBox("Milk Addict detected soft dependency change for Apropos. Did you add/remove it? If so you should reinstall Milk Addict. Clean saving should not be necessary")
		EndIf
		WasAproposInstalled = AproposInstalled
	EndIf
	Debug.Trace("_MA_: Apropos installed: " + AproposInstalled)
	
	; Apropos2
	AproposTwoInstalled = false
	If Game.GetModByName("Apropos2.esp") != 255
		AproposTwo = Game.GetFormFromFile(0x02902C,"Apropos2.esp") as Quest
		AproposTwoInstalled = true
	EndIf
	If AproposTwoInstalled != WasAproposTwoInstalled
		If !IsInit
			Debug.MessageBox("Milk Addict detected soft dependency change for Apropos2. Did you add/remove it? If so you should reinstall Milk Addict. Clean saving should not be necessary")
		EndIf
		WasAproposTwoInstalled = AproposTwoInstalled
	EndIf
	Debug.Trace("_MA_: Apropos2 installed: " + AproposTwoInstalled)
	
	; Devious Followers
	DeviousFollowersInstalled = false
	If Game.GetModByName("DeviousFollowers.esp") != 255
		Dflow_Debt = Game.GetFormFromFile(0x00C54F,"DeviousFollowers.esp") as GlobalVariable
		DeviousFollowersInstalled = true
	EndIf
	Debug.Trace("_MA_: Devious Followers installed: " + DeviousFollowersInstalled)
	
	; Devious Devices
	DeviousDevicesInstalled = false
	If Game.GetModByName("Devious Devices - Expansion.esm") != 255
		zad_DeviousGag = Game.GetFormFromFile(0x007EB8,"Devious Devices - Assets.esm") as Keyword
		zad_DeviousGagPanel = Game.GetFormFromFile(0x01F306,"Devious Devices - Assets.esm") as Keyword
		zad_PermitOral = Game.GetFormFromFile(0x00FAC9,"Devious Devices - Assets.esm") as Keyword
		DeviousDevicesInstalled = true
	EndIf
	Debug.Trace("_MA_: Devious Devices installed: " + DeviousDevicesInstalled)
	
	
	IsInit = false
	Debug.Trace("_MA_: Milk Addict soft dependency check END ==============================")
EndFunction

Function ToggleTailorNpcs(Bool ShouldExist)
	If ShouldExist
		Debug.Notification("Enabling Milk Addicts tailors")
	Else
		Debug.Notification("Disabling Milk Addicts tailors in favor of MWA")
	EndIf
	Int i = _MA_TailorList.GetSize()
	ObjectReference Tailor
	While i > 0
		i -= 1
		Tailor = _MA_TailorList.GetAt(i) as ObjectReference
		If ShouldExist
			Tailor.Enable()
		Else
			Tailor.Disable()
		EndIf
	EndWhile
EndFunction

Function InitTornClothes(ObjectReference akItemReference) ;, ObjectReference akSourceContainer)
	;/
	if akSourceContainer != None ; Did not come from game world
		akItemReference = CurrentTornClothes
	EndIf
	/;
	If StorageUtil.FormListFind(none, "TornClothesList", akItemReference) < 0 ; Skip this object reference if it is already an alias
		
		; Add to object reference array
		StorageUtil.FormListAdd(none, "TornClothesList", akItemReference)
		
		; Find an empty alias
		ReferenceAlias NextEmptyAlias = Main.GetNextEmptyAlias(_MA_TornArmor)
		If NextEmptyAlias == None
			; BackupPlan
			Debug.trace("_MA_: No empty aliases left for torn clothes. Dumping to container")
			Debug.Notification("MA: There are no empty aliases left - Clothes moved to overflow")
			_MA_TornOverflow.AddItem(akItemReference, 1)
		Else
			NextEmptyAlias.ForceRefTo(akItemReference)
			(NextEmptyAlias as _MA_TornClothesScript).InitAlias()
		EndIf
	EndIf
EndFunction

Function ClearTornClothesAlias()
	
	; Remove from ObjectReference array
	StorageUtil.FormListRemove(none, "TornClothesList", CurrentTornClothes)
	
	; Clear Alias
	CurrentTornClothesAlias.Clear()
	CurrentTornClothes = None
	CurrentTornClothesAlias = None
EndFunction


Function InitLostClothes(ObjectReference LostItem)
	Int SlotMask = (LostItem.GetBaseObject() as Armor).GetSlotMask()

	If Math.LogicalAnd(SlotMask, 4) == 4 ; Body
		_MA_ClothesSearchBody.Disable()
		_MA_LostClothesBodyRef.ForceRefTo(LostItem)
		_MA_LostClothesBodyScript.WhereIAm = None
		_MA_ClothesSearchBodyScript.ResetLostItem(LostItem)
		_MA_ClothesSearchBody.Enable()
		_MA_ClothesSearchBody.MoveTo(PlayerRef)
		
	ElseIf Math.LogicalAnd(SlotMask, 128) == 128 ; Feet
		_MA_ClothesSearchFeet.Disable()
		_MA_LostClothesFeetRef.ForceRefTo(LostItem)
		_MA_LostClothesFeetScript.WhereIAm = None
		_MA_ClothesSearchFeetScript.ResetLostItem(LostItem)
		_MA_ClothesSearchFeet.MoveTo(PlayerRef)
		_MA_ClothesSearchFeet.Enable()
		
	ElseIf Math.LogicalAnd(SlotMask, 8) == 8 ; Hands
		_MA_ClothesSearchHands.Disable()
		_MA_LostClothesHandsRef.ForceRefTo(LostItem)
		_MA_LostClothesHandsScript.WhereIAm = None
		_MA_ClothesSearchHandsScript.ResetLostItem(LostItem)
		_MA_ClothesSearchHands.MoveTo(PlayerRef)
		_MA_ClothesSearchHands.Enable()
		
	ElseIf Math.LogicalAnd(SlotMask, 2) == 2 ; Hair
		_MA_ClothesSearchHead.Disable()
		_MA_LostClothesHeadRef.ForceRefTo(LostItem)
		_MA_LostClothesHeadScript.WhereIAm = None
		_MA_ClothesSearchHeadScript.ResetLostItem(LostItem)
		_MA_ClothesSearchHead.MoveTo(PlayerRef)
		_MA_ClothesSearchHead.Enable()
	EndIf
EndFunction

Int Function GetAproposTwoPlayerAlias() ; Search Apropos2 actor aliases as the player alias is not set in stone
	Int i = 0
	ReferenceAlias AliasSelect
	While i < AproposTwo.GetNumAliases()
		AliasSelect = AproposTwo.GetNthAlias(i) as ReferenceAlias
		If AliasSelect.GetReference() as Actor == PlayerRef
			Return i
		EndIf
		i += 1
	EndWhile
	Return -1
EndFunction

Function DoDflowGame()
	DflowGameResult = Utility.RandomInt(1,6)
	Debug.Messagebox("With a trembling hand you roll the dice. For a moment you hold your breath and your heart quickens. As the dice settles you realize you rolled a " + DflowGameResult)
	DflowFirstGame = false
	Float Debt = 0.0
	If DflowGameResult == 1
		Debt = 400.0
	ElseIf DflowGameResult == 2
		Debt = 350.0
	ElseIf DflowGameResult == 3
		Debt = 300.0
	ElseIf DflowGameResult == 4
		Debt = 200.0
	ElseIf DflowGameResult == 5
		Debt = 100.0
	Else
		Debt = 50.0
	EndIf
	
	Int i = DflowGameResult
	Int FlSelect
	Formlist MilkSubCatList
	While i > 0
		i -= 1
		
		If DflowGameResult == 1 || DflowGameResult == 2
			FlSelect = 0
		ElseIf DflowGameResult == 3
			FlSelect = Utility.RandomInt(0, 1)
		ElseIf DflowGameResult == 4
			FlSelect = Utility.RandomInt(0, 2)
		ElseIf DflowGameResult == 5
			FlSelect = Utility.RandomInt(0, 3)
		Else
			FlSelect = Utility.RandomInt(0, 4)
		EndIf

		MilkSubCatList = _MA_Milk_TypeList.GetAt(FlSelect) as Formlist
		PlayerRef.AddItem(MilkSubCatList.GetAt(Utility.RandomInt(0, (MilkSubCatList.GetSize() - 1))), 1)
	EndWhile
	Float CurrentDebt = Dflow_Debt.GetValue()
	Dflow_Debt.SetValue(CurrentDebt + Debt)
EndFunction

Function ShowDflowGameRules()
	Debug.Messagebox("You'll roll this dice. I'll give you as many milks as you roll. The higher the roll, the better quality milk you can win and the less debt you'll earn. \n\n1 - 400 debt, 1 low quality milk\n2 - 350 debt, 2 low quality milks\n3 - 300 debt, 3 random milks up to tasty\n4 - 200 debt, 4 random milks up to creamy\n5 - 100 debt, 5 random milks up to enriched\n6 - 50 debt, 6 random milks up to sublime")
EndFunction

Bool Function ClearToTryAutoAction()
	If Menu.InvoluntaryActions
		If !PlayerRef.HasMagicEffect(_MA_fortifyspeed) && !PlayerRef.HasMagicEffect(_MA_ElixirEffect)
			If !PlayerRef.IsInCombat() && !PlayerRef.IsInFaction(SexLabAnimatingFaction)
				If IsNotGagged()
					If Main.AutoActionChance > Utility.RandomFloat(0.0, 100.0)
						Debug.Trace("_MA_: ClearToTryAutoAction() - Success")
						Return True
					EndIf
				EndIf
			EndIf
		EndIf
	EndIf
	Debug.Trace("_MA_: ClearToTryAutoAction() - Fail")
	Return False
EndFunction

Bool Function IsNotGagged()
	If DeviousDevicesInstalled
		If PlayerRef.WornHasKeyword(zad_DeviousGag)
			If PlayerRef.WornHasKeyword(zad_DeviousGagPanel) || PlayerRef.WornHasKeyword(zad_PermitOral)
				Return True
			Else
				Return False
			EndIf
		EndIf
	EndIf
	Return True
EndFunction

Function AddictEquipMilk(Form MilkSelect)
	If Utility.IsInMenuMode()
		Input.TapKey(15)
	EndIf
	PlayerRef.EquipItem(MilkSelect)
EndFunction

Function TryAddNpcMilk(ObjectReference akTargetRef)
	_MA_NpcMilkAddList.AddForm(akTargetRef)
	Bool DidAddMilk = false
	Int Quantity = Utility.RandomInt(0, Menu.NpcInvMilkQuantity)
	While Quantity > 0
		If Menu.NpcInvMilkChance > Utility.RandomFloat(0.0, 100.0)
			akTargetRef.AddItem(GetRandomMilk())
			DidAddMilk = true
		EndIf
		Quantity -= 1
	EndWhile
	If akTargetRef as Actor && DidAddMilk
		If (akTargetRef as Actor).IsDead()
			Main.TryAutoEquipMilkContainer(akTargetRef)
		Else
			Debug.Trace("_MA_: TryAddNpcMilk")
			If ClearToTryAutoAction()
				TryStealNpcMilk(akTargetRef)
			EndIf
		EndIf
	EndIf
EndFunction

Function TryStealNpcMilk(ObjectReference akTargetRef)
	If PlayerRef.IsSneaking()
		Debug.Trace("_MA_: TryStealNpcMilk")
		Form MilkSelect = Main.GetFirstMilkInContainer(akTargetRef)
		If MilkSelect != None
			ObjectReference BountyItemObjRef = PlayerRef.PlaceAtMe(_MA_StealBountyItem, 1)
			BountyItemObjRef.SendStealAlarm(PlayerRef)
			_MA_AddictItemAddedQuest.Stop()
			akTargetRef.RemoveItem(MilkSelect, 1, true, PlayerRef)
			PlayerRef.EquipItem(MilkSelect)
			_MA_AddictItemAddedQuest.Start()
			BountyItemObjRef.Disable()
			BountyItemObjRef.DeleteWhenAble()
		EndIf
	EndIf
EndFunction

Function SendTripSpankEvent()
	int SpankEvent = ModEvent.Create("STA_DoRandomNpcSpank")
	if (SpankEvent)
		ModEvent.PushFloat(SpankEvent, 3.0)
		ModEvent.PushBool(SpankEvent, false)
		ModEvent.Send(SpankEvent)
	endIf
EndFunction

Function CheckNpcMilkAddList()
;/
	Debug.Trace("_MA_: CheckNpcMilkAddList() Begin **********************************************************************")
	_MA_NpcMilkAddList.AddForm(None)
	Int i = _MA_NpcMilkAddList.GetSize()
	While i > 0
		i -= 1
		Debug.Trace("_MA_: CheckNpcMilkAddList(" + i + ") = " + _MA_NpcMilkAddList.GetAt(i))
		
	EndWhile
/;
	While _MA_NpcMilkAddList.GetSize() > 100
		Form ExcessForm = _MA_NpcMilkAddList.GetAt(0)
		If ExcessForm == None
			_MA_NpcMilkAddList.Revert() ; Can't seem to remove none from a formlist. Revert instead for now
		Else
			_MA_NpcMilkAddList.RemoveAddedForm(ExcessForm)
		EndIf
	EndWhile
EndFunction

Form Function GetRandomMilk()
	Int i = Utility.RandomInt(0, (_MA_Milk_TypeList.GetSize() - 1))
	Formlist FlSelect = (_MA_Milk_TypeList.GetAt(i) as Formlist)
	Return FlSelect.GetAt(Utility.RandomInt(0, (FlSelect.GetSize() - 1)))
EndFunction

 ; Alias Properties =======================================================================================

_MA_DroppedClothesContainerTrack Property _MA_LostClothesBodyScript Auto
_MA_DroppedClothesContainerTrack Property _MA_LostClothesFeetScript Auto
_MA_DroppedClothesContainerTrack Property _MA_LostClothesHandsScript Auto
_MA_DroppedClothesContainerTrack Property _MA_LostClothesHeadScript Auto

ReferenceAlias Property _MA_LostClothesBodyRef Auto
ReferenceAlias Property _MA_LostClothesFeetRef Auto
ReferenceAlias Property _MA_LostClothesHandsRef Auto
ReferenceAlias Property _MA_LostClothesHeadRef Auto

ObjectReference Property _MA_ClothesSearchBody Auto
ObjectReference Property _MA_ClothesSearchFeet Auto
ObjectReference Property _MA_ClothesSearchHands Auto
ObjectReference Property _MA_ClothesSearchHead Auto

_MA_ClothesSearch Property _MA_ClothesSearchBodyScript Auto
_MA_ClothesSearch Property _MA_ClothesSearchFeetScript Auto
_MA_ClothesSearch Property _MA_ClothesSearchHandsScript Auto
_MA_ClothesSearch Property _MA_ClothesSearchHeadScript Auto
