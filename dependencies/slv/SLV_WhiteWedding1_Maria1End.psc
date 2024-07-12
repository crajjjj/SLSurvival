;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiteWedding1_Maria1End Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ActorUtil.RemoveAllPackageOverride(SLV_DragonsreachCenter)

ActorUtil.ClearPackageOverride(SLV_Bellamy.getActorRef())
SLV_Bellamy.getActorRef().evaluatePackage()

debug.SendAnimationEvent(SLV_Abigail.getActorRef(), "IdleForceDefaultState")
debug.SendAnimationEvent(SLV_Marcus.getActorRef(), "IdleForceDefaultState")
debug.SendAnimationEvent(SLV_MariaSlave.getActorRef(), "IdleForceDefaultState")

ActorUtil.ClearPackageOverride(SLV_Abigail.getActorRef())
SLV_Abigail.getActorRef().evaluatePackage()
ActorUtil.ClearPackageOverride(SLV_Marcus.getActorRef())
SLV_Marcus.getActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Abigail.getActorRef(), SLV_FollowPlayer,100)
SLV_Abigail.getActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Marcus.getActorRef(), SLV_DragonsreachCenter ,100)
SLV_Marcus.getActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Package Property SLV_DragonsreachCenter auto
Package Property SLV_FollowPlayer auto
ReferenceAlias Property SLV_Abigail auto
ReferenceAlias Property SLV_Marcus auto
ReferenceAlias Property SLV_Bellamy auto
ReferenceAlias Property SLV_MariaSlave auto

