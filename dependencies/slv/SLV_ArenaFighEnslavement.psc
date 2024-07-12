;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname SLV_ArenaFighEnslavement Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
debug.SendAnimationEvent(Game.getplayer(), "IdleForceDefaultState")
Game.EnablePlayerControls()
game.SetPlayerAIDriven(false)
SendModEvent("dhlp-Resume")

Utility.wait(2.0)

sendModEvent("SlaverunReloaded_ForceEnslavement")

SLV_ArenaFightQuest.SetObjectiveCompleted(3500)
SLV_ArenaFightQuest.SetStage(9000)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_ArenaFightQuest Auto
