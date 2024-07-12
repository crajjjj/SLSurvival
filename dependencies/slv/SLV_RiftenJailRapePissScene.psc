;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 7
Scriptname SLV_RiftenJailRapePissScene Extends Scene Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
debug.SendAnimationEvent(Pisser.getActorRef(), "IdleForceDefaultState")
debug.SendAnimationEvent(Game.getPlayer(), "IdleForceDefaultState")
SendModEvent("dhlp-Resume")
Game.EnablePlayerControls()
game.SetPlayerAIDriven(false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
Game.EnablePlayerControls()
game.SetPlayerAIDriven(false)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property Pisser Auto 
