;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SlaveTravel1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Game.EnablePlayerControls()
game.SetPlayerAIDriven(false)
SendModEvent("dhlp-Resume")

int playscene = Utility.RandomInt(1,100)
if MCMMenu.travelSexProbabilty && playscene <= MCMMenu.travelSexProbabilty
	if SLV_PremiumTravelQuest.IsCompleted()
		getowningquest().setstage(500)
	else
		getowningquest().setstage(1500)
	endif
else
	; skip everything
	getowningquest().setstage(3000)
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_PremiumTravelQuest Auto
SLV_MCMMenu Property MCMMenu Auto
