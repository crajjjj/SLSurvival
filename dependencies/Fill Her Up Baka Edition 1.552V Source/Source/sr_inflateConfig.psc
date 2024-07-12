Scriptname sr_inflateConfig extends SKI_ConfigBase

sr_infPlayer property infPlayer auto

sr_inflateQuest Property inflater auto
sr_inflateMessages Property dialogue auto
sr_infEventManager Property eventManager auto
GlobalVariable Property sr_inflatedCommentChance auto
Globalvariable Property sr_OnEventNoDeflation Auto
Globalvariable Property sr_OnEventAbsorbSperm Auto
Globalvariable Property sr_OnEventAbsorbSpermOral Auto
GlobalVariable Property sr_Cumvariation Auto
GlobalVariable Property sr_Cumvariationingredients Auto
Globalvariable Property sr_followerCommentChance Auto
Globalvariable Property sr_ExpelFaliure Auto
Globalvariable Property sr_MoanSound Auto
Globalvariable Property sr_SexlabMoanSound Auto
Globalvariable Property sr_SendingSpermDataChance Auto
Globalvariable Property sr_SendingSpermDataCriterion Auto
int MoanSoundOID
int SexlabMoanSoundOID
bool property MoanSound auto hidden
bool property SexlabMoanSound auto hidden

int property minInflationTime Auto hidden
int property minInflationTimeDefault = 12 autoreadonly hidden
int minInflationTimeOID

float Property OralmaxInflation auto hidden;Need MCM
float Property OralmaxInflationDefault = 2.0 autoreadonly hidden;Need MCM
float Property maxInflation auto hidden
float property maxInflationDefault = 6.0 autoreadonly hidden
int maxInflationOID
int OralmaxInflationOID

bool property logging auto hidden
bool property loggingDefault = true autoreadonly hidden
int loggingOID

bool property animDeflate auto hidden
bool property animDeflateDefault = true autoreadonly hidden
int animDeflateOID

float property animMult auto hidden
float property animMultDefault = 1.0 autoreadonly hidden 
int animMultOID

bool property encumber auto hidden
bool property encumberDefault = false autoreadonly hidden

int encumberOID
int SFU_PlacePuddlesOID
Bool Property SFU_PlacePuddles Auto
bool property SFU_PlacePuddlesDefault = true autoreadonly hidden

bool property VariousCumIngredients = true auto hidden
bool property VariousCum = true auto hidden
bool property VariousCumDefault = true autoreadonly hidden
bool property VariousCumIngredientsDefault = true autoreadonly hidden
bool property strip auto hidden
bool property stripDefault = true autoreadonly hidden
int stripOID
int VariousCumOID
int VariousCumIngredientsOID


bool property statusMsg auto hidden
bool property statusMsgDefault = true autoreadonly hidden
int statusMsgOID

float property DeflatechanceDefault = 50.0 autoreadonly hidden
float property statusMsgChanceDefault = 50.0 autoreadonly hidden
int statusMsgChanceOID
int DeflatechanceOID
float property Deflatechance = 50.0 Auto hidden

bool property followerComments auto hidden
bool property npcComments auto hidden
bool property npcCommentsDefault = true autoreadonly hidden
bool property followerCommentsDefault = true autoreadonly hidden
int npcCommentsOID
int followerCommentsOID

bool property bellyScale auto hidden
bool property bellyScaleDefault = true autoreadonly hidden
int bellyScaleOID

int FertilityOID


bool resetting = false
bool resettingquest = false
int resetOID
int resetquestOID

bool property enabled = true auto hidden
int enabledOID

bool property femaleEnabled = true auto hidden
int femaleEnabledOID

bool property maleEnabled = true auto hidden
int maleEnabledOID

String Property FHUMorphString = "PregnancyBelly" Auto
String Property FHUMorphString2 = "" Auto
String Property FHUMorphString3 = "" Auto
String Property FHUMorphString4 = "" Auto
String RACE_LIST = "sr.inflater.race.list"
String CREATURERACE_LIST = "sr.inflater.creaturerace.list"
int[] raceOID
int[] CreatureRaceOID
Race[] Property defaultRaceList auto
Race[] Property defaultCreatureRaceList auto

int property defKey = -1 auto hidden
int property defKeyDefault = 81 autoreadonly hidden
int defKeyOID

int cumMultOID

int eventIntervalOID
int eventSendeventChanceOID
int eventSendeventCriterionOID
float property eventIntervalDefault = 1.0 autoreadonly hidden
int property SendeventChance Auto hidden
int property SendeventChanceDefault = 70 autoreadonly hidden
int property SendeventCriterion Auto hidden
int property SendeventCriterionDefault = 50 autoreadonly hidden

bool events 
bool property eventsDefault = true autoreadonly hidden
int eventsOID
int[] eventOIDs
int[] ToggleSlotID
int[] SlotValue
Bool[] bToggleSlot

formlist property sr_InjectorFormlist auto

GlobalVariable Property SRSlotMask auto
GlobalVariable Property SRSlotMaskB auto

int BeeingFemaleOID
bool BeeingFemale

int FHUSLIFOID
int FHUSLIFNullOID

int debugResetOID
int debugFillVagOID
int debugFillAnOID
int FHUMorphStringOID
int FHUMorphString2OID
int FHUMorphString3OID
int FHUMorphString4OID

int BodyMorphOID
bool property BodyMorph = true Auto hidden
bool property BodyMorphdefault = true Auto hidden

GlobalVariable Property sr_CumEffectsEnabled auto 
bool property cumEffects hidden
	bool Function get()
		return sr_CumEffectsEnabled.GetValueInt() > 0
	EndFunction
	
	Function Set(bool v)
		if v
			sr_CumEffectsEnabled.SetValueInt(1)
		Else
			sr_CumEffectsEnabled.SetValueInt(0)
		EndIf
	EndFunction
EndProperty
bool property cumEffectsDefault = true autoreadonly hidden
int cumEffectsOID

GlobalVariable Property sr_messageConsolePrint auto
bool property consolePrint hidden
	bool Function get()
		return sr_messageConsolePrint.GetValueInt() > 0
	EndFunction
	
	Function Set(bool v)
		if v
			sr_messageConsolePrint.SetValueInt(1)
		Else
			sr_messageConsolePrint.SetValueInt(0)
		EndIf
	EndFunction
EndProperty
bool property consolePrintDefault = true autoreadonly hidden
int consolePrintOID

int TongueOID
int autodeflationOID
int absorbspermOID
int absorbspermoralOID
int OnEventSpermPlayerOID
int OnEventSpermNPCOID
GlobalVariable Property sr_TongueEffect Auto
GlobalVariable Property sr_OnEventSpermPlayer Auto
GlobalVariable Property sr_OnEventSpermNPC Auto

int addRaceKey = -1
int property addRaceKeyDefault = 83 autoreadonly hidden ; num.
int addRaceKeyOID
ReferenceAlias Property targetedRace Auto
Message Property AddConfirmationMsg Auto
Message Property AddErrorMsg Auto
Message Property sr_AddCreatureRaceError Auto

GlobalVariable Property sr_InfReInit auto
GlobalVariable Property sr_EstrusChaurus auto
GlobalVariable Property sr_Fertility auto
GlobalVariable Property sr_BeeingFemale auto
GlobalVariable Property sr_SLIF auto

bool EstrusChaurus_Installed
bool Fertility_Installed
bool BeeingFemale_Installed
bool SLIF_Installed
bool Property FHUSLIF = true Auto hidden


bool property addedEvents = true autoreadonly hidden
int runCount = 0
Keyword property ActorTypeNPC Auto

int Function GetVersion()
	return (100+3) ;(VersionNumFloatTruncatedToTenth*10)^2+SubversionNum
EndFunction

Function VerifyMods()
	If Quest.GetQuest("BF_Main")
		BeeingFemale_Installed = true
		sr_BeeingFemale.setvalue(1)
		
		;BDMonitor._BF_ParentFaction = Game.GetFormFromFile(0x008448, "BeeingFemale.esm") as Faction
		;BDMonitor._BFPlayerState = Game.GetFormFromFile(0x060CC3, "BeeingFemale.esm") as GlobalVariable
		
	Else
		BeeingFemale_Installed = false
		sr_BeeingFemale.setvalue(0)
	Endif
	
	
	If Quest.Getquest("_JSW_BB_ConfigQuest") || Quest.Getquest("_JSW_BB_HandlerQuest")
		Fertility_Installed = true
		sr_Fertility.setvalue(1)
		
		;Quest HandlerQuest = Game.GetFormFromFile(0x000D62, "Fertility Mode.esp") as Quest
		;BDMonitor._JSW_BB_PotionFertility = Game.GetFormFromFile(0x0058D2, "Fertility Mode.esp") as Potion
		;BDMonitor.FertilityLastBirth = (HandlerQuest as _JSW_BB_Storage).LastBirth as float[]
		
	Else
		Fertility_Installed = false
		sr_Fertility.setvalue(0)
	Endif

	
	If Quest.Getquest("zzEstrusChaurusMCM")
		EstrusChaurus_Installed = true
		sr_EstrusChaurus.setvalue(1)

		;BDMonitor.zzEstrusChaurusBreederFaction = Game.GetFormFromFile(0x0160A9, "EstrusChaurus.esp") as Faction
	Else
		EstrusChaurus_Installed = false
		sr_EstrusChaurus.setvalue(0)
	Endif

	If Quest.GetQuest("SLIF_Menu")
		SLIF_Installed = true
	Else
		SLIF_Installed = false
	Endif

EndFunction

Function SetDefaults()
	minInflationTime = minInflationTimeDefault
	maxInflation = maxInflationDefault
	OralmaxInflation = OralmaxInflationDefault
	logging = loggingDefault
	addRaceKey = addRaceKeyDefault
	animDeflate = animDeflateDefault
	animMult = animMultDefault
	encumber = encumberDefault
	enabled = true
	femaleEnabled = true
	maleEnabled = true
	statusMsg = statusMsgDefault
	npcComments = npcCommentsDefault
	followerComments = followerCommentsDefault
	eventManager.interval = eventIntervalDefault
	SendeventChance = SendeventChanceDefault
	SendeventCriterion = SendeventCriterionDefault
	events = eventsDefault
	bellyScale = bellyScaleDefault
	BodyMorph = true
	FHUSLIF = true
	MoanSound = true
	SexlabMoanSound = true
	Deflatechance = DeflatechanceDefault
	sr_ExpelFaliure.setvalue(Deflatechance)
	VariousCum = VariousCumDefault
	VariousCumIngredients = VariousCumIngredientsDefault
