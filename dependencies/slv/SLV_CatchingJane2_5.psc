;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingJane2_5 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2000)
getowningquest().setstage(2500)

ActorUtil.ClearPackageOverride(akSpeaker)
akSpeaker.evaluatePackage()
akSpeaker.moveto(Game.getPlayer())

ActorUtil.AddPackageOverride(akSpeaker, SLV_FollowPlayer ,100)
akSpeaker.evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Igor.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Igor.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Fang.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Fang.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Igor Auto 
ReferenceAlias Property SLV_Fang Auto 
Package Property SLV_FollowPlayer Auto
