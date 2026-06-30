Scriptname sr_inflateQuest extends Quest

import StorageUtil
import sr_HentairimUtils

sr_inflateConfig Property config auto
sr_infDeflateAbility Property defAlias Auto
sr_inflateMessages Property dialogue auto 
sr_infEventManager Property eventManager auto
sr_infPlayer Property infplayer auto
 
Quest Property sr_inflateExternalEventManager Auto
GlobalVariable Property sr_debug auto
Keyword Property sr_WhyWontYouDispel Auto
Spell Property sr_inflateBurstSpell Auto 
LeveledItem Property TongueLVL Auto
Armor TongueA
Armor Property Tongue Auto
Armor Property sr_linga1armor Auto
Armor Property sr_linga2armor Auto
Armor Property sr_linga3armor Auto
Armor Property sr_linga4armor Auto
Armor Property sr_linga5armor Auto
Armor Property sr_linga6armor Auto
Armor Property sr_linga7armor Auto
Armor Property sr_linga8armor Auto
Armor Property sr_linga9armor Auto
Armor Property sr_linga10armor Auto
GlobalVariable Property sr_TongueEffect Auto
GlobalVariable Property sr_OnEventSpermPlayer Auto
GlobalVariable Property sr_OnEventSpermNPC Auto
GlobalVariable Property sr_Cumvariation Auto
GlobalVariable Property sr_MoanSound Auto
GlobalVariable Property sr_SexlabMoanSound Auto

Armor Property sr_VagLeak Auto
Armor Property sr_vagLeakBeast Auto
Armor Property sr_vagLeakRotten Auto
Armor Property sr_analLeakGreen Auto
Armor Property sr_AnalLeak Auto
Armor Property sr_analLeakBeast Auto
Armor Property sr_analLeakRotten Auto
Armor Property sr_vagLeakGreen Auto
Armor Property sr_OralLeak Auto
Armor Property sr_OralLeakBeast Auto
Armor Property sr_OralLeakGreen Auto
Armor Property sr_OralLeakRotten Auto

Armor Property sr_ThickCum Auto
Armor Property sr_ThickCumGreen Auto

Armor Property sr_ChaurusEggs Auto
Armor Property sr_ChaurusLarvaeEggs Auto
Armor Property sr_SpiderEggs Auto
Armor Property sr_SprigganSlug Auto
Armor Property sr_AtronachStones Auto
Armor Property sr_AshHopperEggs Auto

GlobalVariable Property sr_plugged Auto ; for detecting when the player is plugged from dialogue without making DDa a hard requirement. Not always in sync but should be good enough
GlobalVariable Property sr_CumEffectsEnabled Auto
GlobalVariable Property sr_OnEventNoDeflation Auto
GlobalVariable Property sr_OnEventAbsorbSperm Auto
GlobalVariable Property sr_OnEventAbsorbSpermOral Auto
GlobalVariable Property sr_SendingSpermDataChance Auto
GlobalVariable Property sr_SendingSpermDataCriterion Auto

GlobalVariable Property SRSlotMask Auto
GlobalVariable Property SRSlotMaskB Auto
Armor[] wornforms


Faction Property sr_Impregnated Auto
Faction Property sr_Impregnatedanal Auto
Faction Property sr_DARAnimatingType Auto
Faction Property inflaterAnimatingFaction Auto
Faction Property inflateFaction Auto
Faction Property SR_InflateOralFaction Auto
Spell Property encumber05 Auto
Spell Property encumber10 Auto
Spell Property encumber15 Auto
Spell Property encumber20 Auto
Spell Property encumber25 Auto

Spell Property sr_expelcumspell Auto
SexLabFramework Property sexlab auto
Faction Property slAnimatingFaction auto

Package Property stayStillPackage auto

GlobalVariable Property GameDaysPassed auto
bool zad = false
Keyword Property zad_DeviousGag auto 
Keyword Property zad_PermitOral auto 

Keyword Property zad_DeviousPlugAnal auto 
Keyword Property zad_DeviousPlugVaginal auto 
Keyword Property zad_DeviousBelt auto 
Keyword Property zad_PermitAnal auto 

ImpactDataSet Property SFU_CumImpactDataSet Auto
ImpactDataSet Property SFU_CumMidImpactDataSet Auto
ImpactDataSet Property SFU_CumHighImpactDataSet Auto

;Actor[] Property Injector Auto ; deprecated
;Actor[] Property InjectorPlayer Auto ; deprecated
formlist Property sr_InjectorFormlist auto
Actor Property Player Auto
;Actor DeflateActor
Static Property xMarker Auto
;Spell Property puddleSpell Auto

Keyword Property SLA_AnalPlug Auto
Keyword Property SLA_AnalPlugBeads Auto
Keyword Property SLA_AnalPlugTail Auto
Keyword Property SLA_VaginalBeads Auto

;int property Tongueri auto
;int property cumtypei auto

sr_inflateThread[] Property threads auto

;Bool TongueOut

GlobalVariable Property sr_CumMultiplier Auto
GlobalVariable Property sr_SLIF Auto ;deprecated
float Property cumMult hidden
	float Function Get()
		return sr_CumMultiplier.GetValue()
	EndFunction
	
	Function Set(float val)
		sr_CumMultiplier.SetValue(val)
	EndFunction
EndProperty

float Property BURST_MULT = 1.2 autoreadonly hidden

String Property EXPEL_SWITCH = "sr.inflater.expel.switch" autoreadonly hidden;Do we need this?

String Property ORIGINAL_SCALE = "sr.inflater.scale.original" autoreadonly hidden
String Property INFLATION_AMOUNT = "sr.inflater.amount" autoreadonly hidden
String Property INFLATED_ACTORS = "sr.inflater.Actors" autoreadonly hidden

String Property LAST_TIME_VAG = "sr.inflater.time.vaginal" autoreadonly hidden 
String Property LAST_TIME_ANAL = "sr.inflater.time.anal" autoreadonly hidden
String Property LAST_TIME_ORAL = "sr.inflater.time.oral" autoreadonly hidden

String Property CUM_VAGINAL = "sr.inflater.cum.vaginal" autoreadonly hidden
String Property CUM_ANAL = "sr.inflater.cum.anal" autoreadonly hidden
String Property CUM_ORAL = "sr.inflater.cum.oral" autoreadonly hidden

String Property CUM_LUMP_VAGINAL = "sr.inflater.lump.vaginal" autoreadonly hidden

String Property InflateMorph = "PregnancyBelly" Auto
String property InflateMorph2 = "" Auto
String property InflateMorph3 = "" Auto
String property InflateMorph4 = "" Auto
String property PregnancyBelly = "PregnancyBelly" AutoReadOnly hidden
String Property BELLY_NODE = "NPC Belly" autoreadonly hidden
String Property ANIMATING = "sr.inflater.animating" autoreadonly hidden
String Property ANIMATE_NUM = "sr.inflater.animate.num" autoreadonly hidden
String Property ANIMATING_SPERMTYPE = "sr.inflater.animating.spermtype" autoreadonly hidden
String Property CHEST_ARMOR = "sr.inflater.armor.chest" autoreadonly hidden
String Property COVER_PIECE = "sr.inflater.armor.cover" autoreadonly hidden

String Property RACE_CUM_AMOUNT = "sr.inflater.race.cum.amount" autoreadonly hidden
String Property CREATURERACE_CUM_AMOUNT = "sr.inflater.creaturerace.cum.amount" autoreadonly hidden
String property RACE_CUM_EFFECTS = "sr.inflater.race.cum.effects" autoreadonly hidden
String property CREATURERACE_CUM_EFFECTS = "sr.inflater.Creaturerace.cum.effects" autoreadonly hidden

String Property START_INFLATION = "sr.inflater.start" autoreadonly hidden
String Property START_ABSORPTION = "sr.inflater.absorb" autoreadonly hidden
String Property TULL_UNEQUIP_LIST = "sr.inflater.tull.unequip.list" autoreadonly hidden
String Property TULL_UNEQUIP_AT = "sr.inflater.tull.unequip.at" autoreadonly hidden

int property VAGINAL		= 0x01 autoreadonly hidden
int property ANAL		= 0x02 autoreadonly hidden
int property ORAL		= 0x04 autoreadonly hidden

GlobalVariable Property sr_EstrusChaurus auto
GlobalVariable Property sr_Fertility auto
GlobalVariable Property sr_BeeingFemale auto

Idle property BaboStomachRubbing auto
Idle property BaboSpermExpelPanting auto
Idle property BaboSpermExpelRefuse auto
Idle property BaboSpermAnusExpelFail auto
Idle property BaboSpermExpel auto
Idle property BaboSpermOut01Start auto
Idle property BaboSpermOut02Start auto
Idle property BaboSpermOut03Start auto
Idle property BaboSpermOut04Start auto

Idle property BaboSpermOralOut auto
Idle property BaboSpermOral01Start auto
Idle property BaboSpermOral01Loop auto
Idle property BaboSpermOral01End auto

Idle property BaboSpermAnalOut01Start auto
Idle property BaboSpermAnalOut02Start auto
Idle property BaboSpermAnalOut03Start auto
Idle property BaboSpermAnalOut04Start auto

Idle property BaboSpermAnalOut01End auto
Idle property BaboSpermAnalOut02End auto
Idle property BaboSpermAnalOut03End auto
Idle property BaboSpermAnalOut04End auto


Idle property BaboSpermOut01Loop auto
Idle property BaboSpermOut02Loop auto
Idle property BaboSpermOut03Loop auto
Idle property BaboSpermOut04Loop auto

Idle property BaboSpermOut01End auto
Idle property BaboSpermOut02End auto
Idle property BaboSpermOut03End auto
Idle property BaboSpermOut04End auto

Idle[] BaboAnimsStart
Idle[] BaboAnimsEnd

Idle[] BaboAnimsOral
Idle[] BaboAnimsOralStart 
Idle[] BaboAnimsOralEnd 

Idle[] BaboAnimsAnusStart
Idle[] BaboAnimsAnusEnd

;int animnum
;int MoanType
bool dhlpSuspend
bool initialized = false

Race Property ChaurusRace Auto
Race Property ChaurusReaperRace Auto
Race Property DLC1_BF_ChaurusRace Auto
Race Property DLC1ChaurusHunterRace Auto

Race Property FrostbiteSpiderRace Auto
Race Property FrostbiteSpiderRaceGiant Auto
Race Property FrostbiteSpiderRaceLarge Auto
Race Property DLC2ExpSpiderBaseRace Auto
Race Property DLC2ExpSpiderPackmuleRace Auto
;int Property spermtype Auto ; deprecated
;Bool AnalDeflation

Sound Property sr_FHUMoanMildMarker  Auto  
Sound Property sr_FHUMoanHardMarker  Auto  
Sound Property sr_FHUMoanDenialMarker  Auto  
Sound Property sr_FHUCumDeflationOralMarker  Auto  
Sound Property sr_FHUCumDeflationVaginalHardMarker  Auto  
Sound Property sr_FHUCumDeflationVaginalMildMarker  Auto  
Sound Property sr_FHUCumDeflationOralFailMarker  Auto  
Sound Property sr_FHUCumDeflationOralAfterMarker  Auto  
Sound Property sr_FHUCumDeflationAnalMildMarker  Auto  
Sound Property sr_FHUCumDeflationAnalHardMarker  Auto  

Keyword Property ActorTypeNPC Auto
formlist property sr_CreatureRaceList auto

race property sr_DeathwormRace auto
race property sr_MimicRace auto

Bool Property bPlayerImpregnated auto hidden
Bool Property bPlayerImpregnatedAnal auto hidden

Bool Property bDeflateAnimation auto hidden
MagicEffect Property sr_ExpelCumMGEF Auto

Sound Property sr_FHUEggCrackingMarker Auto
Sound Property sr_FHUStomachRumblingMarker Auto

Referencealias[] property PregnantActors auto

Actor[] currentActors
int currentType = 0
Bool Property RubAnimation Auto hidden

Actor Property TempActor Auto Hidden
Function BaboAnimsSet()

BaboAnimsOral = new idle[1]
BaboAnimsOralStart = new idle[1]
BaboAnimsOralEnd = new idle[1]

BaboAnimsAnusStart = new idle[4]
BaboAnimsAnusEnd = new idle[4]

BaboAnimsStart = new idle[4]
BaboAnimsEnd = new idle[4]

BaboAnimsOral[0] = BaboSpermOralOut

BaboAnimsOralStart[0] = BaboSpermOral01Start

BaboAnimsOralEnd[0] = BaboSpermOral01End

BaboAnimsStart[0] = BaboSpermOut01Start
BaboAnimsStart[1] = BaboSpermOut02Start
BaboAnimsStart[2] = BaboSpermOut03Start
BaboAnimsStart[3] = BaboSpermOut04Start

BaboAnimsEnd[0] = BaboSpermOut01End
BaboAnimsEnd[1] = BaboSpermOut02End
BaboAnimsEnd[2] = BaboSpermOut03End
BaboAnimsEnd[3] = BaboSpermOut04End

BaboAnimsAnusStart[0] = BaboSpermAnalOut01Start
BaboAnimsAnusStart[1] = BaboSpermAnalOut02Start
BaboAnimsAnusStart[2] = BaboSpermAnalOut03Start
BaboAnimsAnusStart[3] = BaboSpermAnalOut04Start

BaboAnimsAnusEnd[0] = BaboSpermAnalOut01End
BaboAnimsAnusEnd[1] = BaboSpermAnalOut02End
BaboAnimsAnusEnd[2] = BaboSpermAnalOut03End
BaboAnimsAnusEnd[3] = BaboSpermAnalOut04End


EndFunction

Function EggHatchEffect(actor akactor)
	if !akactor.isinfaction(inflaterAnimatingFaction) && Game.IsMovementControlsEnabled() && RubAnimation 
		TryPlayIdle(akactor,BaboStomachRubbing)
	endif
	sr_FHUEggCrackingMarker.play(akactor)
	notify("$FHU_IMPREGNATION_MESSAGES")
EndFunction

Function RubStomach(actor akactor)
	if !akactor.isinfaction(inflaterAnimatingFaction) && Game.IsMovementControlsEnabled() && RubAnimation
		TryPlayIdle(akactor,BaboStomachRubbing)
	endif
	sr_FHUStomachRumblingMarker.play(akactor)
	notify("$FHU_STOMACHRUMBLE_MESSAGES")
EndFunction

float Function GetVersion()
	return 2.03
EndFunction

String Function GetVersionString()
	return "2.03"
EndFunction

Event OnInit()
	If(!initialized)
		initialized = true
		maintenance()
	EndIf
EndEvent

Function VersionUpdate()
	If Game.GetModByName("Devious Devices - Assets.esm") != 255
		zad = true
		zad_DeviousGag		= Game.GetFormFromFile(0x00007EB8, "Devious Devices - Assets.esm") as Keyword
		zad_PermitOral		= Game.GetFormFromFile(0x0000FAC9, "Devious Devices - Assets.esm") as Keyword
		
		zad_DeviousPlugAnal		= Game.GetFormFromFile(0x0001DD7D, "Devious Devices - Assets.esm") as Keyword
		zad_DeviousPlugVaginal	= Game.GetFormFromFile(0x0001DD7C, "Devious Devices - Assets.esm") as Keyword
		zad_DeviousBelt			= Game.GetFormFromFile(0x00003330, "Devious Devices - Assets.esm") as Keyword
		zad_PermitAnal			= Game.GetFormFromFile(0x0000FACA, "Devious Devices - Assets.esm") as Keyword
	EndIf
	SetIntValue(Player, "CI_CumInflation_ON", 1)
	eventManager.StartEvents()
EndFunction

Function maintenance()
	String previousState = GetState()
	GoToState("maintenance")

	RegisterForModEvent("dhlp-Suspend", "OnDhlpSuspend" )
	RegisterForModEvent("dhlp-Resume", "OnDhlpResume" )

	if config.enabled
		RegisterForModEvent("HookOrgasmStart", "Orgasm")
		RegisterForModEvent("HookAnimationEnd", "FHUSexlabEnd")
		RegisterForModEvent("SexLabOrgasmSeparate", "OrgasmSeparate")
	else
		UnregisterForModEvent("HookOrgasmStart")
		UnregisterForModEvent("HookAnimationEnd")
		UnregisterForModEvent("SexLabOrgasmSeparate")
	endif
	BaboAnimsSet()
	eventManager.Maintenance()
	(sr_inflateExternalEventManager as sr_inflateExternalEventController).RegisterModEvent()
	defAlias.Maintenance()
	bDeflateAnimation = false

	If previousState != "maintenance"
		GoToState(previousState)
	Else
		GoToState("")
	EndIf
