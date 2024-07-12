Scriptname PSC_ApproachRun extends Quest

PaySexCrimeMCM Property PSC_MCM Auto
PSC_QuestScript Property QuestScript Auto
PSC_ApproachStart Property ApproachStart Auto

ReferenceAlias Property ApproachingGuard  Auto



Event OnInit()

	;stop looking start approaching.
	ApproachStart.StopApproach()

	If !PSC_MCM.PSC_AllowApproach
		Stop()
	Else

		;Debug.Notification("Run")


		Int TrackerNum = PSC_MCM.ApproachTracker
		Location Holder = Game.GetPlayer().GetCurrentLocation()
		Float StartTime = (Utility.GetCurrentGameTime() * 24)
		Float TimePassed = 0.0
		Int StopStatus = 0
		Actor ApproachingGuardRef = ApproachingGuard.GetActorRef()

		Int i = 1
		;keep checking if should stop approaching.
		While (i == 1)
			Utility.Wait(1.0)
			;check if should stop.
			TimePassed = ((Utility.GetCurrentGameTime() * 24) - StartTime)
			StopStatus = QuestScript.ShouldApproachStop(Holder, ApproachingGuardRef)
			If ( (StopStatus > 0) || (TrackerNum != PSC_MCM.ApproachTracker) || (TimePassed > (PSC_MCM._sliderPercent_ApproachTimeOut / 60)) )
				i = 0
			Else
				If (QuestScript.ShouldApproachSuspend())
					i = -1
					Stop()
					ApproachStart.StopApproach()
					PSC_MCM.ApproachStageDelay = 0.025
					ApproachStart.StageDelay(2)
					;Debug.Notification("suspended")
				EndIf
			EndIf
		EndWhile
		If (TrackerNum == PSC_MCM.ApproachTracker)
			If (Stopstatus == 1)
				;dont start again, leave it to location trigger.
			Else
				Stop()
				PSC_MCM.ApproachStageDelay = 0.0
				ApproachStart.StageDelay(0)
			EndIf
		EndIf

	EndIf

EndEvent
