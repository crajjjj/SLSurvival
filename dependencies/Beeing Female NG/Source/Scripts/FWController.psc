Scriptname FWController extends Quest

FWSystem property System auto

float property Sperm_Min_Amount_For_Impregnation=0.0009 autoReadOnly
float property Sperm_Amount_For_Delete=0.0008 autoReadOnly
Actor property PlayerRef auto ; Tkc (Loverslab) : added to replace much slower Game.GetPlayer()

;/
; FUNCTION INDEX
; Function Name							Description
;--------------------------------------------------------------
; GetStoredFemaleCount					This Function will return the count of the stored woman
; GetStoredFemale						This function will return the stored women at position X
; CreateFemaleActor						Create Stats for the given Actor
; Impregnate							Forced Impregnation for the given Woman from the given Father (optional the number of the children)
; ImpregnateA							Forced Impregnation for the given Woman from the given Fathers (array - arraysize must be the Number of children - see Function Description)
; ActiveSpermImpregnation				Normal Impregnation from the active sperm if exists
; ActiveSpermImpregnationTimed			Normal Impregnation from the active sperm by the given time - if exists
; Unimpregnate							Removed the impregnation without child born
; UnimpregnateState						Removed the impregnation without child born and jump to the given phase
; GiveBirth								Force the woman to give birth
; DamageBaby							Damages the Baby with the given Damage
; HealBaby								Heals the Baby with the given amount
; AbortusBaby							Force an abortus
; AbortusBabyTimed						Force an abortus by given time
; AbortusState							Force an given abortus
; AbortusStateTimed						Force an given abortus at given time
; AddSperm								Add sperm to the given woman from the given man
; AddSpermTimed							Add sperm to the given woman from the given man at the given time
; RemoveSperm							removes all sperm from the woman from the given man
; RemoveAllSperm						removes all sperm from the woman from everyone
; ChangeState							changes the phase the woman is int
; HasRelevantSperm						returns if the woman has relevant sperm inside
; RelevantSpermCount					returns the number with relevant actors who has sperm inside the given woman
; GetRelevantSpermActors				returns an array with all relevant actors who has sperm inside the given woman
; GetRelevantSpermFloat					returns an array with actor relevance 
; HasRelevantSpermTimed					Check if the woman got relevant sperm for impregnation inside at the given time
; RelevantSpermCountTimed				returns the number of relevant sperm actors at the given time
; GetRelevantSpermActorsTimed			Get a list of actors that are most relevant at the given time
; GetRelevantSpermFloatTimed			
; HasSpermInWoman						Check if the given man got sperm in the given woman
; HasSpermInWomanTimed					Check if the given man had sperm in the given woman at the given time
; GetStatePercentage					Returns the percent (0.0 to 100.0) of the womans state
; GetStateEnterTime						Returns the time the woman enterd her state/phase
; GetBabyHealth							returns the health the given womans unborn baby got
; IsPregnant							returns if the woman is pregnant
; GetFemaleState						returns the state/phase the woman is in
; GetNumBirth							returns the number of birth the woman already had
; showInfoBox							open the ShowState window for the given woman
; setCanBecomePregnant					set the flag if the woman may become pregnant in her current cycle
; setCanBecomePMS						set the flag if the woman may become PMS in her current cycle
; setFlag								set the flag for the woman
; getContraception						returns the percent of contraception (0.0 to 100.00)
; getContraceptionTimed					returns the percent of contraception at the given time
; AddContraception						Add an amount of contraception
; AddContraceptionTimed					Add an amount of contraception at the given time
; GetContraceptionDuration				Returns the remaining time till the next pill is required
; GetContraceptionDurationTimed			Returns the remaining time till the next pill was required at the given time
; showRankedInfoBox						open the ShowStats window with the given rank
; showDescriptedRankedInfoBox			open the ShowStats window with the given rank as descripted text



; Full Function Description
;--------------------------------------------------------------
; This Function will return the count of the stored woman
; int function GetStoredFemaleCount()
;
; This function will return the stored women at position X
; actor function GetStoredFemale(int Position)
;
; Create Stats for the given Actor
; bool function CreateFemaleActor(actor woman)
;
; Forced Impregnation for the given Woman from the given Father (optional the number of the children)
; function Impregnate(actor Mother, actor Father, int NumChilds=1)
;
; Forced Impregnation for the given Woman from the given Fathers (array - arraysize must be the Number of children - see Function Description)
; function ImpregnateA(actor Mother, actor[] Fathers, int NumChilds=1)
;
; Normal Impregnation from the active sperm if exists
; bool function ActiveSpermImpregnation(actor Mother, bool bIgnoreContraception = false)
;
; Normal Impregnation from the active sperm by the given time - if exists
; bool function ActiveSpermImpregnationTimed(actor Mother, float Time, bool bIgnoreContraception = false)
;
; Removed the impregnation without child born
; function UnimpregnateState(actor Mother)
;
; Removed the impregnation without child born and jump to the given phase
; function UnimpregnateState(actor Mother, int Menstrual_Cycle_State)
;
; Force the woman to give birth
; function GiveBirth(actor Mother)
;
; Damages the Baby with the given Damage
; function DamageBaby(actor Mother,float Damage)
;
; Heals the Baby with the given amount
; function HealBaby(actor Mother,float Amount)
;
; Force an abortus
; function AbortusBaby(actor Mother)
;
; Add sperm to the given woman from the given man
; function AddSperm(actor Woman, actor PotentialFather, float amount = 1.0)
;
; Add sperm to the given woman from the given man at the given time
; function AddSperm(actor Woman, float Time, actor PotentialFather, float amount = 1.0)
;
; removes all sperm from the woman from the given man
; function RemoveSperm(actor Woman, actor Man)
;
; removes all sperm from the woman from everyone
; function RemoveAllSperm(actor Woman)
;
; changes the phase the woman is in
; function ChangeState(actor Woman, int NewState)
;
; changes the phase the woman is in based on the given time
; function ChangeStateTimed(actor female, float Time, int state_number)
;
; returns if the woman has relevant sperm inside
; bool function HasRelevantSperm(actor Woman, bool bShowTravelingSperm = true)
;
; returns the number with relevant actors who has sperm inside the given woman
; int function RelevantSpermCount(actor Woman, bool bShowTravelingSperm = true)
;
; returns an array with all relevant actors who has sperm inside the given woman
; Actor[] function GetRelevantSpermActors(actor Woman, bool bShowTravelingSperm = true, bool bSort = true)
;
; returns an array with actor relevance 
; float[] function GetRelevantSpermFloat(actor Woman, bool bShowTravelingSperm = true, bool bSort = true)
;
; Check if the woman got relevant sperm for impregnation inside at the given time
; bool function HasRelevantSperm(actor Woman, float Time, bool bShowTravelingSperm = true)
;
; returns the number of relevant sperm actors at the given time
; int function HasRelevantSperm(actor Woman, float Time, bool bShowTravelingSperm = true)
;
; Get a list of actors that are most relevant at the given time
; Actor[] function HasRelevantSperm(actor Woman, float Time, bool bShowTravelingSperm = true, bool bSort = true)
;
; GetRelevantSpermFloatTimed
; float[] function GetRelevantSpermFloatTimed(actor Woman, float Time, bool bShowTravelingSperm = true, bool bSort = true)
;			
; Check if the given man got sperm in the given woman
; bool function HasSpermInWoman(actor male, actor female=none, bool bShowTravelingSperm = true)
;
; Check if the given man had sperm in the given woman at the given time
; bool function HasSpermInWomanTimed(actor male, actor female=none, float Time, bool bShowTravelingSperm = true)
;
; Returns the percent (0.0 to 100.0) of the womans state
; Float Function GetStatePercentage(Actor woman)
;
; Returns the time the woman enterd her state/phase
; Float Function GetStateEnterTime(Actor woman)
;
; returns the health the given womans unborn baby got
; float function GetBabyHealth(actor woman)
;
; returns if the woman is pregnant
; bool function IsPregnant(actor woman)
;
; returns the state/phase the woman is in
; int function GetFemaleState(actor woman)
;
; returns the number of birth the woman already had
; int function GetNumBirth(actor woman)
;
; open the ShowState window for the given woman
; function showInfoBox(actor a)
;
; set the flag if the woman may become pregnant in her current cycle
; int function setCanBecomePregnant(actor woman, bool bActive)
;
; set the flag if the woman may become PMS in her current cycle
; int function setCanBecomePMS(actor woman, bool bActive)
;
; set the flag for the woman
; int function setFlag(actor woman, bool bCanBecomePregnant, bool bCanBecomePMS)
;
; returns the percent of contraception (0.0 to 100.00)
; float function getContraception(actor Woman)
;
; returns the percent of contraception at the given time
; float function getContraceptionTimed(actor Woman, float Time)
;
; Add an amount of contraception
; float function AddContraception(actor Woman, float Value)
;
; Returns the remaining time till the next pill is required
; float function GetContraceptionDuration(actor Woman)
;
; Returns the remaining time till the next pill was required at the given time
; float function GetContraceptionDurationTimed(Actor Woman, float Time)
;
; open the ShowStats window with the given rank
; function showRankedInfoBox(actor target, int Rank)
;
; open the ShowStats window with the given rank as descripted text
; function showDescriptedRankedInfoBox(actor target, int Rank)

/;

GlobalVariable Property GameDaysPassed Auto
Globalvariable property ModEnabled auto
Globalvariable property CloakingSpellEnabled auto
FWSystemConfig property cfg auto
FWAddOnManager property Manager auto
Activator Property MaraShrineObject Auto ; God of love and marriage
Activator Property ArkayShrineObject Auto ; God of birth and death
spell property Effect_VaginalBloodLow auto
spell property Effect_VaginalBloodBig auto
potion property ContraceptionLow auto
potion property ContraceptionMid auto
FWBabyHealthWidget property BabyHealthWidget auto
FWStateWidget property StateWidget auto
FWContraceptionWidget property ContraceptionWidget auto
FWSaveLoad property Data auto
FWTextContents property Content auto

; This Function will return the count of the stored woman
int function GetStoredFemaleCount()
	return StorageUtil.FormListCount(none,"FW.SavedNPCs")
endFunction

; This function will return the stored women at position X
actor function GetStoredFemale(int Position)
	if Position <0 || Position >=StorageUtil.FormListCount(none,"FW.SavedNPCs")
		return none
	endif
	return StorageUtil.FormListGet(none,"FW.SavedNPCs",Position) as actor
endFunction


; Creating the Menstruation Cycle for this Actor
; returns false when there was an error
bool function CreateFemaleActor(actor woman, bool force_new=false)
	;System.Trace("FWController.CreateFemaleActor",woman)
	;if System.CloakingSpellEnabled.GetValueInt()!=1 || System.ModEnabled.GetValueInt()!=1
	if ModEnabled.GetValue() As int ;Tkc (Loverslab) optimization
	else;if System.ModEnabled.GetValueInt()!=1
		return false
	endif
	if CloakingSpellEnabled.GetValue() As int
	else;if System.CloakingSpellEnabled.GetValueInt()!=1
		return false
	endif
	if woman ;Tkc (Loverslab) optimization
	else;if woman==none
		return false
	endif
	if System.IsValidateFemaleActor(woman)<=0
		return false
	endIf
	bool hasSaved = ( StorageUtil.FormListFind(none,"FW.SavedNPCs",woman)>=0 )
	;If hasSaved;/==true/; && force_new==false
	If hasSaved ;Tkc (Loverslab) optimization
		If force_new
		else;If force_new==false
			return true
		endIf
	endIf
	System.Message("Creating new woman stats for: "+woman.GetLeveledActorBase().GetName(), System.MSG_All)
	
	int stateID=Utility.RandomInt(0,3)
	Float currentTime = GameDaysPassed.GetValue()
	float stateDuration = System.GetStateDuration(stateID,woman)
	Float stateEnterTime = currentTime - Utility.RandomFloat(0, stateDuration - 0.5)
	
	if woman == PlayerRef
		stateID=0
		stateEnterTime=currentTime - Utility.RandomFloat(0, stateDuration /2)
	endif
	
	int flag=0
	if System.canBecomePregnant(woman)
		flag+=1
	endIf
	if System.canBecomePMS(woman)
		flag+=2
	endIf
	
	StorageUtil.SetIntValue(woman,"FW.CurrentState",stateID)
	StorageUtil.SetFloatValue(woman,"FW.StateEnterTime",stateEnterTime)
	StorageUtil.SetFloatValue(woman,"FW.LastUpdate",currentTime)
	StorageUtil.SetFloatValue(woman,"FW.LastLoaded",currentTime)
	StorageUtil.SetIntValue(woman,"FW.Flags",flag)

	if hasSaved==false || force_new;/==true/;
		StorageUtil.FormListAdd(none,"FW.SavedNPCs",woman)
	endif
	
	return true
endFunction


; This function will impregnate the given actor and forcing the 1. Trimester-State
function Impregnate(actor Mother, actor Father, int NumChilds=1)
	;System.Trace("FWController.Impregnate",Mother)
	if Mother==PlayerRef ;Tkc (Loverslab) optimization
	else;if Mother!=PlayerRef
		if cfg.NPCCanBecomePregnant
		else;if System.cfg.NPCCanBecomePregnant==false
			return
		endif
	endif
	if System.CheckIsLoreFriendlyMetting(Mother, Father) ;Tkc (Loverslab) optimization
	else;if !System.CheckIsLoreFriendlyMetting(Mother, Father)
		return ; Not lore friendly
	endif
	Actor[] f= FWUtility.ActorArray(NumChilds)
	int i=0
	while i<NumChilds
		f[i]=Father
		i+=1
	endWhile
	ImpregnateA(Mother,f,NumChilds)
endFunction

; This function will impregnate the given actor by the given fathers and forcing the 1. Trimester-State
; For each Child the father must be given - for Exambple with 3 Childs
; Fathers[0] = Alvor
; Fathers[1] = Alvor
; Fathers[2] = Ulfric
function ImpregnateA(actor Mother, actor[] Fathers, int NumChilds=1)
	;System.Trace("FWController.ImpregnateA",Mother)
	if Mother==PlayerRef ;Tkc (Loverslab) optimization
	else;if Mother!=PlayerRef
		if cfg.NPCCanBecomePregnant
		else;if System.cfg.NPCCanBecomePregnant==false
			return
		endif
	endif
	int cSperm=Fathers.length
	int xNumChilds=NumChilds
	if xNumChilds<=0
		xNumChilds = System.calculateNumChildren(PlayerRef)
	endIf
	FWUtility.ClearChildFathers(Mother)
	StorageUtil.SetIntValue(Mother,"FW.NumChilds",xNumChilds)
	While xNumChilds>0
		xNumChilds -= 1
		actor tFather = Fathers[Utility.RandomInt(0, cSperm - 1)]
		FWUtility.AddChildFather(Mother, tFather)
	EndWhile
	StorageUtil.SetFloatValue(Mother,"FW.UnbornHealth",100.0)
	StorageUtil.UnsetIntValue(Mother,"FW.Abortus")
	StorageUtil.SetFloatValue(Mother,"FW.LastConception", Utility.GetCurrentGameTime())
	Manager.OnImpregnate(Mother, NumChilds,Fathers)
	SendConceptionEvent(Mother, Fathers)
	ChangeState(Mother,4)
endFunction

function SendConceptionEvent(actor Mother, actor[] Fathers)
	if !Mother
		return
	endif

	actor Father0 = none 
	actor Father1 = none
	actor Father2 = none
	int childCount = StorageUtil.GetIntValue(Mother,"FW.NumChilds",0)
	if Fathers.length > 0
		Father0 = Fathers[0]
	endif
	if Fathers.length > 1
		Father1 = Fathers[1]
	endif
	if Fathers.length > 2
		Father2 = Fathers[2]
	endif

	int eid = ModEvent.Create("BeeingFemaleConception")
	if eid
		ModEvent.PushForm(eid, Mother)
		ModEvent.PushInt(eid, childCount)
		ModEvent.PushForm(eid, Father0)
		ModEvent.PushForm(eid, Father1)
		ModEvent.PushForm(eid, Father2)
		ModEvent.Send(eid)
	endif
endFunction

; Check for the normal impregnation, using the sperm, the value if she can become pregnant in this cycle, and so on.
bool function ActiveSpermImpregnation(actor Mother, bool bIgnoreContraception = false)
	;System.Trace("FWController.ActiveSpermImpregnation",Mother)
	return ActiveSpermImpregnationTimed(Mother, GameDaysPassed.GetValue(), bIgnoreContraception)
endFunction

; Check for the normal impregnation at the given time, using the sperm, the value if she can become pregnant in this cycle, and so on.
bool function ActiveSpermImpregnationTimed(actor Mother, float Time, bool bIgnoreContraception = false)
	;System.Trace("FWController.ActiveSpermImpregnationTimed",Mother)
	int spermEntries = StorageUtil.FormListCount(Mother, "FW.SpermName")
	int curState = StorageUtil.GetIntValue(Mother, "FW.CurrentState", 0)
	FW_log.WriteLog("FWController.ActiveSpermImpregnationTimed: " + Mother + ", state=" + curState + ", spermEntries=" + spermEntries + ", time=" + Time + ", contraception=" + getContraceptionTimed(Mother, Time))
	if Mother==PlayerRef ;Tkc (Loverslab) optimization
	else;if Mother!=PlayerRef
		if cfg.NPCCanBecomePregnant
		else;if System.cfg.NPCCanBecomePregnant==false
			FW_log.WriteLog("FWController.ActiveSpermImpregnationTimed: blocked — NPCCanBecomePregnant=false")
			return false
		endif
	endif
	bool bCanBecomePregnant=canBecomePregnant(Mother)
	if bCanBecomePregnant ;Tkc (Loverslab) optimization
	else;if bCanBecomePregnant==false
		FW_log.WriteLog("FWController.ActiveSpermImpregnationTimed: blocked — canBecomePregnant=false")
		return false
	endif
	if bIgnoreContraception ;Tkc (Loverslab) optimization
	else;if bIgnoreContraception==false
		ContraceptionSpermKillTimed(Mother,Time)
	endIf
	bool bHasSperm = HasRelevantSpermTimed(Mother,Time,false)
	FW_log.WriteLog("FWController.ActiveSpermImpregnationTimed: hasRelevantSperm=" + bHasSperm)
	if bHasSperm
		if Manager.ActorCanBecomePregnant(Mother);/==true/;
			; Impregnate by active sperm
			int numChild=System.calculateNumChildren(Mother)
			if numChild ;Tkc (Loverslab) optimization
			else;if numChild==0
				return false
			endIf
			;FW_log.WriteLog("ActiveSpermImpregnationTimed 05 - "+numChild)
			actor[] a=GetRelevantSpermActorsTimed(Mother,Time,false,false)
			float[] relevantSperm=GetRelevantSpermFloatTimed(Mother,Time, false, false)
			;if relevantSperm.length==0 ;Tkc (Loverslab) optimization: commented, next condition is checking same thing
			;	return false
			;endif
			;actor[] fathers= FWUtility.ActorArray(numChild)
			int c=relevantSperm.length
			if c ;Tkc (Loverslab) optimization
			else;if c==0
				; All donors may be unloaded (creatures) — still conceive using stored sperm race
				FW_log.WriteLog("FWController.ActiveSpermImpregnationTimed: all " + spermEntries + " donors unloaded — using FW.SpermRace fallback for " + numChild + " children")
				StorageUtil.SetIntValue(Mother,"FW.NumChilds",numChild)
				int spermCount = StorageUtil.FormListCount(Mother, "FW.SpermRace")
				int nc = numChild
				while nc > 0
					nc -= 1
					race spermRace = none
					if spermCount > 0
						spermRace = StorageUtil.FormListGet(Mother, "FW.SpermRace", Utility.RandomInt(0, spermCount - 1)) as Race
					endif
					FWUtility.AddChildFather(Mother, none, spermRace)
				endWhile
				StorageUtil.SetFloatValue(Mother,"FW.UnbornHealth",100.0)
				StorageUtil.UnsetIntValue(Mother,"FW.Abortus")
				StorageUtil.SetFloatValue(Mother,"FW.LastConception", Utility.GetCurrentGameTime())
				actor[] emptyFathers = FWUtility.ActorArray(numChild)
				Manager.OnImpregnate(Mother, numChild, emptyFathers)
				SendConceptionEvent(Mother, emptyFathers)
				ChangeStateTimed(Mother,Time,4)
				return true
			endif
			int i=0
			float relevanceTotal=0.0
			while i<c
				relevanceTotal+=relevantSperm[i]
				;FW_log.WriteLog("["+Mother.GetLeveledActorBase().GetName()+"] Relevant sperm ["+i+"] = "+relevantSperm[i])
				i+=1
			endWhile
			;FW_log.WriteLog("["+Mother.GetLeveledActorBase().GetName()+"] Relevant sperm total = "+relevanceTotal)
			;FW_log.WriteLog("ActiveSpermImpregnationTimed 06 - spermTotal: "+relevanceTotal)
			
			StorageUtil.SetIntValue(Mother,"FW.NumChilds",numChild)
			actor[] Fathers = FWUtility.ActorArray(numChild)

			while numChild>0
				numChild-=1
				; Classic weighted pick (the upstream original): walk the donors
				; until the cumulative weight bucket containing rnd_r is found.
				; The (j + 1) < c bound keeps a[j] valid even when float rounding
				; pushes rnd_r past the last bucket.
				; Sperm_Impregnation_Boost is deliberately NOT part of the father
				; weighting - it is a conception-CHANCE modifier (see
				; FWAbilityBeeingFemale); the earlier boost-based selection here
				; degenerated to "always the last donor" at the default boost of 0.
				float rnd_r = Utility.RandomFloat(0, relevanceTotal)
				int j = 0
				while (rnd_r >= relevantSperm[j]) && ((j + 1) < c)
					rnd_r -= relevantSperm[j]
					j += 1
				endWhile
				FWUtility.AddChildFather(Mother, a[j])
				Fathers[numChild]=a[j]
			endWhile
			StorageUtil.SetFloatValue(Mother,"FW.UnbornHealth",100.0)
			StorageUtil.UnsetIntValue(Mother,"FW.Abortus")
			StorageUtil.SetFloatValue(Mother,"FW.LastConception", Utility.GetCurrentGameTime())
			Manager.OnImpregnate(Mother, Fathers.length,Fathers)
			SendConceptionEvent(Mother, Fathers)
			ChangeStateTimed(Mother,Time,4)
			return true
		else
			FW_log.WriteLog("FWController.ActiveSpermImpregnationTimed: blocked — ActorCanBecomePregnant=false")
		endIf
	else
		FW_log.WriteLog("FWController.ActiveSpermImpregnationTimed: no relevant sperm (spermEntries=" + spermEntries + ", loreFriendly=" + cfg.ImpregnateLoreFriendly + ", creatureSperm=" + cfg.CreatureSperm + ")")
	endIf
	return false
