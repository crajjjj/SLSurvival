;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_RavenRockTaskNeloth4b Extends TopicInfo Hidden

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
ThisMenu.slavefollower.moveto(Game.getPlayer())

SLV_Neloth.getactorref().additem(SLV_WeaponCane)

myScripts.SLV_PikeMoodChange(false,1)
SLV_UseSlaverAsSlave.setValue(0)

if ThisMenu.SkipScenes
	return
endif

SLV_You.getActorRef().moveto(Game.GetPlayer())

SendModEvent("dhlp-Suspend")
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)

SLV_SlaveFollower.ForceRefTo(ThisMenu.slavefollower)
SLV_SlaveFollowerMain.ForceRefTo(ThisMenu.slavefollower)

PunishScene.ForceStart()

ActorUtil.ClearPackageOverride(akSpeaker)
akSpeaker.evaluatePackage()
ActorUtil.AddPackageOverride(akSpeaker, SLV_FollowPlayer ,100)
akSpeaker.evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_UseSlaverAsSlave auto
SLV_Utilities Property myScripts auto
Package Property SLV_FollowPlayer Auto
ReferenceAlias Property SLV_Frea Auto 
ReferenceAlias Property SLV_Neloth Auto 
ReferenceAlias Property SLV_SlaveFollower Auto 
ReferenceAlias Property SLV_SlaveFollowerMain Auto 
Faction Property SlaverunSlaverFaction Auto

Package Property SLV_Idle Auto
ReferenceAlias Property SLV_You Auto
SLV_MCMMenu Property ThisMenu auto

Scene Property PunishScene  Auto
Weapon Property SLV_WeaponCane Auto
