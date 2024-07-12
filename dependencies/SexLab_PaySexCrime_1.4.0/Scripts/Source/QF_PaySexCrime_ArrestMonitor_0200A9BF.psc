;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname QF_PaySexCrime_ArrestMonitor_0200A9BF Extends Quest Hidden

PaySexCrimeMCM Property PSC_MCM Auto

Faction Property CrimeFactionEastmarch Auto 
Faction Property CrimeFactionFalkreath Auto 
Faction Property CrimeFactionHaafingar Auto 
Faction Property CrimeFactionHjaalmarch Auto 
Faction Property CrimeFactionPale Auto 
Faction Property CrimeFactionReach Auto 
Faction Property CrimeFactionRift Auto 
Faction Property CrimeFactionWhiterun Auto 
Faction Property CrimeFactionWinterhold Auto

;BEGIN ALIAS PROPERTY ArrestingGuard
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ArrestingGuard Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE

Actor ArrestingGuard = Alias_ArrestingGuard.GetReference() as Actor

	;find guards faction
	Faction GuardFac = ArrestingGuard.GetCrimeFaction()
	if GuardFac == CrimeFactionEastmarch
		PSC_MCM.CrimeFaction = 1                 
	elseif GuardFac == CrimeFactionFalkreath
		PSC_MCM.CrimeFaction = 2
	elseif GuardFac == CrimeFactionHaafingar
		PSC_MCM.CrimeFaction = 3
	elseif GuardFac == CrimeFactionHjaalmarch
		PSC_MCM.CrimeFaction = 4			
	elseif GuardFac == CrimeFactionPale
		PSC_MCM.CrimeFaction = 5						
	elseif GuardFac == CrimeFactionReach
		PSC_MCM.CrimeFaction = 6						
	elseif GuardFac == CrimeFactionRift
		PSC_MCM.CrimeFaction = 7							
	elseif GuardFac == CrimeFactionWhiterun
		PSC_MCM.CrimeFaction = 8								
	elseif GuardFac == CrimeFactionWinterhold
		PSC_MCM.CrimeFaction = 9
	else
		PSC_MCM.CrimeFaction = 0
	EndIf
	int CrimeFac = PSC_MCM.CrimeFaction

	;if pending bounty
	int TotalBounty = (PSC_MCM.BountyNonViolent[CrimeFac] + PSC_MCM.BountyViolent[CrimeFac]) as int
	if (TotalBounty > 0)
		;add any pending bounty to actual bounty and pardon end penalty
		GuardFac.ModCrimeGold(PSC_MCM.BountyNonViolent[CrimeFac])
		GuardFac.ModCrimeGold(PSC_MCM.BountyViolent[CrimeFac], true)
		int Penalty = 0
		if (PSC_MCM.PSC_PardonEndPenaltySelection)
			Penalty = (PSC_MCM._sliderPercent_PardonEndPenaltyFixed as int)
		else
			Penalty = (((PSC_MCM.BountyNonViolent[CrimeFac] + PSC_MCM.BountyViolent[CrimeFac]) / 100) * (PSC_MCM._sliderPercent_PardonEndPenaltyBounty)) as int
		endif
		GuardFac.ModCrimeGold(Penalty, true)
		PSC_MCM.BountyNonViolent[CrimeFac] = 0
		PSC_MCM.BountyViolent[CrimeFac] = 0
		PSC_MCM.PardonEndTime[CrimeFac] = (Utility.GetCurrentGameTime() * 24)

		;increase tracker
		PSC_MCM.SuccessTracker[CrimeFac] = (PSC_MCM.SuccessTracker[CrimeFac] + 1)
		if (PSC_MCM.SuccessTracker[CrimeFac] > 2000000000)
			PSC_MCM.SuccessTracker[CrimeFac] = 0
		endif
	endif

	Stop()

;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