endFunction

; A Speed-Up variant for ActiveSpermImpregnation - without calculating the contraception-value
bool function ActiveSpermImpregnationContraception(actor Mother, float contraception)
	;System.Trace("FWController.ActiveSpermImpregnationContraception",Mother)
	return ActiveSpermImpregnationNoContraceptionTimed(Mother, GameDaysPassed.GetValue(), contraception)
endFunction

; A Speed-Up variant for ActiveSpermImpregnationTimed - without calculating the contraception-value
bool function ActiveSpermImpregnationNoContraceptionTimed(actor Mother, float Time, float contraception)
	;System.Trace("FWController.ActiveSpermImpregnationContraceptionTimed",Mother)
	;if Mother!=PlayerRef && System.cfg.NPCCanBecomePregnant==false
	if Mother==PlayerRef ;Tkc (Loverslab) optimization
	else;if Mother!=PlayerRef
		if cfg.NPCCanBecomePregnant
		else;if System.cfg.NPCCanBecomePregnant==false
			return false
		endif
	endif
	bool bCanBecomePregnant=canBecomePregnant(Mother)
	if bCanBecomePregnant ;Tkc (Loverslab) optimization
	else;if bCanBecomePregnant==false
		return false
	endif
	
	int sa= StorageUtil.FormListCount(Mother, "FW.SpermName") ;StorageUtil.FloatListCount(Mother, "FW.SpermAmount")
	while sa>0
		sa-=1
		float amo = StorageUtil.FloatListGet(Mother, "FW.SpermAmount", sa)
		if amo>0.3
			int rnd1= Utility.RandomInt(0,3)
			float rnd2
			if rnd1 < 2
				if rnd1==0
					rnd2 = Utility.RandomFloat(1,95.0)
				else
					rnd2 = Utility.RandomFloat(10.0,100.0)
				endIf
			else
				if rnd1==2
					rnd2 = Utility.RandomFloat(20.0,100.0)
				else
					rnd2 = Utility.RandomFloat(40.0,100.0)
				endIf
			endIf
;			if contraception>rnd2
			if(contraception >= rnd2)
				; Below Sperm_Min_Amount_For_Impregnation so the kill actually
				; blocks conception (0.1 still passed every relevance filter)
				StorageUtil.FloatListSet(Mother, "FW.SpermAmount", sa, Sperm_Amount_For_Delete)
			endif
		endif
	endWhile
	
	if ;/System.Controller./;HasRelevantSpermTimed(Mother,Time,false) ;Tkc (Loverslab) optimization: it is Controller
		if Manager.ActorCanBecomePregnant(Mother);/==true/;
			; Impregnate by active sperm
			int numChild=System.calculateNumChildren(Mother)
			if numChild ;Tkc (Loverslab) optimization
			else;if numChild==0
				return false
			endIf
			actor[] a= GetRelevantSpermActorsTimed(Mother,Time,false,false)
			float[] relevantSperm= GetRelevantSpermFloatTimed(Mother,Time, false, false)
			;if relevantSperm.length==0 ;Tkc (Loverslab) optimization: commented, made same in next condition
			;	return false
			;endif
			;actor[] fathers= FWUtility.ActorArray(numChild)
			float relevanceTotal=0.0
			int c=relevantSperm.length
			if c ;Tkc (Loverslab) optimization
			else;if c==0
				return false
			endif
			int i=0
			while i<c
				relevanceTotal+=relevantSperm[i]
				i+=1
			endWhile
			
			StorageUtil.SetIntValue(Mother,"FW.NumChilds",numChild)
			actor[] Fathers= FWUtility.ActorArray(numChild)
			while numChild>0
				numChild-=1
				float rnd_r= Utility.RandomFloat(0,relevanceTotal)
				int j=0
				while rnd_r>relevantSperm[j] && (j + 1) < c
					rnd_r-=relevantSperm[j]
					j+=1
				endWhile
				FWUtility.AddChildFather(Mother, a[j])
				Fathers[numChild]=a[j]
			endWhile
			StorageUtil.SetFloatValue(Mother,"FW.UnbornHealth",100.0)
			StorageUtil.SetFloatValue(Mother,"FW.LastConception", Utility.GetCurrentGameTime())
			Manager.OnImpregnate(Mother, Fathers.length,Fathers)
			SendConceptionEvent(Mother, Fathers)
			ChangeStateTimed(Mother,Time,4)
			return true
		endIf
	endIf
	return false
endFunction

; Returns the number of Babys the given woman is pregnant with
int function getNumBabys(actor Mother)
	return StorageUtil.GetIntValue(Mother,"FW.NumChilds",0)
endFunction

bool function setNumBabys(actor Mother,int num)
	FW_log.WriteLog("FWController::setNumBabys("+Mother.GetLeveledActorBase().GetName()+", "+num+")")
	int cur = StorageUtil.GetIntValue(Mother,"FW.NumChilds",0)
	if cur ;Tkc (Loverslab) optimization: swapped checks
		if cur==num
			; same value
			FW_log.WriteLog("- No changes")
			return true
		elseif cur<num
			; add fathers
			FW_log.WriteLog("- Raise from "+cur+" to "+num+" Babys")
			StorageUtil.SetIntValue(Mother,"FW.NumChilds",num)
			actor father = StorageUtil.FormListGet(Mother,"FW.ChildFather", 0) as actor
			int i=cur
			; Was "while i<cur" - the loop never ran, so NumChilds rose without
			; matching ChildFather entries and the parallel lists went out of sync
			while i<num
				if father
					FW_log.WriteLog("- Father for Baby "+i+" is "+father.GetLeveledActorBase().GetName())
				else
					FW_log.WriteLog("- Father for Baby "+i+" is none")
				endif
				FWUtility.AddChildFather(Mother, father)
				i+=1
			endWhile
			return true
		else;if cur>num
			FW_log.WriteLog("- Drop from "+cur+" to "+num+" Babys")
			
			; remove fathers
			StorageUtil.SetIntValue(Mother,"FW.NumChilds",num)
			int i=StorageUtil.FormListCount(Mother,"FW.ChildFather")
			while i>num
				i-=1
				actor remFather = StorageUtil.FormListGet(Mother,"FW.ChildFather", i) as actor
				string remFatherStr = ""
				if StorageUtil.StringListCount(Mother,"FW.ChildFatherStr") > i
					remFatherStr = StorageUtil.StringListGet(Mother,"FW.ChildFatherStr", i)
				endif
				race remFatherRace = none
				if StorageUtil.FormListCount(Mother,"FW.ChildFatherRace") > i
					remFatherRace = StorageUtil.FormListGet(Mother,"FW.ChildFatherRace", i) as race
				endif
				string remFatherRaceStr = ""
				if remFatherRace
					remFatherRaceStr = FWUtility.GetStringFromForm(remFatherRace)
				endif
				if remFather
					FW_log.WriteLog("- Remove Father "+i+": "+remFather.GetLeveledActorBase().GetName()+" ("+remFatherStr+") ["+remFatherRaceStr+"]")
				else
					FW_log.WriteLog("- Remove Father "+i+": none ("+remFatherStr+") ["+remFatherRaceStr+"]")
				endif
				FWUtility.RemoveChildFatherAt(Mother, i)
			endWhile
			return true
		endif
	else;if cur==0
		FW_log.WriteLog("- Actor not pregnant")
		return false
	endif
endFunction

; This function will wash out some sperm depending on the MCM settings
; Type definition:
; WashOutType 0: without auxiliary material or any help
; WashOutType 1: when swining
; WashOutType 2: with a bottle of washout fluid or something like that
;
; Strength is a multiplyer - by default it's 1.0, so Itemwithsoudscript's tha chance setting in the mcm menu
function WashOutSperm(actor woman, int WashOutType = 1, float Strength=1.0)
	;System.Trace("FWController.WashOutSperm",woman)
	float chance=0
	if Strength<=0
		return
	endif
	if WashOutType >= 0
		if WashOutType < 2
			if WashOutType==0
				chance = cfg.WashOutChance
			else;if WashOutType==1
				chance = cfg.WashOutWaterChance
			endIf
		elseif WashOutType==2
			chance = cfg.WashOutFluidChance
		endif
	endIf
	if chance>0
		int c = StorageUtil.FormListCount(woman, "FW.SpermName");StorageUtil.FloatListCount(woman, "FW.SpermTime")
		int j = 0
		float rnd
		float Time = GameDaysPassed.GetValue()
		while c>0
			c-=1
			rnd = Utility.RandomFloat(0.00001,1.0)
			float STime = StorageUtil.FloatListGet(woman, "FW.SpermTime", c)
			if STime + Data.SpermDeleteTime > Time || STime+cfg.WashOutHourDelay >= Time
				if (chance * Strength)>=rnd
					; Sperm was to old - remove
					FWUtility.RemoveSpermMirrorAt(woman, c)
;				elseif Utility.RandomInt(0,100)>34
				elseif(Utility.RandomInt(1, 100) > 34)
					float amount=StorageUtil.FloatListGet(woman, "FW.SpermAmount", c)
					amount-=Utility.RandomFloat(0.0,0.15 * Strength)
					if amount < Sperm_Min_Amount_For_Impregnation
						; To less sperm, remove
						FWUtility.RemoveSpermMirrorAt(woman, c)
					else
						StorageUtil.FloatListSet(woman, "FW.SpermAmount", c, amount)
					endif
				endif
			endIf
		endWhile
	endif
	ApplySemenCircleTattoo(woman)
	ApplyWombTattoo(woman)
endfunction

function ContraceptionSpermKill(actor Woman)
	;System.Trace("FWController.ContraceptionSpermKill",Woman)
	ContraceptionSpermKillTimed(Woman, GameDaysPassed.GetValue())
endFunction

function ContraceptionSpermKillTimed(actor Woman, float Time)
	;System.Trace("FWController.ContraceptionSpermKillTimed",Woman)
	float contraception = getContraceptionTimed(Woman,Time)
	int c= StorageUtil.FormListCount(woman, "FW.SpermName");StorageUtil.FloatListCount(Woman, "FW.SpermAmount")
	
	actor man_candidate = none
	race man_r = none
	float anti_cont = -1
	float rnd_determine = 0
	bool man_ignore_contraception = false
	
	while c>0
		c-=1
		
		man_ignore_contraception = false
		man_candidate = (StorageUtil.FormListGet(woman, "FW.SpermName", c) As Actor)
		if !man_candidate
			anti_cont = StorageUtil.GetFloatValue(none, "FW.AddOn.Global_Ignore_Contraception_Prob", 0)
		else
			anti_cont = StorageUtil.GetFloatValue(man_candidate, "FW.AddOn.Ignore_Contraception_Prob", 0)
			if(anti_cont == 0)
				man_r = man_candidate.GetRace()
				anti_cont = StorageUtil.GetFloatValue(man_r, "FW.AddOn.Ignore_Contraception_Prob", 0)
				if(anti_cont == 0)
					anti_cont = StorageUtil.GetFloatValue(none, "FW.AddOn.Global_Ignore_Contraception_Prob", 0)
				endIf
			endIf
		endIf
		if(anti_cont > 0)
			rnd_determine = Utility.RandomFloat(0, 99)
			if(rnd_determine < anti_cont)
				man_ignore_contraception = true
			endIf
		endIf
		
		if(man_ignore_contraception)
		else
			float amo = StorageUtil.FloatListGet(Woman, "FW.SpermAmount", c)
			if amo>Sperm_Min_Amount_For_Impregnation
				int rnd1= Utility.RandomInt(0,3)
				float rnd2
				if rnd1 < 2
					if rnd1==0
						rnd2 = Utility.RandomFloat(1,95.0)
					else
						rnd2 = Utility.RandomFloat(10.0,100.0)
					endIf
				else
					if rnd1==2
						rnd2 = Utility.RandomFloat(20.0,100.0)
					else
						rnd2 = Utility.RandomFloat(40.0,100.0)
					endIf
				endIf
				
	;			if contraception>rnd2
				if(contraception >= rnd2)
					; Was Sperm_Min_Amount_For_Impregnation, which every relevance
					; filter accepts with >= - the kill never blocked conception
					StorageUtil.FloatListSet(Woman, "FW.SpermAmount", c, Sperm_Amount_For_Delete)
				elseif contraception > 20
					StorageUtil.FloatListSet(Woman, "FW.SpermAmount", c, amo - (contraception * 0.002))
				endif
			endif
		endIf
	endWhile
endFunction


; This function will unimpregnate the woman and forcing the replanish state
function Unimpregnate(actor Mother)
	;System.Trace("FW Debug: FWController.Unimpregnate",Mother)
	UnimpregnateState(Mother,0)
endFunction


; This function will unimpregnate the woman and changing to the given menstrual-cycle-state
function UnimpregnateState(actor Mother, int Menstrual_Cycle_State)
	;System.Trace("FW Debug: FWController.UnimpregnateState",Mother)
	If (StorageUtil.FormListFind(none,"FW.SavedNPCs",Mother)<0)
		CreateFemaleActor(Mother)
	EndIf
	FWUtility.ClearChildFathers(Mother)
	StorageUtil.SetIntValue(Mother,"FW.NumChilds",0)
	StorageUtil.UnsetIntValue(Mother,"FW.Abortus")
	StorageUtil.UnsetFloatValue(Mother,"FW.UnbornHealth")
	StorageUtil.UnsetFloatValue(Mother,"FW.AbortusTime")
	StorageUtil.SetFloatValue(Mother,"FW.LastConception", 0.0)
	int xMenstrual_Cycle_State=Menstrual_Cycle_State
	if xMenstrual_Cycle_State<0 || xMenstrual_Cycle_State>3
		xMenstrual_Cycle_State=0
	endIf
	if Mother==PlayerRef
		System.Player.NumChilds = 0
		System.Player.changeState(xMenstrual_Cycle_State)
		System.Player.SetBelly()
	else
		StorageUtil.SetFloatValue(Mother,"FW.StateEnterTime", GameDaysPassed.GetValue());
		StorageUtil.SetIntValue(Mother,"FW.CurrentState", xMenstrual_Cycle_State)
		UpdateParentFaction(Mother)
		int flag=0
		if System.canBecomePregnant(Mother)
			flag+=1
		endIf
		if System.canBecomePMS(Mother)
			flag+=2
		endIf
		StorageUtil.SetIntValue(Mother,"FW.Flags",flag)
		System.raiseModEventA("Update",Mother)
	endIf
endFunction


