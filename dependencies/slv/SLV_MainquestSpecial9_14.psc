;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial9_14 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(6500)
getowningquest().setstage(9500)

ActorUtil.ClearPackageOverride(SLV_Ivana.getactorref())
SLV_Ivana.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Ivana.GetActorRef(), SLV_IvanaUseCross ,100)
SLV_Ivana.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Ivana.GetActorRef(), SLV_IvanaWalkToCross ,60)
SLV_Ivana.GetActorRef().evaluatePackage()
SLV_Ivana.GetActorRef().moveto(SLV_IvanaCross)

ActorUtil.ClearPackageOverride(SLV_Diamond.getactorref())
SLV_Diamond.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Diamond.GetActorRef(), SLV_DiamondUseCross ,100)
SLV_Diamond.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Diamond.GetActorRef(), SLV_DiamondWalkToCross ,60)
SLV_Diamond.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Ivana Auto 
Package Property SLV_IvanaWalkToCross Auto
Package Property SLV_IvanaUseCross Auto
ObjectReference Property SLV_IvanaCross Auto

ReferenceAlias Property SLV_Diamond Auto 
Package Property SLV_DiamondWalkToCross Auto
Package Property SLV_DiamondUseCross Auto
