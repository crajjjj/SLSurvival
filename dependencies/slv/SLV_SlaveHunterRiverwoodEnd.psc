;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 8
Scriptname SLV_SlaveHunterRiverwoodEnd Extends Scene Hidden

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
myScripts.SLV_DisplayInformation("starting riverwood end")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
startingtimer.StartSlaveHunterWalkTimer()
debug.SendAnimationEvent(Game.getplayer(), "ZazAPOA001")

SLV_SlaveHunterWalkingScene.forceStart()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
SLV_FindSpectators.stop()
SLV_FindSpectators.reset()

debug.SendAnimationEvent(Game.getplayer(), "IdleForceDefaultState")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Scene Property SLV_SlaveHunterWalkingScene auto
Quest Property SLV_FindSpectators Auto 

SLV_SlaveHunter_Timer Property startingtimer auto

