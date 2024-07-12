Scriptname SLS_Main extends ReferenceAlias

; EVENTS =================================================================================================================

Event OnInit()
	Version = 0.685
	Util.Api.SetVersion(Version)
	UiExtensionsCheck()
	AddInventoryEventFilter(_SLS_EvictionNotice)
	AddInventoryEventFilter(Gold001)
	AddInventoryEventFilter(WhiterunBreezehomeKey)
	AddInventoryEventFilter(SolitudeHouseKey)
	AddInventoryEventFilter(MS11HjerimKey)
	AddInventoryEventFilter(RiftenHoneysideKey)
	AddInventoryEventFilter(MarkarthVlindrelHallKey)
	
	;PlayerRef.AddPerk(_SLS_CreatureTalk) ; Creature events disabled by default
	PlayerRef.AddPerk(_SLS_GagBegPerk)
	PlayerRef.AddPerk(_SLS_IncPickpocketLootPerk)
	PlayerRef.AddSpell(_SLS_AssessStash, true)
	PlayerRef.AddSpell(Game.GetFormFromFile(0x04BE30, "SL Survival.esp") as Spell)
	PlayerRef.AddSpell(_SLS_BarefootSpeedSpell, false)
	PlayerRef.Addspell(Menu._SLS_WeaponReadySpell, false)
	PlayerRef.AddSpell(Game.GetFormFromFile(0x06D1AF, "SL Survival.esp") as Spell, false) ; _SLS_CombatChangeDetectSpell
	
	; Initialize home ownership
	If PlayerRef.GetItemCount(WhiterunBreezehomeKey) > 0
		Eviction.OwnsWhiterun = true
		LicUtil.OwnsProperty = true
		RemoveInventoryEventFilter(WhiterunBreezehomeKey)
	ElseIf PlayerRef.GetItemCount(SolitudeHouseKey) > 0
		Eviction.OwnsSolitude = true
		LicUtil.OwnsProperty = true
		RemoveInventoryEventFilter(SolitudeHouseKey)
	ElseIf PlayerRef.GetItemCount(MS11HjerimKey) > 0
		Eviction.OwnsWindhelm = true
		LicUtil.OwnsProperty = true
		RemoveInventoryEventFilter(MS11HjerimKey)
	ElseIf PlayerRef.GetItemCount(RiftenHoneysideKey) > 0
		Eviction.OwnsRiften = true
		LicUtil.OwnsProperty = true
		RemoveInventoryEventFilter(RiftenHoneysideKey)
	ElseIf PlayerRef.GetItemCount(MarkarthVlindrelHallKey) > 0
		Eviction.OwnsMarkarth = true
		LicUtil.OwnsProperty = true
		RemoveInventoryEventFilter(MarkarthVlindrelHallKey)
	EndIf
	KnockPlayerScript = PlayerAliasKnockQuest as SLS_KnockPlayerScript
	
	;SaveMerchantGoldDefaults()
	IneqVendorGoldUpdate()
	SetHelloExclusions()
	
	RegForEvents()
	StorageUtil.SetIntValue(None, "_SLS_BedrollTutorial", 1)
	SetupTypeStates()
	SetupHighlightEffectShaders()
	SetupPercentileEffectShaders()
	Debug.Notification("SL Survival " + Menu.AllInOne.SnipToDecimalPlaces(StrInput = Version as String, Places = 3) + " Installed. Starting interfaces in 20 sec")
	RegisterForSingleUpdate(15.0)
EndEvent

Event OnUpdate()
	;/
	RndInterface.PlayerLoadsGame()
	Ineed.PlayerLoadsGame()
	Slaverun.PlayerLoadsGame()
	PaySexCrime.PlayerLoadsGame()
	Frostfall.PlayerLoadsGame()
	Devious.PlayerLoadsGame()
	Eff.PlayerLoadsGame()
	/;
	SendModEvent("_SLS_Int_PlayerLoadsGame")
EndEvent

Event OnPlayerLoadGame()
	VersionCheck()
	;Debug.Notification("KS: " + Init.KennelState)
	If Game.GetModByName("Mortal Weapons & Armor.esp") == 255
		_MWA_FittingArmorCount.SetValueInt(-1)
	EndIf
	LoadGameMaintenance()	
	RegForEvents()
	KnockPlayerScript = PlayerAliasKnockQuest as SLS_KnockPlayerScript
	
	;/
	RegisterForModEvent("_SLS_LicenceIssuedEvent", "On_SLS_LicenceIssuedEvent")
	Int GetLicence = ModEvent.Create("_SLS_IssueLicence")
	If (GetLicence)
		ModEvent.PushInt(GetLicence, 0)
		ModEvent.PushInt(GetLicence, 1)
		ModEvent.PushForm(GetLicence, PlayerRef)
		ModEvent.PushForm(GetLicence, PlayerRef)
		ModEvent.PushBool(GetLicence, true)
		ModEvent.PushForm(GetLicence, Self.GetOwningQuest())
		ModEvent.Send(GetLicence)
	EndIf
	/;
EndEvent
;/
Event On_SLS_LicenceIssuedEvent(Form Licence, Int LicenceType, Int TermDuration, Form RequestingMod)
	Debug.Messagebox("Licence: " + (Licence as ObjectReference) + ". LicenceType: " + LicenceType + ". TermDuration: " + TermDuration + ". RequestingMod: " + RequestingMod)
EndEvent
/;
Function RegForEvents()
	RegisterForModEvent("HookAnimationStarting", "OnAnimationStarting")
	RegisterForModEvent("HookAnimationEnding", "OnAnimationEnding")
	
	If Init.MmeInstalled
		RegisterForModEvent("MME_MilkCycleComplete", "OnMME_MilkCycleComplete")
		RegisterForModEvent("DeviceVibrateEffectStart", "OnDeviceVibrateEffectStart")
	EndIf
	
	If Init.FrostfallInstalled
		RegisterForModEvent("Frost_OnRescuePlayer", "Frost_OnRescuePlayer")
		RegisterForModEvent("Frostfall_OnPlayerStartSwimming", "Frostfall_OnPlayerStartSwimming")
		RegisterForModEvent("Frostfall_OnPlayerStopSwimming", "Frostfall_OnPlayerStopSwimming")
	EndIf
	
	RegisterForModEvent("HookOrgasmEnd", "OnOrgasmEnd")
EndFunction

Function LoadGameMaintenance()
	UiExtensionsCheck()
	Init.PlayerLoadsGame()
	;Debug.Messagebox("0xFEFFFFFD: " + 0xFEFFFFFD +"\n0xFEFFFFFE: " + 0xFEFFFFFE + "\n0xFEFFFFFF: " + 0xFEFFFFFF + "\n\n0xFF000000: " + 0xFF000000 + "\n0xFF000001: " + 0xFF000001 + "\n0xFFFFFFFE: " + 0xFEFFFFFE + "\n0xFFFFFFFF: " + 0xFFFFFFFF)
	
	;Int Index = Math.RightShift(Math.LogicalAnd(0xFF000001, 0xFF000000), 24)
	;Debug.Messagebox(Index)
	
	;/
	Int LoadEvent = ModEvent.Create("_SLS_Int_PlayerLoadsGame")
    If (LoadEvent)
        ModEvent.Send(LoadEvent)
    EndIf
	/;
	SendModEvent("_SLS_Int_PlayerLoadsGame")


	_SLS_LicInspLostSightSpell.SetNthEffectDuration(0, _SLS_LicInspPersistence.GetValueInt())
	If Menu.GoldWeight > 0.0
		Gold001.SetWeight(Menu.GoldWeight)
	EndIf
	BarefootMaintenance()
	IneqVendorGoldUpdate()
	Menu.SetGagSpeechDebuff()
	Menu.CumAddict.LoadGameMaintenance()
	If !(Game.GetFormFromFile(0x0DBD29, "SL Survival.esp") as Quest).IsRunning() && StorageUtil.GetFloatValue(None, "yps_TweakVersion", Missing = -1.0) >= 1.0 ; FashionRape quest is not running and tweak is installed
		(Game.GetFormFromFile(0x0DBD29, "SL Survival.esp") as Quest).Start()
	EndIf
	
	BikinifierHalfNakedArmor = _SLS_NeverAddedArmor
	If Game.GetModByName("Bikinifier.esp") != 255
		BikinifierHalfNakedArmor = Game.GetFormFromFile(0x04C8F8, "Bikinifier.esp") as Armor
	EndIf
	Menu.AllInOne.LoadGameMaintenance()
	;Debug.Messagebox(_SLS_LoadGameTestObject.GetWorldModelPath())
	
	_SLS_BikiniBreakCustomCount.SetValueInt((MiscUtil.FilesInFolder("Data/skse/Plugins/StorageUtilData/SL Survival/BikBreak/Custom/", extension = "json")).Length)
	If _SLS_LoadGameTestObject.GetWorldModelPath() == "DefaultState.nif"
		;Debug.Messagebox("DOING Game Session load maintenance")
		DoGameSessionLoadMaintenance()
	;Else
		;Debug.Messagebox("Game Session load maintenance NOT needed!")
	EndIf
	
EndFunction

Function DoGameSessionLoadMaintenance()
	BikiniBreak.DoOncePerGameSessionLoad()
	_SLS_LoadGameTestObject.SetWorldModelPath("ModifiedState.nif")
	;Debug.Messagebox("Game Session load maintenance complete!")
EndFunction

