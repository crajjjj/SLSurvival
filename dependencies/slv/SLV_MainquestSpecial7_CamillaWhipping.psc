;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname SLV_MainquestSpecial7_CamillaWhipping Extends Scene Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
sendModEvent("SlaverunReloaded_WhippingScream")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
Game.EnablePlayerControls()
game.SetPlayerAIDriven(false)
SendModEvent("dhlp-Resume")
debug.SendAnimationEvent(Camilla.getActorRef(), "IdleForceDefaultState")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property Camilla Auto 
