Scriptname SLV_Menu extends SKI_ConfigBase  

Faction Property SlaverunSlaveFaction auto
Faction Property SlaverunSlaverFaction auto
Quest Property SlaverunPeriodicChecking auto
Float Property MaxDistanceToCallSlave auto
Float Property RatioOfSlaveDistanceForFreeWomen Auto
Float Property TotalCheckIntervals auto
Float Property TotalChecksPerformed auto
Int Property ArousalToFuckSlave auto
Bool Property AggressiveFuckForSlaves auto
Bool Property AnalFuckForSlaves auto
Int Property ArousalToFuckFreeFemale auto
Bool Property AggressiveFuckForFreeFemales auto
Bool Property AnalFuckForFreeFemales auto
Int Property CheckInterval auto
Int Property ReportedAvgCheckInterval auto
Int Property FemaleNPCsStripped auto
Int Property SlavesCalledForSex auto
Int Property FreeFemalesCalledForSex auto
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
Quest Property SlaverunQuest Auto
SLV_Utilities Property myScripts auto
SLV_SoftHydraSlavegirls  Property hydraslavegirls Auto
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
;string[] property ThemeList Auto
;string[] property ColorList Auto
string[] ThemeList
string[] ColorList
int property equiptheme = 0 auto
int property equipcolor = 0 auto

;string[] property NPCOutfitList Auto
;string[] property NPCOutfitColorList Auto
string[] NPCOutfitList
string[] NPCOutfitColorList
int property NPCOutfit = 0 auto
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

GlobalVariable Property SLV_WhiterunMaxTask  Auto 
GlobalVariable Property SLV_WhiterunTasksDone  Auto 
GlobalVariable Property SLV_ArenaFightsWon  Auto 
GlobalVariable Property SLV_StopEnforcer Auto
GlobalVariable Property SLV_EnforcerRunning Auto
GlobalVariable Property SLV_IvanaMood Auto
GlobalVariable Property SLV_BrutusMood Auto
GlobalVariable Property SLV_PikeMood Auto
GlobalVariable Property SLV_StoryMode Auto
GlobalVariable Property SLV_SceneWhipping Auto

Actor [] Property followers Auto
Actor Property slavefollower Auto
Actor Property nonslavefollower Auto
Actor Property malefollower Auto
Int Property followersCount Auto

Actor Property selectedActor Auto

; PRIVATE VARIABLES -------------------------------------------------------------------------------
Bool ModisRunning = false
int equipthemeOID
int equipcolorOID
int npcoutfitOID
int npcoutfitcolorOID
int sceneOID

; SCRIPT VERSION ----------------------------------------------------------------------------------
int function GetVersion()
	return 4 ; Default version
endFunction

;------------- Declare each page for the MCM here 
event OnConfigInit()
	ModName = "Slaverun Reloaded"
	Pages = new string[7]
	Pages[0] = "Common Settings"
	Pages[1] = "Enforcer Settings"
	Pages[2] = "Nudity Law"
	Pages[3] = "Problems"
	Pages[4] = "Statistics"
	Pages[5] = "Mod Messages"
	Pages[6] = "Devious Devices"
	
	
	ThemeList = new string[4]
	ThemeList[0] = "Random"
	ThemeList[1] = "Metal"
	ThemeList[2] = "Leather"
	ThemeList[3] = "Ebonite"
	
	ColorList = new string[4]
	ColorList[0] = "Random"
	ColorList[1] = "White"
	ColorList[2] = "Red"
	ColorList[3] = "Black"
	
	NPCOutfitList = new string[4]
	NPCOutfitList[0] = "Random"
	NPCOutfitList[1] = "Naked"
	NPCOutfitList[2] = "Normal"
	NPCOutfitList[3] = "Full"
	
	NPCOutfitColorList = new string[4]
	NPCOutfitColorList[0] = "Random"
	NPCOutfitColorList[1] = "White"
	NPCOutfitColorList[2] = "Red"
	NPCOutfitColorList[3] = "Black"
endEvent

;------------- Add code for version updates here
event OnVersionUpdate(int a_version)
	{Called when a version update of this script has been detected}
	;if a_version != GetVersion()
		OnConfigInit()
	;endif
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
	elseif (a_page == "Enforcer Settings")
		PageEnforcerSettings()
	elseif (a_page == "Nudity Law")
		PageShowNudityLaw()
	elseif (a_page == "Problems")
		PageShowProblems()
	elseif (a_page == "Statistics")
		PageShowStatistics()
	elseif (a_page == "Mod Messages")
		PageMessages()
	elseif (a_page == "Devious Devices")
		PageDevices()
	elseif (a_page == "Mod was shut down")
		AddHeaderOption("Mod is shut down")
	endif
endEvent

