Scriptname MilkQUEST extends Quest
{Core MME script}

SexLabFramework property SexLab auto

MilkECON Property MilkE Auto 
MilkQUEST_Conditions Property MilkQC Auto
CompanionsHousekeepingScript Property CHScript Auto 
PlayerVampireQuestScript Property PlayerVampireQuest Auto 

MME_ineed property ineed auto
MME_SOS property SOS auto
MME_SLA property SLA auto
MME_DDi property DDi auto
MME_zbf property zbf auto
MME_SLSD property SLSD auto
MME_SLHP property SLHP auto
MME_FM property FM auto
MME_SLP property SLP auto
MME_PSQ property PSQ auto
MME_SGO property SGO auto
MME_RND property RND auto

;Cross-script variables

;Varables set in ESP
Actor Property PlayerREF Auto
Message Property MakeMilkMaid Auto
GlobalVariable Property MME_NPCComments Auto
GlobalVariable Property MME_Status_Global Auto

SPELL Property MilkCritical Auto
SPELL Property MilkModInfo Auto
SPELL Property MilkModToggle Auto
SPELL Property MilkForSpriggan Auto
SPELL Property MilkForSprigganPassive Auto
SPELL Property BeingMilkedPassive Auto
SPELL Property FeedingStage Auto
SPELL Property MilkingStage Auto
SPELL Property FuckMachineStage Auto
SPELL Property MilkFx1 Auto
SPELL Property MilkFx2 Auto
SPELL Property MilkSelf Auto
SPELL Property MilkTarget Auto
SPELL Property MilkLeak Auto

SPELL Property MME_DebugSpell Auto
SPELL Property MME_ResetMaids Auto
SPELL Property MME_ResetMod Auto
SPELL Property MME_Uninstall Auto
SPELL Property MME_AM_ME Auto
SPELL Property MME_AM_BLA Auto
SPELL Property MME_AM_PLA Auto
SPELL Property MME_AM_Purge Auto
SPELL Property MME_MakeMilkmaid_Spell Auto
SPELL Property MME_MakeMilkslave_Spell Auto

Armor Property MilkCuirass auto
Armor Property MilkCuirassFuta auto
Armor Property ZaZMoMSuctionCups auto
Armor Property TITS4 auto
Armor Property TITS6 auto
Armor Property TITS8 auto
Sound Property MilkSound Auto
Sound Property FeedingSound Auto
Sound Property TakeHoldSound Auto

;Varables that doesn't care about ESP
;Arrays
Actor[] Property MilkMaid Auto
Actor[] Property MilkSlave Auto
String[] Property MilkMsgHyper Auto
String[] Property MilkMsgStage Auto
String[] Property Story Auto
String[] Property armname Auto
int[] Property armslot Auto
String[] Property MilkingEquipment Auto
String[] Property BasicLivingArmor Auto
String[] Property ParasiteLivingArmor Auto

