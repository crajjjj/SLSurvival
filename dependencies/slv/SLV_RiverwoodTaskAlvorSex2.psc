;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_RiverwoodTaskAlvorSex2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Game.GetPlayer().moveto(akSpeaker)
myScripts.SLV_PlaySex2Synchron(Game.GetPlayer(), akSpeaker,  "Blowjob", true)
SLV_SexIsRunning.setvalue(0)

SLV_You.getActorRef().moveto(Game.GetPlayer())

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_SexIsRunning Auto 
SLV_Utilities Property myScripts auto 
ReferenceAlias Property SLV_You Auto