;------------- Create a function here for each page
Function PageCommonSettings()
	AddHeaderOption("Mod status")
	if (SlaverunQuest.IsRunning() == 1)
		ModisRunning = true;
	else  
		ModisRunning = false;
	endIf
	AddToggleOptionST("ModStatusState","Mod started", ModisRunning )

	AddHeaderOption("Mod options")
	AddToggleOptionST("SlaveShavingState","Slave hair shaving", SlaveShaving )
	AddSliderOptionST("ShaveRegrouthTimeState","Time in hours to regrow hairs",ShaveRegrouthTime,"{0}",Option_Flag_None)
	AddSliderOptionST("ShaveRegrouthRoundState","#haircuts til your original hair reappears",ShaveRegrouthRound,"{0}",Option_Flag_None)
	AddToggleOptionST("ypsFashionShavingState","ypsFashion hair shaving", ypsFashionShaving)	

	AddToggleOptionST("SlaveTatoosState","Slave Tatoos", SlaveTatoos )
	AddToggleOptionST("SlaveRenamingState","Slave name changing", SlaveRenaming )
	AddSliderOptionST("CityEnslavingTimeState","Time in days to enslave cities",CityEnslavingTime,"{0}",Option_Flag_None)
	AddSliderOptionST("WhiterunmaxTaskState","#tasks needed for next city",WhiterunmaxTask,"{0}",Option_Flag_None)
	AddSliderOptionST("maxTasksState","# needed repetitive tasks",maxTasks,"{0}",Option_Flag_None)
	AddToggleOptionST("StoryModeState","Story mode", StoryMode )

	String reporttext = "not set"
	Float reportdate = StorageUtil.GetFloatValue(None, "SLV_ReportBackHours", 0.0 )
	if reportdate != 0.0
		AddToggleOptionST("ForceReportingState","Periodically reporting", ForceReporting )
		AddSliderOptionST("ReportingTimeState","Time in days you need to report peridodically",ReportingTime,"{0}",Option_Flag_None)

		;MiscUtil.PrintConsole("Reportdate:" + reportdate)
		Float currentdate = Utility.GetCurrentGameTime()
	
		Float Time = reportdate - currentdate
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
	endif

	AddToggleOptionST("WhippingSoundState","Whippings with sound", WhippingSound )
	AddToggleOptionST("DieOnBadEndState","Die in the bad end of slaverun", DieOnBadEnd )
	AddToggleOptionST("SleepingSlaveryState","Slavery will come back", SleepingSlavery )
	
	AddHeaderOption("PC enslavement options")
	AddToggleOptionST("PutItemsInChestState","Put Slave items in chest", PutItemsInChest )
	equipthemeOID = AddMenuOption("Enslavement Devices", ThemeList[equiptheme])
	equipcolorOID = AddMenuOption("Enslavement Devices Color", ColorList[equipcolor])
		
	AddToggleOptionST("BreastGrowingState","Breast will increase", BreastGrowing )
	AddToggleOptionST("BreastWeightGrowingState","-> by body weight", BreastWeightGrowing )
	AddToggleOptionST("BreastSLIFGrowingState","-> by Inflation Framework", BreastSLIFGrowing )
	AddSliderOptionST("BreastSLIFSizeState", "-> current SLIF size", BreastSLIFSize , "{1}")
	

	AddHeaderOption("NPC enslavement options")
	AddToggleOptionST("OutfitNPCFreeState","Free NPC Outfits", OutfitNPCFree)
	AddToggleOptionST("OutfitNPCSlaveState","Slave NPC Outfits", OutfitNPCSlave)
	AddToggleOptionST("OutfitNPCFollowerState","Follower NPC Outfits", OutfitNPCFollower)
	npcoutfitOID = AddMenuOption("Slaves Outfit", NPCOutfitList[npcoutfit])
	npcoutfitcolorOID = AddMenuOption("Slaves Outfit Color", NPCOutfitColorList[npcoutfitcolor])

	Int TargetModIndex
	AddHeaderOption("Soft Dependencies")
	if Game.GetModByName("SlaveTats.esp")!= 255
		AddTextOption("Slave Tats","Found")
	else
		AddTextOption("Slave Tats","Not Found")
	endif
	if  Game.GetModByName("BrandingDeviceOfDoom.esp")!= 255
		AddTextOption("Branding Device Of Doom","Found")
	else
		AddTextOption("Branding Device Of Doom","Not Found")
	endif
	if Game.GetModByName("Simpleslavery.esp")!= 255
		AddTextOption("Simple Slavery","Found")
	else
		AddTextOption("Simple Slavery","Not Found")
	endif
	if Game.GetModByName("hydra_slavegirls.esp") != 255
		AddTextOption("Hydragon Slavegirls","Found")
	else
		AddTextOption("Hydragon Slavegirls","Not Found")
	endif
	AddToggleOptionST("HydragonState","Hydragon slave handling", Hydragon)
	if Game.GetModByName("zdd.esp") != 255
		AddTextOption("Diablo-esque Decorations","Found")
	else
		AddTextOption("Diablo-esque Decorations","Not Found")
	endif
	if Game.GetModByName("SerialStrip.esp") != 255
		AddTextOption("Serial Strip","Found")
	else
		AddTextOption("Serial Strip","Not Found")
	endif
	if Game.GetModByName("MilkModNEW.esp") != 255
		AddTextOption("Milk Mod","Found")
	else
		AddTextOption("Milk Mod","Not Found")
	endif
	if Game.GetModByName("SexLabSkoomaWhore.esp") != 255
		AddTextOption("Skooma Whore","Found")
	else
		AddTextOption("Skooma Whore","Not Found")
	endif
	if Game.GetModByName("Deviously Cursed Loot.esp") != 255
		AddTextOption("Cursed Loot","Found")
	else
		AddTextOption("Cursed Loot","Not Found")
	endif
	if Game.GetModByName("PSQ PlayerSuccubusQuest.esm") != 255
		AddTextOption("Player Succubus Quest","Found")
	else
		AddTextOption("Player Succubus Quest","Not Found")
	endif
	if Game.GetModByName("Frostfall.esp") != 255
		AddTextOption("Frostfall","Found")
	else
		AddTextOption("Frostfall","Not Found")
	endif
	if Game.GetModByName("yps-ImmersivePiercing.esp") != 255
		AddTextOption("yps-ImmersiveFashion","Found")
	else
		AddTextOption("yps-ImmersiveFashion","Not Found")
	endif
	if Game.GetModByName("Amputator.esm") != 255
		AddTextOption("Amputator Framework","Found")
	else
		AddTextOption("Amputator Framework","Not Found")
	endif
	if Game.GetModByName("SexLab Inflation Framework.esp") != 255
		AddTextOption("Sexlab Inflation Framework","Found")
	else
		AddTextOption("Sexlab Inflation Framework","Not Found")
	endif
	
	SetCursorPosition(1)
	AddHeaderOption("Progress enslaving skyrim")
	AddTextOption("Player name", Game.GetPlayer().GetActorBase().GetName())
	
	
	AddToggleOptionST("ShowNotificationsState","Show notifications", ShowNotifications )
	AddKeyMapOptionST("MenuKey_Notification", "Key for statusnotifications", KeyForNotification)	
	if(Game.GetPlayer().IsInFaction(SlaverunSlaveFaction))
		AddTextOption("Submissive slave (0-20): ", SLV_IvanaMood.getValue() as int)
		AddTextOption("(0=rebellious - 20=well trained and submissive)", "" )
		AddTextOption("Falling in love with Bellamy (0-10): ", SLV_BrutusMood.getValue() as int )
		AddTextOption("(0=hate - 10=total in love)" , "")
	endIf
	if(Game.GetPlayer().IsInFaction(SlaverunSlaverFaction))
		AddTextOption("Submissive slaver (0-10): ", SLV_PikeMood.getValue() as int)
		AddTextOption("(0=sadistic - 10=slutty and submissive)", "" )
	endIf	
	String playerName = StorageUtil.GetStringValue(none, "SlaverunPlayerName")
	if playerName
		AddTextOption("Original Player name", playerName)
	endIf
	String playerHaircut = StorageUtil.GetStringValue(none, "SlaverunPlayerHair")
	if playerHaircut
		AddTextOption("Original Player haircut", playerHaircut)
	endIf
	
	if(SLV_WhiterunTasksDone.getValue() > 0)
		int tasks = SLV_WhiterunTasksDone.getValue() as int
		AddTextOption("Whiterun Tasks done", tasks)
		String slavetitle = myScripts.SLV_GetSlaveTitle()
		if(slavetitle != "")
			AddTextOption("Slave status", slavetitle)
		endif
	endif
	if(SLV_ArenaFightsWon.getValue() > 0)
		int fights = SLV_ArenaFightsWon.getValue() as int
		AddTextOption("Arena fights won", fights)
		String arenatitle = myScripts.SLV_GetArenaTitle()
		if(arenatitle != "")
			AddTextOption("Arena status", arenatitle)
		endif
	endif

	AddHeaderOption("Enslaved Cities")
	AddToggleOptionST("AutoProgressionState","Slavery autoprogession", AutoProgression )
	String enslavetext = "not set"
	Float enslavedate = StorageUtil.GetFloatValue(None, "SLV_EnslavingHours", 0.0 )
	if enslavedate != 0.0
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
		AddTextOption("Time left until next city enslavement",enslavetext)
		;MiscUtil.PrintConsole("Currentdate:" + currentdate)
	endif	
	
	if SlaverunQuest.getStage() >= 1000
		AddTextOption("Whiterun", "Yes" )
	else
		AddTextOption("Whiterun", "No" )
	endif
	if SlaverunQuest.getStage() >= 2000
		AddTextOption("Riverwood", "Yes" )
	else
		AddTextOption("Riverwood", "No" )
	endif
	if SlaverunQuest.getStage() >= 3000
		AddTextOption("Falkreath", "Yes" )
	else
		AddTextOption("Falkreath", "No" )
	endif
	if SlaverunQuest.getStage() >= 4000
		AddTextOption("Dawnstar", "Yes" )
	else
		AddTextOption("Dawnstar", "No" )
	endif
	if SlaverunQuest.getStage() >= 5000
		AddTextOption("Markarth", "Yes" )
	else
		AddTextOption("Markarth", "No" )
	endif
	if SlaverunQuest.getStage() >= 6000
		AddTextOption("Riften", "Yes" )
	else
		AddTextOption("Riften", "No" )
	endif
	if SlaverunQuest.getStage() >= 7000
		AddTextOption("Morthal", "Yes" )
	else
		AddTextOption("Morthal", "No" )
	endif
	if SlaverunQuest.getStage() >= 8000
		AddTextOption("Winterhold", "Yes" )
	else
		AddTextOption("Winterhold", "No" )
	endif
	if SlaverunQuest.getStage() >= 9000
		AddTextOption("Windhelm", "Yes" )
	else
		AddTextOption("Windhelm", "No" )
	endif
	if SlaverunQuest.getStage() >= 10000
		AddTextOption("Solitude", "Yes" )
	else
		AddTextOption("Solitude", "No" )
	endif
	if SlaverunQuest.getStage() >= 11000
		AddTextOption("Raven Rock", "Yes" )
	else
		AddTextOption("Raven Rock", "No" )
	endif
	
	AddHeaderOption("Follower:")
	AddToggleOptionST("FollowerScanState","Scan for Followers", FollowerScan)
	
	
	int i=0
	if followersCount > 0
		While (i < followersCount)
			Actor follower = followers[i]
			debug.trace("Follower:" + follower.GetLeveledActorBase().getName())
			if(follower.IsInFaction(SlaverunSlaveFaction))
				AddTextOption(follower.GetLeveledActorBase().getName(), "Slave" )
			else
				AddTextOption(follower.GetLeveledActorBase().getName(), "Free" )
			endif
			i = i + 1
		endWhile	
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

	AddHeaderOption("Sex Options")
	AddToggleOptionST("WillArousedMalesFuckPC","Aroused sex for player",ArousedMalesFuckPC)
	AddToggleOptionST("PCGangBangState","Player will be gangbanged",PCGangbang)
	AddSliderOptionST("PCGangBangProbabilityState","Probability for a gangbang",PCGangBangProbability,"{0}",Option_Flag_None)
	AddToggleOptionST("WillArousedMalesFuckSlaves","Aroused males call slaves for sex",ArousedMalesFuckSlaves)
	AddToggleOptionST("UseAggressiveFuckForSlaves","Use aggressive sex with slaves",AggressiveFuckForSlaves)
	AddToggleOptionST("UseAnalFuckForSlaves","Use anal sex with slaves",AnalFuckForSlaves)
	AddToggleOptionST("WillArousedMalesFuckFreeFemales","Aroused males call Free females for sex",ArousedMalesFuckFreeFemales)
	AddToggleOptionST("UseAggressiveFuckForFreeFemales","Use aggressive sex with Free Females",AggressiveFuckForFreeFemales)
	AddToggleOptionST("UseAnalFuckForFreeFemales","Use anal sex with Free Females",AnalFuckForFreeFemales)
	AddHeaderOption("Other options")
	AddToggleOptionST("WillTattleTale","Men report when player violates nudity law",TattleTales)
	AddToggleOptionST("DoAsThePlayerDoes","Female followers will mimic player",FemaleFollowersMimicPlayer)
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
	AddHeaderOption("For lazy fools like me")
	AddToggleOptionST("EnforcerAutomaticStripState","Enforcer automatically strips you",EnforcerAutomaticStrip)
