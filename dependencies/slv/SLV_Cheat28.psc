;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Cheat28 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(0)
getowningquest().setstage(9500)

SLV_Ava.getActorRef().enable()

myScripts.SLV_enslavementNPC(SLV_Ava.getActorRef())
myScripts.SLV_enslavementChains(SLV_Ava.getActorRef())

ActorUtil.ClearPackageOverride(SLV_Ava.getactorref())
SLV_Ava.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Ava.GetActorRef(), SLV_AvaUseCross ,100)
SLV_Ava.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Ava.GetActorRef(), SLV_AvaWalkToCross ,60)
SLV_Ava.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Ava Auto 
Package Property SLV_AvaWalkToCross Auto
Package Property SLV_AvaUseCross Auto
