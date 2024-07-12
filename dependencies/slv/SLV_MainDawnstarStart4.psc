;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainDawnstarStart4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Igor.enable()

if GetOwningQuest().getStage() == 3300
	GetOwningQuest().SetObjectiveCompleted(3300)
	GetOwningQuest().SetStage(3350)
endif

if SLV_SexTraining4Quest.getStage() == 9800
	SLV_SexTraining4Quest.SetObjectiveCompleted(9800)
	SLV_SexTraining4Quest.SetStage(10000)
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
Actor Property Igor Auto

Quest Property SLV_SexTraining4Quest Auto

