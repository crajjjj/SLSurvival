Scriptname SLSF_Configuration extends Quest  

Int Function LastVersion()	;To trigger an update change the return value
	Return 3
EndFunction

Int Function LastNpcInitVersion()	;To trigger an update change the return value
	Return 2
EndFunction

Int Property CurrentVersion = 3 Auto Hidden

Function ResetTutorial()
	TutorialShowed = New Bool[100]
EndFunction

Event OnInit()
	ResetTutorial()
	ResetExcludedList()
	ResetExcludedTats()
	
	FameLocationsList = New Location[34]
	LocationExcludedFromTracking = New Location[2]
	
	LoadFameLocationsList()
	
	FameListNpc = New String[7]
	FameListNpc[0] = "NPC.Libertine"
	FameListNpc[1] = "NPC.Prostitution"
	FameListNpc[2] = "NPC.Raper"
	FameListNpc[3] = "NPC.Slavery"
	FameListNpc[4] = "NPC.Zoophilie"
	FameListNpc[5] = "NPC.Misogyny"	
	FameListNpc[6] = "NPC.Misandry"	
	
	FameListPc = New String[20]
	FameListPc[0] = "PC.Anal"
	FameListPc[1] = "PC.Argonian"
	FameListPc[2] = "PC.Beastiality"
	FameListPc[3] = "PC.Dominant/Master"
	FameListPc[4] = "PC.Exhibitionist/Exposed"
	FameListPc[5] = "PC.GentleLover"
	FameListPc[6] = "PC.Group"
	FameListPc[7] = "PC.Khajiit"
	FameListPc[8] = "PC.LikeMan"
	FameListPc[9] = "PC.LikeWoman"
	FameListPc[10] = "PC.Masochist"
	FameListPc[11] = "PC.Nasty"
	FameListPc[12] = "PC.Oral"
	FameListPc[13] = "PC.Orc"
	FameListPc[14] = "PC.Pregnant"
	FameListPc[15] = "PC.Sadic"
	FameListPc[16] = "PC.SkoomaUser"
	FameListPc[17] = "PC.Slut"
	FameListPc[18] = "PC.Submissive/Slave"
	FameListPc[19] = "PC.Whore"
	
	TemporaryLocation = New Bool[34]
	TemporaryLocation[24] = True
	TemporaryLocation[25] = True
	TemporaryLocation[26] = True
	TemporaryLocation[27] = True
	TemporaryLocation[28] = True
	TemporaryLocation[29] = True
	TemporaryLocation[30] = True
	TemporaryLocation[31] = True
	TemporaryLocation[32] = True
	TemporaryLocation[33] = True
	
	LastDecadencePC = New Float[34]		;Last Fame PC Decadence Check (Note: Decadence and Decay Do DIFFERENT things, Decadence is about reduction of fame level over time)
	LastVariationNPC = New Float[34]	;Last Fame Npc Variation
	LastFameSet = New Float[34]			;Last Fame Inc/Dec, used for Mod based on time (NpcFame) and Clearing(Temporary only)
	
	LocationFameMorbosity = New Float[34]
	Int a = LocationFameMorbosity.Length
	While a > 0
		a -= 1
		LocationFameMorbosity[a] = Utility.RandomFloat(0.4, 0.7)
	EndWhile
	
	LocationFameRequiredMorbosity = New Float[34]
	a = LocationFameRequiredMorbosity.Length
	While a > 0
		a -= 1
		LocationFameRequiredMorbosity[a] = Utility.RandomFloat(0.1, 0.4)
	EndWhile
	
	FameLocationsListString = New String[34]
	String Name
	a = FameLocationsList.Length
	While a > 0
		a -= 1
		If FameLocationsList[a] != None
			Name = FameLocationsList[a].GetName()+" [Loc#"+a+"]"
		Else
			Name = " Empty [Loc#"+a+"]"
		EndIf
		FameLocationsListString[a] = Name
	EndWhile
	
	Int FameNum = FameListPc.Length
	PeriodicIncValue = Utility.CreateIntArray(FameNum)
	PeriodicIncSender = Utility.CreateStringArray(FameNum)
	LoadBaseSTSpecificSlot()
	
	;LocationPCRoleTypes = New Int[34]		;Suppressed with the 0.97
	;a = 34
	;While a > 0
	;	a -= 1
	;	LocationPCRoleTypes[a] = 21
	;EndWhile
	LoadRoleTypeString()
	LoadTraitNames()