;Varables in StorageUtil
;FormListClear(none,"MME.MilkMaid.List")					;not used
;UnsetFloatValue(none,"MME.Progression.Level")
;UnsetFloatValue(none,"MME.Progression.TimesMilked"
;UnsetFloatValue(none,"MME.Progression.TimesMilkedAll")
;UnsetFloatValue(MILKmaid[i],"MME.MilkMaid.MilkGen")
;UnsetFloatValue(MILKmaid[i],"MME.MilkMaid.BreastRows")
;UnsetFloatValue(MILKmaid[i],"MME.MilkMaid.BoobIncr")
;UnsetFloatValue(MILKmaid[i],"MME.MilkMaid.BoobPerLvl")
;UnsetFloatValue(MILKmaid[i],"MME.MilkMaid.TimesMilked")
;UnsetFloatValue(MILKmaid[i],"MME.MilkMaid.MilkingContainerCumsSUM")
;UnsetFloatValue(MILKmaid[i],"MME.MilkMaid.MilkingContainerMilksSUM")
;UnsetFloatValue(MILKmaid[i],"MME.MilkMaid.MilkingContainerLactacid")
;UnsetIntValue(MILKmaid[i],"MME.MilkMaid.MilkingMode")
;UnsetIntValue(MILKmaid[i],"MME.MilkMaid.IsSlave")

Bool Property DisableSkoomaLactacid = False Auto
Bool Property DialogueForceMilkSlave = False Auto
Bool Property MilkFlag = False Auto
Bool Property EconFlag = False Auto
Bool Property MilkNaked = False Auto
Bool Property MilkMsgs = False Auto
Bool Property MilkCntMsgs = False Auto
Bool Property MilkEMsgs = False Auto
Bool Property ForcedFeeding = False Auto
Bool Property FixedMilkGen = False Auto
Bool Property FixedMilkGen4Followers = False Auto
Bool Property CuirassSellsMilk = False Auto
Bool Property MilkStory = False Auto
Bool Property BreastScaleLimit = False Auto
Bool Property BreastUpScale = False Auto
Bool Property BreastVolumeScale = False Auto
Bool Property WeightUpScale = False Auto
Bool Property PainKills = True Auto
Bool Property MaidLvlCap = False Auto
Bool Property MilkAsMaidTimesMilked = False Auto
Bool Property MilkLeakTextures = True Auto
Bool Property MilkLeakToggle = True Auto
Bool Property MilkLeakWearArm = False Auto
Bool Property MilkSuccubusTransform = False Auto
Bool Property MilkVampireTransform = False Auto
Bool Property MilkWerewolfTransform = False Auto
Bool Property MilkingDrainsSP = True Auto
Bool Property MilkingDrainsMP = True Auto
Bool Property Feeding = True Auto
Bool Property FuckMachine = False Auto
Bool Property MilkWithZaZMoMSuctionCups = False Auto
Bool Property PainSystem = True Auto
Bool Property TradeDialogue = True Auto
Bool Property PlayerCantBeMilkmaid = False Auto
Bool Property SexLabOrgasm = True Auto
Bool Property PassiveArousalIncrease = True Auto
Bool Property ECTrigger = True Auto
Bool Property ECCrowdControl = True Auto
Bool Property ZazPumps = False Auto
Bool Property UseFutaMilkCuirass = False Auto
Bool Property FreeLactacid = False Auto
Bool Property BellyScale = True Auto
Bool Property MaleMaids = False Auto
Bool Property ArmorStrippingDisabled = False Auto
Bool Property MobileMilkingAnims = true Auto
Bool Property MilkingReq40PctMilk = true Auto
Bool Property CumProduction = true Auto

Int Property BreastScale = 0 Auto
Int Property TimesMilkedMult Auto
Int Property MilkLvlCap Auto
Int Property MilkPoll Auto					;value is unset, mod will give error if script fails to set it, obviously user papyrus/mod is broken
Int Property Milking_Duration Auto
Int Property Feeding_Duration Auto
Int Property Feeding_Sound Auto
Int Property FuckMachine_Duration Auto
Int Property ExhaustionSleepMod Auto
Int Property ECRange Auto
Int Property GushPct = 10 Auto
Int Property MilkPriceMod Auto

Float Property BoobMAX Auto
Float Property MilkProdMod Auto
Float Property MilkGenValue Auto
Float Property BoobIncr Auto
Float Property BoobPerLvl Auto
Float Property BoobBase Auto
Float Property LastTimeMilked Auto
Float Property BreastCurve Auto
Float Property LactacidDecayRate Auto

FormList Property MME_Cums Auto
FormList Property MME_Foods Auto
FormList Property MME_Drinks Auto			;all fluids
FormList Property MME_Milks Auto			;all milk
FormList Property MME_Milk_Basic Auto		;generic milk
FormList Property MME_Milk_Race Auto
FormList Property MME_Races Auto
FormList Property MME_RacesVampire Auto
FormList Property MME_Milk_Special Auto		;MME_Milk_Succubus+MME_Milk_Vampire+MME_Milk_Werewolf
FormList Property MME_Milk_Altmer_Normal Auto
FormList Property MME_Milk_Altmer_Werewolf Auto
FormList Property MME_Milk_Altmer_Succubus Auto
FormList Property MME_Milk_Altmer_Vampire Auto
FormList Property MME_Milk_Argonian_Normal Auto
FormList Property MME_Milk_Argonian_Werewolf Auto
FormList Property MME_Milk_Argonian_Succubus Auto
FormList Property MME_Milk_Argonian_Vampire Auto
FormList Property MME_Milk_Bosmer_Normal Auto
FormList Property MME_Milk_Bosmer_Werewolf Auto
FormList Property MME_Milk_Bosmer_Succubus Auto
FormList Property MME_Milk_Bosmer_Vampire Auto
FormList Property MME_Milk_Breton_Normal Auto
FormList Property MME_Milk_Breton_Werewolf Auto
FormList Property MME_Milk_Breton_Succubus Auto
FormList Property MME_Milk_Breton_Vampire Auto
FormList Property MME_Milk_Dunmer_Normal Auto
FormList Property MME_Milk_Dunmer_Werewolf Auto
FormList Property MME_Milk_Dunmer_Succubus Auto
FormList Property MME_Milk_Dunmer_Vampire Auto
FormList Property MME_Milk_Exotic_Normal Auto
FormList Property MME_Milk_Exotic_Werewolf Auto
FormList Property MME_Milk_Exotic_Succubus Auto
FormList Property MME_Milk_Exotic_Vampire Auto
FormList Property MME_Milk_Imperial_Normal Auto
FormList Property MME_Milk_Imperial_Werewolf Auto
FormList Property MME_Milk_Imperial_Succubus Auto
FormList Property MME_Milk_Imperial_Vampire Auto
FormList Property MME_Milk_Khajiit_Normal Auto
FormList Property MME_Milk_Khajiit_Werewolf Auto
FormList Property MME_Milk_Khajiit_Succubus Auto
FormList Property MME_Milk_Khajiit_Vampire Auto
FormList Property MME_Milk_Nord_Normal Auto
FormList Property MME_Milk_Nord_Werewolf Auto
FormList Property MME_Milk_Nord_Succubus Auto
FormList Property MME_Milk_Nord_Vampire Auto
FormList Property MME_Milk_Orc_Normal Auto
FormList Property MME_Milk_Orc_Werewolf Auto
FormList Property MME_Milk_Orc_Succubus Auto
FormList Property MME_Milk_Orc_Vampire Auto
FormList Property MME_Milk_Redguard_Normal Auto
FormList Property MME_Milk_Redguard_Werewolf Auto
FormList Property MME_Milk_Redguard_Succubus Auto
FormList Property MME_Milk_Redguard_Vampire Auto
FormList Property MME_Milk_Succubus Auto
FormList Property MME_Milk_Vampire Auto
FormList Property MME_Milk_Werewolf Auto
FormList Property MME_Util_Potions Auto		; Utility potions

FormList Property MME_Spells_Buffs Auto
FormList Property MME_Spells_Unmilked Auto
FormList Property MME_Spells_Wellmilked Auto

LeveledItem Property LItemFoodInnCommon Auto
LeveledItem Property LItemSkooma75 Auto
LeveledItem Property LootCitizenDrinkList75 Auto
LeveledItem Property LItemApothecaryIngredienstUncommon75 Auto
LeveledItem Property MME_LItemFoodInnCommonMilk Auto
LeveledItem Property MME_LItemSkooma75RaceMilkLactacid Auto
LeveledItem Property MME_LootCitizenDrinkList75 Auto
LeveledItem Property MME_LItemApothecaryIngredienstUncommon75 Auto

Faction Property MilkMaidFaction Auto
Faction Property MilkSlaveFaction Auto
Faction Property MME_MilkFaction Auto

;NotificationKey
Int Property NotificationKey Auto
Int Property HotKeyMode Auto

;This script only variables
Actor crosshairRef = None

;DLC's
Bool Property Plugin_HearthFires = false auto
Bool Property Plugin_Dragonborn = false auto
Bool Property Plugin_Dawnguard = false auto
Bool Property Plugin_RealisticNeedsandDiseases = false auto
Bool Property Plugin_iNeed = false auto
Bool Property Plugin_SOS = false auto
Bool Property Plugin_SOS_EQUIP = false auto
Bool Property Plugin_SOS_UNP = false auto
Bool Property Plugin_SOS_NSA = false auto
Bool Property Plugin_SOS_PUBES = false auto
Bool Property Plugin_EstrusChaurus = false auto
Bool Property Plugin_EstrusSpider = false auto
Bool Property Plugin_EstrusDwemer = false auto
Bool Property Plugin_BeeingFemale = false auto
Bool Property Plugin_FertilityMode = false auto
Bool Property Plugin_FertilityMode2 = false auto
Bool Property Plugin_FertilityMode3 = false auto
Bool Property Plugin_HentaiPregnancy = false auto
Bool Property Plugin_SexLabProcreation = false auto
Bool Property Plugin_PSQ = false auto
Bool Property Plugin_DDI = false auto
Bool Property Plugin_SLSD = false auto
Bool Property Plugin_SLA = false auto
Bool Property Plugin_SlSW = false auto

;---Contents---
;
;---Timers---
;	Event OnUpdate()														;old MilkPoll loop /RealTime seconds
;	Event OnUpdateGameTime()												;new MilkPoll loop /GameTime hours
;	Function GetCurrentHourOfDay()											;check for time in game
;
;---Notification key management---
;	Event OnKeyDown(int keyCode)											;key pressed
;	Event OnKeyUp(Int KeyCode, Float HoldTime)								;key released, time it was hold
;	Event OnCrosshairRefChange(ObjectReference ref)							;get Actor at Crosshair
;
;---Core---
;	Function ActorCheck(int t)												;Cycle through MilkMaids, run MilkCycle
;	Function MilkCycle(Actor akActor, int t)								;Generate milk/Reduce pain, add/remove effects, SendModEvent( "MME_MilkCycleComplete" ), trigger living armor effects
;	Function AssignSlot(Actor akActor)										;make Actor a MILKmaid
;	Function AssignSlotSlave(Actor akActor, Int Level, Float Milk)			;make Actor a MILKSlave
;	Function AssignSlotSlaveToMaid(Actor akActor)							;convert Actor to a MILKmaid from a MILKSlave
;	Function AssignSlotMaidToSlave(Actor akActor)							;convert Actor to a MILKSlave from a MILKmaid
;	Function CurrentSize(Actor akActor)										;Change breast size
;	Function MilkingToContainer(Actor akActor, 0, int Mode, int MilkingType, objectreference MilkBarrel = none)	;New milking script start with milk output to container
;	Function Milking(Actor akActor, 0, int Mode, int MilkingType)			;Legacy milking script start
;	Function MilkingCycle(Actor akActor, 0, int Mode, int MilkingType, objectreference MilkBarrel = none)		;Core milking script
;	Function PostMilk(Actor akActor)										;run after milking, add/remove (de)buffs
;	Function LevelCheck()													;Mastery Progression LevelCheck
;	Function MaidLevelCheck(Actor akActor)									;Maid LevelCheck
;
;---Messages---
;	Function MilkCycleMSG(Actor akActor)									;Milk tick messages
;	Function Strings_setup()												;Strings for Milk tick, armor check
;	Function MilkMsgHyper(int t, Actor akActor)								;Level up messages
;
;---Stories---
;	Function StoryDisplay(int StoryState , int StoryMode, bool FirstTime)	;Story selector
;
;---MilkPump Stories---
;	Function StoryS(int i)													;Start Story for milking pump
;	Function StoryE(int i)													;End Story for milking pump
;
;---Spriggan Stories---
;	Function StorySS(int i)													;Start Story for Spriggan
;	Function StorySE(int i)													;End Story for Spriggan
;
;---Hermaeus Mora Stories---
;	Function StoryHMS(int i)												;Start Story for Hermaeus Mora
;	Function StoryHME(int i)												;End Story for Hermaeus Mora
;
;---Living armor Stories---
;	Function StoryLAS(int i)												;Start Story for Living armor
;	Function StoryLAE(int i)												;End Story for Living armor
;
;---Utility---
;	String Function formatString(String src, String part)					;inserts string data into json string
;	Function MultibreastChange()											;Multibreast management
;	Function DLCcheck()														;Checks and updates plugins
;	int Function Milklvl0fix()												;Milklevel 0 fix since Math.Celling doesn't work, provides 1 maid slot at level 0
;	string Function ReduceFloat(String ReduceFloat)							;reduce float 0.00000 to 0.00
;	Function MMEfoodlistaddon()												;Fills inn formlists with milk and khajiit caravans with lactacid
;	Function SlSWfoodlistaddon()											;Fills skooma whore drugs formlists with lactacid
;	Function Milkmaidinfo()													;Milk maid info message box
;	Function Modtoggle()													;Milk mod toggle On/Off
;	Function AddMilkFx(Actor akActor, int i)								;Add milk leaking textures
;	Function AddLeak(Actor akActor)											;Add milk leaking effect(mesh)
;	Function RemoveMilkFx1(Actor akActor)									;Remove leaking textures - full breasts
;	Function RemoveMilkFx2(Actor akActor)									;Remove leaking textures - after milking
;	Function DebuffArraySet()												;Set/Reset DeBuff Array and fill it with spells
;	Function BuffArraySet()													;Set/Reset Buff Array and fill it with spells
;	Function MaidRemove(Actor akActor)										;Removes milkmaid[i]/milkslave[i]
;	Function MaidReset()													;Maids reset
;	Function SlaveReset()													;Slaves reset
;	Function VarSetup()														;Mod variables reset
;	Function UNINSTALL()													;Mod reset, remove (de)buffs and effects
;
;---Actor status checks---
;	string Function akActorSex(Actor akActor)								;Checks for actor sex, male, female, female+schlong=futa
;	bool Function isVampire(Actor akActor)									;Checks if actor Vampire
;	bool Function isWerewolf(Actor akActor)									;Checks if actor Werewolf
;	bool Function isSuccubus(Actor akActor)									;Checks if actor Succubus Race or PSQ Succubus
;	bool Function isPregnant(Actor akActor)									;Checks if actor pregnant (ES+, BF 1.14, SGo, PSQ SGP, SL SGP)
;	int Function PiercingCheck(Actor akActor)								;Checks for nipple piercings, DD keyword + slot 56
;	int Function IsNamedMaid(Actor akActor)									;if actor has "Milkmaid" or "Milkslave" or "Cow" string in their name
;	Function sendVibrationEvent(string str, actor who, int mpas, int MilkingType)	;modevent for Use game controller as Vibrator! V3.0 
;
;---Pain/Exhaustion---
;	string Function NState(Actor akActor)									;Checks and returns nipple status of actor
;	int Function Pain(Actor akActor, int pain) 								;Increase pain during milking
;
;---Devious Devices checks(DDi plugin)---
;	bool Function IsWearingZaZGag (Actor akActor)
;	bool Function IsWearingZaZGag_Open (Actor akActor)
;	bool Function IsWearingGag (Actor akActor)
;	bool Function IsWearingGag_Open (Actor akActor)
;	bool Function IsWearingBelt (Actor akActor)
;	bool Function IsWearingBelt_Open (Actor akActor)
;	bool Function IsWearingDDMilker (Actor akActor)							;allows milking with DD bra/harness containing "Milk" in name
;	bool Function IsMilkingBlocked_Bra (Actor akActor)
;	bool Function IsMilkingBlocked_Armbinder (Actor akActor)
;	bool Function IsMilkingBlocked_Yoke (Actor akActor)
;	bool Function IsMilkingBlocked_PiercingsNipple (Actor akActor)
;	bool Function IsMilkingBlocked_Suit (Actor akActor)
;	bool Function IsWearingHarness (Actor akActor)
;	bool Function IsMilkingBlocked_Bra_SLSD (Actor akActor) 				;if true allows solo milking
;
;---SLA check(SLA plugin)---												;if SLA installed passes info to SLA, if not, returns 0
;	int Function GetActorArousal(Actor akActor)
;	float Function GetActorExposure(Actor akActor)
;	float Function GetActorExposureRate(Actor akActor)
;	Function UpdateActorExposure(Actor akActor, Int value)
;	Function UpdateActorExposureRate(Actor akActor, Float value)
;	Function UpdateActorOrgasmDate(Actor akActor)

;----------------------------------------------------------------------------
;Timers
;----------------------------------------------------------------------------
Event OnInit()
	Debug.Trace("MilkModEconomy 1st run, MilkQUEST script started")
EndEvent

Event OnUpdate()
	if MilkPoll != 0
		if MilkPoll > 24
			RegisterForSingleUpdate(MilkPoll)
			ActorCheck(1)
		else
			RegisterForSingleUpdateGameTime (MilkPoll)
			GetCurrentHourOfDay()
		endif
	else
		Debug.Messagebox("MilkModEconomy MilkPoll interval is 0, mod is broken, have a nice day!")
	endif
EndEvent

Event OnUpdateGameTime()
	if MilkPoll != 0
		if MilkPoll <= 24
			RegisterForSingleUpdateGameTime (MilkPoll)
			Utility.Wait( 5.0 )
			GetCurrentHourOfDay()
		else
			RegisterForSingleUpdate(MilkPoll)
			ActorCheck(1)
		endif
	else
		Debug.Messagebox("MilkModEconomy MilkPoll interval is 0, mod is broken, have a nice day!")
	endif
EndEvent

Function GetCurrentHourOfDay()
	float Time = Utility.GetCurrentGameTime() 	; skyrim days spend in game
;	Time *= 24 									; skyrim hours spend in game
;	Time *= 60 									; skyrim minutes spend in game

	if LastTimeMilked != 0
		int scriptupdatetimes = ((Math.Floor(Time*24)) - (Math.Floor(LastTimeMilked*24)))
		if scriptupdatetimes >= 1 
			ActorCheck(scriptupdatetimes)
			LastTimeMilked = Time
		endif
	else
		LastTimeMilked = Time
	endif
EndFunction

;----------------------------------------------------------------------------
;Key management
;----------------------------------------------------------------------------

Event OnKeyDown(int keyCode)
	Actor akActor = crosshairRef
	If !Utility.IsInMenuMode() && NotificationKey == keyCode
		If HotkeyMode == 1
			;create uie
		Else
			String MaidName
			If akActor != None
				If MILKmaid.find(akActor) == -1 && MILKslave.find(akActor) == -1
					MaidName = akActor.GetLeveledActorBase().GetName()
					Debug.Notification(formatString(JsonUtil.GetStringValue("/MME/Strings", "isnotmaidslave"), MaidName))
					Return
				EndIf
			Else
				if MILKmaid.find(PlayerRef) != -1
					akActor = PlayerRef
					;Alias[0].AddScriptPackage MilkPackage
				Else
					MaidName = PlayerRef.GetLeveledActorBase().GetName()
					Debug.Notification(formatString(JsonUtil.GetStringValue("/MME/Strings", "isnotmaid"), MaidName))
					Return
				EndIf
			EndIf
			
			If akActor != None && (MILKmaid.find(akActor) != -1 || MILKslave.find(akActor) != -1)
				if StorageUtil.GetIntValue(akActor, "MME.MilkMaid.IsAnimating") == 1 && akActor.HasSpell( BeingMilkedPassive ) && akActor == PlayerRef && MobileMilkingAnims						;Changes random animation
					Debug.SendAnimationEvent(akActor,JsonUtil.StringListGet("/MME/Strings", "standingmilkinganimations", Utility.RandomInt(0, JsonUtil.StringListCount("/MME/Strings", "standingmilkinganimations") - 1)))
				endif
				Float MilkCnt = MME_Storage.getMilkCurrent(akActor)
				Float PainCnt = MME_Storage.getPainCurrent(akActor)
				Float PainMax = MME_Storage.getPainMaximum(akActor)
				MaidName = akActor.GetLeveledActorBase().GetName()
				Debug.Notification(formatString(JsonUtil.GetStringValue("/MME/Strings", "onkeyeventstatus"),\
					MaidName,\
					ReduceFloat(MilkCnt),\
					NState(akActor) + " [" + (PainCnt/PainMax*100) as int + "%]",\
					ReduceFloat(MME_Storage.getLactacidCurrent(akActor))))
			EndIf
		EndIf
	EndIf
EndEvent

Event OnKeyUp(Int KeyCode, Float HoldTime)
	Actor akActor = crosshairRef
	If (!Utility.IsInMenuMode() && NotificationKey == keyCode)
		If HotkeyMode == 1
			;create uie
		Else
			If akActor ==  none
				akActor = PlayerRef
			EndIf
			
			If (Input.IsKeyPressed(42) && Input.IsKeyPressed(54))
				If akActor.HasSpell( BeingMilkedPassive )
					akActor.RemoveSpell( BeingMilkedPassive )
				EndIf
			ElseIf (Input.IsKeyPressed(42) || Input.IsKeyPressed(54)) || (HoldTime > 2.0)
				String MaidName = akActor.GetLeveledActorBase().GetName()
				If akActor.HasSpell( BeingMilkedPassive )				;restores PC control\resets animation
					If !StorageUtil.GetIntValue(akActor,"IsBoundStrict"); && !SexLab.IsActorActive(akActor)
						If akActor == PlayerRef
							Game.EnablePlayerControls() ;(True,True,True,True,True,True,True,True,0)
						EndIf
						Debug.SendAnimationEvent(akActor,"IdleForceDefaultState")
						StorageUtil.SetIntValue(akActor, "MME.MilkMaid.IsAnimating", 0)
					EndIf

				ElseIf akActor.HasSpell( MilkForSprigganPassive )
					Debug.Notification(formatString(JsonUtil.GetStringValue("/MME/Strings", "onkeyeventspriggan"), MaidName))

				ElseIf StorageUtil.GetIntValue(akActor,"MME.MilkMaid.IsSlave" ) == 1 && StorageUtil.GetIntValue(akActor,"MME.MilkMaid.MilkingMode") != 0
					Debug.Notification(formatString(JsonUtil.GetStringValue("/MME/Strings", "onkeyeventisslave"), MaidName))

				ElseIf akActor.GetLeveledActorBase().GetSex() == 1
					MilkSelf.cast(akActor)
				EndIf
			EndIf
		EndIf
	EndIf
EndEvent

Event OnCrosshairRefChange(ObjectReference ref)
	crosshairRef = none
	If ref != none
		crosshairRef = ref as Actor
	EndIf
EndEvent

;----------------------------------------------------------------------------
;Core
;----------------------------------------------------------------------------

Function ActorCheck(int t)
	debug.Trace("MilkModEconomy ActorCheck cycle")
	int i = 0
	If PlayerRef != None
		If MilkMaid[i] != PlayerRef && (PlayerRef.GetLeveledActorBase().GetSex() == 1 || MaleMaids == true) && isPregnant(PlayerRef)
			debug.Trace("MilkModEconomy Player is not milkmaid, but pregnant, making player milkmaid")
			AssignSlot(PlayerRef)
		EndIf
		
		While i < MilkMaid.Length
			if MilkMaid[i] != None
				if MilkMaid[i].IsDead()
					debug.Trace("MilkModEconomy Actor is dead, removing form MME:" + MilkMaid[i].GetLeveledActorBase().GetName())
					SingleMaidReset(MilkMaid[i])
				elseif (MilkMaid[i].GetLeveledActorBase().GetSex() == 1 || MaleMaids == true)
					debug.Trace("MilkModEconomy MilkCycle for milkmaid:" + MilkMaid[i].GetLeveledActorBase().GetName())
					MilkCycle(MilkMaid[i] , t)
				endif
			endif
			;(GetNthAlias(Alias[0])).ForceRefTo(PlayerRef)
			i += 1
		EndWhile
		
		i = 0
		While i < MilkSlave.Length
			if MilkSlave[i] != None
				if MilkSlave[i].IsDead()
					debug.Trace("MilkModEconomy Actor is dead, removing form MME:" + MilkSlave[i].GetLeveledActorBase().GetName())
					SingleMaidReset(MilkSlave[i])
				elseif (MilkSlave[i].GetLeveledActorBase().GetSex() == 1 || MaleMaids == true)
					debug.Trace("MilkModEconomy MilkCycle for MilkSlave:" + MilkSlave[i].GetLeveledActorBase().GetName())
					MilkCycle(MilkSlave[i] , t)
				endif
			endif
			i += 1
		EndWhile
		
		SendModEvent( "MME_MilkCycleComplete" )
	else
		Debug.Messagebox("MilkModEconomy PlayerRef is None, mod is broken, have a nice day!")
	endif
EndFunction

Function UpdateActors()
	int idx1 = 0
	While idx1 < MilkMaid.Length
		if MilkMaid[idx1] != none
			MME_Storage.updateMilkMaximum(MilkMaid[idx1])
			MME_Storage.updateMilkCurrent(MilkMaid[idx1])
			CurrentSize(MilkMaid[idx1])
		endif
		idx1 += 1
	EndWhile
	
	idx1 = 0
	While idx1 < MilkSlave.Length
		if MilkSlave[idx1] != none
			MME_Storage.updateMilkMaximum(MilkSlave[idx1])
			MME_Storage.updateMilkCurrent(MilkSlave[idx1])
			CurrentSize(MilkSlave[idx1])
		endif
		idx1 += 1
	EndWhile
EndFunction

Function MilkCycle(Actor akActor, int t)
	Float MilkTick
	Float MilkTickCycle
	Float PainTick
	Float BoobTick
	
	Float LactacidMod = StorageUtil.GetFloatValue(none,"MME.LactacidMod", missing = 10)
	Float LactacidCnt = MME_Storage.getLactacidCurrent(akActor)
	Float MaidMilkGen = StorageUtil.GetFloatValue(akActor,"MME.MilkMaid.MilkGen")
	Float BreastBase = MME_Storage.getBreastsBasevalue(akActor)
	Float BreastBaseMod = MME_Storage.getBreastsBaseadjust(akActor)
	Float MilkCnt = MME_Storage.getMilkCurrent(akActor)
	Float MilkMax = MME_Storage.getMilkMaximum(akActor)
	Float PainCnt = MME_Storage.getPainCurrent(akActor)
	Int BreastRows = MME_Storage.getBreastRows(akActor)
	Int MaidLevelProgressionAffectsMilkGen = StorageUtil.GetIntValue(none,"MME.MaidLevelProgressionAffectsMilkGen", missing = 0)
	Int MaidLevel
	Float LactacidFactor
	
	Bool IsMilkingArmor = false
	Bool IsBabyArmor = false
	String MaidName = akActor.GetLeveledActorBase().GetName()
	
	Form maidArmor = akActor.GetWornForm(Armor.GetMaskForSlot(32))
	
	;add/remove breast row trigger, cause lactation due to drinking breast inc/dec potion
	if 	StorageUtil.GetFloatValue(akActor, "MME.MilkMaid.BreastBaseModPotion") != 0
		if 	StorageUtil.GetFloatValue(akActor, "MME.MilkMaid.BreastBaseModPotion") > 0
			BreastBaseMod += 0.01
			if Utility.RandomInt(0, 100) <= 25
				if StorageUtil.GetFloatValue(akActor, "MME.MilkMaid.MilkGen") == 0
					debug.Notification(MaidName + "'s breasts has started lactating.")
					StorageUtil.AdjustFloatValue(akActor, "MME.MilkMaid.MilkGen", 1/3/10)
					AddMilkFx(akActor, 1)
					AddLeak(akActor)
				else
					StorageUtil.AdjustFloatValue(akActor, "MME.MilkMaid.MilkGen", 1/3/10)
					debug.Notification(MaidName + "'s lactation has increased.")
					MaidMilkGen = StorageUtil.GetFloatValue(akActor,"MME.MilkMaid.MilkGen")
				endif
				if Utility.RandomInt(1, 100) <= MilkQC.BrestEnlargement_MultiBreast_Effect && BreastRows < 4
					StorageUtil.SetFloatValue(akActor,"MME.MilkMaid.AdjustBreastRow", 1)							;add breast row on sleep
				endif
			endif
			;do to ticks to inc breast size, not bound to hours(t) coz im lazy
			StorageUtil.AdjustFloatValue(akActor, "MME.MilkMaid.BreastBaseModPotion", -0.01)
		elseif 	StorageUtil.GetFloatValue(akActor, "MME.MilkMaid.BreastBaseModPotion") < 0
			BreastBaseMod -= 0.01
			if Utility.RandomInt(0, 100) <= 25 && BreastRows > 1
				StorageUtil.SetFloatValue(akActor,"MME.MilkMaid.AdjustBreastRow", -1) 								;remove breast row on sleep
			endif
			;do to ticks to dec breast size, not bound to hours(t) coz im lazy
			StorageUtil.AdjustFloatValue(akActor, "MME.MilkMaid.BreastBaseModPotion", 0.01)
		endif
		MME_Storage.setBreastsBaseadjust(akActor, BreastBaseMod)
		BreastBaseMod = MME_Storage.getBreastsBaseadjust(akActor)
	endif
	
	BoobTick = BreastBase + BreastBaseMod
	
	if BoobTick <= 0
		BoobTick = 0.01
	endif

	if t > MilkMax && BreastScaleLimit
		t = MilkMax as int
	endif
	
	;cycle to generate milk, raise/lower generation
	If (FixedMilkGen || (akActor != PlayerREF && FixedMilkGen4Followers ))												;fixed milkproduction
		MilkTick = 1.0 / 3 * BreastRows * (1 + SLA.GetActorArousal(akActor)/100) * MilkProdMod/100 * t
		if LactacidDecayRate > 0																						;reduce lactacid, for purpose of belly decrease
			LactacidCnt -= LactacidDecayRate
		elseif LactacidDecayRate == 0
			LactacidCnt -= MilkTick
		endif
		if LactacidCnt < 0
			LactacidCnt = 0
		endif
	else																												;dynamic milk production
		Int tmod1 = t
		while tmod1 != 0
			MaidLevel = MME_Storage.getMaidLevel(akActor)
			LactacidFactor = ((LactacidCnt * LactacidCnt) / LactacidMod / PapyrusUtil.ClampInt(MaidLevel, 1, MaidLevel + 1))
			
			;raise/lower generation
			if LactacidCnt > 0\
			|| (isPregnant(akActor) && (MilkCnt + MilkTick < MilkMax))
			;|| ((MaidMilkGen > 0 || isPregnant(akActor)) && (MilkCnt + MilkTick < MilkMax))							;has lactacid or pregnant and not full, increase milk generation
				if MaidLevelProgressionAffectsMilkGen == 0 || MaidLevel == 0
					MaidMilkGen += MilkGenValue * BreastRows
				else
					MaidMilkGen += MilkGenValue * BreastRows * (MaidLevelProgressionAffectsMilkGen * MaidLevel)
				endif
			elseif isPregnant(akActor)																					;no lactacid, pregnant, full of milk
				;do nothing
			else																										;no lactacid, not pregnant, reduce milk generation
				MaidMilkGen -= (MilkGenValue * BreastRows)/ (1 + MaidLevelProgressionAffectsMilkGen * MaidLevel)
				if MaidMilkGen < 0
					MaidMilkGen = 0
				endif
			endif
			
			;generate milk
			float LactacidCycle = 0
			if MaidMilkGen > 0
				MilkTickCycle = (BoobTick + MaidMilkGen)/3/10 * (1 + SLA.GetActorArousal(akActor)/100) * MilkProdMod/100;basic milkproduction formula
				LactacidCycle = PapyrusUtil.ClampFloat(MilkTickCycle * LactacidFactor, 0, LactacidCnt)					;calculate LactacidFactor bonus milkproduction
				MilkTickCycle = MilkTickCycle + LactacidCycle															;basic+bonus
				MilkTick += MilkTickCycle																				;final milk production
			endif
			
			;actor weight scaling, disabled cuz it can cause neck seam
			;if  WeightUpScale && akActor.GetLeveledActorBase().GetWeight() + 1 < 100 && LactacidCnt > 0
			;	Float NeckDelta = (akActor.GetLeveledActorBase().GetWeight() / 100) - ((akActor.GetLeveledActorBase().GetWeight() + 1) / 100)
			;	akActor.GetLeveledActorBase().SetWeight(akActor.GetLeveledActorBase().GetWeight() + 1)
			;	akActor.UpdateWeight(NeckDelta)
			;endif
			
			if LactacidDecayRate > 0																					;reduce lactacid
				LactacidCnt -= LactacidDecayRate
			elseif LactacidDecayRate == 0
				LactacidCnt -= MilkTickCycle
			endif
			if LactacidCnt < 0
				LactacidCnt = 0
			endif
			
			tmod1 -= 1
		endwhile
	EndIf

	;update actor values
	If MilkAsMaidTimesMilked
		StorageUtil.AdjustFloatValue(akActor,"MME.MilkMaid.TimesMilked", MilkTick)
		MaidLevelCheck(akActor)
		MilkMax = MME_Storage.getMilkMaximum(akActor)
	EndIf

	Paintick = MilkTick + MilkMax/10
	MilkCnt += MilkTick
	PainCnt -= paintick
	
	if PainCnt < 0
		PainCnt = 0
	endif

	if akActor.IsNearPlayer()
		RemoveMilkFx1(akActor)
		RemoveMilkFx2(akActor)
	endif
	
	if PassiveArousalIncrease && MilkTick > 0
		SLA.UpdateActorExposure(akActor, t)
	endif

	if maidArmor != None
		if MilkingEquipment.Find(maidArmor.getname()) != -1\
		|| maidArmor == MilkCuirass\
		|| maidArmor == MilkCuirassFuta\
		|| StringUtil.Find(maidArmor.getname(), "Milk" ) >= 0\
		|| StringUtil.Find(maidArmor.getname(), "Cow" ) >=0
			IsMilkingArmor = true
		endif
	endif
	
	If Plugin_BeeingFemale
		IsBabyArmor = akActor.IsEquipped(Game.GetFormFromFile(0x5D17D, "BeeingFemale.esm"))\
					|| akActor.IsEquipped(Game.GetFormFromFile(0x5D17E, "BeeingFemale.esm"))\
					|| akActor.IsEquipped(Game.GetFormFromFile(0x5D182, "BeeingFemale.esm"))\
					|| akActor.IsEquipped(Game.GetFormFromFile(0x5D183, "BeeingFemale.esm"))\
					|| akActor.IsEquipped(Game.GetFormFromFile(0x61CFF, "BeeingFemale.esm"))\
					|| akActor.IsEquipped(Game.GetFormFromFile(0x61D00, "BeeingFemale.esm"))\
					|| akActor.IsEquipped(Game.GetFormFromFile(0x61D01, "BeeingFemale.esm"))\
					|| akActor.IsEquipped(Game.GetFormFromFile(0x61D02, "BeeingFemale.esm"))\
					|| akActor.IsEquipped(Game.GetFormFromFile(0x61D03, "BeeingFemale.esm"))\
					|| akActor.IsEquipped(Game.GetFormFromFile(0x61D04, "BeeingFemale.esm"))
	EndIf
	
	if Plugin_FertilityMode && IsBabyArmor == false
		IsBabyArmor = akActor.IsEquipped(Game.GetFormFromFile(0x05E7E, "FertilityMode.esp"))\
					|| akActor.IsEquipped(Game.GetFormFromFile(0x0BFB8, "FertilityMode.esp"))\
					|| akActor.IsEquipped(Game.GetFormFromFile(0x0BFB9, "FertilityMode.esp"))\
					|| akActor.IsEquipped(Game.GetFormFromFile(0x0BFBA, "FertilityMode.esp"))\
					|| akActor.IsEquipped(Game.GetFormFromFile(0x0BFBB, "FertilityMode.esp"))\
					|| akActor.IsEquipped(Game.GetFormFromFile(0x105D4, "FertilityMode.esp"))\
					|| akActor.IsEquipped(Game.GetFormFromFile(0x105D5, "FertilityMode.esp"))\
					|| akActor.IsEquipped(Game.GetFormFromFile(0x105D6, "FertilityMode.esp"))
	endif
	
	if Plugin_FertilityMode2 && IsBabyArmor == false
		IsBabyArmor = akActor.IsEquipped(Game.GetFormFromFile(0x08964, "Fertility Mode.esp"))\
					|| akActor.IsEquipped(Game.GetFormFromFile(0x08ECE, "Fertility Mode.esp"))\
					|| akActor.IsEquipped(Game.GetFormFromFile(0x08ECF, "Fertility Mode.esp"))\
					|| akActor.IsEquipped(Game.GetFormFromFile(0x08ED0, "Fertility Mode.esp"))\
					|| akActor.IsEquipped(Game.GetFormFromFile(0x08ED1, "Fertility Mode.esp"))\
					|| akActor.IsEquipped(Game.GetFormFromFile(0x08ED2, "Fertility Mode.esp"))\
					|| akActor.IsEquipped(Game.GetFormFromFile(0x08ED3, "Fertility Mode.esp"))\
					|| akActor.IsEquipped(Game.GetFormFromFile(0x08ED4, "Fertility Mode.esp"))
	endif
	
	if Plugin_FertilityMode3 && IsBabyArmor == false
		IsBabyArmor = akActor.IsEquipped(Game.GetFormFromFile(0x08964, "Fertility Mode.esm"))\
					|| akActor.IsEquipped(Game.GetFormFromFile(0x08ECE, "Fertility Mode.esm"))\
					|| akActor.IsEquipped(Game.GetFormFromFile(0x08ECF, "Fertility Mode.esm"))\
					|| akActor.IsEquipped(Game.GetFormFromFile(0x08ED0, "Fertility Mode.esm"))\
					|| akActor.IsEquipped(Game.GetFormFromFile(0x08ED1, "Fertility Mode.esm"))\
					|| akActor.IsEquipped(Game.GetFormFromFile(0x08ED2, "Fertility Mode.esm"))\
					|| akActor.IsEquipped(Game.GetFormFromFile(0x08ED3, "Fertility Mode.esm"))\
					|| akActor.IsEquipped(Game.GetFormFromFile(0x08ED4, "Fertility Mode.esm"))
	endif
	
	;play leaking effects, if breast are bigger then max
	if MilkCnt > MilkMax && PiercingCheck(akActor) != 2
		If BreastScaleLimit
			MilkCnt = MilkMax
		else
			;float bottles = (MilkCnt - MilkMax) / MilkCnt/MilkMax
			float bottles = MilkCnt - MilkMax - ((MilkCnt / MilkMax) - 1) * MaidLevel
			if IsMilkingArmor
				StorageUtil.AdjustFloatValue(akActor, "MME.MilkMaid.MilkingContainerMilksSUM", bottles)
			endIf
			MilkCnt -= bottles
		endif
		if akActor.IsNearPlayer()
			AddMilkFx(akActor, 1)
			AddLeak(akActor)
		endif
	endif

	StorageUtil.SetFloatValue(akActor,"MME.MilkMaid.MilkGen", MaidMilkGen)
	MME_Storage.setLactacidCurrent(akActor, LactacidCnt)
	MME_Storage.setPainCurrent(akActor, PainCnt)
	MME_Storage.setMilkCurrent(akActor, MilkCnt, BreastScaleLimit)

	CurrentSize(akActor)
	PostMilk(akActor)
	
	if MilkMsgs
		MilkCycleMSG(akActor)
	endif
	
	;reset actor maid progression
	if MaidMilkGen == 0 && MaidLevel == 0 && MilkCnt < 1
		StorageUtil.SetFloatValue(akActor,"MME.MilkMaid.TimesMilked", 0)
	endif

	;add/remove breast row trigger, cause lactation due to drinking breast inc/dec potion
	if StorageUtil.GetFloatValue(akActor, "MME.MilkMaid.AdjustBreastRow") != 0 
		if  MilkQC.Buffs && akActor.IsNearPlayer()
			akActor.AddSpell( MME_Spells_Buffs.GetAt(3) as Spell, false )
			if PainSystem && PainKills
				akActor.DamageActorValue("Health", 0.5 * akActor.GetActorValue("Health"))
			endif
		endif
		If MilkMsgs && PlayerREF.GetDistance(akActor) < 500
			If PlayerREF == akActor
				Debug.Notification("Your chest hurts, maybe you should rest, some sleeping might relief your pain" )
			else
				Debug.Notification(MaidName + "'s chest hurts, maybe you should rest, some sleeping might relief her pain" )
			endif
		endif
	endif
		
	;events based on equipped armor(milking,estus etc)
	if maidArmor != None && MME_Storage.getBreastRows(akActor) == 1
		if IsBabyArmor
			if MilkCnt >= 1 && akActor.IsNearPlayer()
				Milking(akActor, 0, 4, 0)
			endif
		elseif IsMilkingArmor
			if StorageUtil.GetIntValue(akActor,"MME.MilkMaid.MilkingMode") == 2
				if StorageUtil.GetFloatValue(akActor,"MME.MilkMaid.MilkingContainerLactacid") > 0
					if LactacidCnt < 1 && MilkCnt <= 1
						MME_Storage.changeLactacidCurrent(akActor, 1)
					endif
					StorageUtil.AdjustFloatValue(akActor,"MME.MilkMaid.MilkingContainerLactacid", -1)
					if Plugin_SlSW && akActor == PlayerREF && !DisableSkoomaLactacid
						akActor.equipitem(Game.GetFormFromFile(0x57A7A, "Skyrim.esm"),false,true)	;skooma
					endif
				endif
				if MilkCnt >= MilkMax * 0.75 && akActor.IsNearPlayer() && !SexLab.IsActorActive(akActor)
					MilkSelf.cast(akActor)
				endif
			endif
		elseif StringUtil.Find(maidArmor.getname(), "Spriggan" ) >= 0\
		|| StringUtil.Find(maidArmor.getname(), "Living Arm" ) >= 0\
		|| StringUtil.Find(maidArmor.getname(), "Hermaeus Mora" ) >= 0\
		|| StringUtil.Find(maidArmor.getname(), "HM Priestess" ) >= 0\
		|| StringUtil.Find(maidArmor.getname(), "Tentacle Armor" ) >= 0\
		|| StringUtil.Find(maidArmor.getname(), "Tentacle Parasite" ) >= 0\
		|| BasicLivingArmor.find(maidArmor.getname()) >= 0\
		|| ParasiteLivingArmor.find(maidArmor.getname()) >= 0
			if LactacidCnt < 1 && MilkCnt <= 1
				MME_Storage.changeLactacidCurrent(akActor, t)
			endif
			if Plugin_SlSW && akActor == PlayerREF && !DisableSkoomaLactacid
				akActor.equipitem(Game.GetFormFromFile(0x57A7A, "Skyrim.esm"),false,true)	;skooma
			endif
			int random = Utility.RandomInt((0-MilkCnt) as int, (MilkMax-MilkCnt) as int)
			if (random == MilkMax || random < 0) && (akActor.GetLeveledActorBase().GetSex() == 1 || MaleMaids == true) && akActor.IsNearPlayer() && !SexLab.IsActorActive(akActor)
				;Estrus Chaurus+  
				if (StringUtil.Find(maidArmor.getname(), "Tentacle Armor" ) >= 0 || StringUtil.Find(maidArmor.getname(), "Tentacle Parasite" ) >= 0 || ParasiteLivingArmor.find(maidArmor.getname()) >= 0)\
				&& Plugin_EstrusChaurus && ECTrigger
					int ECTrap = ModEvent.Create("ECStartAnimation")  					; Int  Does not have to be named "ECTrap" any name would do
					if (ECTrap) && !akActor.IsInCombat() && !akActor.IsOnMount()
						ModEvent.PushForm(ECTrap, akActor)								; Form (Some SendModEvent scripting "black magic" - required)
						ModEvent.PushForm(ECTrap, akActor)								; Form The animation target
						ModEvent.PushInt(ECTrap, 0)										; Int  The animation required    0 = Tentacles, 1 = Machine
						ModEvent.PushBool(ECTrap, true)									; Bool Apply the linked EC effect (Ovipostion for Tentacles, Exhaustion for Machine) 
						ModEvent.Pushint(ECTrap, ECRange)								; Int  Alarm radius in units (0 to disable) 
						ModEvent.PushBool(ECTrap, ECCrowdControl)						; Bool Use EC (basic) crowd control on hostiles 
						ModEvent.Send(ECtrap)
					else
						;EC is not installed
					endIf
					Milking(akActor, 0, 4, 0)
				elseif akActor.IsNearPlayer()
					MilkForSpriggan.cast(akActor)
				endif
			endif
		elseif akActor == PlayerREF && !ArmorStrippingDisabled && Sexlab.IsStrippable(maidArmor)
			if !(maidArmor == TITS4	|| maidArmor == TITS6 || maidArmor == TITS8 || DDi.IsMilkingBlocked_Suit(akActor))
				;heavy armor	
				if MilkCnt > 4 && maidArmor.HasKeyword(Game.GetFormFromFile(0x6BBD2, "Skyrim.esm") as keyword)
					Debug.Notification("Your breasts are too big to fit into your heavy armor")
					akActor.UnEquipItem(maidArmor)
				endif
				;light armor	
				if MilkCnt > 8 && maidArmor.HasKeyword(Game.GetFormFromFile(0x6BBD3, "Skyrim.esm") as keyword)
					Debug.Notification("Your breasts are too big to fit into your light armor")
					akActor.UnEquipItem(maidArmor)
				endif
				;clothes
				if MilkCnt > 12
					Debug.Notification("Your breasts are too big to fit into your clothes")
					akActor.UnEquipItem(maidArmor)
				endif
			endif
		endif
	endif
	
	If MILKSlave.Find(akActor) != -1
		if LactacidCnt < 1 && MilkCnt <= 1
			MME_Storage.changeLactacidCurrent(akActor, t)
		endif
		MilkMax = MME_Storage.getMilkMaximum(akActor)
		if MilkCnt >= MilkMax * 0.75 && akActor.IsNearPlayer() && !SexLab.IsActorActive(akActor)
			MilkSelf.cast(akActor)
		endif
	endIf
EndFunction

Function AssignSlot(Actor akActor)
	If akActor == PlayerREF
		if PlayerCantBeMilkmaid == true
			return
		endif
		MILKmaid[0] = akActor
	Else
		int i = 0
		int count = 0
		int t = MILKmaid.Find(none,1)

		If t == -1
			Debug.notification("No more Milk Maid slots")
			return
		Else
			While i < MilkMaid.Length
				i += 1
				If MilkMaid[i] != None
					count += 1
				EndIf
			EndWhile
			
			;Debug.notification(MilkMaid.Length + " " + count + " " + Milklvl0fix )

			If count >= Milklvl0fix()
				Debug.notification("No more Milk Maid slots")
				return
			Else
				MILKmaid[t] = akActor
			Endif
		EndIf
	EndIf
	MME_Storage.initializeActor(akActor)
	String MaidName = akActor.GetLeveledActorBase().GetName()
	Debug.Notification(formatString(JsonUtil.GetStringValue("/MME/Strings", "assignslotmaid"), MaidName))
	akActor.AddToFaction(MilkMaidFaction)
EndFunction

Function AssignSlotMaid(Actor akActor)
	If akActor == PlayerREF
		if PlayerCantBeMilkmaid == true
			return
		endif
		MILKmaid[0] = akActor
	Else
		int i = 0
		int count = 0
		int t = MILKmaid.Find(none,1)

		If t == -1
			Debug.Notification(JsonUtil.GetStringValue("/MME/Strings", "assignslotnomaidsslots"))
			return
		Else
			While i < MilkMaid.Length
				i += 1
				If MilkMaid[i] != None
					count += 1
				EndIf
			EndWhile
			
			;Debug.notification(MilkMaid.Length + " " + count + " " + Milklvl0fix )

			If count >= Milklvl0fix()
				Debug.Notification(JsonUtil.GetStringValue("/MME/Strings", "assignslotnomaidsslots"))
				return
			Else
				MILKmaid[t] = akActor
			Endif
		EndIf
	EndIf
	MME_Storage.initializeActor(akActor)
	String MaidName = akActor.GetLeveledActorBase().GetName()
	Debug.Notification(formatString(JsonUtil.GetStringValue("/MME/Strings", "assignslotmaid"), MaidName))
	akActor.AddToFaction(MilkMaidFaction)
EndFunction

Function AssignSlotSlave(Actor akActor, Int Level, Float Milk)
	If akActor == PlayerREF
		String MaidName = akActor.GetLeveledActorBase().GetName()
		Debug.Notification(formatString(JsonUtil.GetStringValue("/MME/Strings", "assignslotactorispc"), MaidName))
		return
	EndIf
	int i = MILKSlave.Find(none)
	If i != -1
		MILKSlave[i] = akActor
		MME_Storage.initializeActor(akActor, Level, Milk)
		StorageUtil.SetIntValue(akActor,"MME.MilkMaid.IsSlave", 1)
		akActor.AddToFaction(MilkSlaveFaction)
		CurrentSize(akActor)
	Else
		Debug.Notification(JsonUtil.GetStringValue("/MME/Strings", "assignslotnoslaveslots"))
		return
	Endif
EndFunction

Function AssignSlotSlaveToMaid(Actor akActor)
	int i = MILKSlave.Find(akActor)
	If i != -1
		AssignSlot(akActor)
		if akActor.isInFaction(MilkMaidFaction)
			StorageUtil.SetIntValue(akActor,"MME.MilkMaid.IsSlave", 0)
			akActor.RemoveFromFaction(MilkSlaveFaction)
			MILKSlave[i] = none
		endif
	Else
		String MaidName = akActor.GetLeveledActorBase().GetName()
		Debug.Notification(formatString(JsonUtil.GetStringValue("/MME/Strings", "assignslotstm"), MaidName))
		return
	Endif
EndFunction

Function AssignSlotMaidToSlave(Actor akActor)
	int i = MilkMaid.Find(akActor)
	If i != -1
		i = 1
		i = MILKSlave.Find(none,1)
		If i != -1
			MILKSlave[i] = akActor
		Else
			Debug.Notification(JsonUtil.GetStringValue("/MME/Strings", "assignslotnoslaveslots"))
			return
		Endif
		StorageUtil.SetIntValue(akActor,"MME.MilkMaid.IsSlave", 1)
		akActor.AddToFaction(MilkSlaveFaction)
		akActor.RemoveFromFaction(MilkMaidFaction)
		MilkMaid[i] = none
	Else
		String MaidName = akActor.GetLeveledActorBase().GetName()
		Debug.Notification(formatString(JsonUtil.GetStringValue("/MME/Strings", "assignslotmts"), MaidName))
		return
	Endif
EndFunction

Function CurrentSize(Actor akActor)
	Float BreastBase = MME_Storage.getBreastsBasevalue(akActor)
	Float MaidBoobIncr = StorageUtil.GetFloatValue(akActor,"MME.MilkMaid.BoobIncr")			;fetch individual maid data
	Float MaidBoobPerLvl = StorageUtil.GetFloatValue(akActor,"MME.MilkMaid.BoobPerLvl")		;fetch individual maid data
	Float BreastBaseMod = MME_Storage.getBreastsBaseadjust(akActor)
	Float MilkCnt = MME_Storage.getMilkCurrent(akActor)
	Int   MaidLevel = MME_Storage.getMaidLevel(akActor)
	Float MaidTimesMilked = StorageUtil.GetFloatValue(akActor,"MME.MilkMaid.TimesMilked")
	Float CurrentSize
	Float CurveFix
	Float LactacidCnt
	
	If BreastScale == 3						;off
		CurrentSize = 1
		CurveFix = 1
	Else
		if MaidBoobIncr < 0 				;set to general maid data
			MaidBoobIncr = BoobIncr
		endif
		if MaidBoobPerLvl < 0				;set to general maid data
			MaidBoobPerLvl = BoobPerLvl
		endif
		
		if BreastUpScale
			if BreastBase + BreastBaseMod < 1
				BreastBaseMod += 0.1
				MME_Storage.setBreastsBaseadjust(akActor, BreastBaseMod)
			endif
		endif
		
		if BreastBaseMod < 0 && BreastBase * -1 > BreastBaseMod
			BreastBaseMod = BreastBase * -1
		endif
		if BreastBase <= 0
			BreastBase = 0.01
		endif

		;MilkCnt = BreastBase - MilkCnt * MaidBoobIncr
		;if MilkCnt <= BreastBase
		;	MilkCnt = 0
		;endif

		CurrentSize = BreastBase + ( MilkCnt * MaidBoobIncr ) + ( MaidLevel + ( MaidTimesMilked / (( MaidLevel + 1 ) * TimesMilkedMult ))) * MaidBoobPerLvl
		;debug.notification("CurrentSize pre root = " + CurrentSize)
		;float x = 0.0
		if CurrentSize != BreastBase && BreastVolumeScale
			CurrentSize += 1 - BreastBase ; make sure base volume is 100% [1.00]
			float dx = 1.0
			float x = CurrentSize / 3.0
			
			while dx > 0.1
				dx = (CurrentSize / (x*x) - x) / 3.0
				x += dx
				if dx < 0.0
					dx = -dx
				endif
			endwhile
			CurrentSize = x*BreastBase ; BreastBase defines base volume
		endif

		;CurrentSize = BreastBase + x*(BreastBase+BreastBaseMod)
		;CurrentSize = BreastBase + BreastBaseMod + x
		CurrentSize += BreastBaseMod
		;debug.notification("CurrentSize = " + CurrentSize)
		;CurrentSize = (BreastBase+BreastBaseMod + CurrentSize)*(1+BreastBaseMod)
		if CurrentSize > BoobMAX && BoobMAX != 0
			CurrentSize = BoobMAX
		endif
		
		If(CurrentSize <= 1.0)
			CurveFix = 1.0
		Else
			CurveFix = 1.0 - (CurrentSize * BreastCurve)
			If CurveFix < BoobMAX / 10
				CurveFix = BoobMAX / 10
			EndIf
		EndIf
	Endif
	
	MME_BodyMod BodyMod = Quest.GetQuest("MME_MilkQUEST") as MME_BodyMod
	
	bool isFemale = false
	if akActor.GetLeveledActorBase().GetSex() == 1
		isFemale = true
	Else
		isFemale = false
	endif
	
	If BreastScale == 3
		;HDT Female / Vampire Lord
			BodyMod.RemoveNiONodeScale(akActor, "NPC L Breast", isFemale)
			BodyMod.RemoveNiONodeScale(akActor, "NPC R Breast", isFemale)
			
		;Curve fix
		;HDT Female / Vampire Lord
			BodyMod.RemoveNiONodeScale(akActor, "NPC L Breast01", isFemale)
			BodyMod.RemoveNiONodeScale(akActor, "NPC R Breast01", isFemale)

		;HDT Werewolf
			BodyMod.RemoveNiONodeScale(akActor, "NPC L Breast P1", isFemale)
			BodyMod.RemoveNiONodeScale(akActor, "NPC R Breast P1", isFemale)
			BodyMod.RemoveNiONodeScale(akActor, "NPC L Breast P2", isFemale)
			BodyMod.RemoveNiONodeScale(akActor, "NPC R Breast P2", isFemale)
			BodyMod.RemoveNiONodeScale(akActor, "NPC L Breast P3", isFemale)
			BodyMod.RemoveNiONodeScale(akActor, "NPC R Breast P3", isFemale)
		
	elseif CurrentSize > 0
		;HDT Female / Vampire Lord
			BodyMod.SetNodeScale(akActor, "NPC L Breast", CurrentSize, isFemale)
			BodyMod.SetNodeScale(akActor, "NPC R Breast", CurrentSize, isFemale)
			
		;Curve fix
		;HDT Female / Vampire Lord
			BodyMod.SetNodeScale(akActor, "NPC L Breast01", CurveFix, isFemale)
			BodyMod.SetNodeScale(akActor, "NPC R Breast01", CurveFix, isFemale)

		;HDT Werewolf
			BodyMod.SetNodeScale(akActor, "NPC L Breast P1", CurrentSize, isFemale)
			BodyMod.SetNodeScale(akActor, "NPC R Breast P1", CurrentSize, isFemale)
			BodyMod.SetNodeScale(akActor, "NPC L Breast P2", CurrentSize, isFemale)
			BodyMod.SetNodeScale(akActor, "NPC R Breast P2", CurrentSize, isFemale)
			BodyMod.SetNodeScale(akActor, "NPC L Breast P3", CurrentSize, isFemale)
			BodyMod.SetNodeScale(akActor, "NPC R Breast P3", CurrentSize, isFemale)
		
		;Schlong		this is for male/futa but i have no idea about scaling mechanic
		;NetImmerse.SetNodeScale(akActor, "NPC L GenitalsScrotum [LGenScrot]", CurrentSize, false)
		;NetImmerse.SetNodeScale(akActor, "NPC R GenitalsScrotum [RGenScrot]", CurrentSize, false)
		;FPS
		;NetImmerse.SetNodeScale(akActor, "NPC L GenitalsScrotum [LGenScrot]", CurrentSize, true)
		;NetImmerse.SetNodeScale(akActor, "NPC R GenitalsScrotum [RGenScrot]", CurrentSize, true)
	endif
	
	if BellyScale
		LactacidCnt = MME_Storage.getLactacidCurrent(akActor)
		BodyMod.SetNodeScale(akActor, "NPC Belly", 1 + LactacidCnt / 2, isFemale)
	else
		BodyMod.RemoveNiONodeScale(akActor, "NPC Belly", isFemale)
	endif
EndFunction

;----------------------------------------------------------------------------
;functions called by milking scripts
;----------------------------------------------------------------------------

Function MilkingToContainer(Actor akActor, int i, int Mode, int MilkingType, objectreference MilkBarrel = none)
	MilkingCycle(akActor, i, Mode, MilkingType, MilkBarrel)
EndFunction

Function Milking(Actor akActor, int i, int Mode, int MilkingType)
	MilkingCycle(akActor, i, Mode, MilkingType, none)
EndFunction

Function MilkingCycle(Actor akActor, int i, int Mode, int MilkingType, objectreference MilkBarrel = none)
	;Mode == 0 - Pump Milking
	;Mode == 1 - Other Milking(hands)
	;Mode == 2 - Equipment Milking
	;Mode == 3 - Forced Armor Milking(Spriggan/HM/LA)
	;Mode == 4 - Called by other mods, 
	;MilkingType == 0 normal/none milkpump
	;MilkingType == 1 bound/ disable player control
	;MilkingType == 2 bound/ disable player control, do not enable after milking done
	;MilkBarrel == container where milk should be stored after milking
	
	if akActor.HasSpell( BeingMilkedPassive )
		;if MilkingType != 1						;prevents msg spam from aidrivenplayer bound milkpump, since its activates script endlessly,
			Debug.notification(akActor.GetLeveledActorBase().GetName() + " already being milked, if something went wrong, remove Milking passive spell from Milk Maid debug menu")
		;endif
		return									; prevents multiple scripts running
	endif
	akActor.AddSpell( BeingMilkedPassive, false )	; prevents multiple scripts running, if removed, milking will stop
	StorageUtil.SetIntValue(akActor, "MME.MilkMaid.IsAnimating", 0)

	If !MilkBarrel
		ObjectReference defaultBarrel = StorageUtil.GetFormValue(akActor, "MME_MilkBarrel_Default") As ObjectReference
		If defaultBarrel
			MilkBarrel = defaultBarrel
		EndIf
	EndIf

	ObjectReference overrideBarrel = StorageUtil.GetFormValue(akActor, "MME_MilkBarrel_Override") As ObjectReference
	If overrideBarrel
		MilkBarrel = overrideBarrel
	EndIf
	
	Int soundInstance01
	Int pain = 1
	Int bottles = 0			;milked milk\times milked
	Int Expression
	Int armorcheckloop = 0
	Int boobgasmcount = 0
	Int cumcount = 0
	Int duration = 0
	Int mpas = 1
	Bool IsMilkMaid = false
	Bool IsMilkingBlocked = false
	Bool armf = false
	Bool FirstTimeStory = false
	Bool FeedOnce = true
	Bool IsFeedingBlocked = false
	Bool StopMilking = false
	Weapon weapR = akActor.GetEquippedWeapon()
	Weapon weapL = akActor.GetEquippedWeapon(True)
	Armor Shield = akActor.GetEquippedShield()
	Form maidArmor
	Form cuirass = akActor.GetWornForm(Armor.GetMaskForSlot(32))
	String CuirassName
	
	if cuirass != None
		CuirassName = cuirass.getname()
	endif
	;Devious Devices management
	Bool DDArmbinder = DDi.IsMilkingBlocked_Armbinder(akActor)
	Bool DDYoke = DDi.IsMilkingBlocked_Yoke(akActor)
	Bool DDSuit = DDi.IsMilkingBlocked_Suit(akActor)
	Bool DDBelt = DDi.IsWearingBelt(akActor)
	Bool DDBeltOpen = DDi.IsWearingBelt_Open(akActor)
	Bool DDGag = DDi.IsWearingGag(akActor)
	Bool DDGagOpen = DDi.IsWearingGag_Open(akActor)
	Bool DDBra = DDi.IsMilkingBlocked_Bra(akActor)
	Bool SLSDBra = SLSD.IsMilkingBlocked_Bra_SLSD(akActor)
	Bool hasInventoryMilkCuirass = false
	Bool hasInventoryMilkCuirassFuta = false
	Bool bControlsDisabled = false

	Bool ZaZGag = zbf.IsWearingZaZGag(akActor)
	Bool ZaZGagOpen = zbf.IsWearingZaZGag_Open(akActor)
	
	String akActorGender = akActorSex(akActor)
	String MaidName = akActor.GetLeveledActorBase().GetName()
	
	String anivar = ""						;custom animations by MME for DD belt
	String LastAnimation					;save last animation name to not run animation same twice in a row, causing instant disappearance and appearance of animated objects
	
	Float LactacidCnt = MME_Storage.getLactacidCurrent(akActor)
	Float LactacidMax = MME_Storage.getLactacidMaximum(akActor)
	Float MilkCnt = MME_Storage.getMilkCurrent(akActor)
	Float MilkMax = MME_Storage.getMilkMaximum(akActor)
	Int   MaidLevel = MME_Storage.getMaidLevel(akActor)
	Float PainCnt = MME_Storage.getPainCurrent(akActor)
	Float PainMax = MME_Storage.getPainMaximum(akActor)
	Float MaidTimesMilked = StorageUtil.GetFloatValue(akActor,"MME.MilkMaid.TimesMilked")
	Float TimesMilked = StorageUtil.GetFloatValue(none,"MME.Progression.TimesMilked")
	Float TimesMilkedAll = StorageUtil.GetFloatValue(none,"MME.Progression.TimesMilkedAll")
	Int BreastRows = MME_Storage.getBreastRows(akActor)

	if MILKmaid.find(akActor) != -1 || MILKSlave.find(akActor) != -1
		IsMilkMaid = true
	endif

;-----------------------Milking block check
	
	if PiercingCheck(akActor) == 2 && IsMilkingBlocked == false
		Debug.Notification("Nipple Plugs prevents milking")
		if mode > 0
			akActor.RemoveSpell( BeingMilkedPassive )
				if PlayerREF == akActor && MilkingType == 1
					Game.EnablePlayerControls() ;(True,True,True,True,True,True,True,True,0)
					Game.SetPlayerAIDriven(false)
				endif
			return
		else
			IsMilkingBlocked = true
		endif
	endif
	
	;check if bra prevents non milkump milking
	if Plugin_DDI && IsMilkingBlocked == false
		if DDi.IsWearingDDMilker(akActor) == false
			if DDBra == true && SLSDBra == false
				Debug.Notification("Chastity Bra prevents milking")
				if mode > 0 && SLSDBra == false
					if PlayerREF == akActor && MilkingType != 0
						Game.EnablePlayerControls() ;(True,True,True,True,True,True,True,True,0)
						Game.SetPlayerAIDriven(false)
					endif
					akActor.RemoveSpell( BeingMilkedPassive )
					return
				else
					IsMilkingBlocked = true
				endif
			endif
		endif
	endif
	
	if Mode != 0
		if Mode != 4
			if MilkingReq40PctMilk
				if akActor.HasSpell(MME_Spells_Buffs.GetAt(2) as Spell) && StopMilking != true
					StopMilking = true
					if MilkMsgs && PlayerREF == akActor
						debug.Notification("Your breasts are well-milked and need more milk before they can be milked again.")
					Endif
				Endif
			Endif
		Endif
	Endif

;-----------------------Milking mode selection
	
	if MaidTimesMilked == 0 && MaidLevel == 0
		FirstTimeStory = true
	endif

	if Mode == 0
		if Plugin_DDI
			if DDArmbinder == true || DDYoke == true || DDSuit == true
				if DDArmbinder == true
					Debug.Messagebox("Armbinder prevents using of the device")
				elseif DDYoke == true
					Debug.Messagebox("Yoke prevents using of the device")
				elseif DDSuit == true
					Debug.Messagebox("Bondage suit prevents using of the device")
				endif
				akActor.Setunconscious(false)
				if PlayerREF == akActor && MilkingType != 0
					Game.EnablePlayerControls() ;(True,True,True,True,True,True,True,True,0)
					Game.SetPlayerAIDriven(false)
				endif
				Debug.SendAnimationEvent(akActor,"IdleForceDefaultState")
				akActor.RemoveSpell( BeingMilkedPassive )
				return
			endif
		endif
		
		if Feeding 
			if (ZaZGag == true && ZaZGagOpen == false)
				IsFeedingBlocked = true
				Debug.Messagebox("Gag prevents feeding")
			elseif Plugin_DDI
				if (DDGag == true && DDGagOpen == false)
					IsFeedingBlocked = true
					Debug.Messagebox("Gag prevents feeding")
				endif
			endif
		endif
		
		if MilkingType != 0 && PlayerREF == akActor
			;Game.DisablePlayerControls(1, 1, 0, 0, 1, 1, 0) ;(True,True,False,False,True,True,True,True,0)
			Game.SetPlayerAIDriven(true)
			Game.DisablePlayerControls()
			bControlsDisabled = true
			if MilkMsgs
				debug.Notification("You feel Milk Pump secure your body, removing your ability to move.")
			endif
		endif
		
		while armorcheckloop < armname.Length && !armf && IsMilkingBlocked == false
			int armloop = 0
			while armloop <= 4 && !armf
				maidArmor = akActor.GetWornForm(Armor.GetMaskForSlot(armslot[armloop]))
				if maidArmor != None
					if StringUtil.Find(maidArmor.getname(), armname[armorcheckloop] ) >= 0
						Debug.Notification( maidArmor.getname() + " prevents milking")
						armf = true
						if mode > 0 
							akActor.RemoveSpell( BeingMilkedPassive )
							if PlayerREF == akActor && MilkingType != 0
								Game.EnablePlayerControls() ;(True,True,True,True,True,True,True,True,0)
								Game.SetPlayerAIDriven(false)
							endif
							return
						else
							IsMilkingBlocked = true
						endif
					endif
				endif
				armloop += 1
			endwhile
			armorcheckloop += 1
		endwhile
		
		while (akActor.GetSitState() < 3 && akActor.GetSitState() > 0)					;wait for actor to "sit" in furniture
			Utility.Wait( 1.0 )
		endwhile
		
		If IsMilkingBlocked == false && SLSDBra == false
			if (cuirass != None && (Sexlab.IsStrippable(cuirass) || MilkCuirass == cuirass)) || cuirass == None
				if BreastRows != 1
					;do nothing
				elseif cuirass != None && !(cuirass == TITS4 || cuirass == TITS6 || cuirass == TITS8)
					if !(cuirass == MilkCuirass || cuirass == MilkCuirassFuta)\
					&& !((StringUtil.Find(CuirassName, "Milk" ) >= 0) || (MilkingEquipment.find(CuirassName) >= 0))
						akActor.UnequipItem(cuirass, false, true)
					endif
					if MilkNaked == false
						if MilkWithZaZMoMSuctionCups == true
							akActor.additem(ZaZMoMSuctionCups, 1, true)
							akActor.equipitem(ZaZMoMSuctionCups, true, true)
						elseif !akActor.IsEquipped(cuirass)
							if akActorGender == "Futa" && UseFutaMilkCuirass == true
								akActor.additem(MilkCuirassFuta, 1, true)
								akActor.equipitem(MilkCuirassFuta, true, true)
							else
								akActor.additem(MilkCuirass, 1, true)
								akActor.equipitem(MilkCuirass, true, true)
							endif
						endif
					endif
				elseif MilkNaked == false
					if MilkWithZaZMoMSuctionCups == true
						akActor.additem(ZaZMoMSuctionCups, 1, true)
						akActor.equipitem(ZaZMoMSuctionCups, true, true)
					else
						if akActorGender == "Futa" && UseFutaMilkCuirass == true
							akActor.additem(MilkCuirassFuta, 1, true)
							akActor.equipitem(MilkCuirassFuta, true, true)
						else
							akActor.additem(MilkCuirass, 1, true)
							akActor.equipitem(MilkCuirass, true, true)
						endif
					endif
				endif
				
				If MilkStory && akActor == PlayerREF && (akActorGender != "Male" || (akActorGender == "Male" && MaleMaids))
					StoryDisplay("start","milkpump")
				EndIf
			EndIf
			;if weapR
			;	akActor.UnequipItem(weapR,False,True)
			;endif
			;if weapL
			;	akActor.UnequipItem(weapL,False,True)
			;endif
			;if Shield
			;	akActor.UnequipItem(Shield,False,True)
			;endif
		EndIf
	elseif mode == 4 || StopMilking
		;do nothing
	elseif MilkCnt < 1
		Debug.Notification(akActor.GetLeveledActorBase().GetName() + " have no milk!")
		akActor.RemoveSpell( BeingMilkedPassive )
		return
	else
		if cuirass != None && !(cuirass == TITS4 || cuirass == TITS6 || cuirass == TITS8)
			if BreastRows != 1
				Mode = 1
			ElseIf StringUtil.Find(CuirassName, "Milk" ) >= 0 \
			|| StringUtil.Find(CuirassName, "Cow" ) >= 0 \
			|| MilkingEquipment.find(CuirassName) >= 0 \
			|| SLSDBra == true \
			|| DDi.IsWearingDDMilker(akActor) == true
				Mode = 2
			ElseIf StringUtil.Find(CuirassName, "Spriggan" ) >= 0 \
				|| StringUtil.Find(CuirassName, "Living Arm" ) >= 0 \
				|| StringUtil.Find(CuirassName, "HM Priestess" ) >= 0 \
				|| StringUtil.Find(CuirassName, "Hermaeus Mora" ) >= 0 \
				|| BasicLivingArmor.find(CuirassName) >= 0 \
				|| ParasiteLivingArmor.find(CuirassName) >= 0
				Mode = 3
				int soundInstance02 = TakeHoldSound.Play(akActor)
				Utility.Wait( 5.0 )													;wait for possession sound to play
				If MilkStory && akActor == PlayerREF && (akActorGender != "Male" || (akActorGender == "Male" && MaleMaids))
					if StringUtil.Find(CuirassName, "Hermaeus Mora" ) >= 0 || StringUtil.Find(CuirassName, "HM Priestess" ) >= 0
						StoryDisplay("start","hermaeusmora")
					elseif StringUtil.Find(CuirassName, "Living Arm" ) >= 0
						StoryDisplay("start","livingarmor")
					else
						StoryDisplay("start","spriggan")
					endif
				Endif
				Sound.StopInstance( soundInstance02 )
			ElseIf (DDArmbinder == false && DDYoke == false) && Sexlab.IsStrippable(cuirass)
				If akActor.GetItemCount(MilkCuirassFuta) > 0 && akActorGender == "Futa" && UseFutaMilkCuirass == true
					akActor.equipitem(MilkCuirassFuta, true, true)
					hasInventoryMilkCuirassFuta = true
					Mode = 2
				ElseIf akActor.GetItemCount(MilkCuirass) > 0 && (akActorGender != "Futa" || UseFutaMilkCuirass != true)
					akActor.equipitem(MilkCuirass, true, true)
					hasInventoryMilkCuirass = true
					Mode = 2
				Else
					akActor.UnequipItem(cuirass, false, true)
				EndIf
			EndIf
		ElseIf SLSDBra == true\
			|| DDi.IsWearingDDMilker(akActor) == true
				Mode = 2
		ElseIf !(cuirass == TITS4 || cuirass == TITS6 || cuirass == TITS8)
			If (DDArmbinder == false && DDYoke == false)
				If akActor.GetItemCount(MilkCuirassFuta) > 0 && akActorGender == "Futa" && UseFutaMilkCuirass == true
					akActor.equipitem(MilkCuirassFuta, true, true)
					hasInventoryMilkCuirassFuta = true
					Mode = 2
				ElseIf akActor.GetItemCount(MilkCuirass) > 0 && (akActorGender != "Futa" || UseFutaMilkCuirass != true)
					akActor.equipitem(MilkCuirass, true, true)
					hasInventoryMilkCuirass = true
					Mode = 2
				EndIf
			EndIf
		EndIf
		
		If (DDArmbinder == false && DDYoke == false)
			If IsMilkingBlocked == false && !akActor.IsInCombat() && !akActor.IsOnMount()
				If mode != 4
					If MobileMilkingAnims
						If PlayerREF == akActor
							Game.ForceThirdPerson()
							Game.DisablePlayerControls(1, 1, 0, 0, 1, 1, 0) ;(True,True,False,False,True,True,True,True,0)
							Utility.Wait( 1.0 )												;wait for actor to stop moving (and player to release movement keys)
						EndIf
						If StorageUtil.GetIntValue(akActor,"IsBoundStrict") == 0
							;disable npc moving
							if Mode != 0 && PlayerREF != akActor
								akActor.Setunconscious(true)
							Endif
;							mpas = Utility.RandomInt (1, 3)
;							if mpas == 1
;								Debug.SendAnimationEvent(akActor,"ZaZAPCHorFA")
;							elseif mpas == 2
;								Debug.SendAnimationEvent(akActor,"ZaZAPCHorFB")
;							elseif mpas == 3
;								Debug.SendAnimationEvent(akActor,"ZaZAPCHorFC")
;							endif
							Debug.SendAnimationEvent(akActor,JsonUtil.StringListGet("/MME/Strings", "standingmilkinganimations", Utility.RandomInt(0, JsonUtil.StringListCount("/MME/Strings", "standingmilkinganimations") - 1)))
							StorageUtil.SetIntValue(akActor, "MME.MilkMaid.IsAnimating", 1)
						EndIf
					EndIf
				EndIf
			EndIf
		ElseIf Mode == 1
			If akActor == PlayerRef
				Debug.Notification("With your hands bound there is no way you can be milked without somebody's help")
			Else
				Debug.Notification("With hands bound there is no way " + akActor.GetLeveledActorBase().GetName() + " can be milked without somebody's help")
			EndIf
			IsMilkingBlocked = true
			akActor.RemoveSpell( BeingMilkedPassive )
			return
		EndIf
	endif
	
	if IsMilkMaid == false && PlayerREF.GetDistance(akActor) < 500	
		if MILKmaid.find(akActor) == -1								;recheck if player became milkmaid with milkcuirass, if milking naked option enabled we add player
			int ButtonPressed
			int count
			int C = 0
			
			While C+1 < MilkMaid.Length								;count taken maid slots
				C += 1
				If MilkMaid[C] != None
					count += 1
				EndIf
			EndWhile
			
			if akActor == PlayerREF || count < Milklvl0fix()
				if akActor != PlayerREF								;ask to make npc maid if player have empty maid slots
					ButtonPressed = (MakeMilkMaid).Show()
				EndIf
				
				if akActor == PlayerREF || ButtonPressed == 0		;make player/npc maid
					AssignSlot(akActor)
					
					if MILKmaid.find(akActor) != -1					;recheck player/npc
						IsMilkMaid = true
					endif
				endif
			endif
		else
			IsMilkMaid = true
		endif
	endif
	
	if Mode != 4
		;prevent other mods form interrupting milking
		SexLab.ForbidActor(akActor)
		akActor.AddToFaction(SexLab.AnimatingFaction)
		;Debug.Notification(akActor.GetLeveledActorBase().GetName() + " Set to " + SexLab.AnimatingFaction)
	Endif
	
	If PlayerREF == akActor
        SendModEvent("dhlp-Suspend")
	Endif
	
	if IsMilkMaid == false
		MilkCnt = Utility.RandomInt (1, 2)							;give milk for non maid/slave npc
		LactacidMax = 4
		if isPregnant(akActor)
			MilkCnt = MilkCnt * 2
		endif
	endif
		
	if DDBeltOpen == true					;animation without vaginal probe
		anivar += "_02"
	elseif DDBelt == true					;animation without anal plug, vaginal probe
		anivar += "_01"
	endif
	
	sendVibrationEvent("StartMilkingMachine", akActor, mpas, MilkingType)

;-----------------------Feeding/Milking/Fuck machine

		;run cycle if:
		;actor is sitting or trying to sit(milkmump)
		;or actor is being milked by something other than milkpump(mode 0) and has milk
		;and pain less than max or pain override enabled and not bound milking

	while ((akActor.GetSitState() <= 3 && akActor.GetSitState() > 0 && Mode == 0)\
			|| (MilkCnt >= 1 && Mode > 0 && !StopMilking))\
			&& ((PainCnt <= PainMax*0.9) || PainKills)\
			&& akActor.HasSpell(BeingMilkedPassive)

		;debug.Notification("cycle start")
		;select animation speed and 'enjoyment'
		
		if SLA.GetActorArousal(akActor) > 75
			mpas = 2
		else 
			mpas = 1
		endif
		SLA.UpdateActorExposure(akActor, mpas)

		;FEEDING STAGE

		if Mode == 0															;check if using milkpump
			if Feeding == true													;check if feeding enabled
				if !IsFeedingBlocked											;feeding not blocked by gags
					if (akActorGender != "Male" || (akActorGender == "Male" && MaleMaids))
						
							;check if not full of lactacid or (FeedOnce and ForcedFeeding) override enabled
							;(check if not bound milking and player or actor or actor storageutil has lactacid)		; this doesn't count if both actor and player have lactacid bottles but who cares, no one will ever find xD
							;or bound milking or actor is not maid/slave or actor is slave faction or FreeLactacid cheat enabled

						if (LactacidCnt < LactacidMax || (FeedOnce == true && ForcedFeeding))\
						&& ((MilkingType == 0 && (PlayerREF.GetItemCount(MME_Util_Potions.GetAt(0)) > 0 || akActor.GetItemCount(MME_Util_Potions.GetAt(0)) > 0 || StorageUtil.GetFloatValue(akActor,"MME.MilkMaid.MilkingContainerLactacid") >= 1))\
						|| MilkingType != 0 || akActor.IsInFaction(MilkSlaveFaction) || FreeLactacid == true || !IsMilkMaid)
							
							;debug.Notification("feeding cycle")
							akActor.AddSpell(FeedingStage, false)
							if Feeding_Sound == 0 || (Feeding_Sound == 1 && akActor == PlayerRef)				;check if Feeding_Sound enabled or enabled only for player
								soundInstance01 = FeedingSound.Play(akActor)
								Sound.SetInstanceVolume(soundInstance01, 1.0)
							endif
							
							;bound/unbound animation +: no anal/vaginal vairations
							if MilkingType == 0 && LastAnimation != "ZaZMOMFreeFurn_05"+anivar
								LastAnimation = "ZaZMOMFreeFurn_05"
								Debug.SendAnimationEvent(akActor, LastAnimation+anivar)
							elseif MilkingType != 0 && LastAnimation != "ZaZMOMBoundFurn_05"+anivar
								LastAnimation = "ZaZMOMBoundFurn_05"
								Debug.SendAnimationEvent(akActor, LastAnimation+anivar)
							endif
							
							sendVibrationEvent("FeedingStage", akActor, mpas, MilkingType)
							
							;if not maid/slave, skip and wait to simulate feeding
							if IsMilkMaid == true
								if MilkingType != 0 || FreeLactacid == true											;free lactacid for bound milking or cheat option
									akActor.EquipItem(MME_Util_Potions.GetAt(3), true, true)						;equip soundless lactacid feeding potion Thirst
									akActor.EquipItem(MME_Util_Potions.GetAt(4), true, true)						;equip soundless lactacid feeding potion Hunger
								elseif akActor.IsInFaction(MilkMaidFaction)											;actor is milkmaid
									
									;check there is lactacid in player or actor inventory or actor storageutil
									if (PlayerREF.GetItemCount(MME_Util_Potions.GetAt(0)) > 0 || akActor.GetItemCount(MME_Util_Potions.GetAt(0)) > 0 || StorageUtil.GetFloatValue(akActor,"MME.MilkMaid.MilkingContainerLactacid") >= 1)
										akActor.EquipItem(MME_Util_Potions.GetAt(3), true, true)					;Feed lactacid Thirst
										akActor.EquipItem(MME_Util_Potions.GetAt(4), true, true)					;Feed lactacid Hunger
										
										if MilkingType == 0															;if normal milking remove 1 lactacid from either actor storageutil, inventory, player inventory
											if StorageUtil.GetFloatValue(akActor,"MME.MilkMaid.MilkingContainerLactacid") >= 1 
												StorageUtil.AdjustFloatValue(akActor,"MME.MilkMaid.MilkingContainerLactacid", -1)
											elseif akActor.GetItemCount(MME_Util_Potions.GetAt(0)) > 0
												akActor.RemoveItem(MME_Util_Potions.GetAt(0))
											elseif PlayerREF.GetItemCount(MME_Util_Potions.GetAt(0)) > 0
												PlayerREF.RemoveItem(MME_Util_Potions.GetAt(0))
											endif
										endif
									endif
								elseif akActor.IsInFaction(MilkSlaveFaction)										;actor is milkslave, this goes after in case someone smart decides to add slave faction where it dont belong
									akActor.EquipItem(MME_Util_Potions.GetAt(3), true, true)						;Feed lactacid Thirst
									akActor.EquipItem(MME_Util_Potions.GetAt(4), true, true)						;Feed lactacid Hunger
								endif
								CurrentSize(akActor)																;update body/increase belly
								LactacidCnt = MME_Storage.getLactacidCurrent(akActor)								;update lactacid value from potions (+1)
							else
								LactacidCnt += 1 																	;add lactacid for non maid/slave npc
							endif
							
							Utility.Wait(Feeding_Duration)
							FeedOnce = false
							Sound.StopInstance(soundInstance01)	
						endif
					endif
				endif
			endif
		endif
		
		;MILKING STAGE
		
			;milking not blocked;
			;(actor has milk or (( if FuckMachine disabled or belted ) and (not milk maid/slave or using milkpump))
			;pain less than max or pain override enabled
			;milking is not stopped, when using hand milking and pain reach max

		if !akActor.HasSpell(FeedingStage)\
		&& IsMilkingBlocked == false\
		&& (akActorGender != "Male" || (akActorGender == "Male" && MaleMaids))\
		&& (MilkCnt >= 1 || ((FuckMachine == false || DDBelt == true) && Mode == 0))\
		&& ((PainCnt <= PainMax*0.9) || PainKills)\
		&& StopMilking == false

			;debug.Notification("milking cycle")
			akActor.AddSpell(MilkingStage, false)
			soundInstance01 = MilkSound.Play(akActor)
			Sound.SetInstanceVolume(soundInstance01, 1.0)
			
			;milkpump animation selector
			If Mode == 0
				if MilkingType == 0
					if mpas == 1 && LastAnimation != "ZaZMOMFreeFurn_11"+anivar
						LastAnimation = "ZaZMOMFreeFurn_11"
						Debug.SendAnimationEvent(akActor, LastAnimation+anivar)
					elseif mpas == 2 && LastAnimation != "ZaZMOMFreeFurn_12"+anivar
						LastAnimation = "ZaZMOMFreeFurn_12"
						Debug.SendAnimationEvent(akActor, LastAnimation+anivar)
					endif
				elseif MilkingType != 0
					if mpas == 1 && LastAnimation != "ZaZMOMBoundFurn_11"+anivar
						LastAnimation = "ZaZMOMBoundFurn_11"
						Debug.SendAnimationEvent(akActor, LastAnimation+anivar)
					elseif mpas == 2 && LastAnimation != "ZaZMOMBoundFurn_12"+anivar
						LastAnimation = "ZaZMOMBoundFurn_12"
						Debug.SendAnimationEvent(akActor, LastAnimation+anivar)
					endif
				endif
			Endif
			sendVibrationEvent("MilkingStage", akActor, mpas, MilkingType)
			
			while duration < Milking_Duration\
				&& ((akActor.GetSitState() <= 3 && akActor.GetSitState() > 0) || Mode != 0)\
				&& akActor.HasSpell(BeingMilkedPassive)
				
				;if DDGag == false || ZaZGag == false
					if 	PainCnt >= PainMax
						Expression = 4
						SexLab.PickVoice(akActor).Moan(akActor, Utility.RandomInt (70, 100), true)
					elseif 	PainCnt >= (PainMax/3*2) || ( Mode == 1 )
						Expression = Utility.RandomInt(2, 4)
						SexLab.PickVoice(akActor).Moan(akActor, Utility.RandomInt (30, 100), true)
					else
						Expression = Utility.RandomInt(1, 3)
						SexLab.PickVoice(akActor).Moan(akActor, Utility.RandomInt (30, 100), false)
					endif
				;else
				;	zbf.Main.PlayGagSound(akActor)
				;endif
				
				if DDGag == false || ZaZGagOpen == false
					if Expression == 1
						SexLab.GetExpressionByName("Happy").ApplyTo(akActor, Utility.RandomInt(30, 50))
					elseif Expression == 2
						SexLab.GetExpressionByName("Pleasure").ApplyTo(akActor, Utility.RandomInt(30, 100))
					elseif Expression == 3
						SexLab.GetExpressionByName("Joy").ApplyTo(akActor, Utility.RandomInt(30, 100))
					elseif Expression == 4
						SexLab.GetExpressionByName("Pained").ApplyTo(akActor, Utility.RandomInt(50, 70))
					endif
				endif

				if MilkingDrainsSP
					akActor.DamageActorValue("Stamina", 0.25 * akActor.GetBaseActorValue("Stamina"))
				endif
				if MilkingDrainsMP
					akActor.DamageActorValue("Magicka", 0.25 * akActor.GetBaseActorValue("Magicka"))
				endif
				Utility.Wait(1.0)
				duration += 1
			endwhile
			
			if !IsMilkMaid
				if MilkCnt >= 1
					bottles += 1
					MilkCnt -= 1
				endif
			else
				MilkCnt = MME_Storage.getMilkCurrent(akActor)
				int gush = (MilkCnt * GushPct/100) as int				;use int because we reduce milk by integer value
				
				if gush > MilkCnt
					gush = Math.Floor(MilkCnt)							;find lowest integer Math.Floor(5.9) == 5
				endif
				
				if gush < 1
					gush = 1
				endif

				if MilkCnt >= 1
					bottles += gush
					MilkCnt -= gush
					StorageUtil.AdjustFloatValue(akActor, "MME.MilkMaid.TimesMilked", gush)
					MaidLevelCheck(akActor)
					MME_Storage.setMilkCurrent(akActor, MilkCnt, BreastScaleLimit)
						; refetch to make sure we have the correct value (with applied max-limit)
						; (just to be sure to avoid any chance that there is MilkCnt>MilkMax because the maid
						;  generates more milk during a milking cycle then is being drained by milking)
					MilkCnt = MME_Storage.getMilkCurrent(akActor)
					CurrentSize(akActor)
					if PlayerREF.GetDistance(akActor) < 500 && MilkMsgs && MilkCntMsgs
						debug.Notification(MaidName + "'s remaining capacity: " + MilkCnt + ", Milked capacity: " + bottles)
					endif
					if mode == 1 || akActor.GetWornForm(Armor.GetMaskForSlot(32)) == (None || TITS4 || TITS6 || TITS8)
						AddMilkFx(akActor, 1)
						AddLeak(akActor)
					endif
				endif
				
				if StorageUtil.GetFloatValue(akActor, "MME.MilkMaid.MilkGen") == 0 
					if Utility.RandomInt(0, 100) < 15
						debug.Notification(MaidName + "'s breasts has started lactating.")
						StorageUtil.AdjustFloatValue(akActor, "MME.MilkMaid.MilkGen", MilkGenValue / 3 / 10 * gush)
					endif
				else
					StorageUtil.AdjustFloatValue(akActor, "MME.MilkMaid.MilkGen", MilkGenValue / 3 / 10 * gush)
				endif

				if PainSystem
					if mode > 1 																							;mobile milking pain x2
						Pain = Pain(akActor, pain) * 2
					else																									;milkpump/hands milking pain
						Pain = Pain(akActor, pain)
					endif
				endif

				PainCnt = MME_Storage.getPainCurrent(akActor)
				
				if MilkQC.Buffs && !akActor.HasSpell(MME_Spells_Buffs.GetAt(3) as Spell) 
					if mode == 1 && (PainCnt >= PainMax*0.8)
						StopMilking = true
					elseif (PainCnt >= PainMax*0.9)
						akActor.AddSpell( MME_Spells_Buffs.GetAt(3) as Spell, false )
					endif
				endif

				;if PainCnt >= PainMax && PainSystem && PainKills && MilkQC.Buffs											;change to apply stacking 1h debuff spell hp/sp/mp -5% or smthing like that
					;akActor.equipitem(MilkE.OverMilkingEff, true, true) 
					;akActor.DamageActorValue("Health", 0.5 * (akActor.GetBaseActorValue("Health") / pain))
				;endif
			Endif

		;FUCK MACHINE STAGE 

			;FuckMachine enabled
			;using milkpump
			;not belted
			;actor is sitting or trying to sit

		elseif !akActor.HasSpell(FeedingStage)\
		&& !akActor.HasSpell(MilkingStage)\
		&& FuckMachine == true\
		&& Mode == 0\
		&& DDBelt == false\
		&& (akActor.GetSitState() <= 3 && akActor.GetSitState() > 0)\
		&& akActor.HasSpell(BeingMilkedPassive)

			;debug.Notification("FuckMachine cycle")
			akActor.AddSpell(FuckMachineStage, false)
			soundInstance01 = MilkSound.Play(akActor)
			Sound.SetInstanceVolume(soundInstance01, 1.0)
			
			;milkpump animation selector
			If Mode == 0
				if MilkingType == 0
					if mpas == 1 && LastAnimation != "ZaZMOMFreeFurn_07"+anivar
						LastAnimation = "ZaZMOMFreeFurn_07"
						Debug.SendAnimationEvent(akActor, LastAnimation+anivar)
					elseif mpas == 2 && LastAnimation != "ZaZMOMFreeFurn_08"+anivar
						LastAnimation = "ZaZMOMFreeFurn_08"
						Debug.SendAnimationEvent(akActor, LastAnimation+anivar)
					endif
				elseif MilkingType != 0
					if mpas == 1 && LastAnimation != "ZaZMOMBoundFurn_07"+anivar
						LastAnimation = "ZaZMOMBoundFurn_07"
						Debug.SendAnimationEvent(akActor, LastAnimation+anivar)
					elseif mpas == 2 && LastAnimation != "ZaZMOMBoundFurn_08"+anivar
						LastAnimation = "ZaZMOMBoundFurn_08"
						Debug.SendAnimationEvent(akActor, LastAnimation+anivar)
					endif
				endif
			endif
			sendVibrationEvent("FuckMachineStage", akActor, mpas, MilkingType)
				
			while duration < FuckMachine_Duration\
				&& (akActor.GetSitState() <= 3 && akActor.GetSitState() > 0)\
				&& akActor.HasSpell(BeingMilkedPassive)
				
				;if DDGag == false || ZaZGag == false
					if 	PainCnt >= PainMax
						Expression = 4
						SexLab.PickVoice(akActor).Moan(akActor, Utility.RandomInt (70, 100), true)
					elseif 	PainCnt >= (PainMax/3*2) || ( Mode == 1 )
						Expression = Utility.RandomInt(2, 4)
						SexLab.PickVoice(akActor).Moan(akActor, Utility.RandomInt (30, 100), true)
					else
						Expression = Utility.RandomInt(1, 3)
						SexLab.PickVoice(akActor).Moan(akActor, Utility.RandomInt (30, 100), false)
					endif
				;else
				;	zbf.Main.PlayGagSound(akActor)
				;endif
				if DDGag == false || ZaZGag == false
					if Expression == 1
						SexLab.GetExpressionByName("Happy").ApplyTo(akActor, Utility.RandomInt(30, 50))
					elseif Expression == 2
						SexLab.GetExpressionByName("Pleasure").ApplyTo(akActor, Utility.RandomInt(30, 100))
					elseif Expression == 3
						SexLab.GetExpressionByName("Joy").ApplyTo(akActor, Utility.RandomInt(30, 100))
					elseif Expression == 4
						SexLab.GetExpressionByName("Pained").ApplyTo(akActor, Utility.RandomInt(50, 70))
					endif
				endif

				if MilkingDrainsSP
					akActor.DamageActorValue("Stamina", 0.25 * akActor.GetBaseActorValue("Stamina"))
				endif
				if MilkingDrainsMP
					akActor.DamageActorValue("Magicka", 0.25 * akActor.GetBaseActorValue("Magicka"))
				endif
				Utility.Wait(1.0)
				duration += 1
			endwhile
		endif

		;Cycle wrap-up

		if SLA.GetActorArousal(akActor) > 98 && (akActor.HasSpell(MilkingStage) || akActor.HasSpell(FuckMachineStage))
			if ((akActor.GetSitState() <= 3 && akActor.GetSitState() > 0) || Mode != 0)
				Int exposureValue = ((((bottles + 1) / (MilkCnt + bottles + 1)) * 3 * -20.0)/(1+SLA.GetActorExposureRate(akActor)/3)) as Int
				if PlayerREF.GetDistance(akActor) < 500 && MilkMsgs 
					if akActor.HasSpell(MilkingStage)
						Debug.Notification(formatString(JsonUtil.GetStringValue("/MME/Stories", "MilkingBoobgasm"), MaidName))
					elseif akActor.HasSpell(FuckMachineStage)
						Debug.Notification(formatString(JsonUtil.GetStringValue("/MME/Stories", "MilkingOrgasm"), MaidName))
					endif
				endif
				if akActor == PlayerREF && Game.GetCameraState() != 3
					Game.ShakeCamera(none, Utility.RandomFloat(0.5 , 1), 5)
				endIf
				SexLab.PickVoice(akActor).Moan(akActor, Utility.RandomInt (70, 100), false)
				if akActor == PlayerREF
					SendModEvent("PlayerOrgasmStart")
					Utility.Wait(5.0)
					SendModEvent("PlayerOrgasmEnd")
				endIf
				SLA.UpdateActorOrgasmDate(akActor)
				SLA.UpdateActorExposure(akActor, exposureValue)
				cumcount += 1
			endif

			if akActor.HasSpell(MilkingStage)
				PainCnt *= 0.8
				if IsMilkMaid == true
					AddLeak(akActor)
					MME_Storage.setPainCurrent(akActor, PainCnt)
				endif
				boobgasmcount += 1
			elseif akActor.HasSpell(FuckMachineStage)
				PainCnt *= 0.95
				if IsMilkMaid == true
					MME_Storage.setPainCurrent(akActor, PainCnt)
				endif
			endif
		endif

		if IsMilkMaid == true
			MilkCnt = MME_Storage.getMilkCurrent(akActor)
			LactacidCnt = MME_Storage.getLactacidCurrent(akActor)
			MaidLevel = MME_Storage.getMaidLevel(akActor)
		endif
		
			;milkump mode
			;bound mode
			;did we disable pc controls b4?
		if PlayerREF == akActor\
		&& mode == 0\
		&& MilkingType == 1\
		&& !akActor.HasSpell(FeedingStage)\
		&& bControlsDisabled == true\
		&& (MilkCnt < 1 || (PainCnt >= PainMax*0.9 && !PainKills))
			if PlayerREF == akActor && bControlsDisabled == true 
				Game.EnablePlayerControls() ;(True,True,True,True,True,True,True,True,0)
				Game.SetPlayerAIDriven(false)
				bControlsDisabled = false
			endif
			if akActor.IsUnconscious()
				akActor.Setunconscious(false)
			endif
			if MilkMsgs 
				Debug.Notification(formatString(JsonUtil.GetStringValue("/MME/Stories", "MilkingBoundDone"), MaidName))
			endif
		endif

		if akActor.HasSpell(FeedingStage)
			akActor.RemoveSpell( FeedingStage )
		endif
		if akActor.HasSpell(MilkingStage)
			akActor.RemoveSpell( MilkingStage )
		endif
		if akActor.HasSpell(FuckMachineStage)
			akActor.RemoveSpell( FuckMachineStage )
		endif
		duration = 0
		Sound.StopInstance(soundInstance01)	
		SexLab.ClearMFG(akActor)
	endwhile

	;debug.Notification("milking done." +akActorGender+ " "+isPregnant(akActor))
	sendVibrationEvent("StopMilkingMachine", akActor, mpas, MilkingType)

;-----------------------Milking done

	If PlayerREF == akActor && mode != 4
		Game.EnablePlayerControls() ;(True,True,True,True,True,True,True,True,0)
		Game.SetPlayerAIDriven(false)
	Endif
	StorageUtil.SetIntValue(akActor, "MME.MilkMaid.IsAnimating", 0)
	;justincase
	akActor.Setunconscious(false)
	
	while !akActor.GetSitState() == 0					;wait for actor to get off milking pump
		Utility.Wait( 1.0 )
	endwhile
	
	if IsMilkingBlocked == false
		if Mode == 0
			if BreastRows == 1
				if akActor.IsEquipped(ZaZMoMSuctionCups)
					akActor.UnequipItem(ZaZMoMSuctionCups, false, true)
					akActor.RemoveItem(ZaZMoMSuctionCups, 1, true)
				elseif akActor.IsEquipped(MilkCuirass) && MilkCuirass != cuirass
					akActor.UnequipItem(MilkCuirass, false, true)
					akActor.RemoveItem(MilkCuirass, 1, true)
				elseif akActor.IsEquipped(MilkCuirassFuta) && MilkCuirassFuta != cuirass
					akActor.UnequipItem(MilkCuirassFuta, false, true)
					akActor.RemoveItem(MilkCuirassFuta, 1, true)
				endif
			endif
			If cuirass != None && (Sexlab.IsStrippable(cuirass) || MilkCuirass == cuirass)
				akActor.equipitem(cuirass, false, true)
			EndIf
			If MilkStory && akActor == PlayerREF && (akActorGender != "Male" || (akActorGender == "Male" && MaleMaids))
				StoryDisplay("end","milkpump")
			EndIf
			;if weapR
			;	akActor.EquipItem(weapR,False,True)
			;endif
			;if weapL
			;	akActor.EquipItem(weapL,False,True)
			;endif
			;if Shield
			;	akActor.EquipItem(Shield,False,True)
			;endif
		elseif Mode == 3
			If MilkStory && akActor == PlayerREF && (akActorGender != "Male" || (akActorGender == "Male" && MaleMaids))
				if StringUtil.Find(CuirassName, "Hermaeus Mora" ) >= 0 || StringUtil.Find(CuirassName, "HM Priestess" ) >= 0
					StoryDisplay("end","hermaeusmora")
				elseif StringUtil.Find(CuirassName, "Living Arm" ) >= 0
					StoryDisplay("end","livingarmor")
				else
					StoryDisplay("end","spriggan")
				endif
			EndIf
		else
			If BreastRows == 1
				Utility.Wait(1)
				if akActor.IsEquipped(MilkCuirass) && MilkCuirass != cuirass
					akActor.UnequipItem(MilkCuirass, false, true)
				elseif akActor.IsEquipped(MilkCuirassFuta) && MilkCuirassFuta != cuirass
					akActor.UnequipItem(MilkCuirassFuta, false, true)
				EndIf
				if cuirass != None && (Sexlab.IsStrippable(cuirass) || MilkCuirass == cuirass)
					akActor.equipitem(cuirass, false, true)
				EndIf
			endif
		endif
		
		If Mode != 4
			Utility.Wait(1)
			Debug.SendAnimationEvent(akActor,"IdleForceDefaultState")
		endif
		
		;debug.Notification(Mode + " Mode.")
		if bottles > 0
			if IsMilkMaid == true
				LevelCheck()
				PostMilk(akActor)
				AddMilkFx(akActor, 2)
				AddLeak(akActor)
				
				if MILKSlave.find(akActor) == -1
					StorageUtil.AdjustFloatValue(none, "MME.Progression.TimesMilked", bottles)
					StorageUtil.AdjustFloatValue(none, "MME.Progression.TimesMilkedAll", bottles)
				endif
				
				if MilkBarrel == none
					if Mode == 0 || Mode == 2
						if Mode == 0 && MilkingType != 0 && !FreeLactacid == true ; && MilkE.GetMarketIndexFromLocation(akActor.GetCurrentLocation()) == 4
							bottles = bottles / 2 
							boobgasmcount = boobgasmcount / 2 
						endif
						if MILKSlave.find(akActor) != -1
							StorageUtil.AdjustFloatValue(akActor, "MME.MilkMaid.MilkingContainerMilksSUM", bottles)
						elseif StorageUtil.GetIntValue(akActor, "MME.MilkMaid.IsSlave") == 1
							StorageUtil.AdjustFloatValue(akActor, "MME.MilkMaid.MilkingContainerMilksSUM", bottles)
							debug.Notification(bottles + " Milk added to container.")
						elseif CuirassSellsMilk == true																			;old, sells milk through milkpump or with cuirass
							MilkE.InitiateTrade(bottles + StorageUtil.GetFloatValue(akActor,"MME.MilkMaid.MilkingContainerMilksSUM") as int, boobgasmcount, akActor, false)
							StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.MilkingContainerMilksSUM", 0)
						else																									;new, gives milk to actor
							MilkE.InitiateTrade(bottles + StorageUtil.GetFloatValue(akActor,"MME.MilkMaid.MilkingContainerMilksSUM") as int, boobgasmcount, akActor, true)
							StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.MilkingContainerMilksSUM", 0)
						endif
					endif
				else
					MilkE.InitiateTradeToContainer(bottles + StorageUtil.GetFloatValue(akActor,"MME.MilkMaid.MilkingContainerMilksSUM") as int, boobgasmcount, akActor, MilkBarrel)
					StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.MilkingContainerMilksSUM", 0)
				endif
			else
				if MilkBarrel == none
					MilkE.InitiateTrade(bottles + StorageUtil.GetFloatValue(akActor,"MME.MilkMaid.MilkingContainerMilksSUM") as int, boobgasmcount, akActor, true)
				else
					MilkE.InitiateTradeToContainer(bottles + StorageUtil.GetFloatValue(akActor,"MME.MilkMaid.MilkingContainerMilksSUM") as int, boobgasmcount, akActor, MilkBarrel)
				endif
			endif
		endif
			
		if cumcount > 0 && CumProduction && !(isSuccubus(akActor) || isVampire(akActor))
			if Mode == 0 || Mode == 2
				if IsMilkMaid == true && (StorageUtil.GetIntValue(akActor, "MME.MilkMaid.IsSlave") == 1 || MILKSlave.find(akActor) != -1)
					StorageUtil.AdjustFloatValue(akActor, "MME.MilkMaid.MilkingContainerCumsSUM", cumcount)
				elseif Mode == 0 || Mode == 2
					int cumtype1
					int cumtype1count
					int cumtype2
					int cumtype2count
					
					if akActorGender == "Male" 
						cumtype1 = 1
						cumtype1count = cumcount + StorageUtil.GetFloatValue(akActor,"MME.MilkMaid.MilkingContainerCumsSUM") as int
					elseif akActorGender == "Female" 
						cumtype1 = 0
						cumtype1count = cumcount + StorageUtil.GetFloatValue(akActor,"MME.MilkMaid.MilkingContainerCumsSUM") as int
					elseif akActorGender == "Futa"
						int futamilk = Utility.RandomInt(0, cumcount + StorageUtil.GetFloatValue(akActor,"MME.MilkMaid.MilkingContainerCumsSUM") as int)
						cumtype1 = 3
						cumtype1count = futamilk
						cumtype2 = 2
						cumtype2count = cumcount + StorageUtil.GetFloatValue(akActor,"MME.MilkMaid.MilkingContainerCumsSUM") as int - futamilk
					endif
					
					if MilkBarrel == none
						MilkBarrel = akActor
						if IsMilkMaid == true
							PlayerREF.RemoveItem(MilkE.Gold, (cumcount + StorageUtil.GetFloatValue(akActor,"MME.MilkMaid.MilkingContainerCumsSUM") as int)*2, true)
							StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.MilkingContainerCumsSUM", 0)
						endIf
					endIf
					
					MilkBarrel.AddItem(MME_Cums.GetAt(cumtype1), cumtype1count)
					MilkBarrel.AddItem(MME_Cums.GetAt(cumtype2), cumtype2count)
				endif
			endif
		endif
	endif
	
	if Mode == 3 && MilkQC.Buffs && IsMilkMaid == true
		akActor.AddSpell( MME_Spells_Buffs.GetAt(3) as Spell, false )
		akActor.AddSpell( MME_Spells_Buffs.GetAt(4) as Spell, false )
	endif

	if akActor.HasSpell( BeingMilkedPassive )
		akActor.RemoveSpell( BeingMilkedPassive )
	endif

	if Mode != 4
		;allow other mods to animate actor
		SexLab.AllowActor(akActor)
		akActor.RemoveFromFaction(SexLab.AnimatingFaction)
	Endif
	
	int handle = ModEvent.Create("MME_MilkingDone")
	if (handle)
		ModEvent.PushForm(handle, akActor)
		ModEvent.PushInt(handle, bottles)
		ModEvent.PushInt(handle, boobgasmcount)
		ModEvent.PushInt(handle, cumcount)
		ModEvent.Send(handle)
	endif
	
	If PlayerREF == akActor
        SendModEvent("dhlp-Resume")
	Endif
EndFunction

Function PostMilk(Actor akActor)
	Float MilkCnt = MME_Storage.getMilkCurrent(akActor)
	Float MilkMax = MME_Storage.getMilkMaximum(akActor)
	int numEffects
    int effectCount
	;Spell Unmilked_Spell = Game.GetFormFromFile(0xD7B, "milkmodnew.esp") as Spell
	;Spell Wellmilked_Spell = Game.GetFormFromFile(0x39F87, "milkmodnew.esp") as Spell
	;Spell Breasts_Spell = Game.GetFormFromFile(0x7D36A, "milkmodnew.esp") as Spell
	Float BreastsSize_Node = MME_Storage.getBreastNodeScale(akActor)
	Float BreastRows = MME_Storage.getBreastRows(akActor)
	
	if MilkQC.Buffs != true
		if akActor.HasSpell(MME_Spells_Buffs.GetAt(3) as Spell)
			akActor.RemoveSpell(MME_Spells_Buffs.GetAt(3) as Spell)
		endif
		if akActor.HasSpell(MME_Spells_Buffs.GetAt(4) as Spell)
			akActor.RemoveSpell(MME_Spells_Buffs.GetAt(4) as Spell)
		endif
		if akActor.HasSpell(MME_Spells_Buffs.GetAt(1) as Spell)
			akActor.RemoveSpell(MME_Spells_Buffs.GetAt(1) as Spell)
		endif
		if akActor.HasSpell(MME_Spells_Buffs.GetAt(2) as Spell)
			akActor.RemoveSpell(MME_Spells_Buffs.GetAt(2) as Spell)
		endif
		if akActor.HasSpell(MME_Spells_Buffs.GetAt(0) as Spell)
			akActor.RemoveSpell(MME_Spells_Buffs.GetAt(0) as Spell)
		endif
	else
		;Unmilked debuff
		numEffects = (MME_Spells_Buffs.GetAt(1) as Spell).GetNumEffects()
		effectCount = 0
		while (effectCount < numEffects)
			(MME_Spells_Buffs.GetAt(1) as Spell).SetNthEffectMagnitude(effectCount, MilkCnt as int)
			effectCount= effectCount + 1
		endwhile
		
		;Wellmilked buff
		numEffects = (MME_Spells_Buffs.GetAt(2) as Spell).GetNumEffects()
		effectCount = 0
		while (effectCount < numEffects)
			(MME_Spells_Buffs.GetAt(2) as Spell).SetNthEffectMagnitude(effectCount, ((MilkMax-MilkCnt)*BreastsSize_Node) as int)
			effectCount = effectCount + 1
		endwhile
	
		;breassize debuff 7D36A
		numEffects = (MME_Spells_Buffs.GetAt(0) as Spell).GetNumEffects()
		effectCount = 0
		while (effectCount < numEffects)
			(MME_Spells_Buffs.GetAt(0) as Spell).SetNthEffectMagnitude(effectCount, BreastRows * Math.pow( 2, BreastsSize_Node) * (1+ akActor.GetLeveledActorBase().GetWeight()/100))
			effectCount = effectCount + 1
		endwhile
		
		;remove spells
		if akActor.HasSpell(MME_Spells_Buffs.GetAt(1) as Spell)
			akActor.RemoveSpell(MME_Spells_Buffs.GetAt(1) as Spell)
		endif
		if akActor.HasSpell(MME_Spells_Buffs.GetAt(2) as Spell)
			akActor.RemoveSpell(MME_Spells_Buffs.GetAt(2) as Spell)
		endif
		if akActor.HasSpell(MME_Spells_Buffs.GetAt(0) as Spell)
			akActor.RemoveSpell(MME_Spells_Buffs.GetAt(0) as Spell)
		endif
		
		;re-add spells
		akActor.AddSpell(MME_Spells_Buffs.GetAt(0) as Spell, false)

		if MilkCnt / MilkMax <= 0.4
			akActor.AddSpell(MME_Spells_Buffs.GetAt(2) as Spell, false)
		elseif MilkCnt / MilkMax >= 0.6
			akActor.AddSpell(MME_Spells_Buffs.GetAt(1) as Spell, false)
			if akActor == PlayerRef && MilkMsgs
				debug.Notification("Your breasts are getting heavy from all the milk sloshing inside.")
			endif	
		endif
		
	endif
	
EndFunction

Function LevelCheck()   ; mastery progression levelup messages
	Float TimesMilked = StorageUtil.GetFloatValue(none, "MME.Progression.TimesMilked")
	Float Level = StorageUtil.GetFloatValue(none, "MME.Progression.Level")
	
	If Level < 40
		If TimesMilked >= (Level + 1) * TimesMilkedMult
			StorageUtil.AdjustFloatValue(none,"MME.Progression.Level", 1)
			StorageUtil.SetFloatValue(none,"MME.Progression.TimesMilked", 0)
			if MilkMsgs
				debug.Notification(JsonUtil.StringListGet("/MME/Strings_Lvlup", "masterylevelup", 0))
				debug.messagebox(JsonUtil.StringListGet("/MME/Strings_Lvlup", "masterylevelup", Level as int + 1))
			endif
		EndIf
	EndIf
EndFunction

Function MaidLevelCheck(Actor akActor)   ; maid progression levelup messages
	Float MaidTimesMilked = StorageUtil.GetFloatValue(akActor, "MME.MilkMaid.TimesMilked")
	Int   MaidLevel = MME_Storage.getMaidLevel(akActor)
	
	if (MaidLevel < MilkLvlCap || !MaidLvlCap)
		if MaidLevel != 0 || MME_Storage.getLactacidCurrent(akActor) > 0
			if MaidTimesMilked >= (MaidLevel + 1) * TimesMilkedMult
				MME_Storage.setMaidLevel(akActor, MaidLevel + 1)
				StorageUtil.AdjustFloatValue(akActor, "MME.MilkMaid.TimesMilked", - (MaidLevel + 1) * TimesMilkedMult)
				if MilkMsgs && MaidLevel + 1 <= MilkLvlCap
					String MaidName = akActor.GetLeveledActorBase().GetName()
					debug.Notification(formatString(JsonUtil.StringListGet("/MME/Strings_Lvlup", "maidlevelup", 0), MaidName))
					If Game.Getplayer().GetDistance(akActor) < 500
						debug.messagebox(formatString(JsonUtil.StringListGet("/MME/Strings_Lvlup", "maidlevelup", MaidLevel as int + 1), MaidName, MaidName))
					endif
				endif
			endif
		endif
	endif
	MME_Storage.updateMilkMaximum(akActor)
EndFunction

;----------------------------------------------------------------------------
;Messages breast size /level up
;----------------------------------------------------------------------------

Function MilkCycleMSG(Actor akActor)
	Int MilkCnt = Math.Floor(MME_Storage.getMilkCurrent(akActor))
	Float MilkMax = MME_Storage.getMilkMaximum(akActor)
	Int MilkStageStrings = JsonUtil.StringListCount("/MME/Strings_Milkstage", "milkstage") - 1

	If PlayerREF.GetDistance(akActor) < 500 && (MilkCnt as int) >= 1
		String MaidName = akActor.GetLeveledActorBase().GetName()
		if MilkCnt >= MilkMax && PiercingCheck(akActor) != 2
			debug.Notification(formatString(JsonUtil.StringListGet("/MME/Strings_Milkstage", "milkstage", MilkStageStrings), MaidName))
		elseif MilkCnt == (MilkMax - 1)
			debug.Notification(formatString(JsonUtil.StringListGet("/MME/Strings_Milkstage", "milkstage", MilkStageStrings - 1), MaidName))
		elseif MilkCnt == (MilkMax - 2)
			debug.Notification(formatString(JsonUtil.StringListGet("/MME/Strings_Milkstage", "milkstage", MilkStageStrings - 2), MaidName))
		else
			debug.Notification(formatString(JsonUtil.StringListGet("/MME/Strings_Milkstage", "milkstage", MilkCnt), MaidName))
		endif
	EndIf
EndFunction

Function Strings_setup()
	debug.Trace("MilkModEconomy breast strings array resetting")

	MilkMsgStage = new String[23]
	MilkMsgStage[1] = " breasts feel a bit warm as they tingle."
	MilkMsgStage[2] = " breasts feel quite warm."
	MilkMsgStage[3] = " breasts feel very warm and a bit uncomfortable."
	MilkMsgStage[4] = " breasts are starting to perk up."
	MilkMsgStage[5] = " breasts have become a bit more firm and perky."
	MilkMsgStage[6] = " breasts have become quite firm, the nipples feel very tender."
	MilkMsgStage[7] = " breasts have become very firm, the nipples feel very sensitive."
	MilkMsgStage[8] = " breasts feel slightly heavy."
	MilkMsgStage[9] = " breasts have become heavier, the trend is quite alarming."
	MilkMsgStage[10] = " breasts have become noticeably heavier."
	MilkMsgStage[11] = " breasts feel heavy and full, perhaps it is time to seek release."
	MilkMsgStage[12] = " breasts are demanding release! They're beginning to feel painful."
	MilkMsgStage[13] = " breasts have reached their natural limit, and scream for release."
	MilkMsgStage[14] = " breasts have begun to expand to accommodate the additional milk"
	MilkMsgStage[15] = " breasts have expanded beyond their natural limit."
	MilkMsgStage[16] = " breasts have now become even larger."
	MilkMsgStage[17] = " breasts continue to expand, with no end in sight."
	MilkMsgStage[18] = " breasts are starting to block the view of the lower body."
	MilkMsgStage[19] = " breasts have obscured the lower body, but continue to expand."
	MilkMsgStage[20] = " breasts are swollen with milk."
	MilkMsgStage[21] = " breasts are starting to impair movement."
	MilkMsgStage[22] = " breasts have expanded to their absolute limit."
	
	debug.Trace("MilkModEconomy armor strings array resetting")
	armname = new string[10]
	armname[0] = "Chastity Bra"
	armname[1] = "Spriggan Armor"
	armname[2] = "Spriggan Host"
	armname[3] = "Dwemer milking device"
	armname[4] = "Cow Harness"
	armname[5] = "Living Arm"
	armname[6] = "Hermaeus Mora"
	armname[7] = "HM Priestess"
	armname[8] = "Tentacle Parasite"
	armname[9] = "Tentacle Armor"
		
;slots check // DD items locked through scripts/keywords
	debug.Trace("MilkModEconomy armorslots array resetting")
	armslot = new int[6]
	armslot[0] = 32	;32 - body
	armslot[1] = 45	;45 - harness
	armslot[2] = 49	;49 - harness
	armslot[3] = 56	;56 - bra
	armslot[4] = 58	;58 - collar?,- locked milk cuirass slstorries
	
;Economy
	MilkE.MilkEconMaintenance()
EndFunction

Function MilkMsgHyper(int t, Actor akActor)
	MilkMsgHyper = new String[11]
		String MaidName = akActor.GetLeveledActorBase().GetName()
		MilkMsgHyper[1] = "As a result of a series of repeated vigorous milkings, " + MaidName + "'s breasts have grown accustomed to the great demand for their precious nectar and have grown bigger in size increasing their capacity! \n [Milk Maid Level: 1]"
		MilkMsgHyper[2] = "Due to repeated vigorous milkings, " + MaidName + "'s beautiful boobs are adjusting to the great demand for their precious nectar and have grown bigger in size increasing their capacity even further! \n [Milk Maid Level: 2]"
		MilkMsgHyper[3] = "The repeated vigorous milkings are conditioning " + MaidName + "'s glorious globes to meet the great demand for their precious nectar. They have grown bigger in size increasing their already impressive capacity even further! \n [Milk Maid Level: 3]"
		MilkMsgHyper[4] = "Repeated vigorous milkings have trained " + MaidName + "'s marvellous milk melons to meet the great demand for their precious nectar. They have grown bigger in size increasing their already amazing capacity even further! \n [Milk Maid Level: 4]"
		MilkMsgHyper[5] = MaidName + "'s looking forward to these vigorous milkings. Her breasts have grown accustomed to the great demand for their luscious lactation and have grown bigger in size increasing their inhuman capacity even further! \n [Milk Maid Level: 5]"
		MilkMsgHyper[6] = MaidName + "'s already ample breasts are adjusting to the demand for their precious nectar due to the repeated vigorous milkings. They have grown in size and capacity again! " + MaidName + " enjoys being milked! \n [Milk Maid Level: 6]"
		MilkMsgHyper[7] = "Due to the regular, vigorous milkings, " + MaidName + "'s breasts have grown even larger and their capacity has increased. Their now bountiful breasts will work to meet the demand for their tasty milk. \n [Milk Maid Level: 7]"
		MilkMsgHyper[8] = MaidName + " enjoys the repeated and vigorous milking. her breasts continue to grow to meet the demand for their rich nectar. Her now Gigantic Jugs can supply more milk and she enjoys it when people notice her breast size! \n [Milk Maid Level: 8]"
		MilkMsgHyper[9] = "These regular, vigorous milking sessions turn your milkmaid's on! They now have Tremendous Tits with increased size and capacity. Their delicious milk is in demand and they feel sexy when they hear comments about their boobs. \n [Milk Maid Level: 9]"
		MilkMsgHyper[10] = MaidName + " is now a Master of the Milkmaids with MASSIVE Mammaries! She can supply more milk than an entire herd of cows. And those tits of theirs are the talk of Tamriel. \n [Master Milk Maid]"
	debug.messagebox(MilkMsgHyper[t])
EndFunction

;----------------------------------------------------------------------------
;Stories
;----------------------------------------------------------------------------

Function StoryDisplay(String StoryState , String StoryType)
	int i
	i = Utility.RandomInt(1, JsonUtil.StringListCount("/MME/Strings_Stories", StoryType + StoryState) - 1)
	
	if StoryType == "milkpump"					;Milkpump only milking story
		if (StoryState == "start" && StorageUtil.GetStringValue(Game.Getplayer(), "MME.FirstTimeStoryStart", True) != True)
			;not a 1st time story
		elseif (StoryState == "end" && StorageUtil.GetStringValue(Game.Getplayer(), "MME.FirstTimeStoryEnd", True) != True)
			;not a 1st time story
		else
			;1st time story
			;remove 1st time story flag
			i = 0
			if StoryState == "start"
				StorageUtil.SetStringValue(Game.Getplayer(), "MME.FirstTimeStoryStart", False)
			else
				StorageUtil.SetStringValue(Game.Getplayer(), "MME.FirstTimeStoryEnd", False)
			endif
		endif
	endif
	;sexlab.log("--")
	;sexlab.log("StoryType " + StoryType + ", StoryState " + StoryState)
	;sexlab.log("StringListCount " + JsonUtil.StringListCount("/MME/Strings_Stories", StoryType + StoryState))
	;sexlab.log("StoryType + StoryState " + StoryType+StoryState)
	;sexlab.log("i " + i)
	;sexlab.log("--")
	debug.messagebox(formatString(JsonUtil.StringListGet("/MME/Strings_Stories", StoryType + StoryState, i), Game.Getplayer().GetLeveledActorBase().GetName()))
EndFunction

; Function StoryDisplay(int StoryState , int StoryMode, bool FirstTimeStory)
	;StoryState == 0 - start, 1 - end
	; int i

	; if FirstTimeStory
		; i = 0
	; else
		; i = 1
	; endif

	; if StoryMode == 1					;Milkpump milking
		; i = Utility.RandomInt(1, 5) * i
		; If StoryState == 0
			; StoryMPS(i)
		; Elseif StoryState == 1
			; StoryMPE(i)
		; EndIf
		
	; Elseif StoryMode == 2 				;Spriggan milking
		; i = Utility.RandomInt(1, 3)
		; If StoryState == 0
			; StorySS(i)
		; Elseif StoryState == 1
			; StorySE(i)
		; EndIf
		
	; Elseif StoryMode == 3				;Hermaeus Mora milking
		; i = Utility.RandomInt(1, 2)
		; If StoryState == 0
			; StoryHMS(i)
		; Elseif StoryState == 1
			; StoryHME(i)
		; EndIf
		
	; Elseif StoryMode == 4				;Living armor milking
		; i = Utility.RandomInt(1, 3)
		; If StoryState == 0
			; StoryLAS(i)
		; Elseif StoryState == 1
			; StoryLAE(i)
		; EndIf
	; endif

	; debug.messagebox(Story[i])
; EndFunction

Function StoryMPS(int i)
	Story = new String[6]
	Story[0] = "Out of curiosity you jump into strange device, nothing bad can happen, right? Suddenly, you start to feel tingles over your skin, scared you try to get out of the device but you can move a finger. Desperate, you see tube appear, moving towards your mouth and forcing itself in, few moments later you feel same happens with your intimate parts. Paralyzed you see some fluids flowing through tubes."
	Story[1] = "As you approach the strange device, your milky nipples grow hard and ready of their own volition, eagerly anticipating the opportunity to get milked. You easily fit yourself into the apparatus, hearing the machinery activate automatically as if sensing your breast's full capacity. The cups twitch and move heavily as they raise to your bountiful chest, ready to milk you."
	Story[2] = "As you take a seat on the strange device, your aching nipples grow hard and ready of their own volition, eagerly anticipating the opportunity to release their milky load. You easily fit yourself into the apparatus, hearing the machinery activate automatically. The cups twitch and move as they raise to your full chest, ready to relieve you of your delicious milky burden."
	Story[3] = "You begin holding the breast-milking cups against your forward jutting nipples and with a sudden lurch the suction pulls against you, pressing the cups tightly against your chest, stretching your nubs to nearly twice their normal length. You feel a building pressure as the machine sucks you relentlessly, drawing your milk to the surface. Your body lets down its milk, flooding the tubes with creamy goodness. "
	Story[4] = "You eagerly grab onto the suction cups, pulling them up to your tight and full chest. They latch on, slapping tight against you as the vacuum pressure seals them tightly against your body. You can feel your milk-slicked nipples pulling tight, nearly doubling in size from the intense pressure. The sensitive flesh of your motherly tits fill with a burgeoning pressure that centers around the tubes connected to your nips. Your lactating nubs twitch and pulse for but a moment, then unleash a torrent of milk, totally filling the tubes."
	Story[5] = "You approach the strange device and take a seat. The suckers immediately seal themselves against your breasts and activate, assaulting your nipples with a strong, rhythmic sucking sensation. It's uncomfortable - almost painful, in fact, but the sensation of being milked, brings about a strange, tingling feeling of arousal that washes over your whole being. As you look down to your breasts, you find yourself fantasizing your breasts as heaving boulders of supple flesh, filled with creamy, nutritive milk and maternal purpose. The daydream is oddly erotic, and your thighs begin rubbing against each other of their own accord."
EndFunction

Function StoryMPE(int i)
	Story = new String[6]
	Story[0] = "After minutes of torment, tubes retract into the unknown, as you feel strange magic fades, you try to escape horrible device as fast as you can, though it's not easy for your abused body, filled with unknown liquid."
	Story[1] = "The cups pulse with a strong consistency, milking you HARD and draining you of your reservoir of milk. Your nipples ache with the strange pleasure of it, leaving you moaning and wriggling against your restraints, desperate for release, but you just can't get the stimulation you need. Time stretches on as you're teased like that, pumped of your milk until the machinery shuts off and you wobbly raise to your feet, your milky residue still running down your breasts."
	Story[2] = "The machinery lurches, struggling to keep up as you flood the tubes with your creamy bounty. A motherly sense of pride wells within you as you hear the apparatus wind down and indicate it's fullness with a ding; the people of Skyrim will be getting their fill tonight. Even more, you can't wait to continue to satisfy their thirst when it's time to be milked again."
	Story[3] = "You feel woozy and light-headed from the intense milking, and have difficulty focusing on anything but the residue of fluids coating your milky tits. Feeling sore and exhausted, you make yourself decent and stagger away from the machinery with a satisfied smile on your face."
	Story[4] = "You practically cream yourself from the cup's actions as the milking continues, so hot and horny that you try and wriggle in your harness to press against them. After what seems like hours of non-stop sucking and spurting, your milking is over, and the cups release themselves from your drained breasts. You rise and steady yourself on wobbly knees, eager to experience being milked again."
	Story[5] = "Eventually, the milker's action becomes too much for your reddened nipples, and with a slight grimace you deactivate the milker. As you alleviate your tender bosom, you find that the odd tingling sensation is still lingering in your bosom, along with the vision of your breasts swelling with milk."
EndFunction

Function StorySS(int i)
	Story = new String[4]
	Story[0] = "Here could be your story"
	Story[1] = "The spriggan's root-like tendrils stretch across your swollen breasts, forming tight knots where milk is starting to seep from your nipples. The rough bark of its fingers digs into your flesh, as it starts to massage your breasts, coaxing your milk to the surface."
	Story[2] = "The spriggan's tendrils knot around your milky nipples, then take hold almost painfully hard. You gasp in a mixture of pain and relief, as your milk lets down."
	Story[3] = "The spriggan stirs and suddenly you feel its tendrils rhythmically squeezing your breasts and pulling at your nipples. Pain and pleasure mix as you are forced to meet its demand for your milk."
EndFunction

Function StorySE(int i)
	Story = new String[4]
	Story[0] = "Here could be your story"
	Story[1] = "Your whole body throbs in time with the pulse of milk from your nipples, and a strange euphoria courses through you. But your breasts are nearly drained, and the milking comes to an end. The spriggan seems to be satisfied, for now."
	Story[2] = "You squirm within the spriggan's tight embrace, as it wrings the last few drops from your drained breasts. The spriggan seems to want more, but there is none to be had."
	Story[3] = "The spriggan's tendrils pull harder and faster briefly, and then they begin to relax as every drop of milk is absorbed. You know that it will need to feed again, but when?"
EndFunction

Function StoryHMS(int i)
	Story = new String[3]
	Story[0] = "Here could be your story"
	Story[1] = "The tentacles are reaching for your breasts. The suckers melt with your body. You nearly faint in Hermaeus' presence, feeling his caress, becoming one with his parasite. You feel milk gushing out, ravenous imbibed by the tentacles."
	Story[2] = "A dark voice pounds in your head: '" + PlayerRef.GetLeveledActorBase().GetName() + ", my favourite mind milker. Let me see what knowledge you acquired for me.' The tentacles caress your breast, dig deep into them, you feel them inside your trembling body, reaching your head, your mind..."
EndFunction

Function StoryHME(int i)
	Story = new String[3]
	Story[0] = "Here could be your story"
	Story[1] = "The tentacles relax as the penetration on your tits suddenly stops. You can not say if you feel dizzy, relieved or euphoric. But you are happy you have given Hermaeus this sacrifice. And you're eagerly awaiting his next demand."
	Story[2] = "'Well done my pet.' are his last words before he releases your spirit from its prison and gives you control over your body again. You feel ice cold sweat on your skin. Your legs are shaking. 'Thank you master.' whisper from your lips"
EndFunction

Function StoryLAS(int i)
	Story = new String[4]
	Story[0] = "Here could be your story"
	Story[1] = "The tentacles are reaching for your breasts. The suckers latch on to your body. You nearly faint in anticipation, feeling their caress, and you know what is coming. You feel your milk gushing out, ravenously imbibed by the tentacles."
	Story[2] = "The armor's tentacles coil around your milky nipples, then the suckers take hold almost painfully hard. You gasp in a mixture of pain and relief, as your milk lets down. The tentacles pulse and pull as they milk you."
	Story[3] = "Your armor suddenly tightens around you. Tentacles wrap around your swollen breasts as suckers find the nipples and latch on. Your knees nearly buckle as the writhing mass squeezes and massages your breasts. Your milk begins to flow as the suckers do their work."
EndFunction

Function StoryLAE(int i)
	Story = new String[4]
	Story[0] = "Here could be your story"
	Story[1] = "The tentacles relax as the suction on your tits suddenly stops. You can not say if you feel dizzy, relieved or euphoric. But you are happy you have given the armor what it needs. And you're eagerly awaiting its next feeding."
	Story[2] = "You squirm within the tentacles' tight embrace, as they wring the last few drops from your breasts. The armor seems to want more, but it relaxes its hold... for now."
	Story[3] = "The tentacles squeeze harder and faster as the suckers pull every drop of milk they can get and then as suddenly as it began, the armor relaxes its grip. You've been relieved of your milky burden for now. And you know you'll need to satisfy its hunger again.... but when?"
EndFunction

;----------------------------------------------------------------------------
;Utility
;----------------------------------------------------------------------------
String Function formatString(String src, String part1 = "", String part2 = "", String part3 = "", String part4 = "", String part5 = "")
	;Debug.Messagebox("json source: " + src)
	int pos1 = StringUtil.find(src, "%text1")
	if pos1 == 0
		src = StringUtil.substring("", 0, pos1) + part1 + StringUtil.substring(src, pos1+6)
	elseif pos1 != -1
		src = StringUtil.substring(src, 0, pos1) + part1 + StringUtil.substring(src, pos1+6)
	endIf

	int pos2 = StringUtil.find(src, "%text2")
	if pos2 != -1
		src = StringUtil.substring(src, 0, pos2) + part2 + StringUtil.substring(src, pos2+6)
	endIf
	
	int pos3 = StringUtil.find(src, "%text3")
	if pos3 != -1
		src = StringUtil.substring(src, 0, pos3) + part3 + StringUtil.substring(src, pos3+6)
	endIf
	
	int pos4 = StringUtil.find(src, "%text4")
	if pos4 != -1
		src = StringUtil.substring(src, 0, pos4) + part4 + StringUtil.substring(src, pos4+6)
	endIf
	
	int pos5 = StringUtil.find(src, "%text5")
	if pos5 != -1
		src = StringUtil.substring(src, 0, pos5) + part5 + StringUtil.substring(src, pos5+6)
	endIf
	
	return src
EndFunction

Function MultiBreastChange(Actor akActor)
	Float BreastRows = MME_Storage.getBreastRows(akActor)
	Form cuirass = akActor.GetWornForm(Armor.GetMaskForSlot(32))
	String akActorName = akActor.GetLeveledActorBase().GetName()
	String CuirassName
	
	if !akActor.IsInFaction(MilkSlaveFaction) && !akActor.IsInFaction(MilkMaidFaction)
		if cuirass == TITS4\ 
		|| cuirass == TITS6\
		|| cuirass == TITS8
			debug.Trace("MilkModEconomy MultiBreastChange() "+akActorName+" is not maid/slave and has multi breast, removing")
			akActor.RemoveItem(cuirass, 1, true)
		endif
		debug.Trace("MilkModEconomy MultiBreastChange() "+akActorName+" is not maid/slave exiting")
		return
	endif
	
	if BreastRows < 1
		debug.Trace("MilkModEconomy MultiBreastChange() "+akActorName+" BreastRows < 1, resetting to 1")
		BreastRows = 1
		StorageUtil.SetFloatValue(akActor,"MME.MilkMaid.BreastRows", 1)
	endif
	
	if BreastRows > 4
		debug.Trace("MilkModEconomy MultiBreastChange() "+akActorName+" BreastRows > 4, resetting to 4")
		BreastRows = 4
		StorageUtil.SetFloatValue(akActor,"MME.MilkMaid.BreastRows", 4)
	endif
	
	if (cuirass == TITS4 && BreastRows != 2)\ 
	|| (cuirass == TITS6 && BreastRows != 3)\
	|| (cuirass == TITS8 && BreastRows != 4)
		akActor.RemoveItem(cuirass, 1, true)
	elseif cuirass != none
		akActor.UnEquipItem(cuirass)
	endif
	
	if BreastRows == 2
		akActor.EquipItem(TITS4,true,true)
	elseif BreastRows == 3
		akActor.EquipItem(TITS6,true,true)
	elseif BreastRows == 4
		akActor.EquipItem(TITS8,true,true)
	endif
	MME_Storage.updateMilkMaximum(akActor)
EndFunction

Function DLCcheck()
	debug.Trace("MilkModEconomy DLC check")
	If Game.GetModbyName("HearthFires.esm") != 255
		debug.Trace("MilkModEconomy HearthFires.esm found")
		Plugin_HearthFires = true
		MilkE.locHeljarchenHall = Game.GetFormFromFile(0x520a, "HearthFires.esm") as Location
		MilkE.locWindstadManor = Game.GetFormFromFile(0x5209, "HearthFires.esm") as Location
		MilkE.locLakeviewManor = Game.GetFormFromFile(0x308a, "HearthFires.esm") as Location
	else
		debug.Trace("MilkModEconomy HearthFires.esm not found")
		Plugin_HearthFires = false
		MilkE.locHeljarchenHall = MilkE.locMMEEmpty
		MilkE.locWindstadManor = MilkE.locMMEEmpty
		MilkE.locLakeviewManor = MilkE.locMMEEmpty
	endif
	
	If Game.GetModbyName("Dawnguard.esm") != 255
		debug.Trace("MilkModEconomy Dawnguard.esm found")
		Plugin_Dawnguard = true
		MilkE.locFortDawnguard = Game.GetFormFromFile(0x128fe, "Dawnguard.esm") as Location
		MilkE.locDayspringCanyon = Game.GetFormFromFile(0x4c1f, "Dawnguard.esm") as Location
	else
		debug.Trace("MilkModEconomy Dawnguard.esm not found")
		Plugin_Dawnguard = false
		MilkE.locFortDawnguard = MilkE.locMMEEmpty
		MilkE.locDayspringCanyon = MilkE.locMMEEmpty
	endif

	If Game.GetModbyName("Dragonborn.esm") != 255
		debug.Trace("MilkModEconomy Dragonborn.esm found")
		Plugin_Dragonborn = true
		MilkE.locRavenRock = Game.GetFormFromFile(0x143b9, "Dragonborn.esm") as Location
		MilkE.locSkaalVillage = Game.GetFormFromFile(0x143bb, "Dragonborn.esm") as Location
		MilkE.locTelMithryn = Game.GetFormFromFile(0x143bc, "Dragonborn.esm") as Location
	else
		debug.Trace("MilkModEconomy Dragonborn.esm not found")
		Plugin_Dragonborn = false
		MilkE.locRavenRock = MilkE.locMMEEmpty
		MilkE.locSkaalVillage = MilkE.locMMEEmpty
		MilkE.locTelMithryn = MilkE.locMMEEmpty
	endif

	If Game.GetModbyName("RealisticNeedsandDiseases.esp") != 255
		debug.Trace("MilkModEconomy RealisticNeedsandDiseases.esp found")
		Plugin_RealisticNeedsandDiseases = true
	else
		debug.Trace("MilkModEconomy RealisticNeedsandDiseases.esp not found")
		Plugin_RealisticNeedsandDiseases = false
	endif

	If Game.GetModbyName("iNeed.esp") != 255
		debug.Trace("MilkModEconomy iNeed.esp found")
		Plugin_iNeed = true
	else
		debug.Trace("MilkModEconomy iNeed.esp not found")
		Plugin_iNeed = false
	endif
	
	If Game.GetModbyName("SexLabSkoomaWhore.esp") != 255
		debug.Trace("MilkModEconomy SexLabSkoomaWhore.esp found")
		Plugin_SlSW = true
	else
		debug.Trace("MilkModEconomy SexLabSkoomaWhore.esp not found")
		Plugin_SlSW = false
	endif
	
	If Game.GetModbyName("Schlongs of Skyrim.esp") != 255
		debug.Trace("MilkModEconomy Schlongs of Skyrim.esp found")
		Plugin_SOS = true
	else
		debug.Trace("MilkModEconomy Schlongs of Skyrim.esp not found")
		Plugin_SOS = false
	endif
	
	If Game.GetModbyName("SOS Equipable Schlong.esp") != 255
		debug.Trace("MilkModEconomy SOS Equipable Schlong.esp found")
		Plugin_SOS_EQUIP = true
	else
		debug.Trace("MilkModEconomy SOS Equipable Schlong.esp not found")
		Plugin_SOS_EQUIP = false
	endif
	
	If Game.GetModbyName("SOS - B3lisario UNP Addon.esp") != 255
		debug.Trace("MilkModEconomy SOS - B3lisario UNP Addon.esp found")
		Plugin_SOS_UNP = true
	else
		debug.Trace("MilkModEconomy SOS - B3lisario UNP Addon.esp not found")
		Plugin_SOS_UNP = false
	endif
	
	If Game.GetModbyName("SOS Female Schlongifier (No Schlong Addon by Erundil).esp") != 255
		debug.Trace("MilkModEconomy SOS - SOS Female Schlongifier (No Schlong Addon by Erundil).esp found")
		Plugin_SOS_NSA = true
	else
		debug.Trace("MilkModEconomy SOS - SOS Female Schlongifier (No Schlong Addon by Erundil).esp not found")
		Plugin_SOS_NSA = false
	endif
	
	If Game.GetModbyName("SOS - Pubic Hair for Females Addon.esp") != 255
		debug.Trace("MilkModEconomy SOS - SOS - Pubic Hair for Females Addon.esp found")
		Plugin_SOS_PUBES = true
	else
		debug.Trace("MilkModEconomy SOS - SOS Female Schlongifier (No Schlong Addon by Erundil).esp not found")
		Plugin_SOS_PUBES = false
	endif

	If Game.GetModbyName("EstrusChaurus.esp") != 255
		debug.Trace("MilkModEconomy EstrusChaurus.esp found")
		Plugin_EstrusChaurus = true
	else
		debug.Trace("MilkModEconomy EstrusChaurus.esp not found")
		Plugin_EstrusChaurus = false
	endif
	
	If Game.GetModbyName("EstrusSpider.esp") != 255
		debug.Trace("MilkModEconomy EstrusSpider.esp found")
		Plugin_EstrusSpider = true
	else
		debug.Trace("MilkModEconomy EstrusSpider.esp not found")
		Plugin_EstrusSpider = false
	endif
	
	If Game.GetModbyName("EstrusDwemer.esp") != 255
		debug.Trace("MilkModEconomy EstrusDwemer.esp found")
		Plugin_EstrusDwemer = true
	else
		debug.Trace("MilkModEconomy EstrusDwemer.esp not found")
		Plugin_EstrusDwemer = false
	endif
	
	If Game.GetModbyName("BeeingFemale.esm") != 255
		debug.Trace("MilkModEconomy BeeingFemale.esm found")
		Plugin_BeeingFemale = true
	else
		debug.Trace("MilkModEconomy BeeingFemale.esm not found")
		Plugin_BeeingFemale = false
	endif
	
	If Game.GetModbyName("FertilityMode.esp") != 255
		debug.Trace("MilkModEconomy FertilityMode.esp found")
		Plugin_FertilityMode = true
	else
		debug.Trace("MilkModEconomy FertilityMode.esp not found")
		Plugin_FertilityMode = false
	endif
	
	If Game.GetModbyName("Fertility Mode.esp") != 255
		debug.Trace("MilkModEconomy Fertility Mode.esp found")
		Plugin_FertilityMode2 = true
	else
		debug.Trace("MilkModEconomy Fertility Mode.esp not found")
		Plugin_FertilityMode2 = false
	endif
	
	If Game.GetModbyName("Fertility Mode.esm") != 255
		debug.Trace("MilkModEconomy Fertility Mode.esm found")
		Plugin_FertilityMode3 = true
	else
		debug.Trace("MilkModEconomy Fertility Mode.esm not found")
		Plugin_FertilityMode3 = false
	endif
	
	If Game.GetModbyName("HentaiPregnancy.esm") != 255
		debug.Trace("MilkModEconomy HentaiPregnancy.esm found")
		Plugin_HentaiPregnancy = true
	else
		debug.Trace("MilkModEconomy HentaiPregnancy.esm not found")
		Plugin_HentaiPregnancy = false
	endif
	
	If Game.GetModbyName("SexLabProcreation.esp") != 255
		debug.Trace("MilkModEconomy SexLabProcreation.esp found")
		Plugin_SexLabProcreation = true
	else
		debug.Trace("MilkModEconomy SexLabProcreation.esp not found")
		Plugin_SexLabProcreation = false
	endif
	
	If Game.GetModbyName("PSQ PlayerSuccubusQuest.esm") != 255
		debug.Trace("MilkModEconomy PlayerSuccubusQuest.esm found")
		Plugin_PSQ = true
	else
		debug.Trace("MilkModEconomy PlayerSuccubusQuest.esm not found")
		Plugin_PSQ = false
	endif
	
	If Game.GetModbyName("Devious Devices - Integration.esm") != 255
		debug.Trace("MilkModEconomy Devious Devices - Integration.esm found")
		Plugin_DDI = true
	else
		debug.Trace("MilkModEconomy Devious Devices - Integration.esm not found")
		Plugin_DDI = false
	endif
	
	If Game.GetModbyName("SexLab-StoriesDevious.esp") != 255
		debug.Trace("MilkModEconomy SexLab-StoriesDevious.esp found")
		Plugin_SLSD = true
	else
		debug.Trace("MilkModEconomy SexLab-StoriesDevious.esp not found")
		Plugin_SLSD = false
	endif
	
	If Game.GetModbyName("SexLabAroused.esm") != 255
		debug.Trace("MilkModEconomy SexLabAroused.esm found")
		Plugin_SLA = true
	else
		debug.Trace("MilkModEconomy SexLabAroused.esm not found")
		Plugin_SLA = false
	endif
	
	;(another)user stupidity check(loadorder)
	Int MM = Game.GetModbyName("MilkModNew.esp")
	Int MMHF = Game.GetModbyName("MilkModNEW HF.esp")
	Int MMZAZ = Game.GetModbyName("MilkModNEW ZaZ.esp")
	Int MMS = Game.GetModbyName("MilkModNEW Sanbox.esp")
	
	If (MMHF != 255 && MM > MMHF)\
	|| (MMZAZ != 255 && MM > MMZAZ)\
	|| (MMS != 255 && MM > MMS)
		Debug.MessageBox("MME incorrect load order: patches should go after main mod")
	endif
	
	Int MMMP = Game.GetModbyName("MilkMod_MilkPumpsBasic.esp")
	Int MMMPB = Game.GetModbyName("MilkMod_MilkPumpsBasicB.esp")
	Int MMMPNB = Game.GetModbyName("MilkMod_MilkPumpsBasicNB.esp")
	Int MMMPF = Game.GetModbyName("MilkMod_MilkPumpsFancy.esp")
	Int MMMPFB = Game.GetModbyName("MilkMod_MilkPumpsFancyB.esp")
	Int MMMPFNB = Game.GetModbyName("MilkMod_MilkPumpsFancyNB.esp")
	
	If (MMMP != 255 && MM > MMMP)\
	|| (MMMPB != 255 && MM > MMMPB)\
	|| (MMMPNB != 255 && MM > MMMPNB)\
	|| (MMMPF != 255 && MM > MMMPF)\
	|| (MMMPFB != 255 && MM > MMMPFB)\
	|| (MMMPFNB != 255 && MM > MMMPFNB)
		Debug.MessageBox("MME incorrect load order: milkpumps should go after main mod")
	endif
	
	If (MMMP != 255 && MMS < MMMP)\
	|| (MMMPB != 255 && MMS < MMMPB)\
	|| (MMMPNB != 255 && MMS < MMMPNB)\
	|| (MMMPF != 255 && MMS < MMMPF)\
	|| (MMMPFB != 255 && MMS < MMMPFB)\
	|| (MMMPFNB != 255 && MMS < MMMPFNB)
		Debug.MessageBox("MME incorrect load order: sandbox patch should go after milkpumps")
	endif
	debug.Trace("MilkModEconomy DCL check done")
	MMEfoodlistaddon()
	SlSWfoodlistaddon()
	ineed.iNeedfoodlistaddon()
EndFunction

int Function Milklvl0fix()
	int milklvl = ((StorageUtil.GetFloatValue(none,"MME.Progression.Level") + 1) / 2) as int
	;Debug.notification(milklvl) 		;0.5 => int 0
	If milklvl < 1
		return 1
	Else
		return milklvl
	EndIf
EndFunction

string Function ReduceFloat(String ReduceFloat)
	string temp = ""
	int t = 0
	while t < StringUtil.Find(ReduceFloat, ".") + 3 
		temp += StringUtil.getNthChar(ReduceFloat, t)
		t += 1
	endwhile
	return temp
EndFunction

Function MMEfoodlistaddon()
	debug.Trace("MilkModEconomy adding MME Leveled lists to base Leveled lists")
	int i
	int t = 0
	
	i = 0
	while i < LItemFoodInnCommon.GetNumForms() && LItemFoodInnCommon.GetNthForm(i) != MME_LItemFoodInnCommonMilk
		i += 1
	endwhile
	
	;add basic/simple non lactacid milk to vendors
	if LItemFoodInnCommon.GetNthForm(i) != MME_LItemFoodInnCommonMilk
		;Reset MME LL
		MME_LItemFoodInnCommonMilk.Revert()
		;Build MME LL (100% spawn)

		;add generic milk
		MME_LItemFoodInnCommonMilk.AddForm(MME_Milk_Basic.GetAt(0), 1, 1)
		MME_LItemFoodInnCommonMilk.AddForm(MME_Milk_Basic.GetAt(1), 1, 1)
		MME_LItemFoodInnCommonMilk.AddForm(MME_Milk_Basic.GetAt(2), 1, 1)
		MME_LItemFoodInnCommonMilk.AddForm(MME_Milk_Basic.GetAt(3), 1, 1)
		
		;add simple milk
		MME_LItemFoodInnCommonMilk.AddForm(MME_Milk_Altmer_Normal.GetAt(t), 1, 1)
		MME_LItemFoodInnCommonMilk.AddForm(MME_Milk_Argonian_Normal.GetAt(t), 1, 1)
		MME_LItemFoodInnCommonMilk.AddForm(MME_Milk_Bosmer_Normal.GetAt(t), 1, 1)
		MME_LItemFoodInnCommonMilk.AddForm(MME_Milk_Breton_Normal.GetAt(t), 1, 1)
		MME_LItemFoodInnCommonMilk.AddForm(MME_Milk_Dunmer_Normal.GetAt(t), 1, 1)
		MME_LItemFoodInnCommonMilk.AddForm(MME_Milk_Imperial_Normal.GetAt(t), 1, 1)
		MME_LItemFoodInnCommonMilk.AddForm(MME_Milk_Khajiit_Normal.GetAt(t), 1, 1)
		MME_LItemFoodInnCommonMilk.AddForm(MME_Milk_Nord_Normal.GetAt(t), 1, 1)
		MME_LItemFoodInnCommonMilk.AddForm(MME_Milk_Orc_Normal.GetAt(t), 1, 1)
		MME_LItemFoodInnCommonMilk.AddForm(MME_Milk_Redguard_Normal.GetAt(t), 1, 1)

		;Add MME LL to game list (100% spawn)
		LItemFoodInnCommon.AddForm(MME_LItemFoodInnCommonMilk, 1, 1)
		debug.Trace("MilkModEconomy adding MME_LItemFoodInnCommonMilk list to LItemFoodInnCommon")
	EndIf
	
	i = 0
	while i < LootCitizenDrinkList75.GetNumForms() && LootCitizenDrinkList75.GetNthForm(i) != MME_LootCitizenDrinkList75
		i += 1
	endwhile
	
	;add basic/simple non lactacid milk to Npcs/Citizens
	if LootCitizenDrinkList75.GetNthForm(i) != MME_LootCitizenDrinkList75
		;Reset MME LL
		MME_LootCitizenDrinkList75.Revert()
		;Build MME LL (100% spawn)

		;add generic milk
		MME_LootCitizenDrinkList75.AddForm(MME_Milk_Basic.GetAt(0), 1, 1)
		MME_LootCitizenDrinkList75.AddForm(MME_Milk_Basic.GetAt(1), 1, 1)
		MME_LootCitizenDrinkList75.AddForm(MME_Milk_Basic.GetAt(2), 1, 1)
		MME_LootCitizenDrinkList75.AddForm(MME_Milk_Basic.GetAt(3), 1, 1)
		
		;add simple milk
		MME_LootCitizenDrinkList75.AddForm(MME_Milk_Altmer_Normal.GetAt(t), 1, 1)
		MME_LootCitizenDrinkList75.AddForm(MME_Milk_Argonian_Normal.GetAt(t), 1, 1)
		MME_LootCitizenDrinkList75.AddForm(MME_Milk_Bosmer_Normal.GetAt(t), 1, 1)
		MME_LootCitizenDrinkList75.AddForm(MME_Milk_Breton_Normal.GetAt(t), 1, 1)
		MME_LootCitizenDrinkList75.AddForm(MME_Milk_Dunmer_Normal.GetAt(t), 1, 1)
		MME_LootCitizenDrinkList75.AddForm(MME_Milk_Imperial_Normal.GetAt(t), 1, 1)
		MME_LootCitizenDrinkList75.AddForm(MME_Milk_Khajiit_Normal.GetAt(t), 1, 1)
		MME_LootCitizenDrinkList75.AddForm(MME_Milk_Nord_Normal.GetAt(t), 1, 1)
		MME_LootCitizenDrinkList75.AddForm(MME_Milk_Orc_Normal.GetAt(t), 1, 1)
		MME_LootCitizenDrinkList75.AddForm(MME_Milk_Redguard_Normal.GetAt(t), 1, 1)

		;Add MME LL to game list (75% spawn)
		LootCitizenDrinkList75.AddForm(MME_LootCitizenDrinkList75, 1, 1)
		debug.Trace("MilkModEconomy adding MME_LootCitizenDrinkList75 list to LootCitizenDrinkList75")
	EndIf

	i = 0
	while i < LItemApothecaryIngredienstUncommon75.GetNumForms() && LItemApothecaryIngredienstUncommon75.GetNthForm(i) != MME_LItemApothecaryIngredienstUncommon75
		i += 1
	endwhile
	
	;add special milk with lactacid to alchemists?
	if LItemApothecaryIngredienstUncommon75.GetNthForm(i) != MME_LItemApothecaryIngredienstUncommon75
		;Reset MME LL
		MME_LItemApothecaryIngredienstUncommon75.Revert()
		;Build MME LL (100% spawn)
		;add lactacid milk
		MME_LItemApothecaryIngredienstUncommon75.AddForm(MME_Util_Potions.GetAt(t), 1, 1)
		MME_LItemApothecaryIngredienstUncommon75.AddForm(MME_Util_Potions.GetAt(t), 1, 1)
		MME_LItemApothecaryIngredienstUncommon75.AddForm(MME_Util_Potions.GetAt(t), 1, 1)
		MME_LItemApothecaryIngredienstUncommon75.AddForm(MME_Util_Potions.GetAt(t), 1, 1)
		MME_LItemApothecaryIngredienstUncommon75.AddForm(MME_Util_Potions.GetAt(t), 1, 1)
		
		;add simple special milk
		MME_LItemApothecaryIngredienstUncommon75.AddForm(MME_Milk_Succubus.GetAt(0), 1, 1)
		MME_LItemApothecaryIngredienstUncommon75.AddForm(MME_Milk_Vampire.GetAt(0), 1, 1)
		MME_LItemApothecaryIngredienstUncommon75.AddForm(MME_Milk_Werewolf.GetAt(0), 1, 1)

		;Add MME LL to game list (75% spawn)
		LItemApothecaryIngredienstUncommon75.AddForm(MME_LItemApothecaryIngredienstUncommon75, 1, 1)
		debug.Trace("MilkModEconomy adding MME_LItemApothecaryIngredienstUncommon75 list to LItemApothecaryIngredienstUncommon75")
	EndIf
	
	i = 0
	while i < LItemSkooma75.GetNumForms() && LItemSkooma75.GetNthForm(i) != MME_LItemSkooma75RaceMilkLactacid
		i += 1
	endwhile
	
	;add lactacid to outlaws?
	if LItemSkooma75.GetNthForm(i) != MME_LItemSkooma75RaceMilkLactacid
		;Reset MME LL
		MME_LItemSkooma75RaceMilkLactacid.Revert()
		;Build MME LL (100% spawn)

		;add 5 lactacid to skooma LL list
		MME_LItemSkooma75RaceMilkLactacid.AddForm(MME_Util_Potions.GetAt(t), 1, 1)
		MME_LItemSkooma75RaceMilkLactacid.AddForm(MME_Util_Potions.GetAt(t), 1, 1)
		MME_LItemSkooma75RaceMilkLactacid.AddForm(MME_Util_Potions.GetAt(t), 1, 1)
		MME_LItemSkooma75RaceMilkLactacid.AddForm(MME_Util_Potions.GetAt(t), 1, 1)
		MME_LItemSkooma75RaceMilkLactacid.AddForm(MME_Util_Potions.GetAt(t), 1, 1)

		;add normal races lactacid containing milk to skooma LL list(100-75=25% spawn)
		while t < MME_Milk_Altmer_Normal.GetSize()
			MME_LItemSkooma75RaceMilkLactacid.AddForm(MME_Milk_Altmer_Normal.GetAt(t), 1, 1)
			MME_LItemSkooma75RaceMilkLactacid.AddForm(MME_Milk_Argonian_Normal.GetAt(t), 1, 1)
			MME_LItemSkooma75RaceMilkLactacid.AddForm(MME_Milk_Bosmer_Normal.GetAt(t), 1, 1)
			MME_LItemSkooma75RaceMilkLactacid.AddForm(MME_Milk_Breton_Normal.GetAt(t), 1, 1)
			MME_LItemSkooma75RaceMilkLactacid.AddForm(MME_Milk_Dunmer_Normal.GetAt(t), 1, 1)
			MME_LItemSkooma75RaceMilkLactacid.AddForm(MME_Milk_Imperial_Normal.GetAt(t), 1, 1)
			MME_LItemSkooma75RaceMilkLactacid.AddForm(MME_Milk_Khajiit_Normal.GetAt(t), 1, 1)
			MME_LItemSkooma75RaceMilkLactacid.AddForm(MME_Milk_Nord_Normal.GetAt(t), 1, 1)
			MME_LItemSkooma75RaceMilkLactacid.AddForm(MME_Milk_Orc_Normal.GetAt(t), 1, 1)
			MME_LItemSkooma75RaceMilkLactacid.AddForm(MME_Milk_Redguard_Normal.GetAt(t), 1, 1)
			t += 1
		endwhile
		;Add MME LL to game list (75% spawn)
		LItemSkooma75.AddForm(MME_LItemSkooma75RaceMilkLactacid, 1, 1)
		debug.Trace("MilkModEconomy adding MME_LItemSkooma75RaceMilkLactacid list to LItemSkooma75")
	endif
EndFunction

Function SlSWfoodlistaddon()
	if Plugin_SlSW
		LeveledItem SLSW_DrugsWOcure10 = Game.GetFormFromFile(0x1B0A9, "SexLabSkoomaWhore.esp") as LeveledItem
		LeveledItem SLSW_DrugsAll = Game.GetFormFromFile(0x1AB46, "SexLabSkoomaWhore.esp") as LeveledItem
		FormList SLSW_DrugsWOcure = Game.GetFormFromFile(0x20c71, "SexLabSkoomaWhore.esp") as FormList

		int i = 0
		debug.Trace("MilkModEconomy adding MME Leveled lists to SexLabSkoomaWhore Leveled lists")
		while i < SLSW_DrugsWOcure10.GetNumForms() && SLSW_DrugsWOcure10.GetNthForm(i) != MME_LItemSkooma75RaceMilkLactacid
			i += 1
		endwhile
		
		if SLSW_DrugsWOcure10.GetNthForm(i) != MME_LItemSkooma75RaceMilkLactacid
			SLSW_DrugsWOcure10.AddForm(MME_LItemSkooma75RaceMilkLactacid, 1, 1)
			debug.Trace("MilkModEconomy adding MME_LItemSkooma75RaceMilkLactacid list to SLSW_DrugsWOcure10")
		endif
		
		i = 0
		while i < SLSW_DrugsAll.GetNumForms() && SLSW_DrugsAll.GetNthForm(i) != MME_LItemSkooma75RaceMilkLactacid
			i += 1
		endwhile
		
		if SLSW_DrugsAll.GetNthForm(i) != MME_LItemSkooma75RaceMilkLactacid
			SLSW_DrugsAll.AddForm(MME_LItemSkooma75RaceMilkLactacid, 1, 1)
			debug.Trace("MilkModEconomy adding MME_LItemSkooma75RaceMilkLactacid list to SLSW_DrugsAll")
		endif
		
		if SLSW_DrugsWOcure.Find(MME_Util_Potions.GetAt(0)) < 0
			SLSW_DrugsWOcure.AddForm(MME_Util_Potions.GetAt(0))
			debug.Trace("MilkModEconomy adding Lactacid to SLSW_DrugsWOcure formlist")
		endif
	EndIf
EndFunction

Function Milkmaidinfo()
	String msg = ""
	int i = 0
	msg = " Milkmaids info:\n"
	while i < MilkMaid.Length
		if MilkMaid[i] != None
			float MilkCnt = MME_Storage.getMilkCurrent(MILKmaid[i])
			float PainCnt = MME_Storage.getPainCurrent(MILKmaid[i])
			float PainMax = MME_Storage.getPainMaximum(MILKmaid[i])
			msg = msg + ("Maid name: " + MilkMaid[i].GetLeveledActorBase().GetName()\
							+ " Milk: " + ReduceFloat(MilkCnt)\
							+ " Pain: " + (PainCnt/PainMax*100) as int + "%")
		endif
		i += 1
	endwhile
	while i < MilkSlave.Length
		if MilkSlave[i] != None
			float MilkCnt = MME_Storage.getMilkCurrent(MilkSlave[i])
			float PainCnt = MME_Storage.getPainCurrent(MilkSlave[i])
			float PainMax = MME_Storage.getPainMaximum(MilkSlave[i])
			msg = msg + ("Slave name: " + MilkSlave[i].GetLeveledActorBase().GetName()\
							+ " Milk: " + ReduceFloat(MilkCnt)\
							+ " Pain: " + (PainCnt/PainMax*100) as int + "%")
		endif
		i += 1
	endwhile
	Debug.MessageBox(msg)
EndFunction

Function Modtoggle()
	if !MilkFlag
		MilkFlag = true
		EconFlag = true
		if MilkPoll > 24
			RegisterForSingleUpdate(MilkPoll)
		else
			RegisterForSingleUpdateGameTime (MilkPoll)
		endif
		MilkE.RegisterForSingleUpdateGameTime (1)
		debug.Notification("Milk Mod Enabled")
	else
		MilkFlag = false
		EconFlag = false
		UnregisterForUpdate()
		UnregisterForUpdateGameTime()
		MilkE.UnregisterForUpdateGameTime()
		LastTimeMilked = 0
		debug.Notification("Milk Mod Disabled")
	endif
EndFunction

Function AddMilkFx(Actor akActor, int i)
	If MilkLeakTextures
		If i == 1
			akActor.AddSpell(MilkFx1,False)
		else
			akActor.AddSpell(MilkFx2,False)
		EndIf
	EndIf
EndFunction

Function AddLeak(Actor akActor)
	if MilkLeakToggle == true && DDi.IsMilkingBlocked_Bra(akActor) == false && PiercingCheck(akActor) != 2
		If (akActor.GetWornForm(Armor.GetMaskForSlot(32)) == None || MilkLeakWearArm == true)
			MilkLeak.cast(akActor)
		ElseIf MME_Storage.getBreastRows(akActor) != 1
			MilkLeak.cast(akActor)
		EndIf
	EndIf
EndFunction

Function RemoveMilkFx1(Actor akActor)
	If akActor.HasSpell(MilkFx1)
		akActor.RemoveSpell(MilkFx1)
	EndIf
EndFunction

Function RemoveMilkFx2(Actor akActor)
	If akActor.HasSpell(MilkFx2)
		akActor.RemoveSpell(MilkFx2)
	EndIf
EndFunction

Function MaidRemove(Actor akActor)
		debug.notification("MilkModEconomy existing maid/slave " + akActor.GetLeveledActorBase().GetName() + "resetting")
	If akActor != None
		MME_BodyMod BodyMod = Quest.GetQuest("MME_MilkQUEST") as MME_BodyMod
		debug.Trace("MilkModEconomy existing maid/slave " + akActor.GetLeveledActorBase().GetName() + "resetting")
		
		;Reset Body mods
		MaidResetNodes(akActor)
	
		; reset SexLab Inflation Framework  
		int SLIF_unregisterActor = ModEvent.Create("SLIF_unregisterActor")
		if (SLIF_unregisterActor)
			ModEvent.PushForm(SLIF_unregisterActor, akActor)
			ModEvent.PushString(SLIF_unregisterActor, "Milk Mod Economy")
			ModEvent.Send(SLIF_unregisterActor)
		endif

		; <modified to match updated code in MilkMCM.psc:850-853>
		;float MaidWeightBase = MME_Storage.getWeightBasevalue(MILKmaid[i])
		;Float NeckDelta = (akActor.GetLeveledActorBase().GetWeight() / 100) - (MaidWeightBase/100)
		;akActor.GetLeveledActorBase().SetWeight(MaidWeightBase)
		;akActor.UpdateWeight(NeckDelta)
			
		;remove de/buffs, effects
		If akActor.HasSpell(MME_Spells_Buffs.GetAt(1) as Spell)
			akActor.RemoveSpell(MME_Spells_Buffs.GetAt(1) as Spell)
		EndIf
		
		If akActor.HasSpell(MME_Spells_Buffs.GetAt(2) as Spell)
			akActor.RemoveSpell(MME_Spells_Buffs.GetAt(2) as Spell)
		EndIf
		
		If akActor.HasSpell(MME_Spells_Buffs.GetAt(0) as Spell)
			akActor.RemoveSpell(MME_Spells_Buffs.GetAt(0) as Spell)
		EndIf
		
		If akActor.HasSpell(MME_Spells_Buffs.GetAt(3) as Spell)
			akActor.RemoveSpell(MME_Spells_Buffs.GetAt(3) as Spell)
		EndIf
		
		If akActor.HasSpell(MME_Spells_Buffs.GetAt(4) as Spell)
			akActor.RemoveSpell(MME_Spells_Buffs.GetAt(4) as Spell)
		EndIf

		If akActor.HasSpell(MilkCritical)
			akActor.RemoveSpell(MilkCritical)
		EndIf

		If akActor.HasSpell(MilkLeak)
			akActor.RemoveSpell(MilkLeak)
		EndIf
		
		If akActor.HasSpell(MilkFx1)
			akActor.RemoveSpell(MilkFx1)
		EndIf
		
		If akActor.HasSpell(MilkFx2)
			akActor.RemoveSpell(MilkFx2)
		EndIf
		
		If akActor.HasSpell(BeingMilkedPassive)
			akActor.RemoveSpell(BeingMilkedPassive)
		EndIf
		
		;remove variables from StorageUtil
		MME_Storage.deregisterActor(akActor)
		akActor.RemoveFromFaction(MilkMaidFaction)
		akActor.RemoveFromFaction(MilkSlaveFaction)
		MultiBreastChange(akActor)
		if akActor == Game.Getplayer()
			StorageUtil.UnSetStringValue(akActor, "MME.FirstTimeStoryStart")
			StorageUtil.UnSetStringValue(akActor, "MME.FirstTimeStoryEnd")
		endif
	EndIf
EndFunction

Function MaidResetNodes(Actor akActor)
	If akActor != None
		MME_BodyMod BodyMod = Quest.GetQuest("MME_MilkQUEST") as MME_BodyMod
		debug.Trace("MilkModEconomy existing maid/slave " + akActor.GetLeveledActorBase().GetName() + "resetting NiO scales")
		
	;Reset Body mods
	;Reset NIO
	
		bool isFemale = false
		if akActor.GetLeveledActorBase().GetSex() == 1
			isFemale = true
		Else
			isFemale = false
		endif

	;HDT Female / Vampire Lord
		BodyMod.RemoveNiONodeScale(akActor, "NPC L Breast", isFemale)
		BodyMod.RemoveNiONodeScale(akActor, "NPC R Breast", isFemale)
	
	;Curve fix
		BodyMod.RemoveNiONodeScale(akActor, "NPC L Breast01", isFemale)
		BodyMod.RemoveNiONodeScale(akActor, "NPC R Breast01", isFemale)
	
	;HDT Werewolf
		BodyMod.RemoveNiONodeScale(akActor, "NPC L Breast P1", isFemale)
		BodyMod.RemoveNiONodeScale(akActor, "NPC R Breast P1", isFemale)
		BodyMod.RemoveNiONodeScale(akActor, "NPC L Breast P2", isFemale)
		BodyMod.RemoveNiONodeScale(akActor, "NPC R Breast P2", isFemale)
		BodyMod.RemoveNiONodeScale(akActor, "NPC L Breast P3", isFemale)
		BodyMod.RemoveNiONodeScale(akActor, "NPC R Breast P3", isFemale)
		
		BodyMod.RemoveNiONodeScale(akActor, "NPC Belly", isFemale)
	
	;Male/Futa
		BodyMod.RemoveNiONodeScale(akActor, "NPC L GenitalsScrotum [LGenScrot]", isFemale)
		BodyMod.RemoveNiONodeScale(akActor, "NPC L GenitalsScrotum [RGenScrot]", isFemale)

	EndIf
EndFunction

Function MCMMaidReset(int t, int i)
	if t == 0
		MaidRemove(MilkMaid[i])
		MilkMaid[i] = None
	else
		MaidRemove(MilkSlave[i])
		MilkSlave[i] = None
	endif
EndFunction

Function MCMMaidNiOReset()
	debug.Trace("MilkModEconomy maid/slave Nio nodes reset cycle")
	int i = 0
	while ( i < MilkMaid.Length )
		MaidResetNodes(MilkMaid[i])
		i += 1
	endWhile
	
	i = 0
	while ( i < MilkSlave.Length )
		MaidResetNodes(MilkSlave[i])
		i += 1
	endWhile
EndFunction

Function SingleMaidReset(Actor akActor)
	if MilkMaid.find(akActor) > -1
		MilkMaid[MilkMaid.find(akActor)] = None
	endif
	if MilkSlave.find(akActor) > -1
		MilkSlave[MilkSlave.find(akActor)] = None
	endif
	MaidRemove(akActor)
EndFunction

Function MaidReset()
	debug.Trace("MilkModEconomy maid reset cycle")
	int i = 0
	while ( i < MilkMaid.Length )
		debug.Trace("MilkModEconomy maid array reset " + i + " of " + MilkMaid.Length)
		MaidRemove(MilkMaid[i])
		i += 1
	endWhile
	
	MilkMaid = new Actor[20]
	StorageUtil.FormListClear(none,"MME.MilkMaid.List")
EndFunction

Function SlaveReset()
	debug.Trace("MilkModEconomy slave reset cycle")
	int i = 0
	while ( i < MilkSlave.Length )
		debug.Trace("MilkModEconomy Slave array reset " + i + " of " + MilkSlave.Length)
		MaidRemove(MilkSlave[i])
		i += 1
	endWhile

	MilkSlave = new Actor[100]
EndFunction

Function Armor_Purge()
	int i = 0
	MilkingEquipment = new string[10]
	BasicLivingArmor = new string[10]
	ParasiteLivingArmor = new string[10]
	while ( i < MilkingEquipment.Length )
		MilkingEquipment[i] = "Empty"
		BasicLivingArmor[i] = "Empty"
		ParasiteLivingArmor[i] = "Empty"
		i += 1
	endWhile
EndFunction

bool Function VarSetup()
	UnregisterForAllKeys()
	debug.Trace("MilkModEconomy variable setup/reset")
	MilkLvlCap = 10
	;reset progression
	StorageUtil.SetIntValue(none,"MME.Progression.Level", 0)
	StorageUtil.SetIntValue(none,"MME.Progression.TimesMilked", 0)
	StorageUtil.SetIntValue(none,"MME.Progression.TimesMilkedAll", 0)
	StorageUtil.SetFloatValue(none,"MME.LactacidMod", 10)
	StorageUtil.SetIntValue(none,"MME.MaidLevelProgressionAffectsMilkGen", 0)
	
	;UnsetIntValue(none,"MME.Settings.BreastScale")
	
	;reset mcm values
	BoobIncr = 0.05
	BoobPerLvl = 0.07
	BoobMAX = 3
	BreastCurve = 0.1
	Feeding = True
	Feeding_Duration = 5
	Feeding_Sound = 0
	FuckMachine = False
	FuckMachine_Duration = 5
	MilkGenValue = 0.06
	MilkPoll = 1
	Milking_Duration = 5
	TimesMilkedMult = 50
	GushPct = 10

	DisableSkoomaLactacid = False
	DialogueForceMilkSlave = False
	BreastScale = 0							;scaling is enabled
	BellyScale = true						;scaling is enabled
	BreastScaleLimit = False				;limit to BoobMAX
	BreastUpScale = False	;scale to 1
	BreastVolumeScale = False
	MaleMaids = False
	MilkQC.Buffs = True
	MilkQC.ExhaustionMode = 0
	MilkQC.BrestEnlargement_MultiBreast_Effect = 0
	MilkQC.Debug_enabled = 0
	MME_NPCComments.SetValue(10)
	MilkQC.MME_DialogueMilking = True
	MilkQC.MME_SimpleMilkPotions = False
	ForcedFeeding = False
	FixedMilkGen = False
	FixedMilkGen4Followers = False
	CuirassSellsMilk = False
	MaidLvlCap = False
	SexLabOrgasm = True
	PassiveArousalIncrease = True
	MilkAsMaidTimesMilked = False
	MilkProdMod = 100
	MilkPriceMod = 1
	LactacidDecayRate = 0
	ExhaustionSleepMod = 0
	MilkFlag = False 						;polling disabled
	EconFlag = False 						;8h polling disabled
	MilkNaked = False
	MilkMsgs = True
	MilkCntMsgs = True
	MilkEMsgs = True
	MilkStory = True
	MilkLeakTextures = True
	MilkLeakToggle = True
	MilkLeakWearArm = False
	MilkSuccubusTransform = False
	MilkVampireTransform = False
	MilkWerewolfTransform = False
	MilkWithZaZMoMSuctionCups = False
	MilkingDrainsSP = True
	MilkingDrainsMP = True
	MilkingReq40PctMilk = True
	MobileMilkingAnims = True
	CumProduction = True
	PainSystem = True
	PainKills = True
	WeightUpScale = False					;scale to 100
	PlayerCantBeMilkmaid = False
	ZazPumps = False
	UseFutaMilkCuirass = False
	FreeLactacid = False
	ArmorStrippingDisabled = False
	
	ECTrigger = True
	ECCrowdControl = True
	ECRange = 500

	NotificationKey = 10
	HotkeyMode = 0
	crosshairRef = None
	
	RegisterForKey(NotificationKey)
	RegisterForCrosshairRef()

	MilkE.divnull = 10
	MilkE.InitializeMilkProperties()
	Strings_setup()
	Armor_Purge()
	MMEfoodlistaddon()
	
	return true
EndFunction

Function UNINSTALL()
	debug.Trace("MilkModEconomy Uninstalling")
	;reset variables
	VarSetup()
	
	;disable mod
	if MilkFlag
		Modtoggle()
	else
		Modtoggle()
		Modtoggle()
	endif
	
	UnregisterForCrosshairRef()
	
	;reset maids stats
	MaidReset()
	SlaveReset()
	Debug.Notification("Milk Mod reset")
EndFunction


;----------------------------------------------------------------------------
;Actor status checks
;----------------------------------------------------------------------------

string Function akActorSex(Actor akActor)
bool hasSchlong = False

	if Plugin_SOS
		hasSchlong = SOS.GetSOS(akActor)
	endif
	
	if Plugin_SOS_EQUIP && hasSchlong != True
		hasSchlong = akActor.IsEquipped(Game.GetFormFromFile(0xD62, "SOS Equipable Schlong.esp"))
	endif
	
	if akActor.GetLeveledActorBase().GetSex() == 1 && SexLab.GetGender(akActor) == 1 && hasSchlong != True
		Return "Female"
	elseif akActor.GetLeveledActorBase().GetSex() == 0 && SexLab.GetGender(akActor) == 0
		Return "Male"
	elseif akActor.GetLeveledActorBase().GetSex() > 1 || SexLab.GetGender(akActor) > 1
		Return "Beast"
	else
		Return "Futa"
	endif
EndFunction

bool Function isVampire(Actor akActor)
	; VampireVampirism
	; VampirePoisonResist
	If StringUtil.Find(akActor.GetRace().getname(), "Vampire") >= 0\
	|| StorageUtil.GetIntValue(akActor,"MME.MilkMaid.IsVampire") == 1\
	|| akActor.HasSpell(Game.GetFormFromFile(0xed0a8, "Skyrim.esm") as Spell)\
	|| akActor.HasSpell(Game.GetFormFromFile(0x10fb30, "Skyrim.esm") as Spell)
		Return True
	endif
	Return False
EndFunction

bool Function isWerewolf(Actor akActor)
	; WerewolfChange
	; WerewolfImmunity
	If StringUtil.Find(akActor.GetRace().getname(), "Werewolf") >= 0\
	|| StringUtil.Find(akActor.GetRace().getname(), "Werebeast") >= 0\
	|| StorageUtil.GetIntValue(akActor,"MME.MilkMaid.IsWerewolf") == 1\
	|| akActor.HasSpell(Game.GetFormFromFile(0x92c48, "Skyrim.esm") as Spell)\
	|| akActor.HasSpell(Game.GetFormFromFile(0xf5ba0, "Skyrim.esm") as Spell)
		Return True
	endif
	Return False
EndFunction

bool Function isSuccubus(Actor akActor)
	If StringUtil.Find(akActor.GetRace().getname(), "Succubus") >= 0\
	|| StorageUtil.GetIntValue(akActor, "Angrim_iSuccubusCurse") > 0\
	|| StorageUtil.GetIntValue(akActor, "_SLH_isSuccubus") > 0\
	|| StorageUtil.GetIntValue(akActor, "PSQ_PlayerIsSuccubus") > 0\
	|| StorageUtil.GetIntValue(akActor, "MME.MilkMaid.IsSuccubus") > 0
		Return True
	endif
	Return False
EndFunction

bool Function isPregnant(Actor akActor)
	String akActorName = akActor.GetLeveledActorBase().GetName()
	;SL Procreation
	if SLP.IsPregnant(akActor) == true
		debug.Trace("MilkModEconomy SLP Pregnancy: " + akActorName)
		Return True
	endif
	
	;Hentai pregnancy LE/SE
	if Plugin_HentaiPregnancy
		Faction HentaiPregnantFaction = ( Game.GetFormFromFile(0x12085, "HentaiPregnancy.esm") as Faction )		;HentaiPregnantFaction
		if HentaiPregnantFaction
			if akActor.GetFactionRank(HentaiPregnantFaction) == 2 || akActor.GetFactionRank(HentaiPregnantFaction) == 3
				debug.Trace("MilkModEconomy SLHP2 Pregnancy: " + akActorName)
				Return True
			endif
		endif
	endif
	
	;Fertility Mode 1.5
	if (StorageUtil.HasIntValue(akActor, "_JSW_FM_PregnantDay") && StorageUtil.GetIntValue(akActor, "_JSW_FM_PregnantDay") > 0)
		debug.Trace("MilkModEconomy Fertility Mode Pregnancy: " + akActorName)
		Return True
	endif
	
	;Fertility Mode 2+
	if FM.IsPregnant(akActor) == true
		debug.Trace("MilkModEconomy FM Pregnancy: " + akActorName)
		Return True
	endif
	
	;SL Hentai pregnancy
	if SLHP.IsPregnant(akActor) == true
		debug.Trace("MilkModEconomy SLHP Pregnancy: " + akActorName)
		Return True
	endif

	;SoulGem Oven 2
	if StorageUtil.GetFloatValue(akActor, "SGO.Gem.Weight") > 0
		debug.Trace("MilkModEconomy SGO2 Pregnancy: " + akActorName)
		Return True
	endif
	
	;SoulGem Oven 3
	if SGO.IsPregnant(akActor) == true
		debug.Trace("MilkModEconomy SGO3 Pregnancy: " + akActorName)
		Return True
	endif
	
	;SexLab SoulGem Pregnancy
	if StorageUtil.GetIntValue(akActor, "PRG_IsPregnant") != 0
		debug.Trace("MilkModEconomy SGP Pregnancy: " + akActorName)
		Return True
	endif
	
	;PlayerSuccubusQuest SoulGem Pregnancy
	if StorageUtil.GetIntValue(akActor, "PSQ_SoulGemPregnancyON", 0) != 0
		debug.Trace("MilkModEconomy PSQ Pregnancy: " + akActorName)
		Return True
	endif

	;Estrus Chaurus+
	if Plugin_EstrusChaurus
		if akActor.HasSpell( Game.GetFormFromFile(0x19121, "EstrusChaurus.esp") as Spell ) ;ChaurusBreeder spell
			debug.Trace("MilkModEconomy EC Pregnancy: " + akActorName)
			Return True
		endif
		if akActor.HasKeyword( Game.GetFormFromFile(0x160A8, "EstrusChaurus.esp") as Keyword ) ;zzEstrusParasite Keyword
			debug.Trace("MilkModEconomy EC Pregnancy: " + akActorName)
			Return True
		endif
	endif
	
	;Estrus Spider+
	if Plugin_EstrusSpider
		if akActor.HasSpell( Game.GetFormFromFile(0x4e255, "EstrusSpider.esp") as Spell ) ;SpiderBreeder spell
			debug.Trace("MilkModEconomy ES Pregnancy: " + akActorName)
			Return True
		endif
		if akActor.HasKeyword( Game.GetFormFromFile(0x4F2A3, "EstrusSpider.esp") as Keyword ) ;zzEstrusSpiderParasiteKWD Keyword
			debug.Trace("MilkModEconomy EC Pregnancy: " + akActorName)
			Return True
		endif
	endif
	
	;Estrus Dwemer+
	if Plugin_EstrusDwemer
		if akActor.HasSpell( Game.GetFormFromFile(0x4e255, "EstrusDwemer.esp") as Spell ) ;DwemerBreeder spell
			debug.Trace("MilkModEconomy ED Pregnancy: " + akActorName)
			Return True
		endif
		if akActor.HasKeyword( Game.GetFormFromFile(0x4F2A3, "EstrusDwemer.esp") as Keyword ) ;zzEstrusDwemerParasiteKWD Keyword
			debug.Trace("MilkModEconomy ED Pregnancy: " + akActorName)
			Return True
		endif
	endif
	
	;BeeingFemale
	if Plugin_BeeingFemale
		if akActor.HasSpell( Game.GetFormFromFile(0x28a0, "BeeingFemale.esm") as Spell ) ;_BFStatePregnant spell
			debug.Trace("MilkModEconomy BF Pregnancy: " + akActorName)
			Return True
		endif
	endif
	
	;EggFactory
	If Game.GetModbyName("EggFactory.esp") != 255
		if akActor.isInFaction( Game.GetFormFromFile(0x2943C, "EggFactory.esp") as Faction ) ;EggFactoryPregCheck Faction
			debug.Trace("MilkModEconomy EggFactory Pregnancy: " + akActorName)
			Return True
		endif
	endif

	Return False
EndFunction

int Function PiercingCheck(Actor akActor)

	int t = 0
	if DDi.IsMilkingBlocked_PiercingsNipple(akActor) == true
		t = 1
	endif
	Form maidArmor = akActor.GetWornForm(Armor.GetMaskForSlot(56))
	if maidArmor != None
		if StringUtil.Find(maidArmor.getname(), "Plug" ) >= 0 
			t = 2
		elseif StringUtil.Find(maidArmor.getname(), "Piercing" ) >= 0 
			t = 1
		endif
	endif
	return t
EndFunction

int Function IsNamedMaid(Actor akActor)
	String akActorName = akActor.getname()
	if StringUtil.Find(akActorName, "Milkmaid" ) >= 0 ||  StringUtil.Find(akActorName, "Milk maid" ) >= 0
		return 1
	elseif StringUtil.Find(akActorName, "Milkslave" ) >= 0 || StringUtil.Find(akActorName, "Milk slave" ) >= 0
		return 2
	elseif StringUtil.Find(akActorName, "Cow" ) >= 0
		return 3
	else
		return 0
	endif
EndFunction

;for Use game controller as Vibrator!
Function sendVibrationEvent(string str, actor who, int mpas, int MilkingType)
	Int e = ModEvent.Create("MilkQuest."+str)
	If(!e)
		Return
	EndIf
	
	If MilkingType == 2
		MilkingType = 1
	EndIf

	ModEvent.PushForm(e,Who)
	ModEvent.PushInt(e,mpas)
	ModEvent.PushInt(e,MilkingType)
	ModEvent.Send(e)
endfunction

;----------------------------------------------------------------------------
;Exhaustion/Pain Functions (Called if actor is milkmaid/slave)
;----------------------------------------------------------------------------

string Function NState(Actor akActor)
	String NState
	Float PainCnt = MME_Storage.getPainCurrent(akActor)
	Float PainMax = MME_Storage.getPainMaximum(akActor)

	if PainCnt >= (PainMax*0.9) as int
		NState = "Sore"
	elseif PainCnt >= (PainMax/3*2) as int
		NState = "Irritated"
	elseif PainCnt >= (PainMax/3) as int
		NState = "Sensitive"
	elseif PainCnt < (PainMax/3) as int
		NState = "Normal"
	endif
	
	return NState
EndFunction

int Function Pain(Actor akActor, int pain)
	Int   MaidLevel = MME_Storage.getMaidLevel(akActor)
	Float PainCnt = MME_Storage.getPainCurrent(akActor)
	Float PainMax = MME_Storage.getPainMaximum(akActor)
		string who
		string how

	if akActor == PlayerRef
		who = "My"
		how = "feels"
	else 
		who = akActor.GetLeveledActorBase().GetName() + "'s"
		how = "looks"
	endif

	if PainCnt < (PainMax/3) as int && NState(akActor) == "Normal"
	elseif PainCnt >= (PainMax/3) as int && NState(akActor) == "Sensitive"
		pain += 1
		debug.Notification(who + " nipples " + how + " very sensitive.")
	elseif PainCnt >= (PainMax/3*2) as int && NState(akActor) == "Irritated"
		pain += 1
		debug.Notification(who + " nipples " + how + " irritated and stretched.")
	elseif PainCnt >= (PainMax*0.9) as int && NState(akActor) == "Sore"
		pain += 1
		debug.Notification(who + " nipples jut out in pain demanding release!")
	endif

	PainCnt += (pain - MaidLevel * 0.025) * (1 - SLA.GetActorArousal(akActor) / 100 * 0.25)
	if PiercingCheck(akActor) == 1
		PainCnt *= 2 
	endif

	; automatically limits value to PainMax
	MME_Storage.setPainCurrent(akActor, PainCnt)

	return pain
EndFunction