EndFunction

Event OnGameReload()
	parent.OnGameReload()
	RegisterKeys()
	VerifyMods()
	If runCount < 2
		Utility.Wait(1.0)
		eventManager.RegisterAllEvents()
		runCount += 1
	EndIf
	inflater.maintenance()
	PageReset()
EndEvent

Function RegisterKeys()
	UnregisterForAllKeys()
	If addRaceKey >= 0
		RegisterForKey(addRaceKey)
	EndIf
EndFunction

Event OnConfigInit()
	parent.OnGameReload()
	PageReset()
EndEvent

Function PageReset()
	pages = new String[5]
	pages[0] = "$FHU_SETTINGS"
	pages[1] = "$FHU_EVENTS_HEADER"
	pages[2] = "$FHU_ACTOR_LIST"
	pages[3] = "$FHU_RACE_AMOUNT"
	pages[4] = "$FHU_CREATURERACE_AMOUNT"
	eventOIDs = new int[128]
    ToggleSlotID = new int[32]
    SlotValue = new int[32]
	bToggleSlot = new Bool[32]
EndFunction

Event OnVersionUpdate(int newVersion)
	If newVersion != currentVersion
		ModName = "Fill her up"
		bool monitoring = inflater.GetState() == "MonitoringInflation"
		inflater.stop()
		eventManager.stop()
		dialogue.stop()
		Utility.wait(0.2)
		dialogue.start()
		eventManager.start()
		inflater.start()
		if monitoring
			inflater.GoToState("MonitoringInflation")
			dialogue.doregister()
		endIf
		SetDefaults()
		inflater.versionUpdate()
		inflater.maintenance()
		raceOID = new int[63] ; 128 items per config page if I'm not mistaken, would leave 64 per side and -1 for header
		CreatureRaceOID = new int[48]
		RegisterKeys()

		If currentVersion == 0
			SetDefaultCumAmounts()
		EndIf
		InitCumMagicEffects()
		sr_inflatedCommentChance.SetValueInt(26)
		dialogue.msgChance = statusMsgChanceDefault
		dialogue.DoRegister()
		inflater.log("Updated to " + inflater.GetVersion() + " (" + newVersion +")")
	;	inflater.ResetActors(true)
		If addedEvents
			runCount = 0
		EndIf
		Debug.Notification("Fill Her Up " + inflater.GetVersionString() + " initialized.")
	EndIf
	debug.messagebox("Fill Her Up Update")
EndEvent



Event OnPageReset(String page)
	if sr_InfReInit.GetValueInt() > 0
		SetDefaultCumAmounts()
		InitCumMagicEffects()
		inflater.VersionUpdate()
		sr_InfReInit.SetValueInt(0)
	EndIf
	SetCursorFillMode(TOP_TO_BOTTOM)
	If page == "" || page == pages[0] ; Settings
		GoToState("settings")
		resetting = false
		enabledOID = AddToggleOption("$FHU_ENABLED", enabled)
		femaleEnabledOID = AddToggleOption("$FHU_FEMALE_ENABLED", femaleEnabled)
		maleEnabledOID = AddToggleOption("$FHU_MALE_ENABLED", maleEnabled)
		bellyScaleOID = AddToggleOption("$FHU_VISUAL_BELLY", bellyScale)
		BodyMorphOID = AddToggleOption("$FHU_BodyMorph", BodyMorph)
		minInflationTimeOID = AddSliderOption("$FHU_MIN_TIME", minInflationTime, "$FHU_HOURS")
		maxInflationOID = AddSliderOption("$FHU_MAX_AMOUNT", maxInflation, "{2}")
		OralmaxInflationOID = AddSliderOption("$FHU_ORALMAX_AMOUNT", OralmaxInflation, "{2}")
		stripOID = AddToggleOption("$FHU_STRIP", strip)
		VariousCumOID = AddToggleOption("$FHU_VARIOUSCUM", sr_Cumvariation.getvalue())
		VariousCumIngredientsOID = AddToggleOption("$FHU_VARIOUSCUMINGREDIENTS", sr_Cumvariationingredients.getvalue())
		DeflatechanceOID = AddSliderOption("$FHU_DEFLATE_CHANCE", Deflatechance, "{0}%")
		animDeflateOID = AddToggleOption("$FHU_ANIM_DEFLATE", animDeflate)
		animMultOID = AddSliderOption("$FHU_ANIM_MULT", animMult, "{1}")
		cumMultOID = AddSliderOption("$FHU_CUM_MULT", inflater.cumMult, "{2}")
		encumberOID = AddToggleOption("$FHU_ENCUMBER", encumber)
		SFU_PlacePuddlesOID = AddToggleOption("$FHU_PlacePuddles", SFU_PlacePuddles)
		cumEffectsOID = AddToggleOption("$FHU_CUM_EFFECTS", cumEffects)
		defKeyOID = AddKeyMapOption("$FHU_DEF_ABILITY", defKey, OPTION_FLAG_WITH_UNMAP)
		MoanSoundOID = AddToggleOption("$FHU_STATUS_MOANING", MoanSound)
		SexlabMoanSoundOID = AddToggleOption("$FHU_SEXLAB_MOANING", SexlabMoanSound)
		statusMsgOID = AddToggleOption("$FHU_STATUS_MESSAGES", statusMsg)
		statusMsgChanceOID = AddSliderOption("$FHU_STATUS_MESSAGES_CHANCE", dialogue.msgChance, "{0}%")
		npcCommentsOID = AddToggleOption("$FHU_NPC_COMMENTS", npcComments)
		followerCommentsOID = AddToggleOption("$FHU_FOLLOWER_COMMENTS", followerComments)
		SetCursorPosition(1)
		FHUMorphStringOID = AddInputOption("$FHU_MORPHSTRING", FHUMorphString)
		FHUMorphString2OID = AddInputOption("$FHU_MORPHSTRING2", FHUMorphString2)
		FHUMorphString3OID = AddInputOption("$FHU_MORPHSTRING3", FHUMorphString3)
		FHUMorphString4OID = AddInputOption("$FHU_MORPHSTRING4", FHUMorphString4)
		FHUSLIFOID = AddToggleOption("$FHU_SLIF", FHUSLIF)
		addRaceKeyOID = AddKeyMapOption("$FHU_ADD_RACE", addRaceKey, OPTION_FLAG_WITH_UNMAP)
		consolePrintOID = AddToggleOption("$FHU_CONSOLE_PRINT", consolePrint)
		loggingOID = AddToggleOption("$FHU_LOGGING", logging)
		resetOID = AddTextOption("$FHU_RESET_ACTORS", "$FHU_RESET")
		resetquestOID = AddTextOption("$FHU_RESET_QUEST", "$FHU_RESETQUEST")
		AddEmptyOption()
		if inflater.sr_debug.GetValueInt() > 0
			AddEmptyOption()
			debugResetOID = AddTextOption("Reset player", "reset")
			debugFillVagOID = AddTextOption("Fill player vaginal pool", "fill")
			debugFillAnOID = AddTextOption("Fill player anal pool", "fill")
		EndIf

	ElseIf page == pages[1]
		GoToState("events")
		SetCursorPosition(1)
		eventsOID = AddToggleOption("$FHU_EVENTS", events)
		eventIntervalOID = AddSliderOption("$FHU_EVENT_INTERVAL", eventManager.interval, "{2} hours")
		eventSendeventChanceOID = AddSliderOption("$FHU_SENDEVENT_CHANCE", SendeventChance, "{0}%")
		eventSendeventCriterionOID = AddSliderOption("$FHU_SENDEVENT_CRITERION", SendeventCriterion, "{0}%")
		
		autodeflationOID = AddToggleOption("$FHU_AUTO_DEFLATE", sr_OnEventNoDeflation.getvalue())
		absorbspermOID = AddToggleOption("$FHU_ABSORB_SPERM", sr_OnEventAbsorbSperm.getvalue())
		absorbspermoralOID = AddToggleOption("$FHU_ABSORB_SPERMORAL", sr_OnEventAbsorbSpermOral.getvalue())
		
		TongueOID = AddToggleOption("$FHU_Tongue_EFFECT", sr_TongueEffect.getvalue())
		
		AddHeaderOption("$FHU_Compatibility")
		
		If BeeingFemale_Installed
		BeeingFemaleOID = Addtextoption("$FHU_BeeingFemale", "$Installed")
		Else
		BeeingFemaleOID = Addtextoption("$FHU_BeeingFemale", "$NotInstalled")
		EndIf
		
		If Fertility_Installed
		FertilityOID = Addtextoption("$FHU_Fertility", "$Installed")
		Else
		FertilityOID = Addtextoption("$FHU_Fertility", "$NotInstalled")
		EndIf

		OnEventSpermPlayerOID = AddToggleOption("$FHU_OnEventSpermPC_EFFECT", sr_OnEventSpermPlayer.getvalue())
		OnEventSpermNPCOID = AddToggleOption("$FHU_OnEventSpermNPC_EFFECT", sr_OnEventSpermNPC.getvalue())

		SetCursorPosition(0)
		int i = 0
		while i < 128 && eventManager.events[i] != none
			eventOIDs[i] = AddSliderOption(eventManager.events[i].eventName, eventManager.events[i].chance, "{0}%")
			i += 1
		endWhile 	

		AddHeaderOption("$FHU_ARMOR_SLOTS")
		bToggleSlot = GetUnignoredArmorSlots(SRSlotMask, SRSlotMaskB)
		ToggleSlotID[0] = AddToggleOption("30 - Head", bToggleSlot[0])
		ToggleSlotID[1] = AddToggleOption("31 - Hair", bToggleSlot[1])
		ToggleSlotID[2] = AddToggleOption("32 - Body", bToggleSlot[2])
		ToggleSlotID[3] = AddToggleOption("33 - Hands", bToggleSlot[3])
		ToggleSlotID[4] = AddToggleOption("34 - Forearms", bToggleSlot[4])
		ToggleSlotID[5] = AddToggleOption("35 - Amulet", bToggleSlot[5])
		ToggleSlotID[6] = AddToggleOption("36 - Ring", bToggleSlot[6])
		ToggleSlotID[7] = AddToggleOption("37 - Feet", bToggleSlot[7])
		ToggleSlotID[8] = AddToggleOption("38 - Calves", bToggleSlot[8])
		ToggleSlotID[9] = AddToggleOption("39 - Shield", bToggleSlot[9])
		ToggleSlotID[10] = AddToggleOption("40 - Tail", bToggleSlot[10])
		ToggleSlotID[11] = AddToggleOption("41 - Long Hair", bToggleSlot[11])
		ToggleSlotID[12] = AddToggleOption("42 - Circlet", bToggleSlot[12])
		ToggleSlotID[13] = AddToggleOption("43 - Ears", bToggleSlot[13])
		ToggleSlotID[14] = AddToggleOption("44 - Unnamed", bToggleSlot[14])
		ToggleSlotID[15] = AddToggleOption("45 - Unnamed", bToggleSlot[15])
		ToggleSlotID[16] = AddToggleOption("46 - Unnamed", bToggleSlot[16])
		ToggleSlotID[17] = AddToggleOption("47 - Unnamed", bToggleSlot[17])
		ToggleSlotID[18] = AddToggleOption("48 - Unnamed", bToggleSlot[18])
		ToggleSlotID[19] = AddToggleOption("49 - Unnamed", bToggleSlot[19])
		ToggleSlotID[20] = AddToggleOption("50 - Beheaded", bToggleSlot[20])
		ToggleSlotID[21] = AddToggleOption("51 - Beheaded", bToggleSlot[21])
		ToggleSlotID[22] = AddToggleOption("52 - Underwear", bToggleSlot[22])
		ToggleSlotID[23] = AddToggleOption("53 - Unnamed", bToggleSlot[23])
		ToggleSlotID[24] = AddToggleOption("54 - Unnamed", bToggleSlot[24])
		ToggleSlotID[25] = AddToggleOption("55 - Unnamed", bToggleSlot[25])
		ToggleSlotID[26] = AddToggleOption("56 - Unnamed", bToggleSlot[26])
		ToggleSlotID[27] = AddToggleOption("57 - Unnamed", bToggleSlot[27])
		ToggleSlotID[28] = AddToggleOption("58 - Unnamed", bToggleSlot[28])
		ToggleSlotID[29] = AddToggleOption("59 - Unnamed", bToggleSlot[29])
		ToggleSlotID[30] = AddToggleOption("60 - Unnamed", bToggleSlot[30])
		ToggleSlotID[31] = AddToggleOption("61 - FX01", bToggleSlot[31])
	ElseIf page == pages[2]
		GoToState("actors")
		; Always show the player
		SetCursorPosition(0)
		AddHeaderOption(inflater.player.GetLeveledActorBase().GetName())
		If inflater.sexlab.GetGender(inflater.player)==1
			AddTextOption("$FHU_VAG_AMOUNT", StringUtil.SubString(inflater.GetVaginalCum(inflater.player), 0, 5))
		EndIf
		AddTextOption("$FHU_AN_AMOUNT", StringUtil.SubString(inflater.GetAnalCum(inflater.player), 0, 5))
		AddTextOption("$FHU_OR_AMOUNT", StringUtil.SubString(inflater.GetOralCum(inflater.player), 0, 5))
		AddTextOption("$FHU_TOTAL_INF", StringUtil.SubString(inflater.GetInflation(inflater.player), 0, 5))
		Actor a
		int i = StorageUtil.FormListCount(inflater, inflater.INFLATED_ACTORS)
		While i > 0
			i -= 1
			a = StorageUtil.FormListGet(inflater, inflater.INFLATED_ACTORS, i) as Actor
			If a && a != inflater.player
				AddHeaderOption(a.GetLeveledActorBase().GetName())
				If inflater.sexlab.GetGender(a)== 1
					AddTextOption("$FHU_VAG_AMOUNT", StringUtil.SubString(inflater.GetVaginalCum(a), 0, 5))
				EndIf
				AddTextOption("$FHU_AN_AMOUNT", StringUtil.SubString(inflater.GetAnalCum(a), 0, 5))
				AddTextOption("$FHU_TOTAL_INF", StringUtil.SubString(inflater.GetInflation(a),0,5))
			EndIf
		EndWhile
		SetCursorPosition(1)
		AddHeaderOption("$FHU_SPERM_LIST")
		int iinjector = sr_InjectorFormlist.getsize()
		while iinjector > 0
			iinjector -= 1
			AddTextOption((sr_InjectorFormlist.getat(iinjector) as actor).GetLeveledActorBase().GetName(), DefineSex(sr_InjectorFormlist.getat(iinjector) as actor))
		EndWhile
	ElseIf page == pages[3] ; Events
		GoToState("humancumamount")
		AddHeaderOption("$FHU_RACE_AMOUNTS")
		int n = StorageUtil.FormListCount(self, RACE_LIST)
		int i = 0
		while i < n
			Race raze = StorageUtil.FormListGet(self, RACE_LIST, i) as Race
			raceOID[i] = AddSliderOption(MiscUtil.GetRaceEditorID(raze), StorageUtil.GetFloatValue(raze, inflater.RACE_CUM_AMOUNT, 0.75), "{2}")
			i += 1
		endWhile
	ElseIf page == pages[4] ; Inflated actors
		GoToState("creaturecumamount")
		AddHeaderOption("$FHU_CREATURERACE_AMOUNTS")
