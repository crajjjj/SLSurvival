;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiteWedding3_10 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(4000)
GetOwningQuest().SetStage(4500)

SLV_Priestess.getActorRef().enable()
;SLV_Priestess.getActorRef().moveto(SLV_Pike.getActorRef())

ActorUtil.ClearPackageOverride(SLV_Priestess.GetActorRef())
SLV_Priestess.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Priestess.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Priestess.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Package Property SLV_FollowPlayer Auto
ReferenceAlias Property SLV_Priestess Auto
ReferenceAlias Property SLV_Pike Auto