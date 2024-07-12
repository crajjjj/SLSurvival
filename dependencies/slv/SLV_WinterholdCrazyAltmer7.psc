;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WinterholdCrazyAltmer7 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
WinterholdSlavery.SetObjectiveCompleted(2500)
WinterholdSlavery.setStage(3000)

myScripts.SLV_Play2Sex(Mirabelle.getActorRef(),akSpeaker, "Sex", true)

ActorUtil.ClearPackageOverride(akSpeaker)
ActorUtil.ClearPackageOverride(Mirabelle.getActorRef())

GetOwningQuest().SetObjectiveCompleted(3000)
GetOwningQuest().SetStage(4500)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto 
Quest Property WinterholdSlavery Auto
ReferenceAlias Property Mirabelle Auto
