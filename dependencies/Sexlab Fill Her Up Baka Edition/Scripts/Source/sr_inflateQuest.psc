Scriptname sr_inflateQuest extends Quest

import StorageUtil

sr_inflateConfig Property config auto
sr_infDeflateAbility Property defAlias Auto
sr_inflateMessages Property dialogue auto 
sr_infEventManager Property eventManager auto
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


Faction Property sr_DARAnimatingType Auto
Faction Property inflaterAnimatingFaction Auto
Faction Property inflateFaction Auto
Faction Property SR_InflateOralFaction Auto
Spell Property encumber05 Auto
Spell Property encumber10 Auto
Spell Property encumber15 Auto
Spell Property encumber20 Auto
Spell Property encumber25 Auto

SexLabFramework Property sexlab auto
Faction Property slAnimatingFaction auto

Package Property stayStillPackage auto

GlobalVariable Property GameDaysPassed auto
bool zad = false
Keyword Property zad_DeviousPlugAnal auto 
Keyword Property zad_DeviousPlugVaginal auto 
Keyword Property zad_DeviousBelt auto 
Keyword Property zad_PermitAnal auto 

ImpactDataSet Property SFU_CumImpactDataSet Auto
ImpactDataSet Property SFU_CumMidImpactDataSet Auto
ImpactDataSet Property SFU_CumHighImpactDataSet Auto

Actor[] Property Injector Auto
Actor[] Property InjectorPlayer Auto
formlist Property sr_InjectorFormlist auto
Actor Property Player Auto
Actor DeflateActor
Static Property xMarker Auto
;Spell Property puddleSpell Auto

Keyword Property SLA_AnalPlug Auto
Keyword Property SLA_AnalPlugBeads Auto
Keyword Property SLA_AnalPlugTail Auto
Keyword Property SLA_VaginalBeads Auto

int property Tongueri auto
int property cumtypei auto

sr_inflateThread[] Property threads auto

Bool TongueOut

GlobalVariable Property sr_CumMultiplier Auto
GlobalVariable Property sr_SLIF Auto
float Property cumMult hidden
	float Function Get()
		return sr_CumMultiplier.GetValue()
	EndFunction
	
	Function Set(float val)
		sr_CumMultiplier.SetValue(val)
	EndFunction
EndProperty

float Property BURST_MULT = 1.2 autoreadonly hidden

String Property ORIGINAL_SCALE = "sr.inflater.scale.original" autoreadonly hidden
String Property INFLATION_AMOUNT = "sr.inflater.amount" autoreadonly hidden
String Property INFLATED_ACTORS = "sr.inflater.Actors" autoreadonly hidden

String Property LAST_TIME_VAG = "sr.inflater.time.vaginal" autoreadonly hidden 
String Property LAST_TIME_ANAL = "sr.inflater.time.anal" autoreadonly hidden
String Property LAST_TIME_ORAL = "sr.inflater.time.oral" autoreadonly hidden

String Property CUM_VAGINAL = "sr.inflater.cum.vaginal" autoreadonly hidden
String Property CUM_ANAL = "sr.inflater.cum.anal" autoreadonly hidden
String Property CUM_ORAL = "sr.inflater.cum.oral" autoreadonly hidden

String Property InflateMorph = "PregnancyBelly" Auto
String property InflateMorph2 = "" Auto
String property InflateMorph3 = "" Auto
String property InflateMorph4 = "" Auto
String property PregnancyBelly = "PregnancyBelly" AutoReadOnly hidden
String Property BELLY_NODE = "NPC Belly" autoreadonly hidden
String Property ANIMATING = "sr.inflater.animating" autoreadonly hidden
String Property CHEST_ARMOR = "sr.inflater.armor.chest" autoreadonly hidden
String Property COVER_PIECE = "sr.inflater.armor.cover" autoreadonly hidden

String Property RACE_CUM_AMOUNT = "sr.inflater.race.cum.amount" autoreadonly hidden
String Property CREATURERACE_CUM_AMOUNT = "sr.inflater.creaturerace.cum.amount" autoreadonly hidden
String property RACE_CUM_EFFECTS = "sr.inflater.race.cum.effects" autoreadonly hidden
String property CREATURERACE_CUM_EFFECTS = "sr.inflater.Creaturerace.cum.effects" autoreadonly hidden

String Property START_INFLATION = "sr.inflater.start" autoreadonly hidden
String Property START_ABSORPTION = "sr.inflater.absorb" autoreadonly hidden

int property VAGINAL		= 0x01 autoreadonly hidden
int property ANAL		= 0x02 autoreadonly hidden
int property ORAL		= 0x04 autoreadonly hidden

GlobalVariable Property sr_EstrusChaurus auto
GlobalVariable Property sr_Fertility auto
GlobalVariable Property sr_BeeingFemale auto

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

int animnum
int MoanType

Race Property ChaurusRace Auto
Race Property ChaurusReaperRace Auto
Race Property DLC1_BF_ChaurusRace Auto
Race Property DLC1ChaurusHunterRace Auto

Race Property FrostbiteSpiderRace Auto
Race Property FrostbiteSpiderRaceGiant Auto
Race Property FrostbiteSpiderRaceLarge Auto
Race Property DLC2ExpSpiderBaseRace Auto
Race Property DLC2ExpSpiderPackmuleRace Auto
int Property spermtype Auto
Bool AnalDeflation

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


Actor[] currentActors
int currentType = 0

float Function GetVersion()
	return 2.00
EndFunction

String Function GetVersionString()
	return "2.00"
EndFunction

Event Onint()
	BaboAnimsSet()
;	RegisterInjectorArray()
	maintenance()
EndEvent

Function RegisterInjectorArray()
	;InjectorPlayer = new actor[4]
	;Injector = new actor[4]
EndFunction

Function VersionUpdate()
	If Game.GetModByName("Devious Devices - Assets.esm") != 255
		zad = true
		zad_DeviousPlugAnal		= Game.GetFormFromFile(0x0001DD7D, "Devious Devices - Assets.esm") as Keyword
		zad_DeviousPlugVaginal	= Game.GetFormFromFile(0x0001DD7C, "Devious Devices - Assets.esm") as Keyword
		zad_DeviousBelt			= Game.GetFormFromFile(0x00003330, "Devious Devices - Assets.esm") as Keyword
		zad_PermitAnal			= Game.GetFormFromFile(0x0000FACA, "Devious Devices - Assets.esm") as Keyword
	EndIf
	SetIntValue(Player, "CI_CumInflation_ON", 1)
	eventManager.StartEvents()
EndFunction

Function maintenance()
	if config.enabled
		;debug.notification("FHU Maintenance")
		RegisterForModEvent("HookOrgasmStart", "Orgasm")
		RegisterForModEvent("HookAnimationEnd", "FHUSexlabEnd")
		RegisterForModEvent("SexLabOrgasmSeparate", "OrgasmSeparate")
		RestoreActors()
	endif
	eventManager.Maintenance()
	(sr_inflateExternalEventManager as sr_inflateExternalEventController).RegisterModEvent()
	defAlias.Maintenance()
EndFunction

event FHUSexlabEnd(int tid, bool HasPlayer)
	Actor[] actors = sexlab.HookActors(tid)
	sslBaseAnimation anim = sexlab.HookAnimation(tid)
	
	Actor Victim = actors[0]
	actor Male = actors[1]
	log("Fill her up sex end")
	If anim.hasTag("Vaginal")
		if HasPlayer
			int i = actors.length
			InjectorPlayer = actors
			while i > 1
				i -= 1
				sr_InjectorFormlist.addform(actors[i])
			endwhile
;			debug.notification(tid)
;			Debug.Notification(victim.GetLeveledActorBase().GetName() + " took sperm from " + injectorPlayer[0].GetLeveledActorBase().GetName())
		else
			injector[0] = actors[1]
			injector[1] = actors[2]
			injector[2] = actors[3]
			injector[3] = actors[4]
			Debug.Notification(victim.GetLeveledActorBase().GetName() + " (NPC) took sperm from " + Male.GetLeveledActorBase().GetName())
		endif
	else
		log("No vaginal fail")
	endif
endevent

