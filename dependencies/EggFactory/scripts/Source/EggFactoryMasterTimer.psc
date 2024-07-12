Scriptname EggFactoryMasterTimer extends Quest

globalvariable property EggFactoryScaleMethod auto

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

; spell[] property LaborEffects auto
; 0 not pregnant
; 1 bird	20-30
; 2 spider	15-25
; 3 fish	25-40
; 4 chauras	12-20
; 5 large bird 2-3
; 6 dragon	1-1

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

;faction property EggFactoryPregCheck auto

keyword property eggfactoryenchhold auto
keyword property eggfactoryenchfertile auto

keyword property loctypecity auto
keyword property loctypetown auto
keyword property LocTypePlayerHouse auto
keyword property loctypeinn auto

WICourierScript property CourierScript auto
book Property EggFactoryCourierNote auto
bool property notesent auto

potion property foodeggpotion auto
potion property eggfactoryuncurse auto

armor property eggfactoryfluid auto
spell property eggfactorylabordebuff auto

bool property eggfactory340check auto
bool property eggfactory360check auto

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

globalvariable property EggFactoryDismount auto
globalvariable property EggFactoryBleedout auto

globalvariable property EggFactorymultiLimit auto

miscobject[] property EggItems auto
ingredient[] property EggItemsReal auto

bool[] property wassneaking auto

; lactation system vars

GlobalVariable Property EggFactoryPlayerMilkState auto
GlobalVariable Property EggFactoryPlayerMilkCooldown auto

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

bool Function IsFertileRace(Race thisRace)
	string RaceName = ThisRace.GetName()
	bool IsFertile = false

    if(StringUtil.Find(RaceName, "Bunny") != -1)
		IsFertile = true
    EndIf
    
    if(StringUtil.Find(RaceName, "Nymph") != -1)
		IsFertile = true
    EndIf
    
    return IsFertile
EndFunction

bool Function IsSmallRace(Race ThisRace)
	string RaceName = ThisRace.GetName()
	bool IsSmall = false
	
	if(StringUtil.Find(RaceName, "Goblin") != -1)
		IsSmall = true
	elseif(StringUtil.Find(RaceName, "Gnome") != -1)
		IsSmall = true
	elseif(StringUtil.Find(RaceName, "Kobold") != -1)
		IsSmall = true
    elseif(StringUtil.Find(RaceName, "Svirfneblin") != -1)
		IsSmall = true
	endif
	
	return IsSmall

EndFunction

int function GetPregCount(actor who)
    int i = 0
    int count = 0
    while(i < 12)
        if(victims[i].getactorref() == who)
            count += 1
        endif
		i+=1
	endwhile
    
    return count
endfunction

Function SayMessage(Actor who, string what)
	bool secondperson=false
	bool firstperson=false
	string mymessage
	
	if(who == Game.GetPlayer())
		secondperson=true
		firstperson=EggFactoryFirstPerson.GetValue() as bool
	endif
	
    if(what == "full")
    	if(secondperson==true)
			if(firstperson==true)
				mymessage = "I don't think I can get any more pregnant."
			else
				mymessage = "You cannot get any more pregnant."
			endif
		else
			mymessage = who.GetDisplayName() + ": I don't think I can get any more pregnant."
		endif
	elseif(what == "cramps")
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
    elseif(what == "pregstart")
    	if(secondperson==true)
            if(firstperson==true)
                mymessage = "I feel kind of bloated."
            else
                mymessage = "You feel vaguely bloated."
            endif	
        else
            mymessage = who.GetDisplayName() + ": I feel a bit bloated."
        endif
	endif

    if(who.Is3dLoaded())
        debug.notification(mymessage)
    endif
	
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

;Function SubFromTracker(Actor who)
;	int rank = who.GetFactionRank(EggFactoryPregCheck)
;	if(rank == -2)
;		who.AddToFaction(EggFactoryPregCheck)
;    elseif (rank <= 0)
;        who.SetFactionRank(EggFactoryPregCheck,0)
;    else
;        who.SetFactionRank(EggFactoryPregCheck,(rank - 1))
;	endif
;EndFunction


