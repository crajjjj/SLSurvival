Scriptname SLS_Init extends Quest Conditional

Event OnInit()
	Debug.Trace("SLS_: Init begin =================================================================")
	
	DegradationDialogNpcChoice = New Int[4]
	DegradationDialogPlayerChoice = New Int[4]
	PlayerLoadsGame()
	
	; Dawnguard - OnInit - Can't see people uninstalling and reinstalling dawnguard
	DawnguardInstalled = false
	VoiceType MuttVoice = Game.GetFormFromFile(0x00011687, "Dawnguard.esm") as VoiceType ; Husky voice type
	If MuttVoice != None
		DawnguardInstalled = true
		Debug.Trace("SLS_: Dawnguard Installed")
		_SLS_RaceCum_Dog.AddForm(MuttVoice)
	Else
		Debug.Trace("SLS_: Dawnguard NOT Installed")
	EndIf

	; 'Something' (:P) is adding lactacid to skooma whores drug list. Copy SW list into ours and filter out lactacid
	If SkoomaWhoreInstalled
		Int i = 0
		Form DrugSelect
		While i < DrugsList.GetSize()
			DrugSelect = DrugsList.GetAt(i)
			If DrugSelect != (MME_Lactacid as Form)
				_SLS_DrugsListWoLactacid.AddForm(DrugSelect)
			EndIf
			i += 1
		EndWhile
	EndIf
	
	; Enable Toll objects for extra door in riften if JK skyrim is installed
	If JkSkrimInstalled
		int i = 0
		While i < _SLS_JkRiftenTollObjs.GetSize()
			(_SLS_JkRiftenTollObjs.GetAt(i) as ObjectReference).Enable()
			i += 1
		EndWhile
		;/
		While _SLS_TolledGates.GetNthAlias(0) as ReferenceAlias == None ; Need to wait for the game to start the toll quest and fill aliases. Forcing refs below too soon results in other aliases being empty for some reason...
			Utility.Wait(10.0)
		EndWhile
		Utility.Wait(2.0)
		JkRiftenExtraDoorInterior.ForceRefTo(TollGateRiftenJkSkyrimInterior)
		JkRiftenExtraDoorExterior.ForceRefTo(TollGateRiftenJkSkyrimExterior)/;
		_SLS_TollDoorsRiften.AddForm(TollGateRiftenJkSkyrimInterior)
		_SLS_TollDoorsRiften.AddForm(TollGateRiftenJkSkyrimExterior)
	EndIf
EndEvent

; Internal mod functions ====================================================================================

