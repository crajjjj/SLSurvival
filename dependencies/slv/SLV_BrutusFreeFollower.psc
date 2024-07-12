;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 7
Scriptname SLV_BrutusFreeFollower Extends Scene Hidden

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
myScripts.SLV_enslavementNPC(SLV_Follower.getActorRef())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
myScripts.SLV_enslavementChains(SLV_Follower.getActorRef())

myScripts.SLV_StripBothHands(SLV_Follower.getActorRef())

NextScene.Start()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Scene Property NextScene  Auto  
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Follower  Auto
