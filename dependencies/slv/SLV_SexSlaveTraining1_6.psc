;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SexSlaveTraining1_6 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2000)
getowningquest().setstage(2500)

if ThisMenu.SkipScenes
	return
endif

SLV_You.getActorRef().moveto(Game.GetPlayer())
SendModEvent("dhlp-Suspend")

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)

Punishment.Start()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Scene Property Punishment  Auto 
SLV_MCMMenu Property ThisMenu auto
ReferenceAlias Property SLV_You Auto 