EndEvent

GlobalVariable Property AllowComment Auto		;0 No, 1 Yes
GlobalVariable Property SceneInUse Auto			;0 No, 1 Yes
GlobalVariable Property AllowAnonymous Auto		;0 No, 1 Yes

Form[] Property ExcludedFeet Auto Hidden
Form[] Property ExcludedHand Auto Hidden
Form[] Property ExcludedHead Auto Hidden
Form[] Property ExcludedBody Auto Hidden

Keyword[] Property ClothingKeyword Auto	;ArmBoot, ArmFeet, ArmGaunt, ClothHan, ArmHelm, ClothHead, ArmCuir, ClothBod

Keyword[] Property ZazFoot Auto		;Empty
Keyword[] Property ZazHand Auto		;Empty
Keyword[] Property ZazHead Auto		;zbfBlind, zbfGag
Keyword[] Property ZazBody Auto		;zbfWrist, zbfAnkles, zbfBelt, zbfBra, zbfCollar
Keyword[] Property ZazOther Auto	;zbfEffectKeepOffset, zbfHood

KeyWord[] Property DDFootDevice Auto Hidden
KeyWord[] Property DDHandDevice Auto Hidden
KeyWord[] Property DDHeadDevice Auto Hidden
KeyWord[] Property DDBodyDevice Auto Hidden
KeyWord[] Property DDOtherDevice Auto Hidden
KeyWord Property DDSuit Auto Hidden
KeyWord Property DDLockable Auto Hidden
KeyWord Property DDGenericBlock Auto Hidden

Faction Property HydMiscFaction Auto Hidden
Faction Property DDAnimationFaction Auto Hidden
Faction Property DDVibratingFaction Auto Hidden
Faction Property EsChaurusBreederFaction Auto Hidden

MagicEffect[] Property BathingInSkyrimEffects Auto Hidden	;Note: Bad Named -> Those are the ANIMATION MagicEffect
MagicEffect[] Property BathingInSkyrimDirt Auto Hidden

Spell[] Property SKWPhysicalDecadenceSpell Auto Hidden
Spell Property EsChaurusBreederAbility Auto Hidden

FormList Property CurrentFameLocationNpc Auto
FormList Property CurrentFameLocationPc Auto
FormList Property TraitFaction Auto
Location[] Property FameLocationsList Auto Hidden
Location[] Property LocationExcludedFromTracking Auto Hidden
Location Property LocationOfValuesLoaded Auto Hidden

KeyWord Property LocTypeHold Auto
KeyWord Property LocTypeHouse Auto

Potion[] Property Skooma Auto

;String
;Internal
String[] Property ExcludedSlaveTats Auto Hidden
String[] Property FameListNpc Auto Hidden
String[] Property FameListPc Auto Hidden
String[] Property FameLocationsListString Auto Hidden
String[] Property RoleTypeListstring Auto Hidden
String[] Property STSpecificTatName Auto Hidden
String[] Property PeriodicIncSender Auto Hidden
String[] Property TraitName Auto Hidden

;Bool
;Internal
Bool Property SystemInPause Auto Hidden
Bool[] Property TemporaryLocation Auto Hidden	;FOR CHRIST SAKE DO NOT CHANGE THIS EVER!
Bool[] Property TutorialShowed Auto Hidden
Bool Property KeyCallInPause Auto Hidden
Bool Property PlayerEquipReady Auto Hidden
Bool Property ShameAnimSuspended Auto Hidden
Bool Property SlaExtensionList Auto Hidden	;not used so far
Bool Property EsChaurusPlayerPregnant Auto Hidden