Function PlayerLoadsGame()
	
	Debug.Trace("SLS_: Soft dependency check begin =================================================================")
	
	; Devious Devices
	DdsInstalled = Game.GetModByName("Devious Devices - Expansion.esm") != 255
	If DdsInstalled
		BeggingPlayerAlias.GoToState("Devious")
	Else
		BeggingPlayerAlias.GoToState("")
	EndIf
	Debug.Trace("SLS_: Devious Devices Installed: " + DdsInstalled)
	
	; Cursed Loot
	DclInstalled = Game.GetModByName("Deviously Cursed Loot.esp") != 255
	If Game.GetModByName("Deviously Cursed Loot.esp") != 255
		Dcl_bondageadventurequest = Game.GetFormFromFile(0x0000B495, "Deviously Cursed Loot.esp") as Quest
		_SLS_DclTrack.Start()
	Else
		_SLS_DclTrack.Stop()
	EndIf
	Debug.Trace("SLS_: Cursed Loot Installed: " + DclInstalled)
	
	; Skooma Whore
	SkoomaWhoreInstalled = Game.GetModByName("SexLabSkoomaWhore.esp") != 255
	If SkoomaWhoreInstalled
		DrugsList = Game.GetFormFromFile(0x00020C71, "SexLabSkoomaWhore.esp") as FormList
		SwPhysicalDecay = Game.GetFormFromFile(0x00001D9D, "SexLabSkoomaWhore.esp") as GlobalVariable
		If Util._SLS_SkoomaWhoreMagicEffects.GetSize() == 0
			Util.SetupSwEffectsList()
		EndIf
	EndIf
	Debug.Trace("SLS_: Skooma Whore Installed: " + SkoomaWhoreInstalled)
	
	; MME
	MaOrMmeInstalled = false
	MmeInstalled = Game.GetModByName("MilkModNEW.esp") != 255
	If MmeInstalled
		MME_Milk = Game.GetFormFromFile(0x0006D61F, "MilkModNEW.esp") as Keyword
		MME_LeakingMilk = Game.GetFormFromFile(0x00030898, "MilkModNEW.esp") as MagicEffect
		MME_Lactacid = Game.GetFormFromFile(0x000343F2,"MilkModNEW.esp") as Potion
		MaOrMmeInstalled = true
	EndIf
	Debug.Trace("SLS_: Milk Mod Economy Installed: " + MmeInstalled)
	
	; SL Dialogs
	DialogsInstalled = Game.GetModByName("SexLab_Dialogues.esp") != 255
	If DialogsInstalled
		RestEffect = Game.GetFormFromFile(0x00020B5A, "SexLab_Dialogues.esp") as MagicEffect
	EndIf
	Debug.Trace("SLS_: Sexlab Dialogs Installed: " + DialogsInstalled)
	
	; Rape Tattoos
	RapeTatsInstalled = Game.GetModByName("RapeTattoos.esp") != 255
	If RapeTatsInstalled
		Quest RapeTats = Game.GetFormFromFile(0x00000D62, "RapeTattoos.esp") as Quest
	EndIf
	Debug.Trace("SLS_: Rape Tattoos Installed: " + RapeTatsInstalled)
	
	; TDF Aggressive Prostitution
	TdfProsInstalled = Game.GetModByName("SexLab TDF Aggressive Prostitution.esp") != 255
	If TdfProsInstalled
		TdfDance = Game.GetFormFromFile(0x0001FE42, "SexLab TDF Aggressive Prostitution.esp") as Spell
	EndIf
	Debug.Trace("SLS_: TDF Aggressive Prostitution Installed: " + TdfProsInstalled)
	
	; Milk Addict
	MilkAddictInstalled = Game.GetModByName("Milk Addict.esp") != 255
	If MilkAddictInstalled
		MaAddictionPool = Game.GetFormFromFile(0x00008424, "Milk Addict.esp") as GlobalVariable
		MaOrMmeInstalled = true
	EndIf
	Debug.Trace("SLS_: Milk Addict Installed: " + MilkAddictInstalled)
	
	; Paradise Halls
	PahInstalled = Game.GetModByName("paradise_halls.esm") != 255
	If PahInstalled
		PahFaction = Game.GetFormFromFile(0x000047DB, "paradise_halls.esm") as Faction
	Else
		PahFaction = _SLS_DummyNeverUsedFact
	EndIf
	Debug.Trace("SLS_: Paradise Halls Installed: " + PahInstalled)
	
	; Sexy Bandit Captives
	SbcInstalled = Game.GetModByName("SexyBanditCaptives.esp") != 255
	If SbcInstalled
		SbcFaction = Game.GetFormFromFile(0x0000E6B7, "SexyBanditCaptives.esp") as Faction
	Else
		SbcFaction = _SLS_DummyNeverUsedFact
	EndIf
	Debug.Trace("SLS_: Sexy Bandit Captives Installed: " + SbcInstalled)
	
	; Sexlab Separate Orgasm
	SlsoInstalled = Game.GetModByName("SLSO.esp") != 255
	If SlsoInstalled
		Quest SlsoQuest = Game.GetFormFromFile(0x000D62,"SLSO.esp") as Quest
	EndIf
	Debug.Trace("SLS_: Sexlab Separate Orgasm Installed: " + SlsoInstalled)
	
	; Slaverun Reloaded
	SlvrunRelInstalled = Game.GetModByName("Slaverun_Reloaded.esp") != 255
	Debug.Trace("SLS_: Slaverun Reloaded Installed: " + SlvrunRelInstalled)
	
	; PaySexCrime
	PscInstalled = Game.GetModByName("Sexlab_PaySexCrime.esp") != 255
	Debug.Trace("SLS_: PaySexCrime Installed: " + PscInstalled)
	
	; Devious Followers
	DflowInstalled = Game.GetModByName("DeviousFollowers.esp") != 255
	If DflowInstalled
		Quest DflowMcm = Game.GetFormFromFile(0x0000C545, "DeviousFollowers.esp") as Quest
	EndIf
	Debug.Trace("SLS_: Devious Followers Installed: " + DflowInstalled)
	
	; Zaz Animation Pack
	ZazInstalled = Game.GetModByName("ZaZAnimationPack.esm") != 255
	If ZazInstalled
		ZazSlaveFaction = Game.GetFormFromFile(0x0096AE, "ZaZAnimationPack.esm") as Faction
		zbfFactionAnimating = Game.GetFormFromFile(0x00E2B7, "ZaZAnimationPack.esm") as Faction
		RandomZazSlave = Game.GetFormFromFile(0x00A6E0, "ZaZAnimationPack.esm") as ActorBase
	Else
		ZazSlaveFaction = _SLS_DummyNeverUsedFact
		zbfFactionAnimating = _SLS_DummyNeverUsedFact
	EndIf
	Debug.Trace("SLS_: Zaz Animation Pack Installed: " + ZazInstalled)
	
	; Simple Slavery
	SimpleSlaveryInstalled = Game.GetModByName("SimpleSlavery.esp") != 255
	If SimpleSlaveryInstalled
		Quest SimSlvQuest = Game.GetFormFromFile(0x0000492E, "SimpleSlavery.esp") as Quest
	EndIf
	Debug.Trace("SLS_: Simple Slavery Installed: " + SimpleSlaveryInstalled)
	
	; Sanguines Debauchery
	SdInstalled = Game.GetModByName("sanguinesDebauchery.esp") != 255
	If SdInstalled
		Quest SdMcm = Game.GetFormFromFile(0x00092327, "sanguinesDebauchery.esp") as Quest
	EndIf
	Debug.Trace("SLS_: Sanguines Debauchery Installed: " + SdInstalled)
	
	; Frostfall
	FrostfallInstalled = Game.GetModByName("Frostfall.esp") != 255
	If FrostfallInstalled
		Quest FfQuest = Game.GetFormFromFile(0x00064AF8, "Frostfall.esp") as Quest ; Not used. Just to test is installed
	EndIf
	Debug.Trace("SLS_: Frostfall Installed: " + FrostfallInstalled)
	
	; Hunterborn
	HunterbornInstalled = Game.GetModByName("Hunterborn.esp") != 255
	If HunterbornInstalled
		HuntersCache = Game.GetFormFromFile(0x0003A15A, "Hunterborn.esp")
	EndIf
	Debug.Trace("SLS_: Hunterborn Installed: " + HunterbornInstalled)
	
	; JKs Skyrim
	JkSkrimInstalled = Game.GetModByName("JKs Skyrim.esp") != 255
	If JkSkrimInstalled
		TollGateRiftenJkSkyrimInterior = Game.GetFormFromFile(0x0001466C, "JKs Skyrim.esp") as ObjectReference
		TollGateRiftenJkSkyrimExterior = Game.GetFormFromFile(0x0000DC5, "JKs Skyrim.esp") as ObjectReference
		If JkRiftenExtraDoorInterior.GetReference() == None ; If for some reason the JK door aliases are empty, fill them. If the TolledGates quest is stopped and started these aliases will not be filled. So check & fill them here. 
			If (_SLS_TolledGates.GetNthAlias(0) as ReferenceAlias).GetReference() != None ; Wait for other aliases to be filled. Game empties other aliases if the below is forced too soon....
				JkRiftenExtraDoorInterior.ForceRefTo(TollGateRiftenJkSkyrimInterior)
				JkRiftenExtraDoorExterior.ForceRefTo(TollGateRiftenJkSkyrimExterior)
			EndIf
		EndIf
	EndIf
	Debug.Trace("SLS_: JKs Skyrim installed: " + JkSkrimInstalled)
	
	Debug.Trace("SLS_: Soft dependency check end ==============================================================")
	
	
	If (SexLab.GetCreatureAnimationsByTags(4, "Dog", TagSuppress = "")).Length > 0
		DogGangbangAnims = 3
	EndIf
	If (SexLab.GetCreatureAnimationsByTags(3, "Dog", TagSuppress = "")).Length > 0
		If DogGangbangAnims == 3
			DogGangbangAnims = 2
		Else
			DogGangbangAnims = 1
		EndIf
	EndIf
	Debug.Trace("SLS_: DogGangbangAnims = " + DogGangbangAnims)
	
	If (SexLab.GetCreatureAnimationsByTags(4, "Wolf", TagSuppress = "")).Length > 0
		WolfGangbangAnims = 3
	EndIf
	If (SexLab.GetCreatureAnimationsByTags(3, "Wolf", TagSuppress = "")).Length > 0
		If WolfGangbangAnims == 3
			WolfGangbangAnims = 2
		Else 
			WolfGangbangAnims = 1
		EndIf
	EndIf
	Debug.Trace("SLS_: WolfGangbangAnims = " + WolfGangbangAnims)
	
	If (SexLab.GetCreatureAnimationsByTags(4, "Horse", TagSuppress = "")).Length > 0
		HorseGangbangAnims = 3
	EndIf
	If (SexLab.GetCreatureAnimationsByTags(3, "Horse", TagSuppress = "")).Length > 0
		If HorseGangbangAnims == 3
			HorseGangbangAnims = 2
		Else
			HorseGangbangAnims = 1
		EndIf
	EndIf
	Debug.Trace("SLS_: HorseGangbangAnims = " + HorseGangbangAnims)
	
	LicUtil.PlayerLoadsGame()
	Menu.PlayerLoadsGame()
	GuardWarnDrugs.PlayerLoadsGame()