;Function AddToTracker(Actor who)
;	int rank = who.GetFactionRank(EggFactoryPregCheck)
;	if(rank == -2)
;		who.AddToFaction(EggFactoryPregCheck)
;    elseif (rank < 1)
;        who.SetFactionRank(EggFactoryPregCheck,1)
;    else
;        who.SetFactionRank(EggFactoryPregCheck,(rank +1))
;	endif
;EndFunction

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

Float Function CalcAdjustedBellyScale(int stage, int twins, actor who)
	float adjusted_belly_scale = stage * 0.12
		
	adjusted_belly_scale *= (1.0+(twins*0.5))
	adjusted_belly_scale *= EggFactoryBellyMult.GetValue()
    
    if(IsSmallRace(who.GetRace()) == true)
    	adjusted_belly_scale *= 1.5
	endif
		
	if(adjusted_belly_scale > EggFactoryMaxScale.GetValue())
		adjusted_belly_scale = EggFactoryMaxScale.GetValue()
	endif
		
    
        
	return (adjusted_belly_scale)	
EndFunction

int function GetTwins (Actor who, int chance)
	int twins = EggfactoryMinMultiples.GetValue() as int
    
  	if(IsFertileRace(who.GetRace()) == true)
    	twins += 1
	endif
	
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
	;gestation_total[i]=Utility.RandomInt(55,65)
    gestation_total[i]=50
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
	
	if (gestation_cur[i] >= 10)
		if victim == game.getplayer()
			EggFactoryPlayerMilkState.SetValue(2)
		endif
	endif
	
	if (gestation_cur[i] >= 40)
		if victim == game.getplayer()
			EggFactoryPlayerMilkState.SetValue(3)
		endif
	endif
	
	if (gestation_cur[i] == (gestation_total[i] - 1) && victim.is3dloaded())
		SayMessage(victim, "cramps")
		laborstates[i] = 1
	endif
	
	if (gestation_cur[i] == gestation_total[i] && victim.is3dloaded())
		SayMessage(victim, "water")
		laborstates[i] = 3
		AddFluidAndDebuff(victim)
	endif
    
    float belly_Scale = CalcAdjustedBellyScale(gestation_cur[i],twinscount[i],victim)
	setnodescale(victim, "NPC Belly", belly_scale, i)
		
	if(gestation_cur[i] > gestation_total[i])
		SayMessage(victim, "labor")
		laborstates[i] = 5
		int twincount = twinscount[i]
		int mineggs = EggCountsMin[pregtype]*(1+ twincount)
		int maxeggs = EggCountsMax[pregtype]*(1+ twincount)
		EggCountsLeft[i]=utility.randomint(mineggs,maxeggs)
		float maxbellyscale = CalcAdjustedBellyScale(gestation_cur[i],twinscount[i],victim)
		bellyscalemults[i]= (maxbellyscale - 1.0) / (EggCountsLeft[i] as float)
        ;bellyscalemults[i]= maxbellyscale / (EggCountsLeft[i] as float)
		LaborRates[i] = LaborRateVars[pregtype].GetValue() as int
		PushesToLay[i] = CalcPushesNeeded(LaborRates[i], 1)
		TicsToNextPush[i] = utility.randomint(1,4)
		wassneaking[i]=victim.IsSneaking()
    endif
	
EndFunction

Function RegisterEggFactoryEvents()
;	UnRegisterForModEvent("EggFactory_LaborFinished")
	UnRegisterForModEvent("EggFactory_Impregnate")
	UnRegisterForModEvent("EggFactory_RapidStart")
	UnRegisterForModEvent("EggFactory_Uncurse")
	UnRegisterForModEvent("EggFactory_Info")
	UnRegisterForModEvent("EggFactory_ConfigChange")
	
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
EndFunction

