;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Enslavement13 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if MCMMenu.skipCreatureSex
	Game.FadeOutGame(false, true, 5.0, 10.0)
	debug.messagebox("When you regain consciousness, you body hurts as hell and you a drenched in cum.")
	SLV_SexIsRunning.setvalue(0)
	return
endif

myScripts.SLV_PlaySex2AnimationSynchron(Game.GetPlayer(),akSpeaker,"(Horse) Doggystyle","Sex, Doggystyle", true)
SLV_SexIsRunning.setvalue(0)

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
debug.SendAnimationEvent(Game.getPlayer(), "ZazAPC058")
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_MCMMenu Property MCMMenu Auto
SLV_Utilities Property myScripts auto
GlobalVariable Property SLV_SexIsRunning Auto 