Function VersionCheck()
	If Version < 0.685
		If Version < 0.560
			Menu.BuildSplashArray()
			Version = 0.560
		EndIf
		
		If Version < 0.562
			Menu.BuildPages()
			Version = 0.562
		EndIf
		
		If Version < 0.566
			If Game.GetModByName("sr_FillHerUp.esp") != 255
				Menu.CumSwallowInflate = true
				(Game.GetFormFromFile(0x063A97, "SL Survival.esp") as Quest).Stop() ; FHU
				Utility.WaitMenuMode(0.2)
				(Game.GetFormFromFile(0x063A97, "SL Survival.esp") as Quest).Start()
				Debug.Messagebox("SL Survival: As part of the update process the FHU interface will be restarted. Please save your game, reload it and wait 5 seconds for the interface to start up")
			Else
				Menu.CumSwallowInflate = false
			EndIf
			
			Quest CurseQuest = Game.GetFormFromFile(0x063A8C, "SL Survival.esp") as Quest
			CurseQuest.Stop()
			Utility.Wait(0.1)
			CurseQuest.Start()
			PlayerRef.AddSpell(_SLS_BarefootSpeedSpell, false)
			If Menu.MinAvToggleT
				PlayerRef.AddSpell(Game.GetFormFromFile(0x0732E5, "SL Survival.esp") as Spell, false)
			EndIf
			Version = 0.566
		EndIf
		
		If Version < 0.567
			Menu.SetInequalityEffects()
			Menu._SLS_InequalityRefreshQuest.Stop()
			Menu._SLS_InequalityRefreshQuest.Start()
			Menu.BuildPages()
			Utility.Wait(3.0)
			Menu.RefreshBikiniExpEffects()
			Version = 0.567
		EndIf
		
		If Version < 0.568
			Quest QuestSelect = Game.GetFormFromFile(0x063A8C, "SL Survival.esp") as Quest
			QuestSelect.Stop()
			Utility.Wait(0.1)
			QuestSelect.Start()
			Menu.SetupMenuArrays()
			Menu.AddWearableLanternExceptions()
			Version = 0.568
		EndIf
		
		If Version < 0.569
			LicUtil.BuildBuyBackPerkArray()
			Menu.SetupMenuArrays()
			Version = 0.569
		EndIf
		
		If Version < 0.570
			If Menu.MinAvToggleT
				Quest MinAvQuest = Game.GetFormFromFile(0x026E22, "SL Survival.esp") as Quest
				SLS_MinAv MinAv = ((MinAvQuest.GetNthAlias(0) as ReferenceAlias) as SLS_MinAv)
				MinAv.RegForEvents()
				MinAv.ShutDown()
				MinAv.StartUp()
			EndIf
			Version = 0.570
		EndIf
		
		If Version < 0.571
			Menu.BuildSexOptionsArrays()
			Menu.SetupMenuArrays()
			(Game.GetFormFromFile(0x07EF9A, "SL Survival.esp") as Quest).Stop() ; Devious followers
			Utility.Wait(0.1)
			(Game.GetFormFromFile(0x07EF9A, "SL Survival.esp") as Quest).Start()
			Utility.Wait(0.1)
			Dflow.PlayerLoadsGame()
			
			(Game.GetFormFromFile(0x03EADE, "SL Survival.esp") as Quest).Stop() ; iNeed
			Utility.Wait(0.1)
			(Game.GetFormFromFile(0x03EADE, "SL Survival.esp") as Quest).Start()
			Utility.Wait(0.1)
			Needs.Ineed.PlayerLoadsGame()
			
			(Game.GetFormFromFile(0x03AA30, "SL Survival.esp") as Quest).Stop() ; RND
			Utility.Wait(0.1)
			(Game.GetFormFromFile(0x03AA30, "SL Survival.esp") as Quest).Start()
			Utility.Wait(0.1)
			Needs.Rnd.PlayerLoadsGame()
			
			;SaveMerchantGoldDefaults()
			;IneqVendorGoldUpdate()
			
			Quest QuestSelect = Game.GetFormFromFile(0x0850D2, "SL Survival.esp") as Quest
			QuestSelect.Stop()
			Utility.Wait(0.1)
			QuestSelect.Start()
			Version = 0.571
		EndIf
		
		If Version < 0.572
			If Menu.MinAvToggleT
				PlayerRef.RemoveSpell(Menu._SLS_WeaponReadySpell)
				Utility.Wait(0.1)
				PlayerRef.Addspell(Menu._SLS_WeaponReadySpell, false)
				Menu.BuildPages()
				Menu.SetupMenuArrays()
				Menu.ToggleProxSpank()
				(Game.GetFormFromFile(0x0850D2, "SL Survival.esp") as _SLS_Api).RegisterForEvents()
			EndIf
			Version = 0.572
		EndIf
		
		If Version < 0.574
			Menu.BuildPages()
			Menu.SetupMenuArrays()
			Version = 0.574
		EndIf
		
		If Version < 0.575
			Menu.BuildPages()
			Version = 0.575
		EndIf
		
		If Version < 0.579
			(Game.GetFormFromFile(0x07EF9A, "SL Survival.esp") as Quest).Stop() ; Devious followers
			(Game.GetFormFromFile(0x07EF9A, "SL Survival.esp") as Quest).Start()
			Menu.CumAddict.RegForEvents()
			Menu.SetupMenuArrays()
			Menu.ToggleCoverMechanics()
			Version = 0.579
		EndIf
		
		If Version < 0.581
			Menu.TogglePpSleepNpcPerk()
			Menu.BuildPages()
			Menu.SetupMenuArrays()
			Menu.ToggleSexExp()
			Version = 0.581
		EndIf
		
		If Version < 0.582
			StorageUtil.SetIntValue(None, "_SLS_CreatureCorruption", StorageUtil.GetIntValue(None, "_SLS_CreatureSexOrgasmCount", Missing = 0) - StorageUtil.GetIntValue(PlayerRef, "_SLS_CleansedCorruption", Missing = 0))
			StorageUtil.UnsetIntValue(PlayerRef, "_SLS_CleansedCorruption")
			Version = 0.582
		EndIf
		
		If Version < 0.583
			StorageUtil.SetIntValue((Game.GetFormFromFile(0x131F0, "Skyrim.esm") as Race), "_SLS_LoadSize", 4)
			Int i = StorageUtil.FormListCount(None, "_SLS_HumanSexForms")
			Race RaceCat
			While i > 0
				i -= 1
				RaceCat = StorageUtil.FormListGet(None, "_SLS_HumanSexForms", i) as Race
				If !RaceCat.IsRaceFlagSet(0x00000001)
					StorageUtil.AdjustIntValue(None, "_SLS_SexExperienceGenericFemale", StorageUtil.GetIntValue(RaceCat, "_SLS_SexExperienceFemale", Missing = 0))
					StorageUtil.AdjustIntValue(None, "_SLS_SexExperienceGenericMale", StorageUtil.GetIntValue(RaceCat, "_SLS_SexExperienceMale", Missing = 0))
					StorageUtil.UnSetIntValue(RaceCat, "_SLS_SexExperienceFemale")
					StorageUtil.UnSetIntValue(RaceCat, "_SLS_SexExperienceMale")
					StorageUtil.FormListRemoveAt(None, "_SLS_HumanSexForms", i)
				EndIf
			EndWhile
			Version = 0.583
		EndIf

		If Version < 0.588
			;Menu.BuildPages()
			Menu.SetupMenuArrays()
			Needs.EatSleepDrink.PlayerLoadsGame()
			Menu.Needs.OnInit()
			Menu.ToggleSleepDepriv()
			Menu.ReplaceVanillaMaps(Menu.ReplaceMaps)
			UI.SetNumber("HUD Menu", "_root.HUDMovieBaseInstance.CompassShoutMeterHolder._alpha", 100.0)
			UI.SetNumber("HUD Menu", "_root.HUDMovieBaseInstance.CompassShoutMeterHolder.Compass.DirectionRect._alpha", 100.0)
			UI.SetNumber("HUD Menu", "_root.HUDMovieBaseInstance.CompassShoutMeterHolder.Compass.CompassFrame._alpha", 100.0)
			(((Game.GetFormFromFile(0x04A8A2, "SL Survival.esp") as Quest).GetNthAlias(0)) as _SLS_MapAndCompassAlias).ReinitNav()
			(Game.GetFormFromFile(0x0420BB, "SL Survival.esp") as Quest).UpdateCurrentInstanceGlobal(Game.GetFormFromFile(0x0AC928, "SL Survival.esp") as GlobalVariable)
			Version = 0.588
		EndIf
		
		If Version < 0.589
			Menu.SetupMenuArrays()
			(((Game.GetFormFromFile(0x04A8A2, "SL Survival.esp") as Quest).GetNthAlias(0)) as _SLS_MapAndCompassAlias).ResetCompass()
			Version = 0.589
		EndIf
		
		If Version < 0.590
			Devious.RunPonyGearPatchUp()
			Version = 0.590
		EndIf
		
		If Version < 0.591
			Menu.CumAddict._SLS_CumAddictAutoSuckCooldownQuest.Stop()
			Version = 0.591
		EndIf
		
		If Version < 0.594
			Menu.ModName = "Sexlab Survival"
			Util.RegForEvents()
			Menu.BuildPages()
			Menu.SetupMenuArrays()
			Quest QuestSelect = Game.GetFormFromFile(0x03CA81, "SL Survival.esp") as Quest ; Frostfall
			QuestSelect.Stop()
			QuestSelect.Start()
			QuestSelect = Game.GetFormFromFile(0x0A8DCD, "SL Survival.esp") as Quest ; STA
			QuestSelect.Stop()
			QuestSelect.Start()
			QuestSelect = Game.GetFormFromFile(0x03AA30, "SL Survival.esp") as Quest ; Rnd
			QuestSelect.Stop()
			QuestSelect.Start()
			QuestSelect = Game.GetFormFromFile(0x07995C, "SL Survival.esp") as Quest ; Milk addict
			QuestSelect.Stop()
			QuestSelect.Start()
			QuestSelect = Game.GetFormFromFile(0x063A98, "SL Survival.esp") as Quest ; FHU
			QuestSelect.Stop()
			QuestSelect.Start()
			LicUtil.SetupSlotMasks()
			LicUtil.SetupLicTypeStrArray()
			Menu.CumAddict.UnRegisterForAllKeys()
			Menu.CumSwallow.UnRegisterForAllKeys()
			Menu.CoverMySelf.UnRegisterForAllKeys()
			Menu.SetupMenuArrays()
			Menu.HalfNakedCover.SlotMasks[31] = 0x80000000
			LicUtil.SetupSlotMasks()
			(((Game.GetFormFromFile(0x063A8C, "SL Survival.esp") as Quest).GetNthAlias(0) as ReferenceAlias) as _SLS_LicBikiniCurse).BuildSlotMasks()
			Version = 0.594
		EndIf
		
		If Version < 0.595
			Menu._SLS_LicenceAliases = Game.GetFormFromFile(0x0C3176, "SL Survival.esp") as Quest
			LicUtil._SLS_LicenceAliases = Game.GetFormFromFile(0x0C3176, "SL Survival.esp") as Quest
			Version = 0.595
		EndIf
		
		If Version < 0.596
			Quest DevEffQuest = Game.GetFormFromFile(0x04F44A, "SL Survival.esp") as Quest
			DevEffQuest.Stop()
			If Menu.DeviousEffectsEnable
				DevEffQuest.Start()
			EndIf
			PlayerRef.AddSpell(Game.GetFormFromFile(0x06D1AF, "SL Survival.esp") as Spell, false) ; _SLS_CombatChangeDetectSpell
			Version = 0.596
		EndIf
		
		If Version < 0.597
			If (Game.GetFormFromFile(0x097F8F, "SL Survival.esp") as Quest).IsRunning() ;_SLS_CumAddictQuest
				Spell CumHungerSpell = Game.GetFormFromFile(0x0984FF, "SL Survival.esp") as Spell
				PlayerRef.RemoveSpell(CumHungerSpell)
				Utility.Wait(1.0)
				PlayerRef.AddSpell(CumHungerSpell, false)
			EndIf
			Version = 0.597
		EndIf
		
		If Version < 0.598
			Quest CumDesperateQ = Game.GetFormFromFile(0x0C4703, "SL Survival.esp") as Quest
			(((CumDesperateQ).GetNthAlias(0) as ReferenceAlias) as _SLS_CumDesperateEffects).UnRegisterForAllMenus()
			CumDesperateQ.Stop()
			Version = 0.598
		EndIf
		
		If Version < 0.6000
			Quest DeviousIntQuest = Game.GetFormFromFile(0x040068, "SL Survival.esp") as Quest
			DeviousIntQuest.Stop()
			DeviousIntQuest.Start()
			Version = 0.600
		EndIf
		
		If Version < 0.602
			;If Game.GetModByName("Slaverun_Reloaded.esp") != 255
				;(Game.GetFormFromFile(0x03F041, "SL Survival.esp") as _SLS_InterfaceSlaverun).LastTracker = Game.GetFormFromFile(0x0CD3FE, "SL Survival.esp") as ObjectReference
				;(Game.GetFormFromFile(0x0CCE64, "SL Survival.esp") as Quest).Start(); _SLS_TownLocTrackQuest
				;(Game.GetFormFromFile(0x03F041, "SL Survival.esp") as _SLS_SlaverunLocResolver).Setup()
			;EndIf
			Debug.Messagebox("SLS v0.602: Please save and reload your game to complete the update process")
			Debug.Notification("Survival updated to 0.602")
			Version = 0.602
		EndIf
		
		If Version < 0.607
			PlayerRef.AddSpell(Game.GetFormFromFile(0x0CF9B0, "SL Survival.esp") as Spell) ; Jiggles
			LicUtil.SetupLicTypeStrArray() ; Added new licence types
			(Game.GetFormFromFile(0x03F041, "SL Survival.esp") as Quest).Stop() ; Slaverun interface
			(Game.GetFormFromFile(0x03F041, "SL Survival.esp") as Quest).Start()
			(Game.GetFormFromFile(0x0D357B, "SL Survival.esp") as GlobalVariable).SetValue(StorageUtil.GetFloatValue(None, "_SLS_CreatureCorruption", Missing = 0.0)) ; _SLS_CreatureCorruptionGlob
			
			; Changed kennel. Move kennel stuff that won't move
			ObjectReference KennelChest = Game.GetFormFromFile(0x02C170, "SL Survival.esp") as ObjectReference
			ObjectReference TempStorage = Game.GetFormFromFile(0x0D2FE4, "SL Survival.esp") as ObjectReference ; Storage cell temp barrel
			KennelChest.RemoveAllItems(akTransferTo = TempStorage, abKeepOwnership = true, abRemoveQuestItems = true)
			KennelChest.Reset()
			TempStorage.RemoveAllItems(akTransferTo = TempStorage, abKeepOwnership = true, abRemoveQuestItems = true)
			(Game.GetFormFromFile(0x28B26, "SL Survival.esp") as ObjectReference).Reset() ; Kennel door to whiterun
			(Game.GetFormFromFile(0x02C170, "SL Survival.esp") as ObjectReference).Reset() ; Kennel chest
			If Eviction.OwnsWhiterun || Eviction.OwnsSolitude || Eviction.OwnsWindhelm || Eviction.OwnsRiften || Eviction.OwnsMarkarth
				LicUtil.OwnsProperty = true
			EndIf
			
			(Menu._SLS_LicenceAliases.GetNthAlias(32) as ReferenceAlias).ForceRefTo(Game.GetFormFromFile(0x0D09E1, "SL Survival.esp") as ObjectReference)
			(Menu._SLS_LicenceAliases.GetNthAlias(33) as ReferenceAlias).ForceRefTo(Game.GetFormFromFile(0x0D09E2, "SL Survival.esp") as ObjectReference)
			(Menu._SLS_LicenceAliases.GetNthAlias(34) as ReferenceAlias).ForceRefTo(Game.GetFormFromFile(0x0D1A21, "SL Survival.esp") as ObjectReference)
			(Menu._SLS_LicenceAliases.GetNthAlias(35) as ReferenceAlias).ForceRefTo(Game.GetFormFromFile(0x0D1A22, "SL Survival.esp") as ObjectReference)
			
			(Menu._SLS_LicenceAliases.GetNthAlias(41) as ReferenceAlias).ForceRefTo(Game.GetFormFromFile(0x0D09E3, "SL Survival.esp") as ObjectReference)
			(Menu._SLS_LicenceAliases.GetNthAlias(42) as ReferenceAlias).ForceRefTo(Game.GetFormFromFile(0x0D09E4, "SL Survival.esp") as ObjectReference)
			(Menu._SLS_LicenceAliases.GetNthAlias(43) as ReferenceAlias).ForceRefTo(Game.GetFormFromFile(0x0D1A23, "SL Survival.esp") as ObjectReference)
			(Menu._SLS_LicenceAliases.GetNthAlias(44) as ReferenceAlias).ForceRefTo(Game.GetFormFromFile(0x0D1A24, "SL Survival.esp") as ObjectReference)
			
			(Menu._SLS_LicenceAliases.GetNthAlias(50) as ReferenceAlias).ForceRefTo(Game.GetFormFromFile(0x0D09E5, "SL Survival.esp") as ObjectReference)
			(Menu._SLS_LicenceAliases.GetNthAlias(51) as ReferenceAlias).ForceRefTo(Game.GetFormFromFile(0x0D09E6, "SL Survival.esp") as ObjectReference)
			(Menu._SLS_LicenceAliases.GetNthAlias(52) as ReferenceAlias).ForceRefTo(Game.GetFormFromFile(0x0D1A25, "SL Survival.esp") as ObjectReference)
			(Menu._SLS_LicenceAliases.GetNthAlias(53) as ReferenceAlias).ForceRefTo(Game.GetFormFromFile(0x0D1A26, "SL Survival.esp") as ObjectReference)
			;Debug.Messagebox("Survival updated to 0.607.\nPlease Save and reload to complete the update")
			Version = 0.607
		EndIf
		
		If Version < 0.609
			Menu.BuildPages()
			(Game.GetFormFromFile(0x0C8D0E, "SL Survival.esp") as Quest).Stop() ; Sos Interface
			(Game.GetFormFromFile(0x0C8D0E, "SL Survival.esp") as Quest).Start()
			;Debug.Messagebox("Survival updated to 0.609.\nPlease Save and reload to complete the update")
			Version = 0.609
		EndIf
		
		If Version < 0.613
			StorageUtil.SetIntValue(None, "_SLS_BedrollTutorial", 1)
			(Game.GetFormFromFile(0x0850D2, "SL Survival.esp") as _SLS_Api).RegisterForEvents()
			(Game.GetFormFromFile(0x0A628B, "SL Survival.esp") as _SLS_SexExperience).RegisterForEvents()
			(Game.GetFormFromFile(0x0CF9B1, "SL Survival.esp") as _SLS_BodyInflationTracking).RegisterForEvents()
			Util.SetupSwEffectsList()
			Debug.Notification("Survival updated to 0.613")
			Version = 0.613
		EndIf
		
		If Version < 0.615
			(Game.GetFormFromFile(0x0CCE64, "SL Survival.esp") as Quest).Start() ; _SLS_TownLocTrackQuest
			Menu.BuildPages()
			Menu.BuildSplashArray()
			Debug.Notification("Survival updated to 0.615")
			Version = 0.615
		EndIf
		
		If Version < 0.616
			Menu.LocTrack.SetupInnPrices()
			Menu.LocTrack.SetupLists()
			(Game.GetFormFromFile(0x0CCE64, "SL Survival.esp") as Quest).Stop() ; _SLS_TownLocTrackQuest
			(Game.GetFormFromFile(0x0CCE64, "SL Survival.esp") as Quest).Start()
			Debug.Notification("Survival updated to 0.616")
			Version = 0.616
		EndIf
		
		If Version < 0.617
			(Game.GetFormFromFile(0x0E3F3D, "SL Survival.esp") as _SLS_Curfew).RegisterForEvents() ; _SLS_CurfewQuest
			Menu.TollUtil._SLS_GateCurfewSlavetownBegin = Game.GetFormFromFile(0x0EE155, "SL Survival.esp") as GlobalVariable
			Menu.TollUtil._SLS_GateCurfewSlavetownEnd = Game.GetFormFromFile(0x0EE156, "SL Survival.esp") as GlobalVariable
			Debug.Notification("Survival updated to 0.617")
			Version = 0.617
		EndIf
		
		If Version < 0.619
			(Game.GetFormFromFile(0x0CCE64, "SL Survival.esp") as Quest).Stop() ; _SLS_TownLocTrackQuest
			(Game.GetFormFromFile(0x0CCE64, "SL Survival.esp") as Quest).Start()
			Debug.Notification("Survival updated to 0.619")
			Version = 0.619
		EndIf
		
		If Version < 0.621
			(Game.GetFormFromFile(0x0E7553, "SL Survival.esp") as Quest).Stop()
			Menu.BuildPages()
			Debug.Notification("Survival updated to 0.621")
			Version = 0.621
		EndIf
		
		If Version < 0.627
			StorageUtil.UnSetIntValue(Menu, "TraumaEnable")
			Menu.ToggleCurfew(LicUtil.LicCurfewEnable)
			Debug.Notification("Survival updated to 0.627")
			Version = 0.627
		EndIf
		
		If Version < 0.628
			LicUtil.GetIsAtLeastOneLicenceAvailable()
			LicUtil.UpdateGlobalLicVariables()
			Debug.Notification("Survival updated to 0.628")
			Version = 0.628
		EndIf
		
		If Version < 0.634
			Menu.CumAddict.InitCumPotionIndexLists()
			Menu.CumAddict.RegForEvents()
			Menu.AllInOne.TongueCleanup(PlayerRef)
			Sexlab.ClearCum(PlayerRef)
			Menu.BuildSexOptionsArrays()
			Debug.Notification("Survival updated to 0.634")
			Version = 0.634
		EndIf
		
		If Version < 0.642
			(Game.GetFormFromFile(0x07DF73, "SL Survival.esp") as Quest).Stop() ; SLAX interface
			(Game.GetFormFromFile(0x07DF73, "SL Survival.esp") as Quest).Start()
			
			(Game.GetFormFromFile(0x0FCE71, "SL Survival.esp") as _SLS_Ahegao).EndAhegao() ; _SLS_AhegaoQuest - Stop possible updates that never stopped. 
			
			If Menu._SLS_IneqStat.GetValueInt() == 1
				Menu._SLS_InequalityRefreshQuest.Stop()
				Menu._SLS_InequalityRefreshQuest.Start()
				Utility.Wait(1.0)
				Menu._SLS_InequalityRefreshQuest.Stop()
			EndIf
			StorageUtil.SetIntValue(Menu.AllInOne, "SetOverlaysHelp", 1)
			StorageUtil.SetIntValue(Menu.AllInOne, "GetKeywordsOnTargetHelp", 1)
			Menu.ToggleJiggles()
			SetHelloExclusions()
			StorageUtil.SetIntValue(Util, "ArmorBreakdownHelp", 1)
			Util.Api.SetupQuartermasters()
			Debug.Notification("Survival updated to 0.642")			
			Version = 0.642
		EndIf
		
		If Version < 0.644
			LicUtil.CheckAllLicencesExpiry()
			LicUtil.SetMagicCurseGlobalStatus()
			Util.Api.RegisterForEvents()
			Menu.AllInOne.BuildLicGlobalArray()
			Debug.Notification("Survival updated to 0.644")
			Version = 0.644
		EndIf
		
		If Version < 0.645
			(Game.GetFormFromFile(0x104511, "SL Survival.esp") as Quest).Start()
			Debug.Notification("Survival updated to 0.645")
			Version = 0.645
		EndIf
		
		If Version < 0.657
			BikiniBreak = Game.GetFormFromFile(0x10D7AF, "SL Survival.esp") as _SLS_BikiniBreak
			Menu.BuildPages()
			Menu.SetupMenuArrays()
			Quest Interface = Game.GetFormFromFile(0x063A98, "SL Survival.esp") as Quest ;  FhuInt
			Interface.Stop()
			Interface.Start()
			Interface = Game.GetFormFromFile(0x0707CE, "SL Survival.esp") as Quest
			(Game.GetFormFromFile(0x01C58E, "SL Survival.esp") as Quest).Stop() ; _SLS_PushPlayer
			(Game.GetFormFromFile(0x0E651A, "SL Survival.esp") as Quest).Stop() ; _SLS_PushPlayerProximity
			(Game.GetFormFromFile(0x02C170, "SL Survival.esp") as ObjectReference).MoveToMyEditorLocation() ; Kennel storage chest
			Menu.TogglePushPlayer()
			Menu.Trauma.ClearAllTraumaOverlays()
			(((Game.GetFormFromFile(0x006894, "SL Survival.esp") as Quest).GetNthAlias(0)) as SLS_StashTrackPlayer).LoadStashVariables() ; _SLS_StashTrack
			(((Game.GetFormFromFile(0x006894, "SL Survival.esp") as Quest).GetNthAlias(0)) as SLS_StashTrackPlayer).ResetAllContainerDiscoverabilityVars() ; _SLS_StashTrack
			(((Game.GetFormFromFile(0x006894, "SL Survival.esp") as Quest).GetNthAlias(0)) as SLS_StashTrackPlayer).ImportStashExceptions() ; _SLS_StashTrack
			(Game.GetFormFromFile(0x0850D2, "SL Survival.esp") as _SLS_Api).RegisterForEvents()
			Utility.Wait(4.0)
			SendModEvent("_SLS_Int_PlayerLoadsGame")
			UpdateVersion(0.657)
		EndIf
		
		If Version < 0.659
			(Game.GetFormFromFile(0x0707CE, "SL Survival.esp") as Quest).Stop() ; Apropos2 interface
			(Game.GetFormFromFile(0x0707CE, "SL Survival.esp") as Quest).Start()
			Menu.SetupMenuArrays()
			Utility.Wait(4.0)
			SendModEvent("_SLS_Int_PlayerLoadsGame")
			UpdateVersion(0.659)
		EndIf
		
		If Version < 0.661
			StorageUtil.SetIntValue(None, "_SLS_KennelCellDoorHelp", 1)
			If (Game.GetFormFromFile(0x0E857D, "SL Survival.esp") as Quest).IsRunning()
				(Game.GetFormFromFile(0x0E857D, "SL Survival.esp") as _SLS_OrgasmFatigue).RegisterForEvents()
			EndIf
			UpdateVersion(0.661)
		EndIf
		
		If Version < 0.668
			Menu._SLS_AnimalFriendQuest.Stop()
			Menu._SLS_AnimalFriendQuest.Start()
			Menu.AllInOne.Fav.BuildFavorites()
			Menu.AllInOne._SLS_SubmitAliases = Game.GetFormFromFile(0x11699B, "SL Survival.esp") as Quest
			If Menu.AnimalBreedEnable
				PlayerRef.AddPerk(Game.GetFormFromFile(0x11CFFF, "SL Survival.esp") as Perk) ; _SLS_WildlingPerk
				Menu.AnimalFriend.RegInitEvents()
			EndIf
			Util.UnRegisterForModEvent("_SLS_SwallowCum")
			(Game.GetFormFromFile(0x0850D2, "SL Survival.esp") as _SLS_Api).RegisterForEvents()
			UpdateVersion(0.668)
		EndIf
		
		If Version < 0.671
			Menu.ForceDrug.TollDrugSensitivity = Game.GetModByName("SLSO.esp") != 255
			Menu.ForceDrug.RapeDrugSensitivity = Menu.ForceDrug.TollDrugSensitivity
			Util.Api.RegisterForEvents()
			(Game.GetFormFromFile(0x0E857D, "SL Survival.esp") as _SLS_OrgasmFatigue).RegisterForEvents()
			UpdateVersion(0.671)
		EndIf
		
		If Version < 0.674
			Util.Api.RegisterForEvents()
			StorageUtil.SetFloatValue(None, "_SLS_CreatureCorruption", StorageUtil.GetIntValue(None, "_SLS_CreatureCorruption", Missing = 0))
			StorageUtil.UnSetIntValue(None, "_SLS_CreatureCorruption")
			UpdateVersion(0.674)
		EndIf
		(Game.GetFormFromFile(0x0E857D, "SL Survival.esp") as _SLS_OrgasmFatigue)
		
		If Version < 0.682
			((Game.GetFormFromFile(0x0E857D, "SL Survival.esp") as Quest).GetNthAlias(0) as ReferenceAlias).ForceRefTo(PlayerRef)
			Menu.AnimalFriend.Wildling.Friend = Menu.AnimalFriend
			SetupTypeStates()
			UpdateVersion(0.682)
		EndIf

		If Version < 0.685
			StorageUtil.FormListClear(None, "_SLS_HighlightedItemsList")
			SetupHighlightEffectShaders()
			SetupPercentileEffectShaders()
			(Game.GetFormFromFile(0x07DF73, "SL Survival.esp") as _SLS_InterfaceSlax).RestartInterface()
			UpdateVersion(0.685)
		EndIf
	EndIf
