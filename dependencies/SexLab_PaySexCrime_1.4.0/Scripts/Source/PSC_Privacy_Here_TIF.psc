;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname PSC_Privacy_Here_TIF Extends TopicInfo Hidden

PaySexCrimeMCM Property PSC_MCM Auto
PSC_QuestScript Property QuestScript Auto
PSC_Functions Property Functions Auto
PSC_Scenes Property Scenes Auto
PSC_ApproachStart Property ApproachStart Auto

ReferenceAlias Property PrimaryGuard  Auto
ReferenceAlias Property SecondaryGuard  Auto
ReferenceAlias Property PrimaryTeammate  Auto

GlobalVariable Property PrivacyStatus Auto


;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;start
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE

;end

	;increase tracker
	PSC_MCM.SuccessTracker[PSC_MCM.CrimeFaction] = (PSC_MCM.SuccessTracker[PSC_MCM.CrimeFaction] + 1)
	if (PSC_MCM.SuccessTracker[PSC_MCM.CrimeFaction] > 2000000000)
		PSC_MCM.SuccessTracker[PSC_MCM.CrimeFaction] = 0
	endif

	;End Privacy loop.
	PrivacyStatus.SetValue(0)

	;store crimefaction number.
	Faction GuardFac = PSC_MCM.GuardsCrimeFaction
	int CrimeFac = PSC_MCM.CrimeFaction
	;store tracker num.
	int TrackerNum = PSC_MCM.SuccessTracker[CrimeFac]


	if (StringUtil.Find(PSC_MCM.SceneMain, "Anal") > -1)
;Anal
		if (StringUtil.Find(PSC_MCM.SceneAdditional, "Team") > -1)
			;Teammate scene
			Scenes.Anal(PrimaryTeammate.GetActorRef(), akspeaker)
		Else
			;Player scene
			Scenes.Anal(Game.GetPlayer(), akspeaker)
		Endif

		;for payment modifier.
		if (StringUtil.Find(PSC_MCM.Extra, "WP") > -1)
			;While Pardoned
			Functions.Payment(PSC_MCM._sliderPercent_PaymentFixed_Anal, PSC_MCM._sliderPercent_PaymentBounty_Anal, (PSC_MCM._sliderPercent_PaymentPercent / 100), CrimeFac)
		Elseif (StringUtil.Find(PSC_MCM.Extra, "BC") > -1)
			;BountyCollecter
			Functions.Payment(PSC_MCM._sliderPercent_PaymentFixed_Anal, PSC_MCM._sliderPercent_PaymentBounty_Anal, (PSC_MCM._sliderPercent_BCPaymentPercent / 100), CrimeFac)
		Elseif (StringUtil.Find(PSC_MCM.Extra, "GA") > -1)
			;GuardApproach
		else
			;no special modifier
			Functions.Payment(PSC_MCM._sliderPercent_PaymentFixed_Anal, PSC_MCM._sliderPercent_PaymentBounty_Anal, 1.0, CrimeFac)
		endif

		if ((PSC_MCM.BountyNonViolent[CrimeFac] + PSC_MCM.BountyViolent[CrimeFac]) > 0)
			;for pardon modifier.
			if (StringUtil.Find(PSC_MCM.Extra, "WP") > -1)
				;While Pardoned
				Functions.SetPardonEnd(PSC_MCM._sliderPercent_PardonTime_Anal, (PSC_MCM._sliderPercent_PardonPercent / 100), PSC_MCM.PSC_PardonAdd, CrimeFac)
			Elseif (StringUtil.Find(PSC_MCM.Extra, "BC") > -1)
				;BountyCollecter
				Functions.SetPardonEnd(PSC_MCM._sliderPercent_PardonTime_Anal, (PSC_MCM._sliderPercent_BCPardonPercent / 100), False, CrimeFac)
				Functions.SetPardonEnd(PSC_MCM._sliderPercent_BCPardonFixed, 1.0, True, CrimeFac)
			Elseif (StringUtil.Find(PSC_MCM.Extra, "GA") > -1)
				;GuardApproach
			else
				;no special modifier
				Functions.SetPardonEnd(PSC_MCM._sliderPercent_PardonTime_Anal, 1.0, False, CrimeFac)
			endif
		Endif


	Elseif (StringUtil.Find(PSC_MCM.SceneMain, "Multiple") > -1)
