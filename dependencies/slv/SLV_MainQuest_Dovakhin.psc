;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLV_MainQuest_Dovakhin Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;debug.messagebox("Slaver questline is disabled for this beta version!")
;return

Game.GetPlayer().AddToFaction(zbfSlaveMasterFaction) 
GetOwningQuest().SetObjectiveCompleted(250)
GetOwningQuest().SetStage(1050)

if ThisMenu.SkipScenes
	return
endif
Game.GetPlayer().addItem(Whip)
SendModEvent("dhlp-Suspend")

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
PunishScene.Start()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SlV_MCMMenu Property ThisMenu auto
Scene Property PunishScene  Auto  
Faction Property zbfSlaveMasterFaction auto
Weapon Property Whip auto