EndFunction

Function UpdateVersion(Float UpgradeVersion)
	Version = UpgradeVersion
	Util.Api.SetVersion(UpgradeVersion)
	Debug.Notification("Survival updated to v" + Menu.AllInOne.SnipToDecimalPlaces(UpgradeVersion as String, 3))
EndFunction

Function SetupTypeStates()
	StorageUtil.SetStringValue(None, "_SLS_TypeState_26", "kArmor")
	StorageUtil.SetStringValue(None, "_SLS_TypeState_41", "kWeapon")
	StorageUtil.SetStringValue(None, "_SLS_TypeState_42", "kAmmo")
	StorageUtil.SetStringValue(None, "_SLS_TypeState_32", "kMisc")
	StorageUtil.SetStringValue(None, "_SLS_TypeState_23", "kScrollItem")
	StorageUtil.SetStringValue(None, "_SLS_TypeState_27", "kBook")
	StorageUtil.SetStringValue(None, "_SLS_TypeState_46", "kPotion")
	StorageUtil.SetStringValue(None, "_SLS_TypeState_45", "kKey")
	StorageUtil.SetStringValue(None, "_SLS_TypeState_39", "kFlora")
	StorageUtil.SetStringValue(None, "_SLS_TypeState_50", "kProjectile")
	StorageUtil.SetStringValue(None, "_SLS_TypeState_52", "kSoulGem")
	StorageUtil.SetStringValue(None, "_SLS_TypeState_30", "kIngredient") 
EndFunction

Function SetupHighlightEffectShaders()
	StorageUtil.SetFormValue(None, "_SLS_EffectShaderType_26", Game.GetFormFromFile(0x128C93, "SL Survival.esp")) ; Armor
	StorageUtil.SetFormValue(None, "_SLS_EffectShaderType_41", Game.GetFormFromFile(0x128C94, "SL Survival.esp")) ; Weapon
	StorageUtil.SetFormValue(None, "_SLS_EffectShaderType_42", Game.GetFormFromFile(0x129759, "SL Survival.esp")) ; Ammo
	StorageUtil.SetFormValue(None, "_SLS_EffectShaderType_32", Game.GetFormFromFile(0x129CBC, "SL Survival.esp")) ; Misc
	StorageUtil.SetFormValue(None, "_SLS_EffectShaderType_23", Game.GetFormFromFile(0x129CBD, "SL Survival.esp")) ; Scroll
	StorageUtil.SetFormValue(None, "_SLS_EffectShaderType_27", Game.GetFormFromFile(0x129CBE, "SL Survival.esp")) ; Book
	StorageUtil.SetFormValue(None, "_SLS_EffectShaderType_46", Game.GetFormFromFile(0x129CBF, "SL Survival.esp")) ; Potion
	StorageUtil.SetFormValue(None, "_SLS_EffectShaderType_45", Game.GetFormFromFile(0x129CC0, "SL Survival.esp")) ; Key
	StorageUtil.SetFormValue(None, "_SLS_EffectShaderType_39", Game.GetFormFromFile(0x12ACE9, "SL Survival.esp")) ; Flora
	StorageUtil.SetFormValue(None, "_SLS_EffectShaderType_50", Game.GetFormFromFile(0x129759, "SL Survival.esp")) ; Projectile
	StorageUtil.SetFormValue(None, "_SLS_EffectShaderType_52", Game.GetFormFromFile(0x12D2B6, "SL Survival.esp")) ; Soulgem
	StorageUtil.SetFormValue(None, "_SLS_EffectShaderType_30", Game.GetFormFromFile(0x12D81C, "SL Survival.esp")) ; Ingredient
EndFunction

Function SetupPercentileEffectShaders()
	StorageUtil.FormListClear(None, "_SLS_EffectShaderPercentiles")
	StorageUtil.FormListAdd(None, "_SLS_EffectShaderPercentiles", Game.GetFormFromFile(0x12F318, "SL Survival.esp"))
	StorageUtil.FormListAdd(None, "_SLS_EffectShaderPercentiles", Game.GetFormFromFile(0x12F881, "SL Survival.esp"))
	StorageUtil.FormListAdd(None, "_SLS_EffectShaderPercentiles", Game.GetFormFromFile(0x12F319, "SL Survival.esp"))
	StorageUtil.FormListAdd(None, "_SLS_EffectShaderPercentiles", Game.GetFormFromFile(0x12F882, "SL Survival.esp"))
	StorageUtil.FormListAdd(None, "_SLS_EffectShaderPercentiles", Game.GetFormFromFile(0x12F31A, "SL Survival.esp"))
	StorageUtil.FormListAdd(None, "_SLS_EffectShaderPercentiles", Game.GetFormFromFile(0x12F883, "SL Survival.esp"))
	StorageUtil.FormListAdd(None, "_SLS_EffectShaderPercentiles", Game.GetFormFromFile(0x12F31B, "SL Survival.esp"))
	StorageUtil.FormListAdd(None, "_SLS_EffectShaderPercentiles", Game.GetFormFromFile(0x12F884, "SL Survival.esp"))
	StorageUtil.FormListAdd(None, "_SLS_EffectShaderPercentiles", Game.GetFormFromFile(0x12F31C, "SL Survival.esp"))
	StorageUtil.FormListAdd(None, "_SLS_EffectShaderPercentiles", Game.GetFormFromFile(0x12F885, "SL Survival.esp"))
	StorageUtil.FormListAdd(None, "_SLS_EffectShaderPercentiles", Game.GetFormFromFile(0x12F31E, "SL Survival.esp"))
EndFunction

Function UiExtensionsCheck()
	If Game.GetModByName("UIExtensions.esp") == 255
		PlayerRef.PlaceActorAtMe(Game.GetFormFromFile(0x12CD46, "SL Survival.esp") as ActorBase)
		Int i = 3
		While i > 0
			i -= 1
			Debug.Messagebox("SL Survival:\nUI Extensions is not installed. This can potentially cause serious damage to your save!\n\nDO NOT SAVE NOW!\nExit the game NOW and installed UI extensions!\n\nThis message will repeat 3 times so you don't miss it\n\nAlso added a unfriendly reminder")
			Utility.Wait(1.0)
		EndWhile
	EndIf
EndFunction

ObjectReference Property StrippedClothes Auto Hidden ; Used in SK DDI strip scene
ObjectReference Property KnockHost Auto Hidden
ObjectReference Property KnockDoor Auto Hidden
Location Property HostLocation Auto Hidden
Quest Property _SLS_KnockForceGreet Auto
ReferenceAlias Property ForceGreetAlias Auto
ReferenceAlias Property LockTheDoor Auto
SimplyKnockMainScript Property KnockMain Auto
ReferenceAlias Property _SK_LinkedDoor Auto ; Simply knocks door alias which tries to keep the inside door unlocked. Exactly what we don't want. 

ReferenceAlias Property PlayerAliasKnockQuest  Auto 
SLS_KnockPlayerScript KnockPlayerScript

State Knocked
	Event OnCellLoad()
		If KnockHost != None
			Location PlayerLoc = PlayerRef.GetCurrentLocation()
			Location HostLoc = KnockHost.GetCurrentLocation()
			If PlayerLoc != None && HostLoc != None
				If PlayerLoc.IsSameLocation(HostLoc)
					;KnockPlayerScript.GoToState("InKnockedCell") ; Wake up in milk pump scenario
					LockTheDoor.ForceRefTo(KnockMain.DoorAlias.GetReference())
					SLS_KnockLockDoor LockInScript = LockTheDoor as SLS_KnockLockDoor
					_SK_LinkedDoor.Clear()
					LockInScript.InitDoor()
					Utility.Wait(0.1)
					ForceGreetAlias.ForceRefTo(KnockHost)
					(KnockHost as Actor).EvaluatePackage()
					_SLS_KnockForceGreet.Start()
				EndIf
			EndIf
		EndIf
	EndEvent
EndState

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
		
	; Eviction notes
	If akBaseItem == _SLS_EvictionNotice
		_SLS_EvictionNoticeTakeRefFind.Start()
		If NearestNpc.GetReference() != None
			ObjectReference WotYouTinkYouDoing = PlayerRef.PlaceAtMe(_SLS_EvictionNoteValueDummy)
			WotYouTinkYouDoing.SetActorOwner((NearestNpc.GetReference() as Actor).GetActorBase())
			WotYouTinkYouDoing.SendStealAlarm(PlayerRef)
			WotYouTinkYouDoing.Disable()
			WotYouTinkYouDoing.Delete()
			Init.LastReadEvictionNotice.Disable()
		EndIf
		
	; House keys
	ElseIf akBaseItem == WhiterunBreezehomeKey
		Eviction.OwnsWhiterun = true
		LicUtil.OwnsProperty = true
		If StorageUtil.FormListCount(Eviction, "EvictFormsWhiterun") > 0
			Eviction.EvictWhiterun(Evicted = true)
		EndIf
		RemoveInventoryEventFilter(WhiterunBreezehomeKey)
	ElseIf akBaseItem == SolitudeHouseKey
		Eviction.OwnsSolitude = true
		LicUtil.OwnsProperty = true
		If StorageUtil.FormListCount(Eviction, "EvictFormsSolitude") > 0
			Eviction.EvictSolitude(Evicted = true)
		EndIf
		RemoveInventoryEventFilter(SolitudeHouseKey)
	ElseIf akBaseItem == MS11HjerimKey
		Eviction.OwnsWindhelm = true
		LicUtil.OwnsProperty = true
		If StorageUtil.FormListCount(Eviction, "EvictFormsWindhelm") > 0
			Eviction.EvictWindhelm(Evicted = true)
		EndIf
		RemoveInventoryEventFilter(MS11HjerimKey)
	ElseIf akBaseItem == RiftenHoneysideKey
		Eviction.OwnsRiften = true
		LicUtil.OwnsProperty = true
		If StorageUtil.FormListCount(Eviction, "EvictFormsRiften") > 0
			Eviction.EvictRiften(Evicted = true)
		EndIf
		RemoveInventoryEventFilter(RiftenHoneysideKey)
	ElseIf akBaseItem == MarkarthVlindrelHallKey
		Eviction.OwnsMarkarth = true
		LicUtil.OwnsProperty = true
		If StorageUtil.FormListCount(Eviction, "EvictFormsMarkarth") > 0
			Eviction.EvictMarkarth(Evicted = true)
		EndIf
		RemoveInventoryEventFilter(MarkarthVlindrelHallKey)
	EndIf
EndEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	If akBaseItem == Gold001 && Menu.FolGoldStealChance > 0.0 && akDestContainer as Actor && (akDestContainer as Actor).IsInFaction(CurrentFollowerFaction); Followers steal gold
		If Menu.FolGoldStealChance > Utility.RandomInt(0, 100)
			akDestContainer.RemoveItem(Gold001, Math.Ceiling((aiItemCount * Menu.FolGoldSteamAmount) / 100))
			Debug.Notification("Your follower has sticky fingers ")
			Debug.Trace("SLS_: " + (akDestContainer as Actor).GetBaseObject().GetName() + " stole " + Math.Ceiling((aiItemCount * Menu.FolGoldSteamAmount) / 100) + " from you")
		Else
			Debug.Trace("SLS_: Follower gold steal chance failed")
		EndIf
	EndIf
EndEvent

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	
	; Skooma/Milk
	If akBaseObject as Potion
		If Init.SkoomaWhoreInstalled
			If Init.DrugsList.HasForm(akBaseObject) && !PauseEquip
				Frostfall.ModExposure(-(60))
				If Init.CumBreathLevel > 0
					_SLS_DrinkAlcohol.Cast(PlayerRef, PlayerRef)
				EndIf
				Float FatigueLoss = -(Math.Ceiling(40*Menu.SkoomaSleep))
				Needs.ModFatigue(FatigueLoss)
				AddFatigueGainEffect(akBaseObject, IsMilk = false, Strength = -(FatigueLoss))
			EndIf
		EndIf
		If Init.MmeInstalled
			If akBaseObject.HasKeyword(Init.MME_Milk)
				PauseEquip = true
				Float ExposureGain = GetMilkStrength(akBaseObject)
				Frostfall.ModExposure(-(ExposureGain))
				If Init.CumBreathLevel > 0 && Menu.MilkDecCumBreath
					_SLS_DrinkAlcohol.Cast(PlayerRef, PlayerRef)
				EndIf
				Float FatigueLoss = -(Math.Ceiling((ExposureGain/2) * Menu.MilkSleepMult))
				Needs.ModFatigue(FatigueLoss)
				AddFatigueGainEffect(akBaseObject, IsMilk = true, Strength = -(FatigueLoss), MilkStrength = ExposureGain)
				If Utility.IsInMenuMode() ; Lazy way of stopping MME milk equipping skooma too
					Utility.WaitMenuMode(1.0)
				Else
					Utility.Wait(0.5)
				EndIf
				PauseEquip = false
			EndIf
		EndIf
		If _SLS_AlchList.HasForm(akBaseObject) && Init.CumBreathLevel > 0
			_SLS_DrinkAlcohol.Cast(PlayerRef, PlayerRef)
		EndIf
	
	ElseIf akBaseObject as Armor && Devious.IsDeviousRenderDevice(akBaseObject)
		If Devious.IsHardGagged(PlayerRef)
			Init.PlayerIsHardGagged = true
		Else
			Init.PlayerIsHardGagged = false
		EndIf
		
	EndIf
EndEvent

Event OnObjectUnEquipped(Form akBaseObject, ObjectReference akReference)
	If akBaseObject as Armor && Devious.IsDeviousRenderDevice(akBaseObject)
		If Devious.IsHardGagged(PlayerRef)
			Init.PlayerIsHardGagged = true
		Else
			Init.PlayerIsHardGagged = false
		EndIf
	EndIf
EndEvent

Function AddFatigueGainEffect(Form akBaseObject, Bool IsMilk, Float Strength = 40.0, Float MilkStrength = 0.0) ; Strength = 40.0 for skooma types
	If Menu.DrugEndFatigueInc >= 0.0
		_SLS_DrugFatigueIncSpell.SetNthEffectMagnitude(0, Strength)
		Int Duration
		If IsMilk
			If Init.MilkAddictInstalled
				;Int Duration = MilkAddict.GetMilkDuration(MilkStrength)
				Duration = GetFatigueDrugIncTime(akBaseObject, IsMilk, MilkStrength)
				;Debug.Messagebox("Milk dur: " + Duration)
			Else
				Duration = GetFatigueDrugIncTime(Skooma, false)
			EndIf
			
		Else
			If akBaseObject == Skooma && Needs.GetState() == "Ineed"  ; Ineed applies skooma via script, because of course it does.
				If Init.SkoomaWhoreInstalled
					Duration = 360
				Else
					Duration = 305
				EndIf
			Else
				Duration = GetFatigueDrugIncTime(akBaseObject, false)
			EndIf
		EndIf
		_SLS_DrugFatigueIncSpell.SetNthEffectDuration(0, Duration)
		_SLS_DrugFatigueIncSpell.Cast(PlayerRef, PlayerRef)
	EndIf
EndFunction

Int Function GetFatigueDrugIncTime(Form akBaseObject, Bool IsMilk, Float MilkStrength = 0.0)
	If IsMilk ; Milk
		If Init.MilkAddictInstalled
			Return MilkAddict.GetMilkDuration(MilkStrength)
		Else
			Return GetHighestEffectDurationPotion(Skooma)
		EndIf
	Else ; Drug
		If Init.SkoomaWhoreInstalled
			Return 360 ; Skooma whore has different durations based on PD, MD pools and the type of drug being applied. Just use 360 for now
		Else
			Return GetHighestEffectDurationPotion(akBaseObject)
		EndIf
	EndIf
EndFunction

