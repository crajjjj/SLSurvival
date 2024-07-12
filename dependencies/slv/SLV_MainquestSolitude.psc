;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSolitude Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(11000)
GetOwningQuest().SetStage(12000)

SLV_WhiterunSpecialQuest.Reset() 
SLV_WhiterunSpecialQuest.Start() 
SLV_WhiterunSpecialQuest.SetActive(true) 
SLV_WhiterunSpecialQuest.SetStage(0)

if SLV_DeadSlaveWalkingQuest.getStage() == 6500
	SLV_DeadSlaveWalkingQuest.SetObjectiveCompleted(6500)
	SLV_DeadSlaveWalkingQuest.setStage(7000)
endif

myScripts.SLV_Play2Sex(Game.GetPlayer(),akSpeaker,"", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto 
Quest Property SLV_WhiterunSpecialQuest Auto
Quest Property SLV_DeadSlaveWalkingQuest Auto