Scriptname BFA_Reminder extends FWAddOn_Misc  

FWSystem property System auto
bool bActive=false

Actor Property PlayerRef Auto
GlobalVariable Property GameDaysPassed Auto
FWController property Controller auto

function OnGameLoad()
	if System==none
		System = Game.GetFormFromFile(0xD62, "BeeingFemale.esm") as FWSystem
	endif
	if bActive==true
		RegisterForSingleUpdateGameTime(2)
		execute()
	else
		SetStage(0)
		SetObjectiveDisplayed(0, false)
		SetObjectiveDisplayed(1, false)
		SetObjectiveDisplayed(2, false)
	endif
endFunction

function OnAddOnActivate()
	if bActive==false
		FW_log.WriteLog("Reminder activated")
		bActive=true
		RegisterForUpdateGameTime(2)
		execute()
	endif
endFunction

function OnAddOnDeactivate()
	if bActive==true
		FW_log.WriteLog("Reminder deactivated")
		bActive=false
		UnregisterForUpdateGameTime()
		SetStage(0)
		SetObjectiveDisplayed(0, false)
		SetObjectiveDisplayed(1, false)
		SetObjectiveDisplayed(2, false)
	endif
endFunction

event OnUpdateGameTime()
	if self==none
		return
	endif
	execute()
	if bActive==true
		RegisterForSingleUpdateGameTime(2)
	endif
endEvent

function execute()
	;actor PlayerRef = Game.GetPlayer()
	If PlayerRef.GetLeveledActorBase().GetSex()==0 || (StorageUtil.FormListFind(none,"FW.SavedNPCs",PlayerRef)<0)
		; Woman not stored
		SetStage(0)
		SetObjectiveDisplayed(0, false)
		SetObjectiveDisplayed(1, false)
		SetObjectiveDisplayed(2, false)
		return
	EndIf
	float Time = GameDaysPassed.GetValue()
	float cDur = System.GetPillDuration(PlayerRef)
	float cTime = StorageUtil.GetFloatValue(PlayerRef,"FW.ContraceptionTime",0)
	float contraception = Controller.getContraceptionTimed(PlayerRef, Time)
	
	if contraception<5
		if GetStage()!=0
		SetStage(0)
		SetObjectiveDisplayed(0, false)
		SetObjectiveDisplayed(1, false)
		SetObjectiveDisplayed(2, false)
		endif
	elseif cTime + cDur + 0.2 < Time
		if GetStage()!=2
		SetStage(2)
		SetObjectiveDisplayed(0, false)
		SetObjectiveDisplayed(1, false)
		SetObjectiveDisplayed(2, true)
		endif
	elseif cTime + (cDur * 0.73) > Time
		if GetStage()!=0
		SetStage(0)
		SetObjectiveDisplayed(0, false)
		SetObjectiveDisplayed(1, false)
		SetObjectiveDisplayed(2, false)
		endif
	else
		if GetStage()!=1
		SetStage(1)
		SetObjectiveDisplayed(0, false)
		SetObjectiveDisplayed(1, true)
		SetObjectiveDisplayed(2, false)
		endif
	endif
endFunction

function OnContraception(Actor Woman, float Amount, float ValueBefore, float ValueAfter, float TimeAgo)
	execute()
endFunction