Int Function GetHighestEffectDurationPotion(Form akBaseObject)
	Potion Drug = akBaseObject as Potion
	Int HighestDuration = 0
	Int CurDur
	Int i = Drug.GetNumEffects()
	While i > 0
		i -= 1
		CurDur = Drug.GetNthEffectDuration(i)
		If CurDur > HighestDuration
			HighestDuration = CurDur
		EndIf
	EndWhile
	;Debug.Messagebox("Highest Dur: " + HighestDuration)
	Return HighestDuration + 5
EndFunction

Event OnMenuOpen(String MenuName)
	If MenuName == "InventoryMenu" ; Close inventory during gag deals
		Game.DisablePlayerControls(!Game.IsMovementControlsEnabled(), !Game.IsFightingControlsEnabled(), !Game.IsCamSwitchControlsEnabled(), !Game.IsLookingControlsEnabled(), !Game.IsSneakingControlsEnabled(), true, !Game.IsActivateControlsEnabled(), !Game.IsJournalControlsEnabled())
		Game.EnablePlayerControls(Game.IsMovementControlsEnabled(), Game.IsFightingControlsEnabled(), Game.IsCamSwitchControlsEnabled(), Game.IsLookingControlsEnabled(), Game.IsSneakingControlsEnabled(), true, Game.IsActivateControlsEnabled(), Game.IsJournalControlsEnabled())
	EndIf
EndEvent

; CUSTOM EVENTS ==============================================================================================

Event OnMME_MilkCycleComplete(string eventName, string strArg, float numArg, Form sender)
	If PlayerRef.HasMagicEffect(Init.MME_LeakingMilk)
		If Init.FrostfallInstalled
			_SLS_MilkLeakWet.Cast(PlayerRef, PlayerRef)
		EndIf
	EndIf
	
	; Refresh milk fullness capacity float - used for FemaleNord guard dialogue comment 'Nice big milky tits'
	Init.MmeMilkCapacity = (StorageUtil.GetFloatValue(PlayerRef, "MME.MilkMaid.MilkCount", Missing = 0.0) / StorageUtil.GetFloatValue(PlayerRef, "MME.MilkMaid.MilkMaximum", Missing = 1.0))
EndEvent

Event OnAnimationStarting(int tid, bool HasPlayer)
	If HasPlayer
		PlayerRef.AddToFaction(_SLS_NoParalyzeFact)
		If Init.FrostfallInstalled
			_SLS_WarmBodies.Cast(PlayerRef, PlayerRef)
		EndIf
	EndIf
EndEvent

Event OnAnimationEnding(int tid, bool HasPlayer)
	If HasPlayer && Menu.PushEvents > 1
		_SLS_NoParaFactRemoveSpell.Cast(PlayerRef, PlayerRef)
	EndIf
EndEvent

Event OnOrgasmEnd(int tid, bool HasPlayer)
	If HasPlayer && Init.MmeInstalled
		If PlayerRef.HasMagicEffect(Init.MME_LeakingMilk)
			If Init.FrostfallInstalled
				_SLS_MilkLeakWet.Cast(PlayerRef, PlayerRef)
			EndIf
		EndIf
	EndIf
EndEvent

Event OnDeviceVibrateEffectStart(string eventName, string strArg, float numArg, Form sender)
	If strArg == PlayerRef.GetLeveledActorBase().GetName()
		Utility.Wait(3.0)
		If PlayerRef.HasMagicEffect(Init.MME_LeakingMilk)
			_SLS_MilkLeakWet.Cast(PlayerRef, PlayerRef)
		EndIf
	EndIf
EndEvent

Event Frost_OnRescuePlayer(bool in_water) ; Send to simple slavery+
	If Menu.FfRescueEvents
		If Init.SdInstalled && Init.SimpleSlaveryInstalled
			If Utility.RandomFloat(1.0, 100.0) > Menu.SimpleSlaveryFF
				SendModEvent("SDDreamworldPull")
			Else
				sendModEvent("SSLV Entry")
			EndIf
		
		ElseIf Init.SdInstalled
			SendModEvent("SDDreamworldPull")
		ElseIf Init.SimpleSlaveryInstalled
			sendModEvent("SSLV Entry")
		EndIf
	EndIf
EndEvent

Event Frostfall_OnPlayerStartSwimming() ; Needs moving ?????????
	If Menu.SwimCumClean > 0
		_SLS_SwimCleanCum.Cast(PlayerRef, PlayerRef)
	EndIf
endEvent

; FUNCTIONS ==========================================================================================================================

Function GetKnockLeaveResult()
	Int Result = -1 ; 0 - Release, 1 - Simple Slavery, 2 - Sanguines Debauchery

	If Utility.RandomFloat(1.0, 100.0) > Menu.KnockSlaveryChance
		Result = 0
	EndIf
	
	If Result < 0
		If Init.SdInstalled && Init.SimpleSlaveryInstalled
			If Utility.RandomFloat(1.0, 100.0) > Menu.SimpleSlaveryWeight
				Result = 2
			Else
				Result = 1
			EndIf
		ElseIf Init.SdInstalled
			Result = 2
		ElseIf Init.SimpleSlaveryInstalled
			Result = 1
		Else
			Result = 0
		EndIf
	EndIf
	
	Init.KnockLeaveResult = Result
EndFunction

Float Function GetMilkStrength(Form akBaseObject)
	; Match strengths here with levels in Milk addict interface function GetMilkDuration!!!!!!!!!!!!!!!!!

	String S1 = akBaseObject.GetName()
	
	If StringUtil.Find(S1, "Dilute", 6) > -1; Start at 6 - (Milk, )Tasty
		return 5.0
	ElseIf StringUtil.Find(S1, "Weak", 6) > -1
		return 10.0
	ElseIf StringUtil.Find(S1, "Regular", 6) > -1
		return 15.0
	ElseIf StringUtil.Find(S1, "Strong", 6) > -1
		return 20.0
	ElseIf StringUtil.Find(S1, "Tasty", 6) > -1
		return 25.0
	ElseIf StringUtil.Find(S1, "Creamy", 6) > -1
		return 30.0
	ElseIf StringUtil.Find(S1, "Enriched", 6) > -1
		return 35.0
	ElseIf StringUtil.Find(S1, "Sublime", 6) > -1
		return 40.0
	Else	; Simple milks
		return 15.0
	EndIf
EndFunction

;/
Function KnockStripClothes()
	Int i = PlayerRef.GetNumItems()
	Form akForm
	While i > 0
		i -= 1
		akForm = PlayerRef.GetNthForm(i)
		If akForm.HasKeyword(Clothingbody) || akForm.HasKeyword(ArmorCuirass) || akForm.HasKeyword(VendorItemWeapon)
			PlayerRef.RemoveItem(akForm, PlayerRef.GetItemCount(akForm), true, StrippedChest)
		EndIf
	EndWhile
EndFunction
/;
Function KnockResetSk() ; Reset simply knock and return the player to trespassing state
	;ObjectReference state_marker = KnockMain.GetStateMarker(KnockMain.CurrentDoor)
	_SK_LinkedDoor.GetReference().Activate(PlayerRef) ; throw player out
	;(state_marker as SimplyKnockInteriorState).ClearAllowedEntryAndDelete()	
EndFunction

Actor[] DnpcList

Function UpdateBeggingDialogFactors(Actor akSpeaker)
	UpdateSwDrugPool()
	
	; Find Npcs/dogs/wolves/horses
	_SLS_BeggingSearch.Stop()
	_SLS_BeggingSearch.Start()
	
	; Speaker gender check
	Int Gender = Sexlab.GetGender(akSpeaker)
	If Gender == 0
		Init.IsSpeakerMale = true
	ElseIf Gender == 1
		Init.IsSpeakerMale = false
	EndIf
	
	; Slave check
	If Init.ZazInstalled
		If akSpeaker.IsInFaction(Init.ZazSlaveFaction)
			Init.IsSpeakerSlave = true
		Else
			Init.IsSpeakerSlave = false
		EndIf
	EndIf
	
	; Gagged check
	If PlayerRef.WornHasKeyword(Devious.zad_DeviousGag) && !PlayerRef.WornHasKeyword(Devious.zad_PermitOral)
		Init.IsPlayerEatBlocked = true
	Else
		Init.IsPlayerEatBlocked = false
	EndIf
	
	;Init.BegSwallowDeal = 0
	Init.NpcWants = StorageUtil.GetIntValue(akSpeaker, "SLS_Begging_NpcWants", missing = -1)
	
	Dnpc.Clear()
	DnpcList = new Actor[5]
	If Init.NpcWants == 13 ; Npc previously wanted player degradation
		If Dnpc.GetReference() != akSpeaker ; If player accepted a new degradation deal, clear what the old npc wanted
			StorageUtil.UnSetIntValue(akSpeaker, "SLS_Begging_NpcWants")
			Init.NpcWants = -1
		EndIf
	EndIf
	
	If Init.MmeInstalled
		Init.MmeMilkCapacity = (StorageUtil.GetFloatValue(PlayerRef, "MME.MilkMaid.MilkCount", Missing = 0.0) / StorageUtil.GetFloatValue(PlayerRef, "MME.MilkMaid.MilkMaximum", Missing = 1.0))
	EndIf
	
	Init.BeggingDnpcFound = 0
	If DegradingNpc01.GetReference() != None; && DegradingNpc01.GetReference() != akSpeaker
		If Init.ZazInstalled
			If !(DegradingNpc01.GetReference() as Actor).IsInFaction(Init.ZazSlaveFaction)
				Dnpc.ForceRefTo(DegradingNpc01.GetReference())
				DnpcList[Init.BeggingDnpcFound] = DegradingNpc01.GetReference() as Actor
				Init.BeggingDnpcFound += 1
			Else
				DegradingNpc01.Clear()
			EndIf
		Else
			Dnpc.ForceRefTo(DegradingNpc01.GetReference())
			DnpcList[Init.BeggingDnpcFound] = DegradingNpc01.GetReference() as Actor
			Init.BeggingDnpcFound += 1
		EndIf
	EndIf
	If DegradingNpc02.GetReference() != None; && DegradingNpc02.GetReference() != akSpeaker
		If Init.ZazInstalled
			If !(DegradingNpc02.GetReference() as Actor).IsInFaction(Init.ZazSlaveFaction)
				Dnpc.ForceRefTo(DegradingNpc02.GetReference())
				DnpcList[Init.BeggingDnpcFound] = DegradingNpc02.GetReference() as Actor
				Init.BeggingDnpcFound += 1
			Else
				DegradingNpc02.Clear()
			EndIf
		Else
			Dnpc.ForceRefTo(DegradingNpc02.GetReference())
			DnpcList[Init.BeggingDnpcFound] = DegradingNpc02.GetReference() as Actor
			Init.BeggingDnpcFound += 1
		EndIf
	EndIf
	If DegradingNpc03.GetReference() != None; && DegradingNpc03.GetReference() != akSpeaker
		If Init.ZazInstalled
			If !(DegradingNpc03.GetReference() as Actor).IsInFaction(Init.ZazSlaveFaction)
				Dnpc.ForceRefTo(DegradingNpc03.GetReference())
				DnpcList[Init.BeggingDnpcFound] = DegradingNpc03.GetReference() as Actor
				Init.BeggingDnpcFound += 1
			Else
				DegradingNpc03.Clear()
			EndIf
		Else
			Dnpc.ForceRefTo(DegradingNpc03.GetReference())
			DnpcList[Init.BeggingDnpcFound] = DegradingNpc03.GetReference() as Actor
			Init.BeggingDnpcFound += 1
		EndIf
	EndIf
	If DegradingNpc04.GetReference() != None; && DegradingNpc04.GetReference() != akSpeaker
		If Init.ZazInstalled
			If !(DegradingNpc04.GetReference() as Actor).IsInFaction(Init.ZazSlaveFaction)
				Dnpc.ForceRefTo(DegradingNpc04.GetReference())
				DnpcList[Init.BeggingDnpcFound] = DegradingNpc04.GetReference() as Actor
				Init.BeggingDnpcFound += 1
			Else
				DegradingNpc04.Clear()
			EndIf
		Else
			Dnpc.ForceRefTo(DegradingNpc04.GetReference())
			DnpcList[Init.BeggingDnpcFound] = DegradingNpc04.GetReference() as Actor
			Init.BeggingDnpcFound += 1
		EndIf
	EndIf
	If DegradingNpc05.GetReference() != None; && DegradingNpc05.GetReference() != akSpeaker
		If Init.ZazInstalled
			If !(DegradingNpc05.GetReference() as Actor).IsInFaction(Init.ZazSlaveFaction)
				Dnpc.ForceRefTo(DegradingNpc05.GetReference())
				DnpcList[Init.BeggingDnpcFound] = DegradingNpc05.GetReference() as Actor
				Init.BeggingDnpcFound += 1
			Else
				DegradingNpc05.Clear()
			EndIf
		Else
			Dnpc.ForceRefTo(DegradingNpc05.GetReference())
			DnpcList[Init.BeggingDnpcFound] = DegradingNpc05.GetReference() as Actor
			Init.BeggingDnpcFound += 1
		EndIf
	EndIf
	
	; Wolves
	Init.BeggingWolvesFound = 0
	If BeggingWolf01.GetReference() != None
		Init.BeggingWolvesFound += 1
	EndIf
	If BeggingWolf02.GetReference() != None
		Init.BeggingWolvesFound += 1
	EndIf
	If BeggingWolf03.GetReference() != None
		Init.BeggingWolvesFound += 1
	EndIf
	
	;/
	If Init.NpcWants != -1
		If Init.NpcWants == 7 && Init.BeggingWolvesFound < 2 ; Npc wanted dog gangbang but the number of dogs available has changed
			If Init.BeggingWolvesFound > 0 ; If there's any mutts around
				Init.NpcWants = Utility.RandomInt(4, 6)
				StorageUtil.SetIntValue(akSpeaker, "SLS_Begging_NpcWants", Init.NpcWants)
			Else ; if not just reset
				Init.NpcWants = -1
				StorageUtil.SetIntValue(akSpeaker, "SLS_Begging_NpcWants", -1)
			EndIf
			
		ElseIf Init.NpcWants >= 4 && Init.NpcWants <= 6 && Init.BeggingWolvesFound == 0 ; Npc wanted dog sex but the number of dogs is no longer viable
			Init.NpcWants = -1
			StorageUtil.SetIntValue(akSpeaker, "SLS_Begging_NpcWants", -1)
		EndIf
	EndIf
	/;
	
	; Dogs
	Init.BeggingDogsFound = 0
	If BeggingDog01.GetReference() != None
		Init.BeggingDogsFound += 1
	EndIf
	If BeggingDog02.GetReference() != None
		Init.BeggingDogsFound += 1
	EndIf
	If BeggingDog03.GetReference() != None
		Init.BeggingDogsFound += 1
	EndIf
	If Init.NpcWants != -1
		If Init.NpcWants == 7 && Init.BeggingDogsFound < 2 && Init.BeggingWolvesFound < 2 ; Npc wanted dog/wolves gangbang but the number of dogs available has changed
			If Init.BeggingDogsFound > 0 || Init.BeggingWolvesFound > 0; If there's any mutts around
				Init.NpcWants = Utility.RandomInt(4, 6)
				StorageUtil.SetIntValue(akSpeaker, "SLS_Begging_NpcWants", Init.NpcWants)
			Else ; if not just reset
				Init.NpcWants = -1
				StorageUtil.SetIntValue(akSpeaker, "SLS_Begging_NpcWants", -1)
			EndIf
			
		ElseIf Init.NpcWants >= 4 && Init.NpcWants <= 6 && Init.BeggingDogsFound == 0 && Init.BeggingWolvesFound == 0 ; Npc wanted dog sex but the number of dogs is no longer viable
			Init.NpcWants = -1
			StorageUtil.SetIntValue(akSpeaker, "SLS_Begging_NpcWants", -1)
		EndIf
	EndIf

	; Horses
	Init.BeggingHorsesFound = 0
	If BeggingHorse01.GetReference() != None
		Init.BeggingHorsesFound += 1
	EndIf
	If BeggingHorse02.GetReference() != None
		Init.BeggingHorsesFound += 1
	EndIf
	If BeggingHorse03.GetReference() != None
		Init.BeggingHorsesFound += 1
	EndIf
	If Init.NpcWants != -1
		If Init.NpcWants == 11 && Init.BeggingHorsesFound < 2 ; Npc wanted horse gangbang but the number of horses available is no longer viable
			If Init.BeggingHorsesFound > 0 ; If there's any horses around
				Init.NpcWants = Utility.RandomInt(9, 10) 
				StorageUtil.SetIntValue(akSpeaker, "SLS_Begging_NpcWants", Init.NpcWants)
			Else ; if not just reset
				Init.NpcWants = -1
				StorageUtil.SetIntValue(akSpeaker, "SLS_Begging_NpcWants", -1)
			EndIf
			
		ElseIf Init.NpcWants >= 8 && Init.NpcWants <= 10 && Init.BeggingHorsesFound == 0 ; Npc wanted horse sex but the number of horses is no longer viable
			Init.NpcWants = -1
			StorageUtil.SetIntValue(akSpeaker, "SLS_Begging_NpcWants", -1)
		
		ElseIf Init.NpcWants == 12 ; Check player still only has one set of clothes/armor
			(_SLS_HasPlayerClothes as SLS_HasPlayerClothes).PlayerHasOnlyOneClothes = false
			_SLS_HasPlayerClothes.SetStage(10)
			If !(_SLS_HasPlayerClothes as SLS_HasPlayerClothes).PlayerHasOnlyOneClothes
				Init.NpcWants = -1
				StorageUtil.SetIntValue(akSpeaker, "SLS_Begging_NpcWants", -1)
			EndIf
		EndIf
	EndIf
	
	Slaverun.IsPlayerSlaverunSlave()
	
	Needs.GetBegIsHungy()
	Needs.GetBegIsThirsty()
	
	Init.PlayerHandsAreAvailable = Devious.AreHandsAvailable(PlayerRef)
	
	If PlayerRef.GetWornForm(0x00000004) != _SLS_HalfNakedCoverArmor
		PlayerRef.RemoveItem(_SLS_HalfNakedCoverArmor, 999, true)
	EndIf
	PlayerRef.RemoveItem(BikinifierHalfNakedArmor, 999, true)
