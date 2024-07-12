;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ColosseumTraining_6 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2500)
GetOwningQuest().SetStage(3000)

ActorUtil.ClearPackageOverride(SLV_Gustus.getActorRef())
SLV_Gustus.getActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Gustus.getActorRef(), SLV_FollowPlayer ,100)
SLV_Gustus.getActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Quintus.getActorRef())
SLV_Quintus.getActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Quintus.getActorRef(), SLV_FollowPlayer ,100)
SLV_Quintus.getActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Package Property SLV_FollowPlayer Auto
ReferenceAlias Property SLV_Gustus Auto
ReferenceAlias Property SLV_Quintus Auto

