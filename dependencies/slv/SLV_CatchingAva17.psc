;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingAva17 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(8000)
getowningquest().setstage(8500)

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
ReferenceAlias Property SLV_Ava Auto 
Package Property SLV_AvaWalkToCross Auto
Package Property SLV_AvaUseCross Auto
