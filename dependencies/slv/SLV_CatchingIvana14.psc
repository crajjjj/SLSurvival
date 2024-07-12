;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingIvana14 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_SlaveTrainingQuest.Reset() 
SLV_SlaveTrainingQuest.Start() 
SLV_SlaveTrainingQuest.SetActive(true) 
SLV_SlaveTrainingQuest.SetStage(1500)

Utility.wait(2.0)

;Game.getplayer().additem(SLV_SexSlaveVol02.getReference())

GetOwningQuest().SetObjectiveCompleted(9500)
GetOwningQuest().SetStage(10000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_SlaveTrainingQuest Auto
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_SexSlaveVol02 Auto

