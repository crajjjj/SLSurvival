;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Cheat52 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(0)
GetOwningQuest().SetStage(9500)

SLV_Aden.getActorRef().enable()
SLV_Octavia.getActorRef().enable()
SLV_Raven.getActorRef().enable()

myScripts.SLV_enslavementNPC(SLV_Octavia.getActorRef())
myScripts.SLV_enslavementChains(SLV_Octavia.getActorRef())

ActorUtil.ClearPackageOverride(SLV_Octavia.getactorref())
SLV_Octavia.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Octavia.GetActorRef(), SLV_OctaviaUseCross ,100)
SLV_Octavia.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Octavia.GetActorRef(), SLV_OctaviaWalkToCross ,60)
SLV_Octavia.GetActorRef().evaluatePackage()

myScripts.SLV_enslavementNPC(SLV_Raven.getActorRef())
myScripts.SLV_enslavementChains(SLV_Raven.getActorRef())

ActorUtil.ClearPackageOverride(SLV_Raven.getactorref())
SLV_Raven.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Raven.GetActorRef(), SLV_RavenUseCross ,100)
SLV_Raven.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Raven.GetActorRef(), SLV_RavenWalkToCross ,60)
SLV_Raven.GetActorRef().evaluatePackage()

schlongs.SLV_SchlongSize(SLV_Aden.GetActorRef(),20)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Aden Auto
ReferenceAlias Property SLV_Octavia Auto 
ReferenceAlias Property SLV_Raven Auto 
Package Property SLV_OctaviaWalkToCross Auto
Package Property SLV_OctaviaUseCross Auto
Package Property SLV_RavenWalkToCross Auto
Package Property SLV_RavenUseCross Auto

SLV_SOSSchlong Property schlongs Auto

