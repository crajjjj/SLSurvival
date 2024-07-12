Scriptname	_JSW_SUB_ConfigQuestScript	extends	SKI_ConfigBase

;	other script(s) within this same quest
_JSW_SUB_MCMHelper				Property	MCMHelper		Auto	; script for helpng MCM functions

; scripts in other quests
_JSW_SUB_HandlerQuestAliasScript Property	Handler			Auto	; The primary tracking script
_JSW_SUB_MiscUtilQuest			Property	FMMiscUtil		Auto	; script to calculate conception chance and stuff
_JSW_SUB_GVHolderScript			Property	GVHolder		Auto	; holds variables used by the other scripts
_JSW_SUB_AdoptionScript			Property	FMAdoptScript	Auto	;

Actor			Property	playerRef				Auto	; Reference to the player. Game.GetPlayer() is slow

Faction			Property	FGCloakEnable			Auto	; membership in this faction turns on the FG cloak spell
Faction			Property	FGFaction				Auto	; faction PC auto added to if FG detected
Faction			Property	OStimFaction			Auto	; faction PC auto added to if Ostim detected
Faction			Property	SexLabSLSOFaction		Auto	; faction PC auto added to if SL/SLSO detected

; 2.20
FormList		Property	ParentConfirmMsg		Auto	; list of messages to be displayed for pregnancy confirms

Keyword			Property	FertilityKeyword		Auto	; keyword for fertility altering effects
Keyword			Property	SpawnedChild			Auto	; Keyword for identifying Fertility Mode spawned child NPCs

MagicEffect		Property	EffectContraception		Auto	; Magic effect for decreased fertility
MagicEffect		Property	EffectFertility			Auto	; ME for increased fertility

Quest			Property	RelationshipAdoption	Auto	; hearthfires adoption quest
Quest			Property	FMAdoptQuest			Auto	; FM+ adoption quest

Spell			Property	AbortSpell				Auto
Spell			Property	BirthSpell				Auto
Spell			Property	DetectFertility			Auto
Spell			Property	ImpregnateSpell			Auto
Spell			Property	InseminateSpell			Auto

string[] 		Property	BirthTypeMenu			Auto

form		playerRefForm
int			_summonIndex = 0
int			_trackingFilterIndex = 0
int			_trackingFilterPage = 0
int			_trainingFilterIndex = 0
int			_trainingFilterPage = 0
int			_actorsPerPage = 8
int			_childrenPerPage = 8
int			actorsThisType
string		_playerName = ""
; 2.17 move from function variable 'index' to script variable 'pageIndex'
int			pageIndex

string[]	_birthRaceMenu
string[]	_genderMenu
string[]	_scaleTypeMenu
string[]	_trackingFilter
; 2.12
;string		plugInName = "Fertility Mode 3 Fixes and Updates.esp"

int function GetVersion()
    return 2
endFunction

event OnPageReset(string page)

	playerRefForm = playerRef as form
	if (page == "")
		LoadCustomContent("FertilityMode/Logo.dds", 180, 30)
	else
		UnloadCustomContent()

; 2.17        int index = Pages.Find(page)
		pageIndex = Pages.Find(page)
;/	Settings 1			0
	Settings 2			1
	Tracking(Females)	2
	Tracking(Males)		3
	Player's Children	4
	Info				5
	Debug				6	/;
		if (pageIndex != 2)
			MCMHelper.OnUpdate()
		endIf
		if (pageIndex == 0)
			ResetPage1Settings()
		elseIf (pageIndex == 1)
			ResetPage2Settings()
		elseIf (pageIndex == 2)
			ResetPageTrackingFem()
		elseIf (pageIndex == 3)
			ResetPageTrackingMale()
		elseIf (pageIndex == 4)
			ResetPageChildren()
		elseIf (pageIndex == 5)
			ResetPageInfo()
		elseIf (pageIndex == 6)
			ResetPageDebug()
		endIf
	endIf

endEvent

function ResetPage1Settings()

;	if (_scaleTypeMenu.Length != 5)
		_scaleTypeMenu		=	new String[5]
		_scaleTypeMenu[0]	=	"BodyMorph"
		_scaleTypeMenu[1]	=	"NetImmerse"
		_scaleTypeMenu[2]	=	"NiOverride"
		_scaleTypeMenu[3]	=	"SLIF"
		_scaleTypeMenu[4]	=	"No Morphs"
;	endIf

    SetCursorFillMode(TOP_TO_BOTTOM)

    AddToggleOptionST("D96", "FM+ Enabled", GVHolder.Enabled); toggle mod enabled
    AddSliderOptionST("D9A", "Polling Interval", GVHolder.PollingInterval, "{0} hour(s)")

	AddHeaderOption("Automation")
	AddToggleOptionST("D9B", "Player Only", GVHolder.PlayerOnly)
	if !GVHolder.PlayerOnly
		AddToggleOptionST("D9C", "No Non-Unique Women", GVHolder.UniqueWomenOnly )
		AddToggleOptionST("D9D", "No Non-Unique Men", GVHolder.UniqueMenOnly )
		AddToggleOptionST("DB9", "Randomly Inseminate NPCs", GVHolder.AutoInseminateNpc )
	endIf
	if !GVHolder.PlayerOnly || (Handler.Util.GetActorGender(playerRef) == 1)
		AddToggleOptionST("DA9", "Allow Creatures", GVHolder.AllowCreatures )
	endIf
	AddToggleOptionST("DBA", "Randomly Inseminate PC", GVHolder.AutoInseminatePc )
	if GVHolder.AutoInseminatePC
		AddToggleOptionST("DBB", "\tOnly On Sleep", GVHolder.AutoInseminatePcSleep )
	endIf
	if (GVHolder.AutoInseminatePc || GVHolder.AutoInseminateNpc)
		AddSliderOptionST("DBC", "Insemination Probability", GVHolder.AutoInseminateChance, "{0}%")
	endIf
	AddSliderOptionST("DB8", "Partner Fidelity", GVHolder.SpouseInseminateChance, "{0}%")

    SetCursorPosition(1)
    AddHeaderOption("Menstrual Cycle")
    AddSliderOptionST("D9E", "Cycle Duration", GVHolder.CycleDuration , "{0} days")
	if Handler.Util.GetActorGender(playerRef)
		AddSliderOptionST("D9F", "Menstrual Cycle Buffs/Debuffs", GVHolder.CycleBuffDebuff , "{0}% Max.")
	endIf

	AddHeaderOption("For the Males")
	AddSliderOptionST("DA0", "Male Refractory Period", Handler.Storage.FMValues[11], "{0} Hours")
	
    AddHeaderOption("Conception")
    AddSliderOptionST("DA8", "Base Conception Chance", GVHolder.ConceptionChance, "{0}%")
    AddMenuOptionST("SCALING_METHOD_MENU", "Scaling Method", _scaleTypeMenu[GVHolder.ScalingMethod])
    
    if (GVHolder.ScalingMethod  == 1 || GVHolder.ScalingMethod  == 2)
        AddSliderOptionST("DAC", "\tBelly Scale Maximum", GVHolder.BellyScaleMax , "{0}x")
    endIf
    
    AddSliderOptionST("DAD", "Belly Scale Multiplier", GVHolder.BellyScaleMult , "{1}")
    AddSliderOptionST("DAE", "Breast Scale Multiplier", GVHolder.BreastScaleMult , "{1}")
    AddSliderOptionST("DAA", "Pregnancy Duration", GVHolder.PregnancyDuration, "{0} day(s)")

endFunction

function ResetPage2Settings()

	; 2.17 make new array be conditional
;	if (_genderMenu.Length != 3)
		_genderMenu		=	new	String[3]
		_genderMenu[0]	=	"Male"
		_genderMenu[1]	=	"Female"
		_genderMenu[2]	=	"No"
;	endIf

;	if (_birthRaceMenu.Length != 4)
		_birthRaceMenu		=	new	String[4]
		_birthRaceMenu[0]	=	"Mother"
		_birthRaceMenu[1]	=	"Father"
		_birthRaceMenu[2]	=	"Random"
		_birthRaceMenu[3]	=	"Specific"
;	endIf
    
	SetCursorFillMode(TOP_TO_BOTTOM)
    AddHeaderOption("Birth")
    AddMenuOptionST("BIRTH_TYPE_MENU", "Birth Type", BirthTypeMenu[GVHolder.BirthType])
    if (GVHolder.BirthType != 0)
		AddToggleOptionST("DB2", "Labor Enabled", GVHolder.LaborEnabled )
	endIf
	if GVHolder.LaborEnabled
		AddSliderOptionST("DB6", "\tLabor Duration", GVHolder.LaborDuration, "{0} seconds")
	endIf

	if (GVHolder.BirthType  == 2.0)
		AddToggleOptionST("DB3", "Spawn Enabled", GVHolder.SpawnEnabled )
		if (GVHolder.SpawnEnabled )
			AddSliderOptionST("DB7", "\tBaby Duration", GVHolder.BabyDuration, "{0} day(s)")
			AddToggleOptionST("DB4", "\tAdoption Enabled", GVHolder.AdoptionEnabled )
			AddToggleOptionST("DB5", "\tTraining Enabled", GVHolder.TrainingEnabled )
		endIf
		AddMenuOptionST("BIRTH_RACE_MENU", "Birth Race", _birthRaceMenu[GVHolder.BirthRace])
    
		if (GVHolder.BirthRace  == 3.0)
			AddMenuOptionST("DAF", "\tSpecific Race", Handler.Storage.ParentStrings[GVHolder.BirthRaceSpecific])
		endIf
    endIf
    AddSliderOptionST("DAB", "Recovery Duration", GVHolder.RecoveryDuration, "{0} day(s)")
    AddToggleOptionST("DB0", "Miscarriage Enabled", GVHolder.MiscarriageEnabled )
    SetCursorPosition(1)
    AddHeaderOption("Preferences")
    AddToggleOptionST("D99", "Show Verbose Messages", GVHolder.VerboseMode)
	AddMenuOptionST("FORCE_GENDER_MENU", "Override Player Gender", _genderMenu[GVHolder.ForceGender])
	; 1.67
	AddToggleOptionST("FG_CLOAK_SPELL_TOGGLE", "Flower Girls NPC Monitoring", playerRef.IsInFaction(FGCloakEnable))
    AddSliderOptionST("DB1", "Sound Volume", GVHolder.SoundVolume , "{1}x")
    AddToggleOptionST("DA1", "Detect Fertility Spell", PlayerRef.HasSpell(DetectFertility as form))
	; 2.17
	AddSliderOptionST("DE8_ACTORS_PER_PAGE", "Tracking Page Length", GVHolder.TrackPageLength, "{0} per page")

	if Handler.Util.GetActorGender(playerRef)
		AddHeaderOption("The Widget")
		AddToggleOptionST("DA3", "Show Cycle Widget", GVHolder.WidgetShown)
		AddToggleOptionST("DA4", "Replace Baby Health with Pregnancy Day", (Handler.Storage.FMValues[7] as bool))
		AddSliderOptionST("DA5", "Widget Top", GVHolder.WidgetTop, "{0}px")
		AddSliderOptionST("DA6", "Widget Left", GVHolder.WidgetLeft, "{0}px")
		; 2.23
		AddToggleOptionST("DA2_MapWidget", "Map Widget Hotkey", GVHolder.MapWidgetKey)
		if GVHolder.MapWidgetKey
			AddKeyMapOptionST("DA7", "Widget Hotkey", GVHolder.WidgetHotKey)
		endIf
	endIf

endFunction

function ResetPageTrackingFem()