EndFunction

; Sex functions -------------------------------------------------------------

Function PreBegSex(Actor akSpeaker)
	If Init.BegSwallowDeal == 1
		Init.BegSwallowDeal = 2
	EndIf
	If Menu.OrgasmRequired
		Init.ClientOrgasmState = 2 ; orgasm required
	Else
		Init.ClientOrgasmState = 3 ; orgasm success
	EndIf
	If !Init.IsGagDeal
		Client.ForceRefTo(akSpeaker)
	EndIf
EndFunction

Function PostBegSex(String FameType)
	;Init.DecDflowWill()
	Dflow.DecResistWithSeverity(Amount = 20.0, DoNotify = true, Severity = "3")
	Slsf.IncreaseSexFame(FameType, 5)
EndFunction

Int Function GetGangbangActor(Int Index)
	While Index < DnpcList.Length
		If DnpcList[Index] != None
			Return Index
		EndIf
		Index += 1
	EndWhile
EndFunction

Function BegGagDeal()
	Init.IsGagDeal = true
	RegisterForMenu("InventoryMenu")
	; Block inventory
	Init.BegDealGag = Devious.GetWornDeviceByKeyword(PlayerRef, Devious.zad_DeviousGag)
	Devious.RemoveDevice(PlayerRef, Init.BegDealGag)
	If PlayerRef.WornHasKeyword(Devious.zad_DeviousHeavyBondage)
		Init.BegDealHeavyBondage = Devious.GetWornDeviceByKeyword(PlayerRef, Devious.zad_DeviousHeavyBondage)
		Devious.RemoveDevice(PlayerRef, Init.BegDealHeavyBondage)
	Else 
		Init.BegDealHeavyBondage = None
	EndIf
EndFunction

Function SexTeleport(Int TeleportType, Actor[] SexActors)
	Int i
	If TeleportType == 1
		i = 1 ; Start at 1. Player is 0
	Else
		i = 2 ; Start at 2. Player is 0, akSpeaker is 1
	EndIf
	While i < SexActors.Length
		SexActors[i].MoveTo(PlayerRef)
		Debug.trace("SLS_: Teleporting " + SexActors[i].GetBaseObject().GetName())
		i += 1
	EndWhile
EndFunction

Bool  CurSceneRandomAgg
String Function GetAnimationsTags(Int AggCat, String StartingTags, Float Willpower)
	;Debug.Messagebox("GetAnimationsTags\n\nAggCat: " + AggCat + "\nStartingTags: " + StartingTags + "\nWillpower: " + Willpower)
	If AggCat == 0 ; Not Aggressive
		Return StartingTags
	ElseIf AggCat == 1 ; Don't Care
		Return StartingTags
	ElseIf AggCat == 2 ; Aggressive
		Return AddAggString(StartingTags)
	ElseIf AggCat == 3 ; Use DF Willpower Static
		If Willpower <= 3
			Return StartingTags
		ElseIf Willpower <= 7
			CurSceneRandomAgg = SetCurSceneRandomAgg(AggCat, Willpower)
			If CurSceneRandomAgg
				Return StartingTags
			Else
				Return AddAggString(StartingTags)
			EndIf
		Else
			Return AddAggString(StartingTags)
		EndIf
	Else ; Use DF Willpower % Chance
		CurSceneRandomAgg = SetCurSceneRandomAgg(AggCat, Willpower)
		If CurSceneRandomAgg
			Return AddAggString(StartingTags)
		Else
			Return StartingTags
		EndIf
	EndIf
EndFunction

Function SetCurSceneRandomAgg(Int AggCat, Float Willpower)
	If AggCat == 3 ; Use DF Willpower Fixed
		CurSceneRandomAgg = Utility.RandomFloat(0.0, 100.0) > 50.0
	Else ; Use DF Willpower % Chance
		CurSceneRandomAgg = (10.0 - Willpower) > Utility.RandomFloat(0.0, 10.0) 
	EndIf
EndFunction

String Function GetSuppressTags(Int AggCat, String StartingTags, Float Willpower)
	;Debug.Messagebox("GetSuppressTags\n\nAggCat: " + AggCat + "\nStartingTags: " + StartingTags + "\nWillpower: " + Willpower)
	If AggCat == 0 ; Not Aggressive
		Return AddAggString(StartingTags)
	ElseIf AggCat == 1 ; Aggressive
		Return StartingTags
	ElseIf AggCat == 2 ; Don't Care
		Return StartingTags
	ElseIf AggCat == 3 ; Use DF Willpower Static
		If Willpower <= 3
			Return AddAggString(StartingTags)
		ElseIf Willpower <= 7
			CurSceneRandomAgg = SetCurSceneRandomAgg(AggCat, Willpower)
			If CurSceneRandomAgg
				Return StartingTags
			Else
				Return AddAggString(StartingTags)
			EndIf
		Else
			Return StartingTags
		EndIf
	Else ; Use DF Willpower % Chance
		CurSceneRandomAgg = SetCurSceneRandomAgg(AggCat, Willpower)
		If CurSceneRandomAgg
			Return StartingTags
		Else
			Return AddAggString(StartingTags)
		EndIf
	EndIf
EndFunction

sslBaseAnimation[] Function BeginGetAnims(Int ActorCount, Int SexCat, Bool IsCreatureScene, String AnimTags, String SuppressTags)
	Float Willpower = Dflow.UpdateWillLocal()
	If SexCat == 0 ; Unspecified - Default aggressive
		AnimTags = GetAnimationsTags(AggCat = 2, StartingTags = AnimTags, Willpower = Willpower)
		SuppressTags = GetSuppressTags(AggCat = 2, StartingTags = SuppressTags, Willpower = Willpower)
		Return GetAnims(ActorCount, IsCreatureScene, AnimTags, SuppressTags)
		
	ElseIf SexCat == 1 ; Toll sex
		AnimTags = GetAnimationsTags(AggCat = Menu.TollSexAgg, StartingTags = AnimTags, Willpower = Willpower)
		SuppressTags = GetSuppressTags(AggCat = Menu.TollSexAgg, StartingTags = SuppressTags, Willpower = Willpower)
		Return GetAnims(ActorCount, IsCreatureScene, AnimTags, SuppressTags)
		
	ElseIf SexCat == 2 ; Beg sex
		AnimTags = GetAnimationsTags(AggCat = Menu.BegSexAgg, StartingTags = AnimTags, Willpower = Willpower)
		SuppressTags = GetSuppressTags(AggCat = Menu.BegSexAgg, StartingTags = SuppressTags, Willpower = Willpower)
		Return GetAnims(ActorCount, IsCreatureScene, AnimTags, SuppressTags)
		
	Else ; Kennel sex
		AnimTags = GetAnimationsTags(AggCat = Menu.KennelSexAgg, StartingTags = AnimTags, Willpower = Willpower)
		SuppressTags = GetSuppressTags(AggCat = Menu.KennelSexAgg, StartingTags = SuppressTags, Willpower = Willpower)
		Return GetAnims(ActorCount, IsCreatureScene, AnimTags, SuppressTags)
	EndIf
EndFunction

sslBaseAnimation[] Function GetAnims(Int ActorCount, Bool IsCreatureScene, String AnimTags, String SuppressTags)
	;Debug.Messagebox("GetAnims\n\nActorCount: " + ActorCount + "\nIsCreatureScene: " + IsCreatureScene + "\n\nAnimTags: " + AnimTags + "\n\nSuppressTags: " + SuppressTags)
	If IsCreatureScene
		Return SexLab.GetCreatureAnimationsByTags(ActorCount, AnimTags, TagSuppress = SuppressTags)
	Else
		Return SexLab.GetAnimationsByTags(ActorCount, AnimTags, TagSuppress = SuppressTags)
	EndIf
EndFunction

String Function AddAggString(String Tags)
	If Tags == ""
		Return "Aggressive"
	Else
		Return Tags + ",Aggressive"
	EndIf
EndFunction

Bool Function GetIsPlayerVictim(Int SexCat)
	If SexCat == 0 ; Unspecified - Default aggressive
		Return false
	ElseIf SexCat == 1 ; Toll sex
		Return Menu.TollSexVictim as Bool
	ElseIf SexCat == 2 ; Beg sex
		Return Menu.BegSexVictim as Bool
	Else ; Kennel sex
		Return Menu.KennelSexVictim as Bool
	EndIf
EndFunction

Function DoSexStartDebug(Int SexCat, Int ActorCount, Actor Victim, Int AnimCount, String AnimTags, String SupressTags)
	If Init.DebugMode
		Debug.Messagebox("SexCat: " + SexCat + "\nActor Count: " + ActorCount + "\nVictim: " + Victim + "\nAnimation Count: " + AnimCount + "\n\nAnimTags: " + AnimTags + "\n\nSupressTags: " + SupressTags)
	EndIf
EndFunction

; Human sex -------------------------------------------------------------------
; SexCat == 2 (IsBegging) - Set must orgasm requirement and if is swallow deal
; DecWillIncFame - Decrements Devious Followers willpower
; Victim - Is player victim/forced
; Teleport - 0 - No teleporting, 1 - Teleport all except player, 2 - Teleport all except player and SexActors[1] which is usually akSpeaker

Function Masturbate(Actor akTarget, sslBaseAnimation Anim = None)
	; Anim - Play a specific masturbation animation. If none provided, do a random animation

	actor[] sexActors =  new actor[1]
	SexActors[0] = PlayerRef
	sslBaseAnimation[] animations
	If !Anim
		String AnimTags = "Solo"
		If akTarget.GetActorBase().GetSex() == 1
			AnimTags += ",F"
		Else
			AnimTags += ",M"
		EndIf
		String SuppressTags = ""
		animations = GetAnims(1, false, AnimTags, SuppressTags)
	
	Else
		animations = new sslBaseAnimation[1]
		animations[0] = Anim
	EndIf
	Sexlab.StartSex(sexActors, animations, None)
EndFunction

Function StartSexOralMale(Actor akSpeaker, Int SexCat = 0, Bool DecWillIncFame = true, Actor Victim = none, Int TeleportType = 0)
	; SexCat: 0 - Unspec, 1 - Toll, 2 - Beg, 3 - Kennel.

	If PlayerRef.WornHasKeyword(Devious.zad_DeviousGag)
		Armor Gag = Devious.GetWornDeviceByKeyword(PlayerRef, Devious.zad_DeviousGag)
		Init.TollGag = Gag
		Devious.RemoveDevice(PlayerRef, Gag)
	EndIf
	If SexCat > 0
		If SexCat == 2
			PreBegSex(akSpeaker)
		EndIf
		If GetIsPlayerVictim(SexCat)
			Victim = PlayerRef
		Else
			Victim = None
		EndIf
	EndIf
	
	String AnimTags = "Blowjob"
	String SuppressTags = "Cunnilingus"
	sslBaseAnimation[] animations = BeginGetAnims(2, SexCat = SexCat, IsCreatureScene = false, AnimTags = AnimTags, SuppressTags = SuppressTags)
	If animations.Length == 0 ; Fallback to not filtering aggressive tag if no animations found
		animations = SexLab.GetAnimationsByTags(2, AnimTags, SuppressTags)
	EndIf
	
	actor[] sexActors =  new actor[2]
	SexActors[0] = PlayerRef
	SexActors[1] = akSpeaker
	If TeleportType > 0
		SexTeleport(TeleportType, SexActors)
	EndIf
	DoSexStartDebug(SexCat, SexActors.Length, Victim, animations.Length, AnimTags, SuppressTags)
	Sexlab.StartSex(sexActors, animations, Victim)
	If DecWillIncFame
		PostBegSex("Whore")
	EndIf
	If SexCat == 2
		Util.BegSexCount += 1
		Util.BegBlowjobs += 1
	EndIf
EndFunction

Function StartSexOralFemale(Actor akSpeaker, Int SexCat = 0, Bool DecWillIncFame = true, Actor Victim = none, Int TeleportType = 0)
	If PlayerRef.WornHasKeyword(Devious.zad_DeviousGag)
		Armor Gag = Devious.GetWornDeviceByKeyword(PlayerRef, Devious.zad_DeviousGag)
		Init.TollGag = Gag
		Devious.RemoveDevice(PlayerRef, Gag)
	EndIf
	If SexCat > 0
		If SexCat == 2
			PreBegSex(akSpeaker)
		EndIf
		If GetIsPlayerVictim(SexCat)
			Victim = PlayerRef
		Else
			Victim = None
		EndIf
	EndIf
	
	String AnimTags = "Cunnilingus"
	String SuppressTags = ""
	sslBaseAnimation[] animations = BeginGetAnims(2, SexCat = SexCat, IsCreatureScene = false, AnimTags = AnimTags, SuppressTags = SuppressTags)
	If animations.Length == 0 ; Fallback to not filtering aggressive tag if no animations found
		animations = SexLab.GetAnimationsByTags(2, AnimTags, SuppressTags)
	EndIf
	
	actor[] sexActors =  new actor[2]
	SexActors[0] = PlayerRef
	SexActors[1] = akSpeaker
	If TeleportType > 0
		SexTeleport(TeleportType, SexActors)
	EndIf
	DoSexStartDebug(SexCat, SexActors.Length, Victim, animations.Length, AnimTags, SuppressTags)
	Sexlab.StartSex(sexActors, animations, Victim)
	If DecWillIncFame
		PostBegSex("Whore")
	EndIf
	If SexCat == 2
		Util.BegSexCount += 1
		Util.BegLickings += 1
	EndIf
EndFunction

Function StartSexVaginal(Actor akSpeaker, Int SexCat = 0, Bool DecWillIncFame = true, Actor Victim = none, Int TeleportType = 0)
	If SexCat > 0
		If SexCat == 2
			PreBegSex(akSpeaker)
		EndIf
		If GetIsPlayerVictim(SexCat)
			Victim = PlayerRef
		Else
			Victim = None
		EndIf
	EndIf
	
	String AnimTags = "Vaginal"
	String SuppressTags = ""
	sslBaseAnimation[] animations = BeginGetAnims(2, SexCat = SexCat, IsCreatureScene = false, AnimTags = AnimTags, SuppressTags = SuppressTags)
	If animations.Length == 0 ; Fallback to not filtering aggressive tag if no animations found
		animations = SexLab.GetAnimationsByTags(2, AnimTags, SuppressTags)
	EndIf
	
	actor[] sexActors =  new actor[2]
	SexActors[0] = PlayerRef
	SexActors[1] = akSpeaker
	If TeleportType > 0
		SexTeleport(TeleportType, SexActors)
	EndIf
	DoSexStartDebug(SexCat, SexActors.Length, Victim, animations.Length, AnimTags, SuppressTags)
	Sexlab.StartSex(sexActors, animations, Victim)
	If DecWillIncFame
		PostBegSex("Whore")
	EndIf
	If SexCat == 2
		Util.BegSexCount += 1
		Util.BegVagSex += 1
	EndIf
EndFunction

Function StartSexAnal(Actor akSpeaker, Int SexCat = 0, Bool DecWillIncFame = true, Actor Victim = none, Int TeleportType = 0)
	If SexCat > 0
		If SexCat == 2
			PreBegSex(akSpeaker)
		EndIf
		If GetIsPlayerVictim(SexCat)
			Victim = PlayerRef
		Else
			Victim = None
		EndIf
	EndIf
	
	String AnimTags = "Anal"
	String SuppressTags = ""
	sslBaseAnimation[] animations = BeginGetAnims(2, SexCat = SexCat, IsCreatureScene = false, AnimTags = AnimTags, SuppressTags = SuppressTags)
	If animations.Length == 0 ; Fallback to not filtering aggressive tag if no animations found
		animations = SexLab.GetAnimationsByTags(2, AnimTags, SuppressTags)
	EndIf
	
	actor[] sexActors =  new actor[2]
	SexActors[0] = PlayerRef
	SexActors[1] = akSpeaker
	If TeleportType > 0
		SexTeleport(TeleportType, SexActors)
	EndIf
	DoSexStartDebug(SexCat, SexActors.Length, Victim, animations.Length, AnimTags, SuppressTags)
	Sexlab.StartSex(sexActors, animations, Victim)
	If DecWillIncFame
		PostBegSex("Whore")
	EndIf
	If SexCat == 2
		Util.BegSexCount += 1
		Util.BegAnalSex += 1
	EndIf
EndFunction

Function StartSex3p(Actor akSpeaker, Int SexCat = 0, Bool DecWillIncFame = true, Actor Victim = none, Int TeleportType = 0)
	If SexCat > 0
		If SexCat == 2
			PreBegSex(akSpeaker)
		EndIf
		If GetIsPlayerVictim(SexCat)
			Victim = PlayerRef
		Else
			Victim = None
		EndIf
	EndIf
	
	Int Index = 0
	String AnimTags = "Gangbang"
	String SuppressTags = ""
	sslBaseAnimation[] animations = BeginGetAnims(3, SexCat = SexCat, IsCreatureScene = false, AnimTags = AnimTags, SuppressTags = SuppressTags)
	If animations.Length == 0 ; Fallback to not filtering aggressive tag if no animations found
		animations = SexLab.GetAnimationsByTags(3, AnimTags, SuppressTags)
	EndIf
	
	actor[] sexActors =  new actor[3]
	SexActors[0] = PlayerRef
	SexActors[1] = akSpeaker
	SexActors[2] = DnpcList[GetGangbangActor(Index)]
	If TeleportType > 0
		SexTeleport(TeleportType, SexActors)
	EndIf
	DoSexStartDebug(SexCat, SexActors.Length, Victim, animations.Length, AnimTags, SuppressTags)
	Sexlab.StartSex(sexActors, animations, Victim)
	If DecWillIncFame
		PostBegSex("Whore")
	EndIf
	If SexCat == 2
		Util.BegSexCount += 1
		Util.BegGangbangs += 1
	EndIf
EndFunction

