;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SolitudeFashion13 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1500)
getowningquest().setstage(2000)

ActorUtil.AddPackageOverride(akSpeaker, BluePalace ,100)
akSpeaker.evaluatePackage()

myScripts.SLV_Play3Sex(SLV_Taarie.getActorRef(),akspeaker,Game.GetPlayer(), "Boobjob", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Package Property BluePalace Auto
ReferenceAlias Property SLV_Taarie Auto