Event OnConfigChange()
	debug.trace("EggFactory options changed in MCM.")
	int i = 0
	while(i < 12)
        if(victims[i].getactorref() != none)
            clearnodescale(victims[i].getactorref(), "NPC Belly", i)
            clearlegacynodescale(victims[i].getactorref(), "NPC Belly")
            setnodescale(victims[i].getactorref(), "NPC Belly", CalcAdjustedBellyScale(gestation_cur[i],twinscount[i], victims[i].getactorref()), i)	
        endif
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
			statustext += "% along.\n"
			if (UncurseQueued[i] == true)
				statustext += "Curse will break after delivery.\n"
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
	victim.removespell(eggfactorylabordebuff)
	victim.UnequipItem(eggfactoryfluid,false,true)
	victim.RemoveItem(eggfactoryfluid,1,true)
	gestation_cur[i] = 0
	gestation_total[i] = 0
	doingsecondload[i] = false
	pregtypes[i] = 0
	UncurseQueued[i] = false
	;victim.removefromfaction(EggFactoryPregCheck)
    ;SubFromTracker(victim)
	if(rescalebelly)
		setnodescale(victim, "NPC Belly", 0.0, i)
	endif
	SayMessage(victim,"dispelled")
	if(victim == game.getplayer())
		EggFactoryPlayerMilkCooldown.SetValue(utility.randomint(8,24))
	endif
	victims[i].TryToClear()
EndFunction

Event OnUncurse(form uncursed)
	actor victim = uncursed as actor
	int i = 0
    bool removedone = false
	while (i < 12 && removedone == false)
		if(victim == victims[i].getactorref())
			if(gestation_cur[i] < 10)
				DoUncurse(victim, i, true)
			else
				UncurseQueued[i] = true
			endif
            removedone = true
		endif
		i += 1
	endwhile
EndEvent

Function LaborFinished(int i)
		actor victim = victims[i].getactorref()
		if(victim)
			int pregtype=pregtypes[i]
			laborstates[i] = 0
			victim.removespell(eggfactorylabordebuff)
			victim.UnequipItem(eggfactoryfluid,false,true)
			victim.RemoveItem(eggfactoryfluid,1,true)
			
			SayMessage(victim,"finished")
            clearnodescale(victim, "NPC Belly", i)

			if(EggFactoryBleedOut.GetValueInt() as bool == true)
				if(victim.GetAnimationVariableBool("IsBleedingOut"))
					Debug.SendAnimationEvent(victim, "bleedOutStop")
				endif
			elseif(wassneaking[i] == false && victim.IsSneaking())
				victim.startsneaking()
			endif
			
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
			
            ;if(victim == game.getplayer())
            ;    EggFactoryPlayerMilkCooldown.SetValue(utility.randomint(8,24))
            ;endif
    
			if(victim==game.getplayer() && notesent == false)
				Location playerLoc = victim.GetCurrentLocation()
				if ((playerLoc.HasKeyWord(LocTypeCity) || playerLoc.HasKeyWord(LocTypeTown) || playerLoc.HasKeyWord(LocTypeInn)) && !playerLoc.HasKeyWord(LocTypePlayerHouse))
					CourierScript.AddItemToContainer(eggfactorycouriernote)
					notesent = true
				endif
			endif
			
			; do this again in case the first attempt didn't take
			victim.removespell(eggfactorylabordebuff)
			victim.UnequipItem(eggfactoryfluid,false,true)
			victim.RemoveItem(eggfactoryfluid,1,true)
			
		endif
	
EndFunction

