;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_AnimalHorse_End Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_AnimalMarker.enable()

SLV_AnimalMainQuest.SetObjectiveCompleted(2000)
SLV_AnimalMainQuest.SetStage(2500)

myScripts.SLV_Play2Sex(Game.GetPlayer(),SLV_RoanPet.getActorRef(),"Anal", true)

GetOwningQuest().SetObjectiveCompleted(9500)
getowningquest().setstage(10000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ObjectReference Property SLV_AnimalMarker Auto
Quest Property SLV_AnimalMainQuest Auto
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_RoanPet Auto