EndFunction

;dhlp event handlers
Event OnDhlpSuspend( string eventName, string strArg, float numArg, Form sender )
	dhlpSuspend = True
EndEvent
Event OnDhlpResume( string eventName, string strArg, float numArg, Form sender )
	dhlpSuspend = False
EndEvent

event EggHatch()

Endevent

event FHUSexlabEnd(int tid, bool HasPlayer)
	Actor[] actors = sexlab.HookActors(tid)
	sslBaseAnimation anim = sexlab.HookAnimation(tid)
	
	Actor Victim = actors[0]
	actor Male = actors[1]
	log("Fill her up sex end")
	int iinjector = 0
	String injectorstring = ""
	if anim.hasTag("Vaginal");Do I need both vaginal and anal case?
		injectorstring = "sr.inflater.injector"
		iinjector = 1
	elseif anim.hasTag("Anal")
		injectorstring = "sr.inflater.analinjector"
		iinjector = 2
	endif
	
	
	If iinjector
		if HasPlayer
			int i = actors.length
			while i > 1
				i -= 1
				int raceintkey = GetCreatureRaceint(actors[i])
				if iinjector == 1;vaginal
					sr_InjectorFormlist.addform(actors[i])
					if raceintkey >= 4 && raceintkey <= 6
						if AddImpregnatedFaction(Player)
							RemoveSpermFromActor(player, 1, "Chaurus", false)
						endif
					endif
				else;anal
					FormListAdd(Victim, injectorstring, actors[i])
					if raceintkey >= 4 && raceintkey <= 6
						if AddImpregnatedAnalFaction(Player)
							RemoveSpermFromActor(player, 2, "Chaurus", false)
						endif
					endif
				endif
			endwhile
		else
			Actor[] injectorArray = new Actor[4]
			int i = 0
			while i < 4
				if i < (actors.length - 1)
					injectorArray[i] = actors[i + 1]
				endif
				i += 1
			endwhile
			FormListClear(Victim, injectorstring)
			i = 0
			while i < 4
				;WIP if chaurus, send event for NPC
				If injectorArray[i]
					FormListAdd(Victim, injectorstring, injectorArray[i])
				EndIf
				i += 1
			endwhile
			Debug.Notification(victim.GetLeveledActorBase().GetName() + " (NPC) took sperm from " + Male.GetLeveledActorBase().GetName())
		endif
	else
		log("No vaginal or anal fail")
	endif

	if IsTullAnimatedCreampieReady()
		GlobalVariable SLTTTMTiredTime = Game.GetFormFromFile(0x000804, "SLTooTiredToMove.esp") as GlobalVariable
		if SLTTTMTiredTime
			Utility.Wait(SLTTTMTiredTime.GetValue() + 2.0)
		else
			Utility.Wait(2.0)
		endif
		int i = actors.length
		while i > 0
			i -= 1
			Actor a = actors[i]
			if a && a.GetLeveledActorBase().GetSex() == 1
				Armor vagItem1 = GetTullAnimatedCreampieForm(0x00000801) as Armor
				Armor vagItem2 = GetTullAnimatedCreampieForm(0x00000807) as Armor
				Armor analItem = GetTullAnimatedCreampieForm(0x00000809) as Armor
				Armor oralItem = GetTullAnimatedCreampieForm(0x00000803) as Armor
				if !((vagItem1 && a.IsEquipped(vagItem1)) || (vagItem2 && a.IsEquipped(vagItem2)) || (analItem && a.IsEquipped(analItem)) || (oralItem && a.IsEquipped(oralItem)))
					if UpdateTullAnimatedCreampieCumItem(a, 1)
					else 
						UpdateTullAnimatedCreampieCumItem(a, 3)
					endif
				endif
				
			endif
		endWhile
	endif
endevent

Event OrgasmSeparate(Form ActorRef, Int Thread)
	actor akActor = ActorRef as actor
	
	Actor[] actors = sexlab.HookActors(thread)
	sslBaseAnimation anim = sexlab.HookAnimation(thread)
	SslThreadController threadContr = SexLab.GetController(thread)
	int Stage = threadContr.Stage
	
 	int pos = GetActorPositionFromList(actors, akActor)
    ;String stageTagsAll = GetStageTagsAsString(animation, Stage)
    String penetrationLabel = sr_HentairimUtils.PenetrationLabel(anim, Stage, pos)
    String oralLabel = sr_HentairimUtils.OralLabel(anim, Stage, pos)
    String stimulationLabel = sr_HentairimUtils.StimulationLabel(anim, Stage, pos)
    String penisActionLabel = sr_HentairimUtils.PenisActionLabel(anim, Stage, pos)
    String endingLabel = sr_HentairimUtils.EndingLabel(anim, Stage, pos)
    ;log(">>Penetration:" + penetrationLabel + ".Oral:" + oralLabel + ".Stimul:" + stimulationLabel + ".Penis:" + penisActionLabel + ".Ending:" + endingLabel  )
   	
	Bool inflateTrigger = false
	Bool legacyCondition = anim.hasTag("Vaginal") || anim.hasTag("Oral") || anim.hasTag("Anal") || anim.hasTag("Blowjob")
	Bool isCummedInside = false
	Bool isDP = false

    Bool isVaginalInside = true
    Bool isAnalInside = true
    Bool isOralInside= true

    if isAnimationHentairimTaggedStrings(penetrationLabel, oralLabel, stimulationLabel, endingLabel, penisActionLabel)
		logAndPrint(">>Actor:" + akActor.GetLeveledActorBase().GetName() + ":p[" + pos + "],s["+ stage + "]. Penetration:" + penetrationLabel + ".Oral:" + oralLabel + ".Stimul:" + stimulationLabel + ".Penis:" + penisActionLabel + ".Ending:" + endingLabel)
    	isVaginalInside = IsGivingVaginalPenetration(penisActionLabel) 
    	isAnalInside =  IsGivingAnalPenetration(penisActionLabel) 
    	isOralInside =  IsGettingSuckedoff(penisActionLabel)
		inflateTrigger = legacyCondition && (isVaginalInside || isAnalInside || isOralInside )
    Else
		logAndPrint(">>Actor:" + akActor.GetLeveledActorBase().GetName() + ":p[" + pos + "],s["+ stage + "]. No hentairim stage tags detected. Fallback to regular tags")
		inflateTrigger = legacyCondition
    endif

	If inflateTrigger
		If (!sexlab.config.allowFFCum && sexlab.MaleCount(actors) < 1 && sexlab.CreatureCount(actors) < 1)
			return
		EndIf
		
		int currentPool = 0
		If anim.hasTag("Vaginal") && isVaginalInside
			logAndPrint(">>(SLSO) Vaginal penetration detected.")
			currentPool = Math.LogicalOr(currentPool, VAGINAL)
		EndIf
		If anim.hasTag("Anal") && isAnalInside
			logAndPrint(">>(SLSO) Anal penetration detected")
			currentPool = Math.LogicalOr(currentPool, ANAL)
		EndIf
		If (anim.hasTag("Oral") || anim.hasTag("Blowjob")) && isOralInside
			logAndPrint(">>(SLSO) Oral penetration detected")
			currentPool = Math.LogicalOr(currentPool, ORAL)
			;Debug.notification("Oral " + currentPool as int)
		EndIf

		If currentPool == 0
			return
		EndIf
		
		String callback = ""
		int i = actors.length
		Actor[] cumSource = new Actor[1]
		cumSource[0] = akActor

		while i > 0
			i -= 1
			int cumSpot = anim.GetCum(i)
			int actorGender = sexlab.GetGender(actors[i])
		;	log(anim.name + " - cumSpot for position " + i + ": " + cumSpot)
			If akActor != actors[i]
				If ((actorGender == 1 && config.femaleEnabled) || (actorGender == 0 && config.maleEnabled)) && cumSpot != -1; && cumSpot != 2
					; only inflate if the actor is female (or male pretending to be female!) and the animation position has cum effect set for something else than oral only
					If actors[i] == player && sr_CumEffectsEnabled.GetValueInt() > 0
						dialogue.modMod(30)
						currentActors = cumSource
						currentType = currentPool
						RegisterForModEvent("fhu.playerInflated", "PlayerInflationDone")
						callback = "fhu.playerInflated"
					Else
						callback = ""
					EndIf
						int tid = QueueActor(actors[i], true, currentPool, GetCumAmountForActor(actors[i], cumSource), 3.0, callback)
						;sr_InjectorFormlist.addform(actors[i])
						if tid < 0
							warn("Inflaton slots full, skipping " + actors[i].GetLeveledActorBase().GetName() + "!")
						Else
							log(actors[i].GetLeveledActorBase().GetName() + " slotted to thread " + tid +".")
						EndIf
				EndIf
			EndIf
		EndWhile
		InflateQueued()
	EndIf
EndEvent

Event Orgasm(int thread, bool hasPlayer)
	Actor[] actors = sexlab.HookActors(thread)
	sslBaseAnimation anim = sexlab.HookAnimation(thread)
	If anim.hasTag("Vaginal") || anim.hasTag("Oral") || anim.hasTag("Anal") || anim.hasTag("Blowjob")
		If ( !sexlab.config.allowFFCum && sexlab.MaleCount(actors) < 1 && sexlab.CreatureCount(actors) < 1)
			return 
		EndIf
		
		int currentPool = 0
		If anim.hasTag("Vaginal")
			logAndPrint(">> Vaginal penetration detected.")
			currentPool = Math.LogicalOr(currentPool, VAGINAL)
		EndIf
		If anim.hasTag("Anal")
			logAndPrint(">> Anal penetration detected")
			currentPool = Math.LogicalOr(currentPool, ANAL)
		EndIf
		If anim.hasTag("Oral") || anim.hasTag("Blowjob")
			logAndPrint(">> Oral penetration detected")
			currentPool = Math.LogicalOr(currentPool, ORAL)
			;Debug.notification("Oral " + currentPool as int)
		EndIf
		
		String callback = ""
		int i = actors.length
		while i > 0
			i -= 1
			int cumSpot = anim.GetCum(i)
			int actorGender = sexlab.GetGender(actors[i])
		;	log(anim.name + " - cumSpot for position " + i + ": " + cumSpot)
			If ((actorGender == 1 && config.femaleEnabled) || (actorGender == 0 && config.maleEnabled)) && cumSpot != -1; && cumSpot != 2
				; only inflate if the actor is female (or male pretending to be female!) and the animation position has cum effect set for something else than oral only
				If actors[i] == player && sr_CumEffectsEnabled.GetValueInt() > 0
					dialogue.modMod(30)
					currentActors = actors
					currentType = currentPool
					RegisterForModEvent("fhu.playerInflated", "PlayerInflationDone")
					callback = "fhu.playerInflated"
				Else
					callback = ""
				EndIf
				int tid = QueueActor(actors[i], true, currentPool, GetCumAmountForActor(actors[i], actors), 3.0, callback)
				if tid < 0
					warn("Inflaton slots full, skipping " + actors[i].GetLeveledActorBase().GetName() + "!")
				Else
					log(actors[i].GetLeveledActorBase().GetName() + " slotted to thread " + tid +".")
				EndIf
			EndIf
		EndWhile
		InflateQueued()
	EndIf
EndEvent

bool Function UpdateFHUmoan(ObjectReference aksource, int cumType)
	Actor DeflateActor = aksource as Actor
	If !DeflateActor
		return false
	EndIf
	MfgConsoleFuncExt.ResetMfg(DeflateActor)
	EmotionWhenLeakage(DeflateActor)
	bool needUpdate = false
	if DeflateActor.isinfaction(inflaterAnimatingFaction)
		needUpdate = true
		if cumType < 3
			if GetInflationPercentage(DeflateActor) < 50
				FHUmoanSoundEffect(aksource, 1, cumType)
			else
				FHUmoanSoundEffect(aksource, 2, cumType)
			endif
			MouthOpen(DeflateActor, 0)
		elseif cumType == 3
			MouthOpen(DeflateActor, 0)
			if GetOralPercentage(DeflateActor) < 50
				FHUmoanSoundEffect(aksource, 1, cumType)
			else
				FHUmoanSoundEffect(aksource, 2, cumType)
			endif
		endif
	else
		FHUmoanSoundAfterEffect(aksource, 0, cumType)
		MouthOpen(DeflateActor, 5)
	endif
	return needUpdate
EndFunction

Function FHUmoanSoundEffect(ObjectReference aksource, int type, int CumType); looping
{type 1 = mild, type 2 = hard, type 3 = deflation fail}
;log("FHUmoanSoundEffect for " + aksource + " " +sr_MoanSound.getvalue())
if sr_MoanSound.getvalue() == 1
	;if aksource == Player as objectreference && type < 3
	;DeflateActor = aksource as actor
	;RegisterFHUUpdate()
	;endif
	;MoanType = Type
	if sr_SexlabMoanSound.getvalue() == 1
		if type == 1
			UseSexlabVoice(aksource as actor, 50, true)
		elseif type == 2
			UseSexlabVoice(aksource as actor, 90, true)
		elseif type == 3;deflate fail
			UseSexlabVoice(aksource as actor, 50, true)
		else
			UseSexlabVoice(aksource as actor, 40, false)
		endif
	else
		if CumType == 1;Vaginal
			if type == 1
				sr_FHUCumDeflationVaginalMildMarker.play(aksource)
				log("FHUmoanSoundEffect Vaginal 1 " + aksource)
			elseif type == 2
				sr_FHUCumDeflationVaginalHardMarker.play(aksource)
				log("FHUmoanSoundEffect Vaginal 2 " + aksource)
			else
				sr_FHUMoanDenialMarker.play(aksource)
				log("FHUmoanSoundEffect Vaginal 3 " + aksource)
			endif
			;sr_FHUMoanMildMarker.play(aksource);No longer used. Save it for another update. Burst effect maybe
		elseif CumType == 2
			;sr_FHUMoanHardMarker.play(aksource);No longer used. Save it for another update. Burst effect maybe
			if type == 1
				sr_FHUCumDeflationAnalMildMarker.play(aksource)
				log("FHUmoanSoundEffect Anal 1 " + aksource)
			elseif type == 2
				sr_FHUCumDeflationAnalHardMarker.play(aksource)
				log("FHUmoanSoundEffect Anal 2 " + aksource)
			else
				sr_FHUMoanDenialMarker.play(aksource)
				log("FHUmoanSoundEffect Anal 3 " + aksource)
			endif
		elseif CumType == 3
			;sr_FHUMoanOralMarker.play(aksource)
			if type == 1
				sr_FHUCumDeflationOralMarker.play(aksource)
				log("FHUmoanSoundEffect Oral 1 " + aksource)
			elseif type == 2
				sr_FHUCumDeflationOralMarker.play(aksource)
				log("FHUmoanSoundEffect Oral 2 " + aksource)
			else
				sr_FHUCumDeflationOralFailMarker.play(aksource)
				log("FHUmoanSoundEffect Oral 3 " + aksource)
			endif
		endif
	endif
endif
EndFunction

Function FHUmoanSoundAfterEffect(ObjectReference aksource, int type, int CumType);No loop
if sr_MoanSound.getvalue() == 1
	if sr_SexlabMoanSound.getvalue() == 1
		;Nothing
	else
		if CumType == 3
			sr_FHUCumDeflationOralAfterMarker.play(aksource)
		endif
	endif
endif

Utility.wait(6.0)
MfgConsoleFuncExt.ResetMfg(aksource as Actor)
EndFunction

Function UseSexlabVoice(actor ActorRef, int Strength, bool isvictim)
	sslBaseVoice voice = SexLab.GetVoice(ActorRef)
	voice.PlayMoan(ActorRef, Strength, isvictim, true)
EndFunction

float Function GetCumAmountForActor(Actor a, Actor[] all)
	float tot = 0.0
	int i = all.length
	Actor current = none
	while i > 0
		i -= 1
		current = all[i]
		If current != a && current.haskeyword(ActortypeNPC) && ( sexlab.GetGender(current) != 1 || sexlab.config.AllowFFCum )
			tot += (GetFloatValue(current.GetLeveledActorBase().GetRace(), RACE_CUM_AMOUNT, 0.75) * cumMult)
		Elseif current != a && !current.haskeyword(ActortypeNPC) && ( sexlab.GetGender(current) != 1 || sexlab.config.AllowFFCum )
			tot += VerifyRace(current)
		EndIf
	endWhile
	return tot
EndFunction

String Function GetCreatureRaceKey(Actor Target)
        String RaceKey = sslCreatureAnimationSlots.GetRaceKey(Target.GetLeveledActorBase().GetRace())
        if RaceKey
                Return RaceKey
        endif
