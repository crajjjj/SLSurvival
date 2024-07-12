;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname PSC_Privacy_TIF Extends TopicInfo Hidden

PaySexCrimeMCM Property PSC_MCM Auto
PSC_Functions Property Functions Auto
PSC_ApproachStart Property ApproachStart Auto

Quest Property GuardApproachQuest  Auto

ReferenceAlias Property PrimaryGuard  Auto
ReferenceAlias Property SecondaryGuard  Auto
ReferenceAlias Property PrimaryTeammate  Auto

GlobalVariable Property PrivacyStatus Auto

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE

;start

	PrivacyStatus.SetValue(1)

	if (StringUtil.Find(PSC_MCM.Extra, "GA") > -1)
		;ApproachStart.ApproachStop() 	;stop at start of dialog.
		GuardApproachQuest.Stop()
	EndIf

	Actor SecondaryGuardRef = SecondaryGuard.GetActorRef()
	Actor PrimaryTeammateRef = PrimaryTeammate.GetActorRef()

	Int Participants = 0
	If (SecondaryGuardRef != None)
		Participants += 1
	EndIf
	If (PrimaryTeammateRef != None)
		Participants += 2
	EndIf

	Float Patience = 60.0

	Int CrimeFac = PSC_MCM.CrimeFaction
	Faction GuardFac = PSC_MCM.GuardsCrimeFaction
	Int CrimeGold = 0
	Bool Dead = False
	Float Status = 1
	Float TimeUp = (Utility.GetCurrentGameTime() * 24) + (Patience / 60)
	Bool Time = True


	;cant check none for dead.
	If (Participants == 1)
		while ( (!(CrimeGold > 0) && !Dead && !(Status < 1) && Time) || (UI.IsMenuOpen("Dialogue Menu")) )
			Utility.Wait(1)
			CrimeGold = GuardFac.GetCrimeGold()
			If (akSpeaker.IsDead() || SecondaryGuardRef.IsDead())
				Dead = True
			Endif
			If ((Utility.GetCurrentGameTime() * 24) > TimeUp)
				Time = False
			Endif
			Status = PrivacyStatus.GetValue()
		endWhile
	ElseIf (Participants == 2)
		while ( (!(CrimeGold > 0) && !Dead && !(Status < 1) && Time) || (UI.IsMenuOpen("Dialogue Menu")) )
			Utility.Wait(1)
			CrimeGold = GuardFac.GetCrimeGold()
			If (akSpeaker.IsDead() || PrimaryTeammateRef.IsDead())
				Dead = True
			Endif
			If ((Utility.GetCurrentGameTime() * 24) > TimeUp)
				Time = False
			Endif
			Status = PrivacyStatus.GetValue()
		endWhile
	ElseIf (Participants == 3)
		while ( (!(CrimeGold > 0) && !Dead && !(Status < 1) && Time) || (UI.IsMenuOpen("Dialogue Menu")) )
			Utility.Wait(1)
			CrimeGold = GuardFac.GetCrimeGold()
			If (akSpeaker.IsDead() || SecondaryGuardRef.IsDead() || PrimaryTeammateRef.IsDead())
				Dead = True
			Endif
			If ((Utility.GetCurrentGameTime() * 24) > TimeUp)
				Time = False
			Endif
			Status = PrivacyStatus.GetValue()
		endWhile
	Else
		while ( (!(CrimeGold > 0) && !Dead && !(Status < 1) && Time) || (UI.IsMenuOpen("Dialogue Menu")) )
			Utility.Wait(1)
			CrimeGold = GuardFac.GetCrimeGold()
			If (akSpeaker.IsDead())
				Dead = True
			Endif
			If ((Utility.GetCurrentGameTime() * 24) > TimeUp)
				Time = False
			Endif
			Status = PrivacyStatus.GetValue()
		endWhile
	EndIf


	If (Status != 0)
		If (CrimeGold > 0)
			;Debug.Notification("Crime")
			;comited crime.

		ElseIf  (Dead)
			;Debug.Notification("Dead")
			;Someone died.

		ElseIf (!Time)
			;Debug.Notification("Time")
			;Ran out of time.

		Endif

		if (StringUtil.Find(PSC_MCM.Extra, "WP") > -1)
			Functions.AliasClear()
			PrivacyStatus.SetValue(0)

		Elseif (StringUtil.Find(PSC_MCM.Extra, "BC") > -1)

			Functions.AliasClear()
			PrivacyStatus.SetValue(0)

			;Add stored bounty
			GuardFac.ModCrimeGold(PSC_MCM.BountyNonViolent[CrimeFac])
			GuardFac.ModCrimeGold(PSC_MCM.BountyViolent[CrimeFac], true)
			PSC_MCM.BountyNonViolent[CrimeFac] = 0
			PSC_MCM.BountyViolent[CrimeFac] = 0

			;Bounty collector attacks.
			;akSpeaker.StartCombat(Game.GetPlayer())
			getOwningQuest().setstage(95)

		ElseIf (StringUtil.Find(PSC_MCM.Extra, "GA") > -1)
			Functions.AliasClear()
			PrivacyStatus.SetValue(0)

			;penalty dies with the guard.
			If !(akSpeaker.IsDead())
				;refuse penalty.
				int Penalty = 0
				Penalty = (PSC_MCM._sliderPercent_ApproachRefusePenalty as int)
				GuardFac.ModCrimeGold(Penalty, true)
			EndIf

		else
			Functions.AliasClear()
			PrivacyStatus.SetValue(0)

			;Add stored bounty
			GuardFac.ModCrimeGold(PSC_MCM.BountyNonViolent[CrimeFac])
			GuardFac.ModCrimeGold(PSC_MCM.BountyViolent[CrimeFac], true)
			PSC_MCM.BountyNonViolent[CrimeFac] = 0
			PSC_MCM.BountyViolent[CrimeFac] = 0


		EndIf

		If (StringUtil.Find(PSC_MCM.Extra, "GA") > -1)
			;setup for new approach.
			PSC_MCM.ApproachStageDelay = 0.0
			ApproachStart.StageDelay(0)
		EndIf


	Else
		If (StringUtil.Find(PSC_MCM.Extra, "BC") > -1)

			getOwningQuest().setstage(100)

		EndIf

	EndIf
	;Privacy completed.




;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;end
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
