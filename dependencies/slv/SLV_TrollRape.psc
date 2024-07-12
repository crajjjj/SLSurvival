;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLV_TrollRape Extends TopicInfo Hidden

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

if SLV_Hardmode.getValue() == 0
	myScripts.SLV_PlaySex2Synchron(Game.GetPlayer(),akSpeaker,"", true)
else	
	if myScripts.SLV_TestCreatureAnimation2(akSpeaker, 3, "")
		myScripts.SLV_PlaySex3Synchron(Game.GetPlayer(),akSpeaker,Attacker,"", true)
	else
		myScripts.SLV_PlaySex2Synchron(Game.GetPlayer(),akSpeaker,"", true)
	endif
endif

SLV_SexIsRunning.setvalue(0)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Actor Property Attacker  Auto  
GlobalVariable Property SLV_SexIsRunning Auto 
GlobalVariable Property SLV_Hardmode Auto
SLV_MCMMenu Property MCMMenu Auto
SLV_Utilities Property myScripts auto


