;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingHeike2_5 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1500)
getowningquest().setstage(2000)

ActorUtil.AddPackageOverride(akSpeaker, SLV_FollowPlayer ,100)
akSpeaker.evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Igor.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Igor.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Diamond.GetActorRef())
SLV_Diamond.GetActorRef().evaluatePackage()
SLV_Diamond.GetActorRef().moveto(Game.getPlayer())
ActorUtil.AddPackageOverride(SLV_Diamond.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Diamond.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Ivana.GetActorRef())
SLV_Ivana.GetActorRef().evaluatePackage()
SLV_Ivana.GetActorRef().moveto(Game.getPlayer())
ActorUtil.AddPackageOverride(SLV_Ivana.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Ivana.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Julia.GetActorRef())
SLV_Julia.GetActorRef().evaluatePackage()
SLV_Julia.GetActorRef().moveto(Game.getPlayer())
ActorUtil.AddPackageOverride(SLV_Julia.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Julia.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Valentina.GetActorRef())
SLV_Valentina.GetActorRef().evaluatePackage()
SLV_Valentina.GetActorRef().moveto(Game.getPlayer())
ActorUtil.AddPackageOverride(SLV_Valentina.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Valentina.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Diamond Auto 
ReferenceAlias Property SLV_Ivana Auto 
ReferenceAlias Property SLV_Julia Auto 
ReferenceAlias Property SLV_Valentina Auto 

ReferenceAlias Property SLV_Igor Auto 
Package Property SLV_FollowPlayer Auto
