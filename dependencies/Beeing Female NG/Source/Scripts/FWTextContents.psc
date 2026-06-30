Scriptname FWTextContents extends Quest

function IOReadTranslation(string Langauge) global native
string function getLangText(string VarName) global native
int function getLangSize() global native
int function getErrorCode() global native
string function getFilePath() global native



string property NPCCameInsideNPC = "{0} came inside {1}" auto hidden
string property NPCCameInsideYou = "{0} came inside you" auto hidden
string property YouCameInsideNPC = "You came inside {0}" auto hidden

string property InstallComplete auto hidden;BeeingFemale installed
string property LoadingComplete auto hidden;BeeingFemale loaded
string property UpdateComplete auto hidden;Beeing Female updated
string property InitBF auto hidden;Init BeeingFemale - This may take a while
string property FixProblem auto hidden;Problem will be fixed
string property Updated = "BeeingFemale updated to version {0}" auto hidden
string property UninstallComplete = "Beeing Female was uninstalled. To finish the uninstall process, create a Savegame and restart Skyrim" auto

string property YourPantys = "Your pantys are bloody" auto hidden
string property NPCPantys = "{0}s pantys are bloody" auto hidden

string property YourTampon = "Your tampon is bloody" auto hidden
string property NPCTampon = "{0}s tampon is bloody" auto hidden

string property NPCIsPregnant = "{0} is pregnant" auto hidden
string property YouArePregnant = "You are pregnant" auto hidden

string property NoBeeingFemaleSpell = "{0} doesn't have the BeeingFemale spell" auto hidden
string property NoBeeingMaleSpell = "{0} doesn't have the BeeingMale spell" auto hidden

string property YourPregnantWaterBreaks = "Your pregnant water breaks" auto hidden
string property NPCPregnantWaterBreaks = "{0}'s pregnant water breaks" auto hidden
string property NPCBornHealthyBoy = "{0} has born a healthy little boy" auto hidden
string property NPCBornHealthyGirl = "{0} has born a healthy little girl" auto hidden
string property NPCFatherBornHealthyBoy = "You became father\n{0} has born a healthy little boy" auto hidden
string property NPCFatherBornHealthyGirl = "You became father\n{0} has born a healthy little girl" auto hidden
string property YouBornHealthyBoy = "You have born a healthy little boy" auto hidden
string property YouBornHealthyGirl = "You have born a healthy little girl" auto hidden

string property BeeingFemaleCastedOn = "BeeingFemale casted on {0}" auto hidden
string property BeeingFemaleMissedOn = "BeeingFemale failed on {0}" auto hidden
string property BeeingFemaleMissedOn1 = "BeeingFemale failed on {0} - Child, Dead, Male or NonUnique" auto hidden
string property BeeingFemaleMissedOn2 = "BeeingFemale failed on {0} - NPC Menstruation deactivated" auto hidden

string property AlcoholNotGoodForYourBaby = "Alcohol and drugs are harmful to your baby's health." auto hidden
string property AlcoholNotGoodForNPCBaby = "Alcohol and drugs are harmful to {0}'s baby's health." auto hidden

string property StateNotFound = "The state {0} couldn't be found" auto hidden
string property Compatiblity_Reset = "The compatiblity was reseted" auto hidden

string property YouHaveLostYourChild = "You have lost your child" auto hidden
string property NPCHasLostItsChild = "{0} has lost her child" auto hidden

string property AddOnRaceRemoved = "Race AddOn '{0}' has been removed" auto hidden
string property AddOnPMSRemoved = "PMS AddOn '{0}' has been removed" auto hidden
string property AddOnMiscRemoved = "Misc AddOn '{0}' has been removed" auto hidden
string property AddOnCMERemoved = "CME AddOn '{0}' has been removed" auto hidden
string property AddOnRaceRemovedCount = "{0} Race AddOns has been removed" auto hidden
string property AddOnPMSRemovedCount = "{0} PMS AddOns has been removed" auto hidden
string property AddOnMiscRemovedCount = "{0} Misc AddOns has been removed" auto hidden
string property AddOnCMERemovedCount = "{0} CME AddOns has been removed" auto hidden
string property AddOnRaceInit = "Init Race AddOn: {0} - {1}" auto hidden
string property AddOnPMSInit = "Init PMS AddOn: {0}" auto hidden
string property AddOnCMEInit = "Init CME AddOn: {0}" auto hidden
string property AddOnMiscInit = "Init Misc AddOn: {0}" auto hidden
string property AddOnRaceInitSimple = "Init Race AddOn: {0}" auto hidden

