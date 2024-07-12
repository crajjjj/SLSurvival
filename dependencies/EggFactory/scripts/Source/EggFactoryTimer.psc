Scriptname EggFactoryTimer extends Quest

ReferenceAlias[] property Victims auto

globalvariable[] property PregSpeedVars auto
globalvariable[] property SkipEarlyVars auto
globalvariable[] property TwinChanceVars auto
globalvariable[] property ExtraChanceVars auto
globalvariable[] property WaterGrowthVars auto
faction[] property AspectFactions auto
spell[] property AspectAbilites auto
int[] property DragonSoulCount auto
bool[] property UncurseQueued auto
quest property MQ104 auto

float[] property lastgrowth auto 

spell[] property LaborEffects auto
; 0 not pregnant
; 1 bird
; 2 spider
; 3 fish
; 4 chauras
; 5 large bird
; 6 dragon

int[] property PregTypes auto

int[] property gestation_cur auto
int[] property gestation_total auto
int[] property rapidpoints auto
bool[] property doingsecondload auto
int[] property twinscount auto

globalvariable property EggFactoryBellyMult auto
globalvariable property EggFactoryMaxScale auto
globalvariable property EggFactoryMinMultiples auto
globalvariable property EggFactoryMaxMultiples auto
globalvariable property EggFactoryShuffleMode auto
globalvariable property EggFactoryFirstPerson auto

miscobject property eggfactorycharm auto

faction property EggFactoryPregCheck auto

keyword property eggfactoryenchhold auto
keyword property eggfactoryenchfertile auto

WICourierScript property CourierScript auto
book Property EggFactoryCourierNote auto
bool property notesent auto

potion property foodeggpotion auto
potion property eggfactoryuncurse auto

armor property eggfactoryfluid auto
spell property eggfactorylabordebuff auto

bool property eggfactory340check auto

bool eventick = true

; labor system vars
; per pregtype vars [7]
int[] property EggCountsMax auto
int[] property EggCountsMin auto
int[] property TicsToNextPush auto
int[] property PushesToLay auto
int[] property EggCountsLeft auto
int[] property LaborRates auto
int[] property LaborStates auto
float[] property bellyscalemults auto

globalvariable[] property LaborRateVars auto

sound property EggFactoryLaborMale auto
sound property EggFactoryLaborFemale auto

faction property PlayerFaction auto
faction property EggFactoryCounter auto
GlobalVariable Property EggFactoryVoiceVolume auto

miscobject[] property Eggitems auto

bool Function IsChildRace(Race ThisRace)
	string RaceName = ThisRace.GetName()
	bool IsChild = false
	
	if(StringUtil.Find(RaceName, "Child") != -1)
		IsChild = true
	elseif(StringUtil.Find(RaceName, "Little") != -1)
		IsChild = true
	elseif(StringUtil.Find(RaceName, "117") != -1)
		IsChild = true
	elseif(StringUtil.Find(RaceName, "Enfant") != -1)
		IsChild = true
	elseif(StringUtil.Find(RaceName, "Elin") != -1)
		IsChild = true
	elseif(StringUtil.Find(RaceName, "Young") != -1)
		IsChild = true
	elseif(StringUtil.Find(RaceName, "Monli") != -1)
		IsChild = true
	endif
	
	return IsChild

EndFunction

