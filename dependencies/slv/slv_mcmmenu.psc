Scriptname SLV_MCMMenu extends SKI_ConfigBase  

Actor Property PlayerRef Auto
Faction Property SlaverunSlaveFaction auto
Faction Property SlaverunSlaverFaction auto
Faction Property SLV_SlaveBasicTraining auto
Faction Property SLV_SlaveAdvancedTraining auto
Faction Property SLV_SlaveBeastTraining auto
Faction Property SLV_SlavePainslutTraining auto
Quest Property SlaverunPeriodicChecking auto
Quest Property SlaverunQuest Auto
Quest Property SLV_Mainquest2Quest Auto
Quest Property SLV_Prequest_01 Auto
Quest Property SLV_Prequest_02 Auto
SLV_Utilities Property myScripts auto
SLV_SoftHydraSlavegirls  Property hydraslavegirls Auto
SLV_PeriodicReporting Property periodicReporting Auto
SLV_Mainquest Property mainquest Auto
SLV_EnforcerLocationCheck Property enforcerLocationCheck Auto
SLV_SlaveManagementQuest Property slaveManagement Auto

string[] ThemeList
string[] ColorList
String File

string[] xxxNPCOutfitList
string[] NPCOutfitColorList
string[] FreeNPCOutfitList
string[] SlaveNPCOutfitList

GlobalVariable Property SLV_WhiterunMaxTask  Auto 
GlobalVariable Property SLV_WhiterunTasksDone  Auto 
GlobalVariable Property SLV_ArenaFightsWon  Auto 
GlobalVariable Property SLV_StopEnforcer Auto
GlobalVariable Property SLV_EnforcerRunning Auto
GlobalVariable Property SLV_IvanaMood Auto
GlobalVariable Property SLV_BrutusMood Auto
GlobalVariable Property SLV_PikeMood Auto
GlobalVariable Property SLV_FactionFreeSubmissive Auto
GlobalVariable Property SLV_StoryMode Auto
GlobalVariable Property SLV_SceneWhipping Auto
GlobalVariable Property SLV_MaxTask Auto 
GlobalVariable Property SLV_CarriageDisabled Auto 
GlobalVariable Property SLV_WeightGain Auto 
GlobalVariable Property SLV_SlaveSexCounter Auto
GlobalVariable Property SLV_NPCDialog Auto
GlobalVariable Property SLV_BreastSize Auto
GlobalVariable Property SLV_EnforcerIgnorePC Auto
GlobalVariable Property SLV_LevelForPrequest Auto
GlobalVariable Property SLV_AutomaticEnslavement Auto
GlobalVariable Property SLV_ColosseumRandomBeast Auto
GlobalVariable Property SLV_ColosseumRandomGladiator Auto
GlobalVariable Property SLV_ColosseumRandomFightMode Auto
GlobalVariable Property SLV_ColosseumQuickMode Auto
GlobalVariable Property SLV_GuardNoForceGreet Auto
GlobalVariable Property SLV_FinnEnabled Auto
GlobalVariable Property SLV_ReportingGold Auto
GlobalVariable Property SLV_ColosseumShowsDone Auto
GlobalVariable Property SLV_ColosseumFightsWon Auto

Actor [] Property Followers Auto
Actor Property slavefollower Auto
Actor Property nonslavefollower Auto
Actor Property malefollower Auto
Int Property followersCount Auto

Actor Property selectedActor Auto


Int Property ReportedAvgCheckInterval auto
Int Property FemaleNPCsStripped auto
Int Property SlavesCalledForSex auto
Int Property FreeFemalesCalledForSex auto
Float Property TotalCheckIntervals auto
Float Property TotalChecksPerformed auto

; settings for import/export

Float Property MaxDistanceToCallSlave auto
Float Property RatioOfSlaveDistanceForFreeWomen Auto
Int Property ArousalToFuckSlave auto
Bool Property AggressiveFuckForSlaves auto
Bool Property AnalFuckForSlaves auto
Int Property ArousalToFuckFreeFemale auto
Bool Property AggressiveFuckForFreeFemales auto
Bool Property AnalFuckForFreeFemales auto
Int Property CheckInterval auto
Bool Property ArousedMalesFuckSlaves auto
Bool Property ArousedMalesFuckFreeFemales auto
Bool Property TattleTales auto
Bool Property FemaleFollowersMimicPlayer auto
Bool Property MTUserScreen auto
Bool Property MTUserConsole auto
Bool Property MTUserLog auto
Bool Property MTInformationScreen auto
Bool Property MTInformationConsole auto
Bool Property MTInformationLog auto
Bool Property MTDebug1Screen auto
Bool Property MTDebug1Console auto
Bool Property MTDebug1Log auto
Bool Property MTDebug2Screen auto
Bool Property MTDebug2Console auto
Bool Property MTDebug2Log auto

; new options
Bool Property FollowerScan Auto
Bool Property SlaveShaving auto
Int Property ShaveRegrouthTime auto
Int Property ShaveRegrouthRound auto
Bool Property SlaveTatoos auto
Bool Property SlaveRenaming auto
Bool Property PutItemsInChest auto
Bool Property EnforcerEnabled auto
Bool Property ArousedMalesFuckPC auto
Bool Property SkipOldPeople auto
Bool Property EnableUndressing auto
Bool Property EnableUndressSlot30 auto
Bool Property EnableUndressSlot32 auto
Bool Property EnableUndressSlot46 auto
Bool Property EnableUndressSlot49 auto
Bool Property EnableUndressSlot52 auto
Bool Property EnableUndressSlot56 auto
Bool Property EnableUndressLeftHand auto
Bool Property EnableUndressRightHand auto
Bool Property ForceReporting auto
Bool Property WhippingSound auto
Bool Property DieOnBadEnd auto
Bool Property SleepingSlavery auto

Bool Property SkipCreatureSex auto
Bool Property SkipSexScenes auto
Bool Property SkipScenes auto
Bool Property SkipWhipping auto
Bool Property SkipDevices auto
Bool Property SkipBranding auto

Bool Property NudityCrime auto
Int Property NudityCrimeAmount auto
Bool Property NudityPunishment auto
Bool Property NudityRescue auto
Bool Property NudityEnslavement auto

Bool Property Hydragon auto
Int Property CityEnslavingTime auto
Int Property WhiterunmaxTask auto
int property equiptheme = 0 auto
int property equipcolor = 0 auto

int property FreeNPCOutfit = 0 auto
int property SlaveNPCOutfit = 0 auto
int property NPCOutfitcolor = 0 auto

Int Property ReportingTime auto
Int Property EnforcerMaxSexlabCalls auto
Bool Property SkipIntensiveSexlabChecks auto
Bool Property EnforcerAutomaticStrip auto
Bool Property OutfitNPCFree auto
Bool Property OutfitNPCSlave auto
Bool Property OutfitNPCFollower auto
Bool Property EnforcerLocationJSON auto
Bool Property CombatPausesEnforcer auto
Bool Property CheatsEnabled auto
Bool Property AutoProgression auto
Bool Property PCGangbang auto
Int Property PCGangbangProbability auto
Bool Property SkipAmputee auto
Bool Property ypsFashionShaving auto
Bool Property SkipDevicesForMen auto
Bool Property StoryMode auto
Int Property maxTasks auto
Int Property KeyForNotification = 49 Auto
Bool Property ShowNotifications auto
Bool Property BreastGrowing auto
Bool Property BreastWeightGrowing auto
Bool Property BreastSLIFGrowing auto
Float Property BreastSLIFSize auto
Bool Property NoCarriageTravel auto
Bool Property SOSSlaverSchlong auto
Bool Property UseSexlabVirginity auto
Bool Property NPCDialog auto
Float Property BreastSLIFDelta auto
Int Property QuestStartAtLevel auto
Bool Property DisableFastTravel auto
Bool Property EnforcerSexScenes auto
Int Property enforcerSexSceneProbabilty auto
Int Property travelSexProbabilty auto
Int Property walkOfShameProbabilty auto

Bool Property SlaveGuardsForceGreet auto
Int Property SlaveGuardsCheckInterval auto
Bool Property GoodSlavesAvoidWalkofShame auto
Bool Property SlaveGuardsEquipDevices auto
Bool Property ChangeHairColor auto


Bool Property arenaFreeModeChoice auto
Bool Property arenaFreeOpponentChoice auto
Bool Property arenaDeathMatch auto
Bool Property arenaDeathRapeMatch auto
Bool Property arenaTrainingMatch auto
Bool Property arenaTrainingRapeMatch auto
Bool Property arenaSpeedMatch auto

Bool Property arenaHama auto
Bool Property arenaDomonkos auto
Bool Property arenaBandon auto

Bool Property arenaHaldir auto
Bool Property arenaCalum auto
Bool Property arenaAllanon auto

Bool Property arenaArtus auto
Bool Property arenaDesmond auto
Bool Property arenaAkiro auto

Bool Property arenaAzogTheOrc auto
Bool Property arenaHannibal  auto

Bool Property arenaMaximus  auto
Bool Property arenaDopperfield auto

Bool Property arenaDastan auto
Bool Property arenaMoudini  auto

Bool Property arenaCalar auto
Bool Property arenaArno  auto

Bool Property arenaConan  auto
Bool Property arenaMerlin auto

Bool Property arenaTwoTails auto

Bool Property arenaDog auto
Bool Property arenaCow auto
Bool Property arenaChicken auto
Bool Property arenaGoat auto

Bool Property arenaHorse auto
Bool Property arenaSkeever auto
Bool Property arenaDeer auto
Bool Property arenaBoar auto

Bool Property arenaSpider auto
Bool Property arenaSkeleton auto
Bool Property arenaDraugr auto
Bool Property arenaFalmer auto

Bool Property arenaRiekling auto
Bool Property arenaLargeSpider auto
Bool Property arenaWolf auto
Bool Property arenaChaurus auto
Bool Property arenaDwarvenSpider auto

Bool Property arenaBear auto
Bool Property arenaSabrecat auto
Bool Property arenaTroll auto
Bool Property arenaHorker auto
Bool Property arenaNetch auto
Bool Property arenaDwarvenSphere auto
Bool Property arenaChaurusHunter auto

Bool Property arenaDeathHound auto
Bool Property arenaFrostAtronach auto
Bool Property arenaGargoyle auto
Bool Property arenaChaurusReaper auto
Bool Property arenaDwarvenBallista auto
Bool Property arenaBoarRiekling auto

Bool Property arenaMammoth auto
Bool Property arenaSeeker auto
Bool Property arenaSpiderGiant auto
Bool Property arenaDwarvenCenturion auto

Bool Property arenaDragonPriest auto
Bool Property arenaVampireLord auto
Bool Property arenaWerewolf auto
Bool Property arenaGiant auto
Bool Property arenaLurker auto

Bool Property arenaDragon auto

Bool Property equipGag auto
Bool Property equipAnalPlug auto
Bool Property equipVagPlug auto
Bool Property equipHarness auto
Bool Property equipBelt auto
Bool Property equipBra auto
Bool Property equipCollar auto
Bool Property equipLegCuffs auto
Bool Property equipArmCuffs auto
Bool Property equipArmbinder auto
Bool Property equipYoke auto
Bool Property equipBlindfold auto
Bool Property equipNPiercings auto
Bool Property equipVPiercings auto
Bool Property equipBoots auto
Bool Property equipGloves auto
Bool Property equipCorset auto
Bool Property equipMittens auto
Bool Property equipHood auto
Bool Property equipClamps auto
Bool Property equipSuit auto
Bool Property equipShackles auto
Bool Property equipHobblesSkirt auto
Bool Property equipHobblesSkirtRelaxed auto
Bool Property equipStraitJacket auto


Bool Property equipMaleGag auto
Bool Property equipMaleAnalPlug auto
Bool Property equipMaleVagPlug auto
Bool Property equipMaleHarness auto
Bool Property equipMaleBelt auto
Bool Property equipMaleBra auto
Bool Property equipMaleCollar auto
Bool Property equipMaleLegCuffs auto
Bool Property equipMaleArmCuffs auto
Bool Property equipMaleArmbinder auto
Bool Property equipMaleYoke auto
Bool Property equipMaleBlindfold auto
Bool Property equipMaleNPiercings auto
Bool Property equipMaleVPiercings auto
Bool Property equipMaleBoots auto
Bool Property equipMaleGloves auto
Bool Property equipMaleCorset auto
Bool Property equipMaleMittens auto
Bool Property equipMaleHood auto
Bool Property equipMaleClamps auto
Bool Property equipMaleSuit auto
Bool Property equipMaleShackles auto
Bool Property equipMaleHobblesSkirt auto
Bool Property equipMaleHobblesSkirtRelaxed auto

Bool Property submissiveAutoEnslave auto
Bool Property dontDieInArena auto

Int Property arenaAmputationProbabilty auto
Int Property arenaEnslavementProbabilty auto
Int Property arenaRapeProbabilty auto
Bool Property arenaFightAlone auto
Bool Property arenaBeheading auto
Int Property arenaArmorRemoveProbabilty auto
Bool Property arenaGore auto
Bool Property arenaQuickMode auto
Bool Property enforcerForceToCrawl auto
Bool Property forceToCrawlInteriorOnly auto
Bool Property guardForceGreet auto

Bool Property slaveGuard auto
Bool Property reportMoneyOnly auto
Int Property ReportingMoney auto
Bool Property reportSubmissiveCheck auto		
Bool Property reportConfiscateGold auto	
Int Property reportConfiscateGoldLeft auto
Bool Property reportConfiscateItems auto	
Bool Property reportsendSlaverPatrol auto
Bool Property enforcerForSlavers auto
Bool Property rapeForSlavers auto
Int Property rapeForSlaversProbabilty auto



; PRIVATE VARIABLES -------------------------------------------------------------------------------
Bool ModisRunning = false
int equipthemeOID
int equipcolorOID
int freenpcoutfitOID
int slavenpcoutfitOID
int npcoutfitcolorOID
int sceneOID

int exportsettings1OID
int importsettings1OID
int resetsettingsOID

int exportsettings2OID
int importsettings2OID
int exportsettings3OID
int importsettings3OID

int addDDGagOID
int addDDAnalPlugOID
int addDDVagPlugOID
int addDDHarnessOID
int addDDBeltOID
int addDDBraOID
int addDDCollarOID
int addDDLegCuffsOID
int addDDArmCuffsOID
int addDDArmbinderOID
int addDDYokeOID
int addDDBlindfoldOID
int addDDNPiercingsOID
int addDDVPiercingsOID
int addDDBootsOID
int addDDGlovesOID
int addDDCorsetOID
int addDDMittensOID
int addDDHoodOID
int addDDClampsOID
int addDDSuitOID
int addDDShacklesOID
int addDDHobblesSkirtOID
int addDDHobblesSkirtRelaxedOID
int addDDStraitJacketOID
int addDDChainsOID
int addDDsOID

int shavePCOID
int tattooPCOID
int slaveslutPCOID
int simpleSlaveryOID

int removeDDGagOID
int removeDDAnalPlugOID
int removeDDVagPlugOID
int removeDDHarnessOID
int removeDDBeltOID
int removeDDBraOID
int removeDDCollarOID
int removeDDLegCuffsOID
int removeDDArmCuffsOID
int removeDDArmbinderOID
int removeDDYokeOID
int removeDDBlindfoldOID
int removeDDNPiercingsOID
int removeDDVPiercingsOID
int removeDDBootsOID
int removeDDGlovesOID
int removeDDCorsetOID
int removeDDMittensOID
int removeDDHoodOID
int removeDDClampsOID
int removeDDSuitOID
int removeDDShacklesOID
int removeDDHobblesSkirtOID
int removeDDHobblesSkirtRelaxedOID
int removeDDStraitJacketOID
int removeDDAllOID
int removeDDsOID

bool addDDGag=false
bool addDDAnalPlug=false
bool addDDVagPlug=false
bool addDDHarness=false
bool addDDBelt=false
bool addDDBra=false
bool addDDCollar=false
bool addDDLegCuffs=false
bool addDDArmCuffs=false
bool addDDArmbinder=false
bool addDDYoke=false
bool addDDBlindfold=false
bool addDDNPiercings=false
bool addDDVPiercings=false
bool addDDBoots=false
bool addDDGloves=false
bool addDDCorset=false
bool addDDMittens=false
bool addDDHood=false
bool addDDClamps=false
bool addDDSuit=false
bool addDDShackles=false
bool addDDHobblesSkirt=false
bool addDDHobblesSkirtRelaxed=false
bool addDDStraitJacket=false

bool removeDDGag=false
bool removeDDAnalPlug=false
bool removeDDVagPlug=false
bool removeDDHarness=false
bool removeDDBelt=false
bool removeDDBra=false
bool removeDDCollar=false
bool removeDDLegCuffs=false
bool removeDDArmCuffs=false
bool removeDDArmbinder=false
bool removeDDYoke=false
bool removeDDBlindfold=false
bool removeDDNPiercings=false
bool removeDDVPiercings=false
bool removeDDBoots=false
bool removeDDGloves=false
bool removeDDCorset=false
bool removeDDMittens=false
bool removeDDHood=false
bool removeDDClamps=false
bool removeDDSuit=false
bool removeDDShackles=false
bool removeDDHobblesSkirt=false
bool removeDDHobblesSkirtRelaxed=false
bool removeDDStraitJacket=false


int sosSlaverSchlongOID
int useSexlabVirginityOID
int NPCDialogOID
int BimboHairOID
int ResetDiamondOID
int EnableIvanaOID

int removePlayerFromSlaveOID
int addPlayerToSlaveOID
int removePlayerFromSlaverOID
int addPlayerToSlaverOID

int disableFastTravelOID
int enforcerSexScenesOID

int slaveGuardsForceGreetOID
int goodSlavesAvoidWalkofShameOID
int slaveGuardsEquipDevicesOID
int changeHairColorOID


int arenaFreeModeChoiceOID
int arenaFreeOpponentChoiceOID
int arenaDeathMatchOID
int arenaDeathRapeMatchOID
int arenaTrainingMatchOID
int arenaTrainingRapeMatchOID
int arenaSpeedMatchOID

int arenaHamaOID
int arenaDomonkosOID
int arenaBandonOID

int arenaHaldirOID
int arenaCalumOID
int arenaAllanonOID

int arenaArtusOID
int arenaDesmondOID
int arenaAkiroOID

int arenaAzogTheOrcOID
int arenaHannibalOID

int arenaMaximusOID
int arenaDopperfieldOID

int arenaDastanOID
int arenaMoudiniOID

int arenaCalarOID
int arenaArnoOID

int arenaConanOID
int arenaMerlinOID

int arenaTwoTailsOID

int arenaDogOID 
int arenaCowOID 
int arenaChickenOID 
int arenaGoatOID 

int arenaHorseOID 
int arenaSkeeverOID 
int arenaDeerOID 
int arenaBoarOID 

int arenaSpiderOID 
int arenaSkeletonOID 
int arenaDraugrOID 
int arenaFalmerOID 

int arenaRieklingOID 
int arenaLargeSpiderOID
int arenaWolfOID
int arenaChaurusOID 
int arenaDwarvenSpiderOID 

int arenaBearOID 
int arenaSabrecatOID 
int arenaTrollOID
int arenaHorkerOID 
int arenaNetchOID 
int arenaDwarvenSphereOID 
int arenaChaurusHunterOID 

int arenaDeathHoundOID 
int arenaFrostAtronachOID 
int arenaGargoyleOID 
int arenaChaurusReaperOID 
int arenaDwarvenBallistaOID 
int arenaBoarRieklingOID 

int arenaMammothOID 
int arenaSeekerOID 
int arenaSpiderGiantOID 
int arenaDwarvenCenturionOID 
 
int arenaDragonPriestOID 
int arenaVampireLordOID
int arenaWerewolfOID
int arenaGiantOID 
int arenaLurkerOID 

int arenaDragonOID

int equipGagOID
int equipAnalPlugOID
int equipVagPlugOID
int equipHarnessOID
int equipBeltOID
int equipBraOID
int equipCollarOID
int equipLegCuffsOID
int equipArmCuffsOID
int equipArmbinderOID
int equipYokeOID
int equipBlindfoldOID
int equipNPiercingsOID
int equipVPiercingsOID
int equipBootsOID
int equipGlovesOID
int equipCorsetOID
int equipMittensOID
int equipHoodOID
int equipClampsOID
int equipSuitOID
int equipShacklesOID
int equipHobblesSkirtOID
int equipHobblesSkirtRelaxedOID
int equipStraitJacketOID

int equipMaleGagOID
int equipMaleAnalPlugOID
int equipMaleVagPlugOID
int equipMaleHarnessOID
int equipMaleBeltOID
int equipMaleBraOID
int equipMaleCollarOID
int equipMaleLegCuffsOID
int equipMaleArmCuffsOID
int equipMaleArmbinderOID
int equipMaleYokeOID
int equipMaleBlindfoldOID
int equipMaleNPiercingsOID
int equipMaleVPiercingsOID
int equipMaleBootsOID
int equipMaleGlovesOID
int equipMaleCorsetOID
int equipMaleMittensOID
int equipMaleHoodOID
int equipMaleClampsOID
int equipMaleSuitOID
int equipMaleShacklesOID
int equipMaleHobblesSkirtOID
int equipMaleHobblesSkirtRelaxedOID

int submissiveAutoEnslaveOID
int dontDieInArenaOID
int arenaFightAloneOID
int arenaBeheadingOID
int arenaGoreOID
int arenaQuickModeOID
int enforcerForceToCrawlOID
int forceToCrawlInteriorOnlyOID
int guardForceGreetOID
int slaveGuardOID

int	reportMoneyOnlyOID	
int	reportSubmissiveCheckOID		
int	reportConfiscateGoldOID		
int	reportConfiscateItemsOID	
int	reportsendSlaverPatrolOID	
int enforcerForSlaversOID
int rapeForSlaversOID

Bool _importing

Bool function areMainAliasFilled()
if !mainquest.Alias_SLV_Diamond || mainquest.Alias_SLV_Diamond == none || mainquest.Alias_SLV_Diamond.getActorRef() == none
	MiscUtil.PrintConsole("Diamond alias:" + mainquest.Alias_SLV_Diamond)
	return false
else
	MiscUtil.PrintConsole("Diamond alias not null:" + mainquest.Alias_SLV_Diamond.getActorRef())
endif
if !mainquest.Alias_SLV_Ivana || mainquest.Alias_SLV_Ivana == none || mainquest.Alias_SLV_Ivana.getActorRef() == none
	MiscUtil.PrintConsole("Ivana alias:" + mainquest.Alias_SLV_Ivana)
	return false
else
	MiscUtil.PrintConsole("Ivana alias not null:" + mainquest.Alias_SLV_Ivana.getActorRef())
endif
if !mainquest.Alias_SLV_Pike || mainquest.Alias_SLV_Pike == none || mainquest.Alias_SLV_Pike.getActorRef() == none
	MiscUtil.PrintConsole("Pike alias:" + mainquest.Alias_SLV_Pike)
	return false
else
	MiscUtil.PrintConsole("Pike alias not null:" + mainquest.Alias_SLV_Pike.getActorRef())
endif
if !mainquest.Alias_SLV_Bellamy || mainquest.Alias_SLV_Bellamy == none || mainquest.Alias_SLV_Bellamy.getActorRef() == none
	MiscUtil.PrintConsole("Bellamy alias:" + mainquest.Alias_SLV_Bellamy)
	return false
else
	MiscUtil.PrintConsole("Bellamy alias not null:" + mainquest.Alias_SLV_Bellamy.getActorRef())
endif

return true
EndFunction

; SCRIPT VERSION ----------------------------------------------------------------------------------
int function GetVersion()
return 29901 ; Default version
endFunction

string Function GetStringVer()
	
return "Version 2.99.01"
EndFunction

;------------- Declare each page for the MCM here 
event OnConfigInit()
ModName = "Slaverun Reloaded"
Pages = new string[13]
Pages[0] = "Common Settings"
Pages[1] = "Slavery Settings"
Pages[2] = "Slavery Status"
Pages[3] = "Enforcer Settings"
Pages[4] = "Enforcer Sex/Strip"
Pages[5] = "Nudity Law"
Pages[6] = "Problems"
Pages[7] = "Arena"
Pages[8] = "Your slaves"
Pages[9] = "Devices"
Pages[10] = "Statistics/Dependencies"
Pages[11] = "Mod Messages"
Pages[12] = "Cheats"


ThemeList = new string[4]
ThemeList[0] = "RANDOM"
ThemeList[1] = "METAL"
ThemeList[2] = "LEATHER"
ThemeList[3] = "EBONITE"

ColorList = new string[4]
ColorList[0] = "RANDOM"
ColorList[1] = "WHITE"
ColorList[2] = "RED"
ColorList[3] = "BLACK"
	
;NPCOutfitList = new string[4]
;NPCOutfitList[0] = "RANDOM"
;NPCOutfitList[1] = "NAKED"
;NPCOutfitList[2] = "NORMAL"
;NPCOutfitList[3] = "FULL"

NPCOutfitColorList = new string[4]
NPCOutfitColorList[0] = "RANDOM"
NPCOutfitColorList[1] = "WHITE"
NPCOutfitColorList[2] = "RED"
NPCOutfitColorList[3] = "BLACK"

FreeNPCOutfitList = new string[6]
FreeNPCOutfitList[0] = "RANDOM"
FreeNPCOutfitList[1] = "Naked"
FreeNPCOutfitList[2] = "Shoes"
FreeNPCOutfitList[3] = "Boots"
FreeNPCOutfitList[4] = "Shoes and Gloves"
FreeNPCOutfitList[5] = "Boots and Gloves"

SlaveNPCOutfitList = new string[7]
SlaveNPCOutfitList[0] = "RANDOM"
SlaveNPCOutfitList[1] = "Naked"
SlaveNPCOutfitList[2] = "Collar"
SlaveNPCOutfitList[3] = "Collar+footchain"
SlaveNPCOutfitList[4] = "Collar+footchain+cuffs"
SlaveNPCOutfitList[5] = "Collar+footchain+cuffs+piercings"
SlaveNPCOutfitList[6] = "Collar+footchain+cuffs+piercings+corset"

_importing = False
endEvent

;------------- Add code for version updates here
event OnVersionUpdate(int a_version)
{Called when a version update of this script has been detected}
;if a_version != GetVersion()
	OnConfigInit()
;endif

if !BreastSLIFDelta
	BreastSLIFDelta = 0.1
endif
endEvent

; EVENTS ------------------------------------------------------------------------------------------
;------------- Build the MCM page requested here (call the function to build the page requested)
; @implements SKI_ConfigBase
event OnPageReset(string a_page)
{Called when a new page is selected, including the initial empty page}
; Load custom logo in DDS format
if (a_page == "")
	; Image size 256x244
	; X offset = 376 - (height / 2) = 258
	; Y offset = 223 - (width / 2) = 101
	LoadCustomContent("Slaverun/Slaverun_mcm.dds", 60, 1)
	return
else
	UnloadCustomContent()
endIf
SetCursorFillMode(TOP_TO_BOTTOM)
if (a_page == "Common Settings")
	PageCommonSettings()
elseif (a_page == "Slavery Settings")
	PageSlaverySettings()
elseif (a_page == "Slavery Status")
	PageSlaveryStatus()
elseif (a_page == "Enforcer Settings")
	PageEnforcerSettings()
elseif (a_page == "Enforcer Sex/Strip")
	PageEnforcerSexStrip()
elseif (a_page == "Nudity Law")
	PageShowNudityLaw()
elseif (a_page == "Problems")
	PageShowProblems()
elseif (a_page == "Arena")
	PageShowArena()
elseif (a_page == "Your slaves")
	PageShowYourSlaves()
elseif (a_page == "Devices")
	PageShowDevices()
elseif (a_page == "Statistics/Dependencies")
	PageShowStatistics()
elseif (a_page == "Mod Messages")
	PageMessages()
ElseIf _importing
	AddHeaderOption("Importing Settings")
elseif (a_page == "Cheats")
	PageCheats()
elseif (a_page == "Mod was shut down")
	AddHeaderOption("Mod is shut down")
endif
endEvent


;------------- Create a function here for each page
Function PageCommonSettings()
AddHeaderOption("Mod status")
if SlaverunQuest.IsRunning() == 1 && !areMainAliasFilled()
	AddTextOption("ALIAS in Mainquest not filled","", OPTION_FLAG_DISABLED)
	AddTextOption("INITIALIZATION FAILED","", OPTION_FLAG_DISABLED)
	
	; shutting down mainquest
	;SlaverunQuest.stop()
	;SlaverunQuest.reset()
	debug.messagebox(" Slaverun installation corrupt, important alias in mainquest are not filled! (Don't activate slaverun  during character creation!!!) Get your papryus.log and post it in sexlab forum, slaverun reloaded thread")
	utility.wait(2.0)
endif
AddSliderOptionST("QuestStartAtLevelState","Player level required to start quest",QuestStartAtLevel,"{0}",Option_Flag_None)

bool PrequestIsRunning;
if (SLV_Prequest_01.IsRunning() == 1 || SLV_Prequest_02.IsRunning() == 1)
	PrequestIsRunning = true;
else  
	PrequestIsRunning = false;
endIf
AddToggleOptionST("PrequestStatusState","Is Prequest running", PrequestIsRunning, OPTION_FLAG_DISABLED )
if (SlaverunQuest.IsRunning() == 1)
	ModisRunning = true;
else  
	ModisRunning = false;
endIf
AddToggleOptionST("ModStatusState","Is Mainquest running", ModisRunning, OPTION_FLAG_DISABLED )

AddHeaderOption("General options")
AddToggleOptionST("NoCarriageTravelState","Travel by carriage disabled", NoCarriageTravel )
AddSliderOptionST("travelSexProbabiltyState","Probability for hardcore traveling",travelSexProbabilty,"{0}",Option_Flag_None)
disableFastTravelOID = AddToggleOption("Disable Fast travel", DisableFastTravel)
submissiveAutoEnslaveOID = AddToggleOption("Submissive woman will be enslaved", submissiveAutoEnslave)
NPCDialogOID  = AddToggleOption("General NPC dialog", NPCDialog)
guardForceGreetOID  = AddToggleOption("Slaverun guards/patrol forcegreet", guardForceGreet)

AddHeaderOption("Quest options")	
AddSliderOptionST("WhiterunmaxTaskState","#tasks needed for next city",WhiterunmaxTask,"{0}",Option_Flag_None)
AddSliderOptionST("maxTasksState","# needed in repetitive tasks",maxTasks,"{0}",Option_Flag_None)
AddToggleOptionST("StoryModeState","Story mode", StoryMode )
AddToggleOptionST("DieOnBadEndState","Die in the bad end of slaverun", DieOnBadEnd )
AddToggleOptionST("SleepingSlaveryState","Slavery will come back", SleepingSlavery )
slaveGuardOID  = AddToggleOption("Slaver guard follower", slaveGuard)


SetCursorPosition(1)
AddHeaderOption("Restore configuration")
resetsettingsOID = AddTextOption("Reset settings to default", "USE")

AddHeaderOption("First setting configuration for normal mode")
exportsettings1OID = AddTextOption("Export settings", "USE")		
importsettings1OID = AddTextOption("Import settings", "USE")	

AddHeaderOption("Second setting configuration for soft mode")
exportsettings2OID = AddTextOption("Export soft mode settings", "USE")		
importsettings2OID = AddTextOption("Import soft mode settings", "USE")	

AddHeaderOption("Third setting configuration for hard mode")
exportsettings3OID = AddTextOption("Export hard mode settings", "USE")		
importsettings3OID = AddTextOption("Import hard mode settings", "USE")	
EndFunction

	
Function PageSlaverySettings()
AddHeaderOption("Slavery options")
AddToggleOptionST("SlaveShavingState","Slave hair shaving", SlaveShaving )
AddSliderOptionST("ShaveRegrouthTimeState","Time in hours to regrow hairs",ShaveRegrouthTime,"{0}",Option_Flag_None)
AddSliderOptionST("ShaveRegrouthRoundState","#haircuts til your original hair reappears",ShaveRegrouthRound,"{0}",Option_Flag_None)
AddToggleOptionST("ypsFashionShavingState","ypsFashion hair shaving", ypsFashionShaving)
changeHairColorOID  = AddToggleOption("Slave hair coloring", ChangeHairColor)		

