;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingJane12 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(4500)
getowningquest().setstage(5000)

ActorUtil.AddPackageOverride(SLV_Jane.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Jane.GetActorRef().evaluatePackage()
ActorUtil.ClearPackageOverride(SLV_Constantine.GetActorRef())
SLV_Constantine.GetActorRef().evaluatePackage()

Utility.wait(5.0)
SLV_Constantine.GetActorRef().disable()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Jane Auto 
ReferenceAlias Property SLV_Constantine Auto  
Package Property SLV_FollowPlayer Auto

