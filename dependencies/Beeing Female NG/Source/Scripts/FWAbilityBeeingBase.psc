Scriptname FWAbilityBeeingBase extends ActiveMagicEffect

FWSystem property System auto

Actor property ActorRef auto hidden
ActorBase property ActorRefBase auto hidden

bool property IsPlayer auto hidden
bool property IsFollower auto hidden

bool property bInitSpell=false auto hidden
bool property bInit=false auto hidden

Actor AbilityBaseActor

bool IsCreature = false
bool IsSpouse = false
bool IsFollower = false

bool bIsWearingBaby = false
spell BabyCry
spell BabyFear
spell BabyTalk
spell BabyDrink
spell BabyHappy
spell BabyLaugh
spell BabyAmuse
spell BabyGiggle
spell BabyHiccup
spell BabySupprised
FormList ItemListHappy
FormList ItemListFear
FormList ItemListSupprised


float aPosX
float aPosY
float aPosZ
float lastMoveTime

Keyword Property BabyKeyword Auto
Actor Property PlayerRef Auto
Faction property PlayerMarriedFaction Auto
FWSystemConfig property cfg Auto
Keyword Property ActorTypeCreature Auto
FWAddOnManager property Manager auto
FWTextContents property Contents auto
race[] property MountableRace auto
FWController property Controller auto

import PO3_SKSEFunctions
import PO3_Events_Alias
import PO3_Events_AME

Event OnInit()
	bInit=true
endEvent

Event OnEffectStart(Actor target, Actor caster)
	IsCreature = target.GetRace().HasKeyword(ActorTypeCreature)
	IsSpouse = target.IsInFaction(PlayerMarriedFaction)
	PO3_Events_AME.RegisterForHitEventEx(self, aiBlockFilter = 0)
endEvent

Event OnEffectFinish(Actor target, Actor caster)
	PO3_Events_AME.UnregisterForAllHitEventsEx(self)
endEvent

Event OnDeath(Actor akKiller)
	FWChildActor ca = akKiller as FWChildActor
	if ca
		ca.AddExp(ActorRef.GetLevel() * 2)
	endif
EndEvent

