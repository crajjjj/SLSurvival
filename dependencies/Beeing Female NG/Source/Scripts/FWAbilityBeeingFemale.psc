Scriptname FWAbilityBeeingFemale extends FWAbilityBeeingBase

;--------------------------------------------------------------------------------
; Variables & Properties
;--------------------------------------------------------------------------------
; State Variables
int property currentState = 0 auto hidden
float property stateEnterTime auto hidden
float _onUpdateGameTimeDelay = 1.0
float property stateDamageScale = 1.0 auto hidden
float CurrentStatePercent=0.0
float StateDaysRemaining=0.0
int property nextState = 1 auto hidden

bool property canBecomePregnantThisCycle = false auto hidden
bool property canBecomePMSThisCycle = false auto hidden
bool bHasPMS = false
float property LH = 0.0 auto hidden

; Baby Variables
float property UnbornHealth=0.0 auto hidden
int property NumChilds=0 auto hidden

float oldUpdateDelay=0.0
float property UpdateDelay=0.0 auto hidden
float property PauseStartTime=0.0 auto hidden

; Contraception
float ContraceptionPill=0.0
float ContraceptionTime=0.0

; Measurements
Float[] property BaseBellySize auto hidden
Float[] property BaseBreastSize auto hidden
Float property BaseWeight auto hidden
Float AddedBellySize = 0.0
Float AddedBreastSize = 0.0
Float AddedWeight = 0.0
int lastTypeOfScaling = -1

int property abortus = 0 auto hidden
float property AbortusTime = 0.0 auto hidden
bool Abortus_Fiber = false ; Player only
bool Abortus_Infection = false ; Player only
float LastBabyHealing


; Labor Pains step
; 0 - None
; 1 - Vorwehen
; 2 - Eröffnungswehen
; 3 - Presswehen
; 4 - Nachwehen
int property LaborPainsStep = 0 auto
Form[] dropedItems

;--------------------------------------------------------------------------------
; Events
;--------------------------------------------------------------------------------

import PO3_SKSEFunctions
import PO3_Events_Alias

GlobalVariable Property GameDaysPassed Auto
GlobalVariable Property ModEnabled Auto
Spell Property BeeingFemaleSpell Auto
Keyword Property KwArmorCuirass Auto
Keyword Property KwClothingBody Auto
Globalvariable property GlobalPlayerState auto
Globalvariable property GlobalPlayerStatePercent auto
FormList Property BadSpellList Auto
FWSaveLoad property Data auto
spell[] Property StatCycleID_List Auto
spell Property StatMenstruationCycle Auto
spell Property StatPregnancyCycle Auto
Imagespacemodifier property iModPainLow auto
Imagespacemodifier property iModPainMiddle auto
Imagespacemodifier property iModPainHigh auto
spell property InfectionSpell auto
spell property FeverSpell auto
GlobalVariable property GlobalMenstruating auto
spell property Effect_VaginalBloodLow auto
spell property Effect_VaginalBloodHigh auto
ImageSpaceModifier Property AbortusImod  Auto
Armor Property VaginalBleeding Auto
spell property Effect_VaginalBloodBig auto
armor property Sanitary_Napkin_Normal auto
armor property Tampon_Normal auto
armor property Sanitary_Napkin_Bloody auto
armor property Tampon_Bloody auto
FWStateWidget property StateWidget auto
spell property Effect_Vorwehen auto
spell property Effect_Mittelschmerz auto
spell property Effect_Nachwehen auto
spell property Effect_MenstruationCramps auto
spell property Effect_BreastMilk1 auto
spell property Effect_BreastMilk2 auto
spell property Effect_BreastMilk3 auto
spell property Effect_Presswehen auto
spell property Effect_Eroeffnungswehen auto
Armor Property AmnioticFluid Auto
potion property ContraceptionLow auto
MagicEffect Property _BFAbilityEffectBeeingFemale Auto

Event OnEffectStart(Actor target, Actor caster)
	if(!ModEnabled.GetValue() As int) ;Tkc (Loverslab): optimization
		Self.Dispel()
		Return
	endif	
	float startTime = GameDaysPassed.GetValue()
	ActorRef = target
	ActorRefBase = target.GetLeveledActorBase()
	IsPlayer = (target==PlayerRef) ;Tkc (Loverslab): optimization. PlayerRef added in FWAbilityBeeingBase
	parent.OnEffectStart(target, caster)
	;/reworked
	IsFollower = target.IsInFaction(System.FollowerFaction)
	;if (! System.NpcMentruation()) && (! isPlayer)
	if System.NpcMentruation() ;Tkc (Loverslab): optimization
	else;if (! System.NpcMentruation())
	 if isPlayer
	 else; (! isPlayer)
		System.Message( FWUtility.StringReplace( Contents.BeeingFemaleMissedOn2,"{0}",ActorRefBase.GetName()), System.MSG_Debug)
		Self.Dispel()
		return
	 endIf
	endIf
	if IsPlayer==true
		System.PlayerMale = none
		System.Player = self
	endIf
	
	IsFollower = target.IsInFaction(System.FollowerFaction) && IsPlayer == false
	/;;;\/
	;;;Tkc (Loverslab): reworked code of player\npc\follower detection
	if IsPlayer
		System.PlayerMale = none
		System.Player = self
		IsFollower = false;added to set IsFollower to false if it is player
		Self.RegisterForSingleUpdate(5);was added here from code below. suppose 5 sec. will be still enough to execute other code to the end of the event before OnUpdate will be executed
	else
		if System.NpcMentruation() ;Tkc (Loverslab): optimization
		else ;like in the condition in original code above: if (! System.NpcMentruation()) && (! isPlayer)
			System.Message( FWUtility.StringReplace( Contents.BeeingFemaleMissedOn2,"{0}",ActorRefBase.GetName()), System.MSG_Debug)
			Self.Dispel()
			return
		endIf	
		IsFollower = target.IsInFaction(System.FollowerFaction) ; in original code it is set two times ; like in original above here:IsFollower = target.IsInFaction(System.FollowerFaction) && IsPlayer == false
	endIf
	;;;;;;;
	GetBaseMeasurements(True)
	bInitSpell=true
	System.RegisterFWCache(self)
	InitValues()
	;If IsPlayer ;Tkc (Loverslab): optimization. added in reworked player\npc\follower detection code above because it will reduce code by one check and it is only for player
	;	Self.RegisterForSingleUpdate(5) ;Bane -> Only uaed by Player now
	;EndIf
	If ActorRef.HasMagicEffect(_BFAbilityEffectBeeingFemale)	
		RegisterForAnimationEvent(ActorRef, "SoundPlay")
		Self.RegisterForModEvent("BeeingFemale", "BeeingFemale") 
		Self.RegisterForSleep()
		if oldUpdateDelay>0
			Self.RegisterForSingleUpdateGameTime(oldUpdateDelay)
		else
			InitState()
		endif
	endif
	
	equipChild()
	
	CheckRandomSexPartner()
	System.Message( FWUtility.StringReplace( Contents.BeeingFemaleCastedOn ,"{0}", ActorRef.GetLeveledActorBase().GetName() ), System.MSG_All)
	getLastSeenNPCs()
	System.Message("FWAbilityBeeingFemale::OnEffectStart("+ActorRef.GetLeveledActorBase().GetName()+") " + (Utility.GetCurrentRealTime() - startTime) + " sec", System.MSG_All, System.MSG_Trace)

	Utility.Wait(1.0)
	SetBelly()
	
	if(IsPlayer)
	else
		if(ActorRef.Is3DLoaded())
			int myNumChilds = StorageUtil.GetIntValue(ActorRef, "FW.NumChilds", numChilds)
			if(myNumChilds > 0)
				if(currentState < 4)
					System.InstantBornChilds(ActorRef)
					numChilds = 0
				elseif(currentState > 7)
					System.InstantBornChilds(ActorRef)
					numChilds = 0
				endif				
			endif
			
			if(StorageUtil.GetIntValue(none, "FW.AddOn.Global_RemoveSPIDitems", 0) == 1)
				FW_log.WriteLog("FWAbilityBeeingFemale : removing SPID distributed items for actor " + ActorRef + ", whose name is " + ActorRef.GetDisplayName())
				System.RemoveSPIDitems(ActorRef)
			endIf
		endif
	endIf
	
endEvent

Event OnPlayerLoadGame()
	float startTime = GameDaysPassed.GetValue()
	;if bInit;/==true/; && bInitSpell;/==true/;; && ActorRef.HasMagicEffect(System.BeeingFemaleSpell.GetNthEffectMagicEffect(0))
	if bInit ;Tkc (Loverslab): optimization
	 if bInitSpell
		;Utility.WaitMenuMode(2)
		SetBelly()
		Self.RegisterForSingleUpdate(5)
		Self.UnregisterForModEvent("BeeingFemale")
		Self.RegisterForModEvent("BeeingFemale", "BeeingFemale")
		Self.RegisterForSleep()
		; Always resync Papyrus state with FW.CurrentState on load — a previous
		; session may have saved with state machine desynced (stale nextState,
		; mismatched Self.GetState()). InitState() rebuilds it from currentState.
		InitValues()
		InitState()
		if oldUpdateDelay>0
			Self.RegisterForSingleUpdateGameTime(oldUpdateDelay)
		endif
		getLastSeenNPCs()
	 endif
	endif
	equipChild()
	System.Message("FWAbilityBeeingFemale::OnPlayerLoadGame() " + (Utility.GetCurrentRealTime() - startTime) + " sec", System.MSG_All, System.MSG_Trace)
endEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	if bInitSpell;/==true/;
		; Keep a dead woman's belly - a corpse shouldn't visibly deflate. Live
		; removals (idle-untrack / dispel) are only ever non-pregnant here, so
		; skipping ResetBelly for the dead is a no-op for them.
		if ActorRef && ActorRef.IsDead() ;Tkc-style: avoid the negation
		else
			ResetBelly()
		endif
		onExitState()
	endif
	; Defensive cleanup in case birth was interrupted.
	if akTarget
		StorageUtil.FormListRemove(none,"FW.GivingBirth", akTarget)
	endif
	If ActorRef && ActorRef.HasSpell(BeeingFemaleSpell)
		ActorRef.RemoveSpell(BeeingFemaleSpell)
	EndIf
	PO3_Events_AME.UnregisterForAllHitEventsEx(self)
endEvent

; Bane --> On Update is now only needed by the player for triggering any Baby events via the parent.Onupdate() function
event OnUpdate()
	if IsPlayer ;Tkc (Loverslab): offered by dldrzz000. Error with registerforsingleupdate still occuring in 1839 line aven with IsPlayer check and disappearing when same check here.
	;if ActorRef.HasMagicEffect(System.BeeingFemaleSpell.GetNthEffectMagicEffect(0))
		parent.OnUpdate()
		Self.RegisterForSingleUpdate(5)
	;endif
	endif
endEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName) ;Bane -> Treading water will trigger washout every few seconds
	;If asEventName == "SoundPlay" && ActorRef.IsSwimming() && !( ActorRef.WornHasKeyword(KwArmorCuirass) || ActorRef.WornHasKeyword(KwClothingBody) )
	If asEventName == "SoundPlay" ;Tkc (Loverslab): optimization
	 If ActorRef.IsSwimming()
	  If ( ActorRef.WornHasKeyword(KwArmorCuirass) || ActorRef.WornHasKeyword(KwClothingBody) )
	  else;If !( ActorRef.WornHasKeyword(KwArmorCuirass) || ActorRef.WornHasKeyword(KwClothingBody) )
		Controller.WashOutSperm(ActorRef, 1, 0.8)
		System.Message("Washout Sperm - "+ ActorRef.GetLeveledActorBase().GetName(),System.MSG_Debug)
	  EndIf
	 EndIf
	EndIf
EndEvent

event BeeingFemale(string eventName, string strArg, float numArg, Form sender)
	if eventName=="BeeingFemale"
		if strArg=="TestScale" && (sender==ActorRef || sender as actor==none)
			Debug.Notification("Test Scaling for "+ActorRef.GetLeveledActorBase().GetName())
			TestScale(numArg)
		elseif (numArg== ActorRef.GetFormID() || sender==ActorRef)
			if strArg=="CheckAbortus"
				checkAbortus()
			elseif strArg=="Update"
				InitValues()
				InitState()
			elseif strArg=="Belly"
				SetBelly(true)
			elseif strArg=="Birth"
				SetBelly(true)
			elseif strArg=="ConceptionChance"
				if (numArg==1 && IsPlayer;/==true/;) || (numArg==2 && IsFollower;/==true/;) || (numArg==3 && IsFollower==false)
					Controller.setAutoFlag(ActorRef)
				endif
			elseif strArg=="Dispel"
				Dispel()
			endIf
		endIf
	endif
endEvent

event OnUpdateGameTime()
	float startTime = GameDaysPassed.GetValue()
	float currentTime = GameDaysPassed.GetValue()
	if ActorRef.Is3DLoaded()
		; Idle-untrack timer: mark when she was last loaded (see FWSystem.TryUntrackIdleFemale).
		StorageUtil.SetFloatValue(ActorRef,"FW.LastLoaded",currentTime)
	endif
	string ActorCurrentState = Self.GetState()
	;FW_log.WriteLog("FWAbilityBeeingFemale::OnUpdateGameTime start - " + ActorRef.GetLeveledActorBase().GetName() + " state=" + CurrentState)
	;if System.IsActorPregnantByChaurus(ActorRef) && (Self.GetState() != "PregnantChaurus_State")
	if System.IsActorPregnantByChaurus(ActorRef) ;Tkc (Loverslab): optimization
	 if (ActorCurrentState == "PregnantChaurus_State")
	 else;if (Self.GetState() != "PregnantChaurus_State")
		Controller.Pause(ActorRef,true)
		;System.setObjective(21)	
		GoToState("PregnantChaurus_State")
	 endIf
	endIf
	

	if System.IsActorPregnantByEstrusSpider(ActorRef)
	 if (ActorCurrentState == "PregnantEstrusSpider_State")
	 else
		Controller.Pause(ActorRef,true)
		GoToState("PregnantEstrusSpider_State")
	 endIf
	endIf
	

	if System.IsActorPregnantByEstrusDwemer(ActorRef)
	 if (ActorCurrentState == "PregnantEstrusDwemer_State")
	 else
		Controller.Pause(ActorRef,true)
		GoToState("PregnantEstrusDwemer_State")
	 endIf
	endIf
	

	GetStorageVariable()
	
	float stateDuration = System.getStateDuration(CurrentState, ActorRef)

	if((CurrentState == 2) || (CurrentState == 8))
		If((ActorCurrentState == "PregnantChaurus_State") || (ActorCurrentState == "PregnantEstrusSpider_State") || (ActorCurrentState == "PregnantEstrusDwemer_State"))
			stateEnterTime = currentTime ;Hold Luteal or Replenish State at 0% complete whilst Chaurus Pregnant
		EndIf
	endIf


	if stateDuration > 0
		CurrentStatePercent = ((currentTime - stateEnterTime) * 100) / stateDuration
		StateDaysRemaining = stateDuration - (currentTime - stateEnterTime)
		;if currentTime >= stateEnterTime + stateDuration
		if(StateDaysRemaining <= 0)
			changeState(NextState)
		endIf
		Manager.onUpdateFunction(ActorRef,CurrentState,CurrentStatePercent)
	else
		CurrentStatePercent=0.0
		Manager.onUpdateFunction(ActorRef,CurrentState,0)
	endIf

	string ActorName = ActorRef.GetLeveledActorBase().GetName()
	if IsPlayer
		System.Message("OnUpdateGameTime " + ActorName + ": " + CurrentState + " at " + CurrentStatePercent + "% (Dur: " + stateDuration + ")", System.MSG_Debug)
	else
		System.Message("OnUpdateGameTime " + ActorName + ": " + CurrentState + " at " + CurrentStatePercent + "% (Dur: " + stateDuration + ")", System.MSG_All)
	endIf
	if currentState>=4 && currentState <20
		SetBelly();
		AbortusPains()
	endif

	if IsPlayer
		if System.Player ;Tkc (Loverslab): optimization
			;FW_log.WriteLog("FWAbilityBeeingFemale::OnUpdateGameTime - System.Player already set for " + ActorRef.GetLeveledActorBase().GetName())
		else;if System.Player==none
			;FW_log.WriteLog("FWAbilityBeeingFemale::OnUpdateGameTime - System.Player was none, setting to self for " + ActorRef.GetLeveledActorBase().GetName())
			System.Player=self
			System.PlayerMale=none
		endif
		float SizeDuration
		float matureHours = System.Manager.ActorCustomMatureTimeInHours(PlayerRef)
		if matureHours > 0.0
			SizeDuration = (matureHours / 24.0) / 5.0
		endif
		
		
		;find a player child item and grow/spawn child if time comes
		; Drop identity entries with no backing item (sold/dropped/destroyed) before hatching, so a
		; surviving twin still hatches and a removed one leaves no orphan. Player is always loaded.
		FWUtility.PruneOrphanBabyIdentities(PlayerRef)
		int babyitemCount = StorageUtil.FormListCount(none,"FW.Babys")
		FW_log.WriteLog("FWAbilityBeeingFemale::ChildArmor - player babyitemCount: " + babyitemCount)
		
		while babyitemCount > 0
			babyitemCount -= 1
			Form formarm = StorageUtil.FormListGet(none,"FW.Babys", babyitemCount)
			Armor childArmor = formarm  as Armor
			If (childArmor)
				FW_log.WriteLog("FWAbilityBeeingFemale::ChildArmor - armor entry in FW.Babys " + childArmor.GetName())
			EndIf
			
			; Player baby items hatch while simply CARRIED (equipped or in inventory). NPC mothers
			; hatch via the dedicated !IsPlayer branch below (only when the player is the father).
			if childArmor && PlayerRef.GetItemCount(childArmor) > 0
				int idx = StorageUtil.FormListFind(PlayerRef, "FW.BabyItemArmor", childArmor)
				if idx >= 0
					; Identity recorded at birth - per-baby dob/father (FIFO for twins)
					FW_log.WriteLog("FWAbilityBeeingFemale::ChildArmor - player child: " + childArmor.GetName())
					Actor itemFather = StorageUtil.FormListGet(PlayerRef, "FW.BabyItemFather", idx) as Actor
					float itemDob = StorageUtil.FloatListGet(PlayerRef, "FW.BabyItemDOB", idx)
					ProcessBabyItemTransitionToChild(PlayerRef, itemFather, SizeDuration, childArmor, itemDob, idx)
				else
					; Legacy item born before identity tracking - shared-key fallback.
					; Reads live here so the common paths pay nothing for them.
					Actor m = StorageUtil.GetFormValue(PlayerRef,"FW.ChildArmor.Mother",none) as Actor
					if m && m == PlayerRef
						FW_log.WriteLog("FWAbilityBeeingFemale::ChildArmor - player child (legacy): " + childArmor.GetName())
						Actor f = StorageUtil.GetFormValue(PlayerRef,"FW.ChildArmor.Father",none) as Actor
						float dob = StorageUtil.GetFloatValue(PlayerRef,"FW.ChildArmor.dob",0)
						ProcessBabyItemTransitionToChild(m,f,SizeDuration,childArmor,dob)
					endif
				endif
			endif
		endwhile
		GlobalPlayerState.SetValue(currentState)
		GlobalPlayerStatePercent.SetValue(CurrentStatePercent)
	endif

	;if !IsPlayer && currentState<4 && ActorRef.Is3DLoaded()
	if IsPlayer ;Tkc (Loverslab): optimization
	else;if !IsPlayer
	 ; NPC mother hatches her own carried baby into the mother's child when the PLAYER is the father.
	 ; Identity lives on the mother (FW.BabyItem*), so this reads locally. Guarded on Is3DLoaded so an
	 ; unloaded actor's unreliable inventory read can neither falsely prune nor mis-spawn.
	 int idCount = StorageUtil.FormListCount(ActorRef, "FW.BabyItemArmor")
	 if idCount > 0 && ActorRef.Is3DLoaded()
		FWUtility.PruneOrphanBabyIdentities(ActorRef)
		idCount = StorageUtil.FormListCount(ActorRef, "FW.BabyItemArmor")
		float npcMatureHours = System.Manager.ActorCustomMatureTimeInHours(ActorRef)
		float npcSizeDuration
		if npcMatureHours > 0.0
			npcSizeDuration = (npcMatureHours / 24.0) / 5.0
		endif
		while idCount > 0
			idCount -= 1 ; iterate downward: safe against removal at the current index
			Actor itemFather = StorageUtil.FormListGet(ActorRef, "FW.BabyItemFather", idCount) as Actor
			Armor npcArm = StorageUtil.FormListGet(ActorRef, "FW.BabyItemArmor", idCount) as Armor
			if itemFather == PlayerRef && npcArm && (ActorRef.IsEquipped(npcArm) || ActorRef.GetItemCount(npcArm) > 0)
				float npcItemDob = StorageUtil.FloatListGet(ActorRef, "FW.BabyItemDOB", idCount)
				ProcessBabyItemTransitionToChild(ActorRef, PlayerRef, npcSizeDuration, npcArm, npcItemDob, idCount, true)
			endif
		endwhile
	 endif
	 if currentState<4
	  if ActorRef.Is3DLoaded()
		if numChilds>0
			System.InstantBornChilds(ActorRef)
			numChilds=0
		endif
	  endif
	 endif
	endif
	OnUpdateFunction()
	if IsPlayer
		Controller.ApplySemenCircleTattoo(ActorRef)
		Controller.ApplyWombTattoo(ActorRef)
	endif
	FW_log.WriteLog("FWAbilityBeeingFemale::OnUpdateGameTime("+ActorRef.GetLeveledActorBase().GetName()+") " + (Utility.GetCurrentRealTime() - startTime) + " sec")
	;FW_log.WriteLog("FWAbilityBeeingFemale::OnUpdateGameTime end - " + ActorRef.GetLeveledActorBase().GetName() + " state=" + CurrentState + " percent=" + CurrentStatePercent)
	Utility.WaitMenuMode(1)
	If ActorRef.HasMagicEffect(_BFAbilityEffectBeeingFemale)
		Self.RegisterForSingleUpdateGameTime(oldUpdateDelay)
	EndIf
