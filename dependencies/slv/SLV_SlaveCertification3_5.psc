;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SlaveCertification3_5 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2000)
GetOwningQuest().SetStage(2500)

if ThisMenu.SkipScenes
	return
endif

ActorUtil.AddPackageOverride(SLV_JarlWhiterun.GetActorRef(), WalkDragonsreachCenter ,100)
SLV_JarlWhiterun.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Bellamy.getactorref())
SLV_Bellamy.getactorref().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Bellamy.GetActorRef(), WalkDragonsreachCenter ,100)
SLV_Bellamy.GetActorRef().evaluatePackage()
ActorUtil.ClearPackageOverride(SLV_Murphy.getactorref())
SLV_Murphy.getactorref().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Murphy.GetActorRef(), WalkDragonsreachCenter ,100)
SLV_Murphy.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Amren.GetActorRef(), WalkDragonsreachCenter ,100)
SLV_Amren.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Nazeem.GetActorRef(), WalkDragonsreachCenter ,100)
SLV_Nazeem.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Pike.GetActorRef(), WalkDragonsreachCenter ,100)
SLV_Pike.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Blake.getactorref())
SLV_Blake.getactorref().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Blake.GetActorRef(), WalkDragonsreachCenter ,100)
SLV_Blake.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Eva.getactorref())
SLV_Eva.getactorref().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Eva.GetActorRef(), WalkDragonsreachCenter ,100)
SLV_Eva.GetActorRef().evaluatePackage()

SLV_JarlWhiterun.GetActorRef().moveto(DragonsReachWayMarker)
SLV_Amren.GetActorRef().moveto(DragonsReachWayMarker)
SLV_Nazeem.GetActorRef().moveto(DragonsReachWayMarker)

SLV_You.getActorRef().moveto(Game.GetPlayer())

SendModEvent("dhlp-Suspend")

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
PunishScene.Start()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SlV_MCMMenu Property ThisMenu auto
Scene Property PunishScene  Auto  
SLV_Utilities Property myScripts auto

ReferenceAlias Property SLV_JarlWhiterun Auto 
ReferenceAlias Property SLV_Pike Auto 
ReferenceAlias Property SLV_Bellamy Auto 
ReferenceAlias Property SLV_Murphy Auto 

ReferenceAlias Property SLV_Amren Auto
ReferenceAlias Property SLV_Nazeem Auto 
ReferenceAlias Property SLV_Blake Auto  
ReferenceAlias Property SLV_Eva Auto 

ObjectReference Property DragonsreachWayMarker Auto
Package Property WalkDragonsreachCenter Auto
ReferenceAlias Property SLV_You Auto
