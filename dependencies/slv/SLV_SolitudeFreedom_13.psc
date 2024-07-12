;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SolitudeFreedom_13 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(5500)
getowningquest().setstage(6000)

akSpeaker.moveto(outsideCastle)

myScripts.SLV_PlayerMoveTo(outsideCastle)

ActorUtil.ClearPackageOverride(akSpeaker)
akSpeaker.evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Slave1.getActorRef())
SLV_Slave1.getActorRef().evaluatePackage()
ActorUtil.ClearPackageOverride(SLV_Slave2.getActorRef())
SLV_Slave2.getActorRef().evaluatePackage()
ActorUtil.ClearPackageOverride(SLV_Slave3.getActorRef())
SLV_Slave3.getActorRef().evaluatePackage()
ActorUtil.ClearPackageOverride(SLV_Slave4.getActorRef())
SLV_Slave4.getActorRef().evaluatePackage()
ActorUtil.ClearPackageOverride(SLV_Slave5.getActorRef())
SLV_Slave5.getActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ObjectReference Property outsideCastle Auto

ReferenceAlias Property SLV_Slave1 Auto
ReferenceAlias Property SLV_Slave2 Auto
ReferenceAlias Property SLV_Slave3 Auto
ReferenceAlias Property SLV_Slave4 Auto
ReferenceAlias Property SLV_Slave5 Auto