Function StartSex4p(Actor akSpeaker, Int SexCat = 0, Bool DecWillIncFame = true, Actor Victim = none, Int TeleportType = 0)
	If SexCat > 0
		If SexCat == 2
			PreBegSex(akSpeaker)
		EndIf
		If GetIsPlayerVictim(SexCat)
			Victim = PlayerRef
		Else
			Victim = None
		EndIf
	EndIf
	
	Int Index = 0
	String AnimTags = "Gangbang"
	String SuppressTags = ""
	sslBaseAnimation[] animations = BeginGetAnims(4, SexCat = SexCat, IsCreatureScene = false, AnimTags = AnimTags, SuppressTags = SuppressTags)
	If animations.Length == 0 ; Fallback to not filtering aggressive tag if no animations found
		animations = SexLab.GetAnimationsByTags(4, AnimTags, SuppressTags)
	EndIf
	
	actor[] sexActors =  new actor[4]
	SexActors[0] = PlayerRef
	SexActors[1] = akSpeaker
	SexActors[2] = DnpcList[GetGangbangActor(Index)]
	Index += 1
	SexActors[3] = DnpcList[GetGangbangActor(Index)]
	If TeleportType > 0
		SexTeleport(TeleportType, SexActors)
	EndIf
	DoSexStartDebug(SexCat, SexActors.Length, Victim, animations.Length, AnimTags, SuppressTags)
	Sexlab.StartSex(sexActors, animations, Victim)
	If DecWillIncFame
		PostBegSex("Whore")
	EndIf
	If SexCat == 2
		Util.BegSexCount += 1
		Util.BegGangbangs += 1
	EndIf
EndFunction

; Dog sex ---------------------------------------------------------------------

Function StartDogSexOral(Actor akSpeaker, Int SexCat = 0, Bool DecWillIncFame = true, Actor Victim = none, Int TeleportType = 0)
	If SexCat > 0
		If SexCat == 2
			PreBegSex(akSpeaker)
		EndIf
		If GetIsPlayerVictim(SexCat)
			Victim = PlayerRef
		Else
			Victim = None
		EndIf
	EndIf
	
	String AnimTags = "Dog,Blowjob"
	String SuppressTags = "Cunnilingus"
	sslBaseAnimation[] animations = BeginGetAnims(2, SexCat = SexCat, IsCreatureScene = true, AnimTags = AnimTags, SuppressTags = SuppressTags)
	If animations.Length == 0 ; Fallback to not filtering aggressive tag if no animations found
		animations = SexLab.GetCreatureAnimationsByTags(2, AnimTags, SuppressTags)
	EndIf
	If animations.Length == 0
		AnimTags = "Dog,Oral"
		animations = BeginGetAnims(2, SexCat = SexCat, IsCreatureScene = true, AnimTags = AnimTags, SuppressTags = SuppressTags)
		If animations.Length == 0 ; Fallback to not filtering aggressive tag if no animations found
			animations = SexLab.GetCreatureAnimationsByTags(2, AnimTags, SuppressTags)
		EndIf
	EndIf
	
	actor[] sexActors =  new actor[2]
	SexActors[0] = PlayerRef
	SexActors[1] = BeggingDog01.GetReference() as Actor
	If TeleportType > 0
		SexTeleport(TeleportType, SexActors)
	EndIf
	DoSexStartDebug(SexCat, SexActors.Length, Victim, animations.Length, AnimTags, SuppressTags)
	Sexlab.StartSex(sexActors, animations, Victim)
	If DecWillIncFame
		PostBegSex("Beast")
	EndIf
	If SexCat == 2
		Util.BegCreatureSexCount += 1
		Util.BegDogSex += 1
		Util.BegBlowjobs += 1
	EndIf
EndFunction

Function StartDogSexVaginal(Actor akSpeaker, Int SexCat = 0, Bool DecWillIncFame = true, Actor Victim = none, Int TeleportType = 0)
	If SexCat > 0
		If SexCat == 2
			PreBegSex(akSpeaker)
		EndIf
		If GetIsPlayerVictim(SexCat)
			Victim = PlayerRef
		Else
			Victim = None
		EndIf
	EndIf
	
	String AnimTags = "Dog,Vaginal"
	String SuppressTags = "Cunnilingus"
	sslBaseAnimation[] animations = BeginGetAnims(2, SexCat = SexCat, IsCreatureScene = true, AnimTags = AnimTags, SuppressTags = SuppressTags)
	If animations.Length == 0 ; Fallback to not filtering aggressive tag if no animations found
		animations = SexLab.GetCreatureAnimationsByTags(2, AnimTags, SuppressTags)
	EndIf
	
	actor[] sexActors =  new actor[2]
	SexActors[0] = PlayerRef
	SexActors[1] = BeggingDog01.GetReference() as Actor
	If TeleportType > 0
		SexTeleport(TeleportType, SexActors)
	EndIf
	DoSexStartDebug(SexCat, SexActors.Length, Victim, animations.Length, AnimTags, SuppressTags)
	Sexlab.StartSex(sexActors, animations, Victim)
	If DecWillIncFame
		PostBegSex("Beast")
	EndIf
	If SexCat == 2
		Util.BegCreatureSexCount += 1
		Util.BegDogSex += 1
		Util.BegVagSex += 1
	EndIf
EndFunction

Function StartDogSexAnal(Actor akSpeaker, Int SexCat = 0, Bool DecWillIncFame = true, Actor Victim = none, Int TeleportType = 0)
	If SexCat > 0
		If SexCat == 2
			PreBegSex(akSpeaker)
		EndIf
		If GetIsPlayerVictim(SexCat)
			Victim = PlayerRef
		Else
			Victim = None
		EndIf
	EndIf
	
	String AnimTags = "Dog,Anal"
	String SuppressTags = "Cunnilingus"
	sslBaseAnimation[] animations = BeginGetAnims(2, SexCat = SexCat, IsCreatureScene = true, AnimTags = AnimTags, SuppressTags = SuppressTags)
	If animations.Length == 0 ; Fallback to not filtering aggressive tag if no animations found
		animations = SexLab.GetCreatureAnimationsByTags(2, AnimTags, SuppressTags)
	EndIf
	
	actor[] sexActors =  new actor[2]
	SexActors[0] = PlayerRef
	SexActors[1] = BeggingDog01.GetReference() as Actor
	If TeleportType > 0
		SexTeleport(TeleportType, SexActors)
	EndIf
	DoSexStartDebug(SexCat, SexActors.Length, Victim, animations.Length, AnimTags, SuppressTags)
	Sexlab.StartSex(sexActors, animations, Victim)
	If DecWillIncFame
		PostBegSex("Beast")
	EndIf
	If SexCat == 2
		Util.BegCreatureSexCount += 1
		Util.BegDogSex += 1
		Util.BegAnalSex += 1
	EndIf
EndFunction

Function StartDogSex3p(Actor akSpeaker, Int SexCat = 0, Bool DecWillIncFame = true, Actor Victim = none, Int TeleportType = 0)
	If SexCat > 0
		If SexCat == 2
			PreBegSex(akSpeaker)
		EndIf
		If GetIsPlayerVictim(SexCat)
			Victim = PlayerRef
		Else
			Victim = None
		EndIf
	EndIf
	
	String AnimTags = "Dog"
	String SuppressTags = ""
	sslBaseAnimation[] animations = BeginGetAnims(3, SexCat = SexCat, IsCreatureScene = true, AnimTags = AnimTags, SuppressTags = SuppressTags)
	If animations.Length == 0 ; Fallback to not filtering aggressive tag if no animations found
		animations = SexLab.GetCreatureAnimationsByTags(3, AnimTags, SuppressTags)
	EndIf
	
	actor[] sexActors =  new actor[3]
	SexActors[0] = PlayerRef
	SexActors[1] = BeggingDog01.GetReference() as Actor
	SexActors[2] = BeggingDog02.GetReference() as Actor
	If TeleportType > 0
		SexTeleport(TeleportType, SexActors)
	EndIf
	DoSexStartDebug(SexCat, SexActors.Length, Victim, animations.Length, AnimTags, SuppressTags)
	Sexlab.StartSex(sexActors, animations, Victim)
	If DecWillIncFame
		PostBegSex("Beast")
	EndIf
	If SexCat == 2
		Util.BegCreatureSexCount += 1
		Util.BegDogSex += 1
		Util.BegGangbangs += 1
	EndIf
EndFunction

Function StartDogSex4p(Actor akSpeaker, Int SexCat = 0, Bool DecWillIncFame = true, Actor Victim = none, Int TeleportType = 0)
	If SexCat > 0
		If SexCat == 2
			PreBegSex(akSpeaker)
		EndIf
		If GetIsPlayerVictim(SexCat)
			Victim = PlayerRef
		Else
			Victim = None
		EndIf
	EndIf
	
	String AnimTags = "Dog"
	String SuppressTags = ""
	sslBaseAnimation[] animations = BeginGetAnims(4, SexCat = SexCat, IsCreatureScene = true, AnimTags = AnimTags, SuppressTags = SuppressTags)
	If animations.Length == 0 ; Fallback to not filtering aggressive tag if no animations found
		animations = SexLab.GetCreatureAnimationsByTags(4, AnimTags, SuppressTags)
	EndIf
	
	actor[] sexActors =  new actor[4]
	SexActors[0] = PlayerRef
	SexActors[1] = BeggingDog01.GetReference() as Actor
	SexActors[2] = BeggingDog02.GetReference() as Actor
	SexActors[3] = BeggingDog02.GetReference() as Actor
	If TeleportType > 0
		SexTeleport(TeleportType, SexActors)
	EndIf
	DoSexStartDebug(SexCat, SexActors.Length, Victim, animations.Length, AnimTags, SuppressTags)
	Sexlab.StartSex(sexActors, animations, Victim)
	If DecWillIncFame
		PostBegSex("Beast")
	EndIf
	If SexCat == 2
		Util.BegCreatureSexCount += 1
		Util.BegDogSex += 1
		Util.BegGangbangs += 1
	EndIf
EndFunction

; Wolf sex ----------------------------------------------------------------------

Function StartWolfSexOral(Actor akSpeaker, Int SexCat = 0, Bool DecWillIncFame = true, Actor Victim = none, Int TeleportType = 0)
	If SexCat > 0
		If SexCat == 2
			PreBegSex(akSpeaker)
		EndIf
		If GetIsPlayerVictim(SexCat)
			Victim = PlayerRef
		Else
			Victim = None
		EndIf
	EndIf
	
	String AnimTags = "Wolf,Blowjob" ; Try for blowjob animations first. Oral includes any scene with oral at any stage => may not cum in mouth
	String SuppressTags = "Cunnilingus"
	sslBaseAnimation[] animations = SexLab.GetCreatureAnimationsByTags(2, AnimTags, TagSuppress = SuppressTags)
	If animations.Length == 0 ; Fallback to not filtering aggressive tag if no animations found
		animations = SexLab.GetCreatureAnimationsByTags(2, AnimTags, SuppressTags)
	EndIf
	If animations.Length == 0
		AnimTags = "Wolf,Oral"
		animations = BeginGetAnims(2, SexCat = SexCat, IsCreatureScene = true, AnimTags = AnimTags, SuppressTags = SuppressTags)
		If animations.Length == 0 ; Fallback to not filtering aggressive tag if no animations found
			animations = SexLab.GetCreatureAnimationsByTags(2, AnimTags, SuppressTags)
		EndIf
	EndIf
	
	actor[] sexActors =  new actor[2]
	SexActors[0] = PlayerRef
	SexActors[1] = BeggingWolf01.GetReference() as Actor
	If TeleportType > 0
		SexTeleport(TeleportType, SexActors)
	EndIf
	DoSexStartDebug(SexCat, SexActors.Length, Victim, animations.Length, AnimTags, SuppressTags)
	Sexlab.StartSex(sexActors, animations, Victim)
	If DecWillIncFame
		PostBegSex("Beast")
	EndIf
	If SexCat == 2
		Util.BegCreatureSexCount += 1
		Util.BegWolfSex += 1
		Util.BegBlowjobs += 1
	EndIf
EndFunction

Function StartWolfSexVaginal(Actor akSpeaker, Int SexCat = 0, Bool DecWillIncFame = true, Actor Victim = none, Int TeleportType = 0)
	If SexCat > 0
		If SexCat == 2
			PreBegSex(akSpeaker)
		EndIf
		If GetIsPlayerVictim(SexCat)
			Victim = PlayerRef
		Else
			Victim = None
		EndIf
	EndIf
	
	String AnimTags = "Wolf,Vaginal"
	String SuppressTags = "Cunnilingus"
	sslBaseAnimation[] animations = BeginGetAnims(2, SexCat = SexCat, IsCreatureScene = true, AnimTags = AnimTags, SuppressTags = SuppressTags)
	If animations.Length == 0 ; Fallback to not filtering aggressive tag if no animations found
		animations = SexLab.GetCreatureAnimationsByTags(2, AnimTags, SuppressTags)
	EndIf
	
	actor[] sexActors =  new actor[2]
	SexActors[0] = PlayerRef
	SexActors[1] = BeggingWolf01.GetReference() as Actor
	If TeleportType > 0
		SexTeleport(TeleportType, SexActors)
	EndIf
	DoSexStartDebug(SexCat, SexActors.Length, Victim, animations.Length, AnimTags, SuppressTags)
	Sexlab.StartSex(sexActors, animations, Victim)
	If DecWillIncFame
		PostBegSex("Beast")
	EndIf
	If SexCat == 2
		Util.BegCreatureSexCount += 1
		Util.BegWolfSex += 1
	EndIf
EndFunction

Function StartWolfSexAnal(Actor akSpeaker, Int SexCat = 0, Bool DecWillIncFame = true, Actor Victim = none, Int TeleportType = 0)
	If SexCat > 0
		If SexCat == 2
			PreBegSex(akSpeaker)
		EndIf
		If GetIsPlayerVictim(SexCat)
			Victim = PlayerRef
		Else
			Victim = None
		EndIf
	EndIf
	
	String AnimTags = "Wolf,Anal"
	String SuppressTags = "Cunnilingus"
	sslBaseAnimation[] animations = BeginGetAnims(2, SexCat = SexCat, IsCreatureScene = true, AnimTags = AnimTags, SuppressTags = SuppressTags)
	If animations.Length == 0 ; Fallback to not filtering aggressive tag if no animations found
		animations = SexLab.GetCreatureAnimationsByTags(2, AnimTags, SuppressTags)
	EndIf
	
	actor[] sexActors =  new actor[2]
	SexActors[0] = PlayerRef
	SexActors[1] = BeggingWolf01.GetReference() as Actor
	If TeleportType > 0
		SexTeleport(TeleportType, SexActors)
	EndIf
	DoSexStartDebug(SexCat, SexActors.Length, Victim, animations.Length, AnimTags, SuppressTags)
	Sexlab.StartSex(sexActors, animations, Victim)
	If DecWillIncFame
		PostBegSex("Beast")
	EndIf
	If SexCat == 2
		Util.BegCreatureSexCount += 1
		Util.BegWolfSex += 1
		Util.BegVagSex += 1
		Util.BegAnalSex += 1
	EndIf
EndFunction

Function StartWolfSex3p(Actor akSpeaker, Int SexCat = 0, Bool DecWillIncFame = true, Actor Victim = none, Int TeleportType = 0)
	If SexCat > 0
		If SexCat == 2
			PreBegSex(akSpeaker)
		EndIf
		If GetIsPlayerVictim(SexCat)
			Victim = PlayerRef
		Else
			Victim = None
		EndIf
	EndIf
	
	String AnimTags = "Wolf"
	String SuppressTags = ""
	sslBaseAnimation[] animations = BeginGetAnims(3, SexCat = SexCat, IsCreatureScene = true, AnimTags = AnimTags, SuppressTags = SuppressTags)
	If animations.Length == 0 ; Fallback to not filtering aggressive tag if no animations found
		animations = SexLab.GetCreatureAnimationsByTags(3, AnimTags, SuppressTags)
	EndIf
	
	actor[] sexActors =  new actor[3]
	SexActors[0] = PlayerRef
	SexActors[1] = BeggingWolf01.GetReference() as Actor
	SexActors[2] = BeggingWolf02.GetReference() as Actor
	If TeleportType > 0
		SexTeleport(TeleportType, SexActors)
	EndIf
	DoSexStartDebug(SexCat, SexActors.Length, Victim, animations.Length, AnimTags, SuppressTags)
	Sexlab.StartSex(sexActors, animations, Victim)
	If DecWillIncFame
		PostBegSex("Beast")
	EndIf
	If SexCat == 2
		Util.BegCreatureSexCount += 1
		Util.BegWolfSex += 1
		Util.BegGangbangs += 1
	EndIf
EndFunction

Function StartWolfSex4p(Actor akSpeaker, Int SexCat = 0, Bool DecWillIncFame = true, Actor Victim = none, Int TeleportType = 0)
	If SexCat > 0
		If SexCat == 2
			PreBegSex(akSpeaker)
		EndIf
		If GetIsPlayerVictim(SexCat)
			Victim = PlayerRef
		Else
			Victim = None
		EndIf
	EndIf
	
	String AnimTags = "Wolf"
	String SuppressTags = ""
	sslBaseAnimation[] animations = BeginGetAnims(4, SexCat = SexCat, IsCreatureScene = true, AnimTags = AnimTags, SuppressTags = SuppressTags)
	If animations.Length == 0 ; Fallback to not filtering aggressive tag if no animations found
		animations = SexLab.GetCreatureAnimationsByTags(4, AnimTags, SuppressTags)
	EndIf
	
	actor[] sexActors =  new actor[4]
	SexActors[0] = PlayerRef
	SexActors[1] = BeggingWolf01.GetReference() as Actor
	SexActors[2] = BeggingWolf02.GetReference() as Actor
	SexActors[3] = BeggingWolf02.GetReference() as Actor
	If TeleportType > 0
		SexTeleport(TeleportType, SexActors)
	EndIf
	DoSexStartDebug(SexCat, SexActors.Length, Victim, animations.Length, AnimTags, SuppressTags)
	Sexlab.StartSex(sexActors, animations, Victim)
	If DecWillIncFame
		PostBegSex("Beast")
	EndIf
	If SexCat == 2
		Util.BegCreatureSexCount += 1
		Util.BegWolfSex += 1
		Util.BegGangbangs += 1
	EndIf
EndFunction

; Horse sex -----------------------------------------------------------------

