;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLV_WhiterunTaskFarkas2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if ThisMenu.SkipScenes
	GetOwningQuest().SetObjectiveCompleted(0)
	GetOwningQuest().SetStage(500)
	return
endif

SendModEvent("dhlp-Suspend")
akSpeaker.addItem(Whip)
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
FarkasPunishment.Start()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Scene Property FarkasPunishment  Auto  
Weapon Property Whip Auto
SLV_MCMMenu Property ThisMenu auto