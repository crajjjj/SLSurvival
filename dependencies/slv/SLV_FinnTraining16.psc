;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_FinnTraining16 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetStage(3000)

finnTimer.StartFinnTrainingTimer()
myScripts.SLV_GetMoreSubmissive(true,1)

actor[] sexActors = new actor[2]
sexActors[0] = Game.GetPlayer()
sexActors[1] = akSpeaker

myScripts.SLV_PlaySexAnimationSynchron(sexActors , "Leito Blowjob", "Blowjob", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
SLV_FinnTraining_Timer Property finnTimer Auto