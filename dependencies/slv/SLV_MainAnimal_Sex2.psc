;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLV_MainAnimal_Sex2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if MCMMenu.skipCreatureSex
	Game.FadeOutGame(false, true, 5.0, 10.0)
	debug.messagebox("When you regain consciousness, you body hurts as hell and you a drenched in cum.")
	SLV_SexIsRunning.setvalue(0)
	return
endif

myScripts.SLV_PlaySex2Synchron(Game.GetPlayer(),akSpeaker,"Doggystyle, Sex", true)
SLV_SexIsRunning.setvalue(0)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Actor Property Attacker Auto  
GlobalVariable Property SLV_SexIsRunning Auto 
SLV_MCMMenu Property MCMMenu Auto
SLV_Utilities Property myScripts auto


