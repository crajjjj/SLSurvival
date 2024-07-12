;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingHeike1_8 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(4000)
getowningquest().setstage(4500)

ActorUtil.AddPackageOverride(akSpeaker , SLV_FollowPlayer ,100)
akSpeaker.evaluatePackage()

SLV_Igor.GetActorRef().moveto(markarthMarker )

ActorUtil.AddPackageOverride(SLV_Igor.GetActorRef(), SLV_DoNothing ,100)
SLV_Igor.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Igor Auto 
Package Property SLV_DoNothing Auto
ObjectReference Property markarthMarker auto

Package Property SLV_FollowPlayer Auto
