;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ColosseumFunFair_Passage Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
debug.SendAnimationEvent(Game.getplayer(), "IdleForceDefaultState")
Game.EnablePlayerControls()
game.SetPlayerAIDriven(false)
SendModEvent("dhlp-Resume")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment