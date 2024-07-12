;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiteWedding3_18 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(8000)
GetOwningQuest().SetStage(8500)

ActorUtil.RemoveAllPackageOverride(SLV_WalkToDragonsreachCenter )
ActorUtil.RemoveAllPackageOverride(SLV_WalkToDragonsreachLeft )
ActorUtil.RemoveAllPackageOverride(SLV_WalkToDragonsreachRight )
ActorUtil.RemoveAllPackageOverride(SLV_DragonsreachWedding )
ActorUtil.RemoveAllPackageOverride(SLV_DragonsreachWeddingJarl )

ActorUtil.ClearPackageOverride(akSpeaker)
akSpeaker.evaluatePackage()

debug.SendAnimationEvent(SLV_Raven.getActorRef(), "IdleForceDefaultState")
debug.SendAnimationEvent(SLV_Octavia.getActorRef(), "IdleForceDefaultState")
debug.SendAnimationEvent(SLV_Abigail.getActorRef(), "IdleForceDefaultState")
debug.SendAnimationEvent(SLV_Marcus.getActorRef(), "IdleForceDefaultState")


ActorUtil.AddPackageOverride(SLV_Raven.getActorRef(), SLV_FollowPlayer,100)
SLV_Raven.getActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Octavia.getActorRef(), SLV_FollowPlayer,100)
SLV_Octavia.getActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Abigail.getActorRef(), SLV_FollowPlayer,100)
SLV_Abigail.getActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Marcus.getActorRef(), SLV_FollowPlayer,100)
SLV_Marcus.getActorRef().evaluatePackage()

SLV_Aden.getActorRef().moveto(SLV_Fang)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Package Property SLV_WalkToDragonsreachCenter auto
Package Property SLV_WalkToDragonsreachLeft auto
Package Property SLV_WalkToDragonsreachRight auto

Package Property SLV_DragonsreachWedding auto
Package Property SLV_DragonsreachWeddingJarl auto


Package Property SLV_FollowPlayer auto
ReferenceAlias Property SLV_Raven auto
ReferenceAlias Property SLV_Octavia auto
ReferenceAlias Property SLV_Abigail auto
ReferenceAlias Property SLV_Marcus auto
Actor Property SLV_Fang auto
ReferenceAlias Property SLV_Aden auto


