;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial2_7 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor slave = Actor03.GetActorRef()
GetOwningQuest().SetObjectiveCompleted(3000)

if Game.getPlayer().IsInFaction(SlaverunSlaveFaction)
	GetOwningQuest().SetStage(3500)
else
	GetOwningQuest().SetStage(4000)
endif

ActorUtil.ClearPackageOverride(slave)
slave.evaluatePackage()

myScripts.SLV_Play2Sex(slave,akSpeaker, "Anal", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property Actor03 Auto 
Faction Property SlaverunSlaveFaction auto

