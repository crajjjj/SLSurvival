;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiteWedding1_9 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2500)
GetOwningQuest().SetStage(2700)

ActorUtil.ClearPackageOverride(SLV_Marcus.GetActorRef())
SLV_Marcus.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Marcus.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Marcus.GetActorRef().evaluatePackage()
schlongs.SLV_SchlongSize(SLV_Marcus.GetActorRef(),1)

ActorUtil.ClearPackageOverride(SLV_Abigale.GetActorRef())
SLV_Abigale.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Abigale.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Abigale.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Marcus Auto 
ReferenceAlias Property SLV_Abigale Auto 
Package Property SLV_FollowPlayer Auto

SLV_SOSSchlong Property schlongs Auto
