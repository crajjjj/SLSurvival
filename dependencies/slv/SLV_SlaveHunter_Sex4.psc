;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SlaveHunter_Sex4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
actor[] sexActors = new actor[5]
sexActors[0] =Game.getplayer()
sexActors[1] = SLV_BountyHunter1.getActorRef()
sexActors[2] = SLV_BountyHunter2.getActorRef()
sexActors[3] = SLV_Bellamy.getActorRef()
sexActors[4] = SLV_Murphy.getActorRef()

myScripts.SLV_Gangbang(sexActors)
SLV_SexIsRunning.setvalue(0)

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_SexIsRunning Auto 
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_BountyHunter1 Auto
ReferenceAlias Property SLV_BountyHunter2 Auto
ReferenceAlias Property SLV_Murphy Auto
ReferenceAlias Property SLV_Bellamy Auto

