;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SlaveCertification1_10 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(8500)
GetOwningQuest().SetStage(9000)

ActorUtil.RemoveAllPackageOverride(SLV_DragonsreachCenter)

ActorUtil.AddPackageOverride(akSpeaker, SLV_FollowPlayer,100)
akSpeaker.evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Ivana.getActorRef(), SLV_FollowPlayer,100)
SLV_Ivana.getActorRef().evaluatePackage()

myScripts.SLV_StripBothHands(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Package Property SLV_DragonsreachCenter auto
Package Property SLV_FollowPlayer auto
ReferenceAlias Property SLV_Ivana auto
