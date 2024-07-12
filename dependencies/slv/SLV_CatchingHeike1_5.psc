;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingHeike1_5 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2500)
getowningquest().setstage(3000)

SLV_Valentina.GetActorRef().enable()
SLV_Valentina.GetActorRef().moveto(markarthMarker)

ActorUtil.AddPackageOverride(SLV_Valentina.GetActorRef(), SLV_DoNothing ,100)
SLV_Valentina.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Valentina Auto 
Package Property SLV_DoNothing Auto
ObjectReference Property markarthMarker auto