;		int nc = StorageUtil.FormListCount(self, CREATURERACE_LIST)
		int nc = 48
		int ic = 0
		while ic < nc
			Race Creatureraze = StorageUtil.FormListGet(self, CREATURERACE_LIST, ic) as Race
			CreatureRaceOID[ic] = AddSliderOption(MiscUtil.GetRaceEditorID(Creatureraze), StorageUtil.GetFloatValue(Creatureraze, inflater.CREATURERACE_CUM_AMOUNT, 0.75), "{2}")
			ic += 1
		endWhile
	EndIf	
EndEvent

String Function DefineSex(actor akactor)
int isex = akactor.GetLeveledActorBase().Getsex()
	if isex == 0
		Return "Male"
	elseif isex == 1
		Return "Female"
	endif
	Return "Unknown"
EndFunction

State settings
	Event OnOptionSliderOpen(int opt)
		If opt == minInflationTimeOID
			SetSliderDialogStartValue(minInflationTime)
			SetSliderDialogDefaultValue(minInflationTimeDefault)
			SetSliderDialogRange(1, 250)
			SetSliderDialogInterval(1)
		ElseIf opt == maxInflationOID
			SetSliderDialogStartValue(maxInflation)
			SetSliderDialogDefaultValue(maxInflationDefault)
			SetSliderDialogRange(0.1, 20.0)
			SetSliderDialogInterval(0.05)
		ElseIf opt == OralmaxInflationOID
			SetSliderDialogStartValue(OralmaxInflation)
			SetSliderDialogDefaultValue(OralmaxInflationDefault)
			SetSliderDialogRange(0.1, 5.0)
			SetSliderDialogInterval(0.05)
		ElseIf opt == animMultOID
			SetSliderDialogStartValue(animMult)
			SetSliderDialogDefaultValue(animMultDefault)
			SetSliderDialogRange(0.1, 25.0)
			SetSliderDialogInterval(0.1)
		ElseIf opt == cumMultOID
			SetSliderDialogStartValue(inflater.cumMult)
			SetSliderDialogDefaultValue(1.00)
			SetSliderDialogRange(0.1, 3.0)
			SetSliderDialogInterval(0.02)
		ElseIf opt == statusMsgChanceOID
			SetSliderDialogStartValue(dialogue.msgChance)
			SetSliderDialogDefaultValue(statusMsgChanceDefault)
			SetSliderDialogRange(10.0,100.0)
			SetSliderDialogInterval(1.0)
		ElseIf opt == DeflatechanceOID
			SetSliderDialogStartValue(Deflatechance)
			SetSliderDialogDefaultValue(DeflatechanceDefault)
			SetSliderDialogRange(0, 100)
			SetSliderDialogInterval(1.0)
		EndIf
	EndEvent

	Event OnOptionSliderAccept(int opt, float val)
		If opt == minInflationTimeOID
			minInflationTime = val as int
			SetSliderOptionValue(opt, minInflationTime, "{0} hours")
			inflater.log("Minimum inflation time set to: " + minInflationTime)
		ElseIf opt == maxInflationOID
			maxInflation = val
			SetSliderOptionValue(opt, maxInflation, "{2}")
			inflater.log("Maximum inflation amount set to: " + maxInflation)
		ElseIf opt == OralmaxInflationOID
			OralmaxInflation = val
			SetSliderOptionValue(opt, OralmaxInflation, "{2}")
			inflater.log("Maximum oral inflation amount set to: " + OralmaxInflation)
		ElseIf opt == animMultOID
			animMult = val
			SetSliderOptionValue(opt, animMult, "{1}")
			inflater.log("Animation duration multiplier set to: " + animMult)
		ElseIf opt == cumMultOID
			inflater.cumMult = val
			SetSliderOptionValue(opt, val, "{2}")
			inflater.log("Cum amount multiplier set to: " + val)
		ElseIf opt == statusMsgChanceOID
			dialogue.msgChance = val
			SetSliderOptionValue(opt, val, "{0}%")
			inflater.log("Status message chance set to: " + val + "%")
		ElseIf opt == DeflatechanceOID
			Deflatechance = val
			sr_ExpelFaliure.setvalue(Deflatechance)
			SetSliderOptionValue(opt, Deflatechance as int, "{0}%")
		EndIf
	EndEvent
	
	Event OnOptionInputOpen(int option)
		if (option == FHUMorphStringOID)
			SetInputDialogStartText(FHUMorphString)
		elseif (option == FHUMorphString2OID)
			SetInputDialogStartText(FHUMorphString2)
		elseif (option == FHUMorphString3OID)
			SetInputDialogStartText(FHUMorphString3)
		elseif (option == FHUMorphString4OID)
			SetInputDialogStartText(FHUMorphString4)
		endIf
	EndEvent

	Event OnOptionInputAccept(int option, string Stringinput)
		if (option == FHUMorphStringOID)
			FHUMorphString = Stringinput
			inflater.InflateMorph = FHUMorphString
			SetInputOptionValue(FHUMorphStringOID, FHUMorphString)
		elseif (option == FHUMorphString2OID)
			FHUMorphString2 = Stringinput
			inflater.InflateMorph2 = FHUMorphString2
			SetInputOptionValue(FHUMorphString2OID, FHUMorphString2)
		elseif (option == FHUMorphString3OID)
			FHUMorphString3 = Stringinput
			inflater.InflateMorph3 = FHUMorphString3
			SetInputOptionValue(FHUMorphString3OID, FHUMorphString3)
		elseif (option == FHUMorphString4OID)
			FHUMorphString4 = Stringinput
			inflater.InflateMorph4 = FHUMorphString4
			SetInputOptionValue(FHUMorphString4OID, FHUMorphString4)
		endIf
	EndEvent