string property EstrusCharusFound = "BeeingFemale has located Estrus Chaurus" auto hidden
string property RaceSwitchedCompleted = "Race-Switched" auto hidden

string property StatesAddedForNPC = "{0} states were added to {1} ({2})" auto hidden

string property Day = "{0} Day" auto hidden
string property Days = "{0} Days" auto hidden
string property Hour = "{0} Hour" auto hidden
string property Hours = "{0} Hours" auto hidden
string property Minute = "{0} Minute" auto hidden
string property Minutes = "{0} Minutes" auto hidden
string property Day_Short = "{0}d" auto hidden
string property Hour_Short = "{0}h" auto hidden
string property Minute_Short = "{0}m" auto hidden

string property StateID0 = "Follicular Phase" auto hidden
string property StateID1 = "Ovulating" auto hidden
string property StateID2 = "Luteal Phase" auto hidden
string property StateID3 = "Menstruating" auto hidden
string property StateID4 = "1st Trimester" auto hidden
string property StateID5 = "2nd Trimester" auto hidden
string property StateID6 = "3rd Trimester" auto hidden
string property StateID7 = "Labor pains" auto hidden
string property StateID8 = "Replenish from birth" auto hidden
string property StateID20 = "Pregnant" auto hidden ; Handels pregnacy from other mods
string property StateID21 = "Pregnant by chaurus" auto hidden ; Handels pregnacy from Estrus Chaurus
string property StateUnknown = "Unknown" auto hidden

string property ForbiddenReason1 = "{0} is forbidden" auto hidden
string property ForbiddenReason2 = "{0} is dead" auto hidden
string property ForbiddenReason3 = "{0} is {1}" auto hidden
string property ForbiddenReason4 = "{0} is not a unique character" auto hidden
string property ForbiddenReason5 = "Player is disabled" auto hidden
string property ForbiddenReason6 = "Follower are forbidden" auto hidden
string property ForbiddenReason7 = "NPCs are forbidden" auto hidden
string property ForbiddenReason8 = "{0} is a child" auto hidden
string property ForbiddenReason9 = "{0} is an elder" auto hidden
string property ForbiddenReason10 = "{0} is an elder" auto hidden
string property ForbiddenReason11 = "{0} is an elder" auto hidden

; Female info
string property InfoSpell_GotSpermInside="{0} got some sperm inside" auto hidden
string property InfoSpell_GotNoSpermInside="{0} got no sperm inside" auto hidden
string property InfoSpell_GotYourSpermInside="{0} have sperm from you inside" auto hidden
string property InfoSpell_GotOneSpermInside="{0} have sperm from one man inside" auto hidden
string property InfoSpell_GotMoreSpermInside="{0} have sperm from {1} man inside" auto hidden
string property InfoSpell_CurrentState="Current state: {0}" auto hidden
string property InfoSpell_StateSince="since {0}" auto hidden
string property InfoSpell_StateDuration="State duration: {0}" auto hidden
string property InfoSpell_LooksPregnant="Looks pregnant: {0}" auto hidden
string property InfoSpell_IsPregnant="Is pregnant: {0}" auto hidden
string property InfoSpell_CanBecomePregnant="Can become pregnant this cycle: {0}" auto hidden
string property InfoSpell_PregnantWithNumOfBabys="Pregnant with {0} babys" auto hidden
string property InfoSpell_UnbornBabyHealth="Unborn babys health: {0}%" auto hidden
string property InfoSpell_UnbornBabiesHealth="Unborn babies health: {0}%" auto hidden
string property InfoSpell_Contraception="Contraception: {0}" auto hidden
string property InfoSpell_LastContraception="Last contraception medicine: {0}" auto hidden
string property InfoSpell_SpermNames="Got sperm inside from:\n{0}" auto hidden
; Male info
string property InfoSpell_GotSpermInWoman="Got some sperm inside a woman" auto hidden
string property InfoSpell_GotNoSpermInWoman="Got no sperm inside any woman" auto hidden
string property InfoSpell_GotNumSpermInWoman="{0} got some sperm in {1} women" auto hidden
string property InfoSpell_CameInsideYou="{0} came inside you" auto hidden
string property InfoSpell_CameInsideWoman="{0} came inside women: {1}" auto hidden
string property InfoSpell_CameInsideNames="{0} came inside those women:\n{1}" auto hidden
string property InfoSpell_ImpregnatedYou="{0} impregnated you: {1}" auto hidden
string property InfoSpell_ImpregnatedAnyWoman="{0} impregnated any woman" auto hidden
string property InfoSpell_ImpregnatedWoman="{0} impregnated those {1} women: {2}" auto hidden
string property InfoSpell_ImpregnatedNumWoman="{0} impregnated {1} women" auto hidden
string property InfoSpell_SpermVirility="Sperm virility at {0}" auto hidden

