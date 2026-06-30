Scriptname FWShowStats extends ActiveMagicEffect  

FWController property Controller auto
int property Magnetude = 100 auto
actor ActorRef;=none
bool bInit;=false

Actor Property PlayerRef Auto
FWSystem property System auto
Spell Property BeeingFemaleSpell Auto
Spell Property BeeingMaleSpell Auto
MagicEffect Property BeingMaleEffect Auto
MagicEffect Property BeeingFemaleEffect Auto
FWSystemConfig property cfg auto
GlobalVariable Property GameDaysPassed Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	 ;Tkc (Loverslab): commented checks because for aimed Show stats spell the script even will not be executed and for added Show Player info spell target will be Player
	;if akTarget;/!=none/; ;Tkc (Loverslab) , checks swapped
		ActorRef = akTarget
		execute()
	;else;if !akTarget; && akCaster.GetAngleX()>85 ;Tkc (Loverslab) : will be player if no npc in target without any angles
		;ActorRef = Game.GetPlayer()
		;execute()
	;endif
endEvent

Event OnInit()
	bInit=true
	execute()
endEvent

function execute()
	;if !ActorRef || bInit==false
	if ActorRef ;Tkc (Loverslab) optimization
	else;if !ActorRef
		return
	endif
	if bInit ;Tkc (Loverslab) optimization
	else;if bInit==false
		return
	endif
	
	;Tkc (Loverslab): do not execute when giving birth to prevent game freeze ; fix for problem when game was freezing in time of attemps to show stats while target was giving birth
	if StorageUtil.FormListFind(none,"FW.GivingBirth", ActorRef) == -1
	else
		;debug.trace("BF: Showstats spell - actor giving birth. Returning.")
		return
	endif
	
	if ActorRef == PlayerRef ;Tkc (Loverslab) : skip spell checking when player because it is reseting player
	else
	;;;;
	spell BFspell = BeeingFemaleSpell ;Tkc (Loverslab): optimization
	If ActorRef.HasSpell(BFspell)
		if ActorRef.HasMagicEffect(BeeingFemaleEffect) ;Tkc (Loverslab) optimization
		else;if !ActorRef.HasMagicEffect(Controller.System.BeeingFemaleSpell.GetNthEffectMagicEffect(0))
			ActorRef.RemoveSpell(BFspell)
		endif
	endif
	spell BMspell = BeeingMaleSpell ;Tkc (Loverslab): optimization
	if ActorRef.HasSpell(BMspell)
		if ActorRef.HasMagicEffect(BeingMaleEffect) ;Tkc (Loverslab) optimization
		else;if !ActorRef.HasMagicEffect(Controller.System.BeeingMaleSpell.GetNthEffectMagicEffect(0))
			ActorRef.RemoveSpell(BMspell)
		endif
	endif
	
	If !ActorRef.HasSpell(BFspell) && System.IsValidateFemaleActor(ActorRef) ;Tkc (Loverslab) optimization. changed IsValidateActor to IsValidateFemaleActor to make check faster
		System.ActorAddSpellOpt(ActorRef, BFspell, false, false, false)
	else;if !ActorRef.HasSpell(Controller.System.BeeingMaleSpell) && Controller.System.IsValidateMaleActor(ActorRef)
		if ActorRef.HasSpell(BMspell) ;Tkc (Loverslab) optimization
		else;if !ActorRef.HasSpell(Controller.System.BeeingMaleSpell)
			if System.IsValidateMaleActor(ActorRef)
				if ActorRef.HasMagicEffect(BeingMaleEffect) ;Tkc (Loverslab) optimization
				else;if !ActorRef.HasMagicEffect(Controller.System.BeeingMaleSpell.GetNthEffectMagicEffect(0))
					ActorRef.RemoveSpell(BMspell)
				endif
				System.ActorAddSpellOpt(ActorRef, BMspell, false, false, false) ;Tkc (Loverslab) fixed incorrect execution order after optimizations. Also fixed error about incorrect number of arguments
			endif
		endif
	endif
	;;;;
	endif
	
	;int Magnetude = GetMagnitude() as int
	Controller.showRankedInfoBox(ActorRef, Magnetude)
	;UI.OpenCustomMenu("beeingfemale/info_spell.swf");
	;if ActorRef.GetLeveledActorBase();/!=none/;
	;	if ActorRef.GetLeveledActorBase().GetSex()==0
	;		return
	;	endif
	;endif
	if cfg.Messages==0
		if ActorRef as FWChildActor ;/!=none/;
			printChildInformations()
		else
			if ActorRef.GetLeveledActorBase();/!=none/;
				if ActorRef.GetLeveledActorBase().GetSex()==0
					printMaleInformations()
				else
					printFemaleInformations()
				endif
			endif
		endif
	endif
