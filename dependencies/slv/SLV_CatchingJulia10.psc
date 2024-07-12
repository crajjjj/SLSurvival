;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingJulia10 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(3500)
getowningquest().setstage(4000)

SLV_Julia.GetActorRef().enable()
SLV_Julia.GetActorRef().moveto(markarthMarker )

ActorUtil.AddPackageOverride(SLV_Julia.GetActorRef(), SLV_DoNothing ,100)
SLV_Julia.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Julia Auto 
Package Property SLV_DoNothing Auto
ObjectReference Property markarthMarker auto