;	if (_trackingFilter.Length != 5)
		_trackingFilter		=	new	String[6]
		_trackingFilter[0]	=	"All (unfiltered)"
		_trackingFilter[1]	=	"Unique Only"
		_trackingFilter[2]	=	"Ovulating Only"
		_trackingFilter[3]	=	"Pregnant Only"
		; 2.22
		_trackingFilter[4]	=	"Not Pregnant Only"
		_trackingFilter[5]	=	"Player-Related"
;	endIf
	; 2.17
;	_actorsPerPage			=	8
	_actorsPerPage			=	GVHolder.TrackPageLength
	_playerName				=	(PlayerRef as objectReference).GetDisplayName()
	MCMHelper.CountFilteredActors(_trackingFilterIndex)
    actorsThisType			=	Math.LogicalAnd(MCMHelper.returnList.Length, 0x00000FFF)
	int nListed				=	Math.Ceiling(actorsThisType / _actorsPerPage)
	if _trackingFilterPage < 0
		_trackingFilterPage = 0
	elseIf _trackingFilterPage > nListed
		_trackingFilterPage = nListed
	endIf

    SetCursorFillMode(LEFT_TO_RIGHT)
    
    SetCursorPosition(0)
    AddMenuOptionST("PLAYER_ONLY_FILTER_MENU", "Filter", _trackingFilter[_trackingFilterIndex])
	string added = "Filtered"
	if (_trackingFilterIndex == 0)
		added = "Tracked"
	endIf
    AddTextOption(added + " Characters: " + actorsThisType, "Page: " + (_trackingFilterPage + 1))
    
    if (_trackingFilterPage > 0)
        AddTextOptionST("DBD", "Previous Page", "[" + _trackingFilterPage + "]")
    else
        AddEmptyOption()
    endIf

	if (actorsThisType > ((_trackingFilterPage + 1) * _actorsPerPage))
        AddTextOptionST("DBF", "Next Page", "[" + (_trackingFilterPage + 2) + "]")
    else
        AddEmptyOption()
    endIf

    if (_trackingFilterPage > 1) && (_trackingFilterPage < 10)
        AddTextOptionST("DBE", "Back to First Page", "[0]")
    elseIf (_trackingFilterPage > 9)
        AddTextOptionST("DBE", "Back 10 Pages", "[" + (_trackingFilterPage - 9) + "]")
    else
       AddEmptyOption()
    endIf

    if ((_trackingFilterPage + 10) < ((actorsThisType / _actorsPerPage) as int + 1))
        AddTextOptionST("DC0", "Ahead 10 pages", "[" + (_trackingFilterPage + 11) + "]")
    elseIf ((_trackingFilterPage + 10) < ((actorsThisType / _actorsPerPage) as int + 9))
	; 2.17
        AddTextOptionST("DC0", "Ahead to Last Page", "[" + ((actorsThisType / _actorsPerPage) as int + 1) + "]")
	else
        AddEmptyOption()
    endIf
    
    AddHeaderOption("Tracked Women (most recent location)")
    AddHeaderOption("Curr.father]SpermCount[Concept.%]Ttl.Births")
    
	float	now				=	GVHolder.GVGameDaysPassed.GetValue()
	int		actorIndex		=	_actorsPerPage * _trackingFilterPage
	float	lifeSperm		=	GVHolder.Spermlife as float
	form	trackedActor	=	none
	int		ovulBegin		=	GVHolder.OvulationBegin
	int		recoverDuration	=	GVHolder.RecoveryDuration
	bool	DDPregnantDur	=	(GVHolder.PregnancyDuration  > 9)
	bool	DDCycleDur		=	(GVHolder.CycleDuration  > 9)
	int		birthDay		=	0
	int		cycleDay		=	0
	int		pregnantDay		=	0
	int		sprmCount		=	0
	bool	isOvulating		=	false
	bool	isPregnant		=	false
	int		crossCheck		=	0
	string	fatherName		=	""
	form	father			=	none
	added	=	""
	nListed	=	0
	while ((actorIndex < actorsThisType) && (nListed < _actorsPerPage))
		crossCheck = MCMHelper.returnList[actorIndex]
        trackedActor = Handler.Storage.TrackedActors[crossCheck]
        
        if trackedActor
            	
			cycleDay = Handler.Storage.DayOfCycle[crossCheck]
			
			if (Handler.Storage.LastOvulation[crossCheck] != 0.0)
				added = "*"
				isOvulating = true
			elseIf (cycleDay < ovulBegin)
				added += "^"
			endIf
			
			if (Handler.Storage.LastConception[crossCheck] != 0.0)
				isPregnant = true
			endIf

			if ((trackedActor as actor).HasEffectKeyword(FertilityKeyword))
				if ((trackedActor as actor).HasMagicEffect(EffectContraception))
					added += "-"
				else
					added += "+"
				endIf
			endIf
                
			if (Handler.Storage.ActorBlackList.Find(trackedActor) == -1)
				pregnantDay	=	(now - Handler.Storage.LastConception[crossCheck]) as int
				birthDay	=	(now - Handler.Storage.LastBirth[crossCheck]) as int
				sprmCount	=	Handler.Storage.SpermCount[crossCheck]
				int TBTA	=	Handler.Storage.TimesDelivered[crossCheck]
				father		=	Handler.Storage.CurrentFatherForm[crossCheck]
				; 2.26
				if !father
					father = Handler.Storage.LastFatherForm[crossCheck]
				endIf
				string textString
				if father
					fatherName = (father as actor).GetDisplayName()
				endIf
				if (isPregnant)
					textString = "Pregnant Day "
					; 1.44 don't pad day displays for max single-digit values
					if (DDPregnantDur && (pregnantDay < 10))
						textString += "0"
					endIf
					AddTextOption(MCMHelper.GenerateFirstString(crossCheck, textString, pregnantDay, ""), "")
					if (sprmCount != 0)
						AddTextOption(fatherName, sprmCount + "[0%] " + TBTA)
					elseIf TBTA
						AddTextOption(fatherName, TBTA)
					else
						AddTextOption(fatherName, "")
					endIf
				elseIf (Handler.Storage.LastBirth[crossCheck] != 0.0) && (birthDay < recoverDuration); && (_trackingFilterIndex < 2 || _trackingFilterIndex == 4))
					textString = "Recovery Day "
					if ((recoverDuration > 9) && (birthDay < 10))
						textString += "0"
					endIf
					AddTextOption(MCMHelper.GenerateFirstString(crossCheck, textString, birthDay, ""), "")
					if (sprmCount != 0)
						AddTextOption(fatherName, sprmCount + "[0%] " + TBTA)
					elseIf TBTA
						AddTextOption(fatherName, TBTA)
					else
						AddTextOption(fatherName, "")
					endIf
				else;If (_trackingFilterIndex < 2 || _trackingFilterIndex == 4 || (_trackingFilterIndex == 2 && isOvulating))
					textString = "Cycle Day "
					if (DDCycleDur && (cycleDay < 10))
						textString += "0"
					endIf
					if (sprmCount != 0)
						added += "!"
					endIf
					AddTextOption(MCMHelper.GenerateFirstString(crossCheck, textString, cycleDay, added), "")
					if (sprmCount != 0)
						AddTextOption(fatherName, FMMiscUtil.MakeFertilityString(crossCheck, now, sprmCount, TBTA))
					elseIf TBTA
						AddTextOption(fatherName, TBTA)
					else
						AddTextOption(fatherName, "")
					endIf
				endIf
				textString = ""
			else
				AddTextOption((trackedActor as actor).GetDisplayName(), "[BLOCKED]")
				AddTextOption(fatherName, "")
			endIf
			nListed		+=	1
			birthDay	=	0
			pregnantDay	=	0
			sprmCount	=	0
			cycleDay	=	0
			added		=	""
			isOvulating	=	false
			isPregnant	=	false
			fatherName	=	""
			father		=	none
        endIf
        actorIndex		+=	1
		trackedActor	=	none
    endWhile
endFunction

function ResetPageTrackingMale()

	; 2.17
;	_actorsPerPage			=	16
	_actorsPerPage			=	(GVHolder.TrackPageLength * 2)
	_playerName				=	(PlayerRef as objectReference).GetDisplayName()
	MCMHelper.CountFilteredActors(12)
	actorsThisType			=	Math.LogicalAnd(MCMHelper.returnList.Length, 0x00000FFF)
	int		nListed			=	Math.Ceiling(actorsThisType / _actorsPerPage)
	if (_trackingFilterPage < 0)
		_trackingFilterPage = 0
	elseIf _trackingFilterPage > nListed
		_trackingFilterPage = nListed
	endIf

	AddEmptyOption()
	AddTextOption("Tracked Characters: " + actorsThisType, "Page: " + (_trackingFilterPage + 1))

	if (_trackingFilterPage > 0)
		AddTextOptionST("DBD", "Previous Page", "[" + (_trackingFilterPage) + "]")
	else
		AddEmptyOption()
	endIf

	if (actorsThisType > ((_trackingFilterPage + 1) * _actorsPerPage))
		AddTextOptionST("DBF", "Next Page", "[" + (_trackingFilterPage + 2) + "]")
	else
		AddEmptyOption()
	endIf

	if (_trackingFilterPage > 1) && (_trackingFilterPage < 10)
		AddTextOptionST("DBE", "Back to First Page", "[0]")
	elseIf (_trackingFilterPage > 9)
		AddTextOptionST("DBE", "Back 10 Pages", "[" + (_trackingFilterPage - 9) + "]")
	else
		AddEmptyOption()
	endIf

	if ((_trackingFilterPage + 10) < ((actorsThisType / _actorsPerPage) as int + 1))
		AddTextOptionST("DCO", "Ahead 10 pages", "[" + (_trackingFilterPage + 11) + "]")
	elseIf ((_trackingFilterPage + 10) < ((actorsThisType / _actorsPerPage) as int + 7))
	; 2.17
		AddTextOptionST("DCO", "Ahead to Last Page", "[" + ((actorsThisType / _actorsPerPage) as int + 1) + "]")
	else
		AddEmptyOption()
	endIf
	
	AddHeaderOption("Tracked Males (most recent location)")
	AddEmptyOption()
	
	form	trackedActor	=	none
	int		crossCheck		=	0
	int		actorIndex		=	(_actorsPerPage * _trackingFilterPage)
	nListed = 0
	while ((actorIndex < actorsThisType) && (nListed < _actorsPerPage))
		crossCheck = MCMHelper.returnList[actorIndex]
        trackedActor = Handler.Storage.TrackedFathers[crossCheck]
		if trackedActor
			if (Handler.Storage.ActorBlackList.Find(trackedActor) == -1)
				AddTextOption((trackedActor as actor).GetDisplayName() + " (" + Handler.Storage.LastFatherLocation[crossCheck] + ")", "")
			else
				AddTextOption((trackedActor as actor).GetDisplayName(), "[BLOCKED]")
			endIf
			nListed += 1
		endIf
		actorIndex += 1
		trackedActor = none
	endWhile

endFunction

