Scriptname _STA_SexDialogUtil extends Quest Conditional

Float Property StaVersion Auto Hidden

String OldState = "" ; Needs to be removed - testing only

String[] TearsProgression
String[] DroolTextures
Int Property CurrentTears = -1 Auto Hidden
Int Property TearsCooldownInterval = 300 Auto Hidden Conditional
Int Property DroolCooldown = 180 Auto Hidden Conditional
Float Property TearsOpacity = 0.99 Auto Hidden
Float Property DroolOpacity = 0.99 Auto Hidden

Float Property MinStaminaRate = 2.5 Auto Hidden
Float Property MinStaminaMult = 60.0 Auto Hidden
Float Property MinMagickaRate = 1.5 Auto Hidden
Float Property MinMagickaMult = 50.0 Auto Hidden
Float Property PainDebuffMax = 10.0 Auto Hidden
Float Property SexSoundVol = 0.8 Auto Hidden
Float Property AssClapChance = 50.0 Auto Hidden

SexlabFramework Property Sexlab Auto
_STA_SpankUtil Property SpankUtil Auto
_STA_InterfaceDeviousDevices Property DeviousInterface Auto
_STA_InterfaceMme Property MmeInterface Auto
_STA_InterfaceSlso Property SlsoInterface Auto
_STA_Mcm Property Menu Auto

Bool Property DialogOutInProgress = false Auto Hidden
Bool Property NpcDialogOutInProgress = false Auto Hidden
Int Property ConflictingDialogCooloff = 0 Auto Hidden ; Cool off on player dislikes dialog after Mid mouse presses
String Property NpcDialogAsString Auto Hidden

Bool Property IsDdInstalled Auto Hidden ; Needs Integration
Bool Property IsSlsoInstalled Auto Hidden ; Needs integration
Bool Property IsMmeInstalled Auto Hidden ; Needs integration
Bool Property OnlyFollowerSpanks = false Auto Hidden
Float Property FollowerSexSpankChance = 50.0 Auto Hidden

Int Property SpankCooldown = 0 Auto Hidden
Int Property SpeakKey = 258 Auto Hidden

Int Property SexPartnerGender Auto Hidden Conditional ; 0 - Male, 1 - Female
Int Property SexPartnerRace Auto Hidden Conditional ; 0 - Dog, 1 - Horse, 
Int Property SexPartnerCount Auto Hidden Conditional 
Int Property IsMouthAvailable = 1 Auto Hidden Conditional
Bool Property IsCreature Auto Hidden Conditional
Bool Property IsOral Auto Hidden Conditional
Bool Property IsAnal Auto Hidden Conditional
Bool Property IsVaginal Auto Hidden Conditional
Bool Property IsAnalOrVaginal Auto Hidden Conditional ; Simplify dialog conditions 
Bool Property IsPlayerMasochist Auto Hidden Conditional
Bool Property IsPlayerVictim Auto Hidden Conditional
Float Property SexIdleCommentChance = 5.0 Auto Hidden Conditional
Float Property SpankyNpcChance = 30.0 Auto Hidden ; The base chance an Npc will be of the spank-happy variety
Float SpankyNpcChanceMod = 0.0 ; The increase of chance per rape of getting a spanky type Npc
Float Property VanillaRapeSpankChance = 20.0 Auto Hidden
Float Property GagTalkChance = 20.0 Auto Hidden ; Normally the player will be silent when gagged. This is chance for 'gag talk' when a normal comment is requested

; Enjoyment - SLSO only
Int Property LowJoyThreshold = 35 Auto Hidden ; Not enjoying comments ; Needs MCM Setting
Int Property MidJoyThreshold = 60 Auto Hidden; Mid enjoying comments ; Needs MCM Setting
Int Property NearOrgasmJoyThreshold = 80 Auto Hidden; Near orgasm comments ; Needs MCM Setting
Int Property BaseSpankEnjoyment = 5 Auto Hidden ; Base enjoyment gained from spanking during sex which is * Masochism attitude (-2, -1, 1, 2) ; Needs MCM Setting
Int Property FuckBackTick = 3 Auto Hidden ; Time allowance gained for fucking back
Int Property DenigrateTick = 4 Auto Hidden
Int PlayerEnjoyment

; MME
Bool Property IsPlayerLeakingMilk Auto Hidden Conditional
Bool Property IsPlayerBreastsFull Auto Hidden Conditional
Float Property MmeSlapLeakChance = 15.0 Auto Hidden
Float SexSpankChance
Float SexSpankChanceMod

Int CurrentTid
Int NumOfStages
Int BonusEnjoymentKey
Int NpcSexDialogCooldown = 0
Bool IsMasturbation
Bool CanDoRegularComment = false
Bool IsPlayerBroken = false
Bool IsNpcTheSpankyType = false
String DroolTexture

Actor Property PlayerRef Auto
Actor Property SexPartner Auto Hidden

ActorBase Property _STA_PlayerDuplicate Auto

ObjectReference Property _STA_PlayerTactRef Auto

Faction Property _STA_RapeDialogFaction Auto
Faction Property SexLabAnimatingFaction Auto
Faction Property CurrentFollowerFaction Auto

Spell Property _STA_DialogOutputSpell Auto
Spell Property _STA_DialogOutputNpcSpell Auto
Spell Property _STA_TearsCooldownSpell Auto
Spell Property _STA_DroolCooldownSpell Auto
Spell Property _STA_SexMinMagickaRateSpell Auto
Spell Property _STA_SexMinMagickaRateMultSpell Auto
Spell Property _STA_SexMinStaminaRateSpell Auto
Spell Property _STA_SexMinStaminaRateMultSpell Auto
Spell Property _STA_PainDebuff Auto
Spell Property _STA_PainMasochistBuff Auto
Spell Property _STA_PainMasochistDebuff Auto

Formlist Property _STA_DialogQueue Auto
Formlist Property _STA_DialogQueuePriority Auto
Formlist Property _STA_DogRaceList Auto
Formlist Property _STA_HorseRaceList Auto
Formlist Property _STA_NearOrgasmCommentDone Auto
Formlist Property _STA_SpankHappyCreaturesList Auto

Quest Property _STA_ZazGagDroolQuest Auto
Quest Property _STA_GagRemoveDetectQuest Auto

Keyword Property zad_DeviousGag Auto Hidden

Sound Property _STA_Fucking Auto
Sound Property _STA_FuckingSlimy Auto
Sound Property _STA_Sucking Auto

; TOPIC PROPERTIES ========================================================

Topic Property DummyNpcWhatToSay Auto Hidden

; Npc sex
Topic Property _STA_SexDialogNpcSexStartTopic Auto
Topic Property _STA_SexDialogNpcSexHappyTopic Auto
Topic Property _STA_SexDialogNpcOrgasmNearHappyTopic Auto
Topic Property _STA_SexDialogNpcSexFinishTopic Auto

; Npc rape
Topic Property _STA_SexDialogNpcRapeStartTopic Auto
Topic Property _STA_SexDialogNpcSexUnhappyTopic Auto
Topic Property _STA_SexDialogNpcOrgasmNearUnhappyTopic Auto
Topic Property _STA_SexDialogNpcRapeCumTopic Auto

; Creature rape
Topic Property _STA_SexDialogCreatureRapeStartTopic Auto
Topic Property _STA_SexDialogCreatureSexUnhappyTopic Auto
Topic Property _STA_SexDialogCreatureOrgasmNearUnhappyTopic Auto
Topic Property _STA_SexDialogCreatureRapeCumTopic Auto
Topic Property _STA_SexDialogCreatureRapeFinishTopic Auto