Event OrgasmSeparate(Form ActorRef, Int Thread)
	actor akActor = ActorRef as actor
	
	Actor[] actors = sexlab.HookActors(thread)
	sslBaseAnimation anim = sexlab.HookAnimation(thread)

	If anim.hasTag("Vaginal") || anim.hasTag("Oral") || anim.hasTag("Anal")
		If ( !sexlab.config.allowFFCum && sexlab.MaleCount(actors) < 1 && sexlab.CreatureCount(actors) < 1)
			return 
		EndIf
		
		int currentPool = 0
		If anim.hasTag("Vaginal")
			currentPool = Math.LogicalOr(currentPool, VAGINAL)
		EndIf
		If anim.hasTag("Anal")
			currentPool = Math.LogicalOr(currentPool, ANAL)
		EndIf
		If anim.hasTag("Oral")
			currentPool = Math.LogicalOr(currentPool, ORAL)
			;Debug.notification("Oral " + currentPool as int)
		EndIf

		If sexlab.Threads[Thread].hasPlayer
			dialogue.modMod(30)
			currentActors = actors
			currentType = currentPool
		EndIf
		
		String callback = ""
		int i = actors.length
		while i > 0
			i -= 1
			int cumSpot = anim.GetCum(i)
			int actorGender = sexlab.GetGender(actors[i])
		;	log(anim.name + " - cumSpot for position " + i + ": " + cumSpot)
			If akActor != actors[i]
				If ((actorGender == 1 && config.femaleEnabled) || (actorGender == 0 && config.maleEnabled)) && cumSpot != -1 && cumSpot != 2
					; only inflate if the actor is female (or male pretending to be female!) and the animation position has cum effect set for something else than oral only
					If actors[i] == player && sr_CumEffectsEnabled.GetValueInt() > 0
						RegisterForModEvent("fhu.playerInflated", "PlayerInflationDone")
						callback = "fhu.playerInflated"
					Else
						callback = ""
					EndIf
						int tid = QueueActor(actors[i], true, currentPool, GetCumAmountForActor(actors[i], actors), 3.0, callback)
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
	If anim.hasTag("Vaginal") || anim.hasTag("Oral") || anim.hasTag("Anal")
		If ( !sexlab.config.allowFFCum && sexlab.MaleCount(actors) < 1 && sexlab.CreatureCount(actors) < 1)
			return 
		EndIf
		
		int currentPool = 0
		If anim.hasTag("Vaginal")
			currentPool = Math.LogicalOr(currentPool, VAGINAL)
		EndIf
		If anim.hasTag("Anal")
			currentPool = Math.LogicalOr(currentPool, ANAL)
		EndIf
		If anim.hasTag("Oral")
			currentPool = Math.LogicalOr(currentPool, ORAL)
			;Debug.notification("Oral " + currentPool as int)
		EndIf

		If hasPlayer
			dialogue.modMod(30)
			currentActors = actors
			currentType = currentPool
		EndIf
		
		String callback = ""
		int i = actors.length
		while i > 0
			i -= 1
			int cumSpot = anim.GetCum(i)
			int actorGender = sexlab.GetGender(actors[i])
		;	log(anim.name + " - cumSpot for position " + i + ": " + cumSpot)
			;If ((actorGender == 1 && config.femaleEnabled) || (actorGender == 0 && config.maleEnabled)) && cumSpot != -1 && cumSpot != 2
			If ((actorGender == 1 && config.femaleEnabled) || (actorGender == 0 && config.maleEnabled)) && cumSpot != -1
				; only inflate if the actor is female (or male pretending to be female!) and the animation position has cum effect set for something else than oral only
				If actors[i] == player && sr_CumEffectsEnabled.GetValueInt() > 0
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

Event OnUpdate()
MfgConsoleFunc.ResetPhonemeModifier(DeflateActor)
EmotionWhenLeakage(DeflateActor)
	if DeflateActor.isinfaction(inflaterAnimatingFaction)
		if CumTypei < 3
			if GetInflationPercentage(DeflateActor) < 50
				FHUmoanSoundEffect(DeflateActor as ObjectReference, 1)
			else
				FHUmoanSoundEffect(DeflateActor as ObjectReference, 2)
			endif
			MouthOpen(DeflateActor, TongueOut, 0)
		elseif CumTypei == 3
			MouthOpen(DeflateActor, true, 0)
			if GetOralPercentage(DeflateActor) < 50
				FHUmoanSoundEffect(DeflateActor as ObjectReference, 1)
			else
				FHUmoanSoundEffect(DeflateActor as ObjectReference, 2)
			endif
		endif
	else
		FHUmoanSoundAfterEffect(DeflateActor as ObjectReference, 0)
		MouthOpen(DeflateActor, true, 5)
	endif
EndEvent

Function RegisterFHUUpdate()
	RegisterForSingleUpdate(10.0)
EndFunction

Function FHUmoanSoundEffect(ObjectReference aksource, int type); looping
{type 1 = mild, type 2 = hard, type 3 = deflation fail}
if sr_MoanSound.getvalue() == 1
	;if aksource == Player as objectreference && type < 3
	DeflateActor = aksource as actor
	RegisterFHUUpdate()
	;endif
	MoanType = Type
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
		if CumTypei == 1;Vaginal
			if type == 1
				sr_FHUCumDeflationVaginalMildMarker.play(aksource)
			elseif type == 2
				sr_FHUCumDeflationVaginalHardMarker.play(aksource)
			else
				sr_FHUMoanDenialMarker.play(aksource)
			endif
			;sr_FHUMoanMildMarker.play(aksource);No longer used. Save it for another update. Burst effect maybe
		elseif CumTypei == 2
			;sr_FHUMoanHardMarker.play(aksource);No longer used. Save it for another update. Burst effect maybe
			if type == 1
				sr_FHUCumDeflationAnalMildMarker.play(aksource)
			elseif type == 2
				sr_FHUCumDeflationAnalHardMarker.play(aksource)
			else
				sr_FHUMoanDenialMarker.play(aksource)
			endif
		elseif CumTypei == 3
			;sr_FHUMoanOralMarker.play(aksource)
			if type == 1
				sr_FHUCumDeflationOralMarker.play(aksource)
			elseif type == 2
				sr_FHUCumDeflationOralMarker.play(aksource)
			else
				sr_FHUCumDeflationOralFailMarker.play(aksource)
			endif
		endif
	endif
endif
EndFunction

Function FHUmoanSoundAfterEffect(ObjectReference aksource, int type);No loop
if sr_MoanSound.getvalue() == 1
	if sr_SexlabMoanSound.getvalue() == 1
		;Nothing
	else
		if cumtypei == 3
			sr_FHUCumDeflationOralAfterMarker.play(aksource)
		endif
	endif
endif

Utility.wait(6.0)
MfgConsoleFunc.ResetPhonemeModifier(DeflateActor)
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

int Function GetCreatureRaceint(Actor Target)
    ;humans don't have a RaceName string so it has to be checked first
    If Target.haskeyword(ActorTypeNPC)
        return -1
    EndIf
    
	String RaceName = sslCreatureAnimationSlots.GetRaceKey(Target.GetLeveledActorBase().GetRace())
    If RaceName == "Ashhoppers"
		return 0
	elseIf RaceName == "Bears"
		return 1
	elseIf RaceName == "Boars" || RaceName == "BoarsAny" || RaceName == "BoarsMounted"
		return 2
	elseIf RaceName == "Canines"
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
	Endif
EndFunction