function ResetPageChildren()
	int nChildren = Handler.Storage.PlayerChildName.Length
    
    SetCursorFillMode(LEFT_TO_RIGHT)
    
    SetCursorPosition(0)
    AddTextOption("Trained Children: " + nChildren, "")
    
    if (nChildren > 0)
	    if (Handler.Storage.CurrentFollowerIndex == -1)
	    	AddMenuOptionST("D97", "Summon Child", Handler.Storage.PlayerChildName[_summonIndex])
	    else
	    	AddTextOptionST("D98", "Dismiss " + Handler.Storage.PlayerChildName[Handler.Storage.CurrentFollowerIndex], "")
	    endIf
    else
    	AddEmptyOption()
    endIf
    
    if (_trainingFilterPage > 0)
    	AddTextOptionST("DC1", "Previous Page [" + (_trainingFilterPage - 1) + "]", "")
    else
    	AddEmptyOption()
    endIf
    
    if (_trainingFilterPage < (Handler.Storage.PlayerChildName.Length / _childrenPerPage))
    	AddTextOptionST("DC2", "Next Page [" + (_trainingFilterPage + 1) + "]", "")
    else
    	AddEmptyOption()
    endIf
    
    AddHeaderOption("Trained Children")
    AddEmptyOption()
    
    int		childIndex	=	_childrenPerPage * _trainingFilterPage
    int		nListed		=	0
	int		PCNLength	=	Handler.Storage.PlayerChildName.Length
	string genderMsg
    
    while (childIndex < PCNLength && nListed < _childrenPerPage)
		
		if (Handler.Storage.PlayerChildGender[childIndex] == 1)
			genderMsg = "[F " + Handler.Storage.PlayerChildRace[childIndex].GetName() + " " + Handler.Storage.PlayerChildClass[childIndex] + "] "
		else
			genderMsg = "[M " + Handler.Storage.PlayerChildRace[childIndex].GetName() + " " + Handler.Storage.PlayerChildClass[childIndex] + "] "
		endIf
		
		AddTextOption(genderMsg + Handler.Storage.PlayerChildName[childIndex], "")
		
		childIndex	+=	1
        nListed		+=	1
    endWhile
endFunction

function ResetPageInfo()

	_playerName = (PlayerRef as actor).GetDisplayName()
	SetCursorPosition(0)

	string not = "."
	if (Handler.Storage.FMValues[10] < 10)
		not += "0"
	endIf
	AddHeaderOption("FM+ version: " + Handler.Storage.FMValues[9] + not + Handler.Storage.FMValues[10])
	AddHeaderOption("Detected Compatible Mods")

	AddTextOption("Flower Girls SE detected:", (Game.GetModByName("FlowerGirls SE.esm") != 255))
	AddTextOption("Flower Girls Support Installed:", playerRef.IsInFaction(FGFaction))
	AddTextOption("OStim detected:", (Game.GetModByName("OStim.esp") != 255))
	AddTextOption("OStim Support Installed:", playerRef.IsInFaction(OStimFaction))
	AddTextOption("SexLab detected:", (Game.GetModByName("SexLab.esm") != 255))
	AddEmptyOption()
	AddTextOption("SLSO detected:", (Game.GetModByName("SLSO.esp") != 255))
	AddTextOption("SexLab/SLSO Support Installed:", playerRef.IsInFaction(SexLabSLSOFaction))
	AddTextOption("Hearthfire Multiple Adoptions detected:", (Game.GetModByName("HearthfireMultiKid.esp") != 255))
	AddEmptyOption()
	AddTextOption("SexLab Inflation Framework detected:", (Game.GetModByName("SexLab Inflation Framework.esp") != 255))
	AddEmptyOption()
	; 2.17
	AddTextOption("Fertility Adventures detected: ", GVHolder.FADetected)
	AddEmptyOption()

	AddHeaderOption("Other")
	AddHeaderOption("")
	int sex = playerRef.GetLeveledActorBase().GetSex()
	if (sex == -1)
		not = " none"
	elseIf (sex == 0)
		not = " male"
	elseIf (sex == 1)
		not = " female"
	else
		not = " unknown"
	endIf
	AddTextOption("PC gender as reported by Skyrim :", not)
	if (Handler.Util.GetActorGender(playerRef) == 1)
		not = " female"
	else
		not = " male"
	endIf
	AddTextOption("PC gender as set in FM+ :", not)
	; 2.20
	if GVHolder.FADetected && (GVHolder.PregnancyDuration < 30)
		AddTextOptionST("DF2_FAPregDurationLow", MCMHelper.GetThatString("DF1"), "")
	else
		AddEmptyOption()
	endIf
;/	if (GVHolder.BirthType != 2) && (Handler.Storage.UniqueMothers.Length > 0)
		AddTextOptionST("DF3_BabyTypeNotTwo", MCMHelper.GetThatString("DF1") + " ", "")
	else/;
		AddEmptyOption()
;	endIf
	if GVHolder.PlayerOnly && (ParentConfirmMsg.GetSize() > 3)
		AddTextOptionST("DF4_CantTrackSpecifiedParents", MCMHelper.GetThatString("DF1") + "  ", "")
	else
		AddEmptyOption()
	endIf
	if GVHolder.AutoInseminateNPC && (GVHolder.SpouseInseminateChance < 93)
		AddTextOptionST("DF5_LowSpouseFidelity", MCMHelper.GetThatString("DF1") + "   ", "")
	else
		AddEmptyOption()
	endIf
endFunction

function ResetPageDebug()

	_playerName = (PlayerRef as objectReference).GetDisplayName()
    SetCursorFillMode(TOP_TO_BOTTOM)
    
    SetCursorPosition(0)
    
    AddHeaderOption("Global")
    AddTextOptionST("DC3", "Clear Tracking List", "")
    
    Actor	kActor		=	Game.GetCurrentCrosshairRef() as Actor
    int		playerIndex	=	Handler.Storage.TrackedActors.Find(playerRefForm)
    Armor	baby		=	none
    int		n
    
    if (playerIndex == -1)
        AddHeaderOption(_playerName + " is male or not tracked")
    else
		int cycleDay = Handler.Storage.DayOfCycle[playerIndex]
        string fatherName = "Unknown"
        
        if (Handler.Storage.CurrentFatherForm[playerIndex] != none)
            fatherName = (Handler.Storage.CurrentFatherForm[playerIndex] as actor).GetDisplayName()
        endIf
        
        AddHeaderOption(_playerName)
        float	now			=	GVHolder.GVGameDaysPassed.GetValue()
        AddTextOption("Current Game Time", "Day: " + (now as int) + ", Hour: " + (((now - ((now as int) as float)) * 24.0) as int))
		float	lastInsem	=	Handler.Storage.LastInsemination[playerIndex]
		int		sprmCount	=	Handler.Storage.SpermCount[playerIndex]
		float	lastConcept	=	Handler.Storage.LastConception[playerIndex]
		float	ovulLast	=	Handler.Storage.LastOvulation[playerIndex]
		if !lastConcept
			if (ovulLast != 0.0)
				if (ovulLast as int) == 0
					AddTextOption("Last Ovulation", "Today")
				else
					AddTextOption("Last Ovulation", "Yesterday")
				endIf
			else
				AddTextOption("Expected Ovulation:", "Day " + Handler.Storage.FMValues[1])
			endIf
			AddTextOption("Cycle Day: ", cycleDay)
			if sprmCount
				AddTextOption("Last Insemination", (((now - lastInsem) * 24) as int) + " hours ago")
				AddTextOption("Sperm Count", sprmCount)
				AddTextOption("Fertilization Chance: ", FMMiscUtil.MakeFertilityString(playerIndex, now, 0, -1))
				AddTextOption("Potential Father: ", fatherName)
			endIf
		else
			AddTextOption("Last Conception", "Day: " + (lastConcept as int) + ", Hour: " + (((lastConcept - ((lastConcept as int) as float)) * 24.0) as int))
            AddTextOption("Father: ", fatherName)
		endIf
		if (Handler.Storage.LastBirth[playerIndex] != 0.0)
			AddTextOption("Last Birth", Handler.Storage.LastBirth[playerIndex])
			AddTextOption("Total births", Handler.Storage.TimesDelivered[playerIndex])
		endIf
        
        if !lastConcept
            if (ovulLast == 0.0 && (cycleDay > (GVHolder.OvulationBegin  - 1)))
                AddTextOptionST("DC6", "Force Ovulation", "")
            endIf
            
			; 1.57
			if (Handler.Storage.SpermCount[playerIndex] == 0)
				AddTextOptionST("DC5", "Add Sperm", "")
			endIf

            if lastInsem
                AddTextOptionST("DC7", "Remove Sperm", "")
            endIf
        endIf
        
        if (lastConcept == 0.0) && lastInsem
            AddTextOptionST("DC8", "Impregnate", "")
        elseIf (lastConcept != 0.0)
            AddTextOptionST("DC9", "Give Birth", "")
            AddTextOptionST("DCA", "Abort", "")
        endIf
        
        n = Math.LogicalAnd(Handler.Storage.BirthBabyRace.Length, 0x000000FF)
        
        while (n)
	        n -= 1
	        
	        if (PlayerRef.GetItemCount(Handler.Storage.BirthBabyRace[n]) > 0)
	            baby = Handler.Storage.BirthBabyRace[n] as armor
	        endIf
    	endWhile
    	
    	if (GVHolder.SpawnEnabled  && Handler.Storage.BabyAdded[playerIndex] != 0.0 && baby)
	        AddTextOptionST("DCB", "Force Baby Growth", "")
        endIf
    endIf
    
    AddHeaderOption("Child NPCs")
    
    BYOHRelationshipAdoptionScript adoptHookScript = (RelationshipAdoption as BYOHRelationshipAdoptionScript)
    
;    AddTextOptionST("ADOPTED_CHILDREN", "Adopted Children: " + adoptHookScript.numChildrenAdopted, "")
    AddTextOption("Adopted Children: ", adoptHookScript.numChildrenAdopted)
    AddTextOptionST("DCC", "Spawn Child (Male)", "")
    AddTextOptionST("DCD", "Spawn Child (Female)", "")
    AddTextOptionST("DCE", "Spawn All Supported Children", "")

	if (kActor && kActor.HasKeyword(SpawnedChild))
		AddHeaderOption("Active Child")
		AddTextOptionST("DCF", "Rename Child", "")
		AddTextOptionST("DD1", "Adopt Child", "")
		AddTextOptionST("DD0", "Despawn Child", "")
	else
		AddHeaderOption("No child selected")
	endIf
	SetCursorPosition(1)
	AddHeaderOption("Global")
	AddTextOptionST("DC4", "Clear Tracked NPCs", "")

    if (!kActor)
        AddHeaderOption("No actor selected")
    else
		int sex = kActor.GetLeveledActorBase().GetSex()
        int npcIndex = -1
		if (sex  == 1)
			npcIndex = Handler.Storage.TrackedActors.Find(kActor)
		else
			npcIndex = Handler.Storage.TrackedFathers.Find(kActor)
		endIf
		
		if (npcIndex == -1)
				Handler.Util.AddToTracking(kActor, sex)
			if (sex  == 1)
				npcIndex = Handler.Storage.TrackedActors.Find(kActor)
			else
				npcIndex = Handler.Storage.TrackedFathers.Find(kActor)
			endIf
		endIf

		if (Handler.Storage.BlackListByName.Find((kActor as actor).GetDisplayName()) == -1)
			AddTextOptionST("DD5", "Blacklist", Handler.Storage.BlackListByName.Length)
		else
			AddTextOptionST("DD6", "Remove from Blacklist", Handler.Storage.BlackListByName.Length)
		endIf
        
        if (npcIndex == -1)
            AddHeaderOption((kActor as actor).GetDisplayName() + " cannot be tracked")
        elseIf (sex != 1)
			AddHeaderOption((kActor as actor).GetDisplayName() + " is tracked: " + npcIndex)
            if (Handler.Storage.ActorBlackList.Find(kActor) == -1)
            	AddHeaderOption((kActor as actor).GetDisplayName() +  " " + npcIndex)
            	AddTextOptionST("DD3", "Block", "")
            else
            	AddHeaderOption((kActor as actor).GetDisplayName() + " (BLOCKED)")
            	AddTextOptionST("DD4", "Unblock", "")
            endIf
		else
			int		cycleDay	=	Handler.Storage.DayOfCycle[npcIndex]
			string	fatherName	=	"Unknown"
			int		sprmCount	=	Handler.Storage.SpermCount[npcIndex]
			float	lastConcept	=	Handler.Storage.LastConception[npcIndex]
			bool	isPregnant	=	(lastConcept != 0.0)
			float	timeNow		=	GVHolder.GVGameDaysPassed.GetValue()
			float	ovulLast	=	Handler.Storage.LastOvulation[npcIndex]
            
            if (Handler.Storage.CurrentFatherForm[npcIndex] != none)
                fatherName = (Handler.Storage.CurrentFatherForm[npcIndex] as actor).GetDisplayName()
            endIf
            
            if (Handler.Storage.ActorBlackList.Find(kActor) == -1)
            	AddHeaderOption((kActor as actor).GetDisplayName() +  " " + npcIndex)
            	AddTextOptionST("DD3", "Block", "")
            else
            	AddHeaderOption((kActor as actor).GetDisplayName() + " (BLOCKED)")
            	AddTextOptionST("DD4", "Unblock", "")
            endIf
			AddTextOption("Current Time", "Day: " + (timeNow as int) + ", Hour: " + (((timeNow - ((timeNow as int) as float)) * 24.0) as int))

			if !isPregnant
				if (ovulLast != 0.0)
					if (ovulLast as int) == 0
						AddTextOption("Last Ovulation", "Today")
					else
						AddTextOption("Last Ovulation", "Yesterday")
					endIf
				endIf
				if sprmCount
					AddTextOption("Last Insemination", (((timeNow - Handler.Storage.LastInsemination[npcIndex]) * 24) as int) + " hours ago")
				endIf
			endif
			if (Handler.Storage.LastBirth[npcIndex] != 0.0)
				AddTextOption("Last Birth", "Day " + (Handler.Storage.LastBirth[npcIndex] as int))
				if (Handler.Storage.TimesDelivered[npcIndex] != 0)
					AddTextOption("Total Births", Handler.Storage.TimesDelivered[npcIndex])
				endIf
			endIf
            
            if isPregnant
				AddTextOption("Pregnancy Day:", ((timeNow - lastConcept) as int))
