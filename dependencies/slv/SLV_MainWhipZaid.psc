;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 31
Scriptname SLV_MainWhipZaid Extends Scene Hidden

;BEGIN FRAGMENT Fragment_29
Function Fragment_29()
;BEGIN CODE
game.getplayer().stopcombat()

debug.SendAnimationEvent(game.getplayer(), "Unequip")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
;Debug.notification("End 5")
Game.EnablePlayerControls()
game.SetPlayerAIDriven(false)
SendModEvent("dhlp-Resume")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