Float Function VerifyRace(Actor CreatureActor)
String RaceName = GetCreatureRaceKey(CreatureActor)
float CreatureCumAmount = 0
	If RaceName == "Ashhoppers"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(0) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "Bears"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(1) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "Boars" || RaceName == "BoarsAny" || RaceName == "BoarsMounted"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(2) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "Canines"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(3) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "Chaurus"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(4) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "ChaurusHunters"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(5) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "ChaurusReapers"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(6) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "Chickens"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(7) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "Cows"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(8) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "Deers"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(9) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "Dogs"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(10) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "DragonPriests"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(11) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "Dragons"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(12) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "Draugrs"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(13) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "DwarvenBallistas"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(14) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "DwarvenCenturions"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(15) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "DwarvenSpheres"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(16) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "DwarvenSpiders"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(17) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "Falmers"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(18) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "FlameAtronach"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(19) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "Foxes"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(20) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "FrostAtronach"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(21) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "Gargoyles"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(22) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "Giants"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(23) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "Goats"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(24) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "Hagravens"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(25) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "Horkers"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(26) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "Horses"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(27) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "IceWraiths"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(28) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "Lurkers"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(29) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "Mammoths"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(30) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "Mudcrabs"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(31) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "Netches"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(32) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "Rabbits"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(33) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "Rieklings"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(34) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "SabreCats"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(35) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "Seekers"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(36) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "Skeevers"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(37) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "Slaughterfishes"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(38) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "StormAtronach"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(39) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "Spiders"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(40) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "LargeSpiders"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(41) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "GiantSpiders"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(42) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "Spriggans"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(43) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "Trolls"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(44) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "VampireLords"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(45) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "Werewolves"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(46) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	elseIf RaceName == "WispMothers" || RaceName == "Wisps"
		CreatureCumAmount = GetFloatValue(sr_CreatureRaceList.getat(47) as race, CREATURERACE_CUM_AMOUNT, 0.75) * cumMult
	Endif
Return CreatureCumAmount
EndFunction

Function InflateTo(Actor akActor, int h, float targetLevel = -1.0, float time, String callback = "")
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

Function CheckingLastActor(actor akactor)
form Male
race malerace
float chaurusnum = 0
float spidernum = 0
float humannum = 0
float ashHoppernum = 0
float Draugrnum = 0
float Spriggannum = 0
float StoneAtronachnum = 0
float beastcumnum = 0
float RaceAmount
;int i = injectorPlayer.length
int actori = -1
int i = sr_InjectorFormlist.getsize()
	while i > 0
		i -= 1
		Male = sr_InjectorFormlist.getat(i)
		actori = GetCreatureRaceint(Male as actor)
		;malerace = (injectorPlayer[i].GetActorBase()).getrace()
		;Debug.Notification(injectorPlayer[i].GetLeveledActorBase().GetName() + " sperm " + i)
		
		;if injectorPlayer[i]
		if Male
            if actori == -1
				humannum += 0.5
			elseif actori == 0
				ashHoppernum += GetFloatValue(sr_CreatureRaceList.getat(0) as race, CREATURERACE_CUM_AMOUNT, 0.75)
			elseif actori == 4
				chaurusnum += GetFloatValue(sr_CreatureRaceList.getat(4) as race, CREATURERACE_CUM_AMOUNT, 0.75)
			elseif actori == 5
				chaurusnum += GetFloatValue(sr_CreatureRaceList.getat(5) as race, CREATURERACE_CUM_AMOUNT, 0.75)
			elseif actori == 6
				chaurusnum += GetFloatValue(sr_CreatureRaceList.getat(6) as race, CREATURERACE_CUM_AMOUNT, 0.75)
			elseif actori == 13
				Draugrnum += GetFloatValue(sr_CreatureRaceList.getat(13) as race, CREATURERACE_CUM_AMOUNT, 0.75)
			elseif actori == 39
				StoneAtronachnum += GetFloatValue(sr_CreatureRaceList.getat(39) as race, CREATURERACE_CUM_AMOUNT, 0.75)
			elseif actori == 40
				spidernum += GetFloatValue(sr_CreatureRaceList.getat(40) as race, CREATURERACE_CUM_AMOUNT, 0.75)
			elseif actori == 41
				spidernum += GetFloatValue(sr_CreatureRaceList.getat(41) as race, CREATURERACE_CUM_AMOUNT, 0.75)
			elseif actori == 42
				spidernum += GetFloatValue(sr_CreatureRaceList.getat(42) as race, CREATURERACE_CUM_AMOUNT, 0.75)
			elseif actori == 43
				Spriggannum += GetFloatValue(sr_CreatureRaceList.getat(43) as race, CREATURERACE_CUM_AMOUNT, 0.75)
			else
				beastcumnum += 1
			endif
		else
			sr_InjectorFormlist.RemoveAddedForm(Male)
		endif
	endwhile

RaceAmount = chaurusnum + Draugrnum + spidernum + humannum + ashHoppernum + beastcumnum + Spriggannum + StoneAtronachnum
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
		elseif RandomSperm <= humannum + beastcumnum + Draugrnum + spidernum + chaurusnum + StoneAtronachnum
			spermtype = 6;StoneAtronach
		elseif RandomSperm <= humannum + beastcumnum + Draugrnum + spidernum + chaurusnum + StoneAtronachnum + ashHoppernum
			spermtype = 7;ashHopper
		endif
	else
		spermtype = 0
	endif
	
akactor.setfactionrank(sr_DARAnimatingType, spermtype)
EndFunction

;0human
;1;beastcum
;2;dragur
;3;spider
;4;Chaurus
;5;Spriggan
;6;StoneAtronach
;7;ashHopper

Function EquiprandomTongue(actor akActor, Bool BEquip)
if BEquip
	Tongueri = Utility.RandomInt(1, 10)
	if Tongueri == 1
		akActor.addItem(sr_linga1armor, 1, true)
		akActor.equipItem(sr_linga1armor, abSilent=true)
	elseif Tongueri == 2
		akActor.addItem(sr_linga2armor, 1, true)
		akActor.equipItem(sr_linga2armor, abSilent=true)
	elseif Tongueri == 3
		akActor.addItem(sr_linga3armor, 1, true)
		akActor.equipItem(sr_linga3armor, abSilent=true)
	elseif Tongueri == 4
		akActor.addItem(sr_linga4armor, 1, true)
		akActor.equipItem(sr_linga4armor, abSilent=true)
	elseif Tongueri == 5
		akActor.addItem(sr_linga5armor, 1, true)
		akActor.equipItem(sr_linga5armor, abSilent=true)
	elseif Tongueri == 6
		akActor.addItem(sr_linga6armor, 1, true)
		akActor.equipItem(sr_linga6armor, abSilent=true)
	elseif Tongueri == 7
		akActor.addItem(sr_linga7armor, 1, true)
		akActor.equipItem(sr_linga7armor, abSilent=true)
	elseif Tongueri == 8
		akActor.addItem(sr_linga8armor, 1, true)
		akActor.equipItem(sr_linga8armor, abSilent=true)
	elseif Tongueri == 9
		akActor.addItem(sr_linga9armor, 1, true)
		akActor.equipItem(sr_linga9armor, abSilent=true)
	elseif Tongueri == 10
		akActor.addItem(sr_linga10armor, 1, true)
		akActor.equipItem(sr_linga10armor, abSilent=true)
	endif
else
	if Tongueri == 1
		akActor.unequipItem(sr_linga1armor, abSilent=true)
		akActor.removeItem(sr_linga1armor, 99, true)
	elseif Tongueri == 2
		akActor.unequipItem(sr_linga2armor, abSilent=true)
		akActor.removeItem(sr_linga2armor, 99, true)
	elseif Tongueri == 3
		akActor.unequipItem(sr_linga3armor, abSilent=true)
		akActor.removeItem(sr_linga3armor, 99, true)
	elseif Tongueri == 4
		akActor.unequipItem(sr_linga4armor, abSilent=true)
		akActor.removeItem(sr_linga4armor, 99, true)
	elseif Tongueri == 5
		akActor.unequipItem(sr_linga5armor, abSilent=true)
		akActor.removeItem(sr_linga5armor, 99, true)
	elseif Tongueri == 6
		akActor.unequipItem(sr_linga6armor, abSilent=true)
		akActor.removeItem(sr_linga6armor, 99, true)
	elseif Tongueri == 7
		akActor.unequipItem(sr_linga7armor, abSilent=true)
		akActor.removeItem(sr_linga7armor, 99, true)
	elseif Tongueri == 8
		akActor.unequipItem(sr_linga8armor, abSilent=true)
		akActor.removeItem(sr_linga8armor, 99, true)
	elseif Tongueri == 9
		akActor.unequipItem(sr_linga9armor, abSilent=true)
		akActor.removeItem(sr_linga9armor, 99, true)
	elseif Tongueri == 10
		akActor.unequipItem(sr_linga10armor, abSilent=true)
		akActor.removeItem(sr_linga10armor, 99, true)
	endif
