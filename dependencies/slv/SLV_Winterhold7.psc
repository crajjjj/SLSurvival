;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Winterhold7 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(3000)
GetOwningQuest().SetStage(3500)

SLV_WinterholdTask2.Reset() 
SLV_WinterholdTask2.Start() 
SLV_WinterholdTask2.SetStage(0)
SLV_WinterholdTask2.SetActive(true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_WinterholdTask2 Auto
