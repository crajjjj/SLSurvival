;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SlaveCertification3_10 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(4000)
GetOwningQuest().SetStage(4500)

ActorUtil.ClearPackageOverride(SLV_Blake.getactorref())
SLV_Blake.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Blake.GetActorRef(), SLV_BlakeUseCross ,100)
SLV_Blake.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Blake.GetActorRef(), SLV_BlakeWalkToCross ,60)
SLV_Blake.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Eva.getactorref())
SLV_Eva.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Eva.GetActorRef(), SLV_EvaUseCross ,100)
SLV_Eva.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Eva.GetActorRef(), SLV_EvaWalkToCross ,60)
SLV_Eva.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Eva Auto 
Package Property SLV_EvaWalkToCross Auto
Package Property SLV_EvaUseCross Auto
ReferenceAlias Property SLV_Blake Auto 
Package Property SLV_BlakeWalkToCross Auto
Package Property SLV_BlakeUseCross Auto