endFunction

function PrintLinked()
	int cChain=ActorRef.countLinkedRefChain()
	int i=0
	ObjectReference lnkRef = ActorRef.GetLinkedRef()
	if lnkRef;/!=none/;
		FW_log.WriteLog("Linked References: " + lnkRef.GetName() + " [" + lnkRef.GetFormID() + "]")
	else
		FW_log.WriteLog("Linked References: <NONE>")
	endif
	FW_log.WriteLog("Linked Ref Chains: " + cChain)
	while i<cChain
		ObjectReference lnk = ActorRef.GetNthLinkedRef(i)
		FW_log.WriteLog(i + ": " + lnk.GetName() + " [" + lnk.GetFormID() + "]")
		i+=1
	endWhile
endFunction

function printChildInformations()
	if ActorRef.GetLeveledActorBase();/!=none/;
		FW_log.WriteLog("BeeingChild Saved Data for: "+ActorRef.GetLeveledActorBase().GetName());
	else
		FW_log.WriteLog("BeeingChild Saved Data for: "+ActorRef.GetName());
	endif
	FW_log.WriteLog("Child Name: "+StorageUtil.GetStringValue(ActorRef,"FW.Child.Name",""))
	FW_log.WriteLog("Child last Update: " + StorageUtil.GetFloatValue(ActorRef,"FW.Child.LastUpdate",0))
	actor Mother = StorageUtil.GetFormValue(ActorRef,"FW.Child.Mother") as actor
	actor Father = StorageUtil.GetFormValue(ActorRef,"FW.Child.Father") as actor
	if Mother;/!=none/;
		if Mother.GetLeveledActorBase();/!=none/;
			FW_log.WriteLog("Mother: "+Mother.GetLeveledActorBase().GetName())
		else
			FW_log.WriteLog("Mother: #"+Mother.GetName())
		endif
	else
		FW_log.WriteLog("Mother: <NONE>")
	endif
	if Father;/!=none/;
		if Father.GetLeveledActorBase();/!=none/;
			FW_log.WriteLog("Father: "+Father.GetLeveledActorBase().GetName())
		else
			FW_log.WriteLog("Father: #"+Father.GetName())
		endif
	else
		FW_log.WriteLog("Father: <NONE>")
	endif
	FW_log.WriteLog("Level: "+StorageUtil.GetFloatValue(ActorRef, "FW.Child.Level"))
	FW_log.WriteLog("Experience: "+StorageUtil.GetFloatValue(ActorRef, "FW.Child.StatExperience"))
	FW_log.WriteLog("Stats:")
	FW_log.WriteLog("Comprehension: " + StorageUtil.GetFloatValue(ActorRef,"FW.Child.StatComprehension"))
	FW_log.WriteLog("Destruction: " + StorageUtil.GetFloatValue(ActorRef,"FW.Child.StatDestruction"))
	FW_log.WriteLog("Illusion: " + StorageUtil.GetFloatValue(ActorRef,"FW.Child.StatIllusion"))
	FW_log.WriteLog("Conjuration: " + StorageUtil.GetFloatValue(ActorRef,"FW.Child.StatConjuration"))
	FW_log.WriteLog("Restoration: " + StorageUtil.GetFloatValue(ActorRef,"FW.Child.StatRestoration"))
	FW_log.WriteLog("Alteration: " + StorageUtil.GetFloatValue(ActorRef,"FW.Child.StatAlteration"))
	FW_log.WriteLog("Block: " + StorageUtil.GetFloatValue(ActorRef,"FW.Child.StatBlock"))
	FW_log.WriteLog("OneHanded: " + StorageUtil.GetFloatValue(ActorRef,"FW.Child.StatOneHanded"))
	FW_log.WriteLog("TwoHanded: " + StorageUtil.GetFloatValue(ActorRef,"FW.Child.StatTwoHanded"))
	FW_log.WriteLog("Marksman: " + StorageUtil.GetFloatValue(ActorRef,"FW.Child.StatMarksman"))
	FW_log.WriteLog("Sneak: " + StorageUtil.GetFloatValue(ActorRef,"FW.Child.StatSneak"))
	FW_log.WriteLog("Magicka: " + StorageUtil.GetFloatValue(ActorRef,"FW.Child.StatMagicka"))
	FW_log.WriteLog("CarryWeight: " + StorageUtil.GetFloatValue(ActorRef,"FW.Child.StatCarryWeight"))
	FW_log.WriteLog("Health: " + StorageUtil.GetFloatValue(ActorRef,"FW.Child.StatHealth"))
	FW_log.WriteLog("Perks:")
	int sc = StorageUtil.FormListCount(ActorRef,"FW.Child.Perks")
	while sc>0
		sc-=1
		spell s = StorageUtil.FormListGet(ActorRef,"FW.Child.Perks",sc) as spell
		if s;/!=none/;
			FW_log.WriteLog(s.GetName())
		else
			FW_log.WriteLog("Unknown Perk")
		endif
	endWhile
	
	PrintLinked()
	
	FW_log.WriteLog("-----------------------------------------------------------------")
