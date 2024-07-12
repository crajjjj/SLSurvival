;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecialTask1b Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1480)
GetOwningQuest().SetStage(1550)

SLV_WhiterunCarriageQuest.Reset() 
SLV_WhiterunCarriageQuest.Start() 
SLV_WhiterunCarriageQuest.SetActive(true) 
SLV_WhiterunCarriageQuest.SetStage(0)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_WhiterunCarriageQuest Auto
