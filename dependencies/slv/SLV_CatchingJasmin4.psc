;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingJasmin4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1500)
getowningquest().setstage(2000)

ActorUtil.ClearPackageOverride(SLV_Jasmin.GetActorRef())
SLV_Jasmin.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Jasmin.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Jasmin.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Jasmin Auto 
Package Property SLV_FollowPlayer Auto
