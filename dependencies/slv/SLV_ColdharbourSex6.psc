;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ColdharbourSex6 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
actor[] sexActors = new actor[3]
sexActors[0] = Game.GetPlayer()
sexActors[1] = SLV_FuckSlave1.getActorRef()
sexActors[2] = SLV_FuckSlave2.getActorRef()

myScripts.SLV_decreaseWeight()
myScripts.SLV_Gangbang(sexActors)
myScripts.SLV_decreaseWeight()
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
ReferenceAlias Property SLV_FuckSlave1 Auto
ReferenceAlias Property SLV_FuckSlave2 Auto
ReferenceAlias Property SLV_FuckSlave3 Auto
ReferenceAlias Property SLV_FuckSlave4 Auto