Event OnRapidStart(form actorform, int rapidness)
	actor victim = actorform as actor
	int i = 0
	while (i < 12)
		if(victim == victims[i].getactorref())
			if(pregtypes[i] < 6)
				rapidpoints[i] = rapidpoints[i] + rapidness
			else
				rapidpoints[i] = rapidpoints[i] + 1
			endif
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
    int currentcount = GetPregcount(victim)
    int preglimit = EggFactoryMultiLimit.GetValue() as int
	
    if(currentcount >= preglimit )
		alreadypreg=true
		saymessage(victim,"full")
    endif
	
	if(IsChildRace(victim.GetRace()) == true)
		debug.notification("Cannot impregnate a child!")
		ischild = true
	endif
	
	if(!alreadypreg && !ischild)
		while (i < 12 && !slotfound)
			if(victims[i].forcerefifempty(victim))
				debug.notification(victim.GetDisplayName() + " set to pregnancy slot " + i as string)
				slotfound=true
				pregtypes[i]=pregtype
                dragonsoulcount[i] = GetAdjustedDragonSouls(victim)
				InitPregnancy(i,startpoint)
				AdvanceGestation(i)
                saymessage(victim,"pregstart")
				;AddToTracker(victim)
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
	
	return (pushes - 1)
EndFunction

function LaborPose(int idx)
	actor who = victims[idx].getactorref()
	if(who && who.is3dloaded())
		if(who.GetFlyingState() == 0 && !who.IsSneaking() && !who.IsSwimming() && !who.IsOnMount() && !who.IsDead())
			who.StartSneaking()
;			if(who != game.getplayer())
;				who.enableai(false)
;			endif
			if(EggFactoryBleedOut.GetValueInt() as bool == true)
				if(who.GetPlayerControls() && who.GetSleepState() <= 2 && who.GetSitState() <= 2 && !who.GetAnimationVariableBool("IsBleedingOut"))
					Debug.SendAnimationEvent(who, "bleedOutStart")
				endif
			endif
		elseif(EggFactoryDismount.GetValueInt() as bool == true)
			if(who.GetPlayerControls() && who.IsOnMount())
				who.Dismount()
			endif
		endif
	endif
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
		int eggs
		MiscObject eggitem
        ingredient eggitemreal
		int rate = LaborRates[idx]
		int pregtype = pregtypes[idx]
		
		ObjectReference newegg

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
			int birdtype = utility.randomint(1,3)
			if(pregtype == 1 && birdtype == 2)
				eggitem = eggitems[7]
                eggitemreal = eggitemsreal[7]
			elseif(pregtype == 1 && birdtype == 3)
				eggitem = eggitems[8]
                eggitemreal = eggitemsreal[8]
			else
				eggitem = eggitems[pregtype]
                eggitemreal = eggitemsreal[pregtype]
			endif
		
			if(victim.is3dloaded())
				newegg=victim.PlaceAtMe(eggitem)
			
				newegg.MoveToNode(victim,"NPC Pelvis [Pelv]")
			
				newegg.SetFactionOwner(PlayerFaction)
            else
                Victim.AddItem(eggitemreal)
			endif
			
			eggs -= 1
			EggCountsLeft[idx] = EggCountsLeft[idx] - 1
		endwhile
		
		float newscale = 1.0 + EggCountsLeft[idx] as float * bellyscalemults[idx]
        ;float newscale = EggCountsLeft[idx] as float * bellyscalemults[idx]
		
		SetNodeScale(victim, "NPC Belly", newscale, idx)
	endif
EndFunction

Function GrowthSpurt(int i)
	actor victim = victims[i].getactorref()
	int r = utility.randomint(5,10)
	LaborMoan(i)
	while(r > 0 && laborstates[i] < 5)
		AdvanceGestation(i)
		r -= 1
	endwhile
	
EndFunction

Event OnUpdate()
	int i=0
	int pregtype
	float interval
	float hours_passed
	
	if(eggfactory340check != true)
        EggFactoryScaleMethod = Game.GetFormFromFile(0x3A1E6, "eggfactory.esp") as GlobalVariable
		eggfactory340check = true
	endif
    
    if(eggfactory360check != true)
        EggFactorymultiLimit = Game.GetFormFromFile(0x42332, "eggfactory.esp") as GlobalVariable
		eggfactory360check = true
        OnConfigChange()
	endif
	
