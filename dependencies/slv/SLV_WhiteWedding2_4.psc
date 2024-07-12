;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiteWedding2_4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1000)
GetOwningQuest().SetStage(1500)

ActorUtil.ClearPackageOverride(SLV_Aden.GetActorRef())
SLV_Aden.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Aden.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Aden.GetActorRef().evaluatePackage()
schlongs.SLV_SchlongSize(SLV_Aden.GetActorRef(),15)

ActorUtil.ClearPackageOverride(SLV_Raven.GetActorRef())
SLV_Raven.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Raven.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Raven.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Octavia.GetActorRef())
SLV_Octavia.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Octavia.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Octavia.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Aden Auto 
ReferenceAlias Property SLV_Raven Auto 
ReferenceAlias Property SLV_Octavia Auto 

Package Property SLV_FollowPlayer Auto

SLV_SOSSchlong Property schlongs Auto