;                AddTextOptionST("NPC_FATHER", "Father:", fatherName)
                AddTextOption("Father:", fatherName)
            elseIf sprmCount && ovulLast
				AddTextOption("Cycle Day:", cycleDay)
;/                AddTextOptionST("NPC_SPERM", "Sperm Count:", sprmCount)
				AddTextOptionST("FERT_CHANCE", "Fertilization Chance: ", FMMiscUtil.MakeFertilityString(npcIndex, timeNow, 0, -1))
                AddTextOptionST("NPC_FATHER", "Potential Father:", fatherName)/;
                AddTextOption("Sperm Count:", sprmCount)
				AddTextOption("Fertilization Chance: ", FMMiscUtil.MakeFertilityString(npcIndex, timeNow, 0, -1))
                AddTextOption("Potential Father:", fatherName)
            elseIf sprmCount
				AddTextOption("Cycle Day:", cycleDay)
;/                AddTextOptionST("NPC_SPERM", "Sperm Count:", sprmCount)
                AddTextOptionST("NPC_FATHER", "Potential Father:", fatherName)/;
                AddTextOption("Sperm Count:", sprmCount)
                AddTextOption("Potential Father:", fatherName)
            endIf
            
            if !isPregnant
				if (ovulLast == 0.0 && (cycleDay > (GVHolder.OvulationBegin  - 1)))
                    AddTextOptionST("DD7", "Force Ovulation", "")
                endIf
                
				if !sprmCount
					AddTextOptionST("DD8", "Add Sperm", "")
				endIf
                
                if (Handler.Storage.LastInsemination[npcIndex] != 0.0)
                    AddTextOptionST("DD9", "Remove Sperm", "")
                endIf
            endIf
            
            if !isPregnant && sprmCount
                AddTextOptionST("DDA", "Impregnate", "")
            elseIf isPregnant
                AddTextOptionST("DDB", "Give Birth", "")
                AddTextOptionST("DDC", "Abort", "")
            endIf
            
            n = Math.LogicalAnd(Handler.Storage.BirthBabyRace.Length, 0x000000ff)
        
	        while (n)
		        n -= 1
		        
		        if (kActor.GetItemCount(Handler.Storage.BirthBabyRace[n]) > 0)
		            baby = Handler.Storage.BirthBabyRace[n] as armor
		        endIf
	    	endWhile
	    	
	    	if (GVHolder.SpawnEnabled  && Handler.Storage.BabyAdded[npcIndex] != 0.0 && baby)
		    	if (Handler.Storage.LastFatherForm[npcIndex] == playerRef as form)
		        	AddTextOptionST("DDD", "Force Baby Growth", "")
		        endIf
	        endIf
        endIf
    endIf
    
    AddHeaderOption("Debug Spells")
    AddToggleOptionST("DDE", "Inseminate Spell", playerRef.HasSpell(InseminateSpell as form) )
    AddToggleOptionST("DDF", "Impregnate Spell", playerRef.HasSpell(ImpregnateSpell as form) )
    AddToggleOptionST("DE0", "Give Birth Spell", playerRef.HasSpell(BirthSpell as form) )
    AddToggleOptionST("DE1", "Abort Pregnancy Spell", playerRef.HasSpell(AbortSpell as form) )
; 2.23
;	AddToggleOptionST("DA2", "Multithreaded Updates", (Handler.Storage.FMValues[2] as bool))
    
endFunction

state D97;PLAYER_CHILD_SUMMON_MENU
	event OnMenuOpenST()
		SetMenuDialogStartIndex(0)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(Handler.Storage.PlayerChildName)
	endEvent
	
	event OnMenuAcceptST(int index)
		ActorBase childBase = Handler.Storage.AdultChildren[Handler.Storage.PlayerChildActorIndex[index]] as actorbase
		
		if (childBase)
			childBase.SetHairColor(PlayerRef.GetActorBase().GetHairColor())
		
			Actor child = PlayerRef.PlaceAtMe(childBase) as Actor
			
			child.SetDisplayName(Handler.Storage.PlayerChildName[index])
			child.SetRelationshipRank(PlayerRef, 3)
			PlayerRef.SetRelationshipRank(child, 3)
			
			child.SetPlayerTeammate()
			
			Handler.Storage.CurrentFollower = child
			Handler.Storage.CurrentFollowerIndex = index
		else
			Debug.MessageBox(Handler.Storage.PlayerChildName[index] + " could not be summoned")
		endIf
		
		ForcePageReset()
	endEvent
	
	event OnDefaultST()
		SetMenuOptionValueST(Handler.Storage.PlayerChildName[0])
	endEvent
endState

state D98;PLAYER_CHILD_DISMISS_TEXT
	event OnSelectST()
		Debug.MessageBox("Please exit all menus to complete dismissal...")

		actor theKid	=	Handler.Storage.CurrentFollower
		theKid.Disable(true)
		theKid.Delete()
		Handler.Storage.CurrentFollower = none
		Handler.Storage.CurrentFollowerIndex = -1
	
		ForcePageReset()
	endEvent
endState

state D96;ENABLED_TOGGLE

    event OnSelectST()
		GVHolder.Enabled = !GVHolder.Enabled
		GVHolder.UpdateGVs()

		Handler.ScheduledUpdater.UpdateStatusAll(GVHolder.Enabled, false)
        SetToggleOptionValueST(GVHolder.Enabled )
        ForcePageReset()
    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(GVHolder.Enabled )
    endEvent
endState

state D99;VERBOSE_TOGGLE
    event OnSelectST()
		GVHolder.VerboseMode = !GVHolder.VerboseMode
		GVHolder.UpdateGVs()
        
        SetToggleOptionValueST(GVHolder.VerboseMode )
		ForcePageReset()
    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(GVHolder.VerboseMode )
    endEvent
endState

state D9A;POLLING_SLIDER
    event OnSliderOpenST()
        SetSliderDialogStartValue(GVHolder.PollingInterval  as int)
        SetSliderDialogRange(1, 24)
        SetSliderDialogInterval(1)
    endEvent
    
    event OnSliderAcceptST(float value)
        GVHolder.PollingInterval = value
        SetSliderOptionValueST(value as int, "{0} hour(s)")
		GVHolder.UpdateGVs()
		ForcePageReset()
    endEvent
endState
; 2.17
state DE8_ACTORS_PER_PAGE

	event OnSliderOpenST()
		SetSliderDialogStartValue(GVholder.TrackPageLength)
		SetSliderdialogRange(6, 40)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		GVHolder.TrackPageLength = value as int
		SetSliderOptionValueST(value, "{0} per page")
		ForcePageReset()
	endEvent

endState

state FORCE_GENDER_MENU
	event OnMenuOpenST()
		SetMenuDialogStartIndex(GVHolder.ForceGender)
		SetMenuDialogDefaultIndex(2)
		SetMenuDialogOptions(_genderMenu)
	endEvent

	event OnMenuAcceptST(int index)
		GVHolder.ForceGender = (index)
		GVHolder.UpdateGVs()
		GVHolder.ScanOptionsChanged = true
		Handler.Util.FMUtilCacheVariables()
		string text = "The player will be recognized as "
		int anInt
    	int sex = Handler.Util.GetActorGender(playerRef)

		if (sex == 1)
			Handler.Storage.TrackedActorAdd(PlayerRef, "", none, -2, none)
			anInt = Handler.Storage.TrackedFathers.Find(playerRefForm)
			text += "fe"
			if (anInt != -1)
				Handler.Storage.TrackedFatherRemove(anInt, false)
			endIf
		else
			Handler.Storage.TrackedFatherAdd(PlayerRef, "", none, -2, none)
			anInt = Handler.Storage.TrackedActors.Find(playerRefForm)
			if (anInt != -1)
				Handler.Storage.TrackedActorRemove(anInt, false)
			endIf
		endIf
		Handler.Util.AddToTracking(playerRef, sex)
		Debug.MessageBox(text + "male.  You need to exit the MCM for this to take full effect.")
		FMMiscUtil.UpdateCyclePerks(sex == 1)
		Handler.ScheduledUpdater.UpdateStatusAll(false, false)
		if GVHolder.Enabled
			ModEvent.Send(ModEvent.Create("FMPUpdateWidgetContent"))
			ModEvent.Send(ModEvent.Create("FMPPlayerFactStat"))
		endIf
		ForcePageReset()
	endEvent

	event OnDefaultST()
		SetMenuOptionValueST(_genderMenu[GVHolder.ForceGender])
	endEvent

	event OnHighlightST()
		; 0: "Male"
		; 1: "Female"
		; 2: "Auto"
		string text  = "Select the player's preferred gender\nForce the player to be identified as "
		if (GVHolder.ForceGender  == 0)
			SetInfoText(text + "male.")
		elseIf (GVHolder.ForceGender  == 1)
			SetInfoText(text + "female.")
		elseIf (GVHolder.ForceGender  == 2)
			text  = "Automatic detection is showing the PC as "
			if (Handler.Util.GetActorGender(PlayerRef) == 1)
				text += "fe"
			endIf
			text += "male."
			SetInfoText("Select the player's preferred gender\n\"No\" automatically detects the player character's gender.\n" + text)
		endIf
	endEvent
endState

