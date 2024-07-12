;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ColosseumFanFair_12 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(6000)
GetOwningQuest().SetStage(6500)

slaveMarker.enable()

ActorUtil.AddPackageOverride(SLV_Slave1, SLV_FollowPlayer ,100)
SLV_Slave1.evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Slave2, SLV_FollowPlayer ,100)
SLV_Slave2.evaluatePackage()

SLV_Slave1.moveto(Game.GetPlayer())
SLV_Slave2.moveto(Game.GetPlayer())
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Package Property SLV_FollowPlayer Auto
ObjectReference Property slaveMarker auto

Actor Property SLV_Slave1 Auto
Actor Property SLV_Slave2 Auto
