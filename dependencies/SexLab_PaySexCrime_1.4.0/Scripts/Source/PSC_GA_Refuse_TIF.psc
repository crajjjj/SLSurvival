;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname PSC_GA_Refuse_TIF Extends TopicInfo Hidden

PaySexCrimeMCM Property PSC_MCM Auto
PSC_ApproachStart Property ApproachStart Auto

Quest Property GuardApproachQuest  Auto

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE

;start

	GuardApproachQuest.Stop()
	;ApproachStart.ApproachStop() 	;stop it at start of dialog

	;penalty for refusing.
	Faction GuardFac = akspeaker.GetCrimeFaction()
	int Penalty = 0
	Penalty = (PSC_MCM._sliderPercent_ApproachRefusePenalty as int)
	GuardFac.ModCrimeGold(Penalty, true)

	;setup for new approach.
	ApproachStart.StageDelay(0)



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
