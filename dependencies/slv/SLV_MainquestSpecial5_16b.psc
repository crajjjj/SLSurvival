;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial5_16b Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(7500)
GetOwningQuest().SetStage(8000)

ActorUtil.AddPackageOverride(SexTourist2a.GetActorRef(), IdleNPC,100)
SexTourist2a.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SexTourist2b.GetActorRef(), IdleNPC,100)
SexTourist2b.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SexTourist3a.GetActorRef(), IdleNPC,100)
SexTourist3a.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SexTourist3b.GetActorRef(), IdleNPC,100)
SexTourist3b.GetActorRef().evaluatePackage()

myScripts.SLV_PlayerMoveTo(SolitudeWayMarker)
SexTourist2a.GetActorRef().moveto(SolitudeWayMarker )
SexTourist2b.GetActorRef().moveto(SolitudeWayMarker )
SexTourist3a.GetActorRef().moveto(SolitudeWayMarker )
SexTourist3b.GetActorRef().moveto(SolitudeWayMarker )
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SexTourist2a Auto 
ReferenceAlias Property SexTourist2b Auto 
ReferenceAlias Property SexTourist3a Auto 
ReferenceAlias Property SexTourist3b Auto 
ObjectReference Property SolitudeWayMarker Auto
Package Property IdleNPC Auto
SLV_Utilities Property myScripts auto
