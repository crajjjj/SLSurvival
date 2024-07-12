;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiteWedding2_7 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2500)
GetOwningQuest().SetStage(3000)

ActorUtil.ClearPackageOverride(akSpeaker)
akSpeaker.evaluatePackage()
ActorUtil.AddPackageOverride(akSpeaker, SLV_FollowPlayer ,100)
akSpeaker.evaluatePackage()

if MCMMenu.skipScenes
	myScripts.SLV_enslavementNPC(SLV_Octavia.getActorRef())
	myScripts.SLV_enslavementChains(SLV_Octavia.getActorRef())
	myScripts.SLV_enslavementNPC(SLV_Raven.getActorRef())
	myScripts.SLV_enslavementChains(SLV_Raven.getActorRef())
endif

myScripts.SLV_PlayScene(PunishScene)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Scene Property PunishScene Auto
SLV_Utilities Property myScripts auto
Package Property SLV_FollowPlayer Auto
ReferenceAlias Property SLV_Octavia Auto 
ReferenceAlias Property SLV_Raven Auto 

SLV_MCMMenu Property MCMMenu Auto