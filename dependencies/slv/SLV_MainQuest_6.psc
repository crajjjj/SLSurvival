;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainQuest_6 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if GetOwningQuest().getStage() == 4500
	GetOwningQuest().SetObjectiveCompleted(4500)
	GetOwningQuest().SetStage(4550)
endif

SLV_Catching.Reset() 
SLV_Catching.Start() 
SLV_Catching.SetActive(true) 
SLV_Catching.SetStage(0)

SLV_SlaveryEnforcementQuest.SetObjectiveCompleted(6000)
SLV_SlaveryEnforcementQuest.SetStage(6500)

myScripts.SLV_IvanaMoodChange(true,1) 
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Quest Property SLV_SlaveryEnforcementQuest Auto
Quest Property SLV_Catching Auto
