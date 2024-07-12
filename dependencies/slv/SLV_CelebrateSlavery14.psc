;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CelebrateSlavery14 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(6000)
GetOwningQuest().SetStage(6500)

ActorUtil.ClearPackageOverride(Maven.GetActorRef())
Maven.GetActorRef().evaluatePackage()
ActorUtil.ClearPackageOverride(JarlMorthal.getactorref())
JarlMorthal.getactorref().evaluatePackage()

ActorUtil.AddPackageOverride(JarlMorthal.GetActorRef(), WalkDragonsreachCenter ,100)
JarlMorthal.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(Maven.GetActorRef(), WalkDragonsreachCenter ,100)
Maven.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property JarlMorthal Auto 
ReferenceAlias Property Maven Auto 
Package Property WalkDragonsreachCenter Auto