;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingAva_Sex4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_Play2Sex(SLV_Ava.getActorRef(),SLV_Igor.getActorRef(), "Anal", true)
Utility.wait(2.0)

actor[] sexActors = new actor[1]
sexActors[0] = Game.GetPlayer()

myScripts.SLV_PlaySexSynchron(sexActors,"Masturbation,F", false)
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

ReferenceAlias Property SLV_Igor Auto
ReferenceAlias Property SLV_Ava Auto


