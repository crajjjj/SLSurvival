;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 19
Scriptname SLV_ArenaShowEnd Extends Scene Hidden

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN CODE
myScripts.SLV_DisplayInformation("Start Phase7 ")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
ActorUtil.RemoveAllPackageOverride(SLV_DoNothing2)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
myScripts.SLV_DisplayInformation("End Phase6 ")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
myScripts.SLV_DisplayInformation("End Phase 7") 

debug.SendAnimationEvent(Game.getplayer(), "IdleForceDefaultState")
Game.EnablePlayerControls()
game.SetPlayerAIDriven(false)
SendModEvent("dhlp-Resume")
;arenaLever.activate(Game.getplayer(), true)

if SLV_ArenaShowQuest.getStage() != 9500
	SLV_ArenaShowQuest.SetObjectiveCompleted(1500)
	SLV_ArenaShowQuest.SetStage(9500)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
myScripts.SLV_DisplayInformation("Start Phase6 ")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ObjectReference Property arenaLever Auto
Package Property SLV_DoNothing2 auto
Quest Property SLV_ArenaShowQuest auto
SLV_Utilities Property myScripts auto