EndFunction

Function CheckTaskReset()
	Bool Reset = true
	If CanDoBlowjob == 1
		Reset = false
	EndIf
	If CanDoDevices == 1
		Reset = false
	EndIf
	If SkoomaWhoreInstalled && CanDoMilkOrSkooma == 1
		Reset = false
	EndIf
	If MmeInstalled && CanDoMilkOrSkooma == 1
		Reset = false
	EndIf
	If RapeTatsInstalled && CanDoTats == 1
		Reset = false
	EndIf
	If TdfProsInstalled && CanDoDance == 1 && TollAllowDance
		Reset = false
	EndIf
	
	If Reset
		ResetCanDos()
	EndIf
	Debug.Trace("SLS_: CanDoBlowjob = " + CanDoBlowjob)
	Debug.Trace("SLS_: CanDoDevices = " + CanDoDevices)
	Debug.Trace("SLS_: CanDoMilkOrSkooma = " + CanDoMilkOrSkooma)
	Debug.Trace("SLS_: CanDoTats = " + CanDoTats)
	Debug.Trace("SLS_: CanDoDance = " + CanDoDance)
	Debug.Trace("SLS_: TollAllowDance = " + TollAllowDance)
	Debug.Trace("SLS_: CanDo =================================================")
EndFunction