endif
EndFunction

;Function StartLeakage(Actor akActor, bool isAnal, int animate)
Function StartLeakage(Actor akActor, int CumType, int animate)
bool isAnal
if Cumtype == 2
	isAnal = true
else
	isAnal = false
endif

cumtypei = cumtype

	If !akActor.Is3DLoaded()
	;	log("Skipping animation for " + akActor.GetLeveledActorBase().GetName())
		return
	EndIf
;	log("Starting animation for " + akActor.GetLeveledActorBase().GetName())
	if Cumtype < 3
		if GetInflationPercentage(akactor) < 50
			FHUmoanSoundEffect(akActor as ObjectReference, 1)
		else
			FHUmoanSoundEffect(akActor as ObjectReference, 2)
		endif
	elseif Cumtype == 3
		if GetOralPercentage(akactor) < 50
			FHUmoanSoundEffect(akActor as ObjectReference, 1)
		else
			FHUmoanSoundEffect(akActor as ObjectReference, 2)
		endif
	endif
	
	If config.animDeflate
		if Cumtype < 3;Nostrip when oral
			StripActor(akActor)
		endif
		;StripCover(akActor, isAnal)
	MfgConsoleFunc.ResetPhonemeModifier(akActor)
	If Utility.RandomInt(0, 99) < 40 && sr_TongueEffect.getvalue() == 1
		EquiprandomTongue(akactor, true)
		EmotionWhenLeakage(akActor)
		MouthOpen(akActor, true, 0)
		TongueOut = true
	Else
		EmotionWhenLeakage(akActor)
		MouthOpen(akActor, false, 0)
		TongueOut = false
	EndIf

