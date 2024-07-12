;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainFalkreathStart3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if GetOwningQuest().getStage() == 2300
	GetOwningQuest().SetObjectiveCompleted(2300)
	GetOwningQuest().SetStage(2350)
endif

if SLV_SexTraining2.getStage() == 9500
	SLV_SexTraining2.SetObjectiveCompleted(9500)
	SLV_SexTraining2.SetStage(10000)
endif

SLV_SexTraining3.Reset() 
SLV_SexTraining3.Start() 
SLV_SexTraining3.SetActive(true) 
SLV_SexTraining3.SetStage(0)

myScripts.SLV_IvanaMoodChange(true,1) 
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Quest Property SLV_SexTraining3 Auto
Quest Property SLV_SexTraining2 Auto