Function SayMessage(Actor who, string what)
	bool secondperson=false
	bool firstperson=false
	string mymessage
	
	if(who == Game.GetPlayer())
		secondperson=true
		firstperson=EggFactoryFirstPerson.GetValue() as bool
	endif
	
	if(what == "cramps")
		if(secondperson==true)
			if(firstperson==true)
				mymessage = "I'm feeling mild cramps..."
			else
				mymessage = "You begin to feel mild cramps."
			endif
		else
			mymessage = who.GetDisplayName() + ": I feel it, soon."
		endif
	elseif(what == "labor")
		if(secondperson==true)
			if(firstperson==true)
				mymessage = "Ooh! I have to push!"
			else
				mymessage = "You have to push!"
			endif
		else
			mymessage = who.GetDisplayName() + ": Oh! Here they come!"
		endif
	elseif(what == "water")
		if(secondperson==true)
			if(firstperson==true)
				mymessage = "I think my water just broke!"
			else
				mymessage = "You think your water just broke."
			endif
		else
			mymessage = who.GetDisplayName() + ": My water just broke. Soon!"
		endif
	elseif(what == "finished")
		if(secondperson==true)
			if(firstperson==true)
				mymessage = "I'm finally finished."
			else
				mymessage = "You're finally finished."
			endif
		else
			mymessage = who.GetDisplayName() + ": That's all of them, for now."
		endif
	elseif(what == "maybenot")
		if(secondperson==true)
			mymessage = "Or maybe not..."
		else
			mymessage = who.GetDisplayName() + ": Or maybe not..."
		endif
	elseif(what == "dispelled")
		if(secondperson==true)
			if(firstperson==true)
				mymessage = "I can feel the curse fading away."
			else
				mymessage = "The curse has faded from you."
			endif
		else
			mymessage = who.GetDisplayName() + ": It seems the curse has worn off."
		endif
	elseif(what == "breasts")
		if(secondperson==true)
			if(firstperson==true)
				mymessage = "My breasts feel so heavy."
			else
				mymessage = "Your breasts feel so heavy and sensitive."
			endif
		else
			mymessage = who.GetDisplayName() + ": Ow, my breasts feel so heavy."
		endif
	endif

	debug.notification(mymessage)
	
EndFunction

int function GetAdjustedDragonSouls(actor who)
	if(mq104.GetStage() < 90 && who == Game.GetPlayer())
		return -1
	else
		return who.GetActorValue("dragonsouls") as int
	endif
endfunction

function AddFluidAndDebuff(actor who)
	if(who.GetItemCount(eggfactoryfluid) < 1)
		who.AddItem(eggfactoryfluid,1,true)
	endif
	if(!who.isequipped(eggfactoryfluid))
		who.EquipItem(eggfactoryfluid,true,true)	
	endif
	if!(who.hasspell(eggfactorylabordebuff))
		who.addspell(eggfactorylabordebuff,false)
	endif
endfunction


Function AddToTracker(Actor who)
	int rank = who.GetFactionRank(EggFactoryPregCheck)
	if(rank == -2)
		who.AddToFaction(EggFactoryPregCheck)
	endif
	who.SEtFactionRank(EggFactoryPregCheck,1)
EndFunction

Function IncrementAspect(Actor Who, int pregtype)
	faction AFaction = AspectFactions[pregtype]

	int rank = who.GetFactionRank(AFAction)
	if(rank == -2)
		who.AddToFaction(AFaction)
	elseif (rank == 4) ; advancing to 5 now, add the aspect
		who.addspell(AspectAbilites[pregtype])
	endif
	who.ModFactionRank(AFaction,1)	
EndFunction

Float Function CalcAdjustedBellyScale(int stage, int twins)
	float adjusted_belly_scale = stage * 0.1
		
	adjusted_belly_scale *= (1.0+(twins*0.5))
	adjusted_belly_scale *= EggFactoryBellyMult.GetValue()
		
	if(adjusted_belly_scale > EggFactoryMaxScale.GetValue())
		adjusted_belly_scale = EggFactoryMaxScale.GetValue()
	endif
		
	return (adjusted_belly_scale)	
EndFunction

int function GetTwins (Actor who, int chance)
	int twins = EggfactoryMinMultiples.GetValue() as int
	
;	if(who.getfactionrank(eggfactoryfertilefaction) > 0)
;		twins += 1
;	endif
	
	if (who.haseffectkeyword(eggfactoryenchfertile))
		twins += 1
	endif
	
	chance += 5 * who.GetItemCount(eggfactorycharm)
		
	while (twins < EggfactoryMaxMultiples.GetValue() && utility.randomfloat(0.0,100.0) < chance)
		twins += 1
	endwhile
		
	return twins
EndFunction

