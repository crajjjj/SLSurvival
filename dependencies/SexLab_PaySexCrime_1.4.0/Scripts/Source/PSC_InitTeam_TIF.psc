;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname PSC_InitTeam_TIF Extends TopicInfo Hidden

PaySexCrimeMCM Property PSC_MCM Auto
PSC_Functions Property Functions Auto

GlobalVariable Property OralRejected Auto
GlobalVariable Property SexRejected Auto
GlobalVariable Property AnalRejected Auto
GlobalVariable Property MultipleRejected Auto
GlobalVariable Property TeammateModifier Auto

GlobalVariable Property Delay Auto


;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;start

	;delays conversation until script finishes
	Delay.SetValue(1)


	;set dialogue type as team. 
	PSC_MCM.SceneAdditional = "Team"


	if (PSC_MCM.Teammates[0].GetLeveledActorBase().GetSex() == 0)
		TeammateModifier.SetValue(1)
	elseif (PSC_MCM.Teammates[0].GetLeveledActorBase().GetSex() == 1)
		TeammateModifier.SetValue(2)
	endif

	;store guards faction
	Faction GuardFac = PSC_MCM.GuardsCrimeFaction
	int CrimeFac = PSC_MCM.CrimeFaction

	;reset type rejections
	OralRejected.SetValue(0)
	SexRejected.SetValue(0)
	AnalRejected.SetValue(0)
	MultipleRejected.SetValue(0)


	;setup bouty for later use.
	Float Bounty = 0.001

	;Get arousal modifier
	Float Arousal = 1.0
	if (PSC_MCM.PSC_UseArousal)
		faction ArousalFac = (Game.GetFormFromFile(0x0003FC36, "SexLabAroused.esm") as faction)
		If ((ArousalFac != NONE) && (akSpeaker.GetFactionRank(ArousalFac) >= 0))
			Arousal = ((akSpeaker.GetFactionRank(ArousalFac) as Float) / 100.0)
			Arousal = Arousal * Arousal * 10
		EndIf
	endif

	;get same gender modifier
	float GenderModifier = 1.0
	int TeammateSex = PSC_MCM.Teammates[0].GetLeveledActorBase().GetSex()
	int SpeakerSex = akSpeaker.GetLeveledActorBase().GetSex()
	if (TeammateSex == SpeakerSex)
		GenderModifier = ((100.0 - PSC_MCM._sliderPercent_SameGenderPenalty) / 100.0)
	endif


	;update times penalty
	float TimeSince = ((Utility.GetCurrentGameTime() * 24) - PSC_MCM.PSC_TimesPenaltyTracker[CrimeFac])
	PSC_MCM.PSC_TimesPenalty[CrimeFac] = PSC_MCM.PSC_TimesPenalty[CrimeFac] + (TimeSince * PSC_MCM._sliderPercent_TimeDecrease)
	if (PSC_MCM.PSC_TimesPenalty[CrimeFac] > 100.0)
		PSC_MCM.PSC_TimesPenalty[CrimeFac] = 100.0
	endif
	PSC_MCM.PSC_TimesPenaltyTracker[CrimeFac] = (Utility.GetCurrentGameTime() * 24)

	;get times modifier
	float TimesModifier = (PSC_MCM.PSC_TimesPenalty[CrimeFac] / 100)


	;setup modifier.
	Float Modifier = 1.0



	if (StringUtil.Find(PSC_MCM.Extra, "WP") > -1)
		;is WP.

		;get bounty
		Bounty = ((PSC_MCM.BountyNonViolent[CrimeFac] + PSC_MCM.BountyViolent[CrimeFac]) as float)
		if (Bounty < 0.001)
			Bounty = 0.001
		endif


		;get Pardoned Modifier
		float PardonedModifier = (PSC_MCM._sliderPercent_PardonedSexPercent / 100)


		;combine modifiers 	
		Modifier = (Arousal * GenderModifier * TimesModifier * PardonedModifier)



	ElseIf (StringUtil.Find(PSC_MCM.Extra, "BC") > -1)
		;is BC.

		;get bounty
		Bounty = (GuardFac.GetCrimeGold() as float)
		if (Bounty < 0.001)
			Bounty = 0.001
		endif

		;get BC chance Modifier
		float ChanceModifier = (PSC_MCM._sliderPercent_BCSexPercent / 100)

		;combine modifiers 	
		Modifier = (Arousal * GenderModifier * TimesModifier * ChanceModifier)


	ElseIf (StringUtil.Find(PSC_MCM.Extra, "GA") > -1)
		;is GA.


		;imaganary bounty
		Bounty = PSC_MCM._sliderPercent_ApproachBounty
		if (Bounty < 0.001)
			Bounty = 0.001
		endif


		;Approach modifier
		;get Approach Modifier
		float ApproachModifier = (PSC_MCM._sliderPercent_ApproachSexPercent / 100)



		;combine modifiers 	
		Modifier = (Arousal * GenderModifier * ApproachModifier)


	Else
		;is standard.


		;get bounty
		Bounty = (GuardFac.GetCrimeGold() as float)
		if (Bounty < 0.001)
			Bounty = 0.001
		endif

		;combine modifiers 	
		Modifier = (Arousal * GenderModifier * TimesModifier)


	EndIf


	; oral
	Functions.RejectionCalc (OralRejected, PSC_MCM.PSC_RejectSelection_Oral, PSC_MCM._sliderPercent_RejectBounty_Oral, Bounty, PSC_MCM._sliderPercent_RejectFixed_Oral, Modifier)

	; sex
	Functions.RejectionCalc (SexRejected, PSC_MCM.PSC_RejectSelection_Sex, PSC_MCM._sliderPercent_RejectBounty_Sex, Bounty, PSC_MCM._sliderPercent_RejectFixed_Sex, Modifier)

	; Anal
	Functions.RejectionCalc (AnalRejected, PSC_MCM.PSC_RejectSelection_Anal, PSC_MCM._sliderPercent_RejectBounty_Anal, Bounty, PSC_MCM._sliderPercent_RejectFixed_Anal, Modifier)

	; Multiple
	Functions.RejectionCalc (MultipleRejected, PSC_MCM.PSC_RejectSelection_Multiple, PSC_MCM._sliderPercent_RejectBounty_Multiple, Bounty, PSC_MCM._sliderPercent_RejectFixed_Multiple, Modifier)


	;end delay
	Delay.SetValue(0)
	;Debug.Notification("What should they do?")

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