Bool Function LogAllowed()
	Return True
EndFunction

;MCM
Bool Property SlaveTatsLoaded Auto Hidden
Bool Property HydraSlavegirlsLoaded Auto Hidden
Bool Property DeviousDevicesIntegrationLoaded Auto Hidden
Bool Property BathingInSkyrimLoaded Auto Hidden
Bool Property EstrusChaurusLoaded Auto Hidden
Bool Property SoulGemOvenLoaded Auto Hidden
Bool Property ChildRemover = True Auto Hidden
Bool Property BaseEquipNPC = True Auto Hidden
Bool Property ShameEffectEnabled = False Auto Hidden
Bool Property DisableTutorial Auto Hidden
Bool Property DefineSexuality = False Auto Hidden
Bool Property NeedLosForFameGainRequest = True Auto Hidden	;Not only for request but with all
Bool Property DefineExhib = True Auto Hidden
Bool Property RandomizeTemporaryFameAtStart = True Auto Hidden
Bool Property AllowIncreaseSpecificWithTats = False Auto Hidden
Bool Property NotificationIncrease = True Auto Hidden
Bool Property CumAlwaysHiddable = False Auto Hidden
Bool Property SkoomaWhoreLoaded Auto Hidden
Bool Property NotifyChangeRoleTypeWtLoc Auto Hidden

;Float
;Internal
Float[] Property LastDecadencePC Auto Hidden
Float[] Property LastVariationNPC Auto Hidden
Float[] Property LastFameSet Auto Hidden
Float[] Property LocationFameMorbosity Auto Hidden
Float[] Property LocationFameRequiredMorbosity Auto Hidden
Float Property LastContageCheck Auto Hidden

;MCM
Float Property BaseUpdateInterval = 2.0 Auto Hidden		;Min 2 Max 5
Float Property AllowCommentProbability = 0.7 Auto Hidden
Float Property CommentProbabilityRepository = 0.7 Auto Hidden
Float Property ProbBaseEquipMiscNPC = 0.5 Auto Hidden
Float Property ProbBaseEquipFeetNPC = 0.5 Auto Hidden
Float Property ProbBaseEquipBodyNPC = 0.7 Auto Hidden
Float Property ProbExhibitionist = 0.3 Auto Hidden

Float Property ContageMagnitudo = 0.3 Auto Hidden	;Min 0.1, Max 0.4
Float Property ModIfINSameLocation = 0.0 Auto Hidden	;Min -1.0 Max 1.0
Float Property ModIfNOTSameLocation = -0.2 Auto Hidden
Float Property FameDayDelayBeforeDecrease = 1.0 Auto Hidden
Float Property DistanceWithoutLosNeeded = 350.0 Auto Hidden
Float Property LocationFameModInc = 1.0 Auto Hidden
Float Property LocationFameModDec = 1.0 Auto Hidden
Float Property DaysDelayBeforeNewContage = 0.5 Auto Hidden
Float Property BaseProbabilityContage = 0.1 Auto Hidden
Float Property VariationFameNpcRange = 0.2 Auto Hidden

Float Property FameIncreaseByLover = 0.1 Auto Hidden
Float Property FameIncreaseByFriend = 0.4 Auto Hidden
Float Property FameIncreaseByNeutral = 0.7 Auto Hidden
Float Property FameIncreaseByEnemy = 1.0 Auto Hidden
Float Property ModMorbosityAtContage = 0.1 Auto Hidden

