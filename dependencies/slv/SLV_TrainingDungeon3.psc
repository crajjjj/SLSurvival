;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLV_TrainingDungeon3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(4500)
GetOwningQuest().SetStage(4750)

if ThisMenu.SkipScenes
	return
endif

SendModEvent("dhlp-Suspend")
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
CellDoor.Lock(false)
PunishScene.ForceStart()

myScripts.SLV_Play2Sex(SLV_Valentina.getActorRef(), akSpeaker, "Boobjob", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto 
ReferenceAlias Property SLV_Valentina Auto 
Scene Property PunishScene  Auto  
ObjectReference Property CellDoor  Auto  
SLV_MCMMenu Property ThisMenu auto
