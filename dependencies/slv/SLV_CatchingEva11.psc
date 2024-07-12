;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingEva11 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(4000)
getowningquest().setstage(4500)

SLV_Eva.GetActorRef().enable()
SLV_Eva.GetActorRef().moveto(markarthMarker)

ActorUtil.AddPackageOverride(SLV_Eva.GetActorRef(), SLV_DoNothing ,100)
SLV_Eva.GetActorRef().evaluatePackage()

myScripts.SLV_Play2Sex(Game.GetPlayer(),akSpeaker, "Anal", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Eva Auto 
Package Property SLV_DoNothing Auto
ObjectReference Property markarthMarker auto
SLV_Utilities Property myScripts auto
