;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SexSlaveTraining4_15 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(8500)
GetOwningQuest().SetStage(9000)

debug.SendAnimationEvent(SLV_Ivana.GetActorRef(), "IdleForceDefaultState")

ActorUtil.ClearPackageOverride(SLV_Dremora1.getactorref())
SLV_Dremora1.GetActorRef().evaluatePackage()
ActorUtil.ClearPackageOverride(SLV_Dremora2.getactorref())
SLV_Dremora2.GetActorRef().evaluatePackage()
ActorUtil.RemoveAllPackageOverride(SLV_DungeonCenter)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Dremora1 Auto
ReferenceAlias Property SLV_Dremora2 Auto 
ReferenceAlias Property SLV_Ivana Auto 
Package Property SLV_DungeonCenter Auto
