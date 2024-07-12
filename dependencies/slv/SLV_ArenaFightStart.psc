;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 11
Scriptname SLV_ArenaFightStart Extends Scene Hidden

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
SLV_You.getActorRef().moveto(Game.getPlayer())

arena.SLV_StopMyFollowers(true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
arenaLever.activate(Game.getplayer(), true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
NextScene1.Start()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_You Auto
ObjectReference Property arenaLever Auto
GlobalVariable Property SLV_SexIsRunning Auto 
Scene Property NextScene1  Auto  
SLV_ArenaUtilities Property arena auto