string property InfoSpell_Yes="Yes" auto hidden
string property InfoSpell_No="No" auto hidden
string property InfoSpell_NotAnymore="Not anymore" auto hidden
string property InfoSpell_You="You" auto hidden
string property InfoSpell_AndYou="and from you" auto hidden
string property InfoSpell_Male="male" auto hidden
string property InfoSpell_Female="female" auto hidden
string property InfoSpell_He="He" auto hidden
string property InfoSpell_She="She" auto hidden
string property InfoSpell_Overdue="Overdue" auto hidden


string property InfoSpell_ChildParents auto hidden
string property InfoSpell_ChildFatherIs auto hidden
string property InfoSpell_ChildMotherIs auto hidden
string property InfoSpell_UnknownParents auto hidden
string property InfoSpell_UnknownParent auto hidden
string property InfoSpell_ChildWasBorn auto hidden
string property InfoSpell_ChildVampire auto hidden
string property InfoSpell_ChildFollows auto hidden
string property InfoSpell_ChildGotOrder auto hidden
string property InfoSpell_ChildOrder00 auto hidden
string property InfoSpell_ChildOrder01 auto hidden
string property InfoSpell_ChildOrder02 auto hidden
string property InfoSpell_ChildOrder03 auto hidden
string property InfoSpell_ChildOrder04 auto hidden
string property InfoSpell_ChildOrder05 auto hidden
string property InfoSpell_ChildOrder06 auto hidden

string property ChildLevelUp auto hidden
string property SpermAdded auto hidden
string property CheckGiveSperm auto hidden
string property NoChildArmor auto hidden;No Child-Armor found
string property NoChildItem auto hidden;No Child-Item found
string property BabyBlankName auto hidden;[Baby]
string property BabyName auto hidden;Baby - [1] [2]

; Requirement Check
string property Req_BF auto hidden;BeeingFemale - Check requirements
string property Req_Skyrim auto hidden;Your Skyrim Version is outdated.\nYou must install the latest Skyrim version first.\nBeeingFemale will be disabled!\n\nBetter exit Skyrim to prevent massive Error-Logging
string property Req_SKSE auto hidden;SKSE is not installed.\nYou must install SKSE first.\nBeeingFemale will be disabled!\n\nBetter exit Skyrim to prevent massive Error-Logging
string property Req_SKSEScript auto hidden;Your SKSE version is incompatible.\nPlease install the latest SKSE version.\nBeeingFemale will be disabled!\n\nBetter exit Skyrim to prevent massive Error-Logging
string property Req_PapyrusUtil auto hidden;PapyrusUtil is not installed.\nYou must install PapyrusUtil or a mod that contains PapyrusUtil first.\nBeeingFemale will be disabled!\n\nBetter exit Skyrim to prevent massive Error-Logging
string property Req_PlayerNotFoundOnRef auto hidden;Player was not found in ReferenceAlias!
string property Req_BeeingFemaleNative auto hidden;
string property Req_BeeingFemaleNativeUpdate auto hidden

string property FNISNotInstalled auto hidden
string property FNISOverdue auto hidden
string property FNISUsing auto hidden
string property FNISTXTNotInstalled auto hidden
string property FNISTXTOverdue auto hidden

string property SwitchState auto hidden
string property ActorHasContraception auto hidden
string property BabyHealth auto hidden
string property ActorNotPregnant auto hidden


string property EstrusSpiderFound = "BeeingFemale has located Estrus Spider" auto hidden
string property EstrusDwemerFound = "BeeingFemale has located Estrus Dwemer" auto hidden

