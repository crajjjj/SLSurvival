;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SexSlaveTraining4_Sex18 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
actor[] sexActors = new actor[2]
sexActors[0] = Game.GetPlayer()
sexActors[1] = akSpeaker

myScripts.SLV_PlaySexAnimationSynchron(sexActors,"FunnyBizness Molag Snuff Pound","Sex", true)
SLV_SexIsRunning.setvalue(0)

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
debug.SendAnimationEvent(Game.getPlayer(), "ZazAPC058")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
GlobalVariable Property SLV_SexIsRunning Auto 
