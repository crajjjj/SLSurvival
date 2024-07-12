;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Slavetraining20 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2750)
GetOwningQuest().SetStage(3000)

ActorUtil.ClearPackageOverride(SLV_Valentina.GetActorRef())
SLV_Valentina.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Valentina.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Valentina.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Valentina Auto 
Package Property SLV_FollowPlayer Auto