Scriptname FWSaveLoad extends Quest  

FWSystem property System auto
FWController property Controller auto
FWTextContents property Contents auto

float property SpermDeleteTime = 50.0 auto ; Delete sperm after x Days
float property SkipUpdateAfter = 60.0 auto


GlobalVariable Property ModEnabled Auto
GlobalVariable Property GameDaysPassed Auto
Actor Property PlayerRef Auto
formlist property Pill_Items auto
MagicEffect property Pill_Effect auto


;--------------------------------------------------------------------------------
; StorageUtil Variables - Woman
;--------------------------------------------------------------------------------
; Actor[]	FW.SavedNPCs
; float 	FW.LastUpdate (= the time this actor was updated the last Timedabilityscript)
; float 	FW.StateEnterTime
; float 	FW.Irregulation
; int		FW.CurrentState
; int		FW.Abortus
; float 	FW.AbortusTime
; float 	FW.UnbornHealth
; int		FW.NumChilds (= the number of babys the woman is pregnant with)
; Actor[]	FW.ChildFather
; float[]	FW.SpermTime
; Actor[]	FW.SpermName
; float[]	FW.SpermAmount
; int		FW.Flags
; float 	FW.PainLevel
; float 	FW.Contraception (= 0.0 to 100.0)
; float 	FW.ContraceptionTime
; int 		FW.NumBirth (= the number of birth the woman had)
; int 		FW.NumBabys (= the number of babys the woman has born)
; float 	FW.PauseTime
; float 	FW.LastBornChildTime
; Actor[] 	FW.BornChildFather (= Father of an already born child)
; float[]	FW.BornChildTime (= Timestamp of an already born child)
;
;--------------------------------------------------------------------------------
; StorageUtil Variables - Child
;--------------------------------------------------------------------------------
; Object	FW.Child.SavedChidren
; Actor 	FW.Child.Mother
; Actor 	FW.Child.Father
; int		FW.Child.Flags
; string	FW.Child.Name




;--------------------------------------------------------------------------------
; CurrentState
;--------------------------------------------------------------------------------
;   0	Follicular
;   1	Ovulation
;   2	Luteal
;   3	Menstruation
;   4	Trimester 1
;   5	Trimester 2
;   6	Trimester 3
;   7	LaborPains
;   8	Replanish
;--------------------------------------------------------------------------------
; Abortus
;   0	None
;   1	Abortus_imminens // drohender abortus
;   2	Abortus_incipiens // beginnender Abortus
;   3	Abortus_incompletus // unvollständiger Abort
;   4	Abortus_completus // vollständiger Abortus
;   5	Missed_Abortion // verhaltener Abort
;   6	Miscarriage // Totgeburt
;--------------------------------------------------------------------------------
; Flags
;--------------------------------------------------------------------------------
;   1	Can become Pregnant this cycle
;   2	Can become PMS this cycle

; This Function will update the stats of the given woman
function Update(actor Woman)
	float startTime = Utility.GetCurrentRealTime()
	if System.GetType()!=77
		return
	endif
	if ModEnabled.GetType() != 9
		return
	endif
	if ModEnabled.GetValue() As int != 1
		return
	endif
	if Woman==none
		return
	endif
	if Woman.IsDead()
		Delete(Woman)
		return
	endif
	if Woman.GetActorBase()==none
		Delete(Woman)
		return
	endif
	if StorageUtil.FormListFind(none,"FW.SavedNPCs",Woman)<0
		Controller.CreateFemaleActor(Woman)
	else
		float lu=StorageUtil.GetFloatValue(Woman,"FW.LastUpdate",0.0)
		if GameDaysPassed.GetValue() - lu>SkipUpdateAfter
			; if the last update is above 60 (self.SkipUpdateAfter) Days ago - abort the update - no one will remember - sry, saving performance
			Controller.CreateFemaleActor(Woman,true)
			return
		endif
		if lu+0.05 > GameDaysPassed.GetValue()
			; Last update was just 1.2 Gamehours ago - there is no need to update again
			return
		endIf
		UpdatePerDay(Woman)
	endif
	FW_log.WriteLog("FWSaveLoad::Update("+Woman.GetLeveledActorBase().GetName()+") " + (Utility.GetCurrentRealTime() - startTime) + " sec")
