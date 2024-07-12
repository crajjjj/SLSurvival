;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ColosseumArchitect14 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(6500)
GetOwningQuest().SetStage(7000)

if ThisMenu.SkipScenes || !ThisMenu.StoryMode
	myScripts.SLV_enslavementNPC(SLV_MinerSlave1.getActorRef())
	myScripts.SLV_enslavementChains(SLV_MinerSlave1.getActorRef())

	myScripts.SLV_enslavementNPC(SLV_MinerSlave2.getActorRef())
	myScripts.SLV_enslavementChains(SLV_MinerSlave2.getActorRef())
else
	myScripts.SLV_PlayScene(PunishScene)
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_MinerSlave1 Auto
ReferenceAlias Property SLV_MinerSlave2 Auto
Scene Property PunishScene  Auto
SLV_MCMMenu Property ThisMenu auto

