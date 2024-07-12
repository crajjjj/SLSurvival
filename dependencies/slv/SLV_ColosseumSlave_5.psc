;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ColosseumSlave_5 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2000)
getowningquest().setstage(2500)

myScripts.SLV_BrutusMoodChange(true,1)

ActorUtil.ClearPackageOverride(SLV_Jaha.getActorRef())
SLV_Jaha.getActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Jaha.getActorRef(), SLV_FollowPlayer ,100)
SLV_Jaha.getActorRef().evaluatePackage()

actor[] sexActors = new actor[2]
sexActors[0] = Game.GetPlayer()
sexActors[1] = akSpeaker

myScripts.SLV_PlaySexKissingSynchron(Game.GetPlayer(),akSpeaker)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Package Property SLV_FollowPlayer Auto
ReferenceAlias Property SLV_Jaha Auto
