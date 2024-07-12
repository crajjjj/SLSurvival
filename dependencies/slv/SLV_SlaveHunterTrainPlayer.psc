;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 8
Scriptname SLV_SlaveHunterTrainPlayer Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
;startingtimer.StartSlaveHunterWalkTimer()

if SLV_StoryMode.getValue() != 0 
	SLV_SlaveHunterRiverwoodScene.ForceStart()
else
	SLV_SlaveHunterWalkingScene.ForceStart()
endif
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

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Scene Property nextScene auto

Scene Property SLV_SlaveHunterRiverwoodScene auto

GlobalVariable Property SLV_SexIsRunning Auto 
SLV_SlaveHunter_Timer Property startingtimer auto

GlobalVariable Property SLV_StoryMode Auto 
Scene Property SLV_SlaveHunterWalkingScene  Auto 