endfunction

function printMaleInformations()
	if ActorRef.GetLeveledActorBase();/!=none/;
		FW_log.WriteLog("BeeingMale Saved Data for: "+ActorRef.GetLeveledActorBase().GetName());
	else
		FW_log.WriteLog("BeeingMale Saved Data for: "+ActorRef.GetName());
	endif
	PrintLinked()
	
	FW_log.WriteLog("-----------------------------------------------------------------")
endfunction

function printFemaleInformations()
	int i=0
	int cChildFather=StorageUtil.FormListCount(ActorRef,"FW.ChildFather")
	int cSpermTime=StorageUtil.FloatListCount(ActorRef,"FW.SpermTime")
	int cSpermName=StorageUtil.FormListCount(ActorRef,"FW.SpermName")
	int cSpermAmmount=StorageUtil.FloatListCount(ActorRef,"FW.SpermAmount")
	int cBornChildFather=StorageUtil.FormListCount(ActorRef,"FW.BornChildFather")
	int cBornChildTime=StorageUtil.FloatListCount(ActorRef,"FW.BornChildTime")
	FW_log.WriteLog("-----------------------------------------------------------------")
	if ActorRef.GetLeveledActorBase();/!=none/;
		FW_log.WriteLog("BeeingFemale Saved Data for: "+ActorRef.GetLeveledActorBase().GetName());
	else
		FW_log.WriteLog("BeeingFemale Saved Data for: #"+ActorRef.GetName());
	endif
	FW_log.WriteLog("Current Game Time: "+ GameDaysPassed.GetValue())
	FW_log.WriteLog("-----------------------------------------------------------------")
	FW_log.WriteLog(" FW.LastUpdate :  "+StorageUtil.GetFloatValue(ActorRef,"FW.LastUpdate"))
	FW_log.WriteLog(" FW.StateEnterTime :  "+StorageUtil.GetFloatValue(ActorRef,"FW.StateEnterTime")+" ["+ FWUtility.GetTimeString(GameDaysPassed.GetValue() - StorageUtil.GetFloatValue(ActorRef,"FW.StateEnterTime")) +"]")
	FW_log.WriteLog(" FW.CurrentState :  "+StorageUtil.GetIntValue(ActorRef,"FW.CurrentState"))
	FW_log.WriteLog(" FW.Abortus :  "+StorageUtil.GetIntValue(ActorRef,"FW.Abortus"))
	FW_log.WriteLog(" FW.AbortusTime :  "+StorageUtil.GetFloatValue(ActorRef,"FW.AbortusTime")+" ["+ FWUtility.GetTimeString(GameDaysPassed.GetValue() - StorageUtil.GetFloatValue(ActorRef,"FW.AbortusTime")) +"]")
	FW_log.WriteLog(" FW.UnbornHealth :  "+StorageUtil.GetFloatValue(ActorRef,"FW.UnbornHealth"))
	FW_log.WriteLog(" FW.NumChilds :  "+StorageUtil.GetIntValue(ActorRef,"FW.NumChilds"))
	i=0
	while i<cChildFather
		actor a = StorageUtil.FormListGet(ActorRef,"FW.ChildFather",i) as Actor
		if a;/!=none/;
			if a.GetLeveledActorBase();/!=none/;
				FW_log.WriteLog(" FW.ChildFather["+i+"] :  "+a.GetLeveledActorBase().GetName())
			else
				FW_log.WriteLog(" FW.ChildFather["+i+"] :  #"+a.GetName())
			endif
		endif
		i+=1
	endwhile
	i=0
	while i<cSpermTime
		FW_log.WriteLog(" FW.SpermTime["+i+"] :  "+StorageUtil.FloatListGet(ActorRef,"FW.SpermTime",i)+" ["+ FWUtility.GetTimeString(GameDaysPassed.GetValue() - StorageUtil.FloatListGet(ActorRef,"FW.SpermTime",i)) +"]")
		i+=1
	endwhile
	i=0
	while i<cSpermName
		actor a = StorageUtil.FormListGet(ActorRef,"FW.SpermName",i) as Actor
		if a;/!=none/;
			if a.GetLeveledActorBase();/!=none/;
				FW_log.WriteLog(" FW.SpermName["+i+"] :  "+a.GetLeveledActorBase().GetName())
			else
				FW_log.WriteLog(" FW.SpermName["+i+"] :  #"+a.GetName())
			endif
		endif
		i+=1
	endwhile
	i=0
	while i<cSpermAmmount
		FW_log.WriteLog(" FW.SpermAmount["+i+"] :  "+StorageUtil.FloatListGet(ActorRef,"FW.SpermAmount",i))
		i+=1
	endwhile
	FW_log.WriteLog(" FW.Flags :  "+StorageUtil.GetIntValue(ActorRef,"FW.Flags"))
	FW_log.WriteLog(" FW.PainLevel :  "+StorageUtil.GetFloatValue(ActorRef,"FW.PainLevel"))
	FW_log.WriteLog(" FW.Contraception :  "+StorageUtil.GetFloatValue(ActorRef,"FW.Contraception"))
	FW_log.WriteLog(" FW.ContraceptionTime :  "+StorageUtil.GetFloatValue(ActorRef,"FW.ContraceptionTime")+" ["+ FWUtility.GetTimeString(GameDaysPassed.GetValue() - StorageUtil.GetFloatValue(ActorRef,"FW.ContraceptionTime")) +"]")
	FW_log.WriteLog(" FW.NumBirth :  "+StorageUtil.GetIntValue(ActorRef,"FW.NumBirth"))
	FW_log.WriteLog(" FW.NumBabys :  "+StorageUtil.GetIntValue(ActorRef,"FW.NumBabys"))
	FW_log.WriteLog(" FW.PauseTime :  "+StorageUtil.GetFloatValue(ActorRef,"FW.PauseTime")+" ["+ FWUtility.GetTimeString(GameDaysPassed.GetValue() - StorageUtil.GetFloatValue(ActorRef,"FW.PauseTime")) +"]")
	FW_log.WriteLog(" FW.LastBornChildTime :  "+StorageUtil.GetFloatValue(ActorRef,"FW.LastBornChildTime")+" ["+ FWUtility.GetTimeString(GameDaysPassed.GetValue() - StorageUtil.GetFloatValue(ActorRef,"FW.LastBornChildTime")) +"]")
	i=0
	while i<cBornChildFather
		actor a = StorageUtil.FormListGet(ActorRef,"FW.BornChildFather",i) as Actor
		if a;/!=none/;
			if a.GetLeveledActorBase();/!=none/;
				FW_log.WriteLog(" FW.BornChildFather["+i+"] :  "+a.GetLeveledActorBase().GetName())
			else
				FW_log.WriteLog(" FW.BornChildFather["+i+"] :  #"+a.GetName())
			endif
		endif
		i+=1
	endwhile
	i=0
	while i<cBornChildTime
		FW_log.WriteLog(" FW.BornChildTime["+i+"] :  "+StorageUtil.FloatListGet(ActorRef,"FW.BornChildTime",i)+" ["+ FWUtility.GetTimeString(GameDaysPassed.GetValue() - StorageUtil.FloatListGet(ActorRef,"FW.BornChildTime",i)) +"]")
		i+=1
	endwhile
	
	PrintLinked()
	
	FW_log.WriteLog("-----------------------------------------------------------------")
endFunction

; 04.06.2019 ;Tkc (Loverslab) optimizations here because quite slow in game. Other changes marked with "Tkc (Loverslab)" comment
;	Also added same spell but only for Player because by BF autor was planned to use Show All Stats spell to show Player stats
;	when no target on spell but aimed spell will not execute effect with script if was no hit with any targed and script working only for npcs: 
;	CK Magic effect Wiki: Aimed: Effect is attached to a Projectile which is then fired at the crosshairs. If it makes contact with a valid target, the effect is applied.
;	Added Show Player Info spell of Self type will be working on player and will show Player info.
;	found problem when game was freezing on blured screen wich this spell making before show stats, when playing animation of giving birth, 
;	need to add in esp condition wich will prevent start of effects and this script when player woman giving birth. 
;	For fix this freeze was added FW.GivingBirth Formlist and additional condition here to check if mother is giving birth(added in the formlist) then return