Function ResetCanDos()
	Debug.Trace("SLS_: Reset CanDos")
	CanDoBlowjob = 1
	If FreeDeviceSlots > 0
		CanDoDevices = 1
	EndIf
	
	CanDoMilkOrSkooma = ForceDrug.GetCanDoMilkOrSkooma() as Int
	
	If RapeTatsInstalled && HasFreeTatsSlot
		CanDoTats = 1
	EndIf
	If TdfProsInstalled
		CanDoDance = 1
	EndIf
EndFunction

; Devious Followers ===================================================================

Function DecDflowWill()
	Dflow.DecDflowWill()
EndFunction

Bool Property SKdialog = true Auto Hidden Conditional
Bool Property DawnguardInstalled = false Auto Hidden
Bool Property DdsInstalled = false Auto Hidden Conditional
Bool Property DclInstalled = false Auto Hidden Conditional
Bool Property SkoomaWhoreInstalled = false Auto Hidden Conditional
Bool Property MmeInstalled = false Auto Hidden Conditional
Bool Property DialogsInstalled = false Auto Hidden
Bool Property RapeTatsInstalled = false Auto Hidden Conditional
Bool Property HasFreeTatsSlot = true Auto Hidden Conditional
Bool Property TdfProsInstalled = false Auto Hidden Conditional
Bool Property MilkAddictInstalled = false Auto Hidden Conditional
Bool Property MaOrMmeInstalled = false Auto Hidden Conditional
Bool Property PahInstalled = false Auto Hidden ; Paradise Halls
Bool Property SbcInstalled = false Auto Hidden ; Sexy bandit captives
Bool Property SlsoInstalled = false Auto Hidden ; SL Separate Orgasm
Bool Property FrostfallInstalled = false Auto Hidden
Bool Property HunterbornInstalled = false Auto Hidden
Bool Property JkSkrimInstalled = false Auto Hidden
Bool Property IsTollPaid = false Auto Hidden Conditional
Bool Property TollDialogDevicesDoOnce = False Auto Hidden Conditional
Bool Property TollAllowDance = true Auto Hidden Conditional
Bool Property SlvrunRelInstalled = false Auto Hidden Conditional
Bool Property IsEnslavedTown = false Auto Hidden Conditional
Bool Property IsTollSwallowDeal = false Auto Hidden
Bool Property PscInstalled = false Auto Hidden
Bool Property IsSpeakerMale = true Auto Hidden Conditional
Bool Property IsSpeakerSlave = false Auto Hidden Conditional
Bool Property DflowInstalled = false Auto Hidden Conditional
Bool Property IsSlaverunSlave = false Auto Hidden Conditional
Bool Property ZazInstalled = false Auto Hidden
Bool Property IsDegradationSuccess = false Auto Hidden Conditional
Bool Property IsPlayerInside = false Auto Hidden Conditional
Bool Property IsGagDeal = false Auto Hidden Conditional
Bool Property IsPlayerEatBlocked = false Auto Hidden Conditional
Bool Property EvictionForceGreetDone = false Auto Hidden Conditional
Bool Property SleepRoughWarning = false Auto Hidden Conditional
Bool Property KennelForceGreetIntroDone = false Auto Hidden
Bool Property SimpleSlaveryInstalled = false Auto Hidden Conditional
Bool Property SdInstalled = false Auto Hidden Conditional
Bool Property SlsCreatureEvents = false Auto Hidden Conditional
Bool Property PlayerIsHardGagged = false Auto Hidden Conditional
Bool Property PlayerHandsAreAvailable = true Auto Hidden Conditional
Bool Property LicencesEnable = true Auto Hidden Conditional
Bool Property TollDodgeGiftMenu = true Auto Hidden Conditional
Bool Property CanEquipDeviousBoots = true Auto Hidden Conditional
Bool Property DebugMode = false Auto Hidden Conditional
Bool Property HousePurchaseDialogueState = false Auto Hidden Conditional
Bool Property IsKneeling = false Auto Hidden Conditional
Bool Property IsCrawling = false Auto Hidden Conditional
Bool Property TollEnable = true Auto Hidden Conditional