EndState


State humancumamount
Event OnOptionSliderOpen(int opt)
		int i = StorageUtil.FormListCount(self, RACE_LIST)
			While i > 0
				i -= 1
				If opt == raceOID[i]
					SetSliderDialogStartValue(StorageUtil.GetFloatValue(StorageUtil.FormListGet(self, RACE_LIST, i), inflater.RACE_CUM_AMOUNT))
					SetSliderDialogRange(0.1, 5.0)
					SetSliderDialogInterval(0.05)
					i = 0 ; break
				EndIf
			endWhile
	EndEvent

	Event OnOptionSliderAccept(int opt, float val)
		int i = StorageUtil.FormListCount(self, RACE_LIST)
			While i > 0
				i -= 1
				If opt == raceOID[i]
					StorageUtil.SetFloatValue(StorageUtil.FormListGet(self, RACE_LIST, i), inflater.RACE_CUM_AMOUNT, val)
					SetSliderOptionValue(opt, val, "{2}")				
					i = 0 ; break
				EndIf
			endWhile
	EndEvent
EndState

State creaturecumamount
	Event OnOptionSliderOpen(int opt)
		int i = 48
			While i > 0
				i -= 1
				If opt == CreatureraceOID[i]
					SetSliderDialogStartValue(StorageUtil.GetFloatValue(StorageUtil.FormListGet(self, CREATURERACE_LIST, i), inflater.CREATURERACE_CUM_AMOUNT))
					SetSliderDialogRange(0.1, 5.0)
					SetSliderDialogInterval(0.05)
					i = 0 ; break
				EndIf
			endWhile
	EndEvent

	Event OnOptionSliderAccept(int opt, float val)
		int i = 48
			While i > 0
				i -= 1
				If opt == CreatureraceOID[i]
					StorageUtil.SetFloatValue(StorageUtil.FormListGet(self, CREATURERACE_LIST, i), inflater.CREATURERACE_CUM_AMOUNT, val)
					SetSliderOptionValue(opt, val, "{2}")				
					i = 0 ; break
				EndIf
			endWhile
	EndEvent
EndState

State events

	Event OnOptionSliderOpen(int opt)
		If opt == eventIntervalOID
			SetSliderDialogStartValue(eventManager.interval)
			SetSliderDialogRange(0.25, 12.00)
			SetSliderDialogInterval(0.05)
			SetSliderDialogDefaultValue(eventIntervalDefault)
		ElseIf opt == eventSendeventChanceOID
			SetSliderDialogStartValue(SendeventChance)
			SetSliderDialogRange(0, 100)
			SetSliderDialogInterval(1)
			SetSliderDialogDefaultValue(SendeventChanceDefault)
		ElseIf opt == eventSendeventCriterionOID
			SetSliderDialogStartValue(SendeventCriterion)
			SetSliderDialogRange(1, 100)
			SetSliderDialogInterval(1)
			SetSliderDialogDefaultValue(SendeventCriterionDefault)
		Else
			int i = 0
			while i < 128 && eventManager.events[i] != none
				if opt == eventOIDs[i]
					SetSliderDialogStartValue(eventManager.events[i].chance)
					SetSliderDialogRange(0, 100)
					SetSliderDialogInterval(1)
					SetSliderDialogDefaultValue(eventManager.events[i].chanceDefault)
					i = 128 ; break
				endIf
				i += 1
			endWhile
		EndIf
	EndEvent
	
	Event OnOptionSliderAccept(int opt, float val)
		If opt == eventIntervalOID
			eventManager.interval = val
			SetSliderOptionValue(opt, val, "{2} hours")
		ElseIf opt == eventSendeventChanceOID
			SendeventChance = val as int
			sr_SendingSpermDataChance.setvalue(SendeventChance)
			SetSliderOptionValue(opt, val, "{0}%")
		ElseIf opt == eventSendeventCriterionOID
			SendeventCriterion = val as int
			sr_SendingSpermDataCriterion.setvalue(SendeventCriterion)
			SetSliderOptionValue(opt, val, "{0}%")
						
		Else
			int i = 0
			while i < 128 && eventManager.events[i] != none
				if opt == eventOIDs[i]
					eventManager.events[i].chance = val as int
					SetSliderOptionValue(opt, val, "{0}%")
					i = 128 ; break
				endIf
				i += 1
			endWhile 	
		EndIf 
	EndEvent
	
	Event OnOptionHighlight(int opt)
		If opt == eventsOID
			SetInfoText("$FHU_EVENTS_HELP")
		ElseIf opt == eventIntervalOID
			SetInfoText("$FHU_EVENT_INTERVAL_HELP")
		ElseIf opt == eventSendeventChanceOID
			SetInfoText("$FHU_SENDEVENT_CHANCE_HELP")
		ElseIf opt == eventSendeventCriterionOID
			SetInfoText("$FHU_SENDEVENT_CRITERION_HELP")
		ElseIf opt == BeeingFemaleOID
			SetInfoText("$FHU_BeeingFemaleInfo")
		ElseIf opt == FertilityOID
			SetInfoText("$FHU_FertilityInfo")
		Else
			int i = 0
			while i < 128 && eventManager.events[i] != none
				if opt == eventOIDs[i]
					SetInfoText(eventManager.events[i].helpText)
					i = 128 ; break
				endIf
				i += 1
			endWhile 	
		EndIf
	EndEvent

EndState


State actors


EndState

Event OnOptionSelect(int opt)
	If opt == loggingOID
		inflater.log("Logging set to: " + !logging)
		logging = !logging
		SetToggleOptionValue(loggingOID, logging)
		inflater.log("Logging set to: " + logging)
	ElseIf opt == FHUSLIFOID
		FHUSLIF != FHUSLIF
		sr_SLIF.setvalue(FHUSLIF as int)
		SetToggleOptionValue(FHUSLIFOID, FHUSLIF)
	ElseIf opt == resetOID
		if !resetting
			resetting = true
			SetTextOptionValue(resetOID, "$FHU_SURE")
		Else
			SetTextOptionValue(resetOID, "$FHU_DONE")
			inflater.ResetActors()
		EndIf
	ElseIf opt == resetquestOID
		if !resettingquest
			resettingquest = true
			SetTextOptionValue(resetquestOID, "$FHU_SURE")
		Else
			SetTextOptionValue(resetquestOID, "$FHU_DONE")
			infplayer.ResetQuests()
		EndIf
	ElseIf opt == enabledOID
		enabled = !enabled
		SetToggleOptionValue(enabledOID, enabled)
		If enabled
			inflater.maintenance()
			If bellyScale
				StorageUtil.SetIntValue(Game.GetPlayer(), "CI_CumInflation_ON", 1)
			Else
				StorageUtil.UnsetIntValue(Game.GetPlayer(), "CI_CumInflation_ON")
			EndIf
			SetOptionFlags(femaleEnabledOID, OPTION_FLAG_NONE)
			SetOptionFlags(maleEnabledOID, OPTION_FLAG_NONE)
		Else
			inflater.UnregisterForModEvent("SexLabOrgasmSeparate")
			inflater.UnregisterForModEvent("HookOrgasmStart")
			inflater.ResetActors() ; Eh, same thing couple of lines lower with a confirmation...
			StorageUtil.UnsetIntValue(Game.GetPlayer(), "CI_CumInflation_ON")
			SetOptionFlags(femaleEnabledOID, OPTION_FLAG_DISABLED)
			SetOptionFlags(maleEnabledOID, OPTION_FLAG_DISABLED)
		EndIf
		inflater.log("Enabled status changed to: " + enabled)
	ElseIf opt == femaleEnabledOID
		femaleEnabled = !femaleEnabled
		SetToggleOptionValue(femaleEnabledOID, femaleEnabled)
	ElseIf opt == maleEnabledOID
		maleEnabled = !maleEnabled
		SetToggleOptionValue(maleEnabledOID, maleEnabled)
	ElseIf opt == bellyScaleOID
		bellyScale = !bellyScale
		SetToggleOptionValue(bellyScaleOID, bellyScale)
		If bellyScale && enabled
			StorageUtil.SetIntValue(Game.GetPlayer(), "CI_CumInflation_ON", 1)
		Else
			StorageUtil.UnsetIntValue(Game.GetPlayer(), "CI_CumInflation_ON")
		EndIf
	ElseIf opt == BodyMorphOID
		BodyMorph = !BodyMorph
		SetToggleOptionValue(BodyMorphOID, BodyMorph)
	ElseIf opt == encumberOID
		encumber = !encumber
		SetToggleOptionValue(encumberOID, encumber)
		If encumber
			inflater.EncumberAllActors()
		Else
			inflater.UnencumberAllActors()
		EndIf
	ElseIf opt == SFU_PlacePuddlesOID
		SFU_PlacePuddles = !SFU_PlacePuddles
		SetToggleOptionValue(SFU_PlacePuddlesOID, SFU_PlacePuddles)
	ElseIf opt == cumEffectsOID
		cumEffects = !cumEffects
		SetToggleOptionValue(cumEffectsOID, cumEffects)
	ElseIf opt == TongueOID
		if sr_TongueEffect.getvalue() == 0
			sr_TongueEffect.setvalue(1)
		else
			sr_TongueEffect.setvalue(0)
		endif
		SetToggleOptionValue(TongueOID, sr_TongueEffect.getvalue())
	ElseIf opt == autodeflationOID
		if sr_OnEventNoDeflation.getvalue() == 0
			sr_OnEventNoDeflation.setvalue(1)
		else
			sr_OnEventNoDeflation.setvalue(0)
		endif
		SetToggleOptionValue(autodeflationOID, sr_OnEventNoDeflation.getvalue())		
	ElseIf opt == absorbspermOID
		if sr_OnEventAbsorbSperm.getvalue() == 0
			sr_OnEventAbsorbSperm.setvalue(1)
		else
			sr_OnEventAbsorbSperm.setvalue(0)
		endif
		SetToggleOptionValue(absorbspermOID, sr_OnEventAbsorbSperm.getvalue())
	ElseIf opt == absorbspermoralOID
		if sr_OnEventAbsorbSpermOral.getvalue() == 0
			sr_OnEventAbsorbSpermOral.setvalue(1)
		else
			sr_OnEventAbsorbSpermOral.setvalue(0)
		endif
		SetToggleOptionValue(absorbspermoralOID, sr_OnEventAbsorbSpermOral.getvalue())	
	ElseIf opt == OnEventSpermPlayerOID
		if sr_OnEventSpermPlayer.getvalue() == 0
			sr_OnEventSpermPlayer.setvalue(1)
		else
			sr_OnEventSpermPlayer.setvalue(0)
		endif
		SetToggleOptionValue(OnEventSpermPlayerOID, sr_OnEventSpermPlayer.getvalue())
	ElseIf opt == OnEventSpermNPCOID
		if sr_OnEventSpermNPC.getvalue() == 0
			sr_OnEventSpermNPC.setvalue(1)
		else
			sr_OnEventSpermNPC.setvalue(0)
		endif
		SetToggleOptionValue(OnEventSpermNPCOID, sr_OnEventSpermNPC.getvalue())
	ElseIf opt == eventsOID
		events = !events
		SetToggleOptionValue(eventsOID, events)
		If events
			eventManager.StartEvents()
		Else
			eventManager.StopEvents()
		EndIf
	ElseIf opt == npcCommentsOID
		npcComments = !npcComments
		SetToggleOptionValue(npcCommentsOID, npcComments)
		If npcComments
			sr_inflatedCommentChance.SetValueInt(26)
		Else
			sr_inflatedCommentChance.SetValueInt(0)
		EndIf
	ElseIf opt == followerCommentsOID
		followerComments = !followerComments
		SetToggleOptionValue(followerCommentsOID, followerComments)
		If followerComments
			sr_followerCommentChance.SetValueInt(26)
		Else
			sr_followerCommentChance.SetValueInt(0)
		EndIf
	ElseIf opt == statusMsgOID
		statusMsg = !statusMsg
		SetToggleOptionValue(statusMsgOID, statusMsg)
		If statusMsg
			dialogue.DoRegister()
		Else
			dialogue.StopMessages()
		EndIf
	ElseIf opt == MoanSoundOID
		MoanSound = !MoanSound
		SetToggleOptionValue(MoanSoundOID, MoanSound)
		If MoanSound
			sr_MoanSound.setvalue(1)
		Else
			sr_MoanSound.setvalue(0)
		EndIf
	ElseIf opt == SexlabMoanSoundOID
		SexlabMoanSound = !SexlabMoanSound
		SetToggleOptionValue(SexlabMoanSoundOID, SexlabMoanSound)
		If SexlabMoanSound
			sr_SexlabMoanSound.setvalue(1)
		Else
			sr_SexlabMoanSound.setvalue(0)
		EndIf
	ElseIf opt == stripOID
		strip = !strip
		SetToggleOptionValue(stripOID, strip)
	ElseIf opt == VariousCumOID
		if VariousCum == true
			VariousCum = False
			sr_Cumvariation.setvalue(0)
		else
			VariousCum = true
			sr_Cumvariation.setvalue(1)
		endif
		SetToggleOptionValue(VariousCumOID, VariousCum)
	ElseIf opt == VariousCumIngredientsOID
		if VariousCumIngredients == true
			VariousCumIngredients = False
			sr_Cumvariationingredients.setvalue(0)
		else
			VariousCumIngredients = true
			sr_Cumvariationingredients.setvalue(1)
		endif
		SetToggleOptionValue(VariousCumIngredientsOID, VariousCumIngredients)
	ElseIf opt == animDeflateOID
		animDeflate = !animDeflate
		SetToggleOptionValue(animDeflateOID, animDeflate)
	ElseIf opt == consolePrintOID
		consolePrint = !consolePrint
		SetToggleOptionValue(consolePrintOID, consolePrint)
	ElseIf opt == debugResetOID
		inflater.ResetActor(inflater.player)
		SetTextOptionValue(debugResetOID, "done")
	ElseIf opt == debugFillAnOID
		DebugFill(true)
		SetTextOptionValue(debugFillAnOID, "done")
	ElseIf opt == debugFillVagOID
		DebugFill(false)
		SetTextOptionValue(debugFillVagOID, "done")
	Else
		int idx = ToggleSlotID.Find(opt)
		if (idx >= 0)
			bToggleSlot[idx] = !bToggleSlot[idx]
			IgnoreArmorSlot(SRSlotMask, SRSlotMaskB, idx + 30, !bToggleSlot[idx])
			SetToggleOptionValue(opt, bToggleSlot[idx])
		endif
	EndIf
