;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_GladiatorConan_End Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ActorUtil.ClearPackageOverride(SLV_Conan.GetActorRef())
SLV_Conan.GetActorRef().evaluatePackage()

SLV_GladiatorMainQuest.SetObjectiveCompleted(2000)
SLV_GladiatorMainQuest.SetStage(2500)

GetOwningQuest().SetObjectiveCompleted(9500)
getowningquest().setstage(10000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_GladiatorMainQuest Auto

ReferenceAlias Property SLV_Conan Auto