EndFunction

int Function GetRaceIndex(string RaceName)
        if RaceName == "Ashhoppers"
                return 0
        elseIf RaceName == "Bears"
                return 1
        elseIf RaceName == "Boars" || RaceName == "BoarsAny" || RaceName == "BoarsMounted"
                return 2
        elseIf RaceName == "Canines" || RaceName == "Wolf" || RaceName == "Wolves" ; https://www.loverslab.com/topic/156185-fill-her-up-baka-edition/page/57/#findComment-4238590
                return 3
        elseIf RaceName == "Chaurus"
                return 4
        elseIf RaceName == "ChaurusHunters"
                return 5
        elseIf RaceName == "ChaurusReapers"
                return 6
        elseIf RaceName == "Chickens"
                return 7
        elseIf RaceName == "Cows"
                return 8
        elseIf RaceName == "Deers"
                return 9
        elseIf RaceName == "Dogs"
                return 10
        elseIf RaceName == "DragonPriests"
                return 11
        elseIf RaceName == "Dragons"
                return 12
        elseIf RaceName == "Draugrs"
                return 13
        elseIf RaceName == "DwarvenBallistas"
                return 14
        elseIf RaceName == "DwarvenCenturions"
                return 15
        elseIf RaceName == "DwarvenSpheres"
                return 16
        elseIf RaceName == "DwarvenSpiders"
                return 17
        elseIf RaceName == "Falmers"
                return 18
        elseIf RaceName == "FlameAtronach"
                return 19
        elseIf RaceName == "Foxes"
                return 20
        elseIf RaceName == "FrostAtronach"
                return 21
        elseIf RaceName == "Gargoyles"
                return 22
        elseIf RaceName == "Giants"
                return 23
        elseIf RaceName == "Goats"
                return 24
        elseIf RaceName == "Hagravens"
                return 25
        elseIf RaceName == "Horkers"
                return 26
        elseIf RaceName == "Horses"
                return 27
        elseIf RaceName == "IceWraiths"
                return 28
        elseIf RaceName == "Lurkers"
                return 29
        elseIf RaceName == "Mammoths"
                return 30
        elseIf RaceName == "Mudcrabs"
                return 31
        elseIf RaceName == "Netches"
                return 32
        elseIf RaceName == "Rabbits"
                return 33
        elseIf RaceName == "Rieklings"
                return 34
        elseIf RaceName == "SabreCats"
                return 35
        elseIf RaceName == "Seekers"
                return 36
        elseIf RaceName == "Skeevers"
                return 37
        elseIf RaceName == "Slaughterfishes"
                return 38
        elseIf RaceName == "StormAtronach"
                return 39
        elseIf RaceName == "Spiders"
                return 40
        elseIf RaceName == "LargeSpiders"
                return 41
        elseIf RaceName == "GiantSpiders"
                return 42
        elseIf RaceName == "Spriggans"
                return 43
        elseIf RaceName == "Trolls"
                return 44
        elseIf RaceName == "VampireLords"
                return 45
        elseIf RaceName == "Werewolves"
                return 46
        elseIf RaceName == "WispMothers" || RaceName == "Wisps"
                return 47
        endif
        return -1
EndFunction

int Function GetCreatureRaceint(Actor Target)
        ;humans don't have a RaceName string so it has to be checked first
        if Target.HasKeyword(ActorTypeNPC)
                return -1
        endif

        String RaceName = sslCreatureAnimationSlots.GetRaceKey(Target.GetLeveledActorBase().GetRace())
        ;log(RaceName + " get registered in Fill Her Up")
        return GetRaceIndex(RaceName)
EndFunction

Float Function VerifyRace(Actor CreatureActor)
String RaceName = GetCreatureRaceKey(CreatureActor)
float CreatureCumAmount = 0
        int idx = GetRaceIndex(RaceName)
        if idx >= 0
                CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(idx) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
        endif
Return CreatureCumAmount
EndFunction

Function InflateTo(Actor akActor, int h, float targetLevel = -1.0, float time = 2.0, String callback = "")
	if targetLevel <= 0.0
		targetLevel = config.maxInflation
	endIf
	float amount = targetLevel
	int poolMask = 0
	If h == 1
		amount -= GetVaginalCum(akActor)
		poolMask = Math.LogicalOr(poolMask, VAGINAL)
	ElseIf h == 2
		amount -= GetAnalCum(akActor)
		poolMask = Math.LogicalOr(poolMask, ANAL)
	ElseIf h == 3
		amount -= GetOralCum(akActor)
		poolMask = Math.LogicalOr(poolMask, ORAL)
	EndIf
	QueueActor(akActor, true, poolMask, targetLevel, time, callback)
	InflateQueued()
EndFunction

Function InflateDeflate(Actor akActor, Bool Inflation, int poolMask, float targetLevel = -1.0, float time, String callback = "")
	if targetLevel <= 0.0
		targetLevel = config.maxInflation
	endIf
	QueueActor(akActor, Inflation, poolMask, targetLevel, time, callback)
	InflateQueued()
EndFunction

Function Absorbto(Actor akActor, int poolMask, float targetLevel = -1.0, float time, String callback = "")
	if targetLevel <= 0.0
		targetLevel = config.maxInflation
	endIf
	QueueAbsorbActor(akActor, false, poolmask, targetLevel, time, callback)
	AbsorptionQueued()
EndFunction

Function RemoveSpermFromActor(actor akactor, int type = 1, String ReserveRace = "", bool bEvent = false)
int i
	if type == 1
		If akactor == player
			i = sr_InjectorFormlist.getsize()
		Else
			i = FormListCount(akactor, "sr.inflater.injector")
		EndIf
	elseif type == 2
		i = FormListCount(akactor,  "sr.inflater.analinjector")
	endif
	
	if i > 0
		int randomi = Utility.randomint(0, i - 1)
		actor injector
		if type == 1
			If akactor == player
				injector = sr_InjectorFormlist.getat(randomi) as Actor
			else
				injector = FormListGet(akactor, "sr.inflater.injector", randomi) as Actor
			endif
		elseif type == 2
			injector = FormListGet(akactor, "sr.inflater.analinjector", randomi) as Actor
		endif

		int actori = GetCreatureRaceint(injector)
		if ReserveRace == "Chaurus" && (actori >= 4 && actori <= 6)
			if type == 1
				if !akactor.isinfaction(sr_Impregnated)
					If akactor == player
						bPlayerImpregnated = true
					endif
					akactor.addtofaction(sr_Impregnated)
					return
				endif
				if bevent
					if akactor.getfactionrank(sr_Impregnated) == 0
						akactor.setfactionrank(sr_Impregnated, 1);hatched
						EggHatchEffect(akactor)
					elseif akactor.getfactionrank(sr_Impregnated) == 1
						InflateDeflate(akactor, true, type, 0.5, 0.2, "")
						RubStomach(akactor)
					endif
				endif
				;Feel something in my belly message fire
			elseif type == 2
				if !akactor.isinfaction(sr_Impregnatedanal)
					If akactor == player
						bPlayerImpregnatedAnal = true
					endif
					akactor.addtofaction(sr_Impregnatedanal)
				endif
				if bevent
					if akactor.getfactionrank(sr_Impregnatedanal) == 0
						akactor.setfactionrank(sr_Impregnatedanal, 1);hatched
						EggHatchEffect(akactor)
					elseif akactor.getfactionrank(sr_Impregnatedanal) == 1
						InflateDeflate(akactor, true, type, 0.5, 0.2, "")
						RubStomach(akactor)
					endif
				endif
				;Feel something in my belly message fire
			endif
			return
		elseif ReserveRace == "Chaurus" && (actori < 4 || actori > 6)
			if type == 1
				If akactor == player
					sr_InjectorFormlist.RemoveAddedForm(injector)
				else
					FormListRemove(akactor, "sr.inflater.injector", injector)
				endif
			elseif type == 2
				FormListRemove(akactor, "sr.inflater.analinjector", injector)
			endif
		endif

	endif

EndFunction

Int Function GetSpermLastActor(actor akactor, int type = 1)
	;type == 1 vaginal type == 2 anal 
	form MaleForm
	Actor Male
	race malerace
	float chaurusnum = 0
	float spidernum = 0
	float humannum = 0
	float ashHoppernum = 0
	float Draugrnum = 0
	float Spriggannum = 0
	float StoneAtronachnum = 0
	float FlameAtronachnum = 0
	float FrostAtronachnum = 0
	float sr_Deathwormnum = 0
	float sr_Mimicnum = 0
	float beastcumnum = 0
	float RaceAmount
	int actori = -1
	int spermtype = 0
	string stringinjector
	int i

	if type == 1
		stringinjector = "sr.inflater.injector"
		If akactor == player
			i = sr_InjectorFormlist.getsize()
		Else
			i = FormListCount(akactor, stringinjector)
		EndIf
	elseif type == 2
		stringinjector = "sr.inflater.analinjector"
		i = FormListCount(akactor, stringinjector)
	endif
	
	while i > 0
		i -= 1
		If akactor == player && type == 1
			MaleForm = sr_InjectorFormlist.getat(i)
		Else
			MaleForm = FormListGet(akactor, stringinjector, i)
		EndIf

		Male = MaleForm as Actor
		if Male
			actori = GetCreatureRaceint(Male as actor)
            if actori == -1
				humannum += 0.5
			elseif actori == 0
				ashHoppernum += GetFloatValue(sr_CreatureRaceList.getat(actori) as race, CREATURERACE_CUM_AMOUNT, 0.75)
			elseif actori == 4
				chaurusnum += GetFloatValue(sr_CreatureRaceList.getat(actori) as race, CREATURERACE_CUM_AMOUNT, 0.75)
			elseif actori == 5
				chaurusnum += GetFloatValue(sr_CreatureRaceList.getat(actori) as race, CREATURERACE_CUM_AMOUNT, 0.75)
			elseif actori == 6
				chaurusnum += GetFloatValue(sr_CreatureRaceList.getat(actori) as race, CREATURERACE_CUM_AMOUNT, 0.75)
			elseif actori == 13
				Draugrnum += GetFloatValue(sr_CreatureRaceList.getat(actori) as race, CREATURERACE_CUM_AMOUNT, 0.75)
			elseif actori == 19
				FlameAtronachnum += GetFloatValue(sr_CreatureRaceList.getat(actori) as race, CREATURERACE_CUM_AMOUNT, 0.75)
			elseif actori == 21
				FrostAtronachnum += GetFloatValue(sr_CreatureRaceList.getat(actori) as race, CREATURERACE_CUM_AMOUNT, 0.75)
			elseif actori == 39
				StoneAtronachnum += GetFloatValue(sr_CreatureRaceList.getat(actori) as race, CREATURERACE_CUM_AMOUNT, 0.75)
			elseif actori == 40
				spidernum += GetFloatValue(sr_CreatureRaceList.getat(actori) as race, CREATURERACE_CUM_AMOUNT, 0.75)
			elseif actori == 41
				spidernum += GetFloatValue(sr_CreatureRaceList.getat(actori) as race, CREATURERACE_CUM_AMOUNT, 0.75)
			elseif actori == 42
				spidernum += GetFloatValue(sr_CreatureRaceList.getat(actori) as race, CREATURERACE_CUM_AMOUNT, 0.75)
			elseif actori == 43
				Spriggannum += GetFloatValue(sr_CreatureRaceList.getat(actori) as race, CREATURERACE_CUM_AMOUNT, 0.75)
			;elseif actori == 48
			;	sr_Deathwormnum += GetFloatValue(sr_CreatureRaceList.getat(actori) as race, CREATURERACE_CUM_AMOUNT, 0.75);WIP
			;elseif actori == 49
			;	sr_Mimicnum += GetFloatValue(sr_CreatureRaceList.getat(actori) as race, CREATURERACE_CUM_AMOUNT, 0.75)
			else
				beastcumnum += 1
			endif
		else
			If akactor == player && type == 1
				sr_InjectorFormlist.RemoveAddedForm(MaleForm)
			EndIf
		endif
	endwhile

	RaceAmount = chaurusnum + Draugrnum + spidernum + humannum + ashHoppernum + beastcumnum + Spriggannum + StoneAtronachnum + FlameAtronachnum + FrostAtronachnum
	float RandomSperm = Utility.randomfloat(0, RaceAmount)

	if RandomSperm > 0
		if RandomSperm <= humannum
			spermtype = 0;human
		elseif RandomSperm <= humannum + beastcumnum
			spermtype = 1;beastcum
		elseif RandomSperm <= humannum + beastcumnum + Draugrnum
			spermtype = 2;dragur
		elseif RandomSperm <= humannum + beastcumnum + Draugrnum + spidernum
			spermtype = 3;spider
		elseif RandomSperm <= humannum + beastcumnum + Draugrnum + spidernum + chaurusnum
			spermtype = 4;Chaurus
		elseif RandomSperm <= humannum + beastcumnum + Draugrnum + spidernum + chaurusnum + Spriggannum
			spermtype = 5;Spriggan
		elseif RandomSperm <= humannum + beastcumnum + Draugrnum + spidernum + chaurusnum + Spriggannum + StoneAtronachnum
			spermtype = 6;StoneAtronach
		elseif RandomSperm <= humannum + beastcumnum + Draugrnum + spidernum + chaurusnum + Spriggannum + StoneAtronachnum + ashHoppernum
			spermtype = 7;ashHopper
		elseif RandomSperm <= humannum + beastcumnum + Draugrnum + spidernum + chaurusnum + Spriggannum + StoneAtronachnum + ashHoppernum + FlameAtronachnum
			spermtype = 8;FlameAtronach
		elseif RandomSperm <= humannum + beastcumnum + Draugrnum + spidernum + chaurusnum + Spriggannum + StoneAtronachnum + ashHoppernum + FlameAtronachnum + FrostAtronachnum
			spermtype = 9;FrostAtronach
		endif
	else
		spermtype = 0
	endif
	akactor.setfactionrank(sr_DARAnimatingType, spermtype)
	return spermtype
EndFunction

;0human
;1;beastcum
;2;dragur
;3;spider
;4;Chaurus
;5;Spriggan
;6;StoneAtronach
;7;ashHopper
;8;FlameAtronach
;9;FrostAtronach

Function EquiprandomTongue(actor akActor, Bool BEquip)
	if BEquip
		int Tongueri = Utility.RandomInt(1, 10)
		if Tongueri == 1
			akActor.addItem(sr_linga1armor, 1, true)
			akActor.equipItem(sr_linga1armor, abSilent=true)
			FormListAdd(akActor, "sr.inflater.equipped_tongue", sr_linga1armor)
		elseif Tongueri == 2
			akActor.addItem(sr_linga2armor, 1, true)
			akActor.equipItem(sr_linga2armor, abSilent=true)
			FormListAdd(akActor, "sr.inflater.equipped_tongue", sr_linga2armor)
		elseif Tongueri == 3
			akActor.addItem(sr_linga3armor, 1, true)
			akActor.equipItem(sr_linga3armor, abSilent=true)
			FormListAdd(akActor, "sr.inflater.equipped_tongue", sr_linga3armor)
		elseif Tongueri == 4
			akActor.addItem(sr_linga4armor, 1, true)
			akActor.equipItem(sr_linga4armor, abSilent=true)
			FormListAdd(akActor, "sr.inflater.equipped_tongue", sr_linga4armor)
		elseif Tongueri == 5
			akActor.addItem(sr_linga5armor, 1, true)
			akActor.equipItem(sr_linga5armor, abSilent=true)
			FormListAdd(akActor, "sr.inflater.equipped_tongue", sr_linga5armor)
		elseif Tongueri == 6
			akActor.addItem(sr_linga6armor, 1, true)
			akActor.equipItem(sr_linga6armor, abSilent=true)
			FormListAdd(akActor, "sr.inflater.equipped_tongue", sr_linga6armor)
		elseif Tongueri == 7
			akActor.addItem(sr_linga7armor, 1, true)
			akActor.equipItem(sr_linga7armor, abSilent=true)
			FormListAdd(akActor, "sr.inflater.equipped_tongue", sr_linga7armor)
		elseif Tongueri == 8
			akActor.addItem(sr_linga8armor, 1, true)
			akActor.equipItem(sr_linga8armor, abSilent=true)
			FormListAdd(akActor, "sr.inflater.equipped_tongue", sr_linga8armor)
		elseif Tongueri == 9
			akActor.addItem(sr_linga9armor, 1, true)
			akActor.equipItem(sr_linga9armor, abSilent=true)
			FormListAdd(akActor, "sr.inflater.equipped_tongue", sr_linga9armor)
		elseif Tongueri == 10
			akActor.addItem(sr_linga10armor, 1, true)
			akActor.equipItem(sr_linga10armor, abSilent=true)
			FormListAdd(akActor, "sr.inflater.equipped_tongue", sr_linga10armor)
		endif
	else
		int i = FormListCount(akActor, "sr.inflater.equipped_tongue")
		while(i > 0)
			i -= 1
			Armor aTongue = FormListGet(akActor, "sr.inflater.equipped_tongue", i) as Armor
			akActor.unequipItem(aTongue, abSilent=true)
			akActor.removeItem(aTongue, 99, true)
		endwhile
		FormListClear(akActor, "sr.inflater.equipped_tongue")
	endif
