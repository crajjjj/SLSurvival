;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Mainquest2_11 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(10000)
GetOwningQuest().SetStage(10800)

SLV_CityFreedomQuest.Reset() 
SLV_CityFreedomQuest.Start() 
SLV_CityFreedomQuest.SetActive(true) 
SLV_CityFreedomQuest.SetStage(0)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_CityFreedomQuest Auto
