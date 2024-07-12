;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Cheat33 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(0)
getowningquest().setstage(9500)

SLV_Julia.getActorRef().enable()

myScripts.SLV_enslavementNPC(SLV_Julia.getActorRef())
myScripts.SLV_enslavementChains(SLV_Julia.getActorRef())

ActorUtil.ClearPackageOverride(SLV_Julia.getactorref())
SLV_Julia.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Julia.GetActorRef(), SLV_JuliaUseCross ,100)
SLV_Julia.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Julia.GetActorRef(), SLV_JuliaWalkToCross ,60)
SLV_Julia.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Julia Auto 
Package Property SLV_JuliaWalkToCross Auto
Package Property SLV_JuliaUseCross Auto