; This function will force the birth for the given pregnant woman
; The given Woman must be pregnant already
; True when the mother is locked into a pose/animation the birth lay-down
; sequence would fight: occupying furniture (chairs, crafting stations, and
; ZAP/DD bound furniture like crosses & pillories) or wearing heavy bondage
; (armbinder, yoke, ...). When true, GiveBirth uses the non-animated birth path
; instead of forcing a broken / T-posing idle on top of the restraint.
; The DD keyword is resolved lazily so DD stays a soft dependency (None when
; DD isn't installed -> the check is simply skipped).
bool function IsBirthAnimationBlocked(actor Mother)
	if !Mother
		return false
	endif
	if Mother.GetFurnitureReference() ; sitting / crafting / bound to furniture
		FW_log.WriteLog("FWController.IsBirthAnimationBlocked: " + Mother + " is occupying furniture - birth animation will be skipped (silent birth)")
		return true
	endif
	Keyword kwHeavyBondage = Keyword.GetKeyword("zad_DeviousHeavyBondage")
	if kwHeavyBondage && Mother.WornHasKeyword(kwHeavyBondage)
		FW_log.WriteLog("FWController.IsBirthAnimationBlocked: " + Mother + " is in heavy bondage - birth animation will be skipped (silent birth)")
		return true
	endif
	return false
endFunction

function GiveBirth(actor Mother)

	;System.Trace("FW Debug: FWController.GiveBirth",Mother)
	If (StorageUtil.FormListFind(none,"FW.SavedNPCs",Mother)<0)
		;CreateFemaleActor(Mother)
		return; never was initialised - so can't be pregnant
	EndIf

	; Guard against re-entrancy / multiple triggers causing duplicate births.
	int NumChilds = StorageUtil.GetIntValue(Mother,"FW.NumChilds",0)
	int fatherCount = StorageUtil.FormListCount(Mother, "FW.ChildFather")
	int fatherRaceCount = StorageUtil.FormListCount(Mother, "FW.ChildFatherRace")
	FW_log.WriteLog("FWController.GiveBirth: " + Mother + ", numChilds=" + NumChilds + ", fatherCount=" + fatherCount + ", fatherRaceCount=" + fatherRaceCount + ", playAnimations=" + cfg.PlayAnimations + ", babySpawn=" + cfg.BabySpawn)
	if NumChilds ;Tkc (Loverslab) optimization
	else;if NumChilds==0
		if StorageUtil.FormListFind(none,"FW.GivingBirth", Mother) >= 0
			StorageUtil.FormListRemove(none,"FW.GivingBirth", Mother)
			StorageUtil.UnsetFloatValue(Mother, "FW.GivingBirthTime")
		endif
		return;
	EndIf

	; --- DHLP: respect other mods that hold the actor in a scene ---
	; Wait out any active dhlp-Suspend (Devious Devices, defeat, OStim
	; listeners, ...) before we strip / lock / animate. The re-entrancy guard
	; below still de-dupes concurrent triggers (the claim happens after this
	; wait), and the wait is capped so a leaked suspend from a misbehaving mod
	; can never block birth forever (~15 min: 90 * 10s).
	int dhlpWaited = 0
	if System.IsDHLPSuspended()
		FW_log.WriteLog("FWController.GiveBirth: DHLP suspend active for " + Mother + " - deferring birth scene start")
	endif
	while System.IsDHLPSuspended() && dhlpWaited < 90
		Utility.Wait(10.0)
		dhlpWaited += 1
	endWhile
	if dhlpWaited > 0
		if System.IsDHLPSuspended()
			FW_log.WriteLog("FWController.GiveBirth: DHLP suspend still active after ~" + (dhlpWaited * 10) + "s cap - proceeding with birth for " + Mother)
		else
			FW_log.WriteLog("FWController.GiveBirth: DHLP suspend cleared after ~" + (dhlpWaited * 10) + "s - resuming birth for " + Mother)
		endif
	endif

	if StorageUtil.FormListFind(none,"FW.GivingBirth", Mother) >= 0
		float birthStart = StorageUtil.GetFloatValue(Mother, "FW.GivingBirthTime", 0.0)
		if birthStart > 0.0 && (GameDaysPassed.GetValue() - birthStart) < 0.25
			FW_log.WriteLog("FWController.GiveBirth: already giving birth for " + Mother)
			return
		endif
		; stale guard from a previous stack dump — clear and proceed
		FW_log.WriteLog("FWController.GiveBirth: clearing stale GivingBirth flag for " + Mother)
		StorageUtil.FormListRemove(none, "FW.GivingBirth", Mother)
	endif

	; Claim the birth right after the guard check - the ModEvent calls below
	; unlock the script, so a second trigger must hit the guard above first
	StorageUtil.FormListAdd(none,"FW.GivingBirth", Mother) ;Tkc (Loverslab): Mother added to the GivingBirth list to detect her when is giving birth by papyrus condition or from esp
	StorageUtil.SetFloatValue(Mother, "FW.GivingBirthTime", GameDaysPassed.GetValue())

	; Birth is now committed - tell DHLP-aware mods to suspend while it plays.
	System.DHLPSuspend(Mother)

	int laborEvent = ModEvent.Create("BeeingFemaleLabor")
	if laborEvent
		actor Father0 = none 
		actor Father1 = none
		actor Father2 = none
		int childCount = StorageUtil.GetIntValue(Mother,"FW.NumChilds",0)
		if StorageUtil.FormListCount(Mother, "FW.ChildFather") > 0
			Father0 = StorageUtil.FormListGet(Mother,"FW.ChildFather", 0) as actor
		endif
		if StorageUtil.FormListCount(Mother, "FW.ChildFather") > 1
			Father1 = StorageUtil.FormListGet(Mother,"FW.ChildFather", 1) as actor
		endif
		if StorageUtil.FormListCount(Mother, "FW.ChildFather") > 2
			Father2 = StorageUtil.FormListGet(Mother,"FW.ChildFather", 2) as actor
		endif
		ModEvent.PushForm(laborEvent, Mother)
		ModEvent.PushInt(laborEvent, childCount)
		ModEvent.PushForm(laborEvent, Father0)
		ModEvent.PushForm(laborEvent, Father1)
		ModEvent.PushForm(laborEvent, Father2)
		ModEvent.Send(laborEvent)
	endif

	Manager.OnGiveBirthStart(Mother)
	Mother.EvaluatePackage()
	float UnbornHealth=StorageUtil.GetFloatValue(Mother,"FW.UnbornHealth",100.0)
	Actor[] ChildFather = FWUtility.ActorArray(NumChilds)
	
	actor my_ChildFather = none
	actorbase my_ChildFather_ab = none
	race my_ChildFather_abr = none
	float my_IntervalBabyScale = 10000
	float my_IntervalLaborScale = 10000
	float my_BirthPainDamageScale = 10000

	float temp_IntervalBabyScale = 10000
	float temp_IntervalLaborScale = 10000
	float temp_BirthPainDamageScale = 10000

	int k=NumChilds
	while k>0
		k-=1
		
		my_ChildFather = StorageUtil.FormListGet(Mother, "FW.ChildFather", k) as actor
		if my_ChildFather
			my_ChildFather_abr = my_ChildFather.GetRace()
		else
			my_ChildFather_abr = none
			if StorageUtil.FormListCount(Mother, "FW.ChildFatherRace") > k
				my_ChildFather_abr = StorageUtil.FormListGet(Mother, "FW.ChildFatherRace", k) as race
			endif
		endIf

		if my_ChildFather
			temp_IntervalBabyScale = StorageUtil.GetFloatValue(my_ChildFather, "FW.AddOn.Modify_SecondsBetweenBabySpawn_by_FatherRace", 0)
		else
			temp_IntervalBabyScale = 0
		endIf
		if(temp_IntervalBabyScale == 0)
			temp_IntervalBabyScale = StorageUtil.GetFloatValue(my_ChildFather_abr, "FW.AddOn.Modify_SecondsBetweenBabySpawn_by_FatherRace", 0)
			if(temp_IntervalBabyScale == 0)
				temp_IntervalBabyScale = 1.0
			endIf
		endIf
		
		if my_ChildFather
			temp_IntervalLaborScale = StorageUtil.GetFloatValue(my_ChildFather, "FW.AddOn.Modify_SecondsBetweenLaborPains_by_FatherRace", 0)
		else
			temp_IntervalLaborScale = 0
		endIf
		if(temp_IntervalLaborScale == 0)
			temp_IntervalLaborScale = StorageUtil.GetFloatValue(my_ChildFather_abr, "FW.AddOn.Modify_SecondsBetweenLaborPains_by_FatherRace", 0)
			if(temp_IntervalLaborScale == 0)
				temp_IntervalLaborScale = 1.0
			endIf
		endIf
		
		if my_ChildFather
			temp_BirthPainDamageScale = StorageUtil.GetFloatValue(my_ChildFather, "FW.AddOn.Modify_Pain_GivingBirth_by_FatherRace", 1.0)
		else
			temp_BirthPainDamageScale = 1.0
		endIf
		if(temp_BirthPainDamageScale == 1.0)
			temp_BirthPainDamageScale = StorageUtil.GetFloatValue(my_ChildFather_abr, "FW.AddOn.Modify_Pain_GivingBirth_by_FatherRace", 1.0)
		endIf
		
		if(temp_IntervalBabyScale < my_IntervalBabyScale)
			my_IntervalBabyScale = temp_IntervalBabyScale
		endIf
		if(temp_IntervalLaborScale < my_IntervalLaborScale)
			my_IntervalLaborScale = temp_IntervalLaborScale
		endIf
		if(temp_BirthPainDamageScale < my_BirthPainDamageScale)
			my_BirthPainDamageScale = temp_BirthPainDamageScale
		endIf
		
		ChildFather[k] = my_ChildFather
	endWhile
	my_IntervalBabyScale *= Manager.getActorDuration_BabySpawn(Mother)
	if(my_IntervalBabyScale < 0.3)
		my_IntervalBabyScale = 0.3
	endIf
	my_IntervalLaborScale *= Manager.getActorDuration_BetweenLaborPains(Mother)
	if(my_IntervalLaborScale < 0.3)
		my_IntervalLaborScale = 0.3
	endIf
	my_BirthPainDamageScale *= System.getDamageScale(4,Mother)
	
	float IntervalBabyScale = my_IntervalBabyScale
	float IntervalLaborScale = my_IntervalLaborScale
	float BirthPainDamageScale = my_BirthPainDamageScale
	float DamageScale = 1.0 * BirthPainDamageScale
	if Mother.IsOnMount();/==true/;
		Mother.Dismount()
		Mother.SetVehicle(none)
		Utility.Wait(3)
	endIf
	Form[] dropedItems
	; Skip the lay-down birth animation when the mother is committed to another
	; pose the engine won't let us override (furniture / heavy bondage). Fall back
	; to the non-animated birth so we never force a broken idle on the restraint.
	bool blocked = IsBirthAnimationBlocked(Mother)
	bool playAnim = cfg.PlayAnimations && !blocked
	if(playAnim)
		dropedItems = System.StripActor(Mother)
	
		bool useBed = System.LayDown(Mother)
		if useBed;/==true/;
			DamageScale -= 0.1
		endIf
	endif
	
	if Mother==PlayerRef
		; Skip taking over player control (AI-driven / chargen lock / camera) when
		; another system already owns the player (DD bondage, furniture). Layering
		; our global control toggles on top risks a stuck AI-driven / no-controls
		; softlock, and UnlockPlayer below would clobber their control state.
		if !blocked
			FWUtility.LockPlayer()
			Manager.StartCamera()
		endif
	else
		Mother.SetDontMove(true)
	endIf
	
	ObjectReference MaraShrine = Game.FindClosestReferenceOfTypeFromRef(MaraShrineObject, Mother, 300);
	if MaraShrine;/!=none/;
		DamageScale -= 0.1 ; Mara loves us all
	endIf
	ObjectReference ArkayShrine = Game.FindClosestReferenceOfTypeFromRef(ArkayShrineObject, Mother, 300);
	if ArkayShrine;/!=none/;
		DamageScale -= 0.3 ; Arkay is helping with birth
	endIf
	
	bool my_BirthPain = true
	if(DamageScale <= 0)
		my_BirthPain = false
	endIf
	FW_log.WriteLog("FWController.GiveBirth: DamageScale=" + DamageScale + ", my_BirthPain=" + my_BirthPain)
	
	if(playAnim)
		Utility.Wait(3*IntervalLaborScale)
		Debug.SendAnimationEvent(Mother, "Birth_S1")
		System.Mimik(Mother, "Pained", 85)
		System.PlayPainSound(Mother)
		if(my_BirthPain)
			System.doDamage(Mother, 8 * DamageScale ,10)
		endIf
		Utility.Wait(3*IntervalLaborScale)
	endif

	System.Mimik(Mother, "Pained", 90)
	System.PlayPainSound(Mother, 40)
	if(my_BirthPain)
		System.DoDamage(Mother, 11 * DamageScale ,10)
	endIf
	; Raise the birth count (baby count is incremented per live birth in the loop below)
	StorageUtil.SetIntValue(Mother,"FW.NumBirth", StorageUtil.GetIntValue(Mother,"FW.NumBirth") + 1)

	if(my_BirthPain)
		System.ActorAddSpellOpt(Mother,Effect_VaginalBloodLow,false,true)
	endIf

	while NumChilds > 0
		NumChilds -= 1
		Utility.Wait(4*IntervalBabyScale)

		System.Mimik(Mother, "Pained", 75)

		if(playAnim)
			Debug.SendAnimationEvent(Mother, "Birth_S2");
			Utility.Wait(1)
			int j = 8
			Debug.SendAnimationEvent(Mother, "Birth_S3");
			System.Mimik(Mother, "Pained", 80)
			while j > 0
				System.PlayPainSound(Mother)
				if(my_BirthPain)
					System.DoDamage(Mother,9 * DamageScale,10)
				endIf
				Utility.Wait(2*IntervalBabyScale)
				j -= 1
			endWhile
			System.Mimik(Mother, "Pained", 70)

			;Debug.SendAnimationEvent(Mother, "Birth_S3");
			Utility.Wait(2*IntervalBabyScale)
			System.Mimik(Mother, "Pained", 100)
		else
			if(my_BirthPain)
				int j = 4
				while j > 0
					System.DoDamage(Mother,16 * DamageScale,10)
					Utility.Wait(1*IntervalBabyScale)
					j -= 1
				endWhile
			else
				Utility.Wait(4*IntervalBabyScale)
			endIf
		endif

		System.PlayPainSound(Mother, 60)
		if(my_BirthPain)
			System.DoDamage(Mother,18 * DamageScale,9)
		endIf
		
		float HealthRnd = Utility.RandomFloat(0.0,35.0)
		if UnbornHealth > HealthRnd || cfg.abortus==false
			;System.raiseModEvent("FWSpawnChild",self)
			if(my_BirthPain)
				System.ActorAddSpellOpt(Mother,Effect_VaginalBloodBig,false,true)
			endIf
			race childFatherRace = none
			if StorageUtil.FormListCount(Mother, "FW.ChildFatherRace") > NumChilds
				childFatherRace = StorageUtil.FormListGet(Mother, "FW.ChildFatherRace", NumChilds) as race
			endif
			FW_log.WriteLog("FWController.GiveBirth: spawning child index " + NumChilds + ", father = " + ChildFather[NumChilds] + ", childFatherRace = " + childFatherRace + ", childFatherRaceCount = " + StorageUtil.FormListCount(Mother, "FW.ChildFatherRace"))
			System.SpawnChild(Mother,ChildFather[NumChilds],childFatherRace)
			StorageUtil.SetIntValue(Mother,"FW.NumBabys", StorageUtil.GetIntValue(Mother,"FW.NumBabys",0) + 1)
		else
			System.Message("You've born a dead child...", System.MSG_ALWAYS)
			; Child is death >.<
		endIf
		
		if(playAnim)
			Utility.Wait(1)
			Debug.SendAnimationEvent(Mother, "Birth_S1")
		endif
		Utility.Wait(2)

		System.Mimik(Mother, "Pained", 100)

		StorageUtil.SetIntValue(Mother,"FW.NumChilds",NumChilds)
		if NumChilds ;Tkc (Loverslab): optimization
			SetBelly(Mother,false)
		else;if NumChilds==0
			SetBelly(Mother,true)
		endIf
		Utility.Wait(3*IntervalBabyScale)
	endWhile
	System.Mimik(Mother, "Happy", 80)
	
	StorageUtil.UnsetFloatValue(Mother,"FW.UnbornHealth")
	FWUtility.ClearChildFathers(Mother)
	StorageUtil.UnsetFloatValue(Mother,"FW.AbortusTime")
	StorageUtil.SetFloatValue(Mother,"FW.LastConception", 0.0)
	Utility.Wait(2)
	; Clear expressions
	
	if(playAnim)
		System.GetUp(Mother)
		System.UnstripActor(Mother,dropedItems)
	endif
	Manager.OnGiveBirthEnd(Mother)
	Mother.EvaluatePackage()
	
	if Mother==PlayerRef
		; Only release what we took: if birth was blocked we never locked, so
		; leave the player's control state to whoever owns it (DD, furniture).
		if !blocked
			FWUtility.UnlockPlayer()
			Manager.StopCamera()
		endif
	else
		Mother.SetDontMove(false)
		
		if(cfg.NPCHaveItems)
			FW_log.WriteLog("FWController : NPCHaveItems option is turned on, and thus adding contraception to " + Mother + " whose name is " + Mother.GetDisplayName())
			Mother.AddItem(ContraceptionMid,3)
			Mother.AddItem(ContraceptionLow,12)
		endIf
	endIf
	
	System.Mimik(Mother)
	;changeState(Mother,8)
	StorageUtil.SetIntValue(Mother,"FW.CurrentState",8)
	StorageUtil.SetFloatValue(Mother,"FW.StateEnterTime", GameDaysPassed.GetValue())
	UpdateParentFaction(Mother)
	
	SendModEvent("BeeingFemale","Update", Mother.GetFormID())

	ApplyBabyTrackerTattoos(Mother)
	ApplyWombTattoo(Mother)

	; Birth scene finished - let DHLP-aware mods resume.
	System.DHLPResume(Mother)
	StorageUtil.FormListRemove(none,"FW.GivingBirth", Mother) ; Tkc (Loverslab) : end of givingbirth anim, remove the Mother
	StorageUtil.UnsetFloatValue(Mother, "FW.GivingBirthTime")
endFunction

; SexLab Aroused (SLA) integration. Routed through FWInterfaceArousal which
; wraps the slaSetArousalEffect ModEvent and slaframeworkscr exposure reads.
bool function IsSlaPresent() global
	return FWInterfaceArousal.IsPresent()
endFunction

function StartOvulationArousal(actor Woman)
	if !cfg.OvulationArousalEnabled || !Woman
		return
	endif
	FWInterfaceArousal.StartOvulationRamp(Woman, cfg.OvulationArousalRate * 24.0, cfg.OvulationArousalCap)
endFunction

function StopOvulationArousal(actor Woman)
	FWInterfaceArousal.StopOvulationRamp(Woman)
endFunction

function StartPMSArousalDebuff(actor Woman)
	if !cfg.PMSArousalDebuffEnabled || !Woman
		return
	endif
	FWInterfaceArousal.StartPMSDebuff(Woman, 0.0 - cfg.PMSArousalRate * 24.0, 0.0 - cfg.PMSArousalPenalty)
endFunction

function StopPMSArousalDebuff(actor Woman)
	FWInterfaceArousal.StopPMSDebuff(Woman)
endFunction

; BabyTracker SlaveTats integration
function ApplyBabyTrackerTattoos(actor Mother)
	if !cfg.BabyTrackerTattoos || !Mother
		return
	endif
	if Game.GetModByName("SlaveTats.esp") == 255
		return
	endif
	int babys = StorageUtil.GetIntValue(Mother, "FW.NumBabys", 0)
	if babys <= 0
		return
	endif
	RemoveBabyTrackerTattoos(Mother)
	; Apply the single largest denomination tattoo that does not exceed the
	; baby count. Earlier versions composed multiple tattoos (e.g. 9 babies
	; = _baby8 + _baby1) but the BabyTracker SlaveTats JSON puts all of the
	; _babyN tattoos in the same body slot, so only the last-applied one
	; ever rendered — which made high baby counts visually look like single
	; ones. A tier display avoids the lie.
	if babys >= 12
		SlaveTats.simple_add_tattoo(Mother, "BabyTracker", "Babytracker_baby12", 0, true, true)
	elseif babys >= 8
		SlaveTats.simple_add_tattoo(Mother, "BabyTracker", "Babytracker_baby8", 0, true, true)
	elseif babys >= 4
		SlaveTats.simple_add_tattoo(Mother, "BabyTracker", "Babytracker_baby4", 0, true, true)
	elseif babys >= 3
		SlaveTats.simple_add_tattoo(Mother, "BabyTracker", "Babytracker_baby3", 0, true, true)
	elseif babys >= 2
		SlaveTats.simple_add_tattoo(Mother, "BabyTracker", "Babytracker_baby2", 0, true, true)
	else
		SlaveTats.simple_add_tattoo(Mother, "BabyTracker", "Babytracker_baby1", 0, true, true)
	endif
endFunction

function RemoveBabyTrackerTattoos(actor Mother)
	if !Mother
		return
	endif
	if Game.GetModByName("SlaveTats.esp") == 255
		return
	endif
	SlaveTats.simple_remove_tattoo(Mother, "BabyTracker", "Babytracker_baby1", true, true)
	SlaveTats.simple_remove_tattoo(Mother, "BabyTracker", "Babytracker_baby2", true, true)
	SlaveTats.simple_remove_tattoo(Mother, "BabyTracker", "Babytracker_baby3", true, true)
	SlaveTats.simple_remove_tattoo(Mother, "BabyTracker", "Babytracker_baby4", true, true)
	SlaveTats.simple_remove_tattoo(Mother, "BabyTracker", "Babytracker_baby8", true, true)
	SlaveTats.simple_remove_tattoo(Mother, "BabyTracker", "Babytracker_baby12", true, true)
endFunction

; BabyTracker semen circle tattoo — regular when cum inside, hearts when conception chance
function ApplySemenCircleTattoo(actor Woman, bool force = false)
	if !cfg.SemenCircleTattoos || !Woman
		return
	endif
	if Game.GetModByName("SlaveTats.esp") == 255
		return
	endif
	if force
		; re-add even when the tracked state is unchanged (MCM Refresh after
		; SlaveTats lost the overlay)
		RemoveSemenCircleTattoo(Woman)
	endif
	; Check if there is visible sperm (matches MCM info page criteria)
	bool hasCum = false
	float currentTime = GameDaysPassed.GetValue()
	int sa = StorageUtil.FormListCount(Woman, "FW.SpermName")
	while sa > 0
		sa -= 1
		if StorageUtil.FloatListGet(Woman, "FW.SpermAmount", sa) >= Sperm_Min_Amount_For_Impregnation
			if StorageUtil.FormListGet(Woman, "FW.SpermName", sa) as Actor
				if currentTime - StorageUtil.FloatListGet(Woman, "FW.SpermTime", sa) <= cfg.SpermDuration
					hasCum = true
					sa = 0
				endif
			endif
		endif
	endWhile
	; Determine desired tattoo: 0=none, 1=regular, 2=hearts
	int desired = 0
	if hasCum
		int cycleState = StorageUtil.GetIntValue(Woman, "FW.CurrentState", 0)
		if cycleState == 1
			desired = 2
		else
			desired = 1
		endif
	endif
	; Compare with current state to avoid unnecessary SlaveTats calls
	int current = StorageUtil.GetIntValue(Woman, "FW.SemenTattooState", 0)
	if desired == current
		return
	endif
	; State changed — update tattoos
	if current == 1
		SlaveTats.simple_remove_tattoo(Woman, "BabyTracker", "Babytracker_semen", true, true)
	elseif current == 2
		SlaveTats.simple_remove_tattoo(Woman, "BabyTracker", "Babytracker_hearts semen sircle", true, true)
	endif
	if desired == 1
		SlaveTats.simple_add_tattoo(Woman, "BabyTracker", "Babytracker_semen", 0, true, true)
	elseif desired == 2
		SlaveTats.simple_add_tattoo(Woman, "BabyTracker", "Babytracker_hearts semen sircle", 0, true, true)
	endif
	StorageUtil.SetIntValue(Woman, "FW.SemenTattooState", desired)
endFunction

function RemoveSemenCircleTattoo(actor Woman)
	if !Woman
		return
	endif
	if Game.GetModByName("SlaveTats.esp") == 255
		return
	endif
	SlaveTats.simple_remove_tattoo(Woman, "BabyTracker", "Babytracker_semen", true, true)
	SlaveTats.simple_remove_tattoo(Woman, "BabyTracker", "Babytracker_hearts semen sircle", true, true)
	StorageUtil.SetIntValue(Woman, "FW.SemenTattooState", 0)
endFunction

; "BF Womb tattoo" SlaveTats pack integration (section "BF PW") - a single
; womb-state tattoo following the whole cycle: baseline/ovulation with semen
; fill levels, fertilization, pregnancy phases, multiples, and birth.
; Exactly one tattoo from the section is shown at a time; FW.WombTattooState
; remembers the current one so SlaveTats is only invoked on actual changes.
function ApplyWombTattoo(actor Woman, bool force = false)
	if !cfg.WombTattoos
		return
	endif
	; Player-only by default. The womb tattoo re-applies on every cycle/semen
	; change, so broadcasting it to all tracked NPCs is expensive (and rarely
	; visible on clothed actors) - opt in via the Global_WombTattooNPCs INI.
	if Woman != PlayerRef && !Manager.WombTattooNPCsAllowed()
		return
	endif
	if Game.GetModByName("SlaveTats.esp") == 255
		return
	endif
	if force
		; re-add even when the tracked state is unchanged (MCM Refresh after
		; SlaveTats lost the overlay)
		RemoveWombTattoo(Woman)
	endif
	string desired = GetWombTattooName(Woman)
	string current = StorageUtil.GetStringValue(Woman, "FW.WombTattooState", "")
	if desired == current
		return
	endif
	if current != ""
		SlaveTats.simple_remove_tattoo(Woman, "BF PW", current, true, true)
	endif
	if desired != ""
		SlaveTats.simple_add_tattoo(Woman, "BF PW", desired, 0, true, true)
	endif
	StorageUtil.SetStringValue(Woman, "FW.WombTattooState", desired)
endFunction

string function GetWombTattooName(actor Woman)
	int cycleState = StorageUtil.GetIntValue(Woman, "FW.CurrentState", 0)
	if cycleState == 7
		return "PW Birth"
	endif
	if cycleState >= 4 && cycleState <= 6
		; multiples become visible from the second trimester
		; (FW.NumChilds = unborn count this pregnancy; FW.NumBabys is the lifetime birth tally)
		int babys = StorageUtil.GetIntValue(Woman, "FW.NumChilds", 0)
		if babys >= 2 && cycleState >= 5
			if babys >= 4
				return "PW 4Babies"
			elseif babys == 3
				return "PW 3Babies"
			endif
			return "PW 2Babies"
		endif
		if cycleState == 4
			; fertilized egg on the first day, then the embryo
			if GameDaysPassed.GetValue() - StorageUtil.GetFloatValue(Woman, "FW.StateEnterTime", 0.0) < 1.0
				return "PW fertilization"
			endif
			return "PW Baby(phase1)"
		elseif cycleState == 5
			return "PW Baby(phase2)"
		endif
		return "PW Baby(phase3)"
	endif
	; states 0-3 and 8: baseline with semen fill level
	float total = 0.0
	int sa = StorageUtil.FormListCount(Woman, "FW.SpermName")
	while sa > 0
		sa -= 1
		float amt = StorageUtil.FloatListGet(Woman, "FW.SpermAmount", sa)
		if amt >= Sperm_Min_Amount_For_Impregnation
			total += amt
		endif
	endwhile
	if cycleState == 1
		if total <= 0.0
			return "PW Ovulation"
		elseif total < 3.0
			return "PW Ovulation semen(3)"
		elseif total < 9.0
			return "PW Ovulation semen(11)"
		elseif total < 15.0
			return "PW Ovulation semen(full)"
		endif
		return "PW Ovulation semen(full2)"
	endif
	if total <= 0.0
		return "PW normal"
	elseif total < 3.0
		return "PW normal semen(3)"
	elseif total < 9.0
		return "PW normal semen(9)"
	endif
	return "PW normal semen(full)"
endFunction

function RemoveWombTattoo(actor Woman)
	if !Woman
		return
	endif
	if Game.GetModByName("SlaveTats.esp") == 255
		return
	endif
	string current = StorageUtil.GetStringValue(Woman, "FW.WombTattooState", "")
	if current != ""
		SlaveTats.simple_remove_tattoo(Woman, "BF PW", current, true, true)
	endif
	StorageUtil.UnsetStringValue(Woman, "FW.WombTattooState")
endFunction

; Refresh the womb-state SlaveTats across every tracked female NPC: re-apply it
; when the Global_WombTattooNPCs opt-in is on (and WombTattoos enabled), otherwise
; remove it so overlays left behind from a previous "on" state are stripped off
; NPCs. Heavy (loops all tracked NPCs and hits SlaveTats), so it is driven only by
; the MCM "Refresh Tattoos" button, never automatically. The player is refreshed
; separately by that button.
function RefreshWombTattooNPCs()
	if Game.GetModByName("SlaveTats.esp") == 255
		return
	endif
	bool bApply = cfg.WombTattoos && Manager.WombTattooNPCsAllowed()
	int c = StorageUtil.FormListCount(none, "FW.SavedNPCs")
	int i = 0
	while i < c
		actor npc = StorageUtil.FormListGet(none, "FW.SavedNPCs", i) as actor
		if npc && npc != PlayerRef
			if bApply
				ApplyWombTattoo(npc, true)
			else
				RemoveWombTattoo(npc)
			endif
		endif
		i += 1
	endWhile
endFunction

; Forcing a Belly-Refresh for the given actor
function SetBelly(actor Woman, bool ForceNPC=true)
	;System.Trace("FWController.SetBelly",Woman)
	if Woman==PlayerRef
		System.Player.SetBelly()
	elseif ForceNPC;/==true/;
		System.raiseModEventA("Belly",Woman)
	endIf
endFunction


; This function will damage the unborn child of the given mother
function DamageBaby(actor Mother,float Damage)
	if(cfg.abortus)
		FW_log.WriteLog("FWController - DamageBaby: Abortus is turned on! Processing DamageBaby on mother " + Mother)

		;System.Trace("FWController.DamageBaby",Mother)
		If (StorageUtil.FormListFind(none,"FW.SavedNPCs",Mother)<0)
			;CreateFemaleActor(Mother)
			return; never was initialised - so can't be pregnant
		EndIf
		if StorageUtil.GetIntValue(Mother, "FW.Abortus",0)>1
			; Abortus has already been started
			return
		endif
		int s = StorageUtil.GetIntValue(Mother,"FW.CurrentState",0)
		if s<4 && s==8
			; Not pregnant or in replenish
			return
		endif
		float hp = StorageUtil.GetFloatValue(Mother, "FW.UnbornHealth",100.0)
		
		
		int num_babies_orig = StorageUtil.FormListCount(Mother, "FW.ChildFather")
		actor Father = none
		float DamageScaleByFather = 0
		float HealingScaleByFather = 0
		
		int num_babies = num_babies_orig
		while(num_babies > 0)
			num_babies -= 1
			Father = (StorageUtil.FormListGet(Mother, "FW.ChildFather", num_babies) As Actor)
			DamageScaleByFather += Manager.ActorBabyDamageScaleByFather(Father)
			HealingScaleByFather += Manager.ActorBabyHealingScaleByFather(Father)
		endWhile
		
		
		if Damage>0
			Damage *= ((Manager.ActorBabyDamageScale(Mother)) * DamageScaleByFather / num_babies_orig)
		else
			Damage *= ((Manager.ActorBabyHealingScale(Mother)) * HealingScaleByFather / num_babies_orig)
		endif
		
		if cfg.Difficulty == 0
			Damage = 0
			hp = 100
		else
			if Damage>0
				if cfg.Difficulty > 0
					if cfg.Difficulty < 3
						if cfg.Difficulty == 1 ; Easy
							Damage *= 0.7
						endIf
					else
						if cfg.Difficulty == 3 ; Advanced
							Damage *= 1.3
						elseif cfg.Difficulty == 4 ; Heavy
							Damage *= 1.7
						endIf
					endIf
				endIf
			endif
			
			if hp - Damage<0.0
				hp=0
			elseif hp - Damage >100.0
				hp=100
			else
				hp-=Damage
			endIf
		endIf
		StorageUtil.SetFloatValue(Mother, "FW.UnbornHealth",hp)
		if PlayerRef == Mother
			System.Player.checkAbortus()
			BabyHealthWidget.showTimed(Mother)
		else
			SendModEvent("BeeingFemale","CheckAbortus",Mother.GetFormID())
		endIf
	else
		FW_log.WriteLog("FWController - DamageBaby: Abortus is turned off!")
		return
	endIf
endFunction


function SetBabyHealth(actor Mother,float value)
	If (StorageUtil.FormListFind(none,"FW.SavedNPCs",Mother)<0)
		;CreateFemaleActor(Mother)
		return; never was initialised - so can't be pregnant
	EndIf
	if StorageUtil.GetIntValue(Mother, "FW.Abortus",0)>1
		; Abortus has already been started
		return
	endif
	int s = StorageUtil.GetIntValue(Mother,"FW.CurrentState",0)
	if s<4 && s==8
		; Not pregnant or in replenish
		return
	endif
	if value<0.0
		value=0
	elseif value >100.0
		value=100
	endIf
	StorageUtil.SetFloatValue(Mother, "FW.UnbornHealth",value)
	if PlayerRef == Mother
		System.Player.checkAbortus()
		BabyHealthWidget.showTimed(Mother)
	else
		SendModEvent("BeeingFemale","CheckAbortus",Mother.GetFormID())
	endIf
endFunction


; This function will heal the unborn child of the given mother
function HealBaby(actor Mother,float Healing)
	;System.Trace("FWController.HealBaby",Mother) ;Tkc (Loverslab) optimization
	If (StorageUtil.FormListFind(none,"FW.SavedNPCs",Mother)<0)
		;CreateFemaleActor(Mother)
		return; never was initialised - so can't be pregnant
	EndIf
	if StorageUtil.GetIntValue(Mother, "FW.Abortus",0)>1
		; Abortus has already been started
		return
	endif
	int s = StorageUtil.GetIntValue(Mother,"FW.CurrentState",0)
	if s<4 && s==8
		; Not pregnant or in replenish
		return
	endif
	float hp = StorageUtil.GetFloatValue(Mother, "FW.UnbornHealth",100.0)
	
	
	int num_babies_orig = StorageUtil.FormListCount(Mother, "FW.ChildFather")
	if num_babies_orig <= 0
		return
	endif
	actor Father = none
	float DamageScaleByFather = 0
	float HealingScaleByFather = 0
		
	int num_babies = num_babies_orig
	while(num_babies > 0)
		num_babies -= 1
		Father = (StorageUtil.FormListGet(Mother, "FW.ChildFather", num_babies) As Actor)
		DamageScaleByFather += Manager.ActorBabyDamageScaleByFather(Father)
		HealingScaleByFather += Manager.ActorBabyHealingScaleByFather(Father)
	endWhile
		

	if Healing>0
		Healing *= ((Manager.ActorBabyHealingScale(Mother)) * HealingScaleByFather / num_babies_orig)
	else
		Healing *= ((Manager.ActorBabyDamageScale(Mother)) * DamageScaleByFather / num_babies_orig)
	endif
	if hp + Healing < 0.0
		hp=0.0
	elseif hp + Healing >100.0
		hp=100.0
	else
		hp+=Healing
	endIf
	StorageUtil.SetFloatValue(Mother, "FW.UnbornHealth",hp)
	if PlayerRef == Mother
		System.Player.checkAbortus()
	else
		SendModEvent("BeeingFemale","CheckAbortus",Mother.GetFormID())
	endIf
endFunction


; This function will force an abortus to the given mother
function AbortusBaby(actor Mother)
	;System.Trace("FWController.AbortusBaby",Mother)
	If (StorageUtil.FormListFind(none,"FW.SavedNPCs",Mother)<0)
		;CreateFemaleActor(Mother)
		return; never was initialised - so can't be pregnant
	EndIf
	int s = StorageUtil.GetIntValue(Mother,"FW.CurrentState",0)
	if s<4 && s==8
		; Not pregnant or in replenish
		return
	endif
	if StorageUtil.GetIntValue(Mother, "FW.NumChilds",0)>0
		StorageUtil.SetFloatValue(Mother, "FW.UnbornHealth",0.0)
		StorageUtil.SetIntValue(Mother, "FW.Abortus",2)
		StorageUtil.SetFloatValue(Mother, "FW.AbortusTime", GameDaysPassed.GetValue())
		StorageUtil.SetFloatValue(Mother,"FW.LastConception", 0.0)
		if PlayerRef == Mother
			System.Player.checkAbortus()
		else
			SendModEvent("BeeingFemale","CheckAbortus",Mother.GetFormID())
		endIf
	endif
endFunction
function AbortusBabyTimed(actor Mother,Float Time)
	;System.Trace("FWController.AbortusBabyTimed",Mother)
	If (StorageUtil.FormListFind(none,"FW.SavedNPCs",Mother)<0)
		;CreateFemaleActor(Mother)
		return; never was initialised - so can't be pregnant
	EndIf
	int s = StorageUtil.GetIntValue(Mother,"FW.CurrentState",0)
	if s<4 && s==8
		; Not pregnant or in replenish
		return
	endif
	if StorageUtil.GetIntValue(Mother, "FW.NumChilds",0)>0
		StorageUtil.SetFloatValue(Mother, "FW.UnbornHealth",0.0)
		StorageUtil.SetIntValue(Mother, "FW.Abortus",2)
		StorageUtil.SetFloatValue(Mother, "FW.AbortusTime", Time)
		StorageUtil.SetFloatValue(Mother,"FW.LastConception", 0.0)
		if PlayerRef == Mother
			System.Player.checkAbortus()
		else
			SendModEvent("BeeingFemale","CheckAbortus",Mother.GetFormID())
		endIf
	endif
endFunction


function AbortusState(actor Mother, int Abortus_State)
	;System.Trace("FWController.AbortusState",Mother)
	If (StorageUtil.FormListFind(none,"FW.SavedNPCs",Mother)<0)
		;CreateFemaleActor(Mother)
		return; never was initialised - so can't be pregnant
	EndIf
	int s = StorageUtil.GetIntValue(Mother,"FW.CurrentState",0)
	if s<4 && s==8
		; Not pregnant or in replenish
		return
	endif
	if StorageUtil.GetIntValue(Mother, "FW.NumChilds",0)>0
		StorageUtil.SetFloatValue(Mother, "FW.UnbornHealth",0.0)
		StorageUtil.SetIntValue(Mother, "FW.Abortus",Abortus_State)
		StorageUtil.SetFloatValue(Mother, "FW.AbortusTime", GameDaysPassed.GetValue())
		StorageUtil.SetFloatValue(Mother,"FW.LastConception", 0.0)
		if PlayerRef == Mother
			System.Player.checkAbortus()
		else
			SendModEvent("BeeingFemale","CheckAbortus",Mother.GetFormID())
		endIf
	endif
endFunction

function AbortusStateTimed(actor Mother, float Time, int Abortus_State)
	;System.Trace("FWController.AbortusStateTimed",Mother)
	If (StorageUtil.FormListFind(none,"FW.SavedNPCs",Mother)<0)
		;CreateFemaleActor(Mother)
		return; never was initialised - so can't be pregnant
	EndIf
	int s = StorageUtil.GetIntValue(Mother,"FW.CurrentState",0)
	if s<4 && s==8
		; Not pregnant or in replenish
		return
	endif
	if StorageUtil.GetIntValue(Mother, "FW.NumChilds",0)>0
		StorageUtil.SetFloatValue(Mother, "FW.UnbornHealth",0.0)
		StorageUtil.SetIntValue(Mother, "FW.Abortus",Abortus_State)
		StorageUtil.SetFloatValue(Mother, "FW.AbortusTime", Time)
		StorageUtil.SetFloatValue(Mother,"FW.LastConception", 0.0)
		if PlayerRef == Mother
			System.Player.checkAbortus()
		else
			SendModEvent("BeeingFemale","CheckAbortus",Mother.GetFormID())
		endIf
	endif
endFunction


; This function will add sperm to the given mother from the given father
function AddSperm(actor Woman, actor PotentialFather, float amount = 1.0)
	;System.Trace("FWController.AddSperm",Woman)
	If (StorageUtil.FormListFind(none,"FW.SavedNPCs",Woman)<0)
		CreateFemaleActor(Woman)
	EndIf
	; Set last Sex-Time
	StorageUtil.SetFloatValue(Woman, "FW.LastSexTime", GameDaysPassed.GetValue())
	StorageUtil.SetFloatValue(PotentialFather, "FW.LastSexTime", GameDaysPassed.GetValue())

	; Add sperm to woman
	float tmp_amount=amount * Manager.ActorSpermAmountScale(PotentialFather)
	bool bLoreFriendly = System.CheckIsLoreFriendlyMetting(Woman, PotentialFather)
	if bLoreFriendly ;Tkc (Loverslab) optimization
	else;if !bLoreFriendly
		tmp_amount=Sperm_Amount_For_Delete ; Not lore friendly - sperm can't impregnate
	endif
	race fatherRace = none
	if PotentialFather
		fatherRace = PotentialFather.GetRace()
	endif
	FW_log.WriteLog("FWController.AddSperm: donor=" + PotentialFather + ", race=" + fatherRace + ", amount=" + tmp_amount + ", loreFriendly=" + bLoreFriendly + ", creatureSperm=" + cfg.CreatureSperm + ", spermDuration=" + cfg.SpermDuration + ", washOutDelay=" + cfg.WashOutHourDelay)
	StorageUtil.FloatListAdd(Woman,"FW.SpermTime", GameDaysPassed.GetValue())
	FWUtility.AddSpermMirror(Woman, PotentialFather)
	StorageUtil.FloatListAdd(Woman,"FW.SpermAmount", tmp_amount)

	ApplySemenCircleTattoo(Woman)
	ApplyWombTattoo(Woman)

	; If the player is the Male Actor, show the stats widget
	if PotentialFather==PlayerRef
		StateWidget.showTimed(PotentialFather)
	endif
endFunction

float function GetDaysSinceLastSex(actor a)
	float LastSexTime = 0.0
	float L1 = StorageUtil.FloatListGet(a, "SexLabSkills", 17)
	float L2 = StorageUtil.GetFloatValue(a, "FW.LastSexTime")
	if L1>L2
		LastSexTime = L1
	else
		LastSexTime = L2
	endif
	return GameDaysPassed.GetValue() - LastSexTime
endFunction

float function GetLastSexTime(actor a)
	float L1 = StorageUtil.FloatListGet(a, "SexLabSkills", 17)
	float L2 = StorageUtil.GetFloatValue(a, "FW.LastSexTime")
	if L1>L2
		return L1
	else
		return L2
	endif
endFunction

; This function will add sperm to the given mother from the given father
function AddSpermTimed(actor Woman, float Time, actor PotentialFather, float amount = 1.0)
	;System.Trace("FWController.AddSpermTimed",Woman)
	If (StorageUtil.FormListFind(none,"FW.SavedNPCs",Woman)<0)
		CreateFemaleActor(Woman)
	EndIf
	; Set last Sex-Time
	StorageUtil.SetFloatValue(Woman, "FW.LastSexTime", GameDaysPassed.GetValue())
	StorageUtil.SetFloatValue(PotentialFather, "FW.LastSexTime", GameDaysPassed.GetValue())
	
	; Add sperm to woman
	float tmp_amount=amount * Manager.ActorSpermAmountScale(PotentialFather)
	if System.CheckIsLoreFriendlyMetting(Woman, PotentialFather) ;Tkc (Loverslab) optimization
	else;if !System.CheckIsLoreFriendlyMetting(Woman, PotentialFather)
		tmp_amount=Sperm_Amount_For_Delete ; Not lore friendly - sperm can't impregnate
	endif
	StorageUtil.FloatListAdd(Woman,"FW.SpermTime", Time)
	FWUtility.AddSpermMirror(Woman, PotentialFather)
	StorageUtil.FloatListAdd(Woman,"FW.SpermAmount", tmp_amount)

	ApplySemenCircleTattoo(Woman)
	ApplyWombTattoo(Woman)

	; If the player is the Male Actor, show the stats widget
	if PotentialFather==PlayerRef
		StateWidget.showTimed(PotentialFather)
	endif
endFunction


; This function will remove all sperm from the given woman she got from the given 'potential father'
function RemoveSperm(actor Woman, actor PotentialFather)
	;System.Trace("FWController.RemoveSperm",Woman)
	If (StorageUtil.FormListFind(none,"FW.SavedNPCs",Woman)<0)
		return;
	EndIf
	int c= StorageUtil.FormListCount(woman, "FW.SpermName");StorageUtil.FormListCount(Woman,"FW.SpermName")
	while c>0
		c-=1
		if StorageUtil.FormListGet(Woman,"FW.SpermName",c)==PotentialFather
			FWUtility.RemoveSpermMirrorAt(Woman, c)
		EndIf
	endWhile
endFunction


; This function will remove all sperm from the given woman
function RemoveAllSperm(actor Woman)
	;System.Trace("FWController.RemoveAllSperm",Woman)
	If (StorageUtil.FormListFind(none,"FW.SavedNPCs",Woman)<0)
		return
	EndIf
	FWUtility.ClearSpermMirror(Woman)
endFunction


; This function will change the state to the given state
; If the woman is not pregnant: 0 = Fullicular Phase; 1 = Ovulation; 2 = Luteal Phase; 3 = Menstruation
; If the woman is pregnant: 0 = 1st Trimester; 1 = 2nd Trimester; 2 = 3rd Trimester; 3 = Labor Pains; 4 = Replanish
; Changing to replanish will automaticle unimpregnate the woman
function ChangeState(actor female, int state_number)
	;System.Trace("FWController.ChangeState",female)
	If (StorageUtil.FormListFind(none,"FW.SavedNPCs",female)<0)
		CreateFemaleActor(female)
	EndIf
	;if female!=PlayerRef && System.cfg.NPCCanBecomePregnant==false && state_number>=4 && state_number <10
	if female==PlayerRef ;Tkc (Loverslab) optimization
	else;if female!=PlayerRef
		if cfg.NPCCanBecomePregnant
		else;if System.cfg.NPCCanBecomePregnant==false
			if state_number>=4
				if state_number <10
					return
				endif
			endif
		endif
	endif
	
	int abortus = StorageUtil.GetIntValue(female, "FW.Abortus",0)
	;                 Trimester 1        Trimester 2        Trimester 3                            Labor pains
	if (abortus > 1 && (state_number==4 || state_number==5 || state_number==6)) || (abortus > 2 && state_number==7)
		; Failed to change state - woman got an abortus
		return
	endif
	
	StorageUtil.SetIntValue(female,"FW.CurrentState",state_number)
	StorageUtil.SetFloatValue(female,"FW.StateEnterTime", GameDaysPassed.GetValue())

	setIrregulation(female, state_number)

	if PlayerRef == female
		StateWidget.showTimed(true)
		; Drive the magic-effect state machine instead of just poking the int
		; property — otherwise Self.GetState(), nextState, CME spell rotation
		; and onEnterState/onExitState all stay desynced from FW.CurrentState.
		if System.Player
			System.Player.changeState(state_number)
		endif
	else
		SendModEvent("BeeingFemale","Update", female.GetFormID())
	endIf
	UpdateParentFaction(female)
endFunction

function setIrregulation(actor female,int state_number)
	;System.Trace("FWController.setIrregulation", female)
	float newIrregulation=1.0
	if System.IrregulationChance(female, state_number) > Utility.RandomFloat(0,1.01)
		newIrregulation*=System.IrregulationValue(female, state_number)
	endif
	StorageUtil.SetFloatValue(female,"FW.Irregulation",newIrregulation)
endfunction


function ChangeStateTimed(actor female, float Time, int state_number)
	;System.Trace("FWController.ChangeStateTimed",female)
	If (StorageUtil.FormListFind(none,"FW.SavedNPCs",female)<0)
		CreateFemaleActor(female)
	EndIf
	
	;if female!=PlayerRef && System.cfg.NPCCanBecomePregnant==false && state_number>=4 && state_number <10
	if female==PlayerRef ;Tkc (Loverslab) optimization
	else;if female!=PlayerRef
		if cfg.NPCCanBecomePregnant
		else;if System.cfg.NPCCanBecomePregnant==false
			if state_number>=4
				if state_number <10
					return
				endif
			endif
		endif
	endif
	setIrregulation(female, state_number)
	StorageUtil.SetIntValue(female,"FW.CurrentState",state_number)
	StorageUtil.SetFloatValue(female,"FW.StateEnterTime", Time)
	if PlayerRef == female
		System.Player.currentState = state_number
		System.Player.stateEnterTime = Time
	else
		SendModEvent("BeeingFemale","Update", female.GetFormID())
	endIf
	UpdateParentFaction(female)
endFunction


int function GetNextState(actor female)
	If (StorageUtil.FormListFind(none,"FW.SavedNPCs",female)<0)
		CreateFemaleActor(female)
	EndIf
	int cs = GetFemaleState(female)
	if(cs==0 || cs==1 || cs==2) ; folikel phase
		return cs+1
	elseif(cfg.NPCCanBecomePregnant;/==true/; || PlayerRef == female) && cs < 7 && cs > 3
		return cs+1
	else ; Replanish, Menstruating and disabled NPC Pregnancy
		return 0
	endif
endFunction


; Return if the actor is paused
bool function IsPaused(actor Woman)
	;System.Trace("FWController.IsPaused", Woman)
	return StorageUtil.GetFloatValue(Woman, "FW.PauseTime", 0.0)>0
endfunction


; Pause the given actor
function Pause(actor Woman, bool bPaused)
	;System.Trace("FWController.Pause", Woman)
	if bPaused;/==true/;
		StorageUtil.SetFloatValue(Woman, "FW.PauseTime", GameDaysPassed.GetValue())
		if Woman == PlayerRef
			System.Player.PauseStartTime=GameDaysPassed.GetValue()
		endIf
	else
		float start = StorageUtil.GetFloatValue(Woman, "FW.StateEnterTime",0)
		float pause = StorageUtil.GetFloatValue(Woman, "FW.PauseTime",0)
		StorageUtil.UnsetFloatValue(Woman, "FW.PauseTime")
		float cur = start + (GameDaysPassed.GetValue() - pause)
		StorageUtil.SetFloatValue(Woman, "FW.StateEnterTime", cur)
		if PlayerRef == Woman
			System.Player.stateEnterTime = cur
			System.Player.PauseStartTime = 0
		else
			SendModEvent("BeeingFemale","Update", Woman.GetFormID())
		endIf
	endif
endfunction


; Check if the woman got relevant sperm for impregnation inside
bool function HasRelevantSperm(actor Woman, bool bShowTravelingSperm = false)
	;System.Trace("FWController.HasRelevantSperm", Woman)
	return HasRelevantSpermTimed(Woman, GameDaysPassed.GetValue(),bShowTravelingSperm)
endFunction


; Returns the number of relevant actors that have sperm inside
int function RelevantSpermCount(actor Woman, bool bShowTravelingSperm = false)
	;System.Trace("FWController.RelevantSpermCount", Woman)
	return RelevantSpermCountTimed(Woman, GameDaysPassed.GetValue(), bShowTravelingSperm)
endFunction


; Get a list of actors that are most relevant
actor[] function GetRelevantSpermActors(actor Woman, bool bShowTravelingSperm = false, bool bSort=true)
	;System.Trace("FWController.GetRelevantSpermActors", Woman)
	return GetRelevantSpermActorsTimed(Woman, GameDaysPassed.GetValue(), bShowTravelingSperm, bSort)
endfunction


;
float[] function GetRelevantSpermFloat(actor Woman, bool bShowTravelingSperm = false, bool bSort=true)
	;System.Trace("FWController.GetRelevantSpermFloat", Woman)
	return GetRelevantSpermFloatTimed(Woman, GameDaysPassed.GetValue(), bShowTravelingSperm, bSort)
endFunction


; Check if the woman got relevant sperm for impregnation inside at the given time
bool function HasRelevantSpermTimed(actor woman,float Time, bool bShowTravelingSperm = false)
	;System.Trace("FWController.HasRelevantSpermTimed", woman)
	If (StorageUtil.FormListFind(none,"FW.SavedNPCs",woman)<0)
		CreateFemaleActor(woman)
	EndIf
	int c = StorageUtil.FormListCount(woman, "FW.SpermName") ;StorageUtil.FloatListCount(woman, "FW.SpermName")
	;FW_log.WriteLog("HasRelevantSpermTimed "+woman.GetLeveledActorBase().GetName()+" info")
	;FW_log.WriteLog("Check "+c+"Entries")
	while c>0
		c-=1
		float STime = StorageUtil.FloatListGet(woman, "FW.SpermTime", c)
		actor SName = (StorageUtil.FormListGet(woman, "FW.SpermName", c) As Actor)
		float SAmou = StorageUtil.FloatListGet(woman, "FW.SpermAmount", c)
		;FW_log.WriteLog("Sperm["+c+"] is from "+SName.GetLeveledActorBase().GetName())
		;FW_log.WriteLog(STime+" + "+System.getMaleSpermDuration(SName)+" > "+Time+" && ("+STime+" + "+System.cfg.WashOutHourDelay+" < "+Time+" || "+bShowTravelingSperm+") && "+SAmou+" > 0.01")
		;FW_log.WriteLog((STime+System.getMaleSpermDuration(SName))+" > "+Time+" && ("+(STime+System.cfg.WashOutHourDelay)+" < "+Time+" || "+bShowTravelingSperm+") && "+SAmou+" > 0.01")
		;FW_log.WriteLog((STime+System.getMaleSpermDuration(SName)>Time)+" && ("+(STime+System.cfg.WashOutHourDelay<Time)+" || "+bShowTravelingSperm+") && "+(SAmou>0.01))
		
		;if STime + System.getMaleSpermDuration(SName) > Time && (STime+System.cfg.WashOutHourDelay < Time || bShowTravelingSperm) && SAmou>=Sperm_Min_Amount_For_Impregnation && System.CheckIsLoreFriendlyMetting(woman, SName)
		if STime + System.getMaleSpermDuration(SName) > Time ;Tkc (Loverslab) optimization
			if (STime+cfg.WashOutHourDelay < Time || bShowTravelingSperm)
				if SAmou>=Sperm_Min_Amount_For_Impregnation
					; If actor is None (unloaded creature), still count as relevant — skip lore check
					if SName == none || System.CheckIsLoreFriendlyMetting(woman, SName)
						return true
					endIf
				endIf
			endIf
		endIf
	endWhile
	return false
endFunction


; Returns the number of relevant actors that have sperm inside at the given time
int function RelevantSpermCountTimed(actor woman,float Time, bool bShowTravelingSperm = false)
	;System.Trace("FWController.RelevantSpermCountTimed", woman)
	If (StorageUtil.FormListFind(none,"FW.SavedNPCs",woman)<0)
		CreateFemaleActor(woman)
	EndIf
	int c = StorageUtil.FormListCount(woman, "FW.SpermName") ;StorageUtil.FormListCount(woman, "FW.SpermName")
	int j = 0
	while c>0
		c-=1
		float STime = StorageUtil.FloatListGet(woman, "FW.SpermTime", c)
		actor SName = (StorageUtil.FormListGet(woman, "FW.SpermName", c) As Actor)
		float SAmou = StorageUtil.FloatListGet(woman, "FW.SpermAmount", c)
		if STime + System.getMaleSpermDuration(SName) > Time && (STime+cfg.WashOutHourDelay < Time || bShowTravelingSperm) && SAmou>=Sperm_Min_Amount_For_Impregnation && System.CheckIsLoreFriendlyMetting(woman, SName)
			j+=1
		endIf
	endWhile
	return j
endFunction


; Get a list of actors that are most relevant at the given time
actor[] function GetRelevantSpermActorsTimed(actor woman,float Time, bool bShowTravelingSperm = false, bool bSort = true)
	;System.Trace("FWController.GetRelevantSpermActorsTimed", woman)
	If (StorageUtil.FormListFind(none,"FW.SavedNPCs",woman)<0)
		CreateFemaleActor(woman)
	EndIf
	int c = StorageUtil.FormListCount(woman, "FW.SpermName");StorageUtil.FormListCount(woman, "FW.SpermName")
	actor[] actors
	bool bFirst=true
	if c ;Tkc (Loverslab) optimization
	else;if c==0
		return actors
	endif
	if bSort==false || c==1
		while c>0
			c-=1
			float STime = StorageUtil.FloatListGet(woman, "FW.SpermTime", c)
			actor SName = (StorageUtil.FormListGet(woman, "FW.SpermName", c) As Actor)
			float SAmou = StorageUtil.FloatListGet(woman, "FW.SpermAmount", c)
			float maxSDuration = System.getMaleSpermDuration(SName)
			if SName!=none
				;FW_log.WriteLog("Sperm["+c+"] is from "+SName.GetLeveledActorBase().GetName())
				;FW_log.WriteLog(STime+" + "+maxSDuration+" > "+Time+" && ("+STime+" + "+System.cfg.WashOutHourDelay+" < "+Time+" || "+bShowTravelingSperm+") && "+SAmou+" > "+0.01)
				;FW_log.WriteLog((STime + maxSDuration)+" > "+Time+" && ("+(STime+System.cfg.WashOutHourDelay)+" < "+Time+" || "+bShowTravelingSperm+") && "+SAmou+" > 0.01")
				;FW_log.WriteLog((STime + maxSDuration > Time)+" && ("+(STime+System.cfg.WashOutHourDelay < Time)+" || "+bShowTravelingSperm+") && "+(SAmou>0.01))

				if STime + maxSDuration > Time && (STime+cfg.WashOutHourDelay < Time || bShowTravelingSperm;/==true/;) && SAmou>=Sperm_Min_Amount_For_Impregnation && System.CheckIsLoreFriendlyMetting(woman, SName)
					;FWUtility.ActorArrayAppend(actors, SName)
					if bFirst;/==true/;
						actors=new Actor[1]
						actors[0]=SName
						bFirst=false
					else
						;sslUtility.PushActor(SName,actors)
						actors=FWUtility.ActorArrayAppend(actors, SName)
					endif
				endif
			elseif STime + maxSDuration <= Time
				; Actor gone and sperm expired — safe to clean up
				FWUtility.RemoveSpermMirrorAt(woman, c)
			endif
		endwhile
	else
		float[] actorr
		while c>0
			c-=1
			float STime = StorageUtil.FloatListGet(woman, "FW.SpermTime", c)
			actor SName = (StorageUtil.FormListGet(woman, "FW.SpermName", c) As Actor)
			float SAmou = StorageUtil.FloatListGet(woman, "FW.SpermAmount", c)
			float maxSDuration = System.getMaleSpermDuration(SName)
			if SName!=none
				;FW_log.WriteLog("Sperm["+c+"] is from "+SName.GetLeveledActorBase().GetName())
				;FW_log.WriteLog(STime+" + "+maxSDuration+" > "+Time+" && ("+STime+" + "+System.cfg.WashOutHourDelay+" < "+Time+" || "+bShowTravelingSperm+") && "+SAmou+" > "+0.01)
				;FW_log.WriteLog((STime + maxSDuration)+" > "+Time+" && ("+(STime+System.cfg.WashOutHourDelay)+" < "+Time+" || "+bShowTravelingSperm+") && "+SAmou+" > 0.01")
				;FW_log.WriteLog((STime + maxSDuration > Time)+" && ("+(STime+System.cfg.WashOutHourDelay < Time)+" || "+bShowTravelingSperm+") && "+(SAmou>0.01))
			
				if STime + maxSDuration > Time && (STime+cfg.WashOutHourDelay < Time || bShowTravelingSperm;/==true/;) && SAmou>=Sperm_Min_Amount_For_Impregnation && System.CheckIsLoreFriendlyMetting(woman, SName)
					float SpermDurationPercent = (Time - STime) / maxSDuration
					float xScale = 1.0
					if SpermDurationPercent>0.65
						xScale-=SpermDurationPercent - 0.65
					endIf
					;FWUtility.ActorArrayAppend(actors, SName)
					;FWUtility.FloatArrayAppend(actorr, System.GetSpermRelevance(woman, SName) * SAmou * xScale)
					if bFirst;/==true/;
						actors=new Actor[1]
						actors[0]=SName
						actorr=new Float[1]
						actorr[0]=System.GetSpermRelevance(woman, SName) * SAmou * xScale
						bFirst=false
					else
						;sslUtility.PushActor(SName,actors)
						;sslUtility.PushFloat(System.GetSpermRelevance(woman, SName) * SAmou * xScale,actorr)
						actors=FWUtility.ActorArrayAppend(actors, SName)
						actorr=FWUtility.FloatArrayAppend(actorr, System.GetSpermRelevance(woman, SName) * SAmou * xScale)
					endif
				endif
			elseif STime + maxSDuration <= Time
				FWUtility.RemoveSpermMirrorAt(woman, c)
			endif
		endwhile

		int bi=1
		int bj
		int bc=actors.length ; Count
		bool bl=true ; Flag
		actor ba ; Temp
		float bf ; Temp
		while bi<=bc && bl
			bl=false
			bj=0
			while bj<bc - 1
				if actorr[bj+1]>actorr[bj]
					ba=actors[bj]
					actors[bj]=actors[bj+1]
					actors[bj+1]=ba
					bf=actorr[bj]
					actorr[bj]=actorr[bj+1]
					actorr[bj+1]=bf
					bl=true
				endIf
				bj+=1
			endWhile
			bi+=1
		endWhile
	endif
	
	return actors
	
	;int j = 0
	;while c>0
	;	c-=1
	;	float STime = StorageUtil.FloatListGet(woman, "FW.SpermTime", c)
	;	actor SName = (StorageUtil.FormListGet(woman, "FW.SpermName", c) As Actor)
	;	float SAmou = StorageUtil.FloatListGet(woman, "FW.SpermAmount", c)
	;	if STime + System.getMaleSpermDuration(SName) > Time && (STime+System.cfg.WashOutHourDelay < Time || bShowTravelingSperm) && SAmou>0.01
	;		j+=1
	;	endIf
	;endWhile
	;if j>0
	;	actor[] actors = FWUtility.ActorArray(FWUtility.MinInt(64,j))
	;	float[] actorr = FWUtility.FloatArray(actors.length)
	;	int i = 0
	;	if bSort;/==true/;
	;		while i<j && i<actors.length
	;			float STime = StorageUtil.FloatListGet(woman, "FW.SpermTime", c)
	;			actor SName = (StorageUtil.FormListGet(woman, "FW.SpermName", c) As Actor)
	;			float SAmou = StorageUtil.FloatListGet(woman, "FW.SpermAmount", c)
	;			float maxSDuration = System.getMaleSpermDuration(SName)
	;			if STime + maxSDuration > Time && (STime+System.cfg.WashOutHourDelay < Time || bShowTravelingSperm;/==true/;) && SAmou>0.01
	;				float SpermDurationPercent = (Time - STime) / maxSDuration
	;				float xScale = 1.0
	;				if SpermDurationPercent>0.65
	;					xScale-=SpermDurationPercent - 0.65
	;				endIf
	;				actors[i] = SName
	;				actorr[i] = System.GetSpermRelevance(woman, SName) * SAmou * xScale
	;			endIf
	;			i+=1
	;		endWhile
	;	elseif bSort==false
	;		while i<j && i<actors.length
	;			float STime = StorageUtil.FloatListGet(woman, "FW.SpermTime", c)
	;			actor SName = (StorageUtil.FormListGet(woman, "FW.SpermName", c) As Actor)
	;			float SAmou = StorageUtil.FloatListGet(woman, "FW.SpermAmount", c)
	;			float maxSDuration = System.getMaleSpermDuration(SName)
	;			if STime + maxSDuration > Time && (STime+System.cfg.WashOutHourDelay < Time || bShowTravelingSperm;/==true/;) && SAmou>0.01
	;				actors[i] = SName
	;			endIf
	;			i+=1
	;		endWhile
	;	endif
	;	
	;	if bSort==false
	;		return actors
	;	endIf
	;	
	;	; Using Bubble Sort DESC to order by relevance
	;	int bi=1
	;	int bj
	;	int bc=actors.length ; Count
	;	bool bl=true ; Flag
	;	actor ba ; Temp
	;	float bf ; Temp
	;	while bi<=bc && bl
	;		bl=false
	;		bj=0
	;		while bj<bc - 1
	;			if actorr[bj+1]>actorr[bj]
	;				ba=actors[bj]
	;				actors[bj]=actors[bj+1]
	;				actors[bj+1]=ba
	;				bf=actorr[bj]
	;				actorr[bj]=actorr[bj+1]
	;				actorr[bj+1]=bf
	;				bl=true
	;			endIf
	;			bj+=1
	;		endWhile
	;		bi+=1
	;	endWhile
	;
	;	return actors
	;else
	;	return none
	;endIf
endfunction


; Get a list of actors that are most relevant at the given time
float[] function GetRelevantSpermFloatTimed(actor woman,float Time, bool bShowTravelingSperm = false, bool bSort=true)
	;System.Trace("FWController.GetRelevantSpermFloatTimed", woman)
	If (StorageUtil.FormListFind(none,"FW.SavedNPCs",woman)<0)
		CreateFemaleActor(woman)
	EndIf
	int c = StorageUtil.FormListCount(woman, "FW.SpermName");StorageUtil.FormListCount(woman, "FW.SpermAmount")
	float[] actorr
	if c ;Tkc (Loverslab) optimization
	else;if c==0
		return actorr
	endif

	while c>0
		c-=1
		float STime = StorageUtil.FloatListGet(woman, "FW.SpermTime", c)
		actor SName = (StorageUtil.FormListGet(woman, "FW.SpermName", c) As Actor)
		float SAmou = StorageUtil.FloatListGet(woman, "FW.SpermAmount", c)
		float maxSDuration = System.getMaleSpermDuration(SName)
		if SName!=none
			;FW_log.WriteLog("Sperm["+c+"] is from "+SName.GetLeveledActorBase().GetName())
			;FW_log.WriteLog(STime+" + "+maxSDuration+" > "+Time+" && ("+STime+" + "+System.cfg.WashOutHourDelay+" < "+Time+" || "+bShowTravelingSperm+") && "+SAmou+" > "+0.01)
			;FW_log.WriteLog((STime + maxSDuration)+" > "+Time+" && ("+(STime+System.cfg.WashOutHourDelay)+" < "+Time+" || "+bShowTravelingSperm+") && "+SAmou+" > 0.01")
			;FW_log.WriteLog((STime + maxSDuration > Time)+" && ("+(STime+System.cfg.WashOutHourDelay < Time)+" || "+bShowTravelingSperm+") && "+(SAmou>0.01))

			if STime + maxSDuration > Time && (STime+cfg.WashOutHourDelay < Time || bShowTravelingSperm;/==true/;) && SAmou>=Sperm_Min_Amount_For_Impregnation && System.CheckIsLoreFriendlyMetting(woman, SName)
				float SpermDurationPercent = (Time - STime) / maxSDuration
				float xScale = 1.0
				if SpermDurationPercent>0.65
					xScale-=SpermDurationPercent - 0.65
				endIf
				actorr=FWUtility.FloatArrayAppend(actorr, System.GetSpermRelevance(woman, SName) * SAmou * xScale)
			endif
		elseif STime + maxSDuration <= Time
			FWUtility.RemoveSpermMirrorAt(woman, c)
		endif
	endwhile
	; Sort only when ASKED to. This was inverted (sorted when bSort==false),
	; which paired DESC-sorted weights with the insertion-ordered actor array
	; in the impregnation paths - donors got each other's weights.
	if bSort && actorr.length > 1
		int bi=1
		int bj
		int bc=actorr.length ; Count
		bool bl=true ; Flag
		float bf ; Temp
		while bi<=bc && bl
			bl=false
			bj=0
			while bj<bc - 1
				if actorr[bj+1]>actorr[bj]
					bf=actorr[bj]
					actorr[bj]=actorr[bj+1]
					actorr[bj+1]=bf
					bl=true
				endIf
				bj+=1
			endWhile
			bi+=1
		endWhile
	endif
	
	return actorr

	;int c = StorageUtil.FloatListCount(woman, "FW.SpermTime")
	;int j = 0
	;while c>0
	;	c-=1
	;	float STime = StorageUtil.FloatListGet(woman, "FW.SpermTime", c)
	;	actor SName = (StorageUtil.FormListGet(woman, "FW.SpermName", c) As Actor)
	;	float SAmou = StorageUtil.FloatListGet(woman, "FW.SpermAmount", c)
	;	if STime + System.getMaleSpermDuration(SName) > Time && (STime+System.cfg.WashOutHourDelay < Time || bShowTravelingSperm) && SAmou>0.01
	;		j+=1
	;	endIf
	;endWhile
	;if j>0
	;	float[] actorr = FWUtility.FloatArray(FWUtility.MinInt(64,j))
	;	int i = 0
	;	while i<j && i<actorr.length
	;		float STime = StorageUtil.FloatListGet(woman, "FW.SpermTime", c)
	;		actor SName = (StorageUtil.FormListGet(woman, "FW.SpermName", c) As Actor)
	;		float SAmou = StorageUtil.FloatListGet(woman, "FW.SpermAmount", c)
	;		float maxSDuration = System.getMaleSpermDuration(SName) ; Get the Duration the sperm can survive
	;		if STime + maxSDuration > Time && (STime+System.cfg.WashOutHourDelay < Time || bShowTravelingSperm) && SAmou>0.01
	;			float SpermDurationPercent = (Time - STime) / maxSDuration
	;			float xScale = 1.0
	;			if SpermDurationPercent>0.65
	;				xScale-=SpermDurationPercent - 0.65
	;			endIf
	;			actorr[i] = System.GetSpermRelevance(woman, SName) * SAmou * xScale
	;		endIf
	;		i+=1
	;	endWhile
	;	
	;	if bSort==false
	;		return actorr
	;	endIf
	;	
	;	; Using Bubble Sort DESC to order by relevance
	;	int bi=1
	;	int bj
	;	int bc=actorr.length ; Count
	;	bool bl=true ; Flag
	;	float bf ; Temp
	;	while bi<=bc && bl
	;		bl=false
	;		bj=0
	;		while bj<bc - 1
	;			if actorr[bj+1]>actorr[bj]
	;				bf=actorr[bj]
	;				actorr[bj]=actorr[bj+1]
	;				actorr[bj+1]=bf
	;				bl=true
	;			endIf
	;			bj+=1
	;		endWhile
	;		bi+=1
	;	endWhile
	;	
	;	return actorr
	;else
	;	return none
	;endIf
endfunction




; Check for the normal impregnation at the given time, using the sperm, the value if she can become pregnant in this cycle, and so on.
bool function MyActiveSpermImpregnationTimedForAnyPeriod(actor Mother, bool bIgnoreContraception = false)
	;System.Trace("FWController.MyActiveSpermImpregnationTimedForAnyPeriod",Mother)
	float Time = GameDaysPassed.GetValue()
	
	if Mother==PlayerRef ;Tkc (Loverslab) optimization
	else;if Mother!=PlayerRef
		if cfg.NPCCanBecomePregnant
		else;if System.cfg.NPCCanBecomePregnant==false
			return false
		endif
	endif
	bool bCanBecomePregnant=canBecomePregnant(Mother)
	if bCanBecomePregnant ;Tkc (Loverslab) optimization
	else;if bCanBecomePregnant==false
		return false
	endif
	if bIgnoreContraception ;Tkc (Loverslab) optimization
	else;if bIgnoreContraception==false
		ContraceptionSpermKillTimed(Mother,Time)
	endIf

	if HasRelevantSpermTimed(Mother, Time, false)
		if Manager.ActorCanBecomePregnant(Mother);/==true/;
			; Impregnate by active sperm
			int numChild=System.calculateNumChildren(Mother)
			if numChild ;Tkc (Loverslab) optimization
			else;if numChild==0
				return false
			endIf

			actor[] a = MyGetRelevantSpermActorsTimedForAnyPeriod(Mother, Time, false, false)
			float[] relevantSperm = MyGetRelevantSpermFloatTimedForAnyPeriod(Mother, Time, false, false)

			int c = relevantSperm.length
			if c ;Tkc (Loverslab) optimization
			else;if c==0
				return false
			endif
			int i = 0
			float relevanceTotal = 0.0
			while i<c
				relevanceTotal += relevantSperm[i]
				i += 1
			endWhile
			
			StorageUtil.SetIntValue(Mother, "FW.NumChilds", numChild)
			actor[] Fathers = FWUtility.ActorArray(numChild)

			while(numChild > 0)
				numChild -= 1
				; Classic weighted pick - see ActiveSpermImpregnationTimed for the
				; rationale. The old boost-based variant here also still carried
				; the pre-479c2d8 out-of-bounds read (a[j+1] at j == c-1).
				float rnd_r = Utility.RandomFloat(0, relevanceTotal)
				int j = 0
				while (rnd_r >= relevantSperm[j]) && ((j + 1) < c)
					rnd_r -= relevantSperm[j]
					j += 1
				endWhile
				FWUtility.AddChildFather(Mother, a[j])
				Fathers[numChild]=a[j]
			endWhile
			StorageUtil.SetFloatValue(Mother,"FW.UnbornHealth",100.0)
			StorageUtil.UnsetIntValue(Mother,"FW.Abortus")
			StorageUtil.SetFloatValue(Mother,"FW.LastConception", Utility.GetCurrentGameTime())
			Manager.OnImpregnate(Mother, Fathers.length,Fathers)
			; This path was the only conception flow not emitting the public event
			SendConceptionEvent(Mother, Fathers)
			ChangeStateTimed(Mother,Time,4)
			return true
		endIf
	endIf
	
	return false
endFunction

; Get a list of actors that are most relevant at the given time
actor[] function MyGetRelevantSpermActorsTimedForAnyPeriod(actor woman, float Time, bool bShowTravelingSperm = false, bool bSort = true)
	;System.Trace("FWController.MyGetRelevantSpermActorsTimedForAnyPeriod", woman)
	If(StorageUtil.FormListFind(none, "FW.SavedNPCs", woman) < 0)
		CreateFemaleActor(woman)
	EndIf
	int c = StorageUtil.FormListCount(woman, "FW.SpermName");StorageUtil.FormListCount(woman, "FW.SpermName")
	actor[] actors
	bool bFirst = true
	if c ;Tkc (Loverslab) optimization
	else;if c==0
		return actors
	endif

	int my_Impreg_Any = 0
	float my_Impreg_Chance = 0
	race abr = none
	
	if((bSort == false) || (c == 1))
		while(c > 0)
			c -= 1
			float STime = StorageUtil.FloatListGet(woman, "FW.SpermTime", c)
			actor SName = (StorageUtil.FormListGet(woman, "FW.SpermName", c) As Actor)
			float SAmou = StorageUtil.FloatListGet(woman, "FW.SpermAmount", c)
			float maxSDuration = System.getMaleSpermDuration(SName)

			if SName!=none
				; Reset per donor - without this a donor with no any-period
				; permission inherited the previous donor's chance
				my_Impreg_Chance = 0
				my_Impreg_Any = StorageUtil.GetIntValue(SName, "FW.AddOn.Allow_Impregnation_For_Any_Period", -1)
				if(my_Impreg_Any <= 0)
					abr = SName.GetRace()
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
					my_Impreg_Chance = StorageUtil.GetFloatValue(SName, "FW.AddOn.Sperm_Impregnation_Prob_For_Any_Period", 0)
				endIf

				if((my_Impreg_Chance > 0) && ((STime + maxSDuration) > Time) && (((STime + cfg.WashOutHourDelay) < Time) || bShowTravelingSperm;/==true/;) && (SAmou >= Sperm_Min_Amount_For_Impregnation))
					if bFirst;/==true/;
						actors = new Actor[1]
						actors[0] = SName
						bFirst=false
					else
						actors = FWUtility.ActorArrayAppend(actors, SName)
					endif
				endif
			elseif STime + maxSDuration <= Time
				FWUtility.RemoveSpermMirrorAt(woman, c)
			endif
		endwhile
	else
		float[] actorr
		while(c > 0)
			c -= 1
			float STime = StorageUtil.FloatListGet(woman, "FW.SpermTime", c)
			actor SName = (StorageUtil.FormListGet(woman, "FW.SpermName", c) As Actor)
			float SAmou = StorageUtil.FloatListGet(woman, "FW.SpermAmount", c)
			float maxSDuration = System.getMaleSpermDuration(SName)
					
			if SName!=none
				; Reset per donor - without this a donor with no any-period
				; permission inherited the previous donor's chance
				my_Impreg_Chance = 0
				my_Impreg_Any = StorageUtil.GetIntValue(SName, "FW.AddOn.Allow_Impregnation_For_Any_Period", -1)
				if(my_Impreg_Any <= 0)
					abr = SName.GetRace()
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
					my_Impreg_Chance = StorageUtil.GetFloatValue(SName, "FW.AddOn.Sperm_Impregnation_Prob_For_Any_Period", 0)
				endIf

				if((my_Impreg_Chance > 0) && ((STime + maxSDuration) > Time) && (((STime + cfg.WashOutHourDelay) < Time) || bShowTravelingSperm;/==true/;) && (SAmou >= Sperm_Min_Amount_For_Impregnation))
					float SpermDurationPercent = (Time - STime) / maxSDuration
					float xScale = 1.0
					if(SpermDurationPercent > 0.65)
						xScale -= SpermDurationPercent - 0.65
					endIf

					if bFirst;/==true/;
						actors = new Actor[1]
						actors[0] = SName
						actorr = new Float[1]
						actorr[0] = System.GetSpermRelevance(woman, SName) * SAmou * xScale
						bFirst = false
					else
						actors = FWUtility.ActorArrayAppend(actors, SName)
						actorr = FWUtility.FloatArrayAppend(actorr, System.GetSpermRelevance(woman, SName) * SAmou * xScale)
					endif
				endif
			elseif STime + maxSDuration <= Time
				FWUtility.RemoveSpermMirrorAt(woman, c)
			endif
		endwhile

		int bi = 1
		int bj
		int bc = actors.length ; Count
		bool bl = true ; Flag
		actor ba ; Temp
		float bf ; Temp
		while((bi <= bc) && bl)
			bl = false
			bj = 0
			while(bj < bc - 1)
				if(actorr[bj + 1] > actorr[bj])
					ba = actors[bj]
					actors[bj] = actors[bj + 1]
					actors[bj + 1] = ba
					bf = actorr[bj]
					actorr[bj] = actorr[bj + 1]
					actorr[bj + 1] = bf
					bl = true
				endIf
				bj += 1
			endWhile
			bi += 1
		endWhile
	endif
	
	return actors
endfunction

; Get a list of actors that are most relevant at the given time
float[] function MyGetRelevantSpermFloatTimedForAnyPeriod(actor woman, float Time, bool bShowTravelingSperm = false, bool bSort = true)
	;System.Trace("FWController.MyGetRelevantSpermFloatTimedForAnyPeriod", woman)
	If (StorageUtil.FormListFind(none,"FW.SavedNPCs",woman)<0)
		CreateFemaleActor(woman)
	EndIf
	int c = StorageUtil.FormListCount(woman, "FW.SpermName");StorageUtil.FormListCount(woman, "FW.SpermAmount")
	float[] actorr
	if c ;Tkc (Loverslab) optimization
	else;if c==0
		return actorr
	endif
	
	int my_Impreg_Any = 0
	float my_Impreg_Chance = 0
	race abr = none
	
	while(c > 0)
		c -= 1
		float STime = StorageUtil.FloatListGet(woman, "FW.SpermTime", c)
		actor SName = (StorageUtil.FormListGet(woman, "FW.SpermName", c) As Actor)
		float SAmou = StorageUtil.FloatListGet(woman, "FW.SpermAmount", c)
		float maxSDuration = System.getMaleSpermDuration(SName)
		
		if SName!=none
			; Reset per donor - without this a donor with no any-period
			; permission inherited the previous donor's chance
			my_Impreg_Chance = 0
			my_Impreg_Any = StorageUtil.GetIntValue(SName, "FW.AddOn.Allow_Impregnation_For_Any_Period", -1)
			if(my_Impreg_Any <= 0)
				abr = SName.GetRace()
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
				my_Impreg_Chance = StorageUtil.GetFloatValue(SName, "FW.AddOn.Sperm_Impregnation_Prob_For_Any_Period", 0)
			endIf

			if((my_Impreg_Chance > 0) && ((STime + maxSDuration) > Time) && (((STime + cfg.WashOutHourDelay) < Time) || bShowTravelingSperm;/==true/;) && (SAmou >= Sperm_Min_Amount_For_Impregnation) && System.CheckIsLoreFriendlyMetting(woman, SName))
				float SpermDurationPercent = (Time - STime) / maxSDuration
				float xScale = 1.0
				if SpermDurationPercent>0.65
					xScale-=SpermDurationPercent - 0.65
				endIf
				actorr=FWUtility.FloatArrayAppend(actorr, System.GetSpermRelevance(woman, SName) * SAmou * xScale)
			endif
		elseif STime + maxSDuration <= Time
			FWUtility.RemoveSpermMirrorAt(woman, c)
		endif
	endwhile
	; Sort only when ASKED to. This was inverted (sorted when bSort==false),
	; which paired DESC-sorted weights with the insertion-ordered actor array
	; in the impregnation paths - donors got each other's weights.
	if bSort && actorr.length > 1
		int bi=1
		int bj
		int bc=actorr.length ; Count
		bool bl=true ; Flag
		float bf ; Temp
		while bi<=bc && bl
			bl=false
			bj=0
			while bj<bc - 1
				if actorr[bj+1]>actorr[bj]
					bf=actorr[bj]
					actorr[bj]=actorr[bj+1]
					actorr[bj+1]=bf
					bl=true
				endIf
				bj+=1
			endWhile
			bi+=1
		endWhile
	endif
	
	return actorr
endfunction




; Check if the woman got sperm from 'potential father' inside
; If female is none - all saved females will be checked
bool function HasSpermInWoman(actor male, actor female=none, bool bShowTravelingSperm = true)
	;System.Trace("FWController.HasSpermInWoman", male)
	return HasSpermInWomanTimed(male,female, GameDaysPassed.GetValue(), bShowTravelingSperm)
endFunction


; Check if the woman got sperm from 'potential father' inside
; If female is none - all saved females will be checked
bool function HasSpermInWomanTimed(actor male, actor female=none, float Time, bool bShowTravelingSperm = true)
	;System.Trace("FW Debug: FWController.HasSpermInWomanTimed", male)
	If (StorageUtil.FormListFind(none,"FW.SavedNPCs",female)<0) && female;/!=none/;
		CreateFemaleActor(female)
	EndIf
	float SpermDuration = System.getMaleSpermDuration(male)
	if female ;Tkc (Loverslab) optimization: swapped checks
		int i = StorageUtil.FormListFind(female,"FW.SpermName",male)
		if i >=0
			int j= StorageUtil.FormListCount(female, "FW.SpermName");StorageUtil.FormListCount(female,"FW.SpermName")
			while j>0
				j-=1
				if StorageUtil.FormListGet(female,"FW.SpermName",j)==male
					; Found sperm from the male - now check if the time is relevant
					float STime=StorageUtil.FloatListGet(female,"FW.SpermTime",j)
					if STime+SpermDuration > Time && (STime+cfg.WashOutHourDelay < Time || bShowTravelingSperm)
						return true
					endIf
				endIf
			endWhile
		endIf
	else;!female
		int femaleCount= StorageUtil.FormListCount(none,"FW.SavedNPCs")
		while femaleCount>0
			femaleCount-=1
			actor tmpFemale= StorageUtil.FormListGet(none,"FW.SavedNPCs",femaleCount) as Actor
			int i = StorageUtil.FormListFind(tmpFemale,"FW.SpermName",male)
			if i >0 ;Tkc (Loverslab) optimization
				int j=StorageUtil.FormListCount(tmpFemale, "FW.SpermName");StorageUtil.FormListCount(tmpFemale,"FW.SpermName")
				while j>0
					j-=1
					if StorageUtil.FormListGet(tmpFemale,"FW.SpermName",j)==male
						; Found sperm from the male - now check if the time is relevant
						float STime=StorageUtil.FloatListGet(tmpFemale,"FW.SpermTime",j)
						if STime+SpermDuration > Time && (STime+cfg.WashOutHourDelay < Time || bShowTravelingSperm)
							return true
						endIf
					endIf
				endWhile
			endIf
		endWhile
	endIf
	return false
endFunction

; Returns all actors the woman came has sperm inside
; When "bShowTravelingSperm" is false, only the sperms that can impregnate the woman will be shown
actor[] function getWomansWithSperm(actor Male, bool bShowTravelingSperm = true)
	;System.Trace("FWController.getWomansWithSperm",Male)
	return getWomansWithSpermTimed(Male, GameDaysPassed.GetValue(), bShowTravelingSperm)
endfunction

; Returns all actors the woman came has sperm inside at the given time
; When "bShowTravelingSperm" is false, only the sperms that can impregnate the woman will be shown
Actor[] function getWomansWithSpermTimed(actor Male, float Time, bool bShowTravelingSperm = true)
	;System.Trace("FWController.getWomansWithSpermTimed", Male)
	float SpermDuration = System.getMaleSpermDuration(male)
	Actor[] tmp=new Actor[128]
	int femaleCount= StorageUtil.FormListCount(none,"FW.SavedNPCs")
	int i=0
	int c=0
	while i<femaleCount && c <128
		actor woman = StorageUtil.FormListGet(none,"FW.SavedNPCs",i) as actor
		if StorageUtil.FormListFind(woman,"FW.SpermName", Male)>=0
			; Got sperm inside
			int j= StorageUtil.FormListCount(woman, "FW.SpermName");StorageUtil.FormListCount(woman,"FW.SpermName")
			while j>0 && c <128
				j-=1
				if StorageUtil.FormListGet(woman,"FW.SpermName",j)==male
					float STime=StorageUtil.FloatListGet(woman,"FW.SpermTime",j)
					if STime+SpermDuration > Time && (STime+cfg.WashOutHourDelay < Time || bShowTravelingSperm)
						tmp[c]=woman
						c+=1
						j=0
					endIf
				endif
			endwhile
		endif
		i+=1
	endwhile
	Actor[] res= FWUtility.ActorArray(c)
	i=0
	while i<c
		res[i]=tmp[i]
		i+=1
	endwhile
	return res
endfunction

; Returns the percent value of the womans currenr phase
; Range is from 0.0 to 1.0 (1.0 = 100%)
Float Function GetStatePercentage(Actor woman)
	;System.Trace("FWController.GetStatePercentage", Woman)
	If (StorageUtil.FormListFind(none,"FW.SavedNPCs",woman)<0)
		CreateFemaleActor(woman)
	EndIf
	int stateID = StorageUtil.GetIntValue(woman, "FW.CurrentState",0)
	Float duration = System.GetStateDuration(stateID, woman)
	If duration > 0.0
		Return (GameDaysPassed.GetValue() - GetStateEnterTime(woman)) / duration
	EndIf
	
	Return 0.0
EndFunction

; Returns the Game-Time the woman enters the current phase
Float Function GetStateEnterTime(Actor woman)
	;System.Trace("FWController.GetStateEnterTime",woman)
	If (StorageUtil.FormListFind(none,"FW.SavedNPCs",woman)<0)
		CreateFemaleActor(woman)
	EndIf	
	Return StorageUtil.GetFloatValue(woman, "FW.StateEnterTime")
EndFunction


; Returns the health of the unborn child
float function GetBabyHealth(actor woman)
	;System.Trace("GetBabyHealth",woman)
	If (StorageUtil.FormListFind(none,"FW.SavedNPCs",woman)<0)
		CreateFemaleActor(woman)
	EndIf
	return StorageUtil.GetFloatValue(woman,"FW.UnbornHealth",100.0)
endFunction


; returns if the mother is pregnant
bool function IsPregnant(actor woman)
	;System.Trace("FWController.IsPregnant",woman)
	If (StorageUtil.FormListFind(none,"FW.SavedNPCs",woman)<0)
		CreateFemaleActor(woman)
	EndIf
	return StorageUtil.GetIntValue(woman,"FW.CurrentState",0)>=4
endFunction


; returns the state the woman is in
int function GetFemaleState(actor woman)
	;System.Trace("FWController.GetFemaleState",woman)
	If (StorageUtil.FormListFind(none,"FW.SavedNPCs",woman)<0)
		CreateFemaleActor(woman)
	EndIf
	return StorageUtil.GetIntValue(woman,"FW.CurrentState",0)
endFunction


; returns the number of birth the actor already gave
int function GetNumBirth(actor woman)
	;System.Trace("FWController.GetNumBirth",woman)
	If (StorageUtil.FormListFind(none,"FW.SavedNPCs",woman)<0)
		CreateFemaleActor(woman)
	EndIf
	return StorageUtil.GetIntValue(woman,"FW.NumBirth",0)
endFunction


; Open a MessageBox with all informations
function showInfoBox(actor a)
	;System.Trace("FWController.showInfoBox",a)
	showRankedInfoBox(a,100)
endFunction


; Set the "can become pregnant" flag
; Returns the Flag value
int function setCanBecomePregnant(actor woman, bool bActive)
	;System.Trace("FWController.setCanBecomePregnant", woman)
	If (StorageUtil.FormListFind(none,"FW.SavedNPCs",woman)<0)
		CreateFemaleActor(woman)
	EndIf
	int flag = StorageUtil.GetIntValue(woman, "FW.Flags",0)
	if Math.LogicalAnd(flag,1)==1 && bActive==false
		; Remove flag
		Flag -= 1
	else;if Math.LogicalAnd(flag,1)!=1 && bActive;/==true/;
		if bActive
			if Math.LogicalAnd(flag,1)==1 ;Tkc (Loverslab) optimization
			else;if Math.LogicalAnd(flag,1)!=1
				; Add Flag
				Flag += 1
			endif
		endif
	endif
	StorageUtil.SetIntValue(woman, "FW.Flags",flag)
	return flag
endFunction


; Set the "can become pms" flag
; Returns the Flag value
int function setCanBecomePMS(actor woman, bool bActive)
	;System.Trace("FWController.setCanBecomePMS",woman)
	If (StorageUtil.FormListFind(none,"FW.SavedNPCs",woman)<0)
		CreateFemaleActor(woman)
	EndIf
	int flag = StorageUtil.GetIntValue(woman, "FW.Flags",0)
	if Math.LogicalAnd(flag,2)==2 && bActive==false
		; Remove flag
		Flag -= 2
	else;if Math.LogicalAnd(flag,2)!=2 && bActive;/==true/;
		if bActive;/==true/; ;Tkc (Loverslab) optimization
			if Math.LogicalAnd(flag,2)==2
			else;if Math.LogicalAnd(flag,2)!=2
				; Add Flag
				Flag += 2
			endif
		endif
	endif
	StorageUtil.SetIntValue(woman, "FW.Flags",flag)
	return flag
endFunction

; This funciton will overwrite the "can become pregnant in this cycle" and the
; "can become PMS in this cycle" flag depending on the function arguments
; Returns the flag value
int function setFlag(actor woman, bool bCanBecomePregnant, bool bCanBecomePMS)
	;System.Trace("FWController.setFlag", woman)
	If (StorageUtil.FormListFind(none,"FW.SavedNPCs",woman)<0)
		CreateFemaleActor(woman)
	EndIf
	int flag=0
	if bCanBecomePregnant;/==true/;
		flag+=1
	endIf
	if bCanBecomePMS;/==true/;
		flag+=2
	endIf
	StorageUtil.SetIntValue(woman, "FW.Flags",flag)
	return flag
endFunction

; This funciton will set the "can become pregnant in this cycle" and the
; "can become PMS in this cycle" flag depending on the configuration
; Returns the flag value
int function setAutoFlag(actor Woman)
	;System.Trace("FWController.setAutoFlag", Woman)
	return setFlag(Woman, System.canBecomePregnant(Woman), System.canBecomePMS(Woman))
endFunction

; Returns true if the given woman will become pregnant in the current cycle
bool function canBecomePregnant(actor Woman)
	;System.Trace("FWController.canBecomePregnant", Woman)
	int flag = StorageUtil.GetIntValue(woman, "FW.Flags",0)
	return Math.LogicalAnd(flag,1)==1
endFunction

; Returns true if the given woman will become PMS in the current cycle
bool function canBecomePMS(actor Woman)
	;System.Trace("FWController.canBecomePMS", Woman)
	int flag = StorageUtil.GetIntValue(woman, "FW.Flags",0)
	return Math.LogicalAnd(flag,2)==2
endFunction


; Get the amount of contraception
; (result is 0.0 to 98 .... or 0.0 to System.MaxContraception)
float function getContraception(actor Woman)
	;System.Trace("FWController.getContraception", Woman)
	return getContraceptionTimed(Woman, GameDaysPassed.GetValue())
endFunction

; Get the amount of contraception the woman has got at the given time
; (result is 0.0 to 98 .... or 0.0 to System.MaxContraception)
float function getContraceptionTimed(actor Woman, float Time)
	;System.Trace("FWController.getContraceptionTimed", Woman)
	If (StorageUtil.FormListFind(none,"FW.SavedNPCs",woman)<0)
		return 0.0
	EndIf
	float contraception = StorageUtil.GetFloatValue(Woman,"FW.Contraception",0)
	if contraception<=0
		return 0.0
	elseif contraception > System.MaxContraception
		contraception=System.MaxContraception
	endif
	float cTime = StorageUtil.GetFloatValue(Woman,"FW.ContraceptionTime",0)
	float cDur = System.GetPillDuration(Woman)
	
	float res = contraception - ((Time - cTime - cDur) * 24)
	;if res <0.0
	;	return 0.0
	;else
	;	return res
	;endif
	return FWUtility.RangedFloat(res,0.0,contraception)
endFunction


; Add an amount of contraception (pill effect)
float function AddContraception(actor Woman, float Value)
	;System.Trace("FWController.AddContraception", Woman)
	return AddContraceptionTimed(Woman, GameDaysPassed.GetValue(), Value)
endFunction

; Adds an amount of contraception in the past, at the given time
float function AddContraceptionTimed(actor Woman, float Time, float Value)
	;System.Trace("FWController.AddContraceptionTimed", Woman)
	If (StorageUtil.FormListFind(none,"FW.SavedNPCs",woman)<0)
		CreateFemaleActor(woman)
	EndIf
	float cDur = System.GetPillDuration(Woman)
	float cTime = StorageUtil.GetFloatValue(Woman,"FW.ContraceptionTime",0.0)
	float contraception = getContraceptionTimed(Woman, Time)
	float new_contraception
	float addValue=0.0
	if cTime==0.0
		addValue = Value
	elseif Time - cTime <= 0
		return contraception
	elseif cTime + (cDur*0.75) < Time
		addValue=Value
	else
		addValue = ((Time - cTime) * Value) / (cDur*0.75)
	endIf
	if addValue < 2
		addValue = 2.0
	endif
	new_contraception=contraception+addValue
	; Clamp the NEW value - the old code tested the pre-add value, which never
	; exceeds the cap, so the stored total could overshoot MaxContraception
	if new_contraception>System.MaxContraception
		new_contraception = System.MaxContraception
	elseif new_contraception < 0
		new_contraception = 0.0
	endif
	StorageUtil.SetFloatValue(Woman,"FW.ContraceptionTime",Time)
	StorageUtil.SetFloatValue(Woman,"FW.Contraception",new_contraception)
	
	if(Woman==PlayerRef)
		ContraceptionWidget.showTimed(true)
	endif
	
	Manager.OnContraception(Woman, addValue, contraception, new_contraception, Time - cTime)
	return new_contraception
endFunction


; ===========================================================================
; Fertility Tonic - symmetric counterpart of the contraception API above.
; A timed conception-chance boost (FW.Fertility) that decays like the pill and
; is added to the impregnation roll in FWAbilityBeeingFemale. Unlike
; contraception there is no widget/manager hook to fire.
; ===========================================================================

; Get the woman's current fertility boost (decayed to "now")
float function getFertility(actor Woman)
	return getFertilityTimed(Woman, GameDaysPassed.GetValue())
endFunction

; Get the fertility boost the woman has got at the given time
; (result is 0.0 to MaxFertility)
float function getFertilityTimed(actor Woman, float Time)
	If (StorageUtil.FormListFind(none,"FW.SavedNPCs",woman)<0)
		return 0.0
	EndIf
	float MaxFertility = 8.0
	float fertility = StorageUtil.GetFloatValue(Woman,"FW.Fertility",0)
	if fertility<=0
		return 0.0
	elseif fertility > MaxFertility
		fertility=MaxFertility
	endif
	float fTime = StorageUtil.GetFloatValue(Woman,"FW.FertilityTime",0)
	float fDur = System.GetPillDuration(Woman)

	float res = fertility - ((Time - fTime - fDur) * 24)
	return FWUtility.RangedFloat(res,0.0,fertility)
endFunction

; Add an amount of fertility boost (drinking a Fertility Tonic)
float function AddFertility(actor Woman, float Value)
	return AddFertilityTimed(Woman, GameDaysPassed.GetValue(), Value)
endFunction

; Adds an amount of fertility boost at the given time
float function AddFertilityTimed(actor Woman, float Time, float Value)
	If (StorageUtil.FormListFind(none,"FW.SavedNPCs",woman)<0)
		CreateFemaleActor(woman)
	EndIf
	float MaxFertility = 8.0
	float fDur = System.GetPillDuration(Woman)
	float fTime = StorageUtil.GetFloatValue(Woman,"FW.FertilityTime",0.0)
	float fertility = getFertilityTimed(Woman, Time)
	float new_fertility
	float addValue=0.0
	if fTime==0.0
		addValue = Value
	elseif Time - fTime <= 0
		return fertility
	elseif fTime + (fDur*0.75) < Time
		addValue=Value
	else
		addValue = ((Time - fTime) * Value) / (fDur*0.75)
	endIf
	if addValue < 1
		addValue = 1.0
	endif
	new_fertility=fertility+addValue
	if new_fertility>MaxFertility
		new_fertility = MaxFertility
	elseif new_fertility < 0
		new_fertility = 0.0
	endif
	StorageUtil.SetFloatValue(Woman,"FW.FertilityTime",Time)
	StorageUtil.SetFloatValue(Woman,"FW.Fertility",new_fertility)
	return new_fertility
endFunction

; Apply a Fertility Tonic of the given magnitude - the single entry point shared
; by the consumable (FWFertilityItem) and the "DrinkFertilityTonic" mod event, so
; the potion and the API can never drift apart.
;
; magnitude doubles as the tier selector, matching the potion's EFIT magnitude:
;   < 3.5  (mild, ~2): a Gate 2 conception-roll boost; additionally, if the
;          current cycle rolled infertile (and she is not pregnant), it grants
;          ONE extra Gate 1 ConceiveChance roll - a nudge, never a guarantee.
;   >= 3.5 (potent, ~4): the same Gate 2 boost PLUS it forces the current cycle's
;          Gate 1 "can become pregnant" flag on for the rest of the window.
; Magnitude is floored to 2.0 so an under-spec tonic still does something.
; Returns the resulting FW.Fertility value.
float function ApplyFertilityTonic(actor Woman, float magnitude)
	if magnitude < 2.0
		magnitude = 2.0
	endif
	float res = AddFertility(Woman, magnitude)
	if magnitude >= 3.5
		setCanBecomePregnant(Woman, true)
	elseif GetFemaleState(Woman) < 4 && canBecomePregnant(Woman) == false
		if System.canBecomePregnant(Woman)
			setCanBecomePregnant(Woman, true)
		endif
	endif
	return res
endFunction

; Add an amount of contraception (pill effect)
float function SetContraception(actor Woman, float Value)
	;System.Trace("FWController.AddContraception", Woman)
	return SetContraceptionTimed(Woman, GameDaysPassed.GetValue(), Value)
endFunction

; Adds an amount of contraception in the past, at the given time
float function SetContraceptionTimed(actor Woman, float Time, float Value)
	;System.Trace("FWController.AddContraceptionTimed", Woman)
	If (StorageUtil.FormListFind(none,"FW.SavedNPCs",woman)<0)
		CreateFemaleActor(woman)
	EndIf
	StorageUtil.SetFloatValue(Woman,"FW.ContraceptionTime",Time)
	StorageUtil.SetFloatValue(Woman,"FW.Contraception",Value)
	
	if(Woman==PlayerRef)
		ContraceptionWidget.showTimed(true)
	endif
	return Value
endFunction

; Time till next pill is needed (0 = now)
float function GetContraceptionDuration(actor Woman)
	;System.Trace("FWController.GetContraceptionDuration", Woman)
	return GetContraceptionDurationTimed(Woman, GameDaysPassed.GetValue())
endFunction

; Time till next pill is needed depending on the given time
float function GetContraceptionDurationTimed(Actor Woman, float Time)
	;System.Trace("FWController.GetContraceptionDurationTimed", Woman)
	If (StorageUtil.FormListFind(none,"FW.SavedNPCs",woman)<0)
		return 0
	EndIf
	float cDur = System.GetPillDuration(Woman)
	float cTime = StorageUtil.GetFloatValue(Woman,"FW.ContraceptionTime",0)
	if cTime+cDur>Time
		return 0
	else
		return cDur - ((cTime + cDur) - Time)
	endif
	
endFunction

; returns the Time that has gone, since the actors last child was born
float function getLastChildBornTime(actor ParentActor)
	;System.Trace("FWController.getLastChildBornTime", ParentActor)
	return StorageUtil.GetFloatValue(ParentActor,"FW.LastBornChildTime", 0)
endFunction

; Updates the BeeingFemale faction for the given actor
function UpdateParentFaction(actor ParentActor)
	;System.Trace("FWController.UpdateParentFaction", ParentActor)
	if ParentActor == none || System == none || System.ParentFaction == none
		return
	endif
	if ParentActor != PlayerRef && (StorageUtil.FormListFind(none,"FW.SavedNPCs",ParentActor) < 0)
		return
	endif
	int stateID = StorageUtil.GetIntValue(ParentActor, "FW.CurrentState", 0)
	int newRank
	if stateID == 8
		newRank = -1
	elseif stateID >= 0
		newRank = stateID
	else
		newRank = -2
	endif
	; Skip the SetFactionRank call when the rank is already what we'd write —
	; SetFactionRank triggers AI re-eval on the target, which is the expensive bit.
	; Only reliable for ranks >= 0: GetFactionRank reports -2 for any non-member,
	; so negative target ranks always get the unconditional write.
	if newRank < 0 || ParentActor.GetFactionRank(System.ParentFaction) != newRank
		ParentActor.SetFactionRank(System.ParentFaction, newRank)
	endif
endFunction

; Returns the calculated chance to become pregnant when the given womand has sex right now
; depending on all stats and settings
; (return value is from 0.01 to 0.99)
float function getRelativePregnancyChance(actor woman, actor man = none, bool includeFertility = true)
	return getRelativePregnancyChanceTimed(woman, GameDaysPassed.GetValue(), man, includeFertility)
endfunction

; Returns the calculated chance to become pregnant when the given womand had sex at the given time
; depending on all stats and settings
; (return value is from 0.01 to 0.99)
float function getRelativePregnancyChanceTimed(actor woman, float Time, actor man = none, bool includeFertility = true)
	int WomanState = GetFemaleState(woman)
	float StateEnterTime = GetStateEnterTime(woman)
	if WomanState >=4
		; Already pregnant
		return 0.01
	else
		float Dur0 = System.getStateDuration(0,woman)           ;  5
		float Dur1 = System.getStateDuration(1,woman)           ;  2
		float Dur2 = System.getStateDuration(2,woman)           ;  5
		float Dur3 = System.getStateDuration(3,woman)           ;  2
		float DurT = Dur0+Dur1+Dur2+Dur3                        ; 14
		float EggTravel = System.getEggTravelingDuration(woman) ;  1
		float SpermLifeTime = System.getMaleSpermDuration(man)  ;  3
		float SpermTravel = cfg.WashOutHourDelay
		
		float curTime = 0
		bool bCanBecomePregnant = canBecomePregnant(woman)
		float CurChance = 0.0
		float stateTime = Time - StateEnterTime + SpermTravel
		float canBecomePregnantBonus = 0.0
		if bCanBecomePregnant
			canBecomePregnantBonus=1.0
		else
			canBecomePregnantBonus=0.05
		endif

		; A consumed Fertility Tonic (FW.Fertility) raises the conception roll, so
		; the previewed chance should reflect it. Mirror the per-phase weighting of
		; the live impregnation check: ovulation rolls out of 16 (~+6.25%/point),
		; the luteal phase rolls out of 100 (+1%/point). See FWAbilityBeeingFemale.
		float my_Fertility = 0.0
		if includeFertility
			my_Fertility = getFertilityTimed(woman, Time)
		endif

		float newChance = 0.0
		
		while curTime < SpermLifeTime
			; Angenommen: WomanState = 0, Time = 55.2, StateEnterTime = 51.0 -- Daher Statewechsel in 0,8 Tagen
			newChance=0.0
			if WomanState==0
				;if Dur0 - (Time - StateEnterTime - 0.125) + EggTravel < SpermLifeTime
				;	CurChance = 0.98
				;elseif Dur0 - (Time - StateEnterTime + 0.125) + EggTravel < SpermLifeTime
				;	CurChance = 0
				;else
				;	CurChance = 0.01
				;endif
				stateTime+=1.0
				curTime+=1.0
				if stateTime > Dur0
					stateTime-=Dur0
					WomanState=1
				endif
			elseif WomanState==1 ; Ovulating
				if stateTime > EggTravel * 1.2
					newChance=98
				elseif stateTime > EggTravel * 0.8
					float EggMax=EggTravel * 1.2
					float EggMin=EggTravel * 0.8
					float EggDif=EggMax - EggMin
					float EggStart = stateTime - EggMin
					; stateTime = 1.1
					; EggMin = 0.8
					; EggMax = 1.2
					; EggDif = 0.4
					; EggStart = 1.1 - 0.8 = 0.3
					;
					; EggDif 	- 100%
					; EggStart 	- x
					;--------------------
					; x = (0.3 * 100) / 0.4
					;
					newChance = (EggStart * 100) / EggDif
				endif
				if newChance > 0
					; +6.25%/point: ovulation roll is RandomInt(0,15) < 7 + fertility
					newChance = newChance + my_Fertility * 6.25
				endif
				stateTime+=0.5
				curTime+=0.5
				if stateTime > Dur1
					stateTime-=Dur1
					WomanState=2
				endif
			elseif WomanState==2 ; Lutheal Phase
				float statePercent = (100 * stateTime) / Dur2
				if statePercent<65
					; +1%/point: luteal roll is RandomFloat(0,99) < chance + fertility
					newChance = System.LutealImpregnationTime(statePercent) + my_Fertility
				endif
				stateTime+=0.25
				curTime+=0.25
				if stateTime > Dur2
					stateTime-=Dur2
					WomanState=3
				endif
			elseif WomanState==3 ; Menstruating
				stateTime+=1.0
				curTime+=1.0
				if stateTime > Dur3
					stateTime-=Dur3
					WomanState=0
					canBecomePregnantBonus = cfg.ConceiveChance / 105
				endif
			endif
			float contraception = getContraceptionTimed(woman, Time+curTime)
			newChance*=canBecomePregnantBonus
			newChance*=(100 - contraception) / 100
			if newChance>CurChance
				CurChance=newChance
			endif
		endwhile
		return FWUtility.RangedFloat(CurChance,0.5,97.0) + Utility.RandomFloat(0.0,2.5)
	endif
endFunction

; Returns female actors the given man has sperm inside
Actor[] function getFemalesWithSpermFrom(actor Male, int max=128)
	if(max>128)
		max=128
	endif
	Actor[] res = FWUtility.ActorArray(max)
	int curRes=0
	float SpermDuration = System.getMaleSpermDuration(Male) ; The duration sperm can survive
	float CurTime= GameDaysPassed.GetValue() ; The current Game Time
	int c = FWUtility.MinInt(StorageUtil.FormListCount(none,"FW.SavedNPCs"),max)
	while c>0
		c-=1
		actor female = StorageUtil.FormListGet(none,"FW.SavedNPCs",c) as actor
		; Check if it's neccessary to check all sperms
		if StorageUtil.FormListFind(female, "FW.SpermName", Male)>=0
			; Check for relevant sperm
			int sperm_index= StorageUtil.FormListCount(female, "FW.SpermName");StorageUtil.FormListCount(female,"FW.SpermName")
			while sperm_index>0
				sperm_index-=1
				if StorageUtil.FormListGet(female,"FW.SpermName",sperm_index)==Male
					if StorageUtil.FloatListGet(female,"FW.SpermTime",sperm_index)+SpermDuration>CurTime
						; Found - Exit while and add this sperm
						sperm_index=0
						res[curRes]=female
						curRes+=1
						if curRes>=max
							c=0
						endif
					endIf
				endIf
			endwhile
		endif
	endWhile
	return FWUtility.ActorArrayResize(res,curRes)
endFunction

; Returns female actors the given man has impregnated
Actor[] function getFemalesImpregnatedFrom(actor Male, int max=128)
	if(max>128)
		max=128
	endif
	Actor[] res = FWUtility.ActorArray(max)
	int curRes=0
	int c = StorageUtil.FormListCount(none,"FW.SavedNPCs")
	while c>0
		c-=1
		actor female = StorageUtil.FormListGet(none,"FW.SavedNPCs",c) as actor
		; Check if it's neccessary to check all sperms
		if StorageUtil.FormListFind(female, "FW.SpermName", Male)>=0 || StorageUtil.FormListFind(female, "FW.ChildFather", Male)>=0
			; Found sperm / Father - Update now
			Data.Update(female)
			int female_state= StorageUtil.GetIntValue(female,"FW.CurrentState",0)
			if female_state>3 && female_state<8
				; FormListFind returns an index: 0 (first father) is a valid hit
				if StorageUtil.FormListFind(female, "FW.ChildFather", Male) >= 0
					res[curRes]=female
					curRes+=1
					if curRes>=max
						c=0
					endif
				endif
			endif
		endif
	endWhile
	return FWUtility.ActorArrayResize(res,curRes)
endFunction

; returns the virility of the given man
float function GetVirility(actor Male)
	float virility=0
	If cfg.MaleVirilityRecovery > 0.0
		float L1 = StorageUtil.FloatListGet(Male, "SexLabSkills", 17)
		float L2 = StorageUtil.GetFloatValue(Male, "FW.LastSexTime",0.0)
		float LastSexTime = 0.0
		if L1>L2
			LastSexTime = L1
		else
			LastSexTime = L2
		endif
		if LastSexTime<=0.0
			virility = 1.0
		else
			virility = FWUtility.ClampFloat((GameDaysPassed.GetValue() - LastSexTime) / (cfg.MaleVirilityRecovery * Manager.ActorMaleRecoveryScale(Male)), 0.02, 1.0)
		endif
	else
		virility = 1.0
	EndIf
	return virility
endFunction

; Returns all actors who has impregnated the given woman
Actor[] function getFathers(actor Mother, int max = 12)
	if(max>128)
		max=128
	endif
	actor[] res = FWUtility.ActorArray(max)
	int c = StorageUtil.FormListCount(Mother, "FW.ChildFather")
	int i=0
	int curRes = 0
	while i<c
		actor a = StorageUtil.FormListGet(Mother, "FW.ChildFather", i) as actor
		if a;/!=none/;
			res[curRes]=a
			curRes+=1
			if curRes>=max
				c=0
			endif
		endif
		i+=1
	endWhile
	return FWUtility.ActorArrayResize(res,curRes)
endFunction

; Returns all actors who has sperm inside the given woman
Actor[] function getMalesInWoman(actor female, int max = 128)
	if(max>128)
		max=128
	endif
	float curTime = GameDaysPassed.GetValue()
	actor[] res = FWUtility.ActorArray(max)
	int c = StorageUtil.FormListCount(female, "FW.SpermNames")
	int i=0
	int curRes = 0
	while i<c
		actor a=StorageUtil.FormListGet(female, "FW.SpermNames",i) as actor
		float t=StorageUtil.FloatListGet(female, "FW.SpermTime",i)
		float m=StorageUtil.FloatListGet(female, "FW.SpermAmount",i)
		Debug.Notification(a.GetLeveledActorBase().GetName() + " " + t + " -- " + m)
		if(a;/!=none/; && m>=Sperm_Min_Amount_For_Impregnation)
			float sDur = System.getMaleSpermDuration(a)
			Debug.Notification(curTime + " - " + t + " < " + sDur + " | " + (curTime - t) + " < " + sDur)
			if curTime-t<sDur
				res[curRes]=a
				curRes+=1
				if curRes>=max
					c=0
				endif
			endIf
		endif
		i+=1
	endWhile
	return FWUtility.ActorArrayResize(res,curRes)
endFunction


; Open a Messagebox with informations depending on the rank (Rang = 0 to 100)
; As higher the given rank - as more informations will be shown
; Info-window name: display name first - grown-up preset adults keep their
; base name ("Prisoner"); SetDisplayName holds the real one
string function GetInfoName(actor a)
	if a == none
		return ""
	endif
	string n = a.GetDisplayName()
	if n != ""
		return n
	endif
	ActorBase ab = a.GetLeveledActorBase()
	if ab
		return ab.GetName()
	endif
	return ""
endFunction

function showRankedInfoBox(Actor target, int Rank)
	System.InfoMenuBlur()
	UI.OpenCustomMenu("BeeingFemale/BeeingFemaleInfo")
	string[] ent
	int iValidate = System.IsValidateActor(target)
;	if (target as FWChildActor);/!=none/;
		FWChildActor child = target as FWChildActor
		bool IsCustomChildActor = (StorageUtil.GetIntValue(target, "FW.Child.IsCustomChildActor", 0) == 1)
		; Living grown-up children are adult NPCs now: skip the child card so they fall
		; through to the normal male/female info (cycle/pregnancy/virility). Dead
		; grown-ups keep the child card (lineage + death age), since the NPC branch
		; would just report them as invalid.
		bool IsGrownUp = (StorageUtil.GetIntValue(target, "FW.Child.GrownUp", 0) == 1)

		if(child && (!IsGrownUp || target.IsDead()))
			Child.InitChild()
			ent = new string[9]
			ent[0]=3
			ent[1]=child.Name+" "+child.GetLastName()
			if child.Mother == none && child.Father == none
				ent[2]="$FW_INFOWINDOW_UnknownParents"
			elseif child.Father==none
				ent[2]="$FW_INFOWINDOW_ChildMotherIs{"+child.Mother.GetDisplayName()+"}"
			elseif child.Mother==none
				ent[2]="$FW_INFOWINDOW_ChildFatherIs{"+child.Father.GetDisplayName()+"}"
			else
				ent[2]="$FW_INFOWINDOW_ChildParents{"+child.Mother.GetDisplayName()+"}{"+child.Father.GetDisplayName()+"}"
			endif
			if child.GetLeveledActorBase().GetSex() == 0
				ent[3]="m"
			else
				ent[3]="f"
			endif
			
			if(!child.IsDead())
				ent[4]=Math.Floor(child.Age)
			else
				float myChildDOB = StorageUtil.GetFloatValue(child, "FW.Child.DOB", 0)
				float myChildDOD = StorageUtil.GetFloatValue(child, "FW.Child.DOD", 0)
				
				ent[4] = Math.Floor(myChildDOD - myChildDOB)
			endIf
			
			ent[5]=child.Order
			ent[6]=child.GetLevel()
			ent[7]=(child.GetActorValuePercentage("Experience") * 100) as int
			location loc = child.GetCurrentLocation()
			if loc;/!=none/;
				ent[8]=loc.GetName()
			else
				ent[8]="$FW_INFOWINDOW_UnknownLocation"
			endif
		elseif(IsCustomChildActor && (!IsGrownUp || target.IsDead()))
			ent = new string[9]
			ent[0] = 3
			ent[1] = target.GetDisplayName()
			
			Actor CustomChildMother = StorageUtil.GetFormValue(target, "FW.Child.Mother", none) as Actor
			Actor CustomChildFather = StorageUtil.GetFormValue(target, "FW.Child.Father", none) as Actor	
			if((CustomChildMother == none) && (CustomChildFather == none))
				ent[2] = "$FW_INFOWINDOW_UnknownParents"
			elseif(CustomChildFather == none)
				ent[2] = "$FW_INFOWINDOW_ChildMotherIs{" + CustomChildMother.GetDisplayName() + "}"
			elseif(CustomChildMother == none)
				ent[2] = "$FW_INFOWINDOW_ChildFatherIs{" + CustomChildFather.GetDisplayName() + "}"
			else
				ent[2]="$FW_INFOWINDOW_ChildParents{" + CustomChildMother.GetDisplayName() + "}{" + CustomChildFather.GetDisplayName() + "}"
			endif
			
			if(target.GetLeveledActorBase().GetSex() == 0)
				ent[3] = "m"
			else
				ent[3] = "f"
			endif
			
			float CustomChildDOB = StorageUtil.GetFloatValue(target, "FW.Child.DOB", 0)
			
			if(!target.IsDead())
				ent[4] = Math.Floor(GameDaysPassed.GetValue() - CustomChildDOB)
			else
				float CustomChildDOD = StorageUtil.GetFloatValue(target, "FW.Child.DOD", 0)
				ent[4] = Math.Floor(CustomChildDOD - CustomChildDOB)
			endIf
			
			ent[5] = 0
			ent[6] = target.GetLevel()
			ent[7] = 0

			location loc = target.GetCurrentLocation()
			if loc;/!=none/;
				ent[8] = loc.GetName()
			else
				ent[8] = "$FW_INFOWINDOW_UnknownLocation"
			endif			
		elseif(iValidate<0 || target.GetLeveledActorBase()==none)
			ent = new string[3]
			ent[0] = 4
			ent[1] = GetInfoName(target)
			ent[2] = iValidate * -1
		else
			if target.GetLeveledActorBase().GetSex()==0
				ent = new string[5]
				ent[0]=2
				ent[1]=GetInfoName(target)
				ent[2]=Math.Floor(GetVirility(target)*100)
				ent[3]= FWUtility.getActorListNames(getFemalesWithSpermFrom(target, 20) , true)
				ent[4]= FWUtility.getActorListNames(getFemalesImpregnatedFrom(target, 5) , true)
			else
				Data.Update(target)
				if IsPregnant(target)==false
					Actor[] a = GetRelevantSpermActors(target, true);getMalesInWoman(target)
					ent = new string[9]
					ent[0]=0
					ent[1]=GetInfoName(target)
					ent[2]=GetFemaleState(target)
					ent[3]=GameDaysPassed.GetValue() - GetStateEnterTime(target)
					ent[4]=System.getStateDuration(GetFemaleState(target), target) as int
					ent[5]=getContraception(target) as int
					ent[6]=GetContraceptionDuration(target)
					ent[7]=getRelativePregnancyChance(target)
					ent[8]=FWUtility.getActorListNames(a,true)
				else
					ent = new string[8]
					ent[0]=1
					ent[1]=GetInfoName(target)
					ent[2]=GetFemaleState(target)
					ent[3]=GameDaysPassed.GetValue() - GetStateEnterTime(target)
					ent[4]=System.getStateDuration(GetFemaleState(target), target) as int
					ent[5]=GetNumBabys(target)
					ent[6]=GetBabyHealth(target) as int
					ent[7]=FWUtility.getActorListNames(getFathers(target, 8), true)
				endif
			endif
		endif
		; Living grown-up children show as adult NPCs (types 0/1/2, or 4 if untracked),
		; which have no parent row. The info-window title shows ent[1] raw on a single
		; line, so append the lineage INLINE using resolved names (no $-key, no newline
		; - both fail in that field). Type 3 (dead grown-ups / real children) already
		; shows parents, so skip it.
		if IsGrownUp && ent[0] != "3"
			actor gMother = StorageUtil.GetFormValue(target, "FW.Child.Mother", none) as actor
			actor gFather = StorageUtil.GetFormValue(target, "FW.Child.Father", none) as actor
			string lineage = ""
			if gMother && gFather
				lineage = gMother.GetDisplayName() + " & " + gFather.GetDisplayName()
			elseif gMother
				lineage = gMother.GetDisplayName()
			elseif gFather
				lineage = gFather.GetDisplayName()
			endif
			if lineage != ""
				ent[1] = ent[1] + " (child of " + lineage + ")"
			endif
		endif
		UI.InvokeStringA("CustomMenu", "_root.FWInfoMenu.initData", ent)
endFunction


function __deprecated__showRankedInfoBox(actor target, int Rank)
	string s=""
	string targetName
	
	;FW_log.WriteLog("showRankedInfoBox "+target.GetLeveledActorBase().GetName()+" info")
	
	if target==PlayerRef
		targetName=Content.InfoSpell_You
	else
		targetName=target.GetLeveledActorBase().GetName()
	endif
	
	
	
	if (target as FWChildActor);/!=none/;
		FWChildActor child = target as FWChildActor
		if child.Mother == none && child.Father == None
			s+=Content.InfoSpell_UnknownParents+"\n"
		elseif Child.Mother==none && child.Father;/!=none/;
			s+=FWUtility.MultiStringReplace(Content.InfoSpell_ChildFatherIs,child.Father.GetLeveledActorBase().GetName())+"\n"
		elseif Child.Mother;/!=none/; && child.Father==None
			s+=FWUtility.MultiStringReplace(Content.InfoSpell_ChildMotherIs,child.Mother.GetLeveledActorBase().GetName())+"\n"
		else
			s+=FWUtility.MultiStringReplace(Content.InfoSpell_ChildParents,child.Mother.GetLeveledActorBase().GetName(),child.Father.GetLeveledActorBase().GetName())+"\n"
		EndIf
		s+=FWUtility.MultiStringReplace(Content.InfoSpell_ChildWasBorn, cfg.GetTimeString(child.Age,false) )+"\n"
		if child.IsVampire;/==true/;
			if child.GetLeveledActorBase().GetSex()==0
				s+=FWUtility.MultiStringReplace(Content.InfoSpell_ChildVampire, Content.InfoSpell_He )+"\n"
			Else
				s+=FWUtility.MultiStringReplace(Content.InfoSpell_ChildVampire, Content.InfoSpell_She )+"\n"
			endif
		endIf
		if child.Follow;/!=none/;
			s+=FWUtility.MultiStringReplace(Content.InfoSpell_ChildFollows, child.Follow.GetLeveledActorBase().GetName())+"\n"
		endif
		
		if child.Order >= 0
			if child.Order < 4
				if child.Order < 2
					if child.Order == 0
						s+=FWUtility.MultiStringReplace(Content.InfoSpell_ChildGotOrder, Content.InfoSpell_ChildOrder00 )+"\n"
					else;if child.Order == 1
						s+=FWUtility.MultiStringReplace(Content.InfoSpell_ChildGotOrder, Content.InfoSpell_ChildOrder01 )+"\n"
					endIf
				else
					if child.Order == 2
						s+=FWUtility.MultiStringReplace(Content.InfoSpell_ChildGotOrder, Content.InfoSpell_ChildOrder02 )+"\n"
					else;if child.Order == 3
						s+=FWUtility.MultiStringReplace(Content.InfoSpell_ChildGotOrder, Content.InfoSpell_ChildOrder03 )+"\n"
					endIf
				endIf
			else
				if child.Order < 6
					if child.Order == 4
						s+=FWUtility.MultiStringReplace(Content.InfoSpell_ChildGotOrder, Content.InfoSpell_ChildOrder04 )+"\n"
					else;if child.Order == 5
						s+=FWUtility.MultiStringReplace(Content.InfoSpell_ChildGotOrder, Content.InfoSpell_ChildOrder05 )+"\n"
					endIf
				elseif child.Order == 6
					s+=FWUtility.MultiStringReplace(Content.InfoSpell_ChildGotOrder, Content.InfoSpell_ChildOrder06 )+"\n"
				endif
			endIf
		endIf
		
		if child.Order != child.GetActorValue("Variable06")
			s+="WARNING: Var6 and order are different (" + child.Order + " / " + child.GetActorValue("Variable06") + ")\n"
		endif
		if (child.Order==0 || child.Order==1) && child.GetActorValue("WaitingForPlayer")==0
			s+="WARNING: Not Waiting for Player when having Order: "+child.Order+"\n"
		else;if child.Order;/!=0/; && child.Order!=1 && child.GetActorValue("WaitingForPlayer")==1
			if child.Order ;Tkc (Loverslab) optimization
				if child.Order==1
				else;if child.Order!=1
					if child.GetActorValue("WaitingForPlayer")==1
						s+="WARNING: Waiting for Player when having Order: "+child.Order+"\n"
					endif
				endif
			endif
		endif
		s+="Current Package: "+Child.GetCurrentPackage().GetName()+"("+Child.GetCurrentPackage().GetFormID()+")\n"
		s+="Relationship Rank with Player: "+Child.GetRelationShipRank(PlayerRef)+"\n"
			
	endIf
	
	if target.GetLeveledActorBase().GetSex()==0
	
		int validateMale = System.IsValidateMaleActor(target)
		if validateMale<=0
			if validateMale < 0
				if validateMale > -5
					if validateMale > -3
						if validateMale == -1
							System.Message(FWUtility.MultiStringReplace(Content.ForbiddenReason1,targetName), System.MSG_Always, System.MSG_Box)
						else;if validateMale == -2
							System.Message(FWUtility.MultiStringReplace(Content.ForbiddenReason2,targetName), System.MSG_High, System.MSG_Box)
						endIf
					else
						if validateMale == -3
							System.Message(FWUtility.MultiStringReplace(Content.ForbiddenReason3,targetName,Content.InfoSpell_Female), System.MSG_Debug, System.MSG_Box)
						else;if validateMale == -4
							System.Message(FWUtility.MultiStringReplace(Content.ForbiddenReason4,targetName), System.MSG_Debug, System.MSG_Box)
						endIf
					endIf
				else
					if validateMale > -7
						if validateMale == -5
							System.Message(FWUtility.MultiStringReplace(Content.ForbiddenReason5,targetName), System.MSG_High, System.MSG_Box)
						else;if validateMale == -6
							System.Message(FWUtility.MultiStringReplace(Content.ForbiddenReason6,targetName), System.MSG_High, System.MSG_Box)
						endIf
					else
						if validateMale > -9
							if validateMale == -7
								System.Message(FWUtility.MultiStringReplace(Content.ForbiddenReason7,targetName), System.MSG_High, System.MSG_Box)
							else;if validateMale == -8
								System.Message(FWUtility.MultiStringReplace(Content.ForbiddenReason8,targetName), System.MSG_Low, System.MSG_Box)
							endIf
						elseif validateMale == -9
							System.Message(FWUtility.MultiStringReplace(Content.ForbiddenReason9,targetName), System.MSG_High, System.MSG_Box)
						endif
					endIf
				endIf
			endIf
			return
		endIf
		
		; Infobox for male target
		if Rank <=0
			if HasSpermInWoman(target);/==true/;
				s+=FWUtility.MultiStringReplace(Content.InfoSpell_GotSpermInWoman,targetName)+"\n"
			else
				s+=FWUtility.MultiStringReplace(Content.InfoSpell_GotNoSpermInWoman,targetName)+"\n"
			endIf
		else
			float SpermDuration = System.getMaleSpermDuration(target) ; The duration sperm can survive
			float CurTime= GameDaysPassed.GetValue() ; The current Game Time
			string spermNames=""
			string pregnantNames=""
			int SpermCount=0
			int PregnantCount=0
			bool PlayerSperm=false
			bool PlayerPregnant=false
			int c = StorageUtil.FormListCount(none,"FW.SavedNPCs")
			while c>0
				c-=1
				actor female = StorageUtil.FormListGet(none,"FW.SavedNPCs",c) as actor
				if StorageUtil.FormListFind(female, "FW.SpermName", target)>=0
					; Check for relevant sperm
					int sperm_index= StorageUtil.FormListCount(female, "FW.SpermName");StorageUtil.FormListCount(female,"FW.SpermName")
					while sperm_index>0
						sperm_index-=1
						if StorageUtil.FormListGet(female,"FW.SpermName",sperm_index)==target
							if StorageUtil.FloatListGet(female,"FW.SpermTime",sperm_index)+SpermDuration>CurTime
								; Found - Exit while and add this sperm
								sperm_index=0
								if SpermCount>0
									spermNames+=", "
								endIf
								if female==PlayerRef
									PlayerSperm=true
									spermNames+=Content.InfoSpell_You
								else
									spermNames+=female.GetLeveledActorBase().GetName()
								endif
								SpermCount+=1
							endIf
						endIf
					endWhile
					
					if Rank>=50
						; also show the pregnant ones
						Data.Update(female)
						int female_state= StorageUtil.GetIntValue(female,"FW.CurrentState",0)
						if female_state>3 && female_state<8
							if PregnantCount>0
								pregnantNames+=", "
							endIf
							if female==PlayerRef
								pregnantNames+=Content.InfoSpell_You
								PlayerPregnant=true
							else
								pregnantNames+=female.GetLeveledActorBase().GetName()
							endif
							PregnantCount+=1
						endif
					endif
				endIf
			endWhile
			
			s+=FWUtility.MultiStringReplace(Content.InfoSpell_GotNumSpermInWoman,targetName,SpermCount)+"\n\n"
			
			string shortname=Content.InfoSpell_He
			if target == PlayerRef
				shortname=Content.InfoSpell_You
			endIf
			
			if SpermCount>0 && PlayerRef.GetLeveledActorBase().GetSex()==1
				if PlayerSperm;/==true/;
					s+=FWUtility.MultiStringReplace(Content.InfoSpell_CameInsideYou,shortname, Content.InfoSpell_Yes)+"\n"
				else
					s+=FWUtility.MultiStringReplace(Content.InfoSpell_CameInsideYou,shortname, Content.InfoSpell_No)+"\n"
				endIf
			endif
			
			if Rank >= 20 && SpermCount>0
				s+=FWUtility.MultiStringReplace(Content.InfoSpell_CameInsideNames,shortname,spermNames)+"\n\n"
			endif
			
			if Rank >= 50 && Rank <60
				if PregnantCount>0
					s+=FWUtility.MultiStringReplace(Content.InfoSpell_ImpregnatedAnyWoman,shortname,spermNames)+"\n"
				endif
			elseif Rank >= 60 && (Rank <80 || PregnantCount==0)
				s+=FWUtility.MultiStringReplace(Content.InfoSpell_ImpregnatedNumWoman,shortname,PregnantCount)+"\n"
			endif
			if Rank >=70 && PregnantCount>0
				if PlayerPregnant;/==true/;
					s+=FWUtility.MultiStringReplace(Content.InfoSpell_ImpregnatedYou,shortname,Content.InfoSpell_Yes)+"\n"
				else
					s+=FWUtility.MultiStringReplace(Content.InfoSpell_ImpregnatedYou,shortname,Content.InfoSpell_No)+"\n"
				endIf
			endif
			if Rank>=80 && PregnantCount>0
				s+=FWUtility.MultiStringReplace(Content.InfoSpell_ImpregnatedWoman,shortname, PregnantCount,pregnantNames)+"\n"
			endif
			;endWhile
		endif
		
		;if Rank >=30
		;	s+=targetName+" had sex "
		;endif
	else
		; Infobox for female target
		
		int Validate=System.IsValidateFemaleActor(target)
		if Validate<=0
			if Validate < 0
				if Validate > -5
					if Validate > -3
						if Validate == -1
							System.Message( FWUtility.MultiStringReplace(Content.ForbiddenReason1,targetName) , System.MSG_Always, System.MSG_Box)
						else;if Validate == -2
							System.Message( FWUtility.MultiStringReplace(Content.ForbiddenReason2,targetName) , System.MSG_High, System.MSG_Box)
						endIf
					else
						if Validate == -3
							System.Message( FWUtility.MultiStringReplace(Content.ForbiddenReason3,targetName, Content.InfoSpell_Male), System.MSG_Debug, System.MSG_Box)
						else;if Validate == -4
							System.Message( FWUtility.MultiStringReplace(Content.ForbiddenReason4,targetName) , System.MSG_Debug, System.MSG_Box)
						endIf
					endIf
				else
					if Validate > -7
						if Validate == -5
							System.Message( FWUtility.MultiStringReplace(Content.ForbiddenReason5,targetName) , System.MSG_High, System.MSG_Box)
						else;if Validate == -6
							System.Message( FWUtility.MultiStringReplace(Content.ForbiddenReason6,targetName) , System.MSG_High, System.MSG_Box)
						endIf
					else
						if Validate > -9
							if Validate == -7
								System.Message( FWUtility.MultiStringReplace(Content.ForbiddenReason7,targetName) , System.MSG_High, System.MSG_Box)
							else;if Validate == -8
								System.Message( FWUtility.MultiStringReplace(Content.ForbiddenReason8,targetName) , System.MSG_Low, System.MSG_Box)
							endIf
						elseif Validate == -9
							System.Message( FWUtility.MultiStringReplace(Content.ForbiddenReason9,targetName) , System.MSG_High, System.MSG_Box)
						endif
					endIf
				endIf
			endIf
			return
		endIf
		
		; First update the female NPC
		Data.Update(target)
		
		int stateID= StorageUtil.GetIntValue(target,"FW.CurrentState",0)
		int flag= StorageUtil.GetIntValue(target,"FW.Flags",0)
		Actor[] spermNames = FWUtility.ActorArrayUnique(GetRelevantSpermActors(target, true,true))

		;int z=0
		;while z<spermNames.length
		;	z+=1
		;endwhile

		if Rank <20
			if HasRelevantSperm(target,true);/==true/;
				s+=FWUtility.MultiStringReplace(Content.InfoSpell_GotSpermInside,targetName)+"\n"
			else
				s+=FWUtility.MultiStringReplace(Content.InfoSpell_GotNoSpermInside,targetName)+"\n"
			endIf
		else
			if spermNames.Length==0
				s+=FWUtility.MultiStringReplace(Content.InfoSpell_GotNoSpermInside,targetName)+"\n"
			elseif spermNames.Length==1 && spermNames[0]==PlayerRef && Rank>20
				s+=FWUtility.MultiStringReplace(Content.InfoSpell_GotYourSpermInside,targetName)+"\n"
			elseif spermNames.Length==1
				s+=FWUtility.MultiStringReplace(Content.InfoSpell_GotOneSpermInside,targetName)+"\n"
			else
				s+=FWUtility.MultiStringReplace(Content.InfoSpell_GotMoreSpermInside,targetName,spermNames.length)+"\n"
			endif
		endif
		
		if Rank>=35
			if stateID >= 0
				if stateID < 9
					if stateID < 4
						if stateID < 2
							if stateID==0
								s+=FWUtility.MultiStringReplace(Content.InfoSpell_CurrentState, Content.StateID0)
							else;if stateID==1
								s+=FWUtility.MultiStringReplace(Content.InfoSpell_CurrentState, Content.StateID1)
							endIf
						else
							if stateID==2
								s+=FWUtility.MultiStringReplace(Content.InfoSpell_CurrentState, Content.StateID2)
							else;if stateID==3
								s+=FWUtility.MultiStringReplace(Content.InfoSpell_CurrentState, Content.StateID3)
							endIf
						endIf
					else
						if stateID < 6
							if stateID==4
								s+=FWUtility.MultiStringReplace(Content.InfoSpell_CurrentState, Content.StateID4)
							else;if stateID==5
								s+=FWUtility.MultiStringReplace(Content.InfoSpell_CurrentState, Content.StateID5)
							endIf
						else
							if stateID < 8
								if stateID==6
									s+=FWUtility.MultiStringReplace(Content.InfoSpell_CurrentState, Content.StateID6)
								else;if stateID==7
									s+=FWUtility.MultiStringReplace(Content.InfoSpell_CurrentState, Content.StateID7)
								endIf
							else;if stateID==8
								s+=FWUtility.MultiStringReplace(Content.InfoSpell_CurrentState, Content.StateID8)
							endIf
						endIf
					endIf
				else
					if((stateID==20) || (stateID==21))
						if stateID==20
							s+=FWUtility.MultiStringReplace(Content.InfoSpell_CurrentState, Content.StateID20)
						else;if stateID==21
							s+=FWUtility.MultiStringReplace(Content.InfoSpell_CurrentState, Content.StateID21)
						endIf
					else
						s+=FWUtility.MultiStringReplace(Content.InfoSpell_CurrentState, Content.StateUnknown)
					endIf
				endIf
			else
				s+=FWUtility.MultiStringReplace(Content.InfoSpell_CurrentState, Content.StateUnknown)
			endIf
			
			if Rank>40 && IsPaused(target)==false
				float stateDur=System.GetStateDuration(stateID,target)
				float xStateDelay=GameDaysPassed.GetValue() - StorageUtil.GetFloatValue(target,"FW.StateEnterTime",0.0)
				s+=" "+FWUtility.MultiStringReplace(Content.InfoSpell_StateSince, FWUtility.GetTimeString(xStateDelay,true))+"\n"
				if Rank>65
					s+=FWUtility.MultiStringReplace(Content.InfoSpell_StateDuration, FWUtility.GetTimeString(stateDur,true))
					if Rank>95
						s+=" ("+FWUtility.GetPercentage(GetStatePercentage(target),1)+"%)\n"
					else
						s+="\n"
					endif
				endif
			else
				s+="\n"
			endIf
		endIf
		
		if Rank>=5 && Rank <25
			if stateID>4 && stateID<8
				s+=FWUtility.MultiStringReplace(Content.InfoSpell_LooksPregnant, Content.InfoSpell_Yes)+"\n"
			elseif stateID<=4 ; Event in the 1. Trimester
				s+=FWUtility.MultiStringReplace(Content.InfoSpell_LooksPregnant, Content.InfoSpell_No)+"\n"
			elseif stateID==8
				s+=FWUtility.MultiStringReplace(Content.InfoSpell_LooksPregnant, Content.InfoSpell_NotAnymore)+"\n"
			endif
		elseif Rank>=25
			if stateID>=4 && stateID<8
				s+=FWUtility.MultiStringReplace(Content.InfoSpell_IsPregnant, Content.InfoSpell_Yes)+"\n"
			elseif stateID<4
				s+=FWUtility.MultiStringReplace(Content.InfoSpell_IsPregnant, Content.InfoSpell_No)+"\n"
			elseif stateID==8
				s+=FWUtility.MultiStringReplace(Content.InfoSpell_IsPregnant, Content.InfoSpell_NotAnymore)+"\n"
			endif
		endIf
		
		
		if Rank>=95 && stateID<4
			if Math.LogicalOr(flag,1)==flag
				s+=FWUtility.MultiStringReplace(Content.InfoSpell_CanBecomePregnant, Content.InfoSpell_Yes)+" ("+ Math.Floor(getRelativePregnancyChance(target))+"%)\n"
			else
				s+=FWUtility.MultiStringReplace(Content.InfoSpell_CanBecomePregnant, Content.InfoSpell_No)+" ("+Math.Floor(getRelativePregnancyChance(target))+"%)\n"
			endIf
		elseif Rank>=80 && stateID<4
			if Math.LogicalOr(flag,1)==flag
				s+=FWUtility.MultiStringReplace(Content.InfoSpell_CanBecomePregnant, Content.InfoSpell_Yes)+"\n"
			else
				s+=FWUtility.MultiStringReplace(Content.InfoSpell_CanBecomePregnant, Content.InfoSpell_No)+"\n"
			endIf
		endIf
		
		if stateID>=4 && stateID<8
			;Pregnancy informations
			if Rank>60
				int numChilds=StorageUtil.GetIntValue(target,"FW.NumChilds",0)
				s+=FWUtility.MultiStringReplace(Content.InfoSpell_PregnantWithNumOfBabys, numChilds)+"\n"
				if Rank>95
					if numChilds>1
						s+=FWUtility.MultiStringReplace(Content.InfoSpell_UnbornBabiesHealth, (StorageUtil.GetFloatValue(target,"FW.UnbornHealth") as int))+"\n"
					else
						s+=FWUtility.MultiStringReplace(Content.InfoSpell_UnbornBabyHealth, (StorageUtil.GetFloatValue(target,"FW.UnbornHealth") as int))+"\n"
					endif
				endif
			endIf
		else
			; Cycle and replanish infos
			if Rank>33 && Rank<55
				if StorageUtil.GetFloatValue(target,"FW.Contraception") > 5.0
					s+=FWUtility.MultiStringReplace(Content.InfoSpell_Contraception, Content.InfoSpell_Yes)+"\n"
				else
					s+=FWUtility.MultiStringReplace(Content.InfoSpell_Contraception, Content.InfoSpell_No)+"\n"
				endIf
			elseif Rank>=55
				float concep = StorageUtil.GetFloatValue(target,"FW.Contraception")
				if concep>0
					s+=FWUtility.MultiStringReplace(Content.InfoSpell_Contraception, (concep as int)+"%")+"\n"
				else
					s+=FWUtility.MultiStringReplace(Content.InfoSpell_Contraception, Content.InfoSpell_No)+"\n"
				endif
				
				float lastTimeConcep=StorageUtil.GetFloatValue(target,"FW.ContraceptionTime",0.0)
				if Rank>75 && lastTimeConcep>0
					s+=FWUtility.MultiStringReplace(Content.InfoSpell_LastContraception, FWUtility.GetTimeString(GameDaysPassed.GetValue() - lastTimeConcep,true))+"\n"
				endif
			endIf
			
		endif
		if Rank>=50 && spermNames.length>0
			int c=spermNames.length
			bool bSpermFromPlayer=false
			bool bHasNames=false
			string xSpermNames=""
			while c>0
				c-=1
				if spermNames[c]==PlayerRef
					bSpermFromPlayer=true
				elseif spermNames[c];/!=none/;
					if bHasNames;/==true/;
						xSpermNames+=", "
					endIf
					xSpermNames+=GetInfoName(spermNames[c])
					bHasNames=true
				endif
			endWhile
			if bSpermFromPlayer;/==true/;
				if bHasNames;/==true/;
					xSpermNames+=" "+Content.InfoSpell_AndYou
				else
					xSpermNames+=Content.InfoSpell_You
				endIf
			endIf
			s+=FWUtility.MultiStringReplace(Content.InfoSpell_SpermNames, xSpermNames)+"\n"
		endIf
	endif
	
	System.Message(s, System.MSG_Always, System.MSG_Box)
endFunction


; 04.06.2019 ;Tkc (Loverslab) optimizations. added playerref to esp for this script. Other changes marked with "Tkc (Loverslab)" comment

