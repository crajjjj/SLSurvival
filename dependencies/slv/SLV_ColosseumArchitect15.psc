;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ColosseumArchitect15 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(7000)
GetOwningQuest().SetStage(7500)

ActorUtil.ClearPackageOverride(SLV_MinerSlave1.getActorRef())
SLV_MinerSlave1.getActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_MinerSlave1.getActorRef(), SLV_Idle,100)
SLV_MinerSlave1.getActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_MinerSlave2.getActorRef())
SLV_MinerSlave2.getActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_MinerSlave2.getActorRef(), SLV_Idle,100)
SLV_MinerSlave2.getActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_MinerSlave1 Auto
ReferenceAlias Property SLV_MinerSlave2 Auto

Package Property SLV_Idle Auto