endFunction

function UpdatePerDay(actor Woman)
	float stateEnterTime = StorageUtil.GetFloatValue(Woman,"FW.StateEnterTime",0) ; 
	int CurrentState = StorageUtil.GetIntValue(Woman,"FW.CurrentState",0)
	float UnbornHealth = StorageUtil.GetFloatValue(Woman,"FW.UnbornHealth",100.0)
	float contraceptionTime = StorageUtil.GetFloatValue(Woman,"FW.ContraceptionTime",0.0)
	float contraception = StorageUtil.GetFloatValue(Woman,"FW.Contraception",0.0)
	bool bIsPregnant = CurrentState>=4
	float GT = GameDaysPassed.GetValue() ; stores the time to update
	float cur = StorageUtil.GetFloatValue(Woman,"FW.LastUpdate",0.0) ; Store the current calculated time
	float CurrentStatePercent ; stores the calculated state percentage 0.00 to 1.00
	float contraceptionDur = System.GetPillDuration(Woman)
	bool bIsPlayer = Woman == PlayerRef
	int flag = StorageUtil.GetIntValue(Woman,"FW.Flags",0)
	bool bMayPregnant= (Math.LogicalAnd(flag,1)==1)
	bool bMayPMS=(Math.LogicalAnd(flag,2)==2)
	bool bHasContraceptionItems = _hasContraceptionItems(Woman)
	
	int i = 0
	float[] fDur = New float[9]
	While i < 9
		fDur[i] = System.getStateDuration(i, Woman)
		i += 1
	endWhile
	
	while cur < GT
		
		; Set new State
		while cur - stateEnterTime>=fDur[CurrentState]
			stateEnterTime+=fDur[CurrentState]
			CurrentState+=1
			if (bIsPregnant && CurrentState>8) || (bIsPregnant==false && CurrentState>3)
				bIsPregnant=false
				CurrentState = 0
				flag = Controller.setAutoFlag(Woman)
				bMayPregnant= (Math.LogicalAnd(flag,1)==1)
				bMayPMS=(Math.LogicalAnd(flag,2)==2)
			endif
		endwhile
		
		if bIsPregnant && CurrentState>7 && Woman.Is3DLoaded()==true
			System.InstantBornChilds(Woman)
		endIf
		
		; Non-Pregnant Functions
		if bIsPregnant == false
			CurrentStatePercent = (cur - stateEnterTime) / fDur[CurrentState] * 100
			
			; Check for pregnancy
			if bMayPregnant && (CurrentState==1 && CurrentStatePercent>50) || (CurrentState==2 && CurrentStatePercent<20)
				float tmpcontraception = FWUtility.RangedFloat(contraception - ((cur - contraceptionTime - contraceptionDur) * 24),0.0,System.MaxContraception)
				if Controller.ActiveSpermImpregnationNoContraceptionTimed(Woman,cur,tmpcontraception)
					bIsPregnant=true
					CurrentState=4
					stateEnterTime=cur
					
					if woman.IsInFaction(System.FollowerFaction)
						System.Message( FWUtility.StringReplace( Contents.NPCIsPregnant , "{0}",Woman.GetLeveledActorBase().GetName()), System.MSG_Immersive)
					elseif woman!=PlayerRef
						System.Message( FWUtility.StringReplace( Contents.NPCIsPregnant , "{0}",Woman.GetLeveledActorBase().GetName()), System.MSG_High)
					endif
				endif
			endif
			
			; Check Birth control pills
			if bIsPlayer == false && bIsPregnant==false && bHasContraceptionItems
				;FW_log.WriteLog(Woman.GetLeveledActorBase().GetName()+" Ask for Pill")
				; Check if it's time for the next pill and the woman is not pregnant
				if contraceptionTime + (System.GetPillDuration(Woman) * 0.85) < cur
					;FW_log.WriteLog(Woman.GetLeveledActorBase().GetName()+" request pill")
					int pill_i = Pill_Items.GetSize()
					while pill_i>0
						pill_i-=1
						if Woman.GetItemCount(Pill_Items.GetAt(pill_i))>0 && (Pill_Items.GetAt(pill_i) as Potion)!=none
							;FW_log.WriteLog(Woman.GetLeveledActorBase().GetName()+" got pill item: "+System.Pill_Items.GetAt(pill_i))
							potion pill = (Pill_Items.GetAt(pill_i) as Potion)
							int fx_count=pill.GetNumEffects()
							while fx_count>0
								fx_count-=1
								if pill.GetNthEffectMagicEffect(fx_count) == Pill_Effect
									float mag=pill.GetNthEffectMagnitude(fx_count)
									FW_log.WriteLog(Woman.GetLeveledActorBase().GetName()+" added contraception: "+mag+"%")
									contraception = FWUtility.MinFloat(System.MaxContraception,mag+contraception)
									contraceptionTime=cur
									Woman.RemoveItem(pill, 1, true)
									fx_count=0 ; Exit while
									pill_i=0 ; Exit parent while
									bHasContraceptionItems = _hasContraceptionItems(Woman)
								endIf
							endWhile
						endIf
					endWhile
				endIf
			endIf
			
		endIf
		
		cur+=1
		
	endWhile
	
	; Save state
	Controller.ChangeStateTimed(Woman,stateEnterTime,CurrentState)
	StorageUtil.SetFloatValue(Woman,"FW.UnbornHealth",UnbornHealth)
	StorageUtil.SetFloatValue(Woman,"FW.ContraceptionTime",contraceptionTime)
	StorageUtil.SetFloatValue(Woman,"FW.Contraception",contraception)
	StorageUtil.SetFloatValue(Woman,"FW.LastUpdate",GT)
	
	Controller.UpdateParentFaction(Woman)
	
	; Delete old sperm
	int c = StorageUtil.FloatListCount(Woman, "FW.SpermTime")
	while c>0
		c-=1
		if StorageUtil.FloatListGet(Woman, "FW.SpermTime", c) + SpermDeleteTime < GT
			FWUtility.RemoveSpermMirrorAt(Woman, c)
		endIf
	endWhile
	
