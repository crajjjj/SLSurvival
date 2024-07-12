;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SlaveCertification4_9 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(3500)
GetOwningQuest().SetStage(4000)

ActorUtil.ClearPackageOverride(akSpeaker)
akSpeaker.evaluatePackage()
akSpeaker.moveto(Game.getPlayer())

ActorUtil.AddPackageOverride(akSpeaker, SLV_FollowPlayer ,100)
akSpeaker.evaluatePackage()

myScripts.SLV_BrutusMoodChange(false,1)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Package Property SLV_FollowPlayer Auto

