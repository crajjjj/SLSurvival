;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ColosseumUnderground9 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(4000)
GetOwningQuest().SetStage(4500)

ActorUtil.ClearPackageOverride(SLV_MiningSlave1.getActorRef())
SLV_MiningSlave1.getActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_MiningSlave2.getActorRef())
SLV_MiningSlave2.getActorRef().evaluatePackage()

myScripts.SLV_Play2Sex(SLV_MiningSlave1.getActorRef(),SLV_Miner1.getActorRef(),"Sex", true)

myScripts.SLV_Play2Sex(SLV_MiningSlave2.getActorRef(),SLV_Miner2.getActorRef(),"Sex", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_MiningSlave1 Auto
ReferenceAlias Property SLV_MiningSlave2 Auto
ReferenceAlias Property SLV_Miner1 Auto
ReferenceAlias Property SLV_Miner2 Auto

