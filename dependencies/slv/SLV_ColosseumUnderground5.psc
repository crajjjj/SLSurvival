;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ColosseumUnderground5 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2000)
GetOwningQuest().SetStage(2500)

ActorUtil.ClearPackageOverride(SLV_Miner1.getActorRef())
SLV_Miner1.getActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Miner2.getActorRef())
SLV_Miner2.getActorRef().evaluatePackage()

SLV_Miner1.getActorRef().moveto(Mine1)
SLV_Miner2.getActorRef().moveto(Mine1)

SLV_Miner1.getActorRef().removeFromFaction(zbfFactionSlave )
SLV_Miner2.getActorRef().removeFromFaction(zbfFactionSlave )

upperMineDoor.lock(false)
Utility.wait(2.0)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Miner1 Auto
ReferenceAlias Property SLV_Miner2 Auto

ObjectReference Property Mine1 Auto
Faction Property zbfFactionSlave Auto

ObjectReference Property upperMineDoor Auto

