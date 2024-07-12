;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SexSlaveTraining2_16 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(7500)
GetOwningQuest().SetStage(8000)

if ThisMenu.SkipScenes
	return
endif

SLV_Animal.ForceRefTo(Animal)
;Debug.notification("New Animal= " + SLV_Animal.getActorRef().getActorBase().getName())

SendModEvent("dhlp-Suspend")
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
PunishScene.ForceStart()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_MCMMenu Property ThisMenu auto
Scene Property PunishScene  Auto
ReferenceAlias Property SLV_Animal Auto  
Actor Property Animal Auto
