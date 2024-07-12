;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_RiftenViagrix9b Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
riftenmain.SetObjectiveCompleted(5000)
riftenmain.setStage(5500)

ActorUtil.ClearPackageOverride(akSpeaker)
ActorUtil.ClearPackageOverride(SLV_Ingun.getActorRef())

GetOwningQuest().SetObjectiveCompleted(3000)
GetOwningQuest().SetStage(4500)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property riftenmain Auto
ReferenceAlias Property SLV_Ingun Auto