EndEvent

Event OnOptionDefault(int opt)
    If opt == minInflationTimeOID
        minInflationTime = minInflationTimeDefault
        SetSliderOptionValue(opt, minInflationTime, "$FHU_HOURS")
	ElseIf opt == maxInflationOID
        maxInflation = maxInflationDefault
        SetSliderOptionValue(opt, maxInflation, "{2}")
	ElseIf opt == OralmaxInflationOID
        OralmaxInflation = OralmaxInflationDefault
        SetSliderOptionValue(opt, OralmaxInflation, "{2}")
	ElseIf opt == loggingOID
		logging = loggingDefault
		SetToggleOptionValue(loggingOID, logging)
	ElseIf opt == animMultOID
		animMult = animMultDefault
		SetSliderOptionValue(opt, animMult, "{1}")
	ElseIf opt == encumberOID
		encumber = encumberDefault
		SetToggleOptionValue(encumberOID, encumber)
	ElseIf opt == SFU_PlacePuddlesOID
		SFU_PlacePuddles = SFU_PlacePuddlesDefault
		SetToggleOptionValue(SFU_PlacePuddlesOID, SFU_PlacePuddles)
	ElseIf opt == defKeyOID
		defKey = defKeyDefault
		SetKeyMapOptionValue(defKeyOID, defKey)
	ElseIf opt == npcCommentsOID
		npcComments = npcCommentsDefault
		SetToggleOptionValue(npcCommentsOID, npcComments)
		sr_inflatedCommentChance.SetValueInt(26)
	ElseIf opt == followerCommentsOID
		followerComments = followerCommentsDefault
		SetToggleOptionValue(followerCommentsOID, followerComments)
		sr_followerCommentChance.SetValueInt(26)
	ElseIf opt == VariousCumOID
		VariousCum = true
		sr_Cumvariation.setvalue(1)
		SetToggleOptionValue(VariousCumOID, VariousCum)
	ElseIf opt == VariousCumIngredientsOID
		VariousCumIngredients = true
		sr_Cumvariationingredients.setvalue(1)
		SetToggleOptionValue(VariousCumIngredientsOID, VariousCumIngredients)
	ElseIf opt == animDeflateOID
		animDeflate = animDeflateDefault
		SetToggleOptionValue(animDeflateOID, animDeflate)
	ElseIf opt == cumEffectsOID
		cumEffects = cumEffectsDefault
		SetToggleOptionValue(cumEffectsOID,cumEffects)
	ElseIf opt == TongueOID
		sr_TongueEffect.setvalue(0)
		SetToggleOptionValue(TongueOID,sr_TongueEffect.getvalue())
	ElseIf opt == FHUSLIFOID
		if SLIF_Installed
			sr_SLIF.setvalue(1)
			FHUSLIF = true
		else
			sr_SLIF.setvalue(0)
			FHUSLIF = false
		endif
		SetToggleOptionValue(FHUSLIFOID, FHUSLIF)
	ElseIf opt == autodeflationOID
		sr_OnEventNoDeflation.setvalue(0)
		SetToggleOptionValue(autodeflationOID,sr_OnEventNoDeflation.getvalue())
	ElseIf opt == absorbspermOID
		sr_OnEventAbsorbSperm.setvalue(0)
		SetToggleOptionValue(absorbspermOID,sr_OnEventAbsorbSperm.getvalue())
	ElseIf opt == absorbspermoralOID
		sr_OnEventAbsorbSpermOral.setvalue(0)
		SetToggleOptionValue(absorbspermoralOID,sr_OnEventAbsorbSpermOral.getvalue())		
	ElseIf opt == OnEventSpermPlayerOID
		sr_OnEventSpermPlayer.setvalue(0)
		SetToggleOptionValue(OnEventSpermPlayerOID,sr_OnEventSpermPlayer.getvalue())
	ElseIf opt == OnEventSpermNPCOID
		sr_OnEventSpermNPC.setvalue(0)
		SetToggleOptionValue(OnEventSpermNPCOID,sr_OnEventSpermNPC.getvalue())
	ElseIf opt == consolePrintOID
		consolePrint = consolePrintDefault
		SetToggleOptionValue(consolePrintOID, consolePrint)
	ElseIf opt == bellyScaleOID
		bellyScale = bellyScaleDefault
		If bellyScale
			StorageUtil.SetIntValue(Game.GetPlayer(), "CI_CumInflation_ON", 1)
		Else
			StorageUtil.UnsetIntValue(Game.GetPlayer(), "CI_CumInflation_ON")
		EndIf
		SetToggleOptionValue(bellyScaleOID, bellyScale)
	ElseIf opt == BodyMorphOID
		BodyMorph = true
		SetToggleOptionValue(BodyMorphOID, BodyMorph)
	else
		int idx = ToggleSlotID.Find(opt)
		if (idx >= 0)
			if ( idx <= 13 ) ;slot 30-43
				IgnoreArmorSlot(SRSlotMask, SRSlotMaskB, idx + 30, True)
				SetToggleOptionValue(opt, True)
			else
				IgnoreArmorSlot(SRSlotMask, SRSlotMaskB, idx + 30, False)
				SetToggleOptionValue(opt, False)
			endif
		endif
	EndIf
EndEvent

Event OnOptionKeyMapChange(int option, int keyCode, string conflictControl, string conflictName)
	if option == addRaceKeyOID
		addRaceKey = keyCode
		SetKeyMapOptionValue(option, keyCode)
	ElseIf option == defKeyOID
		defKey = keyCode
		SetKeyMapOptionValue(option, keyCode)
	endIf
EndEvent