function InitPregnancy(int i,int startpoint)
	gestation_cur[i]=startpoint
	gestation_total[i]=Utility.RandomInt(55,65)
	twinscount[i]=GetTwins(victims[i].getactorref(),TwinChanceVars[pregtypes[i]].GetValue() as int)
	lastgrowth[i]=Utility.GetCurrentGameTime()*24.0
endfunction

function AdvanceGestation(int i)
	int pregtype = pregtypes[i]
	;debug.trace("Advance gestation running")
	
	actor victim = victims[i].getactorref()
	if(gestation_total[i]==0) ; new pregnancy
		InitPregnancy(i,0)
	else
		gestation_cur[i] = gestation_cur[i] + 1
		if(victim.haseffectkeyword(eggfactoryenchhold) && gestation_cur[i] > 50)
			gestation_total[i] = gestation_total[i] + 1
		endif
	endif
	
	if (gestation_cur[i] == 40 && victim.is3dloaded())
		SayMessage(victim, "breasts")
	endif
	
	if (gestation_cur[i] >= 40)
		int bhandle = ModEvent.Create("EggFactory_LactationStartGrow")
		if (bhandle)
			modevent.pushform(bhandle, victim)
			modevent.send(bhandle)
		endif
	endif
	
	if (gestation_cur[i] >= 50)
		int bhandle = ModEvent.Create("EggFactory_LactationStartMilk")
		if (bhandle)
			modevent.pushform(bhandle, victim)
			modevent.send(bhandle)
		endif
	endif
	
	if (gestation_cur[i] == (gestation_total[i] - 1) && victim.is3dloaded())
		SayMessage(victim, "cramps")
	endif
	
	if (gestation_cur[i] == gestation_total[i] && victim.is3dloaded())
		SayMessage(victim, "water")
		AddFluidAndDebuff(victim)
	endif
		
	if(gestation_cur[i] > gestation_total[i])
		laborstates[i] = 1
;		if(!victim.HasSpell(laboreffects[pregtype]))
;			victim.addspell(laboreffects[pregtype],false)
;			utility.wait(0.5)
;			SayMessage(victim,"labor")
;			int handle = ModEvent.Create("EggFactory_LaborStart")
;			if (handle)
;				modevent.pushform(handle, victim)
;				modevent.pushint(handle, twinscount[i])
;				modevent.send(handle)
;			endif
;		endif
		; and let labor script handle belly scaling from here out
	else
		float belly_Scale = CalcAdjustedBellyScale(gestation_cur[i],twinscount[i])
		setnodescale(victim, "NPC Belly", belly_scale, true)	
	endif
	
EndFunction

Function RegisterEggFactoryEvents()
;	RegisterForModEvent("EggFactory_LaborFinished", "OnLaborFinished")
	RegisterForModEvent("EggFactory_Impregnate", "OnImpregnate")
	RegisterForModEvent("EggFactory_RapidStart", "OnRapidStart")
	RegisterForModEvent("EggFactory_UnCurse", "OnUnCurse")
	RegisterForModEvent("EggFactory_Info", "OnInfoReq")
	RegisterForModEvent("EggFactory_ConfigChange", "OnConfigChange")
EndFunction

Event OnInit()
	debug.trace("eggfactory on init event running")
	RegisterEggFactoryEvents()
	RegisterForSingleupdate(1)
EndEvent

