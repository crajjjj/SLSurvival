;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiteWedding2_Sex18 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
debug.SendAnimationEvent(SLV_Raven.getActorRef(), "IdleForceDefaultState")

myScripts.SLV_PlaySex2Synchron(SLV_Raven.getActorRef(),akSpeaker, "Blowjob", true)
SLV_SexIsRunning.setvalue(0)

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
debug.SendAnimationEvent(SLV_Raven.getActorRef(), "ZazAPC058")
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_SexIsRunning Auto 
ReferenceAlias Property SLV_Raven Auto
SLV_Utilities Property myScripts auto