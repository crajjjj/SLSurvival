;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SolitudeSlavery7 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2000)
getowningquest().setstage(2500)

ActorUtil.ClearPackageOverride(SexSlave.getactorref())
SexSlave.getactorref().evaluatePackage()

Utility.wait(2.0)
ActorUtil.AddPackageOverride(SexSlave.GetActorRef(), crucified ,100)
SexSlave.GetActorRef().evaluatePackage()

myScripts.SLV_Play2Sex(Game.GetPlayer(),akSpeaker, "Doggystyle", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property SexSlave Auto 
Package Property crucified Auto