EndFunction

Function PageShowProblems()
	AddHeaderOption("Test/Cheat options")
	AddToggleOptionST("CheatsEnabledState","Cheats enabled", CheatsEnabled )
	AddHeaderOption("Want to skip something?")
	AddToggleOptionST("SkipCreatureSexState","Skip creature sex", SkipCreatureSex )
	AddToggleOptionST("SkipSexScenesState","Skip sex act",SkipSexScenes)
	AddToggleOptionST("SkipScenesState","Skip scenes",SkipScenes)
	AddToggleOptionST("SkipWhippingState","Skip wippings",SkipWhipping)
	AddToggleOptionST("SkipDevicesState","Skip usage of all devious devices",SkipDevices)
	AddToggleOptionST("SkipDevicesForMenState","Skip usage of devious devices for men",SkipDevicesForMen)
	AddToggleOptionST("SkipBrandingState","Skip the long branding scene",SkipBranding)
	AddToggleOptionST("SkipAmputeeState","Skip amputations",SkipAmputee)
	AddHeaderOption("Press label to...")
	AddTextOptionST("PlayerControlState","Press here to enable playercontrol", "")
	AddTextOptionST("StartSlaveryState","Press here to enslave player", "")
	AddTextOptionST("EndSlaveryState","Press here to end slavery", "")
	AddTextOptionST("ResetSlaveryState","Press here to reset slavery", "")	
	AddTextOptionST("SkipQuestsState","Press here to enslave all Skyrim towns", "")
	AddTextOptionST("SetSlaveHaircutState","Press here to set original haircut", "")	
	AddTextOptionST("SetSlaveNameState","Press here to set original name", "")	
	AddTextOptionST("DoypsFashionShavingState","Press here to use ypsfashion shaving", "")	

	AddToggleOptionST("SkipIntensiveSexlabChecksState","Skip intensive sexlab checks",SkipIntensiveSexlabChecks)	

