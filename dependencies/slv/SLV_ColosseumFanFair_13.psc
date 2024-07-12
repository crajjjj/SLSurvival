;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ColosseumFanFair_13 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(6500)
GetOwningQuest().SetStage(7000)

ActorUtil.ClearPackageOverride(SLV_Slave1)
SLV_Slave1.evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Slave1, SLV_ColosseumSlaveGradeA ,100)
SLV_Slave1.evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Slave2)
SLV_Slave2.evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Slave2, SLV_ColosseumSlaveGradeA ,100)
SLV_Slave2.evaluatePackage()

SLV_Visitor.getActorRef().enable()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Actor Property SLV_Slave1 Auto
Actor Property SLV_Slave2 Auto

ReferenceAlias Property SLV_Visitor Auto
Package Property SLV_ColosseumSlaveGradeA auto