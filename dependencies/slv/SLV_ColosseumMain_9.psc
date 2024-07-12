;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ColosseumMain_9 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(4500)
GetOwningQuest().SetStage(5000)

SLV_ColosseumFanFairQuest.Reset() 
SLV_ColosseumFanFairQuest.Start() 
SLV_ColosseumFanFairQuest.SetStage(0)
SLV_ColosseumFanFairQuest.SetActive(true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_ColosseumFanFairQuest Auto