Function StartHorseSexOral(Actor akSpeaker, Int SexCat = 0, Bool DecWillIncFame = true, Actor Victim = none, Int TeleportType = 0)
	If SexCat > 0
		If SexCat == 2
			PreBegSex(akSpeaker)
		EndIf
		If GetIsPlayerVictim(SexCat)
			Victim = PlayerRef
		Else
			Victim = None
		EndIf
	EndIf
	
	String AnimTags = "Horse,Blowjob"
	String SuppressTags = ""
	sslBaseAnimation[] animations = SexLab.GetCreatureAnimationsByTags(2, AnimTags, TagSuppress = SuppressTags)
	If animations.Length == 0 ; Fallback to not filtering aggressive tag if no animations found
		animations = SexLab.GetCreatureAnimationsByTags(2, AnimTags, SuppressTags)
	EndIf
	If animations.Length == 0
		AnimTags = "Horse,Oral"
		animations = BeginGetAnims(2, SexCat = SexCat, IsCreatureScene = true, AnimTags = AnimTags, SuppressTags = SuppressTags)
		If animations.Length == 0 ; Fallback to not filtering aggressive tag if no animations found
			animations = SexLab.GetCreatureAnimationsByTags(2, AnimTags, SuppressTags)
		EndIf
	EndIf
	actor[] sexActors =  new actor[2]
	SexActors[0] = PlayerRef
	SexActors[1] = BeggingHorse01.GetReference() as Actor
	If TeleportType > 0
		SexTeleport(TeleportType, SexActors)
	EndIf
	DoSexStartDebug(SexCat, SexActors.Length, Victim, animations.Length, AnimTags, SuppressTags)
	Sexlab.StartSex(sexActors, animations, Victim)
	If DecWillIncFame
		PostBegSex("Beast")
	EndIf
	If SexCat == 2
		Util.BegCreatureSexCount += 1
		Util.BegHorseSex += 1
		Util.BegBlowjobs += 1
	EndIf
EndFunction

Function StartHorseSexVaginal(Actor akSpeaker, Int SexCat = 0, Bool DecWillIncFame = true, Actor Victim = none, Int TeleportType = 0)
	If SexCat > 0
		If SexCat == 2
			PreBegSex(akSpeaker)
		EndIf
		If GetIsPlayerVictim(SexCat)
			Victim = PlayerRef
		Else
			Victim = None
		EndIf
	EndIf
	
	String AnimTags = "Horse,Vaginal"
	String SuppressTags = ""
	sslBaseAnimation[] animations = BeginGetAnims(2, SexCat = SexCat, IsCreatureScene = true, AnimTags = AnimTags, SuppressTags = SuppressTags)
	If animations.Length == 0 ; Fallback to not filtering aggressive tag if no animations found
		animations = SexLab.GetCreatureAnimationsByTags(2, AnimTags, SuppressTags)
	EndIf
	
	actor[] sexActors =  new actor[2]
	SexActors[0] = PlayerRef
	SexActors[1] = BeggingHorse01.GetReference() as Actor
	If TeleportType > 0
		SexTeleport(TeleportType, SexActors)
	EndIf
	DoSexStartDebug(SexCat, SexActors.Length, Victim, animations.Length, AnimTags, SuppressTags)
	Sexlab.StartSex(sexActors, animations, Victim)
	If DecWillIncFame
		PostBegSex("Beast")
	EndIf
	If SexCat == 2
		Util.BegCreatureSexCount += 1
		Util.BegHorseSex += 1
		Util.BegVagSex += 1
	EndIf
EndFunction

Function StartHorseSexAnal(Actor akSpeaker, Int SexCat = 0, Bool DecWillIncFame = true, Actor Victim = none, Int TeleportType = 0)
	If SexCat > 0
		If SexCat == 2
			PreBegSex(akSpeaker)
		EndIf
		If GetIsPlayerVictim(SexCat)
			Victim = PlayerRef
		Else
			Victim = None
		EndIf
	EndIf
	
	String AnimTags = "Horse,Anal"
	String SuppressTags = ""
	sslBaseAnimation[] animations = BeginGetAnims(2, SexCat = SexCat, IsCreatureScene = true, AnimTags = AnimTags, SuppressTags = SuppressTags)
	If animations.Length == 0 ; Fallback to not filtering aggressive tag if no animations found
		animations = SexLab.GetCreatureAnimationsByTags(2, AnimTags, SuppressTags)
	EndIf
	
	actor[] sexActors =  new actor[2]
	SexActors[0] = PlayerRef
	SexActors[1] = BeggingHorse01.GetReference() as Actor
	If TeleportType > 0
		SexTeleport(TeleportType, SexActors)
	EndIf
	DoSexStartDebug(SexCat, SexActors.Length, Victim, animations.Length, AnimTags, SuppressTags)
	Sexlab.StartSex(sexActors, animations, Victim)
	If DecWillIncFame
		PostBegSex("Beast")
	EndIf
	If SexCat == 2
		Util.BegCreatureSexCount += 1
		Util.BegHorseSex += 1
		Util.BegAnalSex += 1
	EndIf
EndFunction

Function StartHorseSex3p(Actor akSpeaker, Int SexCat = 0, Bool DecWillIncFame = true, Actor Victim = none, Int TeleportType = 0)
	If SexCat > 0
		If SexCat == 2
			PreBegSex(akSpeaker)
		EndIf
		If GetIsPlayerVictim(SexCat)
			Victim = PlayerRef
		Else
			Victim = None
		EndIf
	EndIf
	
	String AnimTags = "Horse"
	String SuppressTags = ""
	sslBaseAnimation[] animations = BeginGetAnims(3, SexCat = SexCat, IsCreatureScene = true, AnimTags = AnimTags, SuppressTags = SuppressTags)
	If animations.Length == 0 ; Fallback to not filtering aggressive tag if no animations found
		animations = SexLab.GetCreatureAnimationsByTags(3, AnimTags, SuppressTags)
	EndIf
	
	actor[] sexActors =  new actor[3]
	SexActors[0] = PlayerRef
	SexActors[1] = BeggingHorse01.GetReference() as Actor
	SexActors[2] = BeggingHorse02.GetReference() as Actor
	If TeleportType > 0
		SexTeleport(TeleportType, SexActors)
	EndIf
	DoSexStartDebug(SexCat, SexActors.Length, Victim, animations.Length, AnimTags, SuppressTags)
	Sexlab.StartSex(sexActors, animations, Victim)
	If DecWillIncFame
		PostBegSex("Beast")
	EndIf
	If SexCat == 2
		Util.BegCreatureSexCount += 1
		Util.BegHorseSex += 1
		Util.BegGangbangs += 1
	EndIf
EndFunction

Function StartHorseSex4p(Actor akSpeaker, Int SexCat = 0, Bool DecWillIncFame = true, Actor Victim = none, Int TeleportType = 0)
	If SexCat > 0
		If SexCat == 2
			PreBegSex(akSpeaker)
		EndIf
		If GetIsPlayerVictim(SexCat)
			Victim = PlayerRef
		Else
			Victim = None
		EndIf
	EndIf
	
	String AnimTags = "Horse"
	String SuppressTags = ""
	sslBaseAnimation[] animations = BeginGetAnims(4, SexCat = SexCat, IsCreatureScene = true, AnimTags = AnimTags, SuppressTags = SuppressTags)
	If animations.Length == 0 ; Fallback to not filtering aggressive tag if no animations found
		animations = SexLab.GetCreatureAnimationsByTags(4, AnimTags, SuppressTags)
	EndIf
	
	actor[] sexActors =  new actor[4]
	SexActors[0] = PlayerRef
	SexActors[1] = BeggingHorse01.GetReference() as Actor
	SexActors[2] = BeggingHorse02.GetReference() as Actor
	SexActors[3] = BeggingHorse02.GetReference() as Actor
	If TeleportType > 0
		SexTeleport(TeleportType, SexActors)
	EndIf
	DoSexStartDebug(SexCat, SexActors.Length, Victim, animations.Length, AnimTags, SuppressTags)
	Sexlab.StartSex(sexActors, animations, Victim)
	If DecWillIncFame
		PostBegSex("Beast")
	EndIf
	If SexCat == 2
		Util.BegCreatureSexCount += 1
		Util.BegHorseSex += 1
		Util.BegGangbangs += 1
	EndIf
EndFunction

Function UpdateDialogFactors()
	Init.FreeDeviceSlots = Devious.GetNumFreeSlots(PlayerRef)
	If Init.MilkAddictInstalled
		UpdateMaAddictionPool()
	EndIf
	If Init.SkoomaWhoreInstalled
		UpdateSwDrugPool()
	EndIf
	If Init.RapeTatsInstalled
		CheckFreeSlavetats()
	EndIf
EndFunction

Function UpdateMaAddictionPool()
	If Init.MilkAddictInstalled
		Init.LactacidAddiction = Init.MaAddictionPool.GetValueInt()
	EndIf
EndFunction

Function UpdateSwDrugPool()
	If Init.SkoomaWhoreInstalled
		Init.SwPhysicalPool = Init.SwPhysicalDecay.GetValueInt()
	EndIf
EndFunction

Function CheckFreeSlavetats()
	
	Int i
	i = Tats.GetAvailableSlots(PlayerRef, "Body")
	If i != -1
		Init.FreeTatSlotsBody = Menu.MaxTatsBody - i		
	Else
		Init.FreeTatSlotsBody = -1
	EndIf
	Debug.Trace("SLS_: Free tats Body = " + Init.FreeTatSlotsBody)
	
	i = Tats.GetAvailableSlots(PlayerRef, "Face")
	If i != -1
		Init.FreeTatSlotsFace = Menu.MaxTatsFace - i
	Else
		Init.FreeTatSlotsFace = -1
	EndIf
	Debug.Trace("SLS_: Free tats Face = " + Init.FreeTatSlotsFace)
	
	i = Tats.GetAvailableSlots(PlayerRef, "Hands")
	If i != -1
		Init.FreeTatSlotsHands = Menu.MaxTatsHands - i
	Else
		Init.FreeTatSlotsHands = -1
	EndIf
	Debug.Trace("SLS_: Free tats Hands = " + Init.FreeTatSlotsHands)
	
	i = Tats.GetAvailableSlots(PlayerRef, "Feet")
	If i != -1
		Init.FreeTatSlotsFeet = Menu.MaxTatsFeet - i
	Else
		Init.FreeTatSlotsFeet = -1
	EndIf
	Debug.Trace("SLS_: Free tats Feet = " + Init.FreeTatSlotsFeet)
	
	If Init.FreeTatSlotsBody > 0 || Init.FreeTatSlotsFace > 0 || Init.FreeTatSlotsHands > 0 || Init.FreeTatSlotsFeet > 0
		Init.HasFreeTatsSlot = true
	Else
		Init.HasFreeTatsSlot = false
	EndIf
	
EndFunction

Function FilterGold(Float StealChance)
	If StealChance > 0.0
		AddInventoryEventFilter(Gold001)
	Else
		RemoveInventoryEventFilter(Gold001)
	EndIf
EndFunction

Bool Function IsDegradationSuccess()
	Bool Success = true
	If Init.DegradationDialogPlayerChoice[0] != Init.DegradationDialogNpcChoice[0]
		Success = false
	ElseIf Init.DegradationDialogPlayerChoice[1] != Init.DegradationDialogNpcChoice[1]
		Success = false
	ElseIf Init.DegradationDialogPlayerChoice[2] != Init.DegradationDialogNpcChoice[2]
		Success = false
	ElseIf Init.DegradationDialogPlayerChoice[3] != Init.DegradationDialogNpcChoice[3]
		Success = false
	EndIf
	Return Success
EndFunction

Function BegClothesDeal(ObjectReference akSpeaker)
	If PlayerRef.WornHasKeyword(ClothingBody) || PlayerRef.WornHasKeyword(ArmorCuirass)
		Util.StripBodyClothesTo(akSpeaker, DoAnimation = true)
		
	Else ; If player's not wearing it got to search for it
		Int ItemIndex = PlayerRef.GetNumItems()
		While ItemIndex > 0
			ItemIndex -= 1
			Form ItemSelect = PlayerRef.GetNthForm(ItemIndex)
			If ItemSelect.HasKeyword(ClothingBody) || ItemSelect.HasKeyword(ArmorCuirass)
				PlayerRef.RemoveItem(ItemSelect, 1, false, akSpeaker)
			EndIf
		EndWhile
	EndIf
EndFunction

Function BegSuccess(Int WhatPlayerWants, Int NumItems) ; Give player what they want
	If WhatPlayerWants == 0 ; Food
		Int i = 0
		While i < NumItems
			PlayerRef.AddItem(_SLS_BegFoodList.GetAt(Utility.RandomInt(0, _SLS_BegFoodList.GetSize() - 1)))
			i += 1
		EndWhile
	
	ElseIf WhatPlayerWants == 1 ; Drink
		Int i = 0
		While i < NumItems
			PlayerRef.AddItem(_SLS_BegDrink.GetAt(Utility.RandomInt(0, _SLS_BegDrink.GetSize() - 1)))
			i += 1
		EndWhile
	
	ElseIf WhatPlayerWants == 2 ; Clothes
		Form Clothes = _SLS_BegClothes.GetAt(Utility.RandomInt(0, _SLS_BegClothes.GetSize() - 1))
		If Game.GetModByName("Mortal Weapons & Armor.esp") != 255
			Util.GiveMortalObject(PlayerRef, Clothes, 0.33, 1.0, Silent = false, FitLoosely = true, CursedChance = Menu.BegMwaCurseChance)
		Else
			PlayerRef.AddItem(Clothes)
		EndIf
	
	ElseIf WhatPlayerWants == 3 ; Skooma
		Int i = 0
		While i < NumItems
			PlayerRef.AddItem(Init.DrugsList.GetAt(Utility.RandomInt(0, Init.DrugsList.GetSize() - 1)))
			i += 1
		EndWhile
	
	ElseIf WhatPlayerWants == 4 ; Lactacid
		Int i = 0	
		While i < NumItems
			PlayerRef.AddItem(Init.MME_Lactacid, 1)
			i += 1
		EndWhile
	
	ElseIf WhatPlayerWants == 5 ; Gold
		PlayerRef.AddItem(Gold001, Math.Ceiling(Utility.RandomInt(48, 77) * Menu.BegGold))
		
	ElseIf WhatPlayerWants == 6 ; Boots
		Form Boots = _SLS_BegBoots.GetAt(Utility.RandomInt(0, _SLS_BegBoots.GetSize() - 1))
		If Game.GetModByName("Mortal Weapons & Armor.esp") != 255
			Util.GiveMortalObject(PlayerRef, Boots, 0.33, 1.0, Silent = false, FitLoosely = true, CursedChance = Menu.BegMwaCurseChance)
		Else
			PlayerRef.AddItem(Boots)
		EndIf
	EndIf
EndFunction

Function BegRandomReward(Int NumItems)
	Int[] Possibilities
	Possibilities = New Int[5]
	
	Possibilities[0] = 0
	Possibilities[1] = 1
	Int i = 2
	If !(PlayerRef.WornHasKeyword(ClothingBody) || PlayerRef.WornHasKeyword(ArmorCuirass)) && Init.NpcWants != 9
		Possibilities[i] = 2
		i += 1
	EndIf
	If Init.SkoomaWhoreInstalled
		Possibilities[i] = 3
		i += 1
	EndIf
	If Init.MilkAddictInstalled
		Possibilities[i] = 4
		i += 1
	EndIf
	While NumItems > 0
		NumItems -= 1
		BegSuccess(Possibilities[Utility.RandomInt(0, i - 1)], 1)
	EndWhile
EndFunction

Function BarefootMaintenance()
	If Menu.BarefootMag > 0.0
		_SLS_BarefootSpeedSpell.SetNthEffectMagnitude(0, Menu.BarefootMag)
	EndIf
EndFunction
;/
Function SaveMerchantGoldDefaults()
	JsonUtil.SetIntValue("SL Survival/MerchantGoldDefaults.json", "VendorGoldApothecary", VendorGoldApothecary.GetNthCount(0), allowDuplicate = false)
	JsonUtil.SetIntValue("SL Survival/MerchantGoldDefaults.json", "VendorGoldBlacksmith", VendorGoldBlacksmith.GetNthCount(0), allowDuplicate = false)
	JsonUtil.SetIntValue("SL Survival/MerchantGoldDefaults.json", "VendorGoldBlacksmithTown", VendorGoldBlacksmithTown.GetNthCount(0), allowDuplicate = false)
	JsonUtil.SetIntValue("SL Survival/MerchantGoldDefaults.json", "VendorGoldMisc", VendorGoldMisc.GetNthCount(0), allowDuplicate = false)
	JsonUtil.SetIntValue("SL Survival/MerchantGoldDefaults.json", "VendorGoldSpells", VendorGoldSpells.GetNthCount(0), allowDuplicate = false)
	JsonUtil.SetIntValue("SL Survival/MerchantGoldDefaults.json", "VendorGoldStreetVendor", VendorGoldStreetVendor.GetNthCount(0), allowDuplicate = false)
	JsonUtil.Save("SL Survival/MerchantGoldDefaults.json")
	
	;Debug.Messagebox("SaveMerchantGoldDefaults: " + VendorGoldBlacksmith.GetNthCount(0))
EndFunction
/;
Bool Function CanChangeVendorLists()
	If VendorListIsAsExpected(VendorGoldApothecary, _SLS_VendorGoldApothecaryFemale) && VendorListIsAsExpected(VendorGoldBlacksmith, _SLS_VendorGoldBlacksmithFemale) && \
		VendorListIsAsExpected(VendorGoldBlacksmithTown, _SLS_VendorGoldBlacksmithTownFemale) && VendorListIsAsExpected(VendorGoldMisc, _SLS_VendorGoldMiscFemale) && \
		VendorListIsAsExpected(VendorGoldSpells, _SLS_VendorGoldSpellsFemale) && VendorListIsAsExpected(VendorGoldStreetVendor, _SLS_VendorGoldStreetVendorFemale)
		
		Return true
	EndIf
	Return false
EndFunction

