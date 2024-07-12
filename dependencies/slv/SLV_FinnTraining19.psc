;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_FinnTraining19 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetStage(3600)

finnTimer.StartFinnTrainingTimer()
myScripts.SLV_GetMoreSubmissive(true,1)

SLV_Slaver.ForceRefTo(akSpeaker)
;Debug.notification("New Slaver= " + SLV_Slaver.getActorRef().getActorBase().getName())

myScripts.SLV_PlayScene(PunishScene)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Scene Property PunishScene  Auto
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Slaver Auto
SLV_FinnTraining_Timer Property finnTimer Auto
