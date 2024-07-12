;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 11
Scriptname SLV_EnslavePC1_Switch Extends Scene Hidden

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
myScripts.SLV_StripBothHands(Game.GetPlayer())
debug.SendAnimationEvent(Game.getPlayer(), "ZazAPC001")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
if SLV_Hardmode.getValue() == 0
	NextScene1.Start()
else
	NextScene2.Start()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
SLV_You.getActorRef().getActorBase().setName(Game.getPlayer().getActorBase().getName())
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Scene Property NextScene1  Auto  
Scene Property NextScene2  Auto  
GlobalVariable Property SLV_Hardmode Auto
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_You Auto
