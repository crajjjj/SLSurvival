;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainFalkreathStart4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if GetOwningQuest().getStage() == 2400
	GetOwningQuest().SetObjectiveCompleted(2400)
	GetOwningQuest().SetStage(2450)
endif

if SLV_SexTraining3.getStage() == 9800
	SLV_SexTraining3.SetObjectiveCompleted(9800)
	SLV_SexTraining3.SetStage(10000)
endif

SLV_SexTraining.Reset() 
SLV_SexTraining.Start() 
SLV_SexTraining.SetActive(true) 
SLV_SexTraining.SetStage(0)

myScripts.SLV_IvanaMoodChange(true,1) 
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Quest Property SLV_SexTraining Auto
Quest Property SLV_SexTraining3 Auto

