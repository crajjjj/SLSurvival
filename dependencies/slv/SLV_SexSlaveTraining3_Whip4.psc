;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 13
Scriptname SLV_SexSlaveTraining3_Whip4 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
slv_sexisrunning.setvalue(1)
sendModEvent("SlaverunReloaded_WhippingScream")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
slv_sexisrunning.setvalue(1)
sendModEvent("SlaverunReloaded_WhippingScream")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
slv_sexisrunning.setvalue(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
slv_sexisrunning.setvalue(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
slv_sexisrunning.setvalue(1)
sendModEvent("SlaverunReloaded_WhippingScream")
;END CODE
EndFunction
;END FRAGMENT

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
GlobalVariable Property SLV_SexIsRunning Auto 
