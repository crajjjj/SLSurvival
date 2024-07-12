;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingHeike3_16 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(7500)
getowningquest().setstage(8000)

ActorUtil.ClearPackageOverride(SLV_Ivana.getactorref())
SLV_Ivana.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Ivana.GetActorRef(), SLV_IvanaUseCross ,100)
SLV_Ivana.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Ivana.GetActorRef(), SLV_IvanaWalkToCross ,60)
SLV_Ivana.GetActorRef().evaluatePackage()
SLV_Ivana.GetActorRef().moveto(IvanaCross)

ActorUtil.ClearPackageOverride(SLV_Valentina.getactorref())
SLV_Valentina.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Valentina.GetActorRef(), SLV_ValentinaUseCross ,100)
SLV_Valentina.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Valentina.GetActorRef(), SLV_ValentinaWalkToCross ,60)
SLV_Valentina.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Valentina Auto 
Package Property SLV_ValentinaWalkToCross Auto
Package Property SLV_ValentinaUseCross Auto
ReferenceAlias Property SLV_Ivana Auto 
Package Property SLV_IvanaWalkToCross Auto
Package Property SLV_IvanaUseCross Auto
ObjectReference Property IvanaCross Auto