state D9B;PLAYER_ONLY_TOGGLE
	event OnSelectST()
		if !GVHolder.PlayerOnly
			GVHolder.PlayerOnly			=	true
			GVholder.AutoInseminateNpc	=	false
			GVHolder.UniqueMenOnly		=	false
			GVHolder.UniqueWomenOnly	=	false
			GVHolder.ScanOptionsChanged	=	true

			; 2.08 only set to false if PC is male
			if !Handler.Util.GetActorGender(playerRef)
				GVHolder.AllowCreatures		=	false
			endIf

			int n = Math.LogicalAnd(Handler.Storage.TrackedActors.Length, 0x00000FFF)
    		; Remove all women who are not the player
    		while (n)
    			n -= 1
    			
    			if (Handler.Storage.TrackedActors[n] != playerRefForm)
    				Handler.Storage.TrackedActorRemove(n, false)
    			endIf
    		endWhile
			; 2.08 clear males, then add PC if appropriate
			Handler.Storage.TrackedFatherClear()
			Handler.Util.AddToTracking(playerRef)
        else
            GVHolder.PlayerOnly = false
        endIf
        
        SetToggleOptionValueST(GVHolder.PlayerOnly )
        ForcePageReset()
    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(GVHolder.PlayerOnly )
    endEvent
endState

state D9C;UNIQUE_WOMEN_ONLY_TOGGLE
    event OnSelectST()
		GVHolder.UniqueWomenOnly = !GVHolder.UniqueWomenOnly
        
        SetToggleOptionValueST(GVHolder.UniqueWomenOnly )
		GVHolder.UpdateGVs()
		ModEvent.Send(ModEvent.Create("FMUtilityCacheVars"))
        ForcePageReset()
    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(GVHolder.UniqueWomenOnly )
    endEvent
endState

state D9D;UNIQUE_MEN_ONLY_TOGGLE
    event OnSelectST()
		GVHolder.UniqueMenOnly = !GVHolder.UniqueMenOnly

		GVHolder.UpdateGVs()
        SetToggleOptionValueST(GVHolder.UniqueMenOnly )
		ModEvent.Send(ModEvent.Create("FMUtilityCacheVars"))
        ForcePageReset()
    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(GVHolder.UniqueMenOnly )
    endEvent
endState

state D9E;CYCLE_DURATION_SLIDER
    event OnSliderOpenST()
        SetSliderDialogStartValue(GVHolder.CycleDuration)
        SetSliderDialogRange(7, 28)
        SetSliderDialogInterval(7)
    endEvent
    
    event OnSliderAcceptST(float value)
        GVHolder.CycleDuration = (value as int)
        ; 1.56 change egglife to be 1.0
		GVHolder.SpermLife				=	4
		GVHolder.EggLife				=	1.0
		GVHolder.OvulationBegin			=	7
        if (value == 7.0)
            GVHolder.SpermLife			=	2
            GVHolder.OvulationBegin		=	2
            GVHolder.OvulationEnd		=	5
			Handler.Storage.FMValues[1]	=	3
        elseIf (value == 14.0)
            GVHolder.OvulationBegin		=	4
            GVHolder.OvulationEnd		=	9
			Handler.Storage.FMValues[1]	=	6
        elseIf (value == 21.0)
            GVHolder.OvulationEnd		=	13
			Handler.Storage.FMValues[1]	=	10
        else
            ; Assume anything else should be 28 days
            GVHolder.OvulationEnd = 21
			Handler.Storage.FMValues[1]	=	14
        endIf
        
        SetSliderOptionValueST(value as int, "{0} days")
        ForcePageReset()
    endEvent
endState

; 1.55
State D9F;CYCLE_BUFF_DEBUFF_SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue(GVHolder.CycleBuffDebuff)
		SetSliderDialogRange(0, 15)
		SetSliderDialogInterval(5)
	endEvent
	
	event OnSliderAcceptST(float value)
		GVHolder.CycleBuffDebuff = (value as int)
		MCMHelper.UpdateFactions(value as int)
		SetSliderOptionValueST(value, "{0}% Max")
		ForcePageReset()
	endEvent
endState

; 1.56
state DA0;REFRACTORY_PERIOD_SLIDER
	event OnSliderOpenST()
		float startValue = Handler.Storage.FMValues[11] as float
		SetSliderDialogStartValue(startValue)
		SetSliderDialogRange(2, 24)
		SetSliderDialogInterval(2)
	endEvent
	
	event OnSliderAcceptST(float value)
		Handler.Storage.FMValues[11] = value as int
		SetSliderOptionValueST(value, "{0} Hours")
		ForcePageReset()
	endEvent
endState

state DA1;DETECT_SPELL_TOGGLE
    event OnSelectST()
        if (PlayerRef.HasSpell(DetectFertility as form))
            PlayerRef.RemoveSpell(DetectFertility)
        else
            PlayerRef.AddSpell(DetectFertility)
        endIf

        SetToggleOptionValueST(PlayerRef.HasSpell(DetectFertility as form))
		ForcePageReset()
    endEvent

    event OnDefaultST()
        SetToggleOptionValueST(PlayerRef.HasSpell(DetectFertility as form))
    endEvent
endState
; deprecated 2.23
;/state DA2;MULTITHREADED_TOGGLE
	event OnSelectST()

		Handler.Storage.FMValues[2] = ((!Handler.Storage.FMValues[2] as bool) as int)
		SetToggleOptionValueST(Handler.Storage.FMValues[2] as bool)
		ForcePageReset()

	endEvent
	
	event OnDefaultST()
		SetToggleOptionValueST(Handler.Storage.FMValues[2] as bool)
	endEvent
endState/;

state DA3;WIDGET_SHOWN_TOGGLE
    event OnSelectST()
		GVHolder.WidgetShown = !GVHolder.WidgetShown
		ModEvent.Send(ModEvent.Create("FMPUpdateWidgetContent"))
        SetToggleOptionValueST(GVHolder.WidgetShown )
        ForcePageReset()
    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(GVHolder.WidgetShown )
    endEvent
endState

state DA4;ToggleBabyHealth
	event OnSelectSt()

		Handler.Storage.FMValues[7] = ((!Handler.Storage.FMValues[7] as bool) as int)
		SetToggleOptionValueSt(Handler.Storage.FMValues[7])
		if GVHolder.Enabled
			ModEvent.Send(ModEvent.Create("FMPUpdateWidgetContent"))
			ModEvent.Send(ModEvent.Create("FMPPlayerFactStat"))
		endIf
		ForcePageReset()
	endEvent

	event OnDefaultST()
		SetToggleOptionValueST(Handler.Storage.FMValues[7])
		if GVHolder.Enabled
			ModEvent.Send(ModEvent.Create("FMPUpdateWidgetContent"))
			ModEvent.Send(ModEvent.Create("FMPPlayerFactStat"))
		endIf
		ForcePageReset()
	endEvent
endState

state DA5;WIDGET_TOP_SLIDER
    event OnSliderOpenST()
        SetSliderDialogStartValue(GVHolder.WidgetTop)
        SetSliderDialogRange(0, 4320) ; 8K UHD overkill?
        SetSliderDialogInterval(1)
    endEvent
    
    event OnSliderAcceptST(float value)
        GVHolder.WidgetTop = value as int
		ModEvent.Send(ModEvent.Create("FMPUpdateWidgetContent"))
        SetSliderOptionValueST(value, "{0}px")
        ForcePageReset()
    endEvent
endState

state DA6;WIDGET_LEFT_SLIDER
    event OnSliderOpenST()
        SetSliderDialogStartValue(GVHolder.WidgetLeft)
        SetSliderDialogRange(0, 7680) ; 8K UHD overkill?
        SetSliderDialogInterval(1)
    endEvent
    
    event OnSliderAcceptST(float value)
        GVHolder.WidgetLeft = value as int
		ModEvent.Send(ModEvent.Create("FMPUpdateWidgetContent"))
        SetSliderOptionValueST(value, "{0}px")
        ForcePageReset()
    endEvent
endState
; 2.23
state DA2_MapWidget
	event	OnSelectST()
		GVHolder.MapWidgetKey = !GVHolder.MapWidgetKey
		FMMiscUtil.UpdateWidgetKey()
		ForcePageReset()
	endEvent
endState

state DA7;WIDGET_HOTKEY_MAP
    event OnKeyMapChangeST(int newCode, string conflictControl, string conflictName)

		bool doIt = true
        if (conflictControl != "")
 			doIt = ShowMessage("The key is already mapped to '" + conflictControl + "'. Continue?")
        endIf
		if doIt
			GVHolder.WidgetHotKey = (newCode)
			FMMiscUtil.UpdateWidgetKey()
			SetKeyMapOptionValueST(newCode)
		endIf
		ForcePageReset()

    endEvent
    
    event OnDefaultST()
        GVHolder.WidgetHotKey = (10)
        SetKeyMapOptionValueST(10)
    endEvent
endState

state DA8;CONCEPTION_CHANCE_SLIDER
    event OnSliderOpenST()
        SetSliderDialogStartValue(GVHolder.ConceptionChance)
        SetSliderDialogRange(0, 20)
        SetSliderDialogInterval(1)
    endEvent
    
    event OnSliderAcceptST(float value)
        GVHolder.ConceptionChance = value as int
        SetSliderOptionValueST(value, "{0}%")
		ForcePageReset()
    endEvent
endState

state DA9;ALLOW_CREATURES_TOGGLE
    event OnSelectST()
 
		GVHolder.AllowCreatures = !GVHolder.AllowCreatures
		GVHolder.ScanOptionsChanged = true
        SetToggleOptionValueST(GVHolder.AllowCreatures )
		ForcePageReset()
    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(GVHolder.AllowCreatures )
    endEvent
endState

state DAA;PREGNANCY_DURATION_SLIDER
    event OnSliderOpenST()
        SetSliderDialogStartValue(GVHolder.PregnancyDuration)
		if GVHolder.FADetected
			SetSliderDialogRange(12, 360)
		else
			SetSliderDialogRange(3, 360)
		endIf
        SetSliderDialogInterval(3)
    endEvent
    
    event OnSliderAcceptST(float value)
        GVHolder.PregnancyDuration	=	value as int
		Handler.Storage.FMValues[0]	=	(value / 3.0) as int
		GVHolder.UpdateGVs()
        SetSliderOptionValueST(value, "{0} day(s)")
		int handle = ModEvent.Create("FertilityModeActorsUpdated")
		if handle
			ModEvent.PushBool(handle, false)
			ModEvent.Send(handle)
		endIf
		ForcePageReset()
    endEvent
endState

state DAB;RECOVERY_DURATION_SLIDER
    event OnSliderOpenST()
        SetSliderDialogStartValue(GVHolder.RecoveryDuration)
        SetSliderDialogRange(2, 365)
        SetSliderDialogInterval(1)
    endEvent
    
    event OnSliderAcceptST(float value)
        GVHolder.RecoveryDuration		=	value as int
		if !(GVHolder.RecoveryDuration	>	GVHolder.BabyDuration)
			GVHolder.BabyDuration		=	GVHolder.RecoveryDuration - 1
		endIf
        SetSliderOptionValueST(value, "{0} day(s)")
		ForcePageReset()
    endEvent
endState

state SCALING_METHOD_MENU
    event OnMenuOpenST()
        SetMenuDialogStartIndex(GVHolder.ScalingMethod)
        SetMenuDialogDefaultIndex(0)
        SetMenuDialogOptions(_scaleTypeMenu)
    endEvent

    event OnMenuAcceptST(int index)
