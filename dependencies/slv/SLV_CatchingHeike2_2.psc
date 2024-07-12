;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingHeike2_2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(500)
getowningquest().setstage(1000)

ActorUtil.AddPackageOverride(akSpeaker , SLV_FollowPlayer ,100)
akSpeaker.evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Sven.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Sven.GetActorRef().evaluatePackage()

myScripts.SLV_Play3Sex(Game.getPlayer(), akspeaker, SLV_Sven.getActorRef(), "MMF", false)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Sven Auto 
Package Property SLV_FollowPlayer Auto
