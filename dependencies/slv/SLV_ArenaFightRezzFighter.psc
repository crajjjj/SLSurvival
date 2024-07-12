;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 17
Scriptname SLV_ArenaFightRezzFighter Extends Scene Hidden

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
myScripts.SLV_DisplayInformation("Phase8")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
myScripts.SLV_DisplayInformation("Phase9 " + SLV_ArenaSpittingScene)

int fightmode = SLV_ColosseumFightMode.getValue() as int
if fightmode == 0
	SLV_ArenaSpittingScene.Start()
else
	SLV_ArenaResurrectionScene.Start()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
SLV_SexIsRunning.setValue(1)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_SexIsRunning Auto 
SLV_PrepareDeadPlayer Property deadPlayer Auto

Scene Property SLV_ArenaChoppingScene Auto 
Scene Property SLV_ArenaResurrectionScene Auto 
Scene Property SLV_ArenaSpittingScene Auto 
GlobalVariable Property SLV_ColosseumFightMode Auto

SLV_Utilities Property myScripts auto
SLV_MCMMenu Property MCMMenu Auto


