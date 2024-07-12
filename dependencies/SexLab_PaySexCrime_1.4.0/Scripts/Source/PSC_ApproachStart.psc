Scriptname PSC_ApproachStart extends Quest

PaySexCrimeMCM Property PSC_MCM Auto
PSC_QuestScript Property QuestScript Auto

Quest Property GuardApproachQuest  Auto


Function StopRun()
	GuardApproachQuest.Stop()
endfunction

Function StopApproach()
	UnRegisterForUpdateGameTime()
	;increase approach tracker
	PSC_MCM.ApproachTracker += 1
	if (PSC_MCM.ApproachTracker > 2000000000)
		PSC_MCM.ApproachTracker = 0
	endif
endfunction

Function StageDelay(Int Stage)

	StopApproach()
	Int TrackerNum = PSC_MCM.ApproachTracker

	If (stage == 0)
		If (PSC_MCM.ApproachStageDelay < 0.025)
			Utility.WaitGameTime(PSC_MCM.ApproachStageDelay)
			If (TrackerNum == PSC_MCM.ApproachTracker)
				StageOne()
			EndIf
		Else
			PSC_MCM.UpdateType = 0
			RegisterForSingleUpdateGameTime(PSC_MCM.ApproachStageDelay)
		EndIf
	ElseIf (stage == 1)
			;
	ElseIf (Stage == 2)
		If (PSC_MCM.ApproachStageDelay < 0.025)
			Utility.WaitGameTime(PSC_MCM.ApproachStageDelay)
			If (TrackerNum == PSC_MCM.ApproachTracker)
				StartLoop()
			EndIf
		Else
			PSC_MCM.UpdateType = 2
			RegisterForSingleUpdateGameTime(PSC_MCM.ApproachStageDelay)
		EndIf
	EndIf

EndFunction

Function StageOne()

	StopApproach()

	Int TrackerNum = PSC_MCM.ApproachTracker
	Float WaitTime = (PSC_MCM._sliderPercent_ApproachTriggerTime / 60)

	float StartDelay = Utility.RandomFloat(1.0, 5.0)
	;random number between 1 and 25, (weighted to lower number).
	StartDelay = StartDelay * StartDelay
	StartDelay = StartDelay - 1.0
	StartDelay = StartDelay * (PSC_MCM._sliderPercent_ApproachDelayMultiplier / 100)

	WaitTime += StartDelay

	If (WaitTime < 0.025)
		Utility.WaitGameTime(WaitTime)
		If (TrackerNum == PSC_MCM.ApproachTracker)
			;generate base
			float SuccessBase = Utility.RandomFloat(0.0, 100.0)
			;check roll is greater than base
			if (SuccessBase > (PSC_MCM._sliderPercent_ApproachTriggerChance))
				StageOne()
			Else
				StartLoop()
			EndIf
		EndIf
	Else
		PSC_MCM.UpdateType = 1
		RegisterForSingleUpdateGameTime(WaitTime)
	EndIf
EndFunction


Function StartLoop()

	StopApproach()

	Int TrackerNum = PSC_MCM.ApproachTracker
	Location Holder = Game.GetPlayer().GetCurrentLocation()
	Float StartTime = (Utility.GetCurrentGameTime() * 24)
	Float TimePassed = 0.0
	Int StopStatus = QuestScript.ShouldLookingStop(Holder)

	Int i = 0
	;should it start.
	If (StopStatus > 0)
		i = 0
	Else
		i = 1
	EndIf
	While (i == 1)
		;try to start.
		;dont start if player is having sex, suspend not good enough.
		If !(QuestScript.ShouldApproachSuspend())
			GuardApproachQuest.Start()
			;Debug.Notification("start")
		EndIf
		;Wait before trying again.
		;10 seconds
		Utility.Wait(10.0)
		;check if should stop.
		TimePassed = ((Utility.GetCurrentGameTime() * 24) - StartTime)
		StopStatus = QuestScript.ShouldLookingStop(Holder)

		;Debug.Notification("check")
		If ( (StopStatus > 0) || (TrackerNum != PSC_MCM.ApproachTracker) || (TimePassed > (PSC_MCM._sliderPercent_ApproachTimeOut / 60)) )
			i = 0
		EndIf
	EndWhile
	If (TrackerNum == PSC_MCM.ApproachTracker)
		If (Stopstatus == 1)
			;dont start again, leave it to location trigger.
		Else
			PSC_MCM.ApproachStageDelay = 0.0
			StageDelay(0)
		EndIf
	EndIf
endfunction


Event OnUpdateGameTime()
	If (PSC_MCM.UpdateType == 0)
		StageOne()
	ElseIf (PSC_MCM.UpdateType == 1)
		;generate base
		float SuccessBase = Utility.RandomFloat(0.0, 100.0)
		;check roll is greater than base
		if (SuccessBase > (PSC_MCM._sliderPercent_ApproachTriggerChance))
			StageOne()
		Else
			StartLoop()
		EndIf
	ElseIf (PSC_MCM.UpdateType == 2)
		StartLoop()
	EndIf
EndEvent