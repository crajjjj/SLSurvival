;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiteWedding2_16 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(5000)
GetOwningQuest().SetStage(5500)

if ThisMenu.SkipScenes
	return
endif

ActorUtil.ClearPackageOverride(SLV_Bellamy.getactorref())
SLV_Bellamy.getactorref().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Bellamy.GetActorRef(), WalkDragonsreachCenter ,100)
SLV_Bellamy.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Pike.getactorref())
SLV_Pike.getactorref().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Pike.GetActorRef(), WalkDragonsreachCenter ,100)
SLV_Pike.GetActorRef().evaluatePackage()

myScripts.SLV_PlayScene(PunishScene)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SlV_MCMMenu Property ThisMenu auto
Scene Property PunishScene Auto  
SLV_Utilities Property myScripts auto

ReferenceAlias Property SLV_Pike Auto 
ReferenceAlias Property SLV_Bellamy Auto 

Package Property WalkDragonsreachCenter Auto
