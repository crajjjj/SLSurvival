;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ColosseumArchitect4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1500)
GetOwningQuest().SetStage(2000)

ActorUtil.ClearPackageOverride(akSpeaker)
akSpeaker.evaluatePackage()
ActorUtil.AddPackageOverride(akSpeaker , SLV_FollowPlayer ,100)
akSpeaker.evaluatePackage()

SLV_Michelangela.GetActorRef().enable()
SLV_Michelangela.GetActorRef().moveto(markarthMarker )

ActorUtil.AddPackageOverride(SLV_Michelangela.GetActorRef(), SLV_DoNothing ,100)
SLV_Michelangela.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Package Property SLV_FollowPlayer Auto
ReferenceAlias Property SLV_Michelangela Auto 
Package Property SLV_DoNothing Auto
ObjectReference Property markarthMarker auto
