;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SlavetrainingValentina2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
debug.SendAnimationEvent(akSpeaker, "IdleForceDefaultState")
Utility.wait(2.0)

myScripts.SLV_PlaySex2Synchron(akSpeaker, SLV_Sven.getActorRef() ,"Blowjob", false)
SLV_SexIsRunning.setvalue(0)

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
;debug.SendAnimationEvent(Game.getPlayer(), "ZazAPC058")
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_SexIsRunning Auto 
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Sven Auto