Topic Property _STA_SexDialogCreatureSexMiddleTopic Auto

; Creature sex
Topic Property _STA_SexDialogueCreatureSexStartTopic Auto
Topic Property _STA_SexDialogCreatureSexHappyTopic Auto
Topic Property _STA_SexDialogCreatureOrgasmNearHappyTopic Auto
Topic Property _STA_SexDialogCreatureSexCumTopic Auto
Topic Property _STA_SexDialogCreatureSexFinishTopic Auto

; Misc
Topic Property _STA_SexDialogPlayerOrgasmNearTopic Auto
Topic Property _STA_SpankingNpcDialogForceSlutTopic Auto
Topic Property _STA_SpankingPlayerSpankRequestTopic Auto
Topic Property _STA_SpankingPlayerDenigrateTopic Auto
Topic Property _STA_SpankingPlayerFucksBack Auto
Topic Property _STA_PlayerGaggedDialogTopic Auto

; MME
Topic Property _STA_MmeDialogTitsFullTopic Auto

; Devious Devices
Topic Property _STA_DeviousDevicesViberateTopic Auto

; Bathing in Skyrim
Topic Property _STA_BisDialogCleanTopic Auto

; EVENTS ====================================================================
Event OnInit()
	PapyrusUtilCheck()
	StaVersion = 4.8
	SetupTextureArrays()
	CheckZazGags()
	RegisterForEvents()
	Utility.Wait(3.0)
	IsSlsoInstalled = GetIsSlsoInstalled()
	IsDdInstalled = GetIsDdInstalled()
	IsMmeInstalled = GetIsMmeInstalled()
	AddDlcSpankHappyCreatures()
EndEvent

; FUNCTIONS =================================================================
Function PlayerLoadsGame()
	PapyrusUtilCheck()
	VersionCheck()
	IsSlsoInstalled = GetIsSlsoInstalled()
	IsMmeInstalled = GetIsMmeInstalled()
	IsDdInstalled = GetIsDdInstalled()
	CheckZazGags()
	_STA_PlayerDuplicate.SetName(PlayerRef.GetBaseObject().GetName())
	_STA_PlayerTactRef.GetBaseObject().SetName(PlayerRef.GetBaseObject().GetName())
	DroolGameLoad()
	TearsGameLoad()
	RegisterForEvents()
	DummyNpcWhatToSay = None
EndFunction

Function VersionCheck()
	If StaVersion < 4.8
		If StaVersion < 3.5
			Quest QuestSelect = Game.GetFormFromFile(0x000D62, "Spank That Ass.esp") as Quest
			QuestSelect.Stop()
			Utility.Wait(0.1)
			QuestSelect.Start()
			StaVersion = 3.5
			Debug.Messagebox("Spank That Ass updated to v3.5\nYour masochism progress has been reset")
			Debug.Notification("Spank That Ass updated to v3.5")
		EndIf
		If StaVersion < 3.8
			SpankUtil.RemoveOverlay(PlayerRef, "actors\\character\\SlaveTats\\drool\\drool1.dds", "Face")
			SpankUtil.RemoveOverlay(PlayerRef, "actors\\character\\SlaveTats\\drool\\drool2.dds", "Face")
			SpankUtil.RemoveOverlay(PlayerRef, "actors\\character\\SlaveTats\\drool\\drool3.dds", "Face")
			DroolTexture == ""
			
			SpankUtil.RemoveOverlay(PlayerRef, "actors\\character\\SlaveTats\\drool\\drool1.dds", "Face")
			SpankUtil.RemoveOverlay(PlayerRef, "actors\\character\\SlaveTats\\drool\\drool2.dds", "Face")
			SpankUtil.RemoveOverlay(PlayerRef, "actors\\character\\SlaveTats\\drool\\drool3.dds", "Face")
			DroolTexture = ""
			
			AddDlcSpankHappyCreatures()
			StaVersion = 3.8
			Debug.Notification("Spank That Ass updated to v3.8")
		EndIf
		If StaVersion < 3.9
			Quest DeviousQuest = Game.GetFormFromFile(0x00CB90, "Spank That Ass.esp") as Quest
			DeviousQuest.Stop()
			DeviousQuest.Start()
			Utility.Wait(3.0)
			DeviousInterface.PlayerLoadsGame()
			StaVersion = 3.9
			Debug.Notification("Spank That Ass updated to v3.9")
		EndIf
		If StaVersion < 4.0
			StaVersion = 4.0
			Debug.Notification("Spank That Ass updated to v4.0")
		EndIf
		If StaVersion < 4.2
			UnRegisterForKey(0)
			StaVersion = 4.2
			Debug.Notification("Spank That Ass updated to v4.2")
		EndIf
		If StaVersion < 4.5
			UnRegisterForAllKeys()
			StaVersion = 4.5
			Debug.Notification("Spank That Ass updated to v4.5")
		EndIf
		
		If StaVersion < 4.8
			StaVersion = 4.8
			Debug.Notification("Spank That Ass updated to v4.8")
		EndIf
	EndIf
EndFunction

Function AddDlcSpankHappyCreatures()
	_STA_SpankHappyCreaturesList.AddForm(Game.GetFormFromFile(0x017F44, "Dragonborn.esm")) ; Reikling
	_STA_SpankHappyCreaturesList.AddForm(Game.GetFormFromFile(0x00283A, "Dawnguard.esm")) ; Vampire lord
EndFunction

Function PapyrusUtilCheck()
	If PapyrusUtil.GetVersion() < 33
		Debug.Messagebox("Spank That Ass: Your version of PapyrusUtil is outdated. \n\nYou either need to update your PapyrusUtil or check that it is not overwritten by an older version (Some mods include an outdated version)")
	EndIf
EndFunction

Function CheckZazGags()
	If Game.GetModByName("ZaZAnimationPack.esm") != 255
		_STA_ZazGagDroolQuest.Start()
	Else
		_STA_ZazGagDroolQuest.Stop()
	EndIf
EndFunction

Function SetupTextureArrays()
	TearsProgression = new String[5]
	TearsProgression[0] = "tears1.dds"
	TearsProgression[1] = "tears2.dds"
	TearsProgression[2] = "sob1.dds"
	TearsProgression[3] = "tears3.dds"
	TearsProgression[4] = "sob2.dds"
	
	DroolTextures = new String[3]
	DroolTextures[0] = "drool1.dds"
	DroolTextures[1] = "drool2.dds"
	DroolTextures[2] = "drool3.dds"
EndFunction

Bool Function GetIsSlsoInstalled()
	If Game.GetModByName("SLSO.esp") != 255
		Return true
	EndIf
	Return false
EndFunction

Bool Function GetIsMmeInstalled()
	If Game.GetModByName("MilkModNEW.esp") != 255
		Return true
	EndIf
	Return false
EndFunction

Bool Function GetIsDdInstalled()
	If Game.GetModByName("Devious Devices - Integration.esm") != 255
		zad_DeviousGag = Game.GetFormFromFile(0x007EB8, "Devious Devices - Assets.esm") as Keyword
		_STA_GagRemoveDetectQuest.Start()
		Return true
	Else
		_STA_GagRemoveDetectQuest.Stop()
		Return false
	EndIf
EndFunction

