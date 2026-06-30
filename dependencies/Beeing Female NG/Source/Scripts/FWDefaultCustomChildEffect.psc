Scriptname FWDefaultCustomChildEffect extends ActiveMagicEffect

FWAddOnManager property BF_AddOnManager auto
Spell Property _BF_DefaultCustomChildSpell Auto
MagicEffect Property _BF_DefaultCustomChildEffect Auto
GlobalVariable Property GameDaysPassed Auto

float DayOfBirth
float CurrentAgeInHours
float MatureTimeInHours

float MatureTimeStep
float ScaleStep

int MatureStep
float initialScale
float finalScale

float CurrentScale
int CurrentMatureStep

Actor TargetActor

Event OnEffectStart(Actor akTarget, Actor akCaster)
;	FW_log.WriteLog("FWDefaultCustomChildEffect: akTarget = " + akTarget + ", and akCaster = " + akCaster)
	TargetActor = akTarget
	DayOfBirth = StorageUtil.GetFloatValue(TargetActor, "FW.Child.DOB", -1)

	actor Mother = StorageUtil.GetFormValue(TargetActor, "FW.Child.Mother", none) as actor
	actor ParentActor = StorageUtil.GetFormValue(TargetActor, "FW.Child.ParentActor", none) as actor
	if(ParentActor)
	else
		ParentActor = Mother
	endIf
	

	finalScale = BF_AddOnManager.ActorFinalScale(ParentActor)

	if(DayOfBirth == -1)
		FW_log.WriteLog("FWDefaultCustomChildEffect: Started for the first time on actor: " + akTarget + " by caster: " + akCaster)
		DayOfBirth = GameDaysPassed.GetValue()

		StorageUtil.SetFloatValue(TargetActor, "FW.Child.DOB", DayOfBirth)
		StorageUtil.SetIntValue(TargetActor, "FW.Child.IsCustomChildActor", 1)

		MatureTimeInHours = BF_AddOnManager.ActorCustomMatureTimeInHours(ParentActor)
		if(MatureTimeInHours > 0)
			MatureStep = BF_AddOnManager.ActorMatureStep(ParentActor)
			MatureTimeStep = MatureTimeInHours / MatureStep

			if MatureTimeStep < 1.0	; Must NOT be smaller than 1, else the frequent call of SetScale() in "FWDefaultCustomChildEffect" script may cause CTD!
				MatureTimeStep = 1.0
			endIf

			ScaleStep = BF_AddOnManager.ActorMatureScaleStep(ParentActor)		
			initialScale = BF_AddOnManager.ActorInitialScale(ParentActor)
				
			TargetActor.SetScale(initialScale)

	;		FW_log.WriteLog("FWDefaultCustomChildEffect: MatureStep = " + MatureStep)
	;		FW_log.WriteLog("FWDefaultCustomChildEffect: MatureTime = " + MatureTimeInHours + " hours")
	;		FW_log.WriteLog("FWDefaultCustomChildEffect: initialScale = " + initialScale)
	;		FW_log.WriteLog("FWDefaultCustomChildEffect: finalScale = " + finalScale)
	;		FW_log.WriteLog("FWDefaultCustomChildEffect: MatureTimeStep = " + MatureTimeStep + " hours")
	;		FW_log.WriteLog("FWDefaultCustomChildEffect: ScaleStep = " + ScaleStep)
				
			RegisterForSingleUpdateGameTime(MatureTimeStep)
		else
			FinalizeMature()
		endIf
	else
		FW_log.WriteLog("FWDefaultCustomChildEffect: restarted for some reason on actor: " + akTarget + " by caster: " + akCaster)

		CurrentAgeInHours = 24 * (GameDaysPassed.GetValue() - DayOfBirth)
		MatureTimeInHours = BF_AddOnManager.ActorCustomMatureTimeInHours(ParentActor)
		if(CurrentAgeInHours < MatureTimeInHours)
			if(MatureTimeInHours > 0)
				MatureStep = BF_AddOnManager.ActorMatureStep(ParentActor)
				MatureTimeStep = MatureTimeInHours / MatureStep

				if MatureTimeStep < 1.0	; Must NOT be smaller than 1, else the frequent call of SetScale() in "FWDefaultCustomChildEffect" script may cause CTD!
					MatureTimeStep = 1.0
				endIf

				ScaleStep = BF_AddOnManager.ActorMatureScaleStep(ParentActor)		
				initialScale = BF_AddOnManager.ActorInitialScale(ParentActor)
					
		;		FW_log.WriteLog("FWDefaultCustomChildEffect: MatureStep = " + MatureStep)
		;		FW_log.WriteLog("FWDefaultCustomChildEffect: MatureTime = " + MatureTimeInHours + " hours")
		;		FW_log.WriteLog("FWDefaultCustomChildEffect: initialScale = " + initialScale)
		;		FW_log.WriteLog("FWDefaultCustomChildEffect: finalScale = " + finalScale)
		;		FW_log.WriteLog("FWDefaultCustomChildEffect: MatureTimeStep = " + MatureTimeStep + " hours")
		;		FW_log.WriteLog("FWDefaultCustomChildEffect: ScaleStep = " + ScaleStep)
					
				RegisterForSingleUpdate(1.0)
			else
				FinalizeMature()
			endIf
		else
			FinalizeMature()
		endIf
	endIf