Int[] Property DegradationDialogNpcChoice Auto Hidden
Int[] Property DegradationDialogPlayerChoice Auto Hidden

Int Property CumBreathLevel = 0 Auto Hidden
Int Property TollIntroState = 0 Auto Hidden Conditional
Int Property TollCost = 100 Auto Hidden Conditional
Int Property FreeDeviceSlots = 10 Auto Hidden Conditional
Int Property LactacidAddiction = 1000 Auto Hidden Conditional ; Initialize drug pools. If they're not installed it won't influence toll drugs dialog
Int Property SwPhysicalPool = 1000 Auto Hidden Conditional
Int Property FreeTatSlotsBody Auto Hidden
Int Property FreeTatSlotsFace Auto Hidden
Int Property FreeTatSlotsHands Auto Hidden
Int Property FreeTatSlotsFeet Auto Hidden
Int Property HasEnoughFollowers = -1 Auto Hidden Conditional
Int Property TollJobsToDo = 1 Auto Hidden
Int Property CanDoBlowjob = 1 Auto Hidden Conditional
Int Property CanDoDevices = 1 Auto Hidden Conditional
Int Property CanDoMilkOrSkooma = 1 Auto Hidden Conditional
Int Property CanDoTats = 1 Auto Hidden Conditional
Int Property CanDoDance = 1 Auto Hidden Conditional
Int Property PlayerWants = 0 Auto Hidden Conditional ; 0 - Food, 1 - Drink, 2 - Clothes, 3 - Skooma, 4 - Lactacid, 5 - Gold, 6 - Boots
Int Property NpcWants = 0 Auto Hidden Conditional ; 0 - Oral, 1 - Vaginal, 2 - Anal, 3 - Gangbang, 4 - Dog Oral, 5 - Dog Vaginal, 6 - Dog Anal, 7 - Dog Gangbang, 8 - Horse Oral, 9 - Horse Vaginal, 10 - Horse Anal, 11 - Horse Gangbang, 12 - Players Clothes, 13 - Degradation, 14 - Fuck gift
Int Property BeggingWolvesFound = 0 Auto Hidden Conditional
Int Property BeggingDogsFound = 0 Auto Hidden Conditional
Int property BeggingHorsesFound = 0 Auto Hidden Conditional
Int Property BegSwallowDeal = 0 Auto Hidden Conditional ; 0 - Inactive, 1 - Active, 2 - Committed, 3 - Success, 4 - Failed
Int Property ClientOrgasmState = 0 Auto Hidden Conditional ; 0 - Inactive, 1 - Active, 2 - Committed, 3 - Success, 4 - Failed
Int Property GuardWarnedOutcome = -1 Auto Hidden Conditional ; 0 - Skooma, 1 - Lactacid, 2 - Devices, 3 - Kennel, 4 - Bribe, 5 - Stocks, 6 - Curfew, 7 - Bounty
Int Property TrollSexKeepersDesire = -1 Auto Hidden Conditional ; 0 - DDs, 1 - Sex, 2 - Drugs, 3 - Gold, 4 - Tats.
Int Property PpFailDevices = 4 Auto Hidden Conditional 
Int Property KennelResDeal = -1 Auto Hidden Conditional ; -1 - Begin state, 0 - Deal proposed, 1 - Deal accepted, 2 - Fail
Int Property KennelDealLicence Auto Hidden ; Same as IssueLicence() vars

