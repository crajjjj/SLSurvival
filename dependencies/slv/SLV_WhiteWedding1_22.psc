;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiteWedding1_22 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(7500)
GetOwningQuest().SetStage(8000)

ActorUtil.ClearPackageOverride(SLV_Bellamy.getactorref())
SLV_Bellamy.getactorref().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Bellamy.GetActorRef(), WalkDragonsreachCenter ,100)
SLV_Bellamy.GetActorRef().evaluatePackage()
SLV_Bellamy.GetActorRef().moveto(SLV_Pike.getactorref())

ActorUtil.ClearPackageOverride(SLV_Pike.getactorref())
SLV_Pike.getactorref().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Pike.getactorref(), WalkDragonsreachCenter ,100)
SLV_Pike.getactorref().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Marcus.getactorref())
SLV_Marcus.getactorref().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Marcus.GetActorRef(), WalkDragonsreachCenter ,100)
SLV_Marcus.GetActorRef().evaluatePackage()

;ActorUtil.ClearPackageOverride(SLV_Abigail.getactorref())
;SLV_Abigail.getactorref().evaluatePackage()
;ActorUtil.AddPackageOverride(SLV_Abigail.GetActorRef(), WalkDragonsreachCenter ,100)
;SLV_Abigail.GetActorRef().evaluatePackage()

myScripts.SLV_PlayScene(PunishScene)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Scene Property PunishScene Auto
SLV_Utilities Property myScripts auto
 
ReferenceAlias Property SLV_Bellamy Auto
ReferenceAlias Property SLV_Pike Auto
ReferenceAlias Property SLV_Marcus Auto  
ReferenceAlias Property SLV_Abigail Auto 

Package Property WalkDragonsreachCenter Auto
