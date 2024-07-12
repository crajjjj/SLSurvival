;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CelebrateSlavery10 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(4500)
GetOwningQuest().SetStage(5000)

ActorUtil.AddPackageOverride(JarlWhiterun.GetActorRef(), WalkDragonsreachCenter ,100)
JarlWhiterun.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(JarlMorthal.GetActorRef(), WalkDragonsreachCenter ,100)
JarlMorthal.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(Maven.GetActorRef(), WalkDragonsreachCenter ,100)
Maven.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(Zaid.GetActorRef(), WalkDragonsreachCenter ,100)
Zaid.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(JarlWindhelm.GetActorRef(), WalkDragonsreachLeft ,100)
JarlWindhelm.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(JarlMarkarth.GetActorRef(), WalkDragonsreachLeft ,100)
JarlMarkarth.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(JarlFalkreath.GetActorRef(), WalkDragonsreachLeft ,100)
JarlFalkreath.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(Brutus.GetActorRef(), WalkDragonsreachLeft ,100)
Brutus.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(Elisif.GetActorRef(), WalkDragonsreachLeft ,100)
Elisif.GetActorRef().evaluatePackage()

JarlWindhelm.GetActorRef().removeFromFaction(CWSonsFaction)
JarlWindhelm.GetActorRef().removeFromFaction(CWSonsFactionNPC)

JarlMorthal.GetActorRef().moveto(DragonsReachWayMarker)
JarlWindhelm.GetActorRef().moveto(DragonsReachWayMarker)
JarlMarkarth.GetActorRef().moveto(DragonsReachWayMarker)
JarlFalkreath.GetActorRef().moveto(DragonsReachWayMarker)
Maven.GetActorRef().moveto(DragonsReachWayMarker)
Brutus.GetActorRef().moveto(DragonsReachWayMarker)
Elisif.GetActorRef().moveto(DragonsReachWayMarker)

DragonsreachCross2.enable()
myScripts.SLV_enableExecution()

if ThisMenu.SkipScenes
	return
endif
akSpeaker.addItem(Whip)
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
Weapon Property Whip Auto
SLV_Utilities Property myScripts auto

ReferenceAlias Property JarlWhiterun Auto 
ReferenceAlias Property JarlMarkarth Auto 
ReferenceAlias Property JarlMorthal Auto 
ReferenceAlias Property JarlWindhelm Auto 
ReferenceAlias Property JarlFalkreath Auto 

ReferenceAlias Property Zaid Auto 
ReferenceAlias Property Brutus Auto 
ReferenceAlias Property Maven Auto 
ReferenceAlias Property Elisif Auto 

ObjectReference Property DragonsreachWayMarker Auto
ObjectReference Property DragonsreachCross2 Auto
Package Property WalkDragonsreachCenter Auto
Package Property WalkDragonsreachLeft Auto

Faction Property CWSonsFaction Auto
Faction Property CWSonsFactionNPC Auto