Function RegisterForEvents()
	; Vanilla

	; Misc
	RegisterForModEvent("MME_MilkCycleComplete", "OnMME_MilkCycleComplete")
	RegisterForModEvent("Bis_BatheEvent", "OnBis_BatheEvent")
	RegisterForModEvent("DeviceVibrateEffectStart", "OnDeviceVibrateEffectStart")
	RegisterForModEvent("DDI_DeviceEquipped", "OnDDI_DeviceEquipped")
	RegisterForModEvent("DDI_DeviceRemoved", "OnDDI_DeviceRemoved")
	
	; Sex
	RegisterForModEvent("HookStageStart", "OnStageStart")
    RegisterForModEvent("HookAnimationStart", "OnAnimationStart")
    RegisterForModEvent("HookAnimationStart", "OnAnimationStart")
	RegisterForModEvent("HookAnimationEnd", "OnAnimationEnd")
	RegisterForModEvent("HookAnimationChange", "OnAnimationChange")
	
	If IsSlsoInstalled
		RegisterForModEvent("SexLabOrgasmSeparate", "OnSexLabOrgasmSeparate")
	Else
		RegisterForModEvent("HookOrgasmStart", "OnOrgasmStart")
		RegisterForModEvent("HookOrgasmEnd", "OnOrgasmEnd")
	EndIf
EndFunction

Function SetSexSpankChance()
	If OnlyFollowerSpanks
		If FollowerSexSpankChance > Utility.RandomFloat(0.0, 100.0)
			IsNpcTheSpankyType = true
			Debug.Notification("There's a vicious look in " + SexPartner.GetBaseObject().GetName() + "'s eyes")
		Else
			IsNpcTheSpankyType = false
		EndIf
	
	Else
		If IsPlayerVictim
			If SpankyNpcChance + SpankyNpcChanceMod > Utility.RandomFloat(0.0, 100.0)
				IsNpcTheSpankyType = true
				SpankyNpcChanceMod = 0.0
				Debug.Notification("There's a vicious look in " + SexPartner.GetBaseObject().GetName() + "'s eyes")
			Else
				IsNpcTheSpankyType = false
				SpankyNpcChanceMod += Menu.SpankyNpcIncPerRape
			EndIf
			
			If IsPlayerMasochist || IsMasturbation
				SexSpankChance = 0.0
			Else
				If 15.0 > Utility.RandomFloat(0.0, 100.0)  ; Chance for super spanky Npc
					SexSpankChance = 100.0
				ElseIf SexPartner == None ; Solo
					SexSpankChance = 0.0
				Else ; Otherwise
					SexSpankChance = Utility.RandomFloat(15.0, 65.0)
				EndIf
			EndIf
			
		Else
			SexSpankChance =  1.0
		EndIf
	EndIf
EndFunction

Function SetSexPartnerRace()
	Race SexPartnerRaceTemp = SexPartner.GetRace()
	If _STA_DogRaceList.HasForm(SexPartnerRaceTemp)
		SexPartnerRace = 0
	ElseIf _STA_HorseRaceList.HasForm(SexPartnerRaceTemp)
		SexPartnerRace = 1
	EndIf
EndFunction

