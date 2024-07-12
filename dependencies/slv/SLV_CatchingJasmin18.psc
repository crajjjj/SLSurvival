;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingJasmin18 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(8500)
GetOwningQuest().SetStage(8750)

ActorUtil.AddPackageOverride(SLV_Jasmin.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Jasmin.GetActorRef().evaluatePackage()

myScripts.SLV_BrutusMoodChange(false,1) 
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Jasmin Auto 
Package Property SLV_FollowPlayer Auto
