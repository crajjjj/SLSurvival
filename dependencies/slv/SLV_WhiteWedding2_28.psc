;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiteWedding2_28 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(9200)
GetOwningQuest().SetStage(9400)

ActorUtil.ClearPackageOverride(SLV_Aden.getactorref())
SLV_Aden.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Octavia.getactorref())
SLV_Octavia.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Octavia.GetActorRef(), SLV_OctaviaUseCross ,100)
SLV_Octavia.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Octavia.GetActorRef(), SLV_OctaviaWalkToCross ,60)
SLV_Octavia.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Raven.getactorref())
SLV_Raven.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Raven.GetActorRef(), SLV_RavenUseCross ,100)
SLV_Raven.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Raven.GetActorRef(), SLV_RavenWalkToCross ,60)
SLV_Raven.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Aden Auto
ReferenceAlias Property SLV_Octavia Auto 
ReferenceAlias Property SLV_Raven Auto 
Package Property SLV_OctaviaWalkToCross Auto
Package Property SLV_OctaviaUseCross Auto
Package Property SLV_RavenWalkToCross Auto
Package Property SLV_RavenUseCross Auto