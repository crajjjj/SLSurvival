;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial9_Sex7 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_PlaySex3Synchron(Game.getPlayer(), SLV_Torwin.getActorRef(), SLV_MariaSlave.getActorRef(), "MMF,Sex", true)
SLV_SexIsRunning.setvalue(0)

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)

debug.SendAnimationEvent(Game.getPlayer(), "ZazAPC058")
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_SexIsRunning Auto 
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Torwin Auto
ReferenceAlias Property SLV_MariaSlave Auto