;Int
;Internal
;Int[] Property FameGainBufferSL Auto Hidden
Int[] Property STSpecificFameType Auto Hidden
Int[] Property STSpecificBodyLoc Auto Hidden
Int[] Property STSpecificLimitMax Auto Hidden
Int[] Property PeriodicIncValue Auto Hidden
;Int[] Property LocationPCRoleTypes Auto Hidden		;Suppressed with the 0.97
Int Property MaxExcludedItem = 10 Auto Hidden
Int Property NextLocationNumDecadenceToCheck Auto Hidden
Int property LocationOfValueLoadedNum = -1 Auto Hidden

;MCM
Int Property ProbSlave = 1 Auto Hidden		;Weight probability
Int Property ProbSlaveKind = 1 Auto Hidden
Int Property ProbSlaveNorm = 1 Auto Hidden
Int Property ProbSlaveBast = 1 Auto Hidden

Int Property ProbFree = 1 Auto Hidden
Int Property ProbFreeKind = 1 Auto Hidden
Int Property ProbFreeNorm = 1 Auto Hidden
Int Property ProbFreeBast = 1 Auto Hidden

Int Property ProbMaster = 1 Auto Hidden
Int Property ProbMasterKind = 1 Auto Hidden
Int Property ProbMasterNorm = 1 Auto Hidden
Int Property ProbMasterBast = 1 Auto Hidden

Int Property EquipWeightKindPoor = 1 Auto Hidden
Int Property EquipWeightKindMed = 1 Auto Hidden
Int Property EquipWeightKindRich = 1 Auto Hidden
Int Property EquipWeightNormPoor = 1 Auto Hidden
Int Property EquipWeightNormMed = 1 Auto Hidden
Int Property EquipWeightNormRich = 1 Auto Hidden
Int Property EquipWeightBastPoor = 1 Auto Hidden
Int Property EquipWeightBastMed = 1 Auto Hidden
Int Property EquipWeightBastRich = 1 Auto Hidden

Int Property KeyForConfigMenu = 208 Auto Hidden

Int Property TemporaryFameLocationExpiration = 7 Auto Hidden
Int Property AmountFamePCLocationDecadence = 5 Auto Hidden
Int Property FameMinToAllowContage = 15 Auto Hidden
Int Property ProbRandomFillTempLib = 1 Auto Hidden
Int Property ProbRandomFillTempPro = 1 Auto Hidden
Int Property ProbRandomFillTempRap = 1 Auto Hidden
Int Property ProbRandomFillTempSla = 1 Auto Hidden
Int Property ProbRandomFillTempZoo = 1 Auto Hidden
Int Property ProbRandomFillTempMig = 1 Auto Hidden
Int Property ProbRandomFillTempMia = 1 Auto Hidden

;Int Property MaxGainFromSlaveTatsSpecific = 50 Auto Hidden
Int Property MaxGainFromDDVibrationEvent = 50 Auto Hidden
;Int Property DDVibAnimIncreaseFame Auto Hidden
Int Property SGOProgressionGemLevelNeeded = 20 Auto Hidden

Function ResetExcludedList()
	ExcludedFeet = New Form[10]
	ExcludedHand = New Form[10]
	ExcludedHead = New Form[10]
	ExcludedBody = New Form[10]
EndFunction

Function ResetExcludedTats()
	ExcludedSlaveTats = New String[10]
	ExcludedSlaveTats[0] = "Stockings"
	ExcludedSlaveTats[1] = "Makeup"
	ExcludedSlaveTats[2] = "Scars"
	ExcludedSlaveTats[3] = ""
	ExcludedSlaveTats[4] = ""
	ExcludedSlaveTats[5] = ""
	ExcludedSlaveTats[6] = ""
	ExcludedSlaveTats[7] = ""
	ExcludedSlaveTats[8] = ""
	ExcludedSlaveTats[9] = ""
EndFunction

