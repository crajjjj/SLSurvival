;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_TrainingEnd4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(9500)
GetOwningQuest().SetStage(10000)

if ThisMenu.SkipScenes
	myScripts.SLV_IvanaReset()
	Game.getplayer().additem(SLV_SlaverCertificate.getReference())
	return
endif

ActorUtil.AddPackageOverride(SLV_JarlWhiterun.GetActorRef(), WalkDragonsreachCenter ,100)
SLV_JarlWhiterun.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Brutus.GetActorRef(), WalkDragonsreachCenter ,100)
SLV_Brutus.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Belethor.GetActorRef(), WalkDragonsreachCenter ,100)
SLV_Belethor.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Zaid.GetActorRef(), WalkDragonsreachCenter ,100)
SLV_Zaid.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Ivana.getactorref())
SLV_Ivana.getactorref().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Ivana.GetActorRef(), WalkDragonsreachCenter ,100)
SLV_Ivana.GetActorRef().evaluatePackage()

SLV_JarlWhiterun.GetActorRef().moveto(DragonsReachWayMarker)
SLV_Brutus.GetActorRef().moveto(DragonsReachWayMarker)
SLV_Belethor.GetActorRef().moveto(DragonsReachWayMarker)

SLV_You.getActorRef().moveto(Game.GetPlayer())

SendModEvent("dhlp-Suspend")

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
PunishScene.Start()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
;DEVIOUS DEVICES PROPERTIES
ReferenceAlias Property SLV_SlaverCertificate Auto
SlV_MCMMenu Property ThisMenu auto
Scene Property PunishScene  Auto  
SLV_Utilities Property myScripts auto

ReferenceAlias Property SLV_JarlWhiterun Auto 
ReferenceAlias Property SLV_Zaid Auto 
ReferenceAlias Property SLV_Brutus Auto 
ReferenceAlias Property SLV_Belethor Auto 
ReferenceAlias Property SLV_Ivana Auto 

ObjectReference Property DragonsreachWayMarker Auto
Package Property WalkDragonsreachCenter Auto
ReferenceAlias Property SLV_You Auto
