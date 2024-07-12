;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Cheat37 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(0)
getowningquest().setstage(9500)

ActorUtil.ClearPackageOverride(SLV_Diamond.getactorref())
SLV_Diamond.GetActorRef().evaluatePackage()
SLV_Diamond.GetActorRef().moveto(SLV_Torwin.GetActorRef())

ActorUtil.AddPackageOverride(SLV_Diamond.GetActorRef(), SLV_DiamondUseCross ,100)
SLV_Diamond.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Diamond.GetActorRef(), SLV_DiamondWalkToCross ,80)
SLV_Diamond.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Torwin Auto 
ReferenceAlias Property SLV_Diamond Auto 
Package Property SLV_DiamondWalkToCross Auto
Package Property SLV_DiamondUseCross Auto
