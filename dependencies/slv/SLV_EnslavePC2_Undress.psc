;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 9
Scriptname SLV_EnslavePC2_Undress Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
if SLV_Follower.getActorRef() && MCMMenu.FemaleFollowersMimicPlayer && (SlV_StoryMode.getValue() ==1)
	NextScene2.Start()
else
	NextScene1.Start()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
myScripts.SLV_enslavementChains(Game.getPlayer())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
myScripts.SLV_enslavementFull(false)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Scene Property NextScene1  Auto  
Scene Property NextScene2  Auto  
SLV_MCMMenu Property MCMMenu Auto
GlobalVariable Property SLV_Storymode Auto

SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Follower  Auto