;	debug.trace("Egg timer running")
	
	while (i < 12 && eventick)
		pregtype=PregTypes[i]
		actor victim = victims[i].GetActorRef()
		if(pregtype > 0 && victim)
			if(victim.isdead())	
				; actor's dead, remove from pregnancy tracking, but don't shrink belly
				douncurse(victim, i, false)
			elseif(laborstates[i] < 5)			
				hours_passed = Utility.GetCurrentGameTime()*24.0 - lastgrowth[i]
				float divisor = PregSpeedVars[pregtype].GetValue()
				if(divisor > 0) ; avoid dividing by zero if the variable is set to such somehow
					interval = 1.0/divisor
				else
					interval = 0.0 ; no time-based growth
				endif
				
				; never more than half a game hour between water breaking and pushing
				if (gestation_cur[i] == gestation_total[i] && (interval > 0.5 || interval == 0.0))
					interval = 0.5
				endif
				
				; time-based growth
				while(interval> 0.0001 && hours_passed>=interval)
					AdvanceGestation(i)
					hours_passed -= interval
					lastgrowth[i] = Utility.GetCurrentGameTime()*24.0
				endwhile
				
				; grow up to the skip early threshold
				if(gestation_cur[i] < (SkipEarlyVars[pregtypes[i]].GetValue() as int /2))
					GrowthSpurt(i)
				endif
				
				; growth from rapid pregnancy potion
				if((rapidpoints[i] > 0 || doingsecondload[i] == true))
					GrowthSpurt(i)
					if(doingsecondload[i] == false)
						rapidpoints[i] = rapidpoints[i] - 1
					endif
				endif
				
				; growth from dragon soul (dragon egg only)
				if(pregtype == 6 && GetAdjustedDragonSouls(victim) > dragonsoulcount[i])
					rapidpoints[i] = rapidpoints[i] + utility.randomint(3,5) * (GetAdjustedDragonSouls(victim) - dragonsoulcount[i])
				endif
				dragonsoulcount[i] = GetAdjustedDragonSouls(victim)
				
				; growth from water rapid growth
				if(victim.isswimming() && (gestation_cur[i] < WaterGrowthVars[pregtype].GetValue()/2))
					AdvanceGestation(i)
				endif
				
			endif
			if(victim != game.getplayer())
				; have a NPC use a pregnancy draught if it has one
				if(victim.GetItemCount(foodeggpotion) > 0)
				    if(pregtypes[i] < 6)
						rapidpoints[i] = rapidpoints[i] + utility.randomint(3,5)
					else
						rapidpoints[i] = rapidpoints[i] + 1
					endif
					victim.RemoveItem(foodeggpotion,1,true)
				endif
				
				; have a NPC  use a remove curse if it has one
				if(victim.GetItemCount(eggfactoryuncurse) > 0 && UncurseQueued[i] == false)
					victim.RemoveItem(eggfactoryuncurse,1,true)
					if(gestation_cur[i] < 10)
						DoUncurse(victim, i, true)
					else
						UncurseQueued[i] = true
					endif
				endif
			endif
		endif
		i+=1
	endwhile
	
	eventick = !eventick
	
	i=0
	while (i < 12)
		if(LaborStates[i] >= 5)
			if(TicsToNextPush[i] > 0)
				TicsToNextPush[i] = TicsToNextPush[i] - 1
				if(TicsToNextPush[i] == 0)
                    utility.wait(utility.randomfloat(0.0,0.25))
					LaborPose(i)
					LaborMoan(i)
					LaborPush(i)
					TicsToNextPush[i] = utility.randomint(1,5)
				endif
			endif
			if(EggCountsLeft[i] <= 0)
				LaborFinished(i)
			endif
		endif
		i += 1
	endwhile
	
	RegisterForSingleupdate(0.5)
EndEvent

