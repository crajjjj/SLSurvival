;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainDeadSlaveStart2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(9800)
GetOwningQuest().SetStage(10000)

SLV_DeadSlaveWalkingQuest.Reset() 
SLV_DeadSlaveWalkingQuest.Start() 
SLV_DeadSlaveWalkingQuest.SetActive(true) 
SLV_DeadSlaveWalkingQuest.SetStage(0)

myScripts.SLV_miniLevelUp()
		
headshaving.NextProgressiveSlaveTats(game.getplayer())

SLV_AmputeePlayer.setValue(0)
Amputee.SLV_AmputeeActor(Game.GetPlayer(),0)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
SLV_HeadShaving Property headshaving auto
Quest Property SLV_DeadSlaveWalkingQuest Auto
SLV_Amputee Property Amputee Auto
GlobalVariable Property SLV_AmputeePlayer Auto
