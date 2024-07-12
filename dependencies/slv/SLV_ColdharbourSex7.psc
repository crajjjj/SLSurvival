;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ColdharbourSex7 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
actor[] sexActors = new actor[2]
sexActors[1] = Game.GetPlayer()
sexActors[0] = SLV_FuckSlave2.getActorRef()

myScripts.SLV_decreaseWeight()
myScripts.SLV_PlaySexAnimationSynchron(sexActors,"3jiou Breastfeeding Straight","Breastfeeding", true)
myScripts.SLV_decreaseWeight()
SLV_SexIsRunning.setvalue(0)

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
debug.SendAnimationEvent(Game.getPlayer(), "ZazAPC058")

SLV_FuckSlave2.getActorRef().kill()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
GlobalVariable Property SLV_SexIsRunning Auto 
ReferenceAlias Property SLV_FuckSlave2 Auto