;		If Utility.RandomInt(0, 99) < 33
;			sexlab.ApplyCum(akActor, 5)
;		ElseIf isAnal
;			sexlab.ApplyCum(akActor, 3)
;		Else
;			sexlab.ApplyCum(akActor, 1)
;		EndIf
		
		If CumType == 1
			sexlab.AddCum(akActor, true, false, false)
		elseif CumType == 2
			sexlab.AddCum(akActor, false, false, true)
		elseif CumType == 3
			sexlab.AddCum(akActor, false, true, false)
		else
			sexlab.AddCum(akActor)
		endif
	
		if animate < 0
			SetIntValue(akActor, ANIMATING, -1)
			return
		endIf
		
		AnalDeflation = isAnal
		
		If akActor == Player
			Game.ForceThirdPerson()
		EndIf
	
		if (config.SFU_PlacePuddles)
			if Cumtype < 3
				ApplyPuddle(akActor, 0, 0, 1)
			elseif Cumtype == 3;oral
				ApplyPuddle(akActor, 26, 0, 1)
			endif
		endif
	
		If !akActor.IsOnMount()
			If animate == 2
				; Burst deflate 
			;	log("	burst deflate")
				if CumType == 1
					akActor.addItem(sr_VagLeak, 1, true)
					akActor.equipItem(sr_VagLeak, abSilent=true)
				elseif CumType == 2
					akActor.addItem(sr_AnalLeak, 1, true)
					akActor.equipItem(sr_AnalLeak, abSilent=true)
				elseif CumType == 3
					akActor.addItem(sr_OralLeak, 1, true)
					akActor.equipItem(sr_OralLeak, abSilent=true)
				EndIf
				SetIntValue(akActor, ANIMATING, 2)
				If akActor == player
					int handle = ModEvent.Create("dhlp-weapondrop")
					ModEvent.PushBool(handle, true)
					ModEvent.PushFloat(handle, 1.5)
					ModEvent.PushString(handle, "$FHU_BURST_WEAPON_DROP")
					ModEvent.PushString(handle, "$FHU_BURST_SPELL_DROP")
					If animate >= 10
						akActor.PlayIdle(BaboAnimsStart[animate - 10])
					Else
						animnum = Utility.RandomInt(0, BaboAnimsStart.length - 1)
						akActor.PlayIdle(BaboAnimsStart[animnum])
					EndIf
					If ModEvent.Send(handle)
						Utility.Wait(1.2)
					EndIf
				EndIf 
				Debug.SendAnimationEvent(akActor, "BleedOutStart")
			ElseIf animate == 1 || (animate == 0 && Utility.RandomInt(0, 99) < 80) || animate >= 10
				; normal, less-violent deflate 
			;	log("	normal deflate")
				If akActor.IsWeaponDrawn()
					akActor.SheatheWeapon()
					Utility.Wait(0.8)
				EndIf
				SetIntValue(akActor, ANIMATING, 1)
				if akActor == player
					Input.TapKey(Input.GetMappedKey("Forward"))
					Game.DisablePlayerControls()
				Else
					ActorUtil.AddPackageOverride(akActor, stayStillPackage, 100)
				EndIf
				If animate >= 10
					akActor.PlayIdle(BaboAnimsStart[animate - 10])
				Else
					if spermtype == 0
						if CumType == 1
							animnum = Utility.RandomInt(0, BaboAnimsStart.length - 1)
							akActor.PlayIdle(BaboAnimsStart[animnum])
							akActor.addItem(sr_VagLeak, 1, true)
							akActor.equipItem(sr_VagLeak, abSilent=true)
						elseif CumType == 2
							animnum = Utility.RandomInt(0, BaboAnimsAnusStart.length - 1)
							akActor.PlayIdle(BaboAnimsAnusStart[animnum])
							akActor.addItem(sr_AnalLeak, 1, true)
							akActor.equipItem(sr_AnalLeak, abSilent=true)
						elseif CumType == 3
							;animnum = Utility.RandomInt(0, BaboAnimsOral.length - 1)
							;akActor.PlayIdle(BaboAnimsOral[animnum])
							akActor.PlayIdle(BaboAnimsOralStart[0])
							akActor.addItem(sr_OralLeak, 1, true)
							akActor.equipItem(sr_OralLeak, abSilent=true)
						endif
					elseif spermtype == 1;BeastCum
						if CumType == 1
							animnum = Utility.RandomInt(0, BaboAnimsStart.length - 1)
							akActor.PlayIdle(BaboAnimsStart[animnum])
							akActor.addItem(sr_vagLeakBeast, 1, true)
							akActor.equipItem(sr_vagLeakBeast, abSilent=true)		
						elseif CumType == 2
							animnum = Utility.RandomInt(0, BaboAnimsAnusStart.length - 1)
							akActor.PlayIdle(BaboAnimsAnusStart[animnum])
							akActor.addItem(sr_analLeakBeast, 1, true)
							akActor.equipItem(sr_analLeakBeast, abSilent=true)
						elseif CumType == 3
							;animnum = Utility.RandomInt(0, BaboAnimsOral.length - 1)
							;akActor.PlayIdle(BaboAnimsOral[animnum])
							akActor.PlayIdle(BaboAnimsOralStart[0])
							akActor.addItem(sr_OralLeakBeast, 1, true)
							akActor.equipItem(sr_OralLeakBeast, abSilent=true)
						endif
						if sr_Cumvariation.getvalue() == 1
							if GetInflation(akactor) > 3.0 && CumType < 3
								akActor.addItem(sr_ThickCum, 1, true)
								akActor.equipItem(sr_ThickCum, abSilent=true)
							elseif GetOralCum(akactor) > 1.0 && CumType == 3
								akActor.addItem(sr_ThickCum, 1, true)
								akActor.equipItem(sr_ThickCum, abSilent=true)
							endif
						endif
					elseif spermtype == 2;dragur
						if CumType == 1
							animnum = Utility.RandomInt(0, BaboAnimsStart.length - 1)
							akActor.PlayIdle(BaboAnimsStart[animnum])
							akActor.addItem(sr_vagLeakRotten, 1, true)
							akActor.equipItem(sr_vagLeakRotten, abSilent=true)
						elseif CumType == 2
							animnum = Utility.RandomInt(0, BaboAnimsAnusStart.length - 1)
							akActor.PlayIdle(BaboAnimsAnusStart[animnum])
							akActor.addItem(sr_analLeakRotten, 1, true)
							akActor.equipItem(sr_analLeakRotten, abSilent=true)
						elseif CumType == 3
							;animnum = Utility.RandomInt(0, BaboAnimsOral.length - 1)
							;akActor.PlayIdle(BaboAnimsOral[animnum])
							akActor.PlayIdle(BaboAnimsOralStart[0])
							akActor.addItem(sr_OralLeakRotten, 1, true)
							akActor.equipItem(sr_OralLeakRotten, abSilent=true)
						endif
					elseif spermtype == 3;Spider
						if CumType == 1
							animnum = 3
							akActor.PlayIdle(BaboAnimsStart[animnum])
							akActor.addItem(sr_VagLeak, 1, true)
							akActor.equipItem(sr_VagLeak, abSilent=true)
						elseif CumType == 2
							animnum = Utility.RandomInt(0, BaboAnimsAnusStart.length - 1)
							akActor.PlayIdle(BaboAnimsAnusStart[animnum])
							akActor.addItem(sr_AnalLeak, 1, true)
							akActor.equipItem(sr_AnalLeak, abSilent=true)
						elseif CumType == 3
							;animnum = Utility.RandomInt(0, BaboAnimsOral.length - 1)
							;akActor.PlayIdle(BaboAnimsOral[animnum])
							akActor.PlayIdle(BaboAnimsOralStart[0])
							akActor.addItem(sr_OralLeak, 1, true)
							akActor.equipItem(sr_OralLeak, abSilent=true)
						endif
						if sr_Cumvariation.getvalue() == 1
							akActor.addItem(sr_SpiderEggs, 1, true)
							akActor.equipItem(sr_SpiderEggs, abSilent=true)
						endif
					elseif spermtype == 4;Chaurus
						if CumType == 1
							animnum = 3
							akActor.PlayIdle(BaboAnimsStart[animnum])
							akActor.addItem(sr_VagLeak, 1, true)
							akActor.equipItem(sr_VagLeak, abSilent=true)
						elseif CumType == 2
							animnum = Utility.RandomInt(0, BaboAnimsAnusStart.length - 1)
							akActor.PlayIdle(BaboAnimsAnusStart[animnum])
							akActor.addItem(sr_AnalLeak, 1, true)
							akActor.equipItem(sr_AnalLeak, abSilent=true)
						elseif CumType == 3
							;animnum = Utility.RandomInt(0, BaboAnimsOral.length - 1)
							;akActor.PlayIdle(BaboAnimsOral[animnum])
							akActor.PlayIdle(BaboAnimsOralStart[0])
							akActor.addItem(sr_OralLeak, 1, true)
							akActor.equipItem(sr_OralLeak, abSilent=true)
						endif
						if sr_Cumvariation.getvalue() == 1
							if GetInflation(akactor) >= 3.0 && CumType < 3
								akActor.addItem(sr_ChaurusLarvaeEggs, 1, true)
								akActor.equipItem(sr_ChaurusLarvaeEggs, abSilent=true)
							elseif GetInflation(akactor) < 3.0 && CumType < 3
								akActor.addItem(sr_ChaurusEggs, 1, true)
								akActor.equipItem(sr_ChaurusEggs, abSilent=true)
							elseif CumType == 3
								akActor.addItem(sr_ChaurusEggs, 1, true)
								akActor.equipItem(sr_ChaurusEggs, abSilent=true)
							endif
						endif
					elseif spermtype == 5;Spriggan
						if CumType == 1
							animnum = 3
							akActor.PlayIdle(BaboAnimsStart[animnum])
							akActor.addItem(sr_vagLeakGreen, 1, true)
							akActor.equipItem(sr_vagLeakGreen, abSilent=true)
						elseif CumType == 2
							animnum = Utility.RandomInt(0, BaboAnimsAnusStart.length - 1)
							akActor.PlayIdle(BaboAnimsAnusStart[animnum])
							akActor.addItem(sr_analLeakGreen, 1, true)
							akActor.equipItem(sr_analLeakGreen, abSilent=true)
						elseif CumType == 3
							;animnum = Utility.RandomInt(0, BaboAnimsOral.length - 1)
							;akActor.PlayIdle(BaboAnimsOral[animnum])
							akActor.PlayIdle(BaboAnimsOralStart[0])
							akActor.addItem(sr_OralLeakGreen, 1, true)
							akActor.equipItem(sr_OralLeakGreen, abSilent=true)
						endif
						if sr_Cumvariation.getvalue() == 1
							if GetInflation(akactor) >= 3.0 && CumType < 3
								akActor.addItem(sr_SprigganSlug, 1, true)
								akActor.equipItem(sr_SprigganSlug, abSilent=true)
							elseif GetInflation(akactor) < 3.0 && CumType < 3
								akActor.addItem(sr_ThickCumGreen, 1, true)
								akActor.equipItem(sr_ThickCumGreen, abSilent=true)
							elseif CumType == 3
								akActor.addItem(sr_ThickCumGreen, 1, true)
								akActor.equipItem(sr_ThickCumGreen, abSilent=true)
							endif
						endif
					elseif spermtype == 6;StoneAtronach
						if CumType == 1
							animnum = 3
							akActor.PlayIdle(BaboAnimsStart[animnum])
							akActor.addItem(sr_VagLeak, 1, true)
							akActor.equipItem(sr_VagLeak, abSilent=true)
						elseif CumType == 2
							animnum = Utility.RandomInt(0, BaboAnimsAnusStart.length - 1)
							akActor.PlayIdle(BaboAnimsAnusStart[animnum])
							akActor.addItem(sr_AnalLeak, 1, true)
							akActor.equipItem(sr_AnalLeak, abSilent=true)
						elseif CumType == 3
							;animnum = Utility.RandomInt(0, BaboAnimsOral.length - 1)
							;akActor.PlayIdle(BaboAnimsOral[animnum])
							akActor.PlayIdle(BaboAnimsOralStart[0])
							akActor.addItem(sr_OralLeak, 1, true)
							akActor.equipItem(sr_OralLeak, abSilent=true)
						endif
						if sr_Cumvariation.getvalue() == 1
							akActor.addItem(sr_AtronachStones, 1, true)
							akActor.equipItem(sr_AtronachStones, abSilent=true)
						endif
					elseif spermtype == 7;AshHopper
						if CumType == 1
							animnum = 3
							akActor.PlayIdle(BaboAnimsStart[animnum])
							akActor.addItem(sr_VagLeak, 1, true)
							akActor.equipItem(sr_VagLeak, abSilent=true)
						elseif CumType == 2
							animnum = Utility.RandomInt(0, BaboAnimsAnusStart.length - 1)
							akActor.PlayIdle(BaboAnimsAnusStart[animnum])
							akActor.addItem(sr_AnalLeak, 1, true)
							akActor.equipItem(sr_AnalLeak, abSilent=true)
						elseif CumType == 3
							;animnum = Utility.RandomInt(0, BaboAnimsOral.length - 1)
							;akActor.PlayIdle(BaboAnimsOral[animnum])
							akActor.PlayIdle(BaboAnimsOralStart[0])
							akActor.addItem(sr_OralLeak, 1, true)
							akActor.equipItem(sr_OralLeak, abSilent=true)
						endif
						if sr_Cumvariation.getvalue() == 1
							akActor.addItem(sr_AshHopperEggs, 1, true)
							akActor.equipItem(sr_AshHopperEggs, abSilent=true)
						endif
					endif
				EndIf
			EndIf
		EndIf
	EndIf
EndFunction

Function DeflateFailMotion(actor akactor, int cumi)
	MfgConsoleFunc.ResetPhonemeModifier(akActor)
	if Utility.RandomInt(0, 99) < 40 && sr_TongueEffect.getvalue() == 1
		EmotionWhenLeakage(akactor)
		MouthOpen(akActor, true, 0)
		TongueOut = true
	else
		EmotionWhenLeakage(akactor)
		MouthOpen(akActor, false, 0)
		TongueOut = false
	endif
	if cumi == 1
		akActor.PlayIdle(BaboSpermExpel)
	elseif cumi == 2
		akActor.PlayIdle(BaboSpermExpel);wip
	elseif cumi == 3
		akActor.PlayIdle(BaboSpermOralOut)
	endif
	FHUmoanSoundEffect(akactor as objectreference, 3)