float lastTimeGaveExp=0.0
float lastTimeBabySound=0.0
Event OnHitEx(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	FWChildActor ca = akAggressor as FWChildActor
	float t = Utility.GetCurrentRealTime()
	if ca
		if t>lastTimeGaveExp+3
			if abPowerAttack || abSneakAttack || abBashAttack
				ca.AddExp(ActorRef.GetLevel() / 5)
				lastTimeGaveExp = t
			else
				ca.AddExp(ActorRef.GetLevel() / 15)
				lastTimeGaveExp = t
			endif
		endif
	endif
	
	if IsPlayer && bIsWearingBaby && cfg.ChildrenMayCry && t>lastTimeBabySound+3
		PlayBabySound_OnHit()
		lastTimeBabySound = t
	endif
EndEvent

Event OnActivate(ObjectReference akActionRef)
	equipChild()
	if ActorRef && MountableRace.find(ActorRef.GetRace())>=0
		int c = StorageUtil.FormListCount(none,"FW.Babys")
		while c > 0
			c-=1
			FWChildActor ca = StorageUtil.FormListGet(none, "FW.Babys", c) as FWChildActor
			if ca;/!=none/;
				if ca.GetFurnitureReference();/!=none/;
					if ca.GetFurnitureReference() == ActorRef
						ca.Dismount()
						c = 0
					endif
				endif
			endif
		endWhile
	endif
EndEvent


bool bSexPartnerOnSleep = false
actor aSexPartnerOnSleep
bool bSexPartnerOnSleepCh = false
; Received when the player sleeps. Start and desired end time are in game time days (after registering)
Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
	PlayBabySound()
	bSexPartnerOnSleepCh = Utility.RandomFloat(0,99) < cfg.ImpregnatePlayerChance
	if IsPlayer ;Tkc (Loverslab): optimization
	 if bSexPartnerOnSleepCh
	  if cfg.RelevantPlayer
		bSexPartnerOnSleep = false
		aSexPartnerOnSleep=none
		int radius = 320 ;200
		if cfg.ImpregnatePlayerAmbient
			radius = 2300 ;1900
		endif
		;actor p = Game.GetPlayer() ;Tkc (Loverslab): optimization
		findSleepPartner(radius)
		
		if PlayerRef.GetLeveledActorBase().GetSex()==1 || (aSexPartnerOnSleep && aSexPartnerOnSleep.GetLeveledActorBase().GetSex()==1)
			aSexPartnerOnSleep = Manager.OnSleepSexStart(PlayerRef,aSexPartnerOnSleep)
		endif
	  endif
	 endif
	endif
endEvent

; Received when the player stops sleeping - whether naturally or interrupted (after registering)
Event OnSleepStop(bool abInterrupted)
	if IsPlayer && bSexPartnerOnSleepCh && cfg.RelevantPlayer
		int radius = 320 ;200
		if cfg.ImpregnatePlayerAmbient
			radius = 2400 ;1900
		endif
		;actor p = Game.GetPlayer() ;Tkc (Loverslab): optimization
		;if bSexPartnerOnSleep==false || aSexPartnerOnSleep==none
		if bSexPartnerOnSleep ;Tkc (Loverslab): optimization
		else;if bSexPartnerOnSleep==false
		if aSexPartnerOnSleep
		else;aSexPartnerOnSleep==none
			findSleepPartner(radius)
		endif
		endif
		
		if bSexPartnerOnSleep && aSexPartnerOnSleep;/!=none/; && cfg.ImpregnatePlayerSleep
			; Raise Event first
			int psex = PlayerRef.GetLeveledActorBase().GetSex() ;Tkc (Loverslab): optimization
			int asex = aSexPartnerOnSleep.GetLeveledActorBase().GetSex() ;Tkc (Loverslab): optimization
			if psex==1 || asex==1
				aSexPartnerOnSleep = Manager.OnSleepSexStop(PlayerRef,aSexPartnerOnSleep)
			endif
			
			; Check aSexPartnerOnSleep again - it may has changed during the AddOn Manager
			if aSexPartnerOnSleep;/!=none/;
				; Check if Player is Female
				if psex==1
					Controller.AddSperm(PlayerRef, aSexPartnerOnSleep)
					System.Message( FWUtility.StringReplace( Contents.NPCCameInsideYou , "{0}",aSexPartnerOnSleep.GetLeveledActorBase().GetName()), System.MSG_Immersive)
				endif
			
				; Check if Target is female (no elseif!, so F/F pregnancy can be raised)
				if asex==1
					Controller.AddSperm(aSexPartnerOnSleep, PlayerRef)
					System.Message( FWUtility.StringReplace( Contents.YouCameInsideNPC , "{0}",aSexPartnerOnSleep.GetLeveledActorBase().GetName()), System.MSG_Immersive)
				endif
			endif
		endif
	endif
	if cfg.ChildrenMayCry && IsPlayer;/==true/;
		PlayBabySound_SleepStop()
	endif
endEvent

int cBabyHiccup=0
float nextUpdate
event OnUpdate()
	if IsPlayer
	
		if ActorRef.X > aPosX+20 || ActorRef.X < aPosX - 20 || ActorRef.Y > aPosY+20 || ActorRef.Y < aPosY - 20 || ActorRef.Z > aPosZ+20 || ActorRef.Z < aPosZ - 20
			aPosX=ActorRef.X
			aPosY=ActorRef.Y
			aPosZ=ActorRef.Z
			lastMoveTime=Utility.GetCurrentRealTime()
		endif		
	
	if bIsWearingBaby;/==true/; && cfg.ChildrenMayCry;/==true/; ;/&& IsPlayer==true/; ;Tkc (Loverslab): optimization, baby actions moved inside overal IsPlayer here and identical condition commented
		if cBabyHiccup>0
			PlayBabySound_Hiccup()
			cBabyHiccup-=1
		elseif nextUpdate < Utility.GetCurrentRealTime()
			
			; Check again if the actor is wearing a baby
			bool bFound=false
			int itmCount = ActorRef.GetNumItems()
			while itmCount>0
				itmCount-=1
				form f = ActorRef.GetNthForm(itmCount)
				if f.HasKeyword(BabyKeyword) || f.GetName()=="Baby"
					itmCount=0
					bFound=true
				endif
			endWhile
			
			if bFound ;Tkc (Loverslab): optimization
			else;if bFound==false
				bIsWearingBaby=false
				return
			endif
		
			if ;/IsPlayer &&/; Utility.GetCurrentRealTime() - lastMoveTime> 30
				int rnd=Utility.RandomInt(0,20)
				if rnd>4
					if rnd>7
						if rnd>9
							if rnd>12
								if rnd>14
									if rnd>17
										PlayBabySound(BabyCry, true)
									else;if rnd>14
										PlayBabySound(BabyFear, true)
									endIf
								else;if rnd>12
									cBabyHiccup=Utility.RandomInt(2,8)
								endIf
							else;if rnd>9
								PlayBabySound(BabyHappy, true)
							endIf
						else;if rnd>7
							PlayBabySound(BabyGiggle, true)
						endIf
					else;if rnd>4
						PlayBabySound(BabyAmuse, true)
					endIf
				else
					PlayBabySound(BabyTalk, true)
				endif
				nextUpdate = Utility.GetCurrentRealTime()+Utility.RandomFloat(8,20)
			elseif CheckNoice_Weather()
				nextUpdate = Utility.GetCurrentRealTime()+Utility.RandomFloat(10,90)
			elseif CheckNoice_HappyList()
				nextUpdate = Utility.GetCurrentRealTime()+Utility.RandomFloat(8,55)
			elseif CheckNoice_ListSupprised()
				nextUpdate = Utility.GetCurrentRealTime()+Utility.RandomFloat(8,65)
			elseif CheckNoice_FearList()
				nextUpdate = Utility.GetCurrentRealTime()+Utility.RandomFloat(5,120)
			endif
		endif
	endif		
		
	endif
endEvent

; Finds a sleep sex partner near the player within radius. Prefers the closest
; actor (cheap, and thematically the partner beside you); if that isn't a valid
; partner, scans every living actor in the cell. The result is recorded through
; CheckSexPartnerOnSleep's bSexPartnerOnSleep/aSexPartnerOnSleep side effects -
; callers must ensure those flags are clear before calling.
function findSleepPartner(int radius)
	if CheckSexPartnerOnSleep(Game.FindClosestActorFromRef(PlayerRef, radius), PlayerRef)
		return
	endif
	Actor[] sleepActors = MiscUtil.ScanCellNPCs(PlayerRef, radius)
	int si = 0
	while si < sleepActors.length && !bSexPartnerOnSleep
		CheckSexPartnerOnSleep(sleepActors[si], PlayerRef)
		si += 1
	endWhile
endFunction

bool function CheckSexPartnerOnSleep(actor a,actor aPlayerRef=none)
	if a==aPlayerRef
		; Don't add sperm to yourself
		return false
	endif
	if System.IsValidateActor(aPlayerRef)<0
		return false
	endif
	if IsCreature
		if cfg.CreatureSperm ;Tkc (Loverslab): optimization
		else;if System.cfg.CreatureSperm==false
			return false
		endif
	endif
	;/
	if aPlayerRef==none
		if a!=none
			if System.IsValidateActor(a)>0
				if IsValidatePlayerSexPartner(a)
					bSexPartnerOnSleep = true
					aSexPartnerOnSleep = a
					return true
				endif
			endif
		endif
	else
		if a!=none
			if aPlayerRef.GetLeveledActorBase().GetSex()!=a.GetLeveledActorBase().GetSex() && System.IsValidateActor(a)>0
				if IsValidatePlayerSexPartner(a)
					bSexPartnerOnSleep = true
					aSexPartnerOnSleep = a
					return true
				endif
			endif
		endif
	endif
	/;
	;; ;Tkc (Loverslab): optimization
	if a
		if aPlayerRef
			if aPlayerRef.GetLeveledActorBase().GetSex()==a.GetLeveledActorBase().GetSex()
			else;if aPlayerRef.GetLeveledActorBase().GetSex()!=a.GetLeveledActorBase().GetSex()
				if aIsValidated(a)
					return true
				endif
			endif
		else
			if aIsValidated(a)
				return true
			endif
		endif
	endif
	return false
endFunction
;added for optimized code
bool function aIsValidated(actor a)
	if System.IsValidateActor(a)>0
		if IsValidatePlayerSexPartner(a)
			bSexPartnerOnSleep = true
			aSexPartnerOnSleep = a
			return true
		endif
	endif
	return false
endFunction

bool function IsValidatePlayerSexPartner(actor a)
	; Follower Check
	if a.IsInFaction(System.FollowerFaction)
		if cfg.ImpregnatePlayerFollower
			return true
		endif
	endif
	; Husband Check
	if a.IsInFaction(PlayerMarriedFaction)
		if cfg.ImpregnatePlayerHusband
			return true
		endif
	endif
	; Husband Check
	return cfg.ImpregnateLastPlayerNPCs
endfunction

function equipChild()
	;if ActorRef==none || IsPlayer;/==true/;
	if ActorRef ;Tkc (Loverslab): optimization
	else;ActorRef==none
		return
	endif
	if IsPlayer;/==true/;
		return
	endif
	;Equip baby
	int itmCount = ActorRef.GetNumItems()
	while itmCount>0
		itmCount-=1
		
		form f = ActorRef.GetNthForm(itmCount)
		FWChildArmor ca = f as FWChildArmor

		if ca;/!=none/; || f.HasKeyword(BabyKeyword) || f.GetName()=="Baby"
			; Check, give to other parent
			bool bGaveAway = false
;			if(ca;/!=none/; && bGaveAway==false && Utility.RandomInt(0,100)>85)
			if(ca && (bGaveAway == false) && (Utility.RandomInt(1, 100) > 85))
				actor a1 = ca.Mother
				actor a2 = ca.Father
				if a1;/!=none/; && a2;/!=none/;
					;if a1!=ActorRef && a1!=PlayerRef && a2 == ActorRef && a1;/!=none/;
					;Tkc (Loverslab): optimization
					;if a1;/!=none/; ;already checked before
						if a1==ActorRef
						else;if a1!=ActorRef
							if a1==PlayerRef
							else;if a1!=PlayerRef
								if a2 == ActorRef
									;if a2.IsDead()==false && a2.GetCurrentLocation() == a1.GetCurrentLocation() && a1.GetLeveledActorBase().IsUnique()
									if a2.IsDead() ;Tkc (Loverslab): optimization
									else;if a2.IsDead()==false
										if a2.GetCurrentLocation() == a1.GetCurrentLocation()
											if a1.GetLeveledActorBase().IsUnique()
												a1.AddItem(f,1)
												bGaveAway=true
											endif
										endif
									endif
								endif
							endif
						endif
					;endif
				
					;if a2!=ActorRef && a2!=PlayerRef && a1 == ActorRef && a2;/!=none/;
					;Tkc (Loverslab): optimization
					;if a2 ;already checked before
					if a2==ActorRef
					else;if a2!=ActorRef
						if a2==PlayerRef
						else;if a2!=PlayerRef
							if a1 == ActorRef
								;if a1.IsDead()==false && a1.GetCurrentLocation() == a2.GetCurrentLocation() && a2.GetLeveledActorBase().IsUnique()
								if a1.IsDead() ;Tkc (Loverslab): optimization
								else;if a1.IsDead()==false
									if a1.GetCurrentLocation() == a2.GetCurrentLocation()
										if a2.GetLeveledActorBase().IsUnique()
											a2.AddItem(f,1)
											bGaveAway=true
										endif
									endif
								endif
							endif
						endif
					endif
					;endif
				endif
			endif
			
			; Wasn't gave away - so equip it
			if bGaveAway == false
				ActorRef.EquipItem(f, false, true)
				itmCount=0
			endif
		endif
	endWhile
endFunction


function PlayBabySound_SleepStop()
	if bIsWearingBaby && IsPlayer;/==true/;
;		int rnd=Utility.RandomInt(0,100)
		int rnd = Utility.RandomInt(1, 100)
		if rnd>58
			if rnd>68
				if rnd>72
					if rnd>79
						if rnd>85
							if rnd>88
								if rnd>93
									PlayBabySound(BabyCry, true)
								else;if rnd>88
									PlayBabySound(BabyFear, true)
								endIf
							else;if rnd>85
								PlayBabySound(BabyTalk, true)
							endIf
						else;if rnd>79
							PlayBabySound(BabyHappy, true)
						endIf
					else;if rnd>72
						PlayBabySound(BabyAmuse, true)
					endIf
				else;if rnd>68
					PlayBabySound(BabyGiggle, true)
				endIf
			else;if rnd>58
				cBabyHiccup=Utility.RandomInt(1,15)
			endif
		endIf
	endif
endFunction

function PlayBabySound_OnHit()
	int rnd=Utility.RandomInt(0,7)
	if rnd > 5
		if rnd==7
			PlayBabySound(BabyCry, true)
		else;if rnd==6
			PlayBabySound(BabyFear, true)
		endif
	endIf
endFunction

function PlayBabySound_Hiccup()
	PlayBabySound(BabyHiccup, true)
endFunction

function PlayBabySound(spell SoundSpell = none, bool MustBeEquiped = false)
	if bIsWearingBaby;/==true/; && cfg.ChildrenMayCry;/==true/; && IsPlayer;/==true/;
		if ActorRef; as actor;/!=none/;
			; Play sound on User
			if SoundSpell;/!=none/;
				If ActorRef.HasSpell(SoundSpell)
					return
				else
					SoundSpell.Cast(ActorRef)
				endif
			endif
			ActorRef.CreateDetectionEvent(ActorRef, 100 )
			return
		endif
	endif
endFunction

function DispatchBabySoundFromUser(spell SoundSpell, spell ignoreSpell)
	if SoundSpell;/!=none/;
		if ignoreSpell;/!=none/;
			if ignoreSpell==SoundSpell ;Tkc (Loverslab): optimization
			else;if ignoreSpell!=SoundSpell
				if ActorRef.HasSpell(SoundSpell)
					ActorRef.RemoveSpell(SoundSpell)
				endif
			endif
		else
			if ActorRef.HasSpell(SoundSpell)
				ActorRef.RemoveSpell(SoundSpell)
			endif
		endif
	endif
endFunction



bool OnObjEqIsBusy
; Event received when this actor equips something - akReference may be None if object is not persistent
Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	if OnObjEqIsBusy ; Tkc (Loverslab); spamguard
	else	
	OnObjEqIsBusy = true
	
	if IsPlayer;/==true/;
		bIsWearingBaby=false
		string fName=FWUtility.GetIniFile(akBaseObject)
		if FWUtility.FileExists("BabySounds/"+fName)
			string tmpSoundFile = FWUtility.getIniCString("BabySounds", fName, "Sound","ModFile")
			string soundFile = FWUtility.ModFile( tmpSoundFile )
			if soundFile;/!=""/; ;Tkc (Loverslab): optimization
				bIsWearingBaby=true
				BabyCry=Game.GetFormFromFile(FWUtility.getIniCInt("BabySounds", fName, "Sound","BabyCry"), soundFile) as spell
				BabyFear=Game.GetFormFromFile(FWUtility.getIniCInt("BabySounds", fName, "Sound","BabyFear"), soundFile) as spell
				BabyTalk=Game.GetFormFromFile(FWUtility.getIniCInt("BabySounds", fName, "Sound","BabyTalk"), soundFile) as spell
				BabyDrink=Game.GetFormFromFile(FWUtility.getIniCInt("BabySounds", fName, "Sound","BabyDrink"), soundFile) as spell
				BabyHappy=Game.GetFormFromFile(FWUtility.getIniCInt("BabySounds", fName, "Sound","BabyHappy"), soundFile) as spell
				BabyLaugh=Game.GetFormFromFile(FWUtility.getIniCInt("BabySounds", fName, "Sound","BabyLaugh"), soundFile) as spell
				BabyAmuse=Game.GetFormFromFile(FWUtility.getIniCInt("BabySounds", fName, "Sound","BabyAmuse"), soundFile) as spell
				BabyGiggle=Game.GetFormFromFile(FWUtility.getIniCInt("BabySounds", fName, "Sound","BabyGiggle"), soundFile) as spell
				BabyHiccup=Game.GetFormFromFile(FWUtility.getIniCInt("BabySounds", fName, "Sound","BabyHiccup"), soundFile) as spell
				BabySupprised=Game.GetFormFromFile(FWUtility.getIniCInt("BabySounds", fName, "Sound","BabySupprised"), soundFile) as spell
			endif
		
			string tmpListFile = FWUtility.getIniCString("BabySounds", fName, "ItemList","ModFile")
			string listFile = FWUtility.ModFile(tmpListFile)
			if listFile;/!=""/; ;Tkc (Loverslab): optimization
				ItemListHappy=Game.GetFormFromFile(FWUtility.getIniCInt("BabySounds", fName, "ItemList","Happy"), listFile) as Formlist
				ItemListFear=Game.GetFormFromFile(FWUtility.getIniCInt("BabySounds", fName, "ItemList","Fear"), listFile) as Formlist
				ItemListSupprised=Game.GetFormFromFile(FWUtility.getIniCInt("BabySounds", fName, "ItemList","Supprised"), listFile) as Formlist
			endif
		endif
	endif
	
	OnObjEqIsBusy = false
	endif
endEvent

; returns the form for the item worn at the specified slotMask
; use Armor.GetMaskForSlot() to generate appropriate slotMask
;Form Function GetWornForm(int slotMask) native

; Event received when this actor unequips something - akReference may be None if object is not persistent
bool OnObjUnEqIsBusy
Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
	if OnObjUnEqIsBusy ; Tkc (Loverslab); spamguard
	else
		OnObjUnEqIsBusy = true
		
		string fName=FWUtility.GetIniFile(akBaseObject)
		if FWUtility.FileExists("BabySounds/"+fName)
			bIsWearingBaby=false
		endif
		
		OnObjUnEqIsBusy = false
	endif
endEvent

bool function CheckNoice_Weather()
	Weather w = Weather.GetCurrentWeather()
	int c = w.GetClassification()
	int r = Utility.RandomInt(0,10)
	if c == -1 ; No classification
	elseif c >= 0
		if c < 2
			if c==0 ; Pleasant
				if r > 5
					if r > 7
						if r>=9
							PlayBabySound(BabyHappy, true)
							return true
						else;if r==8
							PlayBabySound(BabyAmuse, true)
							return true
						endIf
					else
						if r==7
							PlayBabySound(BabyGiggle, true)
							return true
						else;if r==6
							PlayBabySound(BabyTalk, true)
							return true
						endif
					endIf
				endIf
			else;if c==1 ; Cloudy
			endIf
		elseif c < 4
			if c==2 ; Rainy
				if r>9
					PlayBabySound(BabyCry, true)
					return true
				endif
			else;if c==3 ; Snow
				if r>6
					PlayBabySound(BabyCry, true)
					return true
				endif
			endif
		endIf
	endIf
	return false
endFunction

bool function CheckNoice_HappyList()
	;if ItemListHappy==none ;|| babyMood<-3
	if ItemListHappy ;Tkc (Loverslab): optimization
	else;if ItemListHappy==none
		return false
	endif
	float Timer = Utility.GetCurrentRealTime()
	if Game.FindClosestReferenceOfAnyTypeInListFromRef(ItemListHappy, ActorRef, 500);/!=none/;
		PlayBabySound(BabyHappy, true)
		return true
	endif
	return false
endFunction

bool function CheckNoice_FearList()
	;if ItemListSupprised==none ;|| babyMood>3
	if ItemListSupprised ;Tkc (Loverslab): optimization
	else;if ItemListSupprised==none
		return false
	endif
	float Timer = Utility.GetCurrentRealTime()
	if Game.FindClosestReferenceOfAnyTypeInListFromRef(ItemListSupprised, ActorRef, 2000);/!=none/;
		PlayBabySound(BabyFear, true)
		return true
	endif
	return false
endFunction

bool function CheckNoice_ListSupprised()
	if ItemListFear ;Tkc (Loverslab): optimization
	else;if ItemListFear==none
		return false
	endif
	float Timer = Utility.GetCurrentRealTime()
	if Game.FindClosestReferenceOfAnyTypeInListFromRef(ItemListSupprised, ActorRef, 400);/!=none/;
		PlayBabySound(BabySupprised, true)
		return true
	endif
	return false
endFunction

; Event received when an item is added to this object's inventory. If the item is a persistant reference, akItemReference will
; point at it - otherwise the parameter will be None
bool OnItAddIsBusy
Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	if OnItAddIsBusy ;Tkc (Loverslab): spamguard
	else
	OnItAddIsBusy = true
	
	if bIsWearingBaby;/==true/; && cfg.ChildrenMayCry;/==true/; && IsPlayer;/==true/;
		if ItemListFear;/!=none/; && ItemListFear.Find(akBaseItem)
			if Utility.RandomInt(1,20)>13
				PlayBabySound(BabyFear, true)
			endif
		elseif ItemListHappy;/!=none/; && ItemListHappy.Find(akBaseItem)
			if Utility.RandomInt(1,20)>9
				PlayBabySound(BabyHappy, true)
			endif
		elseif ItemListSupprised;/!=none/; && ItemListSupprised.Find(akBaseItem)
			if Utility.RandomInt(1,20)>9
				PlayBabySound(BabySupprised, true)
			endif
		endif
	elseif akBaseItem.HasKeyword(BabyKeyword)
		equipChild()
	endif
	
	OnItAddIsBusy = false
	endif
endEvent

; Event received when a spell is cast by this object
Event OnSpellCast(Form akSpell)
	if(akSpell)
		if bIsWearingBaby;/==true/; && cfg.ChildrenMayCry;/==true/; && IsPlayer;/==true/;
			if ItemListFear;/!=none/; && ItemListFear.Find(akSpell)
				if Utility.RandomInt(1,10)>7
					PlayBabySound(BabyFear, true)
				endif
			elseif ItemListHappy;/!=none/; && ItemListHappy.Find(akSpell)
				if Utility.RandomInt(1,10)>4
					PlayBabySound(BabyHappy, true)
				endif
			elseif ItemListSupprised;/!=none/; && ItemListSupprised.Find(akSpell)
				if Utility.RandomInt(1,10)>8
					PlayBabySound(BabySupprised, true)
				endif
			endif
		endif
	endIf
endEvent

; 07 jule 2019 Tkc (Loverslab) optimizations: Changes marked with "Tkc (Loverslab)" comment