Function SetNodeScaleNIO(Actor akActor, string nodeName, float value, int idx)
    bool isFemale = true ;If something goes really fucking wrong and it skips the if/elseif ladder, this assumes the most common case. Most people want females inflated, so assume female skeleton.
    If akActor.GetLeveledActorBase().GetSex()==0
        isFemale=false
    ElseIf akActor.GetLeveledActorBase().GetSex()==1
        isFemale=true
    Else
        return
    EndIf
    String E_Key = "EGG_MODKEY" + idx
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

Function SetNodeScaleSLIF(Actor akActor, string nodeName, float value, int idx)
    string sKey = "slif_belly"
    string eKey = "Egg Factory "+idx

    If (value > 0.0)
        int SLIF_event = ModEvent.Create("SLIF_inflate")
        If (SLIF_event)
            ModEvent.PushForm(SLIF_event, akActor)
            ModEvent.PushString(SLIF_event, eKey)
            ModEvent.PushString(SLIF_event, sKey)
            ModEvent.PushFloat(SLIF_event, value)
            ModEvent.PushString(SLIF_event, "EGG_MODKEY")
            ModEvent.Send(SLIF_event)
        EndIf
    Else
        int SLIF_event = ModEvent.Create("SLIF_unregisterNode")
        If (SLIF_event)
            ModEvent.PushForm(SLIF_event, akActor)
            ModEvent.PushString(SLIF_event, eKey)
            ModEvent.PushString(SLIF_event, sKey)
            ModEvent.Send(SLIF_event)
        EndIf
    EndIf
Endfunction

Function SetNodeScale(Actor akActor, string nodeName, float value, int idx)
    int scalemethod = EggFactoryScaleMethod.GetValue() as int
    
    if(scalemethod == 1)
        SetNodeScaleNIO(akActor, nodeName, value, idx)
    elseif(scalemethod == 2)
        float newScale = (value - 1.0) / 5.0
        string eKey = "Egg Factory "+idx
        if(newScale > 0)
            NiOverride.SetBodyMorph(akActor, "PregnancyBelly", eKey, newScale)
        else
            NiOverride.ClearBodyMorph(akActor, "PregnancyBelly", eKey)
        endif
     	NiOverride.UpdateModelWeight(akActor)
    elseif(scalemethod == 3)
        SetNodeScaleSLIF(akActor, nodeName, value, idx)
    endif

EndFunction

Function ClearNodeScale(Actor akActor, string nodename, int idx)
    string eKey = "Egg Factory "+idx
    SetNodeScaleNIO(akActor, nodeName, 0.0, idx)
    SetNodeScaleSLIF(akActor, nodeName, 0.0, idx)
    NiOverride.ClearBodyMorph(akActor, "PregnancyBelly", eKey)
    NiOverride.UpdateModelWeight(akActor)
EndFunction

Function ClearLegacyNodeScale(Actor akActor, string nodename)
    bool isFemale = true ;If something goes really fucking wrong and it skips the if/elseif ladder, this assumes the most common case. Most people want females inflated, so assume female skeleton.
    If akActor.GetLeveledActorBase().GetSex()==0
        isFemale=false
    ElseIf akActor.GetLeveledActorBase().GetSex()==1
        isFemale=true
    Else
        return
    EndIf
    string eKey = "Egg Factory"
    NiOverride.RemoveNodeTransformScale(akActor, false, isFemale, nodeName, eKey)
    NiOverride.RemoveNodeTransformScale(akActor, true, isFemale, nodeName, eKey)
    int SLIF_event = ModEvent.Create("SLIF_unregisterNode")
        If (SLIF_event)
            ModEvent.PushForm(SLIF_event, akActor)
            ModEvent.PushString(SLIF_event, eKey)
            ModEvent.PushString(SLIF_event, "slif_belly")
            ModEvent.Send(SLIF_event)
        EndIf
    NiOverride.ClearBodyMorph(akActor, "PregnancyBelly", eKey)
    NiOverride.UpdateModelWeight(akActor)
EndFunction
