;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Cheat30 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(0)
getowningquest().setstage(9500)

SLV_Eva.getActorRef().enable()

myScripts.SLV_enslavementNPC(SLV_Eva.getActorRef())
myScripts.SLV_enslavementChains(SLV_Eva.getActorRef())

ActorUtil.ClearPackageOverride(SLV_Eva.getactorref())
SLV_Eva.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Eva.GetActorRef(), SLV_EvaUseCross ,100)
SLV_Eva.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Eva.GetActorRef(), SLV_EvaWalkToCross ,60)
SLV_Eva.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Eva Auto 
Package Property SLV_EvaWalkToCross Auto
Package Property SLV_EvaUseCross Auto