EndEvent

Event OnUpdate()
	CurrentAgeInHours = 24 * (GameDaysPassed.GetValue() - DayOfBirth)
	CurrentMatureStep = (CurrentAgeInHours / MatureTimeStep) as int

	if(CurrentAgeInHours < MatureTimeInHours)
		CurrentScale = initialScale + (CurrentMatureStep * ScaleStep)
		TargetActor.SetScale(CurrentScale)

;		FW_log.WriteLog("FWDefaultCustomChildEffect: CurrentMatureStep = " + CurrentMatureStep)
;		FW_log.WriteLog("FWDefaultCustomChildEffect: CurrentScale = " + CurrentScale)
		RegisterForSingleUpdateGameTime(MatureTimeStep)
	else
		FinalizeMature()
	endIf
EndEvent

Event OnUpdateGameTime()
	CurrentAgeInHours = 24 * (GameDaysPassed.GetValue() - DayOfBirth)
	CurrentMatureStep = (CurrentAgeInHours / MatureTimeStep) as int

	if(CurrentAgeInHours < MatureTimeInHours)
		CurrentScale = initialScale + (CurrentMatureStep * ScaleStep)
		TargetActor.SetScale(CurrentScale)

;		FW_log.WriteLog("FWDefaultCustomChildEffect: CurrentMatureStep = " + CurrentMatureStep)
;		FW_log.WriteLog("FWDefaultCustomChildEffect: CurrentScale = " + CurrentScale)
		RegisterForSingleUpdateGameTime(MatureTimeStep)
	else
		FinalizeMature()
	endIf
endEvent

Function FinalizeMature()
;	FW_log.WriteLog("FWDefaultCustomChildEffect: Finished mature process. Removing...")
	TargetActor.SetScale(finalScale)
	BF_AddOnManager.AddToSLandBF(TargetActor)
	if StorageUtil.GetIntValue(TargetActor, "FW.Child.GrownUp", 0) == 1
		; Already graduated - FinalizeMature re-runs on every effect restart
		return
	endif
	actor ParentActor = StorageUtil.GetFormValue(TargetActor, "FW.Child.ParentActor", none) as actor
	if ParentActor
	else
		ParentActor = StorageUtil.GetFormValue(TargetActor, "FW.Child.Mother", none) as actor
	endIf
	if BF_AddOnManager.ActorGrowUpToAdult(ParentActor)
		BF_AddOnManager.System.GrowChildToAdult(TargetActor)
	endif
endFunction

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	if !TargetActor
		return
	endif
	if StorageUtil.GetIntValue(TargetActor, "FW.Child.GrownUp", 0) == 1
		; The child just grew into an adult and is being deleted - no recast
		return
	endif
	if TargetActor.IsDead()
		FW_log.WriteLog("FWDefaultCustomChildEffect: OnEffectFinish on dead actor. Skipping recast logic.")
		return
	endif

	if(TargetActor.Is3DLoaded())
		FW_log.WriteLog("FWDefaultCustomChildEffect: Finished for some unknown reason!")
		if((!TargetActor.HasSpell(_BF_DefaultCustomChildSpell)) || (!TargetActor.HasMagicEffect(_BF_DefaultCustomChildEffect)))
			FW_log.WriteLog("FWDefaultCustomChildEffect: re-casting!")
			if !TargetActor.IsDead()
				Utility.Wait(5)
				TargetActor.AddSpell(_BF_DefaultCustomChildSpell)
			endIf
		endIf
	else
		FW_log.WriteLog("FWDefaultCustomChildEffect: Finished as player is far away from the actor " + TargetActor)
		StorageUtil.SetIntValue(TargetActor, "FW.Child.DispelledCustomChildActor", 1)
	endIf
endEvent

Event OnDeath(Actor akKiller)
	StorageUtil.SetFloatValue(TargetActor, "FW.Child.DOD", GameDaysPassed.GetValue())

	StorageUtil.SetIntValue(TargetActor, "FW.Child.DispelledCustomChildActor", 0)
	StorageUtil.UnsetIntValue(TargetActor, "FW.Child.DispelledCustomChildActor")

	FWChildActor ca = akKiller as FWChildActor
	if(ca && !ca.IsDead())
		ca.AddExp(TargetActor.GetLevel() * 2)
	endif
endEvent
