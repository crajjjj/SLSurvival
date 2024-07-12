;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 13
Scriptname SLV_BrutusUndress Extends Scene Hidden

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
myScripts.SLV_enslavementFull(false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
myScripts.SLV_enslavementChains(Game.getPlayer())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
if SLV_Follower.getActorRef()
	NextScene2.Start()
else
	NextScene1.Start()
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Scene Property NextScene1  Auto  
Scene Property NextScene2  Auto  

SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Follower  Auto
