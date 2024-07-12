;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SlaveCertification4_11 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(7000)
GetOwningQuest().SetStage(7500)

ActorUtil.ClearPackageOverride(SLV_Julia.getactorref())
SLV_Julia.GetActorRef().evaluatePackage()
Utility.wait(2.0)

ActorUtil.AddPackageOverride(SLV_Julia.GetActorRef(), SLV_JuliaUseCross ,100)
SLV_Julia.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Julia.GetActorRef(), SLV_JuliaWalkToCross ,80)
SLV_Julia.GetActorRef().evaluatePackage()
Utility.wait(2.0)


ActorUtil.ClearPackageOverride(SLV_Ivana.getactorref())
SLV_Ivana.GetActorRef().evaluatePackage()
Utility.wait(2.0)

ActorUtil.AddPackageOverride(SLV_Ivana.GetActorRef(), SLV_IvanaUseCross ,100)
SLV_Ivana.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Ivana.GetActorRef(), SLV_IvanaWalkToCross ,80)
SLV_Ivana.GetActorRef().evaluatePackage()
Utility.wait(2.0)


ActorUtil.ClearPackageOverride(SLV_Diamond.getactorref())
SLV_Diamond.GetActorRef().evaluatePackage()
Utility.wait(2.0)

ActorUtil.AddPackageOverride(SLV_Diamond.GetActorRef(), SLV_DiamondUseCross ,100)
SLV_Diamond.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Diamond.GetActorRef(), SLV_DiamondWalkToCross ,80)
SLV_Diamond.GetActorRef().evaluatePackage()
Utility.wait(2.0)


ActorUtil.ClearPackageOverride(SLV_Valentina.getactorref())
SLV_Valentina.GetActorRef().evaluatePackage()
Utility.wait(2.0)

ActorUtil.AddPackageOverride(SLV_Valentina.GetActorRef(), SLV_ValentinaUseCross ,100)
SLV_Valentina.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Valentina.GetActorRef(), SLV_ValentinaWalkToCross ,80)
SLV_Valentina.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Ivana Auto 
Package Property SLV_IvanaWalkToCross Auto
Package Property SLV_IvanaUseCross Auto
ReferenceAlias Property SLV_Diamond Auto 
Package Property SLV_DiamondWalkToCross Auto
Package Property SLV_DiamondUseCross Auto
ReferenceAlias Property SLV_Valentina Auto 
Package Property SLV_ValentinaWalkToCross Auto
Package Property SLV_ValentinaUseCross Auto
ReferenceAlias Property SLV_Julia Auto 
Package Property SLV_JuliaWalkToCross Auto
Package Property SLV_JuliaUseCross Auto