Function LoadFameLocationsList()
	FameLocationsList[0] = Game.GetFormFromFile(0x00018A50, "Skyrim.esm") As Location	;Dawnstar
	FameLocationsList[1] = Game.GetFormFromFile(0x00018A49, "Skyrim.esm") As Location	;Falkreath
	FameLocationsList[2] = Game.GetFormFromFile(0x00018A59, "Skyrim.esm") As Location	;Markarth
	FameLocationsList[3] = Game.GetFormFromFile(0x00018A53, "Skyrim.esm") As Location	;Morthal
	FameLocationsList[4] = Game.GetFormFromFile(0x00018A58, "Skyrim.esm") As Location	;Riften
	FameLocationsList[5] = Game.GetFormFromFile(0x00018A5A, "Skyrim.esm") As Location	;Solitude
	FameLocationsList[6] = Game.GetFormFromFile(0x00018A56, "Skyrim.esm") As Location	;Whiterun
	FameLocationsList[7] = Game.GetFormFromFile(0x00018A57, "Skyrim.esm") As Location	;Windhelm
	FameLocationsList[8] = Game.GetFormFromFile(0x00018A51, "Skyrim.esm") As Location	;Winterhold
	FameLocationsList[9] = Game.GetFormFromFile(0x00018A46, "Skyrim.esm") As Location	;DragonBridge
	FameLocationsList[10] = Game.GetFormFromFile(0x00018A4B, "Skyrim.esm") As Location	;Ivarstead
	FameLocationsList[11] = Game.GetFormFromFile(0x00018A54, "Skyrim.esm") As Location	;Karthwasten
	FameLocationsList[12] = Game.GetFormFromFile(0x00013163, "Skyrim.esm") As Location	;Riverwood
	FameLocationsList[13] = Game.GetFormFromFile(0x00018A47, "Skyrim.esm") As Location	;Rorikstead
	FameLocationsList[14] = Game.GetFormFromFile(0x00018A4C, "Skyrim.esm") As Location	;ShorsStone
	FameLocationsList[15] = Game.GetFormFromFile(0x00076F3A, "Skyrim.esm") As Location	;WinterholdCollege
	FameLocationsList[16] = Game.GetFormFromFile(0x00019171, "Skyrim.esm") As Location	;DushnikhYal
	FameLocationsList[17] = Game.GetFormFromFile(0x00019263, "Skyrim.esm") As Location	;Largashbur
	FameLocationsList[18] = Game.GetFormFromFile(0x0001927C, "Skyrim.esm") As Location	;MorKhazgur
	FameLocationsList[19] = Game.GetFormFromFile(0x00019282, "Skyrim.esm") As Location	;Narzulbur
	
	LocationExcludedFromTracking[0] = Game.GetFormFromFile(0x000130FF, "Skyrim.esm") As Location	;Tamriel
EndFunction

Function UpdateLocationsList()
	If Game.GetFormFromFile(0x00004C20, "Dawnguard.esm")
		FameLocationsList[20] = Game.GetFormFromFile(0x00004C20, "Dawnguard.esm") As Location	;CastleVolkihar
		FameLocationsList[21] = Game.GetFormFromFile(0x00004C1F, "Dawnguard.esm") As Location	;FortDawnguard(DaySpringCanyon)
		FameLocationsListString[20] = "Castle Volkihar [Loc#20]"
		FameLocationsListString[21] = "Fort Dawnguard (DaySpringCanyon) [Loc#21]"
	Else
		FameLocationsList[20] = None
		FameLocationsList[21] = None
		FameLocationsListString[20] = "[Reserved DG Loc] [Loc#20]"
		FameLocationsListString[21] = "[Reserved DG Loc] [Loc#21]"
	EndIf
	
	If Game.GetFormFromFile(0x000143BB, "Dragonborn.esm")
		FameLocationsList[22] = Game.GetFormFromFile(0x000143BB, "Dragonborn.esm") As Location	;SkaalVillage
		FameLocationsList[23] = Game.GetFormFromFile(0x000143B9, "Dragonborn.esm") As Location	;RavenRock
		FameLocationsListString[22] = "SkaalVillage [Loc#22]"
		FameLocationsListString[23] = "RavenRock [Loc#23]"
	
		LocationExcludedFromTracking[1] = Game.GetFormFromFile(0x00016E2A, "Dragonborn.esm") As Location	;Solstheim
	Else
		FameLocationsList[22] = None
		FameLocationsList[23] = None
		FameLocationsListString[22] = "[Reserved DB Loc] [Loc#22]"
		FameLocationsListString[23] = "[Reserved DB Loc] [Loc#23]"
	
		LocationExcludedFromTracking[1] = None
	EndIf