endEvent

Function ProcessBabyItemTransitionToChild(Actor mother,Actor father, float sizeDuration, Armor arm, float dob, int identityIdx = -1, bool bMothersChild = false)
	if dob == 0.0
		FW_log.WriteLog("FWChildArmor: ProcessBabyItemTransitionToChild: DOB is 0")
		return
	endif
	if !mother
		FW_log.WriteLog("FWChildArmor: ProcessBabyItemTransitionToChild: no mother")
		return
	endif
	Float age = GameDaysPassed.GetValue() - dob
	FW_log.WriteLog("FWChildArmor: Update tick (Age=" + age + ", SizeDuration=" + sizeDuration + ")")
	if age >= sizeDuration
		FW_log.WriteLog("FWChildArmor: Baby transitioned to child")
		; Use the identity recorded at birth so the child that hatches is the
		; same baby that was announced: name, sex and race context carry over.
		int gender = -1
		string babyName = ""
		race babyRace = none
		if identityIdx >= 0
			gender = StorageUtil.IntListGet(mother, "FW.BabyItemSex", identityIdx)
			babyName = StorageUtil.StringListGet(mother, "FW.BabyItemName", identityIdx)
			babyRace = StorageUtil.FormListGet(mother, "FW.BabyItemRace", identityIdx) as Race
		endif
		Actor newChild = System.SpawnChildActor(mother, father, babyRace, gender, babyName, bMothersChild)
		if newChild
			if identityIdx >= 0
				FWUtility.RemoveBabyItemIdentityAt(mother, identityIdx)
			endif
			; Register like SpawnChild does, so the MCM Children tab lists the child
			StorageUtil.FormListAdd(none, "FW.Babys", newChild)
			; Only the player path iterates FW.Babys, so only it consumes the base entry here.
			; FW.Babys holds shared armor BASE forms; removing on the NPC path could delete another
			; mother's (or the player's) entry for the same base. The NPC mother's leftover base entry
			; is harmless (player doesn't carry it) and is cleaned by the game-load FW.Babys purge.
			if !bMothersChild
				StorageUtil.FormListRemove(none, "FW.Babys", arm, false)
			endif
			mother.UnequipItem(arm)
			mother.RemoveItem(arm, 1, true)
		else
			; Spawn can fail (e.g. no child base for the race) - keep the item,
			; its FW.Babys entry and its identity entry so the next tick can retry
			FW_log.WriteLog("FWChildArmor: SpawnChildActor returned none, keeping baby item", 1)
		endif
		return
	endif

	float remainingDays = sizeDuration - age
	
	FW_log.WriteLog("FWChildArmor: Baby is growing. " + remainingDays + " days remaining.")
EndFunction

bool OnHitIsBusy
Event OnHitEx(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
if OnHitIsBusy;spamguard
else
	OnHitIsBusy = true
	
	parent.OnHitEx(akAggressor, akSource, akProjectile, abPowerAttack, abSneakAttack, abBashAttack, abHitBlocked)
	
	OnHitIsBusy = false
endif
endEvent

Event OnSpellCast(Form akSpell)
	if(akSpell)
		if (akSpell as Spell);/!=none/;
			onCastSpellFunction(akSpell as Spell)
		elseif (akSpell as potion);/!=none/;
			potion p = akSpell as potion
			onPotionFunction(p)
		endif
		If BadSpellList && BadSpellList.Find(akSpell)>=0 && currentState>=4 && currentState<20
			If IsPlayer
				System.Message( FWUtility.StringReplace( Contents.AlcoholNotGoodForYourBaby,"{0}",ActorRefBase.GetName()), System.MSG_Low)
			Else
				System.Message( FWUtility.StringReplace( Contents.AlcoholNotGoodForNPCBaby,"{0}",ActorRefBase.GetName()), System.MSG_High)
			EndIf
			Controller.DamageBaby(ActorRef, 8.0)
		EndIf
		parent.OnSpellCast(akSpell)
	endIf
EndEvent

;--------------------------------------------------------------------------------
; General Functions
;--------------------------------------------------------------------------------

function CheckRandomSexPartner()
	
endFunction

function InitValues()
	Data.Update(ActorRef)
	GetStorageVariable()
endFunction

function GetStorageVariable()
	stateEnterTime= StorageUtil.GetFloatValue(ActorRef, "FW.StateEnterTime", GameDaysPassed.GetValue())
	currentState= StorageUtil.GetIntValue(ActorRef, "FW.CurrentState",0)
	UnbornHealth = StorageUtil.GetFloatValue(ActorRef,"FW.UnbornHealth",100.0)
	NumChilds = StorageUtil.GetIntValue(ActorRef,"FW.NumChilds",0)
	AbortusTime = StorageUtil.GetFloatValue(ActorRef,"FW.AbortusTime",0.0)
	abortus = StorageUtil.GetIntValue(ActorRef, "FW.Abortus",0)
	RefreshNextState()
endFunction

function InitState()
	string StateName
	int ObjectiveID
	bool bStateFound=true
	if currentState < 5
		if currentState < 2
			if currentState==0
				;UpdateDelay=4.0 ; Less activity - lower update rate
				UpdateDelay = 1.0 ; To consider the addon option for impregnation at any period
				StateName="Follicular_State"
				ObjectiveID=0
				nextState = 1
			else
				UpdateDelay=1.0
				StateName="Ovulation_State"
				ObjectiveID=1
				nextState = 2
			endIf
		else
			if currentState < 4
				if currentState==2
					UpdateDelay=1.0
					StateName="Luteal_State"
					ObjectiveID=2
					nextState = 3
				else
					UpdateDelay=1.0
					StateName="Menstruation_State"
					ObjectiveID=3
					nextState = 0
				endIf
			else
				;UpdateDelay=3.0
				UpdateDelay = 1.0
				StateName="PregnancyFirst_State"
				ObjectiveID=4
				nextState = 5
			endIf
		endIf
	else
		if currentState < 7
			if currentState==5
				;UpdateDelay=3.0
				UpdateDelay = 1.0
				StateName="PregnancySecond_State"
				ObjectiveID=5
				nextState = 6
			else
				UpdateDelay=1.0
				StateName="PregnancyThird_State"
				ObjectiveID=6
				nextState = 7
			endIf
		else
			if currentState < 9
				if currentState==7
					UpdateDelay=0.2
					StateName="LaborPains_State"
					ObjectiveID=7
					nextState = 8
				else
					UpdateDelay=1.0
					StateName="Replanish_State"
					ObjectiveID=8
					nextState = 0
				endIf
			else
				bStateFound=false
			endIf
		endIf
	endIf
	
	if IsPlayer
		GlobalPlayerState.SetValue(currentState)
	endif
	
	if self as string != "[FWAbilityBeeingFemale <None>]" ; Reverted by Bane - This is a reliable method for avoiding the error RegisterForSingleUpdateGameTime - no native object bound to the script object, or object is of incorrect type
		;if oldUpdateDelay!=UpdateDelay && bInit;/==true/; && bInitSpell;/==true/;
		if oldUpdateDelay==UpdateDelay ;Tkc (Loverslab): optimization
		else;if oldUpdateDelay!=UpdateDelay
		 if bInit;/==true/;
		  if bInitSpell;/==true/; 
			;Self.UnregisterForUpdateGameTime() 
			;if UpdateDelay > 0 && System.cfg.PlayerTimer
			if UpdateDelay > 0
				if cfg.PlayerTimer
					;if IsPlayer ;Tkc (Loverslab): Fix for error reported by dldrzz000:  Reverted by Bane ***This is also for npcs and stopped npc cyrcles*******
						Self.RegisterForSingleUpdateGameTime(UpdateDelay) 
					;endIf
				endIf
			endIf
			oldUpdateDelay = UpdateDelay
		  endIf
		 endIf
		endIf
		if bStateFound
			onExitState()
			stateEnterTime = GameDaysPassed.GetValue()
			CurrentStatePercent=0.0
			StateDaysRemaining = System.getStateDuration(currentState, ActorRef)
			GoToState(StateName)
			castStateSpell()
			onEnterState()
			System.raiseModEvent("stateChanged",self)
		Else
			System.Message( FWUtility.StringReplace( Contents.StateNotFound,"{0}",StateName), System.MSG_Error)
		endIf
	endif
endFunction

function changeState(int NewState)
	if (abortus > 1 && (NewState==4 || NewState==5 || NewState==6)) || (abortus > 2 && NewState==7)
		FW_log.WriteLog("FWAbilityBeeingFemale.changeState: blocked state " + NewState + " for " + ActorRef + " (abortus=" + abortus + ")")
		return
	endif
	FW_log.WriteLog("FWAbilityBeeingFemale.changeState: " + ActorRef + " state " + currentState + " -> " + NewState)
	; Commit StateEnterTime BEFORE CurrentState so any re-entrant OnUpdateGameTime
	; that observes the new currentState also sees the matching enter time.
	float now = GameDaysPassed.GetValue()
	StorageUtil.SetFloatValue(ActorRef,"FW.StateEnterTime", now)
	StorageUtil.SetFloatValue(ActorRef,"FW.LastUpdate", now)
	stateEnterTime = now
	StorageUtil.SetIntValue(ActorRef,"FW.CurrentState",NewState)
	currentState = NewState
	RefreshNextState()
	if System && System.Controller
		System.Controller.UpdateParentFaction(ActorRef)
	endif
	InitState()
endFunction

; Recompute nextState purely from currentState. Mirrors the InitState lookup
; table so a stale persisted nextState (e.g. 0 from a prior Menstruation cycle)
; can't drive an out-of-band changeState into the wrong phase.
function RefreshNextState()
	if currentState < 5
		if currentState < 2
			if currentState == 0
				nextState = 1
			else
				nextState = 2
			endIf
		else
			if currentState < 4
				if currentState == 2
					nextState = 3
				else
					nextState = 0
				endIf
			else
				nextState = 5
			endIf
		endIf
	else
		if currentState < 7
			if currentState == 5
				nextState = 6
			else
				nextState = 7
			endIf
		else
			if currentState == 7
				nextState = 8
			else
				nextState = 0
			endIf
		endIf
	endIf
endFunction

function castStateSpell()
	if ActorRef ;Tkc (Loverslab): optimization
	else;if !ActorRef
		return
	endif
	int i=0
	while i<=8
		if currentState == i
			if ActorRef.HasSpell(StatCycleID_List[i]) ;Tkc (Loverslab): optimization
			else
				ActorRef.AddSpell(StatCycleID_List[i],false)
			endif
		else
			if ActorRef.HasSpell(StatCycleID_List[i])
				ActorRef.RemoveSpell(StatCycleID_List[i])
			endif
		endif
		i+=1
	endWhile
	
	if currentState >= 0
		if currentState<4
			; Cycle
			if ActorRef.HasSpell(StatMenstruationCycle) ;Tkc (Loverslab): optimization
			else;if ActorRef.HasSpell(System.StatMenstruationCycle)==false
				ActorRef.AddSpell(StatMenstruationCycle,false)
			endIf
			if ActorRef.HasSpell(StatPregnancyCycle)
				ActorRef.RemoveSpell(StatPregnancyCycle)
			endIf
		else
			if currentState<20
			; Pregnant
				if ActorRef.HasSpell(StatMenstruationCycle)
					ActorRef.RemoveSpell(StatMenstruationCycle)
				endIf
				if ActorRef.HasSpell(StatPregnancyCycle) ;Tkc (Loverslab): optimization
				else;if ActorRef.HasSpell(System.StatPregnancyCycle)==false
					ActorRef.AddSpell(StatPregnancyCycle,false)
				endIf
			else
				; Pregnant by other mod?
				if ActorRef.HasSpell(StatMenstruationCycle)
					ActorRef.RemoveSpell(StatMenstruationCycle)
				endIf
				if ActorRef.HasSpell(StatPregnancyCycle)
					ActorRef.RemoveSpell(StatPregnancyCycle)
				endIf
			endIf
		endIf
	else
		; Pregnant by other mod?
		if ActorRef.HasSpell(StatMenstruationCycle)
			ActorRef.RemoveSpell(StatMenstruationCycle)
		endIf
		if ActorRef.HasSpell(StatPregnancyCycle)
			ActorRef.RemoveSpell(StatPregnancyCycle)
		endIf
	endif
endFunction

float function timeRemaining()
	if System.getStateDuration(currentState, ActorRef) > 0
		return System.getStateDuration(currentState, ActorRef) - (GameDaysPassed.GetValue() - stateEnterTime)
	else
		return GameDaysPassed.GetValue() - stateEnterTime
	endIf
endFunction

function getLastSeenNPCs()
	; FW.LastSeenNPCs is read only by the auto-insemination "last seen" father
	; source. When that source is off, skip the scan entirely instead of building
	; a list nothing will consume.
	if !cfg.ImpregnateActive || !cfg.ImpregnateLastNPC
		return
	endif
	; PapyrusUtil's ScanCellNPCs (already a hard dependency) returns living actors
	; in the cell directly - no PO3, no keyword, no ObjectReference->Actor cast.
	; Creatures are filtered by addLastSeenNPC's male validation below.
	Actor[] nearby = MiscUtil.ScanCellNPCs(ActorRef, 2500.0)
	int n = 0
	while n < nearby.length && n < 10
		actor a = nearby[n]
		if a && a != PlayerRef
			addLastSeenNPC(a)
		endif
		n += 1
	endWhile
	; Clear old values
	int c = StorageUtil.FormListCount(ActorRef,"FW.LastSeenNPCs")
	float t = GameDaysPassed.GetValue()
	while c>0
		c-=1
		; Remove all actors that are older then 2 Days and not in the same location
		float tt = StorageUtil.FloatListGet(ActorRef,"FW.LastSeenNPCsTime",c)
		actor ta = StorageUtil.FormListGet(ActorRef,"FW.LastSeenNPCs",c) as actor
		if ta==none || ta.IsDead()
			StorageUtil.FloatListRemoveAt(ActorRef, "FW.LastSeenNPCsTime", c)
			StorageUtil.FormListRemoveAt(ActorRef, "FW.LastSeenNPCs", c)
		elseif tt < t - 2
			Location Loc = ta.GetCurrentLocation()
			;if Loc && !ActorRef.IsInLocation(Loc)
			if Loc ;Tkc (Loverslab): optimization
				if ActorRef.IsInLocation(Loc)
				else;if !ActorRef.IsInLocation(Loc)
					StorageUtil.FloatListRemoveAt(ActorRef, "FW.LastSeenNPCsTime", c)
					StorageUtil.FormListRemoveAt(ActorRef, "FW.LastSeenNPCs", c)
				endif
			endif
		endif
	endWhile
endFunction
function addLastSeenNPC(actor a)
	;if System.IsValidateMaleActor(a)>0 && !a.GetRace().HasKeywordString("ActorTypeCreature")
	if System.IsValidateMaleActor(a)>0 ;Tkc (Loverslab): optimization
	 if a.GetRace().HasKeywordString("ActorTypeCreature")
	 else;if !a.GetRace().HasKeywordString("ActorTypeCreature")
		int pos=StorageUtil.FormListFind(ActorRef,"FW.LastSeenNPCs", a)
		if pos==-1
			StorageUtil.FormListAdd(ActorRef,"FW.LastSeenNPCs",a)
			StorageUtil.FloatListAdd(ActorRef,"FW.LastSeenNPCsTime", GameDaysPassed.GetValue())
		else
			StorageUtil.FloatListSet(ActorRef,"FW.LastSeenNPCsTime", pos, GameDaysPassed.GetValue())
		endif
	 endif
	endif
endFunction




;--------------------------------------------------------------------------------
; Abortus Functions
;--------------------------------------------------------------------------------
;   0	None
;   1	Abortus_imminens // drohender abortus
;   2	Abortus_incipiens // beginnender Abortus
;   3	Abortus_incompletus // unvollständiger Abort
;   4	Abortus_completus // vollständiger Abortus
;   5	Missed_Abortion // verhaltener Abort
;   6	Miscarriage // Totgeburt
bool function checkAbortus() ; SensebilityPercent - 20 = up to 20% Chances to losing child, 50 = up to 50% chance to lossingchild
	if cfg.abortus ;Tkc (Loverslab): optimization
	else;if System.cfg.abortus==false
		return false
	endif
	if currentState<4 && currentState==8
		; Not pregnant or in replenish
		return false
	endif
	float hp = StorageUtil.GetFloatValue(ActorRef, "FW.UnbornHealth",100.0)
	numChilds = StorageUtil.GetIntValue(ActorRef, "FW.NumChilds",0)
	AbortusTime = StorageUtil.GetFloatValue(ActorRef,"FW.AbortusTime",0.0)
	abortus = StorageUtil.GetIntValue(ActorRef, "FW.Abortus",0)
	
	float trimesterTimeDay=System.GetStateDuration(currentState,ActorRef) / 89
	
	if abortus < 4
		if abortus<=2
			if hp < 8 && numChilds>0 ;&& abortus<=2 ; Init abortus
				if abortus == 0
					if hp>0
						; Abortus_imminens // drohender abortus
						StorageUtil.SetIntValue(ActorRef, "FW.Abortus",1)
						StorageUtil.SetFloatValue(ActorRef, "FW.AbortusTime",GameDaysPassed.GetValue())
					else;if abortus==0 && hp<=0
						StorageUtil.SetIntValue(ActorRef, "FW.Abortus",2)
						StorageUtil.SetFloatValue(ActorRef, "FW.AbortusTime",GameDaysPassed.GetValue())
						StorageUtil.SetFloatValue(ActorRef, "FW.UnbornHealth",0.0)
					endIf
				else
					if AbortusTime > 0
						if abortus == 1
							if(((GameDaysPassed.GetValue() - AbortusTime) > trimesterTimeDay * 2) && (hp <= 4))
								; Abortus_incipiens // beginnender Abortus
								StorageUtil.SetIntValue(ActorRef, "FW.Abortus",2)
								StorageUtil.SetFloatValue(ActorRef, "FW.AbortusTime",GameDaysPassed.GetValue())
								StorageUtil.SetFloatValue(ActorRef, "FW.UnbornHealth",0.0)
							endIf
						elseif abortus == 2
							if((GameDaysPassed.GetValue() - AbortusTime) > trimesterTimeDay * 3)
								; Abortus variance
								int randomAbortus=Utility.RandomInt(0,50)
								float infectChance=0
								float fiberChance=0
								
								if CurrentState==4
									if randomAbortus < 13 && CurrentStatePercent<14 ;&& CurrentState==4
										; Abortus_completus // vollständiger Abortus
										StorageUtil.SetIntValue(ActorRef, "FW.Abortus",4)
										StorageUtil.SetFloatValue(ActorRef, "FW.AbortusTime",GameDaysPassed.GetValue())
										fiberChance = 0.2
										infectChance = 0.1
									elseif randomAbortus<41 ;&& CurrentState==4
										; Abortus_incompletus // unvollständiger Abort
										StorageUtil.SetIntValue(ActorRef, "FW.Abortus",3)
										StorageUtil.SetFloatValue(ActorRef, "FW.AbortusTime",GameDaysPassed.GetValue())
										fiberChance = 8.1
										infectChance = 0.62
									else;if CurrentState==4
										; Missed_Abortion // verhaltener Abort
										StorageUtil.SetIntValue(ActorRef, "FW.Abortus",5)
										StorageUtil.SetFloatValue(ActorRef, "FW.AbortusTime",GameDaysPassed.GetValue())
										fiberChance = 0.35
										infectChance = 0.21
									endIf
								elseif CurrentState>4 && CurrentState<20
									; Miscarriage // Totgeburt
									StorageUtil.SetIntValue(ActorRef, "FW.Abortus",6)
									StorageUtil.SetFloatValue(ActorRef, "FW.AbortusTime",GameDaysPassed.GetValue())
									fiberChance = 0.71
									infectChance = 0.43
								endif
								Abortus_Fiber = fiberChance> Utility.RandomFloat(0.0,1.0)
								Abortus_Infection = infectChance> Utility.RandomFloat(0.0,1.0)
							endif
						endIf
					endIf
				endIf
				return true
			; Baby got some life again
			elseif hp>=10 && abortus<2
				StorageUtil.UnsetIntValue(ActorRef,"FW.Abortus")
				StorageUtil.UnsetFloatValue(ActorRef,"FW.AbortusTime")
			endIf		
		; Abortus_incompletus
		elseif AbortusTime > 0
			if((GameDaysPassed.GetValue() - AbortusTime) > trimesterTimeDay * 12)
				castAbortus(5,true)
				return true
			endIf
		endIf
	elseif AbortusTime > 0
		if abortus < 6
			if abortus == 4
				; Abortus_completus
				if((GameDaysPassed.GetValue() - AbortusTime) > trimesterTimeDay * 11)
					castAbortus(3,true)
					return true
				endIf
			; Missed_Abortion
			else
				if((GameDaysPassed.GetValue() - AbortusTime) > trimesterTimeDay * 13)
					castAbortus(4,true)
					return true
				endIf
			endIf
		; still birth
		elseif((abortus==6) && ((GameDaysPassed.GetValue() - AbortusTime) > trimesterTimeDay * 16))
			castAbortus(4,true)
			return true
		endIf
	endIf
	return false
endFunction

function AbortusPains()
	if cfg.abortus ;Tkc (Loverslab): optimization
	else;if System.cfg.abortus==false
		return
	endif
	if abortus >0
		float Abortus_DamageScale = System.getDamageScale(5, ActorRef)

		; Find the list of fathers
		int my_num_men = StorageUtil.FormListCount(ActorRef, "FW.ChildFather")
		float my_Abortus_DamageScale = 0
		float temp_Abortus_DamageScale = 0
		actor a = none
		race abr = none
		while my_num_men > 0
			my_num_men -= 1
			a = (StorageUtil.FormListGet(ActorRef, "FW.ChildFather", my_num_men) As Actor)
			if a
				temp_Abortus_DamageScale = StorageUtil.GetFloatValue(a, "FW.AddOn.Modify_Pain_Abortus_by_FatherRace", 1.0)
				if(temp_Abortus_DamageScale == 1.0)
					abr = a.GetRace()
					if abr
						temp_Abortus_DamageScale = StorageUtil.GetFloatValue(abr, "FW.AddOn.Modify_Pain_Abortus_by_FatherRace", 1.0)
					endIf
				endIf
				
				if(temp_Abortus_DamageScale > my_Abortus_DamageScale)
					my_Abortus_DamageScale = temp_Abortus_DamageScale
				endIf
			endIf
		endWhile
		Abortus_DamageScale *= my_Abortus_DamageScale
				
		if(Abortus_DamageScale > 0)
			if abortus < 5
				if abortus < 4
					if abortus==2
						if Utility.RandomInt(0,10)>6
							System.Blur(Utility.RandomFloat(0.3,1.0), iModPainLow)
						endIf
					else
						if Utility.RandomInt(0,10)>3
							System.Blur(Utility.RandomFloat(0.4,1.0), iModPainMiddle)
							System.PlayPainSound(ActorRef)
							System.DoDamage(ActorRef,3*Abortus_DamageScale,14)
						endIf
					endIf
				else
					if Utility.RandomInt(0,10)>7
						System.Blur(Utility.RandomFloat(0.4,0.8), iModPainMiddle)
						System.PlayPainSound(ActorRef)
						System.DoDamage(ActorRef,2*Abortus_DamageScale,14)
					endIf
				endIf
			else
				if abortus==5
					if Utility.RandomInt(0,10)>5
						System.Blur(Utility.RandomFloat(0.4,0.8), iModPainMiddle)
						System.PlayPainSound(ActorRef)
						System.DoDamage(ActorRef,4*Abortus_DamageScale,14)
					endIf
				elseif abortus==6 && Utility.RandomInt(0,10)>4
					if Utility.RandomInt(0,10)>7
						System.Blur(Utility.RandomFloat(0.4,0.6), iModPainHigh)
					else
						System.Blur(Utility.RandomFloat(0.4,0.8), iModPainMiddle)
					endif
					System.PlayPainSound(ActorRef)
					System.DoDamage(ActorRef,2*Abortus_DamageScale,14)
					Utility.Wait(5)
				endIf
			endif
		
			if Abortus_Fiber;/==true/;
				System.ActorAddSpellOpt(ActorRef, FeverSpell, ShowMsg=cfg.Messages<4) ;Tkc (Loverslab): added ShowMsg parameter to not show messages when Innmersion or None Messages mode
			endIf
			if Abortus_Infection;/==true/;
				System.ActorAddSpellOpt(ActorRef, InfectionSpell, ShowMsg=cfg.Messages<4) ;Tkc (Loverslab): added ShowMsg parameter to not show messages when Innmersion or None Messages mode
			endIf
		
			if GlobalMenstruating.GetValue() As int; == 1
				if Utility.RandomInt(1, 100) < 34
					ActorRef.DispelSpell(Effect_VaginalBloodLow)
					System.ActorAddSpellOpt(ActorRef,Effect_VaginalBloodHigh, false, true, ShowMsg=cfg.Messages<4) ;Tkc (Loverslab): added ShowMsg parameter to not show messages when Innmersion or None Messages mode
				else
					ActorRef.DispelSpell(Effect_VaginalBloodHigh)	
					System.ActorAddSpellOpt(ActorRef,Effect_VaginalBloodLow, false, true, ShowMsg=cfg.Messages<4) ;Tkc (Loverslab): added ShowMsg parameter to not show messages when Innmersion or None Messages mode
				endif
			endif
		endIf
		
		Utility.Wait(1)
		checkAbortus()
	endif
endfunction


function castAbortus(float Strength, bool AllowBleedOut = false)
	bool bool_exceptionalCase = false
	if(System.IsActorPregnantByChaurus(ActorRef) || System.IsActorPregnantByEstrusSpider(ActorRef) || System.IsActorPregnantByEstrusDwemer(ActorRef))
		bool_exceptionalCase = true
	endIf

	if((cfg.abortus) || bool_exceptionalCase) ;Tkc (Loverslab): optimization
	else;if System.cfg.abortus==false
		return
	endif

	float Abortus_DamageScale = System.getDamageScale(5, ActorRef)

	; Find the list of fathers
	int my_num_men = StorageUtil.FormListCount(ActorRef, "FW.ChildFather")
	float my_Abortus_DamageScale = 0
	float temp_Abortus_DamageScale = 0
	actor a = none
	race abr = none
	while my_num_men > 0
		my_num_men -= 1
		a = (StorageUtil.FormListGet(ActorRef, "FW.ChildFather", my_num_men) As Actor)
		if a
			temp_Abortus_DamageScale = StorageUtil.GetFloatValue(a, "FW.AddOn.Modify_Pain_Abortus_by_FatherRace", 1.0)
			if(temp_Abortus_DamageScale == 1.0)
				abr = a.GetRace()
				if abr
					temp_Abortus_DamageScale = StorageUtil.GetFloatValue(abr, "FW.AddOn.Modify_Pain_Abortus_by_FatherRace", 1.0)
				endIf
			endIf
			
			if(temp_Abortus_DamageScale > my_Abortus_DamageScale)
				my_Abortus_DamageScale = temp_Abortus_DamageScale
			endIf
		endIf
	endWhile
	Abortus_DamageScale *= (Strength * my_Abortus_DamageScale)
	if(Abortus_DamageScale > 0)
		if IsPlayer
			FWUtility.LockPlayer()
		endif
		
		bool bIsVaginalBleedingEmitter=false
		System.Blur(1,AbortusImod)
		Utility.Wait(1)
		if AllowBleedOut
			Debug.SendAnimationEvent(ActorRef, "IdleForceDefaultState")
			Debug.SendAnimationEvent(ActorRef, "BleedOutStart")
			Utility.Wait(2)
			if ( ActorRef.WornHasKeyword(KwArmorCuirass) || ActorRef.WornHasKeyword(KwClothingBody) ) ;Tkc (Loverslab): optimization
			else;if !( ActorRef.WornHasKeyword(KwArmorCuirass) || ActorRef.WornHasKeyword(KwClothingBody) )
				; Actor is naked - start bleeding effect
				FWUtility.EquipItem(ActorRef,VaginalBleeding)
				bIsVaginalBleedingEmitter=true
			endif
		endif
		
		ActorRef.DispelSpell(Effect_VaginalBloodLow)
		ActorRef.DispelSpell(Effect_VaginalBloodHigh)	
		Effect_VaginalBloodBig.cast(ActorRef,ActorRef)
		
		int i = Utility.RandomInt(6,9)
		
		while i > 0
			i-=1
			System.PlayPainSound(ActorRef)
			;System.DoDamage(ActorRef,Strength*Abortus_DamageScale,14)
			System.DoDamage(ActorRef, Abortus_DamageScale, 14)
			Utility.Wait(1.5)
		endWhile
		
		if bIsVaginalBleedingEmitter;/==true/;
			FWUtility.UnEquipItem(ActorRef, VaginalBleeding)
			Utility.Wait(2)
		endif
		
		if ActorRef == PlayerRef
			System.Message( FWUtility.StringReplace( Contents.YouHaveLostYourChild,"{0}",ActorRef.GetLeveledActorBase().GetName()), System.MSG_Immersive)
			Utility.Wait(1)
		else
			System.Message( FWUtility.StringReplace( Contents.NPCHasLostItsChild,"{0}",ActorRef.GetLeveledActorBase().GetName()), System.MSG_Immersive)
		endif
		
		if AllowBleedOut
			Debug.SendAnimationEvent(ActorRef, "BleedOutStop");
		endif
	
		StorageUtil.SetIntValue(ActorRef,"FW.NumChilds",0)
		StorageUtil.UnsetFloatValue(ActorRef,"FW.UnbornHealth")
		FWUtility.ClearChildFathers(ActorRef)
		StorageUtil.UnsetFloatValue(ActorRef,"FW.AbortusTime")
		StorageUtil.UnsetIntValue(ActorRef,"FW.Abortus")
		
		Utility.Wait(1)
		if IsPlayer
			FWUtility.UnlockPlayer()
		endif
	else
		StorageUtil.SetIntValue(ActorRef,"FW.NumChilds",0)
		StorageUtil.UnsetFloatValue(ActorRef,"FW.UnbornHealth")
		FWUtility.ClearChildFathers(ActorRef)
		StorageUtil.UnsetFloatValue(ActorRef,"FW.AbortusTime")
		StorageUtil.UnsetIntValue(ActorRef,"FW.Abortus")

		Utility.Wait(1)
	endIf
	changeState(8)
endFunction


;--------------------------------------------------------------------------------
; Belly and Brust Size functions
;--------------------------------------------------------------------------------
Function GetBaseMeasurements(Bool bInitMeasurements = False)
	If bInitMeasurements || (BaseBellySize.Length != 2)
		BaseBellySize = New Float[2]
		BaseBellySize[0] = 1.0
		BaseBellySize[1] = 1.0
	EndIf
	If bInitMeasurements || (BaseBreastSize.Length != 8)
		BaseBreastSize = New Float[8]
		BaseBreastSize[0] = 1.0
		BaseBreastSize[1] = 1.0
		BaseBreastSize[2] = 1.0
		BaseBreastSize[3] = 1.0
		BaseBreastSize[4] = 1.0
		BaseBreastSize[5] = 1.0
		BaseBreastSize[6] = 1.0
		BaseBreastSize[7] = 1.0
	EndIf
	
	If NetImmerse.HasNode(ActorRef, "NPC Belly", True)
		BaseBellySize[0] = NetImmerse.GetNodeScale(ActorRef, "NPC Belly", True)
	EndIf
	If NetImmerse.HasNode(ActorRef, "NPC Belly", False)
		BaseBellySize[1] = NetImmerse.GetNodeScale(ActorRef, "NPC Belly", False)
	EndIf
	
	If NetImmerse.HasNode(ActorRef, "NPC L Breast", True)
		BaseBreastSize[0] = NetImmerse.GetNodeScale(ActorRef, "NPC L Breast", True)
	EndIf
	If NetImmerse.HasNode(ActorRef, "NPC L Breast", False)
		BaseBreastSize[1] = NetImmerse.GetNodeScale(ActorRef, "NPC L Breast", False)
	EndIf
	
	If NetImmerse.HasNode(ActorRef, "NPC R Breast", True)
		BaseBreastSize[2] = NetImmerse.GetNodeScale(ActorRef, "NPC R Breast", True)
	EndIf
	If NetImmerse.HasNode(ActorRef, "NPC R Breast", False)
		BaseBreastSize[3] = NetImmerse.GetNodeScale(ActorRef, "NPC R Breast", False)
	EndIf
	
	If NetImmerse.HasNode(ActorRef, "NPC L Breast01", True)
		BaseBreastSize[4] = NetImmerse.GetNodeScale(ActorRef, "NPC L Breast01", True)
	EndIf
	If NetImmerse.HasNode(ActorRef, "NPC L Breast01", False)
		BaseBreastSize[5] = NetImmerse.GetNodeScale(ActorRef, "NPC L Breast01", False)
	EndIf
	
	If NetImmerse.HasNode(ActorRef, "NPC R Breast01", True)
		BaseBreastSize[6] = NetImmerse.GetNodeScale(ActorRef, "NPC R Breast01", True)
	EndIf
	If NetImmerse.HasNode(ActorRef, "NPC R Breast01", False)
		BaseBreastSize[7] = NetImmerse.GetNodeScale(ActorRef, "NPC R Breast01", False)
	EndIf
	
	BaseWeight = ActorRefBase.GetWeight()
	
	If ( bInitMeasurements) ;Tkc (Loverslab): optimization
	else;If (! bInitMeasurements)
		BaseBellySize[0] = BaseBellySize[0] - AddedBellySize
		BaseBellySize[1] = BaseBellySize[1] - AddedBellySize
		
		BaseBreastSize[0] = BaseBreastSize[0] - AddedBreastSize
		BaseBreastSize[1] = BaseBreastSize[1] - AddedBreastSize
		BaseBreastSize[2] = BaseBreastSize[2] - AddedBreastSize
		BaseBreastSize[3] = BaseBreastSize[3] - AddedBreastSize
		
		BaseBreastSize[4] = BaseBreastSize[4] - AddedBreastSize
		BaseBreastSize[5] = BaseBreastSize[5] - AddedBreastSize
		BaseBreastSize[6] = BaseBreastSize[6] - AddedBreastSize
		BaseBreastSize[7] = BaseBreastSize[7] - AddedBreastSize
		
		BaseWeight -= AddedWeight
	EndIf
EndFunction

Function SLIF_inflate(Actor kActor, String sKey, float value)
	SLIF_Main.inflate(kActor, "Beeing Female", sKey, value, -1, -1, "BeeingFemale")
	;int SLIF_event = ModEvent.Create("SLIF_inflate")
	;If (SLIF_event)
		;ModEvent.PushForm(SLIF_event, kActor)
		;ModEvent.PushString(SLIF_event, "Beeing Female")
		;ModEvent.PushString(SLIF_event, sKey)
		;ModEvent.PushFloat(SLIF_event, value)
		;ModEvent.PushString(SLIF_event, "BeeingFemale")
		;ModEvent.Send(SLIF_event)
	;EndIf
EndFunction

Function SLIF_unregisterNode(Actor kActor, String sKey)
	SLIF_Main.unregisterNode(kActor, sKey, "Beeing Female")
	;int SLIF_event = ModEvent.Create("SLIF_unregisterNode")
	;If (SLIF_event)
		;ModEvent.PushForm(SLIF_event, kActor)
		;ModEvent.PushString(SLIF_event, "Beeing Female")
		;ModEvent.PushString(SLIF_event, sKey)
		;ModEvent.Send(SLIF_event)
	;EndIf
EndFunction

Function FillHerUpUpdateNotes(Float afAddedBellySize, Float afAddedBreastSize)
	if cfg.BellyScale;/==true/;
		SLIF_Morph.morph(ActorRef, "Beeing Female", cfg.InflateMorph, afAddedBellySize/10, "BeeingFemale")
	else
		SLIF_Morph.morph(ActorRef, "Beeing Female", cfg.InflateMorph, 0.0, "BeeingFemale")
	endIf
	If cfg.BreastScale;/==true/;
		SLIF_Morph.morph(ActorRef, "Beeing Female", cfg.BreastInflateMorph, afAddedBreastSize/10, "BeeingFemale")
	Else
		SLIF_Morph.morph(ActorRef, "Beeing Female", cfg.BreastInflateMorph, 0.0, "BeeingFemale")
	EndIf
	NiOverride.UpdateModelWeight(ActorRef);Pregnancy Swapper
	int eid = ModEvent.Create("PNSUpdateRequest")
	ModEvent.PushForm(eid, ActorRef)
	ModEvent.Send(eid)
EndFunction

Function UpdateNodesSLIF(Float afAddedBellySize, Float afAddedBreastSize)
	If cfg.BellyScale;/==true/;
		if afAddedBellySize > 0.001
		SLIF_inflate(ActorRef, "slif_belly", afAddedBellySize + 1)
		else
			SLIF_unregisterNode(ActorRef, "slif_belly")
		endif
	Else
		SLIF_unregisterNode(ActorRef, "slif_belly")
	EndIf
	If cfg.BreastScale;/==true/;
		if afAddedBreastSize > 0.001
		SLIF_inflate(ActorRef, "slif_breast", afAddedBreastSize + 1)
		else
			SLIF_unregisterNode(ActorRef, "slif_breast")
		endif
	Else
		SLIF_unregisterNode(ActorRef, "slif_breast")
	EndIf
EndFunction

Function UpdateBodyMorphs(Float afBellyScale, Float afBreastScale)
	If ActorRef;/!=none/;
		; BodyMorph
		If cfg.BellyScale;/==true/;
			NiOverride.SetBodyMorph(ActorRef, "PregnancyBelly", "BeeingFemale", afBellyScale)
		Else
			NiOverride.ClearBodyMorph(ActorRef, "PregnancyBelly", "BeeingFemale")
		EndIf
		
		If cfg.BreastScale;/==true/;
			NiOverride.SetBodyMorph(ActorRef, "BreastsSH", "BeeingFemale", afBreastScale)
			NiOverride.SetBodyMorph(ActorRef, "BreastsNewSH", "BeeingFemale", afBreastScale)
		Else
			NiOverride.ClearBodyMorph(ActorRef, "BreastsSH", "BeeingFemale")
			NiOverride.ClearBodyMorph(ActorRef, "BreastsNewSH", "BeeingFemale")
		EndIf
		
		NiOverride.UpdateModelWeight(ActorRef)
	EndIf
EndFunction

Function ClearBodyMorphs()
	If ActorRef;/!=none/;
		; BodyMorph
		NiOverride.ClearBodyMorph(ActorRef, "PregnancyBelly", "BeeingFemale")
		NiOverride.ClearBodyMorph(ActorRef, "BreastsSH", "BeeingFemale")
		NiOverride.ClearBodyMorph(ActorRef, "BreastsNewSH", "BeeingFemale")
		NiOverride.UpdateModelWeight(ActorRef)
	EndIf
EndFunction

Function UpdateNodes2(Float afAddedBellySize, Float afAddedBreastSize)
	If ActorRef;/!=none/;
		If cfg.BellyScale;/==true/;
			if(afAddedBellySize>0)  ;Patched by qotsafan was ->  if(afAddedBreastSize>0)
				NiOverride.AddNodeTransformScale(ActorRef, true, true, "NPC Belly", "BeeingFemale", afAddedBellySize +1)
				NiOverride.AddNodeTransformScale(ActorRef, false, true, "NPC Belly", "BeeingFemale", afAddedBellySize +1)
			else
				NiOverride.RemoveNodeTransformScale(ActorRef, true, true, "NPC Belly", "BeeingFemale")
				NiOverride.RemoveNodeTransformScale(ActorRef, false, true, "NPC Belly", "BeeingFemale")
			endif
			
			NiOverride.UpdateNodeTransform(ActorRef, true, true, "NPC Belly")
			NiOverride.UpdateNodeTransform(ActorRef, false, true, "NPC Belly")
		EndIf
		
		If cfg.BreastScale;/==true/;
			if(afAddedBreastSize>0)
				NiOverride.AddNodeTransformScale(ActorRef, true, true, "NPC L Breast", "BeeingFemale", afAddedBreastSize +1)
				NiOverride.AddNodeTransformScale(ActorRef, false, true, "NPC L Breast", "BeeingFemale", afAddedBreastSize +1)
				
				NiOverride.AddNodeTransformScale(ActorRef, true, true, "NPC R Breast", "BeeingFemale", afAddedBreastSize +1)
				NiOverride.AddNodeTransformScale(ActorRef, false, true, "NPC R Breast", "BeeingFemale", afAddedBreastSize +1)
				
				NiOverride.UpdateNodeTransform(ActorRef, true, true, "NPC L Breast")
				NiOverride.UpdateNodeTransform(ActorRef, false, true, "NPC R Breast")
			else
				NiOverride.RemoveNodeTransformScale(ActorRef, true, true, "NPC L Breast", "BeeingFemale")
				NiOverride.RemoveNodeTransformScale(ActorRef, false, true, "NPC L Breast", "BeeingFemale")
				
				NiOverride.RemoveNodeTransformScale(ActorRef, true, true, "NPC R Breast", "BeeingFemale")
				NiOverride.RemoveNodeTransformScale(ActorRef, false, true, "NPC R Breast", "BeeingFemale")
			endif
			
			NiOverride.UpdateNodeTransform(ActorRef, true, true, "NPC L Breast")
			NiOverride.UpdateNodeTransform(ActorRef, false, true, "NPC L Breast")
			NiOverride.UpdateNodeTransform(ActorRef, true, true, "NPC R Breast")
			NiOverride.UpdateNodeTransform(ActorRef, false, true, "NPC R Breast")
		EndIf
		
	EndIf
EndFunction

Function UpdateNodes(Float afAddedBellySize, Float afAddedBreastSize)
	If ActorRef;/!=none/;
		; b3lisario Body Scaling
		If BaseBellySize.Length == 2 && cfg.BellyScale;/==true/;
			If NetImmerse.HasNode(ActorRef, "NPC Belly", True)
				NetImmerse.SetNodeScale(ActorRef, "NPC Belly", afAddedBellySize + BaseBellySize[0], True)
			EndIf
			If NetImmerse.HasNode(ActorRef, "NPC Belly", False)
				NetImmerse.SetNodeScale(ActorRef, "NPC Belly", afAddedBellySize + BaseBellySize[1], False)
			EndIf
			AddedBellySize = afAddedBellySize
		EndIf
		
		If BaseBreastSize.Length == 8 && cfg.BreastScale;/==true/;
			
			If NetImmerse.HasNode(ActorRef, "NPC L Breast", True)
				NetImmerse.SetNodeScale(ActorRef, "NPC L Breast", afAddedBreastSize + BaseBreastSize[0], True)
			EndIf
			If NetImmerse.HasNode(ActorRef, "NPC L Breast", False)
				NetImmerse.SetNodeScale(ActorRef, "NPC L Breast", afAddedBreastSize + BaseBreastSize[1], False)
			EndIf
			
			If NetImmerse.HasNode(ActorRef, "NPC R Breast", True)
				NetImmerse.SetNodeScale(ActorRef, "NPC R Breast", afAddedBreastSize + BaseBreastSize[2], True)
			EndIf
			If NetImmerse.HasNode(ActorRef, "NPC R Breast", False)
				NetImmerse.SetNodeScale(ActorRef, "NPC R Breast", afAddedBreastSize + BaseBreastSize[3], False)
			EndIf
			
			; For Torpedo-Fix
			If NetImmerse.HasNode(ActorRef, "NPC L Breast01", True)
				NetImmerse.SetNodeScale(ActorRef, "NPC L Breast01", afAddedBreastSize + BaseBreastSize[4], True)
			EndIf
			If NetImmerse.HasNode(ActorRef, "NPC L Breast01", False)
				NetImmerse.SetNodeScale(ActorRef, "NPC L Breast01", afAddedBreastSize + BaseBreastSize[5], False)
			EndIf
			
			If NetImmerse.HasNode(ActorRef, "NPC R Breast01", True)
				NetImmerse.SetNodeScale(ActorRef, "NPC R Breast01", afAddedBreastSize + BaseBreastSize[6], True)
			EndIf
			If NetImmerse.HasNode(ActorRef, "NPC R Breast01", False)
				NetImmerse.SetNodeScale(ActorRef, "NPC R Breast01", afAddedBreastSize + BaseBreastSize[7], False)
			EndIf
			AddedBreastSize = afAddedBreastSize
		EndIf
		
		If ( ActorRef.IsOnMount()) ;Tkc (Loverslab): optimization
		else;If (! ActorRef.IsOnMount())
			ActorRef.QueueNiNodeUpdate()
		EndIf
	EndIf
EndFunction

Function UpdateWeight(Float afAddedWeight)
	Float NewWeight = FWUtility.ClampFloat(BaseWeight + afAddedWeight, 0.0, 100.0)
	Float NeckDelta = (ActorRefBase.GetWeight() - NewWeight) / 100
	
	;If NeckDelta && (! ActorRef.IsOnMount())
	If NeckDelta ;Tkc (Loverslab): optimization
	 if ( ActorRef.IsOnMount())
	 else;if (! ActorRef.IsOnMount())
		ActorRefBase.SetWeight(NewWeight)
		ActorRef.UpdateWeight(NeckDelta)
		ActorRef.QueueNiNodeUpdate()
		
		AddedWeight = NewWeight - BaseWeight
	 EndIf
	EndIf
EndFunction

Function ResetBelly()
	int visualScaling = cfg.VisualScaling
	bool hasSLIF = Game.IsPluginInstalled("SexLab Inflation Framework.esp")
	if visualScaling == 4 && !hasSLIF
		visualScaling = 5
	endif

	if visualScaling == 5
		ClearBodyMorphs()
	elseif hasSLIF
		if visualScaling == 4 ; SLIF
			FillHerUpUpdateNotes(0, 0)
		else
			UpdateNodesSLIF(0, 0)
		endIf
	elseif lastTypeOfScaling > 0
		if lastTypeOfScaling < 3
			if lastTypeOfScaling == 1
				UpdateNodes(0, 0)
			else;if lastTypeOfScaling == 2
				UpdateNodes2(0, 0)
			endIf
		elseif lastTypeOfScaling == 3
			UpdateWeight(0)
		elseif lastTypeOfScaling == 5
			ClearBodyMorphs()
		endIf
	endif
EndFunction

function TestScale(float Scale=1.0)
	int visualScaling = cfg.VisualScaling
	bool hasSLIF = Game.IsPluginInstalled("SexLab Inflation Framework.esp")
	if visualScaling == 4 && !hasSLIF
		visualScaling = 5
	endif

	if visualScaling == 5
		UpdateBodyMorphs(Scale * cfg.BellyMaxScale * Manager.ActorSizeScaler(0, ActorRef), Scale * cfg.BreastsMaxScale * Manager.ActorSizeScaler(1, ActorRef))
	elseif hasSLIF
		if visualScaling == 4 ; SLIF
			FillHerUpUpdateNotes(Scale * cfg.BellyMaxScale * Manager.ActorSizeScaler(0, ActorRef), Scale * cfg.BreastsMaxScale * Manager.ActorSizeScaler(1, ActorRef))
		else
			UpdateNodesSLIF(Scale * cfg.BellyMaxScale * Manager.ActorSizeScaler(0, ActorRef), Scale * cfg.BreastsMaxScale * Manager.ActorSizeScaler(1, ActorRef))
		endIf
	Elseif visualScaling > 0
		if visualScaling < 3
			If visualScaling == 1
				if lastTypeOfScaling == 2
					UpdateNodes2(0, 0)
				elseif lastTypeOfScaling == 3
					UpdateWeight(0.0)
				endif
				UpdateNodes(Scale * cfg.BellyMaxScale * Manager.ActorSizeScaler(0, ActorRef), Scale * cfg.BreastsMaxScale * Manager.ActorSizeScaler(1, ActorRef))
			Else;If visualScaling == 2
				if lastTypeOfScaling == 1
					UpdateNodes(0, 0)
				elseif lastTypeOfScaling == 3
					UpdateWeight(0.0)
				endif
				UpdateNodes2(Scale * cfg.BellyMaxScale * Manager.ActorSizeScaler(0, ActorRef), Scale * cfg.BreastsMaxScale * Manager.ActorSizeScaler(1, ActorRef))
			endIf
		Else;If visualScaling == 3
			if lastTypeOfScaling == 1
				UpdateNodes(0, 0)
			elseif lastTypeOfScaling == 2
				UpdateNodes2(0, 0)
			endif
			Float MaxAdditionalWeight = FWUtility.MinFloat(cfg.WeightGainMax, 100 - BaseWeight)
			Float addWeight = (Scale * MaxAdditionalWeight)
			UpdateWeight(addWeight)
		EndIf
	endIf
	Utility.Wait(10)
	Debug.Notification("Reset Belly for "+ActorRef.GetLeveledActorBase().GetName())
	SetBelly(true)
endFunction

Function SetBelly(bool bForce=false)
	float startTime = GameDaysPassed.GetValue()
	;if (currentState<4 || currentState>=20 || System.IsActorPregnantByChaurus(ActorRef)) && bForce==false  ;-->Bane SetBellyTest
	if bForce ;Tkc (Loverslab): optimization
	else;if bForce==false
		if (currentState<4 || currentState>=20 || System.IsActorPregnantByChaurus(ActorRef) || System.IsActorPregnantByEstrusSpider(ActorRef) || System.IsActorPregnantByEstrusDwemer(ActorRef))
			return
		endif
	endif

	int visualScaling = cfg.VisualScaling
	bool hasSLIF = Game.IsPluginInstalled("SexLab Inflation Framework.esp")
	if visualScaling == 4 && !hasSLIF
		visualScaling = 5
	endif

	If (visualScaling > 0)
		Int stateID = currentState
		
		float ScaleBelly = 0.0
		float ScaleBreast = 0.0
		
		; Scale up belly and breasts depending on how far along actor is in her
		; pregnancy
		if stateID > 3
			if stateID < 7
				; Find the list of fathers
				int my_num_men = StorageUtil.FormListCount(ActorRef, "FW.ChildFather")
				float my_Preg1stBellyScale = 0
				float temp_Preg1stBellyScale = 0
				float my_Preg2ndBellyScale = 0
				float temp_Preg2ndBellyScale = 0
				float my_Preg3rdBellyScale = 0
				float temp_Preg3rdBellyScale = 0

				float my_Preg1stBreastsScale = 0
				float temp_Preg1stBreastsScale = 0
				float my_Preg2ndBreastsScale = 0
				float temp_Preg2ndBreastsScale = 0
				float my_Preg3rdBreastsScale = 0
				float temp_Preg3rdBreastsScale = 0

				actor a = none
				race abr = none
				while my_num_men > 0
					my_num_men -= 1
					a = (StorageUtil.FormListGet(ActorRef, "FW.ChildFather", my_num_men) As Actor)
					if a
						abr = a.GetRace()
						
						temp_Preg1stBellyScale = StorageUtil.GetFloatValue(a, "FW.AddOn.Modify_Preg1stBellyScale_by_FatherRace", 0)
						if(temp_Preg1stBellyScale == 0)
							temp_Preg1stBellyScale = StorageUtil.GetFloatValue(abr, "FW.AddOn.Modify_Preg1stBellyScale_by_FatherRace", 0)
						endIf
						
						temp_Preg2ndBellyScale = StorageUtil.GetFloatValue(a, "FW.AddOn.Modify_Preg2ndBellyScale_by_FatherRace", 0)
						if(temp_Preg2ndBellyScale == 0)
							temp_Preg2ndBellyScale = StorageUtil.GetFloatValue(abr, "FW.AddOn.Modify_Preg2ndBellyScale_by_FatherRace", 0)
						endIf

						temp_Preg3rdBellyScale = StorageUtil.GetFloatValue(a, "FW.AddOn.Modify_Preg3rdBellyScale_by_FatherRace", 0)
						if(temp_Preg3rdBellyScale == 0)
							temp_Preg3rdBellyScale = StorageUtil.GetFloatValue(abr, "FW.AddOn.Modify_Preg3rdBellyScale_by_FatherRace", 0)
						endIf

						temp_Preg1stBreastsScale = StorageUtil.GetFloatValue(a, "FW.AddOn.Modify_Preg1stBreastsScale_by_FatherRace", 0)
						if(temp_Preg1stBreastsScale == 0)
							temp_Preg1stBreastsScale = StorageUtil.GetFloatValue(abr, "FW.AddOn.Modify_Preg1stBreastsScale_by_FatherRace", 0)
						endIf

						temp_Preg2ndBreastsScale = StorageUtil.GetFloatValue(a, "FW.AddOn.Modify_Preg2ndBreastsScale_by_FatherRace", 0)
						if(temp_Preg2ndBreastsScale == 0)
							temp_Preg2ndBreastsScale = StorageUtil.GetFloatValue(abr, "FW.AddOn.Modify_Preg2ndBreastsScale_by_FatherRace", 0)
						endIf

						temp_Preg3rdBreastsScale = StorageUtil.GetFloatValue(a, "FW.AddOn.Modify_Preg3rdBreastsScale_by_FatherRace", 0)
						if(temp_Preg3rdBreastsScale == 0)
							temp_Preg3rdBreastsScale = StorageUtil.GetFloatValue(abr, "FW.AddOn.Modify_Preg3rdBreastsScale_by_FatherRace", 0)
						endIf
					endIf

					if(temp_Preg1stBellyScale > my_Preg1stBellyScale)
						my_Preg1stBellyScale = temp_Preg1stBellyScale
					endIf
					if(temp_Preg2ndBellyScale > my_Preg2ndBellyScale)
						my_Preg2ndBellyScale = temp_Preg2ndBellyScale
					endIf
					if(temp_Preg3rdBellyScale > my_Preg3rdBellyScale)
						my_Preg3rdBellyScale = temp_Preg3rdBellyScale
					endIf
					
					if(temp_Preg1stBreastsScale > my_Preg1stBreastsScale)
						my_Preg1stBreastsScale = temp_Preg1stBreastsScale
					endIf
					if(temp_Preg2ndBreastsScale > my_Preg2ndBreastsScale)
						my_Preg2ndBreastsScale = temp_Preg2ndBreastsScale
					endIf
					if(temp_Preg3rdBreastsScale > my_Preg3rdBreastsScale)
						my_Preg3rdBreastsScale = temp_Preg3rdBreastsScale
					endIf
				endWhile
				
				if(my_Preg1stBellyScale <= 0)
					my_Preg1stBellyScale = Manager.ActorPreg1stBellyScale(ActorRef)
				else
					my_Preg1stBellyScale *= Manager.ActorPreg1stBellyScale(ActorRef)
				endIf

				if(my_Preg2ndBellyScale <= 0)
					my_Preg2ndBellyScale = Manager.ActorPreg2ndBellyScale(ActorRef)
				else
					my_Preg2ndBellyScale *= Manager.ActorPreg2ndBellyScale(ActorRef)
				endIf

				if(my_Preg3rdBellyScale <= 0)
					my_Preg3rdBellyScale = Manager.ActorPreg3rdBellyScale(ActorRef)
				else
					my_Preg3rdBellyScale *= Manager.ActorPreg3rdBellyScale(ActorRef)
				endIf

				if(my_Preg1stBreastsScale <= 0)
					my_Preg1stBreastsScale = Manager.ActorPreg1stBreastsScale(ActorRef)
				else
					my_Preg1stBreastsScale *= Manager.ActorPreg1stBreastsScale(ActorRef)
				endIf

				if(my_Preg2ndBreastsScale <= 0)
					my_Preg2ndBreastsScale = Manager.ActorPreg2ndBreastsScale(ActorRef)
				else
					my_Preg2ndBreastsScale *= Manager.ActorPreg2ndBreastsScale(ActorRef)
				endIf

				if(my_Preg3rdBreastsScale <= 0)
					my_Preg3rdBreastsScale = Manager.ActorPreg3rdBreastsScale(ActorRef)
				else
					my_Preg3rdBreastsScale *= Manager.ActorPreg3rdBreastsScale(ActorRef)
				endIf
				
				if stateID < 6
					If stateID == 4
						; Add scale value of current trimester
;						ScaleBelly = System.GetPhaseScale(0, 0) * (CurrentStatePercent / 100)
;						ScaleBreast = System.GetPhaseScale(1, 0) * (CurrentStatePercent / 100)
						ScaleBelly = my_Preg1stBellyScale * (CurrentStatePercent / 100)
						ScaleBreast = my_Preg1stBreastsScale * (CurrentStatePercent / 100)

						FW_log.WriteLog("FWAbilityBeeingFemale - SetBelly - ScaleBelly is " + ScaleBelly + " for actor " + ActorRef.GetDisplayName() + " in phase " + stateID + " at " + CurrentStatePercent + " percent.")
						FW_log.WriteLog("FWAbilityBeeingFemale - SetBelly - ScaleBreast is " + ScaleBreast + " for actor " + ActorRef.GetDisplayName() + " in phase " + stateID + " at " + CurrentStatePercent + " percent.")
					Else;If stateID == 5
;						ScaleBelly = System.GetPhaseScale(0, 0) + (System.GetPhaseScale(0, 1) * (CurrentStatePercent / 100))
;						ScaleBreast = System.GetPhaseScale(1, 0) + (System.GetPhaseScale(1, 1) * (CurrentStatePercent / 100))
						ScaleBelly = my_Preg1stBellyScale + (my_Preg2ndBellyScale * (CurrentStatePercent / 100))
						ScaleBreast = my_Preg1stBreastsScale + (my_Preg2ndBreastsScale * (CurrentStatePercent / 100))

						FW_log.WriteLog("FWAbilityBeeingFemale - SetBelly - ScaleBelly is " + ScaleBelly + " for actor " +  ActorRef.GetDisplayName() + " in phase " + stateID + " at " + CurrentStatePercent + " percent.")
						FW_log.WriteLog("FWAbilityBeeingFemale - SetBelly - ScaleBreast is " + ScaleBreast + " for actor " +  ActorRef.GetDisplayName() + " in phase " + stateID + " at " + CurrentStatePercent + " percent.")
					endIf
				Else;If stateID == 6
;					ScaleBelly = System.GetPhaseScale(0, 0) + System.GetPhaseScale(0, 1) + (System.GetPhaseScale(0, 2) * (CurrentStatePercent / 100))
;					ScaleBreast = System.GetPhaseScale(1, 0) + System.GetPhaseScale(1, 1) + (System.GetPhaseScale(1, 2) * (CurrentStatePercent / 100))
					ScaleBelly = my_Preg1stBellyScale + my_Preg2ndBellyScale + (my_Preg3rdBellyScale * (CurrentStatePercent / 100))
					ScaleBreast = my_Preg1stBreastsScale + my_Preg2ndBreastsScale + (my_Preg3rdBreastsScale * (CurrentStatePercent / 100))

					FW_log.WriteLog("FWAbilityBeeingFemale - SetBelly - ScaleBelly is " + ScaleBelly + " for actor " +  ActorRef.GetDisplayName() + " in phase " + stateID + " at " + CurrentStatePercent + " percent.")
					FW_log.WriteLog("FWAbilityBeeingFemale - SetBelly - ScaleBreast is " + ScaleBreast + " for actor " +  ActorRef.GetDisplayName() + " in phase " + stateID + " at " + CurrentStatePercent + " percent.")
				endIf
			; Set to maximum scale in labor pains phase and later
			Else
				If stateID == 7
					ScaleBelly = 1.0
					ScaleBreast = 1.0
				
				; Scale back belly and breasts over the course of recovery  phase
				ElseIf stateID == 8
					ScaleBelly = FWUtility.MaxFloat(0.0, (33 - CurrentStatePercent) / 100)
					ScaleBreast = FWUtility.MaxFloat(0.0, (100 - CurrentStatePercent) / 100)
				EndIf
			endIf
		endIf
		
		; Scale with number of children
		If NumChilds > 1 && stateID<8
			ScaleBelly *= Math.Pow(1.15, NumChilds - 1) * Manager.ActorSizeScaler(2, ActorRef)
			ScaleBreast *= Math.Pow(1.08, NumChilds - 1) * Manager.ActorSizeScaler(3, ActorRef)
		EndIf
		
		; Race specific scaling
		
		if visualScaling == 5
			UpdateBodyMorphs(ScaleBelly * cfg.BellyMaxScale * Manager.ActorSizeScaler(0, ActorRef), ScaleBreast * cfg.BreastsMaxScale * Manager.ActorSizeScaler(1, ActorRef))
		elseif hasSLIF
			if visualScaling == 4 ; SLIF
				FW_log.WriteLog("FWAbilityBeeingFemale - SetBelly - Current belly scale is " + ScaleBelly * cfg.BellyMaxScale * Manager.ActorSizeScaler(0, ActorRef) + " for actor " +  ActorRef.GetDisplayName() + " in phase " + stateID + " at " + CurrentStatePercent + " percent.")
				FW_log.WriteLog("FWAbilityBeeingFemale - SetBelly - Current breast scale is " + ScaleBreast * cfg.BreastsMaxScale * Manager.ActorSizeScaler(1, ActorRef) + " for actor " +  ActorRef.GetDisplayName() + " in phase " + stateID + " at " + CurrentStatePercent + " percent.")
				FillHerUpUpdateNotes(ScaleBelly * cfg.BellyMaxScale * Manager.ActorSizeScaler(0, ActorRef), ScaleBreast * cfg.BreastsMaxScale * Manager.ActorSizeScaler(1, ActorRef))
			else
				UpdateNodesSLIF(ScaleBelly * cfg.BellyMaxScale * Manager.ActorSizeScaler(0, ActorRef), ScaleBreast * cfg.BreastsMaxScale * Manager.ActorSizeScaler(1, ActorRef))
			endIf
		elseif visualScaling > 0
			if visualScaling < 3
				If visualScaling == 1
					if lastTypeOfScaling == 2
						UpdateNodes2(0, 0)
					elseif lastTypeOfScaling == 3
						UpdateWeight(0.0)
					endif
					UpdateNodes(ScaleBelly * cfg.BellyMaxScale * Manager.ActorSizeScaler(0, ActorRef), ScaleBreast * cfg.BreastsMaxScale * Manager.ActorSizeScaler(1, ActorRef))
				Else;If visualScaling == 2
					if lastTypeOfScaling == 1
						UpdateNodes(0, 0)
					elseif lastTypeOfScaling == 3
						UpdateWeight(0.0)
					endif
					UpdateNodes2(ScaleBelly * cfg.BellyMaxScale * Manager.ActorSizeScaler(0, ActorRef), ScaleBreast * cfg.BreastsMaxScale * Manager.ActorSizeScaler(1, ActorRef))
				endIf
			Else;If visualScaling == 3
				if lastTypeOfScaling == 1
					UpdateNodes(0, 0)
				elseif lastTypeOfScaling == 2
					UpdateNodes2(0, 0)
				endif
				Float MaxAdditionalWeight = FWUtility.MinFloat(cfg.WeightGainMax, 100 - BaseWeight)
				Float addWeight = (ScaleBelly * MaxAdditionalWeight)
				UpdateWeight(addWeight)
			EndIf
		endIf
		
		lastTypeOfScaling = visualScaling
	Else;if lastTypeOfScaling != System.cfg.VisualScaling
		if lastTypeOfScaling == cfg.VisualScaling ;Tkc (Loverslab): optimization
		else;if lastTypeOfScaling != System.cfg.VisualScaling
			ResetBelly()
			lastTypeOfScaling = cfg.VisualScaling
		EndIf
	EndIf
	System.Message("FWAbilityBeeingFemale::SetBelly("+ActorRef.GetLeveledActorBase().GetName()+") " + (Utility.GetCurrentRealTime() - startTime) + " sec", System.MSG_All, System.MSG_Trace)
EndFunction



function castMentrualBlood()
	;if !ActorRef || System.GlobalMenstruating.GetValueInt() != 1
	if ActorRef ;Tkc (Loverslab): optimization
	else;if !ActorRef
		return
	endif
	if GlobalMenstruating.GetValue() As int ;Tkc (Loverslab): optimization
	else;if System.GlobalMenstruating.GetValueInt() != 1
		return
	endif
	if ActorRef.IsEquipped(Sanitary_Napkin_Normal) || ActorRef.IsEquipped(Tampon_Normal)
		; Panty or Tampon is equipped		
		if ActorRef.IsEquipped(Sanitary_Napkin_Normal)
			if IsPlayer;/==true/;
				System.Message( Contents.YourPantys, System.MSG_Low)
				ActorRef.UnequipItem(Sanitary_Napkin_Normal, false, true)
				ActorRef.RemoveItem(Sanitary_Napkin_Normal, 1, true)
				ActorRef.addItem(Sanitary_Napkin_Bloody, 1, true)
				ActorRef.EquipItem(Sanitary_Napkin_Bloody, false, true)
			else
				System.Message( FWUtility.StringReplace( Contents.NPCPantys , "{0}", ActorRef.GetLeveledActorBase().GetName()), System.MSG_Debug)
				ActorRef.UnequipItem(Sanitary_Napkin_Normal, false, true)
				ActorRef.RemoveItem(Sanitary_Napkin_Normal, 1, true)
				ActorRef.addItem(Sanitary_Napkin_Bloody, 1, true)
				ActorRef.EquipItem(Sanitary_Napkin_Bloody, false, true)
				Utility.WaitGameTime(0.5) ; Wait some time till redress another sani napkin
				EquipNapkin()
			endif
		else
			if IsPlayer;/==true/;
				System.Message( Contents.YourTampon, System.MSG_Low)
				ActorRef.UnequipItem(Tampon_Normal, false, true)
				ActorRef.RemoveItem(Tampon_Normal, 1, true)
				ActorRef.addItem(Tampon_Bloody, 1, true)
				ActorRef.EquipItem(Tampon_Bloody, false, true)
			else
				System.Message( FWUtility.StringReplace( Contents.NPCTampon , "{0}", ActorRef.GetLeveledActorBase().GetName()), System.MSG_Debug)
				ActorRef.UnequipItem(Tampon_Normal, false, true)
				ActorRef.RemoveItem(Tampon_Normal, 1, true)
				ActorRef.addItem(Tampon_Bloody, 1, true)
				ActorRef.EquipItem(Tampon_Bloody, false, true)
				Utility.WaitGameTime(0.5) ; Wait some time till redress another sani napkin
				EquipTampon()
			endif
		endif
	else
		; Cast blood
		if (CurrentStatePercent > 40.0 && CurrentStatePercent < 60.0)
			ActorRef.DispelSpell(Effect_VaginalBloodLow)			
			System.ActorAddSpellOpt(ActorRef,Effect_VaginalBloodHigh, false, true, ShowMsg=cfg.Messages<4) ;Tkc (Loverslab): added ShowMsg parameter to not show messages when Innmersion or None Messages mode
		else
			ActorRef.DispelSpell(Effect_VaginalBloodHigh)	
			System.ActorAddSpellOpt(ActorRef,Effect_VaginalBloodLow, false, true, ShowMsg=cfg.Messages<4) ;Tkc (Loverslab): added ShowMsg parameter to not show messages when Innmersion or None Messages mode
		endif
	endif
endFunction

function EquipNapkin()
	if !ShouldAutoEquipHygiene()
		return
	endif
	if ActorRef.IsEquipped(Tampon_Normal) || ActorRef.IsEquipped(Tampon_Bloody)
		return
	endif
	if GlobalMenstruating.GetValue() As int; == 1 ;Tkc (Loverslab): optimization
		;if ActorRef.GetItemCount(System.Sanitary_Napkin_Normal)>1 && ActorRef.IsEquipped(System.Sanitary_Napkin_Normal)==false
		if ActorRef.GetItemCount(Sanitary_Napkin_Normal)>1 ;Tkc (Loverslab): optimization
		 if ActorRef.IsEquipped(Sanitary_Napkin_Normal)
		 else;if ActorRef.IsEquipped(System.Sanitary_Napkin_Normal)==false
			form ax = ActorRef.GetWornForm(Sanitary_Napkin_Normal.GetSlotMask())
			if ax;/!=none/;
				if ax != Sanitary_Napkin_Normal && ax != Sanitary_Napkin_Bloody && ax != Tampon_Normal && ax != Tampon_Bloody
					return
				endif
				ActorRef.UnequipItem(ax)
			endif
			; Equip a FRESH one (was the Bloody variant, which the actor does
			; not own at this point - EquipItem silently failed and NPCs never
			; wore their hygiene items). The flow roll soils it naturally later.
			ActorRef.EquipItem(Sanitary_Napkin_Normal, false, true)
		 endif
		endif
	endif
endfunction

function EquipTampon()
	if !ShouldAutoEquipHygiene()
		return
	endif
	if ActorRef.IsEquipped(Sanitary_Napkin_Normal) || ActorRef.IsEquipped(Sanitary_Napkin_Bloody)
		return
	endif
	if GlobalMenstruating.GetValue() As int; == 1 ;Tkc (Loverslab): optimization
		;if ActorRef.GetItemCount(System.Tampon_Normal)>1 && ActorRef.IsEquipped(System.Tampon_Normal)==false
		if ActorRef.GetItemCount(Tampon_Normal)>1 ;Tkc (Loverslab): optimization
		 if ActorRef.IsEquipped(Tampon_Normal);
		 else;if ActorRef.IsEquipped(System.Tampon_Normal)==false
			form ax = ActorRef.GetWornForm(Tampon_Normal.GetSlotMask())
			if ax;/!=none/;
				if ax != Sanitary_Napkin_Normal && ax != Sanitary_Napkin_Bloody && ax != Tampon_Normal && ax != Tampon_Bloody
					return
				endif
				ActorRef.UnequipItem(ax)
			endif
			; Fresh tampon, not the unowned Bloody variant (see EquipNapkin)
			ActorRef.EquipItem(Tampon_Normal, false, true)
		 endif
		endif
	endif
endfunction

bool function ShouldAutoEquipHygiene()
	if !ActorRef
		return false
	endif
	if Game.GetModByName("SexLab.esm") != 255
		Faction sexlabAnimating = Game.GetFormFromFile(0x00E50F, "SexLab.esm") as Faction
		if sexlabAnimating && ActorRef.IsInFaction(sexlabAnimating)
			return false
		endif
	endif
	if Game.GetModByName("OStim.esp") != 255
		Faction ostimExcitement = Game.GetFormFromFile(0x000D93, "OStim.esp") as Faction
		if ostimExcitement && ActorRef.IsInFaction(ostimExcitement)
			return false
		endif
	endif
	return true
endFunction

float SleepingStart
Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
	SleepingStart=GameDaysPassed.GetValue()
	parent.OnSleepStart(afSleepStartTime, afDesiredSleepEndTime)
endEvent
Event OnSleepStop(bool abInterrupted)
	float SleepDur
	if SleepingStart>0.0
		SleepDur = GameDaysPassed.GetValue() - SleepingStart
		Controller.HealBaby(ActorRef,SleepDur*1.3)
	endif
	SleepingStart=0.0
	parent.OnSleepStop(abInterrupted)
endEvent
float SitStart
Event OnSit(ObjectReference akFurniture)
	SitStart=GameDaysPassed.GetValue()
endEvent
Event OnGetUp(ObjectReference akFurniture)
	float SitDur
	if SitStart>0.0
		SitDur = GameDaysPassed.GetValue() - SitStart
		Controller.HealBaby(ActorRef,SitDur*0.5)
	endif
	SitStart=0.0
endEvent

Event OnDeath(Actor akKiller)
	parent.OnDeath(akKiller)
	;if ActorRef==PlayerRef
	if IsPlayer ;Tkc (Loverslab): optimization. IsPlayer is true if ActorRef==PlayerRef
		Controller.DamageBaby(ActorRef,92)
	else
		FWSaveLoad.Delete(ActorRef)
		; Death leaves the ability behind (no OnEffectFinish fires on death), so strip
		; it here - this also triggers OnEffectFinish's ResetBelly/onExitState cleanup.
		ActorRef.RemoveSpell(BeeingFemaleSpell)
	endif
endEvent





;--------------------------------------------------------------------------------
; StateFunctions
;--------------------------------------------------------------------------------
function onEnterState()
endFunction
function onExitState()
endFunction
function onUpdateFunction()
endFunction
function onPotionFunction(potion Item)
endFunction
function onCastSpellFunction(spell SpellID)
endFunction

;--------------------------------------------------------------------------------
; State - Follicular
;--------------------------------------------------------------------------------
state Follicular_State
	function onEnterState()
		Manager.removeCME(ActorRef) ; Remove All effects
		;if ActorRef==PlayerRef
		if IsPlayer ;Tkc (Loverslab): optimization. IsPlayer is true if ActorRef==PlayerRef
			Controller.setAutoFlag(ActorRef)
		endIf
		Manager.CastCME(ActorRef,0,cfg.PMSEffects)
		bHasPMS=false
		if IsPlayer ;Tkc (Loverslab): show widged when state was changed
			StateWidget.showTimed(ActorRef)
		endif
	endFunction
		
	function onUpdateFunction()
		actor a = none
		race abr = none
		int c = StorageUtil.FormListCount(ActorRef, "FW.SpermName")
		int my_Impreg_Any = 0
		float my_Impreg_Chance = 0
		
		bool bool_NotPregnant = true
		while((c > 0) && bool_NotPregnant)
			c -= 1
			a = (StorageUtil.FormListGet(ActorRef, "FW.SpermName", c) As Actor)
			if a
				my_Impreg_Any = StorageUtil.GetIntValue(a, "FW.AddOn.Allow_Impregnation_For_Any_Period", -1)
				if(my_Impreg_Any <= 0)
					abr = a.GetRace()
					if abr
						my_Impreg_Any = StorageUtil.GetIntValue(abr, "FW.AddOn.Allow_Impregnation_For_Any_Period", -1)
						if(my_Impreg_Any <= 0)
							my_Impreg_Any = StorageUtil.GetIntValue(none, "FW.AddOn.Global_Allow_Impregnation_For_Any_Period", -1)
							if(my_Impreg_Any > 0)
								my_Impreg_Chance = StorageUtil.GetFloatValue(none, "FW.AddOn.Global_Sperm_Impregnation_Prob_For_Any_Period", 0)
							endIf
						else
							my_Impreg_Chance = StorageUtil.GetFloatValue(abr, "FW.AddOn.Sperm_Impregnation_Prob_For_Any_Period", 0)
						endIf
					endIf
				else
					my_Impreg_Chance = StorageUtil.GetFloatValue(a, "FW.AddOn.Sperm_Impregnation_Prob_For_Any_Period", 0)
				endIf

				if(my_Impreg_Any > 0)
					; Check for Pregnancy
					Float rnd = Utility.RandomFloat(0, 99)
					if rnd < my_Impreg_Chance
						; Actor is pregnant!
						if Controller.MyActiveSpermImpregnationTimedForAnyPeriod(ActorRef);/==true/;
							bool_NotPregnant = false
							FWUtility.ActorRemoveSpell(ActorRef, Effect_Vorwehen)
							Manager.RemoveCME(ActorRef, 0) ; Remove Follicular Effects
							bHasPMS = false
							changeState(4)
						endif
					endIf
				endIf
			endIf
		endwhile
	EndFunction
		
	function onExitState()
		;ActorRef.removeSpell(Effect_Vorwehen)
		FWUtility.ActorRemoveSpell(ActorRef, Effect_Vorwehen)
		Manager.RemoveCME(ActorRef,0) ; Remove Follicular Effects
		bHasPMS=false
	endfunction
endState

;--------------------------------------------------------------------------------
; State - Ovulation
;--------------------------------------------------------------------------------
state Ovulation_State

	function onEnterState()
		Manager.removeCME(ActorRef,0) ; Remove Follicular Effects
		System.ActorAddSpellOpt(ActorRef,Effect_Mittelschmerz, ShowMsg=cfg.Messages<4) ;Tkc (Loverslab): added ShowMsg parameter to not show messages when Innmersion or None Messages mode
		Manager.CastCME(ActorRef,1,cfg.PMSEffects)
		bHasPMS=false
		Controller.StartOvulationArousal(ActorRef)
		if IsPlayer ;Tkc (Loverslab): show widged when state was changed
			StateWidget.showTimed(ActorRef)
		endif
	endfunction
	
	function onUpdateFunction()
		if CurrentStatePercent > 40
			FWUtility.ActorRemoveSpell(ActorRef,Effect_Mittelschmerz)
		else
			System.ActorAddSpellOpt(ActorRef,Effect_Mittelschmerz, ShowMsg=cfg.Messages<4) ;Tkc (Loverslab): added ShowMsg parameter to not show messages when Innmersion or None Messages mode
		endif

		actor a = none
		race abr = none
		int c = StorageUtil.FormListCount(ActorRef, "FW.SpermName")
		int my_Impreg_Any = 0
		float my_Impreg_Chance = 0
		float my_Impreg_boost = 0
		float my_Fertility = Controller.getFertility(ActorRef)

		bool bool_NotPregnant = true
		while((c > 0) && bool_NotPregnant)
			c -= 1
			a = (StorageUtil.FormListGet(ActorRef, "FW.SpermName", c) As Actor)
			if a
				abr = a.GetRace()
				
				my_Impreg_boost = StorageUtil.GetFloatValue(a, "FW.AddOn.Sperm_Impregnation_Boost", 0)
				if(my_Impreg_boost == 0)
					my_Impreg_boost = StorageUtil.GetFloatValue(abr, "FW.AddOn.Sperm_Impregnation_Boost", 0)
					if(my_Impreg_boost == 0)
						my_Impreg_boost = StorageUtil.GetFloatValue(none, "FW.AddOn.Global_Sperm_Impregnation_Boost", 0)
					endIf
				endIf

				my_Impreg_Any = StorageUtil.GetIntValue(a, "FW.AddOn.Allow_Impregnation_For_Any_Period", -1)
				if(my_Impreg_Any <= 0)
					my_Impreg_Any = StorageUtil.GetIntValue(abr, "FW.AddOn.Allow_Impregnation_For_Any_Period", -1)
					if(my_Impreg_Any <= 0)
						my_Impreg_Any = StorageUtil.GetIntValue(none, "FW.AddOn.Global_Allow_Impregnation_For_Any_Period", -1)
						if(my_Impreg_Any > 0)
							my_Impreg_Chance = StorageUtil.GetFloatValue(none, "FW.AddOn.Global_Sperm_Impregnation_Prob_For_Any_Period", 0)
						endIf
					else
						my_Impreg_Chance = StorageUtil.GetFloatValue(abr, "FW.AddOn.Sperm_Impregnation_Prob_For_Any_Period", 0)
					endIf
				else
					my_Impreg_Chance = StorageUtil.GetFloatValue(a, "FW.AddOn.Sperm_Impregnation_Prob_For_Any_Period", 0)
				endIf

				if CurrentStatePercent >= 50
					; Check for Pregnancy
					int rnd = Utility.RandomInt(0, 15)
					if rnd < (7 + my_Impreg_boost + my_Fertility)
						; Actor is pregnant!
						if Controller.ActiveSpermImpregnation(ActorRef);/==true/;
							bool_NotPregnant = false
							FWUtility.ActorRemoveSpell(ActorRef, Effect_Mittelschmerz)
							Manager.removeCME(ActorRef, 1)
							bHasPMS = false
							changeState(4)
						endif
					endIf	
				else
					if(my_Impreg_Any > 0)								
						; Check for Pregnancy
						Float rnd = Utility.RandomFloat(0, 99)
						if rnd < my_Impreg_Chance
							; Actor is pregnant!
							if Controller.MyActiveSpermImpregnationTimedForAnyPeriod(ActorRef);/==true/;
								bool_NotPregnant = false
								FWUtility.ActorRemoveSpell(ActorRef, Effect_Mittelschmerz)
								Manager.removeCME(ActorRef, 1)
								bHasPMS = false
								changeState(4)
							endIf
						endIf
					endIf
				endIf
			endIf
		endwhile

		;if CurrentStatePercent >= 50
			; Check for Pregnancy
			;int rnd = Utility.RandomInt(0,15)
			;if rnd<7
				; Actor is pregnant!
				;if Controller.ActiveSpermImpregnation(ActorRef);/==true/;
					;FWUtility.ActorRemoveSpell(ActorRef,Effect_Mittelschmerz)
					;changeState(4)
				;endif
			;endIf
		;endif
	endfunction
	
	function onExitState()
		; Make sure Mittelschmerz was removed
		FWUtility.ActorRemoveSpell(ActorRef,Effect_Mittelschmerz)
		Manager.removeCME(ActorRef,1)
		bHasPMS=false
		Controller.StopOvulationArousal(ActorRef)
	endfunction
endState

;--------------------------------------------------------------------------------
; State - Luteal
;--------------------------------------------------------------------------------
state Luteal_State
	function onUpdateFunction()
		if(System.IsActorPregnantByChaurus(ActorRef) || System.IsActorPregnantByEstrusSpider(ActorRef) || System.IsActorPregnantByEstrusDwemer(ActorRef))
		else
			actor a = none
			race abr = none
			int c = StorageUtil.FormListCount(ActorRef, "FW.SpermName")
			int my_Impreg_Any = 0
			float my_Impreg_Chance = 0
			float my_Impreg_boost = 0
			float my_Fertility = Controller.getFertility(ActorRef)

			bool bool_NotPregnant = true
			while((c > 0) && bool_NotPregnant)
				c -= 1
				a = (StorageUtil.FormListGet(ActorRef, "FW.SpermName", c) As Actor)
				if a
					abr = a.GetRace()
					
					my_Impreg_boost = StorageUtil.GetFloatValue(a, "FW.AddOn.Sperm_Impregnation_Boost", 0)
					if(my_Impreg_boost == 0)
						my_Impreg_boost = StorageUtil.GetFloatValue(abr, "FW.AddOn.Sperm_Impregnation_Boost", 0)
						if(my_Impreg_boost == 0)
							my_Impreg_boost = StorageUtil.GetFloatValue(none, "FW.AddOn.Global_Sperm_Impregnation_Boost", 0)
						endIf
					endIf

					my_Impreg_Any = StorageUtil.GetIntValue(a, "FW.AddOn.Allow_Impregnation_For_Any_Period", -1)
					if(my_Impreg_Any <= 0)
						my_Impreg_Any = StorageUtil.GetIntValue(abr, "FW.AddOn.Allow_Impregnation_For_Any_Period", -1)
						if(my_Impreg_Any <= 0)
							my_Impreg_Any = StorageUtil.GetIntValue(none, "FW.AddOn.Global_Allow_Impregnation_For_Any_Period", -1)
							if(my_Impreg_Any > 0)
								my_Impreg_Chance = StorageUtil.GetFloatValue(none, "FW.AddOn.Global_Sperm_Impregnation_Prob_For_Any_Period", 0)
							endIf
						else
							my_Impreg_Chance = StorageUtil.GetFloatValue(abr, "FW.AddOn.Sperm_Impregnation_Prob_For_Any_Period", 0)
						endIf
					else
						my_Impreg_Chance = StorageUtil.GetFloatValue(a, "FW.AddOn.Sperm_Impregnation_Prob_For_Any_Period", 0)
					endIf

					if CurrentStatePercent < 65
						; Check for Pregnancy
						Float rnd = Utility.RandomFloat(0, 99)
						float chance = System.LutealImpregnationTime(CurrentStatePercent)
						if rnd < (chance + my_Impreg_boost + my_Fertility)
							if Controller.ActiveSpermImpregnation(ActorRef);/==true/;
								; Actor is pregnant!
								bool_NotPregnant = false
								Manager.RemoveCME(ActorRef,2) ; Lutheal Effects
								Manager.removeCME(ActorRef,3) ; PMS Effects
								bHasPMS=false
								changeState(4)
								return
							endif
						endIf
					else
						if(my_Impreg_Any > 0)
							; Check for Pregnancy
							Float rnd = Utility.RandomFloat(0, 99)
							if rnd < my_Impreg_Chance
								; Actor is pregnant!
								if Controller.MyActiveSpermImpregnationTimedForAnyPeriod(ActorRef);/==true/;
									bool_NotPregnant = false
									Manager.RemoveCME(ActorRef,2) ; Lutheal Effects
									Manager.removeCME(ActorRef,3) ; PMS Effects
									bHasPMS=false
									changeState(4)
								endIf
							endIf
						endIf
					endIf
				endIf
			endwhile
		endIf
	
		;if CurrentStatePercent < 65
			; Check for Pregnancy
			; Simulate FH Hormones
			;Float rnd = Utility.RandomFloat(0,99)
			;float chance = System.LutealImpregnationTime(CurrentStatePercent)
			;if chance > rnd
			;if rnd < chance
				;if Controller.ActiveSpermImpregnation(ActorRef);/==true/;
					; Actor is pregnant!
					;Manager.removeCME(ActorRef,3) ; PMS Effects
					;changeState(4)
					;return
				;endif
			;endIf
		;else
		if CurrentStatePercent > 75
			; Check for PMS
			;if bHasPMS==false && System.Controller.canBecomePMS(ActorRef);/==true/;
			if bHasPMS ;Tkc (Loverslab): optimization
			else;if bHasPMS==false
				if Controller.canBecomePMS(ActorRef)
					System.Message("Cast PMS for "+ActorRef.GetLeveledActorBase().GetName(), System.MSG_Debug )
					Manager.castCME(ActorRef,3,cfg.PMSEffects)
					Controller.StartPMSArousalDebuff(ActorRef)
					bHasPMS=true
				endIf
			endIf

			if(cfg.NPCHaveItems)
				; Check for Tampons
				;if !isPlayer && ActorRef.GetItemCount(System.Tampon_Normal)<=2  ;***Edit by Bane
				if isPlayer ;Tkc (Loverslab): optimization
				else;if !isPlayer
					if ActorRef.GetItemCount(Tampon_Normal)<=2
						ActorRef.AddItem(Tampon_Normal,6)
					endif
				endif
			endIf
		endif
	endFunction
	
	function onEnterState()
		Manager.removeCME(ActorRef,1)
		Manager.CastCME(ActorRef,2,cfg.PMSEffects)
		bHasPMS=false
		if CurrentStatePercent > 75
			; Check for PMS
			;if bHasPMS==false && System.Controller.canBecomePMS(ActorRef);/==true/;
			if bHasPMS ;Tkc (Loverslab): optimization
			else;if bHasPMS==false
				if Controller.canBecomePMS(ActorRef)
					bHasPMS=true
					System.Message("Cast PMS for "+ActorRef.GetLeveledActorBase().GetName(), System.MSG_Debug )
					Manager.castCME(ActorRef,3,cfg.PMSEffects)
					Controller.StartPMSArousalDebuff(ActorRef)
					System.Message("Casted", System.MSG_Debug )
				endIf
			endIf
		endif
		if IsPlayer ;Tkc (Loverslab): show widged when state was changed
			StateWidget.showTimed(ActorRef)
		endif
	endFunction
	
	function onExitState()
		; Remove PMS
		Manager.RemoveCME(ActorRef,2) ; Lutheal Effects
		Manager.removeCME(ActorRef,3) ; PMS Effects
		Controller.StopPMSArousalDebuff(ActorRef)
		bHasPMS=false
	endFunction
endState

;--------------------------------------------------------------------------------
; State - Menstruation
;--------------------------------------------------------------------------------
state Menstruation_State
	function onEnterState()
		EquipNapkin()
		FWUtility.ActorRemoveSpell(ActorRef,Effect_Nachwehen)
		System.ActorAddSpellOpt(ActorRef,Effect_MenstruationCramps, ShowMsg=cfg.Messages<4) ;Tkc (Loverslab): added ShowMsg parameter to not show messages when Innmersion or None Messages mode
		Manager.removeCME(ActorRef,3)
		Manager.removeCME(ActorRef,2)
		Controller.StopPMSArousalDebuff(ActorRef)
		Manager.CastCME(ActorRef,4,cfg.PMSEffects)
		bHasPMS=false
		if IsPlayer ;Tkc (Loverslab): show widged when state was changed
			StateWidget.showTimed(ActorRef)
		endif
	endfunction
	
	function onUpdateFunction()
		actor a = none
		race abr = none
		int c = StorageUtil.FormListCount(ActorRef, "FW.SpermName")
		int my_Impreg_Any = 0
		float my_Impreg_Chance = 0

		bool bool_NotPregnant = true
		while((c > 0) && bool_NotPregnant)
			c -= 1
			a = (StorageUtil.FormListGet(ActorRef, "FW.SpermName", c) As Actor)
			if a
				my_Impreg_Any = StorageUtil.GetIntValue(a, "FW.AddOn.Allow_Impregnation_For_Any_Period", -1)
				if(my_Impreg_Any <= 0)
					abr = a.GetRace()
					if abr
						my_Impreg_Any = StorageUtil.GetIntValue(abr, "FW.AddOn.Allow_Impregnation_For_Any_Period", -1)
						if(my_Impreg_Any <= 0)
							my_Impreg_Any = StorageUtil.GetIntValue(none, "FW.AddOn.Global_Allow_Impregnation_For_Any_Period", -1)
							if(my_Impreg_Any > 0)
								my_Impreg_Chance = StorageUtil.GetFloatValue(none, "FW.AddOn.Global_Sperm_Impregnation_Prob_For_Any_Period", 0)
							endIf
						else
							my_Impreg_Chance = StorageUtil.GetFloatValue(abr, "FW.AddOn.Sperm_Impregnation_Prob_For_Any_Period", 0)
						endIf
					endIf
				else
					my_Impreg_Chance = StorageUtil.GetFloatValue(a, "FW.AddOn.Sperm_Impregnation_Prob_For_Any_Period", 0)
				endIf

				if(my_Impreg_Any > 0)	
					; Check for Pregnancy
					Float rnd = Utility.RandomFloat(0, 99)
					if rnd < my_Impreg_Chance
						; Actor is pregnant!
						if Controller.MyActiveSpermImpregnationTimedForAnyPeriod(ActorRef);/==true/;
							bool_NotPregnant = false
							FWUtility.ActorRemoveSpell(ActorRef,Effect_MenstruationCramps)
							ActorRef.DispelSpell(Effect_VaginalBloodLow)					
							ActorRef.DispelSpell(Effect_VaginalBloodHigh)	
							Manager.RemoveCME(ActorRef)
							changeState(4)
						endIf
					endIf
				endIf
			endIf
		endwhile


		; NPC-only: the player manages hygiene manually (the panty widget is
		; the prompt) - auto-equipping would consume the player's items and
		; could re-equip a soiled one she just took off
		if IsPlayer
		else
			EquipNapkin()
		endif
		Float fStateFlowRisk = CurrentStatePercent
		If fStateFlowRisk > 50.0
			fStateFlowRisk = 50.0 - (fStateFlowRisk - 50.0)
		EndIf
;		if Utility.RandomFloat(1,100) < fStateFlowRisk
		if(Utility.RandomFloat(1, 100) <= fStateFlowRisk)
			castMentrualBlood()
		endif

		if(cfg.NPCHaveItems)
			;if !isPlayer && ActorRef.GetItemCount(System.Tampon_Normal)<=2 ;***Edit by Bane
			if isPlayer ;Tkc (Loverslab): optimization
			else;if !isPlayer
				if ActorRef.GetItemCount(Tampon_Normal)<=2
					ActorRef.AddItem(Tampon_Normal,6)
				endif
				EquipNapkin()
			endif
		endIf
	endfunction
	
	function onExitState()
		FWUtility.ActorRemoveSpell(ActorRef,Effect_MenstruationCramps)
		ActorRef.DispelSpell(Effect_VaginalBloodLow)					
		ActorRef.DispelSpell(Effect_VaginalBloodHigh)	
		Controller.setAutoFlag(ActorRef)
		Manager.RemoveCME(ActorRef)
	endfunction

endState

;--------------------------------------------------------------------------------
; State 1. Trimester
;--------------------------------------------------------------------------------
state PregnancyFirst_State
	Event OnHitEx(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
		;if (abPowerAttack || abSneakAttack || abBashAttack) && !abHitBlocked
		if (abPowerAttack || abSneakAttack || abBashAttack)
			Controller.DamageBaby(ActorRef, Utility.RandomFloat(2,7))
		endIf
	endEvent
	
	function onEnterState()
		; Defensive sweep: each cycle state's onExitState only clears its own
		; CME slot and its own hardcoded spell, so any effect that leaked past
		; a prior transition would otherwise persist into pregnancy and remain
		; visible in Active Effects.
		FWUtility.ActorRemoveSpell(ActorRef, Effect_Vorwehen)
		FWUtility.ActorRemoveSpell(ActorRef, Effect_Mittelschmerz)
		FWUtility.ActorRemoveSpell(ActorRef, Effect_MenstruationCramps)
		FWUtility.ActorRemoveSpell(ActorRef, Effect_Nachwehen)
		ActorRef.DispelSpell(Effect_VaginalBloodLow)
		ActorRef.DispelSpell(Effect_VaginalBloodHigh)
		ActorRef.DispelSpell(Effect_VaginalBloodBig)
		Controller.StopOvulationArousal(ActorRef)
		Controller.StopPMSArousalDebuff(ActorRef)
		Manager.RemoveCME(ActorRef)
		Manager.CastCME(ActorRef,5,cfg.PMSEffects)
		bHasPMS = false
		if IsPlayer ;Tkc (Loverslab): show widged when state was changed
			StateWidget.showTimed(ActorRef)
		endif
	endFunction

	function onExitState()
		Manager.RemoveCME(ActorRef,5)
	endFunction
	
	function onPotionFunction(potion p)
		int c = p.GetNumEffects()
		while c>0
			c-=1
			if p.GetNthEffectMagicEffect(c).HasKeywordString("MagicAlchRestoreHealth")
				Controller.HealBaby(ActorRef, p.GetNthEffectMagnitude(c) / 5)
			endif
			if p.GetNthEffectMagicEffect(c).HasKeywordString("MagicAlchHarmful")
				Controller.DamageBaby(ActorRef, p.GetNthEffectMagnitude(c) / 10)
			endif
		endwhile
	endFunction
	
	function onUpdateFunction()
		bool my_BabyNTR = cfg.AllowNTRbaby
		if(my_BabyNTR)
			FW_log.WriteLog("FWAbilityBeeingFemale - PregnancyFirst_State : Baby NTR is enabled!")

			actor a = none
			race abr = none
			int my_baby_NTR = 0
			float my_baby_NTR_Chance = 0
			
			int num_babies = 0
			int num_babies_orig = StorageUtil.FormListCount(ActorRef, "FW.ChildFather")

			actor father_NTR_defense = none
			race father_NTR_defense_race = none
			int my_baby_NTR_defense = 0
			float NTR_defense_chance = 0
			
			int c = StorageUtil.FormListCount(ActorRef, "FW.SpermName")
			while(c > 0)
				c -= 1
				a = (StorageUtil.FormListGet(ActorRef, "FW.SpermName", c) As Actor)
				if a
					my_baby_NTR = StorageUtil.GetIntValue(a, "FW.AddOn.Allow_NTR_baby", -1)
					if(my_baby_NTR <= 0)
						abr = a.GetRace()
					
						my_baby_NTR = StorageUtil.GetIntValue(abr, "FW.AddOn.Allow_NTR_baby", -1)
						if(my_baby_NTR > 0)
							my_baby_NTR_Chance = StorageUtil.GetFloatValue(abr, "FW.AddOn.Sperm_NTR_baby_Prob", 0)
						endIf
					else
						my_baby_NTR_Chance = StorageUtil.GetFloatValue(a, "FW.AddOn.Sperm_NTR_baby_Prob", 0)
					endIf
					
					if(my_baby_NTR > 0)
						num_babies = num_babies_orig
						while(num_babies > 0)
							num_babies -= 1
							
							father_NTR_defense = (StorageUtil.FormListGet(ActorRef, "FW.ChildFather", num_babies) As Actor)
							if(a == father_NTR_defense)
							else
								NTR_defense_chance = 0
								my_baby_NTR_defense = StorageUtil.GetIntValue(father_NTR_defense, "FW.AddOn.Allow_NTR_baby", -1)
								if(my_baby_NTR_defense <= 0)
									father_NTR_defense_race = father_NTR_defense.GetRace()
									my_baby_NTR_defense = StorageUtil.GetIntValue(father_NTR_defense_race, "FW.AddOn.Allow_NTR_baby", -1)
									if(my_baby_NTR_defense > 0)
										NTR_defense_chance = StorageUtil.GetFloatValue(father_NTR_defense_race, "FW.AddOn.Sperm_NTR_baby_Prob", 0)
									endIf
								else
									NTR_defense_chance = StorageUtil.GetFloatValue(father_NTR_defense, "FW.AddOn.Sperm_NTR_baby_Prob", 0)
								endIf
								
								; Check for Pregnancy
								Float rnd = Utility.RandomFloat(0, 99)
								if(rnd < (my_baby_NTR_Chance - NTR_defense_chance))
									; Baby will be replaced!
									FW_log.WriteLog("FWAbilityBeeingFemale - PregnancyFirst_State : For female " + ActorRef + " , the actor " + a + " replaced the previous " + num_babies + "th father = " + father_NTR_defense)
									StorageUtil.FormListSet(ActorRef, "FW.ChildFather", num_babies, a)
								endIf
							endIf
						endwhile
					endIf
				endIf
			endwhile
		endIf

		checkAbortus()
		float GT = GameDaysPassed.GetValue()
		int HealAmount = Math.Floor( GT - LastBabyHealing)
		if HealAmount >0
			Controller.HealBaby(ActorRef, HealAmount )
			LastBabyHealing=GT
		endif
	endFunction
endState

;--------------------------------------------------------------------------------
; State 2. Trimester
;--------------------------------------------------------------------------------
state PregnancySecond_State
	Event OnHitEx(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
		;if (abPowerAttack || abSneakAttack || abBashAttack) && !abHitBlocked
		if (abPowerAttack || abSneakAttack || abBashAttack)
			Controller.DamageBaby(ActorRef, Utility.RandomFloat(0,3))
		endIf
	endEvent
	
	function onEnterState()
		Manager.RemoveCME(ActorRef,5)
		Manager.CastCME(ActorRef,6,cfg.PMSEffects)
		if IsPlayer ;Tkc (Loverslab): show widged when state was changed
			StateWidget.showTimed(ActorRef)
		endif
	endFunction
	
	function onExitState()
		Manager.RemoveCME(ActorRef,6)
	endFunction
	
	function onPotionFunction(potion p)
		int c = p.GetNumEffects()
		while c>0
			c-=1
			if p.GetNthEffectMagicEffect(c).HasKeywordString("MagicAlchRestoreHealth")
				Controller.HealBaby(ActorRef, p.GetNthEffectMagnitude(c) / 10)
			endif
			if p.GetNthEffectMagicEffect(c).HasKeywordString("MagicAlchHarmful")
				Controller.DamageBaby(ActorRef, p.GetNthEffectMagnitude(c) / 10)
			endif
		endwhile
	endFunction
	
	function onUpdateFunction()
		bool my_BabyNTR = cfg.AllowNTRbaby
		if(my_BabyNTR)
			FW_log.WriteLog("FWAbilityBeeingFemale - PregnancySecond_State : Baby NTR is enabled!")

			actor a = none
			race abr = none
			int my_baby_NTR = 0
			float my_baby_NTR_Chance = 0
			
			int num_babies = 0
			int num_babies_orig = StorageUtil.FormListCount(ActorRef, "FW.ChildFather")

			actor father_NTR_defense = none
			race father_NTR_defense_race = none
			int my_baby_NTR_defense = 0
			float NTR_defense_chance = 0
			
			int c = StorageUtil.FormListCount(ActorRef, "FW.SpermName")
			while(c > 0)
				c -= 1
				a = (StorageUtil.FormListGet(ActorRef, "FW.SpermName", c) As Actor)
				if a
					my_baby_NTR = StorageUtil.GetIntValue(a, "FW.AddOn.Allow_NTR_baby", -1)
					if(my_baby_NTR <= 0)
						abr = a.GetRace()
					
						my_baby_NTR = StorageUtil.GetIntValue(abr, "FW.AddOn.Allow_NTR_baby", -1)
						if(my_baby_NTR > 0)
							my_baby_NTR_Chance = StorageUtil.GetFloatValue(abr, "FW.AddOn.Sperm_NTR_baby_Prob", 0)
						endIf
					else
						my_baby_NTR_Chance = StorageUtil.GetFloatValue(a, "FW.AddOn.Sperm_NTR_baby_Prob", 0)
					endIf
					
					if(my_baby_NTR > 0)
						num_babies = num_babies_orig
						while(num_babies > 0)
							num_babies -= 1
							
							father_NTR_defense = (StorageUtil.FormListGet(ActorRef, "FW.ChildFather", num_babies) As Actor)
							if(a == father_NTR_defense)
							else
								NTR_defense_chance = 0
								my_baby_NTR_defense = StorageUtil.GetIntValue(father_NTR_defense, "FW.AddOn.Allow_NTR_baby", -1)
								if(my_baby_NTR_defense <= 0)
									father_NTR_defense_race = father_NTR_defense.GetRace()
									my_baby_NTR_defense = StorageUtil.GetIntValue(father_NTR_defense_race, "FW.AddOn.Allow_NTR_baby", -1)
									if(my_baby_NTR_defense > 0)
										NTR_defense_chance = StorageUtil.GetFloatValue(father_NTR_defense_race, "FW.AddOn.Sperm_NTR_baby_Prob", 0)
									endIf
								else
									NTR_defense_chance = StorageUtil.GetFloatValue(father_NTR_defense, "FW.AddOn.Sperm_NTR_baby_Prob", 0)
								endIf
								
								; Check for Pregnancy
								Float rnd = Utility.RandomFloat(0, 99)
								if(rnd < (my_baby_NTR_Chance - NTR_defense_chance))
									; Baby will be replaced!
									FW_log.WriteLog("FWAbilityBeeingFemale - PregnancySecond_State : For female " + ActorRef + " , the actor " + a + " replaced the previous " + num_babies + "th father = " + father_NTR_defense)
									StorageUtil.FormListSet(ActorRef, "FW.ChildFather", num_babies, a)
								endIf
							endIf
						endwhile
					endIf
				endIf
			endwhile
		endIf

		checkAbortus()
		float GT = GameDaysPassed.GetValue()
		int HealAmount = Math.Floor( GT - LastBabyHealing) * 3
		if HealAmount >0
			Controller.HealBaby(ActorRef, HealAmount )
			LastBabyHealing=GT
		endif
	endFunction
endState

;--------------------------------------------------------------------------------
; State 3. Trimester
;--------------------------------------------------------------------------------
state PregnancyThird_State
	function onUpdateFunction()
		bool my_BabyNTR = cfg.AllowNTRbaby
		if(my_BabyNTR)
			FW_log.WriteLog("FWAbilityBeeingFemale - PregnancyThird_State : Baby NTR is enabled!")

			actor a = none
			race abr = none
			int my_baby_NTR = 0
			float my_baby_NTR_Chance = 0
			
			int num_babies = 0
			int num_babies_orig = StorageUtil.FormListCount(ActorRef, "FW.ChildFather")

			actor father_NTR_defense = none
			race father_NTR_defense_race = none
			int my_baby_NTR_defense = 0
			float NTR_defense_chance = 0
			
			int c = StorageUtil.FormListCount(ActorRef, "FW.SpermName")
			while(c > 0)
				c -= 1
				a = (StorageUtil.FormListGet(ActorRef, "FW.SpermName", c) As Actor)
				if a
					my_baby_NTR = StorageUtil.GetIntValue(a, "FW.AddOn.Allow_NTR_baby", -1)
					if(my_baby_NTR <= 0)
						abr = a.GetRace()
					
						my_baby_NTR = StorageUtil.GetIntValue(abr, "FW.AddOn.Allow_NTR_baby", -1)
						if(my_baby_NTR > 0)
							my_baby_NTR_Chance = StorageUtil.GetFloatValue(abr, "FW.AddOn.Sperm_NTR_baby_Prob", 0)
						endIf
					else
						my_baby_NTR_Chance = StorageUtil.GetFloatValue(a, "FW.AddOn.Sperm_NTR_baby_Prob", 0)
					endIf
					
					if(my_baby_NTR > 0)
						num_babies = num_babies_orig
						while(num_babies > 0)
							num_babies -= 1
							
							father_NTR_defense = (StorageUtil.FormListGet(ActorRef, "FW.ChildFather", num_babies) As Actor)
							if(a == father_NTR_defense)
							else
								NTR_defense_chance = 0
								my_baby_NTR_defense = StorageUtil.GetIntValue(father_NTR_defense, "FW.AddOn.Allow_NTR_baby", -1)
								if(my_baby_NTR_defense <= 0)
									father_NTR_defense_race = father_NTR_defense.GetRace()
									my_baby_NTR_defense = StorageUtil.GetIntValue(father_NTR_defense_race, "FW.AddOn.Allow_NTR_baby", -1)
									if(my_baby_NTR_defense > 0)
										NTR_defense_chance = StorageUtil.GetFloatValue(father_NTR_defense_race, "FW.AddOn.Sperm_NTR_baby_Prob", 0)
									endIf
								else
									NTR_defense_chance = StorageUtil.GetFloatValue(father_NTR_defense, "FW.AddOn.Sperm_NTR_baby_Prob", 0)
								endIf
								
								; Check for Pregnancy
								Float rnd = Utility.RandomFloat(0, 99)
								if(rnd < (my_baby_NTR_Chance - NTR_defense_chance))
									; Baby will be replaced!
									FW_log.WriteLog("FWAbilityBeeingFemale - PregnancyThird_State : For female " + ActorRef + " , the actor " + a + " replaced the previous " + num_babies + "th father = " + father_NTR_defense)
									StorageUtil.FormListSet(ActorRef, "FW.ChildFather", num_babies, a)
								endIf
							endIf
						endwhile
					endIf
				endIf
			endwhile
		endIf


		if CurrentStatePercent > 90
			; Vorwehen
			System.ActorAddSpellOpt(ActorRef,Effect_Vorwehen, ShowMsg=cfg.Messages<4) ;Tkc (Loverslab): added ShowMsg parameter to not show messages when Innmersion or None Messages mode
		elseif CurrentStatePercent > 75 && Utility.RandomInt(0,10)>4
			; Breast milk
			int rnd= Utility.RandomInt(0,10)
			if rnd<6
				System.Message("Breast Milk1 ("+ActorRef.GetLeveledActorBase().GetName()+")",System.MSG_All)
				System.ActorAddSpellOpt(ActorRef,Effect_BreastMilk1,false,true, ShowMsg=cfg.Messages<4) ;Tkc (Loverslab): added ShowMsg parameter to not show messages when Innmersion or None Messages mode
			elseif rnd<10
				System.Message("Breast Milk2 ("+ActorRef.GetLeveledActorBase().GetName()+")",System.MSG_All)
				System.ActorAddSpellOpt(ActorRef,Effect_BreastMilk2,false,true, ShowMsg=cfg.Messages<4) ;Tkc (Loverslab): added ShowMsg parameter to not show messages when Innmersion or None Messages mode
			else
				System.Message("Breast Milk3 ("+ActorRef.GetLeveledActorBase().GetName()+")",System.MSG_All)
				System.ActorAddSpellOpt(ActorRef,Effect_BreastMilk3,false,true, ShowMsg=cfg.Messages<4) ;Tkc (Loverslab): added ShowMsg parameter to not show messages when Innmersion or None Messages mode
			endif
		endIf
		checkAbortus()
		
		; Baby hits - let the controler vibrate
;		if Utility.RandomInt(0, 100) > 60
		if(Utility.RandomInt(1, 100) > 60)
			float intensity = Utility.RandomFloat(0.5, 1.0)
			game.shakeController(intensity, intensity, Utility.RandomFloat(0.2, 1.0))
		endif
		
		float GT = GameDaysPassed.GetValue()
		int HealAmount = Math.Floor( GT - LastBabyHealing) * 5
		if HealAmount >0
			Controller.HealBaby(ActorRef, HealAmount )
			LastBabyHealing=GT
		endif
	endFunction
	
	function onEnterState()
		Manager.RemoveCME(ActorRef,6)
		Manager.CastCME(ActorRef,7,cfg.PMSEffects)
		if IsPlayer ;Tkc (Loverslab): show widged when state was changed
			StateWidget.showTimed(ActorRef)
		endif
	endFunction
	
	Event OnHitEx(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
		;if (abPowerAttack || abSneakAttack || abBashAttack) && !abHitBlocked
		if (abPowerAttack || abSneakAttack || abBashAttack)
			Controller.DamageBaby(ActorRef, Utility.RandomFloat(0,2))
		endIf
	endEvent
	
	function onPotionFunction(potion p)
		int c = p.GetNumEffects()
		while c>0
			c-=1
			if p.GetNthEffectMagicEffect(c).HasKeywordString("MagicAlchRestoreHealth")
				Controller.HealBaby(ActorRef, p.GetNthEffectMagnitude(c) / 10)
			endif
			if p.GetNthEffectMagicEffect(c).HasKeywordString("MagicAlchHarmful")
				Controller.DamageBaby(ActorRef, p.GetNthEffectMagnitude(c) / 10)
			endif
		endwhile
	endFunction
	
	function onExitState()
		; Remove Vorwehen
		FWUtility.ActorRemoveSpell(ActorRef,Effect_Vorwehen)
		Manager.RemoveCME(ActorRef,7)
	endFunction
endState

;--------------------------------------------------------------------------------
; State Labor Pains
;--------------------------------------------------------------------------------

Bool bWatersBroken
Bool bAlreadyGaveBirth = false

state LaborPains_State

	function onEnterState()
		bWatersBroken = false
		bAlreadyGaveBirth = false
		int laborEvent = ModEvent.Create("BeeingFemaleLabor")
		if laborEvent
			actor Father0 = none 
			actor Father1 = none
			actor Father2 = none
			int childCount = StorageUtil.GetIntValue(ActorRef,"FW.NumChilds",0)
			if StorageUtil.FormListCount(ActorRef, "FW.ChildFather") > 0
				Father0 = StorageUtil.FormListGet(ActorRef,"FW.ChildFather", 0) as actor
			endif
			if StorageUtil.FormListCount(ActorRef, "FW.ChildFather") > 1
				Father1 = StorageUtil.FormListGet(ActorRef,"FW.ChildFather", 1) as actor
			endif
			if StorageUtil.FormListCount(ActorRef, "FW.ChildFather") > 2
				Father2 = StorageUtil.FormListGet(ActorRef,"FW.ChildFather", 2) as actor
			endif
			ModEvent.PushForm(laborEvent, ActorRef)
			ModEvent.PushInt(laborEvent, childCount)
			ModEvent.PushForm(laborEvent, Father0)
			ModEvent.PushForm(laborEvent, Father1)
			ModEvent.PushForm(laborEvent, Father2)
			ModEvent.Send(laborEvent)
		endif
		Manager.RemoveCME(ActorRef,7)
		Manager.CastCME(ActorRef,8,cfg.PMSEffects)
		if CurrentStatePercent >=50 && ActorRef.HasSpell(Effect_Presswehen)==false
			FWUtility.ActorRemoveSpell(ActorRef,Effect_Eroeffnungswehen)
			System.ActorAddSpellOpt(ActorRef,Effect_Presswehen, ShowMsg=cfg.Messages<4) ;Tkc (Loverslab): added ShowMsg parameter to not show messages when Innmersion or None Messages mode
			bAlreadyGaveBirth = true
			Controller.GiveBirth(ActorRef)
			return
		else;if CurrentStatePercent < 50 && !bWatersBroken
		  if CurrentStatePercent < 50 ;Tkc (Loverslab): optimization
		  if bWatersBroken
		  else;if !bWatersBroken
			bWatersBroken = true
			System.ActorAddSpellOpt(ActorRef,Effect_Eroeffnungswehen, ShowMsg=cfg.Messages<4) ;Tkc (Loverslab): added ShowMsg parameter to not show messages when Innmersion or None Messages mode
			;if ActorRef==PlayerRef
			if IsPlayer ;Tkc (Loverslab): optimization. IsPlayer is true if ActorRef==PlayerRef
				FWUtility.LockPlayer()
				System.Message(Contents.YourPregnantWaterBreaks,System.MSG_Immersive)
			else
				System.Message( FWUtility.StringReplace(Contents.NPCPregnantWaterBreaks,"{0}",ActorRef.GetLeveledActorBase().GetName()) ,System.MSG_Low)
			endif
			FWUtility.EquipItem(ActorRef,AmnioticFluid)
			Utility.Wait(8)
			FWUtility.UnequipItem(ActorRef,AmnioticFluid)
			;if ActorRef==PlayerRef
			if IsPlayer ;Tkc (Loverslab): optimization. IsPlayer is true if ActorRef==PlayerRef
				FWUtility.UnlockPlayer()
			endif
		  endif
		  endif
		endif
		if IsPlayer ;Tkc (Loverslab): show widged when state was changed
			StateWidget.showTimed(ActorRef)
		endif
	endFunction
	
	function onUpdateFunction()
		;FW_log.WriteLog(CurrentStatePercent+"% at Labor Pains for "+ActorRef.GetLeveledActorBase().GetName())
		if CurrentStatePercent >=50 && ActorRef.HasSpell(Effect_Presswehen)==false
			FWUtility.ActorRemoveSpell(ActorRef,Effect_Eroeffnungswehen)
			System.ActorAddSpellOpt(ActorRef,Effect_Presswehen, ShowMsg=cfg.Messages<4) ;Tkc (Loverslab): added ShowMsg parameter to not show messages when Innmersion or None Messages mode
			bAlreadyGaveBirth = true
			Controller.GiveBirth(ActorRef)
			return
		else;if CurrentStatePercent<50 && ActorRef.HasSpell(System.Effect_Eroeffnungswehen)==false
			if CurrentStatePercent<50 ;Tkc (Loverslab): optimization
				if ActorRef.HasSpell(Effect_Eroeffnungswehen)
				else;if ActorRef.HasSpell(System.Effect_Eroeffnungswehen)==false
					System.ActorAddSpellOpt(ActorRef,Effect_Eroeffnungswehen, ShowMsg=cfg.Messages<4) ;Tkc (Loverslab): added ShowMsg parameter to not show messages when Innmersion or None Messages mode
				endif
			endif
		endif
	endFunction
	
	function onExitState()
		if(bAlreadyGaveBirth)
			bAlreadyGaveBirth = false
		else
			FWUtility.ActorRemoveSpell(ActorRef,Effect_Eroeffnungswehen)
			System.ActorAddSpellOpt(ActorRef,Effect_Presswehen, ShowMsg=cfg.Messages<4) ;Tkc (Loverslab): added ShowMsg parameter to not show messages when Innmersion or None Messages mode
			Controller.GiveBirth(ActorRef)
		endIf

		FWUtility.ActorRemoveSpell(ActorRef,Effect_Eroeffnungswehen)
		FWUtility.ActorRemoveSpell(ActorRef,Effect_Presswehen)
		Manager.RemoveCME(ActorRef,8)
		; Defensive cleanup in case birth was interrupted.
		System.DHLPResume(ActorRef)
		StorageUtil.FormListRemove(none,"FW.GivingBirth", ActorRef)
		;System.InstantBornChilds(ActorRef)
	endFunction
endState

;--------------------------------------------------------------------------------
; State - Replanish
;--------------------------------------------------------------------------------
state Replanish_State
	function onEnterState()
		Manager.RemoveCME(ActorRef) ; Remove all Effects
		Manager.CastCME(ActorRef,9,cfg.PMSEffects)
		SetBelly()
		
		equipChild()
		
		;if ActorRef.GetItemCount(System.ContraceptionLow)<=1 && IsPlayer==false
		if IsPlayer ;Tkc (Loverslab): optimization
		else;if IsPlayer==false
			if ActorRef.GetItemCount(ContraceptionLow)<=1
				ActorRef.AddItem(ContraceptionLow, 10, false)
			endif
		endif
		if CurrentStatePercent < 4
			System.ActorAddSpellOpt(ActorRef,Effect_Nachwehen, ShowMsg=cfg.Messages<4) ;Tkc (Loverslab): added ShowMsg parameter to not show messages when Innmersion or None Messages mode
		endif
		if IsPlayer ;Tkc (Loverslab): show widged when state was changed
			StateWidget.showTimed(ActorRef)
		endif
	endFunction
	
	function onUpdateFunction()
		if(System.IsActorPregnantByChaurus(ActorRef) || System.IsActorPregnantByEstrusSpider(ActorRef) || System.IsActorPregnantByEstrusDwemer(ActorRef))
		else
			actor a = none
			race abr = none
			int c = StorageUtil.FormListCount(ActorRef, "FW.SpermName")
			int my_Impreg_Any = 0
			float my_Impreg_Chance = 0

			bool bool_NotPregnant = true
			while((c > 0) && bool_NotPregnant)
				c -= 1
				a = (StorageUtil.FormListGet(ActorRef, "FW.SpermName", c) As Actor)
				if a
					my_Impreg_Any = StorageUtil.GetIntValue(a, "FW.AddOn.Allow_Impregnation_For_Any_Period", -1)
					if(my_Impreg_Any <= 0)
						abr = a.GetRace()
						if abr
							my_Impreg_Any = StorageUtil.GetIntValue(abr, "FW.AddOn.Allow_Impregnation_For_Any_Period", -1)
							if(my_Impreg_Any <= 0)
								my_Impreg_Any = StorageUtil.GetIntValue(none, "FW.AddOn.Global_Allow_Impregnation_For_Any_Period", -1)
								if(my_Impreg_Any > 0)
									my_Impreg_Chance = StorageUtil.GetFloatValue(none, "FW.AddOn.Global_Sperm_Impregnation_Prob_For_Any_Period", 0)
								endIf
							else
								my_Impreg_Chance = StorageUtil.GetFloatValue(abr, "FW.AddOn.Sperm_Impregnation_Prob_For_Any_Period", 0)
							endIf
						endIf
					else
						my_Impreg_Chance = StorageUtil.GetFloatValue(a, "FW.AddOn.Sperm_Impregnation_Prob_For_Any_Period", 0)
					endIf

					if(my_Impreg_Any > 0)	
						; Check for Pregnancy
						Float rnd = Utility.RandomFloat(0, 99)
						if rnd < my_Impreg_Chance
							; Actor is pregnant!
							if Controller.MyActiveSpermImpregnationTimedForAnyPeriod(ActorRef);/==true/;
								bool_NotPregnant = false
								FWUtility.ActorRemoveSpell(ActorRef, Effect_Nachwehen)
								FWUtility.ActorRemoveSpell(ActorRef, FeverSpell)
								FWUtility.ActorRemoveSpell(ActorRef, InfectionSpell)
								changeState(4)
							endIf
						endIf
					endIf
				endIf
			endwhile
		endIf

		if CurrentStatePercent >=4
			FWUtility.ActorRemoveSpell(ActorRef,Effect_Nachwehen)
		else
			System.ActorAddSpellOpt(ActorRef,Effect_Nachwehen, ShowMsg=cfg.Messages<4) ;Tkc (Loverslab): added ShowMsg parameter to not show messages when Innmersion or None Messages mode
		endif
		if CurrentStatePercent >= 2 && ActorRef.HasSpell(FeverSpell)
			FWUtility.ActorRemoveSpell(ActorRef, FeverSpell)
		endif
		if CurrentStatePercent < 20 && Utility.RandomInt(0,10)>4
			; Breast milk
			int rnd= Utility.RandomInt(0,10)
			if rnd < 10
				if rnd<6
					System.Message("Breast Milk1 ("+ActorRef.GetLeveledActorBase().GetName()+")",System.MSG_All)
					System.ActorAddSpellOpt(ActorRef,Effect_BreastMilk1,false,true, ShowMsg=cfg.Messages<4) ;Tkc (Loverslab): added ShowMsg parameter to not show messages when Innmersion or None Messages mode
				else;if rnd<10
					System.Message("Breast Milk2 ("+ActorRef.GetLeveledActorBase().GetName()+")",System.MSG_All)
					System.ActorAddSpellOpt(ActorRef,Effect_BreastMilk2,false,true, ShowMsg=cfg.Messages<4) ;Tkc (Loverslab): added ShowMsg parameter to not show messages when Innmersion or None Messages mode
				endIf
			else
				System.Message("Breast Milk3 ("+ActorRef.GetLeveledActorBase().GetName()+")",System.MSG_All)
				System.ActorAddSpellOpt(ActorRef,Effect_BreastMilk3,false,true, ShowMsg=cfg.Messages<4) ;Tkc (Loverslab): added ShowMsg parameter to not show messages when Innmersion or None Messages mode
			endif
		endIf
	endFunction
	
	function onExitState()
		; System.Manager.removeCME(ActorRef) ; CME Effects will always be removed when Follicel Phase beginns
		FWUtility.ActorRemoveSpell(ActorRef,Effect_Nachwehen)
		FWUtility.ActorRemoveSpell(ActorRef,FeverSpell)
		FWUtility.ActorRemoveSpell(ActorRef,InfectionSpell)
		ResetBelly()
		Controller.setAutoFlag(ActorRef)
	endFunction

endState

;--------------------------------------------------------------------------------
; State - Pregnant by unknown Mod
;--------------------------------------------------------------------------------
state PregnantUnknown_State
	function SetBelly(bool bForce=false)
	endFunction
endState

;--------------------------------------------------------------------------------
; State - Pregnant by Chaurus
;--------------------------------------------------------------------------------
state PregnantChaurus_State

	; THANK YOU CORUM FOR THE FIX!
	; A lot of respect to figure out how FWController and FWSystem works without having a guide!
	
	Event OnBeginState()
		if currentState > 3
			if currentState < 6
				if (currentState == 4)
					castAbortus(3,true)
				else;if (currentState == 5)
					castAbortus(4,true)
				endIf
			else
				if currentState < 9
					if currentState < 8
					;if (currentState == 6 || currentState == 7)
						castAbortus(5,true)
					endIf
				else
					changeState(2)
				endIf
			endIf
		Else;if currentState != 2 && currentState != 8
			if currentState == 2 ;Tkc (Loverslab): optimization
			Else;if currentState != 2
				;if currentState == 8
				;Else;if currentState != 8
					changeState(2)
				;EndIf
			EndIf
		EndIf
	EndEvent

	function OnUpdateFunction()
		;No action if still Pregnant by Chaurus, otherwise resume BFStates
		If System.IsActorPregnantByChaurus(ActorRef) ;Tkc (Loverslab): optimization
		else;If !System.IsActorPregnantByChaurus(ActorRef)
			ResetBelly()
			Controller.Pause(ActorRef,false)
			changeState(3)
			Controller.ChangeState(ActorRef,3) ;Ensure Controller and FWAbilityBeeingFemale are in a consistent state
		EndIf
	EndFunction

	; Bane --> On Update is now only needed by the player for triggering any Baby events via the parent.Onupdate() function
	event OnUpdate()
		if IsPlayer ;Tkc (Loverslab): added check because still was error here from female npc
			parent.OnUpdate()
			Self.RegisterForSingleUpdate(5)
		endif
	endEvent

endState


;--------------------------------------------------------------------------------
; State - Pregnant by EstrusSpider
;--------------------------------------------------------------------------------
state PregnantEstrusSpider_State

	Event OnBeginState()
		if currentState > 3
			if currentState < 6
				if (currentState == 4)
					castAbortus(3,true)
				else;if (currentState == 5)
					castAbortus(4,true)
				endIf
			else
				if currentState < 9
					if currentState < 8
					;if (currentState == 6 || currentState == 7)
						castAbortus(5,true)
					endIf
				else
					changeState(2)
				endIf
			endIf
		Else;if currentState != 2 && currentState != 8
			if currentState == 2 ;Tkc (Loverslab): optimization
			Else
				changeState(2)
			EndIf
		EndIf
	EndEvent

	function OnUpdateFunction()
		;No action if still Pregnant by EstrusSpider, otherwise resume BFStates
		If System.IsActorPregnantByEstrusSpider(ActorRef) ;Tkc (Loverslab): optimization
		else
			ResetBelly()
			Controller.Pause(ActorRef,false)
			changeState(3)
			Controller.ChangeState(ActorRef,3) ;Ensure Controller and FWAbilityBeeingFemale are in a consistent state
		EndIf
	EndFunction

	; Bane --> On Update is now only needed by the player for triggering any Baby events via the parent.Onupdate() function
	event OnUpdate()
		if IsPlayer ;Tkc (Loverslab): added check because still was error here from female npc
			parent.OnUpdate()
			Self.RegisterForSingleUpdate(5)
		endif
	endEvent

endState


;--------------------------------------------------------------------------------
; State - Pregnant by EstrusDwemer
;--------------------------------------------------------------------------------
state PregnantEstrusDwemer_State

	Event OnBeginState()
		if currentState > 3
			if currentState < 6
				if (currentState == 4)
					castAbortus(3,true)
				else;if (currentState == 5)
					castAbortus(4,true)
				endIf
			else
				if currentState < 9
					if currentState < 8
					;if (currentState == 6 || currentState == 7)
						castAbortus(5,true)
					endIf
				else
					changeState(2)
				endIf
			endIf
		Else;if currentState != 2 && currentState != 8
			if currentState == 2 ;Tkc (Loverslab): optimization
			Else
				changeState(2)
			EndIf
		EndIf
	EndEvent

	function OnUpdateFunction()
		;No action if still Pregnant by EstrusDwemer, otherwise resume BFStates
		If System.IsActorPregnantByEstrusDwemer(ActorRef) ;Tkc (Loverslab): optimization
		else
			ResetBelly()
			Controller.Pause(ActorRef,false)
			changeState(3)
			Controller.ChangeState(ActorRef,3) ;Ensure Controller and FWAbilityBeeingFemale are in a consistent state
		EndIf
	EndFunction

	; Bane --> On Update is now only needed by the player for triggering any Baby events via the parent.Onupdate() function
	event OnUpdate()
		if IsPlayer ;Tkc (Loverslab): added check because still was error here from female npc
			parent.OnUpdate()
			Self.RegisterForSingleUpdate(5)
		endif
	endEvent

endState


;OnMagicEffectApply Event moved to seperate script FWAbilityBFOnMagicEffectApply by Bane Master 03/07/2019

;bool ProcessingMagicEffect

; Event received when a magic affect is being applied to this object
;Event OnMagicEffectApply(ObjectReference akCaster, MagicEffect akEffect)
;	If ProcessingMagicEffect;spamguard ;Tkc (Loverslab): optimization
;	else;If !ProcessingMagicEffect
;		ProcessingMagicEffect = true
;		
;		System.Manager.OnMagicEffectApply(ActorRef,akCaster, akEffect)
;		
;		ProcessingMagicEffect = false
;	Endif
;endEvent

; 07 jule 2019 Tkc (Loverslab) optimizations:  Game.GetPlayer() replaced by PlayerRef. Other changes marked with "Tkc (Loverslab)" comment