EndFunction


Function MouthOpen(actor akActor, bool Tongue, int randomi)
{randomi 1-3 normal, 4-5 oralcum, 0 covers all}
if randomi == 0
	randomi = Utility.RandomInt(1, 5)
elseif randomi < 4
	randomi = Utility.RandomInt(1, 3)
endif
	if randomi == 1
		if Tongue
			MfgConsoleFunc.SetPhoneme(akActor,1,70)
			MfgConsoleFunc.SetPhoneme(akActor,14,30)
		Else
			MfgConsoleFunc.SetPhoneme(akActor,1,10)
			MfgConsoleFunc.SetPhoneme(akActor,2,40)
			MfgConsoleFunc.SetPhoneme(akActor,7,50)
		Endif
	elseif randomi == 2
		if Tongue
			MfgConsoleFunc.SetPhoneme(akActor,1,70)
			MfgConsoleFunc.SetPhoneme(akActor,14,30)
		Else
			MfgConsoleFunc.SetPhoneme(akActor,11,60)
			MfgConsoleFunc.SetPhoneme(akActor,12,70)
		Endif
	elseif randomi == 3
		if Tongue
			MfgConsoleFunc.SetPhoneme(akActor,0,40)
			MfgConsoleFunc.SetPhoneme(akActor,0,50)
		Else
			MfgConsoleFunc.SetPhoneme(akActor,0,30)
			MfgConsoleFunc.SetPhoneme(akActor,6,20)
		Endif
	elseif randomi == 4
		MfgConsoleFunc.SetPhoneme(akActor,0,70)
		MfgConsoleFunc.SetPhoneme(akActor,15,40)
	elseif randomi == 5
		MfgConsoleFunc.SetPhoneme(akActor,11,60)
		MfgConsoleFunc.SetPhoneme(akActor,5,30)
	endif
EndFunction

Function EmotionWhenLeakage(actor akActor)
;	MfgConsoleFunc.ResetPhonemeModifier(akActor) ; Remove any previous modifiers and phenomes

	Int random = Utility.RandomInt(1, 3)
	If random == 1
		akActor.SetExpressionOverride(3,100)	; Sad!!!  "This is... Sad!"
		MfgConsoleFunc.SetModifier(akActor,2,50)
		MfgConsoleFunc.SetModifier(akActor,3,50)
		MfgConsoleFunc.SetModifier(akActor,4,50)
		MfgConsoleFunc.SetModifier(akActor,5,50)
		MfgConsoleFunc.SetModifier(akActor,8,50)
		MfgConsoleFunc.SetModifier(akActor,12,30)
		MfgConsoleFunc.SetModifier(akActor,13,30)
	ElseIf random == 2
		akActor.SetExpressionOverride(1,100)	; "So much Orgasm!!"
		MfgConsoleFunc.SetModifier(akActor,0,40)
		MfgConsoleFunc.SetModifier(akActor,1,40)
		MfgConsoleFunc.SetModifier(akActor,11,70)
		MfgConsoleFunc.SetModifier(akActor,12,30)
		MfgConsoleFunc.SetModifier(akActor,13,30)
	Else
		akActor.SetExpressionOverride(3,100)	; "I cna't bear it any longer!!"
		MfgConsoleFunc.SetModifier(akActor,0,20)
		MfgConsoleFunc.SetModifier(akActor,1,20)
		MfgConsoleFunc.SetModifier(akActor,11,70)
		MfgConsoleFunc.SetModifier(akActor,12,30)
		MfgConsoleFunc.SetModifier(akActor,13,30)
	EndIf
EndFunction

Function StopLeakage(Actor akActor)
	int anim = GetIntValue(akActor, ANIMATING,0)
	If anim > 0
		If anim == 1
			;if AnalDeflation
			;	akActor.PlayIdle(BaboAnimsAnusEnd[animnum])
			;else
			;	akActor.PlayIdle(BaboAnimsEnd[animnum])
			;endif
			if cumtypei == 1
				akActor.PlayIdle(BaboAnimsEnd[animnum])
			elseif cumtypei == 2
				akActor.PlayIdle(BaboAnimsAnusEnd[animnum])
			elseif cumtypei == 3
				akActor.PlayIdle(BaboAnimsOralEnd[0])
			endif
		ElseIf anim == 2
			Debug.SendAnimationEvent(akActor, "BleedOutStop")
		EndIf
		UnsetIntValue(akActor, ANIMATING)
	ElseIf anim < 0
		return
	EndIf
	
	if akActor == player
		Game.EnablePlayerControls()
	Else
		MfgConsoleFunc.ResetPhonemeModifier(akActor);Player expression is controlled here(OnKeyUp)
		ActorUtil.RemovePackageOverride(akActor, stayStillPackage)
	EndIf

	if spermtype == 1
		akActor.unequipItem(sr_analLeakBeast, abSilent=true)
		akActor.unequipItem(sr_vagLeakBeast, abSilent=true)
		akActor.unequipItem(sr_ThickCum, abSilent=true)
		akActor.unequipItem(sr_OralLeakBeast, abSilent=true)
		akActor.removeItem(sr_analLeakBeast, 99, true)
		akActor.removeItem(sr_vagLeakBeast, 99, true)
		akActor.removeItem(sr_ThickCum, 99, true)
		akActor.removeItem(sr_OralLeakBeast, 99, true)
	elseif spermtype == 2
		akActor.unequipItem(sr_analLeakRotten, abSilent=true)
		akActor.removeItem(sr_vagLeakRotten, 99, true)
		akActor.unequipItem(sr_OralLeakRotten, abSilent=true)
		akActor.removeItem(sr_OralLeakRotten, 99, true)
	elseif spermtype == 3
		akActor.unequipItem(sr_SpiderEggs, abSilent=true)
		akActor.removeItem(sr_SpiderEggs, 99, true)
	elseif spermtype == 4
		akActor.unequipItem(sr_ChaurusEggs, abSilent=true)
		akActor.unequipItem(sr_ChaurusLarvaeEggs, abSilent=true)
		akActor.removeItem(sr_ChaurusEggs, 99, true)
		akActor.removeItem(sr_ChaurusLarvaeEggs, 99, true)
	elseif spermtype == 5
		akActor.unequipItem(sr_analLeakGreen, abSilent=true)
		akActor.unequipItem(sr_vagLeakGreen, abSilent=true)
		akActor.unequipItem(sr_SprigganSlug, abSilent=true)
		akActor.unequipItem(sr_ThickCumGreen, abSilent=true)
		akActor.unequipItem(sr_OralLeakGreen, abSilent=true)
		akActor.removeItem(sr_analLeakGreen, 99, true)
		akActor.removeItem(sr_vagLeakGreen, 99, true)
		akActor.removeItem(sr_SprigganSlug, 99, true)
		akActor.removeItem(sr_ThickCumGreen, 99, true)
		akActor.removeItem(sr_OralLeakGreen, 99, true)
	elseif spermtype == 6
		akActor.unequipItem(sr_AtronachStones, abSilent=true)
		akActor.removeItem(sr_AtronachStones, 99, true)
	elseif spermtype == 7
		akActor.unequipItem(sr_AshHopperEggs, abSilent=true)
		akActor.removeItem(sr_AshHopperEggs, 99, true)
	endif

	akActor.unequipItem(sr_VagLeak, abSilent=true)
	akActor.unequipItem(sr_AnalLeak, abSilent=true)
	akActor.unequipItem(sr_OralLeak, abSilent=true)
	
	;akActor.unequipItem(TongueA, abSilent=true)
	EquiprandomTongue(akactor, false)
	akActor.removeItem(sr_VagLeak, 99, true)
	akActor.removeItem(sr_AnalLeak, 99, true)
	akActor.removeItem(sr_OralLeak, 99, true)
	;akActor.removeItem(TongueA, 99, true)
	
	;MfgConsoleFunc.ResetPhonemeModifier(akActor) ; Remove any previous modifiers and phenomes
	
	If anim > 0
		UnstripActor(akActor)
	EndIf
