;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingEva19 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(8000)
getowningquest().setstage(8500)

if ThisMenu.SkipScenes
	ActorUtil.ClearPackageOverride(SLV_Eva.getactorref())
	SLV_Eva.GetActorRef().evaluatePackage()

	ActorUtil.AddPackageOverride(SLV_Eva.GetActorRef(), SLV_EvaUseCross ,100)
	SLV_Eva.GetActorRef().evaluatePackage()

	ActorUtil.AddPackageOverride(SLV_Eva.GetActorRef(), SLV_EvaWalkToCross ,60)
	SLV_Eva.GetActorRef().evaluatePackage()

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
ReferenceAlias Property SLV_Eva Auto 
Package Property SLV_EvaWalkToCross Auto
Package Property SLV_EvaUseCross Auto
