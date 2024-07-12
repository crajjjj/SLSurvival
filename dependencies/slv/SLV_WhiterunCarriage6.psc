;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiterunCarriage6 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Game.GetPlayer().moveto(Horse)

if ThisMenu.skipCreatureSex
	Game.FadeOutGame(false, true, 5.0, 10.0)
	debug.messagebox("When you regain consciousness, you body hurts as hell and you a drenched in cum.")
else
	myScripts.SLV_Play2Sex(Game.GetPlayer(),Horse, "Anal", true)
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Actor Property Horse  Auto  
SlV_MCMMenu Property ThisMenu auto
