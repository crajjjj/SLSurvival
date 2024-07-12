;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Mainquest11 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(11000)
GetOwningQuest().SetStage(12000)

if SLV_DeadSlaveWalkingQuest.getStage() <= 7500
	SLV_DeadSlaveWalkingQuest.SetObjectiveCompleted(SLV_DeadSlaveWalkingQuest.getStage())
	SLV_DeadSlaveWalkingQuest.setStage(8000)
endif

myScripts.SLV_Play2Sex(Game.GetPlayer(),akSpeaker,"", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto 
Quest Property SLV_DeadSlaveWalkingQuest Auto
