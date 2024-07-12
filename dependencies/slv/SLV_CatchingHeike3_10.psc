;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingHeike3_10 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(4500)
getowningquest().setstage(5000)

SLV_Zaid.GetActorRef().moveto(markarthMarker)
ActorUtil.AddPackageOverride(SLV_Zaid.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Zaid.GetActorRef().evaluatePackage()

SLV_Eric.GetActorRef().moveto(markarthMarker)
ActorUtil.AddPackageOverride(SLV_Eric.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Eric.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Package Property SLV_FollowPlayer Auto
ObjectReference Property markarthMarker auto
ReferenceAlias Property SLV_Zaid Auto 
ReferenceAlias Property SLV_Eric Auto 
