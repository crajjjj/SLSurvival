;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PSC_Arrest_TIF Extends TopicInfo Hidden

SexLabFramework Property SexLab Auto

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

GlobalVariable Property MultipleGuards Auto
GlobalVariable Property TeammatesAvailable Auto


;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;start

	;set Dialogue Type to standard.
	PSC_MCM.Extra = ""


	;find guards faction
	Faction GuardFac = akSpeaker.GetCrimeFaction()
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

	PSC_MCM.GuardsCrimeFaction = GuardFac
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

	;clears previous actors.
	PSC_MCM.Teammates[0] = None
	PSC_MCM.Guards[0] = None

	MultipleGuards.SetValue(0)
	TeammatesAvailable.SetValue(0)

	;check the amount of guards and teammates
	int SizeGuards = 0
	int SizeTeammates = 0
	cell c = akSpeaker.GetParentCell()
	int NumRefs = c.GetNumRefs(43)
	while NumRefs 
		NumRefs -= 1
		Actor NPC = c.GetNthRef(NumRefs, 43) as Actor
		If (NPC.IsPlayerTeammate())
			If ((NPC.GetDistance(akSpeaker) < 1000) && !NPC.IsInCombat() && (SizeTeammates < 1) && (NPC != akSpeaker) && SexLab.IsValidActor(NPC))
				PSC_MCM.Teammates[SizeTeammates] = NPC
				SizeTeammates += 1
			Endif
		elseIf (NPC.IsGuard())
			If ((NPC.GetDistance(akSpeaker) < 1000) && !NPC.IsInCombat() && (GuardFac == NPC.GetCrimeFaction()) && (SizeGuards < 1) && (NPC != akSpeaker) && SexLab.IsValidActor(NPC))
				PSC_MCM.Guards[SizeGuards] = NPC
				SizeGuards += 1
			Endif
		endIf
	endWhile
	;set the amount of guard
	MultipleGuards.SetValue(SizeGuards)
	TeammatesAvailable.SetValue(SizeTeammates)


;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
