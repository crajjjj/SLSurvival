;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ColosseumMain_7 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2700)
GetOwningQuest().SetStage(3000)

SLV_ColosseumArchitectQuest.Reset() 
SLV_ColosseumArchitectQuest.Start() 
SLV_ColosseumArchitectQuest.SetStage(0)
SLV_ColosseumArchitectQuest.SetActive(true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_ColosseumArchitectQuest Auto