EndFunction

Function RestoreActors()
	int n = FormListCount(self, INFLATED_ACTORS) 
	while n > 0
		n -= 1
		Actor a = FormListGet(self, INFLATED_ACTORS, n) as Actor
		log("Restoring inflation for " + a.GetLeveledActorBase().GetName() + "...")
		If config.bellyScale
			if config.Bodymorph
				;SetBellyMorphValue(a, GetInflation(a), "PregnancyBelly")
				SetBellyMorphValue(a, GetInflation(a), InflateMorph)
				if InflateMorph2 != ""
					SetBellyMorphValue(a, GetInflation(a), InflateMorph2)
				endIf
				if InflateMorph3 != ""
					SetBellyMorphValue(a, GetInflation(a), InflateMorph3)
				endif
				if InflateMorph4 != ""
					SetBellyMorphValue(a, GetOralCum(a), InflateMorph4)
				endif
			Else
				SetNodeScale(a, BELLY_NODE, GetInflation(a))
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
			if (Male.GetBaseObject() as Actorbase).getsex() == 0
				FertilityEventGo("FertilityModeAddSperm", a as form, Male.Getleveledactorbase().getname(), Male as form)
				If fullness > sr_SendingSpermDataCriterion.getvalue() as int
					FertilityEventGo("FertilityModeImpregnate", a as form, Male.Getleveledactorbase().getname(), None)
				EndIf
				Utility.wait(1.0)
			endif
		endwhile
	else
		i = injector.length

		while i > 0
			i -= 1
			if (injector[i].GetActorBase()).getsex() == 0
				Male = injector[i]
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
		;i = injectorPlayer.length
		i = sr_InjectorFormlist.getsize()
		while i > 0
			i -= 1
			Male = sr_InjectorFormlist.getat(i) as actor
			if (Male.GetBaseObject() as Actorbase).getsex() == 0
				Male.SendModEvent("BeeingFemale", "AddSperm", a.GetFormID())
				Utility.wait(1.0)
			endif
		endwhile
	else
		i = injector.length

		while i > 0
			i -= 1
			if ((injector[i].GetActorBase()).getsex() == 0) && (Player != injector[i])
				;debug.notification("yes male")
				Male = injector[i]
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





State MonitoringInflation
	Event OnBeginState()
		log("Starting inflation monitor")
		RegisterForSingleUpdateGameTime(1.0)
	EndEvent
	
	Event OnUpdateGameTime()
		
		int n = FormListCount(self, INFLATED_ACTORS) 
		if n > 0
			float startTime = Utility.GetCurrentGameTime()
			While n > 0
				
				int queued = 0
				while queued < threads.length && n > 0
				
					n -= 1
					Actor a = FormListGet(self, INFLATED_ACTORS, n) as Actor
					if a && !a.IsDead() && !a.IsInCombat() && a.GetCurrentScene() == none && !a.IsInFaction(slAnimatingFaction)
						float lastVagTime = GetFloatValue(a, LAST_TIME_VAG) 
						float lastAnalTime = GetFloatValue(a, LAST_TIME_ANAL)
						float lastoralTime = GetFloatValue(a, LAST_TIME_ORAL)
						bool deflateVag = lastVagTime > 0.0 && ( GameDaysPassed.GetValue() - lastVagTime ) * 24 >= config.minInflationTime; Needs improvement
						bool deflateAnal = lastAnalTime > 0.0 && ( GameDaysPassed.GetValue() - lastAnalTime ) * 24 >= config.minInflationTime
						bool deflateOral = lastoralTime > 0.0 && ( GameDaysPassed.GetValue() - lastoralTime ) * 24 >= config.minInflationTime
						
						If deflateAnal && deflateVag ; only deflate once per tic
							If Utility.RandomInt(0, 99) < 50 || isPlugged(a) == 2;Why either one at a time?
								deflateAnal = false
							Else
								deflateVag = false
							EndIf
						EndIf

					;	log("Deflate actor " + a.GetLeveledActorBase().GetName() + "? Anal: " + deflateAnal +", Vaginal: " + deflateVag)
						
						int plugged = isPlugged(a)	
						if sr_OnEventSpermNPC.getvalue() == 1 && !(a == player)
							FertilityChance(a)
						elseif sr_OnEventSpermPlayer.getvalue() == 1 && (a == player)
							FertilityChance(a)
						endif
						
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
									tid = QueueActor(a, false, VAGINAL, Config.SpermRemovalAmountvag, defTime)
									queued += 1
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
								else
									if sr_OnEventAbsorbSperm.getvalue() == 1
										tid = QueueAbsorbActor(a, false, ANAL, Config.SpermRemovalAmountanal, defTime)
										queued += 1
									endif
								endif
							endIf
						EndIf
						
						if !deflateVag && !deflateAnal && Utility.RandomInt(0, 99) < GetDeflateChance(a)
							if sr_OnEventNoDeflation.getvalue() == 0
								tid = QueueActor(a, false, ORAL, Config.SpermRemovalAmountoral, defTime)
								queued += 1
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
					;	FormListRemove(self, INFLATED_ACTORS, FormListGet(self, INFLATED_ACTORS, n), true)
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


Function ResetActors(bool force = false)
	GoToState("")
	int n = FormListCount(self, INFLATED_ACTORS) 
	while n > 0
		n -= 1
		Actor a = FormListGet(self, INFLATED_ACTORS, n) as Actor
		log("Resetting " + a.GetLeveledActorBase().GetName() + "...")
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
			SetFloatValue(a, INFLATION_AMOUNT, 0.0)
			SetFloatValue(a, CUM_ORAL, 0.0)
		Else
			RemoveNodeScale(a, BELLY_NODE)
		Endif
		
		UnsetFloatValue(a, INFLATION_AMOUNT)
		UnsetFloatValue(a, CUM_ANAL)
		UnsetFloatValue(a, CUM_VAGINAL)
		UnsetFloatValue(a, CUM_ORAL)
		UnsetFloatValue(a, LAST_TIME_ANAL)
		UnsetFloatValue(a, LAST_TIME_VAG)
		UnsetFormValue(a, CHEST_ARMOR)
		a.RemoveSpell(sr_inflateBurstSpell)
		UnencumberActor(a)
		RemoveFaction(a)
	EndWhile
	FormListClear(self, INFLATED_ACTORS)
	
	; Make sure player is always reset
	log("Resetting " + player.GetLeveledActorBase().GetName() + "...")
	if config.Bodymorph
		;SetBellyMorphValue(player, 0.0, "PregnancyBelly")
		SetBellyMorphValue(player, 0.0, InflateMorph)
		if InflateMorph2 != ""
			SetBellyMorphValue(player, 0.0, InflateMorph2)
		endIf
		if InflateMorph3 != ""
			SetBellyMorphValue(player, 0.0, InflateMorph3)
		endif
		if InflateMorph4 != ""
			SetBellyMorphValue(player, 0.0, InflateMorph4)
		endif
		SetFloatValue(player, INFLATION_AMOUNT, 0.0)
		SetFloatValue(player, CUM_ORAL, 0.0)
	Else
		RemoveNodeScale(player, BELLY_NODE)
	Endif
	UnsetFloatValue(player, INFLATION_AMOUNT)
	UnsetFloatValue(player, CUM_ANAL)
	UnsetFloatValue(player, CUM_VAGINAL)
	UnsetFloatValue(player, LAST_TIME_ANAL)
	UnsetFloatValue(player, LAST_TIME_VAG)
	UnsetFormValue(player, CHEST_ARMOR)
	player.RemoveSpell(sr_inflateBurstSpell)
	UnencumberActor(player)
	RemoveFaction(player)
	SendPlayerCumUpdate(0.0, true)
	SendPlayerCumUpdate(0.0, false)
	
	notify("$FHU_ACTORS_RESET")
EndFunction