;Multiple
		if (StringUtil.Find(PSC_MCM.SceneAdditional, "4") > -1)
			;foursome
			;MM get anal.
			int PlayerSex = Game.GetPlayer().GetActorBase().GetSex()
			int TeammateSex = PrimaryTeammate.GetActorRef().GetLeveledActorBase().GetSex()
			int SpeakerSex = akSpeaker.GetLeveledActorBase().GetSex()
			int Guard2Sex = SecondaryGuard.GetActorRef().GetLeveledActorBase().GetSex()
			if ((PlayerSex + SpeakerSex) == 0)
				Scenes.Anal(Game.GetPlayer(), akspeaker)
			Else
				Scenes.SexAny(Game.GetPlayer(), akspeaker)
			Endif
			if ((TeammateSex + Guard2Sex) == 0)
				Scenes.Anal(PrimaryTeammate.GetActorRef(), SecondaryGuard.GetActorRef())
			Else
				Scenes.SexAny(PrimaryTeammate.GetActorRef(), SecondaryGuard.GetActorRef())
			Endif
		elseif (StringUtil.Find(PSC_MCM.SceneAdditional, "TW") > -1)
			;threesome 1 guard
			int PlayerSex = Game.GetPlayer().GetActorBase().GetSex()
			int TeammateSex = PrimaryTeammate.GetActorRef().GetLeveledActorBase().GetSex()
			int SpeakerSex = akSpeaker.GetLeveledActorBase().GetSex()
			Int GenderCombo = (PlayerSex + TeammateSex + SpeakerSex)
			If (GenderCombo == 0)
				;all male.
				Scenes.Multiple(PrimaryTeammate.GetActorRef(), Game.GetPlayer(), akspeaker)
			ElseIf (GenderCombo == 1)
				;2 male 1 female.
				if (TeammateSex == 1)
					;teammate is the female.
					Scenes.Multiple(PrimaryTeammate.GetActorRef(), Game.GetPlayer(), akspeaker)
				ElseIf(PlayerSex == 1)
					;player is the female.
					Scenes.Multiple(Game.GetPlayer(), PrimaryTeammate.GetActorRef(), akspeaker)
				Else
					;guard is the female.
					Scenes.Multiple(akspeaker, PrimaryTeammate.GetActorRef(), Game.GetPlayer())
				EndIf
			ElseIf (GenderCombo == 2)
				;1 male 2 female.
				if (SpeakerSex == 0)
					;guard is the male.
					Scenes.MultipleTW(PrimaryTeammate.GetActorRef(), Game.GetPlayer(), akspeaker)
				ElseIf(PlayerSex == 0)
					;player is the male.
					Scenes.Multiple(PrimaryTeammate.GetActorRef(), akspeaker, Game.GetPlayer())
				Else
					;teammate is the male.
					Scenes.Multiple(Game.GetPlayer(), akspeaker, PrimaryTeammate.GetActorRef())
				EndIf
			Else
				;all female.
				Scenes.MultipleAny(PrimaryTeammate.GetActorRef(), Game.GetPlayer(), akspeaker)
			EndIf
		Else
			;threesome 2 guards
			if (StringUtil.Find(PSC_MCM.SceneAdditional, "Team") > -1)
				;Teammate scene
				Scenes.Multiple(PrimaryTeammate.GetActorRef(), akspeaker, SecondaryGuard.GetActorRef())
			Else
				;Player scene
				Scenes.Multiple(Game.GetPlayer(), akspeaker, SecondaryGuard.GetActorRef())
			Endif
		endif

		;for payment modifier.
		if (StringUtil.Find(PSC_MCM.Extra, "WP") > -1)
			;While Pardoned
			Functions.Payment(PSC_MCM._sliderPercent_PaymentFixed_Multiple, PSC_MCM._sliderPercent_PaymentBounty_Multiple, (PSC_MCM._sliderPercent_PaymentPercent / 100), CrimeFac)
		Elseif (StringUtil.Find(PSC_MCM.Extra, "BC") > -1)
			;BountyCollecter
			Functions.Payment(PSC_MCM._sliderPercent_PaymentFixed_Multiple, PSC_MCM._sliderPercent_PaymentBounty_Multiple, (PSC_MCM._sliderPercent_BCPaymentPercent / 100), CrimeFac)
		Elseif (StringUtil.Find(PSC_MCM.Extra, "GA") > -1)
			;GuardApproach
		else
			;no special modifier
			Functions.Payment(PSC_MCM._sliderPercent_PaymentFixed_Multiple, PSC_MCM._sliderPercent_PaymentBounty_Multiple, 1.0, CrimeFac)
		endif

		if ((PSC_MCM.BountyNonViolent[CrimeFac] + PSC_MCM.BountyViolent[CrimeFac]) > 0)
			;for pardon modifier.
			if (StringUtil.Find(PSC_MCM.Extra, "WP") > -1)
				;While Pardoned
				Functions.SetPardonEnd(PSC_MCM._sliderPercent_PardonTime_Multiple, (PSC_MCM._sliderPercent_PardonPercent / 100), PSC_MCM.PSC_PardonAdd, CrimeFac)
			Elseif (StringUtil.Find(PSC_MCM.Extra, "BC") > -1)
				;BountyCollecter
				Functions.SetPardonEnd(PSC_MCM._sliderPercent_PardonTime_Multiple, (PSC_MCM._sliderPercent_BCPardonPercent / 100), False, CrimeFac)
				Functions.SetPardonEnd(PSC_MCM._sliderPercent_BCPardonFixed, 1.0, True, CrimeFac)
			Elseif (StringUtil.Find(PSC_MCM.Extra, "GA") > -1)
				;GuardApproach
			else
				;no special modifier
				Functions.SetPardonEnd(PSC_MCM._sliderPercent_PardonTime_Multiple, 1.0, False, CrimeFac)
			endif
		Endif


	elseif  (StringUtil.Find(PSC_MCM.SceneMain, "Oral") > -1)
