;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingJane4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(750)
getowningquest().setstage(1000)

ActorUtil.AddPackageOverride(SLV_Jane.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Jane.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Constantine.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Constantine.GetActorRef().evaluatePackage()

if ThisMenu.SkipScenes
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
SLV_MCMMenu Property ThisMenu auto
Scene Property PunishScene  Auto

ReferenceAlias Property SLV_Jane Auto 
ReferenceAlias Property SLV_Constantine Auto 
Package Property SLV_FollowPlayer Auto