sosSlaverSchlongOID  = AddToggleOption("SOS slaver schlongs grow", SOSSlaverSchlong)		

AddToggleOptionST("SlaveTatoosState","Slave Tatoos", SlaveTatoos )
AddToggleOptionST("SlaveRenamingState","Slave name changing", SlaveRenaming )
AddToggleOptionST("WhippingSoundState","Whippings with sound", WhippingSound )

AddHeaderOption("Periodically reporting")
AddToggleOptionST("ForceReportingState","Enabled", ForceReporting )
AddSliderOptionST("ReportingTimeState","Time to report periodically",ReportingTime,"{0}",Option_Flag_None)
reportMoneyOnlyOID  = AddToggleOption("Pay fixed money amount", reportMoneyOnly)
AddSliderOptionST("ReportingMoneyState","Money to pay",ReportingMoney,"{0}",Option_Flag_None)		
reportSubmissiveCheckOID  = AddToggleOption("Check on slave attitude", reportSubmissiveCheck)		
reportConfiscateGoldOID  = AddToggleOption("Confiscate gold of player slave", reportConfiscateGold)	
AddSliderOptionST("reportConfiscateGoldLeftState","Money you can keep",reportConfiscateGoldLeft,"{0}",Option_Flag_None)	
	
reportConfiscateItemsOID  = AddToggleOption("Confiscate items of player slave", reportConfiscateItems)	
reportsendSlaverPatrolOID  = AddToggleOption("Send a patrol to get fleeing player slave", reportsendSlaverPatrol)	



String reporttext = "not set"
Float reportdate = StorageUtil.GetFloatValue(None, "SLV_ReportBackHours", 0.0 )
;MiscUtil.PrintConsole("Reportdate:" + reportdate)
Float currentdate = Utility.GetCurrentGameTime()

Float Time = reportdate - currentdate
if Time >= 0.0
	Int Std = Math.Floor(Time)
	;MiscUtil.PrintConsole("Std:" + Std)
	Time = Time - Std
	;Time = ((Time / 5)*3)
	Int IntTime = Math.Floor(Time*24.0)
	;Time = Time + "d" + " " + Std * "h"
	;MiscUtil.PrintConsole("Time:" + Time)
	reporttext = reportdate - currentdate
	reporttext = Std + "d " + IntTime + "h"
	AddTextOption("Time left",reporttext)
	;MiscUtil.PrintConsole("Currentdate:" + currentdate)
elseif ForceReporting
	periodicReporting.StartPeriodicReportingTimer()
endif
	
SetCursorPosition(1)
AddHeaderOption("Breast enlargement")
AddToggleOptionST("BreastGrowingState","Breast will increase", BreastGrowing )
AddToggleOptionST("BreastWeightGrowingState","-> by body weight", BreastWeightGrowing )
AddToggleOptionST("BreastSLIFGrowingState","-> by Inflation Framework", BreastSLIFGrowing )
AddSliderOptionST("BreastSLIFSizeState", "-> current SLIF size", BreastSLIFSize , "{2}")
AddSliderOptionST("BreastSLIFDeltaState", "-> SLIF breast delta", BreastSLIFDelta , "{2}")

AddHeaderOption("PC enslavement options")
AddToggleOptionST("PutItemsInChestState","Put Slave items in chest", PutItemsInChest )
equipthemeOID = AddMenuOption("Enslavement Devices", ThemeList[equiptheme])
equipcolorOID = AddMenuOption("Enslavement Devices Color", ColorList[equipcolor])	

AddHeaderOption("NPC enslavement options")
AddToggleOptionST("OutfitNPCFreeState","Free NPC Outfits", OutfitNPCFree)
freenpcoutfitOID = AddMenuOption("Free women Outfit", freeNPCOutfitList[freenpcoutfit])
AddToggleOptionST("OutfitNPCSlaveState","Slave NPC Outfits", OutfitNPCSlave)
AddToggleOptionST("OutfitNPCFollowerState","Follower NPC Outfits", OutfitNPCFollower)
slavenpcoutfitOID = AddMenuOption("Slaves Outfit", SlaveNPCOutfitList[slavenpcoutfit])
npcoutfitcolorOID = AddMenuOption("Slaves Outfit Color", NPCOutfitColorList[npcoutfitcolor])
EndFunction


Function PageSlaveryStatus()
AddHeaderOption("Player status")
AddTextOption("Player name", PlayerRef.GetActorBase().GetName())
useSexlabVirginityOID  = AddToggleOption("Use Sexlab Virginity state", useSexlabVirginity)
bool playerIsAVirgin = myScripts.SLV_PlayerIsAVirgin()
;int assfuck = myScripts.SLV_GetPlayerSexSkill("Anal")
;int pussyfuck = myScripts.SLV_GetPlayerSexSkill("Vaginal")
;int blowjobs = myScripts.SLV_GetPlayerSexSkill("Oral")
;int animalfuck = myScripts.SLV_GetPlayerSexSkill("Creatures")
if playerIsAVirgin
	AddTextOption("Player is a virgin", "Yes", OPTION_FLAG_DISABLED)
else
	AddTextOption("Player is a virgin", "No", OPTION_FLAG_DISABLED)
	;AddTextOption("",  blowjobs + " blowjobs", OPTION_FLAG_DISABLED)
	;AddTextOption("",  pussyfuck + " pussy fucks", OPTION_FLAG_DISABLED)
	;AddTextOption("",  assfuck + " ass fucked", OPTION_FLAG_DISABLED)
	;AddTextOption("",  animalfuck + " fucked by creatures", OPTION_FLAG_DISABLED)
endif
	
if(PlayerRef.IsInFaction(SlaverunSlaveFaction))
	String enslavementtext = "not set"
	Float enslavementdate = StorageUtil.GetFloatValue(None, "SLV_PlayerSlaveTime", 0.0 )
	if enslavementdate != 0.0
		Float currentdate = Utility.GetCurrentGameTime()
		Float Time = currentdate - enslavementdate
		Int Std = Math.Floor(Time)
		Time = Time - Std
		Int IntTime = Math.Floor(Time*24.0)
		enslavementtext = Std + "d " + IntTime + "h"
	endif
	int rapecounter = SLV_SlaveSexCounter.getValue() as int
	AddTextOption("Is a slave for " + enslavementtext + " and been raped " + rapecounter + " times.", "", OPTION_FLAG_DISABLED)
endif

AddToggleOptionST("ShowNotificationsState","Show notifications", ShowNotifications )
AddKeyMapOptionST("MenuKey_Notification", "Key for statusnotifications", KeyForNotification)	
if(PlayerRef.IsInFaction(SlaverunSlaveFaction))
	AddTextOption("Submissive slave (0-20): ", SLV_IvanaMood.getValue() as int, OPTION_FLAG_DISABLED)
	AddTextOption("(0=rebellious - 20=well trained and submissive)", "" , OPTION_FLAG_DISABLED)
	AddTextOption("Falling in love with Bellamy (0-20): ", SLV_BrutusMood.getValue() as int , OPTION_FLAG_DISABLED)
	AddTextOption("(0=hate - 20=total in love)" , "", OPTION_FLAG_DISABLED)
elseif(PlayerRef.IsInFaction(SlaverunSlaverFaction))
	AddTextOption("Submissive slaver (0-20): ", SLV_PikeMood.getValue() as int, OPTION_FLAG_DISABLED)
	AddTextOption("(0=sadistic - 20=slutty and submissive)", "" , OPTION_FLAG_DISABLED)
else
	AddTextOption("Submissive free woman/man (0-20): ", SLV_FactionFreeSubmissive.getValue() as int, OPTION_FLAG_DISABLED)
	AddTextOption("(0=rebellious - 20=slutty and submissive)", "" , OPTION_FLAG_DISABLED)
endIf	
String playerName = StorageUtil.GetStringValue(none, "SlaverunPlayerName")
if playerName
	AddTextOption("Original Player name", playerName, OPTION_FLAG_DISABLED)
endIf
String playerHaircut = StorageUtil.GetStringValue(none, "SlaverunPlayerHair")
if playerHaircut
	AddTextOption("Original Player haircut", playerHaircut, OPTION_FLAG_DISABLED)
endIf
	
if(SLV_WhiterunTasksDone.getValue() > 0)
	int tasks = SLV_WhiterunTasksDone.getValue() as int
	AddTextOption("Whiterun Tasks done", tasks, OPTION_FLAG_DISABLED)
	String slavetitle = myScripts.SLV_GetSlaveTitle()
	if(slavetitle != "")
		AddTextOption("Working status", slavetitle, OPTION_FLAG_DISABLED)
	endif
endif
if(SLV_ArenaFightsWon.getValue() > 0)
	int fights = SLV_ArenaFightsWon.getValue() as int
	AddTextOption("Arena fights won", fights, OPTION_FLAG_DISABLED)
	String arenatitle = myScripts.SLV_GetArenaTitle()
	if(arenatitle != "")
		AddTextOption("Arena status", arenatitle, OPTION_FLAG_DISABLED)
	endif
endif
if(SLV_ColosseumShowsDone.getValue() > 0)
	int fights = SLV_ColosseumShowsDone.getValue() as int
	AddTextOption("Colosseum shows done", fights, OPTION_FLAG_DISABLED)
	;String arenatitle = myScripts.SLV_GetColosseumShowTitle()
	;if(arenatitle != "")
	;	AddTextOption("Arena status", arenatitle, OPTION_FLAG_DISABLED)
	;endif
endif
if(SLV_ColosseumFightsWon.getValue() > 0)
	int fights = SLV_ColosseumFightsWon.getValue() as int
	AddTextOption("Colosseum fights won", fights, OPTION_FLAG_DISABLED)
	;String arenatitle = myScripts.SLV_GetColosseumFightTitle()
	;if(arenatitle != "")
	;	AddTextOption("Arena status", arenatitle, OPTION_FLAG_DISABLED)
	;endif
endif

AddHeaderOption("Followers")
AddToggleOptionST("FollowerScanState","Scan for Followers", FollowerScan)
int i=0
if followersCount > 0
	While (i < followersCount)
		Actor follower = Followers[i]
		debug.trace("Follower:" + follower.GetLeveledActorBase().getName())
		if(follower.IsInFaction(SlaverunSlaveFaction))
			AddTextOption(follower.GetLeveledActorBase().getName(), "Slave" , OPTION_FLAG_DISABLED)
		else
			AddTextOption(follower.GetLeveledActorBase().getName(), "Free" , OPTION_FLAG_DISABLED)
		endif
		i = i + 1
	endWhile	
endif
	
SetCursorPosition(1)
AddHeaderOption("Enslaved Cities")
AddToggleOptionST("AutoProgressionState","Slavery autoprogression", AutoProgression )
AddSliderOptionST("CityEnslavingTimeState","Days to automatically enslave cities",CityEnslavingTime,"{0}",Option_Flag_None)
String enslavetext = "not set"
Float enslavedate = StorageUtil.GetFloatValue(None, "SLV_EnslavingHours", 0.0 )
if enslavedate != 0.0  && SlaverunQuest.getstate() < 11000
	;MiscUtil.PrintConsole("enslavedate:" + enslavedate)
	Float currentdate = Utility.GetCurrentGameTime()

	Float Time = enslavedate - currentdate
	Int Std = Math.Floor(Time)
	;MiscUtil.PrintConsole("Std:" + Std)
	Time = Time - Std
	;Time = ((Time / 5)*3)
	Int IntTime = Math.Floor(Time*24.0)
	;Time = Time + "d" + " " + Std * "h"
	;MiscUtil.PrintConsole("Time:" + Time)
	enslavetext = enslavedate - currentdate
	enslavetext = Std + "d " + IntTime + "h"
	AddTextOption("Time left until next city enslavement",enslavetext, OPTION_FLAG_DISABLED)
	;MiscUtil.PrintConsole("Currentdate:" + currentdate)
endif	

if !enforcerLocationCheck.SLV_IsWhiterunFree()
	AddTextOption("Whiterun", "Yes" , OPTION_FLAG_DISABLED)
else
	AddTextOption("Whiterun", "No" , OPTION_FLAG_DISABLED)
endif
if !enforcerLocationCheck.SLV_IsRiverwoodFree()
	AddTextOption("Riverwood", "Yes" , OPTION_FLAG_DISABLED)
else
	AddTextOption("Riverwood", "No" , OPTION_FLAG_DISABLED)
endif
if !enforcerLocationCheck.SLV_IsFalkreathFree()
	AddTextOption("Falkreath", "Yes" , OPTION_FLAG_DISABLED)
else
	AddTextOption("Falkreath", "No" , OPTION_FLAG_DISABLED)
endif
if !enforcerLocationCheck.SLV_IsDawnstarFree()
	AddTextOption("Dawnstar", "Yes" , OPTION_FLAG_DISABLED)
else
	AddTextOption("Dawnstar", "No" , OPTION_FLAG_DISABLED)
endif
if !enforcerLocationCheck.SLV_IsMarkarthFree()
	AddTextOption("Markarth", "Yes" , OPTION_FLAG_DISABLED)
else
	AddTextOption("Markarth", "No" , OPTION_FLAG_DISABLED)
endif
if !enforcerLocationCheck.SLV_IsRiftenFree()
	AddTextOption("Riften", "Yes" , OPTION_FLAG_DISABLED)
else
	AddTextOption("Riften", "No" , OPTION_FLAG_DISABLED)
endif
if !enforcerLocationCheck.SLV_IsMorthalFree()
	AddTextOption("Morthal", "Yes" , OPTION_FLAG_DISABLED)
else
	AddTextOption("Morthal", "No" , OPTION_FLAG_DISABLED)
endif
if !enforcerLocationCheck.SLV_IsWinterholdFree()
	AddTextOption("Winterhold", "Yes" , OPTION_FLAG_DISABLED)
else
	AddTextOption("Winterhold", "No" , OPTION_FLAG_DISABLED)
endif
if !enforcerLocationCheck.SLV_IsWindhelmFree()
	AddTextOption("Windhelm", "Yes" , OPTION_FLAG_DISABLED)
else
	AddTextOption("Windhelm", "No" , OPTION_FLAG_DISABLED)
endif
if !enforcerLocationCheck.SLV_IsSolitudeFree()
	AddTextOption("Solitude", "Yes" , OPTION_FLAG_DISABLED)
else
	AddTextOption("Solitude", "No" , OPTION_FLAG_DISABLED)
endif
if !enforcerLocationCheck.SLV_IsRavenRockFree()
	AddTextOption("Raven Rock", "Yes" , OPTION_FLAG_DISABLED)
else
	AddTextOption("Raven Rock", "No" , OPTION_FLAG_DISABLED)
endif
EndFunction


Function PageEnforcerSettings()
AddHeaderOption("Enforcer Common Settings")
AddToggleOptionST("IsEnforcerEnabled","Enforcer calls enabled",EnforcerEnabled )
AddSliderOptionST("MaxDistanceForSlaveSex","Max distance to call slave for sex",MaxDistanceToCallSlave,"{2}",Option_Flag_None)
AddSliderOptionST("RatioToSlaveForFree","Ratio of distance to slave for free",RatioOfSlaveDistanceForFreeWomen,"{2}",Option_Flag_None)
AddSliderOptionST("CheckNPCsInterval","Time in seconds between checks",CheckInterval,"{0}",Option_Flag_None)
AddSliderOptionST("ArousalReqdToFuckSlave","Arousal reqd. to call slave for sex",ArousalToFuckSlave,"{0}",Option_Flag_None)
AddSliderOptionST("ArousalReqdToFuckFreeFemale","Arousal reqd. to call free female for sex",ArousalToFuckFreeFemale,"{0}",Option_Flag_None)
AddSliderOptionST("EnforcerSexlabCalls","Max sex calls per enforcer run",EnforcerMaxSexlabCalls,"{0}",Option_Flag_None)
AddToggleOptionST("SkipOldPeopleState","Skip old people for enforcer", SkipOldPeople )
AddToggleOptionST("EnforcerLocationJSONState","Use JSON Location only", EnforcerLocationJSON )
AddToggleOptionST("CombatPausesEnforcerState","Fights will pause the enforcer", CombatPausesEnforcer )


SetCursorPosition(1)
AddHeaderOption("Other options")
AddToggleOptionST("WillTattleTale","Men report when player violates nudity law",TattleTales)
AddToggleOptionST("DoAsThePlayerDoes","Female followers will mimic player",FemaleFollowersMimicPlayer)
slaveGuardsForceGreetOID = AddToggleOption("Slave agents will force greet you", slaveGuardsForceGreet)	
AddSliderOptionST("SlaveGuardsCheckIntervalState","Min delay in h for forcegreet",SlaveGuardsCheckInterval,"{0}",Option_Flag_None)
slaveGuardsEquipDevicesOID = AddToggleOption("Slave agents can equip devices to bad slaves", SlaveGuardsEquipDevices)	
enforcerForceToCrawlOID = AddToggleOption("Player slave is forced to crawl", enforcerForceToCrawl)
forceToCrawlInteriorOnlyOID = AddToggleOption("Forced to crawl in indoor only", forceToCrawlInteriorOnly)
enforcerForSlaversOID = AddToggleOption("Enforcers check slavers too", enforcerForSlavers)
rapeForSlaversOID = AddToggleOption("Slavers may be raped", rapeForSlavers)
AddSliderOptionST("rapeForSlaversProbabiltyState","Probability for slaver raped",rapeForSlaversProbabilty,"{0}",Option_Flag_None)
EndFunction


Function PageEnforcerSexStrip()	
AddHeaderOption("Sex Options")
AddToggleOptionST("WillArousedMalesFuckPC","Aroused sex for player",ArousedMalesFuckPC)
enforcerSexScenesOID = AddToggleOption("Play scenes for player rape", enforcerSexScenes)
AddSliderOptionST("enforcerSexSceneProbabiltyState","Probability for playing a scene",enforcerSexSceneProbabilty,"{0}",Option_Flag_None)
AddToggleOptionST("PCGangBangState","Player will be gangbanged",PCGangbang)
AddSliderOptionST("PCGangBangProbabilityState","Probability for a gangbang",PCGangBangProbability,"{0}",Option_Flag_None)
AddToggleOptionST("WillArousedMalesFuckSlaves","Aroused males call NPC slaves for sex",ArousedMalesFuckSlaves)
AddToggleOptionST("UseAggressiveFuckForSlaves","Use aggressive sex with slaves",AggressiveFuckForSlaves)
AddToggleOptionST("UseAnalFuckForSlaves","Use anal sex with slaves",AnalFuckForSlaves)
AddToggleOptionST("WillArousedMalesFuckFreeFemales","Aroused males call free female NPCs for sex",ArousedMalesFuckFreeFemales)
AddToggleOptionST("UseAggressiveFuckForFreeFemales","Use aggressive sex with Free Females",AggressiveFuckForFreeFemales)
AddToggleOptionST("UseAnalFuckForFreeFemales","Use anal sex with Free Females",AnalFuckForFreeFemales)

SetCursorPosition(1)
AddHeaderOption("Undress npc and check body slots of PC")
AddToggleOptionST("UndressingState","Feature enabled",EnableUndressing)

AddHeaderOption("Possible body slots")
AddToggleOptionST("UndressLeftHandState","Left Hand",EnableUndressLeftHand)
AddToggleOptionST("UndressRightHandState","Right Hand",EnableUndressRightHand)

AddToggleOptionST("UndressSlot30State","Slot 30 (Helmet)",EnableUndressSlot30)
AddToggleOptionST("UndressSlot32State","Slot 32 (Body)",EnableUndressSlot32)
AddToggleOptionST("UndressSlot46State","Slot 46 (TitsOuterGarment)",EnableUndressSlot46)
AddToggleOptionST("UndressSlot49State","Slot 49 (PussyOuterGarment)",EnableUndressSlot49)
AddToggleOptionST("UndressSlot52State","Slot 52 (PussyUnderGarment)",EnableUndressSlot52)
AddToggleOptionST("UndressSlot56State","Slot 56 (TitsUnderGarment)",EnableUndressSlot56)
EndFunction


Function PageShowNudityLaw()
AddHeaderOption("Punishments for nudity law")
AddToggleOptionST("NudityCrimeState","You get a skyrim crime", NudityCrime )
AddSliderOptionST("NudityCrimeAmountState","Crime amount",NudityCrimeAmount,"{0}",Option_Flag_None)
AddToggleOptionST("NudityPunishmentState","Immediate punishment",NudityPunishment)
AddToggleOptionST("NudityRescueState","A good soul might rescue you",NudityRescue)
AddToggleOptionST("NudityEnslavementState","You are enslaved or punished",NudityEnslavement)
AddHeaderOption("Punishments for nudity law or escaped slaves")
AddSliderOptionST("WalkOfShameProbabiltyState","Probability for Walk of Shame",walkOfShameProbabilty,"{0}",Option_Flag_None)
goodSlavesAvoidWalkofShameOID = AddToggleOption("Good slaves can avoid Walk of Shame", goodSlavesAvoidWalkofShame)	
AddHeaderOption("For lazy fools like me")
AddToggleOptionST("EnforcerAutomaticStripState","Enforcer automatically strips you",EnforcerAutomaticStrip)
EndFunction


Function PageShowProblems()
AddHeaderOption("Want to skip something?")
AddToggleOptionST("SkipCreatureSexState","Skip creature sex", SkipCreatureSex )
AddToggleOptionST("SkipSexScenesState","Skip sex act",SkipSexScenes)
AddToggleOptionST("SkipScenesState","Skip scenes",SkipScenes)
AddToggleOptionST("SkipWhippingState","Skip whippings",SkipWhipping)
AddToggleOptionST("SkipBrandingState","Skip the long branding scene",SkipBranding)
AddToggleOptionST("SkipAmputeeState","Skip amputations",SkipAmputee)
AddToggleOptionST("SkipIntensiveSexlabChecksState","Skip intensive sexlab checks",SkipIntensiveSexlabChecks)

SetCursorPosition(1)
AddHeaderOption("Press label to ...")
AddTextOptionST("PlayerControlState","... enable playercontrol", "")
AddTextOptionST("StartSlaveryState","... enslave player", "")
AddTextOptionST("EndSlaveryState","... end slavery", "")
AddTextOptionST("ResetSlaveryState","... reset slavery", "")	
AddTextOptionST("SkipQuestsSlaveState","... enslave all Skyrim towns and be enslaved", "")
AddTextOptionST("SkipQuestsState","... enslave all Skyrim towns, but stay free", "")
AddTextOptionST("SetSlaveHaircutState","... set original haircut", "")	
AddTextOptionST("SetSlaveNameState","... set original name", "")	
AddTextOptionST("DoypsFashionShavingState","... use ypsfashion shaving", "")	
simpleSlaveryOID = AddTextOption("... trigger simple slavery event", "")	
resetDiamondOID = AddTextOption("... place Diamond at the gate next to Bellamy", "")
EnableIvanaOID = AddTextOption("... place Ivana at the gate next to Bellamy", "")

AddPlayerToSlaveOID = AddTextOption("... add player to slave faction", "")
RemovePlayerFromSlaveOID = AddTextOption("... remove player from slave faction", "")
AddPlayerToSlaverOID = AddTextOption("... add player to slaver faction", "")
RemovePlayerFromSlaverOID = AddTextOption("... remove player from slaver faction", "")
EndFunction



Function PageShowArena()
AddHeaderOption("Who is your opponent?")
arenaFreeOpponentChoiceOID = AddToggleOption("Choose your opponent yourself", arenaFreeOpponentChoice)
AddHeaderOption("What is your fight mode?")
arenaFreeModeChoiceOID = AddToggleOption("Choose the fight mode yourself", arenaFreeModeChoice)
AddHeaderOption("Available fight modes:")
arenaDeathRapeMatchOID = AddToggleOption("Death rape match", arenaDeathRapeMatch)
arenaDeathMatchOID = AddToggleOption("Death match", arenaDeathMatch)
arenaTrainingRapeMatchOID = AddToggleOption("Training rape match", arenaTrainingRapeMatch)
arenaTrainingMatchOID = AddToggleOption("Training match", arenaTrainingMatch)
arenaSpeedMatchOID = AddToggleOption("Speed match", arenaSpeedMatch)
AddHeaderOption("Other options:")
arenaQuickModeOID = AddToggleOption("Quick mode", arenaQuickMode)
arenaFightAloneOID = AddToggleOption("Player fights alone in the arena", arenaFightAlone)
dontDieInArenaOID = AddToggleOption("Player cannot die in the arena", dontDieInArena)
arenaBeheadingOID = AddToggleOption("If you die you may lose your head", arenaBeheading)
arenaGoreOID = AddToggleOption("Blood and gore in the arena", arenaGore)
	
AddSliderOptionST("arenaAmputationProbabiltyState","Probability for an amputation",arenaAmputationProbabilty,"{0}",Option_Flag_None)
AddSliderOptionST("arenaEnslavementProbabiltyState","Probability for being enslaved",arenaEnslavementProbabilty,"{0}",Option_Flag_None)
AddSliderOptionST("arenaRapeProbabiltyState","Probability for being raped",arenaRapeProbabilty,"{0}",Option_Flag_None)
AddSliderOptionST("arenaArmorRemoveProbabiltyState","Probability for armor remove",arenaArmorRemoveProbabilty,"{0}",Option_Flag_None)

AddHeaderOption("Human opponents")
AddHeaderOption("Rank 1 : Pit Dog")
arenaHamaOID = AddToggleOption("Hama", arenaHama)
arenaDomonkosOID = AddToggleOption("Domonkos", arenaDomonkos)
arenaBandonOID = AddToggleOption("Bandon", arenaBandon)

AddHeaderOption("Rank 2 : Brawler")
arenaHaldirOID = AddToggleOption("Haldir", arenaHaldir)
arenaCalumOID = AddToggleOption("Calum", arenaCalum)
arenaAllanonOID = AddToggleOption("Allanon", arenaAllanon)

AddHeaderOption("Rank 3 : Bloodletter")
arenaArtusOID = AddToggleOption("Artus", arenaArtus)
arenaDesmondOID = AddToggleOption("Desmond", arenaDesmond)
arenaAkiroOID = AddToggleOption("Akiro", arenaAkiro)

AddHeaderOption("Rank 4 : Myrmidon")
arenaAzogTheOrcOID = AddToggleOption("Azon the Orc", arenaAzogTheOrc)
arenaHannibalOID = AddToggleOption("Hannibal", arenaHannibal)

AddHeaderOption("Rank 5 : Warrior")
arenaMaximusOID = AddToggleOption("Maximus", arenaMaximus)
arenaDopperfieldOID = AddToggleOption("Dopperfield", arenaDopperfield)

AddHeaderOption("Rank 6 : Gladiator")
arenaDastanOID = AddToggleOption("Dastan", arenaDastan)
arenaMoudiniOID = AddToggleOption("Moudini", arenaMoudini)

AddHeaderOption("Rank 7 : Hero")
arenaCalarOID = AddToggleOption("Calar", arenaCalar)
arenaArnoOID = AddToggleOption("Arno", arenaArno)

AddHeaderOption("Rank 8 : Champion")
arenaConanOID = AddToggleOption("Conan the Babarian", arenaConan)
arenaMerlinOID = AddToggleOption("Merlin", arenaMerlin)

AddHeaderOption("Rank 9 : Grand Champion")
arenaTwoTailsOID = AddToggleOption("TwoTails", arenaTwotails)

;Right Side
SetCursorPosition(1)
AddHeaderOption("Beast opponents")
AddHeaderOption("Rank 1 : Beast Rookie")
arenaDogOID = AddToggleOption("Dog", arenaDog)
arenaChickenOID = AddToggleOption("Chicken", arenaChicken)
arenaCowOID = AddToggleOption("Cow", arenaCow)
arenaGoatOID = AddToggleOption("Goat", arenaGoat)

AddHeaderOption("Rank 2 : Kennel Slut")
arenaHorseOID = AddToggleOption("Horse", arenaHorse)
arenaSkeeverOID = AddToggleOption("Skeever", arenaSkeever)
arenaDeerOID = AddToggleOption("Deer", arenaDeer)
arenaBoarOID = AddToggleOption("Boar", arenaBoar)

AddHeaderOption("Rank 3 : Beast Slut")
arenaSpiderOID = AddToggleOption("Spider", arenaSpider)
arenaSkeletonOID = AddToggleOption("Skeleton", arenaSkeleton)
arenaDraugrOID = AddToggleOption("Draugr", arenaDraugr)
arenaFalmerOID = AddToggleOption("Falmer", arenaFalmer)
	
AddHeaderOption("Rank 4 : Beast Addicted")
arenaRieklingOID = AddToggleOption("Riekling", arenaRiekling)
arenaLargeSpiderOID = AddToggleOption("Large Spider", arenaLargeSpider)
arenaWolfOID = AddToggleOption("Wolf", arenaWolf)	
arenaChaurusOID = AddToggleOption("Chaurus", arenaChaurus)
arenaDwarvenSpiderOID = AddToggleOption("Dwarven Spider", arenaDwarvenSpider)

AddHeaderOption("Rank 5 : Beast Lover")
arenaBearOID = AddToggleOption("Bears", arenaBear)
arenaSabrecatOID = AddToggleOption("Sabrecat", arenaSabrecat)
arenaTrollOID = AddToggleOption("Troll", arenaTroll)
arenaHorkerOID = AddToggleOption("Horker", arenaHorker)
arenaNetchOID = AddToggleOption("Netch", arenaNetch)
arenaDwarvenSphereOID = AddToggleOption("Dwarven Sphere", arenaDwarvenSphere)
arenaChaurusHunterOID = AddToggleOption("Chaurus Hunter", arenaChaurusHunter)

AddHeaderOption("Rank 6 : Beast Banger")
arenaDeathhoundOID = AddToggleOption("Deathhound", arenaDeathhound)
arenaFrostAtronachOID = AddToggleOption("Frost Atronach", arenaFrostAtronach)
arenaGargoyleOID = AddToggleOption("Gargoyle", arenaGargoyle)
arenaChaurusReaperOID = AddToggleOption("Chaurus Reaper", arenaChaurusReaper)
arenaDwarvenBallistaOID = AddToggleOption("Dwarven Ballista", arenaDwarvenBallista)
arenaBoarRieklingOID = AddToggleOption("Riekling riding a boar", arenaBoarRiekling)

AddHeaderOption("Rank 7 : Beast Hero")
arenaMammothOID = AddToggleOption("Mammoth", arenaMammoth)
arenaSeekerOID = AddToggleOption("Seeker", arenaSeeker)
arenaSpiderGiantOID = AddToggleOption("Giant spider", arenaSpiderGiant)
arenaDwarvenCenturionOID = AddToggleOption("Dwarven Centurion", arenaDwarvenCenturion)

AddHeaderOption("Rank 8 : Beast Champion")
arenaDragonPriestOID = AddToggleOption("DragonPriest", arenaDragonPriest)
arenaVampireLordOID = AddToggleOption("Vampire Lord", arenaVampireLord)
arenaWerewolfOID = AddToggleOption("Werewolf", arenaWerewolf)
arenaGiantOID = AddToggleOption("Giant", arenaGiant)
arenaLurkerOID = AddToggleOption("Lurker", arenaLurker)

AddHeaderOption("Rank 9 : Beast Master")
arenaDragonOID = AddToggleOption("Dragon", arenaDragon)

AddHeaderOption("Rank 10 : Dragon Whore")
EndFunction



Function PageShowYourSlaves()
AddHeaderOption("Slave 1")
if slaveManagement.Alias_SLV_PlayerSlave1 && slaveManagement.Alias_SLV_PlayerSlave1.getActorRef()
	ShowYourSlave(slaveManagement.Alias_SLV_PlayerSlave1.getActorRef())
else
	AddTextOption("Not available", "", OPTION_FLAG_DISABLED)	
endif
AddHeaderOption("Slave 2")
if slaveManagement.Alias_SLV_PlayerSlave2 && slaveManagement.Alias_SLV_PlayerSlave2.getActorRef()
	ShowYourSlave(slaveManagement.Alias_SLV_PlayerSlave2.getActorRef())
else
	AddTextOption("Not available", "", OPTION_FLAG_DISABLED)	
