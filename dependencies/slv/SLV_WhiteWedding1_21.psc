;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiteWedding1_21 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(7200)
GetOwningQuest().SetStage(7500)

schlongs.SLV_SchlongSize(SLV_Marcus.GetActorRef(),20)

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