EndFunction

Function PageDevices()
	if !selectedActor
		selectedActor = game.getPlayer()
	endif
	AddHeaderOption("Manipulate Devious Devices")
	
	AddHeaderOption("Press label to add a devious device")
	
	AddTextOptionST("AddDDGagState","Gag", "")
	;AddTextOptionST("AddDDPlugsState","Plugs", "")
	;AddTextOptionST("AddDDHarnessState","Harness", "")
	;AddTextOptionST("AddDDBeltState","Chastity Belt", "")
	;AddTextOptionST("AddDDBraState","Chastity Bra", "")
	;AddTextOptionST("AddDDCollarState","Collar", "")
	;AddTextOptionST("AddDDCuffsState","Cuffs", "")
	;AddTextOptionST("AddDDArmbinderState","Armbinder", "")
	;AddTextOptionST("AddDDYokeState","Yoke", "")
	;AddTextOptionST("AddDDBlindfoldState","Blindfold", "")
	;AddTextOptionST("AddDDNPiercingsState","Nipple Piercings", "")
	;AddTextOptionST("AddDDVPiercingsState","Vagina Piercings", "")
	;AddTextOptionST("AddDDBootsState","Boots", "")
	;AddTextOptionST("AddDDGlovesState","Gloves", "")
	;AddTextOptionST("AddDDCorsetState","Corset", "")
	;AddTextOptionST("AddDDMittensState","Mittens", "")
	;AddTextOptionST("AddDDHoodState","Hood", "")
	;AddTextOptionST("AddDDClampsState","Nipple Clamps", "")
	;AddTextOptionST("AddDDSuitState","Suit", "")
	;AddTextOptionST("AddDDShacklesState","Shackles", "")
	;AddTextOptionST("AddDDHobblesSkirtState","HobblesSkirt", "")
	;AddTextOptionST("AddDDHobblesSkirtRelaxedState","HobblesSkirt Relaxed", "")
	
	SetCursorPosition(1)
	AddHeaderOption("For character: " + selectedActor.getActorBase().getName())
	AddHeaderOption("Press label to remove a devious device")
	AddTextOptionST("RemoveDDGagState","Gag", "")	
	;AddTextOptionST("RemoveDDPlugsState","Plugs", "")
	;AddTextOptionST("RemoveDDHarnessState","Harness", "")
	;AddTextOptionST("RemoveDDBeltState","Chastity Belt", "")
	;AddTextOptionST("RemoveDDBraState","Chastity Bra", "")
	;AddTextOptionST("RemoveDDCollarState","Collar", "")
	;AddTextOptionST("RemoveDDCuffsState","Cuffs", "")
	;AddTextOptionST("RemoveDDArmbinderState","Armbinder", "")
	;AddTextOptionST("RemoveDDYokeState","Yoke", "")
	;AddTextOptionST("RemoveDDBlindfoldState","Blindfold", "")
	;AddTextOptionST("RemoveDDNPiercingsState","Nipple Piercings", "")
	;AddTextOptionST("RemoveDDVPiercingsState","Vagina Piercings", "")
	;AddTextOptionST("RemoveDDBootsState","Boots", "")
	;AddTextOptionST("RemoveDDGlovesState","Gloves", "")
	;AddTextOptionST("RemoveDDCorsetState","Corset", "")
	;AddTextOptionST("RemoveDDMittensState","Mittens", "")
	;AddTextOptionST("RemoveDDHoodState","Hood", "")
	;AddTextOptionST("RemoveDDClampsState","Nipple Clamps", "")
	;AddTextOptionST("RemoveDDSuitState","Suit", "")
	;AddTextOptionST("RemoveDDShacklesState","Shackles", "")
	;AddTextOptionST("RemoveDDHobblesSkirtState","HobblesSkirt", "")
	;AddTextOptionST("RemoveDDHobblesSkirtRelaxedState","HobblesSkirt Relaxed", "")

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
	AddHeaderOption("Debug messages level 1")
	AddToggleOptionST("MT_Debug1Screen","Screen",MTDebug1Screen)
	AddToggleOptionST("MT_Debug1Console","Console",MTDebug1Console)
	AddToggleOptionST("MT_Debug1Log","Papyrus Log",MTDebug1Log)
	AddHeaderOption("Debug messages level 2")
	AddToggleOptionST("MT_Debug2Screen","Screen",MTDebug2Screen)
	AddToggleOptionST("MT_Debug2Console","Console",MTDebug2Console)
	AddToggleOptionST("MT_Debug2Log","Papyrus Log",MTDebug2Log)
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
	elseif (opt == npcoutfitOID)
		SetMenuDialogStartIndex(npcoutfit)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(NPCOutfitList)
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
	elseif (opt == npcoutfitOID)
		npcoutfit = index
		SetMenuOptionValue(opt, NPCOutfitList[npcoutfit])
	elseif (opt == npcoutfitcolorOID)
		npcoutfitcolor = index
		SetMenuOptionValue(opt, NPCOutfitColorList[npcoutfitcolor])
	endIf