;Oral
		if (StringUtil.Find(PSC_MCM.SceneAdditional, "Female") > -1)
			if (StringUtil.Find(PSC_MCM.SceneAdditional, "Team") > -1)
				;Teammate scene
				Scenes.OralF(PrimaryTeammate.GetActorRef(), akspeaker)
			Else
				;Player scene
				Scenes.OralF(Game.GetPlayer(), akspeaker)
			Endif
		elseif (StringUtil.Find(PSC_MCM.SceneAdditional, "Male") > -1)
			if (StringUtil.Find(PSC_MCM.SceneAdditional, "Team") > -1)
				;Teammate scene
				Scenes.OralM(PrimaryTeammate.GetActorRef(), akspeaker)
			Else
				;Player scene
				Scenes.OralM(Game.GetPlayer(), akspeaker)
			Endif
		endif

		;for payment modifier.
		if (StringUtil.Find(PSC_MCM.Extra, "WP") > -1)
			;While Pardoned
			Functions.Payment(PSC_MCM._sliderPercent_PaymentFixed_Oral, PSC_MCM._sliderPercent_PaymentBounty_Oral, (PSC_MCM._sliderPercent_PaymentPercent / 100), CrimeFac)
		Elseif (StringUtil.Find(PSC_MCM.Extra, "BC") > -1)
			;BountyCollecter
			Functions.Payment(PSC_MCM._sliderPercent_PaymentFixed_Oral, PSC_MCM._sliderPercent_PaymentBounty_Oral, (PSC_MCM._sliderPercent_BCPaymentPercent / 100), CrimeFac)
		Elseif (StringUtil.Find(PSC_MCM.Extra, "GA") > -1)
			;GuardApproach
		else
			;no special modifier
			Functions.Payment(PSC_MCM._sliderPercent_PaymentFixed_Oral, PSC_MCM._sliderPercent_PaymentBounty_Oral, 1.0, CrimeFac)
		endif

		if ((PSC_MCM.BountyNonViolent[CrimeFac] + PSC_MCM.BountyViolent[CrimeFac]) > 0)
			;for pardon modifier.
			if (StringUtil.Find(PSC_MCM.Extra, "WP") > -1)
				;While Pardoned
				Functions.SetPardonEnd(PSC_MCM._sliderPercent_PardonTime_Oral, (PSC_MCM._sliderPercent_PardonPercent / 100), PSC_MCM.PSC_PardonAdd, CrimeFac)
			Elseif (StringUtil.Find(PSC_MCM.Extra, "BC") > -1)
				;BountyCollecter
				Functions.SetPardonEnd(PSC_MCM._sliderPercent_PardonTime_Oral, (PSC_MCM._sliderPercent_BCPardonPercent / 100), False, CrimeFac)
				Functions.SetPardonEnd(PSC_MCM._sliderPercent_BCPardonFixed, 1.0, True, CrimeFac)
			Elseif (StringUtil.Find(PSC_MCM.Extra, "GA") > -1)
				;GuardApproach
			else
				;no special modifier
				Functions.SetPardonEnd(PSC_MCM._sliderPercent_PardonTime_Oral, 1.0, False, CrimeFac)
			endif
		Endif


	elseif  (StringUtil.Find(PSC_MCM.SceneMain, "Sex") > -1)
