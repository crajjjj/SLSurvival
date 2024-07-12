;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingHeike3_Sex2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
debug.SendAnimationEvent(SLV_Ava.getactorref(), "IdleForceDefaultState")
ActorUtil.ClearPackageOverride(SLV_Ava.getactorref())
SLV_Ava.GetActorRef().evaluatePackage()

myScripts.SLV_Play2Sex(Game.GetPlayer(),SLV_Igor.getActorRef(), "Sex", true)
Utility.wait(1.0)

myScripts.SLV_Play2Sex(SLV_Valentina.getActorRef(),SLV_Sven.getActorRef(), "Sex", true)
Utility.wait(1.0)

myScripts.SLV_PlaySex2Synchron(SLV_Ivana.getActorRef(), akspeaker, "Sex", true)
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
ReferenceAlias Property SLV_Ivana Auto
ReferenceAlias Property SLV_Sven Auto
ReferenceAlias Property SLV_Igor Auto
ReferenceAlias Property SLV_Valentina Auto
ReferenceAlias Property SLV_Ava Auto

