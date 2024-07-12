;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WalkOfShame2_9 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if ThisMenu.SkipScenes
	GetOwningQuest().SetObjectiveCompleted(4000)
	GetOwningQuest().SetStage(4500)
	return
endif

myScripts.SLV_PlayScene(PunishScene)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_MCMMenu Property ThisMenu auto
SLV_Utilities Property myScripts auto
Scene Property PunishScene  Auto 