;/        int n = Math.LogicalAnd(Handler.Storage.TrackedActors.Length, 0x00000FFF)
		Actor STAn = none
        while (n)
            n -= 1
            
			STAn = Handler.Storage.TrackedActors[n] as Actor
            if STAn
                Handler.Util.ClearBellyBreastScale(STAn)
            endIf
			STAn = none
        endWhile/;

		GVHolder.ScalingMethod = (index)
		Handler.Util.FMUtilCacheVariables()
		GVHolder.UpdateGVs()
		SetMenuOptionValueST(_scaleTypeMenu[GVHolder.ScalingMethod])
		SendModEvent("FMPlusDoMorph", "", 0.0)
		ForcePageReset()
    endEvent
    
    event OnDefaultST()
        SetMenuOptionValueST(_scaleTypeMenu[GVHolder.ScalingMethod])
    endEvent
    
    event OnHighlightST()

        ; Type 0: "BodyMorph"
        ; Type 1: "NetImmerse"
        ; Type 2: "NiOverride"
        ; Type 3: "SLIF"
		; Type 4: "no morphs"
        if (GVHolder.ScalingMethod  == 0)
            SetInfoText("Select the belly/breast scaling method\nBodyMorph uses morphs from RaceMenu/BodySlide. This is generally the best looking method")
        elseIf (GVHolder.ScalingMethod  == 1)
            SetInfoText("Select the belly/breast scaling method\nNetImmerse is the most widely compatible. Belly and breast nodes are required")
        elseIf (GVHolder.ScalingMethod  == 2)
            SetInfoText("Select the belly/breast scaling method\nNiOverride is an extension onto SKSE. Belly and breast nodes are required")
        elseIf (GVHolder.ScalingMethod  == 3)
			if Handler.Storage.FMValues[4]
				SetInfoText("Select the belly/breast scaling method\nSexLab Inflation Framework is a general scaling utility that uses tools currently installed\nThis option is recommended when using multiple mods that scale the same features")
			else
				SetInfoText("Select the belly/breast scaling method\nSexLab Inflation Framework is a general scaling utility that uses tools currently installed\nNOTE: Skyrim is reporting that SLIF is not installed!")
			endIf
        else
			SetInfoText("If you're using body types that don't have morph bones, or prefer to not see morphs select this.")
		endIf
    endEvent
endState

state DAC;BELLY_SCALE_MAX_SLIDER
    event OnSliderOpenST()
        SetSliderDialogStartValue(GVHolder.BellyScaleMax)
        SetSliderDialogRange(1, 12)
        SetSliderDialogInterval(1)
    endEvent

    event OnSliderAcceptST(float value)
        GVHolder.BellyScaleMax = (value)
        SetSliderOptionValueST(value, "{0}x")
		GVHolder.UpdateGVs()
		ModEvent.Send(ModEvent.Create("FMUtilityCacheVars"))
		ForcePageReset()
    endEvent
endState

state DAD;BELLY_SCALE_MULT_SLIDER
    event OnSliderOpenST()
        SetSliderDialogStartValue(GVHolder.BellyScaleMult )
        SetSliderDialogRange(0.1, 10.0)
        SetSliderDialogInterval(0.1)
    endEvent
    
    event OnSliderAcceptST(float value)
        GVHolder.BellyScaleMult = (value)
        SetSliderOptionValueST(value, "{1}")
		GVHolder.UpdateGVs()
		ModEvent.Send(ModEvent.Create("FMUtilityCacheVars"))
		ForcePageReset()
    endEvent
endState

state DAE;BREAST_SCALE_MULT_SLIDER
    event OnSliderOpenST()
        SetSliderDialogStartValue(GVHolder.BreastScaleMult )
        SetSliderDialogRange(0.1, 10.0)
        SetSliderDialogInterval(0.1)
    endEvent
    
    event OnSliderAcceptST(float value)
        GVHolder.BreastScaleMult = (value)
        SetSliderOptionValueST(value, "{1}")
		GVHolder.UpdateGVs()
		ModEvent.Send(ModEvent.Create("FMUtilityCacheVars"))
		ForcePageReset()
    endEvent
endState

state BIRTH_TYPE_MENU
    event OnMenuOpenST()
        SetMenuDialogOptions(BirthTypeMenu)
        SetMenuDialogStartIndex(GVHolder.BirthType)
        SetMenuDialogDefaultIndex(0)
    endEvent
    
    event OnMenuAcceptST(int index)
        GVHolder.BirthType = (index)
		GVHolder.UpdateGVs()
		if (index != 2)
			GVHolder.AdoptionEnabled	=	false
			GVHolder.SpawnEnabled		=	false
			GVHolder.TrainingEnabled	=	false
			if (index == 0)
				GVHolder.LaborEnabled	=	false
			endIf
		endIf
        SetMenuOptionValueST(BirthTypeMenu[index])
        ForcePageReset()
    endEvent
    
    event OnHighlightST()

        ; Type 0: "None"
        ; Type 1: "Soul Gem"
        ; Type 2: "Baby Item"
        if (GVHolder.BirthType  == 0)
            SetInfoText("Select the result of pregnancy\nNo effect. Pregnancy simply ends")
        elseIf (GVHolder.BirthType  == 1)
            SetInfoText("Select the result of pregnancy\nA filled black soul gem is added to the actor's inventory")
        elseIf (GVHolder.BirthType  == 2)
            SetInfoText("Select the result of pregnancy\nA baby item is added to the actor's inventory and equipped\nThe player's babies may grow into child NPCs")
        endIf
    endEvent
endState

state BIRTH_RACE_MENU
    event OnMenuOpenST()
        SetMenuDialogOptions(_birthRaceMenu)
        SetMenuDialogStartIndex(GVHolder.BirthRace)
        SetMenuDialogDefaultIndex(0)
    endEvent
    
    event OnMenuAcceptST(int index)
        GVHolder.BirthRace = (index)
        SetMenuOptionValueST(_birthRaceMenu[index])
        ForcePageReset()
    endEvent
    
    event OnHighlightST()

        ; Type 0: "Mother"
        ; Type 1: "Father"
        ; Type 2: "Random"
		; 3 = specific
        if (GVHolder.BirthRace  == 0)
            SetInfoText("Select the inherited race of children\nBased on the mother")
        elseIf (GVHolder.BirthRace  == 1)
            SetInfoText("Select the inherited race of children\nBased on the father\nDefaults to the mother if the father cannot be identified")
        elseIf (GVHolder.BirthRace  == 2)
            SetInfoText("Select the inherited race of children\nBased on a random choice between mother and father\nDefaults to the mother if the father cannot be identified")
        else
			SetInfoText("Choose the race of children")
		endIf
    endEvent
endState

state DAF;BIRTH_RACE_SPECIFIC_MENU
    event OnMenuOpenST()
        SetMenuDialogOptions(Handler.Storage.ParentStrings)
        SetMenuDialogStartIndex(GVHolder.BirthRaceSpecific)
        SetMenuDialogDefaultIndex(0)
    endEvent
    
    event OnMenuAcceptST(int index)
        GVHolder.BirthRaceSpecific = index
        SetMenuOptionValueST(Handler.Storage.ParentStrings[index])
        ForcePageReset()
    endEvent
endState

state DB0;MISCARRIAGE_ENABLED_TOGGLE
    event OnSelectST()

		GVHolder.MiscarriageEnabled = !GVHolder.MiscarriageEnabled
		GVHolder.UpdateGVs()
		Handler.FMSpellHandler.MiscarriageState()
        
        SetToggleOptionValueST(GVHolder.MiscarriageEnabled )
        ForcePageReset()
    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(GVHolder.MiscarriageEnabled )
    endEvent
endState

state DB1;SOUND_VOLUME_SLIDER
    event OnSliderOpenST()
        SetSliderDialogStartValue(GVHolder.SoundVolume)
        SetSliderDialogRange(0.0, 1.0)
        SetSliderDialogInterval(0.1)
    endEvent
    
    event OnSliderAcceptST(float value)
        GVHolder.SoundVolume = (value)
        SetSliderOptionValueST(value, "{1}x")
		ForcePageReset()
    endEvent
endState

state DB2;LABOR_ENABLED_TOGGLE
    event OnSelectST()

		GVHolder.LaborEnabled = !GVHolder.LaborEnabled
		GVHolder.UpdateGVs()
        
        SetToggleOptionValueST(GVHolder.LaborEnabled )
        ForcePageReset()
    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(GVHolder.LaborEnabled )
    endEvent
endState

state DB3;SPAWN_ENABLED_TOGGLE
    event OnSelectST()

		GVHolder.SpawnEnabled		=	!GVHolder.SpawnEnabled
		GVHolder.AdoptionEnabled	=	(GVHolder.AdoptionEnabled && GVHolder.SpawnEnabled)
		GVHolder.TrainingEnabled	=	(GVHolder.TrainingEnabled && GVHolder.SpawnEnabled)
        
        SetToggleOptionValueST(GVHolder.SpawnEnabled )
        ForcePageReset()
    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(GVHolder.SpawnEnabled )
    endEvent
endState

state DB4;BIRTH_BABY_ADOPTION_TOGGLE
    event OnSelectST()

		GVHolder.AdoptionEnabled = !GVHolder.AdoptionEnabled
        SetToggleOptionValueST(GVHolder.AdoptionEnabled )
        ForcePageReset()

    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(GVHolder.AdoptionEnabled )
    endEvent
endState

state DB5;BIRTH_BABY_TRAINING_TOGGLE
    event OnSelectST()

		GVHolder.TrainingEnabled = !GVHolder.TrainingEnabled
        SetToggleOptionValueST(GVHolder.TrainingEnabled )
        ForcePageReset()

    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(GVHolder.TrainingEnabled )
    endEvent
endState

state DB6;LABOR_DURATION_SLIDER
    event OnSliderOpenST()
        SetSliderDialogStartValue(GVHolder.LaborDuration)
        SetSliderDialogRange(10, 360)
        SetSliderDialogInterval(1)
    endEvent
    
    event OnSliderAcceptST(float value)
        GVHolder.LaborDuration = value as int
		GVHolder.UpdateGVs()
        SetSliderOptionValueST(value, "{0}s")
		ForcePageReset()
    endEvent
endState

state DB7;BIRTH_BABY_DURATION_SLIDER
    event OnSliderOpenST()
        SetSliderDialogStartValue(GVHolder.BabyDuration)
        SetSliderDialogRange(1, 360)
        SetSliderDialogInterval(1)
    endEvent
    
    event OnSliderAcceptST(float value)
        GVHolder.BabyDuration			=	value as int
		if !(GVHolder.RecoveryDuration	>	GVHolder.BabyDuration)
			GVHolder.RecoveryDuration	=	GVHolder.BabyDuration + 1
		endIf
        SetSliderOptionValueST(value, "{0} day(s)")
		ForcePageReset()
    endEvent
endState

state DB8;SPOUSE_FIDELITY_SLIDER
    event OnSliderOpenST()
        SetSliderDialogStartValue(GVHolder.SpouseInseminateChance)
        SetSliderDialogRange(0, 100)
        SetSliderDialogInterval(1)
    endEvent
    
    event OnSliderAcceptST(float value)
        GVHolder.SpouseInseminateChance = value as int
        SetSliderOptionValueST(value, "{0}%")
		ForcePageReset()
    endEvent
endState

state DB9;AUTO_INSEMINATE_TOGGLE
    event OnSelectST()

		GVHolder.AutoInseminateNpc = !GVHolder.AutoInseminateNpc
		if (GVHolder.AutoInseminatePc || GVHolder.AutoInseminateNpc)
			if (GVHolder.AutoInseminateChance < 1)
				GVHolder.AutoInseminateChance = 1
			endIf
		endIf
		GVHolder.ScanOptionsChanged = true
        SetToggleOptionValueST(GVHolder.AutoInseminateNpc )
        ForcePageReset()

    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(GVHolder.AutoInseminateNpc )
    endEvent
