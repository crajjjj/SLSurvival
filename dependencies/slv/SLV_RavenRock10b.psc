;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_RavenRock10b Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(4500)
GetOwningQuest().SetStage(5000)

if ThisMenu.SkipScenes
	return
endif

SLV_You.getActorRef().moveto(Game.GetPlayer())
SLV_Lleril.getActorRef().moveto(Game.GetPlayer())
ThisMenu.slavefollower.moveto(Game.getPlayer())

SLV_Lleril.getActorRef().addItem(SLV_WeaponCane)
SLV_SlaveFollower.ForceRefTo(ThisMenu.slavefollower)

SendModEvent("dhlp-Suspend")
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
PunishScene.ForceStart()

ActorUtil.ClearPackageOverride(akSpeaker)
akSpeaker.evaluatePackage()
ActorUtil.AddPackageOverride(akSpeaker, SLV_FollowPlayer ,100)
akSpeaker.evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Frea.getActorRef())
SLV_Frea.getActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Frea.getActorRef(), SLV_FollowPlayer ,100)
SLV_Frea.getActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Package Property SLV_FollowPlayer Auto
ReferenceAlias Property SLV_You Auto
SLV_MCMMenu Property ThisMenu auto
Scene Property PunishScene Auto
ReferenceAlias Property SLV_Lleril Auto
ReferenceAlias Property SLV_Frea Auto
ReferenceAlias Property SLV_SlaveFollower Auto 

Weapon Property SLV_WeaponCane Auto
