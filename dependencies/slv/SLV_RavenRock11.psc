;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_RavenRock11 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(5000)
GetOwningQuest().SetStage(5500)

if ThisMenu.SkipScenes
	return
endif

SLV_You.getActorRef().moveto(Game.GetPlayer())
Game.getplayer().additem(SLV_WeaponCane)
SLV_SlaveFollower.getActorRef().additem(SLV_WeaponCane)

SendModEvent("dhlp-Suspend")
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
PunishScene.ForceStart()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_You Auto
ReferenceAlias Property SLV_SlaveFollower Auto

SLV_MCMMenu Property ThisMenu auto
Scene Property PunishScene  Auto
Weapon Property SLV_WeaponCane Auto
