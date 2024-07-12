;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ColosseumSlave_4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1500)
GetOwningQuest().SetStage(2000)

SLV_Jaha.GetActorRef().enable()
SLV_Jaha.GetActorRef().moveto(SLV_Bellamy.GetActorRef())

ActorUtil.AddPackageOverride(SLV_Jaha.GetActorRef(), SLV_DoNothing ,100)
SLV_Jaha.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Package Property SLV_DoNothing Auto

ReferenceAlias Property SLV_Jaha Auto
ReferenceAlias Property SLV_Bellamy Auto

