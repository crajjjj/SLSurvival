;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname PSC_WP_Pay_TIF Extends TopicInfo Hidden

PaySexCrimeMCM Property PSC_MCM Auto

MiscObject Property Gold  Auto

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;end
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;start


	int CrimeFac = PSC_MCM.CrimeFaction

	;increase tracker
	PSC_MCM.SuccessTracker[CrimeFac] = (PSC_MCM.SuccessTracker[CrimeFac] + 1)
	if (PSC_MCM.SuccessTracker[CrimeFac] > 2000000000)
		PSC_MCM.SuccessTracker[CrimeFac] = 0
	endif

	;remove payment from player
	int TotalBounty = (PSC_MCM.BountyNonViolent[CrimeFac] + PSC_MCM.BountyViolent[CrimeFac]) as int
	Game.GetPlayer().RemoveItem(Gold, TotalBounty, true)

	;clear bounty
	PSC_MCM.BountyNonViolent[CrimeFac] = 0
	PSC_MCM.BountyViolent[CrimeFac] = 0
	PSC_MCM.PardonEndTime[CrimeFac] = (Utility.GetCurrentGameTime() * 24)


;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
