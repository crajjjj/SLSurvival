;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ColosseumTraining_18 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2000)
GetOwningQuest().SetStage(2500)

horseOutside.enable()
SLV_Gustus.GetActorRef().enable()
SLV_Gustus.GetActorRef().moveto(horseOutside)

ActorUtil.AddPackageOverride(SLV_Gustus.GetActorRef(), SLV_DoNothing ,100)
SLV_Gustus.GetActorRef().evaluatePackage()

SLV_Quintus.GetActorRef().enable()
SLV_Quintus.GetActorRef().moveto(horseOutside)

ActorUtil.AddPackageOverride(SLV_Quintus.GetActorRef(), SLV_DoNothing ,100)
SLV_Quintus.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Package Property SLV_DoNothing Auto
Actor Property horseOutside auto

ReferenceAlias Property SLV_Gustus Auto
ReferenceAlias Property SLV_Quintus Auto
