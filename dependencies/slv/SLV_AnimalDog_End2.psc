;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_AnimalDog_End2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_DogMarker.enable()

SLV_AnimalMainQuest.SetObjectiveCompleted(1000)
SLV_AnimalMainQuest.SetStage(1500)

GetOwningQuest().SetObjectiveCompleted(9500)
getowningquest().setstage(10000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ObjectReference Property SLV_DogMarker Auto
Quest Property SLV_AnimalMainQuest Auto