endFunction

; Returns if the woman has some contraception items in her inventory
bool function _hasContraceptionItems(actor Woman)
	int pill_i = Pill_Items.GetSize()
	while pill_i>0
		pill_i-=1
		if Woman.GetItemCount(Pill_Items.GetAt(pill_i))>0 && (Pill_Items.GetAt(pill_i) as Potion)!=none
			return true
		endIf
	endWhile
	return false
endFunction

bool function hasWillBecomePregnant(actor Woman)
	int xstate = StorageUtil.GetIntValue(Woman,"FW.CurrentState",0)
	float GT = GameDaysPassed.GetValue() ; stores the time to update
	If xstate>=4
		return true
	endIf
	int c = StorageUtil.FloatListCount(Woman, "FW.SpermTime")
	while c>0
		c-=1
		if StorageUtil.FloatListGet(Woman, "FW.SpermTime", c) + SpermDeleteTime < GT
			FWUtility.RemoveSpermMirrorAt(Woman, c)
		endIf
	endWhile
	return false
endFunction


function __Update_Old(actor Woman)
	if StorageUtil.FormListFind(none,"FW.SavedNPCs",Woman)<0
		Controller.CreateFemaleActor(Woman)
	else
		; Check if the actor was already updated a few gamehours ago
		if StorageUtil.GetFloatValue(Woman,"FW.LastUpdate",0.0)+0.1 > GameDaysPassed.GetValue()
			return
		endIf
		StorageUtil.SetFloatValue(Woman,"FW.LastUpdate",GameDaysPassed.GetValue())
		
		bool bUpdate = true
		float LastStateEnterTime = StorageUtil.GetFloatValue(Woman,"FW.StateEnterTime",0)
		int CurrentState = StorageUtil.GetIntValue(Woman,"FW.CurrentState",0)
		float UnbornHealth = StorageUtil.GetFloatValue(Woman,"FW.UnbornHealth",100.0)
		int NextState=CurrentState+1
		bool bIsPregnant = CurrentState>3
		bool bIsPlayer = Woman == PlayerRef
		
		float currentTime = GameDaysPassed.GetValue()
		float StateTime = currentTime - LastStateEnterTime
		bool hasRelevantSperm = True
		float[] fMenstruationDuration = New float[4]
		float[] fPregnancyDuration = New float[5]
		float fMaxMenstruationDays=0.0
		int i = 0
		While i < 4
			fMenstruationDuration[i] = System.getStateDuration(i, Woman)
			fPregnancyDuration[i] = System.getStateDuration(i+4, Woman)
			fMaxMenstruationDays+=fMenstruationDuration[i]
			i += 1
		EndWhile
		fPregnancyDuration[4] = System.getStateDuration(8, Woman)
		
		
		float impregnationTimeStart = fMenstruationDuration[0] + (fMenstruationDuration[1] / 0.5) ; Time from beginning of the Cycle (Follicular) to 50% of ovulation
		float impregnationTimeEnd = fMenstruationDuration[0] + fMenstruationDuration[1] + (fMenstruationDuration[2] / 0.5) ; Time from beginning of the Cycle (Follicular) to 50% of Luteal
		
		float CycleEnterTime=0
		float StateEnterTime=0.0
		int StateAdded=0
		while bUpdate
			
			if CurrentState>8
				CurrentState=0
				bIsPregnant=false
			endIf
			
			if bIsPregnant
				If StateTime > fPregnancyDuration[CurrentState - 4]
					StateTime -= fPregnancyDuration[CurrentState - 4]
					CurrentState += 1
					StateAdded+=1
				Else
					bUpdate = False
				EndIf
			else
				
				;If hasRelevantSperm
				;	hasRelevantSperm = Controller.HasRelevantSpermTimed(Woman,currentTime - StateTime)
				;EndIf
				
				; If no relevant sperm (which could possibly impregnate the NPC) is present at the time,
				; skip forward for each menstrual cycle the NPC has already completed while not loaded
				;If (! hasRelevantSperm) && (fMaxMenstruationDays > 0)
				;	While StateTime > fMaxMenstruationDays
				;		StateTime -= fMaxMenstruationDays
				;	EndWhile
				;EndIf
			
				If StateTime > fMenstruationDuration[CurrentState]
					StateTime -= fMenstruationDuration[CurrentState]
					CurrentState += 1
					StateAdded+=1
					if CurrentState>=4
						CurrentState=0
					endIf
				Else
					bUpdate = False
				EndIf
				
			endIf
			
			StateEnterTime = currentTime - StateTime
			
			; Check Birth control pills
			if bIsPlayer == false
				FW_log.WriteLog(Woman.GetLeveledActorBase().GetName()+" Ask for Pill")
				; Check if it's time for the next pill and the woman is not pregnant
				if StorageUtil.GetFloatValue(Woman,"FW.ContraceptionTime") + System.GetPillDuration(Woman) - 0.3 < StateEnterTime && bIsPregnant==false
					FW_log.WriteLog(Woman.GetLeveledActorBase().GetName()+" request pill")
					int pill_i = Pill_Items.GetSize()
					while pill_i>0
						pill_i-=1
						if Woman.GetItemCount(Pill_Items.GetAt(pill_i))>0 && (Pill_Items.GetAt(pill_i) as Potion)!=none
							FW_log.WriteLog(Woman.GetLeveledActorBase().GetName()+" got pill item: "+Pill_Items.GetAt(pill_i))
							potion pill = (Pill_Items.GetAt(pill_i) as Potion)
							int fx_count=pill.GetNumEffects()
							while fx_count>0
								fx_count-=1
								if pill.GetNthEffectMagicEffect(fx_count) == Pill_Effect
									float val = StorageUtil.GetFloatValue(Woman,"FW.Contraception",0.0)
									float mag=pill.GetNthEffectMagnitude(fx_count)
									val += mag
									FW_log.WriteLog(Woman.GetLeveledActorBase().GetName()+" added contraception: "+mag)
									StorageUtil.SetFloatValue(Woman,"FW.Contraception",FWUtility.MinFloat(100,val))
									StorageUtil.SetFloatValue(Woman,"FW.ContraceptionTime",StateEnterTime)
									Woman.RemoveItem(pill, 1, true)
									fx_count=0 ; Exit while
									pill_i=0 ; Exit parent while
								endIf
							endWhile
						endIf
					endWhile
				endIf
			endIf
			
			if CurrentState == 2
				;if System.CheckBecomePregnant(Woman, StateEnterTime)==true
				if Controller.ActiveSpermImpregnationTimed(Woman, StateEnterTime)==true
					bIsPregnant=true
					CurrentState=4
				endif
			elseif CurrentState == 7
				CurrentState=8 ; Skip Labor Pains and born the childs
				System.InstantBornChilds(Woman)
			endif
			
			int numChilds = StorageUtil.GetIntValue(Woman,"FW.NumChilds",0)
			if CurrentState >= 4
				if numChilds >0
					bIsPregnant=true
				else
					bIsPregnant=false
				endIf
			endif
			
			; At least - Delete to old sperm (after 20 Days)
			int c = StorageUtil.FloatListCount(Woman, "FW.SpermTime")
			while c>0
				c-=1
				if StorageUtil.FloatListGet(Woman, "FW.SpermTime", c) + SpermDeleteTime < StateEnterTime || StorageUtil.FloatListGet(Woman, "FW.SpermAmount", c)<0.1
					FWUtility.RemoveSpermMirrorAt(Woman, c)
				endIf
			endWhile
		endWhile
		
		;System.Message("States added for "+Woman.GetLeveledActorBase().GetName()+": "+StateAdded+" ("+FWUtility.getTimeString(GameDaysPassed.GetValue() - StorageUtil.GetFloatValue(Woman,"FW.StateEnterTime",0))+")" , System.MSG_All )
		string[] Cont = new string[3]
		Cont[0]=Woman.GetLeveledActorBase().GetName()
		Cont[1]=StateAdded
		Cont[2]=FWUtility.getTimeString(GameDaysPassed.GetValue() - StorageUtil.GetFloatValue(Woman,"FW.StateEnterTime",0))
		System.Message( FWUtility.ArrayReplace(Contents.StatesAddedForNPC,Cont) , System.MSG_All )
		
		; Save the new Data to Storage
		StorageUtil.SetFloatValue(Woman,"FW.StateEnterTime",StateEnterTime)
		StorageUtil.SetintValue(Woman,"FW.CurrentState",CurrentState)
		Controller.UpdateParentFaction(Woman)
		if bIsPregnant== false
			StorageUtil.SetintValue(Woman,"FW.NumChilds",0)
			StorageUtil.SetFloatValue(Woman,"FW.UnbornHealth",0.0)
		endIf
	endIf