Function OnVersionChange()
	int i = 0
	debug.trace("eggfactory reload event running")
	if(MQ104 == none)
		MQ104=Game.GetFormFromFile(0x2610C, "Skyrim.esm") as Quest
	endif
	if(uncursequeued.length==0)
		uncursequeued = new bool[12]
		while (i < 12)
			uncursequeued[i] = false
			i += 1
		endwhile
	endif
	if(DragonSoulCount.length==0)
		DragonSoulCount = new int[12]
		i = 0
		while (i < 12)
			DragonSoulCount[i] = 0
			i += 1
		endwhile
	endif
	i = 0
	while (i < 12)
		lastgrowth[i] = Utility.GetCurrentGameTime()*24.0
		i += 1
	endwhile
	
	if(EggCountsMax.length == 0)
		EggCountsMax = new int [7]
		EggCountsMax[1] = 30
		EggCountsMax[2] = 25
		EggCountsMax[3] = 40
		EggCountsMax[4] = 20
		EggCountsMax[5] = 4
		EggCountsMax[6] = 1
	endif
		
	if(EggCountsMin.length == 0)
		EggCountsMin = new int [7]
		EggCountsMin[1] = 20
		EggCountsMin[2] = 15
		EggCountsMin[3] = 25
		EggCountsMin[4] = 12
		EggCountsMin[5] = 2
		EggCountsMax[6] = 1
	endif
	
	if(LaborStates.length == 0)
		LaborStates = new int [12]
		i = 0
		while (i < 12)
			LaborStates[i] = 0
			i += 1
		endwhile
	endif
	
	if(TicsToNextPush.length == 0)
		TicsToNextPush = new int [12]
		i = 0
		while (i < 12)
			TicsToNextPush[i] = 0
			i += 1
		endwhile
	endif
	
	if(PushesToLay.length == 0)
		PushesToLay = new int [12]
		i = 0
		while (i < 12)
			PushesToLay[i] = 0
			i += 1
		endwhile
	endif
	
	if(EggCountsLeft.length == 0)
		EggCountsLeft = new int [12]
		i = 0
		while (i < 12)
			EggCountsLeft[i] = 0
			i += 1
		endwhile
	endif
	
	if(LaborRates.length == 0)
		LaborRates = new int [12]
		i = 0
		while (i < 12)
			LaborRates[i] = 0
			i += 1
		endwhile
	endif
	
	if(bellyscalemults.length == 0)
		bellyscalemults = new float [12]
		i = 0
		while (i < 12)
			bellyscalemults[i] = 0.0
			i += 1
		endwhile
	endif
	
	if(LaborRateVars.length == 0)
		LaborRateVars = new globalvariable [7]
		LaborRateVars[1] = Game.GetFormFromFile(0x38193, "eggfactory.esp") as GlobalVariable
		LaborRateVars[2] = Game.GetFormFromFile(0x38194, "eggfactory.esp") as GlobalVariable
		LaborRateVars[3] = Game.GetFormFromFile(0x38197, "eggfactory.esp") as GlobalVariable
		LaborRateVars[4] = Game.GetFormFromFile(0x38195, "eggfactory.esp") as GlobalVariable
		LaborRateVars[5] = Game.GetFormFromFile(0x38199, "eggfactory.esp") as GlobalVariable
		LaborRateVars[6] = Game.GetFormFromFile(0x38198, "eggfactory.esp") as GlobalVariable
	endif
	
	if(EggFactoryLaborMale == None)
		EggFactoryLaborMale = Game.GetFormFromFile(0xEFCB, "eggfactory.esp") as sound
	endif
	
	if(EggFactoryLaborFemale == None)
		EggFactoryLaborFemale = Game.GetFormFromFile(0xEFCD, "eggfactory.esp") as sound
	endif
	
	if(PlayerFaction == None)
		PlayerFaction = Game.GetFormFromFile(0xDB1, "skyrim.esm") as faction
	endif
	
	if(EggFactoryCounter == None)
		EggFactoryCounter = Game.GetFormFromFile(0x12054, "eggfactory.esp") as faction
	endif
	
	if(EggFactoryVoiceVolume==None)
		EggFactoryVoiceVolume=Game.GetFormFromFile(0x10559, "eggfactory.esp") as GlobalVariable
	endif
	
	if(eggitems.length == 0)
		eggitems = new miscobject [9]
		eggitems[1] = Game.GetFormFromFile(0xD4D3, "eggfactory.esp") as miscobject
		eggitems[2] = Game.GetFormFromFile(0xD4DA, "eggfactory.esp") as miscobject
		eggitems[3] = Game.GetFormFromFile(0xD4D9, "eggfactory.esp") as miscobject
		eggitems[4] = Game.GetFormFromFile(0xD4D8, "eggfactory.esp") as miscobject
		eggitems[5] = Game.GetFormFromFile(0xD4D6, "eggfactory.esp") as miscobject
		eggitems[6] = Game.GetFormFromFile(0xD4D7, "eggfactory.esp") as miscobject
		eggitems[7] = Game.GetFormFromFile(0xD4D4, "eggfactory.esp") as miscobject
		eggitems[8] = Game.GetFormFromFile(0xD4D5, "eggfactory.esp") as miscobject
	endif
	
	RegisterEggFactoryEvents()
	if(EggFactoryShuffleMode==None)
		EggFactoryShuffleMode=Game.GetFormFromFile(0x340E9, "eggfactory.esp") as GlobalVariable
	endif