Event OnOptionHighlight(int opt)
	If opt == minInflationTimeOID
		SetInfoText("$FHU_MIN_TIME_HELP")
	ElseIf opt == maxInflationOID
		SetInfoText("$FHU_MAX_AMOUNT_HELP")
	ElseIf opt == OralmaxInflationOID
		SetInfoText("$FHU_ORALMAX_AMOUNT_HELP")
	ElseIf opt == loggingOID
		SetInfoText("$FHU_LOGGING_HELP")
	ElseIf opt == resetOID
		SetInfoText("$FHU_RESET_HELP")
	ElseIf opt == resetquestOID
		SetInfoText("$FHU_RESETQUEST_HELP")
	ElseIf opt == addRaceKeyOID
		SetInfoText("$FHU_ADD_RACE_HELP")
	ElseIf opt == animMultOID
		SetInfoText("$FHU_ANIM_MULT_HELP")
	ElseIf opt == cumMultOID
		SetInfoText("$FHU_CUM_MULT_HELP")
	ElseIf opt == encumberOID
		SetInfoText("$FHU_ENCUMBER_HELP")
	ElseIf opt == SFU_PlacePuddlesOID
		SetInfoText("$FHU_SFU_PlacePuddles_HELP")
	ElseIf opt == enabledOID
		SetInfoText("$FHU_ENABLED_HELP")
	ElseIf opt == femaleEnabledOID
		SetInfoText("$FHU_FEMALE_ENABLED_HELP")
	ElseIf opt == maleEnabledOID
		SetInfoText("$FHU_MALE_ENABLED_HELP")
	ElseIf opt == defKeyOID
		SetInfoText("$FHU_DEF_ABILITY_HELP")
	ElseIf opt == npcCommentsOID
		SetInfoText("$FHU_NPC_COMMENTS_HELP")
	ElseIf opt == followerCommentsOID
		SetInfoText("$FHU_FOLLOWER_COMMENTS_HELP")
	ElseIf opt == MoanSoundOID
		SetInfoText("$FHU_STATUS_MOANING_HELP")
	ElseIf opt == SexlabMoanSoundOID
		SetInfoText("$FHU_SEXLAB_MOANING_HELP")
	ElseIf opt == statusMsgOID
		SetInfoText("$FHU_STATUS_MESSAGES_HELP")
	ElseIf opt == statusMsgChanceOID
		SetInfoText("$FHU_STATUS_MESSAGES_CHANCE_HELP")
	ElseIf opt == DeflatechanceOID
		SetInfoText("$FHU_DEFLATE_CHANCE_HELP")
	ElseIf opt == stripOID
		SetInfoText("$FHU_STRIP_HELP")
	ElseIf opt == VariousCumOID
		SetInfoText("$FHU_VARIOUSCUM_HELP")
	ElseIf opt == VariousCumIngredientsOID
		SetInfoText("$FHU_VARIOUSCUMINGREDIENTS_HELP")
	ElseIf opt == animDeflateOID
		SetInfoText("$FHU_ANIM_DEFLATE_HELP")
	ElseIf opt == consolePrintOID
		SetInfoText("$FHU_CONSOLE_PRINT_HELP")
	ElseIf opt == cumEffectsOID
		SetInfoText("$FHU_CUM_EFFECTS_HELP")
	ElseIf opt == TongueOID
		SetInfoText("$FHU_Tongue_EFFECT_HELP")
	ElseIf opt == FHUSLIFOID
		SetInfoText("$FHU_SLIF_HELP")
	ElseIf opt == autodeflationOID
		SetInfoText("$FHU_AUTO_DEFLATE_HELP")
	ElseIf opt == absorbspermOID
		SetInfoText("$FHU_ABSORB_SPERM_HELP")
	ElseIf opt == absorbspermoralOID
		SetInfoText("$FHU_ABSORB_SPERMORAL_HELP")
	ElseIf opt == OnEventSpermPlayerOID
		SetInfoText("$FHU_OnEventSpermPC_EFFECT_HELP")
	ElseIf opt == OnEventSpermNPCOID
		SetInfoText("$FHU_OnEventSpermNPC_EFFECT_HELP")
	ElseIf opt == bellyScaleOID
		SetInfoText("$FHU_VISUAL_BELLY_HELP")
	ElseIf opt == BodyMorphOID
		SetInfoText("$FHU_BodyMorph_Help")
	ElseIf opt == FHUMorphStringOID
		SetInfoText("$FHU_MORPHSTRING_HELP")
	ElseIf opt == FHUMorphString2OID
		SetInfoText("$FHU_MORPHSTRING2_HELP")
	ElseIf opt == FHUMorphString3OID
		SetInfoText("$FHU_MORPHSTRING3_HELP")
	ElseIf opt == FHUMorphString4OID
		SetInfoText("$FHU_MORPHSTRING4_HELP")
;	ElseIf (opt >= ToggleSlotID[0]) && (opt <= ToggleSlotID[31])
;		SetInfoText("$FHU_TOGGLESLOT_HELP")
	EndIf
EndEvent

Event OnKeyUp(int kc, float time)
	If kc == addRaceKey
		Actor a = none
		if time > 0.7
			a = inflater.player
		Else
			a = Game.GetCurrentCrossHairRef() as Actor
		EndIf
		If a
			targetedRace.ForceRefTo(a)
			If AddConfirmationMsg.show() == 0 
				If StorageUtil.FormListCount(self, RACE_LIST) >= 100
					AddErrorMsg.show()
				Else 
					if a.haskeyword(ActorTypeNPC)
						StorageUtil.FormListAdd(self, RACE_LIST, a.GetLeveledActorBase().GetRace(), false)
						StorageUtil.SetFloatValue(a.GetLeveledActorBase().GetRace(), inflater.RACE_CUM_AMOUNT, 0.75)
					else
						sr_AddCreatureRaceError.show()
					endif
				EndIf
			EndIf
			targetedRace.Clear()
		EndIf
	EndIf
EndEvent