endFunction

; This will delete all BeeingFemale related StorageUtil variables
function Delete(actor Woman) global
	StorageUtil.UnsetFloatValue(Woman,"FW.LastUpdate")
	StorageUtil.UnsetFloatValue(Woman,"FW.StateEnterTime")
	StorageUtil.UnsetIntValue(Woman,"FW.CurrentState")
	StorageUtil.UnsetIntValue(Woman,"FW.Abortus")
	StorageUtil.UnsetFloatValue(Woman,"FW.AbortusTime")
	StorageUtil.UnsetFloatValue(Woman,"FW.UnbornHealth")
	StorageUtil.UnsetIntValue(Woman,"FW.NumChilds")
	FWUtility.ClearChildFathers(Woman)
	FWUtility.ClearSpermMirror(Woman)
	FWUtility.ClearBabyItemIdentity(Woman)
	StorageUtil.UnsetIntValue(Woman,"FW.Flags")
	StorageUtil.UnsetFloatValue(Woman,"FW.PainLevel")
	StorageUtil.UnsetFloatValue(Woman,"FW.Contraception")
	StorageUtil.UnsetFloatValue(Woman,"FW.ContraceptionTime")
	StorageUtil.UnsetIntValue(Woman,"FW.NumBirth")
	StorageUtil.UnsetIntValue(Woman,"FW.NumBabys")
	StorageUtil.UnsetFloatValue(Woman,"FW.PauseTime")

	StorageUtil.FormListRemove(none,"FW.SavedNPCs",Woman)
