;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SlaveCertification4_6 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2500)
GetOwningQuest().SetStage(3000)

ActorUtil.ClearPackageOverride(SLV_Julia.getactorref())
SLV_Julia.GetActorRef().evaluatePackage()
Utility.wait(2.0)
ActorUtil.AddPackageOverride(SLV_Julia.GetActorRef(), SLV_DoNothing ,100)
SLV_Julia.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Ivana.getactorref())
SLV_Ivana.GetActorRef().evaluatePackage()
Utility.wait(2.0)
ActorUtil.AddPackageOverride(SLV_Ivana.GetActorRef(), SLV_DoNothing ,100)
SLV_Ivana.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Diamond.getactorref())
SLV_Diamond.GetActorRef().evaluatePackage()
Utility.wait(2.0)
ActorUtil.AddPackageOverride(SLV_Diamond.GetActorRef(), SLV_DoNothing ,100)
SLV_Diamond.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Valentina.getactorref())
SLV_Valentina.GetActorRef().evaluatePackage()
Utility.wait(2.0)
ActorUtil.AddPackageOverride(SLV_Valentina.GetActorRef(), SLV_DoNothing ,100)
SLV_Valentina.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Ivana Auto 
ReferenceAlias Property SLV_Diamond Auto 
ReferenceAlias Property SLV_Valentina Auto 
ReferenceAlias Property SLV_Julia Auto 
Package Property SLV_DoNothing Auto