endEvent

event OnOptionHighlight(int option)
	if (option == equipthemeOID)
		SetInfoText("Use when PC is forced in devious devices.")
	elseif (option == equipcolorOID)
		SetInfoText("Use when PC is forced in devious devices.")
	elseif (option == npcoutfitOID)
		SetInfoText("Use when NPC is forced in devious devices.")
	elseif (option == npcoutfitcolorOID)
		SetInfoText("Use when NPC is forced in devious devices.")
	elseif (option == sceneOID)
		SetInfoText("Enables the player controls in a hanging scene.")
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
	endIf
endEvent



;------------- State functions, these are called when a value is selected, changed or highlighted (moused over)
;------------- 		There will be one "state" for each MCM setting and three events

State AddDDGagState
	Event OnSelectST()
		;SLV_DeviousEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousEquipActor2(selectedActor,true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,false,false,false,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Equip a gag on the selected actor")
	EndEvent
EndState
State RemoveDDGagState
	Event OnSelectST()
		;SLV_DeviousUnEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousUnEquipActor2(selectedActor,true, false, false, false, false, false, false, false, false, false, false, false, false, false, false,false,false,false,false,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Remove a gag from the selected actor")
	EndEvent
EndState


State AddDDPlugsState
	Event OnSelectST()
		;SLV_DeviousEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousEquipActor2(selectedActor,false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false,false,false,false,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Equip plugs on the selected actor")
	EndEvent
EndState
State RemoveDDPlugsState
	Event OnSelectST()
		;SLV_DeviousUnEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousUnEquipActor2(selectedActor,false, true, false, false, false, false, false, false, false, false, false, false, false, false, false,false,false,false,false,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Remove plugs from the selected actor")
	EndEvent
EndState

State AddDDHarnessState
	Event OnSelectST()
		;SLV_DeviousEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousEquipActor2(selectedActor,false,false,true,false,false,false,false,false,false,false,false,false,false,false, false,false,false,false,false,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Equip Harness on the selected actor")
	EndEvent
EndState
State RemoveDDHarnessState
	Event OnSelectST()
		;SLV_DeviousUnEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousUnEquipActor2(selectedActor,false,false,true, false, false, false, false, false, false, false, false, false, false, false, false,false,false,false,false,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Remove Harness from the selected actor")
	EndEvent
EndState

State AddDDBeltState
	Event OnSelectST()
		;SLV_DeviousEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousEquipActor2(selectedActor,false, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false,false,false,false,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Equip a Belt on the selected actor")
	EndEvent
EndState
State RemoveDDBeltState
	Event OnSelectST()
		;SLV_DeviousUnEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousUnEquipActor2(selectedActor,false, false, false, true, false, false, false, false, false, false, false, false, false, false, false,false,false,false,false,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Remove a Belt from the selected actor")
	EndEvent
EndState

State AddDDBraState
	Event OnSelectST()
		;SLV_DeviousEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousEquipActor2(selectedActor,false, false, false, false, true, false, false, false, false, false, false, false, false, false, false, false,false,false,false,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Equip a Bra on the selected actor")
	EndEvent
EndState
State RemoveDDBraState
	Event OnSelectST()
		;SLV_DeviousUnEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousUnEquipActor2(selectedActor,false, false, false, false, true, false, false, false, false, false, false, false, false, false, false,false,false,false,false,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Remove a Bra from the selected actor")
	EndEvent
EndState

State AddDDCollarState
	Event OnSelectST()
		;SLV_DeviousEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousEquipActor2(selectedActor,false, false, false, false, false, true, false, false, false, false, false, false, false, false, false, false,false,false,false,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Equip a Collar on the selected actor")
	EndEvent
EndState
State RemoveDDCollarState
	Event OnSelectST()
		;SLV_DeviousUnEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousUnEquipActor2(selectedActor,false, false, false, false, false, true, false, false, false, false, false, false, false, false, false,false,false,false,false,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Remove a Collar from the selected actor")
	EndEvent
EndState

State AddDDCuffsState
	Event OnSelectST()
		;SLV_DeviousEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousEquipActor2(selectedActor,false, false, false, false, false, false, true, false, false, false, false, false, false, false, false, false,false,false,false,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Equip Cuffs on the selected actor")
	EndEvent
EndState
State RemoveDDCuffsState
	Event OnSelectST()
		;SLV_DeviousUnEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousUnEquipActor2(selectedActor,false, false, false, false, false, false, true, false, false, false, false, false, false, false, false,false,false,false,false,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Remove Cuffs from the selected actor")
	EndEvent
EndState

State AddDDArmbinderState
	Event OnSelectST()
		;SLV_DeviousEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousEquipActor2(selectedActor,false,false,false,false,false,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Equip a Armbinder on the selected actor")
	EndEvent
EndState
State RemoveDDArmbinderState
	Event OnSelectST()
		;SLV_DeviousUnEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousUnEquipActor2(selectedActor,false,false,false,false,false,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Remove a Armbinder from the selected actor")
	EndEvent
EndState

State AddDDYokeState
	Event OnSelectST()
		;SLV_DeviousEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousEquipActor2(selectedActor,false,false,false,false,false,false,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Equip a Yoke on the selected actor")
	EndEvent
EndState
State RemoveDDYokeState
	Event OnSelectST()
		;SLV_DeviousUnEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousUnEquipActor2(selectedActor,false,false,false,false,false,false,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Remove a Yoke from the selected actor")
	EndEvent
EndState

State AddDDBlindfoldState
	Event OnSelectST()
		;SLV_DeviousEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousEquipActor2(selectedActor,false,false,false,false,false,false,false,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Equip a Blindfold on the selected actor")
	EndEvent
EndState
State RemoveDDBlindfoldState
	Event OnSelectST()
		;SLV_DeviousUnEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousUnEquipActor2(selectedActor,false,false,false,false,false,false,false,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Remove a Blindfold from the selected actor")
	EndEvent
EndState

State AddDDNPiercingsState
	Event OnSelectST()
		;SLV_DeviousEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousEquipActor2(selectedActor,false,false,false,false,false,false,false,false,false,false,true,false,false,false,false,false,false,false,false,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Equip Nipple Piercings on the selected actor")
	EndEvent
EndState
State RemoveDDNPiercingsState
	Event OnSelectST()
		;SLV_DeviousUnEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousUnEquipActor2(selectedActor,false,false,false,false,false,false,false,false,false,false,true,false,false,false,false,false,false,false,false,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Remove Nipple Piercings from the selected actor")
	EndEvent
EndState

State AddDDVPiercingsState
	Event OnSelectST()
		;SLV_DeviousEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousEquipActor2(selectedActor,false,false,false,false,false,false,false,false,false,false,false,true,false,false,false,false,false,false,false,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Equip Vagina Piercings on the selected actor")
	EndEvent
EndState
State RemoveDDVPiercingsState
	Event OnSelectST()
		;SLV_DeviousUnEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousUnEquipActor2(selectedActor,false,false,false,false,false,false,false,false,false,false,false,true,false,false,false,false,false,false,false,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Remove Vagina Piercings from the selected actor")
	EndEvent
EndState

State AddDDBootsState
	Event OnSelectST()
		;SLV_DeviousEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousEquipActor2(selectedActor,false,false,false,false,false,false,false,false,false,false,false,false,true,false,false,false,false,false,false,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Equip Boots on the selected actor")
	EndEvent
EndState
State RemoveDDBootsState
	Event OnSelectST()
		;SLV_DeviousUnEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousUnEquipActor2(selectedActor,false,false,false,false,false,false,false,false,false,false,false,false,true,false,false,false,false,false,false,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Remove Boots from the selected actor")
	EndEvent
EndState

State AddDDGlovesState
	Event OnSelectST()
		;SLV_DeviousEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousEquipActor2(selectedActor,false,false,false,false,false,false,false,false,false,false,false,false,false,true,false,false,false,false,false,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Equip Gloves on the selected actor")
	EndEvent
EndState
State RemoveDDGlovesState
	Event OnSelectST()
		;SLV_DeviousUnEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousUnEquipActor2(selectedActor,false,false,false,false,false,false,false,false,false,false,false,false,false,true,false,false,false,false,false,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Remove Gloves from the selected actor")
	EndEvent
EndState

State AddDDCorsetState
	Event OnSelectST()
		;SLV_DeviousEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousEquipActor2(selectedActor,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true,false,false,false,false,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Equip Corset on the selected actor")
	EndEvent
EndState
State RemoveDDCorsetState
	Event OnSelectST()
		;SLV_DeviousUnEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousUnEquipActor2(selectedActor,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true,false,false,false,false,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Remove Corset from the selected actor")
	EndEvent
EndState

State AddDDMittensState
	Event OnSelectST()
		;SLV_DeviousEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousEquipActor2(selectedActor,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true,false,false,false,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Equip Mittens on the selected actor")
	EndEvent
EndState
State RemoveDDMittensState
	Event OnSelectST()
		;SLV_DeviousUnEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousUnEquipActor2(selectedActor,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true,false,false,false,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Remove Mittens from the selected actor")
	EndEvent
EndState

State AddDDHoodState
	Event OnSelectST()
		;SLV_DeviousEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousEquipActor2(selectedActor,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true,false,false,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Equip Hood on the selected actor")
	EndEvent
EndState
State RemoveDDHoodState
	Event OnSelectST()
		;SLV_DeviousUnEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousUnEquipActor2(selectedActor,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true,false,false,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Remove Hood from the selected actor")
	EndEvent
EndState

State AddDDClampsState
	Event OnSelectST()
		;SLV_DeviousEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousEquipActor2(selectedActor,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true,false,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Equip Nipple Clamps on the selected actor")
	EndEvent
EndState
State RemoveDDClampsState
	Event OnSelectST()
		;SLV_DeviousUnEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousUnEquipActor2(selectedActor,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true,false,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Remove Nipple Clamps from the selected actor")
	EndEvent
EndState

State AddDDSuitState
	Event OnSelectST()
		;SLV_DeviousEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousEquipActor2(selectedActor,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Equip Suit on the selected actor")
	EndEvent
EndState

State RemoveDDSuitState
	Event OnSelectST()
		;SLV_DeviousUnEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousUnEquipActor2(selectedActor,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true,false,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Remove Suit from the selected actor")
	EndEvent
EndState

State AddDDShacklesState
	Event OnSelectST()
		;SLV_DeviousEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousEquipActor2(selectedActor,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Equip Shackles on the selected actor")
	EndEvent
EndState

State RemoveDDShacklesState
	Event OnSelectST()
		;SLV_DeviousUnEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousUnEquipActor2(selectedActor,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true,false,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Remove Shackles from the selected actor")
	EndEvent
EndState

State AddDDHobblesSkirtState
	Event OnSelectST()
		;SLV_DeviousEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousEquipActor2(selectedActor,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Equip Hobbles Skirt on the selected actor")
	EndEvent
EndState

State RemoveDDHobblesSkirtState
	Event OnSelectST()
		;SLV_DeviousUnEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousUnEquipActor2(selectedActor,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true,false)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Remove Hobbles Skirt from the selected actor")
	EndEvent
EndState

State AddDDHobblesSkirtRelaxedState
	Event OnSelectST()
		;SLV_DeviousEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousEquipActor2(selectedActor,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Equip HobblesSkirt Relaxed on the selected actor")
	EndEvent
EndState
State RemoveDDHobblesSkirtRelaxedState
	Event OnSelectST()
		;SLV_DeviousUnEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)
		
		defaultActor()
		myScripts.SLV_DeviousUnEquipActor2(selectedActor,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true)
		Debug.MessageBox("Done.")
	endEvent
	Event OnHighlightST()
		SetInfoText("Remove HobblesSkirt Relaxed from the selected actor")
	EndEvent
EndState


Function defaultActor()
if !selectedActor
	selectedActor = game.getPlayer()
endif
endFunction


State BreastGrowingState
	event OnSelectST()
		BreastGrowing= !BreastGrowing
		SetToggleOptionValueST(BreastGrowing)
	endEvent
	event OnDefaultST()
		BreastGrowing=true
	endEvent
	event OnHighlightST()
		SetInfoText("During slavery your breasts will grow.")
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
		SetInfoText("Breast will grow be increase player weight (probably bodyslide required).")
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
        SetSliderDialogInterval(0.1)
	EndEvent
	Event OnSliderAcceptST(float value)
		BreastSLIFSize = value
		SetSliderOptionValueSt( BreastSLIFSize,"{1}")
		
		myScripts.SLV_InflationFramework(BreastSLIFSize)
	EndEvent
	Event OnDefaultST()
		BreastSLIFSize=1.0
		SetSliderOptionValueSt( BreastSLIFSize,"{1}")
		
		myScripts.SLV_InflationFramework(BreastSLIFSize)
	EndEvent
	Event OnHighlightST()
		SetInfoText("The current breast size which will be send to Sexlab Inflation Framework.")
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
		SLV_WhiterunMaxTask.setvalue(maxTasks)
	EndEvent
	Event OnDefaultST()
		maxTasks=3
		SetSliderOptionValueSt( maxTasks as Float,"{0}")
	EndEvent
	Event OnHighlightST()
		SetInfoText("How many repetions are necessary to complete for task.")
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

State PCGangBangProbabilityState
	Event OnSliderOpenST()
        SetSliderDialogStartValue(PCGangBangProbability as Float)
        SetSliderDialogDefaultValue(90.0)
        SetSliderDialogRange(0.0, 100.0)
        SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		PCGangBangProbability = value as Int
		SetSliderOptionValueSt(PCGangBangProbability as Float,"{0}")
	EndEvent
	Event OnDefaultST()
		PCGangBangProbability = 90
		SetSliderOptionValueSt(PCGangBangProbability as Float,"{0}")
	EndEvent
	Event OnHighlightST()
		SetInfoText("Probability the enforcer will let the player be gangbanged.")
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
		AutoProgression = false
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
		CombatPausesEnforcer = false
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
		WhippingSound = false
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
	endEvent
	event OnDefaultST()
		ForceReporting = true
	endEvent
	event OnHighlightST()
		SetInfoText("Activate this option to force the player to report back to Bellamy or be punished for failing.")
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


State SkipQuestsState
	Event OnSelectST()
		Debug.notification("Slavery quests skipped, all Skyrim is enslaved")
		SendModEvent("SlaverunReloaded_SkipSlaveQuests")
		Debug.MessageBox("Slavery has come to all of Skyrim now.")
	endEvent
	
	Event OnHighlightST()
		SetInfoText("Click here to skip all quests and put all Skyrim towns in slavery.")
	EndEvent	
EndState

State SetSlaveHaircutState
	Event OnSelectST()
		Debug.notification("Slave haircut set")
		
		String actualhair = ""
		Actor akActor = Game.GetPlayer()

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
		
		shaveScripts.Shave(Game.GetPlayer())
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
		
		Actor akActor = Game.GetPlayer()
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
		SetInfoText("This is time in days cities will be enslaved for free woman.")
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
		NudityPunishment= false
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
		NudityRescue= false
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
		NudityEnslavement= false
	endEvent
	event OnHighlightST()
		SetInfoText("As a free woman you will be enslaved, as a slave you will be punished by the Slave Master.")
	endEvent
EndState



