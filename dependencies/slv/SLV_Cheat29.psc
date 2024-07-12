;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Cheat29 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(0)
getowningquest().setstage(9500)

SLV_Blake.getActorRef().enable()

myScripts.SLV_enslavementNPC(SLV_Blake.getActorRef())
myScripts.SLV_enslavementChains(SLV_Blake.getActorRef())

ActorUtil.ClearPackageOverride(SLV_Blake.getactorref())
SLV_Blake.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Blake.GetActorRef(), SLV_BlakeUseCross ,100)
SLV_Blake.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Blake.GetActorRef(), SLV_BlakeWalkToCross ,60)
SLV_Blake.GetActorRef().evaluatePackage()


ActorUtil.ClearPackageOverride(SLV_Ivana.getactorref())
SLV_Ivana.GetActorRef().evaluatePackage()
;SLV_Ivana.GetActorRef().moveto(SLV_IvanaCross)
ActorUtil.AddPackageOverride(SLV_Ivana.GetActorRef(), SLV_IvanaUseCross ,100)
SLV_Ivana.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Ivana.GetActorRef(), SLV_IvanaWalkToCross ,60)
SLV_Ivana.GetActorRef().evaluatePackage()


ActorUtil.ClearPackageOverride(SLV_Diamond.getactorref())
SLV_Diamond.GetActorRef().evaluatePackage()
;SLV_Diamond.GetActorRef().moveto(DiamondCross)
Utility.wait(2.0)

ActorUtil.AddPackageOverride(SLV_Diamond.GetActorRef(), SLV_DiamondUseCross ,100)
SLV_Diamond.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Diamond.GetActorRef(), SLV_DiamondWalkToCross ,80)
SLV_Diamond.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto

ReferenceAlias Property SLV_Ivana Auto 
Package Property SLV_IvanaWalkToCross Auto
Package Property SLV_IvanaUseCross Auto
ReferenceAlias Property SLV_Blake Auto 
Package Property SLV_BlakeWalkToCross Auto
Package Property SLV_BlakeUseCross Auto

ReferenceAlias Property SLV_Diamond Auto 
Package Property SLV_DiamondWalkToCross Auto
Package Property SLV_DiamondUseCross Auto
