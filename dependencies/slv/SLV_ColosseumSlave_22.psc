;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ColosseumSlave_22 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2000)
GetOwningQuest().SetStage(2500)

ActorUtil.ClearPackageOverride(SLV_Jaha.getActorRef())
SLV_Jaha.getActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Jaha.getActorRef(), SLV_FollowPlayer ,100)
SLV_Jaha.getActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Package Property SLV_FollowPlayer Auto
ReferenceAlias Property SLV_Jaha Auto