;Sex
		if (StringUtil.Find(PSC_MCM.SceneAdditional, "Give") > -1)
			if (StringUtil.Find(PSC_MCM.SceneAdditional, "Team") > -1)
				;Teammate scene
				Scenes.Sex(akspeaker, PrimaryTeammate.GetActorRef())
			Else
				;Player scene
				Scenes.Sex(akspeaker, Game.GetPlayer())
			Endif
		elseif (StringUtil.Find(PSC_MCM.SceneAdditional, "Take") > -1)
			if (StringUtil.Find(PSC_MCM.SceneAdditional, "Team") > -1)
				;Teammate scene
				Scenes.Sex(PSC_MCM.Teammates[0], akspeaker)
			Else
				;Player scene
				Scenes.Sex(Game.GetPlayer(), akspeaker)
			Endif
		endif

		;for payment modifier.
		if (StringUtil.Find(PSC_MCM.Extra, "WP") > -1)
			;While Pardoned
			Functions.Payment(PSC_MCM._sliderPercent_PaymentFixed_Sex, PSC_MCM._sliderPercent_PaymentBounty_Sex, (PSC_MCM._sliderPercent_PaymentPercent / 100), CrimeFac)
		Elseif (StringUtil.Find(PSC_MCM.Extra, "BC") > -1)
			;BountyCollecter
			Functions.Payment(PSC_MCM._sliderPercent_PaymentFixed_Sex, PSC_MCM._sliderPercent_PaymentBounty_Sex, (PSC_MCM._sliderPercent_BCPaymentPercent / 100), CrimeFac)
		Elseif (StringUtil.Find(PSC_MCM.Extra, "GA") > -1)
			;GuardApproach
		else
			;no special modifier
			Functions.Payment(PSC_MCM._sliderPercent_PaymentFixed_Sex, PSC_MCM._sliderPercent_PaymentBounty_Sex, 1.0, CrimeFac)
		endif

		if ((PSC_MCM.BountyNonViolent[CrimeFac] + PSC_MCM.BountyViolent[CrimeFac]) > 0)
			;for pardon modifier.
			if (StringUtil.Find(PSC_MCM.Extra, "WP") > -1)
				;While Pardoned
				Functions.SetPardonEnd(PSC_MCM._sliderPercent_PardonTime_Sex, (PSC_MCM._sliderPercent_PardonPercent / 100), PSC_MCM.PSC_PardonAdd, CrimeFac)
			Elseif (StringUtil.Find(PSC_MCM.Extra, "BC") > -1)
				;BountyCollecter
				Functions.SetPardonEnd(PSC_MCM._sliderPercent_PardonTime_Sex, (PSC_MCM._sliderPercent_BCPardonPercent / 100), False, CrimeFac)
				Functions.SetPardonEnd(PSC_MCM._sliderPercent_BCPardonFixed, 1.0, True, CrimeFac)
			Elseif (StringUtil.Find(PSC_MCM.Extra, "GA") > -1)
				;GuardApproach
			else
				;no special modifier
				Functions.SetPardonEnd(PSC_MCM._sliderPercent_PardonTime_Sex, 1.0, False, CrimeFac)
			endif
		Endif

	Endif



	;same for all

	Functions.AliasClear()

	;no timespenalty for approaches.
	If !(StringUtil.Find(PSC_MCM.Extra, "GA") > -1)
		Functions.IncreaseTimesPenalty(CrimeFac)
	Endif

	If (StringUtil.Find(PSC_MCM.Extra, "GA") > -1)
		;wait if player if having sex
		while (Game.GetPlayer().HasKeyWordString("SexLabActive")) 
			Utility.Wait(1)
		endWhile
		;setup for new approach.
		PSC_MCM.ApproachStageDelay = 0.0
		ApproachStart.StageDelay(0)
	EndIf

	;dont run if bounty has been cleared, thus no need for pardon
	if ((PSC_MCM.BountyNonViolent[CrimeFac] + PSC_MCM.BountyViolent[CrimeFac]) > 0)

		;wait if player if having sex
		while (Game.GetPlayer().HasKeyWordString("SexLabActive")) 
			Utility.Wait(1)
		endWhile

		;clear actors could help against longterm persistence.
		akspeaker = None

		;if no new event
		if (TrackerNum == PSC_MCM.SuccessTracker[CrimeFac])
			Functions.WaitOutPardon(CrimeFac)
		endif

		QuestScript.PardonEndCheck(TrackerNum, CrimeFac)

		;if no new events with this faction
		if (TrackerNum == PSC_MCM.SuccessTracker[CrimeFac])
			Functions.PardonEnd(GuardFac, CrimeFac)
		endif
	endif

;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