Bool Function VendorListIsAsExpected(LeveledItem List, LeveledItem ExpectedList)
	Int i = 0
	While i < List.GetNumForms()
		If List.GetNthForm(i) == ExpectedList
			Return true
		EndIf
		i += 1
	EndWhile
	Debug.Trace("_SLS_: VendorListIsAsExpected(): Failed on list: " + List + ". Expected List: " + ExpectedList)
	Return false
EndFunction

Function RestoreVendorGoldDefaults()
	VendorGoldApothecary.Revert()
	VendorGoldBlacksmith.Revert()
	VendorGoldBlacksmithTown.Revert()
	VendorGoldMisc.Revert()
	VendorGoldSpells.Revert()
	VendorGoldStreetVendor.Revert()
	
	_SLS_VendorGoldApothecaryFemale.Revert()
	_SLS_VendorGoldBlacksmithFemale.Revert()
	_SLS_VendorGoldBlacksmithTownFemale.Revert()
	_SLS_VendorGoldMiscFemale.Revert()
	_SLS_VendorGoldSpellsFemale.Revert()
	_SLS_VendorGoldStreetVendorFemale.Revert()
	
	_SLS_VendorGoldApothecaryMale.Revert()
	_SLS_VendorGoldBlacksmithMale.Revert()
	_SLS_VendorGoldBlacksmithTownMale.Revert()
	_SLS_VendorGoldMiscMale.Revert()
	_SLS_VendorGoldSpellsMale.Revert()
	_SLS_VendorGoldStreetVendorMale.Revert()
	
	Debug.Messagebox("Save, quit the game and reload your save to finalize resetting leveled lists")
EndFunction

Function IneqVendorGoldUpdate()
	If Menu.IneqFemaleVendorGoldMult != 1.0
		;Debug.Messagebox("IneqVendorGoldUpdate")
		Int GoldApothecary = JsonUtil.GetIntValue("SL Survival/MerchantGoldDefaults.json", "VendorGoldApothecary", 0)
		Int GoldBlacksmith = JsonUtil.GetIntValue("SL Survival/MerchantGoldDefaults.json", "VendorGoldBlacksmith", 0)
		Int GoldBlacksmithTown = JsonUtil.GetIntValue("SL Survival/MerchantGoldDefaults.json", "VendorGoldBlacksmithTown", 0)
		Int GoldMisc = JsonUtil.GetIntValue("SL Survival/MerchantGoldDefaults.json", "VendorGoldMisc", 0)
		Int GoldSpells = JsonUtil.GetIntValue("SL Survival/MerchantGoldDefaults.json", "VendorGoldSpells", 0)
		Int GoldStreetVendor = JsonUtil.GetIntValue("SL Survival/MerchantGoldDefaults.json", "VendorGoldStreetVendor", 0)

		ZeroListGold(VendorGoldApothecary)
		ZeroListGold(VendorGoldBlacksmith)
		ZeroListGold(VendorGoldBlacksmithTown)
		ZeroListGold(VendorGoldMisc)
		ZeroListGold(VendorGoldSpells)
		ZeroListGold(VendorGoldStreetVendor)

		FixCountLimit(_SLS_VendorGoldApothecaryFemale, (GoldApothecary * Menu.IneqFemaleVendorGoldMult) as Int)
		FixCountLimit(_SLS_VendorGoldBlacksmithFemale, (GoldBlacksmith * Menu.IneqFemaleVendorGoldMult) as Int)
		FixCountLimit(_SLS_VendorGoldBlacksmithTownFemale, (GoldBlacksmithTown * Menu.IneqFemaleVendorGoldMult) as Int)
		FixCountLimit(_SLS_VendorGoldMiscFemale, (GoldMisc * Menu.IneqFemaleVendorGoldMult) as Int)
		FixCountLimit(_SLS_VendorGoldSpellsFemale, (GoldSpells * Menu.IneqFemaleVendorGoldMult) as Int)
		FixCountLimit(_SLS_VendorGoldStreetVendorFemale, (GoldStreetVendor * Menu.IneqFemaleVendorGoldMult) as Int)

		FixCountLimit(_SLS_VendorGoldApothecaryMale, (GoldApothecary - (GoldApothecary * Menu.IneqFemaleVendorGoldMult)) as Int)
		FixCountLimit(_SLS_VendorGoldBlacksmithMale,(GoldBlacksmith - (GoldBlacksmith * Menu.IneqFemaleVendorGoldMult)) as Int)
		FixCountLimit(_SLS_VendorGoldBlacksmithTownMale, (GoldBlacksmithTown - (GoldBlacksmithTown * Menu.IneqFemaleVendorGoldMult)) as Int)
		FixCountLimit(_SLS_VendorGoldMiscMale, (GoldMisc - (GoldMisc * Menu.IneqFemaleVendorGoldMult)) as Int)
		FixCountLimit(_SLS_VendorGoldSpellsMale, (GoldSpells - (GoldSpells * Menu.IneqFemaleVendorGoldMult)) as Int)
		FixCountLimit(_SLS_VendorGoldStreetVendorMale, (GoldStreetVendor - (GoldStreetVendor * Menu.IneqFemaleVendorGoldMult)) as Int)
		
		If Init.DebugMode
			Debug.Messagebox("Apothecary - Full: " + GoldApothecary + ". Female: " + Math.Ceiling(GoldApothecary * Menu.IneqFemaleVendorGoldMult) + ". Male boost: " + Math.Ceiling(GoldApothecary - (GoldApothecary * Menu.IneqFemaleVendorGoldMult))\
							+ "\nBlacksmith - Full: " + GoldBlacksmith + ". Female: " + Math.Ceiling(GoldBlacksmith * Menu.IneqFemaleVendorGoldMult) + ". Male boost: " + Math.Ceiling(GoldBlacksmith - (GoldBlacksmith * Menu.IneqFemaleVendorGoldMult))\
							+ "\nBlacksmith Town - Full: " + GoldBlacksmithTown + ". Female: " + Math.Ceiling(GoldBlacksmithTown * Menu.IneqFemaleVendorGoldMult) + ". Male boost: " + Math.Ceiling(GoldBlacksmithTown - (GoldBlacksmithTown * Menu.IneqFemaleVendorGoldMult))\
							+ "\nMisc - Full: " + GoldMisc + ". Female: " + Math.Ceiling(GoldMisc * Menu.IneqFemaleVendorGoldMult) + ". Male boost: " + Math.Ceiling(GoldMisc - (GoldMisc * Menu.IneqFemaleVendorGoldMult))\
							+ "\nSpells - Full: " + GoldSpells + ". Female: " + Math.Ceiling(GoldSpells * Menu.IneqFemaleVendorGoldMult) + ". Male boost: " + Math.Ceiling(GoldSpells - (GoldSpells * Menu.IneqFemaleVendorGoldMult))\
							+ "\nStreet vendor - Full: " + GoldStreetVendor + ". Female: " + Math.Ceiling(GoldStreetVendor * Menu.IneqFemaleVendorGoldMult) + ". Male boost: " + Math.Ceiling(GoldStreetVendor - (GoldStreetVendor * Menu.IneqFemaleVendorGoldMult))\
							)
		EndIf
	EndIf
EndFunction

Function ZeroListGold(LeveledItem List)
	Int i = 0
	While i < List.GetNumForms()
		If List.GetNthForm(i) == Gold001
			List.SetNthCount(i, 0)
		EndIf
		i += 1
	EndWhile
EndFunction

Function FixCountLimit(LeveledItem List, Int DesiredCount)
	; Leveled list SetNthCount(Int n, Int count) -> Count can't be set higher than 255. Fix this BS by adding more forms
	; For. Fucks. Sake.
	
	List.Revert()
	int Index = 0
	While DesiredCount > 0
		If List.GetNthForm(Index) == None
			List.AddForm(Gold001, 1, 0)
		EndIf
		List.SetNthCount(Index, DesiredCount) ; If DesiredCount > 255 it'll automatically be clamped to 255
		DesiredCount -= List.GetNthCount(Index) ; Deduct how much was actually added
		Index += 1
	EndWhile
EndFunction

Function SetHelloExclusions()
	Int i = 0
	Actor akTarget
	While i < JsonUtil.FormListCount("SL Survival/HelloExclusions.json", "helloexclusions")
		akTarget = JsonUtil.FormListGet("SL Survival/HelloExclusions.json", "helloexclusions", i) as Actor
		If akTarget
			akTarget.AddToFaction(Menu.AllInOne._SLS_NoHelloCommentsFact)
		EndIf
		i += 1
	EndWhile
EndFunction

; Global Variables ===========================================================================================================

Bool PauseEquip = false

; PROPERTIES =================================================================================================================

Float Property Version Auto Hidden

LeveledItem Property VendorGoldApothecary Auto
LeveledItem Property VendorGoldBlacksmith Auto
LeveledItem Property VendorGoldBlacksmithTown Auto
LeveledItem Property VendorGoldMisc Auto
LeveledItem Property VendorGoldSpells Auto
LeveledItem Property VendorGoldStreetVendor Auto

LeveledItem Property _SLS_VendorGoldApothecaryMale Auto
LeveledItem Property _SLS_VendorGoldBlacksmithMale Auto
LeveledItem Property _SLS_VendorGoldBlacksmithTownMale Auto
LeveledItem Property _SLS_VendorGoldMiscMale Auto
LeveledItem Property _SLS_VendorGoldSpellsMale Auto
LeveledItem Property _SLS_VendorGoldStreetVendorMale Auto

LeveledItem Property _SLS_VendorGoldApothecaryFemale Auto
LeveledItem Property _SLS_VendorGoldBlacksmithFemale Auto
LeveledItem Property _SLS_VendorGoldBlacksmithTownFemale Auto
LeveledItem Property _SLS_VendorGoldMiscFemale Auto
LeveledItem Property _SLS_VendorGoldSpellsFemale Auto
LeveledItem Property _SLS_VendorGoldStreetVendorFemale Auto

GlobalVariable Property _SLS_TollCost Auto
GlobalVariable Property _MWA_FittingArmorCount Auto
GlobalVariable Property _SLS_LicInspPersistence Auto
GlobalVariable Property _SLS_BikiniBreakCustomCount Auto

Key Property WhiterunBreezehomeKey Auto
Key Property SolitudeHouseKey Auto
Key Property MS11HjerimKey Auto
Key Property RiftenHoneysideKey Auto
Key Property MarkarthVlindrelHallKey Auto

Keyword Property ActorTypeCreature Auto
Keyword Property Clothingbody Auto
Keyword Property ArmorCuirass Auto
Keyword Property ArmorClothing Auto
Keyword Property ArmorLight Auto
Keyword Property ArmorHeavy Auto
Keyword Property VendorItemWeapon Auto
Keyword Property ClothingFeet Auto
Keyword Property ArmorBoots Auto
Keyword Property ClothingHands Auto
Keyword Property ArmorGauntlets Auto
Keyword Property ClothingHead Auto
Keyword Property ArmorHelmet Auto
Keyword Property SexlabNoStrip Auto

Book Property _SLS_EvictionNotice Auto

FormList Property _SLS_RaceCumList Auto
FormList Property _SLS_HouseKeys Auto
FormList Property _SLS_AlchList Auto
FormList Property _SLS_BegFoodList Auto
FormList Property _SLS_BegFoodCrapList Auto
FormList Property _SLS_BegFoodTreat Auto
FormList Property _SLS_BegDrink Auto
FormList Property _SLS_BegClothes Auto
Formlist Property _SLS_BegBoots Auto

MiscObject Property _SLS_LoadGameTestObject Auto
MiscObject Property _SLS_EvictionNoteValueDummy Auto
MiscObject Property Gold001 Auto

Actor Property PlayerRef Auto

Armor Property _SLS_NeverAddedArmor Auto
Armor Property _SLS_HalfNakedCoverArmor Auto
Armor BikinifierHalfNakedArmor

ReferenceAlias Property NearestNpc Auto

ReferenceAlias Property Client Auto ; akSpeaker - Who you're working for
ReferenceAlias Property Dnpc Auto ; Begging quest - The Npc choosen for the player to degrade herself to
ReferenceAlias Property DegradingNpc01 Auto ; BeggingSearch quest - The first Npc search alias. Get more in case one is akSpeaker or zaz slave
ReferenceAlias Property DegradingNpc02 Auto 
ReferenceAlias Property DegradingNpc03 Auto 
ReferenceAlias Property DegradingNpc04 Auto 
ReferenceAlias Property DegradingNpc05 Auto 
ReferenceAlias Property BeggingWolf01 Auto
ReferenceAlias Property BeggingWolf02 Auto
ReferenceAlias Property BeggingWolf03 Auto
ReferenceAlias Property BeggingDog01 Auto
ReferenceAlias Property BeggingDog02 Auto
ReferenceAlias Property BeggingDog03 Auto
ReferenceAlias Property BeggingHorse01 Auto
ReferenceAlias Property BeggingHorse02 Auto
ReferenceAlias Property BeggingHorse03 Auto

Quest Property _SLS_EvictionNoticeTakeRefFind Auto
Quest Property _SLS_BeggingSearch Auto
Quest Property _SLS_BeggingSelfDegradation Auto
Quest Property _SLS_HasPlayerClothes Auto

Spell Property _SLS_DrinkAlcohol Auto
Spell Property _SLS_MilkLeakWet Auto
Spell Property _SLS_WarmBodies Auto
Spell Property _SLS_AssessStash Auto
Spell Property _SLS_SwimCleanCum Auto
Spell Property _SLS_NoParaFactRemoveSpell Auto
Spell Property _SLS_BarefootSpeedSpell Auto
Spell Property _SLS_DrugFatigueIncSpell Auto
Spell Property _SLS_LicInspLostSightSpell Auto

Perk Property _SLS_CreatureTalk Auto
Perk Property _SLS_GagBegPerk Auto
Perk Property _SLS_IncPickpocketLootPerk Auto

Faction Property CurrentFollowerFaction Auto
Faction Property _SLS_NoParalyzeFact Auto

Potion Property Skooma Auto

SLS_Init Property Init Auto
SLS_EvictionTrack Property Eviction Auto
SLS_Mcm Property Menu Auto
_SLS_Needs Property Needs Auto
SLS_Utility Property Util Auto
_SLS_LicenceUtil Property LicUtil Auto
_SLS_BikiniBreak Property BikiniBreak Auto

_SLS_InterfaceRnd Property RndInterface Auto
_SLS_InterfaceIneed Property Ineed Auto
_SLS_InterfaceSlaverun Property Slaverun Auto
_SLS_InterfaceDevious Property Devious Auto
_SLS_InterfacePaySexCrime Property PaySexCrime Auto
_SLS_InterfaceFrostfall Property Frostfall Auto
_SLS_InterfaceEff Property Eff Auto
_SLS_InterfaceSlavetats Property Tats Auto
_SLS_InterfaceMilkAddict Property MilkAddict Auto
_SLS_InterfaceSlsf Property Slsf Auto
_SLS_InterfaceSlif Property Slif Auto
_SLS_InterfaceDeviousFollowers Property Dflow Auto

SexLabFramework Property SexLab Auto



; DUMPING GROUND =============================================================================================================

;/
	UI.SetNumber("MapMenu", "_root._mapMovie.YouAreHereMarker._alpha", 0.0)
	UI.SetBool("MapMenu", "_root._mapMovie.YouAreHereMarker._visible", false)
	
	UI.SetBool("MapMenu", "_root.MapClip.YouAreHereMarker._visible", false)
	UI.SetNumber("MapMenu", "_root.MapClip.YouAreHereMarker._alpha", 0.0)
	
	UI.SetBool("MapMenu", "_root.bottomBar.YouAreHereMarker._visible", false)
	UI.SetNumber("MapMenu", "_root.bottomBar.YouAreHereMarker._alpha", 0.0)

	UI.SetBool("MapMenu", "_root.bottomBar.YouAreHereMarker._visible", false)
	UI.SetNumber("MapMenu", "_root.bottomBar.YouAreHereMarker._alpha", 0.0)

	UI.SetBool("MapMenu", "_root.locationFinderFader.YouAreHereMarker._visible", false)
	UI.SetNumber("MapMenu", "_root.locationFinderFader.YouAreHereMarker._alpha", 0.0)

	UI.SetBool("MapMenu", "_global.Map.MapMenu.YouAreHereMarker._visible", false)
	UI.SetNumber("MapMenu", "_global.Map.MapMenu.YouAreHereMarker._alpha", 0.0)

	UI.SetBool("MapMenu", "_root.Map.MapMenu.YouAreHereMarker._visible", false)
	UI.SetNumber("MapMenu", "_root.Map.MapMenu.YouAreHereMarker._alpha", 0.0)
	
	UI.SetBool("MapMenu", "_root.bottomBar.DateText._visible", false)
	UI.SetNumber("MapMenu", "_root.bottomBar.DateText._alpha", 0.0)

	UI.SetBool("MapMenu", "_root.bottomBar.MapClip._visible", false)
	UI.SetNumber("MapMenu", "_root.bottomBar.MapClip._alpha", 0.0)

	UI.SetBool("MapMenu", "_root.bottomBar.LocationText._visible", false)
	UI.SetNumber("MapMenu", "_root.bottomBar.LocationText._alpha", 0.0)

	UI.SetBool("MapMenu", "_root.localMapFader.LocalMapRect._visible", false)
	UI.SetNumber("MapMenu", "_root.localMapFader.LocalMapRect._alpha", 0.0)

	UI.SetBool("MapMenu", "_root.localMapFader.LocalMapHolder_mc._visible", false)
	UI.SetNumber("MapMenu", "_root.localMapFader.LocalMapHolder_mc._alpha", 0.0)

	UI.SetBool("MapMenu", "_root.bottomBar.SetCurrentLocationEnabled", true)
	UI.SetNumber("MapMenu", "_root.bottomBar.PlayerLocButton._alpha", 0.0)

	;UI.SetBool(MAP_MENU, "_root.IconClip.YouAreHereMarker._visible", false)
	;UI.SetBool(MAP MENU, "_root.IconClip.YouAreHereMarker._visible", false)
	

	;_global.Map.MapMenu
/; 
