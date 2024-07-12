;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLV_SexSlaveTraining2DraugrSex Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if ThisMenu.skipCreatureSex
	Game.FadeOutGame(false, true, 5.0, 10.0)
	debug.messagebox("When you regain consciousness, you body hurts as hell and you a drenched in cum.")
	return
endif

actor[] sexActors = new actor[5]
sexActors[0] = Game.GetPlayer()
sexActors[1] = akSpeaker 
sexActors[2] = draugr2
sexActors[3] = draugr3
sexActors[4] = draugr4

myScripts.SLV_PlaySex(sexActors,"", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
SLV_MCMMenu Property ThisMenu auto

Actor Property Draugr2 Auto 
Actor Property Draugr3 Auto 
Actor Property Draugr4 Auto 


