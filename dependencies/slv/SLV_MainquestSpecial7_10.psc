;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial7_10 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(4000)
GetOwningQuest().SetStage(4500)

if ThisMenu.SkipScenes
	ActorUtil.ClearPackageOverride(akSpeaker)
	akSpeaker.evaluatePackage()
	return
endif

SendModEvent("dhlp-Suspend")
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)

if Game.getPlayer().IsInFaction(SlaverunSlaveFaction)
	PunishScene.Start()
else
	SlaverPunishScene.Start()
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SlV_MCMMenu Property ThisMenu auto
Scene Property PunishScene  Auto  
Scene Property SlaverPunishScene  Auto  
Faction Property SlaverunSlaveFaction Auto