endFunction

; This will reset all BeeingFemale related StorageUtil variables
; bPlayer: This will reset the player only
function ResetNpcData(bool bPlayer=false) global
	int i=StorageUtil.FormListCount(none,"FW.SavedNPCs")
	actor p = Game.GetPlayer()
	while i>0
		i-=1
		actor woman=StorageUtil.FormListGet(none,"FW.SavedNPCs",i) as Actor
		if woman != p || bPlayer==true
			StorageUtil.UnsetFloatValue(Woman,"FW.StateEnterTime")
			StorageUtil.UnsetIntValue(Woman,"FW.CurrentState")
			StorageUtil.UnsetIntValue(Woman,"FW.Abortus")
			StorageUtil.UnsetFloatValue(Woman,"FW.AbortusTime")
			StorageUtil.UnsetFloatValue(Woman,"FW.UnbornHealth")
			StorageUtil.UnsetIntValue(Woman,"FW.NumChilds")
			FWUtility.ClearChildFathers(Woman)
			FWUtility.ClearSpermMirror(Woman)
			FWUtility.ClearBabyItemIdentity(Woman)
			StorageUtil.UnsetIntValue(Woman,"FW.Flags")
			StorageUtil.UnsetFloatValue(Woman,"FW.PainLevel")
			StorageUtil.UnsetFloatValue(Woman,"FW.Contraception")
			StorageUtil.UnsetFloatValue(Woman,"FW.ContraceptionTime")
			StorageUtil.UnsetIntValue(Woman,"FW.NumBirth")
			StorageUtil.UnsetIntValue(Woman,"FW.NumBabys")
			StorageUtil.UnsetFloatValue(Woman,"FW.PauseTime")
		endif
	endWhile
	StorageUtil.FormListClear(none,"FW.SavedNPCs")
	if bPlayer==false
		StorageUtil.FormListAdd(none,"FW.SavedNPCs",p)
	endif