function Upgrade(int oldVersion, int newVersion)
endFunction

function LoadContent()
	FW_log.WriteLog("FWTextContents::LoadContent()")
	string Language = Utility.GetINIString("sLanguage:General")	
	string LanguageFile = ""
	FW_log.WriteLog("FWTextContents::LoadContent() - " + Language)
	IOReadTranslation(Language)
	FW_log.WriteLog("FWTextContents::LoadContent() - Content loaded")
	int size=getLangSize()
	FW_log.WriteLog("FWTextContents::LoadContent() - TextContent Size = "+size)
	FW_log.WriteLog("FWTextContents::LoadContent() - Load in variable content")
	
	NPCCameInsideNPC = getLangText("GAME_CONTENT_NPCCameInsideNPC")
	NPCCameInsideYou = getLangText("GAME_CONTENT_NPCCameInsideYou")
	YouCameInsideNPC = getLangText("GAME_CONTENT_YouCameInsideNPC")
	
	InstallComplete = getLangText("GAME_CONTENT_InstallComplete")
	LoadingComplete = getLangText("GAME_CONTENT_LoadingComplete")
	UpdateComplete = getLangText("GAME_CONTENT_UpdateComplete")
	InitBF = getLangText("GAME_CONTENT_InitBF")
	FixProblem = getLangText("GAME_CONTENT_FixProblem")
	Updated = getLangText("GAME_CONTENT_Updated")
	UninstallComplete = getLangText("GAME_CONTENT_UninstallComplete")

	YourPantys = getLangText("GAME_CONTENT_YourPantys")
	NPCPantys = getLangText("GAME_CONTENT_NPCPantys")

	YourTampon = getLangText("GAME_CONTENT_YourTampon")
	NPCTampon = getLangText("GAME_CONTENT_NPCTampon")
	
	NPCIsPregnant = getLangText("GAME_CONTENT_NPCIsPregnant")
	YouArePregnant = getLangText("GAME_CONTENT_YouArePregnant")

	NoBeeingFemaleSpell = getLangText("GAME_CONTENT_NoBeeingFemaleSpell")
	NoBeeingMaleSpell = getLangText("GAME_CONTENT_NoBeeingMaleSpell")
	
	YourPregnantWaterBreaks = getLangText("GAME_CONTENT_YourPregnantWaterBreaks")
	NPCPregnantWaterBreaks = getLangText("GAME_CONTENT_NPCPregnantWaterBreaks")
	NPCBornHealthyBoy = getLangText("GAME_CONTENT_NPCBornHealthyBoy")
	NPCBornHealthyGirl = getLangText("GAME_CONTENT_NPCBornHealthyGirl")
	NPCFatherBornHealthyBoy = getLangText("GAME_CONTENT_NPCFatherBornHealthyBoy")
	NPCFatherBornHealthyGirl = getLangText("GAME_CONTENT_NPCFatherBornHealthyGirl")
	YouBornHealthyBoy = getLangText("GAME_CONTENT_YouBornHealthyBoy")
	YouBornHealthyGirl = getLangText("GAME_CONTENT_YouBornHealthyGirl")

	BeeingFemaleCastedOn = getLangText("GAME_CONTENT_BeeingFemaleCastedOn")
	BeeingFemaleMissedOn = getLangText("GAME_CONTENT_BeeingFemaleMissedOn")
	BeeingFemaleMissedOn1 = getLangText("GAME_CONTENT_BeeingFemaleMissedOn1")
	BeeingFemaleMissedOn2 = getLangText("GAME_CONTENT_BeeingFemaleMissedOn2")

	AlcoholNotGoodForYourBaby = getLangText("GAME_CONTENT_AlcoholNotGoodForYourBaby")
	AlcoholNotGoodForNPCBaby = getLangText("GAME_CONTENT_AlcoholNotGoodForNPCBaby")

	StateNotFound = getLangText("GAME_CONTENT_StateNotFound")
	Compatiblity_Reset = getLangText("GAME_CONTENT_Compatiblity_Reset")

	YouHaveLostYourChild = getLangText("GAME_CONTENT_YouHaveLostYourChild")
	NPCHasLostItsChild = getLangText("GAME_CONTENT_NPCHasLostItsChild")

	AddOnRaceRemoved = getLangText("GAME_CONTENT_AddOnRaceRemoved")
	AddOnPMSRemoved = getLangText("GAME_CONTENT_AddOnPMSRemoved")
	AddOnMiscRemoved = getLangText("GAME_CONTENT_AddOnMiscRemoved")
	AddOnCMERemoved = getLangText("GAME_CONTENT_AddOnCMERemoved")
	AddOnRaceRemovedCount = getLangText("GAME_CONTENT_AddOnRaceRemovedCount")
	AddOnPMSRemovedCount = getLangText("GAME_CONTENT_AddOnPMSRemovedCount")
	AddOnMiscRemovedCount = getLangText("GAME_CONTENT_AddOnMiscRemovedCount")
	AddOnCMERemovedCount = getLangText("GAME_CONTENT_AddOnCMERemovedCount")
	AddOnRaceInit = getLangText("GAME_CONTENT_AddOnRaceInit")
	AddOnPMSInit = getLangText("GAME_CONTENT_AddOnPMSInit")
	AddOnCMEInit = getLangText("GAME_CONTENT_AddOnCMEInit")
	AddOnMiscInit = getLangText("GAME_CONTENT_AddOnMiscInit")
	AddOnRaceInitSimple = getLangText("GAME_CONTENT_AddOnRaceInitSimple")

	EstrusCharusFound = getLangText("GAME_CONTENT_EstrusCharusFound")
	RaceSwitchedCompleted = getLangText("GAME_CONTENT_RaceSwitchedCompleted")


	EstrusSpiderFound = getLangText("GAME_CONTENT_EstrusSpiderFound")
	EstrusDwemerFound = getLangText("GAME_CONTENT_EstrusDwemerFound")


	StatesAddedForNPC = getLangText("GAME_CONTENT_StatesAddedForNPC")

	Day = getLangText("GAME_CONTENT_Day")
	Days = getLangText("GAME_CONTENT_Days")
	Hour = getLangText("GAME_CONTENT_Hour")
	Hours = getLangText("GAME_CONTENT_Hours")
	Minute = getLangText("GAME_CONTENT_Minute")
	Minutes = getLangText("GAME_CONTENT_Minutes")
	Day_Short = getLangText("GAME_CONTENT_Day_Short")
	Hour_Short = getLangText("GAME_CONTENT_Hour_Short")
	Minute_Short = getLangText("GAME_CONTENT_Minute_Short")

	StateID0 = getLangText("GAME_CONTENT_StateID0")
	StateID1 = getLangText("GAME_CONTENT_StateID1")
	StateID2 = getLangText("GAME_CONTENT_StateID2")
	StateID3 = getLangText("GAME_CONTENT_StateID3")
	StateID4 = getLangText("GAME_CONTENT_StateID4")
	StateID5 = getLangText("GAME_CONTENT_StateID5")
	StateID6 = getLangText("GAME_CONTENT_StateID6")
	StateID7 = getLangText("GAME_CONTENT_StateID7")
	StateID8 = getLangText("GAME_CONTENT_StateID8")
	StateID20 = getLangText("GAME_CONTENT_StateID20") ; Handels pregnacy from other mods
	StateID21 = getLangText("GAME_CONTENT_StateID21") ; Handels pregnacy from Estrus Chaurus
	StateUnknown = getLangText("GAME_CONTENT_StateUnknown")

	ForbiddenReason1 = getLangText("FW_INFOWINDOW_ForbiddenReason1")
	ForbiddenReason2 = getLangText("FW_INFOWINDOW_ForbiddenReason2")
	ForbiddenReason3 = getLangText("FW_INFOWINDOW_ForbiddenReason3")
	ForbiddenReason4 = getLangText("FW_INFOWINDOW_ForbiddenReason4")
	ForbiddenReason5 = getLangText("FW_INFOWINDOW_ForbiddenReason5")
	ForbiddenReason6 = getLangText("FW_INFOWINDOW_ForbiddenReason6")
	ForbiddenReason7 = getLangText("FW_INFOWINDOW_ForbiddenReason7")
	ForbiddenReason8 = getLangText("FW_INFOWINDOW_ForbiddenReason8")
	ForbiddenReason9 = getLangText("FW_INFOWINDOW_ForbiddenReason9")
	ForbiddenReason10 = getLangText("FW_INFOWINDOW_ForbiddenReason10")
	ForbiddenReason11 = getLangText("FW_INFOWINDOW_ForbiddenReason11")

