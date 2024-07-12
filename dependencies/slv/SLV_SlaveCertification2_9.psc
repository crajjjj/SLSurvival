;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SlaveCertification2_9 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(4000)
getowningquest().setstage(4500)


ActorUtil.ClearPackageOverride(SLV_Julia.getactorref())
SLV_Julia.GetActorRef().evaluatePackage()
SLV_Julia.GetActorRef().moveto(JuliaCross)
Utility.wait(2.0)

ActorUtil.AddPackageOverride(SLV_Julia.GetActorRef(), SLV_JuliaUseCross ,100)
SLV_Julia.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Julia.GetActorRef(), SLV_JuliaWalkToCross ,80)
SLV_Julia.GetActorRef().evaluatePackage()
Utility.wait(2.0)


ActorUtil.ClearPackageOverride(SLV_Ivana.getactorref())
SLV_Ivana.GetActorRef().evaluatePackage()
SLV_Ivana.GetActorRef().moveto(IvanaCross)
Utility.wait(2.0)

ActorUtil.AddPackageOverride(SLV_Ivana.GetActorRef(), SLV_IvanaUseCross ,100)
SLV_Ivana.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Ivana.GetActorRef(), SLV_IvanaWalkToCross ,80)
SLV_Ivana.GetActorRef().evaluatePackage()
Utility.wait(2.0)


ActorUtil.ClearPackageOverride(SLV_Diamond.getactorref())
SLV_Diamond.GetActorRef().evaluatePackage()
SLV_Diamond.GetActorRef().moveto(DiamondCross)
Utility.wait(2.0)

ActorUtil.AddPackageOverride(SLV_Diamond.GetActorRef(), SLV_DiamondUseCross ,100)
SLV_Diamond.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Diamond.GetActorRef(), SLV_DiamondWalkToCross ,80)
SLV_Diamond.GetActorRef().evaluatePackage()
Utility.wait(2.0)


ActorUtil.ClearPackageOverride(SLV_Jane.getactorref())
SLV_Jane.GetActorRef().evaluatePackage()
SLV_Jane.GetActorRef().moveto(JaneCross)
Utility.wait(2.0)

ActorUtil.AddPackageOverride(SLV_Jane.GetActorRef(), SLV_JaneUseCross ,100)
SLV_Jane.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Jane.GetActorRef(), SLV_JaneWalkToCross ,80)
SLV_Jane.GetActorRef().evaluatePackage()
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
ReferenceAlias Property SLV_Jane Auto 
Package Property SLV_JaneWalkToCross Auto
Package Property SLV_JaneUseCross Auto
ReferenceAlias Property SLV_Julia Auto 
Package Property SLV_JuliaWalkToCross Auto
Package Property SLV_JuliaUseCross Auto

ObjectReference Property DiamondCross Auto
ObjectReference Property IvanaCross Auto
ObjectReference Property JuliaCross Auto
ObjectReference Property JaneCross Auto


