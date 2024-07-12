;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial4_10 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if ThisMenu.SkipScenes
	GetOwningQuest().SetObjectiveCompleted(2500)
	GetOwningQuest().SetStage(4500)
	return
endif

if game.getplayer().isinfaction(zbfSlaverFaction)	
	GetOwningQuest().SetObjectiveCompleted(2500)
	GetOwningQuest().SetStage(4500)
else
	GetOwningQuest().SetObjectiveCompleted(2500)
	GetOwningQuest().SetStage(3000)
endif
 
Utility.wait(10.0)
Debug.MessageBox("Suddenly the camp is ambushed by Stormcloak soldiers and you flee like a coward.")
SendModEvent("dhlp-Suspend")

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)

;Game.GetPlayer().moveto(CampWayMarker )
;Soldier.GetActorRef().moveto(Game.GetPlayer())
;debug.SendAnimationEvent(game.getplayer(), "ZazAPC011")

ActorUtil.AddPackageOverride(Soldier.GetActorRef(), IdleNPC,100)
Soldier.GetActorRef().evaluatePackage()
Soldier.GetActorRef().addItem(Whip)
;ActorUtil.AddPackageOverride(Campleader.GetActorRef(), IdleNPC,100)
;Campleader.GetActorRef().evaluatePackage()
Campleader.GetActorRef().addItem(Whip)

PunishScene.Start()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_MCMMenu Property ThisMenu auto
Scene Property PunishScene  Auto 
Weapon Property Whip Auto
ReferenceAlias Property Soldier Auto 
ReferenceAlias Property Campleader Auto 
ObjectReference Property CampWayMarker Auto
Package Property IdleNPC Auto
Faction Property zbfSlaverFaction Auto
