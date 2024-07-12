;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SexSlaveTraining6_9 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(5500)
GetOwningQuest().SetStage(6000)


ActorUtil.ClearPackageOverride(SLV_Quintus.getActorRef())
SLV_Quintus.getActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Quintus.getActorRef(), SLV_ColosseumTrainingWalkToCenter ,100)
SLV_Quintus.getActorRef().evaluatePackage()

myScripts.SLV_PlayScene(PunishScene)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Scene Property PunishScene  Auto
SLV_Utilities Property myScripts auto

Package Property SLV_ColosseumTrainingWalkToCenter Auto
ReferenceAlias Property SLV_Quintus Auto
