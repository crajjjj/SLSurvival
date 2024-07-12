;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ColosseumMain_20 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(8500)
GetOwningQuest().SetStage(9000)

ActorUtil.ClearPackageOverride(SLV_Leonardo.getActorRef())
SLV_Leonardo.getActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Leonardo.getActorRef(), SLV_IdleSilent ,100)
SLV_Leonardo.getActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Michelangela.getActorRef())
SLV_Michelangela.getActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Michelangela.getActorRef(), SLV_IdleSilent ,100)
SLV_Michelangela.getActorRef().evaluatePackage()

MineDoor.disable()
MineEntrance.disable()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Package Property SLV_IdleSilent Auto
ReferenceAlias Property SLV_Michelangela Auto
ReferenceAlias Property SLV_Leonardo Auto

ObjectReference Property MineDoor auto
ObjectReference Property MineEntrance auto

