;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SlaveCertification1_4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2000)
GetOwningQuest().SetStage(3000)

ActorUtil.AddPackageOverride(SLV_Diamond.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Diamond.GetActorRef().evaluatePackage()

myScripts.SLV_IvanaMoodChange(false,1) 
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Diamond Auto 
Package Property SLV_FollowPlayer Auto
