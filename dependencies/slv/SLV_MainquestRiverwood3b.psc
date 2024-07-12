;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestRiverwood3b Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if GetOwningQuest().getStage() ==1600
	GetOwningQuest().SetObjectiveCompleted(1600)
	GetOwningQuest().SetStage(1650)
endif

if SLV_SexTraining1.getStage() == 9800
	SLV_SexTraining1.SetObjectiveCompleted(9800)
	SLV_SexTraining1.SetStage(10000)
endif

SLV_SexTraining2.Reset() 
SLV_SexTraining2.Start() 
SLV_SexTraining2.SetActive(true) 
SLV_SexTraining2.SetStage(0)

myScripts.SLV_IvanaMoodChange(true,1)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Quest Property SLV_SexTraining2 Auto
Quest Property SLV_SexTraining1 Auto


