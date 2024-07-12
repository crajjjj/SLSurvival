;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WalkOfShame2_Sex12 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
actor[] sexActors = new actor[5]
sexActors[0] =Game.getplayer()
sexActors[1] = SLV_Bellamy.getActorRef()
sexActors[2] = SLV_Murphy.getActorRef()
sexActors[3] = SLV_Watcher1.getActorRef()
sexActors[4] = SLV_Watcher2.getActorRef()

myScripts.SLV_Gangbang(sexActors)
SLV_SexIsRunning.setvalue(0)

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)

ActorUtil.ClearPackageOverride(SLV_Ivana.getactorref())
SLV_Ivana.GetActorRef().evaluatePackage()
Utility.wait(2.0)

ActorUtil.AddPackageOverride(SLV_Ivana.GetActorRef(), SLV_IvanaUseCross ,100)
SLV_Ivana.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Ivana.GetActorRef(), SLV_IvanaWalkToCross ,80)
SLV_Ivana.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Ivana Auto 
Package Property SLV_IvanaWalkToCross Auto
Package Property SLV_IvanaUseCross Auto
GlobalVariable Property SLV_SexIsRunning Auto 
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Watcher1 Auto
ReferenceAlias Property SLV_Watcher2 Auto
ReferenceAlias Property SLV_Murphy Auto
ReferenceAlias Property SLV_Bellamy Auto

