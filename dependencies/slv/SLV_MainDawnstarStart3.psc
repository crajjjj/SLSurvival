;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainDawnstarStart3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Dremora.enable()

if GetOwningQuest().getStage() ==2500
	GetOwningQuest().SetObjectiveCompleted(2500)
	GetOwningQuest().SetStage(2550)
endif

if SLV_SlaveCertification1Quest.getStage() == 9800
	SLV_SlaveCertification1Quest.SetObjectiveCompleted(9800)
	SLV_SlaveCertification1Quest.SetStage(10000)
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
Actor Property Dremora Auto
Quest Property SLV_SlaveCertification1Quest Auto