endFunction

function deleteChildren() global
	Actor player = Game.GetPlayer()
	int c = StorageUtil.FormListCount(none,"FW.Babys")
	while c>0
		c-=1
		FWChildActor baby1 = StorageUtil.FormListGet(none, "FW.Babys",c) as FWChildActor
		FWChildItem baby2 = StorageUtil.FormListGet(none, "FW.Babys",c) as FWChildItem
		Actor baby3 = StorageUtil.FormListGet(none, "FW.Babys",c) as Actor
		Armor baby4 = StorageUtil.FormListGet(none, "FW.Babys",c) as Armor
		if baby1 != none
			baby1.Delete()
		elseif baby2 != none
			baby2.Delete()
		elseif baby3 != none
			baby3.Delete()
		elseif baby4 != none
			; Item-mode babies are stored as the armor BASE form - none of the
			; casts above match, so without this they survived a mod reset
			player.RemoveItem(baby4, player.GetItemCount(baby4), true)
			StorageUtil.FormListRemoveAt(none, "FW.Babys", c)
		endif
	endwhile
	; Birth-time identity entries for the player's baby items
	FWUtility.ClearBabyItemIdentity(player)
endFunction

function Upgrade(int oldVersion, int newVersion)
endFunction



;ObjectReference.GetItemCount(Form ItemType)
;ObjectReference.RemoveItem(Form akItemToRemove, int aiCount = 1, bool abSilent = false, ObjectReference akOtherContainer = None)