EndFunction

Event OnConfigChange()
	debug.trace("EggFactory options changed in MCM.")
	int i = 0
	while(i < 12)
		setnodescale(victims[i].getactorref(), "NPC Belly", CalcAdjustedBellyScale(gestation_cur[i],twinscount[i]), true)	
		i+=1
	endwhile
EndEvent

Event OnInfoReq(form infoform)
	string statustext = ""
	actor victim = infoform as actor
	bool victimfound = false
	float percentdone = 0.0
	int i = 0
	while (i < 12)
		if(victim == victims[i].getactorref())
			statustext += "Pregnant with "
			if(pregtypes[i] == 1)
				statustext += "bird eggs."
			elseif(pregtypes[i] == 2)
				statustext += "spider eggs."
			elseif(pregtypes[i] == 3)
				statustext += "fish eggs."
			elseif(pregtypes[i] == 4)
				statustext += "chaurus eggs."
			elseif(pregtypes[i] == 5)
				statustext += "large bird eggs."
			elseif(pregtypes[i] == 6)
				statustext += "dragon eggs."
			else
				statustext += "unknown."
			endif
			statustext += "\n"
			if(twinscount[i] == 1)
				statustext += "Twins!\n"
			elseif(twinscount[i] == 2)
				statustext += "Triplets!\n"
			elseif(twinscount[i] == 3)
				statustext += "Quadruplets!\n"
			elseif(twinscount[i] == 4)
				statustext += "Quintuplets!\n"
			elseif(twinscount[i] == 5)
				statustext += "Sextuplets!\n"
			elseif(twinscount[i] == 6)
				statustext += "Septuplets!\n"
			endif
			percentdone = (gestation_cur[i] as float / gestation_total[i] as float) * 100.0
			statustext += percentdone as string
			statustext += "% along."
			if (UncurseQueued[i] == true)
				statustext += "\nCurse will break after delivery."
			endif
			victimfound = true
		endif
		i += 1
	endwhile
	if(victimfound)
		debug.messagebox(statustext)
	else
		debug.messagebox("Not pregnant.")
	endif
EndEvent

Function DoUncurse(actor victim, int i, bool rescalebelly)
	int pregtype = pregtypes[i]
	victim.removespell(laboreffects[pregtype])
	victim.removespell(eggfactorylabordebuff)
	victim.UnequipItem(eggfactoryfluid,false,true)
	victim.RemoveItem(eggfactoryfluid,1,true)
	gestation_cur[i] = 0
	gestation_total[i] = 0
	doingsecondload[i] = false
	pregtypes[i] = 0
	UncurseQueued[i] = false
	victim.removefromfaction(EggFactoryPregCheck)
	if(rescalebelly)
		setnodescale(victim, "NPC Belly", 0.0, true)
	endif
	SayMessage(victim,"dispelled")
	int handle = ModEvent.Create("EggFactory_LactationCooldown")
	if (handle)
		modevent.pushform(handle, victim)
		modevent.pushint(handle, utility.randomint(8,24))
		modevent.send(handle)
	endif
	victims[i].TryToClear()
EndFunction

Event OnUncurse(form uncursed)
	actor victim = uncursed as actor
	int i = 0
	while (i < 12)
		if(victim == victims[i].getactorref())
			if(gestation_cur[i] < 10)
				DoUncurse(victim, i, true)
			else
				UncurseQueued[i] = true
			endif
		endif
		i += 1
	endwhile
