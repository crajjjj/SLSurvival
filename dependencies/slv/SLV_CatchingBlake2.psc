;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingBlake2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(500)
getowningquest().setstage(1000)

ActorUtil.ClearPackageOverride(akSpeaker)
akSpeaker.evaluatePackage()
akSpeaker.moveto(Game.getPlayer())

ActorUtil.AddPackageOverride(akSpeaker, SLV_FollowPlayer ,100)
akSpeaker.evaluatePackage()

SLV_Blake.GetActorRef().enable()
SLV_Blake.GetActorRef().moveto(SLV_Brutus.GetActorRef())

ActorUtil.AddPackageOverride(SLV_Blake.GetActorRef(), SLV_DoNothing ,100)
SLV_Blake.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Blake Auto 
ReferenceAlias Property SLV_Brutus Auto 
Package Property SLV_DoNothing Auto
Package Property SLV_FollowPlayer Auto
