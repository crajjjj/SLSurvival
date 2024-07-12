;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SexSlaveTraining1_2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(500)
getowningquest().setstage(1000)

ActorUtil.ClearPackageOverride(SLV_Ivana.GetActorRef())
SLV_Ivana.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Ivana.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Ivana.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Ivana Auto 
Package Property SLV_FollowPlayer Auto