Function InitCumMagicEffects()
	
	; Dark elf
	StorageUtil.FormListAdd(defaultRaceList[4], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150E9, "sr_FillHerUp.esp"), false) ; Please No, common for humanoids
	StorageUtil.FormListAdd(defaultRaceList[4], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150F6, "sr_FillHerUp.esp"), false) ; Good ol sex, common for humanoids
	StorageUtil.FormListAdd(defaultRaceList[4], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150EC, "sr_FillHerUp.esp"), false)
	StorageUtil.FormListAdd(defaultRaceList[4], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150F1, "sr_FillHerUp.esp"), false)
	
	StorageUtil.FormListAdd(defaultRaceList[5], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150E9, "sr_FillHerUp.esp"), false) ; Please No, common for humanoids
	StorageUtil.FormListAdd(defaultRaceList[5], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150F6, "sr_FillHerUp.esp"), false) ; Good ol sex, common for humanoids
	StorageUtil.FormListAdd(defaultRaceList[5], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150EC, "sr_FillHerUp.esp"), false)
	StorageUtil.FormListAdd(defaultRaceList[5], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150F1, "sr_FillHerUp.esp"), false)
	
	; Breton
	StorageUtil.FormListAdd(defaultRaceList[2], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150E9, "sr_FillHerUp.esp"), false) ; Please No, common for humanoids
	StorageUtil.FormListAdd(defaultRaceList[2], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150F6, "sr_FillHerUp.esp"), false) ; Good ol sex, common for humanoids
	StorageUtil.FormListAdd(defaultRaceList[2], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150FA, "sr_FillHerUp.esp"), false)
	StorageUtil.FormListAdd(defaultRaceList[2], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150FD, "sr_FillHerUp.esp"), false)
	StorageUtil.FormListAdd(defaultRaceList[2], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x00015100, "sr_FillHerUp.esp"), false)
	
	StorageUtil.FormListAdd(defaultRaceList[3], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150E9, "sr_FillHerUp.esp"), false) ; Please No, common for humanoids
	StorageUtil.FormListAdd(defaultRaceList[3], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150F6, "sr_FillHerUp.esp"), false) ; Good ol sex, common for humanoids
	StorageUtil.FormListAdd(defaultRaceList[3], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150FA, "sr_FillHerUp.esp"), false)
	StorageUtil.FormListAdd(defaultRaceList[3], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150FD, "sr_FillHerUp.esp"), false)
	StorageUtil.FormListAdd(defaultRaceList[3], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x00015100, "sr_FillHerUp.esp"), false)
	
	; Nord
	StorageUtil.FormListAdd(defaultRaceList[13], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150E9, "sr_FillHerUp.esp"), false) ; Please No, common for humanoids
	StorageUtil.FormListAdd(defaultRaceList[13], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150F6, "sr_FillHerUp.esp"), false) ; Good ol sex, common for humanoids
	
	StorageUtil.FormListAdd(defaultRaceList[14], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150E9, "sr_FillHerUp.esp"), false) ; Please No, common for humanoids
	StorageUtil.FormListAdd(defaultRaceList[14], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150F6, "sr_FillHerUp.esp"), false) ; Good ol sex, common for humanoids
	
	; Orc
	StorageUtil.FormListAdd(defaultRaceList[15], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150E9, "sr_FillHerUp.esp"), false) ; Please No, common for humanoids
	StorageUtil.FormListAdd(defaultRaceList[15], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150F6, "sr_FillHerUp.esp"), false) ; Good ol sex, common for humanoids
	
	StorageUtil.FormListAdd(defaultRaceList[16], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150E9, "sr_FillHerUp.esp"), false) ; Please No, common for humanoids
	StorageUtil.FormListAdd(defaultRaceList[16], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150F6, "sr_FillHerUp.esp"), false) ; Good ol sex, common for humanoids
	
	; High Elf
	StorageUtil.FormListAdd(defaultRaceList[7], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150E9, "sr_FillHerUp.esp"), false) ; Please No, common for humanoids
	StorageUtil.FormListAdd(defaultRaceList[7], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150F6, "sr_FillHerUp.esp"), false) ; Good ol sex, common for humanoids
	
	StorageUtil.FormListAdd(defaultRaceList[8], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150E9, "sr_FillHerUp.esp"), false) ; Please No, common for humanoids
	StorageUtil.FormListAdd(defaultRaceList[8], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150F6, "sr_FillHerUp.esp"), false) ; Good ol sex, common for humanoids
	
	; Redguard
	StorageUtil.FormListAdd(defaultRaceList[17], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150E9, "sr_FillHerUp.esp"), false) ; Please No, common for humanoids
	StorageUtil.FormListAdd(defaultRaceList[17], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150F6, "sr_FillHerUp.esp"), false) ; Good ol sex, common for humanoids
	
	StorageUtil.FormListAdd(defaultRaceList[18], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150E9, "sr_FillHerUp.esp"), false) ; Please No, common for humanoids
	StorageUtil.FormListAdd(defaultRaceList[18], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150F6, "sr_FillHerUp.esp"), false) ; Good ol sex, common for humanoids
	
	; Imperial
	StorageUtil.FormListAdd(defaultRaceList[9], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150E9, "sr_FillHerUp.esp"), false) ; Please No, common for humanoids
	StorageUtil.FormListAdd(defaultRaceList[9], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150F6, "sr_FillHerUp.esp"), false) ; Good ol sex, common for humanoids
	
	StorageUtil.FormListAdd(defaultRaceList[10], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150E9, "sr_FillHerUp.esp"), false) ; Please No, common for humanoids
	StorageUtil.FormListAdd(defaultRaceList[10], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150F6, "sr_FillHerUp.esp"), false) ; Good ol sex, common for humanoids
	
	; Khajiit
	StorageUtil.FormListAdd(defaultRaceList[11], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150E9, "sr_FillHerUp.esp"), false) ; Please No, common for humanoids
	StorageUtil.FormListAdd(defaultRaceList[11], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150F6, "sr_FillHerUp.esp"), false) ; Good ol sex, common for humanoids
	
	StorageUtil.FormListAdd(defaultRaceList[12], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150E9, "sr_FillHerUp.esp"), false) ; Please No, common for humanoids
	StorageUtil.FormListAdd(defaultRaceList[12], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150F6, "sr_FillHerUp.esp"), false) ; Good ol sex, common for humanoids
	
	; Argonian
	StorageUtil.FormListAdd(defaultRaceList[0], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150E9, "sr_FillHerUp.esp"), false) ; Please No, common for humanoids
	StorageUtil.FormListAdd(defaultRaceList[0], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150F6, "sr_FillHerUp.esp"), false) ; Good ol sex, common for humanoids
	StorageUtil.FormListAdd(defaultRaceList[0], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x00015104, "sr_FillHerUp.esp"), false)
	
	StorageUtil.FormListAdd(defaultRaceList[1], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150E9, "sr_FillHerUp.esp"), false) ; Please No, common for humanoids
	StorageUtil.FormListAdd(defaultRaceList[1], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150F6, "sr_FillHerUp.esp"), false) ; Good ol sex, common for humanoids
	StorageUtil.FormListAdd(defaultRaceList[1], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x00015104, "sr_FillHerUp.esp"), false)
	
	; Wood elf
	StorageUtil.FormListAdd(defaultRaceList[19], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150E9, "sr_FillHerUp.esp"), false) ; Please No, common for humanoids
	StorageUtil.FormListAdd(defaultRaceList[19], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150F6, "sr_FillHerUp.esp"), false) ; Good ol sex, common for humanoids
	
	StorageUtil.FormListAdd(defaultRaceList[20], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150E9, "sr_FillHerUp.esp"), false) ; Please No, common for humanoids
	StorageUtil.FormListAdd(defaultRaceList[20], inflater.RACE_CUM_EFFECTS, Game.GetFormFromFile(0x000150F6, "sr_FillHerUp.esp"), false) ; Good ol sex, common for humanoids

	; Dragon
	StorageUtil.FormListAdd(defaultCreatureRaceList[12], inflater.CREATURERACE_CUM_EFFECTS, Game.GetFormFromFile(0x00013B53, "sr_FillHerUp.esp"), false)
	StorageUtil.FormListAdd(defaultCreatureRaceList[12], inflater.CREATURERACE_CUM_EFFECTS, Game.GetFormFromFile(0x00013B54, "sr_FillHerUp.esp"), false)
	
	; Spider
	StorageUtil.FormListAdd(defaultCreatureRaceList[40], inflater.CREATURERACE_CUM_EFFECTS, Game.GetFormFromFile(0x00013B5A, "sr_FillHerUp.esp"), false)
	StorageUtil.FormListAdd(defaultCreatureRaceList[41], inflater.CREATURERACE_CUM_EFFECTS, Game.GetFormFromFile(0x00013B5A, "sr_FillHerUp.esp"), false)
	StorageUtil.FormListAdd(defaultCreatureRaceList[42], inflater.CREATURERACE_CUM_EFFECTS, Game.GetFormFromFile(0x00013B5A, "sr_FillHerUp.esp"), false)
	
	; Troll
	StorageUtil.FormListAdd(defaultCreatureRaceList[44], inflater.CREATURERACE_CUM_EFFECTS, Game.GetFormFromFile(0x00013B58, "sr_FillHerUp.esp"), false)
	
	; Draugr
	StorageUtil.FormListAdd(defaultCreatureRaceList[13], inflater.CREATURERACE_CUM_EFFECTS, Game.GetFormFromFile(0x00013B57, "sr_FillHerUp.esp"), false)

	; Chaurus
	StorageUtil.FormListAdd(defaultCreatureRaceList[4], inflater.CREATURERACE_CUM_EFFECTS, Game.GetFormFromFile(0x00015108, "sr_FillHerUp.esp"), false)
	StorageUtil.FormListAdd(defaultCreatureRaceList[5], inflater.CREATURERACE_CUM_EFFECTS, Game.GetFormFromFile(0x00015108, "sr_FillHerUp.esp"), false)
	StorageUtil.FormListAdd(defaultCreatureRaceList[6], inflater.CREATURERACE_CUM_EFFECTS, Game.GetFormFromFile(0x00015108, "sr_FillHerUp.esp"), false)
	
	; Bear
	StorageUtil.FormListAdd(defaultCreatureRaceList[1], inflater.CREATURERACE_CUM_EFFECTS, Game.GetFormFromFile(0x0001510B, "sr_FillHerUp.esp"), false)	
EndFunction

