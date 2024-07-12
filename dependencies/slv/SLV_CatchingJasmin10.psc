;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingJasmin10 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(4000)
GetOwningQuest().SetStage(4500)

ActorUtil.ClearPackageOverride(SLV_Jasmin.getactorref())
SLV_Jasmin.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Jasmin.GetActorRef(), SLV_JasminUseCross ,100)
SLV_Jasmin.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Jasmin.GetActorRef(), SLV_JasminWalkToCross ,60)
SLV_Jasmin.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Jasmin Auto 
Package Property SLV_JasminWalkToCross Auto
Package Property SLV_JasminUseCross Auto