Function ResetActor(Actor a)
	log("Resetting " + a.GetLeveledActorBase().GetName() + "...")
	if config.Bodymorph
		;SetBellyMorphValue(player, 0.0, "PregnancyBelly")
		SetBellyMorphValue(player, 0.0, InflateMorph)
		if InflateMorph2 != ""
			SetBellyMorphValue(a, 0.0, InflateMorph2)
		endIf
		if InflateMorph3 != ""
			SetBellyMorphValue(a, 0.0, InflateMorph3)
		endif
		if InflateMorph4 != ""
			SetBellyMorphValue(a, 0.0, InflateMorph4)
		endif
		SetFloatValue(a, INFLATION_AMOUNT, 0.0)
		SetFloatValue(a, CUM_ORAL, 0.0)
	Else
		RemoveNodeScale(a, BELLY_NODE)
	Endif
	UnsetFloatValue(a, INFLATION_AMOUNT)
	UnsetFloatValue(a, CUM_ANAL)
	UnsetFloatValue(a, CUM_VAGINAL)
	UnsetFloatValue(a, CUM_ORAL)
	UnsetFloatValue(a, LAST_TIME_ANAL)
	UnsetFloatValue(a, LAST_TIME_VAG)
	UnsetFloatValue(a, LAST_TIME_ORAL)
	UnsetFormValue(a, CHEST_ARMOR)
	a.RemoveSpell(sr_inflateBurstSpell)
	UnencumberActor(a)
	RemoveFaction(a)
	FormListRemove(self, INFLATED_ACTORS, a, true)
	If a == player
		SendPlayerCumUpdate(0.0, true)
		SendPlayerCumUpdate(0.0, false)
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
			ApplyCumEffect(currentActors[n].GetLeveledActorBase().GetRace(), currentType, startVag, startAn)
		Elseif currentActors[n] != none && currentActors[n] != player && !currentActors[n].haskeyword(ActorTypeNPC)
			ApplyCreatureCumEffect(sr_CreatureRaceList.getat(GetCreatureRaceint(currentActors[n])) as race, currentType, startVag, startAn)
		EndIf

	EndWhile
	currentType = 0
	currentActors = new Actor[1]
EndFunction

Function ApplyCreatureCumEffect(Race rce, int pool, float startVag, float startAn)
	if pool <= 0 
		warn("Tried to apply cum effect without a pool.")
		return
	EndIf
	log("Trying to apply cum effect for " + rce.GetName())
	int n = FormListCount(rce, CREATURERACE_CUM_EFFECTS)
	log("Found " + n + " effects.")
	if n < 1
		return
	EndIf
	Spell theSpell = FormListGet(rce, CREATURERACE_CUM_EFFECTS, Utility.RandomInt(0, n  - 1)) as Spell
	log("Applying " + theSpell.GetName())
	
	bool isAnal
	if(Math.LogicalAnd(pool, ANAL) && !Math.LogicalAnd(pool, VAGINAL))
		isAnal = true
	elseIf(!Math.LogicalAnd(pool, ANAL) && Math.LogicalAnd(pool, VAGINAL))
		isAnal = false
	Else ; both
		isAnal = Utility.RandomInt(0,1) == 1
	EndIf
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
EndFunction

Function ApplyCumEffect(Race rce, int pool, float startVag, float startAn)
	if pool <= 0 
		warn("Tried to apply cum effect without a pool.")
		return
	EndIf
	log("Trying to apply cum effect for " + rce.GetName())
	int n = FormListCount(rce, RACE_CUM_EFFECTS)
	log("Found " + n + " effects.")
	if n < 1
		return
	EndIf
	Spell theSpell = FormListGet(rce, RACE_CUM_EFFECTS, Utility.RandomInt(0, n  - 1)) as Spell
	log("Applying " + theSpell.GetName())
	
	bool isAnal
	if(Math.LogicalAnd(pool, ANAL) && !Math.LogicalAnd(pool, VAGINAL))
		isAnal = true
	elseIf(!Math.LogicalAnd(pool, ANAL) && Math.LogicalAnd(pool, VAGINAL))
		isAnal = false
	Else ; both
		isAnal = Utility.RandomInt(0,1) == 1
	EndIf
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
		UnequipArmor(akActor)
	endIf
EndFunction

Function StripCover(Actor akActor, bool isAnal)
	If config.strip
		int slot = 0x1000000
		If isAnal
			slot = 0x40000
		EndIf
		Form current = SexLab.StripSlot(akActor, slot)
		If current
			SetFormValue(akActor, COVER_PIECE, current)
		EndIf
	EndIf
EndFunction

Function UnstripActor(Actor akActor)
	EquipArmor(akActor)
EndFunction

Function UnequipArmor(Actor target)
wornforms = new Armor[32]

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
			if (!SexLabUtil.HasKeywordSub(curr_armor, "NoStrip"))
				wornforms[index] = curr_armor
				Target.UnequipItem(curr_armor, false, true)
				index += 1
			EndIf
		endif
	endif
		thisSlot *= 2 ;double the number to move on to the next slot
	endWhile
	
EndFunction

Function EquipArmor(Actor target)

int index = wornforms.length

	while index > 0
		index -= 1
		if wornforms[index]
			Target.equipItem(wornforms[index], false, true)
		EndIf
	endWhile
	
EndFunction





Function EncumberActor(Actor a)
	If !config.encumber
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
		return plugged == 3 == type || ( plugged == 1 == type && GetVaginalCum(akActor) > 0.0 ) || ( plugged == 2 == type && GetAnalCum(akActor) > 0.0 )
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
	float an = GetFloatValue(a, CUM_ANAL)
	float vag = GetFloatValue(a, CUM_VAGINAL)
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
	If value != 0.0
		if sr_SLIF.getvalue() == 1
			if MorphName == InflateMorph && config.FHUMorphSLIF
				SLIF_Morph.morph(akActor, "Fill Her Up", morphName, value/10, FHU_KEY)
			else
				NiOverride.SetBodyMorph(akActor, MorphName, FHU_KEY, value/10)
			endif
			
			if MorphName == InflateMorph2 && config.FHUMorphSLIF2
				SLIF_Morph.morph(akActor, "Fill Her Up", morphName, value/10, FHU_KEY)
			else
				NiOverride.SetBodyMorph(akActor, MorphName, FHU_KEY, value/10)
			endif
			
			if MorphName == InflateMorph3 && config.FHUMorphSLIF3
				SLIF_Morph.morph(akActor, "Fill Her Up", morphName, value/10, FHU_KEY)
			else
				NiOverride.SetBodyMorph(akActor, MorphName, FHU_KEY, value/10)
			endif

			if MorphName == InflateMorph4 && config.FHUMorphSLIF4
				SLIF_Morph.morph(akActor, "Fill Her Up", morphName, value/10, FHU_KEY)
			else
				NiOverride.SetBodyMorph(akActor, MorphName, FHU_KEY, value/10)
			endif
		else
			NiOverride.SetBodyMorph(akActor, MorphName, FHU_KEY, value/10)
		endif
	Else
		if sr_SLIF.getvalue() == 1
			if MorphName == InflateMorph && config.FHUMorphSLIF
				SLIF_Morph.morph(akActor, "Fill Her Up", morphName, value/10, FHU_KEY)
			else
				NiOverride.SetBodyMorph(akActor, MorphName, FHU_KEY, value/10)
				NiOverride.ClearBodyMorph(akActor, MorphName, FHU_KEY)
			endif
			
			if MorphName == InflateMorph2 && config.FHUMorphSLIF2
				SLIF_Morph.morph(akActor, "Fill Her Up", morphName, value/10, FHU_KEY)
			else
				NiOverride.SetBodyMorph(akActor, MorphName, FHU_KEY, value/10)
				NiOverride.ClearBodyMorph(akActor, MorphName, FHU_KEY)
			endif
			
			if MorphName == InflateMorph3 && config.FHUMorphSLIF3
				SLIF_Morph.morph(akActor, "Fill Her Up", morphName, value/10, FHU_KEY)
			else
				NiOverride.SetBodyMorph(akActor, MorphName, FHU_KEY, value/10)
				NiOverride.ClearBodyMorph(akActor, MorphName, FHU_KEY)
			endif
			
			if MorphName == InflateMorph4 && config.FHUMorphSLIF4
				SLIF_Morph.morph(akActor, "Fill Her Up", morphName, value/10, FHU_KEY)
			else
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