endState

state DBA;AUTO_INSEMINATE_PC_TOGGLE
    event OnSelectST()

		GVHolder.AutoInseminatePc = !GVHolder.AutoInseminatePc
		if (GVHolder.AutoInseminatePc || GVHolder.AutoInseminateNpc)
			if (GVHolder.AutoInseminateChance < 1)
				GVHolder.AutoInseminateChance = 1
			endIf
		endIf
		GVHolder.ScanOptionsChanged		=	true
		GVHolder.AutoInseminatePcSleep	=	(GVHolder.AutoInseminatePc as int * GVHolder.AutoInseminatePcSleep as int) as bool
		GVHolder.AutoInseminateChance	=	(GVHolder.AutoInseminateChance * ((GVHolder.AutoInseminatePc || GVHolder.AutoInseminateNpc) as int))
        SetToggleOptionValueST(GVHolder.AutoInseminatePc )
		ForcePageReset()

    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(GVHolder.AutoInseminatePc )
    endEvent
endState

state DBB;AUTO_INSEMINATE_PC_SLEEP_TOGGLE
    event OnSelectST()

		GVHolder.AutoInseminatePcSleep = !GVHolder.AutoInseminatePcSleep
        SetToggleOptionValueST(GVHolder.AutoInseminatePcSleep )
		ForcePageReset()

    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(GVHolder.AutoInseminatePcSleep )
    endEvent
endState

state DBC;AUTO_INSEMINATE_CHANCE_SLIDER
    event OnSliderOpenST()
        SetSliderDialogStartValue(GVHolder.AutoInseminateChance)
        SetSliderDialogRange(0, 10)
        SetSliderDialogInterval(1)
    endEvent
    
    event OnSliderAcceptST(float value)
        GVHolder.AutoInseminateChance	=	value as int
		if (value == 0.0)
			GVHolder.AutoInseminateNpc	=	false
			GVHolder.AutoInseminatePc	=	false
		endIf
		GVHolder.ScanOptionsChanged		=	true
        SetSliderOptionValueST(value, "{0}%")
		ForcePageReset()
    endEvent
endState

state PLAYER_ONLY_FILTER_MENU
    event OnMenuOpenST()
        SetMenuDialogOptions(_trackingFilter)
        SetMenuDialogStartIndex(_trackingFilterIndex)
        SetMenuDialogDefaultIndex(0)
    endEvent
    
    event OnMenuAcceptST(int index)
        _trackingFilterIndex = index
        _trackingFilterPage = 0
        SetMenuOptionValueST(_trackingFilter[index])
        ForcePageReset()
    endEvent
    
    event OnHighlightST()

        ; 0: All
        ; 1: Unique
        ; 2: Ovulating
        ; 3: Pregnant
        ; 4: Player Only
        if (_trackingFilterIndex == 0)
        	SetInfoText("The list is unfiltered, showing all currently-tracked characters.")
        elseIf (_trackingFilterIndex == 1)
            SetInfoText("Filters the tracking list to only unique characters.")
        elseIf (_trackingFilterIndex == 2)
            SetInfoText("Filters the tracking list to only ovulating characters.")
        elseIf (_trackingFilterIndex == 3)
            SetInfoText("Filters the tracking list to only pregnant characters.")
        elseIf (_trackingFilterIndex == 4)
        	SetInfoText("Filters the tracking list to those where the player is involved in the relationship")
        endIf
    endEvent
endState

state DBD;TRACKING_PREV_PAGE
	event OnSelectST()
		_trackingFilterPage -= 1
        ForcePageReset()
    endEvent
endState

state DBE;TRACKING_PREV_10_PAGE
    event OnSelectST()
		_trackingFilterPage -= 10
		if _trackingFilterPage < 0
			_trackingFilterPage = 0
		endIf
        ForcePageReset()
    endEvent
endState

state DBF;TRACKING_NEXT_PAGE
	event OnSelectST()
		_trackingFilterPage += 1
        ForcePageReset()
    endEvent
endState

state DC0;TRACKING_NEXT_10_PAGE
    event OnSelectST()
		int lastPage = Math.Ceiling(actorsThisType / _actorsPerPage)
        _trackingFilterPage += 10
		if _trackingFilterPage > lastPage
			_trackingFilterPage = lastPage
		endIf
        ForcePageReset()
    endEvent
endState

state DC1;TRAINING_PREV_PAGE
	event OnSelectST()
		_trainingFilterPage -= 1
        ForcePageReset()
    endEvent
endState

state DC2;TRAINING_NEXT_PAGE
	event OnSelectST()
		_trainingFilterPage += 1
        ForcePageReset()
    endEvent
endState

state DC3;DEBUG_CLEAR_TRACKING
    event OnSelectST()
        int i = Math.LogicalAnd(Handler.Storage.TrackedActors.Length, 0x00000FFF)
        
        while (i)
            i -= 1
            Handler.Storage.TrackedActorRemove(i, false)
        endWhile
        
        i = Math.LogicalAnd(Handler.Storage.TrackedFathers.Length, 0x00000FFF)
        
        while (i)
            i -= 1
            Handler.Storage.TrackedFatherRemove(i, false)
        endWhile
        
        Handler.Util.AddToTracking(PlayerRef)	; Attempt to track the player
        Handler.ScheduledUpdater.UpdateStatusAll(false, false) ; Force an out of band update for widgets and morphs
        
        ForcePageReset()
    endEvent
endState

state DC4;DEBUG_CLEAR_NPC_TRACKING
    event OnSelectST()
        int i = Math.LogicalAnd(Handler.Storage.TrackedActors.Length, 0x00000FFF)
        
        while (i)
            i -= 1
            
            if (Handler.Storage.TrackedActors[i] != playerRefForm)
                Handler.Storage.TrackedActorRemove(i, false)
            endIf
        endWhile
        
        i = Math.LogicalAnd(Handler.Storage.TrackedFathers.Length, 0x00000FFF)
        
        while (i)
            i -= 1
            Handler.Storage.TrackedFatherRemove(i, false)
        endWhile
        
        Handler.ScheduledUpdater.UpdateStatusAll(false, false) ; Force an out of band update for widgets and morphs
        
        ForcePageReset()
    endEvent
endState

state DC5;PLAYER_ADD_SPERM
    event OnSelectST()

		; 1.56
		Handler.FMEventHandler.FMAddSpermEvent(playerRefForm, "", playerRefForm)

        ForcePageReset()
    endEvent
endState

state DC6;PLAYER_OVULATE
    event OnSelectST()
        int index = Handler.Storage.TrackedActors.Find(playerRefForm)
        
        Handler.Storage.LastOvulation[index] = 0.001
		if GVHolder.Enabled
			ModEvent.Send(ModEvent.Create("FMPUpdateWidgetContent"))
			ModEvent.Send(ModEvent.Create("FMPPlayerFactStat"))
		endIf

        ForcePageReset()
    endEvent
endState

state DC7;PLAYER_REMOVE_SPERM
    event OnSelectST()
		; 1.57 that's what the function is for!
		Handler.FMSpellHandler.FMDecopulate(playerRefForm)
        ForcePageReset()
    endEvent
endState

state DC8;PLAYER_IMPREGNATE
    event OnSelectST()

		; 1.56
		Handler.FMEventHandler.FMImpregnateEvent(playerRefForm)

        ForcePageReset()
    endEvent
endState

state DC9;PLAYER_BIRTH
    event OnSelectST()
        
		int handle = ModEvent.Create("FMPlusLabor")
		if handle
			ModEvent.PushString(handle, "")
			ModEvent.PushForm(handle, playerRefForm)
			ModEvent.PushInt(handle, -1)
			ModEvent.Send(handle)
		endIf

        ForcePageReset()
    endEvent
endState

state DCA;PLAYER_ABORT
    event OnSelectST()

		Handler.FMSpellHandler.FMAbortionEvent(playerRefForm)
        ForcePageReset()
    endEvent
endState

state DCB;PLAYER_GROWTH
    event OnSelectST()
    	int n = Math.LogicalAnd(Handler.Storage.BirthBabyRace.Length, 0x000000FF)
    	Armor baby = none
		
		while (n && (baby == none))
	        n -= 1
	        if (PlayerRef.GetItemCount(Handler.Storage.BirthBabyRace[n]) != 0)
	            baby = Handler.Storage.BirthBabyRace[n] as armor
	        endIf
    	endWhile
		int index = Handler.Storage.TrackedActors.Find(playerRefForm)
		FMAdoptQuest.SetCurrentStageID(10)
		Actor child = FMAdoptScript.TrySpawnChildAdopt(PlayerRef)
		if child
			PlayerRef.RemoveItem(baby, 1)
;			Handler.Storage.LastFather[index]		=	""
			; 2.08
			Handler.Storage.LastFatherForm[index]	=	none
			Handler.Storage.BabyAdded[index]		=	0.0
			Handler.Storage.BabyHealth				=	105
			FMAdoptScript.RenameChild(child)
		endIf
;		FMAdoptQuest.SetCurrentStageID(20)
		ForcePageReset()
    endEvent
endState

state DCC;SPAWN_CHILD_PLAYER_MALE
    event OnSelectST()
		int raceIndex = Handler.Storage.GetRaceIndex(playerRef, -1, true)

		if (raceIndex != -1)
			ActorBase childBase = Handler.Storage.Children[2 * raceIndex] as actorbase
			PlayerRef.PlaceActorAtMe(childBase)
			ShowMessage("Spawn completed")
		else
			ShowMessage("Unable to spawn. Unsupported player race")
		endIf
		ForcePageReset()
	endEvent
endState

state DCD;SPAWN_CHILD_PLAYER_FEMALE
    event OnSelectST()
		int raceIndex = Handler.Storage.GetRaceIndex(playerRef, -1, true)

		if (raceIndex != -1)
			ActorBase childBase = Handler.Storage.Children[2 * raceIndex + 1] as actorbase
			PlayerRef.PlaceActorAtMe(childBase)
			ShowMessage("Spawn completed")
		else
			ShowMessage("Unable to spawn. Unsupported player race")
		endIf
		ForcePageReset()
    endEvent
endState

state DCE;SPAWN_CHILD_PLAYER_ALL
    event OnSelectST()
        int n = Math.LogicalAnd(Handler.Storage.Children.Length, 0x00000FFF)
        
        while (n)
            n -= 1
            PlayerRef.PlaceActorAtMe(Handler.Storage.Children[n] as actorbase)
        endWhile
        
        ShowMessage("Spawn completed")
		ForcePageReset()
    endEvent
endState

state DCF;RENAME_CHILD_PLAYER
    event OnSelectST()
        
		FMAdoptQuest.SetCurrentStageID(10)
        FMAdoptScript.RenameChild(Game.GetCurrentCrosshairRef() as Actor)
        
        ShowMessage("Naming completed")
;		FMAdoptQuest.SetCurrentStageID(20)
		ForcePageReset()
    endEvent
endState

state DD0;DESPAWN_CHILD_PLAYER
    event OnSelectST()
        Actor kActor = Game.GetCurrentCrosshairRef() as Actor
        
        kActor.Disable()
        kActor.Delete()
        
        ShowMessage("Despawn completed")
		ForcePageReset()
    endEvent
endState

state DD1;ADOPT_CHILD_PLAYER
    event OnSelectST()
		FMAdoptQuest.SetCurrentStageID(10)
        string result = FMAdoptScript.TryAdoptChildMcm(Game.GetCurrentCrosshairRef() as Actor)
        
        ShowMessage(result)
