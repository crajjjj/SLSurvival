;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ColosseumUnderground17 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_Play2Sex(Game.GetPlayer(),akSpeaker,"Blowjob", true)

SLV_ColosseumMainQuest.SetObjectiveCompleted(4000)
SLV_ColosseumMainQuest.SetStage(4500)

GetOwningQuest().SetObjectiveCompleted(9500)
GetOwningQuest().SetStage(10000)

;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Quest Property SLV_ColosseumMainQuest Auto