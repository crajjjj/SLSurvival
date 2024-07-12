;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SexSlaveTraining6_3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1000)
GetOwningQuest().SetStage(1500)


ActorUtil.ClearPackageOverride(SLV_Gustus.getActorRef())
SLV_Gustus.getActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Gustus.getActorRef(), SLV_ColosseumTrainingWalkToCenter ,100)
SLV_Gustus.getActorRef().evaluatePackage()


ActorUtil.ClearPackageOverride(SLV_Quintus.getActorRef())
SLV_Quintus.getActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Quintus.getActorRef(), SLV_ColosseumTrainingWalkToMill ,100)
SLV_Quintus.getActorRef().evaluatePackage()


ActorUtil.ClearPackageOverride(SLV_Bellamy.getActorRef())
SLV_Bellamy.getActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Bellamy.getActorRef(), SLV_ColosseumTrainingWalkToWater ,100)
SLV_Bellamy.getActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Package Property SLV_ColosseumTrainingWalkToCenter Auto
Package Property SLV_ColosseumTrainingWalkToMill Auto
Package Property SLV_ColosseumTrainingWalkToWater Auto

ReferenceAlias Property SLV_Gustus Auto
ReferenceAlias Property SLV_Quintus Auto
ReferenceAlias Property SLV_Bellamy Auto
