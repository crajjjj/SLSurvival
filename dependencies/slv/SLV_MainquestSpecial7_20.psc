;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial7_20 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(3000)
GetOwningQuest().SetStage(3500)

Utility.wait(5.0)

myScripts.SLV_PlayerMoveTo(CaravanLeader.GetActorRef())
Camilla.GetActorRef().moveto(CaravanLeader.GetActorRef())
ActorUtil.AddPackageOverride(CaravanLeader.GetActorRef(),SLV_FollowPlayer,100)
CaravanLeader.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Package Property SLV_FollowPlayer Auto
ReferenceAlias Property Camilla Auto 
ReferenceAlias Property CaravanLeader Auto
SLV_Utilities Property myScripts auto