;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Cheat31 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(0)
getowningquest().setstage(9500)

SLV_Valentina.getActorRef().enable()

myScripts.SLV_enslavementNPC(SLV_Valentina.getActorRef())
myScripts.SLV_enslavementChains(SLV_Valentina.getActorRef())

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
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Valentina Auto 
Package Property SLV_ValentinaWalkToCross Auto
Package Property SLV_ValentinaUseCross Auto