EndFunction

Function DDUpdateKeyword()
	DDHeadDevice = New Keyword[4]
	DDBodyDevice = New Keyword[14]
	DDOtherDevice = New Keyword[2]
	
	If DeviousDevicesIntegrationLoaded
		;DDFootDevice = New Keyword[1]
		;DDFootDevice[0] = 
		
		;DDHandDevice = New Keyword[1]
		;DDHandDevice[0] = 
		
		;DDHeadDevice = New Keyword[4]
		DDHeadDevice[0] = Game.GetFormFromFile(0x00011B1A, "Devious Devices - Assets.esm") As Keyword	;Blindfold
		DDHeadDevice[1] = Game.GetFormFromFile(0x0002AFA2, "Devious Devices - Assets.esm") As Keyword	;Hood
		DDHeadDevice[2] = Game.GetFormFromFile(0x00007EB8, "Devious Devices - Assets.esm") As Keyword	;Gag*
		DDHeadDevice[3] = Game.GetFormFromFile(0x0000FAC9, "Devious Devices - Assets.esm") As Keyword	;PermitOral
		
		;DDBodyDevice = New Keyword[14]
		DDBodyDevice[0] = Game.GetFormFromFile(0x00003330, "Devious Devices - Assets.esm") As Keyword	;Belt
		DDBodyDevice[1] = Game.GetFormFromFile(0x00003DFA, "Devious Devices - Assets.esm") As Keyword	;Bra
		DDBodyDevice[2] = Game.GetFormFromFile(0x00027F28, "Devious Devices - Assets.esm") As Keyword	;Corset
		DDBodyDevice[3] = Game.GetFormFromFile(0x00017C43, "Devious Devices - Assets.esm") As Keyword	;Harness
		DDBodyDevice[4] = Game.GetFormFromFile(0x0000CA39, "Devious Devices - Assets.esm") As Keyword	;Nip Piercing
		DDBodyDevice[5] = Game.GetFormFromFile(0x00023E70, "Devious Devices - Assets.esm") As Keyword	;Vag Piercing
		DDBodyDevice[6] = Game.GetFormFromFile(0x00003DF9, "Devious Devices - Assets.esm") As Keyword	;ArmCuff*
		DDBodyDevice[7] = Game.GetFormFromFile(0x00003DF7, "Devious Devices - Assets.esm") As Keyword	;Collar*
		DDBodyDevice[8] = Game.GetFormFromFile(0x00003DF8, "Devious Devices - Assets.esm") As Keyword	;LegCuff*
		DDBodyDevice[9] = Game.GetFormFromFile(0x0000FACA, "Devious Devices - Assets.esm") As Keyword	;PermitAnal
		DDBodyDevice[10] = Game.GetFormFromFile(0x0000FACB, "Devious Devices - Assets.esm") As Keyword	;PermitVaginal
		DDBodyDevice[11] = Game.GetFormFromFile(0x0001DD7D, "Devious Devices - Assets.esm") As Keyword	;PlugAnal
		DDBodyDevice[12] = Game.GetFormFromFile(0x0001DD7C, "Devious Devices - Assets.esm") As Keyword	;PlugVaginal
		DDBodyDevice[13] = Game.GetFormFromFile(0x0002C531, "Devious Devices - Assets.esm") As Keyword	;DeviousYoke
		
		;DDOtherDevice = New Keyword[2]
		DDOtherDevice[0] = Game.GetFormFromFile(0x00027F29, "Devious Devices - Assets.esm") As Keyword	;Boots
		DDOtherDevice[1] = Game.GetFormFromFile(0x0002AFA1, "Devious Devices - Assets.esm") As Keyword	;Gloves
		
		DDSuit = Game.GetFormFromFile(0x0002AFA3, "Devious Devices - Assets.esm") As Keyword
		DDLockable = Game.GetFormFromFile(0x00003894, "Devious Devices - Assets.esm") As Keyword
		DDGenericBlock = Game.GetFormFromFile(0x000429FB, "Devious Devices - Integration.esm") As Keyword	;Used By Quest
		
		DDAnimationFaction = Game.GetFormFromFile(0x00029567, "Devious Devices - Integration.esm") As Faction	;DDAnimationFaction
		DDVibratingFaction = Game.GetFormFromFile(0x00029568, "Devious Devices - Integration.esm") As Faction	;DDVibratingFaction
		MaxGainFromDDVibrationEvent = 50
    Else
		DDSuit = None
		DDLockable = None
		DDGenericBlock = None
		DDAnimationFaction = None
		DDVibratingFaction = None
		MaxGainFromDDVibrationEvent = 0
	EndIf