endif
AddHeaderOption("Slave 3")
if slaveManagement.Alias_SLV_PlayerSlave3 && slaveManagement.Alias_SLV_PlayerSlave3.getActorRef()
	ShowYourSlave(slaveManagement.Alias_SLV_PlayerSlave3.getActorRef())
else
	AddTextOption("Not available", "", OPTION_FLAG_DISABLED)	
endif
AddHeaderOption("Slave 4")
if slaveManagement.Alias_SLV_PlayerSlave4 && slaveManagement.Alias_SLV_PlayerSlave4.getActorRef()
	ShowYourSlave(slaveManagement.Alias_SLV_PlayerSlave4.getActorRef())
else
	AddTextOption("Not available", "", OPTION_FLAG_DISABLED)	
endif
AddHeaderOption("Slave 5")
if slaveManagement.Alias_SLV_PlayerSlave5 && slaveManagement.Alias_SLV_PlayerSlave5.getActorRef()
	ShowYourSlave(slaveManagement.Alias_SLV_PlayerSlave5.getActorRef())
else
	AddTextOption("Not available", "", OPTION_FLAG_DISABLED)	
endif
	
;Right Side
SetCursorPosition(1)
AddHeaderOption("Slave 6")
if slaveManagement.Alias_SLV_PlayerSlave6 && slaveManagement.Alias_SLV_PlayerSlave6.getActorRef()
	ShowYourSlave(slaveManagement.Alias_SLV_PlayerSlave6.getActorRef())
else
	AddTextOption("Not available", "", OPTION_FLAG_DISABLED)	
endif
AddHeaderOption("Slave 7")
if slaveManagement.Alias_SLV_PlayerSlave7 && slaveManagement.Alias_SLV_PlayerSlave7.getActorRef()
	ShowYourSlave(slaveManagement.Alias_SLV_PlayerSlave7.getActorRef())
else
	AddTextOption("Not available", "", OPTION_FLAG_DISABLED)	
endif
AddHeaderOption("Slave 8")
if slaveManagement.Alias_SLV_PlayerSlave8 && slaveManagement.Alias_SLV_PlayerSlave8.getActorRef()
	ShowYourSlave(slaveManagement.Alias_SLV_PlayerSlave8.getActorRef())
else
	AddTextOption("Not available", "", OPTION_FLAG_DISABLED)	
endif
AddHeaderOption("Slave 9")
if slaveManagement.Alias_SLV_PlayerSlave9 && slaveManagement.Alias_SLV_PlayerSlave9.getActorRef()
	ShowYourSlave(slaveManagement.Alias_SLV_PlayerSlave9.getActorRef())
else
	AddTextOption("Not available", "", OPTION_FLAG_DISABLED)	
endif
EndFunction


Function ShowYourSlave(Actor slave)
AddTextOption("Name", slave.getActorBase().getName(), OPTION_FLAG_DISABLED)	
if slave.IsInFaction(SLV_SlaveBasicTraining)
	AddTextOption("Finished basic slave training", "Yes", OPTION_FLAG_DISABLED)
else
	AddTextOption("Finished basic slave training", "No", OPTION_FLAG_DISABLED)
endif
if slave.IsInFaction(SLV_SlaveAdvancedTraining)
	AddTextOption("Finished advanced slave training", "Yes", OPTION_FLAG_DISABLED)
else
	AddTextOption("Finished advanced slave training", "No", OPTION_FLAG_DISABLED)
endif
if slave.IsInFaction(SLV_SlaveBeastTraining)
	AddTextOption("Finished beast slave training", "Yes", OPTION_FLAG_DISABLED)
else
	AddTextOption("Finished beast slave training", "No", OPTION_FLAG_DISABLED)
endif
if slave.IsInFaction(SLV_SlavePainslutTraining)
	AddTextOption("Finished painslut slave training", "Yes", OPTION_FLAG_DISABLED)
else
	AddTextOption("Finished painslut slave training", "No", OPTION_FLAG_DISABLED)
endif
EndFunction


Function PageShowDevices()
AddHeaderOption("Devices for females")
AddToggleOptionST("SkipDevicesState","Skip usage of all devious devices",SkipDevices)

AddHeaderOption("Enabled device types")
equipGagOID = AddToggleOption("Gag", equipGag)
equipAnalPlugOID = AddToggleOption("Anal Plug", equipAnalPlug)
equipVagPlugOID = AddToggleOption("Vaginal Plug", equipVagPlug)
equipHarnessOID = AddToggleOption("Harness", equipHarness)
equipBeltOID = AddToggleOption("Chastity Belt", equipBelt)
equipBraOID = AddToggleOption("Chastity Bra", equipBra)
equipCollarOID = AddToggleOption("Collar", equipCollar)
equipLegCuffsOID = AddToggleOption("Leg Cuffs", equipLegCuffs)
equipArmCuffsOID = AddToggleOption("Arm Cuffs", equipArmCuffs)
equipArmbinderOID = AddToggleOption("Armbinder", equipArmbinder)
equipYokeOID = AddToggleOption("Yoke", equipYoke)
equipBlindfoldOID = AddToggleOption("Blindfold", equipBlindfold)
equipNPiercingsOID = AddToggleOption("Nipple Piercings", equipNPiercings)
equipVPiercingsOID = AddToggleOption("Vaginal Piercings", equipVPiercings)
equipBootsOID = AddToggleOption("Boots", equipBoots)
equipGlovesOID = AddToggleOption("Gloves", equipGloves)
equipCorsetOID = AddToggleOption("Corset", equipCorset)
equipMittensOID = AddToggleOption("Mittens", equipMittens)
equipHoodOID = AddToggleOption("Hood", equipHood)
equipClampsOID = AddToggleOption("Clamps", equipClamps)
equipSuitOID = AddToggleOption("Suit", equipSuit)
equipShacklesOID = AddToggleOption("Shackles", equipShackles)
equipHobblesSkirtOID = AddToggleOption("Hobbles Skirt", equipHobblesSkirt)
equipHobblesSkirtRelaxedOID = AddToggleOption("Hobbles Skirt Relaxed", equipHobblesSkirtRelaxed)
equipStraitJacketOID = AddToggleOption("Strait jacket", equipStraitJacket)

;Right Side
SetCursorPosition(1)
AddHeaderOption("Devices for males")
AddToggleOptionST("SkipDevicesForMenState","Skip usage of devious devices for men",SkipDevicesForMen)

AddHeaderOption("Enabled device types")
equipMaleGagOID = AddToggleOption("Gag", equipMaleGag)
equipMaleAnalPlugOID = AddToggleOption("Anal Plug", equipMaleAnalPlug)
;equipMaleVagPlugOID = AddToggleOption("Vaginal Plug", equipMaleVagPlug)
equipMaleHarnessOID = AddToggleOption("Harness", equipMaleHarness)
;equipMaleBeltOID = AddToggleOption("Chastity Belt", equipMaleBelt)
;equipMaleBraOID = AddToggleOption("Chastity Bra", equipMaleBra)
equipMaleCollarOID = AddToggleOption("Collar", equipMaleCollar)
equipMaleLegCuffsOID = AddToggleOption("Leg Cuffs", equipMaleLegCuffs)
equipMaleArmCuffsOID = AddToggleOption("Arm Cuffs", equipMaleArmCuffs)
equipMaleArmbinderOID = AddToggleOption("Armbinder", equipMaleArmbinder)
equipMaleYokeOID = AddToggleOption("Yoke", equipMaleYoke)
equipMaleBlindfoldOID = AddToggleOption("Blindfold", equipMaleBlindfold)
;equipMaleNPiercingsOID = AddToggleOption("Nipple Piercings", equipMaleNPiercings)
;equipMaleVPiercingsOID = AddToggleOption("Vaginal Piercings", equipMaleVPiercings)
equipMaleBootsOID = AddToggleOption("Boots", equipMaleBoots)
equipMaleGlovesOID = AddToggleOption("Gloves", equipMaleGloves)
;equipMaleCorsetOID = AddToggleOption("Corset", equipMaleCorset)
equipMaleMittensOID = AddToggleOption("Mittens", equipMaleMittens)
equipMaleHoodOID = AddToggleOption("Hood", equipMaleHood)
;equipMaleClampsOID = AddToggleOption("Clamps", equipMaleClamps)
;equipMaleSuitOID = AddToggleOption("Suit", equipMaleSuit)
equipMaleShacklesOID = AddToggleOption("Shackles", equipMaleShackles)
;equipMaleHobblesSkirtOID = AddToggleOption("Hobbles Skirt", equipMaleHobblesSkirt)
;equipMaleHobblesSkirtRelaxedOID = AddToggleOption("Hobbles Skirt Relaxed", equipMaleHobblesSkirtRelaxed)
EndFunction


Function PageShowStatistics()
AddHeaderOption("Enforcer Statistics")
ReportedAvgCheckInterval = 0
if TotalChecksPerformed != 0
	ReportedAvgCheckInterval = (TotalCheckIntervals / TotalChecksPerformed) as Int
endif	
AddTextOptionST("ActualCheckInterval","Actual average check interval","" + ReportedAvgCheckInterval,Option_Flag_Disabled)
AddTextOptionST("NPCsStripped","Number of NPCs stripped",FemaleNPCsStripped,Option_Flag_Disabled)
AddTextOptionST("SlavesCalledForSex","Number of slaves called for sex","" + SlavesCalledForSex,Option_Flag_Disabled)
AddTextOptionST("FreeCalledForSex","Number of free females called for sex","" + FreeFemalesCalledForSex,Option_Flag_Disabled)
	
;Right Side
SetCursorPosition(1)
Int TargetModIndex
AddHeaderOption("Soft Dependencies")
if Game.GetModByName("SlaveTats.esp")!= 255
	AddTextOption("Slave Tats","Found" , OPTION_FLAG_DISABLED)
else
	AddTextOption("Slave Tats","Not Found" , OPTION_FLAG_DISABLED)
endif
if  Game.GetModByName("BrandingDeviceOfDoom.esp")!= 255
	AddTextOption("Branding Device Of Doom","Found", OPTION_FLAG_DISABLED)
else
	AddTextOption("Branding Device Of Doom","Not Found", OPTION_FLAG_DISABLED)
endif
if Game.GetModByName("Simpleslavery.esp")!= 255
	AddTextOption("Simple Slavery","Found", OPTION_FLAG_DISABLED)
else
	AddTextOption("Simple Slavery","Not Found", OPTION_FLAG_DISABLED)
endif
if Game.GetModByName("hydra_slavegirls.esp") != 255
	AddTextOption("Hydragon Slavegirls","Found", OPTION_FLAG_DISABLED)
else
	AddTextOption("Hydragon Slavegirls","Not Found", OPTION_FLAG_DISABLED)
endif
AddToggleOptionST("HydragonState","Hydragon slave handling", Hydragon)
if Game.GetModByName("zdd.esp") != 255
	AddTextOption("Diablo-esque Decorations","Found", OPTION_FLAG_DISABLED)
else
	AddTextOption("Diablo-esque Decorations","Not Found", OPTION_FLAG_DISABLED)
endif
if Game.GetModByName("SerialStrip.esp") != 255
	AddTextOption("Serial Strip","Found", OPTION_FLAG_DISABLED)
else
	AddTextOption("Serial Strip","Not Found", OPTION_FLAG_DISABLED)
endif
if Game.GetModByName("MilkModNEW.esp") != 255
	AddTextOption("Milk Mod","Found", OPTION_FLAG_DISABLED)
else
	AddTextOption("Milk Mod","Not Found", OPTION_FLAG_DISABLED)
endif
if Game.GetModByName("SexLabSkoomaWhore.esp") != 255
	AddTextOption("Skooma Whore","Found", OPTION_FLAG_DISABLED)
else
	AddTextOption("Skooma Whore","Not Found", OPTION_FLAG_DISABLED)
endif
if Game.GetModByName("Deviously Cursed Loot.esp") != 255
	AddTextOption("Cursed Loot","Found", OPTION_FLAG_DISABLED)
else
	AddTextOption("Cursed Loot","Not Found", OPTION_FLAG_DISABLED)
endif
if Game.GetModByName("PSQ PlayerSuccubusQuest.esm") != 255
	AddTextOption("Player Succubus Quest","Found", OPTION_FLAG_DISABLED)
else
	AddTextOption("Player Succubus Quest","Not Found", OPTION_FLAG_DISABLED)
endif
if Game.GetModByName("Frostfall.esp") != 255
	AddTextOption("Frostfall","Found", OPTION_FLAG_DISABLED)
else
	AddTextOption("Frostfall","Not Found", OPTION_FLAG_DISABLED)
endif
if Game.GetModByName("yps-ImmersivePiercing.esp") != 255
	AddTextOption("yps-ImmersiveFashion","Found", OPTION_FLAG_DISABLED)
else
	AddTextOption("yps-ImmersiveFashion","Not Found", OPTION_FLAG_DISABLED)
endif
if Game.GetModByName("Amputator.esm") != 255
	AddTextOption("Amputator Framework","Found", OPTION_FLAG_DISABLED)
else
	AddTextOption("Amputator Framework","Not Found", OPTION_FLAG_DISABLED)
endif
if Game.GetModByName("SexLab Inflation Framework.esp") != 255
	AddTextOption("Sexlab Inflation Framework","Found", OPTION_FLAG_DISABLED)
else
	AddTextOption("Sexlab Inflation Framework","Not Found", OPTION_FLAG_DISABLED)
endif
EndFunction


Function PageMessages()
AddHeaderOption("Normal messages for player")
AddToggleOptionST("MT_UserScreen","Screen",MTUserScreen)
AddToggleOptionST("MT_UserConsole","Console",MTUserConsole)
AddToggleOptionST("MT_UserLog","Papyrus Log",MTUserLog)
AddHeaderOption("Extra messages for player")
AddToggleOptionST("MT_InformationScreen","Screen",MTInformationScreen)
AddToggleOptionST("MT_InformationConsole","Console",MTInformationConsole)
AddToggleOptionST("MT_InformationLog","Papyrus Log",MTInformationLog)

SetCursorPosition(1)
AddHeaderOption("Debug messages level 1")
AddToggleOptionST("MT_Debug1Screen","Screen",MTDebug1Screen)
AddToggleOptionST("MT_Debug1Console","Console",MTDebug1Console)
AddToggleOptionST("MT_Debug1Log","Papyrus Log",MTDebug1Log)
AddHeaderOption("Debug messages level 2")
AddToggleOptionST("MT_Debug2Screen","Screen",MTDebug2Screen)
AddToggleOptionST("MT_Debug2Console","Console",MTDebug2Console)
AddToggleOptionST("MT_Debug2Log","Papyrus Log",MTDebug2Log)
EndFunction


Function PageCheats()
addDDGag=false
addDDAnalPlug=false
addDDVagPlug=false
addDDHarness=false
addDDBelt=false
addDDBra=false
addDDCollar=false
addDDLegCuffs=false
addDDArmCuffs=false
addDDArmbinder=false
addDDYoke=false
addDDBlindfold=false
addDDNPiercings=false
addDDVPiercings=false
addDDBoots=false
addDDGloves=false
addDDCorset=false
addDDMittens=false
addDDHood=false
addDDClamps=false
addDDSuit=false
addDDShackles=false
addDDHobblesSkirt=false
addDDHobblesSkirtRelaxed=false
addDDStraitJacket=false
 
removeDDGag=false
removeDDAnalPlug=false
removeDDVagPlug=false
removeDDHarness=false
removeDDBelt=false
removeDDBra=false
removeDDCollar=false
removeDDLegCuffs=false
removeDDArmCuffs=false
removeDDArmbinder=false
removeDDYoke=false
removeDDBlindfold=false
removeDDNPiercings=false
removeDDVPiercings=false
removeDDBoots=false
removeDDGloves=false
removeDDCorset=false
removeDDMittens=false
removeDDHood=false
removeDDClamps=false
removeDDSuit=false
removeDDShackles=false
removeDDHobblesSkirt=false
removeDDHobblesSkirtRelaxed=false
removeDDStraitJacket=false

AddHeaderOption("Test/Cheat options")
AddToggleOptionST("CheatsEnabledState","Cheats enabled", CheatsEnabled )
	
if !selectedActor
	selectedActor = PlayerRef
endif
AddHeaderOption("Manipulate Devious Devices")
addDDGagOID = AddToggleOption("Gag", addDDGag)
addDDAnalPlugOID = AddToggleOption("Anal Plug", addDDAnalPlug)
addDDVagPlugOID = AddToggleOption("Vaginal Plug", addDDVagPlug)
addDDHarnessOID = AddToggleOption("Harness", addDDHarness)
addDDBeltOID = AddToggleOption("Chastity Belt", addDDBelt)
addDDBraOID = AddToggleOption("Chastity Bra", addDDBra)
addDDCollarOID = AddToggleOption("Collar", addDDCollar)
addDDLegCuffsOID = AddToggleOption("Leg Cuffs", addDDLegCuffs)
addDDArmCuffsOID = AddToggleOption("Arm Cuffs", addDDArmCuffs)
addDDArmbinderOID = AddToggleOption("Armbinder", addDDArmbinder)
addDDYokeOID = AddToggleOption("Yoke", addDDYoke)
addDDBlindfoldOID = AddToggleOption("Blindfold", addDDBlindfold)
addDDNPiercingsOID = AddToggleOption("Nipple Piercing", addDDNPiercings)
addDDVPiercingsOID = AddToggleOption("Vaginal Piercing", addDDVPiercings)
addDDBootsOID  = AddToggleOption("Boots", addDDBoots)
addDDGlovesOID = AddToggleOption("Gloves", addDDGloves)
addDDCorsetOID = AddToggleOption("Corset", addDDCorset)
addDDMittensOID = AddToggleOption("Mittens", addDDMittens)
addDDHoodOID = AddToggleOption("Hood", addDDHood)
addDDClampsOID = AddToggleOption("Nipple Clamps", addDDClamps)
addDDSuitOID = AddToggleOption("Suit", addDDSuit)
addDDShacklesOID = AddToggleOption("Shackles", addDDShackles)
addDDHobblesSkirtOID = AddToggleOption("Hobbles Skirt", addDDHobblesSkirt)
addDDHobblesSkirtRelaxedOID = AddToggleOption("Hobbles Skirt Relaxed", addDDHobblesSkirtRelaxed)
addDDStraitJacketOID = AddToggleOption("Strait jacket", addDDStraitJacket)
addDDsOID = AddTextOption("Add selected Devices", "Press here")
AddEmptyOption()
addDDChainsOID = AddTextOption("Add Chain Devices", "Press here")

AddEmptyOption()
AddHeaderOption("Player only:")
shavePCOID = AddTextOption("Shave player", "Press here")
tattooPCOID = AddTextOption("Tattoo player", "Press here")
slaveslutPCOID = AddTextOption("Full slave slut", "Press here")
bimboHairOID = AddTextOption("Bimbo Hair test", "Press here")


SetCursorPosition(1)
AddEmptyOption()
AddEmptyOption()
AddHeaderOption("For character: " + selectedActor.getActorBase().getName())
removeDDGagOID = AddToggleOption("Gag", removeDDGag)
removeDDAnalPlugOID = AddToggleOption("Anal Plug", removeDDAnalPlug)
removeDDVagPlugOID = AddToggleOption("Vaginal Plug", removeDDVagPlug)
removeDDHarnessOID = AddToggleOption("Harness", removeDDHarness)
removeDDBeltOID = AddToggleOption("Chastity Belt", removeDDBelt)
removeDDBraOID = AddToggleOption("Chastity Bra", removeDDBra)
removeDDCollarOID = AddToggleOption("Collar", removeDDCollar)
removeDDLegCuffsOID = AddToggleOption("Leg Cuffs", removeDDLegCuffs)
removeDDArmCuffsOID = AddToggleOption("Arm Cuffs", removeDDArmCuffs)
removeDDArmbinderOID = AddToggleOption("Armbinder", removeDDArmbinder)
removeDDYokeOID = AddToggleOption("Yoke", removeDDYoke)
removeDDBlindfoldOID = AddToggleOption("Blindfold", removeDDBlindfold)
removeDDNPiercingsOID = AddToggleOption("Nipple Piercing", removeDDNPiercings)
removeDDVPiercingsOID = AddToggleOption("Vaginal Piercing", removeDDVPiercings)    
removeDDBootsOID  = AddToggleOption("Boots", removeDDBoots)	
removeDDGlovesOID = AddToggleOption("Gloves", removeDDGloves)
removeDDCorsetOID = AddToggleOption("Corset", removeDDCorset)
removeDDMittensOID = AddToggleOption("Mittens", removeDDMittens)
removeDDHoodOID = AddToggleOption("Hood", removeDDHood)
removeDDClampsOID = AddToggleOption("Nipple Clamps", removeDDClamps)
removeDDSuitOID = AddToggleOption("Suit", removeDDSuit)
removeDDShacklesOID = AddToggleOption("Shackles", removeDDShackles)
removeDDHobblesSkirtOID = AddToggleOption("Hobbles Skirt", removeDDHobblesSkirt)
removeDDHobblesSkirtRelaxedOID = AddToggleOption("Hobbles Skirt Relaxed", removeDDHobblesSkirtRelaxed)
removeDDStraitJacketOID = AddToggleOption("Strait jacket", removeDDStraitJacket)
removeDDsOID = AddTextOption("Remove selected Devices", "Press here")
AddEmptyOption()
removeDDAllOID = AddTextOption("Remove all Devices", "Press here")
EndFunction


event OnOptionMenuOpen(int opt)
if (opt == equipthemeOID)
	SetMenuDialogStartIndex(equiptheme)
	SetMenuDialogDefaultIndex(0)
	SetMenuDialogOptions(ThemeList)
elseif (opt == equipcolorOID)
	SetMenuDialogStartIndex(equipcolor)
	SetMenuDialogDefaultIndex(0)
	SetMenuDialogOptions(ColorList)
elseif (opt == freenpcoutfitOID)
	SetMenuDialogStartIndex(freenpcoutfit)
	SetMenuDialogDefaultIndex(0)
	SetMenuDialogOptions(freeNPCOutfitList)
elseif (opt == slavenpcoutfitOID)
	SetMenuDialogStartIndex(slavenpcoutfit)
	SetMenuDialogDefaultIndex(0)
	SetMenuDialogOptions(SlaveNPCOutfitList)
elseif (opt == npcoutfitcolorOID)
	SetMenuDialogStartIndex(npcoutfitcolor)
	SetMenuDialogDefaultIndex(0)
	SetMenuDialogOptions(NPCOutfitColorList)
endIf
endEvent


event OnOptionMenuAccept(int opt, int index)
if (opt == equipthemeOID)
	equiptheme = index
	SetMenuOptionValue(opt, ThemeList[equiptheme])
elseif (opt == equipcolorOID)
	equipcolor = index
	SetMenuOptionValue(opt, ColorList[equipcolor])
elseif (opt == freenpcoutfitOID)
	freenpcoutfit = index
	SetMenuOptionValue(opt, freeNPCOutfitList[freenpcoutfit])
elseif (opt == slavenpcoutfitOID)
	slavenpcoutfit = index
	SetMenuOptionValue(opt, slaveNPCOutfitList[slavenpcoutfit])
elseif (opt == npcoutfitcolorOID)
	npcoutfitcolor = index
	SetMenuOptionValue(opt, NPCOutfitColorList[npcoutfitcolor])
endIf
endEvent


event OnOptionHighlight(int option)
If _importing
	SetInfoText("Importing settings")
	Return
EndIf
if (option == equipthemeOID)
	SetInfoText("Use when PC is forced in devious devices.")
elseif (option == equipcolorOID)
	SetInfoText("Use when PC is forced in devious devices.")
elseif (option == freenpcoutfitOID)
	SetInfoText("Use when a free NPC is forced in devious devices.")
elseif (option == slavenpcoutfitOID)
	SetInfoText("Use when a slave NPC is forced in devious devices.")
elseif (option == npcoutfitcolorOID)
	SetInfoText("Use when a slave NPC is forced in devious devices.")
elseif (option == sceneOID)
	SetInfoText("Enables the player controls in a hanging scene.")
elseif (option == simpleSlaveryOID)
	SetInfoText("Send the event for Simple Slavery mod.")
	
elseif (option == exportsettings1OID)
	SetInfoText("Export normal settings")
elseif (option == importsettings1OID)
	SetInfoText("Import normal settings")
elseif (option == resetsettingsOID)
	SetInfoText("Reset settings with default values")

elseif (option == exportsettings2OID)
	SetInfoText("Export soft mode settings for maximum compatibilty.")
elseif (option == importsettings2OID)
	SetInfoText("Import soft mode settings: use this to play with minimal impact and maximum compatibility.")
elseif (option == exportsettings3OID)
	SetInfoText("Export hard mode settings for your special desires.")
elseif (option == importsettings3OID)
	SetInfoText("Import hard mode settings: use for hard mode.")
	
	
elseif (option == addDDGagOID)		
	SetInfoText("Equip a gag on the selected actor")
elseif (option == removeDDGagOID)		
	SetInfoText("Remove a gag from the selected actor")
elseif (option == addDDAnalplugOID)		
	SetInfoText("Equip anal plug on the selected actor")
elseif (option == addDDVagplugOID)		
	SetInfoText("Equip vaginal plug on the selected actor")
elseif (option == removeDDAnalplugOID)		
	SetInfoText("Remove anal plug from the selected actor")
elseif (option == removeDDVagplugOID)		
	SetInfoText("Remove vaginal plug from the selected actor")
elseif (option == addDDHarnessOID)		
	SetInfoText("Equip Harness on the selected actor")
elseif (option == removeDDHarnessOID)		
	SetInfoText("Remove Harness from the selected actor")
elseif (option == addDDBeltOID)		
	SetInfoText("Equip a Belt on the selected actor")
elseif (option == removeDDBeltOID)		
	SetInfoText("Remove a Belt from the selected actor")
elseif (option == addDDBraOID)		
	SetInfoText("Equip a Bra on the selected actor")
elseif (option == removeDDBraOID)		
	SetInfoText("Remove a Bra from the selected actor")
elseif (option == addDDCollarOID)		
	SetInfoText("Equip a Collar on the selected actor")
elseif (option == removeDDCollarOID)		
	SetInfoText("Remove a Collar from the selected actor")
elseif (option == addDDLegCuffsOID)		
	SetInfoText("Equip leg Cuffs on the selected actor")
elseif (option == removeDDLegCuffsOID)		
	SetInfoText("Remove leg Cuffs from the selected actor")
elseif (option == addDDArmCuffsOID)		
	SetInfoText("Equip arm Cuffs on the selected actor")
elseif (option == removeDDArmCuffsOID)		
	SetInfoText("Remove arm Cuffs from the selected actor")
elseif (option == addDDArmbinderOID)		
	SetInfoText("Equip a Armbinder on the selected actor")
elseif (option == removeDDArmbinderOID)		
	SetInfoText("Remove a Armbinder from the selected actor")
elseif (option == addDDYokeOID)		
	SetInfoText("Equip a Yoke on the selected actor")
elseif (option == removeDDYokeOID)		
	SetInfoText("Remove a Yoke from the selected actor")
elseif (option == addDDBlindfoldOID)		
	SetInfoText("Equip a Blindfold on the selected actor")
elseif (option == removeDDBlindfoldOID)		
	SetInfoText("Remove a Blindfold from the selected actor")
elseif (option == addDDNPiercingsOID)		
	SetInfoText("Equip Nipple Piercings on the selected actor")
elseif (option == removeDDNPiercingsOID)		
	SetInfoText("Remove Nipple Piercings from the selected actor")
elseif (option == addDDVPiercingsOID)		
	SetInfoText("Equip Vagina Piercings on the selected actor")
elseif (option == removeDDVPiercingsOID)		
	SetInfoText("Remove Vagina Piercings from the selected actor")
elseif (option == addDDBootsOID)		
	SetInfoText("Equip Boots on the selected actor")
elseif (option == removeDDBootsOID)		
	SetInfoText("Remove Boots from the selected actor")
elseif (option == addDDGlovesOID)		
	SetInfoText("Equip Gloves on the selected actor")
elseif (option == removeDDGlovesOID)		
	SetInfoText("Remove Gloves on the selected actor")
elseif (option == addDDCorsetOID)		
	SetInfoText("Equip Corset on the selected actor")
elseif (option == removeDDCorsetOID)		
	SetInfoText("Remove Corset from the selected actor")
elseif (option == addDDMittensOID)		
	SetInfoText("Equip Mittens on the selected actor")
elseif (option == removeDDMittensOID)		
	SetInfoText("Remove Mittens from the selected actor")
elseif (option == addDDHoodOID)		
	SetInfoText("Equip Hood on the selected actor")
elseif (option == removeDDHoodOID)		
	SetInfoText("Remove Hood from the selected actor")
elseif (option == addDDClampsOID)		
	SetInfoText("Equip Nipple Clamps on the selected actor")
elseif (option == removeDDClampsOID)		
	SetInfoText("Remove Nipple Clamps from the selected actor")
elseif (option == addDDSuitOID)		
	SetInfoText("Equip Suit on the selected actor")
elseif (option == removeDDSuitOID)		
	SetInfoText("Remove Suit from the selected actor")
elseif (option == addDDShacklesOID)		
	SetInfoText("Equip Shackles on the selected actor")
elseif (option == removeDDShacklesOID)		
	SetInfoText("Remove Shackles from the selected actor")
elseif (option == addDDHobblesSkirtOID)		
	SetInfoText("Equip Hobbles Skirt on the selected actor")
elseif (option == removeDDHobblesSkirtOID)		
	SetInfoText("Remove Hobbles Skirt from the selected actor")
elseif (option == addDDHobblesSkirtRelaxedOID)		
	SetInfoText("Equip HobblesSkirt Relaxed on the selected actor")
elseif (option == removeDDHobblesSkirtRelaxedOID)		
	SetInfoText("Remove HobblesSkirt Relaxed from the selected actor")
elseif (option == addDDStraitJacketOID)		
	SetInfoText("Equip Strait jacket on the selected actor")
elseif (option == removeDDStraitJacketOID)		
	SetInfoText("Remove Strait jacket from the selected actor")
	
elseif (option == addDDChainsOID)		
	SetInfoText("Equip set of chain devices")
elseif (option == removeDDAllOID)		
	SetInfoText("Remove all devious devices")
elseif (option == shavePCOID)		
	SetInfoText("Shave the players hair")
elseif (option == bimboHairOID)		
	SetInfoText("Change the players hair color")
elseif (option == tattooPCOID)		
	SetInfoText("Tattoo the player with next progressive tats")
elseif (option == slaveslutPCOID)		
	SetInfoText("Make the player a fucking slave slut")
elseif (option == sosSlaverSchlongOID)		
	SetInfoText("If SOS installed male slaver NPC will get bigger dicks.")
elseif (option == useSexlabVirginityOID)		
	SetInfoText("Ask Sexlab to determine player virginity.")
elseif (option == NPCDialogOID)		
	SetInfoText("Adds general dialog options for female NPCs.")
elseif (option == resetDiamondOID)		
	SetInfoText("Puts Diamond outside the gate next to Bellamy (use very carefully, this can break quests!).")
elseif (option == enableIvanaOID)		
	SetInfoText("Puts Ivana outside the gate next to Bellamy (use very carefully, this can break quests!).")

elseif (option == addPlayerToSlaveOID)		
	SetInfoText("Adds player to slave faction (zbfFactionSlave) (use very carefully, this can break quests!).")
elseif (option == RemovePlayerFromSlaveOID)		
	SetInfoText("Remove player from slave faction (zbfFactionSlave) (use very carefully, this can break quests!).")
elseif (option == addPlayerToSlaverOID)		
	SetInfoText("Adds player to slaver faction (zbfFactionSlaver) (use very carefully, this can break quests!).")
elseif (option == RemovePlayerFromSlaverOID)		
	SetInfoText("Remove player from slaver faction (zbfFactionSlaver) (use very carefully, this can break quests!).")

elseif (option == DisableFastTravelOID)		
	SetInfoText("Enables or disable fast travel.")
elseif (option == enforcerSexScenesOID)		
	SetInfoText("If player is raped instead of a simple sexlab call a more complex scene will be used.")
