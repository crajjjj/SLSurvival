;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingAva13 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(6000)
getowningquest().setstage(6500)

ActorUtil.AddPackageOverride(akSpeaker, SLV_FollowPlayer ,100)
akSpeaker.evaluatePackage()

if ThisMenu.SkipScenes
	ActorUtil.ClearPackageOverride(SLV_Igor.getactorref())
	SLV_Igor.GetActorRef().evaluatePackage()
	return
endif

SLV_You.getActorRef().moveto(Game.GetPlayer())

SendModEvent("dhlp-Suspend")
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
PunishScene.ForceStart()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_You Auto
ReferenceAlias Property SLV_Igor Auto
SLV_MCMMenu Property ThisMenu auto
Scene Property PunishScene  Auto
Package Property SLV_FollowPlayer Auto
