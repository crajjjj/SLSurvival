;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SlaveCertification3_8 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(3500)
GetOwningQuest().SetStage(4000)

ActorUtil.RemoveAllPackageOverride(SLV_DragonsreachCenter)

ActorUtil.ClearPackageOverride(akSpeaker)
akSpeaker.evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Bellamy.getactorref())
SLV_Bellamy.GetActorRef().evaluatePackage()

debug.SendAnimationEvent(SLV_Blake.getActorRef(), "IdleForceDefaultState")
debug.SendAnimationEvent(SLV_Eva.getActorRef(), "IdleForceDefaultState")


ActorUtil.AddPackageOverride(SLV_Blake.getActorRef(), SLV_FollowPlayer,100)
SLV_Blake.getActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Eva.getActorRef(), SLV_FollowPlayer,100)
SLV_Eva.getActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Package Property SLV_DragonsreachCenter auto
Package Property SLV_FollowPlayer auto
ReferenceAlias Property SLV_Blake auto
ReferenceAlias Property SLV_Eva auto
ReferenceAlias Property SLV_Bellamy auto
