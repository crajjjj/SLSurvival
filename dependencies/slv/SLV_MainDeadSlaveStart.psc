;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainDeadSlaveStart Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(6400)
GetOwningQuest().SetStage(6450)

SLV_DeadSlaveWalkingQuest.Reset() 
SLV_DeadSlaveWalkingQuest.Start() 
SLV_DeadSlaveWalkingQuest.SetActive(true) 
SLV_DeadSlaveWalkingQuest.SetStage(0)
 
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_DeadSlaveWalkingQuest Auto
