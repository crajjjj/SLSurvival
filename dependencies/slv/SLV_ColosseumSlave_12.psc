;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ColosseumSlave_12 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(5000)
getowningquest().setstage(5500)

Game.GetPlayer().RemoveItem(Gold, 1000)

SLV_Bones.GetActorRef().moveto(markarthMarker )
SLV_Bones.GetActorRef().enable()

ActorUtil.ClearPackageOverride(SLV_Bones.GetActorRef())
SLV_Bones.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Bones.GetActorRef(), SLV_DoNothing ,100)
SLV_Bones.GetActorRef().evaluatePackage()

SLV_Bones.GetActorRef().moveto(markarthMarker )
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Bones Auto 
Package Property SLV_DoNothing Auto
ObjectReference Property markarthMarker auto
MiscObject Property Gold  Auto 