; Female info
	InfoSpell_GotSpermInside = getLangText("GAME_CONTENT_InfoSpell_GotSpermInside")
	InfoSpell_GotNoSpermInside = getLangText("GAME_CONTENT_InfoSpell_GotNoSpermInside")
	InfoSpell_GotYourSpermInside = getLangText("GAME_CONTENT_InfoSpell_GotYourSpermInside")
	InfoSpell_GotOneSpermInside = getLangText("GAME_CONTENT_InfoSpell_GotOneSpermInside")
	InfoSpell_GotMoreSpermInside = getLangText("GAME_CONTENT_InfoSpell_GotMoreSpermInside")
	InfoSpell_CurrentState = getLangText("GAME_CONTENT_InfoSpell_CurrentState")
	InfoSpell_StateSince = getLangText("GAME_CONTENT_InfoSpell_StateSince")
	InfoSpell_StateDuration = getLangText("GAME_CONTENT_InfoSpell_StateDuration")
	InfoSpell_LooksPregnant = getLangText("GAME_CONTENT_InfoSpell_LooksPregnant")
	InfoSpell_IsPregnant = getLangText("GAME_CONTENT_InfoSpell_IsPregnant")
	InfoSpell_CanBecomePregnant = getLangText("GAME_CONTENT_InfoSpell_CanBecomePregnant")
	InfoSpell_PregnantWithNumOfBabys = getLangText("GAME_CONTENT_InfoSpell_PregnantWithNumOfBabys")
	InfoSpell_UnbornBabyHealth = getLangText("GAME_CONTENT_InfoSpell_UnbornBabyHealth")
	InfoSpell_UnbornBabiesHealth = getLangText("GAME_CONTENT_InfoSpell_UnbornBabiesHealth")
	InfoSpell_Contraception = getLangText("GAME_CONTENT_InfoSpell_Contraception")
	InfoSpell_LastContraception = getLangText("GAME_CONTENT_InfoSpell_LastContraception")
	InfoSpell_SpermNames = getLangText("GAME_CONTENT_InfoSpell_SpermNames")
