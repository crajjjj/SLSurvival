;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingBlake3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1000)
getowningquest().setstage(1500)

ActorUtil.AddPackageOverride(akSpeaker, SLV_FollowPlayer ,100)
akSpeaker.evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Blake.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Blake.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Diamond.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Diamond.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(akSpeaker, SLV_FollowPlayer ,100)
akSpeaker.evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Blake.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Blake.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Diamond.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Diamond.GetActorRef().evaluatePackage()

debug.SendAnimationEvent(SLV_Diamond.GetActorRef(), "IdleForceDefaultState")
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Blake Auto 
ReferenceAlias Property SLV_Diamond Auto 
Package Property SLV_FollowPlayer Auto