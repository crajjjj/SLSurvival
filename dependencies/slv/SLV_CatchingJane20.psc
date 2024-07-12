;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingJane20 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(8500)
getowningquest().setstage(9000)

ActorUtil.ClearPackageOverride(SLV_Jane.getactorref())
SLV_Jane.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Jane.GetActorRef(), SLV_JaneUseCross ,100)
SLV_Jane.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Jane.GetActorRef(), SLV_JaneWalkToCross ,60)
SLV_Jane.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Jane Auto 
Package Property SLV_JaneWalkToCross Auto
Package Property SLV_JaneUseCross Auto