EndFunction

Function HydUpdateReference()
	If HydraSlavegirlsLoaded
		HydMiscFaction = Game.GetFormFromFile(0x000122B6, "hydra_slavegirls.esp") As Faction	;HydMiscFaction
	Else
		HydMiscFaction = None
	EndIf
EndFunction

Function BathingInSkyrimReference()
	BathingInSkyrimEffects = New MagicEffect[4]
	BathingInSkyrimDirt = New MagicEffect[2]
	
	If BathingInSkyrimLoaded
		BathingInSkyrimEffects[0] = Game.GetFormFromFile(0x00028A3B, "Bathing in Skyrim - Main.esp") As MagicEffect	;mzinPlayBathingAnimationWithoutSoapEffect
		BathingInSkyrimEffects[1] = Game.GetFormFromFile(0x000228FF, "Bathing in Skyrim - Main.esp") As MagicEffect	;mzinPlayBathingAnimationWithSoapEffect
		BathingInSkyrimEffects[2] = Game.GetFormFromFile(0x00028FA3, "Bathing in Skyrim - Main.esp") As MagicEffect	;mzinPlayShoweringAnimationWithoutSoapEffect
		BathingInSkyrimEffects[3] = Game.GetFormFromFile(0x00028FA2, "Bathing in Skyrim - Main.esp") As MagicEffect	;mzinPlayShoweringAnimationWithSoapEffect
		
		BathingInSkyrimDirt[0] = Game.GetFormFromFile(0x0000E55D, "Bathing in Skyrim - Main.esp") As MagicEffect	;mzinDirtinessTier2Effect
		BathingInSkyrimDirt[1] = Game.GetFormFromFile(0x0000E55E, "Bathing in Skyrim - Main.esp") As MagicEffect	;mzinDirtinessTier3Effect
	EndIf
EndFunction

Function LoadRoleTypeString()
	RoleTypeListString = New String[9]
	
	RoleTypeListstring[0] = "$SLSF_ROLETYPENAME_00"
	RoleTypeListstring[1] = "$SLSF_ROLETYPENAME_01"
	RoleTypeListstring[2] = "$SLSF_ROLETYPENAME_02"
	RoleTypeListstring[3] = "$SLSF_ROLETYPENAME_20"
	RoleTypeListstring[4] = "$SLSF_ROLETYPENAME_21"
	RoleTypeListstring[5] = "$SLSF_ROLETYPENAME_22"
	RoleTypeListstring[6] = "$SLSF_ROLETYPENAME_40"
	RoleTypeListstring[7] = "$SLSF_ROLETYPENAME_41"
	RoleTypeListstring[8] = "$SLSF_ROLETYPENAME_42"
