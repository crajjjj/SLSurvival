;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_DawnstarFreedomEnd2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_quest.SetObjectiveCompleted(8800)
SLV_quest.SetStage(9000)

myScripts.SLV_miniLevelDown()

GetOwningQuest().SetObjectiveCompleted(9000)
GetOwningQuest().SetStage(9500)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Quest Property SLV_quest Auto