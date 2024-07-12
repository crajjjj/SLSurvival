;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiteWedding3_6 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2000)
GetOwningQuest().SetStage(2500)

ActorUtil.ClearPackageOverride(SLV_Marcus.GetActorRef())
SLV_Marcus.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Marcus.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Marcus.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Abigail.GetActorRef())
SLV_Abigail.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Abigail.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Abigail.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Marcus Auto 
ReferenceAlias Property SLV_Abigail Auto 

Package Property SLV_FollowPlayer Auto