elseif (option == slaveGuardsForceGreetOID)		
	SetInfoText("In all towns a slave agent will patrol and force greet you in time intervals.")
elseif (option == slaveGuardsEquipDevicesOID)		
	SetInfoText("A slave agent can equip a device if he doesn't like the answers you give to him.")
elseif (option == goodSlavesAvoidWalkofShameOID)		
	SetInfoText("A good slave with high faction with Pike can be spared the Walk of Shame, but looses faction instead.")
elseif (option == ChangeHairColorOID)		
	SetInfoText("Your Master will change your hair color when he shaves you (yps-ImmersiveFashion only).")
	
elseif (option == arenaFreeModeChoiceOID)		
	SetInfoText("If activated you can choose the fight mode, otherwise it will be random.")
elseif (option == arenaFreeOpponentChoiceOID)		
	SetInfoText("If activated you can choose your opponent, otherwise he will be random.")
elseif (option == arenaDeathMatchOID)		
	SetInfoText("The fight will end with the death of one opponent.")
elseif (option == arenaDeathRapeMatchOID)		
	SetInfoText("The fight will end with the death of one opponent and there may be rapes before and after somebody's death.")
elseif (option == arenaTrainingMatchOID)		
	SetInfoText("Nobody dies in this fight mode.")
elseif (option == arenaTrainingRapeMatchOID)		
	SetInfoText("Nobody dies in this fight mode, but the looser will be probably raped.")
elseif (option == arenaSpeedMatchOID)		
	SetInfoText("A training fight with a time limit, if you can't finish the fight in time you will be raped as punishment.")

elseif (option == arenaTwoTailsOID)		
	SetInfoText("TwoTails, a nasty Argonian fighter will be a possible opponent if you have played the quest to enable him.")
	
elseif (option == arenaHamaOID)		
	SetInfoText("Hama, a warrior will be a possible opponent if you have played the quest to enable him.")
elseif (option == arenaDomonkosOID)		
	SetInfoText("Domonkos, a rogue will be a possible opponent if you have played the quest to enable him.")
elseif (option == arenaBandonOID)		
	SetInfoText("Bandon, a mage will be a possible opponent if you have played the quest to enable him.")

elseif (option == arenaHaldirOID)		
	SetInfoText("Haldir, a warrior will be a possible opponent if you have played the quest to enable him.")
elseif (option == arenaCalumOID)		
	SetInfoText("Calum, an assasin will be a possible opponent if you have played the quest to enable him.")
elseif (option == arenaAllanonOID)		
	SetInfoText("Allanon, a mage will be a possible opponent if you have played the quest to enable him.")

elseif (option == arenaArtusOID)		
	SetInfoText("A Breton named Artus will be a possible opponent if you have played the quest to enable him.")
elseif (option == arenaDesmondOID)		
	SetInfoText("Desmond, an assasin will be a possible opponent if you have played the quest to enable him.")
elseif (option == arenaAkiroOID)		
	SetInfoText("Akiro, a nasty shaman will be a possible opponent if you have played the quest to enable him.")

elseif (option == arenaAzogTheOrcOID)		
	SetInfoText("Azog the orc will be a possible opponent if you have played the quest to enable him.")
elseif (option == arenaHannibalOID)		
	SetInfoText("Hannibal, a slave rogue will be a possible opponent if you have played the quest to enable him.")

elseif (option == arenaMaximusOID)		
	SetInfoText("Maximus, an enslaved warrior will be a possible opponent if you have played the quest to enable him.")
elseif (option == arenaDopperfieldOID)		
	SetInfoText("Dopperfield, a powerfull mage will be a possible opponent if you have played the quest to enable him.")

elseif (option == arenaDastanOID)		
	SetInfoText("Dastan, a skilled assasin will be a possible opponent if you have played the quest to enable him.")
elseif (option == arenaMoudiniOID)		
	SetInfoText("Moudini, an enslaved mage will be a possible opponent if you have played the quest to enable him.")

elseif (option == arenaCalarOID)		
	SetInfoText("Calar, a brutal warrior will be a possible opponent if you have played the quest to enable him.")
elseif (option == arenaArnoOID)		
	SetInfoText("Arno, a nasty enslaved assasin will be a possible opponent if you have played the quest to enable him.")

elseif (option == arenaConanOID)		
	SetInfoText("Conan the Barbarian will be a possible opponent if you have played the quest to enable him.")
elseif (option == arenaMerlinOID)		
	SetInfoText("Merlin, one of the most powerful mage will be a possible opponent if you have played the quest to enable him.")

elseif (option == arenaDogOID)		
	SetInfoText("Dogs will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")
elseif (option == arenaCowOID)		
	SetInfoText("Cows will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")
elseif (option == arenaChickenOID)		
	SetInfoText("Chickens will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")
elseif (option == arenaGoatOID)		
	SetInfoText("Goats will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")

;rank 2
elseif (option == arenaHorseOID)		
	SetInfoText("Horses will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")
elseif (option == arenaSkeeverOID)		
	SetInfoText("Skeever will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")
elseif (option == arenaDeerOID)		
	SetInfoText("Deers will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")
elseif (option == arenaBoarOID)		
	SetInfoText("Boars will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")

;rank 3
elseif (option == arenaSpiderOID)		
	SetInfoText("Spider will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")
elseif (option == arenaSkeletonOID)		
	SetInfoText("Skeletons will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")
elseif (option == arenaDraugrOID)		
	SetInfoText("Draugr will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")
elseif (option == arenaFalmerOID)		
	SetInfoText("Falmer will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")

;rank 4
elseif (option == arenaRieklingOID)		
	SetInfoText("Rieklings will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")
elseif (option == arenaLargeSpiderOID)		
	SetInfoText("Large Spiders will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")
elseif (option == arenaWolfOID)		
	SetInfoText("Wolfs will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")
elseif (option == arenaChaurusOID)		
	SetInfoText("Chaurus will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")
elseif (option == arenaDwarvenSpiderOID)		
	SetInfoText("Dwarven Spiders will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")
	
;rank 5
elseif (option == arenaBearOID)		
	SetInfoText("Bears will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")
elseif (option == arenaSabrecatOID)		
	SetInfoText("Sabrecats will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")
elseif (option == arenaTrollOID)		
	SetInfoText("Trolls will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")
elseif (option == arenaHorkerOID)		
	SetInfoText("Horker will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")
elseif (option == arenaNetchOID)		
	SetInfoText("Netches will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")
elseif (option == arenaDwarvenSphereOID)		
	SetInfoText("Dwarven Speres will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")
elseif (option == arenaChaurusHunterOID)		
	SetInfoText("Chaurus Hunters will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")

;rank 6
elseif (option == arenaDeathHoundOID)		
	SetInfoText("Deathhounds will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")
elseif (option == arenaFrostAtronachOID)		
	SetInfoText("Frost atronachs will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")
elseif (option == arenaGargoyleOID)		
	SetInfoText("Gargoyle will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")
elseif (option == arenaChaurusReaperOID)		
	SetInfoText("Chaurus Reapers will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")
elseif (option == arenaDwarvenBallistaOID)		
	SetInfoText("Dwarven Ballistas will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")
elseif (option == arenaBoarRieklingOID)		
	SetInfoText("Rieklings riding on a boar will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")

;rank 7
elseif (option == arenaMammothOID)		
	SetInfoText("Mammoths will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")
elseif (option == arenaSeekerOID)		
	SetInfoText("Seeker will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")
elseif (option == arenaSpiderGiantOID)		
	SetInfoText("Giant spiders will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")
elseif (option == arenaDwarvenCenturionOID)		
	SetInfoText("Dwarven Centurions will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")
	
;rank 8
elseif (option == arenaDragonPriestOID)		
	SetInfoText("Dragon Priests will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")
elseif (option == arenaVampireLordOID)		
	SetInfoText("Vampire Lords will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")
elseif (option == arenaWerewolfOID)		
	SetInfoText("Werewolfs will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")
elseif (option == arenaGiantOID)		
	SetInfoText("Giants will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")
elseif (option == arenaLurkerOID)		
	SetInfoText("Lurker will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")

elseif (option == arenaDragonOID)		
	SetInfoText("Dragons will be a possible opponent in fights or your partner in animal shows if you have played the quest to enable them.")

