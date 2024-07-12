;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial5_8b Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(3500)
GetOwningQuest().SetStage(4000)

ActorUtil.AddPackageOverride(SexTourist2a.GetActorRef(), IdleNPC,100)
SexTourist2a.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SexTourist2b.GetActorRef(), IdleNPC,100)
SexTourist2b.GetActorRef().evaluatePackage()

myScripts.SLV_PlayerMoveTo(MarkarthWayMarker)
SexTourist2a.GetActorRef().moveto(MarkarthWayMarker )
SexTourist2b.GetActorRef().moveto(MarkarthWayMarker )
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SexTourist2a Auto 
ReferenceAlias Property SexTourist2b Auto 
ObjectReference Property MarkarthWayMarker Auto
Package Property IdleNPC Auto
SLV_Utilities Property myScripts auto

