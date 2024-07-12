;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingHeike3_4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1500)
getowningquest().setstage(2000)

SLV_Ava.GetActorRef().enable()
SLV_Ava.GetActorRef().moveto(markarthMarker)

ActorUtil.AddPackageOverride(SLV_Ava.GetActorRef(), SLV_DoNothing ,100)
SLV_Ava.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Ava Auto 
Package Property SLV_DoNothing Auto
ObjectReference Property markarthMarker auto
