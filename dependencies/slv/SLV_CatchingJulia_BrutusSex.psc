;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingJulia_BrutusSex Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_Play2Sex( Game.GetPlayer(), SLV_Brutus.getActorRef(),"Boobjob", true)
Utility.wait(2.0)

ActorUtil.RemovePackageOverride(SLV_Diamond.GetActorRef(), SLV_Kneeling )
SLV_Diamond.GetActorRef().evaluatePackage()
debug.SendAnimationEvent(SLV_Diamond.GetActorRef(), "IdleForceDefaultState")

myScripts.SLV_PlaySex2Synchron( SLV_Diamond.getActorRef(), SLV_Sven.getActorRef(),"Blowjob", true)
SLV_SexIsRunning.setvalue(0)

ActorUtil.AddPackageOverride(SLV_Diamond.GetActorRef(), SLV_Kneeling )
SLV_Diamond.GetActorRef().evaluatePackage()

debug.SendAnimationEvent(SLV_Diamond.getActorRef(), "ZazAPC058")

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
debug.SendAnimationEvent(Game.getPlayer(), "ZazAPC058")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
GlobalVariable Property SLV_SexIsRunning Auto 

ReferenceAlias Property SLV_Diamond Auto
ReferenceAlias Property SLV_Sven Auto
ReferenceAlias Property SLV_Brutus Auto
Package Property SLV_Kneeling Auto

