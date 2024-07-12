Scriptname PSC_Functions extends Quest  

PaySexCrimeMCM Property PSC_MCM Auto

ReferenceAlias Property PrimaryGuard  Auto
ReferenceAlias Property SecondaryGuard  Auto
ReferenceAlias Property PrimaryTeammate  Auto


	Function Payment(Float PaymentFixed, Float PaymentBounty, Float Modifier, Int CrimeFac)
		;subtract payment using fixed and bounty percentage.
		float NonViolent = (PSC_MCM.BountyNonViolent[CrimeFac] as float)
		float Violent = (PSC_MCM.BountyViolent[CrimeFac] as float)
		float Payment = ((NonViolent + Violent) * (PaymentBounty / 100))
		Payment = ((Payment + PaymentFixed) * Modifier)
		Payment = Math.Ceiling(Payment)

		if (NonViolent <= Payment)
			PSC_MCM.BountyNonViolent[CrimeFac] = 0
			Payment -= NonViolent
			if (Violent <= Payment)
				PSC_MCM.BountyViolent[CrimeFac] = 0
			else
				PSC_MCM.BountyViolent[CrimeFac] = (PSC_MCM.BountyViolent[CrimeFac] - (Payment as int))
			endif
		else
			PSC_MCM.BountyNonViolent[CrimeFac] = (PSC_MCM.BountyNonViolent[CrimeFac] - (Payment as int))
		endif	
	EndFunction



	Function IncreaseTimesPenalty(Int CrimeFac)
		;increase times penalty
		PSC_MCM.PSC_TimesPenalty[CrimeFac] = (PSC_MCM.PSC_TimesPenalty[CrimeFac] - PSC_MCM._sliderPercent_ActIncrease)
		if (PSC_MCM.PSC_TimesPenalty[CrimeFac] < 0.0)
			PSC_MCM.PSC_TimesPenalty[CrimeFac] = 0.0
		endif
	EndFunction



	Function SetPardonEnd(Float PardonAmount, Float Modifier, Bool Add, Int CrimeFac)
		;set when pardon should end, for wait.
		if (Add && (PSC_MCM.PardonEndTime[CrimeFac] > (Utility.GetCurrentGameTime() * 24)))
			PSC_MCM.PardonEndTime[CrimeFac] = (PSC_MCM.PardonEndTime[CrimeFac] + ((PardonAmount / 60) * Modifier))
			;limit pardon to 35 days
			if (PSC_MCM.PardonEndTime[CrimeFac] > ((Utility.GetCurrentGameTime() + 35.0) * 24))
				PSC_MCM.PardonEndTime[CrimeFac] = ((Utility.GetCurrentGameTime() + 35.0) * 24)
			endif
		else
			PSC_MCM.PardonEndTime[CrimeFac] = ((Utility.GetCurrentGameTime() * 24) + ((PardonAmount / 60) * Modifier))
		endif
	EndFunction



	Function WaitOutPardon(Int CrimeFac)
		float PardonWaitTime = (PSC_MCM.PardonEndTime[CrimeFac] - (Utility.GetCurrentGameTime() * 24))

		if (PardonWaitTime > 0.0)
			;wait until pardon time runs out
			Utility.WaitGameTime(PardonWaitTime)
		endif
	EndFunction



	Function PardonEnd(Faction GuardsCrimeFac, Int CrimeFac)
		int Penalty = 0
		if (PSC_MCM.PSC_PardonEndPenaltySelection)
			Penalty = (PSC_MCM._sliderPercent_PardonEndPenaltyFixed as int)
		else
			Penalty = (((PSC_MCM.BountyNonViolent[CrimeFac] + PSC_MCM.BountyViolent[CrimeFac]) / 100) * (PSC_MCM._sliderPercent_PardonEndPenaltyBounty)) as int
		endif
		Debug.Notification((PSC_MCM.BountyNonViolent[CrimeFac] + PSC_MCM.BountyViolent[CrimeFac] + Penalty) + " bounty added to " + GuardsCrimeFac.GetName())
		GuardsCrimeFac.ModCrimeGold(PSC_MCM.BountyNonViolent[CrimeFac])
		GuardsCrimeFac.ModCrimeGold(PSC_MCM.BountyViolent[CrimeFac], true)
		GuardsCrimeFac.ModCrimeGold(Penalty, true)
		PSC_MCM.BountyNonViolent[CrimeFac] = 0
		PSC_MCM.BountyViolent[CrimeFac] = 0
		PSC_MCM.PardonEndTime[CrimeFac] = (Utility.GetCurrentGameTime() * 24)
	EndFunction


	Function AliasClear()
		;Clear alias'.
		PrimaryGuard.Clear()
		SecondaryGuard.Clear()
		PrimaryTeammate.Clear()
	EndFunction




	;Caclulate rejections 
	Function RejectionCalc(GlobalVariable RejectValue, Bool RejectSelection, Float RejectBounty, Float BountyAmount, Float RejectFixed, Float Modifier)
		Float SuccessBase = Utility.RandomFloat(0.0, 100.0)
		if (RejectSelection)
			float SuccessRollTop = ((RejectBounty / BountyAmount) * 100) * Modifier
			float SuccessRoll = Utility.RandomFloat(0.0, SuccessRollTop)
			;check roll is greater than base
			if (SuccessBase > SuccessRoll)
				;rejected
				RejectValue.SetValue(1)
			endif
		else
			;check roll is greater than base
			if (SuccessBase > (RejectFixed * Modifier))
				;rejected
				RejectValue.SetValue(1)
			endif
		endif
	EndFunction