;		FMAdoptQuest.SetCurrentStageID(20)
		ForcePageReset()
    endEvent
endState

state DD2;NPC_TRACK
    event OnSelectST()
        
        Handler.Util.AddToTracking(Game.GetCurrentCrosshairRef() as Actor)
        ForcePageReset()
    endEvent
endState

state DD3;NPC_BLOCK
    event OnSelectST()
        
        Handler.Storage.TrackedActorBlock(Game.GetCurrentCrosshairRef() as Actor)
        ForcePageReset()
    endEvent
endState

state DD4;NPC_UNBLOCK
    event OnSelectST()
        
        Handler.Storage.TrackedActorUnblock(Game.GetCurrentCrosshairRef() as Actor)
        ForcePageReset()
    endEvent
endState

state DD5;NPC_BLACKLIST
	event OnSelectST()
		Handler.Storage.TrackedActorNameBlock((Game.GetCurrentCrosshairRef() as actor).GetDisplayName(), GVHolder.VerboseMode)
		ForcePageReset()
	endEvent
endState

state DD6;NPC_UNBLACKLIST
	event OnSelectST()
		Handler.Storage.TrackedActorNameUnblock((Game.GetCurrentCrosshairRef() as actor).GetDisplayName())
		ForcePageReset()
	endEvent
endState

state DD7;NPC_OVULATE
    event OnSelectST()

        int index = Handler.Storage.TrackedActors.Find(Game.GetCurrentCrosshairRef() as Form)
		if (index != -1)
			Handler.Storage.LastOvulation[index] = 0.001
		endIf
        ForcePageReset()
    endEvent
endState

state DD8;NPC_ADD_SPERM
    event OnSelectST()

		Handler.FMEventHandler.FMAddSpermEvent((Game.GetCurrentCrosshairRef() as Form), (PlayerRef as objectReference).GetDisplayName(), playerRefForm)
        ForcePageReset()
    endEvent
endState

state DD9;NPC_REMOVE_SPERM
    event OnSelectST()

		Handler.FMSpellHandler.FMDecopulate(Game.GetCurrentCrosshairRef() as Form)
        ForcePageReset()
    endEvent
endState

state DDA;NPC_IMPREGNATE
    event OnSelectST()

		Handler.FMEventHandler.FMImpregnateEvent(Game.GetCurrentCrosshairRef() as form)
        ForcePageReset()
    endEvent
endState

state DDB;NPC_BIRTH
    event OnSelectST()
 
		int handle = ModEvent.Create("FMPlusLabor")
		if handle
			ModEvent.PushString(handle, "")
			ModEvent.PushForm(handle, Game.GetCurrentCrosshairRef() as Form)
			ModEvent.PushInt(handle, -1)
			ModEvent.Send(handle)
		endIf
        ForcePageReset()
    endEvent
endState

state DDC;NPC_ABORT
    event OnSelectST()

		Handler.FMSpellHandler.FMAbortionEvent(Game.GetCurrentCrosshairRef() as Form)
        ForcePageReset()
    endEvent
endState

state DDD;NPC_GROWTH
    event OnSelectST()

        Actor	kActor	=	Game.GetCurrentCrosshairRef() as Actor
        int		n		=	Math.LogicalAnd(Handler.Storage.BirthBabyRace.Length, 0x000000FF)
    	Armor	baby	=	none
        while ((n > 0) && (baby == none))
	        n -= 1
	        
	        if (kActor.GetItemCount(Handler.Storage.BirthBabyRace[n]) != 0)
	            baby = Handler.Storage.BirthBabyRace[n] as armor
	        endIf
    	endWhile

        int		index	=	Handler.Storage.TrackedActors.Find(kActor)
		FMAdoptQuest.SetCurrentStageID(10)
		Actor	child	=	FMAdoptScript.TrySpawnChildAdopt(kActor)
        if child
            kActor.RemoveItem(baby, 1)
;            Handler.Storage.LastFather[index]		=	""
			; 2.08
			Handler.Storage.LastFatherForm[index]	=	none
            Handler.Storage.BabyAdded[index]		=	0.0
			; 1.57 set max babyhealth to 105
            Handler.Storage.BabyHealth				=	105
            FMAdoptScript.RenameChild(child)
        endIf
;		FMAdoptQuest.SetCurrentStageID(20)

        ForcePageReset()
    endEvent
endState

state DDE;INSEMINATE_SPELL_TOGGLE
    event OnSelectST()
        if !playerRef.HasSpell(InseminateSpell as form)
            GVHolder.InseminateSpellAdded = true
            PlayerRef.AddSpell(InseminateSpell)
        else
            GVHolder.InseminateSpellAdded = false
            PlayerRef.RemoveSpell(InseminateSpell)
        endIf
        
        SetToggleOptionValueST(GVHolder.InseminateSpellAdded )
        ForcePageReset()
    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(GVHolder.InseminateSpellAdded )
    endEvent
endState

state DDF;IMPREGNATE_SPELL_TOGGLE
    event OnSelectST()
        if !playerRef.HasSpell(ImpregnateSpell as form)
            GVHolder.ImpregnateSpellAdded = true
            PlayerRef.AddSpell(ImpregnateSpell)
        else
            GVHolder.ImpregnateSpellAdded = false
            PlayerRef.RemoveSpell(ImpregnateSpell)
        endIf
        
        SetToggleOptionValueST(GVHolder.ImpregnateSpellAdded )
        ForcePageReset()
    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(GVHolder.ImpregnateSpellAdded )
    endEvent
endState

state DE0;BIRTH_SPELL_TOGGLE
    event OnSelectST()
        if !playerRef.HasSpell(BirthSpell as form)
            GVHolder.BirthSpellAdded = true
            PlayerRef.AddSpell(BirthSpell)
        else
            GVHolder.BirthSpellAdded = false
            PlayerRef.RemoveSpell(BirthSpell)
        endIf
        
        SetToggleOptionValueST(GVHolder.BirthSpellAdded )
        ForcePageReset()
    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(GVHolder.BirthSpellAdded )
    endEvent
endState

state DE1;ABORT_SPELL_TOGGLE
    event OnSelectST()
        if !playerRef.HasSpell(AbortSpell as form)
            GVHolder.AbortSpellAdded = true
            PlayerRef.AddSpell(AbortSpell)
        else
            GVHolder.AbortSpellAdded = false
            PlayerRef.RemoveSpell(AbortSpell)
        endIf
        
        SetToggleOptionValueST(GVHolder.AbortSpellAdded )
        ForcePageReset()
    endEvent
    
    event OnDefaultST()
        SetToggleOptionValueST(GVHolder.AbortSpellAdded )
    endEvent
endState

; 1.67
state FG_CLOAK_SPELL_TOGGLE
	event OnSelectST()
		if playerRef.IsInFaction(FGCloakEnable)
			playerRef.RemoveFromFaction(FGCloakEnable)
		elseIf (Game.GetModByName("FlowerGirls SE.esm") != 255)
			playerRef.SetFactionRank(FGCloakEnable, 0)
		endIf
		
		SetToggleOptionValueST(playerRef.IsInFaction(FGCloakEnable))
		ForcePageReset()
	endEvent


	event OnDefaultST()
		playerRef.RemoveFromFaction(FGCloakEnable)
	endEvent

	event OnHighLightST()
		if (Game.GetModByName("FlowerGirls SE.esm") != 255)
			SetInfoText("Toggles monitoring NPCs for sex acts if Flower Girls is installed.\nSkyrim is reporting that Flower Girls is installed.")
		else
			SetInfoText("Toggles monitoring NPCs for sex acts if Flower Girls is installed.\nSkyrim is reporting that Flower Girls is NOT installed.")
		endIf
	endEvent
		
endState

event OnHighlightST()

;/	the State *is* the FormID that contains the text string
	i.e. State "D9A" uses the name field from plugin FormID D9A as its text string	
	the StringUtil and Math calls in this require SKSE	/;

	string theState = GetState()
	if theState == ""
		SetInfoText("")
		return
	endIf
	string myString = MCMHelper.GetThatString(theState)
	if myString
		SetInfoText(myString)
		return
	endIf
	SetInfoText("")

endEvent
; 2.17
event	OnOptionSelect(int option)

	; if it's not a tracking page, GTFO
	if ((pageIndex != 2) && (pageIndex != 3))
		return
	endIf
	int			indexStart		=	_actorsPerPage * _trackingFilterPage
	; yeah, because this wasn't obscure *at all* to figure out...
	int			actorPosition	=	Math.RightShift((option - (Math.LeftShift((pageIndex + 1), 8) + 8)), (3 - pageIndex))
	int			actorIndex		=	indexStart + actorPosition
	int			crossCheck		=	MCMHelper.returnList[actorIndex]
	if (pageIndex == 2)
		bool	isEven			=	(option as float / 2.0) == (((option as float / 2.0) as int) as float)
        form	trackedActor	=	Handler.Storage.TrackedActors[crossCheck]

		if (trackedActor == none) || (trackedActor == playerRefForm)
			return
		endif

		bool	uniqueActor		=	(trackedActor as actor).GetLeveledActorBase().IsUnique()
		if isEven

			string name = (trackedActor as actor).GetDisplayName()
			if uniqueActor
				if (Handler.Storage.ActorBlackList.Find(trackedActor) == -1)
					if ShowMessage(MCMHelper.GetThatString("DE9") + name + MCMHelper.GetThatString("DEB"), true)
						Handler.Storage.TrackedActorBlock(trackedActor as actor)
;						MCMHelper.OnUpdate()
						MCMHelper.CountFilteredActors(_trackingFilterIndex)
						ForcePageReset()
					endIf
				else
					if ShowMessage(MCMHelper.GetThatString("DD4"), true)
						Handler.Storage.TrackedActorUnblock(trackedActor as actor)
						ForcePageReset()
					endIf
				endIf
			else
				if ShowMessage(MCMHelper.GetThatString("DEA") + name + MCMHelper.GetThatString("DEB"), true)
					Handler.Storage.TrackedActorNameBlock(name, GVHolder.VerboseMode)
;					MCMHelper.OnUpdate()
					MCMHelper.CountFilteredActors(_trackingFilterIndex)
					ForcePageReset()
				endIf
			endIf
;		else
; future code for odd (right-column) clicks can go here.  Maybe.	
		endIf
	else
        form	trackedActor	=	Handler.Storage.TrackedFathers[crossCheck]
		bool	uniqueActor		=	(trackedActor as actor).GetLeveledActorBase().IsUnique()
		if trackedActor == playerRefForm
			return
		endif

		string name = (trackedActor as actor).GetDisplayName()
		if uniqueActor
			if (Handler.Storage.ActorBlackList.Find(trackedActor) == -1)
				if ShowMessage(MCMHelper.GetThatString("DE9") + name + MCMHelper.GetThatString("DEB"), true)
					Handler.Storage.TrackedActorBlock(trackedActor as actor)
;					MCMHelper.OnUpdate()
;					MCMHelper.CountFilteredActors(_trackingFilterIndex)
					ForcePageReset()
				endIf
			else
				if ShowMessage(MCMHelper.GetThatString("DD4"), true)
					Handler.Storage.TrackedActorUnblock(trackedActor as actor)
					ForcePageReset()
				endIf
			endIf
		else
			if ShowMessage(MCMHelper.GetThatString("DEA") + name + MCMHelper.GetThatString("DEB"), true)
				Handler.Storage.TrackedActorNameBlock(name, GVHolder.VerboseMode)
				MCMHelper.OnUpdate()
				MCMHelper.CountFilteredActors(_trackingFilterIndex)
				ForcePageReset()
			endIf
		endIf
	endIf
endEvent
