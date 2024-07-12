;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname PSC_Multiple4_TIF Extends TopicInfo Hidden

PaySexCrimeMCM Property PSC_MCM Auto

ReferenceAlias Property PrimaryGuard  Auto
ReferenceAlias Property SecondaryGuard  Auto
ReferenceAlias Property PrimaryTeammate  Auto

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE

;start

	;get guard's faction from MCM.
	Faction GuardFac = PSC_MCM.GuardsCrimeFaction
	Int CrimeFac = PSC_MCM.CrimeFaction

	;store bounty, call off attack. 
	PSC_MCM.BountyNonViolent[CrimeFac] = GuardFac.GetCrimeGoldNonViolent()
	PSC_MCM.BountyViolent[CrimeFac] = GuardFac.GetCrimeGoldViolent()
	GuardFac.SetCrimeGold(0)
	GuardFac.SetCrimeGoldViolent(0)
	GuardFac.PlayerPayCrimeGold(abRemoveStolenItems = False, abGoToJail = False)
	GuardFac.setPlayerEnemy(false)
	Game.GetPlayer().StopCombat()
	Game.GetPlayer().StopCombatAlarm()
	akspeaker.StopCombat()
	akspeaker.StopCombatAlarm()


	;fill alias.
	PrimaryGuard.ForceRefTo(akSpeaker)
	SecondaryGuard.ForceRefTo(PSC_MCM.Guards[0])
	PrimaryTeammate.ForceRefTo(PSC_MCM.Teammates[0])

	;set scene settings
	PSC_MCM.SceneMain = "Multiple"
	PSC_MCM.SceneAdditional = "4"


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