EndFunction

Function EquipLeak(Actor akActor, Armor leak)
	Armor curr_armor = akActor.GetWornForm(leak.GetSlotMask()) as Armor
	if curr_armor && SexLabUtil.HasKeywordSub(curr_armor, "NoStrip")
		return
	endif
	If curr_armor
		log("EquipLeak "+leak+" for " + akActor.GetLeveledActorBase().GetName() + " replace armor " + curr_armor)
		FormListAdd(akActor, "sr.inflater.unequipped", curr_armor)
	Else	
		log("EquipLeak "+leak+" for " + akActor.GetLeveledActorBase().GetName())
	EndIf
	akActor.addItem(leak, 1, true)
	Utility.Wait(0.2)
	akActor.equipItem(leak, abSilent=true)
	FormListAdd(akActor, "sr.inflater.equipped_leak", leak)
EndFunction

Function StartLeakageSoundEffect(Actor akActor, int CumType)
	if CumType < 3
		if GetInflationPercentage(akactor) < 50
			FHUmoanSoundEffect(akActor as ObjectReference, 1, CumType)
		else
			FHUmoanSoundEffect(akActor as ObjectReference, 2, CumType)
		endif
	elseif CumType == 3
		if GetOralPercentage(akactor) < 50
			FHUmoanSoundEffect(akActor as ObjectReference, 1, CumType)
		else
			FHUmoanSoundEffect(akActor as ObjectReference, 2, CumType)
		endif
	endif
EndFunction


Function StartLeakageAddCum(Actor akActor, int CumType)
	If CumType == 1
		sexlab.AddCum(akActor, true, false, false)
	elseif CumType == 2
		sexlab.AddCum(akActor, false, false, true)
	elseif CumType == 3
		sexlab.AddCum(akActor, false, true, false)
	else
		sexlab.AddCum(akActor)
	endif
EndFunction

Function StartLeakageEmotionAndTongue(Actor akActor, int CumType)
	FormListClear(akActor, "sr.inflater.equipped_tongue")
	MfgConsoleFuncExt.ResetMfg(akActor)
	If Utility.RandomInt(0, 99) < 40 && sr_TongueEffect.getvalue() == 1
		EquiprandomTongue(akactor, true)
	EndIf
	EmotionWhenLeakage(akActor)
	MouthOpen(akActor, 0)
EndFunction

Function StartLeakageApplyPuddle(Actor akActor, int CumType)
	if (config.SFU_PlacePuddles)
		if Cumtype < 3
			ApplyPuddle(akActor, 0, 0, 1)
		elseif Cumtype == 3;oral
			ApplyPuddle(akActor, 26, 0, 1)
		endif
	endif
EndFunction

; SetIntValue(akActor, ANIMATING, [VALUE])
; ANIMATING = -1 -> NoAnim + NoTongue + NoEmotion
; ANIMATING = 0 -> NoAnim + Tongue + Emotion
; ANIMATING = 1 -> NoAnim + Tongue + Emotion
Function StartLeakage(Actor akActor, int CumType, int animate)
	bool isAnal
	if Cumtype == 2
		isAnal = true
	else
		isAnal = false
	endif

	If !akActor.Is3DLoaded()
	;	log("Skipping animation for " + akActor.GetLeveledActorBase().GetName())
		SetIntValue(akActor, ANIMATING, -1)
		SetIntValue(akActor, ANIMATING_SPERMTYPE, GetSpermLastActor(akActor, CumType))
		return
	EndIf
;	log("Starting animation for " + akActor.GetLeveledActorBase().GetName())

	If !config.animDeflate
		StartLeakageSoundEffect(akActor, CumType)
		SetIntValue(akActor, ANIMATING, -1)
		SetIntValue(akActor, ANIMATING_SPERMTYPE, GetSpermLastActor(akActor, CumType))
		return
	EndIf
	
	if animate < 0
		StartLeakageSoundEffect(akActor, CumType)
		StartLeakageEmotionAndTongue(akActor, CumType)
		StartLeakageAddCum(akActor, CumType)
		SetIntValue(akActor, ANIMATING, 0)
		SetIntValue(akActor, ANIMATING_SPERMTYPE, GetSpermLastActor(akActor, CumType))
		return
	endIf

	If akActor.IsInCombat() || isAnimating(akActor)
		StartLeakageSoundEffect(akActor, CumType)
		StartLeakageEmotionAndTongue(akActor, CumType)
		StartLeakageAddCum(akActor, CumType)
		StartLeakageApplyPuddle(akActor, CumType)
		SetIntValue(akActor, ANIMATING, 0)
		SetIntValue(akActor, ANIMATING_SPERMTYPE, GetSpermLastActor(akActor, CumType))
		log("StartLeakage Animation blocked for " + akActor.GetLeveledActorBase().GetName())
		return
	EndIf

	bool isStripArmorExpected = false
	Armor leak1ForEquip = None
	Armor leak2ForEquip = None
	int animnum = 0
	int spermtype = GetSpermLastActor(akActor, CumType)
	SetIntValue(akActor, ANIMATING_SPERMTYPE, spermtype)

	log("StartLeakage for " + akActor.GetLeveledActorBase().GetName() + "; animate:" + animate + "; CumType: " + CumType + "; spermtype: " + spermtype)

	If animate == 2
		; Burst deflate 
	;	log("	burst deflate")
		SetIntValue(akActor, ANIMATING, 2)
		int handle
		If akActor == player
			Game.ForceThirdPerson()
			handle = ModEvent.Create("dhlp-weapondrop")
			ModEvent.PushBool(handle, true)
			ModEvent.PushFloat(handle, 1.5)
			ModEvent.PushString(handle, "$FHU_BURST_WEAPON_DROP")
			ModEvent.PushString(handle, "$FHU_BURST_SPELL_DROP")
			If animate >= 10
				TryPlayIdle(akactor, BaboAnimsStart[animate - 10])
			Else
				animnum = Utility.RandomInt(0, BaboAnimsStart.length - 1)
				TryPlayIdle(akactor, BaboAnimsStart[animnum])
			EndIf
		EndIf 
		if CumType == 1
			EquipLeak(akActor, sr_VagLeak)
		elseif CumType == 2
			EquipLeak(akActor, sr_AnalLeak)
		elseif CumType == 3
			EquipLeak(akActor, sr_OralLeak)
		EndIf
		If akActor == player
			If ModEvent.Send(handle)
				Utility.Wait(1.2)
			EndIf
		EndIf
		;Debug.SendAnimationEvent(akActor, "BleedOutStart");WIP need animation
	ElseIf animate == 1 || (animate == 0 && Utility.RandomInt(0, 99) < 80) || animate >= 10
		; normal, less-violent deflate 
		;	log("	normal deflate")

		SetIntValue(akActor, ANIMATING, 1)
		if akActor == player
			Game.ForceThirdPerson()
			if config.bgamepad
				Input.TapKey(Input.GetMappedKey("Forward", 0x02)); Need Test WIP
			else
				Input.TapKey(Input.GetMappedKey("Forward"))
			endif
			Game.DisablePlayerControls()
		Else
			ActorUtil.AddPackageOverride(akActor, stayStillPackage, 100, 1)
			akActor.EvaluatePackage()
			akActor.SetRestrained(true)
			akActor.SetDontMove(true)
			akActor.StopTranslation()
			(akActor as ObjectReference).SetAnimationVariableInt("IsNPC", 0)
		EndIf

		If akActor.IsWeaponDrawn()
			akActor.SheatheWeapon()
			int attempts = 10
			While attempts > 0 && akActor.IsWeaponDrawn()
				attempts -= 1
				Utility.Wait(0.2)
			EndWhile
		EndIf

		If animate >= 10
			TryPlayIdle(akactor, BaboAnimsStart[animate - 10])
		Else
			if spermtype == 0
				if CumType == 1
					animnum = Utility.RandomInt(0, BaboAnimsStart.length - 1)
					TryPlayIdle(akactor, BaboAnimsStart[animnum])
					leak1ForEquip = sr_VagLeak
				elseif CumType == 2
					animnum = Utility.RandomInt(0, BaboAnimsAnusStart.length - 1)
					TryPlayIdle(akactor, BaboAnimsAnusStart[animnum])
					leak1ForEquip = sr_AnalLeak
				elseif CumType == 3
					;animnum = Utility.RandomInt(0, BaboAnimsOral.length - 1)
					;TryPlayIdle(akactor, BaboAnimsOral[animnum])
					TryPlayIdle(akactor, BaboAnimsOralStart[0])
					leak1ForEquip = sr_OralLeak
				endif
			elseif spermtype == 1;BeastCum
				if CumType == 1
					animnum = Utility.RandomInt(0, BaboAnimsStart.length - 1)
					TryPlayIdle(akactor, BaboAnimsStart[animnum])
					leak1ForEquip = sr_vagLeakBeast
				elseif CumType == 2
					animnum = Utility.RandomInt(0, BaboAnimsAnusStart.length - 1)
					TryPlayIdle(akactor, BaboAnimsAnusStart[animnum])
					leak1ForEquip = sr_analLeakBeast
				elseif CumType == 3
					;animnum = Utility.RandomInt(0, BaboAnimsOral.length - 1)
					;TryPlayIdle(akactor, BaboAnimsOral[animnum])
					TryPlayIdle(akactor, BaboAnimsOralStart[0])
					leak1ForEquip = sr_OralLeakBeast
				endif
				if sr_Cumvariation.getvalue() == 1
					if GetInflation(akactor) > 3.0 && CumType < 3
						leak2ForEquip = sr_ThickCum
					elseif GetOralCum(akactor) > 1.0 && CumType == 3
						leak2ForEquip = sr_ThickCum
					endif
				endif
			elseif spermtype == 2;dragur
				if CumType == 1
					animnum = Utility.RandomInt(0, BaboAnimsStart.length - 1)
					TryPlayIdle(akactor, BaboAnimsStart[animnum])
					leak1ForEquip = sr_vagLeakRotten
				elseif CumType == 2
					animnum = Utility.RandomInt(0, BaboAnimsAnusStart.length - 1)
					TryPlayIdle(akactor, BaboAnimsAnusStart[animnum])
					leak1ForEquip = sr_analLeakRotten
				elseif CumType == 3
					;animnum = Utility.RandomInt(0, BaboAnimsOral.length - 1)
					;TryPlayIdle(akactor, BaboAnimsOral[animnum])
					TryPlayIdle(akactor, BaboAnimsOralStart[0])
					leak1ForEquip = sr_OralLeakRotten
				endif
			elseif spermtype == 3;Spider
				if CumType == 1
					animnum = 3
					TryPlayIdle(akactor, BaboAnimsStart[animnum])
					leak1ForEquip = sr_VagLeak
				elseif CumType == 2
					animnum = Utility.RandomInt(0, BaboAnimsAnusStart.length - 1)
					TryPlayIdle(akactor, BaboAnimsAnusStart[animnum])
					leak1ForEquip = sr_AnalLeak
				elseif CumType == 3
					;animnum = Utility.RandomInt(0, BaboAnimsOral.length - 1)
					;TryPlayIdle(akactor, BaboAnimsOral[animnum])
					TryPlayIdle(akactor, BaboAnimsOralStart[0])
					leak1ForEquip = sr_OralLeak
				endif
				if sr_Cumvariation.getvalue() == 1
					leak2ForEquip = sr_SpiderEggs
				endif
			elseif spermtype == 4;Chaurus
				if CumType == 1
					animnum = 3
					TryPlayIdle(akactor, BaboAnimsStart[animnum])
					leak1ForEquip = sr_VagLeak
				elseif CumType == 2
					animnum = Utility.RandomInt(0, BaboAnimsAnusStart.length - 1)
					TryPlayIdle(akactor, BaboAnimsAnusStart[animnum])
					leak1ForEquip = sr_AnalLeak
				elseif CumType == 3
					TryPlayIdle(akactor, BaboAnimsOralStart[0])
					leak1ForEquip = sr_OralLeak
				endif
				if sr_Cumvariation.getvalue() == 1
					;if GetInflation(akactor) >= 3.0 && CumType < 3;WIP Larva hatches after few days later
					;	EquipLeak(akActor, sr_ChaurusLarvaeEggs)
					;elseif GetInflation(akactor) < 3.0 && CumType < 3
					;	EquipLeak(akActor, sr_ChaurusEggs)
					;elseif CumType == 3
					;	EquipLeak(akActor, sr_ChaurusEggs)
					;endif
					if CumType == 1
						if akActor.getfactionrank(sr_Impregnated) == 1
							leak2ForEquip = sr_ChaurusLarvaeEggs
						else
							leak2ForEquip = sr_ChaurusEggs
						endif
					elseif CumType == 2
						if akActor.getfactionrank(sr_Impregnatedanal) == 1
							leak2ForEquip = sr_ChaurusLarvaeEggs
						else
							leak2ForEquip = sr_ChaurusEggs
						endif
					elseif CumType == 3
						leak2ForEquip = sr_ChaurusEggs
					endif
				endif
			elseif spermtype == 5;Spriggan
				if CumType == 1
					animnum = 3
					TryPlayIdle(akactor, BaboAnimsStart[animnum])
					leak1ForEquip = sr_vagLeakGreen
				elseif CumType == 2
					animnum = Utility.RandomInt(0, BaboAnimsAnusStart.length - 1)
					TryPlayIdle(akactor, BaboAnimsAnusStart[animnum])
					leak1ForEquip = sr_analLeakGreen
				elseif CumType == 3
					;animnum = Utility.RandomInt(0, BaboAnimsOral.length - 1)
					;TryPlayIdle(akactor, BaboAnimsOral[animnum])
					TryPlayIdle(akactor, BaboAnimsOralStart[0])
					leak1ForEquip = sr_OralLeakGreen
				endif
				if sr_Cumvariation.getvalue() == 1
					if GetInflation(akactor) >= 3.0 && CumType < 3
						leak2ForEquip = sr_SprigganSlug
					elseif GetInflation(akactor) < 3.0 && CumType < 3
						leak2ForEquip = sr_ThickCumGreen
					elseif CumType == 3
						leak2ForEquip = sr_ThickCumGreen
					endif
				endif
			elseif spermtype == 6;StoneAtronach
				if CumType == 1
					animnum = 3
					TryPlayIdle(akactor, BaboAnimsStart[animnum])
					leak1ForEquip = sr_VagLeak
				elseif CumType == 2
					animnum = Utility.RandomInt(0, BaboAnimsAnusStart.length - 1)
					TryPlayIdle(akactor, BaboAnimsAnusStart[animnum])
					leak1ForEquip = sr_AnalLeak
				elseif CumType == 3
					;animnum = Utility.RandomInt(0, BaboAnimsOral.length - 1)
					;TryPlayIdle(akactor, BaboAnimsOral[animnum])
					TryPlayIdle(akactor, BaboAnimsOralStart[0])
					leak1ForEquip = sr_OralLeak
				endif
				if sr_Cumvariation.getvalue() == 1
					leak2ForEquip = sr_AtronachStones
				endif
			elseif spermtype == 7;AshHopper
				if CumType == 1
					animnum = 3
					TryPlayIdle(akactor, BaboAnimsStart[animnum])
					leak1ForEquip = sr_VagLeak
				elseif CumType == 2
					animnum = Utility.RandomInt(0, BaboAnimsAnusStart.length - 1)
					TryPlayIdle(akactor, BaboAnimsAnusStart[animnum])
					leak1ForEquip = sr_AnalLeak
				elseif CumType == 3
					;animnum = Utility.RandomInt(0, BaboAnimsOral.length - 1)
					;TryPlayIdle(akactor, BaboAnimsOral[animnum])
					TryPlayIdle(akactor, BaboAnimsOralStart[0])
					leak1ForEquip = sr_OralLeak
				endif
				if sr_Cumvariation.getvalue() == 1
					leak2ForEquip = sr_AshHopperEggs
				endif
			endif
		EndIf
		if Cumtype < 3 ;Nostrip when oral
			isStripArmorExpected = true
		endif
	endif

	StartLeakageSoundEffect(akActor, CumType)
	SetIntValue(akActor, ANIMATE_NUM, animnum)
	StartLeakageEmotionAndTongue(akActor, CumType)

	FormListClear(akActor, "sr.inflater.unequipped")
	FormListClear(akActor, "sr.inflater.equipped_leak")
	If leak1ForEquip
		EquipLeak(akActor, leak1ForEquip)
	EndIf
	If leak2ForEquip
		EquipLeak(akActor, leak2ForEquip)
	EndIf

	StartLeakageAddCum(akActor, CumType)
	StartLeakageApplyPuddle(akActor, CumType)

	If isStripArmorExpected
		StripActor(akActor)
	EndIf