EndEvent

Event OnLaborFinished(form laborer)
	actor victim = laborer as actor
	int i = 0
	while (i < 12)
		if(victim == victims[i].getactorref())
			int pregtype=pregtypes[i]
;			victim.removespell(laboreffects[pregtype])
			victim.removespell(eggfactorylabordebuff)
			victim.UnequipItem(eggfactoryfluid,false,true)
			victim.RemoveItem(eggfactoryfluid,1,true)
			;debug.notification("Confirmed labor finished")
			
			SayMessage(victim,"finished")
			
			IncrementAspect(victim,pregtype)
			if (UncurseQueued[i] == true)
				DoUncurse(victim, i, true)
			else 
				if(pregtype < 6 && EggFactoryShuffleMode.GetValue() > 0)
					pregtypes[i] = utility.randomint(1,5)
				endif
						
				InitPregnancy(i,1)		
				AdvanceGestation(i)
				if(doingsecondload[i]==true)
					doingsecondload[i]=false
				elseif(Utility.RandomInt(1,100) < ExtraChanceVars[pregtypes[i]].GetValue())
					SayMessage(victim,"maybenot")
					doingsecondload[i]=true
				endif
			
			endif
			
			int handle = ModEvent.Create("EggFactory_LactationCooldown")
			if (handle)
				modevent.pushform(handle, victim)
				modevent.pushint(handle, utility.randomint(8,24))
				modevent.send(handle)
			endif
	
			if(victim==game.getplayer() && notesent == false)
				CourierScript.AddItemToContainer(eggfactorycouriernote)
				notesent = true
			endif
			
			; do this again in case the first attempt didn't take
			victim.removespell(eggfactorylabordebuff)
			victim.UnequipItem(eggfactoryfluid,false,true)
			victim.RemoveItem(eggfactoryfluid,1,true)
			
		endif
		i += 1
	endwhile
EndEvent

Event OnRapidStart(form actorform, int rapidness)
	actor victim = actorform as actor
	int i = 0
	while (i < 12)
		if(victim == victims[i].getactorref())
			rapidpoints[i] = rapidpoints[i] + rapidness
		endif
		i += 1
	endwhile
EndEvent

Event OnImpregnate(form actorform, int pregtype, int startpoint)
	actor victim = actorform as actor
	int i = 0
	bool alreadypreg = false
	bool slotfound = false
	bool ischild = false
	
	while (i < 12)
		if(victim == victims[i].getactorref())
			alreadypreg=true
			debug.notification("This actor already pregnant!")
		endif
		i += 1
	endwhile
	
	if(IsChildRace(victim.GetRace()) == true)
		debug.notification("Cannot impregnate a child!")
		ischild = true
	endif
	
	i = 0
	if(!alreadypreg && !ischild)
		while (i < 12 && !slotfound)
			if(victims[i].forcerefifempty(victim))
				debug.notification(victim.GetDisplayName() + " set to pregnancy slot " + i as string)
				slotfound=true
				pregtypes[i]=pregtype
				InitPregnancy(i,startpoint)
				AdvanceGestation(i)
				AddToTracker(victim)
			endif
			i += 1
		endwhile
	endif
	
EndEvent

int Function CalcPushesNeeded(int rate, int initial)
	int pushes = 0
	if(rate == 3)
		pushes = utility.RandomInt(1,3)
	elseif(rate == 4)
		pushes = utility.RandomInt(1,4) + utility.RandomInt(1,4)
	elseif(rate == 5)
		pushes = utility.RandomInt(1,6) + utility.RandomInt(1,6) + utility.RandomInt(1,6) + utility.RandomInt(1,6) 
	else
		pushes = 1
	endif
	
	if(initial > 0)
		pushes += utility.randomint(1,4)
	endif	
	
	return pushes
EndFunction

