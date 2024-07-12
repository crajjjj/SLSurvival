;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingBlake_Sex2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
actor[] sexActors = new actor[5]
sexActors[0] = Game.GetPlayer()
sexActors[1] = SLV_JarlWhiterun.getActorRef()
sexActors[2] = SLV_Amren.getActorRef()
sexActors[3] = SLV_Nazeem.getActorRef()
sexActors[4] = SLV_Brutus.getActorRef()

myScripts.SLV_Gangbang(sexActors)
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
ReferenceAlias Property SLV_JarlWhiterun Auto
ReferenceAlias Property SLV_Amren Auto
ReferenceAlias Property SLV_Nazeem Auto
ReferenceAlias Property SLV_Brutus Auto


