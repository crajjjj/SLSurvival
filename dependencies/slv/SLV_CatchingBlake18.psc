;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingBlake18 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(8500)
getowningquest().setstage(9000)

debug.SendAnimationEvent(SLV_Ivana.getActorRef(), "IdleForceDefaultState")
debug.SendAnimationEvent(SLV_Diamond.getActorRef(), "IdleForceDefaultState")

myScripts.SLV_Play2SexAnimation(Game.GetPlayer(), akSpeaker,"Leito Kissing","Kissing", true)

ActorUtil.RemoveAllPackageOverride(SLV_DragonsreachCenter)

ActorUtil.ClearPackageOverride(akSpeaker)
akSpeaker.evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Zaid.getactorref())
SLV_Zaid.getactorref().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Diamond.getactorref())
SLV_Diamond.GetActorRef().evaluatePackage()
ActorUtil.ClearPackageOverride(SLV_Ivana.getactorref())
SLV_Ivana.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Blake.getActorRef(), SLV_FollowPlayer,100)
SLV_Blake.getActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Ivana.getActorRef(), SLV_FollowPlayer,100)
SLV_Ivana.getActorRef().evaluatePackage()

myScripts.SLV_BrutusMoodChange(true,1) 
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Package Property SLV_DragonsreachCenter auto
Package Property SLV_FollowPlayer auto
ReferenceAlias Property SLV_Diamond auto
ReferenceAlias Property SLV_Blake auto
ReferenceAlias Property SLV_Ivana auto
ReferenceAlias Property SLV_Zaid auto
SLV_Utilities Property myScripts auto