; Male info
	InfoSpell_GotSpermInWoman = getLangText("GAME_CONTENT_InfoSpell_GotSpermInWoman")
	InfoSpell_GotNoSpermInWoman = getLangText("GAME_CONTENT_InfoSpell_GotNoSpermInWoman")
	InfoSpell_GotNumSpermInWoman = getLangText("GAME_CONTENT_InfoSpell_GotNumSpermInWoman")
	InfoSpell_CameInsideYou = getLangText("GAME_CONTENT_InfoSpell_CameInsideYou")
	InfoSpell_CameInsideWoman = getLangText("GAME_CONTENT_InfoSpell_CameInsideWoman")
	InfoSpell_CameInsideNames = getLangText("GAME_CONTENT_InfoSpell_CameInsideNames")
	InfoSpell_ImpregnatedYou = getLangText("GAME_CONTENT_InfoSpell_ImpregnatedYou")
	InfoSpell_ImpregnatedAnyWoman = getLangText("GAME_CONTENT_InfoSpell_ImpregnatedAnyWoman")
	InfoSpell_ImpregnatedWoman = getLangText("GAME_CONTENT_InfoSpell_ImpregnatedWoman")
	InfoSpell_ImpregnatedNumWoman = getLangText("GAME_CONTENT_InfoSpell_ImpregnatedNumWoman")
	InfoSpell_SpermVirility = getLangText("GAME_CONTENT_InfoSpell_SpermVirility")

	InfoSpell_Yes = getLangText("GAME_CONTENT_InfoSpell_Yes")
	InfoSpell_No = getLangText("GAME_CONTENT_InfoSpell_No")
	InfoSpell_NotAnymore = getLangText("GAME_CONTENT_InfoSpell_NotAnymore")
	InfoSpell_You = getLangText("GAME_CONTENT_InfoSpell_You")
	InfoSpell_AndYou = getLangText("GAME_CONTENT_InfoSpell_AndYou")
	InfoSpell_Male = getLangText("GAME_CONTENT_InfoSpell_Male")
	InfoSpell_Female = getLangText("GAME_CONTENT_InfoSpell_Female")
	InfoSpell_He = getLangText("GAME_CONTENT_InfoSpell_He")
	InfoSpell_She = getLangText("GAME_CONTENT_InfoSpell_She")
	InfoSpell_Overdue = getLangText("GAME_CONTENT_InfoSpell_Overdue")
	
