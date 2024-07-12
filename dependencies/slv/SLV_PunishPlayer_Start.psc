;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLV_PunishPlayer_Start Extends Package Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(Actor akActor)
;BEGIN CODE
myScripts.SLV_EndWhipping(Game.getplayer())

;Game.EnablePlayerControls()
;game.SetPlayerAIDriven(false)

;Utility.SetIniBool("bDisablePlayerCollision:Havok",false)
;MiscUtil.PrintConsole("Whip player ended")

;game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
;game.SetPlayerAIDriven(true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(Actor akActor)
;BEGIN CODE
myScripts.SLV_StartWhipping(Game.getplayer())

;Game.EnablePlayerControls()
;game.SetPlayerAIDriven(false)

;Utility.SetIniBool("bDisablePlayerCollision:Havok",true)
;MiscUtil.PrintConsole("Whip player started")

;game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
;game.SetPlayerAIDriven(true)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SLV_Utilities Property myScripts auto
