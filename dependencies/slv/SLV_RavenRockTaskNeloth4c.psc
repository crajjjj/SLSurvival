;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_RavenRockTaskNeloth4c Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1500)
GetOwningQuest().SetStage(2000)

ActorUtil.ClearPackageOverride(SLV_Frea.getactorref())
SLV_Frea.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Frea.GetActorRef(), SLV_Idle ,100)
SLV_Frea.GetActorRef().evaluatePackage()
SLV_Frea.GetActorRef().moveto(Game.getPlayer())

SLV_Neloth.getactorref().additem(SLV_WeaponCane)
SLV_UseSlaverAsSlave.setValue(1)
myScripts.SLV_PikeMoodChange(true,1)

if ThisMenu.SkipScenes
	return
endif

SLV_You.getActorRef().moveto(Game.GetPlayer())

SendModEvent("dhlp-Suspend")
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)

SLV_SlaveFollower.ForceRefTo(SLV_You.getActorRef())
SLV_SlaveFollowerMain.ForceRefTo(SLV_You.getActorRef())

PunishScene.ForceStart()

ActorUtil.ClearPackageOverride(akSpeaker)
akSpeaker.evaluatePackage()
ActorUtil.AddPackageOverride(akSpeaker, SLV_FollowPlayer ,100)
akSpeaker.evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
GlobalVariable Property SLV_UseSlaverAsSlave auto
Package Property SLV_FollowPlayer Auto
ReferenceAlias Property SLV_Frea Auto 
ReferenceAlias Property SLV_Neloth Auto 
ReferenceAlias Property SLV_SlaveFollower Auto 
ReferenceAlias Property SLV_SlaveFollowerMain Auto 
Faction Property SlaverunSlaverFaction Auto

Package Property SLV_Idle Auto
ReferenceAlias Property SLV_You Auto
SLV_MCMMenu Property ThisMenu auto

Scene Property PunishScene Auto

Weapon Property SLV_WeaponCane Auto
