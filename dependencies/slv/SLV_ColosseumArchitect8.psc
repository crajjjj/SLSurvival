;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ColosseumArchitect8 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(3000)
GetOwningQuest().SetStage(3500)

ActorUtil.ClearPackageOverride(akSpeaker)
akSpeaker.evaluatePackage()

ActorUtil.AddPackageOverride(akSpeaker, SLV_FollowPlayer ,100)
akSpeaker.evaluatePackage()

myScripts.SLV_Play2Sex(Game.getPlayer(), akSpeaker ,"Anal", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Package Property SLV_FollowPlayer Auto