Function LaborMoan(int idx)
	actor victim = victims[idx].getactorref()
	if(victim && victim.is3dloaded())
		float maxvolume = EggFactoryVoiceVolume.GetValue()
		int moan
		
		if(victim.GetActorBase().GetSex() == 0)
			moan = EggFactoryLaborMale.play(victim)
		else
			moan = EggFactoryLaborFemale.play(victim)
		endif
	
		Sound.SetInstanceVolume(moan, Utility.RandomFloat(maxvolume*0.7,maxvolume))
	endif
EndFunction

Function LaborPush(int idx)
	actor victim = victims[idx].getactorref()
	if(victim)
		if(PushesToLay[idx] > 0)
			PushesToLay[idx] = PushesToLay[idx] - 1
		else
			LayEggs(idx)
			if(EggCountsLeft[idx] > 0)
				PushesToLay[idx] = CalcPushesNeeded(LaborRates[idx],0)
			else
				int handle = ModEvent.Create("EggFactory_LaborFinished")
				if (handle)
					modevent.pushform(handle, victim)
					modevent.send(handle)
				endif
			endif
		endif
	endif
EndFunction

Function LayEggs(int idx)
	actor victim = victims[idx].getactorref()
	if(victim)
		int rate = LaborRates[idx]
		ObjectReference newegg
		MiscObject eggitem = eggitems[1]
		int eggs
		
		if(rate == 1)
			eggs = utility.randomint(1,3)
		elseif(rate == 0)
			eggs = utility.randomint(3,7)
		else
			eggs = 1
		endif
		
		if(eggs > EggCountsLeft[idx])
			eggs = EggCountsLeft[idx]
		endif
		
		while(eggs > 0)
			if(victim.is3dloaded())
				newegg=victim.PlaceAtMe(eggitem)
			
				newegg.MoveToNode(victim,"NPC Pelvis [Pelv]")
			
				newegg.SetFactionOwner(PlayerFaction)
			endif
			
			eggs -= 1
			EggCountsLeft[idx] = EggCountsLeft[idx] - 1
		endwhile
		
		float newscale = 1.0 + EggCountsLeft[idx] as float * bellyscalemults[idx]
		
		SetNodeScale(victim, "NPC Belly", newscale, true)
	endif
EndFunction

Event OnUpdate()
	UnRegisterForModEvent("EggFactory_LaborFinished")
	UnRegisterForModEvent("EggFactory_Impregnate")
	UnRegisterForModEvent("EggFactory_RapidStart")
	UnRegisterForModEvent("EggFactory_Uncurse")
	UnRegisterForModEvent("EggFactory_Info")
	UnRegisterForModEvent("EggFactory_ConfigChange")
	
	int i=0
	int pregtype
	
	while (i < 12)
		pregtype = PregTypes[i]
		actor victim = victims[i].GetActorRef()
		if(pregtype > 0 && victim)
			douncurse(victim, i, true)
		endif
		i+=1
	endwhile
	
	UnRegisterForUpdate()
EndEvent

Function SetNodeScale(Actor akActor, string nodeName, float value, bool dummy)
;   debug.trace("Set node scale running")
    bool isFemale = true ;If something goes really fucking wrong and it skips the if/elseif ladder, this assumes the most common case. Most people want females inflated, so assume female skeleton.
    If akActor.GetLeveledActorBase().GetSex()==0
        isFemale=false
    ElseIf akActor.GetLeveledActorBase().GetSex()==1
        isFemale=true
    Else
        return
    EndIf
    String E_Key = "EGG_MODKEY"
    ;Debug.Notification(nodename +" "+ E_key+" "+(Value as string))
    
    If value > 1.0
        NiOverride.AddNodeTransformScale(akActor, false, isFemale, nodeName, E_Key, value)
        NiOverride.AddNodeTransformScale(akActor, true, isFemale, nodeName, E_Key, value)
    Else
        NiOverride.RemoveNodeTransformScale(akActor, false, isFemale, nodeName, E_Key)
        NiOverride.RemoveNodeTransformScale(akActor, true, isFemale, nodeName, E_Key)
    Endif
    NiOverride.UpdateNodeTransform(akActor, false, isFemale, nodeName)
    NiOverride.UpdateNodeTransform(akActor, true, isFemale, nodeName)
EndFunction