EndFunction

Function DeflateFailMotion(actor akactor, int CumType, bool btongue = true, int spermtype = 0)

	; TODO: Need DisablePlayerControl for player
	;If akActor.IsWeaponDrawn()
	;	akActor.SheatheWeapon()
	;	int attempts = 100
	;	While attempts > 0 && akActor.IsWeaponDrawn()
	;		attempts -= 1
	;		Utility.Wait(0.2)
	;	EndWhile
	;EndIf

	if CumType == 1
		TryPlayIdle(akactor, BaboSpermExpel)
	elseif CumType == 2
		TryPlayIdle(akactor, BaboSpermAnusExpelFail)
	elseif CumType == 3
		TryPlayIdle(akactor, BaboSpermOralOut)
	elseif CumType == 4
		TryPlayIdle(akactor, BaboSpermExpelPanting);Stamina out
	elseif CumType == 5
		TryPlayIdle(akactor, BaboSpermExpelRefuse);I don't want to expel in front of people
	endif

	bool btongueout = false
	MfgConsoleFuncExt.ResetMfg(akActor)
	EmotionWhenLeakage(akactor)
	if Utility.RandomInt(0, 99) < 40 && sr_TongueEffect.getvalue() == 1 && btongue
		EquiprandomTongue(akactor, true)
		btongueout = true
	endif
	MouthOpen(akActor, 0);checks tongue

	FormListClear(akActor, "sr.inflater.unequipped")
	FormListClear(akActor, "sr.inflater.equipped_leak")
	
	;if spermtype == 1;BeastCum WIP
		;if sr_Cumvariation.getvalue() == 1
		;	if GetInflation(akactor) > 3.0 && CumType < 3
		;		EquipLeak(akActor, sr_ThickCum)
		;	elseif GetOralCum(akactor) > 1.0 && CumType == 3
		;		EquipLeak(akActor, sr_ThickCum)
		;	endif
		;endif
	FHUmoanSoundEffect(akactor as objectreference, 3, CumType)

	if spermtype == 3;Spider
		if sr_Cumvariation.getvalue() == 1 && CumType < 3
			EquipLeak(akActor, sr_SpiderEggs)
			StripActor(akActor)
			Utility.wait(10.0)
		endif
	elseif spermtype == 4;Chaurus
		if sr_Cumvariation.getvalue() == 1
			if CumType == 1
				if akActor.getfactionrank(sr_Impregnated) == 1
					EquipLeak(akActor, sr_ChaurusLarvaeEggs)
				else
					EquipLeak(akActor, sr_ChaurusEggs)
				endif
				StripActor(akActor)
				Utility.wait(10.0)
			elseif CumType == 2
				if akActor.getfactionrank(sr_Impregnatedanal) == 1
					EquipLeak(akActor, sr_ChaurusLarvaeEggs)
				else
					EquipLeak(akActor, sr_ChaurusEggs)
				endif
				StripActor(akActor)
				Utility.wait(10.0)
			elseif CumType == 3
				EquipLeak(akActor, sr_ChaurusEggs)
				Utility.wait(10.0)
			endif
		endif
	;elseif spermtype == 5;Spriggan WIP
	elseif spermtype == 6;StoneAtronach
		if sr_Cumvariation.getvalue() == 1
			EquipLeak(akActor, sr_AtronachStones)
			if Cumtype < 3
				StripActor(akActor)
			endif
			Utility.wait(10.0)
		endif
	elseif spermtype == 7;AshHopper
		if sr_Cumvariation.getvalue() == 1
			EquipLeak(akActor, sr_AshHopperEggs)
			if Cumtype < 3
				StripActor(akActor)
			endif
			Utility.wait(10.0)
		endif
	Else
		Utility.wait(5)
	endif

	;RegisterForSingleUpdate(10.0)
	if btongueout
		equiprandomtongue(akactor, false)
	endif
	MfgConsoleFuncExt.ResetMfg(akActor)
	EquipArmor(akactor)
	;infplayer.RegisterForSingleUpdate(15.0); Just in case when the actor is interrupted and the animation stops 
	;if akActor.WaitForAnimationEvent("IdleForceDefaultState") || EmergencySwitch || bDeflateAnimation ; WaitForAnimationEvent is wonky
	;/ if EmergencySwitch || bDeflateAnimation /;
		;/ EmergencySwitch = false /;
		;/ bDeflateAnimation = false /;
		;/ ;Debug.notification("DeflateFailMotion End Debug Text") /;
		;/ MfgConsoleFunc.ResetPhonemeModifier(akActor) /;
		;/ if btongueout /;
			;/ EquiprandomTongue(akactor, false) /;
		;/ endif /;
		;/ EquipArmor(akactor) /;
EndFunction

Function TryPlayIdle(Actor akActor, Idle akIdle, int retryCount = 3, float delay = 0.5)
    If akActor == None || akIdle == None
        log("Invalid actor or idle passed.")
        return
    EndIf

    int attempts = 0
    bool result = false

    while attempts < retryCount
        if akActor.Is3DLoaded() && !akActor.IsDead() && !akActor.IsInCombat()
            result = akActor.PlayIdle(akIdle)
            if result
                return
            else
                log("PlayIdle failed on attempt " + (attempts + 1))
            endif
        else
            log("Actor state not ready on attempt " + (attempts + 1))
        endif

        Utility.Wait(delay)
        attempts += 1
    endwhile

    log("PlayIdle failed after " + retryCount + " attempts.")
EndFunction

Function MouthOpen(actor akActor, int randomi)
{randomi 1-3 normal, 4-5 oralcum, 0 covers all}
int aTongue = FormListCount(akActor, "sr.inflater.equipped_tongue")
if randomi == 0
	randomi = Utility.RandomInt(1, 5)
elseif randomi < 4
	randomi = Utility.RandomInt(1, 3)
endif
	if randomi == 1
		if aTongue > 0
			MfgConsoleFuncExt.SetPhoneme(akActor,1,70)
			MfgConsoleFuncExt.SetPhoneme(akActor,14,30)
		Else
			MfgConsoleFuncExt.SetPhoneme(akActor,1,10)
			MfgConsoleFuncExt.SetPhoneme(akActor,2,40)
			MfgConsoleFuncExt.SetPhoneme(akActor,7,50)
		Endif
	elseif randomi == 2
		if aTongue > 0
			MfgConsoleFuncExt.SetPhoneme(akActor,1,70)
			MfgConsoleFuncExt.SetPhoneme(akActor,14,30)
		Else
			MfgConsoleFuncExt.SetPhoneme(akActor,11,60)
			MfgConsoleFuncExt.SetPhoneme(akActor,12,70)
		Endif
	elseif randomi == 3
		if aTongue > 0
			MfgConsoleFuncExt.SetPhoneme(akActor,0,40)
			MfgConsoleFuncExt.SetPhoneme(akActor,0,50)
		Else
			MfgConsoleFuncExt.SetPhoneme(akActor,0,30)
			MfgConsoleFuncExt.SetPhoneme(akActor,6,20)
		Endif
	elseif randomi == 4
		MfgConsoleFuncExt.SetPhoneme(akActor,0,70)
		MfgConsoleFuncExt.SetPhoneme(akActor,15,40)
	elseif randomi == 5
		MfgConsoleFuncExt.SetPhoneme(akActor,11,60)
		MfgConsoleFuncExt.SetPhoneme(akActor,5,30)
	endif
EndFunction

Function EmotionWhenLeakage(actor akActor)
;	MfgConsoleFunc.ResetPhonemeModifier(akActor) ; Remove any previous modifiers and phenomes

	Int random = Utility.RandomInt(1, 3)
	If random == 1
		;akActor.SetExpressionOverride(3,100)	; Sad!!!  "This is... Sad!"
		MfgConsoleFuncExt.SetExpression(akActor,3,100)
		MfgConsoleFuncExt.SetModifier(akActor,2,50)
		MfgConsoleFuncExt.SetModifier(akActor,3,50)
		MfgConsoleFuncExt.SetModifier(akActor,4,50)
		MfgConsoleFuncExt.SetModifier(akActor,5,50)
		MfgConsoleFuncExt.SetModifier(akActor,8,50)
		MfgConsoleFuncExt.SetModifier(akActor,12,30)
		MfgConsoleFuncExt.SetModifier(akActor,13,30)
	ElseIf random == 2
		MfgConsoleFuncExt.SetExpression(akActor,1,100)
		;akActor.SetExpressionOverride(1,100)	; "So much Orgasm!!"
		MfgConsoleFuncExt.SetModifier(akActor,0,40)
		MfgConsoleFuncExt.SetModifier(akActor,1,40)
		MfgConsoleFuncExt.SetModifier(akActor,11,70)
		MfgConsoleFuncExt.SetModifier(akActor,12,30)
		MfgConsoleFuncExt.SetModifier(akActor,13,30)
	Else
		MfgConsoleFuncExt.SetExpression(akActor,3,100)
		;akActor.SetExpressionOverride(3,100)	; "I cna't bear it any longer!!"
		MfgConsoleFuncExt.SetModifier(akActor,0,20)
		MfgConsoleFuncExt.SetModifier(akActor,1,20)
		MfgConsoleFuncExt.SetModifier(akActor,11,70)
		MfgConsoleFuncExt.SetModifier(akActor,12,30)
		MfgConsoleFuncExt.SetModifier(akActor,13,30)
	EndIf
EndFunction

Function StopLeakage(Actor akActor, int cumType)
	int anim = GetIntValue(akActor, ANIMATING, 0)
	int animnum = GetIntValue(akActor, ANIMATE_NUM, 0)
	If anim > 0
		If anim == 1
			if cumType == 1
				TryPlayIdle(akactor, BaboAnimsEnd[animnum])
			elseif cumType == 2
				TryPlayIdle(akactor, BaboAnimsAnusEnd[animnum])
			elseif cumType == 3
				TryPlayIdle(akactor, BaboAnimsOralEnd[0])
			endif
		ElseIf anim == 2
			Debug.SendAnimationEvent(akActor, "BleedOutStop")
		EndIf
		UnsetIntValue(akActor, ANIMATING)
		UnsetIntValue(akActor, ANIMATE_NUM)
	ElseIf anim < 0
		return
	EndIf
	
	if akActor == player
		If anim > 0
			Game.EnablePlayerControls()
			;Debug.SendAnimationEvent(akActor as ObjectReference,"IdleForceDefaultState")
		EndIf
	Else
		MfgConsoleFunc.ResetPhonemeModifier(akActor);Player expression is controlled here(OnKeyUp)
		
		If anim > 0
			ActorUtil.RemovePackageOverride(akActor, stayStillPackage)
			akActor.EvaluatePackage()
			akActor.SetRestrained(False)
			akActor.SetDontMove(False)
			(akActor as ObjectReference).SetAnimationVariableInt("IsNPC", 1)
			;Debug.SendAnimationEvent(akActor as ObjectReference,"IdleForceDefaultState")
		EndIf
	EndIf
	
	EquiprandomTongue(akactor, false)
	StopExpelSpell(akActor)
	
	If anim > 0
		UnstripActor(akActor)
	EndIf
EndFunction

Function RestoreActors()
	int n = FormListCount(self, INFLATED_ACTORS) 
	while n > 0
		n -= 1
		Form f = FormListGet(self, INFLATED_ACTORS, n)
		Actor a = f as Actor
		If a == None
			ResetActorState(f)
			FormListRemove(self, INFLATED_ACTORS, f, true)
		EndIf
		log("Restoring inflation for " + a.GetLeveledActorBase().GetName() + "...")
		If config.bellyScale
			if config.Bodymorph
				;SetBellyMorphValue(a, GetInflation(a), "PregnancyBelly")
				
				if InflateMorph2 != ""
					SetBellyMorphValue(a, GetInflation(a), InflateMorph2)
				endIf
				
				if InflateMorph3 != ""
					SetBellyMorphValue(a, GetInflation(a), InflateMorph3)
				endif

				if InflateMorph4 != ""
					If InflateMorph == InflateMorph4
						SetBellyMorphValue(a, GetInflation(a) + GetOralCum(a), InflateMorph)
					Else
						SetBellyMorphValue(a, GetInflation(a), InflateMorph)
						SetBellyMorphValue(a, GetOralCum(a), InflateMorph4)
					EndIf
				Else
					SetBellyMorphValue(a, GetInflation(a), InflateMorph)
				endif
			Else
				; ( change by 15, sent to SLIF sum of all pools
				; SetNodeScale(a, BELLY_NODE, GetInflation(a))
				SetNodeScale(a, BELLY_NODE, GetInflation(a) + GetOralCum(a))
				; by 15 )
			Endif
			
		endIf
		UpdateFaction(a)
		UpdateOralFaction(a)
		EncumberActor(a)
	EndWhile
EndFunction

int Function QueueActor(Actor a, bool inflate, int poolmask, float amount, float time = 2.0, String callback = "", int animate = 0)
;	log("Queueing " + a.GetLeveledActorBase().GetName())
	int m = threads.length
	int i = 0
	int res = -1
	while i < m
		if threads[i].GetActorReference() == none
			threads[i].ForceRefTo(a)
			threads[i].SetUp(inflate, poolmask, amount, time, callback, animate)
			res = i
			i = m ; break
		endIf
		i += 1		
	endWhile
	If res < 0
		warn("Failed to slot " + a.GetLeveledActorBase().GetName() + " for processing!")
	EndIf
	return res
EndFunction

int Function QueueAbsorbActor(Actor a, bool inflate, int poolmask, float amount, float time = 2.0, String callback = "", int animate = 0)
;	log("Queueing " + a.GetLeveledActorBase().GetName())
	int m = threads.length
	int i = 0
	int res = -1
	while i < m
		if threads[i].GetActorReference() == none
			threads[i].ForceRefTo(a)
			threads[i].SetUpAbsorb(inflate, poolmask, amount, time, callback, animate)
			res = i
			i = m ; break
		endIf
		i += 1		
	endWhile
	If res < 0
		warn("Failed to slot " + a.GetLeveledActorBase().GetName() + " for processing!")
	EndIf
	return res
EndFunction

Function InflateQueued()
	int eid = ModEvent.Create(START_INFLATION)
	ModEvent.Send(eid)
EndFunction

Function AbsorptionQueued()
	int eid = ModEvent.Create(START_ABSORPTION)
	ModEvent.Send(eid)
EndFunction

Function FlushQueue()
	log("Flushing inflate queue")
	int i = threads.length
	while i > 0
		i -= 1
		threads[i].clear()
	endWhile
EndFunction

Function FertilityEventGo(string eventname, Form akactor, string fatherName, Form father)
	int handle = ModEvent.Create(eventname)
	if (handle)
		ModEvent.Pushform(handle, akactor)
		ModEvent.PushString(handle, fatherName)
		if father
			ModEvent.Pushform(handle, father)
		endif
		ModEvent.Send(handle)
	endIf
EndFunction

Function FertilityChance(Actor a)

int ri = Utility.randomint(1, 100)
if ri > sr_SendingSpermDataChance.getvalue() as int
	return
endif