elseif (option == equipGagOID)		
	SetInfoText("Gags will be equiped as devious devices to females by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipAnalPlugOID)		
	SetInfoText("Anal plugs will be equiped as devious devices to females by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipVagPlugOID)		
	SetInfoText("Vaginal plugs will be equiped as devious devices to females by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipHarnessOID)		
	SetInfoText("Harness will be equiped as devious devices to females by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipBeltOID)		
	SetInfoText("Chastity belts will be equiped as devious devices to females by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipBraOID)		
	SetInfoText("Chastity bras will be equiped as devious devices to females by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipCollarOID)		
	SetInfoText("Collars will be equiped as devious devices to females by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipLegCuffsOID)		
	SetInfoText("Leg cuffs will be equiped as devious devices to females by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipArmCuffsOID)		
	SetInfoText("Arm cuffs will be equiped as devious devices to females by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipArmbinderOID)		
	SetInfoText("Armbinder will be equiped as devious devices to females by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipYokeOID)		
	SetInfoText("Yokes will be equiped as devious devices to females by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipBlindfoldOID)		
	SetInfoText("Blindfolds will be equiped as devious devices to females by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipNPiercingsOID)		
	SetInfoText("Nipple piercings will be equiped as devious devices to females by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipVPiercingsOID)		
	SetInfoText("Vaginal piercings will be equiped as devious devices to females by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipBootsOID)		
	SetInfoText("Boots will be equiped as devious devices to females by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipGlovesOID)		
	SetInfoText("Gloves will be equiped as devious devices to females by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipCorsetOID)		
	SetInfoText("Corsets will be equiped as devious devices to females by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipMittensOID)		
	SetInfoText("Mittens will be equiped as devious devices to females by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipHoodOID)		
	SetInfoText("Hoods will be equiped as devious devices to females by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipClampsOID)		
	SetInfoText("Clamps will be equiped as devious devices to females by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipSuitOID)		
	SetInfoText("Suits will be equiped as devious devices to females by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipShacklesOID)		
	SetInfoText("Shackles will be equiped as devious devices to females by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipHobblesSkirtOID)		
	SetInfoText("Hobble skirts will be equiped as devious devices to females by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipHobblesSkirtRelaxedOID)		
	SetInfoText("Hobble skirts relaxed will be equiped as devious devices to females by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipStraitJacketOID)		
	SetInfoText("Strait jackets will be equiped as devious devices to females by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")

	
elseif (option == equipMaleGagOID)		
	SetInfoText("Gags will be equiped as devious devices to males by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipMaleAnalPlugOID)		
	SetInfoText("Anal plugs will be equiped as devious devices to males by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipMaleVagPlugOID)		
	SetInfoText("Vaginal plugs will be equiped as devious devices to males by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipMaleHarnessOID)		
	SetInfoText("Harness will be equiped as devious devices to males by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipMaleBeltOID)		
	SetInfoText("Chastity belts will be equiped as devious devices to males by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipMaleBraOID)		
	SetInfoText("Chastity bras will be equiped as devious devices to males by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipMaleCollarOID)		
	SetInfoText("Collars will be equiped as devious devices to males by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipMaleLegCuffsOID)		
	SetInfoText("Leg cuffs will be equiped as devious devices to males by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipMaleArmCuffsOID)		
	SetInfoText("Arm cuffs will be equiped as devious devices to males by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipMaleArmbinderOID)		
	SetInfoText("Armbinder will be equiped as devious devices to males by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipMaleYokeOID)		
	SetInfoText("Yokes will be equiped as devious devices to males by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipMaleBlindfoldOID)		
	SetInfoText("Blindfolds will be equiped as devious devices to males by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipMaleNPiercingsOID)		
	SetInfoText("Nipple piercings will be equiped as devious devices to males by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipMaleVPiercingsOID)		
	SetInfoText("Vaginal piercings will be equiped as devious devices to males by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipMaleBootsOID)		
	SetInfoText("Boots will be equiped as devious devices to males by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipMaleGlovesOID)		
	SetInfoText("Gloves will be equiped as devious devices to males by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipMaleCorsetOID)		
	SetInfoText("Corsets will be equiped as devious devices to males by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipMaleMittensOID)		
	SetInfoText("Mittens will be equiped as devious devices to males by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipMaleHoodOID)		
	SetInfoText("Hoods will be equiped as devious devices to males by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipMaleClampsOID)		
	SetInfoText("Clamps will be equiped as devious devices to males by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipMaleSuitOID)		
	SetInfoText("Suits will be equiped as devious devices to males by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipMaleShacklesOID)		
	SetInfoText("Shackles will be equiped as devious devices to males by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipMaleHobblesSkirtOID)		
	SetInfoText("Hobble skirts will be equiped as devious devices to males by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")
elseif (option == equipMaleHobblesSkirtRelaxedOID)		
	SetInfoText("Hobble skirts relaxes will be equiped as devious devices to males by Slaverun mod if enabled in certain quests. This does NOT disable other mods from using them!")

elseif (option == submissiveAutoEnslaveOID)		
	SetInfoText("Playing a very submissive slaver or free woman will invite the slavers to enslave you.")
elseif (option == dontDieInArenaOID)		
	SetInfoText("If the player dies in the arena, he will be resurrected.")
elseif (option == arenaFightAloneOID)		
	SetInfoText("Your followers will not assist you in an arena fight.")
elseif (option == arenaBeheadingOID)		
	SetInfoText("If the player dies in the arena, he will beheaded (requires 'Player cannot die in arena' to be active to let Slaverun handle your death consequences)")
elseif (option == arenaGoreOID)		
	SetInfoText("Blood and gore will be displayed in the arena of the Colosseum")	
elseif (option == arenaQuickModeOID)		
	SetInfoText("Intro and end scenes will be much shorter!")
elseif (option == enforcerForceToCrawlOID)		
	SetInfoText("As a slave you will be forced to crawl in enslaved cities (Is active only after you have done your slave training).")
elseif (option == forceToCrawlInteriorOnlyOID)		
	SetInfoText("Forced to crawl only in indoor cells.")
elseif (option == guardForceGreetOID)		
	SetInfoText("Slaverun guards/patrol will active forcegreet you. Otherwise you have to start the conversation.")

elseif (option == slaveGuardOID)		
	SetInfoText("After your slave training a slaver will follow and guard you for some time.")
elseif (option == reportMoneyOnlyOID)		
	SetInfoText("When a slave reports back she needs to pay some money. If activated this will disable the confiscate option.")
elseif (option == reportSubmissiveCheckOID)		
	SetInfoText("When a slave reports back the slaver will do a check on the slaves attitude.")
elseif (option == reportConfiscateGoldOID)		
	SetInfoText("When a slave reports back the slaver will confiscate the money of his slave.")
elseif (option == reportConfiscateItemsOID)		
	SetInfoText("When a slave reports back the slaver will confiscate items a slave may not use (armor, clothes, weapons).")
elseif (option == reportsendSlaverPatrolOID)		
	SetInfoText("When a female player fails to report back in time a slaver enforcement patrol will go searching for her.")
elseif (option == enforcerForSlaversOID)		
	SetInfoText("Slavers have to obey the slavery laws too and will be checked by the enforcer.")
elseif (option == rapeForSlaversOID)		
	SetInfoText("A naked slaver may be tried to be raped by men too.")
	
endif
endEvent


event OnOptionSelect(int option)
if (option == sceneOID)
	Debug.notification("Player controls enabled")
	Game.EnablePlayerControls()
	game.SetPlayerAIDriven(false)
	SendModEvent("dhlp-Resume")
	SLV_StopEnforcer.setValue(0)
	SLV_EnforcerRunning.setValue(0)
	PlayerRef.setVehicle(none)
	;SlaveTats.remove_tattoos(PlayerRef, 0, true, false)
	
elseIf (option == exportsettings1OID)
	If ShowMessage("Are you sure?")
		ExportSettings(1)	
		ForcePageReset()		
	Endif
elseIf (option == importsettings1OID)
	If ShowMessage("Are you sure?")
		ImportSettings(1)		
		ForcePageReset()
	Endif	
elseIf (option == resetsettingsOID)
	If ShowMessage("Are you sure?")
		ResetSettings()		
		ForcePageReset()
	Endif	
elseIf (option == exportsettings2OID)
	If ShowMessage("Are you sure?")
		ExportSettings(2)	
		ForcePageReset()		
	Endif
elseIf (option == importsettings2OID)
	If ShowMessage("Are you sure?")
		ImportSettings(2)		
		ForcePageReset()
	Endif	
elseIf (option == exportsettings3OID)
	If ShowMessage("Are you sure?")
		ExportSettings(3)	
		ForcePageReset()		
	Endif
elseIf (option == importsettings3OID)
	If ShowMessage("Are you sure?")
		ImportSettings(3)		
		ForcePageReset()
	Endif	

	
elseif (option == sosSlaverSchlongOID)		
	SOSSlaverSchlong = !SOSSlaverSchlong
	SetToggleOptionValue(sosSlaverSchlongOID, SOSSlaverSchlong)

elseif (option == changeHairColorOID)		
	ChangeHairColor = !ChangeHairColor
	SetToggleOptionValue(changeHairColorOID, ChangeHairColor)

elseif (option == useSexlabVirginityOID)				
	useSexlabVirginity = !useSexlabVirginity
	SetToggleOptionValue(useSexlabVirginityOID, useSexlabVirginity)

elseif (option == disableFastTravelOID)				
	DisableFastTravel = !DisableFastTravel
	SetToggleOptionValue(disableFastTravelOID, DisableFastTravel)
	
	if DisableFastTravel
		Game.EnableFastTravel(false)
	else
		Game.EnableFastTravel(true)
	endif
	
elseif (option == enforcerSexScenesOID)		
	enforcerSexScenes = !enforcerSexScenes
	SetToggleOptionValue(enforcerSexScenesOID, enforcerSexScenes)

elseif (option == slaveGuardsForceGreetOID)		
	slaveGuardsForceGreet = !slaveGuardsForceGreet
	SetToggleOptionValue(slaveGuardsForceGreetOID, slaveGuardsForceGreet)
	
elseif (option == slaveGuardsEquipDevicesOID)		
	SlaveGuardsEquipDevices = !slaveGuardsEquipDevices
	SetToggleOptionValue(slaveGuardsEquipDevicesOID, slaveGuardsEquipDevices)

elseif (option == goodSlavesAvoidWalkofShameOID)		
	goodSlavesAvoidWalkofShame = !goodSlavesAvoidWalkofShame
	SetToggleOptionValue(goodSlavesAvoidWalkofShameOID, goodSlavesAvoidWalkofShame)

elseif (option == NPCDialogOID)				
	NPCDialog = !NPCDialog
	SetToggleOptionValue(NPCDialogOID, NPCDialog)
	if NPCDialog
		SLV_NPCDialog.setValue(1)
	else
		SLV_NPCDialog.setValue(0)
	endif

elseif (option == simpleSlaveryOID)
	sendModEvent("SSLV Entry")
	
elseif (option == addDDsOID)
	If _importing
		Return
	EndIf
	
	_importing = True
	SetTextOptionValue(option,"Done")
	
	;SLV_DeviousEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
	
	defaultActor()
	OnManipulateDDEvent(selectedActor, true, addDDGag, addDDAnalPlug, addDDVagPlug, addDDHarness, addDDBelt, addDDBra, addDDCollar, addDDLegCuffs, addDDArmCuffs, addDDArmbinder, addDDYoke, addDDBlindfold, addDDNPiercings, addDDVPiercings, addDDBoots, addDDGloves, addDDCorset, addDDMittens, addDDHood, addDDClamps, addDDSuit, addDDShackles, addDDHobblesSkirt, addDDHobblesSkirtRelaxed, addDDStraitJacket)

	_importing = False
	ForcePageReset()
	
elseif (option == removeDDsOID)
	If _importing
		Return
	EndIf
	
	_importing = True
	SetTextOptionValue(option,"Done")
	;SLV_DeviousUnEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
	
	defaultActor()
	
	;myScripts.SLV_DisplayInformation("mcmmenu gag: " + removeDDGag);
	;myScripts.SLV_DisplayInformation("mcmmenu collar: " + removeDDCollar);
	;myScripts.SLV_DisplayInformation("mcmmenu suit: " + removeDDSuit);

	OnManipulateDDEvent(selectedActor,false, removeDDGag, removeDDAnalPlug, removeDDVagPlug, removeDDHarness, removeDDBelt, removeDDBra, removeDDCollar, removeDDLegCuffs,removeDDArmCuffs, removeDDArmbinder, removeDDYoke, removeDDBlindfold, removeDDNPiercings, removeDDVPiercings, removeDDBoots, removeDDGloves, removeDDCorset, removeDDMittens, removeDDHood, removeDDClamps, removeDDSuit, removeDDShackles, removeDDHobblesSkirt, removeDDHobblesSkirtRelaxed, removeDDStraitJacket)

	_importing = False
	ForcePageReset()
	
elseif (option == addDDGagOID)
	addDDGag = !addDDGag
	SetToggleOptionValue(addDDGagOID, addDDGag)
	
elseif (option == removeDDGagOID)
	removeDDGag = !removeDDGag
	SetToggleOptionValue(removeDDGagOID, removeDDGag)
	
elseif (option == addDDAnalPlugOID)
	addDDAnalPlug = !addDDAnalPlug
	SetToggleOptionValue(addDDAnalPlugOID, addDDAnalPlug)
	
elseif (option == removeDDAnalPlugOID)
	removeDDAnalPlug = !removeDDAnalPlug
	SetToggleOptionValue(removeDDAnalPlugOID, removeDDAnalPlug)
	
elseif (option == addDDVagPlugOID)
	addDDVagPlug = !addDDVagPlug
	SetToggleOptionValue(addDDVagPlugOID, addDDVagPlug)
	
elseif (option == removeDDVagPlugOID)
	removeDDVagPlug = !removeDDVagPlug
	SetToggleOptionValue(removeDDVagPlugOID, removeDDVagPlug)
	
elseif (option == addDDHarnessOID)
	addDDHarness = !addDDHarness
	SetToggleOptionValue(addDDHarnessOID, addDDHarness)
	
elseif (option == removeDDHarnessOID)
	removeDDHarness = !removeDDHarness
	SetToggleOptionValue(removeDDHarnessOID, removeDDHarness)
	
elseif (option == addDDBeltOID)
	addDDBelt = !addDDBelt
	SetToggleOptionValue(addDDBeltOID, addDDBelt)
	
elseif (option == removeDDBeltOID)
	removeDDBelt = !removeDDBelt
	SetToggleOptionValue(removeDDBeltOID, removeDDBelt)
	
elseif (option == addDDBraOID)
	addDDBra = !addDDBra
	SetToggleOptionValue(addDDBraOID, addDDBra)
	
elseif (option == removeDDBraOID)
	removeDDBra = !removeDDBra
	SetToggleOptionValue(removeDDBraOID, removeDDBra)
	
elseif (option == addDDCollarOID)
	addDDCollar = !addDDCollar
	SetToggleOptionValue(addDDCollarOID, addDDCollar)
	
elseif (option == removeDDCollarOID)
	removeDDCollar = !removeDDCollar
	SetToggleOptionValue(removeDDCollarOID, removeDDCollar)
	
elseif (option == addDDLegCuffsOID)
	addDDLegCuffs = !addDDLegCuffs
	SetToggleOptionValue(addDDLegCuffsOID, addDDLegCuffs)
	
elseif (option == removeDDLegCuffsOID)
	removeDDLegCuffs = !removeDDLegCuffs
	SetToggleOptionValue(removeDDLegCuffsOID, removeDDLegCuffs)
	
elseif (option == addDDArmCuffsOID)
	addDDArmCuffs = !addDDArmCuffs
	SetToggleOptionValue(addDDArmCuffsOID, addDDArmCuffs)
	
elseif (option == removeDDArmCuffsOID)
	removeDDArmCuffs = !removeDDArmCuffs
	SetToggleOptionValue(removeDDArmCuffsOID, removeDDArmCuffs)
	
elseif (option == addDDArmbinderOID)
	addDDArmbinder = !addDDArmbinder
	SetToggleOptionValue(addDDArmbinderOID, addDDArmbinder)
	
elseif (option == removeDDArmbinderOID)
	removeDDArmbinder = !removeDDArmbinder
	SetToggleOptionValue(removeDDArmbinderOID, removeDDArmbinder)
	
elseif (option == addDDYokeOID)
	addDDYoke = !addDDYoke
	SetToggleOptionValue(addDDYokeOID, addDDYoke)
	
elseif (option == removeDDYokeOID)
	removeDDYoke = !removeDDYoke
	SetToggleOptionValue(removeDDYokeOID, removeDDYoke)
	
elseif (option == addDDBlindfoldOID)
	addDDBlindfold = !addDDBlindfold
	SetToggleOptionValue(addDDBlindfoldOID, addDDBlindfold)
	
elseif (option == removeDDBlindfoldOID)
	removeDDBlindfold = !removeDDBlindfold
	SetToggleOptionValue(removeDDBlindfoldOID, removeDDBlindfold)
	
elseif (option == addDDNPiercingsOID)
	addDDNPiercings = !addDDNPiercings
	SetToggleOptionValue(addDDNPiercingsOID, addDDNPiercings)
	
elseif (option == removeDDNPiercingsOID)
	removeDDNPiercings = !removeDDNPiercings
	SetToggleOptionValue(removeDDNPiercingsOID, removeDDNPiercings)
	
elseif (option == addDDVPiercingsOID)
	addDDVPiercings = !addDDVPiercings
	SetToggleOptionValue(addDDVPiercingsOID, addDDVPiercings)
	
elseif (option == removeDDVPiercingsOID)
	removeDDVPiercings = !removeDDVPiercings
	SetToggleOptionValue(removeDDVPiercingsOID, removeDDVPiercings)
	
elseif (option == addDDBootsOID)
	addDDBoots = !addDDBoots
	SetToggleOptionValue(addDDBootsOID, addDDBoots)
	
elseif (option == removeDDBootsOID)
	removeDDBoots = !removeDDBoots
	SetToggleOptionValue(removeDDBootsOID, removeDDBoots)
	
elseif (option == addDDGlovesOID)
	addDDGloves = !addDDGloves
	SetToggleOptionValue(addDDGlovesOID, addDDGloves)
	
elseif (option == removeDDGlovesOID)
	removeDDGloves = !removeDDGloves
	SetToggleOptionValue(removeDDGlovesOID, removeDDGloves)
	
elseif (option == addDDCorsetOID)
	addDDCorset = !addDDCorset
	SetToggleOptionValue(addDDCorsetOID, addDDCorset)
	
elseif (option == removeDDCorsetOID)
	removeDDCorset = !removeDDCorset
	SetToggleOptionValue(removeDDCorsetOID, removeDDCorset)
	
elseif (option == addDDMittensOID)
	addDDMittens = !addDDMittens
	SetToggleOptionValue(addDDMittensOID, addDDMittens)
	
elseif (option == removeDDMittensOID)
	removeDDMittens = !removeDDMittens
	SetToggleOptionValue(removeDDMittensOID, removeDDMittens)
	
elseif (option == addDDHoodOID)
	addDDHood = !addDDHood
	SetToggleOptionValue(addDDHoodOID, addDDHood)
	
elseif (option == removeDDHoodOID)
	removeDDHood = !removeDDHood
	SetToggleOptionValue(removeDDHoodOID, removeDDHood)
	
elseif (option == addDDClampsOID)
	addDDClamps = !addDDClamps
	SetToggleOptionValue(addDDClampsOID, addDDClamps)
	
elseif (option == removeDDClampsOID)
	removeDDClamps = !removeDDClamps
	SetToggleOptionValue(removeDDClampsOID, removeDDClamps)
	
elseif (option == addDDSuitOID)
	addDDSuit = !addDDSuit
	SetToggleOptionValue(addDDSuitOID, addDDSuit)
	
elseif (option == removeDDSuitOID)
	removeDDSuit = !removeDDSuit
	SetToggleOptionValue(removeDDSuitOID, removeDDSuit)
	
elseif (option == addDDShacklesOID)
	addDDShackles = !addDDShackles
	SetToggleOptionValue(addDDShacklesOID, addDDShackles)
	
elseif (option == removeDDShacklesOID)
	removeDDShackles = !removeDDShackles
	SetToggleOptionValue(removeDDShacklesOID, removeDDShackles)
	
elseif (option == addDDHobblesSkirtOID)
	addDDHobblesSkirt = !addDDHobblesSkirt
	SetToggleOptionValue(addDDHobblesSkirtOID, addDDHobblesSkirt)
	
elseif (option == removeDDHobblesSkirtOID)
	removeDDHobblesSkirt = !removeDDHobblesSkirt
	SetToggleOptionValue(removeDDHobblesSkirtOID, removeDDHobblesSkirt)
	
elseif (option == addDDHobblesSkirtRelaxedOID)	
	addDDHobblesSkirtRelaxed = !addDDHobblesSkirtRelaxed
	SetToggleOptionValue(addDDHobblesSkirtRelaxedOID, addDDHobblesSkirtRelaxed)
	
elseif (option == removeDDHobblesSkirtRelaxedOID)		
	removeDDHobblesSkirtRelaxed = !removeDDHobblesSkirtRelaxed
	SetToggleOptionValue(removeDDHobblesSkirtRelaxedOID, removeDDHobblesSkirtRelaxed)
	
elseif (option == addDDStraitJacketOID)	
	addDDStraitJacket = !addDDStraitJacket
	SetToggleOptionValue(addDDStraitJacketOID, addDDStraitJacket)
	
elseif (option == removeDDStraitJacketOID)		
	removeDDStraitJacket = !removeDDStraitJacket
	SetToggleOptionValue(removeDDStraitJacketOID, removeDDStraitJacket)
	
elseif (option == addDDChainsOID)		
	SetTextOptionValue(option,"Done")
	defaultActor()
	myScripts.SLV_equipDDChains(selectedActor)

	_importing = False
	ForcePageReset()
	
elseif (option == removeDDAllOID)		
	SetTextOptionValue(option,"Done")
	;SLV_DeviousUnEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
	
	defaultActor()
	myScripts.SLV_DeviousUnEquipActor2(selectedActor,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true)

	_importing = False
	ForcePageReset()

elseif (option == bimboHairOID)		
	SendModEvent("yps-HairColorBaseEvent", "Bleached Blonde" , 0x00DCD0BA)
	SendModEvent("yps-HairColorDyeEvent", "Bleached Blonde" , 0x00DCD0BA)
	ForcePageReset()

elseif (option == resetDiamondOID)		
	If ShowMessage("Are you sure?")
		myScripts.SLV_EnableDiamond()
		ForcePageReset()
	endif
	
elseif (option == enableIvanaOID)		
	If ShowMessage("Are you sure?")
		myScripts.SLV_enableValentina()
		ForcePageReset()
	endif
	
elseif (option == addPlayerToSlaveOID)
	If ShowMessage("Are you sure?")
		PlayerRef.addToFaction(SlaverunSlaveFaction)
		ForcePageReset()
	endif
elseif (option == removePlayerFromSlaveOID)
	If ShowMessage("Are you sure?")
		PlayerRef.removeFromFaction(SlaverunSlaveFaction)
		ForcePageReset()
	endif
elseif (option == addPlayerToSlaverOID)
	If ShowMessage("Are you sure?")
		myScripts.SLV_FreePlayer()
		ForcePageReset()
	endif
elseif (option == removePlayerFromSlaverOID)
	If ShowMessage("Are you sure?")
		PlayerRef.removeFromFaction(SlaverunSlaverFaction)
		ForcePageReset()
	endif

elseif (option == addDDChainsOID)		
	SetTextOptionValue(option,"Done")
	defaultActor()
	myScripts.SLV_equipDDChains(selectedActor)
elseif (option == shavePCOID)		
	;If _importing
	;    Return
	;EndIf
	
	;_importing = True
	SetTextOptionValue(option,"Done")
	
	shaveScripts.Shave(PlayerRef)

	_importing = False
	ForcePageReset()		
	
elseif (option == tattooPCOID)		
	;If _importing
	;    Return
	;EndIf
	
	;_importing = True
	SetTextOptionValue(option,"Done")
	
	Actor player = PlayerRef
	SlaveTats.simple_remove_tattoo(player , "Slutmarks", "Cunt (right cheek)", silent = true)
	SlaveTats.simple_remove_tattoo(player , "Slave Marks", "Slave (left cheek)", silent = true)
	SlaveTats.simple_remove_tattoo(player , "Slave Marks", "Slave (forehead)", silent = true)
	SlaveTats.simple_remove_tattoo(player , "Slave Marks", "Slave (left hand)", silent = true)
	SlaveTats.simple_remove_tattoo(player , "Slave Marks", "Slave (right hand)", silent = true)

	SlaveTats.simple_add_tattoo(player , "Slutmarks", "Cunt (right cheek)", silent = true)
	SlaveTats.simple_add_tattoo(player , "Slave Marks", "Slave (left cheek)", silent = true)
	SlaveTats.simple_add_tattoo(player , "Slave Marks", "Slave (forehead)", silent = true)
	SlaveTats.simple_add_tattoo(player , "Slave Marks", "Slave (left hand)", silent = true)
	SlaveTats.simple_add_tattoo(player , "Slave Marks", "Slave (right hand)", silent = true)
	StorageUtil.SetIntValue(none, "SlaverunTatooLevel", 19)
	
	shaveScripts.RefreshProgressiveSlaveTats(player )

	_importing = False
	ForcePageReset()	
	
elseif (option == slaveslutPCOID)		
	;If _importing
	;    Return
	;EndIf
	
	;_importing = True
	SetTextOptionValue(option,"Done")
	
	myScripts.SLV_makePlayeraFuckingSlaveSlut()		

	_importing = False
	ForcePageReset()	
	
	
elseif (option == arenaFreeModeChoiceOID)		
	arenaFreeModeChoice = !arenaFreeModeChoice
	SetToggleOptionValue(arenaFreeModeChoiceOID, arenaFreeModeChoice)
	if arenaFreeModeChoice
		SLV_ColosseumRandomFightMode.setvalue(0)
	else
		SLV_ColosseumRandomFightMode.setvalue(1)
	endif
	
	
elseif (option == arenaFreeOpponentChoiceOID)		
	arenaFreeOpponentChoice = !arenaFreeOpponentChoice
	SetToggleOptionValue(arenaFreeOpponentChoiceOID, arenaFreeOpponentChoice)
	
	myScripts.SLV_DisplayInformation("arenaFreeOpponentChoice: " + arenaFreeOpponentChoice);

	if arenaFreeOpponentChoice
		SLV_ColosseumRandomBeast.setvalue(0)
		SLV_ColosseumRandomGladiator.setvalue(0)
	else
		SLV_ColosseumRandomBeast.setvalue(1)
		SLV_ColosseumRandomGladiator.setvalue(1)
	endif
	myScripts.SLV_DisplayInformation("SLV_ColosseumRandomBeast: " + SLV_ColosseumRandomBeast.getvalue());
	
elseif (option == arenaDeathMatchOID)		
	arenaDeathMatch = !arenaDeathMatch
	SetToggleOptionValue(arenaDeathMatchOID, arenaDeathMatch)
elseif (option == arenaDeathRapeMatchOID)		
	arenaDeathRapeMatch = !arenaDeathRapeMatch
	SetToggleOptionValue(arenaDeathRapeMatchOID, arenaDeathRapeMatch)
elseif (option == arenaTrainingMatchOID)		
	arenaTrainingMatch = !arenaTrainingMatch
	SetToggleOptionValue(arenaTrainingMatchOID, arenaTrainingMatch)
elseif (option == arenaTrainingRapeMatchOID)		
	arenaTrainingRapeMatch = !arenaTrainingRapeMatch
	SetToggleOptionValue(arenaTrainingRapeMatchOID, arenaTrainingRapeMatch)
elseif (option == arenaSpeedMatchOID)		
	arenaSpeedMatch = !arenaSpeedMatch
	SetToggleOptionValue(arenaSpeedMatchOID, arenaSpeedMatch)
	
; rank 1
elseif (option == arenaHamaOID)		
	arenaHama = !arenaHama
	SetToggleOptionValue(arenaHamaOID, arenaHama)
elseif (option == arenaDomonkosOID)		
	arenaDomonkos = !arenaDomonkos
	SetToggleOptionValue(arenaDomonkosOID, arenaDomonkos)
elseif (option == arenaBandonOID)		
	arenaBandon = !arenaBandon
	SetToggleOptionValue(arenaBandonOID, arenaBandon)

; rank 2
elseif (option == arenaHaldirOID)		
	arenaHaldir = !arenaHaldir
	SetToggleOptionValue(arenaHaldirOID, arenaHaldir)
elseif (option == arenaCalumOID)		
	arenaCalum = !arenaCalum
	SetToggleOptionValue(arenaCalumOID, arenaCalum)
elseif (option == arenaAllanonOID)		
	arenaAllanon = !arenaAllanon
	SetToggleOptionValue(arenaAllanonOID, arenaAllanon)

; rank 3
elseif (option == arenaArtusOID)		
	arenaArtus = !arenaArtus
	SetToggleOptionValue(arenaArtusOID, arenaArtus)
elseif (option == arenaDesmondOID)		
	arenaDesmond = !arenaDesmond
	SetToggleOptionValue(arenaDesmondOID, arenaDesmond)
elseif (option == arenaAkiroOID)		
	arenaAkiro = !arenaAkiro
	SetToggleOptionValue(arenaAkiroOID, arenaAkiro)

; rank 4
elseif (option == arenaAzogTheOrcOID)		
	arenaAzogTheOrc = !arenaAzogTheOrc
	SetToggleOptionValue(arenaAzogTheOrcOID, arenaAzogTheOrc)
elseif (option == arenaHannibalOID)		
	arenaHannibal = !arenaHannibal
	SetToggleOptionValue(arenaHannibalOID, arenaHannibal)

; rank 5
elseif (option == arenaMaximusOID)		
	arenaMaximus = !arenaMaximus
	SetToggleOptionValue(arenaMaximusOID, arenaMaximus)
elseif (option == arenaDopperfieldOID)		
	arenaDopperfield = !arenaDopperfield
	SetToggleOptionValue(arenaDopperfieldOID, arenaDopperfield)

; rank 6
elseif (option == arenaDastanOID)		
	arenaDastan = !arenaDastan
	SetToggleOptionValue(arenaDastanOID, arenaDastan)
elseif (option == arenaMoudiniOID)		
	arenaMoudini = !arenaMoudini
	SetToggleOptionValue(arenaMoudiniOID, arenaMoudini)

; rank 7
elseif (option == arenaCalarOID)		
	arenaCalar = !arenaCalar
	SetToggleOptionValue(arenaCalarOID, arenaCalar)
elseif (option == arenaArnoOID)		
	arenaArno = !arenaArno
	SetToggleOptionValue(arenaArnoOID, arenaArno)

; rank 8
elseif (option == arenaConanOID)		
	arenaConan = !arenaConan
	SetToggleOptionValue(arenaConanOID, arenaConan)
elseif (option == arenaMerlinOID)		
	arenaMerlin = !arenaMerlin
	SetToggleOptionValue(arenaMerlinOID, arenaMerlin)
	
; rank 9
elseif (option == arenaTwotailsOID)		
	arenaTwotails = !arenaTwotails
	SetToggleOptionValue(arenaTwotailsOID, arenaTwotails)

; rank 1
elseif (option == arenaDogOID)		
	arenaDog = !arenaDog
	SetToggleOptionValue(arenaDogOID, arenaDog)
elseif (option == arenaCowOID)		
	arenaCow = !arenaCow
	SetToggleOptionValue(arenaCowOID, arenaCow)
elseif (option == arenaChickenOID)		
	arenaChicken = !arenaChicken
	SetToggleOptionValue(arenaChickenOID, arenaChicken)
elseif (option == arenaGoatOID)		
	arenaGoat = !arenaGoat
	SetToggleOptionValue(arenaGoatOID, arenaGoat)

;rank 2
elseif (option == arenaHorseOID)		
	arenaHorse = !arenaHorse
	SetToggleOptionValue(arenaHorseOID, arenaHorse)
elseif (option == arenaSkeeverOID)		
	arenaSkeever = !arenaSkeever
	SetToggleOptionValue(arenaSkeeverOID, arenaSkeever)
elseif (option == arenaDeerOID)		
	arenaDeer = !arenaDeer
	SetToggleOptionValue(arenaDeerOID, arenaDeer)
elseif (option == arenaBoarOID)		
	arenaBoar = !arenaBoar
	SetToggleOptionValue(arenaBoarOID, arenaBoar)

;rank 3
elseif (option == arenaSpiderOID)		
	arenaSpider = !arenaSpider
	SetToggleOptionValue(arenaSpiderOID, arenaSpider)
elseif (option == arenaSkeletonOID)		
	arenaSkeleton = !arenaSkeleton
	SetToggleOptionValue(arenaSkeletonOID, arenaSkeleton)
elseif (option == arenaDraugrOID)		
	arenaDraugr = !arenaDraugr
	SetToggleOptionValue(arenaDraugrOID, arenaDraugr)
elseif (option == arenaFalmerOID)		
	arenaFalmer = !arenaFalmer
	SetToggleOptionValue(arenaFalmerOID, arenaFalmer)
	
;rank 4
elseif (option == arenaRieklingOID)		
	arenaRiekling = !arenaRiekling
	SetToggleOptionValue(arenaRieklingOID, arenaRiekling)
elseif (option == arenaLargeSpiderOID)		
	arenaLargeSpider = !arenaLargeSpider
	SetToggleOptionValue(arenaLargeSpiderOID, arenaLargeSpider)
elseif (option == arenaWolfOID)		
	arenaWolf = !arenaWolf
	SetToggleOptionValue(arenaWolfOID, arenaWolf)
elseif (option == arenaChaurusOID)		
	arenaChaurus = !arenaChaurus
	SetToggleOptionValue(arenaChaurusOID, arenaChaurus)
elseif (option == arenaDwarvenSpiderOID)		
	arenaDwarvenSpider = !arenaDwarvenSpider
	SetToggleOptionValue(arenaDwarvenSpiderOID, arenaDwarvenSpider)

;rank 5	
elseif (option == arenaBearOID)		
	arenaBear = !arenaBear
	SetToggleOptionValue(arenaBearOID, arenaBear)
elseif (option == arenaSabrecatOID)		
	arenaSabrecat = !arenaSabrecat
	SetToggleOptionValue(arenaSabrecatOID, arenaSabrecat)
elseif (option == arenaTrollOID)		
	arenaTroll = !arenaTroll
	SetToggleOptionValue(arenaTrollOID, arenaTroll)
elseif (option == arenaHorkerOID)		
	arenaHorker = !arenaHorker
	SetToggleOptionValue(arenaHorkerOID, arenaHorker)
elseif (option == arenaNetchOID)		
	arenaNetch = !arenaNetch
	SetToggleOptionValue(arenaNetchOID, arenaNetch)
elseif (option == arenaDwarvenSphereOID)		
	arenaDwarvenSphere = !arenaDwarvenSphere
	SetToggleOptionValue(arenaDwarvenSphereOID, arenaDwarvenSphere)
elseif (option == arenaChaurusHunterOID)		
	arenaChaurusHunter = !arenaChaurusHunter
	SetToggleOptionValue(arenaChaurusHunterOID, arenaChaurusHunter)

;rank 6	
elseif (option == arenaDeathHoundOID)		
	arenaDeathHound = !arenaDeathHound
	SetToggleOptionValue(arenaDeathHoundOID, arenaDeathHound)
elseif (option == arenaFrostAtronachOID)		
	arenaFrostAtronach = !arenaFrostAtronach
	SetToggleOptionValue(arenaFrostAtronachOID, arenaFrostAtronach)
elseif (option == arenaGargoyleOID)		
	arenaGargoyle = !arenaGargoyle
	SetToggleOptionValue(arenaGargoyleOID, arenaGargoyle)
elseif (option == arenaChaurusReaperOID)		
	arenaChaurusReaper = !arenaChaurusReaper
	SetToggleOptionValue(arenaChaurusReaperOID, arenaChaurusReaper)
elseif (option == arenaDwarvenBallistaOID)		
	arenaDwarvenBallista = !arenaDwarvenBallista
	SetToggleOptionValue(arenaDwarvenBallistaOID, arenaDwarvenBallista)
elseif (option == arenaBoarRieklingOID)		
	arenaBoarRiekling = !arenaBoarRiekling
	SetToggleOptionValue(arenaBoarRieklingOID, arenaBoarRiekling)

;rank 7	
elseif (option == arenaMammothOID)		
	arenaMammoth = !arenaMammoth
	SetToggleOptionValue(arenaMammothOID, arenaMammoth)
elseif (option == arenaSeekerOID)		
	arenaSeeker = !arenaSeeker
	SetToggleOptionValue(arenaSeekerOID, arenaSeeker)
elseif (option == arenaSpiderGiantOID)		
	arenaSpiderGiant = !arenaSpiderGiant
	SetToggleOptionValue(arenaSpiderGiantOID, arenaSpiderGiant)
elseif (option == arenaDwarvenCenturionOID)		
	arenaDwarvenCenturion = !arenaDwarvenCenturion
	SetToggleOptionValue(arenaDwarvenCenturionOID, arenaDwarvenCenturion)

;rank 8	
elseif (option == arenaDragonPriestOID)		
	arenaDragonPriest = !arenaDragonPriest
	SetToggleOptionValue(arenaDragonPriestOID, arenaDragonPriest)
elseif (option == arenaVampireLordOID)		
	arenaVampireLord = !arenaVampireLord
	SetToggleOptionValue(arenaVampireLordOID, arenaVampireLord)
elseif (option == arenaWerewolfOID)		
	arenaWerewolf = !arenaWerewolf
	SetToggleOptionValue(arenaWerewolfOID, arenaWerewolf)
elseif (option == arenaGiantOID)		
	arenaGiant = !arenaGiant
	SetToggleOptionValue(arenaGiantOID, arenaGiant)
elseif (option == arenaLurkerOID)		
	arenaLurker = !arenaLurker
	SetToggleOptionValue(arenaLurkerOID, arenaLurker)

;rank 9	
elseif (option == arenaDragonOID)		
	arenaDragon = !arenaDragon
	SetToggleOptionValue(arenaDragonOID, arenaDragon)

elseif (option == equipGagOID)		
	equipGag = !equipGag
	SetToggleOptionValue(equipGagOID, equipGag)
elseif (option == equipAnalPlugOID)		
	equipAnalPlug = !equipAnalPlug
	SetToggleOptionValue(equipAnalPlugOID, equipAnalPlug)
elseif (option == equipVagPlugOID)		
	equipVagPlug = !equipVagPlug
	SetToggleOptionValue(equipVagPlugOID, equipVagPlug)
elseif (option == equipHarnessOID)		
	equipHarness = !equipHarness
	SetToggleOptionValue(equipHarnessOID, equipHarness)
elseif (option == equipBeltOID)		
	equipBelt = !equipBelt
	SetToggleOptionValue(equipBeltOID, equipBelt)
elseif (option == equipBraOID)		
	equipBra = !equipBra
	SetToggleOptionValue(equipBraOID, equipBra)
elseif (option == equipCollarOID)		
	equipCollar = !equipCollar
	SetToggleOptionValue(equipCollarOID, equipCollar)
elseif (option == equipLegCuffsOID)		
	equipLegCuffs = !equipLegCuffs
	SetToggleOptionValue(equipLegCuffsOID, equipLegCuffs)
elseif (option == equipArmCuffsOID)		
	equipArmCuffs = !equipArmCuffs
	SetToggleOptionValue(equipArmCuffsOID, equipArmCuffs)
elseif (option == equipArmbinderOID)		
	equipArmbinder = !equipArmbinder
	SetToggleOptionValue(equipArmbinderOID, equipArmbinder)
elseif (option == equipYokeOID)		
	equipYoke = !equipYoke
	SetToggleOptionValue(equipYokeOID, equipYoke)
elseif (option == equipBlindfoldOID)		
	equipBlindfold = !equipBlindfold
	SetToggleOptionValue(equipBlindfoldOID, equipBlindfold)
elseif (option == equipNPiercingsOID)		
	equipNPiercings = !equipNPiercings
	SetToggleOptionValue(equipNPiercingsOID, equipNPiercings)
elseif (option == equipVPiercingsOID)		
	equipVPiercings = !equipVPiercings
	SetToggleOptionValue(equipVPiercingsOID, equipVPiercings)
elseif (option == equipBootsOID)		
	equipBoots = !equipBoots
	SetToggleOptionValue(equipBootsOID, equipBoots)
elseif (option == equipGlovesOID)		
	equipGloves = !equipGloves
	SetToggleOptionValue(equipGlovesOID, equipGloves)
elseif (option == equipCorsetOID)		
	equipCorset = !equipCorset
	SetToggleOptionValue(equipCorsetOID, equipCorset)
elseif (option == equipMittensOID)		
	equipMittens = !equipMittens
	SetToggleOptionValue(equipMittensOID, equipMittens)
elseif (option == equipHoodOID)		
	equipHood = !equipHood
	SetToggleOptionValue(equipHoodOID, equipHood)
elseif (option == equipClampsOID)		
	equipClamps = !equipClamps
	SetToggleOptionValue(equipClampsOID, equipClamps)
elseif (option == equipSuitOID)		
	equipSuit = !equipSuit
	SetToggleOptionValue(equipSuitOID, equipSuit)
elseif (option == equipShacklesOID)		
	equipShackles = !equipShackles
	SetToggleOptionValue(equipShacklesOID, equipShackles)
elseif (option == equipHobblesSkirtOID)		
	equipHobblesSkirt = !equipHobblesSkirt
	SetToggleOptionValue(equipHobblesSkirtOID, equipHobblesSkirt)
elseif (option == equipHobblesSkirtRelaxedOID)		
	equipHobblesSkirtRelaxed = !equipHobblesSkirtRelaxed
	SetToggleOptionValue(equipHobblesSkirtRelaxedOID, equipHobblesSkirtRelaxed)
elseif (option == equipStraitJacketOID)		
	equipStraitJacket = !equipStraitJacket
	SetToggleOptionValue(equipStraitJacketOID, equipStraitJacket)

	
elseif (option == equipMaleGagOID)		
	equipMaleGag = !equipMaleGag
	SetToggleOptionValue(equipMaleGagOID, equipMaleGag)
elseif (option == equipMaleAnalPlugOID)		
	equipMaleAnalPlug = !equipMaleAnalPlug
	SetToggleOptionValue(equipMaleAnalPlugOID, equipMaleAnalPlug)
elseif (option == equipMaleVagPlugOID)		
	equipMaleVagPlug = !equipMaleVagPlug
	SetToggleOptionValue(equipMaleVagPlugOID, equipMaleVagPlug)
elseif (option == equipMaleHarnessOID)		
	equipMaleHarness = !equipMaleHarness
	SetToggleOptionValue(equipMaleHarnessOID, equipMaleHarness)
elseif (option == equipMaleBeltOID)		
	equipMaleBelt = !equipMaleBelt
	SetToggleOptionValue(equipMaleBeltOID, equipMaleBelt)
elseif (option == equipMaleBraOID)		
	equipMaleBra = !equipMaleBra
	SetToggleOptionValue(equipMaleBraOID, equipMaleBra)
elseif (option == equipMaleCollarOID)		
	equipMaleCollar = !equipMaleCollar
	SetToggleOptionValue(equipMaleCollarOID, equipMaleCollar)
elseif (option == equipMaleLegCuffsOID)		
	equipMaleLegCuffs = !equipMaleLegCuffs
	SetToggleOptionValue(equipMaleLegCuffsOID, equipMaleLegCuffs)
elseif (option == equipMaleArmCuffsOID)		
	equipMaleArmCuffs = !equipMaleArmCuffs
	SetToggleOptionValue(equipMaleArmCuffsOID, equipMaleArmCuffs)
elseif (option == equipMaleArmbinderOID)		
	equipMaleArmbinder = !equipMaleArmbinder
	SetToggleOptionValue(equipMaleArmbinderOID, equipMaleArmbinder)
elseif (option == equipMaleYokeOID)		
	equipMaleYoke = !equipMaleYoke
	SetToggleOptionValue(equipMaleYokeOID, equipMaleYoke)
elseif (option == equipMaleBlindfoldOID)		
	equipMaleBlindfold = !equipMaleBlindfold
	SetToggleOptionValue(equipMaleBlindfoldOID, equipMaleBlindfold)
elseif (option == equipMaleNPiercingsOID)		
	equipMaleNPiercings = !equipMaleNPiercings
	SetToggleOptionValue(equipMaleNPiercingsOID, equipMaleNPiercings)
elseif (option == equipMaleVPiercingsOID)		
	equipMaleVPiercings = !equipMaleVPiercings
	SetToggleOptionValue(equipMaleVPiercingsOID, equipMaleVPiercings)
elseif (option == equipMaleBootsOID)		
	equipMaleBoots = !equipMaleBoots
	SetToggleOptionValue(equipMaleBootsOID, equipMaleBoots)
elseif (option == equipMaleGlovesOID)		
	equipMaleGloves = !equipMaleGloves
	SetToggleOptionValue(equipMaleGlovesOID, equipMaleGloves)
elseif (option == equipMaleCorsetOID)		
	equipMaleCorset = !equipMaleCorset
	SetToggleOptionValue(equipMaleCorsetOID, equipMaleCorset)
elseif (option == equipMaleMittensOID)		
	equipMaleMittens = !equipMaleMittens
	SetToggleOptionValue(equipMaleMittensOID, equipMaleMittens)
elseif (option == equipMaleHoodOID)		
	equipMaleHood = !equipMaleHood
	SetToggleOptionValue(equipMaleHoodOID, equipMaleHood)
elseif (option == equipMaleClampsOID)		
	equipMaleClamps = !equipMaleClamps
	SetToggleOptionValue(equipMaleClampsOID, equipMaleClamps)
elseif (option == equipMaleSuitOID)		
	equipMaleSuit = !equipMaleSuit
	SetToggleOptionValue(equipMaleSuitOID, equipMaleSuit)
elseif (option == equipMaleShacklesOID)		
	equipMaleShackles = !equipMaleShackles
	SetToggleOptionValue(equipMaleShacklesOID, equipMaleShackles)
elseif (option == equipMaleHobblesSkirtOID)		
	equipMaleHobblesSkirt = !equipMaleHobblesSkirt
	SetToggleOptionValue(equipMaleHobblesSkirtOID, equipMaleHobblesSkirt)
elseif (option == equipMaleHobblesSkirtRelaxedOID)		
	equipMaleHobblesSkirtRelaxed = !equipMaleHobblesSkirtRelaxed
	SetToggleOptionValue(equipMaleHobblesSkirtRelaxedOID, equipMaleHobblesSkirtRelaxed)
	
elseif (option == submissiveAutoEnslaveOID)		
	submissiveAutoEnslave = !submissiveAutoEnslave
	SetToggleOptionValue(submissiveAutoEnslaveOID, submissiveAutoEnslave)
	
	if submissiveAutoEnslave
		SLV_AutomaticEnslavement.setValue(1)
	else
		SLV_AutomaticEnslavement.setValue(0)
	endif		
elseif (option == dontDieInArenaOID)		
	dontDieInArena = !dontDieInArena
	SetToggleOptionValue(dontDieInArenaOID, dontDieInArena)
elseif (option == arenaFightAloneOID)		
	arenaFightAlone = !arenaFightAlone
	SetToggleOptionValue(arenaFightAloneOID, arenaFightAlone)
elseif (option == arenaBeheadingOID)		
	arenaBeheading = !arenaBeheading
	SetToggleOptionValue(arenaBeheadingOID, arenaBeheading)
elseif (option == arenaGoreOID)		
	arenaGore = !arenaGore
	SetToggleOptionValue(arenaGoreOID, arenaGore)
	
elseif (option == arenaQuickModeOID)		
	arenaQuickMode = !arenaQuickMode
	SetToggleOptionValue(arenaQuickModeOID, arenaQuickMode)
	
	if arenaQuickMode
		SLV_ColosseumQuickMode.setValue(1)
	else
		SLV_ColosseumQuickMode.setValue(0)
	endif	
elseif (option == enforcerForceToCrawlOID)		
	enforcerForceToCrawl = !enforcerForceToCrawl
	SetToggleOptionValue(enforcerForceToCrawlOID, enforcerForceToCrawl)
elseif (option == forceToCrawlInteriorOnlyOID)		
	forceToCrawlInteriorOnly = !forceToCrawlInteriorOnly
	SetToggleOptionValue(forceToCrawlInteriorOnlyOID, forceToCrawlInteriorOnly)
	
elseif (option == guardForceGreetOID)		
	guardForceGreet = !guardForceGreet
	SetToggleOptionValue(guardForceGreetOID, guardForceGreet)
	
	if guardForceGreet
		SLV_GuardNoForceGreet.setValue(0)
	else
		SLV_GuardNoForceGreet.setValue(1)
	endif
	
elseif (option == slaveGuardOID)		
	slaveGuard = !slaveGuard
	SetToggleOptionValue(slaveGuardOID, slaveGuard)
	if slaveGuard
		SLV_FinnEnabled.setValue(1)
	else
		SLV_FinnEnabled.setValue(0)
	endif
elseif (option == reportMoneyOnlyOID)		
	reportMoneyOnly = !reportMoneyOnly
	SetToggleOptionValue(reportMoneyOnlyOID, reportMoneyOnly)
	if reportMoneyOnly == true
		reportConfiscateGold = false
		reportConfiscateItems = false
	endif
	softDependency.reportMoneyOnly = reportMoneyOnly
	softDependency.reportConfiscateItems = reportConfiscateItems
	softDependency.reportConfiscateGold = reportConfiscateGold
elseif (option == reportSubmissiveCheckOID)		
	reportSubmissiveCheck = !reportSubmissiveCheck
	SetToggleOptionValue(reportSubmissiveCheckOID, reportSubmissiveCheck)
	softDependency.reportSubmissiveCheck = reportSubmissiveCheck
elseif (option == reportConfiscateGoldOID)		
	reportConfiscateGold = !reportConfiscateGold
	SetToggleOptionValue(reportConfiscateGoldOID, reportConfiscateGold)
	softDependency.reportConfiscateGold = reportConfiscateGold
	if reportConfiscateGold == true
		reportMoneyOnly = false
	endif
	softDependency.reportMoneyOnly = reportMoneyOnly
elseif (option == reportConfiscateItemsOID)		
	reportConfiscateItems = !reportConfiscateItems
	SetToggleOptionValue(reportConfiscateItemsOID, reportConfiscateItems)
	if reportConfiscateItems == true
		reportMoneyOnly = false
	endif
	softDependency.reportMoneyOnly = reportMoneyOnly
	softDependency.reportConfiscateItems = reportConfiscateItems
elseif (option == reportsendSlaverPatrolOID)		
	reportsendSlaverPatrol = !reportsendSlaverPatrol
	SetToggleOptionValue(reportsendSlaverPatrolOID, reportsendSlaverPatrol)
elseif (option == enforcerForSlaversOID)		
	enforcerForSlavers = !enforcerForSlavers
	SetToggleOptionValue(enforcerForSlaversOID, enforcerForSlavers)
	softDependency.enforcerForSlavers = enforcerForSlavers
elseif (option == rapeForSlaversOID)		
	rapeForSlavers = !rapeForSlavers
	SetToggleOptionValue(rapeForSlaversOID, rapeForSlavers)	
	
endIf
endEvent		


Bool Function OnManipulateDDEvent(Actor NPCActor,bool equip, bool equipGagParam,bool equipAnalPlugParam,bool equipVagPlugParam,bool equipHarnessParam,bool equipBeltParam,bool equipBraParam,bool equipCollarParam,bool equipLegCuffsParam,bool equipArmCuffsParam,bool equipArmbinderParam,bool equipYokeParam,bool equipBlindfoldParam,bool equipNPiercingsParam,bool equipVPiercingsParam,bool equipBootsParam,bool equipGlovesParam,bool equipCorsetParam,bool equipMittensParam=true, bool equipHoodParam=true, bool equipClampsParam=true, bool equipSuitParam=true, bool equipShacklesParam=true, bool equipHobblesSkirtParam=true, bool equipHobblesSkirtRelaxedParam=true, bool equipStraitJacketParam=true)

Int Handle = ModEvent.Create("SlaverunReloaded_ManipulateDD")

If (Handle)
	ModEvent.PushForm(Handle, Self)
	ModEvent.PushForm(Handle, NPCActor)
	ModEvent.PushBool(Handle, equip)
	ModEvent.PushBool(Handle, equipGagParam)
	ModEvent.PushBool(Handle, equipAnalPlugParam)
	ModEvent.PushBool(Handle, equipVagPlugParam)
	ModEvent.PushBool(Handle, equipHarnessParam)
	ModEvent.PushBool(Handle, equipBeltParam)
	ModEvent.PushBool(Handle, equipBraParam)
	ModEvent.PushBool(Handle, equipCollarParam)
	ModEvent.PushBool(Handle, equipLegCuffsParam)
	ModEvent.PushBool(Handle, equipArmCuffsParam)
	ModEvent.PushBool(Handle, equipArmbinderParam)
	ModEvent.PushBool(Handle, equipYokeParam)
	ModEvent.PushBool(Handle, equipBlindfoldParam)
	ModEvent.PushBool(Handle, equipNPiercingsParam)
	ModEvent.PushBool(Handle, equipVPiercingsParam)
	ModEvent.PushBool(Handle, equipBootsParam)
	ModEvent.PushBool(Handle, equipGlovesParam)
	ModEvent.PushBool(Handle, equipCorsetParam)
	ModEvent.PushBool(Handle, equipMittensParam)
	ModEvent.PushBool(Handle, equipHoodParam)
	ModEvent.PushBool(Handle, equipClampsParam)
	ModEvent.PushBool(Handle, equipSuitParam)
	ModEvent.PushBool(Handle, equipShacklesParam)
	ModEvent.PushBool(Handle, equipHobblesSkirtParam)
	ModEvent.PushBool(Handle, equipHobblesSkirtRelaxedParam)
	ModEvent.PushBool(Handle, equipStraitJacketParam)
	ModEvent.Send(Handle)
	Return True
Else
	Return False
EndIf
EndFunction


Function defaultActor()
if !selectedActor || selectedActor == None
	selectedActor = PlayerRef
endif
endFunction



;------------- State functions, these are called when a value is selected, changed or highlighted (moused over)
;------------- 		There will be one "state" for each MCM setting and three events
State rapeForSlaversProbabiltyState
	Event OnSliderOpenST()
        SetSliderDialogStartValue(rapeForSlaversProbabilty as Float)
        SetSliderDialogDefaultValue(20.0)
        SetSliderDialogRange(0.0, 100.0)
        SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		rapeForSlaversProbabilty = value as Int
		SetSliderOptionValueSt(rapeForSlaversProbabilty as Float,"{0}")
	EndEvent
	Event OnDefaultST()
		rapeForSlaversProbabilty = 20
		SetSliderOptionValueSt(rapeForSlaversProbabilty as Float,"{0}")
	EndEvent
	Event OnHighlightST()
		SetInfoText("Probability that you can't resist the attempt of a man to rape you as a naked slaver.")
	EndEvent
EndState



State ReportingMoneyState
	Event OnSliderOpenST()
        SetSliderDialogStartValue(ReportingMoney)
        SetSliderDialogDefaultValue(1000.0)
        SetSliderDialogRange(0.0, 5000.0)
        SetSliderDialogInterval(100.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		ReportingMoney= value as int
		SetSliderOptionValueSt(ReportingMoney,"{0}")
		
		SLV_ReportingGold.setvalue(ReportingMoney)
	EndEvent
	Event OnDefaultST()
		ReportingMoney=1000
		SLV_ReportingGold.setvalue(ReportingMoney)
		SetSliderOptionValueSt(ReportingMoney as Float,"{0}")
	EndEvent
	Event OnHighlightST()
		SetInfoText("This is the amount of gold you have to pay when reporting back.")
	EndEvent
EndState

State reportConfiscateGoldLeftState
	Event OnSliderOpenST()
        SetSliderDialogStartValue(reportConfiscateGoldLeft)
        SetSliderDialogDefaultValue(100.0)
        SetSliderDialogRange(0.0, 1000.0)
        SetSliderDialogInterval(100.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		reportConfiscateGoldLeft= value as int
		SetSliderOptionValueSt(reportConfiscateGoldLeft,"{0}")
	EndEvent
	Event OnDefaultST()
		reportConfiscateGoldLeft=100
		SetSliderOptionValueSt(reportConfiscateGoldLeft as Float,"{0}")
	EndEvent
	Event OnHighlightST()
		SetInfoText("This is the amount of gold you can keep when your slaver confiscates your gold.")
	EndEvent
EndState


State arenaAmputationProbabiltyState
	Event OnSliderOpenST()
        SetSliderDialogStartValue(arenaAmputationProbabilty as Float)
        SetSliderDialogDefaultValue(5.0)
        SetSliderDialogRange(0.0, 100.0)
        SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		arenaAmputationProbabilty = value as Int
		SetSliderOptionValueSt(arenaAmputationProbabilty as Float,"{0}")
	EndEvent
	Event OnDefaultST()
		arenaAmputationProbabilty = 5
		SetSliderOptionValueSt(arenaAmputationProbabilty as Float,"{0}")
	EndEvent
	Event OnHighlightST()
		SetInfoText("Probability the player looses a limb by amputation in a fight (requires Amputation Framework) (Set to 0 to disable).")
	EndEvent
EndState

State arenaEnslavementProbabiltyState
	Event OnSliderOpenST()
        SetSliderDialogStartValue(arenaEnslavementProbabilty as Float)
        SetSliderDialogDefaultValue(30.0)
        SetSliderDialogRange(0.0, 100.0)
        SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		arenaEnslavementProbabilty = value as Int
		SetSliderOptionValueSt(arenaEnslavementProbabilty as Float,"{0}")
	EndEvent
	Event OnDefaultST()
		arenaEnslavementProbabilty = 30
		SetSliderOptionValueSt(arenaEnslavementProbabilty as Float,"{0}")
	EndEvent
	Event OnHighlightST()
		SetInfoText("Probability that a female player (who isn't a slave) will be enslaved after loosing an arena fight (Set to 0 to disable).")
	EndEvent
EndState

State arenaRapeProbabiltyState
	Event OnSliderOpenST()
        SetSliderDialogStartValue(arenaRapeProbabilty as Float)
        SetSliderDialogDefaultValue(10.0)
        SetSliderDialogRange(0.0, 100.0)
        SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		arenaRapeProbabilty = value as Int
		SetSliderOptionValueSt(arenaRapeProbabilty as Float,"{0}")
	EndEvent
	Event OnDefaultST()
		arenaRapeProbabilty = 10
		SetSliderOptionValueSt(arenaRapeProbabilty as Float,"{0}")
	EndEvent
	Event OnHighlightST()
		SetInfoText("Probability that the player will be raped during an arena fight (only if arena mode enables this) (Set to 0 to disable).")
	EndEvent
EndState

State arenaArmorRemoveProbabiltyState
	Event OnSliderOpenST()
        SetSliderDialogStartValue(arenaArmorRemoveProbabilty as Float)
        SetSliderDialogDefaultValue(20.0)
        SetSliderDialogRange(0.0, 100.0)
        SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		arenaArmorRemoveProbabilty = value as Int
		SetSliderOptionValueSt(arenaArmorRemoveProbabilty as Float,"{0}")
	EndEvent
	Event OnDefaultST()
		arenaArmorRemoveProbabilty = 20
		SetSliderOptionValueSt(arenaArmorRemoveProbabilty as Float,"{0}")
	EndEvent
	Event OnHighlightST()
		SetInfoText("Probability that your opponent will try to tear away your armor/weapon during a fight (Set to 0 to disable).")
	EndEvent
EndState





State QuestStartAtLevelState
	Event OnSliderOpenST()
        SetSliderDialogStartValue( QuestStartAtLevel)
        SetSliderDialogDefaultValue(2.0)
        SetSliderDialogRange(1.0, 20.0)
        SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		QuestStartAtLevel= value as int
		SetSliderOptionValueSt( QuestStartAtLevel,"{0}")
		SLV_LevelForPrequest.setvalue(QuestStartAtLevel)
	EndEvent
	Event OnDefaultST()
		QuestStartAtLevel=2
		SetSliderOptionValueSt( QuestStartAtLevel as Float,"{0}")
		SLV_LevelForPrequest.setvalue(QuestStartAtLevel)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Slaverun quest will start when player has reached this level.")
	EndEvent
EndState


State NoCarriageTravelState
	event OnSelectST()
		NoCarriageTravel= !NoCarriageTravel
		SetToggleOptionValueST(NoCarriageTravel)
		if NoCarriageTravel
			SLV_CarriageDisabled.setvalue(1)
		else
			SLV_CarriageDisabled.setvalue(0)
		endif
	endEvent
	event OnDefaultST()
		NoCarriageTravel=true
		SLV_CarriageDisabled.setvalue(1)
	endEvent
	event OnHighlightST()
		SetInfoText("Slaves are not allowed to use normal carriage travels until the driver is convinced by a quest.")
	endEvent
EndState

State BreastGrowingState
	event OnSelectST()
		BreastGrowing= !BreastGrowing
		SetToggleOptionValueST(BreastGrowing)
		if BreastGrowing
			SLV_WeightGain.setvalue(1)
		else
			SLV_WeightGain.setvalue(0)
		endif		
	endEvent
	event OnDefaultST()
		BreastGrowing=true
		SLV_WeightGain.setvalue(1)
	endEvent
	event OnHighlightST()
		SetInfoText("During slavery your breasts will grow. When Slaverun starts you will be referenced as slave with small boobs. Don't activete if you don't want this!")
	endEvent
EndState

State BreastWeightGrowingState
	event OnSelectST()
		BreastWeightGrowing= !BreastWeightGrowing
		SetToggleOptionValueST(BreastWeightGrowing)
	endEvent
	event OnDefaultST()
		BreastWeightGrowing=true
	endEvent
	event OnHighlightST()
		SetInfoText("Breasts will grow be increasing the player weight (probably bodyslide required).")
	endEvent
EndState

State BreastSLIFGrowingState
	event OnSelectST()
		BreastSLIFGrowing= !BreastSLIFGrowing
		SetToggleOptionValueST(BreastSLIFGrowing)
	endEvent
	event OnDefaultST()
		BreastSLIFGrowing=true
	endEvent
	event OnHighlightST()
		SetInfoText("Breast will grow be using Sexlab Inflation Framework (if installed).")
	endEvent
EndState

State BreastSLIFSizeState
	Event OnSliderOpenST()
        SetSliderDialogStartValue(BreastSLIFSize)
        SetSliderDialogDefaultValue(1.0)
        SetSliderDialogRange(0.0, 10.0)
        SetSliderDialogInterval(0.05)
	EndEvent
	Event OnSliderAcceptST(float value)
		BreastSLIFSize = value
		SetSliderOptionValueSt( BreastSLIFSize,"{2}")
		
		myScripts.SLV_InflationFramework(PlayerRef, BreastSLIFSize)
	EndEvent
	Event OnDefaultST()
		BreastSLIFSize=1.0
		SetSliderOptionValueSt( BreastSLIFSize,"{2}")
		
		myScripts.SLV_InflationFramework(PlayerRef, BreastSLIFSize)
	EndEvent
	Event OnHighlightST()
		SetInfoText("The current breast size which will be send to Sexlab Inflation Framework.")
	EndEvent
EndState


State BreastSLIFDeltaState
	Event OnSliderOpenST()
        SetSliderDialogStartValue(BreastSLIFDelta)
        SetSliderDialogDefaultValue(0.1)
        SetSliderDialogRange(0.0, 1.0)
        SetSliderDialogInterval(0.05)
	EndEvent
	Event OnSliderAcceptST(float value)
		BreastSLIFDelta = value
		SetSliderOptionValueSt( BreastSLIFDelta,"{2}")
	EndEvent
	Event OnDefaultST()
		BreastSLIFDelta=0.1
		SetSliderOptionValueSt( BreastSLIFDelta,"{2}")
	EndEvent
	Event OnHighlightST()
		SetInfoText("The delta value which the breast will be increased.")
	EndEvent
EndState

State ShowNotificationsState
	event OnSelectST()
		ShowNotifications= !ShowNotifications
		SetToggleOptionValueST(ShowNotifications)
	endEvent
	event OnDefaultST()
		ShowNotifications=true
	endEvent
	event OnHighlightST()
		SetInfoText("Show status notifications with the key below.")
	endEvent
EndState


State MenuKey_Notification
	Event OnKeyMapChangeST(Int newKeyCode, String conflictControl, String conflictName)
		KeyForNotification = newKeyCode
		SetKeyMapOptionValueST(KeyForNotification)
	EndEvent
	
	Event OnDefaultST()
		KeyForNotification = 49
		SetKeyMapOptionValueST(49)
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("")
	EndEvent
EndState


State maxTasksState
	Event OnSliderOpenST()
        SetSliderDialogStartValue(maxTasks)
        SetSliderDialogDefaultValue(3.0)
        SetSliderDialogRange(1.0, 20.0)
        SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		maxTasks= value as int
		SetSliderOptionValueSt( maxTasks,"{0}")
		SLV_MaxTask.setvalue(maxTasks)
		if !SlaverunQuest.UpdateCurrentInstanceGlobal(SLV_MaxTask)
		  	Debug.notification("Failed to update SLV_MaxTask for quest")
		endif
	EndEvent
	Event OnDefaultST()
		maxTasks=3
		SetSliderOptionValueSt( maxTasks as Float,"{0}")
		SLV_MaxTask.setvalue(maxTasks)
		if !SlaverunQuest.UpdateCurrentInstanceGlobal(SLV_MaxTask)
		  	Debug.notification("Failed to update SLV_MaxTask for quest")
		endif
	EndEvent
	Event OnHighlightST()
		SetInfoText("How many repetitions are necessary to complete a simple task.")
	EndEvent
EndState


State StoryModeState
	event OnSelectST()
		StoryMode= !StoryMode
		SetToggleOptionValueST(StoryMode)
		
		if StoryMode
			SLV_StoryMode.setValue(1)
		else
			SLV_StoryMode.setValue(0)
		endif
	endEvent
	event OnDefaultST()
		StoryMode= true
		SLV_StoryMode.setValue(1)
	endEvent
	event OnHighlightST()
		SetInfoText("Enable this to play in story mode (more text to read).")
	endEvent
EndState


State SkipAmputeeState
	event OnSelectST()
		SkipAmputee= !SkipAmputee
		SetToggleOptionValueST(SkipAmputee)
	endEvent
	event OnDefaultST()
		SkipAmputee= false
	endEvent
	event OnHighlightST()
		SetInfoText("Enable this to skip amputations.")
	endEvent
EndState


State ypsFashionShavingState
	event OnSelectST()
		ypsFashionShaving= !ypsFashionShaving
		SetToggleOptionValueST(ypsFashionShaving)
	endEvent
	event OnDefaultST()
		ypsFashionShaving= false
	endEvent
	event OnHighlightST()
		SetInfoText("Use yps-ImmersiveFashion for hairshaving.")
	endEvent
EndState


State walkOfShameProbabiltyState
	Event OnSliderOpenST()
        SetSliderDialogStartValue(walkOfShameProbabilty as Float)
        SetSliderDialogDefaultValue(20.0)
        SetSliderDialogRange(0.0, 100.0)
        SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		walkOfShameProbabilty = value as Int
		SetSliderOptionValueSt(walkOfShameProbabilty as Float,"{0}")
	EndEvent
	Event OnDefaultST()
		walkOfShameProbabilty = 20
		SetSliderOptionValueSt(walkOfShameProbabilty as Float,"{0}")
	EndEvent
	Event OnHighlightST()
		SetInfoText("Probability that you will be punished by another Walk of Shame (will only happen after your painslut training) (Set to 0 to disable).")
	EndEvent
EndState


State travelSexProbabiltyState
	Event OnSliderOpenST()
        SetSliderDialogStartValue(travelSexProbabilty as Float)
        SetSliderDialogDefaultValue(20.0)
        SetSliderDialogRange(0.0, 100.0)
        SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		travelSexProbabilty = value as Int
		SetSliderOptionValueSt(travelSexProbabilty as Float,"{0}")
	EndEvent
	Event OnDefaultST()
		travelSexProbabilty = 20
		SetSliderOptionValueSt(travelSexProbabilty as Float,"{0}")
	EndEvent
	Event OnHighlightST()
		SetInfoText("Probability that traveling with the carriage as a slave will have a lot of hardcore sex. Otherwise the stop will be much shorter.")
	EndEvent
EndState


State enforcerSexSceneProbabiltyState
	Event OnSliderOpenST()
        SetSliderDialogStartValue(enforcerSexSceneProbabilty as Float)
        SetSliderDialogDefaultValue(20.0)
        SetSliderDialogRange(0.0, 100.0)
        SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		enforcerSexSceneProbabilty = value as Int
		SetSliderOptionValueSt(enforcerSexSceneProbabilty as Float,"{0}")
	EndEvent
	Event OnDefaultST()
		enforcerSexSceneProbabilty = 20
		SetSliderOptionValueSt(enforcerSexSceneProbabilty as Float,"{0}")
	EndEvent
	Event OnHighlightST()
		SetInfoText("Probability the enforcer will play a scene if the player is raped. Otherwise a direct Sexlab function call will be made. (Set to 0 to disable scenes).")
	EndEvent
EndState


State PCGangBangProbabilityState
	Event OnSliderOpenST()
        SetSliderDialogStartValue(PCGangBangProbability as Float)
        SetSliderDialogDefaultValue(25.0)
        SetSliderDialogRange(0.0, 100.0)
        SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		PCGangBangProbability = value as Int
		SetSliderOptionValueSt(PCGangBangProbability as Float,"{0}")
	EndEvent
	Event OnDefaultST()
		PCGangBangProbability = 25
		SetSliderOptionValueSt(PCGangBangProbability as Float,"{0}")
	EndEvent
	Event OnHighlightST()
		SetInfoText("Probability the enforcer will let the player be gangbanged (Set to 0 to disable).")
	EndEvent
EndState

State SlaveGuardsCheckIntervalState
	Event OnSliderOpenST()
        SetSliderDialogStartValue(SlaveGuardsCheckInterval as Float)
        SetSliderDialogDefaultValue(24.0)
        SetSliderDialogRange(0.0, 168.0)
        SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		SlaveGuardsCheckInterval = value as Int
		SetSliderOptionValueSt(SlaveGuardsCheckInterval as Float,"{0}")
	EndEvent
	Event OnDefaultST()
		SlaveGuardsCheckInterval = 24
		SetSliderOptionValueSt(SlaveGuardsCheckInterval as Float,"{0}")
	EndEvent
	Event OnHighlightST()
		SetInfoText("Minimum time in hours after a slave guard will force greet you again.")
	EndEvent
EndState


State PCGangBangState
	event OnSelectST()
		PCGangbang = !PCGangbang
		SetToggleOptionValueST(PCGangbang)
	endEvent
	event OnDefaultST()
		PCGangbang = true
	endEvent
	event OnHighlightST()
		SetInfoText("Player will be gangbanged after she is certified as a gangbang slut.")
	endEvent
EndState



State AutoProgressionState
	event OnSelectST()
		AutoProgression = !AutoProgression
		SetToggleOptionValueST(AutoProgression)
	endEvent
	event OnDefaultST()
		AutoProgression = true
	endEvent
	event OnHighlightST()
		SetInfoText("For free women slavery will automatically progress.")
	endEvent
EndState


State CheatsEnabledState
	event OnSelectST()
		CheatsEnabled = !CheatsEnabled
		SetToggleOptionValueST(CheatsEnabled)
		if CheatsEnabled
			softDependency.testmode = true
		endIf
		myScripts.SLV_CheatMode()
	endEvent
	event OnDefaultST()
		CheatsEnabled = false
		myScripts.SLV_CheatMode()
	endEvent
	event OnHighlightST()
		SetInfoText("Enabled cheats will make additional dialogue options appear to skip quest parts")
	endEvent
EndState
SLV_SoftDependency Property softDependency auto

State CombatPausesEnforcerState
	event OnSelectST()
		CombatPausesEnforcer = !CombatPausesEnforcer
		SetToggleOptionValueST(CombatPausesEnforcer)
	endEvent
	event OnDefaultST()
		CombatPausesEnforcer = true
	endEvent
	event OnHighlightST()
		SetInfoText("Enforcer will be paused if the PC goes in combat stance to fight (Dragon or Vampire Attacks)")
	endEvent
EndState

State EnforcerLocationJSONState
	event OnSelectST()
		EnforcerLocationJSON = !EnforcerLocationJSON
		SetToggleOptionValueST(EnforcerLocationJSON)
	endEvent
	event OnDefaultST()
		EnforcerLocationJSON = false
	endEvent
	event OnHighlightST()
		SetInfoText("Enforcer location check will only use JSON, if false enforcer will use JSON AND scripted locs")
	endEvent
EndState

State OutfitNPCFreeState
	event OnSelectST()
		OutfitNPCFree = !OutfitNPCFree
		SetToggleOptionValueST(OutfitNPCFree)
	endEvent
	event OnDefaultST()
		OutfitNPCFree = true
	endEvent
	event OnHighlightST()
		SetInfoText("Free NPC will get an outfit when stripped by enforcer")
	endEvent
EndState

State OutfitNPCSlaveState
	event OnSelectST()
		OutfitNPCSlave = !OutfitNPCSlave
		SetToggleOptionValueST(OutfitNPCSlave)
	endEvent
	event OnDefaultST()
		OutfitNPCFree = true
	endEvent
	event OnHighlightST()
		SetInfoText("Slave NPC will get an outfit when enslaved")
	endEvent
EndState

State OutfitNPCFollowerState
	event OnSelectST()
		OutfitNPCFollower = !OutfitNPCFollower
		SetToggleOptionValueST(OutfitNPCFollower)
	endEvent
	event OnDefaultST()
		OutfitNPCFree = true
	endEvent
	event OnHighlightST()
		SetInfoText("Follower NPC will get an outfit when enslaved")
	endEvent
EndState

State EnforcerAutomaticStripState
	event OnSelectST()
		EnforcerAutomaticStrip = !EnforcerAutomaticStrip
		SetToggleOptionValueST(EnforcerAutomaticStrip)
	endEvent
	event OnDefaultST()
		EnforcerAutomaticStrip = false
	endEvent
	event OnHighlightST()
		SetInfoText("Enforcer strips you if you violate the nudity law")
	endEvent
EndState

State FollowerScanState
	event OnSelectST()
		FollowerScan = !FollowerScan
		SetToggleOptionValueST(FollowerScan)
	endEvent
	event OnDefaultST()
		FollowerScan = true
	endEvent
	event OnHighlightST()
		SetInfoText("Scan for followers during the periodic enforcer checks")
	endEvent
EndState

State SkipIntensiveSexlabChecksState
	event OnSelectST()
		SkipIntensiveSexlabChecks = !SkipIntensiveSexlabChecks
		SetToggleOptionValueST(SkipIntensiveSexlabChecks)
	endEvent
	event OnDefaultST()
		SkipIntensiveSexlabChecks = true
	endEvent
	event OnHighlightST()
		SetInfoText("Skip very intensive (probably unnecessary) checks before calling sexlab api.")
	endEvent
EndState

State WhippingSoundState
	event OnSelectST()
		WhippingSound = !WhippingSound
		SetToggleOptionValueST(WhippingSound)
	endEvent
	event OnDefaultST()
		WhippingSound = true
	endEvent
	event OnHighlightST()
		SetInfoText("Activate this option to hear scream for females during whipping.")
	endEvent
EndState

State DieOnBadEndState
	event OnSelectST()
		DieOnBadEnd = !DieOnBadEnd
		SetToggleOptionValueST(DieOnBadEnd)
	endEvent
	event OnDefaultST()
		DieOnBadEnd = true
	endEvent
	event OnHighlightST()
		SetInfoText("Activate this option to die with the bad end of slaverun reloaded.")
	endEvent
EndState

State SleepingSlaveryState
	event OnSelectST()
		SleepingSlavery = !SleepingSlavery
		SetToggleOptionValueST(SleepingSlavery)
	endEvent
	event OnDefaultST()
		SleepingSlavery = false
	endEvent
	event OnHighlightST()
		SetInfoText("With the good end of slaverun reloaded slavery will dissapear, but it will not vanish and can be retriggered.")
	endEvent
EndState

State ForceReportingState
	event OnSelectST()
		ForceReporting = !ForceReporting
		SetToggleOptionValueST(ForceReporting)
		
		softDependency.ForceReporting = ForceReporting
	endEvent
	event OnDefaultST()
		ForceReporting = true
		softDependency.ForceReporting = ForceReporting
	endEvent
	event OnHighlightST()
		SetInfoText("Activate this option to force the player to report periodically to Bellamy (and as a slave be punished for failing.")
	endEvent
EndState

State ReportingTimeState
	Event OnSliderOpenST()
        SetSliderDialogStartValue( ReportingTime)
        SetSliderDialogDefaultValue(7.0)
        SetSliderDialogRange(1.0, 28.0)
        SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		ReportingTime= value as int
		SetSliderOptionValueSt( ReportingTime,"{0}")
	EndEvent
	Event OnDefaultST()
		ReportingTime=7
		SetSliderOptionValueSt( ReportingTime as Float,"{0}")
	EndEvent
	Event OnHighlightST()
		SetInfoText("This is time period in days you have to report back to Bellamy periodically.")
	EndEvent
EndState

State PlayerControlState
	Event OnSelectST()
		Debug.notification("Player controls enabled")
		Game.EnablePlayerControls()
		game.SetPlayerAIDriven(false)
		SendModEvent("dhlp-Resume")
		SLV_StopEnforcer.setValue(0)
		SLV_EnforcerRunning.setValue(0)
		SLV_EnforcerIgnorePC.setValue(0)
		
		if PlayerRef.GetCurrentScene()
			PlayerRef.GetCurrentScene().stop()
		endif
		
		Utility.SetIniBool("bDisablePlayerCollision:Havok",false)
	endEvent
	
	Event OnHighlightST()
		SetInfoText("Run")
	EndEvent
EndState

State StartSlaveryState
	Event OnSelectST()
		Debug.notification("Slavery started")
		SendModEvent("SlaverunReloaded_ForceEnslavement")
		Debug.MessageBox("Your time as a slave starts now.")
	endEvent
	
	Event OnHighlightST()
		SetInfoText("Click here to enslave the player character.")
	EndEvent
EndState

State EndSlaveryState
	Event OnSelectST()
		Debug.notification("Slavery ended")
		SendModEvent("SlaverunReloaded_EndEnslavement")
		Debug.MessageBox("Done.")
	endEvent

	Event OnHighlightST()
		SetInfoText("Click here to end slavery and free Skyrim again.")
	EndEvent
EndState

State ResetSlaveryState
	Event OnSelectST()
		Debug.notification("Slavery reset")
		SendModEvent("SlaverunReloaded_ResetSlavery")
		;SendModEvent("SlaverunReloaded_FreeSkyrim")
		Debug.MessageBox("Done.")
	endEvent
	
	Event OnHighlightST()
		SetInfoText("Click here to reset Slaverun Reloaded")
	EndEvent	
EndState


State SkipQuestsSlaveState
	Event OnSelectST()
		Debug.notification("Slavery quests skipped, all Skyrim is enslaved")
		SendModEvent("SlaverunReloaded_SkipSlaveQuests")
		Debug.MessageBox("Slavery has come to all of Skyrim now.")
	endEvent
	
	Event OnHighlightST()
		SetInfoText("Click here to skip all quests, put all Skyrim towns in slavery and become a slave.")
	EndEvent	
EndState

State SkipQuestsState
	Event OnSelectST()
		Debug.notification("Slavery quests skipped, all Skyrim is enslaved")
		SendModEvent("SlaverunReloaded_SkipQuests")
		Debug.MessageBox("Slavery has come to all of Skyrim now, but you are still free.")
	endEvent
	
	Event OnHighlightST()
		SetInfoText("Click here to skip all quests, put all Skyrim towns in slavery and stay free.")
	EndEvent	
EndState

State SetSlaveHaircutState
	Event OnSelectST()
		Debug.notification("Slave haircut set")
		
		String actualhair = ""
		Actor akActor = PlayerRef

		int hp = akActor.GetActorBase().GetNumHeadParts()
		int i = 0
		WHILE i < hp
			if(akActor.GetActorBase().GetNthHeadPart(i).GetType() == 3)
				actualhair =  akActor.GetActorBase().GetNthHeadPart(i).GetName()
			endif
			i += 1
		EndWHILE		
		
		StorageUtil.SetStringValue(none, "SlaverunPlayerHair", actualhair)
		Debug.MessageBox("Done.")
	endEvent
	
	Event OnHighlightST()
		SetInfoText("Set the current haircut as your original haircut before shaving.")
	EndEvent	
EndState



State DoypsFashionShavingState
	Event OnSelectST()
		Debug.notification("send event ")
		
		shaveScripts.Shave(PlayerRef)
		Debug.MessageBox("Done.")
	endEvent
	
	Event OnHighlightST()
		SetInfoText("Click here to shave player with yps-ImmersiveFashion.")
	EndEvent	
EndState
SLV_HeadShaving Property shaveScripts auto


State SetSlaveNameState
	Event OnSelectST()
		Debug.notification("Slavename set")
		
		Actor akActor = PlayerRef
		String playername = akActor.GetActorBase().GetName()
		StorageUtil.SetStringValue(none, "SlaverunPlayerName", playername)
		Debug.MessageBox("Done.")
	endEvent
	
	Event OnHighlightST()
		SetInfoText("Set the current name as your original name before you got a slave name.")
	EndEvent	
EndState

State CityEnslavingTimeState
	Event OnSliderOpenST()
        SetSliderDialogStartValue( CityEnslavingTime)
        SetSliderDialogDefaultValue(7.0)
        SetSliderDialogRange(1.0, 28.0)
        SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		CityEnslavingTime= value as int
		SetSliderOptionValueSt( CityEnslavingTime,"{0}")
	EndEvent
	Event OnDefaultST()
		CityEnslavingTime=7
		SetSliderOptionValueSt( CityEnslavingTime as Float,"{0}")
	EndEvent
	Event OnHighlightST()
		SetInfoText("This is time in days the next city will be enslaved when you are playing as a free woman.")
	EndEvent
EndState

State WhiterunmaxTaskState
	Event OnSliderOpenST()
        SetSliderDialogStartValue( WhiterunmaxTask)
        SetSliderDialogDefaultValue(2.0)
        SetSliderDialogRange(1.0, 20.0)
        SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		WhiterunmaxTask= value as int
		SetSliderOptionValueSt( WhiterunmaxTask,"{0}")
		SLV_WhiterunMaxTask.setvalue(WhiterunmaxTask)
		if !SlaverunQuest.UpdateCurrentInstanceGlobal(SLV_WhiterunMaxTask)
		  	Debug.notification("Failed to update SLV_WhiterunMaxTaskvalue for quest")
		endif
	EndEvent
	Event OnDefaultST()
		WhiterunmaxTask=2
		SetSliderOptionValueSt( WhiterunmaxTask as Float,"{0}")
		SLV_WhiterunMaxTask.setvalue(WhiterunmaxTask)
		if !SlaverunQuest.UpdateCurrentInstanceGlobal(SLV_WhiterunMaxTask)
		  	Debug.notification("Failed to update SLV_WhiterunMaxTaskvalue for quest")
		endif
	EndEvent
	Event OnHighlightST()
		SetInfoText("How many tasks are necessary to complete for quested city enslavement process.")
	EndEvent
EndState

State ShaveRegrouthTimeState
	Event OnSliderOpenST()
        SetSliderDialogStartValue(ShaveRegrouthTime)
        SetSliderDialogDefaultValue(48.0)
        SetSliderDialogRange(1.0, 96.0)
        SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		ShaveRegrouthTime= value as int
		SetSliderOptionValueSt(ShaveRegrouthTime,"{0}")
	EndEvent
	Event OnDefaultST()
		ShaveRegrouthTime=48
		SetSliderOptionValueSt(ShaveRegrouthTime as Float,"{0}")
	EndEvent
	Event OnHighlightST()
		SetInfoText("This is time in hours your hair need to regrow to the next stage when shaved off.")
	EndEvent
EndState
State ShaveRegrouthRoundState
	Event OnSliderOpenST()
        SetSliderDialogStartValue(ShaveRegrouthRound)
        SetSliderDialogDefaultValue(5.0)
        SetSliderDialogRange(1.0, 20.0)
        SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		ShaveRegrouthRound= value as int
		SetSliderOptionValueSt(ShaveRegrouthRound,"{0}")
	EndEvent
	Event OnDefaultST()
		ShaveRegrouthRound=5
		SetSliderOptionValueSt(ShaveRegrouthRound as Float,"{0}")
	EndEvent
	Event OnHighlightST()
		SetInfoText("This is number of hair style it will take from bald, very short, short,... til you original hairs reapear.")
	EndEvent
EndState

State MaxDistanceForSlaveSex
	Event OnSliderOpenST()
        SetSliderDialogStartValue(MaxDistanceToCallSlave)
        SetSliderDialogDefaultValue(2500.0)
        SetSliderDialogRange(500.0, 3000.0)
        SetSliderDialogInterval(100.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		MaxDistanceToCallSlave = value
		SetSliderOptionValueSt(MaxDistanceToCallSlave)
	EndEvent
	Event OnDefaultST()
		MaxDistanceToCallSlave = 2500.0
		SetSliderOptionValueSt(MaxDistanceToCallSlave)
	EndEvent
	Event OnHighlightST()
		SetInfoText("This is the maximum distance (default 2500) that a enslaved NPC will be called to for sex")
	EndEvent
EndState

State RatioToSlaveForFree
	Event OnSliderOpenST()
        SetSliderDialogStartValue(RatioOfSlaveDistanceForFreeWomen)
        SetSliderDialogDefaultValue(0.5)
        SetSliderDialogRange(0.0, 1.0)
        SetSliderDialogInterval(0.05)
	EndEvent
	Event OnSliderAcceptST(float value)
		RatioOfSlaveDistanceForFreeWomen = value
		SetSliderOptionValueSt(RatioOfSlaveDistanceForFreeWomen,"{2}",Option_Flag_None)
	EndEvent
	Event OnDefaultST()
		RatioOfSlaveDistanceForFreeWomen = 0.5
		SetSliderOptionValueSt(RatioOfSlaveDistanceForFreeWomen,"{2}",Option_Flag_None)
	EndEvent
	Event OnHighlightST()
		SetInfoText("This is the ratio of the distance to an enslaved NPC (default 0.5, 0.0 = never) that a free female will be called for sex, so free female will have a smaller range for sex attacks")
	EndEvent
EndState

State CheckNPCsInterval
	Event OnSliderOpenST()
        SetSliderDialogStartValue(CheckInterval as Float)
        SetSliderDialogDefaultValue(15.0)
        SetSliderDialogRange(1.0, 120.0)
        SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		CheckInterval = value as Int
		SetSliderOptionValueSt(CheckInterval as Float)
	EndEvent
	Event OnDefaultST()
		CheckInterval = 15
		SetSliderOptionValueSt(CheckInterval as Float)
	EndEvent
	Event OnHighlightST()
		SetInfoText("This is the number of seconds between the time NPCs are checked for clothing (free females and the player)\nMale NPCs are checked for arousal and sex will be started if females are available\nMales will also report the player for wearing clothing, armor or equipped weapons or spells, increase the value to lower script stress on your machine")
	EndEvent
EndState

State ArousalReqdToFuckSlave
	Event OnSliderOpenST()
        SetSliderDialogStartValue(ArousalToFuckSlave as Float)
        SetSliderDialogDefaultValue(40.0)
        SetSliderDialogRange(0.0, 100.0)
        SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		ArousalToFuckSlave = value as Int
		SetSliderOptionValueSt(ArousalToFuckSlave as Float,"{0}")
	EndEvent
	Event OnDefaultST()
		ArousalToFuckSlave = 40
		SetSliderOptionValueSt(ArousalToFuckSlave as Float,"{0}")
	EndEvent
	Event OnHighlightST()
		SetInfoText("This is how aroused a male NPC must be to call a slave to them for sex.")
	EndEvent
EndState

State ArousalReqdToFuckFreeFemale
	Event OnSliderOpenST()
        SetSliderDialogStartValue(ArousalToFuckFreeFemale as Float)
        SetSliderDialogDefaultValue(90.0)
        SetSliderDialogRange(0.0, 100.0)
        SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		ArousalToFuckFreeFemale = value as Int
		SetSliderOptionValueSt(ArousalToFuckFreeFemale as Float,"{0}")
	EndEvent
	Event OnDefaultST()
		ArousalToFuckFreeFemale = 90
		SetSliderOptionValueSt(ArousalToFuckFreeFemale as Float,"{0}")
	EndEvent
	Event OnHighlightST()
		SetInfoText("This is how aroused a male NPC must be to call a free female to them for sex.")
	EndEvent
EndState


State EnforcerSexlabCalls
	Event OnSliderOpenST()
        SetSliderDialogStartValue(EnforcerMaxSexlabCalls as Float)
        SetSliderDialogDefaultValue(1.0)
        SetSliderDialogRange(0.0, 20.0)
        SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		EnforcerMaxSexlabCalls = value as Int
		SetSliderOptionValueSt(EnforcerMaxSexlabCalls as Float,"{0}")
	EndEvent
	Event OnDefaultST()
		EnforcerMaxSexlabCalls = 1
		SetSliderOptionValueSt(EnforcerMaxSexlabCalls as Float,"{0}")
	EndEvent
	Event OnHighlightST()
		SetInfoText("Maximal number of sexlab calls for one enforcer run (0=unlimited).")
	EndEvent
EndState



State ActualCheckInterval
	; No code, always disabled since it is a display item
EndState

State NPCsStripped
	; No code, always disabled since it is a display item
EndState

State SlavesCalledForSex
	; No code, always disabled since it is a display item
EndState

State FreeCalledForSex
	; No code, always disabled since it is a display item
EndState

State WillArousedMalesFuckSlaves
	event OnSelectST()
		ArousedMalesFuckSlaves = !ArousedMalesFuckSlaves
		SetToggleOptionValueST(ArousedMalesFuckSlaves)
	endEvent
	event OnDefaultST()
		ArousedMalesFuckSlaves = true
	endEvent
	event OnHighlightST()
		SetInfoText("Activate this option to let aroused males call slaves for sex")
	endEvent
EndState

State UseAggressiveFuckForSlaves
	event OnSelectST()
		AggressiveFuckForSlaves = !AggressiveFuckForSlaves
		SetToggleOptionValueST(AggressiveFuckForSlaves)
	endEvent
	event OnDefaultST()
		AggressiveFuckForSlaves = true
	endEvent
	event OnHighlightST()
		SetInfoText("Set this option to use only aggressive animations for sex with slaves\nThis affects sex initiated by the Slaverun Enforcer mod, not the Slaverun mod")
	endEvent
EndState

State UseAnalFuckForSlaves
	event OnSelectST()
		AnalFuckForSlaves = !AnalFuckForSlaves
		SetToggleOptionValueST(AnalFuckForSlaves)
	endEvent
	event OnDefaultST()
		AnalFuckForSlaves = false
	endEvent
	event OnHighlightST()
		SetInfoText("Set this option to use only anal animations for sex with slaves\nThis affects sex initiated by the Slaverun Enforcer mod, not the Slaverun mod")
	endEvent
EndState

State WillArousedMalesFuckFreeFemales
	event OnSelectST()
		ArousedMalesFuckFreeFemales = !ArousedMalesFuckFreeFemales
		SetToggleOptionValueST(ArousedMalesFuckFreeFemales)
	endEvent
	event OnDefaultST()
		ArousedMalesFuckFreeFemales = true
	endEvent
	event OnHighlightST()
		SetInfoText("Activate this option to let aroused males call Free Females for sex")
	endEvent
EndState


State UseAggressiveFuckForFreeFemales
	event OnSelectST()
		AggressiveFuckForFreeFemales = !AggressiveFuckForFreeFemales
		SetToggleOptionValueST(AggressiveFuckForFreeFemales)
	endEvent
	event OnDefaultST()
		AggressiveFuckForFreeFemales = false
	endEvent
	event OnHighlightST()
		SetInfoText("Set this option to use only aggressive animations for sex with Free Females\nThis affects sex initiated by the Slaverun Enforcer mod, not the Slaverun mod")
	endEvent
EndState

State UseAnalFuckForFreeFemales
	event OnSelectST()
		AnalFuckForFreeFemales = !AnalFuckForFreeFemales
		SetToggleOptionValueST(AnalFuckForFreeFemales)
	endEvent
	event OnDefaultST()
		AnalFuckForFreeFemales = false
	endEvent
	event OnHighlightST()
		SetInfoText("Set this option to use only anal animations for sex with Free Females\nThis affects sex initiated by the Slaverun Enforcer mod, not the Slaverun mod")
	endEvent
EndState


State WillTattleTale
	event OnSelectST()
		TattleTales = !TattleTales
		SetToggleOptionValueST(TattleTales)
	endEvent
	event OnDefaultST()
		TattleTales = true
	endEvent
	event OnHighlightST()
		SetInfoText("Deactivate this option to prevent males from automatically reporting the player for violating the nudity law")
	endEvent
EndState

State DoAsThePlayerDoes
	event OnSelectST()
		FemaleFollowersMimicPlayer = !FemaleFollowersMimicPlayer
		SetToggleOptionValueST(FemaleFollowersMimicPlayer)
	endEvent
	event OnDefaultST()
		FemaleFollowersMimicPlayer = true
	endEvent
	event OnHighlightST()
		SetInfoText("Deactivate this option if you want the female followers to be treated as Free Females, otherwise they will be enslaved if the player is enslaved\nThis does not add sex scenes for them to the Slaverun mod")
	endEvent
EndState

State HydragonState
	event OnSelectST()
		Hydragon = !Hydragon 
		SetToggleOptionValueST(Hydragon)
		hydraslavegirls.disable_all()
		hydraslavegirls.enable_all()
	endEvent
	event OnDefaultST()
		Hydragon = true
	endEvent
	event OnHighlightST()
		SetInfoText("Deactivate this option if you do not want slaverun enable/disable hydragon slaves depending on city slave status.")
	endEvent
EndState

State MT_UserScreen
	event OnSelectST()
		MTUserScreen = !MTUserScreen
		SetToggleOptionValueST(MTUserScreen)
	endEvent
	event OnDefaultST()
		MTUserScreen = true
	endEvent
	event OnHighlightST()
		SetInfoText("Display these messages on screen for the player")
	endEvent
EndState

State MT_UserConsole
	event OnSelectST()
		MTUserConsole = !MTUserConsole
		SetToggleOptionValueST(MTUserConsole)
	endEvent
	event OnDefaultST()
		MTUserConsole = true
	endEvent
	event OnHighlightST()
		SetInfoText("Display these messages in the Console")
	endEvent
EndState

State MT_UserLog
	event OnSelectST()
		MTUserLog = !MTUserLog
		SetToggleOptionValueST(MTUserLog)
	endEvent
	event OnDefaultST()
		MTUserLog = true
	endEvent
	event OnHighlightST()
		SetInfoText("Write these messages to the Papyrus Log")
	endEvent
EndState

State MT_InformationScreen
	event OnSelectST()
		MTInformationScreen = !MTInformationScreen
		SetToggleOptionValueST(MTInformationScreen)
	endEvent
	event OnDefaultST()
		MTInformationScreen = true
	endEvent
	event OnHighlightST()
		SetInfoText("Display these messages on screen for the player")
	endEvent
EndState

State MT_InformationConsole
	event OnSelectST()
		MTInformationConsole = !MTInformationConsole
		SetToggleOptionValueST(MTInformationConsole)
	endEvent
	event OnDefaultST()
		MTInformationConsole = true
	endEvent
	event OnHighlightST()
		SetInfoText("Display these messages in the Console")
	endEvent
EndState

State MT_InformationLog
	event OnSelectST()
		MTInformationLog = !MTInformationLog
		SetToggleOptionValueST(MTInformationLog)
	endEvent
	event OnDefaultST()
		MTInformationLog = true
	endEvent
	event OnHighlightST()
		SetInfoText("Write these messages to the Papyrus Log")
	endEvent
EndState

State MT_Debug1Screen
	event OnSelectST()
		MTDebug1Screen = !MTDebug1Screen
		SetToggleOptionValueST(MTDebug1Screen)
	endEvent
	event OnDefaultST()
		MTDebug1Screen = true
	endEvent
	event OnHighlightST()
		SetInfoText("Display these messages on screen for the player")
	endEvent
EndState

State MT_Debug1Console
	event OnSelectST()
		MTDebug1Console = !MTDebug1Console
		SetToggleOptionValueST(MTDebug1Console)
	endEvent
	event OnDefaultST()
		MTDebug1Console = true
	endEvent
	event OnHighlightST()
		SetInfoText("Display these messages in the Console")
	endEvent
EndState

State MT_Debug1Log
	event OnSelectST()
		MTDebug1Log = !MTDebug1Log
		SetToggleOptionValueST(MTDebug1Log)
	endEvent
	event OnDefaultST()
		MTDebug1Log = true
	endEvent
	event OnHighlightST()
		SetInfoText("Write these messages to the Papyrus Log")
	endEvent
EndState

State MT_Debug2Screen
	event OnSelectST()
		MTDebug2Screen = !MTDebug2Screen
		SetToggleOptionValueST(MTDebug2Screen)
	endEvent
	event OnDefaultST()
		MTDebug2Screen = true
	endEvent
	event OnHighlightST()
		SetInfoText("Display these messages on screen for the player")
	endEvent
EndState

State MT_Debug2Console
	event OnSelectST()
		MTDebug2Console = !MTDebug2Console
		SetToggleOptionValueST(MTDebug2Console)
	endEvent
	event OnDefaultST()
		MTDebug2Console = true
	endEvent
	event OnHighlightST()
		SetInfoText("Display these messages in the Console")
	endEvent
EndState

State MT_Debug2Log
	event OnSelectST()
		MTDebug2Log = !MTDebug2Log
		SetToggleOptionValueST(MTDebug2Log)
	endEvent
	event OnDefaultST()
		MTDebug2Log = true
	endEvent
	event OnHighlightST()
		SetInfoText("Write these messages to the Papyrus Log")
	endEvent
EndState

State IsEnforcerEnabled
	event OnSelectST()
		EnforcerEnabled= !EnforcerEnabled
		SetToggleOptionValueST(EnforcerEnabled)
	endEvent
	event OnDefaultST()
		EnforcerEnabled= true
	endEvent
	event OnHighlightST()
		SetInfoText("Enable this options to let enforcer do his work, with this option off, no females will be stripped, the PC will not reported and no arousal sex will happen")
	endEvent
EndState

State WillArousedMalesFuckPC
	event OnSelectST()
		ArousedMalesFuckPC = !ArousedMalesFuckPC 
		SetToggleOptionValueST(ArousedMalesFuckPC )
	endEvent
	event OnDefaultST()
		ArousedMalesFuckPC = true
	endEvent
	event OnHighlightST()
		SetInfoText("Activate this option to let aroused males call for sex from the player character")
	endEvent
EndState

State SlaveShavingState
	event OnSelectST()
		SlaveShaving= !SlaveShaving
		SetToggleOptionValueST(SlaveShaving)
	endEvent
	event OnDefaultST()
		SlaveShaving= true
	endEvent
	event OnHighlightST()
		SetInfoText("Enable the players hair to be shaved")
	endEvent
EndState

State SlaveRenamingState
	event OnSelectST()
		SlaveRenaming= !SlaveRenaming
		SetToggleOptionValueST(SlaveRenaming)
	endEvent
	event OnDefaultST()
		SlaveRenaming= true
	endEvent
	event OnHighlightST()
		SetInfoText("Player will get a new slave name after his training and after major quest steps")
	endEvent
EndState

State SlaveTatoosState
	event OnSelectST()
		SlaveTatoos= !SlaveTatoos
		SetToggleOptionValueST(SlaveTatoos)
	endEvent
	event OnDefaultST()
		SlaveTatoos= true
	endEvent
	event OnHighlightST()
		SetInfoText("Player will get some tatoos (SlaveTats must be installed) in his training and after major quest steps")
	endEvent
EndState

State PutItemsInChestState
	event OnSelectST()
		PutItemsInChest = !PutItemsInChest 
		SetToggleOptionValueST(PutItemsInChest )
	endEvent
	event OnDefaultST()
		PutItemsInChest = true
	endEvent
	event OnHighlightST()
		SetInfoText("During enslavement your items are moved in a locked chest")
	endEvent
EndState

State UndressingState
	event OnSelectST()
		EnableUndressing= !EnableUndressing
		SetToggleOptionValueST(EnableUndressing)
	endEvent
	event OnDefaultST()
		EnableUndressing= true
	endEvent
	event OnHighlightST()
		SetInfoText("Undressing npc and checking the pc can be switched on and off here")
	endEvent
EndState

State UndressLeftHandState
	event OnSelectST()
		EnableUndressLeftHand = !EnableUndressLeftHand 
		SetToggleOptionValueST(EnableUndressLeftHand )
	endEvent
	event OnDefaultST()
		EnableUndressLeftHand = true
	endEvent
	event OnHighlightST()
		SetInfoText("Left hand will be undressed for all females and will be checked for the player character")
	endEvent
EndState
State UndressRightHandState
	event OnSelectST()
		EnableUndressRightHand = !EnableUndressRightHand 
		SetToggleOptionValueST(EnableUndressRightHand )
	endEvent
	event OnDefaultST()
		EnableUndressRightHand = true
	endEvent
	event OnHighlightST()
		SetInfoText("Right hand will be undressed for all females and will be checked for the player character")
	endEvent
EndState

State UndressSlot30State
	event OnSelectST()
		EnableUndressSlot30 = !EnableUndressSlot30 
		SetToggleOptionValueST(EnableUndressSlot30 )
	endEvent
	event OnDefaultST()
		EnableUndressSlot30 = true
	endEvent
	event OnHighlightST()
		SetInfoText("Slot 30 will be undressed for all females and will be checked for the player character")
	endEvent
EndState

State UndressSlot32State
	event OnSelectST()
		EnableUndressSlot32 = !EnableUndressSlot32 
		SetToggleOptionValueST(EnableUndressSlot32 )
	endEvent
	event OnDefaultST()
		EnableUndressSlot32 = true
	endEvent
	event OnHighlightST()
		SetInfoText("Slot 32 will be undressed for all females and will be checked for the player character")
	endEvent
EndState

State UndressSlot46State
	event OnSelectST()
		EnableUndressSlot46 = !EnableUndressSlot46 
		SetToggleOptionValueST(EnableUndressSlot46 )
	endEvent
	event OnDefaultST()
		EnableUndressSlot46 = true
	endEvent
	event OnHighlightST()
		SetInfoText("Slot 46 will be undressed for all females and will be checked for the player character")
	endEvent
EndState

State UndressSlot49State
	event OnSelectST()
		EnableUndressSlot49 = !EnableUndressSlot49 
		SetToggleOptionValueST(EnableUndressSlot49 )
	endEvent
	event OnDefaultST()
		EnableUndressSlot49 = true
	endEvent
	event OnHighlightST()
		SetInfoText("Slot 49 will be undressed for all females and will be checked for the player character")
	endEvent
EndState

State UndressSlot52State
	event OnSelectST()
		EnableUndressSlot52= !EnableUndressSlot52
		SetToggleOptionValueST(EnableUndressSlot52)
	endEvent
	event OnDefaultST()
		EnableUndressSlot52= true
	endEvent
	event OnHighlightST()
		SetInfoText("Slot 52 will be undressed for all females and will be checked for the player character")
	endEvent
EndState

State UndressSlot56State
	event OnSelectST()
		EnableUndressSlot56 = !EnableUndressSlot56 
		SetToggleOptionValueST(EnableUndressSlot56 )
	endEvent
	event OnDefaultST()
		EnableUndressSlot56 = true
	endEvent
	event OnHighlightST()
		SetInfoText("Slot 56 will be undressed for all females and will be checked for the player character")
	endEvent
EndState


State SkipCreatureSexState
	event OnSelectST()
		SkipCreatureSex= !SkipCreatureSex
		SetToggleOptionValueST(SkipCreatureSex)
	endEvent
	event OnDefaultST()
		SkipCreatureSex= false
	endEvent
	event OnHighlightST()
		SetInfoText("Skip sex scenes with animals and creatures.")
	endEvent
EndState

State SkipSexScenesState
	event OnSelectST()
		SkipSexScenes= !SkipSexScenes
		SetToggleOptionValueST(SkipSexScenes)
	endEvent
	event OnDefaultST()
		SkipSexScenes= false
	endEvent
	event OnHighlightST()
		SetInfoText("Enable this temporary if you are stuck in a sex scene and disable it afterwards. You MUST enable this feature BEFORE starting the dialogue which triggers the sex scene!!!")
	endEvent
EndState

State SkipScenesState
	event OnSelectST()
		SkipScenes= !SkipScenes
		SetToggleOptionValueST(SkipScenes)
	endEvent
	event OnDefaultST()
		SkipScenes= false
	endEvent
	event OnHighlightST()
		SetInfoText("Enable this temporary if you are stuck in a scene and disable it afterwards. You MUST enable this feature BEFORE starting the dialogue which triggers the scene!!!")
	endEvent
EndState

State SkipWhippingState
	event OnSelectST()
		SkipWhipping= !SkipWhipping
		SetToggleOptionValueST(SkipWhipping)
		
		if SkipWhipping
			SLV_SceneWhipping.setValue(0)
		else
			SLV_SceneWhipping.setValue(1)
		endif
	endEvent
	event OnDefaultST()
		SkipWhipping= false
		SLV_SceneWhipping.setValue(1)
	endEvent
	event OnHighlightST()
		SetInfoText("Enable this to disable whippings.")
	endEvent
EndState


State SkipDevicesForMenState
	event OnSelectST()
		SkipDevicesForMen = !SkipDevicesForMen
		SetToggleOptionValueST(SkipDevicesForMen)
	endEvent
	event OnDefaultST()
		SkipDevicesForMen= true
	endEvent
	event OnHighlightST()
		SetInfoText("Enable this to skip usage of devices for men by slaverun mod. This will not effect other mods.")
	endEvent
EndState


State SkipDevicesState
	event OnSelectST()
		SkipDevices= !SkipDevices
		SetToggleOptionValueST(SkipDevices)
	endEvent
	event OnDefaultST()
		SkipDevices= false
	endEvent
	event OnHighlightST()
		SetInfoText("Enable this to skip usage of devices by slaverun mod. This will not effect other mods.")
	endEvent
EndState

State SkipBrandingState
	event OnSelectST()
		SkipBranding= !SkipBranding
		SetToggleOptionValueST(SkipBranding)
	endEvent
	event OnDefaultST()
		SkipBranding= false
	endEvent
	event OnHighlightST()
		SetInfoText("Enable this to skip the long branding scene, but still apply the slavetat.")
	endEvent
EndState

State SkipOldPeopleState
	event OnSelectST()
		SkipOldPeople= !SkipOldPeople
		SetToggleOptionValueST(SkipOldPeople)
	endEvent
	event OnDefaultST()
		SkipOldPeople= false
	endEvent
	event OnHighlightST()
		SetInfoText("Skip old people for enforcer checks (being striped or raped)")
	endEvent
EndState

State ModStatusState
	; No code, always disabled since it is a display item
EndState
State PrequestStatusState
	; No code, always disabled since it is a display item
EndState

State NudityCrimeState
	event OnSelectST()
		NudityCrime= !NudityCrime
		SetToggleOptionValueST(NudityCrime)
	endEvent
	event OnDefaultST()
		NudityCrime= true
	endEvent
	event OnHighlightST()
		SetInfoText("You get a skyrim bounty on your head, which the guards (PO) will handle, when they can catch you.")
	endEvent
EndState

State NudityCrimeAmountState
	Event OnSliderOpenST()
        SetSliderDialogStartValue(NudityCrimeAmount)
        SetSliderDialogDefaultValue(500.0)
        SetSliderDialogRange(100.0, 10000.0)
        SetSliderDialogInterval(100.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		NudityCrimeAmount = value  as Int
		SetSliderOptionValueSt(NudityCrimeAmount)
	EndEvent
	Event OnDefaultST()
		NudityCrimeAmount = 500
		SetSliderOptionValueSt(NudityCrimeAmount)
	EndEvent
	Event OnHighlightST()
		SetInfoText("This is the bounty you get.")
	EndEvent
EndState

State NudityPunishmentState
	event OnSelectST()
		NudityPunishment= !NudityPunishment
		SetToggleOptionValueST(NudityPunishment)
	endEvent
	event OnDefaultST()
		NudityPunishment= true
	endEvent
	event OnHighlightST()
		SetInfoText("The person who sees you will punish you immediatly.")
	endEvent
EndState

State NudityRescueState
	event OnSelectST()
		NudityRescue= !NudityRescue
		SetToggleOptionValueST(NudityRescue)
	endEvent
	event OnDefaultST()
		NudityRescue= true
	endEvent
	event OnHighlightST()
		SetInfoText("You have a chance a good soul will see you and help you get unseen out of the city.")
	endEvent
EndState

State NudityEnslavementState
	event OnSelectST()
		NudityEnslavement= !NudityEnslavement
		SetToggleOptionValueST(NudityEnslavement)
	endEvent
	event OnDefaultST()
		NudityEnslavement= true
	endEvent
	event OnHighlightST()
		SetInfoText("As a free woman you will be enslaved, as a slave you will be punished by the Slave Master.")
	endEvent
EndState





function ExportInt(string Name, int Value)
	JsonUtil.SetIntValue(File, Name, Value)
endFunction

int function ImportInt(string Name, int Value)
	return JsonUtil.GetIntValue(File, Name, Value)
endFunction

function ExportBool(string Name, bool Value)
	JsonUtil.SetIntValue(File, Name, Value as int)
endFunction

bool function ImportBool(string Name, bool Value)
	return JsonUtil.GetIntValue(File, Name, Value as int) as bool
endFunction

function ExportFloat(string Name, float Value)
	JsonUtil.SetFloatValue(File, Name, Value)
endFunction

float function ImportFloat(string Name, float Value)
	return JsonUtil.GetFloatValue(File, Name, Value)
endFunction


function ExportSettings(int number)
File = "../Slaverun/SlaverunSettings" + number + ".json"
JsonUtil.SetStringValue(File, "ExportLabel", PlayerRef.GetLeveledActorBase().GetName()+" - "+Utility.GetCurrentRealTime() as int)
JsonUtil.SetStringValue(File, "Version", GetStringVer())	
			
ExportFloat("MaxDistanceToCallSlave", MaxDistanceToCallSlave)
	
ExportFloat("RatioOfSlaveDistanceForFreeWomen", RatioOfSlaveDistanceForFreeWomen)
ExportInt("ArousalToFuckSlave", ArousalToFuckSlave)
ExportBool("AggressiveFuckForSlaves", AggressiveFuckForSlaves)
ExportBool("AnalFuckForSlaves", AnalFuckForSlaves)
ExportInt("ArousalToFuckFreeFemale", ArousalToFuckFreeFemale)
ExportBool("AggressiveFuckForFreeFemales", AggressiveFuckForFreeFemales)
ExportBool("AnalFuckForFreeFemales", AnalFuckForFreeFemales)
ExportInt("CheckInterval", CheckInterval)

;ExportFloat("TotalCheckIntervals", TotalCheckIntervals)
;ExportFloat("TotalChecksPerformed", TotalChecksPerformed)
;ExportInt("ReportedAvgCheckInterval", ReportedAvgCheckInterval)
;ExportInt("FemaleNPCsStripped", FemaleNPCsStripped)
;ExportInt("SlavesCalledForSex", SlavesCalledForSex)
;ExportInt("FreeFemalesCalledForSex", FreeFemalesCalledForSex)

ExportBool("ArousedMalesFuckSlaves", ArousedMalesFuckSlaves)
ExportBool("ArousedMalesFuckFreeFemales", ArousedMalesFuckFreeFemales)
ExportBool("TattleTales", TattleTales)
ExportBool("FemaleFollowersMimicPlayer", FemaleFollowersMimicPlayer)
ExportBool("MTUserScreen", MTUserScreen)
ExportBool("MTUserConsole", MTUserConsole)
ExportBool("MTUserLog", MTUserLog)
ExportBool("MTInformationScreen", MTInformationScreen)
ExportBool("MTInformationConsole", MTInformationConsole)
ExportBool("MTInformationLog", MTInformationLog)
ExportBool("MTDebug1Screen", MTDebug1Screen)
ExportBool("MTDebug1Console", MTDebug1Console)
ExportBool("MTDebug1Log", MTDebug1Log)
ExportBool("MTDebug2Screen", MTDebug2Screen)
ExportBool("MTDebug2Console", MTDebug2Console)
ExportBool("MTDebug2Log", MTDebug2Log)

; new options
ExportBool("FollowerScan", FollowerScan)
ExportBool("SlaveShaving",SlaveShaving)
ExportInt("ShaveRegrouthTime", ShaveRegrouthTime)
ExportInt("ShaveRegrouthRound", ShaveRegrouthRound)
ExportBool("SlaveTatoos", SlaveTatoos)
ExportBool("SlaveRenaming", SlaveRenaming)
ExportBool("PutItemsInChest", PutItemsInChest)
ExportBool("EnforcerEnabled", EnforcerEnabled)
ExportBool("ArousedMalesFuckPC", ArousedMalesFuckPC)
ExportBool("SkipOldPeople", SkipOldPeople)
ExportBool("EnableUndressing", EnableUndressing)
ExportBool("EnableUndressSlot30", EnableUndressSlot30)
ExportBool("EnableUndressSlot32", EnableUndressSlot32)
ExportBool("EnableUndressSlot46", EnableUndressSlot46)
ExportBool("EnableUndressSlot49", EnableUndressSlot49)
ExportBool("EnableUndressSlot52", EnableUndressSlot52)
ExportBool("EnableUndressSlot56", EnableUndressSlot56)
ExportBool("EnableUndressLeftHand", EnableUndressLeftHand)
ExportBool("EnableUndressRightHand", EnableUndressRightHand)
ExportBool("ForceReporting", ForceReporting)
ExportBool("WhippingSound", WhippingSound)
ExportBool("DieOnBadEnd", DieOnBadEnd)
ExportBool("SleepingSlavery", SleepingSlavery)

ExportBool("SkipCreatureSex", SkipCreatureSex)
ExportBool("SkipSexScenes", SkipSexScenes)
ExportBool("SkipScenes", SkipScenes)
ExportBool("SkipWhipping", SkipWhipping)
ExportBool("SkipDevices", SkipDevices)
ExportBool("SkipBranding", SkipBranding)

ExportBool("NudityCrime", NudityCrime)
ExportInt("NudityCrimeAmount", NudityCrimeAmount)
ExportBool("NudityPunishment", NudityPunishment)
ExportBool("NudityRescue", NudityRescue)
ExportBool("NudityEnslavement", NudityEnslavement)

ExportBool("Hydragon", Hydragon)
ExportInt("CityEnslavingTime", CityEnslavingTime)
ExportInt("WhiterunmaxTask", WhiterunmaxTask)
ExportInt("equiptheme", equiptheme)
ExportInt("equipcolor", equipcolor)

ExportInt("freeNPCOutfit", freeNPCOutfit)
ExportInt("SlaveNPCOutfit", slaveNPCOutfit)
ExportInt("NPCOutfitcolor", NPCOutfitcolor)

ExportInt("ReportingTime", ReportingTime)
ExportInt("EnforcerMaxSexlabCalls", EnforcerMaxSexlabCalls)
ExportBool("SkipIntensiveSexlabChecks", SkipIntensiveSexlabChecks)
ExportBool("EnforcerAutomaticStrip", EnforcerAutomaticStrip)
ExportBool("OutfitNPCFree", OutfitNPCFree)
ExportBool("OutfitNPCSlave", OutfitNPCSlave)
ExportBool("OutfitNPCFollower", OutfitNPCFollower)
ExportBool("EnforcerLocationJSON", EnforcerLocationJSON)
ExportBool("CombatPausesEnforcer", CombatPausesEnforcer)
ExportBool("CheatsEnabled", CheatsEnabled)
ExportBool("AutoProgression", AutoProgression)
ExportBool("PCGangbang", PCGangbang)
ExportInt("PCGangbangProbability", PCGangbangProbability)
ExportBool("SkipAmputee", SkipAmputee)
ExportBool("ypsFashionShaving", ypsFashionShaving)
ExportBool("SkipDevicesForMen", SkipDevicesForMen)
ExportBool("StoryMode", StoryMode)
ExportInt("maxTasks", maxTasks)
ExportInt("KeyForNotification", KeyForNotification)
ExportBool("ShowNotifications", ShowNotifications)
ExportBool("BreastGrowing", BreastGrowing)
ExportBool("BreastWeightGrowing", BreastWeightGrowing)
ExportBool("BreastSLIFGrowing", BreastSLIFGrowing)
ExportFloat("BreastSLIFSize", BreastSLIFSize)
ExportBool("NoCarriageTravel", NoCarriageTravel)
ExportBool("SOSSlaverSchlong", SOSSlaverSchlong)
ExportBool("UseSexlabVirginity", UseSexlabVirginity)
ExportBool("NPCDialog", NPCDialog)
ExportFloat("BreastSLIFDelta", BreastSLIFDelta)
ExportInt("QuestStartAtLevel", QuestStartAtLevel)
ExportBool("DisableFastTravel", DisableFastTravel)
ExportBool("enforcerSexScenes", enforcerSexScenes)
ExportInt("enforcerSexSceneProbabilty", enforcerSexSceneProbabilty)
ExportInt("travelSexProbabilty", travelSexProbabilty)
ExportInt("walkOfShameProbabilty", walkOfShameProbabilty)

ExportBool("SlaveGuardsForceGreet", SlaveGuardsForceGreet)
ExportInt("SlaveGuardsCheckInterval", SlaveGuardsCheckInterval)
ExportBool("GoodSlavesAvoidWalkofShame", GoodSlavesAvoidWalkofShame)
ExportBool("SlaveGuardsEquipDevices", SlaveGuardsEquipDevices)
ExportBool("ChangeHairColor", ChangeHairColor)


ExportBool("arenaFreeModeChoice", arenaFreeModeChoice)
ExportBool("arenaFreeOpponentChoice", arenaFreeOpponentChoice)
ExportBool("arenaDeathMatch", arenaDeathMatch)
ExportBool("arenaDeathRapeMatch", arenaDeathRapeMatch)
ExportBool("arenaTrainingMatch", arenaTrainingMatch)
ExportBool("arenaTrainingRapeMatch", arenaTrainingRapeMatch)
ExportBool("arenaSpeedMatch", arenaSpeedMatch)


ExportBool("arenaHama", arenaHama)
ExportBool("arenaDomonkos", arenaDomonkos)
ExportBool("arenaBandon", arenaBandon)

ExportBool("arenaHaldir", arenaHaldir)
ExportBool("arenaCalum", arenaCalum)
ExportBool("arenaAllanon", arenaAllanon)

ExportBool("arenaArtus", arenaArtus)
ExportBool("arenaDesmond", arenaDesmond)
ExportBool("arenaAkiro", arenaAkiro)

ExportBool("arenaAzogTheOrc", arenaAzogTheOrc)
ExportBool("arenaHannibal", arenaHannibal)

ExportBool("arenaMaximus", arenaMaximus)
ExportBool("arenaDopperfield", arenaDopperfield)

ExportBool("arenaDastan", arenaDastan)
ExportBool("arenaMoudini", arenaMoudini)

ExportBool("arenaCalar", arenaCalar)
ExportBool("arenaArno", arenaArno)

ExportBool("arenaConan", arenaConan)
ExportBool("arenaMerlin", arenaMerlin)

ExportBool("arenaTwoTails", arenaTwoTails)

ExportBool("arenaDog", arenaDog)
ExportBool("arenaCow", arenaCow)
ExportBool("arenaChicken", arenaChicken)
ExportBool("arenaGoat", arenaGoat)

ExportBool("arenaHorse", arenaHorse)
ExportBool("arenaSkeever", arenaSkeever)
ExportBool("arenaDeer", arenaDeer)
ExportBool("arenaBoar", arenaBoar)

ExportBool("arenaSpider", arenaSpider)
ExportBool("arenaSkeleton", arenaSkeleton)
ExportBool("arenaDraugr", arenaDraugr)
ExportBool("arenaFalmer", arenaFalmer)

ExportBool("arenaRiekling", arenaRiekling)
ExportBool("arenaLargeSpider", arenaLargeSpider)
ExportBool("arenaWolf", arenaWolf)
ExportBool("arenaChaurus", arenaChaurus)
ExportBool("arenaDwarvenSpider", arenaDwarvenSpider)

ExportBool("arenaBear", arenaBear)
ExportBool("arenaSabrecat", arenaSabrecat)
ExportBool("arenaTroll", arenaTroll)
ExportBool("arenaHorker", arenaHorker)
ExportBool("arenaNetch", arenaNetch)
ExportBool("arenaDwarvenSphere", arenaDwarvenSphere)
ExportBool("arenaChaurusHunter", arenaChaurusHunter)

ExportBool("arenaDeathHound", arenaDeathHound)
ExportBool("arenaFrostAtronach", arenaFrostAtronach)
ExportBool("arenaGargoyle", arenaGargoyle)
ExportBool("arenaChaurusReaper", arenaChaurusReaper)
ExportBool("arenaDwarvenBallista", arenaDwarvenBallista)
ExportBool("arenaBoarRiekling", arenaBoarRiekling)

ExportBool("arenaMammoth", arenaMammoth)
ExportBool("arenaSeeker", arenaSeeker)
ExportBool("arenaSpiderGiant", arenaSpiderGiant)
ExportBool("arenaDwarvenCenturion", arenaDwarvenCenturion)

ExportBool("arenaDragonPriest", arenaDragonPriest)
ExportBool("arenaVampireLord", arenaVampireLord)
ExportBool("arenaWerewolf", arenaWerewolf)
ExportBool("arenaGiant", arenaGiant)
ExportBool("arenaLurker", arenaLurker)
ExportBool("arenaDragon", arenaDragon)


ExportBool("equipGag", equipGag)
ExportBool("equipAnalPlug", equipAnalPlug)
ExportBool("equipVagPlug", equipVagPlug)
ExportBool("equipHarness", equipHarness)
ExportBool("equipBelt", equipBelt)
ExportBool("equipBra", equipBra)
ExportBool("equipCollar", equipCollar)
ExportBool("equipLegCuffs", equipLegCuffs)
ExportBool("equipArmCuffs", equipArmCuffs)
ExportBool("equipArmbinder", equipArmbinder)
ExportBool("equipYoke", equipYoke)
ExportBool("equipBlindfold", equipBlindfold)
ExportBool("equipNPiercings", equipNPiercings)
ExportBool("equipVPiercings", equipVPiercings)
ExportBool("equipBoots", equipBoots)
ExportBool("equipGloves", equipGloves)
ExportBool("equipCorset", equipCorset)
ExportBool("equipMittens", equipMittens)
ExportBool("equipHood", equipHood)
ExportBool("equipClamps", equipClamps)
ExportBool("equipSuit", equipSuit)
ExportBool("equipShackles", equipShackles)
ExportBool("equipHobblesSkirt", equipHobblesSkirt)
ExportBool("equipHobblesSkirtRelaxed", equipHobblesSkirtRelaxed)

ExportBool("equipMaleGag", equipMaleGag)
ExportBool("equipMaleAnalPlug", equipMaleAnalPlug)
ExportBool("equipMaleVagPlug", equipMaleVagPlug)
ExportBool("equipMaleHarness", equipMaleHarness)
ExportBool("equipMaleBelt", equipMaleBelt)
ExportBool("equipMaleBra", equipMaleBra)
ExportBool("equipMaleCollar", equipMaleCollar)
ExportBool("equipMaleLegCuffs", equipMaleLegCuffs)
ExportBool("equipMaleArmCuffs", equipMaleArmCuffs)
ExportBool("equipMaleArmbinder", equipMaleArmbinder)
ExportBool("equipMaleYoke", equipMaleYoke)
ExportBool("equipMaleBlindfold", equipMaleBlindfold)
ExportBool("equipMaleNPiercings", equipMaleNPiercings)
ExportBool("equipMaleVPiercings", equipMaleVPiercings)
ExportBool("equipMaleBoots", equipMaleBoots)
ExportBool("equipMaleGloves", equipMaleGloves)
ExportBool("equipMaleCorset", equipMaleCorset)
ExportBool("equipMaleMittens", equipMaleMittens)
ExportBool("equipMaleHood", equipMaleHood)
ExportBool("equipMaleClamps", equipMaleClamps)
ExportBool("equipMaleSuit", equipMaleSuit)
ExportBool("equipMaleShackles", equipMaleShackles)
ExportBool("equipMaleHobblesSkirt", equipMaleHobblesSkirt)
ExportBool("equipMaleHobblesSkirtRelaxed", equipMaleHobblesSkirtRelaxed)

ExportBool("submissiveAutoEnslave", submissiveAutoEnslave)
ExportBool("dontDieInArena", dontDieInArena)
ExportBool("arenaBeheading", arenaBeheading)
ExportBool("arenaFightAlone", arenaFightAlone)
ExportInt("arenaAmputationProbabilty", arenaAmputationProbabilty)
ExportInt("arenaEnslavementProbabilty", arenaEnslavementProbabilty)
ExportInt("arenaRapeProbabilty", arenaRapeProbabilty)
ExportInt("arenaArmorRemoveProbabilty", arenaArmorRemoveProbabilty)
ExportBool("arenaGore", arenaGore)
ExportBool("arenaQuickMode", arenaQuickMode)
ExportBool("enforcerForceToCrawl", enforcerForceToCrawl)
ExportBool("guardForceGreet", guardForceGreet)

ExportBool("slaveGuard", slaveGuard)
ExportBool("reportMoneyOnly", reportMoneyOnly)
ExportInt("ReportingMoney", ReportingMoney)
ExportBool("reportSubmissiveCheck", reportSubmissiveCheck)
ExportBool("reportConfiscateGold", reportConfiscateGold)
ExportInt("reportConfiscateGoldLeft", reportConfiscateGoldLeft)
ExportBool("reportConfiscateItems", reportConfiscateItems)
ExportBool("reportsendSlaverPatrol", reportsendSlaverPatrol)
ExportBool("forceToCrawlInteriorOnly", forceToCrawlInteriorOnly)
ExportBool("enforcerForSlavers", enforcerForSlavers)
ExportBool("rapeForSlavers", rapeForSlavers)

JsonUtil.Save(File, false)
EndFunction


function ImportSettings(int number)
File = "../Slaverun/SlaverunSettings" + number + ".json"

LoadSettings()
EndFunction


function ResetSettings()
File = "../Slaverun/DefaultSlaverunSettings.json"

LoadSettings()
EndFunction


function LoadSettings()
MaxDistanceToCallSlave = ImportFloat("MaxDistanceToCallSlave", MaxDistanceToCallSlave)

RatioOfSlaveDistanceForFreeWomen = ImportFloat("RatioOfSlaveDistanceForFreeWomen", RatioOfSlaveDistanceForFreeWomen)
ArousalToFuckSlave = ImportInt("ArousalToFuckSlave", ArousalToFuckSlave)
AggressiveFuckForSlaves = ImportBool("AggressiveFuckForSlaves", AggressiveFuckForSlaves)
AnalFuckForSlaves = ImportBool("AnalFuckForSlaves", AnalFuckForSlaves)
ArousalToFuckFreeFemale = ImportInt("ArousalToFuckFreeFemale", ArousalToFuckFreeFemale)
AggressiveFuckForFreeFemales = ImportBool("AggressiveFuckForFreeFemales", AggressiveFuckForFreeFemales)
AnalFuckForFreeFemales = ImportBool("AnalFuckForFreeFemales", AnalFuckForFreeFemales)
CheckInterval = ImportInt("CheckInterval", CheckInterval)

;TotalCheckIntervals = ImportFloat("TotalCheckIntervals", TotalCheckIntervals)
;TotalChecksPerformed = ImportFloat("TotalChecksPerformed", TotalChecksPerformed)
;ReportedAvgCheckInterval = ImportInt("ReportedAvgCheckInterval", ReportedAvgCheckInterval)
;FemaleNPCsStripped = ImportInt("FemaleNPCsStripped", FemaleNPCsStripped)
;SlavesCalledForSex = ImportInt("SlavesCalledForSex", SlavesCalledForSex)
;FreeFemalesCalledForSex = ImportInt("FreeFemalesCalledForSex", FreeFemalesCalledForSex)

ArousedMalesFuckSlaves = ImportBool("ArousedMalesFuckSlaves", ArousedMalesFuckSlaves)
ArousedMalesFuckFreeFemales = ImportBool("ArousedMalesFuckFreeFemales", ArousedMalesFuckFreeFemales)
TattleTales = ImportBool("TattleTales", TattleTales)
FemaleFollowersMimicPlayer = ImportBool("FemaleFollowersMimicPlayer", FemaleFollowersMimicPlayer)
MTUserScreen = ImportBool("MTUserScreen", MTUserScreen)
MTUserConsole = ImportBool("MTUserConsole", MTUserConsole)
MTUserLog = ImportBool("MTUserLog", MTUserLog)
MTInformationScreen = ImportBool("MTInformationScreen", MTInformationScreen)
MTInformationConsole = ImportBool("MTInformationConsole", MTInformationConsole)
MTInformationLog = ImportBool("MTInformationLog", MTInformationLog)
MTDebug1Screen = ImportBool("MTDebug1Screen", MTDebug1Screen)
MTDebug1Console = ImportBool("MTDebug1Console", MTDebug1Console)
MTDebug1Log = ImportBool("MTDebug1Log", MTDebug1Log)
MTDebug2Screen = ImportBool("MTDebug2Screen", MTDebug2Screen)
MTDebug2Console = ImportBool("MTDebug2Console", MTDebug2Console)
MTDebug2Log = ImportBool("MTDebug2Log", MTDebug2Log)

; new options
FollowerScan = ImportBool("FollowerScan", FollowerScan)
SlaveShaving = ImportBool("SlaveShaving",SlaveShaving)
ShaveRegrouthTime = ImportInt("ShaveRegrouthTime", ShaveRegrouthTime)
ShaveRegrouthRound = ImportInt("ShaveRegrouthRound", ShaveRegrouthRound)
SlaveTatoos = ImportBool("SlaveTatoos", SlaveTatoos)
SlaveRenaming = ImportBool("SlaveRenaming", SlaveRenaming)
PutItemsInChest = ImportBool("PutItemsInChest", PutItemsInChest)
EnforcerEnabled = ImportBool("EnforcerEnabled", EnforcerEnabled)
ArousedMalesFuckPC = ImportBool("ArousedMalesFuckPC", ArousedMalesFuckPC)
SkipOldPeople = ImportBool("SkipOldPeople", SkipOldPeople)
EnableUndressing = ImportBool("EnableUndressing", EnableUndressing)
EnableUndressSlot30 = ImportBool("EnableUndressSlot30", EnableUndressSlot30)
EnableUndressSlot32 = ImportBool("EnableUndressSlot32", EnableUndressSlot32)
EnableUndressSlot46 = ImportBool("EnableUndressSlot46", EnableUndressSlot46)
EnableUndressSlot49 = ImportBool("EnableUndressSlot49", EnableUndressSlot49)
EnableUndressSlot52 = ImportBool("EnableUndressSlot52", EnableUndressSlot52)
EnableUndressSlot56 = ImportBool("EnableUndressSlot56", EnableUndressSlot56)
EnableUndressLeftHand = ImportBool("EnableUndressLeftHand", EnableUndressLeftHand)
EnableUndressRightHand = ImportBool("EnableUndressRightHand", EnableUndressRightHand)
ForceReporting = ImportBool("ForceReporting", ForceReporting)
WhippingSound = ImportBool("WhippingSound", WhippingSound)
DieOnBadEnd = ImportBool("DieOnBadEnd", DieOnBadEnd)
SleepingSlavery = ImportBool("SleepingSlavery", SleepingSlavery)

SkipCreatureSex = ImportBool("SkipCreatureSex", SkipCreatureSex)
SkipSexScenes = ImportBool("SkipSexScenes", SkipSexScenes)
SkipScenes = ImportBool("SkipScenes", SkipScenes)
SkipWhipping = ImportBool("SkipWhipping", SkipWhipping)
SkipDevices = ImportBool("SkipDevices", SkipDevices)
SkipBranding = ImportBool("SkipBranding", SkipBranding)

NudityCrime = ImportBool("NudityCrime", NudityCrime)
NudityCrimeAmount = ImportInt("NudityCrimeAmount", NudityCrimeAmount)
NudityPunishment = ImportBool("NudityPunishment", NudityPunishment)
NudityRescue = ImportBool("NudityRescue", NudityRescue)
NudityEnslavement = ImportBool("NudityEnslavement", NudityEnslavement)

Hydragon = ImportBool("Hydragon", Hydragon)
CityEnslavingTime = ImportInt("CityEnslavingTime", CityEnslavingTime)
WhiterunmaxTask = ImportInt("WhiterunmaxTask", WhiterunmaxTask)
equiptheme = ImportInt("equiptheme", equiptheme)
equipcolor = ImportInt("equipcolor", equipcolor)

freeNPCOutfit = ImportInt("FreeNPCOutfit", FreeNPCOutfit)
slaveNPCOutfit = ImportInt("SlaveNPCOutfit", SlaveNPCOutfit)
NPCOutfitcolor = ImportInt("NPCOutfitcolor", NPCOutfitcolor)

ReportingTime = ImportInt("ReportingTime", ReportingTime)
EnforcerMaxSexlabCalls = ImportInt("EnforcerMaxSexlabCalls", EnforcerMaxSexlabCalls)
SkipIntensiveSexlabChecks = ImportBool("SkipIntensiveSexlabChecks", SkipIntensiveSexlabChecks)
EnforcerAutomaticStrip = ImportBool("EnforcerAutomaticStrip", EnforcerAutomaticStrip)
OutfitNPCFree = ImportBool("OutfitNPCFree", OutfitNPCFree)
OutfitNPCSlave = ImportBool("OutfitNPCSlave", OutfitNPCSlave)
OutfitNPCFollower = ImportBool("OutfitNPCFollower", OutfitNPCFollower)
EnforcerLocationJSON = ImportBool("EnforcerLocationJSON", EnforcerLocationJSON)
CombatPausesEnforcer = ImportBool("CombatPausesEnforcer", CombatPausesEnforcer)
CheatsEnabled = ImportBool("CheatsEnabled", CheatsEnabled)
AutoProgression = ImportBool("AutoProgression", AutoProgression)
PCGangbang = ImportBool("PCGangbang", PCGangbang)
PCGangbangProbability = ImportInt("PCGangbangProbability", PCGangbangProbability)
SkipAmputee = ImportBool("SkipAmputee", SkipAmputee)
ypsFashionShaving = ImportBool("ypsFashionShaving", ypsFashionShaving)
SkipDevicesForMen = ImportBool("SkipDevicesForMen", SkipDevicesForMen)
StoryMode = ImportBool("StoryMode", StoryMode)
maxTasks = ImportInt("maxTasks", maxTasks)
KeyForNotification = ImportInt("KeyForNotification", KeyForNotification)
ShowNotifications = ImportBool("ShowNotifications", ShowNotifications)
BreastGrowing = ImportBool("BreastGrowing", BreastGrowing)
BreastWeightGrowing = ImportBool("BreastWeightGrowing", BreastWeightGrowing)
BreastSLIFGrowing = ImportBool("BreastSLIFGrowing", BreastSLIFGrowing)
BreastSLIFSize = ImportFloat("BreastSLIFSize", BreastSLIFSize)
NoCarriageTravel = ImportBool("NoCarriageTravel", NoCarriageTravel)
SOSSlaverSchlong = ImportBool("SOSSlaverSchlong", SOSSlaverSchlong)
UseSexlabVirginity = ImportBool("UseSexlabVirginity", UseSexlabVirginity)
NPCDialog = ImportBool("NPCDialog", NPCDialog)
BreastSLIFDelta = ImportFloat("BreastSLIFDelta", BreastSLIFDelta)
QuestStartAtLevel = ImportInt("QuestStartAtLevel", QuestStartAtLevel)
DisableFastTravel = ImportBool("DisableFastTravel", DisableFastTravel)
enforcerSexScenes = ImportBool("enforcerSexScenes", enforcerSexScenes)
enforcerSexSceneProbabilty = ImportInt("enforcerSexSceneProbabilty", enforcerSexSceneProbabilty)
travelSexProbabilty = ImportInt("travelSexProbabilty", travelSexProbabilty)
walkOfShameProbabilty = ImportInt("walkOfShameProbabilty", walkOfShameProbabilty)

SlaveGuardsForceGreet = ImportBool("SlaveGuardsForceGreet", SlaveGuardsForceGreet)
SlaveGuardsCheckInterval = ImportInt("SlaveGuardsCheckInterval", SlaveGuardsCheckInterval)
GoodSlavesAvoidWalkofShame = ImportBool("GoodSlavesAvoidWalkofShame", GoodSlavesAvoidWalkofShame)
SlaveGuardsEquipDevices = ImportBool("SlaveGuardsEquipDevices", SlaveGuardsEquipDevices)
ChangeHairColor = ImportBool("ChangeHairColor", ChangeHairColor)


arenaFreeModeChoice = ImportBool("arenaFreeModeChoice", arenaFreeModeChoice)
arenaFreeOpponentChoice = ImportBool("arenaFreeOpponentChoice", arenaFreeOpponentChoice)
arenaDeathMatch = ImportBool("arenaDeathMatch", arenaDeathMatch)
arenaDeathRapeMatch = ImportBool("arenaDeathRapeMatch", arenaDeathRapeMatch)
arenaTrainingMatch = ImportBool("arenaTrainingMatch", arenaTrainingMatch)
arenaTrainingRapeMatch = ImportBool("arenaTrainingRapeMatch", arenaTrainingRapeMatch)
arenaSpeedMatch = ImportBool("arenaSpeedMatch", arenaSpeedMatch)

arenaHama = ImportBool("arenaHama", arenaHama)
arenaDomonkos = ImportBool("arenaDomonkos", arenaDomonkos)
arenaBandon = ImportBool("arenaBandon", arenaBandon)

arenaHaldir = ImportBool("arenaHaldir", arenaHaldir)
arenaCalum = ImportBool("arenaCalum", arenaCalum)
arenaAllanon = ImportBool("arenaAllanon", arenaAllanon)

arenaArtus = ImportBool("arenaArtus", arenaArtus)
arenaDesmond = ImportBool("arenaDesmond", arenaDesmond)
arenaAkiro = ImportBool("arenaAkiro", arenaAkiro)

arenaAzogTheOrc = ImportBool("arenaAzogTheOrc", arenaAzogTheOrc)
arenaHannibal = ImportBool("arenaHannibal", arenaHannibal)

arenaMaximus = ImportBool("arenaMaximus", arenaMaximus)
arenaDopperfield = ImportBool("arenaDopperfield", arenaDopperfield)

arenaDastan = ImportBool("arenaDastan", arenaDastan)
arenaMoudini = ImportBool("arenaMoudini", arenaMoudini)

arenaCalar = ImportBool("arenaCalar", arenaCalar)
arenaArno = ImportBool("arenaArno", arenaArno)

arenaConan = ImportBool("arenaConan", arenaConan)
arenaMerlin = ImportBool("arenaMerlin", arenaMerlin)

arenaTwoTails = ImportBool("arenaTwoTails", arenaTwoTails)

arenaDog = ImportBool("arenaDog", arenaDog)
arenaCow = ImportBool("arenaCow", arenaCow)
arenaChicken = ImportBool("arenaChicken", arenaChicken)
arenaGoat = ImportBool("arenaGoat", arenaGoat)

arenaHorse = ImportBool("arenaHorse", arenaHorse)
arenaSkeever = ImportBool("arenaSkeever", arenaSkeever)
arenaDeer = ImportBool("arenaDeer", arenaDeer)
arenaBoar = ImportBool("arenaBoar", arenaBoar)

arenaSpider = ImportBool("arenaSpider", arenaSpider)
arenaSkeleton = ImportBool("arenaSkeleton", arenaSkeleton)
arenaDraugr = ImportBool("arenaDraugr", arenaDraugr)
arenaFalmer = ImportBool("arenaFalmer", arenaFalmer)

arenaRiekling = ImportBool("arenaRiekling", arenaRiekling)
arenaLargeSpider = ImportBool("arenaLargeSpider", arenaLargeSpider)
arenaWolf = ImportBool("arenaWolf", arenaWolf)
arenaChaurus = ImportBool("arenaChaurus", arenaChaurus)
arenaDwarvenSpider = ImportBool("arenaDwarvenSpider", arenaDwarvenSpider)

arenaBear = ImportBool("arenaBear", arenaBear)
arenaSabrecat = ImportBool("arenaSabrecat", arenaSabrecat)
arenaTroll = ImportBool("arenaTroll", arenaTroll)
arenaHorker = ImportBool("arenaHorker", arenaHorker)
arenaNetch = ImportBool("arenaNetch", arenaNetch)
arenaDwarvenSphere = ImportBool("arenaDwarvenSphere", arenaDwarvenSphere)
arenaChaurusHunter = ImportBool("arenaChaurusHunter", arenaChaurusHunter)

arenaDeathHound = ImportBool("arenaDeathHound", arenaDeathHound)
arenaFrostAtronach = ImportBool("arenaFrostAtronach", arenaFrostAtronach)
arenaGargoyle = ImportBool("arenaGargoyle", arenaGargoyle)
arenaChaurusReaper = ImportBool("arenaChaurusReaper", arenaChaurusReaper)
arenaDwarvenBallista = ImportBool("arenaDwarvenBallista", arenaDwarvenBallista)
arenaBoarRiekling = ImportBool("arenaBoarRiekling", arenaBoarRiekling)

arenaMammoth = ImportBool("arenaMammoth", arenaMammoth)
arenaSeeker = ImportBool("arenaSeeker", arenaSeeker)
arenaSpiderGiant = ImportBool("arenaSpiderGiant", arenaSpiderGiant)
arenaDwarvenCenturion = ImportBool("arenaDwarvenCenturion", arenaDwarvenCenturion)

arenaDragonPriest = ImportBool("arenaDragonPriest", arenaDragonPriest)
arenaVampireLord = ImportBool("arenaVampireLord", arenaVampireLord)
arenaWerewolf = ImportBool("arenaWerewolf", arenaWerewolf)
arenaGiant = ImportBool("arenaGiant", arenaGiant)
arenaLurker = ImportBool("arenaLurker", arenaLurker)
arenaDragon = ImportBool("arenaDragon", arenaDragon)

equipGag = ImportBool("equipGag", equipGag)
equipAnalPlug = ImportBool("equipAnalPlug", equipAnalPlug)
equipVagPlug = ImportBool("equipVagPlug", equipVagPlug)
equipHarness = ImportBool("equipHarness", equipHarness)
equipBelt = ImportBool("equipBelt", equipBelt)
equipBra = ImportBool("equipBra", equipBra)
equipCollar = ImportBool("equipCollar", equipCollar)
equipLegCuffs = ImportBool("equipLegCuffs", equipLegCuffs)
equipArmCuffs = ImportBool("equipArmCuffs", equipArmCuffs)
equipArmbinder = ImportBool("equipArmbinder", equipArmbinder)
equipYoke = ImportBool("equipYoke", equipYoke)
equipBlindfold = ImportBool("equipBlindfold", equipBlindfold)
equipNPiercings = ImportBool("equipNPiercings", equipNPiercings)
equipVPiercings = ImportBool("equipVPiercings", equipVPiercings)
equipBoots = ImportBool("equipBoots", equipBoots)
equipGloves = ImportBool("equipGloves", equipGloves)
equipCorset = ImportBool("equipCorset", equipCorset)
equipMittens = ImportBool("equipMittens", equipMittens)
equipHood = ImportBool("equipHood", equipHood)
equipClamps = ImportBool("equipClamps", equipClamps)
equipSuit = ImportBool("equipSuit", equipSuit)
equipShackles = ImportBool("equipShackles", equipShackles)
equipHobblesSkirt = ImportBool("equipHobblesSkirt", equipHobblesSkirt)
equipHobblesSkirtRelaxed = ImportBool("equipHobblesSkirtRelaxed", equipHobblesSkirtRelaxed)


equipMaleGag = ImportBool("equipMaleGag", equipMaleGag)
equipMaleAnalPlug = ImportBool("equipMaleAnalPlug", equipMaleAnalPlug)
equipMaleVagPlug = ImportBool("equipMaleVagPlug", equipMaleVagPlug)
equipMaleHarness = ImportBool("equipMaleHarness", equipMaleHarness)
equipMaleBelt = ImportBool("equipMaleBelt", equipMaleBelt)
equipMaleBra = ImportBool("equipMaleBra", equipMaleBra)
equipMaleCollar = ImportBool("equipMaleCollar", equipMaleCollar)
equipMaleLegCuffs = ImportBool("equipMaleLegCuffs", equipMaleLegCuffs)
equipMaleArmCuffs = ImportBool("equipMaleArmCuffs", equipMaleArmCuffs)
equipMaleArmbinder = ImportBool("equipMaleArmbinder", equipMaleArmbinder)
equipMaleYoke = ImportBool("equipMaleYoke", equipMaleYoke)
equipMaleBlindfold = ImportBool("equipMaleBlindfold", equipMaleBlindfold)
equipMaleNPiercings = ImportBool("equipMaleNPiercings", equipMaleNPiercings)
equipMaleVPiercings = ImportBool("equipMaleVPiercings", equipMaleVPiercings)
equipMaleBoots = ImportBool("equipMaleBoots", equipMaleBoots)
equipMaleGloves = ImportBool("equipMaleGloves", equipMaleGloves)
equipMaleCorset = ImportBool("equipMaleCorset", equipMaleCorset)
equipMaleMittens = ImportBool("equipMaleMittens", equipMaleMittens)
equipMaleHood = ImportBool("equipMaleHood", equipMaleHood)
equipMaleClamps = ImportBool("equipMaleClamps", equipMaleClamps)
equipMaleSuit = ImportBool("equipMaleSuit", equipMaleSuit)
equipMaleShackles = ImportBool("equipMaleShackles", equipMaleShackles)
equipMaleHobblesSkirt = ImportBool("equipMaleHobblesSkirt", equipMaleHobblesSkirt)
equipMaleHobblesSkirtRelaxed = ImportBool("equipMaleHobblesSkirtRelaxed", equipMaleHobblesSkirtRelaxed)

submissiveAutoEnslave = ImportBool("submissiveAutoEnslave", submissiveAutoEnslave)
dontDieInArena = ImportBool("dontDieInArena", dontDieInArena)
arenaBeheading = ImportBool("arenaBeheading", arenaBeheading)
arenaFightAlone = ImportBool("arenaFightAlone", arenaFightAlone)
arenaAmputationProbabilty = ImportInt("arenaAmputationProbabilty", arenaAmputationProbabilty)
arenaEnslavementProbabilty = ImportInt("arenaEnslavementProbabilty", arenaEnslavementProbabilty)
arenaRapeProbabilty = ImportInt("arenaRapeProbabilty", arenaRapeProbabilty)
arenaArmorRemoveProbabilty = ImportInt("arenaArmorRemoveProbabilty", arenaArmorRemoveProbabilty)
arenaGore = ImportBool("arenaGore", arenaGore)
arenaQuickMode = ImportBool("arenaQuickMode", arenaQuickMode)
enforcerForceToCrawl = ImportBool("enforcerForceToCrawl", enforcerForceToCrawl)
forceToCrawlInteriorOnly = ImportBool("forceToCrawlInteriorOnly", forceToCrawlInteriorOnly)
guardForceGreet = ImportBool("guardForceGreet", guardForceGreet)

slaveGuard = ImportBool("slaveGuard", slaveGuard)
reportMoneyOnly = ImportBool("reportMoneyOnly", reportMoneyOnly)
ReportingMoney = ImportInt("ReportingMoney", ReportingMoney)
reportSubmissiveCheck = ImportBool("reportSubmissiveCheck", reportSubmissiveCheck)
reportConfiscateGold = ImportBool("reportConfiscateGold", reportConfiscateGold)
reportConfiscateGoldLeft = ImportInt("reportConfiscateGoldLeft", reportConfiscateGoldLeft)
reportConfiscateItems = ImportBool("reportConfiscateItems", reportConfiscateItems)
reportsendSlaverPatrol = ImportBool("reportsendSlaverPatrol", reportsendSlaverPatrol)
enforcerForSlavers = ImportBool("enforcerForSlavers", enforcerForSlavers)
rapeForSlavers = ImportBool("rapeForSlavers", rapeForSlavers)

ImportGlobals()
EndFunction


function ImportGlobals()
if BreastGrowing
	SLV_WeightGain.setvalue(1)
else
	SLV_WeightGain.setvalue(0)
endif		

if NoCarriageTravel
	SLV_CarriageDisabled.setvalue(1)
else
	SLV_CarriageDisabled.setvalue(0)
endif

SLV_MaxTask.setvalue(maxTasks)
if !SlaverunQuest.UpdateCurrentInstanceGlobal(SLV_MaxTask)
  	Debug.notification("Failed to update SLV_MaxTask for quest")
endif
		
if StoryMode
	SLV_StoryMode.setValue(1)
else
	SLV_StoryMode.setValue(0)
endif

SLV_WhiterunMaxTask.setvalue(WhiterunmaxTask)
if !SlaverunQuest.UpdateCurrentInstanceGlobal(SLV_WhiterunMaxTask)
  	Debug.notification("Failed to update SLV_WhiterunMaxTaskvalue for quest")
endif

if SkipWhipping
	SLV_SceneWhipping.setValue(0)
else
	SLV_SceneWhipping.setValue(1)
endif

if CheatsEnabled
	softDependency.testmode = true
endIf
myScripts.SLV_CheatMode()

if NPCDialog
	SLV_NPCDialog.setValue(1)
else
	SLV_NPCDialog.setValue(0)
endif

if submissiveAutoEnslave
	SLV_AutomaticEnslavement.setValue(1)
else
	SLV_AutomaticEnslavement.setValue(0)
endif

if arenaFreeOpponentChoice
	SLV_ColosseumRandomBeast.setvalue(0)
	SLV_ColosseumRandomGladiator.setvalue(0)
else
	SLV_ColosseumRandomBeast.setvalue(1)
	SLV_ColosseumRandomGladiator.setvalue(1)
endif

if arenaFreeModeChoice
	SLV_ColosseumRandomFightMode.setvalue(0)
else
	SLV_ColosseumRandomFightMode.setvalue(1)
endif

if arenaQuickMode
	SLV_ColosseumQuickMode.setValue(1)
else
	SLV_ColosseumQuickMode.setValue(0)
endif		

if guardForceGreet
	SLV_GuardNoForceGreet.setValue(0)
else
	SLV_GuardNoForceGreet.setValue(1)
endif	

if slaveGuard
	SLV_FinnEnabled.setValue(1)
else
	SLV_FinnEnabled.setValue(0)
endif

SLV_ReportingGold.setvalue(ReportingMoney)
SLV_LevelForPrequest.setvalue(QuestStartAtLevel)

if DisableFastTravel
	Game.EnableFastTravel(false)
else
	Game.EnableFastTravel(true)
endif

softDependency.enforcerForSlavers = enforcerForSlavers
softDependency.ForceReporting = ForceReporting
softDependency.reportMoneyOnly = reportMoneyOnly
softDependency.reportSubmissiveCheck = reportSubmissiveCheck
softDependency.reportConfiscateGold = reportConfiscateGold
softDependency.reportConfiscateItems = reportConfiscateItems
EndFunction
