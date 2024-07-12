;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ArenaStripper_8 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_WonAnotherArenaFight()

ActorUtil.ClearPackageOverride(SLV_Watcher1.getActorRef())
SLV_Watcher1.getActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Watcher2.getActorRef())
SLV_Watcher2.getActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Watcher3.getActorRef())
SLV_Watcher3.getActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Watcher4.getActorRef())
SLV_Watcher4.getActorRef().evaluatePackage()


GetOwningQuest().SetObjectiveCompleted(9500)
GetOwningQuest().SetStage(10000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Watcher1 Auto
ReferenceAlias Property SLV_Watcher2 Auto
ReferenceAlias Property SLV_Watcher3 Auto
ReferenceAlias Property SLV_Watcher4 Auto
SLV_Utilities Property myScripts auto