int fullness = (GetVaginalPercentage(a) * 100) as int
actor Male = none
int i
	if sr_Fertility.getvalue() == 1
	
	if a == Player
		i = sr_InjectorFormlist.getsize()
		while i > 0
			i -= 1
			Male = sr_InjectorFormlist.getat(i) as actor
			if Male && (Male.GetBaseObject() as Actorbase).getsex() == 0
				FertilityEventGo("FertilityModeAddSperm", a as form, Male.Getleveledactorbase().getname(), Male as form)
				If fullness > sr_SendingSpermDataCriterion.getvalue() as int
					FertilityEventGo("FertilityModeImpregnate", a as form, Male.Getleveledactorbase().getname(), None)
				EndIf
				Utility.wait(1.0)
			endif
		endwhile
	else
		i = FormListCount(a, "sr.inflater.injector")
		while i > 0
			i -= 1
			Male = FormListGet(a, "sr.inflater.injector", i) as Actor
			if Male && (Male.GetActorBase()).getsex() == 0
				log("FertilityModeAddSperm to " + a + " from " + Male)
				FertilityEventGo("FertilityModeAddSperm", a as form, Male.Getleveledactorbase().getname(), Male as form)
				If fullness > sr_SendingSpermDataCriterion.getvalue() as int
					FertilityEventGo("FertilityModeImpregnate", a as form, Male.Getleveledactorbase().getname(), None)
				EndIf
				Utility.wait(1.0)
			endif
		endwhile
	endif

	endif
	
	if sr_BeeingFemale.getvalue() == 1
	
	if a == Player
		i = sr_InjectorFormlist.getsize()
		while i > 0
			i -= 1
			Male = sr_InjectorFormlist.getat(i) as actor
			if Male && (Male.GetBaseObject() as Actorbase).getsex() == 0
				Male.SendModEvent("BeeingFemale", "AddSperm", a.GetFormID())
				Utility.wait(1.0)
			endif
		endwhile
	else
		i = FormListCount(a, "sr.inflater.injector")
		while i > 0
			i -= 1
			Male = FormListGet(a, "sr.inflater.injector", i) as Actor
			if (Male && (Male.GetActorBase()).getsex() == 0) && (Player != Male)
				;debug.notification("yes male")
				log("BeeingFemale AddSperm to " + a + " from " + Male)
				Male.SendModEvent("BeeingFemale", "AddSperm", a.GetFormID())
				Utility.wait(1.0)
			else
				;debug.notification("No male")
			endif
		endwhile
	endif

	If fullness > sr_SendingSpermDataCriterion.getvalue() as int
		a.SendModEvent("BeeingFemale", "CanBecomePregnant", 1)
	EndIf

	endif
EndFunction

State maintenance
	Event OnBeginState()
		log("Starting maintenance")
	EndEvent

	Function ResetActors()
		;
	EndFunction
	
	Function ResetActor(Form f)
		;
	EndFunction

	Function maintenance()
		;
	EndFunction

	Event OnUpdateGameTime()
		;
	EndEvent

	Function RestoreActors()
		;
	EndFunction
	
	Event OnEndState()
		log("Stopping maintenance")
		UnregisterForUpdateGameTime()
	EndEvent
EndState

State MonitoringInflation
	Event OnBeginState()
		log("Starting inflation monitor")
		RegisterForSingleUpdateGameTime(1.0)
	EndEvent

	function RemoveSpermFromActor(actor akactor, int type = 1, String ReserveRace = "", bool bEvent = false)
		If !(akactor == player)
			return
		endif
		int i
		if type == 1
			i = sr_InjectorFormlist.getsize()
		elseif type == 2
			i = FormListCount(akactor,  "sr.inflater.analinjector")
		endif
		
		if i > 0
			int randomi = Utility.randomint(0, i - 1)
			actor injector
			if type == 1
				injector = sr_InjectorFormlist.getat(randomi) as Actor
			elseif type == 2
				injector = FormListGet(akactor, "sr.inflater.analinjector", randomi) as Actor
			endif

			int actori = GetCreatureRaceint(injector)
			if ReserveRace == "Chaurus" && (actori >= 4 && actori <= 6)
				if type == 1
					if !akactor.isinfaction(sr_Impregnated)
						bPlayerImpregnated = true
						akactor.addtofaction(sr_Impregnated)
					endif
				elseif type == 2
					if !akactor.isinfaction(sr_Impregnatedanal)
						bPlayerImpregnatedAnal = true
						akactor.addtofaction(sr_Impregnatedanal)
					endif
				endif
				return
			elseif ReserveRace == "Chaurus" && (actori < 4 || actori > 6)
				if type == 1
					sr_InjectorFormlist.RemoveAddedForm(injector)
				elseif type == 2
					FormListRemove(akactor, "sr.inflater.analinjector", injector)
				endif
			endif
		endif
	endfunction

	Event OnUpdateGameTime()
		int n = FormListCount(self, INFLATED_ACTORS) 
		if n > 0
			If dhlpSuspend
				RegisterForSingleUpdateGameTime(0.5)
				return
			EndIf
			;SendModEvent("dhlp-Suspend")
			float startTime = Utility.GetCurrentGameTime()
			While n > 0
				
				int queued = 0
				while queued < threads.length && n > 0
					n -= 1
					Actor a = FormListGet(self, INFLATED_ACTORS, n) as Actor
					;int blockedtype = GetAvailableExpelPool(a)
					if a && !a.IsDead() && !a.IsInCombat() && !a.IsInFaction(slAnimatingFaction) ; && a.GetCurrentScene() == none - we need it? moved to `isAnimating` function
						float lastVagTime = GetFloatValue(a, LAST_TIME_VAG) 
						float lastAnalTime = GetFloatValue(a, LAST_TIME_ANAL)
						float lastoralTime = GetFloatValue(a, LAST_TIME_ORAL)
						float vagCum = GetFloatValue(a, CUM_VAGINAL)
						float analCum = GetFloatValue(a, CUM_ANAL)
						float oralCum = GetFloatValue(a, CUM_ORAL)
						bool deflateVag = vagCum > 0 && lastVagTime > 0.0 && ( GameDaysPassed.GetValue() - lastVagTime ) * 24 >= config.minInflationTime; Needs improvement
						bool deflateAnal = analCum > 0 && lastAnalTime > 0.0 && ( GameDaysPassed.GetValue() - lastAnalTime ) * 24 >= config.minInflationTime
						bool deflateOral = oralCum > 0 && lastoralTime > 0.0 && ( GameDaysPassed.GetValue() - lastoralTime ) * 24 >= config.minInflationTime
						
						If deflateAnal && deflateVag ; only deflate once per tic
							If Utility.RandomInt(0, 99) < 50 || isPlugged(a) == 2;Why either one at a time?
								deflateAnal = false
							Else
								deflateVag = false
							EndIf
						EndIf
						If deflateAnal || deflateVag
							deflateOral = false
						EndIf

						log("Deflate actor " + a.GetLeveledActorBase().GetName() + "? Anal: " + deflateAnal +", Vaginal: " + deflateVag +", Oral: " + deflateOral)
						
						int plugged = isPlugged(a)
						If deflateVag
							if sr_OnEventSpermNPC.getvalue() == 1 && !(a == player)
								FertilityChance(a)
							elseif sr_OnEventSpermPlayer.getvalue() == 1 && (a == player)
								FertilityChance(a)
							endif
						EndIf
						
						If a == player
							sr_plugged.setValueInt(plugged)
						EndIf
						
						int tid = 0
						float defTime = Utility.Randomint(2, 4) * config.animMult
					;	float defTime = Utility.RandomFloat(4.0, 8.0)
					;	log("deflate time: " + deftime)
						
						if deflateVag && Utility.RandomInt(0, 99) < GetDeflateChance(a)
					;		log("Trying to remove vaginal cum")
							if plugged == 1 || plugged == 3
								log("Plugged!")
								if a == Player && Utility.RandomInt(0, 99) < 25
									notify("$FHU_PLUGGED_VAG")
								endIf
							Else
								if sr_OnEventNoDeflation.getvalue() == 0
									;if blockedtype == 0
									;	tid = QueueActor(a, false, VAGINAL, Config.SpermRemovalAmountvag, defTime, "", 0)
									;elseif blockedtype == 1
									;	tid = QueueActor(a, false, VAGINAL, Config.SpermRemovalAmountvag, defTime, "", -1)
									;else
									;	;None
									;endif
									tid = QueueActor(a, false, VAGINAL, Config.SpermRemovalAmountvag, defTime)
									queued += 1
									UnequipTullAnimatedCreampieCumItem(a, 1)
									UnsetFloatValue(a, TULL_UNEQUIP_AT)
									FormListRemove(self, TULL_UNEQUIP_LIST, a, true)
								else
									if sr_OnEventAbsorbSperm.getvalue() == 1
										tid = QueueAbsorbActor(a, false, VAGINAL, Config.SpermRemovalAmountvag, defTime)
										queued += 1
									endif
								endif
							endIf
						EndIf
						
						if deflateAnal && Utility.RandomInt(0, 99) < GetDeflateChance(a)
						;	log("Trying to remove anal cum")
							if plugged == 2 || plugged == 3
								log("Plugged!")
								if a == Player && Utility.RandomInt(0, 99) < 25
									notify("$FHU_PLUGGED_AN")
								endIf
							Else
								if sr_OnEventNoDeflation.getvalue() == 0
									tid = QueueActor(a, false, ANAL, Config.SpermRemovalAmountanal, defTime)
									queued += 1
									UnequipTullAnimatedCreampieCumItem(a, 2)
									UnsetFloatValue(a, TULL_UNEQUIP_AT)
									FormListRemove(self, TULL_UNEQUIP_LIST, a, true)
								else
									if sr_OnEventAbsorbSperm.getvalue() == 1
										tid = QueueAbsorbActor(a, false, ANAL, Config.SpermRemovalAmountanal, defTime)
										queued += 1
									endif
								endif
							endIf
						EndIf
						
						if deflateOral && Utility.RandomInt(0, 99) < GetOralDeflateChance(a)
							if sr_OnEventNoDeflation.getvalue() == 0
								tid = QueueActor(a, false, ORAL, Config.SpermRemovalAmountoral, defTime)
								queued += 1
								UnequipTullAnimatedCreampieCumItem(a, 3)
								UnsetFloatValue(a, TULL_UNEQUIP_AT)
								FormListRemove(self, TULL_UNEQUIP_LIST, a, true)
							else
								if sr_OnEventAbsorbSperm.getvalue() == 1 && sr_OnEventAbsorbSpermOral.getvalue() == 1
									tid = QueueAbsorbActor(a, false, ORAL, Config.SpermRemovalAmountoral, defTime)
									queued += 1
								endif
							endif
						endif
						
						if tid < 0
							log("retrying " + a.GetLeveledActorBase().GetName() + ".")
							queued += threads.length ; break the inner loop
							n += 1 ; retry...
						endIf 
							
					ElseIf a == none || a.isDead() || a.isdisabled()
						warn("Found dead or none actor in inflated actor list, removing.")
						FormListRemoveAt(self, INFLATED_ACTORS, n)
						FormListClear(a, "sr.inflater.injector")
						FormListClear(a, "sr.inflater.analinjector")
					;	FormListRemove(self, INFLATED_ACTORS, FormListGet(self, INFLATED_ACTORS, n), true)
					Else
						log("QueueActor blocked for " + a.GetLeveledActorBase().GetName())
					EndIf
				EndWhile

				if sr_OnEventNoDeflation.getvalue() == 1
					if (sr_OnEventAbsorbSperm.getvalue() == 1)
						AbsorptionQueued()
					;elseif (sr_OnEventAbsorbSpermOral.getvalue() == 1)
						;AbsorptionQueued()
					endif
				else
					InflateQueued()
				endif
					Utility.Wait(10.0) ; Wait for all queued threads to finish
			EndWhile
		;	SendModEvent("dhlp-Resume")
			float duration = (Utility.GetCurrentGameTime() - startTime) * 24
			float nextUpdate = 1.0 - duration
			If nextUpdate < 0.1
				nextUpdate = 0.1
			EndIf
			RegisterForSingleUpdateGameTime(nextUpdate)
		Else
			GoToState("")
		EndIf
	EndEvent
	
	Event OnEndState()
		log("Stopping inflation monitor")
		UnregisterForUpdateGameTime()
	EndEvent
EndState

int Function GetDeflateChance(Actor akActor)
	int chance = (GetInflationPercentage(akActor) + 0.5) as int
	chance += 33
	If chance > 90
		chance = 90
	endIf
;	log("Deflate chance: " + chance)
	return chance
EndFunction

int Function GetOralDeflateChance(Actor akActor)
	int chance = (GetOralPercentage(akActor) + 0.5) as int
	chance += 33
	If chance > 90
		chance = 90
	endIf
	return chance
EndFunction

Function ResetActors()
        
	String previousState = GetState()
	GoToState("maintenance")

	int n = FormListCount(self, INFLATED_ACTORS)
	bool resetPlayerState = true
	while n > 0
		n -= 1
		Form f = FormListGet(self, INFLATED_ACTORS, n)
		ResetActorState(f)
		if f == player
			resetPlayerState = false
		EndIf
	EndWhile
	FormListClear(self, INFLATED_ACTORS)

	; Make sure player is always reset
	log("Resetting Player...")
	If resetPlayerState
		ResetActorState(player)
	EndIf
	SendPlayerCumUpdate(0.0, true)
	SendPlayerCumUpdate(0.0, false)
	sr_InjectorFormlist.revert()

	notify("$FHU_ACTORS_RESET")

	GoToState("")
EndFunction

Function ResetActorState(Form f)
		Actor a = f as Actor
		String name = "None"
		If(a)
			name = a.GetLeveledActorBase().GetName()
		EndIf
        log("Resetting " + name + ": " + f + "...")
        if a && config.bellyScale
			if config.Bodymorph
				;SetBellyMorphValue(a, 0.0, "PregnancyBelly")
				SetBellyMorphValue(a, 0.0, InflateMorph)
				if InflateMorph2 != ""
						SetBellyMorphValue(a, 0.0, InflateMorph2)
				endIf
				if InflateMorph3 != ""
						SetBellyMorphValue(a, 0.0, InflateMorph3)
				endif
				if InflateMorph4 != ""
						SetBellyMorphValue(a, 0.0, InflateMorph4)
				endif
			Else
				RemoveNodeScale(a, BELLY_NODE)
			Endif
        EndIf
        FormListClear(f, "sr.inflater.injector")
        FormListClear(f, "sr.inflater.analinjector")

        UnsetFloatValue(f, INFLATION_AMOUNT)
        UnsetFloatValue(f, CUM_ANAL)
        UnsetFloatValue(f, CUM_VAGINAL)
        UnsetFloatValue(f, CUM_ORAL)
        UnsetFloatValue(f, LAST_TIME_ANAL)
        UnsetFloatValue(f, LAST_TIME_VAG)
        UnsetFloatValue(f, LAST_TIME_ORAL)
;        UnsetFormValue(f, CHEST_ARMOR) ; obsolete
		If(a)
			a.RemoveSpell(sr_inflateBurstSpell)
			UnencumberActor(a)
			RemoveFaction(a)
		EndIf
EndFunction

Function ResetActor(Form f)
        ResetActorState(f)
        FormListRemove(self, INFLATED_ACTORS, f, true)
        If f == player
			SendPlayerCumUpdate(0.0, true)
			SendPlayerCumUpdate(0.0, false)
			sr_InjectorFormlist.revert()
        EndIf
EndFunction

Function UpdateFaction(Actor a)
	If !a.IsInFaction(inflateFaction)
		a.addToFaction(inflateFaction)
	EndIf
	int rank = GetInflationPercentage(a) as int
	if rank < 0
		rank = 0
	elseif rank > 101
		rank = 101
	endIf
	a.SetFactionRank(inflateFaction, rank)
EndFunction

Function RemoveFaction(Actor a)
	a.RemoveFromFaction(inflateFaction)
	a.RemoveFromFaction(sr_Impregnated)
	bPlayerImpregnated = false
EndFunction

Function RemoveAnalFaction(Actor a)
	a.RemoveFromFaction(sr_Impregnatedanal)
	bPlayerImpregnatedAnal = false
EndFunction

bool Function AddImpregnatedFaction(Actor a)
	If !a.IsInFaction(sr_Impregnated)
		a.addToFaction(sr_Impregnated)
		return false
	else
		return true
	EndIf
EndFunction

bool Function AddImpregnatedAnalFaction(Actor a)
	If !a.IsInFaction(sr_Impregnatedanal)
		a.addToFaction(sr_Impregnatedanal)
		return false
	else
		return true
	EndIf
EndFunction

Function UpdateOralFaction(Actor a)
	If !a.IsInFaction(SR_InflateOralFaction)
		a.addToFaction(SR_InflateOralFaction)
	EndIf
	int rank = GetOralPercentage(a) as int
	if rank < 0
		rank = 0
	elseif rank > 101
		rank = 101
	endIf
	a.SetFactionRank(SR_InflateOralFaction, rank)
EndFunction

Function RemoveOralFaction(Actor a)
	a.RemoveFromFaction(SR_InflateOralFaction)
EndFunction

