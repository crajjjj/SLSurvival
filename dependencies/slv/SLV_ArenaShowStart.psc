;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 15
Scriptname SLV_ArenaShowStart Extends Scene Hidden

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
myScripts.SLV_SexlabStripNPC(game.getplayer())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
SLV_You.getActorRef().moveto(Game.getPlayer())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
arenaLever.activate(Game.getplayer(), true)
SLV_You.getActorRef().moveto(Game.getPlayer())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
myScripts.SLV_DisplayInformation("Phase6 "  + NextScene2)

NextScene2.Start()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_You Auto
ObjectReference Property arenaLever Auto
GlobalVariable Property SLV_SexIsRunning Auto 
Scene Property NextScene1  Auto  
Scene Property NextScene2  Auto  


SLV_Utilities Property myScripts auto



