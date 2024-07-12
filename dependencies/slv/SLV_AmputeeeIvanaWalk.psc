;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_AmputeeeIvanaWalk Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ActorUtil.ClearPackageOverride(SLV_Farengar.getactorref())
SLV_Farengar.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Farengar.GetActorRef(), SLV_WalktoDragonsReachCenter,100)
SLV_Farengar.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Zaid.getactorref())
SLV_Zaid.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Zaid.GetActorRef(), SLV_WalktoDragonsReachCenter,100)
SLV_Zaid.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Ivana.getactorref())
SLV_Ivana.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Ivana.GetActorRef(), SLV_WalktoDragonsReachCenter,100)
SLV_Ivana.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Farengar Auto 
ReferenceAlias Property SLV_Zaid Auto
ReferenceAlias Property SLV_Ivana Auto
Package Property SLV_WalktoDragonsReachCenter Auto
