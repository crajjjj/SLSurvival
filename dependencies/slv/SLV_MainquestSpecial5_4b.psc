;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial5_4b Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1500)
getowningquest().setstage(2000)

ActorUtil.AddPackageOverride(SexTourist1a.GetActorRef(), IdleNPC,100)
SexTourist1a.GetActorRef().evaluatePackage()

myScripts.SLV_PlayerMoveTo(RiftenWayMarker)
SexTourist1a.GetActorRef().moveto(RiftenWayMarker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SexTourist1a Auto 
ObjectReference Property RiftenWayMarker Auto
Package Property IdleNPC Auto
SLV_Utilities Property myScripts auto