Function SetDefaultCumAmounts()

	StorageUtil.FormListClear(self, RACE_LIST)

	int n = defaultRaceList.length
	int i = 0
	while i < n
		StorageUtil.FormListAdd(self, RACE_LIST, defaultRaceList[i], false)
		i += 1
	endWhile 
	StorageUtil.SetFloatValue(defaultRaceList[0], inflater.RACE_CUM_AMOUNT, 0.3)	; Argonian
	StorageUtil.SetFloatValue(defaultRaceList[1], inflater.RACE_CUM_AMOUNT, 0.3)	; Argonian vampire
	StorageUtil.SetFloatValue(defaultRaceList[2], inflater.RACE_CUM_AMOUNT, 0.2)	; Breton
	StorageUtil.SetFloatValue(defaultRaceList[3], inflater.RACE_CUM_AMOUNT, 0.2)	; Breton vampire
	StorageUtil.SetFloatValue(defaultRaceList[4], inflater.RACE_CUM_AMOUNT, 0.2)	; Dark Elf
	StorageUtil.SetFloatValue(defaultRaceList[5], inflater.RACE_CUM_AMOUNT, 0.2)	; Dark Elf vampire
	StorageUtil.SetFloatValue(defaultRaceList[6], inflater.RACE_CUM_AMOUNT, 0.8)		; Dremora
	StorageUtil.SetFloatValue(defaultRaceList[7], inflater.RACE_CUM_AMOUNT, 0.2)	; High Elf
	StorageUtil.SetFloatValue(defaultRaceList[8], inflater.RACE_CUM_AMOUNT, 0.2)	; High Elf vampire
	StorageUtil.SetFloatValue(defaultRaceList[9], inflater.RACE_CUM_AMOUNT, 0.2)	; Imperial
	StorageUtil.SetFloatValue(defaultRaceList[10], inflater.RACE_CUM_AMOUNT, 0.2)	; Imperial Vampire
	StorageUtil.SetFloatValue(defaultRaceList[11], inflater.RACE_CUM_AMOUNT, 0.3)	; Khajiit
	StorageUtil.SetFloatValue(defaultRaceList[12], inflater.RACE_CUM_AMOUNT, 0.3)	; Khajiit vampire
	StorageUtil.SetFloatValue(defaultRaceList[13], inflater.RACE_CUM_AMOUNT, 0.3)	; Nord
	StorageUtil.SetFloatValue(defaultRaceList[14], inflater.RACE_CUM_AMOUNT, 0.3)	; Nord Vampire
	StorageUtil.SetFloatValue(defaultRaceList[15], inflater.RACE_CUM_AMOUNT, 0.4)	; Orc
	StorageUtil.SetFloatValue(defaultRaceList[16], inflater.RACE_CUM_AMOUNT, 0.4)	; Orc vampire
	StorageUtil.SetFloatValue(defaultRaceList[17], inflater.RACE_CUM_AMOUNT, 0.2)	; Redguard
	StorageUtil.SetFloatValue(defaultRaceList[18], inflater.RACE_CUM_AMOUNT, 0.2)	; Redguard vampire
	StorageUtil.SetFloatValue(defaultRaceList[19], inflater.RACE_CUM_AMOUNT, 0.2)	; Wood Elf
	StorageUtil.SetFloatValue(defaultRaceList[20], inflater.RACE_CUM_AMOUNT, 0.2)	; Wood Elf vampire

	int ic = 0
	while ic < 48
		StorageUtil.FormListAdd(self, CREATURERACE_LIST, defaultCreatureRaceList[ic], false)
		ic += 1
	endWhile 

	StorageUtil.SetFloatValue(defaultCreatureRaceList[0], inflater.CREATURERACE_CUM_AMOUNT, 0.5)	; Ashhopper
	StorageUtil.SetFloatValue(defaultCreatureRaceList[1], inflater.CREATURERACE_CUM_AMOUNT, 1.2)	; Bear
	StorageUtil.SetFloatValue(defaultCreatureRaceList[2], inflater.CREATURERACE_CUM_AMOUNT, 1.0)	; Boar
	StorageUtil.SetFloatValue(defaultCreatureRaceList[3], inflater.CREATURERACE_CUM_AMOUNT, 0.3)	; Wolf
	StorageUtil.SetFloatValue(defaultCreatureRaceList[4], inflater.CREATURERACE_CUM_AMOUNT, 1.2)	; Chaurus
	StorageUtil.SetFloatValue(defaultCreatureRaceList[5], inflater.CREATURERACE_CUM_AMOUNT, 2.0)	; ChaurusHunter
	StorageUtil.SetFloatValue(defaultCreatureRaceList[6], inflater.CREATURERACE_CUM_AMOUNT, 1.8)	; ChaurusReaper
	StorageUtil.SetFloatValue(defaultCreatureRaceList[7], inflater.CREATURERACE_CUM_AMOUNT, 0.1)	; Chicken
	StorageUtil.SetFloatValue(defaultCreatureRaceList[8], inflater.CREATURERACE_CUM_AMOUNT, 0.4)	; Cow
	StorageUtil.SetFloatValue(defaultCreatureRaceList[9], inflater.CREATURERACE_CUM_AMOUNT, 0.4)	; Deer
	StorageUtil.SetFloatValue(defaultCreatureRaceList[10], inflater.CREATURERACE_CUM_AMOUNT, 0.3)	; Dog
	StorageUtil.SetFloatValue(defaultCreatureRaceList[11], inflater.CREATURERACE_CUM_AMOUNT, 0.5)	; DragonPriest
	StorageUtil.SetFloatValue(defaultCreatureRaceList[12], inflater.CREATURERACE_CUM_AMOUNT, 4.0)	; Dragon
	StorageUtil.SetFloatValue(defaultCreatureRaceList[13], inflater.CREATURERACE_CUM_AMOUNT, 0.5)	; Draugr
	StorageUtil.SetFloatValue(defaultCreatureRaceList[14], inflater.CREATURERACE_CUM_AMOUNT, 1.0)	; DwarvenBalist
	StorageUtil.SetFloatValue(defaultCreatureRaceList[15], inflater.CREATURERACE_CUM_AMOUNT, 3.0)	; DwarvenCenturion
	StorageUtil.SetFloatValue(defaultCreatureRaceList[16], inflater.CREATURERACE_CUM_AMOUNT, 1.2)	; DwarvenSphere
	StorageUtil.SetFloatValue(defaultCreatureRaceList[17], inflater.CREATURERACE_CUM_AMOUNT, 1.0)	; DwarvenSpider
	StorageUtil.SetFloatValue(defaultCreatureRaceList[18], inflater.CREATURERACE_CUM_AMOUNT, 0.4)	; Falmer
	StorageUtil.SetFloatValue(defaultCreatureRaceList[19], inflater.CREATURERACE_CUM_AMOUNT, 0.2)	; FlameAtronach
	StorageUtil.SetFloatValue(defaultCreatureRaceList[20], inflater.CREATURERACE_CUM_AMOUNT, 0.2)	; Fox
	StorageUtil.SetFloatValue(defaultCreatureRaceList[21], inflater.CREATURERACE_CUM_AMOUNT, 1.4)	; FrostAtronach
	StorageUtil.SetFloatValue(defaultCreatureRaceList[22], inflater.CREATURERACE_CUM_AMOUNT, 0.9)	; Gargoyle
	StorageUtil.SetFloatValue(defaultCreatureRaceList[23], inflater.CREATURERACE_CUM_AMOUNT, 1.5)	; Giant
	StorageUtil.SetFloatValue(defaultCreatureRaceList[24], inflater.CREATURERACE_CUM_AMOUNT, 0.4)	; Goat
	StorageUtil.SetFloatValue(defaultCreatureRaceList[25], inflater.CREATURERACE_CUM_AMOUNT, 0.3)	; Hagraven
	StorageUtil.SetFloatValue(defaultCreatureRaceList[26], inflater.CREATURERACE_CUM_AMOUNT, 0.3)	; Horker
	StorageUtil.SetFloatValue(defaultCreatureRaceList[27], inflater.CREATURERACE_CUM_AMOUNT, 1.1)	; Horse
	StorageUtil.SetFloatValue(defaultCreatureRaceList[28], inflater.CREATURERACE_CUM_AMOUNT, 0.3)	; IceWraith
	StorageUtil.SetFloatValue(defaultCreatureRaceList[29], inflater.CREATURERACE_CUM_AMOUNT, 2.4)	; Lurker
	StorageUtil.SetFloatValue(defaultCreatureRaceList[30], inflater.CREATURERACE_CUM_AMOUNT, 1.8)	; Mammoth
	StorageUtil.SetFloatValue(defaultCreatureRaceList[31], inflater.CREATURERACE_CUM_AMOUNT, 0.2)	; Mudcrab
	StorageUtil.SetFloatValue(defaultCreatureRaceList[32], inflater.CREATURERACE_CUM_AMOUNT, 2.2)	; Netch
	StorageUtil.SetFloatValue(defaultCreatureRaceList[33], inflater.CREATURERACE_CUM_AMOUNT, 0.1)	; Rabbit
	StorageUtil.SetFloatValue(defaultCreatureRaceList[34], inflater.CREATURERACE_CUM_AMOUNT, 0.4)	; Riekling
	StorageUtil.SetFloatValue(defaultCreatureRaceList[35], inflater.CREATURERACE_CUM_AMOUNT, 0.7)	; Sabre
	StorageUtil.SetFloatValue(defaultCreatureRaceList[36], inflater.CREATURERACE_CUM_AMOUNT, 1.8)	; Seeker
	StorageUtil.SetFloatValue(defaultCreatureRaceList[37], inflater.CREATURERACE_CUM_AMOUNT, 0.2)	; Skeever
	StorageUtil.SetFloatValue(defaultCreatureRaceList[38], inflater.CREATURERACE_CUM_AMOUNT, 0.2)	; Slaughterfish
	StorageUtil.SetFloatValue(defaultCreatureRaceList[39], inflater.CREATURERACE_CUM_AMOUNT, 1.4)	; StormAtronach
	StorageUtil.SetFloatValue(defaultCreatureRaceList[40], inflater.CREATURERACE_CUM_AMOUNT, 0.8)	; FrostbiteSpider
	StorageUtil.SetFloatValue(defaultCreatureRaceList[41], inflater.CREATURERACE_CUM_AMOUNT, 1.4)	; FrostbiteSpiderLarge
	StorageUtil.SetFloatValue(defaultCreatureRaceList[42], inflater.CREATURERACE_CUM_AMOUNT, 2.0)	; FrostbiteSpiderGiant
	StorageUtil.SetFloatValue(defaultCreatureRaceList[43], inflater.CREATURERACE_CUM_AMOUNT, 0.5)	; Spriggan
	StorageUtil.SetFloatValue(defaultCreatureRaceList[44], inflater.CREATURERACE_CUM_AMOUNT, 1.4)	; Troll
	StorageUtil.SetFloatValue(defaultCreatureRaceList[45], inflater.CREATURERACE_CUM_AMOUNT, 1.0)	; VampireLord
	StorageUtil.SetFloatValue(defaultCreatureRaceList[46], inflater.CREATURERACE_CUM_AMOUNT, 1.0)	; Werewolf
	StorageUtil.SetFloatValue(defaultCreatureRaceList[47], inflater.CREATURERACE_CUM_AMOUNT, 0.4)	; Wisp
EndFunction

Event OnConfigClose()
	RegisterKeys()
	inflater.defAlias.Maintenance()
EndEvent

Function DebugFill(bool isAnal)
	String pool = inflater.CUM_VAGINAL
	If isAnal
		pool = inflater.CUM_ANAL
		StorageUtil.SetFloatValue(inflater.player, inflater.LAST_TIME_ANAL, inflater.GameDaysPassed.GetValue())
	Else
		StorageUtil.SetFloatValue(inflater.player, inflater.LAST_TIME_VAG, inflater.GameDaysPassed.GetValue())
	EndIf
	StorageUtil.SetFloatValue(inflater.player, pool, (maxInflation))
	float inf = maxInflation
	If inflater.GetVaginalCum(inflater.player) > 0 && inflater.getAnalCum(inflater.player) > 0
		inf *= 1.2
	EndIf
	StorageUtil.SetFloatValue(inflater.player, inflater.INFLATION_AMOUNT, inf)
	if BodyMorph
		;inflater.SetBellyMorphValue(inflater.player, inf, "PregnancyBelly")
		inflater.SetBellyMorphValue(inflater.player, inf, inflater.InflateMorph)
	Else
		inflater.SetNodeScale(inflater.player, "NPC Belly", inf)
	Endif
	If inflater.GetVaginalCum(inflater.player) + inflater.getAnalCum(inflater.player) > maxInflation * 1.2
		If !inflater.player.HasMagicEffectWithKeyword(inflater.sr_WhyWontYouDispel)
			inflater.player.AddSpell(inflater.sr_inflateBurstSpell, false)
		EndIf
	EndIf
	StorageUtil.FormListAdd(inflater, inflater.INFLATED_ACTORS, inflater.player, false)
	inflater.UpdateFaction(inflater.player)
	inflater.EncumberActor(inflater.player)
EndFunction

Bool[] Function GetUnignoredArmorSlots(GlobalVariable IgnoredArmorSlotsMask, GlobalVariable IgnoredArmorSlotsMaskB)
	Bool[] ArmorSlots = new Bool[32]

    Int CurrentArmorSlotsMaskB = Math.LeftShift(IgnoredArmorSlotsMaskB.GetValue() As Int, 24)
	Int CurrentArmorSlotsMaskA = IgnoredArmorSlotsMask.GetValue() As Int
	Int CurrentIgnoredArmorSlotsMask = Math.LogicalOr(CurrentArmorSlotsMaskA, CurrentArmorSlotsMaskB)
	
	Int Index = ArmorSlots.Length
	While Index
		Index -= 1
		Int ArmorSlotMask = Armor.GetMaskForSlot(Index + 30)
		If Math.LogicalAnd(ArmorSlotMask, CurrentIgnoredArmorSlotsMask) == ArmorSlotMask
			ArmorSlots[Index] = True
		Else
			ArmorSlots[Index] = False
		EndIf
	EndWhile
	
	Return ArmorSlots
EndFunction

Function IgnoreArmorSlot(GlobalVariable IgnoredArmorSlotsMask, GlobalVariable IgnoredArmorSlotsMaskB, Int ArmorSlot, Bool Ignore)
	Int ArmorSlotMask = Armor.GetMaskForSlot(ArmorSlot)
    Int CurrentArmorSlotsMaskB = Math.LeftShift(IgnoredArmorSlotsMaskB.GetValue() As Int, 24)
	Int CurrentArmorSlotsMaskA = IgnoredArmorSlotsMask.GetValue() As Int
	Int CurrentIgnoredArmorSlotsMask = Math.LogicalOr(CurrentArmorSlotsMaskA, CurrentArmorSlotsMaskB)
	
	Int NewIgnoredArmorSlotsMask
	If Ignore == False
		NewIgnoredArmorSlotsMask = Math.LogicalOr(ArmorSlotMask, CurrentIgnoredArmorSlotsMask)
	Else
		NewIgnoredArmorSlotsMask = Math.LogicalXor(ArmorSlotMask, CurrentIgnoredArmorSlotsMask)
	EndIf
	
	IgnoredArmorSlotsMask.SetValue(Math.LogicalAnd(NewIgnoredArmorSlotsMask, 0x00ffffff))
	IgnoredArmorSlotsMaskB.SetValue(Math.RightShift(NewIgnoredArmorSlotsMask, 24))
EndFunction