Function PlayerInflationDone(Form a, float startVag, float startAn, float startOr)
	if a != player
		return
	EndIf
	UnregisterForModEvent("fhu.playerInflated")
	
	log("PlayerInflationDone()")
	int n = currentActors.length
	log(n + " actors")
	while n > 0
		n -= 1
		If currentActors[n] != none && currentActors[n] != player && currentActors[n].haskeyword(ActorTypeNPC)
			ApplyCumEffect(currentActors[n].GetLeveledActorBase().GetRace(), currentType, startVag, startAn, startOr)
		Elseif currentActors[n] != none && currentActors[n] != player && !currentActors[n].haskeyword(ActorTypeNPC)
			ApplyCreatureCumEffect(sr_CreatureRaceList.getat(GetCreatureRaceint(currentActors[n])) as race, currentType, startVag, startAn, startOr)
		EndIf

	EndWhile
	currentType = 0
	currentActors = new Actor[1]
EndFunction

Function ApplyCreatureCumEffect(Race rce, int pool, float startVag, float startAn, float startOr)
	if pool <= 0 
		warn("Tried to apply cum effect without a pool.")
		return
	EndIf
	log("Trying to apply cum effect for " + rce.GetName() + "; startVag=" + startVag + "; startAn=" + startAn + "; startOr=" + startOr)
	int n = FormListCount(rce, CREATURERACE_CUM_EFFECTS)
	log("Found " + n + " effects.")
	if n < 1
		return
	EndIf
	;Spell theSpell = FormListGet(rce, CREATURERACE_CUM_EFFECTS, Utility.RandomInt(0, n  - 1)) as Spell
	;log("Applying " + theSpell.GetName())
	
	bool isVaginal = false
	bool isAnal = false
	bool isOral = false
	if(Math.LogicalAnd(pool, ANAL) && !Math.LogicalAnd(pool, VAGINAL))
		isAnal = true
	elseIf(!Math.LogicalAnd(pool, ANAL) && Math.LogicalAnd(pool, VAGINAL))
		isVaginal = true
	ElseIf (Math.LogicalAnd(pool, ANAL) || Math.LogicalAnd(pool, VAGINAL)); both
		isAnal = Utility.RandomInt(0,1) == 1
		isVaginal = !isAnal
	EndIf

	If isAnal || isVaginal ;No Oral state is needed. Oral is Wip
		Spell theSpell = FormListGet(rce, CREATURERACE_CUM_EFFECTS, Utility.RandomInt(0, n  - 1)) as Spell
		log("Applying " + theSpell.GetName())
		player.AddSpell(theSpell, abVerbose = false)
		int evnt = ModEvent.Create("fhu.playerCumEffectStart")
		If isAnal
			ModEvent.pushFloat(evnt, startAn)
		Else
			ModEvent.pushFloat(evnt, startVag)
		EndIf
		ModEvent.pushBool(evnt, isAnal)
		ModEvent.pushForm(evnt, theSpell) 
		Utility.Wait(0.75)
		ModEvent.Send(evnt)
	EndIf
EndFunction

Function ApplyCumEffect(Race rce, int pool, float startVag, float startAn, float startOr)
	if pool <= 0 
		warn("Tried to apply cum effect without a pool.")
		return
	EndIf
	log("Trying to apply cum effect for " + rce.GetName() + "; startVag=" + startVag + "; startAn=" + startAn + "; startOr=" + startOr)
	int n = FormListCount(rce, RACE_CUM_EFFECTS)
	log("Found " + n + " effects.")
	if n < 1
		return
	EndIf
	;Spell theSpell = FormListGet(rce, RACE_CUM_EFFECTS, Utility.RandomInt(0, n  - 1)) as Spell
	;log("Applying " + theSpell.GetName())
	
	bool isVaginal = false
	bool isAnal = false
	bool isOral = false
	if(Math.LogicalAnd(pool, ANAL) && !Math.LogicalAnd(pool, VAGINAL))
		isAnal = true
	elseIf(!Math.LogicalAnd(pool, ANAL) && Math.LogicalAnd(pool, VAGINAL))
		isVaginal = true
	ElseIf (Math.LogicalAnd(pool, ANAL) || Math.LogicalAnd(pool, VAGINAL)); both
		isAnal = Utility.RandomInt(0,1) == 1
		isVaginal = !isAnal
	EndIf
	
	If isAnal || isVaginal ;No Oral state is needed. Oral is Wip
		Spell theSpell = FormListGet(rce, RACE_CUM_EFFECTS, Utility.RandomInt(0, n  - 1)) as Spell
		log("Applying " + theSpell.GetName())
		player.AddSpell(theSpell, abVerbose = false)
		int evnt = ModEvent.Create("fhu.playerCumEffectStart")
		If isAnal
			ModEvent.pushFloat(evnt, startAn)
		Else
			ModEvent.pushFloat(evnt, startVag)
		EndIf
		ModEvent.pushBool(evnt, isAnal)
		ModEvent.pushForm(evnt, theSpell) 
		Utility.Wait(0.75)
		ModEvent.Send(evnt)
	EndIf
EndFunction

Function SendPlayerCumUpdate(float current, bool isAnal)
	int evnt = ModEvent.Create("fhu.playerCumUpdate")
	ModEvent.PushFloat(evnt, current)
	ModEvent.PushBool(evnt, isAnal)
	ModEvent.Send(evnt)
EndFunction

function ApplyPuddle(Actor a_actor, float dist, float angle_offset, int stages)
		float z_actor = a_actor.GetAngleZ() + angle_offset
		float x_pos = a_actor.GetPositionX() + Math.Sin(z_actor) * dist
		float y_pos = a_actor.GetPositionY() + Math.Cos(z_actor) * dist
		ObjectReference target = a_actor.PlaceAtMe(XMarker)
		target.SetPosition(x_pos, y_pos, a_actor.GetPositionZ() + 35)
		if (stages >= 1)
			target.PlayImpactEffect(SFU_CumImpactDataSet)
		endif
		if (stages >= 2)
			Utility.Wait(3)
			target.PlayImpactEffect(SFU_CumMidImpactDataSet)
		endif
		if (stages >= 3)
			Utility.Wait(3)
			target.PlayImpactEffect(SFU_CumHighImpactDataSet)
		endif
		target.Delete()
endfunction

Function StripActor(Actor akActor)
	If config.strip
		log("StripActor " + akActor)
		UnequipArmor(akActor)
	endIf
EndFunction

; Unused
;Function StripCover(Actor akActor, bool isAnal)
;	If config.strip
;		int slot = 0x1000000
;		If isAnal
;			slot = 0x40000
;		EndIf
;		Form current = SexLab.StripSlot(akActor, slot)
;		If current
;			SetFormValue(akActor, COVER_PIECE, current)
;		EndIf
;	EndIf
;EndFunction

Function UnstripActor(Actor akActor)
	;log("UnstripActor " + akActor)
	EquipArmor(akActor)
EndFunction

Function UnequipArmor(Actor target)
;wornforms = new Armor[32]

;int index = wornforms.length
int index = 0
Armor curr_armor
Int CurrentArmorSlotsMaskB = Math.LeftShift(SRSlotMaskB.GetValue() As Int, 24)
Int CurrentArmorSlotsMaskA = SRSlotMask.GetValue() As Int

Int slotsChecked = Math.LogicalOr(CurrentArmorSlotsMaskA, CurrentArmorSlotsMaskB)

int thisSlot = 0x01
	while (thisSlot < 0x80000000)
	if (Math.LogicalAnd(thisSlot, slotsChecked) != thisSlot)
		curr_armor = target.GetWornForm(thisSlot) as Armor
		if curr_armor
			if !SexLabUtil.HasKeywordSub(curr_armor, "NoStrip") && (FormListFind(target, "sr.inflater.equipped_leak", curr_armor) == -1) && (FormListFind(target, "sr.inflater.equipped_tongue", curr_armor) == -1)
				;wornforms[index] = curr_armor
				Target.UnequipItem(curr_armor, false, true)
				;log("UnequipArmor from " + target + ": " + curr_armor)
				FormListAdd(target, "sr.inflater.unequipped", curr_armor)
				index += 1
			EndIf
		endif
	endif
		thisSlot *= 2 ;double the number to move on to the next slot
	endWhile
	
EndFunction

Function EquipArmor(Actor target)

	int i = FormListCount(target, "sr.inflater.unequipped")

	while(i > 0)
		i -= 1
		Armor curr_armor = FormListGet(target, "sr.inflater.unequipped", i) as Armor
		if curr_armor && !target.IsEquipped(curr_armor)
			bool inInventory = true ; false - TODO: need optimization
			;Int iIndex = target.GetNumItems()
			;While iIndex > 0
			;	iIndex -= 1
			;	If target.GetNthForm(iIndex) == curr_armor
			;		inInventory = true
			;	EndIf
			;EndWhile
			If inInventory
				log("EquipArmor to " + target + ": " + curr_armor)
				Target.equipItem(curr_armor, false, true)
			Else
				log("EquipArmor to " + target + ": " + curr_armor + " failed by !inInventory")
			EndIf
		Else
			if(!curr_armor)
				log("EquipArmor to " + target + ": " + curr_armor + " failed by !curr_armor")
			endif
			if(target.IsEquipped(curr_armor))
				log("EquipArmor to " + target + ": " + curr_armor + " failed by IsEquipped")
			endif
		endif
		FormListRemoveAt(target, "sr.inflater.unequipped", i)
	endwhile
	FormListClear(target, "sr.inflater.unequipped")
	RemoveLeak(target)
	;/ i = FormListCount(target, "sr.inflater.equipped_leak") /;
	;/ while(i > 0) /;
		;/ i -= 1 /;
		;/ Armor leak = FormListGet(target, "sr.inflater.equipped_leak", i) as Armor /;
		;/ target.unequipItem(leak, abSilent=true) /;
		;/ target.removeItem(leak, 99, true) /;
	;/ endwhile /;
	;/ FormListClear(target, "sr.inflater.equipped_leak") /;
EndFunction

Function RemoveLeak(Actor target)
	int i = FormListCount(target, "sr.inflater.equipped_leak")
	while(i > 0)
		i -= 1
		Armor leak = FormListGet(target, "sr.inflater.equipped_leak", i) as Armor
		target.unequipItem(leak, abSilent=true)
		target.removeItem(leak, 99, true)
	endwhile
	FormListClear(target, "sr.inflater.equipped_leak")
EndFunction

Function StopExpelSpell(Actor a)
	if a.HasMagicEffect(sr_ExpelCumMGEF)
		a.RemoveSpell(sr_expelcumspell)
	endif
EndFunction

Function EncumberActor(Actor a)
	If !config.encumber || a == None
		return
	EndIf
	UnencumberActor(a)
	int fullness = a.GetFactionRank(inflateFaction)
	Utility.Wait(2.0) ; Removing and reapplying the same spell seems to fail on reapply, maybe this fixes it?
	If fullness > 86
		a.AddSpell(encumber25, false)
	ElseIf fullness > 72
		a.AddSpell(encumber20, false)
	ElseIf fullness > 58
		a.AddSpell(encumber15, false)
	ElseIf fullness > 44
		a.AddSpell(encumber10, false)
	ElseIf fullness > 20
		a.AddSpell(encumber05, false)
	EndIf
EndFunction

Function UnencumberActor(Actor a)
	If a == None
		return
	EndIf
	a.RemoveSpell(encumber05)
	a.RemoveSpell(encumber10)
	a.RemoveSpell(encumber15)
	a.RemoveSpell(encumber20)
	a.RemoveSpell(encumber25)
EndFunction

Function UnencumberAllActors()
	int n = FormListCount(self, INFLATED_ACTORS) 
	while n > 0
		n -= 1
		Actor a = FormListGet(self, INFLATED_ACTORS, n) as Actor
		UnencumberActor(a)
	EndWhile
EndFunction

Function EncumberAllActors()
	int n = FormListCount(self, INFLATED_ACTORS) 
	while n > 0
		n -= 1
		Actor a = FormListGet(self, INFLATED_ACTORS, n) as Actor
		EncumberActor(a)
	EndWhile
EndFunction


Function Moan(Actor akActor)
	sslBaseVoice voice = sexlab.GetVoice(akActor)
	int fullness = ( GetInflationPercentage(akActor) + 0.5 ) as int
	bool isVictim = fullness > 50 && fullness <= 75 ; to play the medium sound
	voice.PlayMoan(akActor, fullness, isVictim)
EndFunction

; -------
; Helpers
; -------

int function GetAvailableExpelPool(Actor a)
	return GetintValue(a, EXPEL_SWITCH)
	;{0: expel available 1: expel unavailable 2: auto deflate unavailable as well}
	;Abort - {0: expel available 1: vaginal expel unavailable 2: Anal expel unavailable 3: both vaginal and anal unavailable 4: Oral expel unavailable 5: vaginal + oral unavailable 6: anal + oral unavailable 9: All the holes unavailable}
endfunction

float Function GetOralPoolSize(Actor a)
	return config.OralmaxInflation
EndFunction

float Function GetPoolSize(Actor a)
	return config.maxInflation
EndFunction

float Function GetOralCum(Actor a)
	return GetFloatValue(a, CUM_ORAL)
EndFunction

float Function GetAnalCum(Actor a)
	return GetFloatValue(a, CUM_ANAL)
EndFunction

float Function GetVaginalCum(Actor a)
	return GetFloatValue(a, CUM_VAGINAL)
EndFunction

float Function GetAnalPercentage(Actor a)
	return GetAnalCum(a) / GetPoolSize(a)
EndFunction

float Function GetVaginalPercentage(Actor a)
	return GetVaginalCum(a) / GetPoolSize(a)
EndFunction

float Function GetOralPercentage(Actor a)
	return GetOralCum(a) / GetOralPoolSize(a)
EndFunction

String Property TULL_ANIMATED_CREAMP = "TullAnimatedCreampie.esp" autoreadonly hidden

bool Function IsTullAnimatedCreampieReady()
	if !config.TullAnimatedCreampieEnabled
		return false
	endif
	return Game.GetModByName(TULL_ANIMATED_CREAMP) != 255
EndFunction

Form Function GetTullAnimatedCreampieForm(int formId)
	Form f = Game.GetFormFromFile(formId, TULL_ANIMATED_CREAMP)
	return f
EndFunction

Function EquipTullAnimatedCreampieItem(Actor akActor, int formId)
	if !akActor
		return 
	endif
	Armor a = GetTullAnimatedCreampieForm(formId) as Armor
	if a && !akActor.IsEquipped(a)
		akActor.AddItem(a, 1, true)
		akActor.EquipItem(a, abSilent=true)
	endif 
EndFunction

Function UnequipTullAnimatedCreampieItem(Actor akActor, int formId)
	if !akActor
		return
	endif
	Armor a = GetTullAnimatedCreampieForm(formId) as Armor
	if a && akActor.IsEquipped(a)
		akActor.UnequipItem(a, abSilent=true)
		akActor.RemoveItem(a, 99, true)
	endif
EndFunction

bool Function UpdateTullAnimatedCreampieCumItem(Actor akActor, int cumType)
	if !IsTullAnimatedCreampieReady() || !akActor
		return false
	endif
	float threshold = config.TullAnimatedCreampieThreshold / 100.0
	if cumType == 1
		if GetVaginalPercentage(akActor) >= threshold
			EquipTullAnimatedCreampieItem(akActor, 0x00000807)
			ScheduleTullAnimatedCreampieUnequip(akActor)
			return true
		else
			UnequipTullAnimatedCreampieItem(akActor, 0x00000807)
			return false
		endif
	elseif cumType == 3
		if GetOralPercentage(akActor) >= threshold
			EquipTullAnimatedCreampieItem(akActor, 0x00000803)
			ScheduleTullAnimatedCreampieUnequip(akActor)
			return true
		else
			UnequipTullAnimatedCreampieItem(akActor, 0x00000803)
			return false
		endif
	endif
	return false
EndFunction

Function UnequipTullAnimatedCreampieCumItem(Actor akActor, int cumType)
	if !IsTullAnimatedCreampieReady() || !akActor
		return
	endif
	if cumType == 1
		UnequipTullAnimatedCreampieItem(akActor, 0x00000807)
	elseif cumType == 2
		UnequipTullAnimatedCreampieItem(akActor, 0x00000809)
	elseif cumType == 3
		UnequipTullAnimatedCreampieItem(akActor, 0x00000803)
	endif
EndFunction

bool Function ShouldEquipTullAnimatedCreampie(Actor akActor, int cumType)
	if !IsTullAnimatedCreampieReady() || !akActor
		return false
	endif
	float threshold = config.TullAnimatedCreampieThreshold / 100.0
	if cumType == 1
		return GetVaginalPercentage(akActor) >= threshold
	elseif cumType == 2
		return GetAnalPercentage(akActor) >= threshold
	elseif cumType == 3
		return GetOralPercentage(akActor) >= threshold
	endif
	return false
