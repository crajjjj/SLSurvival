;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SlaveCertification4_16 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(6500)
GetOwningQuest().SetStage(7000)

ActorUtil.RemoveAllPackageOverride(SLV_DragonsreachCenter)

ActorUtil.ClearPackageOverride(akSpeaker)
akSpeaker.evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Bellamy.getactorref())
SLV_Bellamy.GetActorRef().evaluatePackage()

debug.SendAnimationEvent(SLV_Diamond.getActorRef(), "IdleForceDefaultState")
debug.SendAnimationEvent(SLV_Ivana.getActorRef(), "IdleForceDefaultState")
debug.SendAnimationEvent(SLV_Julia.getActorRef(), "IdleForceDefaultState")
debug.SendAnimationEvent(SLV_Valentina.getActorRef(), "IdleForceDefaultState")


ActorUtil.AddPackageOverride(SLV_Diamond.getActorRef(), SLV_FollowPlayer,100)
SLV_Diamond.getActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Ivana.getActorRef(), SLV_FollowPlayer,100)
SLV_Ivana.getActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Julia.getActorRef(), SLV_FollowPlayer,100)
SLV_Julia.getActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Valentina.getActorRef(), SLV_FollowPlayer,100)
SLV_Valentina.getActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Package Property SLV_DragonsreachCenter auto
Package Property SLV_FollowPlayer auto
ReferenceAlias Property SLV_Diamond auto
ReferenceAlias Property SLV_Ivana auto
ReferenceAlias Property SLV_Julia auto
ReferenceAlias Property SLV_Valentina auto

ReferenceAlias Property SLV_Bellamy auto
