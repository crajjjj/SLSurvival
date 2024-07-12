;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ColosseumTraining_22 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(7000)
GetOwningQuest().SetStage(7500)

SLV_Rosita.GetActorRef().enable()
SLV_Rosita.GetActorRef().moveto(templeloc)

ActorUtil.AddPackageOverride(SLV_Rosita.GetActorRef(), SLV_DoNothing ,100)
SLV_Rosita.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Package Property SLV_DoNothing Auto
ObjectReference Property templeloc auto
ReferenceAlias Property SLV_Rosita Auto