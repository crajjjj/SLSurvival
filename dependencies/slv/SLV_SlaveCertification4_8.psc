;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SlaveCertification4_8 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(3500)
GetOwningQuest().SetStage(4000)

ActorUtil.ClearPackageOverride(akSpeaker)
akSpeaker.evaluatePackage()
ActorUtil.AddPackageOverride(akSpeaker, SLV_FollowPlayer ,100)
akSpeaker.evaluatePackage()

myScripts.SLV_BrutusMoodChange(true,1)
myScripts.SLV_Play2SexAnimation(Game.GetPlayer(),akSpeaker, "Leito Kissing","Kissing", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Package Property SLV_FollowPlayer Auto