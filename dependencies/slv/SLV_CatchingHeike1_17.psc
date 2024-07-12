;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingHeike1_17 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(8500)
getowningquest().setstage(9000)

ActorUtil.ClearPackageOverride(SLV_Valentina.getactorref())
SLV_Valentina.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Valentina.GetActorRef(), SLV_ValentinaUseCross ,100)
SLV_Valentina.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Valentina.GetActorRef(), SLV_ValentinaWalkToCross ,60)
SLV_Valentina.GetActorRef().evaluatePackage()

if ThisMenu.SkipScenes
	return
endif

SendModEvent("dhlp-Suspend")
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
BeatScene.start()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Scene Property BeatScene  Auto  
SLV_MCMMenu Property ThisMenu auto
ReferenceAlias Property SLV_Valentina Auto 
Package Property SLV_ValentinaWalkToCross Auto
Package Property SLV_ValentinaUseCross Auto