Bool Property ThreepAnimAvailable = false Auto Hidden Conditional
Bool Property FourpAnimAvailable = false Auto Hidden Conditional
Bool Property OralAnimAvailable = false Auto Hidden Conditional
Bool Property AnalAnimAvailable = false Auto Hidden Conditional
Bool Property VaginalAnimAvailable = false Auto Hidden Conditional
Int Property GangbangCreaturesAvailable = 0 Auto Hidden Conditional ; How many creatures of the same race there are in the vicinity

Int Property DogGangbangAnims = 0 Auto Hidden Conditional ; 0 - 2p only, 1 - 2p+3p, 2 - 2p+3p+4p, 3 - 2p+4P. 2P Animations are assumed
Int Property WolfGangBangAnims = 0 Auto Hidden Conditional
Int Property HorseGangbangAnims = 0 Auto Hidden Conditional
Int Property BeggingDnpcFound = 0 Auto Hidden Conditional
Int Property KennelState = 0 Auto Hidden Conditional ; 0 - Intro, 1 - Normal, 2 - Kennel Deal, 3 - Cage Deal, 4 - Force Greet Intro, 5 - Force Greet, 6 - Allowed to leave
Int Property KnockLeaveResult = 0 Auto Hidden Conditional ; 0 - Release, 1 - Simple Slavery, 2 - Sanguines Debauchery
Int Property SpankCounter = 0 Auto Hidden

