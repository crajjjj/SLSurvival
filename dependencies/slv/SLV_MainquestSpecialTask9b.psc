;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecialTask9b Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if GetOwningQuest().getStage() == 7400
	GetOwningQuest().SetObjectiveCompleted(7400)
	GetOwningQuest().SetStage(7450)
endif

SLV_WhiterunSpecialQuest.Reset() 
SLV_WhiterunSpecialQuest.Start() 
SLV_WhiterunSpecialQuest.SetActive(true) 
SLV_WhiterunSpecialQuest.SetStage(0)

myScripts.SLV_IvanaMoodChange(true,1) 

if SLV_SexTraining3.getStage() == 9800
	SLV_SexTraining3.SetObjectiveCompleted(9800)
	SLV_SexTraining3.SetStage(10000)
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Quest Property SLV_WhiterunSpecialQuest Auto
Quest Property SLV_SexTraining3 Auto
