;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLV_SlaveHunterSexNone Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
SLV_SlaveHunterRiverwoodEndScene.start()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_You Auto
GlobalVariable Property SLV_SexIsRunning Auto 
SLV_FindSpecators Property spectators auto
SLV_SlaveHunter Property slaveHunter auto

Scene Property SLV_SlaveHunterRiverwoodEndScene auto