Function QueueComment(Topic WhatToSay, Bool PriorityComment, Bool ForcedGagComment = false) ; ForcedGagComment - Normally the Player will be silent when gagged, enable this to instead do 'gag talk'
	Debug.Trace("_STA_: DialogQueue: SENDING: " + WhatToSay + " >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	Formlist QueueSelect
	If PriorityComment
		QueueSelect = _STA_DialogQueuePriority
		_STA_DialogQueue.Revert() ; Clear the low priority pool - more to cooloff conflicting dialog than anything else
	Else
		QueueSelect = _STA_DialogQueue
	EndIf
	If StorageUtil.GetIntValue(None, "Sexlab.ManualMouthOpen", Missing = 0) == 0 && !sslBaseExpression.IsMouthOpen(PlayerRef)
		If IsMouthAvailable == 1
			QueueSelect.AddForm(WhatToSay)
			_STA_DialogOutputSpell.Cast(PlayerRef, PlayerRef)
		ElseIf ForcedGagComment || GagTalkChance > Utility.RandomFloat(0.0, 100.0)
			WhatToSay = _STA_PlayerGaggedDialogTopic
			QueueSelect.AddForm(WhatToSay)
			_STA_DialogOutputSpell.Cast(PlayerRef, PlayerRef)
		EndIf
	EndIf
EndFunction

Function GetIsMouthAvailable(Int tid)
	IsMouthAvailable = 1
	
	; Gagged ?
	GetIsGagged()
	
	; Mouth 'otherwise' occupied ?
	; DOES THIS NEED TO BE DONE EVERY STAGE OR IS ANIMATION START ENOUGH????????????????????????????????????
	sslBaseAnimation Anim = sexlab.HookAnimation(tid)
	Actor[] actorList = SexLab.HookActors(tid as string)
	Int i = 0
	Int PlayerPos
	Actor NextActor
	While i < actorList.Length
		NextActor = actorList[i]
		If NextActor == PlayerRef
			PlayerPos = i
		EndIf
		i += 1
	EndWhile
	Debug.Trace("_STA_: PlayerPos = " + i)
	
	
	If Anim.UseOpenMouth(PlayerPos, SexLab.GetController(tid).Stage)
		IsMouthAvailable = 0
	EndIf
	Debug.Trace("_STA_: Mouth available: " + IsMouthAvailable)

EndFunction

Function GetIsGagged()
	; Check DD gags
	If zad_DeviousGag != None
		If PlayerRef.WornHasKeyword(zad_DeviousGag)
			IsMouthAvailable = 0
		Else
			IsMouthAvailable = 1
		EndIf
	Else
		IsMouthAvailable = 1
	EndIf
	
	; Check Zaz Gags
	If IsMouthAvailable == 1
		If Game.GetModByName("ZaZAnimationPack.esm") != 255 ; Needs integration
			Keyword zbfWornGag = Game.GetFormFromFile(0x008A4D, "ZaZAnimationPack.esm") as Keyword
			If PlayerRef.WornHasKeyword(zbfWornGag)
				IsMouthAvailable = 0
			EndIf
		EndIf
	EndIf
EndFunction

Function BeginSpankModEnjoyment()
	If IsSlsoInstalled
		Int Enjoyment = BaseSpankEnjoyment * SpankUtil.GetMasochismAttitude(SpankUtil.PlayerMasochism)
		SlsoInterface.DoSpankModEnjoyment(CurrentTid, PlayerRef, Enjoyment)

		;Int BeforeEnjoyment = SexLab.GetController(CurrentTid).ActorAlias(PlayerRef).GetFullEnjoyment()
		;SexLab.GetController(CurrentTid).ActorAlias(PlayerRef).BonusEnjoyment(Ref = PlayerRef, experience = Enjoyment)
		;Int AfterEnjoyment = SexLab.GetController(CurrentTid).ActorAlias(PlayerRef).GetFullEnjoyment()
		;Debug.Messagebox("Enjoyment Mod: " + Enjoyment + ". BeforeEnjoyment: " + BeforeEnjoyment + ". AfterEnjoyment: " + AfterEnjoyment)
	EndIf
EndFunction

String Function GetRandomDroolTexture()
	Int RandInt = Utility.RandomInt(0, 2)
	If RandInt == 0
		Return "SL Survival\\spanky\\drool1.dds"
	ElseIf RandInt == 1
		Return "SL Survival\\spanky\\drool2.dds"
	Else
		Return "SL Survival\\spanky\\drool3.dds"
	EndIf
EndFunction

Function AddDroolCooldownSpell()
	;_STA_DroolCooldownSpell.SetNthEffectDuration(0, DroolCooldown)
	PlayerRef.RemoveSpell(_STA_DroolCooldownSpell)
	Utility.Wait(1.0)
	PlayerRef.AddSpell(_STA_DroolCooldownSpell, false)
EndFunction

Function AddDrool()
	If DroolTexture == ""
		DroolTexture = GetRandomDroolTexture()
		SpankUtil.UpdateAlpha(PlayerRef, DroolOpacity, DroolTexture, "Face")
	EndIf
EndFunction

Function RemoveDrool()
	If DroolTexture != ""
		SpankUtil.RemoveOverlay(PlayerRef, DroolTexture, "Face")
		DroolTexture = ""
	EndIf
EndFunction

Function ResetDrool()
	SpankUtil.RemoveOverlay(PlayerRef, "SL Survival\\spanky\\drool1.dds", "Face")
	SpankUtil.RemoveOverlay(PlayerRef, "SL Survival\\spanky\\drool2.dds", "Face")
	SpankUtil.RemoveOverlay(PlayerRef, "SL Survival\\spanky\\drool3.dds", "Face")
	DroolTexture == ""
EndFunction

Function DroolGameLoad()
	Bool HasDrool = false
	If DroolTexture != ""
		HasDrool = true
	EndIf
	String DroolTemp = DroolTexture
	ResetDrool()
	If HasDrool
		DroolTexture = DroolTemp
		SpankUtil.UpdateAlpha(PlayerRef, DroolOpacity, DroolTexture, "Face")
	EndIf
EndFunction

Function AddTearsCooldownSpell()
	;_STA_TearsCooldownSpell.SetNthEffectDuration(0, TearsCooldownInterval)
	PlayerRef.RemoveSpell(_STA_TearsCooldownSpell)
	Utility.Wait(1.0)
	PlayerRef.AddSpell(_STA_TearsCooldownSpell, false)
EndFunction

Function ModifyTears(Bool IncreaseSuffering)
	Int NewTears = CurrentTears

	If IncreaseSuffering ; Updgrade tears
		If NewTears < TearsProgression.Length - 1
			NewTears += 1
		EndIf
	
	Else ; Downgrade tears
		If NewTears > -1
			NewTears -= 1
		EndIf
	EndIf
	
	If CurrentTears != NewTears
		If CurrentTears != -1
			RemoveTears()
		EndIf
		If NewTears > -1
			SpankUtil.UpdateAlpha(PlayerRef, TearsOpacity, "SL Survival\\spanky\\" + TearsProgression[NewTears], "Face")
			AddTearsCooldownSpell()
		EndIf
		CurrentTears = NewTears
	EndIf
EndFunction

Function RemoveTears() ; Only called in ModifyTears() which checks AreZazTexturesPresent
	SpankUtil.RemoveOverlay(PlayerRef, "SL Survival\\spanky\\" + TearsProgression[CurrentTears], "Face")
	CurrentTears = -1
EndFunction

Function ResetTears() ; Remove all tear overlays and reset CurrentTears
	Int i = TearsProgression.Length
	While i > 0
		i -= 1
		SpankUtil.RemoveOverlay(PlayerRef, "SL Survival\\spanky\\" + TearsProgression[i], "Face")
	EndWhile
	CurrentTears = -1
EndFunction

Function TearsGameLoad()
	Bool HasTears = false
	If CurrentTears != -1
		HasTears = true
	EndIf
	Int CurrentTearsTemp = CurrentTears - 1
	ResetTears()
	If HasTears
		CurrentTears = CurrentTearsTemp
		ModifyTears(true)
	EndIf
EndFunction

Function RegForKeys()
	If IsSlsoInstalled && !IsMasturbation; && !IsCreature
		If SpeakKey > 0
			RegisterForKey(SpeakKey)
		EndIf
		BonusEnjoymentKey = JsonUtil.GetIntValue("/SLSO/Config.json", "hotkey_bonusenjoyment")
		If BonusEnjoymentKey > 0
			RegisterForKey(BonusEnjoymentKey)
		EndIf
	EndIf
EndFunction

Function ChangeSpeakKey(Int KeyCode)
	If  KeyCode > 0
		If PlayerRef.IsInFaction(SexLabAnimatingFaction)
			If IsSlsoInstalled && !IsMasturbation && !IsCreature
				UnRegisterForKey(SpeakKey)
				SpeakKey = KeyCode
				RegisterForKey(SpeakKey)
			EndIf
			
		Else
			SpeakKey = KeyCode
		EndIf
	Else
		Debug.Trace("_STA_: ChangeSpeakKey(): Keycode can not be zero")
	EndIf
EndFunction

Function BuffMinActorValues()
	Float StaminaRateAV = PlayerRef.GetActorValue("StaminaRate")
	Float StaminaRatemultAV = PlayerRef.GetActorValue("StaminaRateMult")
	
	Float MagickaRateAV = PlayerRef.GetActorValue("MagickaRate")
	Float MagickaRatemultAV = PlayerRef.GetActorValue("MagickaRateMult")
	
	If StaminaRateAV < MinStaminaRate
		_STA_SexMinStaminaRateSpell.SetNthEffectMagnitude(0, (MinStaminaRate - StaminaRateAV))
		PlayerRef.AddSpell(_STA_SexMinStaminaRateSpell, false)
	EndIf
	If StaminaRatemultAV < MinStaminaMult
		_STA_SexMinStaminaRateMultSpell.SetNthEffectMagnitude(0, (MinStaminaMult - StaminaRatemultAV))
		PlayerRef.AddSpell(_STA_SexMinStaminaRateMultSpell, false)
	EndIf
	
	If MagickaRateAV < MinMagickaRate
		_STA_SexMinMagickaRateSpell.SetNthEffectMagnitude(0, (MinMagickaRate - MagickaRateAV))
		PlayerRef.AddSpell(_STA_SexMinMagickaRateSpell, false)
	EndIf
	If MagickaRatemultAV < MinMagickaMult
		_STA_SexMinMagickaRateMultSpell.SetNthEffectMagnitude(0, (MinMagickaMult - MagickaRatemultAV))
		PlayerRef.AddSpell(_STA_SexMinMagickaRateMultSpell, false)
	EndIf
EndFunction

Function RemoveMinAvBuffs()
	PlayerRef.RemoveSpell(_STA_SexMinStaminaRateSpell)
	PlayerRef.RemoveSpell(_STA_SexMinStaminaRateMultSpell)
	PlayerRef.RemoveSpell(_STA_SexMinMagickaRateSpell)
	PlayerRef.RemoveSpell(_STA_SexMinMagickaRateMultSpell)
	If Menu.RapeDrainsAttributes && IsPlayerVictim
		PlayerRef.DamageActorValue("Stamina", PlayerRef.GetAv("Stamina"))
		PlayerRef.DamageActorValue("Magicka", PlayerRef.GetAv("Magicka"))
	EndIf
EndFunction

Function ApplyPainEffect()
	Float MasochistAttitude = SpankUtil.GetMasochismAttitude(SpankUtil.PlayerMasochism)
	Float Pain = (SpankUtil.IntensityAss + SpankUtil.IntensityTits)
	Float Magnitude
	
	Spell SpellSelect
	If MasochistAttitude < 0 ; Hates/Dislikes
		SpellSelect = _STA_PainDebuff
		Magnitude = (Pain / 2.0) * -(MasochistAttitude) * PainDebuffMax
		;Debug.Messagebox("Debuff Mag: " + Magnitude)
		
	Else ; Likes/Loves
		
		If Pain < 1.0
			SpellSelect = _STA_PainMasochistDebuff
			Magnitude = (1.0 - Pain) * MasochistAttitude * PainDebuffMax
		Else
			SpellSelect = _STA_PainMasochistBuff
			Magnitude = (Pain - 1.0) * MasochistAttitude * PainDebuffMax
		EndIf
	EndIf
	;dEBUG.messagebox(SpellSelect)
	
	;/
	If SpankUtil.GetIsPlayerMasochist()
		;Pain = (SpankUtil.IntensityAss + SpankUtil.IntensityTits)
		Magnitude = -((-1.0 + Pain) * MasochistAttitude * PainDebuffMax)
	Else
		Magnitude = -((Pain / 2.0) * MasochistAttitude * PainDebuffMax)
	EndIf
/;
	; Set effects and apply
	Int i = SpellSelect.GetNumEffects()
	While i > 0
		i -= 1
		SpellSelect.SetNthEffectMagnitude(i, Magnitude)
	EndWhile
	PlayerRef.RemoveSpell(_STA_PainDebuff)
	PlayerRef.RemoveSpell(_STA_PainMasochistDebuff)
	PlayerRef.RemoveSpell(_STA_PainMasochistBuff)
	Utility.Wait(0.15) ; Pain not appearing sometimes without a wait :S
	PlayerRef.AddSpell(SpellSelect, false)
EndFunction

Function UpdatePlayerState()

	; Change state during sex based on player enjoyment
	If IsSlsoInstalled
		sslThreadController Thread = SexLab.GetController(CurrentTid)
		;sslActorAlias[] actors = Thread.ActorAlias
		Debug.Trace("_STA_: Enjoyment: Player: " + Thread.ActorAlias(PlayerRef).GetFullEnjoyment() + ". Parnter: " + Thread.ActorAlias(SexPartner).GetFullEnjoyment())
		
		Actor[] actorList = SexLab.HookActors(CurrentTid)
		Actor NextActor
		Int Enjoyment
		Int i
		While i < actorList.Length
			NextActor = actorList[i]
			Enjoyment = Thread.ActorAlias(NextActor).GetFullEnjoyment()
			If NextActor == PlayerRef
				PlayerEnjoyment = Enjoyment
			
				; Update player state
				If Enjoyment < LowJoyThreshold && !IsPlayerBroken && !IsMasturbation && IsPlayerVictim ; Not enjoying
					If IsCreature
						GoToState("CreatureUnhappy")
					Else
						GoToState("NpcUnhappy")
					EndIf
					
				ElseIf Enjoyment < MidJoyThreshold ; Mid enjoyment
					If IsCreature
						GoToState("CreatureMiddle")
					Else
						GoToState("NpcMiddle")
					EndIf
					
				Else ; Player is enjoying
					If IsCreature
						GoToState("CreatureHappy")
					ElseIf IsMasturbation
						GoToState("NpcMiddle") ; Masturbation needs a happy topic
					Else
						GoToState("NpcHappy")
					EndIf
				EndIf
				
				If OldState != GetState() ; Needs to be removed - testing only
					If Menu.DebugMode
						Debug.Notification("Player state changed to " + GetState())
					EndIf
					OldState = GetState()
				EndIf
			EndIf
			If Enjoyment > NearOrgasmJoyThreshold
				If NextActor == PlayerRef
					If !_STA_NearOrgasmCommentDone.HasForm(PlayerRef)
						QueueComment(_STA_SexDialogPlayerOrgasmNearTopic, PriorityComment = true)
						_STA_NearOrgasmCommentDone.AddForm(PlayerRef)
					EndIf
				Else
					If !_STA_NearOrgasmCommentDone.HasForm(NextActor)
						;Debug.messagebox("Doing NPC near orgasm comment")
						DoActorNearOrgasmComment()
						_STA_NearOrgasmCommentDone.AddForm(NextActor)
					EndIf
				EndIf
			EndIf
			i += 1
		EndWhile
	EndIf
EndFunction

Function GatherAnimDetails(int tid, bool HasPlayer)
	If HasPlayer
		CurrentTid = tid
		SexPartner = None
		SexPartnerRace = -1
		
		; Has scene got a male npc or male creature? Threesomes+ complicate things a little
		Bool HasMale = false
		Int GenderTemp
		Actor[] actorList = SexLab.HookActors(tid as string)
		SexPartnerCount = actorList.Length - 1
		If actorList.Length == 1
			IsMasturbation = true
		Else
			IsMasturbation = false
		EndIf
		Int i = 0 
		While i < actorList.Length
			If ActorList[i] != PlayerRef
				SexPartner = ActorList[i]
				GenderTemp = Sexlab.GetGender(actorList[i])
				If GenderTemp == 0 || GenderTemp == 2
					HasMale = true
				EndIf
			EndIf
			i += 1
		EndWhile
		If HasMale
			SexPartnerGender = 0
		Else
			SexPartnerGender = 1
		EndIf		
		
		sslBaseAnimation Anim = sexlab.HookAnimation(tid)
		NumOfStages = Anim.StageCount
		IsOral = Anim.IsOral
		IsAnal = Anim.IsAnal
		IsVaginal = Anim.IsVaginal
		If IsAnal || IsVaginal
			IsAnalOrVaginal = true
		Else
			IsAnalOrVaginal = false
		EndIf
		IsPlayerVictim = Sexlab.IsVictim(tid, PlayerRef)
		If IsPlayerVictim
			SpankUtil.IncRapeCount(1)
		EndIf
		If Anim.IsCreature && !_STA_SpankHappyCreaturesList.HasForm(SexPartner.GetRace()) ; Creature scene
			IsCreature = true
			SexSpankChance = 0.0
			GetIsSpankableAnimation()
			SetSexPartnerRace()
			;Debug.Messagebox("IsVictim: " + IsPlayerVictim + ". Spank chance: " + SexSpankChance)
			If IsPlayerVictim
				GoToState("CreatureUnhappy")
			Else
				If IsSlsoInstalled
					GoToState("CreatureMiddle")
				Else
					GoToState("CreatureHappy")
				EndIf
			EndIf

		Else ; Npc scene
			IsCreature = false
			SetSexSpankChance()
			GetIsSpankableAnimation()
			;Debug.Messagebox("IsVictim: " + IsPlayerVictim + ". Spank chance: " + SexSpankChance)
			If IsPlayerVictim
				GoToState("NpcUnhappy")
			Else
				If IsSlsoInstalled
					GoToState("NpcMiddle")
				Else
					GoToState("NpcHappy")
				EndIf
			EndIf		
		EndIf
		
		RegisterForSingleUpdate(1.0)
	EndIf
EndFunction

Bool IsSpankableAnimation
Function GetIsSpankableAnimation()
	IsSpankableAnimation = false
	If (SpankUtil.SexSpankToggle && !IsMasturbation && !IsCreature && IsNpcTheSpankyType)
		IsSpankableAnimation = true
	EndIf
EndFunction

Function DoNpcDialogOut(Topic WhatToSay, Actor akSpeaker)
	Debug.Trace("_STA_: DoNpcDialogOut: WhatToSay: " + WhatToSay + ". akSpeaker: " + akSpeaker)
	If WhatToSay
		DummyNpcWhatToSay = WhatToSay
		If !NpcDialogOutInProgress
			NpcDialogOutInProgress = true
			;Debug.messagebox("Doing dialog out")
			;DummyNpcWhatToSay = WhatToSay
			akSpeaker.AddToFaction(_STA_RapeDialogFaction)
			_STA_DialogOutputNpcSpell.Cast(akSpeaker, akSpeaker)
			akSpeaker.RemoveFromFaction(_STA_RapeDialogFaction)
		EndIf
	EndIf
EndFunction

Function DoFreecamNotify(String NotifString)
	;If Game.GetCameraState() == 3 && !IsCreature
	;	Debug.Notification(SexPartner.GetBaseObject().GetName() + ": " + NotifString)
	;EndIf
EndFunction

; SHARED EVENTS ==============================================================
Event OnUpdate()
	ConflictingDialogCooloff -= 1
	If Sexlab.IsActorActive(PlayerRef)
		UpdatePlayerState()
		If IsSlsoInstalled ; SEXLAB SEPARATE ORGASMS *********************************************
			If IsPlayerVictim ; Rape
				If IsSpankableAnimation ; Spank or comment
					If SpankCooldown <= 0 && NpcSexDialogCooldown <= 0
						DoNpcDialogOut(_STA_SpankingNpcDialogForceSlutTopic, SexPartner)
						;Debug.Messagebox("forced slut comment")
						NpcSexDialogCooldown = Utility.RandomInt(5,7)
					EndIf
					If (SexSpankChance + SexSpankChanceMod) > Utility.RandomFloat(0.0, 100.0) && SpankCooldown <= 0 ; Chance for spank
						SpankUtil.DoSexSpank(SexPartner)
					Else
						If SexIdleCommentChance > Utility.RandomFloat(0.0, 100.0)
							If IsMouthAvailable != 0
								DoSexComment()
							EndIf
						EndIf
					EndIf
					
					; Decrement countdowns
					If NpcSexDialogCooldown > 0
						NpcSexDialogCooldown -= 1
					EndIf
					If SpankCooldown > 0
						SpankCooldown -= 1
					
					; consequences
					Else
						If !IsPlayerMasochist
							SexSpankChanceMod += 10.0
						Else
							If (PlayerRef.GetActorValuePercentage("Stamina") < 0.10 || PlayerEnjoyment < LowJoyThreshold) && SpankCooldown == 0
								SpankUtil.DoSexSpank(SexPartner)
								SpankCooldown += 3 ; Rape, Is masochist
							EndIf
						EndIf
					EndIf
					
				
				Else ; No Spanking - Comment only
					If NpcSexDialogCooldown > 0
						NpcSexDialogCooldown -= 1
					EndIf
					If SexIdleCommentChance > Utility.RandomFloat(0.0, 100.0)
						If IsMouthAvailable != 0
							DoSexComment()
						EndIf
					EndIf
				EndIf
			
			Else ; Consensual
			
				If SexIdleCommentChance > Utility.RandomFloat(0.0, 100.0)
					If IsMouthAvailable != 0
						DoSexComment()
					EndIf
				EndIf
			
			EndIf
			
		
		Else ; VANILLA - NON SEXLAB SEPARATE ORGASMS ***********************************************************
			If IsPlayerVictim ; Rape
				If IsSpankableAnimation ; Spank or comment
					If VanillaRapeSpankChance > Utility.RandomFloat(0.0, 100.0) && SpankCooldown == 0 ; Spank ?
						SpankUtil.DoSexSpank(SexPartner)
						SpankCooldown = Utility.RandomInt(3, 5)
					Else ; Comment
						If SexIdleCommentChance > Utility.RandomFloat(0.0, 100.0)
							If IsMouthAvailable != 0
								DoSexComment()
							EndIf
						EndIf
					EndIf
					If SpankCooldown > 0
						SpankCooldown -= 1
					EndIf
				
				Else ; Comment only
					If SexIdleCommentChance > Utility.RandomFloat(0.0, 100.0)
						If IsMouthAvailable != 0
							DoSexComment()
						EndIf
					EndIf
				EndIf
			
			Else ; Consensual
				If SexIdleCommentChance > Utility.RandomFloat(0.0, 100.0)
					If IsMouthAvailable != 0
						DoSexComment()
					EndIf
				EndIf
			EndIf
		EndIf
		RegisterForSingleUpdate(1.0)
	EndIf
EndEvent

Event OnKeyDown(Int KeyCode)
	If !Utility.IsInMenuMode()
		If IsPlayerMasochist
			If KeyCode == SpeakKey ; Mid Mouse
				If SpankCooldown == 0
					UnRegisterForKey(SpeakKey)
					ConflictingDialogCooloff = 5
					QueueComment(_STA_SpankingPlayerSpankRequestTopic, PriorityComment = true, ForcedGagComment = true)
					RegisterForKey(SpeakKey)
				EndIf
			ElseIf KeyCode == BonusEnjoymentKey
				UnRegisterForKey(BonusEnjoymentKey)
				If PlayerRef.GetActorValuePercentage("Stamina") > 0.10
					DoSexSound()
				EndIf
				If NpcSexDialogCooldown <= 0
					DoNpcDialogOut(_STA_SpankingPlayerFucksBack, SexPartner)
					NpcSexDialogCooldown = Utility.RandomInt(5, 7)
				EndIf
				;Utility.Wait(1.0)
				RegisterForKey(BonusEnjoymentKey)
			EndIf
		
		Else
			If KeyCode == SpeakKey ; Mid Mouse
				ConflictingDialogCooloff = 5
				QueueComment(_STA_SpankingPlayerDenigrateTopic, PriorityComment = true, ForcedGagComment = true)
			ElseIf KeyCode == BonusEnjoymentKey
				UnRegisterForKey(BonusEnjoymentKey)
				If NpcSexDialogCooldown <= 0
					DoNpcDialogOut(_STA_SpankingPlayerFucksBack, SexPartner)
					NpcSexDialogCooldown = Utility.RandomInt(5, 7)
				EndIf
				If PlayerRef.GetActorValuePercentage("Stamina") > 0.10
					DoSexSound()
					SpankCooldown += FuckBackTick ; Rape, Not masochist
					Debug.Trace("_STA_: SpankCooldown: Fuck back: " + FuckBackTick)
					SexSpankChanceMod = 0.0
					Utility.Wait(0.1)
				EndIf
				RegisterForKey(BonusEnjoymentKey)
			EndIf
		EndIf
	EndIf
EndEvent

Function DoSexSound()
	Int SexSound
	If sslBaseExpression.IsMouthOpen(PlayerRef) && StorageUtil.GetIntValue(None, "Sexlab.ManualMouthOpen", Missing = 0) != 2
		SexSound = _STA_Sucking.Play(PlayerRef)
	Else
		If AssClapChance > Utility.RandomFloat(0.0, 100.0)
			SexSound = _STA_Fucking.Play(PlayerRef)
		Else
			SexSound = _STA_FuckingSlimy.Play(PlayerRef)
		EndIf
	EndIf
	Sound.SetInstanceVolume(SexSound, SexSoundVol) 
EndFunction

Event OnAnimationStart(int tid, bool HasPlayer)
	If HasPlayer
		IsPlayerMasochist = SpankUtil.GetIsPlayerMasochist()
		BuffMinActorValues()
		SpankCooldown = 3
		ConflictingDialogCooloff = 0
		CanDoRegularComment = true
		IsPlayerBroken = false
		_STA_DialogQueue.Revert() ; Just in case
		_STA_NearOrgasmCommentDone.Revert()
		GatherAnimDetails(tid, HasPlayer)
		If IsPlayerVictim; && !IsPlayerMasochist
			ModifyTears(true)
		EndIf
		PlayerRef.RemoveSpell(_STA_TearsCooldownSpell)
		PlayerRef.RemoveSpell(_STA_DroolCooldownSpell)
		If !IsMasturbation
			DoAnimationStartComment()
			If IsNpcTheSpankyType && IsSlsoInstalled
				Utility.Wait(2.0)
				DoNpcDialogOut(_STA_SpankingNpcDialogForceSlutTopic, SexPartner)
			EndIf
		EndIf
		RegForKeys()
	EndIf
EndEvent

Event OnStageStart(int tid, bool HasPlayer)
	If HasPlayer
		If Menu.DebugMode
			Debug.Notification("SpankCooldown: " + SpankCooldown)
		EndIf
		GetIsMouthAvailable(tid)
		If !IsMouthAvailable
			AddDrool()
		EndIf
		If SexLab.GetController(tid).Stage == NumOfStages ; End stage
			CanDoRegularComment = false
		ElseIf SexLab.GetController(tid).Stage == NumOfStages - 1 ; He's about to cum (Non SLSO)
			If !IsSlsoInstalled
				DoActorNearOrgasmComment()
			EndIf
		;Else
		
		EndIf
	EndIf
EndEvent

Event OnOrgasmStart(int tid, bool HasPlayer)
	If HasPlayer
		Utility.Wait(3.0)
		DoActorOrgasmComment()
	EndIf
EndEvent

Event OnSexLabOrgasmSeparate(Form ActorRef, Int tid)
	If tid == CurrentTid
		;_STA_NearOrgasmCommentDone.RemoveAddedForm(ActorRef) ; Near orgasm comments occurring twice - timing issue
		If ActorRef == PlayerRef && IsPlayerVictim
			IsPlayerBroken = true
			SpankUtil.IncRapeCount(4)
		ElseIf ActorRef != PlayerRef
			DoActorOrgasmComment()
		EndIf
	EndIf
EndEvent

Event OnAnimationEnd(int tid, bool HasPlayer)
	If HasPlayer
		UnregisterForAllKeys()
		GetIsGagged()
		;Debug.Messagebox("Animation end")
		UnRegisterForUpdate()
		Utility.Wait(2.0)
		UnregisterForAllKeys() ; UnRegisterForKeys again just in case...
		DoAnimationEndComment()
		GoToState("")
		AddDroolCooldownSpell()
		AddTearsCooldownSpell()
		RemoveMinAvBuffs()
	EndIf
EndEvent

Event OnAnimationChange(int tid, bool HasPlayer)
	If HasPlayer
		GatherAnimDetails(tid, HasPlayer)
		GetIsMouthAvailable(tid)
	EndIf
EndEvent

; MISC EVENTS

Event OnDeviceVibrateEffectStart(string eventName, string strArg, float numArg, Form sender)	
	If strArg == PlayerRef.GetLeveledActorBase().GetName()
		Bool HasCommented = false
		While DeviousInterface.GetIsVibrating(PlayerRef) && !HasCommented
			If DeviousInterface.GetIsAnimating(PlayerRef)
				HasCommented = true
				Utility.Wait(1.5)
				QueueComment(_STA_DeviousDevicesViberateTopic, PriorityComment = false)
			EndIf
			Utility.Wait(1.0)
		EndWhile
	EndIf
EndEvent

Event OnDDI_DeviceEquipped(Form inventoryDevice, Form deviceKeyword, Form akActor)
	If akActor as Actor == PlayerRef
		Keyword Zad_DeviousHood  = Game.GetFormFromFile(0x02AFA2, "Devious Devices - Assets.esm") as Keyword ; Needs Integration ?
		If deviceKeyword == zad_DeviousGag || deviceKeyword == Zad_DeviousHood
			IsMouthAvailable = 0
			PlayerRef.RemoveSpell(_STA_DroolCooldownSpell)
			AddDrool()
			Debug.Trace("_STA_: Dialog blocked by gag")
		EndIf
		; Do device added comment ????????????????????????????
	EndIf
EndEvent

Event OnDDI_DeviceRemoved(Form inventoryDevice, Form deviceKeyword, Form akActor)
	If akActor as Actor == PlayerRef
		Keyword Zad_DeviousHood  = Game.GetFormFromFile(0x02AFA2, "Devious Devices - Assets.esm") as Keyword ; Needs Integration ?
		If deviceKeyword == zad_DeviousGag || deviceKeyword == Zad_DeviousHood
			If !SexLab.IsActorActive(PlayerRef)
				IsMouthAvailable = 1
				AddDroolCooldownSpell()
				Debug.Trace("_STA_: Dialog UNblocked by gag")
			EndIf
		EndIf
		; Do device removed comment ????????????????????????????
	EndIf
EndEvent

Function CheckIsGagRemoved(Form akBaseObject)
	If akBaseObject.HasKeyword(zad_DeviousGag)
		If !SexLab.IsActorActive(PlayerRef)
			IsMouthAvailable = 1
			AddDroolCooldownSpell()
			Debug.Trace("_STA_: Dialog UNblocked by gag")
		EndIf
	EndIf
EndFunction

Event OnMME_MilkCycleComplete(string eventName, string strArg, float numArg, Form sender)
	Float CurrentMilk = StorageUtil.GetFloatValue(PlayerRef, "MME.MilkMaid.MilkCount", -1.0)
	Float MaxMilk = StorageUtil.GetFloatValue(PlayerRef, "MME.MilkMaid.MilkMaximum", -100.0)
	If ((CurrentMilk / MaxMilk)) > 0.8
		IsPlayerBreastsFull = true
	Else
		IsPlayerBreastsFull = false
	EndIf
	If MmeInterface.IsLeakingMilk()
		IsPlayerLeakingMilk = true
	Else
		IsPlayerLeakingMilk = false
	EndIf
	If IsPlayerBreastsFull || IsPlayerLeakingMilk
		QueueComment(_STA_MmeDialogTitsFullTopic, PriorityComment = false)
	EndIf
EndEvent

Function BeginBoobLeak()
	If MmeSlapLeakChance > Utility.RandomFloat(0.0, 100.0)
		MmeInterface.BoobLeak()
	EndIf
EndFunction

Event OnBis_BatheEvent(Form akTarget)
	Actor CleanActor = akTarget as Actor
	If CleanActor == PlayerRef
		QueueComment(_STA_BisDialogCleanTopic, PriorityComment = false)
	EndIf
EndEvent

; EMPTY STATE ===============================================================
Function DoAnimationStartComment()
EndFunction
	
Function DoSexComment()
EndFunction

Function DoActorNearOrgasmComment()
EndFunction

Function DoActorOrgasmComment()
EndFunction

Function DoAnimationEndComment()
EndFunction

Function DoPlayerNearOrgasmComment()
EndFunction

; CREATURE STATES ===========================================================
State CreatureHappy
	Function DoAnimationStartComment()
		QueueComment(_STA_SexDialogueCreatureSexStartTopic, PriorityComment = true)
	EndFunction
	
	Function DoSexComment()
		If CanDoRegularComment && _STA_DialogQueue.GetSize() == 0 ; Comment only if there isn't another comment queued as these comments are less important
			QueueComment(_STA_SexDialogCreatureSexHappyTopic, PriorityComment = false)
		EndIf
	EndFunction
	
	Function DoActorNearOrgasmComment()
		QueueComment(_STA_SexDialogCreatureOrgasmNearHappyTopic, PriorityComment = true)
	EndFunction
	
	Function DoPlayerNearOrgasmComment()
		QueueComment(_STA_SexDialogPlayerOrgasmNearTopic, PriorityComment = true)
	EndFunction
	
	Function DoActorOrgasmComment()
		QueueComment(_STA_SexDialogCreatureSexCumTopic, PriorityComment = true)
	EndFunction
	
	Function DoAnimationEndComment()
		QueueComment(_STA_SexDialogCreatureSexFinishTopic, PriorityComment = true)
	EndFunction
EndState

State CreatureMiddle
	Function DoAnimationStartComment()
		QueueComment(_STA_SexDialogueCreatureSexStartTopic, PriorityComment = true)
	EndFunction
	
	Function DoSexComment()
		If CanDoRegularComment && _STA_DialogQueue.GetSize() == 0 ; Comment only if there isn't another comment queued as these comments are less important
			QueueComment(_STA_SexDialogCreatureSexMiddleTopic, PriorityComment = false)
		EndIf
	EndFunction
	
	Function DoActorNearOrgasmComment()
		If IsPlayerBroken
			QueueComment(_STA_SexDialogCreatureOrgasmNearHappyTopic, PriorityComment = true)
		Else
			QueueComment(_STA_SexDialogCreatureOrgasmNearUnhappyTopic, PriorityComment = true, ForcedGagComment = true)
		EndIf
		
	EndFunction
	
	Function DoPlayerNearOrgasmComment()
		QueueComment(_STA_SexDialogPlayerOrgasmNearTopic, PriorityComment = true)
	EndFunction
	
	Function DoActorOrgasmComment()
		QueueComment(_STA_SexDialogCreatureRapeCumTopic, PriorityComment = true)
	EndFunction
	
	Function DoAnimationEndComment()
		If IsPlayerBroken || !IsPlayerVictim
			QueueComment(_STA_SexDialogCreatureSexFinishTopic, PriorityComment = true)
		Else
			QueueComment(_STA_SexDialogCreatureRapeFinishTopic, PriorityComment = true)
		EndIf
	EndFunction
EndState

State CreatureUnhappy
	Function DoAnimationStartComment()
		QueueComment(_STA_SexDialogCreatureRapeStartTopic, PriorityComment = true)
	EndFunction
	
	Function DoSexComment()
		If CanDoRegularComment && _STA_DialogQueue.GetSize() == 0 ; Comment only if there isn't another comment queued as these comments are less important
			QueueComment(_STA_SexDialogCreatureSexUnhappyTopic, PriorityComment = false)
		EndIf
	EndFunction
	
	Function DoActorNearOrgasmComment()
		QueueComment(_STA_SexDialogCreatureOrgasmNearUnhappyTopic, PriorityComment = true, ForcedGagComment = true)
	EndFunction
	
	Function DoPlayerNearOrgasmComment()
		QueueComment(_STA_SexDialogPlayerOrgasmNearTopic, PriorityComment = true)
	EndFunction
	
	Function DoActorOrgasmComment()
		QueueComment(_STA_SexDialogCreatureRapeCumTopic, PriorityComment = true, ForcedGagComment = true)
	EndFunction
	
	Function DoAnimationEndComment()
		QueueComment(_STA_SexDialogCreatureRapeFinishTopic, PriorityComment = true)
	EndFunction
EndState

; NPC STATES =====================================================
State NpcHappy
	Function DoAnimationStartComment()
		QueueComment(_STA_SexDialogNpcSexStartTopic, PriorityComment = true)
	EndFunction
	
	Function DoSexComment()
		If CanDoRegularComment && _STA_DialogQueue.GetSize() == 0 ; Comment only if there isn't another comment queued as these comments are less important
			QueueComment(_STA_SexDialogNpcSexHappyTopic, PriorityComment = false)
		EndIf
	EndFunction
	
	Function DoActorNearOrgasmComment()
		QueueComment(_STA_SexDialogNpcOrgasmNearHappyTopic, PriorityComment = true)
	EndFunction
	
	Function DoPlayerNearOrgasmComment()
		QueueComment(_STA_SexDialogPlayerOrgasmNearTopic, PriorityComment = true)
	EndFunction
	
	Function DoActorOrgasmComment()
		QueueComment(_STA_SexDialogCreatureRapeCumTopic, PriorityComment = true)
	EndFunction
	
	Function DoAnimationEndComment()
		QueueComment(_STA_SexDialogNpcSexFinishTopic, PriorityComment = true)
	EndFunction
EndState

State NpcMiddle
	Function DoAnimationStartComment()
		If IsMasturbation
			; Masturbation needs animation start topic
		Else
			QueueComment(_STA_SexDialogNpcSexStartTopic, PriorityComment = true)
		EndIf
	EndFunction
	
	Function DoSexComment()
		If CanDoRegularComment && _STA_DialogQueue.GetSize() == 0 ; Comment only if there isn't another comment queued as these comments are less important
			QueueComment(_STA_SexDialogCreatureSexMiddleTopic, PriorityComment = false)
		EndIf
	EndFunction
	
	Function DoActorNearOrgasmComment()
		If IsPlayerBroken
			QueueComment(_STA_SexDialogNpcOrgasmNearHappyTopic, PriorityComment = true)
		Else
			QueueComment(_STA_SexDialogNpcOrgasmNearUnhappyTopic, PriorityComment = true, ForcedGagComment = true)
		EndIf
	EndFunction
	
	Function DoPlayerNearOrgasmComment()
		QueueComment(_STA_SexDialogPlayerOrgasmNearTopic, PriorityComment = true)
	EndFunction
	
	Function DoActorOrgasmComment()
		If IsPlayerBroken
			QueueComment(_STA_SexDialogCreatureSexCumTopic, PriorityComment = true) ; Needs more specific topic !!!!!!!!!!!!!!!!!!!!!
		Else
			QueueComment(_STA_SexDialogNpcRapeCumTopic, PriorityComment = true)
		EndIf
	EndFunction
	
	Function DoAnimationEndComment()
		If IsMasturbation
			; Needs topic - Masturbation finish
		ElseIf IsPlayerBroken
			QueueComment(_STA_SexDialogNpcSexFinishTopic, PriorityComment = true)
		Else
			QueueComment(_STA_SexDialogCreatureRapeFinishTopic, PriorityComment = true)
		EndIf
	EndFunction
EndState

State NpcUnhappy
	Function DoAnimationStartComment()
		QueueComment(_STA_SexDialogNpcRapeStartTopic, PriorityComment = true)
	EndFunction
	
	Function DoSexComment()
		If ConflictingDialogCooloff <= 0 && CanDoRegularComment && _STA_DialogQueue.GetSize() == 0 ; Comment only if there isn't another comment queued as these comments are less important
			QueueComment(_STA_SexDialogNpcSexUnhappyTopic, PriorityComment = false)
		EndIf
	EndFunction
	
	Function DoActorNearOrgasmComment()
		QueueComment(_STA_SexDialogNpcOrgasmNearUnhappyTopic, PriorityComment = true, ForcedGagComment = true)
	EndFunction
	
	Function DoPlayerNearOrgasmComment()
		QueueComment(_STA_SexDialogPlayerOrgasmNearTopic, PriorityComment = true)
	EndFunction
	
	Function DoActorOrgasmComment()
		QueueComment(_STA_SexDialogNpcRapeCumTopic, PriorityComment = true, ForcedGagComment = true)
	EndFunction
	
	Function DoAnimationEndComment()
		QueueComment(_STA_SexDialogCreatureRapeFinishTopic, PriorityComment = true)
	EndFunction
EndState
