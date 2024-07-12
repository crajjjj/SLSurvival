;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial9_7 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(3000)
getowningquest().setstage(3500)

ActorUtil.ClearPackageOverride(SLV_Diamond.GetActorRef())
SLV_Diamond.GetActorRef().evaluatePackage()
SLV_Diamond.GetActorRef().moveto(Game.getPlayer())
ActorUtil.AddPackageOverride(SLV_Diamond.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Diamond.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Ivana.GetActorRef())
SLV_Ivana.GetActorRef().evaluatePackage()
SLV_Ivana.GetActorRef().moveto(Game.getPlayer())
ActorUtil.AddPackageOverride(SLV_Ivana.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Ivana.GetActorRef().evaluatePackage()

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
ReferenceAlias Property SLV_Diamond Auto 
ReferenceAlias Property SLV_Ivana Auto 
Package Property SLV_FollowPlayer Auto