EndFunction

Function LoadBaseSTSpecificSlot()
	STSpecificTatName = New String[15]
	STSpecificBodyLoc = New Int[15]
	STSpecificFameType = New Int[15]
	STSpecificLimitMax = New Int[15]
	
	 STSpecificTatName[0] = "Anal"
	 STSpecificBodyLoc[0] = 0
	STSpecificFameType[0] = 0
	STSpecificLimitMax[0] = 100
	
	 STSpecificTatName[1] = "Zoo"
	 STSpecificBodyLoc[1] = 0
	STSpecificFameType[1] = 2
	STSpecificLimitMax[1] = 100
	
	 STSpecificTatName[2] = "Dominant"
	 STSpecificBodyLoc[2] = 0
	STSpecificFameType[2] = 3
	STSpecificLimitMax[2] = 100
	
	 STSpecificTatName[3] = "Sm"
	 STSpecificBodyLoc[3] = 0
	STSpecificFameType[3] = 10
	STSpecificLimitMax[3] = 100
	
	 STSpecificTatName[4] = "Scrawl"
	 STSpecificBodyLoc[4] = 1
	STSpecificFameType[4] = 11
	STSpecificLimitMax[4] = 100
	
	 STSpecificTatName[5] = "Slut"
	 STSpecificBodyLoc[5] = 1
	STSpecificFameType[5] = 17
	STSpecificLimitMax[5] = 100
	
	 STSpecificTatName[6] = "Property"
	 STSpecificBodyLoc[6] = 0
	STSpecificFameType[6] = 18
	STSpecificLimitMax[6] = 100
	
	 STSpecificTatName[7] = "Submissive"
	 STSpecificBodyLoc[7] = 0
	STSpecificFameType[7] = 18
	STSpecificLimitMax[7] = 100
	
	 STSpecificTatName[8] = "Whore"
	 STSpecificBodyLoc[8] = 0
	STSpecificFameType[8] = 19
	STSpecificLimitMax[8] = 100

	Int a = 14
	While a > 8
		 STSpecificTatName[a] = "None"	
		 STSpecificBodyLoc[a] = -1
		STSpecificFameType[a] = -1
		STSpecificLimitMax[a] = 100
		a -= 1
	EndWhile
EndFunction

Function LoadSkoomaWhoreReference()
	SKWPhysicalDecadenceSpell = New Spell[3]
	
	If SkoomaWhoreLoaded
		SKWPhysicalDecadenceSpell[0] = Game.GetFormFromFile(0x000012D2, "SexLabSkoomaWhore.esp") As Spell	;Stage 3
		SKWPhysicalDecadenceSpell[1] = Game.GetFormFromFile(0x000012D4, "SexLabSkoomaWhore.esp") As Spell	;Stage 4
		SKWPhysicalDecadenceSpell[2] = Game.GetFormFromFile(0x000012D6, "SexLabSkoomaWhore.esp") As Spell	;Stage 5
	Else
		SKWPhysicalDecadenceSpell[0] = None
		SKWPhysicalDecadenceSpell[1] = None
		SKWPhysicalDecadenceSpell[2] = None
	EndIf
	
EndFunction

Function LoadEstrusChaurusReference()
	If EstrusChaurusLoaded
		EsChaurusBreederFaction = Game.GetFormFromFile(0x000160A9, "EstrusChaurus.esp") As Faction
		EsChaurusBreederAbility = Game.GetFormFromFile(0x00019121, "EstrusChaurus.esp") As Spell
	Else
		EsChaurusBreederFaction = None
		EsChaurusBreederAbility = None
		EsChaurusPlayerPregnant = False
	EndIf
EndFunction

Function LoadTraitNames()
	Int a = TraitFaction.GetSize()
	TraitName = Utility.CreateStringArray(a)
	While a > 0
		a -= 1
		TraitName[a] = TraitFaction.GetAt(a).GetName()
	EndWhile
EndFunction
