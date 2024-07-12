;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Slavetraining2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(800)
GetOwningQuest().SetStage(900)

if ThisMenu.SkipScenes
	return
endif

SLV_You.getActorRef().moveto(Game.GetPlayer())

SLV_AmputeeIvana.setValue(6)

SendModEvent("dhlp-Suspend")
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
PunishScene.ForceStart()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_You Auto
SLV_MCMMenu Property ThisMenu auto
Scene Property PunishScene Auto 
GlobalVariable Property SLV_AmputeeIvana Auto