EndFunction

Function ScheduleTullAnimatedCreampieUnequip(Actor akActor)
	if !IsTullAnimatedCreampieReady() || !akActor
		return
	endif
	float delay = config.TullAnimatedCreampieCleanDelay
	SetFloatValue(akActor, TULL_UNEQUIP_AT, Utility.GetCurrentGameTime() + (delay / 86400.0))
	FormListAdd(self, TULL_UNEQUIP_LIST, akActor, false)
	RegisterForSingleUpdate(1.0)
EndFunction

Event OnUpdate()
	int n = FormListCount(self, TULL_UNEQUIP_LIST)
	if n <= 0
		return
	endif

	float now = Utility.GetCurrentGameTime()
	float nextWait = 0.0
	bool hasPending = false

	while n > 0
		n -= 1
		Actor a = FormListGet(self, TULL_UNEQUIP_LIST, n) as Actor
		if !a
			FormListRemoveAt(self, TULL_UNEQUIP_LIST, n)
		else
			float due = GetFloatValue(a, TULL_UNEQUIP_AT)
			if due <= 0.0 || now >= due
				UnequipTullAnimatedCreampieItem(a, 0x00000807)
				UnequipTullAnimatedCreampieItem(a, 0x00000809)
				UnequipTullAnimatedCreampieItem(a, 0x00000803)
				UnsetFloatValue(a, TULL_UNEQUIP_AT)
				FormListRemoveAt(self, TULL_UNEQUIP_LIST, n)
			else
				float remaining = (due - now) * 86400.0
				if !hasPending || remaining < nextWait
					nextWait = remaining
					hasPending = true
				endif
			endif
		endif
	endWhile

	if hasPending
		if nextWait < 1.0
			nextWait = 1.0
		endif
		RegisterForSingleUpdate(nextWait)
	endif
EndEvent


float Function GetTotalCum(Actor a)
	return GetAnalCum(a) + GetVaginalCum(a)
EndFunction

float Function GetInflation(Actor a)
	return GetFloatValue(a, INFLATION_AMOUNT)
EndFunction

float Function GetInflationPercentage(Actor a)
	return ((GetInflation(a)) / (config.maxInflation)) * 100.0
EndFunction

Function notify(String msg)
	Debug.Notification(msg)
EndFunction

; -1 	- DDi not installed
;  0	- Not plugged
;  1 	- Vaginal plug
;  2 	- Anal plug
;  3 	- Both plugs
int Function isPlugged(Actor akActor);4Oral is not ready WIP
	if !zad
		return -1
	EndIf

	If akActor.WornHasKeyword(SLA_AnalPlug) && (akActor.WornHasKeyword(SLA_VaginalBeads) || sexlab.GetGender(akActor) == 0)
		return 3
	endif

	If akActor.WornHasKeyword(zad_DeviousPlugAnal) && (akActor.WornHasKeyword(zad_DeviousPlugVaginal) || sexlab.GetGender(akActor) == 0)
		return 3
	ElseIf akActor.WornHasKeyword(zad_DeviousPlugVaginal) || akActor.WornHasKeyword(SLA_VaginalBeads)
		return 1
	ElseIf akActor.WornHasKeyword(zad_DeviousPlugAnal) || akActor.WornHasKeyword(SLA_AnalPlug)  || akActor.WornHasKeyword(SLA_AnalPlugBeads) || akActor.WornHasKeyword(SLA_AnalPlugTail)
		return 2
	Else
		return 0
	EndIf		
EndFunction

int Function isGagged(Actor akActor);0 = Not gagged, 1 = PermitOral Gagged, 2 = Gagged
	If akActor.WornHasKeyword(zad_DeviousGag)
		if akActor.WornHasKeyword(zad_PermitOral)
			return 1
		else
			return 2
		endif
	else
		return 0
	endif
Endfunction

bool Function isFilledAndPlugged(Actor akActor)
	int plugged = isPlugged(akActor)
	if plugged <= 0 || akActor.GetFactionRank(inflateFaction) <= 0
		return false
	EndIf
	
	return plugged == 3 || ( plugged == 1 && GetVaginalCum(akActor) > 0.0 ) || ( plugged == 2 && GetAnalCum(akActor) > 0.0 )
EndFunction

bool Function IsFilledAndPluggedType(Actor akActor, int type)
	int plugged = isPlugged(akActor)
	If plugged > 0 && akActor.GetFactionRank(inflateFaction) > 0
		return (plugged == 3 && type == 3) || (plugged == 1 && type == 1 && GetVaginalCum(akActor) > 0.0) || (plugged == 2 && type == 2 && GetAnalCum(akActor) > 0.0)
	EndIf
	return false
EndFunction

bool Function isBelted(Actor akActor, int h)
	if !zad
		return false
	EndIf

	if h == 1
		return akActor.WornHasKeyword(zad_DeviousBelt)
	ElseIf h == 2
		return akActor.WornHasKeyword(zad_DeviousBelt) && !akActor.WornHasKeyword(zad_PermitAnal)
	EndIf
	return false
EndFunction

; 0 - Neither, no cum
; 1 - Vaginal
; 2 - Anal
; 3 - Oral
int Function GetMostRecentInflationType(Actor a)
	float vag = GetFloatValue(a, CUM_VAGINAL)
	float an = GetFloatValue(a, CUM_ANAL)
	float ora = GetFloatValue(a, CUM_ORAL)
	
	If an > 0.0 || vag > 0.0 || ora > 0.0
		If vag > an
			if ora > vag
				return 3
			else
				return 1
			endif
		Else
			if ora > 0.0
				return 3
			else
				return 2
			endif
		EndIf
	Else
		return 0
	EndIf	
EndFunction

int Function GetMoreInflationType(Actor a, int itype);exclude type 1: Vaginal 2: Anal 3: Oral

	float vag = GetFloatValue(a, CUM_VAGINAL)
	float an = GetFloatValue(a, CUM_ANAL)
	float ora = GetFloatValue(a, CUM_ORAL)

	if itype == 1
		If an > 0.0 || ora > 0.0
			if an >= ora
				return 2
			elseif an < ora
				return 3
			endif
		else
			return 0
		endif
	elseif itype == 2
		If vag > 0.0 || ora > 0.0
			if vag >= ora
				return 1
			elseif vag < ora
				return 3
			endif
		else
			return 0
		endif
	elseif itype == 3
		If vag > 0.0 || an > 0.0
			if vag >= an
				return 1
			elseif vag < an
				return 2
			endif
		else
			return 0
		endif
	endif

EndFunction

float Function GetHoursSinceLastInflation(Actor a)
	float an = GetFloatValue(a, LAST_TIME_ANAL)
	float vag = GetFloatValue(a, LAST_TIME_VAG)
	float ora = GetFloatValue(a, LAST_TIME_ORAL)
	
	If an > 0.0 || vag > 0.0 || ora > 0.0
		If vag > an
			if ora > vag
				return (GameDaysPassed.GetValue() - ora) * 24
			else
				return (GameDaysPassed.GetValue() - vag) * 24
			endif
		Else
			if ora > an
				return (GameDaysPassed.GetValue() - ora) * 24
			else
				return (GameDaysPassed.GetValue() - an) * 24
			endif
		EndIf
	Else
		return -1.0
	EndIf	
EndFunction

float Function GetHoursSinceInflation(Actor a, int type)
	If type == 1
		float vag = GetFloatValue(a, LAST_TIME_VAG)
		If vag > 0.0 
			return (GameDaysPassed.GetValue() - vag) * 24
		Else
			return -1.0
		EndIf
	ElseIf type == 2
		float an = GetFloatValue(a, LAST_TIME_ANAL)
		If an > 0.0 
			return (GameDaysPassed.GetValue() - an) * 24
		Else
			return -1.0
		EndIf
	ElseIf type == 3
		return GetHoursSinceLastInflation(a)
	Elseif type == 4
		float ora = GetFloatValue(a, LAST_TIME_ORAL)
		If ora > 0.0
			return (GameDaysPassed.GetValue() - ora) * 24
		Else
			return -1.0
		EndIf
	Else
		return -1.0
	EndIf
EndFunction

Function log(String msg, int lvl = 0)
	If config.logging
		Debug.Trace("[FillHerUp]: " + msg)
	EndIf
	If sr_debug.getValueInt() == 1
		MiscUtil.PrintConsole("[FillHerUp]: " + msg)
	EndIf
EndFunction

Function logAndPrint(String msg, int lvl = 0)
	If config.logging
		Debug.Trace("[FillHerUp]: " + msg)
		MiscUtil.PrintConsole("[FillHerUp]: " + msg)
	EndIf
EndFunction

Function warn(String msg)
	log(" - Warning - " + msg)
EndFunction

Function error(String msg)
	log(" ================================================================")
	log(" == ERROR == " + msg)
	log(" ================================================================")
EndFunction

Function SLIF_inflate(Actor kActor, String sKey, float value)
	int SLIF_event = ModEvent.Create("SLIF_inflate")
	If (SLIF_event)
		ModEvent.PushForm(SLIF_event, kActor)
		ModEvent.PushString(SLIF_event, "Fill Her Up")
		ModEvent.PushString(SLIF_event, sKey)
		ModEvent.PushFloat(SLIF_event, value)
		ModEvent.PushString(SLIF_event, FHU_MODKEY)
		ModEvent.Send(SLIF_event)
	EndIf
EndFunction

Function SLIF_unregisterNode(Actor kActor, String sKey)
	int SLIF_event = ModEvent.Create("SLIF_unregisterNode")
	If (SLIF_event)
		ModEvent.PushForm(SLIF_event, kActor)
		ModEvent.PushString(SLIF_event, "Fill Her Up")
		ModEvent.PushString(SLIF_event, sKey)
		ModEvent.Send(SLIF_event)
	EndIf
EndFunction

;Quick thing that I added to help NIO and other framework mods

String Property FHU_MODKEY = "FHU_MODKEY" autoreadonly

;This is a copy/paste of the lovely SetNodeScale function from XPMSElib. I copy/pasted it here to avoid any additional dependencies.
;(Actually, at this point it's hardly the same function, but credit where it's due)

; Sets a transformation with the given key in 3rd and 1st person skeleton to the given scale (Quicker, Recommended if not 3rd or 1st person dependent)
Function SetNodeScale(Actor akActor, string nodeName, float value)
	if (akActor)
		if (Game.GetModbyName("SexLab Inflation Framework.esp") != 255)
			SLIF_inflate(akActor, nodeName, value)
		else
			bool isFemale = akActor.GetLeveledActorBase().GetSex() == 1
			bool isPlayer = akActor == Game.GetPlayer()
			If value > 1.0
				NiOverride.AddNodeTransformScale(akActor, false, isFemale, nodeName, FHU_MODKEY, value)
				if (isPlayer)
					NiOverride.AddNodeTransformScale(akActor, true, isFemale, nodeName, FHU_MODKEY, value)
				endIf
			Else
				NiOverride.RemoveNodeTransformScale(akActor, false, isFemale, nodeName, FHU_MODKEY)
				if (isPlayer)
					NiOverride.RemoveNodeTransformScale(akActor, true, isFemale, nodeName, FHU_MODKEY)
				endIf
			Endif
			NiOverride.UpdateNodeTransform(akActor, false, isFemale, nodeName)
			bool hasScale = NiOverride.HasNodeTransformScale(akActor, true, isFemale, nodeName, FHU_MODKEY)
			if (!isPlayer && hasScale)
				NiOverride.RemoveNodeTransformScale(akActor, true, isFemale, nodeName, FHU_MODKEY)
			endIf
			if (isPlayer || hasScale)
				NiOverride.UpdateNodeTransform(akActor, true, isFemale, nodeName)
			endIf
		endIf
	endIf
EndFunction

Function RemoveNodeScale(Actor akActor, string nodeName)
	if (akActor)
		if (Game.GetModbyName("SexLab Inflation Framework.esp") != 255)
			SLIF_unregisterNode(akActor, nodeName)
		endIf
		bool isFemale = akActor.GetLeveledActorBase().GetSex() == 1
		bool isPlayer = akActor == Game.GetPlayer()
		NiOverride.RemoveNodeTransformScale(akActor, false, isFemale, nodeName, FHU_MODKEY)
		if (isPlayer)
			NiOverride.RemoveNodeTransformScale(akActor, true, isFemale, nodeName, FHU_MODKEY)
		endIf
		NiOverride.UpdateNodeTransform(akActor, false, isFemale, nodeName)
		if (isPlayer)
			NiOverride.UpdateNodeTransform(akActor, true, isFemale, nodeName)
		endIf
	endIf
EndFunction


;Added Function that uses morphs instead of node scaling
;Added SLIF compatibility + .esp key so nioverride will auto remove morphs if FHU is unistalled

String Property FHU_KEY = "sr_FillHerUp.esp" autoreadonly
 
Function SetBellyMorphValue(Actor akActor, float value, string MorphName)
	if MorphName == ""
		return
	endif
	
	If value != 0.0
		if config.FHUSLIF
			if MorphName == InflateMorph && config.FHUMorphSLIF
				SLIF_Morph.morph(akActor, "Fill Her Up", morphName, value/10, FHU_KEY)
			elseif MorphName == InflateMorph2 && config.FHUMorphSLIF2
				SLIF_Morph.morph(akActor, "Fill Her Up", morphName, value/10, FHU_KEY)
			elseif MorphName == InflateMorph3 && config.FHUMorphSLIF3
				SLIF_Morph.morph(akActor, "Fill Her Up", morphName, value/10, FHU_KEY)
			elseif MorphName == InflateMorph4 && config.FHUMorphSLIF4
				SLIF_Morph.morph(akActor, "Fill Her Up", morphName, value/10, FHU_KEY)
			;else
			;	NiOverride.SetBodyMorph(akActor, MorphName, FHU_KEY, value/10)
			endif
		else
			NiOverride.SetBodyMorph(akActor, MorphName, FHU_KEY, value/10)
		endif
	Else
		if config.FHUSLIF
			if MorphName == InflateMorph && config.FHUMorphSLIF
				SLIF_Morph.morph(akActor, "Fill Her Up", morphName, value/10, FHU_KEY)
			elseif MorphName == InflateMorph2 && config.FHUMorphSLIF2
				SLIF_Morph.morph(akActor, "Fill Her Up", morphName, value/10, FHU_KEY)
			elseif MorphName == InflateMorph3 && config.FHUMorphSLIF3
				SLIF_Morph.morph(akActor, "Fill Her Up", morphName, value/10, FHU_KEY)
			elseif MorphName == InflateMorph4 && config.FHUMorphSLIF4
				SLIF_Morph.morph(akActor, "Fill Her Up", morphName, value/10, FHU_KEY)
			else;just in case
				NiOverride.SetBodyMorph(akActor, MorphName, FHU_KEY, value/10)
				NiOverride.ClearBodyMorph(akActor, MorphName, FHU_KEY)
			endif
		else
			NiOverride.SetBodyMorph(akActor, MorphName, FHU_KEY, value/10)
			NiOverride.ClearBodyMorph(akActor, MorphName, FHU_KEY)
		endif
	EndIf	
	NiOverride.UpdateModelWeight(akActor);Pregnancy Swapper
	int eid = ModEvent.Create("PNSUpdateRequest")
	ModEvent.PushForm(eid, akActor)
	ModEvent.Send(eid)
EndFunction



Function SLIF_morph(Actor akActor, String MorphName, float value)
	SLIF_Morph.morph(akActor, "Fill Her Up", morphName, value, FHU_KEY)
EndFunction

Function SLIF_unregisterMorph(Actor akActor, String MorphName)
;Null
EndFunction

bool Function isAnimating(Actor akActor) ; TODO too many dependency
	If (akActor.IsOnMount() || akActor.GetCurrentScene() != none || akActor.GetSitState() != 0)
		return true
	EndIf
	If (slAnimatingFaction && akActor.IsInFaction(slAnimatingFaction) ) 
		return true
	EndIf
	If (config.zadAnimatingFaction && akActor.IsInFaction(config.zadAnimatingFaction) ) 
		return true
	EndIf
	If (config.DefeatFaction && akActor.IsInFaction(config.DefeatFaction) ) 
		return true
	EndIf
	If (config.UDMinigameFaction && akActor.IsInFaction(config.UDMinigameFaction) )
		return true
	EndIf
	; TODO: Not a faction
	;If (config.BathinginSkyrimFaction && akActor.IsInFaction(config.BathinginSkyrimFaction) )
	;	return true
	;EndIf

	return false
EndFunction