; Child Info
	InfoSpell_ChildParents = getLangText("GAME_CONTENT_InfoSpell_ChildParents")
	InfoSpell_ChildFatherIs = getLangText("GAME_CONTENT_InfoSpell_ChildFatherIs")
	InfoSpell_ChildMotherIs = getLangText("GAME_CONTENT_InfoSpell_ChildMotherIs")
	InfoSpell_UnknownParents = getLangText("GAME_CONTENT_InfoSpell_UnknownParents")
	InfoSpell_UnknownParent = getLangText("GAME_CONTENT_InfoSpell_UnknownParent")
	InfoSpell_ChildWasBorn = getLangText("GAME_CONTENT_InfoSpell_ChildWasBorn")
	InfoSpell_ChildVampire = getLangText("GAME_CONTENT_InfoSpell_ChildVampire")
	InfoSpell_ChildFollows = getLangText("GAME_CONTENT_InfoSpell_ChildFollows")
	InfoSpell_ChildGotOrder = getLangText("GAME_CONTENT_InfoSpell_ChildGotOrder")
	InfoSpell_ChildOrder00 = getLangText("GAME_CONTENT_InfoSpell_ChildOrder00")
	InfoSpell_ChildOrder01 = getLangText("GAME_CONTENT_InfoSpell_ChildOrder01")
	InfoSpell_ChildOrder02 = getLangText("GAME_CONTENT_InfoSpell_ChildOrder02")
	InfoSpell_ChildOrder03 = getLangText("GAME_CONTENT_InfoSpell_ChildOrder03")
	InfoSpell_ChildOrder04 = getLangText("GAME_CONTENT_InfoSpell_ChildOrder04")
	InfoSpell_ChildOrder05 = getLangText("GAME_CONTENT_InfoSpell_ChildOrder05")
	InfoSpell_ChildOrder06 = getLangText("GAME_CONTENT_InfoSpell_ChildOrder06")
	
	ChildLevelUp = getLangText("GAME_CONTENT_ChildLevelUp")
	NoChildArmor = getLangText("GAME_CONTENT_NoChildArmor")
	NoChildItem = getLangText("GAME_CONTENT_NoChildItem")
	BabyBlankName = getLangText("GAME_CONTENT_BabyBlankName")
	BabyName = getLangText("GAME_CONTENT_BabyName")
	
	Req_BF = getLangText("GAME_CONTENT_Req_BF")
	Req_Skyrim = getLangText("GAME_CONTENT_Req_Skyrim")
	Req_SKSE = getLangText("GAME_CONTENT_Req_SKSE")
	Req_SKSEScript = getLangText("GAME_CONTENT_Req_SKSEScript")
	Req_PapyrusUtil = getLangText("GAME_CONTENT_Req_PapyrusUtil")
	Req_PlayerNotFoundOnRef = getLangText("GAME_CONTENT_Req_PlayerNotFoundOnRef")
	Req_BeeingFemaleNative = getLangText("GAME_CONTENT_BeeingFemaleNative")
	Req_BeeingFemaleNativeUpdate = getLangText("GAME_CONTENT_BeeingFemaleNativeUpdate")
	
	FNISNotInstalled = getLangText("GAME_CONTENT_FNIS_NotInstalled")
	FNISOverdue = getLangText("GAME_CONTENT_FNIS_Overdue")
	FNISUsing = getLangText("GAME_CONTENT_FNIS_Using")
	FNISTXTNotInstalled = getLangText("GAME_CONTENT_FNIS_TXTNotInstalled")
	FNISTXTOverdue = getLangText("GAME_CONTENT_FNIS_TXTOverdue")
	
	; For Console Commands
	SwitchState = getLangText("GAME_CONTENT_SwitchState")
	ActorHasContraception = getLangText("GAME_CONTENT_ActorHasContraception")
	BabyHealth = getLangText("GAME_CONTENT_BabyHealth")
	ActorNotPregnant = getLangText("GAME_CONTENT_ActorNotPregnant")
	
	FW_log.WriteLog("FWTextContents::LoadContent() Loading Done")
endfunction