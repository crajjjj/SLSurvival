;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSexTraining1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if GetOwningQuest().getStage() == 1400
	GetOwningQuest().SetObjectiveCompleted(1400)
	GetOwningQuest().SetStage(1450)
endif

if SLV_SexTraining2.getStage() == 9800
	SLV_SexTraining2.SetObjectiveCompleted(9800)
	SLV_SexTraining2.SetStage(1000)
endif

SLV_SexTraining.Reset() 
SLV_SexTraining.Start() 
SLV_SexTraining.SetActive(true) 
SLV_SexTraining.SetStage(0)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_SexTraining Auto
Quest Property SLV_SexTraining2 Auto