Float Property MmeMilkCapacity = 0.0 Auto Hidden Conditional

;/
Float Property GroundedUntilWhiterun = 0.0 Auto Hidden
Float Property GroundedUntilSolitude = 0.0 Auto Hidden
Float Property GroundedUntilMarkarth = 0.0 Auto Hidden
Float Property GroundedUntilWindhelm = 0.0 Auto Hidden
Float Property GroundedUntilRiften = 0.0 Auto Hidden
/;

Actor Property PlayerRef Auto

ActorBase Property RandomZazSlave Auto Hidden

Faction Property ZazSlaveFaction Auto Hidden
Faction Property zbfFactionAnimating Auto Hidden	
Faction Property PahFaction Auto Hidden
Faction Property SbcFaction Auto Hidden
Faction Property _SLS_DummyNeverUsedFact Auto

FormList Property _SLS_RaceCum_Dog Auto
FormList Property DrugsList Auto Hidden
FormList Property _SLS_JkRiftenTollObjs Auto
FormList Property _SLS_DrugsListWoLactacid Auto
FormList Property _SLS_TollDoorsMarkarth Auto
FormList Property _SLS_TollDoorsSolitude Auto
FormList Property _SLS_TollDoorsWhiterun Auto
FormList Property _SLS_TollDoorsWindhelm Auto
FormList Property _SLS_TollDoorsRiften Auto

Keyword Property MME_Milk Auto Hidden

Spell Property TdfDance Auto Hidden

MagicEffect Property RestEffect Auto Hidden
MagicEffect Property MME_LeakingMilk Auto Hidden
MagicEffect Property SwPhysicalDecayMgef Auto Hidden

Armor Property BegDealGag Auto Hidden
Armor Property TollGag Auto Hidden
Armor Property BegDealHeavyBondage Auto Hidden

Form Property HuntersCache Auto Hidden

Potion Property MME_Lactacid Auto Hidden

GlobalVariable Property MaAddictionPool Auto Hidden
GlobalVariable Property SwPhysicalDecay Auto Hidden

ReferenceAlias Property JkRiftenExtraDoorInterior Auto
ReferenceAlias Property JkRiftenExtraDoorExterior Auto

ObjectReference Property LastReadEvictionNotice Auto Hidden
ObjectReference Property TollGateRiftenJkSkyrimInterior Auto Hidden
ObjectReference Property TollGateRiftenJkSkyrimExterior Auto Hidden

Quest Property _SLS_TolledGates Auto
Quest Property Dcl_bondageadventurequest Auto Hidden
Quest Property _SLS_DclTrack Auto
Quest Property DialogueFollower Auto

SLS_Utility Property Util Auto
SLS_Mcm Property Menu Auto
SLS_Main Property Main Auto
SLS_BeggingPlayerAlias Property BeggingPlayerAlias Auto
SexlabFramework Property Sexlab Auto
_SLS_LicenceUtil Property LicUtil Auto
_SLS_InterfaceDeviousFollowers Property Dflow Auto
_SLS_GuardWarnDrugsAlias Property GuardWarnDrugs Auto
_SLS_ForcedDrugging Property ForceDrug Auto
