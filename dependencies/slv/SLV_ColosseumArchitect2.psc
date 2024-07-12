;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ColosseumArchitect2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(500)
GetOwningQuest().SetStage(1000)

SLV_Leonardo.GetActorRef().enable()
SLV_Leonardo.GetActorRef().moveto(markarthMarker )

ActorUtil.AddPackageOverride(SLV_Leonardo.GetActorRef(), SLV_DoNothing ,100)
SLV_Leonardo.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Leonardo Auto 
Package Property SLV_DoNothing Auto
ObjectReference Property markarthMarker auto
